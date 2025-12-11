; ModuleID = 'sailfin'
source_filename = "sailfin"

%Token = type opaque
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

%Expression = type { i32, [40 x i8] }
%Statement = type { i32, [136 x i8] }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare i1 @strings_equal(i8*, i8*)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)

declare i8* @char_at(i8*, double)
declare i1 @is_symbol_char(i8*)
declare i8* @sanitize_symbol(i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

@.str.len26.h177352073 = private unnamed_addr constant [27 x i8] c"; Sailfin Native Prototype\00"
@.str.len12.h76426699 = private unnamed_addr constant [13 x i8] c".module main\00"
@.str.len14.h330693139 = private unnamed_addr constant [15 x i8] c"module.sfn-asm\00"
@.str.len19.h1782433603 = private unnamed_addr constant [20 x i8] c"sailfin-native-text\00"
@.str.len39.h1281499904 = private unnamed_addr constant [40 x i8] c"native backend: unsupported statement `\00"
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
@.str.len2.h193425971 = private unnamed_addr constant [3 x i8] c", \00"
@.str.len4.h175713983 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.len6.h1830497006 = private unnamed_addr constant [7 x i8] c".span \00"
@.str.len11.h1513373193 = private unnamed_addr constant [12 x i8] c".init-span \00"
@.str.len3.h2087687812 = private unnamed_addr constant [4 x i8] c" : \00"
@.str.len3.h2087691079 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.len5.h2064124065 = private unnamed_addr constant [6 x i8] c".let \00"
@.str.len4.h192491117 = private unnamed_addr constant [5 x i8] c".fn \00"
@.str.len6.h1280331335 = private unnamed_addr constant [7 x i8] c".endfn\00"
@.str.len10.h730819012 = private unnamed_addr constant [11 x i8] c".pipeline \00"
@.str.len12.h1355144398 = private unnamed_addr constant [13 x i8] c".endpipeline\00"
@.str.len6.h1868947418 = private unnamed_addr constant [7 x i8] c".tool \00"
@.str.len8.h580693660 = private unnamed_addr constant [9 x i8] c".endtool\00"
@.str.len6.h1857240668 = private unnamed_addr constant [7 x i8] c".test \00"
@.str.len8.h580338910 = private unnamed_addr constant [9 x i8] c".endtest\00"
@.str.len7.h1082168422 = private unnamed_addr constant [8 x i8] c".model \00"
@.str.len9.h1708674232 = private unnamed_addr constant [10 x i8] c".endmodel\00"
@.str.len6.h1880834942 = private unnamed_addr constant [7 x i8] c".type \00"
@.str.len11.h599952843 = private unnamed_addr constant [12 x i8] c".interface \00"
@.str.len13.h1382830532 = private unnamed_addr constant [14 x i8] c".endinterface\00"
@.str.len6.h1280947313 = private unnamed_addr constant [7 x i8] c".enum \00"
@.str.len8.h562875475 = private unnamed_addr constant [9 x i8] c".endenum\00"
@.str.len8.h2093451461 = private unnamed_addr constant [9 x i8] c".struct \00"
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
@.str.len4.h174362534 = private unnamed_addr constant [5 x i8] c" => \00"
@.str.len4.h175987322 = private unnamed_addr constant [5 x i8] c" if \00"
@.str.len0.h177573 = private unnamed_addr constant [1 x i8] c"\00"
@.str.len4.h192590216 = private unnamed_addr constant [5 x i8] c".if \00"
@.str.len6.h1280334338 = private unnamed_addr constant [7 x i8] c".endif\00"
@.str.len5.h2056075365 = private unnamed_addr constant [6 x i8] c".else\00"
@.str.len4.h273104342 = private unnamed_addr constant [5 x i8] c"ret \00"
@.str.len5.h2080793783 = private unnamed_addr constant [6 x i8] c"eval \00"
@.str.len4.h173787542 = private unnamed_addr constant [5 x i8] c" -> \00"
@.str.len3.h2087758597 = private unnamed_addr constant [4 x i8] c" { \00"
@.str.len2.h193442306 = private unnamed_addr constant [3 x i8] c"; \00"
@.str.len2.h193415972 = private unnamed_addr constant [3 x i8] c" }\00"
@.str.len6.h789690461 = private unnamed_addr constant [7 x i8] c"struct\00"
@.str.len20.h239636501 = private unnamed_addr constant [21 x i8] c".layout struct name=\00"
@.str.len6.h922402750 = private unnamed_addr constant [7 x i8] c" size=\00"
@.str.len7.h847788946 = private unnamed_addr constant [8 x i8] c" align=\00"
@.str.len18.h548024877 = private unnamed_addr constant [19 x i8] c".layout enum name=\00"
@.str.len23.h1863896425 = private unnamed_addr constant [24 x i8] c" tag_type=i32 tag_size=\00"
@.str.len11.h1741471221 = private unnamed_addr constant [12 x i8] c" tag_align=\00"
@.str.len15.h1833630044 = private unnamed_addr constant [16 x i8] c"native layout: \00"
@.str.len2.h193415015 = private unnamed_addr constant [3 x i8] c" `\00"
@.str.len9.h1449250559 = private unnamed_addr constant [10 x i8] c"` field `\00"
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
@.str.len19.h479148896 = private unnamed_addr constant [20 x i8] c"PipelineDeclaration\00"
@.str.len15.h571715647 = private unnamed_addr constant [16 x i8] c"ToolDeclaration\00"
@.str.len15.h889179835 = private unnamed_addr constant [16 x i8] c"TestDeclaration\00"
@.str.len16.h2043328844 = private unnamed_addr constant [17 x i8] c"ModelDeclaration\00"
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
@.str.len10.h1720834339 = private unnamed_addr constant [11 x i8] c"[#element:\00"
@.str.len25.h403645876 = private unnamed_addr constant [26 x i8] c"; Sailfin Layout Manifest\00"
@.str.len19.h2048588885 = private unnamed_addr constant [20 x i8] c".manifest version=1\00"
@.str.len22.h401021290 = private unnamed_addr constant [23 x i8] c"module.layout-manifest\00"
@.str.len23.h668778749 = private unnamed_addr constant [24 x i8] c"sailfin-layout-manifest\00"

declare void @sailfin_runtime_mark_persistent(i8*)

define %LayoutContext @build_layout_context(%Program %program) {
block.entry:
  %l0 = alloca { %LayoutStructDefinition*, i64 }*
  %l1 = alloca { %LayoutEnumDefinition*, i64 }*
  %l2 = alloca double
  %l3 = alloca %Statement*
  %l4 = alloca { %LayoutFieldInput*, i64 }*
  %l5 = alloca { %LayoutEnumVariantDefinition*, i64 }*
  %l6 = alloca double
  %l7 = alloca %EnumVariant*
  %l8 = alloca { %LayoutFieldInput*, i64 }*
  %t0 = getelementptr [0 x %LayoutStructDefinition], [0 x %LayoutStructDefinition]* null, i32 1
  %t1 = ptrtoint [0 x %LayoutStructDefinition]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %LayoutStructDefinition*
  %t6 = getelementptr { %LayoutStructDefinition*, i64 }, { %LayoutStructDefinition*, i64 }* null, i32 1
  %t7 = ptrtoint { %LayoutStructDefinition*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %LayoutStructDefinition*, i64 }*
  %t10 = getelementptr { %LayoutStructDefinition*, i64 }, { %LayoutStructDefinition*, i64 }* %t9, i32 0, i32 0
  store %LayoutStructDefinition* %t5, %LayoutStructDefinition** %t10
  %t11 = getelementptr { %LayoutStructDefinition*, i64 }, { %LayoutStructDefinition*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %LayoutStructDefinition*, i64 }* %t9, { %LayoutStructDefinition*, i64 }** %l0
  %t12 = getelementptr [0 x %LayoutEnumDefinition], [0 x %LayoutEnumDefinition]* null, i32 1
  %t13 = ptrtoint [0 x %LayoutEnumDefinition]* %t12 to i64
  %t14 = icmp eq i64 %t13, 0
  %t15 = select i1 %t14, i64 1, i64 %t13
  %t16 = call i8* @malloc(i64 %t15)
  %t17 = bitcast i8* %t16 to %LayoutEnumDefinition*
  %t18 = getelementptr { %LayoutEnumDefinition*, i64 }, { %LayoutEnumDefinition*, i64 }* null, i32 1
  %t19 = ptrtoint { %LayoutEnumDefinition*, i64 }* %t18 to i64
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to { %LayoutEnumDefinition*, i64 }*
  %t22 = getelementptr { %LayoutEnumDefinition*, i64 }, { %LayoutEnumDefinition*, i64 }* %t21, i32 0, i32 0
  store %LayoutEnumDefinition* %t17, %LayoutEnumDefinition** %t22
  %t23 = getelementptr { %LayoutEnumDefinition*, i64 }, { %LayoutEnumDefinition*, i64 }* %t21, i32 0, i32 1
  store i64 0, i64* %t23
  store { %LayoutEnumDefinition*, i64 }* %t21, { %LayoutEnumDefinition*, i64 }** %l1
  %t24 = sitofp i64 0 to double
  store double %t24, double* %l2
  %t25 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t26 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t27 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t409 = phi { %LayoutStructDefinition*, i64 }* [ %t25, %block.entry ], [ %t406, %loop.latch2 ]
  %t410 = phi { %LayoutEnumDefinition*, i64 }* [ %t26, %block.entry ], [ %t407, %loop.latch2 ]
  %t411 = phi double [ %t27, %block.entry ], [ %t408, %loop.latch2 ]
  store { %LayoutStructDefinition*, i64 }* %t409, { %LayoutStructDefinition*, i64 }** %l0
  store { %LayoutEnumDefinition*, i64 }* %t410, { %LayoutEnumDefinition*, i64 }** %l1
  store double %t411, double* %l2
  br label %loop.body1
loop.body1:
  %t28 = load double, double* %l2
  %t29 = extractvalue %Program %program, 0
  %t30 = load { %Statement**, i64 }, { %Statement**, i64 }* %t29
  %t31 = extractvalue { %Statement**, i64 } %t30, 1
  %t32 = sitofp i64 %t31 to double
  %t33 = fcmp oge double %t28, %t32
  %t34 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t35 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t36 = load double, double* %l2
  br i1 %t33, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t37 = extractvalue %Program %program, 0
  %t38 = load double, double* %l2
  %t39 = call double @llvm.round.f64(double %t38)
  %t40 = fptosi double %t39 to i64
  %t41 = load { %Statement**, i64 }, { %Statement**, i64 }* %t37
  %t42 = extractvalue { %Statement**, i64 } %t41, 0
  %t43 = extractvalue { %Statement**, i64 } %t41, 1
  %t44 = icmp uge i64 %t40, %t43
  ; bounds check: %t44 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t40, i64 %t43)
  %t45 = getelementptr %Statement*, %Statement** %t42, i64 %t40
  %t46 = load %Statement*, %Statement** %t45
  store %Statement* %t46, %Statement** %l3
  %t47 = load %Statement*, %Statement** %l3
  %t48 = getelementptr inbounds %Statement, %Statement* %t47, i32 0, i32 0
  %t49 = load i32, i32* %t48
  %t50 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t51 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t52 = icmp eq i32 %t49, 0
  %t53 = select i1 %t52, i8* %t51, i8* %t50
  %t54 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t55 = icmp eq i32 %t49, 1
  %t56 = select i1 %t55, i8* %t54, i8* %t53
  %t57 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t58 = icmp eq i32 %t49, 2
  %t59 = select i1 %t58, i8* %t57, i8* %t56
  %t60 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t61 = icmp eq i32 %t49, 3
  %t62 = select i1 %t61, i8* %t60, i8* %t59
  %t63 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t49, 4
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t49, 5
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t49, 6
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t49, 7
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t49, 8
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t49, 9
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %t81 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t49, 10
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t49, 11
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %t87 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t88 = icmp eq i32 %t49, 12
  %t89 = select i1 %t88, i8* %t87, i8* %t86
  %t90 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t91 = icmp eq i32 %t49, 13
  %t92 = select i1 %t91, i8* %t90, i8* %t89
  %t93 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t49, 14
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %t96 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t97 = icmp eq i32 %t49, 15
  %t98 = select i1 %t97, i8* %t96, i8* %t95
  %t99 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t49, 16
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t49, 17
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t106 = icmp eq i32 %t49, 18
  %t107 = select i1 %t106, i8* %t105, i8* %t104
  %t108 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t49, 19
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t112 = icmp eq i32 %t49, 20
  %t113 = select i1 %t112, i8* %t111, i8* %t110
  %t114 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t49, 21
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %t117 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t118 = icmp eq i32 %t49, 22
  %t119 = select i1 %t118, i8* %t117, i8* %t116
  %s120 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1842783069, i32 0, i32 0
  %t121 = call i1 @strings_equal(i8* %t119, i8* %s120)
  %t122 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t123 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t124 = load double, double* %l2
  %t125 = load %Statement*, %Statement** %l3
  br i1 %t121, label %then6, label %merge7
then6:
  %t126 = load %Statement*, %Statement** %l3
  %t127 = getelementptr inbounds %Statement, %Statement* %t126, i32 0, i32 0
  %t128 = load i32, i32* %t127
  %t129 = getelementptr inbounds %Statement, %Statement* %t126, i32 0, i32 1
  %t130 = bitcast [56 x i8]* %t129 to i8*
  %t131 = getelementptr inbounds i8, i8* %t130, i64 32
  %t132 = bitcast i8* %t131 to { %FieldDeclaration**, i64 }**
  %t133 = load { %FieldDeclaration**, i64 }*, { %FieldDeclaration**, i64 }** %t132
  %t134 = icmp eq i32 %t128, 8
  %t135 = select i1 %t134, { %FieldDeclaration**, i64 }* %t133, { %FieldDeclaration**, i64 }* null
  %t136 = bitcast { %FieldDeclaration**, i64 }* %t135 to { %FieldDeclaration*, i64 }*
  %t137 = call { %LayoutFieldInput*, i64 }* @convert_struct_fields({ %FieldDeclaration*, i64 }* %t136)
  store { %LayoutFieldInput*, i64 }* %t137, { %LayoutFieldInput*, i64 }** %l4
  %t138 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t139 = load %Statement*, %Statement** %l3
  %t140 = getelementptr inbounds %Statement, %Statement* %t139, i32 0, i32 0
  %t141 = load i32, i32* %t140
  %t142 = getelementptr inbounds %Statement, %Statement* %t139, i32 0, i32 1
  %t143 = bitcast [48 x i8]* %t142 to i8*
  %t144 = bitcast i8* %t143 to i8**
  %t145 = load i8*, i8** %t144
  %t146 = icmp eq i32 %t141, 2
  %t147 = select i1 %t146, i8* %t145, i8* null
  %t148 = getelementptr inbounds %Statement, %Statement* %t139, i32 0, i32 1
  %t149 = bitcast [48 x i8]* %t148 to i8*
  %t150 = bitcast i8* %t149 to i8**
  %t151 = load i8*, i8** %t150
  %t152 = icmp eq i32 %t141, 3
  %t153 = select i1 %t152, i8* %t151, i8* %t147
  %t154 = getelementptr inbounds %Statement, %Statement* %t139, i32 0, i32 1
  %t155 = bitcast [56 x i8]* %t154 to i8*
  %t156 = bitcast i8* %t155 to i8**
  %t157 = load i8*, i8** %t156
  %t158 = icmp eq i32 %t141, 6
  %t159 = select i1 %t158, i8* %t157, i8* %t153
  %t160 = getelementptr inbounds %Statement, %Statement* %t139, i32 0, i32 1
  %t161 = bitcast [56 x i8]* %t160 to i8*
  %t162 = bitcast i8* %t161 to i8**
  %t163 = load i8*, i8** %t162
  %t164 = icmp eq i32 %t141, 8
  %t165 = select i1 %t164, i8* %t163, i8* %t159
  %t166 = getelementptr inbounds %Statement, %Statement* %t139, i32 0, i32 1
  %t167 = bitcast [40 x i8]* %t166 to i8*
  %t168 = bitcast i8* %t167 to i8**
  %t169 = load i8*, i8** %t168
  %t170 = icmp eq i32 %t141, 9
  %t171 = select i1 %t170, i8* %t169, i8* %t165
  %t172 = getelementptr inbounds %Statement, %Statement* %t139, i32 0, i32 1
  %t173 = bitcast [40 x i8]* %t172 to i8*
  %t174 = bitcast i8* %t173 to i8**
  %t175 = load i8*, i8** %t174
  %t176 = icmp eq i32 %t141, 10
  %t177 = select i1 %t176, i8* %t175, i8* %t171
  %t178 = getelementptr inbounds %Statement, %Statement* %t139, i32 0, i32 1
  %t179 = bitcast [40 x i8]* %t178 to i8*
  %t180 = bitcast i8* %t179 to i8**
  %t181 = load i8*, i8** %t180
  %t182 = icmp eq i32 %t141, 11
  %t183 = select i1 %t182, i8* %t181, i8* %t177
  %t184 = insertvalue %LayoutStructDefinition undef, i8* %t183, 0
  %t185 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l4
  %t186 = bitcast { %LayoutFieldInput*, i64 }* %t185 to { %LayoutFieldInput**, i64 }*
  %t187 = insertvalue %LayoutStructDefinition %t184, { %LayoutFieldInput**, i64 }* %t186, 1
  %t188 = call { %LayoutStructDefinition*, i64 }* @append_layout_struct_definition({ %LayoutStructDefinition*, i64 }* %t138, %LayoutStructDefinition %t187)
  store { %LayoutStructDefinition*, i64 }* %t188, { %LayoutStructDefinition*, i64 }** %l0
  %t189 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  br label %merge7
merge7:
  %t190 = phi { %LayoutStructDefinition*, i64 }* [ %t189, %then6 ], [ %t122, %merge5 ]
  store { %LayoutStructDefinition*, i64 }* %t190, { %LayoutStructDefinition*, i64 }** %l0
  %t191 = load %Statement*, %Statement** %l3
  %t192 = getelementptr inbounds %Statement, %Statement* %t191, i32 0, i32 0
  %t193 = load i32, i32* %t192
  %t194 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t195 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t196 = icmp eq i32 %t193, 0
  %t197 = select i1 %t196, i8* %t195, i8* %t194
  %t198 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t199 = icmp eq i32 %t193, 1
  %t200 = select i1 %t199, i8* %t198, i8* %t197
  %t201 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t202 = icmp eq i32 %t193, 2
  %t203 = select i1 %t202, i8* %t201, i8* %t200
  %t204 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t205 = icmp eq i32 %t193, 3
  %t206 = select i1 %t205, i8* %t204, i8* %t203
  %t207 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t208 = icmp eq i32 %t193, 4
  %t209 = select i1 %t208, i8* %t207, i8* %t206
  %t210 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t211 = icmp eq i32 %t193, 5
  %t212 = select i1 %t211, i8* %t210, i8* %t209
  %t213 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t214 = icmp eq i32 %t193, 6
  %t215 = select i1 %t214, i8* %t213, i8* %t212
  %t216 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t217 = icmp eq i32 %t193, 7
  %t218 = select i1 %t217, i8* %t216, i8* %t215
  %t219 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t220 = icmp eq i32 %t193, 8
  %t221 = select i1 %t220, i8* %t219, i8* %t218
  %t222 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t223 = icmp eq i32 %t193, 9
  %t224 = select i1 %t223, i8* %t222, i8* %t221
  %t225 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t226 = icmp eq i32 %t193, 10
  %t227 = select i1 %t226, i8* %t225, i8* %t224
  %t228 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t229 = icmp eq i32 %t193, 11
  %t230 = select i1 %t229, i8* %t228, i8* %t227
  %t231 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t232 = icmp eq i32 %t193, 12
  %t233 = select i1 %t232, i8* %t231, i8* %t230
  %t234 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t235 = icmp eq i32 %t193, 13
  %t236 = select i1 %t235, i8* %t234, i8* %t233
  %t237 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t238 = icmp eq i32 %t193, 14
  %t239 = select i1 %t238, i8* %t237, i8* %t236
  %t240 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t241 = icmp eq i32 %t193, 15
  %t242 = select i1 %t241, i8* %t240, i8* %t239
  %t243 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t244 = icmp eq i32 %t193, 16
  %t245 = select i1 %t244, i8* %t243, i8* %t242
  %t246 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t247 = icmp eq i32 %t193, 17
  %t248 = select i1 %t247, i8* %t246, i8* %t245
  %t249 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t250 = icmp eq i32 %t193, 18
  %t251 = select i1 %t250, i8* %t249, i8* %t248
  %t252 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t253 = icmp eq i32 %t193, 19
  %t254 = select i1 %t253, i8* %t252, i8* %t251
  %t255 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t256 = icmp eq i32 %t193, 20
  %t257 = select i1 %t256, i8* %t255, i8* %t254
  %t258 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t259 = icmp eq i32 %t193, 21
  %t260 = select i1 %t259, i8* %t258, i8* %t257
  %t261 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t262 = icmp eq i32 %t193, 22
  %t263 = select i1 %t262, i8* %t261, i8* %t260
  %s264 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h579804543, i32 0, i32 0
  %t265 = call i1 @strings_equal(i8* %t263, i8* %s264)
  %t266 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t267 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t268 = load double, double* %l2
  %t269 = load %Statement*, %Statement** %l3
  br i1 %t265, label %then8, label %merge9
then8:
  %t270 = getelementptr [0 x %LayoutEnumVariantDefinition], [0 x %LayoutEnumVariantDefinition]* null, i32 1
  %t271 = ptrtoint [0 x %LayoutEnumVariantDefinition]* %t270 to i64
  %t272 = icmp eq i64 %t271, 0
  %t273 = select i1 %t272, i64 1, i64 %t271
  %t274 = call i8* @malloc(i64 %t273)
  %t275 = bitcast i8* %t274 to %LayoutEnumVariantDefinition*
  %t276 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* null, i32 1
  %t277 = ptrtoint { %LayoutEnumVariantDefinition*, i64 }* %t276 to i64
  %t278 = call i8* @malloc(i64 %t277)
  %t279 = bitcast i8* %t278 to { %LayoutEnumVariantDefinition*, i64 }*
  %t280 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %t279, i32 0, i32 0
  store %LayoutEnumVariantDefinition* %t275, %LayoutEnumVariantDefinition** %t280
  %t281 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %t279, i32 0, i32 1
  store i64 0, i64* %t281
  store { %LayoutEnumVariantDefinition*, i64 }* %t279, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t282 = sitofp i64 0 to double
  store double %t282, double* %l6
  %t283 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t284 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t285 = load double, double* %l2
  %t286 = load %Statement*, %Statement** %l3
  %t287 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t288 = load double, double* %l6
  br label %loop.header10
loop.header10:
  %t346 = phi { %LayoutEnumVariantDefinition*, i64 }* [ %t287, %then8 ], [ %t344, %loop.latch12 ]
  %t347 = phi double [ %t288, %then8 ], [ %t345, %loop.latch12 ]
  store { %LayoutEnumVariantDefinition*, i64 }* %t346, { %LayoutEnumVariantDefinition*, i64 }** %l5
  store double %t347, double* %l6
  br label %loop.body11
loop.body11:
  %t289 = load double, double* %l6
  %t290 = load %Statement*, %Statement** %l3
  %t291 = getelementptr inbounds %Statement, %Statement* %t290, i32 0, i32 0
  %t292 = load i32, i32* %t291
  %t293 = getelementptr inbounds %Statement, %Statement* %t290, i32 0, i32 1
  %t294 = bitcast [40 x i8]* %t293 to i8*
  %t295 = getelementptr inbounds i8, i8* %t294, i64 24
  %t296 = bitcast i8* %t295 to { %EnumVariant**, i64 }**
  %t297 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t296
  %t298 = icmp eq i32 %t292, 11
  %t299 = select i1 %t298, { %EnumVariant**, i64 }* %t297, { %EnumVariant**, i64 }* null
  %t300 = load { %EnumVariant**, i64 }, { %EnumVariant**, i64 }* %t299
  %t301 = extractvalue { %EnumVariant**, i64 } %t300, 1
  %t302 = sitofp i64 %t301 to double
  %t303 = fcmp oge double %t289, %t302
  %t304 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t305 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t306 = load double, double* %l2
  %t307 = load %Statement*, %Statement** %l3
  %t308 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t309 = load double, double* %l6
  br i1 %t303, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t310 = load %Statement*, %Statement** %l3
  %t311 = getelementptr inbounds %Statement, %Statement* %t310, i32 0, i32 0
  %t312 = load i32, i32* %t311
  %t313 = getelementptr inbounds %Statement, %Statement* %t310, i32 0, i32 1
  %t314 = bitcast [40 x i8]* %t313 to i8*
  %t315 = getelementptr inbounds i8, i8* %t314, i64 24
  %t316 = bitcast i8* %t315 to { %EnumVariant**, i64 }**
  %t317 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t316
  %t318 = icmp eq i32 %t312, 11
  %t319 = select i1 %t318, { %EnumVariant**, i64 }* %t317, { %EnumVariant**, i64 }* null
  %t320 = load double, double* %l6
  %t321 = call double @llvm.round.f64(double %t320)
  %t322 = fptosi double %t321 to i64
  %t323 = load { %EnumVariant**, i64 }, { %EnumVariant**, i64 }* %t319
  %t324 = extractvalue { %EnumVariant**, i64 } %t323, 0
  %t325 = extractvalue { %EnumVariant**, i64 } %t323, 1
  %t326 = icmp uge i64 %t322, %t325
  ; bounds check: %t326 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t322, i64 %t325)
  %t327 = getelementptr %EnumVariant*, %EnumVariant** %t324, i64 %t322
  %t328 = load %EnumVariant*, %EnumVariant** %t327
  store %EnumVariant* %t328, %EnumVariant** %l7
  %t329 = load %EnumVariant*, %EnumVariant** %l7
  %t330 = load %EnumVariant, %EnumVariant* %t329
  %t331 = call { %LayoutFieldInput*, i64 }* @convert_variant_fields(%EnumVariant %t330)
  store { %LayoutFieldInput*, i64 }* %t331, { %LayoutFieldInput*, i64 }** %l8
  %t332 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t333 = load %EnumVariant*, %EnumVariant** %l7
  %t334 = getelementptr %EnumVariant, %EnumVariant* %t333, i32 0, i32 0
  %t335 = load i8*, i8** %t334
  %t336 = insertvalue %LayoutEnumVariantDefinition undef, i8* %t335, 0
  %t337 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l8
  %t338 = bitcast { %LayoutFieldInput*, i64 }* %t337 to { %LayoutFieldInput**, i64 }*
  %t339 = insertvalue %LayoutEnumVariantDefinition %t336, { %LayoutFieldInput**, i64 }* %t338, 1
  %t340 = call { %LayoutEnumVariantDefinition*, i64 }* @append_layout_enum_variant_definition({ %LayoutEnumVariantDefinition*, i64 }* %t332, %LayoutEnumVariantDefinition %t339)
  store { %LayoutEnumVariantDefinition*, i64 }* %t340, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t341 = load double, double* %l6
  %t342 = sitofp i64 1 to double
  %t343 = fadd double %t341, %t342
  store double %t343, double* %l6
  br label %loop.latch12
loop.latch12:
  %t344 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t345 = load double, double* %l6
  br label %loop.header10
afterloop13:
  %t348 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t349 = load double, double* %l6
  %t350 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t351 = load %Statement*, %Statement** %l3
  %t352 = getelementptr inbounds %Statement, %Statement* %t351, i32 0, i32 0
  %t353 = load i32, i32* %t352
  %t354 = getelementptr inbounds %Statement, %Statement* %t351, i32 0, i32 1
  %t355 = bitcast [48 x i8]* %t354 to i8*
  %t356 = bitcast i8* %t355 to i8**
  %t357 = load i8*, i8** %t356
  %t358 = icmp eq i32 %t353, 2
  %t359 = select i1 %t358, i8* %t357, i8* null
  %t360 = getelementptr inbounds %Statement, %Statement* %t351, i32 0, i32 1
  %t361 = bitcast [48 x i8]* %t360 to i8*
  %t362 = bitcast i8* %t361 to i8**
  %t363 = load i8*, i8** %t362
  %t364 = icmp eq i32 %t353, 3
  %t365 = select i1 %t364, i8* %t363, i8* %t359
  %t366 = getelementptr inbounds %Statement, %Statement* %t351, i32 0, i32 1
  %t367 = bitcast [56 x i8]* %t366 to i8*
  %t368 = bitcast i8* %t367 to i8**
  %t369 = load i8*, i8** %t368
  %t370 = icmp eq i32 %t353, 6
  %t371 = select i1 %t370, i8* %t369, i8* %t365
  %t372 = getelementptr inbounds %Statement, %Statement* %t351, i32 0, i32 1
  %t373 = bitcast [56 x i8]* %t372 to i8*
  %t374 = bitcast i8* %t373 to i8**
  %t375 = load i8*, i8** %t374
  %t376 = icmp eq i32 %t353, 8
  %t377 = select i1 %t376, i8* %t375, i8* %t371
  %t378 = getelementptr inbounds %Statement, %Statement* %t351, i32 0, i32 1
  %t379 = bitcast [40 x i8]* %t378 to i8*
  %t380 = bitcast i8* %t379 to i8**
  %t381 = load i8*, i8** %t380
  %t382 = icmp eq i32 %t353, 9
  %t383 = select i1 %t382, i8* %t381, i8* %t377
  %t384 = getelementptr inbounds %Statement, %Statement* %t351, i32 0, i32 1
  %t385 = bitcast [40 x i8]* %t384 to i8*
  %t386 = bitcast i8* %t385 to i8**
  %t387 = load i8*, i8** %t386
  %t388 = icmp eq i32 %t353, 10
  %t389 = select i1 %t388, i8* %t387, i8* %t383
  %t390 = getelementptr inbounds %Statement, %Statement* %t351, i32 0, i32 1
  %t391 = bitcast [40 x i8]* %t390 to i8*
  %t392 = bitcast i8* %t391 to i8**
  %t393 = load i8*, i8** %t392
  %t394 = icmp eq i32 %t353, 11
  %t395 = select i1 %t394, i8* %t393, i8* %t389
  %t396 = insertvalue %LayoutEnumDefinition undef, i8* %t395, 0
  %t397 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l5
  %t398 = bitcast { %LayoutEnumVariantDefinition*, i64 }* %t397 to { %LayoutEnumVariantDefinition**, i64 }*
  %t399 = insertvalue %LayoutEnumDefinition %t396, { %LayoutEnumVariantDefinition**, i64 }* %t398, 1
  %t400 = call { %LayoutEnumDefinition*, i64 }* @append_layout_enum_definition({ %LayoutEnumDefinition*, i64 }* %t350, %LayoutEnumDefinition %t399)
  store { %LayoutEnumDefinition*, i64 }* %t400, { %LayoutEnumDefinition*, i64 }** %l1
  %t401 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  br label %merge9
merge9:
  %t402 = phi { %LayoutEnumDefinition*, i64 }* [ %t401, %afterloop13 ], [ %t267, %merge7 ]
  store { %LayoutEnumDefinition*, i64 }* %t402, { %LayoutEnumDefinition*, i64 }** %l1
  %t403 = load double, double* %l2
  %t404 = sitofp i64 1 to double
  %t405 = fadd double %t403, %t404
  store double %t405, double* %l2
  br label %loop.latch2
loop.latch2:
  %t406 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t407 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t408 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t412 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t413 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t414 = load double, double* %l2
  %t415 = load { %LayoutStructDefinition*, i64 }*, { %LayoutStructDefinition*, i64 }** %l0
  %t416 = bitcast { %LayoutStructDefinition*, i64 }* %t415 to { %LayoutStructDefinition**, i64 }*
  %t417 = insertvalue %LayoutContext undef, { %LayoutStructDefinition**, i64 }* %t416, 0
  %t418 = load { %LayoutEnumDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }** %l1
  %t419 = bitcast { %LayoutEnumDefinition*, i64 }* %t418 to { %LayoutEnumDefinition**, i64 }*
  %t420 = insertvalue %LayoutContext %t417, { %LayoutEnumDefinition**, i64 }* %t419, 1
  ret %LayoutContext %t420
}

define %EmitNativeResult @emit_native(%Program %program) {
block.entry:
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
  %t18 = phi %NativeState [ %t17, %then0 ], [ %t14, %block.entry ]
  store %NativeState %t18, %NativeState* %l1
  %t19 = sitofp i64 0 to double
  store double %t19, double* %l2
  %t20 = load %LayoutContext, %LayoutContext* %l0
  %t21 = load %NativeState, %NativeState* %l1
  %t22 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t65 = phi %NativeState [ %t21, %merge1 ], [ %t63, %loop.latch4 ]
  %t66 = phi double [ %t22, %merge1 ], [ %t64, %loop.latch4 ]
  store %NativeState %t65, %NativeState* %l1
  store double %t66, double* %l2
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
  %t35 = call double @llvm.round.f64(double %t34)
  %t36 = fptosi double %t35 to i64
  %t37 = load { %Statement**, i64 }, { %Statement**, i64 }* %t33
  %t38 = extractvalue { %Statement**, i64 } %t37, 0
  %t39 = extractvalue { %Statement**, i64 } %t37, 1
  %t40 = icmp uge i64 %t36, %t39
  ; bounds check: %t40 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t36, i64 %t39)
  %t41 = getelementptr %Statement*, %Statement** %t38, i64 %t36
  %t42 = load %Statement*, %Statement** %t41
  %t43 = load %Statement, %Statement* %t42
  %t44 = call %NativeState @emit_statement(%NativeState %t32, %Statement %t43)
  store %NativeState %t44, %NativeState* %l1
  %t45 = load double, double* %l2
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  %t48 = extractvalue %Program %program, 0
  %t49 = load { %Statement**, i64 }, { %Statement**, i64 }* %t48
  %t50 = extractvalue { %Statement**, i64 } %t49, 1
  %t51 = sitofp i64 %t50 to double
  %t52 = fcmp olt double %t47, %t51
  %t53 = load %LayoutContext, %LayoutContext* %l0
  %t54 = load %NativeState, %NativeState* %l1
  %t55 = load double, double* %l2
  br i1 %t52, label %then8, label %merge9
then8:
  %t56 = load %NativeState, %NativeState* %l1
  %t57 = call %NativeState @state_emit_blank(%NativeState %t56)
  store %NativeState %t57, %NativeState* %l1
  %t58 = load %NativeState, %NativeState* %l1
  br label %merge9
merge9:
  %t59 = phi %NativeState [ %t58, %then8 ], [ %t54, %merge7 ]
  store %NativeState %t59, %NativeState* %l1
  %t60 = load double, double* %l2
  %t61 = sitofp i64 1 to double
  %t62 = fadd double %t60, %t61
  store double %t62, double* %l2
  br label %loop.latch4
loop.latch4:
  %t63 = load %NativeState, %NativeState* %l1
  %t64 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t67 = load %NativeState, %NativeState* %l1
  %t68 = load double, double* %l2
  %s69 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h330693139, i32 0, i32 0
  %t70 = insertvalue %NativeArtifact undef, i8* %s69, 0
  %s71 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1782433603, i32 0, i32 0
  %t72 = insertvalue %NativeArtifact %t70, i8* %s71, 1
  %t73 = load %NativeState, %NativeState* %l1
  %t74 = extractvalue %NativeState %t73, 0
  %t75 = call i8* @builder_to_string(%TextBuilder %t74)
  %t76 = insertvalue %NativeArtifact %t72, i8* %t75, 2
  store %NativeArtifact %t76, %NativeArtifact* %l3
  %t77 = load %LayoutContext, %LayoutContext* %l0
  %t78 = call %NativeArtifact @generate_layout_manifest(%Program %program, %LayoutContext %t77)
  store %NativeArtifact %t78, %NativeArtifact* %l4
  %t79 = load %NativeArtifact, %NativeArtifact* %l3
  %t80 = load %NativeArtifact, %NativeArtifact* %l4
  %t81 = call noalias i8* @malloc(i64 24)
  %t82 = bitcast i8* %t81 to %NativeArtifact*
  store %NativeArtifact %t79, %NativeArtifact* %t82
  %t83 = bitcast i8* %t81 to %NativeArtifact*
  %t84 = call noalias i8* @malloc(i64 24)
  %t85 = bitcast i8* %t84 to %NativeArtifact*
  store %NativeArtifact %t80, %NativeArtifact* %t85
  %t86 = bitcast i8* %t84 to %NativeArtifact*
  %t87 = getelementptr [2 x %NativeArtifact*], [2 x %NativeArtifact*]* null, i32 1
  %t88 = ptrtoint [2 x %NativeArtifact*]* %t87 to i64
  %t89 = icmp eq i64 %t88, 0
  %t90 = select i1 %t89, i64 1, i64 %t88
  %t91 = call i8* @malloc(i64 %t90)
  %t92 = bitcast i8* %t91 to %NativeArtifact**
  %t93 = getelementptr %NativeArtifact*, %NativeArtifact** %t92, i64 0
  store %NativeArtifact* %t83, %NativeArtifact** %t93
  %t94 = getelementptr %NativeArtifact*, %NativeArtifact** %t92, i64 1
  store %NativeArtifact* %t86, %NativeArtifact** %t94
  %t95 = getelementptr { %NativeArtifact**, i64 }, { %NativeArtifact**, i64 }* null, i32 1
  %t96 = ptrtoint { %NativeArtifact**, i64 }* %t95 to i64
  %t97 = call i8* @malloc(i64 %t96)
  %t98 = bitcast i8* %t97 to { %NativeArtifact**, i64 }*
  %t99 = getelementptr { %NativeArtifact**, i64 }, { %NativeArtifact**, i64 }* %t98, i32 0, i32 0
  store %NativeArtifact** %t92, %NativeArtifact*** %t99
  %t100 = getelementptr { %NativeArtifact**, i64 }, { %NativeArtifact**, i64 }* %t98, i32 0, i32 1
  store i64 2, i64* %t100
  %t101 = insertvalue %NativeModule undef, { %NativeArtifact**, i64 }* %t98, 0
  %t102 = call { i8**, i64 }* @collect_entry_points(%Program %program)
  %t103 = insertvalue %NativeModule %t101, { i8**, i64 }* %t102, 1
  %t104 = call double @count_exported_symbols(%Program %program)
  %t105 = insertvalue %NativeModule %t103, double %t104, 2
  store %NativeModule %t105, %NativeModule* %l5
  %t106 = load %NativeModule, %NativeModule* %l5
  %t107 = insertvalue %EmitNativeResult undef, %NativeModule %t106, 0
  %t108 = load %NativeState, %NativeState* %l1
  %t109 = extractvalue %NativeState %t108, 1
  %t110 = insertvalue %EmitNativeResult %t107, { i8**, i64 }* %t109, 1
  ret %EmitNativeResult %t110
}

define %NativeState @emit_statement(%NativeState %state, %Statement %statement) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca i8*
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
  %t72 = call i1 @strings_equal(i8* %t70, i8* %s71)
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
  %t91 = alloca [2 x i8], align 1
  %t92 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 0
  store i8 34, i8* %t92
  %t93 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 1
  store i8 0, i8* %t93
  %t94 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 0
  %t95 = call i8* @sailfin_runtime_string_concat(i8* %t90, i8* %t94)
  store i8* %t95, i8** %l0
  %t96 = extractvalue %Statement %statement, 0
  %t97 = alloca %Statement
  store %Statement %statement, %Statement* %t97
  %t98 = getelementptr inbounds %Statement, %Statement* %t97, i32 0, i32 1
  %t99 = bitcast [16 x i8]* %t98 to i8*
  %t100 = bitcast i8* %t99 to { %ImportSpecifier**, i64 }**
  %t101 = load { %ImportSpecifier**, i64 }*, { %ImportSpecifier**, i64 }** %t100
  %t102 = icmp eq i32 %t96, 0
  %t103 = select i1 %t102, { %ImportSpecifier**, i64 }* %t101, { %ImportSpecifier**, i64 }* null
  %t104 = bitcast { %ImportSpecifier**, i64 }* %t103 to { %ImportSpecifier*, i64 }*
  %t105 = call i8* @render_native_specifiers({ %ImportSpecifier*, i64 }* %t104)
  store i8* %t105, i8** %l1
  %t106 = load i8*, i8** %l1
  %t107 = call i64 @sailfin_runtime_string_length(i8* %t106)
  %t108 = icmp sgt i64 %t107, 0
  %t109 = load i8*, i8** %l0
  %t110 = load i8*, i8** %l1
  br i1 %t108, label %then2, label %merge3
then2:
  %t111 = load i8*, i8** %l0
  %s112 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087758597, i32 0, i32 0
  %t113 = call i8* @sailfin_runtime_string_concat(i8* %t111, i8* %s112)
  %t114 = load i8*, i8** %l1
  %t115 = call i8* @sailfin_runtime_string_concat(i8* %t113, i8* %t114)
  %s116 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415972, i32 0, i32 0
  %t117 = call i8* @sailfin_runtime_string_concat(i8* %t115, i8* %s116)
  store i8* %t117, i8** %l0
  %t118 = load i8*, i8** %l0
  br label %merge3
merge3:
  %t119 = phi i8* [ %t118, %then2 ], [ %t109, %then0 ]
  store i8* %t119, i8** %l0
  %t120 = load i8*, i8** %l0
  %t121 = call %NativeState @state_emit_line(%NativeState %state, i8* %t120)
  ret %NativeState %t121
merge1:
  %t122 = extractvalue %Statement %statement, 0
  %t123 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t124 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t125 = icmp eq i32 %t122, 0
  %t126 = select i1 %t125, i8* %t124, i8* %t123
  %t127 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t128 = icmp eq i32 %t122, 1
  %t129 = select i1 %t128, i8* %t127, i8* %t126
  %t130 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t131 = icmp eq i32 %t122, 2
  %t132 = select i1 %t131, i8* %t130, i8* %t129
  %t133 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t134 = icmp eq i32 %t122, 3
  %t135 = select i1 %t134, i8* %t133, i8* %t132
  %t136 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t122, 4
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t122, 5
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t122, 6
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t122, 7
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t122, 8
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t122, 9
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t122, 10
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t122, 11
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %t160 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t161 = icmp eq i32 %t122, 12
  %t162 = select i1 %t161, i8* %t160, i8* %t159
  %t163 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t164 = icmp eq i32 %t122, 13
  %t165 = select i1 %t164, i8* %t163, i8* %t162
  %t166 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t167 = icmp eq i32 %t122, 14
  %t168 = select i1 %t167, i8* %t166, i8* %t165
  %t169 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t170 = icmp eq i32 %t122, 15
  %t171 = select i1 %t170, i8* %t169, i8* %t168
  %t172 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t173 = icmp eq i32 %t122, 16
  %t174 = select i1 %t173, i8* %t172, i8* %t171
  %t175 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t176 = icmp eq i32 %t122, 17
  %t177 = select i1 %t176, i8* %t175, i8* %t174
  %t178 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t179 = icmp eq i32 %t122, 18
  %t180 = select i1 %t179, i8* %t178, i8* %t177
  %t181 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t182 = icmp eq i32 %t122, 19
  %t183 = select i1 %t182, i8* %t181, i8* %t180
  %t184 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t185 = icmp eq i32 %t122, 20
  %t186 = select i1 %t185, i8* %t184, i8* %t183
  %t187 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t188 = icmp eq i32 %t122, 21
  %t189 = select i1 %t188, i8* %t187, i8* %t186
  %t190 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t191 = icmp eq i32 %t122, 22
  %t192 = select i1 %t191, i8* %t190, i8* %t189
  %s193 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1813262795, i32 0, i32 0
  %t194 = call i1 @strings_equal(i8* %t192, i8* %s193)
  br i1 %t194, label %then4, label %merge5
then4:
  %s195 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1091414306, i32 0, i32 0
  %t196 = extractvalue %Statement %statement, 0
  %t197 = alloca %Statement
  store %Statement %statement, %Statement* %t197
  %t198 = getelementptr inbounds %Statement, %Statement* %t197, i32 0, i32 1
  %t199 = bitcast [16 x i8]* %t198 to i8*
  %t200 = getelementptr inbounds i8, i8* %t199, i64 8
  %t201 = bitcast i8* %t200 to i8**
  %t202 = load i8*, i8** %t201
  %t203 = icmp eq i32 %t196, 0
  %t204 = select i1 %t203, i8* %t202, i8* null
  %t205 = getelementptr inbounds %Statement, %Statement* %t197, i32 0, i32 1
  %t206 = bitcast [16 x i8]* %t205 to i8*
  %t207 = getelementptr inbounds i8, i8* %t206, i64 8
  %t208 = bitcast i8* %t207 to i8**
  %t209 = load i8*, i8** %t208
  %t210 = icmp eq i32 %t196, 1
  %t211 = select i1 %t210, i8* %t209, i8* %t204
  %t212 = call i8* @sailfin_runtime_string_concat(i8* %s195, i8* %t211)
  %t213 = alloca [2 x i8], align 1
  %t214 = getelementptr [2 x i8], [2 x i8]* %t213, i32 0, i32 0
  store i8 34, i8* %t214
  %t215 = getelementptr [2 x i8], [2 x i8]* %t213, i32 0, i32 1
  store i8 0, i8* %t215
  %t216 = getelementptr [2 x i8], [2 x i8]* %t213, i32 0, i32 0
  %t217 = call i8* @sailfin_runtime_string_concat(i8* %t212, i8* %t216)
  store i8* %t217, i8** %l2
  %t218 = extractvalue %Statement %statement, 0
  %t219 = alloca %Statement
  store %Statement %statement, %Statement* %t219
  %t220 = getelementptr inbounds %Statement, %Statement* %t219, i32 0, i32 1
  %t221 = bitcast [16 x i8]* %t220 to i8*
  %t222 = bitcast i8* %t221 to { %ExportSpecifier**, i64 }**
  %t223 = load { %ExportSpecifier**, i64 }*, { %ExportSpecifier**, i64 }** %t222
  %t224 = icmp eq i32 %t218, 1
  %t225 = select i1 %t224, { %ExportSpecifier**, i64 }* %t223, { %ExportSpecifier**, i64 }* null
  %t226 = bitcast { %ExportSpecifier**, i64 }* %t225 to { %ExportSpecifier*, i64 }*
  %t227 = call i8* @render_export_specifiers({ %ExportSpecifier*, i64 }* %t226)
  store i8* %t227, i8** %l3
  %t228 = load i8*, i8** %l3
  %t229 = call i64 @sailfin_runtime_string_length(i8* %t228)
  %t230 = icmp sgt i64 %t229, 0
  %t231 = load i8*, i8** %l2
  %t232 = load i8*, i8** %l3
  br i1 %t230, label %then6, label %merge7
then6:
  %t233 = load i8*, i8** %l2
  %s234 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087758597, i32 0, i32 0
  %t235 = call i8* @sailfin_runtime_string_concat(i8* %t233, i8* %s234)
  %t236 = load i8*, i8** %l3
  %t237 = call i8* @sailfin_runtime_string_concat(i8* %t235, i8* %t236)
  %s238 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415972, i32 0, i32 0
  %t239 = call i8* @sailfin_runtime_string_concat(i8* %t237, i8* %s238)
  store i8* %t239, i8** %l2
  %t240 = load i8*, i8** %l2
  br label %merge7
merge7:
  %t241 = phi i8* [ %t240, %then6 ], [ %t231, %then4 ]
  store i8* %t241, i8** %l2
  %t242 = load i8*, i8** %l2
  %t243 = call %NativeState @state_emit_line(%NativeState %state, i8* %t242)
  ret %NativeState %t243
merge5:
  %t244 = extractvalue %Statement %statement, 0
  %t245 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t246 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t247 = icmp eq i32 %t244, 0
  %t248 = select i1 %t247, i8* %t246, i8* %t245
  %t249 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t250 = icmp eq i32 %t244, 1
  %t251 = select i1 %t250, i8* %t249, i8* %t248
  %t252 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t253 = icmp eq i32 %t244, 2
  %t254 = select i1 %t253, i8* %t252, i8* %t251
  %t255 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t256 = icmp eq i32 %t244, 3
  %t257 = select i1 %t256, i8* %t255, i8* %t254
  %t258 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t259 = icmp eq i32 %t244, 4
  %t260 = select i1 %t259, i8* %t258, i8* %t257
  %t261 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t262 = icmp eq i32 %t244, 5
  %t263 = select i1 %t262, i8* %t261, i8* %t260
  %t264 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t265 = icmp eq i32 %t244, 6
  %t266 = select i1 %t265, i8* %t264, i8* %t263
  %t267 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t268 = icmp eq i32 %t244, 7
  %t269 = select i1 %t268, i8* %t267, i8* %t266
  %t270 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t271 = icmp eq i32 %t244, 8
  %t272 = select i1 %t271, i8* %t270, i8* %t269
  %t273 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t274 = icmp eq i32 %t244, 9
  %t275 = select i1 %t274, i8* %t273, i8* %t272
  %t276 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t277 = icmp eq i32 %t244, 10
  %t278 = select i1 %t277, i8* %t276, i8* %t275
  %t279 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t280 = icmp eq i32 %t244, 11
  %t281 = select i1 %t280, i8* %t279, i8* %t278
  %t282 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t283 = icmp eq i32 %t244, 12
  %t284 = select i1 %t283, i8* %t282, i8* %t281
  %t285 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t286 = icmp eq i32 %t244, 13
  %t287 = select i1 %t286, i8* %t285, i8* %t284
  %t288 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t289 = icmp eq i32 %t244, 14
  %t290 = select i1 %t289, i8* %t288, i8* %t287
  %t291 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t292 = icmp eq i32 %t244, 15
  %t293 = select i1 %t292, i8* %t291, i8* %t290
  %t294 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t295 = icmp eq i32 %t244, 16
  %t296 = select i1 %t295, i8* %t294, i8* %t293
  %t297 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t298 = icmp eq i32 %t244, 17
  %t299 = select i1 %t298, i8* %t297, i8* %t296
  %t300 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t301 = icmp eq i32 %t244, 18
  %t302 = select i1 %t301, i8* %t300, i8* %t299
  %t303 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t304 = icmp eq i32 %t244, 19
  %t305 = select i1 %t304, i8* %t303, i8* %t302
  %t306 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t307 = icmp eq i32 %t244, 20
  %t308 = select i1 %t307, i8* %t306, i8* %t305
  %t309 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t310 = icmp eq i32 %t244, 21
  %t311 = select i1 %t310, i8* %t309, i8* %t308
  %t312 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t313 = icmp eq i32 %t244, 22
  %t314 = select i1 %t313, i8* %t312, i8* %t311
  %s315 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1204027478, i32 0, i32 0
  %t316 = call i1 @strings_equal(i8* %t314, i8* %s315)
  br i1 %t316, label %then8, label %merge9
then8:
  %t317 = call %NativeState @emit_variable(%NativeState %state, %Statement %statement)
  ret %NativeState %t317
merge9:
  %t318 = extractvalue %Statement %statement, 0
  %t319 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t320 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t321 = icmp eq i32 %t318, 0
  %t322 = select i1 %t321, i8* %t320, i8* %t319
  %t323 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t324 = icmp eq i32 %t318, 1
  %t325 = select i1 %t324, i8* %t323, i8* %t322
  %t326 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t327 = icmp eq i32 %t318, 2
  %t328 = select i1 %t327, i8* %t326, i8* %t325
  %t329 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t330 = icmp eq i32 %t318, 3
  %t331 = select i1 %t330, i8* %t329, i8* %t328
  %t332 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t333 = icmp eq i32 %t318, 4
  %t334 = select i1 %t333, i8* %t332, i8* %t331
  %t335 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t336 = icmp eq i32 %t318, 5
  %t337 = select i1 %t336, i8* %t335, i8* %t334
  %t338 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t339 = icmp eq i32 %t318, 6
  %t340 = select i1 %t339, i8* %t338, i8* %t337
  %t341 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t342 = icmp eq i32 %t318, 7
  %t343 = select i1 %t342, i8* %t341, i8* %t340
  %t344 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t345 = icmp eq i32 %t318, 8
  %t346 = select i1 %t345, i8* %t344, i8* %t343
  %t347 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t348 = icmp eq i32 %t318, 9
  %t349 = select i1 %t348, i8* %t347, i8* %t346
  %t350 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t351 = icmp eq i32 %t318, 10
  %t352 = select i1 %t351, i8* %t350, i8* %t349
  %t353 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t354 = icmp eq i32 %t318, 11
  %t355 = select i1 %t354, i8* %t353, i8* %t352
  %t356 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t357 = icmp eq i32 %t318, 12
  %t358 = select i1 %t357, i8* %t356, i8* %t355
  %t359 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t360 = icmp eq i32 %t318, 13
  %t361 = select i1 %t360, i8* %t359, i8* %t358
  %t362 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t363 = icmp eq i32 %t318, 14
  %t364 = select i1 %t363, i8* %t362, i8* %t361
  %t365 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t366 = icmp eq i32 %t318, 15
  %t367 = select i1 %t366, i8* %t365, i8* %t364
  %t368 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t369 = icmp eq i32 %t318, 16
  %t370 = select i1 %t369, i8* %t368, i8* %t367
  %t371 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t372 = icmp eq i32 %t318, 17
  %t373 = select i1 %t372, i8* %t371, i8* %t370
  %t374 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t375 = icmp eq i32 %t318, 18
  %t376 = select i1 %t375, i8* %t374, i8* %t373
  %t377 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t378 = icmp eq i32 %t318, 19
  %t379 = select i1 %t378, i8* %t377, i8* %t376
  %t380 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t381 = icmp eq i32 %t318, 20
  %t382 = select i1 %t381, i8* %t380, i8* %t379
  %t383 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t384 = icmp eq i32 %t318, 21
  %t385 = select i1 %t384, i8* %t383, i8* %t382
  %t386 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t387 = icmp eq i32 %t318, 22
  %t388 = select i1 %t387, i8* %t386, i8* %t385
  %s389 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h486335986, i32 0, i32 0
  %t390 = call i1 @strings_equal(i8* %t388, i8* %s389)
  br i1 %t390, label %then10, label %merge11
then10:
  %t391 = extractvalue %Statement %statement, 0
  %t392 = alloca %Statement
  store %Statement %statement, %Statement* %t392
  %t393 = getelementptr inbounds %Statement, %Statement* %t392, i32 0, i32 1
  %t394 = bitcast [88 x i8]* %t393 to i8*
  %t395 = bitcast i8* %t394 to %FunctionSignature*
  %t396 = load %FunctionSignature, %FunctionSignature* %t395
  %t397 = icmp eq i32 %t391, 4
  %t398 = select i1 %t397, %FunctionSignature %t396, %FunctionSignature zeroinitializer
  %t399 = getelementptr inbounds %Statement, %Statement* %t392, i32 0, i32 1
  %t400 = bitcast [88 x i8]* %t399 to i8*
  %t401 = bitcast i8* %t400 to %FunctionSignature*
  %t402 = load %FunctionSignature, %FunctionSignature* %t401
  %t403 = icmp eq i32 %t391, 5
  %t404 = select i1 %t403, %FunctionSignature %t402, %FunctionSignature %t398
  %t405 = getelementptr inbounds %Statement, %Statement* %t392, i32 0, i32 1
  %t406 = bitcast [88 x i8]* %t405 to i8*
  %t407 = bitcast i8* %t406 to %FunctionSignature*
  %t408 = load %FunctionSignature, %FunctionSignature* %t407
  %t409 = icmp eq i32 %t391, 7
  %t410 = select i1 %t409, %FunctionSignature %t408, %FunctionSignature %t404
  %t411 = extractvalue %Statement %statement, 0
  %t412 = alloca %Statement
  store %Statement %statement, %Statement* %t412
  %t413 = getelementptr inbounds %Statement, %Statement* %t412, i32 0, i32 1
  %t414 = bitcast [88 x i8]* %t413 to i8*
  %t415 = getelementptr inbounds i8, i8* %t414, i64 56
  %t416 = bitcast i8* %t415 to %Block*
  %t417 = load %Block, %Block* %t416
  %t418 = icmp eq i32 %t411, 4
  %t419 = select i1 %t418, %Block %t417, %Block zeroinitializer
  %t420 = getelementptr inbounds %Statement, %Statement* %t412, i32 0, i32 1
  %t421 = bitcast [88 x i8]* %t420 to i8*
  %t422 = getelementptr inbounds i8, i8* %t421, i64 56
  %t423 = bitcast i8* %t422 to %Block*
  %t424 = load %Block, %Block* %t423
  %t425 = icmp eq i32 %t411, 5
  %t426 = select i1 %t425, %Block %t424, %Block %t419
  %t427 = getelementptr inbounds %Statement, %Statement* %t412, i32 0, i32 1
  %t428 = bitcast [56 x i8]* %t427 to i8*
  %t429 = getelementptr inbounds i8, i8* %t428, i64 16
  %t430 = bitcast i8* %t429 to %Block*
  %t431 = load %Block, %Block* %t430
  %t432 = icmp eq i32 %t411, 6
  %t433 = select i1 %t432, %Block %t431, %Block %t426
  %t434 = getelementptr inbounds %Statement, %Statement* %t412, i32 0, i32 1
  %t435 = bitcast [88 x i8]* %t434 to i8*
  %t436 = getelementptr inbounds i8, i8* %t435, i64 56
  %t437 = bitcast i8* %t436 to %Block*
  %t438 = load %Block, %Block* %t437
  %t439 = icmp eq i32 %t411, 7
  %t440 = select i1 %t439, %Block %t438, %Block %t433
  %t441 = getelementptr inbounds %Statement, %Statement* %t412, i32 0, i32 1
  %t442 = bitcast [120 x i8]* %t441 to i8*
  %t443 = getelementptr inbounds i8, i8* %t442, i64 88
  %t444 = bitcast i8* %t443 to %Block*
  %t445 = load %Block, %Block* %t444
  %t446 = icmp eq i32 %t411, 12
  %t447 = select i1 %t446, %Block %t445, %Block %t440
  %t448 = getelementptr inbounds %Statement, %Statement* %t412, i32 0, i32 1
  %t449 = bitcast [40 x i8]* %t448 to i8*
  %t450 = getelementptr inbounds i8, i8* %t449, i64 8
  %t451 = bitcast i8* %t450 to %Block*
  %t452 = load %Block, %Block* %t451
  %t453 = icmp eq i32 %t411, 13
  %t454 = select i1 %t453, %Block %t452, %Block %t447
  %t455 = getelementptr inbounds %Statement, %Statement* %t412, i32 0, i32 1
  %t456 = bitcast [136 x i8]* %t455 to i8*
  %t457 = getelementptr inbounds i8, i8* %t456, i64 104
  %t458 = bitcast i8* %t457 to %Block*
  %t459 = load %Block, %Block* %t458
  %t460 = icmp eq i32 %t411, 14
  %t461 = select i1 %t460, %Block %t459, %Block %t454
  %t462 = getelementptr inbounds %Statement, %Statement* %t412, i32 0, i32 1
  %t463 = bitcast [32 x i8]* %t462 to i8*
  %t464 = bitcast i8* %t463 to %Block*
  %t465 = load %Block, %Block* %t464
  %t466 = icmp eq i32 %t411, 15
  %t467 = select i1 %t466, %Block %t465, %Block %t461
  %t468 = extractvalue %Statement %statement, 0
  %t469 = alloca %Statement
  store %Statement %statement, %Statement* %t469
  %t470 = getelementptr inbounds %Statement, %Statement* %t469, i32 0, i32 1
  %t471 = bitcast [48 x i8]* %t470 to i8*
  %t472 = getelementptr inbounds i8, i8* %t471, i64 40
  %t473 = bitcast i8* %t472 to { %Decorator**, i64 }**
  %t474 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t473
  %t475 = icmp eq i32 %t468, 3
  %t476 = select i1 %t475, { %Decorator**, i64 }* %t474, { %Decorator**, i64 }* null
  %t477 = getelementptr inbounds %Statement, %Statement* %t469, i32 0, i32 1
  %t478 = bitcast [88 x i8]* %t477 to i8*
  %t479 = getelementptr inbounds i8, i8* %t478, i64 80
  %t480 = bitcast i8* %t479 to { %Decorator**, i64 }**
  %t481 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t480
  %t482 = icmp eq i32 %t468, 4
  %t483 = select i1 %t482, { %Decorator**, i64 }* %t481, { %Decorator**, i64 }* %t476
  %t484 = getelementptr inbounds %Statement, %Statement* %t469, i32 0, i32 1
  %t485 = bitcast [88 x i8]* %t484 to i8*
  %t486 = getelementptr inbounds i8, i8* %t485, i64 80
  %t487 = bitcast i8* %t486 to { %Decorator**, i64 }**
  %t488 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t487
  %t489 = icmp eq i32 %t468, 5
  %t490 = select i1 %t489, { %Decorator**, i64 }* %t488, { %Decorator**, i64 }* %t483
  %t491 = getelementptr inbounds %Statement, %Statement* %t469, i32 0, i32 1
  %t492 = bitcast [56 x i8]* %t491 to i8*
  %t493 = getelementptr inbounds i8, i8* %t492, i64 48
  %t494 = bitcast i8* %t493 to { %Decorator**, i64 }**
  %t495 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t494
  %t496 = icmp eq i32 %t468, 6
  %t497 = select i1 %t496, { %Decorator**, i64 }* %t495, { %Decorator**, i64 }* %t490
  %t498 = getelementptr inbounds %Statement, %Statement* %t469, i32 0, i32 1
  %t499 = bitcast [88 x i8]* %t498 to i8*
  %t500 = getelementptr inbounds i8, i8* %t499, i64 80
  %t501 = bitcast i8* %t500 to { %Decorator**, i64 }**
  %t502 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t501
  %t503 = icmp eq i32 %t468, 7
  %t504 = select i1 %t503, { %Decorator**, i64 }* %t502, { %Decorator**, i64 }* %t497
  %t505 = getelementptr inbounds %Statement, %Statement* %t469, i32 0, i32 1
  %t506 = bitcast [56 x i8]* %t505 to i8*
  %t507 = getelementptr inbounds i8, i8* %t506, i64 48
  %t508 = bitcast i8* %t507 to { %Decorator**, i64 }**
  %t509 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t508
  %t510 = icmp eq i32 %t468, 8
  %t511 = select i1 %t510, { %Decorator**, i64 }* %t509, { %Decorator**, i64 }* %t504
  %t512 = getelementptr inbounds %Statement, %Statement* %t469, i32 0, i32 1
  %t513 = bitcast [40 x i8]* %t512 to i8*
  %t514 = getelementptr inbounds i8, i8* %t513, i64 32
  %t515 = bitcast i8* %t514 to { %Decorator**, i64 }**
  %t516 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t515
  %t517 = icmp eq i32 %t468, 9
  %t518 = select i1 %t517, { %Decorator**, i64 }* %t516, { %Decorator**, i64 }* %t511
  %t519 = getelementptr inbounds %Statement, %Statement* %t469, i32 0, i32 1
  %t520 = bitcast [40 x i8]* %t519 to i8*
  %t521 = getelementptr inbounds i8, i8* %t520, i64 32
  %t522 = bitcast i8* %t521 to { %Decorator**, i64 }**
  %t523 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t522
  %t524 = icmp eq i32 %t468, 10
  %t525 = select i1 %t524, { %Decorator**, i64 }* %t523, { %Decorator**, i64 }* %t518
  %t526 = getelementptr inbounds %Statement, %Statement* %t469, i32 0, i32 1
  %t527 = bitcast [40 x i8]* %t526 to i8*
  %t528 = getelementptr inbounds i8, i8* %t527, i64 32
  %t529 = bitcast i8* %t528 to { %Decorator**, i64 }**
  %t530 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t529
  %t531 = icmp eq i32 %t468, 11
  %t532 = select i1 %t531, { %Decorator**, i64 }* %t530, { %Decorator**, i64 }* %t525
  %t533 = getelementptr inbounds %Statement, %Statement* %t469, i32 0, i32 1
  %t534 = bitcast [120 x i8]* %t533 to i8*
  %t535 = getelementptr inbounds i8, i8* %t534, i64 112
  %t536 = bitcast i8* %t535 to { %Decorator**, i64 }**
  %t537 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t536
  %t538 = icmp eq i32 %t468, 12
  %t539 = select i1 %t538, { %Decorator**, i64 }* %t537, { %Decorator**, i64 }* %t532
  %t540 = getelementptr inbounds %Statement, %Statement* %t469, i32 0, i32 1
  %t541 = bitcast [40 x i8]* %t540 to i8*
  %t542 = getelementptr inbounds i8, i8* %t541, i64 32
  %t543 = bitcast i8* %t542 to { %Decorator**, i64 }**
  %t544 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t543
  %t545 = icmp eq i32 %t468, 13
  %t546 = select i1 %t545, { %Decorator**, i64 }* %t544, { %Decorator**, i64 }* %t539
  %t547 = getelementptr inbounds %Statement, %Statement* %t469, i32 0, i32 1
  %t548 = bitcast [136 x i8]* %t547 to i8*
  %t549 = getelementptr inbounds i8, i8* %t548, i64 128
  %t550 = bitcast i8* %t549 to { %Decorator**, i64 }**
  %t551 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t550
  %t552 = icmp eq i32 %t468, 14
  %t553 = select i1 %t552, { %Decorator**, i64 }* %t551, { %Decorator**, i64 }* %t546
  %t554 = getelementptr inbounds %Statement, %Statement* %t469, i32 0, i32 1
  %t555 = bitcast [32 x i8]* %t554 to i8*
  %t556 = getelementptr inbounds i8, i8* %t555, i64 24
  %t557 = bitcast i8* %t556 to { %Decorator**, i64 }**
  %t558 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t557
  %t559 = icmp eq i32 %t468, 15
  %t560 = select i1 %t559, { %Decorator**, i64 }* %t558, { %Decorator**, i64 }* %t553
  %t561 = getelementptr inbounds %Statement, %Statement* %t469, i32 0, i32 1
  %t562 = bitcast [64 x i8]* %t561 to i8*
  %t563 = getelementptr inbounds i8, i8* %t562, i64 56
  %t564 = bitcast i8* %t563 to { %Decorator**, i64 }**
  %t565 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t564
  %t566 = icmp eq i32 %t468, 18
  %t567 = select i1 %t566, { %Decorator**, i64 }* %t565, { %Decorator**, i64 }* %t560
  %t568 = getelementptr inbounds %Statement, %Statement* %t469, i32 0, i32 1
  %t569 = bitcast [88 x i8]* %t568 to i8*
  %t570 = getelementptr inbounds i8, i8* %t569, i64 80
  %t571 = bitcast i8* %t570 to { %Decorator**, i64 }**
  %t572 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t571
  %t573 = icmp eq i32 %t468, 19
  %t574 = select i1 %t573, { %Decorator**, i64 }* %t572, { %Decorator**, i64 }* %t567
  %t575 = bitcast { %Decorator**, i64 }* %t574 to { %Decorator*, i64 }*
  %t576 = call %NativeState @emit_function(%NativeState %state, %FunctionSignature %t410, %Block %t467, { %Decorator*, i64 }* %t575)
  ret %NativeState %t576
merge11:
  %t577 = extractvalue %Statement %statement, 0
  %t578 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t579 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t580 = icmp eq i32 %t577, 0
  %t581 = select i1 %t580, i8* %t579, i8* %t578
  %t582 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t583 = icmp eq i32 %t577, 1
  %t584 = select i1 %t583, i8* %t582, i8* %t581
  %t585 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t586 = icmp eq i32 %t577, 2
  %t587 = select i1 %t586, i8* %t585, i8* %t584
  %t588 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t589 = icmp eq i32 %t577, 3
  %t590 = select i1 %t589, i8* %t588, i8* %t587
  %t591 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t592 = icmp eq i32 %t577, 4
  %t593 = select i1 %t592, i8* %t591, i8* %t590
  %t594 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t595 = icmp eq i32 %t577, 5
  %t596 = select i1 %t595, i8* %t594, i8* %t593
  %t597 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t598 = icmp eq i32 %t577, 6
  %t599 = select i1 %t598, i8* %t597, i8* %t596
  %t600 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t601 = icmp eq i32 %t577, 7
  %t602 = select i1 %t601, i8* %t600, i8* %t599
  %t603 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t604 = icmp eq i32 %t577, 8
  %t605 = select i1 %t604, i8* %t603, i8* %t602
  %t606 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t607 = icmp eq i32 %t577, 9
  %t608 = select i1 %t607, i8* %t606, i8* %t605
  %t609 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t610 = icmp eq i32 %t577, 10
  %t611 = select i1 %t610, i8* %t609, i8* %t608
  %t612 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t613 = icmp eq i32 %t577, 11
  %t614 = select i1 %t613, i8* %t612, i8* %t611
  %t615 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t616 = icmp eq i32 %t577, 12
  %t617 = select i1 %t616, i8* %t615, i8* %t614
  %t618 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t619 = icmp eq i32 %t577, 13
  %t620 = select i1 %t619, i8* %t618, i8* %t617
  %t621 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t622 = icmp eq i32 %t577, 14
  %t623 = select i1 %t622, i8* %t621, i8* %t620
  %t624 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t625 = icmp eq i32 %t577, 15
  %t626 = select i1 %t625, i8* %t624, i8* %t623
  %t627 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t628 = icmp eq i32 %t577, 16
  %t629 = select i1 %t628, i8* %t627, i8* %t626
  %t630 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t631 = icmp eq i32 %t577, 17
  %t632 = select i1 %t631, i8* %t630, i8* %t629
  %t633 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t634 = icmp eq i32 %t577, 18
  %t635 = select i1 %t634, i8* %t633, i8* %t632
  %t636 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t637 = icmp eq i32 %t577, 19
  %t638 = select i1 %t637, i8* %t636, i8* %t635
  %t639 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t640 = icmp eq i32 %t577, 20
  %t641 = select i1 %t640, i8* %t639, i8* %t638
  %t642 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t643 = icmp eq i32 %t577, 21
  %t644 = select i1 %t643, i8* %t642, i8* %t641
  %t645 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t646 = icmp eq i32 %t577, 22
  %t647 = select i1 %t646, i8* %t645, i8* %t644
  %s648 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1842783069, i32 0, i32 0
  %t649 = call i1 @strings_equal(i8* %t647, i8* %s648)
  br i1 %t649, label %then12, label %merge13
then12:
  %t650 = call %NativeState @emit_struct(%NativeState %state, %Statement %statement)
  ret %NativeState %t650
merge13:
  %t651 = extractvalue %Statement %statement, 0
  %t652 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t653 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t654 = icmp eq i32 %t651, 0
  %t655 = select i1 %t654, i8* %t653, i8* %t652
  %t656 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t657 = icmp eq i32 %t651, 1
  %t658 = select i1 %t657, i8* %t656, i8* %t655
  %t659 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t660 = icmp eq i32 %t651, 2
  %t661 = select i1 %t660, i8* %t659, i8* %t658
  %t662 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t663 = icmp eq i32 %t651, 3
  %t664 = select i1 %t663, i8* %t662, i8* %t661
  %t665 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t666 = icmp eq i32 %t651, 4
  %t667 = select i1 %t666, i8* %t665, i8* %t664
  %t668 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t669 = icmp eq i32 %t651, 5
  %t670 = select i1 %t669, i8* %t668, i8* %t667
  %t671 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t672 = icmp eq i32 %t651, 6
  %t673 = select i1 %t672, i8* %t671, i8* %t670
  %t674 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t675 = icmp eq i32 %t651, 7
  %t676 = select i1 %t675, i8* %t674, i8* %t673
  %t677 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t678 = icmp eq i32 %t651, 8
  %t679 = select i1 %t678, i8* %t677, i8* %t676
  %t680 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t681 = icmp eq i32 %t651, 9
  %t682 = select i1 %t681, i8* %t680, i8* %t679
  %t683 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t684 = icmp eq i32 %t651, 10
  %t685 = select i1 %t684, i8* %t683, i8* %t682
  %t686 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t687 = icmp eq i32 %t651, 11
  %t688 = select i1 %t687, i8* %t686, i8* %t685
  %t689 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t690 = icmp eq i32 %t651, 12
  %t691 = select i1 %t690, i8* %t689, i8* %t688
  %t692 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t693 = icmp eq i32 %t651, 13
  %t694 = select i1 %t693, i8* %t692, i8* %t691
  %t695 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t696 = icmp eq i32 %t651, 14
  %t697 = select i1 %t696, i8* %t695, i8* %t694
  %t698 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t699 = icmp eq i32 %t651, 15
  %t700 = select i1 %t699, i8* %t698, i8* %t697
  %t701 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t702 = icmp eq i32 %t651, 16
  %t703 = select i1 %t702, i8* %t701, i8* %t700
  %t704 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t705 = icmp eq i32 %t651, 17
  %t706 = select i1 %t705, i8* %t704, i8* %t703
  %t707 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t708 = icmp eq i32 %t651, 18
  %t709 = select i1 %t708, i8* %t707, i8* %t706
  %t710 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t711 = icmp eq i32 %t651, 19
  %t712 = select i1 %t711, i8* %t710, i8* %t709
  %t713 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t714 = icmp eq i32 %t651, 20
  %t715 = select i1 %t714, i8* %t713, i8* %t712
  %t716 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t717 = icmp eq i32 %t651, 21
  %t718 = select i1 %t717, i8* %t716, i8* %t715
  %t719 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t720 = icmp eq i32 %t651, 22
  %t721 = select i1 %t720, i8* %t719, i8* %t718
  %s722 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h479148896, i32 0, i32 0
  %t723 = call i1 @strings_equal(i8* %t721, i8* %s722)
  br i1 %t723, label %then14, label %merge15
then14:
  %t724 = call %NativeState @emit_pipeline(%NativeState %state, %Statement %statement)
  ret %NativeState %t724
merge15:
  %t725 = extractvalue %Statement %statement, 0
  %t726 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t727 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t728 = icmp eq i32 %t725, 0
  %t729 = select i1 %t728, i8* %t727, i8* %t726
  %t730 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t731 = icmp eq i32 %t725, 1
  %t732 = select i1 %t731, i8* %t730, i8* %t729
  %t733 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t734 = icmp eq i32 %t725, 2
  %t735 = select i1 %t734, i8* %t733, i8* %t732
  %t736 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t737 = icmp eq i32 %t725, 3
  %t738 = select i1 %t737, i8* %t736, i8* %t735
  %t739 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t740 = icmp eq i32 %t725, 4
  %t741 = select i1 %t740, i8* %t739, i8* %t738
  %t742 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t743 = icmp eq i32 %t725, 5
  %t744 = select i1 %t743, i8* %t742, i8* %t741
  %t745 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t746 = icmp eq i32 %t725, 6
  %t747 = select i1 %t746, i8* %t745, i8* %t744
  %t748 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t749 = icmp eq i32 %t725, 7
  %t750 = select i1 %t749, i8* %t748, i8* %t747
  %t751 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t752 = icmp eq i32 %t725, 8
  %t753 = select i1 %t752, i8* %t751, i8* %t750
  %t754 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t755 = icmp eq i32 %t725, 9
  %t756 = select i1 %t755, i8* %t754, i8* %t753
  %t757 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t758 = icmp eq i32 %t725, 10
  %t759 = select i1 %t758, i8* %t757, i8* %t756
  %t760 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t761 = icmp eq i32 %t725, 11
  %t762 = select i1 %t761, i8* %t760, i8* %t759
  %t763 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t764 = icmp eq i32 %t725, 12
  %t765 = select i1 %t764, i8* %t763, i8* %t762
  %t766 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t767 = icmp eq i32 %t725, 13
  %t768 = select i1 %t767, i8* %t766, i8* %t765
  %t769 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t770 = icmp eq i32 %t725, 14
  %t771 = select i1 %t770, i8* %t769, i8* %t768
  %t772 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t773 = icmp eq i32 %t725, 15
  %t774 = select i1 %t773, i8* %t772, i8* %t771
  %t775 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t776 = icmp eq i32 %t725, 16
  %t777 = select i1 %t776, i8* %t775, i8* %t774
  %t778 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t779 = icmp eq i32 %t725, 17
  %t780 = select i1 %t779, i8* %t778, i8* %t777
  %t781 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t782 = icmp eq i32 %t725, 18
  %t783 = select i1 %t782, i8* %t781, i8* %t780
  %t784 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t785 = icmp eq i32 %t725, 19
  %t786 = select i1 %t785, i8* %t784, i8* %t783
  %t787 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t788 = icmp eq i32 %t725, 20
  %t789 = select i1 %t788, i8* %t787, i8* %t786
  %t790 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t791 = icmp eq i32 %t725, 21
  %t792 = select i1 %t791, i8* %t790, i8* %t789
  %t793 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t794 = icmp eq i32 %t725, 22
  %t795 = select i1 %t794, i8* %t793, i8* %t792
  %s796 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h571715647, i32 0, i32 0
  %t797 = call i1 @strings_equal(i8* %t795, i8* %s796)
  br i1 %t797, label %then16, label %merge17
then16:
  %t798 = call %NativeState @emit_tool(%NativeState %state, %Statement %statement)
  ret %NativeState %t798
merge17:
  %t799 = extractvalue %Statement %statement, 0
  %t800 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t801 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t802 = icmp eq i32 %t799, 0
  %t803 = select i1 %t802, i8* %t801, i8* %t800
  %t804 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t805 = icmp eq i32 %t799, 1
  %t806 = select i1 %t805, i8* %t804, i8* %t803
  %t807 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t808 = icmp eq i32 %t799, 2
  %t809 = select i1 %t808, i8* %t807, i8* %t806
  %t810 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t811 = icmp eq i32 %t799, 3
  %t812 = select i1 %t811, i8* %t810, i8* %t809
  %t813 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t814 = icmp eq i32 %t799, 4
  %t815 = select i1 %t814, i8* %t813, i8* %t812
  %t816 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t817 = icmp eq i32 %t799, 5
  %t818 = select i1 %t817, i8* %t816, i8* %t815
  %t819 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t820 = icmp eq i32 %t799, 6
  %t821 = select i1 %t820, i8* %t819, i8* %t818
  %t822 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t823 = icmp eq i32 %t799, 7
  %t824 = select i1 %t823, i8* %t822, i8* %t821
  %t825 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t826 = icmp eq i32 %t799, 8
  %t827 = select i1 %t826, i8* %t825, i8* %t824
  %t828 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t829 = icmp eq i32 %t799, 9
  %t830 = select i1 %t829, i8* %t828, i8* %t827
  %t831 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t832 = icmp eq i32 %t799, 10
  %t833 = select i1 %t832, i8* %t831, i8* %t830
  %t834 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t835 = icmp eq i32 %t799, 11
  %t836 = select i1 %t835, i8* %t834, i8* %t833
  %t837 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t838 = icmp eq i32 %t799, 12
  %t839 = select i1 %t838, i8* %t837, i8* %t836
  %t840 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t841 = icmp eq i32 %t799, 13
  %t842 = select i1 %t841, i8* %t840, i8* %t839
  %t843 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t844 = icmp eq i32 %t799, 14
  %t845 = select i1 %t844, i8* %t843, i8* %t842
  %t846 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t847 = icmp eq i32 %t799, 15
  %t848 = select i1 %t847, i8* %t846, i8* %t845
  %t849 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t850 = icmp eq i32 %t799, 16
  %t851 = select i1 %t850, i8* %t849, i8* %t848
  %t852 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t853 = icmp eq i32 %t799, 17
  %t854 = select i1 %t853, i8* %t852, i8* %t851
  %t855 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t856 = icmp eq i32 %t799, 18
  %t857 = select i1 %t856, i8* %t855, i8* %t854
  %t858 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t859 = icmp eq i32 %t799, 19
  %t860 = select i1 %t859, i8* %t858, i8* %t857
  %t861 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t862 = icmp eq i32 %t799, 20
  %t863 = select i1 %t862, i8* %t861, i8* %t860
  %t864 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t865 = icmp eq i32 %t799, 21
  %t866 = select i1 %t865, i8* %t864, i8* %t863
  %t867 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t868 = icmp eq i32 %t799, 22
  %t869 = select i1 %t868, i8* %t867, i8* %t866
  %s870 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h889179835, i32 0, i32 0
  %t871 = call i1 @strings_equal(i8* %t869, i8* %s870)
  br i1 %t871, label %then18, label %merge19
then18:
  %t872 = call %NativeState @emit_test(%NativeState %state, %Statement %statement)
  ret %NativeState %t872
merge19:
  %t873 = extractvalue %Statement %statement, 0
  %t874 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t875 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t876 = icmp eq i32 %t873, 0
  %t877 = select i1 %t876, i8* %t875, i8* %t874
  %t878 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t879 = icmp eq i32 %t873, 1
  %t880 = select i1 %t879, i8* %t878, i8* %t877
  %t881 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t882 = icmp eq i32 %t873, 2
  %t883 = select i1 %t882, i8* %t881, i8* %t880
  %t884 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t885 = icmp eq i32 %t873, 3
  %t886 = select i1 %t885, i8* %t884, i8* %t883
  %t887 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t888 = icmp eq i32 %t873, 4
  %t889 = select i1 %t888, i8* %t887, i8* %t886
  %t890 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t891 = icmp eq i32 %t873, 5
  %t892 = select i1 %t891, i8* %t890, i8* %t889
  %t893 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t894 = icmp eq i32 %t873, 6
  %t895 = select i1 %t894, i8* %t893, i8* %t892
  %t896 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t897 = icmp eq i32 %t873, 7
  %t898 = select i1 %t897, i8* %t896, i8* %t895
  %t899 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t900 = icmp eq i32 %t873, 8
  %t901 = select i1 %t900, i8* %t899, i8* %t898
  %t902 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t903 = icmp eq i32 %t873, 9
  %t904 = select i1 %t903, i8* %t902, i8* %t901
  %t905 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t906 = icmp eq i32 %t873, 10
  %t907 = select i1 %t906, i8* %t905, i8* %t904
  %t908 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t909 = icmp eq i32 %t873, 11
  %t910 = select i1 %t909, i8* %t908, i8* %t907
  %t911 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t912 = icmp eq i32 %t873, 12
  %t913 = select i1 %t912, i8* %t911, i8* %t910
  %t914 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t915 = icmp eq i32 %t873, 13
  %t916 = select i1 %t915, i8* %t914, i8* %t913
  %t917 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t918 = icmp eq i32 %t873, 14
  %t919 = select i1 %t918, i8* %t917, i8* %t916
  %t920 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t921 = icmp eq i32 %t873, 15
  %t922 = select i1 %t921, i8* %t920, i8* %t919
  %t923 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t924 = icmp eq i32 %t873, 16
  %t925 = select i1 %t924, i8* %t923, i8* %t922
  %t926 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t927 = icmp eq i32 %t873, 17
  %t928 = select i1 %t927, i8* %t926, i8* %t925
  %t929 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t930 = icmp eq i32 %t873, 18
  %t931 = select i1 %t930, i8* %t929, i8* %t928
  %t932 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t933 = icmp eq i32 %t873, 19
  %t934 = select i1 %t933, i8* %t932, i8* %t931
  %t935 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t936 = icmp eq i32 %t873, 20
  %t937 = select i1 %t936, i8* %t935, i8* %t934
  %t938 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t939 = icmp eq i32 %t873, 21
  %t940 = select i1 %t939, i8* %t938, i8* %t937
  %t941 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t942 = icmp eq i32 %t873, 22
  %t943 = select i1 %t942, i8* %t941, i8* %t940
  %s944 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h2043328844, i32 0, i32 0
  %t945 = call i1 @strings_equal(i8* %t943, i8* %s944)
  br i1 %t945, label %then20, label %merge21
then20:
  %t946 = call %NativeState @emit_model(%NativeState %state, %Statement %statement)
  ret %NativeState %t946
merge21:
  %t947 = extractvalue %Statement %statement, 0
  %t948 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t949 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t950 = icmp eq i32 %t947, 0
  %t951 = select i1 %t950, i8* %t949, i8* %t948
  %t952 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t953 = icmp eq i32 %t947, 1
  %t954 = select i1 %t953, i8* %t952, i8* %t951
  %t955 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t956 = icmp eq i32 %t947, 2
  %t957 = select i1 %t956, i8* %t955, i8* %t954
  %t958 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t959 = icmp eq i32 %t947, 3
  %t960 = select i1 %t959, i8* %t958, i8* %t957
  %t961 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t962 = icmp eq i32 %t947, 4
  %t963 = select i1 %t962, i8* %t961, i8* %t960
  %t964 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t965 = icmp eq i32 %t947, 5
  %t966 = select i1 %t965, i8* %t964, i8* %t963
  %t967 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t968 = icmp eq i32 %t947, 6
  %t969 = select i1 %t968, i8* %t967, i8* %t966
  %t970 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t971 = icmp eq i32 %t947, 7
  %t972 = select i1 %t971, i8* %t970, i8* %t969
  %t973 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t974 = icmp eq i32 %t947, 8
  %t975 = select i1 %t974, i8* %t973, i8* %t972
  %t976 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t977 = icmp eq i32 %t947, 9
  %t978 = select i1 %t977, i8* %t976, i8* %t975
  %t979 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t980 = icmp eq i32 %t947, 10
  %t981 = select i1 %t980, i8* %t979, i8* %t978
  %t982 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t983 = icmp eq i32 %t947, 11
  %t984 = select i1 %t983, i8* %t982, i8* %t981
  %t985 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t986 = icmp eq i32 %t947, 12
  %t987 = select i1 %t986, i8* %t985, i8* %t984
  %t988 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t989 = icmp eq i32 %t947, 13
  %t990 = select i1 %t989, i8* %t988, i8* %t987
  %t991 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t992 = icmp eq i32 %t947, 14
  %t993 = select i1 %t992, i8* %t991, i8* %t990
  %t994 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t995 = icmp eq i32 %t947, 15
  %t996 = select i1 %t995, i8* %t994, i8* %t993
  %t997 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t998 = icmp eq i32 %t947, 16
  %t999 = select i1 %t998, i8* %t997, i8* %t996
  %t1000 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1001 = icmp eq i32 %t947, 17
  %t1002 = select i1 %t1001, i8* %t1000, i8* %t999
  %t1003 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1004 = icmp eq i32 %t947, 18
  %t1005 = select i1 %t1004, i8* %t1003, i8* %t1002
  %t1006 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1007 = icmp eq i32 %t947, 19
  %t1008 = select i1 %t1007, i8* %t1006, i8* %t1005
  %t1009 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1010 = icmp eq i32 %t947, 20
  %t1011 = select i1 %t1010, i8* %t1009, i8* %t1008
  %t1012 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1013 = icmp eq i32 %t947, 21
  %t1014 = select i1 %t1013, i8* %t1012, i8* %t1011
  %t1015 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1016 = icmp eq i32 %t947, 22
  %t1017 = select i1 %t1016, i8* %t1015, i8* %t1014
  %s1018 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1496093543, i32 0, i32 0
  %t1019 = call i1 @strings_equal(i8* %t1017, i8* %s1018)
  br i1 %t1019, label %then22, label %merge23
then22:
  %t1020 = call %NativeState @emit_type_alias(%NativeState %state, %Statement %statement)
  ret %NativeState %t1020
merge23:
  %t1021 = extractvalue %Statement %statement, 0
  %t1022 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1023 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1024 = icmp eq i32 %t1021, 0
  %t1025 = select i1 %t1024, i8* %t1023, i8* %t1022
  %t1026 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1027 = icmp eq i32 %t1021, 1
  %t1028 = select i1 %t1027, i8* %t1026, i8* %t1025
  %t1029 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1030 = icmp eq i32 %t1021, 2
  %t1031 = select i1 %t1030, i8* %t1029, i8* %t1028
  %t1032 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1033 = icmp eq i32 %t1021, 3
  %t1034 = select i1 %t1033, i8* %t1032, i8* %t1031
  %t1035 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1036 = icmp eq i32 %t1021, 4
  %t1037 = select i1 %t1036, i8* %t1035, i8* %t1034
  %t1038 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1039 = icmp eq i32 %t1021, 5
  %t1040 = select i1 %t1039, i8* %t1038, i8* %t1037
  %t1041 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1042 = icmp eq i32 %t1021, 6
  %t1043 = select i1 %t1042, i8* %t1041, i8* %t1040
  %t1044 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1045 = icmp eq i32 %t1021, 7
  %t1046 = select i1 %t1045, i8* %t1044, i8* %t1043
  %t1047 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1048 = icmp eq i32 %t1021, 8
  %t1049 = select i1 %t1048, i8* %t1047, i8* %t1046
  %t1050 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1051 = icmp eq i32 %t1021, 9
  %t1052 = select i1 %t1051, i8* %t1050, i8* %t1049
  %t1053 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1054 = icmp eq i32 %t1021, 10
  %t1055 = select i1 %t1054, i8* %t1053, i8* %t1052
  %t1056 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1057 = icmp eq i32 %t1021, 11
  %t1058 = select i1 %t1057, i8* %t1056, i8* %t1055
  %t1059 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1060 = icmp eq i32 %t1021, 12
  %t1061 = select i1 %t1060, i8* %t1059, i8* %t1058
  %t1062 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1063 = icmp eq i32 %t1021, 13
  %t1064 = select i1 %t1063, i8* %t1062, i8* %t1061
  %t1065 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1066 = icmp eq i32 %t1021, 14
  %t1067 = select i1 %t1066, i8* %t1065, i8* %t1064
  %t1068 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1069 = icmp eq i32 %t1021, 15
  %t1070 = select i1 %t1069, i8* %t1068, i8* %t1067
  %t1071 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1072 = icmp eq i32 %t1021, 16
  %t1073 = select i1 %t1072, i8* %t1071, i8* %t1070
  %t1074 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1075 = icmp eq i32 %t1021, 17
  %t1076 = select i1 %t1075, i8* %t1074, i8* %t1073
  %t1077 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1078 = icmp eq i32 %t1021, 18
  %t1079 = select i1 %t1078, i8* %t1077, i8* %t1076
  %t1080 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1081 = icmp eq i32 %t1021, 19
  %t1082 = select i1 %t1081, i8* %t1080, i8* %t1079
  %t1083 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1084 = icmp eq i32 %t1021, 20
  %t1085 = select i1 %t1084, i8* %t1083, i8* %t1082
  %t1086 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1087 = icmp eq i32 %t1021, 21
  %t1088 = select i1 %t1087, i8* %t1086, i8* %t1085
  %t1089 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1090 = icmp eq i32 %t1021, 22
  %t1091 = select i1 %t1090, i8* %t1089, i8* %t1088
  %s1092 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h666604742, i32 0, i32 0
  %t1093 = call i1 @strings_equal(i8* %t1091, i8* %s1092)
  br i1 %t1093, label %then24, label %merge25
then24:
  %t1094 = call %NativeState @emit_interface(%NativeState %state, %Statement %statement)
  ret %NativeState %t1094
merge25:
  %t1095 = extractvalue %Statement %statement, 0
  %t1096 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1097 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1098 = icmp eq i32 %t1095, 0
  %t1099 = select i1 %t1098, i8* %t1097, i8* %t1096
  %t1100 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1101 = icmp eq i32 %t1095, 1
  %t1102 = select i1 %t1101, i8* %t1100, i8* %t1099
  %t1103 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1104 = icmp eq i32 %t1095, 2
  %t1105 = select i1 %t1104, i8* %t1103, i8* %t1102
  %t1106 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1107 = icmp eq i32 %t1095, 3
  %t1108 = select i1 %t1107, i8* %t1106, i8* %t1105
  %t1109 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1110 = icmp eq i32 %t1095, 4
  %t1111 = select i1 %t1110, i8* %t1109, i8* %t1108
  %t1112 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1113 = icmp eq i32 %t1095, 5
  %t1114 = select i1 %t1113, i8* %t1112, i8* %t1111
  %t1115 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1116 = icmp eq i32 %t1095, 6
  %t1117 = select i1 %t1116, i8* %t1115, i8* %t1114
  %t1118 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1119 = icmp eq i32 %t1095, 7
  %t1120 = select i1 %t1119, i8* %t1118, i8* %t1117
  %t1121 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1122 = icmp eq i32 %t1095, 8
  %t1123 = select i1 %t1122, i8* %t1121, i8* %t1120
  %t1124 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1125 = icmp eq i32 %t1095, 9
  %t1126 = select i1 %t1125, i8* %t1124, i8* %t1123
  %t1127 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1128 = icmp eq i32 %t1095, 10
  %t1129 = select i1 %t1128, i8* %t1127, i8* %t1126
  %t1130 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1131 = icmp eq i32 %t1095, 11
  %t1132 = select i1 %t1131, i8* %t1130, i8* %t1129
  %t1133 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1134 = icmp eq i32 %t1095, 12
  %t1135 = select i1 %t1134, i8* %t1133, i8* %t1132
  %t1136 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1137 = icmp eq i32 %t1095, 13
  %t1138 = select i1 %t1137, i8* %t1136, i8* %t1135
  %t1139 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1140 = icmp eq i32 %t1095, 14
  %t1141 = select i1 %t1140, i8* %t1139, i8* %t1138
  %t1142 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1143 = icmp eq i32 %t1095, 15
  %t1144 = select i1 %t1143, i8* %t1142, i8* %t1141
  %t1145 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1146 = icmp eq i32 %t1095, 16
  %t1147 = select i1 %t1146, i8* %t1145, i8* %t1144
  %t1148 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1149 = icmp eq i32 %t1095, 17
  %t1150 = select i1 %t1149, i8* %t1148, i8* %t1147
  %t1151 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1152 = icmp eq i32 %t1095, 18
  %t1153 = select i1 %t1152, i8* %t1151, i8* %t1150
  %t1154 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1155 = icmp eq i32 %t1095, 19
  %t1156 = select i1 %t1155, i8* %t1154, i8* %t1153
  %t1157 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1158 = icmp eq i32 %t1095, 20
  %t1159 = select i1 %t1158, i8* %t1157, i8* %t1156
  %t1160 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1161 = icmp eq i32 %t1095, 21
  %t1162 = select i1 %t1161, i8* %t1160, i8* %t1159
  %t1163 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1164 = icmp eq i32 %t1095, 22
  %t1165 = select i1 %t1164, i8* %t1163, i8* %t1162
  %s1166 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h579804543, i32 0, i32 0
  %t1167 = call i1 @strings_equal(i8* %t1165, i8* %s1166)
  br i1 %t1167, label %then26, label %merge27
then26:
  %t1168 = call %NativeState @emit_enum(%NativeState %state, %Statement %statement)
  ret %NativeState %t1168
merge27:
  %t1169 = extractvalue %Statement %statement, 0
  %t1170 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1171 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1172 = icmp eq i32 %t1169, 0
  %t1173 = select i1 %t1172, i8* %t1171, i8* %t1170
  %t1174 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1175 = icmp eq i32 %t1169, 1
  %t1176 = select i1 %t1175, i8* %t1174, i8* %t1173
  %t1177 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1178 = icmp eq i32 %t1169, 2
  %t1179 = select i1 %t1178, i8* %t1177, i8* %t1176
  %t1180 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1181 = icmp eq i32 %t1169, 3
  %t1182 = select i1 %t1181, i8* %t1180, i8* %t1179
  %t1183 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1184 = icmp eq i32 %t1169, 4
  %t1185 = select i1 %t1184, i8* %t1183, i8* %t1182
  %t1186 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1187 = icmp eq i32 %t1169, 5
  %t1188 = select i1 %t1187, i8* %t1186, i8* %t1185
  %t1189 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1190 = icmp eq i32 %t1169, 6
  %t1191 = select i1 %t1190, i8* %t1189, i8* %t1188
  %t1192 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1193 = icmp eq i32 %t1169, 7
  %t1194 = select i1 %t1193, i8* %t1192, i8* %t1191
  %t1195 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1196 = icmp eq i32 %t1169, 8
  %t1197 = select i1 %t1196, i8* %t1195, i8* %t1194
  %t1198 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1199 = icmp eq i32 %t1169, 9
  %t1200 = select i1 %t1199, i8* %t1198, i8* %t1197
  %t1201 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1202 = icmp eq i32 %t1169, 10
  %t1203 = select i1 %t1202, i8* %t1201, i8* %t1200
  %t1204 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1205 = icmp eq i32 %t1169, 11
  %t1206 = select i1 %t1205, i8* %t1204, i8* %t1203
  %t1207 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1208 = icmp eq i32 %t1169, 12
  %t1209 = select i1 %t1208, i8* %t1207, i8* %t1206
  %t1210 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1211 = icmp eq i32 %t1169, 13
  %t1212 = select i1 %t1211, i8* %t1210, i8* %t1209
  %t1213 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1214 = icmp eq i32 %t1169, 14
  %t1215 = select i1 %t1214, i8* %t1213, i8* %t1212
  %t1216 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1217 = icmp eq i32 %t1169, 15
  %t1218 = select i1 %t1217, i8* %t1216, i8* %t1215
  %t1219 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1220 = icmp eq i32 %t1169, 16
  %t1221 = select i1 %t1220, i8* %t1219, i8* %t1218
  %t1222 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1223 = icmp eq i32 %t1169, 17
  %t1224 = select i1 %t1223, i8* %t1222, i8* %t1221
  %t1225 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1226 = icmp eq i32 %t1169, 18
  %t1227 = select i1 %t1226, i8* %t1225, i8* %t1224
  %t1228 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1229 = icmp eq i32 %t1169, 19
  %t1230 = select i1 %t1229, i8* %t1228, i8* %t1227
  %t1231 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1232 = icmp eq i32 %t1169, 20
  %t1233 = select i1 %t1232, i8* %t1231, i8* %t1230
  %t1234 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1235 = icmp eq i32 %t1169, 21
  %t1236 = select i1 %t1235, i8* %t1234, i8* %t1233
  %t1237 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1238 = icmp eq i32 %t1169, 22
  %t1239 = select i1 %t1238, i8* %t1237, i8* %t1236
  %s1240 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1067284810, i32 0, i32 0
  %t1241 = call i1 @strings_equal(i8* %t1239, i8* %s1240)
  br i1 %t1241, label %then28, label %merge29
then28:
  %t1242 = call %NativeState @emit_prompt(%NativeState %state, %Statement %statement)
  ret %NativeState %t1242
merge29:
  %t1243 = extractvalue %Statement %statement, 0
  %t1244 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1245 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1246 = icmp eq i32 %t1243, 0
  %t1247 = select i1 %t1246, i8* %t1245, i8* %t1244
  %t1248 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1249 = icmp eq i32 %t1243, 1
  %t1250 = select i1 %t1249, i8* %t1248, i8* %t1247
  %t1251 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1252 = icmp eq i32 %t1243, 2
  %t1253 = select i1 %t1252, i8* %t1251, i8* %t1250
  %t1254 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1255 = icmp eq i32 %t1243, 3
  %t1256 = select i1 %t1255, i8* %t1254, i8* %t1253
  %t1257 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1258 = icmp eq i32 %t1243, 4
  %t1259 = select i1 %t1258, i8* %t1257, i8* %t1256
  %t1260 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1261 = icmp eq i32 %t1243, 5
  %t1262 = select i1 %t1261, i8* %t1260, i8* %t1259
  %t1263 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1264 = icmp eq i32 %t1243, 6
  %t1265 = select i1 %t1264, i8* %t1263, i8* %t1262
  %t1266 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1267 = icmp eq i32 %t1243, 7
  %t1268 = select i1 %t1267, i8* %t1266, i8* %t1265
  %t1269 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1270 = icmp eq i32 %t1243, 8
  %t1271 = select i1 %t1270, i8* %t1269, i8* %t1268
  %t1272 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1273 = icmp eq i32 %t1243, 9
  %t1274 = select i1 %t1273, i8* %t1272, i8* %t1271
  %t1275 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1276 = icmp eq i32 %t1243, 10
  %t1277 = select i1 %t1276, i8* %t1275, i8* %t1274
  %t1278 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1279 = icmp eq i32 %t1243, 11
  %t1280 = select i1 %t1279, i8* %t1278, i8* %t1277
  %t1281 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1282 = icmp eq i32 %t1243, 12
  %t1283 = select i1 %t1282, i8* %t1281, i8* %t1280
  %t1284 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1285 = icmp eq i32 %t1243, 13
  %t1286 = select i1 %t1285, i8* %t1284, i8* %t1283
  %t1287 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1288 = icmp eq i32 %t1243, 14
  %t1289 = select i1 %t1288, i8* %t1287, i8* %t1286
  %t1290 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1291 = icmp eq i32 %t1243, 15
  %t1292 = select i1 %t1291, i8* %t1290, i8* %t1289
  %t1293 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1294 = icmp eq i32 %t1243, 16
  %t1295 = select i1 %t1294, i8* %t1293, i8* %t1292
  %t1296 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1297 = icmp eq i32 %t1243, 17
  %t1298 = select i1 %t1297, i8* %t1296, i8* %t1295
  %t1299 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1300 = icmp eq i32 %t1243, 18
  %t1301 = select i1 %t1300, i8* %t1299, i8* %t1298
  %t1302 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1303 = icmp eq i32 %t1243, 19
  %t1304 = select i1 %t1303, i8* %t1302, i8* %t1301
  %t1305 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1306 = icmp eq i32 %t1243, 20
  %t1307 = select i1 %t1306, i8* %t1305, i8* %t1304
  %t1308 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1309 = icmp eq i32 %t1243, 21
  %t1310 = select i1 %t1309, i8* %t1308, i8* %t1307
  %t1311 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1312 = icmp eq i32 %t1243, 22
  %t1313 = select i1 %t1312, i8* %t1311, i8* %t1310
  %s1314 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1925822000, i32 0, i32 0
  %t1315 = call i1 @strings_equal(i8* %t1313, i8* %s1314)
  br i1 %t1315, label %then30, label %merge31
then30:
  %t1316 = call %NativeState @emit_with(%NativeState %state, %Statement %statement)
  ret %NativeState %t1316
merge31:
  %t1317 = extractvalue %Statement %statement, 0
  %t1318 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1319 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1320 = icmp eq i32 %t1317, 0
  %t1321 = select i1 %t1320, i8* %t1319, i8* %t1318
  %t1322 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1323 = icmp eq i32 %t1317, 1
  %t1324 = select i1 %t1323, i8* %t1322, i8* %t1321
  %t1325 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1326 = icmp eq i32 %t1317, 2
  %t1327 = select i1 %t1326, i8* %t1325, i8* %t1324
  %t1328 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1329 = icmp eq i32 %t1317, 3
  %t1330 = select i1 %t1329, i8* %t1328, i8* %t1327
  %t1331 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1332 = icmp eq i32 %t1317, 4
  %t1333 = select i1 %t1332, i8* %t1331, i8* %t1330
  %t1334 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1335 = icmp eq i32 %t1317, 5
  %t1336 = select i1 %t1335, i8* %t1334, i8* %t1333
  %t1337 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1338 = icmp eq i32 %t1317, 6
  %t1339 = select i1 %t1338, i8* %t1337, i8* %t1336
  %t1340 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1341 = icmp eq i32 %t1317, 7
  %t1342 = select i1 %t1341, i8* %t1340, i8* %t1339
  %t1343 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1344 = icmp eq i32 %t1317, 8
  %t1345 = select i1 %t1344, i8* %t1343, i8* %t1342
  %t1346 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1347 = icmp eq i32 %t1317, 9
  %t1348 = select i1 %t1347, i8* %t1346, i8* %t1345
  %t1349 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1350 = icmp eq i32 %t1317, 10
  %t1351 = select i1 %t1350, i8* %t1349, i8* %t1348
  %t1352 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1353 = icmp eq i32 %t1317, 11
  %t1354 = select i1 %t1353, i8* %t1352, i8* %t1351
  %t1355 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1356 = icmp eq i32 %t1317, 12
  %t1357 = select i1 %t1356, i8* %t1355, i8* %t1354
  %t1358 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1359 = icmp eq i32 %t1317, 13
  %t1360 = select i1 %t1359, i8* %t1358, i8* %t1357
  %t1361 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1362 = icmp eq i32 %t1317, 14
  %t1363 = select i1 %t1362, i8* %t1361, i8* %t1360
  %t1364 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1365 = icmp eq i32 %t1317, 15
  %t1366 = select i1 %t1365, i8* %t1364, i8* %t1363
  %t1367 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1368 = icmp eq i32 %t1317, 16
  %t1369 = select i1 %t1368, i8* %t1367, i8* %t1366
  %t1370 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1371 = icmp eq i32 %t1317, 17
  %t1372 = select i1 %t1371, i8* %t1370, i8* %t1369
  %t1373 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1374 = icmp eq i32 %t1317, 18
  %t1375 = select i1 %t1374, i8* %t1373, i8* %t1372
  %t1376 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1377 = icmp eq i32 %t1317, 19
  %t1378 = select i1 %t1377, i8* %t1376, i8* %t1375
  %t1379 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1380 = icmp eq i32 %t1317, 20
  %t1381 = select i1 %t1380, i8* %t1379, i8* %t1378
  %t1382 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1383 = icmp eq i32 %t1317, 21
  %t1384 = select i1 %t1383, i8* %t1382, i8* %t1381
  %t1385 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1386 = icmp eq i32 %t1317, 22
  %t1387 = select i1 %t1386, i8* %t1385, i8* %t1384
  %s1388 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h84042670, i32 0, i32 0
  %t1389 = call i1 @strings_equal(i8* %t1387, i8* %s1388)
  br i1 %t1389, label %then32, label %merge33
then32:
  %t1390 = call %NativeState @emit_for(%NativeState %state, %Statement %statement)
  ret %NativeState %t1390
merge33:
  %t1391 = extractvalue %Statement %statement, 0
  %t1392 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1393 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1394 = icmp eq i32 %t1391, 0
  %t1395 = select i1 %t1394, i8* %t1393, i8* %t1392
  %t1396 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1397 = icmp eq i32 %t1391, 1
  %t1398 = select i1 %t1397, i8* %t1396, i8* %t1395
  %t1399 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1400 = icmp eq i32 %t1391, 2
  %t1401 = select i1 %t1400, i8* %t1399, i8* %t1398
  %t1402 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1403 = icmp eq i32 %t1391, 3
  %t1404 = select i1 %t1403, i8* %t1402, i8* %t1401
  %t1405 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1406 = icmp eq i32 %t1391, 4
  %t1407 = select i1 %t1406, i8* %t1405, i8* %t1404
  %t1408 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1409 = icmp eq i32 %t1391, 5
  %t1410 = select i1 %t1409, i8* %t1408, i8* %t1407
  %t1411 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1412 = icmp eq i32 %t1391, 6
  %t1413 = select i1 %t1412, i8* %t1411, i8* %t1410
  %t1414 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1415 = icmp eq i32 %t1391, 7
  %t1416 = select i1 %t1415, i8* %t1414, i8* %t1413
  %t1417 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1418 = icmp eq i32 %t1391, 8
  %t1419 = select i1 %t1418, i8* %t1417, i8* %t1416
  %t1420 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1421 = icmp eq i32 %t1391, 9
  %t1422 = select i1 %t1421, i8* %t1420, i8* %t1419
  %t1423 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1424 = icmp eq i32 %t1391, 10
  %t1425 = select i1 %t1424, i8* %t1423, i8* %t1422
  %t1426 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1427 = icmp eq i32 %t1391, 11
  %t1428 = select i1 %t1427, i8* %t1426, i8* %t1425
  %t1429 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1430 = icmp eq i32 %t1391, 12
  %t1431 = select i1 %t1430, i8* %t1429, i8* %t1428
  %t1432 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1433 = icmp eq i32 %t1391, 13
  %t1434 = select i1 %t1433, i8* %t1432, i8* %t1431
  %t1435 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1436 = icmp eq i32 %t1391, 14
  %t1437 = select i1 %t1436, i8* %t1435, i8* %t1434
  %t1438 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1439 = icmp eq i32 %t1391, 15
  %t1440 = select i1 %t1439, i8* %t1438, i8* %t1437
  %t1441 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1442 = icmp eq i32 %t1391, 16
  %t1443 = select i1 %t1442, i8* %t1441, i8* %t1440
  %t1444 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1445 = icmp eq i32 %t1391, 17
  %t1446 = select i1 %t1445, i8* %t1444, i8* %t1443
  %t1447 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1448 = icmp eq i32 %t1391, 18
  %t1449 = select i1 %t1448, i8* %t1447, i8* %t1446
  %t1450 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1451 = icmp eq i32 %t1391, 19
  %t1452 = select i1 %t1451, i8* %t1450, i8* %t1449
  %t1453 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1454 = icmp eq i32 %t1391, 20
  %t1455 = select i1 %t1454, i8* %t1453, i8* %t1452
  %t1456 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1457 = icmp eq i32 %t1391, 21
  %t1458 = select i1 %t1457, i8* %t1456, i8* %t1455
  %t1459 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1460 = icmp eq i32 %t1391, 22
  %t1461 = select i1 %t1460, i8* %t1459, i8* %t1458
  %s1462 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h196308685, i32 0, i32 0
  %t1463 = call i1 @strings_equal(i8* %t1461, i8* %s1462)
  br i1 %t1463, label %then34, label %merge35
then34:
  %t1464 = call %NativeState @emit_match(%NativeState %state, %Statement %statement)
  ret %NativeState %t1464
merge35:
  %t1465 = extractvalue %Statement %statement, 0
  %t1466 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1467 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1468 = icmp eq i32 %t1465, 0
  %t1469 = select i1 %t1468, i8* %t1467, i8* %t1466
  %t1470 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1471 = icmp eq i32 %t1465, 1
  %t1472 = select i1 %t1471, i8* %t1470, i8* %t1469
  %t1473 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1474 = icmp eq i32 %t1465, 2
  %t1475 = select i1 %t1474, i8* %t1473, i8* %t1472
  %t1476 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1477 = icmp eq i32 %t1465, 3
  %t1478 = select i1 %t1477, i8* %t1476, i8* %t1475
  %t1479 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1480 = icmp eq i32 %t1465, 4
  %t1481 = select i1 %t1480, i8* %t1479, i8* %t1478
  %t1482 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1483 = icmp eq i32 %t1465, 5
  %t1484 = select i1 %t1483, i8* %t1482, i8* %t1481
  %t1485 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1486 = icmp eq i32 %t1465, 6
  %t1487 = select i1 %t1486, i8* %t1485, i8* %t1484
  %t1488 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1489 = icmp eq i32 %t1465, 7
  %t1490 = select i1 %t1489, i8* %t1488, i8* %t1487
  %t1491 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1492 = icmp eq i32 %t1465, 8
  %t1493 = select i1 %t1492, i8* %t1491, i8* %t1490
  %t1494 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1495 = icmp eq i32 %t1465, 9
  %t1496 = select i1 %t1495, i8* %t1494, i8* %t1493
  %t1497 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1498 = icmp eq i32 %t1465, 10
  %t1499 = select i1 %t1498, i8* %t1497, i8* %t1496
  %t1500 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1501 = icmp eq i32 %t1465, 11
  %t1502 = select i1 %t1501, i8* %t1500, i8* %t1499
  %t1503 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1504 = icmp eq i32 %t1465, 12
  %t1505 = select i1 %t1504, i8* %t1503, i8* %t1502
  %t1506 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1507 = icmp eq i32 %t1465, 13
  %t1508 = select i1 %t1507, i8* %t1506, i8* %t1505
  %t1509 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1510 = icmp eq i32 %t1465, 14
  %t1511 = select i1 %t1510, i8* %t1509, i8* %t1508
  %t1512 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1513 = icmp eq i32 %t1465, 15
  %t1514 = select i1 %t1513, i8* %t1512, i8* %t1511
  %t1515 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1516 = icmp eq i32 %t1465, 16
  %t1517 = select i1 %t1516, i8* %t1515, i8* %t1514
  %t1518 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1519 = icmp eq i32 %t1465, 17
  %t1520 = select i1 %t1519, i8* %t1518, i8* %t1517
  %t1521 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1522 = icmp eq i32 %t1465, 18
  %t1523 = select i1 %t1522, i8* %t1521, i8* %t1520
  %t1524 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1525 = icmp eq i32 %t1465, 19
  %t1526 = select i1 %t1525, i8* %t1524, i8* %t1523
  %t1527 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1528 = icmp eq i32 %t1465, 20
  %t1529 = select i1 %t1528, i8* %t1527, i8* %t1526
  %t1530 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1531 = icmp eq i32 %t1465, 21
  %t1532 = select i1 %t1531, i8* %t1530, i8* %t1529
  %t1533 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1534 = icmp eq i32 %t1465, 22
  %t1535 = select i1 %t1534, i8* %t1533, i8* %t1532
  %s1536 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1678412334, i32 0, i32 0
  %t1537 = call i1 @strings_equal(i8* %t1535, i8* %s1536)
  br i1 %t1537, label %then36, label %merge37
then36:
  %t1538 = call %NativeState @emit_loop(%NativeState %state, %Statement %statement)
  ret %NativeState %t1538
merge37:
  %t1539 = extractvalue %Statement %statement, 0
  %t1540 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1541 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1542 = icmp eq i32 %t1539, 0
  %t1543 = select i1 %t1542, i8* %t1541, i8* %t1540
  %t1544 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1545 = icmp eq i32 %t1539, 1
  %t1546 = select i1 %t1545, i8* %t1544, i8* %t1543
  %t1547 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1548 = icmp eq i32 %t1539, 2
  %t1549 = select i1 %t1548, i8* %t1547, i8* %t1546
  %t1550 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1551 = icmp eq i32 %t1539, 3
  %t1552 = select i1 %t1551, i8* %t1550, i8* %t1549
  %t1553 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1554 = icmp eq i32 %t1539, 4
  %t1555 = select i1 %t1554, i8* %t1553, i8* %t1552
  %t1556 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1557 = icmp eq i32 %t1539, 5
  %t1558 = select i1 %t1557, i8* %t1556, i8* %t1555
  %t1559 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1560 = icmp eq i32 %t1539, 6
  %t1561 = select i1 %t1560, i8* %t1559, i8* %t1558
  %t1562 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1563 = icmp eq i32 %t1539, 7
  %t1564 = select i1 %t1563, i8* %t1562, i8* %t1561
  %t1565 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1566 = icmp eq i32 %t1539, 8
  %t1567 = select i1 %t1566, i8* %t1565, i8* %t1564
  %t1568 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1569 = icmp eq i32 %t1539, 9
  %t1570 = select i1 %t1569, i8* %t1568, i8* %t1567
  %t1571 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1572 = icmp eq i32 %t1539, 10
  %t1573 = select i1 %t1572, i8* %t1571, i8* %t1570
  %t1574 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1575 = icmp eq i32 %t1539, 11
  %t1576 = select i1 %t1575, i8* %t1574, i8* %t1573
  %t1577 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1578 = icmp eq i32 %t1539, 12
  %t1579 = select i1 %t1578, i8* %t1577, i8* %t1576
  %t1580 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1581 = icmp eq i32 %t1539, 13
  %t1582 = select i1 %t1581, i8* %t1580, i8* %t1579
  %t1583 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1584 = icmp eq i32 %t1539, 14
  %t1585 = select i1 %t1584, i8* %t1583, i8* %t1582
  %t1586 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1587 = icmp eq i32 %t1539, 15
  %t1588 = select i1 %t1587, i8* %t1586, i8* %t1585
  %t1589 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1590 = icmp eq i32 %t1539, 16
  %t1591 = select i1 %t1590, i8* %t1589, i8* %t1588
  %t1592 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1593 = icmp eq i32 %t1539, 17
  %t1594 = select i1 %t1593, i8* %t1592, i8* %t1591
  %t1595 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1596 = icmp eq i32 %t1539, 18
  %t1597 = select i1 %t1596, i8* %t1595, i8* %t1594
  %t1598 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1599 = icmp eq i32 %t1539, 19
  %t1600 = select i1 %t1599, i8* %t1598, i8* %t1597
  %t1601 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1602 = icmp eq i32 %t1539, 20
  %t1603 = select i1 %t1602, i8* %t1601, i8* %t1600
  %t1604 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1605 = icmp eq i32 %t1539, 21
  %t1606 = select i1 %t1605, i8* %t1604, i8* %t1603
  %t1607 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1608 = icmp eq i32 %t1539, 22
  %t1609 = select i1 %t1608, i8* %t1607, i8* %t1606
  %s1610 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h88846349, i32 0, i32 0
  %t1611 = call i1 @strings_equal(i8* %t1609, i8* %s1610)
  br i1 %t1611, label %then38, label %merge39
then38:
  %s1612 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1958778164, i32 0, i32 0
  %t1613 = call %NativeState @state_emit_line(%NativeState %state, i8* %s1612)
  ret %NativeState %t1613
merge39:
  %t1614 = extractvalue %Statement %statement, 0
  %t1615 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1616 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1617 = icmp eq i32 %t1614, 0
  %t1618 = select i1 %t1617, i8* %t1616, i8* %t1615
  %t1619 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1620 = icmp eq i32 %t1614, 1
  %t1621 = select i1 %t1620, i8* %t1619, i8* %t1618
  %t1622 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1623 = icmp eq i32 %t1614, 2
  %t1624 = select i1 %t1623, i8* %t1622, i8* %t1621
  %t1625 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1626 = icmp eq i32 %t1614, 3
  %t1627 = select i1 %t1626, i8* %t1625, i8* %t1624
  %t1628 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1629 = icmp eq i32 %t1614, 4
  %t1630 = select i1 %t1629, i8* %t1628, i8* %t1627
  %t1631 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1632 = icmp eq i32 %t1614, 5
  %t1633 = select i1 %t1632, i8* %t1631, i8* %t1630
  %t1634 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1635 = icmp eq i32 %t1614, 6
  %t1636 = select i1 %t1635, i8* %t1634, i8* %t1633
  %t1637 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1638 = icmp eq i32 %t1614, 7
  %t1639 = select i1 %t1638, i8* %t1637, i8* %t1636
  %t1640 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1641 = icmp eq i32 %t1614, 8
  %t1642 = select i1 %t1641, i8* %t1640, i8* %t1639
  %t1643 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1644 = icmp eq i32 %t1614, 9
  %t1645 = select i1 %t1644, i8* %t1643, i8* %t1642
  %t1646 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1647 = icmp eq i32 %t1614, 10
  %t1648 = select i1 %t1647, i8* %t1646, i8* %t1645
  %t1649 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1650 = icmp eq i32 %t1614, 11
  %t1651 = select i1 %t1650, i8* %t1649, i8* %t1648
  %t1652 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1653 = icmp eq i32 %t1614, 12
  %t1654 = select i1 %t1653, i8* %t1652, i8* %t1651
  %t1655 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1656 = icmp eq i32 %t1614, 13
  %t1657 = select i1 %t1656, i8* %t1655, i8* %t1654
  %t1658 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1659 = icmp eq i32 %t1614, 14
  %t1660 = select i1 %t1659, i8* %t1658, i8* %t1657
  %t1661 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1662 = icmp eq i32 %t1614, 15
  %t1663 = select i1 %t1662, i8* %t1661, i8* %t1660
  %t1664 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1665 = icmp eq i32 %t1614, 16
  %t1666 = select i1 %t1665, i8* %t1664, i8* %t1663
  %t1667 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1668 = icmp eq i32 %t1614, 17
  %t1669 = select i1 %t1668, i8* %t1667, i8* %t1666
  %t1670 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1671 = icmp eq i32 %t1614, 18
  %t1672 = select i1 %t1671, i8* %t1670, i8* %t1669
  %t1673 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1674 = icmp eq i32 %t1614, 19
  %t1675 = select i1 %t1674, i8* %t1673, i8* %t1672
  %t1676 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1677 = icmp eq i32 %t1614, 20
  %t1678 = select i1 %t1677, i8* %t1676, i8* %t1675
  %t1679 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1680 = icmp eq i32 %t1614, 21
  %t1681 = select i1 %t1680, i8* %t1679, i8* %t1678
  %t1682 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1683 = icmp eq i32 %t1614, 22
  %t1684 = select i1 %t1683, i8* %t1682, i8* %t1681
  %s1685 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1998778048, i32 0, i32 0
  %t1686 = call i1 @strings_equal(i8* %t1684, i8* %s1685)
  br i1 %t1686, label %then40, label %merge41
then40:
  %s1687 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h528348603, i32 0, i32 0
  %t1688 = call %NativeState @state_emit_line(%NativeState %state, i8* %s1687)
  ret %NativeState %t1688
merge41:
  %t1689 = extractvalue %Statement %statement, 0
  %t1690 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1691 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1692 = icmp eq i32 %t1689, 0
  %t1693 = select i1 %t1692, i8* %t1691, i8* %t1690
  %t1694 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1695 = icmp eq i32 %t1689, 1
  %t1696 = select i1 %t1695, i8* %t1694, i8* %t1693
  %t1697 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1698 = icmp eq i32 %t1689, 2
  %t1699 = select i1 %t1698, i8* %t1697, i8* %t1696
  %t1700 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1701 = icmp eq i32 %t1689, 3
  %t1702 = select i1 %t1701, i8* %t1700, i8* %t1699
  %t1703 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1704 = icmp eq i32 %t1689, 4
  %t1705 = select i1 %t1704, i8* %t1703, i8* %t1702
  %t1706 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1707 = icmp eq i32 %t1689, 5
  %t1708 = select i1 %t1707, i8* %t1706, i8* %t1705
  %t1709 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1710 = icmp eq i32 %t1689, 6
  %t1711 = select i1 %t1710, i8* %t1709, i8* %t1708
  %t1712 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1713 = icmp eq i32 %t1689, 7
  %t1714 = select i1 %t1713, i8* %t1712, i8* %t1711
  %t1715 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1716 = icmp eq i32 %t1689, 8
  %t1717 = select i1 %t1716, i8* %t1715, i8* %t1714
  %t1718 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1719 = icmp eq i32 %t1689, 9
  %t1720 = select i1 %t1719, i8* %t1718, i8* %t1717
  %t1721 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1722 = icmp eq i32 %t1689, 10
  %t1723 = select i1 %t1722, i8* %t1721, i8* %t1720
  %t1724 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1725 = icmp eq i32 %t1689, 11
  %t1726 = select i1 %t1725, i8* %t1724, i8* %t1723
  %t1727 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1728 = icmp eq i32 %t1689, 12
  %t1729 = select i1 %t1728, i8* %t1727, i8* %t1726
  %t1730 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1731 = icmp eq i32 %t1689, 13
  %t1732 = select i1 %t1731, i8* %t1730, i8* %t1729
  %t1733 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1734 = icmp eq i32 %t1689, 14
  %t1735 = select i1 %t1734, i8* %t1733, i8* %t1732
  %t1736 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1737 = icmp eq i32 %t1689, 15
  %t1738 = select i1 %t1737, i8* %t1736, i8* %t1735
  %t1739 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1740 = icmp eq i32 %t1689, 16
  %t1741 = select i1 %t1740, i8* %t1739, i8* %t1738
  %t1742 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1743 = icmp eq i32 %t1689, 17
  %t1744 = select i1 %t1743, i8* %t1742, i8* %t1741
  %t1745 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1746 = icmp eq i32 %t1689, 18
  %t1747 = select i1 %t1746, i8* %t1745, i8* %t1744
  %t1748 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1749 = icmp eq i32 %t1689, 19
  %t1750 = select i1 %t1749, i8* %t1748, i8* %t1747
  %t1751 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1752 = icmp eq i32 %t1689, 20
  %t1753 = select i1 %t1752, i8* %t1751, i8* %t1750
  %t1754 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1755 = icmp eq i32 %t1689, 21
  %t1756 = select i1 %t1755, i8* %t1754, i8* %t1753
  %t1757 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1758 = icmp eq i32 %t1689, 22
  %t1759 = select i1 %t1758, i8* %t1757, i8* %t1756
  %s1760 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1566780570, i32 0, i32 0
  %t1761 = call i1 @strings_equal(i8* %t1759, i8* %s1760)
  br i1 %t1761, label %then42, label %merge43
then42:
  %t1762 = call %NativeState @emit_if(%NativeState %state, %Statement %statement)
  ret %NativeState %t1762
merge43:
  %t1763 = extractvalue %Statement %statement, 0
  %t1764 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1765 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1766 = icmp eq i32 %t1763, 0
  %t1767 = select i1 %t1766, i8* %t1765, i8* %t1764
  %t1768 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1769 = icmp eq i32 %t1763, 1
  %t1770 = select i1 %t1769, i8* %t1768, i8* %t1767
  %t1771 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1772 = icmp eq i32 %t1763, 2
  %t1773 = select i1 %t1772, i8* %t1771, i8* %t1770
  %t1774 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1775 = icmp eq i32 %t1763, 3
  %t1776 = select i1 %t1775, i8* %t1774, i8* %t1773
  %t1777 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1778 = icmp eq i32 %t1763, 4
  %t1779 = select i1 %t1778, i8* %t1777, i8* %t1776
  %t1780 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1781 = icmp eq i32 %t1763, 5
  %t1782 = select i1 %t1781, i8* %t1780, i8* %t1779
  %t1783 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1784 = icmp eq i32 %t1763, 6
  %t1785 = select i1 %t1784, i8* %t1783, i8* %t1782
  %t1786 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1787 = icmp eq i32 %t1763, 7
  %t1788 = select i1 %t1787, i8* %t1786, i8* %t1785
  %t1789 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1790 = icmp eq i32 %t1763, 8
  %t1791 = select i1 %t1790, i8* %t1789, i8* %t1788
  %t1792 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1793 = icmp eq i32 %t1763, 9
  %t1794 = select i1 %t1793, i8* %t1792, i8* %t1791
  %t1795 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1796 = icmp eq i32 %t1763, 10
  %t1797 = select i1 %t1796, i8* %t1795, i8* %t1794
  %t1798 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1799 = icmp eq i32 %t1763, 11
  %t1800 = select i1 %t1799, i8* %t1798, i8* %t1797
  %t1801 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1802 = icmp eq i32 %t1763, 12
  %t1803 = select i1 %t1802, i8* %t1801, i8* %t1800
  %t1804 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1805 = icmp eq i32 %t1763, 13
  %t1806 = select i1 %t1805, i8* %t1804, i8* %t1803
  %t1807 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1808 = icmp eq i32 %t1763, 14
  %t1809 = select i1 %t1808, i8* %t1807, i8* %t1806
  %t1810 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1811 = icmp eq i32 %t1763, 15
  %t1812 = select i1 %t1811, i8* %t1810, i8* %t1809
  %t1813 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1814 = icmp eq i32 %t1763, 16
  %t1815 = select i1 %t1814, i8* %t1813, i8* %t1812
  %t1816 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1817 = icmp eq i32 %t1763, 17
  %t1818 = select i1 %t1817, i8* %t1816, i8* %t1815
  %t1819 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1820 = icmp eq i32 %t1763, 18
  %t1821 = select i1 %t1820, i8* %t1819, i8* %t1818
  %t1822 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1823 = icmp eq i32 %t1763, 19
  %t1824 = select i1 %t1823, i8* %t1822, i8* %t1821
  %t1825 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1826 = icmp eq i32 %t1763, 20
  %t1827 = select i1 %t1826, i8* %t1825, i8* %t1824
  %t1828 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1829 = icmp eq i32 %t1763, 21
  %t1830 = select i1 %t1829, i8* %t1828, i8* %t1827
  %t1831 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1832 = icmp eq i32 %t1763, 22
  %t1833 = select i1 %t1832, i8* %t1831, i8* %t1830
  %s1834 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1613933868, i32 0, i32 0
  %t1835 = call i1 @strings_equal(i8* %t1833, i8* %s1834)
  br i1 %t1835, label %then44, label %merge45
then44:
  %t1836 = call %NativeState @emit_return(%NativeState %state, %Statement %statement)
  ret %NativeState %t1836
merge45:
  %t1837 = extractvalue %Statement %statement, 0
  %t1838 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1839 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1840 = icmp eq i32 %t1837, 0
  %t1841 = select i1 %t1840, i8* %t1839, i8* %t1838
  %t1842 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1843 = icmp eq i32 %t1837, 1
  %t1844 = select i1 %t1843, i8* %t1842, i8* %t1841
  %t1845 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1846 = icmp eq i32 %t1837, 2
  %t1847 = select i1 %t1846, i8* %t1845, i8* %t1844
  %t1848 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1849 = icmp eq i32 %t1837, 3
  %t1850 = select i1 %t1849, i8* %t1848, i8* %t1847
  %t1851 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1852 = icmp eq i32 %t1837, 4
  %t1853 = select i1 %t1852, i8* %t1851, i8* %t1850
  %t1854 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1855 = icmp eq i32 %t1837, 5
  %t1856 = select i1 %t1855, i8* %t1854, i8* %t1853
  %t1857 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1858 = icmp eq i32 %t1837, 6
  %t1859 = select i1 %t1858, i8* %t1857, i8* %t1856
  %t1860 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1861 = icmp eq i32 %t1837, 7
  %t1862 = select i1 %t1861, i8* %t1860, i8* %t1859
  %t1863 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1864 = icmp eq i32 %t1837, 8
  %t1865 = select i1 %t1864, i8* %t1863, i8* %t1862
  %t1866 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1867 = icmp eq i32 %t1837, 9
  %t1868 = select i1 %t1867, i8* %t1866, i8* %t1865
  %t1869 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1870 = icmp eq i32 %t1837, 10
  %t1871 = select i1 %t1870, i8* %t1869, i8* %t1868
  %t1872 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1873 = icmp eq i32 %t1837, 11
  %t1874 = select i1 %t1873, i8* %t1872, i8* %t1871
  %t1875 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1876 = icmp eq i32 %t1837, 12
  %t1877 = select i1 %t1876, i8* %t1875, i8* %t1874
  %t1878 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1879 = icmp eq i32 %t1837, 13
  %t1880 = select i1 %t1879, i8* %t1878, i8* %t1877
  %t1881 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1882 = icmp eq i32 %t1837, 14
  %t1883 = select i1 %t1882, i8* %t1881, i8* %t1880
  %t1884 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1885 = icmp eq i32 %t1837, 15
  %t1886 = select i1 %t1885, i8* %t1884, i8* %t1883
  %t1887 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1888 = icmp eq i32 %t1837, 16
  %t1889 = select i1 %t1888, i8* %t1887, i8* %t1886
  %t1890 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1891 = icmp eq i32 %t1837, 17
  %t1892 = select i1 %t1891, i8* %t1890, i8* %t1889
  %t1893 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1894 = icmp eq i32 %t1837, 18
  %t1895 = select i1 %t1894, i8* %t1893, i8* %t1892
  %t1896 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1897 = icmp eq i32 %t1837, 19
  %t1898 = select i1 %t1897, i8* %t1896, i8* %t1895
  %t1899 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1900 = icmp eq i32 %t1837, 20
  %t1901 = select i1 %t1900, i8* %t1899, i8* %t1898
  %t1902 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1903 = icmp eq i32 %t1837, 21
  %t1904 = select i1 %t1903, i8* %t1902, i8* %t1901
  %t1905 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1906 = icmp eq i32 %t1837, 22
  %t1907 = select i1 %t1906, i8* %t1905, i8* %t1904
  %s1908 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h868168677, i32 0, i32 0
  %t1909 = call i1 @strings_equal(i8* %t1907, i8* %s1908)
  br i1 %t1909, label %then46, label %merge47
then46:
  %t1910 = call %NativeState @emit_expression_statement(%NativeState %state, %Statement %statement)
  ret %NativeState %t1910
merge47:
  %s1911 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h1281499904, i32 0, i32 0
  %t1912 = extractvalue %Statement %statement, 0
  %t1913 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1914 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1915 = icmp eq i32 %t1912, 0
  %t1916 = select i1 %t1915, i8* %t1914, i8* %t1913
  %t1917 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1918 = icmp eq i32 %t1912, 1
  %t1919 = select i1 %t1918, i8* %t1917, i8* %t1916
  %t1920 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1921 = icmp eq i32 %t1912, 2
  %t1922 = select i1 %t1921, i8* %t1920, i8* %t1919
  %t1923 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1924 = icmp eq i32 %t1912, 3
  %t1925 = select i1 %t1924, i8* %t1923, i8* %t1922
  %t1926 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1927 = icmp eq i32 %t1912, 4
  %t1928 = select i1 %t1927, i8* %t1926, i8* %t1925
  %t1929 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1930 = icmp eq i32 %t1912, 5
  %t1931 = select i1 %t1930, i8* %t1929, i8* %t1928
  %t1932 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1933 = icmp eq i32 %t1912, 6
  %t1934 = select i1 %t1933, i8* %t1932, i8* %t1931
  %t1935 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1936 = icmp eq i32 %t1912, 7
  %t1937 = select i1 %t1936, i8* %t1935, i8* %t1934
  %t1938 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1939 = icmp eq i32 %t1912, 8
  %t1940 = select i1 %t1939, i8* %t1938, i8* %t1937
  %t1941 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1942 = icmp eq i32 %t1912, 9
  %t1943 = select i1 %t1942, i8* %t1941, i8* %t1940
  %t1944 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1945 = icmp eq i32 %t1912, 10
  %t1946 = select i1 %t1945, i8* %t1944, i8* %t1943
  %t1947 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1948 = icmp eq i32 %t1912, 11
  %t1949 = select i1 %t1948, i8* %t1947, i8* %t1946
  %t1950 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1951 = icmp eq i32 %t1912, 12
  %t1952 = select i1 %t1951, i8* %t1950, i8* %t1949
  %t1953 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1954 = icmp eq i32 %t1912, 13
  %t1955 = select i1 %t1954, i8* %t1953, i8* %t1952
  %t1956 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1957 = icmp eq i32 %t1912, 14
  %t1958 = select i1 %t1957, i8* %t1956, i8* %t1955
  %t1959 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1960 = icmp eq i32 %t1912, 15
  %t1961 = select i1 %t1960, i8* %t1959, i8* %t1958
  %t1962 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1963 = icmp eq i32 %t1912, 16
  %t1964 = select i1 %t1963, i8* %t1962, i8* %t1961
  %t1965 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1966 = icmp eq i32 %t1912, 17
  %t1967 = select i1 %t1966, i8* %t1965, i8* %t1964
  %t1968 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1969 = icmp eq i32 %t1912, 18
  %t1970 = select i1 %t1969, i8* %t1968, i8* %t1967
  %t1971 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1972 = icmp eq i32 %t1912, 19
  %t1973 = select i1 %t1972, i8* %t1971, i8* %t1970
  %t1974 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1975 = icmp eq i32 %t1912, 20
  %t1976 = select i1 %t1975, i8* %t1974, i8* %t1973
  %t1977 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1978 = icmp eq i32 %t1912, 21
  %t1979 = select i1 %t1978, i8* %t1977, i8* %t1976
  %t1980 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1981 = icmp eq i32 %t1912, 22
  %t1982 = select i1 %t1981, i8* %t1980, i8* %t1979
  %t1983 = call i8* @sailfin_runtime_string_concat(i8* %s1911, i8* %t1982)
  %t1984 = alloca [2 x i8], align 1
  %t1985 = getelementptr [2 x i8], [2 x i8]* %t1984, i32 0, i32 0
  store i8 96, i8* %t1985
  %t1986 = getelementptr [2 x i8], [2 x i8]* %t1984, i32 0, i32 1
  store i8 0, i8* %t1986
  %t1987 = getelementptr [2 x i8], [2 x i8]* %t1984, i32 0, i32 0
  %t1988 = call i8* @sailfin_runtime_string_concat(i8* %t1983, i8* %t1987)
  store i8* %t1988, i8** %l4
  %t1989 = load i8*, i8** %l4
  %t1990 = call %NativeState @state_add_diagnostic(%NativeState %state, i8* %t1989)
  ret %NativeState %t1990
}

define i8* @render_native_specifiers({ %ImportSpecifier*, i64 }* %specifiers) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t50 = phi { i8**, i64 }* [ %t13, %block.entry ], [ %t48, %loop.latch2 ]
  %t51 = phi double [ %t14, %block.entry ], [ %t49, %loop.latch2 ]
  store { i8**, i64 }* %t50, { i8**, i64 }** %l0
  store double %t51, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %specifiers
  %t17 = extractvalue { %ImportSpecifier*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load double, double* %l1
  %t24 = call double @llvm.round.f64(double %t23)
  %t25 = fptosi double %t24 to i64
  %t26 = load { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %specifiers
  %t27 = extractvalue { %ImportSpecifier*, i64 } %t26, 0
  %t28 = extractvalue { %ImportSpecifier*, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t25, i64 %t28)
  %t30 = getelementptr %ImportSpecifier, %ImportSpecifier* %t27, i64 %t25
  %t31 = load %ImportSpecifier, %ImportSpecifier* %t30
  %t32 = extractvalue %ImportSpecifier %t31, 0
  %t33 = load double, double* %l1
  %t34 = call double @llvm.round.f64(double %t33)
  %t35 = fptosi double %t34 to i64
  %t36 = load { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %specifiers
  %t37 = extractvalue { %ImportSpecifier*, i64 } %t36, 0
  %t38 = extractvalue { %ImportSpecifier*, i64 } %t36, 1
  %t39 = icmp uge i64 %t35, %t38
  ; bounds check: %t39 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t35, i64 %t38)
  %t40 = getelementptr %ImportSpecifier, %ImportSpecifier* %t37, i64 %t35
  %t41 = load %ImportSpecifier, %ImportSpecifier* %t40
  %t42 = extractvalue %ImportSpecifier %t41, 1
  %t43 = call i8* @format_native_specifier(i8* %t32, i8* %t42)
  %t44 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t22, i8* %t43)
  store { i8**, i64 }* %t44, { i8**, i64 }** %l0
  %t45 = load double, double* %l1
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l1
  br label %loop.latch2
loop.latch2:
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load double, double* %l1
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s55 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t56 = call i8* @join_with_separator({ i8**, i64 }* %t54, i8* %s55)
  call void @sailfin_runtime_mark_persistent(i8* %t56)
  ret i8* %t56
}

define i8* @render_export_specifiers({ %ExportSpecifier*, i64 }* %specifiers) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t50 = phi { i8**, i64 }* [ %t13, %block.entry ], [ %t48, %loop.latch2 ]
  %t51 = phi double [ %t14, %block.entry ], [ %t49, %loop.latch2 ]
  store { i8**, i64 }* %t50, { i8**, i64 }** %l0
  store double %t51, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %specifiers
  %t17 = extractvalue { %ExportSpecifier*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load double, double* %l1
  %t24 = call double @llvm.round.f64(double %t23)
  %t25 = fptosi double %t24 to i64
  %t26 = load { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %specifiers
  %t27 = extractvalue { %ExportSpecifier*, i64 } %t26, 0
  %t28 = extractvalue { %ExportSpecifier*, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t25, i64 %t28)
  %t30 = getelementptr %ExportSpecifier, %ExportSpecifier* %t27, i64 %t25
  %t31 = load %ExportSpecifier, %ExportSpecifier* %t30
  %t32 = extractvalue %ExportSpecifier %t31, 0
  %t33 = load double, double* %l1
  %t34 = call double @llvm.round.f64(double %t33)
  %t35 = fptosi double %t34 to i64
  %t36 = load { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %specifiers
  %t37 = extractvalue { %ExportSpecifier*, i64 } %t36, 0
  %t38 = extractvalue { %ExportSpecifier*, i64 } %t36, 1
  %t39 = icmp uge i64 %t35, %t38
  ; bounds check: %t39 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t35, i64 %t38)
  %t40 = getelementptr %ExportSpecifier, %ExportSpecifier* %t37, i64 %t35
  %t41 = load %ExportSpecifier, %ExportSpecifier* %t40
  %t42 = extractvalue %ExportSpecifier %t41, 1
  %t43 = call i8* @format_native_specifier(i8* %t32, i8* %t42)
  %t44 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t22, i8* %t43)
  store { i8**, i64 }* %t44, { i8**, i64 }** %l0
  %t45 = load double, double* %l1
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l1
  br label %loop.latch2
loop.latch2:
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load double, double* %l1
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s55 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t56 = call i8* @join_with_separator({ i8**, i64 }* %t54, i8* %s55)
  call void @sailfin_runtime_mark_persistent(i8* %t56)
  ret i8* %t56
}

define i8* @format_native_specifier(i8* %name, i8* %alias) {
block.entry:
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
  call void @sailfin_runtime_mark_persistent(i8* %name)
  ret i8* %name
merge1:
  %s5 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175713983, i32 0, i32 0
  %t6 = call i8* @sailfin_runtime_string_concat(i8* %name, i8* %s5)
  %t7 = call i8* @sailfin_runtime_string_concat(i8* %t6, i8* %alias)
  call void @sailfin_runtime_mark_persistent(i8* %t7)
  ret i8* %t7
}

define %NativeState @emit_span_if_present(%NativeState %state, %SourceSpan* %span) {
block.entry:
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
block.entry:
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
block.entry:
  %t0 = icmp eq %TypeAnnotation* %annotation, null
  br i1 %t0, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* %line)
  ret i8* %line
merge1:
  %s1 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087687812, i32 0, i32 0
  %t2 = call i8* @sailfin_runtime_string_concat(i8* %line, i8* %s1)
  %t3 = getelementptr %TypeAnnotation, %TypeAnnotation* %annotation, i32 0, i32 0
  %t4 = load i8*, i8** %t3
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t2, i8* %t4)
  call void @sailfin_runtime_mark_persistent(i8* %t5)
  ret i8* %t5
}

define i8* @append_optional_initializer(i8* %line, %Expression* %initializer) {
block.entry:
  %t0 = icmp eq %Expression* %initializer, null
  br i1 %t0, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* %line)
  ret i8* %line
merge1:
  %s1 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t2 = call i8* @sailfin_runtime_string_concat(i8* %line, i8* %s1)
  %t3 = load %Expression, %Expression* %initializer
  %t4 = call i8* @format_expression(%Expression %t3)
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t2, i8* %t4)
  call void @sailfin_runtime_mark_persistent(i8* %t5)
  ret i8* %t5
}

define i8* @format_span(%SourceSpan %span) {
block.entry:
  %t0 = extractvalue %SourceSpan %span, 0
  %t1 = call i8* @number_to_string(double %t0)
  %t2 = alloca [2 x i8], align 1
  %t3 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  store i8 32, i8* %t3
  %t4 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 1
  store i8 0, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  %t6 = call i8* @sailfin_runtime_string_concat(i8* %t1, i8* %t5)
  %t7 = extractvalue %SourceSpan %span, 1
  %t8 = call i8* @number_to_string(double %t7)
  %t9 = call i8* @sailfin_runtime_string_concat(i8* %t6, i8* %t8)
  %t10 = alloca [2 x i8], align 1
  %t11 = getelementptr [2 x i8], [2 x i8]* %t10, i32 0, i32 0
  store i8 32, i8* %t11
  %t12 = getelementptr [2 x i8], [2 x i8]* %t10, i32 0, i32 1
  store i8 0, i8* %t12
  %t13 = getelementptr [2 x i8], [2 x i8]* %t10, i32 0, i32 0
  %t14 = call i8* @sailfin_runtime_string_concat(i8* %t9, i8* %t13)
  %t15 = extractvalue %SourceSpan %span, 2
  %t16 = call i8* @number_to_string(double %t15)
  %t17 = call i8* @sailfin_runtime_string_concat(i8* %t14, i8* %t16)
  %t18 = alloca [2 x i8], align 1
  %t19 = getelementptr [2 x i8], [2 x i8]* %t18, i32 0, i32 0
  store i8 32, i8* %t19
  %t20 = getelementptr [2 x i8], [2 x i8]* %t18, i32 0, i32 1
  store i8 0, i8* %t20
  %t21 = getelementptr [2 x i8], [2 x i8]* %t18, i32 0, i32 0
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %t17, i8* %t21)
  %t23 = extractvalue %SourceSpan %span, 3
  %t24 = call i8* @number_to_string(double %t23)
  %t25 = call i8* @sailfin_runtime_string_concat(i8* %t22, i8* %t24)
  call void @sailfin_runtime_mark_persistent(i8* %t25)
  ret i8* %t25
}

define %NativeState @emit_variable(%NativeState %state, %Statement %statement) {
block.entry:
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
  %t17 = bitcast [56 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 48
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
  %t51 = phi i8* [ %t50, %then0 ], [ %t46, %block.entry ]
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
  %t68 = bitcast [56 x i8]* %t67 to i8*
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
block.entry:
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
block.entry:
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
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
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
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
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
  %t114 = bitcast [88 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to %FunctionSignature*
  %t116 = load %FunctionSignature, %FunctionSignature* %t115
  %t117 = icmp eq i32 %t111, 4
  %t118 = select i1 %t117, %FunctionSignature %t116, %FunctionSignature zeroinitializer
  %t119 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t120 = bitcast [88 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to %FunctionSignature*
  %t122 = load %FunctionSignature, %FunctionSignature* %t121
  %t123 = icmp eq i32 %t111, 5
  %t124 = select i1 %t123, %FunctionSignature %t122, %FunctionSignature %t118
  %t125 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t126 = bitcast [88 x i8]* %t125 to i8*
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
  %t138 = bitcast [88 x i8]* %t137 to i8*
  %t139 = bitcast i8* %t138 to %FunctionSignature*
  %t140 = load %FunctionSignature, %FunctionSignature* %t139
  %t141 = icmp eq i32 %t135, 4
  %t142 = select i1 %t141, %FunctionSignature %t140, %FunctionSignature zeroinitializer
  %t143 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t144 = bitcast [88 x i8]* %t143 to i8*
  %t145 = bitcast i8* %t144 to %FunctionSignature*
  %t146 = load %FunctionSignature, %FunctionSignature* %t145
  %t147 = icmp eq i32 %t135, 5
  %t148 = select i1 %t147, %FunctionSignature %t146, %FunctionSignature %t142
  %t149 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t150 = bitcast [88 x i8]* %t149 to i8*
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
  %t162 = bitcast [88 x i8]* %t161 to i8*
  %t163 = bitcast i8* %t162 to %FunctionSignature*
  %t164 = load %FunctionSignature, %FunctionSignature* %t163
  %t165 = icmp eq i32 %t159, 4
  %t166 = select i1 %t165, %FunctionSignature %t164, %FunctionSignature zeroinitializer
  %t167 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t168 = bitcast [88 x i8]* %t167 to i8*
  %t169 = bitcast i8* %t168 to %FunctionSignature*
  %t170 = load %FunctionSignature, %FunctionSignature* %t169
  %t171 = icmp eq i32 %t159, 5
  %t172 = select i1 %t171, %FunctionSignature %t170, %FunctionSignature %t166
  %t173 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t174 = bitcast [88 x i8]* %t173 to i8*
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
  %t186 = bitcast [88 x i8]* %t185 to i8*
  %t187 = getelementptr inbounds i8, i8* %t186, i64 56
  %t188 = bitcast i8* %t187 to %Block*
  %t189 = load %Block, %Block* %t188
  %t190 = icmp eq i32 %t183, 4
  %t191 = select i1 %t190, %Block %t189, %Block zeroinitializer
  %t192 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t193 = bitcast [88 x i8]* %t192 to i8*
  %t194 = getelementptr inbounds i8, i8* %t193, i64 56
  %t195 = bitcast i8* %t194 to %Block*
  %t196 = load %Block, %Block* %t195
  %t197 = icmp eq i32 %t183, 5
  %t198 = select i1 %t197, %Block %t196, %Block %t191
  %t199 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t200 = bitcast [56 x i8]* %t199 to i8*
  %t201 = getelementptr inbounds i8, i8* %t200, i64 16
  %t202 = bitcast i8* %t201 to %Block*
  %t203 = load %Block, %Block* %t202
  %t204 = icmp eq i32 %t183, 6
  %t205 = select i1 %t204, %Block %t203, %Block %t198
  %t206 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t207 = bitcast [88 x i8]* %t206 to i8*
  %t208 = getelementptr inbounds i8, i8* %t207, i64 56
  %t209 = bitcast i8* %t208 to %Block*
  %t210 = load %Block, %Block* %t209
  %t211 = icmp eq i32 %t183, 7
  %t212 = select i1 %t211, %Block %t210, %Block %t205
  %t213 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t214 = bitcast [120 x i8]* %t213 to i8*
  %t215 = getelementptr inbounds i8, i8* %t214, i64 88
  %t216 = bitcast i8* %t215 to %Block*
  %t217 = load %Block, %Block* %t216
  %t218 = icmp eq i32 %t183, 12
  %t219 = select i1 %t218, %Block %t217, %Block %t212
  %t220 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t221 = bitcast [40 x i8]* %t220 to i8*
  %t222 = getelementptr inbounds i8, i8* %t221, i64 8
  %t223 = bitcast i8* %t222 to %Block*
  %t224 = load %Block, %Block* %t223
  %t225 = icmp eq i32 %t183, 13
  %t226 = select i1 %t225, %Block %t224, %Block %t219
  %t227 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t228 = bitcast [136 x i8]* %t227 to i8*
  %t229 = getelementptr inbounds i8, i8* %t228, i64 104
  %t230 = bitcast i8* %t229 to %Block*
  %t231 = load %Block, %Block* %t230
  %t232 = icmp eq i32 %t183, 14
  %t233 = select i1 %t232, %Block %t231, %Block %t226
  %t234 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t235 = bitcast [32 x i8]* %t234 to i8*
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
block.entry:
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
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
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
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
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
  %t114 = bitcast [88 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to %FunctionSignature*
  %t116 = load %FunctionSignature, %FunctionSignature* %t115
  %t117 = icmp eq i32 %t111, 4
  %t118 = select i1 %t117, %FunctionSignature %t116, %FunctionSignature zeroinitializer
  %t119 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t120 = bitcast [88 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to %FunctionSignature*
  %t122 = load %FunctionSignature, %FunctionSignature* %t121
  %t123 = icmp eq i32 %t111, 5
  %t124 = select i1 %t123, %FunctionSignature %t122, %FunctionSignature %t118
  %t125 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t126 = bitcast [88 x i8]* %t125 to i8*
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
  %t138 = bitcast [88 x i8]* %t137 to i8*
  %t139 = bitcast i8* %t138 to %FunctionSignature*
  %t140 = load %FunctionSignature, %FunctionSignature* %t139
  %t141 = icmp eq i32 %t135, 4
  %t142 = select i1 %t141, %FunctionSignature %t140, %FunctionSignature zeroinitializer
  %t143 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t144 = bitcast [88 x i8]* %t143 to i8*
  %t145 = bitcast i8* %t144 to %FunctionSignature*
  %t146 = load %FunctionSignature, %FunctionSignature* %t145
  %t147 = icmp eq i32 %t135, 5
  %t148 = select i1 %t147, %FunctionSignature %t146, %FunctionSignature %t142
  %t149 = getelementptr inbounds %Statement, %Statement* %t136, i32 0, i32 1
  %t150 = bitcast [88 x i8]* %t149 to i8*
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
  %t162 = bitcast [88 x i8]* %t161 to i8*
  %t163 = bitcast i8* %t162 to %FunctionSignature*
  %t164 = load %FunctionSignature, %FunctionSignature* %t163
  %t165 = icmp eq i32 %t159, 4
  %t166 = select i1 %t165, %FunctionSignature %t164, %FunctionSignature zeroinitializer
  %t167 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t168 = bitcast [88 x i8]* %t167 to i8*
  %t169 = bitcast i8* %t168 to %FunctionSignature*
  %t170 = load %FunctionSignature, %FunctionSignature* %t169
  %t171 = icmp eq i32 %t159, 5
  %t172 = select i1 %t171, %FunctionSignature %t170, %FunctionSignature %t166
  %t173 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t174 = bitcast [88 x i8]* %t173 to i8*
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
  %t186 = bitcast [88 x i8]* %t185 to i8*
  %t187 = getelementptr inbounds i8, i8* %t186, i64 56
  %t188 = bitcast i8* %t187 to %Block*
  %t189 = load %Block, %Block* %t188
  %t190 = icmp eq i32 %t183, 4
  %t191 = select i1 %t190, %Block %t189, %Block zeroinitializer
  %t192 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t193 = bitcast [88 x i8]* %t192 to i8*
  %t194 = getelementptr inbounds i8, i8* %t193, i64 56
  %t195 = bitcast i8* %t194 to %Block*
  %t196 = load %Block, %Block* %t195
  %t197 = icmp eq i32 %t183, 5
  %t198 = select i1 %t197, %Block %t196, %Block %t191
  %t199 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t200 = bitcast [56 x i8]* %t199 to i8*
  %t201 = getelementptr inbounds i8, i8* %t200, i64 16
  %t202 = bitcast i8* %t201 to %Block*
  %t203 = load %Block, %Block* %t202
  %t204 = icmp eq i32 %t183, 6
  %t205 = select i1 %t204, %Block %t203, %Block %t198
  %t206 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t207 = bitcast [88 x i8]* %t206 to i8*
  %t208 = getelementptr inbounds i8, i8* %t207, i64 56
  %t209 = bitcast i8* %t208 to %Block*
  %t210 = load %Block, %Block* %t209
  %t211 = icmp eq i32 %t183, 7
  %t212 = select i1 %t211, %Block %t210, %Block %t205
  %t213 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t214 = bitcast [120 x i8]* %t213 to i8*
  %t215 = getelementptr inbounds i8, i8* %t214, i64 88
  %t216 = bitcast i8* %t215 to %Block*
  %t217 = load %Block, %Block* %t216
  %t218 = icmp eq i32 %t183, 12
  %t219 = select i1 %t218, %Block %t217, %Block %t212
  %t220 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t221 = bitcast [40 x i8]* %t220 to i8*
  %t222 = getelementptr inbounds i8, i8* %t221, i64 8
  %t223 = bitcast i8* %t222 to %Block*
  %t224 = load %Block, %Block* %t223
  %t225 = icmp eq i32 %t183, 13
  %t226 = select i1 %t225, %Block %t224, %Block %t219
  %t227 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t228 = bitcast [136 x i8]* %t227 to i8*
  %t229 = getelementptr inbounds i8, i8* %t228, i64 104
  %t230 = bitcast i8* %t229 to %Block*
  %t231 = load %Block, %Block* %t230
  %t232 = icmp eq i32 %t183, 14
  %t233 = select i1 %t232, %Block %t231, %Block %t226
  %t234 = getelementptr inbounds %Statement, %Statement* %t184, i32 0, i32 1
  %t235 = bitcast [32 x i8]* %t234 to i8*
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
block.entry:
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
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
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
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
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
  %t125 = bitcast [56 x i8]* %t124 to i8*
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
  %t166 = bitcast [56 x i8]* %t165 to i8*
  %t167 = getelementptr inbounds i8, i8* %t166, i64 40
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
  %t190 = bitcast [56 x i8]* %t189 to i8*
  %t191 = getelementptr inbounds i8, i8* %t190, i64 40
  %t192 = bitcast i8* %t191 to { i8**, i64 }**
  %t193 = load { i8**, i64 }*, { i8**, i64 }** %t192
  %t194 = icmp eq i32 %t180, 6
  %t195 = select i1 %t194, { i8**, i64 }* %t193, { i8**, i64 }* %t188
  %s196 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t197 = call i8* @join_with_separator({ i8**, i64 }* %t195, i8* %s196)
  %t198 = call i8* @sailfin_runtime_string_concat(i8* %t179, i8* %t197)
  %t199 = alloca [2 x i8], align 1
  %t200 = getelementptr [2 x i8], [2 x i8]* %t199, i32 0, i32 0
  store i8 93, i8* %t200
  %t201 = getelementptr [2 x i8], [2 x i8]* %t199, i32 0, i32 1
  store i8 0, i8* %t201
  %t202 = getelementptr [2 x i8], [2 x i8]* %t199, i32 0, i32 0
  %t203 = call i8* @sailfin_runtime_string_concat(i8* %t198, i8* %t202)
  store i8* %t203, i8** %l1
  %t204 = load i8*, i8** %l1
  br label %merge1
merge1:
  %t205 = phi i8* [ %t204, %then0 ], [ %t176, %block.entry ]
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
  %t225 = bitcast [56 x i8]* %t224 to i8*
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
  %t256 = getelementptr [0 x %Parameter*], [0 x %Parameter*]* null, i32 1
  %t257 = ptrtoint [0 x %Parameter*]* %t256 to i64
  %t258 = icmp eq i64 %t257, 0
  %t259 = select i1 %t258, i64 1, i64 %t257
  %t260 = call i8* @malloc(i64 %t259)
  %t261 = bitcast i8* %t260 to %Parameter**
  %t262 = getelementptr { %Parameter**, i64 }, { %Parameter**, i64 }* null, i32 1
  %t263 = ptrtoint { %Parameter**, i64 }* %t262 to i64
  %t264 = call i8* @malloc(i64 %t263)
  %t265 = bitcast i8* %t264 to { %Parameter**, i64 }*
  %t266 = getelementptr { %Parameter**, i64 }, { %Parameter**, i64 }* %t265, i32 0, i32 0
  store %Parameter** %t261, %Parameter*** %t266
  %t267 = getelementptr { %Parameter**, i64 }, { %Parameter**, i64 }* %t265, i32 0, i32 1
  store i64 0, i64* %t267
  %t268 = insertvalue %FunctionSignature %t255, { %Parameter**, i64 }* %t265, 2
  %t269 = bitcast i8* null to %TypeAnnotation*
  %t270 = insertvalue %FunctionSignature %t268, %TypeAnnotation* %t269, 3
  %t271 = extractvalue %Statement %statement, 0
  %t272 = alloca %Statement
  store %Statement %statement, %Statement* %t272
  %t273 = getelementptr inbounds %Statement, %Statement* %t272, i32 0, i32 1
  %t274 = bitcast [48 x i8]* %t273 to i8*
  %t275 = getelementptr inbounds i8, i8* %t274, i64 32
  %t276 = bitcast i8* %t275 to { i8**, i64 }**
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %t276
  %t278 = icmp eq i32 %t271, 3
  %t279 = select i1 %t278, { i8**, i64 }* %t277, { i8**, i64 }* null
  %t280 = getelementptr inbounds %Statement, %Statement* %t272, i32 0, i32 1
  %t281 = bitcast [56 x i8]* %t280 to i8*
  %t282 = getelementptr inbounds i8, i8* %t281, i64 40
  %t283 = bitcast i8* %t282 to { i8**, i64 }**
  %t284 = load { i8**, i64 }*, { i8**, i64 }** %t283
  %t285 = icmp eq i32 %t271, 6
  %t286 = select i1 %t285, { i8**, i64 }* %t284, { i8**, i64 }* %t279
  %t287 = insertvalue %FunctionSignature %t270, { i8**, i64 }* %t286, 4
  %t288 = getelementptr [0 x %TypeParameter*], [0 x %TypeParameter*]* null, i32 1
  %t289 = ptrtoint [0 x %TypeParameter*]* %t288 to i64
  %t290 = icmp eq i64 %t289, 0
  %t291 = select i1 %t290, i64 1, i64 %t289
  %t292 = call i8* @malloc(i64 %t291)
  %t293 = bitcast i8* %t292 to %TypeParameter**
  %t294 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* null, i32 1
  %t295 = ptrtoint { %TypeParameter**, i64 }* %t294 to i64
  %t296 = call i8* @malloc(i64 %t295)
  %t297 = bitcast i8* %t296 to { %TypeParameter**, i64 }*
  %t298 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t297, i32 0, i32 0
  store %TypeParameter** %t293, %TypeParameter*** %t298
  %t299 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t297, i32 0, i32 1
  store i64 0, i64* %t299
  %t300 = insertvalue %FunctionSignature %t287, { %TypeParameter**, i64 }* %t297, 5
  %t301 = bitcast i8* null to %SourceSpan*
  %t302 = insertvalue %FunctionSignature %t300, %SourceSpan* %t301, 6
  %t303 = call %NativeState @emit_signature_metadata(%NativeState %t209, %FunctionSignature %t302)
  store %NativeState %t303, %NativeState* %l0
  %t304 = load %NativeState, %NativeState* %l0
  %t305 = call %NativeState @state_push_indent(%NativeState %t304)
  store %NativeState %t305, %NativeState* %l0
  %t306 = load %NativeState, %NativeState* %l0
  %t307 = extractvalue %Statement %statement, 0
  %t308 = alloca %Statement
  store %Statement %statement, %Statement* %t308
  %t309 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t310 = bitcast [88 x i8]* %t309 to i8*
  %t311 = getelementptr inbounds i8, i8* %t310, i64 56
  %t312 = bitcast i8* %t311 to %Block*
  %t313 = load %Block, %Block* %t312
  %t314 = icmp eq i32 %t307, 4
  %t315 = select i1 %t314, %Block %t313, %Block zeroinitializer
  %t316 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t317 = bitcast [88 x i8]* %t316 to i8*
  %t318 = getelementptr inbounds i8, i8* %t317, i64 56
  %t319 = bitcast i8* %t318 to %Block*
  %t320 = load %Block, %Block* %t319
  %t321 = icmp eq i32 %t307, 5
  %t322 = select i1 %t321, %Block %t320, %Block %t315
  %t323 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t324 = bitcast [56 x i8]* %t323 to i8*
  %t325 = getelementptr inbounds i8, i8* %t324, i64 16
  %t326 = bitcast i8* %t325 to %Block*
  %t327 = load %Block, %Block* %t326
  %t328 = icmp eq i32 %t307, 6
  %t329 = select i1 %t328, %Block %t327, %Block %t322
  %t330 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t331 = bitcast [88 x i8]* %t330 to i8*
  %t332 = getelementptr inbounds i8, i8* %t331, i64 56
  %t333 = bitcast i8* %t332 to %Block*
  %t334 = load %Block, %Block* %t333
  %t335 = icmp eq i32 %t307, 7
  %t336 = select i1 %t335, %Block %t334, %Block %t329
  %t337 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t338 = bitcast [120 x i8]* %t337 to i8*
  %t339 = getelementptr inbounds i8, i8* %t338, i64 88
  %t340 = bitcast i8* %t339 to %Block*
  %t341 = load %Block, %Block* %t340
  %t342 = icmp eq i32 %t307, 12
  %t343 = select i1 %t342, %Block %t341, %Block %t336
  %t344 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t345 = bitcast [40 x i8]* %t344 to i8*
  %t346 = getelementptr inbounds i8, i8* %t345, i64 8
  %t347 = bitcast i8* %t346 to %Block*
  %t348 = load %Block, %Block* %t347
  %t349 = icmp eq i32 %t307, 13
  %t350 = select i1 %t349, %Block %t348, %Block %t343
  %t351 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t352 = bitcast [136 x i8]* %t351 to i8*
  %t353 = getelementptr inbounds i8, i8* %t352, i64 104
  %t354 = bitcast i8* %t353 to %Block*
  %t355 = load %Block, %Block* %t354
  %t356 = icmp eq i32 %t307, 14
  %t357 = select i1 %t356, %Block %t355, %Block %t350
  %t358 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t359 = bitcast [32 x i8]* %t358 to i8*
  %t360 = bitcast i8* %t359 to %Block*
  %t361 = load %Block, %Block* %t360
  %t362 = icmp eq i32 %t307, 15
  %t363 = select i1 %t362, %Block %t361, %Block %t357
  %t364 = call %NativeState @emit_block(%NativeState %t306, %Block %t363)
  store %NativeState %t364, %NativeState* %l0
  %t365 = load %NativeState, %NativeState* %l0
  %t366 = call %NativeState @state_pop_indent(%NativeState %t365)
  store %NativeState %t366, %NativeState* %l0
  %t367 = load %NativeState, %NativeState* %l0
  %s368 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h580338910, i32 0, i32 0
  %t369 = call %NativeState @state_emit_line(%NativeState %t367, i8* %s368)
  ret %NativeState %t369
}

define %NativeState @emit_model(%NativeState %state, %Statement %statement) {
block.entry:
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
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
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
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
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
  %t125 = bitcast [56 x i8]* %t124 to i8*
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
  %t178 = bitcast [56 x i8]* %t177 to i8*
  %t179 = getelementptr inbounds i8, i8* %t178, i64 40
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
  %t202 = bitcast [56 x i8]* %t201 to i8*
  %t203 = getelementptr inbounds i8, i8* %t202, i64 40
  %t204 = bitcast i8* %t203 to { i8**, i64 }**
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %t204
  %t206 = icmp eq i32 %t192, 6
  %t207 = select i1 %t206, { i8**, i64 }* %t205, { i8**, i64 }* %t200
  %s208 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t209 = call i8* @join_with_separator({ i8**, i64 }* %t207, i8* %s208)
  %t210 = call i8* @sailfin_runtime_string_concat(i8* %t191, i8* %t209)
  %t211 = alloca [2 x i8], align 1
  %t212 = getelementptr [2 x i8], [2 x i8]* %t211, i32 0, i32 0
  store i8 93, i8* %t212
  %t213 = getelementptr [2 x i8], [2 x i8]* %t211, i32 0, i32 1
  store i8 0, i8* %t213
  %t214 = getelementptr [2 x i8], [2 x i8]* %t211, i32 0, i32 0
  %t215 = call i8* @sailfin_runtime_string_concat(i8* %t210, i8* %t214)
  store i8* %t215, i8** %l1
  %t216 = load i8*, i8** %l1
  br label %merge1
merge1:
  %t217 = phi i8* [ %t216, %then0 ], [ %t188, %block.entry ]
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
  %t282 = phi %NativeState [ %t224, %merge1 ], [ %t280, %loop.latch4 ]
  %t283 = phi double [ %t226, %merge1 ], [ %t281, %loop.latch4 ]
  store %NativeState %t282, %NativeState* %l0
  store double %t283, double* %l2
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
  %t254 = call double @llvm.round.f64(double %t253)
  %t255 = fptosi double %t254 to i64
  %t256 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t252
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
block.entry:
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
  %t16 = bitcast [56 x i8]* %t15 to i8*
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
  %t104 = bitcast [88 x i8]* %t103 to i8*
  %t105 = getelementptr inbounds i8, i8* %t104, i64 80
  %t106 = bitcast i8* %t105 to { %Decorator**, i64 }**
  %t107 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t106
  %t108 = icmp eq i32 %t94, 4
  %t109 = select i1 %t108, { %Decorator**, i64 }* %t107, { %Decorator**, i64 }* %t102
  %t110 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t111 = bitcast [88 x i8]* %t110 to i8*
  %t112 = getelementptr inbounds i8, i8* %t111, i64 80
  %t113 = bitcast i8* %t112 to { %Decorator**, i64 }**
  %t114 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t113
  %t115 = icmp eq i32 %t94, 5
  %t116 = select i1 %t115, { %Decorator**, i64 }* %t114, { %Decorator**, i64 }* %t109
  %t117 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t118 = bitcast [56 x i8]* %t117 to i8*
  %t119 = getelementptr inbounds i8, i8* %t118, i64 48
  %t120 = bitcast i8* %t119 to { %Decorator**, i64 }**
  %t121 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t120
  %t122 = icmp eq i32 %t94, 6
  %t123 = select i1 %t122, { %Decorator**, i64 }* %t121, { %Decorator**, i64 }* %t116
  %t124 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t125 = bitcast [88 x i8]* %t124 to i8*
  %t126 = getelementptr inbounds i8, i8* %t125, i64 80
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
  %t160 = bitcast [120 x i8]* %t159 to i8*
  %t161 = getelementptr inbounds i8, i8* %t160, i64 112
  %t162 = bitcast i8* %t161 to { %Decorator**, i64 }**
  %t163 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t162
  %t164 = icmp eq i32 %t94, 12
  %t165 = select i1 %t164, { %Decorator**, i64 }* %t163, { %Decorator**, i64 }* %t158
  %t166 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t167 = bitcast [40 x i8]* %t166 to i8*
  %t168 = getelementptr inbounds i8, i8* %t167, i64 32
  %t169 = bitcast i8* %t168 to { %Decorator**, i64 }**
  %t170 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t169
  %t171 = icmp eq i32 %t94, 13
  %t172 = select i1 %t171, { %Decorator**, i64 }* %t170, { %Decorator**, i64 }* %t165
  %t173 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t174 = bitcast [136 x i8]* %t173 to i8*
  %t175 = getelementptr inbounds i8, i8* %t174, i64 128
  %t176 = bitcast i8* %t175 to { %Decorator**, i64 }**
  %t177 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t176
  %t178 = icmp eq i32 %t94, 14
  %t179 = select i1 %t178, { %Decorator**, i64 }* %t177, { %Decorator**, i64 }* %t172
  %t180 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t181 = bitcast [32 x i8]* %t180 to i8*
  %t182 = getelementptr inbounds i8, i8* %t181, i64 24
  %t183 = bitcast i8* %t182 to { %Decorator**, i64 }**
  %t184 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t183
  %t185 = icmp eq i32 %t94, 15
  %t186 = select i1 %t185, { %Decorator**, i64 }* %t184, { %Decorator**, i64 }* %t179
  %t187 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t188 = bitcast [64 x i8]* %t187 to i8*
  %t189 = getelementptr inbounds i8, i8* %t188, i64 56
  %t190 = bitcast i8* %t189 to { %Decorator**, i64 }**
  %t191 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t190
  %t192 = icmp eq i32 %t94, 18
  %t193 = select i1 %t192, { %Decorator**, i64 }* %t191, { %Decorator**, i64 }* %t186
  %t194 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t195 = bitcast [88 x i8]* %t194 to i8*
  %t196 = getelementptr inbounds i8, i8* %t195, i64 80
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
  %t215 = bitcast [88 x i8]* %t214 to i8*
  %t216 = getelementptr inbounds i8, i8* %t215, i64 80
  %t217 = bitcast i8* %t216 to { %Decorator**, i64 }**
  %t218 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t217
  %t219 = icmp eq i32 %t205, 4
  %t220 = select i1 %t219, { %Decorator**, i64 }* %t218, { %Decorator**, i64 }* %t213
  %t221 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t222 = bitcast [88 x i8]* %t221 to i8*
  %t223 = getelementptr inbounds i8, i8* %t222, i64 80
  %t224 = bitcast i8* %t223 to { %Decorator**, i64 }**
  %t225 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t224
  %t226 = icmp eq i32 %t205, 5
  %t227 = select i1 %t226, { %Decorator**, i64 }* %t225, { %Decorator**, i64 }* %t220
  %t228 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t229 = bitcast [56 x i8]* %t228 to i8*
  %t230 = getelementptr inbounds i8, i8* %t229, i64 48
  %t231 = bitcast i8* %t230 to { %Decorator**, i64 }**
  %t232 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t231
  %t233 = icmp eq i32 %t205, 6
  %t234 = select i1 %t233, { %Decorator**, i64 }* %t232, { %Decorator**, i64 }* %t227
  %t235 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t236 = bitcast [88 x i8]* %t235 to i8*
  %t237 = getelementptr inbounds i8, i8* %t236, i64 80
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
  %t271 = bitcast [120 x i8]* %t270 to i8*
  %t272 = getelementptr inbounds i8, i8* %t271, i64 112
  %t273 = bitcast i8* %t272 to { %Decorator**, i64 }**
  %t274 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t273
  %t275 = icmp eq i32 %t205, 12
  %t276 = select i1 %t275, { %Decorator**, i64 }* %t274, { %Decorator**, i64 }* %t269
  %t277 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t278 = bitcast [40 x i8]* %t277 to i8*
  %t279 = getelementptr inbounds i8, i8* %t278, i64 32
  %t280 = bitcast i8* %t279 to { %Decorator**, i64 }**
  %t281 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t280
  %t282 = icmp eq i32 %t205, 13
  %t283 = select i1 %t282, { %Decorator**, i64 }* %t281, { %Decorator**, i64 }* %t276
  %t284 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t285 = bitcast [136 x i8]* %t284 to i8*
  %t286 = getelementptr inbounds i8, i8* %t285, i64 128
  %t287 = bitcast i8* %t286 to { %Decorator**, i64 }**
  %t288 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t287
  %t289 = icmp eq i32 %t205, 14
  %t290 = select i1 %t289, { %Decorator**, i64 }* %t288, { %Decorator**, i64 }* %t283
  %t291 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t292 = bitcast [32 x i8]* %t291 to i8*
  %t293 = getelementptr inbounds i8, i8* %t292, i64 24
  %t294 = bitcast i8* %t293 to { %Decorator**, i64 }**
  %t295 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t294
  %t296 = icmp eq i32 %t205, 15
  %t297 = select i1 %t296, { %Decorator**, i64 }* %t295, { %Decorator**, i64 }* %t290
  %t298 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t299 = bitcast [64 x i8]* %t298 to i8*
  %t300 = getelementptr inbounds i8, i8* %t299, i64 56
  %t301 = bitcast i8* %t300 to { %Decorator**, i64 }**
  %t302 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t301
  %t303 = icmp eq i32 %t205, 18
  %t304 = select i1 %t303, { %Decorator**, i64 }* %t302, { %Decorator**, i64 }* %t297
  %t305 = getelementptr inbounds %Statement, %Statement* %t206, i32 0, i32 1
  %t306 = bitcast [88 x i8]* %t305 to i8*
  %t307 = getelementptr inbounds i8, i8* %t306, i64 80
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
block.entry:
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
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
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
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
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
  %t125 = bitcast [56 x i8]* %t124 to i8*
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
  %t245 = phi %NativeState [ %t195, %block.entry ], [ %t243, %loop.latch2 ]
  %t246 = phi double [ %t197, %block.entry ], [ %t244, %loop.latch2 ]
  store %NativeState %t245, %NativeState* %l0
  store double %t246, double* %l2
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
  %t225 = call double @llvm.round.f64(double %t224)
  %t226 = fptosi double %t225 to i64
  %t227 = load { %FunctionSignature**, i64 }, { %FunctionSignature**, i64 }* %t223
  %t228 = extractvalue { %FunctionSignature**, i64 } %t227, 0
  %t229 = extractvalue { %FunctionSignature**, i64 } %t227, 1
  %t230 = icmp uge i64 %t226, %t229
  ; bounds check: %t230 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t226, i64 %t229)
  %t231 = getelementptr %FunctionSignature*, %FunctionSignature** %t228, i64 %t226
  %t232 = load %FunctionSignature*, %FunctionSignature** %t231
  store %FunctionSignature* %t232, %FunctionSignature** %l3
  %t233 = load %NativeState, %NativeState* %l0
  %s234 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072555103, i32 0, i32 0
  %t235 = load %FunctionSignature*, %FunctionSignature** %l3
  %t236 = load %FunctionSignature, %FunctionSignature* %t235
  %t237 = call i8* @format_function_signature(%FunctionSignature %t236)
  %t238 = call i8* @sailfin_runtime_string_concat(i8* %s234, i8* %t237)
  %t239 = call %NativeState @state_emit_line(%NativeState %t233, i8* %t238)
  store %NativeState %t239, %NativeState* %l0
  %t240 = load double, double* %l2
  %t241 = sitofp i64 1 to double
  %t242 = fadd double %t240, %t241
  store double %t242, double* %l2
  br label %loop.latch2
loop.latch2:
  %t243 = load %NativeState, %NativeState* %l0
  %t244 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t247 = load %NativeState, %NativeState* %l0
  %t248 = load double, double* %l2
  %t249 = extractvalue %Statement %statement, 0
  %t250 = alloca %Statement
  store %Statement %statement, %Statement* %t250
  %t251 = getelementptr inbounds %Statement, %Statement* %t250, i32 0, i32 1
  %t252 = bitcast [40 x i8]* %t251 to i8*
  %t253 = getelementptr inbounds i8, i8* %t252, i64 24
  %t254 = bitcast i8* %t253 to { %FunctionSignature**, i64 }**
  %t255 = load { %FunctionSignature**, i64 }*, { %FunctionSignature**, i64 }** %t254
  %t256 = icmp eq i32 %t249, 10
  %t257 = select i1 %t256, { %FunctionSignature**, i64 }* %t255, { %FunctionSignature**, i64 }* null
  %t258 = load { %FunctionSignature**, i64 }, { %FunctionSignature**, i64 }* %t257
  %t259 = extractvalue { %FunctionSignature**, i64 } %t258, 1
  %t260 = icmp eq i64 %t259, 0
  %t261 = load %NativeState, %NativeState* %l0
  %t262 = load i8*, i8** %l1
  %t263 = load double, double* %l2
  br i1 %t260, label %then6, label %merge7
then6:
  %t264 = load %NativeState, %NativeState* %l0
  %s265 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t266 = call %NativeState @state_emit_line(%NativeState %t264, i8* %s265)
  store %NativeState %t266, %NativeState* %l0
  %t267 = load %NativeState, %NativeState* %l0
  br label %merge7
merge7:
  %t268 = phi %NativeState [ %t267, %then6 ], [ %t261, %afterloop3 ]
  store %NativeState %t268, %NativeState* %l0
  %t269 = load %NativeState, %NativeState* %l0
  %t270 = call %NativeState @state_pop_indent(%NativeState %t269)
  store %NativeState %t270, %NativeState* %l0
  %t271 = load %NativeState, %NativeState* %l0
  %s272 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1382830532, i32 0, i32 0
  %t273 = call %NativeState @state_emit_line(%NativeState %t271, i8* %s272)
  ret %NativeState %t273
}

define %NativeState @emit_enum(%NativeState %state, %Statement %statement) {
block.entry:
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
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
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
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
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
  %t125 = bitcast [56 x i8]* %t124 to i8*
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
  %t256 = phi %NativeState [ %t205, %block.entry ], [ %t254, %loop.latch2 ]
  %t257 = phi double [ %t208, %block.entry ], [ %t255, %loop.latch2 ]
  store %NativeState %t256, %NativeState* %l0
  store double %t257, double* %l3
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
  %t239 = call double @llvm.round.f64(double %t238)
  %t240 = fptosi double %t239 to i64
  %t241 = load { %EnumVariant**, i64 }, { %EnumVariant**, i64 }* %t237
  %t242 = extractvalue { %EnumVariant**, i64 } %t241, 0
  %t243 = extractvalue { %EnumVariant**, i64 } %t241, 1
  %t244 = icmp uge i64 %t240, %t243
  ; bounds check: %t244 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t240, i64 %t243)
  %t245 = getelementptr %EnumVariant*, %EnumVariant** %t242, i64 %t240
  %t246 = load %EnumVariant*, %EnumVariant** %t245
  %t247 = load %EnumVariant, %EnumVariant* %t246
  %t248 = call i8* @format_enum_variant(%EnumVariant %t247)
  %t249 = call i8* @sailfin_runtime_string_concat(i8* %s228, i8* %t248)
  %t250 = call %NativeState @state_emit_line(%NativeState %t227, i8* %t249)
  store %NativeState %t250, %NativeState* %l0
  %t251 = load double, double* %l3
  %t252 = sitofp i64 1 to double
  %t253 = fadd double %t251, %t252
  store double %t253, double* %l3
  br label %loop.latch2
loop.latch2:
  %t254 = load %NativeState, %NativeState* %l0
  %t255 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t258 = load %NativeState, %NativeState* %l0
  %t259 = load double, double* %l3
  %t260 = extractvalue %Statement %statement, 0
  %t261 = alloca %Statement
  store %Statement %statement, %Statement* %t261
  %t262 = getelementptr inbounds %Statement, %Statement* %t261, i32 0, i32 1
  %t263 = bitcast [40 x i8]* %t262 to i8*
  %t264 = getelementptr inbounds i8, i8* %t263, i64 24
  %t265 = bitcast i8* %t264 to { %EnumVariant**, i64 }**
  %t266 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t265
  %t267 = icmp eq i32 %t260, 11
  %t268 = select i1 %t267, { %EnumVariant**, i64 }* %t266, { %EnumVariant**, i64 }* null
  %t269 = load { %EnumVariant**, i64 }, { %EnumVariant**, i64 }* %t268
  %t270 = extractvalue { %EnumVariant**, i64 } %t269, 1
  %t271 = icmp eq i64 %t270, 0
  %t272 = load %NativeState, %NativeState* %l0
  %t273 = load i8*, i8** %l1
  %t274 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t275 = load double, double* %l3
  br i1 %t271, label %then6, label %merge7
then6:
  %t276 = load %NativeState, %NativeState* %l0
  %s277 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t278 = call %NativeState @state_emit_line(%NativeState %t276, i8* %s277)
  store %NativeState %t278, %NativeState* %l0
  %t279 = load %NativeState, %NativeState* %l0
  br label %merge7
merge7:
  %t280 = phi %NativeState [ %t279, %then6 ], [ %t272, %afterloop3 ]
  store %NativeState %t280, %NativeState* %l0
  %t281 = load %NativeState, %NativeState* %l0
  %t282 = call %NativeState @state_pop_indent(%NativeState %t281)
  store %NativeState %t282, %NativeState* %l0
  %t283 = load %NativeState, %NativeState* %l0
  %s284 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h562875475, i32 0, i32 0
  %t285 = call %NativeState @state_emit_line(%NativeState %t283, i8* %s284)
  ret %NativeState %t285
}

define %NativeState @emit_struct(%NativeState %state, %Statement %statement) {
block.entry:
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
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
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
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
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
  %t125 = bitcast [56 x i8]* %t124 to i8*
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
  %t219 = phi i8* [ %t218, %then0 ], [ %t202, %block.entry ]
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
  %t241 = bitcast [56 x i8]* %t240 to i8*
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
  %t341 = phi %NativeState [ %t290, %merge1 ], [ %t339, %loop.latch4 ]
  %t342 = phi double [ %t293, %merge1 ], [ %t340, %loop.latch4 ]
  store %NativeState %t341, %NativeState* %l0
  store double %t342, double* %l3
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
  %t324 = call double @llvm.round.f64(double %t323)
  %t325 = fptosi double %t324 to i64
  %t326 = load { %FieldDeclaration**, i64 }, { %FieldDeclaration**, i64 }* %t322
  %t327 = extractvalue { %FieldDeclaration**, i64 } %t326, 0
  %t328 = extractvalue { %FieldDeclaration**, i64 } %t326, 1
  %t329 = icmp uge i64 %t325, %t328
  ; bounds check: %t329 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t325, i64 %t328)
  %t330 = getelementptr %FieldDeclaration*, %FieldDeclaration** %t327, i64 %t325
  %t331 = load %FieldDeclaration*, %FieldDeclaration** %t330
  %t332 = load %FieldDeclaration, %FieldDeclaration* %t331
  %t333 = call i8* @format_field(%FieldDeclaration %t332)
  %t334 = call i8* @sailfin_runtime_string_concat(i8* %s313, i8* %t333)
  %t335 = call %NativeState @state_emit_line(%NativeState %t312, i8* %t334)
  store %NativeState %t335, %NativeState* %l0
  %t336 = load double, double* %l3
  %t337 = sitofp i64 1 to double
  %t338 = fadd double %t336, %t337
  store double %t338, double* %l3
  br label %loop.latch4
loop.latch4:
  %t339 = load %NativeState, %NativeState* %l0
  %t340 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t343 = load %NativeState, %NativeState* %l0
  %t344 = load double, double* %l3
  %t345 = sitofp i64 0 to double
  store double %t345, double* %l4
  %t346 = load %NativeState, %NativeState* %l0
  %t347 = load i8*, i8** %l1
  %t348 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t349 = load double, double* %l3
  %t350 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t396 = phi %NativeState [ %t346, %afterloop5 ], [ %t394, %loop.latch10 ]
  %t397 = phi double [ %t350, %afterloop5 ], [ %t395, %loop.latch10 ]
  store %NativeState %t396, %NativeState* %l0
  store double %t397, double* %l4
  br label %loop.body9
loop.body9:
  %t351 = load double, double* %l4
  %t352 = extractvalue %Statement %statement, 0
  %t353 = alloca %Statement
  store %Statement %statement, %Statement* %t353
  %t354 = getelementptr inbounds %Statement, %Statement* %t353, i32 0, i32 1
  %t355 = bitcast [56 x i8]* %t354 to i8*
  %t356 = getelementptr inbounds i8, i8* %t355, i64 40
  %t357 = bitcast i8* %t356 to { %MethodDeclaration**, i64 }**
  %t358 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t357
  %t359 = icmp eq i32 %t352, 8
  %t360 = select i1 %t359, { %MethodDeclaration**, i64 }* %t358, { %MethodDeclaration**, i64 }* null
  %t361 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t360
  %t362 = extractvalue { %MethodDeclaration**, i64 } %t361, 1
  %t363 = sitofp i64 %t362 to double
  %t364 = fcmp oge double %t351, %t363
  %t365 = load %NativeState, %NativeState* %l0
  %t366 = load i8*, i8** %l1
  %t367 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t368 = load double, double* %l3
  %t369 = load double, double* %l4
  br i1 %t364, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t370 = load %NativeState, %NativeState* %l0
  %t371 = extractvalue %Statement %statement, 0
  %t372 = alloca %Statement
  store %Statement %statement, %Statement* %t372
  %t373 = getelementptr inbounds %Statement, %Statement* %t372, i32 0, i32 1
  %t374 = bitcast [56 x i8]* %t373 to i8*
  %t375 = getelementptr inbounds i8, i8* %t374, i64 40
  %t376 = bitcast i8* %t375 to { %MethodDeclaration**, i64 }**
  %t377 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t376
  %t378 = icmp eq i32 %t371, 8
  %t379 = select i1 %t378, { %MethodDeclaration**, i64 }* %t377, { %MethodDeclaration**, i64 }* null
  %t380 = load double, double* %l4
  %t381 = call double @llvm.round.f64(double %t380)
  %t382 = fptosi double %t381 to i64
  %t383 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t379
  %t384 = extractvalue { %MethodDeclaration**, i64 } %t383, 0
  %t385 = extractvalue { %MethodDeclaration**, i64 } %t383, 1
  %t386 = icmp uge i64 %t382, %t385
  ; bounds check: %t386 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t382, i64 %t385)
  %t387 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t384, i64 %t382
  %t388 = load %MethodDeclaration*, %MethodDeclaration** %t387
  %t389 = load %MethodDeclaration, %MethodDeclaration* %t388
  %t390 = call %NativeState @emit_method(%NativeState %t370, %MethodDeclaration %t389)
  store %NativeState %t390, %NativeState* %l0
  %t391 = load double, double* %l4
  %t392 = sitofp i64 1 to double
  %t393 = fadd double %t391, %t392
  store double %t393, double* %l4
  br label %loop.latch10
loop.latch10:
  %t394 = load %NativeState, %NativeState* %l0
  %t395 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t398 = load %NativeState, %NativeState* %l0
  %t399 = load double, double* %l4
  %t401 = extractvalue %Statement %statement, 0
  %t402 = alloca %Statement
  store %Statement %statement, %Statement* %t402
  %t403 = getelementptr inbounds %Statement, %Statement* %t402, i32 0, i32 1
  %t404 = bitcast [56 x i8]* %t403 to i8*
  %t405 = getelementptr inbounds i8, i8* %t404, i64 32
  %t406 = bitcast i8* %t405 to { %FieldDeclaration**, i64 }**
  %t407 = load { %FieldDeclaration**, i64 }*, { %FieldDeclaration**, i64 }** %t406
  %t408 = icmp eq i32 %t401, 8
  %t409 = select i1 %t408, { %FieldDeclaration**, i64 }* %t407, { %FieldDeclaration**, i64 }* null
  %t410 = load { %FieldDeclaration**, i64 }, { %FieldDeclaration**, i64 }* %t409
  %t411 = extractvalue { %FieldDeclaration**, i64 } %t410, 1
  %t412 = icmp eq i64 %t411, 0
  br label %logical_and_entry_400

logical_and_entry_400:
  br i1 %t412, label %logical_and_right_400, label %logical_and_merge_400

logical_and_right_400:
  %t413 = extractvalue %Statement %statement, 0
  %t414 = alloca %Statement
  store %Statement %statement, %Statement* %t414
  %t415 = getelementptr inbounds %Statement, %Statement* %t414, i32 0, i32 1
  %t416 = bitcast [56 x i8]* %t415 to i8*
  %t417 = getelementptr inbounds i8, i8* %t416, i64 40
  %t418 = bitcast i8* %t417 to { %MethodDeclaration**, i64 }**
  %t419 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t418
  %t420 = icmp eq i32 %t413, 8
  %t421 = select i1 %t420, { %MethodDeclaration**, i64 }* %t419, { %MethodDeclaration**, i64 }* null
  %t422 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t421
  %t423 = extractvalue { %MethodDeclaration**, i64 } %t422, 1
  %t424 = icmp eq i64 %t423, 0
  br label %logical_and_right_end_400

logical_and_right_end_400:
  br label %logical_and_merge_400

logical_and_merge_400:
  %t425 = phi i1 [ false, %logical_and_entry_400 ], [ %t424, %logical_and_right_end_400 ]
  %t426 = load %NativeState, %NativeState* %l0
  %t427 = load i8*, i8** %l1
  %t428 = load %LayoutEmitResult, %LayoutEmitResult* %l2
  %t429 = load double, double* %l3
  %t430 = load double, double* %l4
  br i1 %t425, label %then14, label %merge15
then14:
  %t431 = load %NativeState, %NativeState* %l0
  %s432 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t433 = call %NativeState @state_emit_line(%NativeState %t431, i8* %s432)
  store %NativeState %t433, %NativeState* %l0
  %t434 = load %NativeState, %NativeState* %l0
  br label %merge15
merge15:
  %t435 = phi %NativeState [ %t434, %then14 ], [ %t426, %logical_and_merge_400 ]
  store %NativeState %t435, %NativeState* %l0
  %t436 = load %NativeState, %NativeState* %l0
  %t437 = call %NativeState @state_pop_indent(%NativeState %t436)
  store %NativeState %t437, %NativeState* %l0
  %t438 = load %NativeState, %NativeState* %l0
  %s439 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h2070880298, i32 0, i32 0
  %t440 = call %NativeState @state_emit_line(%NativeState %t438, i8* %s439)
  ret %NativeState %t440
}

define %NativeState @emit_method(%NativeState %state, %MethodDeclaration %method) {
block.entry:
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
block.entry:
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
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
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
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
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
  %t114 = bitcast [120 x i8]* %t113 to i8*
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
  %t127 = bitcast [88 x i8]* %t126 to i8*
  %t128 = getelementptr inbounds i8, i8* %t127, i64 56
  %t129 = bitcast i8* %t128 to %Block*
  %t130 = load %Block, %Block* %t129
  %t131 = icmp eq i32 %t124, 4
  %t132 = select i1 %t131, %Block %t130, %Block zeroinitializer
  %t133 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t134 = bitcast [88 x i8]* %t133 to i8*
  %t135 = getelementptr inbounds i8, i8* %t134, i64 56
  %t136 = bitcast i8* %t135 to %Block*
  %t137 = load %Block, %Block* %t136
  %t138 = icmp eq i32 %t124, 5
  %t139 = select i1 %t138, %Block %t137, %Block %t132
  %t140 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t141 = bitcast [56 x i8]* %t140 to i8*
  %t142 = getelementptr inbounds i8, i8* %t141, i64 16
  %t143 = bitcast i8* %t142 to %Block*
  %t144 = load %Block, %Block* %t143
  %t145 = icmp eq i32 %t124, 6
  %t146 = select i1 %t145, %Block %t144, %Block %t139
  %t147 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t148 = bitcast [88 x i8]* %t147 to i8*
  %t149 = getelementptr inbounds i8, i8* %t148, i64 56
  %t150 = bitcast i8* %t149 to %Block*
  %t151 = load %Block, %Block* %t150
  %t152 = icmp eq i32 %t124, 7
  %t153 = select i1 %t152, %Block %t151, %Block %t146
  %t154 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t155 = bitcast [120 x i8]* %t154 to i8*
  %t156 = getelementptr inbounds i8, i8* %t155, i64 88
  %t157 = bitcast i8* %t156 to %Block*
  %t158 = load %Block, %Block* %t157
  %t159 = icmp eq i32 %t124, 12
  %t160 = select i1 %t159, %Block %t158, %Block %t153
  %t161 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t162 = bitcast [40 x i8]* %t161 to i8*
  %t163 = getelementptr inbounds i8, i8* %t162, i64 8
  %t164 = bitcast i8* %t163 to %Block*
  %t165 = load %Block, %Block* %t164
  %t166 = icmp eq i32 %t124, 13
  %t167 = select i1 %t166, %Block %t165, %Block %t160
  %t168 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t169 = bitcast [136 x i8]* %t168 to i8*
  %t170 = getelementptr inbounds i8, i8* %t169, i64 104
  %t171 = bitcast i8* %t170 to %Block*
  %t172 = load %Block, %Block* %t171
  %t173 = icmp eq i32 %t124, 14
  %t174 = select i1 %t173, %Block %t172, %Block %t167
  %t175 = getelementptr inbounds %Statement, %Statement* %t125, i32 0, i32 1
  %t176 = bitcast [32 x i8]* %t175 to i8*
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
block.entry:
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
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
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
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
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
  %t168 = phi i8* [ %t112, %block.entry ], [ %t166, %loop.latch2 ]
  %t169 = phi double [ %t113, %block.entry ], [ %t167, %loop.latch2 ]
  store i8* %t168, i8** %l1
  store double %t169, double* %l2
  br label %loop.body1
loop.body1:
  %t114 = load double, double* %l2
  %t115 = extractvalue %Statement %statement, 0
  %t116 = alloca %Statement
  store %Statement %statement, %Statement* %t116
  %t117 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t118 = bitcast [40 x i8]* %t117 to i8*
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
  %t145 = bitcast [40 x i8]* %t144 to i8*
  %t146 = bitcast i8* %t145 to { %WithClause**, i64 }**
  %t147 = load { %WithClause**, i64 }*, { %WithClause**, i64 }** %t146
  %t148 = icmp eq i32 %t142, 13
  %t149 = select i1 %t148, { %WithClause**, i64 }* %t147, { %WithClause**, i64 }* null
  %t150 = load double, double* %l2
  %t151 = call double @llvm.round.f64(double %t150)
  %t152 = fptosi double %t151 to i64
  %t153 = load { %WithClause**, i64 }, { %WithClause**, i64 }* %t149
  %t154 = extractvalue { %WithClause**, i64 } %t153, 0
  %t155 = extractvalue { %WithClause**, i64 } %t153, 1
  %t156 = icmp uge i64 %t152, %t155
  ; bounds check: %t156 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t152, i64 %t155)
  %t157 = getelementptr %WithClause*, %WithClause** %t154, i64 %t152
  %t158 = load %WithClause*, %WithClause** %t157
  %t159 = getelementptr %WithClause, %WithClause* %t158, i32 0, i32 0
  %t160 = load %Expression, %Expression* %t159
  %t161 = call i8* @format_expression(%Expression %t160)
  %t162 = call i8* @sailfin_runtime_string_concat(i8* %t141, i8* %t161)
  store i8* %t162, i8** %l1
  %t163 = load double, double* %l2
  %t164 = sitofp i64 1 to double
  %t165 = fadd double %t163, %t164
  store double %t165, double* %l2
  br label %loop.latch2
loop.latch2:
  %t166 = load i8*, i8** %l1
  %t167 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t170 = load i8*, i8** %l1
  %t171 = load double, double* %l2
  %t172 = load %NativeState, %NativeState* %l0
  %t173 = load i8*, i8** %l1
  %t174 = call %NativeState @state_emit_line(%NativeState %t172, i8* %t173)
  store %NativeState %t174, %NativeState* %l0
  %t175 = load %NativeState, %NativeState* %l0
  %t176 = call %NativeState @state_push_indent(%NativeState %t175)
  store %NativeState %t176, %NativeState* %l0
  %t177 = load %NativeState, %NativeState* %l0
  %t178 = extractvalue %Statement %statement, 0
  %t179 = alloca %Statement
  store %Statement %statement, %Statement* %t179
  %t180 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t181 = bitcast [88 x i8]* %t180 to i8*
  %t182 = getelementptr inbounds i8, i8* %t181, i64 56
  %t183 = bitcast i8* %t182 to %Block*
  %t184 = load %Block, %Block* %t183
  %t185 = icmp eq i32 %t178, 4
  %t186 = select i1 %t185, %Block %t184, %Block zeroinitializer
  %t187 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t188 = bitcast [88 x i8]* %t187 to i8*
  %t189 = getelementptr inbounds i8, i8* %t188, i64 56
  %t190 = bitcast i8* %t189 to %Block*
  %t191 = load %Block, %Block* %t190
  %t192 = icmp eq i32 %t178, 5
  %t193 = select i1 %t192, %Block %t191, %Block %t186
  %t194 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t195 = bitcast [56 x i8]* %t194 to i8*
  %t196 = getelementptr inbounds i8, i8* %t195, i64 16
  %t197 = bitcast i8* %t196 to %Block*
  %t198 = load %Block, %Block* %t197
  %t199 = icmp eq i32 %t178, 6
  %t200 = select i1 %t199, %Block %t198, %Block %t193
  %t201 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t202 = bitcast [88 x i8]* %t201 to i8*
  %t203 = getelementptr inbounds i8, i8* %t202, i64 56
  %t204 = bitcast i8* %t203 to %Block*
  %t205 = load %Block, %Block* %t204
  %t206 = icmp eq i32 %t178, 7
  %t207 = select i1 %t206, %Block %t205, %Block %t200
  %t208 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t209 = bitcast [120 x i8]* %t208 to i8*
  %t210 = getelementptr inbounds i8, i8* %t209, i64 88
  %t211 = bitcast i8* %t210 to %Block*
  %t212 = load %Block, %Block* %t211
  %t213 = icmp eq i32 %t178, 12
  %t214 = select i1 %t213, %Block %t212, %Block %t207
  %t215 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t216 = bitcast [40 x i8]* %t215 to i8*
  %t217 = getelementptr inbounds i8, i8* %t216, i64 8
  %t218 = bitcast i8* %t217 to %Block*
  %t219 = load %Block, %Block* %t218
  %t220 = icmp eq i32 %t178, 13
  %t221 = select i1 %t220, %Block %t219, %Block %t214
  %t222 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t223 = bitcast [136 x i8]* %t222 to i8*
  %t224 = getelementptr inbounds i8, i8* %t223, i64 104
  %t225 = bitcast i8* %t224 to %Block*
  %t226 = load %Block, %Block* %t225
  %t227 = icmp eq i32 %t178, 14
  %t228 = select i1 %t227, %Block %t226, %Block %t221
  %t229 = getelementptr inbounds %Statement, %Statement* %t179, i32 0, i32 1
  %t230 = bitcast [32 x i8]* %t229 to i8*
  %t231 = bitcast i8* %t230 to %Block*
  %t232 = load %Block, %Block* %t231
  %t233 = icmp eq i32 %t178, 15
  %t234 = select i1 %t233, %Block %t232, %Block %t228
  %t235 = call %NativeState @emit_block(%NativeState %t177, %Block %t234)
  store %NativeState %t235, %NativeState* %l0
  %t236 = load %NativeState, %NativeState* %l0
  %t237 = call %NativeState @state_pop_indent(%NativeState %t236)
  store %NativeState %t237, %NativeState* %l0
  %t238 = load %NativeState, %NativeState* %l0
  %s239 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h584041114, i32 0, i32 0
  %t240 = call %NativeState @state_emit_line(%NativeState %t238, i8* %s239)
  ret %NativeState %t240
}

define %NativeState @emit_for(%NativeState %state, %Statement %statement) {
block.entry:
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
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
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
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
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
  %t113 = bitcast [136 x i8]* %t112 to i8*
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
  %t126 = bitcast [136 x i8]* %t125 to i8*
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
  %t143 = bitcast [88 x i8]* %t142 to i8*
  %t144 = getelementptr inbounds i8, i8* %t143, i64 56
  %t145 = bitcast i8* %t144 to %Block*
  %t146 = load %Block, %Block* %t145
  %t147 = icmp eq i32 %t140, 4
  %t148 = select i1 %t147, %Block %t146, %Block zeroinitializer
  %t149 = getelementptr inbounds %Statement, %Statement* %t141, i32 0, i32 1
  %t150 = bitcast [88 x i8]* %t149 to i8*
  %t151 = getelementptr inbounds i8, i8* %t150, i64 56
  %t152 = bitcast i8* %t151 to %Block*
  %t153 = load %Block, %Block* %t152
  %t154 = icmp eq i32 %t140, 5
  %t155 = select i1 %t154, %Block %t153, %Block %t148
  %t156 = getelementptr inbounds %Statement, %Statement* %t141, i32 0, i32 1
  %t157 = bitcast [56 x i8]* %t156 to i8*
  %t158 = getelementptr inbounds i8, i8* %t157, i64 16
  %t159 = bitcast i8* %t158 to %Block*
  %t160 = load %Block, %Block* %t159
  %t161 = icmp eq i32 %t140, 6
  %t162 = select i1 %t161, %Block %t160, %Block %t155
  %t163 = getelementptr inbounds %Statement, %Statement* %t141, i32 0, i32 1
  %t164 = bitcast [88 x i8]* %t163 to i8*
  %t165 = getelementptr inbounds i8, i8* %t164, i64 56
  %t166 = bitcast i8* %t165 to %Block*
  %t167 = load %Block, %Block* %t166
  %t168 = icmp eq i32 %t140, 7
  %t169 = select i1 %t168, %Block %t167, %Block %t162
  %t170 = getelementptr inbounds %Statement, %Statement* %t141, i32 0, i32 1
  %t171 = bitcast [120 x i8]* %t170 to i8*
  %t172 = getelementptr inbounds i8, i8* %t171, i64 88
  %t173 = bitcast i8* %t172 to %Block*
  %t174 = load %Block, %Block* %t173
  %t175 = icmp eq i32 %t140, 12
  %t176 = select i1 %t175, %Block %t174, %Block %t169
  %t177 = getelementptr inbounds %Statement, %Statement* %t141, i32 0, i32 1
  %t178 = bitcast [40 x i8]* %t177 to i8*
  %t179 = getelementptr inbounds i8, i8* %t178, i64 8
  %t180 = bitcast i8* %t179 to %Block*
  %t181 = load %Block, %Block* %t180
  %t182 = icmp eq i32 %t140, 13
  %t183 = select i1 %t182, %Block %t181, %Block %t176
  %t184 = getelementptr inbounds %Statement, %Statement* %t141, i32 0, i32 1
  %t185 = bitcast [136 x i8]* %t184 to i8*
  %t186 = getelementptr inbounds i8, i8* %t185, i64 104
  %t187 = bitcast i8* %t186 to %Block*
  %t188 = load %Block, %Block* %t187
  %t189 = icmp eq i32 %t140, 14
  %t190 = select i1 %t189, %Block %t188, %Block %t183
  %t191 = getelementptr inbounds %Statement, %Statement* %t141, i32 0, i32 1
  %t192 = bitcast [32 x i8]* %t191 to i8*
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
block.entry:
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
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
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
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
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
  %t118 = bitcast [88 x i8]* %t117 to i8*
  %t119 = getelementptr inbounds i8, i8* %t118, i64 56
  %t120 = bitcast i8* %t119 to %Block*
  %t121 = load %Block, %Block* %t120
  %t122 = icmp eq i32 %t115, 4
  %t123 = select i1 %t122, %Block %t121, %Block zeroinitializer
  %t124 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t125 = bitcast [88 x i8]* %t124 to i8*
  %t126 = getelementptr inbounds i8, i8* %t125, i64 56
  %t127 = bitcast i8* %t126 to %Block*
  %t128 = load %Block, %Block* %t127
  %t129 = icmp eq i32 %t115, 5
  %t130 = select i1 %t129, %Block %t128, %Block %t123
  %t131 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t132 = bitcast [56 x i8]* %t131 to i8*
  %t133 = getelementptr inbounds i8, i8* %t132, i64 16
  %t134 = bitcast i8* %t133 to %Block*
  %t135 = load %Block, %Block* %t134
  %t136 = icmp eq i32 %t115, 6
  %t137 = select i1 %t136, %Block %t135, %Block %t130
  %t138 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t139 = bitcast [88 x i8]* %t138 to i8*
  %t140 = getelementptr inbounds i8, i8* %t139, i64 56
  %t141 = bitcast i8* %t140 to %Block*
  %t142 = load %Block, %Block* %t141
  %t143 = icmp eq i32 %t115, 7
  %t144 = select i1 %t143, %Block %t142, %Block %t137
  %t145 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t146 = bitcast [120 x i8]* %t145 to i8*
  %t147 = getelementptr inbounds i8, i8* %t146, i64 88
  %t148 = bitcast i8* %t147 to %Block*
  %t149 = load %Block, %Block* %t148
  %t150 = icmp eq i32 %t115, 12
  %t151 = select i1 %t150, %Block %t149, %Block %t144
  %t152 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t153 = bitcast [40 x i8]* %t152 to i8*
  %t154 = getelementptr inbounds i8, i8* %t153, i64 8
  %t155 = bitcast i8* %t154 to %Block*
  %t156 = load %Block, %Block* %t155
  %t157 = icmp eq i32 %t115, 13
  %t158 = select i1 %t157, %Block %t156, %Block %t151
  %t159 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t160 = bitcast [136 x i8]* %t159 to i8*
  %t161 = getelementptr inbounds i8, i8* %t160, i64 104
  %t162 = bitcast i8* %t161 to %Block*
  %t163 = load %Block, %Block* %t162
  %t164 = icmp eq i32 %t115, 14
  %t165 = select i1 %t164, %Block %t163, %Block %t158
  %t166 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t167 = bitcast [32 x i8]* %t166 to i8*
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
block.entry:
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
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
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
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
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
  %t114 = bitcast [64 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to %Expression*
  %t116 = load %Expression, %Expression* %t115
  %t117 = icmp eq i32 %t111, 18
  %t118 = select i1 %t117, %Expression %t116, %Expression zeroinitializer
  %t119 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t120 = bitcast [56 x i8]* %t119 to i8*
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
  %t175 = phi %NativeState [ %t131, %block.entry ], [ %t173, %loop.latch2 ]
  %t176 = phi double [ %t132, %block.entry ], [ %t174, %loop.latch2 ]
  store %NativeState %t175, %NativeState* %l0
  store double %t176, double* %l1
  br label %loop.body1
loop.body1:
  %t133 = load double, double* %l1
  %t134 = extractvalue %Statement %statement, 0
  %t135 = alloca %Statement
  store %Statement %statement, %Statement* %t135
  %t136 = getelementptr inbounds %Statement, %Statement* %t135, i32 0, i32 1
  %t137 = bitcast [64 x i8]* %t136 to i8*
  %t138 = getelementptr inbounds i8, i8* %t137, i64 48
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
  %t153 = bitcast [64 x i8]* %t152 to i8*
  %t154 = getelementptr inbounds i8, i8* %t153, i64 48
  %t155 = bitcast i8* %t154 to { %MatchCase**, i64 }**
  %t156 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t155
  %t157 = icmp eq i32 %t150, 18
  %t158 = select i1 %t157, { %MatchCase**, i64 }* %t156, { %MatchCase**, i64 }* null
  %t159 = load double, double* %l1
  %t160 = call double @llvm.round.f64(double %t159)
  %t161 = fptosi double %t160 to i64
  %t162 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t158
  %t163 = extractvalue { %MatchCase**, i64 } %t162, 0
  %t164 = extractvalue { %MatchCase**, i64 } %t162, 1
  %t165 = icmp uge i64 %t161, %t164
  ; bounds check: %t165 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t161, i64 %t164)
  %t166 = getelementptr %MatchCase*, %MatchCase** %t163, i64 %t161
  %t167 = load %MatchCase*, %MatchCase** %t166
  %t168 = load %MatchCase, %MatchCase* %t167
  %t169 = call %NativeState @emit_match_case(%NativeState %t149, %MatchCase %t168)
  store %NativeState %t169, %NativeState* %l0
  %t170 = load double, double* %l1
  %t171 = sitofp i64 1 to double
  %t172 = fadd double %t170, %t171
  store double %t172, double* %l1
  br label %loop.latch2
loop.latch2:
  %t173 = load %NativeState, %NativeState* %l0
  %t174 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t177 = load %NativeState, %NativeState* %l0
  %t178 = load double, double* %l1
  %t179 = extractvalue %Statement %statement, 0
  %t180 = alloca %Statement
  store %Statement %statement, %Statement* %t180
  %t181 = getelementptr inbounds %Statement, %Statement* %t180, i32 0, i32 1
  %t182 = bitcast [64 x i8]* %t181 to i8*
  %t183 = getelementptr inbounds i8, i8* %t182, i64 48
  %t184 = bitcast i8* %t183 to { %MatchCase**, i64 }**
  %t185 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t184
  %t186 = icmp eq i32 %t179, 18
  %t187 = select i1 %t186, { %MatchCase**, i64 }* %t185, { %MatchCase**, i64 }* null
  %t188 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t187
  %t189 = extractvalue { %MatchCase**, i64 } %t188, 1
  %t190 = icmp eq i64 %t189, 0
  %t191 = load %NativeState, %NativeState* %l0
  %t192 = load double, double* %l1
  br i1 %t190, label %then6, label %merge7
then6:
  %t193 = load %NativeState, %NativeState* %l0
  %s194 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t195 = call %NativeState @state_emit_line(%NativeState %t193, i8* %s194)
  store %NativeState %t195, %NativeState* %l0
  %t196 = load %NativeState, %NativeState* %l0
  br label %merge7
merge7:
  %t197 = phi %NativeState [ %t196, %then6 ], [ %t191, %afterloop3 ]
  store %NativeState %t197, %NativeState* %l0
  %t198 = load %NativeState, %NativeState* %l0
  %t199 = call %NativeState @state_pop_indent(%NativeState %t198)
  store %NativeState %t199, %NativeState* %l0
  %t200 = load %NativeState, %NativeState* %l0
  %s201 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1692644020, i32 0, i32 0
  %t202 = call %NativeState @state_emit_line(%NativeState %t200, i8* %s201)
  ret %NativeState %t202
}

define %NativeState @emit_match_case(%NativeState %state, %MatchCase %case) {
block.entry:
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
block.entry:
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
  %t86 = call i1 @strings_equal(i8* %t84, i8* %s85)
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
  %t163 = call i1 @strings_equal(i8* %t161, i8* %s162)
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
block.entry:
  %l0 = alloca i8*
  %t0 = call i8* @format_match_case_head(%MatchCase %case)
  %s1 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h174362534, i32 0, i32 0
  %t2 = call i8* @sailfin_runtime_string_concat(i8* %t0, i8* %s1)
  %t3 = call i8* @format_inline_case_body(%Statement %statement)
  %t4 = call i8* @sailfin_runtime_string_concat(i8* %t2, i8* %t3)
  store i8* %t4, i8** %l0
  %t5 = load i8*, i8** %l0
  %t6 = alloca [2 x i8], align 1
  %t7 = getelementptr [2 x i8], [2 x i8]* %t6, i32 0, i32 0
  store i8 44, i8* %t7
  %t8 = getelementptr [2 x i8], [2 x i8]* %t6, i32 0, i32 1
  store i8 0, i8* %t8
  %t9 = getelementptr [2 x i8], [2 x i8]* %t6, i32 0, i32 0
  %t10 = call i8* @sailfin_runtime_string_concat(i8* %t5, i8* %t9)
  %t11 = call %NativeState @state_emit_line(%NativeState %state, i8* %t10)
  ret %NativeState %t11
}

define i8* @format_match_case_head(%MatchCase %case) {
block.entry:
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
  call void @sailfin_runtime_mark_persistent(i8* %t7)
  ret i8* %t7
merge1:
  %t8 = load i8*, i8** %l0
  %s9 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175987322, i32 0, i32 0
  %t10 = call i8* @sailfin_runtime_string_concat(i8* %t8, i8* %s9)
  %t11 = load %Expression*, %Expression** %l1
  %t12 = load %Expression, %Expression* %t11
  %t13 = call i8* @format_expression(%Expression %t12)
  %t14 = call i8* @sailfin_runtime_string_concat(i8* %t10, i8* %t13)
  call void @sailfin_runtime_mark_persistent(i8* %t14)
  ret i8* %t14
}

define i8* @format_inline_case_body(%Statement %statement) {
block.entry:
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
  %t72 = call i1 @strings_equal(i8* %t70, i8* %s71)
  br i1 %t72, label %then0, label %merge1
then0:
  %t73 = extractvalue %Statement %statement, 0
  %t74 = alloca %Statement
  store %Statement %statement, %Statement* %t74
  %t75 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t76 = bitcast [64 x i8]* %t75 to i8*
  %t77 = bitcast i8* %t76 to %Expression*
  %t78 = load %Expression, %Expression* %t77
  %t79 = icmp eq i32 %t73, 18
  %t80 = select i1 %t79, %Expression %t78, %Expression zeroinitializer
  %t81 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t82 = bitcast [56 x i8]* %t81 to i8*
  %t83 = bitcast i8* %t82 to %Expression*
  %t84 = load %Expression, %Expression* %t83
  %t85 = icmp eq i32 %t73, 21
  %t86 = select i1 %t85, %Expression %t84, %Expression %t80
  %t87 = call i8* @format_expression(%Expression %t86)
  call void @sailfin_runtime_mark_persistent(i8* %t87)
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
  %t160 = call i1 @strings_equal(i8* %t158, i8* %s159)
  br i1 %t160, label %then2, label %merge3
then2:
  %t161 = extractvalue %Statement %statement, 0
  %t162 = alloca %Statement
  store %Statement %statement, %Statement* %t162
  %t163 = getelementptr inbounds %Statement, %Statement* %t162, i32 0, i32 1
  %t164 = bitcast [64 x i8]* %t163 to i8*
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
  %t175 = bitcast [56 x i8]* %t174 to i8*
  %t176 = bitcast i8* %t175 to %Expression*
  %t177 = icmp eq i32 %t161, 21
  %t178 = select i1 %t177, %Expression* %t176, %Expression* %t173
  %t179 = icmp eq %Expression* %t178, null
  br i1 %t179, label %then4, label %merge5
then4:
  %s180 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1061063223, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s180)
  ret i8* %s180
merge5:
  %s181 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h655348872, i32 0, i32 0
  %t182 = extractvalue %Statement %statement, 0
  %t183 = alloca %Statement
  store %Statement %statement, %Statement* %t183
  %t184 = getelementptr inbounds %Statement, %Statement* %t183, i32 0, i32 1
  %t185 = bitcast [64 x i8]* %t184 to i8*
  %t186 = bitcast i8* %t185 to %Expression*
  %t187 = load %Expression, %Expression* %t186
  %t188 = icmp eq i32 %t182, 18
  %t189 = select i1 %t188, %Expression %t187, %Expression zeroinitializer
  %t190 = getelementptr inbounds %Statement, %Statement* %t183, i32 0, i32 1
  %t191 = bitcast [56 x i8]* %t190 to i8*
  %t192 = bitcast i8* %t191 to %Expression*
  %t193 = load %Expression, %Expression* %t192
  %t194 = icmp eq i32 %t182, 21
  %t195 = select i1 %t194, %Expression %t193, %Expression %t189
  %t196 = call i8* @format_expression(%Expression %t195)
  %t197 = call i8* @sailfin_runtime_string_concat(i8* %s181, i8* %t196)
  call void @sailfin_runtime_mark_persistent(i8* %t197)
  ret i8* %t197
merge3:
  %s198 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s198)
  ret i8* %s198
}

define %NativeState @emit_if(%NativeState %state, %Statement %statement) {
block.entry:
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
  %t10 = bitcast [88 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 80
  %t12 = bitcast i8* %t11 to { %Decorator**, i64 }**
  %t13 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 4
  %t15 = select i1 %t14, { %Decorator**, i64 }* %t13, { %Decorator**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [88 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 80
  %t19 = bitcast i8* %t18 to { %Decorator**, i64 }**
  %t20 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 5
  %t22 = select i1 %t21, { %Decorator**, i64 }* %t20, { %Decorator**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [56 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 48
  %t26 = bitcast i8* %t25 to { %Decorator**, i64 }**
  %t27 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 6
  %t29 = select i1 %t28, { %Decorator**, i64 }* %t27, { %Decorator**, i64 }* %t22
  %t30 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t31 = bitcast [88 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 80
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
  %t66 = bitcast [120 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 112
  %t68 = bitcast i8* %t67 to { %Decorator**, i64 }**
  %t69 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t68
  %t70 = icmp eq i32 %t0, 12
  %t71 = select i1 %t70, { %Decorator**, i64 }* %t69, { %Decorator**, i64 }* %t64
  %t72 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 32
  %t75 = bitcast i8* %t74 to { %Decorator**, i64 }**
  %t76 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t75
  %t77 = icmp eq i32 %t0, 13
  %t78 = select i1 %t77, { %Decorator**, i64 }* %t76, { %Decorator**, i64 }* %t71
  %t79 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t80 = bitcast [136 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 128
  %t82 = bitcast i8* %t81 to { %Decorator**, i64 }**
  %t83 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t82
  %t84 = icmp eq i32 %t0, 14
  %t85 = select i1 %t84, { %Decorator**, i64 }* %t83, { %Decorator**, i64 }* %t78
  %t86 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t87 = bitcast [32 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 24
  %t89 = bitcast i8* %t88 to { %Decorator**, i64 }**
  %t90 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t89
  %t91 = icmp eq i32 %t0, 15
  %t92 = select i1 %t91, { %Decorator**, i64 }* %t90, { %Decorator**, i64 }* %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t94 = bitcast [64 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 56
  %t96 = bitcast i8* %t95 to { %Decorator**, i64 }**
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t96
  %t98 = icmp eq i32 %t0, 18
  %t99 = select i1 %t98, { %Decorator**, i64 }* %t97, { %Decorator**, i64 }* %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 80
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
  %t114 = bitcast [88 x i8]* %t113 to i8*
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
  %t128 = bitcast [88 x i8]* %t127 to i8*
  %t129 = getelementptr inbounds i8, i8* %t128, i64 48
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
  %t140 = bitcast [88 x i8]* %t139 to i8*
  %t141 = getelementptr inbounds i8, i8* %t140, i64 72
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
block.entry:
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
block.entry:
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
  %t17 = bitcast [56 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 48
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
  %t27 = bitcast [64 x i8]* %t26 to i8*
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
  %t38 = bitcast [56 x i8]* %t37 to i8*
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
  %t52 = bitcast [64 x i8]* %t51 to i8*
  %t53 = bitcast i8* %t52 to %Expression*
  %t54 = load %Expression, %Expression* %t53
  %t55 = icmp eq i32 %t49, 18
  %t56 = select i1 %t55, %Expression %t54, %Expression zeroinitializer
  %t57 = getelementptr inbounds %Statement, %Statement* %t50, i32 0, i32 1
  %t58 = bitcast [56 x i8]* %t57 to i8*
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
block.entry:
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
  %t17 = bitcast [56 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 48
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
  %t29 = bitcast [64 x i8]* %t28 to i8*
  %t30 = bitcast i8* %t29 to %Expression*
  %t31 = load %Expression, %Expression* %t30
  %t32 = icmp eq i32 %t26, 18
  %t33 = select i1 %t32, %Expression %t31, %Expression zeroinitializer
  %t34 = getelementptr inbounds %Statement, %Statement* %t27, i32 0, i32 1
  %t35 = bitcast [56 x i8]* %t34 to i8*
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
block.entry:
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
  %t35 = phi %NativeState [ %t7, %merge1 ], [ %t33, %loop.latch4 ]
  %t36 = phi double [ %t8, %merge1 ], [ %t34, %loop.latch4 ]
  store %NativeState %t35, %NativeState* %l0
  store double %t36, double* %l1
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
  %t20 = call double @llvm.round.f64(double %t19)
  %t21 = fptosi double %t20 to i64
  %t22 = load { %Statement**, i64 }, { %Statement**, i64 }* %t18
  %t23 = extractvalue { %Statement**, i64 } %t22, 0
  %t24 = extractvalue { %Statement**, i64 } %t22, 1
  %t25 = icmp uge i64 %t21, %t24
  ; bounds check: %t25 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t21, i64 %t24)
  %t26 = getelementptr %Statement*, %Statement** %t23, i64 %t21
  %t27 = load %Statement*, %Statement** %t26
  %t28 = load %Statement, %Statement* %t27
  %t29 = call %NativeState @emit_statement(%NativeState %t17, %Statement %t28)
  store %NativeState %t29, %NativeState* %l0
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch4
loop.latch4:
  %t33 = load %NativeState, %NativeState* %l0
  %t34 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t37 = load %NativeState, %NativeState* %l0
  %t38 = load double, double* %l1
  %t39 = load %NativeState, %NativeState* %l0
  ret %NativeState %t39
}

define %NativeState @emit_decorators(%NativeState %state, { %Decorator*, i64 }* %decorators) {
block.entry:
  %l0 = alloca %NativeState
  %l1 = alloca double
  store %NativeState %state, %NativeState* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load %NativeState, %NativeState* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t29 = phi %NativeState [ %t1, %block.entry ], [ %t27, %loop.latch2 ]
  %t30 = phi double [ %t2, %block.entry ], [ %t28, %loop.latch2 ]
  store %NativeState %t29, %NativeState* %l0
  store double %t30, double* %l1
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
  %t13 = call double @llvm.round.f64(double %t12)
  %t14 = fptosi double %t13 to i64
  %t15 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %decorators
  %t16 = extractvalue { %Decorator*, i64 } %t15, 0
  %t17 = extractvalue { %Decorator*, i64 } %t15, 1
  %t18 = icmp uge i64 %t14, %t17
  ; bounds check: %t18 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t14, i64 %t17)
  %t19 = getelementptr %Decorator, %Decorator* %t16, i64 %t14
  %t20 = load %Decorator, %Decorator* %t19
  %t21 = call i8* @format_decorator(%Decorator %t20)
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %s11, i8* %t21)
  %t23 = call %NativeState @state_emit_line(%NativeState %t10, i8* %t22)
  store %NativeState %t23, %NativeState* %l0
  %t24 = load double, double* %l1
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l1
  br label %loop.latch2
loop.latch2:
  %t27 = load %NativeState, %NativeState* %l0
  %t28 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t31 = load %NativeState, %NativeState* %l0
  %t32 = load double, double* %l1
  %t33 = load %NativeState, %NativeState* %l0
  ret %NativeState %t33
}

define %NativeState @emit_signature_metadata(%NativeState %state, %FunctionSignature %signature) {
block.entry:
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
block.entry:
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
  %t81 = phi %NativeState [ %t1, %block.entry ], [ %t79, %loop.latch2 ]
  %t82 = phi double [ %t2, %block.entry ], [ %t80, %loop.latch2 ]
  store %NativeState %t81, %NativeState* %l0
  store double %t82, double* %l1
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
  %t11 = call double @llvm.round.f64(double %t10)
  %t12 = fptosi double %t11 to i64
  %t13 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t14 = extractvalue { %Parameter*, i64 } %t13, 0
  %t15 = extractvalue { %Parameter*, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t12, i64 %t15)
  %t17 = getelementptr %Parameter, %Parameter* %t14, i64 %t12
  %t18 = load %Parameter, %Parameter* %t17
  store %Parameter %t18, %Parameter* %l2
  %t19 = load %NativeState, %NativeState* %l0
  %t20 = load %Parameter, %Parameter* %l2
  %t21 = extractvalue %Parameter %t20, 4
  %t22 = call %NativeState @emit_span_if_present(%NativeState %t19, %SourceSpan* %t21)
  store %NativeState %t22, %NativeState* %l0
  %s23 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h130169768, i32 0, i32 0
  store i8* %s23, i8** %l3
  %t24 = load %Parameter, %Parameter* %l2
  %t25 = extractvalue %Parameter %t24, 3
  %t26 = load %NativeState, %NativeState* %l0
  %t27 = load double, double* %l1
  %t28 = load %Parameter, %Parameter* %l2
  %t29 = load i8*, i8** %l3
  br i1 %t25, label %then6, label %merge7
then6:
  %t30 = load i8*, i8** %l3
  %s31 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t32 = call i8* @sailfin_runtime_string_concat(i8* %t30, i8* %s31)
  store i8* %t32, i8** %l3
  %t33 = load i8*, i8** %l3
  br label %merge7
merge7:
  %t34 = phi i8* [ %t33, %then6 ], [ %t29, %merge5 ]
  store i8* %t34, i8** %l3
  %t35 = load i8*, i8** %l3
  %t36 = load %Parameter, %Parameter* %l2
  %t37 = extractvalue %Parameter %t36, 0
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %t35, i8* %t37)
  store i8* %t38, i8** %l3
  %t39 = load %Parameter, %Parameter* %l2
  %t40 = extractvalue %Parameter %t39, 1
  %t41 = icmp ne %TypeAnnotation* %t40, null
  %t42 = load %NativeState, %NativeState* %l0
  %t43 = load double, double* %l1
  %t44 = load %Parameter, %Parameter* %l2
  %t45 = load i8*, i8** %l3
  br i1 %t41, label %then8, label %merge9
then8:
  %t46 = load i8*, i8** %l3
  %s47 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h173787542, i32 0, i32 0
  %t48 = call i8* @sailfin_runtime_string_concat(i8* %t46, i8* %s47)
  %t49 = load %Parameter, %Parameter* %l2
  %t50 = extractvalue %Parameter %t49, 1
  %t51 = getelementptr %TypeAnnotation, %TypeAnnotation* %t50, i32 0, i32 0
  %t52 = load i8*, i8** %t51
  %t53 = call i8* @sailfin_runtime_string_concat(i8* %t48, i8* %t52)
  store i8* %t53, i8** %l3
  %t54 = load i8*, i8** %l3
  br label %merge9
merge9:
  %t55 = phi i8* [ %t54, %then8 ], [ %t45, %merge7 ]
  store i8* %t55, i8** %l3
  %t56 = load %Parameter, %Parameter* %l2
  %t57 = extractvalue %Parameter %t56, 2
  %t58 = icmp ne %Expression* %t57, null
  %t59 = load %NativeState, %NativeState* %l0
  %t60 = load double, double* %l1
  %t61 = load %Parameter, %Parameter* %l2
  %t62 = load i8*, i8** %l3
  br i1 %t58, label %then10, label %merge11
then10:
  %t63 = load i8*, i8** %l3
  %s64 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t65 = call i8* @sailfin_runtime_string_concat(i8* %t63, i8* %s64)
  %t66 = load %Parameter, %Parameter* %l2
  %t67 = extractvalue %Parameter %t66, 2
  %t68 = load %Expression, %Expression* %t67
  %t69 = call i8* @format_expression(%Expression %t68)
  %t70 = call i8* @sailfin_runtime_string_concat(i8* %t65, i8* %t69)
  store i8* %t70, i8** %l3
  %t71 = load i8*, i8** %l3
  br label %merge11
merge11:
  %t72 = phi i8* [ %t71, %then10 ], [ %t62, %merge9 ]
  store i8* %t72, i8** %l3
  %t73 = load %NativeState, %NativeState* %l0
  %t74 = load i8*, i8** %l3
  %t75 = call %NativeState @state_emit_line(%NativeState %t73, i8* %t74)
  store %NativeState %t75, %NativeState* %l0
  %t76 = load double, double* %l1
  %t77 = sitofp i64 1 to double
  %t78 = fadd double %t76, %t77
  store double %t78, double* %l1
  br label %loop.latch2
loop.latch2:
  %t79 = load %NativeState, %NativeState* %l0
  %t80 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t83 = load %NativeState, %NativeState* %l0
  %t84 = load double, double* %l1
  %t85 = load %NativeState, %NativeState* %l0
  ret %NativeState %t85
}

define i8* @format_decorator(%Decorator %decorator) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %DecoratorArgument*
  %l4 = alloca i8*
  %t0 = extractvalue %Decorator %decorator, 0
  %t1 = alloca [2 x i8], align 1
  %t2 = getelementptr [2 x i8], [2 x i8]* %t1, i32 0, i32 0
  store i8 64, i8* %t2
  %t3 = getelementptr [2 x i8], [2 x i8]* %t1, i32 0, i32 1
  store i8 0, i8* %t3
  %t4 = getelementptr [2 x i8], [2 x i8]* %t1, i32 0, i32 0
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t4, i8* %t0)
  store i8* %t5, i8** %l0
  %t6 = extractvalue %Decorator %decorator, 1
  %t7 = load { %DecoratorArgument**, i64 }, { %DecoratorArgument**, i64 }* %t6
  %t8 = extractvalue { %DecoratorArgument**, i64 } %t7, 1
  %t9 = icmp eq i64 %t8, 0
  %t10 = load i8*, i8** %l0
  br i1 %t9, label %then0, label %merge1
then0:
  %t11 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t11)
  ret i8* %t11
merge1:
  %t12 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t13 = ptrtoint [0 x i8*]* %t12 to i64
  %t14 = icmp eq i64 %t13, 0
  %t15 = select i1 %t14, i64 1, i64 %t13
  %t16 = call i8* @malloc(i64 %t15)
  %t17 = bitcast i8* %t16 to i8**
  %t18 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t19 = ptrtoint { i8**, i64 }* %t18 to i64
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to { i8**, i64 }*
  %t22 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 0
  store i8** %t17, i8*** %t22
  %t23 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 1
  store i64 0, i64* %t23
  store { i8**, i64 }* %t21, { i8**, i64 }** %l1
  %t24 = sitofp i64 0 to double
  store double %t24, double* %l2
  %t25 = load i8*, i8** %l0
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t27 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t83 = phi { i8**, i64 }* [ %t26, %merge1 ], [ %t81, %loop.latch4 ]
  %t84 = phi double [ %t27, %merge1 ], [ %t82, %loop.latch4 ]
  store { i8**, i64 }* %t83, { i8**, i64 }** %l1
  store double %t84, double* %l2
  br label %loop.body3
loop.body3:
  %t28 = load double, double* %l2
  %t29 = extractvalue %Decorator %decorator, 1
  %t30 = load { %DecoratorArgument**, i64 }, { %DecoratorArgument**, i64 }* %t29
  %t31 = extractvalue { %DecoratorArgument**, i64 } %t30, 1
  %t32 = sitofp i64 %t31 to double
  %t33 = fcmp oge double %t28, %t32
  %t34 = load i8*, i8** %l0
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t36 = load double, double* %l2
  br i1 %t33, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t37 = extractvalue %Decorator %decorator, 1
  %t38 = load double, double* %l2
  %t39 = call double @llvm.round.f64(double %t38)
  %t40 = fptosi double %t39 to i64
  %t41 = load { %DecoratorArgument**, i64 }, { %DecoratorArgument**, i64 }* %t37
  %t42 = extractvalue { %DecoratorArgument**, i64 } %t41, 0
  %t43 = extractvalue { %DecoratorArgument**, i64 } %t41, 1
  %t44 = icmp uge i64 %t40, %t43
  ; bounds check: %t44 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t40, i64 %t43)
  %t45 = getelementptr %DecoratorArgument*, %DecoratorArgument** %t42, i64 %t40
  %t46 = load %DecoratorArgument*, %DecoratorArgument** %t45
  store %DecoratorArgument* %t46, %DecoratorArgument** %l3
  %t47 = load %DecoratorArgument*, %DecoratorArgument** %l3
  %t48 = getelementptr %DecoratorArgument, %DecoratorArgument* %t47, i32 0, i32 1
  %t49 = load %Expression, %Expression* %t48
  %t50 = call i8* @format_expression(%Expression %t49)
  store i8* %t50, i8** %l4
  %t51 = load %DecoratorArgument*, %DecoratorArgument** %l3
  %t52 = getelementptr %DecoratorArgument, %DecoratorArgument* %t51, i32 0, i32 0
  %t53 = load i8*, i8** %t52
  %t54 = icmp ne i8* %t53, null
  %t55 = load i8*, i8** %l0
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t57 = load double, double* %l2
  %t58 = load %DecoratorArgument*, %DecoratorArgument** %l3
  %t59 = load i8*, i8** %l4
  br i1 %t54, label %then8, label %else9
then8:
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t61 = load %DecoratorArgument*, %DecoratorArgument** %l3
  %t62 = getelementptr %DecoratorArgument, %DecoratorArgument* %t61, i32 0, i32 0
  %t63 = load i8*, i8** %t62
  %t64 = alloca [2 x i8], align 1
  %t65 = getelementptr [2 x i8], [2 x i8]* %t64, i32 0, i32 0
  store i8 61, i8* %t65
  %t66 = getelementptr [2 x i8], [2 x i8]* %t64, i32 0, i32 1
  store i8 0, i8* %t66
  %t67 = getelementptr [2 x i8], [2 x i8]* %t64, i32 0, i32 0
  %t68 = call i8* @sailfin_runtime_string_concat(i8* %t63, i8* %t67)
  %t69 = load i8*, i8** %l4
  %t70 = call i8* @sailfin_runtime_string_concat(i8* %t68, i8* %t69)
  %t71 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t60, i8* %t70)
  store { i8**, i64 }* %t71, { i8**, i64 }** %l1
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge10
else9:
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t74 = load i8*, i8** %l4
  %t75 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t73, i8* %t74)
  store { i8**, i64 }* %t75, { i8**, i64 }** %l1
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge10
merge10:
  %t77 = phi { i8**, i64 }* [ %t72, %then8 ], [ %t76, %else9 ]
  store { i8**, i64 }* %t77, { i8**, i64 }** %l1
  %t78 = load double, double* %l2
  %t79 = sitofp i64 1 to double
  %t80 = fadd double %t78, %t79
  store double %t80, double* %l2
  br label %loop.latch4
loop.latch4:
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t82 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t86 = load double, double* %l2
  %t87 = load i8*, i8** %l0
  %t88 = alloca [2 x i8], align 1
  %t89 = getelementptr [2 x i8], [2 x i8]* %t88, i32 0, i32 0
  store i8 40, i8* %t89
  %t90 = getelementptr [2 x i8], [2 x i8]* %t88, i32 0, i32 1
  store i8 0, i8* %t90
  %t91 = getelementptr [2 x i8], [2 x i8]* %t88, i32 0, i32 0
  %t92 = call i8* @sailfin_runtime_string_concat(i8* %t87, i8* %t91)
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s94 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t95 = call i8* @join_with_separator({ i8**, i64 }* %t93, i8* %s94)
  %t96 = call i8* @sailfin_runtime_string_concat(i8* %t92, i8* %t95)
  %t97 = alloca [2 x i8], align 1
  %t98 = getelementptr [2 x i8], [2 x i8]* %t97, i32 0, i32 0
  store i8 41, i8* %t98
  %t99 = getelementptr [2 x i8], [2 x i8]* %t97, i32 0, i32 1
  store i8 0, i8* %t99
  %t100 = getelementptr [2 x i8], [2 x i8]* %t97, i32 0, i32 0
  %t101 = call i8* @sailfin_runtime_string_concat(i8* %t96, i8* %t100)
  call void @sailfin_runtime_mark_persistent(i8* %t101)
  ret i8* %t101
}

define i8* @format_function_signature(%FunctionSignature %signature) {
block.entry:
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
  %t5 = phi i8* [ %t4, %then0 ], [ %t2, %block.entry ]
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
  %t15 = alloca [2 x i8], align 1
  %t16 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  store i8 40, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 1
  store i8 0, i8* %t17
  %t18 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  %t19 = call i8* @sailfin_runtime_string_concat(i8* %t14, i8* %t18)
  %t20 = extractvalue %FunctionSignature %signature, 2
  %t21 = bitcast { %Parameter**, i64 }* %t20 to { %Parameter*, i64 }*
  %t22 = call i8* @format_parameters({ %Parameter*, i64 }* %t21)
  %t23 = call i8* @sailfin_runtime_string_concat(i8* %t19, i8* %t22)
  %t24 = alloca [2 x i8], align 1
  %t25 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 0
  store i8 41, i8* %t25
  %t26 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 1
  store i8 0, i8* %t26
  %t27 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 0
  %t28 = call i8* @sailfin_runtime_string_concat(i8* %t23, i8* %t27)
  store i8* %t28, i8** %l1
  %t29 = extractvalue %FunctionSignature %signature, 3
  %t30 = icmp ne %TypeAnnotation* %t29, null
  %t31 = load i8*, i8** %l0
  %t32 = load i8*, i8** %l1
  br i1 %t30, label %then2, label %merge3
then2:
  %t33 = load i8*, i8** %l1
  %s34 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h173787542, i32 0, i32 0
  %t35 = call i8* @sailfin_runtime_string_concat(i8* %t33, i8* %s34)
  %t36 = extractvalue %FunctionSignature %signature, 3
  %t37 = getelementptr %TypeAnnotation, %TypeAnnotation* %t36, i32 0, i32 0
  %t38 = load i8*, i8** %t37
  %t39 = call i8* @sailfin_runtime_string_concat(i8* %t35, i8* %t38)
  store i8* %t39, i8** %l1
  %t40 = load i8*, i8** %l1
  br label %merge3
merge3:
  %t41 = phi i8* [ %t40, %then2 ], [ %t32, %merge1 ]
  store i8* %t41, i8** %l1
  %t42 = extractvalue %FunctionSignature %signature, 4
  %t43 = load { i8**, i64 }, { i8**, i64 }* %t42
  %t44 = extractvalue { i8**, i64 } %t43, 1
  %t45 = icmp sgt i64 %t44, 0
  %t46 = load i8*, i8** %l0
  %t47 = load i8*, i8** %l1
  br i1 %t45, label %then4, label %merge5
then4:
  %t48 = load i8*, i8** %l1
  %s49 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087662534, i32 0, i32 0
  %t50 = call i8* @sailfin_runtime_string_concat(i8* %t48, i8* %s49)
  %t51 = extractvalue %FunctionSignature %signature, 4
  %s52 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t53 = call i8* @join_with_separator({ i8**, i64 }* %t51, i8* %s52)
  %t54 = call i8* @sailfin_runtime_string_concat(i8* %t50, i8* %t53)
  %t55 = alloca [2 x i8], align 1
  %t56 = getelementptr [2 x i8], [2 x i8]* %t55, i32 0, i32 0
  store i8 93, i8* %t56
  %t57 = getelementptr [2 x i8], [2 x i8]* %t55, i32 0, i32 1
  store i8 0, i8* %t57
  %t58 = getelementptr [2 x i8], [2 x i8]* %t55, i32 0, i32 0
  %t59 = call i8* @sailfin_runtime_string_concat(i8* %t54, i8* %t58)
  store i8* %t59, i8** %l1
  %t60 = load i8*, i8** %l1
  br label %merge5
merge5:
  %t61 = phi i8* [ %t60, %then4 ], [ %t47, %merge3 ]
  store i8* %t61, i8** %l1
  %t62 = load i8*, i8** %l1
  call void @sailfin_runtime_mark_persistent(i8* %t62)
  ret i8* %t62
}

define i8* @format_parameters({ %Parameter*, i64 }* %parameters) {
block.entry:
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
  call void @sailfin_runtime_mark_persistent(i8* %s3)
  ret i8* %s3
merge1:
  %t4 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t5 = ptrtoint [0 x i8*]* %t4 to i64
  %t6 = icmp eq i64 %t5, 0
  %t7 = select i1 %t6, i64 1, i64 %t5
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to i8**
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t11 = ptrtoint { i8**, i64 }* %t10 to i64
  %t12 = call i8* @malloc(i64 %t11)
  %t13 = bitcast i8* %t12 to { i8**, i64 }*
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 0
  store i8** %t9, i8*** %t14
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { i8**, i64 }* %t13, { i8**, i64 }** %l0
  %t16 = sitofp i64 0 to double
  store double %t16, double* %l1
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t93 = phi { i8**, i64 }* [ %t17, %merge1 ], [ %t91, %loop.latch4 ]
  %t94 = phi double [ %t18, %merge1 ], [ %t92, %loop.latch4 ]
  store { i8**, i64 }* %t93, { i8**, i64 }** %l0
  store double %t94, double* %l1
  br label %loop.body3
loop.body3:
  %t19 = load double, double* %l1
  %t20 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t21 = extractvalue { %Parameter*, i64 } %t20, 1
  %t22 = sitofp i64 %t21 to double
  %t23 = fcmp oge double %t19, %t22
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  br i1 %t23, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t26 = load double, double* %l1
  %t27 = call double @llvm.round.f64(double %t26)
  %t28 = fptosi double %t27 to i64
  %t29 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t30 = extractvalue { %Parameter*, i64 } %t29, 0
  %t31 = extractvalue { %Parameter*, i64 } %t29, 1
  %t32 = icmp uge i64 %t28, %t31
  ; bounds check: %t32 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t28, i64 %t31)
  %t33 = getelementptr %Parameter, %Parameter* %t30, i64 %t28
  %t34 = load %Parameter, %Parameter* %t33
  store %Parameter %t34, %Parameter* %l2
  %s35 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s35, i8** %l3
  %t36 = load %Parameter, %Parameter* %l2
  %t37 = extractvalue %Parameter %t36, 3
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load double, double* %l1
  %t40 = load %Parameter, %Parameter* %l2
  %t41 = load i8*, i8** %l3
  br i1 %t37, label %then8, label %else9
then8:
  %s42 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t43 = load %Parameter, %Parameter* %l2
  %t44 = extractvalue %Parameter %t43, 0
  %t45 = call i8* @sailfin_runtime_string_concat(i8* %s42, i8* %t44)
  store i8* %t45, i8** %l3
  %t46 = load i8*, i8** %l3
  br label %merge10
else9:
  %t47 = load %Parameter, %Parameter* %l2
  %t48 = extractvalue %Parameter %t47, 0
  store i8* %t48, i8** %l3
  %t49 = load i8*, i8** %l3
  br label %merge10
merge10:
  %t50 = phi i8* [ %t46, %then8 ], [ %t49, %else9 ]
  store i8* %t50, i8** %l3
  %t51 = load %Parameter, %Parameter* %l2
  %t52 = extractvalue %Parameter %t51, 1
  %t53 = icmp ne %TypeAnnotation* %t52, null
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load double, double* %l1
  %t56 = load %Parameter, %Parameter* %l2
  %t57 = load i8*, i8** %l3
  br i1 %t53, label %then11, label %merge12
then11:
  %t58 = load i8*, i8** %l3
  %s59 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h173787542, i32 0, i32 0
  %t60 = call i8* @sailfin_runtime_string_concat(i8* %t58, i8* %s59)
  %t61 = load %Parameter, %Parameter* %l2
  %t62 = extractvalue %Parameter %t61, 1
  %t63 = getelementptr %TypeAnnotation, %TypeAnnotation* %t62, i32 0, i32 0
  %t64 = load i8*, i8** %t63
  %t65 = call i8* @sailfin_runtime_string_concat(i8* %t60, i8* %t64)
  store i8* %t65, i8** %l3
  %t66 = load i8*, i8** %l3
  br label %merge12
merge12:
  %t67 = phi i8* [ %t66, %then11 ], [ %t57, %merge10 ]
  store i8* %t67, i8** %l3
  %t68 = load %Parameter, %Parameter* %l2
  %t69 = extractvalue %Parameter %t68, 2
  %t70 = icmp ne %Expression* %t69, null
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = load double, double* %l1
  %t73 = load %Parameter, %Parameter* %l2
  %t74 = load i8*, i8** %l3
  br i1 %t70, label %then13, label %merge14
then13:
  %t75 = load i8*, i8** %l3
  %s76 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t77 = call i8* @sailfin_runtime_string_concat(i8* %t75, i8* %s76)
  %t78 = load %Parameter, %Parameter* %l2
  %t79 = extractvalue %Parameter %t78, 2
  %t80 = load %Expression, %Expression* %t79
  %t81 = call i8* @format_expression(%Expression %t80)
  %t82 = call i8* @sailfin_runtime_string_concat(i8* %t77, i8* %t81)
  store i8* %t82, i8** %l3
  %t83 = load i8*, i8** %l3
  br label %merge14
merge14:
  %t84 = phi i8* [ %t83, %then13 ], [ %t74, %merge12 ]
  store i8* %t84, i8** %l3
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t86 = load i8*, i8** %l3
  %t87 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t85, i8* %t86)
  store { i8**, i64 }* %t87, { i8**, i64 }** %l0
  %t88 = load double, double* %l1
  %t89 = sitofp i64 1 to double
  %t90 = fadd double %t88, %t89
  store double %t90, double* %l1
  br label %loop.latch4
loop.latch4:
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t92 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t96 = load double, double* %l1
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s98 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t99 = call i8* @join_with_separator({ i8**, i64 }* %t97, i8* %s98)
  call void @sailfin_runtime_mark_persistent(i8* %t99)
  ret i8* %t99
}

define i8* @format_type_parameters({ %TypeParameter*, i64 }* %parameters) {
block.entry:
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
  call void @sailfin_runtime_mark_persistent(i8* %s3)
  ret i8* %s3
merge1:
  %t4 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t5 = ptrtoint [0 x i8*]* %t4 to i64
  %t6 = icmp eq i64 %t5, 0
  %t7 = select i1 %t6, i64 1, i64 %t5
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to i8**
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t11 = ptrtoint { i8**, i64 }* %t10 to i64
  %t12 = call i8* @malloc(i64 %t11)
  %t13 = bitcast i8* %t12 to { i8**, i64 }*
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 0
  store i8** %t9, i8*** %t14
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { i8**, i64 }* %t13, { i8**, i64 }** %l0
  %t16 = sitofp i64 0 to double
  store double %t16, double* %l1
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t62 = phi { i8**, i64 }* [ %t17, %merge1 ], [ %t60, %loop.latch4 ]
  %t63 = phi double [ %t18, %merge1 ], [ %t61, %loop.latch4 ]
  store { i8**, i64 }* %t62, { i8**, i64 }** %l0
  store double %t63, double* %l1
  br label %loop.body3
loop.body3:
  %t19 = load double, double* %l1
  %t20 = load { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %parameters
  %t21 = extractvalue { %TypeParameter*, i64 } %t20, 1
  %t22 = sitofp i64 %t21 to double
  %t23 = fcmp oge double %t19, %t22
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  br i1 %t23, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t26 = load double, double* %l1
  %t27 = call double @llvm.round.f64(double %t26)
  %t28 = fptosi double %t27 to i64
  %t29 = load { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %parameters
  %t30 = extractvalue { %TypeParameter*, i64 } %t29, 0
  %t31 = extractvalue { %TypeParameter*, i64 } %t29, 1
  %t32 = icmp uge i64 %t28, %t31
  ; bounds check: %t32 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t28, i64 %t31)
  %t33 = getelementptr %TypeParameter, %TypeParameter* %t30, i64 %t28
  %t34 = load %TypeParameter, %TypeParameter* %t33
  store %TypeParameter %t34, %TypeParameter* %l2
  %t35 = load %TypeParameter, %TypeParameter* %l2
  %t36 = extractvalue %TypeParameter %t35, 0
  store i8* %t36, i8** %l3
  %t37 = load %TypeParameter, %TypeParameter* %l2
  %t38 = extractvalue %TypeParameter %t37, 1
  %t39 = icmp ne %TypeAnnotation* %t38, null
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load double, double* %l1
  %t42 = load %TypeParameter, %TypeParameter* %l2
  %t43 = load i8*, i8** %l3
  br i1 %t39, label %then8, label %merge9
then8:
  %t44 = load i8*, i8** %l3
  %s45 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087687812, i32 0, i32 0
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t44, i8* %s45)
  %t47 = load %TypeParameter, %TypeParameter* %l2
  %t48 = extractvalue %TypeParameter %t47, 1
  %t49 = getelementptr %TypeAnnotation, %TypeAnnotation* %t48, i32 0, i32 0
  %t50 = load i8*, i8** %t49
  %t51 = call i8* @sailfin_runtime_string_concat(i8* %t46, i8* %t50)
  store i8* %t51, i8** %l3
  %t52 = load i8*, i8** %l3
  br label %merge9
merge9:
  %t53 = phi i8* [ %t52, %then8 ], [ %t43, %merge7 ]
  store i8* %t53, i8** %l3
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load i8*, i8** %l3
  %t56 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t54, i8* %t55)
  store { i8**, i64 }* %t56, { i8**, i64 }** %l0
  %t57 = load double, double* %l1
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l1
  br label %loop.latch4
loop.latch4:
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t61 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load double, double* %l1
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s67 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t68 = call i8* @join_with_separator({ i8**, i64 }* %t66, i8* %s67)
  %t69 = alloca [2 x i8], align 1
  %t70 = getelementptr [2 x i8], [2 x i8]* %t69, i32 0, i32 0
  store i8 60, i8* %t70
  %t71 = getelementptr [2 x i8], [2 x i8]* %t69, i32 0, i32 1
  store i8 0, i8* %t71
  %t72 = getelementptr [2 x i8], [2 x i8]* %t69, i32 0, i32 0
  %t73 = call i8* @sailfin_runtime_string_concat(i8* %t72, i8* %t68)
  %t74 = alloca [2 x i8], align 1
  %t75 = getelementptr [2 x i8], [2 x i8]* %t74, i32 0, i32 0
  store i8 62, i8* %t75
  %t76 = getelementptr [2 x i8], [2 x i8]* %t74, i32 0, i32 1
  store i8 0, i8* %t76
  %t77 = getelementptr [2 x i8], [2 x i8]* %t74, i32 0, i32 0
  %t78 = call i8* @sailfin_runtime_string_concat(i8* %t73, i8* %t77)
  call void @sailfin_runtime_mark_persistent(i8* %t78)
  ret i8* %t78
}

define i8* @format_field(%FieldDeclaration %field) {
block.entry:
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
  %t7 = phi i8* [ %t6, %then0 ], [ %t2, %block.entry ]
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
  call void @sailfin_runtime_mark_persistent(i8* %t16)
  ret i8* %t16
}

define i8* @format_enum_variant(%EnumVariant %variant) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = extractvalue %EnumVariant %variant, 1
  %t1 = load { %FieldDeclaration**, i64 }, { %FieldDeclaration**, i64 }* %t0
  %t2 = extractvalue { %FieldDeclaration**, i64 } %t1, 1
  %t3 = icmp eq i64 %t2, 0
  br i1 %t3, label %then0, label %merge1
then0:
  %t4 = extractvalue %EnumVariant %variant, 0
  call void @sailfin_runtime_mark_persistent(i8* %t4)
  ret i8* %t4
merge1:
  %t5 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t6 = ptrtoint [0 x i8*]* %t5 to i64
  %t7 = icmp eq i64 %t6, 0
  %t8 = select i1 %t7, i64 1, i64 %t6
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to i8**
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t12 = ptrtoint { i8**, i64 }* %t11 to i64
  %t13 = call i8* @malloc(i64 %t12)
  %t14 = bitcast i8* %t13 to { i8**, i64 }*
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 0
  store i8** %t10, i8*** %t15
  %t16 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  store { i8**, i64 }* %t14, { i8**, i64 }** %l0
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l1
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t47 = phi { i8**, i64 }* [ %t18, %merge1 ], [ %t45, %loop.latch4 ]
  %t48 = phi double [ %t19, %merge1 ], [ %t46, %loop.latch4 ]
  store { i8**, i64 }* %t47, { i8**, i64 }** %l0
  store double %t48, double* %l1
  br label %loop.body3
loop.body3:
  %t20 = load double, double* %l1
  %t21 = extractvalue %EnumVariant %variant, 1
  %t22 = load { %FieldDeclaration**, i64 }, { %FieldDeclaration**, i64 }* %t21
  %t23 = extractvalue { %FieldDeclaration**, i64 } %t22, 1
  %t24 = sitofp i64 %t23 to double
  %t25 = fcmp oge double %t20, %t24
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load double, double* %l1
  br i1 %t25, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = extractvalue %EnumVariant %variant, 1
  %t30 = load double, double* %l1
  %t31 = call double @llvm.round.f64(double %t30)
  %t32 = fptosi double %t31 to i64
  %t33 = load { %FieldDeclaration**, i64 }, { %FieldDeclaration**, i64 }* %t29
  %t34 = extractvalue { %FieldDeclaration**, i64 } %t33, 0
  %t35 = extractvalue { %FieldDeclaration**, i64 } %t33, 1
  %t36 = icmp uge i64 %t32, %t35
  ; bounds check: %t36 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t32, i64 %t35)
  %t37 = getelementptr %FieldDeclaration*, %FieldDeclaration** %t34, i64 %t32
  %t38 = load %FieldDeclaration*, %FieldDeclaration** %t37
  %t39 = load %FieldDeclaration, %FieldDeclaration* %t38
  %t40 = call i8* @format_field(%FieldDeclaration %t39)
  %t41 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t28, i8* %t40)
  store { i8**, i64 }* %t41, { i8**, i64 }** %l0
  %t42 = load double, double* %l1
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  store double %t44, double* %l1
  br label %loop.latch4
loop.latch4:
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t46 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = load double, double* %l1
  %t51 = extractvalue %EnumVariant %variant, 0
  %s52 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087758597, i32 0, i32 0
  %t53 = call i8* @sailfin_runtime_string_concat(i8* %t51, i8* %s52)
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s55 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193442306, i32 0, i32 0
  %t56 = call i8* @join_with_separator({ i8**, i64 }* %t54, i8* %s55)
  %t57 = call i8* @sailfin_runtime_string_concat(i8* %t53, i8* %t56)
  %s58 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415972, i32 0, i32 0
  %t59 = call i8* @sailfin_runtime_string_concat(i8* %t57, i8* %s58)
  call void @sailfin_runtime_mark_persistent(i8* %t59)
  ret i8* %t59
}

define %LayoutEmitResult @compute_struct_layout_lines(%LayoutContext %context, i8* %struct_name, { %FieldDeclaration*, i64 }* %fields) {
block.entry:
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
  %t3 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t4 = ptrtoint [0 x i8*]* %t3 to i64
  %t5 = icmp eq i64 %t4, 0
  %t6 = select i1 %t5, i64 1, i64 %t4
  %t7 = call i8* @malloc(i64 %t6)
  %t8 = bitcast i8* %t7 to i8**
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t8, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  %t15 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t12, i8* %struct_name)
  %t16 = call %RecordLayoutResult @calculate_record_layout(%LayoutContext %context, { %LayoutFieldInput*, i64 }* %t1, i8* %s2, i8* %struct_name, { i8**, i64 }* %t15)
  store %RecordLayoutResult %t16, %RecordLayoutResult* %l1
  %t17 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t18 = ptrtoint [0 x i8*]* %t17 to i64
  %t19 = icmp eq i64 %t18, 0
  %t20 = select i1 %t19, i64 1, i64 %t18
  %t21 = call i8* @malloc(i64 %t20)
  %t22 = bitcast i8* %t21 to i8**
  %t23 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t24 = ptrtoint { i8**, i64 }* %t23 to i64
  %t25 = call i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to { i8**, i64 }*
  %t27 = getelementptr { i8**, i64 }, { i8**, i64 }* %t26, i32 0, i32 0
  store i8** %t22, i8*** %t27
  %t28 = getelementptr { i8**, i64 }, { i8**, i64 }* %t26, i32 0, i32 1
  store i64 0, i64* %t28
  store { i8**, i64 }* %t26, { i8**, i64 }** %l2
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s30 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h239636501, i32 0, i32 0
  %t31 = call i8* @sailfin_runtime_string_concat(i8* %s30, i8* %struct_name)
  %s32 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h922402750, i32 0, i32 0
  %t33 = call i8* @sailfin_runtime_string_concat(i8* %t31, i8* %s32)
  %t34 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t35 = extractvalue %RecordLayoutResult %t34, 0
  %t36 = call i8* @number_to_string(double %t35)
  %t37 = call i8* @sailfin_runtime_string_concat(i8* %t33, i8* %t36)
  %s38 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h847788946, i32 0, i32 0
  %t39 = call i8* @sailfin_runtime_string_concat(i8* %t37, i8* %s38)
  %t40 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t41 = extractvalue %RecordLayoutResult %t40, 1
  %t42 = call i8* @number_to_string(double %t41)
  %t43 = call i8* @sailfin_runtime_string_concat(i8* %t39, i8* %t42)
  %t44 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t29, i8* %t43)
  store { i8**, i64 }* %t44, { i8**, i64 }** %l2
  %t45 = sitofp i64 0 to double
  store double %t45, double* %l3
  %t46 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t47 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t49 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t116 = phi { i8**, i64 }* [ %t48, %block.entry ], [ %t114, %loop.latch2 ]
  %t117 = phi double [ %t49, %block.entry ], [ %t115, %loop.latch2 ]
  store { i8**, i64 }* %t116, { i8**, i64 }** %l2
  store double %t117, double* %l3
  br label %loop.body1
loop.body1:
  %t50 = load double, double* %l3
  %t51 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t52 = extractvalue %RecordLayoutResult %t51, 2
  %t53 = load { %StructFieldLayoutDescriptor**, i64 }, { %StructFieldLayoutDescriptor**, i64 }* %t52
  %t54 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t53, 1
  %t55 = sitofp i64 %t54 to double
  %t56 = fcmp oge double %t50, %t55
  %t57 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t58 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t60 = load double, double* %l3
  br i1 %t56, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t61 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t62 = extractvalue %RecordLayoutResult %t61, 2
  %t63 = load double, double* %l3
  %t64 = call double @llvm.round.f64(double %t63)
  %t65 = fptosi double %t64 to i64
  %t66 = load { %StructFieldLayoutDescriptor**, i64 }, { %StructFieldLayoutDescriptor**, i64 }* %t62
  %t67 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t66, 0
  %t68 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t66, 1
  %t69 = icmp uge i64 %t65, %t68
  ; bounds check: %t69 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t65, i64 %t68)
  %t70 = getelementptr %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t67, i64 %t65
  %t71 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t70
  store %StructFieldLayoutDescriptor* %t71, %StructFieldLayoutDescriptor** %l4
  %s72 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1053492670, i32 0, i32 0
  %t73 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l4
  %t74 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t73, i32 0, i32 0
  %t75 = load i8*, i8** %t74
  %t76 = call i8* @sailfin_runtime_string_concat(i8* %s72, i8* %t75)
  store i8* %t76, i8** %l5
  %t77 = load i8*, i8** %l5
  %s78 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h980153509, i32 0, i32 0
  %t79 = call i8* @sailfin_runtime_string_concat(i8* %t77, i8* %s78)
  %t80 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l4
  %t81 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t80, i32 0, i32 1
  %t82 = load i8*, i8** %t81
  %t83 = call i8* @sailfin_runtime_string_concat(i8* %t79, i8* %t82)
  store i8* %t83, i8** %l5
  %t84 = load i8*, i8** %l5
  %s85 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h455185518, i32 0, i32 0
  %t86 = call i8* @sailfin_runtime_string_concat(i8* %t84, i8* %s85)
  %t87 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l4
  %t88 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t87, i32 0, i32 2
  %t89 = load double, double* %t88
  %t90 = call i8* @number_to_string(double %t89)
  %t91 = call i8* @sailfin_runtime_string_concat(i8* %t86, i8* %t90)
  store i8* %t91, i8** %l5
  %t92 = load i8*, i8** %l5
  %s93 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h922402750, i32 0, i32 0
  %t94 = call i8* @sailfin_runtime_string_concat(i8* %t92, i8* %s93)
  %t95 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l4
  %t96 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t95, i32 0, i32 3
  %t97 = load double, double* %t96
  %t98 = call i8* @number_to_string(double %t97)
  %t99 = call i8* @sailfin_runtime_string_concat(i8* %t94, i8* %t98)
  store i8* %t99, i8** %l5
  %t100 = load i8*, i8** %l5
  %s101 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h847788946, i32 0, i32 0
  %t102 = call i8* @sailfin_runtime_string_concat(i8* %t100, i8* %s101)
  %t103 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l4
  %t104 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t103, i32 0, i32 4
  %t105 = load double, double* %t104
  %t106 = call i8* @number_to_string(double %t105)
  %t107 = call i8* @sailfin_runtime_string_concat(i8* %t102, i8* %t106)
  store i8* %t107, i8** %l5
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t109 = load i8*, i8** %l5
  %t110 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t108, i8* %t109)
  store { i8**, i64 }* %t110, { i8**, i64 }** %l2
  %t111 = load double, double* %l3
  %t112 = sitofp i64 1 to double
  %t113 = fadd double %t111, %t112
  store double %t113, double* %l3
  br label %loop.latch2
loop.latch2:
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t115 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t119 = load double, double* %l3
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t121 = insertvalue %LayoutEmitResult undef, { i8**, i64 }* %t120, 0
  %t122 = load %RecordLayoutResult, %RecordLayoutResult* %l1
  %t123 = extractvalue %RecordLayoutResult %t122, 3
  %t124 = insertvalue %LayoutEmitResult %t121, { i8**, i64 }* %t123, 1
  ret %LayoutEmitResult %t124
}

define %LayoutEmitResult @compute_enum_layout_lines(%LayoutContext %context, %Statement %statement) {
block.entry:
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
  %t0 = getelementptr [0 x %LayoutEnumVariantDefinition], [0 x %LayoutEnumVariantDefinition]* null, i32 1
  %t1 = ptrtoint [0 x %LayoutEnumVariantDefinition]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %LayoutEnumVariantDefinition*
  %t6 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* null, i32 1
  %t7 = ptrtoint { %LayoutEnumVariantDefinition*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %LayoutEnumVariantDefinition*, i64 }*
  %t10 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %t9, i32 0, i32 0
  store %LayoutEnumVariantDefinition* %t5, %LayoutEnumVariantDefinition** %t10
  %t11 = getelementptr { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %LayoutEnumVariantDefinition*, i64 }* %t9, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t66 = phi { %LayoutEnumVariantDefinition*, i64 }* [ %t13, %block.entry ], [ %t64, %loop.latch2 ]
  %t67 = phi double [ %t14, %block.entry ], [ %t65, %loop.latch2 ]
  store { %LayoutEnumVariantDefinition*, i64 }* %t66, { %LayoutEnumVariantDefinition*, i64 }** %l0
  store double %t67, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = extractvalue %Statement %statement, 0
  %t17 = alloca %Statement
  store %Statement %statement, %Statement* %t17
  %t18 = getelementptr inbounds %Statement, %Statement* %t17, i32 0, i32 1
  %t19 = bitcast [40 x i8]* %t18 to i8*
  %t20 = getelementptr inbounds i8, i8* %t19, i64 24
  %t21 = bitcast i8* %t20 to { %EnumVariant**, i64 }**
  %t22 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t21
  %t23 = icmp eq i32 %t16, 11
  %t24 = select i1 %t23, { %EnumVariant**, i64 }* %t22, { %EnumVariant**, i64 }* null
  %t25 = load { %EnumVariant**, i64 }, { %EnumVariant**, i64 }* %t24
  %t26 = extractvalue { %EnumVariant**, i64 } %t25, 1
  %t27 = sitofp i64 %t26 to double
  %t28 = fcmp oge double %t15, %t27
  %t29 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t30 = load double, double* %l1
  br i1 %t28, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t31 = extractvalue %Statement %statement, 0
  %t32 = alloca %Statement
  store %Statement %statement, %Statement* %t32
  %t33 = getelementptr inbounds %Statement, %Statement* %t32, i32 0, i32 1
  %t34 = bitcast [40 x i8]* %t33 to i8*
  %t35 = getelementptr inbounds i8, i8* %t34, i64 24
  %t36 = bitcast i8* %t35 to { %EnumVariant**, i64 }**
  %t37 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t36
  %t38 = icmp eq i32 %t31, 11
  %t39 = select i1 %t38, { %EnumVariant**, i64 }* %t37, { %EnumVariant**, i64 }* null
  %t40 = load double, double* %l1
  %t41 = call double @llvm.round.f64(double %t40)
  %t42 = fptosi double %t41 to i64
  %t43 = load { %EnumVariant**, i64 }, { %EnumVariant**, i64 }* %t39
  %t44 = extractvalue { %EnumVariant**, i64 } %t43, 0
  %t45 = extractvalue { %EnumVariant**, i64 } %t43, 1
  %t46 = icmp uge i64 %t42, %t45
  ; bounds check: %t46 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t42, i64 %t45)
  %t47 = getelementptr %EnumVariant*, %EnumVariant** %t44, i64 %t42
  %t48 = load %EnumVariant*, %EnumVariant** %t47
  store %EnumVariant* %t48, %EnumVariant** %l2
  %t49 = load %EnumVariant*, %EnumVariant** %l2
  %t50 = load %EnumVariant, %EnumVariant* %t49
  %t51 = call { %LayoutFieldInput*, i64 }* @convert_variant_fields(%EnumVariant %t50)
  store { %LayoutFieldInput*, i64 }* %t51, { %LayoutFieldInput*, i64 }** %l3
  %t52 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t53 = load %EnumVariant*, %EnumVariant** %l2
  %t54 = getelementptr %EnumVariant, %EnumVariant* %t53, i32 0, i32 0
  %t55 = load i8*, i8** %t54
  %t56 = insertvalue %LayoutEnumVariantDefinition undef, i8* %t55, 0
  %t57 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l3
  %t58 = bitcast { %LayoutFieldInput*, i64 }* %t57 to { %LayoutFieldInput**, i64 }*
  %t59 = insertvalue %LayoutEnumVariantDefinition %t56, { %LayoutFieldInput**, i64 }* %t58, 1
  %t60 = call { %LayoutEnumVariantDefinition*, i64 }* @append_layout_enum_variant_definition({ %LayoutEnumVariantDefinition*, i64 }* %t52, %LayoutEnumVariantDefinition %t59)
  store { %LayoutEnumVariantDefinition*, i64 }* %t60, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t61 = load double, double* %l1
  %t62 = sitofp i64 1 to double
  %t63 = fadd double %t61, %t62
  store double %t63, double* %l1
  br label %loop.latch2
loop.latch2:
  %t64 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t65 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t68 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t69 = load double, double* %l1
  %t70 = extractvalue %Statement %statement, 0
  %t71 = alloca %Statement
  store %Statement %statement, %Statement* %t71
  %t72 = getelementptr inbounds %Statement, %Statement* %t71, i32 0, i32 1
  %t73 = bitcast [48 x i8]* %t72 to i8*
  %t74 = bitcast i8* %t73 to i8**
  %t75 = load i8*, i8** %t74
  %t76 = icmp eq i32 %t70, 2
  %t77 = select i1 %t76, i8* %t75, i8* null
  %t78 = getelementptr inbounds %Statement, %Statement* %t71, i32 0, i32 1
  %t79 = bitcast [48 x i8]* %t78 to i8*
  %t80 = bitcast i8* %t79 to i8**
  %t81 = load i8*, i8** %t80
  %t82 = icmp eq i32 %t70, 3
  %t83 = select i1 %t82, i8* %t81, i8* %t77
  %t84 = getelementptr inbounds %Statement, %Statement* %t71, i32 0, i32 1
  %t85 = bitcast [56 x i8]* %t84 to i8*
  %t86 = bitcast i8* %t85 to i8**
  %t87 = load i8*, i8** %t86
  %t88 = icmp eq i32 %t70, 6
  %t89 = select i1 %t88, i8* %t87, i8* %t83
  %t90 = getelementptr inbounds %Statement, %Statement* %t71, i32 0, i32 1
  %t91 = bitcast [56 x i8]* %t90 to i8*
  %t92 = bitcast i8* %t91 to i8**
  %t93 = load i8*, i8** %t92
  %t94 = icmp eq i32 %t70, 8
  %t95 = select i1 %t94, i8* %t93, i8* %t89
  %t96 = getelementptr inbounds %Statement, %Statement* %t71, i32 0, i32 1
  %t97 = bitcast [40 x i8]* %t96 to i8*
  %t98 = bitcast i8* %t97 to i8**
  %t99 = load i8*, i8** %t98
  %t100 = icmp eq i32 %t70, 9
  %t101 = select i1 %t100, i8* %t99, i8* %t95
  %t102 = getelementptr inbounds %Statement, %Statement* %t71, i32 0, i32 1
  %t103 = bitcast [40 x i8]* %t102 to i8*
  %t104 = bitcast i8* %t103 to i8**
  %t105 = load i8*, i8** %t104
  %t106 = icmp eq i32 %t70, 10
  %t107 = select i1 %t106, i8* %t105, i8* %t101
  %t108 = getelementptr inbounds %Statement, %Statement* %t71, i32 0, i32 1
  %t109 = bitcast [40 x i8]* %t108 to i8*
  %t110 = bitcast i8* %t109 to i8**
  %t111 = load i8*, i8** %t110
  %t112 = icmp eq i32 %t70, 11
  %t113 = select i1 %t112, i8* %t111, i8* %t107
  %t114 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t115 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t116 = ptrtoint [0 x i8*]* %t115 to i64
  %t117 = icmp eq i64 %t116, 0
  %t118 = select i1 %t117, i64 1, i64 %t116
  %t119 = call i8* @malloc(i64 %t118)
  %t120 = bitcast i8* %t119 to i8**
  %t121 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t122 = ptrtoint { i8**, i64 }* %t121 to i64
  %t123 = call i8* @malloc(i64 %t122)
  %t124 = bitcast i8* %t123 to { i8**, i64 }*
  %t125 = getelementptr { i8**, i64 }, { i8**, i64 }* %t124, i32 0, i32 0
  store i8** %t120, i8*** %t125
  %t126 = getelementptr { i8**, i64 }, { i8**, i64 }* %t124, i32 0, i32 1
  store i64 0, i64* %t126
  %t127 = extractvalue %Statement %statement, 0
  %t128 = alloca %Statement
  store %Statement %statement, %Statement* %t128
  %t129 = getelementptr inbounds %Statement, %Statement* %t128, i32 0, i32 1
  %t130 = bitcast [48 x i8]* %t129 to i8*
  %t131 = bitcast i8* %t130 to i8**
  %t132 = load i8*, i8** %t131
  %t133 = icmp eq i32 %t127, 2
  %t134 = select i1 %t133, i8* %t132, i8* null
  %t135 = getelementptr inbounds %Statement, %Statement* %t128, i32 0, i32 1
  %t136 = bitcast [48 x i8]* %t135 to i8*
  %t137 = bitcast i8* %t136 to i8**
  %t138 = load i8*, i8** %t137
  %t139 = icmp eq i32 %t127, 3
  %t140 = select i1 %t139, i8* %t138, i8* %t134
  %t141 = getelementptr inbounds %Statement, %Statement* %t128, i32 0, i32 1
  %t142 = bitcast [56 x i8]* %t141 to i8*
  %t143 = bitcast i8* %t142 to i8**
  %t144 = load i8*, i8** %t143
  %t145 = icmp eq i32 %t127, 6
  %t146 = select i1 %t145, i8* %t144, i8* %t140
  %t147 = getelementptr inbounds %Statement, %Statement* %t128, i32 0, i32 1
  %t148 = bitcast [56 x i8]* %t147 to i8*
  %t149 = bitcast i8* %t148 to i8**
  %t150 = load i8*, i8** %t149
  %t151 = icmp eq i32 %t127, 8
  %t152 = select i1 %t151, i8* %t150, i8* %t146
  %t153 = getelementptr inbounds %Statement, %Statement* %t128, i32 0, i32 1
  %t154 = bitcast [40 x i8]* %t153 to i8*
  %t155 = bitcast i8* %t154 to i8**
  %t156 = load i8*, i8** %t155
  %t157 = icmp eq i32 %t127, 9
  %t158 = select i1 %t157, i8* %t156, i8* %t152
  %t159 = getelementptr inbounds %Statement, %Statement* %t128, i32 0, i32 1
  %t160 = bitcast [40 x i8]* %t159 to i8*
  %t161 = bitcast i8* %t160 to i8**
  %t162 = load i8*, i8** %t161
  %t163 = icmp eq i32 %t127, 10
  %t164 = select i1 %t163, i8* %t162, i8* %t158
  %t165 = getelementptr inbounds %Statement, %Statement* %t128, i32 0, i32 1
  %t166 = bitcast [40 x i8]* %t165 to i8*
  %t167 = bitcast i8* %t166 to i8**
  %t168 = load i8*, i8** %t167
  %t169 = icmp eq i32 %t127, 11
  %t170 = select i1 %t169, i8* %t168, i8* %t164
  %t171 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t124, i8* %t170)
  %t172 = call %EnumAggregateLayout @infer_enum_aggregate_layout(%LayoutContext %context, i8* %t113, { %LayoutEnumVariantDefinition*, i64 }* %t114, { i8**, i64 }* %t171)
  store %EnumAggregateLayout %t172, %EnumAggregateLayout* %l4
  %t173 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t174 = ptrtoint [0 x i8*]* %t173 to i64
  %t175 = icmp eq i64 %t174, 0
  %t176 = select i1 %t175, i64 1, i64 %t174
  %t177 = call i8* @malloc(i64 %t176)
  %t178 = bitcast i8* %t177 to i8**
  %t179 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t180 = ptrtoint { i8**, i64 }* %t179 to i64
  %t181 = call i8* @malloc(i64 %t180)
  %t182 = bitcast i8* %t181 to { i8**, i64 }*
  %t183 = getelementptr { i8**, i64 }, { i8**, i64 }* %t182, i32 0, i32 0
  store i8** %t178, i8*** %t183
  %t184 = getelementptr { i8**, i64 }, { i8**, i64 }* %t182, i32 0, i32 1
  store i64 0, i64* %t184
  store { i8**, i64 }* %t182, { i8**, i64 }** %l5
  %s185 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.len18.h548024877, i32 0, i32 0
  %t186 = extractvalue %Statement %statement, 0
  %t187 = alloca %Statement
  store %Statement %statement, %Statement* %t187
  %t188 = getelementptr inbounds %Statement, %Statement* %t187, i32 0, i32 1
  %t189 = bitcast [48 x i8]* %t188 to i8*
  %t190 = bitcast i8* %t189 to i8**
  %t191 = load i8*, i8** %t190
  %t192 = icmp eq i32 %t186, 2
  %t193 = select i1 %t192, i8* %t191, i8* null
  %t194 = getelementptr inbounds %Statement, %Statement* %t187, i32 0, i32 1
  %t195 = bitcast [48 x i8]* %t194 to i8*
  %t196 = bitcast i8* %t195 to i8**
  %t197 = load i8*, i8** %t196
  %t198 = icmp eq i32 %t186, 3
  %t199 = select i1 %t198, i8* %t197, i8* %t193
  %t200 = getelementptr inbounds %Statement, %Statement* %t187, i32 0, i32 1
  %t201 = bitcast [56 x i8]* %t200 to i8*
  %t202 = bitcast i8* %t201 to i8**
  %t203 = load i8*, i8** %t202
  %t204 = icmp eq i32 %t186, 6
  %t205 = select i1 %t204, i8* %t203, i8* %t199
  %t206 = getelementptr inbounds %Statement, %Statement* %t187, i32 0, i32 1
  %t207 = bitcast [56 x i8]* %t206 to i8*
  %t208 = bitcast i8* %t207 to i8**
  %t209 = load i8*, i8** %t208
  %t210 = icmp eq i32 %t186, 8
  %t211 = select i1 %t210, i8* %t209, i8* %t205
  %t212 = getelementptr inbounds %Statement, %Statement* %t187, i32 0, i32 1
  %t213 = bitcast [40 x i8]* %t212 to i8*
  %t214 = bitcast i8* %t213 to i8**
  %t215 = load i8*, i8** %t214
  %t216 = icmp eq i32 %t186, 9
  %t217 = select i1 %t216, i8* %t215, i8* %t211
  %t218 = getelementptr inbounds %Statement, %Statement* %t187, i32 0, i32 1
  %t219 = bitcast [40 x i8]* %t218 to i8*
  %t220 = bitcast i8* %t219 to i8**
  %t221 = load i8*, i8** %t220
  %t222 = icmp eq i32 %t186, 10
  %t223 = select i1 %t222, i8* %t221, i8* %t217
  %t224 = getelementptr inbounds %Statement, %Statement* %t187, i32 0, i32 1
  %t225 = bitcast [40 x i8]* %t224 to i8*
  %t226 = bitcast i8* %t225 to i8**
  %t227 = load i8*, i8** %t226
  %t228 = icmp eq i32 %t186, 11
  %t229 = select i1 %t228, i8* %t227, i8* %t223
  %t230 = call i8* @sailfin_runtime_string_concat(i8* %s185, i8* %t229)
  %s231 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h922402750, i32 0, i32 0
  %t232 = call i8* @sailfin_runtime_string_concat(i8* %t230, i8* %s231)
  %t233 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t234 = extractvalue %EnumAggregateLayout %t233, 0
  %t235 = call i8* @number_to_string(double %t234)
  %t236 = call i8* @sailfin_runtime_string_concat(i8* %t232, i8* %t235)
  %s237 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h847788946, i32 0, i32 0
  %t238 = call i8* @sailfin_runtime_string_concat(i8* %t236, i8* %s237)
  %t239 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t240 = extractvalue %EnumAggregateLayout %t239, 1
  %t241 = call i8* @number_to_string(double %t240)
  %t242 = call i8* @sailfin_runtime_string_concat(i8* %t238, i8* %t241)
  store i8* %t242, i8** %l6
  %t243 = load i8*, i8** %l6
  %s244 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.len23.h1863896425, i32 0, i32 0
  %t245 = call i8* @sailfin_runtime_string_concat(i8* %t243, i8* %s244)
  %t246 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t247 = extractvalue %EnumAggregateLayout %t246, 2
  %t248 = call i8* @number_to_string(double %t247)
  %t249 = call i8* @sailfin_runtime_string_concat(i8* %t245, i8* %t248)
  %s250 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1741471221, i32 0, i32 0
  %t251 = call i8* @sailfin_runtime_string_concat(i8* %t249, i8* %s250)
  %t252 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t253 = extractvalue %EnumAggregateLayout %t252, 3
  %t254 = call i8* @number_to_string(double %t253)
  %t255 = call i8* @sailfin_runtime_string_concat(i8* %t251, i8* %t254)
  store i8* %t255, i8** %l6
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t257 = load i8*, i8** %l6
  %t258 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t256, i8* %t257)
  store { i8**, i64 }* %t258, { i8**, i64 }** %l5
  %t259 = sitofp i64 0 to double
  store double %t259, double* %l7
  %t260 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t261 = load double, double* %l1
  %t262 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t263 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t264 = load i8*, i8** %l6
  %t265 = load double, double* %l7
  br label %loop.header6
loop.header6:
  %t431 = phi { i8**, i64 }* [ %t263, %afterloop3 ], [ %t429, %loop.latch8 ]
  %t432 = phi double [ %t265, %afterloop3 ], [ %t430, %loop.latch8 ]
  store { i8**, i64 }* %t431, { i8**, i64 }** %l5
  store double %t432, double* %l7
  br label %loop.body7
loop.body7:
  %t266 = load double, double* %l7
  %t267 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t268 = extractvalue %EnumAggregateLayout %t267, 4
  %t269 = load { %EnumVariantLayoutDescriptor**, i64 }, { %EnumVariantLayoutDescriptor**, i64 }* %t268
  %t270 = extractvalue { %EnumVariantLayoutDescriptor**, i64 } %t269, 1
  %t271 = sitofp i64 %t270 to double
  %t272 = fcmp oge double %t266, %t271
  %t273 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t274 = load double, double* %l1
  %t275 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t276 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t277 = load i8*, i8** %l6
  %t278 = load double, double* %l7
  br i1 %t272, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t279 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t280 = extractvalue %EnumAggregateLayout %t279, 4
  %t281 = load double, double* %l7
  %t282 = call double @llvm.round.f64(double %t281)
  %t283 = fptosi double %t282 to i64
  %t284 = load { %EnumVariantLayoutDescriptor**, i64 }, { %EnumVariantLayoutDescriptor**, i64 }* %t280
  %t285 = extractvalue { %EnumVariantLayoutDescriptor**, i64 } %t284, 0
  %t286 = extractvalue { %EnumVariantLayoutDescriptor**, i64 } %t284, 1
  %t287 = icmp uge i64 %t283, %t286
  ; bounds check: %t287 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t283, i64 %t286)
  %t288 = getelementptr %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %t285, i64 %t283
  %t289 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %t288
  store %EnumVariantLayoutDescriptor* %t289, %EnumVariantLayoutDescriptor** %l8
  %s290 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1695010494, i32 0, i32 0
  %t291 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t292 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t291, i32 0, i32 0
  %t293 = load i8*, i8** %t292
  %t294 = call i8* @sailfin_runtime_string_concat(i8* %s290, i8* %t293)
  store i8* %t294, i8** %l9
  %t295 = load i8*, i8** %l9
  %s296 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1525558983, i32 0, i32 0
  %t297 = call i8* @sailfin_runtime_string_concat(i8* %t295, i8* %s296)
  %t298 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t299 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t298, i32 0, i32 1
  %t300 = load double, double* %t299
  %t301 = call i8* @number_to_string(double %t300)
  %t302 = call i8* @sailfin_runtime_string_concat(i8* %t297, i8* %t301)
  store i8* %t302, i8** %l9
  %t303 = load i8*, i8** %l9
  %s304 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h455185518, i32 0, i32 0
  %t305 = call i8* @sailfin_runtime_string_concat(i8* %t303, i8* %s304)
  %t306 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t307 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t306, i32 0, i32 2
  %t308 = load double, double* %t307
  %t309 = call i8* @number_to_string(double %t308)
  %t310 = call i8* @sailfin_runtime_string_concat(i8* %t305, i8* %t309)
  store i8* %t310, i8** %l9
  %t311 = load i8*, i8** %l9
  %s312 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h922402750, i32 0, i32 0
  %t313 = call i8* @sailfin_runtime_string_concat(i8* %t311, i8* %s312)
  %t314 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t315 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t314, i32 0, i32 3
  %t316 = load double, double* %t315
  %t317 = call i8* @number_to_string(double %t316)
  %t318 = call i8* @sailfin_runtime_string_concat(i8* %t313, i8* %t317)
  store i8* %t318, i8** %l9
  %t319 = load i8*, i8** %l9
  %s320 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h847788946, i32 0, i32 0
  %t321 = call i8* @sailfin_runtime_string_concat(i8* %t319, i8* %s320)
  %t322 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t323 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t322, i32 0, i32 4
  %t324 = load double, double* %t323
  %t325 = call i8* @number_to_string(double %t324)
  %t326 = call i8* @sailfin_runtime_string_concat(i8* %t321, i8* %t325)
  store i8* %t326, i8** %l9
  %t327 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t328 = load i8*, i8** %l9
  %t329 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t327, i8* %t328)
  store { i8**, i64 }* %t329, { i8**, i64 }** %l5
  %t330 = sitofp i64 0 to double
  store double %t330, double* %l10
  %t331 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t332 = load double, double* %l1
  %t333 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t334 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t335 = load i8*, i8** %l6
  %t336 = load double, double* %l7
  %t337 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t338 = load i8*, i8** %l9
  %t339 = load double, double* %l10
  br label %loop.header12
loop.header12:
  %t422 = phi { i8**, i64 }* [ %t334, %merge11 ], [ %t420, %loop.latch14 ]
  %t423 = phi double [ %t339, %merge11 ], [ %t421, %loop.latch14 ]
  store { i8**, i64 }* %t422, { i8**, i64 }** %l5
  store double %t423, double* %l10
  br label %loop.body13
loop.body13:
  %t340 = load double, double* %l10
  %t341 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t342 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t341, i32 0, i32 5
  %t343 = load { %StructFieldLayoutDescriptor**, i64 }*, { %StructFieldLayoutDescriptor**, i64 }** %t342
  %t344 = load { %StructFieldLayoutDescriptor**, i64 }, { %StructFieldLayoutDescriptor**, i64 }* %t343
  %t345 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t344, 1
  %t346 = sitofp i64 %t345 to double
  %t347 = fcmp oge double %t340, %t346
  %t348 = load { %LayoutEnumVariantDefinition*, i64 }*, { %LayoutEnumVariantDefinition*, i64 }** %l0
  %t349 = load double, double* %l1
  %t350 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t351 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t352 = load i8*, i8** %l6
  %t353 = load double, double* %l7
  %t354 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t355 = load i8*, i8** %l9
  %t356 = load double, double* %l10
  br i1 %t347, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t357 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t358 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t357, i32 0, i32 5
  %t359 = load { %StructFieldLayoutDescriptor**, i64 }*, { %StructFieldLayoutDescriptor**, i64 }** %t358
  %t360 = load double, double* %l10
  %t361 = call double @llvm.round.f64(double %t360)
  %t362 = fptosi double %t361 to i64
  %t363 = load { %StructFieldLayoutDescriptor**, i64 }, { %StructFieldLayoutDescriptor**, i64 }* %t359
  %t364 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t363, 0
  %t365 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t363, 1
  %t366 = icmp uge i64 %t362, %t365
  ; bounds check: %t366 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t362, i64 %t365)
  %t367 = getelementptr %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t364, i64 %t362
  %t368 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t367
  store %StructFieldLayoutDescriptor* %t368, %StructFieldLayoutDescriptor** %l11
  %s369 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1290415774, i32 0, i32 0
  %t370 = load %EnumVariantLayoutDescriptor*, %EnumVariantLayoutDescriptor** %l8
  %t371 = getelementptr %EnumVariantLayoutDescriptor, %EnumVariantLayoutDescriptor* %t370, i32 0, i32 0
  %t372 = load i8*, i8** %t371
  %t373 = call i8* @sailfin_runtime_string_concat(i8* %s369, i8* %t372)
  %t374 = alloca [2 x i8], align 1
  %t375 = getelementptr [2 x i8], [2 x i8]* %t374, i32 0, i32 0
  store i8 46, i8* %t375
  %t376 = getelementptr [2 x i8], [2 x i8]* %t374, i32 0, i32 1
  store i8 0, i8* %t376
  %t377 = getelementptr [2 x i8], [2 x i8]* %t374, i32 0, i32 0
  %t378 = call i8* @sailfin_runtime_string_concat(i8* %t373, i8* %t377)
  %t379 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l11
  %t380 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t379, i32 0, i32 0
  %t381 = load i8*, i8** %t380
  %t382 = call i8* @sailfin_runtime_string_concat(i8* %t378, i8* %t381)
  store i8* %t382, i8** %l12
  %t383 = load i8*, i8** %l12
  %s384 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h980153509, i32 0, i32 0
  %t385 = call i8* @sailfin_runtime_string_concat(i8* %t383, i8* %s384)
  %t386 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l11
  %t387 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t386, i32 0, i32 1
  %t388 = load i8*, i8** %t387
  %t389 = call i8* @sailfin_runtime_string_concat(i8* %t385, i8* %t388)
  store i8* %t389, i8** %l12
  %t390 = load i8*, i8** %l12
  %s391 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h455185518, i32 0, i32 0
  %t392 = call i8* @sailfin_runtime_string_concat(i8* %t390, i8* %s391)
  %t393 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l11
  %t394 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t393, i32 0, i32 2
  %t395 = load double, double* %t394
  %t396 = call i8* @number_to_string(double %t395)
  %t397 = call i8* @sailfin_runtime_string_concat(i8* %t392, i8* %t396)
  store i8* %t397, i8** %l12
  %t398 = load i8*, i8** %l12
  %s399 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h922402750, i32 0, i32 0
  %t400 = call i8* @sailfin_runtime_string_concat(i8* %t398, i8* %s399)
  %t401 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l11
  %t402 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t401, i32 0, i32 3
  %t403 = load double, double* %t402
  %t404 = call i8* @number_to_string(double %t403)
  %t405 = call i8* @sailfin_runtime_string_concat(i8* %t400, i8* %t404)
  store i8* %t405, i8** %l12
  %t406 = load i8*, i8** %l12
  %s407 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h847788946, i32 0, i32 0
  %t408 = call i8* @sailfin_runtime_string_concat(i8* %t406, i8* %s407)
  %t409 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l11
  %t410 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t409, i32 0, i32 4
  %t411 = load double, double* %t410
  %t412 = call i8* @number_to_string(double %t411)
  %t413 = call i8* @sailfin_runtime_string_concat(i8* %t408, i8* %t412)
  store i8* %t413, i8** %l12
  %t414 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t415 = load i8*, i8** %l12
  %t416 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t414, i8* %t415)
  store { i8**, i64 }* %t416, { i8**, i64 }** %l5
  %t417 = load double, double* %l10
  %t418 = sitofp i64 1 to double
  %t419 = fadd double %t417, %t418
  store double %t419, double* %l10
  br label %loop.latch14
loop.latch14:
  %t420 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t421 = load double, double* %l10
  br label %loop.header12
afterloop15:
  %t424 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t425 = load double, double* %l10
  %t426 = load double, double* %l7
  %t427 = sitofp i64 1 to double
  %t428 = fadd double %t426, %t427
  store double %t428, double* %l7
  br label %loop.latch8
loop.latch8:
  %t429 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t430 = load double, double* %l7
  br label %loop.header6
afterloop9:
  %t433 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t434 = load double, double* %l7
  %t435 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t436 = insertvalue %LayoutEmitResult undef, { i8**, i64 }* %t435, 0
  %t437 = load %EnumAggregateLayout, %EnumAggregateLayout* %l4
  %t438 = extractvalue %EnumAggregateLayout %t437, 5
  %t439 = insertvalue %LayoutEmitResult %t436, { i8**, i64 }* %t438, 1
  ret %LayoutEmitResult %t439
}

define %EnumAggregateLayout @infer_enum_aggregate_layout(%LayoutContext %context, i8* %enum_name, { %LayoutEnumVariantDefinition*, i64 }* %variants, { i8**, i64 }* %visiting) {
block.entry:
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
  %t4 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t5 = ptrtoint [0 x i8*]* %t4 to i64
  %t6 = icmp eq i64 %t5, 0
  %t7 = select i1 %t6, i64 1, i64 %t5
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to i8**
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t11 = ptrtoint { i8**, i64 }* %t10 to i64
  %t12 = call i8* @malloc(i64 %t11)
  %t13 = bitcast i8* %t12 to { i8**, i64 }*
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 0
  store i8** %t9, i8*** %t14
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { i8**, i64 }* %t13, { i8**, i64 }** %l4
  %t16 = getelementptr [0 x %EnumVariantLayoutDescriptor], [0 x %EnumVariantLayoutDescriptor]* null, i32 1
  %t17 = ptrtoint [0 x %EnumVariantLayoutDescriptor]* %t16 to i64
  %t18 = icmp eq i64 %t17, 0
  %t19 = select i1 %t18, i64 1, i64 %t17
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to %EnumVariantLayoutDescriptor*
  %t22 = getelementptr { %EnumVariantLayoutDescriptor*, i64 }, { %EnumVariantLayoutDescriptor*, i64 }* null, i32 1
  %t23 = ptrtoint { %EnumVariantLayoutDescriptor*, i64 }* %t22 to i64
  %t24 = call i8* @malloc(i64 %t23)
  %t25 = bitcast i8* %t24 to { %EnumVariantLayoutDescriptor*, i64 }*
  %t26 = getelementptr { %EnumVariantLayoutDescriptor*, i64 }, { %EnumVariantLayoutDescriptor*, i64 }* %t25, i32 0, i32 0
  store %EnumVariantLayoutDescriptor* %t21, %EnumVariantLayoutDescriptor** %t26
  %t27 = getelementptr { %EnumVariantLayoutDescriptor*, i64 }, { %EnumVariantLayoutDescriptor*, i64 }* %t25, i32 0, i32 1
  store i64 0, i64* %t27
  store { %EnumVariantLayoutDescriptor*, i64 }* %t25, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t28 = sitofp i64 0 to double
  store double %t28, double* %l6
  %t29 = load double, double* %l0
  %t30 = load double, double* %l1
  %t31 = load double, double* %l2
  %t32 = load double, double* %l3
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t34 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t35 = load double, double* %l6
  br label %loop.header0
loop.header0:
  %t258 = phi { i8**, i64 }* [ %t33, %block.entry ], [ %t253, %loop.latch2 ]
  %t259 = phi double [ %t31, %block.entry ], [ %t254, %loop.latch2 ]
  %t260 = phi double [ %t32, %block.entry ], [ %t255, %loop.latch2 ]
  %t261 = phi { %EnumVariantLayoutDescriptor*, i64 }* [ %t34, %block.entry ], [ %t256, %loop.latch2 ]
  %t262 = phi double [ %t35, %block.entry ], [ %t257, %loop.latch2 ]
  store { i8**, i64 }* %t258, { i8**, i64 }** %l4
  store double %t259, double* %l2
  store double %t260, double* %l3
  store { %EnumVariantLayoutDescriptor*, i64 }* %t261, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  store double %t262, double* %l6
  br label %loop.body1
loop.body1:
  %t36 = load double, double* %l6
  %t37 = load { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %variants
  %t38 = extractvalue { %LayoutEnumVariantDefinition*, i64 } %t37, 1
  %t39 = sitofp i64 %t38 to double
  %t40 = fcmp oge double %t36, %t39
  %t41 = load double, double* %l0
  %t42 = load double, double* %l1
  %t43 = load double, double* %l2
  %t44 = load double, double* %l3
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t46 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t47 = load double, double* %l6
  br i1 %t40, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t48 = load double, double* %l6
  %t49 = call double @llvm.round.f64(double %t48)
  %t50 = fptosi double %t49 to i64
  %t51 = load { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %variants
  %t52 = extractvalue { %LayoutEnumVariantDefinition*, i64 } %t51, 0
  %t53 = extractvalue { %LayoutEnumVariantDefinition*, i64 } %t51, 1
  %t54 = icmp uge i64 %t50, %t53
  ; bounds check: %t54 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t50, i64 %t53)
  %t55 = getelementptr %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %t52, i64 %t50
  %t56 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %t55
  store %LayoutEnumVariantDefinition %t56, %LayoutEnumVariantDefinition* %l7
  %t57 = alloca [2 x i8], align 1
  %t58 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 0
  store i8 46, i8* %t58
  %t59 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 1
  store i8 0, i8* %t59
  %t60 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 0
  %t61 = call i8* @sailfin_runtime_string_concat(i8* %enum_name, i8* %t60)
  %t62 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t63 = extractvalue %LayoutEnumVariantDefinition %t62, 0
  %t64 = call i8* @sailfin_runtime_string_concat(i8* %t61, i8* %t63)
  store i8* %t64, i8** %l8
  %t65 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t66 = extractvalue %LayoutEnumVariantDefinition %t65, 1
  %s67 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h513898090, i32 0, i32 0
  %t68 = load i8*, i8** %l8
  %t69 = bitcast { %LayoutFieldInput**, i64 }* %t66 to { %LayoutFieldInput*, i64 }*
  %t70 = call %RecordLayoutResult @calculate_record_layout(%LayoutContext %context, { %LayoutFieldInput*, i64 }* %t69, i8* %s67, i8* %t68, { i8**, i64 }* %visiting)
  store %RecordLayoutResult %t70, %RecordLayoutResult* %l9
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t72 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t73 = extractvalue %RecordLayoutResult %t72, 3
  %t74 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t71, { i8**, i64 }* %t73)
  store { i8**, i64 }* %t74, { i8**, i64 }** %l4
  %t75 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t76 = extractvalue %RecordLayoutResult %t75, 1
  store double %t76, double* %l10
  %t77 = load double, double* %l10
  %t78 = sitofp i64 0 to double
  %t79 = fcmp ole double %t77, %t78
  %t80 = load double, double* %l0
  %t81 = load double, double* %l1
  %t82 = load double, double* %l2
  %t83 = load double, double* %l3
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t85 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t86 = load double, double* %l6
  %t87 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t88 = load i8*, i8** %l8
  %t89 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t90 = load double, double* %l10
  br i1 %t79, label %then6, label %merge7
then6:
  %t91 = sitofp i64 1 to double
  store double %t91, double* %l10
  %t92 = load double, double* %l10
  br label %merge7
merge7:
  %t93 = phi double [ %t92, %then6 ], [ %t90, %merge5 ]
  store double %t93, double* %l10
  %t94 = load double, double* %l0
  %t95 = load double, double* %l10
  %t96 = call double @align_to(double %t94, double %t95)
  store double %t96, double* %l11
  %t97 = load double, double* %l10
  %t98 = load double, double* %l2
  %t99 = fcmp ogt double %t97, %t98
  %t100 = load double, double* %l0
  %t101 = load double, double* %l1
  %t102 = load double, double* %l2
  %t103 = load double, double* %l3
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t105 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t106 = load double, double* %l6
  %t107 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t108 = load i8*, i8** %l8
  %t109 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t110 = load double, double* %l10
  %t111 = load double, double* %l11
  br i1 %t99, label %then8, label %merge9
then8:
  %t112 = load double, double* %l10
  store double %t112, double* %l2
  %t113 = load double, double* %l2
  br label %merge9
merge9:
  %t114 = phi double [ %t113, %then8 ], [ %t102, %merge7 ]
  store double %t114, double* %l2
  %t115 = getelementptr [0 x %StructFieldLayoutDescriptor], [0 x %StructFieldLayoutDescriptor]* null, i32 1
  %t116 = ptrtoint [0 x %StructFieldLayoutDescriptor]* %t115 to i64
  %t117 = icmp eq i64 %t116, 0
  %t118 = select i1 %t117, i64 1, i64 %t116
  %t119 = call i8* @malloc(i64 %t118)
  %t120 = bitcast i8* %t119 to %StructFieldLayoutDescriptor*
  %t121 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* null, i32 1
  %t122 = ptrtoint { %StructFieldLayoutDescriptor*, i64 }* %t121 to i64
  %t123 = call i8* @malloc(i64 %t122)
  %t124 = bitcast i8* %t123 to { %StructFieldLayoutDescriptor*, i64 }*
  %t125 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t124, i32 0, i32 0
  store %StructFieldLayoutDescriptor* %t120, %StructFieldLayoutDescriptor** %t125
  %t126 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t124, i32 0, i32 1
  store i64 0, i64* %t126
  store { %StructFieldLayoutDescriptor*, i64 }* %t124, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t127 = sitofp i64 0 to double
  store double %t127, double* %l13
  %t128 = load double, double* %l0
  %t129 = load double, double* %l1
  %t130 = load double, double* %l2
  %t131 = load double, double* %l3
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t133 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t134 = load double, double* %l6
  %t135 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t136 = load i8*, i8** %l8
  %t137 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t138 = load double, double* %l10
  %t139 = load double, double* %l11
  %t140 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t141 = load double, double* %l13
  br label %loop.header10
loop.header10:
  %t204 = phi { %StructFieldLayoutDescriptor*, i64 }* [ %t140, %merge9 ], [ %t202, %loop.latch12 ]
  %t205 = phi double [ %t141, %merge9 ], [ %t203, %loop.latch12 ]
  store { %StructFieldLayoutDescriptor*, i64 }* %t204, { %StructFieldLayoutDescriptor*, i64 }** %l12
  store double %t205, double* %l13
  br label %loop.body11
loop.body11:
  %t142 = load double, double* %l13
  %t143 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t144 = extractvalue %RecordLayoutResult %t143, 2
  %t145 = load { %StructFieldLayoutDescriptor**, i64 }, { %StructFieldLayoutDescriptor**, i64 }* %t144
  %t146 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t145, 1
  %t147 = sitofp i64 %t146 to double
  %t148 = fcmp oge double %t142, %t147
  %t149 = load double, double* %l0
  %t150 = load double, double* %l1
  %t151 = load double, double* %l2
  %t152 = load double, double* %l3
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t154 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t155 = load double, double* %l6
  %t156 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t157 = load i8*, i8** %l8
  %t158 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t159 = load double, double* %l10
  %t160 = load double, double* %l11
  %t161 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t162 = load double, double* %l13
  br i1 %t148, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t163 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t164 = extractvalue %RecordLayoutResult %t163, 2
  %t165 = load double, double* %l13
  %t166 = call double @llvm.round.f64(double %t165)
  %t167 = fptosi double %t166 to i64
  %t168 = load { %StructFieldLayoutDescriptor**, i64 }, { %StructFieldLayoutDescriptor**, i64 }* %t164
  %t169 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t168, 0
  %t170 = extractvalue { %StructFieldLayoutDescriptor**, i64 } %t168, 1
  %t171 = icmp uge i64 %t167, %t170
  ; bounds check: %t171 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t167, i64 %t170)
  %t172 = getelementptr %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t169, i64 %t167
  %t173 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %t172
  store %StructFieldLayoutDescriptor* %t173, %StructFieldLayoutDescriptor** %l14
  %t174 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l14
  %t175 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t174, i32 0, i32 0
  %t176 = load i8*, i8** %t175
  %t177 = insertvalue %StructFieldLayoutDescriptor undef, i8* %t176, 0
  %t178 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l14
  %t179 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t178, i32 0, i32 1
  %t180 = load i8*, i8** %t179
  %t181 = insertvalue %StructFieldLayoutDescriptor %t177, i8* %t180, 1
  %t182 = load double, double* %l11
  %t183 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l14
  %t184 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t183, i32 0, i32 2
  %t185 = load double, double* %t184
  %t186 = fadd double %t182, %t185
  %t187 = insertvalue %StructFieldLayoutDescriptor %t181, double %t186, 2
  %t188 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l14
  %t189 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t188, i32 0, i32 3
  %t190 = load double, double* %t189
  %t191 = insertvalue %StructFieldLayoutDescriptor %t187, double %t190, 3
  %t192 = load %StructFieldLayoutDescriptor*, %StructFieldLayoutDescriptor** %l14
  %t193 = getelementptr %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %t192, i32 0, i32 4
  %t194 = load double, double* %t193
  %t195 = insertvalue %StructFieldLayoutDescriptor %t191, double %t194, 4
  store %StructFieldLayoutDescriptor %t195, %StructFieldLayoutDescriptor* %l15
  %t196 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t197 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l15
  %t198 = call { %StructFieldLayoutDescriptor*, i64 }* @append_struct_field_layout({ %StructFieldLayoutDescriptor*, i64 }* %t196, %StructFieldLayoutDescriptor %t197)
  store { %StructFieldLayoutDescriptor*, i64 }* %t198, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t199 = load double, double* %l13
  %t200 = sitofp i64 1 to double
  %t201 = fadd double %t199, %t200
  store double %t201, double* %l13
  br label %loop.latch12
loop.latch12:
  %t202 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t203 = load double, double* %l13
  br label %loop.header10
afterloop13:
  %t206 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t207 = load double, double* %l13
  %t208 = load double, double* %l11
  %t209 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t210 = extractvalue %RecordLayoutResult %t209, 0
  %t211 = fadd double %t208, %t210
  store double %t211, double* %l16
  %t212 = load double, double* %l16
  %t213 = load double, double* %l3
  %t214 = fcmp ogt double %t212, %t213
  %t215 = load double, double* %l0
  %t216 = load double, double* %l1
  %t217 = load double, double* %l2
  %t218 = load double, double* %l3
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t220 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t221 = load double, double* %l6
  %t222 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t223 = load i8*, i8** %l8
  %t224 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t225 = load double, double* %l10
  %t226 = load double, double* %l11
  %t227 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t228 = load double, double* %l13
  %t229 = load double, double* %l16
  br i1 %t214, label %then16, label %merge17
then16:
  %t230 = load double, double* %l16
  store double %t230, double* %l3
  %t231 = load double, double* %l3
  br label %merge17
merge17:
  %t232 = phi double [ %t231, %then16 ], [ %t218, %afterloop13 ]
  store double %t232, double* %l3
  %t233 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t234 = load %LayoutEnumVariantDefinition, %LayoutEnumVariantDefinition* %l7
  %t235 = extractvalue %LayoutEnumVariantDefinition %t234, 0
  %t236 = insertvalue %EnumVariantLayoutDescriptor undef, i8* %t235, 0
  %t237 = load double, double* %l6
  %t238 = insertvalue %EnumVariantLayoutDescriptor %t236, double %t237, 1
  %t239 = load double, double* %l11
  %t240 = insertvalue %EnumVariantLayoutDescriptor %t238, double %t239, 2
  %t241 = load %RecordLayoutResult, %RecordLayoutResult* %l9
  %t242 = extractvalue %RecordLayoutResult %t241, 0
  %t243 = insertvalue %EnumVariantLayoutDescriptor %t240, double %t242, 3
  %t244 = load double, double* %l10
  %t245 = insertvalue %EnumVariantLayoutDescriptor %t243, double %t244, 4
  %t246 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l12
  %t247 = bitcast { %StructFieldLayoutDescriptor*, i64 }* %t246 to { %StructFieldLayoutDescriptor**, i64 }*
  %t248 = insertvalue %EnumVariantLayoutDescriptor %t245, { %StructFieldLayoutDescriptor**, i64 }* %t247, 5
  %t249 = call { %EnumVariantLayoutDescriptor*, i64 }* @append_enum_variant_layout({ %EnumVariantLayoutDescriptor*, i64 }* %t233, %EnumVariantLayoutDescriptor %t248)
  store { %EnumVariantLayoutDescriptor*, i64 }* %t249, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t250 = load double, double* %l6
  %t251 = sitofp i64 1 to double
  %t252 = fadd double %t250, %t251
  store double %t252, double* %l6
  br label %loop.latch2
loop.latch2:
  %t253 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t254 = load double, double* %l2
  %t255 = load double, double* %l3
  %t256 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t257 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t263 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t264 = load double, double* %l2
  %t265 = load double, double* %l3
  %t266 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t267 = load double, double* %l6
  %t268 = load { %LayoutEnumVariantDefinition*, i64 }, { %LayoutEnumVariantDefinition*, i64 }* %variants
  %t269 = extractvalue { %LayoutEnumVariantDefinition*, i64 } %t268, 1
  %t270 = icmp eq i64 %t269, 0
  %t271 = load double, double* %l0
  %t272 = load double, double* %l1
  %t273 = load double, double* %l2
  %t274 = load double, double* %l3
  %t275 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t276 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t277 = load double, double* %l6
  br i1 %t270, label %then18, label %merge19
then18:
  %t278 = load double, double* %l1
  store double %t278, double* %l2
  %t279 = load double, double* %l0
  store double %t279, double* %l3
  %t280 = load double, double* %l2
  %t281 = load double, double* %l3
  br label %merge19
merge19:
  %t282 = phi double [ %t280, %then18 ], [ %t273, %afterloop3 ]
  %t283 = phi double [ %t281, %then18 ], [ %t274, %afterloop3 ]
  store double %t282, double* %l2
  store double %t283, double* %l3
  %t284 = load double, double* %l2
  store double %t284, double* %l17
  %t285 = load double, double* %l17
  %t286 = sitofp i64 0 to double
  %t287 = fcmp ole double %t285, %t286
  %t288 = load double, double* %l0
  %t289 = load double, double* %l1
  %t290 = load double, double* %l2
  %t291 = load double, double* %l3
  %t292 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t293 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t294 = load double, double* %l6
  %t295 = load double, double* %l17
  br i1 %t287, label %then20, label %merge21
then20:
  %t296 = sitofp i64 1 to double
  store double %t296, double* %l17
  %t297 = load double, double* %l17
  br label %merge21
merge21:
  %t298 = phi double [ %t297, %then20 ], [ %t295, %merge19 ]
  store double %t298, double* %l17
  %t299 = load double, double* %l3
  store double %t299, double* %l18
  %t300 = load double, double* %l17
  %t301 = sitofp i64 1 to double
  %t302 = fcmp ogt double %t300, %t301
  %t303 = load double, double* %l0
  %t304 = load double, double* %l1
  %t305 = load double, double* %l2
  %t306 = load double, double* %l3
  %t307 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t308 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t309 = load double, double* %l6
  %t310 = load double, double* %l17
  %t311 = load double, double* %l18
  br i1 %t302, label %then22, label %merge23
then22:
  %t312 = load double, double* %l3
  %t313 = load double, double* %l17
  %t314 = call double @align_to(double %t312, double %t313)
  store double %t314, double* %l18
  %t315 = load double, double* %l18
  br label %merge23
merge23:
  %t316 = phi double [ %t315, %then22 ], [ %t311, %merge21 ]
  store double %t316, double* %l18
  %t317 = load double, double* %l18
  %t318 = insertvalue %EnumAggregateLayout undef, double %t317, 0
  %t319 = load double, double* %l17
  %t320 = insertvalue %EnumAggregateLayout %t318, double %t319, 1
  %t321 = load double, double* %l0
  %t322 = insertvalue %EnumAggregateLayout %t320, double %t321, 2
  %t323 = load double, double* %l1
  %t324 = insertvalue %EnumAggregateLayout %t322, double %t323, 3
  %t325 = load { %EnumVariantLayoutDescriptor*, i64 }*, { %EnumVariantLayoutDescriptor*, i64 }** %l5
  %t326 = bitcast { %EnumVariantLayoutDescriptor*, i64 }* %t325 to { %EnumVariantLayoutDescriptor**, i64 }*
  %t327 = insertvalue %EnumAggregateLayout %t324, { %EnumVariantLayoutDescriptor**, i64 }* %t326, 4
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t329 = insertvalue %EnumAggregateLayout %t327, { i8**, i64 }* %t328, 5
  ret %EnumAggregateLayout %t329
}

define %RecordLayoutResult @calculate_record_layout(%LayoutContext %context, { %LayoutFieldInput*, i64 }* %inputs, i8* %container_kind, i8* %container_name, { i8**, i64 }* %visiting) {
block.entry:
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
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = getelementptr [0 x %StructFieldLayoutDescriptor], [0 x %StructFieldLayoutDescriptor]* null, i32 1
  %t13 = ptrtoint [0 x %StructFieldLayoutDescriptor]* %t12 to i64
  %t14 = icmp eq i64 %t13, 0
  %t15 = select i1 %t14, i64 1, i64 %t13
  %t16 = call i8* @malloc(i64 %t15)
  %t17 = bitcast i8* %t16 to %StructFieldLayoutDescriptor*
  %t18 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* null, i32 1
  %t19 = ptrtoint { %StructFieldLayoutDescriptor*, i64 }* %t18 to i64
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to { %StructFieldLayoutDescriptor*, i64 }*
  %t22 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t21, i32 0, i32 0
  store %StructFieldLayoutDescriptor* %t17, %StructFieldLayoutDescriptor** %t22
  %t23 = getelementptr { %StructFieldLayoutDescriptor*, i64 }, { %StructFieldLayoutDescriptor*, i64 }* %t21, i32 0, i32 1
  store i64 0, i64* %t23
  store { %StructFieldLayoutDescriptor*, i64 }* %t21, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t24 = sitofp i64 0 to double
  store double %t24, double* %l2
  %t25 = sitofp i64 1 to double
  store double %t25, double* %l3
  %t26 = sitofp i64 0 to double
  store double %t26, double* %l4
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t29 = load double, double* %l2
  %t30 = load double, double* %l3
  %t31 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t123 = phi { i8**, i64 }* [ %t27, %block.entry ], [ %t118, %loop.latch2 ]
  %t124 = phi double [ %t29, %block.entry ], [ %t119, %loop.latch2 ]
  %t125 = phi { %StructFieldLayoutDescriptor*, i64 }* [ %t28, %block.entry ], [ %t120, %loop.latch2 ]
  %t126 = phi double [ %t30, %block.entry ], [ %t121, %loop.latch2 ]
  %t127 = phi double [ %t31, %block.entry ], [ %t122, %loop.latch2 ]
  store { i8**, i64 }* %t123, { i8**, i64 }** %l0
  store double %t124, double* %l2
  store { %StructFieldLayoutDescriptor*, i64 }* %t125, { %StructFieldLayoutDescriptor*, i64 }** %l1
  store double %t126, double* %l3
  store double %t127, double* %l4
  br label %loop.body1
loop.body1:
  %t32 = load double, double* %l4
  %t33 = load { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %inputs
  %t34 = extractvalue { %LayoutFieldInput*, i64 } %t33, 1
  %t35 = sitofp i64 %t34 to double
  %t36 = fcmp oge double %t32, %t35
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t39 = load double, double* %l2
  %t40 = load double, double* %l3
  %t41 = load double, double* %l4
  br i1 %t36, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t42 = load double, double* %l4
  %t43 = call double @llvm.round.f64(double %t42)
  %t44 = fptosi double %t43 to i64
  %t45 = load { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %inputs
  %t46 = extractvalue { %LayoutFieldInput*, i64 } %t45, 0
  %t47 = extractvalue { %LayoutFieldInput*, i64 } %t45, 1
  %t48 = icmp uge i64 %t44, %t47
  ; bounds check: %t48 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t44, i64 %t47)
  %t49 = getelementptr %LayoutFieldInput, %LayoutFieldInput* %t46, i64 %t44
  %t50 = load %LayoutFieldInput, %LayoutFieldInput* %t49
  store %LayoutFieldInput %t50, %LayoutFieldInput* %l5
  %t51 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t52 = extractvalue %LayoutFieldInput %t51, 1
  %t53 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t54 = extractvalue %LayoutFieldInput %t53, 0
  %t55 = call %TypeLayoutInfo @analyze_type_layout(%LayoutContext %context, { i8**, i64 }* %visiting, i8* %t52, i8* %container_kind, i8* %container_name, i8* %t54)
  store %TypeLayoutInfo %t55, %TypeLayoutInfo* %l6
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t57 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t58 = extractvalue %TypeLayoutInfo %t57, 2
  %t59 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t56, { i8**, i64 }* %t58)
  store { i8**, i64 }* %t59, { i8**, i64 }** %l0
  %t60 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t61 = extractvalue %TypeLayoutInfo %t60, 1
  store double %t61, double* %l7
  %t62 = load double, double* %l7
  %t63 = sitofp i64 0 to double
  %t64 = fcmp ole double %t62, %t63
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t67 = load double, double* %l2
  %t68 = load double, double* %l3
  %t69 = load double, double* %l4
  %t70 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t71 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t72 = load double, double* %l7
  br i1 %t64, label %then6, label %merge7
then6:
  %t73 = sitofp i64 1 to double
  store double %t73, double* %l7
  %t74 = load double, double* %l7
  br label %merge7
merge7:
  %t75 = phi double [ %t74, %then6 ], [ %t72, %merge5 ]
  store double %t75, double* %l7
  %t76 = load double, double* %l2
  %t77 = load double, double* %l7
  %t78 = call double @align_to(double %t76, double %t77)
  store double %t78, double* %l2
  %t79 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t80 = extractvalue %LayoutFieldInput %t79, 0
  %t81 = insertvalue %StructFieldLayoutDescriptor undef, i8* %t80, 0
  %t82 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t83 = extractvalue %LayoutFieldInput %t82, 1
  %t84 = call i8* @trim_text(i8* %t83)
  %t85 = insertvalue %StructFieldLayoutDescriptor %t81, i8* %t84, 1
  %t86 = load double, double* %l2
  %t87 = insertvalue %StructFieldLayoutDescriptor %t85, double %t86, 2
  %t88 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t89 = extractvalue %TypeLayoutInfo %t88, 0
  %t90 = insertvalue %StructFieldLayoutDescriptor %t87, double %t89, 3
  %t91 = load double, double* %l7
  %t92 = insertvalue %StructFieldLayoutDescriptor %t90, double %t91, 4
  store %StructFieldLayoutDescriptor %t92, %StructFieldLayoutDescriptor* %l8
  %t93 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t94 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l8
  %t95 = call { %StructFieldLayoutDescriptor*, i64 }* @append_struct_field_layout({ %StructFieldLayoutDescriptor*, i64 }* %t93, %StructFieldLayoutDescriptor %t94)
  store { %StructFieldLayoutDescriptor*, i64 }* %t95, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t96 = load double, double* %l2
  %t97 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t98 = extractvalue %TypeLayoutInfo %t97, 0
  %t99 = fadd double %t96, %t98
  store double %t99, double* %l2
  %t100 = load double, double* %l7
  %t101 = load double, double* %l3
  %t102 = fcmp ogt double %t100, %t101
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t104 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t105 = load double, double* %l2
  %t106 = load double, double* %l3
  %t107 = load double, double* %l4
  %t108 = load %LayoutFieldInput, %LayoutFieldInput* %l5
  %t109 = load %TypeLayoutInfo, %TypeLayoutInfo* %l6
  %t110 = load double, double* %l7
  %t111 = load %StructFieldLayoutDescriptor, %StructFieldLayoutDescriptor* %l8
  br i1 %t102, label %then8, label %merge9
then8:
  %t112 = load double, double* %l7
  store double %t112, double* %l3
  %t113 = load double, double* %l3
  br label %merge9
merge9:
  %t114 = phi double [ %t113, %then8 ], [ %t106, %merge7 ]
  store double %t114, double* %l3
  %t115 = load double, double* %l4
  %t116 = sitofp i64 1 to double
  %t117 = fadd double %t115, %t116
  store double %t117, double* %l4
  br label %loop.latch2
loop.latch2:
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t119 = load double, double* %l2
  %t120 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t121 = load double, double* %l3
  %t122 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t129 = load double, double* %l2
  %t130 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t131 = load double, double* %l3
  %t132 = load double, double* %l4
  %t133 = load double, double* %l3
  store double %t133, double* %l9
  %t134 = load { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %inputs
  %t135 = extractvalue { %LayoutFieldInput*, i64 } %t134, 1
  %t136 = icmp eq i64 %t135, 0
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t138 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t139 = load double, double* %l2
  %t140 = load double, double* %l3
  %t141 = load double, double* %l4
  %t142 = load double, double* %l9
  br i1 %t136, label %then10, label %merge11
then10:
  %t143 = sitofp i64 1 to double
  store double %t143, double* %l9
  %t144 = load double, double* %l9
  br label %merge11
merge11:
  %t145 = phi double [ %t144, %then10 ], [ %t142, %afterloop3 ]
  store double %t145, double* %l9
  %t146 = load double, double* %l9
  %t147 = sitofp i64 0 to double
  %t148 = fcmp ole double %t146, %t147
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t150 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t151 = load double, double* %l2
  %t152 = load double, double* %l3
  %t153 = load double, double* %l4
  %t154 = load double, double* %l9
  br i1 %t148, label %then12, label %merge13
then12:
  %t155 = sitofp i64 1 to double
  store double %t155, double* %l9
  %t156 = load double, double* %l9
  br label %merge13
merge13:
  %t157 = phi double [ %t156, %then12 ], [ %t154, %merge11 ]
  store double %t157, double* %l9
  %t158 = load double, double* %l2
  store double %t158, double* %l10
  %t159 = load double, double* %l9
  %t160 = sitofp i64 1 to double
  %t161 = fcmp ogt double %t159, %t160
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t163 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t164 = load double, double* %l2
  %t165 = load double, double* %l3
  %t166 = load double, double* %l4
  %t167 = load double, double* %l9
  %t168 = load double, double* %l10
  br i1 %t161, label %then14, label %merge15
then14:
  %t169 = load double, double* %l2
  %t170 = load double, double* %l9
  %t171 = call double @align_to(double %t169, double %t170)
  store double %t171, double* %l10
  %t172 = load double, double* %l10
  br label %merge15
merge15:
  %t173 = phi double [ %t172, %then14 ], [ %t168, %merge13 ]
  store double %t173, double* %l10
  %t174 = load double, double* %l10
  %t175 = insertvalue %RecordLayoutResult undef, double %t174, 0
  %t176 = load double, double* %l9
  %t177 = insertvalue %RecordLayoutResult %t175, double %t176, 1
  %t178 = load { %StructFieldLayoutDescriptor*, i64 }*, { %StructFieldLayoutDescriptor*, i64 }** %l1
  %t179 = bitcast { %StructFieldLayoutDescriptor*, i64 }* %t178 to { %StructFieldLayoutDescriptor**, i64 }*
  %t180 = insertvalue %RecordLayoutResult %t177, { %StructFieldLayoutDescriptor**, i64 }* %t179, 2
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t182 = insertvalue %RecordLayoutResult %t180, { i8**, i64 }* %t181, 3
  ret %RecordLayoutResult %t182
}

define %TypeLayoutInfo @analyze_type_layout(%LayoutContext %context, { i8**, i64 }* %visiting, i8* %type_annotation, i8* %container_kind, i8* %container_name, i8* %field_name) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i8*
  %l3 = alloca %LayoutStructDefinition*
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca %RecordLayoutResult
  %l6 = alloca %LayoutEnumDefinition*
  %l7 = alloca { i8**, i64 }*
  %l8 = alloca %EnumAggregateLayout
  %l9 = alloca %CanonicalTypeLayout*
  %t0 = call i8* @trim_text(i8* %type_annotation)
  store i8* %t0, i8** %l0
  %t1 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t2 = ptrtoint [0 x i8*]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to i8**
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t8 = ptrtoint { i8**, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { i8**, i64 }*
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t6, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { i8**, i64 }* %t10, { i8**, i64 }** %l1
  %t13 = load i8*, i8** %l0
  %t14 = call i64 @sailfin_runtime_string_length(i8* %t13)
  %t15 = icmp eq i64 %t14, 0
  %t16 = load i8*, i8** %l0
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t15, label %then0, label %merge1
then0:
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s19 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1833630044, i32 0, i32 0
  %t20 = call i8* @sailfin_runtime_string_concat(i8* %s19, i8* %container_kind)
  %s21 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415015, i32 0, i32 0
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %t20, i8* %s21)
  %t23 = call i8* @sailfin_runtime_string_concat(i8* %t22, i8* %container_name)
  %s24 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1449250559, i32 0, i32 0
  %t25 = call i8* @sailfin_runtime_string_concat(i8* %t23, i8* %s24)
  %t26 = call i8* @sailfin_runtime_string_concat(i8* %t25, i8* %field_name)
  %s27 = getelementptr inbounds [56 x i8], [56 x i8]* @.str.len55.h700951597, i32 0, i32 0
  %t28 = call i8* @sailfin_runtime_string_concat(i8* %t26, i8* %s27)
  %t29 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t18, i8* %t28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l1
  %t30 = sitofp i64 8 to double
  %t31 = insertvalue %TypeLayoutInfo undef, double %t30, 0
  %t32 = sitofp i64 8 to double
  %t33 = insertvalue %TypeLayoutInfo %t31, double %t32, 1
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t35 = insertvalue %TypeLayoutInfo %t33, { i8**, i64 }* %t34, 2
  ret %TypeLayoutInfo %t35
merge1:
  %t36 = load i8*, i8** %l0
  %s37 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h807326654, i32 0, i32 0
  %t38 = call i1 @strings_equal(i8* %t36, i8* %s37)
  %t39 = load i8*, i8** %l0
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t38, label %then2, label %merge3
then2:
  %t41 = sitofp i64 8 to double
  %t42 = insertvalue %TypeLayoutInfo undef, double %t41, 0
  %t43 = sitofp i64 8 to double
  %t44 = insertvalue %TypeLayoutInfo %t42, double %t43, 1
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t46 = insertvalue %TypeLayoutInfo %t44, { i8**, i64 }* %t45, 2
  ret %TypeLayoutInfo %t46
merge3:
  %t48 = load i8*, i8** %l0
  %s49 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090370613, i32 0, i32 0
  %t50 = call i1 @strings_equal(i8* %t48, i8* %s49)
  br label %logical_or_entry_47

logical_or_entry_47:
  br i1 %t50, label %logical_or_merge_47, label %logical_or_right_47

logical_or_right_47:
  %t51 = load i8*, i8** %l0
  %s52 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090307517, i32 0, i32 0
  %t53 = call i1 @strings_equal(i8* %t51, i8* %s52)
  br label %logical_or_right_end_47

logical_or_right_end_47:
  br label %logical_or_merge_47

logical_or_merge_47:
  %t54 = phi i1 [ true, %logical_or_entry_47 ], [ %t53, %logical_or_right_end_47 ]
  %t55 = load i8*, i8** %l0
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t54, label %then4, label %merge5
then4:
  %t57 = sitofp i64 8 to double
  %t58 = insertvalue %TypeLayoutInfo undef, double %t57, 0
  %t59 = sitofp i64 8 to double
  %t60 = insertvalue %TypeLayoutInfo %t58, double %t59, 1
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t62 = insertvalue %TypeLayoutInfo %t60, { i8**, i64 }* %t61, 2
  ret %TypeLayoutInfo %t62
merge5:
  %t63 = load i8*, i8** %l0
  %s64 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090304184, i32 0, i32 0
  %t65 = call i1 @strings_equal(i8* %t63, i8* %s64)
  %t66 = load i8*, i8** %l0
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t65, label %then6, label %merge7
then6:
  %t68 = sitofp i64 4 to double
  %t69 = insertvalue %TypeLayoutInfo undef, double %t68, 0
  %t70 = sitofp i64 4 to double
  %t71 = insertvalue %TypeLayoutInfo %t69, double %t70, 1
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t73 = insertvalue %TypeLayoutInfo %t71, { i8**, i64 }* %t72, 2
  ret %TypeLayoutInfo %t73
merge7:
  %t75 = load i8*, i8** %l0
  %s76 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h1483009776, i32 0, i32 0
  %t77 = call i1 @strings_equal(i8* %t75, i8* %s76)
  br label %logical_or_entry_74

logical_or_entry_74:
  br i1 %t77, label %logical_or_merge_74, label %logical_or_right_74

logical_or_right_74:
  %t79 = load i8*, i8** %l0
  %s80 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h254486039, i32 0, i32 0
  %t81 = call i1 @strings_equal(i8* %t79, i8* %s80)
  br label %logical_or_entry_78

logical_or_entry_78:
  br i1 %t81, label %logical_or_merge_78, label %logical_or_right_78

logical_or_right_78:
  %t82 = load i8*, i8** %l0
  %s83 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193492961, i32 0, i32 0
  %t84 = call i1 @strings_equal(i8* %t82, i8* %s83)
  br label %logical_or_right_end_78

logical_or_right_end_78:
  br label %logical_or_merge_78

logical_or_merge_78:
  %t85 = phi i1 [ true, %logical_or_entry_78 ], [ %t84, %logical_or_right_end_78 ]
  br label %logical_or_right_end_74

logical_or_right_end_74:
  br label %logical_or_merge_74

logical_or_merge_74:
  %t86 = phi i1 [ true, %logical_or_entry_74 ], [ %t85, %logical_or_right_end_74 ]
  %t87 = load i8*, i8** %l0
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t86, label %then8, label %merge9
then8:
  %t89 = sitofp i64 1 to double
  %t90 = insertvalue %TypeLayoutInfo undef, double %t89, 0
  %t91 = sitofp i64 1 to double
  %t92 = insertvalue %TypeLayoutInfo %t90, double %t91, 1
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t94 = insertvalue %TypeLayoutInfo %t92, { i8**, i64 }* %t93, 2
  ret %TypeLayoutInfo %t94
merge9:
  %t95 = load i8*, i8** %l0
  %s96 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090083282, i32 0, i32 0
  %t97 = call i1 @strings_equal(i8* %t95, i8* %s96)
  %t98 = load i8*, i8** %l0
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t97, label %then10, label %merge11
then10:
  %t100 = sitofp i64 8 to double
  %t101 = insertvalue %TypeLayoutInfo undef, double %t100, 0
  %t102 = sitofp i64 8 to double
  %t103 = insertvalue %TypeLayoutInfo %t101, double %t102, 1
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t105 = insertvalue %TypeLayoutInfo %t103, { i8**, i64 }* %t104, 2
  ret %TypeLayoutInfo %t105
merge11:
  %t106 = load i8*, i8** %l0
  %t107 = call i1 @is_array_type(i8* %t106)
  %t108 = load i8*, i8** %l0
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t107, label %then12, label %merge13
then12:
  %t110 = sitofp i64 8 to double
  %t111 = insertvalue %TypeLayoutInfo undef, double %t110, 0
  %t112 = sitofp i64 8 to double
  %t113 = insertvalue %TypeLayoutInfo %t111, double %t112, 1
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t115 = insertvalue %TypeLayoutInfo %t113, { i8**, i64 }* %t114, 2
  ret %TypeLayoutInfo %t115
merge13:
  %t116 = load i8*, i8** %l0
  %s117 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h789270767, i32 0, i32 0
  %t118 = call i1 @strings_equal(i8* %t116, i8* %s117)
  %t119 = load i8*, i8** %l0
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t118, label %then14, label %merge15
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
  %t128 = call i1 @is_optional_annotation(i8* %t127)
  %t129 = load i8*, i8** %l0
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t128, label %then16, label %merge17
then16:
  %t131 = load i8*, i8** %l0
  %t132 = call i8* @strip_optional_suffix(i8* %t131)
  %t133 = call i8* @trim_text(i8* %t132)
  store i8* %t133, i8** %l2
  %t134 = load i8*, i8** %l2
  %t135 = call i64 @sailfin_runtime_string_length(i8* %t134)
  %t136 = icmp eq i64 %t135, 0
  %t137 = load i8*, i8** %l0
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t139 = load i8*, i8** %l2
  br i1 %t136, label %then18, label %merge19
then18:
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s141 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1833630044, i32 0, i32 0
  %t142 = call i8* @sailfin_runtime_string_concat(i8* %s141, i8* %container_kind)
  %s143 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415015, i32 0, i32 0
  %t144 = call i8* @sailfin_runtime_string_concat(i8* %t142, i8* %s143)
  %t145 = call i8* @sailfin_runtime_string_concat(i8* %t144, i8* %container_name)
  %s146 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1449250559, i32 0, i32 0
  %t147 = call i8* @sailfin_runtime_string_concat(i8* %t145, i8* %s146)
  %t148 = call i8* @sailfin_runtime_string_concat(i8* %t147, i8* %field_name)
  %s149 = getelementptr inbounds [71 x i8], [71 x i8]* @.str.len70.h1478160845, i32 0, i32 0
  %t150 = call i8* @sailfin_runtime_string_concat(i8* %t148, i8* %s149)
  %t151 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t140, i8* %t150)
  store { i8**, i64 }* %t151, { i8**, i64 }** %l1
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t153 = phi { i8**, i64 }* [ %t152, %then18 ], [ %t138, %then16 ]
  store { i8**, i64 }* %t153, { i8**, i64 }** %l1
  %t154 = sitofp i64 8 to double
  %t155 = insertvalue %TypeLayoutInfo undef, double %t154, 0
  %t156 = sitofp i64 8 to double
  %t157 = insertvalue %TypeLayoutInfo %t155, double %t156, 1
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t159 = insertvalue %TypeLayoutInfo %t157, { i8**, i64 }* %t158, 2
  ret %TypeLayoutInfo %t159
merge17:
  %t160 = load i8*, i8** %l0
  %t161 = call i1 @contains_string({ i8**, i64 }* %visiting, i8* %t160)
  %t162 = load i8*, i8** %l0
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t161, label %then20, label %merge21
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
  %t171 = call %LayoutStructDefinition* @find_layout_struct_definition(%LayoutContext %context, i8* %t170)
  store %LayoutStructDefinition* %t171, %LayoutStructDefinition** %l3
  %t172 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l3
  %t173 = icmp ne %LayoutStructDefinition* %t172, null
  %t174 = load i8*, i8** %l0
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t176 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l3
  br i1 %t173, label %then22, label %merge23
then22:
  %t177 = load i8*, i8** %l0
  %t178 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %visiting, i8* %t177)
  store { i8**, i64 }* %t178, { i8**, i64 }** %l4
  %t179 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l3
  %t180 = getelementptr %LayoutStructDefinition, %LayoutStructDefinition* %t179, i32 0, i32 1
  %t181 = load { %LayoutFieldInput**, i64 }*, { %LayoutFieldInput**, i64 }** %t180
  %s182 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h789690461, i32 0, i32 0
  %t183 = load i8*, i8** %l0
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t185 = bitcast { %LayoutFieldInput**, i64 }* %t181 to { %LayoutFieldInput*, i64 }*
  %t186 = call %RecordLayoutResult @calculate_record_layout(%LayoutContext %context, { %LayoutFieldInput*, i64 }* %t185, i8* %s182, i8* %t183, { i8**, i64 }* %t184)
  store %RecordLayoutResult %t186, %RecordLayoutResult* %l5
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t188 = load %RecordLayoutResult, %RecordLayoutResult* %l5
  %t189 = extractvalue %RecordLayoutResult %t188, 3
  %t190 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t187, { i8**, i64 }* %t189)
  store { i8**, i64 }* %t190, { i8**, i64 }** %l1
  %t191 = load %RecordLayoutResult, %RecordLayoutResult* %l5
  %t192 = extractvalue %RecordLayoutResult %t191, 0
  %t193 = insertvalue %TypeLayoutInfo undef, double %t192, 0
  %t194 = load %RecordLayoutResult, %RecordLayoutResult* %l5
  %t195 = extractvalue %RecordLayoutResult %t194, 1
  %t196 = insertvalue %TypeLayoutInfo %t193, double %t195, 1
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t198 = insertvalue %TypeLayoutInfo %t196, { i8**, i64 }* %t197, 2
  ret %TypeLayoutInfo %t198
merge23:
  %t199 = load i8*, i8** %l0
  %t200 = call %LayoutEnumDefinition* @find_layout_enum_definition(%LayoutContext %context, i8* %t199)
  store %LayoutEnumDefinition* %t200, %LayoutEnumDefinition** %l6
  %t201 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %l6
  %t202 = icmp ne %LayoutEnumDefinition* %t201, null
  %t203 = load i8*, i8** %l0
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t205 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l3
  %t206 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %l6
  br i1 %t202, label %then24, label %merge25
then24:
  %t207 = load i8*, i8** %l0
  %t208 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %visiting, i8* %t207)
  store { i8**, i64 }* %t208, { i8**, i64 }** %l7
  %t209 = load i8*, i8** %l0
  %t210 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %l6
  %t211 = getelementptr %LayoutEnumDefinition, %LayoutEnumDefinition* %t210, i32 0, i32 1
  %t212 = load { %LayoutEnumVariantDefinition**, i64 }*, { %LayoutEnumVariantDefinition**, i64 }** %t211
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t214 = bitcast { %LayoutEnumVariantDefinition**, i64 }* %t212 to { %LayoutEnumVariantDefinition*, i64 }*
  %t215 = call %EnumAggregateLayout @infer_enum_aggregate_layout(%LayoutContext %context, i8* %t209, { %LayoutEnumVariantDefinition*, i64 }* %t214, { i8**, i64 }* %t213)
  store %EnumAggregateLayout %t215, %EnumAggregateLayout* %l8
  %t216 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t217 = load %EnumAggregateLayout, %EnumAggregateLayout* %l8
  %t218 = extractvalue %EnumAggregateLayout %t217, 5
  %t219 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t216, { i8**, i64 }* %t218)
  store { i8**, i64 }* %t219, { i8**, i64 }** %l1
  %t220 = load %EnumAggregateLayout, %EnumAggregateLayout* %l8
  %t221 = extractvalue %EnumAggregateLayout %t220, 0
  %t222 = insertvalue %TypeLayoutInfo undef, double %t221, 0
  %t223 = load %EnumAggregateLayout, %EnumAggregateLayout* %l8
  %t224 = extractvalue %EnumAggregateLayout %t223, 1
  %t225 = insertvalue %TypeLayoutInfo %t222, double %t224, 1
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t227 = insertvalue %TypeLayoutInfo %t225, { i8**, i64 }* %t226, 2
  ret %TypeLayoutInfo %t227
merge25:
  %t228 = load i8*, i8** %l0
  %t229 = call %CanonicalTypeLayout* @lookup_canonical_type_layout(i8* %t228)
  store %CanonicalTypeLayout* %t229, %CanonicalTypeLayout** %l9
  %t230 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l9
  %t231 = icmp ne %CanonicalTypeLayout* %t230, null
  %t232 = load i8*, i8** %l0
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t234 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l3
  %t235 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %l6
  %t236 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l9
  br i1 %t231, label %then26, label %merge27
then26:
  %t237 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l9
  %t238 = getelementptr %CanonicalTypeLayout, %CanonicalTypeLayout* %t237, i32 0, i32 1
  %t239 = load double, double* %t238
  %t240 = insertvalue %TypeLayoutInfo undef, double %t239, 0
  %t241 = load %CanonicalTypeLayout*, %CanonicalTypeLayout** %l9
  %t242 = getelementptr %CanonicalTypeLayout, %CanonicalTypeLayout* %t241, i32 0, i32 2
  %t243 = load double, double* %t242
  %t244 = insertvalue %TypeLayoutInfo %t240, double %t243, 1
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t246 = insertvalue %TypeLayoutInfo %t244, { i8**, i64 }* %t245, 2
  ret %TypeLayoutInfo %t246
merge27:
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s248 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1833630044, i32 0, i32 0
  %t249 = call i8* @sailfin_runtime_string_concat(i8* %s248, i8* %container_kind)
  %s250 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415015, i32 0, i32 0
  %t251 = call i8* @sailfin_runtime_string_concat(i8* %t249, i8* %s250)
  %t252 = call i8* @sailfin_runtime_string_concat(i8* %t251, i8* %container_name)
  %s253 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1449250559, i32 0, i32 0
  %t254 = call i8* @sailfin_runtime_string_concat(i8* %t252, i8* %s253)
  %t255 = call i8* @sailfin_runtime_string_concat(i8* %t254, i8* %field_name)
  %s256 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h9921935, i32 0, i32 0
  %t257 = call i8* @sailfin_runtime_string_concat(i8* %t255, i8* %s256)
  %t258 = load i8*, i8** %l0
  %t259 = call i8* @sailfin_runtime_string_concat(i8* %t257, i8* %t258)
  %s260 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h2008080495, i32 0, i32 0
  %t261 = call i8* @sailfin_runtime_string_concat(i8* %t259, i8* %s260)
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
block.entry:
  %l0 = alloca { %LayoutFieldInput*, i64 }*
  %l1 = alloca double
  %l2 = alloca %FieldDeclaration
  %l3 = alloca i8*
  %t0 = getelementptr [0 x %LayoutFieldInput], [0 x %LayoutFieldInput]* null, i32 1
  %t1 = ptrtoint [0 x %LayoutFieldInput]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %LayoutFieldInput*
  %t6 = getelementptr { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* null, i32 1
  %t7 = ptrtoint { %LayoutFieldInput*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %LayoutFieldInput*, i64 }*
  %t10 = getelementptr { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %t9, i32 0, i32 0
  store %LayoutFieldInput* %t5, %LayoutFieldInput** %t10
  %t11 = getelementptr { %LayoutFieldInput*, i64 }, { %LayoutFieldInput*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %LayoutFieldInput*, i64 }* %t9, { %LayoutFieldInput*, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t46 = phi { %LayoutFieldInput*, i64 }* [ %t13, %block.entry ], [ %t44, %loop.latch2 ]
  %t47 = phi double [ %t14, %block.entry ], [ %t45, %loop.latch2 ]
  store { %LayoutFieldInput*, i64 }* %t46, { %LayoutFieldInput*, i64 }** %l0
  store double %t47, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %fields
  %t17 = extractvalue { %FieldDeclaration*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l1
  %t23 = call double @llvm.round.f64(double %t22)
  %t24 = fptosi double %t23 to i64
  %t25 = load { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %fields
  %t26 = extractvalue { %FieldDeclaration*, i64 } %t25, 0
  %t27 = extractvalue { %FieldDeclaration*, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t24, i64 %t27)
  %t29 = getelementptr %FieldDeclaration, %FieldDeclaration* %t26, i64 %t24
  %t30 = load %FieldDeclaration, %FieldDeclaration* %t29
  store %FieldDeclaration %t30, %FieldDeclaration* %l2
  %t31 = load %FieldDeclaration, %FieldDeclaration* %l2
  %t32 = extractvalue %FieldDeclaration %t31, 1
  %t33 = extractvalue %TypeAnnotation %t32, 0
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
  %t49 = load double, double* %l1
  %t50 = load { %LayoutFieldInput*, i64 }*, { %LayoutFieldInput*, i64 }** %l0
  ret { %LayoutFieldInput*, i64 }* %t50
}

define { %LayoutFieldInput*, i64 }* @convert_variant_fields(%EnumVariant %variant) {
block.entry:
  %t0 = extractvalue %EnumVariant %variant, 1
  %t1 = bitcast { %FieldDeclaration**, i64 }* %t0 to { %FieldDeclaration*, i64 }*
  %t2 = call { %LayoutFieldInput*, i64 }* @convert_struct_fields({ %FieldDeclaration*, i64 }* %t1)
  ret { %LayoutFieldInput*, i64 }* %t2
}

define { %StructFieldLayoutDescriptor*, i64 }* @append_struct_field_layout({ %StructFieldLayoutDescriptor*, i64 }* %values, %StructFieldLayoutDescriptor %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 40)
  %t1 = bitcast i8* %t0 to %StructFieldLayoutDescriptor*
  store %StructFieldLayoutDescriptor %value, %StructFieldLayoutDescriptor* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %StructFieldLayoutDescriptor*, i64 }* %values to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %StructFieldLayoutDescriptor*, i64 }*
  ret { %StructFieldLayoutDescriptor*, i64 }* %t17
}

define { %EnumVariantLayoutDescriptor*, i64 }* @append_enum_variant_layout({ %EnumVariantLayoutDescriptor*, i64 }* %values, %EnumVariantLayoutDescriptor %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 48)
  %t1 = bitcast i8* %t0 to %EnumVariantLayoutDescriptor*
  store %EnumVariantLayoutDescriptor %value, %EnumVariantLayoutDescriptor* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %EnumVariantLayoutDescriptor*, i64 }* %values to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %EnumVariantLayoutDescriptor*, i64 }*
  ret { %EnumVariantLayoutDescriptor*, i64 }* %t17
}

define { %LayoutFieldInput*, i64 }* @append_layout_field_input({ %LayoutFieldInput*, i64 }* %values, %LayoutFieldInput %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 16)
  %t1 = bitcast i8* %t0 to %LayoutFieldInput*
  store %LayoutFieldInput %value, %LayoutFieldInput* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %LayoutFieldInput*, i64 }* %values to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %LayoutFieldInput*, i64 }*
  ret { %LayoutFieldInput*, i64 }* %t17
}

define { %LayoutStructDefinition*, i64 }* @append_layout_struct_definition({ %LayoutStructDefinition*, i64 }* %values, %LayoutStructDefinition %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 16)
  %t1 = bitcast i8* %t0 to %LayoutStructDefinition*
  store %LayoutStructDefinition %value, %LayoutStructDefinition* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %LayoutStructDefinition*, i64 }* %values to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %LayoutStructDefinition*, i64 }*
  ret { %LayoutStructDefinition*, i64 }* %t17
}

define { %LayoutEnumDefinition*, i64 }* @append_layout_enum_definition({ %LayoutEnumDefinition*, i64 }* %values, %LayoutEnumDefinition %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 16)
  %t1 = bitcast i8* %t0 to %LayoutEnumDefinition*
  store %LayoutEnumDefinition %value, %LayoutEnumDefinition* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %LayoutEnumDefinition*, i64 }* %values to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %LayoutEnumDefinition*, i64 }*
  ret { %LayoutEnumDefinition*, i64 }* %t17
}

define { %LayoutEnumVariantDefinition*, i64 }* @append_layout_enum_variant_definition({ %LayoutEnumVariantDefinition*, i64 }* %values, %LayoutEnumVariantDefinition %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 16)
  %t1 = bitcast i8* %t0 to %LayoutEnumVariantDefinition*
  store %LayoutEnumVariantDefinition %value, %LayoutEnumVariantDefinition* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %LayoutEnumVariantDefinition*, i64 }* %values to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %LayoutEnumVariantDefinition*, i64 }*
  ret { %LayoutEnumVariantDefinition*, i64 }* %t17
}

define { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %values, %CanonicalTypeLayout %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %CanonicalTypeLayout*
  store %CanonicalTypeLayout %value, %CanonicalTypeLayout* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %CanonicalTypeLayout*, i64 }* %values to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %CanonicalTypeLayout*, i64 }*
  ret { %CanonicalTypeLayout*, i64 }* %t17
}

define %LayoutStructDefinition* @find_layout_struct_definition(%LayoutContext %context, i8* %name) {
block.entry:
  %l0 = alloca double
  %l1 = alloca %LayoutStructDefinition*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t30 = phi double [ %t1, %block.entry ], [ %t29, %loop.latch2 ]
  store double %t30, double* %l0
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
  %t11 = call double @llvm.round.f64(double %t10)
  %t12 = fptosi double %t11 to i64
  %t13 = load { %LayoutStructDefinition**, i64 }, { %LayoutStructDefinition**, i64 }* %t9
  %t14 = extractvalue { %LayoutStructDefinition**, i64 } %t13, 0
  %t15 = extractvalue { %LayoutStructDefinition**, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t12, i64 %t15)
  %t17 = getelementptr %LayoutStructDefinition*, %LayoutStructDefinition** %t14, i64 %t12
  %t18 = load %LayoutStructDefinition*, %LayoutStructDefinition** %t17
  store %LayoutStructDefinition* %t18, %LayoutStructDefinition** %l1
  %t19 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l1
  %t20 = getelementptr %LayoutStructDefinition, %LayoutStructDefinition* %t19, i32 0, i32 0
  %t21 = load i8*, i8** %t20
  %t22 = call i1 @strings_equal(i8* %t21, i8* %name)
  %t23 = load double, double* %l0
  %t24 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l1
  br i1 %t22, label %then6, label %merge7
then6:
  %t25 = load %LayoutStructDefinition*, %LayoutStructDefinition** %l1
  ret %LayoutStructDefinition* %t25
merge7:
  %t26 = load double, double* %l0
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  store double %t28, double* %l0
  br label %loop.latch2
loop.latch2:
  %t29 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t31 = load double, double* %l0
  %t32 = bitcast i8* null to %LayoutStructDefinition*
  ret %LayoutStructDefinition* %t32
}

define %LayoutEnumDefinition* @find_layout_enum_definition(%LayoutContext %context, i8* %name) {
block.entry:
  %l0 = alloca double
  %l1 = alloca %LayoutEnumDefinition*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t30 = phi double [ %t1, %block.entry ], [ %t29, %loop.latch2 ]
  store double %t30, double* %l0
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
  %t11 = call double @llvm.round.f64(double %t10)
  %t12 = fptosi double %t11 to i64
  %t13 = load { %LayoutEnumDefinition**, i64 }, { %LayoutEnumDefinition**, i64 }* %t9
  %t14 = extractvalue { %LayoutEnumDefinition**, i64 } %t13, 0
  %t15 = extractvalue { %LayoutEnumDefinition**, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t12, i64 %t15)
  %t17 = getelementptr %LayoutEnumDefinition*, %LayoutEnumDefinition** %t14, i64 %t12
  %t18 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %t17
  store %LayoutEnumDefinition* %t18, %LayoutEnumDefinition** %l1
  %t19 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %l1
  %t20 = getelementptr %LayoutEnumDefinition, %LayoutEnumDefinition* %t19, i32 0, i32 0
  %t21 = load i8*, i8** %t20
  %t22 = call i1 @strings_equal(i8* %t21, i8* %name)
  %t23 = load double, double* %l0
  %t24 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %l1
  br i1 %t22, label %then6, label %merge7
then6:
  %t25 = load %LayoutEnumDefinition*, %LayoutEnumDefinition** %l1
  ret %LayoutEnumDefinition* %t25
merge7:
  %t26 = load double, double* %l0
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  store double %t28, double* %l0
  br label %loop.latch2
loop.latch2:
  %t29 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t31 = load double, double* %l0
  %t32 = bitcast i8* null to %LayoutEnumDefinition*
  ret %LayoutEnumDefinition* %t32
}

define { %CanonicalTypeLayout*, i64 }* @canonical_type_layouts() {
block.entry:
  %l0 = alloca { %CanonicalTypeLayout*, i64 }*
  %t0 = getelementptr [0 x %CanonicalTypeLayout], [0 x %CanonicalTypeLayout]* null, i32 1
  %t1 = ptrtoint [0 x %CanonicalTypeLayout]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %CanonicalTypeLayout*
  %t6 = getelementptr { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* null, i32 1
  %t7 = ptrtoint { %CanonicalTypeLayout*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %CanonicalTypeLayout*, i64 }*
  %t10 = getelementptr { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* %t9, i32 0, i32 0
  store %CanonicalTypeLayout* %t5, %CanonicalTypeLayout** %t10
  %t11 = getelementptr { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %CanonicalTypeLayout*, i64 }* %t9, { %CanonicalTypeLayout*, i64 }** %l0
  %t12 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s13 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1407544976, i32 0, i32 0
  %t14 = insertvalue %CanonicalTypeLayout undef, i8* %s13, 0
  %t15 = sitofp i64 40 to double
  %t16 = insertvalue %CanonicalTypeLayout %t14, double %t15, 1
  %t17 = sitofp i64 8 to double
  %t18 = insertvalue %CanonicalTypeLayout %t16, double %t17, 2
  %t19 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t12, %CanonicalTypeLayout %t18)
  store { %CanonicalTypeLayout*, i64 }* %t19, { %CanonicalTypeLayout*, i64 }** %l0
  %t20 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s21 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h341064397, i32 0, i32 0
  %t22 = insertvalue %CanonicalTypeLayout undef, i8* %s21, 0
  %t23 = sitofp i64 16 to double
  %t24 = insertvalue %CanonicalTypeLayout %t22, double %t23, 1
  %t25 = sitofp i64 8 to double
  %t26 = insertvalue %CanonicalTypeLayout %t24, double %t25, 2
  %t27 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t20, %CanonicalTypeLayout %t26)
  store { %CanonicalTypeLayout*, i64 }* %t27, { %CanonicalTypeLayout*, i64 }** %l0
  %t28 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s29 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h576672325, i32 0, i32 0
  %t30 = insertvalue %CanonicalTypeLayout undef, i8* %s29, 0
  %t31 = sitofp i64 8 to double
  %t32 = insertvalue %CanonicalTypeLayout %t30, double %t31, 1
  %t33 = sitofp i64 8 to double
  %t34 = insertvalue %CanonicalTypeLayout %t32, double %t33, 2
  %t35 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t28, %CanonicalTypeLayout %t34)
  store { %CanonicalTypeLayout*, i64 }* %t35, { %CanonicalTypeLayout*, i64 }** %l0
  %t36 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s37 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1988247080, i32 0, i32 0
  %t38 = insertvalue %CanonicalTypeLayout undef, i8* %s37, 0
  %t39 = sitofp i64 8 to double
  %t40 = insertvalue %CanonicalTypeLayout %t38, double %t39, 1
  %t41 = sitofp i64 8 to double
  %t42 = insertvalue %CanonicalTypeLayout %t40, double %t41, 2
  %t43 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t36, %CanonicalTypeLayout %t42)
  store { %CanonicalTypeLayout*, i64 }* %t43, { %CanonicalTypeLayout*, i64 }** %l0
  %t44 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s45 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h898775369, i32 0, i32 0
  %t46 = insertvalue %CanonicalTypeLayout undef, i8* %s45, 0
  %t47 = sitofp i64 8 to double
  %t48 = insertvalue %CanonicalTypeLayout %t46, double %t47, 1
  %t49 = sitofp i64 8 to double
  %t50 = insertvalue %CanonicalTypeLayout %t48, double %t49, 2
  %t51 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t44, %CanonicalTypeLayout %t50)
  store { %CanonicalTypeLayout*, i64 }* %t51, { %CanonicalTypeLayout*, i64 }** %l0
  %t52 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s53 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h699691610, i32 0, i32 0
  %t54 = insertvalue %CanonicalTypeLayout undef, i8* %s53, 0
  %t55 = sitofp i64 8 to double
  %t56 = insertvalue %CanonicalTypeLayout %t54, double %t55, 1
  %t57 = sitofp i64 8 to double
  %t58 = insertvalue %CanonicalTypeLayout %t56, double %t57, 2
  %t59 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t52, %CanonicalTypeLayout %t58)
  store { %CanonicalTypeLayout*, i64 }* %t59, { %CanonicalTypeLayout*, i64 }** %l0
  %t60 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s61 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h302043987, i32 0, i32 0
  %t62 = insertvalue %CanonicalTypeLayout undef, i8* %s61, 0
  %t63 = sitofp i64 8 to double
  %t64 = insertvalue %CanonicalTypeLayout %t62, double %t63, 1
  %t65 = sitofp i64 8 to double
  %t66 = insertvalue %CanonicalTypeLayout %t64, double %t65, 2
  %t67 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t60, %CanonicalTypeLayout %t66)
  store { %CanonicalTypeLayout*, i64 }* %t67, { %CanonicalTypeLayout*, i64 }** %l0
  %t68 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s69 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1629914700, i32 0, i32 0
  %t70 = insertvalue %CanonicalTypeLayout undef, i8* %s69, 0
  %t71 = sitofp i64 8 to double
  %t72 = insertvalue %CanonicalTypeLayout %t70, double %t71, 1
  %t73 = sitofp i64 8 to double
  %t74 = insertvalue %CanonicalTypeLayout %t72, double %t73, 2
  %t75 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t68, %CanonicalTypeLayout %t74)
  store { %CanonicalTypeLayout*, i64 }* %t75, { %CanonicalTypeLayout*, i64 }** %l0
  %t76 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s77 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1724213902, i32 0, i32 0
  %t78 = insertvalue %CanonicalTypeLayout undef, i8* %s77, 0
  %t79 = sitofp i64 8 to double
  %t80 = insertvalue %CanonicalTypeLayout %t78, double %t79, 1
  %t81 = sitofp i64 8 to double
  %t82 = insertvalue %CanonicalTypeLayout %t80, double %t81, 2
  %t83 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t76, %CanonicalTypeLayout %t82)
  store { %CanonicalTypeLayout*, i64 }* %t83, { %CanonicalTypeLayout*, i64 }** %l0
  %t84 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s85 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1381756460, i32 0, i32 0
  %t86 = insertvalue %CanonicalTypeLayout undef, i8* %s85, 0
  %t87 = sitofp i64 8 to double
  %t88 = insertvalue %CanonicalTypeLayout %t86, double %t87, 1
  %t89 = sitofp i64 8 to double
  %t90 = insertvalue %CanonicalTypeLayout %t88, double %t89, 2
  %t91 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t84, %CanonicalTypeLayout %t90)
  store { %CanonicalTypeLayout*, i64 }* %t91, { %CanonicalTypeLayout*, i64 }** %l0
  %t92 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s93 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h259975568, i32 0, i32 0
  %t94 = insertvalue %CanonicalTypeLayout undef, i8* %s93, 0
  %t95 = sitofp i64 8 to double
  %t96 = insertvalue %CanonicalTypeLayout %t94, double %t95, 1
  %t97 = sitofp i64 8 to double
  %t98 = insertvalue %CanonicalTypeLayout %t96, double %t97, 2
  %t99 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t92, %CanonicalTypeLayout %t98)
  store { %CanonicalTypeLayout*, i64 }* %t99, { %CanonicalTypeLayout*, i64 }** %l0
  %t100 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s101 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h83011545, i32 0, i32 0
  %t102 = insertvalue %CanonicalTypeLayout undef, i8* %s101, 0
  %t103 = sitofp i64 8 to double
  %t104 = insertvalue %CanonicalTypeLayout %t102, double %t103, 1
  %t105 = sitofp i64 8 to double
  %t106 = insertvalue %CanonicalTypeLayout %t104, double %t105, 2
  %t107 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t100, %CanonicalTypeLayout %t106)
  store { %CanonicalTypeLayout*, i64 }* %t107, { %CanonicalTypeLayout*, i64 }** %l0
  %t108 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s109 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h355918296, i32 0, i32 0
  %t110 = insertvalue %CanonicalTypeLayout undef, i8* %s109, 0
  %t111 = sitofp i64 8 to double
  %t112 = insertvalue %CanonicalTypeLayout %t110, double %t111, 1
  %t113 = sitofp i64 8 to double
  %t114 = insertvalue %CanonicalTypeLayout %t112, double %t113, 2
  %t115 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t108, %CanonicalTypeLayout %t114)
  store { %CanonicalTypeLayout*, i64 }* %t115, { %CanonicalTypeLayout*, i64 }** %l0
  %t116 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s117 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1057071035, i32 0, i32 0
  %t118 = insertvalue %CanonicalTypeLayout undef, i8* %s117, 0
  %t119 = sitofp i64 8 to double
  %t120 = insertvalue %CanonicalTypeLayout %t118, double %t119, 1
  %t121 = sitofp i64 8 to double
  %t122 = insertvalue %CanonicalTypeLayout %t120, double %t121, 2
  %t123 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t116, %CanonicalTypeLayout %t122)
  store { %CanonicalTypeLayout*, i64 }* %t123, { %CanonicalTypeLayout*, i64 }** %l0
  %t124 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s125 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h2110552132, i32 0, i32 0
  %t126 = insertvalue %CanonicalTypeLayout undef, i8* %s125, 0
  %t127 = sitofp i64 8 to double
  %t128 = insertvalue %CanonicalTypeLayout %t126, double %t127, 1
  %t129 = sitofp i64 8 to double
  %t130 = insertvalue %CanonicalTypeLayout %t128, double %t129, 2
  %t131 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t124, %CanonicalTypeLayout %t130)
  store { %CanonicalTypeLayout*, i64 }* %t131, { %CanonicalTypeLayout*, i64 }** %l0
  %t132 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s133 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h198095254, i32 0, i32 0
  %t134 = insertvalue %CanonicalTypeLayout undef, i8* %s133, 0
  %t135 = sitofp i64 8 to double
  %t136 = insertvalue %CanonicalTypeLayout %t134, double %t135, 1
  %t137 = sitofp i64 8 to double
  %t138 = insertvalue %CanonicalTypeLayout %t136, double %t137, 2
  %t139 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t132, %CanonicalTypeLayout %t138)
  store { %CanonicalTypeLayout*, i64 }* %t139, { %CanonicalTypeLayout*, i64 }** %l0
  %t140 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s141 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h152073561, i32 0, i32 0
  %t142 = insertvalue %CanonicalTypeLayout undef, i8* %s141, 0
  %t143 = sitofp i64 8 to double
  %t144 = insertvalue %CanonicalTypeLayout %t142, double %t143, 1
  %t145 = sitofp i64 8 to double
  %t146 = insertvalue %CanonicalTypeLayout %t144, double %t145, 2
  %t147 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t140, %CanonicalTypeLayout %t146)
  store { %CanonicalTypeLayout*, i64 }* %t147, { %CanonicalTypeLayout*, i64 }** %l0
  %t148 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s149 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1508055514, i32 0, i32 0
  %t150 = insertvalue %CanonicalTypeLayout undef, i8* %s149, 0
  %t151 = sitofp i64 8 to double
  %t152 = insertvalue %CanonicalTypeLayout %t150, double %t151, 1
  %t153 = sitofp i64 8 to double
  %t154 = insertvalue %CanonicalTypeLayout %t152, double %t153, 2
  %t155 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t148, %CanonicalTypeLayout %t154)
  store { %CanonicalTypeLayout*, i64 }* %t155, { %CanonicalTypeLayout*, i64 }** %l0
  %t156 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s157 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h2121470532, i32 0, i32 0
  %t158 = insertvalue %CanonicalTypeLayout undef, i8* %s157, 0
  %t159 = sitofp i64 8 to double
  %t160 = insertvalue %CanonicalTypeLayout %t158, double %t159, 1
  %t161 = sitofp i64 8 to double
  %t162 = insertvalue %CanonicalTypeLayout %t160, double %t161, 2
  %t163 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t156, %CanonicalTypeLayout %t162)
  store { %CanonicalTypeLayout*, i64 }* %t163, { %CanonicalTypeLayout*, i64 }** %l0
  %t164 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s165 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h479148896, i32 0, i32 0
  %t166 = insertvalue %CanonicalTypeLayout undef, i8* %s165, 0
  %t167 = sitofp i64 8 to double
  %t168 = insertvalue %CanonicalTypeLayout %t166, double %t167, 1
  %t169 = sitofp i64 8 to double
  %t170 = insertvalue %CanonicalTypeLayout %t168, double %t169, 2
  %t171 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t164, %CanonicalTypeLayout %t170)
  store { %CanonicalTypeLayout*, i64 }* %t171, { %CanonicalTypeLayout*, i64 }** %l0
  %t172 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s173 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h571715647, i32 0, i32 0
  %t174 = insertvalue %CanonicalTypeLayout undef, i8* %s173, 0
  %t175 = sitofp i64 8 to double
  %t176 = insertvalue %CanonicalTypeLayout %t174, double %t175, 1
  %t177 = sitofp i64 8 to double
  %t178 = insertvalue %CanonicalTypeLayout %t176, double %t177, 2
  %t179 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t172, %CanonicalTypeLayout %t178)
  store { %CanonicalTypeLayout*, i64 }* %t179, { %CanonicalTypeLayout*, i64 }** %l0
  %t180 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s181 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h889179835, i32 0, i32 0
  %t182 = insertvalue %CanonicalTypeLayout undef, i8* %s181, 0
  %t183 = sitofp i64 8 to double
  %t184 = insertvalue %CanonicalTypeLayout %t182, double %t183, 1
  %t185 = sitofp i64 8 to double
  %t186 = insertvalue %CanonicalTypeLayout %t184, double %t185, 2
  %t187 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t180, %CanonicalTypeLayout %t186)
  store { %CanonicalTypeLayout*, i64 }* %t187, { %CanonicalTypeLayout*, i64 }** %l0
  %t188 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s189 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h2043328844, i32 0, i32 0
  %t190 = insertvalue %CanonicalTypeLayout undef, i8* %s189, 0
  %t191 = sitofp i64 8 to double
  %t192 = insertvalue %CanonicalTypeLayout %t190, double %t191, 1
  %t193 = sitofp i64 8 to double
  %t194 = insertvalue %CanonicalTypeLayout %t192, double %t193, 2
  %t195 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t188, %CanonicalTypeLayout %t194)
  store { %CanonicalTypeLayout*, i64 }* %t195, { %CanonicalTypeLayout*, i64 }** %l0
  %t196 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s197 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1902764570, i32 0, i32 0
  %t198 = insertvalue %CanonicalTypeLayout undef, i8* %s197, 0
  %t199 = sitofp i64 8 to double
  %t200 = insertvalue %CanonicalTypeLayout %t198, double %t199, 1
  %t201 = sitofp i64 8 to double
  %t202 = insertvalue %CanonicalTypeLayout %t200, double %t201, 2
  %t203 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t196, %CanonicalTypeLayout %t202)
  store { %CanonicalTypeLayout*, i64 }* %t203, { %CanonicalTypeLayout*, i64 }** %l0
  %t204 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s205 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1620510857, i32 0, i32 0
  %t206 = insertvalue %CanonicalTypeLayout undef, i8* %s205, 0
  %t207 = sitofp i64 8 to double
  %t208 = insertvalue %CanonicalTypeLayout %t206, double %t207, 1
  %t209 = sitofp i64 8 to double
  %t210 = insertvalue %CanonicalTypeLayout %t208, double %t209, 2
  %t211 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t204, %CanonicalTypeLayout %t210)
  store { %CanonicalTypeLayout*, i64 }* %t211, { %CanonicalTypeLayout*, i64 }** %l0
  %t212 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s213 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1192169574, i32 0, i32 0
  %t214 = insertvalue %CanonicalTypeLayout undef, i8* %s213, 0
  %t215 = sitofp i64 8 to double
  %t216 = insertvalue %CanonicalTypeLayout %t214, double %t215, 1
  %t217 = sitofp i64 8 to double
  %t218 = insertvalue %CanonicalTypeLayout %t216, double %t217, 2
  %t219 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t212, %CanonicalTypeLayout %t218)
  store { %CanonicalTypeLayout*, i64 }* %t219, { %CanonicalTypeLayout*, i64 }** %l0
  %t220 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s221 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h204830940, i32 0, i32 0
  %t222 = insertvalue %CanonicalTypeLayout undef, i8* %s221, 0
  %t223 = sitofp i64 8 to double
  %t224 = insertvalue %CanonicalTypeLayout %t222, double %t223, 1
  %t225 = sitofp i64 8 to double
  %t226 = insertvalue %CanonicalTypeLayout %t224, double %t225, 2
  %t227 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t220, %CanonicalTypeLayout %t226)
  store { %CanonicalTypeLayout*, i64 }* %t227, { %CanonicalTypeLayout*, i64 }** %l0
  %t228 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s229 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h711382918, i32 0, i32 0
  %t230 = insertvalue %CanonicalTypeLayout undef, i8* %s229, 0
  %t231 = sitofp i64 8 to double
  %t232 = insertvalue %CanonicalTypeLayout %t230, double %t231, 1
  %t233 = sitofp i64 8 to double
  %t234 = insertvalue %CanonicalTypeLayout %t232, double %t233, 2
  %t235 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t228, %CanonicalTypeLayout %t234)
  store { %CanonicalTypeLayout*, i64 }* %t235, { %CanonicalTypeLayout*, i64 }** %l0
  %t236 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s237 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1969606825, i32 0, i32 0
  %t238 = insertvalue %CanonicalTypeLayout undef, i8* %s237, 0
  %t239 = sitofp i64 8 to double
  %t240 = insertvalue %CanonicalTypeLayout %t238, double %t239, 1
  %t241 = sitofp i64 8 to double
  %t242 = insertvalue %CanonicalTypeLayout %t240, double %t241, 2
  %t243 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t236, %CanonicalTypeLayout %t242)
  store { %CanonicalTypeLayout*, i64 }* %t243, { %CanonicalTypeLayout*, i64 }** %l0
  %t244 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s245 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h364122910, i32 0, i32 0
  %t246 = insertvalue %CanonicalTypeLayout undef, i8* %s245, 0
  %t247 = sitofp i64 8 to double
  %t248 = insertvalue %CanonicalTypeLayout %t246, double %t247, 1
  %t249 = sitofp i64 8 to double
  %t250 = insertvalue %CanonicalTypeLayout %t248, double %t249, 2
  %t251 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t244, %CanonicalTypeLayout %t250)
  store { %CanonicalTypeLayout*, i64 }* %t251, { %CanonicalTypeLayout*, i64 }** %l0
  %t252 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s253 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h300877395, i32 0, i32 0
  %t254 = insertvalue %CanonicalTypeLayout undef, i8* %s253, 0
  %t255 = sitofp i64 8 to double
  %t256 = insertvalue %CanonicalTypeLayout %t254, double %t255, 1
  %t257 = sitofp i64 8 to double
  %t258 = insertvalue %CanonicalTypeLayout %t256, double %t257, 2
  %t259 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t252, %CanonicalTypeLayout %t258)
  store { %CanonicalTypeLayout*, i64 }* %t259, { %CanonicalTypeLayout*, i64 }** %l0
  %t260 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s261 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h575661041, i32 0, i32 0
  %t262 = insertvalue %CanonicalTypeLayout undef, i8* %s261, 0
  %t263 = sitofp i64 8 to double
  %t264 = insertvalue %CanonicalTypeLayout %t262, double %t263, 1
  %t265 = sitofp i64 8 to double
  %t266 = insertvalue %CanonicalTypeLayout %t264, double %t265, 2
  %t267 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t260, %CanonicalTypeLayout %t266)
  store { %CanonicalTypeLayout*, i64 }* %t267, { %CanonicalTypeLayout*, i64 }** %l0
  %t268 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %s269 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h237087299, i32 0, i32 0
  %t270 = insertvalue %CanonicalTypeLayout undef, i8* %s269, 0
  %t271 = sitofp i64 8 to double
  %t272 = insertvalue %CanonicalTypeLayout %t270, double %t271, 1
  %t273 = sitofp i64 8 to double
  %t274 = insertvalue %CanonicalTypeLayout %t272, double %t273, 2
  %t275 = call { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }* %t268, %CanonicalTypeLayout %t274)
  store { %CanonicalTypeLayout*, i64 }* %t275, { %CanonicalTypeLayout*, i64 }** %l0
  %t276 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  ret { %CanonicalTypeLayout*, i64 }* %t276
}

define %CanonicalTypeLayout* @lookup_canonical_type_layout(i8* %name) {
block.entry:
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
  %t34 = phi double [ %t3, %block.entry ], [ %t33, %loop.latch2 ]
  store double %t34, double* %l1
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
  %t14 = call double @llvm.round.f64(double %t13)
  %t15 = fptosi double %t14 to i64
  %t16 = load { %CanonicalTypeLayout*, i64 }, { %CanonicalTypeLayout*, i64 }* %t12
  %t17 = extractvalue { %CanonicalTypeLayout*, i64 } %t16, 0
  %t18 = extractvalue { %CanonicalTypeLayout*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t15, i64 %t18)
  %t20 = getelementptr %CanonicalTypeLayout, %CanonicalTypeLayout* %t17, i64 %t15
  %t21 = load %CanonicalTypeLayout, %CanonicalTypeLayout* %t20
  store %CanonicalTypeLayout %t21, %CanonicalTypeLayout* %l2
  %t22 = load %CanonicalTypeLayout, %CanonicalTypeLayout* %l2
  %t23 = extractvalue %CanonicalTypeLayout %t22, 0
  %t24 = call i1 @strings_equal(i8* %t23, i8* %name)
  %t25 = load { %CanonicalTypeLayout*, i64 }*, { %CanonicalTypeLayout*, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = load %CanonicalTypeLayout, %CanonicalTypeLayout* %l2
  br i1 %t24, label %then6, label %merge7
then6:
  %t28 = load %CanonicalTypeLayout, %CanonicalTypeLayout* %l2
  %t29 = alloca %CanonicalTypeLayout
  store %CanonicalTypeLayout %t28, %CanonicalTypeLayout* %t29
  ret %CanonicalTypeLayout* %t29
merge7:
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch2
loop.latch2:
  %t33 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t35 = load double, double* %l1
  %t36 = bitcast i8* null to %CanonicalTypeLayout*
  ret %CanonicalTypeLayout* %t36
}

define double @align_to(double %value, double %alignment) {
block.entry:
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
block.entry:
  %s0 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193479167, i32 0, i32 0
  %t1 = call i1 @ends_with(i8* %type_annotation, i8* %s0)
  ret i1 %t1
}

define i1 @is_optional_annotation(i8* %type_annotation) {
block.entry:
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
block.entry:
  %t0 = call i64 @sailfin_runtime_string_length(i8* %type_annotation)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* %type_annotation)
  ret i8* %type_annotation
merge1:
  %t2 = call i64 @sailfin_runtime_string_length(i8* %type_annotation)
  %t3 = sub i64 %t2, 1
  %t4 = call i8* @sailfin_runtime_substring(i8* %type_annotation, i64 0, i64 %t3)
  call void @sailfin_runtime_mark_persistent(i8* %t4)
  ret i8* %t4
}

define i1 @ends_with(i8* %value, i8* %suffix) {
block.entry:
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
  %t37 = phi double [ %t10, %merge3 ], [ %t36, %loop.latch6 ]
  store double %t37, double* %l1
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
  %t21 = call double @llvm.round.f64(double %t20)
  %t22 = fptosi double %t21 to i64
  %t23 = getelementptr i8, i8* %value, i64 %t22
  %t24 = load i8, i8* %t23
  %t25 = load double, double* %l1
  %t26 = call double @llvm.round.f64(double %t25)
  %t27 = fptosi double %t26 to i64
  %t28 = getelementptr i8, i8* %suffix, i64 %t27
  %t29 = load i8, i8* %t28
  %t30 = icmp ne i8 %t24, %t29
  %t31 = load i64, i64* %l0
  %t32 = load double, double* %l1
  br i1 %t30, label %then10, label %merge11
then10:
  ret i1 0
merge11:
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch6
loop.latch6:
  %t36 = load double, double* %l1
  br label %loop.header4
afterloop7:
  %t38 = load double, double* %l1
  ret i1 1
}

define i8* @number_to_string(double %value) {
block.entry:
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
  call void @sailfin_runtime_mark_persistent(i8* %t5)
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
  %t61 = phi i8* [ %t9, %merge1 ], [ %t59, %loop.latch4 ]
  %t62 = phi double [ %t8, %merge1 ], [ %t60, %loop.latch4 ]
  store i8* %t61, i8** %l1
  store double %t62, double* %l0
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
  %t50 = call double @llvm.round.f64(double %t46)
  %t51 = fptosi double %t50 to i64
  %t52 = call double @llvm.round.f64(double %t49)
  %t53 = fptosi double %t52 to i64
  %t54 = call i8* @sailfin_runtime_substring(i8* %t45, i64 %t51, i64 %t53)
  store i8* %t54, i8** %l6
  %t55 = load i8*, i8** %l6
  %t56 = load i8*, i8** %l1
  %t57 = call i8* @sailfin_runtime_string_concat(i8* %t55, i8* %t56)
  store i8* %t57, i8** %l1
  %t58 = load double, double* %l4
  store double %t58, double* %l0
  br label %loop.latch4
loop.latch4:
  %t59 = load i8*, i8** %l1
  %t60 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t63 = load i8*, i8** %l1
  %t64 = load double, double* %l0
  %t65 = load i8*, i8** %l1
  call void @sailfin_runtime_mark_persistent(i8* %t65)
  ret i8* %t65
}

define i8* @format_expression(%Expression %expression) {
block.entry:
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
  %t51 = call i1 @strings_equal(i8* %t49, i8* %s50)
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
  call void @sailfin_runtime_mark_persistent(i8* %t59)
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
  %t111 = call i1 @strings_equal(i8* %t109, i8* %s110)
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
  call void @sailfin_runtime_mark_persistent(i8* %t131)
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
  %t183 = call i1 @strings_equal(i8* %t181, i8* %s182)
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
  call void @sailfin_runtime_mark_persistent(i8* %t203)
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
  %t255 = call i1 @strings_equal(i8* %t253, i8* %s254)
  br i1 %t255, label %then6, label %merge7
then6:
  %s256 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268929446, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s256)
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
  %t308 = call i1 @strings_equal(i8* %t306, i8* %s307)
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
  call void @sailfin_runtime_mark_persistent(i8* %t329)
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
  %t381 = call i1 @strings_equal(i8* %t379, i8* %s380)
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
  call void @sailfin_runtime_mark_persistent(i8* %t407)
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
  %t459 = call i1 @strings_equal(i8* %t457, i8* %s458)
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
  %t483 = alloca [2 x i8], align 1
  %t484 = getelementptr [2 x i8], [2 x i8]* %t483, i32 0, i32 0
  store i8 32, i8* %t484
  %t485 = getelementptr [2 x i8], [2 x i8]* %t483, i32 0, i32 1
  store i8 0, i8* %t485
  %t486 = getelementptr [2 x i8], [2 x i8]* %t483, i32 0, i32 0
  %t487 = call i8* @sailfin_runtime_string_concat(i8* %t482, i8* %t486)
  %t488 = extractvalue %Expression %expression, 0
  %t489 = alloca %Expression
  store %Expression %expression, %Expression* %t489
  %t490 = getelementptr inbounds %Expression, %Expression* %t489, i32 0, i32 1
  %t491 = bitcast [16 x i8]* %t490 to i8*
  %t492 = bitcast i8* %t491 to i8**
  %t493 = load i8*, i8** %t492
  %t494 = icmp eq i32 %t488, 5
  %t495 = select i1 %t494, i8* %t493, i8* null
  %t496 = getelementptr inbounds %Expression, %Expression* %t489, i32 0, i32 1
  %t497 = bitcast [24 x i8]* %t496 to i8*
  %t498 = bitcast i8* %t497 to i8**
  %t499 = load i8*, i8** %t498
  %t500 = icmp eq i32 %t488, 6
  %t501 = select i1 %t500, i8* %t499, i8* %t495
  %t502 = call i8* @sailfin_runtime_string_concat(i8* %t487, i8* %t501)
  %t503 = alloca [2 x i8], align 1
  %t504 = getelementptr [2 x i8], [2 x i8]* %t503, i32 0, i32 0
  store i8 32, i8* %t504
  %t505 = getelementptr [2 x i8], [2 x i8]* %t503, i32 0, i32 1
  store i8 0, i8* %t505
  %t506 = getelementptr [2 x i8], [2 x i8]* %t503, i32 0, i32 0
  %t507 = call i8* @sailfin_runtime_string_concat(i8* %t502, i8* %t506)
  %t508 = load i8*, i8** %l1
  %t509 = call i8* @sailfin_runtime_string_concat(i8* %t507, i8* %t508)
  call void @sailfin_runtime_mark_persistent(i8* %t509)
  ret i8* %t509
merge13:
  %t510 = extractvalue %Expression %expression, 0
  %t511 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t512 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t513 = icmp eq i32 %t510, 0
  %t514 = select i1 %t513, i8* %t512, i8* %t511
  %t515 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t516 = icmp eq i32 %t510, 1
  %t517 = select i1 %t516, i8* %t515, i8* %t514
  %t518 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t519 = icmp eq i32 %t510, 2
  %t520 = select i1 %t519, i8* %t518, i8* %t517
  %t521 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t522 = icmp eq i32 %t510, 3
  %t523 = select i1 %t522, i8* %t521, i8* %t520
  %t524 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t525 = icmp eq i32 %t510, 4
  %t526 = select i1 %t525, i8* %t524, i8* %t523
  %t527 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t528 = icmp eq i32 %t510, 5
  %t529 = select i1 %t528, i8* %t527, i8* %t526
  %t530 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t531 = icmp eq i32 %t510, 6
  %t532 = select i1 %t531, i8* %t530, i8* %t529
  %t533 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t534 = icmp eq i32 %t510, 7
  %t535 = select i1 %t534, i8* %t533, i8* %t532
  %t536 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t537 = icmp eq i32 %t510, 8
  %t538 = select i1 %t537, i8* %t536, i8* %t535
  %t539 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t540 = icmp eq i32 %t510, 9
  %t541 = select i1 %t540, i8* %t539, i8* %t538
  %t542 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t543 = icmp eq i32 %t510, 10
  %t544 = select i1 %t543, i8* %t542, i8* %t541
  %t545 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t546 = icmp eq i32 %t510, 11
  %t547 = select i1 %t546, i8* %t545, i8* %t544
  %t548 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t549 = icmp eq i32 %t510, 12
  %t550 = select i1 %t549, i8* %t548, i8* %t547
  %t551 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t552 = icmp eq i32 %t510, 13
  %t553 = select i1 %t552, i8* %t551, i8* %t550
  %t554 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t555 = icmp eq i32 %t510, 14
  %t556 = select i1 %t555, i8* %t554, i8* %t553
  %t557 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t558 = icmp eq i32 %t510, 15
  %t559 = select i1 %t558, i8* %t557, i8* %t556
  %s560 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h512390329, i32 0, i32 0
  %t561 = call i1 @strings_equal(i8* %t559, i8* %s560)
  br i1 %t561, label %then14, label %merge15
then14:
  %t562 = extractvalue %Expression %expression, 0
  %t563 = alloca %Expression
  store %Expression %expression, %Expression* %t563
  %t564 = getelementptr inbounds %Expression, %Expression* %t563, i32 0, i32 1
  %t565 = bitcast [16 x i8]* %t564 to i8*
  %t566 = bitcast i8* %t565 to %Expression**
  %t567 = load %Expression*, %Expression** %t566
  %t568 = icmp eq i32 %t562, 7
  %t569 = select i1 %t568, %Expression* %t567, %Expression* null
  %t570 = load %Expression, %Expression* %t569
  %t571 = call i8* @format_expression(%Expression %t570)
  %t572 = alloca [2 x i8], align 1
  %t573 = getelementptr [2 x i8], [2 x i8]* %t572, i32 0, i32 0
  store i8 46, i8* %t573
  %t574 = getelementptr [2 x i8], [2 x i8]* %t572, i32 0, i32 1
  store i8 0, i8* %t574
  %t575 = getelementptr [2 x i8], [2 x i8]* %t572, i32 0, i32 0
  %t576 = call i8* @sailfin_runtime_string_concat(i8* %t571, i8* %t575)
  %t577 = extractvalue %Expression %expression, 0
  %t578 = alloca %Expression
  store %Expression %expression, %Expression* %t578
  %t579 = getelementptr inbounds %Expression, %Expression* %t578, i32 0, i32 1
  %t580 = bitcast [16 x i8]* %t579 to i8*
  %t581 = getelementptr inbounds i8, i8* %t580, i64 8
  %t582 = bitcast i8* %t581 to i8**
  %t583 = load i8*, i8** %t582
  %t584 = icmp eq i32 %t577, 7
  %t585 = select i1 %t584, i8* %t583, i8* null
  %t586 = call i8* @sailfin_runtime_string_concat(i8* %t576, i8* %t585)
  call void @sailfin_runtime_mark_persistent(i8* %t586)
  ret i8* %t586
merge15:
  %t587 = extractvalue %Expression %expression, 0
  %t588 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t589 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t590 = icmp eq i32 %t587, 0
  %t591 = select i1 %t590, i8* %t589, i8* %t588
  %t592 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t593 = icmp eq i32 %t587, 1
  %t594 = select i1 %t593, i8* %t592, i8* %t591
  %t595 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t596 = icmp eq i32 %t587, 2
  %t597 = select i1 %t596, i8* %t595, i8* %t594
  %t598 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t599 = icmp eq i32 %t587, 3
  %t600 = select i1 %t599, i8* %t598, i8* %t597
  %t601 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t602 = icmp eq i32 %t587, 4
  %t603 = select i1 %t602, i8* %t601, i8* %t600
  %t604 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t605 = icmp eq i32 %t587, 5
  %t606 = select i1 %t605, i8* %t604, i8* %t603
  %t607 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t608 = icmp eq i32 %t587, 6
  %t609 = select i1 %t608, i8* %t607, i8* %t606
  %t610 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t611 = icmp eq i32 %t587, 7
  %t612 = select i1 %t611, i8* %t610, i8* %t609
  %t613 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t614 = icmp eq i32 %t587, 8
  %t615 = select i1 %t614, i8* %t613, i8* %t612
  %t616 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t617 = icmp eq i32 %t587, 9
  %t618 = select i1 %t617, i8* %t616, i8* %t615
  %t619 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t620 = icmp eq i32 %t587, 10
  %t621 = select i1 %t620, i8* %t619, i8* %t618
  %t622 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t623 = icmp eq i32 %t587, 11
  %t624 = select i1 %t623, i8* %t622, i8* %t621
  %t625 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t626 = icmp eq i32 %t587, 12
  %t627 = select i1 %t626, i8* %t625, i8* %t624
  %t628 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t629 = icmp eq i32 %t587, 13
  %t630 = select i1 %t629, i8* %t628, i8* %t627
  %t631 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t632 = icmp eq i32 %t587, 14
  %t633 = select i1 %t632, i8* %t631, i8* %t630
  %t634 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t635 = icmp eq i32 %t587, 15
  %t636 = select i1 %t635, i8* %t634, i8* %t633
  %s637 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h217216103, i32 0, i32 0
  %t638 = call i1 @strings_equal(i8* %t636, i8* %s637)
  br i1 %t638, label %then16, label %merge17
then16:
  %t639 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t640 = ptrtoint [0 x i8*]* %t639 to i64
  %t641 = icmp eq i64 %t640, 0
  %t642 = select i1 %t641, i64 1, i64 %t640
  %t643 = call i8* @malloc(i64 %t642)
  %t644 = bitcast i8* %t643 to i8**
  %t645 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t646 = ptrtoint { i8**, i64 }* %t645 to i64
  %t647 = call i8* @malloc(i64 %t646)
  %t648 = bitcast i8* %t647 to { i8**, i64 }*
  %t649 = getelementptr { i8**, i64 }, { i8**, i64 }* %t648, i32 0, i32 0
  store i8** %t644, i8*** %t649
  %t650 = getelementptr { i8**, i64 }, { i8**, i64 }* %t648, i32 0, i32 1
  store i64 0, i64* %t650
  store { i8**, i64 }* %t648, { i8**, i64 }** %l2
  %t651 = sitofp i64 0 to double
  store double %t651, double* %l3
  %t652 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t653 = load double, double* %l3
  br label %loop.header18
loop.header18:
  %t697 = phi { i8**, i64 }* [ %t652, %then16 ], [ %t695, %loop.latch20 ]
  %t698 = phi double [ %t653, %then16 ], [ %t696, %loop.latch20 ]
  store { i8**, i64 }* %t697, { i8**, i64 }** %l2
  store double %t698, double* %l3
  br label %loop.body19
loop.body19:
  %t654 = load double, double* %l3
  %t655 = extractvalue %Expression %expression, 0
  %t656 = alloca %Expression
  store %Expression %expression, %Expression* %t656
  %t657 = getelementptr inbounds %Expression, %Expression* %t656, i32 0, i32 1
  %t658 = bitcast [16 x i8]* %t657 to i8*
  %t659 = getelementptr inbounds i8, i8* %t658, i64 8
  %t660 = bitcast i8* %t659 to { %Expression**, i64 }**
  %t661 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t660
  %t662 = icmp eq i32 %t655, 8
  %t663 = select i1 %t662, { %Expression**, i64 }* %t661, { %Expression**, i64 }* null
  %t664 = load { %Expression**, i64 }, { %Expression**, i64 }* %t663
  %t665 = extractvalue { %Expression**, i64 } %t664, 1
  %t666 = sitofp i64 %t665 to double
  %t667 = fcmp oge double %t654, %t666
  %t668 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t669 = load double, double* %l3
  br i1 %t667, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t670 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t671 = extractvalue %Expression %expression, 0
  %t672 = alloca %Expression
  store %Expression %expression, %Expression* %t672
  %t673 = getelementptr inbounds %Expression, %Expression* %t672, i32 0, i32 1
  %t674 = bitcast [16 x i8]* %t673 to i8*
  %t675 = getelementptr inbounds i8, i8* %t674, i64 8
  %t676 = bitcast i8* %t675 to { %Expression**, i64 }**
  %t677 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t676
  %t678 = icmp eq i32 %t671, 8
  %t679 = select i1 %t678, { %Expression**, i64 }* %t677, { %Expression**, i64 }* null
  %t680 = load double, double* %l3
  %t681 = call double @llvm.round.f64(double %t680)
  %t682 = fptosi double %t681 to i64
  %t683 = load { %Expression**, i64 }, { %Expression**, i64 }* %t679
  %t684 = extractvalue { %Expression**, i64 } %t683, 0
  %t685 = extractvalue { %Expression**, i64 } %t683, 1
  %t686 = icmp uge i64 %t682, %t685
  ; bounds check: %t686 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t682, i64 %t685)
  %t687 = getelementptr %Expression*, %Expression** %t684, i64 %t682
  %t688 = load %Expression*, %Expression** %t687
  %t689 = load %Expression, %Expression* %t688
  %t690 = call i8* @format_expression(%Expression %t689)
  %t691 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t670, i8* %t690)
  store { i8**, i64 }* %t691, { i8**, i64 }** %l2
  %t692 = load double, double* %l3
  %t693 = sitofp i64 1 to double
  %t694 = fadd double %t692, %t693
  store double %t694, double* %l3
  br label %loop.latch20
loop.latch20:
  %t695 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t696 = load double, double* %l3
  br label %loop.header18
afterloop21:
  %t699 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t700 = load double, double* %l3
  %t701 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s702 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t703 = call i8* @join_with_separator({ i8**, i64 }* %t701, i8* %s702)
  store i8* %t703, i8** %l4
  %t704 = extractvalue %Expression %expression, 0
  %t705 = alloca %Expression
  store %Expression %expression, %Expression* %t705
  %t706 = getelementptr inbounds %Expression, %Expression* %t705, i32 0, i32 1
  %t707 = bitcast [16 x i8]* %t706 to i8*
  %t708 = bitcast i8* %t707 to %Expression**
  %t709 = load %Expression*, %Expression** %t708
  %t710 = icmp eq i32 %t704, 8
  %t711 = select i1 %t710, %Expression* %t709, %Expression* null
  %t712 = load %Expression, %Expression* %t711
  %t713 = call i8* @format_expression(%Expression %t712)
  %t714 = alloca [2 x i8], align 1
  %t715 = getelementptr [2 x i8], [2 x i8]* %t714, i32 0, i32 0
  store i8 40, i8* %t715
  %t716 = getelementptr [2 x i8], [2 x i8]* %t714, i32 0, i32 1
  store i8 0, i8* %t716
  %t717 = getelementptr [2 x i8], [2 x i8]* %t714, i32 0, i32 0
  %t718 = call i8* @sailfin_runtime_string_concat(i8* %t713, i8* %t717)
  %t719 = load i8*, i8** %l4
  %t720 = call i8* @sailfin_runtime_string_concat(i8* %t718, i8* %t719)
  %t721 = alloca [2 x i8], align 1
  %t722 = getelementptr [2 x i8], [2 x i8]* %t721, i32 0, i32 0
  store i8 41, i8* %t722
  %t723 = getelementptr [2 x i8], [2 x i8]* %t721, i32 0, i32 1
  store i8 0, i8* %t723
  %t724 = getelementptr [2 x i8], [2 x i8]* %t721, i32 0, i32 0
  %t725 = call i8* @sailfin_runtime_string_concat(i8* %t720, i8* %t724)
  call void @sailfin_runtime_mark_persistent(i8* %t725)
  ret i8* %t725
merge17:
  %t726 = extractvalue %Expression %expression, 0
  %t727 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t728 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t729 = icmp eq i32 %t726, 0
  %t730 = select i1 %t729, i8* %t728, i8* %t727
  %t731 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t732 = icmp eq i32 %t726, 1
  %t733 = select i1 %t732, i8* %t731, i8* %t730
  %t734 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t735 = icmp eq i32 %t726, 2
  %t736 = select i1 %t735, i8* %t734, i8* %t733
  %t737 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t738 = icmp eq i32 %t726, 3
  %t739 = select i1 %t738, i8* %t737, i8* %t736
  %t740 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t741 = icmp eq i32 %t726, 4
  %t742 = select i1 %t741, i8* %t740, i8* %t739
  %t743 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t744 = icmp eq i32 %t726, 5
  %t745 = select i1 %t744, i8* %t743, i8* %t742
  %t746 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t747 = icmp eq i32 %t726, 6
  %t748 = select i1 %t747, i8* %t746, i8* %t745
  %t749 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t750 = icmp eq i32 %t726, 7
  %t751 = select i1 %t750, i8* %t749, i8* %t748
  %t752 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t753 = icmp eq i32 %t726, 8
  %t754 = select i1 %t753, i8* %t752, i8* %t751
  %t755 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t756 = icmp eq i32 %t726, 9
  %t757 = select i1 %t756, i8* %t755, i8* %t754
  %t758 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t759 = icmp eq i32 %t726, 10
  %t760 = select i1 %t759, i8* %t758, i8* %t757
  %t761 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t762 = icmp eq i32 %t726, 11
  %t763 = select i1 %t762, i8* %t761, i8* %t760
  %t764 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t765 = icmp eq i32 %t726, 12
  %t766 = select i1 %t765, i8* %t764, i8* %t763
  %t767 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t768 = icmp eq i32 %t726, 13
  %t769 = select i1 %t768, i8* %t767, i8* %t766
  %t770 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t771 = icmp eq i32 %t726, 14
  %t772 = select i1 %t771, i8* %t770, i8* %t769
  %t773 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t774 = icmp eq i32 %t726, 15
  %t775 = select i1 %t774, i8* %t773, i8* %t772
  %s776 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h975618503, i32 0, i32 0
  %t777 = call i1 @strings_equal(i8* %t775, i8* %s776)
  br i1 %t777, label %then24, label %merge25
then24:
  %t778 = extractvalue %Expression %expression, 0
  %t779 = alloca %Expression
  store %Expression %expression, %Expression* %t779
  %t780 = getelementptr inbounds %Expression, %Expression* %t779, i32 0, i32 1
  %t781 = bitcast [16 x i8]* %t780 to i8*
  %t782 = bitcast i8* %t781 to %Expression**
  %t783 = load %Expression*, %Expression** %t782
  %t784 = icmp eq i32 %t778, 9
  %t785 = select i1 %t784, %Expression* %t783, %Expression* null
  %t786 = load %Expression, %Expression* %t785
  %t787 = call i8* @format_expression(%Expression %t786)
  %t788 = alloca [2 x i8], align 1
  %t789 = getelementptr [2 x i8], [2 x i8]* %t788, i32 0, i32 0
  store i8 91, i8* %t789
  %t790 = getelementptr [2 x i8], [2 x i8]* %t788, i32 0, i32 1
  store i8 0, i8* %t790
  %t791 = getelementptr [2 x i8], [2 x i8]* %t788, i32 0, i32 0
  %t792 = call i8* @sailfin_runtime_string_concat(i8* %t787, i8* %t791)
  %t793 = extractvalue %Expression %expression, 0
  %t794 = alloca %Expression
  store %Expression %expression, %Expression* %t794
  %t795 = getelementptr inbounds %Expression, %Expression* %t794, i32 0, i32 1
  %t796 = bitcast [16 x i8]* %t795 to i8*
  %t797 = getelementptr inbounds i8, i8* %t796, i64 8
  %t798 = bitcast i8* %t797 to %Expression**
  %t799 = load %Expression*, %Expression** %t798
  %t800 = icmp eq i32 %t793, 9
  %t801 = select i1 %t800, %Expression* %t799, %Expression* null
  %t802 = load %Expression, %Expression* %t801
  %t803 = call i8* @format_expression(%Expression %t802)
  %t804 = call i8* @sailfin_runtime_string_concat(i8* %t792, i8* %t803)
  %t805 = alloca [2 x i8], align 1
  %t806 = getelementptr [2 x i8], [2 x i8]* %t805, i32 0, i32 0
  store i8 93, i8* %t806
  %t807 = getelementptr [2 x i8], [2 x i8]* %t805, i32 0, i32 1
  store i8 0, i8* %t807
  %t808 = getelementptr [2 x i8], [2 x i8]* %t805, i32 0, i32 0
  %t809 = call i8* @sailfin_runtime_string_concat(i8* %t804, i8* %t808)
  call void @sailfin_runtime_mark_persistent(i8* %t809)
  ret i8* %t809
merge25:
  %t810 = extractvalue %Expression %expression, 0
  %t811 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t812 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t813 = icmp eq i32 %t810, 0
  %t814 = select i1 %t813, i8* %t812, i8* %t811
  %t815 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t816 = icmp eq i32 %t810, 1
  %t817 = select i1 %t816, i8* %t815, i8* %t814
  %t818 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t819 = icmp eq i32 %t810, 2
  %t820 = select i1 %t819, i8* %t818, i8* %t817
  %t821 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t822 = icmp eq i32 %t810, 3
  %t823 = select i1 %t822, i8* %t821, i8* %t820
  %t824 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t825 = icmp eq i32 %t810, 4
  %t826 = select i1 %t825, i8* %t824, i8* %t823
  %t827 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t828 = icmp eq i32 %t810, 5
  %t829 = select i1 %t828, i8* %t827, i8* %t826
  %t830 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t831 = icmp eq i32 %t810, 6
  %t832 = select i1 %t831, i8* %t830, i8* %t829
  %t833 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t834 = icmp eq i32 %t810, 7
  %t835 = select i1 %t834, i8* %t833, i8* %t832
  %t836 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t837 = icmp eq i32 %t810, 8
  %t838 = select i1 %t837, i8* %t836, i8* %t835
  %t839 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t840 = icmp eq i32 %t810, 9
  %t841 = select i1 %t840, i8* %t839, i8* %t838
  %t842 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t843 = icmp eq i32 %t810, 10
  %t844 = select i1 %t843, i8* %t842, i8* %t841
  %t845 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t846 = icmp eq i32 %t810, 11
  %t847 = select i1 %t846, i8* %t845, i8* %t844
  %t848 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t849 = icmp eq i32 %t810, 12
  %t850 = select i1 %t849, i8* %t848, i8* %t847
  %t851 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t852 = icmp eq i32 %t810, 13
  %t853 = select i1 %t852, i8* %t851, i8* %t850
  %t854 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t855 = icmp eq i32 %t810, 14
  %t856 = select i1 %t855, i8* %t854, i8* %t853
  %t857 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t858 = icmp eq i32 %t810, 15
  %t859 = select i1 %t858, i8* %t857, i8* %t856
  %s860 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h667777838, i32 0, i32 0
  %t861 = call i1 @strings_equal(i8* %t859, i8* %s860)
  br i1 %t861, label %then26, label %merge27
then26:
  %t862 = extractvalue %Expression %expression, 0
  %t863 = alloca %Expression
  store %Expression %expression, %Expression* %t863
  %t864 = getelementptr inbounds %Expression, %Expression* %t863, i32 0, i32 1
  %t865 = bitcast [8 x i8]* %t864 to i8*
  %t866 = bitcast i8* %t865 to { %Expression**, i64 }**
  %t867 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t866
  %t868 = icmp eq i32 %t862, 10
  %t869 = select i1 %t868, { %Expression**, i64 }* %t867, { %Expression**, i64 }* null
  %t870 = bitcast { %Expression**, i64 }* %t869 to { %Expression*, i64 }*
  %t871 = call i8* @format_array_expression({ %Expression*, i64 }* %t870)
  call void @sailfin_runtime_mark_persistent(i8* %t871)
  ret i8* %t871
merge27:
  %t872 = extractvalue %Expression %expression, 0
  %t873 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t874 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t875 = icmp eq i32 %t872, 0
  %t876 = select i1 %t875, i8* %t874, i8* %t873
  %t877 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t878 = icmp eq i32 %t872, 1
  %t879 = select i1 %t878, i8* %t877, i8* %t876
  %t880 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t881 = icmp eq i32 %t872, 2
  %t882 = select i1 %t881, i8* %t880, i8* %t879
  %t883 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t884 = icmp eq i32 %t872, 3
  %t885 = select i1 %t884, i8* %t883, i8* %t882
  %t886 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t887 = icmp eq i32 %t872, 4
  %t888 = select i1 %t887, i8* %t886, i8* %t885
  %t889 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t890 = icmp eq i32 %t872, 5
  %t891 = select i1 %t890, i8* %t889, i8* %t888
  %t892 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t893 = icmp eq i32 %t872, 6
  %t894 = select i1 %t893, i8* %t892, i8* %t891
  %t895 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t896 = icmp eq i32 %t872, 7
  %t897 = select i1 %t896, i8* %t895, i8* %t894
  %t898 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t899 = icmp eq i32 %t872, 8
  %t900 = select i1 %t899, i8* %t898, i8* %t897
  %t901 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t902 = icmp eq i32 %t872, 9
  %t903 = select i1 %t902, i8* %t901, i8* %t900
  %t904 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t905 = icmp eq i32 %t872, 10
  %t906 = select i1 %t905, i8* %t904, i8* %t903
  %t907 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t908 = icmp eq i32 %t872, 11
  %t909 = select i1 %t908, i8* %t907, i8* %t906
  %t910 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t911 = icmp eq i32 %t872, 12
  %t912 = select i1 %t911, i8* %t910, i8* %t909
  %t913 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t914 = icmp eq i32 %t872, 13
  %t915 = select i1 %t914, i8* %t913, i8* %t912
  %t916 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t917 = icmp eq i32 %t872, 14
  %t918 = select i1 %t917, i8* %t916, i8* %t915
  %t919 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t920 = icmp eq i32 %t872, 15
  %t921 = select i1 %t920, i8* %t919, i8* %t918
  %s922 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h826984377, i32 0, i32 0
  %t923 = call i1 @strings_equal(i8* %t921, i8* %s922)
  br i1 %t923, label %then28, label %merge29
then28:
  %t924 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t925 = ptrtoint [0 x i8*]* %t924 to i64
  %t926 = icmp eq i64 %t925, 0
  %t927 = select i1 %t926, i64 1, i64 %t925
  %t928 = call i8* @malloc(i64 %t927)
  %t929 = bitcast i8* %t928 to i8**
  %t930 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t931 = ptrtoint { i8**, i64 }* %t930 to i64
  %t932 = call i8* @malloc(i64 %t931)
  %t933 = bitcast i8* %t932 to { i8**, i64 }*
  %t934 = getelementptr { i8**, i64 }, { i8**, i64 }* %t933, i32 0, i32 0
  store i8** %t929, i8*** %t934
  %t935 = getelementptr { i8**, i64 }, { i8**, i64 }* %t933, i32 0, i32 1
  store i64 0, i64* %t935
  store { i8**, i64 }* %t933, { i8**, i64 }** %l5
  %t936 = sitofp i64 0 to double
  store double %t936, double* %l6
  %t937 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t938 = load double, double* %l6
  br label %loop.header30
loop.header30:
  %t1002 = phi { i8**, i64 }* [ %t937, %then28 ], [ %t1000, %loop.latch32 ]
  %t1003 = phi double [ %t938, %then28 ], [ %t1001, %loop.latch32 ]
  store { i8**, i64 }* %t1002, { i8**, i64 }** %l5
  store double %t1003, double* %l6
  br label %loop.body31
loop.body31:
  %t939 = load double, double* %l6
  %t940 = extractvalue %Expression %expression, 0
  %t941 = alloca %Expression
  store %Expression %expression, %Expression* %t941
  %t942 = getelementptr inbounds %Expression, %Expression* %t941, i32 0, i32 1
  %t943 = bitcast [8 x i8]* %t942 to i8*
  %t944 = bitcast i8* %t943 to { %ObjectField**, i64 }**
  %t945 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t944
  %t946 = icmp eq i32 %t940, 11
  %t947 = select i1 %t946, { %ObjectField**, i64 }* %t945, { %ObjectField**, i64 }* null
  %t948 = getelementptr inbounds %Expression, %Expression* %t941, i32 0, i32 1
  %t949 = bitcast [16 x i8]* %t948 to i8*
  %t950 = getelementptr inbounds i8, i8* %t949, i64 8
  %t951 = bitcast i8* %t950 to { %ObjectField**, i64 }**
  %t952 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t951
  %t953 = icmp eq i32 %t940, 12
  %t954 = select i1 %t953, { %ObjectField**, i64 }* %t952, { %ObjectField**, i64 }* %t947
  %t955 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t954
  %t956 = extractvalue { %ObjectField**, i64 } %t955, 1
  %t957 = sitofp i64 %t956 to double
  %t958 = fcmp oge double %t939, %t957
  %t959 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t960 = load double, double* %l6
  br i1 %t958, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t961 = extractvalue %Expression %expression, 0
  %t962 = alloca %Expression
  store %Expression %expression, %Expression* %t962
  %t963 = getelementptr inbounds %Expression, %Expression* %t962, i32 0, i32 1
  %t964 = bitcast [8 x i8]* %t963 to i8*
  %t965 = bitcast i8* %t964 to { %ObjectField**, i64 }**
  %t966 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t965
  %t967 = icmp eq i32 %t961, 11
  %t968 = select i1 %t967, { %ObjectField**, i64 }* %t966, { %ObjectField**, i64 }* null
  %t969 = getelementptr inbounds %Expression, %Expression* %t962, i32 0, i32 1
  %t970 = bitcast [16 x i8]* %t969 to i8*
  %t971 = getelementptr inbounds i8, i8* %t970, i64 8
  %t972 = bitcast i8* %t971 to { %ObjectField**, i64 }**
  %t973 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t972
  %t974 = icmp eq i32 %t961, 12
  %t975 = select i1 %t974, { %ObjectField**, i64 }* %t973, { %ObjectField**, i64 }* %t968
  %t976 = load double, double* %l6
  %t977 = call double @llvm.round.f64(double %t976)
  %t978 = fptosi double %t977 to i64
  %t979 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t975
  %t980 = extractvalue { %ObjectField**, i64 } %t979, 0
  %t981 = extractvalue { %ObjectField**, i64 } %t979, 1
  %t982 = icmp uge i64 %t978, %t981
  ; bounds check: %t982 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t978, i64 %t981)
  %t983 = getelementptr %ObjectField*, %ObjectField** %t980, i64 %t978
  %t984 = load %ObjectField*, %ObjectField** %t983
  store %ObjectField* %t984, %ObjectField** %l7
  %t985 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t986 = load %ObjectField*, %ObjectField** %l7
  %t987 = getelementptr %ObjectField, %ObjectField* %t986, i32 0, i32 0
  %t988 = load i8*, i8** %t987
  %s989 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193441217, i32 0, i32 0
  %t990 = call i8* @sailfin_runtime_string_concat(i8* %t988, i8* %s989)
  %t991 = load %ObjectField*, %ObjectField** %l7
  %t992 = getelementptr %ObjectField, %ObjectField* %t991, i32 0, i32 1
  %t993 = load %Expression, %Expression* %t992
  %t994 = call i8* @format_expression(%Expression %t993)
  %t995 = call i8* @sailfin_runtime_string_concat(i8* %t990, i8* %t994)
  %t996 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t985, i8* %t995)
  store { i8**, i64 }* %t996, { i8**, i64 }** %l5
  %t997 = load double, double* %l6
  %t998 = sitofp i64 1 to double
  %t999 = fadd double %t997, %t998
  store double %t999, double* %l6
  br label %loop.latch32
loop.latch32:
  %t1000 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1001 = load double, double* %l6
  br label %loop.header30
afterloop33:
  %t1004 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1005 = load double, double* %l6
  %s1006 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193512002, i32 0, i32 0
  %t1007 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s1008 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t1009 = call i8* @join_with_separator({ i8**, i64 }* %t1007, i8* %s1008)
  %t1010 = call i8* @sailfin_runtime_string_concat(i8* %s1006, i8* %t1009)
  %s1011 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415972, i32 0, i32 0
  %t1012 = call i8* @sailfin_runtime_string_concat(i8* %t1010, i8* %s1011)
  call void @sailfin_runtime_mark_persistent(i8* %t1012)
  ret i8* %t1012
merge29:
  %t1013 = extractvalue %Expression %expression, 0
  %t1014 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1015 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1016 = icmp eq i32 %t1013, 0
  %t1017 = select i1 %t1016, i8* %t1015, i8* %t1014
  %t1018 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1019 = icmp eq i32 %t1013, 1
  %t1020 = select i1 %t1019, i8* %t1018, i8* %t1017
  %t1021 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1022 = icmp eq i32 %t1013, 2
  %t1023 = select i1 %t1022, i8* %t1021, i8* %t1020
  %t1024 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1025 = icmp eq i32 %t1013, 3
  %t1026 = select i1 %t1025, i8* %t1024, i8* %t1023
  %t1027 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1028 = icmp eq i32 %t1013, 4
  %t1029 = select i1 %t1028, i8* %t1027, i8* %t1026
  %t1030 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1031 = icmp eq i32 %t1013, 5
  %t1032 = select i1 %t1031, i8* %t1030, i8* %t1029
  %t1033 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1034 = icmp eq i32 %t1013, 6
  %t1035 = select i1 %t1034, i8* %t1033, i8* %t1032
  %t1036 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1037 = icmp eq i32 %t1013, 7
  %t1038 = select i1 %t1037, i8* %t1036, i8* %t1035
  %t1039 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1040 = icmp eq i32 %t1013, 8
  %t1041 = select i1 %t1040, i8* %t1039, i8* %t1038
  %t1042 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1043 = icmp eq i32 %t1013, 9
  %t1044 = select i1 %t1043, i8* %t1042, i8* %t1041
  %t1045 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1046 = icmp eq i32 %t1013, 10
  %t1047 = select i1 %t1046, i8* %t1045, i8* %t1044
  %t1048 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1049 = icmp eq i32 %t1013, 11
  %t1050 = select i1 %t1049, i8* %t1048, i8* %t1047
  %t1051 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1052 = icmp eq i32 %t1013, 12
  %t1053 = select i1 %t1052, i8* %t1051, i8* %t1050
  %t1054 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1055 = icmp eq i32 %t1013, 13
  %t1056 = select i1 %t1055, i8* %t1054, i8* %t1053
  %t1057 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1058 = icmp eq i32 %t1013, 14
  %t1059 = select i1 %t1058, i8* %t1057, i8* %t1056
  %t1060 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1061 = icmp eq i32 %t1013, 15
  %t1062 = select i1 %t1061, i8* %t1060, i8* %t1059
  %s1063 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h264904746, i32 0, i32 0
  %t1064 = call i1 @strings_equal(i8* %t1062, i8* %s1063)
  br i1 %t1064, label %then36, label %merge37
then36:
  %t1065 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1066 = ptrtoint [0 x i8*]* %t1065 to i64
  %t1067 = icmp eq i64 %t1066, 0
  %t1068 = select i1 %t1067, i64 1, i64 %t1066
  %t1069 = call i8* @malloc(i64 %t1068)
  %t1070 = bitcast i8* %t1069 to i8**
  %t1071 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t1072 = ptrtoint { i8**, i64 }* %t1071 to i64
  %t1073 = call i8* @malloc(i64 %t1072)
  %t1074 = bitcast i8* %t1073 to { i8**, i64 }*
  %t1075 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1074, i32 0, i32 0
  store i8** %t1070, i8*** %t1075
  %t1076 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1074, i32 0, i32 1
  store i64 0, i64* %t1076
  store { i8**, i64 }* %t1074, { i8**, i64 }** %l8
  %t1077 = sitofp i64 0 to double
  store double %t1077, double* %l9
  %t1078 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1079 = load double, double* %l9
  br label %loop.header38
loop.header38:
  %t1143 = phi { i8**, i64 }* [ %t1078, %then36 ], [ %t1141, %loop.latch40 ]
  %t1144 = phi double [ %t1079, %then36 ], [ %t1142, %loop.latch40 ]
  store { i8**, i64 }* %t1143, { i8**, i64 }** %l8
  store double %t1144, double* %l9
  br label %loop.body39
loop.body39:
  %t1080 = load double, double* %l9
  %t1081 = extractvalue %Expression %expression, 0
  %t1082 = alloca %Expression
  store %Expression %expression, %Expression* %t1082
  %t1083 = getelementptr inbounds %Expression, %Expression* %t1082, i32 0, i32 1
  %t1084 = bitcast [8 x i8]* %t1083 to i8*
  %t1085 = bitcast i8* %t1084 to { %ObjectField**, i64 }**
  %t1086 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t1085
  %t1087 = icmp eq i32 %t1081, 11
  %t1088 = select i1 %t1087, { %ObjectField**, i64 }* %t1086, { %ObjectField**, i64 }* null
  %t1089 = getelementptr inbounds %Expression, %Expression* %t1082, i32 0, i32 1
  %t1090 = bitcast [16 x i8]* %t1089 to i8*
  %t1091 = getelementptr inbounds i8, i8* %t1090, i64 8
  %t1092 = bitcast i8* %t1091 to { %ObjectField**, i64 }**
  %t1093 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t1092
  %t1094 = icmp eq i32 %t1081, 12
  %t1095 = select i1 %t1094, { %ObjectField**, i64 }* %t1093, { %ObjectField**, i64 }* %t1088
  %t1096 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t1095
  %t1097 = extractvalue { %ObjectField**, i64 } %t1096, 1
  %t1098 = sitofp i64 %t1097 to double
  %t1099 = fcmp oge double %t1080, %t1098
  %t1100 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1101 = load double, double* %l9
  br i1 %t1099, label %then42, label %merge43
then42:
  br label %afterloop41
merge43:
  %t1102 = extractvalue %Expression %expression, 0
  %t1103 = alloca %Expression
  store %Expression %expression, %Expression* %t1103
  %t1104 = getelementptr inbounds %Expression, %Expression* %t1103, i32 0, i32 1
  %t1105 = bitcast [8 x i8]* %t1104 to i8*
  %t1106 = bitcast i8* %t1105 to { %ObjectField**, i64 }**
  %t1107 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t1106
  %t1108 = icmp eq i32 %t1102, 11
  %t1109 = select i1 %t1108, { %ObjectField**, i64 }* %t1107, { %ObjectField**, i64 }* null
  %t1110 = getelementptr inbounds %Expression, %Expression* %t1103, i32 0, i32 1
  %t1111 = bitcast [16 x i8]* %t1110 to i8*
  %t1112 = getelementptr inbounds i8, i8* %t1111, i64 8
  %t1113 = bitcast i8* %t1112 to { %ObjectField**, i64 }**
  %t1114 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t1113
  %t1115 = icmp eq i32 %t1102, 12
  %t1116 = select i1 %t1115, { %ObjectField**, i64 }* %t1114, { %ObjectField**, i64 }* %t1109
  %t1117 = load double, double* %l9
  %t1118 = call double @llvm.round.f64(double %t1117)
  %t1119 = fptosi double %t1118 to i64
  %t1120 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t1116
  %t1121 = extractvalue { %ObjectField**, i64 } %t1120, 0
  %t1122 = extractvalue { %ObjectField**, i64 } %t1120, 1
  %t1123 = icmp uge i64 %t1119, %t1122
  ; bounds check: %t1123 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1119, i64 %t1122)
  %t1124 = getelementptr %ObjectField*, %ObjectField** %t1121, i64 %t1119
  %t1125 = load %ObjectField*, %ObjectField** %t1124
  store %ObjectField* %t1125, %ObjectField** %l10
  %t1126 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1127 = load %ObjectField*, %ObjectField** %l10
  %t1128 = getelementptr %ObjectField, %ObjectField* %t1127, i32 0, i32 0
  %t1129 = load i8*, i8** %t1128
  %s1130 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193441217, i32 0, i32 0
  %t1131 = call i8* @sailfin_runtime_string_concat(i8* %t1129, i8* %s1130)
  %t1132 = load %ObjectField*, %ObjectField** %l10
  %t1133 = getelementptr %ObjectField, %ObjectField* %t1132, i32 0, i32 1
  %t1134 = load %Expression, %Expression* %t1133
  %t1135 = call i8* @format_expression(%Expression %t1134)
  %t1136 = call i8* @sailfin_runtime_string_concat(i8* %t1131, i8* %t1135)
  %t1137 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1126, i8* %t1136)
  store { i8**, i64 }* %t1137, { i8**, i64 }** %l8
  %t1138 = load double, double* %l9
  %t1139 = sitofp i64 1 to double
  %t1140 = fadd double %t1138, %t1139
  store double %t1140, double* %l9
  br label %loop.latch40
loop.latch40:
  %t1141 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1142 = load double, double* %l9
  br label %loop.header38
afterloop41:
  %t1145 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t1146 = load double, double* %l9
  %t1147 = extractvalue %Expression %expression, 0
  %t1148 = alloca %Expression
  store %Expression %expression, %Expression* %t1148
  %t1149 = getelementptr inbounds %Expression, %Expression* %t1148, i32 0, i32 1
  %t1150 = bitcast [16 x i8]* %t1149 to i8*
  %t1151 = bitcast i8* %t1150 to { i8**, i64 }**
  %t1152 = load { i8**, i64 }*, { i8**, i64 }** %t1151
  %t1153 = icmp eq i32 %t1147, 12
  %t1154 = select i1 %t1153, { i8**, i64 }* %t1152, { i8**, i64 }* null
  %t1155 = alloca [2 x i8], align 1
  %t1156 = getelementptr [2 x i8], [2 x i8]* %t1155, i32 0, i32 0
  store i8 46, i8* %t1156
  %t1157 = getelementptr [2 x i8], [2 x i8]* %t1155, i32 0, i32 1
  store i8 0, i8* %t1157
  %t1158 = getelementptr [2 x i8], [2 x i8]* %t1155, i32 0, i32 0
  %t1159 = call i8* @join_with_separator({ i8**, i64 }* %t1154, i8* %t1158)
  store i8* %t1159, i8** %l11
  %t1160 = load i8*, i8** %l11
  %s1161 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087758597, i32 0, i32 0
  %t1162 = call i8* @sailfin_runtime_string_concat(i8* %t1160, i8* %s1161)
  %t1163 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %s1164 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t1165 = call i8* @join_with_separator({ i8**, i64 }* %t1163, i8* %s1164)
  %t1166 = call i8* @sailfin_runtime_string_concat(i8* %t1162, i8* %t1165)
  %s1167 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415972, i32 0, i32 0
  %t1168 = call i8* @sailfin_runtime_string_concat(i8* %t1166, i8* %s1167)
  call void @sailfin_runtime_mark_persistent(i8* %t1168)
  ret i8* %t1168
merge37:
  %t1169 = extractvalue %Expression %expression, 0
  %t1170 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1171 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1172 = icmp eq i32 %t1169, 0
  %t1173 = select i1 %t1172, i8* %t1171, i8* %t1170
  %t1174 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1175 = icmp eq i32 %t1169, 1
  %t1176 = select i1 %t1175, i8* %t1174, i8* %t1173
  %t1177 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1178 = icmp eq i32 %t1169, 2
  %t1179 = select i1 %t1178, i8* %t1177, i8* %t1176
  %t1180 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1181 = icmp eq i32 %t1169, 3
  %t1182 = select i1 %t1181, i8* %t1180, i8* %t1179
  %t1183 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1184 = icmp eq i32 %t1169, 4
  %t1185 = select i1 %t1184, i8* %t1183, i8* %t1182
  %t1186 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1187 = icmp eq i32 %t1169, 5
  %t1188 = select i1 %t1187, i8* %t1186, i8* %t1185
  %t1189 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1190 = icmp eq i32 %t1169, 6
  %t1191 = select i1 %t1190, i8* %t1189, i8* %t1188
  %t1192 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1193 = icmp eq i32 %t1169, 7
  %t1194 = select i1 %t1193, i8* %t1192, i8* %t1191
  %t1195 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1196 = icmp eq i32 %t1169, 8
  %t1197 = select i1 %t1196, i8* %t1195, i8* %t1194
  %t1198 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1199 = icmp eq i32 %t1169, 9
  %t1200 = select i1 %t1199, i8* %t1198, i8* %t1197
  %t1201 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1202 = icmp eq i32 %t1169, 10
  %t1203 = select i1 %t1202, i8* %t1201, i8* %t1200
  %t1204 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1205 = icmp eq i32 %t1169, 11
  %t1206 = select i1 %t1205, i8* %t1204, i8* %t1203
  %t1207 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1208 = icmp eq i32 %t1169, 12
  %t1209 = select i1 %t1208, i8* %t1207, i8* %t1206
  %t1210 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1211 = icmp eq i32 %t1169, 13
  %t1212 = select i1 %t1211, i8* %t1210, i8* %t1209
  %t1213 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1214 = icmp eq i32 %t1169, 14
  %t1215 = select i1 %t1214, i8* %t1213, i8* %t1212
  %t1216 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1217 = icmp eq i32 %t1169, 15
  %t1218 = select i1 %t1217, i8* %t1216, i8* %t1215
  %s1219 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1312780988, i32 0, i32 0
  %t1220 = call i1 @strings_equal(i8* %t1218, i8* %s1219)
  br i1 %t1220, label %then44, label %merge45
then44:
  %t1221 = extractvalue %Expression %expression, 0
  %t1222 = alloca %Expression
  store %Expression %expression, %Expression* %t1222
  %t1223 = getelementptr inbounds %Expression, %Expression* %t1222, i32 0, i32 1
  %t1224 = bitcast [16 x i8]* %t1223 to i8*
  %t1225 = bitcast i8* %t1224 to %Expression**
  %t1226 = load %Expression*, %Expression** %t1225
  %t1227 = icmp eq i32 %t1221, 14
  %t1228 = select i1 %t1227, %Expression* %t1226, %Expression* null
  %t1229 = load %Expression, %Expression* %t1228
  %t1230 = call i8* @format_expression(%Expression %t1229)
  %s1231 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428611, i32 0, i32 0
  %t1232 = call i8* @sailfin_runtime_string_concat(i8* %t1230, i8* %s1231)
  %t1233 = extractvalue %Expression %expression, 0
  %t1234 = alloca %Expression
  store %Expression %expression, %Expression* %t1234
  %t1235 = getelementptr inbounds %Expression, %Expression* %t1234, i32 0, i32 1
  %t1236 = bitcast [16 x i8]* %t1235 to i8*
  %t1237 = getelementptr inbounds i8, i8* %t1236, i64 8
  %t1238 = bitcast i8* %t1237 to %Expression**
  %t1239 = load %Expression*, %Expression** %t1238
  %t1240 = icmp eq i32 %t1233, 14
  %t1241 = select i1 %t1240, %Expression* %t1239, %Expression* null
  %t1242 = load %Expression, %Expression* %t1241
  %t1243 = call i8* @format_expression(%Expression %t1242)
  %t1244 = call i8* @sailfin_runtime_string_concat(i8* %t1232, i8* %t1243)
  call void @sailfin_runtime_mark_persistent(i8* %t1244)
  ret i8* %t1244
merge45:
  %t1245 = extractvalue %Expression %expression, 0
  %t1246 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1247 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1248 = icmp eq i32 %t1245, 0
  %t1249 = select i1 %t1248, i8* %t1247, i8* %t1246
  %t1250 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1251 = icmp eq i32 %t1245, 1
  %t1252 = select i1 %t1251, i8* %t1250, i8* %t1249
  %t1253 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1254 = icmp eq i32 %t1245, 2
  %t1255 = select i1 %t1254, i8* %t1253, i8* %t1252
  %t1256 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1257 = icmp eq i32 %t1245, 3
  %t1258 = select i1 %t1257, i8* %t1256, i8* %t1255
  %t1259 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1260 = icmp eq i32 %t1245, 4
  %t1261 = select i1 %t1260, i8* %t1259, i8* %t1258
  %t1262 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1263 = icmp eq i32 %t1245, 5
  %t1264 = select i1 %t1263, i8* %t1262, i8* %t1261
  %t1265 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1266 = icmp eq i32 %t1245, 6
  %t1267 = select i1 %t1266, i8* %t1265, i8* %t1264
  %t1268 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1269 = icmp eq i32 %t1245, 7
  %t1270 = select i1 %t1269, i8* %t1268, i8* %t1267
  %t1271 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1272 = icmp eq i32 %t1245, 8
  %t1273 = select i1 %t1272, i8* %t1271, i8* %t1270
  %t1274 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1275 = icmp eq i32 %t1245, 9
  %t1276 = select i1 %t1275, i8* %t1274, i8* %t1273
  %t1277 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1278 = icmp eq i32 %t1245, 10
  %t1279 = select i1 %t1278, i8* %t1277, i8* %t1276
  %t1280 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1281 = icmp eq i32 %t1245, 11
  %t1282 = select i1 %t1281, i8* %t1280, i8* %t1279
  %t1283 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1284 = icmp eq i32 %t1245, 12
  %t1285 = select i1 %t1284, i8* %t1283, i8* %t1282
  %t1286 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1287 = icmp eq i32 %t1245, 13
  %t1288 = select i1 %t1287, i8* %t1286, i8* %t1285
  %t1289 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1290 = icmp eq i32 %t1245, 14
  %t1291 = select i1 %t1290, i8* %t1289, i8* %t1288
  %t1292 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1293 = icmp eq i32 %t1245, 15
  %t1294 = select i1 %t1293, i8* %t1292, i8* %t1291
  %s1295 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1211862785, i32 0, i32 0
  %t1296 = call i1 @strings_equal(i8* %t1294, i8* %s1295)
  br i1 %t1296, label %then46, label %merge47
then46:
  %s1297 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h573909064, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s1297)
  ret i8* %s1297
merge47:
  %t1298 = extractvalue %Expression %expression, 0
  %t1299 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1300 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1301 = icmp eq i32 %t1298, 0
  %t1302 = select i1 %t1301, i8* %t1300, i8* %t1299
  %t1303 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1304 = icmp eq i32 %t1298, 1
  %t1305 = select i1 %t1304, i8* %t1303, i8* %t1302
  %t1306 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1307 = icmp eq i32 %t1298, 2
  %t1308 = select i1 %t1307, i8* %t1306, i8* %t1305
  %t1309 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1310 = icmp eq i32 %t1298, 3
  %t1311 = select i1 %t1310, i8* %t1309, i8* %t1308
  %t1312 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1313 = icmp eq i32 %t1298, 4
  %t1314 = select i1 %t1313, i8* %t1312, i8* %t1311
  %t1315 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1316 = icmp eq i32 %t1298, 5
  %t1317 = select i1 %t1316, i8* %t1315, i8* %t1314
  %t1318 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1319 = icmp eq i32 %t1298, 6
  %t1320 = select i1 %t1319, i8* %t1318, i8* %t1317
  %t1321 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1322 = icmp eq i32 %t1298, 7
  %t1323 = select i1 %t1322, i8* %t1321, i8* %t1320
  %t1324 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1325 = icmp eq i32 %t1298, 8
  %t1326 = select i1 %t1325, i8* %t1324, i8* %t1323
  %t1327 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1328 = icmp eq i32 %t1298, 9
  %t1329 = select i1 %t1328, i8* %t1327, i8* %t1326
  %t1330 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1331 = icmp eq i32 %t1298, 10
  %t1332 = select i1 %t1331, i8* %t1330, i8* %t1329
  %t1333 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1334 = icmp eq i32 %t1298, 11
  %t1335 = select i1 %t1334, i8* %t1333, i8* %t1332
  %t1336 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1337 = icmp eq i32 %t1298, 12
  %t1338 = select i1 %t1337, i8* %t1336, i8* %t1335
  %t1339 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1340 = icmp eq i32 %t1298, 13
  %t1341 = select i1 %t1340, i8* %t1339, i8* %t1338
  %t1342 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1343 = icmp eq i32 %t1298, 14
  %t1344 = select i1 %t1343, i8* %t1342, i8* %t1341
  %t1345 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1346 = icmp eq i32 %t1298, 15
  %t1347 = select i1 %t1346, i8* %t1345, i8* %t1344
  %s1348 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089530004, i32 0, i32 0
  %t1349 = call i1 @strings_equal(i8* %t1347, i8* %s1348)
  br i1 %t1349, label %then48, label %merge49
then48:
  %t1350 = extractvalue %Expression %expression, 0
  %t1351 = alloca %Expression
  store %Expression %expression, %Expression* %t1351
  %t1352 = getelementptr inbounds %Expression, %Expression* %t1351, i32 0, i32 1
  %t1353 = bitcast [8 x i8]* %t1352 to i8*
  %t1354 = bitcast i8* %t1353 to i8**
  %t1355 = load i8*, i8** %t1354
  %t1356 = icmp eq i32 %t1350, 15
  %t1357 = select i1 %t1356, i8* %t1355, i8* null
  %t1358 = call i8* @trim_text(i8* %t1357)
  call void @sailfin_runtime_mark_persistent(i8* %t1358)
  ret i8* %t1358
merge49:
  %t1359 = extractvalue %Expression %expression, 0
  %t1360 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t1361 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t1362 = icmp eq i32 %t1359, 0
  %t1363 = select i1 %t1362, i8* %t1361, i8* %t1360
  %t1364 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t1365 = icmp eq i32 %t1359, 1
  %t1366 = select i1 %t1365, i8* %t1364, i8* %t1363
  %t1367 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t1368 = icmp eq i32 %t1359, 2
  %t1369 = select i1 %t1368, i8* %t1367, i8* %t1366
  %t1370 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t1371 = icmp eq i32 %t1359, 3
  %t1372 = select i1 %t1371, i8* %t1370, i8* %t1369
  %t1373 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t1374 = icmp eq i32 %t1359, 4
  %t1375 = select i1 %t1374, i8* %t1373, i8* %t1372
  %t1376 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t1377 = icmp eq i32 %t1359, 5
  %t1378 = select i1 %t1377, i8* %t1376, i8* %t1375
  %t1379 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t1380 = icmp eq i32 %t1359, 6
  %t1381 = select i1 %t1380, i8* %t1379, i8* %t1378
  %t1382 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t1383 = icmp eq i32 %t1359, 7
  %t1384 = select i1 %t1383, i8* %t1382, i8* %t1381
  %t1385 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t1386 = icmp eq i32 %t1359, 8
  %t1387 = select i1 %t1386, i8* %t1385, i8* %t1384
  %t1388 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t1389 = icmp eq i32 %t1359, 9
  %t1390 = select i1 %t1389, i8* %t1388, i8* %t1387
  %t1391 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t1392 = icmp eq i32 %t1359, 10
  %t1393 = select i1 %t1392, i8* %t1391, i8* %t1390
  %t1394 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t1395 = icmp eq i32 %t1359, 11
  %t1396 = select i1 %t1395, i8* %t1394, i8* %t1393
  %t1397 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t1398 = icmp eq i32 %t1359, 12
  %t1399 = select i1 %t1398, i8* %t1397, i8* %t1396
  %t1400 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t1401 = icmp eq i32 %t1359, 13
  %t1402 = select i1 %t1401, i8* %t1400, i8* %t1399
  %t1403 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t1404 = icmp eq i32 %t1359, 14
  %t1405 = select i1 %t1404, i8* %t1403, i8* %t1402
  %t1406 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t1407 = icmp eq i32 %t1359, 15
  %t1408 = select i1 %t1407, i8* %t1406, i8* %t1405
  %t1409 = alloca [2 x i8], align 1
  %t1410 = getelementptr [2 x i8], [2 x i8]* %t1409, i32 0, i32 0
  store i8 60, i8* %t1410
  %t1411 = getelementptr [2 x i8], [2 x i8]* %t1409, i32 0, i32 1
  store i8 0, i8* %t1411
  %t1412 = getelementptr [2 x i8], [2 x i8]* %t1409, i32 0, i32 0
  %t1413 = call i8* @sailfin_runtime_string_concat(i8* %t1412, i8* %t1408)
  %t1414 = alloca [2 x i8], align 1
  %t1415 = getelementptr [2 x i8], [2 x i8]* %t1414, i32 0, i32 0
  store i8 62, i8* %t1415
  %t1416 = getelementptr [2 x i8], [2 x i8]* %t1414, i32 0, i32 1
  store i8 0, i8* %t1416
  %t1417 = getelementptr [2 x i8], [2 x i8]* %t1414, i32 0, i32 0
  %t1418 = call i8* @sailfin_runtime_string_concat(i8* %t1413, i8* %t1417)
  call void @sailfin_runtime_mark_persistent(i8* %t1418)
  ret i8* %t1418
}

define i8* @format_array_expression({ %Expression*, i64 }* %elements) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca i8*
  %t0 = call i8* @infer_array_element_type({ %Expression*, i64 }* %elements)
  store i8* %t0, i8** %l0
  %t1 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t2 = ptrtoint [0 x i8*]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to i8**
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t8 = ptrtoint { i8**, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { i8**, i64 }*
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t6, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { i8**, i64 }* %t10, { i8**, i64 }** %l1
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l2
  %t14 = load i8*, i8** %l0
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t16 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t42 = phi { i8**, i64 }* [ %t15, %block.entry ], [ %t40, %loop.latch2 ]
  %t43 = phi double [ %t16, %block.entry ], [ %t41, %loop.latch2 ]
  store { i8**, i64 }* %t42, { i8**, i64 }** %l1
  store double %t43, double* %l2
  br label %loop.body1
loop.body1:
  %t17 = load double, double* %l2
  %t18 = load { %Expression*, i64 }, { %Expression*, i64 }* %elements
  %t19 = extractvalue { %Expression*, i64 } %t18, 1
  %t20 = sitofp i64 %t19 to double
  %t21 = fcmp oge double %t17, %t20
  %t22 = load i8*, i8** %l0
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t24 = load double, double* %l2
  br i1 %t21, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t26 = load double, double* %l2
  %t27 = call double @llvm.round.f64(double %t26)
  %t28 = fptosi double %t27 to i64
  %t29 = load { %Expression*, i64 }, { %Expression*, i64 }* %elements
  %t30 = extractvalue { %Expression*, i64 } %t29, 0
  %t31 = extractvalue { %Expression*, i64 } %t29, 1
  %t32 = icmp uge i64 %t28, %t31
  ; bounds check: %t32 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t28, i64 %t31)
  %t33 = getelementptr %Expression, %Expression* %t30, i64 %t28
  %t34 = load %Expression, %Expression* %t33
  %t35 = call i8* @format_expression(%Expression %t34)
  %t36 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t25, i8* %t35)
  store { i8**, i64 }* %t36, { i8**, i64 }** %l1
  %t37 = load double, double* %l2
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l2
  br label %loop.latch2
loop.latch2:
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t41 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t45 = load double, double* %l2
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t47 = load { i8**, i64 }, { i8**, i64 }* %t46
  %t48 = extractvalue { i8**, i64 } %t47, 1
  %t49 = icmp eq i64 %t48, 0
  %t50 = load i8*, i8** %l0
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t52 = load double, double* %l2
  br i1 %t49, label %then6, label %merge7
then6:
  %t53 = load i8*, i8** %l0
  %t54 = call i64 @sailfin_runtime_string_length(i8* %t53)
  %t55 = icmp eq i64 %t54, 0
  %t56 = load i8*, i8** %l0
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t58 = load double, double* %l2
  br i1 %t55, label %then8, label %merge9
then8:
  %s59 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193479167, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s59)
  ret i8* %s59
merge9:
  %s60 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1720834339, i32 0, i32 0
  %t61 = load i8*, i8** %l0
  %t62 = call i8* @sailfin_runtime_string_concat(i8* %s60, i8* %t61)
  %t63 = alloca [2 x i8], align 1
  %t64 = getelementptr [2 x i8], [2 x i8]* %t63, i32 0, i32 0
  store i8 93, i8* %t64
  %t65 = getelementptr [2 x i8], [2 x i8]* %t63, i32 0, i32 1
  store i8 0, i8* %t65
  %t66 = getelementptr [2 x i8], [2 x i8]* %t63, i32 0, i32 0
  %t67 = call i8* @sailfin_runtime_string_concat(i8* %t62, i8* %t66)
  call void @sailfin_runtime_mark_persistent(i8* %t67)
  ret i8* %t67
merge7:
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s69 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t70 = call i8* @join_with_separator({ i8**, i64 }* %t68, i8* %s69)
  store i8* %t70, i8** %l3
  %t71 = load i8*, i8** %l0
  %t72 = call i64 @sailfin_runtime_string_length(i8* %t71)
  %t73 = icmp eq i64 %t72, 0
  %t74 = load i8*, i8** %l0
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t76 = load double, double* %l2
  %t77 = load i8*, i8** %l3
  br i1 %t73, label %then10, label %merge11
then10:
  %t78 = load i8*, i8** %l3
  %t79 = alloca [2 x i8], align 1
  %t80 = getelementptr [2 x i8], [2 x i8]* %t79, i32 0, i32 0
  store i8 91, i8* %t80
  %t81 = getelementptr [2 x i8], [2 x i8]* %t79, i32 0, i32 1
  store i8 0, i8* %t81
  %t82 = getelementptr [2 x i8], [2 x i8]* %t79, i32 0, i32 0
  %t83 = call i8* @sailfin_runtime_string_concat(i8* %t82, i8* %t78)
  %t84 = alloca [2 x i8], align 1
  %t85 = getelementptr [2 x i8], [2 x i8]* %t84, i32 0, i32 0
  store i8 93, i8* %t85
  %t86 = getelementptr [2 x i8], [2 x i8]* %t84, i32 0, i32 1
  store i8 0, i8* %t86
  %t87 = getelementptr [2 x i8], [2 x i8]* %t84, i32 0, i32 0
  %t88 = call i8* @sailfin_runtime_string_concat(i8* %t83, i8* %t87)
  call void @sailfin_runtime_mark_persistent(i8* %t88)
  ret i8* %t88
merge11:
  %s89 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1720834339, i32 0, i32 0
  %t90 = load i8*, i8** %l0
  %t91 = call i8* @sailfin_runtime_string_concat(i8* %s89, i8* %t90)
  %s92 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t93 = call i8* @sailfin_runtime_string_concat(i8* %t91, i8* %s92)
  %t94 = load i8*, i8** %l3
  %t95 = call i8* @sailfin_runtime_string_concat(i8* %t93, i8* %t94)
  %t96 = alloca [2 x i8], align 1
  %t97 = getelementptr [2 x i8], [2 x i8]* %t96, i32 0, i32 0
  store i8 93, i8* %t97
  %t98 = getelementptr [2 x i8], [2 x i8]* %t96, i32 0, i32 1
  store i8 0, i8* %t98
  %t99 = getelementptr [2 x i8], [2 x i8]* %t96, i32 0, i32 0
  %t100 = call i8* @sailfin_runtime_string_concat(i8* %t95, i8* %t99)
  call void @sailfin_runtime_mark_persistent(i8* %t100)
  ret i8* %t100
}

define i8* @infer_array_element_type({ %Expression*, i64 }* %elements) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = load { %Expression*, i64 }, { %Expression*, i64 }* %elements
  %t1 = extractvalue { %Expression*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s3)
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
  %t54 = phi i8* [ %t6, %merge1 ], [ %t52, %loop.latch4 ]
  %t55 = phi double [ %t7, %merge1 ], [ %t53, %loop.latch4 ]
  store i8* %t54, i8** %l0
  store double %t55, double* %l1
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
  %t16 = call double @llvm.round.f64(double %t15)
  %t17 = fptosi double %t16 to i64
  %t18 = load { %Expression*, i64 }, { %Expression*, i64 }* %elements
  %t19 = extractvalue { %Expression*, i64 } %t18, 0
  %t20 = extractvalue { %Expression*, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t17, i64 %t20)
  %t22 = getelementptr %Expression, %Expression* %t19, i64 %t17
  %t23 = load %Expression, %Expression* %t22
  %t24 = call i8* @infer_expression_type(%Expression %t23)
  store i8* %t24, i8** %l2
  %t25 = load i8*, i8** %l2
  %t26 = call i64 @sailfin_runtime_string_length(i8* %t25)
  %t27 = icmp eq i64 %t26, 0
  %t28 = load i8*, i8** %l0
  %t29 = load double, double* %l1
  %t30 = load i8*, i8** %l2
  br i1 %t27, label %then8, label %merge9
then8:
  %s31 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s31)
  ret i8* %s31
merge9:
  %t32 = load i8*, i8** %l0
  %t33 = call i64 @sailfin_runtime_string_length(i8* %t32)
  %t34 = icmp eq i64 %t33, 0
  %t35 = load i8*, i8** %l0
  %t36 = load double, double* %l1
  %t37 = load i8*, i8** %l2
  br i1 %t34, label %then10, label %else11
then10:
  %t38 = load i8*, i8** %l2
  store i8* %t38, i8** %l0
  %t39 = load i8*, i8** %l0
  br label %merge12
else11:
  %t40 = load i8*, i8** %l0
  %t41 = load i8*, i8** %l2
  %t42 = call i1 @strings_equal(i8* %t40, i8* %t41)
  %t43 = xor i1 %t42, true
  %t44 = load i8*, i8** %l0
  %t45 = load double, double* %l1
  %t46 = load i8*, i8** %l2
  br i1 %t43, label %then13, label %merge14
then13:
  %s47 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s47)
  ret i8* %s47
merge14:
  br label %merge12
merge12:
  %t48 = phi i8* [ %t39, %then10 ], [ %t35, %merge14 ]
  store i8* %t48, i8** %l0
  %t49 = load double, double* %l1
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l1
  br label %loop.latch4
loop.latch4:
  %t52 = load i8*, i8** %l0
  %t53 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t56 = load i8*, i8** %l0
  %t57 = load double, double* %l1
  %t58 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t58)
  ret i8* %t58
}

define i8* @infer_expression_type(%Expression %expression) {
block.entry:
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
  %t51 = call i1 @strings_equal(i8* %t49, i8* %s50)
  br i1 %t51, label %then0, label %merge1
then0:
  %s52 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h807326654, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s52)
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
  %t104 = call i1 @strings_equal(i8* %t102, i8* %s103)
  br i1 %t104, label %then2, label %merge3
then2:
  %s105 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h1483009776, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s105)
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
  %t157 = call i1 @strings_equal(i8* %t155, i8* %s156)
  br i1 %t157, label %then4, label %merge5
then4:
  %s158 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h789270767, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s158)
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
  %t210 = call i1 @strings_equal(i8* %t208, i8* %s209)
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
  call void @sailfin_runtime_mark_persistent(i8* %s222)
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
  call void @sailfin_runtime_mark_persistent(i8* %t247)
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
  call void @sailfin_runtime_mark_persistent(i8* %t260)
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
  %t312 = call i1 @strings_equal(i8* %t310, i8* %s311)
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
  %t373 = call i1 @strings_equal(i8* %t371, i8* %s372)
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
  call void @sailfin_runtime_mark_persistent(i8* %t389)
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
  %t450 = call i1 @strings_equal(i8* %t448, i8* %s449)
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
  call void @sailfin_runtime_mark_persistent(i8* %t460)
  ret i8* %t460
merge17:
  %s461 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s461)
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
  %t513 = call i1 @strings_equal(i8* %t511, i8* %s512)
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
  call void @sailfin_runtime_mark_persistent(i8* %s528)
  ret i8* %s528
merge21:
  %t529 = load i8*, i8** %l0
  %s530 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193479167, i32 0, i32 0
  %t531 = call i8* @sailfin_runtime_string_concat(i8* %t529, i8* %s530)
  call void @sailfin_runtime_mark_persistent(i8* %t531)
  ret i8* %t531
merge19:
  %s532 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s532)
  ret i8* %s532
}

define i8* @quote_string(i8* %value) {
block.entry:
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
  %t30 = phi i8* [ %t5, %block.entry ], [ %t28, %loop.latch2 ]
  %t31 = phi double [ %t6, %block.entry ], [ %t29, %loop.latch2 ]
  store i8* %t30, i8** %l0
  store double %t31, double* %l1
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
  %t15 = call double @llvm.round.f64(double %t14)
  %t16 = fptosi double %t15 to i64
  %t17 = getelementptr i8, i8* %value, i64 %t16
  %t18 = load i8, i8* %t17
  %t19 = alloca [2 x i8], align 1
  %t20 = getelementptr [2 x i8], [2 x i8]* %t19, i32 0, i32 0
  store i8 %t18, i8* %t20
  %t21 = getelementptr [2 x i8], [2 x i8]* %t19, i32 0, i32 1
  store i8 0, i8* %t21
  %t22 = getelementptr [2 x i8], [2 x i8]* %t19, i32 0, i32 0
  %t23 = call i8* @escape_string_char(i8* %t22)
  %t24 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %t23)
  store i8* %t24, i8** %l0
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l1
  br label %loop.latch2
loop.latch2:
  %t28 = load i8*, i8** %l0
  %t29 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t32 = load i8*, i8** %l0
  %t33 = load double, double* %l1
  %t34 = load i8*, i8** %l0
  %t35 = alloca [2 x i8], align 1
  %t36 = getelementptr [2 x i8], [2 x i8]* %t35, i32 0, i32 0
  store i8 34, i8* %t36
  %t37 = getelementptr [2 x i8], [2 x i8]* %t35, i32 0, i32 1
  store i8 0, i8* %t37
  %t38 = getelementptr [2 x i8], [2 x i8]* %t35, i32 0, i32 0
  %t39 = call i8* @sailfin_runtime_string_concat(i8* %t34, i8* %t38)
  store i8* %t39, i8** %l0
  %t40 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t40)
  ret i8* %t40
}

define i8* @escape_string_char(i8* %ch) {
block.entry:
  %t0 = load i8, i8* %ch
  %t1 = icmp eq i8 %t0, 34
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193478309, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s2)
  ret i8* %s2
merge1:
  %t3 = load i8, i8* %ch
  %t4 = icmp eq i8 %t3, 92
  br i1 %t4, label %then2, label %merge3
then2:
  %s5 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193480223, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s5)
  ret i8* %s5
merge3:
  %t6 = load i8, i8* %ch
  %t7 = icmp eq i8 %t6, 10
  br i1 %t7, label %then4, label %merge5
then4:
  %s8 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193480817, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s8)
  ret i8* %s8
merge5:
  %t9 = load i8, i8* %ch
  %t10 = icmp eq i8 %t9, 13
  br i1 %t10, label %then6, label %merge7
then6:
  %s11 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193480949, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s11)
  ret i8* %s11
merge7:
  %t12 = load i8, i8* %ch
  %t13 = icmp eq i8 %t12, 9
  br i1 %t13, label %then8, label %merge9
then8:
  %s14 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193481015, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s14)
  ret i8* %s14
merge9:
  call void @sailfin_runtime_mark_persistent(i8* %ch)
  ret i8* %ch
}

define i8* @trim_text(i8* %value) {
block.entry:
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
  %t28 = phi double [ %t3, %block.entry ], [ %t27, %loop.latch2 ]
  store double %t28, double* %l0
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
  %t11 = call double @llvm.round.f64(double %t10)
  %t12 = fptosi double %t11 to i64
  %t13 = getelementptr i8, i8* %value, i64 %t12
  %t14 = load i8, i8* %t13
  store i8 %t14, i8* %l2
  %t15 = load i8, i8* %l2
  %t16 = alloca [2 x i8], align 1
  %t17 = getelementptr [2 x i8], [2 x i8]* %t16, i32 0, i32 0
  store i8 %t15, i8* %t17
  %t18 = getelementptr [2 x i8], [2 x i8]* %t16, i32 0, i32 1
  store i8 0, i8* %t18
  %t19 = getelementptr [2 x i8], [2 x i8]* %t16, i32 0, i32 0
  %t20 = call i1 @is_trim_char(i8* %t19)
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  %t23 = load i8, i8* %l2
  br i1 %t20, label %then6, label %merge7
then6:
  %t24 = load double, double* %l0
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t27 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t29 = load double, double* %l0
  %t30 = load double, double* %l0
  %t31 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t57 = phi double [ %t31, %afterloop3 ], [ %t56, %loop.latch10 ]
  store double %t57, double* %l1
  br label %loop.body9
loop.body9:
  %t32 = load double, double* %l1
  %t33 = load double, double* %l0
  %t34 = fcmp ole double %t32, %t33
  %t35 = load double, double* %l0
  %t36 = load double, double* %l1
  br i1 %t34, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t37 = load double, double* %l1
  %t38 = sitofp i64 1 to double
  %t39 = fsub double %t37, %t38
  %t40 = call double @llvm.round.f64(double %t39)
  %t41 = fptosi double %t40 to i64
  %t42 = getelementptr i8, i8* %value, i64 %t41
  %t43 = load i8, i8* %t42
  store i8 %t43, i8* %l3
  %t44 = load i8, i8* %l3
  %t45 = alloca [2 x i8], align 1
  %t46 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 0
  store i8 %t44, i8* %t46
  %t47 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 1
  store i8 0, i8* %t47
  %t48 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 0
  %t49 = call i1 @is_trim_char(i8* %t48)
  %t50 = load double, double* %l0
  %t51 = load double, double* %l1
  %t52 = load i8, i8* %l3
  br i1 %t49, label %then14, label %merge15
then14:
  %t53 = load double, double* %l1
  %t54 = sitofp i64 1 to double
  %t55 = fsub double %t53, %t54
  store double %t55, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t56 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t58 = load double, double* %l1
  %t60 = load double, double* %l0
  %t61 = sitofp i64 0 to double
  %t62 = fcmp oeq double %t60, %t61
  br label %logical_and_entry_59

logical_and_entry_59:
  br i1 %t62, label %logical_and_right_59, label %logical_and_merge_59

logical_and_right_59:
  %t63 = load double, double* %l1
  %t64 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t65 = sitofp i64 %t64 to double
  %t66 = fcmp oeq double %t63, %t65
  br label %logical_and_right_end_59

logical_and_right_end_59:
  br label %logical_and_merge_59

logical_and_merge_59:
  %t67 = phi i1 [ false, %logical_and_entry_59 ], [ %t66, %logical_and_right_end_59 ]
  %t68 = load double, double* %l0
  %t69 = load double, double* %l1
  br i1 %t67, label %then16, label %merge17
then16:
  call void @sailfin_runtime_mark_persistent(i8* %value)
  ret i8* %value
merge17:
  %t70 = load double, double* %l0
  %t71 = load double, double* %l1
  %t72 = call double @llvm.round.f64(double %t70)
  %t73 = fptosi double %t72 to i64
  %t74 = call double @llvm.round.f64(double %t71)
  %t75 = fptosi double %t74 to i64
  %t76 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t73, i64 %t75)
  call void @sailfin_runtime_mark_persistent(i8* %t76)
  ret i8* %t76
}

define i1 @is_trim_char(i8* %ch) {
block.entry:
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
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %Statement*
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t271 = phi { i8**, i64 }* [ %t13, %block.entry ], [ %t269, %loop.latch2 ]
  %t272 = phi double [ %t14, %block.entry ], [ %t270, %loop.latch2 ]
  store { i8**, i64 }* %t271, { i8**, i64 }** %l0
  store double %t272, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = extractvalue %Program %program, 0
  %t17 = load { %Statement**, i64 }, { %Statement**, i64 }* %t16
  %t18 = extractvalue { %Statement**, i64 } %t17, 1
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp oge double %t15, %t19
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load double, double* %l1
  br i1 %t20, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t23 = extractvalue %Program %program, 0
  %t24 = load double, double* %l1
  %t25 = call double @llvm.round.f64(double %t24)
  %t26 = fptosi double %t25 to i64
  %t27 = load { %Statement**, i64 }, { %Statement**, i64 }* %t23
  %t28 = extractvalue { %Statement**, i64 } %t27, 0
  %t29 = extractvalue { %Statement**, i64 } %t27, 1
  %t30 = icmp uge i64 %t26, %t29
  ; bounds check: %t30 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t26, i64 %t29)
  %t31 = getelementptr %Statement*, %Statement** %t28, i64 %t26
  %t32 = load %Statement*, %Statement** %t31
  store %Statement* %t32, %Statement** %l2
  %t33 = load %Statement*, %Statement** %l2
  %t34 = getelementptr inbounds %Statement, %Statement* %t33, i32 0, i32 0
  %t35 = load i32, i32* %t34
  %t36 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t37 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t35, 0
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %t40 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t41 = icmp eq i32 %t35, 1
  %t42 = select i1 %t41, i8* %t40, i8* %t39
  %t43 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t44 = icmp eq i32 %t35, 2
  %t45 = select i1 %t44, i8* %t43, i8* %t42
  %t46 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t47 = icmp eq i32 %t35, 3
  %t48 = select i1 %t47, i8* %t46, i8* %t45
  %t49 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t50 = icmp eq i32 %t35, 4
  %t51 = select i1 %t50, i8* %t49, i8* %t48
  %t52 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t53 = icmp eq i32 %t35, 5
  %t54 = select i1 %t53, i8* %t52, i8* %t51
  %t55 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t35, 6
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t35, 7
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t35, 8
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t35, 9
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t35, 10
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t35, 11
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t35, 12
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %t76 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t35, 13
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %t79 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t35, 14
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t35, 15
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %t85 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t35, 16
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t35, 17
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t35, 18
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t35, 19
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t35, 20
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %t100 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t35, 21
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %t103 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t104 = icmp eq i32 %t35, 22
  %t105 = select i1 %t104, i8* %t103, i8* %t102
  %s106 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h486335986, i32 0, i32 0
  %t107 = call i1 @strings_equal(i8* %t105, i8* %s106)
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t109 = load double, double* %l1
  %t110 = load %Statement*, %Statement** %l2
  br i1 %t107, label %then6, label %merge7
then6:
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t112 = load %Statement*, %Statement** %l2
  %t113 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 0
  %t114 = load i32, i32* %t113
  %t115 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t116 = bitcast [88 x i8]* %t115 to i8*
  %t117 = bitcast i8* %t116 to %FunctionSignature*
  %t118 = load %FunctionSignature, %FunctionSignature* %t117
  %t119 = icmp eq i32 %t114, 4
  %t120 = select i1 %t119, %FunctionSignature %t118, %FunctionSignature zeroinitializer
  %t121 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t122 = bitcast [88 x i8]* %t121 to i8*
  %t123 = bitcast i8* %t122 to %FunctionSignature*
  %t124 = load %FunctionSignature, %FunctionSignature* %t123
  %t125 = icmp eq i32 %t114, 5
  %t126 = select i1 %t125, %FunctionSignature %t124, %FunctionSignature %t120
  %t127 = getelementptr inbounds %Statement, %Statement* %t112, i32 0, i32 1
  %t128 = bitcast [88 x i8]* %t127 to i8*
  %t129 = bitcast i8* %t128 to %FunctionSignature*
  %t130 = load %FunctionSignature, %FunctionSignature* %t129
  %t131 = icmp eq i32 %t114, 7
  %t132 = select i1 %t131, %FunctionSignature %t130, %FunctionSignature %t126
  %t133 = extractvalue %FunctionSignature %t132, 0
  %t134 = call { i8**, i64 }* @append_unique({ i8**, i64 }* %t111, i8* %t133)
  store { i8**, i64 }* %t134, { i8**, i64 }** %l0
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t136 = phi { i8**, i64 }* [ %t135, %then6 ], [ %t108, %merge5 ]
  store { i8**, i64 }* %t136, { i8**, i64 }** %l0
  %t137 = load %Statement*, %Statement** %l2
  %t138 = getelementptr inbounds %Statement, %Statement* %t137, i32 0, i32 0
  %t139 = load i32, i32* %t138
  %t140 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t141 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t139, 0
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t139, 1
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t139, 2
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t139, 3
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t139, 4
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t139, 5
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t139, 6
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %t162 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t139, 7
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t139, 8
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %t168 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t169 = icmp eq i32 %t139, 9
  %t170 = select i1 %t169, i8* %t168, i8* %t167
  %t171 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t172 = icmp eq i32 %t139, 10
  %t173 = select i1 %t172, i8* %t171, i8* %t170
  %t174 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t175 = icmp eq i32 %t139, 11
  %t176 = select i1 %t175, i8* %t174, i8* %t173
  %t177 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t178 = icmp eq i32 %t139, 12
  %t179 = select i1 %t178, i8* %t177, i8* %t176
  %t180 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t181 = icmp eq i32 %t139, 13
  %t182 = select i1 %t181, i8* %t180, i8* %t179
  %t183 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t184 = icmp eq i32 %t139, 14
  %t185 = select i1 %t184, i8* %t183, i8* %t182
  %t186 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t187 = icmp eq i32 %t139, 15
  %t188 = select i1 %t187, i8* %t186, i8* %t185
  %t189 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t190 = icmp eq i32 %t139, 16
  %t191 = select i1 %t190, i8* %t189, i8* %t188
  %t192 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t193 = icmp eq i32 %t139, 17
  %t194 = select i1 %t193, i8* %t192, i8* %t191
  %t195 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t196 = icmp eq i32 %t139, 18
  %t197 = select i1 %t196, i8* %t195, i8* %t194
  %t198 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t199 = icmp eq i32 %t139, 19
  %t200 = select i1 %t199, i8* %t198, i8* %t197
  %t201 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t202 = icmp eq i32 %t139, 20
  %t203 = select i1 %t202, i8* %t201, i8* %t200
  %t204 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t205 = icmp eq i32 %t139, 21
  %t206 = select i1 %t205, i8* %t204, i8* %t203
  %t207 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t208 = icmp eq i32 %t139, 22
  %t209 = select i1 %t208, i8* %t207, i8* %t206
  %s210 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h889179835, i32 0, i32 0
  %t211 = call i1 @strings_equal(i8* %t209, i8* %s210)
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t213 = load double, double* %l1
  %t214 = load %Statement*, %Statement** %l2
  br i1 %t211, label %then8, label %merge9
then8:
  %t215 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s216 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h500836810, i32 0, i32 0
  %t217 = load %Statement*, %Statement** %l2
  %t218 = getelementptr inbounds %Statement, %Statement* %t217, i32 0, i32 0
  %t219 = load i32, i32* %t218
  %t220 = getelementptr inbounds %Statement, %Statement* %t217, i32 0, i32 1
  %t221 = bitcast [48 x i8]* %t220 to i8*
  %t222 = bitcast i8* %t221 to i8**
  %t223 = load i8*, i8** %t222
  %t224 = icmp eq i32 %t219, 2
  %t225 = select i1 %t224, i8* %t223, i8* null
  %t226 = getelementptr inbounds %Statement, %Statement* %t217, i32 0, i32 1
  %t227 = bitcast [48 x i8]* %t226 to i8*
  %t228 = bitcast i8* %t227 to i8**
  %t229 = load i8*, i8** %t228
  %t230 = icmp eq i32 %t219, 3
  %t231 = select i1 %t230, i8* %t229, i8* %t225
  %t232 = getelementptr inbounds %Statement, %Statement* %t217, i32 0, i32 1
  %t233 = bitcast [56 x i8]* %t232 to i8*
  %t234 = bitcast i8* %t233 to i8**
  %t235 = load i8*, i8** %t234
  %t236 = icmp eq i32 %t219, 6
  %t237 = select i1 %t236, i8* %t235, i8* %t231
  %t238 = getelementptr inbounds %Statement, %Statement* %t217, i32 0, i32 1
  %t239 = bitcast [56 x i8]* %t238 to i8*
  %t240 = bitcast i8* %t239 to i8**
  %t241 = load i8*, i8** %t240
  %t242 = icmp eq i32 %t219, 8
  %t243 = select i1 %t242, i8* %t241, i8* %t237
  %t244 = getelementptr inbounds %Statement, %Statement* %t217, i32 0, i32 1
  %t245 = bitcast [40 x i8]* %t244 to i8*
  %t246 = bitcast i8* %t245 to i8**
  %t247 = load i8*, i8** %t246
  %t248 = icmp eq i32 %t219, 9
  %t249 = select i1 %t248, i8* %t247, i8* %t243
  %t250 = getelementptr inbounds %Statement, %Statement* %t217, i32 0, i32 1
  %t251 = bitcast [40 x i8]* %t250 to i8*
  %t252 = bitcast i8* %t251 to i8**
  %t253 = load i8*, i8** %t252
  %t254 = icmp eq i32 %t219, 10
  %t255 = select i1 %t254, i8* %t253, i8* %t249
  %t256 = getelementptr inbounds %Statement, %Statement* %t217, i32 0, i32 1
  %t257 = bitcast [40 x i8]* %t256 to i8*
  %t258 = bitcast i8* %t257 to i8**
  %t259 = load i8*, i8** %t258
  %t260 = icmp eq i32 %t219, 11
  %t261 = select i1 %t260, i8* %t259, i8* %t255
  %t262 = call i8* @sailfin_runtime_string_concat(i8* %s216, i8* %t261)
  %t263 = call { i8**, i64 }* @append_unique({ i8**, i64 }* %t215, i8* %t262)
  store { i8**, i64 }* %t263, { i8**, i64 }** %l0
  %t264 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t265 = phi { i8**, i64 }* [ %t264, %then8 ], [ %t212, %merge7 ]
  store { i8**, i64 }* %t265, { i8**, i64 }** %l0
  %t266 = load double, double* %l1
  %t267 = sitofp i64 1 to double
  %t268 = fadd double %t266, %t267
  store double %t268, double* %l1
  br label %loop.latch2
loop.latch2:
  %t269 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t270 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t274 = load double, double* %l1
  %t275 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t275
}

define double @count_exported_symbols(%Program %program) {
block.entry:
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
  %t726 = phi double [ %t2, %block.entry ], [ %t724, %loop.latch2 ]
  %t727 = phi double [ %t3, %block.entry ], [ %t725, %loop.latch2 ]
  store double %t726, double* %l0
  store double %t727, double* %l1
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
  %t14 = call double @llvm.round.f64(double %t13)
  %t15 = fptosi double %t14 to i64
  %t16 = load { %Statement**, i64 }, { %Statement**, i64 }* %t12
  %t17 = extractvalue { %Statement**, i64 } %t16, 0
  %t18 = extractvalue { %Statement**, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t15, i64 %t18)
  %t20 = getelementptr %Statement*, %Statement** %t17, i64 %t15
  %t21 = load %Statement*, %Statement** %t20
  store %Statement* %t21, %Statement** %l2
  %t23 = load %Statement*, %Statement** %l2
  %t24 = getelementptr inbounds %Statement, %Statement* %t23, i32 0, i32 0
  %t25 = load i32, i32* %t24
  %t26 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t27 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t28 = icmp eq i32 %t25, 0
  %t29 = select i1 %t28, i8* %t27, i8* %t26
  %t30 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t31 = icmp eq i32 %t25, 1
  %t32 = select i1 %t31, i8* %t30, i8* %t29
  %t33 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t34 = icmp eq i32 %t25, 2
  %t35 = select i1 %t34, i8* %t33, i8* %t32
  %t36 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t37 = icmp eq i32 %t25, 3
  %t38 = select i1 %t37, i8* %t36, i8* %t35
  %t39 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t40 = icmp eq i32 %t25, 4
  %t41 = select i1 %t40, i8* %t39, i8* %t38
  %t42 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t43 = icmp eq i32 %t25, 5
  %t44 = select i1 %t43, i8* %t42, i8* %t41
  %t45 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t46 = icmp eq i32 %t25, 6
  %t47 = select i1 %t46, i8* %t45, i8* %t44
  %t48 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t49 = icmp eq i32 %t25, 7
  %t50 = select i1 %t49, i8* %t48, i8* %t47
  %t51 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t52 = icmp eq i32 %t25, 8
  %t53 = select i1 %t52, i8* %t51, i8* %t50
  %t54 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t55 = icmp eq i32 %t25, 9
  %t56 = select i1 %t55, i8* %t54, i8* %t53
  %t57 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t58 = icmp eq i32 %t25, 10
  %t59 = select i1 %t58, i8* %t57, i8* %t56
  %t60 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t61 = icmp eq i32 %t25, 11
  %t62 = select i1 %t61, i8* %t60, i8* %t59
  %t63 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t25, 12
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t25, 13
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t25, 14
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t25, 15
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t25, 16
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t25, 17
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %t81 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t25, 18
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t25, 19
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %t87 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t88 = icmp eq i32 %t25, 20
  %t89 = select i1 %t88, i8* %t87, i8* %t86
  %t90 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t91 = icmp eq i32 %t25, 21
  %t92 = select i1 %t91, i8* %t90, i8* %t89
  %t93 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t25, 22
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %s96 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h486335986, i32 0, i32 0
  %t97 = call i1 @strings_equal(i8* %t95, i8* %s96)
  br label %logical_or_entry_22

logical_or_entry_22:
  br i1 %t97, label %logical_or_merge_22, label %logical_or_right_22

logical_or_right_22:
  %t99 = load %Statement*, %Statement** %l2
  %t100 = getelementptr inbounds %Statement, %Statement* %t99, i32 0, i32 0
  %t101 = load i32, i32* %t100
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
  %s172 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1842783069, i32 0, i32 0
  %t173 = call i1 @strings_equal(i8* %t171, i8* %s172)
  br label %logical_or_entry_98

logical_or_entry_98:
  br i1 %t173, label %logical_or_merge_98, label %logical_or_right_98

logical_or_right_98:
  %t175 = load %Statement*, %Statement** %l2
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
  %s248 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h579804543, i32 0, i32 0
  %t249 = call i1 @strings_equal(i8* %t247, i8* %s248)
  br label %logical_or_entry_174

logical_or_entry_174:
  br i1 %t249, label %logical_or_merge_174, label %logical_or_right_174

logical_or_right_174:
  %t251 = load %Statement*, %Statement** %l2
  %t252 = getelementptr inbounds %Statement, %Statement* %t251, i32 0, i32 0
  %t253 = load i32, i32* %t252
  %t254 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t255 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t256 = icmp eq i32 %t253, 0
  %t257 = select i1 %t256, i8* %t255, i8* %t254
  %t258 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t259 = icmp eq i32 %t253, 1
  %t260 = select i1 %t259, i8* %t258, i8* %t257
  %t261 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t262 = icmp eq i32 %t253, 2
  %t263 = select i1 %t262, i8* %t261, i8* %t260
  %t264 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t265 = icmp eq i32 %t253, 3
  %t266 = select i1 %t265, i8* %t264, i8* %t263
  %t267 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t268 = icmp eq i32 %t253, 4
  %t269 = select i1 %t268, i8* %t267, i8* %t266
  %t270 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t271 = icmp eq i32 %t253, 5
  %t272 = select i1 %t271, i8* %t270, i8* %t269
  %t273 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t274 = icmp eq i32 %t253, 6
  %t275 = select i1 %t274, i8* %t273, i8* %t272
  %t276 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t277 = icmp eq i32 %t253, 7
  %t278 = select i1 %t277, i8* %t276, i8* %t275
  %t279 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t280 = icmp eq i32 %t253, 8
  %t281 = select i1 %t280, i8* %t279, i8* %t278
  %t282 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t283 = icmp eq i32 %t253, 9
  %t284 = select i1 %t283, i8* %t282, i8* %t281
  %t285 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t286 = icmp eq i32 %t253, 10
  %t287 = select i1 %t286, i8* %t285, i8* %t284
  %t288 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t289 = icmp eq i32 %t253, 11
  %t290 = select i1 %t289, i8* %t288, i8* %t287
  %t291 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t292 = icmp eq i32 %t253, 12
  %t293 = select i1 %t292, i8* %t291, i8* %t290
  %t294 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t295 = icmp eq i32 %t253, 13
  %t296 = select i1 %t295, i8* %t294, i8* %t293
  %t297 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t298 = icmp eq i32 %t253, 14
  %t299 = select i1 %t298, i8* %t297, i8* %t296
  %t300 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t301 = icmp eq i32 %t253, 15
  %t302 = select i1 %t301, i8* %t300, i8* %t299
  %t303 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t304 = icmp eq i32 %t253, 16
  %t305 = select i1 %t304, i8* %t303, i8* %t302
  %t306 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t307 = icmp eq i32 %t253, 17
  %t308 = select i1 %t307, i8* %t306, i8* %t305
  %t309 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t310 = icmp eq i32 %t253, 18
  %t311 = select i1 %t310, i8* %t309, i8* %t308
  %t312 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t313 = icmp eq i32 %t253, 19
  %t314 = select i1 %t313, i8* %t312, i8* %t311
  %t315 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t316 = icmp eq i32 %t253, 20
  %t317 = select i1 %t316, i8* %t315, i8* %t314
  %t318 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t319 = icmp eq i32 %t253, 21
  %t320 = select i1 %t319, i8* %t318, i8* %t317
  %t321 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t322 = icmp eq i32 %t253, 22
  %t323 = select i1 %t322, i8* %t321, i8* %t320
  %s324 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h479148896, i32 0, i32 0
  %t325 = call i1 @strings_equal(i8* %t323, i8* %s324)
  br label %logical_or_entry_250

logical_or_entry_250:
  br i1 %t325, label %logical_or_merge_250, label %logical_or_right_250

logical_or_right_250:
  %t327 = load %Statement*, %Statement** %l2
  %t328 = getelementptr inbounds %Statement, %Statement* %t327, i32 0, i32 0
  %t329 = load i32, i32* %t328
  %t330 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t331 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t332 = icmp eq i32 %t329, 0
  %t333 = select i1 %t332, i8* %t331, i8* %t330
  %t334 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t335 = icmp eq i32 %t329, 1
  %t336 = select i1 %t335, i8* %t334, i8* %t333
  %t337 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t338 = icmp eq i32 %t329, 2
  %t339 = select i1 %t338, i8* %t337, i8* %t336
  %t340 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t341 = icmp eq i32 %t329, 3
  %t342 = select i1 %t341, i8* %t340, i8* %t339
  %t343 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t344 = icmp eq i32 %t329, 4
  %t345 = select i1 %t344, i8* %t343, i8* %t342
  %t346 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t347 = icmp eq i32 %t329, 5
  %t348 = select i1 %t347, i8* %t346, i8* %t345
  %t349 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t350 = icmp eq i32 %t329, 6
  %t351 = select i1 %t350, i8* %t349, i8* %t348
  %t352 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t353 = icmp eq i32 %t329, 7
  %t354 = select i1 %t353, i8* %t352, i8* %t351
  %t355 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t356 = icmp eq i32 %t329, 8
  %t357 = select i1 %t356, i8* %t355, i8* %t354
  %t358 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t359 = icmp eq i32 %t329, 9
  %t360 = select i1 %t359, i8* %t358, i8* %t357
  %t361 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t362 = icmp eq i32 %t329, 10
  %t363 = select i1 %t362, i8* %t361, i8* %t360
  %t364 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t365 = icmp eq i32 %t329, 11
  %t366 = select i1 %t365, i8* %t364, i8* %t363
  %t367 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t368 = icmp eq i32 %t329, 12
  %t369 = select i1 %t368, i8* %t367, i8* %t366
  %t370 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t371 = icmp eq i32 %t329, 13
  %t372 = select i1 %t371, i8* %t370, i8* %t369
  %t373 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t374 = icmp eq i32 %t329, 14
  %t375 = select i1 %t374, i8* %t373, i8* %t372
  %t376 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t377 = icmp eq i32 %t329, 15
  %t378 = select i1 %t377, i8* %t376, i8* %t375
  %t379 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t380 = icmp eq i32 %t329, 16
  %t381 = select i1 %t380, i8* %t379, i8* %t378
  %t382 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t383 = icmp eq i32 %t329, 17
  %t384 = select i1 %t383, i8* %t382, i8* %t381
  %t385 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t386 = icmp eq i32 %t329, 18
  %t387 = select i1 %t386, i8* %t385, i8* %t384
  %t388 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t389 = icmp eq i32 %t329, 19
  %t390 = select i1 %t389, i8* %t388, i8* %t387
  %t391 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t392 = icmp eq i32 %t329, 20
  %t393 = select i1 %t392, i8* %t391, i8* %t390
  %t394 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t395 = icmp eq i32 %t329, 21
  %t396 = select i1 %t395, i8* %t394, i8* %t393
  %t397 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t398 = icmp eq i32 %t329, 22
  %t399 = select i1 %t398, i8* %t397, i8* %t396
  %s400 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h571715647, i32 0, i32 0
  %t401 = call i1 @strings_equal(i8* %t399, i8* %s400)
  br label %logical_or_entry_326

logical_or_entry_326:
  br i1 %t401, label %logical_or_merge_326, label %logical_or_right_326

logical_or_right_326:
  %t403 = load %Statement*, %Statement** %l2
  %t404 = getelementptr inbounds %Statement, %Statement* %t403, i32 0, i32 0
  %t405 = load i32, i32* %t404
  %t406 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t407 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t408 = icmp eq i32 %t405, 0
  %t409 = select i1 %t408, i8* %t407, i8* %t406
  %t410 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t411 = icmp eq i32 %t405, 1
  %t412 = select i1 %t411, i8* %t410, i8* %t409
  %t413 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t414 = icmp eq i32 %t405, 2
  %t415 = select i1 %t414, i8* %t413, i8* %t412
  %t416 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t417 = icmp eq i32 %t405, 3
  %t418 = select i1 %t417, i8* %t416, i8* %t415
  %t419 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t420 = icmp eq i32 %t405, 4
  %t421 = select i1 %t420, i8* %t419, i8* %t418
  %t422 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t423 = icmp eq i32 %t405, 5
  %t424 = select i1 %t423, i8* %t422, i8* %t421
  %t425 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t426 = icmp eq i32 %t405, 6
  %t427 = select i1 %t426, i8* %t425, i8* %t424
  %t428 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t429 = icmp eq i32 %t405, 7
  %t430 = select i1 %t429, i8* %t428, i8* %t427
  %t431 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t432 = icmp eq i32 %t405, 8
  %t433 = select i1 %t432, i8* %t431, i8* %t430
  %t434 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t435 = icmp eq i32 %t405, 9
  %t436 = select i1 %t435, i8* %t434, i8* %t433
  %t437 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t438 = icmp eq i32 %t405, 10
  %t439 = select i1 %t438, i8* %t437, i8* %t436
  %t440 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t441 = icmp eq i32 %t405, 11
  %t442 = select i1 %t441, i8* %t440, i8* %t439
  %t443 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t444 = icmp eq i32 %t405, 12
  %t445 = select i1 %t444, i8* %t443, i8* %t442
  %t446 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t447 = icmp eq i32 %t405, 13
  %t448 = select i1 %t447, i8* %t446, i8* %t445
  %t449 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t450 = icmp eq i32 %t405, 14
  %t451 = select i1 %t450, i8* %t449, i8* %t448
  %t452 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t453 = icmp eq i32 %t405, 15
  %t454 = select i1 %t453, i8* %t452, i8* %t451
  %t455 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t456 = icmp eq i32 %t405, 16
  %t457 = select i1 %t456, i8* %t455, i8* %t454
  %t458 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t459 = icmp eq i32 %t405, 17
  %t460 = select i1 %t459, i8* %t458, i8* %t457
  %t461 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t462 = icmp eq i32 %t405, 18
  %t463 = select i1 %t462, i8* %t461, i8* %t460
  %t464 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t465 = icmp eq i32 %t405, 19
  %t466 = select i1 %t465, i8* %t464, i8* %t463
  %t467 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t468 = icmp eq i32 %t405, 20
  %t469 = select i1 %t468, i8* %t467, i8* %t466
  %t470 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t471 = icmp eq i32 %t405, 21
  %t472 = select i1 %t471, i8* %t470, i8* %t469
  %t473 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t474 = icmp eq i32 %t405, 22
  %t475 = select i1 %t474, i8* %t473, i8* %t472
  %s476 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h2043328844, i32 0, i32 0
  %t477 = call i1 @strings_equal(i8* %t475, i8* %s476)
  br label %logical_or_entry_402

logical_or_entry_402:
  br i1 %t477, label %logical_or_merge_402, label %logical_or_right_402

logical_or_right_402:
  %t479 = load %Statement*, %Statement** %l2
  %t480 = getelementptr inbounds %Statement, %Statement* %t479, i32 0, i32 0
  %t481 = load i32, i32* %t480
  %t482 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t483 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t484 = icmp eq i32 %t481, 0
  %t485 = select i1 %t484, i8* %t483, i8* %t482
  %t486 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t487 = icmp eq i32 %t481, 1
  %t488 = select i1 %t487, i8* %t486, i8* %t485
  %t489 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t490 = icmp eq i32 %t481, 2
  %t491 = select i1 %t490, i8* %t489, i8* %t488
  %t492 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t493 = icmp eq i32 %t481, 3
  %t494 = select i1 %t493, i8* %t492, i8* %t491
  %t495 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t496 = icmp eq i32 %t481, 4
  %t497 = select i1 %t496, i8* %t495, i8* %t494
  %t498 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t499 = icmp eq i32 %t481, 5
  %t500 = select i1 %t499, i8* %t498, i8* %t497
  %t501 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t502 = icmp eq i32 %t481, 6
  %t503 = select i1 %t502, i8* %t501, i8* %t500
  %t504 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t505 = icmp eq i32 %t481, 7
  %t506 = select i1 %t505, i8* %t504, i8* %t503
  %t507 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t508 = icmp eq i32 %t481, 8
  %t509 = select i1 %t508, i8* %t507, i8* %t506
  %t510 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t511 = icmp eq i32 %t481, 9
  %t512 = select i1 %t511, i8* %t510, i8* %t509
  %t513 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t514 = icmp eq i32 %t481, 10
  %t515 = select i1 %t514, i8* %t513, i8* %t512
  %t516 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t517 = icmp eq i32 %t481, 11
  %t518 = select i1 %t517, i8* %t516, i8* %t515
  %t519 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t520 = icmp eq i32 %t481, 12
  %t521 = select i1 %t520, i8* %t519, i8* %t518
  %t522 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t523 = icmp eq i32 %t481, 13
  %t524 = select i1 %t523, i8* %t522, i8* %t521
  %t525 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t526 = icmp eq i32 %t481, 14
  %t527 = select i1 %t526, i8* %t525, i8* %t524
  %t528 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t529 = icmp eq i32 %t481, 15
  %t530 = select i1 %t529, i8* %t528, i8* %t527
  %t531 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t532 = icmp eq i32 %t481, 16
  %t533 = select i1 %t532, i8* %t531, i8* %t530
  %t534 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t535 = icmp eq i32 %t481, 17
  %t536 = select i1 %t535, i8* %t534, i8* %t533
  %t537 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t538 = icmp eq i32 %t481, 18
  %t539 = select i1 %t538, i8* %t537, i8* %t536
  %t540 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t541 = icmp eq i32 %t481, 19
  %t542 = select i1 %t541, i8* %t540, i8* %t539
  %t543 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t544 = icmp eq i32 %t481, 20
  %t545 = select i1 %t544, i8* %t543, i8* %t542
  %t546 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t547 = icmp eq i32 %t481, 21
  %t548 = select i1 %t547, i8* %t546, i8* %t545
  %t549 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t550 = icmp eq i32 %t481, 22
  %t551 = select i1 %t550, i8* %t549, i8* %t548
  %s552 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h889179835, i32 0, i32 0
  %t553 = call i1 @strings_equal(i8* %t551, i8* %s552)
  br label %logical_or_entry_478

logical_or_entry_478:
  br i1 %t553, label %logical_or_merge_478, label %logical_or_right_478

logical_or_right_478:
  %t555 = load %Statement*, %Statement** %l2
  %t556 = getelementptr inbounds %Statement, %Statement* %t555, i32 0, i32 0
  %t557 = load i32, i32* %t556
  %t558 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t559 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t560 = icmp eq i32 %t557, 0
  %t561 = select i1 %t560, i8* %t559, i8* %t558
  %t562 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t563 = icmp eq i32 %t557, 1
  %t564 = select i1 %t563, i8* %t562, i8* %t561
  %t565 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t566 = icmp eq i32 %t557, 2
  %t567 = select i1 %t566, i8* %t565, i8* %t564
  %t568 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t569 = icmp eq i32 %t557, 3
  %t570 = select i1 %t569, i8* %t568, i8* %t567
  %t571 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t572 = icmp eq i32 %t557, 4
  %t573 = select i1 %t572, i8* %t571, i8* %t570
  %t574 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t575 = icmp eq i32 %t557, 5
  %t576 = select i1 %t575, i8* %t574, i8* %t573
  %t577 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t578 = icmp eq i32 %t557, 6
  %t579 = select i1 %t578, i8* %t577, i8* %t576
  %t580 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t581 = icmp eq i32 %t557, 7
  %t582 = select i1 %t581, i8* %t580, i8* %t579
  %t583 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t584 = icmp eq i32 %t557, 8
  %t585 = select i1 %t584, i8* %t583, i8* %t582
  %t586 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t587 = icmp eq i32 %t557, 9
  %t588 = select i1 %t587, i8* %t586, i8* %t585
  %t589 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t590 = icmp eq i32 %t557, 10
  %t591 = select i1 %t590, i8* %t589, i8* %t588
  %t592 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t593 = icmp eq i32 %t557, 11
  %t594 = select i1 %t593, i8* %t592, i8* %t591
  %t595 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t596 = icmp eq i32 %t557, 12
  %t597 = select i1 %t596, i8* %t595, i8* %t594
  %t598 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t599 = icmp eq i32 %t557, 13
  %t600 = select i1 %t599, i8* %t598, i8* %t597
  %t601 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t602 = icmp eq i32 %t557, 14
  %t603 = select i1 %t602, i8* %t601, i8* %t600
  %t604 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t605 = icmp eq i32 %t557, 15
  %t606 = select i1 %t605, i8* %t604, i8* %t603
  %t607 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t608 = icmp eq i32 %t557, 16
  %t609 = select i1 %t608, i8* %t607, i8* %t606
  %t610 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t611 = icmp eq i32 %t557, 17
  %t612 = select i1 %t611, i8* %t610, i8* %t609
  %t613 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t614 = icmp eq i32 %t557, 18
  %t615 = select i1 %t614, i8* %t613, i8* %t612
  %t616 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t617 = icmp eq i32 %t557, 19
  %t618 = select i1 %t617, i8* %t616, i8* %t615
  %t619 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t620 = icmp eq i32 %t557, 20
  %t621 = select i1 %t620, i8* %t619, i8* %t618
  %t622 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t623 = icmp eq i32 %t557, 21
  %t624 = select i1 %t623, i8* %t622, i8* %t621
  %t625 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t626 = icmp eq i32 %t557, 22
  %t627 = select i1 %t626, i8* %t625, i8* %t624
  %s628 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1496093543, i32 0, i32 0
  %t629 = call i1 @strings_equal(i8* %t627, i8* %s628)
  br label %logical_or_entry_554

logical_or_entry_554:
  br i1 %t629, label %logical_or_merge_554, label %logical_or_right_554

logical_or_right_554:
  %t630 = load %Statement*, %Statement** %l2
  %t631 = getelementptr inbounds %Statement, %Statement* %t630, i32 0, i32 0
  %t632 = load i32, i32* %t631
  %t633 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t634 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t635 = icmp eq i32 %t632, 0
  %t636 = select i1 %t635, i8* %t634, i8* %t633
  %t637 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t638 = icmp eq i32 %t632, 1
  %t639 = select i1 %t638, i8* %t637, i8* %t636
  %t640 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t641 = icmp eq i32 %t632, 2
  %t642 = select i1 %t641, i8* %t640, i8* %t639
  %t643 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t644 = icmp eq i32 %t632, 3
  %t645 = select i1 %t644, i8* %t643, i8* %t642
  %t646 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t647 = icmp eq i32 %t632, 4
  %t648 = select i1 %t647, i8* %t646, i8* %t645
  %t649 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t650 = icmp eq i32 %t632, 5
  %t651 = select i1 %t650, i8* %t649, i8* %t648
  %t652 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t653 = icmp eq i32 %t632, 6
  %t654 = select i1 %t653, i8* %t652, i8* %t651
  %t655 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t656 = icmp eq i32 %t632, 7
  %t657 = select i1 %t656, i8* %t655, i8* %t654
  %t658 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t659 = icmp eq i32 %t632, 8
  %t660 = select i1 %t659, i8* %t658, i8* %t657
  %t661 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t662 = icmp eq i32 %t632, 9
  %t663 = select i1 %t662, i8* %t661, i8* %t660
  %t664 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t665 = icmp eq i32 %t632, 10
  %t666 = select i1 %t665, i8* %t664, i8* %t663
  %t667 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t668 = icmp eq i32 %t632, 11
  %t669 = select i1 %t668, i8* %t667, i8* %t666
  %t670 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t671 = icmp eq i32 %t632, 12
  %t672 = select i1 %t671, i8* %t670, i8* %t669
  %t673 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t674 = icmp eq i32 %t632, 13
  %t675 = select i1 %t674, i8* %t673, i8* %t672
  %t676 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t677 = icmp eq i32 %t632, 14
  %t678 = select i1 %t677, i8* %t676, i8* %t675
  %t679 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t680 = icmp eq i32 %t632, 15
  %t681 = select i1 %t680, i8* %t679, i8* %t678
  %t682 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t683 = icmp eq i32 %t632, 16
  %t684 = select i1 %t683, i8* %t682, i8* %t681
  %t685 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t686 = icmp eq i32 %t632, 17
  %t687 = select i1 %t686, i8* %t685, i8* %t684
  %t688 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t689 = icmp eq i32 %t632, 18
  %t690 = select i1 %t689, i8* %t688, i8* %t687
  %t691 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t692 = icmp eq i32 %t632, 19
  %t693 = select i1 %t692, i8* %t691, i8* %t690
  %t694 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t695 = icmp eq i32 %t632, 20
  %t696 = select i1 %t695, i8* %t694, i8* %t693
  %t697 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t698 = icmp eq i32 %t632, 21
  %t699 = select i1 %t698, i8* %t697, i8* %t696
  %t700 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t701 = icmp eq i32 %t632, 22
  %t702 = select i1 %t701, i8* %t700, i8* %t699
  %s703 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h666604742, i32 0, i32 0
  %t704 = call i1 @strings_equal(i8* %t702, i8* %s703)
  br label %logical_or_right_end_554

logical_or_right_end_554:
  br label %logical_or_merge_554

logical_or_merge_554:
  %t705 = phi i1 [ true, %logical_or_entry_554 ], [ %t704, %logical_or_right_end_554 ]
  br label %logical_or_right_end_478

logical_or_right_end_478:
  br label %logical_or_merge_478

logical_or_merge_478:
  %t706 = phi i1 [ true, %logical_or_entry_478 ], [ %t705, %logical_or_right_end_478 ]
  br label %logical_or_right_end_402

logical_or_right_end_402:
  br label %logical_or_merge_402

logical_or_merge_402:
  %t707 = phi i1 [ true, %logical_or_entry_402 ], [ %t706, %logical_or_right_end_402 ]
  br label %logical_or_right_end_326

logical_or_right_end_326:
  br label %logical_or_merge_326

logical_or_merge_326:
  %t708 = phi i1 [ true, %logical_or_entry_326 ], [ %t707, %logical_or_right_end_326 ]
  br label %logical_or_right_end_250

logical_or_right_end_250:
  br label %logical_or_merge_250

logical_or_merge_250:
  %t709 = phi i1 [ true, %logical_or_entry_250 ], [ %t708, %logical_or_right_end_250 ]
  br label %logical_or_right_end_174

logical_or_right_end_174:
  br label %logical_or_merge_174

logical_or_merge_174:
  %t710 = phi i1 [ true, %logical_or_entry_174 ], [ %t709, %logical_or_right_end_174 ]
  br label %logical_or_right_end_98

logical_or_right_end_98:
  br label %logical_or_merge_98

logical_or_merge_98:
  %t711 = phi i1 [ true, %logical_or_entry_98 ], [ %t710, %logical_or_right_end_98 ]
  br label %logical_or_right_end_22

logical_or_right_end_22:
  br label %logical_or_merge_22

logical_or_merge_22:
  %t712 = phi i1 [ true, %logical_or_entry_22 ], [ %t711, %logical_or_right_end_22 ]
  %t713 = load double, double* %l0
  %t714 = load double, double* %l1
  %t715 = load %Statement*, %Statement** %l2
  br i1 %t712, label %then6, label %merge7
then6:
  %t716 = load double, double* %l0
  %t717 = sitofp i64 1 to double
  %t718 = fadd double %t716, %t717
  store double %t718, double* %l0
  %t719 = load double, double* %l0
  br label %merge7
merge7:
  %t720 = phi double [ %t719, %then6 ], [ %t713, %logical_or_merge_22 ]
  store double %t720, double* %l0
  %t721 = load double, double* %l1
  %t722 = sitofp i64 1 to double
  %t723 = fadd double %t721, %t722
  store double %t723, double* %l1
  br label %loop.latch2
loop.latch2:
  %t724 = load double, double* %l0
  %t725 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t728 = load double, double* %l0
  %t729 = load double, double* %l1
  %t730 = load double, double* %l0
  ret double %t730
}

define { i8**, i64 }* @append_unique({ i8**, i64 }* %values, i8* %value) {
block.entry:
  %t0 = call i1 @contains_string({ i8**, i64 }* %values, i8* %value)
  br i1 %t0, label %then0, label %merge1
then0:
  ret { i8**, i64 }* %values
merge1:
  %t1 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %values, i8* %value)
  ret { i8**, i64 }* %t1
}

define i1 @contains_string({ i8**, i64 }* %values, i8* %target) {
block.entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t23 = phi double [ %t1, %block.entry ], [ %t22, %loop.latch2 ]
  store double %t23, double* %l0
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
  %t9 = call double @llvm.round.f64(double %t8)
  %t10 = fptosi double %t9 to i64
  %t11 = load { i8**, i64 }, { i8**, i64 }* %values
  %t12 = extractvalue { i8**, i64 } %t11, 0
  %t13 = extractvalue { i8**, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t10, i64 %t13)
  %t15 = getelementptr i8*, i8** %t12, i64 %t10
  %t16 = load i8*, i8** %t15
  %t17 = call i1 @strings_equal(i8* %t16, i8* %target)
  %t18 = load double, double* %l0
  br i1 %t17, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t19 = load double, double* %l0
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l0
  br label %loop.latch2
loop.latch2:
  %t22 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t24 = load double, double* %l0
  ret i1 0
}

define %NativeState @state_new(%LayoutContext %context) {
block.entry:
  %t0 = call %TextBuilder @builder_new()
  %t1 = insertvalue %NativeState undef, %TextBuilder %t0, 0
  %t2 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t3 = ptrtoint [0 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t9 = ptrtoint { i8**, i64 }* %t8 to i64
  %t10 = call i8* @malloc(i64 %t9)
  %t11 = bitcast i8* %t10 to { i8**, i64 }*
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t11, i32 0, i32 0
  store i8** %t7, i8*** %t12
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t11, i32 0, i32 1
  store i64 0, i64* %t13
  %t14 = insertvalue %NativeState %t1, { i8**, i64 }* %t11, 1
  %t15 = insertvalue %NativeState %t14, %LayoutContext %context, 2
  ret %NativeState %t15
}

define %NativeState @state_emit_line(%NativeState %state, i8* %line) {
block.entry:
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
block.entry:
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
block.entry:
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
block.entry:
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
block.entry:
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
block.entry:
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
  %t30 = phi { i8**, i64 }* [ %t5, %merge1 ], [ %t28, %loop.latch4 ]
  %t31 = phi double [ %t6, %merge1 ], [ %t29, %loop.latch4 ]
  store { i8**, i64 }* %t30, { i8**, i64 }** %l0
  store double %t31, double* %l1
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
  %t16 = call double @llvm.round.f64(double %t15)
  %t17 = fptosi double %t16 to i64
  %t18 = load { i8**, i64 }, { i8**, i64 }* %entries
  %t19 = extractvalue { i8**, i64 } %t18, 0
  %t20 = extractvalue { i8**, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t17, i64 %t20)
  %t22 = getelementptr i8*, i8** %t19, i64 %t17
  %t23 = load i8*, i8** %t22
  %t24 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t14, i8* %t23)
  store { i8**, i64 }* %t24, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l1
  br label %loop.latch4
loop.latch4:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load double, double* %l1
  %t34 = extractvalue %NativeState %state, 0
  %t35 = insertvalue %NativeState undef, %TextBuilder %t34, 0
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = insertvalue %NativeState %t35, { i8**, i64 }* %t36, 1
  %t38 = extractvalue %NativeState %state, 2
  %t39 = insertvalue %NativeState %t37, %LayoutContext %t38, 2
  ret %NativeState %t39
}

define %NativeArtifact @generate_layout_manifest(%Program %program, %LayoutContext %context) {
block.entry:
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
  %t216 = phi %TextBuilder [ %t10, %block.entry ], [ %t214, %loop.latch2 ]
  %t217 = phi double [ %t11, %block.entry ], [ %t215, %loop.latch2 ]
  store %TextBuilder %t216, %TextBuilder* %l0
  store double %t217, double* %l1
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
  %t22 = call double @llvm.round.f64(double %t21)
  %t23 = fptosi double %t22 to i64
  %t24 = load { %Statement**, i64 }, { %Statement**, i64 }* %t20
  %t25 = extractvalue { %Statement**, i64 } %t24, 0
  %t26 = extractvalue { %Statement**, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t23, i64 %t26)
  %t28 = getelementptr %Statement*, %Statement** %t25, i64 %t23
  %t29 = load %Statement*, %Statement** %t28
  store %Statement* %t29, %Statement** %l2
  %t30 = load %Statement*, %Statement** %l2
  %t31 = getelementptr inbounds %Statement, %Statement* %t30, i32 0, i32 0
  %t32 = load i32, i32* %t31
  %t33 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t34 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t32, 0
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %t37 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t32, 1
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %t40 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t41 = icmp eq i32 %t32, 2
  %t42 = select i1 %t41, i8* %t40, i8* %t39
  %t43 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t44 = icmp eq i32 %t32, 3
  %t45 = select i1 %t44, i8* %t43, i8* %t42
  %t46 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t47 = icmp eq i32 %t32, 4
  %t48 = select i1 %t47, i8* %t46, i8* %t45
  %t49 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t50 = icmp eq i32 %t32, 5
  %t51 = select i1 %t50, i8* %t49, i8* %t48
  %t52 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t53 = icmp eq i32 %t32, 6
  %t54 = select i1 %t53, i8* %t52, i8* %t51
  %t55 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t32, 7
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t32, 8
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t32, 9
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t32, 10
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t32, 11
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t32, 12
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t32, 13
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %t76 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t32, 14
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %t79 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t32, 15
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t32, 16
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %t85 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t32, 17
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t32, 18
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t32, 19
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t32, 20
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t32, 21
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %t100 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t32, 22
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %s103 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1842783069, i32 0, i32 0
  %t104 = call i1 @strings_equal(i8* %t102, i8* %s103)
  %t105 = load %TextBuilder, %TextBuilder* %l0
  %t106 = load double, double* %l1
  %t107 = load %Statement*, %Statement** %l2
  br i1 %t104, label %then6, label %merge7
then6:
  %t108 = load %Statement*, %Statement** %l2
  %t109 = getelementptr inbounds %Statement, %Statement* %t108, i32 0, i32 0
  %t110 = load i32, i32* %t109
  %t111 = getelementptr inbounds %Statement, %Statement* %t108, i32 0, i32 1
  %t112 = bitcast [48 x i8]* %t111 to i8*
  %t113 = bitcast i8* %t112 to i8**
  %t114 = load i8*, i8** %t113
  %t115 = icmp eq i32 %t110, 2
  %t116 = select i1 %t115, i8* %t114, i8* null
  %t117 = getelementptr inbounds %Statement, %Statement* %t108, i32 0, i32 1
  %t118 = bitcast [48 x i8]* %t117 to i8*
  %t119 = bitcast i8* %t118 to i8**
  %t120 = load i8*, i8** %t119
  %t121 = icmp eq i32 %t110, 3
  %t122 = select i1 %t121, i8* %t120, i8* %t116
  %t123 = getelementptr inbounds %Statement, %Statement* %t108, i32 0, i32 1
  %t124 = bitcast [56 x i8]* %t123 to i8*
  %t125 = bitcast i8* %t124 to i8**
  %t126 = load i8*, i8** %t125
  %t127 = icmp eq i32 %t110, 6
  %t128 = select i1 %t127, i8* %t126, i8* %t122
  %t129 = getelementptr inbounds %Statement, %Statement* %t108, i32 0, i32 1
  %t130 = bitcast [56 x i8]* %t129 to i8*
  %t131 = bitcast i8* %t130 to i8**
  %t132 = load i8*, i8** %t131
  %t133 = icmp eq i32 %t110, 8
  %t134 = select i1 %t133, i8* %t132, i8* %t128
  %t135 = getelementptr inbounds %Statement, %Statement* %t108, i32 0, i32 1
  %t136 = bitcast [40 x i8]* %t135 to i8*
  %t137 = bitcast i8* %t136 to i8**
  %t138 = load i8*, i8** %t137
  %t139 = icmp eq i32 %t110, 9
  %t140 = select i1 %t139, i8* %t138, i8* %t134
  %t141 = getelementptr inbounds %Statement, %Statement* %t108, i32 0, i32 1
  %t142 = bitcast [40 x i8]* %t141 to i8*
  %t143 = bitcast i8* %t142 to i8**
  %t144 = load i8*, i8** %t143
  %t145 = icmp eq i32 %t110, 10
  %t146 = select i1 %t145, i8* %t144, i8* %t140
  %t147 = getelementptr inbounds %Statement, %Statement* %t108, i32 0, i32 1
  %t148 = bitcast [40 x i8]* %t147 to i8*
  %t149 = bitcast i8* %t148 to i8**
  %t150 = load i8*, i8** %t149
  %t151 = icmp eq i32 %t110, 11
  %t152 = select i1 %t151, i8* %t150, i8* %t146
  %t153 = load %Statement*, %Statement** %l2
  %t154 = getelementptr inbounds %Statement, %Statement* %t153, i32 0, i32 0
  %t155 = load i32, i32* %t154
  %t156 = getelementptr inbounds %Statement, %Statement* %t153, i32 0, i32 1
  %t157 = bitcast [56 x i8]* %t156 to i8*
  %t158 = getelementptr inbounds i8, i8* %t157, i64 32
  %t159 = bitcast i8* %t158 to { %FieldDeclaration**, i64 }**
  %t160 = load { %FieldDeclaration**, i64 }*, { %FieldDeclaration**, i64 }** %t159
  %t161 = icmp eq i32 %t155, 8
  %t162 = select i1 %t161, { %FieldDeclaration**, i64 }* %t160, { %FieldDeclaration**, i64 }* null
  %t163 = bitcast { %FieldDeclaration**, i64 }* %t162 to { %FieldDeclaration*, i64 }*
  %t164 = call %LayoutEmitResult @compute_struct_layout_lines(%LayoutContext %context, i8* %t152, { %FieldDeclaration*, i64 }* %t163)
  store %LayoutEmitResult %t164, %LayoutEmitResult* %l3
  %t165 = sitofp i64 0 to double
  store double %t165, double* %l4
  %t166 = load %TextBuilder, %TextBuilder* %l0
  %t167 = load double, double* %l1
  %t168 = load %Statement*, %Statement** %l2
  %t169 = load %LayoutEmitResult, %LayoutEmitResult* %l3
  %t170 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t201 = phi %TextBuilder [ %t166, %then6 ], [ %t199, %loop.latch10 ]
  %t202 = phi double [ %t170, %then6 ], [ %t200, %loop.latch10 ]
  store %TextBuilder %t201, %TextBuilder* %l0
  store double %t202, double* %l4
  br label %loop.body9
loop.body9:
  %t171 = load double, double* %l4
  %t172 = load %LayoutEmitResult, %LayoutEmitResult* %l3
  %t173 = extractvalue %LayoutEmitResult %t172, 0
  %t174 = load { i8**, i64 }, { i8**, i64 }* %t173
  %t175 = extractvalue { i8**, i64 } %t174, 1
  %t176 = sitofp i64 %t175 to double
  %t177 = fcmp oge double %t171, %t176
  %t178 = load %TextBuilder, %TextBuilder* %l0
  %t179 = load double, double* %l1
  %t180 = load %Statement*, %Statement** %l2
  %t181 = load %LayoutEmitResult, %LayoutEmitResult* %l3
  %t182 = load double, double* %l4
  br i1 %t177, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t183 = load %TextBuilder, %TextBuilder* %l0
  %t184 = load %LayoutEmitResult, %LayoutEmitResult* %l3
  %t185 = extractvalue %LayoutEmitResult %t184, 0
  %t186 = load double, double* %l4
  %t187 = call double @llvm.round.f64(double %t186)
  %t188 = fptosi double %t187 to i64
  %t189 = load { i8**, i64 }, { i8**, i64 }* %t185
  %t190 = extractvalue { i8**, i64 } %t189, 0
  %t191 = extractvalue { i8**, i64 } %t189, 1
  %t192 = icmp uge i64 %t188, %t191
  ; bounds check: %t192 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t188, i64 %t191)
  %t193 = getelementptr i8*, i8** %t190, i64 %t188
  %t194 = load i8*, i8** %t193
  %t195 = call %TextBuilder @builder_emit_line(%TextBuilder %t183, i8* %t194)
  store %TextBuilder %t195, %TextBuilder* %l0
  %t196 = load double, double* %l4
  %t197 = sitofp i64 1 to double
  %t198 = fadd double %t196, %t197
  store double %t198, double* %l4
  br label %loop.latch10
loop.latch10:
  %t199 = load %TextBuilder, %TextBuilder* %l0
  %t200 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t203 = load %TextBuilder, %TextBuilder* %l0
  %t204 = load double, double* %l4
  %t205 = load %TextBuilder, %TextBuilder* %l0
  %t206 = call %TextBuilder @builder_emit_blank(%TextBuilder %t205)
  store %TextBuilder %t206, %TextBuilder* %l0
  %t207 = load %TextBuilder, %TextBuilder* %l0
  %t208 = load %TextBuilder, %TextBuilder* %l0
  br label %merge7
merge7:
  %t209 = phi %TextBuilder [ %t207, %afterloop11 ], [ %t105, %merge5 ]
  %t210 = phi %TextBuilder [ %t208, %afterloop11 ], [ %t105, %merge5 ]
  store %TextBuilder %t209, %TextBuilder* %l0
  store %TextBuilder %t210, %TextBuilder* %l0
  %t211 = load double, double* %l1
  %t212 = sitofp i64 1 to double
  %t213 = fadd double %t211, %t212
  store double %t213, double* %l1
  br label %loop.latch2
loop.latch2:
  %t214 = load %TextBuilder, %TextBuilder* %l0
  %t215 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t218 = load %TextBuilder, %TextBuilder* %l0
  %t219 = load double, double* %l1
  %t220 = sitofp i64 0 to double
  store double %t220, double* %l1
  %t221 = load %TextBuilder, %TextBuilder* %l0
  %t222 = load double, double* %l1
  br label %loop.header14
loop.header14:
  %t373 = phi %TextBuilder [ %t221, %afterloop3 ], [ %t371, %loop.latch16 ]
  %t374 = phi double [ %t222, %afterloop3 ], [ %t372, %loop.latch16 ]
  store %TextBuilder %t373, %TextBuilder* %l0
  store double %t374, double* %l1
  br label %loop.body15
loop.body15:
  %t223 = load double, double* %l1
  %t224 = extractvalue %Program %program, 0
  %t225 = load { %Statement**, i64 }, { %Statement**, i64 }* %t224
  %t226 = extractvalue { %Statement**, i64 } %t225, 1
  %t227 = sitofp i64 %t226 to double
  %t228 = fcmp oge double %t223, %t227
  %t229 = load %TextBuilder, %TextBuilder* %l0
  %t230 = load double, double* %l1
  br i1 %t228, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t231 = extractvalue %Program %program, 0
  %t232 = load double, double* %l1
  %t233 = call double @llvm.round.f64(double %t232)
  %t234 = fptosi double %t233 to i64
  %t235 = load { %Statement**, i64 }, { %Statement**, i64 }* %t231
  %t236 = extractvalue { %Statement**, i64 } %t235, 0
  %t237 = extractvalue { %Statement**, i64 } %t235, 1
  %t238 = icmp uge i64 %t234, %t237
  ; bounds check: %t238 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t234, i64 %t237)
  %t239 = getelementptr %Statement*, %Statement** %t236, i64 %t234
  %t240 = load %Statement*, %Statement** %t239
  store %Statement* %t240, %Statement** %l5
  %t241 = load %Statement*, %Statement** %l5
  %t242 = getelementptr inbounds %Statement, %Statement* %t241, i32 0, i32 0
  %t243 = load i32, i32* %t242
  %t244 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t245 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t246 = icmp eq i32 %t243, 0
  %t247 = select i1 %t246, i8* %t245, i8* %t244
  %t248 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t249 = icmp eq i32 %t243, 1
  %t250 = select i1 %t249, i8* %t248, i8* %t247
  %t251 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t252 = icmp eq i32 %t243, 2
  %t253 = select i1 %t252, i8* %t251, i8* %t250
  %t254 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t255 = icmp eq i32 %t243, 3
  %t256 = select i1 %t255, i8* %t254, i8* %t253
  %t257 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t258 = icmp eq i32 %t243, 4
  %t259 = select i1 %t258, i8* %t257, i8* %t256
  %t260 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t261 = icmp eq i32 %t243, 5
  %t262 = select i1 %t261, i8* %t260, i8* %t259
  %t263 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t264 = icmp eq i32 %t243, 6
  %t265 = select i1 %t264, i8* %t263, i8* %t262
  %t266 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t267 = icmp eq i32 %t243, 7
  %t268 = select i1 %t267, i8* %t266, i8* %t265
  %t269 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t270 = icmp eq i32 %t243, 8
  %t271 = select i1 %t270, i8* %t269, i8* %t268
  %t272 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t273 = icmp eq i32 %t243, 9
  %t274 = select i1 %t273, i8* %t272, i8* %t271
  %t275 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t276 = icmp eq i32 %t243, 10
  %t277 = select i1 %t276, i8* %t275, i8* %t274
  %t278 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t279 = icmp eq i32 %t243, 11
  %t280 = select i1 %t279, i8* %t278, i8* %t277
  %t281 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t282 = icmp eq i32 %t243, 12
  %t283 = select i1 %t282, i8* %t281, i8* %t280
  %t284 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t285 = icmp eq i32 %t243, 13
  %t286 = select i1 %t285, i8* %t284, i8* %t283
  %t287 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t288 = icmp eq i32 %t243, 14
  %t289 = select i1 %t288, i8* %t287, i8* %t286
  %t290 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t291 = icmp eq i32 %t243, 15
  %t292 = select i1 %t291, i8* %t290, i8* %t289
  %t293 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t294 = icmp eq i32 %t243, 16
  %t295 = select i1 %t294, i8* %t293, i8* %t292
  %t296 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t297 = icmp eq i32 %t243, 17
  %t298 = select i1 %t297, i8* %t296, i8* %t295
  %t299 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t300 = icmp eq i32 %t243, 18
  %t301 = select i1 %t300, i8* %t299, i8* %t298
  %t302 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t303 = icmp eq i32 %t243, 19
  %t304 = select i1 %t303, i8* %t302, i8* %t301
  %t305 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t306 = icmp eq i32 %t243, 20
  %t307 = select i1 %t306, i8* %t305, i8* %t304
  %t308 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t309 = icmp eq i32 %t243, 21
  %t310 = select i1 %t309, i8* %t308, i8* %t307
  %t311 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t312 = icmp eq i32 %t243, 22
  %t313 = select i1 %t312, i8* %t311, i8* %t310
  %s314 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h579804543, i32 0, i32 0
  %t315 = call i1 @strings_equal(i8* %t313, i8* %s314)
  %t316 = load %TextBuilder, %TextBuilder* %l0
  %t317 = load double, double* %l1
  %t318 = load %Statement*, %Statement** %l5
  br i1 %t315, label %then20, label %merge21
then20:
  %t319 = load %Statement*, %Statement** %l5
  %t320 = load %Statement, %Statement* %t319
  %t321 = call %LayoutEmitResult @compute_enum_layout_lines(%LayoutContext %context, %Statement %t320)
  store %LayoutEmitResult %t321, %LayoutEmitResult* %l6
  %t322 = sitofp i64 0 to double
  store double %t322, double* %l7
  %t323 = load %TextBuilder, %TextBuilder* %l0
  %t324 = load double, double* %l1
  %t325 = load %Statement*, %Statement** %l5
  %t326 = load %LayoutEmitResult, %LayoutEmitResult* %l6
  %t327 = load double, double* %l7
  br label %loop.header22
loop.header22:
  %t358 = phi %TextBuilder [ %t323, %then20 ], [ %t356, %loop.latch24 ]
  %t359 = phi double [ %t327, %then20 ], [ %t357, %loop.latch24 ]
  store %TextBuilder %t358, %TextBuilder* %l0
  store double %t359, double* %l7
  br label %loop.body23
loop.body23:
  %t328 = load double, double* %l7
  %t329 = load %LayoutEmitResult, %LayoutEmitResult* %l6
  %t330 = extractvalue %LayoutEmitResult %t329, 0
  %t331 = load { i8**, i64 }, { i8**, i64 }* %t330
  %t332 = extractvalue { i8**, i64 } %t331, 1
  %t333 = sitofp i64 %t332 to double
  %t334 = fcmp oge double %t328, %t333
  %t335 = load %TextBuilder, %TextBuilder* %l0
  %t336 = load double, double* %l1
  %t337 = load %Statement*, %Statement** %l5
  %t338 = load %LayoutEmitResult, %LayoutEmitResult* %l6
  %t339 = load double, double* %l7
  br i1 %t334, label %then26, label %merge27
then26:
  br label %afterloop25
merge27:
  %t340 = load %TextBuilder, %TextBuilder* %l0
  %t341 = load %LayoutEmitResult, %LayoutEmitResult* %l6
  %t342 = extractvalue %LayoutEmitResult %t341, 0
  %t343 = load double, double* %l7
  %t344 = call double @llvm.round.f64(double %t343)
  %t345 = fptosi double %t344 to i64
  %t346 = load { i8**, i64 }, { i8**, i64 }* %t342
  %t347 = extractvalue { i8**, i64 } %t346, 0
  %t348 = extractvalue { i8**, i64 } %t346, 1
  %t349 = icmp uge i64 %t345, %t348
  ; bounds check: %t349 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t345, i64 %t348)
  %t350 = getelementptr i8*, i8** %t347, i64 %t345
  %t351 = load i8*, i8** %t350
  %t352 = call %TextBuilder @builder_emit_line(%TextBuilder %t340, i8* %t351)
  store %TextBuilder %t352, %TextBuilder* %l0
  %t353 = load double, double* %l7
  %t354 = sitofp i64 1 to double
  %t355 = fadd double %t353, %t354
  store double %t355, double* %l7
  br label %loop.latch24
loop.latch24:
  %t356 = load %TextBuilder, %TextBuilder* %l0
  %t357 = load double, double* %l7
  br label %loop.header22
afterloop25:
  %t360 = load %TextBuilder, %TextBuilder* %l0
  %t361 = load double, double* %l7
  %t362 = load %TextBuilder, %TextBuilder* %l0
  %t363 = call %TextBuilder @builder_emit_blank(%TextBuilder %t362)
  store %TextBuilder %t363, %TextBuilder* %l0
  %t364 = load %TextBuilder, %TextBuilder* %l0
  %t365 = load %TextBuilder, %TextBuilder* %l0
  br label %merge21
merge21:
  %t366 = phi %TextBuilder [ %t364, %afterloop25 ], [ %t316, %merge19 ]
  %t367 = phi %TextBuilder [ %t365, %afterloop25 ], [ %t316, %merge19 ]
  store %TextBuilder %t366, %TextBuilder* %l0
  store %TextBuilder %t367, %TextBuilder* %l0
  %t368 = load double, double* %l1
  %t369 = sitofp i64 1 to double
  %t370 = fadd double %t368, %t369
  store double %t370, double* %l1
  br label %loop.latch16
loop.latch16:
  %t371 = load %TextBuilder, %TextBuilder* %l0
  %t372 = load double, double* %l1
  br label %loop.header14
afterloop17:
  %t375 = load %TextBuilder, %TextBuilder* %l0
  %t376 = load double, double* %l1
  %s377 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h401021290, i32 0, i32 0
  %t378 = insertvalue %NativeArtifact undef, i8* %s377, 0
  %s379 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.len23.h668778749, i32 0, i32 0
  %t380 = insertvalue %NativeArtifact %t378, i8* %s379, 1
  %t381 = load %TextBuilder, %TextBuilder* %l0
  %t382 = call i8* @builder_to_string(%TextBuilder %t381)
  %t383 = insertvalue %NativeArtifact %t380, i8* %t382, 2
  ret %NativeArtifact %t383
}

define %NativeState @emit_layout_lines(%NativeState %state, { i8**, i64 }* %lines) {
block.entry:
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
  %t29 = phi %NativeState [ %t4, %merge1 ], [ %t27, %loop.latch4 ]
  %t30 = phi double [ %t5, %merge1 ], [ %t28, %loop.latch4 ]
  store %NativeState %t29, %NativeState* %l0
  store double %t30, double* %l1
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
  %t15 = call double @llvm.round.f64(double %t14)
  %t16 = fptosi double %t15 to i64
  %t17 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t18 = extractvalue { i8**, i64 } %t17, 0
  %t19 = extractvalue { i8**, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t16, i64 %t19)
  %t21 = getelementptr i8*, i8** %t18, i64 %t16
  %t22 = load i8*, i8** %t21
  %t23 = call %NativeState @state_emit_line(%NativeState %t13, i8* %t22)
  store %NativeState %t23, %NativeState* %l0
  %t24 = load double, double* %l1
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l1
  br label %loop.latch4
loop.latch4:
  %t27 = load %NativeState, %NativeState* %l0
  %t28 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t31 = load %NativeState, %NativeState* %l0
  %t32 = load double, double* %l1
  %t33 = load %NativeState, %NativeState* %l0
  ret %NativeState %t33
}

define %TextBuilder @builder_new() {
block.entry:
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  %t12 = insertvalue %TextBuilder undef, { i8**, i64 }* %t9, 0
  %t13 = sitofp i64 0 to double
  %t14 = insertvalue %TextBuilder %t12, double %t13, 1
  ret %TextBuilder %t14
}

define %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %line) {
block.entry:
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
  %t17 = phi i8* [ %t2, %block.entry ], [ %t15, %loop.latch2 ]
  %t18 = phi double [ %t3, %block.entry ], [ %t16, %loop.latch2 ]
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
block.entry:
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
block.entry:
  %t0 = extractvalue %TextBuilder %builder, 0
  %t1 = insertvalue %TextBuilder undef, { i8**, i64 }* %t0, 0
  %t2 = extractvalue %TextBuilder %builder, 1
  %t3 = sitofp i64 1 to double
  %t4 = fadd double %t2, %t3
  %t5 = insertvalue %TextBuilder %t1, double %t4, 1
  ret %TextBuilder %t5
}

define %TextBuilder @builder_pop_indent(%TextBuilder %builder) {
block.entry:
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
  %t9 = phi double [ %t8, %then0 ], [ %t4, %block.entry ]
  store double %t9, double* %l0
  %t10 = extractvalue %TextBuilder %builder, 0
  %t11 = insertvalue %TextBuilder undef, { i8**, i64 }* %t10, 0
  %t12 = load double, double* %l0
  %t13 = insertvalue %TextBuilder %t11, double %t12, 1
  ret %TextBuilder %t13
}

define i8* @builder_to_string(%TextBuilder %builder) {
block.entry:
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
  call void @sailfin_runtime_mark_persistent(i8* %s10)
  ret i8* %s10
merge1:
  %t11 = load i8*, i8** %l0
  %t12 = alloca [2 x i8], align 1
  %t13 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  store i8 10, i8* %t13
  %t14 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 1
  store i8 0, i8* %t14
  %t15 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  %t16 = call i8* @sailfin_runtime_string_concat(i8* %t11, i8* %t15)
  call void @sailfin_runtime_mark_persistent(i8* %t16)
  ret i8* %t16
}

define i8* @trim_right(i8* %value) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i8
  %t0 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t1 = sitofp i64 %t0 to double
  store double %t1, double* %l0
  %t2 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t26 = phi double [ %t2, %block.entry ], [ %t25, %loop.latch2 ]
  store double %t26, double* %l0
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
  %t10 = call double @llvm.round.f64(double %t9)
  %t11 = fptosi double %t10 to i64
  %t12 = getelementptr i8, i8* %value, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l1
  %t15 = load i8, i8* %l1
  %t16 = icmp eq i8 %t15, 32
  br label %logical_or_entry_14

logical_or_entry_14:
  br i1 %t16, label %logical_or_merge_14, label %logical_or_right_14

logical_or_right_14:
  %t17 = load i8, i8* %l1
  %t18 = icmp eq i8 %t17, 9
  br label %logical_or_right_end_14

logical_or_right_end_14:
  br label %logical_or_merge_14

logical_or_merge_14:
  %t19 = phi i1 [ true, %logical_or_entry_14 ], [ %t18, %logical_or_right_end_14 ]
  %t20 = load double, double* %l0
  %t21 = load i8, i8* %l1
  br i1 %t19, label %then6, label %merge7
then6:
  %t22 = load double, double* %l0
  %t23 = sitofp i64 1 to double
  %t24 = fsub double %t22, %t23
  store double %t24, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t25 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t27 = load double, double* %l0
  %t28 = load double, double* %l0
  %t29 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t30 = sitofp i64 %t29 to double
  %t31 = fcmp oeq double %t28, %t30
  %t32 = load double, double* %l0
  br i1 %t31, label %then8, label %merge9
then8:
  call void @sailfin_runtime_mark_persistent(i8* %value)
  ret i8* %value
merge9:
  %t33 = load double, double* %l0
  %t34 = call double @llvm.round.f64(double %t33)
  %t35 = fptosi double %t34 to i64
  %t36 = call i8* @sailfin_runtime_substring(i8* %value, i64 0, i64 %t35)
  call void @sailfin_runtime_mark_persistent(i8* %t36)
  ret i8* %t36
}

define { i8**, i64 }* @append_string({ i8**, i64 }* %values, i8* %value) {
block.entry:
  %t0 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t1 = ptrtoint [1 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr i8*, i8** %t5, i64 0
  store i8* %value, i8** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t8 = ptrtoint { i8**, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { i8**, i64 }*
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t5, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %values, { i8**, i64 }* %t10)
  ret { i8**, i64 }* %t13
}

define i8* @join_with_separator({ i8**, i64 }* %values, i8* %separator) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %t0 = load { i8**, i64 }, { i8**, i64 }* %values
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s3)
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
  %t37 = phi i8* [ %t11, %merge1 ], [ %t35, %loop.latch4 ]
  %t38 = phi double [ %t12, %merge1 ], [ %t36, %loop.latch4 ]
  store i8* %t37, i8** %l0
  store double %t38, double* %l1
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
  %t23 = call double @llvm.round.f64(double %t22)
  %t24 = fptosi double %t23 to i64
  %t25 = load { i8**, i64 }, { i8**, i64 }* %values
  %t26 = extractvalue { i8**, i64 } %t25, 0
  %t27 = extractvalue { i8**, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t24, i64 %t27)
  %t29 = getelementptr i8*, i8** %t26, i64 %t24
  %t30 = load i8*, i8** %t29
  %t31 = call i8* @sailfin_runtime_string_concat(i8* %t21, i8* %t30)
  store i8* %t31, i8** %l0
  %t32 = load double, double* %l1
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l1
  br label %loop.latch4
loop.latch4:
  %t35 = load i8*, i8** %l0
  %t36 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t39 = load i8*, i8** %l0
  %t40 = load double, double* %l1
  %t41 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t41)
  ret i8* %t41
}

define i8* @join_type_annotations({ %TypeAnnotation*, i64 }* %values) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = load { %TypeAnnotation*, i64 }, { %TypeAnnotation*, i64 }* %values
  %t1 = extractvalue { %TypeAnnotation*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s3)
  ret i8* %s3
merge1:
  %t4 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t5 = ptrtoint [0 x i8*]* %t4 to i64
  %t6 = icmp eq i64 %t5, 0
  %t7 = select i1 %t6, i64 1, i64 %t5
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to i8**
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t11 = ptrtoint { i8**, i64 }* %t10 to i64
  %t12 = call i8* @malloc(i64 %t11)
  %t13 = bitcast i8* %t12 to { i8**, i64 }*
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 0
  store i8** %t9, i8*** %t14
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { i8**, i64 }* %t13, { i8**, i64 }** %l0
  %t16 = sitofp i64 0 to double
  store double %t16, double* %l1
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t43 = phi { i8**, i64 }* [ %t17, %merge1 ], [ %t41, %loop.latch4 ]
  %t44 = phi double [ %t18, %merge1 ], [ %t42, %loop.latch4 ]
  store { i8**, i64 }* %t43, { i8**, i64 }** %l0
  store double %t44, double* %l1
  br label %loop.body3
loop.body3:
  %t19 = load double, double* %l1
  %t20 = load { %TypeAnnotation*, i64 }, { %TypeAnnotation*, i64 }* %values
  %t21 = extractvalue { %TypeAnnotation*, i64 } %t20, 1
  %t22 = sitofp i64 %t21 to double
  %t23 = fcmp oge double %t19, %t22
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  br i1 %t23, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load double, double* %l1
  %t28 = call double @llvm.round.f64(double %t27)
  %t29 = fptosi double %t28 to i64
  %t30 = load { %TypeAnnotation*, i64 }, { %TypeAnnotation*, i64 }* %values
  %t31 = extractvalue { %TypeAnnotation*, i64 } %t30, 0
  %t32 = extractvalue { %TypeAnnotation*, i64 } %t30, 1
  %t33 = icmp uge i64 %t29, %t32
  ; bounds check: %t33 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t29, i64 %t32)
  %t34 = getelementptr %TypeAnnotation, %TypeAnnotation* %t31, i64 %t29
  %t35 = load %TypeAnnotation, %TypeAnnotation* %t34
  %t36 = extractvalue %TypeAnnotation %t35, 0
  %t37 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t26, i8* %t36)
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
  call void @sailfin_runtime_mark_persistent(i8* %t49)
  ret i8* %t49
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
@.str.len2.h193512002 = private unnamed_addr constant [3 x i8] c"{ \00"
@.str.len2.h193481015 = private unnamed_addr constant [3 x i8] c"\5Ct\00"
@.str.len5.h1525558983 = private unnamed_addr constant [6 x i8] c" tag=\00"
@.str.len6.h807326654 = private unnamed_addr constant [7 x i8] c"number\00"
@.str.len15.h1067284810 = private unnamed_addr constant [16 x i8] c"PromptStatement\00"
@.str.len2.h193480949 = private unnamed_addr constant [3 x i8] c"\5Cr\00"
@.str.len4.h268717223 = private unnamed_addr constant [5 x i8] c"noop\00"
@.str.len6.h1134498859 = private unnamed_addr constant [7 x i8] c"async \00"
@.str.len3.h2090304184 = private unnamed_addr constant [4 x i8] c"i32\00"
@.str.len6.h1061063223 = private unnamed_addr constant [7 x i8] c"return\00"
@.str.len11.h1571993816 = private unnamed_addr constant [12 x i8] c"NullLiteral\00"
@.str.len5.h500836810 = private unnamed_addr constant [6 x i8] c"test:\00"
@.str.len3.h2090684245 = private unnamed_addr constant [4 x i8] c"ret\00"
@.str.len6.h789270767 = private unnamed_addr constant [7 x i8] c"string\00"
@.str.len6.h1211862785 = private unnamed_addr constant [7 x i8] c"Lambda\00"
@.str.len11.h1566780570 = private unnamed_addr constant [12 x i8] c"IfStatement\00"
@.str.len13.h1678412334 = private unnamed_addr constant [14 x i8] c"LoopStatement\00"
@.str.len3.h2090083282 = private unnamed_addr constant [4 x i8] c"any\00"
@.str.len5.h1445149598 = private unnamed_addr constant [6 x i8] c"Unary\00"
@.str.len6.h512390329 = private unnamed_addr constant [7 x i8] c"Member\00"
@.str.len4.h268929446 = private unnamed_addr constant [5 x i8] c"null\00"
@.str.len14.h1318614710 = private unnamed_addr constant [15 x i8] c"BooleanLiteral\00"
@.str.len15.h579804543 = private unnamed_addr constant [16 x i8] c"EnumDeclaration\00"
@.str.len11.h1482555192 = private unnamed_addr constant [12 x i8] c".decorator \00"
@.str.len19.h486335986 = private unnamed_addr constant [20 x i8] c"FunctionDeclaration\00"
@.str.len13.h1925822000 = private unnamed_addr constant [14 x i8] c"WithStatement\00"
@.str.len5.h1312780988 = private unnamed_addr constant [6 x i8] c"Range\00"
@.str.len2.h193492961 = private unnamed_addr constant [3 x i8] c"i1\00"
@.str.len17.h1998778048 = private unnamed_addr constant [18 x i8] c"ContinueStatement\00"
@.str.len15.h1613933868 = private unnamed_addr constant [16 x i8] c"ReturnStatement\00"
@.str.len5.h667777838 = private unnamed_addr constant [6 x i8] c"Array\00"
@.str.len5.h975618503 = private unnamed_addr constant [6 x i8] c"Index\00"
@.str.len6.h264904746 = private unnamed_addr constant [7 x i8] c"Struct\00"
@.str.len9.h1311191977 = private unnamed_addr constant [10 x i8] c".variant \00"
@.str.len14.h196308685 = private unnamed_addr constant [15 x i8] c"MatchStatement\00"
@.str.len12.h84042670 = private unnamed_addr constant [13 x i8] c"ForStatement\00"
@.str.len3.h2089530004 = private unnamed_addr constant [4 x i8] c"Raw\00"
@.str.len6.h1496334143 = private unnamed_addr constant [7 x i8] c"Binary\00"
@.str.len8.h528348603 = private unnamed_addr constant [9 x i8] c"continue\00"
@.str.len2.h193441217 = private unnamed_addr constant [3 x i8] c": \00"
@.str.len14.h88846349 = private unnamed_addr constant [15 x i8] c"BreakStatement\00"
@.str.len55.h700951597 = private unnamed_addr constant [56 x i8] c"` missing type annotation; defaulting to pointer layout\00"
@.str.len9.h1814778076 = private unnamed_addr constant [10 x i8] c".import \22\00"
@.str.len12.h2084565287 = private unnamed_addr constant [13 x i8] c" implements \00"
@.str.len6.h826984377 = private unnamed_addr constant [7 x i8] c"Object\00"
@.str.len7.h1483009776 = private unnamed_addr constant [8 x i8] c"boolean\00"
@.str.len7.h130169768 = private unnamed_addr constant [8 x i8] c".param \00"
@.str.len20.h666604742 = private unnamed_addr constant [21 x i8] c"InterfaceDeclaration\00"
@.str.len8.h455185518 = private unnamed_addr constant [9 x i8] c" offset=\00"
@.str.len3.h2090370613 = private unnamed_addr constant [4 x i8] c"int\00"
@.str.len17.h1970266448 = private unnamed_addr constant [18 x i8] c".meta return void\00"
@.str.len3.h2087662534 = private unnamed_addr constant [4 x i8] c" ![\00"
@.str.len20.h1496093543 = private unnamed_addr constant [21 x i8] c"TypeAliasDeclaration\00"
@.str.len5.h2072555103 = private unnamed_addr constant [6 x i8] c".sig \00"
@.str.len18.h1250048525 = private unnamed_addr constant [19 x i8] c".meta effects none\00"
@.str.len17.h689147423 = private unnamed_addr constant [18 x i8] c"ImportDeclaration\00"
@.str.len19.h868168677 = private unnamed_addr constant [20 x i8] c"ExpressionStatement\00"
@.str.len16.h1290415774 = private unnamed_addr constant [17 x i8] c".layout payload \00"
@.str.len17.h1813262795 = private unnamed_addr constant [18 x i8] c"ExportDeclaration\00"
@.str.len8.h573909064 = private unnamed_addr constant [9 x i8] c"<lambda>\00"
@.str.len3.h2090307517 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str.len70.h1478160845 = private unnamed_addr constant [71 x i8] c"` optional type missing inner annotation; defaulting to pointer layout\00"
@.str.len7.h513898090 = private unnamed_addr constant [8 x i8] c"variant\00"
@.str.len17.h1842783069 = private unnamed_addr constant [18 x i8] c"StructDeclaration\00"
@.str.len4.h267749729 = private unnamed_addr constant [5 x i8] c"mut \00"
@.str.len14.h1053492670 = private unnamed_addr constant [15 x i8] c".layout field \00"
@.str.len2.h193480223 = private unnamed_addr constant [3 x i8] c"\5C\5C\00"
@.str.len4.h217216103 = private unnamed_addr constant [5 x i8] c"Call\00"
@.str.len15.h1897143060 = private unnamed_addr constant [16 x i8] c".meta generics \00"
@.str.len10.h381722796 = private unnamed_addr constant [11 x i8] c".property \00"
@.str.len5.h1958778164 = private unnamed_addr constant [6 x i8] c"break\00"
@.str.len9.h1091414306 = private unnamed_addr constant [10 x i8] c".export \22\00"
@.str.len2.h193480817 = private unnamed_addr constant [3 x i8] c"\5Cn\00"
@.str.len13.h1570408460 = private unnamed_addr constant [14 x i8] c"NumberLiteral\00"
@.str.len13.h1610966039 = private unnamed_addr constant [14 x i8] c".meta return \00"
@.str.len16.h1695010494 = private unnamed_addr constant [17 x i8] c".layout variant \00"
@.str.len6.h980153509 = private unnamed_addr constant [7 x i8] c" type=\00"
@.str.len7.h655348872 = private unnamed_addr constant [8 x i8] c"return \00"
@.str.len7.h398443637 = private unnamed_addr constant [8 x i8] c".field \00"
@.str.len6.h1187178968 = private unnamed_addr constant [7 x i8] c".case \00"
@.str.len13.h590768815 = private unnamed_addr constant [14 x i8] c"StringLiteral\00"
@.str.len14.h110444378 = private unnamed_addr constant [15 x i8] c".meta effects \00"
@.str.len2.h193478309 = private unnamed_addr constant [3 x i8] c"\5C\22\00"
@.str.len4.h173287691 = private unnamed_addr constant [5 x i8] c"    \00"
@.str.len2.h193428611 = private unnamed_addr constant [3 x i8] c"..\00"
@.str.len10.h1576352120 = private unnamed_addr constant [11 x i8] c"Identifier\00"
@.str.len19.h1204027478 = private unnamed_addr constant [20 x i8] c"VariableDeclaration\00"
@.str.len4.h254486039 = private unnamed_addr constant [5 x i8] c"bool\00"