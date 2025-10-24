; ModuleID = 'sailfin'
source_filename = "sailfin"

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

%NativeInstruction = type { i32, [48 x i8] }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare double @char_code(i8*)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

@.str.len19.h1782433603 = private unnamed_addr constant [20 x i8] c"sailfin-native-text\00"
@.str.len23.h668778749 = private unnamed_addr constant [24 x i8] c"sailfin-layout-manifest\00"
@.str.len8.h1370870284 = private unnamed_addr constant [9 x i8] c".module \00"
@.str.len8.h575595345 = private unnamed_addr constant [9 x i8] c".import \00"
@.str.len6.h483393773 = private unnamed_addr constant [7 x i8] c"import\00"
@.str.len24.h457168017 = private unnamed_addr constant [25 x i8] c"unable to parse import: \00"
@.str.len8.h1074277327 = private unnamed_addr constant [9 x i8] c".export \00"
@.str.len6.h42978514 = private unnamed_addr constant [7 x i8] c"export\00"
@.str.len24.h1881287894 = private unnamed_addr constant [25 x i8] c"unable to parse export: \00"
@.str.len6.h1830497006 = private unnamed_addr constant [7 x i8] c".span \00"
@.str.len31.h762677253 = private unnamed_addr constant [32 x i8] c"unable to parse span metadata: \00"
@.str.len11.h1513373193 = private unnamed_addr constant [12 x i8] c".init-span \00"
@.str.len43.h1714227133 = private unnamed_addr constant [44 x i8] c"unable to parse initializer span metadata: \00"
@.str.len8.h2093451461 = private unnamed_addr constant [9 x i8] c".struct \00"
@.str.len11.h599952843 = private unnamed_addr constant [12 x i8] c".interface \00"
@.str.len6.h1280947313 = private unnamed_addr constant [7 x i8] c".enum \00"
@.str.len4.h192491117 = private unnamed_addr constant [5 x i8] c".fn \00"
@.str.len57.h1118233133 = private unnamed_addr constant [58 x i8] c"encountered nested .fn while previous function still open\00"
@.str.len4.h278197661 = private unnamed_addr constant [5 x i8] c"void\00"
@.str.len6.h1280331335 = private unnamed_addr constant [7 x i8] c".endfn\00"
@.str.len42.h1518215675 = private unnamed_addr constant [43 x i8] c"encountered .endfn without active function\00"
@.str.len6.h1583308163 = private unnamed_addr constant [7 x i8] c".meta \00"
@.str.len32.h1767333123 = private unnamed_addr constant [33 x i8] c"metadata outside function body: \00"
@.str.len7.h130169768 = private unnamed_addr constant [8 x i8] c".param \00"
@.str.len32.h1189086491 = private unnamed_addr constant [33 x i8] c"unable to parse parameter line: \00"
@.str.len33.h1023685264 = private unnamed_addr constant [34 x i8] c"unable to parse parameter entry: \00"
@.str.len33.h712498791 = private unnamed_addr constant [34 x i8] c"parameter outside function body: \00"
@.str.len29.h1601547567 = private unnamed_addr constant [30 x i8] c"unused span metadata before: \00"
@.str.len41.h35508704 = private unnamed_addr constant [42 x i8] c"unused initializer span metadata before: \00"
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
@.str.len3.h2089318639 = private unnamed_addr constant [4 x i8] c"Let\00"
@.str.len47.h1886628617 = private unnamed_addr constant [48 x i8] c"top-level directive not supported in lowering: \00"
@.str.len40.h1512965366 = private unnamed_addr constant [41 x i8] c"unterminated function at end of artifact\00"
@.str.len7.h655348872 = private unnamed_addr constant [8 x i8] c"return \00"
@.str.len8.h787332764 = private unnamed_addr constant [9 x i8] c"effects \00"
@.str.len0.h177573 = private unnamed_addr constant [1 x i8] c"\00"
@.str.len5.h2080793783 = private unnamed_addr constant [6 x i8] c"eval \00"
@.str.len4.h273104342 = private unnamed_addr constant [5 x i8] c"ret \00"
@.str.len4.h268717223 = private unnamed_addr constant [5 x i8] c"noop\00"
@.str.len4.h192590216 = private unnamed_addr constant [5 x i8] c".if \00"
@.str.len5.h2056075365 = private unnamed_addr constant [6 x i8] c".else\00"
@.str.len6.h1280334338 = private unnamed_addr constant [7 x i8] c".endif\00"
@.str.len5.h2057365731 = private unnamed_addr constant [6 x i8] c".for \00"
@.str.len4.h175996034 = private unnamed_addr constant [5 x i8] c" in \00"
@.str.len7.h1448749422 = private unnamed_addr constant [8 x i8] c".endfor\00"
@.str.len5.h2064480630 = private unnamed_addr constant [6 x i8] c".loop\00"
@.str.len8.h571206424 = private unnamed_addr constant [9 x i8] c".endloop\00"
@.str.len5.h1958778164 = private unnamed_addr constant [6 x i8] c"break\00"
@.str.len8.h528348603 = private unnamed_addr constant [9 x i8] c"continue\00"
@.str.len7.h553171426 = private unnamed_addr constant [8 x i8] c".match \00"
@.str.len6.h1187178968 = private unnamed_addr constant [7 x i8] c".case \00"
@.str.len9.h1692644020 = private unnamed_addr constant [10 x i8] c".endmatch\00"
@.str.len5.h2064124065 = private unnamed_addr constant [6 x i8] c".let \00"
@.str.len7.h725262232 = private unnamed_addr constant [8 x i8] c".return\00"
@.str.len3.h2090684245 = private unnamed_addr constant [4 x i8] c"ret\00"
@.str.len9.h890937508 = private unnamed_addr constant [10 x i8] c"eval let \00"
@.str.len4.h267749729 = private unnamed_addr constant [5 x i8] c"mut \00"
@.str.len2.h193445474 = private unnamed_addr constant [3 x i8] c"=>\00"
@.str.len4.h175987322 = private unnamed_addr constant [5 x i8] c" if \00"
@.str.len4.h175713983 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.len31.h1478667446 = private unnamed_addr constant [32 x i8] c"unable to parse struct header: \00"
@.str.len20.h1216366549 = private unnamed_addr constant [21 x i8] c"unterminated struct \00"
@.str.len10.h2070880298 = private unnamed_addr constant [11 x i8] c".endstruct\00"
@.str.len30.h208276320 = private unnamed_addr constant [31 x i8] c"unterminated method in struct \00"
@.str.len10.h179409731 = private unnamed_addr constant [11 x i8] c".endmethod\00"
@.str.len34.h1211676914 = private unnamed_addr constant [35 x i8] c"unable to parse method parameter: \00"
@.str.len8.h1951948513 = private unnamed_addr constant [9 x i8] c".method \00"
@.str.len36.h736848621 = private unnamed_addr constant [37 x i8] c"nested method declaration in struct \00"
@.str.len8.h1616485352 = private unnamed_addr constant [9 x i8] c".layout \00"
@.str.len7.h289982314 = private unnamed_addr constant [8 x i8] c"struct \00"
@.str.len34.h654371835 = private unnamed_addr constant [35 x i8] c"duplicate struct layout header in \00"
@.str.len6.h734244628 = private unnamed_addr constant [7 x i8] c"field \00"
@.str.len46.h1830585629 = private unnamed_addr constant [47 x i8] c" layout field encountered before layout header\00"
@.str.len37.h1152036459 = private unnamed_addr constant [38 x i8] c"unsupported struct layout directive: \00"
@.str.len7.h398443637 = private unnamed_addr constant [8 x i8] c".field \00"
@.str.len30.h702899578 = private unnamed_addr constant [31 x i8] c"unable to parse struct field: \00"
@.str.len30.h211710404 = private unnamed_addr constant [31 x i8] c"unsupported struct directive: \00"
@.str.len34.h805939531 = private unnamed_addr constant [35 x i8] c"unable to parse interface header: \00"
@.str.len23.h1564009733 = private unnamed_addr constant [24 x i8] c"unterminated interface \00"
@.str.len13.h1382830532 = private unnamed_addr constant [14 x i8] c".endinterface\00"
@.str.len5.h2072555103 = private unnamed_addr constant [6 x i8] c".sig \00"
@.str.len33.h1134984829 = private unnamed_addr constant [34 x i8] c"unsupported interface directive: \00"
@.str.len11.h908744813 = private unnamed_addr constant [12 x i8] c"implements \00"
@.str.len31.h1868156648 = private unnamed_addr constant [32 x i8] c" header missing implements list\00"
@.str.len33.h1132321576 = private unnamed_addr constant [34 x i8] c" header has unsupported segment `\00"
@.str.len10.h385719500 = private unnamed_addr constant [11 x i8] c"interface \00"
@.str.len26.h1834305347 = private unnamed_addr constant [27 x i8] c" signature missing content\00"
@.str.len6.h1134498859 = private unnamed_addr constant [7 x i8] c"async \00"
@.str.len35.h546841458 = private unnamed_addr constant [36 x i8] c" signature missing parameter list: \00"
@.str.len44.h1730891783 = private unnamed_addr constant [45 x i8] c" signature has unterminated parameter list: \00"
@.str.len12.h841153022 = private unnamed_addr constant [13 x i8] c" signature `\00"
@.str.len27.h237652301 = private unnamed_addr constant [28 x i8] c"` has unsupported segment `\00"
@.str.len14.h1219450488 = private unnamed_addr constant [15 x i8] c"` missing name\00"
@.str.len25.h378946335 = private unnamed_addr constant [26 x i8] c"` has invalid parameter `\00"
@.str.len2.h193415939 = private unnamed_addr constant [3 x i8] c"![\00"
@.str.len2.h193428050 = private unnamed_addr constant [3 x i8] c"->\00"
@.str.len26.h1606904140 = private unnamed_addr constant [27 x i8] c"` has unsupported suffix `\00"
@.str.len34.h1377481172 = private unnamed_addr constant [35 x i8] c"` has invalid effects annotation `\00"
@.str.len8.h487238491 = private unnamed_addr constant [9 x i8] c"header `\00"
@.str.len21.h1187531435 = private unnamed_addr constant [22 x i8] c"` missing closing `>`\00"
@.str.len29.h668562564 = private unnamed_addr constant [30 x i8] c"unable to parse enum header: \00"
@.str.len18.h1997941781 = private unnamed_addr constant [19 x i8] c"unterminated enum \00"
@.str.len5.h2072026244 = private unnamed_addr constant [6 x i8] c"enum \00"
@.str.len32.h1822658020 = private unnamed_addr constant [33 x i8] c"duplicate enum layout header in \00"
@.str.len8.h1926252274 = private unnamed_addr constant [9 x i8] c"variant \00"
@.str.len31.h1924917952 = private unnamed_addr constant [32 x i8] c"duplicate enum layout variant `\00"
@.str.len5.h1783417286 = private unnamed_addr constant [6 x i8] c"` in \00"
@.str.len48.h235936117 = private unnamed_addr constant [49 x i8] c" layout variant encountered before layout header\00"
@.str.len8.h1521657554 = private unnamed_addr constant [9 x i8] c"payload \00"
@.str.len44.h1623843 = private unnamed_addr constant [45 x i8] c" layout payload references unknown variant `\00"
@.str.len48.h807033739 = private unnamed_addr constant [49 x i8] c" layout payload encountered before layout header\00"
@.str.len35.h2058816325 = private unnamed_addr constant [36 x i8] c"unsupported enum layout directive: \00"
@.str.len8.h562875475 = private unnamed_addr constant [9 x i8] c".endenum\00"
@.str.len9.h1311191977 = private unnamed_addr constant [10 x i8] c".variant \00"
@.str.len30.h829706524 = private unnamed_addr constant [31 x i8] c"unable to parse enum variant: \00"
@.str.len28.h1471254674 = private unnamed_addr constant [29 x i8] c"unsupported enum directive: \00"
@.str.len36.h414094739 = private unnamed_addr constant [37 x i8] c"struct layout header missing entries\00"
@.str.len5.h261048910 = private unnamed_addr constant [6 x i8] c"name=\00"
@.str.len5.h466680424 = private unnamed_addr constant [6 x i8] c"size=\00"
@.str.len39.h943297157 = private unnamed_addr constant [40 x i8] c"struct layout header has invalid size `\00"
@.str.len6.h841337749 = private unnamed_addr constant [7 x i8] c"align=\00"
@.str.len40.h1650449248 = private unnamed_addr constant [41 x i8] c"struct layout header has invalid align `\00"
@.str.len41.h1415177535 = private unnamed_addr constant [42 x i8] c"struct layout header unrecognized token `\00"
@.str.len39.h1399971520 = private unnamed_addr constant [40 x i8] c"struct layout header missing size entry\00"
@.str.len40.h318366654 = private unnamed_addr constant [41 x i8] c"struct layout header missing align entry\00"
@.str.len29.h128952257 = private unnamed_addr constant [30 x i8] c" layout field missing content\00"
@.str.len29.h555082439 = private unnamed_addr constant [30 x i8] c" layout field missing entries\00"
@.str.len26.h130324785 = private unnamed_addr constant [27 x i8] c" layout field missing name\00"
@.str.len5.h524431183 = private unnamed_addr constant [6 x i8] c"type=\00"
@.str.len7.h242296049 = private unnamed_addr constant [8 x i8] c"offset=\00"
@.str.len15.h506269955 = private unnamed_addr constant [16 x i8] c" layout field `\00"
@.str.len22.h24304067 = private unnamed_addr constant [23 x i8] c"` has invalid offset `\00"
@.str.len20.h151690315 = private unnamed_addr constant [21 x i8] c"` has invalid size `\00"
@.str.len21.h1297227834 = private unnamed_addr constant [22 x i8] c"` has invalid align `\00"
@.str.len22.h496289716 = private unnamed_addr constant [23 x i8] c"` unrecognized token `\00"
@.str.len20.h1568429285 = private unnamed_addr constant [21 x i8] c"` missing type entry\00"
@.str.len22.h625556084 = private unnamed_addr constant [23 x i8] c"` missing offset entry\00"
@.str.len20.h608364678 = private unnamed_addr constant [21 x i8] c"` missing size entry\00"
@.str.len21.h2112628887 = private unnamed_addr constant [22 x i8] c"` missing align entry\00"
@.str.len34.h183092327 = private unnamed_addr constant [35 x i8] c"enum layout header missing entries\00"
@.str.len37.h1581468287 = private unnamed_addr constant [38 x i8] c"enum layout header has invalid size `\00"
@.str.len38.h1235260132 = private unnamed_addr constant [39 x i8] c"enum layout header has invalid align `\00"
@.str.len9.h1228988541 = private unnamed_addr constant [10 x i8] c"tag_type=\00"
@.str.len9.h1171237782 = private unnamed_addr constant [10 x i8] c"tag_size=\00"
@.str.len41.h1384306956 = private unnamed_addr constant [42 x i8] c"enum layout header has invalid tag_size `\00"
@.str.len10.h469410318 = private unnamed_addr constant [11 x i8] c"tag_align=\00"
@.str.len42.h1171387022 = private unnamed_addr constant [43 x i8] c"enum layout header has invalid tag_align `\00"
@.str.len39.h598838653 = private unnamed_addr constant [40 x i8] c"enum layout header unrecognized token `\00"
@.str.len37.h2038142650 = private unnamed_addr constant [38 x i8] c"enum layout header missing size entry\00"
@.str.len38.h2050661185 = private unnamed_addr constant [39 x i8] c"enum layout header missing align entry\00"
@.str.len41.h881857818 = private unnamed_addr constant [42 x i8] c"enum layout header missing tag_type entry\00"
@.str.len41.h2069276858 = private unnamed_addr constant [42 x i8] c"enum layout header missing tag_size entry\00"
@.str.len42.h930606274 = private unnamed_addr constant [43 x i8] c"enum layout header missing tag_align entry\00"
@.str.len31.h1960327680 = private unnamed_addr constant [32 x i8] c" layout variant missing content\00"
@.str.len31.h238974215 = private unnamed_addr constant [32 x i8] c" layout variant missing entries\00"
@.str.len28.h1605654048 = private unnamed_addr constant [29 x i8] c" layout variant missing name\00"
@.str.len4.h275319236 = private unnamed_addr constant [5 x i8] c"tag=\00"
@.str.len17.h293109504 = private unnamed_addr constant [18 x i8] c" layout variant `\00"
@.str.len19.h879467198 = private unnamed_addr constant [20 x i8] c"` has invalid tag `\00"
@.str.len19.h1697653870 = private unnamed_addr constant [20 x i8] c"` missing tag entry\00"
@.str.len31.h329133056 = private unnamed_addr constant [32 x i8] c" layout payload missing content\00"
@.str.len31.h755263238 = private unnamed_addr constant [32 x i8] c" layout payload missing entries\00"
@.str.len28.h497146076 = private unnamed_addr constant [29 x i8] c" layout payload identifier `\00"
@.str.len9.h1123073249 = private unnamed_addr constant [10 x i8] c"` invalid\00"
@.str.len17.h1973869273 = private unnamed_addr constant [18 x i8] c" layout payload `\00"
@.str.len4.h268715771 = private unnamed_addr constant [5 x i8] c"none\00"
@.str.len10.h1219235236 = private unnamed_addr constant [11 x i8] c".manifest \00"
@.str.len15.h87749209 = private unnamed_addr constant [16 x i8] c".layout struct \00"
@.str.len14.h1053492670 = private unnamed_addr constant [15 x i8] c".layout field \00"
@.str.len13.h259593098 = private unnamed_addr constant [14 x i8] c".layout enum \00"
@.str.len16.h1695010494 = private unnamed_addr constant [17 x i8] c".layout variant \00"
@.str.len16.h1290415774 = private unnamed_addr constant [17 x i8] c".layout payload \00"

define %NativeArtifact* @select_text_artifact({ %NativeArtifact*, i64 }* %artifacts) {
entry:
  %l0 = alloca double
  %l1 = alloca %NativeArtifact
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t28 = phi double [ %t1, %entry ], [ %t27, %loop.latch2 ]
  store double %t28, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load { %NativeArtifact*, i64 }, { %NativeArtifact*, i64 }* %artifacts
  %t4 = extractvalue { %NativeArtifact*, i64 } %t3, 1
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t2, %t5
  %t7 = load double, double* %l0
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l0
  %t9 = fptosi double %t8 to i64
  %t10 = load { %NativeArtifact*, i64 }, { %NativeArtifact*, i64 }* %artifacts
  %t11 = extractvalue { %NativeArtifact*, i64 } %t10, 0
  %t12 = extractvalue { %NativeArtifact*, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t9, i64 %t12)
  %t14 = getelementptr %NativeArtifact, %NativeArtifact* %t11, i64 %t9
  %t15 = load %NativeArtifact, %NativeArtifact* %t14
  store %NativeArtifact %t15, %NativeArtifact* %l1
  %t16 = load %NativeArtifact, %NativeArtifact* %l1
  %t17 = extractvalue %NativeArtifact %t16, 1
  %s18 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1782433603, i32 0, i32 0
  %t19 = icmp eq i8* %t17, %s18
  %t20 = load double, double* %l0
  %t21 = load %NativeArtifact, %NativeArtifact* %l1
  br i1 %t19, label %then6, label %merge7
then6:
  %t22 = load %NativeArtifact, %NativeArtifact* %l1
  %t23 = alloca %NativeArtifact
  store %NativeArtifact %t22, %NativeArtifact* %t23
  ret %NativeArtifact* %t23
merge7:
  %t24 = load double, double* %l0
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l0
  br label %loop.latch2
loop.latch2:
  %t27 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t29 = load double, double* %l0
  %t30 = bitcast i8* null to %NativeArtifact*
  ret %NativeArtifact* %t30
}

define %NativeArtifact* @select_layout_manifest_artifact({ %NativeArtifact*, i64 }* %artifacts) {
entry:
  %l0 = alloca double
  %l1 = alloca %NativeArtifact
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t28 = phi double [ %t1, %entry ], [ %t27, %loop.latch2 ]
  store double %t28, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load { %NativeArtifact*, i64 }, { %NativeArtifact*, i64 }* %artifacts
  %t4 = extractvalue { %NativeArtifact*, i64 } %t3, 1
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t2, %t5
  %t7 = load double, double* %l0
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l0
  %t9 = fptosi double %t8 to i64
  %t10 = load { %NativeArtifact*, i64 }, { %NativeArtifact*, i64 }* %artifacts
  %t11 = extractvalue { %NativeArtifact*, i64 } %t10, 0
  %t12 = extractvalue { %NativeArtifact*, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t9, i64 %t12)
  %t14 = getelementptr %NativeArtifact, %NativeArtifact* %t11, i64 %t9
  %t15 = load %NativeArtifact, %NativeArtifact* %t14
  store %NativeArtifact %t15, %NativeArtifact* %l1
  %t16 = load %NativeArtifact, %NativeArtifact* %l1
  %t17 = extractvalue %NativeArtifact %t16, 1
  %s18 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.len23.h668778749, i32 0, i32 0
  %t19 = icmp eq i8* %t17, %s18
  %t20 = load double, double* %l0
  %t21 = load %NativeArtifact, %NativeArtifact* %l1
  br i1 %t19, label %then6, label %merge7
then6:
  %t22 = load %NativeArtifact, %NativeArtifact* %l1
  %t23 = alloca %NativeArtifact
  store %NativeArtifact %t22, %NativeArtifact* %t23
  ret %NativeArtifact* %t23
merge7:
  %t24 = load double, double* %l0
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l0
  br label %loop.latch2
loop.latch2:
  %t27 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t29 = load double, double* %l0
  %t30 = bitcast i8* null to %NativeArtifact*
  ret %NativeArtifact* %t30
}

define %ParseNativeResult @parse_native_artifact(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { %NativeFunction*, i64 }*
  %l3 = alloca { %NativeImport*, i64 }*
  %l4 = alloca { %NativeStruct*, i64 }*
  %l5 = alloca { %NativeInterface*, i64 }*
  %l6 = alloca { %NativeEnum*, i64 }*
  %l7 = alloca { %NativeBinding*, i64 }*
  %l8 = alloca %NativeFunction*
  %l9 = alloca %NativeSourceSpan*
  %l10 = alloca %NativeSourceSpan*
  %l11 = alloca double
  %l12 = alloca i8*
  %l13 = alloca i8*
  %l14 = alloca %NativeImport*
  %l15 = alloca %NativeImport*
  %l16 = alloca %NativeSourceSpan*
  %l17 = alloca %NativeSourceSpan*
  %l18 = alloca %StructParseResult
  %l19 = alloca %InterfaceParseResult
  %l20 = alloca %EnumParseResult
  %l21 = alloca i8*
  %l22 = alloca double
  %l23 = alloca i8*
  %l24 = alloca i8*
  %l25 = alloca { i8**, i64 }*
  %l26 = alloca double
  %l27 = alloca i1
  %l28 = alloca i8*
  %l29 = alloca %NativeSourceSpan*
  %l30 = alloca %NativeParameter*
  %l31 = alloca %InstructionGatherResult
  %l32 = alloca %InstructionParseResult
  %l33 = alloca { %NativeInstruction**, i64 }*
  %l34 = alloca double
  %t0 = call { i8**, i64 }* @split_lines(i8* %text)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %t1 = alloca [0 x i8*]
  %t2 = getelementptr [0 x i8*], [0 x i8*]* %t1, i32 0, i32 0
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t2, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %t6 = alloca [0 x %NativeFunction]
  %t7 = getelementptr [0 x %NativeFunction], [0 x %NativeFunction]* %t6, i32 0, i32 0
  %t8 = alloca { %NativeFunction*, i64 }
  %t9 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t8, i32 0, i32 0
  store %NativeFunction* %t7, %NativeFunction** %t9
  %t10 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
  store { %NativeFunction*, i64 }* %t8, { %NativeFunction*, i64 }** %l2
  %t11 = alloca [0 x %NativeImport]
  %t12 = getelementptr [0 x %NativeImport], [0 x %NativeImport]* %t11, i32 0, i32 0
  %t13 = alloca { %NativeImport*, i64 }
  %t14 = getelementptr { %NativeImport*, i64 }, { %NativeImport*, i64 }* %t13, i32 0, i32 0
  store %NativeImport* %t12, %NativeImport** %t14
  %t15 = getelementptr { %NativeImport*, i64 }, { %NativeImport*, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { %NativeImport*, i64 }* %t13, { %NativeImport*, i64 }** %l3
  %t16 = alloca [0 x %NativeStruct]
  %t17 = getelementptr [0 x %NativeStruct], [0 x %NativeStruct]* %t16, i32 0, i32 0
  %t18 = alloca { %NativeStruct*, i64 }
  %t19 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t18, i32 0, i32 0
  store %NativeStruct* %t17, %NativeStruct** %t19
  %t20 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t18, i32 0, i32 1
  store i64 0, i64* %t20
  store { %NativeStruct*, i64 }* %t18, { %NativeStruct*, i64 }** %l4
  %t21 = alloca [0 x %NativeInterface]
  %t22 = getelementptr [0 x %NativeInterface], [0 x %NativeInterface]* %t21, i32 0, i32 0
  %t23 = alloca { %NativeInterface*, i64 }
  %t24 = getelementptr { %NativeInterface*, i64 }, { %NativeInterface*, i64 }* %t23, i32 0, i32 0
  store %NativeInterface* %t22, %NativeInterface** %t24
  %t25 = getelementptr { %NativeInterface*, i64 }, { %NativeInterface*, i64 }* %t23, i32 0, i32 1
  store i64 0, i64* %t25
  store { %NativeInterface*, i64 }* %t23, { %NativeInterface*, i64 }** %l5
  %t26 = alloca [0 x %NativeEnum]
  %t27 = getelementptr [0 x %NativeEnum], [0 x %NativeEnum]* %t26, i32 0, i32 0
  %t28 = alloca { %NativeEnum*, i64 }
  %t29 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t28, i32 0, i32 0
  store %NativeEnum* %t27, %NativeEnum** %t29
  %t30 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t28, i32 0, i32 1
  store i64 0, i64* %t30
  store { %NativeEnum*, i64 }* %t28, { %NativeEnum*, i64 }** %l6
  %t31 = alloca [0 x %NativeBinding]
  %t32 = getelementptr [0 x %NativeBinding], [0 x %NativeBinding]* %t31, i32 0, i32 0
  %t33 = alloca { %NativeBinding*, i64 }
  %t34 = getelementptr { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %t33, i32 0, i32 0
  store %NativeBinding* %t32, %NativeBinding** %t34
  %t35 = getelementptr { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %t33, i32 0, i32 1
  store i64 0, i64* %t35
  store { %NativeBinding*, i64 }* %t33, { %NativeBinding*, i64 }** %l7
  %t36 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t36, %NativeFunction** %l8
  %t37 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t37, %NativeSourceSpan** %l9
  %t38 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t38, %NativeSourceSpan** %l10
  %t39 = sitofp i64 0 to double
  store double %t39, double* %l11
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t42 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t43 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t44 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t45 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t46 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t47 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t48 = load %NativeFunction*, %NativeFunction** %l8
  %t49 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t50 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t51 = load double, double* %l11
  br label %loop.header0
loop.header0:
  %t1408 = phi double [ %t51, %entry ], [ %t1397, %loop.latch2 ]
  %t1409 = phi { i8**, i64 }* [ %t41, %entry ], [ %t1398, %loop.latch2 ]
  %t1410 = phi { %NativeImport*, i64 }* [ %t43, %entry ], [ %t1399, %loop.latch2 ]
  %t1411 = phi %NativeSourceSpan* [ %t49, %entry ], [ %t1400, %loop.latch2 ]
  %t1412 = phi %NativeSourceSpan* [ %t50, %entry ], [ %t1401, %loop.latch2 ]
  %t1413 = phi { %NativeStruct*, i64 }* [ %t44, %entry ], [ %t1402, %loop.latch2 ]
  %t1414 = phi { %NativeInterface*, i64 }* [ %t45, %entry ], [ %t1403, %loop.latch2 ]
  %t1415 = phi { %NativeEnum*, i64 }* [ %t46, %entry ], [ %t1404, %loop.latch2 ]
  %t1416 = phi %NativeFunction* [ %t48, %entry ], [ %t1405, %loop.latch2 ]
  %t1417 = phi { %NativeFunction*, i64 }* [ %t42, %entry ], [ %t1406, %loop.latch2 ]
  %t1418 = phi { %NativeBinding*, i64 }* [ %t47, %entry ], [ %t1407, %loop.latch2 ]
  store double %t1408, double* %l11
  store { i8**, i64 }* %t1409, { i8**, i64 }** %l1
  store { %NativeImport*, i64 }* %t1410, { %NativeImport*, i64 }** %l3
  store %NativeSourceSpan* %t1411, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t1412, %NativeSourceSpan** %l10
  store { %NativeStruct*, i64 }* %t1413, { %NativeStruct*, i64 }** %l4
  store { %NativeInterface*, i64 }* %t1414, { %NativeInterface*, i64 }** %l5
  store { %NativeEnum*, i64 }* %t1415, { %NativeEnum*, i64 }** %l6
  store %NativeFunction* %t1416, %NativeFunction** %l8
  store { %NativeFunction*, i64 }* %t1417, { %NativeFunction*, i64 }** %l2
  store { %NativeBinding*, i64 }* %t1418, { %NativeBinding*, i64 }** %l7
  br label %loop.body1
loop.body1:
  %t52 = load double, double* %l11
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load { i8**, i64 }, { i8**, i64 }* %t53
  %t55 = extractvalue { i8**, i64 } %t54, 1
  %t56 = sitofp i64 %t55 to double
  %t57 = fcmp oge double %t52, %t56
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t60 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t61 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t62 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t63 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t64 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t65 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t66 = load %NativeFunction*, %NativeFunction** %l8
  %t67 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t68 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t69 = load double, double* %l11
  br i1 %t57, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load double, double* %l11
  %t72 = fptosi double %t71 to i64
  %t73 = load { i8**, i64 }, { i8**, i64 }* %t70
  %t74 = extractvalue { i8**, i64 } %t73, 0
  %t75 = extractvalue { i8**, i64 } %t73, 1
  %t76 = icmp uge i64 %t72, %t75
  ; bounds check: %t76 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t72, i64 %t75)
  %t77 = getelementptr i8*, i8** %t74, i64 %t72
  %t78 = load i8*, i8** %t77
  store i8* %t78, i8** %l12
  %t79 = load i8*, i8** %l12
  %t80 = call i8* @trim_text(i8* %t79)
  store i8* %t80, i8** %l13
  %t81 = load i8*, i8** %l13
  %t82 = call i64 @sailfin_runtime_string_length(i8* %t81)
  %t83 = icmp eq i64 %t82, 0
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t86 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t87 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t88 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t89 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t90 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t91 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t92 = load %NativeFunction*, %NativeFunction** %l8
  %t93 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t94 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t95 = load double, double* %l11
  %t96 = load i8*, i8** %l12
  %t97 = load i8*, i8** %l13
  br i1 %t83, label %then6, label %merge7
then6:
  %t98 = load double, double* %l11
  %t99 = sitofp i64 1 to double
  %t100 = fadd double %t98, %t99
  store double %t100, double* %l11
  br label %loop.latch2
merge7:
  %t101 = load i8*, i8** %l13
  %t102 = alloca [2 x i8], align 1
  %t103 = getelementptr [2 x i8], [2 x i8]* %t102, i32 0, i32 0
  store i8 59, i8* %t103
  %t104 = getelementptr [2 x i8], [2 x i8]* %t102, i32 0, i32 1
  store i8 0, i8* %t104
  %t105 = getelementptr [2 x i8], [2 x i8]* %t102, i32 0, i32 0
  %t106 = call i1 @starts_with(i8* %t101, i8* %t105)
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t109 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t110 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t111 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t112 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t113 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t114 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t115 = load %NativeFunction*, %NativeFunction** %l8
  %t116 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t117 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t118 = load double, double* %l11
  %t119 = load i8*, i8** %l12
  %t120 = load i8*, i8** %l13
  br i1 %t106, label %then8, label %merge9
then8:
  %t121 = load double, double* %l11
  %t122 = sitofp i64 1 to double
  %t123 = fadd double %t121, %t122
  store double %t123, double* %l11
  br label %loop.latch2
merge9:
  %t124 = load i8*, i8** %l13
  %s125 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1370870284, i32 0, i32 0
  %t126 = call i1 @starts_with(i8* %t124, i8* %s125)
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t129 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t130 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t131 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t132 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t133 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t134 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t135 = load %NativeFunction*, %NativeFunction** %l8
  %t136 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t137 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t138 = load double, double* %l11
  %t139 = load i8*, i8** %l12
  %t140 = load i8*, i8** %l13
  br i1 %t126, label %then10, label %merge11
then10:
  %t141 = load double, double* %l11
  %t142 = sitofp i64 1 to double
  %t143 = fadd double %t141, %t142
  store double %t143, double* %l11
  br label %loop.latch2
merge11:
  %t144 = load i8*, i8** %l13
  %s145 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h575595345, i32 0, i32 0
  %t146 = call i1 @starts_with(i8* %t144, i8* %s145)
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t149 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t150 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t151 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t152 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t153 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t154 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t155 = load %NativeFunction*, %NativeFunction** %l8
  %t156 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t157 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t158 = load double, double* %l11
  %t159 = load i8*, i8** %l12
  %t160 = load i8*, i8** %l13
  br i1 %t146, label %then12, label %merge13
then12:
  %s161 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h483393773, i32 0, i32 0
  %t162 = load i8*, i8** %l13
  %s163 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h575595345, i32 0, i32 0
  %t164 = call i8* @strip_prefix(i8* %t162, i8* %s163)
  %t165 = call %NativeImport* @parse_import_entry(i8* %s161, i8* %t164)
  store %NativeImport* %t165, %NativeImport** %l14
  %t166 = load %NativeImport*, %NativeImport** %l14
  %t167 = icmp eq %NativeImport* %t166, null
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t170 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t171 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t172 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t173 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t174 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t175 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t176 = load %NativeFunction*, %NativeFunction** %l8
  %t177 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t178 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t179 = load double, double* %l11
  %t180 = load i8*, i8** %l12
  %t181 = load i8*, i8** %l13
  %t182 = load %NativeImport*, %NativeImport** %l14
  br i1 %t167, label %then14, label %else15
then14:
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s184 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.len24.h457168017, i32 0, i32 0
  %t185 = load i8*, i8** %l13
  %t186 = call i8* @sailfin_runtime_string_concat(i8* %s184, i8* %t185)
  %t187 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t183, i8* %t186)
  store { i8**, i64 }* %t187, { i8**, i64 }** %l1
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge16
else15:
  %t189 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t190 = load %NativeImport*, %NativeImport** %l14
  %t191 = load %NativeImport, %NativeImport* %t190
  %t192 = call { %NativeImport*, i64 }* @append_import({ %NativeImport*, i64 }* %t189, %NativeImport %t191)
  store { %NativeImport*, i64 }* %t192, { %NativeImport*, i64 }** %l3
  %t193 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  br label %merge16
merge16:
  %t194 = phi { i8**, i64 }* [ %t188, %then14 ], [ %t169, %else15 ]
  %t195 = phi { %NativeImport*, i64 }* [ %t171, %then14 ], [ %t193, %else15 ]
  store { i8**, i64 }* %t194, { i8**, i64 }** %l1
  store { %NativeImport*, i64 }* %t195, { %NativeImport*, i64 }** %l3
  %t196 = load double, double* %l11
  %t197 = sitofp i64 1 to double
  %t198 = fadd double %t196, %t197
  store double %t198, double* %l11
  br label %loop.latch2
merge13:
  %t199 = load i8*, i8** %l13
  %s200 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1074277327, i32 0, i32 0
  %t201 = call i1 @starts_with(i8* %t199, i8* %s200)
  %t202 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t204 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t205 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t206 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t207 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t208 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t209 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t210 = load %NativeFunction*, %NativeFunction** %l8
  %t211 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t212 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t213 = load double, double* %l11
  %t214 = load i8*, i8** %l12
  %t215 = load i8*, i8** %l13
  br i1 %t201, label %then17, label %merge18
then17:
  %s216 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h42978514, i32 0, i32 0
  %t217 = load i8*, i8** %l13
  %s218 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1074277327, i32 0, i32 0
  %t219 = call i8* @strip_prefix(i8* %t217, i8* %s218)
  %t220 = call %NativeImport* @parse_import_entry(i8* %s216, i8* %t219)
  store %NativeImport* %t220, %NativeImport** %l15
  %t221 = load %NativeImport*, %NativeImport** %l15
  %t222 = icmp eq %NativeImport* %t221, null
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t225 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t226 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t227 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t228 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t229 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t230 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t231 = load %NativeFunction*, %NativeFunction** %l8
  %t232 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t233 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t234 = load double, double* %l11
  %t235 = load i8*, i8** %l12
  %t236 = load i8*, i8** %l13
  %t237 = load %NativeImport*, %NativeImport** %l15
  br i1 %t222, label %then19, label %else20
then19:
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s239 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.len24.h1881287894, i32 0, i32 0
  %t240 = load i8*, i8** %l13
  %t241 = call i8* @sailfin_runtime_string_concat(i8* %s239, i8* %t240)
  %t242 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t238, i8* %t241)
  store { i8**, i64 }* %t242, { i8**, i64 }** %l1
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge21
else20:
  %t244 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t245 = load %NativeImport*, %NativeImport** %l15
  %t246 = load %NativeImport, %NativeImport* %t245
  %t247 = call { %NativeImport*, i64 }* @append_import({ %NativeImport*, i64 }* %t244, %NativeImport %t246)
  store { %NativeImport*, i64 }* %t247, { %NativeImport*, i64 }** %l3
  %t248 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  br label %merge21
merge21:
  %t249 = phi { i8**, i64 }* [ %t243, %then19 ], [ %t224, %else20 ]
  %t250 = phi { %NativeImport*, i64 }* [ %t226, %then19 ], [ %t248, %else20 ]
  store { i8**, i64 }* %t249, { i8**, i64 }** %l1
  store { %NativeImport*, i64 }* %t250, { %NativeImport*, i64 }** %l3
  %t251 = load double, double* %l11
  %t252 = sitofp i64 1 to double
  %t253 = fadd double %t251, %t252
  store double %t253, double* %l11
  br label %loop.latch2
merge18:
  %t254 = load i8*, i8** %l13
  %s255 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1830497006, i32 0, i32 0
  %t256 = call i1 @starts_with(i8* %t254, i8* %s255)
  %t257 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t259 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t260 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t261 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t262 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t263 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t264 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t265 = load %NativeFunction*, %NativeFunction** %l8
  %t266 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t267 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t268 = load double, double* %l11
  %t269 = load i8*, i8** %l12
  %t270 = load i8*, i8** %l13
  br i1 %t256, label %then22, label %merge23
then22:
  %t271 = load i8*, i8** %l13
  %s272 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1830497006, i32 0, i32 0
  %t273 = call i8* @strip_prefix(i8* %t271, i8* %s272)
  %t274 = call %NativeSourceSpan* @parse_source_span(i8* %t273)
  store %NativeSourceSpan* %t274, %NativeSourceSpan** %l16
  %t275 = load %NativeSourceSpan*, %NativeSourceSpan** %l16
  %t276 = icmp eq %NativeSourceSpan* %t275, null
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t278 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t279 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t280 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t281 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t282 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t283 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t284 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t285 = load %NativeFunction*, %NativeFunction** %l8
  %t286 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t287 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t288 = load double, double* %l11
  %t289 = load i8*, i8** %l12
  %t290 = load i8*, i8** %l13
  %t291 = load %NativeSourceSpan*, %NativeSourceSpan** %l16
  br i1 %t276, label %then24, label %else25
then24:
  %t292 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s293 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h762677253, i32 0, i32 0
  %t294 = load i8*, i8** %l13
  %t295 = call i8* @sailfin_runtime_string_concat(i8* %s293, i8* %t294)
  %t296 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t292, i8* %t295)
  store { i8**, i64 }* %t296, { i8**, i64 }** %l1
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
else25:
  %t298 = load %NativeSourceSpan*, %NativeSourceSpan** %l16
  store %NativeSourceSpan* %t298, %NativeSourceSpan** %l9
  %t299 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge26
merge26:
  %t300 = phi { i8**, i64 }* [ %t297, %then24 ], [ %t278, %else25 ]
  %t301 = phi %NativeSourceSpan* [ %t286, %then24 ], [ %t299, %else25 ]
  store { i8**, i64 }* %t300, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t301, %NativeSourceSpan** %l9
  %t302 = load double, double* %l11
  %t303 = sitofp i64 1 to double
  %t304 = fadd double %t302, %t303
  store double %t304, double* %l11
  br label %loop.latch2
merge23:
  %t305 = load i8*, i8** %l13
  %s306 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1513373193, i32 0, i32 0
  %t307 = call i1 @starts_with(i8* %t305, i8* %s306)
  %t308 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t309 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t310 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t311 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t312 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t313 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t314 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t315 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t316 = load %NativeFunction*, %NativeFunction** %l8
  %t317 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t318 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t319 = load double, double* %l11
  %t320 = load i8*, i8** %l12
  %t321 = load i8*, i8** %l13
  br i1 %t307, label %then27, label %merge28
then27:
  %t322 = load i8*, i8** %l13
  %s323 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1513373193, i32 0, i32 0
  %t324 = call i8* @strip_prefix(i8* %t322, i8* %s323)
  %t325 = call %NativeSourceSpan* @parse_source_span(i8* %t324)
  store %NativeSourceSpan* %t325, %NativeSourceSpan** %l17
  %t326 = load %NativeSourceSpan*, %NativeSourceSpan** %l17
  %t327 = icmp eq %NativeSourceSpan* %t326, null
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t329 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t330 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t331 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t332 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t333 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t334 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t335 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t336 = load %NativeFunction*, %NativeFunction** %l8
  %t337 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t338 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t339 = load double, double* %l11
  %t340 = load i8*, i8** %l12
  %t341 = load i8*, i8** %l13
  %t342 = load %NativeSourceSpan*, %NativeSourceSpan** %l17
  br i1 %t327, label %then29, label %else30
then29:
  %t343 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s344 = getelementptr inbounds [44 x i8], [44 x i8]* @.str.len43.h1714227133, i32 0, i32 0
  %t345 = load i8*, i8** %l13
  %t346 = call i8* @sailfin_runtime_string_concat(i8* %s344, i8* %t345)
  %t347 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t343, i8* %t346)
  store { i8**, i64 }* %t347, { i8**, i64 }** %l1
  %t348 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge31
else30:
  %t349 = load %NativeSourceSpan*, %NativeSourceSpan** %l17
  store %NativeSourceSpan* %t349, %NativeSourceSpan** %l10
  %t350 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge31
merge31:
  %t351 = phi { i8**, i64 }* [ %t348, %then29 ], [ %t329, %else30 ]
  %t352 = phi %NativeSourceSpan* [ %t338, %then29 ], [ %t350, %else30 ]
  store { i8**, i64 }* %t351, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t352, %NativeSourceSpan** %l10
  %t353 = load double, double* %l11
  %t354 = sitofp i64 1 to double
  %t355 = fadd double %t353, %t354
  store double %t355, double* %l11
  br label %loop.latch2
merge28:
  %t356 = load i8*, i8** %l13
  %s357 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h2093451461, i32 0, i32 0
  %t358 = call i1 @starts_with(i8* %t356, i8* %s357)
  %t359 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t360 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t361 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t362 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t363 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t364 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t365 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t366 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t367 = load %NativeFunction*, %NativeFunction** %l8
  %t368 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t369 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t370 = load double, double* %l11
  %t371 = load i8*, i8** %l12
  %t372 = load i8*, i8** %l13
  br i1 %t358, label %then32, label %merge33
then32:
  %t373 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t374 = load double, double* %l11
  %t375 = call %StructParseResult @parse_struct_definition({ i8**, i64 }* %t373, double %t374)
  store %StructParseResult %t375, %StructParseResult* %l18
  %t376 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t377 = load %StructParseResult, %StructParseResult* %l18
  %t378 = extractvalue %StructParseResult %t377, 2
  %t379 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t376, { i8**, i64 }* %t378)
  store { i8**, i64 }* %t379, { i8**, i64 }** %l1
  %t380 = load %StructParseResult, %StructParseResult* %l18
  %t381 = extractvalue %StructParseResult %t380, 0
  %t382 = icmp ne %NativeStruct* %t381, null
  %t383 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t384 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t385 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t386 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t387 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t388 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t389 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t390 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t391 = load %NativeFunction*, %NativeFunction** %l8
  %t392 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t393 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t394 = load double, double* %l11
  %t395 = load i8*, i8** %l12
  %t396 = load i8*, i8** %l13
  %t397 = load %StructParseResult, %StructParseResult* %l18
  br i1 %t382, label %then34, label %merge35
then34:
  %t398 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t399 = load %StructParseResult, %StructParseResult* %l18
  %t400 = extractvalue %StructParseResult %t399, 0
  %t401 = load %NativeStruct, %NativeStruct* %t400
  %t402 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t398, %NativeStruct %t401)
  store { %NativeStruct*, i64 }* %t402, { %NativeStruct*, i64 }** %l4
  %t403 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  br label %merge35
merge35:
  %t404 = phi { %NativeStruct*, i64 }* [ %t403, %then34 ], [ %t387, %then32 ]
  store { %NativeStruct*, i64 }* %t404, { %NativeStruct*, i64 }** %l4
  %t405 = load %StructParseResult, %StructParseResult* %l18
  %t406 = extractvalue %StructParseResult %t405, 1
  store double %t406, double* %l11
  br label %loop.latch2
merge33:
  %t407 = load i8*, i8** %l13
  %s408 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h599952843, i32 0, i32 0
  %t409 = call i1 @starts_with(i8* %t407, i8* %s408)
  %t410 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t411 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t412 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t413 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t414 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t415 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t416 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t417 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t418 = load %NativeFunction*, %NativeFunction** %l8
  %t419 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t420 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t421 = load double, double* %l11
  %t422 = load i8*, i8** %l12
  %t423 = load i8*, i8** %l13
  br i1 %t409, label %then36, label %merge37
then36:
  %t424 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t425 = load double, double* %l11
  %t426 = call %InterfaceParseResult @parse_interface_definition({ i8**, i64 }* %t424, double %t425)
  store %InterfaceParseResult %t426, %InterfaceParseResult* %l19
  %t427 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t428 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t429 = extractvalue %InterfaceParseResult %t428, 2
  %t430 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t427, { i8**, i64 }* %t429)
  store { i8**, i64 }* %t430, { i8**, i64 }** %l1
  %t431 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t432 = extractvalue %InterfaceParseResult %t431, 0
  %t433 = icmp ne %NativeInterface* %t432, null
  %t434 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t435 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t436 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t437 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t438 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t439 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t440 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t441 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t442 = load %NativeFunction*, %NativeFunction** %l8
  %t443 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t444 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t445 = load double, double* %l11
  %t446 = load i8*, i8** %l12
  %t447 = load i8*, i8** %l13
  %t448 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  br i1 %t433, label %then38, label %merge39
then38:
  %t449 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t450 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t451 = extractvalue %InterfaceParseResult %t450, 0
  %t452 = load %NativeInterface, %NativeInterface* %t451
  %t453 = call { %NativeInterface*, i64 }* @append_interface({ %NativeInterface*, i64 }* %t449, %NativeInterface %t452)
  store { %NativeInterface*, i64 }* %t453, { %NativeInterface*, i64 }** %l5
  %t454 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  br label %merge39
merge39:
  %t455 = phi { %NativeInterface*, i64 }* [ %t454, %then38 ], [ %t439, %then36 ]
  store { %NativeInterface*, i64 }* %t455, { %NativeInterface*, i64 }** %l5
  %t456 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t457 = extractvalue %InterfaceParseResult %t456, 1
  store double %t457, double* %l11
  br label %loop.latch2
merge37:
  %t458 = load i8*, i8** %l13
  %s459 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1280947313, i32 0, i32 0
  %t460 = call i1 @starts_with(i8* %t458, i8* %s459)
  %t461 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t462 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t463 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t464 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t465 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t466 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t467 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t468 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t469 = load %NativeFunction*, %NativeFunction** %l8
  %t470 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t471 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t472 = load double, double* %l11
  %t473 = load i8*, i8** %l12
  %t474 = load i8*, i8** %l13
  br i1 %t460, label %then40, label %merge41
then40:
  %t475 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t476 = load double, double* %l11
  %t477 = call %EnumParseResult @parse_enum_definition({ i8**, i64 }* %t475, double %t476)
  store %EnumParseResult %t477, %EnumParseResult* %l20
  %t478 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t479 = load %EnumParseResult, %EnumParseResult* %l20
  %t480 = extractvalue %EnumParseResult %t479, 2
  %t481 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t478, { i8**, i64 }* %t480)
  store { i8**, i64 }* %t481, { i8**, i64 }** %l1
  %t482 = load %EnumParseResult, %EnumParseResult* %l20
  %t483 = extractvalue %EnumParseResult %t482, 0
  %t484 = icmp ne %NativeEnum* %t483, null
  %t485 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t486 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t487 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t488 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t489 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t490 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t491 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t492 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t493 = load %NativeFunction*, %NativeFunction** %l8
  %t494 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t495 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t496 = load double, double* %l11
  %t497 = load i8*, i8** %l12
  %t498 = load i8*, i8** %l13
  %t499 = load %EnumParseResult, %EnumParseResult* %l20
  br i1 %t484, label %then42, label %merge43
then42:
  %t500 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t501 = load %EnumParseResult, %EnumParseResult* %l20
  %t502 = extractvalue %EnumParseResult %t501, 0
  %t503 = load %NativeEnum, %NativeEnum* %t502
  %t504 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t500, %NativeEnum %t503)
  store { %NativeEnum*, i64 }* %t504, { %NativeEnum*, i64 }** %l6
  %t505 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  br label %merge43
merge43:
  %t506 = phi { %NativeEnum*, i64 }* [ %t505, %then42 ], [ %t491, %then40 ]
  store { %NativeEnum*, i64 }* %t506, { %NativeEnum*, i64 }** %l6
  %t507 = load %EnumParseResult, %EnumParseResult* %l20
  %t508 = extractvalue %EnumParseResult %t507, 1
  store double %t508, double* %l11
  br label %loop.latch2
merge41:
  %t509 = load i8*, i8** %l13
  %s510 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h192491117, i32 0, i32 0
  %t511 = call i1 @starts_with(i8* %t509, i8* %s510)
  %t512 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t513 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t514 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t515 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t516 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t517 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t518 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t519 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t520 = load %NativeFunction*, %NativeFunction** %l8
  %t521 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t522 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t523 = load double, double* %l11
  %t524 = load i8*, i8** %l12
  %t525 = load i8*, i8** %l13
  br i1 %t511, label %then44, label %merge45
then44:
  %t526 = load %NativeFunction*, %NativeFunction** %l8
  %t527 = icmp ne %NativeFunction* %t526, null
  %t528 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t529 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t530 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t531 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t532 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t533 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t534 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t535 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t536 = load %NativeFunction*, %NativeFunction** %l8
  %t537 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t538 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t539 = load double, double* %l11
  %t540 = load i8*, i8** %l12
  %t541 = load i8*, i8** %l13
  br i1 %t527, label %then46, label %merge47
then46:
  %t542 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s543 = getelementptr inbounds [58 x i8], [58 x i8]* @.str.len57.h1118233133, i32 0, i32 0
  %t544 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t542, i8* %s543)
  store { i8**, i64 }* %t544, { i8**, i64 }** %l1
  %t545 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge47
merge47:
  %t546 = phi { i8**, i64 }* [ %t545, %then46 ], [ %t529, %then44 ]
  store { i8**, i64 }* %t546, { i8**, i64 }** %l1
  %t547 = load i8*, i8** %l13
  %s548 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h192491117, i32 0, i32 0
  %t549 = call i8* @strip_prefix(i8* %t547, i8* %s548)
  %t550 = call i8* @parse_function_name(i8* %t549)
  %t551 = insertvalue %NativeFunction undef, i8* %t550, 0
  %t552 = alloca [0 x %NativeParameter*]
  %t553 = getelementptr [0 x %NativeParameter*], [0 x %NativeParameter*]* %t552, i32 0, i32 0
  %t554 = alloca { %NativeParameter**, i64 }
  %t555 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t554, i32 0, i32 0
  store %NativeParameter** %t553, %NativeParameter*** %t555
  %t556 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t554, i32 0, i32 1
  store i64 0, i64* %t556
  %t557 = insertvalue %NativeFunction %t551, { %NativeParameter**, i64 }* %t554, 1
  %s558 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h278197661, i32 0, i32 0
  %t559 = insertvalue %NativeFunction %t557, i8* %s558, 2
  %t560 = alloca [0 x i8*]
  %t561 = getelementptr [0 x i8*], [0 x i8*]* %t560, i32 0, i32 0
  %t562 = alloca { i8**, i64 }
  %t563 = getelementptr { i8**, i64 }, { i8**, i64 }* %t562, i32 0, i32 0
  store i8** %t561, i8*** %t563
  %t564 = getelementptr { i8**, i64 }, { i8**, i64 }* %t562, i32 0, i32 1
  store i64 0, i64* %t564
  %t565 = insertvalue %NativeFunction %t559, { i8**, i64 }* %t562, 3
  %t566 = alloca [0 x %NativeInstruction*]
  %t567 = getelementptr [0 x %NativeInstruction*], [0 x %NativeInstruction*]* %t566, i32 0, i32 0
  %t568 = alloca { %NativeInstruction**, i64 }
  %t569 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t568, i32 0, i32 0
  store %NativeInstruction** %t567, %NativeInstruction*** %t569
  %t570 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t568, i32 0, i32 1
  store i64 0, i64* %t570
  %t571 = insertvalue %NativeFunction %t565, { %NativeInstruction**, i64 }* %t568, 4
  %t572 = alloca %NativeFunction
  store %NativeFunction %t571, %NativeFunction* %t572
  store %NativeFunction* %t572, %NativeFunction** %l8
  %t573 = load double, double* %l11
  %t574 = sitofp i64 1 to double
  %t575 = fadd double %t573, %t574
  store double %t575, double* %l11
  br label %loop.latch2
merge45:
  %t576 = load i8*, i8** %l13
  %s577 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1280331335, i32 0, i32 0
  %t578 = call i1 @starts_with(i8* %t576, i8* %s577)
  %t579 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t580 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t581 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t582 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t583 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t584 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t585 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t586 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t587 = load %NativeFunction*, %NativeFunction** %l8
  %t588 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t589 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t590 = load double, double* %l11
  %t591 = load i8*, i8** %l12
  %t592 = load i8*, i8** %l13
  br i1 %t578, label %then48, label %merge49
then48:
  %t593 = load %NativeFunction*, %NativeFunction** %l8
  %t594 = icmp eq %NativeFunction* %t593, null
  %t595 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t596 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t597 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t598 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t599 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t600 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t601 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t602 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t603 = load %NativeFunction*, %NativeFunction** %l8
  %t604 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t605 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t606 = load double, double* %l11
  %t607 = load i8*, i8** %l12
  %t608 = load i8*, i8** %l13
  br i1 %t594, label %then50, label %else51
then50:
  %t609 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s610 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.len42.h1518215675, i32 0, i32 0
  %t611 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t609, i8* %s610)
  store { i8**, i64 }* %t611, { i8**, i64 }** %l1
  %t612 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge52
else51:
  %t613 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t614 = load %NativeFunction*, %NativeFunction** %l8
  %t615 = load %NativeFunction, %NativeFunction* %t614
  %t616 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t613, %NativeFunction %t615)
  store { %NativeFunction*, i64 }* %t616, { %NativeFunction*, i64 }** %l2
  %t617 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t617, %NativeFunction** %l8
  %t618 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t619 = load %NativeFunction*, %NativeFunction** %l8
  br label %merge52
merge52:
  %t620 = phi { i8**, i64 }* [ %t612, %then50 ], [ %t596, %else51 ]
  %t621 = phi { %NativeFunction*, i64 }* [ %t597, %then50 ], [ %t618, %else51 ]
  %t622 = phi %NativeFunction* [ %t603, %then50 ], [ %t619, %else51 ]
  store { i8**, i64 }* %t620, { i8**, i64 }** %l1
  store { %NativeFunction*, i64 }* %t621, { %NativeFunction*, i64 }** %l2
  store %NativeFunction* %t622, %NativeFunction** %l8
  %t623 = load double, double* %l11
  %t624 = sitofp i64 1 to double
  %t625 = fadd double %t623, %t624
  store double %t625, double* %l11
  br label %loop.latch2
merge49:
  %t626 = load i8*, i8** %l13
  %s627 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1583308163, i32 0, i32 0
  %t628 = call i1 @starts_with(i8* %t626, i8* %s627)
  %t629 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t630 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t631 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t632 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t633 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t634 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t635 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t636 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t637 = load %NativeFunction*, %NativeFunction** %l8
  %t638 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t639 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t640 = load double, double* %l11
  %t641 = load i8*, i8** %l12
  %t642 = load i8*, i8** %l13
  br i1 %t628, label %then53, label %merge54
then53:
  %t643 = load %NativeFunction*, %NativeFunction** %l8
  %t644 = icmp ne %NativeFunction* %t643, null
  %t645 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t646 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t647 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t648 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t649 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t650 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t651 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t652 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t653 = load %NativeFunction*, %NativeFunction** %l8
  %t654 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t655 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t656 = load double, double* %l11
  %t657 = load i8*, i8** %l12
  %t658 = load i8*, i8** %l13
  br i1 %t644, label %then55, label %else56
then55:
  %t659 = load %NativeFunction*, %NativeFunction** %l8
  %t660 = load i8*, i8** %l13
  %s661 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1583308163, i32 0, i32 0
  %t662 = call i8* @strip_prefix(i8* %t660, i8* %s661)
  %t663 = load %NativeFunction, %NativeFunction* %t659
  %t664 = call %NativeFunction @apply_meta(%NativeFunction %t663, i8* %t662)
  %t665 = alloca %NativeFunction
  store %NativeFunction %t664, %NativeFunction* %t665
  store %NativeFunction* %t665, %NativeFunction** %l8
  %t666 = load %NativeFunction*, %NativeFunction** %l8
  br label %merge57
else56:
  %t667 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s668 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.len32.h1767333123, i32 0, i32 0
  %t669 = load i8*, i8** %l13
  %t670 = call i8* @sailfin_runtime_string_concat(i8* %s668, i8* %t669)
  %t671 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t667, i8* %t670)
  store { i8**, i64 }* %t671, { i8**, i64 }** %l1
  %t672 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge57
merge57:
  %t673 = phi %NativeFunction* [ %t666, %then55 ], [ %t653, %else56 ]
  %t674 = phi { i8**, i64 }* [ %t646, %then55 ], [ %t672, %else56 ]
  store %NativeFunction* %t673, %NativeFunction** %l8
  store { i8**, i64 }* %t674, { i8**, i64 }** %l1
  %t675 = load double, double* %l11
  %t676 = sitofp i64 1 to double
  %t677 = fadd double %t675, %t676
  store double %t677, double* %l11
  br label %loop.latch2
merge54:
  %t678 = load i8*, i8** %l13
  %s679 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h130169768, i32 0, i32 0
  %t680 = call i1 @starts_with(i8* %t678, i8* %s679)
  %t681 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t682 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t683 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t684 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t685 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t686 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t687 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t688 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t689 = load %NativeFunction*, %NativeFunction** %l8
  %t690 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t691 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t692 = load double, double* %l11
  %t693 = load i8*, i8** %l12
  %t694 = load i8*, i8** %l13
  br i1 %t680, label %then58, label %merge59
then58:
  %t695 = load %NativeFunction*, %NativeFunction** %l8
  %t696 = icmp ne %NativeFunction* %t695, null
  %t697 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t698 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t699 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t700 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t701 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t702 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t703 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t704 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t705 = load %NativeFunction*, %NativeFunction** %l8
  %t706 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t707 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t708 = load double, double* %l11
  %t709 = load i8*, i8** %l12
  %t710 = load i8*, i8** %l13
  br i1 %t696, label %then60, label %else61
then60:
  %t711 = load i8*, i8** %l13
  %s712 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h130169768, i32 0, i32 0
  %t713 = call i8* @strip_prefix(i8* %t711, i8* %s712)
  store i8* %t713, i8** %l21
  %t714 = load double, double* %l11
  %t715 = sitofp i64 1 to double
  %t716 = fadd double %t714, %t715
  store double %t716, double* %l22
  %t717 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t718 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t719 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t720 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t721 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t722 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t723 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t724 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t725 = load %NativeFunction*, %NativeFunction** %l8
  %t726 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t727 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t728 = load double, double* %l11
  %t729 = load i8*, i8** %l12
  %t730 = load i8*, i8** %l13
  %t731 = load i8*, i8** %l21
  %t732 = load double, double* %l22
  br label %loop.header63
loop.header63:
  %t846 = phi double [ %t732, %then60 ], [ %t844, %loop.latch65 ]
  %t847 = phi i8* [ %t731, %then60 ], [ %t845, %loop.latch65 ]
  store double %t846, double* %l22
  store i8* %t847, i8** %l21
  br label %loop.body64
loop.body64:
  %t733 = load double, double* %l22
  %t734 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t735 = load { i8**, i64 }, { i8**, i64 }* %t734
  %t736 = extractvalue { i8**, i64 } %t735, 1
  %t737 = sitofp i64 %t736 to double
  %t738 = fcmp oge double %t733, %t737
  %t739 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t740 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t741 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t742 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t743 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t744 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t745 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t746 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t747 = load %NativeFunction*, %NativeFunction** %l8
  %t748 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t749 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t750 = load double, double* %l11
  %t751 = load i8*, i8** %l12
  %t752 = load i8*, i8** %l13
  %t753 = load i8*, i8** %l21
  %t754 = load double, double* %l22
  br i1 %t738, label %then67, label %merge68
then67:
  br label %afterloop66
merge68:
  %t755 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t756 = load double, double* %l22
  %t757 = fptosi double %t756 to i64
  %t758 = load { i8**, i64 }, { i8**, i64 }* %t755
  %t759 = extractvalue { i8**, i64 } %t758, 0
  %t760 = extractvalue { i8**, i64 } %t758, 1
  %t761 = icmp uge i64 %t757, %t760
  ; bounds check: %t761 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t757, i64 %t760)
  %t762 = getelementptr i8*, i8** %t759, i64 %t757
  %t763 = load i8*, i8** %t762
  store i8* %t763, i8** %l23
  %t764 = load i8*, i8** %l23
  %t765 = call i64 @sailfin_runtime_string_length(i8* %t764)
  %t766 = icmp eq i64 %t765, 0
  %t767 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t768 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t769 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t770 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t771 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t772 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t773 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t774 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t775 = load %NativeFunction*, %NativeFunction** %l8
  %t776 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t777 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t778 = load double, double* %l11
  %t779 = load i8*, i8** %l12
  %t780 = load i8*, i8** %l13
  %t781 = load i8*, i8** %l21
  %t782 = load double, double* %l22
  %t783 = load i8*, i8** %l23
  br i1 %t766, label %then69, label %merge70
then69:
  br label %afterloop66
merge70:
  %t784 = load i8*, i8** %l23
  %t785 = call i8* @trim_text(i8* %t784)
  store i8* %t785, i8** %l24
  %t786 = load i8*, i8** %l24
  %t787 = call i64 @sailfin_runtime_string_length(i8* %t786)
  %t788 = icmp eq i64 %t787, 0
  %t789 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t790 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t791 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t792 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t793 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t794 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t795 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t796 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t797 = load %NativeFunction*, %NativeFunction** %l8
  %t798 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t799 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t800 = load double, double* %l11
  %t801 = load i8*, i8** %l12
  %t802 = load i8*, i8** %l13
  %t803 = load i8*, i8** %l21
  %t804 = load double, double* %l22
  %t805 = load i8*, i8** %l23
  %t806 = load i8*, i8** %l24
  br i1 %t788, label %then71, label %merge72
then71:
  %t807 = load double, double* %l22
  %t808 = sitofp i64 1 to double
  %t809 = fadd double %t807, %t808
  store double %t809, double* %l22
  br label %loop.latch65
merge72:
  %t810 = load i8*, i8** %l24
  %t811 = call i1 @line_looks_like_parameter_entry(i8* %t810)
  %t812 = xor i1 %t811, 1
  %t813 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t814 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t815 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t816 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t817 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t818 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t819 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t820 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t821 = load %NativeFunction*, %NativeFunction** %l8
  %t822 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t823 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t824 = load double, double* %l11
  %t825 = load i8*, i8** %l12
  %t826 = load i8*, i8** %l13
  %t827 = load i8*, i8** %l21
  %t828 = load double, double* %l22
  %t829 = load i8*, i8** %l23
  %t830 = load i8*, i8** %l24
  br i1 %t812, label %then73, label %merge74
then73:
  br label %afterloop66
merge74:
  %t831 = load i8*, i8** %l21
  %t832 = load i8, i8* %t831
  %t833 = add i8 %t832, 32
  %t834 = load i8*, i8** %l24
  %t835 = load i8, i8* %t834
  %t836 = add i8 %t833, %t835
  %t837 = alloca [2 x i8], align 1
  %t838 = getelementptr [2 x i8], [2 x i8]* %t837, i32 0, i32 0
  store i8 %t836, i8* %t838
  %t839 = getelementptr [2 x i8], [2 x i8]* %t837, i32 0, i32 1
  store i8 0, i8* %t839
  %t840 = getelementptr [2 x i8], [2 x i8]* %t837, i32 0, i32 0
  store i8* %t840, i8** %l21
  %t841 = load double, double* %l22
  %t842 = sitofp i64 1 to double
  %t843 = fadd double %t841, %t842
  store double %t843, double* %l22
  br label %loop.latch65
loop.latch65:
  %t844 = load double, double* %l22
  %t845 = load i8*, i8** %l21
  br label %loop.header63
afterloop66:
  %t848 = load double, double* %l22
  %t849 = load i8*, i8** %l21
  %t850 = load i8*, i8** %l21
  %t851 = call { i8**, i64 }* @split_parameter_entries(i8* %t850)
  store { i8**, i64 }* %t851, { i8**, i64 }** %l25
  %t852 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t853 = load { i8**, i64 }, { i8**, i64 }* %t852
  %t854 = extractvalue { i8**, i64 } %t853, 1
  %t855 = icmp eq i64 %t854, 0
  %t856 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t857 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t858 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t859 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t860 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t861 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t862 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t863 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t864 = load %NativeFunction*, %NativeFunction** %l8
  %t865 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t866 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t867 = load double, double* %l11
  %t868 = load i8*, i8** %l12
  %t869 = load i8*, i8** %l13
  %t870 = load i8*, i8** %l21
  %t871 = load double, double* %l22
  %t872 = load { i8**, i64 }*, { i8**, i64 }** %l25
  br i1 %t855, label %then75, label %else76
then75:
  %t873 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s874 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.len32.h1189086491, i32 0, i32 0
  %t875 = load i8*, i8** %l13
  %t876 = call i8* @sailfin_runtime_string_concat(i8* %s874, i8* %t875)
  %t877 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t873, i8* %t876)
  store { i8**, i64 }* %t877, { i8**, i64 }** %l1
  %t878 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t878, %NativeSourceSpan** %l9
  %t879 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t880 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge77
else76:
  %t881 = sitofp i64 0 to double
  store double %t881, double* %l26
  store i1 0, i1* %l27
  %t882 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t883 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t884 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t885 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t886 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t887 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t888 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t889 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t890 = load %NativeFunction*, %NativeFunction** %l8
  %t891 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t892 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t893 = load double, double* %l11
  %t894 = load i8*, i8** %l12
  %t895 = load i8*, i8** %l13
  %t896 = load i8*, i8** %l21
  %t897 = load double, double* %l22
  %t898 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t899 = load double, double* %l26
  %t900 = load i1, i1* %l27
  br label %loop.header78
loop.header78:
  %t1040 = phi { i8**, i64 }* [ %t883, %else76 ], [ %t1036, %loop.latch80 ]
  %t1041 = phi %NativeFunction* [ %t890, %else76 ], [ %t1037, %loop.latch80 ]
  %t1042 = phi i1 [ %t900, %else76 ], [ %t1038, %loop.latch80 ]
  %t1043 = phi double [ %t899, %else76 ], [ %t1039, %loop.latch80 ]
  store { i8**, i64 }* %t1040, { i8**, i64 }** %l1
  store %NativeFunction* %t1041, %NativeFunction** %l8
  store i1 %t1042, i1* %l27
  store double %t1043, double* %l26
  br label %loop.body79
loop.body79:
  %t901 = load double, double* %l26
  %t902 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t903 = load { i8**, i64 }, { i8**, i64 }* %t902
  %t904 = extractvalue { i8**, i64 } %t903, 1
  %t905 = sitofp i64 %t904 to double
  %t906 = fcmp oge double %t901, %t905
  %t907 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t908 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t909 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t910 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t911 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t912 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t913 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t914 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t915 = load %NativeFunction*, %NativeFunction** %l8
  %t916 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t917 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t918 = load double, double* %l11
  %t919 = load i8*, i8** %l12
  %t920 = load i8*, i8** %l13
  %t921 = load i8*, i8** %l21
  %t922 = load double, double* %l22
  %t923 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t924 = load double, double* %l26
  %t925 = load i1, i1* %l27
  br i1 %t906, label %then82, label %merge83
then82:
  br label %afterloop81
merge83:
  %t926 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t927 = load double, double* %l26
  %t928 = fptosi double %t927 to i64
  %t929 = load { i8**, i64 }, { i8**, i64 }* %t926
  %t930 = extractvalue { i8**, i64 } %t929, 0
  %t931 = extractvalue { i8**, i64 } %t929, 1
  %t932 = icmp uge i64 %t928, %t931
  ; bounds check: %t932 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t928, i64 %t931)
  %t933 = getelementptr i8*, i8** %t930, i64 %t928
  %t934 = load i8*, i8** %t933
  store i8* %t934, i8** %l28
  %t935 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t935, %NativeSourceSpan** %l29
  %t936 = load i1, i1* %l27
  %t937 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t938 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t939 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t940 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t941 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t942 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t943 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t944 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t945 = load %NativeFunction*, %NativeFunction** %l8
  %t946 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t947 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t948 = load double, double* %l11
  %t949 = load i8*, i8** %l12
  %t950 = load i8*, i8** %l13
  %t951 = load i8*, i8** %l21
  %t952 = load double, double* %l22
  %t953 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t954 = load double, double* %l26
  %t955 = load i1, i1* %l27
  %t956 = load i8*, i8** %l28
  %t957 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  br i1 %t936, label %then84, label %merge85
then84:
  %t958 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t958, %NativeSourceSpan** %l29
  %t959 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  br label %merge85
merge85:
  %t960 = phi %NativeSourceSpan* [ %t959, %then84 ], [ %t957, %merge83 ]
  store %NativeSourceSpan* %t960, %NativeSourceSpan** %l29
  %t961 = load i8*, i8** %l28
  %t962 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  %t963 = call %NativeParameter* @parse_parameter_entry(i8* %t961, %NativeSourceSpan* %t962)
  store %NativeParameter* %t963, %NativeParameter** %l30
  %t964 = load %NativeParameter*, %NativeParameter** %l30
  %t965 = icmp eq %NativeParameter* %t964, null
  %t966 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t967 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t968 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t969 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t970 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t971 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t972 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t973 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t974 = load %NativeFunction*, %NativeFunction** %l8
  %t975 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t976 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t977 = load double, double* %l11
  %t978 = load i8*, i8** %l12
  %t979 = load i8*, i8** %l13
  %t980 = load i8*, i8** %l21
  %t981 = load double, double* %l22
  %t982 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t983 = load double, double* %l26
  %t984 = load i1, i1* %l27
  %t985 = load i8*, i8** %l28
  %t986 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  %t987 = load %NativeParameter*, %NativeParameter** %l30
  br i1 %t965, label %then86, label %else87
then86:
  %t988 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s989 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.len33.h1023685264, i32 0, i32 0
  %t990 = load i8*, i8** %l28
  %t991 = call i8* @sailfin_runtime_string_concat(i8* %s989, i8* %t990)
  %t992 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t988, i8* %t991)
  store { i8**, i64 }* %t992, { i8**, i64 }** %l1
  %t993 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge88
else87:
  %t994 = load %NativeFunction*, %NativeFunction** %l8
  %t995 = load %NativeParameter*, %NativeParameter** %l30
  %t996 = load %NativeFunction, %NativeFunction* %t994
  %t997 = load %NativeParameter, %NativeParameter* %t995
  %t998 = call %NativeFunction @append_parameter(%NativeFunction %t996, %NativeParameter %t997)
  %t999 = alloca %NativeFunction
  store %NativeFunction %t998, %NativeFunction* %t999
  store %NativeFunction* %t999, %NativeFunction** %l8
  %t1000 = load %NativeParameter*, %NativeParameter** %l30
  %t1001 = getelementptr %NativeParameter, %NativeParameter* %t1000, i32 0, i32 4
  %t1002 = load %NativeSourceSpan*, %NativeSourceSpan** %t1001
  %t1003 = icmp ne %NativeSourceSpan* %t1002, null
  %t1004 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1005 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1006 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1007 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1008 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1009 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1010 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1011 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1012 = load %NativeFunction*, %NativeFunction** %l8
  %t1013 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1014 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1015 = load double, double* %l11
  %t1016 = load i8*, i8** %l12
  %t1017 = load i8*, i8** %l13
  %t1018 = load i8*, i8** %l21
  %t1019 = load double, double* %l22
  %t1020 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t1021 = load double, double* %l26
  %t1022 = load i1, i1* %l27
  %t1023 = load i8*, i8** %l28
  %t1024 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  %t1025 = load %NativeParameter*, %NativeParameter** %l30
  br i1 %t1003, label %then89, label %merge90
then89:
  store i1 1, i1* %l27
  %t1026 = load i1, i1* %l27
  br label %merge90
merge90:
  %t1027 = phi i1 [ %t1026, %then89 ], [ %t1022, %else87 ]
  store i1 %t1027, i1* %l27
  %t1028 = load %NativeFunction*, %NativeFunction** %l8
  %t1029 = load i1, i1* %l27
  br label %merge88
merge88:
  %t1030 = phi { i8**, i64 }* [ %t993, %then86 ], [ %t967, %merge90 ]
  %t1031 = phi %NativeFunction* [ %t974, %then86 ], [ %t1028, %merge90 ]
  %t1032 = phi i1 [ %t984, %then86 ], [ %t1029, %merge90 ]
  store { i8**, i64 }* %t1030, { i8**, i64 }** %l1
  store %NativeFunction* %t1031, %NativeFunction** %l8
  store i1 %t1032, i1* %l27
  %t1033 = load double, double* %l26
  %t1034 = sitofp i64 1 to double
  %t1035 = fadd double %t1033, %t1034
  store double %t1035, double* %l26
  br label %loop.latch80
loop.latch80:
  %t1036 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1037 = load %NativeFunction*, %NativeFunction** %l8
  %t1038 = load i1, i1* %l27
  %t1039 = load double, double* %l26
  br label %loop.header78
afterloop81:
  %t1044 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1045 = load %NativeFunction*, %NativeFunction** %l8
  %t1046 = load i1, i1* %l27
  %t1047 = load double, double* %l26
  %t1048 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1048, %NativeSourceSpan** %l9
  %t1049 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1050 = load %NativeFunction*, %NativeFunction** %l8
  %t1051 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge77
merge77:
  %t1052 = phi { i8**, i64 }* [ %t879, %then75 ], [ %t1049, %afterloop81 ]
  %t1053 = phi %NativeSourceSpan* [ %t880, %then75 ], [ %t1051, %afterloop81 ]
  %t1054 = phi %NativeFunction* [ %t864, %then75 ], [ %t1050, %afterloop81 ]
  store { i8**, i64 }* %t1052, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1053, %NativeSourceSpan** %l9
  store %NativeFunction* %t1054, %NativeFunction** %l8
  %t1055 = load double, double* %l22
  %t1056 = sitofp i64 1 to double
  %t1057 = fsub double %t1055, %t1056
  store double %t1057, double* %l11
  %t1058 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1059 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1060 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1061 = load %NativeFunction*, %NativeFunction** %l8
  %t1062 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1063 = load double, double* %l11
  br label %merge62
else61:
  %t1064 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1065 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.len33.h712498791, i32 0, i32 0
  %t1066 = load i8*, i8** %l13
  %t1067 = call i8* @sailfin_runtime_string_concat(i8* %s1065, i8* %t1066)
  %t1068 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1064, i8* %t1067)
  store { i8**, i64 }* %t1068, { i8**, i64 }** %l1
  %t1069 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge62
merge62:
  %t1070 = phi { i8**, i64 }* [ %t1058, %merge77 ], [ %t1069, %else61 ]
  %t1071 = phi %NativeSourceSpan* [ %t1059, %merge77 ], [ %t706, %else61 ]
  %t1072 = phi %NativeFunction* [ %t1061, %merge77 ], [ %t705, %else61 ]
  %t1073 = phi double [ %t1063, %merge77 ], [ %t708, %else61 ]
  store { i8**, i64 }* %t1070, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1071, %NativeSourceSpan** %l9
  store %NativeFunction* %t1072, %NativeFunction** %l8
  store double %t1073, double* %l11
  %t1074 = load double, double* %l11
  %t1075 = sitofp i64 1 to double
  %t1076 = fadd double %t1074, %t1075
  store double %t1076, double* %l11
  br label %loop.latch2
merge59:
  %t1077 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1078 = load double, double* %l11
  %t1079 = call %InstructionGatherResult @gather_instruction({ i8**, i64 }* %t1077, double %t1078)
  store %InstructionGatherResult %t1079, %InstructionGatherResult* %l31
  %t1080 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1081 = extractvalue %InstructionGatherResult %t1080, 0
  store i8* %t1081, i8** %l13
  %t1082 = load double, double* %l11
  %t1083 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1084 = extractvalue %InstructionGatherResult %t1083, 1
  %t1085 = fadd double %t1082, %t1084
  store double %t1085, double* %l11
  %t1086 = load i8*, i8** %l13
  %t1087 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1088 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1089 = call %InstructionParseResult @parse_instruction(i8* %t1086, %NativeSourceSpan* %t1087, %NativeSourceSpan* %t1088)
  store %InstructionParseResult %t1089, %InstructionParseResult* %l32
  %t1090 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1091 = extractvalue %InstructionParseResult %t1090, 0
  store { %NativeInstruction**, i64 }* %t1091, { %NativeInstruction**, i64 }** %l33
  %t1092 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1093 = extractvalue %InstructionParseResult %t1092, 1
  %t1094 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1095 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1096 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1097 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1098 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1099 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1100 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1101 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1102 = load %NativeFunction*, %NativeFunction** %l8
  %t1103 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1104 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1105 = load double, double* %l11
  %t1106 = load i8*, i8** %l12
  %t1107 = load i8*, i8** %l13
  %t1108 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1109 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1110 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1093, label %then91, label %else92
then91:
  %t1111 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1111, %NativeSourceSpan** %l9
  %t1112 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge93
else92:
  %t1113 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1114 = icmp ne %NativeSourceSpan* %t1113, null
  %t1115 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1116 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1117 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1118 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1119 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1120 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1121 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1122 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1123 = load %NativeFunction*, %NativeFunction** %l8
  %t1124 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1125 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1126 = load double, double* %l11
  %t1127 = load i8*, i8** %l12
  %t1128 = load i8*, i8** %l13
  %t1129 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1130 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1131 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1114, label %then94, label %merge95
then94:
  %t1132 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1133 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1601547567, i32 0, i32 0
  %t1134 = load i8*, i8** %l13
  %t1135 = call i8* @sailfin_runtime_string_concat(i8* %s1133, i8* %t1134)
  %t1136 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1132, i8* %t1135)
  store { i8**, i64 }* %t1136, { i8**, i64 }** %l1
  %t1137 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1137, %NativeSourceSpan** %l9
  %t1138 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1139 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge95
merge95:
  %t1140 = phi { i8**, i64 }* [ %t1138, %then94 ], [ %t1116, %else92 ]
  %t1141 = phi %NativeSourceSpan* [ %t1139, %then94 ], [ %t1124, %else92 ]
  store { i8**, i64 }* %t1140, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1141, %NativeSourceSpan** %l9
  %t1142 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1143 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge93
merge93:
  %t1144 = phi %NativeSourceSpan* [ %t1112, %then91 ], [ %t1143, %merge95 ]
  %t1145 = phi { i8**, i64 }* [ %t1095, %then91 ], [ %t1142, %merge95 ]
  store %NativeSourceSpan* %t1144, %NativeSourceSpan** %l9
  store { i8**, i64 }* %t1145, { i8**, i64 }** %l1
  %t1146 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1147 = extractvalue %InstructionParseResult %t1146, 2
  %t1148 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1149 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1150 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1151 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1152 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1153 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1154 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1155 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1156 = load %NativeFunction*, %NativeFunction** %l8
  %t1157 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1158 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1159 = load double, double* %l11
  %t1160 = load i8*, i8** %l12
  %t1161 = load i8*, i8** %l13
  %t1162 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1163 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1164 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1147, label %then96, label %else97
then96:
  %t1165 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1165, %NativeSourceSpan** %l10
  %t1166 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge98
else97:
  %t1167 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1168 = icmp ne %NativeSourceSpan* %t1167, null
  %t1169 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1170 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1171 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1172 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1173 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1174 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1175 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1176 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1177 = load %NativeFunction*, %NativeFunction** %l8
  %t1178 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1179 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1180 = load double, double* %l11
  %t1181 = load i8*, i8** %l12
  %t1182 = load i8*, i8** %l13
  %t1183 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1184 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1185 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1168, label %then99, label %merge100
then99:
  %t1186 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1187 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h35508704, i32 0, i32 0
  %t1188 = load i8*, i8** %l13
  %t1189 = call i8* @sailfin_runtime_string_concat(i8* %s1187, i8* %t1188)
  %t1190 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1186, i8* %t1189)
  store { i8**, i64 }* %t1190, { i8**, i64 }** %l1
  %t1191 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1191, %NativeSourceSpan** %l10
  %t1192 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1193 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge100
merge100:
  %t1194 = phi { i8**, i64 }* [ %t1192, %then99 ], [ %t1170, %else97 ]
  %t1195 = phi %NativeSourceSpan* [ %t1193, %then99 ], [ %t1179, %else97 ]
  store { i8**, i64 }* %t1194, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1195, %NativeSourceSpan** %l10
  %t1196 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1197 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge98
merge98:
  %t1198 = phi %NativeSourceSpan* [ %t1166, %then96 ], [ %t1197, %merge100 ]
  %t1199 = phi { i8**, i64 }* [ %t1149, %then96 ], [ %t1196, %merge100 ]
  store %NativeSourceSpan* %t1198, %NativeSourceSpan** %l10
  store { i8**, i64 }* %t1199, { i8**, i64 }** %l1
  %t1200 = load %NativeFunction*, %NativeFunction** %l8
  %t1201 = icmp eq %NativeFunction* %t1200, null
  %t1202 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1203 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1204 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1205 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1206 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1207 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1208 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1209 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1210 = load %NativeFunction*, %NativeFunction** %l8
  %t1211 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1212 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1213 = load double, double* %l11
  %t1214 = load i8*, i8** %l12
  %t1215 = load i8*, i8** %l13
  %t1216 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1217 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1218 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1201, label %then101, label %merge102
then101:
  %t1220 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1221 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1220
  %t1222 = extractvalue { %NativeInstruction**, i64 } %t1221, 1
  %t1223 = icmp eq i64 %t1222, 1
  br label %logical_and_entry_1219

logical_and_entry_1219:
  br i1 %t1223, label %logical_and_right_1219, label %logical_and_merge_1219

logical_and_right_1219:
  %t1224 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1225 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1224
  %t1226 = extractvalue { %NativeInstruction**, i64 } %t1225, 0
  %t1227 = extractvalue { %NativeInstruction**, i64 } %t1225, 1
  %t1228 = icmp uge i64 0, %t1227
  ; bounds check: %t1228 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t1227)
  %t1229 = getelementptr %NativeInstruction*, %NativeInstruction** %t1226, i64 0
  %t1230 = load %NativeInstruction*, %NativeInstruction** %t1229
  %t1231 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1230, i32 0, i32 0
  %t1232 = load i32, i32* %t1231
  %t1233 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1234 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1235 = icmp eq i32 %t1232, 0
  %t1236 = select i1 %t1235, i8* %t1234, i8* %t1233
  %t1237 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1238 = icmp eq i32 %t1232, 1
  %t1239 = select i1 %t1238, i8* %t1237, i8* %t1236
  %t1240 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1241 = icmp eq i32 %t1232, 2
  %t1242 = select i1 %t1241, i8* %t1240, i8* %t1239
  %t1243 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1244 = icmp eq i32 %t1232, 3
  %t1245 = select i1 %t1244, i8* %t1243, i8* %t1242
  %t1246 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1247 = icmp eq i32 %t1232, 4
  %t1248 = select i1 %t1247, i8* %t1246, i8* %t1245
  %t1249 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1250 = icmp eq i32 %t1232, 5
  %t1251 = select i1 %t1250, i8* %t1249, i8* %t1248
  %t1252 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1253 = icmp eq i32 %t1232, 6
  %t1254 = select i1 %t1253, i8* %t1252, i8* %t1251
  %t1255 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1256 = icmp eq i32 %t1232, 7
  %t1257 = select i1 %t1256, i8* %t1255, i8* %t1254
  %t1258 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1259 = icmp eq i32 %t1232, 8
  %t1260 = select i1 %t1259, i8* %t1258, i8* %t1257
  %t1261 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1262 = icmp eq i32 %t1232, 9
  %t1263 = select i1 %t1262, i8* %t1261, i8* %t1260
  %t1264 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1265 = icmp eq i32 %t1232, 10
  %t1266 = select i1 %t1265, i8* %t1264, i8* %t1263
  %t1267 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1268 = icmp eq i32 %t1232, 11
  %t1269 = select i1 %t1268, i8* %t1267, i8* %t1266
  %t1270 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1271 = icmp eq i32 %t1232, 12
  %t1272 = select i1 %t1271, i8* %t1270, i8* %t1269
  %t1273 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1274 = icmp eq i32 %t1232, 13
  %t1275 = select i1 %t1274, i8* %t1273, i8* %t1272
  %t1276 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1277 = icmp eq i32 %t1232, 14
  %t1278 = select i1 %t1277, i8* %t1276, i8* %t1275
  %t1279 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1280 = icmp eq i32 %t1232, 15
  %t1281 = select i1 %t1280, i8* %t1279, i8* %t1278
  %t1282 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1283 = icmp eq i32 %t1232, 16
  %t1284 = select i1 %t1283, i8* %t1282, i8* %t1281
  %s1285 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089318639, i32 0, i32 0
  %t1286 = icmp eq i8* %t1284, %s1285
  br label %logical_and_right_end_1219

logical_and_right_end_1219:
  br label %logical_and_merge_1219

logical_and_merge_1219:
  %t1287 = phi i1 [ false, %logical_and_entry_1219 ], [ %t1286, %logical_and_right_end_1219 ]
  %t1288 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1289 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1290 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1291 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1292 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1293 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1294 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1295 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1296 = load %NativeFunction*, %NativeFunction** %l8
  %t1297 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1298 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1299 = load double, double* %l11
  %t1300 = load i8*, i8** %l12
  %t1301 = load i8*, i8** %l13
  %t1302 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1303 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1304 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1287, label %then103, label %else104
then103:
  %t1305 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1306 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1307 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1306
  %t1308 = extractvalue { %NativeInstruction**, i64 } %t1307, 0
  %t1309 = extractvalue { %NativeInstruction**, i64 } %t1307, 1
  %t1310 = icmp uge i64 0, %t1309
  ; bounds check: %t1310 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t1309)
  %t1311 = getelementptr %NativeInstruction*, %NativeInstruction** %t1308, i64 0
  %t1312 = load %NativeInstruction*, %NativeInstruction** %t1311
  %t1313 = load %NativeInstruction, %NativeInstruction* %t1312
  %t1314 = call %NativeBinding @binding_from_instruction(%NativeInstruction %t1313)
  %t1315 = call { %NativeBinding*, i64 }* @append_binding({ %NativeBinding*, i64 }* %t1305, %NativeBinding %t1314)
  store { %NativeBinding*, i64 }* %t1315, { %NativeBinding*, i64 }** %l7
  %t1316 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  br label %merge105
else104:
  %t1317 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1318 = getelementptr inbounds [48 x i8], [48 x i8]* @.str.len47.h1886628617, i32 0, i32 0
  %t1319 = load i8*, i8** %l13
  %t1320 = call i8* @sailfin_runtime_string_concat(i8* %s1318, i8* %t1319)
  %t1321 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1317, i8* %t1320)
  store { i8**, i64 }* %t1321, { i8**, i64 }** %l1
  %t1322 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge105
merge105:
  %t1323 = phi { %NativeBinding*, i64 }* [ %t1316, %then103 ], [ %t1295, %else104 ]
  %t1324 = phi { i8**, i64 }* [ %t1289, %then103 ], [ %t1322, %else104 ]
  store { %NativeBinding*, i64 }* %t1323, { %NativeBinding*, i64 }** %l7
  store { i8**, i64 }* %t1324, { i8**, i64 }** %l1
  %t1325 = load double, double* %l11
  %t1326 = sitofp i64 1 to double
  %t1327 = fadd double %t1325, %t1326
  store double %t1327, double* %l11
  br label %loop.latch2
merge102:
  %t1328 = sitofp i64 0 to double
  store double %t1328, double* %l34
  %t1329 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1330 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1331 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1332 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1333 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1334 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1335 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1336 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1337 = load %NativeFunction*, %NativeFunction** %l8
  %t1338 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1339 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1340 = load double, double* %l11
  %t1341 = load i8*, i8** %l12
  %t1342 = load i8*, i8** %l13
  %t1343 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1344 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1345 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1346 = load double, double* %l34
  br label %loop.header106
loop.header106:
  %t1390 = phi %NativeFunction* [ %t1337, %merge102 ], [ %t1388, %loop.latch108 ]
  %t1391 = phi double [ %t1346, %merge102 ], [ %t1389, %loop.latch108 ]
  store %NativeFunction* %t1390, %NativeFunction** %l8
  store double %t1391, double* %l34
  br label %loop.body107
loop.body107:
  %t1347 = load double, double* %l34
  %t1348 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1349 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1348
  %t1350 = extractvalue { %NativeInstruction**, i64 } %t1349, 1
  %t1351 = sitofp i64 %t1350 to double
  %t1352 = fcmp oge double %t1347, %t1351
  %t1353 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1354 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1355 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1356 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1357 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1358 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1359 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1360 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1361 = load %NativeFunction*, %NativeFunction** %l8
  %t1362 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1363 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1364 = load double, double* %l11
  %t1365 = load i8*, i8** %l12
  %t1366 = load i8*, i8** %l13
  %t1367 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1368 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1369 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1370 = load double, double* %l34
  br i1 %t1352, label %then110, label %merge111
then110:
  br label %afterloop109
merge111:
  %t1371 = load %NativeFunction*, %NativeFunction** %l8
  %t1372 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1373 = load double, double* %l34
  %t1374 = fptosi double %t1373 to i64
  %t1375 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1372
  %t1376 = extractvalue { %NativeInstruction**, i64 } %t1375, 0
  %t1377 = extractvalue { %NativeInstruction**, i64 } %t1375, 1
  %t1378 = icmp uge i64 %t1374, %t1377
  ; bounds check: %t1378 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1374, i64 %t1377)
  %t1379 = getelementptr %NativeInstruction*, %NativeInstruction** %t1376, i64 %t1374
  %t1380 = load %NativeInstruction*, %NativeInstruction** %t1379
  %t1381 = load %NativeFunction, %NativeFunction* %t1371
  %t1382 = load %NativeInstruction, %NativeInstruction* %t1380
  %t1383 = call %NativeFunction @append_instruction(%NativeFunction %t1381, %NativeInstruction %t1382)
  %t1384 = alloca %NativeFunction
  store %NativeFunction %t1383, %NativeFunction* %t1384
  store %NativeFunction* %t1384, %NativeFunction** %l8
  %t1385 = load double, double* %l34
  %t1386 = sitofp i64 1 to double
  %t1387 = fadd double %t1385, %t1386
  store double %t1387, double* %l34
  br label %loop.latch108
loop.latch108:
  %t1388 = load %NativeFunction*, %NativeFunction** %l8
  %t1389 = load double, double* %l34
  br label %loop.header106
afterloop109:
  %t1392 = load %NativeFunction*, %NativeFunction** %l8
  %t1393 = load double, double* %l34
  %t1394 = load double, double* %l11
  %t1395 = sitofp i64 1 to double
  %t1396 = fadd double %t1394, %t1395
  store double %t1396, double* %l11
  br label %loop.latch2
loop.latch2:
  %t1397 = load double, double* %l11
  %t1398 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1399 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1400 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1401 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1402 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1403 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1404 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1405 = load %NativeFunction*, %NativeFunction** %l8
  %t1406 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1407 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  br label %loop.header0
afterloop3:
  %t1419 = load double, double* %l11
  %t1420 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1421 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1422 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1423 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1424 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1425 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1426 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1427 = load %NativeFunction*, %NativeFunction** %l8
  %t1428 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1429 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1430 = load %NativeFunction*, %NativeFunction** %l8
  %t1431 = icmp ne %NativeFunction* %t1430, null
  %t1432 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1433 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1434 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1435 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1436 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1437 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1438 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1439 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1440 = load %NativeFunction*, %NativeFunction** %l8
  %t1441 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1442 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1443 = load double, double* %l11
  br i1 %t1431, label %then112, label %merge113
then112:
  %t1444 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1445 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.len40.h1512965366, i32 0, i32 0
  %t1446 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1444, i8* %s1445)
  store { i8**, i64 }* %t1446, { i8**, i64 }** %l1
  %t1447 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge113
merge113:
  %t1448 = phi { i8**, i64 }* [ %t1447, %then112 ], [ %t1433, %afterloop3 ]
  store { i8**, i64 }* %t1448, { i8**, i64 }** %l1
  %t1449 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1450 = bitcast { %NativeFunction*, i64 }* %t1449 to { %NativeFunction**, i64 }*
  %t1451 = insertvalue %ParseNativeResult undef, { %NativeFunction**, i64 }* %t1450, 0
  %t1452 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1453 = bitcast { %NativeImport*, i64 }* %t1452 to { %NativeImport**, i64 }*
  %t1454 = insertvalue %ParseNativeResult %t1451, { %NativeImport**, i64 }* %t1453, 1
  %t1455 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1456 = bitcast { %NativeStruct*, i64 }* %t1455 to { %NativeStruct**, i64 }*
  %t1457 = insertvalue %ParseNativeResult %t1454, { %NativeStruct**, i64 }* %t1456, 2
  %t1458 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1459 = bitcast { %NativeInterface*, i64 }* %t1458 to { %NativeInterface**, i64 }*
  %t1460 = insertvalue %ParseNativeResult %t1457, { %NativeInterface**, i64 }* %t1459, 3
  %t1461 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1462 = bitcast { %NativeEnum*, i64 }* %t1461 to { %NativeEnum**, i64 }*
  %t1463 = insertvalue %ParseNativeResult %t1460, { %NativeEnum**, i64 }* %t1462, 4
  %t1464 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1465 = bitcast { %NativeBinding*, i64 }* %t1464 to { %NativeBinding**, i64 }*
  %t1466 = insertvalue %ParseNativeResult %t1463, { %NativeBinding**, i64 }* %t1465, 5
  %t1467 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1468 = insertvalue %ParseNativeResult %t1466, { i8**, i64 }* %t1467, 6
  ret %ParseNativeResult %t1468
}

define %NativeSourceSpan* @parse_source_span(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %NumberParseResult
  %l3 = alloca %NumberParseResult
  %l4 = alloca %NumberParseResult
  %l5 = alloca %NumberParseResult
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = bitcast i8* null to %NativeSourceSpan*
  ret %NativeSourceSpan* %t5
merge1:
  %t6 = load i8*, i8** %l0
  %t7 = call { i8**, i64 }* @split_whitespace(i8* %t6)
  store { i8**, i64 }* %t7, { i8**, i64 }** %l1
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %t8
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = icmp ne i64 %t10, 4
  %t12 = load i8*, i8** %l0
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t11, label %then2, label %merge3
then2:
  %t14 = bitcast i8* null to %NativeSourceSpan*
  ret %NativeSourceSpan* %t14
merge3:
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %t15
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 0, %t18
  ; bounds check: %t19 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t18)
  %t20 = getelementptr i8*, i8** %t17, i64 0
  %t21 = load i8*, i8** %t20
  %t22 = call %NumberParseResult @parse_decimal_number(i8* %t21)
  store %NumberParseResult %t22, %NumberParseResult* %l2
  %t23 = load %NumberParseResult, %NumberParseResult* %l2
  %t24 = extractvalue %NumberParseResult %t23, 0
  %t25 = xor i1 %t24, 1
  %t26 = load i8*, i8** %l0
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t28 = load %NumberParseResult, %NumberParseResult* %l2
  br i1 %t25, label %then4, label %merge5
then4:
  %t29 = bitcast i8* null to %NativeSourceSpan*
  ret %NativeSourceSpan* %t29
merge5:
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t31 = load { i8**, i64 }, { i8**, i64 }* %t30
  %t32 = extractvalue { i8**, i64 } %t31, 0
  %t33 = extractvalue { i8**, i64 } %t31, 1
  %t34 = icmp uge i64 1, %t33
  ; bounds check: %t34 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 1, i64 %t33)
  %t35 = getelementptr i8*, i8** %t32, i64 1
  %t36 = load i8*, i8** %t35
  %t37 = call %NumberParseResult @parse_decimal_number(i8* %t36)
  store %NumberParseResult %t37, %NumberParseResult* %l3
  %t38 = load %NumberParseResult, %NumberParseResult* %l3
  %t39 = extractvalue %NumberParseResult %t38, 0
  %t40 = xor i1 %t39, 1
  %t41 = load i8*, i8** %l0
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t43 = load %NumberParseResult, %NumberParseResult* %l2
  %t44 = load %NumberParseResult, %NumberParseResult* %l3
  br i1 %t40, label %then6, label %merge7
then6:
  %t45 = bitcast i8* null to %NativeSourceSpan*
  ret %NativeSourceSpan* %t45
merge7:
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t47 = load { i8**, i64 }, { i8**, i64 }* %t46
  %t48 = extractvalue { i8**, i64 } %t47, 0
  %t49 = extractvalue { i8**, i64 } %t47, 1
  %t50 = icmp uge i64 2, %t49
  ; bounds check: %t50 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 2, i64 %t49)
  %t51 = getelementptr i8*, i8** %t48, i64 2
  %t52 = load i8*, i8** %t51
  %t53 = call %NumberParseResult @parse_decimal_number(i8* %t52)
  store %NumberParseResult %t53, %NumberParseResult* %l4
  %t54 = load %NumberParseResult, %NumberParseResult* %l4
  %t55 = extractvalue %NumberParseResult %t54, 0
  %t56 = xor i1 %t55, 1
  %t57 = load i8*, i8** %l0
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = load %NumberParseResult, %NumberParseResult* %l2
  %t60 = load %NumberParseResult, %NumberParseResult* %l3
  %t61 = load %NumberParseResult, %NumberParseResult* %l4
  br i1 %t56, label %then8, label %merge9
then8:
  %t62 = bitcast i8* null to %NativeSourceSpan*
  ret %NativeSourceSpan* %t62
merge9:
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t64 = load { i8**, i64 }, { i8**, i64 }* %t63
  %t65 = extractvalue { i8**, i64 } %t64, 0
  %t66 = extractvalue { i8**, i64 } %t64, 1
  %t67 = icmp uge i64 3, %t66
  ; bounds check: %t67 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 3, i64 %t66)
  %t68 = getelementptr i8*, i8** %t65, i64 3
  %t69 = load i8*, i8** %t68
  %t70 = call %NumberParseResult @parse_decimal_number(i8* %t69)
  store %NumberParseResult %t70, %NumberParseResult* %l5
  %t71 = load %NumberParseResult, %NumberParseResult* %l5
  %t72 = extractvalue %NumberParseResult %t71, 0
  %t73 = xor i1 %t72, 1
  %t74 = load i8*, i8** %l0
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t76 = load %NumberParseResult, %NumberParseResult* %l2
  %t77 = load %NumberParseResult, %NumberParseResult* %l3
  %t78 = load %NumberParseResult, %NumberParseResult* %l4
  %t79 = load %NumberParseResult, %NumberParseResult* %l5
  br i1 %t73, label %then10, label %merge11
then10:
  %t80 = bitcast i8* null to %NativeSourceSpan*
  ret %NativeSourceSpan* %t80
merge11:
  %t81 = load %NumberParseResult, %NumberParseResult* %l2
  %t82 = extractvalue %NumberParseResult %t81, 1
  %t83 = insertvalue %NativeSourceSpan undef, double %t82, 0
  %t84 = load %NumberParseResult, %NumberParseResult* %l3
  %t85 = extractvalue %NumberParseResult %t84, 1
  %t86 = insertvalue %NativeSourceSpan %t83, double %t85, 1
  %t87 = load %NumberParseResult, %NumberParseResult* %l4
  %t88 = extractvalue %NumberParseResult %t87, 1
  %t89 = insertvalue %NativeSourceSpan %t86, double %t88, 2
  %t90 = load %NumberParseResult, %NumberParseResult* %l5
  %t91 = extractvalue %NumberParseResult %t90, 1
  %t92 = insertvalue %NativeSourceSpan %t89, double %t91, 3
  %t93 = alloca %NativeSourceSpan
  store %NativeSourceSpan %t92, %NativeSourceSpan* %t93
  ret %NativeSourceSpan* %t93
}

define { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %functions, %NativeFunction %value) {
entry:
  %t0 = call noalias i8* @malloc(i64 40)
  %t1 = bitcast i8* %t0 to %NativeFunction*
  store %NativeFunction %value, %NativeFunction* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %NativeFunction*, i64 }* %functions to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %NativeFunction*, i64 }*
  ret { %NativeFunction*, i64 }* %t10
}

define { %NativeBinding*, i64 }* @append_binding({ %NativeBinding*, i64 }* %bindings, %NativeBinding %value) {
entry:
  %t0 = call noalias i8* @malloc(i64 32)
  %t1 = bitcast i8* %t0 to %NativeBinding*
  store %NativeBinding %value, %NativeBinding* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %NativeBinding*, i64 }* %bindings to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %NativeBinding*, i64 }*
  ret { %NativeBinding*, i64 }* %t10
}

define { %NativeImport*, i64 }* @append_import({ %NativeImport*, i64 }* %imports, %NativeImport %value) {
entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %NativeImport*
  store %NativeImport %value, %NativeImport* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %NativeImport*, i64 }* %imports to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %NativeImport*, i64 }*
  ret { %NativeImport*, i64 }* %t10
}

define { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %structs, %NativeStruct %value) {
entry:
  %t0 = call noalias i8* @malloc(i64 40)
  %t1 = bitcast i8* %t0 to %NativeStruct*
  store %NativeStruct %value, %NativeStruct* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %NativeStruct*, i64 }* %structs to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %NativeStruct*, i64 }*
  ret { %NativeStruct*, i64 }* %t10
}

define { %NativeInterface*, i64 }* @append_interface({ %NativeInterface*, i64 }* %interfaces, %NativeInterface %value) {
entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %NativeInterface*
  store %NativeInterface %value, %NativeInterface* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %NativeInterface*, i64 }* %interfaces to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %NativeInterface*, i64 }*
  ret { %NativeInterface*, i64 }* %t10
}

define { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %enums, %NativeEnum %value) {
entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %NativeEnum*
  store %NativeEnum %value, %NativeEnum* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %NativeEnum*, i64 }* %enums to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %NativeEnum*, i64 }*
  ret { %NativeEnum*, i64 }* %t10
}

define { %NativeEnumVariant*, i64 }* @append_enum_variant({ %NativeEnumVariant*, i64 }* %variants, %NativeEnumVariant %value) {
entry:
  %t0 = call noalias i8* @malloc(i64 16)
  %t1 = bitcast i8* %t0 to %NativeEnumVariant*
  store %NativeEnumVariant %value, %NativeEnumVariant* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %NativeEnumVariant*, i64 }* %variants to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %NativeEnumVariant*, i64 }*
  ret { %NativeEnumVariant*, i64 }* %t10
}

define { %NativeEnumVariantField*, i64 }* @append_enum_variant_field({ %NativeEnumVariantField*, i64 }* %fields, %NativeEnumVariantField %value) {
entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %NativeEnumVariantField*
  store %NativeEnumVariantField %value, %NativeEnumVariantField* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %NativeEnumVariantField*, i64 }* %fields to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %NativeEnumVariantField*, i64 }*
  ret { %NativeEnumVariantField*, i64 }* %t10
}

define { %NativeStructField*, i64 }* @append_struct_field({ %NativeStructField*, i64 }* %fields, %NativeStructField %field) {
entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %NativeStructField*
  store %NativeStructField %field, %NativeStructField* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %NativeStructField*, i64 }* %fields to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %NativeStructField*, i64 }*
  ret { %NativeStructField*, i64 }* %t10
}

define { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %fields, %NativeStructLayoutField %field) {
entry:
  %t0 = call noalias i8* @malloc(i64 40)
  %t1 = bitcast i8* %t0 to %NativeStructLayoutField*
  store %NativeStructLayoutField %field, %NativeStructLayoutField* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %NativeStructLayoutField*, i64 }* %fields to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %NativeStructLayoutField*, i64 }*
  ret { %NativeStructLayoutField*, i64 }* %t10
}

define { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %variants, %NativeEnumVariantLayout %value) {
entry:
  %t0 = call noalias i8* @malloc(i64 48)
  %t1 = bitcast i8* %t0 to %NativeEnumVariantLayout*
  store %NativeEnumVariantLayout %value, %NativeEnumVariantLayout* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %NativeEnumVariantLayout*, i64 }* %variants to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %NativeEnumVariantLayout*, i64 }*
  ret { %NativeEnumVariantLayout*, i64 }* %t10
}

define double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %variants, i8* %name) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t24 = phi double [ %t1, %entry ], [ %t23, %loop.latch2 ]
  store double %t24, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t4 = extractvalue { %NativeEnumVariantLayout*, i64 } %t3, 1
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t2, %t5
  %t7 = load double, double* %l0
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l0
  %t9 = fptosi double %t8 to i64
  %t10 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t11 = extractvalue { %NativeEnumVariantLayout*, i64 } %t10, 0
  %t12 = extractvalue { %NativeEnumVariantLayout*, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t9, i64 %t12)
  %t14 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t11, i64 %t9
  %t15 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t14
  %t16 = extractvalue %NativeEnumVariantLayout %t15, 0
  %t17 = icmp eq i8* %t16, %name
  %t18 = load double, double* %l0
  br i1 %t17, label %then6, label %merge7
then6:
  %t19 = load double, double* %l0
  ret double %t19
merge7:
  %t20 = load double, double* %l0
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l0
  br label %loop.latch2
loop.latch2:
  %t23 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t25 = load double, double* %l0
  %t26 = sitofp i64 -1 to double
  ret double %t26
}

define { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %variants, double %index, %NativeStructLayoutField %field) {
entry:
  %l0 = alloca { %NativeEnumVariantLayout*, i64 }*
  %l1 = alloca double
  %l2 = alloca %NativeEnumVariantLayout
  %l3 = alloca %NativeEnumVariantLayout
  %t0 = alloca [0 x %NativeEnumVariantLayout]
  %t1 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* %t0, i32 0, i32 0
  %t2 = alloca { %NativeEnumVariantLayout*, i64 }
  %t3 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t2, i32 0, i32 0
  store %NativeEnumVariantLayout* %t1, %NativeEnumVariantLayout** %t3
  %t4 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %NativeEnumVariantLayout*, i64 }* %t2, { %NativeEnumVariantLayout*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t69 = phi { %NativeEnumVariantLayout*, i64 }* [ %t6, %entry ], [ %t67, %loop.latch2 ]
  %t70 = phi double [ %t7, %entry ], [ %t68, %loop.latch2 ]
  store { %NativeEnumVariantLayout*, i64 }* %t69, { %NativeEnumVariantLayout*, i64 }** %l0
  store double %t70, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t10 = extractvalue { %NativeEnumVariantLayout*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = fcmp oeq double %t15, %index
  %t17 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then6, label %else7
then6:
  %t19 = load double, double* %l1
  %t20 = fptosi double %t19 to i64
  %t21 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t22 = extractvalue { %NativeEnumVariantLayout*, i64 } %t21, 0
  %t23 = extractvalue { %NativeEnumVariantLayout*, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t20, i64 %t23)
  %t25 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t22, i64 %t20
  %t26 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t25
  store %NativeEnumVariantLayout %t26, %NativeEnumVariantLayout* %l2
  %t27 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t28 = extractvalue %NativeEnumVariantLayout %t27, 0
  %t29 = insertvalue %NativeEnumVariantLayout undef, i8* %t28, 0
  %t30 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t31 = extractvalue %NativeEnumVariantLayout %t30, 1
  %t32 = insertvalue %NativeEnumVariantLayout %t29, double %t31, 1
  %t33 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t34 = extractvalue %NativeEnumVariantLayout %t33, 2
  %t35 = insertvalue %NativeEnumVariantLayout %t32, double %t34, 2
  %t36 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t37 = extractvalue %NativeEnumVariantLayout %t36, 3
  %t38 = insertvalue %NativeEnumVariantLayout %t35, double %t37, 3
  %t39 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t40 = extractvalue %NativeEnumVariantLayout %t39, 4
  %t41 = insertvalue %NativeEnumVariantLayout %t38, double %t40, 4
  %t42 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t43 = extractvalue %NativeEnumVariantLayout %t42, 5
  %t44 = bitcast { %NativeStructLayoutField**, i64 }* %t43 to { %NativeStructLayoutField*, i64 }*
  %t45 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t44, %NativeStructLayoutField %field)
  %t46 = bitcast { %NativeStructLayoutField*, i64 }* %t45 to { %NativeStructLayoutField**, i64 }*
  %t47 = insertvalue %NativeEnumVariantLayout %t41, { %NativeStructLayoutField**, i64 }* %t46, 5
  store %NativeEnumVariantLayout %t47, %NativeEnumVariantLayout* %l3
  %t48 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t49 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l3
  %t50 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t48, %NativeEnumVariantLayout %t49)
  store { %NativeEnumVariantLayout*, i64 }* %t50, { %NativeEnumVariantLayout*, i64 }** %l0
  %t51 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  br label %merge8
else7:
  %t52 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t53 = load double, double* %l1
  %t54 = fptosi double %t53 to i64
  %t55 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t56 = extractvalue { %NativeEnumVariantLayout*, i64 } %t55, 0
  %t57 = extractvalue { %NativeEnumVariantLayout*, i64 } %t55, 1
  %t58 = icmp uge i64 %t54, %t57
  ; bounds check: %t58 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t54, i64 %t57)
  %t59 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t56, i64 %t54
  %t60 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t59
  %t61 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t52, %NativeEnumVariantLayout %t60)
  store { %NativeEnumVariantLayout*, i64 }* %t61, { %NativeEnumVariantLayout*, i64 }** %l0
  %t62 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  br label %merge8
merge8:
  %t63 = phi { %NativeEnumVariantLayout*, i64 }* [ %t51, %then6 ], [ %t62, %else7 ]
  store { %NativeEnumVariantLayout*, i64 }* %t63, { %NativeEnumVariantLayout*, i64 }** %l0
  %t64 = load double, double* %l1
  %t65 = sitofp i64 1 to double
  %t66 = fadd double %t64, %t65
  store double %t66, double* %l1
  br label %loop.latch2
loop.latch2:
  %t67 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t68 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t71 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t72 = load double, double* %l1
  %t73 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  ret { %NativeEnumVariantLayout*, i64 }* %t73
}

define %NativeFunction @append_parameter(%NativeFunction %function, %NativeParameter %parameter) {
entry:
  %l0 = alloca { %NativeParameter*, i64 }*
  %t0 = extractvalue %NativeFunction %function, 1
  %t1 = bitcast { %NativeParameter**, i64 }* %t0 to { %NativeParameter*, i64 }*
  %t2 = call { %NativeParameter*, i64 }* @append_parameter_array({ %NativeParameter*, i64 }* %t1, %NativeParameter %parameter)
  store { %NativeParameter*, i64 }* %t2, { %NativeParameter*, i64 }** %l0
  %t3 = extractvalue %NativeFunction %function, 0
  %t4 = insertvalue %NativeFunction undef, i8* %t3, 0
  %t5 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l0
  %t6 = bitcast { %NativeParameter*, i64 }* %t5 to { %NativeParameter**, i64 }*
  %t7 = insertvalue %NativeFunction %t4, { %NativeParameter**, i64 }* %t6, 1
  %t8 = extractvalue %NativeFunction %function, 2
  %t9 = insertvalue %NativeFunction %t7, i8* %t8, 2
  %t10 = extractvalue %NativeFunction %function, 3
  %t11 = insertvalue %NativeFunction %t9, { i8**, i64 }* %t10, 3
  %t12 = extractvalue %NativeFunction %function, 4
  %t13 = insertvalue %NativeFunction %t11, { %NativeInstruction**, i64 }* %t12, 4
  ret %NativeFunction %t13
}

define %NativeFunction @append_instruction(%NativeFunction %function, %NativeInstruction %instruction) {
entry:
  %l0 = alloca { i8**, i64 }*
  %t0 = extractvalue %NativeFunction %function, 4
  %t1 = call noalias i8* @malloc(i64 56)
  %t2 = bitcast i8* %t1 to %NativeInstruction*
  store %NativeInstruction %instruction, %NativeInstruction* %t2
  %t3 = alloca [1 x i8*]
  %t4 = getelementptr [1 x i8*], [1 x i8*]* %t3, i32 0, i32 0
  %t5 = getelementptr i8*, i8** %t4, i64 0
  store i8* %t1, i8** %t5
  %t6 = alloca { i8**, i64 }
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 0
  store i8** %t4, i8*** %t7
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 1
  store i64 1, i64* %t8
  %t9 = bitcast { %NativeInstruction**, i64 }* %t0 to { i8**, i64 }*
  %t10 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t9, { i8**, i64 }* %t6)
  store { i8**, i64 }* %t10, { i8**, i64 }** %l0
  %t11 = extractvalue %NativeFunction %function, 0
  %t12 = insertvalue %NativeFunction undef, i8* %t11, 0
  %t13 = extractvalue %NativeFunction %function, 1
  %t14 = insertvalue %NativeFunction %t12, { %NativeParameter**, i64 }* %t13, 1
  %t15 = extractvalue %NativeFunction %function, 2
  %t16 = insertvalue %NativeFunction %t14, i8* %t15, 2
  %t17 = extractvalue %NativeFunction %function, 3
  %t18 = insertvalue %NativeFunction %t16, { i8**, i64 }* %t17, 3
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = bitcast { i8**, i64 }* %t19 to { %NativeInstruction**, i64 }*
  %t21 = insertvalue %NativeFunction %t18, { %NativeInstruction**, i64 }* %t20, 4
  ret %NativeFunction %t21
}

define %NativeBinding @binding_from_instruction(%NativeInstruction %instruction) {
entry:
  %t0 = extractvalue %NativeInstruction %instruction, 0
  %t1 = alloca %NativeInstruction
  store %NativeInstruction %instruction, %NativeInstruction* %t1
  %t2 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = bitcast i8* %t3 to i8**
  %t5 = load i8*, i8** %t4
  %t6 = icmp eq i32 %t0, 2
  %t7 = select i1 %t6, i8* %t5, i8* null
  %t8 = insertvalue %NativeBinding undef, i8* %t7, 0
  %t9 = extractvalue %NativeInstruction %instruction, 0
  %t10 = alloca %NativeInstruction
  store %NativeInstruction %instruction, %NativeInstruction* %t10
  %t11 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t10, i32 0, i32 1
  %t12 = bitcast [48 x i8]* %t11 to i8*
  %t13 = getelementptr inbounds i8, i8* %t12, i64 8
  %t14 = bitcast i8* %t13 to i1*
  %t15 = load i1, i1* %t14
  %t16 = icmp eq i32 %t9, 2
  %t17 = select i1 %t16, i1 %t15, i1 false
  %t18 = insertvalue %NativeBinding %t8, i1 %t17, 1
  %t19 = extractvalue %NativeInstruction %instruction, 0
  %t20 = alloca %NativeInstruction
  store %NativeInstruction %instruction, %NativeInstruction* %t20
  %t21 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t22 = bitcast [48 x i8]* %t21 to i8*
  %t23 = getelementptr inbounds i8, i8* %t22, i64 16
  %t24 = bitcast i8* %t23 to i8**
  %t25 = load i8*, i8** %t24
  %t26 = icmp eq i32 %t19, 2
  %t27 = select i1 %t26, i8* %t25, i8* null
  %t28 = insertvalue %NativeBinding %t18, i8* %t27, 2
  %t29 = extractvalue %NativeInstruction %instruction, 0
  %t30 = alloca %NativeInstruction
  store %NativeInstruction %instruction, %NativeInstruction* %t30
  %t31 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t30, i32 0, i32 1
  %t32 = bitcast [48 x i8]* %t31 to i8*
  %t33 = getelementptr inbounds i8, i8* %t32, i64 24
  %t34 = bitcast i8* %t33 to i8**
  %t35 = load i8*, i8** %t34
  %t36 = icmp eq i32 %t29, 2
  %t37 = select i1 %t36, i8* %t35, i8* null
  %t38 = insertvalue %NativeBinding %t28, i8* %t37, 3
  ret %NativeBinding %t38
}

define %NativeFunction @apply_meta(%NativeFunction %function, i8* %entry) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca { i8**, i64 }*
  %t0 = call i8* @trim_text(i8* %entry)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h655348872, i32 0, i32 0
  %t3 = call i1 @starts_with(i8* %t1, i8* %s2)
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %s6 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h655348872, i32 0, i32 0
  %t7 = call i8* @strip_prefix(i8* %t5, i8* %s6)
  %t8 = call i8* @trim_text(i8* %t7)
  store i8* %t8, i8** %l1
  %t9 = load i8*, i8** %l1
  %t10 = extractvalue %NativeFunction %function, 3
  %t11 = call %NativeFunction @update_function_meta(%NativeFunction %function, i8* %t9, { i8**, i64 }* %t10)
  ret %NativeFunction %t11
merge1:
  %t12 = load i8*, i8** %l0
  %s13 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h787332764, i32 0, i32 0
  %t14 = call i1 @starts_with(i8* %t12, i8* %s13)
  %t15 = load i8*, i8** %l0
  br i1 %t14, label %then2, label %merge3
then2:
  %t16 = load i8*, i8** %l0
  %s17 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h787332764, i32 0, i32 0
  %t18 = call i8* @strip_prefix(i8* %t16, i8* %s17)
  %t19 = call i8* @trim_text(i8* %t18)
  store i8* %t19, i8** %l2
  %t20 = load i8*, i8** %l2
  %t21 = call { i8**, i64 }* @parse_effect_list(i8* %t20)
  store { i8**, i64 }* %t21, { i8**, i64 }** %l3
  %t22 = extractvalue %NativeFunction %function, 2
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t24 = call %NativeFunction @update_function_meta(%NativeFunction %function, i8* %t22, { i8**, i64 }* %t23)
  ret %NativeFunction %t24
merge3:
  ret %NativeFunction %function
}

define %NativeFunction @update_function_meta(%NativeFunction %function, i8* %return_type, { i8**, i64 }* %effects) {
entry:
  %t0 = extractvalue %NativeFunction %function, 0
  %t1 = insertvalue %NativeFunction undef, i8* %t0, 0
  %t2 = extractvalue %NativeFunction %function, 1
  %t3 = insertvalue %NativeFunction %t1, { %NativeParameter**, i64 }* %t2, 1
  %t4 = insertvalue %NativeFunction %t3, i8* %return_type, 2
  %t5 = insertvalue %NativeFunction %t4, { i8**, i64 }* %effects, 3
  %t6 = extractvalue %NativeFunction %function, 4
  %t7 = insertvalue %NativeFunction %t5, { %NativeInstruction**, i64 }* %t6, 4
  ret %NativeFunction %t7
}

define %InstructionGatherResult @gather_instruction({ i8**, i64 }* %lines, double %start_index) {
entry:
  %l0 = alloca i8*
  %l1 = alloca %InstructionDepthState
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %t0 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = sitofp i64 %t1 to double
  %t3 = fcmp oge double %start_index, %t2
  br i1 %t3, label %then0, label %merge1
then0:
  %s4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t5 = insertvalue %InstructionGatherResult undef, i8* %s4, 0
  %t6 = sitofp i64 0 to double
  %t7 = insertvalue %InstructionGatherResult %t5, double %t6, 1
  ret %InstructionGatherResult %t7
merge1:
  %t8 = fptosi double %start_index to i64
  %t9 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t10 = extractvalue { i8**, i64 } %t9, 0
  %t11 = extractvalue { i8**, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t8, i64 %t11)
  %t13 = getelementptr i8*, i8** %t10, i64 %t8
  %t14 = load i8*, i8** %t13
  %t15 = call i8* @trim_text(i8* %t14)
  store i8* %t15, i8** %l0
  %t16 = load i8*, i8** %l0
  %t17 = call i64 @sailfin_runtime_string_length(i8* %t16)
  %t18 = icmp eq i64 %t17, 0
  %t19 = load i8*, i8** %l0
  br i1 %t18, label %then2, label %merge3
then2:
  %t20 = load i8*, i8** %l0
  %t21 = insertvalue %InstructionGatherResult undef, i8* %t20, 0
  %t22 = sitofp i64 0 to double
  %t23 = insertvalue %InstructionGatherResult %t21, double %t22, 1
  ret %InstructionGatherResult %t23
merge3:
  %t24 = load i8*, i8** %l0
  %t25 = call i1 @instruction_supports_multiline(i8* %t24)
  %t26 = xor i1 %t25, 1
  %t27 = load i8*, i8** %l0
  br i1 %t26, label %then4, label %merge5
then4:
  %t28 = load i8*, i8** %l0
  %t29 = insertvalue %InstructionGatherResult undef, i8* %t28, 0
  %t30 = sitofp i64 0 to double
  %t31 = insertvalue %InstructionGatherResult %t29, double %t30, 1
  ret %InstructionGatherResult %t31
merge5:
  %t32 = call %InstructionDepthState @initial_instruction_depth_state()
  %t33 = load i8*, i8** %l0
  %t34 = call %InstructionDepthState @update_instruction_depth_state(%InstructionDepthState %t32, i8* %t33)
  store %InstructionDepthState %t34, %InstructionDepthState* %l1
  %t35 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t36 = call i1 @instruction_requires_continuation(%InstructionDepthState %t35)
  %t37 = xor i1 %t36, 1
  %t38 = load i8*, i8** %l0
  %t39 = load %InstructionDepthState, %InstructionDepthState* %l1
  br i1 %t37, label %then6, label %merge7
then6:
  %t40 = load i8*, i8** %l0
  %t41 = insertvalue %InstructionGatherResult undef, i8* %t40, 0
  %t42 = sitofp i64 0 to double
  %t43 = insertvalue %InstructionGatherResult %t41, double %t42, 1
  ret %InstructionGatherResult %t43
merge7:
  %t44 = load i8*, i8** %l0
  store i8* %t44, i8** %l2
  %t45 = sitofp i64 0 to double
  store double %t45, double* %l3
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %start_index, %t46
  store double %t47, double* %l4
  %t48 = load i8*, i8** %l0
  %t49 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t50 = load i8*, i8** %l2
  %t51 = load double, double* %l3
  %t52 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t125 = phi i8* [ %t50, %merge7 ], [ %t121, %loop.latch10 ]
  %t126 = phi %InstructionDepthState [ %t49, %merge7 ], [ %t122, %loop.latch10 ]
  %t127 = phi double [ %t51, %merge7 ], [ %t123, %loop.latch10 ]
  %t128 = phi double [ %t52, %merge7 ], [ %t124, %loop.latch10 ]
  store i8* %t125, i8** %l2
  store %InstructionDepthState %t126, %InstructionDepthState* %l1
  store double %t127, double* %l3
  store double %t128, double* %l4
  br label %loop.body9
loop.body9:
  %t53 = load double, double* %l4
  %t54 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t55 = extractvalue { i8**, i64 } %t54, 1
  %t56 = sitofp i64 %t55 to double
  %t57 = fcmp oge double %t53, %t56
  %t58 = load i8*, i8** %l0
  %t59 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t60 = load i8*, i8** %l2
  %t61 = load double, double* %l3
  %t62 = load double, double* %l4
  br i1 %t57, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t63 = load double, double* %l4
  %t64 = fptosi double %t63 to i64
  %t65 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t66 = extractvalue { i8**, i64 } %t65, 0
  %t67 = extractvalue { i8**, i64 } %t65, 1
  %t68 = icmp uge i64 %t64, %t67
  ; bounds check: %t68 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t64, i64 %t67)
  %t69 = getelementptr i8*, i8** %t66, i64 %t64
  %t70 = load i8*, i8** %t69
  %t71 = call i8* @trim_text(i8* %t70)
  store i8* %t71, i8** %l5
  %t72 = load i8*, i8** %l5
  %t73 = call i64 @sailfin_runtime_string_length(i8* %t72)
  %t74 = icmp eq i64 %t73, 0
  %t75 = load i8*, i8** %l0
  %t76 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t77 = load i8*, i8** %l2
  %t78 = load double, double* %l3
  %t79 = load double, double* %l4
  %t80 = load i8*, i8** %l5
  br i1 %t74, label %then14, label %else15
then14:
  %t81 = load i8*, i8** %l2
  %t82 = load i8, i8* %t81
  %t83 = add i8 %t82, 10
  %t84 = alloca [2 x i8], align 1
  %t85 = getelementptr [2 x i8], [2 x i8]* %t84, i32 0, i32 0
  store i8 %t83, i8* %t85
  %t86 = getelementptr [2 x i8], [2 x i8]* %t84, i32 0, i32 1
  store i8 0, i8* %t86
  %t87 = getelementptr [2 x i8], [2 x i8]* %t84, i32 0, i32 0
  store i8* %t87, i8** %l2
  %t88 = load i8*, i8** %l2
  br label %merge16
else15:
  %t89 = load i8*, i8** %l2
  %t90 = load i8, i8* %t89
  %t91 = add i8 %t90, 10
  %t92 = load i8*, i8** %l5
  %t93 = load i8, i8* %t92
  %t94 = add i8 %t91, %t93
  %t95 = alloca [2 x i8], align 1
  %t96 = getelementptr [2 x i8], [2 x i8]* %t95, i32 0, i32 0
  store i8 %t94, i8* %t96
  %t97 = getelementptr [2 x i8], [2 x i8]* %t95, i32 0, i32 1
  store i8 0, i8* %t97
  %t98 = getelementptr [2 x i8], [2 x i8]* %t95, i32 0, i32 0
  store i8* %t98, i8** %l2
  %t99 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t100 = load i8*, i8** %l5
  %t101 = call %InstructionDepthState @update_instruction_depth_state(%InstructionDepthState %t99, i8* %t100)
  store %InstructionDepthState %t101, %InstructionDepthState* %l1
  %t102 = load i8*, i8** %l2
  %t103 = load %InstructionDepthState, %InstructionDepthState* %l1
  br label %merge16
merge16:
  %t104 = phi i8* [ %t88, %then14 ], [ %t102, %else15 ]
  %t105 = phi %InstructionDepthState [ %t76, %then14 ], [ %t103, %else15 ]
  store i8* %t104, i8** %l2
  store %InstructionDepthState %t105, %InstructionDepthState* %l1
  %t106 = load double, double* %l3
  %t107 = sitofp i64 1 to double
  %t108 = fadd double %t106, %t107
  store double %t108, double* %l3
  %t109 = load double, double* %l4
  %t110 = sitofp i64 1 to double
  %t111 = fadd double %t109, %t110
  store double %t111, double* %l4
  %t112 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t113 = call i1 @instruction_requires_continuation(%InstructionDepthState %t112)
  %t114 = xor i1 %t113, 1
  %t115 = load i8*, i8** %l0
  %t116 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t117 = load i8*, i8** %l2
  %t118 = load double, double* %l3
  %t119 = load double, double* %l4
  %t120 = load i8*, i8** %l5
  br i1 %t114, label %then17, label %merge18
then17:
  br label %afterloop11
merge18:
  br label %loop.latch10
loop.latch10:
  %t121 = load i8*, i8** %l2
  %t122 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t123 = load double, double* %l3
  %t124 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t129 = load i8*, i8** %l2
  %t130 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t131 = load double, double* %l3
  %t132 = load double, double* %l4
  %t133 = load i8*, i8** %l2
  %t134 = call i8* @trim_text(i8* %t133)
  store i8* %t134, i8** %l6
  %t135 = load i8*, i8** %l6
  %t136 = insertvalue %InstructionGatherResult undef, i8* %t135, 0
  %t137 = load double, double* %l3
  %t138 = insertvalue %InstructionGatherResult %t136, double %t137, 1
  ret %InstructionGatherResult %t138
}

define i1 @instruction_supports_multiline(i8* %line) {
entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2080793783, i32 0, i32 0
  %t1 = call i1 @starts_with(i8* %line, i8* %s0)
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h273104342, i32 0, i32 0
  %t3 = call i1 @starts_with(i8* %line, i8* %s2)
  br i1 %t3, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  ret i1 0
}

define i1 @instruction_requires_continuation(%InstructionDepthState %state) {
entry:
  %t0 = extractvalue %InstructionDepthState %state, 3
  br i1 %t0, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t1 = extractvalue %InstructionDepthState %state, 0
  %t2 = sitofp i64 0 to double
  %t3 = fcmp ogt double %t1, %t2
  br i1 %t3, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %t4 = extractvalue %InstructionDepthState %state, 1
  %t5 = sitofp i64 0 to double
  %t6 = fcmp ogt double %t4, %t5
  br i1 %t6, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t7 = extractvalue %InstructionDepthState %state, 2
  %t8 = sitofp i64 0 to double
  %t9 = fcmp ogt double %t7, %t8
  br i1 %t9, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  ret i1 0
}

define %InstructionDepthState @initial_instruction_depth_state() {
entry:
  %t0 = sitofp i64 0 to double
  %t1 = insertvalue %InstructionDepthState undef, double %t0, 0
  %t2 = sitofp i64 0 to double
  %t3 = insertvalue %InstructionDepthState %t1, double %t2, 1
  %t4 = sitofp i64 0 to double
  %t5 = insertvalue %InstructionDepthState %t3, double %t4, 2
  %t6 = insertvalue %InstructionDepthState %t5, i1 0, 3
  %t7 = insertvalue %InstructionDepthState %t6, i1 0, 4
  ret %InstructionDepthState %t7
}

define %InstructionDepthState @update_instruction_depth_state(%InstructionDepthState %state, i8* %text) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i1
  %l4 = alloca i1
  %l5 = alloca double
  %l6 = alloca i8
  %t0 = extractvalue %InstructionDepthState %state, 0
  store double %t0, double* %l0
  %t1 = extractvalue %InstructionDepthState %state, 1
  store double %t1, double* %l1
  %t2 = extractvalue %InstructionDepthState %state, 2
  store double %t2, double* %l2
  %t3 = extractvalue %InstructionDepthState %state, 3
  store i1 %t3, i1* %l3
  %t4 = extractvalue %InstructionDepthState %state, 4
  store i1 %t4, i1* %l4
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l5
  %t6 = load double, double* %l0
  %t7 = load double, double* %l1
  %t8 = load double, double* %l2
  %t9 = load i1, i1* %l3
  %t10 = load i1, i1* %l4
  %t11 = load double, double* %l5
  br label %loop.header0
loop.header0:
  %t218 = phi i1 [ %t10, %entry ], [ %t212, %loop.latch2 ]
  %t219 = phi double [ %t11, %entry ], [ %t213, %loop.latch2 ]
  %t220 = phi i1 [ %t9, %entry ], [ %t214, %loop.latch2 ]
  %t221 = phi double [ %t6, %entry ], [ %t215, %loop.latch2 ]
  %t222 = phi double [ %t7, %entry ], [ %t216, %loop.latch2 ]
  %t223 = phi double [ %t8, %entry ], [ %t217, %loop.latch2 ]
  store i1 %t218, i1* %l4
  store double %t219, double* %l5
  store i1 %t220, i1* %l3
  store double %t221, double* %l0
  store double %t222, double* %l1
  store double %t223, double* %l2
  br label %loop.body1
loop.body1:
  %t12 = load double, double* %l5
  %t13 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t14 = sitofp i64 %t13 to double
  %t15 = fcmp oge double %t12, %t14
  %t16 = load double, double* %l0
  %t17 = load double, double* %l1
  %t18 = load double, double* %l2
  %t19 = load i1, i1* %l3
  %t20 = load i1, i1* %l4
  %t21 = load double, double* %l5
  br i1 %t15, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l5
  %t23 = fptosi double %t22 to i64
  %t24 = getelementptr i8, i8* %text, i64 %t23
  %t25 = load i8, i8* %t24
  store i8 %t25, i8* %l6
  %t26 = load i1, i1* %l3
  %t27 = load double, double* %l0
  %t28 = load double, double* %l1
  %t29 = load double, double* %l2
  %t30 = load i1, i1* %l3
  %t31 = load i1, i1* %l4
  %t32 = load double, double* %l5
  %t33 = load i8, i8* %l6
  br i1 %t26, label %then6, label %merge7
then6:
  %t34 = load i1, i1* %l4
  %t35 = load double, double* %l0
  %t36 = load double, double* %l1
  %t37 = load double, double* %l2
  %t38 = load i1, i1* %l3
  %t39 = load i1, i1* %l4
  %t40 = load double, double* %l5
  %t41 = load i8, i8* %l6
  br i1 %t34, label %then8, label %merge9
then8:
  store i1 0, i1* %l4
  %t42 = load double, double* %l5
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  store double %t44, double* %l5
  br label %loop.latch2
merge9:
  %t45 = load i8, i8* %l6
  %t46 = icmp eq i8 %t45, 92
  %t47 = load double, double* %l0
  %t48 = load double, double* %l1
  %t49 = load double, double* %l2
  %t50 = load i1, i1* %l3
  %t51 = load i1, i1* %l4
  %t52 = load double, double* %l5
  %t53 = load i8, i8* %l6
  br i1 %t46, label %then10, label %merge11
then10:
  store i1 1, i1* %l4
  %t54 = load double, double* %l5
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %t54, %t55
  store double %t56, double* %l5
  br label %loop.latch2
merge11:
  %t57 = load i8, i8* %l6
  %t58 = icmp eq i8 %t57, 34
  %t59 = load double, double* %l0
  %t60 = load double, double* %l1
  %t61 = load double, double* %l2
  %t62 = load i1, i1* %l3
  %t63 = load i1, i1* %l4
  %t64 = load double, double* %l5
  %t65 = load i8, i8* %l6
  br i1 %t58, label %then12, label %merge13
then12:
  store i1 0, i1* %l3
  %t66 = load i1, i1* %l3
  br label %merge13
merge13:
  %t67 = phi i1 [ %t66, %then12 ], [ %t62, %merge11 ]
  store i1 %t67, i1* %l3
  %t68 = load double, double* %l5
  %t69 = sitofp i64 1 to double
  %t70 = fadd double %t68, %t69
  store double %t70, double* %l5
  br label %loop.latch2
merge7:
  %t71 = load i8, i8* %l6
  %t72 = icmp eq i8 %t71, 34
  %t73 = load double, double* %l0
  %t74 = load double, double* %l1
  %t75 = load double, double* %l2
  %t76 = load i1, i1* %l3
  %t77 = load i1, i1* %l4
  %t78 = load double, double* %l5
  %t79 = load i8, i8* %l6
  br i1 %t72, label %then14, label %merge15
then14:
  store i1 1, i1* %l3
  %t80 = load double, double* %l5
  %t81 = sitofp i64 1 to double
  %t82 = fadd double %t80, %t81
  store double %t82, double* %l5
  br label %loop.latch2
merge15:
  %t83 = load i8, i8* %l6
  %t84 = icmp eq i8 %t83, 40
  %t85 = load double, double* %l0
  %t86 = load double, double* %l1
  %t87 = load double, double* %l2
  %t88 = load i1, i1* %l3
  %t89 = load i1, i1* %l4
  %t90 = load double, double* %l5
  %t91 = load i8, i8* %l6
  br i1 %t84, label %then16, label %merge17
then16:
  %t92 = load double, double* %l0
  %t93 = sitofp i64 1 to double
  %t94 = fadd double %t92, %t93
  store double %t94, double* %l0
  %t95 = load double, double* %l5
  %t96 = sitofp i64 1 to double
  %t97 = fadd double %t95, %t96
  store double %t97, double* %l5
  br label %loop.latch2
merge17:
  %t98 = load i8, i8* %l6
  %t99 = icmp eq i8 %t98, 41
  %t100 = load double, double* %l0
  %t101 = load double, double* %l1
  %t102 = load double, double* %l2
  %t103 = load i1, i1* %l3
  %t104 = load i1, i1* %l4
  %t105 = load double, double* %l5
  %t106 = load i8, i8* %l6
  br i1 %t99, label %then18, label %merge19
then18:
  %t107 = load double, double* %l0
  %t108 = sitofp i64 0 to double
  %t109 = fcmp ogt double %t107, %t108
  %t110 = load double, double* %l0
  %t111 = load double, double* %l1
  %t112 = load double, double* %l2
  %t113 = load i1, i1* %l3
  %t114 = load i1, i1* %l4
  %t115 = load double, double* %l5
  %t116 = load i8, i8* %l6
  br i1 %t109, label %then20, label %merge21
then20:
  %t117 = load double, double* %l0
  %t118 = sitofp i64 1 to double
  %t119 = fsub double %t117, %t118
  store double %t119, double* %l0
  %t120 = load double, double* %l0
  br label %merge21
merge21:
  %t121 = phi double [ %t120, %then20 ], [ %t110, %then18 ]
  store double %t121, double* %l0
  %t122 = load double, double* %l5
  %t123 = sitofp i64 1 to double
  %t124 = fadd double %t122, %t123
  store double %t124, double* %l5
  br label %loop.latch2
merge19:
  %t125 = load i8, i8* %l6
  %t126 = icmp eq i8 %t125, 91
  %t127 = load double, double* %l0
  %t128 = load double, double* %l1
  %t129 = load double, double* %l2
  %t130 = load i1, i1* %l3
  %t131 = load i1, i1* %l4
  %t132 = load double, double* %l5
  %t133 = load i8, i8* %l6
  br i1 %t126, label %then22, label %merge23
then22:
  %t134 = load double, double* %l1
  %t135 = sitofp i64 1 to double
  %t136 = fadd double %t134, %t135
  store double %t136, double* %l1
  %t137 = load double, double* %l5
  %t138 = sitofp i64 1 to double
  %t139 = fadd double %t137, %t138
  store double %t139, double* %l5
  br label %loop.latch2
merge23:
  %t140 = load i8, i8* %l6
  %t141 = icmp eq i8 %t140, 93
  %t142 = load double, double* %l0
  %t143 = load double, double* %l1
  %t144 = load double, double* %l2
  %t145 = load i1, i1* %l3
  %t146 = load i1, i1* %l4
  %t147 = load double, double* %l5
  %t148 = load i8, i8* %l6
  br i1 %t141, label %then24, label %merge25
then24:
  %t149 = load double, double* %l1
  %t150 = sitofp i64 0 to double
  %t151 = fcmp ogt double %t149, %t150
  %t152 = load double, double* %l0
  %t153 = load double, double* %l1
  %t154 = load double, double* %l2
  %t155 = load i1, i1* %l3
  %t156 = load i1, i1* %l4
  %t157 = load double, double* %l5
  %t158 = load i8, i8* %l6
  br i1 %t151, label %then26, label %merge27
then26:
  %t159 = load double, double* %l1
  %t160 = sitofp i64 1 to double
  %t161 = fsub double %t159, %t160
  store double %t161, double* %l1
  %t162 = load double, double* %l1
  br label %merge27
merge27:
  %t163 = phi double [ %t162, %then26 ], [ %t153, %then24 ]
  store double %t163, double* %l1
  %t164 = load double, double* %l5
  %t165 = sitofp i64 1 to double
  %t166 = fadd double %t164, %t165
  store double %t166, double* %l5
  br label %loop.latch2
merge25:
  %t167 = load i8, i8* %l6
  %t168 = icmp eq i8 %t167, 123
  %t169 = load double, double* %l0
  %t170 = load double, double* %l1
  %t171 = load double, double* %l2
  %t172 = load i1, i1* %l3
  %t173 = load i1, i1* %l4
  %t174 = load double, double* %l5
  %t175 = load i8, i8* %l6
  br i1 %t168, label %then28, label %merge29
then28:
  %t176 = load double, double* %l2
  %t177 = sitofp i64 1 to double
  %t178 = fadd double %t176, %t177
  store double %t178, double* %l2
  %t179 = load double, double* %l5
  %t180 = sitofp i64 1 to double
  %t181 = fadd double %t179, %t180
  store double %t181, double* %l5
  br label %loop.latch2
merge29:
  %t182 = load i8, i8* %l6
  %t183 = icmp eq i8 %t182, 125
  %t184 = load double, double* %l0
  %t185 = load double, double* %l1
  %t186 = load double, double* %l2
  %t187 = load i1, i1* %l3
  %t188 = load i1, i1* %l4
  %t189 = load double, double* %l5
  %t190 = load i8, i8* %l6
  br i1 %t183, label %then30, label %merge31
then30:
  %t191 = load double, double* %l2
  %t192 = sitofp i64 0 to double
  %t193 = fcmp ogt double %t191, %t192
  %t194 = load double, double* %l0
  %t195 = load double, double* %l1
  %t196 = load double, double* %l2
  %t197 = load i1, i1* %l3
  %t198 = load i1, i1* %l4
  %t199 = load double, double* %l5
  %t200 = load i8, i8* %l6
  br i1 %t193, label %then32, label %merge33
then32:
  %t201 = load double, double* %l2
  %t202 = sitofp i64 1 to double
  %t203 = fsub double %t201, %t202
  store double %t203, double* %l2
  %t204 = load double, double* %l2
  br label %merge33
merge33:
  %t205 = phi double [ %t204, %then32 ], [ %t196, %then30 ]
  store double %t205, double* %l2
  %t206 = load double, double* %l5
  %t207 = sitofp i64 1 to double
  %t208 = fadd double %t206, %t207
  store double %t208, double* %l5
  br label %loop.latch2
merge31:
  %t209 = load double, double* %l5
  %t210 = sitofp i64 1 to double
  %t211 = fadd double %t209, %t210
  store double %t211, double* %l5
  br label %loop.latch2
loop.latch2:
  %t212 = load i1, i1* %l4
  %t213 = load double, double* %l5
  %t214 = load i1, i1* %l3
  %t215 = load double, double* %l0
  %t216 = load double, double* %l1
  %t217 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t224 = load i1, i1* %l4
  %t225 = load double, double* %l5
  %t226 = load i1, i1* %l3
  %t227 = load double, double* %l0
  %t228 = load double, double* %l1
  %t229 = load double, double* %l2
  %t230 = load double, double* %l0
  %t231 = insertvalue %InstructionDepthState undef, double %t230, 0
  %t232 = load double, double* %l1
  %t233 = insertvalue %InstructionDepthState %t231, double %t232, 1
  %t234 = load double, double* %l2
  %t235 = insertvalue %InstructionDepthState %t233, double %t234, 2
  %t236 = load i1, i1* %l3
  %t237 = insertvalue %InstructionDepthState %t235, i1 %t236, 3
  %t238 = load i1, i1* %l4
  %t239 = insertvalue %InstructionDepthState %t237, i1 %t238, 4
  ret %InstructionDepthState %t239
}

define %InstructionParseResult @parse_instruction(i8* %line, %NativeSourceSpan* %span, %NativeSourceSpan* %value_span) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca i8
  %l10 = alloca i8*
  %l11 = alloca i8*
  %l12 = alloca i1
  %l13 = alloca %BindingComponents
  %s0 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t1 = icmp eq i8* %line, %s0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = insertvalue %NativeInstruction undef, i32 15, 0
  %t3 = call noalias i8* @malloc(i64 56)
  %t4 = bitcast i8* %t3 to %NativeInstruction*
  store %NativeInstruction %t2, %NativeInstruction* %t4
  %t5 = bitcast i8* %t3 to %NativeInstruction*
  %t6 = alloca [1 x %NativeInstruction*]
  %t7 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* %t6, i32 0, i32 0
  %t8 = getelementptr %NativeInstruction*, %NativeInstruction** %t7, i64 0
  store %NativeInstruction* %t5, %NativeInstruction** %t8
  %t9 = alloca { %NativeInstruction**, i64 }
  %t10 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t9, i32 0, i32 0
  store %NativeInstruction** %t7, %NativeInstruction*** %t10
  %t11 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t9, i32 0, i32 1
  store i64 1, i64* %t11
  %t12 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t9, 0
  %t13 = insertvalue %InstructionParseResult %t12, i1 0, 1
  %t14 = insertvalue %InstructionParseResult %t13, i1 0, 2
  ret %InstructionParseResult %t14
merge1:
  %s15 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h192590216, i32 0, i32 0
  %t16 = call i1 @starts_with(i8* %line, i8* %s15)
  br i1 %t16, label %then2, label %merge3
then2:
  %s17 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h192590216, i32 0, i32 0
  %t18 = call i8* @strip_prefix(i8* %line, i8* %s17)
  %t19 = call i8* @trim_text(i8* %t18)
  store i8* %t19, i8** %l0
  %t20 = alloca %NativeInstruction
  %t21 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 0
  store i32 3, i32* %t21
  %t22 = load i8*, i8** %l0
  %t23 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t24 = bitcast [8 x i8]* %t23 to i8*
  %t25 = bitcast i8* %t24 to i8**
  store i8* %t22, i8** %t25
  %t26 = load %NativeInstruction, %NativeInstruction* %t20
  %t27 = alloca [1 x %NativeInstruction]
  %t28 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t27, i32 0, i32 0
  %t29 = getelementptr %NativeInstruction, %NativeInstruction* %t28, i64 0
  store %NativeInstruction %t26, %NativeInstruction* %t29
  %t30 = alloca { %NativeInstruction*, i64 }
  %t31 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t30, i32 0, i32 0
  store %NativeInstruction* %t28, %NativeInstruction** %t31
  %t32 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t30, i32 0, i32 1
  store i64 1, i64* %t32
  %t33 = bitcast { %NativeInstruction*, i64 }* %t30 to { %NativeInstruction**, i64 }*
  %t34 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t33, 0
  %t35 = insertvalue %InstructionParseResult %t34, i1 0, 1
  %t36 = insertvalue %InstructionParseResult %t35, i1 0, 2
  ret %InstructionParseResult %t36
merge3:
  %s37 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2056075365, i32 0, i32 0
  %t38 = icmp eq i8* %line, %s37
  br i1 %t38, label %then4, label %merge5
then4:
  %t39 = insertvalue %NativeInstruction undef, i32 4, 0
  %t40 = call noalias i8* @malloc(i64 56)
  %t41 = bitcast i8* %t40 to %NativeInstruction*
  store %NativeInstruction %t39, %NativeInstruction* %t41
  %t42 = bitcast i8* %t40 to %NativeInstruction*
  %t43 = alloca [1 x %NativeInstruction*]
  %t44 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* %t43, i32 0, i32 0
  %t45 = getelementptr %NativeInstruction*, %NativeInstruction** %t44, i64 0
  store %NativeInstruction* %t42, %NativeInstruction** %t45
  %t46 = alloca { %NativeInstruction**, i64 }
  %t47 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t46, i32 0, i32 0
  store %NativeInstruction** %t44, %NativeInstruction*** %t47
  %t48 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t46, i32 0, i32 1
  store i64 1, i64* %t48
  %t49 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t46, 0
  %t50 = insertvalue %InstructionParseResult %t49, i1 0, 1
  %t51 = insertvalue %InstructionParseResult %t50, i1 0, 2
  ret %InstructionParseResult %t51
merge5:
  %s52 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1280334338, i32 0, i32 0
  %t53 = icmp eq i8* %line, %s52
  br i1 %t53, label %then6, label %merge7
then6:
  %t54 = insertvalue %NativeInstruction undef, i32 5, 0
  %t55 = call noalias i8* @malloc(i64 56)
  %t56 = bitcast i8* %t55 to %NativeInstruction*
  store %NativeInstruction %t54, %NativeInstruction* %t56
  %t57 = bitcast i8* %t55 to %NativeInstruction*
  %t58 = alloca [1 x %NativeInstruction*]
  %t59 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* %t58, i32 0, i32 0
  %t60 = getelementptr %NativeInstruction*, %NativeInstruction** %t59, i64 0
  store %NativeInstruction* %t57, %NativeInstruction** %t60
  %t61 = alloca { %NativeInstruction**, i64 }
  %t62 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t61, i32 0, i32 0
  store %NativeInstruction** %t59, %NativeInstruction*** %t62
  %t63 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t61, i32 0, i32 1
  store i64 1, i64* %t63
  %t64 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t61, 0
  %t65 = insertvalue %InstructionParseResult %t64, i1 0, 1
  %t66 = insertvalue %InstructionParseResult %t65, i1 0, 2
  ret %InstructionParseResult %t66
merge7:
  %s67 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2057365731, i32 0, i32 0
  %t68 = call i1 @starts_with(i8* %line, i8* %s67)
  br i1 %t68, label %then8, label %merge9
then8:
  %s69 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2057365731, i32 0, i32 0
  %t70 = call i8* @strip_prefix(i8* %line, i8* %s69)
  %t71 = call i8* @trim_text(i8* %t70)
  store i8* %t71, i8** %l1
  %s72 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175996034, i32 0, i32 0
  store i8* %s72, i8** %l2
  %t73 = load i8*, i8** %l1
  %t74 = load i8*, i8** %l2
  %t75 = call double @index_of(i8* %t73, i8* %t74)
  store double %t75, double* %l3
  %t76 = load double, double* %l3
  %t77 = sitofp i64 0 to double
  %t78 = fcmp oge double %t76, %t77
  %t79 = load i8*, i8** %l1
  %t80 = load i8*, i8** %l2
  %t81 = load double, double* %l3
  br i1 %t78, label %then10, label %merge11
then10:
  %t82 = load i8*, i8** %l1
  %t83 = load double, double* %l3
  %t84 = fptosi double %t83 to i64
  %t85 = call i8* @sailfin_runtime_substring(i8* %t82, i64 0, i64 %t84)
  %t86 = call i8* @trim_text(i8* %t85)
  store i8* %t86, i8** %l4
  %t87 = load i8*, i8** %l1
  %t88 = load double, double* %l3
  %t89 = load i8*, i8** %l2
  %t90 = call i64 @sailfin_runtime_string_length(i8* %t89)
  %t91 = sitofp i64 %t90 to double
  %t92 = fadd double %t88, %t91
  %t93 = load i8*, i8** %l1
  %t94 = call i64 @sailfin_runtime_string_length(i8* %t93)
  %t95 = fptosi double %t92 to i64
  %t96 = call i8* @sailfin_runtime_substring(i8* %t87, i64 %t95, i64 %t94)
  %t97 = call i8* @trim_text(i8* %t96)
  store i8* %t97, i8** %l5
  %t98 = alloca %NativeInstruction
  %t99 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t98, i32 0, i32 0
  store i32 6, i32* %t99
  %t100 = load i8*, i8** %l4
  %t101 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t98, i32 0, i32 1
  %t102 = bitcast [16 x i8]* %t101 to i8*
  %t103 = bitcast i8* %t102 to i8**
  store i8* %t100, i8** %t103
  %t104 = load i8*, i8** %l5
  %t105 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t98, i32 0, i32 1
  %t106 = bitcast [16 x i8]* %t105 to i8*
  %t107 = getelementptr inbounds i8, i8* %t106, i64 8
  %t108 = bitcast i8* %t107 to i8**
  store i8* %t104, i8** %t108
  %t109 = load %NativeInstruction, %NativeInstruction* %t98
  %t110 = alloca [1 x %NativeInstruction]
  %t111 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t110, i32 0, i32 0
  %t112 = getelementptr %NativeInstruction, %NativeInstruction* %t111, i64 0
  store %NativeInstruction %t109, %NativeInstruction* %t112
  %t113 = alloca { %NativeInstruction*, i64 }
  %t114 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t113, i32 0, i32 0
  store %NativeInstruction* %t111, %NativeInstruction** %t114
  %t115 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t113, i32 0, i32 1
  store i64 1, i64* %t115
  %t116 = bitcast { %NativeInstruction*, i64 }* %t113 to { %NativeInstruction**, i64 }*
  %t117 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t116, 0
  %t118 = insertvalue %InstructionParseResult %t117, i1 0, 1
  %t119 = insertvalue %InstructionParseResult %t118, i1 0, 2
  ret %InstructionParseResult %t119
merge11:
  br label %merge9
merge9:
  %s120 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h1448749422, i32 0, i32 0
  %t121 = icmp eq i8* %line, %s120
  br i1 %t121, label %then12, label %merge13
then12:
  %t122 = insertvalue %NativeInstruction undef, i32 7, 0
  %t123 = call noalias i8* @malloc(i64 56)
  %t124 = bitcast i8* %t123 to %NativeInstruction*
  store %NativeInstruction %t122, %NativeInstruction* %t124
  %t125 = bitcast i8* %t123 to %NativeInstruction*
  %t126 = alloca [1 x %NativeInstruction*]
  %t127 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* %t126, i32 0, i32 0
  %t128 = getelementptr %NativeInstruction*, %NativeInstruction** %t127, i64 0
  store %NativeInstruction* %t125, %NativeInstruction** %t128
  %t129 = alloca { %NativeInstruction**, i64 }
  %t130 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t129, i32 0, i32 0
  store %NativeInstruction** %t127, %NativeInstruction*** %t130
  %t131 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t129, i32 0, i32 1
  store i64 1, i64* %t131
  %t132 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t129, 0
  %t133 = insertvalue %InstructionParseResult %t132, i1 0, 1
  %t134 = insertvalue %InstructionParseResult %t133, i1 0, 2
  ret %InstructionParseResult %t134
merge13:
  %s135 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2064480630, i32 0, i32 0
  %t136 = icmp eq i8* %line, %s135
  br i1 %t136, label %then14, label %merge15
then14:
  %t137 = insertvalue %NativeInstruction undef, i32 8, 0
  %t138 = call noalias i8* @malloc(i64 56)
  %t139 = bitcast i8* %t138 to %NativeInstruction*
  store %NativeInstruction %t137, %NativeInstruction* %t139
  %t140 = bitcast i8* %t138 to %NativeInstruction*
  %t141 = alloca [1 x %NativeInstruction*]
  %t142 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* %t141, i32 0, i32 0
  %t143 = getelementptr %NativeInstruction*, %NativeInstruction** %t142, i64 0
  store %NativeInstruction* %t140, %NativeInstruction** %t143
  %t144 = alloca { %NativeInstruction**, i64 }
  %t145 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t144, i32 0, i32 0
  store %NativeInstruction** %t142, %NativeInstruction*** %t145
  %t146 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t144, i32 0, i32 1
  store i64 1, i64* %t146
  %t147 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t144, 0
  %t148 = insertvalue %InstructionParseResult %t147, i1 0, 1
  %t149 = insertvalue %InstructionParseResult %t148, i1 0, 2
  ret %InstructionParseResult %t149
merge15:
  %s150 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h571206424, i32 0, i32 0
  %t151 = icmp eq i8* %line, %s150
  br i1 %t151, label %then16, label %merge17
then16:
  %t152 = insertvalue %NativeInstruction undef, i32 9, 0
  %t153 = call noalias i8* @malloc(i64 56)
  %t154 = bitcast i8* %t153 to %NativeInstruction*
  store %NativeInstruction %t152, %NativeInstruction* %t154
  %t155 = bitcast i8* %t153 to %NativeInstruction*
  %t156 = alloca [1 x %NativeInstruction*]
  %t157 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* %t156, i32 0, i32 0
  %t158 = getelementptr %NativeInstruction*, %NativeInstruction** %t157, i64 0
  store %NativeInstruction* %t155, %NativeInstruction** %t158
  %t159 = alloca { %NativeInstruction**, i64 }
  %t160 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t159, i32 0, i32 0
  store %NativeInstruction** %t157, %NativeInstruction*** %t160
  %t161 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t159, i32 0, i32 1
  store i64 1, i64* %t161
  %t162 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t159, 0
  %t163 = insertvalue %InstructionParseResult %t162, i1 0, 1
  %t164 = insertvalue %InstructionParseResult %t163, i1 0, 2
  ret %InstructionParseResult %t164
merge17:
  %s165 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1958778164, i32 0, i32 0
  %t166 = icmp eq i8* %line, %s165
  br i1 %t166, label %then18, label %merge19
then18:
  %t167 = insertvalue %NativeInstruction undef, i32 10, 0
  %t168 = call noalias i8* @malloc(i64 56)
  %t169 = bitcast i8* %t168 to %NativeInstruction*
  store %NativeInstruction %t167, %NativeInstruction* %t169
  %t170 = bitcast i8* %t168 to %NativeInstruction*
  %t171 = alloca [1 x %NativeInstruction*]
  %t172 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* %t171, i32 0, i32 0
  %t173 = getelementptr %NativeInstruction*, %NativeInstruction** %t172, i64 0
  store %NativeInstruction* %t170, %NativeInstruction** %t173
  %t174 = alloca { %NativeInstruction**, i64 }
  %t175 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t174, i32 0, i32 0
  store %NativeInstruction** %t172, %NativeInstruction*** %t175
  %t176 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t174, i32 0, i32 1
  store i64 1, i64* %t176
  %t177 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t174, 0
  %t178 = insertvalue %InstructionParseResult %t177, i1 0, 1
  %t179 = insertvalue %InstructionParseResult %t178, i1 0, 2
  ret %InstructionParseResult %t179
merge19:
  %s180 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h528348603, i32 0, i32 0
  %t181 = icmp eq i8* %line, %s180
  br i1 %t181, label %then20, label %merge21
then20:
  %t182 = insertvalue %NativeInstruction undef, i32 11, 0
  %t183 = call noalias i8* @malloc(i64 56)
  %t184 = bitcast i8* %t183 to %NativeInstruction*
  store %NativeInstruction %t182, %NativeInstruction* %t184
  %t185 = bitcast i8* %t183 to %NativeInstruction*
  %t186 = alloca [1 x %NativeInstruction*]
  %t187 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* %t186, i32 0, i32 0
  %t188 = getelementptr %NativeInstruction*, %NativeInstruction** %t187, i64 0
  store %NativeInstruction* %t185, %NativeInstruction** %t188
  %t189 = alloca { %NativeInstruction**, i64 }
  %t190 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t189, i32 0, i32 0
  store %NativeInstruction** %t187, %NativeInstruction*** %t190
  %t191 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t189, i32 0, i32 1
  store i64 1, i64* %t191
  %t192 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t189, 0
  %t193 = insertvalue %InstructionParseResult %t192, i1 0, 1
  %t194 = insertvalue %InstructionParseResult %t193, i1 0, 2
  ret %InstructionParseResult %t194
merge21:
  %s195 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h553171426, i32 0, i32 0
  %t196 = call i1 @starts_with(i8* %line, i8* %s195)
  br i1 %t196, label %then22, label %merge23
then22:
  %s197 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h553171426, i32 0, i32 0
  %t198 = call i8* @strip_prefix(i8* %line, i8* %s197)
  %t199 = call i8* @trim_text(i8* %t198)
  store i8* %t199, i8** %l6
  %t200 = alloca %NativeInstruction
  %t201 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t200, i32 0, i32 0
  store i32 12, i32* %t201
  %t202 = load i8*, i8** %l6
  %t203 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t200, i32 0, i32 1
  %t204 = bitcast [8 x i8]* %t203 to i8*
  %t205 = bitcast i8* %t204 to i8**
  store i8* %t202, i8** %t205
  %t206 = load %NativeInstruction, %NativeInstruction* %t200
  %t207 = alloca [1 x %NativeInstruction]
  %t208 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t207, i32 0, i32 0
  %t209 = getelementptr %NativeInstruction, %NativeInstruction* %t208, i64 0
  store %NativeInstruction %t206, %NativeInstruction* %t209
  %t210 = alloca { %NativeInstruction*, i64 }
  %t211 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t210, i32 0, i32 0
  store %NativeInstruction* %t208, %NativeInstruction** %t211
  %t212 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t210, i32 0, i32 1
  store i64 1, i64* %t212
  %t213 = bitcast { %NativeInstruction*, i64 }* %t210 to { %NativeInstruction**, i64 }*
  %t214 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t213, 0
  %t215 = insertvalue %InstructionParseResult %t214, i1 0, 1
  %t216 = insertvalue %InstructionParseResult %t215, i1 0, 2
  ret %InstructionParseResult %t216
merge23:
  %s217 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1187178968, i32 0, i32 0
  %t218 = call i1 @starts_with(i8* %line, i8* %s217)
  br i1 %t218, label %then24, label %merge25
then24:
  %t219 = call %NativeInstruction @parse_case_instruction(i8* %line)
  %t220 = call noalias i8* @malloc(i64 56)
  %t221 = bitcast i8* %t220 to %NativeInstruction*
  store %NativeInstruction %t219, %NativeInstruction* %t221
  %t222 = bitcast i8* %t220 to %NativeInstruction*
  %t223 = alloca [1 x %NativeInstruction*]
  %t224 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* %t223, i32 0, i32 0
  %t225 = getelementptr %NativeInstruction*, %NativeInstruction** %t224, i64 0
  store %NativeInstruction* %t222, %NativeInstruction** %t225
  %t226 = alloca { %NativeInstruction**, i64 }
  %t227 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t226, i32 0, i32 0
  store %NativeInstruction** %t224, %NativeInstruction*** %t227
  %t228 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t226, i32 0, i32 1
  store i64 1, i64* %t228
  %t229 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t226, 0
  %t230 = insertvalue %InstructionParseResult %t229, i1 0, 1
  %t231 = insertvalue %InstructionParseResult %t230, i1 0, 2
  ret %InstructionParseResult %t231
merge25:
  %s232 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1692644020, i32 0, i32 0
  %t233 = icmp eq i8* %line, %s232
  br i1 %t233, label %then26, label %merge27
then26:
  %t234 = insertvalue %NativeInstruction undef, i32 14, 0
  %t235 = call noalias i8* @malloc(i64 56)
  %t236 = bitcast i8* %t235 to %NativeInstruction*
  store %NativeInstruction %t234, %NativeInstruction* %t236
  %t237 = bitcast i8* %t235 to %NativeInstruction*
  %t238 = alloca [1 x %NativeInstruction*]
  %t239 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* %t238, i32 0, i32 0
  %t240 = getelementptr %NativeInstruction*, %NativeInstruction** %t239, i64 0
  store %NativeInstruction* %t237, %NativeInstruction** %t240
  %t241 = alloca { %NativeInstruction**, i64 }
  %t242 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t241, i32 0, i32 0
  store %NativeInstruction** %t239, %NativeInstruction*** %t242
  %t243 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t241, i32 0, i32 1
  store i64 1, i64* %t243
  %t244 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t241, 0
  %t245 = insertvalue %InstructionParseResult %t244, i1 0, 1
  %t246 = insertvalue %InstructionParseResult %t245, i1 0, 2
  ret %InstructionParseResult %t246
merge27:
  %s247 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2064124065, i32 0, i32 0
  %t248 = call i1 @starts_with(i8* %line, i8* %s247)
  br i1 %t248, label %then28, label %merge29
then28:
  %t249 = call %NativeInstruction @parse_let_instruction(i8* %line, %NativeSourceSpan* %span, %NativeSourceSpan* %value_span)
  %t250 = call noalias i8* @malloc(i64 56)
  %t251 = bitcast i8* %t250 to %NativeInstruction*
  store %NativeInstruction %t249, %NativeInstruction* %t251
  %t252 = bitcast i8* %t250 to %NativeInstruction*
  %t253 = alloca [1 x %NativeInstruction*]
  %t254 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* %t253, i32 0, i32 0
  %t255 = getelementptr %NativeInstruction*, %NativeInstruction** %t254, i64 0
  store %NativeInstruction* %t252, %NativeInstruction** %t255
  %t256 = alloca { %NativeInstruction**, i64 }
  %t257 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t256, i32 0, i32 0
  store %NativeInstruction** %t254, %NativeInstruction*** %t257
  %t258 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t256, i32 0, i32 1
  store i64 1, i64* %t258
  %t259 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t256, 0
  %t260 = insertvalue %InstructionParseResult %t259, i1 1, 1
  %t261 = insertvalue %InstructionParseResult %t260, i1 1, 2
  ret %InstructionParseResult %t261
merge29:
  %s262 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h725262232, i32 0, i32 0
  %t263 = call i1 @starts_with(i8* %line, i8* %s262)
  br i1 %t263, label %then30, label %merge31
then30:
  %s264 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h725262232, i32 0, i32 0
  %t265 = call i8* @strip_prefix(i8* %line, i8* %s264)
  %t266 = call i8* @trim_text(i8* %t265)
  store i8* %t266, i8** %l7
  %s267 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s267, i8** %l8
  %t268 = load i8*, i8** %l7
  %t269 = call i64 @sailfin_runtime_string_length(i8* %t268)
  %t270 = icmp sgt i64 %t269, 0
  %t271 = load i8*, i8** %l7
  %t272 = load i8*, i8** %l8
  br i1 %t270, label %then32, label %merge33
then32:
  %t273 = load i8*, i8** %l7
  %t274 = call i8* @trim_trailing_delimiters(i8* %t273)
  store i8* %t274, i8** %l8
  %t275 = load i8*, i8** %l8
  br label %merge33
merge33:
  %t276 = phi i8* [ %t275, %then32 ], [ %t272, %then30 ]
  store i8* %t276, i8** %l8
  %t277 = alloca %NativeInstruction
  %t278 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t277, i32 0, i32 0
  store i32 0, i32* %t278
  %t279 = load i8*, i8** %l8
  %t280 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t277, i32 0, i32 1
  %t281 = bitcast [16 x i8]* %t280 to i8*
  %t282 = bitcast i8* %t281 to i8**
  store i8* %t279, i8** %t282
  %t283 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t277, i32 0, i32 1
  %t284 = bitcast [16 x i8]* %t283 to i8*
  %t285 = getelementptr inbounds i8, i8* %t284, i64 8
  %t286 = bitcast i8* %t285 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t286
  %t287 = load %NativeInstruction, %NativeInstruction* %t277
  %t288 = alloca [1 x %NativeInstruction]
  %t289 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t288, i32 0, i32 0
  %t290 = getelementptr %NativeInstruction, %NativeInstruction* %t289, i64 0
  store %NativeInstruction %t287, %NativeInstruction* %t290
  %t291 = alloca { %NativeInstruction*, i64 }
  %t292 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t291, i32 0, i32 0
  store %NativeInstruction* %t289, %NativeInstruction** %t292
  %t293 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t291, i32 0, i32 1
  store i64 1, i64* %t293
  %t294 = bitcast { %NativeInstruction*, i64 }* %t291 to { %NativeInstruction**, i64 }*
  %t295 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t294, 0
  %t296 = insertvalue %InstructionParseResult %t295, i1 1, 1
  %t297 = insertvalue %InstructionParseResult %t296, i1 0, 2
  ret %InstructionParseResult %t297
merge31:
  %s298 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090684245, i32 0, i32 0
  %t299 = call i1 @starts_with(i8* %line, i8* %s298)
  br i1 %t299, label %then34, label %merge35
then34:
  %t300 = call i64 @sailfin_runtime_string_length(i8* %line)
  %t301 = icmp eq i64 %t300, 3
  br i1 %t301, label %then36, label %merge37
then36:
  %t302 = alloca %NativeInstruction
  %t303 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t302, i32 0, i32 0
  store i32 0, i32* %t303
  %s304 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t305 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t302, i32 0, i32 1
  %t306 = bitcast [16 x i8]* %t305 to i8*
  %t307 = bitcast i8* %t306 to i8**
  store i8* %s304, i8** %t307
  %t308 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t302, i32 0, i32 1
  %t309 = bitcast [16 x i8]* %t308 to i8*
  %t310 = getelementptr inbounds i8, i8* %t309, i64 8
  %t311 = bitcast i8* %t310 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t311
  %t312 = load %NativeInstruction, %NativeInstruction* %t302
  %t313 = alloca [1 x %NativeInstruction]
  %t314 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t313, i32 0, i32 0
  %t315 = getelementptr %NativeInstruction, %NativeInstruction* %t314, i64 0
  store %NativeInstruction %t312, %NativeInstruction* %t315
  %t316 = alloca { %NativeInstruction*, i64 }
  %t317 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t316, i32 0, i32 0
  store %NativeInstruction* %t314, %NativeInstruction** %t317
  %t318 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t316, i32 0, i32 1
  store i64 1, i64* %t318
  %t319 = bitcast { %NativeInstruction*, i64 }* %t316 to { %NativeInstruction**, i64 }*
  %t320 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t319, 0
  %t321 = insertvalue %InstructionParseResult %t320, i1 1, 1
  %t322 = insertvalue %InstructionParseResult %t321, i1 0, 2
  ret %InstructionParseResult %t322
merge37:
  %t323 = getelementptr i8, i8* %line, i64 3
  %t324 = load i8, i8* %t323
  store i8 %t324, i8* %l9
  %t326 = load i8, i8* %l9
  %t327 = icmp eq i8 %t326, 32
  br label %logical_or_entry_325

logical_or_entry_325:
  br i1 %t327, label %logical_or_merge_325, label %logical_or_right_325

logical_or_right_325:
  %t328 = load i8, i8* %l9
  %t329 = icmp eq i8 %t328, 9
  br label %logical_or_right_end_325

logical_or_right_end_325:
  br label %logical_or_merge_325

logical_or_merge_325:
  %t330 = phi i1 [ true, %logical_or_entry_325 ], [ %t329, %logical_or_right_end_325 ]
  %t331 = load i8, i8* %l9
  br i1 %t330, label %then38, label %merge39
then38:
  %t332 = call i64 @sailfin_runtime_string_length(i8* %line)
  %t333 = call i8* @sailfin_runtime_substring(i8* %line, i64 3, i64 %t332)
  %t334 = call i8* @trim_text(i8* %t333)
  store i8* %t334, i8** %l10
  %t335 = load i8*, i8** %l10
  %t336 = call i64 @sailfin_runtime_string_length(i8* %t335)
  %t337 = icmp eq i64 %t336, 0
  %t338 = load i8, i8* %l9
  %t339 = load i8*, i8** %l10
  br i1 %t337, label %then40, label %merge41
then40:
  %t340 = alloca %NativeInstruction
  %t341 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t340, i32 0, i32 0
  store i32 0, i32* %t341
  %s342 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t343 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t340, i32 0, i32 1
  %t344 = bitcast [16 x i8]* %t343 to i8*
  %t345 = bitcast i8* %t344 to i8**
  store i8* %s342, i8** %t345
  %t346 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t340, i32 0, i32 1
  %t347 = bitcast [16 x i8]* %t346 to i8*
  %t348 = getelementptr inbounds i8, i8* %t347, i64 8
  %t349 = bitcast i8* %t348 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t349
  %t350 = load %NativeInstruction, %NativeInstruction* %t340
  %t351 = alloca [1 x %NativeInstruction]
  %t352 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t351, i32 0, i32 0
  %t353 = getelementptr %NativeInstruction, %NativeInstruction* %t352, i64 0
  store %NativeInstruction %t350, %NativeInstruction* %t353
  %t354 = alloca { %NativeInstruction*, i64 }
  %t355 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t354, i32 0, i32 0
  store %NativeInstruction* %t352, %NativeInstruction** %t355
  %t356 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t354, i32 0, i32 1
  store i64 1, i64* %t356
  %t357 = bitcast { %NativeInstruction*, i64 }* %t354 to { %NativeInstruction**, i64 }*
  %t358 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t357, 0
  %t359 = insertvalue %InstructionParseResult %t358, i1 1, 1
  %t360 = insertvalue %InstructionParseResult %t359, i1 0, 2
  ret %InstructionParseResult %t360
merge41:
  %t361 = alloca %NativeInstruction
  %t362 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t361, i32 0, i32 0
  store i32 0, i32* %t362
  %t363 = load i8*, i8** %l10
  %t364 = call i8* @trim_trailing_delimiters(i8* %t363)
  %t365 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t361, i32 0, i32 1
  %t366 = bitcast [16 x i8]* %t365 to i8*
  %t367 = bitcast i8* %t366 to i8**
  store i8* %t364, i8** %t367
  %t368 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t361, i32 0, i32 1
  %t369 = bitcast [16 x i8]* %t368 to i8*
  %t370 = getelementptr inbounds i8, i8* %t369, i64 8
  %t371 = bitcast i8* %t370 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t371
  %t372 = load %NativeInstruction, %NativeInstruction* %t361
  %t373 = alloca [1 x %NativeInstruction]
  %t374 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t373, i32 0, i32 0
  %t375 = getelementptr %NativeInstruction, %NativeInstruction* %t374, i64 0
  store %NativeInstruction %t372, %NativeInstruction* %t375
  %t376 = alloca { %NativeInstruction*, i64 }
  %t377 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t376, i32 0, i32 0
  store %NativeInstruction* %t374, %NativeInstruction** %t377
  %t378 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t376, i32 0, i32 1
  store i64 1, i64* %t378
  %t379 = bitcast { %NativeInstruction*, i64 }* %t376 to { %NativeInstruction**, i64 }*
  %t380 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t379, 0
  %t381 = insertvalue %InstructionParseResult %t380, i1 1, 1
  %t382 = insertvalue %InstructionParseResult %t381, i1 0, 2
  ret %InstructionParseResult %t382
merge39:
  br label %merge35
merge35:
  %s383 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h890937508, i32 0, i32 0
  %t384 = call i1 @starts_with(i8* %line, i8* %s383)
  br i1 %t384, label %then42, label %merge43
then42:
  %s385 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h890937508, i32 0, i32 0
  %t386 = call i8* @strip_prefix(i8* %line, i8* %s385)
  %t387 = call i8* @trim_text(i8* %t386)
  store i8* %t387, i8** %l11
  store i1 0, i1* %l12
  %t388 = load i8*, i8** %l11
  %s389 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t390 = call i1 @starts_with(i8* %t388, i8* %s389)
  %t391 = load i8*, i8** %l11
  %t392 = load i1, i1* %l12
  br i1 %t390, label %then44, label %merge45
then44:
  store i1 1, i1* %l12
  %t393 = load i8*, i8** %l11
  %s394 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t395 = call i8* @strip_prefix(i8* %t393, i8* %s394)
  %t396 = call i8* @trim_text(i8* %t395)
  store i8* %t396, i8** %l11
  %t397 = load i1, i1* %l12
  %t398 = load i8*, i8** %l11
  br label %merge45
merge45:
  %t399 = phi i1 [ %t397, %then44 ], [ %t392, %then42 ]
  %t400 = phi i8* [ %t398, %then44 ], [ %t391, %then42 ]
  store i1 %t399, i1* %l12
  store i8* %t400, i8** %l11
  %t401 = load i8*, i8** %l11
  %t402 = call %BindingComponents @parse_binding_components(i8* %t401)
  store %BindingComponents %t402, %BindingComponents* %l13
  %t403 = alloca %NativeInstruction
  %t404 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t403, i32 0, i32 0
  store i32 2, i32* %t404
  %t405 = load %BindingComponents, %BindingComponents* %l13
  %t406 = extractvalue %BindingComponents %t405, 0
  %t407 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t403, i32 0, i32 1
  %t408 = bitcast [48 x i8]* %t407 to i8*
  %t409 = bitcast i8* %t408 to i8**
  store i8* %t406, i8** %t409
  %t410 = load i1, i1* %l12
  %t411 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t403, i32 0, i32 1
  %t412 = bitcast [48 x i8]* %t411 to i8*
  %t413 = getelementptr inbounds i8, i8* %t412, i64 8
  %t414 = bitcast i8* %t413 to i1*
  store i1 %t410, i1* %t414
  %t415 = load %BindingComponents, %BindingComponents* %l13
  %t416 = extractvalue %BindingComponents %t415, 1
  %t417 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t403, i32 0, i32 1
  %t418 = bitcast [48 x i8]* %t417 to i8*
  %t419 = getelementptr inbounds i8, i8* %t418, i64 16
  %t420 = bitcast i8* %t419 to i8**
  store i8* %t416, i8** %t420
  %t421 = load %BindingComponents, %BindingComponents* %l13
  %t422 = extractvalue %BindingComponents %t421, 2
  %t423 = call i8* @maybe_trim_trailing(i8* %t422)
  %t424 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t403, i32 0, i32 1
  %t425 = bitcast [48 x i8]* %t424 to i8*
  %t426 = getelementptr inbounds i8, i8* %t425, i64 24
  %t427 = bitcast i8* %t426 to i8**
  store i8* %t423, i8** %t427
  %t428 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t403, i32 0, i32 1
  %t429 = bitcast [48 x i8]* %t428 to i8*
  %t430 = getelementptr inbounds i8, i8* %t429, i64 32
  %t431 = bitcast i8* %t430 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t431
  %t432 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t403, i32 0, i32 1
  %t433 = bitcast [48 x i8]* %t432 to i8*
  %t434 = getelementptr inbounds i8, i8* %t433, i64 40
  %t435 = bitcast i8* %t434 to %NativeSourceSpan**
  store %NativeSourceSpan* %value_span, %NativeSourceSpan** %t435
  %t436 = load %NativeInstruction, %NativeInstruction* %t403
  %t437 = alloca [1 x %NativeInstruction]
  %t438 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t437, i32 0, i32 0
  %t439 = getelementptr %NativeInstruction, %NativeInstruction* %t438, i64 0
  store %NativeInstruction %t436, %NativeInstruction* %t439
  %t440 = alloca { %NativeInstruction*, i64 }
  %t441 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t440, i32 0, i32 0
  store %NativeInstruction* %t438, %NativeInstruction** %t441
  %t442 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t440, i32 0, i32 1
  store i64 1, i64* %t442
  %t443 = bitcast { %NativeInstruction*, i64 }* %t440 to { %NativeInstruction**, i64 }*
  %t444 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t443, 0
  %t445 = insertvalue %InstructionParseResult %t444, i1 1, 1
  %t446 = insertvalue %InstructionParseResult %t445, i1 1, 2
  ret %InstructionParseResult %t446
merge43:
  %s447 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2080793783, i32 0, i32 0
  %t448 = call i1 @starts_with(i8* %line, i8* %s447)
  br i1 %t448, label %then46, label %merge47
then46:
  %t449 = alloca %NativeInstruction
  %t450 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t449, i32 0, i32 0
  store i32 1, i32* %t450
  %s451 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2080793783, i32 0, i32 0
  %t452 = call i8* @strip_prefix(i8* %line, i8* %s451)
  %t453 = call i8* @trim_text(i8* %t452)
  %t454 = call i8* @trim_trailing_delimiters(i8* %t453)
  %t455 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t449, i32 0, i32 1
  %t456 = bitcast [16 x i8]* %t455 to i8*
  %t457 = bitcast i8* %t456 to i8**
  store i8* %t454, i8** %t457
  %t458 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t449, i32 0, i32 1
  %t459 = bitcast [16 x i8]* %t458 to i8*
  %t460 = getelementptr inbounds i8, i8* %t459, i64 8
  %t461 = bitcast i8* %t460 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t461
  %t462 = load %NativeInstruction, %NativeInstruction* %t449
  %t463 = alloca [1 x %NativeInstruction]
  %t464 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t463, i32 0, i32 0
  %t465 = getelementptr %NativeInstruction, %NativeInstruction* %t464, i64 0
  store %NativeInstruction %t462, %NativeInstruction* %t465
  %t466 = alloca { %NativeInstruction*, i64 }
  %t467 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t466, i32 0, i32 0
  store %NativeInstruction* %t464, %NativeInstruction** %t467
  %t468 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t466, i32 0, i32 1
  store i64 1, i64* %t468
  %t469 = bitcast { %NativeInstruction*, i64 }* %t466 to { %NativeInstruction**, i64 }*
  %t470 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t469, 0
  %t471 = insertvalue %InstructionParseResult %t470, i1 1, 1
  %t472 = insertvalue %InstructionParseResult %t471, i1 0, 2
  ret %InstructionParseResult %t472
merge47:
  %s473 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193445474, i32 0, i32 0
  %t474 = call double @index_of(i8* %line, i8* %s473)
  %t475 = sitofp i64 0 to double
  %t476 = fcmp oge double %t474, %t475
  br i1 %t476, label %then48, label %merge49
then48:
  %t477 = call { %NativeInstruction*, i64 }* @parse_inline_case_instruction(i8* %line)
  %t478 = bitcast { %NativeInstruction*, i64 }* %t477 to { %NativeInstruction**, i64 }*
  %t479 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t478, 0
  %t480 = insertvalue %InstructionParseResult %t479, i1 0, 1
  %t481 = insertvalue %InstructionParseResult %t480, i1 0, 2
  ret %InstructionParseResult %t481
merge49:
  %t482 = alloca %NativeInstruction
  %t483 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t482, i32 0, i32 0
  store i32 16, i32* %t483
  %t484 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t482, i32 0, i32 1
  %t485 = bitcast [8 x i8]* %t484 to i8*
  %t486 = bitcast i8* %t485 to i8**
  store i8* %line, i8** %t486
  %t487 = load %NativeInstruction, %NativeInstruction* %t482
  %t488 = alloca [1 x %NativeInstruction]
  %t489 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t488, i32 0, i32 0
  %t490 = getelementptr %NativeInstruction, %NativeInstruction* %t489, i64 0
  store %NativeInstruction %t487, %NativeInstruction* %t490
  %t491 = alloca { %NativeInstruction*, i64 }
  %t492 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t491, i32 0, i32 0
  store %NativeInstruction* %t489, %NativeInstruction** %t492
  %t493 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t491, i32 0, i32 1
  store i64 1, i64* %t493
  %t494 = bitcast { %NativeInstruction*, i64 }* %t491 to { %NativeInstruction**, i64 }*
  %t495 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t494, 0
  %t496 = insertvalue %InstructionParseResult %t495, i1 0, 1
  %t497 = insertvalue %InstructionParseResult %t496, i1 0, 2
  ret %InstructionParseResult %t497
}

define %NativeInstruction @parse_case_instruction(i8* %line) {
entry:
  %l0 = alloca i8*
  %l1 = alloca %CaseComponents
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1187178968, i32 0, i32 0
  %t1 = call i8* @strip_prefix(i8* %line, i8* %s0)
  %t2 = call i8* @trim_text(i8* %t1)
  store i8* %t2, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = call %CaseComponents @split_case_components(i8* %t3)
  store %CaseComponents %t4, %CaseComponents* %l1
  %t5 = alloca %NativeInstruction
  %t6 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t5, i32 0, i32 0
  store i32 13, i32* %t6
  %t7 = load %CaseComponents, %CaseComponents* %l1
  %t8 = extractvalue %CaseComponents %t7, 0
  %t9 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t5, i32 0, i32 1
  %t10 = bitcast [16 x i8]* %t9 to i8*
  %t11 = bitcast i8* %t10 to i8**
  store i8* %t8, i8** %t11
  %t12 = load %CaseComponents, %CaseComponents* %l1
  %t13 = extractvalue %CaseComponents %t12, 1
  %t14 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t5, i32 0, i32 1
  %t15 = bitcast [16 x i8]* %t14 to i8*
  %t16 = getelementptr inbounds i8, i8* %t15, i64 8
  %t17 = bitcast i8* %t16 to i8**
  store i8* %t13, i8** %t17
  %t18 = load %NativeInstruction, %NativeInstruction* %t5
  ret %NativeInstruction %t18
}

define { %NativeInstruction*, i64 }* @parse_inline_case_instruction(i8* %line) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca %CaseComponents
  %l5 = alloca { %NativeInstruction*, i64 }*
  %l6 = alloca %NativeInstruction
  %t0 = call i8* @trim_text(i8* %line)
  %t1 = call i8* @trim_trailing_delimiters(i8* %t0)
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  %s3 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193445474, i32 0, i32 0
  %t4 = call double @index_of(i8* %t2, i8* %s3)
  store double %t4, double* %l1
  %t5 = load double, double* %l1
  %t6 = sitofp i64 0 to double
  %t7 = fcmp olt double %t5, %t6
  %t8 = load i8*, i8** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then0, label %merge1
then0:
  %t10 = alloca %NativeInstruction
  %t11 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t10, i32 0, i32 0
  store i32 16, i32* %t11
  %t12 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t10, i32 0, i32 1
  %t13 = bitcast [8 x i8]* %t12 to i8*
  %t14 = bitcast i8* %t13 to i8**
  store i8* %line, i8** %t14
  %t15 = load %NativeInstruction, %NativeInstruction* %t10
  %t16 = alloca [1 x %NativeInstruction]
  %t17 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t16, i32 0, i32 0
  %t18 = getelementptr %NativeInstruction, %NativeInstruction* %t17, i64 0
  store %NativeInstruction %t15, %NativeInstruction* %t18
  %t19 = alloca { %NativeInstruction*, i64 }
  %t20 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t19, i32 0, i32 0
  store %NativeInstruction* %t17, %NativeInstruction** %t20
  %t21 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t19, i32 0, i32 1
  store i64 1, i64* %t21
  ret { %NativeInstruction*, i64 }* %t19
merge1:
  %t22 = load i8*, i8** %l0
  %t23 = load double, double* %l1
  %t24 = fptosi double %t23 to i64
  %t25 = call i8* @sailfin_runtime_substring(i8* %t22, i64 0, i64 %t24)
  %t26 = call i8* @trim_text(i8* %t25)
  store i8* %t26, i8** %l2
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  %t29 = sitofp i64 2 to double
  %t30 = fadd double %t28, %t29
  %t31 = load i8*, i8** %l0
  %t32 = call i64 @sailfin_runtime_string_length(i8* %t31)
  %t33 = fptosi double %t30 to i64
  %t34 = call i8* @sailfin_runtime_substring(i8* %t27, i64 %t33, i64 %t32)
  %t35 = call i8* @trim_text(i8* %t34)
  %t36 = call i8* @trim_trailing_delimiters(i8* %t35)
  store i8* %t36, i8** %l3
  %t37 = load i8*, i8** %l2
  %t38 = call %CaseComponents @split_case_components(i8* %t37)
  store %CaseComponents %t38, %CaseComponents* %l4
  %t39 = alloca [0 x %NativeInstruction]
  %t40 = getelementptr [0 x %NativeInstruction], [0 x %NativeInstruction]* %t39, i32 0, i32 0
  %t41 = alloca { %NativeInstruction*, i64 }
  %t42 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t41, i32 0, i32 0
  store %NativeInstruction* %t40, %NativeInstruction** %t42
  %t43 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t41, i32 0, i32 1
  store i64 0, i64* %t43
  store { %NativeInstruction*, i64 }* %t41, { %NativeInstruction*, i64 }** %l5
  %t44 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  %t45 = alloca %NativeInstruction
  %t46 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t45, i32 0, i32 0
  store i32 13, i32* %t46
  %t47 = load %CaseComponents, %CaseComponents* %l4
  %t48 = extractvalue %CaseComponents %t47, 0
  %t49 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t45, i32 0, i32 1
  %t50 = bitcast [16 x i8]* %t49 to i8*
  %t51 = bitcast i8* %t50 to i8**
  store i8* %t48, i8** %t51
  %t52 = load %CaseComponents, %CaseComponents* %l4
  %t53 = extractvalue %CaseComponents %t52, 1
  %t54 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t45, i32 0, i32 1
  %t55 = bitcast [16 x i8]* %t54 to i8*
  %t56 = getelementptr inbounds i8, i8* %t55, i64 8
  %t57 = bitcast i8* %t56 to i8**
  store i8* %t53, i8** %t57
  %t58 = load %NativeInstruction, %NativeInstruction* %t45
  %t59 = call noalias i8* @malloc(i64 56)
  %t60 = bitcast i8* %t59 to %NativeInstruction*
  store %NativeInstruction %t58, %NativeInstruction* %t60
  %t61 = alloca [1 x i8*]
  %t62 = getelementptr [1 x i8*], [1 x i8*]* %t61, i32 0, i32 0
  %t63 = getelementptr i8*, i8** %t62, i64 0
  store i8* %t59, i8** %t63
  %t64 = alloca { i8**, i64 }
  %t65 = getelementptr { i8**, i64 }, { i8**, i64 }* %t64, i32 0, i32 0
  store i8** %t62, i8*** %t65
  %t66 = getelementptr { i8**, i64 }, { i8**, i64 }* %t64, i32 0, i32 1
  store i64 1, i64* %t66
  %t67 = bitcast { %NativeInstruction*, i64 }* %t44 to { i8**, i64 }*
  %t68 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t67, { i8**, i64 }* %t64)
  %t69 = bitcast { i8**, i64 }* %t68 to { %NativeInstruction*, i64 }*
  store { %NativeInstruction*, i64 }* %t69, { %NativeInstruction*, i64 }** %l5
  %t70 = load i8*, i8** %l3
  %t71 = call i64 @sailfin_runtime_string_length(i8* %t70)
  %t72 = icmp eq i64 %t71, 0
  %t73 = load i8*, i8** %l0
  %t74 = load double, double* %l1
  %t75 = load i8*, i8** %l2
  %t76 = load i8*, i8** %l3
  %t77 = load %CaseComponents, %CaseComponents* %l4
  %t78 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  br i1 %t72, label %then2, label %merge3
then2:
  %t79 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  %t80 = insertvalue %NativeInstruction undef, i32 15, 0
  %t81 = call noalias i8* @malloc(i64 56)
  %t82 = bitcast i8* %t81 to %NativeInstruction*
  store %NativeInstruction %t80, %NativeInstruction* %t82
  %t83 = alloca [1 x i8*]
  %t84 = getelementptr [1 x i8*], [1 x i8*]* %t83, i32 0, i32 0
  %t85 = getelementptr i8*, i8** %t84, i64 0
  store i8* %t81, i8** %t85
  %t86 = alloca { i8**, i64 }
  %t87 = getelementptr { i8**, i64 }, { i8**, i64 }* %t86, i32 0, i32 0
  store i8** %t84, i8*** %t87
  %t88 = getelementptr { i8**, i64 }, { i8**, i64 }* %t86, i32 0, i32 1
  store i64 1, i64* %t88
  %t89 = bitcast { %NativeInstruction*, i64 }* %t79 to { i8**, i64 }*
  %t90 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t89, { i8**, i64 }* %t86)
  %t91 = bitcast { i8**, i64 }* %t90 to { %NativeInstruction*, i64 }*
  store { %NativeInstruction*, i64 }* %t91, { %NativeInstruction*, i64 }** %l5
  %t92 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  ret { %NativeInstruction*, i64 }* %t92
merge3:
  %t93 = load i8*, i8** %l3
  %t94 = call %NativeInstruction @parse_inline_case_body_instruction(i8* %t93)
  store %NativeInstruction %t94, %NativeInstruction* %l6
  %t95 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  %t96 = load %NativeInstruction, %NativeInstruction* %l6
  %t97 = call noalias i8* @malloc(i64 56)
  %t98 = bitcast i8* %t97 to %NativeInstruction*
  store %NativeInstruction %t96, %NativeInstruction* %t98
  %t99 = alloca [1 x i8*]
  %t100 = getelementptr [1 x i8*], [1 x i8*]* %t99, i32 0, i32 0
  %t101 = getelementptr i8*, i8** %t100, i64 0
  store i8* %t97, i8** %t101
  %t102 = alloca { i8**, i64 }
  %t103 = getelementptr { i8**, i64 }, { i8**, i64 }* %t102, i32 0, i32 0
  store i8** %t100, i8*** %t103
  %t104 = getelementptr { i8**, i64 }, { i8**, i64 }* %t102, i32 0, i32 1
  store i64 1, i64* %t104
  %t105 = bitcast { %NativeInstruction*, i64 }* %t95 to { i8**, i64 }*
  %t106 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t105, { i8**, i64 }* %t102)
  %t107 = bitcast { i8**, i64 }* %t106 to { %NativeInstruction*, i64 }*
  store { %NativeInstruction*, i64 }* %t107, { %NativeInstruction*, i64 }** %l5
  %t108 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  ret { %NativeInstruction*, i64 }* %t108
}

define %NativeInstruction @parse_inline_case_body_instruction(i8* %body) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @trim_trailing_delimiters(i8* %body)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h655348872, i32 0, i32 0
  %t3 = call i1 @starts_with(i8* %t1, i8* %s2)
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %s6 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h655348872, i32 0, i32 0
  %t7 = call i8* @strip_prefix(i8* %t5, i8* %s6)
  %t8 = call i8* @trim_text(i8* %t7)
  %t9 = call i8* @trim_trailing_delimiters(i8* %t8)
  store i8* %t9, i8** %l1
  %t10 = alloca %NativeInstruction
  %t11 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t10, i32 0, i32 0
  store i32 0, i32* %t11
  %t12 = load i8*, i8** %l1
  %t13 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t10, i32 0, i32 1
  %t14 = bitcast [16 x i8]* %t13 to i8*
  %t15 = bitcast i8* %t14 to i8**
  store i8* %t12, i8** %t15
  %t16 = bitcast i8* null to %NativeSourceSpan*
  %t17 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t10, i32 0, i32 1
  %t18 = bitcast [16 x i8]* %t17 to i8*
  %t19 = getelementptr inbounds i8, i8* %t18, i64 8
  %t20 = bitcast i8* %t19 to %NativeSourceSpan**
  store %NativeSourceSpan* %t16, %NativeSourceSpan** %t20
  %t21 = load %NativeInstruction, %NativeInstruction* %t10
  ret %NativeInstruction %t21
merge1:
  %t22 = load i8*, i8** %l0
  %s23 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2080793783, i32 0, i32 0
  %t24 = call i1 @starts_with(i8* %t22, i8* %s23)
  %t25 = load i8*, i8** %l0
  br i1 %t24, label %then2, label %merge3
then2:
  %t26 = alloca %NativeInstruction
  %t27 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t26, i32 0, i32 0
  store i32 1, i32* %t27
  %t28 = load i8*, i8** %l0
  %s29 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2080793783, i32 0, i32 0
  %t30 = call i8* @strip_prefix(i8* %t28, i8* %s29)
  %t31 = call i8* @trim_text(i8* %t30)
  %t32 = call i8* @trim_trailing_delimiters(i8* %t31)
  %t33 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t26, i32 0, i32 1
  %t34 = bitcast [16 x i8]* %t33 to i8*
  %t35 = bitcast i8* %t34 to i8**
  store i8* %t32, i8** %t35
  %t36 = bitcast i8* null to %NativeSourceSpan*
  %t37 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t26, i32 0, i32 1
  %t38 = bitcast [16 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 8
  %t40 = bitcast i8* %t39 to %NativeSourceSpan**
  store %NativeSourceSpan* %t36, %NativeSourceSpan** %t40
  %t41 = load %NativeInstruction, %NativeInstruction* %t26
  ret %NativeInstruction %t41
merge3:
  %t42 = alloca %NativeInstruction
  %t43 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t42, i32 0, i32 0
  store i32 1, i32* %t43
  %t44 = load i8*, i8** %l0
  %t45 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t42, i32 0, i32 1
  %t46 = bitcast [16 x i8]* %t45 to i8*
  %t47 = bitcast i8* %t46 to i8**
  store i8* %t44, i8** %t47
  %t48 = bitcast i8* null to %NativeSourceSpan*
  %t49 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t42, i32 0, i32 1
  %t50 = bitcast [16 x i8]* %t49 to i8*
  %t51 = getelementptr inbounds i8, i8* %t50, i64 8
  %t52 = bitcast i8* %t51 to %NativeSourceSpan**
  store %NativeSourceSpan* %t48, %NativeSourceSpan** %t52
  %t53 = load %NativeInstruction, %NativeInstruction* %t42
  ret %NativeInstruction %t53
}

define %CaseComponents @split_case_components(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %t6 = insertvalue %CaseComponents undef, i8* %t5, 0
  %t7 = insertvalue %CaseComponents %t6, i8* null, 1
  ret %CaseComponents %t7
merge1:
  %s8 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175987322, i32 0, i32 0
  store i8* %s8, i8** %l1
  %t9 = load i8*, i8** %l0
  %t10 = load i8*, i8** %l1
  %t11 = call double @last_index_of(i8* %t9, i8* %t10)
  store double %t11, double* %l2
  %t12 = load double, double* %l2
  %t13 = sitofp i64 0 to double
  %t14 = fcmp olt double %t12, %t13
  %t15 = load i8*, i8** %l0
  %t16 = load i8*, i8** %l1
  %t17 = load double, double* %l2
  br i1 %t14, label %then2, label %merge3
then2:
  %t18 = load i8*, i8** %l0
  %t19 = insertvalue %CaseComponents undef, i8* %t18, 0
  %t20 = insertvalue %CaseComponents %t19, i8* null, 1
  ret %CaseComponents %t20
merge3:
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l2
  %t23 = fptosi double %t22 to i64
  %t24 = call i8* @sailfin_runtime_substring(i8* %t21, i64 0, i64 %t23)
  %t25 = call i8* @trim_text(i8* %t24)
  store i8* %t25, i8** %l3
  %t26 = load i8*, i8** %l0
  %t27 = load double, double* %l2
  %t28 = load i8*, i8** %l1
  %t29 = call i64 @sailfin_runtime_string_length(i8* %t28)
  %t30 = sitofp i64 %t29 to double
  %t31 = fadd double %t27, %t30
  %t32 = load i8*, i8** %l0
  %t33 = call i64 @sailfin_runtime_string_length(i8* %t32)
  %t34 = fptosi double %t31 to i64
  %t35 = call i8* @sailfin_runtime_substring(i8* %t26, i64 %t34, i64 %t33)
  %t36 = call i8* @trim_text(i8* %t35)
  store i8* %t36, i8** %l4
  %t37 = load i8*, i8** %l4
  %t38 = call i64 @sailfin_runtime_string_length(i8* %t37)
  %t39 = icmp eq i64 %t38, 0
  %t40 = load i8*, i8** %l0
  %t41 = load i8*, i8** %l1
  %t42 = load double, double* %l2
  %t43 = load i8*, i8** %l3
  %t44 = load i8*, i8** %l4
  br i1 %t39, label %then4, label %merge5
then4:
  %t45 = load i8*, i8** %l3
  %t46 = insertvalue %CaseComponents undef, i8* %t45, 0
  %t47 = insertvalue %CaseComponents %t46, i8* null, 1
  ret %CaseComponents %t47
merge5:
  %t48 = load i8*, i8** %l3
  %t49 = insertvalue %CaseComponents undef, i8* %t48, 0
  %t50 = load i8*, i8** %l4
  %t51 = insertvalue %CaseComponents %t49, i8* %t50, 1
  ret %CaseComponents %t51
}

define %NativeImport* @parse_import_entry(i8* %kind, i8* %entry) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca { %NativeImportSpecifier*, i64 }*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %t0 = call i8* @trim_text(i8* %entry)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = bitcast i8* null to %NativeImport*
  ret %NativeImport* %t5
merge1:
  %t6 = load i8*, i8** %l0
  store i8* %t6, i8** %l1
  %t7 = alloca [0 x %NativeImportSpecifier]
  %t8 = getelementptr [0 x %NativeImportSpecifier], [0 x %NativeImportSpecifier]* %t7, i32 0, i32 0
  %t9 = alloca { %NativeImportSpecifier*, i64 }
  %t10 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t9, i32 0, i32 0
  store %NativeImportSpecifier* %t8, %NativeImportSpecifier** %t10
  %t11 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %NativeImportSpecifier*, i64 }* %t9, { %NativeImportSpecifier*, i64 }** %l2
  %t12 = load i8*, i8** %l0
  %t13 = alloca [2 x i8], align 1
  %t14 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 0
  store i8 123, i8* %t14
  %t15 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 1
  store i8 0, i8* %t15
  %t16 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 0
  %t17 = call double @index_of(i8* %t12, i8* %t16)
  store double %t17, double* %l3
  %t18 = load double, double* %l3
  %t19 = sitofp i64 0 to double
  %t20 = fcmp oge double %t18, %t19
  %t21 = load i8*, i8** %l0
  %t22 = load i8*, i8** %l1
  %t23 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t24 = load double, double* %l3
  br i1 %t20, label %then2, label %merge3
then2:
  %t25 = load i8*, i8** %l0
  %t26 = alloca [2 x i8], align 1
  %t27 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 0
  store i8 125, i8* %t27
  %t28 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 1
  store i8 0, i8* %t28
  %t29 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 0
  %t30 = call double @last_index_of(i8* %t25, i8* %t29)
  store double %t30, double* %l4
  %t32 = load double, double* %l4
  %t33 = sitofp i64 0 to double
  %t34 = fcmp olt double %t32, %t33
  br label %logical_or_entry_31

logical_or_entry_31:
  br i1 %t34, label %logical_or_merge_31, label %logical_or_right_31

logical_or_right_31:
  %t35 = load double, double* %l4
  %t36 = load double, double* %l3
  %t37 = fcmp ole double %t35, %t36
  br label %logical_or_right_end_31

logical_or_right_end_31:
  br label %logical_or_merge_31

logical_or_merge_31:
  %t38 = phi i1 [ true, %logical_or_entry_31 ], [ %t37, %logical_or_right_end_31 ]
  %t39 = load i8*, i8** %l0
  %t40 = load i8*, i8** %l1
  %t41 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t42 = load double, double* %l3
  %t43 = load double, double* %l4
  br i1 %t38, label %then4, label %merge5
then4:
  %t44 = bitcast i8* null to %NativeImport*
  ret %NativeImport* %t44
merge5:
  %t45 = load i8*, i8** %l0
  %t46 = load double, double* %l3
  %t47 = fptosi double %t46 to i64
  %t48 = call i8* @sailfin_runtime_substring(i8* %t45, i64 0, i64 %t47)
  %t49 = call i8* @trim_text(i8* %t48)
  store i8* %t49, i8** %l1
  %t50 = load i8*, i8** %l0
  %t51 = load double, double* %l3
  %t52 = sitofp i64 1 to double
  %t53 = fadd double %t51, %t52
  %t54 = load double, double* %l4
  %t55 = fptosi double %t53 to i64
  %t56 = fptosi double %t54 to i64
  %t57 = call i8* @sailfin_runtime_substring(i8* %t50, i64 %t55, i64 %t56)
  store i8* %t57, i8** %l5
  %t58 = load i8*, i8** %l5
  %t59 = call { %NativeImportSpecifier*, i64 }* @parse_import_specifiers(i8* %t58)
  store { %NativeImportSpecifier*, i64 }* %t59, { %NativeImportSpecifier*, i64 }** %l2
  %t60 = load i8*, i8** %l1
  %t61 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  br label %merge3
merge3:
  %t62 = phi i8* [ %t60, %merge5 ], [ %t22, %merge1 ]
  %t63 = phi { %NativeImportSpecifier*, i64 }* [ %t61, %merge5 ], [ %t23, %merge1 ]
  store i8* %t62, i8** %l1
  store { %NativeImportSpecifier*, i64 }* %t63, { %NativeImportSpecifier*, i64 }** %l2
  %t64 = load i8*, i8** %l1
  %t65 = call i8* @trim_text(i8* %t64)
  %t66 = call i8* @strip_quotes(i8* %t65)
  store i8* %t66, i8** %l1
  %t67 = insertvalue %NativeImport undef, i8* %kind, 0
  %t68 = load i8*, i8** %l1
  %t69 = insertvalue %NativeImport %t67, i8* %t68, 1
  %t70 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t71 = bitcast { %NativeImportSpecifier*, i64 }* %t70 to { %NativeImportSpecifier**, i64 }*
  %t72 = insertvalue %NativeImport %t69, { %NativeImportSpecifier**, i64 }* %t71, 2
  %t73 = alloca %NativeImport
  store %NativeImport %t72, %NativeImport* %t73
  ret %NativeImport* %t73
}

define { %NativeImportSpecifier*, i64 }* @parse_import_specifiers(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { %NativeImportSpecifier*, i64 }*
  %l3 = alloca double
  %l4 = alloca %NativeImportSpecifier
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = alloca [0 x %NativeImportSpecifier]
  %t6 = getelementptr [0 x %NativeImportSpecifier], [0 x %NativeImportSpecifier]* %t5, i32 0, i32 0
  %t7 = alloca { %NativeImportSpecifier*, i64 }
  %t8 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t7, i32 0, i32 0
  store %NativeImportSpecifier* %t6, %NativeImportSpecifier** %t8
  %t9 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  ret { %NativeImportSpecifier*, i64 }* %t7
merge1:
  %t10 = load i8*, i8** %l0
  %t11 = call { i8**, i64 }* @split_comma_separated(i8* %t10)
  store { i8**, i64 }* %t11, { i8**, i64 }** %l1
  %t12 = alloca [0 x %NativeImportSpecifier]
  %t13 = getelementptr [0 x %NativeImportSpecifier], [0 x %NativeImportSpecifier]* %t12, i32 0, i32 0
  %t14 = alloca { %NativeImportSpecifier*, i64 }
  %t15 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t14, i32 0, i32 0
  store %NativeImportSpecifier* %t13, %NativeImportSpecifier** %t15
  %t16 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  store { %NativeImportSpecifier*, i64 }* %t14, { %NativeImportSpecifier*, i64 }** %l2
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l3
  %t18 = load i8*, i8** %l0
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t20 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t21 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t71 = phi { %NativeImportSpecifier*, i64 }* [ %t20, %merge1 ], [ %t69, %loop.latch4 ]
  %t72 = phi double [ %t21, %merge1 ], [ %t70, %loop.latch4 ]
  store { %NativeImportSpecifier*, i64 }* %t71, { %NativeImportSpecifier*, i64 }** %l2
  store double %t72, double* %l3
  br label %loop.body3
loop.body3:
  %t22 = load double, double* %l3
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t24 = load { i8**, i64 }, { i8**, i64 }* %t23
  %t25 = extractvalue { i8**, i64 } %t24, 1
  %t26 = sitofp i64 %t25 to double
  %t27 = fcmp oge double %t22, %t26
  %t28 = load i8*, i8** %l0
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t30 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t31 = load double, double* %l3
  br i1 %t27, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t33 = load double, double* %l3
  %t34 = fptosi double %t33 to i64
  %t35 = load { i8**, i64 }, { i8**, i64 }* %t32
  %t36 = extractvalue { i8**, i64 } %t35, 0
  %t37 = extractvalue { i8**, i64 } %t35, 1
  %t38 = icmp uge i64 %t34, %t37
  ; bounds check: %t38 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t34, i64 %t37)
  %t39 = getelementptr i8*, i8** %t36, i64 %t34
  %t40 = load i8*, i8** %t39
  %t41 = call %NativeImportSpecifier @parse_single_specifier(i8* %t40)
  store %NativeImportSpecifier %t41, %NativeImportSpecifier* %l4
  %t42 = load %NativeImportSpecifier, %NativeImportSpecifier* %l4
  %t43 = extractvalue %NativeImportSpecifier %t42, 0
  %t44 = call i64 @sailfin_runtime_string_length(i8* %t43)
  %t45 = icmp sgt i64 %t44, 0
  %t46 = load i8*, i8** %l0
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t48 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t49 = load double, double* %l3
  %t50 = load %NativeImportSpecifier, %NativeImportSpecifier* %l4
  br i1 %t45, label %then8, label %merge9
then8:
  %t51 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t52 = load %NativeImportSpecifier, %NativeImportSpecifier* %l4
  %t53 = call noalias i8* @malloc(i64 16)
  %t54 = bitcast i8* %t53 to %NativeImportSpecifier*
  store %NativeImportSpecifier %t52, %NativeImportSpecifier* %t54
  %t55 = alloca [1 x i8*]
  %t56 = getelementptr [1 x i8*], [1 x i8*]* %t55, i32 0, i32 0
  %t57 = getelementptr i8*, i8** %t56, i64 0
  store i8* %t53, i8** %t57
  %t58 = alloca { i8**, i64 }
  %t59 = getelementptr { i8**, i64 }, { i8**, i64 }* %t58, i32 0, i32 0
  store i8** %t56, i8*** %t59
  %t60 = getelementptr { i8**, i64 }, { i8**, i64 }* %t58, i32 0, i32 1
  store i64 1, i64* %t60
  %t61 = bitcast { %NativeImportSpecifier*, i64 }* %t51 to { i8**, i64 }*
  %t62 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t61, { i8**, i64 }* %t58)
  %t63 = bitcast { i8**, i64 }* %t62 to { %NativeImportSpecifier*, i64 }*
  store { %NativeImportSpecifier*, i64 }* %t63, { %NativeImportSpecifier*, i64 }** %l2
  %t64 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  br label %merge9
merge9:
  %t65 = phi { %NativeImportSpecifier*, i64 }* [ %t64, %then8 ], [ %t48, %merge7 ]
  store { %NativeImportSpecifier*, i64 }* %t65, { %NativeImportSpecifier*, i64 }** %l2
  %t66 = load double, double* %l3
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %t66, %t67
  store double %t68, double* %l3
  br label %loop.latch4
loop.latch4:
  %t69 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t70 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t73 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t74 = load double, double* %l3
  %t75 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  ret { %NativeImportSpecifier*, i64 }* %t75
}

define %NativeImportSpecifier @parse_single_specifier(i8* %entry) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca i8*
  %t0 = call i8* @trim_text(i8* %entry)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t6 = insertvalue %NativeImportSpecifier undef, i8* %s5, 0
  %t7 = insertvalue %NativeImportSpecifier %t6, i8* null, 1
  ret %NativeImportSpecifier %t7
merge1:
  %s8 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175713983, i32 0, i32 0
  store i8* %s8, i8** %l1
  %t9 = load i8*, i8** %l0
  %t10 = load i8*, i8** %l1
  %t11 = call double @index_of(i8* %t9, i8* %t10)
  store double %t11, double* %l2
  %t12 = load double, double* %l2
  %t13 = sitofp i64 0 to double
  %t14 = fcmp olt double %t12, %t13
  %t15 = load i8*, i8** %l0
  %t16 = load i8*, i8** %l1
  %t17 = load double, double* %l2
  br i1 %t14, label %then2, label %merge3
then2:
  %t18 = load i8*, i8** %l0
  %t19 = insertvalue %NativeImportSpecifier undef, i8* %t18, 0
  %t20 = insertvalue %NativeImportSpecifier %t19, i8* null, 1
  ret %NativeImportSpecifier %t20
merge3:
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l2
  %t23 = fptosi double %t22 to i64
  %t24 = call i8* @sailfin_runtime_substring(i8* %t21, i64 0, i64 %t23)
  %t25 = call i8* @trim_text(i8* %t24)
  store i8* %t25, i8** %l3
  %t26 = load i8*, i8** %l0
  %t27 = load double, double* %l2
  %t28 = load i8*, i8** %l1
  %t29 = call i64 @sailfin_runtime_string_length(i8* %t28)
  %t30 = sitofp i64 %t29 to double
  %t31 = fadd double %t27, %t30
  %t32 = load i8*, i8** %l0
  %t33 = call i64 @sailfin_runtime_string_length(i8* %t32)
  %t34 = fptosi double %t31 to i64
  %t35 = call i8* @sailfin_runtime_substring(i8* %t26, i64 %t34, i64 %t33)
  %t36 = call i8* @trim_text(i8* %t35)
  store i8* %t36, i8** %l4
  %t37 = load i8*, i8** %l4
  %t38 = call i64 @sailfin_runtime_string_length(i8* %t37)
  %t39 = icmp eq i64 %t38, 0
  %t40 = load i8*, i8** %l0
  %t41 = load i8*, i8** %l1
  %t42 = load double, double* %l2
  %t43 = load i8*, i8** %l3
  %t44 = load i8*, i8** %l4
  br i1 %t39, label %then4, label %merge5
then4:
  %t45 = load i8*, i8** %l3
  %t46 = insertvalue %NativeImportSpecifier undef, i8* %t45, 0
  %t47 = insertvalue %NativeImportSpecifier %t46, i8* null, 1
  ret %NativeImportSpecifier %t47
merge5:
  %t48 = load i8*, i8** %l3
  %t49 = insertvalue %NativeImportSpecifier undef, i8* %t48, 0
  %t50 = load i8*, i8** %l4
  %t51 = insertvalue %NativeImportSpecifier %t49, i8* %t50, 1
  ret %NativeImportSpecifier %t51
}

define %StructParseResult @parse_struct_definition({ i8**, i64 }* %lines, double %start_index) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca %StructHeaderParse
  %l4 = alloca i8*
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca { %NativeStructField*, i64 }*
  %l7 = alloca { %NativeFunction*, i64 }*
  %l8 = alloca %NativeFunction*
  %l9 = alloca %NativeSourceSpan*
  %l10 = alloca %NativeSourceSpan*
  %l11 = alloca { %NativeStructLayoutField*, i64 }*
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca i1
  %l15 = alloca i1
  %l16 = alloca double
  %l17 = alloca %NativeStructLayout*
  %l18 = alloca i8*
  %l19 = alloca %NativeParameter*
  %l20 = alloca %NativeSourceSpan*
  %l21 = alloca %NativeSourceSpan*
  %l22 = alloca %InstructionParseResult
  %l23 = alloca double
  %l24 = alloca i8*
  %l25 = alloca %StructLayoutHeaderParse
  %l26 = alloca %StructLayoutFieldParse
  %l27 = alloca %NativeStructField*
  %l28 = alloca i8*
  %l29 = alloca %NativeStructLayout*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = fptosi double %start_index to i64
  %t6 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t7 = extractvalue { i8**, i64 } %t6, 0
  %t8 = extractvalue { i8**, i64 } %t6, 1
  %t9 = icmp uge i64 %t5, %t8
  ; bounds check: %t9 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t5, i64 %t8)
  %t10 = getelementptr i8*, i8** %t7, i64 %t5
  %t11 = load i8*, i8** %t10
  %t12 = call i8* @trim_text(i8* %t11)
  store i8* %t12, i8** %l1
  %t13 = load i8*, i8** %l1
  %s14 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h2093451461, i32 0, i32 0
  %t15 = call i8* @strip_prefix(i8* %t13, i8* %s14)
  %t16 = call i8* @trim_text(i8* %t15)
  store i8* %t16, i8** %l2
  %t17 = load i8*, i8** %l2
  %t18 = call %StructHeaderParse @parse_struct_header(i8* %t17)
  store %StructHeaderParse %t18, %StructHeaderParse* %l3
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t21 = extractvalue %StructHeaderParse %t20, 2
  %t22 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t19, { i8**, i64 }* %t21)
  store { i8**, i64 }* %t22, { i8**, i64 }** %l0
  %t23 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t24 = extractvalue %StructHeaderParse %t23, 0
  store i8* %t24, i8** %l4
  %t25 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t26 = extractvalue %StructHeaderParse %t25, 1
  store { i8**, i64 }* %t26, { i8**, i64 }** %l5
  %t27 = load i8*, i8** %l4
  %t28 = call i64 @sailfin_runtime_string_length(i8* %t27)
  %t29 = icmp eq i64 %t28, 0
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load i8*, i8** %l1
  %t32 = load i8*, i8** %l2
  %t33 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t34 = load i8*, i8** %l4
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br i1 %t29, label %then0, label %merge1
then0:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s37 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1478667446, i32 0, i32 0
  %t38 = load i8*, i8** %l1
  %t39 = call i8* @sailfin_runtime_string_concat(i8* %s37, i8* %t38)
  %t40 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t36, i8* %t39)
  store { i8**, i64 }* %t40, { i8**, i64 }** %l0
  %t41 = bitcast i8* null to %NativeStruct*
  %t42 = insertvalue %StructParseResult undef, %NativeStruct* %t41, 0
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %start_index, %t43
  %t45 = insertvalue %StructParseResult %t42, double %t44, 1
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = insertvalue %StructParseResult %t45, { i8**, i64 }* %t46, 2
  ret %StructParseResult %t47
merge1:
  %t48 = alloca [0 x %NativeStructField]
  %t49 = getelementptr [0 x %NativeStructField], [0 x %NativeStructField]* %t48, i32 0, i32 0
  %t50 = alloca { %NativeStructField*, i64 }
  %t51 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t50, i32 0, i32 0
  store %NativeStructField* %t49, %NativeStructField** %t51
  %t52 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t50, i32 0, i32 1
  store i64 0, i64* %t52
  store { %NativeStructField*, i64 }* %t50, { %NativeStructField*, i64 }** %l6
  %t53 = alloca [0 x %NativeFunction]
  %t54 = getelementptr [0 x %NativeFunction], [0 x %NativeFunction]* %t53, i32 0, i32 0
  %t55 = alloca { %NativeFunction*, i64 }
  %t56 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t55, i32 0, i32 0
  store %NativeFunction* %t54, %NativeFunction** %t56
  %t57 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t55, i32 0, i32 1
  store i64 0, i64* %t57
  store { %NativeFunction*, i64 }* %t55, { %NativeFunction*, i64 }** %l7
  %t58 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t58, %NativeFunction** %l8
  %t59 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t59, %NativeSourceSpan** %l9
  %t60 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t60, %NativeSourceSpan** %l10
  %t61 = alloca [0 x %NativeStructLayoutField]
  %t62 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* %t61, i32 0, i32 0
  %t63 = alloca { %NativeStructLayoutField*, i64 }
  %t64 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t63, i32 0, i32 0
  store %NativeStructLayoutField* %t62, %NativeStructLayoutField** %t64
  %t65 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t63, i32 0, i32 1
  store i64 0, i64* %t65
  store { %NativeStructLayoutField*, i64 }* %t63, { %NativeStructLayoutField*, i64 }** %l11
  %t66 = sitofp i64 0 to double
  store double %t66, double* %l12
  %t67 = sitofp i64 0 to double
  store double %t67, double* %l13
  store i1 0, i1* %l14
  store i1 0, i1* %l15
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %start_index, %t68
  store double %t69, double* %l16
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load i8*, i8** %l1
  %t72 = load i8*, i8** %l2
  %t73 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t74 = load i8*, i8** %l4
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t76 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t77 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t78 = load %NativeFunction*, %NativeFunction** %l8
  %t79 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t80 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t81 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t82 = load double, double* %l12
  %t83 = load double, double* %l13
  %t84 = load i1, i1* %l14
  %t85 = load i1, i1* %l15
  %t86 = load double, double* %l16
  br label %loop.header2
loop.header2:
  %t1203 = phi { i8**, i64 }* [ %t70, %merge1 ], [ %t1191, %loop.latch4 ]
  %t1204 = phi double [ %t86, %merge1 ], [ %t1192, %loop.latch4 ]
  %t1205 = phi { %NativeFunction*, i64 }* [ %t77, %merge1 ], [ %t1193, %loop.latch4 ]
  %t1206 = phi %NativeFunction* [ %t78, %merge1 ], [ %t1194, %loop.latch4 ]
  %t1207 = phi %NativeSourceSpan* [ %t79, %merge1 ], [ %t1195, %loop.latch4 ]
  %t1208 = phi %NativeSourceSpan* [ %t80, %merge1 ], [ %t1196, %loop.latch4 ]
  %t1209 = phi double [ %t82, %merge1 ], [ %t1197, %loop.latch4 ]
  %t1210 = phi double [ %t83, %merge1 ], [ %t1198, %loop.latch4 ]
  %t1211 = phi i1 [ %t84, %merge1 ], [ %t1199, %loop.latch4 ]
  %t1212 = phi { %NativeStructLayoutField*, i64 }* [ %t81, %merge1 ], [ %t1200, %loop.latch4 ]
  %t1213 = phi i1 [ %t85, %merge1 ], [ %t1201, %loop.latch4 ]
  %t1214 = phi { %NativeStructField*, i64 }* [ %t76, %merge1 ], [ %t1202, %loop.latch4 ]
  store { i8**, i64 }* %t1203, { i8**, i64 }** %l0
  store double %t1204, double* %l16
  store { %NativeFunction*, i64 }* %t1205, { %NativeFunction*, i64 }** %l7
  store %NativeFunction* %t1206, %NativeFunction** %l8
  store %NativeSourceSpan* %t1207, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t1208, %NativeSourceSpan** %l10
  store double %t1209, double* %l12
  store double %t1210, double* %l13
  store i1 %t1211, i1* %l14
  store { %NativeStructLayoutField*, i64 }* %t1212, { %NativeStructLayoutField*, i64 }** %l11
  store i1 %t1213, i1* %l15
  store { %NativeStructField*, i64 }* %t1214, { %NativeStructField*, i64 }** %l6
  br label %loop.body3
loop.body3:
  %t87 = load double, double* %l16
  %t88 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t89 = extractvalue { i8**, i64 } %t88, 1
  %t90 = sitofp i64 %t89 to double
  %t91 = fcmp oge double %t87, %t90
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t93 = load i8*, i8** %l1
  %t94 = load i8*, i8** %l2
  %t95 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t96 = load i8*, i8** %l4
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t98 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t99 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t100 = load %NativeFunction*, %NativeFunction** %l8
  %t101 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t102 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t103 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t104 = load double, double* %l12
  %t105 = load double, double* %l13
  %t106 = load i1, i1* %l14
  %t107 = load i1, i1* %l15
  %t108 = load double, double* %l16
  br i1 %t91, label %then6, label %merge7
then6:
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s110 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1216366549, i32 0, i32 0
  %t111 = load i8*, i8** %l4
  %t112 = call i8* @sailfin_runtime_string_concat(i8* %s110, i8* %t111)
  %t113 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t109, i8* %t112)
  store { i8**, i64 }* %t113, { i8**, i64 }** %l0
  %t114 = bitcast i8* null to %NativeStructLayout*
  store %NativeStructLayout* %t114, %NativeStructLayout** %l17
  %t115 = load i1, i1* %l14
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t117 = load i8*, i8** %l1
  %t118 = load i8*, i8** %l2
  %t119 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t120 = load i8*, i8** %l4
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t122 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t123 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t124 = load %NativeFunction*, %NativeFunction** %l8
  %t125 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t126 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t127 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t128 = load double, double* %l12
  %t129 = load double, double* %l13
  %t130 = load i1, i1* %l14
  %t131 = load i1, i1* %l15
  %t132 = load double, double* %l16
  %t133 = load %NativeStructLayout*, %NativeStructLayout** %l17
  br i1 %t115, label %then8, label %merge9
then8:
  %t134 = load double, double* %l12
  %t135 = insertvalue %NativeStructLayout undef, double %t134, 0
  %t136 = load double, double* %l13
  %t137 = insertvalue %NativeStructLayout %t135, double %t136, 1
  %t138 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t139 = bitcast { %NativeStructLayoutField*, i64 }* %t138 to { %NativeStructLayoutField**, i64 }*
  %t140 = insertvalue %NativeStructLayout %t137, { %NativeStructLayoutField**, i64 }* %t139, 2
  %t141 = alloca %NativeStructLayout
  store %NativeStructLayout %t140, %NativeStructLayout* %t141
  store %NativeStructLayout* %t141, %NativeStructLayout** %l17
  %t142 = load %NativeStructLayout*, %NativeStructLayout** %l17
  br label %merge9
merge9:
  %t143 = phi %NativeStructLayout* [ %t142, %then8 ], [ %t133, %then6 ]
  store %NativeStructLayout* %t143, %NativeStructLayout** %l17
  %t144 = load i8*, i8** %l4
  %t145 = insertvalue %NativeStruct undef, i8* %t144, 0
  %t146 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t147 = bitcast { %NativeStructField*, i64 }* %t146 to { %NativeStructField**, i64 }*
  %t148 = insertvalue %NativeStruct %t145, { %NativeStructField**, i64 }* %t147, 1
  %t149 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t150 = bitcast { %NativeFunction*, i64 }* %t149 to { %NativeFunction**, i64 }*
  %t151 = insertvalue %NativeStruct %t148, { %NativeFunction**, i64 }* %t150, 2
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t153 = insertvalue %NativeStruct %t151, { i8**, i64 }* %t152, 3
  %t154 = load %NativeStructLayout*, %NativeStructLayout** %l17
  %t155 = insertvalue %NativeStruct %t153, %NativeStructLayout* %t154, 4
  %t156 = alloca %NativeStruct
  store %NativeStruct %t155, %NativeStruct* %t156
  %t157 = insertvalue %StructParseResult undef, %NativeStruct* %t156, 0
  %t158 = load double, double* %l16
  %t159 = insertvalue %StructParseResult %t157, double %t158, 1
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t161 = insertvalue %StructParseResult %t159, { i8**, i64 }* %t160, 2
  ret %StructParseResult %t161
merge7:
  %t162 = load double, double* %l16
  %t163 = fptosi double %t162 to i64
  %t164 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t165 = extractvalue { i8**, i64 } %t164, 0
  %t166 = extractvalue { i8**, i64 } %t164, 1
  %t167 = icmp uge i64 %t163, %t166
  ; bounds check: %t167 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t163, i64 %t166)
  %t168 = getelementptr i8*, i8** %t165, i64 %t163
  %t169 = load i8*, i8** %t168
  %t170 = call i8* @trim_text(i8* %t169)
  store i8* %t170, i8** %l18
  %t172 = load i8*, i8** %l18
  %t173 = call i64 @sailfin_runtime_string_length(i8* %t172)
  %t174 = icmp eq i64 %t173, 0
  br label %logical_or_entry_171

logical_or_entry_171:
  br i1 %t174, label %logical_or_merge_171, label %logical_or_right_171

logical_or_right_171:
  %t175 = load i8*, i8** %l18
  %t176 = alloca [2 x i8], align 1
  %t177 = getelementptr [2 x i8], [2 x i8]* %t176, i32 0, i32 0
  store i8 59, i8* %t177
  %t178 = getelementptr [2 x i8], [2 x i8]* %t176, i32 0, i32 1
  store i8 0, i8* %t178
  %t179 = getelementptr [2 x i8], [2 x i8]* %t176, i32 0, i32 0
  %t180 = call i1 @starts_with(i8* %t175, i8* %t179)
  br label %logical_or_right_end_171

logical_or_right_end_171:
  br label %logical_or_merge_171

logical_or_merge_171:
  %t181 = phi i1 [ true, %logical_or_entry_171 ], [ %t180, %logical_or_right_end_171 ]
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t183 = load i8*, i8** %l1
  %t184 = load i8*, i8** %l2
  %t185 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t186 = load i8*, i8** %l4
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t188 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t189 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t190 = load %NativeFunction*, %NativeFunction** %l8
  %t191 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t192 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t193 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t194 = load double, double* %l12
  %t195 = load double, double* %l13
  %t196 = load i1, i1* %l14
  %t197 = load i1, i1* %l15
  %t198 = load double, double* %l16
  %t199 = load i8*, i8** %l18
  br i1 %t181, label %then10, label %merge11
then10:
  %t200 = load double, double* %l16
  %t201 = sitofp i64 1 to double
  %t202 = fadd double %t200, %t201
  store double %t202, double* %l16
  br label %loop.latch4
merge11:
  %t203 = load i8*, i8** %l18
  %s204 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h2070880298, i32 0, i32 0
  %t205 = icmp eq i8* %t203, %s204
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t207 = load i8*, i8** %l1
  %t208 = load i8*, i8** %l2
  %t209 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t210 = load i8*, i8** %l4
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t212 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t213 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t214 = load %NativeFunction*, %NativeFunction** %l8
  %t215 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t216 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t217 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t218 = load double, double* %l12
  %t219 = load double, double* %l13
  %t220 = load i1, i1* %l14
  %t221 = load i1, i1* %l15
  %t222 = load double, double* %l16
  %t223 = load i8*, i8** %l18
  br i1 %t205, label %then12, label %merge13
then12:
  %t224 = load %NativeFunction*, %NativeFunction** %l8
  %t225 = icmp ne %NativeFunction* %t224, null
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t227 = load i8*, i8** %l1
  %t228 = load i8*, i8** %l2
  %t229 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t230 = load i8*, i8** %l4
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t232 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t233 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t234 = load %NativeFunction*, %NativeFunction** %l8
  %t235 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t236 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t237 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t238 = load double, double* %l12
  %t239 = load double, double* %l13
  %t240 = load i1, i1* %l14
  %t241 = load i1, i1* %l15
  %t242 = load double, double* %l16
  %t243 = load i8*, i8** %l18
  br i1 %t225, label %then14, label %merge15
then14:
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s245 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.len30.h208276320, i32 0, i32 0
  %t246 = load i8*, i8** %l4
  %t247 = call i8* @sailfin_runtime_string_concat(i8* %s245, i8* %t246)
  %t248 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t244, i8* %t247)
  store { i8**, i64 }* %t248, { i8**, i64 }** %l0
  %t249 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t250 = load %NativeFunction*, %NativeFunction** %l8
  %t251 = load %NativeFunction, %NativeFunction* %t250
  %t252 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t249, %NativeFunction %t251)
  store { %NativeFunction*, i64 }* %t252, { %NativeFunction*, i64 }** %l7
  %t253 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t253, %NativeFunction** %l8
  %t254 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t254, %NativeSourceSpan** %l9
  %t255 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t255, %NativeSourceSpan** %l10
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t257 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t258 = load %NativeFunction*, %NativeFunction** %l8
  %t259 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t260 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge15
merge15:
  %t261 = phi { i8**, i64 }* [ %t256, %then14 ], [ %t226, %then12 ]
  %t262 = phi { %NativeFunction*, i64 }* [ %t257, %then14 ], [ %t233, %then12 ]
  %t263 = phi %NativeFunction* [ %t258, %then14 ], [ %t234, %then12 ]
  %t264 = phi %NativeSourceSpan* [ %t259, %then14 ], [ %t235, %then12 ]
  %t265 = phi %NativeSourceSpan* [ %t260, %then14 ], [ %t236, %then12 ]
  store { i8**, i64 }* %t261, { i8**, i64 }** %l0
  store { %NativeFunction*, i64 }* %t262, { %NativeFunction*, i64 }** %l7
  store %NativeFunction* %t263, %NativeFunction** %l8
  store %NativeSourceSpan* %t264, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t265, %NativeSourceSpan** %l10
  %t266 = load double, double* %l16
  %t267 = sitofp i64 1 to double
  %t268 = fadd double %t266, %t267
  store double %t268, double* %l16
  br label %afterloop5
merge13:
  %t269 = load %NativeFunction*, %NativeFunction** %l8
  %t270 = icmp ne %NativeFunction* %t269, null
  %t271 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t272 = load i8*, i8** %l1
  %t273 = load i8*, i8** %l2
  %t274 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t275 = load i8*, i8** %l4
  %t276 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t277 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t278 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t279 = load %NativeFunction*, %NativeFunction** %l8
  %t280 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t281 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t282 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t283 = load double, double* %l12
  %t284 = load double, double* %l13
  %t285 = load i1, i1* %l14
  %t286 = load i1, i1* %l15
  %t287 = load double, double* %l16
  %t288 = load i8*, i8** %l18
  br i1 %t270, label %then16, label %merge17
then16:
  %t289 = load i8*, i8** %l18
  %s290 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h179409731, i32 0, i32 0
  %t291 = icmp eq i8* %t289, %s290
  %t292 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t293 = load i8*, i8** %l1
  %t294 = load i8*, i8** %l2
  %t295 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t296 = load i8*, i8** %l4
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t298 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t299 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t300 = load %NativeFunction*, %NativeFunction** %l8
  %t301 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t302 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t303 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t304 = load double, double* %l12
  %t305 = load double, double* %l13
  %t306 = load i1, i1* %l14
  %t307 = load i1, i1* %l15
  %t308 = load double, double* %l16
  %t309 = load i8*, i8** %l18
  br i1 %t291, label %then18, label %merge19
then18:
  %t310 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t311 = load %NativeFunction*, %NativeFunction** %l8
  %t312 = load %NativeFunction, %NativeFunction* %t311
  %t313 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t310, %NativeFunction %t312)
  store { %NativeFunction*, i64 }* %t313, { %NativeFunction*, i64 }** %l7
  %t314 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t314, %NativeFunction** %l8
  %t315 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t315, %NativeSourceSpan** %l9
  %t316 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t316, %NativeSourceSpan** %l10
  %t317 = load double, double* %l16
  %t318 = sitofp i64 1 to double
  %t319 = fadd double %t317, %t318
  store double %t319, double* %l16
  br label %loop.latch4
merge19:
  %t320 = load i8*, i8** %l18
  %s321 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1583308163, i32 0, i32 0
  %t322 = call i1 @starts_with(i8* %t320, i8* %s321)
  %t323 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t324 = load i8*, i8** %l1
  %t325 = load i8*, i8** %l2
  %t326 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t327 = load i8*, i8** %l4
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t329 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t330 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t331 = load %NativeFunction*, %NativeFunction** %l8
  %t332 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t333 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t334 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t335 = load double, double* %l12
  %t336 = load double, double* %l13
  %t337 = load i1, i1* %l14
  %t338 = load i1, i1* %l15
  %t339 = load double, double* %l16
  %t340 = load i8*, i8** %l18
  br i1 %t322, label %then20, label %merge21
then20:
  %t341 = load %NativeFunction*, %NativeFunction** %l8
  %t342 = load i8*, i8** %l18
  %s343 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1583308163, i32 0, i32 0
  %t344 = call i8* @strip_prefix(i8* %t342, i8* %s343)
  %t345 = load %NativeFunction, %NativeFunction* %t341
  %t346 = call %NativeFunction @apply_meta(%NativeFunction %t345, i8* %t344)
  %t347 = alloca %NativeFunction
  store %NativeFunction %t346, %NativeFunction* %t347
  store %NativeFunction* %t347, %NativeFunction** %l8
  %t348 = load double, double* %l16
  %t349 = sitofp i64 1 to double
  %t350 = fadd double %t348, %t349
  store double %t350, double* %l16
  br label %loop.latch4
merge21:
  %t351 = load i8*, i8** %l18
  %s352 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h130169768, i32 0, i32 0
  %t353 = call i1 @starts_with(i8* %t351, i8* %s352)
  %t354 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t355 = load i8*, i8** %l1
  %t356 = load i8*, i8** %l2
  %t357 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t358 = load i8*, i8** %l4
  %t359 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t360 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t361 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t362 = load %NativeFunction*, %NativeFunction** %l8
  %t363 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t364 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t365 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t366 = load double, double* %l12
  %t367 = load double, double* %l13
  %t368 = load i1, i1* %l14
  %t369 = load i1, i1* %l15
  %t370 = load double, double* %l16
  %t371 = load i8*, i8** %l18
  br i1 %t353, label %then22, label %merge23
then22:
  %t372 = load i8*, i8** %l18
  %s373 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h130169768, i32 0, i32 0
  %t374 = call i8* @strip_prefix(i8* %t372, i8* %s373)
  %t375 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t376 = call %NativeParameter* @parse_parameter_entry(i8* %t374, %NativeSourceSpan* %t375)
  store %NativeParameter* %t376, %NativeParameter** %l19
  %t377 = load %NativeParameter*, %NativeParameter** %l19
  %t378 = icmp eq %NativeParameter* %t377, null
  %t379 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t380 = load i8*, i8** %l1
  %t381 = load i8*, i8** %l2
  %t382 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t383 = load i8*, i8** %l4
  %t384 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t385 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t386 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t387 = load %NativeFunction*, %NativeFunction** %l8
  %t388 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t389 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t390 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t391 = load double, double* %l12
  %t392 = load double, double* %l13
  %t393 = load i1, i1* %l14
  %t394 = load i1, i1* %l15
  %t395 = load double, double* %l16
  %t396 = load i8*, i8** %l18
  %t397 = load %NativeParameter*, %NativeParameter** %l19
  br i1 %t378, label %then24, label %else25
then24:
  %t398 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s399 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.len34.h1211676914, i32 0, i32 0
  %t400 = load i8*, i8** %l18
  %t401 = call i8* @sailfin_runtime_string_concat(i8* %s399, i8* %t400)
  %t402 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t398, i8* %t401)
  store { i8**, i64 }* %t402, { i8**, i64 }** %l0
  %t403 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge26
else25:
  %t404 = load %NativeFunction*, %NativeFunction** %l8
  %t405 = load %NativeParameter*, %NativeParameter** %l19
  %t406 = load %NativeFunction, %NativeFunction* %t404
  %t407 = load %NativeParameter, %NativeParameter* %t405
  %t408 = call %NativeFunction @append_parameter(%NativeFunction %t406, %NativeParameter %t407)
  %t409 = alloca %NativeFunction
  store %NativeFunction %t408, %NativeFunction* %t409
  store %NativeFunction* %t409, %NativeFunction** %l8
  %t410 = load %NativeFunction*, %NativeFunction** %l8
  br label %merge26
merge26:
  %t411 = phi { i8**, i64 }* [ %t403, %then24 ], [ %t379, %else25 ]
  %t412 = phi %NativeFunction* [ %t387, %then24 ], [ %t410, %else25 ]
  store { i8**, i64 }* %t411, { i8**, i64 }** %l0
  store %NativeFunction* %t412, %NativeFunction** %l8
  %t413 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t413, %NativeSourceSpan** %l9
  %t414 = load double, double* %l16
  %t415 = sitofp i64 1 to double
  %t416 = fadd double %t414, %t415
  store double %t416, double* %l16
  br label %loop.latch4
merge23:
  %t417 = load i8*, i8** %l18
  %s418 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1951948513, i32 0, i32 0
  %t419 = call i1 @starts_with(i8* %t417, i8* %s418)
  %t420 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t421 = load i8*, i8** %l1
  %t422 = load i8*, i8** %l2
  %t423 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t424 = load i8*, i8** %l4
  %t425 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t426 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t427 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t428 = load %NativeFunction*, %NativeFunction** %l8
  %t429 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t430 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t431 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t432 = load double, double* %l12
  %t433 = load double, double* %l13
  %t434 = load i1, i1* %l14
  %t435 = load i1, i1* %l15
  %t436 = load double, double* %l16
  %t437 = load i8*, i8** %l18
  br i1 %t419, label %then27, label %merge28
then27:
  %t438 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s439 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.len36.h736848621, i32 0, i32 0
  %t440 = load i8*, i8** %l4
  %t441 = call i8* @sailfin_runtime_string_concat(i8* %s439, i8* %t440)
  %t442 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t438, i8* %t441)
  store { i8**, i64 }* %t442, { i8**, i64 }** %l0
  %t443 = load double, double* %l16
  %t444 = sitofp i64 1 to double
  %t445 = fadd double %t443, %t444
  store double %t445, double* %l16
  br label %loop.latch4
merge28:
  %t446 = load i8*, i8** %l18
  %s447 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1830497006, i32 0, i32 0
  %t448 = call i1 @starts_with(i8* %t446, i8* %s447)
  %t449 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t450 = load i8*, i8** %l1
  %t451 = load i8*, i8** %l2
  %t452 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t453 = load i8*, i8** %l4
  %t454 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t455 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t456 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t457 = load %NativeFunction*, %NativeFunction** %l8
  %t458 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t459 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t460 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t461 = load double, double* %l12
  %t462 = load double, double* %l13
  %t463 = load i1, i1* %l14
  %t464 = load i1, i1* %l15
  %t465 = load double, double* %l16
  %t466 = load i8*, i8** %l18
  br i1 %t448, label %then29, label %merge30
then29:
  %t467 = load i8*, i8** %l18
  %s468 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1830497006, i32 0, i32 0
  %t469 = call i8* @strip_prefix(i8* %t467, i8* %s468)
  %t470 = call %NativeSourceSpan* @parse_source_span(i8* %t469)
  store %NativeSourceSpan* %t470, %NativeSourceSpan** %l20
  %t471 = load %NativeSourceSpan*, %NativeSourceSpan** %l20
  %t472 = icmp eq %NativeSourceSpan* %t471, null
  %t473 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t474 = load i8*, i8** %l1
  %t475 = load i8*, i8** %l2
  %t476 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t477 = load i8*, i8** %l4
  %t478 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t479 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t480 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t481 = load %NativeFunction*, %NativeFunction** %l8
  %t482 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t483 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t484 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t485 = load double, double* %l12
  %t486 = load double, double* %l13
  %t487 = load i1, i1* %l14
  %t488 = load i1, i1* %l15
  %t489 = load double, double* %l16
  %t490 = load i8*, i8** %l18
  %t491 = load %NativeSourceSpan*, %NativeSourceSpan** %l20
  br i1 %t472, label %then31, label %else32
then31:
  %t492 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s493 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h762677253, i32 0, i32 0
  %t494 = load i8*, i8** %l18
  %t495 = call i8* @sailfin_runtime_string_concat(i8* %s493, i8* %t494)
  %t496 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t492, i8* %t495)
  store { i8**, i64 }* %t496, { i8**, i64 }** %l0
  %t497 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge33
else32:
  %t498 = load %NativeSourceSpan*, %NativeSourceSpan** %l20
  store %NativeSourceSpan* %t498, %NativeSourceSpan** %l9
  %t499 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge33
merge33:
  %t500 = phi { i8**, i64 }* [ %t497, %then31 ], [ %t473, %else32 ]
  %t501 = phi %NativeSourceSpan* [ %t482, %then31 ], [ %t499, %else32 ]
  store { i8**, i64 }* %t500, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t501, %NativeSourceSpan** %l9
  %t502 = load double, double* %l16
  %t503 = sitofp i64 1 to double
  %t504 = fadd double %t502, %t503
  store double %t504, double* %l16
  br label %loop.latch4
merge30:
  %t505 = load i8*, i8** %l18
  %s506 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1513373193, i32 0, i32 0
  %t507 = call i1 @starts_with(i8* %t505, i8* %s506)
  %t508 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t509 = load i8*, i8** %l1
  %t510 = load i8*, i8** %l2
  %t511 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t512 = load i8*, i8** %l4
  %t513 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t514 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t515 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t516 = load %NativeFunction*, %NativeFunction** %l8
  %t517 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t518 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t519 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t520 = load double, double* %l12
  %t521 = load double, double* %l13
  %t522 = load i1, i1* %l14
  %t523 = load i1, i1* %l15
  %t524 = load double, double* %l16
  %t525 = load i8*, i8** %l18
  br i1 %t507, label %then34, label %merge35
then34:
  %t526 = load i8*, i8** %l18
  %s527 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1513373193, i32 0, i32 0
  %t528 = call i8* @strip_prefix(i8* %t526, i8* %s527)
  %t529 = call %NativeSourceSpan* @parse_source_span(i8* %t528)
  store %NativeSourceSpan* %t529, %NativeSourceSpan** %l21
  %t530 = load %NativeSourceSpan*, %NativeSourceSpan** %l21
  %t531 = icmp eq %NativeSourceSpan* %t530, null
  %t532 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t533 = load i8*, i8** %l1
  %t534 = load i8*, i8** %l2
  %t535 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t536 = load i8*, i8** %l4
  %t537 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t538 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t539 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t540 = load %NativeFunction*, %NativeFunction** %l8
  %t541 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t542 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t543 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t544 = load double, double* %l12
  %t545 = load double, double* %l13
  %t546 = load i1, i1* %l14
  %t547 = load i1, i1* %l15
  %t548 = load double, double* %l16
  %t549 = load i8*, i8** %l18
  %t550 = load %NativeSourceSpan*, %NativeSourceSpan** %l21
  br i1 %t531, label %then36, label %else37
then36:
  %t551 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s552 = getelementptr inbounds [44 x i8], [44 x i8]* @.str.len43.h1714227133, i32 0, i32 0
  %t553 = load i8*, i8** %l18
  %t554 = call i8* @sailfin_runtime_string_concat(i8* %s552, i8* %t553)
  %t555 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t551, i8* %t554)
  store { i8**, i64 }* %t555, { i8**, i64 }** %l0
  %t556 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge38
else37:
  %t557 = load %NativeSourceSpan*, %NativeSourceSpan** %l21
  store %NativeSourceSpan* %t557, %NativeSourceSpan** %l10
  %t558 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge38
merge38:
  %t559 = phi { i8**, i64 }* [ %t556, %then36 ], [ %t532, %else37 ]
  %t560 = phi %NativeSourceSpan* [ %t542, %then36 ], [ %t558, %else37 ]
  store { i8**, i64 }* %t559, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t560, %NativeSourceSpan** %l10
  %t561 = load double, double* %l16
  %t562 = sitofp i64 1 to double
  %t563 = fadd double %t561, %t562
  store double %t563, double* %l16
  br label %loop.latch4
merge35:
  %t564 = load i8*, i8** %l18
  %t565 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t566 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t567 = call %InstructionParseResult @parse_instruction(i8* %t564, %NativeSourceSpan* %t565, %NativeSourceSpan* %t566)
  store %InstructionParseResult %t567, %InstructionParseResult* %l22
  %t568 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t569 = extractvalue %InstructionParseResult %t568, 1
  %t570 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t571 = load i8*, i8** %l1
  %t572 = load i8*, i8** %l2
  %t573 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t574 = load i8*, i8** %l4
  %t575 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t576 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t577 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t578 = load %NativeFunction*, %NativeFunction** %l8
  %t579 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t580 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t581 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t582 = load double, double* %l12
  %t583 = load double, double* %l13
  %t584 = load i1, i1* %l14
  %t585 = load i1, i1* %l15
  %t586 = load double, double* %l16
  %t587 = load i8*, i8** %l18
  %t588 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t569, label %then39, label %else40
then39:
  %t589 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t589, %NativeSourceSpan** %l9
  %t590 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge41
else40:
  %t591 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t592 = icmp ne %NativeSourceSpan* %t591, null
  %t593 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t594 = load i8*, i8** %l1
  %t595 = load i8*, i8** %l2
  %t596 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t597 = load i8*, i8** %l4
  %t598 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t599 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t600 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t601 = load %NativeFunction*, %NativeFunction** %l8
  %t602 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t603 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t604 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t605 = load double, double* %l12
  %t606 = load double, double* %l13
  %t607 = load i1, i1* %l14
  %t608 = load i1, i1* %l15
  %t609 = load double, double* %l16
  %t610 = load i8*, i8** %l18
  %t611 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t592, label %then42, label %merge43
then42:
  %t612 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s613 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1601547567, i32 0, i32 0
  %t614 = load i8*, i8** %l18
  %t615 = call i8* @sailfin_runtime_string_concat(i8* %s613, i8* %t614)
  %t616 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t612, i8* %t615)
  store { i8**, i64 }* %t616, { i8**, i64 }** %l0
  %t617 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t617, %NativeSourceSpan** %l9
  %t618 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t619 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge43
merge43:
  %t620 = phi { i8**, i64 }* [ %t618, %then42 ], [ %t593, %else40 ]
  %t621 = phi %NativeSourceSpan* [ %t619, %then42 ], [ %t602, %else40 ]
  store { i8**, i64 }* %t620, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t621, %NativeSourceSpan** %l9
  %t622 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t623 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge41
merge41:
  %t624 = phi %NativeSourceSpan* [ %t590, %then39 ], [ %t623, %merge43 ]
  %t625 = phi { i8**, i64 }* [ %t570, %then39 ], [ %t622, %merge43 ]
  store %NativeSourceSpan* %t624, %NativeSourceSpan** %l9
  store { i8**, i64 }* %t625, { i8**, i64 }** %l0
  %t626 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t627 = extractvalue %InstructionParseResult %t626, 2
  %t628 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t629 = load i8*, i8** %l1
  %t630 = load i8*, i8** %l2
  %t631 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t632 = load i8*, i8** %l4
  %t633 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t634 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t635 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t636 = load %NativeFunction*, %NativeFunction** %l8
  %t637 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t638 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t639 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t640 = load double, double* %l12
  %t641 = load double, double* %l13
  %t642 = load i1, i1* %l14
  %t643 = load i1, i1* %l15
  %t644 = load double, double* %l16
  %t645 = load i8*, i8** %l18
  %t646 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t627, label %then44, label %else45
then44:
  %t647 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t647, %NativeSourceSpan** %l10
  %t648 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge46
else45:
  %t649 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t650 = icmp ne %NativeSourceSpan* %t649, null
  %t651 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t652 = load i8*, i8** %l1
  %t653 = load i8*, i8** %l2
  %t654 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t655 = load i8*, i8** %l4
  %t656 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t657 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t658 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t659 = load %NativeFunction*, %NativeFunction** %l8
  %t660 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t661 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t662 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t663 = load double, double* %l12
  %t664 = load double, double* %l13
  %t665 = load i1, i1* %l14
  %t666 = load i1, i1* %l15
  %t667 = load double, double* %l16
  %t668 = load i8*, i8** %l18
  %t669 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t650, label %then47, label %merge48
then47:
  %t670 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s671 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h35508704, i32 0, i32 0
  %t672 = load i8*, i8** %l18
  %t673 = call i8* @sailfin_runtime_string_concat(i8* %s671, i8* %t672)
  %t674 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t670, i8* %t673)
  store { i8**, i64 }* %t674, { i8**, i64 }** %l0
  %t675 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t675, %NativeSourceSpan** %l10
  %t676 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t677 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge48
merge48:
  %t678 = phi { i8**, i64 }* [ %t676, %then47 ], [ %t651, %else45 ]
  %t679 = phi %NativeSourceSpan* [ %t677, %then47 ], [ %t661, %else45 ]
  store { i8**, i64 }* %t678, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t679, %NativeSourceSpan** %l10
  %t680 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t681 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge46
merge46:
  %t682 = phi %NativeSourceSpan* [ %t648, %then44 ], [ %t681, %merge48 ]
  %t683 = phi { i8**, i64 }* [ %t628, %then44 ], [ %t680, %merge48 ]
  store %NativeSourceSpan* %t682, %NativeSourceSpan** %l10
  store { i8**, i64 }* %t683, { i8**, i64 }** %l0
  %t684 = sitofp i64 0 to double
  store double %t684, double* %l23
  %t685 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t686 = load i8*, i8** %l1
  %t687 = load i8*, i8** %l2
  %t688 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t689 = load i8*, i8** %l4
  %t690 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t691 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t692 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t693 = load %NativeFunction*, %NativeFunction** %l8
  %t694 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t695 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t696 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t697 = load double, double* %l12
  %t698 = load double, double* %l13
  %t699 = load i1, i1* %l14
  %t700 = load i1, i1* %l15
  %t701 = load double, double* %l16
  %t702 = load i8*, i8** %l18
  %t703 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t704 = load double, double* %l23
  br label %loop.header49
loop.header49:
  %t752 = phi %NativeFunction* [ %t693, %merge46 ], [ %t750, %loop.latch51 ]
  %t753 = phi double [ %t704, %merge46 ], [ %t751, %loop.latch51 ]
  store %NativeFunction* %t752, %NativeFunction** %l8
  store double %t753, double* %l23
  br label %loop.body50
loop.body50:
  %t705 = load double, double* %l23
  %t706 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t707 = extractvalue %InstructionParseResult %t706, 0
  %t708 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t707
  %t709 = extractvalue { %NativeInstruction**, i64 } %t708, 1
  %t710 = sitofp i64 %t709 to double
  %t711 = fcmp oge double %t705, %t710
  %t712 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t713 = load i8*, i8** %l1
  %t714 = load i8*, i8** %l2
  %t715 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t716 = load i8*, i8** %l4
  %t717 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t718 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t719 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t720 = load %NativeFunction*, %NativeFunction** %l8
  %t721 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t722 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t723 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t724 = load double, double* %l12
  %t725 = load double, double* %l13
  %t726 = load i1, i1* %l14
  %t727 = load i1, i1* %l15
  %t728 = load double, double* %l16
  %t729 = load i8*, i8** %l18
  %t730 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t731 = load double, double* %l23
  br i1 %t711, label %then53, label %merge54
then53:
  br label %afterloop52
merge54:
  %t732 = load %NativeFunction*, %NativeFunction** %l8
  %t733 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t734 = extractvalue %InstructionParseResult %t733, 0
  %t735 = load double, double* %l23
  %t736 = fptosi double %t735 to i64
  %t737 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t734
  %t738 = extractvalue { %NativeInstruction**, i64 } %t737, 0
  %t739 = extractvalue { %NativeInstruction**, i64 } %t737, 1
  %t740 = icmp uge i64 %t736, %t739
  ; bounds check: %t740 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t736, i64 %t739)
  %t741 = getelementptr %NativeInstruction*, %NativeInstruction** %t738, i64 %t736
  %t742 = load %NativeInstruction*, %NativeInstruction** %t741
  %t743 = load %NativeFunction, %NativeFunction* %t732
  %t744 = load %NativeInstruction, %NativeInstruction* %t742
  %t745 = call %NativeFunction @append_instruction(%NativeFunction %t743, %NativeInstruction %t744)
  %t746 = alloca %NativeFunction
  store %NativeFunction %t745, %NativeFunction* %t746
  store %NativeFunction* %t746, %NativeFunction** %l8
  %t747 = load double, double* %l23
  %t748 = sitofp i64 1 to double
  %t749 = fadd double %t747, %t748
  store double %t749, double* %l23
  br label %loop.latch51
loop.latch51:
  %t750 = load %NativeFunction*, %NativeFunction** %l8
  %t751 = load double, double* %l23
  br label %loop.header49
afterloop52:
  %t754 = load %NativeFunction*, %NativeFunction** %l8
  %t755 = load double, double* %l23
  %t756 = load double, double* %l16
  %t757 = sitofp i64 1 to double
  %t758 = fadd double %t756, %t757
  store double %t758, double* %l16
  br label %loop.latch4
merge17:
  %t759 = load i8*, i8** %l18
  %s760 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t761 = call i1 @starts_with(i8* %t759, i8* %s760)
  %t762 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t763 = load i8*, i8** %l1
  %t764 = load i8*, i8** %l2
  %t765 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t766 = load i8*, i8** %l4
  %t767 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t768 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t769 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t770 = load %NativeFunction*, %NativeFunction** %l8
  %t771 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t772 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t773 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t774 = load double, double* %l12
  %t775 = load double, double* %l13
  %t776 = load i1, i1* %l14
  %t777 = load i1, i1* %l15
  %t778 = load double, double* %l16
  %t779 = load i8*, i8** %l18
  br i1 %t761, label %then55, label %merge56
then55:
  %t780 = load i8*, i8** %l18
  %s781 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t782 = call i8* @strip_prefix(i8* %t780, i8* %s781)
  store i8* %t782, i8** %l24
  %t783 = load i8*, i8** %l24
  %s784 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t785 = call i1 @starts_with(i8* %t783, i8* %s784)
  %t786 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t787 = load i8*, i8** %l1
  %t788 = load i8*, i8** %l2
  %t789 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t790 = load i8*, i8** %l4
  %t791 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t792 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t793 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t794 = load %NativeFunction*, %NativeFunction** %l8
  %t795 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t796 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t797 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t798 = load double, double* %l12
  %t799 = load double, double* %l13
  %t800 = load i1, i1* %l14
  %t801 = load i1, i1* %l15
  %t802 = load double, double* %l16
  %t803 = load i8*, i8** %l18
  %t804 = load i8*, i8** %l24
  br i1 %t785, label %then57, label %merge58
then57:
  %t805 = load i8*, i8** %l24
  %s806 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t807 = call i8* @strip_prefix(i8* %t805, i8* %s806)
  %t808 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t807)
  store %StructLayoutHeaderParse %t808, %StructLayoutHeaderParse* %l25
  %t809 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t810 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t811 = extractvalue %StructLayoutHeaderParse %t810, 4
  %t812 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t809, { i8**, i64 }* %t811)
  store { i8**, i64 }* %t812, { i8**, i64 }** %l0
  %t813 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t814 = extractvalue %StructLayoutHeaderParse %t813, 0
  %t815 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t816 = load i8*, i8** %l1
  %t817 = load i8*, i8** %l2
  %t818 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t819 = load i8*, i8** %l4
  %t820 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t821 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t822 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t823 = load %NativeFunction*, %NativeFunction** %l8
  %t824 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t825 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t826 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t827 = load double, double* %l12
  %t828 = load double, double* %l13
  %t829 = load i1, i1* %l14
  %t830 = load i1, i1* %l15
  %t831 = load double, double* %l16
  %t832 = load i8*, i8** %l18
  %t833 = load i8*, i8** %l24
  %t834 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  br i1 %t814, label %then59, label %merge60
then59:
  %t835 = load i1, i1* %l14
  %t836 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t837 = load i8*, i8** %l1
  %t838 = load i8*, i8** %l2
  %t839 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t840 = load i8*, i8** %l4
  %t841 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t842 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t843 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t844 = load %NativeFunction*, %NativeFunction** %l8
  %t845 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t846 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t847 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t848 = load double, double* %l12
  %t849 = load double, double* %l13
  %t850 = load i1, i1* %l14
  %t851 = load i1, i1* %l15
  %t852 = load double, double* %l16
  %t853 = load i8*, i8** %l18
  %t854 = load i8*, i8** %l24
  %t855 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  br i1 %t835, label %then61, label %else62
then61:
  %t856 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s857 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.len34.h654371835, i32 0, i32 0
  %t858 = load i8*, i8** %l4
  %t859 = call i8* @sailfin_runtime_string_concat(i8* %s857, i8* %t858)
  %t860 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t856, i8* %t859)
  store { i8**, i64 }* %t860, { i8**, i64 }** %l0
  %t861 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge63
else62:
  %t862 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t863 = extractvalue %StructLayoutHeaderParse %t862, 2
  store double %t863, double* %l12
  %t864 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t865 = extractvalue %StructLayoutHeaderParse %t864, 3
  store double %t865, double* %l13
  store i1 1, i1* %l14
  %t866 = load double, double* %l12
  %t867 = load double, double* %l13
  %t868 = load i1, i1* %l14
  br label %merge63
merge63:
  %t869 = phi { i8**, i64 }* [ %t861, %then61 ], [ %t836, %else62 ]
  %t870 = phi double [ %t848, %then61 ], [ %t866, %else62 ]
  %t871 = phi double [ %t849, %then61 ], [ %t867, %else62 ]
  %t872 = phi i1 [ %t850, %then61 ], [ %t868, %else62 ]
  store { i8**, i64 }* %t869, { i8**, i64 }** %l0
  store double %t870, double* %l12
  store double %t871, double* %l13
  store i1 %t872, i1* %l14
  %t873 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t874 = load double, double* %l12
  %t875 = load double, double* %l13
  %t876 = load i1, i1* %l14
  br label %merge60
merge60:
  %t877 = phi { i8**, i64 }* [ %t873, %merge63 ], [ %t815, %then57 ]
  %t878 = phi double [ %t874, %merge63 ], [ %t827, %then57 ]
  %t879 = phi double [ %t875, %merge63 ], [ %t828, %then57 ]
  %t880 = phi i1 [ %t876, %merge63 ], [ %t829, %then57 ]
  store { i8**, i64 }* %t877, { i8**, i64 }** %l0
  store double %t878, double* %l12
  store double %t879, double* %l13
  store i1 %t880, i1* %l14
  %t881 = load double, double* %l16
  %t882 = sitofp i64 1 to double
  %t883 = fadd double %t881, %t882
  store double %t883, double* %l16
  br label %loop.latch4
merge58:
  %t884 = load i8*, i8** %l24
  %s885 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h734244628, i32 0, i32 0
  %t886 = call i1 @starts_with(i8* %t884, i8* %s885)
  %t887 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t888 = load i8*, i8** %l1
  %t889 = load i8*, i8** %l2
  %t890 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t891 = load i8*, i8** %l4
  %t892 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t893 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t894 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t895 = load %NativeFunction*, %NativeFunction** %l8
  %t896 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t897 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t898 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t899 = load double, double* %l12
  %t900 = load double, double* %l13
  %t901 = load i1, i1* %l14
  %t902 = load i1, i1* %l15
  %t903 = load double, double* %l16
  %t904 = load i8*, i8** %l18
  %t905 = load i8*, i8** %l24
  br i1 %t886, label %then64, label %merge65
then64:
  %t906 = load i8*, i8** %l24
  %s907 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h734244628, i32 0, i32 0
  %t908 = call i8* @strip_prefix(i8* %t906, i8* %s907)
  %t909 = load i8*, i8** %l4
  %t910 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t908, i8* %t909)
  store %StructLayoutFieldParse %t910, %StructLayoutFieldParse* %l26
  %t911 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t912 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  %t913 = extractvalue %StructLayoutFieldParse %t912, 2
  %t914 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t911, { i8**, i64 }* %t913)
  store { i8**, i64 }* %t914, { i8**, i64 }** %l0
  %t915 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  %t916 = extractvalue %StructLayoutFieldParse %t915, 0
  %t917 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t918 = load i8*, i8** %l1
  %t919 = load i8*, i8** %l2
  %t920 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t921 = load i8*, i8** %l4
  %t922 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t923 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t924 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t925 = load %NativeFunction*, %NativeFunction** %l8
  %t926 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t927 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t928 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t929 = load double, double* %l12
  %t930 = load double, double* %l13
  %t931 = load i1, i1* %l14
  %t932 = load i1, i1* %l15
  %t933 = load double, double* %l16
  %t934 = load i8*, i8** %l18
  %t935 = load i8*, i8** %l24
  %t936 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  br i1 %t916, label %then66, label %merge67
then66:
  %t937 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t938 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  %t939 = extractvalue %StructLayoutFieldParse %t938, 1
  %t940 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t937, %NativeStructLayoutField %t939)
  store { %NativeStructLayoutField*, i64 }* %t940, { %NativeStructLayoutField*, i64 }** %l11
  %t941 = load i1, i1* %l14
  %t942 = xor i1 %t941, 1
  %t943 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t944 = load i8*, i8** %l1
  %t945 = load i8*, i8** %l2
  %t946 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t947 = load i8*, i8** %l4
  %t948 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t949 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t950 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t951 = load %NativeFunction*, %NativeFunction** %l8
  %t952 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t953 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t954 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t955 = load double, double* %l12
  %t956 = load double, double* %l13
  %t957 = load i1, i1* %l14
  %t958 = load i1, i1* %l15
  %t959 = load double, double* %l16
  %t960 = load i8*, i8** %l18
  %t961 = load i8*, i8** %l24
  %t962 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  br i1 %t942, label %then68, label %merge69
then68:
  %t963 = load i1, i1* %l15
  %t964 = xor i1 %t963, 1
  %t965 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t966 = load i8*, i8** %l1
  %t967 = load i8*, i8** %l2
  %t968 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t969 = load i8*, i8** %l4
  %t970 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t971 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t972 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t973 = load %NativeFunction*, %NativeFunction** %l8
  %t974 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t975 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t976 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t977 = load double, double* %l12
  %t978 = load double, double* %l13
  %t979 = load i1, i1* %l14
  %t980 = load i1, i1* %l15
  %t981 = load double, double* %l16
  %t982 = load i8*, i8** %l18
  %t983 = load i8*, i8** %l24
  %t984 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  br i1 %t964, label %then70, label %merge71
then70:
  %t985 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s986 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t987 = load i8*, i8** %l4
  %t988 = call i8* @sailfin_runtime_string_concat(i8* %s986, i8* %t987)
  %s989 = getelementptr inbounds [47 x i8], [47 x i8]* @.str.len46.h1830585629, i32 0, i32 0
  %t990 = call i8* @sailfin_runtime_string_concat(i8* %t988, i8* %s989)
  %t991 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t985, i8* %t990)
  store { i8**, i64 }* %t991, { i8**, i64 }** %l0
  store i1 1, i1* %l15
  %t992 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t993 = load i1, i1* %l15
  br label %merge71
merge71:
  %t994 = phi { i8**, i64 }* [ %t992, %then70 ], [ %t965, %then68 ]
  %t995 = phi i1 [ %t993, %then70 ], [ %t980, %then68 ]
  store { i8**, i64 }* %t994, { i8**, i64 }** %l0
  store i1 %t995, i1* %l15
  %t996 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t997 = load i1, i1* %l15
  br label %merge69
merge69:
  %t998 = phi { i8**, i64 }* [ %t996, %merge71 ], [ %t943, %then66 ]
  %t999 = phi i1 [ %t997, %merge71 ], [ %t958, %then66 ]
  store { i8**, i64 }* %t998, { i8**, i64 }** %l0
  store i1 %t999, i1* %l15
  %t1000 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1001 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1002 = load i1, i1* %l15
  br label %merge67
merge67:
  %t1003 = phi { %NativeStructLayoutField*, i64 }* [ %t1000, %merge69 ], [ %t928, %then64 ]
  %t1004 = phi { i8**, i64 }* [ %t1001, %merge69 ], [ %t917, %then64 ]
  %t1005 = phi i1 [ %t1002, %merge69 ], [ %t932, %then64 ]
  store { %NativeStructLayoutField*, i64 }* %t1003, { %NativeStructLayoutField*, i64 }** %l11
  store { i8**, i64 }* %t1004, { i8**, i64 }** %l0
  store i1 %t1005, i1* %l15
  %t1006 = load double, double* %l16
  %t1007 = sitofp i64 1 to double
  %t1008 = fadd double %t1006, %t1007
  store double %t1008, double* %l16
  br label %loop.latch4
merge65:
  %t1009 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1010 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.len37.h1152036459, i32 0, i32 0
  %t1011 = load i8*, i8** %l18
  %t1012 = call i8* @sailfin_runtime_string_concat(i8* %s1010, i8* %t1011)
  %t1013 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1009, i8* %t1012)
  store { i8**, i64 }* %t1013, { i8**, i64 }** %l0
  %t1014 = load double, double* %l16
  %t1015 = sitofp i64 1 to double
  %t1016 = fadd double %t1014, %t1015
  store double %t1016, double* %l16
  br label %loop.latch4
merge56:
  %t1017 = load i8*, i8** %l18
  %s1018 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t1019 = icmp eq i8* %t1017, %s1018
  %t1020 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1021 = load i8*, i8** %l1
  %t1022 = load i8*, i8** %l2
  %t1023 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1024 = load i8*, i8** %l4
  %t1025 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1026 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1027 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1028 = load %NativeFunction*, %NativeFunction** %l8
  %t1029 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1030 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1031 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1032 = load double, double* %l12
  %t1033 = load double, double* %l13
  %t1034 = load i1, i1* %l14
  %t1035 = load i1, i1* %l15
  %t1036 = load double, double* %l16
  %t1037 = load i8*, i8** %l18
  br i1 %t1019, label %then72, label %merge73
then72:
  %t1038 = load double, double* %l16
  %t1039 = sitofp i64 1 to double
  %t1040 = fadd double %t1038, %t1039
  store double %t1040, double* %l16
  br label %loop.latch4
merge73:
  %t1041 = load i8*, i8** %l18
  %s1042 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h398443637, i32 0, i32 0
  %t1043 = call i1 @starts_with(i8* %t1041, i8* %s1042)
  %t1044 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1045 = load i8*, i8** %l1
  %t1046 = load i8*, i8** %l2
  %t1047 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1048 = load i8*, i8** %l4
  %t1049 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1050 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1051 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1052 = load %NativeFunction*, %NativeFunction** %l8
  %t1053 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1054 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1055 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1056 = load double, double* %l12
  %t1057 = load double, double* %l13
  %t1058 = load i1, i1* %l14
  %t1059 = load i1, i1* %l15
  %t1060 = load double, double* %l16
  %t1061 = load i8*, i8** %l18
  br i1 %t1043, label %then74, label %merge75
then74:
  %t1062 = load i8*, i8** %l18
  %s1063 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h398443637, i32 0, i32 0
  %t1064 = call i8* @strip_prefix(i8* %t1062, i8* %s1063)
  %t1065 = call %NativeStructField* @parse_struct_field_line(i8* %t1064)
  store %NativeStructField* %t1065, %NativeStructField** %l27
  %t1066 = load %NativeStructField*, %NativeStructField** %l27
  %t1067 = icmp eq %NativeStructField* %t1066, null
  %t1068 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1069 = load i8*, i8** %l1
  %t1070 = load i8*, i8** %l2
  %t1071 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1072 = load i8*, i8** %l4
  %t1073 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1074 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1075 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1076 = load %NativeFunction*, %NativeFunction** %l8
  %t1077 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1078 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1079 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1080 = load double, double* %l12
  %t1081 = load double, double* %l13
  %t1082 = load i1, i1* %l14
  %t1083 = load i1, i1* %l15
  %t1084 = load double, double* %l16
  %t1085 = load i8*, i8** %l18
  %t1086 = load %NativeStructField*, %NativeStructField** %l27
  br i1 %t1067, label %then76, label %else77
then76:
  %t1087 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1088 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.len30.h702899578, i32 0, i32 0
  %t1089 = load i8*, i8** %l18
  %t1090 = call i8* @sailfin_runtime_string_concat(i8* %s1088, i8* %t1089)
  %t1091 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1087, i8* %t1090)
  store { i8**, i64 }* %t1091, { i8**, i64 }** %l0
  %t1092 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge78
else77:
  %t1093 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1094 = load %NativeStructField*, %NativeStructField** %l27
  %t1095 = load %NativeStructField, %NativeStructField* %t1094
  %t1096 = call { %NativeStructField*, i64 }* @append_struct_field({ %NativeStructField*, i64 }* %t1093, %NativeStructField %t1095)
  store { %NativeStructField*, i64 }* %t1096, { %NativeStructField*, i64 }** %l6
  %t1097 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  br label %merge78
merge78:
  %t1098 = phi { i8**, i64 }* [ %t1092, %then76 ], [ %t1068, %else77 ]
  %t1099 = phi { %NativeStructField*, i64 }* [ %t1074, %then76 ], [ %t1097, %else77 ]
  store { i8**, i64 }* %t1098, { i8**, i64 }** %l0
  store { %NativeStructField*, i64 }* %t1099, { %NativeStructField*, i64 }** %l6
  %t1100 = load double, double* %l16
  %t1101 = sitofp i64 1 to double
  %t1102 = fadd double %t1100, %t1101
  store double %t1102, double* %l16
  br label %loop.latch4
merge75:
  %t1103 = load i8*, i8** %l18
  %s1104 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1951948513, i32 0, i32 0
  %t1105 = call i1 @starts_with(i8* %t1103, i8* %s1104)
  %t1106 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1107 = load i8*, i8** %l1
  %t1108 = load i8*, i8** %l2
  %t1109 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1110 = load i8*, i8** %l4
  %t1111 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1112 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1113 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1114 = load %NativeFunction*, %NativeFunction** %l8
  %t1115 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1116 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1117 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1118 = load double, double* %l12
  %t1119 = load double, double* %l13
  %t1120 = load i1, i1* %l14
  %t1121 = load i1, i1* %l15
  %t1122 = load double, double* %l16
  %t1123 = load i8*, i8** %l18
  br i1 %t1105, label %then79, label %merge80
then79:
  %t1124 = load %NativeFunction*, %NativeFunction** %l8
  %t1125 = icmp ne %NativeFunction* %t1124, null
  %t1126 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1127 = load i8*, i8** %l1
  %t1128 = load i8*, i8** %l2
  %t1129 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1130 = load i8*, i8** %l4
  %t1131 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1132 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1133 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1134 = load %NativeFunction*, %NativeFunction** %l8
  %t1135 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1136 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1137 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1138 = load double, double* %l12
  %t1139 = load double, double* %l13
  %t1140 = load i1, i1* %l14
  %t1141 = load i1, i1* %l15
  %t1142 = load double, double* %l16
  %t1143 = load i8*, i8** %l18
  br i1 %t1125, label %then81, label %merge82
then81:
  %t1144 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1145 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.len36.h736848621, i32 0, i32 0
  %t1146 = load i8*, i8** %l4
  %t1147 = call i8* @sailfin_runtime_string_concat(i8* %s1145, i8* %t1146)
  %t1148 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1144, i8* %t1147)
  store { i8**, i64 }* %t1148, { i8**, i64 }** %l0
  %t1149 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge82
merge82:
  %t1150 = phi { i8**, i64 }* [ %t1149, %then81 ], [ %t1126, %then79 ]
  store { i8**, i64 }* %t1150, { i8**, i64 }** %l0
  %t1151 = load i8*, i8** %l18
  %s1152 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1951948513, i32 0, i32 0
  %t1153 = call i8* @strip_prefix(i8* %t1151, i8* %s1152)
  %t1154 = call i8* @parse_function_name(i8* %t1153)
  store i8* %t1154, i8** %l28
  %t1155 = load i8*, i8** %l28
  %t1156 = insertvalue %NativeFunction undef, i8* %t1155, 0
  %t1157 = alloca [0 x %NativeParameter*]
  %t1158 = getelementptr [0 x %NativeParameter*], [0 x %NativeParameter*]* %t1157, i32 0, i32 0
  %t1159 = alloca { %NativeParameter**, i64 }
  %t1160 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t1159, i32 0, i32 0
  store %NativeParameter** %t1158, %NativeParameter*** %t1160
  %t1161 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t1159, i32 0, i32 1
  store i64 0, i64* %t1161
  %t1162 = insertvalue %NativeFunction %t1156, { %NativeParameter**, i64 }* %t1159, 1
  %s1163 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h278197661, i32 0, i32 0
  %t1164 = insertvalue %NativeFunction %t1162, i8* %s1163, 2
  %t1165 = alloca [0 x i8*]
  %t1166 = getelementptr [0 x i8*], [0 x i8*]* %t1165, i32 0, i32 0
  %t1167 = alloca { i8**, i64 }
  %t1168 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1167, i32 0, i32 0
  store i8** %t1166, i8*** %t1168
  %t1169 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1167, i32 0, i32 1
  store i64 0, i64* %t1169
  %t1170 = insertvalue %NativeFunction %t1164, { i8**, i64 }* %t1167, 3
  %t1171 = alloca [0 x %NativeInstruction*]
  %t1172 = getelementptr [0 x %NativeInstruction*], [0 x %NativeInstruction*]* %t1171, i32 0, i32 0
  %t1173 = alloca { %NativeInstruction**, i64 }
  %t1174 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1173, i32 0, i32 0
  store %NativeInstruction** %t1172, %NativeInstruction*** %t1174
  %t1175 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1173, i32 0, i32 1
  store i64 0, i64* %t1175
  %t1176 = insertvalue %NativeFunction %t1170, { %NativeInstruction**, i64 }* %t1173, 4
  %t1177 = alloca %NativeFunction
  store %NativeFunction %t1176, %NativeFunction* %t1177
  store %NativeFunction* %t1177, %NativeFunction** %l8
  %t1178 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1178, %NativeSourceSpan** %l9
  %t1179 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1179, %NativeSourceSpan** %l10
  %t1180 = load double, double* %l16
  %t1181 = sitofp i64 1 to double
  %t1182 = fadd double %t1180, %t1181
  store double %t1182, double* %l16
  br label %loop.latch4
merge80:
  %t1183 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1184 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.len30.h211710404, i32 0, i32 0
  %t1185 = load i8*, i8** %l18
  %t1186 = call i8* @sailfin_runtime_string_concat(i8* %s1184, i8* %t1185)
  %t1187 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1183, i8* %t1186)
  store { i8**, i64 }* %t1187, { i8**, i64 }** %l0
  %t1188 = load double, double* %l16
  %t1189 = sitofp i64 1 to double
  %t1190 = fadd double %t1188, %t1189
  store double %t1190, double* %l16
  br label %loop.latch4
loop.latch4:
  %t1191 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1192 = load double, double* %l16
  %t1193 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1194 = load %NativeFunction*, %NativeFunction** %l8
  %t1195 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1196 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1197 = load double, double* %l12
  %t1198 = load double, double* %l13
  %t1199 = load i1, i1* %l14
  %t1200 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1201 = load i1, i1* %l15
  %t1202 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  br label %loop.header2
afterloop5:
  %t1215 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1216 = load double, double* %l16
  %t1217 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1218 = load %NativeFunction*, %NativeFunction** %l8
  %t1219 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1220 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1221 = load double, double* %l12
  %t1222 = load double, double* %l13
  %t1223 = load i1, i1* %l14
  %t1224 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1225 = load i1, i1* %l15
  %t1226 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1227 = bitcast i8* null to %NativeStructLayout*
  store %NativeStructLayout* %t1227, %NativeStructLayout** %l29
  %t1228 = load i1, i1* %l14
  %t1229 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1230 = load i8*, i8** %l1
  %t1231 = load i8*, i8** %l2
  %t1232 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1233 = load i8*, i8** %l4
  %t1234 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1235 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1236 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1237 = load %NativeFunction*, %NativeFunction** %l8
  %t1238 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1239 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1240 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1241 = load double, double* %l12
  %t1242 = load double, double* %l13
  %t1243 = load i1, i1* %l14
  %t1244 = load i1, i1* %l15
  %t1245 = load double, double* %l16
  %t1246 = load %NativeStructLayout*, %NativeStructLayout** %l29
  br i1 %t1228, label %then83, label %merge84
then83:
  %t1247 = load double, double* %l12
  %t1248 = insertvalue %NativeStructLayout undef, double %t1247, 0
  %t1249 = load double, double* %l13
  %t1250 = insertvalue %NativeStructLayout %t1248, double %t1249, 1
  %t1251 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1252 = bitcast { %NativeStructLayoutField*, i64 }* %t1251 to { %NativeStructLayoutField**, i64 }*
  %t1253 = insertvalue %NativeStructLayout %t1250, { %NativeStructLayoutField**, i64 }* %t1252, 2
  %t1254 = alloca %NativeStructLayout
  store %NativeStructLayout %t1253, %NativeStructLayout* %t1254
  store %NativeStructLayout* %t1254, %NativeStructLayout** %l29
  %t1255 = load %NativeStructLayout*, %NativeStructLayout** %l29
  br label %merge84
merge84:
  %t1256 = phi %NativeStructLayout* [ %t1255, %then83 ], [ %t1246, %afterloop5 ]
  store %NativeStructLayout* %t1256, %NativeStructLayout** %l29
  %t1257 = load i8*, i8** %l4
  %t1258 = insertvalue %NativeStruct undef, i8* %t1257, 0
  %t1259 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1260 = bitcast { %NativeStructField*, i64 }* %t1259 to { %NativeStructField**, i64 }*
  %t1261 = insertvalue %NativeStruct %t1258, { %NativeStructField**, i64 }* %t1260, 1
  %t1262 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1263 = bitcast { %NativeFunction*, i64 }* %t1262 to { %NativeFunction**, i64 }*
  %t1264 = insertvalue %NativeStruct %t1261, { %NativeFunction**, i64 }* %t1263, 2
  %t1265 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1266 = insertvalue %NativeStruct %t1264, { i8**, i64 }* %t1265, 3
  %t1267 = load %NativeStructLayout*, %NativeStructLayout** %l29
  %t1268 = insertvalue %NativeStruct %t1266, %NativeStructLayout* %t1267, 4
  %t1269 = alloca %NativeStruct
  store %NativeStruct %t1268, %NativeStruct* %t1269
  %t1270 = insertvalue %StructParseResult undef, %NativeStruct* %t1269, 0
  %t1271 = load double, double* %l16
  %t1272 = insertvalue %StructParseResult %t1270, double %t1271, 1
  %t1273 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1274 = insertvalue %StructParseResult %t1272, { i8**, i64 }* %t1273, 2
  ret %StructParseResult %t1274
}

define %InterfaceParseResult @parse_interface_definition({ i8**, i64 }* %lines, double %start_index) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca %InterfaceHeaderParse
  %l4 = alloca i8*
  %l5 = alloca { %NativeInterfaceSignature*, i64 }*
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca %InterfaceSignatureParse
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = fptosi double %start_index to i64
  %t6 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t7 = extractvalue { i8**, i64 } %t6, 0
  %t8 = extractvalue { i8**, i64 } %t6, 1
  %t9 = icmp uge i64 %t5, %t8
  ; bounds check: %t9 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t5, i64 %t8)
  %t10 = getelementptr i8*, i8** %t7, i64 %t5
  %t11 = load i8*, i8** %t10
  %t12 = call i8* @trim_text(i8* %t11)
  store i8* %t12, i8** %l1
  %t13 = load i8*, i8** %l1
  %s14 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h599952843, i32 0, i32 0
  %t15 = call i8* @strip_prefix(i8* %t13, i8* %s14)
  %t16 = call i8* @trim_text(i8* %t15)
  store i8* %t16, i8** %l2
  %t17 = load i8*, i8** %l2
  %t18 = call %InterfaceHeaderParse @parse_interface_header(i8* %t17)
  store %InterfaceHeaderParse %t18, %InterfaceHeaderParse* %l3
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t21 = extractvalue %InterfaceHeaderParse %t20, 2
  %t22 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t19, { i8**, i64 }* %t21)
  store { i8**, i64 }* %t22, { i8**, i64 }** %l0
  %t23 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t24 = extractvalue %InterfaceHeaderParse %t23, 0
  store i8* %t24, i8** %l4
  %t25 = load i8*, i8** %l4
  %t26 = call i64 @sailfin_runtime_string_length(i8* %t25)
  %t27 = icmp eq i64 %t26, 0
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load i8*, i8** %l1
  %t30 = load i8*, i8** %l2
  %t31 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t32 = load i8*, i8** %l4
  br i1 %t27, label %then0, label %merge1
then0:
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s34 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.len34.h805939531, i32 0, i32 0
  %t35 = load i8*, i8** %l1
  %t36 = call i8* @sailfin_runtime_string_concat(i8* %s34, i8* %t35)
  %t37 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t33, i8* %t36)
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  %t38 = bitcast i8* null to %NativeInterface*
  %t39 = insertvalue %InterfaceParseResult undef, %NativeInterface* %t38, 0
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %start_index, %t40
  %t42 = insertvalue %InterfaceParseResult %t39, double %t41, 1
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = insertvalue %InterfaceParseResult %t42, { i8**, i64 }* %t43, 2
  ret %InterfaceParseResult %t44
merge1:
  %t45 = alloca [0 x %NativeInterfaceSignature]
  %t46 = getelementptr [0 x %NativeInterfaceSignature], [0 x %NativeInterfaceSignature]* %t45, i32 0, i32 0
  %t47 = alloca { %NativeInterfaceSignature*, i64 }
  %t48 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t47, i32 0, i32 0
  store %NativeInterfaceSignature* %t46, %NativeInterfaceSignature** %t48
  %t49 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t47, i32 0, i32 1
  store i64 0, i64* %t49
  store { %NativeInterfaceSignature*, i64 }* %t47, { %NativeInterfaceSignature*, i64 }** %l5
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %start_index, %t50
  store double %t51, double* %l6
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load i8*, i8** %l1
  %t54 = load i8*, i8** %l2
  %t55 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t56 = load i8*, i8** %l4
  %t57 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t58 = load double, double* %l6
  br label %loop.header2
loop.header2:
  %t210 = phi { i8**, i64 }* [ %t52, %merge1 ], [ %t207, %loop.latch4 ]
  %t211 = phi double [ %t58, %merge1 ], [ %t208, %loop.latch4 ]
  %t212 = phi { %NativeInterfaceSignature*, i64 }* [ %t57, %merge1 ], [ %t209, %loop.latch4 ]
  store { i8**, i64 }* %t210, { i8**, i64 }** %l0
  store double %t211, double* %l6
  store { %NativeInterfaceSignature*, i64 }* %t212, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.body3
loop.body3:
  %t59 = load double, double* %l6
  %t60 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t61 = extractvalue { i8**, i64 } %t60, 1
  %t62 = sitofp i64 %t61 to double
  %t63 = fcmp oge double %t59, %t62
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load i8*, i8** %l1
  %t66 = load i8*, i8** %l2
  %t67 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t68 = load i8*, i8** %l4
  %t69 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t70 = load double, double* %l6
  br i1 %t63, label %then6, label %merge7
then6:
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s72 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.len23.h1564009733, i32 0, i32 0
  %t73 = load i8*, i8** %l4
  %t74 = call i8* @sailfin_runtime_string_concat(i8* %s72, i8* %t73)
  %t75 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t71, i8* %t74)
  store { i8**, i64 }* %t75, { i8**, i64 }** %l0
  %t76 = load i8*, i8** %l4
  %t77 = insertvalue %NativeInterface undef, i8* %t76, 0
  %t78 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t79 = extractvalue %InterfaceHeaderParse %t78, 1
  %t80 = insertvalue %NativeInterface %t77, { i8**, i64 }* %t79, 1
  %t81 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t82 = bitcast { %NativeInterfaceSignature*, i64 }* %t81 to { %NativeInterfaceSignature**, i64 }*
  %t83 = insertvalue %NativeInterface %t80, { %NativeInterfaceSignature**, i64 }* %t82, 2
  %t84 = alloca %NativeInterface
  store %NativeInterface %t83, %NativeInterface* %t84
  %t85 = insertvalue %InterfaceParseResult undef, %NativeInterface* %t84, 0
  %t86 = load double, double* %l6
  %t87 = insertvalue %InterfaceParseResult %t85, double %t86, 1
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t89 = insertvalue %InterfaceParseResult %t87, { i8**, i64 }* %t88, 2
  ret %InterfaceParseResult %t89
merge7:
  %t90 = load double, double* %l6
  %t91 = fptosi double %t90 to i64
  %t92 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t93 = extractvalue { i8**, i64 } %t92, 0
  %t94 = extractvalue { i8**, i64 } %t92, 1
  %t95 = icmp uge i64 %t91, %t94
  ; bounds check: %t95 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t91, i64 %t94)
  %t96 = getelementptr i8*, i8** %t93, i64 %t91
  %t97 = load i8*, i8** %t96
  %t98 = call i8* @trim_text(i8* %t97)
  store i8* %t98, i8** %l7
  %t100 = load i8*, i8** %l7
  %t101 = call i64 @sailfin_runtime_string_length(i8* %t100)
  %t102 = icmp eq i64 %t101, 0
  br label %logical_or_entry_99

logical_or_entry_99:
  br i1 %t102, label %logical_or_merge_99, label %logical_or_right_99

logical_or_right_99:
  %t103 = load i8*, i8** %l7
  %t104 = alloca [2 x i8], align 1
  %t105 = getelementptr [2 x i8], [2 x i8]* %t104, i32 0, i32 0
  store i8 59, i8* %t105
  %t106 = getelementptr [2 x i8], [2 x i8]* %t104, i32 0, i32 1
  store i8 0, i8* %t106
  %t107 = getelementptr [2 x i8], [2 x i8]* %t104, i32 0, i32 0
  %t108 = call i1 @starts_with(i8* %t103, i8* %t107)
  br label %logical_or_right_end_99

logical_or_right_end_99:
  br label %logical_or_merge_99

logical_or_merge_99:
  %t109 = phi i1 [ true, %logical_or_entry_99 ], [ %t108, %logical_or_right_end_99 ]
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t111 = load i8*, i8** %l1
  %t112 = load i8*, i8** %l2
  %t113 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t114 = load i8*, i8** %l4
  %t115 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t116 = load double, double* %l6
  %t117 = load i8*, i8** %l7
  br i1 %t109, label %then8, label %merge9
then8:
  %t118 = load double, double* %l6
  %t119 = sitofp i64 1 to double
  %t120 = fadd double %t118, %t119
  store double %t120, double* %l6
  br label %loop.latch4
merge9:
  %t121 = load i8*, i8** %l7
  %s122 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1382830532, i32 0, i32 0
  %t123 = icmp eq i8* %t121, %s122
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t125 = load i8*, i8** %l1
  %t126 = load i8*, i8** %l2
  %t127 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t128 = load i8*, i8** %l4
  %t129 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t130 = load double, double* %l6
  %t131 = load i8*, i8** %l7
  br i1 %t123, label %then10, label %merge11
then10:
  %t132 = load double, double* %l6
  %t133 = sitofp i64 1 to double
  %t134 = fadd double %t132, %t133
  store double %t134, double* %l6
  br label %afterloop5
merge11:
  %t135 = load i8*, i8** %l7
  %s136 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t137 = icmp eq i8* %t135, %s136
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t139 = load i8*, i8** %l1
  %t140 = load i8*, i8** %l2
  %t141 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t142 = load i8*, i8** %l4
  %t143 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t144 = load double, double* %l6
  %t145 = load i8*, i8** %l7
  br i1 %t137, label %then12, label %merge13
then12:
  %t146 = load double, double* %l6
  %t147 = sitofp i64 1 to double
  %t148 = fadd double %t146, %t147
  store double %t148, double* %l6
  br label %loop.latch4
merge13:
  %t149 = load i8*, i8** %l7
  %s150 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072555103, i32 0, i32 0
  %t151 = call i1 @starts_with(i8* %t149, i8* %s150)
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t153 = load i8*, i8** %l1
  %t154 = load i8*, i8** %l2
  %t155 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t156 = load i8*, i8** %l4
  %t157 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t158 = load double, double* %l6
  %t159 = load i8*, i8** %l7
  br i1 %t151, label %then14, label %merge15
then14:
  %t160 = load i8*, i8** %l7
  %s161 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072555103, i32 0, i32 0
  %t162 = call i8* @strip_prefix(i8* %t160, i8* %s161)
  %t163 = load i8*, i8** %l4
  %t164 = call %InterfaceSignatureParse @parse_interface_signature(i8* %t162, i8* %t163)
  store %InterfaceSignatureParse %t164, %InterfaceSignatureParse* %l8
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t166 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t167 = extractvalue %InterfaceSignatureParse %t166, 2
  %t168 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t165, { i8**, i64 }* %t167)
  store { i8**, i64 }* %t168, { i8**, i64 }** %l0
  %t169 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t170 = extractvalue %InterfaceSignatureParse %t169, 0
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t172 = load i8*, i8** %l1
  %t173 = load i8*, i8** %l2
  %t174 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t175 = load i8*, i8** %l4
  %t176 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t177 = load double, double* %l6
  %t178 = load i8*, i8** %l7
  %t179 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  br i1 %t170, label %then16, label %merge17
then16:
  %t180 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t181 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t182 = extractvalue %InterfaceSignatureParse %t181, 1
  %t183 = call noalias i8* @malloc(i64 48)
  %t184 = bitcast i8* %t183 to %NativeInterfaceSignature*
  store %NativeInterfaceSignature %t182, %NativeInterfaceSignature* %t184
  %t185 = alloca [1 x i8*]
  %t186 = getelementptr [1 x i8*], [1 x i8*]* %t185, i32 0, i32 0
  %t187 = getelementptr i8*, i8** %t186, i64 0
  store i8* %t183, i8** %t187
  %t188 = alloca { i8**, i64 }
  %t189 = getelementptr { i8**, i64 }, { i8**, i64 }* %t188, i32 0, i32 0
  store i8** %t186, i8*** %t189
  %t190 = getelementptr { i8**, i64 }, { i8**, i64 }* %t188, i32 0, i32 1
  store i64 1, i64* %t190
  %t191 = bitcast { %NativeInterfaceSignature*, i64 }* %t180 to { i8**, i64 }*
  %t192 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t191, { i8**, i64 }* %t188)
  %t193 = bitcast { i8**, i64 }* %t192 to { %NativeInterfaceSignature*, i64 }*
  store { %NativeInterfaceSignature*, i64 }* %t193, { %NativeInterfaceSignature*, i64 }** %l5
  %t194 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  br label %merge17
merge17:
  %t195 = phi { %NativeInterfaceSignature*, i64 }* [ %t194, %then16 ], [ %t176, %then14 ]
  store { %NativeInterfaceSignature*, i64 }* %t195, { %NativeInterfaceSignature*, i64 }** %l5
  %t196 = load double, double* %l6
  %t197 = sitofp i64 1 to double
  %t198 = fadd double %t196, %t197
  store double %t198, double* %l6
  br label %loop.latch4
merge15:
  %t199 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s200 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.len33.h1134984829, i32 0, i32 0
  %t201 = load i8*, i8** %l7
  %t202 = call i8* @sailfin_runtime_string_concat(i8* %s200, i8* %t201)
  %t203 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t199, i8* %t202)
  store { i8**, i64 }* %t203, { i8**, i64 }** %l0
  %t204 = load double, double* %l6
  %t205 = sitofp i64 1 to double
  %t206 = fadd double %t204, %t205
  store double %t206, double* %l6
  br label %loop.latch4
loop.latch4:
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t208 = load double, double* %l6
  %t209 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.header2
afterloop5:
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t214 = load double, double* %l6
  %t215 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t216 = load i8*, i8** %l4
  %t217 = insertvalue %NativeInterface undef, i8* %t216, 0
  %t218 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t219 = extractvalue %InterfaceHeaderParse %t218, 1
  %t220 = insertvalue %NativeInterface %t217, { i8**, i64 }* %t219, 1
  %t221 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t222 = bitcast { %NativeInterfaceSignature*, i64 }* %t221 to { %NativeInterfaceSignature**, i64 }*
  %t223 = insertvalue %NativeInterface %t220, { %NativeInterfaceSignature**, i64 }* %t222, 2
  %t224 = alloca %NativeInterface
  store %NativeInterface %t223, %NativeInterface* %t224
  %t225 = insertvalue %InterfaceParseResult undef, %NativeInterface* %t224, 0
  %t226 = load double, double* %l6
  %t227 = insertvalue %InterfaceParseResult %t225, double %t226, 1
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t229 = insertvalue %InterfaceParseResult %t227, { i8**, i64 }* %t228, 2
  ret %InterfaceParseResult %t229
}

define %StructHeaderParse @parse_struct_header(i8* %text) {
entry:
  %l0 = alloca %HeaderNameParse
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca i8*
  %t0 = call %HeaderNameParse @parse_header_name_and_remainder(i8* %text)
  store %HeaderNameParse %t0, %HeaderNameParse* %l0
  %t1 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t2 = extractvalue %HeaderNameParse %t1, 3
  store { i8**, i64 }* %t2, { i8**, i64 }** %l1
  %t3 = alloca [0 x i8*]
  %t4 = getelementptr [0 x i8*], [0 x i8*]* %t3, i32 0, i32 0
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t4, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 0, i64* %t7
  store { i8**, i64 }* %t5, { i8**, i64 }** %l2
  %t8 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t9 = extractvalue %HeaderNameParse %t8, 2
  %t10 = call i64 @sailfin_runtime_string_length(i8* %t9)
  %t11 = icmp sgt i64 %t10, 0
  %t12 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t11, label %then0, label %merge1
then0:
  %t15 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t16 = extractvalue %HeaderNameParse %t15, 2
  %s17 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h908744813, i32 0, i32 0
  %t18 = call i1 @starts_with(i8* %t16, i8* %s17)
  %t19 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t18, label %then2, label %else3
then2:
  %t22 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t23 = extractvalue %HeaderNameParse %t22, 2
  %s24 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h908744813, i32 0, i32 0
  %t25 = call i8* @strip_prefix(i8* %t23, i8* %s24)
  %t26 = call i8* @trim_text(i8* %t25)
  store i8* %t26, i8** %l3
  %t27 = load i8*, i8** %l3
  %t28 = call i64 @sailfin_runtime_string_length(i8* %t27)
  %t29 = icmp eq i64 %t28, 0
  %t30 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t33 = load i8*, i8** %l3
  br i1 %t29, label %then5, label %else6
then5:
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s35 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t36 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t37 = extractvalue %HeaderNameParse %t36, 0
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %s35, i8* %t37)
  %s39 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1868156648, i32 0, i32 0
  %t40 = call i8* @sailfin_runtime_string_concat(i8* %t38, i8* %s39)
  %t41 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t34, i8* %t40)
  store { i8**, i64 }* %t41, { i8**, i64 }** %l1
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge7
else6:
  %t43 = load i8*, i8** %l3
  %t44 = call { i8**, i64 }* @parse_implements_list(i8* %t43)
  store { i8**, i64 }* %t44, { i8**, i64 }** %l2
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge7
merge7:
  %t46 = phi { i8**, i64 }* [ %t42, %then5 ], [ %t31, %else6 ]
  %t47 = phi { i8**, i64 }* [ %t32, %then5 ], [ %t45, %else6 ]
  store { i8**, i64 }* %t46, { i8**, i64 }** %l1
  store { i8**, i64 }* %t47, { i8**, i64 }** %l2
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge4
else3:
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s51 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t52 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t53 = extractvalue %HeaderNameParse %t52, 0
  %t54 = call i8* @sailfin_runtime_string_concat(i8* %s51, i8* %t53)
  %s55 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.len33.h1132321576, i32 0, i32 0
  %t56 = call i8* @sailfin_runtime_string_concat(i8* %t54, i8* %s55)
  %t57 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t58 = extractvalue %HeaderNameParse %t57, 2
  %t59 = call i8* @sailfin_runtime_string_concat(i8* %t56, i8* %t58)
  %t60 = load i8, i8* %t59
  %t61 = add i8 %t60, 96
  %t62 = alloca [2 x i8], align 1
  %t63 = getelementptr [2 x i8], [2 x i8]* %t62, i32 0, i32 0
  store i8 %t61, i8* %t63
  %t64 = getelementptr [2 x i8], [2 x i8]* %t62, i32 0, i32 1
  store i8 0, i8* %t64
  %t65 = getelementptr [2 x i8], [2 x i8]* %t62, i32 0, i32 0
  %t66 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t50, i8* %t65)
  store { i8**, i64 }* %t66, { i8**, i64 }** %l1
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge4
merge4:
  %t68 = phi { i8**, i64 }* [ %t48, %merge7 ], [ %t67, %else3 ]
  %t69 = phi { i8**, i64 }* [ %t49, %merge7 ], [ %t21, %else3 ]
  store { i8**, i64 }* %t68, { i8**, i64 }** %l1
  store { i8**, i64 }* %t69, { i8**, i64 }** %l2
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge1
merge1:
  %t73 = phi { i8**, i64 }* [ %t70, %merge4 ], [ %t13, %entry ]
  %t74 = phi { i8**, i64 }* [ %t71, %merge4 ], [ %t14, %entry ]
  %t75 = phi { i8**, i64 }* [ %t72, %merge4 ], [ %t13, %entry ]
  store { i8**, i64 }* %t73, { i8**, i64 }** %l1
  store { i8**, i64 }* %t74, { i8**, i64 }** %l2
  store { i8**, i64 }* %t75, { i8**, i64 }** %l1
  %t76 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t77 = extractvalue %HeaderNameParse %t76, 0
  %t78 = insertvalue %StructHeaderParse undef, i8* %t77, 0
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t80 = insertvalue %StructHeaderParse %t78, { i8**, i64 }* %t79, 1
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t82 = insertvalue %StructHeaderParse %t80, { i8**, i64 }* %t81, 2
  ret %StructHeaderParse %t82
}

define %InterfaceHeaderParse @parse_interface_header(i8* %text) {
entry:
  %l0 = alloca %HeaderNameParse
  %l1 = alloca { i8**, i64 }*
  %t0 = call %HeaderNameParse @parse_header_name_and_remainder(i8* %text)
  store %HeaderNameParse %t0, %HeaderNameParse* %l0
  %t1 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t2 = extractvalue %HeaderNameParse %t1, 3
  store { i8**, i64 }* %t2, { i8**, i64 }** %l1
  %t3 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t4 = extractvalue %HeaderNameParse %t3, 2
  %t5 = call i64 @sailfin_runtime_string_length(i8* %t4)
  %t6 = icmp sgt i64 %t5, 0
  %t7 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t6, label %then0, label %merge1
then0:
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s10 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t11 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t12 = extractvalue %HeaderNameParse %t11, 0
  %t13 = call i8* @sailfin_runtime_string_concat(i8* %s10, i8* %t12)
  %s14 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.len33.h1132321576, i32 0, i32 0
  %t15 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %s14)
  %t16 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t17 = extractvalue %HeaderNameParse %t16, 2
  %t18 = call i8* @sailfin_runtime_string_concat(i8* %t15, i8* %t17)
  %t19 = load i8, i8* %t18
  %t20 = add i8 %t19, 96
  %t21 = alloca [2 x i8], align 1
  %t22 = getelementptr [2 x i8], [2 x i8]* %t21, i32 0, i32 0
  store i8 %t20, i8* %t22
  %t23 = getelementptr [2 x i8], [2 x i8]* %t21, i32 0, i32 1
  store i8 0, i8* %t23
  %t24 = getelementptr [2 x i8], [2 x i8]* %t21, i32 0, i32 0
  %t25 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t9, i8* %t24)
  store { i8**, i64 }* %t25, { i8**, i64 }** %l1
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge1
merge1:
  %t27 = phi { i8**, i64 }* [ %t26, %then0 ], [ %t8, %entry ]
  store { i8**, i64 }* %t27, { i8**, i64 }** %l1
  %t28 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t29 = extractvalue %HeaderNameParse %t28, 0
  %t30 = insertvalue %InterfaceHeaderParse undef, i8* %t29, 0
  %t31 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t32 = extractvalue %HeaderNameParse %t31, 1
  %t33 = insertvalue %InterfaceHeaderParse %t30, { i8**, i64 }* %t32, 1
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t35 = insertvalue %InterfaceHeaderParse %t33, { i8**, i64 }* %t34, 2
  ret %InterfaceHeaderParse %t35
}

define %InterfaceSignatureParse @parse_interface_signature(i8* %text, i8* %interface_name) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca %NativeInterfaceSignature
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca i1
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca %HeaderNameParse
  %l9 = alloca i8*
  %l10 = alloca i8*
  %l11 = alloca { %NativeParameter*, i64 }*
  %l12 = alloca i8*
  %l13 = alloca { i8**, i64 }*
  %l14 = alloca double
  %l15 = alloca %NativeParameter*
  %l16 = alloca i8*
  %l17 = alloca { i8**, i64 }*
  %l18 = alloca i8*
  %l19 = alloca double
  %l20 = alloca i8*
  %l21 = alloca i8*
  %l22 = alloca i8*
  %l23 = alloca %NativeInterfaceSignature
  %l24 = alloca i1
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t6 = insertvalue %NativeInterfaceSignature undef, i8* %s5, 0
  %t7 = insertvalue %NativeInterfaceSignature %t6, i1 0, 1
  %t8 = alloca [0 x i8*]
  %t9 = getelementptr [0 x i8*], [0 x i8*]* %t8, i32 0, i32 0
  %t10 = alloca { i8**, i64 }
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t9, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  %t13 = insertvalue %NativeInterfaceSignature %t7, { i8**, i64 }* %t10, 2
  %t14 = alloca [0 x %NativeParameter*]
  %t15 = getelementptr [0 x %NativeParameter*], [0 x %NativeParameter*]* %t14, i32 0, i32 0
  %t16 = alloca { %NativeParameter**, i64 }
  %t17 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t16, i32 0, i32 0
  store %NativeParameter** %t15, %NativeParameter*** %t17
  %t18 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t16, i32 0, i32 1
  store i64 0, i64* %t18
  %t19 = insertvalue %NativeInterfaceSignature %t13, { %NativeParameter**, i64 }* %t16, 3
  %s20 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h278197661, i32 0, i32 0
  %t21 = insertvalue %NativeInterfaceSignature %t19, i8* %s20, 4
  %t22 = alloca [0 x i8*]
  %t23 = getelementptr [0 x i8*], [0 x i8*]* %t22, i32 0, i32 0
  %t24 = alloca { i8**, i64 }
  %t25 = getelementptr { i8**, i64 }, { i8**, i64 }* %t24, i32 0, i32 0
  store i8** %t23, i8*** %t25
  %t26 = getelementptr { i8**, i64 }, { i8**, i64 }* %t24, i32 0, i32 1
  store i64 0, i64* %t26
  %t27 = insertvalue %NativeInterfaceSignature %t21, { i8**, i64 }* %t24, 5
  store %NativeInterfaceSignature %t27, %NativeInterfaceSignature* %l1
  %t28 = call i8* @trim_text(i8* %text)
  %t29 = call i8* @trim_trailing_delimiters(i8* %t28)
  store i8* %t29, i8** %l2
  %t30 = load i8*, i8** %l2
  %t31 = call i64 @sailfin_runtime_string_length(i8* %t30)
  %t32 = icmp eq i64 %t31, 0
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t35 = load i8*, i8** %l2
  br i1 %t32, label %then0, label %merge1
then0:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s37 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %s37, i8* %interface_name)
  %s39 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h1834305347, i32 0, i32 0
  %t40 = call i8* @sailfin_runtime_string_concat(i8* %t38, i8* %s39)
  %t41 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t36, i8* %t40)
  store { i8**, i64 }* %t41, { i8**, i64 }** %l0
  %t42 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t43 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t44 = insertvalue %InterfaceSignatureParse %t42, %NativeInterfaceSignature %t43, 1
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t46 = insertvalue %InterfaceSignatureParse %t44, { i8**, i64 }* %t45, 2
  ret %InterfaceSignatureParse %t46
merge1:
  %t47 = load i8*, i8** %l2
  store i8* %t47, i8** %l3
  store i1 0, i1* %l4
  %t48 = load i8*, i8** %l3
  %s49 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1134498859, i32 0, i32 0
  %t50 = call i1 @starts_with(i8* %t48, i8* %s49)
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t53 = load i8*, i8** %l2
  %t54 = load i8*, i8** %l3
  %t55 = load i1, i1* %l4
  br i1 %t50, label %then2, label %merge3
then2:
  store i1 1, i1* %l4
  %t56 = load i8*, i8** %l3
  %s57 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1134498859, i32 0, i32 0
  %t58 = call i8* @strip_prefix(i8* %t56, i8* %s57)
  %t59 = call i8* @trim_text(i8* %t58)
  store i8* %t59, i8** %l3
  %t60 = load i1, i1* %l4
  %t61 = load i8*, i8** %l3
  br label %merge3
merge3:
  %t62 = phi i1 [ %t60, %then2 ], [ %t55, %merge1 ]
  %t63 = phi i8* [ %t61, %then2 ], [ %t54, %merge1 ]
  store i1 %t62, i1* %l4
  store i8* %t63, i8** %l3
  %t64 = load i8*, i8** %l3
  %t65 = alloca [2 x i8], align 1
  %t66 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 0
  store i8 40, i8* %t66
  %t67 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 1
  store i8 0, i8* %t67
  %t68 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 0
  %t69 = call double @index_of(i8* %t64, i8* %t68)
  store double %t69, double* %l5
  %t70 = load double, double* %l5
  %t71 = sitofp i64 0 to double
  %t72 = fcmp olt double %t70, %t71
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t75 = load i8*, i8** %l2
  %t76 = load i8*, i8** %l3
  %t77 = load i1, i1* %l4
  %t78 = load double, double* %l5
  br i1 %t72, label %then4, label %merge5
then4:
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s80 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t81 = call i8* @sailfin_runtime_string_concat(i8* %s80, i8* %interface_name)
  %s82 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.len35.h546841458, i32 0, i32 0
  %t83 = call i8* @sailfin_runtime_string_concat(i8* %t81, i8* %s82)
  %t84 = load i8*, i8** %l2
  %t85 = call i8* @sailfin_runtime_string_concat(i8* %t83, i8* %t84)
  %t86 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t79, i8* %t85)
  store { i8**, i64 }* %t86, { i8**, i64 }** %l0
  %t87 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t88 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t89 = insertvalue %InterfaceSignatureParse %t87, %NativeInterfaceSignature %t88, 1
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t91 = insertvalue %InterfaceSignatureParse %t89, { i8**, i64 }* %t90, 2
  ret %InterfaceSignatureParse %t91
merge5:
  %t92 = load i8*, i8** %l3
  %t93 = load double, double* %l5
  %t94 = call double @find_matching_paren(i8* %t92, double %t93)
  store double %t94, double* %l6
  %t95 = load double, double* %l6
  %t96 = sitofp i64 0 to double
  %t97 = fcmp olt double %t95, %t96
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t99 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t100 = load i8*, i8** %l2
  %t101 = load i8*, i8** %l3
  %t102 = load i1, i1* %l4
  %t103 = load double, double* %l5
  %t104 = load double, double* %l6
  br i1 %t97, label %then6, label %merge7
then6:
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s106 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t107 = call i8* @sailfin_runtime_string_concat(i8* %s106, i8* %interface_name)
  %s108 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.len44.h1730891783, i32 0, i32 0
  %t109 = call i8* @sailfin_runtime_string_concat(i8* %t107, i8* %s108)
  %t110 = load i8*, i8** %l2
  %t111 = call i8* @sailfin_runtime_string_concat(i8* %t109, i8* %t110)
  %t112 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t105, i8* %t111)
  store { i8**, i64 }* %t112, { i8**, i64 }** %l0
  %t113 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t114 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t115 = insertvalue %InterfaceSignatureParse %t113, %NativeInterfaceSignature %t114, 1
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t117 = insertvalue %InterfaceSignatureParse %t115, { i8**, i64 }* %t116, 2
  ret %InterfaceSignatureParse %t117
merge7:
  %t118 = load i8*, i8** %l3
  %t119 = load double, double* %l5
  %t120 = fptosi double %t119 to i64
  %t121 = call i8* @sailfin_runtime_substring(i8* %t118, i64 0, i64 %t120)
  %t122 = call i8* @trim_text(i8* %t121)
  store i8* %t122, i8** %l7
  %t123 = load i8*, i8** %l7
  %t124 = call %HeaderNameParse @parse_header_name_and_remainder(i8* %t123)
  store %HeaderNameParse %t124, %HeaderNameParse* %l8
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t126 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t127 = extractvalue %HeaderNameParse %t126, 3
  %t128 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t125, { i8**, i64 }* %t127)
  store { i8**, i64 }* %t128, { i8**, i64 }** %l0
  %t129 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t130 = extractvalue %HeaderNameParse %t129, 2
  %t131 = call i64 @sailfin_runtime_string_length(i8* %t130)
  %t132 = icmp sgt i64 %t131, 0
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t134 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t135 = load i8*, i8** %l2
  %t136 = load i8*, i8** %l3
  %t137 = load i1, i1* %l4
  %t138 = load double, double* %l5
  %t139 = load double, double* %l6
  %t140 = load i8*, i8** %l7
  %t141 = load %HeaderNameParse, %HeaderNameParse* %l8
  br i1 %t132, label %then8, label %merge9
then8:
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s143 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t144 = call i8* @sailfin_runtime_string_concat(i8* %s143, i8* %interface_name)
  %s145 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h841153022, i32 0, i32 0
  %t146 = call i8* @sailfin_runtime_string_concat(i8* %t144, i8* %s145)
  %t147 = load i8*, i8** %l2
  %t148 = call i8* @sailfin_runtime_string_concat(i8* %t146, i8* %t147)
  %s149 = getelementptr inbounds [28 x i8], [28 x i8]* @.str.len27.h237652301, i32 0, i32 0
  %t150 = call i8* @sailfin_runtime_string_concat(i8* %t148, i8* %s149)
  %t151 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t152 = extractvalue %HeaderNameParse %t151, 2
  %t153 = call i8* @sailfin_runtime_string_concat(i8* %t150, i8* %t152)
  %t154 = load i8, i8* %t153
  %t155 = add i8 %t154, 96
  %t156 = alloca [2 x i8], align 1
  %t157 = getelementptr [2 x i8], [2 x i8]* %t156, i32 0, i32 0
  store i8 %t155, i8* %t157
  %t158 = getelementptr [2 x i8], [2 x i8]* %t156, i32 0, i32 1
  store i8 0, i8* %t158
  %t159 = getelementptr [2 x i8], [2 x i8]* %t156, i32 0, i32 0
  %t160 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t142, i8* %t159)
  store { i8**, i64 }* %t160, { i8**, i64 }** %l0
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t162 = phi { i8**, i64 }* [ %t161, %then8 ], [ %t133, %merge7 ]
  store { i8**, i64 }* %t162, { i8**, i64 }** %l0
  %t163 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t164 = extractvalue %HeaderNameParse %t163, 0
  store i8* %t164, i8** %l9
  %t165 = load i8*, i8** %l9
  %t166 = call i64 @sailfin_runtime_string_length(i8* %t165)
  %t167 = icmp eq i64 %t166, 0
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t169 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t170 = load i8*, i8** %l2
  %t171 = load i8*, i8** %l3
  %t172 = load i1, i1* %l4
  %t173 = load double, double* %l5
  %t174 = load double, double* %l6
  %t175 = load i8*, i8** %l7
  %t176 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t177 = load i8*, i8** %l9
  br i1 %t167, label %then10, label %merge11
then10:
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s179 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t180 = call i8* @sailfin_runtime_string_concat(i8* %s179, i8* %interface_name)
  %s181 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h841153022, i32 0, i32 0
  %t182 = call i8* @sailfin_runtime_string_concat(i8* %t180, i8* %s181)
  %t183 = load i8*, i8** %l2
  %t184 = call i8* @sailfin_runtime_string_concat(i8* %t182, i8* %t183)
  %s185 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1219450488, i32 0, i32 0
  %t186 = call i8* @sailfin_runtime_string_concat(i8* %t184, i8* %s185)
  %t187 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t178, i8* %t186)
  store { i8**, i64 }* %t187, { i8**, i64 }** %l0
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge11
merge11:
  %t189 = phi { i8**, i64 }* [ %t188, %then10 ], [ %t168, %merge9 ]
  store { i8**, i64 }* %t189, { i8**, i64 }** %l0
  %t190 = load i8*, i8** %l3
  %t191 = load double, double* %l5
  %t192 = sitofp i64 1 to double
  %t193 = fadd double %t191, %t192
  %t194 = load double, double* %l6
  %t195 = fptosi double %t193 to i64
  %t196 = fptosi double %t194 to i64
  %t197 = call i8* @sailfin_runtime_substring(i8* %t190, i64 %t195, i64 %t196)
  store i8* %t197, i8** %l10
  %t198 = alloca [0 x %NativeParameter]
  %t199 = getelementptr [0 x %NativeParameter], [0 x %NativeParameter]* %t198, i32 0, i32 0
  %t200 = alloca { %NativeParameter*, i64 }
  %t201 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t200, i32 0, i32 0
  store %NativeParameter* %t199, %NativeParameter** %t201
  %t202 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t200, i32 0, i32 1
  store i64 0, i64* %t202
  store { %NativeParameter*, i64 }* %t200, { %NativeParameter*, i64 }** %l11
  %t203 = load i8*, i8** %l10
  %t204 = call i8* @trim_text(i8* %t203)
  store i8* %t204, i8** %l12
  %t205 = load i8*, i8** %l12
  %t206 = call i64 @sailfin_runtime_string_length(i8* %t205)
  %t207 = icmp sgt i64 %t206, 0
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t209 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t210 = load i8*, i8** %l2
  %t211 = load i8*, i8** %l3
  %t212 = load i1, i1* %l4
  %t213 = load double, double* %l5
  %t214 = load double, double* %l6
  %t215 = load i8*, i8** %l7
  %t216 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t217 = load i8*, i8** %l9
  %t218 = load i8*, i8** %l10
  %t219 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t220 = load i8*, i8** %l12
  br i1 %t207, label %then12, label %merge13
then12:
  %t221 = load i8*, i8** %l12
  %t222 = call { i8**, i64 }* @split_parameter_entries(i8* %t221)
  store { i8**, i64 }* %t222, { i8**, i64 }** %l13
  %t223 = sitofp i64 0 to double
  store double %t223, double* %l14
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t225 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t226 = load i8*, i8** %l2
  %t227 = load i8*, i8** %l3
  %t228 = load i1, i1* %l4
  %t229 = load double, double* %l5
  %t230 = load double, double* %l6
  %t231 = load i8*, i8** %l7
  %t232 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t233 = load i8*, i8** %l9
  %t234 = load i8*, i8** %l10
  %t235 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t236 = load i8*, i8** %l12
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t238 = load double, double* %l14
  br label %loop.header14
loop.header14:
  %t329 = phi { i8**, i64 }* [ %t224, %then12 ], [ %t326, %loop.latch16 ]
  %t330 = phi { %NativeParameter*, i64 }* [ %t235, %then12 ], [ %t327, %loop.latch16 ]
  %t331 = phi double [ %t238, %then12 ], [ %t328, %loop.latch16 ]
  store { i8**, i64 }* %t329, { i8**, i64 }** %l0
  store { %NativeParameter*, i64 }* %t330, { %NativeParameter*, i64 }** %l11
  store double %t331, double* %l14
  br label %loop.body15
loop.body15:
  %t239 = load double, double* %l14
  %t240 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t241 = load { i8**, i64 }, { i8**, i64 }* %t240
  %t242 = extractvalue { i8**, i64 } %t241, 1
  %t243 = sitofp i64 %t242 to double
  %t244 = fcmp oge double %t239, %t243
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t246 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t247 = load i8*, i8** %l2
  %t248 = load i8*, i8** %l3
  %t249 = load i1, i1* %l4
  %t250 = load double, double* %l5
  %t251 = load double, double* %l6
  %t252 = load i8*, i8** %l7
  %t253 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t254 = load i8*, i8** %l9
  %t255 = load i8*, i8** %l10
  %t256 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t257 = load i8*, i8** %l12
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t259 = load double, double* %l14
  br i1 %t244, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t260 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t261 = load double, double* %l14
  %t262 = fptosi double %t261 to i64
  %t263 = load { i8**, i64 }, { i8**, i64 }* %t260
  %t264 = extractvalue { i8**, i64 } %t263, 0
  %t265 = extractvalue { i8**, i64 } %t263, 1
  %t266 = icmp uge i64 %t262, %t265
  ; bounds check: %t266 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t262, i64 %t265)
  %t267 = getelementptr i8*, i8** %t264, i64 %t262
  %t268 = load i8*, i8** %t267
  %t269 = bitcast i8* null to %NativeSourceSpan*
  %t270 = call %NativeParameter* @parse_parameter_entry(i8* %t268, %NativeSourceSpan* %t269)
  store %NativeParameter* %t270, %NativeParameter** %l15
  %t271 = load %NativeParameter*, %NativeParameter** %l15
  %t272 = icmp eq %NativeParameter* %t271, null
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t274 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t275 = load i8*, i8** %l2
  %t276 = load i8*, i8** %l3
  %t277 = load i1, i1* %l4
  %t278 = load double, double* %l5
  %t279 = load double, double* %l6
  %t280 = load i8*, i8** %l7
  %t281 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t282 = load i8*, i8** %l9
  %t283 = load i8*, i8** %l10
  %t284 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t285 = load i8*, i8** %l12
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t287 = load double, double* %l14
  %t288 = load %NativeParameter*, %NativeParameter** %l15
  br i1 %t272, label %then20, label %else21
then20:
  %t289 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s290 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t291 = call i8* @sailfin_runtime_string_concat(i8* %s290, i8* %interface_name)
  %s292 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h841153022, i32 0, i32 0
  %t293 = call i8* @sailfin_runtime_string_concat(i8* %t291, i8* %s292)
  %t294 = load i8*, i8** %l9
  %t295 = call i8* @sailfin_runtime_string_concat(i8* %t293, i8* %t294)
  %s296 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h378946335, i32 0, i32 0
  %t297 = call i8* @sailfin_runtime_string_concat(i8* %t295, i8* %s296)
  %t298 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t299 = load double, double* %l14
  %t300 = fptosi double %t299 to i64
  %t301 = load { i8**, i64 }, { i8**, i64 }* %t298
  %t302 = extractvalue { i8**, i64 } %t301, 0
  %t303 = extractvalue { i8**, i64 } %t301, 1
  %t304 = icmp uge i64 %t300, %t303
  ; bounds check: %t304 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t300, i64 %t303)
  %t305 = getelementptr i8*, i8** %t302, i64 %t300
  %t306 = load i8*, i8** %t305
  %t307 = call i8* @sailfin_runtime_string_concat(i8* %t297, i8* %t306)
  %t308 = load i8, i8* %t307
  %t309 = add i8 %t308, 96
  %t310 = alloca [2 x i8], align 1
  %t311 = getelementptr [2 x i8], [2 x i8]* %t310, i32 0, i32 0
  store i8 %t309, i8* %t311
  %t312 = getelementptr [2 x i8], [2 x i8]* %t310, i32 0, i32 1
  store i8 0, i8* %t312
  %t313 = getelementptr [2 x i8], [2 x i8]* %t310, i32 0, i32 0
  %t314 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t289, i8* %t313)
  store { i8**, i64 }* %t314, { i8**, i64 }** %l0
  %t315 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge22
else21:
  %t316 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t317 = load %NativeParameter*, %NativeParameter** %l15
  %t318 = load %NativeParameter, %NativeParameter* %t317
  %t319 = call { %NativeParameter*, i64 }* @append_parameter_array({ %NativeParameter*, i64 }* %t316, %NativeParameter %t318)
  store { %NativeParameter*, i64 }* %t319, { %NativeParameter*, i64 }** %l11
  %t320 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  br label %merge22
merge22:
  %t321 = phi { i8**, i64 }* [ %t315, %then20 ], [ %t273, %else21 ]
  %t322 = phi { %NativeParameter*, i64 }* [ %t284, %then20 ], [ %t320, %else21 ]
  store { i8**, i64 }* %t321, { i8**, i64 }** %l0
  store { %NativeParameter*, i64 }* %t322, { %NativeParameter*, i64 }** %l11
  %t323 = load double, double* %l14
  %t324 = sitofp i64 1 to double
  %t325 = fadd double %t323, %t324
  store double %t325, double* %l14
  br label %loop.latch16
loop.latch16:
  %t326 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t327 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t328 = load double, double* %l14
  br label %loop.header14
afterloop17:
  %t332 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t333 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t334 = load double, double* %l14
  %t335 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t336 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  br label %merge13
merge13:
  %t337 = phi { i8**, i64 }* [ %t335, %afterloop17 ], [ %t208, %merge11 ]
  %t338 = phi { %NativeParameter*, i64 }* [ %t336, %afterloop17 ], [ %t219, %merge11 ]
  store { i8**, i64 }* %t337, { i8**, i64 }** %l0
  store { %NativeParameter*, i64 }* %t338, { %NativeParameter*, i64 }** %l11
  %s339 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h278197661, i32 0, i32 0
  store i8* %s339, i8** %l16
  %t340 = alloca [0 x i8*]
  %t341 = getelementptr [0 x i8*], [0 x i8*]* %t340, i32 0, i32 0
  %t342 = alloca { i8**, i64 }
  %t343 = getelementptr { i8**, i64 }, { i8**, i64 }* %t342, i32 0, i32 0
  store i8** %t341, i8*** %t343
  %t344 = getelementptr { i8**, i64 }, { i8**, i64 }* %t342, i32 0, i32 1
  store i64 0, i64* %t344
  store { i8**, i64 }* %t342, { i8**, i64 }** %l17
  %t345 = load i8*, i8** %l3
  %t346 = load double, double* %l6
  %t347 = sitofp i64 1 to double
  %t348 = fadd double %t346, %t347
  %t349 = load i8*, i8** %l3
  %t350 = call i64 @sailfin_runtime_string_length(i8* %t349)
  %t351 = fptosi double %t348 to i64
  %t352 = call i8* @sailfin_runtime_substring(i8* %t345, i64 %t351, i64 %t350)
  %t353 = call i8* @trim_text(i8* %t352)
  store i8* %t353, i8** %l18
  %t354 = load i8*, i8** %l18
  %t355 = call i64 @sailfin_runtime_string_length(i8* %t354)
  %t356 = icmp sgt i64 %t355, 0
  %t357 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t358 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t359 = load i8*, i8** %l2
  %t360 = load i8*, i8** %l3
  %t361 = load i1, i1* %l4
  %t362 = load double, double* %l5
  %t363 = load double, double* %l6
  %t364 = load i8*, i8** %l7
  %t365 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t366 = load i8*, i8** %l9
  %t367 = load i8*, i8** %l10
  %t368 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t369 = load i8*, i8** %l12
  %t370 = load i8*, i8** %l16
  %t371 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t372 = load i8*, i8** %l18
  br i1 %t356, label %then23, label %merge24
then23:
  %t373 = load i8*, i8** %l18
  %s374 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415939, i32 0, i32 0
  %t375 = call double @index_of(i8* %t373, i8* %s374)
  store double %t375, double* %l19
  %s376 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s376, i8** %l20
  %t377 = load double, double* %l19
  %t378 = sitofp i64 0 to double
  %t379 = fcmp oge double %t377, %t378
  %t380 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t381 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t382 = load i8*, i8** %l2
  %t383 = load i8*, i8** %l3
  %t384 = load i1, i1* %l4
  %t385 = load double, double* %l5
  %t386 = load double, double* %l6
  %t387 = load i8*, i8** %l7
  %t388 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t389 = load i8*, i8** %l9
  %t390 = load i8*, i8** %l10
  %t391 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t392 = load i8*, i8** %l12
  %t393 = load i8*, i8** %l16
  %t394 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t395 = load i8*, i8** %l18
  %t396 = load double, double* %l19
  %t397 = load i8*, i8** %l20
  br i1 %t379, label %then25, label %merge26
then25:
  %t398 = load i8*, i8** %l18
  %t399 = load double, double* %l19
  %t400 = load i8*, i8** %l18
  %t401 = call i64 @sailfin_runtime_string_length(i8* %t400)
  %t402 = fptosi double %t399 to i64
  %t403 = call i8* @sailfin_runtime_substring(i8* %t398, i64 %t402, i64 %t401)
  %t404 = call i8* @trim_text(i8* %t403)
  store i8* %t404, i8** %l20
  %t405 = load i8*, i8** %l18
  %t406 = load double, double* %l19
  %t407 = fptosi double %t406 to i64
  %t408 = call i8* @sailfin_runtime_substring(i8* %t405, i64 0, i64 %t407)
  %t409 = call i8* @trim_text(i8* %t408)
  store i8* %t409, i8** %l18
  %t410 = load i8*, i8** %l20
  %t411 = load i8*, i8** %l18
  br label %merge26
merge26:
  %t412 = phi i8* [ %t410, %then25 ], [ %t397, %then23 ]
  %t413 = phi i8* [ %t411, %then25 ], [ %t395, %then23 ]
  store i8* %t412, i8** %l20
  store i8* %t413, i8** %l18
  %t414 = load i8*, i8** %l18
  %t415 = call i64 @sailfin_runtime_string_length(i8* %t414)
  %t416 = icmp sgt i64 %t415, 0
  %t417 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t418 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t419 = load i8*, i8** %l2
  %t420 = load i8*, i8** %l3
  %t421 = load i1, i1* %l4
  %t422 = load double, double* %l5
  %t423 = load double, double* %l6
  %t424 = load i8*, i8** %l7
  %t425 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t426 = load i8*, i8** %l9
  %t427 = load i8*, i8** %l10
  %t428 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t429 = load i8*, i8** %l12
  %t430 = load i8*, i8** %l16
  %t431 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t432 = load i8*, i8** %l18
  %t433 = load double, double* %l19
  %t434 = load i8*, i8** %l20
  br i1 %t416, label %then27, label %merge28
then27:
  %t435 = load i8*, i8** %l18
  %s436 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t437 = call i1 @starts_with(i8* %t435, i8* %s436)
  %t438 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t439 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t440 = load i8*, i8** %l2
  %t441 = load i8*, i8** %l3
  %t442 = load i1, i1* %l4
  %t443 = load double, double* %l5
  %t444 = load double, double* %l6
  %t445 = load i8*, i8** %l7
  %t446 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t447 = load i8*, i8** %l9
  %t448 = load i8*, i8** %l10
  %t449 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t450 = load i8*, i8** %l12
  %t451 = load i8*, i8** %l16
  %t452 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t453 = load i8*, i8** %l18
  %t454 = load double, double* %l19
  %t455 = load i8*, i8** %l20
  br i1 %t437, label %then29, label %else30
then29:
  %t456 = load i8*, i8** %l18
  %s457 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t458 = call i8* @strip_prefix(i8* %t456, i8* %s457)
  %t459 = call i8* @trim_text(i8* %t458)
  store i8* %t459, i8** %l21
  %t460 = load i8*, i8** %l21
  %t461 = call i64 @sailfin_runtime_string_length(i8* %t460)
  %t462 = icmp sgt i64 %t461, 0
  %t463 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t464 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t465 = load i8*, i8** %l2
  %t466 = load i8*, i8** %l3
  %t467 = load i1, i1* %l4
  %t468 = load double, double* %l5
  %t469 = load double, double* %l6
  %t470 = load i8*, i8** %l7
  %t471 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t472 = load i8*, i8** %l9
  %t473 = load i8*, i8** %l10
  %t474 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t475 = load i8*, i8** %l12
  %t476 = load i8*, i8** %l16
  %t477 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t478 = load i8*, i8** %l18
  %t479 = load double, double* %l19
  %t480 = load i8*, i8** %l20
  %t481 = load i8*, i8** %l21
  br i1 %t462, label %then32, label %merge33
then32:
  %t482 = load i8*, i8** %l21
  store i8* %t482, i8** %l16
  %t483 = load i8*, i8** %l16
  br label %merge33
merge33:
  %t484 = phi i8* [ %t483, %then32 ], [ %t476, %then29 ]
  store i8* %t484, i8** %l16
  %t485 = load i8*, i8** %l16
  br label %merge31
else30:
  %t486 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s487 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t488 = call i8* @sailfin_runtime_string_concat(i8* %s487, i8* %interface_name)
  %s489 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h841153022, i32 0, i32 0
  %t490 = call i8* @sailfin_runtime_string_concat(i8* %t488, i8* %s489)
  %t491 = load i8*, i8** %l9
  %t492 = call i8* @sailfin_runtime_string_concat(i8* %t490, i8* %t491)
  %s493 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h1606904140, i32 0, i32 0
  %t494 = call i8* @sailfin_runtime_string_concat(i8* %t492, i8* %s493)
  %t495 = load i8*, i8** %l18
  %t496 = call i8* @sailfin_runtime_string_concat(i8* %t494, i8* %t495)
  %t497 = load i8, i8* %t496
  %t498 = add i8 %t497, 96
  %t499 = alloca [2 x i8], align 1
  %t500 = getelementptr [2 x i8], [2 x i8]* %t499, i32 0, i32 0
  store i8 %t498, i8* %t500
  %t501 = getelementptr [2 x i8], [2 x i8]* %t499, i32 0, i32 1
  store i8 0, i8* %t501
  %t502 = getelementptr [2 x i8], [2 x i8]* %t499, i32 0, i32 0
  %t503 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t486, i8* %t502)
  store { i8**, i64 }* %t503, { i8**, i64 }** %l0
  %t504 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge31
merge31:
  %t505 = phi i8* [ %t485, %merge33 ], [ %t451, %else30 ]
  %t506 = phi { i8**, i64 }* [ %t438, %merge33 ], [ %t504, %else30 ]
  store i8* %t505, i8** %l16
  store { i8**, i64 }* %t506, { i8**, i64 }** %l0
  %t507 = load i8*, i8** %l16
  %t508 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge28
merge28:
  %t509 = phi i8* [ %t507, %merge31 ], [ %t430, %merge26 ]
  %t510 = phi { i8**, i64 }* [ %t508, %merge31 ], [ %t417, %merge26 ]
  store i8* %t509, i8** %l16
  store { i8**, i64 }* %t510, { i8**, i64 }** %l0
  %t511 = load i8*, i8** %l20
  %t512 = call i64 @sailfin_runtime_string_length(i8* %t511)
  %t513 = icmp sgt i64 %t512, 0
  %t514 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t515 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t516 = load i8*, i8** %l2
  %t517 = load i8*, i8** %l3
  %t518 = load i1, i1* %l4
  %t519 = load double, double* %l5
  %t520 = load double, double* %l6
  %t521 = load i8*, i8** %l7
  %t522 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t523 = load i8*, i8** %l9
  %t524 = load i8*, i8** %l10
  %t525 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t526 = load i8*, i8** %l12
  %t527 = load i8*, i8** %l16
  %t528 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t529 = load i8*, i8** %l18
  %t530 = load double, double* %l19
  %t531 = load i8*, i8** %l20
  br i1 %t513, label %then34, label %merge35
then34:
  %t533 = load i8*, i8** %l20
  %s534 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415939, i32 0, i32 0
  %t535 = call i1 @starts_with(i8* %t533, i8* %s534)
  br label %logical_and_entry_532

logical_and_entry_532:
  br i1 %t535, label %logical_and_right_532, label %logical_and_merge_532

logical_and_right_532:
  %t536 = load i8*, i8** %l20
  %t537 = load i8*, i8** %l20
  %t538 = call i64 @sailfin_runtime_string_length(i8* %t537)
  %t539 = sub i64 %t538, 1
  %t540 = getelementptr i8, i8* %t536, i64 %t539
  %t541 = load i8, i8* %t540
  %t542 = icmp eq i8 %t541, 93
  br label %logical_and_right_end_532

logical_and_right_end_532:
  br label %logical_and_merge_532

logical_and_merge_532:
  %t543 = phi i1 [ false, %logical_and_entry_532 ], [ %t542, %logical_and_right_end_532 ]
  %t544 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t545 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t546 = load i8*, i8** %l2
  %t547 = load i8*, i8** %l3
  %t548 = load i1, i1* %l4
  %t549 = load double, double* %l5
  %t550 = load double, double* %l6
  %t551 = load i8*, i8** %l7
  %t552 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t553 = load i8*, i8** %l9
  %t554 = load i8*, i8** %l10
  %t555 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t556 = load i8*, i8** %l12
  %t557 = load i8*, i8** %l16
  %t558 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t559 = load i8*, i8** %l18
  %t560 = load double, double* %l19
  %t561 = load i8*, i8** %l20
  br i1 %t543, label %then36, label %else37
then36:
  %t562 = load i8*, i8** %l20
  %t563 = load i8*, i8** %l20
  %t564 = call i64 @sailfin_runtime_string_length(i8* %t563)
  %t565 = sub i64 %t564, 1
  %t566 = call i8* @sailfin_runtime_substring(i8* %t562, i64 2, i64 %t565)
  store i8* %t566, i8** %l22
  %t567 = load i8*, i8** %l22
  %t568 = call { i8**, i64 }* @parse_effect_list(i8* %t567)
  store { i8**, i64 }* %t568, { i8**, i64 }** %l17
  %t569 = load { i8**, i64 }*, { i8**, i64 }** %l17
  br label %merge38
else37:
  %t570 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s571 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t572 = call i8* @sailfin_runtime_string_concat(i8* %s571, i8* %interface_name)
  %s573 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h841153022, i32 0, i32 0
  %t574 = call i8* @sailfin_runtime_string_concat(i8* %t572, i8* %s573)
  %t575 = load i8*, i8** %l9
  %t576 = call i8* @sailfin_runtime_string_concat(i8* %t574, i8* %t575)
  %s577 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.len34.h1377481172, i32 0, i32 0
  %t578 = call i8* @sailfin_runtime_string_concat(i8* %t576, i8* %s577)
  %t579 = load i8*, i8** %l20
  %t580 = call i8* @sailfin_runtime_string_concat(i8* %t578, i8* %t579)
  %t581 = load i8, i8* %t580
  %t582 = add i8 %t581, 96
  %t583 = alloca [2 x i8], align 1
  %t584 = getelementptr [2 x i8], [2 x i8]* %t583, i32 0, i32 0
  store i8 %t582, i8* %t584
  %t585 = getelementptr [2 x i8], [2 x i8]* %t583, i32 0, i32 1
  store i8 0, i8* %t585
  %t586 = getelementptr [2 x i8], [2 x i8]* %t583, i32 0, i32 0
  %t587 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t570, i8* %t586)
  store { i8**, i64 }* %t587, { i8**, i64 }** %l0
  %t588 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge38
merge38:
  %t589 = phi { i8**, i64 }* [ %t569, %then36 ], [ %t558, %else37 ]
  %t590 = phi { i8**, i64 }* [ %t544, %then36 ], [ %t588, %else37 ]
  store { i8**, i64 }* %t589, { i8**, i64 }** %l17
  store { i8**, i64 }* %t590, { i8**, i64 }** %l0
  %t591 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t592 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge35
merge35:
  %t593 = phi { i8**, i64 }* [ %t591, %merge38 ], [ %t528, %merge28 ]
  %t594 = phi { i8**, i64 }* [ %t592, %merge38 ], [ %t514, %merge28 ]
  store { i8**, i64 }* %t593, { i8**, i64 }** %l17
  store { i8**, i64 }* %t594, { i8**, i64 }** %l0
  %t595 = load i8*, i8** %l18
  %t596 = load i8*, i8** %l16
  %t597 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t598 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t599 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge24
merge24:
  %t600 = phi i8* [ %t595, %merge35 ], [ %t372, %merge13 ]
  %t601 = phi i8* [ %t596, %merge35 ], [ %t370, %merge13 ]
  %t602 = phi { i8**, i64 }* [ %t597, %merge35 ], [ %t357, %merge13 ]
  %t603 = phi { i8**, i64 }* [ %t598, %merge35 ], [ %t371, %merge13 ]
  %t604 = phi { i8**, i64 }* [ %t599, %merge35 ], [ %t357, %merge13 ]
  store i8* %t600, i8** %l18
  store i8* %t601, i8** %l16
  store { i8**, i64 }* %t602, { i8**, i64 }** %l0
  store { i8**, i64 }* %t603, { i8**, i64 }** %l17
  store { i8**, i64 }* %t604, { i8**, i64 }** %l0
  %t605 = load i8*, i8** %l9
  %t606 = insertvalue %NativeInterfaceSignature undef, i8* %t605, 0
  %t607 = load i1, i1* %l4
  %t608 = insertvalue %NativeInterfaceSignature %t606, i1 %t607, 1
  %t609 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t610 = extractvalue %HeaderNameParse %t609, 1
  %t611 = insertvalue %NativeInterfaceSignature %t608, { i8**, i64 }* %t610, 2
  %t612 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t613 = bitcast { %NativeParameter*, i64 }* %t612 to { %NativeParameter**, i64 }*
  %t614 = insertvalue %NativeInterfaceSignature %t611, { %NativeParameter**, i64 }* %t613, 3
  %t615 = load i8*, i8** %l16
  %t616 = insertvalue %NativeInterfaceSignature %t614, i8* %t615, 4
  %t617 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t618 = insertvalue %NativeInterfaceSignature %t616, { i8**, i64 }* %t617, 5
  store %NativeInterfaceSignature %t618, %NativeInterfaceSignature* %l23
  %t620 = load i8*, i8** %l9
  %t621 = call i64 @sailfin_runtime_string_length(i8* %t620)
  %t622 = icmp sgt i64 %t621, 0
  br label %logical_and_entry_619

logical_and_entry_619:
  br i1 %t622, label %logical_and_right_619, label %logical_and_merge_619

logical_and_right_619:
  %t623 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t624 = load { i8**, i64 }, { i8**, i64 }* %t623
  %t625 = extractvalue { i8**, i64 } %t624, 1
  %t626 = icmp eq i64 %t625, 0
  br label %logical_and_right_end_619

logical_and_right_end_619:
  br label %logical_and_merge_619

logical_and_merge_619:
  %t627 = phi i1 [ false, %logical_and_entry_619 ], [ %t626, %logical_and_right_end_619 ]
  store i1 %t627, i1* %l24
  %t628 = load i1, i1* %l24
  %t629 = insertvalue %InterfaceSignatureParse undef, i1 %t628, 0
  %t630 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l23
  %t631 = insertvalue %InterfaceSignatureParse %t629, %NativeInterfaceSignature %t630, 1
  %t632 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t633 = insertvalue %InterfaceSignatureParse %t631, { i8**, i64 }* %t632, 2
  ret %InterfaceSignatureParse %t633
}

define %HeaderNameParse @parse_header_name_and_remainder(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca double
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = call i8* @trim_text(i8* %text)
  store i8* %t5, i8** %l1
  %t6 = load i8*, i8** %l1
  %t7 = call i64 @sailfin_runtime_string_length(i8* %t6)
  %t8 = icmp eq i64 %t7, 0
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load i8*, i8** %l1
  br i1 %t8, label %then0, label %merge1
then0:
  %s11 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t12 = insertvalue %HeaderNameParse undef, i8* %s11, 0
  %t13 = alloca [0 x i8*]
  %t14 = getelementptr [0 x i8*], [0 x i8*]* %t13, i32 0, i32 0
  %t15 = alloca { i8**, i64 }
  %t16 = getelementptr { i8**, i64 }, { i8**, i64 }* %t15, i32 0, i32 0
  store i8** %t14, i8*** %t16
  %t17 = getelementptr { i8**, i64 }, { i8**, i64 }* %t15, i32 0, i32 1
  store i64 0, i64* %t17
  %t18 = insertvalue %HeaderNameParse %t12, { i8**, i64 }* %t15, 1
  %s19 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t20 = insertvalue %HeaderNameParse %t18, i8* %s19, 2
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = insertvalue %HeaderNameParse %t20, { i8**, i64 }* %t21, 3
  ret %HeaderNameParse %t22
merge1:
  %t23 = load i8*, i8** %l1
  store i8* %t23, i8** %l2
  %s24 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s24, i8** %l3
  %t25 = alloca [0 x i8*]
  %t26 = getelementptr [0 x i8*], [0 x i8*]* %t25, i32 0, i32 0
  %t27 = alloca { i8**, i64 }
  %t28 = getelementptr { i8**, i64 }, { i8**, i64 }* %t27, i32 0, i32 0
  store i8** %t26, i8*** %t28
  %t29 = getelementptr { i8**, i64 }, { i8**, i64 }* %t27, i32 0, i32 1
  store i64 0, i64* %t29
  store { i8**, i64 }* %t27, { i8**, i64 }** %l4
  %t30 = load i8*, i8** %l1
  %t31 = alloca [2 x i8], align 1
  %t32 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 0
  store i8 60, i8* %t32
  %t33 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 1
  store i8 0, i8* %t33
  %t34 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 0
  %t35 = call double @index_of(i8* %t30, i8* %t34)
  store double %t35, double* %l5
  %t36 = load double, double* %l5
  %t37 = sitofp i64 0 to double
  %t38 = fcmp oge double %t36, %t37
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load i8*, i8** %l1
  %t41 = load i8*, i8** %l2
  %t42 = load i8*, i8** %l3
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t44 = load double, double* %l5
  br i1 %t38, label %then2, label %else3
then2:
  %t45 = load i8*, i8** %l1
  %t46 = load double, double* %l5
  %t47 = call double @find_matching_angle(i8* %t45, double %t46)
  store double %t47, double* %l6
  %t48 = load double, double* %l6
  %t49 = sitofp i64 0 to double
  %t50 = fcmp olt double %t48, %t49
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load i8*, i8** %l1
  %t53 = load i8*, i8** %l2
  %t54 = load i8*, i8** %l3
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t56 = load double, double* %l5
  %t57 = load double, double* %l6
  br i1 %t50, label %then5, label %merge6
then5:
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s59 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h487238491, i32 0, i32 0
  %t60 = call i8* @sailfin_runtime_string_concat(i8* %s59, i8* %text)
  %s61 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1187531435, i32 0, i32 0
  %t62 = call i8* @sailfin_runtime_string_concat(i8* %t60, i8* %s61)
  %t63 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t58, i8* %t62)
  store { i8**, i64 }* %t63, { i8**, i64 }** %l0
  %t64 = load i8*, i8** %l1
  %t65 = call i8* @strip_generics(i8* %t64)
  store i8* %t65, i8** %l2
  %t66 = load i8*, i8** %l2
  %t67 = insertvalue %HeaderNameParse undef, i8* %t66, 0
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t69 = insertvalue %HeaderNameParse %t67, { i8**, i64 }* %t68, 1
  %t70 = load i8*, i8** %l3
  %t71 = insertvalue %HeaderNameParse %t69, i8* %t70, 2
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t73 = insertvalue %HeaderNameParse %t71, { i8**, i64 }* %t72, 3
  ret %HeaderNameParse %t73
merge6:
  %t74 = load i8*, i8** %l1
  %t75 = load double, double* %l5
  %t76 = fptosi double %t75 to i64
  %t77 = call i8* @sailfin_runtime_substring(i8* %t74, i64 0, i64 %t76)
  %t78 = call i8* @trim_text(i8* %t77)
  store i8* %t78, i8** %l2
  %t79 = load i8*, i8** %l1
  %t80 = load double, double* %l5
  %t81 = sitofp i64 1 to double
  %t82 = fadd double %t80, %t81
  %t83 = load double, double* %l6
  %t84 = fptosi double %t82 to i64
  %t85 = fptosi double %t83 to i64
  %t86 = call i8* @sailfin_runtime_substring(i8* %t79, i64 %t84, i64 %t85)
  store i8* %t86, i8** %l7
  %t87 = load i8*, i8** %l7
  %t88 = call { i8**, i64 }* @parse_type_parameter_entries(i8* %t87)
  store { i8**, i64 }* %t88, { i8**, i64 }** %l4
  %t89 = load i8*, i8** %l1
  %t90 = load double, double* %l6
  %t91 = sitofp i64 1 to double
  %t92 = fadd double %t90, %t91
  %t93 = load i8*, i8** %l1
  %t94 = call i64 @sailfin_runtime_string_length(i8* %t93)
  %t95 = fptosi double %t92 to i64
  %t96 = call i8* @sailfin_runtime_substring(i8* %t89, i64 %t95, i64 %t94)
  %t97 = call i8* @trim_text(i8* %t96)
  store i8* %t97, i8** %l3
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t99 = load i8*, i8** %l2
  %t100 = load i8*, i8** %l2
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t102 = load i8*, i8** %l3
  br label %merge4
else3:
  %t103 = load i8*, i8** %l1
  %t104 = alloca [2 x i8], align 1
  %t105 = getelementptr [2 x i8], [2 x i8]* %t104, i32 0, i32 0
  store i8 32, i8* %t105
  %t106 = getelementptr [2 x i8], [2 x i8]* %t104, i32 0, i32 1
  store i8 0, i8* %t106
  %t107 = getelementptr [2 x i8], [2 x i8]* %t104, i32 0, i32 0
  %t108 = call double @index_of(i8* %t103, i8* %t107)
  store double %t108, double* %l8
  %t109 = load double, double* %l8
  %t110 = sitofp i64 0 to double
  %t111 = fcmp oge double %t109, %t110
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t113 = load i8*, i8** %l1
  %t114 = load i8*, i8** %l2
  %t115 = load i8*, i8** %l3
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t117 = load double, double* %l5
  %t118 = load double, double* %l8
  br i1 %t111, label %then7, label %merge8
then7:
  %t119 = load i8*, i8** %l1
  %t120 = load double, double* %l8
  %t121 = fptosi double %t120 to i64
  %t122 = call i8* @sailfin_runtime_substring(i8* %t119, i64 0, i64 %t121)
  %t123 = call i8* @trim_text(i8* %t122)
  store i8* %t123, i8** %l2
  %t124 = load i8*, i8** %l1
  %t125 = load double, double* %l8
  %t126 = sitofp i64 1 to double
  %t127 = fadd double %t125, %t126
  %t128 = load i8*, i8** %l1
  %t129 = call i64 @sailfin_runtime_string_length(i8* %t128)
  %t130 = fptosi double %t127 to i64
  %t131 = call i8* @sailfin_runtime_substring(i8* %t124, i64 %t130, i64 %t129)
  %t132 = call i8* @trim_text(i8* %t131)
  store i8* %t132, i8** %l3
  %t133 = load i8*, i8** %l2
  %t134 = load i8*, i8** %l3
  br label %merge8
merge8:
  %t135 = phi i8* [ %t133, %then7 ], [ %t114, %else3 ]
  %t136 = phi i8* [ %t134, %then7 ], [ %t115, %else3 ]
  store i8* %t135, i8** %l2
  store i8* %t136, i8** %l3
  %t137 = load i8*, i8** %l2
  %t138 = load i8*, i8** %l3
  br label %merge4
merge4:
  %t139 = phi { i8**, i64 }* [ %t98, %merge6 ], [ %t39, %merge8 ]
  %t140 = phi i8* [ %t99, %merge6 ], [ %t137, %merge8 ]
  %t141 = phi { i8**, i64 }* [ %t101, %merge6 ], [ %t43, %merge8 ]
  %t142 = phi i8* [ %t102, %merge6 ], [ %t138, %merge8 ]
  store { i8**, i64 }* %t139, { i8**, i64 }** %l0
  store i8* %t140, i8** %l2
  store { i8**, i64 }* %t141, { i8**, i64 }** %l4
  store i8* %t142, i8** %l3
  %t143 = load i8*, i8** %l2
  %t144 = call i8* @strip_generics(i8* %t143)
  store i8* %t144, i8** %l2
  %t145 = load i8*, i8** %l2
  %t146 = insertvalue %HeaderNameParse undef, i8* %t145, 0
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t148 = insertvalue %HeaderNameParse %t146, { i8**, i64 }* %t147, 1
  %t149 = load i8*, i8** %l3
  %t150 = insertvalue %HeaderNameParse %t148, i8* %t149, 2
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t152 = insertvalue %HeaderNameParse %t150, { i8**, i64 }* %t151, 3
  ret %HeaderNameParse %t152
}

define { i8**, i64 }* @parse_type_parameter_entries(i8* %text) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = alloca [0 x i8*]
  %t6 = getelementptr [0 x i8*], [0 x i8*]* %t5, i32 0, i32 0
  %t7 = alloca { i8**, i64 }
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t7, i32 0, i32 0
  store i8** %t6, i8*** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  ret { i8**, i64 }* %t7
merge1:
  %t10 = load i8*, i8** %l0
  %t11 = call { i8**, i64 }* @split_top_level_commas(i8* %t10)
  ret { i8**, i64 }* %t11
}

define { i8**, i64 }* @parse_implements_list(i8* %text) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = alloca [0 x i8*]
  %t6 = getelementptr [0 x i8*], [0 x i8*]* %t5, i32 0, i32 0
  %t7 = alloca { i8**, i64 }
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t7, i32 0, i32 0
  store i8** %t6, i8*** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  ret { i8**, i64 }* %t7
merge1:
  %t10 = load i8*, i8** %l0
  %t11 = call { i8**, i64 }* @split_top_level_commas(i8* %t10)
  ret { i8**, i64 }* %t11
}

define { i8**, i64 }* @split_top_level_commas(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca i8
  %l9 = alloca i8*
  %l10 = alloca i8*
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
  %s7 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s7, i8** %l3
  %t8 = sitofp i64 0 to double
  store double %t8, double* %l4
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l5
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l6
  %t11 = sitofp i64 0 to double
  store double %t11, double* %l7
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t13 = load i8*, i8** %l1
  %t14 = load double, double* %l2
  %t15 = load i8*, i8** %l3
  %t16 = load double, double* %l4
  %t17 = load double, double* %l5
  %t18 = load double, double* %l6
  %t19 = load double, double* %l7
  br label %loop.header0
loop.header0:
  %t495 = phi i8* [ %t13, %entry ], [ %t487, %loop.latch2 ]
  %t496 = phi double [ %t14, %entry ], [ %t488, %loop.latch2 ]
  %t497 = phi i8* [ %t15, %entry ], [ %t489, %loop.latch2 ]
  %t498 = phi double [ %t16, %entry ], [ %t490, %loop.latch2 ]
  %t499 = phi double [ %t17, %entry ], [ %t491, %loop.latch2 ]
  %t500 = phi double [ %t18, %entry ], [ %t492, %loop.latch2 ]
  %t501 = phi double [ %t19, %entry ], [ %t493, %loop.latch2 ]
  %t502 = phi { i8**, i64 }* [ %t12, %entry ], [ %t494, %loop.latch2 ]
  store i8* %t495, i8** %l1
  store double %t496, double* %l2
  store i8* %t497, i8** %l3
  store double %t498, double* %l4
  store double %t499, double* %l5
  store double %t500, double* %l6
  store double %t501, double* %l7
  store { i8**, i64 }* %t502, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t20 = load double, double* %l2
  %t21 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t22 = sitofp i64 %t21 to double
  %t23 = fcmp oge double %t20, %t22
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load i8*, i8** %l1
  %t26 = load double, double* %l2
  %t27 = load i8*, i8** %l3
  %t28 = load double, double* %l4
  %t29 = load double, double* %l5
  %t30 = load double, double* %l6
  %t31 = load double, double* %l7
  br i1 %t23, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t32 = load double, double* %l2
  %t33 = fptosi double %t32 to i64
  %t34 = getelementptr i8, i8* %text, i64 %t33
  %t35 = load i8, i8* %t34
  store i8 %t35, i8* %l8
  %t36 = load i8*, i8** %l3
  %t37 = call i64 @sailfin_runtime_string_length(i8* %t36)
  %t38 = icmp sgt i64 %t37, 0
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load i8*, i8** %l1
  %t41 = load double, double* %l2
  %t42 = load i8*, i8** %l3
  %t43 = load double, double* %l4
  %t44 = load double, double* %l5
  %t45 = load double, double* %l6
  %t46 = load double, double* %l7
  %t47 = load i8, i8* %l8
  br i1 %t38, label %then6, label %merge7
then6:
  %t48 = load i8*, i8** %l1
  %t49 = load i8, i8* %l8
  %t50 = load i8, i8* %t48
  %t51 = add i8 %t50, %t49
  %t52 = alloca [2 x i8], align 1
  %t53 = getelementptr [2 x i8], [2 x i8]* %t52, i32 0, i32 0
  store i8 %t51, i8* %t53
  %t54 = getelementptr [2 x i8], [2 x i8]* %t52, i32 0, i32 1
  store i8 0, i8* %t54
  %t55 = getelementptr [2 x i8], [2 x i8]* %t52, i32 0, i32 0
  store i8* %t55, i8** %l1
  %t56 = load i8, i8* %l8
  %t57 = icmp eq i8 %t56, 92
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load i8*, i8** %l1
  %t60 = load double, double* %l2
  %t61 = load i8*, i8** %l3
  %t62 = load double, double* %l4
  %t63 = load double, double* %l5
  %t64 = load double, double* %l6
  %t65 = load double, double* %l7
  %t66 = load i8, i8* %l8
  br i1 %t57, label %then8, label %merge9
then8:
  %t67 = load double, double* %l2
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %t67, %t68
  %t70 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t71 = sitofp i64 %t70 to double
  %t72 = fcmp olt double %t69, %t71
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = load i8*, i8** %l1
  %t75 = load double, double* %l2
  %t76 = load i8*, i8** %l3
  %t77 = load double, double* %l4
  %t78 = load double, double* %l5
  %t79 = load double, double* %l6
  %t80 = load double, double* %l7
  %t81 = load i8, i8* %l8
  br i1 %t72, label %then10, label %merge11
then10:
  %t82 = load i8*, i8** %l1
  %t83 = load double, double* %l2
  %t84 = sitofp i64 1 to double
  %t85 = fadd double %t83, %t84
  %t86 = fptosi double %t85 to i64
  %t87 = getelementptr i8, i8* %text, i64 %t86
  %t88 = load i8, i8* %t87
  %t89 = load i8, i8* %t82
  %t90 = add i8 %t89, %t88
  %t91 = alloca [2 x i8], align 1
  %t92 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 0
  store i8 %t90, i8* %t92
  %t93 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 1
  store i8 0, i8* %t93
  %t94 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 0
  store i8* %t94, i8** %l1
  %t95 = load double, double* %l2
  %t96 = sitofp i64 2 to double
  %t97 = fadd double %t95, %t96
  store double %t97, double* %l2
  br label %loop.latch2
merge11:
  %t98 = load i8*, i8** %l1
  %t99 = load double, double* %l2
  br label %merge9
merge9:
  %t100 = phi i8* [ %t98, %merge11 ], [ %t59, %then6 ]
  %t101 = phi double [ %t99, %merge11 ], [ %t60, %then6 ]
  store i8* %t100, i8** %l1
  store double %t101, double* %l2
  %t102 = load i8, i8* %l8
  %t103 = load i8*, i8** %l3
  %t104 = load i8, i8* %t103
  %t105 = icmp eq i8 %t102, %t104
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t107 = load i8*, i8** %l1
  %t108 = load double, double* %l2
  %t109 = load i8*, i8** %l3
  %t110 = load double, double* %l4
  %t111 = load double, double* %l5
  %t112 = load double, double* %l6
  %t113 = load double, double* %l7
  %t114 = load i8, i8* %l8
  br i1 %t105, label %then12, label %merge13
then12:
  %s115 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s115, i8** %l3
  %t116 = load i8*, i8** %l3
  br label %merge13
merge13:
  %t117 = phi i8* [ %t116, %then12 ], [ %t109, %merge9 ]
  store i8* %t117, i8** %l3
  %t118 = load double, double* %l2
  %t119 = sitofp i64 1 to double
  %t120 = fadd double %t118, %t119
  store double %t120, double* %l2
  br label %loop.latch2
merge7:
  %t122 = load i8, i8* %l8
  %t123 = icmp eq i8 %t122, 34
  br label %logical_or_entry_121

logical_or_entry_121:
  br i1 %t123, label %logical_or_merge_121, label %logical_or_right_121

logical_or_right_121:
  %t124 = load i8, i8* %l8
  %t125 = icmp eq i8 %t124, 39
  br label %logical_or_right_end_121

logical_or_right_end_121:
  br label %logical_or_merge_121

logical_or_merge_121:
  %t126 = phi i1 [ true, %logical_or_entry_121 ], [ %t125, %logical_or_right_end_121 ]
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t128 = load i8*, i8** %l1
  %t129 = load double, double* %l2
  %t130 = load i8*, i8** %l3
  %t131 = load double, double* %l4
  %t132 = load double, double* %l5
  %t133 = load double, double* %l6
  %t134 = load double, double* %l7
  %t135 = load i8, i8* %l8
  br i1 %t126, label %then14, label %merge15
then14:
  %t136 = load i8, i8* %l8
  %t137 = alloca [2 x i8], align 1
  %t138 = getelementptr [2 x i8], [2 x i8]* %t137, i32 0, i32 0
  store i8 %t136, i8* %t138
  %t139 = getelementptr [2 x i8], [2 x i8]* %t137, i32 0, i32 1
  store i8 0, i8* %t139
  %t140 = getelementptr [2 x i8], [2 x i8]* %t137, i32 0, i32 0
  store i8* %t140, i8** %l3
  %t141 = load i8*, i8** %l1
  %t142 = load i8, i8* %l8
  %t143 = load i8, i8* %t141
  %t144 = add i8 %t143, %t142
  %t145 = alloca [2 x i8], align 1
  %t146 = getelementptr [2 x i8], [2 x i8]* %t145, i32 0, i32 0
  store i8 %t144, i8* %t146
  %t147 = getelementptr [2 x i8], [2 x i8]* %t145, i32 0, i32 1
  store i8 0, i8* %t147
  %t148 = getelementptr [2 x i8], [2 x i8]* %t145, i32 0, i32 0
  store i8* %t148, i8** %l1
  %t149 = load double, double* %l2
  %t150 = sitofp i64 1 to double
  %t151 = fadd double %t149, %t150
  store double %t151, double* %l2
  br label %loop.latch2
merge15:
  %t152 = load i8, i8* %l8
  %t153 = icmp eq i8 %t152, 60
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t155 = load i8*, i8** %l1
  %t156 = load double, double* %l2
  %t157 = load i8*, i8** %l3
  %t158 = load double, double* %l4
  %t159 = load double, double* %l5
  %t160 = load double, double* %l6
  %t161 = load double, double* %l7
  %t162 = load i8, i8* %l8
  br i1 %t153, label %then16, label %merge17
then16:
  %t163 = load double, double* %l4
  %t164 = sitofp i64 1 to double
  %t165 = fadd double %t163, %t164
  store double %t165, double* %l4
  %t166 = load i8*, i8** %l1
  %t167 = load i8, i8* %l8
  %t168 = load i8, i8* %t166
  %t169 = add i8 %t168, %t167
  %t170 = alloca [2 x i8], align 1
  %t171 = getelementptr [2 x i8], [2 x i8]* %t170, i32 0, i32 0
  store i8 %t169, i8* %t171
  %t172 = getelementptr [2 x i8], [2 x i8]* %t170, i32 0, i32 1
  store i8 0, i8* %t172
  %t173 = getelementptr [2 x i8], [2 x i8]* %t170, i32 0, i32 0
  store i8* %t173, i8** %l1
  %t174 = load double, double* %l2
  %t175 = sitofp i64 1 to double
  %t176 = fadd double %t174, %t175
  store double %t176, double* %l2
  br label %loop.latch2
merge17:
  %t177 = load i8, i8* %l8
  %t178 = icmp eq i8 %t177, 62
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t180 = load i8*, i8** %l1
  %t181 = load double, double* %l2
  %t182 = load i8*, i8** %l3
  %t183 = load double, double* %l4
  %t184 = load double, double* %l5
  %t185 = load double, double* %l6
  %t186 = load double, double* %l7
  %t187 = load i8, i8* %l8
  br i1 %t178, label %then18, label %merge19
then18:
  %t188 = load double, double* %l4
  %t189 = sitofp i64 0 to double
  %t190 = fcmp ogt double %t188, %t189
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t192 = load i8*, i8** %l1
  %t193 = load double, double* %l2
  %t194 = load i8*, i8** %l3
  %t195 = load double, double* %l4
  %t196 = load double, double* %l5
  %t197 = load double, double* %l6
  %t198 = load double, double* %l7
  %t199 = load i8, i8* %l8
  br i1 %t190, label %then20, label %merge21
then20:
  %t200 = load double, double* %l4
  %t201 = sitofp i64 1 to double
  %t202 = fsub double %t200, %t201
  store double %t202, double* %l4
  %t203 = load double, double* %l4
  br label %merge21
merge21:
  %t204 = phi double [ %t203, %then20 ], [ %t195, %then18 ]
  store double %t204, double* %l4
  %t205 = load i8*, i8** %l1
  %t206 = load i8, i8* %l8
  %t207 = load i8, i8* %t205
  %t208 = add i8 %t207, %t206
  %t209 = alloca [2 x i8], align 1
  %t210 = getelementptr [2 x i8], [2 x i8]* %t209, i32 0, i32 0
  store i8 %t208, i8* %t210
  %t211 = getelementptr [2 x i8], [2 x i8]* %t209, i32 0, i32 1
  store i8 0, i8* %t211
  %t212 = getelementptr [2 x i8], [2 x i8]* %t209, i32 0, i32 0
  store i8* %t212, i8** %l1
  %t213 = load double, double* %l2
  %t214 = sitofp i64 1 to double
  %t215 = fadd double %t213, %t214
  store double %t215, double* %l2
  br label %loop.latch2
merge19:
  %t216 = load i8, i8* %l8
  %t217 = icmp eq i8 %t216, 40
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t219 = load i8*, i8** %l1
  %t220 = load double, double* %l2
  %t221 = load i8*, i8** %l3
  %t222 = load double, double* %l4
  %t223 = load double, double* %l5
  %t224 = load double, double* %l6
  %t225 = load double, double* %l7
  %t226 = load i8, i8* %l8
  br i1 %t217, label %then22, label %merge23
then22:
  %t227 = load double, double* %l5
  %t228 = sitofp i64 1 to double
  %t229 = fadd double %t227, %t228
  store double %t229, double* %l5
  %t230 = load i8*, i8** %l1
  %t231 = load i8, i8* %l8
  %t232 = load i8, i8* %t230
  %t233 = add i8 %t232, %t231
  %t234 = alloca [2 x i8], align 1
  %t235 = getelementptr [2 x i8], [2 x i8]* %t234, i32 0, i32 0
  store i8 %t233, i8* %t235
  %t236 = getelementptr [2 x i8], [2 x i8]* %t234, i32 0, i32 1
  store i8 0, i8* %t236
  %t237 = getelementptr [2 x i8], [2 x i8]* %t234, i32 0, i32 0
  store i8* %t237, i8** %l1
  %t238 = load double, double* %l2
  %t239 = sitofp i64 1 to double
  %t240 = fadd double %t238, %t239
  store double %t240, double* %l2
  br label %loop.latch2
merge23:
  %t241 = load i8, i8* %l8
  %t242 = icmp eq i8 %t241, 41
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t244 = load i8*, i8** %l1
  %t245 = load double, double* %l2
  %t246 = load i8*, i8** %l3
  %t247 = load double, double* %l4
  %t248 = load double, double* %l5
  %t249 = load double, double* %l6
  %t250 = load double, double* %l7
  %t251 = load i8, i8* %l8
  br i1 %t242, label %then24, label %merge25
then24:
  %t252 = load double, double* %l5
  %t253 = sitofp i64 0 to double
  %t254 = fcmp ogt double %t252, %t253
  %t255 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t256 = load i8*, i8** %l1
  %t257 = load double, double* %l2
  %t258 = load i8*, i8** %l3
  %t259 = load double, double* %l4
  %t260 = load double, double* %l5
  %t261 = load double, double* %l6
  %t262 = load double, double* %l7
  %t263 = load i8, i8* %l8
  br i1 %t254, label %then26, label %merge27
then26:
  %t264 = load double, double* %l5
  %t265 = sitofp i64 1 to double
  %t266 = fsub double %t264, %t265
  store double %t266, double* %l5
  %t267 = load double, double* %l5
  br label %merge27
merge27:
  %t268 = phi double [ %t267, %then26 ], [ %t260, %then24 ]
  store double %t268, double* %l5
  %t269 = load i8*, i8** %l1
  %t270 = load i8, i8* %l8
  %t271 = load i8, i8* %t269
  %t272 = add i8 %t271, %t270
  %t273 = alloca [2 x i8], align 1
  %t274 = getelementptr [2 x i8], [2 x i8]* %t273, i32 0, i32 0
  store i8 %t272, i8* %t274
  %t275 = getelementptr [2 x i8], [2 x i8]* %t273, i32 0, i32 1
  store i8 0, i8* %t275
  %t276 = getelementptr [2 x i8], [2 x i8]* %t273, i32 0, i32 0
  store i8* %t276, i8** %l1
  %t277 = load double, double* %l2
  %t278 = sitofp i64 1 to double
  %t279 = fadd double %t277, %t278
  store double %t279, double* %l2
  br label %loop.latch2
merge25:
  %t280 = load i8, i8* %l8
  %t281 = icmp eq i8 %t280, 91
  %t282 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t283 = load i8*, i8** %l1
  %t284 = load double, double* %l2
  %t285 = load i8*, i8** %l3
  %t286 = load double, double* %l4
  %t287 = load double, double* %l5
  %t288 = load double, double* %l6
  %t289 = load double, double* %l7
  %t290 = load i8, i8* %l8
  br i1 %t281, label %then28, label %merge29
then28:
  %t291 = load double, double* %l6
  %t292 = sitofp i64 1 to double
  %t293 = fadd double %t291, %t292
  store double %t293, double* %l6
  %t294 = load i8*, i8** %l1
  %t295 = load i8, i8* %l8
  %t296 = load i8, i8* %t294
  %t297 = add i8 %t296, %t295
  %t298 = alloca [2 x i8], align 1
  %t299 = getelementptr [2 x i8], [2 x i8]* %t298, i32 0, i32 0
  store i8 %t297, i8* %t299
  %t300 = getelementptr [2 x i8], [2 x i8]* %t298, i32 0, i32 1
  store i8 0, i8* %t300
  %t301 = getelementptr [2 x i8], [2 x i8]* %t298, i32 0, i32 0
  store i8* %t301, i8** %l1
  %t302 = load double, double* %l2
  %t303 = sitofp i64 1 to double
  %t304 = fadd double %t302, %t303
  store double %t304, double* %l2
  br label %loop.latch2
merge29:
  %t305 = load i8, i8* %l8
  %t306 = icmp eq i8 %t305, 93
  %t307 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t308 = load i8*, i8** %l1
  %t309 = load double, double* %l2
  %t310 = load i8*, i8** %l3
  %t311 = load double, double* %l4
  %t312 = load double, double* %l5
  %t313 = load double, double* %l6
  %t314 = load double, double* %l7
  %t315 = load i8, i8* %l8
  br i1 %t306, label %then30, label %merge31
then30:
  %t316 = load double, double* %l6
  %t317 = sitofp i64 0 to double
  %t318 = fcmp ogt double %t316, %t317
  %t319 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t320 = load i8*, i8** %l1
  %t321 = load double, double* %l2
  %t322 = load i8*, i8** %l3
  %t323 = load double, double* %l4
  %t324 = load double, double* %l5
  %t325 = load double, double* %l6
  %t326 = load double, double* %l7
  %t327 = load i8, i8* %l8
  br i1 %t318, label %then32, label %merge33
then32:
  %t328 = load double, double* %l6
  %t329 = sitofp i64 1 to double
  %t330 = fsub double %t328, %t329
  store double %t330, double* %l6
  %t331 = load double, double* %l6
  br label %merge33
merge33:
  %t332 = phi double [ %t331, %then32 ], [ %t325, %then30 ]
  store double %t332, double* %l6
  %t333 = load i8*, i8** %l1
  %t334 = load i8, i8* %l8
  %t335 = load i8, i8* %t333
  %t336 = add i8 %t335, %t334
  %t337 = alloca [2 x i8], align 1
  %t338 = getelementptr [2 x i8], [2 x i8]* %t337, i32 0, i32 0
  store i8 %t336, i8* %t338
  %t339 = getelementptr [2 x i8], [2 x i8]* %t337, i32 0, i32 1
  store i8 0, i8* %t339
  %t340 = getelementptr [2 x i8], [2 x i8]* %t337, i32 0, i32 0
  store i8* %t340, i8** %l1
  %t341 = load double, double* %l2
  %t342 = sitofp i64 1 to double
  %t343 = fadd double %t341, %t342
  store double %t343, double* %l2
  br label %loop.latch2
merge31:
  %t344 = load i8, i8* %l8
  %t345 = icmp eq i8 %t344, 123
  %t346 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t347 = load i8*, i8** %l1
  %t348 = load double, double* %l2
  %t349 = load i8*, i8** %l3
  %t350 = load double, double* %l4
  %t351 = load double, double* %l5
  %t352 = load double, double* %l6
  %t353 = load double, double* %l7
  %t354 = load i8, i8* %l8
  br i1 %t345, label %then34, label %merge35
then34:
  %t355 = load double, double* %l7
  %t356 = sitofp i64 1 to double
  %t357 = fadd double %t355, %t356
  store double %t357, double* %l7
  %t358 = load i8*, i8** %l1
  %t359 = load i8, i8* %l8
  %t360 = load i8, i8* %t358
  %t361 = add i8 %t360, %t359
  %t362 = alloca [2 x i8], align 1
  %t363 = getelementptr [2 x i8], [2 x i8]* %t362, i32 0, i32 0
  store i8 %t361, i8* %t363
  %t364 = getelementptr [2 x i8], [2 x i8]* %t362, i32 0, i32 1
  store i8 0, i8* %t364
  %t365 = getelementptr [2 x i8], [2 x i8]* %t362, i32 0, i32 0
  store i8* %t365, i8** %l1
  %t366 = load double, double* %l2
  %t367 = sitofp i64 1 to double
  %t368 = fadd double %t366, %t367
  store double %t368, double* %l2
  br label %loop.latch2
merge35:
  %t369 = load i8, i8* %l8
  %t370 = icmp eq i8 %t369, 125
  %t371 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t372 = load i8*, i8** %l1
  %t373 = load double, double* %l2
  %t374 = load i8*, i8** %l3
  %t375 = load double, double* %l4
  %t376 = load double, double* %l5
  %t377 = load double, double* %l6
  %t378 = load double, double* %l7
  %t379 = load i8, i8* %l8
  br i1 %t370, label %then36, label %merge37
then36:
  %t380 = load double, double* %l7
  %t381 = sitofp i64 0 to double
  %t382 = fcmp ogt double %t380, %t381
  %t383 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t384 = load i8*, i8** %l1
  %t385 = load double, double* %l2
  %t386 = load i8*, i8** %l3
  %t387 = load double, double* %l4
  %t388 = load double, double* %l5
  %t389 = load double, double* %l6
  %t390 = load double, double* %l7
  %t391 = load i8, i8* %l8
  br i1 %t382, label %then38, label %merge39
then38:
  %t392 = load double, double* %l7
  %t393 = sitofp i64 1 to double
  %t394 = fsub double %t392, %t393
  store double %t394, double* %l7
  %t395 = load double, double* %l7
  br label %merge39
merge39:
  %t396 = phi double [ %t395, %then38 ], [ %t390, %then36 ]
  store double %t396, double* %l7
  %t397 = load i8*, i8** %l1
  %t398 = load i8, i8* %l8
  %t399 = load i8, i8* %t397
  %t400 = add i8 %t399, %t398
  %t401 = alloca [2 x i8], align 1
  %t402 = getelementptr [2 x i8], [2 x i8]* %t401, i32 0, i32 0
  store i8 %t400, i8* %t402
  %t403 = getelementptr [2 x i8], [2 x i8]* %t401, i32 0, i32 1
  store i8 0, i8* %t403
  %t404 = getelementptr [2 x i8], [2 x i8]* %t401, i32 0, i32 0
  store i8* %t404, i8** %l1
  %t405 = load double, double* %l2
  %t406 = sitofp i64 1 to double
  %t407 = fadd double %t405, %t406
  store double %t407, double* %l2
  br label %loop.latch2
merge37:
  %t408 = load i8, i8* %l8
  %t409 = icmp eq i8 %t408, 44
  %t410 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t411 = load i8*, i8** %l1
  %t412 = load double, double* %l2
  %t413 = load i8*, i8** %l3
  %t414 = load double, double* %l4
  %t415 = load double, double* %l5
  %t416 = load double, double* %l6
  %t417 = load double, double* %l7
  %t418 = load i8, i8* %l8
  br i1 %t409, label %then40, label %merge41
then40:
  %t420 = load double, double* %l4
  %t421 = sitofp i64 0 to double
  %t422 = fcmp oeq double %t420, %t421
  br label %logical_and_entry_419

logical_and_entry_419:
  br i1 %t422, label %logical_and_right_419, label %logical_and_merge_419

logical_and_right_419:
  %t424 = load double, double* %l5
  %t425 = sitofp i64 0 to double
  %t426 = fcmp oeq double %t424, %t425
  br label %logical_and_entry_423

logical_and_entry_423:
  br i1 %t426, label %logical_and_right_423, label %logical_and_merge_423

logical_and_right_423:
  %t428 = load double, double* %l6
  %t429 = sitofp i64 0 to double
  %t430 = fcmp oeq double %t428, %t429
  br label %logical_and_entry_427

logical_and_entry_427:
  br i1 %t430, label %logical_and_right_427, label %logical_and_merge_427

logical_and_right_427:
  %t431 = load double, double* %l7
  %t432 = sitofp i64 0 to double
  %t433 = fcmp oeq double %t431, %t432
  br label %logical_and_right_end_427

logical_and_right_end_427:
  br label %logical_and_merge_427

logical_and_merge_427:
  %t434 = phi i1 [ false, %logical_and_entry_427 ], [ %t433, %logical_and_right_end_427 ]
  br label %logical_and_right_end_423

logical_and_right_end_423:
  br label %logical_and_merge_423

logical_and_merge_423:
  %t435 = phi i1 [ false, %logical_and_entry_423 ], [ %t434, %logical_and_right_end_423 ]
  br label %logical_and_right_end_419

logical_and_right_end_419:
  br label %logical_and_merge_419

logical_and_merge_419:
  %t436 = phi i1 [ false, %logical_and_entry_419 ], [ %t435, %logical_and_right_end_419 ]
  %t437 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t438 = load i8*, i8** %l1
  %t439 = load double, double* %l2
  %t440 = load i8*, i8** %l3
  %t441 = load double, double* %l4
  %t442 = load double, double* %l5
  %t443 = load double, double* %l6
  %t444 = load double, double* %l7
  %t445 = load i8, i8* %l8
  br i1 %t436, label %then42, label %merge43
then42:
  %t446 = load i8*, i8** %l1
  %t447 = call i8* @trim_text(i8* %t446)
  store i8* %t447, i8** %l9
  %t448 = load i8*, i8** %l9
  %t449 = call i64 @sailfin_runtime_string_length(i8* %t448)
  %t450 = icmp sgt i64 %t449, 0
  %t451 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t452 = load i8*, i8** %l1
  %t453 = load double, double* %l2
  %t454 = load i8*, i8** %l3
  %t455 = load double, double* %l4
  %t456 = load double, double* %l5
  %t457 = load double, double* %l6
  %t458 = load double, double* %l7
  %t459 = load i8, i8* %l8
  %t460 = load i8*, i8** %l9
  br i1 %t450, label %then44, label %merge45
then44:
  %t461 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t462 = load i8*, i8** %l9
  %t463 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t461, i8* %t462)
  store { i8**, i64 }* %t463, { i8**, i64 }** %l0
  %t464 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge45
merge45:
  %t465 = phi { i8**, i64 }* [ %t464, %then44 ], [ %t451, %then42 ]
  store { i8**, i64 }* %t465, { i8**, i64 }** %l0
  %s466 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s466, i8** %l1
  %t467 = load double, double* %l2
  %t468 = sitofp i64 1 to double
  %t469 = fadd double %t467, %t468
  store double %t469, double* %l2
  br label %loop.latch2
merge43:
  %t470 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t471 = load i8*, i8** %l1
  %t472 = load double, double* %l2
  br label %merge41
merge41:
  %t473 = phi { i8**, i64 }* [ %t470, %merge43 ], [ %t410, %merge37 ]
  %t474 = phi i8* [ %t471, %merge43 ], [ %t411, %merge37 ]
  %t475 = phi double [ %t472, %merge43 ], [ %t412, %merge37 ]
  store { i8**, i64 }* %t473, { i8**, i64 }** %l0
  store i8* %t474, i8** %l1
  store double %t475, double* %l2
  %t476 = load i8*, i8** %l1
  %t477 = load i8, i8* %l8
  %t478 = load i8, i8* %t476
  %t479 = add i8 %t478, %t477
  %t480 = alloca [2 x i8], align 1
  %t481 = getelementptr [2 x i8], [2 x i8]* %t480, i32 0, i32 0
  store i8 %t479, i8* %t481
  %t482 = getelementptr [2 x i8], [2 x i8]* %t480, i32 0, i32 1
  store i8 0, i8* %t482
  %t483 = getelementptr [2 x i8], [2 x i8]* %t480, i32 0, i32 0
  store i8* %t483, i8** %l1
  %t484 = load double, double* %l2
  %t485 = sitofp i64 1 to double
  %t486 = fadd double %t484, %t485
  store double %t486, double* %l2
  br label %loop.latch2
loop.latch2:
  %t487 = load i8*, i8** %l1
  %t488 = load double, double* %l2
  %t489 = load i8*, i8** %l3
  %t490 = load double, double* %l4
  %t491 = load double, double* %l5
  %t492 = load double, double* %l6
  %t493 = load double, double* %l7
  %t494 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t503 = load i8*, i8** %l1
  %t504 = load double, double* %l2
  %t505 = load i8*, i8** %l3
  %t506 = load double, double* %l4
  %t507 = load double, double* %l5
  %t508 = load double, double* %l6
  %t509 = load double, double* %l7
  %t510 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t511 = load i8*, i8** %l1
  %t512 = call i8* @trim_text(i8* %t511)
  store i8* %t512, i8** %l10
  %t513 = load i8*, i8** %l10
  %t514 = call i64 @sailfin_runtime_string_length(i8* %t513)
  %t515 = icmp sgt i64 %t514, 0
  %t516 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t517 = load i8*, i8** %l1
  %t518 = load double, double* %l2
  %t519 = load i8*, i8** %l3
  %t520 = load double, double* %l4
  %t521 = load double, double* %l5
  %t522 = load double, double* %l6
  %t523 = load double, double* %l7
  %t524 = load i8*, i8** %l10
  br i1 %t515, label %then46, label %merge47
then46:
  %t525 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t526 = load i8*, i8** %l10
  %t527 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t525, i8* %t526)
  store { i8**, i64 }* %t527, { i8**, i64 }** %l0
  %t528 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge47
merge47:
  %t529 = phi { i8**, i64 }* [ %t528, %then46 ], [ %t516, %afterloop3 ]
  store { i8**, i64 }* %t529, { i8**, i64 }** %l0
  %t530 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t530
}

define double @find_matching_angle(i8* %text, double %start_index) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double %start_index, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t54 = phi double [ %t1, %entry ], [ %t52, %loop.latch2 ]
  %t55 = phi double [ %t2, %entry ], [ %t53, %loop.latch2 ]
  store double %t54, double* %l0
  store double %t55, double* %l1
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
  %t10 = fptosi double %t9 to i64
  %t11 = getelementptr i8, i8* %text, i64 %t10
  %t12 = load i8, i8* %t11
  store i8 %t12, i8* %l2
  %t13 = load i8, i8* %l2
  %t14 = icmp eq i8 %t13, 60
  %t15 = load double, double* %l0
  %t16 = load double, double* %l1
  %t17 = load i8, i8* %l2
  br i1 %t14, label %then6, label %else7
then6:
  %t18 = load double, double* %l0
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l0
  %t21 = load double, double* %l0
  br label %merge8
else7:
  %t22 = load i8, i8* %l2
  %t23 = icmp eq i8 %t22, 62
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  %t26 = load i8, i8* %l2
  br i1 %t23, label %then9, label %merge10
then9:
  %t27 = load double, double* %l0
  %t28 = sitofp i64 0 to double
  %t29 = fcmp ogt double %t27, %t28
  %t30 = load double, double* %l0
  %t31 = load double, double* %l1
  %t32 = load i8, i8* %l2
  br i1 %t29, label %then11, label %else12
then11:
  %t33 = load double, double* %l0
  %t34 = sitofp i64 1 to double
  %t35 = fsub double %t33, %t34
  store double %t35, double* %l0
  %t36 = load double, double* %l0
  %t37 = sitofp i64 0 to double
  %t38 = fcmp oeq double %t36, %t37
  %t39 = load double, double* %l0
  %t40 = load double, double* %l1
  %t41 = load i8, i8* %l2
  br i1 %t38, label %then14, label %merge15
then14:
  %t42 = load double, double* %l1
  ret double %t42
merge15:
  %t43 = load double, double* %l0
  br label %merge13
else12:
  %t44 = load double, double* %l1
  ret double %t44
merge13:
  %t45 = load double, double* %l0
  br label %merge10
merge10:
  %t46 = phi double [ %t45, %merge13 ], [ %t24, %else7 ]
  store double %t46, double* %l0
  %t47 = load double, double* %l0
  br label %merge8
merge8:
  %t48 = phi double [ %t21, %then6 ], [ %t47, %merge10 ]
  store double %t48, double* %l0
  %t49 = load double, double* %l1
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l1
  br label %loop.latch2
loop.latch2:
  %t52 = load double, double* %l0
  %t53 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t56 = load double, double* %l0
  %t57 = load double, double* %l1
  %t58 = sitofp i64 -1 to double
  ret double %t58
}

define double @find_matching_paren(i8* %text, double %start_index) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca double
  %l4 = alloca i8
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double %start_index, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t116 = phi double [ %t2, %entry ], [ %t114, %loop.latch2 ]
  %t117 = phi double [ %t1, %entry ], [ %t115, %loop.latch2 ]
  store double %t116, double* %l1
  store double %t117, double* %l0
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
  %t10 = fptosi double %t9 to i64
  %t11 = getelementptr i8, i8* %text, i64 %t10
  %t12 = load i8, i8* %t11
  store i8 %t12, i8* %l2
  %t14 = load i8, i8* %l2
  %t15 = icmp eq i8 %t14, 34
  br label %logical_or_entry_13

logical_or_entry_13:
  br i1 %t15, label %logical_or_merge_13, label %logical_or_right_13

logical_or_right_13:
  %t16 = load i8, i8* %l2
  %t17 = icmp eq i8 %t16, 39
  br label %logical_or_right_end_13

logical_or_right_end_13:
  br label %logical_or_merge_13

logical_or_merge_13:
  %t18 = phi i1 [ true, %logical_or_entry_13 ], [ %t17, %logical_or_right_end_13 ]
  %t19 = load double, double* %l0
  %t20 = load double, double* %l1
  %t21 = load i8, i8* %l2
  br i1 %t18, label %then6, label %else7
then6:
  %t22 = load double, double* %l1
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l3
  %t25 = load double, double* %l0
  %t26 = load double, double* %l1
  %t27 = load i8, i8* %l2
  %t28 = load double, double* %l3
  br label %loop.header9
loop.header9:
  %t66 = phi double [ %t28, %then6 ], [ %t64, %loop.latch11 ]
  %t67 = phi double [ %t26, %then6 ], [ %t65, %loop.latch11 ]
  store double %t66, double* %l3
  store double %t67, double* %l1
  br label %loop.body10
loop.body10:
  %t29 = load double, double* %l3
  %t30 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t31 = sitofp i64 %t30 to double
  %t32 = fcmp oge double %t29, %t31
  %t33 = load double, double* %l0
  %t34 = load double, double* %l1
  %t35 = load i8, i8* %l2
  %t36 = load double, double* %l3
  br i1 %t32, label %then13, label %merge14
then13:
  %t37 = sitofp i64 -1 to double
  ret double %t37
merge14:
  %t38 = load double, double* %l3
  %t39 = fptosi double %t38 to i64
  %t40 = getelementptr i8, i8* %text, i64 %t39
  %t41 = load i8, i8* %t40
  store i8 %t41, i8* %l4
  %t42 = load i8, i8* %l4
  %t43 = icmp eq i8 %t42, 92
  %t44 = load double, double* %l0
  %t45 = load double, double* %l1
  %t46 = load i8, i8* %l2
  %t47 = load double, double* %l3
  %t48 = load i8, i8* %l4
  br i1 %t43, label %then15, label %merge16
then15:
  %t49 = load double, double* %l3
  %t50 = sitofp i64 2 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l3
  br label %loop.latch11
merge16:
  %t52 = load i8, i8* %l4
  %t53 = load i8, i8* %l2
  %t54 = icmp eq i8 %t52, %t53
  %t55 = load double, double* %l0
  %t56 = load double, double* %l1
  %t57 = load i8, i8* %l2
  %t58 = load double, double* %l3
  %t59 = load i8, i8* %l4
  br i1 %t54, label %then17, label %merge18
then17:
  %t60 = load double, double* %l3
  store double %t60, double* %l1
  br label %afterloop12
merge18:
  %t61 = load double, double* %l3
  %t62 = sitofp i64 1 to double
  %t63 = fadd double %t61, %t62
  store double %t63, double* %l3
  br label %loop.latch11
loop.latch11:
  %t64 = load double, double* %l3
  %t65 = load double, double* %l1
  br label %loop.header9
afterloop12:
  %t68 = load double, double* %l3
  %t69 = load double, double* %l1
  %t70 = load double, double* %l1
  br label %merge8
else7:
  %t71 = load i8, i8* %l2
  %t72 = icmp eq i8 %t71, 40
  %t73 = load double, double* %l0
  %t74 = load double, double* %l1
  %t75 = load i8, i8* %l2
  br i1 %t72, label %then19, label %else20
then19:
  %t76 = load double, double* %l0
  %t77 = sitofp i64 1 to double
  %t78 = fadd double %t76, %t77
  store double %t78, double* %l0
  %t79 = load double, double* %l0
  br label %merge21
else20:
  %t80 = load i8, i8* %l2
  %t81 = icmp eq i8 %t80, 41
  %t82 = load double, double* %l0
  %t83 = load double, double* %l1
  %t84 = load i8, i8* %l2
  br i1 %t81, label %then22, label %merge23
then22:
  %t85 = load double, double* %l0
  %t86 = sitofp i64 0 to double
  %t87 = fcmp ogt double %t85, %t86
  %t88 = load double, double* %l0
  %t89 = load double, double* %l1
  %t90 = load i8, i8* %l2
  br i1 %t87, label %then24, label %else25
then24:
  %t91 = load double, double* %l0
  %t92 = sitofp i64 1 to double
  %t93 = fsub double %t91, %t92
  store double %t93, double* %l0
  %t94 = load double, double* %l0
  %t95 = sitofp i64 0 to double
  %t96 = fcmp oeq double %t94, %t95
  %t97 = load double, double* %l0
  %t98 = load double, double* %l1
  %t99 = load i8, i8* %l2
  br i1 %t96, label %then27, label %merge28
then27:
  %t100 = load double, double* %l1
  ret double %t100
merge28:
  %t101 = load double, double* %l0
  br label %merge26
else25:
  %t102 = sitofp i64 -1 to double
  ret double %t102
merge26:
  %t103 = load double, double* %l0
  br label %merge23
merge23:
  %t104 = phi double [ %t103, %merge26 ], [ %t82, %else20 ]
  store double %t104, double* %l0
  %t105 = load double, double* %l0
  br label %merge21
merge21:
  %t106 = phi double [ %t79, %then19 ], [ %t105, %merge23 ]
  store double %t106, double* %l0
  %t107 = load double, double* %l0
  %t108 = load double, double* %l0
  br label %merge8
merge8:
  %t109 = phi double [ %t70, %afterloop12 ], [ %t20, %merge21 ]
  %t110 = phi double [ %t19, %afterloop12 ], [ %t107, %merge21 ]
  store double %t109, double* %l1
  store double %t110, double* %l0
  %t111 = load double, double* %l1
  %t112 = sitofp i64 1 to double
  %t113 = fadd double %t111, %t112
  store double %t113, double* %l1
  br label %loop.latch2
loop.latch2:
  %t114 = load double, double* %l1
  %t115 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t118 = load double, double* %l1
  %t119 = load double, double* %l0
  %t120 = sitofp i64 -1 to double
  ret double %t120
}

define %EnumParseResult @parse_enum_definition({ i8**, i64 }* %lines, double %start_index) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca { %NativeEnumVariant*, i64 }*
  %l6 = alloca { %NativeEnumVariantLayout*, i64 }*
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca i8*
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca i1
  %l13 = alloca i1
  %l14 = alloca double
  %l15 = alloca %NativeEnumLayout*
  %l16 = alloca i8*
  %l17 = alloca i8*
  %l18 = alloca %EnumLayoutHeaderParse
  %l19 = alloca %EnumLayoutVariantParse
  %l20 = alloca double
  %l21 = alloca %EnumLayoutPayloadParse
  %l22 = alloca double
  %l23 = alloca %NativeEnumVariant*
  %l24 = alloca %NativeEnumLayout*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = fptosi double %start_index to i64
  %t6 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t7 = extractvalue { i8**, i64 } %t6, 0
  %t8 = extractvalue { i8**, i64 } %t6, 1
  %t9 = icmp uge i64 %t5, %t8
  ; bounds check: %t9 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t5, i64 %t8)
  %t10 = getelementptr i8*, i8** %t7, i64 %t5
  %t11 = load i8*, i8** %t10
  %t12 = call i8* @trim_text(i8* %t11)
  store i8* %t12, i8** %l1
  %t13 = load i8*, i8** %l1
  %s14 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1280947313, i32 0, i32 0
  %t15 = call i8* @strip_prefix(i8* %t13, i8* %s14)
  %t16 = call i8* @trim_text(i8* %t15)
  store i8* %t16, i8** %l2
  %t17 = load i8*, i8** %l2
  store i8* %t17, i8** %l3
  %t18 = load i8*, i8** %l3
  %t19 = alloca [2 x i8], align 1
  %t20 = getelementptr [2 x i8], [2 x i8]* %t19, i32 0, i32 0
  store i8 32, i8* %t20
  %t21 = getelementptr [2 x i8], [2 x i8]* %t19, i32 0, i32 1
  store i8 0, i8* %t21
  %t22 = getelementptr [2 x i8], [2 x i8]* %t19, i32 0, i32 0
  %t23 = call double @index_of(i8* %t18, i8* %t22)
  store double %t23, double* %l4
  %t24 = load double, double* %l4
  %t25 = sitofp i64 0 to double
  %t26 = fcmp oge double %t24, %t25
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load i8*, i8** %l1
  %t29 = load i8*, i8** %l2
  %t30 = load i8*, i8** %l3
  %t31 = load double, double* %l4
  br i1 %t26, label %then0, label %merge1
then0:
  %t32 = load i8*, i8** %l3
  %t33 = load double, double* %l4
  %t34 = fptosi double %t33 to i64
  %t35 = call i8* @sailfin_runtime_substring(i8* %t32, i64 0, i64 %t34)
  %t36 = call i8* @trim_text(i8* %t35)
  store i8* %t36, i8** %l3
  %t37 = load i8*, i8** %l3
  br label %merge1
merge1:
  %t38 = phi i8* [ %t37, %then0 ], [ %t30, %entry ]
  store i8* %t38, i8** %l3
  %t39 = load i8*, i8** %l3
  %t40 = call i8* @strip_generics(i8* %t39)
  store i8* %t40, i8** %l3
  %t41 = load i8*, i8** %l3
  %t42 = call i64 @sailfin_runtime_string_length(i8* %t41)
  %t43 = icmp eq i64 %t42, 0
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load i8*, i8** %l1
  %t46 = load i8*, i8** %l2
  %t47 = load i8*, i8** %l3
  %t48 = load double, double* %l4
  br i1 %t43, label %then2, label %merge3
then2:
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s50 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h668562564, i32 0, i32 0
  %t51 = load i8*, i8** %l1
  %t52 = call i8* @sailfin_runtime_string_concat(i8* %s50, i8* %t51)
  %t53 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t49, i8* %t52)
  store { i8**, i64 }* %t53, { i8**, i64 }** %l0
  %t54 = bitcast i8* null to %NativeEnum*
  %t55 = insertvalue %EnumParseResult undef, %NativeEnum* %t54, 0
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %start_index, %t56
  %t58 = insertvalue %EnumParseResult %t55, double %t57, 1
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t60 = insertvalue %EnumParseResult %t58, { i8**, i64 }* %t59, 2
  ret %EnumParseResult %t60
merge3:
  %t61 = alloca [0 x %NativeEnumVariant]
  %t62 = getelementptr [0 x %NativeEnumVariant], [0 x %NativeEnumVariant]* %t61, i32 0, i32 0
  %t63 = alloca { %NativeEnumVariant*, i64 }
  %t64 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t63, i32 0, i32 0
  store %NativeEnumVariant* %t62, %NativeEnumVariant** %t64
  %t65 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t63, i32 0, i32 1
  store i64 0, i64* %t65
  store { %NativeEnumVariant*, i64 }* %t63, { %NativeEnumVariant*, i64 }** %l5
  %t66 = alloca [0 x %NativeEnumVariantLayout]
  %t67 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* %t66, i32 0, i32 0
  %t68 = alloca { %NativeEnumVariantLayout*, i64 }
  %t69 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t68, i32 0, i32 0
  store %NativeEnumVariantLayout* %t67, %NativeEnumVariantLayout** %t69
  %t70 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t68, i32 0, i32 1
  store i64 0, i64* %t70
  store { %NativeEnumVariantLayout*, i64 }* %t68, { %NativeEnumVariantLayout*, i64 }** %l6
  %t71 = sitofp i64 0 to double
  store double %t71, double* %l7
  %t72 = sitofp i64 0 to double
  store double %t72, double* %l8
  %s73 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s73, i8** %l9
  %t74 = sitofp i64 0 to double
  store double %t74, double* %l10
  %t75 = sitofp i64 0 to double
  store double %t75, double* %l11
  store i1 0, i1* %l12
  store i1 0, i1* %l13
  %t76 = sitofp i64 1 to double
  %t77 = fadd double %start_index, %t76
  store double %t77, double* %l14
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t79 = load i8*, i8** %l1
  %t80 = load i8*, i8** %l2
  %t81 = load i8*, i8** %l3
  %t82 = load double, double* %l4
  %t83 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t84 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t85 = load double, double* %l7
  %t86 = load double, double* %l8
  %t87 = load i8*, i8** %l9
  %t88 = load double, double* %l10
  %t89 = load double, double* %l11
  %t90 = load i1, i1* %l12
  %t91 = load i1, i1* %l13
  %t92 = load double, double* %l14
  br label %loop.header4
loop.header4:
  %t799 = phi { i8**, i64 }* [ %t78, %merge3 ], [ %t788, %loop.latch6 ]
  %t800 = phi double [ %t92, %merge3 ], [ %t789, %loop.latch6 ]
  %t801 = phi double [ %t85, %merge3 ], [ %t790, %loop.latch6 ]
  %t802 = phi double [ %t86, %merge3 ], [ %t791, %loop.latch6 ]
  %t803 = phi i8* [ %t87, %merge3 ], [ %t792, %loop.latch6 ]
  %t804 = phi double [ %t88, %merge3 ], [ %t793, %loop.latch6 ]
  %t805 = phi double [ %t89, %merge3 ], [ %t794, %loop.latch6 ]
  %t806 = phi i1 [ %t90, %merge3 ], [ %t795, %loop.latch6 ]
  %t807 = phi { %NativeEnumVariantLayout*, i64 }* [ %t84, %merge3 ], [ %t796, %loop.latch6 ]
  %t808 = phi i1 [ %t91, %merge3 ], [ %t797, %loop.latch6 ]
  %t809 = phi { %NativeEnumVariant*, i64 }* [ %t83, %merge3 ], [ %t798, %loop.latch6 ]
  store { i8**, i64 }* %t799, { i8**, i64 }** %l0
  store double %t800, double* %l14
  store double %t801, double* %l7
  store double %t802, double* %l8
  store i8* %t803, i8** %l9
  store double %t804, double* %l10
  store double %t805, double* %l11
  store i1 %t806, i1* %l12
  store { %NativeEnumVariantLayout*, i64 }* %t807, { %NativeEnumVariantLayout*, i64 }** %l6
  store i1 %t808, i1* %l13
  store { %NativeEnumVariant*, i64 }* %t809, { %NativeEnumVariant*, i64 }** %l5
  br label %loop.body5
loop.body5:
  %t93 = load double, double* %l14
  %t94 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t95 = extractvalue { i8**, i64 } %t94, 1
  %t96 = sitofp i64 %t95 to double
  %t97 = fcmp oge double %t93, %t96
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t99 = load i8*, i8** %l1
  %t100 = load i8*, i8** %l2
  %t101 = load i8*, i8** %l3
  %t102 = load double, double* %l4
  %t103 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t104 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t105 = load double, double* %l7
  %t106 = load double, double* %l8
  %t107 = load i8*, i8** %l9
  %t108 = load double, double* %l10
  %t109 = load double, double* %l11
  %t110 = load i1, i1* %l12
  %t111 = load i1, i1* %l13
  %t112 = load double, double* %l14
  br i1 %t97, label %then8, label %merge9
then8:
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s114 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.len18.h1997941781, i32 0, i32 0
  %t115 = load i8*, i8** %l3
  %t116 = call i8* @sailfin_runtime_string_concat(i8* %s114, i8* %t115)
  %t117 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t113, i8* %t116)
  store { i8**, i64 }* %t117, { i8**, i64 }** %l0
  %t118 = bitcast i8* null to %NativeEnumLayout*
  store %NativeEnumLayout* %t118, %NativeEnumLayout** %l15
  %t119 = load i1, i1* %l12
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t121 = load i8*, i8** %l1
  %t122 = load i8*, i8** %l2
  %t123 = load i8*, i8** %l3
  %t124 = load double, double* %l4
  %t125 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t126 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t127 = load double, double* %l7
  %t128 = load double, double* %l8
  %t129 = load i8*, i8** %l9
  %t130 = load double, double* %l10
  %t131 = load double, double* %l11
  %t132 = load i1, i1* %l12
  %t133 = load i1, i1* %l13
  %t134 = load double, double* %l14
  %t135 = load %NativeEnumLayout*, %NativeEnumLayout** %l15
  br i1 %t119, label %then10, label %merge11
then10:
  %t136 = load double, double* %l7
  %t137 = insertvalue %NativeEnumLayout undef, double %t136, 0
  %t138 = load double, double* %l8
  %t139 = insertvalue %NativeEnumLayout %t137, double %t138, 1
  %t140 = load i8*, i8** %l9
  %t141 = insertvalue %NativeEnumLayout %t139, i8* %t140, 2
  %t142 = load double, double* %l10
  %t143 = insertvalue %NativeEnumLayout %t141, double %t142, 3
  %t144 = load double, double* %l11
  %t145 = insertvalue %NativeEnumLayout %t143, double %t144, 4
  %t146 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t147 = bitcast { %NativeEnumVariantLayout*, i64 }* %t146 to { %NativeEnumVariantLayout**, i64 }*
  %t148 = insertvalue %NativeEnumLayout %t145, { %NativeEnumVariantLayout**, i64 }* %t147, 5
  %t149 = alloca %NativeEnumLayout
  store %NativeEnumLayout %t148, %NativeEnumLayout* %t149
  store %NativeEnumLayout* %t149, %NativeEnumLayout** %l15
  %t150 = load %NativeEnumLayout*, %NativeEnumLayout** %l15
  br label %merge11
merge11:
  %t151 = phi %NativeEnumLayout* [ %t150, %then10 ], [ %t135, %then8 ]
  store %NativeEnumLayout* %t151, %NativeEnumLayout** %l15
  %t152 = load i8*, i8** %l3
  %t153 = insertvalue %NativeEnum undef, i8* %t152, 0
  %t154 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t155 = bitcast { %NativeEnumVariant*, i64 }* %t154 to { %NativeEnumVariant**, i64 }*
  %t156 = insertvalue %NativeEnum %t153, { %NativeEnumVariant**, i64 }* %t155, 1
  %t157 = load %NativeEnumLayout*, %NativeEnumLayout** %l15
  %t158 = insertvalue %NativeEnum %t156, %NativeEnumLayout* %t157, 2
  %t159 = alloca %NativeEnum
  store %NativeEnum %t158, %NativeEnum* %t159
  %t160 = insertvalue %EnumParseResult undef, %NativeEnum* %t159, 0
  %t161 = load double, double* %l14
  %t162 = insertvalue %EnumParseResult %t160, double %t161, 1
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t164 = insertvalue %EnumParseResult %t162, { i8**, i64 }* %t163, 2
  ret %EnumParseResult %t164
merge9:
  %t165 = load double, double* %l14
  %t166 = fptosi double %t165 to i64
  %t167 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t168 = extractvalue { i8**, i64 } %t167, 0
  %t169 = extractvalue { i8**, i64 } %t167, 1
  %t170 = icmp uge i64 %t166, %t169
  ; bounds check: %t170 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t166, i64 %t169)
  %t171 = getelementptr i8*, i8** %t168, i64 %t166
  %t172 = load i8*, i8** %t171
  %t173 = call i8* @trim_text(i8* %t172)
  store i8* %t173, i8** %l16
  %t175 = load i8*, i8** %l16
  %t176 = call i64 @sailfin_runtime_string_length(i8* %t175)
  %t177 = icmp eq i64 %t176, 0
  br label %logical_or_entry_174

logical_or_entry_174:
  br i1 %t177, label %logical_or_merge_174, label %logical_or_right_174

logical_or_right_174:
  %t178 = load i8*, i8** %l16
  %t179 = alloca [2 x i8], align 1
  %t180 = getelementptr [2 x i8], [2 x i8]* %t179, i32 0, i32 0
  store i8 59, i8* %t180
  %t181 = getelementptr [2 x i8], [2 x i8]* %t179, i32 0, i32 1
  store i8 0, i8* %t181
  %t182 = getelementptr [2 x i8], [2 x i8]* %t179, i32 0, i32 0
  %t183 = call i1 @starts_with(i8* %t178, i8* %t182)
  br label %logical_or_right_end_174

logical_or_right_end_174:
  br label %logical_or_merge_174

logical_or_merge_174:
  %t184 = phi i1 [ true, %logical_or_entry_174 ], [ %t183, %logical_or_right_end_174 ]
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t186 = load i8*, i8** %l1
  %t187 = load i8*, i8** %l2
  %t188 = load i8*, i8** %l3
  %t189 = load double, double* %l4
  %t190 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t191 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t192 = load double, double* %l7
  %t193 = load double, double* %l8
  %t194 = load i8*, i8** %l9
  %t195 = load double, double* %l10
  %t196 = load double, double* %l11
  %t197 = load i1, i1* %l12
  %t198 = load i1, i1* %l13
  %t199 = load double, double* %l14
  %t200 = load i8*, i8** %l16
  br i1 %t184, label %then12, label %merge13
then12:
  %t201 = load double, double* %l14
  %t202 = sitofp i64 1 to double
  %t203 = fadd double %t201, %t202
  store double %t203, double* %l14
  br label %loop.latch6
merge13:
  %t204 = load i8*, i8** %l16
  %s205 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t206 = icmp eq i8* %t204, %s205
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t208 = load i8*, i8** %l1
  %t209 = load i8*, i8** %l2
  %t210 = load i8*, i8** %l3
  %t211 = load double, double* %l4
  %t212 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t213 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t214 = load double, double* %l7
  %t215 = load double, double* %l8
  %t216 = load i8*, i8** %l9
  %t217 = load double, double* %l10
  %t218 = load double, double* %l11
  %t219 = load i1, i1* %l12
  %t220 = load i1, i1* %l13
  %t221 = load double, double* %l14
  %t222 = load i8*, i8** %l16
  br i1 %t206, label %then14, label %merge15
then14:
  %t223 = load double, double* %l14
  %t224 = sitofp i64 1 to double
  %t225 = fadd double %t223, %t224
  store double %t225, double* %l14
  br label %loop.latch6
merge15:
  %t226 = load i8*, i8** %l16
  %s227 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t228 = call i1 @starts_with(i8* %t226, i8* %s227)
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t230 = load i8*, i8** %l1
  %t231 = load i8*, i8** %l2
  %t232 = load i8*, i8** %l3
  %t233 = load double, double* %l4
  %t234 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t235 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t236 = load double, double* %l7
  %t237 = load double, double* %l8
  %t238 = load i8*, i8** %l9
  %t239 = load double, double* %l10
  %t240 = load double, double* %l11
  %t241 = load i1, i1* %l12
  %t242 = load i1, i1* %l13
  %t243 = load double, double* %l14
  %t244 = load i8*, i8** %l16
  br i1 %t228, label %then16, label %merge17
then16:
  %t245 = load i8*, i8** %l16
  %s246 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t247 = call i8* @strip_prefix(i8* %t245, i8* %s246)
  store i8* %t247, i8** %l17
  %t248 = load i8*, i8** %l17
  %s249 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t250 = call i1 @starts_with(i8* %t248, i8* %s249)
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t252 = load i8*, i8** %l1
  %t253 = load i8*, i8** %l2
  %t254 = load i8*, i8** %l3
  %t255 = load double, double* %l4
  %t256 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t257 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t258 = load double, double* %l7
  %t259 = load double, double* %l8
  %t260 = load i8*, i8** %l9
  %t261 = load double, double* %l10
  %t262 = load double, double* %l11
  %t263 = load i1, i1* %l12
  %t264 = load i1, i1* %l13
  %t265 = load double, double* %l14
  %t266 = load i8*, i8** %l16
  %t267 = load i8*, i8** %l17
  br i1 %t250, label %then18, label %merge19
then18:
  %t268 = load i8*, i8** %l17
  %s269 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t270 = call i8* @strip_prefix(i8* %t268, i8* %s269)
  %t271 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t270)
  store %EnumLayoutHeaderParse %t271, %EnumLayoutHeaderParse* %l18
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t273 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t274 = extractvalue %EnumLayoutHeaderParse %t273, 7
  %t275 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t272, { i8**, i64 }* %t274)
  store { i8**, i64 }* %t275, { i8**, i64 }** %l0
  %t276 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t277 = extractvalue %EnumLayoutHeaderParse %t276, 0
  %t278 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t279 = load i8*, i8** %l1
  %t280 = load i8*, i8** %l2
  %t281 = load i8*, i8** %l3
  %t282 = load double, double* %l4
  %t283 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t284 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t285 = load double, double* %l7
  %t286 = load double, double* %l8
  %t287 = load i8*, i8** %l9
  %t288 = load double, double* %l10
  %t289 = load double, double* %l11
  %t290 = load i1, i1* %l12
  %t291 = load i1, i1* %l13
  %t292 = load double, double* %l14
  %t293 = load i8*, i8** %l16
  %t294 = load i8*, i8** %l17
  %t295 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t277, label %then20, label %merge21
then20:
  %t296 = load i1, i1* %l12
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t298 = load i8*, i8** %l1
  %t299 = load i8*, i8** %l2
  %t300 = load i8*, i8** %l3
  %t301 = load double, double* %l4
  %t302 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t303 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t304 = load double, double* %l7
  %t305 = load double, double* %l8
  %t306 = load i8*, i8** %l9
  %t307 = load double, double* %l10
  %t308 = load double, double* %l11
  %t309 = load i1, i1* %l12
  %t310 = load i1, i1* %l13
  %t311 = load double, double* %l14
  %t312 = load i8*, i8** %l16
  %t313 = load i8*, i8** %l17
  %t314 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t296, label %then22, label %else23
then22:
  %t315 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s316 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.len32.h1822658020, i32 0, i32 0
  %t317 = load i8*, i8** %l3
  %t318 = call i8* @sailfin_runtime_string_concat(i8* %s316, i8* %t317)
  %t319 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t315, i8* %t318)
  store { i8**, i64 }* %t319, { i8**, i64 }** %l0
  %t320 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge24
else23:
  %t321 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t322 = extractvalue %EnumLayoutHeaderParse %t321, 2
  store double %t322, double* %l7
  %t323 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t324 = extractvalue %EnumLayoutHeaderParse %t323, 3
  store double %t324, double* %l8
  %t325 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t326 = extractvalue %EnumLayoutHeaderParse %t325, 4
  store i8* %t326, i8** %l9
  %t327 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t328 = extractvalue %EnumLayoutHeaderParse %t327, 5
  store double %t328, double* %l10
  %t329 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t330 = extractvalue %EnumLayoutHeaderParse %t329, 6
  store double %t330, double* %l11
  store i1 1, i1* %l12
  %t331 = load double, double* %l7
  %t332 = load double, double* %l8
  %t333 = load i8*, i8** %l9
  %t334 = load double, double* %l10
  %t335 = load double, double* %l11
  %t336 = load i1, i1* %l12
  br label %merge24
merge24:
  %t337 = phi { i8**, i64 }* [ %t320, %then22 ], [ %t297, %else23 ]
  %t338 = phi double [ %t304, %then22 ], [ %t331, %else23 ]
  %t339 = phi double [ %t305, %then22 ], [ %t332, %else23 ]
  %t340 = phi i8* [ %t306, %then22 ], [ %t333, %else23 ]
  %t341 = phi double [ %t307, %then22 ], [ %t334, %else23 ]
  %t342 = phi double [ %t308, %then22 ], [ %t335, %else23 ]
  %t343 = phi i1 [ %t309, %then22 ], [ %t336, %else23 ]
  store { i8**, i64 }* %t337, { i8**, i64 }** %l0
  store double %t338, double* %l7
  store double %t339, double* %l8
  store i8* %t340, i8** %l9
  store double %t341, double* %l10
  store double %t342, double* %l11
  store i1 %t343, i1* %l12
  %t344 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t345 = load double, double* %l7
  %t346 = load double, double* %l8
  %t347 = load i8*, i8** %l9
  %t348 = load double, double* %l10
  %t349 = load double, double* %l11
  %t350 = load i1, i1* %l12
  br label %merge21
merge21:
  %t351 = phi { i8**, i64 }* [ %t344, %merge24 ], [ %t278, %then18 ]
  %t352 = phi double [ %t345, %merge24 ], [ %t285, %then18 ]
  %t353 = phi double [ %t346, %merge24 ], [ %t286, %then18 ]
  %t354 = phi i8* [ %t347, %merge24 ], [ %t287, %then18 ]
  %t355 = phi double [ %t348, %merge24 ], [ %t288, %then18 ]
  %t356 = phi double [ %t349, %merge24 ], [ %t289, %then18 ]
  %t357 = phi i1 [ %t350, %merge24 ], [ %t290, %then18 ]
  store { i8**, i64 }* %t351, { i8**, i64 }** %l0
  store double %t352, double* %l7
  store double %t353, double* %l8
  store i8* %t354, i8** %l9
  store double %t355, double* %l10
  store double %t356, double* %l11
  store i1 %t357, i1* %l12
  %t358 = load double, double* %l14
  %t359 = sitofp i64 1 to double
  %t360 = fadd double %t358, %t359
  store double %t360, double* %l14
  br label %loop.latch6
merge19:
  %t361 = load i8*, i8** %l17
  %s362 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1926252274, i32 0, i32 0
  %t363 = call i1 @starts_with(i8* %t361, i8* %s362)
  %t364 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t365 = load i8*, i8** %l1
  %t366 = load i8*, i8** %l2
  %t367 = load i8*, i8** %l3
  %t368 = load double, double* %l4
  %t369 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t370 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t371 = load double, double* %l7
  %t372 = load double, double* %l8
  %t373 = load i8*, i8** %l9
  %t374 = load double, double* %l10
  %t375 = load double, double* %l11
  %t376 = load i1, i1* %l12
  %t377 = load i1, i1* %l13
  %t378 = load double, double* %l14
  %t379 = load i8*, i8** %l16
  %t380 = load i8*, i8** %l17
  br i1 %t363, label %then25, label %merge26
then25:
  %t381 = load i8*, i8** %l17
  %s382 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1926252274, i32 0, i32 0
  %t383 = call i8* @strip_prefix(i8* %t381, i8* %s382)
  %t384 = load i8*, i8** %l3
  %t385 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t383, i8* %t384)
  store %EnumLayoutVariantParse %t385, %EnumLayoutVariantParse* %l19
  %t386 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t387 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t388 = extractvalue %EnumLayoutVariantParse %t387, 2
  %t389 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t386, { i8**, i64 }* %t388)
  store { i8**, i64 }* %t389, { i8**, i64 }** %l0
  %t390 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t391 = extractvalue %EnumLayoutVariantParse %t390, 0
  %t392 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t393 = load i8*, i8** %l1
  %t394 = load i8*, i8** %l2
  %t395 = load i8*, i8** %l3
  %t396 = load double, double* %l4
  %t397 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t398 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t399 = load double, double* %l7
  %t400 = load double, double* %l8
  %t401 = load i8*, i8** %l9
  %t402 = load double, double* %l10
  %t403 = load double, double* %l11
  %t404 = load i1, i1* %l12
  %t405 = load i1, i1* %l13
  %t406 = load double, double* %l14
  %t407 = load i8*, i8** %l16
  %t408 = load i8*, i8** %l17
  %t409 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  br i1 %t391, label %then27, label %merge28
then27:
  %t410 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t411 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t412 = extractvalue %EnumLayoutVariantParse %t411, 1
  %t413 = extractvalue %NativeEnumVariantLayout %t412, 0
  %t414 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t410, i8* %t413)
  store double %t414, double* %l20
  %t415 = load double, double* %l20
  %t416 = sitofp i64 0 to double
  %t417 = fcmp oge double %t415, %t416
  %t418 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t419 = load i8*, i8** %l1
  %t420 = load i8*, i8** %l2
  %t421 = load i8*, i8** %l3
  %t422 = load double, double* %l4
  %t423 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t424 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t425 = load double, double* %l7
  %t426 = load double, double* %l8
  %t427 = load i8*, i8** %l9
  %t428 = load double, double* %l10
  %t429 = load double, double* %l11
  %t430 = load i1, i1* %l12
  %t431 = load i1, i1* %l13
  %t432 = load double, double* %l14
  %t433 = load i8*, i8** %l16
  %t434 = load i8*, i8** %l17
  %t435 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t436 = load double, double* %l20
  br i1 %t417, label %then29, label %else30
then29:
  %t437 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s438 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1924917952, i32 0, i32 0
  %t439 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t440 = extractvalue %EnumLayoutVariantParse %t439, 1
  %t441 = extractvalue %NativeEnumVariantLayout %t440, 0
  %t442 = call i8* @sailfin_runtime_string_concat(i8* %s438, i8* %t441)
  %s443 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1783417286, i32 0, i32 0
  %t444 = call i8* @sailfin_runtime_string_concat(i8* %t442, i8* %s443)
  %t445 = load i8*, i8** %l3
  %t446 = call i8* @sailfin_runtime_string_concat(i8* %t444, i8* %t445)
  %t447 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t437, i8* %t446)
  store { i8**, i64 }* %t447, { i8**, i64 }** %l0
  %t448 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge31
else30:
  %t449 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t450 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t451 = extractvalue %EnumLayoutVariantParse %t450, 1
  %t452 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t449, %NativeEnumVariantLayout %t451)
  store { %NativeEnumVariantLayout*, i64 }* %t452, { %NativeEnumVariantLayout*, i64 }** %l6
  %t453 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge31
merge31:
  %t454 = phi { i8**, i64 }* [ %t448, %then29 ], [ %t418, %else30 ]
  %t455 = phi { %NativeEnumVariantLayout*, i64 }* [ %t424, %then29 ], [ %t453, %else30 ]
  store { i8**, i64 }* %t454, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t455, { %NativeEnumVariantLayout*, i64 }** %l6
  %t456 = load i1, i1* %l12
  %t457 = xor i1 %t456, 1
  %t458 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t459 = load i8*, i8** %l1
  %t460 = load i8*, i8** %l2
  %t461 = load i8*, i8** %l3
  %t462 = load double, double* %l4
  %t463 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t464 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t465 = load double, double* %l7
  %t466 = load double, double* %l8
  %t467 = load i8*, i8** %l9
  %t468 = load double, double* %l10
  %t469 = load double, double* %l11
  %t470 = load i1, i1* %l12
  %t471 = load i1, i1* %l13
  %t472 = load double, double* %l14
  %t473 = load i8*, i8** %l16
  %t474 = load i8*, i8** %l17
  %t475 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t476 = load double, double* %l20
  br i1 %t457, label %then32, label %merge33
then32:
  %t477 = load i1, i1* %l13
  %t478 = xor i1 %t477, 1
  %t479 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t480 = load i8*, i8** %l1
  %t481 = load i8*, i8** %l2
  %t482 = load i8*, i8** %l3
  %t483 = load double, double* %l4
  %t484 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t485 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t486 = load double, double* %l7
  %t487 = load double, double* %l8
  %t488 = load i8*, i8** %l9
  %t489 = load double, double* %l10
  %t490 = load double, double* %l11
  %t491 = load i1, i1* %l12
  %t492 = load i1, i1* %l13
  %t493 = load double, double* %l14
  %t494 = load i8*, i8** %l16
  %t495 = load i8*, i8** %l17
  %t496 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t497 = load double, double* %l20
  br i1 %t478, label %then34, label %merge35
then34:
  %t498 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s499 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t500 = load i8*, i8** %l3
  %t501 = call i8* @sailfin_runtime_string_concat(i8* %s499, i8* %t500)
  %s502 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.len48.h235936117, i32 0, i32 0
  %t503 = call i8* @sailfin_runtime_string_concat(i8* %t501, i8* %s502)
  %t504 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t498, i8* %t503)
  store { i8**, i64 }* %t504, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  %t505 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t506 = load i1, i1* %l13
  br label %merge35
merge35:
  %t507 = phi { i8**, i64 }* [ %t505, %then34 ], [ %t479, %then32 ]
  %t508 = phi i1 [ %t506, %then34 ], [ %t492, %then32 ]
  store { i8**, i64 }* %t507, { i8**, i64 }** %l0
  store i1 %t508, i1* %l13
  %t509 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t510 = load i1, i1* %l13
  br label %merge33
merge33:
  %t511 = phi { i8**, i64 }* [ %t509, %merge35 ], [ %t458, %merge31 ]
  %t512 = phi i1 [ %t510, %merge35 ], [ %t471, %merge31 ]
  store { i8**, i64 }* %t511, { i8**, i64 }** %l0
  store i1 %t512, i1* %l13
  %t513 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t514 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t515 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t516 = load i1, i1* %l13
  br label %merge28
merge28:
  %t517 = phi { i8**, i64 }* [ %t513, %merge33 ], [ %t392, %then25 ]
  %t518 = phi { %NativeEnumVariantLayout*, i64 }* [ %t514, %merge33 ], [ %t398, %then25 ]
  %t519 = phi { i8**, i64 }* [ %t515, %merge33 ], [ %t392, %then25 ]
  %t520 = phi i1 [ %t516, %merge33 ], [ %t405, %then25 ]
  store { i8**, i64 }* %t517, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t518, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t519, { i8**, i64 }** %l0
  store i1 %t520, i1* %l13
  %t521 = load double, double* %l14
  %t522 = sitofp i64 1 to double
  %t523 = fadd double %t521, %t522
  store double %t523, double* %l14
  br label %loop.latch6
merge26:
  %t524 = load i8*, i8** %l17
  %s525 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1521657554, i32 0, i32 0
  %t526 = call i1 @starts_with(i8* %t524, i8* %s525)
  %t527 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t528 = load i8*, i8** %l1
  %t529 = load i8*, i8** %l2
  %t530 = load i8*, i8** %l3
  %t531 = load double, double* %l4
  %t532 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t533 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t534 = load double, double* %l7
  %t535 = load double, double* %l8
  %t536 = load i8*, i8** %l9
  %t537 = load double, double* %l10
  %t538 = load double, double* %l11
  %t539 = load i1, i1* %l12
  %t540 = load i1, i1* %l13
  %t541 = load double, double* %l14
  %t542 = load i8*, i8** %l16
  %t543 = load i8*, i8** %l17
  br i1 %t526, label %then36, label %merge37
then36:
  %t544 = load i8*, i8** %l17
  %s545 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1521657554, i32 0, i32 0
  %t546 = call i8* @strip_prefix(i8* %t544, i8* %s545)
  %t547 = load i8*, i8** %l3
  %t548 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t546, i8* %t547)
  store %EnumLayoutPayloadParse %t548, %EnumLayoutPayloadParse* %l21
  %t549 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t550 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t551 = extractvalue %EnumLayoutPayloadParse %t550, 3
  %t552 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t549, { i8**, i64 }* %t551)
  store { i8**, i64 }* %t552, { i8**, i64 }** %l0
  %t553 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t554 = extractvalue %EnumLayoutPayloadParse %t553, 0
  %t555 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t556 = load i8*, i8** %l1
  %t557 = load i8*, i8** %l2
  %t558 = load i8*, i8** %l3
  %t559 = load double, double* %l4
  %t560 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t561 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t562 = load double, double* %l7
  %t563 = load double, double* %l8
  %t564 = load i8*, i8** %l9
  %t565 = load double, double* %l10
  %t566 = load double, double* %l11
  %t567 = load i1, i1* %l12
  %t568 = load i1, i1* %l13
  %t569 = load double, double* %l14
  %t570 = load i8*, i8** %l16
  %t571 = load i8*, i8** %l17
  %t572 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  br i1 %t554, label %then38, label %merge39
then38:
  %t573 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t574 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t575 = extractvalue %EnumLayoutPayloadParse %t574, 1
  %t576 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t573, i8* %t575)
  store double %t576, double* %l22
  %t577 = load double, double* %l22
  %t578 = sitofp i64 0 to double
  %t579 = fcmp olt double %t577, %t578
  %t580 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t581 = load i8*, i8** %l1
  %t582 = load i8*, i8** %l2
  %t583 = load i8*, i8** %l3
  %t584 = load double, double* %l4
  %t585 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t586 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t587 = load double, double* %l7
  %t588 = load double, double* %l8
  %t589 = load i8*, i8** %l9
  %t590 = load double, double* %l10
  %t591 = load double, double* %l11
  %t592 = load i1, i1* %l12
  %t593 = load i1, i1* %l13
  %t594 = load double, double* %l14
  %t595 = load i8*, i8** %l16
  %t596 = load i8*, i8** %l17
  %t597 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t598 = load double, double* %l22
  br i1 %t579, label %then40, label %else41
then40:
  %t599 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s600 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t601 = load i8*, i8** %l3
  %t602 = call i8* @sailfin_runtime_string_concat(i8* %s600, i8* %t601)
  %s603 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.len44.h1623843, i32 0, i32 0
  %t604 = call i8* @sailfin_runtime_string_concat(i8* %t602, i8* %s603)
  %t605 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t606 = extractvalue %EnumLayoutPayloadParse %t605, 1
  %t607 = call i8* @sailfin_runtime_string_concat(i8* %t604, i8* %t606)
  %t608 = load i8, i8* %t607
  %t609 = add i8 %t608, 96
  %t610 = alloca [2 x i8], align 1
  %t611 = getelementptr [2 x i8], [2 x i8]* %t610, i32 0, i32 0
  store i8 %t609, i8* %t611
  %t612 = getelementptr [2 x i8], [2 x i8]* %t610, i32 0, i32 1
  store i8 0, i8* %t612
  %t613 = getelementptr [2 x i8], [2 x i8]* %t610, i32 0, i32 0
  %t614 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t599, i8* %t613)
  store { i8**, i64 }* %t614, { i8**, i64 }** %l0
  %t615 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge42
else41:
  %t616 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t617 = load double, double* %l22
  %t618 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t619 = extractvalue %EnumLayoutPayloadParse %t618, 2
  %t620 = call { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %t616, double %t617, %NativeStructLayoutField %t619)
  store { %NativeEnumVariantLayout*, i64 }* %t620, { %NativeEnumVariantLayout*, i64 }** %l6
  %t621 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge42
merge42:
  %t622 = phi { i8**, i64 }* [ %t615, %then40 ], [ %t580, %else41 ]
  %t623 = phi { %NativeEnumVariantLayout*, i64 }* [ %t586, %then40 ], [ %t621, %else41 ]
  store { i8**, i64 }* %t622, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t623, { %NativeEnumVariantLayout*, i64 }** %l6
  %t624 = load i1, i1* %l12
  %t625 = xor i1 %t624, 1
  %t626 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t627 = load i8*, i8** %l1
  %t628 = load i8*, i8** %l2
  %t629 = load i8*, i8** %l3
  %t630 = load double, double* %l4
  %t631 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t632 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t633 = load double, double* %l7
  %t634 = load double, double* %l8
  %t635 = load i8*, i8** %l9
  %t636 = load double, double* %l10
  %t637 = load double, double* %l11
  %t638 = load i1, i1* %l12
  %t639 = load i1, i1* %l13
  %t640 = load double, double* %l14
  %t641 = load i8*, i8** %l16
  %t642 = load i8*, i8** %l17
  %t643 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t644 = load double, double* %l22
  br i1 %t625, label %then43, label %merge44
then43:
  %t645 = load i1, i1* %l13
  %t646 = xor i1 %t645, 1
  %t647 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t648 = load i8*, i8** %l1
  %t649 = load i8*, i8** %l2
  %t650 = load i8*, i8** %l3
  %t651 = load double, double* %l4
  %t652 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t653 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t654 = load double, double* %l7
  %t655 = load double, double* %l8
  %t656 = load i8*, i8** %l9
  %t657 = load double, double* %l10
  %t658 = load double, double* %l11
  %t659 = load i1, i1* %l12
  %t660 = load i1, i1* %l13
  %t661 = load double, double* %l14
  %t662 = load i8*, i8** %l16
  %t663 = load i8*, i8** %l17
  %t664 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t665 = load double, double* %l22
  br i1 %t646, label %then45, label %merge46
then45:
  %t666 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s667 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t668 = load i8*, i8** %l3
  %t669 = call i8* @sailfin_runtime_string_concat(i8* %s667, i8* %t668)
  %s670 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.len48.h807033739, i32 0, i32 0
  %t671 = call i8* @sailfin_runtime_string_concat(i8* %t669, i8* %s670)
  %t672 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t666, i8* %t671)
  store { i8**, i64 }* %t672, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  %t673 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t674 = load i1, i1* %l13
  br label %merge46
merge46:
  %t675 = phi { i8**, i64 }* [ %t673, %then45 ], [ %t647, %then43 ]
  %t676 = phi i1 [ %t674, %then45 ], [ %t660, %then43 ]
  store { i8**, i64 }* %t675, { i8**, i64 }** %l0
  store i1 %t676, i1* %l13
  %t677 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t678 = load i1, i1* %l13
  br label %merge44
merge44:
  %t679 = phi { i8**, i64 }* [ %t677, %merge46 ], [ %t626, %merge42 ]
  %t680 = phi i1 [ %t678, %merge46 ], [ %t639, %merge42 ]
  store { i8**, i64 }* %t679, { i8**, i64 }** %l0
  store i1 %t680, i1* %l13
  %t681 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t682 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t683 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t684 = load i1, i1* %l13
  br label %merge39
merge39:
  %t685 = phi { i8**, i64 }* [ %t681, %merge44 ], [ %t555, %then36 ]
  %t686 = phi { %NativeEnumVariantLayout*, i64 }* [ %t682, %merge44 ], [ %t561, %then36 ]
  %t687 = phi { i8**, i64 }* [ %t683, %merge44 ], [ %t555, %then36 ]
  %t688 = phi i1 [ %t684, %merge44 ], [ %t568, %then36 ]
  store { i8**, i64 }* %t685, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t686, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t687, { i8**, i64 }** %l0
  store i1 %t688, i1* %l13
  %t689 = load double, double* %l14
  %t690 = sitofp i64 1 to double
  %t691 = fadd double %t689, %t690
  store double %t691, double* %l14
  br label %loop.latch6
merge37:
  %t692 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s693 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.len35.h2058816325, i32 0, i32 0
  %t694 = load i8*, i8** %l16
  %t695 = call i8* @sailfin_runtime_string_concat(i8* %s693, i8* %t694)
  %t696 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t692, i8* %t695)
  store { i8**, i64 }* %t696, { i8**, i64 }** %l0
  %t697 = load double, double* %l14
  %t698 = sitofp i64 1 to double
  %t699 = fadd double %t697, %t698
  store double %t699, double* %l14
  br label %loop.latch6
merge17:
  %t700 = load i8*, i8** %l16
  %s701 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h562875475, i32 0, i32 0
  %t702 = icmp eq i8* %t700, %s701
  %t703 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t704 = load i8*, i8** %l1
  %t705 = load i8*, i8** %l2
  %t706 = load i8*, i8** %l3
  %t707 = load double, double* %l4
  %t708 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t709 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t710 = load double, double* %l7
  %t711 = load double, double* %l8
  %t712 = load i8*, i8** %l9
  %t713 = load double, double* %l10
  %t714 = load double, double* %l11
  %t715 = load i1, i1* %l12
  %t716 = load i1, i1* %l13
  %t717 = load double, double* %l14
  %t718 = load i8*, i8** %l16
  br i1 %t702, label %then47, label %merge48
then47:
  %t719 = load double, double* %l14
  %t720 = sitofp i64 1 to double
  %t721 = fadd double %t719, %t720
  store double %t721, double* %l14
  br label %afterloop7
merge48:
  %t722 = load i8*, i8** %l16
  %s723 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1311191977, i32 0, i32 0
  %t724 = call i1 @starts_with(i8* %t722, i8* %s723)
  %t725 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t726 = load i8*, i8** %l1
  %t727 = load i8*, i8** %l2
  %t728 = load i8*, i8** %l3
  %t729 = load double, double* %l4
  %t730 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t731 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t732 = load double, double* %l7
  %t733 = load double, double* %l8
  %t734 = load i8*, i8** %l9
  %t735 = load double, double* %l10
  %t736 = load double, double* %l11
  %t737 = load i1, i1* %l12
  %t738 = load i1, i1* %l13
  %t739 = load double, double* %l14
  %t740 = load i8*, i8** %l16
  br i1 %t724, label %then49, label %merge50
then49:
  %t741 = load i8*, i8** %l16
  %s742 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1311191977, i32 0, i32 0
  %t743 = call i8* @strip_prefix(i8* %t741, i8* %s742)
  %t744 = call %NativeEnumVariant* @parse_enum_variant_line(i8* %t743)
  store %NativeEnumVariant* %t744, %NativeEnumVariant** %l23
  %t745 = load %NativeEnumVariant*, %NativeEnumVariant** %l23
  %t746 = icmp eq %NativeEnumVariant* %t745, null
  %t747 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t748 = load i8*, i8** %l1
  %t749 = load i8*, i8** %l2
  %t750 = load i8*, i8** %l3
  %t751 = load double, double* %l4
  %t752 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t753 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t754 = load double, double* %l7
  %t755 = load double, double* %l8
  %t756 = load i8*, i8** %l9
  %t757 = load double, double* %l10
  %t758 = load double, double* %l11
  %t759 = load i1, i1* %l12
  %t760 = load i1, i1* %l13
  %t761 = load double, double* %l14
  %t762 = load i8*, i8** %l16
  %t763 = load %NativeEnumVariant*, %NativeEnumVariant** %l23
  br i1 %t746, label %then51, label %else52
then51:
  %t764 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s765 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.len30.h829706524, i32 0, i32 0
  %t766 = load i8*, i8** %l16
  %t767 = call i8* @sailfin_runtime_string_concat(i8* %s765, i8* %t766)
  %t768 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t764, i8* %t767)
  store { i8**, i64 }* %t768, { i8**, i64 }** %l0
  %t769 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge53
else52:
  %t770 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t771 = load %NativeEnumVariant*, %NativeEnumVariant** %l23
  %t772 = load %NativeEnumVariant, %NativeEnumVariant* %t771
  %t773 = call { %NativeEnumVariant*, i64 }* @append_enum_variant({ %NativeEnumVariant*, i64 }* %t770, %NativeEnumVariant %t772)
  store { %NativeEnumVariant*, i64 }* %t773, { %NativeEnumVariant*, i64 }** %l5
  %t774 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  br label %merge53
merge53:
  %t775 = phi { i8**, i64 }* [ %t769, %then51 ], [ %t747, %else52 ]
  %t776 = phi { %NativeEnumVariant*, i64 }* [ %t752, %then51 ], [ %t774, %else52 ]
  store { i8**, i64 }* %t775, { i8**, i64 }** %l0
  store { %NativeEnumVariant*, i64 }* %t776, { %NativeEnumVariant*, i64 }** %l5
  %t777 = load double, double* %l14
  %t778 = sitofp i64 1 to double
  %t779 = fadd double %t777, %t778
  store double %t779, double* %l14
  br label %loop.latch6
merge50:
  %t780 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s781 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h1471254674, i32 0, i32 0
  %t782 = load i8*, i8** %l16
  %t783 = call i8* @sailfin_runtime_string_concat(i8* %s781, i8* %t782)
  %t784 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t780, i8* %t783)
  store { i8**, i64 }* %t784, { i8**, i64 }** %l0
  %t785 = load double, double* %l14
  %t786 = sitofp i64 1 to double
  %t787 = fadd double %t785, %t786
  store double %t787, double* %l14
  br label %loop.latch6
loop.latch6:
  %t788 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t789 = load double, double* %l14
  %t790 = load double, double* %l7
  %t791 = load double, double* %l8
  %t792 = load i8*, i8** %l9
  %t793 = load double, double* %l10
  %t794 = load double, double* %l11
  %t795 = load i1, i1* %l12
  %t796 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t797 = load i1, i1* %l13
  %t798 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  br label %loop.header4
afterloop7:
  %t810 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t811 = load double, double* %l14
  %t812 = load double, double* %l7
  %t813 = load double, double* %l8
  %t814 = load i8*, i8** %l9
  %t815 = load double, double* %l10
  %t816 = load double, double* %l11
  %t817 = load i1, i1* %l12
  %t818 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t819 = load i1, i1* %l13
  %t820 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t821 = bitcast i8* null to %NativeEnumLayout*
  store %NativeEnumLayout* %t821, %NativeEnumLayout** %l24
  %t822 = load i1, i1* %l12
  %t823 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t824 = load i8*, i8** %l1
  %t825 = load i8*, i8** %l2
  %t826 = load i8*, i8** %l3
  %t827 = load double, double* %l4
  %t828 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t829 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t830 = load double, double* %l7
  %t831 = load double, double* %l8
  %t832 = load i8*, i8** %l9
  %t833 = load double, double* %l10
  %t834 = load double, double* %l11
  %t835 = load i1, i1* %l12
  %t836 = load i1, i1* %l13
  %t837 = load double, double* %l14
  %t838 = load %NativeEnumLayout*, %NativeEnumLayout** %l24
  br i1 %t822, label %then54, label %merge55
then54:
  %t839 = load double, double* %l7
  %t840 = insertvalue %NativeEnumLayout undef, double %t839, 0
  %t841 = load double, double* %l8
  %t842 = insertvalue %NativeEnumLayout %t840, double %t841, 1
  %t843 = load i8*, i8** %l9
  %t844 = insertvalue %NativeEnumLayout %t842, i8* %t843, 2
  %t845 = load double, double* %l10
  %t846 = insertvalue %NativeEnumLayout %t844, double %t845, 3
  %t847 = load double, double* %l11
  %t848 = insertvalue %NativeEnumLayout %t846, double %t847, 4
  %t849 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t850 = bitcast { %NativeEnumVariantLayout*, i64 }* %t849 to { %NativeEnumVariantLayout**, i64 }*
  %t851 = insertvalue %NativeEnumLayout %t848, { %NativeEnumVariantLayout**, i64 }* %t850, 5
  %t852 = alloca %NativeEnumLayout
  store %NativeEnumLayout %t851, %NativeEnumLayout* %t852
  store %NativeEnumLayout* %t852, %NativeEnumLayout** %l24
  %t853 = load %NativeEnumLayout*, %NativeEnumLayout** %l24
  br label %merge55
merge55:
  %t854 = phi %NativeEnumLayout* [ %t853, %then54 ], [ %t838, %afterloop7 ]
  store %NativeEnumLayout* %t854, %NativeEnumLayout** %l24
  %t855 = load i8*, i8** %l3
  %t856 = insertvalue %NativeEnum undef, i8* %t855, 0
  %t857 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t858 = bitcast { %NativeEnumVariant*, i64 }* %t857 to { %NativeEnumVariant**, i64 }*
  %t859 = insertvalue %NativeEnum %t856, { %NativeEnumVariant**, i64 }* %t858, 1
  %t860 = load %NativeEnumLayout*, %NativeEnumLayout** %l24
  %t861 = insertvalue %NativeEnum %t859, %NativeEnumLayout* %t860, 2
  %t862 = alloca %NativeEnum
  store %NativeEnum %t861, %NativeEnum* %t862
  %t863 = insertvalue %EnumParseResult undef, %NativeEnum* %t862, 0
  %t864 = load double, double* %l14
  %t865 = insertvalue %EnumParseResult %t863, double %t864, 1
  %t866 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t867 = insertvalue %EnumParseResult %t865, { i8**, i64 }* %t866, 2
  ret %EnumParseResult %t867
}

define %NativeEnumVariant* @parse_enum_variant_line(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca { %NativeEnumVariantField*, i64 }*
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca %NativeEnumVariantField*
  %t0 = call i8* @trim_text(i8* %text)
  %t1 = call i8* @trim_trailing_delimiters(i8* %t0)
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i64 @sailfin_runtime_string_length(i8* %t2)
  %t4 = icmp eq i64 %t3, 0
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then0, label %merge1
then0:
  %t6 = bitcast i8* null to %NativeEnumVariant*
  ret %NativeEnumVariant* %t6
merge1:
  %t7 = load i8*, i8** %l0
  %t8 = alloca [2 x i8], align 1
  %t9 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  store i8 123, i8* %t9
  %t10 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 1
  store i8 0, i8* %t10
  %t11 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  %t12 = call double @index_of(i8* %t7, i8* %t11)
  store double %t12, double* %l1
  %t13 = load double, double* %l1
  %t14 = sitofp i64 0 to double
  %t15 = fcmp olt double %t13, %t14
  %t16 = load i8*, i8** %l0
  %t17 = load double, double* %l1
  br i1 %t15, label %then2, label %merge3
then2:
  %t18 = load i8*, i8** %l0
  %t19 = call i8* @strip_generics(i8* %t18)
  %t20 = insertvalue %NativeEnumVariant undef, i8* %t19, 0
  %t21 = alloca [0 x %NativeEnumVariantField*]
  %t22 = getelementptr [0 x %NativeEnumVariantField*], [0 x %NativeEnumVariantField*]* %t21, i32 0, i32 0
  %t23 = alloca { %NativeEnumVariantField**, i64 }
  %t24 = getelementptr { %NativeEnumVariantField**, i64 }, { %NativeEnumVariantField**, i64 }* %t23, i32 0, i32 0
  store %NativeEnumVariantField** %t22, %NativeEnumVariantField*** %t24
  %t25 = getelementptr { %NativeEnumVariantField**, i64 }, { %NativeEnumVariantField**, i64 }* %t23, i32 0, i32 1
  store i64 0, i64* %t25
  %t26 = insertvalue %NativeEnumVariant %t20, { %NativeEnumVariantField**, i64 }* %t23, 1
  %t27 = alloca %NativeEnumVariant
  store %NativeEnumVariant %t26, %NativeEnumVariant* %t27
  ret %NativeEnumVariant* %t27
merge3:
  %t28 = load i8*, i8** %l0
  %t29 = alloca [2 x i8], align 1
  %t30 = getelementptr [2 x i8], [2 x i8]* %t29, i32 0, i32 0
  store i8 125, i8* %t30
  %t31 = getelementptr [2 x i8], [2 x i8]* %t29, i32 0, i32 1
  store i8 0, i8* %t31
  %t32 = getelementptr [2 x i8], [2 x i8]* %t29, i32 0, i32 0
  %t33 = call double @last_index_of(i8* %t28, i8* %t32)
  store double %t33, double* %l2
  %t35 = load double, double* %l2
  %t36 = sitofp i64 0 to double
  %t37 = fcmp olt double %t35, %t36
  br label %logical_or_entry_34

logical_or_entry_34:
  br i1 %t37, label %logical_or_merge_34, label %logical_or_right_34

logical_or_right_34:
  %t38 = load double, double* %l2
  %t39 = load double, double* %l1
  %t40 = fcmp ole double %t38, %t39
  br label %logical_or_right_end_34

logical_or_right_end_34:
  br label %logical_or_merge_34

logical_or_merge_34:
  %t41 = phi i1 [ true, %logical_or_entry_34 ], [ %t40, %logical_or_right_end_34 ]
  %t42 = load i8*, i8** %l0
  %t43 = load double, double* %l1
  %t44 = load double, double* %l2
  br i1 %t41, label %then4, label %merge5
then4:
  %t45 = bitcast i8* null to %NativeEnumVariant*
  ret %NativeEnumVariant* %t45
merge5:
  %t46 = load i8*, i8** %l0
  %t47 = load double, double* %l1
  %t48 = fptosi double %t47 to i64
  %t49 = call i8* @sailfin_runtime_substring(i8* %t46, i64 0, i64 %t48)
  %t50 = call i8* @trim_text(i8* %t49)
  %t51 = call i8* @strip_generics(i8* %t50)
  store i8* %t51, i8** %l3
  %t52 = load i8*, i8** %l3
  %t53 = call i64 @sailfin_runtime_string_length(i8* %t52)
  %t54 = icmp eq i64 %t53, 0
  %t55 = load i8*, i8** %l0
  %t56 = load double, double* %l1
  %t57 = load double, double* %l2
  %t58 = load i8*, i8** %l3
  br i1 %t54, label %then6, label %merge7
then6:
  %t59 = bitcast i8* null to %NativeEnumVariant*
  ret %NativeEnumVariant* %t59
merge7:
  %t60 = load i8*, i8** %l0
  %t61 = load double, double* %l1
  %t62 = sitofp i64 1 to double
  %t63 = fadd double %t61, %t62
  %t64 = load double, double* %l2
  %t65 = fptosi double %t63 to i64
  %t66 = fptosi double %t64 to i64
  %t67 = call i8* @sailfin_runtime_substring(i8* %t60, i64 %t65, i64 %t66)
  store i8* %t67, i8** %l4
  %t68 = load i8*, i8** %l4
  %t69 = call { i8**, i64 }* @split_enum_field_entries(i8* %t68)
  store { i8**, i64 }* %t69, { i8**, i64 }** %l5
  %t70 = alloca [0 x %NativeEnumVariantField]
  %t71 = getelementptr [0 x %NativeEnumVariantField], [0 x %NativeEnumVariantField]* %t70, i32 0, i32 0
  %t72 = alloca { %NativeEnumVariantField*, i64 }
  %t73 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %t72, i32 0, i32 0
  store %NativeEnumVariantField* %t71, %NativeEnumVariantField** %t73
  %t74 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %t72, i32 0, i32 1
  store i64 0, i64* %t74
  store { %NativeEnumVariantField*, i64 }* %t72, { %NativeEnumVariantField*, i64 }** %l6
  %t75 = sitofp i64 0 to double
  store double %t75, double* %l7
  %t76 = load i8*, i8** %l0
  %t77 = load double, double* %l1
  %t78 = load double, double* %l2
  %t79 = load i8*, i8** %l3
  %t80 = load i8*, i8** %l4
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t82 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t83 = load double, double* %l7
  br label %loop.header8
loop.header8:
  %t148 = phi double [ %t83, %merge7 ], [ %t146, %loop.latch10 ]
  %t149 = phi { %NativeEnumVariantField*, i64 }* [ %t82, %merge7 ], [ %t147, %loop.latch10 ]
  store double %t148, double* %l7
  store { %NativeEnumVariantField*, i64 }* %t149, { %NativeEnumVariantField*, i64 }** %l6
  br label %loop.body9
loop.body9:
  %t84 = load double, double* %l7
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t86 = load { i8**, i64 }, { i8**, i64 }* %t85
  %t87 = extractvalue { i8**, i64 } %t86, 1
  %t88 = sitofp i64 %t87 to double
  %t89 = fcmp oge double %t84, %t88
  %t90 = load i8*, i8** %l0
  %t91 = load double, double* %l1
  %t92 = load double, double* %l2
  %t93 = load i8*, i8** %l3
  %t94 = load i8*, i8** %l4
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t96 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t97 = load double, double* %l7
  br i1 %t89, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t99 = load double, double* %l7
  %t100 = fptosi double %t99 to i64
  %t101 = load { i8**, i64 }, { i8**, i64 }* %t98
  %t102 = extractvalue { i8**, i64 } %t101, 0
  %t103 = extractvalue { i8**, i64 } %t101, 1
  %t104 = icmp uge i64 %t100, %t103
  ; bounds check: %t104 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t100, i64 %t103)
  %t105 = getelementptr i8*, i8** %t102, i64 %t100
  %t106 = load i8*, i8** %t105
  %t107 = call i8* @trim_text(i8* %t106)
  %t108 = call i8* @trim_trailing_delimiters(i8* %t107)
  store i8* %t108, i8** %l8
  %t109 = load i8*, i8** %l8
  %t110 = call i64 @sailfin_runtime_string_length(i8* %t109)
  %t111 = icmp eq i64 %t110, 0
  %t112 = load i8*, i8** %l0
  %t113 = load double, double* %l1
  %t114 = load double, double* %l2
  %t115 = load i8*, i8** %l3
  %t116 = load i8*, i8** %l4
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t118 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t119 = load double, double* %l7
  %t120 = load i8*, i8** %l8
  br i1 %t111, label %then14, label %merge15
then14:
  %t121 = load double, double* %l7
  %t122 = sitofp i64 1 to double
  %t123 = fadd double %t121, %t122
  store double %t123, double* %l7
  br label %loop.latch10
merge15:
  %t124 = load i8*, i8** %l8
  %t125 = call %NativeEnumVariantField* @parse_enum_variant_field(i8* %t124)
  store %NativeEnumVariantField* %t125, %NativeEnumVariantField** %l9
  %t126 = load %NativeEnumVariantField*, %NativeEnumVariantField** %l9
  %t127 = icmp eq %NativeEnumVariantField* %t126, null
  %t128 = load i8*, i8** %l0
  %t129 = load double, double* %l1
  %t130 = load double, double* %l2
  %t131 = load i8*, i8** %l3
  %t132 = load i8*, i8** %l4
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t134 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t135 = load double, double* %l7
  %t136 = load i8*, i8** %l8
  %t137 = load %NativeEnumVariantField*, %NativeEnumVariantField** %l9
  br i1 %t127, label %then16, label %merge17
then16:
  %t138 = bitcast i8* null to %NativeEnumVariant*
  ret %NativeEnumVariant* %t138
merge17:
  %t139 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t140 = load %NativeEnumVariantField*, %NativeEnumVariantField** %l9
  %t141 = load %NativeEnumVariantField, %NativeEnumVariantField* %t140
  %t142 = call { %NativeEnumVariantField*, i64 }* @append_enum_variant_field({ %NativeEnumVariantField*, i64 }* %t139, %NativeEnumVariantField %t141)
  store { %NativeEnumVariantField*, i64 }* %t142, { %NativeEnumVariantField*, i64 }** %l6
  %t143 = load double, double* %l7
  %t144 = sitofp i64 1 to double
  %t145 = fadd double %t143, %t144
  store double %t145, double* %l7
  br label %loop.latch10
loop.latch10:
  %t146 = load double, double* %l7
  %t147 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  br label %loop.header8
afterloop11:
  %t150 = load double, double* %l7
  %t151 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t152 = load i8*, i8** %l3
  %t153 = insertvalue %NativeEnumVariant undef, i8* %t152, 0
  %t154 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t155 = bitcast { %NativeEnumVariantField*, i64 }* %t154 to { %NativeEnumVariantField**, i64 }*
  %t156 = insertvalue %NativeEnumVariant %t153, { %NativeEnumVariantField**, i64 }* %t155, 1
  %t157 = alloca %NativeEnumVariant
  store %NativeEnumVariant %t156, %NativeEnumVariant* %t157
  ret %NativeEnumVariant* %t157
}

define { i8**, i64 }* @split_enum_field_entries(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8
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
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t9 = load i8*, i8** %l1
  %t10 = load double, double* %l2
  %t11 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t111 = phi double [ %t10, %entry ], [ %t107, %loop.latch2 ]
  %t112 = phi { i8**, i64 }* [ %t8, %entry ], [ %t108, %loop.latch2 ]
  %t113 = phi i8* [ %t9, %entry ], [ %t109, %loop.latch2 ]
  %t114 = phi double [ %t11, %entry ], [ %t110, %loop.latch2 ]
  store double %t111, double* %l2
  store { i8**, i64 }* %t112, { i8**, i64 }** %l0
  store i8* %t113, i8** %l1
  store double %t114, double* %l3
  br label %loop.body1
loop.body1:
  %t12 = load double, double* %l3
  %t13 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t14 = sitofp i64 %t13 to double
  %t15 = fcmp oge double %t12, %t14
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load i8*, i8** %l1
  %t18 = load double, double* %l2
  %t19 = load double, double* %l3
  br i1 %t15, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t20 = load double, double* %l3
  %t21 = fptosi double %t20 to i64
  %t22 = getelementptr i8, i8* %text, i64 %t21
  %t23 = load i8, i8* %t22
  store i8 %t23, i8* %l4
  %t25 = load i8, i8* %l4
  %t26 = icmp eq i8 %t25, 123
  br label %logical_or_entry_24

logical_or_entry_24:
  br i1 %t26, label %logical_or_merge_24, label %logical_or_right_24

logical_or_right_24:
  %t28 = load i8, i8* %l4
  %t29 = icmp eq i8 %t28, 91
  br label %logical_or_entry_27

logical_or_entry_27:
  br i1 %t29, label %logical_or_merge_27, label %logical_or_right_27

logical_or_right_27:
  %t30 = load i8, i8* %l4
  %t31 = icmp eq i8 %t30, 40
  br label %logical_or_right_end_27

logical_or_right_end_27:
  br label %logical_or_merge_27

logical_or_merge_27:
  %t32 = phi i1 [ true, %logical_or_entry_27 ], [ %t31, %logical_or_right_end_27 ]
  br label %logical_or_right_end_24

logical_or_right_end_24:
  br label %logical_or_merge_24

logical_or_merge_24:
  %t33 = phi i1 [ true, %logical_or_entry_24 ], [ %t32, %logical_or_right_end_24 ]
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load i8*, i8** %l1
  %t36 = load double, double* %l2
  %t37 = load double, double* %l3
  %t38 = load i8, i8* %l4
  br i1 %t33, label %then6, label %else7
then6:
  %t39 = load double, double* %l2
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l2
  %t42 = load double, double* %l2
  br label %merge8
else7:
  %t44 = load i8, i8* %l4
  %t45 = icmp eq i8 %t44, 125
  br label %logical_or_entry_43

logical_or_entry_43:
  br i1 %t45, label %logical_or_merge_43, label %logical_or_right_43

logical_or_right_43:
  %t47 = load i8, i8* %l4
  %t48 = icmp eq i8 %t47, 93
  br label %logical_or_entry_46

logical_or_entry_46:
  br i1 %t48, label %logical_or_merge_46, label %logical_or_right_46

logical_or_right_46:
  %t49 = load i8, i8* %l4
  %t50 = icmp eq i8 %t49, 41
  br label %logical_or_right_end_46

logical_or_right_end_46:
  br label %logical_or_merge_46

logical_or_merge_46:
  %t51 = phi i1 [ true, %logical_or_entry_46 ], [ %t50, %logical_or_right_end_46 ]
  br label %logical_or_right_end_43

logical_or_right_end_43:
  br label %logical_or_merge_43

logical_or_merge_43:
  %t52 = phi i1 [ true, %logical_or_entry_43 ], [ %t51, %logical_or_right_end_43 ]
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load i8*, i8** %l1
  %t55 = load double, double* %l2
  %t56 = load double, double* %l3
  %t57 = load i8, i8* %l4
  br i1 %t52, label %then9, label %merge10
then9:
  %t58 = load double, double* %l2
  %t59 = sitofp i64 0 to double
  %t60 = fcmp ogt double %t58, %t59
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t62 = load i8*, i8** %l1
  %t63 = load double, double* %l2
  %t64 = load double, double* %l3
  %t65 = load i8, i8* %l4
  br i1 %t60, label %then11, label %merge12
then11:
  %t66 = load double, double* %l2
  %t67 = sitofp i64 1 to double
  %t68 = fsub double %t66, %t67
  store double %t68, double* %l2
  %t69 = load double, double* %l2
  br label %merge12
merge12:
  %t70 = phi double [ %t69, %then11 ], [ %t63, %then9 ]
  store double %t70, double* %l2
  %t71 = load double, double* %l2
  br label %merge10
merge10:
  %t72 = phi double [ %t71, %merge12 ], [ %t55, %logical_or_merge_43 ]
  store double %t72, double* %l2
  %t73 = load double, double* %l2
  br label %merge8
merge8:
  %t74 = phi double [ %t42, %then6 ], [ %t73, %merge10 ]
  store double %t74, double* %l2
  %t76 = load i8, i8* %l4
  %t77 = icmp eq i8 %t76, 59
  br label %logical_and_entry_75

logical_and_entry_75:
  br i1 %t77, label %logical_and_right_75, label %logical_and_merge_75

logical_and_right_75:
  %t78 = load double, double* %l2
  %t79 = sitofp i64 0 to double
  %t80 = fcmp oeq double %t78, %t79
  br label %logical_and_right_end_75

logical_and_right_end_75:
  br label %logical_and_merge_75

logical_and_merge_75:
  %t81 = phi i1 [ false, %logical_and_entry_75 ], [ %t80, %logical_and_right_end_75 ]
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t83 = load i8*, i8** %l1
  %t84 = load double, double* %l2
  %t85 = load double, double* %l3
  %t86 = load i8, i8* %l4
  br i1 %t81, label %then13, label %else14
then13:
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t88 = load i8*, i8** %l1
  %t89 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t87, i8* %t88)
  store { i8**, i64 }* %t89, { i8**, i64 }** %l0
  %s90 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s90, i8** %l1
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t92 = load i8*, i8** %l1
  br label %merge15
else14:
  %t93 = load i8*, i8** %l1
  %t94 = load i8, i8* %l4
  %t95 = load i8, i8* %t93
  %t96 = add i8 %t95, %t94
  %t97 = alloca [2 x i8], align 1
  %t98 = getelementptr [2 x i8], [2 x i8]* %t97, i32 0, i32 0
  store i8 %t96, i8* %t98
  %t99 = getelementptr [2 x i8], [2 x i8]* %t97, i32 0, i32 1
  store i8 0, i8* %t99
  %t100 = getelementptr [2 x i8], [2 x i8]* %t97, i32 0, i32 0
  store i8* %t100, i8** %l1
  %t101 = load i8*, i8** %l1
  br label %merge15
merge15:
  %t102 = phi { i8**, i64 }* [ %t91, %then13 ], [ %t82, %else14 ]
  %t103 = phi i8* [ %t92, %then13 ], [ %t101, %else14 ]
  store { i8**, i64 }* %t102, { i8**, i64 }** %l0
  store i8* %t103, i8** %l1
  %t104 = load double, double* %l3
  %t105 = sitofp i64 1 to double
  %t106 = fadd double %t104, %t105
  store double %t106, double* %l3
  br label %loop.latch2
loop.latch2:
  %t107 = load double, double* %l2
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t109 = load i8*, i8** %l1
  %t110 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t115 = load double, double* %l2
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t117 = load i8*, i8** %l1
  %t118 = load double, double* %l3
  %t119 = load i8*, i8** %l1
  %t120 = call i64 @sailfin_runtime_string_length(i8* %t119)
  %t121 = icmp sgt i64 %t120, 0
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t123 = load i8*, i8** %l1
  %t124 = load double, double* %l2
  %t125 = load double, double* %l3
  br i1 %t121, label %then16, label %merge17
then16:
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t127 = load i8*, i8** %l1
  %t128 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t126, i8* %t127)
  store { i8**, i64 }* %t128, { i8**, i64 }** %l0
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge17
merge17:
  %t130 = phi { i8**, i64 }* [ %t129, %then16 ], [ %t122, %afterloop3 ]
  store { i8**, i64 }* %t130, { i8**, i64 }** %l0
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t131
}

define %NativeEnumVariantField* @parse_enum_variant_field(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i1
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = bitcast i8* null to %NativeEnumVariantField*
  ret %NativeEnumVariantField* %t5
merge1:
  store i1 0, i1* %l1
  %t6 = load i8*, i8** %l0
  %s7 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t8 = call i1 @starts_with(i8* %t6, i8* %s7)
  %t9 = load i8*, i8** %l0
  %t10 = load i1, i1* %l1
  br i1 %t8, label %then2, label %merge3
then2:
  store i1 1, i1* %l1
  %t11 = load i8*, i8** %l0
  %s12 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t13 = call i8* @strip_prefix(i8* %t11, i8* %s12)
  %t14 = call i8* @trim_text(i8* %t13)
  store i8* %t14, i8** %l0
  %t15 = load i1, i1* %l1
  %t16 = load i8*, i8** %l0
  br label %merge3
merge3:
  %t17 = phi i1 [ %t15, %then2 ], [ %t10, %merge1 ]
  %t18 = phi i8* [ %t16, %then2 ], [ %t9, %merge1 ]
  store i1 %t17, i1* %l1
  store i8* %t18, i8** %l0
  %t19 = load i8*, i8** %l0
  %s20 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t21 = call double @index_of(i8* %t19, i8* %s20)
  store double %t21, double* %l2
  %t22 = load double, double* %l2
  %t23 = sitofp i64 0 to double
  %t24 = fcmp olt double %t22, %t23
  %t25 = load i8*, i8** %l0
  %t26 = load i1, i1* %l1
  %t27 = load double, double* %l2
  br i1 %t24, label %then4, label %merge5
then4:
  %t28 = bitcast i8* null to %NativeEnumVariantField*
  ret %NativeEnumVariantField* %t28
merge5:
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l2
  %t31 = fptosi double %t30 to i64
  %t32 = call i8* @sailfin_runtime_substring(i8* %t29, i64 0, i64 %t31)
  %t33 = call i8* @trim_text(i8* %t32)
  store i8* %t33, i8** %l3
  %t34 = load i8*, i8** %l3
  %t35 = call i64 @sailfin_runtime_string_length(i8* %t34)
  %t36 = icmp eq i64 %t35, 0
  %t37 = load i8*, i8** %l0
  %t38 = load i1, i1* %l1
  %t39 = load double, double* %l2
  %t40 = load i8*, i8** %l3
  br i1 %t36, label %then6, label %merge7
then6:
  %t41 = bitcast i8* null to %NativeEnumVariantField*
  ret %NativeEnumVariantField* %t41
merge7:
  %t42 = load i8*, i8** %l0
  %t43 = load double, double* %l2
  %t44 = sitofp i64 2 to double
  %t45 = fadd double %t43, %t44
  %t46 = load i8*, i8** %l0
  %t47 = call i64 @sailfin_runtime_string_length(i8* %t46)
  %t48 = fptosi double %t45 to i64
  %t49 = call i8* @sailfin_runtime_substring(i8* %t42, i64 %t48, i64 %t47)
  %t50 = call i8* @trim_text(i8* %t49)
  store i8* %t50, i8** %l4
  %t51 = load i8*, i8** %l3
  %t52 = insertvalue %NativeEnumVariantField undef, i8* %t51, 0
  %t53 = load i8*, i8** %l4
  %t54 = insertvalue %NativeEnumVariantField %t52, i8* %t53, 1
  %t55 = load i1, i1* %l1
  %t56 = insertvalue %NativeEnumVariantField %t54, i1 %t55, 2
  %t57 = alloca %NativeEnumVariantField
  store %NativeEnumVariantField %t56, %NativeEnumVariantField* %t57
  ret %NativeEnumVariantField* %t57
}

define i8* @text_char_at(i8* %value, double %index) {
entry:
  %t0 = sitofp i64 0 to double
  %t1 = fcmp olt double %index, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  ret i8* %s2
merge1:
  %t3 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t4 = sitofp i64 %t3 to double
  %t5 = fcmp oge double %index, %t4
  br i1 %t5, label %then2, label %merge3
then2:
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  ret i8* %s6
merge3:
  %t7 = sitofp i64 1 to double
  %t8 = fadd double %index, %t7
  %t9 = fptosi double %index to i64
  %t10 = fptosi double %t8 to i64
  %t11 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t9, i64 %t10)
  ret i8* %t11
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
  %t10 = call i8* @text_char_at(i8* %text, double %t9)
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

define i8* @maybe_trim_trailing(i8* %value) {
entry:
  %l0 = alloca i8*
  %t0 = icmp eq i8* %value, null
  br i1 %t0, label %then0, label %merge1
then0:
  ret i8* null
merge1:
  %t1 = call i8* @trim_trailing_delimiters(i8* %value)
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  ret i8* %t2
}

define %NativeStructField* @parse_struct_field_line(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i1
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = bitcast i8* null to %NativeStructField*
  ret %NativeStructField* %t5
merge1:
  store i1 0, i1* %l1
  %t6 = load i8*, i8** %l0
  %s7 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t8 = call i1 @starts_with(i8* %t6, i8* %s7)
  %t9 = load i8*, i8** %l0
  %t10 = load i1, i1* %l1
  br i1 %t8, label %then2, label %merge3
then2:
  store i1 1, i1* %l1
  %t11 = load i8*, i8** %l0
  %s12 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t13 = call i8* @strip_prefix(i8* %t11, i8* %s12)
  %t14 = call i8* @trim_text(i8* %t13)
  store i8* %t14, i8** %l0
  %t15 = load i1, i1* %l1
  %t16 = load i8*, i8** %l0
  br label %merge3
merge3:
  %t17 = phi i1 [ %t15, %then2 ], [ %t10, %merge1 ]
  %t18 = phi i8* [ %t16, %then2 ], [ %t9, %merge1 ]
  store i1 %t17, i1* %l1
  store i8* %t18, i8** %l0
  %t19 = load i8*, i8** %l0
  %s20 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t21 = call double @index_of(i8* %t19, i8* %s20)
  store double %t21, double* %l2
  %t22 = load double, double* %l2
  %t23 = sitofp i64 0 to double
  %t24 = fcmp olt double %t22, %t23
  %t25 = load i8*, i8** %l0
  %t26 = load i1, i1* %l1
  %t27 = load double, double* %l2
  br i1 %t24, label %then4, label %merge5
then4:
  %t28 = bitcast i8* null to %NativeStructField*
  ret %NativeStructField* %t28
merge5:
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l2
  %t31 = fptosi double %t30 to i64
  %t32 = call i8* @sailfin_runtime_substring(i8* %t29, i64 0, i64 %t31)
  %t33 = call i8* @trim_text(i8* %t32)
  store i8* %t33, i8** %l3
  %t34 = load i8*, i8** %l3
  %t35 = call i64 @sailfin_runtime_string_length(i8* %t34)
  %t36 = icmp eq i64 %t35, 0
  %t37 = load i8*, i8** %l0
  %t38 = load i1, i1* %l1
  %t39 = load double, double* %l2
  %t40 = load i8*, i8** %l3
  br i1 %t36, label %then6, label %merge7
then6:
  %t41 = bitcast i8* null to %NativeStructField*
  ret %NativeStructField* %t41
merge7:
  %t42 = load i8*, i8** %l0
  %t43 = load double, double* %l2
  %t44 = sitofp i64 2 to double
  %t45 = fadd double %t43, %t44
  %t46 = load i8*, i8** %l0
  %t47 = call i64 @sailfin_runtime_string_length(i8* %t46)
  %t48 = fptosi double %t45 to i64
  %t49 = call i8* @sailfin_runtime_substring(i8* %t42, i64 %t48, i64 %t47)
  %t50 = call i8* @trim_text(i8* %t49)
  store i8* %t50, i8** %l4
  %t51 = load i8*, i8** %l3
  %t52 = insertvalue %NativeStructField undef, i8* %t51, 0
  %t53 = load i8*, i8** %l4
  %t54 = insertvalue %NativeStructField %t52, i8* %t53, 1
  %t55 = load i1, i1* %l1
  %t56 = insertvalue %NativeStructField %t54, i1 %t55, 2
  %t57 = alloca %NativeStructField
  store %NativeStructField %t56, %NativeStructField* %t57
  ret %NativeStructField* %t57
}

define %StructLayoutHeaderParse @parse_struct_layout_header(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i1
  %l3 = alloca i1
  %l4 = alloca i1
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca i8*
  %l10 = alloca i8*
  %l11 = alloca %NumberParseResult
  %l12 = alloca i8*
  %l13 = alloca %NumberParseResult
  %l14 = alloca i1
  %t0 = call i8* @trim_text(i8* %text)
  %t1 = call { i8**, i64 }* @split_whitespace(i8* %t0)
  store { i8**, i64 }* %t1, { i8**, i64 }** %l0
  %t2 = alloca [0 x i8*]
  %t3 = getelementptr [0 x i8*], [0 x i8*]* %t2, i32 0, i32 0
  %t4 = alloca { i8**, i64 }
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t4, i32 0, i32 0
  store i8** %t3, i8*** %t5
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  store { i8**, i64 }* %t4, { i8**, i64 }** %l1
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = load { i8**, i64 }, { i8**, i64 }* %t7
  %t9 = extractvalue { i8**, i64 } %t8, 1
  %t10 = icmp eq i64 %t9, 0
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t10, label %then0, label %merge1
then0:
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s14 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.len36.h414094739, i32 0, i32 0
  %t15 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t13, i8* %s14)
  store { i8**, i64 }* %t15, { i8**, i64 }** %l1
  %t16 = insertvalue %StructLayoutHeaderParse undef, i1 0, 0
  %s17 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t18 = insertvalue %StructLayoutHeaderParse %t16, i8* %s17, 1
  %t19 = sitofp i64 0 to double
  %t20 = insertvalue %StructLayoutHeaderParse %t18, double %t19, 2
  %t21 = sitofp i64 0 to double
  %t22 = insertvalue %StructLayoutHeaderParse %t20, double %t21, 3
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t24 = insertvalue %StructLayoutHeaderParse %t22, { i8**, i64 }* %t23, 4
  ret %StructLayoutHeaderParse %t24
merge1:
  store i1 0, i1* %l2
  store i1 0, i1* %l3
  store i1 0, i1* %l4
  %s25 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s25, i8** %l5
  %t26 = sitofp i64 0 to double
  store double %t26, double* %l6
  %t27 = sitofp i64 0 to double
  store double %t27, double* %l7
  %t28 = sitofp i64 0 to double
  store double %t28, double* %l8
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t31 = load i1, i1* %l2
  %t32 = load i1, i1* %l3
  %t33 = load i1, i1* %l4
  %t34 = load i8*, i8** %l5
  %t35 = load double, double* %l6
  %t36 = load double, double* %l7
  %t37 = load double, double* %l8
  br label %loop.header2
loop.header2:
  %t240 = phi i8* [ %t34, %merge1 ], [ %t232, %loop.latch4 ]
  %t241 = phi i1 [ %t31, %merge1 ], [ %t233, %loop.latch4 ]
  %t242 = phi i1 [ %t32, %merge1 ], [ %t234, %loop.latch4 ]
  %t243 = phi double [ %t35, %merge1 ], [ %t235, %loop.latch4 ]
  %t244 = phi { i8**, i64 }* [ %t30, %merge1 ], [ %t236, %loop.latch4 ]
  %t245 = phi i1 [ %t33, %merge1 ], [ %t237, %loop.latch4 ]
  %t246 = phi double [ %t36, %merge1 ], [ %t238, %loop.latch4 ]
  %t247 = phi double [ %t37, %merge1 ], [ %t239, %loop.latch4 ]
  store i8* %t240, i8** %l5
  store i1 %t241, i1* %l2
  store i1 %t242, i1* %l3
  store double %t243, double* %l6
  store { i8**, i64 }* %t244, { i8**, i64 }** %l1
  store i1 %t245, i1* %l4
  store double %t246, double* %l7
  store double %t247, double* %l8
  br label %loop.body3
loop.body3:
  %t38 = load double, double* %l8
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load { i8**, i64 }, { i8**, i64 }* %t39
  %t41 = extractvalue { i8**, i64 } %t40, 1
  %t42 = sitofp i64 %t41 to double
  %t43 = fcmp oge double %t38, %t42
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t46 = load i1, i1* %l2
  %t47 = load i1, i1* %l3
  %t48 = load i1, i1* %l4
  %t49 = load i8*, i8** %l5
  %t50 = load double, double* %l6
  %t51 = load double, double* %l7
  %t52 = load double, double* %l8
  br i1 %t43, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load double, double* %l8
  %t55 = fptosi double %t54 to i64
  %t56 = load { i8**, i64 }, { i8**, i64 }* %t53
  %t57 = extractvalue { i8**, i64 } %t56, 0
  %t58 = extractvalue { i8**, i64 } %t56, 1
  %t59 = icmp uge i64 %t55, %t58
  ; bounds check: %t59 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t55, i64 %t58)
  %t60 = getelementptr i8*, i8** %t57, i64 %t55
  %t61 = load i8*, i8** %t60
  store i8* %t61, i8** %l9
  %t62 = load i8*, i8** %l9
  %s63 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h261048910, i32 0, i32 0
  %t64 = call i1 @starts_with(i8* %t62, i8* %s63)
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t67 = load i1, i1* %l2
  %t68 = load i1, i1* %l3
  %t69 = load i1, i1* %l4
  %t70 = load i8*, i8** %l5
  %t71 = load double, double* %l6
  %t72 = load double, double* %l7
  %t73 = load double, double* %l8
  %t74 = load i8*, i8** %l9
  br i1 %t64, label %then8, label %else9
then8:
  %t75 = load i8*, i8** %l9
  %t76 = load i8*, i8** %l9
  %t77 = call i64 @sailfin_runtime_string_length(i8* %t76)
  %t78 = call i8* @sailfin_runtime_substring(i8* %t75, i64 5, i64 %t77)
  store i8* %t78, i8** %l5
  store i1 1, i1* %l2
  %t79 = load i8*, i8** %l5
  %t80 = load i1, i1* %l2
  br label %merge10
else9:
  %t81 = load i8*, i8** %l9
  %s82 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h466680424, i32 0, i32 0
  %t83 = call i1 @starts_with(i8* %t81, i8* %s82)
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t86 = load i1, i1* %l2
  %t87 = load i1, i1* %l3
  %t88 = load i1, i1* %l4
  %t89 = load i8*, i8** %l5
  %t90 = load double, double* %l6
  %t91 = load double, double* %l7
  %t92 = load double, double* %l8
  %t93 = load i8*, i8** %l9
  br i1 %t83, label %then11, label %else12
then11:
  %t94 = load i8*, i8** %l9
  %t95 = load i8*, i8** %l9
  %t96 = call i64 @sailfin_runtime_string_length(i8* %t95)
  %t97 = call i8* @sailfin_runtime_substring(i8* %t94, i64 5, i64 %t96)
  store i8* %t97, i8** %l10
  %t98 = load i8*, i8** %l10
  %t99 = call %NumberParseResult @parse_decimal_number(i8* %t98)
  store %NumberParseResult %t99, %NumberParseResult* %l11
  %t100 = load %NumberParseResult, %NumberParseResult* %l11
  %t101 = extractvalue %NumberParseResult %t100, 0
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t104 = load i1, i1* %l2
  %t105 = load i1, i1* %l3
  %t106 = load i1, i1* %l4
  %t107 = load i8*, i8** %l5
  %t108 = load double, double* %l6
  %t109 = load double, double* %l7
  %t110 = load double, double* %l8
  %t111 = load i8*, i8** %l9
  %t112 = load i8*, i8** %l10
  %t113 = load %NumberParseResult, %NumberParseResult* %l11
  br i1 %t101, label %then14, label %else15
then14:
  store i1 1, i1* %l3
  %t114 = load %NumberParseResult, %NumberParseResult* %l11
  %t115 = extractvalue %NumberParseResult %t114, 1
  store double %t115, double* %l6
  %t116 = load i1, i1* %l3
  %t117 = load double, double* %l6
  br label %merge16
else15:
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s119 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h943297157, i32 0, i32 0
  %t120 = load i8*, i8** %l10
  %t121 = call i8* @sailfin_runtime_string_concat(i8* %s119, i8* %t120)
  %t122 = load i8, i8* %t121
  %t123 = add i8 %t122, 96
  %t124 = alloca [2 x i8], align 1
  %t125 = getelementptr [2 x i8], [2 x i8]* %t124, i32 0, i32 0
  store i8 %t123, i8* %t125
  %t126 = getelementptr [2 x i8], [2 x i8]* %t124, i32 0, i32 1
  store i8 0, i8* %t126
  %t127 = getelementptr [2 x i8], [2 x i8]* %t124, i32 0, i32 0
  %t128 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t118, i8* %t127)
  store { i8**, i64 }* %t128, { i8**, i64 }** %l1
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge16
merge16:
  %t130 = phi i1 [ %t116, %then14 ], [ %t105, %else15 ]
  %t131 = phi double [ %t117, %then14 ], [ %t108, %else15 ]
  %t132 = phi { i8**, i64 }* [ %t103, %then14 ], [ %t129, %else15 ]
  store i1 %t130, i1* %l3
  store double %t131, double* %l6
  store { i8**, i64 }* %t132, { i8**, i64 }** %l1
  %t133 = load i1, i1* %l3
  %t134 = load double, double* %l6
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge13
else12:
  %t136 = load i8*, i8** %l9
  %s137 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h841337749, i32 0, i32 0
  %t138 = call i1 @starts_with(i8* %t136, i8* %s137)
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t141 = load i1, i1* %l2
  %t142 = load i1, i1* %l3
  %t143 = load i1, i1* %l4
  %t144 = load i8*, i8** %l5
  %t145 = load double, double* %l6
  %t146 = load double, double* %l7
  %t147 = load double, double* %l8
  %t148 = load i8*, i8** %l9
  br i1 %t138, label %then17, label %else18
then17:
  %t149 = load i8*, i8** %l9
  %t150 = load i8*, i8** %l9
  %t151 = call i64 @sailfin_runtime_string_length(i8* %t150)
  %t152 = call i8* @sailfin_runtime_substring(i8* %t149, i64 6, i64 %t151)
  store i8* %t152, i8** %l12
  %t153 = load i8*, i8** %l12
  %t154 = call %NumberParseResult @parse_decimal_number(i8* %t153)
  store %NumberParseResult %t154, %NumberParseResult* %l13
  %t155 = load %NumberParseResult, %NumberParseResult* %l13
  %t156 = extractvalue %NumberParseResult %t155, 0
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t159 = load i1, i1* %l2
  %t160 = load i1, i1* %l3
  %t161 = load i1, i1* %l4
  %t162 = load i8*, i8** %l5
  %t163 = load double, double* %l6
  %t164 = load double, double* %l7
  %t165 = load double, double* %l8
  %t166 = load i8*, i8** %l9
  %t167 = load i8*, i8** %l12
  %t168 = load %NumberParseResult, %NumberParseResult* %l13
  br i1 %t156, label %then20, label %else21
then20:
  store i1 1, i1* %l4
  %t169 = load %NumberParseResult, %NumberParseResult* %l13
  %t170 = extractvalue %NumberParseResult %t169, 1
  store double %t170, double* %l7
  %t171 = load i1, i1* %l4
  %t172 = load double, double* %l7
  br label %merge22
else21:
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s174 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.len40.h1650449248, i32 0, i32 0
  %t175 = load i8*, i8** %l12
  %t176 = call i8* @sailfin_runtime_string_concat(i8* %s174, i8* %t175)
  %t177 = load i8, i8* %t176
  %t178 = add i8 %t177, 96
  %t179 = alloca [2 x i8], align 1
  %t180 = getelementptr [2 x i8], [2 x i8]* %t179, i32 0, i32 0
  store i8 %t178, i8* %t180
  %t181 = getelementptr [2 x i8], [2 x i8]* %t179, i32 0, i32 1
  store i8 0, i8* %t181
  %t182 = getelementptr [2 x i8], [2 x i8]* %t179, i32 0, i32 0
  %t183 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t173, i8* %t182)
  store { i8**, i64 }* %t183, { i8**, i64 }** %l1
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge22
merge22:
  %t185 = phi i1 [ %t171, %then20 ], [ %t161, %else21 ]
  %t186 = phi double [ %t172, %then20 ], [ %t164, %else21 ]
  %t187 = phi { i8**, i64 }* [ %t158, %then20 ], [ %t184, %else21 ]
  store i1 %t185, i1* %l4
  store double %t186, double* %l7
  store { i8**, i64 }* %t187, { i8**, i64 }** %l1
  %t188 = load i1, i1* %l4
  %t189 = load double, double* %l7
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge19
else18:
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s192 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h1415177535, i32 0, i32 0
  %t193 = load i8*, i8** %l9
  %t194 = call i8* @sailfin_runtime_string_concat(i8* %s192, i8* %t193)
  %t195 = load i8, i8* %t194
  %t196 = add i8 %t195, 96
  %t197 = alloca [2 x i8], align 1
  %t198 = getelementptr [2 x i8], [2 x i8]* %t197, i32 0, i32 0
  store i8 %t196, i8* %t198
  %t199 = getelementptr [2 x i8], [2 x i8]* %t197, i32 0, i32 1
  store i8 0, i8* %t199
  %t200 = getelementptr [2 x i8], [2 x i8]* %t197, i32 0, i32 0
  %t201 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t191, i8* %t200)
  store { i8**, i64 }* %t201, { i8**, i64 }** %l1
  %t202 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t203 = phi i1 [ %t188, %merge22 ], [ %t143, %else18 ]
  %t204 = phi double [ %t189, %merge22 ], [ %t146, %else18 ]
  %t205 = phi { i8**, i64 }* [ %t190, %merge22 ], [ %t202, %else18 ]
  store i1 %t203, i1* %l4
  store double %t204, double* %l7
  store { i8**, i64 }* %t205, { i8**, i64 }** %l1
  %t206 = load i1, i1* %l4
  %t207 = load double, double* %l7
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t209 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge13
merge13:
  %t210 = phi i1 [ %t133, %merge16 ], [ %t87, %merge19 ]
  %t211 = phi double [ %t134, %merge16 ], [ %t90, %merge19 ]
  %t212 = phi { i8**, i64 }* [ %t135, %merge16 ], [ %t208, %merge19 ]
  %t213 = phi i1 [ %t88, %merge16 ], [ %t206, %merge19 ]
  %t214 = phi double [ %t91, %merge16 ], [ %t207, %merge19 ]
  store i1 %t210, i1* %l3
  store double %t211, double* %l6
  store { i8**, i64 }* %t212, { i8**, i64 }** %l1
  store i1 %t213, i1* %l4
  store double %t214, double* %l7
  %t215 = load i1, i1* %l3
  %t216 = load double, double* %l6
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t218 = load i1, i1* %l4
  %t219 = load double, double* %l7
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t221 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge10
merge10:
  %t222 = phi i8* [ %t79, %then8 ], [ %t70, %merge13 ]
  %t223 = phi i1 [ %t80, %then8 ], [ %t67, %merge13 ]
  %t224 = phi i1 [ %t68, %then8 ], [ %t215, %merge13 ]
  %t225 = phi double [ %t71, %then8 ], [ %t216, %merge13 ]
  %t226 = phi { i8**, i64 }* [ %t66, %then8 ], [ %t217, %merge13 ]
  %t227 = phi i1 [ %t69, %then8 ], [ %t218, %merge13 ]
  %t228 = phi double [ %t72, %then8 ], [ %t219, %merge13 ]
  store i8* %t222, i8** %l5
  store i1 %t223, i1* %l2
  store i1 %t224, i1* %l3
  store double %t225, double* %l6
  store { i8**, i64 }* %t226, { i8**, i64 }** %l1
  store i1 %t227, i1* %l4
  store double %t228, double* %l7
  %t229 = load double, double* %l8
  %t230 = sitofp i64 1 to double
  %t231 = fadd double %t229, %t230
  store double %t231, double* %l8
  br label %loop.latch4
loop.latch4:
  %t232 = load i8*, i8** %l5
  %t233 = load i1, i1* %l2
  %t234 = load i1, i1* %l3
  %t235 = load double, double* %l6
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t237 = load i1, i1* %l4
  %t238 = load double, double* %l7
  %t239 = load double, double* %l8
  br label %loop.header2
afterloop5:
  %t248 = load i8*, i8** %l5
  %t249 = load i1, i1* %l2
  %t250 = load i1, i1* %l3
  %t251 = load double, double* %l6
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t253 = load i1, i1* %l4
  %t254 = load double, double* %l7
  %t255 = load double, double* %l8
  %t256 = load i1, i1* %l3
  %t257 = xor i1 %t256, 1
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t259 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t260 = load i1, i1* %l2
  %t261 = load i1, i1* %l3
  %t262 = load i1, i1* %l4
  %t263 = load i8*, i8** %l5
  %t264 = load double, double* %l6
  %t265 = load double, double* %l7
  %t266 = load double, double* %l8
  br i1 %t257, label %then23, label %merge24
then23:
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s268 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h1399971520, i32 0, i32 0
  %t269 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t267, i8* %s268)
  store { i8**, i64 }* %t269, { i8**, i64 }** %l1
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge24
merge24:
  %t271 = phi { i8**, i64 }* [ %t270, %then23 ], [ %t259, %afterloop5 ]
  store { i8**, i64 }* %t271, { i8**, i64 }** %l1
  %t272 = load i1, i1* %l4
  %t273 = xor i1 %t272, 1
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t275 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t276 = load i1, i1* %l2
  %t277 = load i1, i1* %l3
  %t278 = load i1, i1* %l4
  %t279 = load i8*, i8** %l5
  %t280 = load double, double* %l6
  %t281 = load double, double* %l7
  %t282 = load double, double* %l8
  br i1 %t273, label %then25, label %merge26
then25:
  %t283 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s284 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.len40.h318366654, i32 0, i32 0
  %t285 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t283, i8* %s284)
  store { i8**, i64 }* %t285, { i8**, i64 }** %l1
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t287 = phi { i8**, i64 }* [ %t286, %then25 ], [ %t275, %merge24 ]
  store { i8**, i64 }* %t287, { i8**, i64 }** %l1
  %t289 = load i1, i1* %l3
  br label %logical_and_entry_288

logical_and_entry_288:
  br i1 %t289, label %logical_and_right_288, label %logical_and_merge_288

logical_and_right_288:
  %t291 = load i1, i1* %l4
  br label %logical_and_entry_290

logical_and_entry_290:
  br i1 %t291, label %logical_and_right_290, label %logical_and_merge_290

logical_and_right_290:
  %t292 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t293 = load { i8**, i64 }, { i8**, i64 }* %t292
  %t294 = extractvalue { i8**, i64 } %t293, 1
  %t295 = icmp eq i64 %t294, 0
  br label %logical_and_right_end_290

logical_and_right_end_290:
  br label %logical_and_merge_290

logical_and_merge_290:
  %t296 = phi i1 [ false, %logical_and_entry_290 ], [ %t295, %logical_and_right_end_290 ]
  br label %logical_and_right_end_288

logical_and_right_end_288:
  br label %logical_and_merge_288

logical_and_merge_288:
  %t297 = phi i1 [ false, %logical_and_entry_288 ], [ %t296, %logical_and_right_end_288 ]
  store i1 %t297, i1* %l14
  %t298 = load i1, i1* %l14
  %t299 = insertvalue %StructLayoutHeaderParse undef, i1 %t298, 0
  %t300 = load i8*, i8** %l5
  %t301 = insertvalue %StructLayoutHeaderParse %t299, i8* %t300, 1
  %t302 = load double, double* %l6
  %t303 = insertvalue %StructLayoutHeaderParse %t301, double %t302, 2
  %t304 = load double, double* %l7
  %t305 = insertvalue %StructLayoutHeaderParse %t303, double %t304, 3
  %t306 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t307 = insertvalue %StructLayoutHeaderParse %t305, { i8**, i64 }* %t306, 4
  ret %StructLayoutHeaderParse %t307
}

define %StructLayoutFieldParse @parse_struct_layout_field(i8* %text, i8* %struct_name) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %NativeStructLayoutField
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca i1
  %l7 = alloca i1
  %l8 = alloca i1
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca i8*
  %l14 = alloca i8*
  %l15 = alloca %NumberParseResult
  %l16 = alloca i8*
  %l17 = alloca %NumberParseResult
  %l18 = alloca i8*
  %l19 = alloca %NumberParseResult
  %l20 = alloca i1
  %l21 = alloca %NativeStructLayoutField
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = alloca [0 x i8*]
  %t2 = getelementptr [0 x i8*], [0 x i8*]* %t1, i32 0, i32 0
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t2, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t7 = insertvalue %NativeStructLayoutField undef, i8* %s6, 0
  %s8 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t9 = insertvalue %NativeStructLayoutField %t7, i8* %s8, 1
  %t10 = sitofp i64 0 to double
  %t11 = insertvalue %NativeStructLayoutField %t9, double %t10, 2
  %t12 = sitofp i64 0 to double
  %t13 = insertvalue %NativeStructLayoutField %t11, double %t12, 3
  %t14 = sitofp i64 0 to double
  %t15 = insertvalue %NativeStructLayoutField %t13, double %t14, 4
  store %NativeStructLayoutField %t15, %NativeStructLayoutField* %l2
  %t16 = load i8*, i8** %l0
  %t17 = call i64 @sailfin_runtime_string_length(i8* %t16)
  %t18 = icmp eq i64 %t17, 0
  %t19 = load i8*, i8** %l0
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t21 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  br i1 %t18, label %then0, label %merge1
then0:
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s23 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t24 = call i8* @sailfin_runtime_string_concat(i8* %s23, i8* %struct_name)
  %s25 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h128952257, i32 0, i32 0
  %t26 = call i8* @sailfin_runtime_string_concat(i8* %t24, i8* %s25)
  %t27 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t22, i8* %t26)
  store { i8**, i64 }* %t27, { i8**, i64 }** %l1
  %t28 = insertvalue %StructLayoutFieldParse undef, i1 0, 0
  %t29 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t30 = insertvalue %StructLayoutFieldParse %t28, %NativeStructLayoutField %t29, 1
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t32 = insertvalue %StructLayoutFieldParse %t30, { i8**, i64 }* %t31, 2
  ret %StructLayoutFieldParse %t32
merge1:
  %t33 = load i8*, i8** %l0
  %t34 = call { i8**, i64 }* @split_whitespace(i8* %t33)
  store { i8**, i64 }* %t34, { i8**, i64 }** %l3
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t36 = load { i8**, i64 }, { i8**, i64 }* %t35
  %t37 = extractvalue { i8**, i64 } %t36, 1
  %t38 = icmp eq i64 %t37, 0
  %t39 = load i8*, i8** %l0
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t41 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br i1 %t38, label %then2, label %merge3
then2:
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s44 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t45 = call i8* @sailfin_runtime_string_concat(i8* %s44, i8* %struct_name)
  %s46 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h555082439, i32 0, i32 0
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %t45, i8* %s46)
  %t48 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t43, i8* %t47)
  store { i8**, i64 }* %t48, { i8**, i64 }** %l1
  %t49 = insertvalue %StructLayoutFieldParse undef, i1 0, 0
  %t50 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t51 = insertvalue %StructLayoutFieldParse %t49, %NativeStructLayoutField %t50, 1
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t53 = insertvalue %StructLayoutFieldParse %t51, { i8**, i64 }* %t52, 2
  ret %StructLayoutFieldParse %t53
merge3:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t55 = load { i8**, i64 }, { i8**, i64 }* %t54
  %t56 = extractvalue { i8**, i64 } %t55, 0
  %t57 = extractvalue { i8**, i64 } %t55, 1
  %t58 = icmp uge i64 0, %t57
  ; bounds check: %t58 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t57)
  %t59 = getelementptr i8*, i8** %t56, i64 0
  %t60 = load i8*, i8** %t59
  store i8* %t60, i8** %l4
  %t61 = load i8*, i8** %l4
  %t62 = call i64 @sailfin_runtime_string_length(i8* %t61)
  %t63 = icmp eq i64 %t62, 0
  %t64 = load i8*, i8** %l0
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t66 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t68 = load i8*, i8** %l4
  br i1 %t63, label %then4, label %merge5
then4:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s70 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t71 = call i8* @sailfin_runtime_string_concat(i8* %s70, i8* %struct_name)
  %s72 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h130324785, i32 0, i32 0
  %t73 = call i8* @sailfin_runtime_string_concat(i8* %t71, i8* %s72)
  %t74 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t69, i8* %t73)
  store { i8**, i64 }* %t74, { i8**, i64 }** %l1
  %t75 = insertvalue %StructLayoutFieldParse undef, i1 0, 0
  %t76 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t77 = insertvalue %StructLayoutFieldParse %t75, %NativeStructLayoutField %t76, 1
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t79 = insertvalue %StructLayoutFieldParse %t77, { i8**, i64 }* %t78, 2
  ret %StructLayoutFieldParse %t79
merge5:
  %s80 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s80, i8** %l5
  store i1 0, i1* %l6
  store i1 0, i1* %l7
  store i1 0, i1* %l8
  %t81 = sitofp i64 0 to double
  store double %t81, double* %l9
  %t82 = sitofp i64 0 to double
  store double %t82, double* %l10
  %t83 = sitofp i64 0 to double
  store double %t83, double* %l11
  %t84 = sitofp i64 1 to double
  store double %t84, double* %l12
  %t85 = load i8*, i8** %l0
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t87 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t89 = load i8*, i8** %l4
  %t90 = load i8*, i8** %l5
  %t91 = load i1, i1* %l6
  %t92 = load i1, i1* %l7
  %t93 = load i1, i1* %l8
  %t94 = load double, double* %l9
  %t95 = load double, double* %l10
  %t96 = load double, double* %l11
  %t97 = load double, double* %l12
  br label %loop.header6
loop.header6:
  %t433 = phi i8* [ %t90, %merge5 ], [ %t424, %loop.latch8 ]
  %t434 = phi i1 [ %t91, %merge5 ], [ %t425, %loop.latch8 ]
  %t435 = phi double [ %t94, %merge5 ], [ %t426, %loop.latch8 ]
  %t436 = phi { i8**, i64 }* [ %t86, %merge5 ], [ %t427, %loop.latch8 ]
  %t437 = phi i1 [ %t92, %merge5 ], [ %t428, %loop.latch8 ]
  %t438 = phi double [ %t95, %merge5 ], [ %t429, %loop.latch8 ]
  %t439 = phi i1 [ %t93, %merge5 ], [ %t430, %loop.latch8 ]
  %t440 = phi double [ %t96, %merge5 ], [ %t431, %loop.latch8 ]
  %t441 = phi double [ %t97, %merge5 ], [ %t432, %loop.latch8 ]
  store i8* %t433, i8** %l5
  store i1 %t434, i1* %l6
  store double %t435, double* %l9
  store { i8**, i64 }* %t436, { i8**, i64 }** %l1
  store i1 %t437, i1* %l7
  store double %t438, double* %l10
  store i1 %t439, i1* %l8
  store double %t440, double* %l11
  store double %t441, double* %l12
  br label %loop.body7
loop.body7:
  %t98 = load double, double* %l12
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t100 = load { i8**, i64 }, { i8**, i64 }* %t99
  %t101 = extractvalue { i8**, i64 } %t100, 1
  %t102 = sitofp i64 %t101 to double
  %t103 = fcmp oge double %t98, %t102
  %t104 = load i8*, i8** %l0
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t106 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t108 = load i8*, i8** %l4
  %t109 = load i8*, i8** %l5
  %t110 = load i1, i1* %l6
  %t111 = load i1, i1* %l7
  %t112 = load i1, i1* %l8
  %t113 = load double, double* %l9
  %t114 = load double, double* %l10
  %t115 = load double, double* %l11
  %t116 = load double, double* %l12
  br i1 %t103, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t118 = load double, double* %l12
  %t119 = fptosi double %t118 to i64
  %t120 = load { i8**, i64 }, { i8**, i64 }* %t117
  %t121 = extractvalue { i8**, i64 } %t120, 0
  %t122 = extractvalue { i8**, i64 } %t120, 1
  %t123 = icmp uge i64 %t119, %t122
  ; bounds check: %t123 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t119, i64 %t122)
  %t124 = getelementptr i8*, i8** %t121, i64 %t119
  %t125 = load i8*, i8** %t124
  store i8* %t125, i8** %l13
  %t126 = load i8*, i8** %l13
  %s127 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h524431183, i32 0, i32 0
  %t128 = call i1 @starts_with(i8* %t126, i8* %s127)
  %t129 = load i8*, i8** %l0
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t131 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t133 = load i8*, i8** %l4
  %t134 = load i8*, i8** %l5
  %t135 = load i1, i1* %l6
  %t136 = load i1, i1* %l7
  %t137 = load i1, i1* %l8
  %t138 = load double, double* %l9
  %t139 = load double, double* %l10
  %t140 = load double, double* %l11
  %t141 = load double, double* %l12
  %t142 = load i8*, i8** %l13
  br i1 %t128, label %then12, label %else13
then12:
  %t143 = load i8*, i8** %l13
  %t144 = load i8*, i8** %l13
  %t145 = call i64 @sailfin_runtime_string_length(i8* %t144)
  %t146 = call i8* @sailfin_runtime_substring(i8* %t143, i64 5, i64 %t145)
  store i8* %t146, i8** %l5
  %t147 = load i8*, i8** %l5
  br label %merge14
else13:
  %t148 = load i8*, i8** %l13
  %s149 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h242296049, i32 0, i32 0
  %t150 = call i1 @starts_with(i8* %t148, i8* %s149)
  %t151 = load i8*, i8** %l0
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t153 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t155 = load i8*, i8** %l4
  %t156 = load i8*, i8** %l5
  %t157 = load i1, i1* %l6
  %t158 = load i1, i1* %l7
  %t159 = load i1, i1* %l8
  %t160 = load double, double* %l9
  %t161 = load double, double* %l10
  %t162 = load double, double* %l11
  %t163 = load double, double* %l12
  %t164 = load i8*, i8** %l13
  br i1 %t150, label %then15, label %else16
then15:
  %t165 = load i8*, i8** %l13
  %t166 = load i8*, i8** %l13
  %t167 = call i64 @sailfin_runtime_string_length(i8* %t166)
  %t168 = call i8* @sailfin_runtime_substring(i8* %t165, i64 7, i64 %t167)
  store i8* %t168, i8** %l14
  %t169 = load i8*, i8** %l14
  %t170 = call %NumberParseResult @parse_decimal_number(i8* %t169)
  store %NumberParseResult %t170, %NumberParseResult* %l15
  %t171 = load %NumberParseResult, %NumberParseResult* %l15
  %t172 = extractvalue %NumberParseResult %t171, 0
  %t173 = load i8*, i8** %l0
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t175 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t177 = load i8*, i8** %l4
  %t178 = load i8*, i8** %l5
  %t179 = load i1, i1* %l6
  %t180 = load i1, i1* %l7
  %t181 = load i1, i1* %l8
  %t182 = load double, double* %l9
  %t183 = load double, double* %l10
  %t184 = load double, double* %l11
  %t185 = load double, double* %l12
  %t186 = load i8*, i8** %l13
  %t187 = load i8*, i8** %l14
  %t188 = load %NumberParseResult, %NumberParseResult* %l15
  br i1 %t172, label %then18, label %else19
then18:
  store i1 1, i1* %l6
  %t189 = load %NumberParseResult, %NumberParseResult* %l15
  %t190 = extractvalue %NumberParseResult %t189, 1
  store double %t190, double* %l9
  %t191 = load i1, i1* %l6
  %t192 = load double, double* %l9
  br label %merge20
else19:
  %t193 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s194 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t195 = call i8* @sailfin_runtime_string_concat(i8* %s194, i8* %struct_name)
  %s196 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t197 = call i8* @sailfin_runtime_string_concat(i8* %t195, i8* %s196)
  %t198 = load i8*, i8** %l4
  %t199 = call i8* @sailfin_runtime_string_concat(i8* %t197, i8* %t198)
  %s200 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h24304067, i32 0, i32 0
  %t201 = call i8* @sailfin_runtime_string_concat(i8* %t199, i8* %s200)
  %t202 = load i8*, i8** %l14
  %t203 = call i8* @sailfin_runtime_string_concat(i8* %t201, i8* %t202)
  %t204 = load i8, i8* %t203
  %t205 = add i8 %t204, 96
  %t206 = alloca [2 x i8], align 1
  %t207 = getelementptr [2 x i8], [2 x i8]* %t206, i32 0, i32 0
  store i8 %t205, i8* %t207
  %t208 = getelementptr [2 x i8], [2 x i8]* %t206, i32 0, i32 1
  store i8 0, i8* %t208
  %t209 = getelementptr [2 x i8], [2 x i8]* %t206, i32 0, i32 0
  %t210 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t193, i8* %t209)
  store { i8**, i64 }* %t210, { i8**, i64 }** %l1
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t212 = phi i1 [ %t191, %then18 ], [ %t179, %else19 ]
  %t213 = phi double [ %t192, %then18 ], [ %t182, %else19 ]
  %t214 = phi { i8**, i64 }* [ %t174, %then18 ], [ %t211, %else19 ]
  store i1 %t212, i1* %l6
  store double %t213, double* %l9
  store { i8**, i64 }* %t214, { i8**, i64 }** %l1
  %t215 = load i1, i1* %l6
  %t216 = load double, double* %l9
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
else16:
  %t218 = load i8*, i8** %l13
  %s219 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h466680424, i32 0, i32 0
  %t220 = call i1 @starts_with(i8* %t218, i8* %s219)
  %t221 = load i8*, i8** %l0
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t223 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t225 = load i8*, i8** %l4
  %t226 = load i8*, i8** %l5
  %t227 = load i1, i1* %l6
  %t228 = load i1, i1* %l7
  %t229 = load i1, i1* %l8
  %t230 = load double, double* %l9
  %t231 = load double, double* %l10
  %t232 = load double, double* %l11
  %t233 = load double, double* %l12
  %t234 = load i8*, i8** %l13
  br i1 %t220, label %then21, label %else22
then21:
  %t235 = load i8*, i8** %l13
  %t236 = load i8*, i8** %l13
  %t237 = call i64 @sailfin_runtime_string_length(i8* %t236)
  %t238 = call i8* @sailfin_runtime_substring(i8* %t235, i64 5, i64 %t237)
  store i8* %t238, i8** %l16
  %t239 = load i8*, i8** %l16
  %t240 = call %NumberParseResult @parse_decimal_number(i8* %t239)
  store %NumberParseResult %t240, %NumberParseResult* %l17
  %t241 = load %NumberParseResult, %NumberParseResult* %l17
  %t242 = extractvalue %NumberParseResult %t241, 0
  %t243 = load i8*, i8** %l0
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t245 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t247 = load i8*, i8** %l4
  %t248 = load i8*, i8** %l5
  %t249 = load i1, i1* %l6
  %t250 = load i1, i1* %l7
  %t251 = load i1, i1* %l8
  %t252 = load double, double* %l9
  %t253 = load double, double* %l10
  %t254 = load double, double* %l11
  %t255 = load double, double* %l12
  %t256 = load i8*, i8** %l13
  %t257 = load i8*, i8** %l16
  %t258 = load %NumberParseResult, %NumberParseResult* %l17
  br i1 %t242, label %then24, label %else25
then24:
  store i1 1, i1* %l7
  %t259 = load %NumberParseResult, %NumberParseResult* %l17
  %t260 = extractvalue %NumberParseResult %t259, 1
  store double %t260, double* %l10
  %t261 = load i1, i1* %l7
  %t262 = load double, double* %l10
  br label %merge26
else25:
  %t263 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s264 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t265 = call i8* @sailfin_runtime_string_concat(i8* %s264, i8* %struct_name)
  %s266 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t267 = call i8* @sailfin_runtime_string_concat(i8* %t265, i8* %s266)
  %t268 = load i8*, i8** %l4
  %t269 = call i8* @sailfin_runtime_string_concat(i8* %t267, i8* %t268)
  %s270 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h151690315, i32 0, i32 0
  %t271 = call i8* @sailfin_runtime_string_concat(i8* %t269, i8* %s270)
  %t272 = load i8*, i8** %l16
  %t273 = call i8* @sailfin_runtime_string_concat(i8* %t271, i8* %t272)
  %t274 = load i8, i8* %t273
  %t275 = add i8 %t274, 96
  %t276 = alloca [2 x i8], align 1
  %t277 = getelementptr [2 x i8], [2 x i8]* %t276, i32 0, i32 0
  store i8 %t275, i8* %t277
  %t278 = getelementptr [2 x i8], [2 x i8]* %t276, i32 0, i32 1
  store i8 0, i8* %t278
  %t279 = getelementptr [2 x i8], [2 x i8]* %t276, i32 0, i32 0
  %t280 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t263, i8* %t279)
  store { i8**, i64 }* %t280, { i8**, i64 }** %l1
  %t281 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t282 = phi i1 [ %t261, %then24 ], [ %t250, %else25 ]
  %t283 = phi double [ %t262, %then24 ], [ %t253, %else25 ]
  %t284 = phi { i8**, i64 }* [ %t244, %then24 ], [ %t281, %else25 ]
  store i1 %t282, i1* %l7
  store double %t283, double* %l10
  store { i8**, i64 }* %t284, { i8**, i64 }** %l1
  %t285 = load i1, i1* %l7
  %t286 = load double, double* %l10
  %t287 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
else22:
  %t288 = load i8*, i8** %l13
  %s289 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h841337749, i32 0, i32 0
  %t290 = call i1 @starts_with(i8* %t288, i8* %s289)
  %t291 = load i8*, i8** %l0
  %t292 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t293 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t294 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t295 = load i8*, i8** %l4
  %t296 = load i8*, i8** %l5
  %t297 = load i1, i1* %l6
  %t298 = load i1, i1* %l7
  %t299 = load i1, i1* %l8
  %t300 = load double, double* %l9
  %t301 = load double, double* %l10
  %t302 = load double, double* %l11
  %t303 = load double, double* %l12
  %t304 = load i8*, i8** %l13
  br i1 %t290, label %then27, label %else28
then27:
  %t305 = load i8*, i8** %l13
  %t306 = load i8*, i8** %l13
  %t307 = call i64 @sailfin_runtime_string_length(i8* %t306)
  %t308 = call i8* @sailfin_runtime_substring(i8* %t305, i64 6, i64 %t307)
  store i8* %t308, i8** %l18
  %t309 = load i8*, i8** %l18
  %t310 = call %NumberParseResult @parse_decimal_number(i8* %t309)
  store %NumberParseResult %t310, %NumberParseResult* %l19
  %t311 = load %NumberParseResult, %NumberParseResult* %l19
  %t312 = extractvalue %NumberParseResult %t311, 0
  %t313 = load i8*, i8** %l0
  %t314 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t315 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t316 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t317 = load i8*, i8** %l4
  %t318 = load i8*, i8** %l5
  %t319 = load i1, i1* %l6
  %t320 = load i1, i1* %l7
  %t321 = load i1, i1* %l8
  %t322 = load double, double* %l9
  %t323 = load double, double* %l10
  %t324 = load double, double* %l11
  %t325 = load double, double* %l12
  %t326 = load i8*, i8** %l13
  %t327 = load i8*, i8** %l18
  %t328 = load %NumberParseResult, %NumberParseResult* %l19
  br i1 %t312, label %then30, label %else31
then30:
  store i1 1, i1* %l8
  %t329 = load %NumberParseResult, %NumberParseResult* %l19
  %t330 = extractvalue %NumberParseResult %t329, 1
  store double %t330, double* %l11
  %t331 = load i1, i1* %l8
  %t332 = load double, double* %l11
  br label %merge32
else31:
  %t333 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s334 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t335 = call i8* @sailfin_runtime_string_concat(i8* %s334, i8* %struct_name)
  %s336 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t337 = call i8* @sailfin_runtime_string_concat(i8* %t335, i8* %s336)
  %t338 = load i8*, i8** %l4
  %t339 = call i8* @sailfin_runtime_string_concat(i8* %t337, i8* %t338)
  %s340 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1297227834, i32 0, i32 0
  %t341 = call i8* @sailfin_runtime_string_concat(i8* %t339, i8* %s340)
  %t342 = load i8*, i8** %l18
  %t343 = call i8* @sailfin_runtime_string_concat(i8* %t341, i8* %t342)
  %t344 = load i8, i8* %t343
  %t345 = add i8 %t344, 96
  %t346 = alloca [2 x i8], align 1
  %t347 = getelementptr [2 x i8], [2 x i8]* %t346, i32 0, i32 0
  store i8 %t345, i8* %t347
  %t348 = getelementptr [2 x i8], [2 x i8]* %t346, i32 0, i32 1
  store i8 0, i8* %t348
  %t349 = getelementptr [2 x i8], [2 x i8]* %t346, i32 0, i32 0
  %t350 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t333, i8* %t349)
  store { i8**, i64 }* %t350, { i8**, i64 }** %l1
  %t351 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t352 = phi i1 [ %t331, %then30 ], [ %t321, %else31 ]
  %t353 = phi double [ %t332, %then30 ], [ %t324, %else31 ]
  %t354 = phi { i8**, i64 }* [ %t314, %then30 ], [ %t351, %else31 ]
  store i1 %t352, i1* %l8
  store double %t353, double* %l11
  store { i8**, i64 }* %t354, { i8**, i64 }** %l1
  %t355 = load i1, i1* %l8
  %t356 = load double, double* %l11
  %t357 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
else28:
  %t358 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s359 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t360 = call i8* @sailfin_runtime_string_concat(i8* %s359, i8* %struct_name)
  %s361 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t362 = call i8* @sailfin_runtime_string_concat(i8* %t360, i8* %s361)
  %t363 = load i8*, i8** %l4
  %t364 = call i8* @sailfin_runtime_string_concat(i8* %t362, i8* %t363)
  %s365 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h496289716, i32 0, i32 0
  %t366 = call i8* @sailfin_runtime_string_concat(i8* %t364, i8* %s365)
  %t367 = load i8*, i8** %l13
  %t368 = call i8* @sailfin_runtime_string_concat(i8* %t366, i8* %t367)
  %t369 = load i8, i8* %t368
  %t370 = add i8 %t369, 96
  %t371 = alloca [2 x i8], align 1
  %t372 = getelementptr [2 x i8], [2 x i8]* %t371, i32 0, i32 0
  store i8 %t370, i8* %t372
  %t373 = getelementptr [2 x i8], [2 x i8]* %t371, i32 0, i32 1
  store i8 0, i8* %t373
  %t374 = getelementptr [2 x i8], [2 x i8]* %t371, i32 0, i32 0
  %t375 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t358, i8* %t374)
  store { i8**, i64 }* %t375, { i8**, i64 }** %l1
  %t376 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t377 = phi i1 [ %t355, %merge32 ], [ %t299, %else28 ]
  %t378 = phi double [ %t356, %merge32 ], [ %t302, %else28 ]
  %t379 = phi { i8**, i64 }* [ %t357, %merge32 ], [ %t376, %else28 ]
  store i1 %t377, i1* %l8
  store double %t378, double* %l11
  store { i8**, i64 }* %t379, { i8**, i64 }** %l1
  %t380 = load i1, i1* %l8
  %t381 = load double, double* %l11
  %t382 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t383 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t384 = phi i1 [ %t285, %merge26 ], [ %t228, %merge29 ]
  %t385 = phi double [ %t286, %merge26 ], [ %t231, %merge29 ]
  %t386 = phi { i8**, i64 }* [ %t287, %merge26 ], [ %t382, %merge29 ]
  %t387 = phi i1 [ %t229, %merge26 ], [ %t380, %merge29 ]
  %t388 = phi double [ %t232, %merge26 ], [ %t381, %merge29 ]
  store i1 %t384, i1* %l7
  store double %t385, double* %l10
  store { i8**, i64 }* %t386, { i8**, i64 }** %l1
  store i1 %t387, i1* %l8
  store double %t388, double* %l11
  %t389 = load i1, i1* %l7
  %t390 = load double, double* %l10
  %t391 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t392 = load i1, i1* %l8
  %t393 = load double, double* %l11
  %t394 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t395 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
merge17:
  %t396 = phi i1 [ %t215, %merge20 ], [ %t157, %merge23 ]
  %t397 = phi double [ %t216, %merge20 ], [ %t160, %merge23 ]
  %t398 = phi { i8**, i64 }* [ %t217, %merge20 ], [ %t391, %merge23 ]
  %t399 = phi i1 [ %t158, %merge20 ], [ %t389, %merge23 ]
  %t400 = phi double [ %t161, %merge20 ], [ %t390, %merge23 ]
  %t401 = phi i1 [ %t159, %merge20 ], [ %t392, %merge23 ]
  %t402 = phi double [ %t162, %merge20 ], [ %t393, %merge23 ]
  store i1 %t396, i1* %l6
  store double %t397, double* %l9
  store { i8**, i64 }* %t398, { i8**, i64 }** %l1
  store i1 %t399, i1* %l7
  store double %t400, double* %l10
  store i1 %t401, i1* %l8
  store double %t402, double* %l11
  %t403 = load i1, i1* %l6
  %t404 = load double, double* %l9
  %t405 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t406 = load i1, i1* %l7
  %t407 = load double, double* %l10
  %t408 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t409 = load i1, i1* %l8
  %t410 = load double, double* %l11
  %t411 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t412 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge14
merge14:
  %t413 = phi i8* [ %t147, %then12 ], [ %t134, %merge17 ]
  %t414 = phi i1 [ %t135, %then12 ], [ %t403, %merge17 ]
  %t415 = phi double [ %t138, %then12 ], [ %t404, %merge17 ]
  %t416 = phi { i8**, i64 }* [ %t130, %then12 ], [ %t405, %merge17 ]
  %t417 = phi i1 [ %t136, %then12 ], [ %t406, %merge17 ]
  %t418 = phi double [ %t139, %then12 ], [ %t407, %merge17 ]
  %t419 = phi i1 [ %t137, %then12 ], [ %t409, %merge17 ]
  %t420 = phi double [ %t140, %then12 ], [ %t410, %merge17 ]
  store i8* %t413, i8** %l5
  store i1 %t414, i1* %l6
  store double %t415, double* %l9
  store { i8**, i64 }* %t416, { i8**, i64 }** %l1
  store i1 %t417, i1* %l7
  store double %t418, double* %l10
  store i1 %t419, i1* %l8
  store double %t420, double* %l11
  %t421 = load double, double* %l12
  %t422 = sitofp i64 1 to double
  %t423 = fadd double %t421, %t422
  store double %t423, double* %l12
  br label %loop.latch8
loop.latch8:
  %t424 = load i8*, i8** %l5
  %t425 = load i1, i1* %l6
  %t426 = load double, double* %l9
  %t427 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t428 = load i1, i1* %l7
  %t429 = load double, double* %l10
  %t430 = load i1, i1* %l8
  %t431 = load double, double* %l11
  %t432 = load double, double* %l12
  br label %loop.header6
afterloop9:
  %t442 = load i8*, i8** %l5
  %t443 = load i1, i1* %l6
  %t444 = load double, double* %l9
  %t445 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t446 = load i1, i1* %l7
  %t447 = load double, double* %l10
  %t448 = load i1, i1* %l8
  %t449 = load double, double* %l11
  %t450 = load double, double* %l12
  %t451 = load i8*, i8** %l5
  %t452 = call i64 @sailfin_runtime_string_length(i8* %t451)
  %t453 = icmp eq i64 %t452, 0
  %t454 = load i8*, i8** %l0
  %t455 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t456 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t457 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t458 = load i8*, i8** %l4
  %t459 = load i8*, i8** %l5
  %t460 = load i1, i1* %l6
  %t461 = load i1, i1* %l7
  %t462 = load i1, i1* %l8
  %t463 = load double, double* %l9
  %t464 = load double, double* %l10
  %t465 = load double, double* %l11
  %t466 = load double, double* %l12
  br i1 %t453, label %then33, label %merge34
then33:
  %t467 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s468 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t469 = call i8* @sailfin_runtime_string_concat(i8* %s468, i8* %struct_name)
  %s470 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t471 = call i8* @sailfin_runtime_string_concat(i8* %t469, i8* %s470)
  %t472 = load i8*, i8** %l4
  %t473 = call i8* @sailfin_runtime_string_concat(i8* %t471, i8* %t472)
  %s474 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1568429285, i32 0, i32 0
  %t475 = call i8* @sailfin_runtime_string_concat(i8* %t473, i8* %s474)
  %t476 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t467, i8* %t475)
  store { i8**, i64 }* %t476, { i8**, i64 }** %l1
  %t477 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t478 = phi { i8**, i64 }* [ %t477, %then33 ], [ %t455, %afterloop9 ]
  store { i8**, i64 }* %t478, { i8**, i64 }** %l1
  %t479 = load i1, i1* %l6
  %t480 = xor i1 %t479, 1
  %t481 = load i8*, i8** %l0
  %t482 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t483 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t484 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t485 = load i8*, i8** %l4
  %t486 = load i8*, i8** %l5
  %t487 = load i1, i1* %l6
  %t488 = load i1, i1* %l7
  %t489 = load i1, i1* %l8
  %t490 = load double, double* %l9
  %t491 = load double, double* %l10
  %t492 = load double, double* %l11
  %t493 = load double, double* %l12
  br i1 %t480, label %then35, label %merge36
then35:
  %t494 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s495 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t496 = call i8* @sailfin_runtime_string_concat(i8* %s495, i8* %struct_name)
  %s497 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t498 = call i8* @sailfin_runtime_string_concat(i8* %t496, i8* %s497)
  %t499 = load i8*, i8** %l4
  %t500 = call i8* @sailfin_runtime_string_concat(i8* %t498, i8* %t499)
  %s501 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h625556084, i32 0, i32 0
  %t502 = call i8* @sailfin_runtime_string_concat(i8* %t500, i8* %s501)
  %t503 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t494, i8* %t502)
  store { i8**, i64 }* %t503, { i8**, i64 }** %l1
  %t504 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge36
merge36:
  %t505 = phi { i8**, i64 }* [ %t504, %then35 ], [ %t482, %merge34 ]
  store { i8**, i64 }* %t505, { i8**, i64 }** %l1
  %t506 = load i1, i1* %l7
  %t507 = xor i1 %t506, 1
  %t508 = load i8*, i8** %l0
  %t509 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t510 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t511 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t512 = load i8*, i8** %l4
  %t513 = load i8*, i8** %l5
  %t514 = load i1, i1* %l6
  %t515 = load i1, i1* %l7
  %t516 = load i1, i1* %l8
  %t517 = load double, double* %l9
  %t518 = load double, double* %l10
  %t519 = load double, double* %l11
  %t520 = load double, double* %l12
  br i1 %t507, label %then37, label %merge38
then37:
  %t521 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s522 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t523 = call i8* @sailfin_runtime_string_concat(i8* %s522, i8* %struct_name)
  %s524 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t525 = call i8* @sailfin_runtime_string_concat(i8* %t523, i8* %s524)
  %t526 = load i8*, i8** %l4
  %t527 = call i8* @sailfin_runtime_string_concat(i8* %t525, i8* %t526)
  %s528 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h608364678, i32 0, i32 0
  %t529 = call i8* @sailfin_runtime_string_concat(i8* %t527, i8* %s528)
  %t530 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t521, i8* %t529)
  store { i8**, i64 }* %t530, { i8**, i64 }** %l1
  %t531 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge38
merge38:
  %t532 = phi { i8**, i64 }* [ %t531, %then37 ], [ %t509, %merge36 ]
  store { i8**, i64 }* %t532, { i8**, i64 }** %l1
  %t533 = load i1, i1* %l8
  %t534 = xor i1 %t533, 1
  %t535 = load i8*, i8** %l0
  %t536 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t537 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t538 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t539 = load i8*, i8** %l4
  %t540 = load i8*, i8** %l5
  %t541 = load i1, i1* %l6
  %t542 = load i1, i1* %l7
  %t543 = load i1, i1* %l8
  %t544 = load double, double* %l9
  %t545 = load double, double* %l10
  %t546 = load double, double* %l11
  %t547 = load double, double* %l12
  br i1 %t534, label %then39, label %merge40
then39:
  %t548 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s549 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t550 = call i8* @sailfin_runtime_string_concat(i8* %s549, i8* %struct_name)
  %s551 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t552 = call i8* @sailfin_runtime_string_concat(i8* %t550, i8* %s551)
  %t553 = load i8*, i8** %l4
  %t554 = call i8* @sailfin_runtime_string_concat(i8* %t552, i8* %t553)
  %s555 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h2112628887, i32 0, i32 0
  %t556 = call i8* @sailfin_runtime_string_concat(i8* %t554, i8* %s555)
  %t557 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t548, i8* %t556)
  store { i8**, i64 }* %t557, { i8**, i64 }** %l1
  %t558 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge40
merge40:
  %t559 = phi { i8**, i64 }* [ %t558, %then39 ], [ %t536, %merge38 ]
  store { i8**, i64 }* %t559, { i8**, i64 }** %l1
  %t561 = load i8*, i8** %l5
  %t562 = call i64 @sailfin_runtime_string_length(i8* %t561)
  %t563 = icmp sgt i64 %t562, 0
  br label %logical_and_entry_560

logical_and_entry_560:
  br i1 %t563, label %logical_and_right_560, label %logical_and_merge_560

logical_and_right_560:
  %t565 = load i1, i1* %l6
  br label %logical_and_entry_564

logical_and_entry_564:
  br i1 %t565, label %logical_and_right_564, label %logical_and_merge_564

logical_and_right_564:
  %t567 = load i1, i1* %l7
  br label %logical_and_entry_566

logical_and_entry_566:
  br i1 %t567, label %logical_and_right_566, label %logical_and_merge_566

logical_and_right_566:
  %t569 = load i1, i1* %l8
  br label %logical_and_entry_568

logical_and_entry_568:
  br i1 %t569, label %logical_and_right_568, label %logical_and_merge_568

logical_and_right_568:
  %t570 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t571 = load { i8**, i64 }, { i8**, i64 }* %t570
  %t572 = extractvalue { i8**, i64 } %t571, 1
  %t573 = icmp eq i64 %t572, 0
  br label %logical_and_right_end_568

logical_and_right_end_568:
  br label %logical_and_merge_568

logical_and_merge_568:
  %t574 = phi i1 [ false, %logical_and_entry_568 ], [ %t573, %logical_and_right_end_568 ]
  br label %logical_and_right_end_566

logical_and_right_end_566:
  br label %logical_and_merge_566

logical_and_merge_566:
  %t575 = phi i1 [ false, %logical_and_entry_566 ], [ %t574, %logical_and_right_end_566 ]
  br label %logical_and_right_end_564

logical_and_right_end_564:
  br label %logical_and_merge_564

logical_and_merge_564:
  %t576 = phi i1 [ false, %logical_and_entry_564 ], [ %t575, %logical_and_right_end_564 ]
  br label %logical_and_right_end_560

logical_and_right_end_560:
  br label %logical_and_merge_560

logical_and_merge_560:
  %t577 = phi i1 [ false, %logical_and_entry_560 ], [ %t576, %logical_and_right_end_560 ]
  store i1 %t577, i1* %l20
  %t578 = load i8*, i8** %l4
  %t579 = insertvalue %NativeStructLayoutField undef, i8* %t578, 0
  %t580 = load i8*, i8** %l5
  %t581 = insertvalue %NativeStructLayoutField %t579, i8* %t580, 1
  %t582 = load double, double* %l9
  %t583 = insertvalue %NativeStructLayoutField %t581, double %t582, 2
  %t584 = load double, double* %l10
  %t585 = insertvalue %NativeStructLayoutField %t583, double %t584, 3
  %t586 = load double, double* %l11
  %t587 = insertvalue %NativeStructLayoutField %t585, double %t586, 4
  store %NativeStructLayoutField %t587, %NativeStructLayoutField* %l21
  %t588 = load i1, i1* %l20
  %t589 = insertvalue %StructLayoutFieldParse undef, i1 %t588, 0
  %t590 = load %NativeStructLayoutField, %NativeStructLayoutField* %l21
  %t591 = insertvalue %StructLayoutFieldParse %t589, %NativeStructLayoutField %t590, 1
  %t592 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t593 = insertvalue %StructLayoutFieldParse %t591, { i8**, i64 }* %t592, 2
  ret %StructLayoutFieldParse %t593
}

define %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i1
  %l3 = alloca i1
  %l4 = alloca i1
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i1
  %l8 = alloca i1
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca i8*
  %l15 = alloca i8*
  %l16 = alloca %NumberParseResult
  %l17 = alloca i8*
  %l18 = alloca %NumberParseResult
  %l19 = alloca i8*
  %l20 = alloca %NumberParseResult
  %l21 = alloca i8*
  %l22 = alloca %NumberParseResult
  %l23 = alloca i1
  %t0 = call i8* @trim_text(i8* %text)
  %t1 = call { i8**, i64 }* @split_whitespace(i8* %t0)
  store { i8**, i64 }* %t1, { i8**, i64 }** %l0
  %t2 = alloca [0 x i8*]
  %t3 = getelementptr [0 x i8*], [0 x i8*]* %t2, i32 0, i32 0
  %t4 = alloca { i8**, i64 }
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t4, i32 0, i32 0
  store i8** %t3, i8*** %t5
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  store { i8**, i64 }* %t4, { i8**, i64 }** %l1
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = load { i8**, i64 }, { i8**, i64 }* %t7
  %t9 = extractvalue { i8**, i64 } %t8, 1
  %t10 = icmp eq i64 %t9, 0
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t10, label %then0, label %merge1
then0:
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s14 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.len34.h183092327, i32 0, i32 0
  %t15 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t13, i8* %s14)
  store { i8**, i64 }* %t15, { i8**, i64 }** %l1
  %t16 = insertvalue %EnumLayoutHeaderParse undef, i1 0, 0
  %s17 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t18 = insertvalue %EnumLayoutHeaderParse %t16, i8* %s17, 1
  %t19 = sitofp i64 0 to double
  %t20 = insertvalue %EnumLayoutHeaderParse %t18, double %t19, 2
  %t21 = sitofp i64 0 to double
  %t22 = insertvalue %EnumLayoutHeaderParse %t20, double %t21, 3
  %s23 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t24 = insertvalue %EnumLayoutHeaderParse %t22, i8* %s23, 4
  %t25 = sitofp i64 0 to double
  %t26 = insertvalue %EnumLayoutHeaderParse %t24, double %t25, 5
  %t27 = sitofp i64 0 to double
  %t28 = insertvalue %EnumLayoutHeaderParse %t26, double %t27, 6
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t30 = insertvalue %EnumLayoutHeaderParse %t28, { i8**, i64 }* %t29, 7
  ret %EnumLayoutHeaderParse %t30
merge1:
  store i1 0, i1* %l2
  store i1 0, i1* %l3
  store i1 0, i1* %l4
  %s31 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s31, i8** %l5
  %s32 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s32, i8** %l6
  store i1 0, i1* %l7
  store i1 0, i1* %l8
  %t33 = sitofp i64 0 to double
  store double %t33, double* %l9
  %t34 = sitofp i64 0 to double
  store double %t34, double* %l10
  %t35 = sitofp i64 0 to double
  store double %t35, double* %l11
  %t36 = sitofp i64 0 to double
  store double %t36, double* %l12
  %t37 = sitofp i64 0 to double
  store double %t37, double* %l13
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t40 = load i1, i1* %l2
  %t41 = load i1, i1* %l3
  %t42 = load i1, i1* %l4
  %t43 = load i8*, i8** %l5
  %t44 = load i8*, i8** %l6
  %t45 = load i1, i1* %l7
  %t46 = load i1, i1* %l8
  %t47 = load double, double* %l9
  %t48 = load double, double* %l10
  %t49 = load double, double* %l11
  %t50 = load double, double* %l12
  %t51 = load double, double* %l13
  br label %loop.header2
loop.header2:
  %t504 = phi i8* [ %t43, %merge1 ], [ %t491, %loop.latch4 ]
  %t505 = phi i1 [ %t40, %merge1 ], [ %t492, %loop.latch4 ]
  %t506 = phi i1 [ %t41, %merge1 ], [ %t493, %loop.latch4 ]
  %t507 = phi double [ %t47, %merge1 ], [ %t494, %loop.latch4 ]
  %t508 = phi { i8**, i64 }* [ %t39, %merge1 ], [ %t495, %loop.latch4 ]
  %t509 = phi i1 [ %t42, %merge1 ], [ %t496, %loop.latch4 ]
  %t510 = phi double [ %t48, %merge1 ], [ %t497, %loop.latch4 ]
  %t511 = phi i8* [ %t44, %merge1 ], [ %t498, %loop.latch4 ]
  %t512 = phi i1 [ %t45, %merge1 ], [ %t499, %loop.latch4 ]
  %t513 = phi double [ %t49, %merge1 ], [ %t500, %loop.latch4 ]
  %t514 = phi i1 [ %t46, %merge1 ], [ %t501, %loop.latch4 ]
  %t515 = phi double [ %t50, %merge1 ], [ %t502, %loop.latch4 ]
  %t516 = phi double [ %t51, %merge1 ], [ %t503, %loop.latch4 ]
  store i8* %t504, i8** %l5
  store i1 %t505, i1* %l2
  store i1 %t506, i1* %l3
  store double %t507, double* %l9
  store { i8**, i64 }* %t508, { i8**, i64 }** %l1
  store i1 %t509, i1* %l4
  store double %t510, double* %l10
  store i8* %t511, i8** %l6
  store i1 %t512, i1* %l7
  store double %t513, double* %l11
  store i1 %t514, i1* %l8
  store double %t515, double* %l12
  store double %t516, double* %l13
  br label %loop.body3
loop.body3:
  %t52 = load double, double* %l13
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load { i8**, i64 }, { i8**, i64 }* %t53
  %t55 = extractvalue { i8**, i64 } %t54, 1
  %t56 = sitofp i64 %t55 to double
  %t57 = fcmp oge double %t52, %t56
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t60 = load i1, i1* %l2
  %t61 = load i1, i1* %l3
  %t62 = load i1, i1* %l4
  %t63 = load i8*, i8** %l5
  %t64 = load i8*, i8** %l6
  %t65 = load i1, i1* %l7
  %t66 = load i1, i1* %l8
  %t67 = load double, double* %l9
  %t68 = load double, double* %l10
  %t69 = load double, double* %l11
  %t70 = load double, double* %l12
  %t71 = load double, double* %l13
  br i1 %t57, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t73 = load double, double* %l13
  %t74 = fptosi double %t73 to i64
  %t75 = load { i8**, i64 }, { i8**, i64 }* %t72
  %t76 = extractvalue { i8**, i64 } %t75, 0
  %t77 = extractvalue { i8**, i64 } %t75, 1
  %t78 = icmp uge i64 %t74, %t77
  ; bounds check: %t78 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t74, i64 %t77)
  %t79 = getelementptr i8*, i8** %t76, i64 %t74
  %t80 = load i8*, i8** %t79
  store i8* %t80, i8** %l14
  %t81 = load i8*, i8** %l14
  %s82 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h261048910, i32 0, i32 0
  %t83 = call i1 @starts_with(i8* %t81, i8* %s82)
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t86 = load i1, i1* %l2
  %t87 = load i1, i1* %l3
  %t88 = load i1, i1* %l4
  %t89 = load i8*, i8** %l5
  %t90 = load i8*, i8** %l6
  %t91 = load i1, i1* %l7
  %t92 = load i1, i1* %l8
  %t93 = load double, double* %l9
  %t94 = load double, double* %l10
  %t95 = load double, double* %l11
  %t96 = load double, double* %l12
  %t97 = load double, double* %l13
  %t98 = load i8*, i8** %l14
  br i1 %t83, label %then8, label %else9
then8:
  %t99 = load i8*, i8** %l14
  %t100 = load i8*, i8** %l14
  %t101 = call i64 @sailfin_runtime_string_length(i8* %t100)
  %t102 = call i8* @sailfin_runtime_substring(i8* %t99, i64 5, i64 %t101)
  store i8* %t102, i8** %l5
  store i1 1, i1* %l2
  %t103 = load i8*, i8** %l5
  %t104 = load i1, i1* %l2
  br label %merge10
else9:
  %t105 = load i8*, i8** %l14
  %s106 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h466680424, i32 0, i32 0
  %t107 = call i1 @starts_with(i8* %t105, i8* %s106)
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t110 = load i1, i1* %l2
  %t111 = load i1, i1* %l3
  %t112 = load i1, i1* %l4
  %t113 = load i8*, i8** %l5
  %t114 = load i8*, i8** %l6
  %t115 = load i1, i1* %l7
  %t116 = load i1, i1* %l8
  %t117 = load double, double* %l9
  %t118 = load double, double* %l10
  %t119 = load double, double* %l11
  %t120 = load double, double* %l12
  %t121 = load double, double* %l13
  %t122 = load i8*, i8** %l14
  br i1 %t107, label %then11, label %else12
then11:
  %t123 = load i8*, i8** %l14
  %t124 = load i8*, i8** %l14
  %t125 = call i64 @sailfin_runtime_string_length(i8* %t124)
  %t126 = call i8* @sailfin_runtime_substring(i8* %t123, i64 5, i64 %t125)
  store i8* %t126, i8** %l15
  %t127 = load i8*, i8** %l15
  %t128 = call %NumberParseResult @parse_decimal_number(i8* %t127)
  store %NumberParseResult %t128, %NumberParseResult* %l16
  %t129 = load %NumberParseResult, %NumberParseResult* %l16
  %t130 = extractvalue %NumberParseResult %t129, 0
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t133 = load i1, i1* %l2
  %t134 = load i1, i1* %l3
  %t135 = load i1, i1* %l4
  %t136 = load i8*, i8** %l5
  %t137 = load i8*, i8** %l6
  %t138 = load i1, i1* %l7
  %t139 = load i1, i1* %l8
  %t140 = load double, double* %l9
  %t141 = load double, double* %l10
  %t142 = load double, double* %l11
  %t143 = load double, double* %l12
  %t144 = load double, double* %l13
  %t145 = load i8*, i8** %l14
  %t146 = load i8*, i8** %l15
  %t147 = load %NumberParseResult, %NumberParseResult* %l16
  br i1 %t130, label %then14, label %else15
then14:
  store i1 1, i1* %l3
  %t148 = load %NumberParseResult, %NumberParseResult* %l16
  %t149 = extractvalue %NumberParseResult %t148, 1
  store double %t149, double* %l9
  %t150 = load i1, i1* %l3
  %t151 = load double, double* %l9
  br label %merge16
else15:
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s153 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.len37.h1581468287, i32 0, i32 0
  %t154 = load i8*, i8** %l15
  %t155 = call i8* @sailfin_runtime_string_concat(i8* %s153, i8* %t154)
  %t156 = load i8, i8* %t155
  %t157 = add i8 %t156, 96
  %t158 = alloca [2 x i8], align 1
  %t159 = getelementptr [2 x i8], [2 x i8]* %t158, i32 0, i32 0
  store i8 %t157, i8* %t159
  %t160 = getelementptr [2 x i8], [2 x i8]* %t158, i32 0, i32 1
  store i8 0, i8* %t160
  %t161 = getelementptr [2 x i8], [2 x i8]* %t158, i32 0, i32 0
  %t162 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t152, i8* %t161)
  store { i8**, i64 }* %t162, { i8**, i64 }** %l1
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge16
merge16:
  %t164 = phi i1 [ %t150, %then14 ], [ %t134, %else15 ]
  %t165 = phi double [ %t151, %then14 ], [ %t140, %else15 ]
  %t166 = phi { i8**, i64 }* [ %t132, %then14 ], [ %t163, %else15 ]
  store i1 %t164, i1* %l3
  store double %t165, double* %l9
  store { i8**, i64 }* %t166, { i8**, i64 }** %l1
  %t167 = load i1, i1* %l3
  %t168 = load double, double* %l9
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge13
else12:
  %t170 = load i8*, i8** %l14
  %s171 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h841337749, i32 0, i32 0
  %t172 = call i1 @starts_with(i8* %t170, i8* %s171)
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t175 = load i1, i1* %l2
  %t176 = load i1, i1* %l3
  %t177 = load i1, i1* %l4
  %t178 = load i8*, i8** %l5
  %t179 = load i8*, i8** %l6
  %t180 = load i1, i1* %l7
  %t181 = load i1, i1* %l8
  %t182 = load double, double* %l9
  %t183 = load double, double* %l10
  %t184 = load double, double* %l11
  %t185 = load double, double* %l12
  %t186 = load double, double* %l13
  %t187 = load i8*, i8** %l14
  br i1 %t172, label %then17, label %else18
then17:
  %t188 = load i8*, i8** %l14
  %t189 = load i8*, i8** %l14
  %t190 = call i64 @sailfin_runtime_string_length(i8* %t189)
  %t191 = call i8* @sailfin_runtime_substring(i8* %t188, i64 6, i64 %t190)
  store i8* %t191, i8** %l17
  %t192 = load i8*, i8** %l17
  %t193 = call %NumberParseResult @parse_decimal_number(i8* %t192)
  store %NumberParseResult %t193, %NumberParseResult* %l18
  %t194 = load %NumberParseResult, %NumberParseResult* %l18
  %t195 = extractvalue %NumberParseResult %t194, 0
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t198 = load i1, i1* %l2
  %t199 = load i1, i1* %l3
  %t200 = load i1, i1* %l4
  %t201 = load i8*, i8** %l5
  %t202 = load i8*, i8** %l6
  %t203 = load i1, i1* %l7
  %t204 = load i1, i1* %l8
  %t205 = load double, double* %l9
  %t206 = load double, double* %l10
  %t207 = load double, double* %l11
  %t208 = load double, double* %l12
  %t209 = load double, double* %l13
  %t210 = load i8*, i8** %l14
  %t211 = load i8*, i8** %l17
  %t212 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t195, label %then20, label %else21
then20:
  store i1 1, i1* %l4
  %t213 = load %NumberParseResult, %NumberParseResult* %l18
  %t214 = extractvalue %NumberParseResult %t213, 1
  store double %t214, double* %l10
  %t215 = load i1, i1* %l4
  %t216 = load double, double* %l10
  br label %merge22
else21:
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s218 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.len38.h1235260132, i32 0, i32 0
  %t219 = load i8*, i8** %l17
  %t220 = call i8* @sailfin_runtime_string_concat(i8* %s218, i8* %t219)
  %t221 = load i8, i8* %t220
  %t222 = add i8 %t221, 96
  %t223 = alloca [2 x i8], align 1
  %t224 = getelementptr [2 x i8], [2 x i8]* %t223, i32 0, i32 0
  store i8 %t222, i8* %t224
  %t225 = getelementptr [2 x i8], [2 x i8]* %t223, i32 0, i32 1
  store i8 0, i8* %t225
  %t226 = getelementptr [2 x i8], [2 x i8]* %t223, i32 0, i32 0
  %t227 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t217, i8* %t226)
  store { i8**, i64 }* %t227, { i8**, i64 }** %l1
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge22
merge22:
  %t229 = phi i1 [ %t215, %then20 ], [ %t200, %else21 ]
  %t230 = phi double [ %t216, %then20 ], [ %t206, %else21 ]
  %t231 = phi { i8**, i64 }* [ %t197, %then20 ], [ %t228, %else21 ]
  store i1 %t229, i1* %l4
  store double %t230, double* %l10
  store { i8**, i64 }* %t231, { i8**, i64 }** %l1
  %t232 = load i1, i1* %l4
  %t233 = load double, double* %l10
  %t234 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge19
else18:
  %t235 = load i8*, i8** %l14
  %s236 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1228988541, i32 0, i32 0
  %t237 = call i1 @starts_with(i8* %t235, i8* %s236)
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t240 = load i1, i1* %l2
  %t241 = load i1, i1* %l3
  %t242 = load i1, i1* %l4
  %t243 = load i8*, i8** %l5
  %t244 = load i8*, i8** %l6
  %t245 = load i1, i1* %l7
  %t246 = load i1, i1* %l8
  %t247 = load double, double* %l9
  %t248 = load double, double* %l10
  %t249 = load double, double* %l11
  %t250 = load double, double* %l12
  %t251 = load double, double* %l13
  %t252 = load i8*, i8** %l14
  br i1 %t237, label %then23, label %else24
then23:
  %t253 = load i8*, i8** %l14
  %t254 = load i8*, i8** %l14
  %t255 = call i64 @sailfin_runtime_string_length(i8* %t254)
  %t256 = call i8* @sailfin_runtime_substring(i8* %t253, i64 9, i64 %t255)
  store i8* %t256, i8** %l6
  %t257 = load i8*, i8** %l6
  br label %merge25
else24:
  %t258 = load i8*, i8** %l14
  %s259 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1171237782, i32 0, i32 0
  %t260 = call i1 @starts_with(i8* %t258, i8* %s259)
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t262 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t263 = load i1, i1* %l2
  %t264 = load i1, i1* %l3
  %t265 = load i1, i1* %l4
  %t266 = load i8*, i8** %l5
  %t267 = load i8*, i8** %l6
  %t268 = load i1, i1* %l7
  %t269 = load i1, i1* %l8
  %t270 = load double, double* %l9
  %t271 = load double, double* %l10
  %t272 = load double, double* %l11
  %t273 = load double, double* %l12
  %t274 = load double, double* %l13
  %t275 = load i8*, i8** %l14
  br i1 %t260, label %then26, label %else27
then26:
  %t276 = load i8*, i8** %l14
  %t277 = load i8*, i8** %l14
  %t278 = call i64 @sailfin_runtime_string_length(i8* %t277)
  %t279 = call i8* @sailfin_runtime_substring(i8* %t276, i64 9, i64 %t278)
  store i8* %t279, i8** %l19
  %t280 = load i8*, i8** %l19
  %t281 = call %NumberParseResult @parse_decimal_number(i8* %t280)
  store %NumberParseResult %t281, %NumberParseResult* %l20
  %t282 = load %NumberParseResult, %NumberParseResult* %l20
  %t283 = extractvalue %NumberParseResult %t282, 0
  %t284 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t285 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t286 = load i1, i1* %l2
  %t287 = load i1, i1* %l3
  %t288 = load i1, i1* %l4
  %t289 = load i8*, i8** %l5
  %t290 = load i8*, i8** %l6
  %t291 = load i1, i1* %l7
  %t292 = load i1, i1* %l8
  %t293 = load double, double* %l9
  %t294 = load double, double* %l10
  %t295 = load double, double* %l11
  %t296 = load double, double* %l12
  %t297 = load double, double* %l13
  %t298 = load i8*, i8** %l14
  %t299 = load i8*, i8** %l19
  %t300 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t283, label %then29, label %else30
then29:
  store i1 1, i1* %l7
  %t301 = load %NumberParseResult, %NumberParseResult* %l20
  %t302 = extractvalue %NumberParseResult %t301, 1
  store double %t302, double* %l11
  %t303 = load i1, i1* %l7
  %t304 = load double, double* %l11
  br label %merge31
else30:
  %t305 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s306 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h1384306956, i32 0, i32 0
  %t307 = load i8*, i8** %l19
  %t308 = call i8* @sailfin_runtime_string_concat(i8* %s306, i8* %t307)
  %t309 = load i8, i8* %t308
  %t310 = add i8 %t309, 96
  %t311 = alloca [2 x i8], align 1
  %t312 = getelementptr [2 x i8], [2 x i8]* %t311, i32 0, i32 0
  store i8 %t310, i8* %t312
  %t313 = getelementptr [2 x i8], [2 x i8]* %t311, i32 0, i32 1
  store i8 0, i8* %t313
  %t314 = getelementptr [2 x i8], [2 x i8]* %t311, i32 0, i32 0
  %t315 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t305, i8* %t314)
  store { i8**, i64 }* %t315, { i8**, i64 }** %l1
  %t316 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge31
merge31:
  %t317 = phi i1 [ %t303, %then29 ], [ %t291, %else30 ]
  %t318 = phi double [ %t304, %then29 ], [ %t295, %else30 ]
  %t319 = phi { i8**, i64 }* [ %t285, %then29 ], [ %t316, %else30 ]
  store i1 %t317, i1* %l7
  store double %t318, double* %l11
  store { i8**, i64 }* %t319, { i8**, i64 }** %l1
  %t320 = load i1, i1* %l7
  %t321 = load double, double* %l11
  %t322 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge28
else27:
  %t323 = load i8*, i8** %l14
  %s324 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h469410318, i32 0, i32 0
  %t325 = call i1 @starts_with(i8* %t323, i8* %s324)
  %t326 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t327 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t328 = load i1, i1* %l2
  %t329 = load i1, i1* %l3
  %t330 = load i1, i1* %l4
  %t331 = load i8*, i8** %l5
  %t332 = load i8*, i8** %l6
  %t333 = load i1, i1* %l7
  %t334 = load i1, i1* %l8
  %t335 = load double, double* %l9
  %t336 = load double, double* %l10
  %t337 = load double, double* %l11
  %t338 = load double, double* %l12
  %t339 = load double, double* %l13
  %t340 = load i8*, i8** %l14
  br i1 %t325, label %then32, label %else33
then32:
  %t341 = load i8*, i8** %l14
  %t342 = load i8*, i8** %l14
  %t343 = call i64 @sailfin_runtime_string_length(i8* %t342)
  %t344 = call i8* @sailfin_runtime_substring(i8* %t341, i64 10, i64 %t343)
  store i8* %t344, i8** %l21
  %t345 = load i8*, i8** %l21
  %t346 = call %NumberParseResult @parse_decimal_number(i8* %t345)
  store %NumberParseResult %t346, %NumberParseResult* %l22
  %t347 = load %NumberParseResult, %NumberParseResult* %l22
  %t348 = extractvalue %NumberParseResult %t347, 0
  %t349 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t350 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t351 = load i1, i1* %l2
  %t352 = load i1, i1* %l3
  %t353 = load i1, i1* %l4
  %t354 = load i8*, i8** %l5
  %t355 = load i8*, i8** %l6
  %t356 = load i1, i1* %l7
  %t357 = load i1, i1* %l8
  %t358 = load double, double* %l9
  %t359 = load double, double* %l10
  %t360 = load double, double* %l11
  %t361 = load double, double* %l12
  %t362 = load double, double* %l13
  %t363 = load i8*, i8** %l14
  %t364 = load i8*, i8** %l21
  %t365 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t348, label %then35, label %else36
then35:
  store i1 1, i1* %l8
  %t366 = load %NumberParseResult, %NumberParseResult* %l22
  %t367 = extractvalue %NumberParseResult %t366, 1
  store double %t367, double* %l12
  %t368 = load i1, i1* %l8
  %t369 = load double, double* %l12
  br label %merge37
else36:
  %t370 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s371 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.len42.h1171387022, i32 0, i32 0
  %t372 = load i8*, i8** %l21
  %t373 = call i8* @sailfin_runtime_string_concat(i8* %s371, i8* %t372)
  %t374 = load i8, i8* %t373
  %t375 = add i8 %t374, 96
  %t376 = alloca [2 x i8], align 1
  %t377 = getelementptr [2 x i8], [2 x i8]* %t376, i32 0, i32 0
  store i8 %t375, i8* %t377
  %t378 = getelementptr [2 x i8], [2 x i8]* %t376, i32 0, i32 1
  store i8 0, i8* %t378
  %t379 = getelementptr [2 x i8], [2 x i8]* %t376, i32 0, i32 0
  %t380 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t370, i8* %t379)
  store { i8**, i64 }* %t380, { i8**, i64 }** %l1
  %t381 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge37
merge37:
  %t382 = phi i1 [ %t368, %then35 ], [ %t357, %else36 ]
  %t383 = phi double [ %t369, %then35 ], [ %t361, %else36 ]
  %t384 = phi { i8**, i64 }* [ %t350, %then35 ], [ %t381, %else36 ]
  store i1 %t382, i1* %l8
  store double %t383, double* %l12
  store { i8**, i64 }* %t384, { i8**, i64 }** %l1
  %t385 = load i1, i1* %l8
  %t386 = load double, double* %l12
  %t387 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge34
else33:
  %t388 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s389 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h598838653, i32 0, i32 0
  %t390 = load i8*, i8** %l14
  %t391 = call i8* @sailfin_runtime_string_concat(i8* %s389, i8* %t390)
  %t392 = load i8, i8* %t391
  %t393 = add i8 %t392, 96
  %t394 = alloca [2 x i8], align 1
  %t395 = getelementptr [2 x i8], [2 x i8]* %t394, i32 0, i32 0
  store i8 %t393, i8* %t395
  %t396 = getelementptr [2 x i8], [2 x i8]* %t394, i32 0, i32 1
  store i8 0, i8* %t396
  %t397 = getelementptr [2 x i8], [2 x i8]* %t394, i32 0, i32 0
  %t398 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t388, i8* %t397)
  store { i8**, i64 }* %t398, { i8**, i64 }** %l1
  %t399 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t400 = phi i1 [ %t385, %merge37 ], [ %t334, %else33 ]
  %t401 = phi double [ %t386, %merge37 ], [ %t338, %else33 ]
  %t402 = phi { i8**, i64 }* [ %t387, %merge37 ], [ %t399, %else33 ]
  store i1 %t400, i1* %l8
  store double %t401, double* %l12
  store { i8**, i64 }* %t402, { i8**, i64 }** %l1
  %t403 = load i1, i1* %l8
  %t404 = load double, double* %l12
  %t405 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t406 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge28
merge28:
  %t407 = phi i1 [ %t320, %merge31 ], [ %t268, %merge34 ]
  %t408 = phi double [ %t321, %merge31 ], [ %t272, %merge34 ]
  %t409 = phi { i8**, i64 }* [ %t322, %merge31 ], [ %t405, %merge34 ]
  %t410 = phi i1 [ %t269, %merge31 ], [ %t403, %merge34 ]
  %t411 = phi double [ %t273, %merge31 ], [ %t404, %merge34 ]
  store i1 %t407, i1* %l7
  store double %t408, double* %l11
  store { i8**, i64 }* %t409, { i8**, i64 }** %l1
  store i1 %t410, i1* %l8
  store double %t411, double* %l12
  %t412 = load i1, i1* %l7
  %t413 = load double, double* %l11
  %t414 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t415 = load i1, i1* %l8
  %t416 = load double, double* %l12
  %t417 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t418 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge25
merge25:
  %t419 = phi i8* [ %t257, %then23 ], [ %t244, %merge28 ]
  %t420 = phi i1 [ %t245, %then23 ], [ %t412, %merge28 ]
  %t421 = phi double [ %t249, %then23 ], [ %t413, %merge28 ]
  %t422 = phi { i8**, i64 }* [ %t239, %then23 ], [ %t414, %merge28 ]
  %t423 = phi i1 [ %t246, %then23 ], [ %t415, %merge28 ]
  %t424 = phi double [ %t250, %then23 ], [ %t416, %merge28 ]
  store i8* %t419, i8** %l6
  store i1 %t420, i1* %l7
  store double %t421, double* %l11
  store { i8**, i64 }* %t422, { i8**, i64 }** %l1
  store i1 %t423, i1* %l8
  store double %t424, double* %l12
  %t425 = load i8*, i8** %l6
  %t426 = load i1, i1* %l7
  %t427 = load double, double* %l11
  %t428 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t429 = load i1, i1* %l8
  %t430 = load double, double* %l12
  %t431 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t432 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t433 = phi i1 [ %t232, %merge22 ], [ %t177, %merge25 ]
  %t434 = phi double [ %t233, %merge22 ], [ %t183, %merge25 ]
  %t435 = phi { i8**, i64 }* [ %t234, %merge22 ], [ %t428, %merge25 ]
  %t436 = phi i8* [ %t179, %merge22 ], [ %t425, %merge25 ]
  %t437 = phi i1 [ %t180, %merge22 ], [ %t426, %merge25 ]
  %t438 = phi double [ %t184, %merge22 ], [ %t427, %merge25 ]
  %t439 = phi i1 [ %t181, %merge22 ], [ %t429, %merge25 ]
  %t440 = phi double [ %t185, %merge22 ], [ %t430, %merge25 ]
  store i1 %t433, i1* %l4
  store double %t434, double* %l10
  store { i8**, i64 }* %t435, { i8**, i64 }** %l1
  store i8* %t436, i8** %l6
  store i1 %t437, i1* %l7
  store double %t438, double* %l11
  store i1 %t439, i1* %l8
  store double %t440, double* %l12
  %t441 = load i1, i1* %l4
  %t442 = load double, double* %l10
  %t443 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t444 = load i8*, i8** %l6
  %t445 = load i1, i1* %l7
  %t446 = load double, double* %l11
  %t447 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t448 = load i1, i1* %l8
  %t449 = load double, double* %l12
  %t450 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t451 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge13
merge13:
  %t452 = phi i1 [ %t167, %merge16 ], [ %t111, %merge19 ]
  %t453 = phi double [ %t168, %merge16 ], [ %t117, %merge19 ]
  %t454 = phi { i8**, i64 }* [ %t169, %merge16 ], [ %t443, %merge19 ]
  %t455 = phi i1 [ %t112, %merge16 ], [ %t441, %merge19 ]
  %t456 = phi double [ %t118, %merge16 ], [ %t442, %merge19 ]
  %t457 = phi i8* [ %t114, %merge16 ], [ %t444, %merge19 ]
  %t458 = phi i1 [ %t115, %merge16 ], [ %t445, %merge19 ]
  %t459 = phi double [ %t119, %merge16 ], [ %t446, %merge19 ]
  %t460 = phi i1 [ %t116, %merge16 ], [ %t448, %merge19 ]
  %t461 = phi double [ %t120, %merge16 ], [ %t449, %merge19 ]
  store i1 %t452, i1* %l3
  store double %t453, double* %l9
  store { i8**, i64 }* %t454, { i8**, i64 }** %l1
  store i1 %t455, i1* %l4
  store double %t456, double* %l10
  store i8* %t457, i8** %l6
  store i1 %t458, i1* %l7
  store double %t459, double* %l11
  store i1 %t460, i1* %l8
  store double %t461, double* %l12
  %t462 = load i1, i1* %l3
  %t463 = load double, double* %l9
  %t464 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t465 = load i1, i1* %l4
  %t466 = load double, double* %l10
  %t467 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t468 = load i8*, i8** %l6
  %t469 = load i1, i1* %l7
  %t470 = load double, double* %l11
  %t471 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t472 = load i1, i1* %l8
  %t473 = load double, double* %l12
  %t474 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t475 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge10
merge10:
  %t476 = phi i8* [ %t103, %then8 ], [ %t89, %merge13 ]
  %t477 = phi i1 [ %t104, %then8 ], [ %t86, %merge13 ]
  %t478 = phi i1 [ %t87, %then8 ], [ %t462, %merge13 ]
  %t479 = phi double [ %t93, %then8 ], [ %t463, %merge13 ]
  %t480 = phi { i8**, i64 }* [ %t85, %then8 ], [ %t464, %merge13 ]
  %t481 = phi i1 [ %t88, %then8 ], [ %t465, %merge13 ]
  %t482 = phi double [ %t94, %then8 ], [ %t466, %merge13 ]
  %t483 = phi i8* [ %t90, %then8 ], [ %t468, %merge13 ]
  %t484 = phi i1 [ %t91, %then8 ], [ %t469, %merge13 ]
  %t485 = phi double [ %t95, %then8 ], [ %t470, %merge13 ]
  %t486 = phi i1 [ %t92, %then8 ], [ %t472, %merge13 ]
  %t487 = phi double [ %t96, %then8 ], [ %t473, %merge13 ]
  store i8* %t476, i8** %l5
  store i1 %t477, i1* %l2
  store i1 %t478, i1* %l3
  store double %t479, double* %l9
  store { i8**, i64 }* %t480, { i8**, i64 }** %l1
  store i1 %t481, i1* %l4
  store double %t482, double* %l10
  store i8* %t483, i8** %l6
  store i1 %t484, i1* %l7
  store double %t485, double* %l11
  store i1 %t486, i1* %l8
  store double %t487, double* %l12
  %t488 = load double, double* %l13
  %t489 = sitofp i64 1 to double
  %t490 = fadd double %t488, %t489
  store double %t490, double* %l13
  br label %loop.latch4
loop.latch4:
  %t491 = load i8*, i8** %l5
  %t492 = load i1, i1* %l2
  %t493 = load i1, i1* %l3
  %t494 = load double, double* %l9
  %t495 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t496 = load i1, i1* %l4
  %t497 = load double, double* %l10
  %t498 = load i8*, i8** %l6
  %t499 = load i1, i1* %l7
  %t500 = load double, double* %l11
  %t501 = load i1, i1* %l8
  %t502 = load double, double* %l12
  %t503 = load double, double* %l13
  br label %loop.header2
afterloop5:
  %t517 = load i8*, i8** %l5
  %t518 = load i1, i1* %l2
  %t519 = load i1, i1* %l3
  %t520 = load double, double* %l9
  %t521 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t522 = load i1, i1* %l4
  %t523 = load double, double* %l10
  %t524 = load i8*, i8** %l6
  %t525 = load i1, i1* %l7
  %t526 = load double, double* %l11
  %t527 = load i1, i1* %l8
  %t528 = load double, double* %l12
  %t529 = load double, double* %l13
  %t530 = load i1, i1* %l3
  %t531 = xor i1 %t530, 1
  %t532 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t533 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t534 = load i1, i1* %l2
  %t535 = load i1, i1* %l3
  %t536 = load i1, i1* %l4
  %t537 = load i8*, i8** %l5
  %t538 = load i8*, i8** %l6
  %t539 = load i1, i1* %l7
  %t540 = load i1, i1* %l8
  %t541 = load double, double* %l9
  %t542 = load double, double* %l10
  %t543 = load double, double* %l11
  %t544 = load double, double* %l12
  %t545 = load double, double* %l13
  br i1 %t531, label %then38, label %merge39
then38:
  %t546 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s547 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.len37.h2038142650, i32 0, i32 0
  %t548 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t546, i8* %s547)
  store { i8**, i64 }* %t548, { i8**, i64 }** %l1
  %t549 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t550 = phi { i8**, i64 }* [ %t549, %then38 ], [ %t533, %afterloop5 ]
  store { i8**, i64 }* %t550, { i8**, i64 }** %l1
  %t551 = load i1, i1* %l4
  %t552 = xor i1 %t551, 1
  %t553 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t554 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t555 = load i1, i1* %l2
  %t556 = load i1, i1* %l3
  %t557 = load i1, i1* %l4
  %t558 = load i8*, i8** %l5
  %t559 = load i8*, i8** %l6
  %t560 = load i1, i1* %l7
  %t561 = load i1, i1* %l8
  %t562 = load double, double* %l9
  %t563 = load double, double* %l10
  %t564 = load double, double* %l11
  %t565 = load double, double* %l12
  %t566 = load double, double* %l13
  br i1 %t552, label %then40, label %merge41
then40:
  %t567 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s568 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.len38.h2050661185, i32 0, i32 0
  %t569 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t567, i8* %s568)
  store { i8**, i64 }* %t569, { i8**, i64 }** %l1
  %t570 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t571 = phi { i8**, i64 }* [ %t570, %then40 ], [ %t554, %merge39 ]
  store { i8**, i64 }* %t571, { i8**, i64 }** %l1
  %t572 = load i8*, i8** %l6
  %t573 = call i64 @sailfin_runtime_string_length(i8* %t572)
  %t574 = icmp eq i64 %t573, 0
  %t575 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t576 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t577 = load i1, i1* %l2
  %t578 = load i1, i1* %l3
  %t579 = load i1, i1* %l4
  %t580 = load i8*, i8** %l5
  %t581 = load i8*, i8** %l6
  %t582 = load i1, i1* %l7
  %t583 = load i1, i1* %l8
  %t584 = load double, double* %l9
  %t585 = load double, double* %l10
  %t586 = load double, double* %l11
  %t587 = load double, double* %l12
  %t588 = load double, double* %l13
  br i1 %t574, label %then42, label %merge43
then42:
  %t589 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s590 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h881857818, i32 0, i32 0
  %t591 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t589, i8* %s590)
  store { i8**, i64 }* %t591, { i8**, i64 }** %l1
  %t592 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t593 = phi { i8**, i64 }* [ %t592, %then42 ], [ %t576, %merge41 ]
  store { i8**, i64 }* %t593, { i8**, i64 }** %l1
  %t594 = load i1, i1* %l7
  %t595 = xor i1 %t594, 1
  %t596 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t597 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t598 = load i1, i1* %l2
  %t599 = load i1, i1* %l3
  %t600 = load i1, i1* %l4
  %t601 = load i8*, i8** %l5
  %t602 = load i8*, i8** %l6
  %t603 = load i1, i1* %l7
  %t604 = load i1, i1* %l8
  %t605 = load double, double* %l9
  %t606 = load double, double* %l10
  %t607 = load double, double* %l11
  %t608 = load double, double* %l12
  %t609 = load double, double* %l13
  br i1 %t595, label %then44, label %merge45
then44:
  %t610 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s611 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h2069276858, i32 0, i32 0
  %t612 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t610, i8* %s611)
  store { i8**, i64 }* %t612, { i8**, i64 }** %l1
  %t613 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge45
merge45:
  %t614 = phi { i8**, i64 }* [ %t613, %then44 ], [ %t597, %merge43 ]
  store { i8**, i64 }* %t614, { i8**, i64 }** %l1
  %t615 = load i1, i1* %l8
  %t616 = xor i1 %t615, 1
  %t617 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t618 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t619 = load i1, i1* %l2
  %t620 = load i1, i1* %l3
  %t621 = load i1, i1* %l4
  %t622 = load i8*, i8** %l5
  %t623 = load i8*, i8** %l6
  %t624 = load i1, i1* %l7
  %t625 = load i1, i1* %l8
  %t626 = load double, double* %l9
  %t627 = load double, double* %l10
  %t628 = load double, double* %l11
  %t629 = load double, double* %l12
  %t630 = load double, double* %l13
  br i1 %t616, label %then46, label %merge47
then46:
  %t631 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s632 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.len42.h930606274, i32 0, i32 0
  %t633 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t631, i8* %s632)
  store { i8**, i64 }* %t633, { i8**, i64 }** %l1
  %t634 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge47
merge47:
  %t635 = phi { i8**, i64 }* [ %t634, %then46 ], [ %t618, %merge45 ]
  store { i8**, i64 }* %t635, { i8**, i64 }** %l1
  %t637 = load i1, i1* %l3
  br label %logical_and_entry_636

logical_and_entry_636:
  br i1 %t637, label %logical_and_right_636, label %logical_and_merge_636

logical_and_right_636:
  %t639 = load i1, i1* %l4
  br label %logical_and_entry_638

logical_and_entry_638:
  br i1 %t639, label %logical_and_right_638, label %logical_and_merge_638

logical_and_right_638:
  %t641 = load i8*, i8** %l6
  %t642 = call i64 @sailfin_runtime_string_length(i8* %t641)
  %t643 = icmp sgt i64 %t642, 0
  br label %logical_and_entry_640

logical_and_entry_640:
  br i1 %t643, label %logical_and_right_640, label %logical_and_merge_640

logical_and_right_640:
  %t645 = load i1, i1* %l7
  br label %logical_and_entry_644

logical_and_entry_644:
  br i1 %t645, label %logical_and_right_644, label %logical_and_merge_644

logical_and_right_644:
  %t647 = load i1, i1* %l8
  br label %logical_and_entry_646

logical_and_entry_646:
  br i1 %t647, label %logical_and_right_646, label %logical_and_merge_646

logical_and_right_646:
  %t648 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t649 = load { i8**, i64 }, { i8**, i64 }* %t648
  %t650 = extractvalue { i8**, i64 } %t649, 1
  %t651 = icmp eq i64 %t650, 0
  br label %logical_and_right_end_646

logical_and_right_end_646:
  br label %logical_and_merge_646

logical_and_merge_646:
  %t652 = phi i1 [ false, %logical_and_entry_646 ], [ %t651, %logical_and_right_end_646 ]
  br label %logical_and_right_end_644

logical_and_right_end_644:
  br label %logical_and_merge_644

logical_and_merge_644:
  %t653 = phi i1 [ false, %logical_and_entry_644 ], [ %t652, %logical_and_right_end_644 ]
  br label %logical_and_right_end_640

logical_and_right_end_640:
  br label %logical_and_merge_640

logical_and_merge_640:
  %t654 = phi i1 [ false, %logical_and_entry_640 ], [ %t653, %logical_and_right_end_640 ]
  br label %logical_and_right_end_638

logical_and_right_end_638:
  br label %logical_and_merge_638

logical_and_merge_638:
  %t655 = phi i1 [ false, %logical_and_entry_638 ], [ %t654, %logical_and_right_end_638 ]
  br label %logical_and_right_end_636

logical_and_right_end_636:
  br label %logical_and_merge_636

logical_and_merge_636:
  %t656 = phi i1 [ false, %logical_and_entry_636 ], [ %t655, %logical_and_right_end_636 ]
  store i1 %t656, i1* %l23
  %t657 = load i1, i1* %l23
  %t658 = insertvalue %EnumLayoutHeaderParse undef, i1 %t657, 0
  %t659 = load i8*, i8** %l5
  %t660 = insertvalue %EnumLayoutHeaderParse %t658, i8* %t659, 1
  %t661 = load double, double* %l9
  %t662 = insertvalue %EnumLayoutHeaderParse %t660, double %t661, 2
  %t663 = load double, double* %l10
  %t664 = insertvalue %EnumLayoutHeaderParse %t662, double %t663, 3
  %t665 = load i8*, i8** %l6
  %t666 = insertvalue %EnumLayoutHeaderParse %t664, i8* %t665, 4
  %t667 = load double, double* %l11
  %t668 = insertvalue %EnumLayoutHeaderParse %t666, double %t667, 5
  %t669 = load double, double* %l12
  %t670 = insertvalue %EnumLayoutHeaderParse %t668, double %t669, 6
  %t671 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t672 = insertvalue %EnumLayoutHeaderParse %t670, { i8**, i64 }* %t671, 7
  ret %EnumLayoutHeaderParse %t672
}

define %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %text, i8* %enum_name) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %NativeEnumVariantLayout
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca i8*
  %l5 = alloca i1
  %l6 = alloca i1
  %l7 = alloca i1
  %l8 = alloca i1
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca i8*
  %l15 = alloca i8*
  %l16 = alloca %NumberParseResult
  %l17 = alloca i8*
  %l18 = alloca %NumberParseResult
  %l19 = alloca i8*
  %l20 = alloca %NumberParseResult
  %l21 = alloca i8*
  %l22 = alloca %NumberParseResult
  %l23 = alloca i1
  %l24 = alloca %NativeEnumVariantLayout
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = alloca [0 x i8*]
  %t2 = getelementptr [0 x i8*], [0 x i8*]* %t1, i32 0, i32 0
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t2, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t7 = insertvalue %NativeEnumVariantLayout undef, i8* %s6, 0
  %t8 = sitofp i64 0 to double
  %t9 = insertvalue %NativeEnumVariantLayout %t7, double %t8, 1
  %t10 = sitofp i64 0 to double
  %t11 = insertvalue %NativeEnumVariantLayout %t9, double %t10, 2
  %t12 = sitofp i64 0 to double
  %t13 = insertvalue %NativeEnumVariantLayout %t11, double %t12, 3
  %t14 = sitofp i64 0 to double
  %t15 = insertvalue %NativeEnumVariantLayout %t13, double %t14, 4
  %t16 = alloca [0 x %NativeStructLayoutField*]
  %t17 = getelementptr [0 x %NativeStructLayoutField*], [0 x %NativeStructLayoutField*]* %t16, i32 0, i32 0
  %t18 = alloca { %NativeStructLayoutField**, i64 }
  %t19 = getelementptr { %NativeStructLayoutField**, i64 }, { %NativeStructLayoutField**, i64 }* %t18, i32 0, i32 0
  store %NativeStructLayoutField** %t17, %NativeStructLayoutField*** %t19
  %t20 = getelementptr { %NativeStructLayoutField**, i64 }, { %NativeStructLayoutField**, i64 }* %t18, i32 0, i32 1
  store i64 0, i64* %t20
  %t21 = insertvalue %NativeEnumVariantLayout %t15, { %NativeStructLayoutField**, i64 }* %t18, 5
  store %NativeEnumVariantLayout %t21, %NativeEnumVariantLayout* %l2
  %t22 = load i8*, i8** %l0
  %t23 = call i64 @sailfin_runtime_string_length(i8* %t22)
  %t24 = icmp eq i64 %t23, 0
  %t25 = load i8*, i8** %l0
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t27 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  br i1 %t24, label %then0, label %merge1
then0:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s29 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t30 = call i8* @sailfin_runtime_string_concat(i8* %s29, i8* %enum_name)
  %s31 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1960327680, i32 0, i32 0
  %t32 = call i8* @sailfin_runtime_string_concat(i8* %t30, i8* %s31)
  %t33 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t28, i8* %t32)
  store { i8**, i64 }* %t33, { i8**, i64 }** %l1
  %t34 = insertvalue %EnumLayoutVariantParse undef, i1 0, 0
  %t35 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t36 = insertvalue %EnumLayoutVariantParse %t34, %NativeEnumVariantLayout %t35, 1
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t38 = insertvalue %EnumLayoutVariantParse %t36, { i8**, i64 }* %t37, 2
  ret %EnumLayoutVariantParse %t38
merge1:
  %t39 = load i8*, i8** %l0
  %t40 = call { i8**, i64 }* @split_whitespace(i8* %t39)
  store { i8**, i64 }* %t40, { i8**, i64 }** %l3
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t42 = load { i8**, i64 }, { i8**, i64 }* %t41
  %t43 = extractvalue { i8**, i64 } %t42, 1
  %t44 = icmp eq i64 %t43, 0
  %t45 = load i8*, i8** %l0
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t47 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br i1 %t44, label %then2, label %merge3
then2:
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s50 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t51 = call i8* @sailfin_runtime_string_concat(i8* %s50, i8* %enum_name)
  %s52 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h238974215, i32 0, i32 0
  %t53 = call i8* @sailfin_runtime_string_concat(i8* %t51, i8* %s52)
  %t54 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t49, i8* %t53)
  store { i8**, i64 }* %t54, { i8**, i64 }** %l1
  %t55 = insertvalue %EnumLayoutVariantParse undef, i1 0, 0
  %t56 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t57 = insertvalue %EnumLayoutVariantParse %t55, %NativeEnumVariantLayout %t56, 1
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = insertvalue %EnumLayoutVariantParse %t57, { i8**, i64 }* %t58, 2
  ret %EnumLayoutVariantParse %t59
merge3:
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t61 = load { i8**, i64 }, { i8**, i64 }* %t60
  %t62 = extractvalue { i8**, i64 } %t61, 0
  %t63 = extractvalue { i8**, i64 } %t61, 1
  %t64 = icmp uge i64 0, %t63
  ; bounds check: %t64 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t63)
  %t65 = getelementptr i8*, i8** %t62, i64 0
  %t66 = load i8*, i8** %t65
  store i8* %t66, i8** %l4
  %t67 = load i8*, i8** %l4
  %t68 = call i64 @sailfin_runtime_string_length(i8* %t67)
  %t69 = icmp eq i64 %t68, 0
  %t70 = load i8*, i8** %l0
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t72 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t74 = load i8*, i8** %l4
  br i1 %t69, label %then4, label %merge5
then4:
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s76 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t77 = call i8* @sailfin_runtime_string_concat(i8* %s76, i8* %enum_name)
  %s78 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h1605654048, i32 0, i32 0
  %t79 = call i8* @sailfin_runtime_string_concat(i8* %t77, i8* %s78)
  %t80 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t75, i8* %t79)
  store { i8**, i64 }* %t80, { i8**, i64 }** %l1
  %t81 = insertvalue %EnumLayoutVariantParse undef, i1 0, 0
  %t82 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t83 = insertvalue %EnumLayoutVariantParse %t81, %NativeEnumVariantLayout %t82, 1
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t85 = insertvalue %EnumLayoutVariantParse %t83, { i8**, i64 }* %t84, 2
  ret %EnumLayoutVariantParse %t85
merge5:
  store i1 0, i1* %l5
  store i1 0, i1* %l6
  store i1 0, i1* %l7
  store i1 0, i1* %l8
  %t86 = sitofp i64 0 to double
  store double %t86, double* %l9
  %t87 = sitofp i64 0 to double
  store double %t87, double* %l10
  %t88 = sitofp i64 0 to double
  store double %t88, double* %l11
  %t89 = sitofp i64 0 to double
  store double %t89, double* %l12
  %t90 = sitofp i64 1 to double
  store double %t90, double* %l13
  %t91 = load i8*, i8** %l0
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t93 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t95 = load i8*, i8** %l4
  %t96 = load i1, i1* %l5
  %t97 = load i1, i1* %l6
  %t98 = load i1, i1* %l7
  %t99 = load i1, i1* %l8
  %t100 = load double, double* %l9
  %t101 = load double, double* %l10
  %t102 = load double, double* %l11
  %t103 = load double, double* %l12
  %t104 = load double, double* %l13
  br label %loop.header6
loop.header6:
  %t499 = phi i1 [ %t96, %merge5 ], [ %t489, %loop.latch8 ]
  %t500 = phi double [ %t100, %merge5 ], [ %t490, %loop.latch8 ]
  %t501 = phi { i8**, i64 }* [ %t92, %merge5 ], [ %t491, %loop.latch8 ]
  %t502 = phi i1 [ %t97, %merge5 ], [ %t492, %loop.latch8 ]
  %t503 = phi double [ %t101, %merge5 ], [ %t493, %loop.latch8 ]
  %t504 = phi i1 [ %t98, %merge5 ], [ %t494, %loop.latch8 ]
  %t505 = phi double [ %t102, %merge5 ], [ %t495, %loop.latch8 ]
  %t506 = phi i1 [ %t99, %merge5 ], [ %t496, %loop.latch8 ]
  %t507 = phi double [ %t103, %merge5 ], [ %t497, %loop.latch8 ]
  %t508 = phi double [ %t104, %merge5 ], [ %t498, %loop.latch8 ]
  store i1 %t499, i1* %l5
  store double %t500, double* %l9
  store { i8**, i64 }* %t501, { i8**, i64 }** %l1
  store i1 %t502, i1* %l6
  store double %t503, double* %l10
  store i1 %t504, i1* %l7
  store double %t505, double* %l11
  store i1 %t506, i1* %l8
  store double %t507, double* %l12
  store double %t508, double* %l13
  br label %loop.body7
loop.body7:
  %t105 = load double, double* %l13
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t107 = load { i8**, i64 }, { i8**, i64 }* %t106
  %t108 = extractvalue { i8**, i64 } %t107, 1
  %t109 = sitofp i64 %t108 to double
  %t110 = fcmp oge double %t105, %t109
  %t111 = load i8*, i8** %l0
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t113 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t115 = load i8*, i8** %l4
  %t116 = load i1, i1* %l5
  %t117 = load i1, i1* %l6
  %t118 = load i1, i1* %l7
  %t119 = load i1, i1* %l8
  %t120 = load double, double* %l9
  %t121 = load double, double* %l10
  %t122 = load double, double* %l11
  %t123 = load double, double* %l12
  %t124 = load double, double* %l13
  br i1 %t110, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t126 = load double, double* %l13
  %t127 = fptosi double %t126 to i64
  %t128 = load { i8**, i64 }, { i8**, i64 }* %t125
  %t129 = extractvalue { i8**, i64 } %t128, 0
  %t130 = extractvalue { i8**, i64 } %t128, 1
  %t131 = icmp uge i64 %t127, %t130
  ; bounds check: %t131 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t127, i64 %t130)
  %t132 = getelementptr i8*, i8** %t129, i64 %t127
  %t133 = load i8*, i8** %t132
  store i8* %t133, i8** %l14
  %t134 = load i8*, i8** %l14
  %s135 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275319236, i32 0, i32 0
  %t136 = call i1 @starts_with(i8* %t134, i8* %s135)
  %t137 = load i8*, i8** %l0
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t139 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t141 = load i8*, i8** %l4
  %t142 = load i1, i1* %l5
  %t143 = load i1, i1* %l6
  %t144 = load i1, i1* %l7
  %t145 = load i1, i1* %l8
  %t146 = load double, double* %l9
  %t147 = load double, double* %l10
  %t148 = load double, double* %l11
  %t149 = load double, double* %l12
  %t150 = load double, double* %l13
  %t151 = load i8*, i8** %l14
  br i1 %t136, label %then12, label %else13
then12:
  %t152 = load i8*, i8** %l14
  %t153 = load i8*, i8** %l14
  %t154 = call i64 @sailfin_runtime_string_length(i8* %t153)
  %t155 = call i8* @sailfin_runtime_substring(i8* %t152, i64 4, i64 %t154)
  store i8* %t155, i8** %l15
  %t156 = load i8*, i8** %l15
  %t157 = call %NumberParseResult @parse_decimal_number(i8* %t156)
  store %NumberParseResult %t157, %NumberParseResult* %l16
  %t158 = load %NumberParseResult, %NumberParseResult* %l16
  %t159 = extractvalue %NumberParseResult %t158, 0
  %t160 = load i8*, i8** %l0
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t162 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t164 = load i8*, i8** %l4
  %t165 = load i1, i1* %l5
  %t166 = load i1, i1* %l6
  %t167 = load i1, i1* %l7
  %t168 = load i1, i1* %l8
  %t169 = load double, double* %l9
  %t170 = load double, double* %l10
  %t171 = load double, double* %l11
  %t172 = load double, double* %l12
  %t173 = load double, double* %l13
  %t174 = load i8*, i8** %l14
  %t175 = load i8*, i8** %l15
  %t176 = load %NumberParseResult, %NumberParseResult* %l16
  br i1 %t159, label %then15, label %else16
then15:
  store i1 1, i1* %l5
  %t177 = load %NumberParseResult, %NumberParseResult* %l16
  %t178 = extractvalue %NumberParseResult %t177, 1
  store double %t178, double* %l9
  %t179 = load i1, i1* %l5
  %t180 = load double, double* %l9
  br label %merge17
else16:
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s182 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t183 = call i8* @sailfin_runtime_string_concat(i8* %s182, i8* %enum_name)
  %s184 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t185 = call i8* @sailfin_runtime_string_concat(i8* %t183, i8* %s184)
  %t186 = load i8*, i8** %l4
  %t187 = call i8* @sailfin_runtime_string_concat(i8* %t185, i8* %t186)
  %s188 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h879467198, i32 0, i32 0
  %t189 = call i8* @sailfin_runtime_string_concat(i8* %t187, i8* %s188)
  %t190 = load i8*, i8** %l15
  %t191 = call i8* @sailfin_runtime_string_concat(i8* %t189, i8* %t190)
  %t192 = load i8, i8* %t191
  %t193 = add i8 %t192, 96
  %t194 = alloca [2 x i8], align 1
  %t195 = getelementptr [2 x i8], [2 x i8]* %t194, i32 0, i32 0
  store i8 %t193, i8* %t195
  %t196 = getelementptr [2 x i8], [2 x i8]* %t194, i32 0, i32 1
  store i8 0, i8* %t196
  %t197 = getelementptr [2 x i8], [2 x i8]* %t194, i32 0, i32 0
  %t198 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t181, i8* %t197)
  store { i8**, i64 }* %t198, { i8**, i64 }** %l1
  %t199 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
merge17:
  %t200 = phi i1 [ %t179, %then15 ], [ %t165, %else16 ]
  %t201 = phi double [ %t180, %then15 ], [ %t169, %else16 ]
  %t202 = phi { i8**, i64 }* [ %t161, %then15 ], [ %t199, %else16 ]
  store i1 %t200, i1* %l5
  store double %t201, double* %l9
  store { i8**, i64 }* %t202, { i8**, i64 }** %l1
  %t203 = load i1, i1* %l5
  %t204 = load double, double* %l9
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge14
else13:
  %t206 = load i8*, i8** %l14
  %s207 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h242296049, i32 0, i32 0
  %t208 = call i1 @starts_with(i8* %t206, i8* %s207)
  %t209 = load i8*, i8** %l0
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t211 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t213 = load i8*, i8** %l4
  %t214 = load i1, i1* %l5
  %t215 = load i1, i1* %l6
  %t216 = load i1, i1* %l7
  %t217 = load i1, i1* %l8
  %t218 = load double, double* %l9
  %t219 = load double, double* %l10
  %t220 = load double, double* %l11
  %t221 = load double, double* %l12
  %t222 = load double, double* %l13
  %t223 = load i8*, i8** %l14
  br i1 %t208, label %then18, label %else19
then18:
  %t224 = load i8*, i8** %l14
  %t225 = load i8*, i8** %l14
  %t226 = call i64 @sailfin_runtime_string_length(i8* %t225)
  %t227 = call i8* @sailfin_runtime_substring(i8* %t224, i64 7, i64 %t226)
  store i8* %t227, i8** %l17
  %t228 = load i8*, i8** %l17
  %t229 = call %NumberParseResult @parse_decimal_number(i8* %t228)
  store %NumberParseResult %t229, %NumberParseResult* %l18
  %t230 = load %NumberParseResult, %NumberParseResult* %l18
  %t231 = extractvalue %NumberParseResult %t230, 0
  %t232 = load i8*, i8** %l0
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t234 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t236 = load i8*, i8** %l4
  %t237 = load i1, i1* %l5
  %t238 = load i1, i1* %l6
  %t239 = load i1, i1* %l7
  %t240 = load i1, i1* %l8
  %t241 = load double, double* %l9
  %t242 = load double, double* %l10
  %t243 = load double, double* %l11
  %t244 = load double, double* %l12
  %t245 = load double, double* %l13
  %t246 = load i8*, i8** %l14
  %t247 = load i8*, i8** %l17
  %t248 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t231, label %then21, label %else22
then21:
  store i1 1, i1* %l6
  %t249 = load %NumberParseResult, %NumberParseResult* %l18
  %t250 = extractvalue %NumberParseResult %t249, 1
  store double %t250, double* %l10
  %t251 = load i1, i1* %l6
  %t252 = load double, double* %l10
  br label %merge23
else22:
  %t253 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s254 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t255 = call i8* @sailfin_runtime_string_concat(i8* %s254, i8* %enum_name)
  %s256 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t257 = call i8* @sailfin_runtime_string_concat(i8* %t255, i8* %s256)
  %t258 = load i8*, i8** %l4
  %t259 = call i8* @sailfin_runtime_string_concat(i8* %t257, i8* %t258)
  %s260 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h24304067, i32 0, i32 0
  %t261 = call i8* @sailfin_runtime_string_concat(i8* %t259, i8* %s260)
  %t262 = load i8*, i8** %l17
  %t263 = call i8* @sailfin_runtime_string_concat(i8* %t261, i8* %t262)
  %t264 = load i8, i8* %t263
  %t265 = add i8 %t264, 96
  %t266 = alloca [2 x i8], align 1
  %t267 = getelementptr [2 x i8], [2 x i8]* %t266, i32 0, i32 0
  store i8 %t265, i8* %t267
  %t268 = getelementptr [2 x i8], [2 x i8]* %t266, i32 0, i32 1
  store i8 0, i8* %t268
  %t269 = getelementptr [2 x i8], [2 x i8]* %t266, i32 0, i32 0
  %t270 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t253, i8* %t269)
  store { i8**, i64 }* %t270, { i8**, i64 }** %l1
  %t271 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t272 = phi i1 [ %t251, %then21 ], [ %t238, %else22 ]
  %t273 = phi double [ %t252, %then21 ], [ %t242, %else22 ]
  %t274 = phi { i8**, i64 }* [ %t233, %then21 ], [ %t271, %else22 ]
  store i1 %t272, i1* %l6
  store double %t273, double* %l10
  store { i8**, i64 }* %t274, { i8**, i64 }** %l1
  %t275 = load i1, i1* %l6
  %t276 = load double, double* %l10
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge20
else19:
  %t278 = load i8*, i8** %l14
  %s279 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h466680424, i32 0, i32 0
  %t280 = call i1 @starts_with(i8* %t278, i8* %s279)
  %t281 = load i8*, i8** %l0
  %t282 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t283 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t284 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t285 = load i8*, i8** %l4
  %t286 = load i1, i1* %l5
  %t287 = load i1, i1* %l6
  %t288 = load i1, i1* %l7
  %t289 = load i1, i1* %l8
  %t290 = load double, double* %l9
  %t291 = load double, double* %l10
  %t292 = load double, double* %l11
  %t293 = load double, double* %l12
  %t294 = load double, double* %l13
  %t295 = load i8*, i8** %l14
  br i1 %t280, label %then24, label %else25
then24:
  %t296 = load i8*, i8** %l14
  %t297 = load i8*, i8** %l14
  %t298 = call i64 @sailfin_runtime_string_length(i8* %t297)
  %t299 = call i8* @sailfin_runtime_substring(i8* %t296, i64 5, i64 %t298)
  store i8* %t299, i8** %l19
  %t300 = load i8*, i8** %l19
  %t301 = call %NumberParseResult @parse_decimal_number(i8* %t300)
  store %NumberParseResult %t301, %NumberParseResult* %l20
  %t302 = load %NumberParseResult, %NumberParseResult* %l20
  %t303 = extractvalue %NumberParseResult %t302, 0
  %t304 = load i8*, i8** %l0
  %t305 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t306 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t307 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t308 = load i8*, i8** %l4
  %t309 = load i1, i1* %l5
  %t310 = load i1, i1* %l6
  %t311 = load i1, i1* %l7
  %t312 = load i1, i1* %l8
  %t313 = load double, double* %l9
  %t314 = load double, double* %l10
  %t315 = load double, double* %l11
  %t316 = load double, double* %l12
  %t317 = load double, double* %l13
  %t318 = load i8*, i8** %l14
  %t319 = load i8*, i8** %l19
  %t320 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t303, label %then27, label %else28
then27:
  store i1 1, i1* %l7
  %t321 = load %NumberParseResult, %NumberParseResult* %l20
  %t322 = extractvalue %NumberParseResult %t321, 1
  store double %t322, double* %l11
  %t323 = load i1, i1* %l7
  %t324 = load double, double* %l11
  br label %merge29
else28:
  %t325 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s326 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t327 = call i8* @sailfin_runtime_string_concat(i8* %s326, i8* %enum_name)
  %s328 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t329 = call i8* @sailfin_runtime_string_concat(i8* %t327, i8* %s328)
  %t330 = load i8*, i8** %l4
  %t331 = call i8* @sailfin_runtime_string_concat(i8* %t329, i8* %t330)
  %s332 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h151690315, i32 0, i32 0
  %t333 = call i8* @sailfin_runtime_string_concat(i8* %t331, i8* %s332)
  %t334 = load i8*, i8** %l19
  %t335 = call i8* @sailfin_runtime_string_concat(i8* %t333, i8* %t334)
  %t336 = load i8, i8* %t335
  %t337 = add i8 %t336, 96
  %t338 = alloca [2 x i8], align 1
  %t339 = getelementptr [2 x i8], [2 x i8]* %t338, i32 0, i32 0
  store i8 %t337, i8* %t339
  %t340 = getelementptr [2 x i8], [2 x i8]* %t338, i32 0, i32 1
  store i8 0, i8* %t340
  %t341 = getelementptr [2 x i8], [2 x i8]* %t338, i32 0, i32 0
  %t342 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t325, i8* %t341)
  store { i8**, i64 }* %t342, { i8**, i64 }** %l1
  %t343 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t344 = phi i1 [ %t323, %then27 ], [ %t311, %else28 ]
  %t345 = phi double [ %t324, %then27 ], [ %t315, %else28 ]
  %t346 = phi { i8**, i64 }* [ %t305, %then27 ], [ %t343, %else28 ]
  store i1 %t344, i1* %l7
  store double %t345, double* %l11
  store { i8**, i64 }* %t346, { i8**, i64 }** %l1
  %t347 = load i1, i1* %l7
  %t348 = load double, double* %l11
  %t349 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
else25:
  %t350 = load i8*, i8** %l14
  %s351 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h841337749, i32 0, i32 0
  %t352 = call i1 @starts_with(i8* %t350, i8* %s351)
  %t353 = load i8*, i8** %l0
  %t354 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t355 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t356 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t357 = load i8*, i8** %l4
  %t358 = load i1, i1* %l5
  %t359 = load i1, i1* %l6
  %t360 = load i1, i1* %l7
  %t361 = load i1, i1* %l8
  %t362 = load double, double* %l9
  %t363 = load double, double* %l10
  %t364 = load double, double* %l11
  %t365 = load double, double* %l12
  %t366 = load double, double* %l13
  %t367 = load i8*, i8** %l14
  br i1 %t352, label %then30, label %else31
then30:
  %t368 = load i8*, i8** %l14
  %t369 = load i8*, i8** %l14
  %t370 = call i64 @sailfin_runtime_string_length(i8* %t369)
  %t371 = call i8* @sailfin_runtime_substring(i8* %t368, i64 6, i64 %t370)
  store i8* %t371, i8** %l21
  %t372 = load i8*, i8** %l21
  %t373 = call %NumberParseResult @parse_decimal_number(i8* %t372)
  store %NumberParseResult %t373, %NumberParseResult* %l22
  %t374 = load %NumberParseResult, %NumberParseResult* %l22
  %t375 = extractvalue %NumberParseResult %t374, 0
  %t376 = load i8*, i8** %l0
  %t377 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t378 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t379 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t380 = load i8*, i8** %l4
  %t381 = load i1, i1* %l5
  %t382 = load i1, i1* %l6
  %t383 = load i1, i1* %l7
  %t384 = load i1, i1* %l8
  %t385 = load double, double* %l9
  %t386 = load double, double* %l10
  %t387 = load double, double* %l11
  %t388 = load double, double* %l12
  %t389 = load double, double* %l13
  %t390 = load i8*, i8** %l14
  %t391 = load i8*, i8** %l21
  %t392 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t375, label %then33, label %else34
then33:
  store i1 1, i1* %l8
  %t393 = load %NumberParseResult, %NumberParseResult* %l22
  %t394 = extractvalue %NumberParseResult %t393, 1
  store double %t394, double* %l12
  %t395 = load i1, i1* %l8
  %t396 = load double, double* %l12
  br label %merge35
else34:
  %t397 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s398 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t399 = call i8* @sailfin_runtime_string_concat(i8* %s398, i8* %enum_name)
  %s400 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t401 = call i8* @sailfin_runtime_string_concat(i8* %t399, i8* %s400)
  %t402 = load i8*, i8** %l4
  %t403 = call i8* @sailfin_runtime_string_concat(i8* %t401, i8* %t402)
  %s404 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1297227834, i32 0, i32 0
  %t405 = call i8* @sailfin_runtime_string_concat(i8* %t403, i8* %s404)
  %t406 = load i8*, i8** %l21
  %t407 = call i8* @sailfin_runtime_string_concat(i8* %t405, i8* %t406)
  %t408 = load i8, i8* %t407
  %t409 = add i8 %t408, 96
  %t410 = alloca [2 x i8], align 1
  %t411 = getelementptr [2 x i8], [2 x i8]* %t410, i32 0, i32 0
  store i8 %t409, i8* %t411
  %t412 = getelementptr [2 x i8], [2 x i8]* %t410, i32 0, i32 1
  store i8 0, i8* %t412
  %t413 = getelementptr [2 x i8], [2 x i8]* %t410, i32 0, i32 0
  %t414 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t397, i8* %t413)
  store { i8**, i64 }* %t414, { i8**, i64 }** %l1
  %t415 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge35
merge35:
  %t416 = phi i1 [ %t395, %then33 ], [ %t384, %else34 ]
  %t417 = phi double [ %t396, %then33 ], [ %t388, %else34 ]
  %t418 = phi { i8**, i64 }* [ %t377, %then33 ], [ %t415, %else34 ]
  store i1 %t416, i1* %l8
  store double %t417, double* %l12
  store { i8**, i64 }* %t418, { i8**, i64 }** %l1
  %t419 = load i1, i1* %l8
  %t420 = load double, double* %l12
  %t421 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge32
else31:
  %t422 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s423 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t424 = call i8* @sailfin_runtime_string_concat(i8* %s423, i8* %enum_name)
  %s425 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t426 = call i8* @sailfin_runtime_string_concat(i8* %t424, i8* %s425)
  %t427 = load i8*, i8** %l4
  %t428 = call i8* @sailfin_runtime_string_concat(i8* %t426, i8* %t427)
  %s429 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h496289716, i32 0, i32 0
  %t430 = call i8* @sailfin_runtime_string_concat(i8* %t428, i8* %s429)
  %t431 = load i8*, i8** %l14
  %t432 = call i8* @sailfin_runtime_string_concat(i8* %t430, i8* %t431)
  %t433 = load i8, i8* %t432
  %t434 = add i8 %t433, 96
  %t435 = alloca [2 x i8], align 1
  %t436 = getelementptr [2 x i8], [2 x i8]* %t435, i32 0, i32 0
  store i8 %t434, i8* %t436
  %t437 = getelementptr [2 x i8], [2 x i8]* %t435, i32 0, i32 1
  store i8 0, i8* %t437
  %t438 = getelementptr [2 x i8], [2 x i8]* %t435, i32 0, i32 0
  %t439 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t422, i8* %t438)
  store { i8**, i64 }* %t439, { i8**, i64 }** %l1
  %t440 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t441 = phi i1 [ %t419, %merge35 ], [ %t361, %else31 ]
  %t442 = phi double [ %t420, %merge35 ], [ %t365, %else31 ]
  %t443 = phi { i8**, i64 }* [ %t421, %merge35 ], [ %t440, %else31 ]
  store i1 %t441, i1* %l8
  store double %t442, double* %l12
  store { i8**, i64 }* %t443, { i8**, i64 }** %l1
  %t444 = load i1, i1* %l8
  %t445 = load double, double* %l12
  %t446 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t447 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t448 = phi i1 [ %t347, %merge29 ], [ %t288, %merge32 ]
  %t449 = phi double [ %t348, %merge29 ], [ %t292, %merge32 ]
  %t450 = phi { i8**, i64 }* [ %t349, %merge29 ], [ %t446, %merge32 ]
  %t451 = phi i1 [ %t289, %merge29 ], [ %t444, %merge32 ]
  %t452 = phi double [ %t293, %merge29 ], [ %t445, %merge32 ]
  store i1 %t448, i1* %l7
  store double %t449, double* %l11
  store { i8**, i64 }* %t450, { i8**, i64 }** %l1
  store i1 %t451, i1* %l8
  store double %t452, double* %l12
  %t453 = load i1, i1* %l7
  %t454 = load double, double* %l11
  %t455 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t456 = load i1, i1* %l8
  %t457 = load double, double* %l12
  %t458 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t459 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t460 = phi i1 [ %t275, %merge23 ], [ %t215, %merge26 ]
  %t461 = phi double [ %t276, %merge23 ], [ %t219, %merge26 ]
  %t462 = phi { i8**, i64 }* [ %t277, %merge23 ], [ %t455, %merge26 ]
  %t463 = phi i1 [ %t216, %merge23 ], [ %t453, %merge26 ]
  %t464 = phi double [ %t220, %merge23 ], [ %t454, %merge26 ]
  %t465 = phi i1 [ %t217, %merge23 ], [ %t456, %merge26 ]
  %t466 = phi double [ %t221, %merge23 ], [ %t457, %merge26 ]
  store i1 %t460, i1* %l6
  store double %t461, double* %l10
  store { i8**, i64 }* %t462, { i8**, i64 }** %l1
  store i1 %t463, i1* %l7
  store double %t464, double* %l11
  store i1 %t465, i1* %l8
  store double %t466, double* %l12
  %t467 = load i1, i1* %l6
  %t468 = load double, double* %l10
  %t469 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t470 = load i1, i1* %l7
  %t471 = load double, double* %l11
  %t472 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t473 = load i1, i1* %l8
  %t474 = load double, double* %l12
  %t475 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t476 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge14
merge14:
  %t477 = phi i1 [ %t203, %merge17 ], [ %t142, %merge20 ]
  %t478 = phi double [ %t204, %merge17 ], [ %t146, %merge20 ]
  %t479 = phi { i8**, i64 }* [ %t205, %merge17 ], [ %t469, %merge20 ]
  %t480 = phi i1 [ %t143, %merge17 ], [ %t467, %merge20 ]
  %t481 = phi double [ %t147, %merge17 ], [ %t468, %merge20 ]
  %t482 = phi i1 [ %t144, %merge17 ], [ %t470, %merge20 ]
  %t483 = phi double [ %t148, %merge17 ], [ %t471, %merge20 ]
  %t484 = phi i1 [ %t145, %merge17 ], [ %t473, %merge20 ]
  %t485 = phi double [ %t149, %merge17 ], [ %t474, %merge20 ]
  store i1 %t477, i1* %l5
  store double %t478, double* %l9
  store { i8**, i64 }* %t479, { i8**, i64 }** %l1
  store i1 %t480, i1* %l6
  store double %t481, double* %l10
  store i1 %t482, i1* %l7
  store double %t483, double* %l11
  store i1 %t484, i1* %l8
  store double %t485, double* %l12
  %t486 = load double, double* %l13
  %t487 = sitofp i64 1 to double
  %t488 = fadd double %t486, %t487
  store double %t488, double* %l13
  br label %loop.latch8
loop.latch8:
  %t489 = load i1, i1* %l5
  %t490 = load double, double* %l9
  %t491 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t492 = load i1, i1* %l6
  %t493 = load double, double* %l10
  %t494 = load i1, i1* %l7
  %t495 = load double, double* %l11
  %t496 = load i1, i1* %l8
  %t497 = load double, double* %l12
  %t498 = load double, double* %l13
  br label %loop.header6
afterloop9:
  %t509 = load i1, i1* %l5
  %t510 = load double, double* %l9
  %t511 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t512 = load i1, i1* %l6
  %t513 = load double, double* %l10
  %t514 = load i1, i1* %l7
  %t515 = load double, double* %l11
  %t516 = load i1, i1* %l8
  %t517 = load double, double* %l12
  %t518 = load double, double* %l13
  %t519 = load i1, i1* %l5
  %t520 = xor i1 %t519, 1
  %t521 = load i8*, i8** %l0
  %t522 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t523 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t524 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t525 = load i8*, i8** %l4
  %t526 = load i1, i1* %l5
  %t527 = load i1, i1* %l6
  %t528 = load i1, i1* %l7
  %t529 = load i1, i1* %l8
  %t530 = load double, double* %l9
  %t531 = load double, double* %l10
  %t532 = load double, double* %l11
  %t533 = load double, double* %l12
  %t534 = load double, double* %l13
  br i1 %t520, label %then36, label %merge37
then36:
  %t535 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s536 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t537 = call i8* @sailfin_runtime_string_concat(i8* %s536, i8* %enum_name)
  %s538 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t539 = call i8* @sailfin_runtime_string_concat(i8* %t537, i8* %s538)
  %t540 = load i8*, i8** %l4
  %t541 = call i8* @sailfin_runtime_string_concat(i8* %t539, i8* %t540)
  %s542 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1697653870, i32 0, i32 0
  %t543 = call i8* @sailfin_runtime_string_concat(i8* %t541, i8* %s542)
  %t544 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t535, i8* %t543)
  store { i8**, i64 }* %t544, { i8**, i64 }** %l1
  %t545 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge37
merge37:
  %t546 = phi { i8**, i64 }* [ %t545, %then36 ], [ %t522, %afterloop9 ]
  store { i8**, i64 }* %t546, { i8**, i64 }** %l1
  %t547 = load i1, i1* %l6
  %t548 = xor i1 %t547, 1
  %t549 = load i8*, i8** %l0
  %t550 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t551 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t552 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t553 = load i8*, i8** %l4
  %t554 = load i1, i1* %l5
  %t555 = load i1, i1* %l6
  %t556 = load i1, i1* %l7
  %t557 = load i1, i1* %l8
  %t558 = load double, double* %l9
  %t559 = load double, double* %l10
  %t560 = load double, double* %l11
  %t561 = load double, double* %l12
  %t562 = load double, double* %l13
  br i1 %t548, label %then38, label %merge39
then38:
  %t563 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s564 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t565 = call i8* @sailfin_runtime_string_concat(i8* %s564, i8* %enum_name)
  %s566 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t567 = call i8* @sailfin_runtime_string_concat(i8* %t565, i8* %s566)
  %t568 = load i8*, i8** %l4
  %t569 = call i8* @sailfin_runtime_string_concat(i8* %t567, i8* %t568)
  %s570 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h625556084, i32 0, i32 0
  %t571 = call i8* @sailfin_runtime_string_concat(i8* %t569, i8* %s570)
  %t572 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t563, i8* %t571)
  store { i8**, i64 }* %t572, { i8**, i64 }** %l1
  %t573 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t574 = phi { i8**, i64 }* [ %t573, %then38 ], [ %t550, %merge37 ]
  store { i8**, i64 }* %t574, { i8**, i64 }** %l1
  %t575 = load i1, i1* %l7
  %t576 = xor i1 %t575, 1
  %t577 = load i8*, i8** %l0
  %t578 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t579 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t580 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t581 = load i8*, i8** %l4
  %t582 = load i1, i1* %l5
  %t583 = load i1, i1* %l6
  %t584 = load i1, i1* %l7
  %t585 = load i1, i1* %l8
  %t586 = load double, double* %l9
  %t587 = load double, double* %l10
  %t588 = load double, double* %l11
  %t589 = load double, double* %l12
  %t590 = load double, double* %l13
  br i1 %t576, label %then40, label %merge41
then40:
  %t591 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s592 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t593 = call i8* @sailfin_runtime_string_concat(i8* %s592, i8* %enum_name)
  %s594 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t595 = call i8* @sailfin_runtime_string_concat(i8* %t593, i8* %s594)
  %t596 = load i8*, i8** %l4
  %t597 = call i8* @sailfin_runtime_string_concat(i8* %t595, i8* %t596)
  %s598 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h608364678, i32 0, i32 0
  %t599 = call i8* @sailfin_runtime_string_concat(i8* %t597, i8* %s598)
  %t600 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t591, i8* %t599)
  store { i8**, i64 }* %t600, { i8**, i64 }** %l1
  %t601 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t602 = phi { i8**, i64 }* [ %t601, %then40 ], [ %t578, %merge39 ]
  store { i8**, i64 }* %t602, { i8**, i64 }** %l1
  %t603 = load i1, i1* %l8
  %t604 = xor i1 %t603, 1
  %t605 = load i8*, i8** %l0
  %t606 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t607 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t608 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t609 = load i8*, i8** %l4
  %t610 = load i1, i1* %l5
  %t611 = load i1, i1* %l6
  %t612 = load i1, i1* %l7
  %t613 = load i1, i1* %l8
  %t614 = load double, double* %l9
  %t615 = load double, double* %l10
  %t616 = load double, double* %l11
  %t617 = load double, double* %l12
  %t618 = load double, double* %l13
  br i1 %t604, label %then42, label %merge43
then42:
  %t619 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s620 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t621 = call i8* @sailfin_runtime_string_concat(i8* %s620, i8* %enum_name)
  %s622 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t623 = call i8* @sailfin_runtime_string_concat(i8* %t621, i8* %s622)
  %t624 = load i8*, i8** %l4
  %t625 = call i8* @sailfin_runtime_string_concat(i8* %t623, i8* %t624)
  %s626 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h2112628887, i32 0, i32 0
  %t627 = call i8* @sailfin_runtime_string_concat(i8* %t625, i8* %s626)
  %t628 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t619, i8* %t627)
  store { i8**, i64 }* %t628, { i8**, i64 }** %l1
  %t629 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t630 = phi { i8**, i64 }* [ %t629, %then42 ], [ %t606, %merge41 ]
  store { i8**, i64 }* %t630, { i8**, i64 }** %l1
  %t632 = load i1, i1* %l5
  br label %logical_and_entry_631

logical_and_entry_631:
  br i1 %t632, label %logical_and_right_631, label %logical_and_merge_631

logical_and_right_631:
  %t634 = load i1, i1* %l6
  br label %logical_and_entry_633

logical_and_entry_633:
  br i1 %t634, label %logical_and_right_633, label %logical_and_merge_633

logical_and_right_633:
  %t636 = load i1, i1* %l7
  br label %logical_and_entry_635

logical_and_entry_635:
  br i1 %t636, label %logical_and_right_635, label %logical_and_merge_635

logical_and_right_635:
  %t638 = load i1, i1* %l8
  br label %logical_and_entry_637

logical_and_entry_637:
  br i1 %t638, label %logical_and_right_637, label %logical_and_merge_637

logical_and_right_637:
  %t639 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t640 = load { i8**, i64 }, { i8**, i64 }* %t639
  %t641 = extractvalue { i8**, i64 } %t640, 1
  %t642 = icmp eq i64 %t641, 0
  br label %logical_and_right_end_637

logical_and_right_end_637:
  br label %logical_and_merge_637

logical_and_merge_637:
  %t643 = phi i1 [ false, %logical_and_entry_637 ], [ %t642, %logical_and_right_end_637 ]
  br label %logical_and_right_end_635

logical_and_right_end_635:
  br label %logical_and_merge_635

logical_and_merge_635:
  %t644 = phi i1 [ false, %logical_and_entry_635 ], [ %t643, %logical_and_right_end_635 ]
  br label %logical_and_right_end_633

logical_and_right_end_633:
  br label %logical_and_merge_633

logical_and_merge_633:
  %t645 = phi i1 [ false, %logical_and_entry_633 ], [ %t644, %logical_and_right_end_633 ]
  br label %logical_and_right_end_631

logical_and_right_end_631:
  br label %logical_and_merge_631

logical_and_merge_631:
  %t646 = phi i1 [ false, %logical_and_entry_631 ], [ %t645, %logical_and_right_end_631 ]
  store i1 %t646, i1* %l23
  %t647 = load i8*, i8** %l4
  %t648 = insertvalue %NativeEnumVariantLayout undef, i8* %t647, 0
  %t649 = load double, double* %l9
  %t650 = insertvalue %NativeEnumVariantLayout %t648, double %t649, 1
  %t651 = load double, double* %l10
  %t652 = insertvalue %NativeEnumVariantLayout %t650, double %t651, 2
  %t653 = load double, double* %l11
  %t654 = insertvalue %NativeEnumVariantLayout %t652, double %t653, 3
  %t655 = load double, double* %l12
  %t656 = insertvalue %NativeEnumVariantLayout %t654, double %t655, 4
  %t657 = alloca [0 x %NativeStructLayoutField*]
  %t658 = getelementptr [0 x %NativeStructLayoutField*], [0 x %NativeStructLayoutField*]* %t657, i32 0, i32 0
  %t659 = alloca { %NativeStructLayoutField**, i64 }
  %t660 = getelementptr { %NativeStructLayoutField**, i64 }, { %NativeStructLayoutField**, i64 }* %t659, i32 0, i32 0
  store %NativeStructLayoutField** %t658, %NativeStructLayoutField*** %t660
  %t661 = getelementptr { %NativeStructLayoutField**, i64 }, { %NativeStructLayoutField**, i64 }* %t659, i32 0, i32 1
  store i64 0, i64* %t661
  %t662 = insertvalue %NativeEnumVariantLayout %t656, { %NativeStructLayoutField**, i64 }* %t659, 5
  store %NativeEnumVariantLayout %t662, %NativeEnumVariantLayout* %l24
  %t663 = load i1, i1* %l23
  %t664 = insertvalue %EnumLayoutVariantParse undef, i1 %t663, 0
  %t665 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l24
  %t666 = insertvalue %EnumLayoutVariantParse %t664, %NativeEnumVariantLayout %t665, 1
  %t667 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t668 = insertvalue %EnumLayoutVariantParse %t666, { i8**, i64 }* %t667, 2
  ret %EnumLayoutVariantParse %t668
}

define %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %text, i8* %enum_name) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %NativeStructLayoutField
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca i1
  %l10 = alloca i1
  %l11 = alloca i1
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca double
  %l15 = alloca double
  %l16 = alloca i8*
  %l17 = alloca i8*
  %l18 = alloca %NumberParseResult
  %l19 = alloca i8*
  %l20 = alloca %NumberParseResult
  %l21 = alloca i8*
  %l22 = alloca %NumberParseResult
  %l23 = alloca i1
  %l24 = alloca %NativeStructLayoutField
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = alloca [0 x i8*]
  %t2 = getelementptr [0 x i8*], [0 x i8*]* %t1, i32 0, i32 0
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t2, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t7 = insertvalue %NativeStructLayoutField undef, i8* %s6, 0
  %s8 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t9 = insertvalue %NativeStructLayoutField %t7, i8* %s8, 1
  %t10 = sitofp i64 0 to double
  %t11 = insertvalue %NativeStructLayoutField %t9, double %t10, 2
  %t12 = sitofp i64 0 to double
  %t13 = insertvalue %NativeStructLayoutField %t11, double %t12, 3
  %t14 = sitofp i64 0 to double
  %t15 = insertvalue %NativeStructLayoutField %t13, double %t14, 4
  store %NativeStructLayoutField %t15, %NativeStructLayoutField* %l2
  %t16 = load i8*, i8** %l0
  %t17 = call i64 @sailfin_runtime_string_length(i8* %t16)
  %t18 = icmp eq i64 %t17, 0
  %t19 = load i8*, i8** %l0
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t21 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  br i1 %t18, label %then0, label %merge1
then0:
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s23 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t24 = call i8* @sailfin_runtime_string_concat(i8* %s23, i8* %enum_name)
  %s25 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h329133056, i32 0, i32 0
  %t26 = call i8* @sailfin_runtime_string_concat(i8* %t24, i8* %s25)
  %t27 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t22, i8* %t26)
  store { i8**, i64 }* %t27, { i8**, i64 }** %l1
  %t28 = insertvalue %EnumLayoutPayloadParse undef, i1 0, 0
  %s29 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t30 = insertvalue %EnumLayoutPayloadParse %t28, i8* %s29, 1
  %t31 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t32 = insertvalue %EnumLayoutPayloadParse %t30, %NativeStructLayoutField %t31, 2
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t34 = insertvalue %EnumLayoutPayloadParse %t32, { i8**, i64 }* %t33, 3
  ret %EnumLayoutPayloadParse %t34
merge1:
  %t35 = load i8*, i8** %l0
  %t36 = call { i8**, i64 }* @split_whitespace(i8* %t35)
  store { i8**, i64 }* %t36, { i8**, i64 }** %l3
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t38 = load { i8**, i64 }, { i8**, i64 }* %t37
  %t39 = extractvalue { i8**, i64 } %t38, 1
  %t40 = icmp eq i64 %t39, 0
  %t41 = load i8*, i8** %l0
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t43 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br i1 %t40, label %then2, label %merge3
then2:
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s46 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %s46, i8* %enum_name)
  %s48 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h755263238, i32 0, i32 0
  %t49 = call i8* @sailfin_runtime_string_concat(i8* %t47, i8* %s48)
  %t50 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t45, i8* %t49)
  store { i8**, i64 }* %t50, { i8**, i64 }** %l1
  %t51 = insertvalue %EnumLayoutPayloadParse undef, i1 0, 0
  %s52 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t53 = insertvalue %EnumLayoutPayloadParse %t51, i8* %s52, 1
  %t54 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t55 = insertvalue %EnumLayoutPayloadParse %t53, %NativeStructLayoutField %t54, 2
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t57 = insertvalue %EnumLayoutPayloadParse %t55, { i8**, i64 }* %t56, 3
  ret %EnumLayoutPayloadParse %t57
merge3:
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t59 = load { i8**, i64 }, { i8**, i64 }* %t58
  %t60 = extractvalue { i8**, i64 } %t59, 0
  %t61 = extractvalue { i8**, i64 } %t59, 1
  %t62 = icmp uge i64 0, %t61
  ; bounds check: %t62 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t61)
  %t63 = getelementptr i8*, i8** %t60, i64 0
  %t64 = load i8*, i8** %t63
  store i8* %t64, i8** %l4
  %t65 = load i8*, i8** %l4
  %t66 = alloca [2 x i8], align 1
  %t67 = getelementptr [2 x i8], [2 x i8]* %t66, i32 0, i32 0
  store i8 46, i8* %t67
  %t68 = getelementptr [2 x i8], [2 x i8]* %t66, i32 0, i32 1
  store i8 0, i8* %t68
  %t69 = getelementptr [2 x i8], [2 x i8]* %t66, i32 0, i32 0
  %t70 = call double @index_of(i8* %t65, i8* %t69)
  store double %t70, double* %l5
  %t72 = load double, double* %l5
  %t73 = sitofp i64 0 to double
  %t74 = fcmp ole double %t72, %t73
  br label %logical_or_entry_71

logical_or_entry_71:
  br i1 %t74, label %logical_or_merge_71, label %logical_or_right_71

logical_or_right_71:
  %t75 = load double, double* %l5
  %t76 = sitofp i64 1 to double
  %t77 = fadd double %t75, %t76
  %t78 = load i8*, i8** %l4
  %t79 = call i64 @sailfin_runtime_string_length(i8* %t78)
  %t80 = sitofp i64 %t79 to double
  %t81 = fcmp oge double %t77, %t80
  br label %logical_or_right_end_71

logical_or_right_end_71:
  br label %logical_or_merge_71

logical_or_merge_71:
  %t82 = phi i1 [ true, %logical_or_entry_71 ], [ %t81, %logical_or_right_end_71 ]
  %t83 = load i8*, i8** %l0
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t85 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t87 = load i8*, i8** %l4
  %t88 = load double, double* %l5
  br i1 %t82, label %then4, label %merge5
then4:
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s90 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t91 = call i8* @sailfin_runtime_string_concat(i8* %s90, i8* %enum_name)
  %s92 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h497146076, i32 0, i32 0
  %t93 = call i8* @sailfin_runtime_string_concat(i8* %t91, i8* %s92)
  %t94 = load i8*, i8** %l4
  %t95 = call i8* @sailfin_runtime_string_concat(i8* %t93, i8* %t94)
  %s96 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1123073249, i32 0, i32 0
  %t97 = call i8* @sailfin_runtime_string_concat(i8* %t95, i8* %s96)
  %t98 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t89, i8* %t97)
  store { i8**, i64 }* %t98, { i8**, i64 }** %l1
  %t99 = insertvalue %EnumLayoutPayloadParse undef, i1 0, 0
  %s100 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t101 = insertvalue %EnumLayoutPayloadParse %t99, i8* %s100, 1
  %t102 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t103 = insertvalue %EnumLayoutPayloadParse %t101, %NativeStructLayoutField %t102, 2
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t105 = insertvalue %EnumLayoutPayloadParse %t103, { i8**, i64 }* %t104, 3
  ret %EnumLayoutPayloadParse %t105
merge5:
  %t106 = load i8*, i8** %l4
  %t107 = load double, double* %l5
  %t108 = fptosi double %t107 to i64
  %t109 = call i8* @sailfin_runtime_substring(i8* %t106, i64 0, i64 %t108)
  store i8* %t109, i8** %l6
  %t110 = load i8*, i8** %l4
  %t111 = load double, double* %l5
  %t112 = sitofp i64 1 to double
  %t113 = fadd double %t111, %t112
  %t114 = load i8*, i8** %l4
  %t115 = call i64 @sailfin_runtime_string_length(i8* %t114)
  %t116 = fptosi double %t113 to i64
  %t117 = call i8* @sailfin_runtime_substring(i8* %t110, i64 %t116, i64 %t115)
  store i8* %t117, i8** %l7
  %s118 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s118, i8** %l8
  store i1 0, i1* %l9
  store i1 0, i1* %l10
  store i1 0, i1* %l11
  %t119 = sitofp i64 0 to double
  store double %t119, double* %l12
  %t120 = sitofp i64 0 to double
  store double %t120, double* %l13
  %t121 = sitofp i64 0 to double
  store double %t121, double* %l14
  %t122 = sitofp i64 1 to double
  store double %t122, double* %l15
  %t123 = load i8*, i8** %l0
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t125 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t127 = load i8*, i8** %l4
  %t128 = load double, double* %l5
  %t129 = load i8*, i8** %l6
  %t130 = load i8*, i8** %l7
  %t131 = load i8*, i8** %l8
  %t132 = load i1, i1* %l9
  %t133 = load i1, i1* %l10
  %t134 = load i1, i1* %l11
  %t135 = load double, double* %l12
  %t136 = load double, double* %l13
  %t137 = load double, double* %l14
  %t138 = load double, double* %l15
  br label %loop.header6
loop.header6:
  %t498 = phi i8* [ %t131, %merge5 ], [ %t489, %loop.latch8 ]
  %t499 = phi i1 [ %t132, %merge5 ], [ %t490, %loop.latch8 ]
  %t500 = phi double [ %t135, %merge5 ], [ %t491, %loop.latch8 ]
  %t501 = phi { i8**, i64 }* [ %t124, %merge5 ], [ %t492, %loop.latch8 ]
  %t502 = phi i1 [ %t133, %merge5 ], [ %t493, %loop.latch8 ]
  %t503 = phi double [ %t136, %merge5 ], [ %t494, %loop.latch8 ]
  %t504 = phi i1 [ %t134, %merge5 ], [ %t495, %loop.latch8 ]
  %t505 = phi double [ %t137, %merge5 ], [ %t496, %loop.latch8 ]
  %t506 = phi double [ %t138, %merge5 ], [ %t497, %loop.latch8 ]
  store i8* %t498, i8** %l8
  store i1 %t499, i1* %l9
  store double %t500, double* %l12
  store { i8**, i64 }* %t501, { i8**, i64 }** %l1
  store i1 %t502, i1* %l10
  store double %t503, double* %l13
  store i1 %t504, i1* %l11
  store double %t505, double* %l14
  store double %t506, double* %l15
  br label %loop.body7
loop.body7:
  %t139 = load double, double* %l15
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t141 = load { i8**, i64 }, { i8**, i64 }* %t140
  %t142 = extractvalue { i8**, i64 } %t141, 1
  %t143 = sitofp i64 %t142 to double
  %t144 = fcmp oge double %t139, %t143
  %t145 = load i8*, i8** %l0
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t147 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t149 = load i8*, i8** %l4
  %t150 = load double, double* %l5
  %t151 = load i8*, i8** %l6
  %t152 = load i8*, i8** %l7
  %t153 = load i8*, i8** %l8
  %t154 = load i1, i1* %l9
  %t155 = load i1, i1* %l10
  %t156 = load i1, i1* %l11
  %t157 = load double, double* %l12
  %t158 = load double, double* %l13
  %t159 = load double, double* %l14
  %t160 = load double, double* %l15
  br i1 %t144, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t162 = load double, double* %l15
  %t163 = fptosi double %t162 to i64
  %t164 = load { i8**, i64 }, { i8**, i64 }* %t161
  %t165 = extractvalue { i8**, i64 } %t164, 0
  %t166 = extractvalue { i8**, i64 } %t164, 1
  %t167 = icmp uge i64 %t163, %t166
  ; bounds check: %t167 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t163, i64 %t166)
  %t168 = getelementptr i8*, i8** %t165, i64 %t163
  %t169 = load i8*, i8** %t168
  store i8* %t169, i8** %l16
  %t170 = load i8*, i8** %l16
  %s171 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h524431183, i32 0, i32 0
  %t172 = call i1 @starts_with(i8* %t170, i8* %s171)
  %t173 = load i8*, i8** %l0
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t175 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t177 = load i8*, i8** %l4
  %t178 = load double, double* %l5
  %t179 = load i8*, i8** %l6
  %t180 = load i8*, i8** %l7
  %t181 = load i8*, i8** %l8
  %t182 = load i1, i1* %l9
  %t183 = load i1, i1* %l10
  %t184 = load i1, i1* %l11
  %t185 = load double, double* %l12
  %t186 = load double, double* %l13
  %t187 = load double, double* %l14
  %t188 = load double, double* %l15
  %t189 = load i8*, i8** %l16
  br i1 %t172, label %then12, label %else13
then12:
  %t190 = load i8*, i8** %l16
  %t191 = load i8*, i8** %l16
  %t192 = call i64 @sailfin_runtime_string_length(i8* %t191)
  %t193 = call i8* @sailfin_runtime_substring(i8* %t190, i64 5, i64 %t192)
  store i8* %t193, i8** %l8
  %t194 = load i8*, i8** %l8
  br label %merge14
else13:
  %t195 = load i8*, i8** %l16
  %s196 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h242296049, i32 0, i32 0
  %t197 = call i1 @starts_with(i8* %t195, i8* %s196)
  %t198 = load i8*, i8** %l0
  %t199 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t200 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t202 = load i8*, i8** %l4
  %t203 = load double, double* %l5
  %t204 = load i8*, i8** %l6
  %t205 = load i8*, i8** %l7
  %t206 = load i8*, i8** %l8
  %t207 = load i1, i1* %l9
  %t208 = load i1, i1* %l10
  %t209 = load i1, i1* %l11
  %t210 = load double, double* %l12
  %t211 = load double, double* %l13
  %t212 = load double, double* %l14
  %t213 = load double, double* %l15
  %t214 = load i8*, i8** %l16
  br i1 %t197, label %then15, label %else16
then15:
  %t215 = load i8*, i8** %l16
  %t216 = load i8*, i8** %l16
  %t217 = call i64 @sailfin_runtime_string_length(i8* %t216)
  %t218 = call i8* @sailfin_runtime_substring(i8* %t215, i64 7, i64 %t217)
  store i8* %t218, i8** %l17
  %t219 = load i8*, i8** %l17
  %t220 = call %NumberParseResult @parse_decimal_number(i8* %t219)
  store %NumberParseResult %t220, %NumberParseResult* %l18
  %t221 = load %NumberParseResult, %NumberParseResult* %l18
  %t222 = extractvalue %NumberParseResult %t221, 0
  %t223 = load i8*, i8** %l0
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t225 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t227 = load i8*, i8** %l4
  %t228 = load double, double* %l5
  %t229 = load i8*, i8** %l6
  %t230 = load i8*, i8** %l7
  %t231 = load i8*, i8** %l8
  %t232 = load i1, i1* %l9
  %t233 = load i1, i1* %l10
  %t234 = load i1, i1* %l11
  %t235 = load double, double* %l12
  %t236 = load double, double* %l13
  %t237 = load double, double* %l14
  %t238 = load double, double* %l15
  %t239 = load i8*, i8** %l16
  %t240 = load i8*, i8** %l17
  %t241 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t222, label %then18, label %else19
then18:
  store i1 1, i1* %l9
  %t242 = load %NumberParseResult, %NumberParseResult* %l18
  %t243 = extractvalue %NumberParseResult %t242, 1
  store double %t243, double* %l12
  %t244 = load i1, i1* %l9
  %t245 = load double, double* %l12
  br label %merge20
else19:
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s247 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t248 = call i8* @sailfin_runtime_string_concat(i8* %s247, i8* %enum_name)
  %s249 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t250 = call i8* @sailfin_runtime_string_concat(i8* %t248, i8* %s249)
  %t251 = load i8*, i8** %l4
  %t252 = call i8* @sailfin_runtime_string_concat(i8* %t250, i8* %t251)
  %s253 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h24304067, i32 0, i32 0
  %t254 = call i8* @sailfin_runtime_string_concat(i8* %t252, i8* %s253)
  %t255 = load i8*, i8** %l17
  %t256 = call i8* @sailfin_runtime_string_concat(i8* %t254, i8* %t255)
  %t257 = load i8, i8* %t256
  %t258 = add i8 %t257, 96
  %t259 = alloca [2 x i8], align 1
  %t260 = getelementptr [2 x i8], [2 x i8]* %t259, i32 0, i32 0
  store i8 %t258, i8* %t260
  %t261 = getelementptr [2 x i8], [2 x i8]* %t259, i32 0, i32 1
  store i8 0, i8* %t261
  %t262 = getelementptr [2 x i8], [2 x i8]* %t259, i32 0, i32 0
  %t263 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t246, i8* %t262)
  store { i8**, i64 }* %t263, { i8**, i64 }** %l1
  %t264 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t265 = phi i1 [ %t244, %then18 ], [ %t232, %else19 ]
  %t266 = phi double [ %t245, %then18 ], [ %t235, %else19 ]
  %t267 = phi { i8**, i64 }* [ %t224, %then18 ], [ %t264, %else19 ]
  store i1 %t265, i1* %l9
  store double %t266, double* %l12
  store { i8**, i64 }* %t267, { i8**, i64 }** %l1
  %t268 = load i1, i1* %l9
  %t269 = load double, double* %l12
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
else16:
  %t271 = load i8*, i8** %l16
  %s272 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h466680424, i32 0, i32 0
  %t273 = call i1 @starts_with(i8* %t271, i8* %s272)
  %t274 = load i8*, i8** %l0
  %t275 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t276 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t278 = load i8*, i8** %l4
  %t279 = load double, double* %l5
  %t280 = load i8*, i8** %l6
  %t281 = load i8*, i8** %l7
  %t282 = load i8*, i8** %l8
  %t283 = load i1, i1* %l9
  %t284 = load i1, i1* %l10
  %t285 = load i1, i1* %l11
  %t286 = load double, double* %l12
  %t287 = load double, double* %l13
  %t288 = load double, double* %l14
  %t289 = load double, double* %l15
  %t290 = load i8*, i8** %l16
  br i1 %t273, label %then21, label %else22
then21:
  %t291 = load i8*, i8** %l16
  %t292 = load i8*, i8** %l16
  %t293 = call i64 @sailfin_runtime_string_length(i8* %t292)
  %t294 = call i8* @sailfin_runtime_substring(i8* %t291, i64 5, i64 %t293)
  store i8* %t294, i8** %l19
  %t295 = load i8*, i8** %l19
  %t296 = call %NumberParseResult @parse_decimal_number(i8* %t295)
  store %NumberParseResult %t296, %NumberParseResult* %l20
  %t297 = load %NumberParseResult, %NumberParseResult* %l20
  %t298 = extractvalue %NumberParseResult %t297, 0
  %t299 = load i8*, i8** %l0
  %t300 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t301 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t302 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t303 = load i8*, i8** %l4
  %t304 = load double, double* %l5
  %t305 = load i8*, i8** %l6
  %t306 = load i8*, i8** %l7
  %t307 = load i8*, i8** %l8
  %t308 = load i1, i1* %l9
  %t309 = load i1, i1* %l10
  %t310 = load i1, i1* %l11
  %t311 = load double, double* %l12
  %t312 = load double, double* %l13
  %t313 = load double, double* %l14
  %t314 = load double, double* %l15
  %t315 = load i8*, i8** %l16
  %t316 = load i8*, i8** %l19
  %t317 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t298, label %then24, label %else25
then24:
  store i1 1, i1* %l10
  %t318 = load %NumberParseResult, %NumberParseResult* %l20
  %t319 = extractvalue %NumberParseResult %t318, 1
  store double %t319, double* %l13
  %t320 = load i1, i1* %l10
  %t321 = load double, double* %l13
  br label %merge26
else25:
  %t322 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s323 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t324 = call i8* @sailfin_runtime_string_concat(i8* %s323, i8* %enum_name)
  %s325 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t326 = call i8* @sailfin_runtime_string_concat(i8* %t324, i8* %s325)
  %t327 = load i8*, i8** %l4
  %t328 = call i8* @sailfin_runtime_string_concat(i8* %t326, i8* %t327)
  %s329 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h151690315, i32 0, i32 0
  %t330 = call i8* @sailfin_runtime_string_concat(i8* %t328, i8* %s329)
  %t331 = load i8*, i8** %l19
  %t332 = call i8* @sailfin_runtime_string_concat(i8* %t330, i8* %t331)
  %t333 = load i8, i8* %t332
  %t334 = add i8 %t333, 96
  %t335 = alloca [2 x i8], align 1
  %t336 = getelementptr [2 x i8], [2 x i8]* %t335, i32 0, i32 0
  store i8 %t334, i8* %t336
  %t337 = getelementptr [2 x i8], [2 x i8]* %t335, i32 0, i32 1
  store i8 0, i8* %t337
  %t338 = getelementptr [2 x i8], [2 x i8]* %t335, i32 0, i32 0
  %t339 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t322, i8* %t338)
  store { i8**, i64 }* %t339, { i8**, i64 }** %l1
  %t340 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t341 = phi i1 [ %t320, %then24 ], [ %t309, %else25 ]
  %t342 = phi double [ %t321, %then24 ], [ %t312, %else25 ]
  %t343 = phi { i8**, i64 }* [ %t300, %then24 ], [ %t340, %else25 ]
  store i1 %t341, i1* %l10
  store double %t342, double* %l13
  store { i8**, i64 }* %t343, { i8**, i64 }** %l1
  %t344 = load i1, i1* %l10
  %t345 = load double, double* %l13
  %t346 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
else22:
  %t347 = load i8*, i8** %l16
  %s348 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h841337749, i32 0, i32 0
  %t349 = call i1 @starts_with(i8* %t347, i8* %s348)
  %t350 = load i8*, i8** %l0
  %t351 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t352 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t353 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t354 = load i8*, i8** %l4
  %t355 = load double, double* %l5
  %t356 = load i8*, i8** %l6
  %t357 = load i8*, i8** %l7
  %t358 = load i8*, i8** %l8
  %t359 = load i1, i1* %l9
  %t360 = load i1, i1* %l10
  %t361 = load i1, i1* %l11
  %t362 = load double, double* %l12
  %t363 = load double, double* %l13
  %t364 = load double, double* %l14
  %t365 = load double, double* %l15
  %t366 = load i8*, i8** %l16
  br i1 %t349, label %then27, label %else28
then27:
  %t367 = load i8*, i8** %l16
  %t368 = load i8*, i8** %l16
  %t369 = call i64 @sailfin_runtime_string_length(i8* %t368)
  %t370 = call i8* @sailfin_runtime_substring(i8* %t367, i64 6, i64 %t369)
  store i8* %t370, i8** %l21
  %t371 = load i8*, i8** %l21
  %t372 = call %NumberParseResult @parse_decimal_number(i8* %t371)
  store %NumberParseResult %t372, %NumberParseResult* %l22
  %t373 = load %NumberParseResult, %NumberParseResult* %l22
  %t374 = extractvalue %NumberParseResult %t373, 0
  %t375 = load i8*, i8** %l0
  %t376 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t377 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t378 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t379 = load i8*, i8** %l4
  %t380 = load double, double* %l5
  %t381 = load i8*, i8** %l6
  %t382 = load i8*, i8** %l7
  %t383 = load i8*, i8** %l8
  %t384 = load i1, i1* %l9
  %t385 = load i1, i1* %l10
  %t386 = load i1, i1* %l11
  %t387 = load double, double* %l12
  %t388 = load double, double* %l13
  %t389 = load double, double* %l14
  %t390 = load double, double* %l15
  %t391 = load i8*, i8** %l16
  %t392 = load i8*, i8** %l21
  %t393 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t374, label %then30, label %else31
then30:
  store i1 1, i1* %l11
  %t394 = load %NumberParseResult, %NumberParseResult* %l22
  %t395 = extractvalue %NumberParseResult %t394, 1
  store double %t395, double* %l14
  %t396 = load i1, i1* %l11
  %t397 = load double, double* %l14
  br label %merge32
else31:
  %t398 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s399 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t400 = call i8* @sailfin_runtime_string_concat(i8* %s399, i8* %enum_name)
  %s401 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t402 = call i8* @sailfin_runtime_string_concat(i8* %t400, i8* %s401)
  %t403 = load i8*, i8** %l4
  %t404 = call i8* @sailfin_runtime_string_concat(i8* %t402, i8* %t403)
  %s405 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1297227834, i32 0, i32 0
  %t406 = call i8* @sailfin_runtime_string_concat(i8* %t404, i8* %s405)
  %t407 = load i8*, i8** %l21
  %t408 = call i8* @sailfin_runtime_string_concat(i8* %t406, i8* %t407)
  %t409 = load i8, i8* %t408
  %t410 = add i8 %t409, 96
  %t411 = alloca [2 x i8], align 1
  %t412 = getelementptr [2 x i8], [2 x i8]* %t411, i32 0, i32 0
  store i8 %t410, i8* %t412
  %t413 = getelementptr [2 x i8], [2 x i8]* %t411, i32 0, i32 1
  store i8 0, i8* %t413
  %t414 = getelementptr [2 x i8], [2 x i8]* %t411, i32 0, i32 0
  %t415 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t398, i8* %t414)
  store { i8**, i64 }* %t415, { i8**, i64 }** %l1
  %t416 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t417 = phi i1 [ %t396, %then30 ], [ %t386, %else31 ]
  %t418 = phi double [ %t397, %then30 ], [ %t389, %else31 ]
  %t419 = phi { i8**, i64 }* [ %t376, %then30 ], [ %t416, %else31 ]
  store i1 %t417, i1* %l11
  store double %t418, double* %l14
  store { i8**, i64 }* %t419, { i8**, i64 }** %l1
  %t420 = load i1, i1* %l11
  %t421 = load double, double* %l14
  %t422 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
else28:
  %t423 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s424 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t425 = call i8* @sailfin_runtime_string_concat(i8* %s424, i8* %enum_name)
  %s426 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t427 = call i8* @sailfin_runtime_string_concat(i8* %t425, i8* %s426)
  %t428 = load i8*, i8** %l4
  %t429 = call i8* @sailfin_runtime_string_concat(i8* %t427, i8* %t428)
  %s430 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h496289716, i32 0, i32 0
  %t431 = call i8* @sailfin_runtime_string_concat(i8* %t429, i8* %s430)
  %t432 = load i8*, i8** %l16
  %t433 = call i8* @sailfin_runtime_string_concat(i8* %t431, i8* %t432)
  %t434 = load i8, i8* %t433
  %t435 = add i8 %t434, 96
  %t436 = alloca [2 x i8], align 1
  %t437 = getelementptr [2 x i8], [2 x i8]* %t436, i32 0, i32 0
  store i8 %t435, i8* %t437
  %t438 = getelementptr [2 x i8], [2 x i8]* %t436, i32 0, i32 1
  store i8 0, i8* %t438
  %t439 = getelementptr [2 x i8], [2 x i8]* %t436, i32 0, i32 0
  %t440 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t423, i8* %t439)
  store { i8**, i64 }* %t440, { i8**, i64 }** %l1
  %t441 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t442 = phi i1 [ %t420, %merge32 ], [ %t361, %else28 ]
  %t443 = phi double [ %t421, %merge32 ], [ %t364, %else28 ]
  %t444 = phi { i8**, i64 }* [ %t422, %merge32 ], [ %t441, %else28 ]
  store i1 %t442, i1* %l11
  store double %t443, double* %l14
  store { i8**, i64 }* %t444, { i8**, i64 }** %l1
  %t445 = load i1, i1* %l11
  %t446 = load double, double* %l14
  %t447 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t448 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t449 = phi i1 [ %t344, %merge26 ], [ %t284, %merge29 ]
  %t450 = phi double [ %t345, %merge26 ], [ %t287, %merge29 ]
  %t451 = phi { i8**, i64 }* [ %t346, %merge26 ], [ %t447, %merge29 ]
  %t452 = phi i1 [ %t285, %merge26 ], [ %t445, %merge29 ]
  %t453 = phi double [ %t288, %merge26 ], [ %t446, %merge29 ]
  store i1 %t449, i1* %l10
  store double %t450, double* %l13
  store { i8**, i64 }* %t451, { i8**, i64 }** %l1
  store i1 %t452, i1* %l11
  store double %t453, double* %l14
  %t454 = load i1, i1* %l10
  %t455 = load double, double* %l13
  %t456 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t457 = load i1, i1* %l11
  %t458 = load double, double* %l14
  %t459 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t460 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
merge17:
  %t461 = phi i1 [ %t268, %merge20 ], [ %t207, %merge23 ]
  %t462 = phi double [ %t269, %merge20 ], [ %t210, %merge23 ]
  %t463 = phi { i8**, i64 }* [ %t270, %merge20 ], [ %t456, %merge23 ]
  %t464 = phi i1 [ %t208, %merge20 ], [ %t454, %merge23 ]
  %t465 = phi double [ %t211, %merge20 ], [ %t455, %merge23 ]
  %t466 = phi i1 [ %t209, %merge20 ], [ %t457, %merge23 ]
  %t467 = phi double [ %t212, %merge20 ], [ %t458, %merge23 ]
  store i1 %t461, i1* %l9
  store double %t462, double* %l12
  store { i8**, i64 }* %t463, { i8**, i64 }** %l1
  store i1 %t464, i1* %l10
  store double %t465, double* %l13
  store i1 %t466, i1* %l11
  store double %t467, double* %l14
  %t468 = load i1, i1* %l9
  %t469 = load double, double* %l12
  %t470 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t471 = load i1, i1* %l10
  %t472 = load double, double* %l13
  %t473 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t474 = load i1, i1* %l11
  %t475 = load double, double* %l14
  %t476 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t477 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge14
merge14:
  %t478 = phi i8* [ %t194, %then12 ], [ %t181, %merge17 ]
  %t479 = phi i1 [ %t182, %then12 ], [ %t468, %merge17 ]
  %t480 = phi double [ %t185, %then12 ], [ %t469, %merge17 ]
  %t481 = phi { i8**, i64 }* [ %t174, %then12 ], [ %t470, %merge17 ]
  %t482 = phi i1 [ %t183, %then12 ], [ %t471, %merge17 ]
  %t483 = phi double [ %t186, %then12 ], [ %t472, %merge17 ]
  %t484 = phi i1 [ %t184, %then12 ], [ %t474, %merge17 ]
  %t485 = phi double [ %t187, %then12 ], [ %t475, %merge17 ]
  store i8* %t478, i8** %l8
  store i1 %t479, i1* %l9
  store double %t480, double* %l12
  store { i8**, i64 }* %t481, { i8**, i64 }** %l1
  store i1 %t482, i1* %l10
  store double %t483, double* %l13
  store i1 %t484, i1* %l11
  store double %t485, double* %l14
  %t486 = load double, double* %l15
  %t487 = sitofp i64 1 to double
  %t488 = fadd double %t486, %t487
  store double %t488, double* %l15
  br label %loop.latch8
loop.latch8:
  %t489 = load i8*, i8** %l8
  %t490 = load i1, i1* %l9
  %t491 = load double, double* %l12
  %t492 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t493 = load i1, i1* %l10
  %t494 = load double, double* %l13
  %t495 = load i1, i1* %l11
  %t496 = load double, double* %l14
  %t497 = load double, double* %l15
  br label %loop.header6
afterloop9:
  %t507 = load i8*, i8** %l8
  %t508 = load i1, i1* %l9
  %t509 = load double, double* %l12
  %t510 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t511 = load i1, i1* %l10
  %t512 = load double, double* %l13
  %t513 = load i1, i1* %l11
  %t514 = load double, double* %l14
  %t515 = load double, double* %l15
  %t516 = load i8*, i8** %l8
  %t517 = call i64 @sailfin_runtime_string_length(i8* %t516)
  %t518 = icmp eq i64 %t517, 0
  %t519 = load i8*, i8** %l0
  %t520 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t521 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t522 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t523 = load i8*, i8** %l4
  %t524 = load double, double* %l5
  %t525 = load i8*, i8** %l6
  %t526 = load i8*, i8** %l7
  %t527 = load i8*, i8** %l8
  %t528 = load i1, i1* %l9
  %t529 = load i1, i1* %l10
  %t530 = load i1, i1* %l11
  %t531 = load double, double* %l12
  %t532 = load double, double* %l13
  %t533 = load double, double* %l14
  %t534 = load double, double* %l15
  br i1 %t518, label %then33, label %merge34
then33:
  %t535 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s536 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t537 = call i8* @sailfin_runtime_string_concat(i8* %s536, i8* %enum_name)
  %s538 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t539 = call i8* @sailfin_runtime_string_concat(i8* %t537, i8* %s538)
  %t540 = load i8*, i8** %l4
  %t541 = call i8* @sailfin_runtime_string_concat(i8* %t539, i8* %t540)
  %s542 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1568429285, i32 0, i32 0
  %t543 = call i8* @sailfin_runtime_string_concat(i8* %t541, i8* %s542)
  %t544 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t535, i8* %t543)
  store { i8**, i64 }* %t544, { i8**, i64 }** %l1
  %t545 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t546 = phi { i8**, i64 }* [ %t545, %then33 ], [ %t520, %afterloop9 ]
  store { i8**, i64 }* %t546, { i8**, i64 }** %l1
  %t547 = load i1, i1* %l9
  %t548 = xor i1 %t547, 1
  %t549 = load i8*, i8** %l0
  %t550 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t551 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t552 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t553 = load i8*, i8** %l4
  %t554 = load double, double* %l5
  %t555 = load i8*, i8** %l6
  %t556 = load i8*, i8** %l7
  %t557 = load i8*, i8** %l8
  %t558 = load i1, i1* %l9
  %t559 = load i1, i1* %l10
  %t560 = load i1, i1* %l11
  %t561 = load double, double* %l12
  %t562 = load double, double* %l13
  %t563 = load double, double* %l14
  %t564 = load double, double* %l15
  br i1 %t548, label %then35, label %merge36
then35:
  %t565 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s566 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t567 = call i8* @sailfin_runtime_string_concat(i8* %s566, i8* %enum_name)
  %s568 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t569 = call i8* @sailfin_runtime_string_concat(i8* %t567, i8* %s568)
  %t570 = load i8*, i8** %l4
  %t571 = call i8* @sailfin_runtime_string_concat(i8* %t569, i8* %t570)
  %s572 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h625556084, i32 0, i32 0
  %t573 = call i8* @sailfin_runtime_string_concat(i8* %t571, i8* %s572)
  %t574 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t565, i8* %t573)
  store { i8**, i64 }* %t574, { i8**, i64 }** %l1
  %t575 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge36
merge36:
  %t576 = phi { i8**, i64 }* [ %t575, %then35 ], [ %t550, %merge34 ]
  store { i8**, i64 }* %t576, { i8**, i64 }** %l1
  %t577 = load i1, i1* %l10
  %t578 = xor i1 %t577, 1
  %t579 = load i8*, i8** %l0
  %t580 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t581 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t582 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t583 = load i8*, i8** %l4
  %t584 = load double, double* %l5
  %t585 = load i8*, i8** %l6
  %t586 = load i8*, i8** %l7
  %t587 = load i8*, i8** %l8
  %t588 = load i1, i1* %l9
  %t589 = load i1, i1* %l10
  %t590 = load i1, i1* %l11
  %t591 = load double, double* %l12
  %t592 = load double, double* %l13
  %t593 = load double, double* %l14
  %t594 = load double, double* %l15
  br i1 %t578, label %then37, label %merge38
then37:
  %t595 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s596 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t597 = call i8* @sailfin_runtime_string_concat(i8* %s596, i8* %enum_name)
  %s598 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t599 = call i8* @sailfin_runtime_string_concat(i8* %t597, i8* %s598)
  %t600 = load i8*, i8** %l4
  %t601 = call i8* @sailfin_runtime_string_concat(i8* %t599, i8* %t600)
  %s602 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h608364678, i32 0, i32 0
  %t603 = call i8* @sailfin_runtime_string_concat(i8* %t601, i8* %s602)
  %t604 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t595, i8* %t603)
  store { i8**, i64 }* %t604, { i8**, i64 }** %l1
  %t605 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge38
merge38:
  %t606 = phi { i8**, i64 }* [ %t605, %then37 ], [ %t580, %merge36 ]
  store { i8**, i64 }* %t606, { i8**, i64 }** %l1
  %t607 = load i1, i1* %l11
  %t608 = xor i1 %t607, 1
  %t609 = load i8*, i8** %l0
  %t610 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t611 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t612 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t613 = load i8*, i8** %l4
  %t614 = load double, double* %l5
  %t615 = load i8*, i8** %l6
  %t616 = load i8*, i8** %l7
  %t617 = load i8*, i8** %l8
  %t618 = load i1, i1* %l9
  %t619 = load i1, i1* %l10
  %t620 = load i1, i1* %l11
  %t621 = load double, double* %l12
  %t622 = load double, double* %l13
  %t623 = load double, double* %l14
  %t624 = load double, double* %l15
  br i1 %t608, label %then39, label %merge40
then39:
  %t625 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s626 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t627 = call i8* @sailfin_runtime_string_concat(i8* %s626, i8* %enum_name)
  %s628 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t629 = call i8* @sailfin_runtime_string_concat(i8* %t627, i8* %s628)
  %t630 = load i8*, i8** %l4
  %t631 = call i8* @sailfin_runtime_string_concat(i8* %t629, i8* %t630)
  %s632 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h2112628887, i32 0, i32 0
  %t633 = call i8* @sailfin_runtime_string_concat(i8* %t631, i8* %s632)
  %t634 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t625, i8* %t633)
  store { i8**, i64 }* %t634, { i8**, i64 }** %l1
  %t635 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge40
merge40:
  %t636 = phi { i8**, i64 }* [ %t635, %then39 ], [ %t610, %merge38 ]
  store { i8**, i64 }* %t636, { i8**, i64 }** %l1
  %t638 = load i8*, i8** %l8
  %t639 = call i64 @sailfin_runtime_string_length(i8* %t638)
  %t640 = icmp sgt i64 %t639, 0
  br label %logical_and_entry_637

logical_and_entry_637:
  br i1 %t640, label %logical_and_right_637, label %logical_and_merge_637

logical_and_right_637:
  %t642 = load i1, i1* %l9
  br label %logical_and_entry_641

logical_and_entry_641:
  br i1 %t642, label %logical_and_right_641, label %logical_and_merge_641

logical_and_right_641:
  %t644 = load i1, i1* %l10
  br label %logical_and_entry_643

logical_and_entry_643:
  br i1 %t644, label %logical_and_right_643, label %logical_and_merge_643

logical_and_right_643:
  %t646 = load i1, i1* %l11
  br label %logical_and_entry_645

logical_and_entry_645:
  br i1 %t646, label %logical_and_right_645, label %logical_and_merge_645

logical_and_right_645:
  %t647 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t648 = load { i8**, i64 }, { i8**, i64 }* %t647
  %t649 = extractvalue { i8**, i64 } %t648, 1
  %t650 = icmp eq i64 %t649, 0
  br label %logical_and_right_end_645

logical_and_right_end_645:
  br label %logical_and_merge_645

logical_and_merge_645:
  %t651 = phi i1 [ false, %logical_and_entry_645 ], [ %t650, %logical_and_right_end_645 ]
  br label %logical_and_right_end_643

logical_and_right_end_643:
  br label %logical_and_merge_643

logical_and_merge_643:
  %t652 = phi i1 [ false, %logical_and_entry_643 ], [ %t651, %logical_and_right_end_643 ]
  br label %logical_and_right_end_641

logical_and_right_end_641:
  br label %logical_and_merge_641

logical_and_merge_641:
  %t653 = phi i1 [ false, %logical_and_entry_641 ], [ %t652, %logical_and_right_end_641 ]
  br label %logical_and_right_end_637

logical_and_right_end_637:
  br label %logical_and_merge_637

logical_and_merge_637:
  %t654 = phi i1 [ false, %logical_and_entry_637 ], [ %t653, %logical_and_right_end_637 ]
  store i1 %t654, i1* %l23
  %t655 = load i8*, i8** %l7
  %t656 = insertvalue %NativeStructLayoutField undef, i8* %t655, 0
  %t657 = load i8*, i8** %l8
  %t658 = insertvalue %NativeStructLayoutField %t656, i8* %t657, 1
  %t659 = load double, double* %l12
  %t660 = insertvalue %NativeStructLayoutField %t658, double %t659, 2
  %t661 = load double, double* %l13
  %t662 = insertvalue %NativeStructLayoutField %t660, double %t661, 3
  %t663 = load double, double* %l14
  %t664 = insertvalue %NativeStructLayoutField %t662, double %t663, 4
  store %NativeStructLayoutField %t664, %NativeStructLayoutField* %l24
  %t665 = load i1, i1* %l23
  %t666 = insertvalue %EnumLayoutPayloadParse undef, i1 %t665, 0
  %t667 = load i8*, i8** %l6
  %t668 = insertvalue %EnumLayoutPayloadParse %t666, i8* %t667, 1
  %t669 = load %NativeStructLayoutField, %NativeStructLayoutField* %l24
  %t670 = insertvalue %EnumLayoutPayloadParse %t668, %NativeStructLayoutField %t669, 2
  %t671 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t672 = insertvalue %EnumLayoutPayloadParse %t670, { i8**, i64 }* %t671, 3
  ret %EnumLayoutPayloadParse %t672
}

define %NativeInstruction @parse_let_instruction(i8* %line, %NativeSourceSpan* %span, %NativeSourceSpan* %value_span) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i1
  %l2 = alloca i8*
  %l3 = alloca %BindingComponents
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2064124065, i32 0, i32 0
  %t1 = call i8* @strip_prefix(i8* %line, i8* %s0)
  %t2 = call i8* @trim_text(i8* %t1)
  store i8* %t2, i8** %l0
  store i1 0, i1* %l1
  %t3 = load i8*, i8** %l0
  store i8* %t3, i8** %l2
  %t4 = load i8*, i8** %l2
  %s5 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t6 = call i1 @starts_with(i8* %t4, i8* %s5)
  %t7 = load i8*, i8** %l0
  %t8 = load i1, i1* %l1
  %t9 = load i8*, i8** %l2
  br i1 %t6, label %then0, label %merge1
then0:
  store i1 1, i1* %l1
  %t10 = load i8*, i8** %l2
  %s11 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t12 = call i8* @strip_prefix(i8* %t10, i8* %s11)
  %t13 = call i8* @trim_text(i8* %t12)
  store i8* %t13, i8** %l2
  %t14 = load i1, i1* %l1
  %t15 = load i8*, i8** %l2
  br label %merge1
merge1:
  %t16 = phi i1 [ %t14, %then0 ], [ %t8, %entry ]
  %t17 = phi i8* [ %t15, %then0 ], [ %t9, %entry ]
  store i1 %t16, i1* %l1
  store i8* %t17, i8** %l2
  %t18 = load i8*, i8** %l2
  %t19 = call %BindingComponents @parse_binding_components(i8* %t18)
  store %BindingComponents %t19, %BindingComponents* %l3
  %t20 = alloca %NativeInstruction
  %t21 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 0
  store i32 2, i32* %t21
  %t22 = load %BindingComponents, %BindingComponents* %l3
  %t23 = extractvalue %BindingComponents %t22, 0
  %t24 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t25 = bitcast [48 x i8]* %t24 to i8*
  %t26 = bitcast i8* %t25 to i8**
  store i8* %t23, i8** %t26
  %t27 = load i1, i1* %l1
  %t28 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t29 = bitcast [48 x i8]* %t28 to i8*
  %t30 = getelementptr inbounds i8, i8* %t29, i64 8
  %t31 = bitcast i8* %t30 to i1*
  store i1 %t27, i1* %t31
  %t32 = load %BindingComponents, %BindingComponents* %l3
  %t33 = extractvalue %BindingComponents %t32, 1
  %t34 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t35 = bitcast [48 x i8]* %t34 to i8*
  %t36 = getelementptr inbounds i8, i8* %t35, i64 16
  %t37 = bitcast i8* %t36 to i8**
  store i8* %t33, i8** %t37
  %t38 = load %BindingComponents, %BindingComponents* %l3
  %t39 = extractvalue %BindingComponents %t38, 2
  %t40 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t41 = bitcast [48 x i8]* %t40 to i8*
  %t42 = getelementptr inbounds i8, i8* %t41, i64 24
  %t43 = bitcast i8* %t42 to i8**
  store i8* %t39, i8** %t43
  %t44 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t45 = bitcast [48 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t47
  %t48 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t49 = bitcast [48 x i8]* %t48 to i8*
  %t50 = getelementptr inbounds i8, i8* %t49, i64 40
  %t51 = bitcast i8* %t50 to %NativeSourceSpan**
  store %NativeSourceSpan* %value_span, %NativeSourceSpan** %t51
  %t52 = load %NativeInstruction, %NativeInstruction* %t20
  ret %NativeInstruction %t52
}

define %BindingComponents @parse_binding_components(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca double
  %l9 = alloca i8*
  %l10 = alloca i8*
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t40 = phi i8* [ %t2, %entry ], [ %t38, %loop.latch2 ]
  %t41 = phi double [ %t3, %entry ], [ %t39, %loop.latch2 ]
  store i8* %t40, i8** %l0
  store double %t41, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = call i64 @sailfin_runtime_string_length(i8* %text)
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
  %t12 = getelementptr i8, i8* %text, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l2
  %t15 = load i8, i8* %l2
  %t16 = icmp eq i8 %t15, 32
  br label %logical_or_entry_14

logical_or_entry_14:
  br i1 %t16, label %logical_or_merge_14, label %logical_or_right_14

logical_or_right_14:
  %t18 = load i8, i8* %l2
  %t19 = icmp eq i8 %t18, 58
  br label %logical_or_entry_17

logical_or_entry_17:
  br i1 %t19, label %logical_or_merge_17, label %logical_or_right_17

logical_or_right_17:
  %t20 = load i8, i8* %l2
  %t21 = icmp eq i8 %t20, 61
  br label %logical_or_right_end_17

logical_or_right_end_17:
  br label %logical_or_merge_17

logical_or_merge_17:
  %t22 = phi i1 [ true, %logical_or_entry_17 ], [ %t21, %logical_or_right_end_17 ]
  br label %logical_or_right_end_14

logical_or_right_end_14:
  br label %logical_or_merge_14

logical_or_merge_14:
  %t23 = phi i1 [ true, %logical_or_entry_14 ], [ %t22, %logical_or_right_end_14 ]
  %t24 = load i8*, i8** %l0
  %t25 = load double, double* %l1
  %t26 = load i8, i8* %l2
  br i1 %t23, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t27 = load i8*, i8** %l0
  %t28 = load i8, i8* %l2
  %t29 = load i8, i8* %t27
  %t30 = add i8 %t29, %t28
  %t31 = alloca [2 x i8], align 1
  %t32 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 0
  store i8 %t30, i8* %t32
  %t33 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 1
  store i8 0, i8* %t33
  %t34 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 0
  store i8* %t34, i8** %l0
  %t35 = load double, double* %l1
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l1
  br label %loop.latch2
loop.latch2:
  %t38 = load i8*, i8** %l0
  %t39 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t42 = load i8*, i8** %l0
  %t43 = load double, double* %l1
  %t44 = load i8*, i8** %l0
  %t45 = call i8* @trim_text(i8* %t44)
  store i8* %t45, i8** %l0
  %s46 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s46, i8** %l3
  store i8* null, i8** %l4
  %t47 = load double, double* %l1
  %t48 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t49 = fptosi double %t47 to i64
  %t50 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t49, i64 %t48)
  %t51 = call i8* @trim_text(i8* %t50)
  store i8* %t51, i8** %l5
  %t52 = load i8*, i8** %l5
  %t53 = call i64 @sailfin_runtime_string_length(i8* %t52)
  %t54 = icmp sgt i64 %t53, 0
  %t55 = load i8*, i8** %l0
  %t56 = load double, double* %l1
  %t57 = load i8*, i8** %l3
  %t58 = load i8*, i8** %l4
  %t59 = load i8*, i8** %l5
  br i1 %t54, label %then8, label %merge9
then8:
  %t60 = load i8*, i8** %l5
  %s61 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t62 = call i1 @starts_with(i8* %t60, i8* %s61)
  %t63 = load i8*, i8** %l0
  %t64 = load double, double* %l1
  %t65 = load i8*, i8** %l3
  %t66 = load i8*, i8** %l4
  %t67 = load i8*, i8** %l5
  br i1 %t62, label %then10, label %else11
then10:
  %t68 = load i8*, i8** %l5
  %s69 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t70 = call i8* @strip_prefix(i8* %t68, i8* %s69)
  %t71 = call i8* @trim_text(i8* %t70)
  store i8* %t71, i8** %l5
  %t72 = load i8*, i8** %l5
  %t73 = alloca [2 x i8], align 1
  %t74 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 0
  store i8 61, i8* %t74
  %t75 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 1
  store i8 0, i8* %t75
  %t76 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 0
  %t77 = call double @index_of(i8* %t72, i8* %t76)
  store double %t77, double* %l6
  %t78 = load double, double* %l6
  %t79 = sitofp i64 0 to double
  %t80 = fcmp oge double %t78, %t79
  %t81 = load i8*, i8** %l0
  %t82 = load double, double* %l1
  %t83 = load i8*, i8** %l3
  %t84 = load i8*, i8** %l4
  %t85 = load i8*, i8** %l5
  %t86 = load double, double* %l6
  br i1 %t80, label %then13, label %else14
then13:
  %t87 = load i8*, i8** %l5
  %t88 = load double, double* %l6
  %t89 = fptosi double %t88 to i64
  %t90 = call i8* @sailfin_runtime_substring(i8* %t87, i64 0, i64 %t89)
  %t91 = call i8* @trim_text(i8* %t90)
  store i8* %t91, i8** %l3
  %t92 = load i8*, i8** %l5
  %t93 = load double, double* %l6
  %t94 = sitofp i64 1 to double
  %t95 = fadd double %t93, %t94
  %t96 = load i8*, i8** %l5
  %t97 = call i64 @sailfin_runtime_string_length(i8* %t96)
  %t98 = fptosi double %t95 to i64
  %t99 = call i8* @sailfin_runtime_substring(i8* %t92, i64 %t98, i64 %t97)
  %t100 = call i8* @trim_text(i8* %t99)
  store i8* %t100, i8** %l7
  %t101 = load i8*, i8** %l7
  %t102 = call i64 @sailfin_runtime_string_length(i8* %t101)
  %t103 = icmp sgt i64 %t102, 0
  %t104 = load i8*, i8** %l0
  %t105 = load double, double* %l1
  %t106 = load i8*, i8** %l3
  %t107 = load i8*, i8** %l4
  %t108 = load i8*, i8** %l5
  %t109 = load double, double* %l6
  %t110 = load i8*, i8** %l7
  br i1 %t103, label %then16, label %merge17
then16:
  %t111 = load i8*, i8** %l7
  store i8* %t111, i8** %l4
  %t112 = load i8*, i8** %l4
  br label %merge17
merge17:
  %t113 = phi i8* [ %t112, %then16 ], [ %t107, %then13 ]
  store i8* %t113, i8** %l4
  %t114 = load i8*, i8** %l3
  %t115 = load i8*, i8** %l4
  br label %merge15
else14:
  %t116 = load i8*, i8** %l5
  %t117 = call i8* @trim_text(i8* %t116)
  store i8* %t117, i8** %l3
  %t118 = load i8*, i8** %l3
  br label %merge15
merge15:
  %t119 = phi i8* [ %t114, %merge17 ], [ %t118, %else14 ]
  %t120 = phi i8* [ %t115, %merge17 ], [ %t84, %else14 ]
  store i8* %t119, i8** %l3
  store i8* %t120, i8** %l4
  %t121 = load i8*, i8** %l5
  %t122 = load i8*, i8** %l3
  %t123 = load i8*, i8** %l4
  %t124 = load i8*, i8** %l3
  br label %merge12
else11:
  %t125 = load i8*, i8** %l5
  %t126 = alloca [2 x i8], align 1
  %t127 = getelementptr [2 x i8], [2 x i8]* %t126, i32 0, i32 0
  store i8 58, i8* %t127
  %t128 = getelementptr [2 x i8], [2 x i8]* %t126, i32 0, i32 1
  store i8 0, i8* %t128
  %t129 = getelementptr [2 x i8], [2 x i8]* %t126, i32 0, i32 0
  %t130 = call i1 @starts_with(i8* %t125, i8* %t129)
  %t131 = load i8*, i8** %l0
  %t132 = load double, double* %l1
  %t133 = load i8*, i8** %l3
  %t134 = load i8*, i8** %l4
  %t135 = load i8*, i8** %l5
  br i1 %t130, label %then18, label %else19
then18:
  %t136 = load i8*, i8** %l5
  %t137 = alloca [2 x i8], align 1
  %t138 = getelementptr [2 x i8], [2 x i8]* %t137, i32 0, i32 0
  store i8 58, i8* %t138
  %t139 = getelementptr [2 x i8], [2 x i8]* %t137, i32 0, i32 1
  store i8 0, i8* %t139
  %t140 = getelementptr [2 x i8], [2 x i8]* %t137, i32 0, i32 0
  %t141 = call i8* @strip_prefix(i8* %t136, i8* %t140)
  %t142 = call i8* @trim_text(i8* %t141)
  store i8* %t142, i8** %l5
  %t143 = load i8*, i8** %l5
  %t144 = alloca [2 x i8], align 1
  %t145 = getelementptr [2 x i8], [2 x i8]* %t144, i32 0, i32 0
  store i8 61, i8* %t145
  %t146 = getelementptr [2 x i8], [2 x i8]* %t144, i32 0, i32 1
  store i8 0, i8* %t146
  %t147 = getelementptr [2 x i8], [2 x i8]* %t144, i32 0, i32 0
  %t148 = call double @index_of(i8* %t143, i8* %t147)
  store double %t148, double* %l8
  %t149 = load double, double* %l8
  %t150 = sitofp i64 0 to double
  %t151 = fcmp oge double %t149, %t150
  %t152 = load i8*, i8** %l0
  %t153 = load double, double* %l1
  %t154 = load i8*, i8** %l3
  %t155 = load i8*, i8** %l4
  %t156 = load i8*, i8** %l5
  %t157 = load double, double* %l8
  br i1 %t151, label %then21, label %else22
then21:
  %t158 = load i8*, i8** %l5
  %t159 = load double, double* %l8
  %t160 = fptosi double %t159 to i64
  %t161 = call i8* @sailfin_runtime_substring(i8* %t158, i64 0, i64 %t160)
  %t162 = call i8* @trim_text(i8* %t161)
  store i8* %t162, i8** %l3
  %t163 = load i8*, i8** %l5
  %t164 = load double, double* %l8
  %t165 = sitofp i64 1 to double
  %t166 = fadd double %t164, %t165
  %t167 = load i8*, i8** %l5
  %t168 = call i64 @sailfin_runtime_string_length(i8* %t167)
  %t169 = fptosi double %t166 to i64
  %t170 = call i8* @sailfin_runtime_substring(i8* %t163, i64 %t169, i64 %t168)
  %t171 = call i8* @trim_text(i8* %t170)
  store i8* %t171, i8** %l9
  %t172 = load i8*, i8** %l9
  %t173 = call i64 @sailfin_runtime_string_length(i8* %t172)
  %t174 = icmp sgt i64 %t173, 0
  %t175 = load i8*, i8** %l0
  %t176 = load double, double* %l1
  %t177 = load i8*, i8** %l3
  %t178 = load i8*, i8** %l4
  %t179 = load i8*, i8** %l5
  %t180 = load double, double* %l8
  %t181 = load i8*, i8** %l9
  br i1 %t174, label %then24, label %merge25
then24:
  %t182 = load i8*, i8** %l9
  store i8* %t182, i8** %l4
  %t183 = load i8*, i8** %l4
  br label %merge25
merge25:
  %t184 = phi i8* [ %t183, %then24 ], [ %t178, %then21 ]
  store i8* %t184, i8** %l4
  %t185 = load i8*, i8** %l3
  %t186 = load i8*, i8** %l4
  br label %merge23
else22:
  %t187 = load i8*, i8** %l5
  %t188 = call i8* @trim_text(i8* %t187)
  store i8* %t188, i8** %l3
  %t189 = load i8*, i8** %l3
  br label %merge23
merge23:
  %t190 = phi i8* [ %t185, %merge25 ], [ %t189, %else22 ]
  %t191 = phi i8* [ %t186, %merge25 ], [ %t155, %else22 ]
  store i8* %t190, i8** %l3
  store i8* %t191, i8** %l4
  %t192 = load i8*, i8** %l5
  %t193 = load i8*, i8** %l3
  %t194 = load i8*, i8** %l4
  %t195 = load i8*, i8** %l3
  br label %merge20
else19:
  %t196 = load i8*, i8** %l5
  %t197 = alloca [2 x i8], align 1
  %t198 = getelementptr [2 x i8], [2 x i8]* %t197, i32 0, i32 0
  store i8 61, i8* %t198
  %t199 = getelementptr [2 x i8], [2 x i8]* %t197, i32 0, i32 1
  store i8 0, i8* %t199
  %t200 = getelementptr [2 x i8], [2 x i8]* %t197, i32 0, i32 0
  %t201 = call i1 @starts_with(i8* %t196, i8* %t200)
  %t202 = load i8*, i8** %l0
  %t203 = load double, double* %l1
  %t204 = load i8*, i8** %l3
  %t205 = load i8*, i8** %l4
  %t206 = load i8*, i8** %l5
  br i1 %t201, label %then26, label %else27
then26:
  %t207 = load i8*, i8** %l5
  %t208 = alloca [2 x i8], align 1
  %t209 = getelementptr [2 x i8], [2 x i8]* %t208, i32 0, i32 0
  store i8 61, i8* %t209
  %t210 = getelementptr [2 x i8], [2 x i8]* %t208, i32 0, i32 1
  store i8 0, i8* %t210
  %t211 = getelementptr [2 x i8], [2 x i8]* %t208, i32 0, i32 0
  %t212 = call i8* @strip_prefix(i8* %t207, i8* %t211)
  %t213 = call i8* @trim_text(i8* %t212)
  store i8* %t213, i8** %l10
  %t214 = load i8*, i8** %l10
  %t215 = call i64 @sailfin_runtime_string_length(i8* %t214)
  %t216 = icmp sgt i64 %t215, 0
  %t217 = load i8*, i8** %l0
  %t218 = load double, double* %l1
  %t219 = load i8*, i8** %l3
  %t220 = load i8*, i8** %l4
  %t221 = load i8*, i8** %l5
  %t222 = load i8*, i8** %l10
  br i1 %t216, label %then29, label %merge30
then29:
  %t223 = load i8*, i8** %l10
  store i8* %t223, i8** %l4
  %t224 = load i8*, i8** %l4
  br label %merge30
merge30:
  %t225 = phi i8* [ %t224, %then29 ], [ %t220, %then26 ]
  store i8* %t225, i8** %l4
  %t226 = load i8*, i8** %l4
  br label %merge28
else27:
  %t227 = load i8*, i8** %l5
  store i8* %t227, i8** %l4
  %t228 = load i8*, i8** %l4
  br label %merge28
merge28:
  %t229 = phi i8* [ %t226, %merge30 ], [ %t228, %else27 ]
  store i8* %t229, i8** %l4
  %t230 = load i8*, i8** %l4
  %t231 = load i8*, i8** %l4
  br label %merge20
merge20:
  %t232 = phi i8* [ %t192, %merge23 ], [ %t135, %merge28 ]
  %t233 = phi i8* [ %t193, %merge23 ], [ %t133, %merge28 ]
  %t234 = phi i8* [ %t194, %merge23 ], [ %t230, %merge28 ]
  store i8* %t232, i8** %l5
  store i8* %t233, i8** %l3
  store i8* %t234, i8** %l4
  %t235 = load i8*, i8** %l5
  %t236 = load i8*, i8** %l3
  %t237 = load i8*, i8** %l4
  %t238 = load i8*, i8** %l3
  %t239 = load i8*, i8** %l4
  %t240 = load i8*, i8** %l4
  br label %merge12
merge12:
  %t241 = phi i8* [ %t121, %merge15 ], [ %t235, %merge20 ]
  %t242 = phi i8* [ %t122, %merge15 ], [ %t236, %merge20 ]
  %t243 = phi i8* [ %t123, %merge15 ], [ %t237, %merge20 ]
  store i8* %t241, i8** %l5
  store i8* %t242, i8** %l3
  store i8* %t243, i8** %l4
  %t244 = load i8*, i8** %l5
  %t245 = load i8*, i8** %l3
  %t246 = load i8*, i8** %l4
  %t247 = load i8*, i8** %l3
  %t248 = load i8*, i8** %l5
  %t249 = load i8*, i8** %l3
  %t250 = load i8*, i8** %l4
  %t251 = load i8*, i8** %l3
  %t252 = load i8*, i8** %l4
  %t253 = load i8*, i8** %l4
  br label %merge9
merge9:
  %t254 = phi i8* [ %t244, %merge12 ], [ %t59, %afterloop3 ]
  %t255 = phi i8* [ %t245, %merge12 ], [ %t57, %afterloop3 ]
  %t256 = phi i8* [ %t246, %merge12 ], [ %t58, %afterloop3 ]
  %t257 = phi i8* [ %t247, %merge12 ], [ %t57, %afterloop3 ]
  %t258 = phi i8* [ %t248, %merge12 ], [ %t59, %afterloop3 ]
  %t259 = phi i8* [ %t249, %merge12 ], [ %t57, %afterloop3 ]
  %t260 = phi i8* [ %t250, %merge12 ], [ %t58, %afterloop3 ]
  %t261 = phi i8* [ %t251, %merge12 ], [ %t57, %afterloop3 ]
  %t262 = phi i8* [ %t252, %merge12 ], [ %t58, %afterloop3 ]
  %t263 = phi i8* [ %t253, %merge12 ], [ %t58, %afterloop3 ]
  store i8* %t254, i8** %l5
  store i8* %t255, i8** %l3
  store i8* %t256, i8** %l4
  store i8* %t257, i8** %l3
  store i8* %t258, i8** %l5
  store i8* %t259, i8** %l3
  store i8* %t260, i8** %l4
  store i8* %t261, i8** %l3
  store i8* %t262, i8** %l4
  store i8* %t263, i8** %l4
  %t264 = load i8*, i8** %l0
  %t265 = insertvalue %BindingComponents undef, i8* %t264, 0
  %t266 = load i8*, i8** %l3
  %t267 = insertvalue %BindingComponents %t265, i8* %t266, 1
  %t268 = load i8*, i8** %l4
  %t269 = insertvalue %BindingComponents %t267, i8* %t268, 2
  ret %BindingComponents %t269
}

define i8* @parse_function_name(i8* %header) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %t0 = call i8* @trim_text(i8* %header)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1134498859, i32 0, i32 0
  %t3 = call i1 @starts_with(i8* %t1, i8* %s2)
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %s6 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1134498859, i32 0, i32 0
  %t7 = call i8* @strip_prefix(i8* %t5, i8* %s6)
  %t8 = call i8* @trim_text(i8* %t7)
  store i8* %t8, i8** %l0
  %t9 = load i8*, i8** %l0
  br label %merge1
merge1:
  %t10 = phi i8* [ %t9, %then0 ], [ %t4, %entry ]
  store i8* %t10, i8** %l0
  %t11 = load i8*, i8** %l0
  %t12 = alloca [2 x i8], align 1
  %t13 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  store i8 40, i8* %t13
  %t14 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 1
  store i8 0, i8* %t14
  %t15 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  %t16 = call double @index_of(i8* %t11, i8* %t15)
  store double %t16, double* %l1
  %t17 = load i8*, i8** %l0
  store i8* %t17, i8** %l2
  %t18 = load double, double* %l1
  %t19 = sitofp i64 0 to double
  %t20 = fcmp oge double %t18, %t19
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l1
  %t23 = load i8*, i8** %l2
  br i1 %t20, label %then2, label %merge3
then2:
  %t24 = load i8*, i8** %l0
  %t25 = load double, double* %l1
  %t26 = fptosi double %t25 to i64
  %t27 = call i8* @sailfin_runtime_substring(i8* %t24, i64 0, i64 %t26)
  %t28 = call i8* @trim_text(i8* %t27)
  store i8* %t28, i8** %l2
  %t29 = load i8*, i8** %l2
  br label %merge3
merge3:
  %t30 = phi i8* [ %t29, %then2 ], [ %t23, %merge1 ]
  store i8* %t30, i8** %l2
  %t31 = load i8*, i8** %l2
  %t32 = alloca [2 x i8], align 1
  %t33 = getelementptr [2 x i8], [2 x i8]* %t32, i32 0, i32 0
  store i8 46, i8* %t33
  %t34 = getelementptr [2 x i8], [2 x i8]* %t32, i32 0, i32 1
  store i8 0, i8* %t34
  %t35 = getelementptr [2 x i8], [2 x i8]* %t32, i32 0, i32 0
  %t36 = call double @last_index_of(i8* %t31, i8* %t35)
  store double %t36, double* %l3
  %t37 = load double, double* %l3
  %t38 = sitofp i64 0 to double
  %t39 = fcmp oge double %t37, %t38
  %t40 = load i8*, i8** %l0
  %t41 = load double, double* %l1
  %t42 = load i8*, i8** %l2
  %t43 = load double, double* %l3
  br i1 %t39, label %then4, label %merge5
then4:
  %t44 = load i8*, i8** %l2
  %t45 = load double, double* %l3
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  %t48 = load i8*, i8** %l2
  %t49 = call i64 @sailfin_runtime_string_length(i8* %t48)
  %t50 = fptosi double %t47 to i64
  %t51 = call i8* @sailfin_runtime_substring(i8* %t44, i64 %t50, i64 %t49)
  %t52 = call i8* @trim_text(i8* %t51)
  store i8* %t52, i8** %l2
  %t53 = load i8*, i8** %l2
  br label %merge5
merge5:
  %t54 = phi i8* [ %t53, %then4 ], [ %t42, %merge3 ]
  store i8* %t54, i8** %l2
  %t55 = load i8*, i8** %l2
  %t56 = call i8* @strip_generics(i8* %t55)
  ret i8* %t56
}

define %NativeParameter* @parse_parameter_entry(i8* %body, %NativeSourceSpan* %span) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i1
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca double
  %l9 = alloca i8*
  %l10 = alloca i8*
  %t0 = call i8* @trim_text(i8* %body)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = bitcast i8* null to %NativeParameter*
  ret %NativeParameter* %t5
merge1:
  store i1 0, i1* %l1
  %t6 = load i8*, i8** %l0
  %s7 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t8 = call i1 @starts_with(i8* %t6, i8* %s7)
  %t9 = load i8*, i8** %l0
  %t10 = load i1, i1* %l1
  br i1 %t8, label %then2, label %merge3
then2:
  store i1 1, i1* %l1
  %t11 = load i8*, i8** %l0
  %s12 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t13 = call i8* @strip_prefix(i8* %t11, i8* %s12)
  %t14 = call i8* @trim_text(i8* %t13)
  store i8* %t14, i8** %l0
  %t15 = load i1, i1* %l1
  %t16 = load i8*, i8** %l0
  br label %merge3
merge3:
  %t17 = phi i1 [ %t15, %then2 ], [ %t10, %merge1 ]
  %t18 = phi i8* [ %t16, %then2 ], [ %t9, %merge1 ]
  store i1 %t17, i1* %l1
  store i8* %t18, i8** %l0
  %s19 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s19, i8** %l2
  %t20 = sitofp i64 0 to double
  store double %t20, double* %l3
  %t21 = load i8*, i8** %l0
  %t22 = load i1, i1* %l1
  %t23 = load i8*, i8** %l2
  %t24 = load double, double* %l3
  br label %loop.header4
loop.header4:
  %t67 = phi i8* [ %t23, %merge3 ], [ %t65, %loop.latch6 ]
  %t68 = phi double [ %t24, %merge3 ], [ %t66, %loop.latch6 ]
  store i8* %t67, i8** %l2
  store double %t68, double* %l3
  br label %loop.body5
loop.body5:
  %t25 = load double, double* %l3
  %t26 = load i8*, i8** %l0
  %t27 = call i64 @sailfin_runtime_string_length(i8* %t26)
  %t28 = sitofp i64 %t27 to double
  %t29 = fcmp oge double %t25, %t28
  %t30 = load i8*, i8** %l0
  %t31 = load i1, i1* %l1
  %t32 = load i8*, i8** %l2
  %t33 = load double, double* %l3
  br i1 %t29, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l3
  %t36 = fptosi double %t35 to i64
  %t37 = getelementptr i8, i8* %t34, i64 %t36
  %t38 = load i8, i8* %t37
  store i8 %t38, i8* %l4
  %t40 = load i8, i8* %l4
  %t41 = icmp eq i8 %t40, 32
  br label %logical_or_entry_39

logical_or_entry_39:
  br i1 %t41, label %logical_or_merge_39, label %logical_or_right_39

logical_or_right_39:
  %t43 = load i8, i8* %l4
  %t44 = icmp eq i8 %t43, 45
  br label %logical_or_entry_42

logical_or_entry_42:
  br i1 %t44, label %logical_or_merge_42, label %logical_or_right_42

logical_or_right_42:
  %t45 = load i8, i8* %l4
  %t46 = icmp eq i8 %t45, 61
  br label %logical_or_right_end_42

logical_or_right_end_42:
  br label %logical_or_merge_42

logical_or_merge_42:
  %t47 = phi i1 [ true, %logical_or_entry_42 ], [ %t46, %logical_or_right_end_42 ]
  br label %logical_or_right_end_39

logical_or_right_end_39:
  br label %logical_or_merge_39

logical_or_merge_39:
  %t48 = phi i1 [ true, %logical_or_entry_39 ], [ %t47, %logical_or_right_end_39 ]
  %t49 = load i8*, i8** %l0
  %t50 = load i1, i1* %l1
  %t51 = load i8*, i8** %l2
  %t52 = load double, double* %l3
  %t53 = load i8, i8* %l4
  br i1 %t48, label %then10, label %merge11
then10:
  br label %afterloop7
merge11:
  %t54 = load i8*, i8** %l2
  %t55 = load i8, i8* %l4
  %t56 = load i8, i8* %t54
  %t57 = add i8 %t56, %t55
  %t58 = alloca [2 x i8], align 1
  %t59 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  store i8 %t57, i8* %t59
  %t60 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 1
  store i8 0, i8* %t60
  %t61 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  store i8* %t61, i8** %l2
  %t62 = load double, double* %l3
  %t63 = sitofp i64 1 to double
  %t64 = fadd double %t62, %t63
  store double %t64, double* %l3
  br label %loop.latch6
loop.latch6:
  %t65 = load i8*, i8** %l2
  %t66 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t69 = load i8*, i8** %l2
  %t70 = load double, double* %l3
  %t71 = load i8*, i8** %l2
  %t72 = call i8* @trim_text(i8* %t71)
  store i8* %t72, i8** %l2
  %t73 = load i8*, i8** %l2
  %t74 = call i64 @sailfin_runtime_string_length(i8* %t73)
  %t75 = icmp eq i64 %t74, 0
  %t76 = load i8*, i8** %l0
  %t77 = load i1, i1* %l1
  %t78 = load i8*, i8** %l2
  %t79 = load double, double* %l3
  br i1 %t75, label %then12, label %merge13
then12:
  %t80 = bitcast i8* null to %NativeParameter*
  ret %NativeParameter* %t80
merge13:
  %s81 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s81, i8** %l5
  store i8* null, i8** %l6
  %t82 = load i8*, i8** %l0
  %t83 = load double, double* %l3
  %t84 = load i8*, i8** %l0
  %t85 = call i64 @sailfin_runtime_string_length(i8* %t84)
  %t86 = fptosi double %t83 to i64
  %t87 = call i8* @sailfin_runtime_substring(i8* %t82, i64 %t86, i64 %t85)
  %t88 = call i8* @trim_text(i8* %t87)
  store i8* %t88, i8** %l7
  %t89 = load i8*, i8** %l7
  %t90 = call i64 @sailfin_runtime_string_length(i8* %t89)
  %t91 = icmp sgt i64 %t90, 0
  %t92 = load i8*, i8** %l0
  %t93 = load i1, i1* %l1
  %t94 = load i8*, i8** %l2
  %t95 = load double, double* %l3
  %t96 = load i8*, i8** %l5
  %t97 = load i8*, i8** %l6
  %t98 = load i8*, i8** %l7
  br i1 %t91, label %then14, label %merge15
then14:
  %t99 = load i8*, i8** %l7
  %s100 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t101 = call i1 @starts_with(i8* %t99, i8* %s100)
  %t102 = load i8*, i8** %l0
  %t103 = load i1, i1* %l1
  %t104 = load i8*, i8** %l2
  %t105 = load double, double* %l3
  %t106 = load i8*, i8** %l5
  %t107 = load i8*, i8** %l6
  %t108 = load i8*, i8** %l7
  br i1 %t101, label %then16, label %else17
then16:
  %t109 = load i8*, i8** %l7
  %s110 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t111 = call i8* @strip_prefix(i8* %t109, i8* %s110)
  %t112 = call i8* @trim_text(i8* %t111)
  store i8* %t112, i8** %l7
  %t113 = load i8*, i8** %l7
  %t114 = alloca [2 x i8], align 1
  %t115 = getelementptr [2 x i8], [2 x i8]* %t114, i32 0, i32 0
  store i8 61, i8* %t115
  %t116 = getelementptr [2 x i8], [2 x i8]* %t114, i32 0, i32 1
  store i8 0, i8* %t116
  %t117 = getelementptr [2 x i8], [2 x i8]* %t114, i32 0, i32 0
  %t118 = call double @index_of(i8* %t113, i8* %t117)
  store double %t118, double* %l8
  %t119 = load double, double* %l8
  %t120 = sitofp i64 0 to double
  %t121 = fcmp oge double %t119, %t120
  %t122 = load i8*, i8** %l0
  %t123 = load i1, i1* %l1
  %t124 = load i8*, i8** %l2
  %t125 = load double, double* %l3
  %t126 = load i8*, i8** %l5
  %t127 = load i8*, i8** %l6
  %t128 = load i8*, i8** %l7
  %t129 = load double, double* %l8
  br i1 %t121, label %then19, label %else20
then19:
  %t130 = load i8*, i8** %l7
  %t131 = load double, double* %l8
  %t132 = fptosi double %t131 to i64
  %t133 = call i8* @sailfin_runtime_substring(i8* %t130, i64 0, i64 %t132)
  %t134 = call i8* @trim_text(i8* %t133)
  store i8* %t134, i8** %l5
  %t135 = load i8*, i8** %l7
  %t136 = load double, double* %l8
  %t137 = sitofp i64 1 to double
  %t138 = fadd double %t136, %t137
  %t139 = load i8*, i8** %l7
  %t140 = call i64 @sailfin_runtime_string_length(i8* %t139)
  %t141 = fptosi double %t138 to i64
  %t142 = call i8* @sailfin_runtime_substring(i8* %t135, i64 %t141, i64 %t140)
  %t143 = call i8* @trim_text(i8* %t142)
  store i8* %t143, i8** %l9
  %t144 = load i8*, i8** %l9
  %t145 = call i64 @sailfin_runtime_string_length(i8* %t144)
  %t146 = icmp sgt i64 %t145, 0
  %t147 = load i8*, i8** %l0
  %t148 = load i1, i1* %l1
  %t149 = load i8*, i8** %l2
  %t150 = load double, double* %l3
  %t151 = load i8*, i8** %l5
  %t152 = load i8*, i8** %l6
  %t153 = load i8*, i8** %l7
  %t154 = load double, double* %l8
  %t155 = load i8*, i8** %l9
  br i1 %t146, label %then22, label %merge23
then22:
  %t156 = load i8*, i8** %l9
  store i8* %t156, i8** %l6
  %t157 = load i8*, i8** %l6
  br label %merge23
merge23:
  %t158 = phi i8* [ %t157, %then22 ], [ %t152, %then19 ]
  store i8* %t158, i8** %l6
  %t159 = load i8*, i8** %l5
  %t160 = load i8*, i8** %l6
  br label %merge21
else20:
  %t161 = load i8*, i8** %l7
  %t162 = call i8* @trim_text(i8* %t161)
  store i8* %t162, i8** %l5
  %t163 = load i8*, i8** %l5
  br label %merge21
merge21:
  %t164 = phi i8* [ %t159, %merge23 ], [ %t163, %else20 ]
  %t165 = phi i8* [ %t160, %merge23 ], [ %t127, %else20 ]
  store i8* %t164, i8** %l5
  store i8* %t165, i8** %l6
  %t166 = load i8*, i8** %l7
  %t167 = load i8*, i8** %l5
  %t168 = load i8*, i8** %l6
  %t169 = load i8*, i8** %l5
  br label %merge18
else17:
  %t170 = load i8*, i8** %l7
  %t171 = alloca [2 x i8], align 1
  %t172 = getelementptr [2 x i8], [2 x i8]* %t171, i32 0, i32 0
  store i8 61, i8* %t172
  %t173 = getelementptr [2 x i8], [2 x i8]* %t171, i32 0, i32 1
  store i8 0, i8* %t173
  %t174 = getelementptr [2 x i8], [2 x i8]* %t171, i32 0, i32 0
  %t175 = call i1 @starts_with(i8* %t170, i8* %t174)
  %t176 = load i8*, i8** %l0
  %t177 = load i1, i1* %l1
  %t178 = load i8*, i8** %l2
  %t179 = load double, double* %l3
  %t180 = load i8*, i8** %l5
  %t181 = load i8*, i8** %l6
  %t182 = load i8*, i8** %l7
  br i1 %t175, label %then24, label %merge25
then24:
  %t183 = load i8*, i8** %l7
  %t184 = alloca [2 x i8], align 1
  %t185 = getelementptr [2 x i8], [2 x i8]* %t184, i32 0, i32 0
  store i8 61, i8* %t185
  %t186 = getelementptr [2 x i8], [2 x i8]* %t184, i32 0, i32 1
  store i8 0, i8* %t186
  %t187 = getelementptr [2 x i8], [2 x i8]* %t184, i32 0, i32 0
  %t188 = call i8* @strip_prefix(i8* %t183, i8* %t187)
  %t189 = call i8* @trim_text(i8* %t188)
  store i8* %t189, i8** %l10
  %t190 = load i8*, i8** %l10
  %t191 = call i64 @sailfin_runtime_string_length(i8* %t190)
  %t192 = icmp sgt i64 %t191, 0
  %t193 = load i8*, i8** %l0
  %t194 = load i1, i1* %l1
  %t195 = load i8*, i8** %l2
  %t196 = load double, double* %l3
  %t197 = load i8*, i8** %l5
  %t198 = load i8*, i8** %l6
  %t199 = load i8*, i8** %l7
  %t200 = load i8*, i8** %l10
  br i1 %t192, label %then26, label %merge27
then26:
  %t201 = load i8*, i8** %l10
  store i8* %t201, i8** %l6
  %t202 = load i8*, i8** %l6
  br label %merge27
merge27:
  %t203 = phi i8* [ %t202, %then26 ], [ %t198, %then24 ]
  store i8* %t203, i8** %l6
  %t204 = load i8*, i8** %l6
  br label %merge25
merge25:
  %t205 = phi i8* [ %t204, %merge27 ], [ %t181, %else17 ]
  store i8* %t205, i8** %l6
  %t206 = load i8*, i8** %l6
  br label %merge18
merge18:
  %t207 = phi i8* [ %t166, %merge21 ], [ %t108, %merge25 ]
  %t208 = phi i8* [ %t167, %merge21 ], [ %t106, %merge25 ]
  %t209 = phi i8* [ %t168, %merge21 ], [ %t206, %merge25 ]
  store i8* %t207, i8** %l7
  store i8* %t208, i8** %l5
  store i8* %t209, i8** %l6
  %t210 = load i8*, i8** %l7
  %t211 = load i8*, i8** %l5
  %t212 = load i8*, i8** %l6
  %t213 = load i8*, i8** %l5
  %t214 = load i8*, i8** %l6
  br label %merge15
merge15:
  %t215 = phi i8* [ %t210, %merge18 ], [ %t98, %merge13 ]
  %t216 = phi i8* [ %t211, %merge18 ], [ %t96, %merge13 ]
  %t217 = phi i8* [ %t212, %merge18 ], [ %t97, %merge13 ]
  %t218 = phi i8* [ %t213, %merge18 ], [ %t96, %merge13 ]
  %t219 = phi i8* [ %t214, %merge18 ], [ %t97, %merge13 ]
  store i8* %t215, i8** %l7
  store i8* %t216, i8** %l5
  store i8* %t217, i8** %l6
  store i8* %t218, i8** %l5
  store i8* %t219, i8** %l6
  %t220 = load i8*, i8** %l2
  %t221 = insertvalue %NativeParameter undef, i8* %t220, 0
  %t222 = load i8*, i8** %l5
  %t223 = insertvalue %NativeParameter %t221, i8* %t222, 1
  %t224 = load i1, i1* %l1
  %t225 = insertvalue %NativeParameter %t223, i1 %t224, 2
  %t226 = load i8*, i8** %l6
  %t227 = insertvalue %NativeParameter %t225, i8* %t226, 3
  %t228 = insertvalue %NativeParameter %t227, %NativeSourceSpan* %span, 4
  %t229 = alloca %NativeParameter
  store %NativeParameter %t228, %NativeParameter* %t229
  ret %NativeParameter* %t229
}

define i1 @line_looks_like_parameter_entry(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
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
  %t6 = alloca [2 x i8], align 1
  %t7 = getelementptr [2 x i8], [2 x i8]* %t6, i32 0, i32 0
  store i8 46, i8* %t7
  %t8 = getelementptr [2 x i8], [2 x i8]* %t6, i32 0, i32 1
  store i8 0, i8* %t8
  %t9 = getelementptr [2 x i8], [2 x i8]* %t6, i32 0, i32 0
  %t10 = call i1 @starts_with(i8* %t5, i8* %t9)
  %t11 = load i8*, i8** %l0
  br i1 %t10, label %then2, label %merge3
then2:
  ret i1 0
merge3:
  %t12 = load i8*, i8** %l0
  %t13 = alloca [2 x i8], align 1
  %t14 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 0
  store i8 59, i8* %t14
  %t15 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 1
  store i8 0, i8* %t15
  %t16 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 0
  %t17 = call i1 @starts_with(i8* %t12, i8* %t16)
  %t18 = load i8*, i8** %l0
  br i1 %t17, label %then4, label %merge5
then4:
  ret i1 0
merge5:
  %t19 = load i8*, i8** %l0
  %s20 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t21 = call double @index_of(i8* %t19, i8* %s20)
  store double %t21, double* %l1
  %t22 = load double, double* %l1
  %t23 = sitofp i64 0 to double
  %t24 = fcmp oge double %t22, %t23
  %t25 = load i8*, i8** %l0
  %t26 = load double, double* %l1
  br i1 %t24, label %then6, label %merge7
then6:
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  %t29 = fptosi double %t28 to i64
  %t30 = call i8* @sailfin_runtime_substring(i8* %t27, i64 0, i64 %t29)
  %t31 = call i8* @trim_text(i8* %t30)
  store i8* %t31, i8** %l2
  %t32 = load i8*, i8** %l2
  %t33 = call i64 @sailfin_runtime_string_length(i8* %t32)
  %t34 = icmp eq i64 %t33, 0
  %t35 = load i8*, i8** %l0
  %t36 = load double, double* %l1
  %t37 = load i8*, i8** %l2
  br i1 %t34, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t38 = load i8*, i8** %l2
  %s39 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t40 = call i1 @starts_with(i8* %t38, i8* %s39)
  %t41 = load i8*, i8** %l0
  %t42 = load double, double* %l1
  %t43 = load i8*, i8** %l2
  br i1 %t40, label %then10, label %merge11
then10:
  %t44 = load i8*, i8** %l2
  %s45 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t46 = call i8* @strip_prefix(i8* %t44, i8* %s45)
  %t47 = call i8* @trim_text(i8* %t46)
  store i8* %t47, i8** %l2
  %t48 = load i8*, i8** %l2
  br label %merge11
merge11:
  %t49 = phi i8* [ %t48, %then10 ], [ %t43, %merge9 ]
  store i8* %t49, i8** %l2
  %t50 = load i8*, i8** %l2
  %t51 = call i64 @sailfin_runtime_string_length(i8* %t50)
  %t52 = icmp eq i64 %t51, 0
  %t53 = load i8*, i8** %l0
  %t54 = load double, double* %l1
  %t55 = load i8*, i8** %l2
  br i1 %t52, label %then12, label %merge13
then12:
  ret i1 0
merge13:
  %t56 = load i8*, i8** %l2
  %t57 = alloca [2 x i8], align 1
  %t58 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 0
  store i8 32, i8* %t58
  %t59 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 1
  store i8 0, i8* %t59
  %t60 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 0
  %t61 = call double @index_of(i8* %t56, i8* %t60)
  %t62 = sitofp i64 0 to double
  %t63 = fcmp oge double %t61, %t62
  %t64 = load i8*, i8** %l0
  %t65 = load double, double* %l1
  %t66 = load i8*, i8** %l2
  br i1 %t63, label %then14, label %merge15
then14:
  ret i1 0
merge15:
  %t67 = load i8*, i8** %l2
  %t68 = alloca [2 x i8], align 1
  %t69 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 0
  store i8 9, i8* %t69
  %t70 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 1
  store i8 0, i8* %t70
  %t71 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 0
  %t72 = call double @index_of(i8* %t67, i8* %t71)
  %t73 = sitofp i64 0 to double
  %t74 = fcmp oge double %t72, %t73
  %t75 = load i8*, i8** %l0
  %t76 = load double, double* %l1
  %t77 = load i8*, i8** %l2
  br i1 %t74, label %then16, label %merge17
then16:
  ret i1 0
merge17:
  ret i1 1
merge7:
  %t78 = load i8*, i8** %l0
  %t79 = alloca [2 x i8], align 1
  %t80 = getelementptr [2 x i8], [2 x i8]* %t79, i32 0, i32 0
  store i8 61, i8* %t80
  %t81 = getelementptr [2 x i8], [2 x i8]* %t79, i32 0, i32 1
  store i8 0, i8* %t81
  %t82 = getelementptr [2 x i8], [2 x i8]* %t79, i32 0, i32 0
  %t83 = call double @index_of(i8* %t78, i8* %t82)
  store double %t83, double* %l3
  %t84 = load double, double* %l3
  %t85 = sitofp i64 0 to double
  %t86 = fcmp oge double %t84, %t85
  %t87 = load i8*, i8** %l0
  %t88 = load double, double* %l1
  %t89 = load double, double* %l3
  br i1 %t86, label %then18, label %merge19
then18:
  %t90 = load i8*, i8** %l0
  %t91 = load double, double* %l3
  %t92 = fptosi double %t91 to i64
  %t93 = call i8* @sailfin_runtime_substring(i8* %t90, i64 0, i64 %t92)
  %t94 = call i8* @trim_text(i8* %t93)
  store i8* %t94, i8** %l4
  %t95 = load i8*, i8** %l4
  %t96 = call i64 @sailfin_runtime_string_length(i8* %t95)
  %t97 = icmp eq i64 %t96, 0
  %t98 = load i8*, i8** %l0
  %t99 = load double, double* %l1
  %t100 = load double, double* %l3
  %t101 = load i8*, i8** %l4
  br i1 %t97, label %then20, label %merge21
then20:
  ret i1 0
merge21:
  %t102 = load i8*, i8** %l4
  %s103 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t104 = call i1 @starts_with(i8* %t102, i8* %s103)
  %t105 = load i8*, i8** %l0
  %t106 = load double, double* %l1
  %t107 = load double, double* %l3
  %t108 = load i8*, i8** %l4
  br i1 %t104, label %then22, label %merge23
then22:
  %t109 = load i8*, i8** %l4
  %s110 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t111 = call i8* @strip_prefix(i8* %t109, i8* %s110)
  %t112 = call i8* @trim_text(i8* %t111)
  store i8* %t112, i8** %l4
  %t113 = load i8*, i8** %l4
  br label %merge23
merge23:
  %t114 = phi i8* [ %t113, %then22 ], [ %t108, %merge21 ]
  store i8* %t114, i8** %l4
  %t115 = load i8*, i8** %l4
  %t116 = call i64 @sailfin_runtime_string_length(i8* %t115)
  %t117 = icmp eq i64 %t116, 0
  %t118 = load i8*, i8** %l0
  %t119 = load double, double* %l1
  %t120 = load double, double* %l3
  %t121 = load i8*, i8** %l4
  br i1 %t117, label %then24, label %merge25
then24:
  ret i1 0
merge25:
  %t122 = load i8*, i8** %l4
  %t123 = alloca [2 x i8], align 1
  %t124 = getelementptr [2 x i8], [2 x i8]* %t123, i32 0, i32 0
  store i8 32, i8* %t124
  %t125 = getelementptr [2 x i8], [2 x i8]* %t123, i32 0, i32 1
  store i8 0, i8* %t125
  %t126 = getelementptr [2 x i8], [2 x i8]* %t123, i32 0, i32 0
  %t127 = call double @index_of(i8* %t122, i8* %t126)
  %t128 = sitofp i64 0 to double
  %t129 = fcmp oge double %t127, %t128
  %t130 = load i8*, i8** %l0
  %t131 = load double, double* %l1
  %t132 = load double, double* %l3
  %t133 = load i8*, i8** %l4
  br i1 %t129, label %then26, label %merge27
then26:
  ret i1 0
merge27:
  %t134 = load i8*, i8** %l4
  %t135 = alloca [2 x i8], align 1
  %t136 = getelementptr [2 x i8], [2 x i8]* %t135, i32 0, i32 0
  store i8 9, i8* %t136
  %t137 = getelementptr [2 x i8], [2 x i8]* %t135, i32 0, i32 1
  store i8 0, i8* %t137
  %t138 = getelementptr [2 x i8], [2 x i8]* %t135, i32 0, i32 0
  %t139 = call double @index_of(i8* %t134, i8* %t138)
  %t140 = sitofp i64 0 to double
  %t141 = fcmp oge double %t139, %t140
  %t142 = load i8*, i8** %l0
  %t143 = load double, double* %l1
  %t144 = load double, double* %l3
  %t145 = load i8*, i8** %l4
  br i1 %t141, label %then28, label %merge29
then28:
  ret i1 0
merge29:
  ret i1 1
merge19:
  ret i1 0
}

define { i8**, i64 }* @split_parameter_entries(i8* %body) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca i8
  %l6 = alloca i8*
  %l7 = alloca i8*
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
  %s8 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s8, i8** %l4
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load i8*, i8** %l1
  %t11 = load double, double* %l2
  %t12 = load double, double* %l3
  %t13 = load i8*, i8** %l4
  br label %loop.header0
loop.header0:
  %t259 = phi i8* [ %t10, %entry ], [ %t254, %loop.latch2 ]
  %t260 = phi double [ %t11, %entry ], [ %t255, %loop.latch2 ]
  %t261 = phi i8* [ %t13, %entry ], [ %t256, %loop.latch2 ]
  %t262 = phi double [ %t12, %entry ], [ %t257, %loop.latch2 ]
  %t263 = phi { i8**, i64 }* [ %t9, %entry ], [ %t258, %loop.latch2 ]
  store i8* %t259, i8** %l1
  store double %t260, double* %l2
  store i8* %t261, i8** %l4
  store double %t262, double* %l3
  store { i8**, i64 }* %t263, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l2
  %t15 = call i64 @sailfin_runtime_string_length(i8* %body)
  %t16 = sitofp i64 %t15 to double
  %t17 = fcmp oge double %t14, %t16
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load i8*, i8** %l1
  %t20 = load double, double* %l2
  %t21 = load double, double* %l3
  %t22 = load i8*, i8** %l4
  br i1 %t17, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t23 = load double, double* %l2
  %t24 = fptosi double %t23 to i64
  %t25 = getelementptr i8, i8* %body, i64 %t24
  %t26 = load i8, i8* %t25
  store i8 %t26, i8* %l5
  %t27 = load i8*, i8** %l4
  %t28 = call i64 @sailfin_runtime_string_length(i8* %t27)
  %t29 = icmp sgt i64 %t28, 0
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load i8*, i8** %l1
  %t32 = load double, double* %l2
  %t33 = load double, double* %l3
  %t34 = load i8*, i8** %l4
  %t35 = load i8, i8* %l5
  br i1 %t29, label %then6, label %merge7
then6:
  %t36 = load i8*, i8** %l1
  %t37 = load i8, i8* %l5
  %t38 = load i8, i8* %t36
  %t39 = add i8 %t38, %t37
  %t40 = alloca [2 x i8], align 1
  %t41 = getelementptr [2 x i8], [2 x i8]* %t40, i32 0, i32 0
  store i8 %t39, i8* %t41
  %t42 = getelementptr [2 x i8], [2 x i8]* %t40, i32 0, i32 1
  store i8 0, i8* %t42
  %t43 = getelementptr [2 x i8], [2 x i8]* %t40, i32 0, i32 0
  store i8* %t43, i8** %l1
  %t44 = load i8, i8* %l5
  %t45 = icmp eq i8 %t44, 92
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load i8*, i8** %l1
  %t48 = load double, double* %l2
  %t49 = load double, double* %l3
  %t50 = load i8*, i8** %l4
  %t51 = load i8, i8* %l5
  br i1 %t45, label %then8, label %merge9
then8:
  %t52 = load double, double* %l2
  %t53 = sitofp i64 1 to double
  %t54 = fadd double %t52, %t53
  %t55 = call i64 @sailfin_runtime_string_length(i8* %body)
  %t56 = sitofp i64 %t55 to double
  %t57 = fcmp olt double %t54, %t56
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load i8*, i8** %l1
  %t60 = load double, double* %l2
  %t61 = load double, double* %l3
  %t62 = load i8*, i8** %l4
  %t63 = load i8, i8* %l5
  br i1 %t57, label %then10, label %merge11
then10:
  %t64 = load i8*, i8** %l1
  %t65 = load double, double* %l2
  %t66 = sitofp i64 1 to double
  %t67 = fadd double %t65, %t66
  %t68 = fptosi double %t67 to i64
  %t69 = getelementptr i8, i8* %body, i64 %t68
  %t70 = load i8, i8* %t69
  %t71 = load i8, i8* %t64
  %t72 = add i8 %t71, %t70
  %t73 = alloca [2 x i8], align 1
  %t74 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 0
  store i8 %t72, i8* %t74
  %t75 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 1
  store i8 0, i8* %t75
  %t76 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 0
  store i8* %t76, i8** %l1
  %t77 = load double, double* %l2
  %t78 = sitofp i64 2 to double
  %t79 = fadd double %t77, %t78
  store double %t79, double* %l2
  br label %loop.latch2
merge11:
  %t80 = load i8*, i8** %l1
  %t81 = load double, double* %l2
  br label %merge9
merge9:
  %t82 = phi i8* [ %t80, %merge11 ], [ %t47, %then6 ]
  %t83 = phi double [ %t81, %merge11 ], [ %t48, %then6 ]
  store i8* %t82, i8** %l1
  store double %t83, double* %l2
  %t84 = load i8, i8* %l5
  %t85 = load i8*, i8** %l4
  %t86 = load i8, i8* %t85
  %t87 = icmp eq i8 %t84, %t86
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t89 = load i8*, i8** %l1
  %t90 = load double, double* %l2
  %t91 = load double, double* %l3
  %t92 = load i8*, i8** %l4
  %t93 = load i8, i8* %l5
  br i1 %t87, label %then12, label %merge13
then12:
  %s94 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s94, i8** %l4
  %t95 = load i8*, i8** %l4
  br label %merge13
merge13:
  %t96 = phi i8* [ %t95, %then12 ], [ %t92, %merge9 ]
  store i8* %t96, i8** %l4
  %t97 = load double, double* %l2
  %t98 = sitofp i64 1 to double
  %t99 = fadd double %t97, %t98
  store double %t99, double* %l2
  br label %loop.latch2
merge7:
  %t101 = load i8, i8* %l5
  %t102 = icmp eq i8 %t101, 34
  br label %logical_or_entry_100

logical_or_entry_100:
  br i1 %t102, label %logical_or_merge_100, label %logical_or_right_100

logical_or_right_100:
  %t103 = load i8, i8* %l5
  %t104 = icmp eq i8 %t103, 39
  br label %logical_or_right_end_100

logical_or_right_end_100:
  br label %logical_or_merge_100

logical_or_merge_100:
  %t105 = phi i1 [ true, %logical_or_entry_100 ], [ %t104, %logical_or_right_end_100 ]
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t107 = load i8*, i8** %l1
  %t108 = load double, double* %l2
  %t109 = load double, double* %l3
  %t110 = load i8*, i8** %l4
  %t111 = load i8, i8* %l5
  br i1 %t105, label %then14, label %merge15
then14:
  %t112 = load i8, i8* %l5
  %t113 = alloca [2 x i8], align 1
  %t114 = getelementptr [2 x i8], [2 x i8]* %t113, i32 0, i32 0
  store i8 %t112, i8* %t114
  %t115 = getelementptr [2 x i8], [2 x i8]* %t113, i32 0, i32 1
  store i8 0, i8* %t115
  %t116 = getelementptr [2 x i8], [2 x i8]* %t113, i32 0, i32 0
  store i8* %t116, i8** %l4
  %t117 = load i8*, i8** %l1
  %t118 = load i8, i8* %l5
  %t119 = load i8, i8* %t117
  %t120 = add i8 %t119, %t118
  %t121 = alloca [2 x i8], align 1
  %t122 = getelementptr [2 x i8], [2 x i8]* %t121, i32 0, i32 0
  store i8 %t120, i8* %t122
  %t123 = getelementptr [2 x i8], [2 x i8]* %t121, i32 0, i32 1
  store i8 0, i8* %t123
  %t124 = getelementptr [2 x i8], [2 x i8]* %t121, i32 0, i32 0
  store i8* %t124, i8** %l1
  %t125 = load double, double* %l2
  %t126 = sitofp i64 1 to double
  %t127 = fadd double %t125, %t126
  store double %t127, double* %l2
  br label %loop.latch2
merge15:
  %t129 = load i8, i8* %l5
  %t130 = icmp eq i8 %t129, 40
  br label %logical_or_entry_128

logical_or_entry_128:
  br i1 %t130, label %logical_or_merge_128, label %logical_or_right_128

logical_or_right_128:
  %t132 = load i8, i8* %l5
  %t133 = icmp eq i8 %t132, 91
  br label %logical_or_entry_131

logical_or_entry_131:
  br i1 %t133, label %logical_or_merge_131, label %logical_or_right_131

logical_or_right_131:
  %t134 = load i8, i8* %l5
  %t135 = icmp eq i8 %t134, 123
  br label %logical_or_right_end_131

logical_or_right_end_131:
  br label %logical_or_merge_131

logical_or_merge_131:
  %t136 = phi i1 [ true, %logical_or_entry_131 ], [ %t135, %logical_or_right_end_131 ]
  br label %logical_or_right_end_128

logical_or_right_end_128:
  br label %logical_or_merge_128

logical_or_merge_128:
  %t137 = phi i1 [ true, %logical_or_entry_128 ], [ %t136, %logical_or_right_end_128 ]
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t139 = load i8*, i8** %l1
  %t140 = load double, double* %l2
  %t141 = load double, double* %l3
  %t142 = load i8*, i8** %l4
  %t143 = load i8, i8* %l5
  br i1 %t137, label %then16, label %merge17
then16:
  %t144 = load double, double* %l3
  %t145 = sitofp i64 1 to double
  %t146 = fadd double %t144, %t145
  store double %t146, double* %l3
  %t147 = load i8*, i8** %l1
  %t148 = load i8, i8* %l5
  %t149 = load i8, i8* %t147
  %t150 = add i8 %t149, %t148
  %t151 = alloca [2 x i8], align 1
  %t152 = getelementptr [2 x i8], [2 x i8]* %t151, i32 0, i32 0
  store i8 %t150, i8* %t152
  %t153 = getelementptr [2 x i8], [2 x i8]* %t151, i32 0, i32 1
  store i8 0, i8* %t153
  %t154 = getelementptr [2 x i8], [2 x i8]* %t151, i32 0, i32 0
  store i8* %t154, i8** %l1
  %t155 = load double, double* %l2
  %t156 = sitofp i64 1 to double
  %t157 = fadd double %t155, %t156
  store double %t157, double* %l2
  br label %loop.latch2
merge17:
  %t159 = load i8, i8* %l5
  %t160 = icmp eq i8 %t159, 41
  br label %logical_or_entry_158

logical_or_entry_158:
  br i1 %t160, label %logical_or_merge_158, label %logical_or_right_158

logical_or_right_158:
  %t162 = load i8, i8* %l5
  %t163 = icmp eq i8 %t162, 93
  br label %logical_or_entry_161

logical_or_entry_161:
  br i1 %t163, label %logical_or_merge_161, label %logical_or_right_161

logical_or_right_161:
  %t164 = load i8, i8* %l5
  %t165 = icmp eq i8 %t164, 125
  br label %logical_or_right_end_161

logical_or_right_end_161:
  br label %logical_or_merge_161

logical_or_merge_161:
  %t166 = phi i1 [ true, %logical_or_entry_161 ], [ %t165, %logical_or_right_end_161 ]
  br label %logical_or_right_end_158

logical_or_right_end_158:
  br label %logical_or_merge_158

logical_or_merge_158:
  %t167 = phi i1 [ true, %logical_or_entry_158 ], [ %t166, %logical_or_right_end_158 ]
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t169 = load i8*, i8** %l1
  %t170 = load double, double* %l2
  %t171 = load double, double* %l3
  %t172 = load i8*, i8** %l4
  %t173 = load i8, i8* %l5
  br i1 %t167, label %then18, label %merge19
then18:
  %t174 = load double, double* %l3
  %t175 = sitofp i64 0 to double
  %t176 = fcmp ogt double %t174, %t175
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t178 = load i8*, i8** %l1
  %t179 = load double, double* %l2
  %t180 = load double, double* %l3
  %t181 = load i8*, i8** %l4
  %t182 = load i8, i8* %l5
  br i1 %t176, label %then20, label %merge21
then20:
  %t183 = load double, double* %l3
  %t184 = sitofp i64 1 to double
  %t185 = fsub double %t183, %t184
  store double %t185, double* %l3
  %t186 = load double, double* %l3
  br label %merge21
merge21:
  %t187 = phi double [ %t186, %then20 ], [ %t180, %then18 ]
  store double %t187, double* %l3
  %t188 = load i8*, i8** %l1
  %t189 = load i8, i8* %l5
  %t190 = load i8, i8* %t188
  %t191 = add i8 %t190, %t189
  %t192 = alloca [2 x i8], align 1
  %t193 = getelementptr [2 x i8], [2 x i8]* %t192, i32 0, i32 0
  store i8 %t191, i8* %t193
  %t194 = getelementptr [2 x i8], [2 x i8]* %t192, i32 0, i32 1
  store i8 0, i8* %t194
  %t195 = getelementptr [2 x i8], [2 x i8]* %t192, i32 0, i32 0
  store i8* %t195, i8** %l1
  %t196 = load double, double* %l2
  %t197 = sitofp i64 1 to double
  %t198 = fadd double %t196, %t197
  store double %t198, double* %l2
  br label %loop.latch2
merge19:
  %t199 = load i8, i8* %l5
  %t200 = icmp eq i8 %t199, 44
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t202 = load i8*, i8** %l1
  %t203 = load double, double* %l2
  %t204 = load double, double* %l3
  %t205 = load i8*, i8** %l4
  %t206 = load i8, i8* %l5
  br i1 %t200, label %then22, label %merge23
then22:
  %t207 = load double, double* %l3
  %t208 = sitofp i64 0 to double
  %t209 = fcmp oeq double %t207, %t208
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t211 = load i8*, i8** %l1
  %t212 = load double, double* %l2
  %t213 = load double, double* %l3
  %t214 = load i8*, i8** %l4
  %t215 = load i8, i8* %l5
  br i1 %t209, label %then24, label %merge25
then24:
  %t216 = load i8*, i8** %l1
  %t217 = call i8* @trim_text(i8* %t216)
  store i8* %t217, i8** %l6
  %t218 = load i8*, i8** %l6
  %t219 = call i64 @sailfin_runtime_string_length(i8* %t218)
  %t220 = icmp sgt i64 %t219, 0
  %t221 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t222 = load i8*, i8** %l1
  %t223 = load double, double* %l2
  %t224 = load double, double* %l3
  %t225 = load i8*, i8** %l4
  %t226 = load i8, i8* %l5
  %t227 = load i8*, i8** %l6
  br i1 %t220, label %then26, label %merge27
then26:
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t229 = load i8*, i8** %l6
  %t230 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t228, i8* %t229)
  store { i8**, i64 }* %t230, { i8**, i64 }** %l0
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge27
merge27:
  %t232 = phi { i8**, i64 }* [ %t231, %then26 ], [ %t221, %then24 ]
  store { i8**, i64 }* %t232, { i8**, i64 }** %l0
  %s233 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s233, i8** %l1
  %t234 = load double, double* %l2
  %t235 = sitofp i64 1 to double
  %t236 = fadd double %t234, %t235
  store double %t236, double* %l2
  br label %loop.latch2
merge25:
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t238 = load i8*, i8** %l1
  %t239 = load double, double* %l2
  br label %merge23
merge23:
  %t240 = phi { i8**, i64 }* [ %t237, %merge25 ], [ %t201, %merge19 ]
  %t241 = phi i8* [ %t238, %merge25 ], [ %t202, %merge19 ]
  %t242 = phi double [ %t239, %merge25 ], [ %t203, %merge19 ]
  store { i8**, i64 }* %t240, { i8**, i64 }** %l0
  store i8* %t241, i8** %l1
  store double %t242, double* %l2
  %t243 = load i8*, i8** %l1
  %t244 = load i8, i8* %l5
  %t245 = load i8, i8* %t243
  %t246 = add i8 %t245, %t244
  %t247 = alloca [2 x i8], align 1
  %t248 = getelementptr [2 x i8], [2 x i8]* %t247, i32 0, i32 0
  store i8 %t246, i8* %t248
  %t249 = getelementptr [2 x i8], [2 x i8]* %t247, i32 0, i32 1
  store i8 0, i8* %t249
  %t250 = getelementptr [2 x i8], [2 x i8]* %t247, i32 0, i32 0
  store i8* %t250, i8** %l1
  %t251 = load double, double* %l2
  %t252 = sitofp i64 1 to double
  %t253 = fadd double %t251, %t252
  store double %t253, double* %l2
  br label %loop.latch2
loop.latch2:
  %t254 = load i8*, i8** %l1
  %t255 = load double, double* %l2
  %t256 = load i8*, i8** %l4
  %t257 = load double, double* %l3
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t264 = load i8*, i8** %l1
  %t265 = load double, double* %l2
  %t266 = load i8*, i8** %l4
  %t267 = load double, double* %l3
  %t268 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t269 = load i8*, i8** %l1
  %t270 = call i8* @trim_text(i8* %t269)
  store i8* %t270, i8** %l7
  %t271 = load i8*, i8** %l7
  %t272 = call i64 @sailfin_runtime_string_length(i8* %t271)
  %t273 = icmp sgt i64 %t272, 0
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t275 = load i8*, i8** %l1
  %t276 = load double, double* %l2
  %t277 = load double, double* %l3
  %t278 = load i8*, i8** %l4
  %t279 = load i8*, i8** %l7
  br i1 %t273, label %then28, label %merge29
then28:
  %t280 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t281 = load i8*, i8** %l7
  %t282 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t280, i8* %t281)
  store { i8**, i64 }* %t282, { i8**, i64 }** %l0
  %t283 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge29
merge29:
  %t284 = phi { i8**, i64 }* [ %t283, %then28 ], [ %t274, %afterloop3 ]
  store { i8**, i64 }* %t284, { i8**, i64 }** %l0
  %t285 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t285
}

define { i8**, i64 }* @parse_effect_list(i8* %text) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268715771, i32 0, i32 0
  %t3 = icmp eq i8* %t1, %s2
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = alloca [0 x i8*]
  %t6 = getelementptr [0 x i8*], [0 x i8*]* %t5, i32 0, i32 0
  %t7 = alloca { i8**, i64 }
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t7, i32 0, i32 0
  store i8** %t6, i8*** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  ret { i8**, i64 }* %t7
merge1:
  %t10 = load i8*, i8** %l0
  %t11 = call { i8**, i64 }* @split_comma_separated(i8* %t10)
  ret { i8**, i64 }* %t11
}

define { i8**, i64 }* @split_whitespace(i8* %value) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca i1
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t6 = icmp eq i64 %t5, 0
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br i1 %t6, label %then0, label %merge1
then0:
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t8
merge1:
  %t9 = sitofp i64 -1 to double
  store double %t9, double* %l1
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l2
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load double, double* %l1
  %t13 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t89 = phi { i8**, i64 }* [ %t11, %merge1 ], [ %t86, %loop.latch4 ]
  %t90 = phi double [ %t12, %merge1 ], [ %t87, %loop.latch4 ]
  %t91 = phi double [ %t13, %merge1 ], [ %t88, %loop.latch4 ]
  store { i8**, i64 }* %t89, { i8**, i64 }** %l0
  store double %t90, double* %l1
  store double %t91, double* %l2
  br label %loop.body3
loop.body3:
  %t14 = load double, double* %l2
  %t15 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t16 = sitofp i64 %t15 to double
  %t17 = fcmp oge double %t14, %t16
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load double, double* %l1
  %t20 = load double, double* %l2
  br i1 %t17, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t21 = load double, double* %l2
  %t22 = call i8* @text_char_at(i8* %value, double %t21)
  store i8* %t22, i8** %l3
  %t24 = load i8*, i8** %l3
  %t25 = load i8, i8* %t24
  %t26 = icmp eq i8 %t25, 32
  br label %logical_or_entry_23

logical_or_entry_23:
  br i1 %t26, label %logical_or_merge_23, label %logical_or_right_23

logical_or_right_23:
  %t28 = load i8*, i8** %l3
  %t29 = load i8, i8* %t28
  %t30 = icmp eq i8 %t29, 9
  br label %logical_or_entry_27

logical_or_entry_27:
  br i1 %t30, label %logical_or_merge_27, label %logical_or_right_27

logical_or_right_27:
  %t32 = load i8*, i8** %l3
  %t33 = load i8, i8* %t32
  %t34 = icmp eq i8 %t33, 10
  br label %logical_or_entry_31

logical_or_entry_31:
  br i1 %t34, label %logical_or_merge_31, label %logical_or_right_31

logical_or_right_31:
  %t35 = load i8*, i8** %l3
  %t36 = load i8, i8* %t35
  %t37 = icmp eq i8 %t36, 13
  br label %logical_or_right_end_31

logical_or_right_end_31:
  br label %logical_or_merge_31

logical_or_merge_31:
  %t38 = phi i1 [ true, %logical_or_entry_31 ], [ %t37, %logical_or_right_end_31 ]
  br label %logical_or_right_end_27

logical_or_right_end_27:
  br label %logical_or_merge_27

logical_or_merge_27:
  %t39 = phi i1 [ true, %logical_or_entry_27 ], [ %t38, %logical_or_right_end_27 ]
  br label %logical_or_right_end_23

logical_or_right_end_23:
  br label %logical_or_merge_23

logical_or_merge_23:
  %t40 = phi i1 [ true, %logical_or_entry_23 ], [ %t39, %logical_or_right_end_23 ]
  store i1 %t40, i1* %l4
  %t41 = load i1, i1* %l4
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load double, double* %l1
  %t44 = load double, double* %l2
  %t45 = load i8*, i8** %l3
  %t46 = load i1, i1* %l4
  br i1 %t41, label %then8, label %else9
then8:
  %t47 = load double, double* %l1
  %t48 = sitofp i64 0 to double
  %t49 = fcmp oge double %t47, %t48
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load double, double* %l1
  %t52 = load double, double* %l2
  %t53 = load i8*, i8** %l3
  %t54 = load i1, i1* %l4
  br i1 %t49, label %then11, label %merge12
then11:
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = load double, double* %l1
  %t57 = load double, double* %l2
  %t58 = fptosi double %t56 to i64
  %t59 = fptosi double %t57 to i64
  %t60 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t58, i64 %t59)
  %t61 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t55, i8* %t60)
  store { i8**, i64 }* %t61, { i8**, i64 }** %l0
  %t62 = sitofp i64 -1 to double
  store double %t62, double* %l1
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t64 = load double, double* %l1
  br label %merge12
merge12:
  %t65 = phi { i8**, i64 }* [ %t63, %then11 ], [ %t50, %then8 ]
  %t66 = phi double [ %t64, %then11 ], [ %t51, %then8 ]
  store { i8**, i64 }* %t65, { i8**, i64 }** %l0
  store double %t66, double* %l1
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t68 = load double, double* %l1
  br label %merge10
else9:
  %t69 = load double, double* %l1
  %t70 = sitofp i64 0 to double
  %t71 = fcmp olt double %t69, %t70
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t73 = load double, double* %l1
  %t74 = load double, double* %l2
  %t75 = load i8*, i8** %l3
  %t76 = load i1, i1* %l4
  br i1 %t71, label %then13, label %merge14
then13:
  %t77 = load double, double* %l2
  store double %t77, double* %l1
  %t78 = load double, double* %l1
  br label %merge14
merge14:
  %t79 = phi double [ %t78, %then13 ], [ %t73, %else9 ]
  store double %t79, double* %l1
  %t80 = load double, double* %l1
  br label %merge10
merge10:
  %t81 = phi { i8**, i64 }* [ %t67, %merge12 ], [ %t42, %merge14 ]
  %t82 = phi double [ %t68, %merge12 ], [ %t80, %merge14 ]
  store { i8**, i64 }* %t81, { i8**, i64 }** %l0
  store double %t82, double* %l1
  %t83 = load double, double* %l2
  %t84 = sitofp i64 1 to double
  %t85 = fadd double %t83, %t84
  store double %t85, double* %l2
  br label %loop.latch4
loop.latch4:
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t87 = load double, double* %l1
  %t88 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t93 = load double, double* %l1
  %t94 = load double, double* %l2
  %t95 = load double, double* %l1
  %t96 = sitofp i64 0 to double
  %t97 = fcmp oge double %t95, %t96
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t99 = load double, double* %l1
  %t100 = load double, double* %l2
  br i1 %t97, label %then15, label %merge16
then15:
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t102 = load double, double* %l1
  %t103 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t104 = fptosi double %t102 to i64
  %t105 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t104, i64 %t103)
  %t106 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t101, i8* %t105)
  store { i8**, i64 }* %t106, { i8**, i64 }** %l0
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge16
merge16:
  %t108 = phi { i8**, i64 }* [ %t107, %then15 ], [ %t98, %afterloop5 ]
  store { i8**, i64 }* %t108, { i8**, i64 }** %l0
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t109
}

define %NumberParseResult @parse_decimal_number(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8
  %l6 = alloca double
  %l7 = alloca double
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = insertvalue %NumberParseResult undef, i1 0, 0
  %t6 = sitofp i64 0 to double
  %t7 = insertvalue %NumberParseResult %t5, double %t6, 1
  ret %NumberParseResult %t7
merge1:
  %t8 = alloca [2 x i8], align 1
  %t9 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  store i8 48, i8* %t9
  %t10 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 1
  store i8 0, i8* %t10
  %t11 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  %t12 = call double @char_code(i8* %t11)
  store double %t12, double* %l1
  %t13 = alloca [2 x i8], align 1
  %t14 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 0
  store i8 57, i8* %t14
  %t15 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 1
  store i8 0, i8* %t15
  %t16 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 0
  %t17 = call double @char_code(i8* %t16)
  store double %t17, double* %l2
  %t18 = sitofp i64 0 to double
  store double %t18, double* %l3
  %t19 = sitofp i64 0 to double
  store double %t19, double* %l4
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l1
  %t22 = load double, double* %l2
  %t23 = load double, double* %l3
  %t24 = load double, double* %l4
  br label %loop.header2
loop.header2:
  %t77 = phi double [ %t24, %merge1 ], [ %t75, %loop.latch4 ]
  %t78 = phi double [ %t23, %merge1 ], [ %t76, %loop.latch4 ]
  store double %t77, double* %l4
  store double %t78, double* %l3
  br label %loop.body3
loop.body3:
  %t25 = load double, double* %l3
  %t26 = load i8*, i8** %l0
  %t27 = call i64 @sailfin_runtime_string_length(i8* %t26)
  %t28 = sitofp i64 %t27 to double
  %t29 = fcmp oge double %t25, %t28
  %t30 = load i8*, i8** %l0
  %t31 = load double, double* %l1
  %t32 = load double, double* %l2
  %t33 = load double, double* %l3
  %t34 = load double, double* %l4
  br i1 %t29, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t35 = load i8*, i8** %l0
  %t36 = load double, double* %l3
  %t37 = fptosi double %t36 to i64
  %t38 = getelementptr i8, i8* %t35, i64 %t37
  %t39 = load i8, i8* %t38
  store i8 %t39, i8* %l5
  %t40 = load i8, i8* %l5
  %t41 = alloca [2 x i8], align 1
  %t42 = getelementptr [2 x i8], [2 x i8]* %t41, i32 0, i32 0
  store i8 %t40, i8* %t42
  %t43 = getelementptr [2 x i8], [2 x i8]* %t41, i32 0, i32 1
  store i8 0, i8* %t43
  %t44 = getelementptr [2 x i8], [2 x i8]* %t41, i32 0, i32 0
  %t45 = call double @char_code(i8* %t44)
  store double %t45, double* %l6
  %t47 = load double, double* %l6
  %t48 = load double, double* %l1
  %t49 = fcmp olt double %t47, %t48
  br label %logical_or_entry_46

logical_or_entry_46:
  br i1 %t49, label %logical_or_merge_46, label %logical_or_right_46

logical_or_right_46:
  %t50 = load double, double* %l6
  %t51 = load double, double* %l2
  %t52 = fcmp ogt double %t50, %t51
  br label %logical_or_right_end_46

logical_or_right_end_46:
  br label %logical_or_merge_46

logical_or_merge_46:
  %t53 = phi i1 [ true, %logical_or_entry_46 ], [ %t52, %logical_or_right_end_46 ]
  %t54 = load i8*, i8** %l0
  %t55 = load double, double* %l1
  %t56 = load double, double* %l2
  %t57 = load double, double* %l3
  %t58 = load double, double* %l4
  %t59 = load i8, i8* %l5
  %t60 = load double, double* %l6
  br i1 %t53, label %then8, label %merge9
then8:
  %t61 = insertvalue %NumberParseResult undef, i1 0, 0
  %t62 = sitofp i64 0 to double
  %t63 = insertvalue %NumberParseResult %t61, double %t62, 1
  ret %NumberParseResult %t63
merge9:
  %t64 = load double, double* %l6
  %t65 = load double, double* %l1
  %t66 = fsub double %t64, %t65
  store double %t66, double* %l7
  %t67 = load double, double* %l4
  %t68 = sitofp i64 10 to double
  %t69 = fmul double %t67, %t68
  %t70 = load double, double* %l7
  %t71 = fadd double %t69, %t70
  store double %t71, double* %l4
  %t72 = load double, double* %l3
  %t73 = sitofp i64 1 to double
  %t74 = fadd double %t72, %t73
  store double %t74, double* %l3
  br label %loop.latch4
loop.latch4:
  %t75 = load double, double* %l4
  %t76 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t79 = load double, double* %l4
  %t80 = load double, double* %l3
  %t81 = insertvalue %NumberParseResult undef, i1 1, 0
  %t82 = load double, double* %l4
  %t83 = insertvalue %NumberParseResult %t81, double %t82, 1
  ret %NumberParseResult %t83
}

define { i8**, i64 }* @split_lines(i8* %value) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8
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
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = load i8*, i8** %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t50 = phi { i8**, i64 }* [ %t7, %entry ], [ %t47, %loop.latch2 ]
  %t51 = phi i8* [ %t8, %entry ], [ %t48, %loop.latch2 ]
  %t52 = phi double [ %t9, %entry ], [ %t49, %loop.latch2 ]
  store { i8**, i64 }* %t50, { i8**, i64 }** %l0
  store i8* %t51, i8** %l1
  store double %t52, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t10, %t12
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load i8*, i8** %l1
  %t16 = load double, double* %l2
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t17 = load double, double* %l2
  %t18 = fptosi double %t17 to i64
  %t19 = getelementptr i8, i8* %value, i64 %t18
  %t20 = load i8, i8* %t19
  store i8 %t20, i8* %l3
  %t21 = load i8, i8* %l3
  %t22 = icmp eq i8 %t21, 10
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load i8*, i8** %l1
  %t25 = load double, double* %l2
  %t26 = load i8, i8* %l3
  br i1 %t22, label %then6, label %else7
then6:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load i8*, i8** %l1
  %t29 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t27, i8* %t28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l0
  %s30 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s30, i8** %l1
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load i8*, i8** %l1
  br label %merge8
else7:
  %t33 = load i8*, i8** %l1
  %t34 = load i8, i8* %l3
  %t35 = load i8, i8* %t33
  %t36 = add i8 %t35, %t34
  %t37 = alloca [2 x i8], align 1
  %t38 = getelementptr [2 x i8], [2 x i8]* %t37, i32 0, i32 0
  store i8 %t36, i8* %t38
  %t39 = getelementptr [2 x i8], [2 x i8]* %t37, i32 0, i32 1
  store i8 0, i8* %t39
  %t40 = getelementptr [2 x i8], [2 x i8]* %t37, i32 0, i32 0
  store i8* %t40, i8** %l1
  %t41 = load i8*, i8** %l1
  br label %merge8
merge8:
  %t42 = phi { i8**, i64 }* [ %t31, %then6 ], [ %t23, %else7 ]
  %t43 = phi i8* [ %t32, %then6 ], [ %t41, %else7 ]
  store { i8**, i64 }* %t42, { i8**, i64 }** %l0
  store i8* %t43, i8** %l1
  %t44 = load double, double* %l2
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l2
  br label %loop.latch2
loop.latch2:
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load i8*, i8** %l1
  %t49 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load i8*, i8** %l1
  %t55 = load double, double* %l2
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t57 = load i8*, i8** %l1
  %t58 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t56, i8* %t57)
  store { i8**, i64 }* %t58, { i8**, i64 }** %l0
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t59
}

define { i8**, i64 }* @split_comma_separated(i8* %value) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca i8*
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
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = load i8*, i8** %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t51 = phi { i8**, i64 }* [ %t7, %entry ], [ %t48, %loop.latch2 ]
  %t52 = phi i8* [ %t8, %entry ], [ %t49, %loop.latch2 ]
  %t53 = phi double [ %t9, %entry ], [ %t50, %loop.latch2 ]
  store { i8**, i64 }* %t51, { i8**, i64 }** %l0
  store i8* %t52, i8** %l1
  store double %t53, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t10, %t12
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load i8*, i8** %l1
  %t16 = load double, double* %l2
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t17 = load double, double* %l2
  %t18 = fptosi double %t17 to i64
  %t19 = getelementptr i8, i8* %value, i64 %t18
  %t20 = load i8, i8* %t19
  store i8 %t20, i8* %l3
  %t21 = load i8, i8* %l3
  %t22 = icmp eq i8 %t21, 44
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load i8*, i8** %l1
  %t25 = load double, double* %l2
  %t26 = load i8, i8* %l3
  br i1 %t22, label %then6, label %else7
then6:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load i8*, i8** %l1
  %t29 = call i8* @trim_text(i8* %t28)
  %t30 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t27, i8* %t29)
  store { i8**, i64 }* %t30, { i8**, i64 }** %l0
  %s31 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s31, i8** %l1
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load i8*, i8** %l1
  br label %merge8
else7:
  %t34 = load i8*, i8** %l1
  %t35 = load i8, i8* %l3
  %t36 = load i8, i8* %t34
  %t37 = add i8 %t36, %t35
  %t38 = alloca [2 x i8], align 1
  %t39 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 0
  store i8 %t37, i8* %t39
  %t40 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 1
  store i8 0, i8* %t40
  %t41 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 0
  store i8* %t41, i8** %l1
  %t42 = load i8*, i8** %l1
  br label %merge8
merge8:
  %t43 = phi { i8**, i64 }* [ %t32, %then6 ], [ %t23, %else7 ]
  %t44 = phi i8* [ %t33, %then6 ], [ %t42, %else7 ]
  store { i8**, i64 }* %t43, { i8**, i64 }** %l0
  store i8* %t44, i8** %l1
  %t45 = load double, double* %l2
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l2
  br label %loop.latch2
loop.latch2:
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load i8*, i8** %l1
  %t50 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load i8*, i8** %l1
  %t56 = load double, double* %l2
  %t57 = load i8*, i8** %l1
  %t58 = call i64 @sailfin_runtime_string_length(i8* %t57)
  %t59 = icmp sgt i64 %t58, 0
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t61 = load i8*, i8** %l1
  %t62 = load double, double* %l2
  br i1 %t59, label %then9, label %merge10
then9:
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t64 = load i8*, i8** %l1
  %t65 = call i8* @trim_text(i8* %t64)
  %t66 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t63, i8* %t65)
  store { i8**, i64 }* %t66, { i8**, i64 }** %l0
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge10
merge10:
  %t68 = phi { i8**, i64 }* [ %t67, %then9 ], [ %t60, %afterloop3 ]
  store { i8**, i64 }* %t68, { i8**, i64 }** %l0
  %t69 = alloca [0 x i8*]
  %t70 = getelementptr [0 x i8*], [0 x i8*]* %t69, i32 0, i32 0
  %t71 = alloca { i8**, i64 }
  %t72 = getelementptr { i8**, i64 }, { i8**, i64 }* %t71, i32 0, i32 0
  store i8** %t70, i8*** %t72
  %t73 = getelementptr { i8**, i64 }, { i8**, i64 }* %t71, i32 0, i32 1
  store i64 0, i64* %t73
  store { i8**, i64 }* %t71, { i8**, i64 }** %l4
  %t74 = sitofp i64 0 to double
  store double %t74, double* %l2
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t76 = load i8*, i8** %l1
  %t77 = load double, double* %l2
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %loop.header11
loop.header11:
  %t116 = phi { i8**, i64 }* [ %t78, %merge10 ], [ %t114, %loop.latch13 ]
  %t117 = phi double [ %t77, %merge10 ], [ %t115, %loop.latch13 ]
  store { i8**, i64 }* %t116, { i8**, i64 }** %l4
  store double %t117, double* %l2
  br label %loop.body12
loop.body12:
  %t79 = load double, double* %l2
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t81 = load { i8**, i64 }, { i8**, i64 }* %t80
  %t82 = extractvalue { i8**, i64 } %t81, 1
  %t83 = sitofp i64 %t82 to double
  %t84 = fcmp oge double %t79, %t83
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t86 = load i8*, i8** %l1
  %t87 = load double, double* %l2
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br i1 %t84, label %then15, label %merge16
then15:
  br label %afterloop14
merge16:
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t90 = load double, double* %l2
  %t91 = fptosi double %t90 to i64
  %t92 = load { i8**, i64 }, { i8**, i64 }* %t89
  %t93 = extractvalue { i8**, i64 } %t92, 0
  %t94 = extractvalue { i8**, i64 } %t92, 1
  %t95 = icmp uge i64 %t91, %t94
  ; bounds check: %t95 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t91, i64 %t94)
  %t96 = getelementptr i8*, i8** %t93, i64 %t91
  %t97 = load i8*, i8** %t96
  store i8* %t97, i8** %l5
  %t98 = load i8*, i8** %l5
  %t99 = call i64 @sailfin_runtime_string_length(i8* %t98)
  %t100 = icmp sgt i64 %t99, 0
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t102 = load i8*, i8** %l1
  %t103 = load double, double* %l2
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t105 = load i8*, i8** %l5
  br i1 %t100, label %then17, label %merge18
then17:
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t107 = load i8*, i8** %l5
  %t108 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t106, i8* %t107)
  store { i8**, i64 }* %t108, { i8**, i64 }** %l4
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %merge18
merge18:
  %t110 = phi { i8**, i64 }* [ %t109, %then17 ], [ %t104, %merge16 ]
  store { i8**, i64 }* %t110, { i8**, i64 }** %l4
  %t111 = load double, double* %l2
  %t112 = sitofp i64 1 to double
  %t113 = fadd double %t111, %t112
  store double %t113, double* %l2
  br label %loop.latch13
loop.latch13:
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t115 = load double, double* %l2
  br label %loop.header11
afterloop14:
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t119 = load double, double* %l2
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l4
  ret { i8**, i64 }* %t120
}

define i8* @strip_generics(i8* %name) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l2
  %t3 = load i8*, i8** %l0
  %t4 = load double, double* %l1
  %t5 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t73 = phi double [ %t4, %entry ], [ %t70, %loop.latch2 ]
  %t74 = phi double [ %t5, %entry ], [ %t71, %loop.latch2 ]
  %t75 = phi i8* [ %t3, %entry ], [ %t72, %loop.latch2 ]
  store double %t73, double* %l1
  store double %t74, double* %l2
  store i8* %t75, i8** %l0
  br label %loop.body1
loop.body1:
  %t6 = load double, double* %l2
  %t7 = call i64 @sailfin_runtime_string_length(i8* %name)
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t6, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  %t12 = load double, double* %l2
  br i1 %t9, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t13 = load double, double* %l2
  %t14 = fptosi double %t13 to i64
  %t15 = getelementptr i8, i8* %name, i64 %t14
  %t16 = load i8, i8* %t15
  store i8 %t16, i8* %l3
  %t17 = load i8, i8* %l3
  %t18 = icmp eq i8 %t17, 60
  %t19 = load i8*, i8** %l0
  %t20 = load double, double* %l1
  %t21 = load double, double* %l2
  %t22 = load i8, i8* %l3
  br i1 %t18, label %then6, label %merge7
then6:
  %t23 = load double, double* %l1
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l1
  %t26 = load double, double* %l2
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  store double %t28, double* %l2
  br label %loop.latch2
merge7:
  %t29 = load i8, i8* %l3
  %t30 = icmp eq i8 %t29, 62
  %t31 = load i8*, i8** %l0
  %t32 = load double, double* %l1
  %t33 = load double, double* %l2
  %t34 = load i8, i8* %l3
  br i1 %t30, label %then8, label %merge9
then8:
  %t35 = load double, double* %l1
  %t36 = sitofp i64 0 to double
  %t37 = fcmp ogt double %t35, %t36
  %t38 = load i8*, i8** %l0
  %t39 = load double, double* %l1
  %t40 = load double, double* %l2
  %t41 = load i8, i8* %l3
  br i1 %t37, label %then10, label %merge11
then10:
  %t42 = load double, double* %l1
  %t43 = sitofp i64 1 to double
  %t44 = fsub double %t42, %t43
  store double %t44, double* %l1
  %t45 = load double, double* %l1
  br label %merge11
merge11:
  %t46 = phi double [ %t45, %then10 ], [ %t39, %then8 ]
  store double %t46, double* %l1
  %t47 = load double, double* %l2
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l2
  br label %loop.latch2
merge9:
  %t50 = load double, double* %l1
  %t51 = sitofp i64 0 to double
  %t52 = fcmp oeq double %t50, %t51
  %t53 = load i8*, i8** %l0
  %t54 = load double, double* %l1
  %t55 = load double, double* %l2
  %t56 = load i8, i8* %l3
  br i1 %t52, label %then12, label %merge13
then12:
  %t57 = load i8*, i8** %l0
  %t58 = load i8, i8* %l3
  %t59 = load i8, i8* %t57
  %t60 = add i8 %t59, %t58
  %t61 = alloca [2 x i8], align 1
  %t62 = getelementptr [2 x i8], [2 x i8]* %t61, i32 0, i32 0
  store i8 %t60, i8* %t62
  %t63 = getelementptr [2 x i8], [2 x i8]* %t61, i32 0, i32 1
  store i8 0, i8* %t63
  %t64 = getelementptr [2 x i8], [2 x i8]* %t61, i32 0, i32 0
  store i8* %t64, i8** %l0
  %t65 = load i8*, i8** %l0
  br label %merge13
merge13:
  %t66 = phi i8* [ %t65, %then12 ], [ %t53, %merge9 ]
  store i8* %t66, i8** %l0
  %t67 = load double, double* %l2
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %t67, %t68
  store double %t69, double* %l2
  br label %loop.latch2
loop.latch2:
  %t70 = load double, double* %l1
  %t71 = load double, double* %l2
  %t72 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t76 = load double, double* %l1
  %t77 = load double, double* %l2
  %t78 = load i8*, i8** %l0
  %t79 = load i8*, i8** %l0
  %t80 = call i8* @trim_text(i8* %t79)
  ret i8* %t80
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
  %t39 = fptosi double %t38 to i64
  %t40 = getelementptr i8, i8* %value, i64 %t39
  %t41 = load i8, i8* %t40
  store i8 %t41, i8* %l3
  %t42 = load i8, i8* %l3
  %t43 = alloca [2 x i8], align 1
  %t44 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  store i8 %t42, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 1
  store i8 0, i8* %t45
  %t46 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  %t47 = call i1 @is_trim_char(i8* %t46)
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
  ret i8* %value
merge17:
  %t68 = load double, double* %l0
  %t69 = load double, double* %l1
  %t70 = fptosi double %t68 to i64
  %t71 = fptosi double %t69 to i64
  %t72 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t70, i64 %t71)
  ret i8* %t72
}

define %LayoutManifest @parse_layout_manifest(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { %NativeStruct*, i64 }*
  %l3 = alloca { %NativeEnum*, i64 }*
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca %StructLayoutHeaderParse
  %l10 = alloca { %NativeStructLayoutField*, i64 }*
  %l11 = alloca i8*
  %l12 = alloca i8*
  %l13 = alloca i8*
  %l14 = alloca i8*
  %l15 = alloca %StructLayoutFieldParse
  %l16 = alloca %NativeStruct
  %l17 = alloca i8*
  %l18 = alloca i8*
  %l19 = alloca %EnumLayoutHeaderParse
  %l20 = alloca { %NativeEnumVariantLayout*, i64 }*
  %l21 = alloca i8*
  %l22 = alloca i8*
  %l23 = alloca i8*
  %l24 = alloca i8*
  %l25 = alloca %EnumLayoutVariantParse
  %l26 = alloca i8*
  %l27 = alloca i8*
  %l28 = alloca %EnumLayoutPayloadParse
  %l29 = alloca i64
  %l30 = alloca %NativeEnumVariantLayout
  %l31 = alloca { %NativeStructLayoutField*, i64 }*
  %l32 = alloca %NativeEnum
  %t0 = call { i8**, i64 }* @split_lines(i8* %text)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %t1 = alloca [0 x i8*]
  %t2 = getelementptr [0 x i8*], [0 x i8*]* %t1, i32 0, i32 0
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t2, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %t6 = alloca [0 x %NativeStruct]
  %t7 = getelementptr [0 x %NativeStruct], [0 x %NativeStruct]* %t6, i32 0, i32 0
  %t8 = alloca { %NativeStruct*, i64 }
  %t9 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t8, i32 0, i32 0
  store %NativeStruct* %t7, %NativeStruct** %t9
  %t10 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
  store { %NativeStruct*, i64 }* %t8, { %NativeStruct*, i64 }** %l2
  %t11 = alloca [0 x %NativeEnum]
  %t12 = getelementptr [0 x %NativeEnum], [0 x %NativeEnum]* %t11, i32 0, i32 0
  %t13 = alloca { %NativeEnum*, i64 }
  %t14 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t13, i32 0, i32 0
  store %NativeEnum* %t12, %NativeEnum** %t14
  %t15 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { %NativeEnum*, i64 }* %t13, { %NativeEnum*, i64 }** %l3
  %t16 = sitofp i64 0 to double
  store double %t16, double* %l4
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t19 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t20 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t21 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t653 = phi double [ %t21, %entry ], [ %t649, %loop.latch2 ]
  %t654 = phi { i8**, i64 }* [ %t18, %entry ], [ %t650, %loop.latch2 ]
  %t655 = phi { %NativeStruct*, i64 }* [ %t19, %entry ], [ %t651, %loop.latch2 ]
  %t656 = phi { %NativeEnum*, i64 }* [ %t20, %entry ], [ %t652, %loop.latch2 ]
  store double %t653, double* %l4
  store { i8**, i64 }* %t654, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t655, { %NativeStruct*, i64 }** %l2
  store { %NativeEnum*, i64 }* %t656, { %NativeEnum*, i64 }** %l3
  br label %loop.body1
loop.body1:
  %t22 = load double, double* %l4
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load { i8**, i64 }, { i8**, i64 }* %t23
  %t25 = extractvalue { i8**, i64 } %t24, 1
  %t26 = sitofp i64 %t25 to double
  %t27 = fcmp oge double %t22, %t26
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t30 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t31 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t32 = load double, double* %l4
  br i1 %t27, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load double, double* %l4
  %t35 = fptosi double %t34 to i64
  %t36 = load { i8**, i64 }, { i8**, i64 }* %t33
  %t37 = extractvalue { i8**, i64 } %t36, 0
  %t38 = extractvalue { i8**, i64 } %t36, 1
  %t39 = icmp uge i64 %t35, %t38
  ; bounds check: %t39 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t35, i64 %t38)
  %t40 = getelementptr i8*, i8** %t37, i64 %t35
  %t41 = load i8*, i8** %t40
  store i8* %t41, i8** %l5
  %t42 = load i8*, i8** %l5
  %t43 = call i8* @trim_text(i8* %t42)
  store i8* %t43, i8** %l6
  %t44 = load i8*, i8** %l6
  %t45 = call i64 @sailfin_runtime_string_length(i8* %t44)
  %t46 = icmp eq i64 %t45, 0
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t49 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t50 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t51 = load double, double* %l4
  %t52 = load i8*, i8** %l5
  %t53 = load i8*, i8** %l6
  br i1 %t46, label %then6, label %merge7
then6:
  %t54 = load double, double* %l4
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %t54, %t55
  store double %t56, double* %l4
  br label %loop.latch2
merge7:
  %t57 = load i8*, i8** %l6
  %t58 = alloca [2 x i8], align 1
  %t59 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  store i8 59, i8* %t59
  %t60 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 1
  store i8 0, i8* %t60
  %t61 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  %t62 = call i1 @starts_with(i8* %t57, i8* %t61)
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t65 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t66 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t67 = load double, double* %l4
  %t68 = load i8*, i8** %l5
  %t69 = load i8*, i8** %l6
  br i1 %t62, label %then8, label %merge9
then8:
  %t70 = load double, double* %l4
  %t71 = sitofp i64 1 to double
  %t72 = fadd double %t70, %t71
  store double %t72, double* %l4
  br label %loop.latch2
merge9:
  %t73 = load i8*, i8** %l6
  %s74 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1219235236, i32 0, i32 0
  %t75 = call i1 @starts_with(i8* %t73, i8* %s74)
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t78 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t79 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t80 = load double, double* %l4
  %t81 = load i8*, i8** %l5
  %t82 = load i8*, i8** %l6
  br i1 %t75, label %then10, label %merge11
then10:
  %t83 = load double, double* %l4
  %t84 = sitofp i64 1 to double
  %t85 = fadd double %t83, %t84
  store double %t85, double* %l4
  br label %loop.latch2
merge11:
  %t86 = load i8*, i8** %l6
  %s87 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h87749209, i32 0, i32 0
  %t88 = call i1 @starts_with(i8* %t86, i8* %s87)
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t91 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t92 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t93 = load double, double* %l4
  %t94 = load i8*, i8** %l5
  %t95 = load i8*, i8** %l6
  br i1 %t88, label %then12, label %merge13
then12:
  %t96 = load i8*, i8** %l6
  %s97 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t98 = call i8* @strip_prefix(i8* %t96, i8* %s97)
  store i8* %t98, i8** %l7
  %t99 = load i8*, i8** %l7
  %s100 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t101 = call i8* @strip_prefix(i8* %t99, i8* %s100)
  store i8* %t101, i8** %l8
  %t102 = load i8*, i8** %l8
  %t103 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t102)
  store %StructLayoutHeaderParse %t103, %StructLayoutHeaderParse* %l9
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t105 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t106 = extractvalue %StructLayoutHeaderParse %t105, 4
  %t107 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t104, { i8**, i64 }* %t106)
  store { i8**, i64 }* %t107, { i8**, i64 }** %l1
  %t108 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t109 = extractvalue %StructLayoutHeaderParse %t108, 0
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t112 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t113 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t114 = load double, double* %l4
  %t115 = load i8*, i8** %l5
  %t116 = load i8*, i8** %l6
  %t117 = load i8*, i8** %l7
  %t118 = load i8*, i8** %l8
  %t119 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  br i1 %t109, label %then14, label %merge15
then14:
  %t120 = alloca [0 x %NativeStructLayoutField]
  %t121 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* %t120, i32 0, i32 0
  %t122 = alloca { %NativeStructLayoutField*, i64 }
  %t123 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t122, i32 0, i32 0
  store %NativeStructLayoutField* %t121, %NativeStructLayoutField** %t123
  %t124 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t122, i32 0, i32 1
  store i64 0, i64* %t124
  store { %NativeStructLayoutField*, i64 }* %t122, { %NativeStructLayoutField*, i64 }** %l10
  %t125 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t126 = extractvalue %StructLayoutHeaderParse %t125, 1
  store i8* %t126, i8** %l11
  %t127 = load double, double* %l4
  %t128 = sitofp i64 1 to double
  %t129 = fadd double %t127, %t128
  store double %t129, double* %l4
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t132 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t133 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t134 = load double, double* %l4
  %t135 = load i8*, i8** %l5
  %t136 = load i8*, i8** %l6
  %t137 = load i8*, i8** %l7
  %t138 = load i8*, i8** %l8
  %t139 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t140 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t141 = load i8*, i8** %l11
  br label %loop.header16
loop.header16:
  %t247 = phi i8* [ %t137, %then14 ], [ %t243, %loop.latch18 ]
  %t248 = phi { i8**, i64 }* [ %t131, %then14 ], [ %t244, %loop.latch18 ]
  %t249 = phi { %NativeStructLayoutField*, i64 }* [ %t140, %then14 ], [ %t245, %loop.latch18 ]
  %t250 = phi double [ %t134, %then14 ], [ %t246, %loop.latch18 ]
  store i8* %t247, i8** %l7
  store { i8**, i64 }* %t248, { i8**, i64 }** %l1
  store { %NativeStructLayoutField*, i64 }* %t249, { %NativeStructLayoutField*, i64 }** %l10
  store double %t250, double* %l4
  br label %loop.body17
loop.body17:
  %t142 = load double, double* %l4
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t144 = load { i8**, i64 }, { i8**, i64 }* %t143
  %t145 = extractvalue { i8**, i64 } %t144, 1
  %t146 = sitofp i64 %t145 to double
  %t147 = fcmp oge double %t142, %t146
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t150 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t151 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t152 = load double, double* %l4
  %t153 = load i8*, i8** %l5
  %t154 = load i8*, i8** %l6
  %t155 = load i8*, i8** %l7
  %t156 = load i8*, i8** %l8
  %t157 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t158 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t159 = load i8*, i8** %l11
  br i1 %t147, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t161 = load double, double* %l4
  %t162 = fptosi double %t161 to i64
  %t163 = load { i8**, i64 }, { i8**, i64 }* %t160
  %t164 = extractvalue { i8**, i64 } %t163, 0
  %t165 = extractvalue { i8**, i64 } %t163, 1
  %t166 = icmp uge i64 %t162, %t165
  ; bounds check: %t166 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t162, i64 %t165)
  %t167 = getelementptr i8*, i8** %t164, i64 %t162
  %t168 = load i8*, i8** %t167
  %t169 = call i8* @trim_text(i8* %t168)
  store i8* %t169, i8** %l12
  %t170 = load i8*, i8** %l12
  %t171 = call i64 @sailfin_runtime_string_length(i8* %t170)
  %t172 = icmp eq i64 %t171, 0
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t175 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t176 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t177 = load double, double* %l4
  %t178 = load i8*, i8** %l5
  %t179 = load i8*, i8** %l6
  %t180 = load i8*, i8** %l7
  %t181 = load i8*, i8** %l8
  %t182 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t183 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t184 = load i8*, i8** %l11
  %t185 = load i8*, i8** %l12
  br i1 %t172, label %then22, label %merge23
then22:
  br label %afterloop19
merge23:
  %t186 = load i8*, i8** %l12
  %s187 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1053492670, i32 0, i32 0
  %t188 = call i1 @starts_with(i8* %t186, i8* %s187)
  %t189 = xor i1 %t188, 1
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t192 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t193 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t194 = load double, double* %l4
  %t195 = load i8*, i8** %l5
  %t196 = load i8*, i8** %l6
  %t197 = load i8*, i8** %l7
  %t198 = load i8*, i8** %l8
  %t199 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t200 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t201 = load i8*, i8** %l11
  %t202 = load i8*, i8** %l12
  br i1 %t189, label %then24, label %merge25
then24:
  br label %afterloop19
merge25:
  %t203 = load i8*, i8** %l12
  %s204 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t205 = call i8* @strip_prefix(i8* %t203, i8* %s204)
  store i8* %t205, i8** %l13
  %t206 = load i8*, i8** %l7
  %s207 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h734244628, i32 0, i32 0
  %t208 = call i8* @strip_prefix(i8* %t206, i8* %s207)
  store i8* %t208, i8** %l14
  %t209 = load i8*, i8** %l14
  %t210 = load i8*, i8** %l11
  %t211 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t209, i8* %t210)
  store %StructLayoutFieldParse %t211, %StructLayoutFieldParse* %l15
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t213 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t214 = extractvalue %StructLayoutFieldParse %t213, 2
  %t215 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t212, { i8**, i64 }* %t214)
  store { i8**, i64 }* %t215, { i8**, i64 }** %l1
  %t216 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t217 = extractvalue %StructLayoutFieldParse %t216, 0
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t220 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t221 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t222 = load double, double* %l4
  %t223 = load i8*, i8** %l5
  %t224 = load i8*, i8** %l6
  %t225 = load i8*, i8** %l7
  %t226 = load i8*, i8** %l8
  %t227 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t228 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t229 = load i8*, i8** %l11
  %t230 = load i8*, i8** %l12
  %t231 = load i8*, i8** %l13
  %t232 = load i8*, i8** %l14
  %t233 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  br i1 %t217, label %then26, label %merge27
then26:
  %t234 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t235 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t236 = extractvalue %StructLayoutFieldParse %t235, 1
  %t237 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t234, %NativeStructLayoutField %t236)
  store { %NativeStructLayoutField*, i64 }* %t237, { %NativeStructLayoutField*, i64 }** %l10
  %t238 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  br label %merge27
merge27:
  %t239 = phi { %NativeStructLayoutField*, i64 }* [ %t238, %then26 ], [ %t228, %merge25 ]
  store { %NativeStructLayoutField*, i64 }* %t239, { %NativeStructLayoutField*, i64 }** %l10
  %t240 = load double, double* %l4
  %t241 = sitofp i64 1 to double
  %t242 = fadd double %t240, %t241
  store double %t242, double* %l4
  br label %loop.latch18
loop.latch18:
  %t243 = load i8*, i8** %l7
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t245 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t246 = load double, double* %l4
  br label %loop.header16
afterloop19:
  %t251 = load i8*, i8** %l7
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t253 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t254 = load double, double* %l4
  %t255 = load i8*, i8** %l11
  %t256 = insertvalue %NativeStruct undef, i8* %t255, 0
  %t257 = alloca [0 x %NativeStructField*]
  %t258 = getelementptr [0 x %NativeStructField*], [0 x %NativeStructField*]* %t257, i32 0, i32 0
  %t259 = alloca { %NativeStructField**, i64 }
  %t260 = getelementptr { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* %t259, i32 0, i32 0
  store %NativeStructField** %t258, %NativeStructField*** %t260
  %t261 = getelementptr { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* %t259, i32 0, i32 1
  store i64 0, i64* %t261
  %t262 = insertvalue %NativeStruct %t256, { %NativeStructField**, i64 }* %t259, 1
  %t263 = alloca [0 x %NativeFunction*]
  %t264 = getelementptr [0 x %NativeFunction*], [0 x %NativeFunction*]* %t263, i32 0, i32 0
  %t265 = alloca { %NativeFunction**, i64 }
  %t266 = getelementptr { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t265, i32 0, i32 0
  store %NativeFunction** %t264, %NativeFunction*** %t266
  %t267 = getelementptr { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t265, i32 0, i32 1
  store i64 0, i64* %t267
  %t268 = insertvalue %NativeStruct %t262, { %NativeFunction**, i64 }* %t265, 2
  %t269 = alloca [0 x i8*]
  %t270 = getelementptr [0 x i8*], [0 x i8*]* %t269, i32 0, i32 0
  %t271 = alloca { i8**, i64 }
  %t272 = getelementptr { i8**, i64 }, { i8**, i64 }* %t271, i32 0, i32 0
  store i8** %t270, i8*** %t272
  %t273 = getelementptr { i8**, i64 }, { i8**, i64 }* %t271, i32 0, i32 1
  store i64 0, i64* %t273
  %t274 = insertvalue %NativeStruct %t268, { i8**, i64 }* %t271, 3
  %t275 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t276 = extractvalue %StructLayoutHeaderParse %t275, 2
  %t277 = insertvalue %NativeStructLayout undef, double %t276, 0
  %t278 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t279 = extractvalue %StructLayoutHeaderParse %t278, 3
  %t280 = insertvalue %NativeStructLayout %t277, double %t279, 1
  %t281 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t282 = bitcast { %NativeStructLayoutField*, i64 }* %t281 to { %NativeStructLayoutField**, i64 }*
  %t283 = insertvalue %NativeStructLayout %t280, { %NativeStructLayoutField**, i64 }* %t282, 2
  %t284 = alloca %NativeStructLayout
  store %NativeStructLayout %t283, %NativeStructLayout* %t284
  %t285 = insertvalue %NativeStruct %t274, %NativeStructLayout* %t284, 4
  store %NativeStruct %t285, %NativeStruct* %l16
  %t286 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t287 = load %NativeStruct, %NativeStruct* %l16
  %t288 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t286, %NativeStruct %t287)
  store { %NativeStruct*, i64 }* %t288, { %NativeStruct*, i64 }** %l2
  %t289 = load double, double* %l4
  %t290 = load i8*, i8** %l7
  %t291 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t292 = load double, double* %l4
  %t293 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  br label %merge15
merge15:
  %t294 = phi double [ %t289, %afterloop19 ], [ %t114, %then12 ]
  %t295 = phi i8* [ %t290, %afterloop19 ], [ %t117, %then12 ]
  %t296 = phi { i8**, i64 }* [ %t291, %afterloop19 ], [ %t111, %then12 ]
  %t297 = phi double [ %t292, %afterloop19 ], [ %t114, %then12 ]
  %t298 = phi { %NativeStruct*, i64 }* [ %t293, %afterloop19 ], [ %t112, %then12 ]
  store double %t294, double* %l4
  store i8* %t295, i8** %l7
  store { i8**, i64 }* %t296, { i8**, i64 }** %l1
  store double %t297, double* %l4
  store { %NativeStruct*, i64 }* %t298, { %NativeStruct*, i64 }** %l2
  %t299 = load double, double* %l4
  %t300 = sitofp i64 1 to double
  %t301 = fadd double %t299, %t300
  store double %t301, double* %l4
  br label %loop.latch2
merge13:
  %t302 = load i8*, i8** %l6
  %s303 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h259593098, i32 0, i32 0
  %t304 = call i1 @starts_with(i8* %t302, i8* %s303)
  %t305 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t306 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t307 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t308 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t309 = load double, double* %l4
  %t310 = load i8*, i8** %l5
  %t311 = load i8*, i8** %l6
  br i1 %t304, label %then28, label %merge29
then28:
  %t312 = load i8*, i8** %l6
  %s313 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t314 = call i8* @strip_prefix(i8* %t312, i8* %s313)
  store i8* %t314, i8** %l17
  %t315 = load i8*, i8** %l17
  %s316 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t317 = call i8* @strip_prefix(i8* %t315, i8* %s316)
  store i8* %t317, i8** %l18
  %t318 = load i8*, i8** %l18
  %t319 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t318)
  store %EnumLayoutHeaderParse %t319, %EnumLayoutHeaderParse* %l19
  %t320 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t321 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t322 = extractvalue %EnumLayoutHeaderParse %t321, 7
  %t323 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t320, { i8**, i64 }* %t322)
  store { i8**, i64 }* %t323, { i8**, i64 }** %l1
  %t324 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t325 = extractvalue %EnumLayoutHeaderParse %t324, 0
  %t326 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t327 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t328 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t329 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t330 = load double, double* %l4
  %t331 = load i8*, i8** %l5
  %t332 = load i8*, i8** %l6
  %t333 = load i8*, i8** %l17
  %t334 = load i8*, i8** %l18
  %t335 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  br i1 %t325, label %then30, label %else31
then30:
  %t336 = alloca [0 x %NativeEnumVariantLayout]
  %t337 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* %t336, i32 0, i32 0
  %t338 = alloca { %NativeEnumVariantLayout*, i64 }
  %t339 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t338, i32 0, i32 0
  store %NativeEnumVariantLayout* %t337, %NativeEnumVariantLayout** %t339
  %t340 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t338, i32 0, i32 1
  store i64 0, i64* %t340
  store { %NativeEnumVariantLayout*, i64 }* %t338, { %NativeEnumVariantLayout*, i64 }** %l20
  %t341 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t342 = extractvalue %EnumLayoutHeaderParse %t341, 1
  store i8* %t342, i8** %l21
  %t343 = load double, double* %l4
  %t344 = sitofp i64 1 to double
  %t345 = fadd double %t343, %t344
  store double %t345, double* %l4
  %t346 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t347 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t348 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t349 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t350 = load double, double* %l4
  %t351 = load i8*, i8** %l5
  %t352 = load i8*, i8** %l6
  %t353 = load i8*, i8** %l17
  %t354 = load i8*, i8** %l18
  %t355 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t356 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t357 = load i8*, i8** %l21
  br label %loop.header33
loop.header33:
  %t594 = phi double [ %t350, %then30 ], [ %t590, %loop.latch35 ]
  %t595 = phi i8* [ %t353, %then30 ], [ %t591, %loop.latch35 ]
  %t596 = phi { i8**, i64 }* [ %t347, %then30 ], [ %t592, %loop.latch35 ]
  %t597 = phi { %NativeEnumVariantLayout*, i64 }* [ %t356, %then30 ], [ %t593, %loop.latch35 ]
  store double %t594, double* %l4
  store i8* %t595, i8** %l17
  store { i8**, i64 }* %t596, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t597, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.body34
loop.body34:
  %t358 = load double, double* %l4
  %t359 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t360 = load { i8**, i64 }, { i8**, i64 }* %t359
  %t361 = extractvalue { i8**, i64 } %t360, 1
  %t362 = sitofp i64 %t361 to double
  %t363 = fcmp oge double %t358, %t362
  %t364 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t365 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t366 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t367 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t368 = load double, double* %l4
  %t369 = load i8*, i8** %l5
  %t370 = load i8*, i8** %l6
  %t371 = load i8*, i8** %l17
  %t372 = load i8*, i8** %l18
  %t373 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t374 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t375 = load i8*, i8** %l21
  br i1 %t363, label %then37, label %merge38
then37:
  br label %afterloop36
merge38:
  %t376 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t377 = load double, double* %l4
  %t378 = fptosi double %t377 to i64
  %t379 = load { i8**, i64 }, { i8**, i64 }* %t376
  %t380 = extractvalue { i8**, i64 } %t379, 0
  %t381 = extractvalue { i8**, i64 } %t379, 1
  %t382 = icmp uge i64 %t378, %t381
  ; bounds check: %t382 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t378, i64 %t381)
  %t383 = getelementptr i8*, i8** %t380, i64 %t378
  %t384 = load i8*, i8** %t383
  %t385 = call i8* @trim_text(i8* %t384)
  store i8* %t385, i8** %l22
  %t386 = load i8*, i8** %l22
  %t387 = call i64 @sailfin_runtime_string_length(i8* %t386)
  %t388 = icmp eq i64 %t387, 0
  %t389 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t390 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t391 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t392 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t393 = load double, double* %l4
  %t394 = load i8*, i8** %l5
  %t395 = load i8*, i8** %l6
  %t396 = load i8*, i8** %l17
  %t397 = load i8*, i8** %l18
  %t398 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t399 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t400 = load i8*, i8** %l21
  %t401 = load i8*, i8** %l22
  br i1 %t388, label %then39, label %merge40
then39:
  %t402 = load double, double* %l4
  %t403 = sitofp i64 1 to double
  %t404 = fadd double %t402, %t403
  store double %t404, double* %l4
  br label %afterloop36
merge40:
  %t406 = load i8*, i8** %l22
  %s407 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1695010494, i32 0, i32 0
  %t408 = call i1 @starts_with(i8* %t406, i8* %s407)
  br label %logical_and_entry_405

logical_and_entry_405:
  br i1 %t408, label %logical_and_right_405, label %logical_and_merge_405

logical_and_right_405:
  %t409 = load i8*, i8** %l22
  %s410 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1290415774, i32 0, i32 0
  %t411 = call i1 @starts_with(i8* %t409, i8* %s410)
  %t412 = xor i1 %t411, 1
  br label %logical_and_right_end_405

logical_and_right_end_405:
  br label %logical_and_merge_405

logical_and_merge_405:
  %t413 = phi i1 [ false, %logical_and_entry_405 ], [ %t412, %logical_and_right_end_405 ]
  %t414 = xor i1 %t413, 1
  %t415 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t416 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t417 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t418 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t419 = load double, double* %l4
  %t420 = load i8*, i8** %l5
  %t421 = load i8*, i8** %l6
  %t422 = load i8*, i8** %l17
  %t423 = load i8*, i8** %l18
  %t424 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t425 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t426 = load i8*, i8** %l21
  %t427 = load i8*, i8** %l22
  br i1 %t414, label %then41, label %merge42
then41:
  br label %afterloop36
merge42:
  %t428 = load i8*, i8** %l22
  %s429 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1695010494, i32 0, i32 0
  %t430 = call i1 @starts_with(i8* %t428, i8* %s429)
  %t431 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t432 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t433 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t434 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t435 = load double, double* %l4
  %t436 = load i8*, i8** %l5
  %t437 = load i8*, i8** %l6
  %t438 = load i8*, i8** %l17
  %t439 = load i8*, i8** %l18
  %t440 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t441 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t442 = load i8*, i8** %l21
  %t443 = load i8*, i8** %l22
  br i1 %t430, label %then43, label %else44
then43:
  %t444 = load i8*, i8** %l22
  %s445 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t446 = call i8* @strip_prefix(i8* %t444, i8* %s445)
  store i8* %t446, i8** %l23
  %t447 = load i8*, i8** %l17
  %s448 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1926252274, i32 0, i32 0
  %t449 = call i8* @strip_prefix(i8* %t447, i8* %s448)
  store i8* %t449, i8** %l24
  %t450 = load i8*, i8** %l24
  %t451 = load i8*, i8** %l21
  %t452 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t450, i8* %t451)
  store %EnumLayoutVariantParse %t452, %EnumLayoutVariantParse* %l25
  %t453 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t454 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t455 = extractvalue %EnumLayoutVariantParse %t454, 2
  %t456 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t453, { i8**, i64 }* %t455)
  store { i8**, i64 }* %t456, { i8**, i64 }** %l1
  %t457 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t458 = extractvalue %EnumLayoutVariantParse %t457, 0
  %t459 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t460 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t461 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t462 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t463 = load double, double* %l4
  %t464 = load i8*, i8** %l5
  %t465 = load i8*, i8** %l6
  %t466 = load i8*, i8** %l17
  %t467 = load i8*, i8** %l18
  %t468 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t469 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t470 = load i8*, i8** %l21
  %t471 = load i8*, i8** %l22
  %t472 = load i8*, i8** %l23
  %t473 = load i8*, i8** %l24
  %t474 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  br i1 %t458, label %then46, label %merge47
then46:
  %t475 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t476 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t477 = extractvalue %EnumLayoutVariantParse %t476, 1
  %t478 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t475, %NativeEnumVariantLayout %t477)
  store { %NativeEnumVariantLayout*, i64 }* %t478, { %NativeEnumVariantLayout*, i64 }** %l20
  %t479 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge47
merge47:
  %t480 = phi { %NativeEnumVariantLayout*, i64 }* [ %t479, %then46 ], [ %t469, %then43 ]
  store { %NativeEnumVariantLayout*, i64 }* %t480, { %NativeEnumVariantLayout*, i64 }** %l20
  %t481 = load i8*, i8** %l17
  %t482 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t483 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge45
else44:
  %t484 = load i8*, i8** %l22
  %s485 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1290415774, i32 0, i32 0
  %t486 = call i1 @starts_with(i8* %t484, i8* %s485)
  %t487 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t488 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t489 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t490 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t491 = load double, double* %l4
  %t492 = load i8*, i8** %l5
  %t493 = load i8*, i8** %l6
  %t494 = load i8*, i8** %l17
  %t495 = load i8*, i8** %l18
  %t496 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t497 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t498 = load i8*, i8** %l21
  %t499 = load i8*, i8** %l22
  br i1 %t486, label %then48, label %merge49
then48:
  %t500 = load i8*, i8** %l22
  %s501 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t502 = call i8* @strip_prefix(i8* %t500, i8* %s501)
  store i8* %t502, i8** %l26
  %t503 = load i8*, i8** %l17
  %s504 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1521657554, i32 0, i32 0
  %t505 = call i8* @strip_prefix(i8* %t503, i8* %s504)
  store i8* %t505, i8** %l27
  %t506 = load i8*, i8** %l27
  %t507 = load i8*, i8** %l21
  %t508 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t506, i8* %t507)
  store %EnumLayoutPayloadParse %t508, %EnumLayoutPayloadParse* %l28
  %t509 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t510 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t511 = extractvalue %EnumLayoutPayloadParse %t510, 3
  %t512 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t509, { i8**, i64 }* %t511)
  store { i8**, i64 }* %t512, { i8**, i64 }** %l1
  %t514 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t515 = extractvalue %EnumLayoutPayloadParse %t514, 0
  br label %logical_and_entry_513

logical_and_entry_513:
  br i1 %t515, label %logical_and_right_513, label %logical_and_merge_513

logical_and_right_513:
  %t516 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t517 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t516
  %t518 = extractvalue { %NativeEnumVariantLayout*, i64 } %t517, 1
  %t519 = icmp sgt i64 %t518, 0
  br label %logical_and_right_end_513

logical_and_right_end_513:
  br label %logical_and_merge_513

logical_and_merge_513:
  %t520 = phi i1 [ false, %logical_and_entry_513 ], [ %t519, %logical_and_right_end_513 ]
  %t521 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t522 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t523 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t524 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t525 = load double, double* %l4
  %t526 = load i8*, i8** %l5
  %t527 = load i8*, i8** %l6
  %t528 = load i8*, i8** %l17
  %t529 = load i8*, i8** %l18
  %t530 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t531 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t532 = load i8*, i8** %l21
  %t533 = load i8*, i8** %l22
  %t534 = load i8*, i8** %l26
  %t535 = load i8*, i8** %l27
  %t536 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  br i1 %t520, label %then50, label %merge51
then50:
  %t537 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t538 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t537
  %t539 = extractvalue { %NativeEnumVariantLayout*, i64 } %t538, 1
  %t540 = sub i64 %t539, 1
  store i64 %t540, i64* %l29
  %t541 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t542 = load i64, i64* %l29
  %t543 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t541
  %t544 = extractvalue { %NativeEnumVariantLayout*, i64 } %t543, 0
  %t545 = extractvalue { %NativeEnumVariantLayout*, i64 } %t543, 1
  %t546 = icmp uge i64 %t542, %t545
  ; bounds check: %t546 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t542, i64 %t545)
  %t547 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t544, i64 %t542
  %t548 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t547
  store %NativeEnumVariantLayout %t548, %NativeEnumVariantLayout* %l30
  %t549 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t550 = extractvalue %NativeEnumVariantLayout %t549, 5
  %t551 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t552 = extractvalue %EnumLayoutPayloadParse %t551, 2
  %t553 = bitcast { %NativeStructLayoutField**, i64 }* %t550 to { %NativeStructLayoutField*, i64 }*
  %t554 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t553, %NativeStructLayoutField %t552)
  store { %NativeStructLayoutField*, i64 }* %t554, { %NativeStructLayoutField*, i64 }** %l31
  %t555 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t556 = extractvalue %NativeEnumVariantLayout %t555, 0
  %t557 = insertvalue %NativeEnumVariantLayout undef, i8* %t556, 0
  %t558 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t559 = extractvalue %NativeEnumVariantLayout %t558, 1
  %t560 = insertvalue %NativeEnumVariantLayout %t557, double %t559, 1
  %t561 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t562 = extractvalue %NativeEnumVariantLayout %t561, 2
  %t563 = insertvalue %NativeEnumVariantLayout %t560, double %t562, 2
  %t564 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t565 = extractvalue %NativeEnumVariantLayout %t564, 3
  %t566 = insertvalue %NativeEnumVariantLayout %t563, double %t565, 3
  %t567 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t568 = extractvalue %NativeEnumVariantLayout %t567, 4
  %t569 = insertvalue %NativeEnumVariantLayout %t566, double %t568, 4
  %t570 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l31
  %t571 = bitcast { %NativeStructLayoutField*, i64 }* %t570 to { %NativeStructLayoutField**, i64 }*
  %t572 = insertvalue %NativeEnumVariantLayout %t569, { %NativeStructLayoutField**, i64 }* %t571, 5
  %t573 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t574 = load i64, i64* %l29
  %t575 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t573, i32 0, i32 0
  %t577 = load %NativeEnumVariantLayout*, %NativeEnumVariantLayout** %t575
  %t576 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t577, i64 %t574
  store %NativeEnumVariantLayout %t572, %NativeEnumVariantLayout* %t576
  br label %merge51
merge51:
  %t578 = load i8*, i8** %l17
  %t579 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge49
merge49:
  %t580 = phi i8* [ %t578, %merge51 ], [ %t494, %else44 ]
  %t581 = phi { i8**, i64 }* [ %t579, %merge51 ], [ %t488, %else44 ]
  store i8* %t580, i8** %l17
  store { i8**, i64 }* %t581, { i8**, i64 }** %l1
  %t582 = load i8*, i8** %l17
  %t583 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge45
merge45:
  %t584 = phi i8* [ %t481, %merge47 ], [ %t582, %merge49 ]
  %t585 = phi { i8**, i64 }* [ %t482, %merge47 ], [ %t583, %merge49 ]
  %t586 = phi { %NativeEnumVariantLayout*, i64 }* [ %t483, %merge47 ], [ %t441, %merge49 ]
  store i8* %t584, i8** %l17
  store { i8**, i64 }* %t585, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t586, { %NativeEnumVariantLayout*, i64 }** %l20
  %t587 = load double, double* %l4
  %t588 = sitofp i64 1 to double
  %t589 = fadd double %t587, %t588
  store double %t589, double* %l4
  br label %loop.latch35
loop.latch35:
  %t590 = load double, double* %l4
  %t591 = load i8*, i8** %l17
  %t592 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t593 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.header33
afterloop36:
  %t598 = load double, double* %l4
  %t599 = load i8*, i8** %l17
  %t600 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t601 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t602 = load i8*, i8** %l21
  %t603 = insertvalue %NativeEnum undef, i8* %t602, 0
  %t604 = alloca [0 x %NativeEnumVariant*]
  %t605 = getelementptr [0 x %NativeEnumVariant*], [0 x %NativeEnumVariant*]* %t604, i32 0, i32 0
  %t606 = alloca { %NativeEnumVariant**, i64 }
  %t607 = getelementptr { %NativeEnumVariant**, i64 }, { %NativeEnumVariant**, i64 }* %t606, i32 0, i32 0
  store %NativeEnumVariant** %t605, %NativeEnumVariant*** %t607
  %t608 = getelementptr { %NativeEnumVariant**, i64 }, { %NativeEnumVariant**, i64 }* %t606, i32 0, i32 1
  store i64 0, i64* %t608
  %t609 = insertvalue %NativeEnum %t603, { %NativeEnumVariant**, i64 }* %t606, 1
  %t610 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t611 = extractvalue %EnumLayoutHeaderParse %t610, 2
  %t612 = insertvalue %NativeEnumLayout undef, double %t611, 0
  %t613 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t614 = extractvalue %EnumLayoutHeaderParse %t613, 3
  %t615 = insertvalue %NativeEnumLayout %t612, double %t614, 1
  %t616 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t617 = extractvalue %EnumLayoutHeaderParse %t616, 4
  %t618 = insertvalue %NativeEnumLayout %t615, i8* %t617, 2
  %t619 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t620 = extractvalue %EnumLayoutHeaderParse %t619, 5
  %t621 = insertvalue %NativeEnumLayout %t618, double %t620, 3
  %t622 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t623 = extractvalue %EnumLayoutHeaderParse %t622, 6
  %t624 = insertvalue %NativeEnumLayout %t621, double %t623, 4
  %t625 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t626 = bitcast { %NativeEnumVariantLayout*, i64 }* %t625 to { %NativeEnumVariantLayout**, i64 }*
  %t627 = insertvalue %NativeEnumLayout %t624, { %NativeEnumVariantLayout**, i64 }* %t626, 5
  %t628 = alloca %NativeEnumLayout
  store %NativeEnumLayout %t627, %NativeEnumLayout* %t628
  %t629 = insertvalue %NativeEnum %t609, %NativeEnumLayout* %t628, 2
  store %NativeEnum %t629, %NativeEnum* %l32
  %t630 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t631 = load %NativeEnum, %NativeEnum* %l32
  %t632 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t630, %NativeEnum %t631)
  store { %NativeEnum*, i64 }* %t632, { %NativeEnum*, i64 }** %l3
  %t633 = load double, double* %l4
  %t634 = load double, double* %l4
  %t635 = load i8*, i8** %l17
  %t636 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t637 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  br label %merge32
else31:
  %t638 = load double, double* %l4
  %t639 = sitofp i64 1 to double
  %t640 = fadd double %t638, %t639
  store double %t640, double* %l4
  %t641 = load double, double* %l4
  br label %merge32
merge32:
  %t642 = phi double [ %t633, %afterloop36 ], [ %t641, %else31 ]
  %t643 = phi i8* [ %t635, %afterloop36 ], [ %t333, %else31 ]
  %t644 = phi { i8**, i64 }* [ %t636, %afterloop36 ], [ %t327, %else31 ]
  %t645 = phi { %NativeEnum*, i64 }* [ %t637, %afterloop36 ], [ %t329, %else31 ]
  store double %t642, double* %l4
  store i8* %t643, i8** %l17
  store { i8**, i64 }* %t644, { i8**, i64 }** %l1
  store { %NativeEnum*, i64 }* %t645, { %NativeEnum*, i64 }** %l3
  br label %loop.latch2
merge29:
  %t646 = load double, double* %l4
  %t647 = sitofp i64 1 to double
  %t648 = fadd double %t646, %t647
  store double %t648, double* %l4
  br label %loop.latch2
loop.latch2:
  %t649 = load double, double* %l4
  %t650 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t651 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t652 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  br label %loop.header0
afterloop3:
  %t657 = load double, double* %l4
  %t658 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t659 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t660 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t661 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t662 = bitcast { %NativeStruct*, i64 }* %t661 to { %NativeStruct**, i64 }*
  %t663 = insertvalue %LayoutManifest undef, { %NativeStruct**, i64 }* %t662, 0
  %t664 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t665 = bitcast { %NativeEnum*, i64 }* %t664 to { %NativeEnum**, i64 }*
  %t666 = insertvalue %LayoutManifest %t663, { %NativeEnum**, i64 }* %t665, 1
  %t667 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t668 = insertvalue %LayoutManifest %t666, { i8**, i64 }* %t667, 2
  ret %LayoutManifest %t668
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

define i8* @strip_prefix(i8* %value, i8* %prefix) {
entry:
  %t0 = call i1 @starts_with(i8* %value, i8* %prefix)
  %t1 = xor i1 %t0, 1
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* %value
merge1:
  %t2 = call i64 @sailfin_runtime_string_length(i8* %prefix)
  %t3 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t4 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t2, i64 %t3)
  ret i8* %t4
}

define double @index_of(i8* %value, i8* %target) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i1
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
  %t27 = fptosi double %t26 to i64
  %t28 = getelementptr i8, i8* %value, i64 %t27
  %t29 = load i8, i8* %t28
  %t30 = load double, double* %l1
  %t31 = fptosi double %t30 to i64
  %t32 = getelementptr i8, i8* %target, i64 %t31
  %t33 = load i8, i8* %t32
  %t34 = icmp ne i8 %t29, %t33
  %t35 = load double, double* %l0
  %t36 = load double, double* %l1
  %t37 = load i1, i1* %l2
  br i1 %t34, label %then14, label %merge15
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

define double @last_index_of(i8* %value, i8* %target) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i1
  %t0 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t3 = sitofp i64 %t2 to double
  ret double %t3
merge1:
  %t4 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t5 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t6 = sub i64 %t4, %t5
  %t7 = sitofp i64 %t6 to double
  store double %t7, double* %l0
  %t8 = load double, double* %l0
  br label %loop.header2
loop.header2:
  %t56 = phi double [ %t8, %merge1 ], [ %t55, %loop.latch4 ]
  store double %t56, double* %l0
  br label %loop.body3
loop.body3:
  %t9 = load double, double* %l0
  %t10 = sitofp i64 0 to double
  %t11 = fcmp olt double %t9, %t10
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
  %t27 = fptosi double %t26 to i64
  %t28 = getelementptr i8, i8* %value, i64 %t27
  %t29 = load i8, i8* %t28
  %t30 = load double, double* %l1
  %t31 = fptosi double %t30 to i64
  %t32 = getelementptr i8, i8* %target, i64 %t31
  %t33 = load i8, i8* %t32
  %t34 = icmp ne i8 %t29, %t33
  %t35 = load double, double* %l0
  %t36 = load double, double* %l1
  %t37 = load i1, i1* %l2
  br i1 %t34, label %then14, label %merge15
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
  %t54 = fsub double %t52, %t53
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

define i8* @strip_quotes(i8* %value) {
entry:
  %l0 = alloca i8
  %l1 = alloca i8
  %l2 = alloca i1
  %l3 = alloca i1
  %t0 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t1 = icmp sge i64 %t0, 2
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = getelementptr i8, i8* %value, i64 0
  %t3 = load i8, i8* %t2
  store i8 %t3, i8* %l0
  %t4 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t5 = sub i64 %t4, 1
  %t6 = getelementptr i8, i8* %value, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l1
  %t9 = load i8, i8* %l0
  %t10 = icmp eq i8 %t9, 34
  br label %logical_and_entry_8

logical_and_entry_8:
  br i1 %t10, label %logical_and_right_8, label %logical_and_merge_8

logical_and_right_8:
  %t11 = load i8, i8* %l1
  %t12 = icmp eq i8 %t11, 34
  br label %logical_and_right_end_8

logical_and_right_end_8:
  br label %logical_and_merge_8

logical_and_merge_8:
  %t13 = phi i1 [ false, %logical_and_entry_8 ], [ %t12, %logical_and_right_end_8 ]
  store i1 %t13, i1* %l2
  %t15 = load i8, i8* %l0
  %t16 = icmp eq i8 %t15, 39
  br label %logical_and_entry_14

logical_and_entry_14:
  br i1 %t16, label %logical_and_right_14, label %logical_and_merge_14

logical_and_right_14:
  %t17 = load i8, i8* %l1
  %t18 = icmp eq i8 %t17, 39
  br label %logical_and_right_end_14

logical_and_right_end_14:
  br label %logical_and_merge_14

logical_and_merge_14:
  %t19 = phi i1 [ false, %logical_and_entry_14 ], [ %t18, %logical_and_right_end_14 ]
  store i1 %t19, i1* %l3
  %t21 = load i1, i1* %l2
  br label %logical_or_entry_20

logical_or_entry_20:
  br i1 %t21, label %logical_or_merge_20, label %logical_or_right_20

logical_or_right_20:
  %t22 = load i1, i1* %l3
  br label %logical_or_right_end_20

logical_or_right_end_20:
  br label %logical_or_merge_20

logical_or_merge_20:
  %t23 = phi i1 [ true, %logical_or_entry_20 ], [ %t22, %logical_or_right_end_20 ]
  %t24 = load i8, i8* %l0
  %t25 = load i8, i8* %l1
  %t26 = load i1, i1* %l2
  %t27 = load i1, i1* %l3
  br i1 %t23, label %then2, label %merge3
then2:
  %t28 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t29 = sub i64 %t28, 1
  %t30 = call i8* @sailfin_runtime_substring(i8* %value, i64 1, i64 %t29)
  ret i8* %t30
merge3:
  br label %merge1
merge1:
  ret i8* %value
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

define { i8**, i64 }* @split_text(i8* %value, i8* %delimiter) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %delimiter)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %value, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
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
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l2
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = load double, double* %l1
  %t17 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t55 = phi { i8**, i64 }* [ %t15, %merge1 ], [ %t52, %loop.latch4 ]
  %t56 = phi double [ %t16, %merge1 ], [ %t53, %loop.latch4 ]
  %t57 = phi double [ %t17, %merge1 ], [ %t54, %loop.latch4 ]
  store { i8**, i64 }* %t55, { i8**, i64 }** %l0
  store double %t56, double* %l1
  store double %t57, double* %l2
  br label %loop.body3
loop.body3:
  %t18 = load double, double* %l2
  %t19 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t20 = sitofp i64 %t19 to double
  %t21 = fcmp oge double %t18, %t20
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load double, double* %l1
  %t24 = load double, double* %l2
  br i1 %t21, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t25 = load double, double* %l2
  %t26 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t27 = fptosi double %t25 to i64
  %t28 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t27, i64 %t26)
  %t29 = call double @index_of(i8* %t28, i8* %delimiter)
  store double %t29, double* %l3
  %t30 = load double, double* %l3
  %t31 = sitofp i64 0 to double
  %t32 = fcmp olt double %t30, %t31
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = load double, double* %l2
  %t36 = load double, double* %l3
  br i1 %t32, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t37 = load double, double* %l2
  %t38 = load double, double* %l3
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l4
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load double, double* %l1
  %t42 = load double, double* %l4
  %t43 = fptosi double %t41 to i64
  %t44 = fptosi double %t42 to i64
  %t45 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t43, i64 %t44)
  %t46 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t40, i8* %t45)
  store { i8**, i64 }* %t46, { i8**, i64 }** %l0
  %t47 = load double, double* %l4
  %t48 = call i64 @sailfin_runtime_string_length(i8* %delimiter)
  %t49 = sitofp i64 %t48 to double
  %t50 = fadd double %t47, %t49
  store double %t50, double* %l1
  %t51 = load double, double* %l1
  store double %t51, double* %l2
  br label %loop.latch4
loop.latch4:
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load double, double* %l1
  %t54 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load double, double* %l1
  %t60 = load double, double* %l2
  %t61 = load double, double* %l1
  %t62 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t63 = sitofp i64 %t62 to double
  %t64 = fcmp olt double %t61, %t63
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load double, double* %l1
  %t67 = load double, double* %l2
  br i1 %t64, label %then10, label %else11
then10:
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = load double, double* %l1
  %t70 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t71 = fptosi double %t69 to i64
  %t72 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t71, i64 %t70)
  %t73 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t68, i8* %t72)
  store { i8**, i64 }* %t73, { i8**, i64 }** %l0
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge12
else11:
  %t75 = load double, double* %l1
  %t76 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t77 = sitofp i64 %t76 to double
  %t78 = fcmp oeq double %t75, %t77
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t80 = load double, double* %l1
  %t81 = load double, double* %l2
  br i1 %t78, label %then13, label %merge14
then13:
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s83 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t84 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t82, i8* %s83)
  store { i8**, i64 }* %t84, { i8**, i64 }** %l0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge14
merge14:
  %t86 = phi { i8**, i64 }* [ %t85, %then13 ], [ %t79, %else11 ]
  store { i8**, i64 }* %t86, { i8**, i64 }** %l0
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge12
merge12:
  %t88 = phi { i8**, i64 }* [ %t74, %then10 ], [ %t87, %merge14 ]
  store { i8**, i64 }* %t88, { i8**, i64 }** %l0
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t89
}

define { %NativeParameter*, i64 }* @append_parameter_array({ %NativeParameter*, i64 }* %values, %NativeParameter %parameter) {
entry:
  %t0 = call noalias i8* @malloc(i64 40)
  %t1 = bitcast i8* %t0 to %NativeParameter*
  store %NativeParameter %parameter, %NativeParameter* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %NativeParameter*, i64 }* %values to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %NativeParameter*, i64 }*
  ret { %NativeParameter*, i64 }* %t10
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
