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

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

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
@.str.len17.h1842783069 = private unnamed_addr constant [18 x i8] c"StructDeclaration\00"
@.str.len15.h579804543 = private unnamed_addr constant [16 x i8] c"EnumDeclaration\00"
@.str.len26.h177352073 = private unnamed_addr constant [27 x i8] c"; Sailfin Native Prototype\00"
@.str.len12.h76426699 = private unnamed_addr constant [13 x i8] c".module main\00"
@.str.len14.h330693139 = private unnamed_addr constant [15 x i8] c"module.sfn-asm\00"
@.str.len19.h1782433603 = private unnamed_addr constant [20 x i8] c"sailfin-native-text\00"
@.str.len17.h689147423 = private unnamed_addr constant [18 x i8] c"ImportDeclaration\00"
@.str.len9.h1814778076 = private unnamed_addr constant [10 x i8] c".import \22\00"
@.str.len3.h2087758597 = private unnamed_addr constant [4 x i8] c" { \00"
@.str.len2.h193415972 = private unnamed_addr constant [3 x i8] c" }\00"
@.str.len17.h1813262795 = private unnamed_addr constant [18 x i8] c"ExportDeclaration\00"
@.str.len9.h1091414306 = private unnamed_addr constant [10 x i8] c".export \22\00"
@.str.len19.h1204027478 = private unnamed_addr constant [20 x i8] c"VariableDeclaration\00"
@.str.len19.h486335986 = private unnamed_addr constant [20 x i8] c"FunctionDeclaration\00"
@.str.len19.h479148896 = private unnamed_addr constant [20 x i8] c"PipelineDeclaration\00"
@.str.len15.h571715647 = private unnamed_addr constant [16 x i8] c"ToolDeclaration\00"
@.str.len15.h889179835 = private unnamed_addr constant [16 x i8] c"TestDeclaration\00"
@.str.len16.h2043328844 = private unnamed_addr constant [17 x i8] c"ModelDeclaration\00"
@.str.len20.h1496093543 = private unnamed_addr constant [21 x i8] c"TypeAliasDeclaration\00"
@.str.len20.h666604742 = private unnamed_addr constant [21 x i8] c"InterfaceDeclaration\00"
@.str.len15.h1067284810 = private unnamed_addr constant [16 x i8] c"PromptStatement\00"
@.str.len13.h1925822000 = private unnamed_addr constant [14 x i8] c"WithStatement\00"
@.str.len12.h84042670 = private unnamed_addr constant [13 x i8] c"ForStatement\00"
@.str.len14.h196308685 = private unnamed_addr constant [15 x i8] c"MatchStatement\00"
@.str.len13.h1678412334 = private unnamed_addr constant [14 x i8] c"LoopStatement\00"
@.str.len14.h88846349 = private unnamed_addr constant [15 x i8] c"BreakStatement\00"
@.str.len5.h1958778164 = private unnamed_addr constant [6 x i8] c"break\00"
@.str.len17.h1998778048 = private unnamed_addr constant [18 x i8] c"ContinueStatement\00"
@.str.len8.h528348603 = private unnamed_addr constant [9 x i8] c"continue\00"
@.str.len11.h1566780570 = private unnamed_addr constant [12 x i8] c"IfStatement\00"
@.str.len15.h1613933868 = private unnamed_addr constant [16 x i8] c"ReturnStatement\00"
@.str.len19.h868168677 = private unnamed_addr constant [20 x i8] c"ExpressionStatement\00"
@.str.len39.h1281499904 = private unnamed_addr constant [40 x i8] c"native backend: unsupported statement `\00"
@.str.len2.h193425971 = private unnamed_addr constant [3 x i8] c", \00"
@.str.len4.h175713983 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.len6.h1830497006 = private unnamed_addr constant [7 x i8] c".span \00"
@.str.len11.h1513373193 = private unnamed_addr constant [12 x i8] c".init-span \00"
@.str.len3.h2087687812 = private unnamed_addr constant [4 x i8] c" : \00"
@.str.len3.h2087691079 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.len5.h2064124065 = private unnamed_addr constant [6 x i8] c".let \00"
@.str.len4.h267749729 = private unnamed_addr constant [5 x i8] c"mut \00"
@.str.len4.h192491117 = private unnamed_addr constant [5 x i8] c".fn \00"
@.str.len6.h1280331335 = private unnamed_addr constant [7 x i8] c".endfn\00"
@.str.len10.h730819012 = private unnamed_addr constant [11 x i8] c".pipeline \00"
@.str.len12.h1355144398 = private unnamed_addr constant [13 x i8] c".endpipeline\00"
@.str.len6.h1868947418 = private unnamed_addr constant [7 x i8] c".tool \00"
@.str.len8.h580693660 = private unnamed_addr constant [9 x i8] c".endtool\00"
@.str.len6.h1857240668 = private unnamed_addr constant [7 x i8] c".test \00"
@.str.len3.h2087662534 = private unnamed_addr constant [4 x i8] c" ![\00"
@.str.len8.h580338910 = private unnamed_addr constant [9 x i8] c".endtest\00"
@.str.len7.h1082168422 = private unnamed_addr constant [8 x i8] c".model \00"
@.str.len10.h381722796 = private unnamed_addr constant [11 x i8] c".property \00"
@.str.len4.h268717223 = private unnamed_addr constant [5 x i8] c"noop\00"
@.str.len9.h1708674232 = private unnamed_addr constant [10 x i8] c".endmodel\00"
@.str.len6.h1880834942 = private unnamed_addr constant [7 x i8] c".type \00"
@.str.len11.h599952843 = private unnamed_addr constant [12 x i8] c".interface \00"
@.str.len5.h2072555103 = private unnamed_addr constant [6 x i8] c".sig \00"
@.str.len13.h1382830532 = private unnamed_addr constant [14 x i8] c".endinterface\00"
@.str.len6.h1280947313 = private unnamed_addr constant [7 x i8] c".enum \00"
@.str.len9.h1311191977 = private unnamed_addr constant [10 x i8] c".variant \00"
@.str.len8.h562875475 = private unnamed_addr constant [9 x i8] c".endenum\00"
@.str.len8.h2093451461 = private unnamed_addr constant [9 x i8] c".struct \00"
@.str.len12.h2084565287 = private unnamed_addr constant [13 x i8] c" implements \00"
@.str.len7.h398443637 = private unnamed_addr constant [8 x i8] c".field \00"
@.str.len10.h2070880298 = private unnamed_addr constant [11 x i8] c".endstruct\00"
@.str.len8.h1951948513 = private unnamed_addr constant [9 x i8] c".method \00"
@.str.len10.h179409731 = private unnamed_addr constant [11 x i8] c".endmethod\00"
@.str.len8.h377779046 = private unnamed_addr constant [9 x i8] c".prompt \00"
@.str.len10.h261858150 = private unnamed_addr constant [11 x i8] c".endprompt\00"
@.str.len6.h1979413400 = private unnamed_addr constant [7 x i8] c".with \00"
@.str.len8.h584041114 = private unnamed_addr constant [9 x i8] c".endwith\00"
@.str.len5.h2057365731 = private unnamed_addr constant [6 x i8] c".for \00"
@.str.len4.h175996034 = private unnamed_addr constant [5 x i8] c" in \00"
@.str.len7.h1448749422 = private unnamed_addr constant [8 x i8] c".endfor\00"
@.str.len5.h2064480630 = private unnamed_addr constant [6 x i8] c".loop\00"
@.str.len8.h571206424 = private unnamed_addr constant [9 x i8] c".endloop\00"
@.str.len7.h553171426 = private unnamed_addr constant [8 x i8] c".match \00"
@.str.len9.h1692644020 = private unnamed_addr constant [10 x i8] c".endmatch\00"
@.str.len6.h1187178968 = private unnamed_addr constant [7 x i8] c".case \00"
@.str.len4.h174362534 = private unnamed_addr constant [5 x i8] c" => \00"
@.str.len4.h175987322 = private unnamed_addr constant [5 x i8] c" if \00"
@.str.len6.h1061063223 = private unnamed_addr constant [7 x i8] c"return\00"
@.str.len7.h655348872 = private unnamed_addr constant [8 x i8] c"return \00"
@.str.len0.h177573 = private unnamed_addr constant [1 x i8] c"\00"
@.str.len4.h192590216 = private unnamed_addr constant [5 x i8] c".if \00"
@.str.len6.h1280334338 = private unnamed_addr constant [7 x i8] c".endif\00"
@.str.len5.h2056075365 = private unnamed_addr constant [6 x i8] c".else\00"
@.str.len3.h2090684245 = private unnamed_addr constant [4 x i8] c"ret\00"
@.str.len4.h273104342 = private unnamed_addr constant [5 x i8] c"ret \00"
@.str.len5.h2080793783 = private unnamed_addr constant [6 x i8] c"eval \00"
@.str.len11.h1482555192 = private unnamed_addr constant [12 x i8] c".decorator \00"
@.str.len13.h1610966039 = private unnamed_addr constant [14 x i8] c".meta return \00"
@.str.len17.h1970266448 = private unnamed_addr constant [18 x i8] c".meta return void\00"
@.str.len14.h110444378 = private unnamed_addr constant [15 x i8] c".meta effects \00"
@.str.len18.h1250048525 = private unnamed_addr constant [19 x i8] c".meta effects none\00"
@.str.len15.h1897143060 = private unnamed_addr constant [16 x i8] c".meta generics \00"
@.str.len7.h130169768 = private unnamed_addr constant [8 x i8] c".param \00"
@.str.len4.h173787542 = private unnamed_addr constant [5 x i8] c" -> \00"
@.str.len6.h1134498859 = private unnamed_addr constant [7 x i8] c"async \00"
@.str.len2.h193442306 = private unnamed_addr constant [3 x i8] c"; \00"
@.str.len6.h789690461 = private unnamed_addr constant [7 x i8] c"struct\00"
@.str.len20.h239636501 = private unnamed_addr constant [21 x i8] c".layout struct name=\00"
@.str.len6.h922402750 = private unnamed_addr constant [7 x i8] c" size=\00"
@.str.len7.h847788946 = private unnamed_addr constant [8 x i8] c" align=\00"
@.str.len14.h1053492670 = private unnamed_addr constant [15 x i8] c".layout field \00"
@.str.len6.h980153509 = private unnamed_addr constant [7 x i8] c" type=\00"
@.str.len8.h455185518 = private unnamed_addr constant [9 x i8] c" offset=\00"
@.str.len18.h548024877 = private unnamed_addr constant [19 x i8] c".layout enum name=\00"
@.str.len23.h1863896425 = private unnamed_addr constant [24 x i8] c" tag_type=i32 tag_size=\00"
@.str.len11.h1741471221 = private unnamed_addr constant [12 x i8] c" tag_align=\00"
@.str.len16.h1695010494 = private unnamed_addr constant [17 x i8] c".layout variant \00"
@.str.len5.h1525558983 = private unnamed_addr constant [6 x i8] c" tag=\00"
@.str.len16.h1290415774 = private unnamed_addr constant [17 x i8] c".layout payload \00"
@.str.len7.h513898090 = private unnamed_addr constant [8 x i8] c"variant\00"
@.str.len15.h1833630044 = private unnamed_addr constant [16 x i8] c"native layout: \00"
@.str.len2.h193415015 = private unnamed_addr constant [3 x i8] c" `\00"
@.str.len9.h1449250559 = private unnamed_addr constant [10 x i8] c"` field `\00"
@.str.len55.h700951597 = private unnamed_addr constant [56 x i8] c"` missing type annotation; defaulting to pointer layout\00"
@.str.len6.h807326654 = private unnamed_addr constant [7 x i8] c"number\00"
@.str.len3.h2090370613 = private unnamed_addr constant [4 x i8] c"int\00"
@.str.len3.h2090307517 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str.len3.h2090304184 = private unnamed_addr constant [4 x i8] c"i32\00"
@.str.len7.h1483009776 = private unnamed_addr constant [8 x i8] c"boolean\00"
@.str.len4.h254486039 = private unnamed_addr constant [5 x i8] c"bool\00"
@.str.len2.h193492961 = private unnamed_addr constant [3 x i8] c"i1\00"
@.str.len3.h2090083282 = private unnamed_addr constant [4 x i8] c"any\00"
@.str.len6.h789270767 = private unnamed_addr constant [7 x i8] c"string\00"
@.str.len70.h1478160845 = private unnamed_addr constant [71 x i8] c"` optional type missing inner annotation; defaulting to pointer layout\00"
@.str.len25.h9921935 = private unnamed_addr constant [26 x i8] c"` uses unsupported type `\00"
@.str.len31.h2008080495 = private unnamed_addr constant [32 x i8] c"`; defaulting to pointer layout\00"
@.str.len5.h1407544976 = private unnamed_addr constant [6 x i8] c"Token\00"
@.str.len9.h341064397 = private unnamed_addr constant [10 x i8] c"TokenKind\00"
@.str.len7.h576672325 = private unnamed_addr constant [8 x i8] c"Program\00"
@.str.len14.h1988247080 = private unnamed_addr constant [15 x i8] c"TypeAnnotation\00"
@.str.len13.h898775369 = private unnamed_addr constant [14 x i8] c"TypeParameter\00"
@.str.len5.h699691610 = private unnamed_addr constant [6 x i8] c"Block\00"
@.str.len10.h302043987 = private unnamed_addr constant [11 x i8] c"SourceSpan\00"
@.str.len10.h1629914700 = private unnamed_addr constant [11 x i8] c"Expression\00"
@.str.len9.h1724213902 = private unnamed_addr constant [10 x i8] c"Parameter\00"
@.str.len10.h1381756460 = private unnamed_addr constant [11 x i8] c"WithClause\00"
@.str.len11.h259975568 = private unnamed_addr constant [12 x i8] c"ObjectField\00"
@.str.len10.h83011545 = private unnamed_addr constant [11 x i8] c"ElseBranch\00"
@.str.len9.h355918296 = private unnamed_addr constant [10 x i8] c"ForClause\00"
@.str.len9.h1057071035 = private unnamed_addr constant [10 x i8] c"MatchCase\00"
@.str.len13.h2110552132 = private unnamed_addr constant [14 x i8] c"ModelProperty\00"
@.str.len16.h198095254 = private unnamed_addr constant [17 x i8] c"FieldDeclaration\00"
@.str.len17.h152073561 = private unnamed_addr constant [18 x i8] c"MethodDeclaration\00"
@.str.len11.h1508055514 = private unnamed_addr constant [12 x i8] c"EnumVariant\00"
@.str.len17.h2121470532 = private unnamed_addr constant [18 x i8] c"FunctionSignature\00"
@.str.len9.h1902764570 = private unnamed_addr constant [10 x i8] c"Decorator\00"
@.str.len17.h1620510857 = private unnamed_addr constant [18 x i8] c"DecoratorArgument\00"
@.str.len14.h1192169574 = private unnamed_addr constant [15 x i8] c"NamedSpecifier\00"
@.str.len9.h204830940 = private unnamed_addr constant [10 x i8] c"Statement\00"
@.str.len9.h711382918 = private unnamed_addr constant [10 x i8] c"EnumField\00"
@.str.len21.h1969606825 = private unnamed_addr constant [22 x i8] c"EnumVariantDefinition\00"
@.str.len8.h364122910 = private unnamed_addr constant [9 x i8] c"EnumType\00"
@.str.len12.h300877395 = private unnamed_addr constant [13 x i8] c"EnumInstance\00"
@.str.len11.h575661041 = private unnamed_addr constant [12 x i8] c"StructField\00"
@.str.len14.h237087299 = private unnamed_addr constant [15 x i8] c"TypeDescriptor\00"
@.str.len2.h193479167 = private unnamed_addr constant [3 x i8] c"[]\00"
@.str.len10.h626550212 = private unnamed_addr constant [11 x i8] c"0123456789\00"
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
@.str.len10.h1576352120 = private unnamed_addr constant [11 x i8] c"Identifier\00"
@.str.len13.h1570408460 = private unnamed_addr constant [14 x i8] c"NumberLiteral\00"
@.str.len14.h1318614710 = private unnamed_addr constant [15 x i8] c"BooleanLiteral\00"
@.str.len11.h1571993816 = private unnamed_addr constant [12 x i8] c"NullLiteral\00"
@.str.len4.h268929446 = private unnamed_addr constant [5 x i8] c"null\00"
@.str.len13.h590768815 = private unnamed_addr constant [14 x i8] c"StringLiteral\00"
@.str.len5.h1445149598 = private unnamed_addr constant [6 x i8] c"Unary\00"
@.str.len6.h1496334143 = private unnamed_addr constant [7 x i8] c"Binary\00"
@.str.len6.h512390329 = private unnamed_addr constant [7 x i8] c"Member\00"
@.str.len4.h217216103 = private unnamed_addr constant [5 x i8] c"Call\00"
@.str.len5.h975618503 = private unnamed_addr constant [6 x i8] c"Index\00"
@.str.len5.h667777838 = private unnamed_addr constant [6 x i8] c"Array\00"
@.str.len6.h826984377 = private unnamed_addr constant [7 x i8] c"Object\00"
@.str.len2.h193441217 = private unnamed_addr constant [3 x i8] c": \00"
@.str.len2.h193512002 = private unnamed_addr constant [3 x i8] c"{ \00"
@.str.len6.h264904746 = private unnamed_addr constant [7 x i8] c"Struct\00"
@.str.len5.h1312780988 = private unnamed_addr constant [6 x i8] c"Range\00"
@.str.len2.h193428611 = private unnamed_addr constant [3 x i8] c"..\00"
@.str.len6.h1211862785 = private unnamed_addr constant [7 x i8] c"Lambda\00"
@.str.len8.h573909064 = private unnamed_addr constant [9 x i8] c"<lambda>\00"
@.str.len3.h2089530004 = private unnamed_addr constant [4 x i8] c"Raw\00"
@.str.len10.h1720834339 = private unnamed_addr constant [11 x i8] c"[#element:\00"
@.str.len2.h193478309 = private unnamed_addr constant [3 x i8] c"\5C\22\00"
@.str.len2.h193480223 = private unnamed_addr constant [3 x i8] c"\5C\5C\00"
@.str.len2.h193480817 = private unnamed_addr constant [3 x i8] c"\5Cn\00"
@.str.len2.h193480949 = private unnamed_addr constant [3 x i8] c"\5Cr\00"
@.str.len2.h193481015 = private unnamed_addr constant [3 x i8] c"\5Ct\00"
@.str.len5.h500836810 = private unnamed_addr constant [6 x i8] c"test:\00"
@.str.len25.h403645876 = private unnamed_addr constant [26 x i8] c"; Sailfin Layout Manifest\00"
@.str.len19.h2048588885 = private unnamed_addr constant [20 x i8] c".manifest version=1\00"
@.str.len22.h401021290 = private unnamed_addr constant [23 x i8] c"module.layout-manifest\00"
@.str.len23.h668778749 = private unnamed_addr constant [24 x i8] c"sailfin-layout-manifest\00"
@.str.len4.h173287691 = private unnamed_addr constant [5 x i8] c"    \00"

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
  %t386 = phi { %LayoutStructDefinition*, i64 }* [ %t11, %entry ], [ %t383, %loop.latch2 ]
  %t387 = phi { %LayoutEnumDefinition*, i64 }* [ %t12, %entry ], [ %t384, %loop.latch2 ]
  %t388 = phi double [ %t13, %entry ], [ %t385, %loop.latch2 ]
  store { %LayoutStructDefinition*, i64 }* %t386, { %LayoutStructDefinition*, i64 }** %l0
  store { %LayoutEnumDefinition*, i64 }* %t387, { %LayoutEnumDefinition*, i64 }** %l1
  store double %t388, double* %l2
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
  call void @sailfin_runtime_bounds_check(i64 %t25, i64 %t28)
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
  %s105 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1842783069, i32 0, i32 0
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
  %t174 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  br label %merge7
merge7:
  %t175 = phi { %LayoutStructDefinition*, i64 }* [ %t174, %then6 ], [ %t107, %merge5 ]
  store { %LayoutStructDefinition*, i64 }* %t175, { %LayoutStructDefinition*, i64 }** %l0
  %t176 = load %Statement*, %Statement** %l3
  %t177 = getelementptr inbounds %Statement, %Statement* %t176, i32 0, i32 0
  %t178 = load i32, i32* %t177
  %t179 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t180 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t181 = icmp eq i32 %t178, 0
  %t182 = select i1 %t181, i8* %t180, i8* %t179
  %t183 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t184 = icmp eq i32 %t178, 1
  %t185 = select i1 %t184, i8* %t183, i8* %t182
  %t186 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t187 = icmp eq i32 %t178, 2
  %t188 = select i1 %t187, i8* %t186, i8* %t185
  %t189 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t190 = icmp eq i32 %t178, 3
  %t191 = select i1 %t190, i8* %t189, i8* %t188
  %t192 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t193 = icmp eq i32 %t178, 4
  %t194 = select i1 %t193, i8* %t192, i8* %t191
  %t195 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t196 = icmp eq i32 %t178, 5
  %t197 = select i1 %t196, i8* %t195, i8* %t194
  %t198 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t199 = icmp eq i32 %t178, 6
  %t200 = select i1 %t199, i8* %t198, i8* %t197
  %t201 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t202 = icmp eq i32 %t178, 7
  %t203 = select i1 %t202, i8* %t201, i8* %t200
  %t204 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t205 = icmp eq i32 %t178, 8
  %t206 = select i1 %t205, i8* %t204, i8* %t203
  %t207 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t208 = icmp eq i32 %t178, 9
  %t209 = select i1 %t208, i8* %t207, i8* %t206
  %t210 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t211 = icmp eq i32 %t178, 10
  %t212 = select i1 %t211, i8* %t210, i8* %t209
  %t213 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t214 = icmp eq i32 %t178, 11
  %t215 = select i1 %t214, i8* %t213, i8* %t212
  %t216 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t217 = icmp eq i32 %t178, 12
  %t218 = select i1 %t217, i8* %t216, i8* %t215
  %t219 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t220 = icmp eq i32 %t178, 13
  %t221 = select i1 %t220, i8* %t219, i8* %t218
  %t222 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t223 = icmp eq i32 %t178, 14
  %t224 = select i1 %t223, i8* %t222, i8* %t221
  %t225 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t226 = icmp eq i32 %t178, 15
  %t227 = select i1 %t226, i8* %t225, i8* %t224
  %t228 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t229 = icmp eq i32 %t178, 16
  %t230 = select i1 %t229, i8* %t228, i8* %t227
  %t231 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t232 = icmp eq i32 %t178, 17
  %t233 = select i1 %t232, i8* %t231, i8* %t230
  %t234 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t235 = icmp eq i32 %t178, 18
  %t236 = select i1 %t235, i8* %t234, i8* %t233
  %t237 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t238 = icmp eq i32 %t178, 19
  %t239 = select i1 %t238, i8* %t237, i8* %t236
  %t240 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t241 = icmp eq i32 %t178, 20
  %t242 = select i1 %t241, i8* %t240, i8* %t239
  %t243 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t244 = icmp eq i32 %t178, 21
  %t245 = select i1 %t244, i8* %t243, i8* %t242
  %t246 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t247 = icmp eq i32 %t178, 22
  %t248 = select i1 %t247, i8* %t246, i8* %t245
  %s249 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h579804543, i32 0, i32 0
  %t250 = icmp eq i8* %t248, %s249
  %t251 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t252 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t253 = load double, double* %l2
  %t254 = load %Statement*, %Statement** %l3
  br i1 %t250, label %then8, label %merge9
then8:
  %t255 = alloca [0 x %LayoutEnumVariantDefinition]
  %t256 = getelementptr [0 x %LayoutEnumVariantDefinition], [0 x %LayoutEnumVariantDefinition]* %t255, i32 0, i32 0
  %t257 = alloca { %LayoutEnumVariantDefinition*, i64 }
  %t258 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %t257, i32 0, i32 0
  store %LayoutEnumVariantDefinition* %t256, %LayoutEnumVariantDefinition** %t258
  %t259 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %t257, i32 0, i32 1
  store i64 0, i64* %t259
  store { %LayoutEnumVariantDefinition*, i64 }* %t257, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t260 = sitofp i64 0 to double
  store double %t260, double* %l6
  %t261 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t262 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t263 = load double, double* %l2
  %t264 = load %Statement*, %Statement** %l3
  %t265 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t266 = load double, double* %l6
  br label %loop.header10
loop.header10:
  %t323 = phi { %LayoutEnumVariantDefinition*, i64 }* [ %t265, %then8 ], [ %t321, %loop.latch12 ]
  %t324 = phi double [ %t266, %then8 ], [ %t322, %loop.latch12 ]
  store { %LayoutEnumVariantDefinition*, i64 }* %t323, { %LayoutEnumVariantDefinition*, i64 }** %l5
  store double %t324, double* %l6
  br label %loop.body11
loop.body11:
  %t267 = load double, double* %l6
  %t268 = load %Statement*, %Statement** %l3
  %t269 = getelementptr inbounds %Statement, %Statement* %t268, i32 0, i32 0
  %t270 = load i32, i32* %t269
  %t271 = getelementptr inbounds %Statement, %Statement* %t268, i32 0, i32 1
  %t272 = bitcast [40 x i8]* %t271 to i8*
  %t273 = getelementptr inbounds i8, i8* %t272, i64 24
  %t274 = bitcast i8* %t273 to { %EnumVariant**, i64 }**
  %t275 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t274
  %t276 = icmp eq i32 %t270, 11
  %t277 = select i1 %t276, { %EnumVariant**, i64 }* %t275, { %EnumVariant**, i64 }* null
  %t278 = load { %EnumVariant**, i64 }, { %EnumVariant**, i64 }* %t277
  %t279 = extractvalue { %EnumVariant**, i64 } %t278, 1
  %t280 = sitofp i64 %t279 to double
  %t281 = fcmp oge double %t267, %t280
  %t282 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t283 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t284 = load double, double* %l2
  %t285 = load %Statement*, %Statement** %l3
  %t286 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t287 = load double, double* %l6
  br i1 %t281, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t288 = load %Statement*, %Statement** %l3
  %t289 = getelementptr inbounds %Statement, %Statement* %t288, i32 0, i32 0
  %t290 = load i32, i32* %t289
  %t291 = getelementptr inbounds %Statement, %Statement* %t288, i32 0, i32 1
  %t292 = bitcast [40 x i8]* %t291 to i8*
  %t293 = getelementptr inbounds i8, i8* %t292, i64 24
  %t294 = bitcast i8* %t293 to { %EnumVariant**, i64 }**
  %t295 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t294
  %t296 = icmp eq i32 %t290, 11
  %t297 = select i1 %t296, { %EnumVariant**, i64 }* %t295, { %EnumVariant**, i64 }* null
  %t298 = load double, double* %l6
  %t299 = fptosi double %t298 to i64
  %t300 = load { %EnumVariant**, i64 }, { %EnumVariant**, i64 }* %t297
  %t301 = extractvalue { %EnumVariant**, i64 } %t300, 0
  %t302 = extractvalue { %EnumVariant**, i64 } %t300, 1
  %t303 = icmp uge i64 %t299, %t302
  ; bounds check: %t303 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t299, i64 %t302)
  %t304 = getelementptr %EnumVariant*, %EnumVariant** %t301, i64 %t299
  %t305 = load %EnumVariant*, %EnumVariant** %t304
  store %EnumVariant* %t305, %EnumVariant** %l7
  %t306 = load %EnumVariant*, %EnumVariant** %l7
  %t307 = load %EnumVariant, %EnumVariant* %t306
  %t308 = call { %LayoutFieldInput*, i64 }* @convert_variant_fields(%EnumVariant %t307)
  store { %LayoutFieldInput*, i64 }* %t308, { %LayoutFieldInput*, i64 }** %l8
  %t309 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t310 = load %EnumVariant*, %EnumVariant** %l7
  %t311 = getelementptr %EnumVariant, %EnumVariant* %t310, i32 0, i32 0
  %t312 = load i8*, i8** %t311
  %t313 = insertvalue %LayoutEnumVariantDefinition undef, i8* %t312, 0
  %t314 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l8
  %t315 = bitcast { %LayoutFieldInput*, i64 }* %t314 to { %LayoutFieldInput**, i64 }*
  %t316 = insertvalue %LayoutEnumVariantDefinition %t313, { %LayoutFieldInput**, i64 }* %t315, 1
  %t317 = call { %LayoutEnumVariantDefinition*, i64 }* @append_layout_enum_variant_definition({ %LayoutEnumVariantDefinition*, i64 }* %t309, %LayoutEnumVariantDefinition %t316)
  store { %LayoutEnumVariantDefinition*, i64 }* %t317, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t318 = load double, double* %l6
  %t319 = sitofp i64 1 to double
  %t320 = fadd double %t318, %t319
  store double %t320, double* %l6
  br label %loop.latch12
loop.latch12:
  %t321 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t322 = load double, double* %l6
  br label %loop.header10
afterloop13:
  %t325 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t326 = load double, double* %l6
  %t327 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t328 = load %Statement*, %Statement** %l3
  %t329 = getelementptr inbounds %Statement, %Statement* %t328, i32 0, i32 0
  %t330 = load i32, i32* %t329
  %t331 = getelementptr inbounds %Statement, %Statement* %t328, i32 0, i32 1
  %t332 = bitcast [48 x i8]* %t331 to i8*
  %t333 = bitcast i8* %t332 to i8**
  %t334 = load i8*, i8** %t333
  %t335 = icmp eq i32 %t330, 2
  %t336 = select i1 %t335, i8* %t334, i8* null
  %t337 = getelementptr inbounds %Statement, %Statement* %t328, i32 0, i32 1
  %t338 = bitcast [48 x i8]* %t337 to i8*
  %t339 = bitcast i8* %t338 to i8**
  %t340 = load i8*, i8** %t339
  %t341 = icmp eq i32 %t330, 3
  %t342 = select i1 %t341, i8* %t340, i8* %t336
  %t343 = getelementptr inbounds %Statement, %Statement* %t328, i32 0, i32 1
  %t344 = bitcast [40 x i8]* %t343 to i8*
  %t345 = bitcast i8* %t344 to i8**
  %t346 = load i8*, i8** %t345
  %t347 = icmp eq i32 %t330, 6
  %t348 = select i1 %t347, i8* %t346, i8* %t342
  %t349 = getelementptr inbounds %Statement, %Statement* %t328, i32 0, i32 1
  %t350 = bitcast [56 x i8]* %t349 to i8*
  %t351 = bitcast i8* %t350 to i8**
  %t352 = load i8*, i8** %t351
  %t353 = icmp eq i32 %t330, 8
  %t354 = select i1 %t353, i8* %t352, i8* %t348
  %t355 = getelementptr inbounds %Statement, %Statement* %t328, i32 0, i32 1
  %t356 = bitcast [40 x i8]* %t355 to i8*
  %t357 = bitcast i8* %t356 to i8**
  %t358 = load i8*, i8** %t357
  %t359 = icmp eq i32 %t330, 9
  %t360 = select i1 %t359, i8* %t358, i8* %t354
  %t361 = getelementptr inbounds %Statement, %Statement* %t328, i32 0, i32 1
  %t362 = bitcast [40 x i8]* %t361 to i8*
  %t363 = bitcast i8* %t362 to i8**
  %t364 = load i8*, i8** %t363
  %t365 = icmp eq i32 %t330, 10
  %t366 = select i1 %t365, i8* %t364, i8* %t360
  %t367 = getelementptr inbounds %Statement, %Statement* %t328, i32 0, i32 1
  %t368 = bitcast [40 x i8]* %t367 to i8*
  %t369 = bitcast i8* %t368 to i8**
  %t370 = load i8*, i8** %t369
  %t371 = icmp eq i32 %t330, 11
  %t372 = select i1 %t371, i8* %t370, i8* %t366
  %t373 = insertvalue %LayoutEnumDefinition undef, i8* %t372, 0
  %t374 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t375 = bitcast { %LayoutEnumVariantDefinition*, i64 }* %t374 to { %LayoutEnumVariantDefinition**, i64 }*
  %t376 = insertvalue %LayoutEnumDefinition %t373, { %LayoutEnumVariantDefinition**, i64 }* %t375, 1
  %t377 = call { %LayoutEnumDefinition*, i64 }* @append_layout_enum_definition({ %LayoutEnumDefinition*, i64 }* %t327, %LayoutEnumDefinition %t376)
  store { %LayoutEnumDefinition*, i64 }* %t377, { %LayoutEnumDefinition*, i64 }** %l1
  %t378 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  br label %merge9
merge9:
  %t379 = phi { %LayoutEnumDefinition*, i64 }* [ %t378, %afterloop13 ], [ %t252, %merge7 ]
  store { %LayoutEnumDefinition*, i64 }* %t379, { %LayoutEnumDefinition*, i64 }** %l1
  %t380 = load double, double* %l2
  %t381 = sitofp i64 1 to double
  %t382 = fadd double %t380, %t381
  store double %t382, double* %l2
  br label %loop.latch2
loop.latch2:
  %t383 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t384 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t385 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t389 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t390 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t391 = load double, double* %l2
  %t392 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t393 = bitcast { %LayoutStructDefinition*, i64 }* %t392 to { %LayoutStructDefinition**, i64 }*
  %t394 = insertvalue %LayoutContext undef, { %LayoutStructDefinition**, i64 }* %t393, 0
  %t395 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t396 = bitcast { %LayoutEnumDefinition*, i64 }* %t395 to { %LayoutEnumDefinition**, i64 }*
  %t397 = insertvalue %LayoutContext %t394, { %LayoutEnumDefinition**, i64 }* %t396, 1
  ret %LayoutContext %t397
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
  %s4 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h177352073, i32 0, i32 0
  %t5 = call %NativeState @state_emit_line(%NativeState %t3, i8* %s4)
  store %NativeState %t5, %NativeState* %l1
  %t6 = load %NativeState, %NativeState* %l1
  %s7 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h76426699, i32 0, i32 0
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
  %t17 = load %NativeState, %NativeState* %l1
  br label %merge1
merge1:
  %t18 = phi %NativeState [ %t17, %then0 ], [ %t14, %entry ]
  store %NativeState %t18, %NativeState* %l1
  %t19 = sitofp i64 0 to double
  store double %t19, double* %l2
  %t20 = load %LayoutContext, %LayoutContext* %l0
  %t21 = load %NativeState, %NativeState* %l1
  %t22 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t64 = phi %NativeState [ %t21, %merge1 ], [ %t62, %loop.latch4 ]
  %t65 = phi double [ %t22, %merge1 ], [ %t63, %loop.latch4 ]
  store %NativeState %t64, %NativeState* %l1
  store double %t65, double* %l2
  br label %loop.body3
loop.body3:
  %t23 = load double, double* %l2
  %t24 = extractvalue %Program %program, 0
  %t25 = load { %Statement**, i64 }, { %Statement**, i64 }* %t24
  %t26 = extractvalue { %Statement**, i64 } %t25, 1
  %t27 = sitofp i64 %t26 to double
  %t28 = fcmp oge double %t23, %t27
  %t29 = load %LayoutContext, %LayoutContext* %l0
  %t30 = load %NativeState, %NativeState* %l1
  %t31 = load double, double* %l2
  br i1 %t28, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t32 = load %NativeState, %NativeState* %l1
  %t33 = extractvalue %Program %program, 0
  %t34 = load double, double* %l2
  %t35 = fptosi double %t34 to i64
  %t36 = load { %Statement**, i64 }, { %Statement**, i64 }* %t33
  %t37 = extractvalue { %Statement**, i64 } %t36, 0
  %t38 = extractvalue { %Statement**, i64 } %t36, 1
  %t39 = icmp uge i64 %t35, %t38
  ; bounds check: %t39 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t35, i64 %t38)
  %t40 = getelementptr %Statement*, %Statement** %t37, i64 %t35
  %t41 = load %Statement*, %Statement** %t40
  %t42 = load %Statement, %Statement* %t41
  %t43 = call %NativeState @emit_statement(%NativeState %t32, %Statement %t42)
  store %NativeState %t43, %NativeState* %l1
  %t44 = load double, double* %l2
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  %t47 = extractvalue %Program %program, 0
  %t48 = load { %Statement**, i64 }, { %Statement**, i64 }* %t47
  %t49 = extractvalue { %Statement**, i64 } %t48, 1
  %t50 = sitofp i64 %t49 to double
  %t51 = fcmp olt double %t46, %t50
  %t52 = load %LayoutContext, %LayoutContext* %l0
  %t53 = load %NativeState, %NativeState* %l1
  %t54 = load double, double* %l2
  br i1 %t51, label %then8, label %merge9
then8:
  %t55 = load %NativeState, %NativeState* %l1
  %t56 = call %NativeState @state_emit_blank(%NativeState %t55)
  store %NativeState %t56, %NativeState* %l1
  %t57 = load %NativeState, %NativeState* %l1
  br label %merge9
merge9:
  %t58 = phi %NativeState [ %t57, %then8 ], [ %t53, %merge7 ]
  store %NativeState %t58, %NativeState* %l1
  %t59 = load double, double* %l2
  %t60 = sitofp i64 1 to double
  %t61 = fadd double %t59, %t60
  store double %t61, double* %l2
  br label %loop.latch4
loop.latch4:
  %t62 = load %NativeState, %NativeState* %l1
  %t63 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t66 = load %NativeState, %NativeState* %l1
  %t67 = load double, double* %l2
  %s68 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h330693139, i32 0, i32 0
  %t69 = insertvalue %NativeArtifact undef, i8* %s68, 0
  %s70 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1782433603, i32 0, i32 0
  %t71 = insertvalue %NativeArtifact %t69, i8* %s70, 1
  %t72 = load %NativeState, %NativeState* %l1
  %t73 = extractvalue %NativeState %t72, 0
  %t74 = call i8* @builder_to_string(%TextBuilder %t73)
  %t75 = insertvalue %NativeArtifact %t71, i8* %t74, 2
  store %NativeArtifact %t75, %NativeArtifact* %l3
  %t76 = load %LayoutContext, %LayoutContext* %l0
  %t77 = call %NativeArtifact @generate_layout_manifest(%Program %program, %LayoutContext %t76)
  store %NativeArtifact %t77, %NativeArtifact* %l4
  %t78 = load %NativeArtifact, %NativeArtifact* %l3
  %t79 = load %NativeArtifact, %NativeArtifact* %l4
  %t80 = call noalias i8* @malloc(i64 24)
  %t81 = bitcast i8* %t80 to %NativeArtifact*
  store %NativeArtifact %t78, %NativeArtifact* %t81
  %t82 = bitcast i8* %t80 to %NativeArtifact*
  %t83 = call noalias i8* @malloc(i64 24)
  %t84 = bitcast i8* %t83 to %NativeArtifact*
  store %NativeArtifact %t79, %NativeArtifact* %t84
  %t85 = bitcast i8* %t83 to %NativeArtifact*
  %t86 = alloca [2 x %NativeArtifact*]
  %t87 = getelementptr [2 x %NativeArtifact*], [2 x %NativeArtifact*]* %t86, i32 0, i32 0
  %t88 = getelementptr %NativeArtifact*, %NativeArtifact** %t87, i64 0
  store %NativeArtifact* %t82, %NativeArtifact** %t88
  %t89 = getelementptr %NativeArtifact*, %NativeArtifact** %t87, i64 1
  store %NativeArtifact* %t85, %NativeArtifact** %t89
  %t90 = alloca { %NativeArtifact**, i64 }
  %t91 = getelementptr { %NativeArtifact**, i64 }, { %NativeArtifact**, i64 }* %t90, i32 0, i32 0
  store %NativeArtifact** %t87, %NativeArtifact*** %t91
  %t92 = getelementptr { %NativeArtifact**, i64 }, { %NativeArtifact**, i64 }* %t90, i32 0, i32 1
  store i64 2, i64* %t92
  %t93 = insertvalue %NativeModule undef, { %NativeArtifact**, i64 }* %t90, 0
  %t94 = call { i8**, i64 }* @collect_entry_points(%Program %program)
  %t95 = insertvalue %NativeModule %t93, { i8**, i64 }* %t94, 1
  %t96 = call double @count_exported_symbols(%Program %program)
  %t97 = insertvalue %NativeModule %t95, double %t96, 2
  store %NativeModule %t97, %NativeModule* %l5
  %t98 = load %NativeModule, %NativeModule* %l5
  %t99 = insertvalue %EmitNativeResult undef, %NativeModule %t98, 0
  %t100 = load %NativeState, %NativeState* %l1
  %t101 = extractvalue %NativeState %t100, 1
  %t102 = insertvalue %EmitNativeResult %t99, { i8**, i64 }* %t101, 1
  ret %EmitNativeResult %t102
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
  %s71 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h689147423, i32 0, i32 0
  %t72 = icmp eq i8* %t70, %s71
  br i1 %t72, label %then0, label %merge1
then0:
  %s73 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1814778076, i32 0, i32 0
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
  %t90 = call i8* @sailfin_runtime_string_concat(i8* %s73, i8* %t89)
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
  %t98 = alloca %Statement
  store %Statement %statement, %Statement* %t98
  %t99 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t100 = bitcast [16 x i8]* %t99 to i8*
  %t101 = bitcast i8* %t100 to { %ImportSpecifier**, i64 }**
  %t102 = load { %ImportSpecifier**, i64 }*, { %ImportSpecifier**, i64 }** %t101
  %t103 = icmp eq i32 %t97, 0
  %t104 = select i1 %t103, { %ImportSpecifier**, i64 }* %t102, { %ImportSpecifier**, i64 }* null
  %t105 = bitcast { %ImportSpecifier**, i64 }* %t104 to { %ImportSpecifier*, i64 }*
  %t106 = call i8* @render_native_specifiers({ %ImportSpecifier*, i64 }* %t105)
  store i8* %t106, i8** %l1
  %t107 = load i8*, i8** %l1
  %t108 = call i64 @sailfin_runtime_string_length(i8* %t107)
  %t109 = icmp sgt i64 %t108, 0
  %t110 = load i8*, i8** %l0
  %t111 = load i8*, i8** %l1
  br i1 %t109, label %then2, label %merge3
then2:
  %t112 = load i8*, i8** %l0
  %s113 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087758597, i32 0, i32 0
  %t114 = call i8* @sailfin_runtime_string_concat(i8* %t112, i8* %s113)
  %t115 = load i8*, i8** %l1
  %t116 = call i8* @sailfin_runtime_string_concat(i8* %t114, i8* %t115)
  %s117 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415972, i32 0, i32 0
  %t118 = call i8* @sailfin_runtime_string_concat(i8* %t116, i8* %s117)
  store i8* %t118, i8** %l0
  %t119 = load i8*, i8** %l0
  br label %merge3
merge3:
  %t120 = phi i8* [ %t119, %then2 ], [ %t110, %then0 ]
  store i8* %t120, i8** %l0
  %t121 = load i8*, i8** %l0
  %t122 = call %NativeState @state_emit_line(%NativeState %state, i8* %t121)
  ret %NativeState %t122
merge1:
  %t123 = extractvalue %Statement %statement, 0
  %t124 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t125 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t126 = icmp eq i32 %t123, 0
  %t127 = select i1 %t126, i8* %t125, i8* %t124
  %t128 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t129 = icmp eq i32 %t123, 1
  %t130 = select i1 %t129, i8* %t128, i8* %t127
  %t131 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t132 = icmp eq i32 %t123, 2
  %t133 = select i1 %t132, i8* %t131, i8* %t130
  %t134 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t123, 3
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t123, 4
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t123, 5
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t123, 6
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t123, 7
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t123, 8
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t123, 9
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t123, 10
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t123, 11
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t123, 12
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t123, 13
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t123, 14
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t123, 15
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t123, 16
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %t176 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t177 = icmp eq i32 %t123, 17
  %t178 = select i1 %t177, i8* %t176, i8* %t175
  %t179 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t123, 18
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t123, 19
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t123, 20
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %t188 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t123, 21
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %t191 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t192 = icmp eq i32 %t123, 22
  %t193 = select i1 %t192, i8* %t191, i8* %t190
  %s194 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1813262795, i32 0, i32 0
  %t195 = icmp eq i8* %t193, %s194
  br i1 %t195, label %then4, label %merge5
then4:
  %s196 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1091414306, i32 0, i32 0
  %t197 = extractvalue %Statement %statement, 0
  %t198 = alloca %Statement
  store %Statement %statement, %Statement* %t198
  %t199 = getelementptr inbounds %Statement, %Statement* %t198, i32 0, i32 1
  %t200 = bitcast [16 x i8]* %t199 to i8*
  %t201 = getelementptr inbounds i8, i8* %t200, i64 8
  %t202 = bitcast i8* %t201 to i8**
  %t203 = load i8*, i8** %t202
  %t204 = icmp eq i32 %t197, 0
  %t205 = select i1 %t204, i8* %t203, i8* null
  %t206 = getelementptr inbounds %Statement, %Statement* %t198, i32 0, i32 1
  %t207 = bitcast [16 x i8]* %t206 to i8*
  %t208 = getelementptr inbounds i8, i8* %t207, i64 8
  %t209 = bitcast i8* %t208 to i8**
  %t210 = load i8*, i8** %t209
  %t211 = icmp eq i32 %t197, 1
  %t212 = select i1 %t211, i8* %t210, i8* %t205
  %t213 = call i8* @sailfin_runtime_string_concat(i8* %s196, i8* %t212)
  %t214 = load i8, i8* %t213
  %t215 = add i8 %t214, 34
  %t216 = alloca [2 x i8], align 1
  %t217 = getelementptr [2 x i8], [2 x i8]* %t216, i32 0, i32 0
  store i8 %t215, i8* %t217
  %t218 = getelementptr [2 x i8], [2 x i8]* %t216, i32 0, i32 1
  store i8 0, i8* %t218
  %t219 = getelementptr [2 x i8], [2 x i8]* %t216, i32 0, i32 0
  store i8* %t219, i8** %l2
  %t220 = extractvalue %Statement %statement, 0
  %t221 = alloca %Statement
  store %Statement %statement, %Statement* %t221
  %t222 = getelementptr inbounds %Statement, %Statement* %t221, i32 0, i32 1
  %t223 = bitcast [16 x i8]* %t222 to i8*
  %t224 = bitcast i8* %t223 to { %ExportSpecifier**, i64 }**
  %t225 = load { %ExportSpecifier**, i64 }*, { %ExportSpecifier**, i64 }** %t224
  %t226 = icmp eq i32 %t220, 1
  %t227 = select i1 %t226, { %ExportSpecifier**, i64 }* %t225, { %ExportSpecifier**, i64 }* null
  %t228 = bitcast { %ExportSpecifier**, i64 }* %t227 to { %ExportSpecifier*, i64 }*
  %t229 = call i8* @render_export_specifiers({ %ExportSpecifier*, i64 }* %t228)
  store i8* %t229, i8** %l3
  %t230 = load i8*, i8** %l3
  %t231 = call i64 @sailfin_runtime_string_length(i8* %t230)
  %t232 = icmp sgt i64 %t231, 0
  %t233 = load i8*, i8** %l2
  %t234 = load i8*, i8** %l3
  br i1 %t232, label %then6, label %merge7
then6:
  %t235 = load i8*, i8** %l2
  %s236 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087758597, i32 0, i32 0
  %t237 = call i8* @sailfin_runtime_string_concat(i8* %t235, i8* %s236)
  %t238 = load i8*, i8** %l3
  %t239 = call i8* @sailfin_runtime_string_concat(i8* %t237, i8* %t238)
  %s240 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415972, i32 0, i32 0
  %t241 = call i8* @sailfin_runtime_string_concat(i8* %t239, i8* %s240)
  store i8* %t241, i8** %l2
  %t242 = load i8*, i8** %l2
  br label %merge7
merge7:
  %t243 = phi i8* [ %t242, %then6 ], [ %t233, %then4 ]
  store i8* %t243, i8** %l2
  %t244 = load i8*, i8** %l2
  %t245 = call %NativeState @state_emit_line(%NativeState %state, i8* %t244)
  ret %NativeState %t245
merge5:
  %t246 = extractvalue %Statement %statement, 0
  %t247 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t248 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t249 = icmp eq i32 %t246, 0
  %t250 = select i1 %t249, i8* %t248, i8* %t247
  %t251 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t252 = icmp eq i32 %t246, 1
  %t253 = select i1 %t252, i8* %t251, i8* %t250
  %t254 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t255 = icmp eq i32 %t246, 2
  %t256 = select i1 %t255, i8* %t254, i8* %t253
  %t257 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t258 = icmp eq i32 %t246, 3
  %t259 = select i1 %t258, i8* %t257, i8* %t256
  %t260 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t261 = icmp eq i32 %t246, 4
  %t262 = select i1 %t261, i8* %t260, i8* %t259
  %t263 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t264 = icmp eq i32 %t246, 5
  %t265 = select i1 %t264, i8* %t263, i8* %t262
  %t266 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t267 = icmp eq i32 %t246, 6
  %t268 = select i1 %t267, i8* %t266, i8* %t265
  %t269 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t270 = icmp eq i32 %t246, 7
  %t271 = select i1 %t270, i8* %t269, i8* %t268
  %t272 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t273 = icmp eq i32 %t246, 8
  %t274 = select i1 %t273, i8* %t272, i8* %t271
  %t275 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t276 = icmp eq i32 %t246, 9
  %t277 = select i1 %t276, i8* %t275, i8* %t274
  %t278 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t279 = icmp eq i32 %t246, 10
  %t280 = select i1 %t279, i8* %t278, i8* %t277
  %t281 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t282 = icmp eq i32 %t246, 11
  %t283 = select i1 %t282, i8* %t281, i8* %t280
  %t284 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t285 = icmp eq i32 %t246, 12
  %t286 = select i1 %t285, i8* %t284, i8* %t283
  %t287 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t288 = icmp eq i32 %t246, 13
  %t289 = select i1 %t288, i8* %t287, i8* %t286
  %t290 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t291 = icmp eq i32 %t246, 14
  %t292 = select i1 %t291, i8* %t290, i8* %t289
  %t293 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t294 = icmp eq i32 %t246, 15
  %t295 = select i1 %t294, i8* %t293, i8* %t292
  %t296 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t297 = icmp eq i32 %t246, 16
  %t298 = select i1 %t297, i8* %t296, i8* %t295
  %t299 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t300 = icmp eq i32 %t246, 17
  %t301 = select i1 %t300, i8* %t299, i8* %t298
  %t302 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t303 = icmp eq i32 %t246, 18
  %t304 = select i1 %t303, i8* %t302, i8* %t301
  %t305 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t306 = icmp eq i32 %t246, 19
  %t307 = select i1 %t306, i8* %t305, i8* %t304
  %t308 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t309 = icmp eq i32 %t246, 20
  %t310 = select i1 %t309, i8* %t308, i8* %t307
  %t311 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t312 = icmp eq i32 %t246, 21
  %t313 = select i1 %t312, i8* %t311, i8* %t310
  %t314 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t315 = icmp eq i32 %t246, 22
  %t316 = select i1 %t315, i8* %t314, i8* %t313
  %s317 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1204027478, i32 0, i32 0
  %t318 = icmp eq i8* %t316, %s317
  br i1 %t318, label %then8, label %merge9
then8:
  %t319 = call %NativeState @emit_variable(%NativeState %state, %Statement %statement)
  ret %NativeState %t319
merge9:
  %t320 = extractvalue %Statement %statement, 0
  %t321 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t322 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t323 = icmp eq i32 %t320, 0
  %t324 = select i1 %t323, i8* %t322, i8* %t321
  %t325 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t326 = icmp eq i32 %t320, 1
  %t327 = select i1 %t326, i8* %t325, i8* %t324
  %t328 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t329 = icmp eq i32 %t320, 2
  %t330 = select i1 %t329, i8* %t328, i8* %t327
  %t331 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t332 = icmp eq i32 %t320, 3
  %t333 = select i1 %t332, i8* %t331, i8* %t330
  %t334 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t335 = icmp eq i32 %t320, 4
  %t336 = select i1 %t335, i8* %t334, i8* %t333
  %t337 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t338 = icmp eq i32 %t320, 5
  %t339 = select i1 %t338, i8* %t337, i8* %t336
  %t340 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t341 = icmp eq i32 %t320, 6
  %t342 = select i1 %t341, i8* %t340, i8* %t339
  %t343 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t344 = icmp eq i32 %t320, 7
  %t345 = select i1 %t344, i8* %t343, i8* %t342
  %t346 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t347 = icmp eq i32 %t320, 8
  %t348 = select i1 %t347, i8* %t346, i8* %t345
  %t349 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t350 = icmp eq i32 %t320, 9
  %t351 = select i1 %t350, i8* %t349, i8* %t348
  %t352 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t353 = icmp eq i32 %t320, 10
  %t354 = select i1 %t353, i8* %t352, i8* %t351
  %t355 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t356 = icmp eq i32 %t320, 11
  %t357 = select i1 %t356, i8* %t355, i8* %t354
  %t358 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t359 = icmp eq i32 %t320, 12
  %t360 = select i1 %t359, i8* %t358, i8* %t357
  %t361 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t362 = icmp eq i32 %t320, 13
  %t363 = select i1 %t362, i8* %t361, i8* %t360
  %t364 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t365 = icmp eq i32 %t320, 14
  %t366 = select i1 %t365, i8* %t364, i8* %t363
  %t367 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t368 = icmp eq i32 %t320, 15
  %t369 = select i1 %t368, i8* %t367, i8* %t366
  %t370 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t371 = icmp eq i32 %t320, 16
  %t372 = select i1 %t371, i8* %t370, i8* %t369
  %t373 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t374 = icmp eq i32 %t320, 17
  %t375 = select i1 %t374, i8* %t373, i8* %t372
  %t376 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t377 = icmp eq i32 %t320, 18
  %t378 = select i1 %t377, i8* %t376, i8* %t375
  %t379 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t380 = icmp eq i32 %t320, 19
  %t381 = select i1 %t380, i8* %t379, i8* %t378
  %t382 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t383 = icmp eq i32 %t320, 20
  %t384 = select i1 %t383, i8* %t382, i8* %t381
  %t385 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t386 = icmp eq i32 %t320, 21
  %t387 = select i1 %t386, i8* %t385, i8* %t384
  %t388 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t389 = icmp eq i32 %t320, 22
  %t390 = select i1 %t389, i8* %t388, i8* %t387
  %s391 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h486335986, i32 0, i32 0
  %t392 = icmp eq i8* %t390, %s391
  br i1 %t392, label %then10, label %merge11
then10:
  %t393 = extractvalue %Statement %statement, 0
  %t394 = alloca %Statement
  store %Statement %statement, %Statement* %t394
  %t395 = getelementptr inbounds %Statement, %Statement* %t394, i32 0, i32 1
  %t396 = bitcast [24 x i8]* %t395 to i8*
  %t397 = bitcast i8* %t396 to %FunctionSignature*
  %t398 = load %FunctionSignature, %FunctionSignature* %t397
  %t399 = icmp eq i32 %t393, 4
  %t400 = select i1 %t399, %FunctionSignature %t398, %FunctionSignature zeroinitializer
  %t401 = getelementptr inbounds %Statement, %Statement* %t394, i32 0, i32 1
  %t402 = bitcast [24 x i8]* %t401 to i8*
  %t403 = bitcast i8* %t402 to %FunctionSignature*
  %t404 = load %FunctionSignature, %FunctionSignature* %t403
  %t405 = icmp eq i32 %t393, 5
  %t406 = select i1 %t405, %FunctionSignature %t404, %FunctionSignature %t400
  %t407 = getelementptr inbounds %Statement, %Statement* %t394, i32 0, i32 1
  %t408 = bitcast [24 x i8]* %t407 to i8*
  %t409 = bitcast i8* %t408 to %FunctionSignature*
  %t410 = load %FunctionSignature, %FunctionSignature* %t409
  %t411 = icmp eq i32 %t393, 7
  %t412 = select i1 %t411, %FunctionSignature %t410, %FunctionSignature %t406
  %t413 = extractvalue %Statement %statement, 0
  %t414 = alloca %Statement
  store %Statement %statement, %Statement* %t414
  %t415 = getelementptr inbounds %Statement, %Statement* %t414, i32 0, i32 1
  %t416 = bitcast [24 x i8]* %t415 to i8*
  %t417 = getelementptr inbounds i8, i8* %t416, i64 8
  %t418 = bitcast i8* %t417 to %Block*
  %t419 = load %Block, %Block* %t418
  %t420 = icmp eq i32 %t413, 4
  %t421 = select i1 %t420, %Block %t419, %Block zeroinitializer
  %t422 = getelementptr inbounds %Statement, %Statement* %t414, i32 0, i32 1
  %t423 = bitcast [24 x i8]* %t422 to i8*
  %t424 = getelementptr inbounds i8, i8* %t423, i64 8
  %t425 = bitcast i8* %t424 to %Block*
  %t426 = load %Block, %Block* %t425
  %t427 = icmp eq i32 %t413, 5
  %t428 = select i1 %t427, %Block %t426, %Block %t421
  %t429 = getelementptr inbounds %Statement, %Statement* %t414, i32 0, i32 1
  %t430 = bitcast [40 x i8]* %t429 to i8*
  %t431 = getelementptr inbounds i8, i8* %t430, i64 16
  %t432 = bitcast i8* %t431 to %Block*
  %t433 = load %Block, %Block* %t432
  %t434 = icmp eq i32 %t413, 6
  %t435 = select i1 %t434, %Block %t433, %Block %t428
  %t436 = getelementptr inbounds %Statement, %Statement* %t414, i32 0, i32 1
  %t437 = bitcast [24 x i8]* %t436 to i8*
  %t438 = getelementptr inbounds i8, i8* %t437, i64 8
  %t439 = bitcast i8* %t438 to %Block*
  %t440 = load %Block, %Block* %t439
  %t441 = icmp eq i32 %t413, 7
  %t442 = select i1 %t441, %Block %t440, %Block %t435
  %t443 = getelementptr inbounds %Statement, %Statement* %t414, i32 0, i32 1
  %t444 = bitcast [40 x i8]* %t443 to i8*
  %t445 = getelementptr inbounds i8, i8* %t444, i64 24
  %t446 = bitcast i8* %t445 to %Block*
  %t447 = load %Block, %Block* %t446
  %t448 = icmp eq i32 %t413, 12
  %t449 = select i1 %t448, %Block %t447, %Block %t442
  %t450 = getelementptr inbounds %Statement, %Statement* %t414, i32 0, i32 1
  %t451 = bitcast [24 x i8]* %t450 to i8*
  %t452 = getelementptr inbounds i8, i8* %t451, i64 8
  %t453 = bitcast i8* %t452 to %Block*
  %t454 = load %Block, %Block* %t453
  %t455 = icmp eq i32 %t413, 13
  %t456 = select i1 %t455, %Block %t454, %Block %t449
  %t457 = getelementptr inbounds %Statement, %Statement* %t414, i32 0, i32 1
  %t458 = bitcast [24 x i8]* %t457 to i8*
  %t459 = getelementptr inbounds i8, i8* %t458, i64 8
  %t460 = bitcast i8* %t459 to %Block*
  %t461 = load %Block, %Block* %t460
  %t462 = icmp eq i32 %t413, 14
  %t463 = select i1 %t462, %Block %t461, %Block %t456
  %t464 = getelementptr inbounds %Statement, %Statement* %t414, i32 0, i32 1
  %t465 = bitcast [16 x i8]* %t464 to i8*
  %t466 = bitcast i8* %t465 to %Block*
  %t467 = load %Block, %Block* %t466
  %t468 = icmp eq i32 %t413, 15
  %t469 = select i1 %t468, %Block %t467, %Block %t463
  %t470 = extractvalue %Statement %statement, 0
  %t471 = alloca %Statement
  store %Statement %statement, %Statement* %t471
  %t472 = getelementptr inbounds %Statement, %Statement* %t471, i32 0, i32 1
  %t473 = bitcast [48 x i8]* %t472 to i8*
  %t474 = getelementptr inbounds i8, i8* %t473, i64 40
  %t475 = bitcast i8* %t474 to { %Decorator**, i64 }**
  %t476 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t475
  %t477 = icmp eq i32 %t470, 3
  %t478 = select i1 %t477, { %Decorator**, i64 }* %t476, { %Decorator**, i64 }* null
  %t479 = getelementptr inbounds %Statement, %Statement* %t471, i32 0, i32 1
  %t480 = bitcast [24 x i8]* %t479 to i8*
  %t481 = getelementptr inbounds i8, i8* %t480, i64 16
  %t482 = bitcast i8* %t481 to { %Decorator**, i64 }**
  %t483 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t482
  %t484 = icmp eq i32 %t470, 4
  %t485 = select i1 %t484, { %Decorator**, i64 }* %t483, { %Decorator**, i64 }* %t478
  %t486 = getelementptr inbounds %Statement, %Statement* %t471, i32 0, i32 1
  %t487 = bitcast [24 x i8]* %t486 to i8*
  %t488 = getelementptr inbounds i8, i8* %t487, i64 16
  %t489 = bitcast i8* %t488 to { %Decorator**, i64 }**
  %t490 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t489
  %t491 = icmp eq i32 %t470, 5
  %t492 = select i1 %t491, { %Decorator**, i64 }* %t490, { %Decorator**, i64 }* %t485
  %t493 = getelementptr inbounds %Statement, %Statement* %t471, i32 0, i32 1
  %t494 = bitcast [40 x i8]* %t493 to i8*
  %t495 = getelementptr inbounds i8, i8* %t494, i64 32
  %t496 = bitcast i8* %t495 to { %Decorator**, i64 }**
  %t497 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t496
  %t498 = icmp eq i32 %t470, 6
  %t499 = select i1 %t498, { %Decorator**, i64 }* %t497, { %Decorator**, i64 }* %t492
  %t500 = getelementptr inbounds %Statement, %Statement* %t471, i32 0, i32 1
  %t501 = bitcast [24 x i8]* %t500 to i8*
  %t502 = getelementptr inbounds i8, i8* %t501, i64 16
  %t503 = bitcast i8* %t502 to { %Decorator**, i64 }**
  %t504 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t503
  %t505 = icmp eq i32 %t470, 7
  %t506 = select i1 %t505, { %Decorator**, i64 }* %t504, { %Decorator**, i64 }* %t499
  %t507 = getelementptr inbounds %Statement, %Statement* %t471, i32 0, i32 1
  %t508 = bitcast [56 x i8]* %t507 to i8*
  %t509 = getelementptr inbounds i8, i8* %t508, i64 48
  %t510 = bitcast i8* %t509 to { %Decorator**, i64 }**
  %t511 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t510
  %t512 = icmp eq i32 %t470, 8
  %t513 = select i1 %t512, { %Decorator**, i64 }* %t511, { %Decorator**, i64 }* %t506
  %t514 = getelementptr inbounds %Statement, %Statement* %t471, i32 0, i32 1
  %t515 = bitcast [40 x i8]* %t514 to i8*
  %t516 = getelementptr inbounds i8, i8* %t515, i64 32
  %t517 = bitcast i8* %t516 to { %Decorator**, i64 }**
  %t518 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t517
  %t519 = icmp eq i32 %t470, 9
  %t520 = select i1 %t519, { %Decorator**, i64 }* %t518, { %Decorator**, i64 }* %t513
  %t521 = getelementptr inbounds %Statement, %Statement* %t471, i32 0, i32 1
  %t522 = bitcast [40 x i8]* %t521 to i8*
  %t523 = getelementptr inbounds i8, i8* %t522, i64 32
  %t524 = bitcast i8* %t523 to { %Decorator**, i64 }**
  %t525 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t524
  %t526 = icmp eq i32 %t470, 10
  %t527 = select i1 %t526, { %Decorator**, i64 }* %t525, { %Decorator**, i64 }* %t520
  %t528 = getelementptr inbounds %Statement, %Statement* %t471, i32 0, i32 1
  %t529 = bitcast [40 x i8]* %t528 to i8*
  %t530 = getelementptr inbounds i8, i8* %t529, i64 32
  %t531 = bitcast i8* %t530 to { %Decorator**, i64 }**
  %t532 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t531
  %t533 = icmp eq i32 %t470, 11
  %t534 = select i1 %t533, { %Decorator**, i64 }* %t532, { %Decorator**, i64 }* %t527
  %t535 = getelementptr inbounds %Statement, %Statement* %t471, i32 0, i32 1
  %t536 = bitcast [40 x i8]* %t535 to i8*
  %t537 = getelementptr inbounds i8, i8* %t536, i64 32
  %t538 = bitcast i8* %t537 to { %Decorator**, i64 }**
  %t539 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t538
  %t540 = icmp eq i32 %t470, 12
  %t541 = select i1 %t540, { %Decorator**, i64 }* %t539, { %Decorator**, i64 }* %t534
  %t542 = getelementptr inbounds %Statement, %Statement* %t471, i32 0, i32 1
  %t543 = bitcast [24 x i8]* %t542 to i8*
  %t544 = getelementptr inbounds i8, i8* %t543, i64 16
  %t545 = bitcast i8* %t544 to { %Decorator**, i64 }**
  %t546 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t545
  %t547 = icmp eq i32 %t470, 13
  %t548 = select i1 %t547, { %Decorator**, i64 }* %t546, { %Decorator**, i64 }* %t541
  %t549 = getelementptr inbounds %Statement, %Statement* %t471, i32 0, i32 1
  %t550 = bitcast [24 x i8]* %t549 to i8*
  %t551 = getelementptr inbounds i8, i8* %t550, i64 16
  %t552 = bitcast i8* %t551 to { %Decorator**, i64 }**
  %t553 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t552
  %t554 = icmp eq i32 %t470, 14
  %t555 = select i1 %t554, { %Decorator**, i64 }* %t553, { %Decorator**, i64 }* %t548
  %t556 = getelementptr inbounds %Statement, %Statement* %t471, i32 0, i32 1
  %t557 = bitcast [16 x i8]* %t556 to i8*
  %t558 = getelementptr inbounds i8, i8* %t557, i64 8
  %t559 = bitcast i8* %t558 to { %Decorator**, i64 }**
  %t560 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t559
  %t561 = icmp eq i32 %t470, 15
  %t562 = select i1 %t561, { %Decorator**, i64 }* %t560, { %Decorator**, i64 }* %t555
  %t563 = getelementptr inbounds %Statement, %Statement* %t471, i32 0, i32 1
  %t564 = bitcast [24 x i8]* %t563 to i8*
  %t565 = getelementptr inbounds i8, i8* %t564, i64 16
  %t566 = bitcast i8* %t565 to { %Decorator**, i64 }**
  %t567 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t566
  %t568 = icmp eq i32 %t470, 18
  %t569 = select i1 %t568, { %Decorator**, i64 }* %t567, { %Decorator**, i64 }* %t562
  %t570 = getelementptr inbounds %Statement, %Statement* %t471, i32 0, i32 1
  %t571 = bitcast [32 x i8]* %t570 to i8*
  %t572 = getelementptr inbounds i8, i8* %t571, i64 24
  %t573 = bitcast i8* %t572 to { %Decorator**, i64 }**
  %t574 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t573
  %t575 = icmp eq i32 %t470, 19
  %t576 = select i1 %t575, { %Decorator**, i64 }* %t574, { %Decorator**, i64 }* %t569
  %t577 = bitcast { %Decorator**, i64 }* %t576 to { %Decorator*, i64 }*
  %t578 = call %NativeState @emit_function(%NativeState %state, %FunctionSignature %t412, %Block %t469, { %Decorator*, i64 }* %t577)
  ret %NativeState %t578
merge11:
  %t579 = extractvalue %Statement %statement, 0
  %t580 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t581 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t582 = icmp eq i32 %t579, 0
  %t583 = select i1 %t582, i8* %t581, i8* %t580
  %t584 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t585 = icmp eq i32 %t579, 1
  %t586 = select i1 %t585, i8* %t584, i8* %t583
  %t587 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t588 = icmp eq i32 %t579, 2
  %t589 = select i1 %t588, i8* %t587, i8* %t586
  %t590 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t591 = icmp eq i32 %t579, 3
  %t592 = select i1 %t591, i8* %t590, i8* %t589
  %t593 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t594 = icmp eq i32 %t579, 4
  %t595 = select i1 %t594, i8* %t593, i8* %t592
  %t596 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t597 = icmp eq i32 %t579, 5
  %t598 = select i1 %t597, i8* %t596, i8* %t595
  %t599 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t600 = icmp eq i32 %t579, 6
  %t601 = select i1 %t600, i8* %t599, i8* %t598
  %t602 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t603 = icmp eq i32 %t579, 7
  %t604 = select i1 %t603, i8* %t602, i8* %t601
  %t605 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t606 = icmp eq i32 %t579, 8
  %t607 = select i1 %t606, i8* %t605, i8* %t604
  %t608 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t609 = icmp eq i32 %t579, 9
  %t610 = select i1 %t609, i8* %t608, i8* %t607
  %t611 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t612 = icmp eq i32 %t579, 10
  %t613 = select i1 %t612, i8* %t611, i8* %t610
  %t614 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t615 = icmp eq i32 %t579, 11
  %t616 = select i1 %t615, i8* %t614, i8* %t613
  %t617 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t618 = icmp eq i32 %t579, 12
  %t619 = select i1 %t618, i8* %t617, i8* %t616
  %t620 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t621 = icmp eq i32 %t579, 13
  %t622 = select i1 %t621, i8* %t620, i8* %t619
  %t623 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t624 = icmp eq i32 %t579, 14
  %t625 = select i1 %t624, i8* %t623, i8* %t622
  %t626 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t627 = icmp eq i32 %t579, 15
  %t628 = select i1 %t627, i8* %t626, i8* %t625
  %t629 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t630 = icmp eq i32 %t579, 16
  %t631 = select i1 %t630, i8* %t629, i8* %t628
  %t632 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t633 = icmp eq i32 %t579, 17
  %t634 = select i1 %t633, i8* %t632, i8* %t631
  %t635 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t636 = icmp eq i32 %t579, 18
  %t637 = select i1 %t636, i8* %t635, i8* %t634
  %t638 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t639 = icmp eq i32 %t579, 19
  %t640 = select i1 %t639, i8* %t638, i8* %t637
  %t641 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t642 = icmp eq i32 %t579, 20
  %t643 = select i1 %t642, i8* %t641, i8* %t640
  %t644 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t645 = icmp eq i32 %t579, 21
  %t646 = select i1 %t645, i8* %t644, i8* %t643
  %t647 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t648 = icmp eq i32 %t579, 22
  %t649 = select i1 %t648, i8* %t647, i8* %t646
  %s650 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1842783069, i32 0, i32 0
  %t651 = icmp eq i8* %t649, %s650
  br i1 %t651, label %then12, label %merge13
then12:
  %t652 = call %NativeState @emit_struct(%NativeState %state, %Statement %statement)
  ret %NativeState %t652
merge13:
  %t653 = extractvalue %Statement %statement, 0
  %t654 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t655 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t656 = icmp eq i32 %t653, 0
  %t657 = select i1 %t656, i8* %t655, i8* %t654
  %t658 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t659 = icmp eq i32 %t653, 1
  %t660 = select i1 %t659, i8* %t658, i8* %t657
  %t661 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t662 = icmp eq i32 %t653, 2
  %t663 = select i1 %t662, i8* %t661, i8* %t660
  %t664 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t665 = icmp eq i32 %t653, 3
  %t666 = select i1 %t665, i8* %t664, i8* %t663
  %t667 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t668 = icmp eq i32 %t653, 4
  %t669 = select i1 %t668, i8* %t667, i8* %t666
  %t670 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t671 = icmp eq i32 %t653, 5
  %t672 = select i1 %t671, i8* %t670, i8* %t669
  %t673 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t674 = icmp eq i32 %t653, 6
  %t675 = select i1 %t674, i8* %t673, i8* %t672
  %t676 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t677 = icmp eq i32 %t653, 7
  %t678 = select i1 %t677, i8* %t676, i8* %t675
  %t679 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t680 = icmp eq i32 %t653, 8
  %t681 = select i1 %t680, i8* %t679, i8* %t678
  %t682 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t683 = icmp eq i32 %t653, 9
  %t684 = select i1 %t683, i8* %t682, i8* %t681
  %t685 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t686 = icmp eq i32 %t653, 10
  %t687 = select i1 %t686, i8* %t685, i8* %t684
  %t688 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t689 = icmp eq i32 %t653, 11
  %t690 = select i1 %t689, i8* %t688, i8* %t687
  %t691 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t692 = icmp eq i32 %t653, 12
  %t693 = select i1 %t692, i8* %t691, i8* %t690
  %t694 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t695 = icmp eq i32 %t653, 13
  %t696 = select i1 %t695, i8* %t694, i8* %t693
  %t697 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t698 = icmp eq i32 %t653, 14
  %t699 = select i1 %t698, i8* %t697, i8* %t696
  %t700 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t701 = icmp eq i32 %t653, 15
  %t702 = select i1 %t701, i8* %t700, i8* %t699
  %t703 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t704 = icmp eq i32 %t653, 16
  %t705 = select i1 %t704, i8* %t703, i8* %t702
  %t706 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t707 = icmp eq i32 %t653, 17
  %t708 = select i1 %t707, i8* %t706, i8* %t705
  %t709 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t710 = icmp eq i32 %t653, 18
  %t711 = select i1 %t710, i8* %t709, i8* %t708
  %t712 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t713 = icmp eq i32 %t653, 19
  %t714 = select i1 %t713, i8* %t712, i8* %t711
  %t715 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t716 = icmp eq i32 %t653, 20
  %t717 = select i1 %t716, i8* %t715, i8* %t714
  %t718 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t719 = icmp eq i32 %t653, 21
  %t720 = select i1 %t719, i8* %t718, i8* %t717
  %t721 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t722 = icmp eq i32 %t653, 22
  %t723 = select i1 %t722, i8* %t721, i8* %t720
  %s724 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h479148896, i32 0, i32 0
  %t725 = icmp eq i8* %t723, %s724
  br i1 %t725, label %then14, label %merge15
then14:
  %t726 = call %NativeState @emit_pipeline(%NativeState %state, %Statement %statement)
  ret %NativeState %t726
merge15:
  %t727 = extractvalue %Statement %statement, 0
  %t728 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t729 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t730 = icmp eq i32 %t727, 0
  %t731 = select i1 %t730, i8* %t729, i8* %t728
  %t732 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t733 = icmp eq i32 %t727, 1
  %t734 = select i1 %t733, i8* %t732, i8* %t731
  %t735 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t736 = icmp eq i32 %t727, 2
  %t737 = select i1 %t736, i8* %t735, i8* %t734
  %t738 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t739 = icmp eq i32 %t727, 3
  %t740 = select i1 %t739, i8* %t738, i8* %t737
  %t741 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t742 = icmp eq i32 %t727, 4
  %t743 = select i1 %t742, i8* %t741, i8* %t740
  %t744 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t745 = icmp eq i32 %t727, 5
  %t746 = select i1 %t745, i8* %t744, i8* %t743
  %t747 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t748 = icmp eq i32 %t727, 6
  %t749 = select i1 %t748, i8* %t747, i8* %t746
  %t750 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t751 = icmp eq i32 %t727, 7
  %t752 = select i1 %t751, i8* %t750, i8* %t749
  %t753 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t754 = icmp eq i32 %t727, 8
  %t755 = select i1 %t754, i8* %t753, i8* %t752
  %t756 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t757 = icmp eq i32 %t727, 9
  %t758 = select i1 %t757, i8* %t756, i8* %t755
  %t759 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t760 = icmp eq i32 %t727, 10
  %t761 = select i1 %t760, i8* %t759, i8* %t758
  %t762 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t763 = icmp eq i32 %t727, 11
  %t764 = select i1 %t763, i8* %t762, i8* %t761
  %t765 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t766 = icmp eq i32 %t727, 12
  %t767 = select i1 %t766, i8* %t765, i8* %t764
  %t768 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t769 = icmp eq i32 %t727, 13
  %t770 = select i1 %t769, i8* %t768, i8* %t767
  %t771 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t772 = icmp eq i32 %t727, 14
  %t773 = select i1 %t772, i8* %t771, i8* %t770
  %t774 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t775 = icmp eq i32 %t727, 15
  %t776 = select i1 %t775, i8* %t774, i8* %t773
  %t777 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t778 = icmp eq i32 %t727, 16
  %t779 = select i1 %t778, i8* %t777, i8* %t776
  %t780 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t781 = icmp eq i32 %t727, 17
  %t782 = select i1 %t781, i8* %t780, i8* %t779
  %t783 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t784 = icmp eq i32 %t727, 18
  %t785 = select i1 %t784, i8* %t783, i8* %t782
  %t786 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t787 = icmp eq i32 %t727, 19
  %t788 = select i1 %t787, i8* %t786, i8* %t785
  %t789 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t790 = icmp eq i32 %t727, 20
  %t791 = select i1 %t790, i8* %t789, i8* %t788
  %t792 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t793 = icmp eq i32 %t727, 21
  %t794 = select i1 %t793, i8* %t792, i8* %t791
  %t795 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t796 = icmp eq i32 %t727, 22
  %t797 = select i1 %t796, i8* %t795, i8* %t794
  %s798 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h571715647, i32 0, i32 0
  %t799 = icmp eq i8* %t797, %s798
  br i1 %t799, label %then16, label %merge17
then16:
  %t800 = call %NativeState @emit_tool(%NativeState %state, %Statement %statement)
  ret %NativeState %t800
merge17:
  %t801 = extractvalue %Statement %statement, 0
  %t802 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t803 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t804 = icmp eq i32 %t801, 0
  %t805 = select i1 %t804, i8* %t803, i8* %t802
  %t806 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t807 = icmp eq i32 %t801, 1
  %t808 = select i1 %t807, i8* %t806, i8* %t805
  %t809 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t810 = icmp eq i32 %t801, 2
  %t811 = select i1 %t810, i8* %t809, i8* %t808
  %t812 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t813 = icmp eq i32 %t801, 3
  %t814 = select i1 %t813, i8* %t812, i8* %t811
  %t815 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t816 = icmp eq i32 %t801, 4
  %t817 = select i1 %t816, i8* %t815, i8* %t814
  %t818 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t819 = icmp eq i32 %t801, 5
  %t820 = select i1 %t819, i8* %t818, i8* %t817
  %t821 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t822 = icmp eq i32 %t801, 6
  %t823 = select i1 %t822, i8* %t821, i8* %t820
  %t824 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t825 = icmp eq i32 %t801, 7
  %t826 = select i1 %t825, i8* %t824, i8* %t823
  %t827 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t828 = icmp eq i32 %t801, 8
  %t829 = select i1 %t828, i8* %t827, i8* %t826
  %t830 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t831 = icmp eq i32 %t801, 9
  %t832 = select i1 %t831, i8* %t830, i8* %t829
  %t833 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t834 = icmp eq i32 %t801, 10
  %t835 = select i1 %t834, i8* %t833, i8* %t832
  %t836 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t837 = icmp eq i32 %t801, 11
  %t838 = select i1 %t837, i8* %t836, i8* %t835
  %t839 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t840 = icmp eq i32 %t801, 12
  %t841 = select i1 %t840, i8* %t839, i8* %t838
  %t842 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t843 = icmp eq i32 %t801, 13
  %t844 = select i1 %t843, i8* %t842, i8* %t841
  %t845 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t846 = icmp eq i32 %t801, 14
  %t847 = select i1 %t846, i8* %t845, i8* %t844
  %t848 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t849 = icmp eq i32 %t801, 15
  %t850 = select i1 %t849, i8* %t848, i8* %t847
  %t851 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t852 = icmp eq i32 %t801, 16
  %t853 = select i1 %t852, i8* %t851, i8* %t850
  %t854 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t855 = icmp eq i32 %t801, 17
  %t856 = select i1 %t855, i8* %t854, i8* %t853
  %t857 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t858 = icmp eq i32 %t801, 18
  %t859 = select i1 %t858, i8* %t857, i8* %t856
  %t860 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t861 = icmp eq i32 %t801, 19
  %t862 = select i1 %t861, i8* %t860, i8* %t859
  %t863 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t864 = icmp eq i32 %t801, 20
  %t865 = select i1 %t864, i8* %t863, i8* %t862
  %t866 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t867 = icmp eq i32 %t801, 21
  %t868 = select i1 %t867, i8* %t866, i8* %t865
  %t869 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t870 = icmp eq i32 %t801, 22
  %t871 = select i1 %t870, i8* %t869, i8* %t868
  %s872 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h889179835, i32 0, i32 0
  %t873 = icmp eq i8* %t871, %s872
  br i1 %t873, label %then18, label %merge19
then18:
  %t874 = call %NativeState @emit_test(%NativeState %state, %Statement %statement)
  ret %NativeState %t874
merge19:
  %t875 = extractvalue %Statement %statement, 0
  %t876 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t877 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t878 = icmp eq i32 %t875, 0
  %t879 = select i1 %t878, i8* %t877, i8* %t876
  %t880 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t881 = icmp eq i32 %t875, 1
  %t882 = select i1 %t881, i8* %t880, i8* %t879
  %t883 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t884 = icmp eq i32 %t875, 2
  %t885 = select i1 %t884, i8* %t883, i8* %t882
  %t886 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t887 = icmp eq i32 %t875, 3
  %t888 = select i1 %t887, i8* %t886, i8* %t885
  %t889 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t890 = icmp eq i32 %t875, 4
  %t891 = select i1 %t890, i8* %t889, i8* %t888
  %t892 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t893 = icmp eq i32 %t875, 5
  %t894 = select i1 %t893, i8* %t892, i8* %t891
  %t895 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t896 = icmp eq i32 %t875, 6
  %t897 = select i1 %t896, i8* %t895, i8* %t894
  %t898 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t899 = icmp eq i32 %t875, 7
  %t900 = select i1 %t899, i8* %t898, i8* %t897
  %t901 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t902 = icmp eq i32 %t875, 8
  %t903 = select i1 %t902, i8* %t901, i8* %t900
  %t904 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t905 = icmp eq i32 %t875, 9
  %t906 = select i1 %t905, i8* %t904, i8* %t903
  %t907 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t908 = icmp eq i32 %t875, 10
  %t909 = select i1 %t908, i8* %t907, i8* %t906
  %t910 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t911 = icmp eq i32 %t875, 11
  %t912 = select i1 %t911, i8* %t910, i8* %t909
  %t913 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t914 = icmp eq i32 %t875, 12
  %t915 = select i1 %t914, i8* %t913, i8* %t912
  %t916 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t917 = icmp eq i32 %t875, 13
  %t918 = select i1 %t917, i8* %t916, i8* %t915
  %t919 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t920 = icmp eq i32 %t875, 14
  %t921 = select i1 %t920, i8* %t919, i8* %t918
  %t922 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t923 = icmp eq i32 %t875, 15
  %t924 = select i1 %t923, i8* %t922, i8* %t921
  %t925 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t926 = icmp eq i32 %t875, 16
  %t927 = select i1 %t926, i8* %t925, i8* %t924
  %t928 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t929 = icmp eq i32 %t875, 17
  %t930 = select i1 %t929, i8* %t928, i8* %t927
  %t931 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t932 = icmp eq i32 %t875, 18
  %t933 = select i1 %t932, i8* %t931, i8* %t930
  %t934 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t935 = icmp eq i32 %t875, 19
  %t936 = select i1 %t935, i8* %t934, i8* %t933
  %t937 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t938 = icmp eq i32 %t875, 20
  %t939 = select i1 %t938, i8* %t937, i8* %t936
  %t940 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t941 = icmp eq i32 %t875, 21
  %t942 = select i1 %t941, i8* %t940, i8* %t939
  %t943 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t944 = icmp eq i32 %t875, 22
  %t945 = select i1 %t944, i8* %t943, i8* %t942
  %s946 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h2043328844, i32 0, i32 0
  %t947 = icmp eq i8* %t945, %s946
  br i1 %t947, label %then20, label %merge21
then20:
  %t948 = call %NativeState @emit_model(%NativeState %state, %Statement %statement)
  ret %NativeState %t948
merge21:
  %t949 = extractvalue %Statement %statement, 0
  %t950 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t951 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t952 = icmp eq i32 %t949, 0
  %t953 = select i1 %t952, i8* %t951, i8* %t950
  %t954 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t955 = icmp eq i32 %t949, 1
  %t956 = select i1 %t955, i8* %t954, i8* %t953
  %t957 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t958 = icmp eq i32 %t949, 2
  %t959 = select i1 %t958, i8* %t957, i8* %t956
  %t960 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t961 = icmp eq i32 %t949, 3
  %t962 = select i1 %t961, i8* %t960, i8* %t959
  %t963 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t964 = icmp eq i32 %t949, 4
  %t965 = select i1 %t964, i8* %t963, i8* %t962
  %t966 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t967 = icmp eq i32 %t949, 5
  %t968 = select i1 %t967, i8* %t966, i8* %t965
  %t969 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t970 = icmp eq i32 %t949, 6
  %t971 = select i1 %t970, i8* %t969, i8* %t968
  %t972 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t973 = icmp eq i32 %t949, 7
  %t974 = select i1 %t973, i8* %t972, i8* %t971
  %t975 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t976 = icmp eq i32 %t949, 8
  %t977 = select i1 %t976, i8* %t975, i8* %t974
  %t978 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t979 = icmp eq i32 %t949, 9
  %t980 = select i1 %t979, i8* %t978, i8* %t977
  %t981 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t982 = icmp eq i32 %t949, 10
  %t983 = select i1 %t982, i8* %t981, i8* %t980
  %t984 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t985 = icmp eq i32 %t949, 11
  %t986 = select i1 %t985, i8* %t984, i8* %t983
  %t987 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t988 = icmp eq i32 %t949, 12
  %t989 = select i1 %t988, i8* %t987, i8* %t986
  %t990 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t991 = icmp eq i32 %t949, 13
  %t992 = select i1 %t991, i8* %t990, i8* %t989
  %t993 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t994 = icmp eq i32 %t949, 14
  %t995 = select i1 %t994, i8* %t993, i8* %t992
  %t996 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t997 = icmp eq i32 %t949, 15
  %t998 = select i1 %t997, i8* %t996, i8* %t995
  %t999 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1000 = icmp eq i32 %t949, 16
  %t1001 = select i1 %t1000, i8* %t999, i8* %t998
  %t1002 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1003 = icmp eq i32 %t949, 17
  %t1004 = select i1 %t1003, i8* %t1002, i8* %t1001
  %t1005 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1006 = icmp eq i32 %t949, 18
  %t1007 = select i1 %t1006, i8* %t1005, i8* %t1004
  %t1008 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1009 = icmp eq i32 %t949, 19
  %t1010 = select i1 %t1009, i8* %t1008, i8* %t1007
  %t1011 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1012 = icmp eq i32 %t949, 20
  %t1013 = select i1 %t1012, i8* %t1011, i8* %t1010
  %t1014 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1015 = icmp eq i32 %t949, 21
  %t1016 = select i1 %t1015, i8* %t1014, i8* %t1013
  %t1017 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1018 = icmp eq i32 %t949, 22
  %t1019 = select i1 %t1018, i8* %t1017, i8* %t1016
  %s1020 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1496093543, i32 0, i32 0
  %t1021 = icmp eq i8* %t1019, %s1020
  br i1 %t1021, label %then22, label %merge23
then22:
  %t1022 = call %NativeState @emit_type_alias(%NativeState %state, %Statement %statement)
  ret %NativeState %t1022
merge23:
  %t1023 = extractvalue %Statement %statement, 0
  %t1024 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1025 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1026 = icmp eq i32 %t1023, 0
  %t1027 = select i1 %t1026, i8* %t1025, i8* %t1024
  %t1028 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1029 = icmp eq i32 %t1023, 1
  %t1030 = select i1 %t1029, i8* %t1028, i8* %t1027
  %t1031 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1032 = icmp eq i32 %t1023, 2
  %t1033 = select i1 %t1032, i8* %t1031, i8* %t1030
  %t1034 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1035 = icmp eq i32 %t1023, 3
  %t1036 = select i1 %t1035, i8* %t1034, i8* %t1033
  %t1037 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1038 = icmp eq i32 %t1023, 4
  %t1039 = select i1 %t1038, i8* %t1037, i8* %t1036
  %t1040 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1041 = icmp eq i32 %t1023, 5
  %t1042 = select i1 %t1041, i8* %t1040, i8* %t1039
  %t1043 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1044 = icmp eq i32 %t1023, 6
  %t1045 = select i1 %t1044, i8* %t1043, i8* %t1042
  %t1046 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1047 = icmp eq i32 %t1023, 7
  %t1048 = select i1 %t1047, i8* %t1046, i8* %t1045
  %t1049 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1050 = icmp eq i32 %t1023, 8
  %t1051 = select i1 %t1050, i8* %t1049, i8* %t1048
  %t1052 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1053 = icmp eq i32 %t1023, 9
  %t1054 = select i1 %t1053, i8* %t1052, i8* %t1051
  %t1055 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1056 = icmp eq i32 %t1023, 10
  %t1057 = select i1 %t1056, i8* %t1055, i8* %t1054
  %t1058 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1059 = icmp eq i32 %t1023, 11
  %t1060 = select i1 %t1059, i8* %t1058, i8* %t1057
  %t1061 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1062 = icmp eq i32 %t1023, 12
  %t1063 = select i1 %t1062, i8* %t1061, i8* %t1060
  %t1064 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1065 = icmp eq i32 %t1023, 13
  %t1066 = select i1 %t1065, i8* %t1064, i8* %t1063
  %t1067 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1068 = icmp eq i32 %t1023, 14
  %t1069 = select i1 %t1068, i8* %t1067, i8* %t1066
  %t1070 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1071 = icmp eq i32 %t1023, 15
  %t1072 = select i1 %t1071, i8* %t1070, i8* %t1069
  %t1073 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1074 = icmp eq i32 %t1023, 16
  %t1075 = select i1 %t1074, i8* %t1073, i8* %t1072
  %t1076 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1077 = icmp eq i32 %t1023, 17
  %t1078 = select i1 %t1077, i8* %t1076, i8* %t1075
  %t1079 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1080 = icmp eq i32 %t1023, 18
  %t1081 = select i1 %t1080, i8* %t1079, i8* %t1078
  %t1082 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1083 = icmp eq i32 %t1023, 19
  %t1084 = select i1 %t1083, i8* %t1082, i8* %t1081
  %t1085 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1086 = icmp eq i32 %t1023, 20
  %t1087 = select i1 %t1086, i8* %t1085, i8* %t1084
  %t1088 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1089 = icmp eq i32 %t1023, 21
  %t1090 = select i1 %t1089, i8* %t1088, i8* %t1087
  %t1091 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1092 = icmp eq i32 %t1023, 22
  %t1093 = select i1 %t1092, i8* %t1091, i8* %t1090
  %s1094 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h666604742, i32 0, i32 0
  %t1095 = icmp eq i8* %t1093, %s1094
  br i1 %t1095, label %then24, label %merge25
then24:
  %t1096 = call %NativeState @emit_interface(%NativeState %state, %Statement %statement)
  ret %NativeState %t1096
merge25:
  %t1097 = extractvalue %Statement %statement, 0
  %t1098 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1099 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1100 = icmp eq i32 %t1097, 0
  %t1101 = select i1 %t1100, i8* %t1099, i8* %t1098
  %t1102 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1103 = icmp eq i32 %t1097, 1
  %t1104 = select i1 %t1103, i8* %t1102, i8* %t1101
  %t1105 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1106 = icmp eq i32 %t1097, 2
  %t1107 = select i1 %t1106, i8* %t1105, i8* %t1104
  %t1108 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1109 = icmp eq i32 %t1097, 3
  %t1110 = select i1 %t1109, i8* %t1108, i8* %t1107
  %t1111 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1112 = icmp eq i32 %t1097, 4
  %t1113 = select i1 %t1112, i8* %t1111, i8* %t1110
  %t1114 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1115 = icmp eq i32 %t1097, 5
  %t1116 = select i1 %t1115, i8* %t1114, i8* %t1113
  %t1117 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1118 = icmp eq i32 %t1097, 6
  %t1119 = select i1 %t1118, i8* %t1117, i8* %t1116
  %t1120 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1121 = icmp eq i32 %t1097, 7
  %t1122 = select i1 %t1121, i8* %t1120, i8* %t1119
  %t1123 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1124 = icmp eq i32 %t1097, 8
  %t1125 = select i1 %t1124, i8* %t1123, i8* %t1122
  %t1126 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1127 = icmp eq i32 %t1097, 9
  %t1128 = select i1 %t1127, i8* %t1126, i8* %t1125
  %t1129 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1130 = icmp eq i32 %t1097, 10
  %t1131 = select i1 %t1130, i8* %t1129, i8* %t1128
  %t1132 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1133 = icmp eq i32 %t1097, 11
  %t1134 = select i1 %t1133, i8* %t1132, i8* %t1131
  %t1135 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1136 = icmp eq i32 %t1097, 12
  %t1137 = select i1 %t1136, i8* %t1135, i8* %t1134
  %t1138 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1139 = icmp eq i32 %t1097, 13
  %t1140 = select i1 %t1139, i8* %t1138, i8* %t1137
  %t1141 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1142 = icmp eq i32 %t1097, 14
  %t1143 = select i1 %t1142, i8* %t1141, i8* %t1140
  %t1144 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1145 = icmp eq i32 %t1097, 15
  %t1146 = select i1 %t1145, i8* %t1144, i8* %t1143
  %t1147 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1148 = icmp eq i32 %t1097, 16
  %t1149 = select i1 %t1148, i8* %t1147, i8* %t1146
  %t1150 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1151 = icmp eq i32 %t1097, 17
  %t1152 = select i1 %t1151, i8* %t1150, i8* %t1149
  %t1153 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1154 = icmp eq i32 %t1097, 18
  %t1155 = select i1 %t1154, i8* %t1153, i8* %t1152
  %t1156 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1157 = icmp eq i32 %t1097, 19
  %t1158 = select i1 %t1157, i8* %t1156, i8* %t1155
  %t1159 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1160 = icmp eq i32 %t1097, 20
  %t1161 = select i1 %t1160, i8* %t1159, i8* %t1158
  %t1162 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1163 = icmp eq i32 %t1097, 21
  %t1164 = select i1 %t1163, i8* %t1162, i8* %t1161
  %t1165 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1166 = icmp eq i32 %t1097, 22
  %t1167 = select i1 %t1166, i8* %t1165, i8* %t1164
  %s1168 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h579804543, i32 0, i32 0
  %t1169 = icmp eq i8* %t1167, %s1168
  br i1 %t1169, label %then26, label %merge27
then26:
  %t1170 = call %NativeState @emit_enum(%NativeState %state, %Statement %statement)
  ret %NativeState %t1170
merge27:
  %t1171 = extractvalue %Statement %statement, 0
  %t1172 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1173 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1174 = icmp eq i32 %t1171, 0
  %t1175 = select i1 %t1174, i8* %t1173, i8* %t1172
  %t1176 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1177 = icmp eq i32 %t1171, 1
  %t1178 = select i1 %t1177, i8* %t1176, i8* %t1175
  %t1179 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1180 = icmp eq i32 %t1171, 2
  %t1181 = select i1 %t1180, i8* %t1179, i8* %t1178
  %t1182 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1183 = icmp eq i32 %t1171, 3
  %t1184 = select i1 %t1183, i8* %t1182, i8* %t1181
  %t1185 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1186 = icmp eq i32 %t1171, 4
  %t1187 = select i1 %t1186, i8* %t1185, i8* %t1184
  %t1188 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1189 = icmp eq i32 %t1171, 5
  %t1190 = select i1 %t1189, i8* %t1188, i8* %t1187
  %t1191 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1192 = icmp eq i32 %t1171, 6
  %t1193 = select i1 %t1192, i8* %t1191, i8* %t1190
  %t1194 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1195 = icmp eq i32 %t1171, 7
  %t1196 = select i1 %t1195, i8* %t1194, i8* %t1193
  %t1197 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1198 = icmp eq i32 %t1171, 8
  %t1199 = select i1 %t1198, i8* %t1197, i8* %t1196
  %t1200 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1201 = icmp eq i32 %t1171, 9
  %t1202 = select i1 %t1201, i8* %t1200, i8* %t1199
  %t1203 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1204 = icmp eq i32 %t1171, 10
  %t1205 = select i1 %t1204, i8* %t1203, i8* %t1202
  %t1206 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1207 = icmp eq i32 %t1171, 11
  %t1208 = select i1 %t1207, i8* %t1206, i8* %t1205
  %t1209 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1210 = icmp eq i32 %t1171, 12
  %t1211 = select i1 %t1210, i8* %t1209, i8* %t1208
  %t1212 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1213 = icmp eq i32 %t1171, 13
  %t1214 = select i1 %t1213, i8* %t1212, i8* %t1211
  %t1215 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1216 = icmp eq i32 %t1171, 14
  %t1217 = select i1 %t1216, i8* %t1215, i8* %t1214
  %t1218 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1219 = icmp eq i32 %t1171, 15
  %t1220 = select i1 %t1219, i8* %t1218, i8* %t1217
  %t1221 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1222 = icmp eq i32 %t1171, 16
  %t1223 = select i1 %t1222, i8* %t1221, i8* %t1220
  %t1224 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1225 = icmp eq i32 %t1171, 17
  %t1226 = select i1 %t1225, i8* %t1224, i8* %t1223
  %t1227 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1228 = icmp eq i32 %t1171, 18
  %t1229 = select i1 %t1228, i8* %t1227, i8* %t1226
  %t1230 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1231 = icmp eq i32 %t1171, 19
  %t1232 = select i1 %t1231, i8* %t1230, i8* %t1229
  %t1233 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1234 = icmp eq i32 %t1171, 20
  %t1235 = select i1 %t1234, i8* %t1233, i8* %t1232
  %t1236 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1237 = icmp eq i32 %t1171, 21
  %t1238 = select i1 %t1237, i8* %t1236, i8* %t1235
  %t1239 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1240 = icmp eq i32 %t1171, 22
  %t1241 = select i1 %t1240, i8* %t1239, i8* %t1238
  %s1242 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1067284810, i32 0, i32 0
  %t1243 = icmp eq i8* %t1241, %s1242
  br i1 %t1243, label %then28, label %merge29
then28:
  %t1244 = call %NativeState @emit_prompt(%NativeState %state, %Statement %statement)
  ret %NativeState %t1244
merge29:
  %t1245 = extractvalue %Statement %statement, 0
  %t1246 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1247 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1248 = icmp eq i32 %t1245, 0
  %t1249 = select i1 %t1248, i8* %t1247, i8* %t1246
  %t1250 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1251 = icmp eq i32 %t1245, 1
  %t1252 = select i1 %t1251, i8* %t1250, i8* %t1249
  %t1253 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1254 = icmp eq i32 %t1245, 2
  %t1255 = select i1 %t1254, i8* %t1253, i8* %t1252
  %t1256 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1257 = icmp eq i32 %t1245, 3
  %t1258 = select i1 %t1257, i8* %t1256, i8* %t1255
  %t1259 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1260 = icmp eq i32 %t1245, 4
  %t1261 = select i1 %t1260, i8* %t1259, i8* %t1258
  %t1262 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1263 = icmp eq i32 %t1245, 5
  %t1264 = select i1 %t1263, i8* %t1262, i8* %t1261
  %t1265 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1266 = icmp eq i32 %t1245, 6
  %t1267 = select i1 %t1266, i8* %t1265, i8* %t1264
  %t1268 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1269 = icmp eq i32 %t1245, 7
  %t1270 = select i1 %t1269, i8* %t1268, i8* %t1267
  %t1271 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1272 = icmp eq i32 %t1245, 8
  %t1273 = select i1 %t1272, i8* %t1271, i8* %t1270
  %t1274 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1275 = icmp eq i32 %t1245, 9
  %t1276 = select i1 %t1275, i8* %t1274, i8* %t1273
  %t1277 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1278 = icmp eq i32 %t1245, 10
  %t1279 = select i1 %t1278, i8* %t1277, i8* %t1276
  %t1280 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1281 = icmp eq i32 %t1245, 11
  %t1282 = select i1 %t1281, i8* %t1280, i8* %t1279
  %t1283 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1284 = icmp eq i32 %t1245, 12
  %t1285 = select i1 %t1284, i8* %t1283, i8* %t1282
  %t1286 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1287 = icmp eq i32 %t1245, 13
  %t1288 = select i1 %t1287, i8* %t1286, i8* %t1285
  %t1289 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1290 = icmp eq i32 %t1245, 14
  %t1291 = select i1 %t1290, i8* %t1289, i8* %t1288
  %t1292 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1293 = icmp eq i32 %t1245, 15
  %t1294 = select i1 %t1293, i8* %t1292, i8* %t1291
  %t1295 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1296 = icmp eq i32 %t1245, 16
  %t1297 = select i1 %t1296, i8* %t1295, i8* %t1294
  %t1298 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1299 = icmp eq i32 %t1245, 17
  %t1300 = select i1 %t1299, i8* %t1298, i8* %t1297
  %t1301 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1302 = icmp eq i32 %t1245, 18
  %t1303 = select i1 %t1302, i8* %t1301, i8* %t1300
  %t1304 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1305 = icmp eq i32 %t1245, 19
  %t1306 = select i1 %t1305, i8* %t1304, i8* %t1303
  %t1307 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1308 = icmp eq i32 %t1245, 20
  %t1309 = select i1 %t1308, i8* %t1307, i8* %t1306
  %t1310 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1311 = icmp eq i32 %t1245, 21
  %t1312 = select i1 %t1311, i8* %t1310, i8* %t1309
  %t1313 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1314 = icmp eq i32 %t1245, 22
  %t1315 = select i1 %t1314, i8* %t1313, i8* %t1312
  %s1316 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1925822000, i32 0, i32 0
  %t1317 = icmp eq i8* %t1315, %s1316
  br i1 %t1317, label %then30, label %merge31
then30:
  %t1318 = call %NativeState @emit_with(%NativeState %state, %Statement %statement)
  ret %NativeState %t1318
merge31:
  %t1319 = extractvalue %Statement %statement, 0
  %t1320 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1321 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1322 = icmp eq i32 %t1319, 0
  %t1323 = select i1 %t1322, i8* %t1321, i8* %t1320
  %t1324 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1325 = icmp eq i32 %t1319, 1
  %t1326 = select i1 %t1325, i8* %t1324, i8* %t1323
  %t1327 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1328 = icmp eq i32 %t1319, 2
  %t1329 = select i1 %t1328, i8* %t1327, i8* %t1326
  %t1330 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1331 = icmp eq i32 %t1319, 3
  %t1332 = select i1 %t1331, i8* %t1330, i8* %t1329
  %t1333 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1334 = icmp eq i32 %t1319, 4
  %t1335 = select i1 %t1334, i8* %t1333, i8* %t1332
  %t1336 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1337 = icmp eq i32 %t1319, 5
  %t1338 = select i1 %t1337, i8* %t1336, i8* %t1335
  %t1339 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1340 = icmp eq i32 %t1319, 6
  %t1341 = select i1 %t1340, i8* %t1339, i8* %t1338
  %t1342 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1343 = icmp eq i32 %t1319, 7
  %t1344 = select i1 %t1343, i8* %t1342, i8* %t1341
  %t1345 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1346 = icmp eq i32 %t1319, 8
  %t1347 = select i1 %t1346, i8* %t1345, i8* %t1344
  %t1348 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1349 = icmp eq i32 %t1319, 9
  %t1350 = select i1 %t1349, i8* %t1348, i8* %t1347
  %t1351 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1352 = icmp eq i32 %t1319, 10
  %t1353 = select i1 %t1352, i8* %t1351, i8* %t1350
  %t1354 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1355 = icmp eq i32 %t1319, 11
  %t1356 = select i1 %t1355, i8* %t1354, i8* %t1353
  %t1357 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1358 = icmp eq i32 %t1319, 12
  %t1359 = select i1 %t1358, i8* %t1357, i8* %t1356
  %t1360 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1361 = icmp eq i32 %t1319, 13
  %t1362 = select i1 %t1361, i8* %t1360, i8* %t1359
  %t1363 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1364 = icmp eq i32 %t1319, 14
  %t1365 = select i1 %t1364, i8* %t1363, i8* %t1362
  %t1366 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1367 = icmp eq i32 %t1319, 15
  %t1368 = select i1 %t1367, i8* %t1366, i8* %t1365
  %t1369 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1370 = icmp eq i32 %t1319, 16
  %t1371 = select i1 %t1370, i8* %t1369, i8* %t1368
  %t1372 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1373 = icmp eq i32 %t1319, 17
  %t1374 = select i1 %t1373, i8* %t1372, i8* %t1371
  %t1375 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1376 = icmp eq i32 %t1319, 18
  %t1377 = select i1 %t1376, i8* %t1375, i8* %t1374
  %t1378 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1379 = icmp eq i32 %t1319, 19
  %t1380 = select i1 %t1379, i8* %t1378, i8* %t1377
  %t1381 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1382 = icmp eq i32 %t1319, 20
  %t1383 = select i1 %t1382, i8* %t1381, i8* %t1380
  %t1384 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1385 = icmp eq i32 %t1319, 21
  %t1386 = select i1 %t1385, i8* %t1384, i8* %t1383
  %t1387 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1388 = icmp eq i32 %t1319, 22
  %t1389 = select i1 %t1388, i8* %t1387, i8* %t1386
  %s1390 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h84042670, i32 0, i32 0
  %t1391 = icmp eq i8* %t1389, %s1390
  br i1 %t1391, label %then32, label %merge33
then32:
  %t1392 = call %NativeState @emit_for(%NativeState %state, %Statement %statement)
  ret %NativeState %t1392
merge33:
  %t1393 = extractvalue %Statement %statement, 0
  %t1394 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1395 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1396 = icmp eq i32 %t1393, 0
  %t1397 = select i1 %t1396, i8* %t1395, i8* %t1394
  %t1398 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1399 = icmp eq i32 %t1393, 1
  %t1400 = select i1 %t1399, i8* %t1398, i8* %t1397
  %t1401 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1402 = icmp eq i32 %t1393, 2
  %t1403 = select i1 %t1402, i8* %t1401, i8* %t1400
  %t1404 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1405 = icmp eq i32 %t1393, 3
  %t1406 = select i1 %t1405, i8* %t1404, i8* %t1403
  %t1407 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1408 = icmp eq i32 %t1393, 4
  %t1409 = select i1 %t1408, i8* %t1407, i8* %t1406
  %t1410 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1411 = icmp eq i32 %t1393, 5
  %t1412 = select i1 %t1411, i8* %t1410, i8* %t1409
  %t1413 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1414 = icmp eq i32 %t1393, 6
  %t1415 = select i1 %t1414, i8* %t1413, i8* %t1412
  %t1416 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1417 = icmp eq i32 %t1393, 7
  %t1418 = select i1 %t1417, i8* %t1416, i8* %t1415
  %t1419 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1420 = icmp eq i32 %t1393, 8
  %t1421 = select i1 %t1420, i8* %t1419, i8* %t1418
  %t1422 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1423 = icmp eq i32 %t1393, 9
  %t1424 = select i1 %t1423, i8* %t1422, i8* %t1421
  %t1425 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1426 = icmp eq i32 %t1393, 10
  %t1427 = select i1 %t1426, i8* %t1425, i8* %t1424
  %t1428 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1429 = icmp eq i32 %t1393, 11
  %t1430 = select i1 %t1429, i8* %t1428, i8* %t1427
  %t1431 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1432 = icmp eq i32 %t1393, 12
  %t1433 = select i1 %t1432, i8* %t1431, i8* %t1430
  %t1434 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1435 = icmp eq i32 %t1393, 13
  %t1436 = select i1 %t1435, i8* %t1434, i8* %t1433
  %t1437 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1438 = icmp eq i32 %t1393, 14
  %t1439 = select i1 %t1438, i8* %t1437, i8* %t1436
  %t1440 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1441 = icmp eq i32 %t1393, 15
  %t1442 = select i1 %t1441, i8* %t1440, i8* %t1439
  %t1443 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1444 = icmp eq i32 %t1393, 16
  %t1445 = select i1 %t1444, i8* %t1443, i8* %t1442
  %t1446 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1447 = icmp eq i32 %t1393, 17
  %t1448 = select i1 %t1447, i8* %t1446, i8* %t1445
  %t1449 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1450 = icmp eq i32 %t1393, 18
  %t1451 = select i1 %t1450, i8* %t1449, i8* %t1448
  %t1452 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1453 = icmp eq i32 %t1393, 19
  %t1454 = select i1 %t1453, i8* %t1452, i8* %t1451
  %t1455 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1456 = icmp eq i32 %t1393, 20
  %t1457 = select i1 %t1456, i8* %t1455, i8* %t1454
  %t1458 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1459 = icmp eq i32 %t1393, 21
  %t1460 = select i1 %t1459, i8* %t1458, i8* %t1457
  %t1461 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1462 = icmp eq i32 %t1393, 22
  %t1463 = select i1 %t1462, i8* %t1461, i8* %t1460
  %s1464 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h196308685, i32 0, i32 0
  %t1465 = icmp eq i8* %t1463, %s1464
  br i1 %t1465, label %then34, label %merge35
then34:
  %t1466 = call %NativeState @emit_match(%NativeState %state, %Statement %statement)
  ret %NativeState %t1466
merge35:
  %t1467 = extractvalue %Statement %statement, 0
  %t1468 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1469 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1470 = icmp eq i32 %t1467, 0
  %t1471 = select i1 %t1470, i8* %t1469, i8* %t1468
  %t1472 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1473 = icmp eq i32 %t1467, 1
  %t1474 = select i1 %t1473, i8* %t1472, i8* %t1471
  %t1475 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1476 = icmp eq i32 %t1467, 2
  %t1477 = select i1 %t1476, i8* %t1475, i8* %t1474
  %t1478 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1479 = icmp eq i32 %t1467, 3
  %t1480 = select i1 %t1479, i8* %t1478, i8* %t1477
  %t1481 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1482 = icmp eq i32 %t1467, 4
  %t1483 = select i1 %t1482, i8* %t1481, i8* %t1480
  %t1484 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1485 = icmp eq i32 %t1467, 5
  %t1486 = select i1 %t1485, i8* %t1484, i8* %t1483
  %t1487 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1488 = icmp eq i32 %t1467, 6
  %t1489 = select i1 %t1488, i8* %t1487, i8* %t1486
  %t1490 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1491 = icmp eq i32 %t1467, 7
  %t1492 = select i1 %t1491, i8* %t1490, i8* %t1489
  %t1493 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1494 = icmp eq i32 %t1467, 8
  %t1495 = select i1 %t1494, i8* %t1493, i8* %t1492
  %t1496 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1497 = icmp eq i32 %t1467, 9
  %t1498 = select i1 %t1497, i8* %t1496, i8* %t1495
  %t1499 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1500 = icmp eq i32 %t1467, 10
  %t1501 = select i1 %t1500, i8* %t1499, i8* %t1498
  %t1502 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1503 = icmp eq i32 %t1467, 11
  %t1504 = select i1 %t1503, i8* %t1502, i8* %t1501
  %t1505 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1506 = icmp eq i32 %t1467, 12
  %t1507 = select i1 %t1506, i8* %t1505, i8* %t1504
  %t1508 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1509 = icmp eq i32 %t1467, 13
  %t1510 = select i1 %t1509, i8* %t1508, i8* %t1507
  %t1511 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1512 = icmp eq i32 %t1467, 14
  %t1513 = select i1 %t1512, i8* %t1511, i8* %t1510
  %t1514 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1515 = icmp eq i32 %t1467, 15
  %t1516 = select i1 %t1515, i8* %t1514, i8* %t1513
  %t1517 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1518 = icmp eq i32 %t1467, 16
  %t1519 = select i1 %t1518, i8* %t1517, i8* %t1516
  %t1520 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1521 = icmp eq i32 %t1467, 17
  %t1522 = select i1 %t1521, i8* %t1520, i8* %t1519
  %t1523 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1524 = icmp eq i32 %t1467, 18
  %t1525 = select i1 %t1524, i8* %t1523, i8* %t1522
  %t1526 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1527 = icmp eq i32 %t1467, 19
  %t1528 = select i1 %t1527, i8* %t1526, i8* %t1525
  %t1529 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1530 = icmp eq i32 %t1467, 20
  %t1531 = select i1 %t1530, i8* %t1529, i8* %t1528
  %t1532 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1533 = icmp eq i32 %t1467, 21
  %t1534 = select i1 %t1533, i8* %t1532, i8* %t1531
  %t1535 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1536 = icmp eq i32 %t1467, 22
  %t1537 = select i1 %t1536, i8* %t1535, i8* %t1534
  %s1538 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1678412334, i32 0, i32 0
  %t1539 = icmp eq i8* %t1537, %s1538
  br i1 %t1539, label %then36, label %merge37
then36:
  %t1540 = call %NativeState @emit_loop(%NativeState %state, %Statement %statement)
  ret %NativeState %t1540
merge37:
  %t1541 = extractvalue %Statement %statement, 0
  %t1542 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1543 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1544 = icmp eq i32 %t1541, 0
  %t1545 = select i1 %t1544, i8* %t1543, i8* %t1542
  %t1546 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1547 = icmp eq i32 %t1541, 1
  %t1548 = select i1 %t1547, i8* %t1546, i8* %t1545
  %t1549 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1550 = icmp eq i32 %t1541, 2
  %t1551 = select i1 %t1550, i8* %t1549, i8* %t1548
  %t1552 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1553 = icmp eq i32 %t1541, 3
  %t1554 = select i1 %t1553, i8* %t1552, i8* %t1551
  %t1555 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1556 = icmp eq i32 %t1541, 4
  %t1557 = select i1 %t1556, i8* %t1555, i8* %t1554
  %t1558 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1559 = icmp eq i32 %t1541, 5
  %t1560 = select i1 %t1559, i8* %t1558, i8* %t1557
  %t1561 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1562 = icmp eq i32 %t1541, 6
  %t1563 = select i1 %t1562, i8* %t1561, i8* %t1560
  %t1564 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1565 = icmp eq i32 %t1541, 7
  %t1566 = select i1 %t1565, i8* %t1564, i8* %t1563
  %t1567 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1568 = icmp eq i32 %t1541, 8
  %t1569 = select i1 %t1568, i8* %t1567, i8* %t1566
  %t1570 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1571 = icmp eq i32 %t1541, 9
  %t1572 = select i1 %t1571, i8* %t1570, i8* %t1569
  %t1573 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1574 = icmp eq i32 %t1541, 10
  %t1575 = select i1 %t1574, i8* %t1573, i8* %t1572
  %t1576 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1577 = icmp eq i32 %t1541, 11
  %t1578 = select i1 %t1577, i8* %t1576, i8* %t1575
  %t1579 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1580 = icmp eq i32 %t1541, 12
  %t1581 = select i1 %t1580, i8* %t1579, i8* %t1578
  %t1582 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1583 = icmp eq i32 %t1541, 13
  %t1584 = select i1 %t1583, i8* %t1582, i8* %t1581
  %t1585 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1586 = icmp eq i32 %t1541, 14
  %t1587 = select i1 %t1586, i8* %t1585, i8* %t1584
  %t1588 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1589 = icmp eq i32 %t1541, 15
  %t1590 = select i1 %t1589, i8* %t1588, i8* %t1587
  %t1591 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1592 = icmp eq i32 %t1541, 16
  %t1593 = select i1 %t1592, i8* %t1591, i8* %t1590
  %t1594 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1595 = icmp eq i32 %t1541, 17
  %t1596 = select i1 %t1595, i8* %t1594, i8* %t1593
  %t1597 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1598 = icmp eq i32 %t1541, 18
  %t1599 = select i1 %t1598, i8* %t1597, i8* %t1596
  %t1600 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1601 = icmp eq i32 %t1541, 19
  %t1602 = select i1 %t1601, i8* %t1600, i8* %t1599
  %t1603 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1604 = icmp eq i32 %t1541, 20
  %t1605 = select i1 %t1604, i8* %t1603, i8* %t1602
  %t1606 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1607 = icmp eq i32 %t1541, 21
  %t1608 = select i1 %t1607, i8* %t1606, i8* %t1605
  %t1609 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1610 = icmp eq i32 %t1541, 22
  %t1611 = select i1 %t1610, i8* %t1609, i8* %t1608
  %s1612 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h88846349, i32 0, i32 0
  %t1613 = icmp eq i8* %t1611, %s1612
  br i1 %t1613, label %then38, label %merge39
then38:
  %s1614 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1958778164, i32 0, i32 0
  %t1615 = call %NativeState @state_emit_line(%NativeState %state, i8* %s1614)
  ret %NativeState %t1615
merge39:
  %t1616 = extractvalue %Statement %statement, 0
  %t1617 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1618 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1619 = icmp eq i32 %t1616, 0
  %t1620 = select i1 %t1619, i8* %t1618, i8* %t1617
  %t1621 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1622 = icmp eq i32 %t1616, 1
  %t1623 = select i1 %t1622, i8* %t1621, i8* %t1620
  %t1624 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1625 = icmp eq i32 %t1616, 2
  %t1626 = select i1 %t1625, i8* %t1624, i8* %t1623
  %t1627 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1628 = icmp eq i32 %t1616, 3
  %t1629 = select i1 %t1628, i8* %t1627, i8* %t1626
  %t1630 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1631 = icmp eq i32 %t1616, 4
  %t1632 = select i1 %t1631, i8* %t1630, i8* %t1629
  %t1633 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1634 = icmp eq i32 %t1616, 5
  %t1635 = select i1 %t1634, i8* %t1633, i8* %t1632
  %t1636 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1637 = icmp eq i32 %t1616, 6
  %t1638 = select i1 %t1637, i8* %t1636, i8* %t1635
  %t1639 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1640 = icmp eq i32 %t1616, 7
  %t1641 = select i1 %t1640, i8* %t1639, i8* %t1638
  %t1642 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1643 = icmp eq i32 %t1616, 8
  %t1644 = select i1 %t1643, i8* %t1642, i8* %t1641
  %t1645 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1646 = icmp eq i32 %t1616, 9
  %t1647 = select i1 %t1646, i8* %t1645, i8* %t1644
  %t1648 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1649 = icmp eq i32 %t1616, 10
  %t1650 = select i1 %t1649, i8* %t1648, i8* %t1647
  %t1651 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1652 = icmp eq i32 %t1616, 11
  %t1653 = select i1 %t1652, i8* %t1651, i8* %t1650
  %t1654 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1655 = icmp eq i32 %t1616, 12
  %t1656 = select i1 %t1655, i8* %t1654, i8* %t1653
  %t1657 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1658 = icmp eq i32 %t1616, 13
  %t1659 = select i1 %t1658, i8* %t1657, i8* %t1656
  %t1660 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1661 = icmp eq i32 %t1616, 14
  %t1662 = select i1 %t1661, i8* %t1660, i8* %t1659
  %t1663 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1664 = icmp eq i32 %t1616, 15
  %t1665 = select i1 %t1664, i8* %t1663, i8* %t1662
  %t1666 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1667 = icmp eq i32 %t1616, 16
  %t1668 = select i1 %t1667, i8* %t1666, i8* %t1665
  %t1669 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1670 = icmp eq i32 %t1616, 17
  %t1671 = select i1 %t1670, i8* %t1669, i8* %t1668
  %t1672 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1673 = icmp eq i32 %t1616, 18
  %t1674 = select i1 %t1673, i8* %t1672, i8* %t1671
  %t1675 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1676 = icmp eq i32 %t1616, 19
  %t1677 = select i1 %t1676, i8* %t1675, i8* %t1674
  %t1678 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1679 = icmp eq i32 %t1616, 20
  %t1680 = select i1 %t1679, i8* %t1678, i8* %t1677
  %t1681 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1682 = icmp eq i32 %t1616, 21
  %t1683 = select i1 %t1682, i8* %t1681, i8* %t1680
  %t1684 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1685 = icmp eq i32 %t1616, 22
  %t1686 = select i1 %t1685, i8* %t1684, i8* %t1683
  %s1687 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1998778048, i32 0, i32 0
  %t1688 = icmp eq i8* %t1686, %s1687
  br i1 %t1688, label %then40, label %merge41
then40:
  %s1689 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h528348603, i32 0, i32 0
  %t1690 = call %NativeState @state_emit_line(%NativeState %state, i8* %s1689)
  ret %NativeState %t1690
merge41:
  %t1691 = extractvalue %Statement %statement, 0
  %t1692 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1693 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1694 = icmp eq i32 %t1691, 0
  %t1695 = select i1 %t1694, i8* %t1693, i8* %t1692
  %t1696 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1697 = icmp eq i32 %t1691, 1
  %t1698 = select i1 %t1697, i8* %t1696, i8* %t1695
  %t1699 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1700 = icmp eq i32 %t1691, 2
  %t1701 = select i1 %t1700, i8* %t1699, i8* %t1698
  %t1702 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1703 = icmp eq i32 %t1691, 3
  %t1704 = select i1 %t1703, i8* %t1702, i8* %t1701
  %t1705 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1706 = icmp eq i32 %t1691, 4
  %t1707 = select i1 %t1706, i8* %t1705, i8* %t1704
  %t1708 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1709 = icmp eq i32 %t1691, 5
  %t1710 = select i1 %t1709, i8* %t1708, i8* %t1707
  %t1711 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1712 = icmp eq i32 %t1691, 6
  %t1713 = select i1 %t1712, i8* %t1711, i8* %t1710
  %t1714 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1715 = icmp eq i32 %t1691, 7
  %t1716 = select i1 %t1715, i8* %t1714, i8* %t1713
  %t1717 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1718 = icmp eq i32 %t1691, 8
  %t1719 = select i1 %t1718, i8* %t1717, i8* %t1716
  %t1720 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1721 = icmp eq i32 %t1691, 9
  %t1722 = select i1 %t1721, i8* %t1720, i8* %t1719
  %t1723 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1724 = icmp eq i32 %t1691, 10
  %t1725 = select i1 %t1724, i8* %t1723, i8* %t1722
  %t1726 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1727 = icmp eq i32 %t1691, 11
  %t1728 = select i1 %t1727, i8* %t1726, i8* %t1725
  %t1729 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1730 = icmp eq i32 %t1691, 12
  %t1731 = select i1 %t1730, i8* %t1729, i8* %t1728
  %t1732 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1733 = icmp eq i32 %t1691, 13
  %t1734 = select i1 %t1733, i8* %t1732, i8* %t1731
  %t1735 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1736 = icmp eq i32 %t1691, 14
  %t1737 = select i1 %t1736, i8* %t1735, i8* %t1734
  %t1738 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1739 = icmp eq i32 %t1691, 15
  %t1740 = select i1 %t1739, i8* %t1738, i8* %t1737
  %t1741 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1742 = icmp eq i32 %t1691, 16
  %t1743 = select i1 %t1742, i8* %t1741, i8* %t1740
  %t1744 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1745 = icmp eq i32 %t1691, 17
  %t1746 = select i1 %t1745, i8* %t1744, i8* %t1743
  %t1747 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1748 = icmp eq i32 %t1691, 18
  %t1749 = select i1 %t1748, i8* %t1747, i8* %t1746
  %t1750 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1751 = icmp eq i32 %t1691, 19
  %t1752 = select i1 %t1751, i8* %t1750, i8* %t1749
  %t1753 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1754 = icmp eq i32 %t1691, 20
  %t1755 = select i1 %t1754, i8* %t1753, i8* %t1752
  %t1756 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1757 = icmp eq i32 %t1691, 21
  %t1758 = select i1 %t1757, i8* %t1756, i8* %t1755
  %t1759 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1760 = icmp eq i32 %t1691, 22
  %t1761 = select i1 %t1760, i8* %t1759, i8* %t1758
  %s1762 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1566780570, i32 0, i32 0
  %t1763 = icmp eq i8* %t1761, %s1762
  br i1 %t1763, label %then42, label %merge43
then42:
  %t1764 = call %NativeState @emit_if(%NativeState %state, %Statement %statement)
  ret %NativeState %t1764
merge43:
  %t1765 = extractvalue %Statement %statement, 0
  %t1766 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1767 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1768 = icmp eq i32 %t1765, 0
  %t1769 = select i1 %t1768, i8* %t1767, i8* %t1766
  %t1770 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1771 = icmp eq i32 %t1765, 1
  %t1772 = select i1 %t1771, i8* %t1770, i8* %t1769
  %t1773 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1774 = icmp eq i32 %t1765, 2
  %t1775 = select i1 %t1774, i8* %t1773, i8* %t1772
  %t1776 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1777 = icmp eq i32 %t1765, 3
  %t1778 = select i1 %t1777, i8* %t1776, i8* %t1775
  %t1779 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1780 = icmp eq i32 %t1765, 4
  %t1781 = select i1 %t1780, i8* %t1779, i8* %t1778
  %t1782 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1783 = icmp eq i32 %t1765, 5
  %t1784 = select i1 %t1783, i8* %t1782, i8* %t1781
  %t1785 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1786 = icmp eq i32 %t1765, 6
  %t1787 = select i1 %t1786, i8* %t1785, i8* %t1784
  %t1788 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1789 = icmp eq i32 %t1765, 7
  %t1790 = select i1 %t1789, i8* %t1788, i8* %t1787
  %t1791 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1792 = icmp eq i32 %t1765, 8
  %t1793 = select i1 %t1792, i8* %t1791, i8* %t1790
  %t1794 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1795 = icmp eq i32 %t1765, 9
  %t1796 = select i1 %t1795, i8* %t1794, i8* %t1793
  %t1797 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1798 = icmp eq i32 %t1765, 10
  %t1799 = select i1 %t1798, i8* %t1797, i8* %t1796
  %t1800 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1801 = icmp eq i32 %t1765, 11
  %t1802 = select i1 %t1801, i8* %t1800, i8* %t1799
  %t1803 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1804 = icmp eq i32 %t1765, 12
  %t1805 = select i1 %t1804, i8* %t1803, i8* %t1802
  %t1806 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1807 = icmp eq i32 %t1765, 13
  %t1808 = select i1 %t1807, i8* %t1806, i8* %t1805
  %t1809 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1810 = icmp eq i32 %t1765, 14
  %t1811 = select i1 %t1810, i8* %t1809, i8* %t1808
  %t1812 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1813 = icmp eq i32 %t1765, 15
  %t1814 = select i1 %t1813, i8* %t1812, i8* %t1811
  %t1815 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1816 = icmp eq i32 %t1765, 16
  %t1817 = select i1 %t1816, i8* %t1815, i8* %t1814
  %t1818 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1819 = icmp eq i32 %t1765, 17
  %t1820 = select i1 %t1819, i8* %t1818, i8* %t1817
  %t1821 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1822 = icmp eq i32 %t1765, 18
  %t1823 = select i1 %t1822, i8* %t1821, i8* %t1820
  %t1824 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1825 = icmp eq i32 %t1765, 19
  %t1826 = select i1 %t1825, i8* %t1824, i8* %t1823
  %t1827 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1828 = icmp eq i32 %t1765, 20
  %t1829 = select i1 %t1828, i8* %t1827, i8* %t1826
  %t1830 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1831 = icmp eq i32 %t1765, 21
  %t1832 = select i1 %t1831, i8* %t1830, i8* %t1829
  %t1833 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1834 = icmp eq i32 %t1765, 22
  %t1835 = select i1 %t1834, i8* %t1833, i8* %t1832
  %s1836 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1613933868, i32 0, i32 0
  %t1837 = icmp eq i8* %t1835, %s1836
  br i1 %t1837, label %then44, label %merge45
then44:
  %t1838 = call %NativeState @emit_return(%NativeState %state, %Statement %statement)
  ret %NativeState %t1838
merge45:
  %t1839 = extractvalue %Statement %statement, 0
  %t1840 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1841 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1842 = icmp eq i32 %t1839, 0
  %t1843 = select i1 %t1842, i8* %t1841, i8* %t1840
  %t1844 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1845 = icmp eq i32 %t1839, 1
  %t1846 = select i1 %t1845, i8* %t1844, i8* %t1843
  %t1847 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1848 = icmp eq i32 %t1839, 2
  %t1849 = select i1 %t1848, i8* %t1847, i8* %t1846
  %t1850 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1851 = icmp eq i32 %t1839, 3
  %t1852 = select i1 %t1851, i8* %t1850, i8* %t1849
  %t1853 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1854 = icmp eq i32 %t1839, 4
  %t1855 = select i1 %t1854, i8* %t1853, i8* %t1852
  %t1856 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1857 = icmp eq i32 %t1839, 5
  %t1858 = select i1 %t1857, i8* %t1856, i8* %t1855
  %t1859 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1860 = icmp eq i32 %t1839, 6
  %t1861 = select i1 %t1860, i8* %t1859, i8* %t1858
  %t1862 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1863 = icmp eq i32 %t1839, 7
  %t1864 = select i1 %t1863, i8* %t1862, i8* %t1861
  %t1865 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1866 = icmp eq i32 %t1839, 8
  %t1867 = select i1 %t1866, i8* %t1865, i8* %t1864
  %t1868 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1869 = icmp eq i32 %t1839, 9
  %t1870 = select i1 %t1869, i8* %t1868, i8* %t1867
  %t1871 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1872 = icmp eq i32 %t1839, 10
  %t1873 = select i1 %t1872, i8* %t1871, i8* %t1870
  %t1874 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1875 = icmp eq i32 %t1839, 11
  %t1876 = select i1 %t1875, i8* %t1874, i8* %t1873
  %t1877 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1878 = icmp eq i32 %t1839, 12
  %t1879 = select i1 %t1878, i8* %t1877, i8* %t1876
  %t1880 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1881 = icmp eq i32 %t1839, 13
  %t1882 = select i1 %t1881, i8* %t1880, i8* %t1879
  %t1883 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1884 = icmp eq i32 %t1839, 14
  %t1885 = select i1 %t1884, i8* %t1883, i8* %t1882
  %t1886 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1887 = icmp eq i32 %t1839, 15
  %t1888 = select i1 %t1887, i8* %t1886, i8* %t1885
  %t1889 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1890 = icmp eq i32 %t1839, 16
  %t1891 = select i1 %t1890, i8* %t1889, i8* %t1888
  %t1892 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1893 = icmp eq i32 %t1839, 17
  %t1894 = select i1 %t1893, i8* %t1892, i8* %t1891
  %t1895 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1896 = icmp eq i32 %t1839, 18
  %t1897 = select i1 %t1896, i8* %t1895, i8* %t1894
  %t1898 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1899 = icmp eq i32 %t1839, 19
  %t1900 = select i1 %t1899, i8* %t1898, i8* %t1897
  %t1901 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1902 = icmp eq i32 %t1839, 20
  %t1903 = select i1 %t1902, i8* %t1901, i8* %t1900
  %t1904 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1905 = icmp eq i32 %t1839, 21
  %t1906 = select i1 %t1905, i8* %t1904, i8* %t1903
  %t1907 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1908 = icmp eq i32 %t1839, 22
  %t1909 = select i1 %t1908, i8* %t1907, i8* %t1906
  %s1910 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h868168677, i32 0, i32 0
  %t1911 = icmp eq i8* %t1909, %s1910
  br i1 %t1911, label %then46, label %merge47
then46:
  %t1912 = call %NativeState @emit_expression_statement(%NativeState %state, %Statement %statement)
  ret %NativeState %t1912
merge47:
  %s1913 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h1281499904, i32 0, i32 0
  %t1914 = extractvalue %Statement %statement, 0
  %t1915 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1916 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1917 = icmp eq i32 %t1914, 0
  %t1918 = select i1 %t1917, i8* %t1916, i8* %t1915
  %t1919 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1920 = icmp eq i32 %t1914, 1
  %t1921 = select i1 %t1920, i8* %t1919, i8* %t1918
  %t1922 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1923 = icmp eq i32 %t1914, 2
  %t1924 = select i1 %t1923, i8* %t1922, i8* %t1921
  %t1925 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1926 = icmp eq i32 %t1914, 3
  %t1927 = select i1 %t1926, i8* %t1925, i8* %t1924
  %t1928 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1929 = icmp eq i32 %t1914, 4
  %t1930 = select i1 %t1929, i8* %t1928, i8* %t1927
  %t1931 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1932 = icmp eq i32 %t1914, 5
  %t1933 = select i1 %t1932, i8* %t1931, i8* %t1930
  %t1934 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1935 = icmp eq i32 %t1914, 6
  %t1936 = select i1 %t1935, i8* %t1934, i8* %t1933
  %t1937 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1938 = icmp eq i32 %t1914, 7
  %t1939 = select i1 %t1938, i8* %t1937, i8* %t1936
  %t1940 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1941 = icmp eq i32 %t1914, 8
  %t1942 = select i1 %t1941, i8* %t1940, i8* %t1939
  %t1943 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1944 = icmp eq i32 %t1914, 9
  %t1945 = select i1 %t1944, i8* %t1943, i8* %t1942
  %t1946 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1947 = icmp eq i32 %t1914, 10
  %t1948 = select i1 %t1947, i8* %t1946, i8* %t1945
  %t1949 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1950 = icmp eq i32 %t1914, 11
  %t1951 = select i1 %t1950, i8* %t1949, i8* %t1948
  %t1952 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1953 = icmp eq i32 %t1914, 12
  %t1954 = select i1 %t1953, i8* %t1952, i8* %t1951
  %t1955 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1956 = icmp eq i32 %t1914, 13
  %t1957 = select i1 %t1956, i8* %t1955, i8* %t1954
  %t1958 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1959 = icmp eq i32 %t1914, 14
  %t1960 = select i1 %t1959, i8* %t1958, i8* %t1957
  %t1961 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1962 = icmp eq i32 %t1914, 15
  %t1963 = select i1 %t1962, i8* %t1961, i8* %t1960
  %t1964 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1965 = icmp eq i32 %t1914, 16
  %t1966 = select i1 %t1965, i8* %t1964, i8* %t1963
  %t1967 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1968 = icmp eq i32 %t1914, 17
  %t1969 = select i1 %t1968, i8* %t1967, i8* %t1966
  %t1970 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1971 = icmp eq i32 %t1914, 18
  %t1972 = select i1 %t1971, i8* %t1970, i8* %t1969
  %t1973 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1974 = icmp eq i32 %t1914, 19
  %t1975 = select i1 %t1974, i8* %t1973, i8* %t1972
  %t1976 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1977 = icmp eq i32 %t1914, 20
  %t1978 = select i1 %t1977, i8* %t1976, i8* %t1975
  %t1979 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1980 = icmp eq i32 %t1914, 21
  %t1981 = select i1 %t1980, i8* %t1979, i8* %t1978
  %t1982 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1983 = icmp eq i32 %t1914, 22
  %t1984 = select i1 %t1983, i8* %t1982, i8* %t1981
  %t1985 = call i8* @sailfin_runtime_string_concat(i8* %s1913, i8* %t1984)
  %t1986 = load i8, i8* %t1985
  %t1987 = add i8 %t1986, 96
  store i8 %t1987, i8* %l4
  %t1988 = load i8, i8* %l4
  %t1989 = alloca [2 x i8], align 1
  %t1990 = getelementptr [2 x i8], [2 x i8]* %t1989, i32 0, i32 0
  store i8 %t1988, i8* %t1990
  %t1991 = getelementptr [2 x i8], [2 x i8]* %t1989, i32 0, i32 1
  store i8 0, i8* %t1991
  %t1992 = getelementptr [2 x i8], [2 x i8]* %t1989, i32 0, i32 0
  %t1993 = call %NativeState @state_add_diagnostic(%NativeState %state, i8* %t1992)
  ret %NativeState %t1993
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
  call void @sailfin_runtime_bounds_check(i64 %t17, i64 %t20)
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
  call void @sailfin_runtime_bounds_check(i64 %t26, i64 %t29)
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
  %t44 = load double, double* %l1
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s46 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t47 = call i8* @join_with_separator({ i8**, i64 }* %t45, i8* %s46)
  ret i8* %t47
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
  call void @sailfin_runtime_bounds_check(i64 %t17, i64 %t20)
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
  call void @sailfin_runtime_bounds_check(i64 %t26, i64 %t29)
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
  %t44 = load double, double* %l1
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s46 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t47 = call i8* @join_with_separator({ i8**, i64 }* %t45, i8* %s46)
  ret i8* %t47
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
  %s5 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175713983, i32 0, i32 0
  %t6 = call i8* @sailfin_runtime_string_concat(i8* %name, i8* %s5)
  %t7 = call i8* @sailfin_runtime_string_concat(i8* %t6, i8* %alias)
  ret i8* %t7
}

define %NativeState @emit_span_if_present(%NativeState %state, %SourceSpan* %span) {
entry:
  %t0 = icmp eq %SourceSpan* %span, null
  br i1 %t0, label %then0, label %merge1
then0:
  ret %NativeState %state
merge1:
  %s1 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1830497006, i32 0, i32 0
  %t2 = load %SourceSpan, %SourceSpan* %span
  %t3 = call i8* @format_span(%SourceSpan %t2)
  %t4 = call i8* @sailfin_runtime_string_concat(i8* %s1, i8* %t3)
  %t5 = call %NativeState @state_emit_line(%NativeState %state, i8* %t4)
  ret %NativeState %t5
}

define %NativeState @emit_initializer_span_if_present(%NativeState %state, %SourceSpan* %span) {
entry:
  %t0 = icmp eq %SourceSpan* %span, null
  br i1 %t0, label %then0, label %merge1
then0:
  ret %NativeState %state
merge1:
  %s1 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1513373193, i32 0, i32 0
  %t2 = load %SourceSpan, %SourceSpan* %span
  %t3 = call i8* @format_span(%SourceSpan %t2)
  %t4 = call i8* @sailfin_runtime_string_concat(i8* %s1, i8* %t3)
  %t5 = call %NativeState @state_emit_line(%NativeState %state, i8* %t4)
  ret %NativeState %t5
}

define i8* @append_optional_type_annotation(i8* %line, %TypeAnnotation* %annotation) {
entry:
  %t0 = icmp eq %TypeAnnotation* %annotation, null
  br i1 %t0, label %then0, label %merge1
then0:
  ret i8* %line
merge1:
  %s1 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087687812, i32 0, i32 0
  %t2 = call i8* @sailfin_runtime_string_concat(i8* %line, i8* %s1)
  %t3 = getelementptr %TypeAnnotation, %TypeAnnotation* %annotation, i32 0, i32 0
  %t4 = load i8*, i8** %t3
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t2, i8* %t4)
  ret i8* %t5
}

define i8* @append_optional_initializer(i8* %line, %Expression* %initializer) {
entry:
  %t0 = icmp eq %Expression* %initializer, null
  br i1 %t0, label %then0, label %merge1
then0:
  ret i8* %line
merge1:
  %s1 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t2 = call i8* @sailfin_runtime_string_concat(i8* %line, i8* %s1)
  %t3 = load %Expression, %Expression* %initializer
  %t4 = call i8* @format_expression(%Expression %t3)
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t2, i8* %t4)
  ret i8* %t5
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
  %s35 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2064124065, i32 0, i32 0
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
  %s48 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t49 = call i8* @sailfin_runtime_string_concat(i8* %t47, i8* %s48)
  store i8* %t49, i8** %l1
  %t50 = load i8*, i8** %l1
  br label %merge1
merge1:
  %t51 = phi i8* [ %t50, %then0 ], [ %t46, %entry ]
  store i8* %t51, i8** %l1
  %t52 = load i8*, i8** %l1
  %t53 = extractvalue %Statement %statement, 0
  %t54 = alloca %Statement
  store %Statement %statement, %Statement* %t54
  %t55 = getelementptr inbounds %Statement, %Statement* %t54, i32 0, i32 1
  %t56 = bitcast [48 x i8]* %t55 to i8*
  %t57 = bitcast i8* %t56 to i8**
  %t58 = load i8*, i8** %t57
  %t59 = icmp eq i32 %t53, 2
  %t60 = select i1 %t59, i8* %t58, i8* null
  %t61 = getelementptr inbounds %Statement, %Statement* %t54, i32 0, i32 1
  %t62 = bitcast [48 x i8]* %t61 to i8*
  %t63 = bitcast i8* %t62 to i8**
  %t64 = load i8*, i8** %t63
  %t65 = icmp eq i32 %t53, 3
  %t66 = select i1 %t65, i8* %t64, i8* %t60
  %t67 = getelementptr inbounds %Statement, %Statement* %t54, i32 0, i32 1
  %t68 = bitcast [40 x i8]* %t67 to i8*
  %t69 = bitcast i8* %t68 to i8**
  %t70 = load i8*, i8** %t69
  %t71 = icmp eq i32 %t53, 6
  %t72 = select i1 %t71, i8* %t70, i8* %t66
  %t73 = getelementptr inbounds %Statement, %Statement* %t54, i32 0, i32 1
  %t74 = bitcast [56 x i8]* %t73 to i8*
  %t75 = bitcast i8* %t74 to i8**
  %t76 = load i8*, i8** %t75
  %t77 = icmp eq i32 %t53, 8
  %t78 = select i1 %t77, i8* %t76, i8* %t72
  %t79 = getelementptr inbounds %Statement, %Statement* %t54, i32 0, i32 1
  %t80 = bitcast [40 x i8]* %t79 to i8*
  %t81 = bitcast i8* %t80 to i8**
  %t82 = load i8*, i8** %t81
  %t83 = icmp eq i32 %t53, 9
  %t84 = select i1 %t83, i8* %t82, i8* %t78
  %t85 = getelementptr inbounds %Statement, %Statement* %t54, i32 0, i32 1
  %t86 = bitcast [40 x i8]* %t85 to i8*
  %t87 = bitcast i8* %t86 to i8**
  %t88 = load i8*, i8** %t87
  %t89 = icmp eq i32 %t53, 10
  %t90 = select i1 %t89, i8* %t88, i8* %t84
  %t91 = getelementptr inbounds %Statement, %Statement* %t54, i32 0, i32 1
  %t92 = bitcast [40 x i8]* %t91 to i8*
  %t93 = bitcast i8* %t92 to i8**
  %t94 = load i8*, i8** %t93
  %t95 = icmp eq i32 %t53, 11
  %t96 = select i1 %t95, i8* %t94, i8* %t90
  %t97 = call i8* @sailfin_runtime_string_concat(i8* %t52, i8* %t96)
  store i8* %t97, i8** %l1
  %t98 = load i8*, i8** %l1
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
  %t108 = call i8* @append_optional_type_annotation(i8* %t98, %TypeAnnotation* %t107)
  store i8* %t108, i8** %l1
  %t109 = load i8*, i8** %l1
  %t110 = extractvalue %Statement %statement, 0
  %t111 = alloca %Statement
  store %Statement %statement, %Statement* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t111, i32 0, i32 1
  %t113 = bitcast [48 x i8]* %t112 to i8*
  %t114 = getelementptr inbounds i8, i8* %t113, i64 24
  %t115 = bitcast i8* %t114 to %Expression**
  %t116 = load %Expression*, %Expression** %t115
  %t117 = icmp eq i32 %t110, 2
  %t118 = select i1 %t117, %Expression* %t116, %Expression* null
  %t119 = call i8* @append_optional_initializer(i8* %t109, %Expression* %t118)
  store i8* %t119, i8** %l1
  %t120 = load %NativeState, %NativeState* %l0
  %t121 = load i8*, i8** %l1
  %t122 = call %NativeState @state_emit_line(%NativeState %t120, i8* %t121)
  ret %NativeState %t122
}

define %NativeState @emit_function(%NativeState %state, %FunctionSignature %signature, %Block %body, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %NativeState
  %t0 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %decorators)
  store %NativeState %t0, %NativeState* %l0
  %t1 = load %NativeState, %NativeState* %l0
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h192491117, i32 0, i32 0
  %t3 = call i8* @format_function_signature(%FunctionSignature %signature)
  %t4 = call i8* @sailfin_runtime_string_concat(i8* %s2, i8* %t3)
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
  %s19 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1280331335, i32 0, i32 0
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
  %s110 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h730819012, i32 0, i32 0
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
  %t132 = call i8* @sailfin_runtime_string_concat(i8* %s110, i8* %t131)
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
  %s244 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h1355144398, i32 0, i32 0
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
  %s110 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1868947418, i32 0, i32 0
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
  %t132 = call i8* @sailfin_runtime_string_concat(i8* %s110, i8* %t131)
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
  %s244 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h580693660, i32 0, i32 0
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
  %s109 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1857240668, i32 0, i32 0
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
  %t155 = call i8* @sailfin_runtime_string_concat(i8* %s109, i8* %t154)
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
  %s178 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087662534, i32 0, i32 0
  %t179 = call i8* @sailfin_runtime_string_concat(i8* %t177, i8* %s178)
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
  %s196 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t197 = call i8* @join_with_separator({ i8**, i64 }* %t195, i8* %s196)
  %t198 = call i8* @sailfin_runtime_string_concat(i8* %t179, i8* %t197)
  %t199 = load i8, i8* %t198
  %t200 = add i8 %t199, 93
  %t201 = alloca [2 x i8], align 1
  %t202 = getelementptr [2 x i8], [2 x i8]* %t201, i32 0, i32 0
  store i8 %t200, i8* %t202
  %t203 = getelementptr [2 x i8], [2 x i8]* %t201, i32 0, i32 1
  store i8 0, i8* %t203
  %t204 = getelementptr [2 x i8], [2 x i8]* %t201, i32 0, i32 0
  store i8* %t204, i8** %l1
  %t205 = load i8*, i8** %l1
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
  %t299 = bitcast i8* %t298 to %Block*
  %t300 = load %Block, %Block* %t299
  %t301 = icmp eq i32 %t294, 4
  %t302 = select i1 %t301, %Block %t300, %Block zeroinitializer
  %t303 = getelementptr inbounds %Statement, %Statement* %t295, i32 0, i32 1
  %t304 = bitcast [24 x i8]* %t303 to i8*
  %t305 = getelementptr inbounds i8, i8* %t304, i64 8
  %t306 = bitcast i8* %t305 to %Block*
  %t307 = load %Block, %Block* %t306
  %t308 = icmp eq i32 %t294, 5
  %t309 = select i1 %t308, %Block %t307, %Block %t302
  %t310 = getelementptr inbounds %Statement, %Statement* %t295, i32 0, i32 1
  %t311 = bitcast [40 x i8]* %t310 to i8*
  %t312 = getelementptr inbounds i8, i8* %t311, i64 16
  %t313 = bitcast i8* %t312 to %Block*
  %t314 = load %Block, %Block* %t313
  %t315 = icmp eq i32 %t294, 6
  %t316 = select i1 %t315, %Block %t314, %Block %t309
  %t317 = getelementptr inbounds %Statement, %Statement* %t295, i32 0, i32 1
  %t318 = bitcast [24 x i8]* %t317 to i8*
  %t319 = getelementptr inbounds i8, i8* %t318, i64 8
  %t320 = bitcast i8* %t319 to %Block*
  %t321 = load %Block, %Block* %t320
  %t322 = icmp eq i32 %t294, 7
  %t323 = select i1 %t322, %Block %t321, %Block %t316
  %t324 = getelementptr inbounds %Statement, %Statement* %t295, i32 0, i32 1
  %t325 = bitcast [40 x i8]* %t324 to i8*
  %t326 = getelementptr inbounds i8, i8* %t325, i64 24
  %t327 = bitcast i8* %t326 to %Block*
  %t328 = load %Block, %Block* %t327
  %t329 = icmp eq i32 %t294, 12
  %t330 = select i1 %t329, %Block %t328, %Block %t323
  %t331 = getelementptr inbounds %Statement, %Statement* %t295, i32 0, i32 1
  %t332 = bitcast [24 x i8]* %t331 to i8*
  %t333 = getelementptr inbounds i8, i8* %t332, i64 8
  %t334 = bitcast i8* %t333 to %Block*
  %t335 = load %Block, %Block* %t334
  %t336 = icmp eq i32 %t294, 13
  %t337 = select i1 %t336, %Block %t335, %Block %t330
  %t338 = getelementptr inbounds %Statement, %Statement* %t295, i32 0, i32 1
  %t339 = bitcast [24 x i8]* %t338 to i8*
  %t340 = getelementptr inbounds i8, i8* %t339, i64 8
  %t341 = bitcast i8* %t340 to %Block*
  %t342 = load %Block, %Block* %t341
  %t343 = icmp eq i32 %t294, 14
  %t344 = select i1 %t343, %Block %t342, %Block %t337
  %t345 = getelementptr inbounds %Statement, %Statement* %t295, i32 0, i32 1
  %t346 = bitcast [16 x i8]* %t345 to i8*
  %t347 = bitcast i8* %t346 to %Block*
  %t348 = load %Block, %Block* %t347
  %t349 = icmp eq i32 %t294, 15
  %t350 = select i1 %t349, %Block %t348, %Block %t344
  %t351 = call %NativeState @emit_block(%NativeState %t293, %Block %t350)
  store %NativeState %t351, %NativeState* %l0
  %t352 = load %NativeState, %NativeState* %l0
  %t353 = call %NativeState @state_pop_indent(%NativeState %t352)
  store %NativeState %t353, %NativeState* %l0
  %t354 = load %NativeState, %NativeState* %l0
  %s355 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h580338910, i32 0, i32 0
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
  %s109 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h1082168422, i32 0, i32 0
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
  %t154 = call i8* @sailfin_runtime_string_concat(i8* %s109, i8* %t153)
  %s155 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087687812, i32 0, i32 0
  %t156 = call i8* @sailfin_runtime_string_concat(i8* %t154, i8* %s155)
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
  %t167 = call i8* @sailfin_runtime_string_concat(i8* %t156, i8* %t166)
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
  %s190 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087662534, i32 0, i32 0
  %t191 = call i8* @sailfin_runtime_string_concat(i8* %t189, i8* %s190)
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
  %s208 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t209 = call i8* @join_with_separator({ i8**, i64 }* %t207, i8* %s208)
  %t210 = call i8* @sailfin_runtime_string_concat(i8* %t191, i8* %t209)
  %t211 = load i8, i8* %t210
  %t212 = add i8 %t211, 93
  %t213 = alloca [2 x i8], align 1
  %t214 = getelementptr [2 x i8], [2 x i8]* %t213, i32 0, i32 0
  store i8 %t212, i8* %t214
  %t215 = getelementptr [2 x i8], [2 x i8]* %t213, i32 0, i32 1
  store i8 0, i8* %t215
  %t216 = getelementptr [2 x i8], [2 x i8]* %t213, i32 0, i32 0
  store i8* %t216, i8** %l1
  %t217 = load i8*, i8** %l1
  br label %merge1
merge1:
  %t218 = phi i8* [ %t217, %then0 ], [ %t188, %entry ]
  store i8* %t218, i8** %l1
  %t219 = load %NativeState, %NativeState* %l0
  %t220 = load i8*, i8** %l1
  %t221 = call %NativeState @state_emit_line(%NativeState %t219, i8* %t220)
  store %NativeState %t221, %NativeState* %l0
  %t222 = load %NativeState, %NativeState* %l0
  %t223 = call %NativeState @state_push_indent(%NativeState %t222)
  store %NativeState %t223, %NativeState* %l0
  %t224 = sitofp i64 0 to double
  store double %t224, double* %l2
  %t225 = load %NativeState, %NativeState* %l0
  %t226 = load i8*, i8** %l1
  %t227 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t282 = phi %NativeState [ %t225, %merge1 ], [ %t280, %loop.latch4 ]
  %t283 = phi double [ %t227, %merge1 ], [ %t281, %loop.latch4 ]
  store %NativeState %t282, %NativeState* %l0
  store double %t283, double* %l2
  br label %loop.body3
loop.body3:
  %t228 = load double, double* %l2
  %t229 = extractvalue %Statement %statement, 0
  %t230 = alloca %Statement
  store %Statement %statement, %Statement* %t230
  %t231 = getelementptr inbounds %Statement, %Statement* %t230, i32 0, i32 1
  %t232 = bitcast [48 x i8]* %t231 to i8*
  %t233 = getelementptr inbounds i8, i8* %t232, i64 24
  %t234 = bitcast i8* %t233 to { %ModelProperty**, i64 }**
  %t235 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t234
  %t236 = icmp eq i32 %t229, 3
  %t237 = select i1 %t236, { %ModelProperty**, i64 }* %t235, { %ModelProperty**, i64 }* null
  %t238 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t237
  %t239 = extractvalue { %ModelProperty**, i64 } %t238, 1
  %t240 = sitofp i64 %t239 to double
  %t241 = fcmp oge double %t228, %t240
  %t242 = load %NativeState, %NativeState* %l0
  %t243 = load i8*, i8** %l1
  %t244 = load double, double* %l2
  br i1 %t241, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t245 = extractvalue %Statement %statement, 0
  %t246 = alloca %Statement
  store %Statement %statement, %Statement* %t246
  %t247 = getelementptr inbounds %Statement, %Statement* %t246, i32 0, i32 1
  %t248 = bitcast [48 x i8]* %t247 to i8*
  %t249 = getelementptr inbounds i8, i8* %t248, i64 24
  %t250 = bitcast i8* %t249 to { %ModelProperty**, i64 }**
  %t251 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t250
  %t252 = icmp eq i32 %t245, 3
  %t253 = select i1 %t252, { %ModelProperty**, i64 }* %t251, { %ModelProperty**, i64 }* null
  %t254 = load double, double* %l2
  %t255 = fptosi double %t254 to i64
  %t256 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t253
  %t257 = extractvalue { %ModelProperty**, i64 } %t256, 0
  %t258 = extractvalue { %ModelProperty**, i64 } %t256, 1
  %t259 = icmp uge i64 %t255, %t258
  ; bounds check: %t259 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t255, i64 %t258)
  %t260 = getelementptr %ModelProperty*, %ModelProperty** %t257, i64 %t255
  %t261 = load %ModelProperty*, %ModelProperty** %t260
  store %ModelProperty* %t261, %ModelProperty** %l3
  %s262 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h381722796, i32 0, i32 0
  %t263 = load %ModelProperty*, %ModelProperty** %l3
  %t264 = getelementptr %ModelProperty, %ModelProperty* %t263, i32 0, i32 0
  %t265 = load i8*, i8** %t264
  %t266 = call i8* @sailfin_runtime_string_concat(i8* %s262, i8* %t265)
  %s267 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t268 = call i8* @sailfin_runtime_string_concat(i8* %t266, i8* %s267)
  %t269 = load %ModelProperty*, %ModelProperty** %l3
  %t270 = getelementptr %ModelProperty, %ModelProperty* %t269, i32 0, i32 1
  %t271 = load %Expression, %Expression* %t270
  %t272 = call i8* @format_expression(%Expression %t271)
  %t273 = call i8* @sailfin_runtime_string_concat(i8* %t268, i8* %t272)
  store i8* %t273, i8** %l4
  %t274 = load %NativeState, %NativeState* %l0
  %t275 = load i8*, i8** %l4
  %t276 = call %NativeState @state_emit_line(%NativeState %t274, i8* %t275)
  store %NativeState %t276, %NativeState* %l0
  %t277 = load double, double* %l2
  %t278 = sitofp i64 1 to double
  %t279 = fadd double %t277, %t278
  store double %t279, double* %l2
  br label %loop.latch4
loop.latch4:
  %t280 = load %NativeState, %NativeState* %l0
  %t281 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t284 = load %NativeState, %NativeState* %l0
  %t285 = load double, double* %l2
  %t286 = extractvalue %Statement %statement, 0
  %t287 = alloca %Statement
  store %Statement %statement, %Statement* %t287
  %t288 = getelementptr inbounds %Statement, %Statement* %t287, i32 0, i32 1
  %t289 = bitcast [48 x i8]* %t288 to i8*
  %t290 = getelementptr inbounds i8, i8* %t289, i64 24
  %t291 = bitcast i8* %t290 to { %ModelProperty**, i64 }**
  %t292 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t291
  %t293 = icmp eq i32 %t286, 3
  %t294 = select i1 %t293, { %ModelProperty**, i64 }* %t292, { %ModelProperty**, i64 }* null
  %t295 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t294
  %t296 = extractvalue { %ModelProperty**, i64 } %t295, 1
  %t297 = icmp eq i64 %t296, 0
  %t298 = load %NativeState, %NativeState* %l0
  %t299 = load i8*, i8** %l1
  %t300 = load double, double* %l2
  br i1 %t297, label %then8, label %merge9
then8:
  %t301 = load %NativeState, %NativeState* %l0
  %s302 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t303 = call %NativeState @state_emit_line(%NativeState %t301, i8* %s302)
  store %NativeState %t303, %NativeState* %l0
  %t304 = load %NativeState, %NativeState* %l0
  br label %merge9
merge9:
  %t305 = phi %NativeState [ %t304, %then8 ], [ %t298, %afterloop5 ]
  store %NativeState %t305, %NativeState* %l0
  %t306 = load %NativeState, %NativeState* %l0
  %t307 = call %NativeState @state_pop_indent(%NativeState %t306)
  store %NativeState %t307, %NativeState* %l0
  %t308 = load %NativeState, %NativeState* %l0
  %s309 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1708674232, i32 0, i32 0
  %t310 = call %NativeState @state_emit_line(%NativeState %t308, i8* %s309)
  ret %NativeState %t310
}

define %NativeState @emit_type_alias(%NativeState %state, %Statement %statement) {
entry:
  %l0 = alloca i8*
  %l1 = alloca %NativeState
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1880834942, i32 0, i32 0
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
  %t45 = call i8* @sailfin_runtime_string_concat(i8* %s0, i8* %t44)
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
  %t79 = call i8* @sailfin_runtime_string_concat(i8* %t46, i8* %t78)
  store i8* %t79, i8** %l0
  %t80 = load i8*, i8** %l0
  %s81 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t82 = call i8* @sailfin_runtime_string_concat(i8* %t80, i8* %s81)
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
  %t93 = call i8* @sailfin_runtime_string_concat(i8* %t82, i8* %t92)
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
  %s109 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h599952843, i32 0, i32 0
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
  %t154 = call i8* @sailfin_runtime_string_concat(i8* %s109, i8* %t153)
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
  %t188 = call i8* @sailfin_runtime_string_concat(i8* %t155, i8* %t187)
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
  call void @sailfin_runtime_bounds_check(i64 %t225, i64 %t228)
  %t230 = getelementptr %FunctionSignature*, %FunctionSignature** %t227, i64 %t225
  %t231 = load %FunctionSignature*, %FunctionSignature** %t230
  store %FunctionSignature* %t231, %FunctionSignature** %l3
  %t232 = load %NativeState, %NativeState* %l0
  %s233 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072555103, i32 0, i32 0
  %t234 = load %FunctionSignature*, %FunctionSignature** %l3
  %t235 = load %FunctionSignature, %FunctionSignature* %t234
  %t236 = call i8* @format_function_signature(%FunctionSignature %t235)
  %t237 = call i8* @sailfin_runtime_string_concat(i8* %s233, i8* %t236)
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
  %t246 = load %NativeState, %NativeState* %l0
  %t247 = load double, double* %l2
  %t248 = extractvalue %Statement %statement, 0
  %t249 = alloca %Statement
  store %Statement %statement, %Statement* %t249
  %t250 = getelementptr inbounds %Statement, %Statement* %t249, i32 0, i32 1
  %t251 = bitcast [40 x i8]* %t250 to i8*
  %t252 = getelementptr inbounds i8, i8* %t251, i64 24
  %t253 = bitcast i8* %t252 to { %FunctionSignature**, i64 }**
  %t254 = load { %FunctionSignature**, i64 }*, { %FunctionSignature**, i64 }** %t253
  %t255 = icmp eq i32 %t248, 10
  %t256 = select i1 %t255, { %FunctionSignature**, i64 }* %t254, { %FunctionSignature**, i64 }* null
  %t257 = load { %FunctionSignature**, i64 }, { %FunctionSignature**, i64 }* %t256
  %t258 = extractvalue { %FunctionSignature**, i64 } %t257, 1
  %t259 = icmp eq i64 %t258, 0
  %t260 = load %NativeState, %NativeState* %l0
  %t261 = load i8*, i8** %l1
  %t262 = load double, double* %l2
  br i1 %t259, label %then6, label %merge7
then6:
  %t263 = load %NativeState, %NativeState* %l0
  %s264 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t265 = call %NativeState @state_emit_line(%NativeState %t263, i8* %s264)
  store %NativeState %t265, %NativeState* %l0
  %t266 = load %NativeState, %NativeState* %l0
  br label %merge7
merge7:
  %t267 = phi %NativeState [ %t266, %then6 ], [ %t260, %afterloop3 ]
  store %NativeState %t267, %NativeState* %l0
  %t268 = load %NativeState, %NativeState* %l0
  %t269 = call %NativeState @state_pop_indent(%NativeState %t268)
  store %NativeState %t269, %NativeState* %l0
  %t270 = load %NativeState, %NativeState* %l0
  %s271 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1382830532, i32 0, i32 0
  %t272 = call %NativeState @state_emit_line(%NativeState %t270, i8* %s271)
  ret %NativeState %t272
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
  %s109 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1280947313, i32 0, i32 0
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
  %t154 = call i8* @sailfin_runtime_string_concat(i8* %s109, i8* %t153)
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
  %t188 = call i8* @sailfin_runtime_string_concat(i8* %t155, i8* %t187)
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
  %s228 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1311191977, i32 0, i32 0
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
  call void @sailfin_runtime_bounds_check(i64 %t239, i64 %t242)
  %t244 = getelementptr %EnumVariant*, %EnumVariant** %t241, i64 %t239
  %t245 = load %EnumVariant*, %EnumVariant** %t244
  %t246 = load %EnumVariant, %EnumVariant* %t245
  %t247 = call i8* @format_enum_variant(%EnumVariant %t246)
  %t248 = call i8* @sailfin_runtime_string_concat(i8* %s228, i8* %t247)
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
  %t257 = load %NativeState, %NativeState* %l0
  %t258 = load double, double* %l3
  %t259 = extractvalue %Statement %statement, 0
  %t260 = alloca %Statement
  store %Statement %statement, %Statement* %t260
  %t261 = getelementptr inbounds %Statement, %Statement* %t260, i32 0, i32 1
  %t262 = bitcast [40 x i8]* %t261 to i8*
  %t263 = getelementptr inbounds i8, i8* %t262, i64 24
  %t264 = bitcast i8* %t263 to { %EnumVariant**, i64 }**
  %t265 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t264
  %t266 = icmp eq i32 %t259, 11
  %t267 = select i1 %t266, { %EnumVariant**, i64 }* %t265, { %EnumVariant**, i64 }* null
  %t268 = load { %EnumVariant**, i64 }, { %EnumVariant**, i64 }* %t267
  %t269 = extractvalue { %EnumVariant**, i64 } %t268, 1
  %t270 = icmp eq i64 %t269, 0
  %t271 = load %NativeState, %NativeState* %l0
  %t272 = load i8*, i8** %l1
  %t273 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t274 = load double, double* %l3
  br i1 %t270, label %then6, label %merge7
then6:
  %t275 = load %NativeState, %NativeState* %l0
  %s276 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t277 = call %NativeState @state_emit_line(%NativeState %t275, i8* %s276)
  store %NativeState %t277, %NativeState* %l0
  %t278 = load %NativeState, %NativeState* %l0
  br label %merge7
merge7:
  %t279 = phi %NativeState [ %t278, %then6 ], [ %t271, %afterloop3 ]
  store %NativeState %t279, %NativeState* %l0
  %t280 = load %NativeState, %NativeState* %l0
  %t281 = call %NativeState @state_pop_indent(%NativeState %t280)
  store %NativeState %t281, %NativeState* %l0
  %t282 = load %NativeState, %NativeState* %l0
  %s283 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h562875475, i32 0, i32 0
  %t284 = call %NativeState @state_emit_line(%NativeState %t282, i8* %s283)
  ret %NativeState %t284
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
  %s109 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h2093451461, i32 0, i32 0
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
  %t154 = call i8* @sailfin_runtime_string_concat(i8* %s109, i8* %t153)
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
  %t188 = call i8* @sailfin_runtime_string_concat(i8* %t155, i8* %t187)
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
  %s204 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h2084565287, i32 0, i32 0
  %t205 = call i8* @sailfin_runtime_string_concat(i8* %t203, i8* %s204)
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
  %t217 = call i8* @sailfin_runtime_string_concat(i8* %t205, i8* %t216)
  store i8* %t217, i8** %l1
  %t218 = load i8*, i8** %l1
  br label %merge1
merge1:
  %t219 = phi i8* [ %t218, %then0 ], [ %t202, %entry ]
  store i8* %t219, i8** %l1
  %t220 = load %NativeState, %NativeState* %l0
  %t221 = load i8*, i8** %l1
  %t222 = call %NativeState @state_emit_line(%NativeState %t220, i8* %t221)
  store %NativeState %t222, %NativeState* %l0
  %t223 = load %NativeState, %NativeState* %l0
  %t224 = call %NativeState @state_push_indent(%NativeState %t223)
  store %NativeState %t224, %NativeState* %l0
  %t225 = extractvalue %NativeState %state, 2
  %t226 = extractvalue %Statement %statement, 0
  %t227 = alloca %Statement
  store %Statement %statement, %Statement* %t227
  %t228 = getelementptr inbounds %Statement, %Statement* %t227, i32 0, i32 1
  %t229 = bitcast [48 x i8]* %t228 to i8*
  %t230 = bitcast i8* %t229 to i8**
  %t231 = load i8*, i8** %t230
  %t232 = icmp eq i32 %t226, 2
  %t233 = select i1 %t232, i8* %t231, i8* null
  %t234 = getelementptr inbounds %Statement, %Statement* %t227, i32 0, i32 1
  %t235 = bitcast [48 x i8]* %t234 to i8*
  %t236 = bitcast i8* %t235 to i8**
  %t237 = load i8*, i8** %t236
  %t238 = icmp eq i32 %t226, 3
  %t239 = select i1 %t238, i8* %t237, i8* %t233
  %t240 = getelementptr inbounds %Statement, %Statement* %t227, i32 0, i32 1
  %t241 = bitcast [40 x i8]* %t240 to i8*
  %t242 = bitcast i8* %t241 to i8**
  %t243 = load i8*, i8** %t242
  %t244 = icmp eq i32 %t226, 6
  %t245 = select i1 %t244, i8* %t243, i8* %t239
  %t246 = getelementptr inbounds %Statement, %Statement* %t227, i32 0, i32 1
  %t247 = bitcast [56 x i8]* %t246 to i8*
  %t248 = bitcast i8* %t247 to i8**
  %t249 = load i8*, i8** %t248
  %t250 = icmp eq i32 %t226, 8
  %t251 = select i1 %t250, i8* %t249, i8* %t245
  %t252 = getelementptr inbounds %Statement, %Statement* %t227, i32 0, i32 1
  %t253 = bitcast [40 x i8]* %t252 to i8*
  %t254 = bitcast i8* %t253 to i8**
  %t255 = load i8*, i8** %t254
  %t256 = icmp eq i32 %t226, 9
  %t257 = select i1 %t256, i8* %t255, i8* %t251
  %t258 = getelementptr inbounds %Statement, %Statement* %t227, i32 0, i32 1
  %t259 = bitcast [40 x i8]* %t258 to i8*
  %t260 = bitcast i8* %t259 to i8**
  %t261 = load i8*, i8** %t260
  %t262 = icmp eq i32 %t226, 10
  %t263 = select i1 %t262, i8* %t261, i8* %t257
  %t264 = getelementptr inbounds %Statement, %Statement* %t227, i32 0, i32 1
  %t265 = bitcast [40 x i8]* %t264 to i8*
  %t266 = bitcast i8* %t265 to i8**
  %t267 = load i8*, i8** %t266
  %t268 = icmp eq i32 %t226, 11
  %t269 = select i1 %t268, i8* %t267, i8* %t263
  %t270 = extractvalue %Statement %statement, 0
  %t271 = alloca %Statement
  store %Statement %statement, %Statement* %t271
  %t272 = getelementptr inbounds %Statement, %Statement* %t271, i32 0, i32 1
  %t273 = bitcast [56 x i8]* %t272 to i8*
  %t274 = getelementptr inbounds i8, i8* %t273, i64 32
  %t275 = bitcast i8* %t274 to { %FieldDeclaration**, i64 }**
  %t276 = load { %FieldDeclaration**, i64 }*, { %FieldDeclaration**, i64 }** %t275
  %t277 = icmp eq i32 %t270, 8
  %t278 = select i1 %t277, { %FieldDeclaration**, i64 }* %t276, { %FieldDeclaration**, i64 }* null
  %t279 = bitcast { %FieldDeclaration**, i64 }* %t278 to { %FieldDeclaration*, i64 }*
  %t280 = call %LayoutEmitResult @compute_struct_layout_lines(%LayoutContext %t225, i8* %t269, { %FieldDeclaration*, i64 }* %t279)
  store %LayoutEmitResult %t280, %LayoutEmitResult* %l2
  %t281 = load %NativeState, %NativeState* %l0
  %t282 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t283 = extractvalue %LayoutEmitResult %t282, 0
  %t284 = call %NativeState @emit_layout_lines(%NativeState %t281, { i8**, i64 }* %t283)
  store %NativeState %t284, %NativeState* %l0
  %t285 = load %NativeState, %NativeState* %l0
  %t286 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t287 = extractvalue %LayoutEmitResult %t286, 1
  %t288 = call %NativeState @state_merge_diagnostics(%NativeState %t285, { i8**, i64 }* %t287)
  store %NativeState %t288, %NativeState* %l0
  %t289 = sitofp i64 0 to double
  store double %t289, double* %l3
  %t290 = load %NativeState, %NativeState* %l0
  %t291 = load i8*, i8** %l1
  %t292 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t293 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t340 = phi %NativeState [ %t290, %merge1 ], [ %t338, %loop.latch4 ]
  %t341 = phi double [ %t293, %merge1 ], [ %t339, %loop.latch4 ]
  store %NativeState %t340, %NativeState* %l0
  store double %t341, double* %l3
  br label %loop.body3
loop.body3:
  %t294 = load double, double* %l3
  %t295 = extractvalue %Statement %statement, 0
  %t296 = alloca %Statement
  store %Statement %statement, %Statement* %t296
  %t297 = getelementptr inbounds %Statement, %Statement* %t296, i32 0, i32 1
  %t298 = bitcast [56 x i8]* %t297 to i8*
  %t299 = getelementptr inbounds i8, i8* %t298, i64 32
  %t300 = bitcast i8* %t299 to { %FieldDeclaration**, i64 }**
  %t301 = load { %FieldDeclaration**, i64 }*, { %FieldDeclaration**, i64 }** %t300
  %t302 = icmp eq i32 %t295, 8
  %t303 = select i1 %t302, { %FieldDeclaration**, i64 }* %t301, { %FieldDeclaration**, i64 }* null
  %t304 = load { %FieldDeclaration**, i64 }, { %FieldDeclaration**, i64 }* %t303
  %t305 = extractvalue { %FieldDeclaration**, i64 } %t304, 1
  %t306 = sitofp i64 %t305 to double
  %t307 = fcmp oge double %t294, %t306
  %t308 = load %NativeState, %NativeState* %l0
  %t309 = load i8*, i8** %l1
  %t310 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t311 = load double, double* %l3
  br i1 %t307, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t312 = load %NativeState, %NativeState* %l0
  %s313 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h398443637, i32 0, i32 0
  %t314 = extractvalue %Statement %statement, 0
  %t315 = alloca %Statement
  store %Statement %statement, %Statement* %t315
  %t316 = getelementptr inbounds %Statement, %Statement* %t315, i32 0, i32 1
  %t317 = bitcast [56 x i8]* %t316 to i8*
  %t318 = getelementptr inbounds i8, i8* %t317, i64 32
  %t319 = bitcast i8* %t318 to { %FieldDeclaration**, i64 }**
  %t320 = load { %FieldDeclaration**, i64 }*, { %FieldDeclaration**, i64 }** %t319
  %t321 = icmp eq i32 %t314, 8
  %t322 = select i1 %t321, { %FieldDeclaration**, i64 }* %t320, { %FieldDeclaration**, i64 }* null
  %t323 = load double, double* %l3
  %t324 = fptosi double %t323 to i64
  %t325 = load { %FieldDeclaration**, i64 }, { %FieldDeclaration**, i64 }* %t322
  %t326 = extractvalue { %FieldDeclaration**, i64 } %t325, 0
  %t327 = extractvalue { %FieldDeclaration**, i64 } %t325, 1
  %t328 = icmp uge i64 %t324, %t327
  ; bounds check: %t328 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t324, i64 %t327)
  %t329 = getelementptr %FieldDeclaration*, %FieldDeclaration** %t326, i64 %t324
  %t330 = load %FieldDeclaration*, %FieldDeclaration** %t329
  %t331 = load %FieldDeclaration, %FieldDeclaration* %t330
  %t332 = call i8* @format_field(%FieldDeclaration %t331)
  %t333 = call i8* @sailfin_runtime_string_concat(i8* %s313, i8* %t332)
  %t334 = call %NativeState @state_emit_line(%NativeState %t312, i8* %t333)
  store %NativeState %t334, %NativeState* %l0
  %t335 = load double, double* %l3
  %t336 = sitofp i64 1 to double
  %t337 = fadd double %t335, %t336
  store double %t337, double* %l3
  br label %loop.latch4
loop.latch4:
  %t338 = load %NativeState, %NativeState* %l0
  %t339 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t342 = load %NativeState, %NativeState* %l0
  %t343 = load double, double* %l3
  %t344 = sitofp i64 0 to double
  store double %t344, double* %l4
  %t345 = load %NativeState, %NativeState* %l0
  %t346 = load i8*, i8** %l1
  %t347 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t348 = load double, double* %l3
  %t349 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t394 = phi %NativeState [ %t345, %afterloop5 ], [ %t392, %loop.latch10 ]
  %t395 = phi double [ %t349, %afterloop5 ], [ %t393, %loop.latch10 ]
  store %NativeState %t394, %NativeState* %l0
  store double %t395, double* %l4
  br label %loop.body9
loop.body9:
  %t350 = load double, double* %l4
  %t351 = extractvalue %Statement %statement, 0
  %t352 = alloca %Statement
  store %Statement %statement, %Statement* %t352
  %t353 = getelementptr inbounds %Statement, %Statement* %t352, i32 0, i32 1
  %t354 = bitcast [56 x i8]* %t353 to i8*
  %t355 = getelementptr inbounds i8, i8* %t354, i64 40
  %t356 = bitcast i8* %t355 to { %MethodDeclaration**, i64 }**
  %t357 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t356
  %t358 = icmp eq i32 %t351, 8
  %t359 = select i1 %t358, { %MethodDeclaration**, i64 }* %t357, { %MethodDeclaration**, i64 }* null
  %t360 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t359
  %t361 = extractvalue { %MethodDeclaration**, i64 } %t360, 1
  %t362 = sitofp i64 %t361 to double
  %t363 = fcmp oge double %t350, %t362
  %t364 = load %NativeState, %NativeState* %l0
  %t365 = load i8*, i8** %l1
  %t366 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t367 = load double, double* %l3
  %t368 = load double, double* %l4
  br i1 %t363, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t369 = load %NativeState, %NativeState* %l0
  %t370 = extractvalue %Statement %statement, 0
  %t371 = alloca %Statement
  store %Statement %statement, %Statement* %t371
  %t372 = getelementptr inbounds %Statement, %Statement* %t371, i32 0, i32 1
  %t373 = bitcast [56 x i8]* %t372 to i8*
  %t374 = getelementptr inbounds i8, i8* %t373, i64 40
  %t375 = bitcast i8* %t374 to { %MethodDeclaration**, i64 }**
  %t376 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t375
  %t377 = icmp eq i32 %t370, 8
  %t378 = select i1 %t377, { %MethodDeclaration**, i64 }* %t376, { %MethodDeclaration**, i64 }* null
  %t379 = load double, double* %l4
  %t380 = fptosi double %t379 to i64
  %t381 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t378
  %t382 = extractvalue { %MethodDeclaration**, i64 } %t381, 0
  %t383 = extractvalue { %MethodDeclaration**, i64 } %t381, 1
  %t384 = icmp uge i64 %t380, %t383
  ; bounds check: %t384 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t380, i64 %t383)
  %t385 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t382, i64 %t380
  %t386 = load %MethodDeclaration*, %MethodDeclaration** %t385
  %t387 = load %MethodDeclaration, %MethodDeclaration* %t386
  %t388 = call %NativeState @emit_method(%NativeState %t369, %MethodDeclaration %t387)
  store %NativeState %t388, %NativeState* %l0
  %t389 = load double, double* %l4
  %t390 = sitofp i64 1 to double
  %t391 = fadd double %t389, %t390
  store double %t391, double* %l4
  br label %loop.latch10
loop.latch10:
  %t392 = load %NativeState, %NativeState* %l0
  %t393 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t396 = load %NativeState, %NativeState* %l0
  %t397 = load double, double* %l4
  %t399 = extractvalue %Statement %statement, 0
  %t400 = alloca %Statement
  store %Statement %statement, %Statement* %t400
  %t401 = getelementptr inbounds %Statement, %Statement* %t400, i32 0, i32 1
  %t402 = bitcast [56 x i8]* %t401 to i8*
  %t403 = getelementptr inbounds i8, i8* %t402, i64 32
  %t404 = bitcast i8* %t403 to { %FieldDeclaration**, i64 }**
  %t405 = load { %FieldDeclaration**, i64 }*, { %FieldDeclaration**, i64 }** %t404
  %t406 = icmp eq i32 %t399, 8
  %t407 = select i1 %t406, { %FieldDeclaration**, i64 }* %t405, { %FieldDeclaration**, i64 }* null
  %t408 = load { %FieldDeclaration**, i64 }, { %FieldDeclaration**, i64 }* %t407
  %t409 = extractvalue { %FieldDeclaration**, i64 } %t408, 1
  %t410 = icmp eq i64 %t409, 0
  br label %logical_and_entry_398

logical_and_entry_398:
  br i1 %t410, label %logical_and_right_398, label %logical_and_merge_398

logical_and_right_398:
  %t411 = extractvalue %Statement %statement, 0
  %t412 = alloca %Statement
  store %Statement %statement, %Statement* %t412
  %t413 = getelementptr inbounds %Statement, %Statement* %t412, i32 0, i32 1
  %t414 = bitcast [56 x i8]* %t413 to i8*
  %t415 = getelementptr inbounds i8, i8* %t414, i64 40
  %t416 = bitcast i8* %t415 to { %MethodDeclaration**, i64 }**
  %t417 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t416
  %t418 = icmp eq i32 %t411, 8
  %t419 = select i1 %t418, { %MethodDeclaration**, i64 }* %t417, { %MethodDeclaration**, i64 }* null
  %t420 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t419
  %t421 = extractvalue { %MethodDeclaration**, i64 } %t420, 1
  %t422 = icmp eq i64 %t421, 0
  br label %logical_and_right_end_398

logical_and_right_end_398:
  br label %logical_and_merge_398

logical_and_merge_398:
  %t423 = phi i1 [ false, %logical_and_entry_398 ], [ %t422, %logical_and_right_end_398 ]
  %t424 = load %NativeState, %NativeState* %l0
  %t425 = load i8*, i8** %l1
  %t426 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t427 = load double, double* %l3
  %t428 = load double, double* %l4
  br i1 %t423, label %then14, label %merge15
then14:
  %t429 = load %NativeState, %NativeState* %l0
  %s430 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t431 = call %NativeState @state_emit_line(%NativeState %t429, i8* %s430)
  store %NativeState %t431, %NativeState* %l0
  %t432 = load %NativeState, %NativeState* %l0
  br label %merge15
merge15:
  %t433 = phi %NativeState [ %t432, %then14 ], [ %t424, %logical_and_merge_398 ]
  store %NativeState %t433, %NativeState* %l0
  %t434 = load %NativeState, %NativeState* %l0
  %t435 = call %NativeState @state_pop_indent(%NativeState %t434)
  store %NativeState %t435, %NativeState* %l0
  %t436 = load %NativeState, %NativeState* %l0
  %s437 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h2070880298, i32 0, i32 0
  %t438 = call %NativeState @state_emit_line(%NativeState %t436, i8* %s437)
  ret %NativeState %t438
}

define %NativeState @emit_method(%NativeState %state, %MethodDeclaration %method) {
entry:
  %l0 = alloca %NativeState
  %t0 = extractvalue %MethodDeclaration %method, 2
  %t1 = bitcast { %Decorator**, i64 }* %t0 to { %Decorator*, i64 }*
  %t2 = call %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %t1)
  store %NativeState %t2, %NativeState* %l0
  %t3 = load %NativeState, %NativeState* %l0
  %s4 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1951948513, i32 0, i32 0
  %t5 = extractvalue %MethodDeclaration %method, 0
  %t6 = call i8* @format_function_signature(%FunctionSignature %t5)
  %t7 = call i8* @sailfin_runtime_string_concat(i8* %s4, i8* %t6)
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
  %s25 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h179409731, i32 0, i32 0
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
  %s110 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h377779046, i32 0, i32 0
  %t111 = extractvalue %Statement %statement, 0
  %t112 = alloca %Statement
  store %Statement %statement, %Statement* %t112
  %t113 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t114 = bitcast [40 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to i8**
  %t116 = load i8*, i8** %t115
  %t117 = icmp eq i32 %t111, 12
  %t118 = select i1 %t117, i8* %t116, i8* null
  %t119 = call i8* @sailfin_runtime_string_concat(i8* %s110, i8* %t118)
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
  %s185 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h261858150, i32 0, i32 0
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
  %s109 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1979413400, i32 0, i32 0
  store i8* %s109, i8** %l1
  %t110 = sitofp i64 0 to double
  store double %t110, double* %l2
  %t111 = load %NativeState, %NativeState* %l0
  %t112 = load i8*, i8** %l1
  %t113 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t167 = phi i8* [ %t112, %entry ], [ %t165, %loop.latch2 ]
  %t168 = phi double [ %t113, %entry ], [ %t166, %loop.latch2 ]
  store i8* %t167, i8** %l1
  store double %t168, double* %l2
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
  %s137 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t138 = call i8* @sailfin_runtime_string_concat(i8* %t136, i8* %s137)
  store i8* %t138, i8** %l1
  %t139 = load i8*, i8** %l1
  br label %merge7
merge7:
  %t140 = phi i8* [ %t139, %then6 ], [ %t134, %merge5 ]
  store i8* %t140, i8** %l1
  %t141 = load i8*, i8** %l1
  %t142 = extractvalue %Statement %statement, 0
  %t143 = alloca %Statement
  store %Statement %statement, %Statement* %t143
  %t144 = getelementptr inbounds %Statement, %Statement* %t143, i32 0, i32 1
  %t145 = bitcast [24 x i8]* %t144 to i8*
  %t146 = bitcast i8* %t145 to { %WithClause**, i64 }**
  %t147 = load { %WithClause**, i64 }*, { %WithClause**, i64 }** %t146
  %t148 = icmp eq i32 %t142, 13
  %t149 = select i1 %t148, { %WithClause**, i64 }* %t147, { %WithClause**, i64 }* null
  %t150 = load double, double* %l2
  %t151 = fptosi double %t150 to i64
  %t152 = load { %WithClause**, i64 }, { %WithClause**, i64 }* %t149
  %t153 = extractvalue { %WithClause**, i64 } %t152, 0
  %t154 = extractvalue { %WithClause**, i64 } %t152, 1
  %t155 = icmp uge i64 %t151, %t154
  ; bounds check: %t155 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t151, i64 %t154)
  %t156 = getelementptr %WithClause*, %WithClause** %t153, i64 %t151
  %t157 = load %WithClause*, %WithClause** %t156
  %t158 = getelementptr %WithClause, %WithClause* %t157, i32 0, i32 0
  %t159 = load %Expression, %Expression* %t158
  %t160 = call i8* @format_expression(%Expression %t159)
  %t161 = call i8* @sailfin_runtime_string_concat(i8* %t141, i8* %t160)
  store i8* %t161, i8** %l1
  %t162 = load double, double* %l2
  %t163 = sitofp i64 1 to double
  %t164 = fadd double %t162, %t163
  store double %t164, double* %l2
  br label %loop.latch2
loop.latch2:
  %t165 = load i8*, i8** %l1
  %t166 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t169 = load i8*, i8** %l1
  %t170 = load double, double* %l2
  %t171 = load %NativeState, %NativeState* %l0
  %t172 = load i8*, i8** %l1
  %t173 = call %NativeState @state_emit_line(%NativeState %t171, i8* %t172)
  store %NativeState %t173, %NativeState* %l0
  %t174 = load %NativeState, %NativeState* %l0
  %t175 = call %NativeState @state_push_indent(%NativeState %t174)
  store %NativeState %t175, %NativeState* %l0
  %t176 = load %NativeState, %NativeState* %l0
  %t177 = extractvalue %Statement %statement, 0
  %t178 = alloca %Statement
  store %Statement %statement, %Statement* %t178
  %t179 = getelementptr inbounds %Statement, %Statement* %t178, i32 0, i32 1
  %t180 = bitcast [24 x i8]* %t179 to i8*
  %t181 = getelementptr inbounds i8, i8* %t180, i64 8
  %t182 = bitcast i8* %t181 to %Block*
  %t183 = load %Block, %Block* %t182
  %t184 = icmp eq i32 %t177, 4
  %t185 = select i1 %t184, %Block %t183, %Block zeroinitializer
  %t186 = getelementptr inbounds %Statement, %Statement* %t178, i32 0, i32 1
  %t187 = bitcast [24 x i8]* %t186 to i8*
  %t188 = getelementptr inbounds i8, i8* %t187, i64 8
  %t189 = bitcast i8* %t188 to %Block*
  %t190 = load %Block, %Block* %t189
  %t191 = icmp eq i32 %t177, 5
  %t192 = select i1 %t191, %Block %t190, %Block %t185
  %t193 = getelementptr inbounds %Statement, %Statement* %t178, i32 0, i32 1
  %t194 = bitcast [40 x i8]* %t193 to i8*
  %t195 = getelementptr inbounds i8, i8* %t194, i64 16
  %t196 = bitcast i8* %t195 to %Block*
  %t197 = load %Block, %Block* %t196
  %t198 = icmp eq i32 %t177, 6
  %t199 = select i1 %t198, %Block %t197, %Block %t192
  %t200 = getelementptr inbounds %Statement, %Statement* %t178, i32 0, i32 1
  %t201 = bitcast [24 x i8]* %t200 to i8*
  %t202 = getelementptr inbounds i8, i8* %t201, i64 8
  %t203 = bitcast i8* %t202 to %Block*
  %t204 = load %Block, %Block* %t203
  %t205 = icmp eq i32 %t177, 7
  %t206 = select i1 %t205, %Block %t204, %Block %t199
  %t207 = getelementptr inbounds %Statement, %Statement* %t178, i32 0, i32 1
  %t208 = bitcast [40 x i8]* %t207 to i8*
  %t209 = getelementptr inbounds i8, i8* %t208, i64 24
  %t210 = bitcast i8* %t209 to %Block*
  %t211 = load %Block, %Block* %t210
  %t212 = icmp eq i32 %t177, 12
  %t213 = select i1 %t212, %Block %t211, %Block %t206
  %t214 = getelementptr inbounds %Statement, %Statement* %t178, i32 0, i32 1
  %t215 = bitcast [24 x i8]* %t214 to i8*
  %t216 = getelementptr inbounds i8, i8* %t215, i64 8
  %t217 = bitcast i8* %t216 to %Block*
  %t218 = load %Block, %Block* %t217
  %t219 = icmp eq i32 %t177, 13
  %t220 = select i1 %t219, %Block %t218, %Block %t213
  %t221 = getelementptr inbounds %Statement, %Statement* %t178, i32 0, i32 1
  %t222 = bitcast [24 x i8]* %t221 to i8*
  %t223 = getelementptr inbounds i8, i8* %t222, i64 8
  %t224 = bitcast i8* %t223 to %Block*
  %t225 = load %Block, %Block* %t224
  %t226 = icmp eq i32 %t177, 14
  %t227 = select i1 %t226, %Block %t225, %Block %t220
  %t228 = getelementptr inbounds %Statement, %Statement* %t178, i32 0, i32 1
  %t229 = bitcast [16 x i8]* %t228 to i8*
  %t230 = bitcast i8* %t229 to %Block*
  %t231 = load %Block, %Block* %t230
  %t232 = icmp eq i32 %t177, 15
  %t233 = select i1 %t232, %Block %t231, %Block %t227
  %t234 = call %NativeState @emit_block(%NativeState %t176, %Block %t233)
  store %NativeState %t234, %NativeState* %l0
  %t235 = load %NativeState, %NativeState* %l0
  %t236 = call %NativeState @state_pop_indent(%NativeState %t235)
  store %NativeState %t236, %NativeState* %l0
  %t237 = load %NativeState, %NativeState* %l0
  %s238 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h584041114, i32 0, i32 0
  %t239 = call %NativeState @state_emit_line(%NativeState %t237, i8* %s238)
  ret %NativeState %t239
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
  %s109 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2057365731, i32 0, i32 0
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
  %t120 = call i8* @sailfin_runtime_string_concat(i8* %s109, i8* %t119)
  %s121 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175996034, i32 0, i32 0
  %t122 = call i8* @sailfin_runtime_string_concat(i8* %t120, i8* %s121)
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
  %t133 = call i8* @sailfin_runtime_string_concat(i8* %t122, i8* %t132)
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
  %s201 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h1448749422, i32 0, i32 0
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
  %s110 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2064480630, i32 0, i32 0
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
  %s176 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h571206424, i32 0, i32 0
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
  %s110 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h553171426, i32 0, i32 0
  %t111 = extractvalue %Statement %statement, 0
  %t112 = alloca %Statement
  store %Statement %statement, %Statement* %t112
  %t113 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t114 = bitcast [24 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to %Expression*
  %t116 = load %Expression, %Expression* %t115
  %t117 = icmp eq i32 %t111, 18
  %t118 = select i1 %t117, %Expression %t116, %Expression zeroinitializer
  %t119 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t120 = bitcast [16 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to %Expression*
  %t122 = load %Expression, %Expression* %t121
  %t123 = icmp eq i32 %t111, 21
  %t124 = select i1 %t123, %Expression %t122, %Expression %t118
  %t125 = call i8* @format_expression(%Expression %t124)
  %t126 = call i8* @sailfin_runtime_string_concat(i8* %s110, i8* %t125)
  %t127 = call %NativeState @state_emit_line(%NativeState %t109, i8* %t126)
  store %NativeState %t127, %NativeState* %l0
  %t128 = load %NativeState, %NativeState* %l0
  %t129 = call %NativeState @state_push_indent(%NativeState %t128)
  store %NativeState %t129, %NativeState* %l0
  %t130 = sitofp i64 0 to double
  store double %t130, double* %l1
  %t131 = load %NativeState, %NativeState* %l0
  %t132 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t174 = phi %NativeState [ %t131, %entry ], [ %t172, %loop.latch2 ]
  %t175 = phi double [ %t132, %entry ], [ %t173, %loop.latch2 ]
  store %NativeState %t174, %NativeState* %l0
  store double %t175, double* %l1
  br label %loop.body1
loop.body1:
  %t133 = load double, double* %l1
  %t134 = extractvalue %Statement %statement, 0
  %t135 = alloca %Statement
  store %Statement %statement, %Statement* %t135
  %t136 = getelementptr inbounds %Statement, %Statement* %t135, i32 0, i32 1
  %t137 = bitcast [24 x i8]* %t136 to i8*
  %t138 = getelementptr inbounds i8, i8* %t137, i64 8
  %t139 = bitcast i8* %t138 to { %MatchCase**, i64 }**
  %t140 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t139
  %t141 = icmp eq i32 %t134, 18
  %t142 = select i1 %t141, { %MatchCase**, i64 }* %t140, { %MatchCase**, i64 }* null
  %t143 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t142
  %t144 = extractvalue { %MatchCase**, i64 } %t143, 1
  %t145 = sitofp i64 %t144 to double
  %t146 = fcmp oge double %t133, %t145
  %t147 = load %NativeState, %NativeState* %l0
  %t148 = load double, double* %l1
  br i1 %t146, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t149 = load %NativeState, %NativeState* %l0
  %t150 = extractvalue %Statement %statement, 0
  %t151 = alloca %Statement
  store %Statement %statement, %Statement* %t151
  %t152 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t153 = bitcast [24 x i8]* %t152 to i8*
  %t154 = getelementptr inbounds i8, i8* %t153, i64 8
  %t155 = bitcast i8* %t154 to { %MatchCase**, i64 }**
  %t156 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t155
  %t157 = icmp eq i32 %t150, 18
  %t158 = select i1 %t157, { %MatchCase**, i64 }* %t156, { %MatchCase**, i64 }* null
  %t159 = load double, double* %l1
  %t160 = fptosi double %t159 to i64
  %t161 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t158
  %t162 = extractvalue { %MatchCase**, i64 } %t161, 0
  %t163 = extractvalue { %MatchCase**, i64 } %t161, 1
  %t164 = icmp uge i64 %t160, %t163
  ; bounds check: %t164 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t160, i64 %t163)
  %t165 = getelementptr %MatchCase*, %MatchCase** %t162, i64 %t160
  %t166 = load %MatchCase*, %MatchCase** %t165
  %t167 = load %MatchCase, %MatchCase* %t166
  %t168 = call %NativeState @emit_match_case(%NativeState %t149, %MatchCase %t167)
  store %NativeState %t168, %NativeState* %l0
  %t169 = load double, double* %l1
  %t170 = sitofp i64 1 to double
  %t171 = fadd double %t169, %t170
  store double %t171, double* %l1
  br label %loop.latch2
loop.latch2:
  %t172 = load %NativeState, %NativeState* %l0
  %t173 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t176 = load %NativeState, %NativeState* %l0
  %t177 = load double, double* %l1
  %t178 = extractvalue %Statement %statement, 0
  %t179 = alloca %Statement
  store %Statement %statement, %Statement* %t179
  %t180 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t181 = bitcast [24 x i8]* %t180 to i8*
  %t182 = getelementptr inbounds i8, i8* %t181, i64 8
  %t183 = bitcast i8* %t182 to { %MatchCase**, i64 }**
  %t184 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t183
  %t185 = icmp eq i32 %t178, 18
  %t186 = select i1 %t185, { %MatchCase**, i64 }* %t184, { %MatchCase**, i64 }* null
  %t187 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t186
  %t188 = extractvalue { %MatchCase**, i64 } %t187, 1
  %t189 = icmp eq i64 %t188, 0
  %t190 = load %NativeState, %NativeState* %l0
  %t191 = load double, double* %l1
  br i1 %t189, label %then6, label %merge7
then6:
  %t192 = load %NativeState, %NativeState* %l0
  %s193 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t194 = call %NativeState @state_emit_line(%NativeState %t192, i8* %s193)
  store %NativeState %t194, %NativeState* %l0
  %t195 = load %NativeState, %NativeState* %l0
  br label %merge7
merge7:
  %t196 = phi %NativeState [ %t195, %then6 ], [ %t190, %afterloop3 ]
  store %NativeState %t196, %NativeState* %l0
  %t197 = load %NativeState, %NativeState* %l0
  %t198 = call %NativeState @state_pop_indent(%NativeState %t197)
  store %NativeState %t198, %NativeState* %l0
  %t199 = load %NativeState, %NativeState* %l0
  %s200 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1692644020, i32 0, i32 0
  %t201 = call %NativeState @state_emit_line(%NativeState %t199, i8* %s200)
  ret %NativeState %t201
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
  %t3 = icmp eq %Statement* %t2, null
  %t4 = load %Statement*, %Statement** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %s5 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1187178968, i32 0, i32 0
  %t6 = call i8* @format_match_case_head(%MatchCase %case)
  %t7 = call i8* @sailfin_runtime_string_concat(i8* %s5, i8* %t6)
  store i8* %t7, i8** %l1
  %t8 = load i8*, i8** %l1
  %t9 = call %NativeState @state_emit_line(%NativeState %state, i8* %t8)
  store %NativeState %t9, %NativeState* %l2
  %t10 = load %NativeState, %NativeState* %l2
  %t11 = call %NativeState @state_push_indent(%NativeState %t10)
  store %NativeState %t11, %NativeState* %l2
  %t12 = load %NativeState, %NativeState* %l2
  %t13 = extractvalue %MatchCase %case, 2
  %t14 = call %NativeState @emit_block(%NativeState %t12, %Block %t13)
  store %NativeState %t14, %NativeState* %l2
  %t15 = load %NativeState, %NativeState* %l2
  %t16 = call %NativeState @state_pop_indent(%NativeState %t15)
  store %NativeState %t16, %NativeState* %l2
  %t17 = load %NativeState, %NativeState* %l2
  ret %NativeState %t17
merge1:
  %t18 = load %Statement*, %Statement** %l0
  %t19 = load %Statement, %Statement* %t18
  %t20 = call %NativeState @emit_inline_match_case(%NativeState %state, %MatchCase %case, %Statement %t19)
  ret %NativeState %t20
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
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t8)
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
  %s85 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h868168677, i32 0, i32 0
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
  %s162 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1613933868, i32 0, i32 0
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
  %s1 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h174362534, i32 0, i32 0
  %t2 = call i8* @sailfin_runtime_string_concat(i8* %t0, i8* %s1)
  %t3 = call i8* @format_inline_case_body(%Statement %statement)
  %t4 = call i8* @sailfin_runtime_string_concat(i8* %t2, i8* %t3)
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
  %l1 = alloca %Expression*
  %t0 = extractvalue %MatchCase %case, 0
  %t1 = call i8* @format_expression(%Expression %t0)
  store i8* %t1, i8** %l0
  %t2 = extractvalue %MatchCase %case, 1
  store %Expression* %t2, %Expression** %l1
  %t3 = load %Expression*, %Expression** %l1
  %t4 = icmp eq %Expression* %t3, null
  %t5 = load i8*, i8** %l0
  %t6 = load %Expression*, %Expression** %l1
  br i1 %t4, label %then0, label %merge1
then0:
  %t7 = load i8*, i8** %l0
  ret i8* %t7
merge1:
  %t8 = load i8*, i8** %l0
  %s9 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175987322, i32 0, i32 0
  %t10 = call i8* @sailfin_runtime_string_concat(i8* %t8, i8* %s9)
  %t11 = load %Expression*, %Expression** %l1
  %t12 = load %Expression, %Expression* %t11
  %t13 = call i8* @format_expression(%Expression %t12)
  %t14 = call i8* @sailfin_runtime_string_concat(i8* %t10, i8* %t13)
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
  %s71 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h868168677, i32 0, i32 0
  %t72 = icmp eq i8* %t70, %s71
  br i1 %t72, label %then0, label %merge1
then0:
  %t73 = extractvalue %Statement %statement, 0
  %t74 = alloca %Statement
  store %Statement %statement, %Statement* %t74
  %t75 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t76 = bitcast [24 x i8]* %t75 to i8*
  %t77 = bitcast i8* %t76 to %Expression*
  %t78 = load %Expression, %Expression* %t77
  %t79 = icmp eq i32 %t73, 18
  %t80 = select i1 %t79, %Expression %t78, %Expression zeroinitializer
  %t81 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t82 = bitcast [16 x i8]* %t81 to i8*
  %t83 = bitcast i8* %t82 to %Expression*
  %t84 = load %Expression, %Expression* %t83
  %t85 = icmp eq i32 %t73, 21
  %t86 = select i1 %t85, %Expression %t84, %Expression %t80
  %t87 = call i8* @format_expression(%Expression %t86)
  ret i8* %t87
merge1:
  %t88 = extractvalue %Statement %statement, 0
  %t89 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t90 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t91 = icmp eq i32 %t88, 0
  %t92 = select i1 %t91, i8* %t90, i8* %t89
  %t93 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t88, 1
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %t96 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t97 = icmp eq i32 %t88, 2
  %t98 = select i1 %t97, i8* %t96, i8* %t95
  %t99 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t88, 3
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t88, 4
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t106 = icmp eq i32 %t88, 5
  %t107 = select i1 %t106, i8* %t105, i8* %t104
  %t108 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t88, 6
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t112 = icmp eq i32 %t88, 7
  %t113 = select i1 %t112, i8* %t111, i8* %t110
  %t114 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t88, 8
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %t117 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t118 = icmp eq i32 %t88, 9
  %t119 = select i1 %t118, i8* %t117, i8* %t116
  %t120 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t88, 10
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %t123 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t124 = icmp eq i32 %t88, 11
  %t125 = select i1 %t124, i8* %t123, i8* %t122
  %t126 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t127 = icmp eq i32 %t88, 12
  %t128 = select i1 %t127, i8* %t126, i8* %t125
  %t129 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t130 = icmp eq i32 %t88, 13
  %t131 = select i1 %t130, i8* %t129, i8* %t128
  %t132 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t88, 14
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t88, 15
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t88, 16
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t88, 17
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t88, 18
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t88, 19
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t88, 20
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t88, 21
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t88, 22
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %s159 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1613933868, i32 0, i32 0
  %t160 = icmp eq i8* %t158, %s159
  br i1 %t160, label %then2, label %merge3
then2:
  %t161 = extractvalue %Statement %statement, 0
  %t162 = alloca %Statement
  store %Statement %statement, %Statement* %t162
  %t163 = getelementptr inbounds %Statement, %Statement* %t162, i32 0, i32 1
  %t164 = bitcast [24 x i8]* %t163 to i8*
  %t165 = bitcast i8* %t164 to %Expression*
  %t166 = icmp eq i32 %t161, 18
  %t167 = select i1 %t166, %Expression* %t165, %Expression* null
  %t168 = getelementptr inbounds %Statement, %Statement* %t162, i32 0, i32 1
  %t169 = bitcast [16 x i8]* %t168 to i8*
  %t170 = bitcast i8* %t169 to %Expression**
  %t171 = load %Expression*, %Expression** %t170
  %t172 = icmp eq i32 %t161, 20
  %t173 = select i1 %t172, %Expression* %t171, %Expression* %t167
  %t174 = getelementptr inbounds %Statement, %Statement* %t162, i32 0, i32 1
  %t175 = bitcast [16 x i8]* %t174 to i8*
  %t176 = bitcast i8* %t175 to %Expression*
  %t177 = icmp eq i32 %t161, 21
  %t178 = select i1 %t177, %Expression* %t176, %Expression* %t173
  %t179 = icmp eq %Expression* %t178, null
  br i1 %t179, label %then4, label %merge5
then4:
  %s180 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1061063223, i32 0, i32 0
  ret i8* %s180
merge5:
  %s181 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h655348872, i32 0, i32 0
  %t182 = extractvalue %Statement %statement, 0
  %t183 = alloca %Statement
  store %Statement %statement, %Statement* %t183
  %t184 = getelementptr inbounds %Statement, %Statement* %t183, i32 0, i32 1
  %t185 = bitcast [24 x i8]* %t184 to i8*
  %t186 = bitcast i8* %t185 to %Expression*
  %t187 = load %Expression, %Expression* %t186
  %t188 = icmp eq i32 %t182, 18
  %t189 = select i1 %t188, %Expression %t187, %Expression zeroinitializer
  %t190 = getelementptr inbounds %Statement, %Statement* %t183, i32 0, i32 1
  %t191 = bitcast [16 x i8]* %t190 to i8*
  %t192 = bitcast i8* %t191 to %Expression*
  %t193 = load %Expression, %Expression* %t192
  %t194 = icmp eq i32 %t182, 21
  %t195 = select i1 %t194, %Expression %t193, %Expression %t189
  %t196 = call i8* @format_expression(%Expression %t195)
  %t197 = call i8* @sailfin_runtime_string_concat(i8* %s181, i8* %t196)
  ret i8* %t197
merge3:
  %s198 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  ret i8* %s198
}

define %NativeState @emit_if(%NativeState %state, %Statement %statement) {
entry:
  %l0 = alloca %NativeState
  %l1 = alloca %ElseBranch*
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
  %s110 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h192590216, i32 0, i32 0
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
  %t120 = call i8* @sailfin_runtime_string_concat(i8* %s110, i8* %t119)
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
  store %ElseBranch* %t145, %ElseBranch** %l1
  %t146 = load %ElseBranch*, %ElseBranch** %l1
  %t147 = icmp eq %ElseBranch* %t146, null
  %t148 = load %NativeState, %NativeState* %l0
  %t149 = load %ElseBranch*, %ElseBranch** %l1
  br i1 %t147, label %then0, label %merge1
then0:
  %t150 = load %NativeState, %NativeState* %l0
  %s151 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1280334338, i32 0, i32 0
  %t152 = call %NativeState @state_emit_line(%NativeState %t150, i8* %s151)
  ret %NativeState %t152
merge1:
  %t153 = load %NativeState, %NativeState* %l0
  %t154 = load %ElseBranch*, %ElseBranch** %l1
  %t155 = load %ElseBranch, %ElseBranch* %t154
  %t156 = call %NativeState @emit_else_branch(%NativeState %t153, %ElseBranch %t155)
  store %NativeState %t156, %NativeState* %l0
  %t157 = load %NativeState, %NativeState* %l0
  %s158 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1280334338, i32 0, i32 0
  %t159 = call %NativeState @state_emit_line(%NativeState %t157, i8* %s158)
  ret %NativeState %t159
}

define %NativeState @emit_else_branch(%NativeState %state, %ElseBranch %branch) {
entry:
  %l0 = alloca %NativeState
  %l1 = alloca %Block*
  %l2 = alloca %Statement*
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2056075365, i32 0, i32 0
  %t1 = call %NativeState @state_emit_line(%NativeState %state, i8* %s0)
  store %NativeState %t1, %NativeState* %l0
  %t2 = load %NativeState, %NativeState* %l0
  %t3 = call %NativeState @state_push_indent(%NativeState %t2)
  store %NativeState %t3, %NativeState* %l0
  %t4 = extractvalue %ElseBranch %branch, 1
  store %Block* %t4, %Block** %l1
  %t5 = load %Block*, %Block** %l1
  %t6 = icmp eq %Block* %t5, null
  %t7 = load %NativeState, %NativeState* %l0
  %t8 = load %Block*, %Block** %l1
  br i1 %t6, label %then0, label %else1
then0:
  %t9 = extractvalue %ElseBranch %branch, 0
  store %Statement* %t9, %Statement** %l2
  %t10 = load %Statement*, %Statement** %l2
  %t11 = icmp eq %Statement* %t10, null
  %t12 = load %NativeState, %NativeState* %l0
  %t13 = load %Block*, %Block** %l1
  %t14 = load %Statement*, %Statement** %l2
  br i1 %t11, label %then3, label %else4
then3:
  %t15 = load %NativeState, %NativeState* %l0
  %s16 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t17 = call %NativeState @state_emit_line(%NativeState %t15, i8* %s16)
  store %NativeState %t17, %NativeState* %l0
  %t18 = load %NativeState, %NativeState* %l0
  br label %merge5
else4:
  %t19 = load %NativeState, %NativeState* %l0
  %t20 = load %Statement*, %Statement** %l2
  %t21 = load %Statement, %Statement* %t20
  %t22 = call %NativeState @emit_statement(%NativeState %t19, %Statement %t21)
  store %NativeState %t22, %NativeState* %l0
  %t23 = load %NativeState, %NativeState* %l0
  br label %merge5
merge5:
  %t24 = phi %NativeState [ %t18, %then3 ], [ %t23, %else4 ]
  store %NativeState %t24, %NativeState* %l0
  %t25 = load %NativeState, %NativeState* %l0
  %t26 = load %NativeState, %NativeState* %l0
  br label %merge2
else1:
  %t27 = load %NativeState, %NativeState* %l0
  %t28 = load %Block*, %Block** %l1
  %t29 = load %Block, %Block* %t28
  %t30 = call %NativeState @emit_block(%NativeState %t27, %Block %t29)
  store %NativeState %t30, %NativeState* %l0
  %t31 = load %NativeState, %NativeState* %l0
  br label %merge2
merge2:
  %t32 = phi %NativeState [ %t25, %merge5 ], [ %t31, %else1 ]
  store %NativeState %t32, %NativeState* %l0
  %t33 = load %NativeState, %NativeState* %l0
  %t34 = call %NativeState @state_pop_indent(%NativeState %t33)
  store %NativeState %t34, %NativeState* %l0
  %t35 = load %NativeState, %NativeState* %l0
  ret %NativeState %t35
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
  %t42 = icmp eq %Expression* %t41, null
  %t43 = load %NativeState, %NativeState* %l0
  br i1 %t42, label %then0, label %merge1
then0:
  %t44 = load %NativeState, %NativeState* %l0
  %s45 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090684245, i32 0, i32 0
  %t46 = call %NativeState @state_emit_line(%NativeState %t44, i8* %s45)
  ret %NativeState %t46
merge1:
  %t47 = load %NativeState, %NativeState* %l0
  %s48 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h273104342, i32 0, i32 0
  %t49 = extractvalue %Statement %statement, 0
  %t50 = alloca %Statement
  store %Statement %statement, %Statement* %t50
  %t51 = getelementptr inbounds %Statement, %Statement* %t50, i32 0, i32 1
  %t52 = bitcast [24 x i8]* %t51 to i8*
  %t53 = bitcast i8* %t52 to %Expression*
  %t54 = load %Expression, %Expression* %t53
  %t55 = icmp eq i32 %t49, 18
  %t56 = select i1 %t55, %Expression %t54, %Expression zeroinitializer
  %t57 = getelementptr inbounds %Statement, %Statement* %t50, i32 0, i32 1
  %t58 = bitcast [16 x i8]* %t57 to i8*
  %t59 = bitcast i8* %t58 to %Expression*
  %t60 = load %Expression, %Expression* %t59
  %t61 = icmp eq i32 %t49, 21
  %t62 = select i1 %t61, %Expression %t60, %Expression %t56
  %t63 = call i8* @format_expression(%Expression %t62)
  %t64 = call i8* @sailfin_runtime_string_concat(i8* %s48, i8* %t63)
  %t65 = call %NativeState @state_emit_line(%NativeState %t47, i8* %t64)
  ret %NativeState %t65
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
  %s25 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2080793783, i32 0, i32 0
  %t26 = extractvalue %Statement %statement, 0
  %t27 = alloca %Statement
  store %Statement %statement, %Statement* %t27
  %t28 = getelementptr inbounds %Statement, %Statement* %t27, i32 0, i32 1
  %t29 = bitcast [24 x i8]* %t28 to i8*
  %t30 = bitcast i8* %t29 to %Expression*
  %t31 = load %Expression, %Expression* %t30
  %t32 = icmp eq i32 %t26, 18
  %t33 = select i1 %t32, %Expression %t31, %Expression zeroinitializer
  %t34 = getelementptr inbounds %Statement, %Statement* %t27, i32 0, i32 1
  %t35 = bitcast [16 x i8]* %t34 to i8*
  %t36 = bitcast i8* %t35 to %Expression*
  %t37 = load %Expression, %Expression* %t36
  %t38 = icmp eq i32 %t26, 21
  %t39 = select i1 %t38, %Expression %t37, %Expression %t33
  %t40 = call i8* @format_expression(%Expression %t39)
  %t41 = call i8* @sailfin_runtime_string_concat(i8* %s25, i8* %t40)
  %t42 = call %NativeState @state_emit_line(%NativeState %t24, i8* %t41)
  ret %NativeState %t42
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
  %s4 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
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
  %t34 = phi %NativeState [ %t7, %merge1 ], [ %t32, %loop.latch4 ]
  %t35 = phi double [ %t8, %merge1 ], [ %t33, %loop.latch4 ]
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
  call void @sailfin_runtime_bounds_check(i64 %t20, i64 %t23)
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
  %t37 = load double, double* %l1
  %t38 = load %NativeState, %NativeState* %l0
  ret %NativeState %t38
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
  %s11 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1482555192, i32 0, i32 0
  %t12 = load double, double* %l1
  %t13 = fptosi double %t12 to i64
  %t14 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %decorators
  %t15 = extractvalue { %Decorator*, i64 } %t14, 0
  %t16 = extractvalue { %Decorator*, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t13, i64 %t16)
  %t18 = getelementptr %Decorator, %Decorator* %t15, i64 %t13
  %t19 = load %Decorator, %Decorator* %t18
  %t20 = call i8* @format_decorator(%Decorator %t19)
  %t21 = call i8* @sailfin_runtime_string_concat(i8* %s11, i8* %t20)
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
  %t31 = load double, double* %l1
  %t32 = load %NativeState, %NativeState* %l0
  ret %NativeState %t32
}

define %NativeState @emit_signature_metadata(%NativeState %state, %FunctionSignature %signature) {
entry:
  %l0 = alloca %NativeState
  store %NativeState %state, %NativeState* %l0
  %t0 = extractvalue %FunctionSignature %signature, 3
  %t1 = icmp ne %TypeAnnotation* %t0, null
  %t2 = load %NativeState, %NativeState* %l0
  br i1 %t1, label %then0, label %else1
then0:
  %t3 = load %NativeState, %NativeState* %l0
  %s4 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1610966039, i32 0, i32 0
  %t5 = extractvalue %FunctionSignature %signature, 3
  %t6 = getelementptr %TypeAnnotation, %TypeAnnotation* %t5, i32 0, i32 0
  %t7 = load i8*, i8** %t6
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %s4, i8* %t7)
  %t9 = call %NativeState @state_emit_line(%NativeState %t3, i8* %t8)
  store %NativeState %t9, %NativeState* %l0
  %t10 = load %NativeState, %NativeState* %l0
  br label %merge2
else1:
  %t11 = load %NativeState, %NativeState* %l0
  %s12 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1970266448, i32 0, i32 0
  %t13 = call %NativeState @state_emit_line(%NativeState %t11, i8* %s12)
  store %NativeState %t13, %NativeState* %l0
  %t14 = load %NativeState, %NativeState* %l0
  br label %merge2
merge2:
  %t15 = phi %NativeState [ %t10, %then0 ], [ %t14, %else1 ]
  store %NativeState %t15, %NativeState* %l0
  %t16 = extractvalue %FunctionSignature %signature, 4
  %t17 = load { i8**, i64 }, { i8**, i64 }* %t16
  %t18 = extractvalue { i8**, i64 } %t17, 1
  %t19 = icmp sgt i64 %t18, 0
  %t20 = load %NativeState, %NativeState* %l0
  br i1 %t19, label %then3, label %else4
then3:
  %t21 = load %NativeState, %NativeState* %l0
  %s22 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h110444378, i32 0, i32 0
  %t23 = extractvalue %FunctionSignature %signature, 4
  %s24 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t25 = call i8* @join_with_separator({ i8**, i64 }* %t23, i8* %s24)
  %t26 = call i8* @sailfin_runtime_string_concat(i8* %s22, i8* %t25)
  %t27 = call %NativeState @state_emit_line(%NativeState %t21, i8* %t26)
  store %NativeState %t27, %NativeState* %l0
  %t28 = load %NativeState, %NativeState* %l0
  br label %merge5
else4:
  %t29 = load %NativeState, %NativeState* %l0
  %s30 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.len18.h1250048525, i32 0, i32 0
  %t31 = call %NativeState @state_emit_line(%NativeState %t29, i8* %s30)
  store %NativeState %t31, %NativeState* %l0
  %t32 = load %NativeState, %NativeState* %l0
  br label %merge5
merge5:
  %t33 = phi %NativeState [ %t28, %then3 ], [ %t32, %else4 ]
  store %NativeState %t33, %NativeState* %l0
  %t34 = extractvalue %FunctionSignature %signature, 5
  %t35 = load { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t34
  %t36 = extractvalue { %TypeParameter**, i64 } %t35, 1
  %t37 = icmp sgt i64 %t36, 0
  %t38 = load %NativeState, %NativeState* %l0
  br i1 %t37, label %then6, label %merge7
then6:
  %t39 = load %NativeState, %NativeState* %l0
  %s40 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1897143060, i32 0, i32 0
  %t41 = extractvalue %FunctionSignature %signature, 5
  %t42 = bitcast { %TypeParameter**, i64 }* %t41 to { %TypeParameter*, i64 }*
  %t43 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t42)
  %t44 = call i8* @sailfin_runtime_string_concat(i8* %s40, i8* %t43)
  %t45 = call %NativeState @state_emit_line(%NativeState %t39, i8* %t44)
  store %NativeState %t45, %NativeState* %l0
  %t46 = load %NativeState, %NativeState* %l0
  br label %merge7
merge7:
  %t47 = phi %NativeState [ %t46, %then6 ], [ %t38, %merge5 ]
  store %NativeState %t47, %NativeState* %l0
  %t48 = load %NativeState, %NativeState* %l0
  ret %NativeState %t48
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
  %t80 = phi %NativeState [ %t1, %entry ], [ %t78, %loop.latch2 ]
  %t81 = phi double [ %t2, %entry ], [ %t79, %loop.latch2 ]
  store %NativeState %t80, %NativeState* %l0
  store double %t81, double* %l1
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
  call void @sailfin_runtime_bounds_check(i64 %t11, i64 %t14)
  %t16 = getelementptr %Parameter, %Parameter* %t13, i64 %t11
  %t17 = load %Parameter, %Parameter* %t16
  store %Parameter %t17, %Parameter* %l2
  %t18 = load %NativeState, %NativeState* %l0
  %t19 = load %Parameter, %Parameter* %l2
  %t20 = extractvalue %Parameter %t19, 4
  %t21 = call %NativeState @emit_span_if_present(%NativeState %t18, %SourceSpan* %t20)
  store %NativeState %t21, %NativeState* %l0
  %s22 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h130169768, i32 0, i32 0
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
  %s30 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t31 = call i8* @sailfin_runtime_string_concat(i8* %t29, i8* %s30)
  store i8* %t31, i8** %l3
  %t32 = load i8*, i8** %l3
  br label %merge7
merge7:
  %t33 = phi i8* [ %t32, %then6 ], [ %t28, %merge5 ]
  store i8* %t33, i8** %l3
  %t34 = load i8*, i8** %l3
  %t35 = load %Parameter, %Parameter* %l2
  %t36 = extractvalue %Parameter %t35, 0
  %t37 = call i8* @sailfin_runtime_string_concat(i8* %t34, i8* %t36)
  store i8* %t37, i8** %l3
  %t38 = load %Parameter, %Parameter* %l2
  %t39 = extractvalue %Parameter %t38, 1
  %t40 = icmp ne %TypeAnnotation* %t39, null
  %t41 = load %NativeState, %NativeState* %l0
  %t42 = load double, double* %l1
  %t43 = load %Parameter, %Parameter* %l2
  %t44 = load i8*, i8** %l3
  br i1 %t40, label %then8, label %merge9
then8:
  %t45 = load i8*, i8** %l3
  %s46 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h173787542, i32 0, i32 0
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %t45, i8* %s46)
  %t48 = load %Parameter, %Parameter* %l2
  %t49 = extractvalue %Parameter %t48, 1
  %t50 = getelementptr %TypeAnnotation, %TypeAnnotation* %t49, i32 0, i32 0
  %t51 = load i8*, i8** %t50
  %t52 = call i8* @sailfin_runtime_string_concat(i8* %t47, i8* %t51)
  store i8* %t52, i8** %l3
  %t53 = load i8*, i8** %l3
  br label %merge9
merge9:
  %t54 = phi i8* [ %t53, %then8 ], [ %t44, %merge7 ]
  store i8* %t54, i8** %l3
  %t55 = load %Parameter, %Parameter* %l2
  %t56 = extractvalue %Parameter %t55, 2
  %t57 = icmp ne %Expression* %t56, null
  %t58 = load %NativeState, %NativeState* %l0
  %t59 = load double, double* %l1
  %t60 = load %Parameter, %Parameter* %l2
  %t61 = load i8*, i8** %l3
  br i1 %t57, label %then10, label %merge11
then10:
  %t62 = load i8*, i8** %l3
  %s63 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t64 = call i8* @sailfin_runtime_string_concat(i8* %t62, i8* %s63)
  %t65 = load %Parameter, %Parameter* %l2
  %t66 = extractvalue %Parameter %t65, 2
  %t67 = load %Expression, %Expression* %t66
  %t68 = call i8* @format_expression(%Expression %t67)
  %t69 = call i8* @sailfin_runtime_string_concat(i8* %t64, i8* %t68)
  store i8* %t69, i8** %l3
  %t70 = load i8*, i8** %l3
  br label %merge11
merge11:
  %t71 = phi i8* [ %t70, %then10 ], [ %t61, %merge9 ]
  store i8* %t71, i8** %l3
  %t72 = load %NativeState, %NativeState* %l0
  %t73 = load i8*, i8** %l3
  %t74 = call %NativeState @state_emit_line(%NativeState %t72, i8* %t73)
  store %NativeState %t74, %NativeState* %l0
  %t75 = load double, double* %l1
  %t76 = sitofp i64 1 to double
  %t77 = fadd double %t75, %t76
  store double %t77, double* %l1
  br label %loop.latch2
loop.latch2:
  %t78 = load %NativeState, %NativeState* %l0
  %t79 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t82 = load %NativeState, %NativeState* %l0
  %t83 = load double, double* %l1
  %t84 = load %NativeState, %NativeState* %l0
  ret %NativeState %t84
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
  %t78 = phi { i8**, i64 }* [ %t20, %merge1 ], [ %t76, %loop.latch4 ]
  %t79 = phi double [ %t21, %merge1 ], [ %t77, %loop.latch4 ]
  store { i8**, i64 }* %t78, { i8**, i64 }** %l1
  store double %t79, double* %l2
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
  call void @sailfin_runtime_bounds_check(i64 %t33, i64 %t36)
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
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge10
else9:
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t69 = load i8*, i8** %l4
  %t70 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t68, i8* %t69)
  store { i8**, i64 }* %t70, { i8**, i64 }** %l1
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge10
merge10:
  %t72 = phi { i8**, i64 }* [ %t67, %then8 ], [ %t71, %else9 ]
  store { i8**, i64 }* %t72, { i8**, i64 }** %l1
  %t73 = load double, double* %l2
  %t74 = sitofp i64 1 to double
  %t75 = fadd double %t73, %t74
  store double %t75, double* %l2
  br label %loop.latch4
loop.latch4:
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t77 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t81 = load double, double* %l2
  %t82 = load i8*, i8** %l0
  %t83 = load i8, i8* %t82
  %t84 = add i8 %t83, 40
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s86 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t87 = call i8* @join_with_separator({ i8**, i64 }* %t85, i8* %s86)
  %t88 = load i8, i8* %t87
  %t89 = add i8 %t84, %t88
  %t90 = add i8 %t89, 41
  %t91 = alloca [2 x i8], align 1
  %t92 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 0
  store i8 %t90, i8* %t92
  %t93 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 1
  store i8 0, i8* %t93
  %t94 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 0
  ret i8* %t94
}

define i8* @format_function_signature(%FunctionSignature %signature) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = extractvalue %FunctionSignature %signature, 1
  %t2 = load i8*, i8** %l0
  br i1 %t1, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1134498859, i32 0, i32 0
  store i8* %s3, i8** %l0
  %t4 = load i8*, i8** %l0
  br label %merge1
merge1:
  %t5 = phi i8* [ %t4, %then0 ], [ %t2, %entry ]
  store i8* %t5, i8** %l0
  %t6 = load i8*, i8** %l0
  %t7 = extractvalue %FunctionSignature %signature, 0
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %t6, i8* %t7)
  store i8* %t8, i8** %l1
  %t9 = load i8*, i8** %l1
  %t10 = extractvalue %FunctionSignature %signature, 5
  %t11 = bitcast { %TypeParameter**, i64 }* %t10 to { %TypeParameter*, i64 }*
  %t12 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* %t11)
  %t13 = call i8* @sailfin_runtime_string_concat(i8* %t9, i8* %t12)
  store i8* %t13, i8** %l1
  %t14 = load i8*, i8** %l1
  %t15 = load i8, i8* %t14
  %t16 = add i8 %t15, 40
  %t17 = extractvalue %FunctionSignature %signature, 2
  %t18 = bitcast { %Parameter**, i64 }* %t17 to { %Parameter*, i64 }*
  %t19 = call i8* @format_parameters({ %Parameter*, i64 }* %t18)
  %t20 = load i8, i8* %t19
  %t21 = add i8 %t16, %t20
  %t22 = add i8 %t21, 41
  %t23 = alloca [2 x i8], align 1
  %t24 = getelementptr [2 x i8], [2 x i8]* %t23, i32 0, i32 0
  store i8 %t22, i8* %t24
  %t25 = getelementptr [2 x i8], [2 x i8]* %t23, i32 0, i32 1
  store i8 0, i8* %t25
  %t26 = getelementptr [2 x i8], [2 x i8]* %t23, i32 0, i32 0
  store i8* %t26, i8** %l1
  %t27 = extractvalue %FunctionSignature %signature, 3
  %t28 = icmp ne %TypeAnnotation* %t27, null
  %t29 = load i8*, i8** %l0
  %t30 = load i8*, i8** %l1
  br i1 %t28, label %then2, label %merge3
then2:
  %t31 = load i8*, i8** %l1
  %s32 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h173787542, i32 0, i32 0
  %t33 = call i8* @sailfin_runtime_string_concat(i8* %t31, i8* %s32)
  %t34 = extractvalue %FunctionSignature %signature, 3
  %t35 = getelementptr %TypeAnnotation, %TypeAnnotation* %t34, i32 0, i32 0
  %t36 = load i8*, i8** %t35
  %t37 = call i8* @sailfin_runtime_string_concat(i8* %t33, i8* %t36)
  store i8* %t37, i8** %l1
  %t38 = load i8*, i8** %l1
  br label %merge3
merge3:
  %t39 = phi i8* [ %t38, %then2 ], [ %t30, %merge1 ]
  store i8* %t39, i8** %l1
  %t40 = extractvalue %FunctionSignature %signature, 4
  %t41 = load { i8**, i64 }, { i8**, i64 }* %t40
  %t42 = extractvalue { i8**, i64 } %t41, 1
  %t43 = icmp sgt i64 %t42, 0
  %t44 = load i8*, i8** %l0
  %t45 = load i8*, i8** %l1
  br i1 %t43, label %then4, label %merge5
then4:
  %t46 = load i8*, i8** %l1
  %s47 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087662534, i32 0, i32 0
  %t48 = call i8* @sailfin_runtime_string_concat(i8* %t46, i8* %s47)
  %t49 = extractvalue %FunctionSignature %signature, 4
  %s50 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t51 = call i8* @join_with_separator({ i8**, i64 }* %t49, i8* %s50)
  %t52 = call i8* @sailfin_runtime_string_concat(i8* %t48, i8* %t51)
  %t53 = load i8, i8* %t52
  %t54 = add i8 %t53, 93
  %t55 = alloca [2 x i8], align 1
  %t56 = getelementptr [2 x i8], [2 x i8]* %t55, i32 0, i32 0
  store i8 %t54, i8* %t56
  %t57 = getelementptr [2 x i8], [2 x i8]* %t55, i32 0, i32 1
  store i8 0, i8* %t57
  %t58 = getelementptr [2 x i8], [2 x i8]* %t55, i32 0, i32 0
  store i8* %t58, i8** %l1
  %t59 = load i8*, i8** %l1
  br label %merge5
merge5:
  %t60 = phi i8* [ %t59, %then4 ], [ %t45, %merge3 ]
  store i8* %t60, i8** %l1
  %t61 = load i8*, i8** %l1
  ret i8* %t61
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
  %t85 = phi { i8**, i64 }* [ %t10, %merge1 ], [ %t83, %loop.latch4 ]
  %t86 = phi double [ %t11, %merge1 ], [ %t84, %loop.latch4 ]
  store { i8**, i64 }* %t85, { i8**, i64 }** %l0
  store double %t86, double* %l1
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
  call void @sailfin_runtime_bounds_check(i64 %t20, i64 %t23)
  %t25 = getelementptr %Parameter, %Parameter* %t22, i64 %t20
  %t26 = load %Parameter, %Parameter* %t25
  store %Parameter %t26, %Parameter* %l2
  %s27 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s27, i8** %l3
  %t28 = load %Parameter, %Parameter* %l2
  %t29 = extractvalue %Parameter %t28, 3
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load double, double* %l1
  %t32 = load %Parameter, %Parameter* %l2
  %t33 = load i8*, i8** %l3
  br i1 %t29, label %then8, label %else9
then8:
  %s34 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t35 = load %Parameter, %Parameter* %l2
  %t36 = extractvalue %Parameter %t35, 0
  %t37 = call i8* @sailfin_runtime_string_concat(i8* %s34, i8* %t36)
  store i8* %t37, i8** %l3
  %t38 = load i8*, i8** %l3
  br label %merge10
else9:
  %t39 = load %Parameter, %Parameter* %l2
  %t40 = extractvalue %Parameter %t39, 0
  store i8* %t40, i8** %l3
  %t41 = load i8*, i8** %l3
  br label %merge10
merge10:
  %t42 = phi i8* [ %t38, %then8 ], [ %t41, %else9 ]
  store i8* %t42, i8** %l3
  %t43 = load %Parameter, %Parameter* %l2
  %t44 = extractvalue %Parameter %t43, 1
  %t45 = icmp ne %TypeAnnotation* %t44, null
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load double, double* %l1
  %t48 = load %Parameter, %Parameter* %l2
  %t49 = load i8*, i8** %l3
  br i1 %t45, label %then11, label %merge12
then11:
  %t50 = load i8*, i8** %l3
  %s51 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h173787542, i32 0, i32 0
  %t52 = call i8* @sailfin_runtime_string_concat(i8* %t50, i8* %s51)
  %t53 = load %Parameter, %Parameter* %l2
  %t54 = extractvalue %Parameter %t53, 1
  %t55 = getelementptr %TypeAnnotation, %TypeAnnotation* %t54, i32 0, i32 0
  %t56 = load i8*, i8** %t55
  %t57 = call i8* @sailfin_runtime_string_concat(i8* %t52, i8* %t56)
  store i8* %t57, i8** %l3
  %t58 = load i8*, i8** %l3
  br label %merge12
merge12:
  %t59 = phi i8* [ %t58, %then11 ], [ %t49, %merge10 ]
  store i8* %t59, i8** %l3
  %t60 = load %Parameter, %Parameter* %l2
  %t61 = extractvalue %Parameter %t60, 2
  %t62 = icmp ne %Expression* %t61, null
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t64 = load double, double* %l1
  %t65 = load %Parameter, %Parameter* %l2
  %t66 = load i8*, i8** %l3
  br i1 %t62, label %then13, label %merge14
then13:
  %t67 = load i8*, i8** %l3
  %s68 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t69 = call i8* @sailfin_runtime_string_concat(i8* %t67, i8* %s68)
  %t70 = load %Parameter, %Parameter* %l2
  %t71 = extractvalue %Parameter %t70, 2
  %t72 = load %Expression, %Expression* %t71
  %t73 = call i8* @format_expression(%Expression %t72)
  %t74 = call i8* @sailfin_runtime_string_concat(i8* %t69, i8* %t73)
  store i8* %t74, i8** %l3
  %t75 = load i8*, i8** %l3
  br label %merge14
merge14:
  %t76 = phi i8* [ %t75, %then13 ], [ %t66, %merge12 ]
  store i8* %t76, i8** %l3
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t78 = load i8*, i8** %l3
  %t79 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t77, i8* %t78)
  store { i8**, i64 }* %t79, { i8**, i64 }** %l0
  %t80 = load double, double* %l1
  %t81 = sitofp i64 1 to double
  %t82 = fadd double %t80, %t81
  store double %t82, double* %l1
  br label %loop.latch4
loop.latch4:
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t84 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t88 = load double, double* %l1
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s90 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t91 = call i8* @join_with_separator({ i8**, i64 }* %t89, i8* %s90)
  ret i8* %t91
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
  %t54 = phi { i8**, i64 }* [ %t10, %merge1 ], [ %t52, %loop.latch4 ]
  %t55 = phi double [ %t11, %merge1 ], [ %t53, %loop.latch4 ]
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
  call void @sailfin_runtime_bounds_check(i64 %t20, i64 %t23)
  %t25 = getelementptr %TypeParameter, %TypeParameter* %t22, i64 %t20
  %t26 = load %TypeParameter, %TypeParameter* %t25
  store %TypeParameter %t26, %TypeParameter* %l2
  %t27 = load %TypeParameter, %TypeParameter* %l2
  %t28 = extractvalue %TypeParameter %t27, 0
  store i8* %t28, i8** %l3
  %t29 = load %TypeParameter, %TypeParameter* %l2
  %t30 = extractvalue %TypeParameter %t29, 1
  %t31 = icmp ne %TypeAnnotation* %t30, null
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load double, double* %l1
  %t34 = load %TypeParameter, %TypeParameter* %l2
  %t35 = load i8*, i8** %l3
  br i1 %t31, label %then8, label %merge9
then8:
  %t36 = load i8*, i8** %l3
  %s37 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087687812, i32 0, i32 0
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %t36, i8* %s37)
  %t39 = load %TypeParameter, %TypeParameter* %l2
  %t40 = extractvalue %TypeParameter %t39, 1
  %t41 = getelementptr %TypeAnnotation, %TypeAnnotation* %t40, i32 0, i32 0
  %t42 = load i8*, i8** %t41
  %t43 = call i8* @sailfin_runtime_string_concat(i8* %t38, i8* %t42)
  store i8* %t43, i8** %l3
  %t44 = load i8*, i8** %l3
  br label %merge9
merge9:
  %t45 = phi i8* [ %t44, %then8 ], [ %t35, %merge7 ]
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
  %t57 = load double, double* %l1
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s59 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t60 = call i8* @join_with_separator({ i8**, i64 }* %t58, i8* %s59)
  %t61 = load i8, i8* %t60
  %t62 = add i8 60, %t61
  %t63 = add i8 %t62, 62
  %t64 = alloca [2 x i8], align 1
  %t65 = getelementptr [2 x i8], [2 x i8]* %t64, i32 0, i32 0
  store i8 %t63, i8* %t65
  %t66 = getelementptr [2 x i8], [2 x i8]* %t64, i32 0, i32 1
  store i8 0, i8* %t66
  %t67 = getelementptr [2 x i8], [2 x i8]* %t64, i32 0, i32 0
  ret i8* %t67
}

define i8* @format_field(%FieldDeclaration %field) {
entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = extractvalue %FieldDeclaration %field, 2
  %t2 = load i8*, i8** %l0
  br i1 %t1, label %then0, label %merge1
then0:
  %t3 = load i8*, i8** %l0
  %s4 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t3, i8* %s4)
  store i8* %t5, i8** %l0
  %t6 = load i8*, i8** %l0
  br label %merge1
merge1:
  %t7 = phi i8* [ %t6, %then0 ], [ %t2, %entry ]
  store i8* %t7, i8** %l0
  %t8 = load i8*, i8** %l0
  %t9 = extractvalue %FieldDeclaration %field, 0
  %t10 = call i8* @sailfin_runtime_string_concat(i8* %t8, i8* %t9)
  %s11 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h173787542, i32 0, i32 0
  %t12 = call i8* @sailfin_runtime_string_concat(i8* %t10, i8* %s11)
  %t13 = extractvalue %FieldDeclaration %field, 1
  %t14 = extractvalue %TypeAnnotation %t13, 0
  %t15 = call i8* @sailfin_runtime_string_concat(i8* %t12, i8* %t14)
  store i8* %t15, i8** %l0
  %t16 = load i8*, i8** %l0
  ret i8* %t16
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
  %t39 = phi { i8**, i64 }* [ %t11, %merge1 ], [ %t37, %loop.latch4 ]
  %t40 = phi double [ %t12, %merge1 ], [ %t38, %loop.latch4 ]
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
  call void @sailfin_runtime_bounds_check(i64 %t24, i64 %t27)
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
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load double, double* %l1
  %t43 = extractvalue %EnumVariant %variant, 0
  %s44 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087758597, i32 0, i32 0
  %t45 = call i8* @sailfin_runtime_string_concat(i8* %t43, i8* %s44)
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s47 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193442306, i32 0, i32 0
  %t48 = call i8* @join_with_separator({ i8**, i64 }* %t46, i8* %s47)
  %t49 = call i8* @sailfin_runtime_string_concat(i8* %t45, i8* %t48)
  %s50 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415972, i32 0, i32 0
  %t51 = call i8* @sailfin_runtime_string_concat(i8* %t49, i8* %s50)
  ret i8* %t51
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
  %s2 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h789690461, i32 0, i32 0
  %t3 = alloca [0 x i8*]
  %t4 = getelementptr [0 x i8*], [0 x i8*]* %t3, i32 0, i32 0
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t4, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 0, i64* %t7
  %t8 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t5, i8* %struct_name)
  %t9 = call %RecordLayoutResult @calculate_record_layout(%LayoutContext %context, { %LayoutFieldInput*, i64 }* %t1, i8* %s2, i8* %struct_name, { i8**, i64 }* %t8)
  store %RecordLayoutResult %t9, %RecordLayoutResult* %l1
  %t10 = alloca [0 x i8*]
  %t11 = getelementptr [0 x i8*], [0 x i8*]* %t10, i32 0, i32 0
  %t12 = alloca { i8**, i64 }
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t11, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { i8**, i64 }* %t12, { i8**, i64 }** %l2
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s16 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h239636501, i32 0, i32 0
  %t17 = call i8* @sailfin_runtime_string_concat(i8* %s16, i8* %struct_name)
  %s18 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h922402750, i32 0, i32 0
  %t19 = call i8* @sailfin_runtime_string_concat(i8* %t17, i8* %s18)
  %t20 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t21 = extractvalue %RecordLayoutResult %t20, 0
  %t22 = call i8* @number_to_string(double %t21)
  %t23 = call i8* @sailfin_runtime_string_concat(i8* %t19, i8* %t22)
  %s24 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h847788946, i32 0, i32 0
  %t25 = call i8* @sailfin_runtime_string_concat(i8* %t23, i8* %s24)
  %t26 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t27 = extractvalue %RecordLayoutResult %t26, 1
  %t28 = call i8* @number_to_string(double %t27)
  %t29 = call i8* @sailfin_runtime_string_concat(i8* %t25, i8* %t28)
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
  %t101 = phi { i8**, i64 }* [ %t34, %entry ], [ %t99, %loop.latch2 ]
  %t102 = phi double [ %t35, %entry ], [ %t100, %loop.latch2 ]
  store { i8**, i64 }* %t101, { i8**, i64 }** %l2
  store double %t102, double* %l3
  br label %loop.body1
loop.body1:
  %t36 = load double, double* %l3
  %t37 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t38 = extractvalue %RecordLayoutResult %t37, 2
  %t39 = load { %StructFieldLayoutDescriptor**, i64 }, { %StructFieldLayoutDescriptor**, i64 }* %t38
  %t40 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t39, 1
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
  %t50 = fptosi double %t49 to i64
  %t51 = load { %StructFieldLayoutDescriptor**, i64 }, { %StructFieldLayoutDescriptor**, i64 }* %t48
  %t52 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t51, 0
  %t53 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t51, 1
  %t54 = icmp uge i64 %t50, %t53
  ; bounds check: %t54 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t50, i64 %t53)
  %t55 = getelementptr %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t52, i64 %t50
  %t56 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t55
  store %StructFieldLayoutDescriptor* %t56, %StructFieldLayoutDescriptor** %l4
  %s57 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1053492670, i32 0, i32 0
  %t58 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l4
  %t59 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t58, i32 0, i32 0
  %t60 = load i8*, i8** %t59
  %t61 = call i8* @sailfin_runtime_string_concat(i8* %s57, i8* %t60)
  store i8* %t61, i8** %l5
  %t62 = load i8*, i8** %l5
  %s63 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h980153509, i32 0, i32 0
  %t64 = call i8* @sailfin_runtime_string_concat(i8* %t62, i8* %s63)
  %t65 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l4
  %t66 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t65, i32 0, i32 1
  %t67 = load i8*, i8** %t66
  %t68 = call i8* @sailfin_runtime_string_concat(i8* %t64, i8* %t67)
  store i8* %t68, i8** %l5
  %t69 = load i8*, i8** %l5
  %s70 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h455185518, i32 0, i32 0
  %t71 = call i8* @sailfin_runtime_string_concat(i8* %t69, i8* %s70)
  %t72 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l4
  %t73 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t72, i32 0, i32 2
  %t74 = load double, double* %t73
  %t75 = call i8* @number_to_string(double %t74)
  %t76 = call i8* @sailfin_runtime_string_concat(i8* %t71, i8* %t75)
  store i8* %t76, i8** %l5
  %t77 = load i8*, i8** %l5
  %s78 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h922402750, i32 0, i32 0
  %t79 = call i8* @sailfin_runtime_string_concat(i8* %t77, i8* %s78)
  %t80 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l4
  %t81 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t80, i32 0, i32 3
  %t82 = load double, double* %t81
  %t83 = call i8* @number_to_string(double %t82)
  %t84 = call i8* @sailfin_runtime_string_concat(i8* %t79, i8* %t83)
  store i8* %t84, i8** %l5
  %t85 = load i8*, i8** %l5
  %s86 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h847788946, i32 0, i32 0
  %t87 = call i8* @sailfin_runtime_string_concat(i8* %t85, i8* %s86)
  %t88 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l4
  %t89 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t88, i32 0, i32 4
  %t90 = load double, double* %t89
  %t91 = call i8* @number_to_string(double %t90)
  %t92 = call i8* @sailfin_runtime_string_concat(i8* %t87, i8* %t91)
  store i8* %t92, i8** %l5
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t94 = load i8*, i8** %l5
  %t95 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t93, i8* %t94)
  store { i8**, i64 }* %t95, { i8**, i64 }** %l2
  %t96 = load double, double* %l3
  %t97 = sitofp i64 1 to double
  %t98 = fadd double %t96, %t97
  store double %t98, double* %l3
  br label %loop.latch2
loop.latch2:
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t100 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t104 = load double, double* %l3
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t106 = insertvalue %LayoutEmitResult undef, { i8**, i64 }* %t105, 0
  %t107 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t108 = extractvalue %RecordLayoutResult %t107, 3
  %t109 = insertvalue %LayoutEmitResult %t106, { i8**, i64 }* %t108, 1
  ret %LayoutEmitResult %t109
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
  call void @sailfin_runtime_bounds_check(i64 %t34, i64 %t37)
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
  %t60 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t61 = load double, double* %l1
  %t62 = extractvalue %Statement %statement, 0
  %t63 = alloca %Statement
  store %Statement %statement, %Statement* %t63
  %t64 = getelementptr inbounds %Statement, %Statement* %t63, i32 0, i32 1
  %t65 = bitcast [48 x i8]* %t64 to i8*
  %t66 = bitcast i8* %t65 to i8**
  %t67 = load i8*, i8** %t66
  %t68 = icmp eq i32 %t62, 2
  %t69 = select i1 %t68, i8* %t67, i8* null
  %t70 = getelementptr inbounds %Statement, %Statement* %t63, i32 0, i32 1
  %t71 = bitcast [48 x i8]* %t70 to i8*
  %t72 = bitcast i8* %t71 to i8**
  %t73 = load i8*, i8** %t72
  %t74 = icmp eq i32 %t62, 3
  %t75 = select i1 %t74, i8* %t73, i8* %t69
  %t76 = getelementptr inbounds %Statement, %Statement* %t63, i32 0, i32 1
  %t77 = bitcast [40 x i8]* %t76 to i8*
  %t78 = bitcast i8* %t77 to i8**
  %t79 = load i8*, i8** %t78
  %t80 = icmp eq i32 %t62, 6
  %t81 = select i1 %t80, i8* %t79, i8* %t75
  %t82 = getelementptr inbounds %Statement, %Statement* %t63, i32 0, i32 1
  %t83 = bitcast [56 x i8]* %t82 to i8*
  %t84 = bitcast i8* %t83 to i8**
  %t85 = load i8*, i8** %t84
  %t86 = icmp eq i32 %t62, 8
  %t87 = select i1 %t86, i8* %t85, i8* %t81
  %t88 = getelementptr inbounds %Statement, %Statement* %t63, i32 0, i32 1
  %t89 = bitcast [40 x i8]* %t88 to i8*
  %t90 = bitcast i8* %t89 to i8**
  %t91 = load i8*, i8** %t90
  %t92 = icmp eq i32 %t62, 9
  %t93 = select i1 %t92, i8* %t91, i8* %t87
  %t94 = getelementptr inbounds %Statement, %Statement* %t63, i32 0, i32 1
  %t95 = bitcast [40 x i8]* %t94 to i8*
  %t96 = bitcast i8* %t95 to i8**
  %t97 = load i8*, i8** %t96
  %t98 = icmp eq i32 %t62, 10
  %t99 = select i1 %t98, i8* %t97, i8* %t93
  %t100 = getelementptr inbounds %Statement, %Statement* %t63, i32 0, i32 1
  %t101 = bitcast [40 x i8]* %t100 to i8*
  %t102 = bitcast i8* %t101 to i8**
  %t103 = load i8*, i8** %t102
  %t104 = icmp eq i32 %t62, 11
  %t105 = select i1 %t104, i8* %t103, i8* %t99
  %t106 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t107 = alloca [0 x i8*]
  %t108 = getelementptr [0 x i8*], [0 x i8*]* %t107, i32 0, i32 0
  %t109 = alloca { i8**, i64 }
  %t110 = getelementptr { i8**, i64 }, { i8**, i64 }* %t109, i32 0, i32 0
  store i8** %t108, i8*** %t110
  %t111 = getelementptr { i8**, i64 }, { i8**, i64 }* %t109, i32 0, i32 1
  store i64 0, i64* %t111
  %t112 = extractvalue %Statement %statement, 0
  %t113 = alloca %Statement
  store %Statement %statement, %Statement* %t113
  %t114 = getelementptr inbounds %Statement, %Statement* %t113, i32 0, i32 1
  %t115 = bitcast [48 x i8]* %t114 to i8*
  %t116 = bitcast i8* %t115 to i8**
  %t117 = load i8*, i8** %t116
  %t118 = icmp eq i32 %t112, 2
  %t119 = select i1 %t118, i8* %t117, i8* null
  %t120 = getelementptr inbounds %Statement, %Statement* %t113, i32 0, i32 1
  %t121 = bitcast [48 x i8]* %t120 to i8*
  %t122 = bitcast i8* %t121 to i8**
  %t123 = load i8*, i8** %t122
  %t124 = icmp eq i32 %t112, 3
  %t125 = select i1 %t124, i8* %t123, i8* %t119
  %t126 = getelementptr inbounds %Statement, %Statement* %t113, i32 0, i32 1
  %t127 = bitcast [40 x i8]* %t126 to i8*
  %t128 = bitcast i8* %t127 to i8**
  %t129 = load i8*, i8** %t128
  %t130 = icmp eq i32 %t112, 6
  %t131 = select i1 %t130, i8* %t129, i8* %t125
  %t132 = getelementptr inbounds %Statement, %Statement* %t113, i32 0, i32 1
  %t133 = bitcast [56 x i8]* %t132 to i8*
  %t134 = bitcast i8* %t133 to i8**
  %t135 = load i8*, i8** %t134
  %t136 = icmp eq i32 %t112, 8
  %t137 = select i1 %t136, i8* %t135, i8* %t131
  %t138 = getelementptr inbounds %Statement, %Statement* %t113, i32 0, i32 1
  %t139 = bitcast [40 x i8]* %t138 to i8*
  %t140 = bitcast i8* %t139 to i8**
  %t141 = load i8*, i8** %t140
  %t142 = icmp eq i32 %t112, 9
  %t143 = select i1 %t142, i8* %t141, i8* %t137
  %t144 = getelementptr inbounds %Statement, %Statement* %t113, i32 0, i32 1
  %t145 = bitcast [40 x i8]* %t144 to i8*
  %t146 = bitcast i8* %t145 to i8**
  %t147 = load i8*, i8** %t146
  %t148 = icmp eq i32 %t112, 10
  %t149 = select i1 %t148, i8* %t147, i8* %t143
  %t150 = getelementptr inbounds %Statement, %Statement* %t113, i32 0, i32 1
  %t151 = bitcast [40 x i8]* %t150 to i8*
  %t152 = bitcast i8* %t151 to i8**
  %t153 = load i8*, i8** %t152
  %t154 = icmp eq i32 %t112, 11
  %t155 = select i1 %t154, i8* %t153, i8* %t149
  %t156 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t109, i8* %t155)
  %t157 = call %EnumAggregateLayout @infer_enum_aggregate_layout(%LayoutContext %context, i8* %t105, { %LayoutEnumVariantDefinition*, i64 }* %t106, { i8**, i64 }* %t156)
  store %EnumAggregateLayout %t157, %EnumAggregateLayout* %l4
  %t158 = alloca [0 x i8*]
  %t159 = getelementptr [0 x i8*], [0 x i8*]* %t158, i32 0, i32 0
  %t160 = alloca { i8**, i64 }
  %t161 = getelementptr { i8**, i64 }, { i8**, i64 }* %t160, i32 0, i32 0
  store i8** %t159, i8*** %t161
  %t162 = getelementptr { i8**, i64 }, { i8**, i64 }* %t160, i32 0, i32 1
  store i64 0, i64* %t162
  store { i8**, i64 }* %t160, { i8**, i64 }** %l5
  %s163 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.len18.h548024877, i32 0, i32 0
  %t164 = extractvalue %Statement %statement, 0
  %t165 = alloca %Statement
  store %Statement %statement, %Statement* %t165
  %t166 = getelementptr inbounds %Statement, %Statement* %t165, i32 0, i32 1
  %t167 = bitcast [48 x i8]* %t166 to i8*
  %t168 = bitcast i8* %t167 to i8**
  %t169 = load i8*, i8** %t168
  %t170 = icmp eq i32 %t164, 2
  %t171 = select i1 %t170, i8* %t169, i8* null
  %t172 = getelementptr inbounds %Statement, %Statement* %t165, i32 0, i32 1
  %t173 = bitcast [48 x i8]* %t172 to i8*
  %t174 = bitcast i8* %t173 to i8**
  %t175 = load i8*, i8** %t174
  %t176 = icmp eq i32 %t164, 3
  %t177 = select i1 %t176, i8* %t175, i8* %t171
  %t178 = getelementptr inbounds %Statement, %Statement* %t165, i32 0, i32 1
  %t179 = bitcast [40 x i8]* %t178 to i8*
  %t180 = bitcast i8* %t179 to i8**
  %t181 = load i8*, i8** %t180
  %t182 = icmp eq i32 %t164, 6
  %t183 = select i1 %t182, i8* %t181, i8* %t177
  %t184 = getelementptr inbounds %Statement, %Statement* %t165, i32 0, i32 1
  %t185 = bitcast [56 x i8]* %t184 to i8*
  %t186 = bitcast i8* %t185 to i8**
  %t187 = load i8*, i8** %t186
  %t188 = icmp eq i32 %t164, 8
  %t189 = select i1 %t188, i8* %t187, i8* %t183
  %t190 = getelementptr inbounds %Statement, %Statement* %t165, i32 0, i32 1
  %t191 = bitcast [40 x i8]* %t190 to i8*
  %t192 = bitcast i8* %t191 to i8**
  %t193 = load i8*, i8** %t192
  %t194 = icmp eq i32 %t164, 9
  %t195 = select i1 %t194, i8* %t193, i8* %t189
  %t196 = getelementptr inbounds %Statement, %Statement* %t165, i32 0, i32 1
  %t197 = bitcast [40 x i8]* %t196 to i8*
  %t198 = bitcast i8* %t197 to i8**
  %t199 = load i8*, i8** %t198
  %t200 = icmp eq i32 %t164, 10
  %t201 = select i1 %t200, i8* %t199, i8* %t195
  %t202 = getelementptr inbounds %Statement, %Statement* %t165, i32 0, i32 1
  %t203 = bitcast [40 x i8]* %t202 to i8*
  %t204 = bitcast i8* %t203 to i8**
  %t205 = load i8*, i8** %t204
  %t206 = icmp eq i32 %t164, 11
  %t207 = select i1 %t206, i8* %t205, i8* %t201
  %t208 = call i8* @sailfin_runtime_string_concat(i8* %s163, i8* %t207)
  %s209 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h922402750, i32 0, i32 0
  %t210 = call i8* @sailfin_runtime_string_concat(i8* %t208, i8* %s209)
  %t211 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t212 = extractvalue %EnumAggregateLayout %t211, 0
  %t213 = call i8* @number_to_string(double %t212)
  %t214 = call i8* @sailfin_runtime_string_concat(i8* %t210, i8* %t213)
  %s215 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h847788946, i32 0, i32 0
  %t216 = call i8* @sailfin_runtime_string_concat(i8* %t214, i8* %s215)
  %t217 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t218 = extractvalue %EnumAggregateLayout %t217, 1
  %t219 = call i8* @number_to_string(double %t218)
  %t220 = call i8* @sailfin_runtime_string_concat(i8* %t216, i8* %t219)
  store i8* %t220, i8** %l6
  %t221 = load i8*, i8** %l6
  %s222 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.len23.h1863896425, i32 0, i32 0
  %t223 = call i8* @sailfin_runtime_string_concat(i8* %t221, i8* %s222)
  %t224 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t225 = extractvalue %EnumAggregateLayout %t224, 2
  %t226 = call i8* @number_to_string(double %t225)
  %t227 = call i8* @sailfin_runtime_string_concat(i8* %t223, i8* %t226)
  %s228 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1741471221, i32 0, i32 0
  %t229 = call i8* @sailfin_runtime_string_concat(i8* %t227, i8* %s228)
  %t230 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t231 = extractvalue %EnumAggregateLayout %t230, 3
  %t232 = call i8* @number_to_string(double %t231)
  %t233 = call i8* @sailfin_runtime_string_concat(i8* %t229, i8* %t232)
  store i8* %t233, i8** %l6
  %t234 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t235 = load i8*, i8** %l6
  %t236 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t234, i8* %t235)
  store { i8**, i64 }* %t236, { i8**, i64 }** %l5
  %t237 = sitofp i64 0 to double
  store double %t237, double* %l7
  %t238 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t239 = load double, double* %l1
  %t240 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t242 = load i8*, i8** %l6
  %t243 = load double, double* %l7
  br label %loop.header6
loop.header6:
  %t409 = phi { i8**, i64 }* [ %t241, %afterloop3 ], [ %t407, %loop.latch8 ]
  %t410 = phi double [ %t243, %afterloop3 ], [ %t408, %loop.latch8 ]
  store { i8**, i64 }* %t409, { i8**, i64 }** %l5
  store double %t410, double* %l7
  br label %loop.body7
loop.body7:
  %t244 = load double, double* %l7
  %t245 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t246 = extractvalue %EnumAggregateLayout %t245, 4
  %t247 = load { %EnumVariantLayoutDescriptor**, i64 }, { %EnumVariantLayoutDescriptor**, i64 }* %t246
  %t248 = extractvalue { %EnumVariantLayoutDescriptor**, i64 } %t247, 1
  %t249 = sitofp i64 %t248 to double
  %t250 = fcmp oge double %t244, %t249
  %t251 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t252 = load double, double* %l1
  %t253 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t254 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t255 = load i8*, i8** %l6
  %t256 = load double, double* %l7
  br i1 %t250, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t257 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t258 = extractvalue %EnumAggregateLayout %t257, 4
  %t259 = load double, double* %l7
  %t260 = fptosi double %t259 to i64
  %t261 = load { %EnumVariantLayoutDescriptor**, i64 }, { %EnumVariantLayoutDescriptor**, i64 }* %t258
  %t262 = extractvalue { %EnumVariantLayoutDescriptor**, i64 } %t261, 0
  %t263 = extractvalue { %EnumVariantLayoutDescriptor**, i64 } %t261, 1
  %t264 = icmp uge i64 %t260, %t263
  ; bounds check: %t264 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t260, i64 %t263)
  %t265 = getelementptr %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %t262, i64 %t260
  %t266 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %t265
  store %EnumVariantLayoutDescriptor* %t266, %EnumVariantLayoutDescriptor** %l8
  %s267 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1695010494, i32 0, i32 0
  %t268 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t269 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t268, i32 0, i32 0
  %t270 = load i8*, i8** %t269
  %t271 = call i8* @sailfin_runtime_string_concat(i8* %s267, i8* %t270)
  store i8* %t271, i8** %l9
  %t272 = load i8*, i8** %l9
  %s273 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1525558983, i32 0, i32 0
  %t274 = call i8* @sailfin_runtime_string_concat(i8* %t272, i8* %s273)
  %t275 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t276 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t275, i32 0, i32 1
  %t277 = load double, double* %t276
  %t278 = call i8* @number_to_string(double %t277)
  %t279 = call i8* @sailfin_runtime_string_concat(i8* %t274, i8* %t278)
  store i8* %t279, i8** %l9
  %t280 = load i8*, i8** %l9
  %s281 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h455185518, i32 0, i32 0
  %t282 = call i8* @sailfin_runtime_string_concat(i8* %t280, i8* %s281)
  %t283 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t284 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t283, i32 0, i32 2
  %t285 = load double, double* %t284
  %t286 = call i8* @number_to_string(double %t285)
  %t287 = call i8* @sailfin_runtime_string_concat(i8* %t282, i8* %t286)
  store i8* %t287, i8** %l9
  %t288 = load i8*, i8** %l9
  %s289 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h922402750, i32 0, i32 0
  %t290 = call i8* @sailfin_runtime_string_concat(i8* %t288, i8* %s289)
  %t291 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t292 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t291, i32 0, i32 3
  %t293 = load double, double* %t292
  %t294 = call i8* @number_to_string(double %t293)
  %t295 = call i8* @sailfin_runtime_string_concat(i8* %t290, i8* %t294)
  store i8* %t295, i8** %l9
  %t296 = load i8*, i8** %l9
  %s297 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h847788946, i32 0, i32 0
  %t298 = call i8* @sailfin_runtime_string_concat(i8* %t296, i8* %s297)
  %t299 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t300 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t299, i32 0, i32 4
  %t301 = load double, double* %t300
  %t302 = call i8* @number_to_string(double %t301)
  %t303 = call i8* @sailfin_runtime_string_concat(i8* %t298, i8* %t302)
  store i8* %t303, i8** %l9
  %t304 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t305 = load i8*, i8** %l9
  %t306 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t304, i8* %t305)
  store { i8**, i64 }* %t306, { i8**, i64 }** %l5
  %t307 = sitofp i64 0 to double
  store double %t307, double* %l10
  %t308 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t309 = load double, double* %l1
  %t310 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t311 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t312 = load i8*, i8** %l6
  %t313 = load double, double* %l7
  %t314 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t315 = load i8*, i8** %l9
  %t316 = load double, double* %l10
  br label %loop.header12
loop.header12:
  %t400 = phi { i8**, i64 }* [ %t311, %merge11 ], [ %t398, %loop.latch14 ]
  %t401 = phi double [ %t316, %merge11 ], [ %t399, %loop.latch14 ]
  store { i8**, i64 }* %t400, { i8**, i64 }** %l5
  store double %t401, double* %l10
  br label %loop.body13
loop.body13:
  %t317 = load double, double* %l10
  %t318 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t319 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t318, i32 0, i32 5
  %t320 = load { %StructFieldLayoutDescriptor**, i64 }*, { %StructFieldLayoutDescriptor**, i64 }** %t319
  %t321 = load { %StructFieldLayoutDescriptor**, i64 }, { %StructFieldLayoutDescriptor**, i64 }* %t320
  %t322 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t321, 1
  %t323 = sitofp i64 %t322 to double
  %t324 = fcmp oge double %t317, %t323
  %t325 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t326 = load double, double* %l1
  %t327 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t329 = load i8*, i8** %l6
  %t330 = load double, double* %l7
  %t331 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t332 = load i8*, i8** %l9
  %t333 = load double, double* %l10
  br i1 %t324, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t334 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t335 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t334, i32 0, i32 5
  %t336 = load { %StructFieldLayoutDescriptor**, i64 }*, { %StructFieldLayoutDescriptor**, i64 }** %t335
  %t337 = load double, double* %l10
  %t338 = fptosi double %t337 to i64
  %t339 = load { %StructFieldLayoutDescriptor**, i64 }, { %StructFieldLayoutDescriptor**, i64 }* %t336
  %t340 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t339, 0
  %t341 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t339, 1
  %t342 = icmp uge i64 %t338, %t341
  ; bounds check: %t342 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t338, i64 %t341)
  %t343 = getelementptr %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t340, i64 %t338
  %t344 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t343
  store %StructFieldLayoutDescriptor* %t344, %StructFieldLayoutDescriptor** %l11
  %s345 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1290415774, i32 0, i32 0
  %t346 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t347 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t346, i32 0, i32 0
  %t348 = load i8*, i8** %t347
  %t349 = call i8* @sailfin_runtime_string_concat(i8* %s345, i8* %t348)
  %t350 = load i8, i8* %t349
  %t351 = add i8 %t350, 46
  %t352 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l11
  %t353 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t352, i32 0, i32 0
  %t354 = load i8*, i8** %t353
  %t355 = load i8, i8* %t354
  %t356 = add i8 %t351, %t355
  %t357 = alloca [2 x i8], align 1
  %t358 = getelementptr [2 x i8], [2 x i8]* %t357, i32 0, i32 0
  store i8 %t356, i8* %t358
  %t359 = getelementptr [2 x i8], [2 x i8]* %t357, i32 0, i32 1
  store i8 0, i8* %t359
  %t360 = getelementptr [2 x i8], [2 x i8]* %t357, i32 0, i32 0
  store i8* %t360, i8** %l12
  %t361 = load i8*, i8** %l12
  %s362 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h980153509, i32 0, i32 0
  %t363 = call i8* @sailfin_runtime_string_concat(i8* %t361, i8* %s362)
  %t364 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l11
  %t365 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t364, i32 0, i32 1
  %t366 = load i8*, i8** %t365
  %t367 = call i8* @sailfin_runtime_string_concat(i8* %t363, i8* %t366)
  store i8* %t367, i8** %l12
  %t368 = load i8*, i8** %l12
  %s369 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h455185518, i32 0, i32 0
  %t370 = call i8* @sailfin_runtime_string_concat(i8* %t368, i8* %s369)
  %t371 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l11
  %t372 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t371, i32 0, i32 2
  %t373 = load double, double* %t372
  %t374 = call i8* @number_to_string(double %t373)
  %t375 = call i8* @sailfin_runtime_string_concat(i8* %t370, i8* %t374)
  store i8* %t375, i8** %l12
  %t376 = load i8*, i8** %l12
  %s377 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h922402750, i32 0, i32 0
  %t378 = call i8* @sailfin_runtime_string_concat(i8* %t376, i8* %s377)
  %t379 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l11
  %t380 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t379, i32 0, i32 3
  %t381 = load double, double* %t380
  %t382 = call i8* @number_to_string(double %t381)
  %t383 = call i8* @sailfin_runtime_string_concat(i8* %t378, i8* %t382)
  store i8* %t383, i8** %l12
  %t384 = load i8*, i8** %l12
  %s385 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h847788946, i32 0, i32 0
  %t386 = call i8* @sailfin_runtime_string_concat(i8* %t384, i8* %s385)
  %t387 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l11
  %t388 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t387, i32 0, i32 4
  %t389 = load double, double* %t388
  %t390 = call i8* @number_to_string(double %t389)
  %t391 = call i8* @sailfin_runtime_string_concat(i8* %t386, i8* %t390)
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
  %t402 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t403 = load double, double* %l10
  %t404 = load double, double* %l7
  %t405 = sitofp i64 1 to double
  %t406 = fadd double %t404, %t405
  store double %t406, double* %l7
  br label %loop.latch8
loop.latch8:
  %t407 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t408 = load double, double* %l7
  br label %loop.header6
afterloop9:
  %t411 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t412 = load double, double* %l7
  %t413 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t414 = insertvalue %LayoutEmitResult undef, { i8**, i64 }* %t413, 0
  %t415 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t416 = extractvalue %EnumAggregateLayout %t415, 5
  %t417 = insertvalue %LayoutEmitResult %t414, { i8**, i64 }* %t416, 1
  ret %LayoutEmitResult %t417
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
  %t237 = phi { i8**, i64 }* [ %t19, %entry ], [ %t232, %loop.latch2 ]
  %t238 = phi double [ %t17, %entry ], [ %t233, %loop.latch2 ]
  %t239 = phi double [ %t18, %entry ], [ %t234, %loop.latch2 ]
  %t240 = phi { %EnumVariantLayoutDescriptor*, i64 }* [ %t20, %entry ], [ %t235, %loop.latch2 ]
  %t241 = phi double [ %t21, %entry ], [ %t236, %loop.latch2 ]
  store { i8**, i64 }* %t237, { i8**, i64 }** %l4
  store double %t238, double* %l2
  store double %t239, double* %l3
  store { %EnumVariantLayoutDescriptor*, i64 }* %t240, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  store double %t241, double* %l6
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
  call void @sailfin_runtime_bounds_check(i64 %t35, i64 %t38)
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
  %s50 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h513898090, i32 0, i32 0
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
  %t79 = load double, double* %l10
  br label %merge7
merge7:
  %t80 = phi double [ %t79, %then6 ], [ %t77, %merge5 ]
  store double %t80, double* %l10
  %t81 = load double, double* %l0
  %t82 = load double, double* %l10
  %t83 = call double @align_to(double %t81, double %t82)
  store double %t83, double* %l11
  %t84 = load double, double* %l10
  %t85 = load double, double* %l2
  %t86 = fcmp ogt double %t84, %t85
  %t87 = load double, double* %l0
  %t88 = load double, double* %l1
  %t89 = load double, double* %l2
  %t90 = load double, double* %l3
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t92 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t93 = load double, double* %l6
  %t94 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t95 = load i8, i8* %l8
  %t96 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t97 = load double, double* %l10
  %t98 = load double, double* %l11
  br i1 %t86, label %then8, label %merge9
then8:
  %t99 = load double, double* %l10
  store double %t99, double* %l2
  %t100 = load double, double* %l2
  br label %merge9
merge9:
  %t101 = phi double [ %t100, %then8 ], [ %t89, %merge7 ]
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
  %t183 = phi { %StructFieldLayoutDescriptor*, i64 }* [ %t120, %merge9 ], [ %t181, %loop.latch12 ]
  %t184 = phi double [ %t121, %merge9 ], [ %t182, %loop.latch12 ]
  store { %StructFieldLayoutDescriptor*, i64 }* %t183, { %StructFieldLayoutDescriptor*, i64 }** %l12
  store double %t184, double* %l13
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
  call void @sailfin_runtime_bounds_check(i64 %t146, i64 %t149)
  %t151 = getelementptr %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t148, i64 %t146
  %t152 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t151
  store %StructFieldLayoutDescriptor* %t152, %StructFieldLayoutDescriptor** %l14
  %t153 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l14
  %t154 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t153, i32 0, i32 0
  %t155 = load i8*, i8** %t154
  %t156 = insertvalue %StructFieldLayoutDescriptor undef, i8* %t155, 0
  %t157 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l14
  %t158 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t157, i32 0, i32 1
  %t159 = load i8*, i8** %t158
  %t160 = insertvalue %StructFieldLayoutDescriptor %t156, i8* %t159, 1
  %t161 = load double, double* %l11
  %t162 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l14
  %t163 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t162, i32 0, i32 2
  %t164 = load double, double* %t163
  %t165 = fadd double %t161, %t164
  %t166 = insertvalue %StructFieldLayoutDescriptor %t160, double %t165, 2
  %t167 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l14
  %t168 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t167, i32 0, i32 3
  %t169 = load double, double* %t168
  %t170 = insertvalue %StructFieldLayoutDescriptor %t166, double %t169, 3
  %t171 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l14
  %t172 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t171, i32 0, i32 4
  %t173 = load double, double* %t172
  %t174 = insertvalue %StructFieldLayoutDescriptor %t170, double %t173, 4
  store %StructFieldLayoutDescriptor %t174, %StructFieldLayoutDescriptor* %l15
  %t175 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t176 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l15
  %t177 = call { %StructFieldLayoutDescriptor*, i64 }* @append_struct_field_layout({ %StructFieldLayoutDescriptor*, i64 }* %t175, %StructFieldLayoutDescriptor %t176)
  store { %StructFieldLayoutDescriptor*, i64 }* %t177, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t178 = load double, double* %l13
  %t179 = sitofp i64 1 to double
  %t180 = fadd double %t178, %t179
  store double %t180, double* %l13
  br label %loop.latch12
loop.latch12:
  %t181 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t182 = load double, double* %l13
  br label %loop.header10
afterloop13:
  %t185 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t186 = load double, double* %l13
  %t187 = load double, double* %l11
  %t188 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t189 = extractvalue %RecordLayoutResult %t188, 0
  %t190 = fadd double %t187, %t189
  store double %t190, double* %l16
  %t191 = load double, double* %l16
  %t192 = load double, double* %l3
  %t193 = fcmp ogt double %t191, %t192
  %t194 = load double, double* %l0
  %t195 = load double, double* %l1
  %t196 = load double, double* %l2
  %t197 = load double, double* %l3
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t199 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t200 = load double, double* %l6
  %t201 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t202 = load i8, i8* %l8
  %t203 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t204 = load double, double* %l10
  %t205 = load double, double* %l11
  %t206 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t207 = load double, double* %l13
  %t208 = load double, double* %l16
  br i1 %t193, label %then16, label %merge17
then16:
  %t209 = load double, double* %l16
  store double %t209, double* %l3
  %t210 = load double, double* %l3
  br label %merge17
merge17:
  %t211 = phi double [ %t210, %then16 ], [ %t197, %afterloop13 ]
  store double %t211, double* %l3
  %t212 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t213 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t214 = extractvalue %LayoutEnumVariantDefinition %t213, 0
  %t215 = insertvalue %EnumVariantLayoutDescriptor undef, i8* %t214, 0
  %t216 = load double, double* %l6
  %t217 = insertvalue %EnumVariantLayoutDescriptor %t215, double %t216, 1
  %t218 = load double, double* %l11
  %t219 = insertvalue %EnumVariantLayoutDescriptor %t217, double %t218, 2
  %t220 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t221 = extractvalue %RecordLayoutResult %t220, 0
  %t222 = insertvalue %EnumVariantLayoutDescriptor %t219, double %t221, 3
  %t223 = load double, double* %l10
  %t224 = insertvalue %EnumVariantLayoutDescriptor %t222, double %t223, 4
  %t225 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t226 = bitcast { %StructFieldLayoutDescriptor*, i64 }* %t225 to { %StructFieldLayoutDescriptor**, i64 }*
  %t227 = insertvalue %EnumVariantLayoutDescriptor %t224, { %StructFieldLayoutDescriptor**, i64 }* %t226, 5
  %t228 = call { %EnumVariantLayoutDescriptor*, i64 }* @append_enum_variant_layout({ %EnumVariantLayoutDescriptor*, i64 }* %t212, %EnumVariantLayoutDescriptor %t227)
  store { %EnumVariantLayoutDescriptor*, i64 }* %t228, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t229 = load double, double* %l6
  %t230 = sitofp i64 1 to double
  %t231 = fadd double %t229, %t230
  store double %t231, double* %l6
  br label %loop.latch2
loop.latch2:
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t233 = load double, double* %l2
  %t234 = load double, double* %l3
  %t235 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t236 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t243 = load double, double* %l2
  %t244 = load double, double* %l3
  %t245 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t246 = load double, double* %l6
  %t247 = load { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %variants
  %t248 = extractvalue { %LayoutEnumVariantDefinition*, i64 } %t247, 1
  %t249 = icmp eq i64 %t248, 0
  %t250 = load double, double* %l0
  %t251 = load double, double* %l1
  %t252 = load double, double* %l2
  %t253 = load double, double* %l3
  %t254 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t255 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t256 = load double, double* %l6
  br i1 %t249, label %then18, label %merge19
then18:
  %t257 = load double, double* %l1
  store double %t257, double* %l2
  %t258 = load double, double* %l0
  store double %t258, double* %l3
  %t259 = load double, double* %l2
  %t260 = load double, double* %l3
  br label %merge19
merge19:
  %t261 = phi double [ %t259, %then18 ], [ %t252, %afterloop3 ]
  %t262 = phi double [ %t260, %then18 ], [ %t253, %afterloop3 ]
  store double %t261, double* %l2
  store double %t262, double* %l3
  %t263 = load double, double* %l2
  store double %t263, double* %l17
  %t264 = load double, double* %l17
  %t265 = sitofp i64 0 to double
  %t266 = fcmp ole double %t264, %t265
  %t267 = load double, double* %l0
  %t268 = load double, double* %l1
  %t269 = load double, double* %l2
  %t270 = load double, double* %l3
  %t271 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t272 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t273 = load double, double* %l6
  %t274 = load double, double* %l17
  br i1 %t266, label %then20, label %merge21
then20:
  %t275 = sitofp i64 1 to double
  store double %t275, double* %l17
  %t276 = load double, double* %l17
  br label %merge21
merge21:
  %t277 = phi double [ %t276, %then20 ], [ %t274, %merge19 ]
  store double %t277, double* %l17
  %t278 = load double, double* %l3
  store double %t278, double* %l18
  %t279 = load double, double* %l17
  %t280 = sitofp i64 1 to double
  %t281 = fcmp ogt double %t279, %t280
  %t282 = load double, double* %l0
  %t283 = load double, double* %l1
  %t284 = load double, double* %l2
  %t285 = load double, double* %l3
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t287 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t288 = load double, double* %l6
  %t289 = load double, double* %l17
  %t290 = load double, double* %l18
  br i1 %t281, label %then22, label %merge23
then22:
  %t291 = load double, double* %l3
  %t292 = load double, double* %l17
  %t293 = call double @align_to(double %t291, double %t292)
  store double %t293, double* %l18
  %t294 = load double, double* %l18
  br label %merge23
merge23:
  %t295 = phi double [ %t294, %then22 ], [ %t290, %merge21 ]
  store double %t295, double* %l18
  %t296 = load double, double* %l18
  %t297 = insertvalue %EnumAggregateLayout undef, double %t296, 0
  %t298 = load double, double* %l17
  %t299 = insertvalue %EnumAggregateLayout %t297, double %t298, 1
  %t300 = load double, double* %l0
  %t301 = insertvalue %EnumAggregateLayout %t299, double %t300, 2
  %t302 = load double, double* %l1
  %t303 = insertvalue %EnumAggregateLayout %t301, double %t302, 3
  %t304 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t305 = bitcast { %EnumVariantLayoutDescriptor*, i64 }* %t304 to { %EnumVariantLayoutDescriptor**, i64 }*
  %t306 = insertvalue %EnumAggregateLayout %t303, { %EnumVariantLayoutDescriptor**, i64 }* %t305, 4
  %t307 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t308 = insertvalue %EnumAggregateLayout %t306, { i8**, i64 }* %t307, 5
  ret %EnumAggregateLayout %t308
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
  %t108 = phi { i8**, i64 }* [ %t13, %entry ], [ %t103, %loop.latch2 ]
  %t109 = phi double [ %t15, %entry ], [ %t104, %loop.latch2 ]
  %t110 = phi { %StructFieldLayoutDescriptor*, i64 }* [ %t14, %entry ], [ %t105, %loop.latch2 ]
  %t111 = phi double [ %t16, %entry ], [ %t106, %loop.latch2 ]
  %t112 = phi double [ %t17, %entry ], [ %t107, %loop.latch2 ]
  store { i8**, i64 }* %t108, { i8**, i64 }** %l0
  store double %t109, double* %l2
  store { %StructFieldLayoutDescriptor*, i64 }* %t110, { %StructFieldLayoutDescriptor*, i64 }** %l1
  store double %t111, double* %l3
  store double %t112, double* %l4
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
  call void @sailfin_runtime_bounds_check(i64 %t29, i64 %t32)
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
  %t59 = load double, double* %l7
  br label %merge7
merge7:
  %t60 = phi double [ %t59, %then6 ], [ %t57, %merge5 ]
  store double %t60, double* %l7
  %t61 = load double, double* %l2
  %t62 = load double, double* %l7
  %t63 = call double @align_to(double %t61, double %t62)
  store double %t63, double* %l2
  %t64 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t65 = extractvalue %LayoutFieldInput %t64, 0
  %t66 = insertvalue %StructFieldLayoutDescriptor undef, i8* %t65, 0
  %t67 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t68 = extractvalue %LayoutFieldInput %t67, 1
  %t69 = call i8* @trim_text(i8* %t68)
  %t70 = insertvalue %StructFieldLayoutDescriptor %t66, i8* %t69, 1
  %t71 = load double, double* %l2
  %t72 = insertvalue %StructFieldLayoutDescriptor %t70, double %t71, 2
  %t73 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t74 = extractvalue %TypeLayoutInfo %t73, 0
  %t75 = insertvalue %StructFieldLayoutDescriptor %t72, double %t74, 3
  %t76 = load double, double* %l7
  %t77 = insertvalue %StructFieldLayoutDescriptor %t75, double %t76, 4
  store %StructFieldLayoutDescriptor %t77, %StructFieldLayoutDescriptor* %l8
  %t78 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t79 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l8
  %t80 = call { %StructFieldLayoutDescriptor*, i64 }* @append_struct_field_layout({ %StructFieldLayoutDescriptor*, i64 }* %t78, %StructFieldLayoutDescriptor %t79)
  store { %StructFieldLayoutDescriptor*, i64 }* %t80, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t81 = load double, double* %l2
  %t82 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t83 = extractvalue %TypeLayoutInfo %t82, 0
  %t84 = fadd double %t81, %t83
  store double %t84, double* %l2
  %t85 = load double, double* %l7
  %t86 = load double, double* %l3
  %t87 = fcmp ogt double %t85, %t86
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t89 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t90 = load double, double* %l2
  %t91 = load double, double* %l3
  %t92 = load double, double* %l4
  %t93 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t94 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t95 = load double, double* %l7
  %t96 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l8
  br i1 %t87, label %then8, label %merge9
then8:
  %t97 = load double, double* %l7
  store double %t97, double* %l3
  %t98 = load double, double* %l3
  br label %merge9
merge9:
  %t99 = phi double [ %t98, %then8 ], [ %t91, %merge7 ]
  store double %t99, double* %l3
  %t100 = load double, double* %l4
  %t101 = sitofp i64 1 to double
  %t102 = fadd double %t100, %t101
  store double %t102, double* %l4
  br label %loop.latch2
loop.latch2:
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t104 = load double, double* %l2
  %t105 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t106 = load double, double* %l3
  %t107 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t114 = load double, double* %l2
  %t115 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t116 = load double, double* %l3
  %t117 = load double, double* %l4
  %t118 = load double, double* %l3
  store double %t118, double* %l9
  %t119 = load { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %inputs
  %t120 = extractvalue { %LayoutFieldInput*, i64 } %t119, 1
  %t121 = icmp eq i64 %t120, 0
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t123 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t124 = load double, double* %l2
  %t125 = load double, double* %l3
  %t126 = load double, double* %l4
  %t127 = load double, double* %l9
  br i1 %t121, label %then10, label %merge11
then10:
  %t128 = sitofp i64 1 to double
  store double %t128, double* %l9
  %t129 = load double, double* %l9
  br label %merge11
merge11:
  %t130 = phi double [ %t129, %then10 ], [ %t127, %afterloop3 ]
  store double %t130, double* %l9
  %t131 = load double, double* %l9
  %t132 = sitofp i64 0 to double
  %t133 = fcmp ole double %t131, %t132
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t135 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t136 = load double, double* %l2
  %t137 = load double, double* %l3
  %t138 = load double, double* %l4
  %t139 = load double, double* %l9
  br i1 %t133, label %then12, label %merge13
then12:
  %t140 = sitofp i64 1 to double
  store double %t140, double* %l9
  %t141 = load double, double* %l9
  br label %merge13
merge13:
  %t142 = phi double [ %t141, %then12 ], [ %t139, %merge11 ]
  store double %t142, double* %l9
  %t143 = load double, double* %l2
  store double %t143, double* %l10
  %t144 = load double, double* %l9
  %t145 = sitofp i64 1 to double
  %t146 = fcmp ogt double %t144, %t145
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t148 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t149 = load double, double* %l2
  %t150 = load double, double* %l3
  %t151 = load double, double* %l4
  %t152 = load double, double* %l9
  %t153 = load double, double* %l10
  br i1 %t146, label %then14, label %merge15
then14:
  %t154 = load double, double* %l2
  %t155 = load double, double* %l9
  %t156 = call double @align_to(double %t154, double %t155)
  store double %t156, double* %l10
  %t157 = load double, double* %l10
  br label %merge15
merge15:
  %t158 = phi double [ %t157, %then14 ], [ %t153, %merge13 ]
  store double %t158, double* %l10
  %t159 = load double, double* %l10
  %t160 = insertvalue %RecordLayoutResult undef, double %t159, 0
  %t161 = load double, double* %l9
  %t162 = insertvalue %RecordLayoutResult %t160, double %t161, 1
  %t163 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t164 = bitcast { %StructFieldLayoutDescriptor*, i64 }* %t163 to { %StructFieldLayoutDescriptor**, i64 }*
  %t165 = insertvalue %RecordLayoutResult %t162, { %StructFieldLayoutDescriptor**, i64 }* %t164, 2
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t167 = insertvalue %RecordLayoutResult %t165, { i8**, i64 }* %t166, 3
  ret %RecordLayoutResult %t167
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
  %s12 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1833630044, i32 0, i32 0
  %t13 = call i8* @sailfin_runtime_string_concat(i8* %s12, i8* %container_kind)
  %s14 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415015, i32 0, i32 0
  %t15 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %s14)
  %t16 = call i8* @sailfin_runtime_string_concat(i8* %t15, i8* %container_name)
  %s17 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1449250559, i32 0, i32 0
  %t18 = call i8* @sailfin_runtime_string_concat(i8* %t16, i8* %s17)
  %t19 = call i8* @sailfin_runtime_string_concat(i8* %t18, i8* %field_name)
  %s20 = getelementptr inbounds [56 x i8], [56 x i8]* @.str.len55.h700951597, i32 0, i32 0
  %t21 = call i8* @sailfin_runtime_string_concat(i8* %t19, i8* %s20)
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
  %s30 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h807326654, i32 0, i32 0
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
  %s42 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090370613, i32 0, i32 0
  %t43 = icmp eq i8* %t41, %s42
  br label %logical_or_entry_40

logical_or_entry_40:
  br i1 %t43, label %logical_or_merge_40, label %logical_or_right_40

logical_or_right_40:
  %t44 = load i8*, i8** %l0
  %s45 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090307517, i32 0, i32 0
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
  %s57 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090304184, i32 0, i32 0
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
  %s69 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h1483009776, i32 0, i32 0
  %t70 = icmp eq i8* %t68, %s69
  br label %logical_or_entry_67

logical_or_entry_67:
  br i1 %t70, label %logical_or_merge_67, label %logical_or_right_67

logical_or_right_67:
  %t72 = load i8*, i8** %l0
  %s73 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h254486039, i32 0, i32 0
  %t74 = icmp eq i8* %t72, %s73
  br label %logical_or_entry_71

logical_or_entry_71:
  br i1 %t74, label %logical_or_merge_71, label %logical_or_right_71

logical_or_right_71:
  %t75 = load i8*, i8** %l0
  %s76 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193492961, i32 0, i32 0
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
  %s89 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090083282, i32 0, i32 0
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
  %t102 = icmp ne %CanonicalTypeLayout* %t101, null
  %t103 = load i8*, i8** %l0
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t105 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l2
  br i1 %t102, label %then12, label %merge13
then12:
  %t106 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l2
  %t107 = getelementptr %CanonicalTypeLayout, %CanonicalTypeLayout* %t106, i32 0, i32 1
  %t108 = load double, double* %t107
  %t109 = insertvalue %TypeLayoutInfo undef, double %t108, 0
  %t110 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l2
  %t111 = getelementptr %CanonicalTypeLayout, %CanonicalTypeLayout* %t110, i32 0, i32 2
  %t112 = load double, double* %t111
  %t113 = insertvalue %TypeLayoutInfo %t109, double %t112, 1
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t115 = insertvalue %TypeLayoutInfo %t113, { i8**, i64 }* %t114, 2
  ret %TypeLayoutInfo %t115
merge13:
  %t116 = load i8*, i8** %l0
  %t117 = call i1 @is_array_type(i8* %t116)
  %t118 = load i8*, i8** %l0
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t120 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l2
  br i1 %t117, label %then14, label %merge15
then14:
  %t121 = sitofp i64 8 to double
  %t122 = insertvalue %TypeLayoutInfo undef, double %t121, 0
  %t123 = sitofp i64 8 to double
  %t124 = insertvalue %TypeLayoutInfo %t122, double %t123, 1
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t126 = insertvalue %TypeLayoutInfo %t124, { i8**, i64 }* %t125, 2
  ret %TypeLayoutInfo %t126
merge15:
  %t127 = load i8*, i8** %l0
  %s128 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h789270767, i32 0, i32 0
  %t129 = icmp eq i8* %t127, %s128
  %t130 = load i8*, i8** %l0
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t132 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l2
  br i1 %t129, label %then16, label %merge17
then16:
  %t133 = sitofp i64 8 to double
  %t134 = insertvalue %TypeLayoutInfo undef, double %t133, 0
  %t135 = sitofp i64 8 to double
  %t136 = insertvalue %TypeLayoutInfo %t134, double %t135, 1
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t138 = insertvalue %TypeLayoutInfo %t136, { i8**, i64 }* %t137, 2
  ret %TypeLayoutInfo %t138
merge17:
  %t139 = load i8*, i8** %l0
  %t140 = call i1 @is_optional_annotation(i8* %t139)
  %t141 = load i8*, i8** %l0
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t143 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l2
  br i1 %t140, label %then18, label %merge19
then18:
  %t144 = load i8*, i8** %l0
  %t145 = call i8* @strip_optional_suffix(i8* %t144)
  %t146 = call i8* @trim_text(i8* %t145)
  store i8* %t146, i8** %l3
  %t147 = load i8*, i8** %l3
  %t148 = call i64 @sailfin_runtime_string_length(i8* %t147)
  %t149 = icmp eq i64 %t148, 0
  %t150 = load i8*, i8** %l0
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t152 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l2
  %t153 = load i8*, i8** %l3
  br i1 %t149, label %then20, label %merge21
then20:
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s155 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1833630044, i32 0, i32 0
  %t156 = call i8* @sailfin_runtime_string_concat(i8* %s155, i8* %container_kind)
  %s157 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415015, i32 0, i32 0
  %t158 = call i8* @sailfin_runtime_string_concat(i8* %t156, i8* %s157)
  %t159 = call i8* @sailfin_runtime_string_concat(i8* %t158, i8* %container_name)
  %s160 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1449250559, i32 0, i32 0
  %t161 = call i8* @sailfin_runtime_string_concat(i8* %t159, i8* %s160)
  %t162 = call i8* @sailfin_runtime_string_concat(i8* %t161, i8* %field_name)
  %s163 = getelementptr inbounds [71 x i8], [71 x i8]* @.str.len70.h1478160845, i32 0, i32 0
  %t164 = call i8* @sailfin_runtime_string_concat(i8* %t162, i8* %s163)
  %t165 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t154, i8* %t164)
  store { i8**, i64 }* %t165, { i8**, i64 }** %l1
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge21
merge21:
  %t167 = phi { i8**, i64 }* [ %t166, %then20 ], [ %t151, %then18 ]
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
  %t188 = icmp ne %LayoutStructDefinition* %t187, null
  %t189 = load i8*, i8** %l0
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t191 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l2
  %t192 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l4
  br i1 %t188, label %then24, label %merge25
then24:
  %t193 = load i8*, i8** %l0
  %t194 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %visiting, i8* %t193)
  store { i8**, i64 }* %t194, { i8**, i64 }** %l5
  %t195 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l4
  %t196 = getelementptr %LayoutStructDefinition, %LayoutStructDefinition* %t195, i32 0, i32 1
  %t197 = load { %LayoutFieldInput**, i64 }*, { %LayoutFieldInput**, i64 }** %t196
  %s198 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h789690461, i32 0, i32 0
  %t199 = load i8*, i8** %l0
  %t200 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t201 = bitcast { %LayoutFieldInput**, i64 }* %t197 to { %LayoutFieldInput*, i64 }*
  %t202 = call %RecordLayoutResult @calculate_record_layout(%LayoutContext %context, { %LayoutFieldInput*, i64 }* %t201, i8* %s198, i8* %t199, { i8**, i64 }* %t200)
  store %RecordLayoutResult %t202, %RecordLayoutResult* %l6
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t204 = load %RecordLayoutResult, %RecordLayoutResult* %l6
  %t205 = extractvalue %RecordLayoutResult %t204, 3
  %t206 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t203, { i8**, i64 }* %t205)
  store { i8**, i64 }* %t206, { i8**, i64 }** %l1
  %t207 = load %RecordLayoutResult, %RecordLayoutResult* %l6
  %t208 = extractvalue %RecordLayoutResult %t207, 0
  %t209 = insertvalue %TypeLayoutInfo undef, double %t208, 0
  %t210 = load %RecordLayoutResult, %RecordLayoutResult* %l6
  %t211 = extractvalue %RecordLayoutResult %t210, 1
  %t212 = insertvalue %TypeLayoutInfo %t209, double %t211, 1
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t214 = insertvalue %TypeLayoutInfo %t212, { i8**, i64 }* %t213, 2
  ret %TypeLayoutInfo %t214
merge25:
  %t215 = load i8*, i8** %l0
  %t216 = call %LayoutEnumDefinition* @find_layout_enum_definition(%LayoutContext %context, i8* %t215)
  store %LayoutEnumDefinition* %t216, %LayoutEnumDefinition** %l7
  %t217 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %l7
  %t218 = icmp ne %LayoutEnumDefinition* %t217, null
  %t219 = load i8*, i8** %l0
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t221 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l2
  %t222 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l4
  %t223 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %l7
  br i1 %t218, label %then26, label %merge27
then26:
  %t224 = load i8*, i8** %l0
  %t225 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %visiting, i8* %t224)
  store { i8**, i64 }* %t225, { i8**, i64 }** %l8
  %t226 = load i8*, i8** %l0
  %t227 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %l7
  %t228 = getelementptr %LayoutEnumDefinition, %LayoutEnumDefinition* %t227, i32 0, i32 1
  %t229 = load { %LayoutEnumVariantDefinition**, i64 }*, { %LayoutEnumVariantDefinition**, i64 }** %t228
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t231 = bitcast { %LayoutEnumVariantDefinition**, i64 }* %t229 to { %LayoutEnumVariantDefinition*, i64 }*
  %t232 = call %EnumAggregateLayout @infer_enum_aggregate_layout(%LayoutContext %context, i8* %t226, { %LayoutEnumVariantDefinition*, i64 }* %t231, { i8**, i64 }* %t230)
  store %EnumAggregateLayout %t232, %EnumAggregateLayout* %l9
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t234 = load %EnumAggregateLayout, %EnumAggregateLayout* %l9
  %t235 = extractvalue %EnumAggregateLayout %t234, 5
  %t236 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t233, { i8**, i64 }* %t235)
  store { i8**, i64 }* %t236, { i8**, i64 }** %l1
  %t237 = load %EnumAggregateLayout, %EnumAggregateLayout* %l9
  %t238 = extractvalue %EnumAggregateLayout %t237, 0
  %t239 = insertvalue %TypeLayoutInfo undef, double %t238, 0
  %t240 = load %EnumAggregateLayout, %EnumAggregateLayout* %l9
  %t241 = extractvalue %EnumAggregateLayout %t240, 1
  %t242 = insertvalue %TypeLayoutInfo %t239, double %t241, 1
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t244 = insertvalue %TypeLayoutInfo %t242, { i8**, i64 }* %t243, 2
  ret %TypeLayoutInfo %t244
merge27:
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s246 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1833630044, i32 0, i32 0
  %t247 = call i8* @sailfin_runtime_string_concat(i8* %s246, i8* %container_kind)
  %s248 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415015, i32 0, i32 0
  %t249 = call i8* @sailfin_runtime_string_concat(i8* %t247, i8* %s248)
  %t250 = call i8* @sailfin_runtime_string_concat(i8* %t249, i8* %container_name)
  %s251 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1449250559, i32 0, i32 0
  %t252 = call i8* @sailfin_runtime_string_concat(i8* %t250, i8* %s251)
  %t253 = call i8* @sailfin_runtime_string_concat(i8* %t252, i8* %field_name)
  %s254 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h9921935, i32 0, i32 0
  %t255 = call i8* @sailfin_runtime_string_concat(i8* %t253, i8* %s254)
  %t256 = load i8*, i8** %l0
  %t257 = call i8* @sailfin_runtime_string_concat(i8* %t255, i8* %t256)
  %s258 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h2008080495, i32 0, i32 0
  %t259 = call i8* @sailfin_runtime_string_concat(i8* %t257, i8* %s258)
  %t260 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t245, i8* %t259)
  store { i8**, i64 }* %t260, { i8**, i64 }** %l1
  %t261 = sitofp i64 8 to double
  %t262 = insertvalue %TypeLayoutInfo undef, double %t261, 0
  %t263 = sitofp i64 8 to double
  %t264 = insertvalue %TypeLayoutInfo %t262, double %t263, 1
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t266 = insertvalue %TypeLayoutInfo %t264, { i8**, i64 }* %t265, 2
  ret %TypeLayoutInfo %t266
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
  call void @sailfin_runtime_bounds_check(i64 %t16, i64 %t19)
  %t21 = getelementptr %FieldDeclaration, %FieldDeclaration* %t18, i64 %t16
  %t22 = load %FieldDeclaration, %FieldDeclaration* %t21
  store %FieldDeclaration %t22, %FieldDeclaration* %l2
  %t23 = load %FieldDeclaration, %FieldDeclaration* %l2
  %t24 = extractvalue %FieldDeclaration %t23, 1
  %t25 = extractvalue %TypeAnnotation %t24, 0
  store i8* %t25, i8** %l3
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
  %t41 = load double, double* %l1
  %t42 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  ret { %LayoutFieldInput*, i64 }* %t42
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
  %t0 = call noalias i8* @malloc(i64 40)
  %t1 = bitcast i8* %t0 to %StructFieldLayoutDescriptor*
  store %StructFieldLayoutDescriptor %value, %StructFieldLayoutDescriptor* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %StructFieldLayoutDescriptor*, i64 }* %values to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %StructFieldLayoutDescriptor*, i64 }*
  ret { %StructFieldLayoutDescriptor*, i64 }* %t10
}

define { %EnumVariantLayoutDescriptor*, i64 }* @append_enum_variant_layout({ %EnumVariantLayoutDescriptor*, i64 }* %values, %EnumVariantLayoutDescriptor %value) {
entry:
  %t0 = call noalias i8* @malloc(i64 48)
  %t1 = bitcast i8* %t0 to %EnumVariantLayoutDescriptor*
  store %EnumVariantLayoutDescriptor %value, %EnumVariantLayoutDescriptor* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %EnumVariantLayoutDescriptor*, i64 }* %values to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %EnumVariantLayoutDescriptor*, i64 }*
  ret { %EnumVariantLayoutDescriptor*, i64 }* %t10
}

define { %LayoutFieldInput*, i64 }* @append_layout_field_input({ %LayoutFieldInput*, i64 }* %values, %LayoutFieldInput %value) {
entry:
  %t0 = call noalias i8* @malloc(i64 16)
  %t1 = bitcast i8* %t0 to %LayoutFieldInput*
  store %LayoutFieldInput %value, %LayoutFieldInput* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %LayoutFieldInput*, i64 }* %values to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %LayoutFieldInput*, i64 }*
  ret { %LayoutFieldInput*, i64 }* %t10
}

define { %LayoutStructDefinition*, i64 }* @append_layout_struct_definition({ %LayoutStructDefinition*, i64 }* %values, %LayoutStructDefinition %value) {
entry:
  %t0 = call noalias i8* @malloc(i64 16)
  %t1 = bitcast i8* %t0 to %LayoutStructDefinition*
  store %LayoutStructDefinition %value, %LayoutStructDefinition* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %LayoutStructDefinition*, i64 }* %values to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %LayoutStructDefinition*, i64 }*
  ret { %LayoutStructDefinition*, i64 }* %t10
}

define { %LayoutEnumDefinition*, i64 }* @append_layout_enum_definition({ %LayoutEnumDefinition*, i64 }* %values, %LayoutEnumDefinition %value) {
entry:
  %t0 = call noalias i8* @malloc(i64 16)
  %t1 = bitcast i8* %t0 to %LayoutEnumDefinition*
  store %LayoutEnumDefinition %value, %LayoutEnumDefinition* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %LayoutEnumDefinition*, i64 }* %values to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %LayoutEnumDefinition*, i64 }*
  ret { %LayoutEnumDefinition*, i64 }* %t10
}

define { %LayoutEnumVariantDefinition*, i64 }* @append_layout_enum_variant_definition({ %LayoutEnumVariantDefinition*, i64 }* %values, %LayoutEnumVariantDefinition %value) {
entry:
  %t0 = call noalias i8* @malloc(i64 16)
  %t1 = bitcast i8* %t0 to %LayoutEnumVariantDefinition*
  store %LayoutEnumVariantDefinition %value, %LayoutEnumVariantDefinition* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %LayoutEnumVariantDefinition*, i64 }* %values to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %LayoutEnumVariantDefinition*, i64 }*
  ret { %LayoutEnumVariantDefinition*, i64 }* %t10
}

define { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %values, %CanonicalTypeLayout %value) {
entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %CanonicalTypeLayout*
  store %CanonicalTypeLayout %value, %CanonicalTypeLayout* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %CanonicalTypeLayout*, i64 }* %values to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %CanonicalTypeLayout*, i64 }*
  ret { %CanonicalTypeLayout*, i64 }* %t10
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
  call void @sailfin_runtime_bounds_check(i64 %t11, i64 %t14)
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
  %t30 = load double, double* %l0
  %t31 = bitcast i8* null to %LayoutStructDefinition*
  ret %LayoutStructDefinition* %t31
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
  call void @sailfin_runtime_bounds_check(i64 %t11, i64 %t14)
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
  %t30 = load double, double* %l0
  %t31 = bitcast i8* null to %LayoutEnumDefinition*
  ret %LayoutEnumDefinition* %t31
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
  %s6 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1407544976, i32 0, i32 0
  %t7 = insertvalue %CanonicalTypeLayout undef, i8* %s6, 0
  %t8 = sitofp i64 8 to double
  %t9 = insertvalue %CanonicalTypeLayout %t7, double %t8, 1
  %t10 = sitofp i64 8 to double
  %t11 = insertvalue %CanonicalTypeLayout %t9, double %t10, 2
  %t12 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t5, %CanonicalTypeLayout %t11)
  store { %CanonicalTypeLayout*, i64 }* %t12, { %CanonicalTypeLayout*, i64 }** %l0
  %t13 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s14 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h341064397, i32 0, i32 0
  %t15 = insertvalue %CanonicalTypeLayout undef, i8* %s14, 0
  %t16 = sitofp i64 8 to double
  %t17 = insertvalue %CanonicalTypeLayout %t15, double %t16, 1
  %t18 = sitofp i64 8 to double
  %t19 = insertvalue %CanonicalTypeLayout %t17, double %t18, 2
  %t20 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t13, %CanonicalTypeLayout %t19)
  store { %CanonicalTypeLayout*, i64 }* %t20, { %CanonicalTypeLayout*, i64 }** %l0
  %t21 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s22 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h576672325, i32 0, i32 0
  %t23 = insertvalue %CanonicalTypeLayout undef, i8* %s22, 0
  %t24 = sitofp i64 8 to double
  %t25 = insertvalue %CanonicalTypeLayout %t23, double %t24, 1
  %t26 = sitofp i64 8 to double
  %t27 = insertvalue %CanonicalTypeLayout %t25, double %t26, 2
  %t28 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t21, %CanonicalTypeLayout %t27)
  store { %CanonicalTypeLayout*, i64 }* %t28, { %CanonicalTypeLayout*, i64 }** %l0
  %t29 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s30 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1988247080, i32 0, i32 0
  %t31 = insertvalue %CanonicalTypeLayout undef, i8* %s30, 0
  %t32 = sitofp i64 8 to double
  %t33 = insertvalue %CanonicalTypeLayout %t31, double %t32, 1
  %t34 = sitofp i64 8 to double
  %t35 = insertvalue %CanonicalTypeLayout %t33, double %t34, 2
  %t36 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t29, %CanonicalTypeLayout %t35)
  store { %CanonicalTypeLayout*, i64 }* %t36, { %CanonicalTypeLayout*, i64 }** %l0
  %t37 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s38 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h898775369, i32 0, i32 0
  %t39 = insertvalue %CanonicalTypeLayout undef, i8* %s38, 0
  %t40 = sitofp i64 8 to double
  %t41 = insertvalue %CanonicalTypeLayout %t39, double %t40, 1
  %t42 = sitofp i64 8 to double
  %t43 = insertvalue %CanonicalTypeLayout %t41, double %t42, 2
  %t44 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t37, %CanonicalTypeLayout %t43)
  store { %CanonicalTypeLayout*, i64 }* %t44, { %CanonicalTypeLayout*, i64 }** %l0
  %t45 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s46 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h699691610, i32 0, i32 0
  %t47 = insertvalue %CanonicalTypeLayout undef, i8* %s46, 0
  %t48 = sitofp i64 8 to double
  %t49 = insertvalue %CanonicalTypeLayout %t47, double %t48, 1
  %t50 = sitofp i64 8 to double
  %t51 = insertvalue %CanonicalTypeLayout %t49, double %t50, 2
  %t52 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t45, %CanonicalTypeLayout %t51)
  store { %CanonicalTypeLayout*, i64 }* %t52, { %CanonicalTypeLayout*, i64 }** %l0
  %t53 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s54 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h302043987, i32 0, i32 0
  %t55 = insertvalue %CanonicalTypeLayout undef, i8* %s54, 0
  %t56 = sitofp i64 8 to double
  %t57 = insertvalue %CanonicalTypeLayout %t55, double %t56, 1
  %t58 = sitofp i64 8 to double
  %t59 = insertvalue %CanonicalTypeLayout %t57, double %t58, 2
  %t60 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t53, %CanonicalTypeLayout %t59)
  store { %CanonicalTypeLayout*, i64 }* %t60, { %CanonicalTypeLayout*, i64 }** %l0
  %t61 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s62 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1629914700, i32 0, i32 0
  %t63 = insertvalue %CanonicalTypeLayout undef, i8* %s62, 0
  %t64 = sitofp i64 8 to double
  %t65 = insertvalue %CanonicalTypeLayout %t63, double %t64, 1
  %t66 = sitofp i64 8 to double
  %t67 = insertvalue %CanonicalTypeLayout %t65, double %t66, 2
  %t68 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t61, %CanonicalTypeLayout %t67)
  store { %CanonicalTypeLayout*, i64 }* %t68, { %CanonicalTypeLayout*, i64 }** %l0
  %t69 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s70 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1724213902, i32 0, i32 0
  %t71 = insertvalue %CanonicalTypeLayout undef, i8* %s70, 0
  %t72 = sitofp i64 8 to double
  %t73 = insertvalue %CanonicalTypeLayout %t71, double %t72, 1
  %t74 = sitofp i64 8 to double
  %t75 = insertvalue %CanonicalTypeLayout %t73, double %t74, 2
  %t76 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t69, %CanonicalTypeLayout %t75)
  store { %CanonicalTypeLayout*, i64 }* %t76, { %CanonicalTypeLayout*, i64 }** %l0
  %t77 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s78 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1381756460, i32 0, i32 0
  %t79 = insertvalue %CanonicalTypeLayout undef, i8* %s78, 0
  %t80 = sitofp i64 8 to double
  %t81 = insertvalue %CanonicalTypeLayout %t79, double %t80, 1
  %t82 = sitofp i64 8 to double
  %t83 = insertvalue %CanonicalTypeLayout %t81, double %t82, 2
  %t84 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t77, %CanonicalTypeLayout %t83)
  store { %CanonicalTypeLayout*, i64 }* %t84, { %CanonicalTypeLayout*, i64 }** %l0
  %t85 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s86 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h259975568, i32 0, i32 0
  %t87 = insertvalue %CanonicalTypeLayout undef, i8* %s86, 0
  %t88 = sitofp i64 8 to double
  %t89 = insertvalue %CanonicalTypeLayout %t87, double %t88, 1
  %t90 = sitofp i64 8 to double
  %t91 = insertvalue %CanonicalTypeLayout %t89, double %t90, 2
  %t92 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t85, %CanonicalTypeLayout %t91)
  store { %CanonicalTypeLayout*, i64 }* %t92, { %CanonicalTypeLayout*, i64 }** %l0
  %t93 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s94 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h83011545, i32 0, i32 0
  %t95 = insertvalue %CanonicalTypeLayout undef, i8* %s94, 0
  %t96 = sitofp i64 8 to double
  %t97 = insertvalue %CanonicalTypeLayout %t95, double %t96, 1
  %t98 = sitofp i64 8 to double
  %t99 = insertvalue %CanonicalTypeLayout %t97, double %t98, 2
  %t100 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t93, %CanonicalTypeLayout %t99)
  store { %CanonicalTypeLayout*, i64 }* %t100, { %CanonicalTypeLayout*, i64 }** %l0
  %t101 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s102 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h355918296, i32 0, i32 0
  %t103 = insertvalue %CanonicalTypeLayout undef, i8* %s102, 0
  %t104 = sitofp i64 8 to double
  %t105 = insertvalue %CanonicalTypeLayout %t103, double %t104, 1
  %t106 = sitofp i64 8 to double
  %t107 = insertvalue %CanonicalTypeLayout %t105, double %t106, 2
  %t108 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t101, %CanonicalTypeLayout %t107)
  store { %CanonicalTypeLayout*, i64 }* %t108, { %CanonicalTypeLayout*, i64 }** %l0
  %t109 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s110 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1057071035, i32 0, i32 0
  %t111 = insertvalue %CanonicalTypeLayout undef, i8* %s110, 0
  %t112 = sitofp i64 8 to double
  %t113 = insertvalue %CanonicalTypeLayout %t111, double %t112, 1
  %t114 = sitofp i64 8 to double
  %t115 = insertvalue %CanonicalTypeLayout %t113, double %t114, 2
  %t116 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t109, %CanonicalTypeLayout %t115)
  store { %CanonicalTypeLayout*, i64 }* %t116, { %CanonicalTypeLayout*, i64 }** %l0
  %t117 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s118 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h2110552132, i32 0, i32 0
  %t119 = insertvalue %CanonicalTypeLayout undef, i8* %s118, 0
  %t120 = sitofp i64 8 to double
  %t121 = insertvalue %CanonicalTypeLayout %t119, double %t120, 1
  %t122 = sitofp i64 8 to double
  %t123 = insertvalue %CanonicalTypeLayout %t121, double %t122, 2
  %t124 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t117, %CanonicalTypeLayout %t123)
  store { %CanonicalTypeLayout*, i64 }* %t124, { %CanonicalTypeLayout*, i64 }** %l0
  %t125 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s126 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h198095254, i32 0, i32 0
  %t127 = insertvalue %CanonicalTypeLayout undef, i8* %s126, 0
  %t128 = sitofp i64 8 to double
  %t129 = insertvalue %CanonicalTypeLayout %t127, double %t128, 1
  %t130 = sitofp i64 8 to double
  %t131 = insertvalue %CanonicalTypeLayout %t129, double %t130, 2
  %t132 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t125, %CanonicalTypeLayout %t131)
  store { %CanonicalTypeLayout*, i64 }* %t132, { %CanonicalTypeLayout*, i64 }** %l0
  %t133 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s134 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h152073561, i32 0, i32 0
  %t135 = insertvalue %CanonicalTypeLayout undef, i8* %s134, 0
  %t136 = sitofp i64 8 to double
  %t137 = insertvalue %CanonicalTypeLayout %t135, double %t136, 1
  %t138 = sitofp i64 8 to double
  %t139 = insertvalue %CanonicalTypeLayout %t137, double %t138, 2
  %t140 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t133, %CanonicalTypeLayout %t139)
  store { %CanonicalTypeLayout*, i64 }* %t140, { %CanonicalTypeLayout*, i64 }** %l0
  %t141 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s142 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1508055514, i32 0, i32 0
  %t143 = insertvalue %CanonicalTypeLayout undef, i8* %s142, 0
  %t144 = sitofp i64 8 to double
  %t145 = insertvalue %CanonicalTypeLayout %t143, double %t144, 1
  %t146 = sitofp i64 8 to double
  %t147 = insertvalue %CanonicalTypeLayout %t145, double %t146, 2
  %t148 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t141, %CanonicalTypeLayout %t147)
  store { %CanonicalTypeLayout*, i64 }* %t148, { %CanonicalTypeLayout*, i64 }** %l0
  %t149 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s150 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h2121470532, i32 0, i32 0
  %t151 = insertvalue %CanonicalTypeLayout undef, i8* %s150, 0
  %t152 = sitofp i64 8 to double
  %t153 = insertvalue %CanonicalTypeLayout %t151, double %t152, 1
  %t154 = sitofp i64 8 to double
  %t155 = insertvalue %CanonicalTypeLayout %t153, double %t154, 2
  %t156 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t149, %CanonicalTypeLayout %t155)
  store { %CanonicalTypeLayout*, i64 }* %t156, { %CanonicalTypeLayout*, i64 }** %l0
  %t157 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s158 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h479148896, i32 0, i32 0
  %t159 = insertvalue %CanonicalTypeLayout undef, i8* %s158, 0
  %t160 = sitofp i64 8 to double
  %t161 = insertvalue %CanonicalTypeLayout %t159, double %t160, 1
  %t162 = sitofp i64 8 to double
  %t163 = insertvalue %CanonicalTypeLayout %t161, double %t162, 2
  %t164 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t157, %CanonicalTypeLayout %t163)
  store { %CanonicalTypeLayout*, i64 }* %t164, { %CanonicalTypeLayout*, i64 }** %l0
  %t165 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s166 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h571715647, i32 0, i32 0
  %t167 = insertvalue %CanonicalTypeLayout undef, i8* %s166, 0
  %t168 = sitofp i64 8 to double
  %t169 = insertvalue %CanonicalTypeLayout %t167, double %t168, 1
  %t170 = sitofp i64 8 to double
  %t171 = insertvalue %CanonicalTypeLayout %t169, double %t170, 2
  %t172 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t165, %CanonicalTypeLayout %t171)
  store { %CanonicalTypeLayout*, i64 }* %t172, { %CanonicalTypeLayout*, i64 }** %l0
  %t173 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s174 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h889179835, i32 0, i32 0
  %t175 = insertvalue %CanonicalTypeLayout undef, i8* %s174, 0
  %t176 = sitofp i64 8 to double
  %t177 = insertvalue %CanonicalTypeLayout %t175, double %t176, 1
  %t178 = sitofp i64 8 to double
  %t179 = insertvalue %CanonicalTypeLayout %t177, double %t178, 2
  %t180 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t173, %CanonicalTypeLayout %t179)
  store { %CanonicalTypeLayout*, i64 }* %t180, { %CanonicalTypeLayout*, i64 }** %l0
  %t181 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s182 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h2043328844, i32 0, i32 0
  %t183 = insertvalue %CanonicalTypeLayout undef, i8* %s182, 0
  %t184 = sitofp i64 8 to double
  %t185 = insertvalue %CanonicalTypeLayout %t183, double %t184, 1
  %t186 = sitofp i64 8 to double
  %t187 = insertvalue %CanonicalTypeLayout %t185, double %t186, 2
  %t188 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t181, %CanonicalTypeLayout %t187)
  store { %CanonicalTypeLayout*, i64 }* %t188, { %CanonicalTypeLayout*, i64 }** %l0
  %t189 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s190 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1902764570, i32 0, i32 0
  %t191 = insertvalue %CanonicalTypeLayout undef, i8* %s190, 0
  %t192 = sitofp i64 8 to double
  %t193 = insertvalue %CanonicalTypeLayout %t191, double %t192, 1
  %t194 = sitofp i64 8 to double
  %t195 = insertvalue %CanonicalTypeLayout %t193, double %t194, 2
  %t196 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t189, %CanonicalTypeLayout %t195)
  store { %CanonicalTypeLayout*, i64 }* %t196, { %CanonicalTypeLayout*, i64 }** %l0
  %t197 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s198 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1620510857, i32 0, i32 0
  %t199 = insertvalue %CanonicalTypeLayout undef, i8* %s198, 0
  %t200 = sitofp i64 8 to double
  %t201 = insertvalue %CanonicalTypeLayout %t199, double %t200, 1
  %t202 = sitofp i64 8 to double
  %t203 = insertvalue %CanonicalTypeLayout %t201, double %t202, 2
  %t204 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t197, %CanonicalTypeLayout %t203)
  store { %CanonicalTypeLayout*, i64 }* %t204, { %CanonicalTypeLayout*, i64 }** %l0
  %t205 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s206 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1192169574, i32 0, i32 0
  %t207 = insertvalue %CanonicalTypeLayout undef, i8* %s206, 0
  %t208 = sitofp i64 8 to double
  %t209 = insertvalue %CanonicalTypeLayout %t207, double %t208, 1
  %t210 = sitofp i64 8 to double
  %t211 = insertvalue %CanonicalTypeLayout %t209, double %t210, 2
  %t212 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t205, %CanonicalTypeLayout %t211)
  store { %CanonicalTypeLayout*, i64 }* %t212, { %CanonicalTypeLayout*, i64 }** %l0
  %t213 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s214 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h204830940, i32 0, i32 0
  %t215 = insertvalue %CanonicalTypeLayout undef, i8* %s214, 0
  %t216 = sitofp i64 8 to double
  %t217 = insertvalue %CanonicalTypeLayout %t215, double %t216, 1
  %t218 = sitofp i64 8 to double
  %t219 = insertvalue %CanonicalTypeLayout %t217, double %t218, 2
  %t220 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t213, %CanonicalTypeLayout %t219)
  store { %CanonicalTypeLayout*, i64 }* %t220, { %CanonicalTypeLayout*, i64 }** %l0
  %t221 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s222 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h711382918, i32 0, i32 0
  %t223 = insertvalue %CanonicalTypeLayout undef, i8* %s222, 0
  %t224 = sitofp i64 8 to double
  %t225 = insertvalue %CanonicalTypeLayout %t223, double %t224, 1
  %t226 = sitofp i64 8 to double
  %t227 = insertvalue %CanonicalTypeLayout %t225, double %t226, 2
  %t228 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t221, %CanonicalTypeLayout %t227)
  store { %CanonicalTypeLayout*, i64 }* %t228, { %CanonicalTypeLayout*, i64 }** %l0
  %t229 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s230 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1969606825, i32 0, i32 0
  %t231 = insertvalue %CanonicalTypeLayout undef, i8* %s230, 0
  %t232 = sitofp i64 8 to double
  %t233 = insertvalue %CanonicalTypeLayout %t231, double %t232, 1
  %t234 = sitofp i64 8 to double
  %t235 = insertvalue %CanonicalTypeLayout %t233, double %t234, 2
  %t236 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t229, %CanonicalTypeLayout %t235)
  store { %CanonicalTypeLayout*, i64 }* %t236, { %CanonicalTypeLayout*, i64 }** %l0
  %t237 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s238 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h364122910, i32 0, i32 0
  %t239 = insertvalue %CanonicalTypeLayout undef, i8* %s238, 0
  %t240 = sitofp i64 8 to double
  %t241 = insertvalue %CanonicalTypeLayout %t239, double %t240, 1
  %t242 = sitofp i64 8 to double
  %t243 = insertvalue %CanonicalTypeLayout %t241, double %t242, 2
  %t244 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t237, %CanonicalTypeLayout %t243)
  store { %CanonicalTypeLayout*, i64 }* %t244, { %CanonicalTypeLayout*, i64 }** %l0
  %t245 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s246 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h300877395, i32 0, i32 0
  %t247 = insertvalue %CanonicalTypeLayout undef, i8* %s246, 0
  %t248 = sitofp i64 8 to double
  %t249 = insertvalue %CanonicalTypeLayout %t247, double %t248, 1
  %t250 = sitofp i64 8 to double
  %t251 = insertvalue %CanonicalTypeLayout %t249, double %t250, 2
  %t252 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t245, %CanonicalTypeLayout %t251)
  store { %CanonicalTypeLayout*, i64 }* %t252, { %CanonicalTypeLayout*, i64 }** %l0
  %t253 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s254 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h575661041, i32 0, i32 0
  %t255 = insertvalue %CanonicalTypeLayout undef, i8* %s254, 0
  %t256 = sitofp i64 8 to double
  %t257 = insertvalue %CanonicalTypeLayout %t255, double %t256, 1
  %t258 = sitofp i64 8 to double
  %t259 = insertvalue %CanonicalTypeLayout %t257, double %t258, 2
  %t260 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t253, %CanonicalTypeLayout %t259)
  store { %CanonicalTypeLayout*, i64 }* %t260, { %CanonicalTypeLayout*, i64 }** %l0
  %t261 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s262 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h237087299, i32 0, i32 0
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
  call void @sailfin_runtime_bounds_check(i64 %t14, i64 %t17)
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
  %t34 = load double, double* %l1
  %t35 = bitcast i8* null to %CanonicalTypeLayout*
  ret %CanonicalTypeLayout* %t35
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
  %t9 = phi double [ %t2, %merge1 ], [ %t8, %loop.latch4 ]
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
  %t11 = load double, double* %l0
  %t12 = sitofp i64 0 to double
  %t13 = fcmp oeq double %t11, %t12
  %t14 = load double, double* %l0
  br i1 %t13, label %then8, label %merge9
then8:
  ret double %value
merge9:
  %t15 = fadd double %value, %alignment
  %t16 = load double, double* %l0
  %t17 = fsub double %t15, %t16
  ret double %t17
}

define i1 @is_array_type(i8* %type_annotation) {
entry:
  %s0 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193479167, i32 0, i32 0
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
  %t35 = phi double [ %t10, %merge3 ], [ %t34, %loop.latch6 ]
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
  %t36 = load double, double* %l1
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
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s6, i8** %l1
  %s7 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h626550212, i32 0, i32 0
  store i8* %s7, i8** %l2
  %t8 = load double, double* %l0
  %t9 = load i8*, i8** %l1
  %t10 = load i8*, i8** %l2
  br label %loop.header2
loop.header2:
  %t59 = phi i8* [ %t9, %merge1 ], [ %t57, %loop.latch4 ]
  %t60 = phi double [ %t8, %merge1 ], [ %t58, %loop.latch4 ]
  store i8* %t59, i8** %l1
  store double %t60, double* %l0
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
  %t40 = phi double [ %t22, %merge7 ], [ %t38, %loop.latch10 ]
  %t41 = phi double [ %t23, %merge7 ], [ %t39, %loop.latch10 ]
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
  %t43 = load double, double* %l4
  %t44 = load double, double* %l3
  store double %t44, double* %l5
  %t45 = load i8*, i8** %l2
  %t46 = load double, double* %l5
  %t47 = load double, double* %l5
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  %t50 = fptosi double %t46 to i64
  %t51 = fptosi double %t49 to i64
  %t52 = call i8* @sailfin_runtime_substring(i8* %t45, i64 %t50, i64 %t51)
  store i8* %t52, i8** %l6
  %t53 = load i8*, i8** %l6
  %t54 = load i8*, i8** %l1
  %t55 = call i8* @sailfin_runtime_string_concat(i8* %t53, i8* %t54)
  store i8* %t55, i8** %l1
  %t56 = load double, double* %l4
  store double %t56, double* %l0
  br label %loop.latch4
loop.latch4:
  %t57 = load i8*, i8** %l1
  %t58 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t61 = load i8*, i8** %l1
  %t62 = load double, double* %l0
  %t63 = load i8*, i8** %l1
  ret i8* %t63
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
  %s50 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1576352120, i32 0, i32 0
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
  %s110 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1570408460, i32 0, i32 0
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
  %s182 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1318614710, i32 0, i32 0
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
  %s254 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1571993816, i32 0, i32 0
  %t255 = icmp eq i8* %t253, %s254
  br i1 %t255, label %then6, label %merge7
then6:
  %s256 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268929446, i32 0, i32 0
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
  %s307 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h590768815, i32 0, i32 0
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
  %s380 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1445149598, i32 0, i32 0
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
  %t407 = call i8* @sailfin_runtime_string_concat(i8* %t395, i8* %t406)
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
  %s458 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1496334143, i32 0, i32 0
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
  %s559 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h512390329, i32 0, i32 0
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
  %s638 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h217216103, i32 0, i32 0
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
  call void @sailfin_runtime_bounds_check(i64 %t675, i64 %t678)
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
  %t693 = load double, double* %l3
  %t694 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s695 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t696 = call i8* @join_with_separator({ i8**, i64 }* %t694, i8* %s695)
  store i8* %t696, i8** %l4
  %t697 = extractvalue %Expression %expression, 0
  %t698 = alloca %Expression
  store %Expression %expression, %Expression* %t698
  %t699 = getelementptr inbounds %Expression, %Expression* %t698, i32 0, i32 1
  %t700 = bitcast [16 x i8]* %t699 to i8*
  %t701 = bitcast i8* %t700 to %Expression**
  %t702 = load %Expression*, %Expression** %t701
  %t703 = icmp eq i32 %t697, 8
  %t704 = select i1 %t703, %Expression* %t702, %Expression* null
  %t705 = load %Expression, %Expression* %t704
  %t706 = call i8* @format_expression(%Expression %t705)
  %t707 = load i8, i8* %t706
  %t708 = add i8 %t707, 40
  %t709 = load i8*, i8** %l4
  %t710 = load i8, i8* %t709
  %t711 = add i8 %t708, %t710
  %t712 = add i8 %t711, 41
  %t713 = alloca [2 x i8], align 1
  %t714 = getelementptr [2 x i8], [2 x i8]* %t713, i32 0, i32 0
  store i8 %t712, i8* %t714
  %t715 = getelementptr [2 x i8], [2 x i8]* %t713, i32 0, i32 1
  store i8 0, i8* %t715
  %t716 = getelementptr [2 x i8], [2 x i8]* %t713, i32 0, i32 0
  ret i8* %t716
merge17:
  %t717 = extractvalue %Expression %expression, 0
  %t718 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t719 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t720 = icmp eq i32 %t717, 0
  %t721 = select i1 %t720, i8* %t719, i8* %t718
  %t722 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t723 = icmp eq i32 %t717, 1
  %t724 = select i1 %t723, i8* %t722, i8* %t721
  %t725 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t726 = icmp eq i32 %t717, 2
  %t727 = select i1 %t726, i8* %t725, i8* %t724
  %t728 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t729 = icmp eq i32 %t717, 3
  %t730 = select i1 %t729, i8* %t728, i8* %t727
  %t731 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t732 = icmp eq i32 %t717, 4
  %t733 = select i1 %t732, i8* %t731, i8* %t730
  %t734 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t735 = icmp eq i32 %t717, 5
  %t736 = select i1 %t735, i8* %t734, i8* %t733
  %t737 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t738 = icmp eq i32 %t717, 6
  %t739 = select i1 %t738, i8* %t737, i8* %t736
  %t740 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t741 = icmp eq i32 %t717, 7
  %t742 = select i1 %t741, i8* %t740, i8* %t739
  %t743 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t744 = icmp eq i32 %t717, 8
  %t745 = select i1 %t744, i8* %t743, i8* %t742
  %t746 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t747 = icmp eq i32 %t717, 9
  %t748 = select i1 %t747, i8* %t746, i8* %t745
  %t749 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t750 = icmp eq i32 %t717, 10
  %t751 = select i1 %t750, i8* %t749, i8* %t748
  %t752 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t753 = icmp eq i32 %t717, 11
  %t754 = select i1 %t753, i8* %t752, i8* %t751
  %t755 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t756 = icmp eq i32 %t717, 12
  %t757 = select i1 %t756, i8* %t755, i8* %t754
  %t758 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t759 = icmp eq i32 %t717, 13
  %t760 = select i1 %t759, i8* %t758, i8* %t757
  %t761 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t762 = icmp eq i32 %t717, 14
  %t763 = select i1 %t762, i8* %t761, i8* %t760
  %t764 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t765 = icmp eq i32 %t717, 15
  %t766 = select i1 %t765, i8* %t764, i8* %t763
  %s767 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h975618503, i32 0, i32 0
  %t768 = icmp eq i8* %t766, %s767
  br i1 %t768, label %then24, label %merge25
then24:
  %t769 = extractvalue %Expression %expression, 0
  %t770 = alloca %Expression
  store %Expression %expression, %Expression* %t770
  %t771 = getelementptr inbounds %Expression, %Expression* %t770, i32 0, i32 1
  %t772 = bitcast [16 x i8]* %t771 to i8*
  %t773 = bitcast i8* %t772 to %Expression**
  %t774 = load %Expression*, %Expression** %t773
  %t775 = icmp eq i32 %t769, 9
  %t776 = select i1 %t775, %Expression* %t774, %Expression* null
  %t777 = load %Expression, %Expression* %t776
  %t778 = call i8* @format_expression(%Expression %t777)
  %t779 = load i8, i8* %t778
  %t780 = add i8 %t779, 91
  %t781 = extractvalue %Expression %expression, 0
  %t782 = alloca %Expression
  store %Expression %expression, %Expression* %t782
  %t783 = getelementptr inbounds %Expression, %Expression* %t782, i32 0, i32 1
  %t784 = bitcast [16 x i8]* %t783 to i8*
  %t785 = getelementptr inbounds i8, i8* %t784, i64 8
  %t786 = bitcast i8* %t785 to %Expression**
  %t787 = load %Expression*, %Expression** %t786
  %t788 = icmp eq i32 %t781, 9
  %t789 = select i1 %t788, %Expression* %t787, %Expression* null
  %t790 = load %Expression, %Expression* %t789
  %t791 = call i8* @format_expression(%Expression %t790)
  %t792 = load i8, i8* %t791
  %t793 = add i8 %t780, %t792
  %t794 = add i8 %t793, 93
  %t795 = alloca [2 x i8], align 1
  %t796 = getelementptr [2 x i8], [2 x i8]* %t795, i32 0, i32 0
  store i8 %t794, i8* %t796
  %t797 = getelementptr [2 x i8], [2 x i8]* %t795, i32 0, i32 1
  store i8 0, i8* %t797
  %t798 = getelementptr [2 x i8], [2 x i8]* %t795, i32 0, i32 0
  ret i8* %t798
merge25:
  %t799 = extractvalue %Expression %expression, 0
  %t800 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t801 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t802 = icmp eq i32 %t799, 0
  %t803 = select i1 %t802, i8* %t801, i8* %t800
  %t804 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t805 = icmp eq i32 %t799, 1
  %t806 = select i1 %t805, i8* %t804, i8* %t803
  %t807 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t808 = icmp eq i32 %t799, 2
  %t809 = select i1 %t808, i8* %t807, i8* %t806
  %t810 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t811 = icmp eq i32 %t799, 3
  %t812 = select i1 %t811, i8* %t810, i8* %t809
  %t813 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t814 = icmp eq i32 %t799, 4
  %t815 = select i1 %t814, i8* %t813, i8* %t812
  %t816 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t817 = icmp eq i32 %t799, 5
  %t818 = select i1 %t817, i8* %t816, i8* %t815
  %t819 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t820 = icmp eq i32 %t799, 6
  %t821 = select i1 %t820, i8* %t819, i8* %t818
  %t822 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t823 = icmp eq i32 %t799, 7
  %t824 = select i1 %t823, i8* %t822, i8* %t821
  %t825 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t826 = icmp eq i32 %t799, 8
  %t827 = select i1 %t826, i8* %t825, i8* %t824
  %t828 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t829 = icmp eq i32 %t799, 9
  %t830 = select i1 %t829, i8* %t828, i8* %t827
  %t831 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t832 = icmp eq i32 %t799, 10
  %t833 = select i1 %t832, i8* %t831, i8* %t830
  %t834 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t835 = icmp eq i32 %t799, 11
  %t836 = select i1 %t835, i8* %t834, i8* %t833
  %t837 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t838 = icmp eq i32 %t799, 12
  %t839 = select i1 %t838, i8* %t837, i8* %t836
  %t840 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t841 = icmp eq i32 %t799, 13
  %t842 = select i1 %t841, i8* %t840, i8* %t839
  %t843 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t844 = icmp eq i32 %t799, 14
  %t845 = select i1 %t844, i8* %t843, i8* %t842
  %t846 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t847 = icmp eq i32 %t799, 15
  %t848 = select i1 %t847, i8* %t846, i8* %t845
  %s849 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h667777838, i32 0, i32 0
  %t850 = icmp eq i8* %t848, %s849
  br i1 %t850, label %then26, label %merge27
then26:
  %t851 = extractvalue %Expression %expression, 0
  %t852 = alloca %Expression
  store %Expression %expression, %Expression* %t852
  %t853 = getelementptr inbounds %Expression, %Expression* %t852, i32 0, i32 1
  %t854 = bitcast [8 x i8]* %t853 to i8*
  %t855 = bitcast i8* %t854 to { %Expression**, i64 }**
  %t856 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t855
  %t857 = icmp eq i32 %t851, 10
  %t858 = select i1 %t857, { %Expression**, i64 }* %t856, { %Expression**, i64 }* null
  %t859 = bitcast { %Expression**, i64 }* %t858 to { %Expression*, i64 }*
  %t860 = call i8* @format_array_expression({ %Expression*, i64 }* %t859)
  ret i8* %t860
merge27:
  %t861 = extractvalue %Expression %expression, 0
  %t862 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t863 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t864 = icmp eq i32 %t861, 0
  %t865 = select i1 %t864, i8* %t863, i8* %t862
  %t866 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t867 = icmp eq i32 %t861, 1
  %t868 = select i1 %t867, i8* %t866, i8* %t865
  %t869 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t870 = icmp eq i32 %t861, 2
  %t871 = select i1 %t870, i8* %t869, i8* %t868
  %t872 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t873 = icmp eq i32 %t861, 3
  %t874 = select i1 %t873, i8* %t872, i8* %t871
  %t875 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t876 = icmp eq i32 %t861, 4
  %t877 = select i1 %t876, i8* %t875, i8* %t874
  %t878 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t879 = icmp eq i32 %t861, 5
  %t880 = select i1 %t879, i8* %t878, i8* %t877
  %t881 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t882 = icmp eq i32 %t861, 6
  %t883 = select i1 %t882, i8* %t881, i8* %t880
  %t884 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t885 = icmp eq i32 %t861, 7
  %t886 = select i1 %t885, i8* %t884, i8* %t883
  %t887 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t888 = icmp eq i32 %t861, 8
  %t889 = select i1 %t888, i8* %t887, i8* %t886
  %t890 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t891 = icmp eq i32 %t861, 9
  %t892 = select i1 %t891, i8* %t890, i8* %t889
  %t893 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t894 = icmp eq i32 %t861, 10
  %t895 = select i1 %t894, i8* %t893, i8* %t892
  %t896 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t897 = icmp eq i32 %t861, 11
  %t898 = select i1 %t897, i8* %t896, i8* %t895
  %t899 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t900 = icmp eq i32 %t861, 12
  %t901 = select i1 %t900, i8* %t899, i8* %t898
  %t902 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t903 = icmp eq i32 %t861, 13
  %t904 = select i1 %t903, i8* %t902, i8* %t901
  %t905 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t906 = icmp eq i32 %t861, 14
  %t907 = select i1 %t906, i8* %t905, i8* %t904
  %t908 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t909 = icmp eq i32 %t861, 15
  %t910 = select i1 %t909, i8* %t908, i8* %t907
  %s911 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h826984377, i32 0, i32 0
  %t912 = icmp eq i8* %t910, %s911
  br i1 %t912, label %then28, label %merge29
then28:
  %t913 = alloca [0 x i8*]
  %t914 = getelementptr [0 x i8*], [0 x i8*]* %t913, i32 0, i32 0
  %t915 = alloca { i8**, i64 }
  %t916 = getelementptr { i8**, i64 }, { i8**, i64 }* %t915, i32 0, i32 0
  store i8** %t914, i8*** %t916
  %t917 = getelementptr { i8**, i64 }, { i8**, i64 }* %t915, i32 0, i32 1
  store i64 0, i64* %t917
  store { i8**, i64 }* %t915, { i8**, i64 }** %l5
  %t918 = sitofp i64 0 to double
  store double %t918, double* %l6
  %t919 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t920 = load double, double* %l6
  br label %loop.header30
loop.header30:
  %t983 = phi { i8**, i64 }* [ %t919, %then28 ], [ %t981, %loop.latch32 ]
  %t984 = phi double [ %t920, %then28 ], [ %t982, %loop.latch32 ]
  store { i8**, i64 }* %t983, { i8**, i64 }** %l5
  store double %t984, double* %l6
  br label %loop.body31
loop.body31:
  %t921 = load double, double* %l6
  %t922 = extractvalue %Expression %expression, 0
  %t923 = alloca %Expression
  store %Expression %expression, %Expression* %t923
  %t924 = getelementptr inbounds %Expression, %Expression* %t923, i32 0, i32 1
  %t925 = bitcast [8 x i8]* %t924 to i8*
  %t926 = bitcast i8* %t925 to { %ObjectField**, i64 }**
  %t927 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t926
  %t928 = icmp eq i32 %t922, 11
  %t929 = select i1 %t928, { %ObjectField**, i64 }* %t927, { %ObjectField**, i64 }* null
  %t930 = getelementptr inbounds %Expression, %Expression* %t923, i32 0, i32 1
  %t931 = bitcast [16 x i8]* %t930 to i8*
  %t932 = getelementptr inbounds i8, i8* %t931, i64 8
  %t933 = bitcast i8* %t932 to { %ObjectField**, i64 }**
  %t934 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t933
  %t935 = icmp eq i32 %t922, 12
  %t936 = select i1 %t935, { %ObjectField**, i64 }* %t934, { %ObjectField**, i64 }* %t929
  %t937 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t936
  %t938 = extractvalue { %ObjectField**, i64 } %t937, 1
  %t939 = sitofp i64 %t938 to double
  %t940 = fcmp oge double %t921, %t939
  %t941 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t942 = load double, double* %l6
  br i1 %t940, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t943 = extractvalue %Expression %expression, 0
  %t944 = alloca %Expression
  store %Expression %expression, %Expression* %t944
  %t945 = getelementptr inbounds %Expression, %Expression* %t944, i32 0, i32 1
  %t946 = bitcast [8 x i8]* %t945 to i8*
  %t947 = bitcast i8* %t946 to { %ObjectField**, i64 }**
  %t948 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t947
  %t949 = icmp eq i32 %t943, 11
  %t950 = select i1 %t949, { %ObjectField**, i64 }* %t948, { %ObjectField**, i64 }* null
  %t951 = getelementptr inbounds %Expression, %Expression* %t944, i32 0, i32 1
  %t952 = bitcast [16 x i8]* %t951 to i8*
  %t953 = getelementptr inbounds i8, i8* %t952, i64 8
  %t954 = bitcast i8* %t953 to { %ObjectField**, i64 }**
  %t955 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t954
  %t956 = icmp eq i32 %t943, 12
  %t957 = select i1 %t956, { %ObjectField**, i64 }* %t955, { %ObjectField**, i64 }* %t950
  %t958 = load double, double* %l6
  %t959 = fptosi double %t958 to i64
  %t960 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t957
  %t961 = extractvalue { %ObjectField**, i64 } %t960, 0
  %t962 = extractvalue { %ObjectField**, i64 } %t960, 1
  %t963 = icmp uge i64 %t959, %t962
  ; bounds check: %t963 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t959, i64 %t962)
  %t964 = getelementptr %ObjectField*, %ObjectField** %t961, i64 %t959
  %t965 = load %ObjectField*, %ObjectField** %t964
  store %ObjectField* %t965, %ObjectField** %l7
  %t966 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t967 = load %ObjectField*, %ObjectField** %l7
  %t968 = getelementptr %ObjectField, %ObjectField* %t967, i32 0, i32 0
  %t969 = load i8*, i8** %t968
  %s970 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193441217, i32 0, i32 0
  %t971 = call i8* @sailfin_runtime_string_concat(i8* %t969, i8* %s970)
  %t972 = load %ObjectField*, %ObjectField** %l7
  %t973 = getelementptr %ObjectField, %ObjectField* %t972, i32 0, i32 1
  %t974 = load %Expression, %Expression* %t973
  %t975 = call i8* @format_expression(%Expression %t974)
  %t976 = call i8* @sailfin_runtime_string_concat(i8* %t971, i8* %t975)
  %t977 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t966, i8* %t976)
  store { i8**, i64 }* %t977, { i8**, i64 }** %l5
  %t978 = load double, double* %l6
  %t979 = sitofp i64 1 to double
  %t980 = fadd double %t978, %t979
  store double %t980, double* %l6
  br label %loop.latch32
loop.latch32:
  %t981 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t982 = load double, double* %l6
  br label %loop.header30
afterloop33:
  %t985 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t986 = load double, double* %l6
  %s987 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193512002, i32 0, i32 0
  %t988 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s989 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t990 = call i8* @join_with_separator({ i8**, i64 }* %t988, i8* %s989)
  %t991 = call i8* @sailfin_runtime_string_concat(i8* %s987, i8* %t990)
  %s992 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415972, i32 0, i32 0
  %t993 = call i8* @sailfin_runtime_string_concat(i8* %t991, i8* %s992)
  ret i8* %t993
merge29:
  %t994 = extractvalue %Expression %expression, 0
  %t995 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t996 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t997 = icmp eq i32 %t994, 0
  %t998 = select i1 %t997, i8* %t996, i8* %t995
  %t999 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1000 = icmp eq i32 %t994, 1
  %t1001 = select i1 %t1000, i8* %t999, i8* %t998
  %t1002 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1003 = icmp eq i32 %t994, 2
  %t1004 = select i1 %t1003, i8* %t1002, i8* %t1001
  %t1005 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1006 = icmp eq i32 %t994, 3
  %t1007 = select i1 %t1006, i8* %t1005, i8* %t1004
  %t1008 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1009 = icmp eq i32 %t994, 4
  %t1010 = select i1 %t1009, i8* %t1008, i8* %t1007
  %t1011 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1012 = icmp eq i32 %t994, 5
  %t1013 = select i1 %t1012, i8* %t1011, i8* %t1010
  %t1014 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1015 = icmp eq i32 %t994, 6
  %t1016 = select i1 %t1015, i8* %t1014, i8* %t1013
  %t1017 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1018 = icmp eq i32 %t994, 7
  %t1019 = select i1 %t1018, i8* %t1017, i8* %t1016
  %t1020 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1021 = icmp eq i32 %t994, 8
  %t1022 = select i1 %t1021, i8* %t1020, i8* %t1019
  %t1023 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1024 = icmp eq i32 %t994, 9
  %t1025 = select i1 %t1024, i8* %t1023, i8* %t1022
  %t1026 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1027 = icmp eq i32 %t994, 10
  %t1028 = select i1 %t1027, i8* %t1026, i8* %t1025
  %t1029 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1030 = icmp eq i32 %t994, 11
  %t1031 = select i1 %t1030, i8* %t1029, i8* %t1028
  %t1032 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1033 = icmp eq i32 %t994, 12
  %t1034 = select i1 %t1033, i8* %t1032, i8* %t1031
  %t1035 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1036 = icmp eq i32 %t994, 13
  %t1037 = select i1 %t1036, i8* %t1035, i8* %t1034
  %t1038 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1039 = icmp eq i32 %t994, 14
  %t1040 = select i1 %t1039, i8* %t1038, i8* %t1037
  %t1041 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1042 = icmp eq i32 %t994, 15
  %t1043 = select i1 %t1042, i8* %t1041, i8* %t1040
  %s1044 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h264904746, i32 0, i32 0
  %t1045 = icmp eq i8* %t1043, %s1044
  br i1 %t1045, label %then36, label %merge37
then36:
  %t1046 = alloca [0 x i8*]
  %t1047 = getelementptr [0 x i8*], [0 x i8*]* %t1046, i32 0, i32 0
  %t1048 = alloca { i8**, i64 }
  %t1049 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1048, i32 0, i32 0
  store i8** %t1047, i8*** %t1049
  %t1050 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1048, i32 0, i32 1
  store i64 0, i64* %t1050
  store { i8**, i64 }* %t1048, { i8**, i64 }** %l8
  %t1051 = sitofp i64 0 to double
  store double %t1051, double* %l9
  %t1052 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1053 = load double, double* %l9
  br label %loop.header38
loop.header38:
  %t1116 = phi { i8**, i64 }* [ %t1052, %then36 ], [ %t1114, %loop.latch40 ]
  %t1117 = phi double [ %t1053, %then36 ], [ %t1115, %loop.latch40 ]
  store { i8**, i64 }* %t1116, { i8**, i64 }** %l8
  store double %t1117, double* %l9
  br label %loop.body39
loop.body39:
  %t1054 = load double, double* %l9
  %t1055 = extractvalue %Expression %expression, 0
  %t1056 = alloca %Expression
  store %Expression %expression, %Expression* %t1056
  %t1057 = getelementptr inbounds %Expression, %Expression* %t1056, i32 0, i32 1
  %t1058 = bitcast [8 x i8]* %t1057 to i8*
  %t1059 = bitcast i8* %t1058 to { %ObjectField**, i64 }**
  %t1060 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t1059
  %t1061 = icmp eq i32 %t1055, 11
  %t1062 = select i1 %t1061, { %ObjectField**, i64 }* %t1060, { %ObjectField**, i64 }* null
  %t1063 = getelementptr inbounds %Expression, %Expression* %t1056, i32 0, i32 1
  %t1064 = bitcast [16 x i8]* %t1063 to i8*
  %t1065 = getelementptr inbounds i8, i8* %t1064, i64 8
  %t1066 = bitcast i8* %t1065 to { %ObjectField**, i64 }**
  %t1067 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t1066
  %t1068 = icmp eq i32 %t1055, 12
  %t1069 = select i1 %t1068, { %ObjectField**, i64 }* %t1067, { %ObjectField**, i64 }* %t1062
  %t1070 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t1069
  %t1071 = extractvalue { %ObjectField**, i64 } %t1070, 1
  %t1072 = sitofp i64 %t1071 to double
  %t1073 = fcmp oge double %t1054, %t1072
  %t1074 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1075 = load double, double* %l9
  br i1 %t1073, label %then42, label %merge43
then42:
  br label %afterloop41
merge43:
  %t1076 = extractvalue %Expression %expression, 0
  %t1077 = alloca %Expression
  store %Expression %expression, %Expression* %t1077
  %t1078 = getelementptr inbounds %Expression, %Expression* %t1077, i32 0, i32 1
  %t1079 = bitcast [8 x i8]* %t1078 to i8*
  %t1080 = bitcast i8* %t1079 to { %ObjectField**, i64 }**
  %t1081 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t1080
  %t1082 = icmp eq i32 %t1076, 11
  %t1083 = select i1 %t1082, { %ObjectField**, i64 }* %t1081, { %ObjectField**, i64 }* null
  %t1084 = getelementptr inbounds %Expression, %Expression* %t1077, i32 0, i32 1
  %t1085 = bitcast [16 x i8]* %t1084 to i8*
  %t1086 = getelementptr inbounds i8, i8* %t1085, i64 8
  %t1087 = bitcast i8* %t1086 to { %ObjectField**, i64 }**
  %t1088 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t1087
  %t1089 = icmp eq i32 %t1076, 12
  %t1090 = select i1 %t1089, { %ObjectField**, i64 }* %t1088, { %ObjectField**, i64 }* %t1083
  %t1091 = load double, double* %l9
  %t1092 = fptosi double %t1091 to i64
  %t1093 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t1090
  %t1094 = extractvalue { %ObjectField**, i64 } %t1093, 0
  %t1095 = extractvalue { %ObjectField**, i64 } %t1093, 1
  %t1096 = icmp uge i64 %t1092, %t1095
  ; bounds check: %t1096 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1092, i64 %t1095)
  %t1097 = getelementptr %ObjectField*, %ObjectField** %t1094, i64 %t1092
  %t1098 = load %ObjectField*, %ObjectField** %t1097
  store %ObjectField* %t1098, %ObjectField** %l10
  %t1099 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1100 = load %ObjectField*, %ObjectField** %l10
  %t1101 = getelementptr %ObjectField, %ObjectField* %t1100, i32 0, i32 0
  %t1102 = load i8*, i8** %t1101
  %s1103 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193441217, i32 0, i32 0
  %t1104 = call i8* @sailfin_runtime_string_concat(i8* %t1102, i8* %s1103)
  %t1105 = load %ObjectField*, %ObjectField** %l10
  %t1106 = getelementptr %ObjectField, %ObjectField* %t1105, i32 0, i32 1
  %t1107 = load %Expression, %Expression* %t1106
  %t1108 = call i8* @format_expression(%Expression %t1107)
  %t1109 = call i8* @sailfin_runtime_string_concat(i8* %t1104, i8* %t1108)
  %t1110 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1099, i8* %t1109)
  store { i8**, i64 }* %t1110, { i8**, i64 }** %l8
  %t1111 = load double, double* %l9
  %t1112 = sitofp i64 1 to double
  %t1113 = fadd double %t1111, %t1112
  store double %t1113, double* %l9
  br label %loop.latch40
loop.latch40:
  %t1114 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1115 = load double, double* %l9
  br label %loop.header38
afterloop41:
  %t1118 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1119 = load double, double* %l9
  %t1120 = extractvalue %Expression %expression, 0
  %t1121 = alloca %Expression
  store %Expression %expression, %Expression* %t1121
  %t1122 = getelementptr inbounds %Expression, %Expression* %t1121, i32 0, i32 1
  %t1123 = bitcast [16 x i8]* %t1122 to i8*
  %t1124 = bitcast i8* %t1123 to { i8**, i64 }**
  %t1125 = load { i8**, i64 }*, { i8**, i64 }** %t1124
  %t1126 = icmp eq i32 %t1120, 12
  %t1127 = select i1 %t1126, { i8**, i64 }* %t1125, { i8**, i64 }* null
  %t1128 = alloca [2 x i8], align 1
  %t1129 = getelementptr [2 x i8], [2 x i8]* %t1128, i32 0, i32 0
  store i8 46, i8* %t1129
  %t1130 = getelementptr [2 x i8], [2 x i8]* %t1128, i32 0, i32 1
  store i8 0, i8* %t1130
  %t1131 = getelementptr [2 x i8], [2 x i8]* %t1128, i32 0, i32 0
  %t1132 = call i8* @join_with_separator({ i8**, i64 }* %t1127, i8* %t1131)
  store i8* %t1132, i8** %l11
  %t1133 = load i8*, i8** %l11
  %s1134 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087758597, i32 0, i32 0
  %t1135 = call i8* @sailfin_runtime_string_concat(i8* %t1133, i8* %s1134)
  %t1136 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %s1137 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t1138 = call i8* @join_with_separator({ i8**, i64 }* %t1136, i8* %s1137)
  %t1139 = call i8* @sailfin_runtime_string_concat(i8* %t1135, i8* %t1138)
  %s1140 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415972, i32 0, i32 0
  %t1141 = call i8* @sailfin_runtime_string_concat(i8* %t1139, i8* %s1140)
  ret i8* %t1141
merge37:
  %t1142 = extractvalue %Expression %expression, 0
  %t1143 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1144 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1145 = icmp eq i32 %t1142, 0
  %t1146 = select i1 %t1145, i8* %t1144, i8* %t1143
  %t1147 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1148 = icmp eq i32 %t1142, 1
  %t1149 = select i1 %t1148, i8* %t1147, i8* %t1146
  %t1150 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1151 = icmp eq i32 %t1142, 2
  %t1152 = select i1 %t1151, i8* %t1150, i8* %t1149
  %t1153 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1154 = icmp eq i32 %t1142, 3
  %t1155 = select i1 %t1154, i8* %t1153, i8* %t1152
  %t1156 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1157 = icmp eq i32 %t1142, 4
  %t1158 = select i1 %t1157, i8* %t1156, i8* %t1155
  %t1159 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1160 = icmp eq i32 %t1142, 5
  %t1161 = select i1 %t1160, i8* %t1159, i8* %t1158
  %t1162 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1163 = icmp eq i32 %t1142, 6
  %t1164 = select i1 %t1163, i8* %t1162, i8* %t1161
  %t1165 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1166 = icmp eq i32 %t1142, 7
  %t1167 = select i1 %t1166, i8* %t1165, i8* %t1164
  %t1168 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1169 = icmp eq i32 %t1142, 8
  %t1170 = select i1 %t1169, i8* %t1168, i8* %t1167
  %t1171 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1172 = icmp eq i32 %t1142, 9
  %t1173 = select i1 %t1172, i8* %t1171, i8* %t1170
  %t1174 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1175 = icmp eq i32 %t1142, 10
  %t1176 = select i1 %t1175, i8* %t1174, i8* %t1173
  %t1177 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1178 = icmp eq i32 %t1142, 11
  %t1179 = select i1 %t1178, i8* %t1177, i8* %t1176
  %t1180 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1181 = icmp eq i32 %t1142, 12
  %t1182 = select i1 %t1181, i8* %t1180, i8* %t1179
  %t1183 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1184 = icmp eq i32 %t1142, 13
  %t1185 = select i1 %t1184, i8* %t1183, i8* %t1182
  %t1186 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1187 = icmp eq i32 %t1142, 14
  %t1188 = select i1 %t1187, i8* %t1186, i8* %t1185
  %t1189 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1190 = icmp eq i32 %t1142, 15
  %t1191 = select i1 %t1190, i8* %t1189, i8* %t1188
  %s1192 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1312780988, i32 0, i32 0
  %t1193 = icmp eq i8* %t1191, %s1192
  br i1 %t1193, label %then44, label %merge45
then44:
  %t1194 = extractvalue %Expression %expression, 0
  %t1195 = alloca %Expression
  store %Expression %expression, %Expression* %t1195
  %t1196 = getelementptr inbounds %Expression, %Expression* %t1195, i32 0, i32 1
  %t1197 = bitcast [16 x i8]* %t1196 to i8*
  %t1198 = bitcast i8* %t1197 to %Expression**
  %t1199 = load %Expression*, %Expression** %t1198
  %t1200 = icmp eq i32 %t1194, 14
  %t1201 = select i1 %t1200, %Expression* %t1199, %Expression* null
  %t1202 = load %Expression, %Expression* %t1201
  %t1203 = call i8* @format_expression(%Expression %t1202)
  %s1204 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428611, i32 0, i32 0
  %t1205 = call i8* @sailfin_runtime_string_concat(i8* %t1203, i8* %s1204)
  %t1206 = extractvalue %Expression %expression, 0
  %t1207 = alloca %Expression
  store %Expression %expression, %Expression* %t1207
  %t1208 = getelementptr inbounds %Expression, %Expression* %t1207, i32 0, i32 1
  %t1209 = bitcast [16 x i8]* %t1208 to i8*
  %t1210 = getelementptr inbounds i8, i8* %t1209, i64 8
  %t1211 = bitcast i8* %t1210 to %Expression**
  %t1212 = load %Expression*, %Expression** %t1211
  %t1213 = icmp eq i32 %t1206, 14
  %t1214 = select i1 %t1213, %Expression* %t1212, %Expression* null
  %t1215 = load %Expression, %Expression* %t1214
  %t1216 = call i8* @format_expression(%Expression %t1215)
  %t1217 = call i8* @sailfin_runtime_string_concat(i8* %t1205, i8* %t1216)
  ret i8* %t1217
merge45:
  %t1218 = extractvalue %Expression %expression, 0
  %t1219 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1220 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1221 = icmp eq i32 %t1218, 0
  %t1222 = select i1 %t1221, i8* %t1220, i8* %t1219
  %t1223 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1224 = icmp eq i32 %t1218, 1
  %t1225 = select i1 %t1224, i8* %t1223, i8* %t1222
  %t1226 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1227 = icmp eq i32 %t1218, 2
  %t1228 = select i1 %t1227, i8* %t1226, i8* %t1225
  %t1229 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1230 = icmp eq i32 %t1218, 3
  %t1231 = select i1 %t1230, i8* %t1229, i8* %t1228
  %t1232 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1233 = icmp eq i32 %t1218, 4
  %t1234 = select i1 %t1233, i8* %t1232, i8* %t1231
  %t1235 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1236 = icmp eq i32 %t1218, 5
  %t1237 = select i1 %t1236, i8* %t1235, i8* %t1234
  %t1238 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1239 = icmp eq i32 %t1218, 6
  %t1240 = select i1 %t1239, i8* %t1238, i8* %t1237
  %t1241 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1242 = icmp eq i32 %t1218, 7
  %t1243 = select i1 %t1242, i8* %t1241, i8* %t1240
  %t1244 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1245 = icmp eq i32 %t1218, 8
  %t1246 = select i1 %t1245, i8* %t1244, i8* %t1243
  %t1247 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1248 = icmp eq i32 %t1218, 9
  %t1249 = select i1 %t1248, i8* %t1247, i8* %t1246
  %t1250 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1251 = icmp eq i32 %t1218, 10
  %t1252 = select i1 %t1251, i8* %t1250, i8* %t1249
  %t1253 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1254 = icmp eq i32 %t1218, 11
  %t1255 = select i1 %t1254, i8* %t1253, i8* %t1252
  %t1256 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1257 = icmp eq i32 %t1218, 12
  %t1258 = select i1 %t1257, i8* %t1256, i8* %t1255
  %t1259 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1260 = icmp eq i32 %t1218, 13
  %t1261 = select i1 %t1260, i8* %t1259, i8* %t1258
  %t1262 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1263 = icmp eq i32 %t1218, 14
  %t1264 = select i1 %t1263, i8* %t1262, i8* %t1261
  %t1265 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1266 = icmp eq i32 %t1218, 15
  %t1267 = select i1 %t1266, i8* %t1265, i8* %t1264
  %s1268 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1211862785, i32 0, i32 0
  %t1269 = icmp eq i8* %t1267, %s1268
  br i1 %t1269, label %then46, label %merge47
then46:
  %s1270 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h573909064, i32 0, i32 0
  ret i8* %s1270
merge47:
  %t1271 = extractvalue %Expression %expression, 0
  %t1272 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1273 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1274 = icmp eq i32 %t1271, 0
  %t1275 = select i1 %t1274, i8* %t1273, i8* %t1272
  %t1276 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1277 = icmp eq i32 %t1271, 1
  %t1278 = select i1 %t1277, i8* %t1276, i8* %t1275
  %t1279 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1280 = icmp eq i32 %t1271, 2
  %t1281 = select i1 %t1280, i8* %t1279, i8* %t1278
  %t1282 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1283 = icmp eq i32 %t1271, 3
  %t1284 = select i1 %t1283, i8* %t1282, i8* %t1281
  %t1285 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1286 = icmp eq i32 %t1271, 4
  %t1287 = select i1 %t1286, i8* %t1285, i8* %t1284
  %t1288 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1289 = icmp eq i32 %t1271, 5
  %t1290 = select i1 %t1289, i8* %t1288, i8* %t1287
  %t1291 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1292 = icmp eq i32 %t1271, 6
  %t1293 = select i1 %t1292, i8* %t1291, i8* %t1290
  %t1294 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1295 = icmp eq i32 %t1271, 7
  %t1296 = select i1 %t1295, i8* %t1294, i8* %t1293
  %t1297 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1298 = icmp eq i32 %t1271, 8
  %t1299 = select i1 %t1298, i8* %t1297, i8* %t1296
  %t1300 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1301 = icmp eq i32 %t1271, 9
  %t1302 = select i1 %t1301, i8* %t1300, i8* %t1299
  %t1303 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1304 = icmp eq i32 %t1271, 10
  %t1305 = select i1 %t1304, i8* %t1303, i8* %t1302
  %t1306 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1307 = icmp eq i32 %t1271, 11
  %t1308 = select i1 %t1307, i8* %t1306, i8* %t1305
  %t1309 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1310 = icmp eq i32 %t1271, 12
  %t1311 = select i1 %t1310, i8* %t1309, i8* %t1308
  %t1312 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1313 = icmp eq i32 %t1271, 13
  %t1314 = select i1 %t1313, i8* %t1312, i8* %t1311
  %t1315 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1316 = icmp eq i32 %t1271, 14
  %t1317 = select i1 %t1316, i8* %t1315, i8* %t1314
  %t1318 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1319 = icmp eq i32 %t1271, 15
  %t1320 = select i1 %t1319, i8* %t1318, i8* %t1317
  %s1321 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089530004, i32 0, i32 0
  %t1322 = icmp eq i8* %t1320, %s1321
  br i1 %t1322, label %then48, label %merge49
then48:
  %t1323 = extractvalue %Expression %expression, 0
  %t1324 = alloca %Expression
  store %Expression %expression, %Expression* %t1324
  %t1325 = getelementptr inbounds %Expression, %Expression* %t1324, i32 0, i32 1
  %t1326 = bitcast [8 x i8]* %t1325 to i8*
  %t1327 = bitcast i8* %t1326 to i8**
  %t1328 = load i8*, i8** %t1327
  %t1329 = icmp eq i32 %t1323, 15
  %t1330 = select i1 %t1329, i8* %t1328, i8* null
  %t1331 = call i8* @trim_text(i8* %t1330)
  ret i8* %t1331
merge49:
  %t1332 = extractvalue %Expression %expression, 0
  %t1333 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1334 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1335 = icmp eq i32 %t1332, 0
  %t1336 = select i1 %t1335, i8* %t1334, i8* %t1333
  %t1337 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1338 = icmp eq i32 %t1332, 1
  %t1339 = select i1 %t1338, i8* %t1337, i8* %t1336
  %t1340 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1341 = icmp eq i32 %t1332, 2
  %t1342 = select i1 %t1341, i8* %t1340, i8* %t1339
  %t1343 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1344 = icmp eq i32 %t1332, 3
  %t1345 = select i1 %t1344, i8* %t1343, i8* %t1342
  %t1346 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1347 = icmp eq i32 %t1332, 4
  %t1348 = select i1 %t1347, i8* %t1346, i8* %t1345
  %t1349 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1350 = icmp eq i32 %t1332, 5
  %t1351 = select i1 %t1350, i8* %t1349, i8* %t1348
  %t1352 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1353 = icmp eq i32 %t1332, 6
  %t1354 = select i1 %t1353, i8* %t1352, i8* %t1351
  %t1355 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1356 = icmp eq i32 %t1332, 7
  %t1357 = select i1 %t1356, i8* %t1355, i8* %t1354
  %t1358 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1359 = icmp eq i32 %t1332, 8
  %t1360 = select i1 %t1359, i8* %t1358, i8* %t1357
  %t1361 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1362 = icmp eq i32 %t1332, 9
  %t1363 = select i1 %t1362, i8* %t1361, i8* %t1360
  %t1364 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1365 = icmp eq i32 %t1332, 10
  %t1366 = select i1 %t1365, i8* %t1364, i8* %t1363
  %t1367 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1368 = icmp eq i32 %t1332, 11
  %t1369 = select i1 %t1368, i8* %t1367, i8* %t1366
  %t1370 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1371 = icmp eq i32 %t1332, 12
  %t1372 = select i1 %t1371, i8* %t1370, i8* %t1369
  %t1373 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1374 = icmp eq i32 %t1332, 13
  %t1375 = select i1 %t1374, i8* %t1373, i8* %t1372
  %t1376 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1377 = icmp eq i32 %t1332, 14
  %t1378 = select i1 %t1377, i8* %t1376, i8* %t1375
  %t1379 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1380 = icmp eq i32 %t1332, 15
  %t1381 = select i1 %t1380, i8* %t1379, i8* %t1378
  %t1382 = load i8, i8* %t1381
  %t1383 = add i8 60, %t1382
  %t1384 = add i8 %t1383, 62
  %t1385 = alloca [2 x i8], align 1
  %t1386 = getelementptr [2 x i8], [2 x i8]* %t1385, i32 0, i32 0
  store i8 %t1384, i8* %t1386
  %t1387 = getelementptr [2 x i8], [2 x i8]* %t1385, i32 0, i32 1
  store i8 0, i8* %t1387
  %t1388 = getelementptr [2 x i8], [2 x i8]* %t1385, i32 0, i32 0
  ret i8* %t1388
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
  call void @sailfin_runtime_bounds_check(i64 %t20, i64 %t23)
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
  %t37 = load double, double* %l2
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = load { i8**, i64 }, { i8**, i64 }* %t38
  %t40 = extractvalue { i8**, i64 } %t39, 1
  %t41 = icmp eq i64 %t40, 0
  %t42 = load i8*, i8** %l0
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t44 = load double, double* %l2
  br i1 %t41, label %then6, label %merge7
then6:
  %t45 = load i8*, i8** %l0
  %t46 = call i64 @sailfin_runtime_string_length(i8* %t45)
  %t47 = icmp eq i64 %t46, 0
  %t48 = load i8*, i8** %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t50 = load double, double* %l2
  br i1 %t47, label %then8, label %merge9
then8:
  %s51 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193479167, i32 0, i32 0
  ret i8* %s51
merge9:
  %s52 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1720834339, i32 0, i32 0
  %t53 = load i8*, i8** %l0
  %t54 = call i8* @sailfin_runtime_string_concat(i8* %s52, i8* %t53)
  %t55 = load i8, i8* %t54
  %t56 = add i8 %t55, 93
  %t57 = alloca [2 x i8], align 1
  %t58 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 0
  store i8 %t56, i8* %t58
  %t59 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 1
  store i8 0, i8* %t59
  %t60 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 0
  ret i8* %t60
merge7:
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s62 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t63 = call i8* @join_with_separator({ i8**, i64 }* %t61, i8* %s62)
  store i8* %t63, i8** %l3
  %t64 = load i8*, i8** %l0
  %t65 = call i64 @sailfin_runtime_string_length(i8* %t64)
  %t66 = icmp eq i64 %t65, 0
  %t67 = load i8*, i8** %l0
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t69 = load double, double* %l2
  %t70 = load i8*, i8** %l3
  br i1 %t66, label %then10, label %merge11
then10:
  %t71 = load i8*, i8** %l3
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
  %s79 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1720834339, i32 0, i32 0
  %t80 = load i8*, i8** %l0
  %t81 = call i8* @sailfin_runtime_string_concat(i8* %s79, i8* %t80)
  %s82 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t83 = call i8* @sailfin_runtime_string_concat(i8* %t81, i8* %s82)
  %t84 = load i8*, i8** %l3
  %t85 = call i8* @sailfin_runtime_string_concat(i8* %t83, i8* %t84)
  %t86 = load i8, i8* %t85
  %t87 = add i8 %t86, 93
  %t88 = alloca [2 x i8], align 1
  %t89 = getelementptr [2 x i8], [2 x i8]* %t88, i32 0, i32 0
  store i8 %t87, i8* %t89
  %t90 = getelementptr [2 x i8], [2 x i8]* %t88, i32 0, i32 1
  store i8 0, i8* %t90
  %t91 = getelementptr [2 x i8], [2 x i8]* %t88, i32 0, i32 0
  ret i8* %t91
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
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  ret i8* %s3
merge1:
  %s4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s4, i8** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load i8*, i8** %l0
  %t7 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t52 = phi i8* [ %t6, %merge1 ], [ %t50, %loop.latch4 ]
  %t53 = phi double [ %t7, %merge1 ], [ %t51, %loop.latch4 ]
  store i8* %t52, i8** %l0
  store double %t53, double* %l1
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
  call void @sailfin_runtime_bounds_check(i64 %t16, i64 %t19)
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
  %s30 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
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
  %t38 = load i8*, i8** %l0
  br label %merge12
else11:
  %t39 = load i8*, i8** %l0
  %t40 = load i8*, i8** %l2
  %t41 = icmp ne i8* %t39, %t40
  %t42 = load i8*, i8** %l0
  %t43 = load double, double* %l1
  %t44 = load i8*, i8** %l2
  br i1 %t41, label %then13, label %merge14
then13:
  %s45 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  ret i8* %s45
merge14:
  br label %merge12
merge12:
  %t46 = phi i8* [ %t38, %then10 ], [ %t34, %merge14 ]
  store i8* %t46, i8** %l0
  %t47 = load double, double* %l1
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l1
  br label %loop.latch4
loop.latch4:
  %t50 = load i8*, i8** %l0
  %t51 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t54 = load i8*, i8** %l0
  %t55 = load double, double* %l1
  %t56 = load i8*, i8** %l0
  ret i8* %t56
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
  %s50 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1570408460, i32 0, i32 0
  %t51 = icmp eq i8* %t49, %s50
  br i1 %t51, label %then0, label %merge1
then0:
  %s52 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h807326654, i32 0, i32 0
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
  %s103 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1318614710, i32 0, i32 0
  %t104 = icmp eq i8* %t102, %s103
  br i1 %t104, label %then2, label %merge3
then2:
  %s105 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h1483009776, i32 0, i32 0
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
  %s156 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h590768815, i32 0, i32 0
  %t157 = icmp eq i8* %t155, %s156
  br i1 %t157, label %then4, label %merge5
then4:
  %s158 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h789270767, i32 0, i32 0
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
  %s209 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h264904746, i32 0, i32 0
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
  %s222 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
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
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t244)
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
  %s311 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h512390329, i32 0, i32 0
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
  %s372 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1576352120, i32 0, i32 0
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
  %s449 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h512390329, i32 0, i32 0
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
  %s461 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
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
  %s512 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h667777838, i32 0, i32 0
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
  %s528 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  ret i8* %s528
merge21:
  %t529 = load i8*, i8** %l0
  %s530 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193479167, i32 0, i32 0
  %t531 = call i8* @sailfin_runtime_string_concat(i8* %t529, i8* %s530)
  ret i8* %t531
merge19:
  %s532 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
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
  %t23 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %t22)
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
  %t32 = load double, double* %l1
  %t33 = load i8*, i8** %l0
  %t34 = load i8, i8* %t33
  %t35 = add i8 %t34, 34
  %t36 = alloca [2 x i8], align 1
  %t37 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 0
  store i8 %t35, i8* %t37
  %t38 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 1
  store i8 0, i8* %t38
  %t39 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 0
  store i8* %t39, i8** %l0
  %t40 = load i8*, i8** %l0
  ret i8* %t40
}

define i8* @escape_string_char(i8* %ch) {
entry:
  %t0 = load i8, i8* %ch
  %t1 = icmp eq i8 %t0, 34
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193478309, i32 0, i32 0
  ret i8* %s2
merge1:
  %t3 = load i8, i8* %ch
  %t4 = icmp eq i8 %t3, 92
  br i1 %t4, label %then2, label %merge3
then2:
  %s5 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193480223, i32 0, i32 0
  ret i8* %s5
merge3:
  %t6 = load i8, i8* %ch
  %t7 = icmp eq i8 %t6, 10
  br i1 %t7, label %then4, label %merge5
then4:
  %s8 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193480817, i32 0, i32 0
  ret i8* %s8
merge5:
  %t9 = load i8, i8* %ch
  %t10 = icmp eq i8 %t9, 13
  br i1 %t10, label %then6, label %merge7
then6:
  %s11 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193480949, i32 0, i32 0
  ret i8* %s11
merge7:
  %t12 = load i8, i8* %ch
  %t13 = icmp eq i8 %t12, 9
  br i1 %t13, label %then8, label %merge9
then8:
  %s14 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193481015, i32 0, i32 0
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
  %t263 = phi { i8**, i64 }* [ %t6, %entry ], [ %t261, %loop.latch2 ]
  %t264 = phi double [ %t7, %entry ], [ %t262, %loop.latch2 ]
  store { i8**, i64 }* %t263, { i8**, i64 }** %l0
  store double %t264, double* %l1
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
  call void @sailfin_runtime_bounds_check(i64 %t18, i64 %t21)
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
  %s98 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h486335986, i32 0, i32 0
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
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t128 = phi { i8**, i64 }* [ %t127, %then6 ], [ %t100, %merge5 ]
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
  %s202 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h889179835, i32 0, i32 0
  %t203 = icmp eq i8* %t201, %s202
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t205 = load double, double* %l1
  %t206 = load %Statement*, %Statement** %l2
  br i1 %t203, label %then8, label %merge9
then8:
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s208 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h500836810, i32 0, i32 0
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
  %t254 = call i8* @sailfin_runtime_string_concat(i8* %s208, i8* %t253)
  %t255 = call { i8**, i64 }* @append_unique({ i8**, i64 }* %t207, i8* %t254)
  store { i8**, i64 }* %t255, { i8**, i64 }** %l0
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t257 = phi { i8**, i64 }* [ %t256, %then8 ], [ %t204, %merge7 ]
  store { i8**, i64 }* %t257, { i8**, i64 }** %l0
  %t258 = load double, double* %l1
  %t259 = sitofp i64 1 to double
  %t260 = fadd double %t258, %t259
  store double %t260, double* %l1
  br label %loop.latch2
loop.latch2:
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t262 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t266 = load double, double* %l1
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t267
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
  %t725 = phi double [ %t2, %entry ], [ %t723, %loop.latch2 ]
  %t726 = phi double [ %t3, %entry ], [ %t724, %loop.latch2 ]
  store double %t725, double* %l0
  store double %t726, double* %l1
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
  call void @sailfin_runtime_bounds_check(i64 %t14, i64 %t17)
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
  %s95 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h486335986, i32 0, i32 0
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
  %s171 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1842783069, i32 0, i32 0
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
  %s247 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h579804543, i32 0, i32 0
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
  %s323 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h479148896, i32 0, i32 0
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
  %s399 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h571715647, i32 0, i32 0
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
  %s475 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h2043328844, i32 0, i32 0
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
  %s551 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h889179835, i32 0, i32 0
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
  %s627 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1496093543, i32 0, i32 0
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
  %s702 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h666604742, i32 0, i32 0
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
  %t718 = load double, double* %l0
  br label %merge7
merge7:
  %t719 = phi double [ %t718, %then6 ], [ %t712, %logical_or_merge_21 ]
  store double %t719, double* %l0
  %t720 = load double, double* %l1
  %t721 = sitofp i64 1 to double
  %t722 = fadd double %t720, %t721
  store double %t722, double* %l1
  br label %loop.latch2
loop.latch2:
  %t723 = load double, double* %l0
  %t724 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t727 = load double, double* %l0
  %t728 = load double, double* %l1
  %t729 = load double, double* %l0
  ret double %t729
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
  call void @sailfin_runtime_bounds_check(i64 %t9, i64 %t12)
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
  %t23 = load double, double* %l0
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
  %s3 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193442306, i32 0, i32 0
  %t4 = call i8* @sailfin_runtime_string_concat(i8* %s3, i8* %message)
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
  %t29 = phi { i8**, i64 }* [ %t5, %merge1 ], [ %t27, %loop.latch4 ]
  %t30 = phi double [ %t6, %merge1 ], [ %t28, %loop.latch4 ]
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
  call void @sailfin_runtime_bounds_check(i64 %t16, i64 %t19)
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
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load double, double* %l1
  %t33 = extractvalue %NativeState %state, 0
  %t34 = insertvalue %NativeState undef, %TextBuilder %t33, 0
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = insertvalue %NativeState %t34, { i8**, i64 }* %t35, 1
  %t37 = extractvalue %NativeState %state, 2
  %t38 = insertvalue %NativeState %t36, %LayoutContext %t37, 2
  ret %NativeState %t38
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
  %s2 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h403645876, i32 0, i32 0
  %t3 = call %TextBuilder @builder_emit_line(%TextBuilder %t1, i8* %s2)
  store %TextBuilder %t3, %TextBuilder* %l0
  %t4 = load %TextBuilder, %TextBuilder* %l0
  %s5 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h2048588885, i32 0, i32 0
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
  %t214 = phi %TextBuilder [ %t10, %entry ], [ %t212, %loop.latch2 ]
  %t215 = phi double [ %t11, %entry ], [ %t213, %loop.latch2 ]
  store %TextBuilder %t214, %TextBuilder* %l0
  store double %t215, double* %l1
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
  call void @sailfin_runtime_bounds_check(i64 %t22, i64 %t25)
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
  %s102 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1842783069, i32 0, i32 0
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
  call void @sailfin_runtime_bounds_check(i64 %t186, i64 %t189)
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
  %t202 = load double, double* %l4
  %t203 = load %TextBuilder, %TextBuilder* %l0
  %t204 = call %TextBuilder @builder_emit_blank(%TextBuilder %t203)
  store %TextBuilder %t204, %TextBuilder* %l0
  %t205 = load %TextBuilder, %TextBuilder* %l0
  %t206 = load %TextBuilder, %TextBuilder* %l0
  br label %merge7
merge7:
  %t207 = phi %TextBuilder [ %t205, %afterloop11 ], [ %t104, %merge5 ]
  %t208 = phi %TextBuilder [ %t206, %afterloop11 ], [ %t104, %merge5 ]
  store %TextBuilder %t207, %TextBuilder* %l0
  store %TextBuilder %t208, %TextBuilder* %l0
  %t209 = load double, double* %l1
  %t210 = sitofp i64 1 to double
  %t211 = fadd double %t209, %t210
  store double %t211, double* %l1
  br label %loop.latch2
loop.latch2:
  %t212 = load %TextBuilder, %TextBuilder* %l0
  %t213 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t216 = load %TextBuilder, %TextBuilder* %l0
  %t217 = load double, double* %l1
  %t218 = sitofp i64 0 to double
  store double %t218, double* %l1
  %t219 = load %TextBuilder, %TextBuilder* %l0
  %t220 = load double, double* %l1
  br label %loop.header14
loop.header14:
  %t369 = phi %TextBuilder [ %t219, %afterloop3 ], [ %t367, %loop.latch16 ]
  %t370 = phi double [ %t220, %afterloop3 ], [ %t368, %loop.latch16 ]
  store %TextBuilder %t369, %TextBuilder* %l0
  store double %t370, double* %l1
  br label %loop.body15
loop.body15:
  %t221 = load double, double* %l1
  %t222 = extractvalue %Program %program, 0
  %t223 = load { %Statement**, i64 }, { %Statement**, i64 }* %t222
  %t224 = extractvalue { %Statement**, i64 } %t223, 1
  %t225 = sitofp i64 %t224 to double
  %t226 = fcmp oge double %t221, %t225
  %t227 = load %TextBuilder, %TextBuilder* %l0
  %t228 = load double, double* %l1
  br i1 %t226, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t229 = extractvalue %Program %program, 0
  %t230 = load double, double* %l1
  %t231 = fptosi double %t230 to i64
  %t232 = load { %Statement**, i64 }, { %Statement**, i64 }* %t229
  %t233 = extractvalue { %Statement**, i64 } %t232, 0
  %t234 = extractvalue { %Statement**, i64 } %t232, 1
  %t235 = icmp uge i64 %t231, %t234
  ; bounds check: %t235 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t231, i64 %t234)
  %t236 = getelementptr %Statement*, %Statement** %t233, i64 %t231
  %t237 = load %Statement*, %Statement** %t236
  store %Statement* %t237, %Statement** %l5
  %t238 = load %Statement*, %Statement** %l5
  %t239 = getelementptr inbounds %Statement, %Statement* %t238, i32 0, i32 0
  %t240 = load i32, i32* %t239
  %t241 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t242 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t243 = icmp eq i32 %t240, 0
  %t244 = select i1 %t243, i8* %t242, i8* %t241
  %t245 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t246 = icmp eq i32 %t240, 1
  %t247 = select i1 %t246, i8* %t245, i8* %t244
  %t248 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t249 = icmp eq i32 %t240, 2
  %t250 = select i1 %t249, i8* %t248, i8* %t247
  %t251 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t252 = icmp eq i32 %t240, 3
  %t253 = select i1 %t252, i8* %t251, i8* %t250
  %t254 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t255 = icmp eq i32 %t240, 4
  %t256 = select i1 %t255, i8* %t254, i8* %t253
  %t257 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t258 = icmp eq i32 %t240, 5
  %t259 = select i1 %t258, i8* %t257, i8* %t256
  %t260 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t261 = icmp eq i32 %t240, 6
  %t262 = select i1 %t261, i8* %t260, i8* %t259
  %t263 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t264 = icmp eq i32 %t240, 7
  %t265 = select i1 %t264, i8* %t263, i8* %t262
  %t266 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t267 = icmp eq i32 %t240, 8
  %t268 = select i1 %t267, i8* %t266, i8* %t265
  %t269 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t270 = icmp eq i32 %t240, 9
  %t271 = select i1 %t270, i8* %t269, i8* %t268
  %t272 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t273 = icmp eq i32 %t240, 10
  %t274 = select i1 %t273, i8* %t272, i8* %t271
  %t275 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t276 = icmp eq i32 %t240, 11
  %t277 = select i1 %t276, i8* %t275, i8* %t274
  %t278 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t279 = icmp eq i32 %t240, 12
  %t280 = select i1 %t279, i8* %t278, i8* %t277
  %t281 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t282 = icmp eq i32 %t240, 13
  %t283 = select i1 %t282, i8* %t281, i8* %t280
  %t284 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t285 = icmp eq i32 %t240, 14
  %t286 = select i1 %t285, i8* %t284, i8* %t283
  %t287 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t288 = icmp eq i32 %t240, 15
  %t289 = select i1 %t288, i8* %t287, i8* %t286
  %t290 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t291 = icmp eq i32 %t240, 16
  %t292 = select i1 %t291, i8* %t290, i8* %t289
  %t293 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t294 = icmp eq i32 %t240, 17
  %t295 = select i1 %t294, i8* %t293, i8* %t292
  %t296 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t297 = icmp eq i32 %t240, 18
  %t298 = select i1 %t297, i8* %t296, i8* %t295
  %t299 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t300 = icmp eq i32 %t240, 19
  %t301 = select i1 %t300, i8* %t299, i8* %t298
  %t302 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t303 = icmp eq i32 %t240, 20
  %t304 = select i1 %t303, i8* %t302, i8* %t301
  %t305 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t306 = icmp eq i32 %t240, 21
  %t307 = select i1 %t306, i8* %t305, i8* %t304
  %t308 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t309 = icmp eq i32 %t240, 22
  %t310 = select i1 %t309, i8* %t308, i8* %t307
  %s311 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h579804543, i32 0, i32 0
  %t312 = icmp eq i8* %t310, %s311
  %t313 = load %TextBuilder, %TextBuilder* %l0
  %t314 = load double, double* %l1
  %t315 = load %Statement*, %Statement** %l5
  br i1 %t312, label %then20, label %merge21
then20:
  %t316 = load %Statement*, %Statement** %l5
  %t317 = load %Statement, %Statement* %t316
  %t318 = call %LayoutEmitResult @compute_enum_layout_lines(%LayoutContext %context, %Statement %t317)
  store %LayoutEmitResult %t318, %LayoutEmitResult* %l6
  %t319 = sitofp i64 0 to double
  store double %t319, double* %l7
  %t320 = load %TextBuilder, %TextBuilder* %l0
  %t321 = load double, double* %l1
  %t322 = load %Statement*, %Statement** %l5
  %t323 = load %LayoutEmitResult, %LayoutEmitResult* %l6
  %t324 = load double, double* %l7
  br label %loop.header22
loop.header22:
  %t354 = phi %TextBuilder [ %t320, %then20 ], [ %t352, %loop.latch24 ]
  %t355 = phi double [ %t324, %then20 ], [ %t353, %loop.latch24 ]
  store %TextBuilder %t354, %TextBuilder* %l0
  store double %t355, double* %l7
  br label %loop.body23
loop.body23:
  %t325 = load double, double* %l7
  %t326 = load %LayoutEmitResult, %LayoutEmitResult* %l6
  %t327 = extractvalue %LayoutEmitResult %t326, 0
  %t328 = load { i8**, i64 }, { i8**, i64 }* %t327
  %t329 = extractvalue { i8**, i64 } %t328, 1
  %t330 = sitofp i64 %t329 to double
  %t331 = fcmp oge double %t325, %t330
  %t332 = load %TextBuilder, %TextBuilder* %l0
  %t333 = load double, double* %l1
  %t334 = load %Statement*, %Statement** %l5
  %t335 = load %LayoutEmitResult, %LayoutEmitResult* %l6
  %t336 = load double, double* %l7
  br i1 %t331, label %then26, label %merge27
then26:
  br label %afterloop25
merge27:
  %t337 = load %TextBuilder, %TextBuilder* %l0
  %t338 = load %LayoutEmitResult, %LayoutEmitResult* %l6
  %t339 = extractvalue %LayoutEmitResult %t338, 0
  %t340 = load double, double* %l7
  %t341 = fptosi double %t340 to i64
  %t342 = load { i8**, i64 }, { i8**, i64 }* %t339
  %t343 = extractvalue { i8**, i64 } %t342, 0
  %t344 = extractvalue { i8**, i64 } %t342, 1
  %t345 = icmp uge i64 %t341, %t344
  ; bounds check: %t345 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t341, i64 %t344)
  %t346 = getelementptr i8*, i8** %t343, i64 %t341
  %t347 = load i8*, i8** %t346
  %t348 = call %TextBuilder @builder_emit_line(%TextBuilder %t337, i8* %t347)
  store %TextBuilder %t348, %TextBuilder* %l0
  %t349 = load double, double* %l7
  %t350 = sitofp i64 1 to double
  %t351 = fadd double %t349, %t350
  store double %t351, double* %l7
  br label %loop.latch24
loop.latch24:
  %t352 = load %TextBuilder, %TextBuilder* %l0
  %t353 = load double, double* %l7
  br label %loop.header22
afterloop25:
  %t356 = load %TextBuilder, %TextBuilder* %l0
  %t357 = load double, double* %l7
  %t358 = load %TextBuilder, %TextBuilder* %l0
  %t359 = call %TextBuilder @builder_emit_blank(%TextBuilder %t358)
  store %TextBuilder %t359, %TextBuilder* %l0
  %t360 = load %TextBuilder, %TextBuilder* %l0
  %t361 = load %TextBuilder, %TextBuilder* %l0
  br label %merge21
merge21:
  %t362 = phi %TextBuilder [ %t360, %afterloop25 ], [ %t313, %merge19 ]
  %t363 = phi %TextBuilder [ %t361, %afterloop25 ], [ %t313, %merge19 ]
  store %TextBuilder %t362, %TextBuilder* %l0
  store %TextBuilder %t363, %TextBuilder* %l0
  %t364 = load double, double* %l1
  %t365 = sitofp i64 1 to double
  %t366 = fadd double %t364, %t365
  store double %t366, double* %l1
  br label %loop.latch16
loop.latch16:
  %t367 = load %TextBuilder, %TextBuilder* %l0
  %t368 = load double, double* %l1
  br label %loop.header14
afterloop17:
  %t371 = load %TextBuilder, %TextBuilder* %l0
  %t372 = load double, double* %l1
  %s373 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h401021290, i32 0, i32 0
  %t374 = insertvalue %NativeArtifact undef, i8* %s373, 0
  %s375 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.len23.h668778749, i32 0, i32 0
  %t376 = insertvalue %NativeArtifact %t374, i8* %s375, 1
  %t377 = load %TextBuilder, %TextBuilder* %l0
  %t378 = call i8* @builder_to_string(%TextBuilder %t377)
  %t379 = insertvalue %NativeArtifact %t376, i8* %t378, 2
  ret %NativeArtifact %t379
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
  %t28 = phi %NativeState [ %t4, %merge1 ], [ %t26, %loop.latch4 ]
  %t29 = phi double [ %t5, %merge1 ], [ %t27, %loop.latch4 ]
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
  call void @sailfin_runtime_bounds_check(i64 %t15, i64 %t18)
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
  %t31 = load double, double* %l1
  %t32 = load %NativeState, %NativeState* %l0
  ret %NativeState %t32
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
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
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
  %s10 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h173287691, i32 0, i32 0
  %t11 = call i8* @sailfin_runtime_string_concat(i8* %t9, i8* %s10)
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
  %t20 = load double, double* %l1
  %t21 = load i8*, i8** %l0
  %t22 = call i8* @trim_right(i8* %line)
  %t23 = call i8* @sailfin_runtime_string_concat(i8* %t21, i8* %t22)
  store i8* %t23, i8** %l2
  %t24 = extractvalue %TextBuilder %builder, 0
  %t25 = load i8*, i8** %l2
  %t26 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t24, i8* %t25)
  store { i8**, i64 }* %t26, { i8**, i64 }** %l3
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t28 = insertvalue %TextBuilder undef, { i8**, i64 }* %t27, 0
  %t29 = extractvalue %TextBuilder %builder, 1
  %t30 = insertvalue %TextBuilder %t28, double %t29, 1
  ret %TextBuilder %t30
}

define %TextBuilder @builder_emit_blank(%TextBuilder %builder) {
entry:
  %l0 = alloca { i8**, i64 }*
  %t0 = extractvalue %TextBuilder %builder, 0
  %s1 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
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
  %t8 = load double, double* %l0
  br label %merge1
merge1:
  %t9 = phi double [ %t8, %then0 ], [ %t4, %entry ]
  store double %t9, double* %l0
  %t10 = extractvalue %TextBuilder %builder, 0
  %t11 = insertvalue %TextBuilder undef, { i8**, i64 }* %t10, 0
  %t12 = load double, double* %l0
  %t13 = insertvalue %TextBuilder %t11, double %t12, 1
  ret %TextBuilder %t13
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
  %t27 = load double, double* %l0
  %t28 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t29 = sitofp i64 %t28 to double
  %t30 = fcmp oeq double %t27, %t29
  %t31 = load double, double* %l0
  br i1 %t30, label %then8, label %merge9
then8:
  ret i8* %value
merge9:
  %t32 = load double, double* %l0
  %t33 = fptosi double %t32 to i64
  %t34 = call i8* @sailfin_runtime_substring(i8* %value, i64 0, i64 %t33)
  ret i8* %t34
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

define i8* @join_type_annotations({ %TypeAnnotation*, i64 }* %values) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = load { %TypeAnnotation*, i64 }, { %TypeAnnotation*, i64 }* %values
  %t1 = extractvalue { %TypeAnnotation*, i64 } %t0, 1
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
  %t35 = phi { i8**, i64 }* [ %t10, %merge1 ], [ %t33, %loop.latch4 ]
  %t36 = phi double [ %t11, %merge1 ], [ %t34, %loop.latch4 ]
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
  call void @sailfin_runtime_bounds_check(i64 %t21, i64 %t24)
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
  %t38 = load double, double* %l1
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s40 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t41 = call i8* @join_with_separator({ i8**, i64 }* %t39, i8* %s40)
  ret i8* %t41
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
