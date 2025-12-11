; ModuleID = 'sailfin'
source_filename = "sailfin"

%Diagnostic = type { i8*, i8*, %Token* }
%SymbolEntry = type { i8*, i8*, %SourceSpan* }
%TypecheckResult = type { { %Diagnostic**, i64 }*, { %SymbolEntry**, i64 }* }
%SymbolCollectionResult = type { { %SymbolEntry**, i64 }*, { %Diagnostic**, i64 }* }
%ScopeResult = type { { %SymbolEntry**, i64 }*, { %Diagnostic**, i64 }* }
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
%Token = type { %TokenKind, i8*, double, double }
%EffectRequirement = type { i8*, %Token*, i8* }
%EffectViolation = type { i8*, { i8**, i64 }*, { %EffectRequirement**, i64 }* }

%Expression = type { i32, [24 x i8] }
%Statement = type { i32, [56 x i8] }
%TokenKind = type { i32, [8 x i8] }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare i1 @strings_equal(i8*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

@.str.len2.h193425971 = private unnamed_addr constant [3 x i8] c", \00"
@.str.len0.h177573 = private unnamed_addr constant [1 x i8] c"\00"
@.str.len20.h1863181231 = private unnamed_addr constant [21 x i8] c" is missing effect '\00"
@.str.len14.h1876709041 = private unnamed_addr constant [15 x i8] c". hint: add ![\00"
@.str.len60.h1899438158 = private unnamed_addr constant [61 x i8] c"] to the signature or accept the CLI fix prompt when offered\00"
@.str.len5.h743728889 = private unnamed_addr constant [6 x i8] c"E0302\00"
@.str.len7.h289982314 = private unnamed_addr constant [8 x i8] c"struct \00"
@.str.len12.h2084565287 = private unnamed_addr constant [13 x i8] c" implements \00"
@.str.len18.h1304509209 = private unnamed_addr constant [19 x i8] c" but must specify \00"
@.str.len15.h1487231025 = private unnamed_addr constant [16 x i8] c" type arguments\00"
@.str.len16.h302658750 = private unnamed_addr constant [17 x i8] c" but must match \00"
@.str.len5.h1504944345 = private unnamed_addr constant [6 x i8] c" but \00"
@.str.len29.h85694398 = private unnamed_addr constant [30 x i8] c" does not take type arguments\00"
@.str.len5.h743621045 = private unnamed_addr constant [6 x i8] c"E0001\00"
@.str.len10.h6072819 = private unnamed_addr constant [11 x i8] c"duplicate \00"
@.str.len2.h193415015 = private unnamed_addr constant [3 x i8] c" `\00"
@.str.len10.h1855834391 = private unnamed_addr constant [11 x i8] c"` declared\00"
@.str.len5.h743728856 = private unnamed_addr constant [6 x i8] c"E0301\00"
@.str.len24.h680377687 = private unnamed_addr constant [25 x i8] c" but is missing member `\00"

define %TypecheckResult @typecheck_program(%Program %program) {
block.entry:
  %l0 = alloca %SymbolCollectionResult
  %l1 = alloca { %Statement*, i64 }*
  %l2 = alloca { %Diagnostic*, i64 }*
  %l3 = alloca { %Diagnostic*, i64 }*
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca { i8**, i64 }*
  %t0 = call %SymbolCollectionResult @collect_top_level_symbols(%Program %program)
  store %SymbolCollectionResult %t0, %SymbolCollectionResult* %l0
  %t1 = call { %Statement*, i64 }* @collect_interface_definitions(%Program %program)
  store { %Statement*, i64 }* %t1, { %Statement*, i64 }** %l1
  %t2 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  %t3 = call { %Diagnostic*, i64 }* @check_program_scopes(%Program %program, { %Statement*, i64 }* %t2)
  store { %Diagnostic*, i64 }* %t3, { %Diagnostic*, i64 }** %l2
  %t4 = call { %Diagnostic*, i64 }* @build_effect_diagnostics(%Program %program)
  store { %Diagnostic*, i64 }* %t4, { %Diagnostic*, i64 }** %l3
  %t5 = load %SymbolCollectionResult, %SymbolCollectionResult* %l0
  %t6 = extractvalue %SymbolCollectionResult %t5, 1
  %t7 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l2
  %t8 = bitcast { %Diagnostic**, i64 }* %t6 to { i8**, i64 }*
  %t9 = bitcast { %Diagnostic*, i64 }* %t7 to { i8**, i64 }*
  %t10 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t9)
  store { i8**, i64 }* %t10, { i8**, i64 }** %l4
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t12 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  %t13 = bitcast { %Diagnostic*, i64 }* %t12 to { i8**, i64 }*
  %t14 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t11, { i8**, i64 }* %t13)
  store { i8**, i64 }* %t14, { i8**, i64 }** %l5
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t16 = bitcast { i8**, i64 }* %t15 to { %Diagnostic**, i64 }*
  %t17 = insertvalue %TypecheckResult undef, { %Diagnostic**, i64 }* %t16, 0
  %t18 = load %SymbolCollectionResult, %SymbolCollectionResult* %l0
  %t19 = extractvalue %SymbolCollectionResult %t18, 0
  %t20 = insertvalue %TypecheckResult %t17, { %SymbolEntry**, i64 }* %t19, 1
  ret %TypecheckResult %t20
}

define { %Statement*, i64 }* @collect_interface_definitions(%Program %program) {
block.entry:
  %l0 = alloca { %Statement*, i64 }*
  %l1 = alloca i64
  %l2 = alloca %Statement*
  %t0 = getelementptr [0 x %Statement], [0 x %Statement]* null, i32 1
  %t1 = ptrtoint [0 x %Statement]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %Statement*
  %t6 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* null, i32 1
  %t7 = ptrtoint { %Statement*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %Statement*, i64 }*
  %t10 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t9, i32 0, i32 0
  store %Statement* %t5, %Statement** %t10
  %t11 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %Statement*, i64 }* %t9, { %Statement*, i64 }** %l0
  %t12 = extractvalue %Program %program, 0
  %t13 = getelementptr { %Statement**, i64 }, { %Statement**, i64 }* %t12, i32 0, i32 1
  %t14 = load i64, i64* %t13
  %t15 = getelementptr { %Statement**, i64 }, { %Statement**, i64 }* %t12, i32 0, i32 0
  %t16 = load %Statement**, %Statement*** %t15
  store i64 0, i64* %l1
  store %Statement* null, %Statement** %l2
  br label %for0
for0:
  %t17 = load i64, i64* %l1
  %t18 = icmp slt i64 %t17, %t14
  br i1 %t18, label %forbody1, label %afterfor3
forbody1:
  %t19 = load i64, i64* %l1
  %t20 = getelementptr %Statement*, %Statement** %t16, i64 %t19
  %t21 = load %Statement*, %Statement** %t20
  store %Statement* %t21, %Statement** %l2
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
  %s95 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h666604742, i32 0, i32 0
  %t96 = call i1 @strings_equal(i8* %t94, i8* %s95)
  %t97 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  %t98 = load %Statement*, %Statement** %l2
  br i1 %t96, label %then4, label %merge5
then4:
  %t99 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  %t100 = load %Statement*, %Statement** %l2
  %t101 = bitcast %Statement* %t100 to i8*
  %t102 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t103 = ptrtoint [1 x i8*]* %t102 to i64
  %t104 = icmp eq i64 %t103, 0
  %t105 = select i1 %t104, i64 1, i64 %t103
  %t106 = call i8* @malloc(i64 %t105)
  %t107 = bitcast i8* %t106 to i8**
  %t108 = getelementptr i8*, i8** %t107, i64 0
  store i8* %t101, i8** %t108
  %t109 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t110 = ptrtoint { i8**, i64 }* %t109 to i64
  %t111 = call i8* @malloc(i64 %t110)
  %t112 = bitcast i8* %t111 to { i8**, i64 }*
  %t113 = getelementptr { i8**, i64 }, { i8**, i64 }* %t112, i32 0, i32 0
  store i8** %t107, i8*** %t113
  %t114 = getelementptr { i8**, i64 }, { i8**, i64 }* %t112, i32 0, i32 1
  store i64 1, i64* %t114
  %t115 = bitcast { %Statement*, i64 }* %t99 to { i8**, i64 }*
  %t116 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t115, { i8**, i64 }* %t112)
  %t117 = bitcast { i8**, i64 }* %t116 to { %Statement*, i64 }*
  store { %Statement*, i64 }* %t117, { %Statement*, i64 }** %l0
  %t118 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  br label %merge5
merge5:
  %t119 = phi { %Statement*, i64 }* [ %t118, %then4 ], [ %t97, %forbody1 ]
  store { %Statement*, i64 }* %t119, { %Statement*, i64 }** %l0
  br label %forinc2
forinc2:
  %t120 = load i64, i64* %l1
  %t121 = add i64 %t120, 1
  store i64 %t121, i64* %l1
  br label %for0
afterfor3:
  %t122 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  %t123 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  ret { %Statement*, i64 }* %t123
}

define %SymbolCollectionResult @collect_top_level_symbols(%Program %program) {
block.entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %Statement*
  %l4 = alloca %SymbolCollectionResult
  %t0 = getelementptr [0 x %SymbolEntry], [0 x %SymbolEntry]* null, i32 1
  %t1 = ptrtoint [0 x %SymbolEntry]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %SymbolEntry*
  %t6 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* null, i32 1
  %t7 = ptrtoint { %SymbolEntry*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %SymbolEntry*, i64 }*
  %t10 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t9, i32 0, i32 0
  store %SymbolEntry* %t5, %SymbolEntry** %t10
  %t11 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %SymbolEntry*, i64 }* %t9, { %SymbolEntry*, i64 }** %l0
  %t12 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t13 = ptrtoint [0 x %Diagnostic]* %t12 to i64
  %t14 = icmp eq i64 %t13, 0
  %t15 = select i1 %t14, i64 1, i64 %t13
  %t16 = call i8* @malloc(i64 %t15)
  %t17 = bitcast i8* %t16 to %Diagnostic*
  %t18 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t19 = ptrtoint { %Diagnostic*, i64 }* %t18 to i64
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to { %Diagnostic*, i64 }*
  %t22 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t21, i32 0, i32 0
  store %Diagnostic* %t17, %Diagnostic** %t22
  %t23 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t21, i32 0, i32 1
  store i64 0, i64* %t23
  store { %Diagnostic*, i64 }* %t21, { %Diagnostic*, i64 }** %l1
  %t24 = extractvalue %Program %program, 0
  %t25 = getelementptr { %Statement**, i64 }, { %Statement**, i64 }* %t24, i32 0, i32 1
  %t26 = load i64, i64* %t25
  %t27 = getelementptr { %Statement**, i64 }, { %Statement**, i64 }* %t24, i32 0, i32 0
  %t28 = load %Statement**, %Statement*** %t27
  store i64 0, i64* %l2
  store %Statement* null, %Statement** %l3
  br label %for0
for0:
  %t29 = load i64, i64* %l2
  %t30 = icmp slt i64 %t29, %t26
  br i1 %t30, label %forbody1, label %afterfor3
forbody1:
  %t31 = load i64, i64* %l2
  %t32 = getelementptr %Statement*, %Statement** %t28, i64 %t31
  %t33 = load %Statement*, %Statement** %t32
  store %Statement* %t33, %Statement** %l3
  %t34 = load %Statement*, %Statement** %l3
  %t35 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t36 = load %Statement, %Statement* %t34
  %t37 = call %SymbolCollectionResult @register_top_level_symbol(%Statement %t36, { %SymbolEntry*, i64 }* %t35)
  store %SymbolCollectionResult %t37, %SymbolCollectionResult* %l4
  %t38 = load %SymbolCollectionResult, %SymbolCollectionResult* %l4
  %t39 = extractvalue %SymbolCollectionResult %t38, 0
  %t40 = bitcast { %SymbolEntry**, i64 }* %t39 to { %SymbolEntry*, i64 }*
  store { %SymbolEntry*, i64 }* %t40, { %SymbolEntry*, i64 }** %l0
  %t41 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t42 = load %SymbolCollectionResult, %SymbolCollectionResult* %l4
  %t43 = extractvalue %SymbolCollectionResult %t42, 1
  %t44 = bitcast { %Diagnostic*, i64 }* %t41 to { i8**, i64 }*
  %t45 = bitcast { %Diagnostic**, i64 }* %t43 to { i8**, i64 }*
  %t46 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t44, { i8**, i64 }* %t45)
  %t47 = bitcast { i8**, i64 }* %t46 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t47, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t48 = load i64, i64* %l2
  %t49 = add i64 %t48, 1
  store i64 %t49, i64* %l2
  br label %for0
afterfor3:
  %t50 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t51 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t52 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t53 = bitcast { %SymbolEntry*, i64 }* %t52 to { %SymbolEntry**, i64 }*
  %t54 = insertvalue %SymbolCollectionResult undef, { %SymbolEntry**, i64 }* %t53, 0
  %t55 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t56 = bitcast { %Diagnostic*, i64 }* %t55 to { %Diagnostic**, i64 }*
  %t57 = insertvalue %SymbolCollectionResult %t54, { %Diagnostic**, i64 }* %t56, 1
  ret %SymbolCollectionResult %t57
}

define %SymbolCollectionResult @register_top_level_symbol(%Statement %statement, { %SymbolEntry*, i64 }* %existing) {
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
  %s71 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h486335986, i32 0, i32 0
  %t72 = call i1 @strings_equal(i8* %t70, i8* %s71)
  br i1 %t72, label %then0, label %merge1
then0:
  %t73 = extractvalue %Statement %statement, 0
  %t74 = alloca %Statement
  store %Statement %statement, %Statement* %t74
  %t75 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t76 = bitcast [24 x i8]* %t75 to i8*
  %t77 = bitcast i8* %t76 to %FunctionSignature*
  %t78 = load %FunctionSignature, %FunctionSignature* %t77
  %t79 = icmp eq i32 %t73, 4
  %t80 = select i1 %t79, %FunctionSignature %t78, %FunctionSignature zeroinitializer
  %t81 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t82 = bitcast [24 x i8]* %t81 to i8*
  %t83 = bitcast i8* %t82 to %FunctionSignature*
  %t84 = load %FunctionSignature, %FunctionSignature* %t83
  %t85 = icmp eq i32 %t73, 5
  %t86 = select i1 %t85, %FunctionSignature %t84, %FunctionSignature %t80
  %t87 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t88 = bitcast [24 x i8]* %t87 to i8*
  %t89 = bitcast i8* %t88 to %FunctionSignature*
  %t90 = load %FunctionSignature, %FunctionSignature* %t89
  %t91 = icmp eq i32 %t73, 7
  %t92 = select i1 %t91, %FunctionSignature %t90, %FunctionSignature %t86
  %t93 = extractvalue %FunctionSignature %t92, 0
  %s94 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1603982015, i32 0, i32 0
  %t95 = extractvalue %Statement %statement, 0
  %t96 = alloca %Statement
  store %Statement %statement, %Statement* %t96
  %t97 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t98 = bitcast [24 x i8]* %t97 to i8*
  %t99 = bitcast i8* %t98 to %FunctionSignature*
  %t100 = load %FunctionSignature, %FunctionSignature* %t99
  %t101 = icmp eq i32 %t95, 4
  %t102 = select i1 %t101, %FunctionSignature %t100, %FunctionSignature zeroinitializer
  %t103 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t104 = bitcast [24 x i8]* %t103 to i8*
  %t105 = bitcast i8* %t104 to %FunctionSignature*
  %t106 = load %FunctionSignature, %FunctionSignature* %t105
  %t107 = icmp eq i32 %t95, 5
  %t108 = select i1 %t107, %FunctionSignature %t106, %FunctionSignature %t102
  %t109 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t110 = bitcast [24 x i8]* %t109 to i8*
  %t111 = bitcast i8* %t110 to %FunctionSignature*
  %t112 = load %FunctionSignature, %FunctionSignature* %t111
  %t113 = icmp eq i32 %t95, 7
  %t114 = select i1 %t113, %FunctionSignature %t112, %FunctionSignature %t108
  %t115 = extractvalue %FunctionSignature %t114, 6
  %t116 = call %SymbolCollectionResult @register_symbol(i8* %t93, i8* %s94, %SourceSpan* %t115, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t116
merge1:
  %t117 = extractvalue %Statement %statement, 0
  %t118 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t119 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t117, 0
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %t122 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t123 = icmp eq i32 %t117, 1
  %t124 = select i1 %t123, i8* %t122, i8* %t121
  %t125 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t126 = icmp eq i32 %t117, 2
  %t127 = select i1 %t126, i8* %t125, i8* %t124
  %t128 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t129 = icmp eq i32 %t117, 3
  %t130 = select i1 %t129, i8* %t128, i8* %t127
  %t131 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t132 = icmp eq i32 %t117, 4
  %t133 = select i1 %t132, i8* %t131, i8* %t130
  %t134 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t117, 5
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t117, 6
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t117, 7
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t117, 8
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t117, 9
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t117, 10
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t117, 11
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t117, 12
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t117, 13
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t117, 14
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t117, 15
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t117, 16
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t117, 17
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t117, 18
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %t176 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t177 = icmp eq i32 %t117, 19
  %t178 = select i1 %t177, i8* %t176, i8* %t175
  %t179 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t117, 20
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t117, 21
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t117, 22
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %s188 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1842783069, i32 0, i32 0
  %t189 = call i1 @strings_equal(i8* %t187, i8* %s188)
  br i1 %t189, label %then2, label %merge3
then2:
  %t190 = extractvalue %Statement %statement, 0
  %t191 = alloca %Statement
  store %Statement %statement, %Statement* %t191
  %t192 = getelementptr inbounds %Statement, %Statement* %t191, i32 0, i32 1
  %t193 = bitcast [48 x i8]* %t192 to i8*
  %t194 = bitcast i8* %t193 to i8**
  %t195 = load i8*, i8** %t194
  %t196 = icmp eq i32 %t190, 2
  %t197 = select i1 %t196, i8* %t195, i8* null
  %t198 = getelementptr inbounds %Statement, %Statement* %t191, i32 0, i32 1
  %t199 = bitcast [48 x i8]* %t198 to i8*
  %t200 = bitcast i8* %t199 to i8**
  %t201 = load i8*, i8** %t200
  %t202 = icmp eq i32 %t190, 3
  %t203 = select i1 %t202, i8* %t201, i8* %t197
  %t204 = getelementptr inbounds %Statement, %Statement* %t191, i32 0, i32 1
  %t205 = bitcast [40 x i8]* %t204 to i8*
  %t206 = bitcast i8* %t205 to i8**
  %t207 = load i8*, i8** %t206
  %t208 = icmp eq i32 %t190, 6
  %t209 = select i1 %t208, i8* %t207, i8* %t203
  %t210 = getelementptr inbounds %Statement, %Statement* %t191, i32 0, i32 1
  %t211 = bitcast [56 x i8]* %t210 to i8*
  %t212 = bitcast i8* %t211 to i8**
  %t213 = load i8*, i8** %t212
  %t214 = icmp eq i32 %t190, 8
  %t215 = select i1 %t214, i8* %t213, i8* %t209
  %t216 = getelementptr inbounds %Statement, %Statement* %t191, i32 0, i32 1
  %t217 = bitcast [40 x i8]* %t216 to i8*
  %t218 = bitcast i8* %t217 to i8**
  %t219 = load i8*, i8** %t218
  %t220 = icmp eq i32 %t190, 9
  %t221 = select i1 %t220, i8* %t219, i8* %t215
  %t222 = getelementptr inbounds %Statement, %Statement* %t191, i32 0, i32 1
  %t223 = bitcast [40 x i8]* %t222 to i8*
  %t224 = bitcast i8* %t223 to i8**
  %t225 = load i8*, i8** %t224
  %t226 = icmp eq i32 %t190, 10
  %t227 = select i1 %t226, i8* %t225, i8* %t221
  %t228 = getelementptr inbounds %Statement, %Statement* %t191, i32 0, i32 1
  %t229 = bitcast [40 x i8]* %t228 to i8*
  %t230 = bitcast i8* %t229 to i8**
  %t231 = load i8*, i8** %t230
  %t232 = icmp eq i32 %t190, 11
  %t233 = select i1 %t232, i8* %t231, i8* %t227
  %s234 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h789690461, i32 0, i32 0
  %t235 = extractvalue %Statement %statement, 0
  %t236 = alloca %Statement
  store %Statement %statement, %Statement* %t236
  %t237 = getelementptr inbounds %Statement, %Statement* %t236, i32 0, i32 1
  %t238 = bitcast [48 x i8]* %t237 to i8*
  %t239 = getelementptr inbounds i8, i8* %t238, i64 8
  %t240 = bitcast i8* %t239 to %SourceSpan**
  %t241 = load %SourceSpan*, %SourceSpan** %t240
  %t242 = icmp eq i32 %t235, 3
  %t243 = select i1 %t242, %SourceSpan* %t241, %SourceSpan* null
  %t244 = getelementptr inbounds %Statement, %Statement* %t236, i32 0, i32 1
  %t245 = bitcast [40 x i8]* %t244 to i8*
  %t246 = getelementptr inbounds i8, i8* %t245, i64 8
  %t247 = bitcast i8* %t246 to %SourceSpan**
  %t248 = load %SourceSpan*, %SourceSpan** %t247
  %t249 = icmp eq i32 %t235, 6
  %t250 = select i1 %t249, %SourceSpan* %t248, %SourceSpan* %t243
  %t251 = getelementptr inbounds %Statement, %Statement* %t236, i32 0, i32 1
  %t252 = bitcast [56 x i8]* %t251 to i8*
  %t253 = getelementptr inbounds i8, i8* %t252, i64 8
  %t254 = bitcast i8* %t253 to %SourceSpan**
  %t255 = load %SourceSpan*, %SourceSpan** %t254
  %t256 = icmp eq i32 %t235, 8
  %t257 = select i1 %t256, %SourceSpan* %t255, %SourceSpan* %t250
  %t258 = getelementptr inbounds %Statement, %Statement* %t236, i32 0, i32 1
  %t259 = bitcast [40 x i8]* %t258 to i8*
  %t260 = getelementptr inbounds i8, i8* %t259, i64 8
  %t261 = bitcast i8* %t260 to %SourceSpan**
  %t262 = load %SourceSpan*, %SourceSpan** %t261
  %t263 = icmp eq i32 %t235, 9
  %t264 = select i1 %t263, %SourceSpan* %t262, %SourceSpan* %t257
  %t265 = getelementptr inbounds %Statement, %Statement* %t236, i32 0, i32 1
  %t266 = bitcast [40 x i8]* %t265 to i8*
  %t267 = getelementptr inbounds i8, i8* %t266, i64 8
  %t268 = bitcast i8* %t267 to %SourceSpan**
  %t269 = load %SourceSpan*, %SourceSpan** %t268
  %t270 = icmp eq i32 %t235, 10
  %t271 = select i1 %t270, %SourceSpan* %t269, %SourceSpan* %t264
  %t272 = getelementptr inbounds %Statement, %Statement* %t236, i32 0, i32 1
  %t273 = bitcast [40 x i8]* %t272 to i8*
  %t274 = getelementptr inbounds i8, i8* %t273, i64 8
  %t275 = bitcast i8* %t274 to %SourceSpan**
  %t276 = load %SourceSpan*, %SourceSpan** %t275
  %t277 = icmp eq i32 %t235, 11
  %t278 = select i1 %t277, %SourceSpan* %t276, %SourceSpan* %t271
  %t279 = call %SymbolCollectionResult @register_symbol(i8* %t233, i8* %s234, %SourceSpan* %t278, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t279
merge3:
  %t280 = extractvalue %Statement %statement, 0
  %t281 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t282 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t283 = icmp eq i32 %t280, 0
  %t284 = select i1 %t283, i8* %t282, i8* %t281
  %t285 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t286 = icmp eq i32 %t280, 1
  %t287 = select i1 %t286, i8* %t285, i8* %t284
  %t288 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t289 = icmp eq i32 %t280, 2
  %t290 = select i1 %t289, i8* %t288, i8* %t287
  %t291 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t292 = icmp eq i32 %t280, 3
  %t293 = select i1 %t292, i8* %t291, i8* %t290
  %t294 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t295 = icmp eq i32 %t280, 4
  %t296 = select i1 %t295, i8* %t294, i8* %t293
  %t297 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t298 = icmp eq i32 %t280, 5
  %t299 = select i1 %t298, i8* %t297, i8* %t296
  %t300 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t301 = icmp eq i32 %t280, 6
  %t302 = select i1 %t301, i8* %t300, i8* %t299
  %t303 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t304 = icmp eq i32 %t280, 7
  %t305 = select i1 %t304, i8* %t303, i8* %t302
  %t306 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t307 = icmp eq i32 %t280, 8
  %t308 = select i1 %t307, i8* %t306, i8* %t305
  %t309 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t310 = icmp eq i32 %t280, 9
  %t311 = select i1 %t310, i8* %t309, i8* %t308
  %t312 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t313 = icmp eq i32 %t280, 10
  %t314 = select i1 %t313, i8* %t312, i8* %t311
  %t315 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t316 = icmp eq i32 %t280, 11
  %t317 = select i1 %t316, i8* %t315, i8* %t314
  %t318 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t319 = icmp eq i32 %t280, 12
  %t320 = select i1 %t319, i8* %t318, i8* %t317
  %t321 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t322 = icmp eq i32 %t280, 13
  %t323 = select i1 %t322, i8* %t321, i8* %t320
  %t324 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t325 = icmp eq i32 %t280, 14
  %t326 = select i1 %t325, i8* %t324, i8* %t323
  %t327 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t328 = icmp eq i32 %t280, 15
  %t329 = select i1 %t328, i8* %t327, i8* %t326
  %t330 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t331 = icmp eq i32 %t280, 16
  %t332 = select i1 %t331, i8* %t330, i8* %t329
  %t333 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t334 = icmp eq i32 %t280, 17
  %t335 = select i1 %t334, i8* %t333, i8* %t332
  %t336 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t337 = icmp eq i32 %t280, 18
  %t338 = select i1 %t337, i8* %t336, i8* %t335
  %t339 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t340 = icmp eq i32 %t280, 19
  %t341 = select i1 %t340, i8* %t339, i8* %t338
  %t342 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t343 = icmp eq i32 %t280, 20
  %t344 = select i1 %t343, i8* %t342, i8* %t341
  %t345 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t346 = icmp eq i32 %t280, 21
  %t347 = select i1 %t346, i8* %t345, i8* %t344
  %t348 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t349 = icmp eq i32 %t280, 22
  %t350 = select i1 %t349, i8* %t348, i8* %t347
  %s351 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h579804543, i32 0, i32 0
  %t352 = call i1 @strings_equal(i8* %t350, i8* %s351)
  br i1 %t352, label %then4, label %merge5
then4:
  %t353 = extractvalue %Statement %statement, 0
  %t354 = alloca %Statement
  store %Statement %statement, %Statement* %t354
  %t355 = getelementptr inbounds %Statement, %Statement* %t354, i32 0, i32 1
  %t356 = bitcast [48 x i8]* %t355 to i8*
  %t357 = bitcast i8* %t356 to i8**
  %t358 = load i8*, i8** %t357
  %t359 = icmp eq i32 %t353, 2
  %t360 = select i1 %t359, i8* %t358, i8* null
  %t361 = getelementptr inbounds %Statement, %Statement* %t354, i32 0, i32 1
  %t362 = bitcast [48 x i8]* %t361 to i8*
  %t363 = bitcast i8* %t362 to i8**
  %t364 = load i8*, i8** %t363
  %t365 = icmp eq i32 %t353, 3
  %t366 = select i1 %t365, i8* %t364, i8* %t360
  %t367 = getelementptr inbounds %Statement, %Statement* %t354, i32 0, i32 1
  %t368 = bitcast [40 x i8]* %t367 to i8*
  %t369 = bitcast i8* %t368 to i8**
  %t370 = load i8*, i8** %t369
  %t371 = icmp eq i32 %t353, 6
  %t372 = select i1 %t371, i8* %t370, i8* %t366
  %t373 = getelementptr inbounds %Statement, %Statement* %t354, i32 0, i32 1
  %t374 = bitcast [56 x i8]* %t373 to i8*
  %t375 = bitcast i8* %t374 to i8**
  %t376 = load i8*, i8** %t375
  %t377 = icmp eq i32 %t353, 8
  %t378 = select i1 %t377, i8* %t376, i8* %t372
  %t379 = getelementptr inbounds %Statement, %Statement* %t354, i32 0, i32 1
  %t380 = bitcast [40 x i8]* %t379 to i8*
  %t381 = bitcast i8* %t380 to i8**
  %t382 = load i8*, i8** %t381
  %t383 = icmp eq i32 %t353, 9
  %t384 = select i1 %t383, i8* %t382, i8* %t378
  %t385 = getelementptr inbounds %Statement, %Statement* %t354, i32 0, i32 1
  %t386 = bitcast [40 x i8]* %t385 to i8*
  %t387 = bitcast i8* %t386 to i8**
  %t388 = load i8*, i8** %t387
  %t389 = icmp eq i32 %t353, 10
  %t390 = select i1 %t389, i8* %t388, i8* %t384
  %t391 = getelementptr inbounds %Statement, %Statement* %t354, i32 0, i32 1
  %t392 = bitcast [40 x i8]* %t391 to i8*
  %t393 = bitcast i8* %t392 to i8**
  %t394 = load i8*, i8** %t393
  %t395 = icmp eq i32 %t353, 11
  %t396 = select i1 %t395, i8* %t394, i8* %t390
  %s397 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h258014432, i32 0, i32 0
  %t398 = extractvalue %Statement %statement, 0
  %t399 = alloca %Statement
  store %Statement %statement, %Statement* %t399
  %t400 = getelementptr inbounds %Statement, %Statement* %t399, i32 0, i32 1
  %t401 = bitcast [48 x i8]* %t400 to i8*
  %t402 = getelementptr inbounds i8, i8* %t401, i64 8
  %t403 = bitcast i8* %t402 to %SourceSpan**
  %t404 = load %SourceSpan*, %SourceSpan** %t403
  %t405 = icmp eq i32 %t398, 3
  %t406 = select i1 %t405, %SourceSpan* %t404, %SourceSpan* null
  %t407 = getelementptr inbounds %Statement, %Statement* %t399, i32 0, i32 1
  %t408 = bitcast [40 x i8]* %t407 to i8*
  %t409 = getelementptr inbounds i8, i8* %t408, i64 8
  %t410 = bitcast i8* %t409 to %SourceSpan**
  %t411 = load %SourceSpan*, %SourceSpan** %t410
  %t412 = icmp eq i32 %t398, 6
  %t413 = select i1 %t412, %SourceSpan* %t411, %SourceSpan* %t406
  %t414 = getelementptr inbounds %Statement, %Statement* %t399, i32 0, i32 1
  %t415 = bitcast [56 x i8]* %t414 to i8*
  %t416 = getelementptr inbounds i8, i8* %t415, i64 8
  %t417 = bitcast i8* %t416 to %SourceSpan**
  %t418 = load %SourceSpan*, %SourceSpan** %t417
  %t419 = icmp eq i32 %t398, 8
  %t420 = select i1 %t419, %SourceSpan* %t418, %SourceSpan* %t413
  %t421 = getelementptr inbounds %Statement, %Statement* %t399, i32 0, i32 1
  %t422 = bitcast [40 x i8]* %t421 to i8*
  %t423 = getelementptr inbounds i8, i8* %t422, i64 8
  %t424 = bitcast i8* %t423 to %SourceSpan**
  %t425 = load %SourceSpan*, %SourceSpan** %t424
  %t426 = icmp eq i32 %t398, 9
  %t427 = select i1 %t426, %SourceSpan* %t425, %SourceSpan* %t420
  %t428 = getelementptr inbounds %Statement, %Statement* %t399, i32 0, i32 1
  %t429 = bitcast [40 x i8]* %t428 to i8*
  %t430 = getelementptr inbounds i8, i8* %t429, i64 8
  %t431 = bitcast i8* %t430 to %SourceSpan**
  %t432 = load %SourceSpan*, %SourceSpan** %t431
  %t433 = icmp eq i32 %t398, 10
  %t434 = select i1 %t433, %SourceSpan* %t432, %SourceSpan* %t427
  %t435 = getelementptr inbounds %Statement, %Statement* %t399, i32 0, i32 1
  %t436 = bitcast [40 x i8]* %t435 to i8*
  %t437 = getelementptr inbounds i8, i8* %t436, i64 8
  %t438 = bitcast i8* %t437 to %SourceSpan**
  %t439 = load %SourceSpan*, %SourceSpan** %t438
  %t440 = icmp eq i32 %t398, 11
  %t441 = select i1 %t440, %SourceSpan* %t439, %SourceSpan* %t434
  %t442 = call %SymbolCollectionResult @register_symbol(i8* %t396, i8* %s397, %SourceSpan* %t441, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t442
merge5:
  %t443 = extractvalue %Statement %statement, 0
  %t444 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t445 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t446 = icmp eq i32 %t443, 0
  %t447 = select i1 %t446, i8* %t445, i8* %t444
  %t448 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t449 = icmp eq i32 %t443, 1
  %t450 = select i1 %t449, i8* %t448, i8* %t447
  %t451 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t452 = icmp eq i32 %t443, 2
  %t453 = select i1 %t452, i8* %t451, i8* %t450
  %t454 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t455 = icmp eq i32 %t443, 3
  %t456 = select i1 %t455, i8* %t454, i8* %t453
  %t457 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t458 = icmp eq i32 %t443, 4
  %t459 = select i1 %t458, i8* %t457, i8* %t456
  %t460 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t461 = icmp eq i32 %t443, 5
  %t462 = select i1 %t461, i8* %t460, i8* %t459
  %t463 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t464 = icmp eq i32 %t443, 6
  %t465 = select i1 %t464, i8* %t463, i8* %t462
  %t466 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t467 = icmp eq i32 %t443, 7
  %t468 = select i1 %t467, i8* %t466, i8* %t465
  %t469 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t470 = icmp eq i32 %t443, 8
  %t471 = select i1 %t470, i8* %t469, i8* %t468
  %t472 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t473 = icmp eq i32 %t443, 9
  %t474 = select i1 %t473, i8* %t472, i8* %t471
  %t475 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t476 = icmp eq i32 %t443, 10
  %t477 = select i1 %t476, i8* %t475, i8* %t474
  %t478 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t479 = icmp eq i32 %t443, 11
  %t480 = select i1 %t479, i8* %t478, i8* %t477
  %t481 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t482 = icmp eq i32 %t443, 12
  %t483 = select i1 %t482, i8* %t481, i8* %t480
  %t484 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t485 = icmp eq i32 %t443, 13
  %t486 = select i1 %t485, i8* %t484, i8* %t483
  %t487 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t488 = icmp eq i32 %t443, 14
  %t489 = select i1 %t488, i8* %t487, i8* %t486
  %t490 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t491 = icmp eq i32 %t443, 15
  %t492 = select i1 %t491, i8* %t490, i8* %t489
  %t493 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t494 = icmp eq i32 %t443, 16
  %t495 = select i1 %t494, i8* %t493, i8* %t492
  %t496 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t497 = icmp eq i32 %t443, 17
  %t498 = select i1 %t497, i8* %t496, i8* %t495
  %t499 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t500 = icmp eq i32 %t443, 18
  %t501 = select i1 %t500, i8* %t499, i8* %t498
  %t502 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t503 = icmp eq i32 %t443, 19
  %t504 = select i1 %t503, i8* %t502, i8* %t501
  %t505 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t506 = icmp eq i32 %t443, 20
  %t507 = select i1 %t506, i8* %t505, i8* %t504
  %t508 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t509 = icmp eq i32 %t443, 21
  %t510 = select i1 %t509, i8* %t508, i8* %t507
  %t511 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t512 = icmp eq i32 %t443, 22
  %t513 = select i1 %t512, i8* %t511, i8* %t510
  %s514 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h666604742, i32 0, i32 0
  %t515 = call i1 @strings_equal(i8* %t513, i8* %s514)
  br i1 %t515, label %then6, label %merge7
then6:
  %t516 = extractvalue %Statement %statement, 0
  %t517 = alloca %Statement
  store %Statement %statement, %Statement* %t517
  %t518 = getelementptr inbounds %Statement, %Statement* %t517, i32 0, i32 1
  %t519 = bitcast [48 x i8]* %t518 to i8*
  %t520 = bitcast i8* %t519 to i8**
  %t521 = load i8*, i8** %t520
  %t522 = icmp eq i32 %t516, 2
  %t523 = select i1 %t522, i8* %t521, i8* null
  %t524 = getelementptr inbounds %Statement, %Statement* %t517, i32 0, i32 1
  %t525 = bitcast [48 x i8]* %t524 to i8*
  %t526 = bitcast i8* %t525 to i8**
  %t527 = load i8*, i8** %t526
  %t528 = icmp eq i32 %t516, 3
  %t529 = select i1 %t528, i8* %t527, i8* %t523
  %t530 = getelementptr inbounds %Statement, %Statement* %t517, i32 0, i32 1
  %t531 = bitcast [40 x i8]* %t530 to i8*
  %t532 = bitcast i8* %t531 to i8**
  %t533 = load i8*, i8** %t532
  %t534 = icmp eq i32 %t516, 6
  %t535 = select i1 %t534, i8* %t533, i8* %t529
  %t536 = getelementptr inbounds %Statement, %Statement* %t517, i32 0, i32 1
  %t537 = bitcast [56 x i8]* %t536 to i8*
  %t538 = bitcast i8* %t537 to i8**
  %t539 = load i8*, i8** %t538
  %t540 = icmp eq i32 %t516, 8
  %t541 = select i1 %t540, i8* %t539, i8* %t535
  %t542 = getelementptr inbounds %Statement, %Statement* %t517, i32 0, i32 1
  %t543 = bitcast [40 x i8]* %t542 to i8*
  %t544 = bitcast i8* %t543 to i8**
  %t545 = load i8*, i8** %t544
  %t546 = icmp eq i32 %t516, 9
  %t547 = select i1 %t546, i8* %t545, i8* %t541
  %t548 = getelementptr inbounds %Statement, %Statement* %t517, i32 0, i32 1
  %t549 = bitcast [40 x i8]* %t548 to i8*
  %t550 = bitcast i8* %t549 to i8**
  %t551 = load i8*, i8** %t550
  %t552 = icmp eq i32 %t516, 10
  %t553 = select i1 %t552, i8* %t551, i8* %t547
  %t554 = getelementptr inbounds %Statement, %Statement* %t517, i32 0, i32 1
  %t555 = bitcast [40 x i8]* %t554 to i8*
  %t556 = bitcast i8* %t555 to i8**
  %t557 = load i8*, i8** %t556
  %t558 = icmp eq i32 %t516, 11
  %t559 = select i1 %t558, i8* %t557, i8* %t553
  %s560 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1313193687, i32 0, i32 0
  %t561 = extractvalue %Statement %statement, 0
  %t562 = alloca %Statement
  store %Statement %statement, %Statement* %t562
  %t563 = getelementptr inbounds %Statement, %Statement* %t562, i32 0, i32 1
  %t564 = bitcast [48 x i8]* %t563 to i8*
  %t565 = getelementptr inbounds i8, i8* %t564, i64 8
  %t566 = bitcast i8* %t565 to %SourceSpan**
  %t567 = load %SourceSpan*, %SourceSpan** %t566
  %t568 = icmp eq i32 %t561, 3
  %t569 = select i1 %t568, %SourceSpan* %t567, %SourceSpan* null
  %t570 = getelementptr inbounds %Statement, %Statement* %t562, i32 0, i32 1
  %t571 = bitcast [40 x i8]* %t570 to i8*
  %t572 = getelementptr inbounds i8, i8* %t571, i64 8
  %t573 = bitcast i8* %t572 to %SourceSpan**
  %t574 = load %SourceSpan*, %SourceSpan** %t573
  %t575 = icmp eq i32 %t561, 6
  %t576 = select i1 %t575, %SourceSpan* %t574, %SourceSpan* %t569
  %t577 = getelementptr inbounds %Statement, %Statement* %t562, i32 0, i32 1
  %t578 = bitcast [56 x i8]* %t577 to i8*
  %t579 = getelementptr inbounds i8, i8* %t578, i64 8
  %t580 = bitcast i8* %t579 to %SourceSpan**
  %t581 = load %SourceSpan*, %SourceSpan** %t580
  %t582 = icmp eq i32 %t561, 8
  %t583 = select i1 %t582, %SourceSpan* %t581, %SourceSpan* %t576
  %t584 = getelementptr inbounds %Statement, %Statement* %t562, i32 0, i32 1
  %t585 = bitcast [40 x i8]* %t584 to i8*
  %t586 = getelementptr inbounds i8, i8* %t585, i64 8
  %t587 = bitcast i8* %t586 to %SourceSpan**
  %t588 = load %SourceSpan*, %SourceSpan** %t587
  %t589 = icmp eq i32 %t561, 9
  %t590 = select i1 %t589, %SourceSpan* %t588, %SourceSpan* %t583
  %t591 = getelementptr inbounds %Statement, %Statement* %t562, i32 0, i32 1
  %t592 = bitcast [40 x i8]* %t591 to i8*
  %t593 = getelementptr inbounds i8, i8* %t592, i64 8
  %t594 = bitcast i8* %t593 to %SourceSpan**
  %t595 = load %SourceSpan*, %SourceSpan** %t594
  %t596 = icmp eq i32 %t561, 10
  %t597 = select i1 %t596, %SourceSpan* %t595, %SourceSpan* %t590
  %t598 = getelementptr inbounds %Statement, %Statement* %t562, i32 0, i32 1
  %t599 = bitcast [40 x i8]* %t598 to i8*
  %t600 = getelementptr inbounds i8, i8* %t599, i64 8
  %t601 = bitcast i8* %t600 to %SourceSpan**
  %t602 = load %SourceSpan*, %SourceSpan** %t601
  %t603 = icmp eq i32 %t561, 11
  %t604 = select i1 %t603, %SourceSpan* %t602, %SourceSpan* %t597
  %t605 = call %SymbolCollectionResult @register_symbol(i8* %t559, i8* %s560, %SourceSpan* %t604, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t605
merge7:
  %t606 = extractvalue %Statement %statement, 0
  %t607 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t608 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t609 = icmp eq i32 %t606, 0
  %t610 = select i1 %t609, i8* %t608, i8* %t607
  %t611 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t612 = icmp eq i32 %t606, 1
  %t613 = select i1 %t612, i8* %t611, i8* %t610
  %t614 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t615 = icmp eq i32 %t606, 2
  %t616 = select i1 %t615, i8* %t614, i8* %t613
  %t617 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t618 = icmp eq i32 %t606, 3
  %t619 = select i1 %t618, i8* %t617, i8* %t616
  %t620 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t621 = icmp eq i32 %t606, 4
  %t622 = select i1 %t621, i8* %t620, i8* %t619
  %t623 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t624 = icmp eq i32 %t606, 5
  %t625 = select i1 %t624, i8* %t623, i8* %t622
  %t626 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t627 = icmp eq i32 %t606, 6
  %t628 = select i1 %t627, i8* %t626, i8* %t625
  %t629 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t630 = icmp eq i32 %t606, 7
  %t631 = select i1 %t630, i8* %t629, i8* %t628
  %t632 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t633 = icmp eq i32 %t606, 8
  %t634 = select i1 %t633, i8* %t632, i8* %t631
  %t635 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t636 = icmp eq i32 %t606, 9
  %t637 = select i1 %t636, i8* %t635, i8* %t634
  %t638 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t639 = icmp eq i32 %t606, 10
  %t640 = select i1 %t639, i8* %t638, i8* %t637
  %t641 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t642 = icmp eq i32 %t606, 11
  %t643 = select i1 %t642, i8* %t641, i8* %t640
  %t644 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t645 = icmp eq i32 %t606, 12
  %t646 = select i1 %t645, i8* %t644, i8* %t643
  %t647 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t648 = icmp eq i32 %t606, 13
  %t649 = select i1 %t648, i8* %t647, i8* %t646
  %t650 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t651 = icmp eq i32 %t606, 14
  %t652 = select i1 %t651, i8* %t650, i8* %t649
  %t653 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t654 = icmp eq i32 %t606, 15
  %t655 = select i1 %t654, i8* %t653, i8* %t652
  %t656 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t657 = icmp eq i32 %t606, 16
  %t658 = select i1 %t657, i8* %t656, i8* %t655
  %t659 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t660 = icmp eq i32 %t606, 17
  %t661 = select i1 %t660, i8* %t659, i8* %t658
  %t662 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t663 = icmp eq i32 %t606, 18
  %t664 = select i1 %t663, i8* %t662, i8* %t661
  %t665 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t666 = icmp eq i32 %t606, 19
  %t667 = select i1 %t666, i8* %t665, i8* %t664
  %t668 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t669 = icmp eq i32 %t606, 20
  %t670 = select i1 %t669, i8* %t668, i8* %t667
  %t671 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t672 = icmp eq i32 %t606, 21
  %t673 = select i1 %t672, i8* %t671, i8* %t670
  %t674 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t675 = icmp eq i32 %t606, 22
  %t676 = select i1 %t675, i8* %t674, i8* %t673
  %s677 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h2043328844, i32 0, i32 0
  %t678 = call i1 @strings_equal(i8* %t676, i8* %s677)
  br i1 %t678, label %then8, label %merge9
then8:
  %t679 = extractvalue %Statement %statement, 0
  %t680 = alloca %Statement
  store %Statement %statement, %Statement* %t680
  %t681 = getelementptr inbounds %Statement, %Statement* %t680, i32 0, i32 1
  %t682 = bitcast [48 x i8]* %t681 to i8*
  %t683 = bitcast i8* %t682 to i8**
  %t684 = load i8*, i8** %t683
  %t685 = icmp eq i32 %t679, 2
  %t686 = select i1 %t685, i8* %t684, i8* null
  %t687 = getelementptr inbounds %Statement, %Statement* %t680, i32 0, i32 1
  %t688 = bitcast [48 x i8]* %t687 to i8*
  %t689 = bitcast i8* %t688 to i8**
  %t690 = load i8*, i8** %t689
  %t691 = icmp eq i32 %t679, 3
  %t692 = select i1 %t691, i8* %t690, i8* %t686
  %t693 = getelementptr inbounds %Statement, %Statement* %t680, i32 0, i32 1
  %t694 = bitcast [40 x i8]* %t693 to i8*
  %t695 = bitcast i8* %t694 to i8**
  %t696 = load i8*, i8** %t695
  %t697 = icmp eq i32 %t679, 6
  %t698 = select i1 %t697, i8* %t696, i8* %t692
  %t699 = getelementptr inbounds %Statement, %Statement* %t680, i32 0, i32 1
  %t700 = bitcast [56 x i8]* %t699 to i8*
  %t701 = bitcast i8* %t700 to i8**
  %t702 = load i8*, i8** %t701
  %t703 = icmp eq i32 %t679, 8
  %t704 = select i1 %t703, i8* %t702, i8* %t698
  %t705 = getelementptr inbounds %Statement, %Statement* %t680, i32 0, i32 1
  %t706 = bitcast [40 x i8]* %t705 to i8*
  %t707 = bitcast i8* %t706 to i8**
  %t708 = load i8*, i8** %t707
  %t709 = icmp eq i32 %t679, 9
  %t710 = select i1 %t709, i8* %t708, i8* %t704
  %t711 = getelementptr inbounds %Statement, %Statement* %t680, i32 0, i32 1
  %t712 = bitcast [40 x i8]* %t711 to i8*
  %t713 = bitcast i8* %t712 to i8**
  %t714 = load i8*, i8** %t713
  %t715 = icmp eq i32 %t679, 10
  %t716 = select i1 %t715, i8* %t714, i8* %t710
  %t717 = getelementptr inbounds %Statement, %Statement* %t680, i32 0, i32 1
  %t718 = bitcast [40 x i8]* %t717 to i8*
  %t719 = bitcast i8* %t718 to i8**
  %t720 = load i8*, i8** %t719
  %t721 = icmp eq i32 %t679, 11
  %t722 = select i1 %t721, i8* %t720, i8* %t716
  %s723 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h238194529, i32 0, i32 0
  %t724 = extractvalue %Statement %statement, 0
  %t725 = alloca %Statement
  store %Statement %statement, %Statement* %t725
  %t726 = getelementptr inbounds %Statement, %Statement* %t725, i32 0, i32 1
  %t727 = bitcast [48 x i8]* %t726 to i8*
  %t728 = getelementptr inbounds i8, i8* %t727, i64 8
  %t729 = bitcast i8* %t728 to %SourceSpan**
  %t730 = load %SourceSpan*, %SourceSpan** %t729
  %t731 = icmp eq i32 %t724, 3
  %t732 = select i1 %t731, %SourceSpan* %t730, %SourceSpan* null
  %t733 = getelementptr inbounds %Statement, %Statement* %t725, i32 0, i32 1
  %t734 = bitcast [40 x i8]* %t733 to i8*
  %t735 = getelementptr inbounds i8, i8* %t734, i64 8
  %t736 = bitcast i8* %t735 to %SourceSpan**
  %t737 = load %SourceSpan*, %SourceSpan** %t736
  %t738 = icmp eq i32 %t724, 6
  %t739 = select i1 %t738, %SourceSpan* %t737, %SourceSpan* %t732
  %t740 = getelementptr inbounds %Statement, %Statement* %t725, i32 0, i32 1
  %t741 = bitcast [56 x i8]* %t740 to i8*
  %t742 = getelementptr inbounds i8, i8* %t741, i64 8
  %t743 = bitcast i8* %t742 to %SourceSpan**
  %t744 = load %SourceSpan*, %SourceSpan** %t743
  %t745 = icmp eq i32 %t724, 8
  %t746 = select i1 %t745, %SourceSpan* %t744, %SourceSpan* %t739
  %t747 = getelementptr inbounds %Statement, %Statement* %t725, i32 0, i32 1
  %t748 = bitcast [40 x i8]* %t747 to i8*
  %t749 = getelementptr inbounds i8, i8* %t748, i64 8
  %t750 = bitcast i8* %t749 to %SourceSpan**
  %t751 = load %SourceSpan*, %SourceSpan** %t750
  %t752 = icmp eq i32 %t724, 9
  %t753 = select i1 %t752, %SourceSpan* %t751, %SourceSpan* %t746
  %t754 = getelementptr inbounds %Statement, %Statement* %t725, i32 0, i32 1
  %t755 = bitcast [40 x i8]* %t754 to i8*
  %t756 = getelementptr inbounds i8, i8* %t755, i64 8
  %t757 = bitcast i8* %t756 to %SourceSpan**
  %t758 = load %SourceSpan*, %SourceSpan** %t757
  %t759 = icmp eq i32 %t724, 10
  %t760 = select i1 %t759, %SourceSpan* %t758, %SourceSpan* %t753
  %t761 = getelementptr inbounds %Statement, %Statement* %t725, i32 0, i32 1
  %t762 = bitcast [40 x i8]* %t761 to i8*
  %t763 = getelementptr inbounds i8, i8* %t762, i64 8
  %t764 = bitcast i8* %t763 to %SourceSpan**
  %t765 = load %SourceSpan*, %SourceSpan** %t764
  %t766 = icmp eq i32 %t724, 11
  %t767 = select i1 %t766, %SourceSpan* %t765, %SourceSpan* %t760
  %t768 = call %SymbolCollectionResult @register_symbol(i8* %t722, i8* %s723, %SourceSpan* %t767, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t768
merge9:
  %t769 = extractvalue %Statement %statement, 0
  %t770 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t771 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t772 = icmp eq i32 %t769, 0
  %t773 = select i1 %t772, i8* %t771, i8* %t770
  %t774 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t775 = icmp eq i32 %t769, 1
  %t776 = select i1 %t775, i8* %t774, i8* %t773
  %t777 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t778 = icmp eq i32 %t769, 2
  %t779 = select i1 %t778, i8* %t777, i8* %t776
  %t780 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t781 = icmp eq i32 %t769, 3
  %t782 = select i1 %t781, i8* %t780, i8* %t779
  %t783 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t784 = icmp eq i32 %t769, 4
  %t785 = select i1 %t784, i8* %t783, i8* %t782
  %t786 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t787 = icmp eq i32 %t769, 5
  %t788 = select i1 %t787, i8* %t786, i8* %t785
  %t789 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t790 = icmp eq i32 %t769, 6
  %t791 = select i1 %t790, i8* %t789, i8* %t788
  %t792 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t793 = icmp eq i32 %t769, 7
  %t794 = select i1 %t793, i8* %t792, i8* %t791
  %t795 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t796 = icmp eq i32 %t769, 8
  %t797 = select i1 %t796, i8* %t795, i8* %t794
  %t798 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t799 = icmp eq i32 %t769, 9
  %t800 = select i1 %t799, i8* %t798, i8* %t797
  %t801 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t802 = icmp eq i32 %t769, 10
  %t803 = select i1 %t802, i8* %t801, i8* %t800
  %t804 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t805 = icmp eq i32 %t769, 11
  %t806 = select i1 %t805, i8* %t804, i8* %t803
  %t807 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t808 = icmp eq i32 %t769, 12
  %t809 = select i1 %t808, i8* %t807, i8* %t806
  %t810 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t811 = icmp eq i32 %t769, 13
  %t812 = select i1 %t811, i8* %t810, i8* %t809
  %t813 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t814 = icmp eq i32 %t769, 14
  %t815 = select i1 %t814, i8* %t813, i8* %t812
  %t816 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t817 = icmp eq i32 %t769, 15
  %t818 = select i1 %t817, i8* %t816, i8* %t815
  %t819 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t820 = icmp eq i32 %t769, 16
  %t821 = select i1 %t820, i8* %t819, i8* %t818
  %t822 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t823 = icmp eq i32 %t769, 17
  %t824 = select i1 %t823, i8* %t822, i8* %t821
  %t825 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t826 = icmp eq i32 %t769, 18
  %t827 = select i1 %t826, i8* %t825, i8* %t824
  %t828 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t829 = icmp eq i32 %t769, 19
  %t830 = select i1 %t829, i8* %t828, i8* %t827
  %t831 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t832 = icmp eq i32 %t769, 20
  %t833 = select i1 %t832, i8* %t831, i8* %t830
  %t834 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t835 = icmp eq i32 %t769, 21
  %t836 = select i1 %t835, i8* %t834, i8* %t833
  %t837 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t838 = icmp eq i32 %t769, 22
  %t839 = select i1 %t838, i8* %t837, i8* %t836
  %s840 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h479148896, i32 0, i32 0
  %t841 = call i1 @strings_equal(i8* %t839, i8* %s840)
  br i1 %t841, label %then10, label %merge11
then10:
  %t842 = extractvalue %Statement %statement, 0
  %t843 = alloca %Statement
  store %Statement %statement, %Statement* %t843
  %t844 = getelementptr inbounds %Statement, %Statement* %t843, i32 0, i32 1
  %t845 = bitcast [24 x i8]* %t844 to i8*
  %t846 = bitcast i8* %t845 to %FunctionSignature*
  %t847 = load %FunctionSignature, %FunctionSignature* %t846
  %t848 = icmp eq i32 %t842, 4
  %t849 = select i1 %t848, %FunctionSignature %t847, %FunctionSignature zeroinitializer
  %t850 = getelementptr inbounds %Statement, %Statement* %t843, i32 0, i32 1
  %t851 = bitcast [24 x i8]* %t850 to i8*
  %t852 = bitcast i8* %t851 to %FunctionSignature*
  %t853 = load %FunctionSignature, %FunctionSignature* %t852
  %t854 = icmp eq i32 %t842, 5
  %t855 = select i1 %t854, %FunctionSignature %t853, %FunctionSignature %t849
  %t856 = getelementptr inbounds %Statement, %Statement* %t843, i32 0, i32 1
  %t857 = bitcast [24 x i8]* %t856 to i8*
  %t858 = bitcast i8* %t857 to %FunctionSignature*
  %t859 = load %FunctionSignature, %FunctionSignature* %t858
  %t860 = icmp eq i32 %t842, 7
  %t861 = select i1 %t860, %FunctionSignature %t859, %FunctionSignature %t855
  %t862 = extractvalue %FunctionSignature %t861, 0
  %s863 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h2003786807, i32 0, i32 0
  %t864 = extractvalue %Statement %statement, 0
  %t865 = alloca %Statement
  store %Statement %statement, %Statement* %t865
  %t866 = getelementptr inbounds %Statement, %Statement* %t865, i32 0, i32 1
  %t867 = bitcast [24 x i8]* %t866 to i8*
  %t868 = bitcast i8* %t867 to %FunctionSignature*
  %t869 = load %FunctionSignature, %FunctionSignature* %t868
  %t870 = icmp eq i32 %t864, 4
  %t871 = select i1 %t870, %FunctionSignature %t869, %FunctionSignature zeroinitializer
  %t872 = getelementptr inbounds %Statement, %Statement* %t865, i32 0, i32 1
  %t873 = bitcast [24 x i8]* %t872 to i8*
  %t874 = bitcast i8* %t873 to %FunctionSignature*
  %t875 = load %FunctionSignature, %FunctionSignature* %t874
  %t876 = icmp eq i32 %t864, 5
  %t877 = select i1 %t876, %FunctionSignature %t875, %FunctionSignature %t871
  %t878 = getelementptr inbounds %Statement, %Statement* %t865, i32 0, i32 1
  %t879 = bitcast [24 x i8]* %t878 to i8*
  %t880 = bitcast i8* %t879 to %FunctionSignature*
  %t881 = load %FunctionSignature, %FunctionSignature* %t880
  %t882 = icmp eq i32 %t864, 7
  %t883 = select i1 %t882, %FunctionSignature %t881, %FunctionSignature %t877
  %t884 = extractvalue %FunctionSignature %t883, 6
  %t885 = call %SymbolCollectionResult @register_symbol(i8* %t862, i8* %s863, %SourceSpan* %t884, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t885
merge11:
  %t886 = extractvalue %Statement %statement, 0
  %t887 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t888 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t889 = icmp eq i32 %t886, 0
  %t890 = select i1 %t889, i8* %t888, i8* %t887
  %t891 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t892 = icmp eq i32 %t886, 1
  %t893 = select i1 %t892, i8* %t891, i8* %t890
  %t894 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t895 = icmp eq i32 %t886, 2
  %t896 = select i1 %t895, i8* %t894, i8* %t893
  %t897 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t898 = icmp eq i32 %t886, 3
  %t899 = select i1 %t898, i8* %t897, i8* %t896
  %t900 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t901 = icmp eq i32 %t886, 4
  %t902 = select i1 %t901, i8* %t900, i8* %t899
  %t903 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t904 = icmp eq i32 %t886, 5
  %t905 = select i1 %t904, i8* %t903, i8* %t902
  %t906 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t907 = icmp eq i32 %t886, 6
  %t908 = select i1 %t907, i8* %t906, i8* %t905
  %t909 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t910 = icmp eq i32 %t886, 7
  %t911 = select i1 %t910, i8* %t909, i8* %t908
  %t912 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t913 = icmp eq i32 %t886, 8
  %t914 = select i1 %t913, i8* %t912, i8* %t911
  %t915 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t916 = icmp eq i32 %t886, 9
  %t917 = select i1 %t916, i8* %t915, i8* %t914
  %t918 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t919 = icmp eq i32 %t886, 10
  %t920 = select i1 %t919, i8* %t918, i8* %t917
  %t921 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t922 = icmp eq i32 %t886, 11
  %t923 = select i1 %t922, i8* %t921, i8* %t920
  %t924 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t925 = icmp eq i32 %t886, 12
  %t926 = select i1 %t925, i8* %t924, i8* %t923
  %t927 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t928 = icmp eq i32 %t886, 13
  %t929 = select i1 %t928, i8* %t927, i8* %t926
  %t930 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t931 = icmp eq i32 %t886, 14
  %t932 = select i1 %t931, i8* %t930, i8* %t929
  %t933 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t934 = icmp eq i32 %t886, 15
  %t935 = select i1 %t934, i8* %t933, i8* %t932
  %t936 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t937 = icmp eq i32 %t886, 16
  %t938 = select i1 %t937, i8* %t936, i8* %t935
  %t939 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t940 = icmp eq i32 %t886, 17
  %t941 = select i1 %t940, i8* %t939, i8* %t938
  %t942 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t943 = icmp eq i32 %t886, 18
  %t944 = select i1 %t943, i8* %t942, i8* %t941
  %t945 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t946 = icmp eq i32 %t886, 19
  %t947 = select i1 %t946, i8* %t945, i8* %t944
  %t948 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t949 = icmp eq i32 %t886, 20
  %t950 = select i1 %t949, i8* %t948, i8* %t947
  %t951 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t952 = icmp eq i32 %t886, 21
  %t953 = select i1 %t952, i8* %t951, i8* %t950
  %t954 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t955 = icmp eq i32 %t886, 22
  %t956 = select i1 %t955, i8* %t954, i8* %t953
  %s957 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h571715647, i32 0, i32 0
  %t958 = call i1 @strings_equal(i8* %t956, i8* %s957)
  br i1 %t958, label %then12, label %merge13
then12:
  %t959 = extractvalue %Statement %statement, 0
  %t960 = alloca %Statement
  store %Statement %statement, %Statement* %t960
  %t961 = getelementptr inbounds %Statement, %Statement* %t960, i32 0, i32 1
  %t962 = bitcast [24 x i8]* %t961 to i8*
  %t963 = bitcast i8* %t962 to %FunctionSignature*
  %t964 = load %FunctionSignature, %FunctionSignature* %t963
  %t965 = icmp eq i32 %t959, 4
  %t966 = select i1 %t965, %FunctionSignature %t964, %FunctionSignature zeroinitializer
  %t967 = getelementptr inbounds %Statement, %Statement* %t960, i32 0, i32 1
  %t968 = bitcast [24 x i8]* %t967 to i8*
  %t969 = bitcast i8* %t968 to %FunctionSignature*
  %t970 = load %FunctionSignature, %FunctionSignature* %t969
  %t971 = icmp eq i32 %t959, 5
  %t972 = select i1 %t971, %FunctionSignature %t970, %FunctionSignature %t966
  %t973 = getelementptr inbounds %Statement, %Statement* %t960, i32 0, i32 1
  %t974 = bitcast [24 x i8]* %t973 to i8*
  %t975 = bitcast i8* %t974 to %FunctionSignature*
  %t976 = load %FunctionSignature, %FunctionSignature* %t975
  %t977 = icmp eq i32 %t959, 7
  %t978 = select i1 %t977, %FunctionSignature %t976, %FunctionSignature %t972
  %t979 = extractvalue %FunctionSignature %t978, 0
  %s980 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275832617, i32 0, i32 0
  %t981 = extractvalue %Statement %statement, 0
  %t982 = alloca %Statement
  store %Statement %statement, %Statement* %t982
  %t983 = getelementptr inbounds %Statement, %Statement* %t982, i32 0, i32 1
  %t984 = bitcast [24 x i8]* %t983 to i8*
  %t985 = bitcast i8* %t984 to %FunctionSignature*
  %t986 = load %FunctionSignature, %FunctionSignature* %t985
  %t987 = icmp eq i32 %t981, 4
  %t988 = select i1 %t987, %FunctionSignature %t986, %FunctionSignature zeroinitializer
  %t989 = getelementptr inbounds %Statement, %Statement* %t982, i32 0, i32 1
  %t990 = bitcast [24 x i8]* %t989 to i8*
  %t991 = bitcast i8* %t990 to %FunctionSignature*
  %t992 = load %FunctionSignature, %FunctionSignature* %t991
  %t993 = icmp eq i32 %t981, 5
  %t994 = select i1 %t993, %FunctionSignature %t992, %FunctionSignature %t988
  %t995 = getelementptr inbounds %Statement, %Statement* %t982, i32 0, i32 1
  %t996 = bitcast [24 x i8]* %t995 to i8*
  %t997 = bitcast i8* %t996 to %FunctionSignature*
  %t998 = load %FunctionSignature, %FunctionSignature* %t997
  %t999 = icmp eq i32 %t981, 7
  %t1000 = select i1 %t999, %FunctionSignature %t998, %FunctionSignature %t994
  %t1001 = extractvalue %FunctionSignature %t1000, 6
  %t1002 = call %SymbolCollectionResult @register_symbol(i8* %t979, i8* %s980, %SourceSpan* %t1001, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1002
merge13:
  %t1003 = extractvalue %Statement %statement, 0
  %t1004 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1005 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1006 = icmp eq i32 %t1003, 0
  %t1007 = select i1 %t1006, i8* %t1005, i8* %t1004
  %t1008 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1009 = icmp eq i32 %t1003, 1
  %t1010 = select i1 %t1009, i8* %t1008, i8* %t1007
  %t1011 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1012 = icmp eq i32 %t1003, 2
  %t1013 = select i1 %t1012, i8* %t1011, i8* %t1010
  %t1014 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1015 = icmp eq i32 %t1003, 3
  %t1016 = select i1 %t1015, i8* %t1014, i8* %t1013
  %t1017 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1018 = icmp eq i32 %t1003, 4
  %t1019 = select i1 %t1018, i8* %t1017, i8* %t1016
  %t1020 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1021 = icmp eq i32 %t1003, 5
  %t1022 = select i1 %t1021, i8* %t1020, i8* %t1019
  %t1023 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1024 = icmp eq i32 %t1003, 6
  %t1025 = select i1 %t1024, i8* %t1023, i8* %t1022
  %t1026 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1027 = icmp eq i32 %t1003, 7
  %t1028 = select i1 %t1027, i8* %t1026, i8* %t1025
  %t1029 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1030 = icmp eq i32 %t1003, 8
  %t1031 = select i1 %t1030, i8* %t1029, i8* %t1028
  %t1032 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1033 = icmp eq i32 %t1003, 9
  %t1034 = select i1 %t1033, i8* %t1032, i8* %t1031
  %t1035 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1036 = icmp eq i32 %t1003, 10
  %t1037 = select i1 %t1036, i8* %t1035, i8* %t1034
  %t1038 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1039 = icmp eq i32 %t1003, 11
  %t1040 = select i1 %t1039, i8* %t1038, i8* %t1037
  %t1041 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1042 = icmp eq i32 %t1003, 12
  %t1043 = select i1 %t1042, i8* %t1041, i8* %t1040
  %t1044 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1045 = icmp eq i32 %t1003, 13
  %t1046 = select i1 %t1045, i8* %t1044, i8* %t1043
  %t1047 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1048 = icmp eq i32 %t1003, 14
  %t1049 = select i1 %t1048, i8* %t1047, i8* %t1046
  %t1050 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1051 = icmp eq i32 %t1003, 15
  %t1052 = select i1 %t1051, i8* %t1050, i8* %t1049
  %t1053 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1054 = icmp eq i32 %t1003, 16
  %t1055 = select i1 %t1054, i8* %t1053, i8* %t1052
  %t1056 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1057 = icmp eq i32 %t1003, 17
  %t1058 = select i1 %t1057, i8* %t1056, i8* %t1055
  %t1059 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1060 = icmp eq i32 %t1003, 18
  %t1061 = select i1 %t1060, i8* %t1059, i8* %t1058
  %t1062 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1063 = icmp eq i32 %t1003, 19
  %t1064 = select i1 %t1063, i8* %t1062, i8* %t1061
  %t1065 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1066 = icmp eq i32 %t1003, 20
  %t1067 = select i1 %t1066, i8* %t1065, i8* %t1064
  %t1068 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1069 = icmp eq i32 %t1003, 21
  %t1070 = select i1 %t1069, i8* %t1068, i8* %t1067
  %t1071 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1072 = icmp eq i32 %t1003, 22
  %t1073 = select i1 %t1072, i8* %t1071, i8* %t1070
  %s1074 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h889179835, i32 0, i32 0
  %t1075 = call i1 @strings_equal(i8* %t1073, i8* %s1074)
  br i1 %t1075, label %then14, label %merge15
then14:
  %t1076 = extractvalue %Statement %statement, 0
  %t1077 = alloca %Statement
  store %Statement %statement, %Statement* %t1077
  %t1078 = getelementptr inbounds %Statement, %Statement* %t1077, i32 0, i32 1
  %t1079 = bitcast [48 x i8]* %t1078 to i8*
  %t1080 = bitcast i8* %t1079 to i8**
  %t1081 = load i8*, i8** %t1080
  %t1082 = icmp eq i32 %t1076, 2
  %t1083 = select i1 %t1082, i8* %t1081, i8* null
  %t1084 = getelementptr inbounds %Statement, %Statement* %t1077, i32 0, i32 1
  %t1085 = bitcast [48 x i8]* %t1084 to i8*
  %t1086 = bitcast i8* %t1085 to i8**
  %t1087 = load i8*, i8** %t1086
  %t1088 = icmp eq i32 %t1076, 3
  %t1089 = select i1 %t1088, i8* %t1087, i8* %t1083
  %t1090 = getelementptr inbounds %Statement, %Statement* %t1077, i32 0, i32 1
  %t1091 = bitcast [40 x i8]* %t1090 to i8*
  %t1092 = bitcast i8* %t1091 to i8**
  %t1093 = load i8*, i8** %t1092
  %t1094 = icmp eq i32 %t1076, 6
  %t1095 = select i1 %t1094, i8* %t1093, i8* %t1089
  %t1096 = getelementptr inbounds %Statement, %Statement* %t1077, i32 0, i32 1
  %t1097 = bitcast [56 x i8]* %t1096 to i8*
  %t1098 = bitcast i8* %t1097 to i8**
  %t1099 = load i8*, i8** %t1098
  %t1100 = icmp eq i32 %t1076, 8
  %t1101 = select i1 %t1100, i8* %t1099, i8* %t1095
  %t1102 = getelementptr inbounds %Statement, %Statement* %t1077, i32 0, i32 1
  %t1103 = bitcast [40 x i8]* %t1102 to i8*
  %t1104 = bitcast i8* %t1103 to i8**
  %t1105 = load i8*, i8** %t1104
  %t1106 = icmp eq i32 %t1076, 9
  %t1107 = select i1 %t1106, i8* %t1105, i8* %t1101
  %t1108 = getelementptr inbounds %Statement, %Statement* %t1077, i32 0, i32 1
  %t1109 = bitcast [40 x i8]* %t1108 to i8*
  %t1110 = bitcast i8* %t1109 to i8**
  %t1111 = load i8*, i8** %t1110
  %t1112 = icmp eq i32 %t1076, 10
  %t1113 = select i1 %t1112, i8* %t1111, i8* %t1107
  %t1114 = getelementptr inbounds %Statement, %Statement* %t1077, i32 0, i32 1
  %t1115 = bitcast [40 x i8]* %t1114 to i8*
  %t1116 = bitcast i8* %t1115 to i8**
  %t1117 = load i8*, i8** %t1116
  %t1118 = icmp eq i32 %t1076, 11
  %t1119 = select i1 %t1118, i8* %t1117, i8* %t1113
  %s1120 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275477867, i32 0, i32 0
  %t1121 = extractvalue %Statement %statement, 0
  %t1122 = alloca %Statement
  store %Statement %statement, %Statement* %t1122
  %t1123 = getelementptr inbounds %Statement, %Statement* %t1122, i32 0, i32 1
  %t1124 = bitcast [48 x i8]* %t1123 to i8*
  %t1125 = getelementptr inbounds i8, i8* %t1124, i64 8
  %t1126 = bitcast i8* %t1125 to %SourceSpan**
  %t1127 = load %SourceSpan*, %SourceSpan** %t1126
  %t1128 = icmp eq i32 %t1121, 3
  %t1129 = select i1 %t1128, %SourceSpan* %t1127, %SourceSpan* null
  %t1130 = getelementptr inbounds %Statement, %Statement* %t1122, i32 0, i32 1
  %t1131 = bitcast [40 x i8]* %t1130 to i8*
  %t1132 = getelementptr inbounds i8, i8* %t1131, i64 8
  %t1133 = bitcast i8* %t1132 to %SourceSpan**
  %t1134 = load %SourceSpan*, %SourceSpan** %t1133
  %t1135 = icmp eq i32 %t1121, 6
  %t1136 = select i1 %t1135, %SourceSpan* %t1134, %SourceSpan* %t1129
  %t1137 = getelementptr inbounds %Statement, %Statement* %t1122, i32 0, i32 1
  %t1138 = bitcast [56 x i8]* %t1137 to i8*
  %t1139 = getelementptr inbounds i8, i8* %t1138, i64 8
  %t1140 = bitcast i8* %t1139 to %SourceSpan**
  %t1141 = load %SourceSpan*, %SourceSpan** %t1140
  %t1142 = icmp eq i32 %t1121, 8
  %t1143 = select i1 %t1142, %SourceSpan* %t1141, %SourceSpan* %t1136
  %t1144 = getelementptr inbounds %Statement, %Statement* %t1122, i32 0, i32 1
  %t1145 = bitcast [40 x i8]* %t1144 to i8*
  %t1146 = getelementptr inbounds i8, i8* %t1145, i64 8
  %t1147 = bitcast i8* %t1146 to %SourceSpan**
  %t1148 = load %SourceSpan*, %SourceSpan** %t1147
  %t1149 = icmp eq i32 %t1121, 9
  %t1150 = select i1 %t1149, %SourceSpan* %t1148, %SourceSpan* %t1143
  %t1151 = getelementptr inbounds %Statement, %Statement* %t1122, i32 0, i32 1
  %t1152 = bitcast [40 x i8]* %t1151 to i8*
  %t1153 = getelementptr inbounds i8, i8* %t1152, i64 8
  %t1154 = bitcast i8* %t1153 to %SourceSpan**
  %t1155 = load %SourceSpan*, %SourceSpan** %t1154
  %t1156 = icmp eq i32 %t1121, 10
  %t1157 = select i1 %t1156, %SourceSpan* %t1155, %SourceSpan* %t1150
  %t1158 = getelementptr inbounds %Statement, %Statement* %t1122, i32 0, i32 1
  %t1159 = bitcast [40 x i8]* %t1158 to i8*
  %t1160 = getelementptr inbounds i8, i8* %t1159, i64 8
  %t1161 = bitcast i8* %t1160 to %SourceSpan**
  %t1162 = load %SourceSpan*, %SourceSpan** %t1161
  %t1163 = icmp eq i32 %t1121, 11
  %t1164 = select i1 %t1163, %SourceSpan* %t1162, %SourceSpan* %t1157
  %t1165 = call %SymbolCollectionResult @register_symbol(i8* %t1119, i8* %s1120, %SourceSpan* %t1164, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1165
merge15:
  %t1166 = extractvalue %Statement %statement, 0
  %t1167 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1168 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1169 = icmp eq i32 %t1166, 0
  %t1170 = select i1 %t1169, i8* %t1168, i8* %t1167
  %t1171 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1172 = icmp eq i32 %t1166, 1
  %t1173 = select i1 %t1172, i8* %t1171, i8* %t1170
  %t1174 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1175 = icmp eq i32 %t1166, 2
  %t1176 = select i1 %t1175, i8* %t1174, i8* %t1173
  %t1177 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1178 = icmp eq i32 %t1166, 3
  %t1179 = select i1 %t1178, i8* %t1177, i8* %t1176
  %t1180 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1181 = icmp eq i32 %t1166, 4
  %t1182 = select i1 %t1181, i8* %t1180, i8* %t1179
  %t1183 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1184 = icmp eq i32 %t1166, 5
  %t1185 = select i1 %t1184, i8* %t1183, i8* %t1182
  %t1186 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1187 = icmp eq i32 %t1166, 6
  %t1188 = select i1 %t1187, i8* %t1186, i8* %t1185
  %t1189 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1190 = icmp eq i32 %t1166, 7
  %t1191 = select i1 %t1190, i8* %t1189, i8* %t1188
  %t1192 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1193 = icmp eq i32 %t1166, 8
  %t1194 = select i1 %t1193, i8* %t1192, i8* %t1191
  %t1195 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1196 = icmp eq i32 %t1166, 9
  %t1197 = select i1 %t1196, i8* %t1195, i8* %t1194
  %t1198 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1199 = icmp eq i32 %t1166, 10
  %t1200 = select i1 %t1199, i8* %t1198, i8* %t1197
  %t1201 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1202 = icmp eq i32 %t1166, 11
  %t1203 = select i1 %t1202, i8* %t1201, i8* %t1200
  %t1204 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1205 = icmp eq i32 %t1166, 12
  %t1206 = select i1 %t1205, i8* %t1204, i8* %t1203
  %t1207 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1208 = icmp eq i32 %t1166, 13
  %t1209 = select i1 %t1208, i8* %t1207, i8* %t1206
  %t1210 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1211 = icmp eq i32 %t1166, 14
  %t1212 = select i1 %t1211, i8* %t1210, i8* %t1209
  %t1213 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1214 = icmp eq i32 %t1166, 15
  %t1215 = select i1 %t1214, i8* %t1213, i8* %t1212
  %t1216 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1217 = icmp eq i32 %t1166, 16
  %t1218 = select i1 %t1217, i8* %t1216, i8* %t1215
  %t1219 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1220 = icmp eq i32 %t1166, 17
  %t1221 = select i1 %t1220, i8* %t1219, i8* %t1218
  %t1222 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1223 = icmp eq i32 %t1166, 18
  %t1224 = select i1 %t1223, i8* %t1222, i8* %t1221
  %t1225 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1226 = icmp eq i32 %t1166, 19
  %t1227 = select i1 %t1226, i8* %t1225, i8* %t1224
  %t1228 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1229 = icmp eq i32 %t1166, 20
  %t1230 = select i1 %t1229, i8* %t1228, i8* %t1227
  %t1231 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1232 = icmp eq i32 %t1166, 21
  %t1233 = select i1 %t1232, i8* %t1231, i8* %t1230
  %t1234 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1235 = icmp eq i32 %t1166, 22
  %t1236 = select i1 %t1235, i8* %t1234, i8* %t1233
  %s1237 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1496093543, i32 0, i32 0
  %t1238 = call i1 @strings_equal(i8* %t1236, i8* %s1237)
  br i1 %t1238, label %then16, label %merge17
then16:
  %t1239 = extractvalue %Statement %statement, 0
  %t1240 = alloca %Statement
  store %Statement %statement, %Statement* %t1240
  %t1241 = getelementptr inbounds %Statement, %Statement* %t1240, i32 0, i32 1
  %t1242 = bitcast [48 x i8]* %t1241 to i8*
  %t1243 = bitcast i8* %t1242 to i8**
  %t1244 = load i8*, i8** %t1243
  %t1245 = icmp eq i32 %t1239, 2
  %t1246 = select i1 %t1245, i8* %t1244, i8* null
  %t1247 = getelementptr inbounds %Statement, %Statement* %t1240, i32 0, i32 1
  %t1248 = bitcast [48 x i8]* %t1247 to i8*
  %t1249 = bitcast i8* %t1248 to i8**
  %t1250 = load i8*, i8** %t1249
  %t1251 = icmp eq i32 %t1239, 3
  %t1252 = select i1 %t1251, i8* %t1250, i8* %t1246
  %t1253 = getelementptr inbounds %Statement, %Statement* %t1240, i32 0, i32 1
  %t1254 = bitcast [40 x i8]* %t1253 to i8*
  %t1255 = bitcast i8* %t1254 to i8**
  %t1256 = load i8*, i8** %t1255
  %t1257 = icmp eq i32 %t1239, 6
  %t1258 = select i1 %t1257, i8* %t1256, i8* %t1252
  %t1259 = getelementptr inbounds %Statement, %Statement* %t1240, i32 0, i32 1
  %t1260 = bitcast [56 x i8]* %t1259 to i8*
  %t1261 = bitcast i8* %t1260 to i8**
  %t1262 = load i8*, i8** %t1261
  %t1263 = icmp eq i32 %t1239, 8
  %t1264 = select i1 %t1263, i8* %t1262, i8* %t1258
  %t1265 = getelementptr inbounds %Statement, %Statement* %t1240, i32 0, i32 1
  %t1266 = bitcast [40 x i8]* %t1265 to i8*
  %t1267 = bitcast i8* %t1266 to i8**
  %t1268 = load i8*, i8** %t1267
  %t1269 = icmp eq i32 %t1239, 9
  %t1270 = select i1 %t1269, i8* %t1268, i8* %t1264
  %t1271 = getelementptr inbounds %Statement, %Statement* %t1240, i32 0, i32 1
  %t1272 = bitcast [40 x i8]* %t1271 to i8*
  %t1273 = bitcast i8* %t1272 to i8**
  %t1274 = load i8*, i8** %t1273
  %t1275 = icmp eq i32 %t1239, 10
  %t1276 = select i1 %t1275, i8* %t1274, i8* %t1270
  %t1277 = getelementptr inbounds %Statement, %Statement* %t1240, i32 0, i32 1
  %t1278 = bitcast [40 x i8]* %t1277 to i8*
  %t1279 = bitcast i8* %t1278 to i8**
  %t1280 = load i8*, i8** %t1279
  %t1281 = icmp eq i32 %t1239, 11
  %t1282 = select i1 %t1281, i8* %t1280, i8* %t1276
  %s1283 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h276192845, i32 0, i32 0
  %t1284 = extractvalue %Statement %statement, 0
  %t1285 = alloca %Statement
  store %Statement %statement, %Statement* %t1285
  %t1286 = getelementptr inbounds %Statement, %Statement* %t1285, i32 0, i32 1
  %t1287 = bitcast [48 x i8]* %t1286 to i8*
  %t1288 = getelementptr inbounds i8, i8* %t1287, i64 8
  %t1289 = bitcast i8* %t1288 to %SourceSpan**
  %t1290 = load %SourceSpan*, %SourceSpan** %t1289
  %t1291 = icmp eq i32 %t1284, 3
  %t1292 = select i1 %t1291, %SourceSpan* %t1290, %SourceSpan* null
  %t1293 = getelementptr inbounds %Statement, %Statement* %t1285, i32 0, i32 1
  %t1294 = bitcast [40 x i8]* %t1293 to i8*
  %t1295 = getelementptr inbounds i8, i8* %t1294, i64 8
  %t1296 = bitcast i8* %t1295 to %SourceSpan**
  %t1297 = load %SourceSpan*, %SourceSpan** %t1296
  %t1298 = icmp eq i32 %t1284, 6
  %t1299 = select i1 %t1298, %SourceSpan* %t1297, %SourceSpan* %t1292
  %t1300 = getelementptr inbounds %Statement, %Statement* %t1285, i32 0, i32 1
  %t1301 = bitcast [56 x i8]* %t1300 to i8*
  %t1302 = getelementptr inbounds i8, i8* %t1301, i64 8
  %t1303 = bitcast i8* %t1302 to %SourceSpan**
  %t1304 = load %SourceSpan*, %SourceSpan** %t1303
  %t1305 = icmp eq i32 %t1284, 8
  %t1306 = select i1 %t1305, %SourceSpan* %t1304, %SourceSpan* %t1299
  %t1307 = getelementptr inbounds %Statement, %Statement* %t1285, i32 0, i32 1
  %t1308 = bitcast [40 x i8]* %t1307 to i8*
  %t1309 = getelementptr inbounds i8, i8* %t1308, i64 8
  %t1310 = bitcast i8* %t1309 to %SourceSpan**
  %t1311 = load %SourceSpan*, %SourceSpan** %t1310
  %t1312 = icmp eq i32 %t1284, 9
  %t1313 = select i1 %t1312, %SourceSpan* %t1311, %SourceSpan* %t1306
  %t1314 = getelementptr inbounds %Statement, %Statement* %t1285, i32 0, i32 1
  %t1315 = bitcast [40 x i8]* %t1314 to i8*
  %t1316 = getelementptr inbounds i8, i8* %t1315, i64 8
  %t1317 = bitcast i8* %t1316 to %SourceSpan**
  %t1318 = load %SourceSpan*, %SourceSpan** %t1317
  %t1319 = icmp eq i32 %t1284, 10
  %t1320 = select i1 %t1319, %SourceSpan* %t1318, %SourceSpan* %t1313
  %t1321 = getelementptr inbounds %Statement, %Statement* %t1285, i32 0, i32 1
  %t1322 = bitcast [40 x i8]* %t1321 to i8*
  %t1323 = getelementptr inbounds i8, i8* %t1322, i64 8
  %t1324 = bitcast i8* %t1323 to %SourceSpan**
  %t1325 = load %SourceSpan*, %SourceSpan** %t1324
  %t1326 = icmp eq i32 %t1284, 11
  %t1327 = select i1 %t1326, %SourceSpan* %t1325, %SourceSpan* %t1320
  %t1328 = call %SymbolCollectionResult @register_symbol(i8* %t1282, i8* %s1283, %SourceSpan* %t1327, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1328
merge17:
  %t1329 = extractvalue %Statement %statement, 0
  %t1330 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1331 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1332 = icmp eq i32 %t1329, 0
  %t1333 = select i1 %t1332, i8* %t1331, i8* %t1330
  %t1334 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1335 = icmp eq i32 %t1329, 1
  %t1336 = select i1 %t1335, i8* %t1334, i8* %t1333
  %t1337 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1338 = icmp eq i32 %t1329, 2
  %t1339 = select i1 %t1338, i8* %t1337, i8* %t1336
  %t1340 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1341 = icmp eq i32 %t1329, 3
  %t1342 = select i1 %t1341, i8* %t1340, i8* %t1339
  %t1343 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1344 = icmp eq i32 %t1329, 4
  %t1345 = select i1 %t1344, i8* %t1343, i8* %t1342
  %t1346 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1347 = icmp eq i32 %t1329, 5
  %t1348 = select i1 %t1347, i8* %t1346, i8* %t1345
  %t1349 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1350 = icmp eq i32 %t1329, 6
  %t1351 = select i1 %t1350, i8* %t1349, i8* %t1348
  %t1352 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1353 = icmp eq i32 %t1329, 7
  %t1354 = select i1 %t1353, i8* %t1352, i8* %t1351
  %t1355 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1356 = icmp eq i32 %t1329, 8
  %t1357 = select i1 %t1356, i8* %t1355, i8* %t1354
  %t1358 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1359 = icmp eq i32 %t1329, 9
  %t1360 = select i1 %t1359, i8* %t1358, i8* %t1357
  %t1361 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1362 = icmp eq i32 %t1329, 10
  %t1363 = select i1 %t1362, i8* %t1361, i8* %t1360
  %t1364 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1365 = icmp eq i32 %t1329, 11
  %t1366 = select i1 %t1365, i8* %t1364, i8* %t1363
  %t1367 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1368 = icmp eq i32 %t1329, 12
  %t1369 = select i1 %t1368, i8* %t1367, i8* %t1366
  %t1370 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1371 = icmp eq i32 %t1329, 13
  %t1372 = select i1 %t1371, i8* %t1370, i8* %t1369
  %t1373 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1374 = icmp eq i32 %t1329, 14
  %t1375 = select i1 %t1374, i8* %t1373, i8* %t1372
  %t1376 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1377 = icmp eq i32 %t1329, 15
  %t1378 = select i1 %t1377, i8* %t1376, i8* %t1375
  %t1379 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1380 = icmp eq i32 %t1329, 16
  %t1381 = select i1 %t1380, i8* %t1379, i8* %t1378
  %t1382 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1383 = icmp eq i32 %t1329, 17
  %t1384 = select i1 %t1383, i8* %t1382, i8* %t1381
  %t1385 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1386 = icmp eq i32 %t1329, 18
  %t1387 = select i1 %t1386, i8* %t1385, i8* %t1384
  %t1388 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1389 = icmp eq i32 %t1329, 19
  %t1390 = select i1 %t1389, i8* %t1388, i8* %t1387
  %t1391 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1392 = icmp eq i32 %t1329, 20
  %t1393 = select i1 %t1392, i8* %t1391, i8* %t1390
  %t1394 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1395 = icmp eq i32 %t1329, 21
  %t1396 = select i1 %t1395, i8* %t1394, i8* %t1393
  %t1397 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1398 = icmp eq i32 %t1329, 22
  %t1399 = select i1 %t1398, i8* %t1397, i8* %t1396
  %s1400 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1204027478, i32 0, i32 0
  %t1401 = call i1 @strings_equal(i8* %t1399, i8* %s1400)
  br i1 %t1401, label %then18, label %merge19
then18:
  %t1402 = extractvalue %Statement %statement, 0
  %t1403 = alloca %Statement
  store %Statement %statement, %Statement* %t1403
  %t1404 = getelementptr inbounds %Statement, %Statement* %t1403, i32 0, i32 1
  %t1405 = bitcast [48 x i8]* %t1404 to i8*
  %t1406 = bitcast i8* %t1405 to i8**
  %t1407 = load i8*, i8** %t1406
  %t1408 = icmp eq i32 %t1402, 2
  %t1409 = select i1 %t1408, i8* %t1407, i8* null
  %t1410 = getelementptr inbounds %Statement, %Statement* %t1403, i32 0, i32 1
  %t1411 = bitcast [48 x i8]* %t1410 to i8*
  %t1412 = bitcast i8* %t1411 to i8**
  %t1413 = load i8*, i8** %t1412
  %t1414 = icmp eq i32 %t1402, 3
  %t1415 = select i1 %t1414, i8* %t1413, i8* %t1409
  %t1416 = getelementptr inbounds %Statement, %Statement* %t1403, i32 0, i32 1
  %t1417 = bitcast [40 x i8]* %t1416 to i8*
  %t1418 = bitcast i8* %t1417 to i8**
  %t1419 = load i8*, i8** %t1418
  %t1420 = icmp eq i32 %t1402, 6
  %t1421 = select i1 %t1420, i8* %t1419, i8* %t1415
  %t1422 = getelementptr inbounds %Statement, %Statement* %t1403, i32 0, i32 1
  %t1423 = bitcast [56 x i8]* %t1422 to i8*
  %t1424 = bitcast i8* %t1423 to i8**
  %t1425 = load i8*, i8** %t1424
  %t1426 = icmp eq i32 %t1402, 8
  %t1427 = select i1 %t1426, i8* %t1425, i8* %t1421
  %t1428 = getelementptr inbounds %Statement, %Statement* %t1403, i32 0, i32 1
  %t1429 = bitcast [40 x i8]* %t1428 to i8*
  %t1430 = bitcast i8* %t1429 to i8**
  %t1431 = load i8*, i8** %t1430
  %t1432 = icmp eq i32 %t1402, 9
  %t1433 = select i1 %t1432, i8* %t1431, i8* %t1427
  %t1434 = getelementptr inbounds %Statement, %Statement* %t1403, i32 0, i32 1
  %t1435 = bitcast [40 x i8]* %t1434 to i8*
  %t1436 = bitcast i8* %t1435 to i8**
  %t1437 = load i8*, i8** %t1436
  %t1438 = icmp eq i32 %t1402, 10
  %t1439 = select i1 %t1438, i8* %t1437, i8* %t1433
  %t1440 = getelementptr inbounds %Statement, %Statement* %t1403, i32 0, i32 1
  %t1441 = bitcast [40 x i8]* %t1440 to i8*
  %t1442 = bitcast i8* %t1441 to i8**
  %t1443 = load i8*, i8** %t1442
  %t1444 = icmp eq i32 %t1402, 11
  %t1445 = select i1 %t1444, i8* %t1443, i8* %t1439
  %s1446 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1925814595, i32 0, i32 0
  %t1447 = extractvalue %Statement %statement, 0
  %t1448 = alloca %Statement
  store %Statement %statement, %Statement* %t1448
  %t1449 = getelementptr inbounds %Statement, %Statement* %t1448, i32 0, i32 1
  %t1450 = bitcast [48 x i8]* %t1449 to i8*
  %t1451 = getelementptr inbounds i8, i8* %t1450, i64 32
  %t1452 = bitcast i8* %t1451 to %SourceSpan**
  %t1453 = load %SourceSpan*, %SourceSpan** %t1452
  %t1454 = icmp eq i32 %t1447, 2
  %t1455 = select i1 %t1454, %SourceSpan* %t1453, %SourceSpan* null
  %t1456 = getelementptr inbounds %Statement, %Statement* %t1448, i32 0, i32 1
  %t1457 = bitcast [16 x i8]* %t1456 to i8*
  %t1458 = getelementptr inbounds i8, i8* %t1457, i64 8
  %t1459 = bitcast i8* %t1458 to %SourceSpan**
  %t1460 = load %SourceSpan*, %SourceSpan** %t1459
  %t1461 = icmp eq i32 %t1447, 20
  %t1462 = select i1 %t1461, %SourceSpan* %t1460, %SourceSpan* %t1455
  %t1463 = getelementptr inbounds %Statement, %Statement* %t1448, i32 0, i32 1
  %t1464 = bitcast [16 x i8]* %t1463 to i8*
  %t1465 = getelementptr inbounds i8, i8* %t1464, i64 8
  %t1466 = bitcast i8* %t1465 to %SourceSpan**
  %t1467 = load %SourceSpan*, %SourceSpan** %t1466
  %t1468 = icmp eq i32 %t1447, 21
  %t1469 = select i1 %t1468, %SourceSpan* %t1467, %SourceSpan* %t1462
  %t1470 = call %SymbolCollectionResult @register_symbol(i8* %t1445, i8* %s1446, %SourceSpan* %t1469, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1470
merge19:
  %t1471 = bitcast { %SymbolEntry*, i64 }* %existing to { %SymbolEntry**, i64 }*
  %t1472 = insertvalue %SymbolCollectionResult undef, { %SymbolEntry**, i64 }* %t1471, 0
  %t1473 = getelementptr [0 x %Diagnostic*], [0 x %Diagnostic*]* null, i32 1
  %t1474 = ptrtoint [0 x %Diagnostic*]* %t1473 to i64
  %t1475 = icmp eq i64 %t1474, 0
  %t1476 = select i1 %t1475, i64 1, i64 %t1474
  %t1477 = call i8* @malloc(i64 %t1476)
  %t1478 = bitcast i8* %t1477 to %Diagnostic**
  %t1479 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* null, i32 1
  %t1480 = ptrtoint { %Diagnostic**, i64 }* %t1479 to i64
  %t1481 = call i8* @malloc(i64 %t1480)
  %t1482 = bitcast i8* %t1481 to { %Diagnostic**, i64 }*
  %t1483 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t1482, i32 0, i32 0
  store %Diagnostic** %t1478, %Diagnostic*** %t1483
  %t1484 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t1482, i32 0, i32 1
  store i64 0, i64* %t1484
  %t1485 = insertvalue %SymbolCollectionResult %t1472, { %Diagnostic**, i64 }* %t1482, 1
  ret %SymbolCollectionResult %t1485
}

define { %Diagnostic*, i64 }* @check_program_scopes(%Program %program, { %Statement*, i64 }* %interfaces) {
block.entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %Statement*
  %l4 = alloca %ScopeResult
  %t0 = getelementptr [0 x %SymbolEntry], [0 x %SymbolEntry]* null, i32 1
  %t1 = ptrtoint [0 x %SymbolEntry]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %SymbolEntry*
  %t6 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* null, i32 1
  %t7 = ptrtoint { %SymbolEntry*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %SymbolEntry*, i64 }*
  %t10 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t9, i32 0, i32 0
  store %SymbolEntry* %t5, %SymbolEntry** %t10
  %t11 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %SymbolEntry*, i64 }* %t9, { %SymbolEntry*, i64 }** %l0
  %t12 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t13 = ptrtoint [0 x %Diagnostic]* %t12 to i64
  %t14 = icmp eq i64 %t13, 0
  %t15 = select i1 %t14, i64 1, i64 %t13
  %t16 = call i8* @malloc(i64 %t15)
  %t17 = bitcast i8* %t16 to %Diagnostic*
  %t18 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t19 = ptrtoint { %Diagnostic*, i64 }* %t18 to i64
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to { %Diagnostic*, i64 }*
  %t22 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t21, i32 0, i32 0
  store %Diagnostic* %t17, %Diagnostic** %t22
  %t23 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t21, i32 0, i32 1
  store i64 0, i64* %t23
  store { %Diagnostic*, i64 }* %t21, { %Diagnostic*, i64 }** %l1
  %t24 = extractvalue %Program %program, 0
  %t25 = getelementptr { %Statement**, i64 }, { %Statement**, i64 }* %t24, i32 0, i32 1
  %t26 = load i64, i64* %t25
  %t27 = getelementptr { %Statement**, i64 }, { %Statement**, i64 }* %t24, i32 0, i32 0
  %t28 = load %Statement**, %Statement*** %t27
  store i64 0, i64* %l2
  store %Statement* null, %Statement** %l3
  br label %for0
for0:
  %t29 = load i64, i64* %l2
  %t30 = icmp slt i64 %t29, %t26
  br i1 %t30, label %forbody1, label %afterfor3
forbody1:
  %t31 = load i64, i64* %l2
  %t32 = getelementptr %Statement*, %Statement** %t28, i64 %t31
  %t33 = load %Statement*, %Statement** %t32
  store %Statement* %t33, %Statement** %l3
  %t34 = load %Statement*, %Statement** %l3
  %t35 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t36 = load %Statement, %Statement* %t34
  %t37 = call %ScopeResult @check_statement(%Statement %t36, { %SymbolEntry*, i64 }* %t35, { %Statement*, i64 }* %interfaces)
  store %ScopeResult %t37, %ScopeResult* %l4
  %t38 = load %ScopeResult, %ScopeResult* %l4
  %t39 = extractvalue %ScopeResult %t38, 0
  %t40 = bitcast { %SymbolEntry**, i64 }* %t39 to { %SymbolEntry*, i64 }*
  store { %SymbolEntry*, i64 }* %t40, { %SymbolEntry*, i64 }** %l0
  %t41 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t42 = load %ScopeResult, %ScopeResult* %l4
  %t43 = extractvalue %ScopeResult %t42, 1
  %t44 = bitcast { %Diagnostic*, i64 }* %t41 to { i8**, i64 }*
  %t45 = bitcast { %Diagnostic**, i64 }* %t43 to { i8**, i64 }*
  %t46 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t44, { i8**, i64 }* %t45)
  %t47 = bitcast { i8**, i64 }* %t46 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t47, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t48 = load i64, i64* %l2
  %t49 = add i64 %t48, 1
  store i64 %t49, i64* %l2
  br label %for0
afterfor3:
  %t50 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t51 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t52 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t52
}

define %ScopeResult @check_statement(%Statement %statement, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces) {
block.entry:
  %l0 = alloca %ScopeResult
  %l1 = alloca { %Diagnostic**, i64 }*
  %l2 = alloca { %Diagnostic*, i64 }*
  %l3 = alloca %ScopeResult
  %l4 = alloca { %Diagnostic**, i64 }*
  %l5 = alloca double
  %l6 = alloca %MethodDeclaration*
  %l7 = alloca %ScopeResult
  %l8 = alloca { %Diagnostic**, i64 }*
  %l9 = alloca %ScopeResult
  %l10 = alloca { %Diagnostic**, i64 }*
  %l11 = alloca %ScopeResult
  %l12 = alloca { i8**, i64 }*
  %l13 = alloca %ScopeResult
  %l14 = alloca { %Diagnostic**, i64 }*
  %l15 = alloca %ScopeResult
  %l16 = alloca { %Diagnostic**, i64 }*
  %l17 = alloca %ScopeResult
  %l18 = alloca { i8**, i64 }*
  %l19 = alloca { %Diagnostic*, i64 }*
  %l20 = alloca double
  %l21 = alloca %MatchCase*
  %l22 = alloca { %Diagnostic*, i64 }*
  %l23 = alloca %ElseBranch*
  %l24 = alloca %ScopeResult
  %l25 = alloca %ScopeResult
  %l26 = alloca { i8**, i64 }*
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
  %s71 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1204027478, i32 0, i32 0
  %t72 = call i1 @strings_equal(i8* %t70, i8* %s71)
  br i1 %t72, label %then0, label %merge1
then0:
  %t73 = extractvalue %Statement %statement, 0
  %t74 = alloca %Statement
  store %Statement %statement, %Statement* %t74
  %t75 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t76 = bitcast [48 x i8]* %t75 to i8*
  %t77 = bitcast i8* %t76 to i8**
  %t78 = load i8*, i8** %t77
  %t79 = icmp eq i32 %t73, 2
  %t80 = select i1 %t79, i8* %t78, i8* null
  %t81 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t82 = bitcast [48 x i8]* %t81 to i8*
  %t83 = bitcast i8* %t82 to i8**
  %t84 = load i8*, i8** %t83
  %t85 = icmp eq i32 %t73, 3
  %t86 = select i1 %t85, i8* %t84, i8* %t80
  %t87 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t88 = bitcast [40 x i8]* %t87 to i8*
  %t89 = bitcast i8* %t88 to i8**
  %t90 = load i8*, i8** %t89
  %t91 = icmp eq i32 %t73, 6
  %t92 = select i1 %t91, i8* %t90, i8* %t86
  %t93 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t94 = bitcast [56 x i8]* %t93 to i8*
  %t95 = bitcast i8* %t94 to i8**
  %t96 = load i8*, i8** %t95
  %t97 = icmp eq i32 %t73, 8
  %t98 = select i1 %t97, i8* %t96, i8* %t92
  %t99 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t100 = bitcast [40 x i8]* %t99 to i8*
  %t101 = bitcast i8* %t100 to i8**
  %t102 = load i8*, i8** %t101
  %t103 = icmp eq i32 %t73, 9
  %t104 = select i1 %t103, i8* %t102, i8* %t98
  %t105 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t106 = bitcast [40 x i8]* %t105 to i8*
  %t107 = bitcast i8* %t106 to i8**
  %t108 = load i8*, i8** %t107
  %t109 = icmp eq i32 %t73, 10
  %t110 = select i1 %t109, i8* %t108, i8* %t104
  %t111 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t112 = bitcast [40 x i8]* %t111 to i8*
  %t113 = bitcast i8* %t112 to i8**
  %t114 = load i8*, i8** %t113
  %t115 = icmp eq i32 %t73, 11
  %t116 = select i1 %t115, i8* %t114, i8* %t110
  %s117 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1925814595, i32 0, i32 0
  %t118 = extractvalue %Statement %statement, 0
  %t119 = alloca %Statement
  store %Statement %statement, %Statement* %t119
  %t120 = getelementptr inbounds %Statement, %Statement* %t119, i32 0, i32 1
  %t121 = bitcast [48 x i8]* %t120 to i8*
  %t122 = getelementptr inbounds i8, i8* %t121, i64 32
  %t123 = bitcast i8* %t122 to %SourceSpan**
  %t124 = load %SourceSpan*, %SourceSpan** %t123
  %t125 = icmp eq i32 %t118, 2
  %t126 = select i1 %t125, %SourceSpan* %t124, %SourceSpan* null
  %t127 = getelementptr inbounds %Statement, %Statement* %t119, i32 0, i32 1
  %t128 = bitcast [16 x i8]* %t127 to i8*
  %t129 = getelementptr inbounds i8, i8* %t128, i64 8
  %t130 = bitcast i8* %t129 to %SourceSpan**
  %t131 = load %SourceSpan*, %SourceSpan** %t130
  %t132 = icmp eq i32 %t118, 20
  %t133 = select i1 %t132, %SourceSpan* %t131, %SourceSpan* %t126
  %t134 = getelementptr inbounds %Statement, %Statement* %t119, i32 0, i32 1
  %t135 = bitcast [16 x i8]* %t134 to i8*
  %t136 = getelementptr inbounds i8, i8* %t135, i64 8
  %t137 = bitcast i8* %t136 to %SourceSpan**
  %t138 = load %SourceSpan*, %SourceSpan** %t137
  %t139 = icmp eq i32 %t118, 21
  %t140 = select i1 %t139, %SourceSpan* %t138, %SourceSpan* %t133
  %t141 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t116, i8* %s117, %SourceSpan* %t140)
  ret %ScopeResult %t141
merge1:
  %t142 = extractvalue %Statement %statement, 0
  %t143 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t144 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t142, 0
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t142, 1
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t142, 2
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t142, 3
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t142, 4
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t142, 5
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %t162 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t142, 6
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t142, 7
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %t168 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t169 = icmp eq i32 %t142, 8
  %t170 = select i1 %t169, i8* %t168, i8* %t167
  %t171 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t172 = icmp eq i32 %t142, 9
  %t173 = select i1 %t172, i8* %t171, i8* %t170
  %t174 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t175 = icmp eq i32 %t142, 10
  %t176 = select i1 %t175, i8* %t174, i8* %t173
  %t177 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t178 = icmp eq i32 %t142, 11
  %t179 = select i1 %t178, i8* %t177, i8* %t176
  %t180 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t181 = icmp eq i32 %t142, 12
  %t182 = select i1 %t181, i8* %t180, i8* %t179
  %t183 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t184 = icmp eq i32 %t142, 13
  %t185 = select i1 %t184, i8* %t183, i8* %t182
  %t186 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t187 = icmp eq i32 %t142, 14
  %t188 = select i1 %t187, i8* %t186, i8* %t185
  %t189 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t190 = icmp eq i32 %t142, 15
  %t191 = select i1 %t190, i8* %t189, i8* %t188
  %t192 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t193 = icmp eq i32 %t142, 16
  %t194 = select i1 %t193, i8* %t192, i8* %t191
  %t195 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t196 = icmp eq i32 %t142, 17
  %t197 = select i1 %t196, i8* %t195, i8* %t194
  %t198 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t199 = icmp eq i32 %t142, 18
  %t200 = select i1 %t199, i8* %t198, i8* %t197
  %t201 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t202 = icmp eq i32 %t142, 19
  %t203 = select i1 %t202, i8* %t201, i8* %t200
  %t204 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t205 = icmp eq i32 %t142, 20
  %t206 = select i1 %t205, i8* %t204, i8* %t203
  %t207 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t208 = icmp eq i32 %t142, 21
  %t209 = select i1 %t208, i8* %t207, i8* %t206
  %t210 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t211 = icmp eq i32 %t142, 22
  %t212 = select i1 %t211, i8* %t210, i8* %t209
  %s213 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h486335986, i32 0, i32 0
  %t214 = call i1 @strings_equal(i8* %t212, i8* %s213)
  br i1 %t214, label %then2, label %merge3
then2:
  %t215 = extractvalue %Statement %statement, 0
  %t216 = alloca %Statement
  store %Statement %statement, %Statement* %t216
  %t217 = getelementptr inbounds %Statement, %Statement* %t216, i32 0, i32 1
  %t218 = bitcast [24 x i8]* %t217 to i8*
  %t219 = bitcast i8* %t218 to %FunctionSignature*
  %t220 = load %FunctionSignature, %FunctionSignature* %t219
  %t221 = icmp eq i32 %t215, 4
  %t222 = select i1 %t221, %FunctionSignature %t220, %FunctionSignature zeroinitializer
  %t223 = getelementptr inbounds %Statement, %Statement* %t216, i32 0, i32 1
  %t224 = bitcast [24 x i8]* %t223 to i8*
  %t225 = bitcast i8* %t224 to %FunctionSignature*
  %t226 = load %FunctionSignature, %FunctionSignature* %t225
  %t227 = icmp eq i32 %t215, 5
  %t228 = select i1 %t227, %FunctionSignature %t226, %FunctionSignature %t222
  %t229 = getelementptr inbounds %Statement, %Statement* %t216, i32 0, i32 1
  %t230 = bitcast [24 x i8]* %t229 to i8*
  %t231 = bitcast i8* %t230 to %FunctionSignature*
  %t232 = load %FunctionSignature, %FunctionSignature* %t231
  %t233 = icmp eq i32 %t215, 7
  %t234 = select i1 %t233, %FunctionSignature %t232, %FunctionSignature %t228
  %t235 = extractvalue %FunctionSignature %t234, 0
  %s236 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1603982015, i32 0, i32 0
  %t237 = extractvalue %Statement %statement, 0
  %t238 = alloca %Statement
  store %Statement %statement, %Statement* %t238
  %t239 = getelementptr inbounds %Statement, %Statement* %t238, i32 0, i32 1
  %t240 = bitcast [24 x i8]* %t239 to i8*
  %t241 = bitcast i8* %t240 to %FunctionSignature*
  %t242 = load %FunctionSignature, %FunctionSignature* %t241
  %t243 = icmp eq i32 %t237, 4
  %t244 = select i1 %t243, %FunctionSignature %t242, %FunctionSignature zeroinitializer
  %t245 = getelementptr inbounds %Statement, %Statement* %t238, i32 0, i32 1
  %t246 = bitcast [24 x i8]* %t245 to i8*
  %t247 = bitcast i8* %t246 to %FunctionSignature*
  %t248 = load %FunctionSignature, %FunctionSignature* %t247
  %t249 = icmp eq i32 %t237, 5
  %t250 = select i1 %t249, %FunctionSignature %t248, %FunctionSignature %t244
  %t251 = getelementptr inbounds %Statement, %Statement* %t238, i32 0, i32 1
  %t252 = bitcast [24 x i8]* %t251 to i8*
  %t253 = bitcast i8* %t252 to %FunctionSignature*
  %t254 = load %FunctionSignature, %FunctionSignature* %t253
  %t255 = icmp eq i32 %t237, 7
  %t256 = select i1 %t255, %FunctionSignature %t254, %FunctionSignature %t250
  %t257 = extractvalue %FunctionSignature %t256, 6
  %t258 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t235, i8* %s236, %SourceSpan* %t257)
  store %ScopeResult %t258, %ScopeResult* %l0
  %t259 = load %ScopeResult, %ScopeResult* %l0
  %t260 = extractvalue %ScopeResult %t259, 1
  store { %Diagnostic**, i64 }* %t260, { %Diagnostic**, i64 }** %l1
  %t261 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l1
  %t262 = extractvalue %Statement %statement, 0
  %t263 = alloca %Statement
  store %Statement %statement, %Statement* %t263
  %t264 = getelementptr inbounds %Statement, %Statement* %t263, i32 0, i32 1
  %t265 = bitcast [24 x i8]* %t264 to i8*
  %t266 = bitcast i8* %t265 to %FunctionSignature*
  %t267 = load %FunctionSignature, %FunctionSignature* %t266
  %t268 = icmp eq i32 %t262, 4
  %t269 = select i1 %t268, %FunctionSignature %t267, %FunctionSignature zeroinitializer
  %t270 = getelementptr inbounds %Statement, %Statement* %t263, i32 0, i32 1
  %t271 = bitcast [24 x i8]* %t270 to i8*
  %t272 = bitcast i8* %t271 to %FunctionSignature*
  %t273 = load %FunctionSignature, %FunctionSignature* %t272
  %t274 = icmp eq i32 %t262, 5
  %t275 = select i1 %t274, %FunctionSignature %t273, %FunctionSignature %t269
  %t276 = getelementptr inbounds %Statement, %Statement* %t263, i32 0, i32 1
  %t277 = bitcast [24 x i8]* %t276 to i8*
  %t278 = bitcast i8* %t277 to %FunctionSignature*
  %t279 = load %FunctionSignature, %FunctionSignature* %t278
  %t280 = icmp eq i32 %t262, 7
  %t281 = select i1 %t280, %FunctionSignature %t279, %FunctionSignature %t275
  %t282 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t281)
  %t283 = bitcast { %Diagnostic**, i64 }* %t261 to { i8**, i64 }*
  %t284 = bitcast { %Diagnostic*, i64 }* %t282 to { i8**, i64 }*
  %t285 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t283, { i8**, i64 }* %t284)
  %t286 = bitcast { i8**, i64 }* %t285 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t286, { %Diagnostic**, i64 }** %l1
  %t287 = extractvalue %Statement %statement, 0
  %t288 = alloca %Statement
  store %Statement %statement, %Statement* %t288
  %t289 = getelementptr inbounds %Statement, %Statement* %t288, i32 0, i32 1
  %t290 = bitcast [24 x i8]* %t289 to i8*
  %t291 = bitcast i8* %t290 to %FunctionSignature*
  %t292 = load %FunctionSignature, %FunctionSignature* %t291
  %t293 = icmp eq i32 %t287, 4
  %t294 = select i1 %t293, %FunctionSignature %t292, %FunctionSignature zeroinitializer
  %t295 = getelementptr inbounds %Statement, %Statement* %t288, i32 0, i32 1
  %t296 = bitcast [24 x i8]* %t295 to i8*
  %t297 = bitcast i8* %t296 to %FunctionSignature*
  %t298 = load %FunctionSignature, %FunctionSignature* %t297
  %t299 = icmp eq i32 %t287, 5
  %t300 = select i1 %t299, %FunctionSignature %t298, %FunctionSignature %t294
  %t301 = getelementptr inbounds %Statement, %Statement* %t288, i32 0, i32 1
  %t302 = bitcast [24 x i8]* %t301 to i8*
  %t303 = bitcast i8* %t302 to %FunctionSignature*
  %t304 = load %FunctionSignature, %FunctionSignature* %t303
  %t305 = icmp eq i32 %t287, 7
  %t306 = select i1 %t305, %FunctionSignature %t304, %FunctionSignature %t300
  %t307 = extractvalue %Statement %statement, 0
  %t308 = alloca %Statement
  store %Statement %statement, %Statement* %t308
  %t309 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t310 = bitcast [24 x i8]* %t309 to i8*
  %t311 = getelementptr inbounds i8, i8* %t310, i64 8
  %t312 = bitcast i8* %t311 to %Block*
  %t313 = load %Block, %Block* %t312
  %t314 = icmp eq i32 %t307, 4
  %t315 = select i1 %t314, %Block %t313, %Block zeroinitializer
  %t316 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t317 = bitcast [24 x i8]* %t316 to i8*
  %t318 = getelementptr inbounds i8, i8* %t317, i64 8
  %t319 = bitcast i8* %t318 to %Block*
  %t320 = load %Block, %Block* %t319
  %t321 = icmp eq i32 %t307, 5
  %t322 = select i1 %t321, %Block %t320, %Block %t315
  %t323 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t324 = bitcast [40 x i8]* %t323 to i8*
  %t325 = getelementptr inbounds i8, i8* %t324, i64 16
  %t326 = bitcast i8* %t325 to %Block*
  %t327 = load %Block, %Block* %t326
  %t328 = icmp eq i32 %t307, 6
  %t329 = select i1 %t328, %Block %t327, %Block %t322
  %t330 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t331 = bitcast [24 x i8]* %t330 to i8*
  %t332 = getelementptr inbounds i8, i8* %t331, i64 8
  %t333 = bitcast i8* %t332 to %Block*
  %t334 = load %Block, %Block* %t333
  %t335 = icmp eq i32 %t307, 7
  %t336 = select i1 %t335, %Block %t334, %Block %t329
  %t337 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t338 = bitcast [40 x i8]* %t337 to i8*
  %t339 = getelementptr inbounds i8, i8* %t338, i64 24
  %t340 = bitcast i8* %t339 to %Block*
  %t341 = load %Block, %Block* %t340
  %t342 = icmp eq i32 %t307, 12
  %t343 = select i1 %t342, %Block %t341, %Block %t336
  %t344 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t345 = bitcast [24 x i8]* %t344 to i8*
  %t346 = getelementptr inbounds i8, i8* %t345, i64 8
  %t347 = bitcast i8* %t346 to %Block*
  %t348 = load %Block, %Block* %t347
  %t349 = icmp eq i32 %t307, 13
  %t350 = select i1 %t349, %Block %t348, %Block %t343
  %t351 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t352 = bitcast [24 x i8]* %t351 to i8*
  %t353 = getelementptr inbounds i8, i8* %t352, i64 8
  %t354 = bitcast i8* %t353 to %Block*
  %t355 = load %Block, %Block* %t354
  %t356 = icmp eq i32 %t307, 14
  %t357 = select i1 %t356, %Block %t355, %Block %t350
  %t358 = getelementptr inbounds %Statement, %Statement* %t308, i32 0, i32 1
  %t359 = bitcast [16 x i8]* %t358 to i8*
  %t360 = bitcast i8* %t359 to %Block*
  %t361 = load %Block, %Block* %t360
  %t362 = icmp eq i32 %t307, 15
  %t363 = select i1 %t362, %Block %t361, %Block %t357
  %t364 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t306, %Block %t363, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t364, { %Diagnostic*, i64 }** %l2
  %t365 = load %ScopeResult, %ScopeResult* %l0
  %t366 = extractvalue %ScopeResult %t365, 0
  %t367 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t366, 0
  %t368 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l1
  %t369 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l2
  %t370 = bitcast { %Diagnostic**, i64 }* %t368 to { i8**, i64 }*
  %t371 = bitcast { %Diagnostic*, i64 }* %t369 to { i8**, i64 }*
  %t372 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t370, { i8**, i64 }* %t371)
  %t373 = bitcast { i8**, i64 }* %t372 to { %Diagnostic**, i64 }*
  %t374 = insertvalue %ScopeResult %t367, { %Diagnostic**, i64 }* %t373, 1
  ret %ScopeResult %t374
merge3:
  %t375 = extractvalue %Statement %statement, 0
  %t376 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t377 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t378 = icmp eq i32 %t375, 0
  %t379 = select i1 %t378, i8* %t377, i8* %t376
  %t380 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t381 = icmp eq i32 %t375, 1
  %t382 = select i1 %t381, i8* %t380, i8* %t379
  %t383 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t384 = icmp eq i32 %t375, 2
  %t385 = select i1 %t384, i8* %t383, i8* %t382
  %t386 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t387 = icmp eq i32 %t375, 3
  %t388 = select i1 %t387, i8* %t386, i8* %t385
  %t389 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t390 = icmp eq i32 %t375, 4
  %t391 = select i1 %t390, i8* %t389, i8* %t388
  %t392 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t393 = icmp eq i32 %t375, 5
  %t394 = select i1 %t393, i8* %t392, i8* %t391
  %t395 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t396 = icmp eq i32 %t375, 6
  %t397 = select i1 %t396, i8* %t395, i8* %t394
  %t398 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t399 = icmp eq i32 %t375, 7
  %t400 = select i1 %t399, i8* %t398, i8* %t397
  %t401 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t402 = icmp eq i32 %t375, 8
  %t403 = select i1 %t402, i8* %t401, i8* %t400
  %t404 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t405 = icmp eq i32 %t375, 9
  %t406 = select i1 %t405, i8* %t404, i8* %t403
  %t407 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t408 = icmp eq i32 %t375, 10
  %t409 = select i1 %t408, i8* %t407, i8* %t406
  %t410 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t411 = icmp eq i32 %t375, 11
  %t412 = select i1 %t411, i8* %t410, i8* %t409
  %t413 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t414 = icmp eq i32 %t375, 12
  %t415 = select i1 %t414, i8* %t413, i8* %t412
  %t416 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t417 = icmp eq i32 %t375, 13
  %t418 = select i1 %t417, i8* %t416, i8* %t415
  %t419 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t420 = icmp eq i32 %t375, 14
  %t421 = select i1 %t420, i8* %t419, i8* %t418
  %t422 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t423 = icmp eq i32 %t375, 15
  %t424 = select i1 %t423, i8* %t422, i8* %t421
  %t425 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t426 = icmp eq i32 %t375, 16
  %t427 = select i1 %t426, i8* %t425, i8* %t424
  %t428 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t429 = icmp eq i32 %t375, 17
  %t430 = select i1 %t429, i8* %t428, i8* %t427
  %t431 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t432 = icmp eq i32 %t375, 18
  %t433 = select i1 %t432, i8* %t431, i8* %t430
  %t434 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t435 = icmp eq i32 %t375, 19
  %t436 = select i1 %t435, i8* %t434, i8* %t433
  %t437 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t438 = icmp eq i32 %t375, 20
  %t439 = select i1 %t438, i8* %t437, i8* %t436
  %t440 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t441 = icmp eq i32 %t375, 21
  %t442 = select i1 %t441, i8* %t440, i8* %t439
  %t443 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t444 = icmp eq i32 %t375, 22
  %t445 = select i1 %t444, i8* %t443, i8* %t442
  %s446 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1842783069, i32 0, i32 0
  %t447 = call i1 @strings_equal(i8* %t445, i8* %s446)
  br i1 %t447, label %then4, label %merge5
then4:
  %t448 = extractvalue %Statement %statement, 0
  %t449 = alloca %Statement
  store %Statement %statement, %Statement* %t449
  %t450 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t451 = bitcast [48 x i8]* %t450 to i8*
  %t452 = bitcast i8* %t451 to i8**
  %t453 = load i8*, i8** %t452
  %t454 = icmp eq i32 %t448, 2
  %t455 = select i1 %t454, i8* %t453, i8* null
  %t456 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t457 = bitcast [48 x i8]* %t456 to i8*
  %t458 = bitcast i8* %t457 to i8**
  %t459 = load i8*, i8** %t458
  %t460 = icmp eq i32 %t448, 3
  %t461 = select i1 %t460, i8* %t459, i8* %t455
  %t462 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t463 = bitcast [40 x i8]* %t462 to i8*
  %t464 = bitcast i8* %t463 to i8**
  %t465 = load i8*, i8** %t464
  %t466 = icmp eq i32 %t448, 6
  %t467 = select i1 %t466, i8* %t465, i8* %t461
  %t468 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t469 = bitcast [56 x i8]* %t468 to i8*
  %t470 = bitcast i8* %t469 to i8**
  %t471 = load i8*, i8** %t470
  %t472 = icmp eq i32 %t448, 8
  %t473 = select i1 %t472, i8* %t471, i8* %t467
  %t474 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t475 = bitcast [40 x i8]* %t474 to i8*
  %t476 = bitcast i8* %t475 to i8**
  %t477 = load i8*, i8** %t476
  %t478 = icmp eq i32 %t448, 9
  %t479 = select i1 %t478, i8* %t477, i8* %t473
  %t480 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t481 = bitcast [40 x i8]* %t480 to i8*
  %t482 = bitcast i8* %t481 to i8**
  %t483 = load i8*, i8** %t482
  %t484 = icmp eq i32 %t448, 10
  %t485 = select i1 %t484, i8* %t483, i8* %t479
  %t486 = getelementptr inbounds %Statement, %Statement* %t449, i32 0, i32 1
  %t487 = bitcast [40 x i8]* %t486 to i8*
  %t488 = bitcast i8* %t487 to i8**
  %t489 = load i8*, i8** %t488
  %t490 = icmp eq i32 %t448, 11
  %t491 = select i1 %t490, i8* %t489, i8* %t485
  %s492 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h789690461, i32 0, i32 0
  %t493 = extractvalue %Statement %statement, 0
  %t494 = alloca %Statement
  store %Statement %statement, %Statement* %t494
  %t495 = getelementptr inbounds %Statement, %Statement* %t494, i32 0, i32 1
  %t496 = bitcast [48 x i8]* %t495 to i8*
  %t497 = getelementptr inbounds i8, i8* %t496, i64 8
  %t498 = bitcast i8* %t497 to %SourceSpan**
  %t499 = load %SourceSpan*, %SourceSpan** %t498
  %t500 = icmp eq i32 %t493, 3
  %t501 = select i1 %t500, %SourceSpan* %t499, %SourceSpan* null
  %t502 = getelementptr inbounds %Statement, %Statement* %t494, i32 0, i32 1
  %t503 = bitcast [40 x i8]* %t502 to i8*
  %t504 = getelementptr inbounds i8, i8* %t503, i64 8
  %t505 = bitcast i8* %t504 to %SourceSpan**
  %t506 = load %SourceSpan*, %SourceSpan** %t505
  %t507 = icmp eq i32 %t493, 6
  %t508 = select i1 %t507, %SourceSpan* %t506, %SourceSpan* %t501
  %t509 = getelementptr inbounds %Statement, %Statement* %t494, i32 0, i32 1
  %t510 = bitcast [56 x i8]* %t509 to i8*
  %t511 = getelementptr inbounds i8, i8* %t510, i64 8
  %t512 = bitcast i8* %t511 to %SourceSpan**
  %t513 = load %SourceSpan*, %SourceSpan** %t512
  %t514 = icmp eq i32 %t493, 8
  %t515 = select i1 %t514, %SourceSpan* %t513, %SourceSpan* %t508
  %t516 = getelementptr inbounds %Statement, %Statement* %t494, i32 0, i32 1
  %t517 = bitcast [40 x i8]* %t516 to i8*
  %t518 = getelementptr inbounds i8, i8* %t517, i64 8
  %t519 = bitcast i8* %t518 to %SourceSpan**
  %t520 = load %SourceSpan*, %SourceSpan** %t519
  %t521 = icmp eq i32 %t493, 9
  %t522 = select i1 %t521, %SourceSpan* %t520, %SourceSpan* %t515
  %t523 = getelementptr inbounds %Statement, %Statement* %t494, i32 0, i32 1
  %t524 = bitcast [40 x i8]* %t523 to i8*
  %t525 = getelementptr inbounds i8, i8* %t524, i64 8
  %t526 = bitcast i8* %t525 to %SourceSpan**
  %t527 = load %SourceSpan*, %SourceSpan** %t526
  %t528 = icmp eq i32 %t493, 10
  %t529 = select i1 %t528, %SourceSpan* %t527, %SourceSpan* %t522
  %t530 = getelementptr inbounds %Statement, %Statement* %t494, i32 0, i32 1
  %t531 = bitcast [40 x i8]* %t530 to i8*
  %t532 = getelementptr inbounds i8, i8* %t531, i64 8
  %t533 = bitcast i8* %t532 to %SourceSpan**
  %t534 = load %SourceSpan*, %SourceSpan** %t533
  %t535 = icmp eq i32 %t493, 11
  %t536 = select i1 %t535, %SourceSpan* %t534, %SourceSpan* %t529
  %t537 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t491, i8* %s492, %SourceSpan* %t536)
  store %ScopeResult %t537, %ScopeResult* %l3
  %t538 = load %ScopeResult, %ScopeResult* %l3
  %t539 = extractvalue %ScopeResult %t538, 1
  store { %Diagnostic**, i64 }* %t539, { %Diagnostic**, i64 }** %l4
  %t540 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t541 = extractvalue %Statement %statement, 0
  %t542 = alloca %Statement
  store %Statement %statement, %Statement* %t542
  %t543 = getelementptr inbounds %Statement, %Statement* %t542, i32 0, i32 1
  %t544 = bitcast [56 x i8]* %t543 to i8*
  %t545 = getelementptr inbounds i8, i8* %t544, i64 16
  %t546 = bitcast i8* %t545 to { %TypeParameter**, i64 }**
  %t547 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t546
  %t548 = icmp eq i32 %t541, 8
  %t549 = select i1 %t548, { %TypeParameter**, i64 }* %t547, { %TypeParameter**, i64 }* null
  %t550 = getelementptr inbounds %Statement, %Statement* %t542, i32 0, i32 1
  %t551 = bitcast [40 x i8]* %t550 to i8*
  %t552 = getelementptr inbounds i8, i8* %t551, i64 16
  %t553 = bitcast i8* %t552 to { %TypeParameter**, i64 }**
  %t554 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t553
  %t555 = icmp eq i32 %t541, 9
  %t556 = select i1 %t555, { %TypeParameter**, i64 }* %t554, { %TypeParameter**, i64 }* %t549
  %t557 = getelementptr inbounds %Statement, %Statement* %t542, i32 0, i32 1
  %t558 = bitcast [40 x i8]* %t557 to i8*
  %t559 = getelementptr inbounds i8, i8* %t558, i64 16
  %t560 = bitcast i8* %t559 to { %TypeParameter**, i64 }**
  %t561 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t560
  %t562 = icmp eq i32 %t541, 10
  %t563 = select i1 %t562, { %TypeParameter**, i64 }* %t561, { %TypeParameter**, i64 }* %t556
  %t564 = getelementptr inbounds %Statement, %Statement* %t542, i32 0, i32 1
  %t565 = bitcast [40 x i8]* %t564 to i8*
  %t566 = getelementptr inbounds i8, i8* %t565, i64 16
  %t567 = bitcast i8* %t566 to { %TypeParameter**, i64 }**
  %t568 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t567
  %t569 = icmp eq i32 %t541, 11
  %t570 = select i1 %t569, { %TypeParameter**, i64 }* %t568, { %TypeParameter**, i64 }* %t563
  %t571 = bitcast { %TypeParameter**, i64 }* %t570 to { %TypeParameter*, i64 }*
  %t572 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t571)
  %t573 = bitcast { %Diagnostic**, i64 }* %t540 to { i8**, i64 }*
  %t574 = bitcast { %Diagnostic*, i64 }* %t572 to { i8**, i64 }*
  %t575 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t573, { i8**, i64 }* %t574)
  %t576 = bitcast { i8**, i64 }* %t575 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t576, { %Diagnostic**, i64 }** %l4
  %t577 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t578 = extractvalue %Statement %statement, 0
  %t579 = alloca %Statement
  store %Statement %statement, %Statement* %t579
  %t580 = getelementptr inbounds %Statement, %Statement* %t579, i32 0, i32 1
  %t581 = bitcast [56 x i8]* %t580 to i8*
  %t582 = getelementptr inbounds i8, i8* %t581, i64 32
  %t583 = bitcast i8* %t582 to { %FieldDeclaration**, i64 }**
  %t584 = load { %FieldDeclaration**, i64 }*, { %FieldDeclaration**, i64 }** %t583
  %t585 = icmp eq i32 %t578, 8
  %t586 = select i1 %t585, { %FieldDeclaration**, i64 }* %t584, { %FieldDeclaration**, i64 }* null
  %t587 = bitcast { %FieldDeclaration**, i64 }* %t586 to { %FieldDeclaration*, i64 }*
  %t588 = call { %Diagnostic*, i64 }* @check_struct_fields({ %FieldDeclaration*, i64 }* %t587)
  %t589 = bitcast { %Diagnostic**, i64 }* %t577 to { i8**, i64 }*
  %t590 = bitcast { %Diagnostic*, i64 }* %t588 to { i8**, i64 }*
  %t591 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t589, { i8**, i64 }* %t590)
  %t592 = bitcast { i8**, i64 }* %t591 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t592, { %Diagnostic**, i64 }** %l4
  %t593 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t594 = extractvalue %Statement %statement, 0
  %t595 = alloca %Statement
  store %Statement %statement, %Statement* %t595
  %t596 = getelementptr inbounds %Statement, %Statement* %t595, i32 0, i32 1
  %t597 = bitcast [56 x i8]* %t596 to i8*
  %t598 = getelementptr inbounds i8, i8* %t597, i64 40
  %t599 = bitcast i8* %t598 to { %MethodDeclaration**, i64 }**
  %t600 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t599
  %t601 = icmp eq i32 %t594, 8
  %t602 = select i1 %t601, { %MethodDeclaration**, i64 }* %t600, { %MethodDeclaration**, i64 }* null
  %t603 = bitcast { %MethodDeclaration**, i64 }* %t602 to { %MethodDeclaration*, i64 }*
  %t604 = call { %Diagnostic*, i64 }* @check_struct_methods({ %MethodDeclaration*, i64 }* %t603)
  %t605 = bitcast { %Diagnostic**, i64 }* %t593 to { i8**, i64 }*
  %t606 = bitcast { %Diagnostic*, i64 }* %t604 to { i8**, i64 }*
  %t607 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t605, { i8**, i64 }* %t606)
  %t608 = bitcast { i8**, i64 }* %t607 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t608, { %Diagnostic**, i64 }** %l4
  %t609 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t610 = call { %Diagnostic*, i64 }* @check_struct_implements_interfaces(%Statement %statement, { %Statement*, i64 }* %interfaces)
  %t611 = bitcast { %Diagnostic**, i64 }* %t609 to { i8**, i64 }*
  %t612 = bitcast { %Diagnostic*, i64 }* %t610 to { i8**, i64 }*
  %t613 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t611, { i8**, i64 }* %t612)
  %t614 = bitcast { i8**, i64 }* %t613 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t614, { %Diagnostic**, i64 }** %l4
  %t615 = sitofp i64 0 to double
  store double %t615, double* %l5
  %t616 = load %ScopeResult, %ScopeResult* %l3
  %t617 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t618 = load double, double* %l5
  br label %loop.header6
loop.header6:
  %t671 = phi { %Diagnostic**, i64 }* [ %t617, %then4 ], [ %t669, %loop.latch8 ]
  %t672 = phi double [ %t618, %then4 ], [ %t670, %loop.latch8 ]
  store { %Diagnostic**, i64 }* %t671, { %Diagnostic**, i64 }** %l4
  store double %t672, double* %l5
  br label %loop.body7
loop.body7:
  %t619 = load double, double* %l5
  %t620 = extractvalue %Statement %statement, 0
  %t621 = alloca %Statement
  store %Statement %statement, %Statement* %t621
  %t622 = getelementptr inbounds %Statement, %Statement* %t621, i32 0, i32 1
  %t623 = bitcast [56 x i8]* %t622 to i8*
  %t624 = getelementptr inbounds i8, i8* %t623, i64 40
  %t625 = bitcast i8* %t624 to { %MethodDeclaration**, i64 }**
  %t626 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t625
  %t627 = icmp eq i32 %t620, 8
  %t628 = select i1 %t627, { %MethodDeclaration**, i64 }* %t626, { %MethodDeclaration**, i64 }* null
  %t629 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t628
  %t630 = extractvalue { %MethodDeclaration**, i64 } %t629, 1
  %t631 = sitofp i64 %t630 to double
  %t632 = fcmp oge double %t619, %t631
  %t633 = load %ScopeResult, %ScopeResult* %l3
  %t634 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t635 = load double, double* %l5
  br i1 %t632, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t636 = extractvalue %Statement %statement, 0
  %t637 = alloca %Statement
  store %Statement %statement, %Statement* %t637
  %t638 = getelementptr inbounds %Statement, %Statement* %t637, i32 0, i32 1
  %t639 = bitcast [56 x i8]* %t638 to i8*
  %t640 = getelementptr inbounds i8, i8* %t639, i64 40
  %t641 = bitcast i8* %t640 to { %MethodDeclaration**, i64 }**
  %t642 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t641
  %t643 = icmp eq i32 %t636, 8
  %t644 = select i1 %t643, { %MethodDeclaration**, i64 }* %t642, { %MethodDeclaration**, i64 }* null
  %t645 = load double, double* %l5
  %t646 = call double @llvm.round.f64(double %t645)
  %t647 = fptosi double %t646 to i64
  %t648 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t644
  %t649 = extractvalue { %MethodDeclaration**, i64 } %t648, 0
  %t650 = extractvalue { %MethodDeclaration**, i64 } %t648, 1
  %t651 = icmp uge i64 %t647, %t650
  ; bounds check: %t651 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t647, i64 %t650)
  %t652 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t649, i64 %t647
  %t653 = load %MethodDeclaration*, %MethodDeclaration** %t652
  store %MethodDeclaration* %t653, %MethodDeclaration** %l6
  %t654 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t655 = load %MethodDeclaration*, %MethodDeclaration** %l6
  %t656 = getelementptr %MethodDeclaration, %MethodDeclaration* %t655, i32 0, i32 0
  %t657 = load %FunctionSignature, %FunctionSignature* %t656
  %t658 = load %MethodDeclaration*, %MethodDeclaration** %l6
  %t659 = getelementptr %MethodDeclaration, %MethodDeclaration* %t658, i32 0, i32 1
  %t660 = load %Block, %Block* %t659
  %t661 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t657, %Block %t660, { %Statement*, i64 }* %interfaces)
  %t662 = bitcast { %Diagnostic**, i64 }* %t654 to { i8**, i64 }*
  %t663 = bitcast { %Diagnostic*, i64 }* %t661 to { i8**, i64 }*
  %t664 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t662, { i8**, i64 }* %t663)
  %t665 = bitcast { i8**, i64 }* %t664 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t665, { %Diagnostic**, i64 }** %l4
  %t666 = load double, double* %l5
  %t667 = sitofp i64 1 to double
  %t668 = fadd double %t666, %t667
  store double %t668, double* %l5
  br label %loop.latch8
loop.latch8:
  %t669 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t670 = load double, double* %l5
  br label %loop.header6
afterloop9:
  %t673 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t674 = load double, double* %l5
  %t675 = load %ScopeResult, %ScopeResult* %l3
  %t676 = extractvalue %ScopeResult %t675, 0
  %t677 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t676, 0
  %t678 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t679 = insertvalue %ScopeResult %t677, { %Diagnostic**, i64 }* %t678, 1
  ret %ScopeResult %t679
merge5:
  %t680 = extractvalue %Statement %statement, 0
  %t681 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t682 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t683 = icmp eq i32 %t680, 0
  %t684 = select i1 %t683, i8* %t682, i8* %t681
  %t685 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t686 = icmp eq i32 %t680, 1
  %t687 = select i1 %t686, i8* %t685, i8* %t684
  %t688 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t689 = icmp eq i32 %t680, 2
  %t690 = select i1 %t689, i8* %t688, i8* %t687
  %t691 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t692 = icmp eq i32 %t680, 3
  %t693 = select i1 %t692, i8* %t691, i8* %t690
  %t694 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t695 = icmp eq i32 %t680, 4
  %t696 = select i1 %t695, i8* %t694, i8* %t693
  %t697 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t698 = icmp eq i32 %t680, 5
  %t699 = select i1 %t698, i8* %t697, i8* %t696
  %t700 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t701 = icmp eq i32 %t680, 6
  %t702 = select i1 %t701, i8* %t700, i8* %t699
  %t703 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t704 = icmp eq i32 %t680, 7
  %t705 = select i1 %t704, i8* %t703, i8* %t702
  %t706 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t707 = icmp eq i32 %t680, 8
  %t708 = select i1 %t707, i8* %t706, i8* %t705
  %t709 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t710 = icmp eq i32 %t680, 9
  %t711 = select i1 %t710, i8* %t709, i8* %t708
  %t712 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t713 = icmp eq i32 %t680, 10
  %t714 = select i1 %t713, i8* %t712, i8* %t711
  %t715 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t716 = icmp eq i32 %t680, 11
  %t717 = select i1 %t716, i8* %t715, i8* %t714
  %t718 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t719 = icmp eq i32 %t680, 12
  %t720 = select i1 %t719, i8* %t718, i8* %t717
  %t721 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t722 = icmp eq i32 %t680, 13
  %t723 = select i1 %t722, i8* %t721, i8* %t720
  %t724 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t725 = icmp eq i32 %t680, 14
  %t726 = select i1 %t725, i8* %t724, i8* %t723
  %t727 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t728 = icmp eq i32 %t680, 15
  %t729 = select i1 %t728, i8* %t727, i8* %t726
  %t730 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t731 = icmp eq i32 %t680, 16
  %t732 = select i1 %t731, i8* %t730, i8* %t729
  %t733 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t734 = icmp eq i32 %t680, 17
  %t735 = select i1 %t734, i8* %t733, i8* %t732
  %t736 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t737 = icmp eq i32 %t680, 18
  %t738 = select i1 %t737, i8* %t736, i8* %t735
  %t739 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t740 = icmp eq i32 %t680, 19
  %t741 = select i1 %t740, i8* %t739, i8* %t738
  %t742 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t743 = icmp eq i32 %t680, 20
  %t744 = select i1 %t743, i8* %t742, i8* %t741
  %t745 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t746 = icmp eq i32 %t680, 21
  %t747 = select i1 %t746, i8* %t745, i8* %t744
  %t748 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t749 = icmp eq i32 %t680, 22
  %t750 = select i1 %t749, i8* %t748, i8* %t747
  %s751 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h579804543, i32 0, i32 0
  %t752 = call i1 @strings_equal(i8* %t750, i8* %s751)
  br i1 %t752, label %then12, label %merge13
then12:
  %t753 = extractvalue %Statement %statement, 0
  %t754 = alloca %Statement
  store %Statement %statement, %Statement* %t754
  %t755 = getelementptr inbounds %Statement, %Statement* %t754, i32 0, i32 1
  %t756 = bitcast [48 x i8]* %t755 to i8*
  %t757 = bitcast i8* %t756 to i8**
  %t758 = load i8*, i8** %t757
  %t759 = icmp eq i32 %t753, 2
  %t760 = select i1 %t759, i8* %t758, i8* null
  %t761 = getelementptr inbounds %Statement, %Statement* %t754, i32 0, i32 1
  %t762 = bitcast [48 x i8]* %t761 to i8*
  %t763 = bitcast i8* %t762 to i8**
  %t764 = load i8*, i8** %t763
  %t765 = icmp eq i32 %t753, 3
  %t766 = select i1 %t765, i8* %t764, i8* %t760
  %t767 = getelementptr inbounds %Statement, %Statement* %t754, i32 0, i32 1
  %t768 = bitcast [40 x i8]* %t767 to i8*
  %t769 = bitcast i8* %t768 to i8**
  %t770 = load i8*, i8** %t769
  %t771 = icmp eq i32 %t753, 6
  %t772 = select i1 %t771, i8* %t770, i8* %t766
  %t773 = getelementptr inbounds %Statement, %Statement* %t754, i32 0, i32 1
  %t774 = bitcast [56 x i8]* %t773 to i8*
  %t775 = bitcast i8* %t774 to i8**
  %t776 = load i8*, i8** %t775
  %t777 = icmp eq i32 %t753, 8
  %t778 = select i1 %t777, i8* %t776, i8* %t772
  %t779 = getelementptr inbounds %Statement, %Statement* %t754, i32 0, i32 1
  %t780 = bitcast [40 x i8]* %t779 to i8*
  %t781 = bitcast i8* %t780 to i8**
  %t782 = load i8*, i8** %t781
  %t783 = icmp eq i32 %t753, 9
  %t784 = select i1 %t783, i8* %t782, i8* %t778
  %t785 = getelementptr inbounds %Statement, %Statement* %t754, i32 0, i32 1
  %t786 = bitcast [40 x i8]* %t785 to i8*
  %t787 = bitcast i8* %t786 to i8**
  %t788 = load i8*, i8** %t787
  %t789 = icmp eq i32 %t753, 10
  %t790 = select i1 %t789, i8* %t788, i8* %t784
  %t791 = getelementptr inbounds %Statement, %Statement* %t754, i32 0, i32 1
  %t792 = bitcast [40 x i8]* %t791 to i8*
  %t793 = bitcast i8* %t792 to i8**
  %t794 = load i8*, i8** %t793
  %t795 = icmp eq i32 %t753, 11
  %t796 = select i1 %t795, i8* %t794, i8* %t790
  %s797 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h258014432, i32 0, i32 0
  %t798 = extractvalue %Statement %statement, 0
  %t799 = alloca %Statement
  store %Statement %statement, %Statement* %t799
  %t800 = getelementptr inbounds %Statement, %Statement* %t799, i32 0, i32 1
  %t801 = bitcast [48 x i8]* %t800 to i8*
  %t802 = getelementptr inbounds i8, i8* %t801, i64 8
  %t803 = bitcast i8* %t802 to %SourceSpan**
  %t804 = load %SourceSpan*, %SourceSpan** %t803
  %t805 = icmp eq i32 %t798, 3
  %t806 = select i1 %t805, %SourceSpan* %t804, %SourceSpan* null
  %t807 = getelementptr inbounds %Statement, %Statement* %t799, i32 0, i32 1
  %t808 = bitcast [40 x i8]* %t807 to i8*
  %t809 = getelementptr inbounds i8, i8* %t808, i64 8
  %t810 = bitcast i8* %t809 to %SourceSpan**
  %t811 = load %SourceSpan*, %SourceSpan** %t810
  %t812 = icmp eq i32 %t798, 6
  %t813 = select i1 %t812, %SourceSpan* %t811, %SourceSpan* %t806
  %t814 = getelementptr inbounds %Statement, %Statement* %t799, i32 0, i32 1
  %t815 = bitcast [56 x i8]* %t814 to i8*
  %t816 = getelementptr inbounds i8, i8* %t815, i64 8
  %t817 = bitcast i8* %t816 to %SourceSpan**
  %t818 = load %SourceSpan*, %SourceSpan** %t817
  %t819 = icmp eq i32 %t798, 8
  %t820 = select i1 %t819, %SourceSpan* %t818, %SourceSpan* %t813
  %t821 = getelementptr inbounds %Statement, %Statement* %t799, i32 0, i32 1
  %t822 = bitcast [40 x i8]* %t821 to i8*
  %t823 = getelementptr inbounds i8, i8* %t822, i64 8
  %t824 = bitcast i8* %t823 to %SourceSpan**
  %t825 = load %SourceSpan*, %SourceSpan** %t824
  %t826 = icmp eq i32 %t798, 9
  %t827 = select i1 %t826, %SourceSpan* %t825, %SourceSpan* %t820
  %t828 = getelementptr inbounds %Statement, %Statement* %t799, i32 0, i32 1
  %t829 = bitcast [40 x i8]* %t828 to i8*
  %t830 = getelementptr inbounds i8, i8* %t829, i64 8
  %t831 = bitcast i8* %t830 to %SourceSpan**
  %t832 = load %SourceSpan*, %SourceSpan** %t831
  %t833 = icmp eq i32 %t798, 10
  %t834 = select i1 %t833, %SourceSpan* %t832, %SourceSpan* %t827
  %t835 = getelementptr inbounds %Statement, %Statement* %t799, i32 0, i32 1
  %t836 = bitcast [40 x i8]* %t835 to i8*
  %t837 = getelementptr inbounds i8, i8* %t836, i64 8
  %t838 = bitcast i8* %t837 to %SourceSpan**
  %t839 = load %SourceSpan*, %SourceSpan** %t838
  %t840 = icmp eq i32 %t798, 11
  %t841 = select i1 %t840, %SourceSpan* %t839, %SourceSpan* %t834
  %t842 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t796, i8* %s797, %SourceSpan* %t841)
  store %ScopeResult %t842, %ScopeResult* %l7
  %t843 = load %ScopeResult, %ScopeResult* %l7
  %t844 = extractvalue %ScopeResult %t843, 1
  store { %Diagnostic**, i64 }* %t844, { %Diagnostic**, i64 }** %l8
  %t845 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l8
  %t846 = extractvalue %Statement %statement, 0
  %t847 = alloca %Statement
  store %Statement %statement, %Statement* %t847
  %t848 = getelementptr inbounds %Statement, %Statement* %t847, i32 0, i32 1
  %t849 = bitcast [56 x i8]* %t848 to i8*
  %t850 = getelementptr inbounds i8, i8* %t849, i64 16
  %t851 = bitcast i8* %t850 to { %TypeParameter**, i64 }**
  %t852 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t851
  %t853 = icmp eq i32 %t846, 8
  %t854 = select i1 %t853, { %TypeParameter**, i64 }* %t852, { %TypeParameter**, i64 }* null
  %t855 = getelementptr inbounds %Statement, %Statement* %t847, i32 0, i32 1
  %t856 = bitcast [40 x i8]* %t855 to i8*
  %t857 = getelementptr inbounds i8, i8* %t856, i64 16
  %t858 = bitcast i8* %t857 to { %TypeParameter**, i64 }**
  %t859 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t858
  %t860 = icmp eq i32 %t846, 9
  %t861 = select i1 %t860, { %TypeParameter**, i64 }* %t859, { %TypeParameter**, i64 }* %t854
  %t862 = getelementptr inbounds %Statement, %Statement* %t847, i32 0, i32 1
  %t863 = bitcast [40 x i8]* %t862 to i8*
  %t864 = getelementptr inbounds i8, i8* %t863, i64 16
  %t865 = bitcast i8* %t864 to { %TypeParameter**, i64 }**
  %t866 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t865
  %t867 = icmp eq i32 %t846, 10
  %t868 = select i1 %t867, { %TypeParameter**, i64 }* %t866, { %TypeParameter**, i64 }* %t861
  %t869 = getelementptr inbounds %Statement, %Statement* %t847, i32 0, i32 1
  %t870 = bitcast [40 x i8]* %t869 to i8*
  %t871 = getelementptr inbounds i8, i8* %t870, i64 16
  %t872 = bitcast i8* %t871 to { %TypeParameter**, i64 }**
  %t873 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t872
  %t874 = icmp eq i32 %t846, 11
  %t875 = select i1 %t874, { %TypeParameter**, i64 }* %t873, { %TypeParameter**, i64 }* %t868
  %t876 = bitcast { %TypeParameter**, i64 }* %t875 to { %TypeParameter*, i64 }*
  %t877 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t876)
  %t878 = bitcast { %Diagnostic**, i64 }* %t845 to { i8**, i64 }*
  %t879 = bitcast { %Diagnostic*, i64 }* %t877 to { i8**, i64 }*
  %t880 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t878, { i8**, i64 }* %t879)
  %t881 = bitcast { i8**, i64 }* %t880 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t881, { %Diagnostic**, i64 }** %l8
  %t882 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l8
  %t883 = extractvalue %Statement %statement, 0
  %t884 = alloca %Statement
  store %Statement %statement, %Statement* %t884
  %t885 = getelementptr inbounds %Statement, %Statement* %t884, i32 0, i32 1
  %t886 = bitcast [40 x i8]* %t885 to i8*
  %t887 = getelementptr inbounds i8, i8* %t886, i64 24
  %t888 = bitcast i8* %t887 to { %EnumVariant**, i64 }**
  %t889 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t888
  %t890 = icmp eq i32 %t883, 11
  %t891 = select i1 %t890, { %EnumVariant**, i64 }* %t889, { %EnumVariant**, i64 }* null
  %t892 = bitcast { %EnumVariant**, i64 }* %t891 to { %EnumVariant*, i64 }*
  %t893 = call { %Diagnostic*, i64 }* @check_enum_variants({ %EnumVariant*, i64 }* %t892)
  %t894 = bitcast { %Diagnostic**, i64 }* %t882 to { i8**, i64 }*
  %t895 = bitcast { %Diagnostic*, i64 }* %t893 to { i8**, i64 }*
  %t896 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t894, { i8**, i64 }* %t895)
  %t897 = bitcast { i8**, i64 }* %t896 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t897, { %Diagnostic**, i64 }** %l8
  %t898 = load %ScopeResult, %ScopeResult* %l7
  %t899 = extractvalue %ScopeResult %t898, 0
  %t900 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t899, 0
  %t901 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l8
  %t902 = insertvalue %ScopeResult %t900, { %Diagnostic**, i64 }* %t901, 1
  ret %ScopeResult %t902
merge13:
  %t903 = extractvalue %Statement %statement, 0
  %t904 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t905 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t906 = icmp eq i32 %t903, 0
  %t907 = select i1 %t906, i8* %t905, i8* %t904
  %t908 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t909 = icmp eq i32 %t903, 1
  %t910 = select i1 %t909, i8* %t908, i8* %t907
  %t911 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t912 = icmp eq i32 %t903, 2
  %t913 = select i1 %t912, i8* %t911, i8* %t910
  %t914 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t915 = icmp eq i32 %t903, 3
  %t916 = select i1 %t915, i8* %t914, i8* %t913
  %t917 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t918 = icmp eq i32 %t903, 4
  %t919 = select i1 %t918, i8* %t917, i8* %t916
  %t920 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t921 = icmp eq i32 %t903, 5
  %t922 = select i1 %t921, i8* %t920, i8* %t919
  %t923 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t924 = icmp eq i32 %t903, 6
  %t925 = select i1 %t924, i8* %t923, i8* %t922
  %t926 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t927 = icmp eq i32 %t903, 7
  %t928 = select i1 %t927, i8* %t926, i8* %t925
  %t929 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t930 = icmp eq i32 %t903, 8
  %t931 = select i1 %t930, i8* %t929, i8* %t928
  %t932 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t933 = icmp eq i32 %t903, 9
  %t934 = select i1 %t933, i8* %t932, i8* %t931
  %t935 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t936 = icmp eq i32 %t903, 10
  %t937 = select i1 %t936, i8* %t935, i8* %t934
  %t938 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t939 = icmp eq i32 %t903, 11
  %t940 = select i1 %t939, i8* %t938, i8* %t937
  %t941 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t942 = icmp eq i32 %t903, 12
  %t943 = select i1 %t942, i8* %t941, i8* %t940
  %t944 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t945 = icmp eq i32 %t903, 13
  %t946 = select i1 %t945, i8* %t944, i8* %t943
  %t947 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t948 = icmp eq i32 %t903, 14
  %t949 = select i1 %t948, i8* %t947, i8* %t946
  %t950 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t951 = icmp eq i32 %t903, 15
  %t952 = select i1 %t951, i8* %t950, i8* %t949
  %t953 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t954 = icmp eq i32 %t903, 16
  %t955 = select i1 %t954, i8* %t953, i8* %t952
  %t956 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t957 = icmp eq i32 %t903, 17
  %t958 = select i1 %t957, i8* %t956, i8* %t955
  %t959 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t960 = icmp eq i32 %t903, 18
  %t961 = select i1 %t960, i8* %t959, i8* %t958
  %t962 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t963 = icmp eq i32 %t903, 19
  %t964 = select i1 %t963, i8* %t962, i8* %t961
  %t965 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t966 = icmp eq i32 %t903, 20
  %t967 = select i1 %t966, i8* %t965, i8* %t964
  %t968 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t969 = icmp eq i32 %t903, 21
  %t970 = select i1 %t969, i8* %t968, i8* %t967
  %t971 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t972 = icmp eq i32 %t903, 22
  %t973 = select i1 %t972, i8* %t971, i8* %t970
  %s974 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h666604742, i32 0, i32 0
  %t975 = call i1 @strings_equal(i8* %t973, i8* %s974)
  br i1 %t975, label %then14, label %merge15
then14:
  %t976 = extractvalue %Statement %statement, 0
  %t977 = alloca %Statement
  store %Statement %statement, %Statement* %t977
  %t978 = getelementptr inbounds %Statement, %Statement* %t977, i32 0, i32 1
  %t979 = bitcast [48 x i8]* %t978 to i8*
  %t980 = bitcast i8* %t979 to i8**
  %t981 = load i8*, i8** %t980
  %t982 = icmp eq i32 %t976, 2
  %t983 = select i1 %t982, i8* %t981, i8* null
  %t984 = getelementptr inbounds %Statement, %Statement* %t977, i32 0, i32 1
  %t985 = bitcast [48 x i8]* %t984 to i8*
  %t986 = bitcast i8* %t985 to i8**
  %t987 = load i8*, i8** %t986
  %t988 = icmp eq i32 %t976, 3
  %t989 = select i1 %t988, i8* %t987, i8* %t983
  %t990 = getelementptr inbounds %Statement, %Statement* %t977, i32 0, i32 1
  %t991 = bitcast [40 x i8]* %t990 to i8*
  %t992 = bitcast i8* %t991 to i8**
  %t993 = load i8*, i8** %t992
  %t994 = icmp eq i32 %t976, 6
  %t995 = select i1 %t994, i8* %t993, i8* %t989
  %t996 = getelementptr inbounds %Statement, %Statement* %t977, i32 0, i32 1
  %t997 = bitcast [56 x i8]* %t996 to i8*
  %t998 = bitcast i8* %t997 to i8**
  %t999 = load i8*, i8** %t998
  %t1000 = icmp eq i32 %t976, 8
  %t1001 = select i1 %t1000, i8* %t999, i8* %t995
  %t1002 = getelementptr inbounds %Statement, %Statement* %t977, i32 0, i32 1
  %t1003 = bitcast [40 x i8]* %t1002 to i8*
  %t1004 = bitcast i8* %t1003 to i8**
  %t1005 = load i8*, i8** %t1004
  %t1006 = icmp eq i32 %t976, 9
  %t1007 = select i1 %t1006, i8* %t1005, i8* %t1001
  %t1008 = getelementptr inbounds %Statement, %Statement* %t977, i32 0, i32 1
  %t1009 = bitcast [40 x i8]* %t1008 to i8*
  %t1010 = bitcast i8* %t1009 to i8**
  %t1011 = load i8*, i8** %t1010
  %t1012 = icmp eq i32 %t976, 10
  %t1013 = select i1 %t1012, i8* %t1011, i8* %t1007
  %t1014 = getelementptr inbounds %Statement, %Statement* %t977, i32 0, i32 1
  %t1015 = bitcast [40 x i8]* %t1014 to i8*
  %t1016 = bitcast i8* %t1015 to i8**
  %t1017 = load i8*, i8** %t1016
  %t1018 = icmp eq i32 %t976, 11
  %t1019 = select i1 %t1018, i8* %t1017, i8* %t1013
  %s1020 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1313193687, i32 0, i32 0
  %t1021 = extractvalue %Statement %statement, 0
  %t1022 = alloca %Statement
  store %Statement %statement, %Statement* %t1022
  %t1023 = getelementptr inbounds %Statement, %Statement* %t1022, i32 0, i32 1
  %t1024 = bitcast [48 x i8]* %t1023 to i8*
  %t1025 = getelementptr inbounds i8, i8* %t1024, i64 8
  %t1026 = bitcast i8* %t1025 to %SourceSpan**
  %t1027 = load %SourceSpan*, %SourceSpan** %t1026
  %t1028 = icmp eq i32 %t1021, 3
  %t1029 = select i1 %t1028, %SourceSpan* %t1027, %SourceSpan* null
  %t1030 = getelementptr inbounds %Statement, %Statement* %t1022, i32 0, i32 1
  %t1031 = bitcast [40 x i8]* %t1030 to i8*
  %t1032 = getelementptr inbounds i8, i8* %t1031, i64 8
  %t1033 = bitcast i8* %t1032 to %SourceSpan**
  %t1034 = load %SourceSpan*, %SourceSpan** %t1033
  %t1035 = icmp eq i32 %t1021, 6
  %t1036 = select i1 %t1035, %SourceSpan* %t1034, %SourceSpan* %t1029
  %t1037 = getelementptr inbounds %Statement, %Statement* %t1022, i32 0, i32 1
  %t1038 = bitcast [56 x i8]* %t1037 to i8*
  %t1039 = getelementptr inbounds i8, i8* %t1038, i64 8
  %t1040 = bitcast i8* %t1039 to %SourceSpan**
  %t1041 = load %SourceSpan*, %SourceSpan** %t1040
  %t1042 = icmp eq i32 %t1021, 8
  %t1043 = select i1 %t1042, %SourceSpan* %t1041, %SourceSpan* %t1036
  %t1044 = getelementptr inbounds %Statement, %Statement* %t1022, i32 0, i32 1
  %t1045 = bitcast [40 x i8]* %t1044 to i8*
  %t1046 = getelementptr inbounds i8, i8* %t1045, i64 8
  %t1047 = bitcast i8* %t1046 to %SourceSpan**
  %t1048 = load %SourceSpan*, %SourceSpan** %t1047
  %t1049 = icmp eq i32 %t1021, 9
  %t1050 = select i1 %t1049, %SourceSpan* %t1048, %SourceSpan* %t1043
  %t1051 = getelementptr inbounds %Statement, %Statement* %t1022, i32 0, i32 1
  %t1052 = bitcast [40 x i8]* %t1051 to i8*
  %t1053 = getelementptr inbounds i8, i8* %t1052, i64 8
  %t1054 = bitcast i8* %t1053 to %SourceSpan**
  %t1055 = load %SourceSpan*, %SourceSpan** %t1054
  %t1056 = icmp eq i32 %t1021, 10
  %t1057 = select i1 %t1056, %SourceSpan* %t1055, %SourceSpan* %t1050
  %t1058 = getelementptr inbounds %Statement, %Statement* %t1022, i32 0, i32 1
  %t1059 = bitcast [40 x i8]* %t1058 to i8*
  %t1060 = getelementptr inbounds i8, i8* %t1059, i64 8
  %t1061 = bitcast i8* %t1060 to %SourceSpan**
  %t1062 = load %SourceSpan*, %SourceSpan** %t1061
  %t1063 = icmp eq i32 %t1021, 11
  %t1064 = select i1 %t1063, %SourceSpan* %t1062, %SourceSpan* %t1057
  %t1065 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1019, i8* %s1020, %SourceSpan* %t1064)
  store %ScopeResult %t1065, %ScopeResult* %l9
  %t1066 = load %ScopeResult, %ScopeResult* %l9
  %t1067 = extractvalue %ScopeResult %t1066, 1
  store { %Diagnostic**, i64 }* %t1067, { %Diagnostic**, i64 }** %l10
  %t1068 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l10
  %t1069 = extractvalue %Statement %statement, 0
  %t1070 = alloca %Statement
  store %Statement %statement, %Statement* %t1070
  %t1071 = getelementptr inbounds %Statement, %Statement* %t1070, i32 0, i32 1
  %t1072 = bitcast [56 x i8]* %t1071 to i8*
  %t1073 = getelementptr inbounds i8, i8* %t1072, i64 16
  %t1074 = bitcast i8* %t1073 to { %TypeParameter**, i64 }**
  %t1075 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1074
  %t1076 = icmp eq i32 %t1069, 8
  %t1077 = select i1 %t1076, { %TypeParameter**, i64 }* %t1075, { %TypeParameter**, i64 }* null
  %t1078 = getelementptr inbounds %Statement, %Statement* %t1070, i32 0, i32 1
  %t1079 = bitcast [40 x i8]* %t1078 to i8*
  %t1080 = getelementptr inbounds i8, i8* %t1079, i64 16
  %t1081 = bitcast i8* %t1080 to { %TypeParameter**, i64 }**
  %t1082 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1081
  %t1083 = icmp eq i32 %t1069, 9
  %t1084 = select i1 %t1083, { %TypeParameter**, i64 }* %t1082, { %TypeParameter**, i64 }* %t1077
  %t1085 = getelementptr inbounds %Statement, %Statement* %t1070, i32 0, i32 1
  %t1086 = bitcast [40 x i8]* %t1085 to i8*
  %t1087 = getelementptr inbounds i8, i8* %t1086, i64 16
  %t1088 = bitcast i8* %t1087 to { %TypeParameter**, i64 }**
  %t1089 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1088
  %t1090 = icmp eq i32 %t1069, 10
  %t1091 = select i1 %t1090, { %TypeParameter**, i64 }* %t1089, { %TypeParameter**, i64 }* %t1084
  %t1092 = getelementptr inbounds %Statement, %Statement* %t1070, i32 0, i32 1
  %t1093 = bitcast [40 x i8]* %t1092 to i8*
  %t1094 = getelementptr inbounds i8, i8* %t1093, i64 16
  %t1095 = bitcast i8* %t1094 to { %TypeParameter**, i64 }**
  %t1096 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1095
  %t1097 = icmp eq i32 %t1069, 11
  %t1098 = select i1 %t1097, { %TypeParameter**, i64 }* %t1096, { %TypeParameter**, i64 }* %t1091
  %t1099 = bitcast { %TypeParameter**, i64 }* %t1098 to { %TypeParameter*, i64 }*
  %t1100 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t1099)
  %t1101 = bitcast { %Diagnostic**, i64 }* %t1068 to { i8**, i64 }*
  %t1102 = bitcast { %Diagnostic*, i64 }* %t1100 to { i8**, i64 }*
  %t1103 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1101, { i8**, i64 }* %t1102)
  %t1104 = bitcast { i8**, i64 }* %t1103 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1104, { %Diagnostic**, i64 }** %l10
  %t1105 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l10
  %t1106 = extractvalue %Statement %statement, 0
  %t1107 = alloca %Statement
  store %Statement %statement, %Statement* %t1107
  %t1108 = getelementptr inbounds %Statement, %Statement* %t1107, i32 0, i32 1
  %t1109 = bitcast [40 x i8]* %t1108 to i8*
  %t1110 = getelementptr inbounds i8, i8* %t1109, i64 24
  %t1111 = bitcast i8* %t1110 to { %FunctionSignature**, i64 }**
  %t1112 = load { %FunctionSignature**, i64 }*, { %FunctionSignature**, i64 }** %t1111
  %t1113 = icmp eq i32 %t1106, 10
  %t1114 = select i1 %t1113, { %FunctionSignature**, i64 }* %t1112, { %FunctionSignature**, i64 }* null
  %t1115 = bitcast { %FunctionSignature**, i64 }* %t1114 to { %FunctionSignature*, i64 }*
  %t1116 = call { %Diagnostic*, i64 }* @check_interface_members({ %FunctionSignature*, i64 }* %t1115)
  %t1117 = bitcast { %Diagnostic**, i64 }* %t1105 to { i8**, i64 }*
  %t1118 = bitcast { %Diagnostic*, i64 }* %t1116 to { i8**, i64 }*
  %t1119 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1117, { i8**, i64 }* %t1118)
  %t1120 = bitcast { i8**, i64 }* %t1119 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1120, { %Diagnostic**, i64 }** %l10
  %t1121 = load %ScopeResult, %ScopeResult* %l9
  %t1122 = extractvalue %ScopeResult %t1121, 0
  %t1123 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1122, 0
  %t1124 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l10
  %t1125 = insertvalue %ScopeResult %t1123, { %Diagnostic**, i64 }* %t1124, 1
  ret %ScopeResult %t1125
merge15:
  %t1126 = extractvalue %Statement %statement, 0
  %t1127 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1128 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1129 = icmp eq i32 %t1126, 0
  %t1130 = select i1 %t1129, i8* %t1128, i8* %t1127
  %t1131 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1132 = icmp eq i32 %t1126, 1
  %t1133 = select i1 %t1132, i8* %t1131, i8* %t1130
  %t1134 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1135 = icmp eq i32 %t1126, 2
  %t1136 = select i1 %t1135, i8* %t1134, i8* %t1133
  %t1137 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1138 = icmp eq i32 %t1126, 3
  %t1139 = select i1 %t1138, i8* %t1137, i8* %t1136
  %t1140 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1141 = icmp eq i32 %t1126, 4
  %t1142 = select i1 %t1141, i8* %t1140, i8* %t1139
  %t1143 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1144 = icmp eq i32 %t1126, 5
  %t1145 = select i1 %t1144, i8* %t1143, i8* %t1142
  %t1146 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1147 = icmp eq i32 %t1126, 6
  %t1148 = select i1 %t1147, i8* %t1146, i8* %t1145
  %t1149 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1150 = icmp eq i32 %t1126, 7
  %t1151 = select i1 %t1150, i8* %t1149, i8* %t1148
  %t1152 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1153 = icmp eq i32 %t1126, 8
  %t1154 = select i1 %t1153, i8* %t1152, i8* %t1151
  %t1155 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1156 = icmp eq i32 %t1126, 9
  %t1157 = select i1 %t1156, i8* %t1155, i8* %t1154
  %t1158 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1159 = icmp eq i32 %t1126, 10
  %t1160 = select i1 %t1159, i8* %t1158, i8* %t1157
  %t1161 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1162 = icmp eq i32 %t1126, 11
  %t1163 = select i1 %t1162, i8* %t1161, i8* %t1160
  %t1164 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1165 = icmp eq i32 %t1126, 12
  %t1166 = select i1 %t1165, i8* %t1164, i8* %t1163
  %t1167 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1168 = icmp eq i32 %t1126, 13
  %t1169 = select i1 %t1168, i8* %t1167, i8* %t1166
  %t1170 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1171 = icmp eq i32 %t1126, 14
  %t1172 = select i1 %t1171, i8* %t1170, i8* %t1169
  %t1173 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1174 = icmp eq i32 %t1126, 15
  %t1175 = select i1 %t1174, i8* %t1173, i8* %t1172
  %t1176 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1177 = icmp eq i32 %t1126, 16
  %t1178 = select i1 %t1177, i8* %t1176, i8* %t1175
  %t1179 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1180 = icmp eq i32 %t1126, 17
  %t1181 = select i1 %t1180, i8* %t1179, i8* %t1178
  %t1182 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1183 = icmp eq i32 %t1126, 18
  %t1184 = select i1 %t1183, i8* %t1182, i8* %t1181
  %t1185 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1186 = icmp eq i32 %t1126, 19
  %t1187 = select i1 %t1186, i8* %t1185, i8* %t1184
  %t1188 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1189 = icmp eq i32 %t1126, 20
  %t1190 = select i1 %t1189, i8* %t1188, i8* %t1187
  %t1191 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1192 = icmp eq i32 %t1126, 21
  %t1193 = select i1 %t1192, i8* %t1191, i8* %t1190
  %t1194 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1195 = icmp eq i32 %t1126, 22
  %t1196 = select i1 %t1195, i8* %t1194, i8* %t1193
  %s1197 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h2043328844, i32 0, i32 0
  %t1198 = call i1 @strings_equal(i8* %t1196, i8* %s1197)
  br i1 %t1198, label %then16, label %merge17
then16:
  %t1199 = extractvalue %Statement %statement, 0
  %t1200 = alloca %Statement
  store %Statement %statement, %Statement* %t1200
  %t1201 = getelementptr inbounds %Statement, %Statement* %t1200, i32 0, i32 1
  %t1202 = bitcast [48 x i8]* %t1201 to i8*
  %t1203 = bitcast i8* %t1202 to i8**
  %t1204 = load i8*, i8** %t1203
  %t1205 = icmp eq i32 %t1199, 2
  %t1206 = select i1 %t1205, i8* %t1204, i8* null
  %t1207 = getelementptr inbounds %Statement, %Statement* %t1200, i32 0, i32 1
  %t1208 = bitcast [48 x i8]* %t1207 to i8*
  %t1209 = bitcast i8* %t1208 to i8**
  %t1210 = load i8*, i8** %t1209
  %t1211 = icmp eq i32 %t1199, 3
  %t1212 = select i1 %t1211, i8* %t1210, i8* %t1206
  %t1213 = getelementptr inbounds %Statement, %Statement* %t1200, i32 0, i32 1
  %t1214 = bitcast [40 x i8]* %t1213 to i8*
  %t1215 = bitcast i8* %t1214 to i8**
  %t1216 = load i8*, i8** %t1215
  %t1217 = icmp eq i32 %t1199, 6
  %t1218 = select i1 %t1217, i8* %t1216, i8* %t1212
  %t1219 = getelementptr inbounds %Statement, %Statement* %t1200, i32 0, i32 1
  %t1220 = bitcast [56 x i8]* %t1219 to i8*
  %t1221 = bitcast i8* %t1220 to i8**
  %t1222 = load i8*, i8** %t1221
  %t1223 = icmp eq i32 %t1199, 8
  %t1224 = select i1 %t1223, i8* %t1222, i8* %t1218
  %t1225 = getelementptr inbounds %Statement, %Statement* %t1200, i32 0, i32 1
  %t1226 = bitcast [40 x i8]* %t1225 to i8*
  %t1227 = bitcast i8* %t1226 to i8**
  %t1228 = load i8*, i8** %t1227
  %t1229 = icmp eq i32 %t1199, 9
  %t1230 = select i1 %t1229, i8* %t1228, i8* %t1224
  %t1231 = getelementptr inbounds %Statement, %Statement* %t1200, i32 0, i32 1
  %t1232 = bitcast [40 x i8]* %t1231 to i8*
  %t1233 = bitcast i8* %t1232 to i8**
  %t1234 = load i8*, i8** %t1233
  %t1235 = icmp eq i32 %t1199, 10
  %t1236 = select i1 %t1235, i8* %t1234, i8* %t1230
  %t1237 = getelementptr inbounds %Statement, %Statement* %t1200, i32 0, i32 1
  %t1238 = bitcast [40 x i8]* %t1237 to i8*
  %t1239 = bitcast i8* %t1238 to i8**
  %t1240 = load i8*, i8** %t1239
  %t1241 = icmp eq i32 %t1199, 11
  %t1242 = select i1 %t1241, i8* %t1240, i8* %t1236
  %s1243 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h238194529, i32 0, i32 0
  %t1244 = extractvalue %Statement %statement, 0
  %t1245 = alloca %Statement
  store %Statement %statement, %Statement* %t1245
  %t1246 = getelementptr inbounds %Statement, %Statement* %t1245, i32 0, i32 1
  %t1247 = bitcast [48 x i8]* %t1246 to i8*
  %t1248 = getelementptr inbounds i8, i8* %t1247, i64 8
  %t1249 = bitcast i8* %t1248 to %SourceSpan**
  %t1250 = load %SourceSpan*, %SourceSpan** %t1249
  %t1251 = icmp eq i32 %t1244, 3
  %t1252 = select i1 %t1251, %SourceSpan* %t1250, %SourceSpan* null
  %t1253 = getelementptr inbounds %Statement, %Statement* %t1245, i32 0, i32 1
  %t1254 = bitcast [40 x i8]* %t1253 to i8*
  %t1255 = getelementptr inbounds i8, i8* %t1254, i64 8
  %t1256 = bitcast i8* %t1255 to %SourceSpan**
  %t1257 = load %SourceSpan*, %SourceSpan** %t1256
  %t1258 = icmp eq i32 %t1244, 6
  %t1259 = select i1 %t1258, %SourceSpan* %t1257, %SourceSpan* %t1252
  %t1260 = getelementptr inbounds %Statement, %Statement* %t1245, i32 0, i32 1
  %t1261 = bitcast [56 x i8]* %t1260 to i8*
  %t1262 = getelementptr inbounds i8, i8* %t1261, i64 8
  %t1263 = bitcast i8* %t1262 to %SourceSpan**
  %t1264 = load %SourceSpan*, %SourceSpan** %t1263
  %t1265 = icmp eq i32 %t1244, 8
  %t1266 = select i1 %t1265, %SourceSpan* %t1264, %SourceSpan* %t1259
  %t1267 = getelementptr inbounds %Statement, %Statement* %t1245, i32 0, i32 1
  %t1268 = bitcast [40 x i8]* %t1267 to i8*
  %t1269 = getelementptr inbounds i8, i8* %t1268, i64 8
  %t1270 = bitcast i8* %t1269 to %SourceSpan**
  %t1271 = load %SourceSpan*, %SourceSpan** %t1270
  %t1272 = icmp eq i32 %t1244, 9
  %t1273 = select i1 %t1272, %SourceSpan* %t1271, %SourceSpan* %t1266
  %t1274 = getelementptr inbounds %Statement, %Statement* %t1245, i32 0, i32 1
  %t1275 = bitcast [40 x i8]* %t1274 to i8*
  %t1276 = getelementptr inbounds i8, i8* %t1275, i64 8
  %t1277 = bitcast i8* %t1276 to %SourceSpan**
  %t1278 = load %SourceSpan*, %SourceSpan** %t1277
  %t1279 = icmp eq i32 %t1244, 10
  %t1280 = select i1 %t1279, %SourceSpan* %t1278, %SourceSpan* %t1273
  %t1281 = getelementptr inbounds %Statement, %Statement* %t1245, i32 0, i32 1
  %t1282 = bitcast [40 x i8]* %t1281 to i8*
  %t1283 = getelementptr inbounds i8, i8* %t1282, i64 8
  %t1284 = bitcast i8* %t1283 to %SourceSpan**
  %t1285 = load %SourceSpan*, %SourceSpan** %t1284
  %t1286 = icmp eq i32 %t1244, 11
  %t1287 = select i1 %t1286, %SourceSpan* %t1285, %SourceSpan* %t1280
  %t1288 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1242, i8* %s1243, %SourceSpan* %t1287)
  store %ScopeResult %t1288, %ScopeResult* %l11
  %t1289 = load %ScopeResult, %ScopeResult* %l11
  %t1290 = extractvalue %ScopeResult %t1289, 1
  %t1291 = extractvalue %Statement %statement, 0
  %t1292 = alloca %Statement
  store %Statement %statement, %Statement* %t1292
  %t1293 = getelementptr inbounds %Statement, %Statement* %t1292, i32 0, i32 1
  %t1294 = bitcast [48 x i8]* %t1293 to i8*
  %t1295 = getelementptr inbounds i8, i8* %t1294, i64 24
  %t1296 = bitcast i8* %t1295 to { %ModelProperty**, i64 }**
  %t1297 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1296
  %t1298 = icmp eq i32 %t1291, 3
  %t1299 = select i1 %t1298, { %ModelProperty**, i64 }* %t1297, { %ModelProperty**, i64 }* null
  %t1300 = bitcast { %ModelProperty**, i64 }* %t1299 to { %ModelProperty*, i64 }*
  %t1301 = call { %Diagnostic*, i64 }* @check_model_properties({ %ModelProperty*, i64 }* %t1300)
  %t1302 = bitcast { %Diagnostic**, i64 }* %t1290 to { i8**, i64 }*
  %t1303 = bitcast { %Diagnostic*, i64 }* %t1301 to { i8**, i64 }*
  %t1304 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1302, { i8**, i64 }* %t1303)
  store { i8**, i64 }* %t1304, { i8**, i64 }** %l12
  %t1305 = load %ScopeResult, %ScopeResult* %l11
  %t1306 = extractvalue %ScopeResult %t1305, 0
  %t1307 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1306, 0
  %t1308 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %t1309 = bitcast { i8**, i64 }* %t1308 to { %Diagnostic**, i64 }*
  %t1310 = insertvalue %ScopeResult %t1307, { %Diagnostic**, i64 }* %t1309, 1
  ret %ScopeResult %t1310
merge17:
  %t1311 = extractvalue %Statement %statement, 0
  %t1312 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1313 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1314 = icmp eq i32 %t1311, 0
  %t1315 = select i1 %t1314, i8* %t1313, i8* %t1312
  %t1316 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1317 = icmp eq i32 %t1311, 1
  %t1318 = select i1 %t1317, i8* %t1316, i8* %t1315
  %t1319 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1320 = icmp eq i32 %t1311, 2
  %t1321 = select i1 %t1320, i8* %t1319, i8* %t1318
  %t1322 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1323 = icmp eq i32 %t1311, 3
  %t1324 = select i1 %t1323, i8* %t1322, i8* %t1321
  %t1325 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1326 = icmp eq i32 %t1311, 4
  %t1327 = select i1 %t1326, i8* %t1325, i8* %t1324
  %t1328 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1329 = icmp eq i32 %t1311, 5
  %t1330 = select i1 %t1329, i8* %t1328, i8* %t1327
  %t1331 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1332 = icmp eq i32 %t1311, 6
  %t1333 = select i1 %t1332, i8* %t1331, i8* %t1330
  %t1334 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1335 = icmp eq i32 %t1311, 7
  %t1336 = select i1 %t1335, i8* %t1334, i8* %t1333
  %t1337 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1338 = icmp eq i32 %t1311, 8
  %t1339 = select i1 %t1338, i8* %t1337, i8* %t1336
  %t1340 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1341 = icmp eq i32 %t1311, 9
  %t1342 = select i1 %t1341, i8* %t1340, i8* %t1339
  %t1343 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1344 = icmp eq i32 %t1311, 10
  %t1345 = select i1 %t1344, i8* %t1343, i8* %t1342
  %t1346 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1347 = icmp eq i32 %t1311, 11
  %t1348 = select i1 %t1347, i8* %t1346, i8* %t1345
  %t1349 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1350 = icmp eq i32 %t1311, 12
  %t1351 = select i1 %t1350, i8* %t1349, i8* %t1348
  %t1352 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1353 = icmp eq i32 %t1311, 13
  %t1354 = select i1 %t1353, i8* %t1352, i8* %t1351
  %t1355 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1356 = icmp eq i32 %t1311, 14
  %t1357 = select i1 %t1356, i8* %t1355, i8* %t1354
  %t1358 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1359 = icmp eq i32 %t1311, 15
  %t1360 = select i1 %t1359, i8* %t1358, i8* %t1357
  %t1361 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1362 = icmp eq i32 %t1311, 16
  %t1363 = select i1 %t1362, i8* %t1361, i8* %t1360
  %t1364 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1365 = icmp eq i32 %t1311, 17
  %t1366 = select i1 %t1365, i8* %t1364, i8* %t1363
  %t1367 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1368 = icmp eq i32 %t1311, 18
  %t1369 = select i1 %t1368, i8* %t1367, i8* %t1366
  %t1370 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1371 = icmp eq i32 %t1311, 19
  %t1372 = select i1 %t1371, i8* %t1370, i8* %t1369
  %t1373 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1374 = icmp eq i32 %t1311, 20
  %t1375 = select i1 %t1374, i8* %t1373, i8* %t1372
  %t1376 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1377 = icmp eq i32 %t1311, 21
  %t1378 = select i1 %t1377, i8* %t1376, i8* %t1375
  %t1379 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1380 = icmp eq i32 %t1311, 22
  %t1381 = select i1 %t1380, i8* %t1379, i8* %t1378
  %s1382 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h479148896, i32 0, i32 0
  %t1383 = call i1 @strings_equal(i8* %t1381, i8* %s1382)
  br i1 %t1383, label %then18, label %merge19
then18:
  %t1384 = extractvalue %Statement %statement, 0
  %t1385 = alloca %Statement
  store %Statement %statement, %Statement* %t1385
  %t1386 = getelementptr inbounds %Statement, %Statement* %t1385, i32 0, i32 1
  %t1387 = bitcast [24 x i8]* %t1386 to i8*
  %t1388 = bitcast i8* %t1387 to %FunctionSignature*
  %t1389 = load %FunctionSignature, %FunctionSignature* %t1388
  %t1390 = icmp eq i32 %t1384, 4
  %t1391 = select i1 %t1390, %FunctionSignature %t1389, %FunctionSignature zeroinitializer
  %t1392 = getelementptr inbounds %Statement, %Statement* %t1385, i32 0, i32 1
  %t1393 = bitcast [24 x i8]* %t1392 to i8*
  %t1394 = bitcast i8* %t1393 to %FunctionSignature*
  %t1395 = load %FunctionSignature, %FunctionSignature* %t1394
  %t1396 = icmp eq i32 %t1384, 5
  %t1397 = select i1 %t1396, %FunctionSignature %t1395, %FunctionSignature %t1391
  %t1398 = getelementptr inbounds %Statement, %Statement* %t1385, i32 0, i32 1
  %t1399 = bitcast [24 x i8]* %t1398 to i8*
  %t1400 = bitcast i8* %t1399 to %FunctionSignature*
  %t1401 = load %FunctionSignature, %FunctionSignature* %t1400
  %t1402 = icmp eq i32 %t1384, 7
  %t1403 = select i1 %t1402, %FunctionSignature %t1401, %FunctionSignature %t1397
  %t1404 = extractvalue %FunctionSignature %t1403, 0
  %s1405 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h2003786807, i32 0, i32 0
  %t1406 = extractvalue %Statement %statement, 0
  %t1407 = alloca %Statement
  store %Statement %statement, %Statement* %t1407
  %t1408 = getelementptr inbounds %Statement, %Statement* %t1407, i32 0, i32 1
  %t1409 = bitcast [24 x i8]* %t1408 to i8*
  %t1410 = bitcast i8* %t1409 to %FunctionSignature*
  %t1411 = load %FunctionSignature, %FunctionSignature* %t1410
  %t1412 = icmp eq i32 %t1406, 4
  %t1413 = select i1 %t1412, %FunctionSignature %t1411, %FunctionSignature zeroinitializer
  %t1414 = getelementptr inbounds %Statement, %Statement* %t1407, i32 0, i32 1
  %t1415 = bitcast [24 x i8]* %t1414 to i8*
  %t1416 = bitcast i8* %t1415 to %FunctionSignature*
  %t1417 = load %FunctionSignature, %FunctionSignature* %t1416
  %t1418 = icmp eq i32 %t1406, 5
  %t1419 = select i1 %t1418, %FunctionSignature %t1417, %FunctionSignature %t1413
  %t1420 = getelementptr inbounds %Statement, %Statement* %t1407, i32 0, i32 1
  %t1421 = bitcast [24 x i8]* %t1420 to i8*
  %t1422 = bitcast i8* %t1421 to %FunctionSignature*
  %t1423 = load %FunctionSignature, %FunctionSignature* %t1422
  %t1424 = icmp eq i32 %t1406, 7
  %t1425 = select i1 %t1424, %FunctionSignature %t1423, %FunctionSignature %t1419
  %t1426 = extractvalue %FunctionSignature %t1425, 6
  %t1427 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1404, i8* %s1405, %SourceSpan* %t1426)
  store %ScopeResult %t1427, %ScopeResult* %l13
  %t1428 = load %ScopeResult, %ScopeResult* %l13
  %t1429 = extractvalue %ScopeResult %t1428, 1
  store { %Diagnostic**, i64 }* %t1429, { %Diagnostic**, i64 }** %l14
  %t1430 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l14
  %t1431 = extractvalue %Statement %statement, 0
  %t1432 = alloca %Statement
  store %Statement %statement, %Statement* %t1432
  %t1433 = getelementptr inbounds %Statement, %Statement* %t1432, i32 0, i32 1
  %t1434 = bitcast [24 x i8]* %t1433 to i8*
  %t1435 = bitcast i8* %t1434 to %FunctionSignature*
  %t1436 = load %FunctionSignature, %FunctionSignature* %t1435
  %t1437 = icmp eq i32 %t1431, 4
  %t1438 = select i1 %t1437, %FunctionSignature %t1436, %FunctionSignature zeroinitializer
  %t1439 = getelementptr inbounds %Statement, %Statement* %t1432, i32 0, i32 1
  %t1440 = bitcast [24 x i8]* %t1439 to i8*
  %t1441 = bitcast i8* %t1440 to %FunctionSignature*
  %t1442 = load %FunctionSignature, %FunctionSignature* %t1441
  %t1443 = icmp eq i32 %t1431, 5
  %t1444 = select i1 %t1443, %FunctionSignature %t1442, %FunctionSignature %t1438
  %t1445 = getelementptr inbounds %Statement, %Statement* %t1432, i32 0, i32 1
  %t1446 = bitcast [24 x i8]* %t1445 to i8*
  %t1447 = bitcast i8* %t1446 to %FunctionSignature*
  %t1448 = load %FunctionSignature, %FunctionSignature* %t1447
  %t1449 = icmp eq i32 %t1431, 7
  %t1450 = select i1 %t1449, %FunctionSignature %t1448, %FunctionSignature %t1444
  %t1451 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t1450)
  %t1452 = bitcast { %Diagnostic**, i64 }* %t1430 to { i8**, i64 }*
  %t1453 = bitcast { %Diagnostic*, i64 }* %t1451 to { i8**, i64 }*
  %t1454 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1452, { i8**, i64 }* %t1453)
  %t1455 = bitcast { i8**, i64 }* %t1454 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1455, { %Diagnostic**, i64 }** %l14
  %t1456 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l14
  %t1457 = extractvalue %Statement %statement, 0
  %t1458 = alloca %Statement
  store %Statement %statement, %Statement* %t1458
  %t1459 = getelementptr inbounds %Statement, %Statement* %t1458, i32 0, i32 1
  %t1460 = bitcast [24 x i8]* %t1459 to i8*
  %t1461 = bitcast i8* %t1460 to %FunctionSignature*
  %t1462 = load %FunctionSignature, %FunctionSignature* %t1461
  %t1463 = icmp eq i32 %t1457, 4
  %t1464 = select i1 %t1463, %FunctionSignature %t1462, %FunctionSignature zeroinitializer
  %t1465 = getelementptr inbounds %Statement, %Statement* %t1458, i32 0, i32 1
  %t1466 = bitcast [24 x i8]* %t1465 to i8*
  %t1467 = bitcast i8* %t1466 to %FunctionSignature*
  %t1468 = load %FunctionSignature, %FunctionSignature* %t1467
  %t1469 = icmp eq i32 %t1457, 5
  %t1470 = select i1 %t1469, %FunctionSignature %t1468, %FunctionSignature %t1464
  %t1471 = getelementptr inbounds %Statement, %Statement* %t1458, i32 0, i32 1
  %t1472 = bitcast [24 x i8]* %t1471 to i8*
  %t1473 = bitcast i8* %t1472 to %FunctionSignature*
  %t1474 = load %FunctionSignature, %FunctionSignature* %t1473
  %t1475 = icmp eq i32 %t1457, 7
  %t1476 = select i1 %t1475, %FunctionSignature %t1474, %FunctionSignature %t1470
  %t1477 = extractvalue %Statement %statement, 0
  %t1478 = alloca %Statement
  store %Statement %statement, %Statement* %t1478
  %t1479 = getelementptr inbounds %Statement, %Statement* %t1478, i32 0, i32 1
  %t1480 = bitcast [24 x i8]* %t1479 to i8*
  %t1481 = getelementptr inbounds i8, i8* %t1480, i64 8
  %t1482 = bitcast i8* %t1481 to %Block*
  %t1483 = load %Block, %Block* %t1482
  %t1484 = icmp eq i32 %t1477, 4
  %t1485 = select i1 %t1484, %Block %t1483, %Block zeroinitializer
  %t1486 = getelementptr inbounds %Statement, %Statement* %t1478, i32 0, i32 1
  %t1487 = bitcast [24 x i8]* %t1486 to i8*
  %t1488 = getelementptr inbounds i8, i8* %t1487, i64 8
  %t1489 = bitcast i8* %t1488 to %Block*
  %t1490 = load %Block, %Block* %t1489
  %t1491 = icmp eq i32 %t1477, 5
  %t1492 = select i1 %t1491, %Block %t1490, %Block %t1485
  %t1493 = getelementptr inbounds %Statement, %Statement* %t1478, i32 0, i32 1
  %t1494 = bitcast [40 x i8]* %t1493 to i8*
  %t1495 = getelementptr inbounds i8, i8* %t1494, i64 16
  %t1496 = bitcast i8* %t1495 to %Block*
  %t1497 = load %Block, %Block* %t1496
  %t1498 = icmp eq i32 %t1477, 6
  %t1499 = select i1 %t1498, %Block %t1497, %Block %t1492
  %t1500 = getelementptr inbounds %Statement, %Statement* %t1478, i32 0, i32 1
  %t1501 = bitcast [24 x i8]* %t1500 to i8*
  %t1502 = getelementptr inbounds i8, i8* %t1501, i64 8
  %t1503 = bitcast i8* %t1502 to %Block*
  %t1504 = load %Block, %Block* %t1503
  %t1505 = icmp eq i32 %t1477, 7
  %t1506 = select i1 %t1505, %Block %t1504, %Block %t1499
  %t1507 = getelementptr inbounds %Statement, %Statement* %t1478, i32 0, i32 1
  %t1508 = bitcast [40 x i8]* %t1507 to i8*
  %t1509 = getelementptr inbounds i8, i8* %t1508, i64 24
  %t1510 = bitcast i8* %t1509 to %Block*
  %t1511 = load %Block, %Block* %t1510
  %t1512 = icmp eq i32 %t1477, 12
  %t1513 = select i1 %t1512, %Block %t1511, %Block %t1506
  %t1514 = getelementptr inbounds %Statement, %Statement* %t1478, i32 0, i32 1
  %t1515 = bitcast [24 x i8]* %t1514 to i8*
  %t1516 = getelementptr inbounds i8, i8* %t1515, i64 8
  %t1517 = bitcast i8* %t1516 to %Block*
  %t1518 = load %Block, %Block* %t1517
  %t1519 = icmp eq i32 %t1477, 13
  %t1520 = select i1 %t1519, %Block %t1518, %Block %t1513
  %t1521 = getelementptr inbounds %Statement, %Statement* %t1478, i32 0, i32 1
  %t1522 = bitcast [24 x i8]* %t1521 to i8*
  %t1523 = getelementptr inbounds i8, i8* %t1522, i64 8
  %t1524 = bitcast i8* %t1523 to %Block*
  %t1525 = load %Block, %Block* %t1524
  %t1526 = icmp eq i32 %t1477, 14
  %t1527 = select i1 %t1526, %Block %t1525, %Block %t1520
  %t1528 = getelementptr inbounds %Statement, %Statement* %t1478, i32 0, i32 1
  %t1529 = bitcast [16 x i8]* %t1528 to i8*
  %t1530 = bitcast i8* %t1529 to %Block*
  %t1531 = load %Block, %Block* %t1530
  %t1532 = icmp eq i32 %t1477, 15
  %t1533 = select i1 %t1532, %Block %t1531, %Block %t1527
  %t1534 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t1476, %Block %t1533, { %Statement*, i64 }* %interfaces)
  %t1535 = bitcast { %Diagnostic**, i64 }* %t1456 to { i8**, i64 }*
  %t1536 = bitcast { %Diagnostic*, i64 }* %t1534 to { i8**, i64 }*
  %t1537 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1535, { i8**, i64 }* %t1536)
  %t1538 = bitcast { i8**, i64 }* %t1537 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1538, { %Diagnostic**, i64 }** %l14
  %t1539 = load %ScopeResult, %ScopeResult* %l13
  %t1540 = extractvalue %ScopeResult %t1539, 0
  %t1541 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1540, 0
  %t1542 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l14
  %t1543 = insertvalue %ScopeResult %t1541, { %Diagnostic**, i64 }* %t1542, 1
  ret %ScopeResult %t1543
merge19:
  %t1544 = extractvalue %Statement %statement, 0
  %t1545 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1546 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1547 = icmp eq i32 %t1544, 0
  %t1548 = select i1 %t1547, i8* %t1546, i8* %t1545
  %t1549 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1550 = icmp eq i32 %t1544, 1
  %t1551 = select i1 %t1550, i8* %t1549, i8* %t1548
  %t1552 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1553 = icmp eq i32 %t1544, 2
  %t1554 = select i1 %t1553, i8* %t1552, i8* %t1551
  %t1555 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1556 = icmp eq i32 %t1544, 3
  %t1557 = select i1 %t1556, i8* %t1555, i8* %t1554
  %t1558 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1559 = icmp eq i32 %t1544, 4
  %t1560 = select i1 %t1559, i8* %t1558, i8* %t1557
  %t1561 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1562 = icmp eq i32 %t1544, 5
  %t1563 = select i1 %t1562, i8* %t1561, i8* %t1560
  %t1564 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1565 = icmp eq i32 %t1544, 6
  %t1566 = select i1 %t1565, i8* %t1564, i8* %t1563
  %t1567 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1568 = icmp eq i32 %t1544, 7
  %t1569 = select i1 %t1568, i8* %t1567, i8* %t1566
  %t1570 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1571 = icmp eq i32 %t1544, 8
  %t1572 = select i1 %t1571, i8* %t1570, i8* %t1569
  %t1573 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1574 = icmp eq i32 %t1544, 9
  %t1575 = select i1 %t1574, i8* %t1573, i8* %t1572
  %t1576 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1577 = icmp eq i32 %t1544, 10
  %t1578 = select i1 %t1577, i8* %t1576, i8* %t1575
  %t1579 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1580 = icmp eq i32 %t1544, 11
  %t1581 = select i1 %t1580, i8* %t1579, i8* %t1578
  %t1582 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1583 = icmp eq i32 %t1544, 12
  %t1584 = select i1 %t1583, i8* %t1582, i8* %t1581
  %t1585 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1586 = icmp eq i32 %t1544, 13
  %t1587 = select i1 %t1586, i8* %t1585, i8* %t1584
  %t1588 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1589 = icmp eq i32 %t1544, 14
  %t1590 = select i1 %t1589, i8* %t1588, i8* %t1587
  %t1591 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1592 = icmp eq i32 %t1544, 15
  %t1593 = select i1 %t1592, i8* %t1591, i8* %t1590
  %t1594 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1595 = icmp eq i32 %t1544, 16
  %t1596 = select i1 %t1595, i8* %t1594, i8* %t1593
  %t1597 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1598 = icmp eq i32 %t1544, 17
  %t1599 = select i1 %t1598, i8* %t1597, i8* %t1596
  %t1600 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1601 = icmp eq i32 %t1544, 18
  %t1602 = select i1 %t1601, i8* %t1600, i8* %t1599
  %t1603 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1604 = icmp eq i32 %t1544, 19
  %t1605 = select i1 %t1604, i8* %t1603, i8* %t1602
  %t1606 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1607 = icmp eq i32 %t1544, 20
  %t1608 = select i1 %t1607, i8* %t1606, i8* %t1605
  %t1609 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1610 = icmp eq i32 %t1544, 21
  %t1611 = select i1 %t1610, i8* %t1609, i8* %t1608
  %t1612 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1613 = icmp eq i32 %t1544, 22
  %t1614 = select i1 %t1613, i8* %t1612, i8* %t1611
  %s1615 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h571715647, i32 0, i32 0
  %t1616 = call i1 @strings_equal(i8* %t1614, i8* %s1615)
  br i1 %t1616, label %then20, label %merge21
then20:
  %t1617 = extractvalue %Statement %statement, 0
  %t1618 = alloca %Statement
  store %Statement %statement, %Statement* %t1618
  %t1619 = getelementptr inbounds %Statement, %Statement* %t1618, i32 0, i32 1
  %t1620 = bitcast [24 x i8]* %t1619 to i8*
  %t1621 = bitcast i8* %t1620 to %FunctionSignature*
  %t1622 = load %FunctionSignature, %FunctionSignature* %t1621
  %t1623 = icmp eq i32 %t1617, 4
  %t1624 = select i1 %t1623, %FunctionSignature %t1622, %FunctionSignature zeroinitializer
  %t1625 = getelementptr inbounds %Statement, %Statement* %t1618, i32 0, i32 1
  %t1626 = bitcast [24 x i8]* %t1625 to i8*
  %t1627 = bitcast i8* %t1626 to %FunctionSignature*
  %t1628 = load %FunctionSignature, %FunctionSignature* %t1627
  %t1629 = icmp eq i32 %t1617, 5
  %t1630 = select i1 %t1629, %FunctionSignature %t1628, %FunctionSignature %t1624
  %t1631 = getelementptr inbounds %Statement, %Statement* %t1618, i32 0, i32 1
  %t1632 = bitcast [24 x i8]* %t1631 to i8*
  %t1633 = bitcast i8* %t1632 to %FunctionSignature*
  %t1634 = load %FunctionSignature, %FunctionSignature* %t1633
  %t1635 = icmp eq i32 %t1617, 7
  %t1636 = select i1 %t1635, %FunctionSignature %t1634, %FunctionSignature %t1630
  %t1637 = extractvalue %FunctionSignature %t1636, 0
  %s1638 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275832617, i32 0, i32 0
  %t1639 = extractvalue %Statement %statement, 0
  %t1640 = alloca %Statement
  store %Statement %statement, %Statement* %t1640
  %t1641 = getelementptr inbounds %Statement, %Statement* %t1640, i32 0, i32 1
  %t1642 = bitcast [24 x i8]* %t1641 to i8*
  %t1643 = bitcast i8* %t1642 to %FunctionSignature*
  %t1644 = load %FunctionSignature, %FunctionSignature* %t1643
  %t1645 = icmp eq i32 %t1639, 4
  %t1646 = select i1 %t1645, %FunctionSignature %t1644, %FunctionSignature zeroinitializer
  %t1647 = getelementptr inbounds %Statement, %Statement* %t1640, i32 0, i32 1
  %t1648 = bitcast [24 x i8]* %t1647 to i8*
  %t1649 = bitcast i8* %t1648 to %FunctionSignature*
  %t1650 = load %FunctionSignature, %FunctionSignature* %t1649
  %t1651 = icmp eq i32 %t1639, 5
  %t1652 = select i1 %t1651, %FunctionSignature %t1650, %FunctionSignature %t1646
  %t1653 = getelementptr inbounds %Statement, %Statement* %t1640, i32 0, i32 1
  %t1654 = bitcast [24 x i8]* %t1653 to i8*
  %t1655 = bitcast i8* %t1654 to %FunctionSignature*
  %t1656 = load %FunctionSignature, %FunctionSignature* %t1655
  %t1657 = icmp eq i32 %t1639, 7
  %t1658 = select i1 %t1657, %FunctionSignature %t1656, %FunctionSignature %t1652
  %t1659 = extractvalue %FunctionSignature %t1658, 6
  %t1660 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1637, i8* %s1638, %SourceSpan* %t1659)
  store %ScopeResult %t1660, %ScopeResult* %l15
  %t1661 = load %ScopeResult, %ScopeResult* %l15
  %t1662 = extractvalue %ScopeResult %t1661, 1
  store { %Diagnostic**, i64 }* %t1662, { %Diagnostic**, i64 }** %l16
  %t1663 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l16
  %t1664 = extractvalue %Statement %statement, 0
  %t1665 = alloca %Statement
  store %Statement %statement, %Statement* %t1665
  %t1666 = getelementptr inbounds %Statement, %Statement* %t1665, i32 0, i32 1
  %t1667 = bitcast [24 x i8]* %t1666 to i8*
  %t1668 = bitcast i8* %t1667 to %FunctionSignature*
  %t1669 = load %FunctionSignature, %FunctionSignature* %t1668
  %t1670 = icmp eq i32 %t1664, 4
  %t1671 = select i1 %t1670, %FunctionSignature %t1669, %FunctionSignature zeroinitializer
  %t1672 = getelementptr inbounds %Statement, %Statement* %t1665, i32 0, i32 1
  %t1673 = bitcast [24 x i8]* %t1672 to i8*
  %t1674 = bitcast i8* %t1673 to %FunctionSignature*
  %t1675 = load %FunctionSignature, %FunctionSignature* %t1674
  %t1676 = icmp eq i32 %t1664, 5
  %t1677 = select i1 %t1676, %FunctionSignature %t1675, %FunctionSignature %t1671
  %t1678 = getelementptr inbounds %Statement, %Statement* %t1665, i32 0, i32 1
  %t1679 = bitcast [24 x i8]* %t1678 to i8*
  %t1680 = bitcast i8* %t1679 to %FunctionSignature*
  %t1681 = load %FunctionSignature, %FunctionSignature* %t1680
  %t1682 = icmp eq i32 %t1664, 7
  %t1683 = select i1 %t1682, %FunctionSignature %t1681, %FunctionSignature %t1677
  %t1684 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t1683)
  %t1685 = bitcast { %Diagnostic**, i64 }* %t1663 to { i8**, i64 }*
  %t1686 = bitcast { %Diagnostic*, i64 }* %t1684 to { i8**, i64 }*
  %t1687 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1685, { i8**, i64 }* %t1686)
  %t1688 = bitcast { i8**, i64 }* %t1687 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1688, { %Diagnostic**, i64 }** %l16
  %t1689 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l16
  %t1690 = extractvalue %Statement %statement, 0
  %t1691 = alloca %Statement
  store %Statement %statement, %Statement* %t1691
  %t1692 = getelementptr inbounds %Statement, %Statement* %t1691, i32 0, i32 1
  %t1693 = bitcast [24 x i8]* %t1692 to i8*
  %t1694 = bitcast i8* %t1693 to %FunctionSignature*
  %t1695 = load %FunctionSignature, %FunctionSignature* %t1694
  %t1696 = icmp eq i32 %t1690, 4
  %t1697 = select i1 %t1696, %FunctionSignature %t1695, %FunctionSignature zeroinitializer
  %t1698 = getelementptr inbounds %Statement, %Statement* %t1691, i32 0, i32 1
  %t1699 = bitcast [24 x i8]* %t1698 to i8*
  %t1700 = bitcast i8* %t1699 to %FunctionSignature*
  %t1701 = load %FunctionSignature, %FunctionSignature* %t1700
  %t1702 = icmp eq i32 %t1690, 5
  %t1703 = select i1 %t1702, %FunctionSignature %t1701, %FunctionSignature %t1697
  %t1704 = getelementptr inbounds %Statement, %Statement* %t1691, i32 0, i32 1
  %t1705 = bitcast [24 x i8]* %t1704 to i8*
  %t1706 = bitcast i8* %t1705 to %FunctionSignature*
  %t1707 = load %FunctionSignature, %FunctionSignature* %t1706
  %t1708 = icmp eq i32 %t1690, 7
  %t1709 = select i1 %t1708, %FunctionSignature %t1707, %FunctionSignature %t1703
  %t1710 = extractvalue %Statement %statement, 0
  %t1711 = alloca %Statement
  store %Statement %statement, %Statement* %t1711
  %t1712 = getelementptr inbounds %Statement, %Statement* %t1711, i32 0, i32 1
  %t1713 = bitcast [24 x i8]* %t1712 to i8*
  %t1714 = getelementptr inbounds i8, i8* %t1713, i64 8
  %t1715 = bitcast i8* %t1714 to %Block*
  %t1716 = load %Block, %Block* %t1715
  %t1717 = icmp eq i32 %t1710, 4
  %t1718 = select i1 %t1717, %Block %t1716, %Block zeroinitializer
  %t1719 = getelementptr inbounds %Statement, %Statement* %t1711, i32 0, i32 1
  %t1720 = bitcast [24 x i8]* %t1719 to i8*
  %t1721 = getelementptr inbounds i8, i8* %t1720, i64 8
  %t1722 = bitcast i8* %t1721 to %Block*
  %t1723 = load %Block, %Block* %t1722
  %t1724 = icmp eq i32 %t1710, 5
  %t1725 = select i1 %t1724, %Block %t1723, %Block %t1718
  %t1726 = getelementptr inbounds %Statement, %Statement* %t1711, i32 0, i32 1
  %t1727 = bitcast [40 x i8]* %t1726 to i8*
  %t1728 = getelementptr inbounds i8, i8* %t1727, i64 16
  %t1729 = bitcast i8* %t1728 to %Block*
  %t1730 = load %Block, %Block* %t1729
  %t1731 = icmp eq i32 %t1710, 6
  %t1732 = select i1 %t1731, %Block %t1730, %Block %t1725
  %t1733 = getelementptr inbounds %Statement, %Statement* %t1711, i32 0, i32 1
  %t1734 = bitcast [24 x i8]* %t1733 to i8*
  %t1735 = getelementptr inbounds i8, i8* %t1734, i64 8
  %t1736 = bitcast i8* %t1735 to %Block*
  %t1737 = load %Block, %Block* %t1736
  %t1738 = icmp eq i32 %t1710, 7
  %t1739 = select i1 %t1738, %Block %t1737, %Block %t1732
  %t1740 = getelementptr inbounds %Statement, %Statement* %t1711, i32 0, i32 1
  %t1741 = bitcast [40 x i8]* %t1740 to i8*
  %t1742 = getelementptr inbounds i8, i8* %t1741, i64 24
  %t1743 = bitcast i8* %t1742 to %Block*
  %t1744 = load %Block, %Block* %t1743
  %t1745 = icmp eq i32 %t1710, 12
  %t1746 = select i1 %t1745, %Block %t1744, %Block %t1739
  %t1747 = getelementptr inbounds %Statement, %Statement* %t1711, i32 0, i32 1
  %t1748 = bitcast [24 x i8]* %t1747 to i8*
  %t1749 = getelementptr inbounds i8, i8* %t1748, i64 8
  %t1750 = bitcast i8* %t1749 to %Block*
  %t1751 = load %Block, %Block* %t1750
  %t1752 = icmp eq i32 %t1710, 13
  %t1753 = select i1 %t1752, %Block %t1751, %Block %t1746
  %t1754 = getelementptr inbounds %Statement, %Statement* %t1711, i32 0, i32 1
  %t1755 = bitcast [24 x i8]* %t1754 to i8*
  %t1756 = getelementptr inbounds i8, i8* %t1755, i64 8
  %t1757 = bitcast i8* %t1756 to %Block*
  %t1758 = load %Block, %Block* %t1757
  %t1759 = icmp eq i32 %t1710, 14
  %t1760 = select i1 %t1759, %Block %t1758, %Block %t1753
  %t1761 = getelementptr inbounds %Statement, %Statement* %t1711, i32 0, i32 1
  %t1762 = bitcast [16 x i8]* %t1761 to i8*
  %t1763 = bitcast i8* %t1762 to %Block*
  %t1764 = load %Block, %Block* %t1763
  %t1765 = icmp eq i32 %t1710, 15
  %t1766 = select i1 %t1765, %Block %t1764, %Block %t1760
  %t1767 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t1709, %Block %t1766, { %Statement*, i64 }* %interfaces)
  %t1768 = bitcast { %Diagnostic**, i64 }* %t1689 to { i8**, i64 }*
  %t1769 = bitcast { %Diagnostic*, i64 }* %t1767 to { i8**, i64 }*
  %t1770 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1768, { i8**, i64 }* %t1769)
  %t1771 = bitcast { i8**, i64 }* %t1770 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1771, { %Diagnostic**, i64 }** %l16
  %t1772 = load %ScopeResult, %ScopeResult* %l15
  %t1773 = extractvalue %ScopeResult %t1772, 0
  %t1774 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1773, 0
  %t1775 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l16
  %t1776 = insertvalue %ScopeResult %t1774, { %Diagnostic**, i64 }* %t1775, 1
  ret %ScopeResult %t1776
merge21:
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
  %s1848 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h889179835, i32 0, i32 0
  %t1849 = call i1 @strings_equal(i8* %t1847, i8* %s1848)
  br i1 %t1849, label %then22, label %merge23
then22:
  %t1850 = extractvalue %Statement %statement, 0
  %t1851 = alloca %Statement
  store %Statement %statement, %Statement* %t1851
  %t1852 = getelementptr inbounds %Statement, %Statement* %t1851, i32 0, i32 1
  %t1853 = bitcast [48 x i8]* %t1852 to i8*
  %t1854 = bitcast i8* %t1853 to i8**
  %t1855 = load i8*, i8** %t1854
  %t1856 = icmp eq i32 %t1850, 2
  %t1857 = select i1 %t1856, i8* %t1855, i8* null
  %t1858 = getelementptr inbounds %Statement, %Statement* %t1851, i32 0, i32 1
  %t1859 = bitcast [48 x i8]* %t1858 to i8*
  %t1860 = bitcast i8* %t1859 to i8**
  %t1861 = load i8*, i8** %t1860
  %t1862 = icmp eq i32 %t1850, 3
  %t1863 = select i1 %t1862, i8* %t1861, i8* %t1857
  %t1864 = getelementptr inbounds %Statement, %Statement* %t1851, i32 0, i32 1
  %t1865 = bitcast [40 x i8]* %t1864 to i8*
  %t1866 = bitcast i8* %t1865 to i8**
  %t1867 = load i8*, i8** %t1866
  %t1868 = icmp eq i32 %t1850, 6
  %t1869 = select i1 %t1868, i8* %t1867, i8* %t1863
  %t1870 = getelementptr inbounds %Statement, %Statement* %t1851, i32 0, i32 1
  %t1871 = bitcast [56 x i8]* %t1870 to i8*
  %t1872 = bitcast i8* %t1871 to i8**
  %t1873 = load i8*, i8** %t1872
  %t1874 = icmp eq i32 %t1850, 8
  %t1875 = select i1 %t1874, i8* %t1873, i8* %t1869
  %t1876 = getelementptr inbounds %Statement, %Statement* %t1851, i32 0, i32 1
  %t1877 = bitcast [40 x i8]* %t1876 to i8*
  %t1878 = bitcast i8* %t1877 to i8**
  %t1879 = load i8*, i8** %t1878
  %t1880 = icmp eq i32 %t1850, 9
  %t1881 = select i1 %t1880, i8* %t1879, i8* %t1875
  %t1882 = getelementptr inbounds %Statement, %Statement* %t1851, i32 0, i32 1
  %t1883 = bitcast [40 x i8]* %t1882 to i8*
  %t1884 = bitcast i8* %t1883 to i8**
  %t1885 = load i8*, i8** %t1884
  %t1886 = icmp eq i32 %t1850, 10
  %t1887 = select i1 %t1886, i8* %t1885, i8* %t1881
  %t1888 = getelementptr inbounds %Statement, %Statement* %t1851, i32 0, i32 1
  %t1889 = bitcast [40 x i8]* %t1888 to i8*
  %t1890 = bitcast i8* %t1889 to i8**
  %t1891 = load i8*, i8** %t1890
  %t1892 = icmp eq i32 %t1850, 11
  %t1893 = select i1 %t1892, i8* %t1891, i8* %t1887
  %s1894 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275477867, i32 0, i32 0
  %t1895 = extractvalue %Statement %statement, 0
  %t1896 = alloca %Statement
  store %Statement %statement, %Statement* %t1896
  %t1897 = getelementptr inbounds %Statement, %Statement* %t1896, i32 0, i32 1
  %t1898 = bitcast [48 x i8]* %t1897 to i8*
  %t1899 = getelementptr inbounds i8, i8* %t1898, i64 8
  %t1900 = bitcast i8* %t1899 to %SourceSpan**
  %t1901 = load %SourceSpan*, %SourceSpan** %t1900
  %t1902 = icmp eq i32 %t1895, 3
  %t1903 = select i1 %t1902, %SourceSpan* %t1901, %SourceSpan* null
  %t1904 = getelementptr inbounds %Statement, %Statement* %t1896, i32 0, i32 1
  %t1905 = bitcast [40 x i8]* %t1904 to i8*
  %t1906 = getelementptr inbounds i8, i8* %t1905, i64 8
  %t1907 = bitcast i8* %t1906 to %SourceSpan**
  %t1908 = load %SourceSpan*, %SourceSpan** %t1907
  %t1909 = icmp eq i32 %t1895, 6
  %t1910 = select i1 %t1909, %SourceSpan* %t1908, %SourceSpan* %t1903
  %t1911 = getelementptr inbounds %Statement, %Statement* %t1896, i32 0, i32 1
  %t1912 = bitcast [56 x i8]* %t1911 to i8*
  %t1913 = getelementptr inbounds i8, i8* %t1912, i64 8
  %t1914 = bitcast i8* %t1913 to %SourceSpan**
  %t1915 = load %SourceSpan*, %SourceSpan** %t1914
  %t1916 = icmp eq i32 %t1895, 8
  %t1917 = select i1 %t1916, %SourceSpan* %t1915, %SourceSpan* %t1910
  %t1918 = getelementptr inbounds %Statement, %Statement* %t1896, i32 0, i32 1
  %t1919 = bitcast [40 x i8]* %t1918 to i8*
  %t1920 = getelementptr inbounds i8, i8* %t1919, i64 8
  %t1921 = bitcast i8* %t1920 to %SourceSpan**
  %t1922 = load %SourceSpan*, %SourceSpan** %t1921
  %t1923 = icmp eq i32 %t1895, 9
  %t1924 = select i1 %t1923, %SourceSpan* %t1922, %SourceSpan* %t1917
  %t1925 = getelementptr inbounds %Statement, %Statement* %t1896, i32 0, i32 1
  %t1926 = bitcast [40 x i8]* %t1925 to i8*
  %t1927 = getelementptr inbounds i8, i8* %t1926, i64 8
  %t1928 = bitcast i8* %t1927 to %SourceSpan**
  %t1929 = load %SourceSpan*, %SourceSpan** %t1928
  %t1930 = icmp eq i32 %t1895, 10
  %t1931 = select i1 %t1930, %SourceSpan* %t1929, %SourceSpan* %t1924
  %t1932 = getelementptr inbounds %Statement, %Statement* %t1896, i32 0, i32 1
  %t1933 = bitcast [40 x i8]* %t1932 to i8*
  %t1934 = getelementptr inbounds i8, i8* %t1933, i64 8
  %t1935 = bitcast i8* %t1934 to %SourceSpan**
  %t1936 = load %SourceSpan*, %SourceSpan** %t1935
  %t1937 = icmp eq i32 %t1895, 11
  %t1938 = select i1 %t1937, %SourceSpan* %t1936, %SourceSpan* %t1931
  %t1939 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1893, i8* %s1894, %SourceSpan* %t1938)
  store %ScopeResult %t1939, %ScopeResult* %l17
  %t1940 = load %ScopeResult, %ScopeResult* %l17
  %t1941 = extractvalue %ScopeResult %t1940, 1
  %t1942 = extractvalue %Statement %statement, 0
  %t1943 = alloca %Statement
  store %Statement %statement, %Statement* %t1943
  %t1944 = getelementptr inbounds %Statement, %Statement* %t1943, i32 0, i32 1
  %t1945 = bitcast [24 x i8]* %t1944 to i8*
  %t1946 = getelementptr inbounds i8, i8* %t1945, i64 8
  %t1947 = bitcast i8* %t1946 to %Block*
  %t1948 = load %Block, %Block* %t1947
  %t1949 = icmp eq i32 %t1942, 4
  %t1950 = select i1 %t1949, %Block %t1948, %Block zeroinitializer
  %t1951 = getelementptr inbounds %Statement, %Statement* %t1943, i32 0, i32 1
  %t1952 = bitcast [24 x i8]* %t1951 to i8*
  %t1953 = getelementptr inbounds i8, i8* %t1952, i64 8
  %t1954 = bitcast i8* %t1953 to %Block*
  %t1955 = load %Block, %Block* %t1954
  %t1956 = icmp eq i32 %t1942, 5
  %t1957 = select i1 %t1956, %Block %t1955, %Block %t1950
  %t1958 = getelementptr inbounds %Statement, %Statement* %t1943, i32 0, i32 1
  %t1959 = bitcast [40 x i8]* %t1958 to i8*
  %t1960 = getelementptr inbounds i8, i8* %t1959, i64 16
  %t1961 = bitcast i8* %t1960 to %Block*
  %t1962 = load %Block, %Block* %t1961
  %t1963 = icmp eq i32 %t1942, 6
  %t1964 = select i1 %t1963, %Block %t1962, %Block %t1957
  %t1965 = getelementptr inbounds %Statement, %Statement* %t1943, i32 0, i32 1
  %t1966 = bitcast [24 x i8]* %t1965 to i8*
  %t1967 = getelementptr inbounds i8, i8* %t1966, i64 8
  %t1968 = bitcast i8* %t1967 to %Block*
  %t1969 = load %Block, %Block* %t1968
  %t1970 = icmp eq i32 %t1942, 7
  %t1971 = select i1 %t1970, %Block %t1969, %Block %t1964
  %t1972 = getelementptr inbounds %Statement, %Statement* %t1943, i32 0, i32 1
  %t1973 = bitcast [40 x i8]* %t1972 to i8*
  %t1974 = getelementptr inbounds i8, i8* %t1973, i64 24
  %t1975 = bitcast i8* %t1974 to %Block*
  %t1976 = load %Block, %Block* %t1975
  %t1977 = icmp eq i32 %t1942, 12
  %t1978 = select i1 %t1977, %Block %t1976, %Block %t1971
  %t1979 = getelementptr inbounds %Statement, %Statement* %t1943, i32 0, i32 1
  %t1980 = bitcast [24 x i8]* %t1979 to i8*
  %t1981 = getelementptr inbounds i8, i8* %t1980, i64 8
  %t1982 = bitcast i8* %t1981 to %Block*
  %t1983 = load %Block, %Block* %t1982
  %t1984 = icmp eq i32 %t1942, 13
  %t1985 = select i1 %t1984, %Block %t1983, %Block %t1978
  %t1986 = getelementptr inbounds %Statement, %Statement* %t1943, i32 0, i32 1
  %t1987 = bitcast [24 x i8]* %t1986 to i8*
  %t1988 = getelementptr inbounds i8, i8* %t1987, i64 8
  %t1989 = bitcast i8* %t1988 to %Block*
  %t1990 = load %Block, %Block* %t1989
  %t1991 = icmp eq i32 %t1942, 14
  %t1992 = select i1 %t1991, %Block %t1990, %Block %t1985
  %t1993 = getelementptr inbounds %Statement, %Statement* %t1943, i32 0, i32 1
  %t1994 = bitcast [16 x i8]* %t1993 to i8*
  %t1995 = bitcast i8* %t1994 to %Block*
  %t1996 = load %Block, %Block* %t1995
  %t1997 = icmp eq i32 %t1942, 15
  %t1998 = select i1 %t1997, %Block %t1996, %Block %t1992
  %t1999 = getelementptr [0 x %SymbolEntry], [0 x %SymbolEntry]* null, i32 1
  %t2000 = ptrtoint [0 x %SymbolEntry]* %t1999 to i64
  %t2001 = icmp eq i64 %t2000, 0
  %t2002 = select i1 %t2001, i64 1, i64 %t2000
  %t2003 = call i8* @malloc(i64 %t2002)
  %t2004 = bitcast i8* %t2003 to %SymbolEntry*
  %t2005 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* null, i32 1
  %t2006 = ptrtoint { %SymbolEntry*, i64 }* %t2005 to i64
  %t2007 = call i8* @malloc(i64 %t2006)
  %t2008 = bitcast i8* %t2007 to { %SymbolEntry*, i64 }*
  %t2009 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t2008, i32 0, i32 0
  store %SymbolEntry* %t2004, %SymbolEntry** %t2009
  %t2010 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t2008, i32 0, i32 1
  store i64 0, i64* %t2010
  %t2011 = call { %Diagnostic*, i64 }* @check_block(%Block %t1998, { %SymbolEntry*, i64 }* %t2008, { %Statement*, i64 }* %interfaces)
  %t2012 = bitcast { %Diagnostic**, i64 }* %t1941 to { i8**, i64 }*
  %t2013 = bitcast { %Diagnostic*, i64 }* %t2011 to { i8**, i64 }*
  %t2014 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2012, { i8**, i64 }* %t2013)
  store { i8**, i64 }* %t2014, { i8**, i64 }** %l18
  %t2015 = load %ScopeResult, %ScopeResult* %l17
  %t2016 = extractvalue %ScopeResult %t2015, 0
  %t2017 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2016, 0
  %t2018 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t2019 = bitcast { i8**, i64 }* %t2018 to { %Diagnostic**, i64 }*
  %t2020 = insertvalue %ScopeResult %t2017, { %Diagnostic**, i64 }* %t2019, 1
  ret %ScopeResult %t2020
merge23:
  %t2021 = extractvalue %Statement %statement, 0
  %t2022 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2023 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2024 = icmp eq i32 %t2021, 0
  %t2025 = select i1 %t2024, i8* %t2023, i8* %t2022
  %t2026 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2027 = icmp eq i32 %t2021, 1
  %t2028 = select i1 %t2027, i8* %t2026, i8* %t2025
  %t2029 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2030 = icmp eq i32 %t2021, 2
  %t2031 = select i1 %t2030, i8* %t2029, i8* %t2028
  %t2032 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2033 = icmp eq i32 %t2021, 3
  %t2034 = select i1 %t2033, i8* %t2032, i8* %t2031
  %t2035 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2036 = icmp eq i32 %t2021, 4
  %t2037 = select i1 %t2036, i8* %t2035, i8* %t2034
  %t2038 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2039 = icmp eq i32 %t2021, 5
  %t2040 = select i1 %t2039, i8* %t2038, i8* %t2037
  %t2041 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2042 = icmp eq i32 %t2021, 6
  %t2043 = select i1 %t2042, i8* %t2041, i8* %t2040
  %t2044 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2045 = icmp eq i32 %t2021, 7
  %t2046 = select i1 %t2045, i8* %t2044, i8* %t2043
  %t2047 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2048 = icmp eq i32 %t2021, 8
  %t2049 = select i1 %t2048, i8* %t2047, i8* %t2046
  %t2050 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2051 = icmp eq i32 %t2021, 9
  %t2052 = select i1 %t2051, i8* %t2050, i8* %t2049
  %t2053 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2054 = icmp eq i32 %t2021, 10
  %t2055 = select i1 %t2054, i8* %t2053, i8* %t2052
  %t2056 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2057 = icmp eq i32 %t2021, 11
  %t2058 = select i1 %t2057, i8* %t2056, i8* %t2055
  %t2059 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2060 = icmp eq i32 %t2021, 12
  %t2061 = select i1 %t2060, i8* %t2059, i8* %t2058
  %t2062 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2063 = icmp eq i32 %t2021, 13
  %t2064 = select i1 %t2063, i8* %t2062, i8* %t2061
  %t2065 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2066 = icmp eq i32 %t2021, 14
  %t2067 = select i1 %t2066, i8* %t2065, i8* %t2064
  %t2068 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2069 = icmp eq i32 %t2021, 15
  %t2070 = select i1 %t2069, i8* %t2068, i8* %t2067
  %t2071 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2072 = icmp eq i32 %t2021, 16
  %t2073 = select i1 %t2072, i8* %t2071, i8* %t2070
  %t2074 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2075 = icmp eq i32 %t2021, 17
  %t2076 = select i1 %t2075, i8* %t2074, i8* %t2073
  %t2077 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2078 = icmp eq i32 %t2021, 18
  %t2079 = select i1 %t2078, i8* %t2077, i8* %t2076
  %t2080 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2081 = icmp eq i32 %t2021, 19
  %t2082 = select i1 %t2081, i8* %t2080, i8* %t2079
  %t2083 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2084 = icmp eq i32 %t2021, 20
  %t2085 = select i1 %t2084, i8* %t2083, i8* %t2082
  %t2086 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2087 = icmp eq i32 %t2021, 21
  %t2088 = select i1 %t2087, i8* %t2086, i8* %t2085
  %t2089 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2090 = icmp eq i32 %t2021, 22
  %t2091 = select i1 %t2090, i8* %t2089, i8* %t2088
  %s2092 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1925822000, i32 0, i32 0
  %t2093 = call i1 @strings_equal(i8* %t2091, i8* %s2092)
  br i1 %t2093, label %then24, label %merge25
then24:
  %t2094 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2095 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2094, 0
  %t2096 = extractvalue %Statement %statement, 0
  %t2097 = alloca %Statement
  store %Statement %statement, %Statement* %t2097
  %t2098 = getelementptr inbounds %Statement, %Statement* %t2097, i32 0, i32 1
  %t2099 = bitcast [24 x i8]* %t2098 to i8*
  %t2100 = getelementptr inbounds i8, i8* %t2099, i64 8
  %t2101 = bitcast i8* %t2100 to %Block*
  %t2102 = load %Block, %Block* %t2101
  %t2103 = icmp eq i32 %t2096, 4
  %t2104 = select i1 %t2103, %Block %t2102, %Block zeroinitializer
  %t2105 = getelementptr inbounds %Statement, %Statement* %t2097, i32 0, i32 1
  %t2106 = bitcast [24 x i8]* %t2105 to i8*
  %t2107 = getelementptr inbounds i8, i8* %t2106, i64 8
  %t2108 = bitcast i8* %t2107 to %Block*
  %t2109 = load %Block, %Block* %t2108
  %t2110 = icmp eq i32 %t2096, 5
  %t2111 = select i1 %t2110, %Block %t2109, %Block %t2104
  %t2112 = getelementptr inbounds %Statement, %Statement* %t2097, i32 0, i32 1
  %t2113 = bitcast [40 x i8]* %t2112 to i8*
  %t2114 = getelementptr inbounds i8, i8* %t2113, i64 16
  %t2115 = bitcast i8* %t2114 to %Block*
  %t2116 = load %Block, %Block* %t2115
  %t2117 = icmp eq i32 %t2096, 6
  %t2118 = select i1 %t2117, %Block %t2116, %Block %t2111
  %t2119 = getelementptr inbounds %Statement, %Statement* %t2097, i32 0, i32 1
  %t2120 = bitcast [24 x i8]* %t2119 to i8*
  %t2121 = getelementptr inbounds i8, i8* %t2120, i64 8
  %t2122 = bitcast i8* %t2121 to %Block*
  %t2123 = load %Block, %Block* %t2122
  %t2124 = icmp eq i32 %t2096, 7
  %t2125 = select i1 %t2124, %Block %t2123, %Block %t2118
  %t2126 = getelementptr inbounds %Statement, %Statement* %t2097, i32 0, i32 1
  %t2127 = bitcast [40 x i8]* %t2126 to i8*
  %t2128 = getelementptr inbounds i8, i8* %t2127, i64 24
  %t2129 = bitcast i8* %t2128 to %Block*
  %t2130 = load %Block, %Block* %t2129
  %t2131 = icmp eq i32 %t2096, 12
  %t2132 = select i1 %t2131, %Block %t2130, %Block %t2125
  %t2133 = getelementptr inbounds %Statement, %Statement* %t2097, i32 0, i32 1
  %t2134 = bitcast [24 x i8]* %t2133 to i8*
  %t2135 = getelementptr inbounds i8, i8* %t2134, i64 8
  %t2136 = bitcast i8* %t2135 to %Block*
  %t2137 = load %Block, %Block* %t2136
  %t2138 = icmp eq i32 %t2096, 13
  %t2139 = select i1 %t2138, %Block %t2137, %Block %t2132
  %t2140 = getelementptr inbounds %Statement, %Statement* %t2097, i32 0, i32 1
  %t2141 = bitcast [24 x i8]* %t2140 to i8*
  %t2142 = getelementptr inbounds i8, i8* %t2141, i64 8
  %t2143 = bitcast i8* %t2142 to %Block*
  %t2144 = load %Block, %Block* %t2143
  %t2145 = icmp eq i32 %t2096, 14
  %t2146 = select i1 %t2145, %Block %t2144, %Block %t2139
  %t2147 = getelementptr inbounds %Statement, %Statement* %t2097, i32 0, i32 1
  %t2148 = bitcast [16 x i8]* %t2147 to i8*
  %t2149 = bitcast i8* %t2148 to %Block*
  %t2150 = load %Block, %Block* %t2149
  %t2151 = icmp eq i32 %t2096, 15
  %t2152 = select i1 %t2151, %Block %t2150, %Block %t2146
  %t2153 = call { %Diagnostic*, i64 }* @check_block(%Block %t2152, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2154 = bitcast { %Diagnostic*, i64 }* %t2153 to { %Diagnostic**, i64 }*
  %t2155 = insertvalue %ScopeResult %t2095, { %Diagnostic**, i64 }* %t2154, 1
  ret %ScopeResult %t2155
merge25:
  %t2156 = extractvalue %Statement %statement, 0
  %t2157 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2158 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2159 = icmp eq i32 %t2156, 0
  %t2160 = select i1 %t2159, i8* %t2158, i8* %t2157
  %t2161 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2162 = icmp eq i32 %t2156, 1
  %t2163 = select i1 %t2162, i8* %t2161, i8* %t2160
  %t2164 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2165 = icmp eq i32 %t2156, 2
  %t2166 = select i1 %t2165, i8* %t2164, i8* %t2163
  %t2167 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2168 = icmp eq i32 %t2156, 3
  %t2169 = select i1 %t2168, i8* %t2167, i8* %t2166
  %t2170 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2171 = icmp eq i32 %t2156, 4
  %t2172 = select i1 %t2171, i8* %t2170, i8* %t2169
  %t2173 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2174 = icmp eq i32 %t2156, 5
  %t2175 = select i1 %t2174, i8* %t2173, i8* %t2172
  %t2176 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2177 = icmp eq i32 %t2156, 6
  %t2178 = select i1 %t2177, i8* %t2176, i8* %t2175
  %t2179 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2180 = icmp eq i32 %t2156, 7
  %t2181 = select i1 %t2180, i8* %t2179, i8* %t2178
  %t2182 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2183 = icmp eq i32 %t2156, 8
  %t2184 = select i1 %t2183, i8* %t2182, i8* %t2181
  %t2185 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2186 = icmp eq i32 %t2156, 9
  %t2187 = select i1 %t2186, i8* %t2185, i8* %t2184
  %t2188 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2189 = icmp eq i32 %t2156, 10
  %t2190 = select i1 %t2189, i8* %t2188, i8* %t2187
  %t2191 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2192 = icmp eq i32 %t2156, 11
  %t2193 = select i1 %t2192, i8* %t2191, i8* %t2190
  %t2194 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2195 = icmp eq i32 %t2156, 12
  %t2196 = select i1 %t2195, i8* %t2194, i8* %t2193
  %t2197 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2198 = icmp eq i32 %t2156, 13
  %t2199 = select i1 %t2198, i8* %t2197, i8* %t2196
  %t2200 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2201 = icmp eq i32 %t2156, 14
  %t2202 = select i1 %t2201, i8* %t2200, i8* %t2199
  %t2203 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2204 = icmp eq i32 %t2156, 15
  %t2205 = select i1 %t2204, i8* %t2203, i8* %t2202
  %t2206 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2207 = icmp eq i32 %t2156, 16
  %t2208 = select i1 %t2207, i8* %t2206, i8* %t2205
  %t2209 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2210 = icmp eq i32 %t2156, 17
  %t2211 = select i1 %t2210, i8* %t2209, i8* %t2208
  %t2212 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2213 = icmp eq i32 %t2156, 18
  %t2214 = select i1 %t2213, i8* %t2212, i8* %t2211
  %t2215 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2216 = icmp eq i32 %t2156, 19
  %t2217 = select i1 %t2216, i8* %t2215, i8* %t2214
  %t2218 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2219 = icmp eq i32 %t2156, 20
  %t2220 = select i1 %t2219, i8* %t2218, i8* %t2217
  %t2221 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2222 = icmp eq i32 %t2156, 21
  %t2223 = select i1 %t2222, i8* %t2221, i8* %t2220
  %t2224 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2225 = icmp eq i32 %t2156, 22
  %t2226 = select i1 %t2225, i8* %t2224, i8* %t2223
  %s2227 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h84042670, i32 0, i32 0
  %t2228 = call i1 @strings_equal(i8* %t2226, i8* %s2227)
  br i1 %t2228, label %then26, label %merge27
then26:
  %t2229 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2230 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2229, 0
  %t2231 = extractvalue %Statement %statement, 0
  %t2232 = alloca %Statement
  store %Statement %statement, %Statement* %t2232
  %t2233 = getelementptr inbounds %Statement, %Statement* %t2232, i32 0, i32 1
  %t2234 = bitcast [24 x i8]* %t2233 to i8*
  %t2235 = getelementptr inbounds i8, i8* %t2234, i64 8
  %t2236 = bitcast i8* %t2235 to %Block*
  %t2237 = load %Block, %Block* %t2236
  %t2238 = icmp eq i32 %t2231, 4
  %t2239 = select i1 %t2238, %Block %t2237, %Block zeroinitializer
  %t2240 = getelementptr inbounds %Statement, %Statement* %t2232, i32 0, i32 1
  %t2241 = bitcast [24 x i8]* %t2240 to i8*
  %t2242 = getelementptr inbounds i8, i8* %t2241, i64 8
  %t2243 = bitcast i8* %t2242 to %Block*
  %t2244 = load %Block, %Block* %t2243
  %t2245 = icmp eq i32 %t2231, 5
  %t2246 = select i1 %t2245, %Block %t2244, %Block %t2239
  %t2247 = getelementptr inbounds %Statement, %Statement* %t2232, i32 0, i32 1
  %t2248 = bitcast [40 x i8]* %t2247 to i8*
  %t2249 = getelementptr inbounds i8, i8* %t2248, i64 16
  %t2250 = bitcast i8* %t2249 to %Block*
  %t2251 = load %Block, %Block* %t2250
  %t2252 = icmp eq i32 %t2231, 6
  %t2253 = select i1 %t2252, %Block %t2251, %Block %t2246
  %t2254 = getelementptr inbounds %Statement, %Statement* %t2232, i32 0, i32 1
  %t2255 = bitcast [24 x i8]* %t2254 to i8*
  %t2256 = getelementptr inbounds i8, i8* %t2255, i64 8
  %t2257 = bitcast i8* %t2256 to %Block*
  %t2258 = load %Block, %Block* %t2257
  %t2259 = icmp eq i32 %t2231, 7
  %t2260 = select i1 %t2259, %Block %t2258, %Block %t2253
  %t2261 = getelementptr inbounds %Statement, %Statement* %t2232, i32 0, i32 1
  %t2262 = bitcast [40 x i8]* %t2261 to i8*
  %t2263 = getelementptr inbounds i8, i8* %t2262, i64 24
  %t2264 = bitcast i8* %t2263 to %Block*
  %t2265 = load %Block, %Block* %t2264
  %t2266 = icmp eq i32 %t2231, 12
  %t2267 = select i1 %t2266, %Block %t2265, %Block %t2260
  %t2268 = getelementptr inbounds %Statement, %Statement* %t2232, i32 0, i32 1
  %t2269 = bitcast [24 x i8]* %t2268 to i8*
  %t2270 = getelementptr inbounds i8, i8* %t2269, i64 8
  %t2271 = bitcast i8* %t2270 to %Block*
  %t2272 = load %Block, %Block* %t2271
  %t2273 = icmp eq i32 %t2231, 13
  %t2274 = select i1 %t2273, %Block %t2272, %Block %t2267
  %t2275 = getelementptr inbounds %Statement, %Statement* %t2232, i32 0, i32 1
  %t2276 = bitcast [24 x i8]* %t2275 to i8*
  %t2277 = getelementptr inbounds i8, i8* %t2276, i64 8
  %t2278 = bitcast i8* %t2277 to %Block*
  %t2279 = load %Block, %Block* %t2278
  %t2280 = icmp eq i32 %t2231, 14
  %t2281 = select i1 %t2280, %Block %t2279, %Block %t2274
  %t2282 = getelementptr inbounds %Statement, %Statement* %t2232, i32 0, i32 1
  %t2283 = bitcast [16 x i8]* %t2282 to i8*
  %t2284 = bitcast i8* %t2283 to %Block*
  %t2285 = load %Block, %Block* %t2284
  %t2286 = icmp eq i32 %t2231, 15
  %t2287 = select i1 %t2286, %Block %t2285, %Block %t2281
  %t2288 = call { %Diagnostic*, i64 }* @check_block(%Block %t2287, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2289 = bitcast { %Diagnostic*, i64 }* %t2288 to { %Diagnostic**, i64 }*
  %t2290 = insertvalue %ScopeResult %t2230, { %Diagnostic**, i64 }* %t2289, 1
  ret %ScopeResult %t2290
merge27:
  %t2291 = extractvalue %Statement %statement, 0
  %t2292 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2293 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2294 = icmp eq i32 %t2291, 0
  %t2295 = select i1 %t2294, i8* %t2293, i8* %t2292
  %t2296 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2297 = icmp eq i32 %t2291, 1
  %t2298 = select i1 %t2297, i8* %t2296, i8* %t2295
  %t2299 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2300 = icmp eq i32 %t2291, 2
  %t2301 = select i1 %t2300, i8* %t2299, i8* %t2298
  %t2302 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2303 = icmp eq i32 %t2291, 3
  %t2304 = select i1 %t2303, i8* %t2302, i8* %t2301
  %t2305 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2306 = icmp eq i32 %t2291, 4
  %t2307 = select i1 %t2306, i8* %t2305, i8* %t2304
  %t2308 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2309 = icmp eq i32 %t2291, 5
  %t2310 = select i1 %t2309, i8* %t2308, i8* %t2307
  %t2311 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2312 = icmp eq i32 %t2291, 6
  %t2313 = select i1 %t2312, i8* %t2311, i8* %t2310
  %t2314 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2315 = icmp eq i32 %t2291, 7
  %t2316 = select i1 %t2315, i8* %t2314, i8* %t2313
  %t2317 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2318 = icmp eq i32 %t2291, 8
  %t2319 = select i1 %t2318, i8* %t2317, i8* %t2316
  %t2320 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2321 = icmp eq i32 %t2291, 9
  %t2322 = select i1 %t2321, i8* %t2320, i8* %t2319
  %t2323 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2324 = icmp eq i32 %t2291, 10
  %t2325 = select i1 %t2324, i8* %t2323, i8* %t2322
  %t2326 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2327 = icmp eq i32 %t2291, 11
  %t2328 = select i1 %t2327, i8* %t2326, i8* %t2325
  %t2329 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2330 = icmp eq i32 %t2291, 12
  %t2331 = select i1 %t2330, i8* %t2329, i8* %t2328
  %t2332 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2333 = icmp eq i32 %t2291, 13
  %t2334 = select i1 %t2333, i8* %t2332, i8* %t2331
  %t2335 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2336 = icmp eq i32 %t2291, 14
  %t2337 = select i1 %t2336, i8* %t2335, i8* %t2334
  %t2338 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2339 = icmp eq i32 %t2291, 15
  %t2340 = select i1 %t2339, i8* %t2338, i8* %t2337
  %t2341 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2342 = icmp eq i32 %t2291, 16
  %t2343 = select i1 %t2342, i8* %t2341, i8* %t2340
  %t2344 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2345 = icmp eq i32 %t2291, 17
  %t2346 = select i1 %t2345, i8* %t2344, i8* %t2343
  %t2347 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2348 = icmp eq i32 %t2291, 18
  %t2349 = select i1 %t2348, i8* %t2347, i8* %t2346
  %t2350 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2351 = icmp eq i32 %t2291, 19
  %t2352 = select i1 %t2351, i8* %t2350, i8* %t2349
  %t2353 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2354 = icmp eq i32 %t2291, 20
  %t2355 = select i1 %t2354, i8* %t2353, i8* %t2352
  %t2356 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2357 = icmp eq i32 %t2291, 21
  %t2358 = select i1 %t2357, i8* %t2356, i8* %t2355
  %t2359 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2360 = icmp eq i32 %t2291, 22
  %t2361 = select i1 %t2360, i8* %t2359, i8* %t2358
  %s2362 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h196308685, i32 0, i32 0
  %t2363 = call i1 @strings_equal(i8* %t2361, i8* %s2362)
  br i1 %t2363, label %then28, label %merge29
then28:
  %t2364 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t2365 = ptrtoint [0 x %Diagnostic]* %t2364 to i64
  %t2366 = icmp eq i64 %t2365, 0
  %t2367 = select i1 %t2366, i64 1, i64 %t2365
  %t2368 = call i8* @malloc(i64 %t2367)
  %t2369 = bitcast i8* %t2368 to %Diagnostic*
  %t2370 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t2371 = ptrtoint { %Diagnostic*, i64 }* %t2370 to i64
  %t2372 = call i8* @malloc(i64 %t2371)
  %t2373 = bitcast i8* %t2372 to { %Diagnostic*, i64 }*
  %t2374 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2373, i32 0, i32 0
  store %Diagnostic* %t2369, %Diagnostic** %t2374
  %t2375 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2373, i32 0, i32 1
  store i64 0, i64* %t2375
  store { %Diagnostic*, i64 }* %t2373, { %Diagnostic*, i64 }** %l19
  %t2376 = sitofp i64 0 to double
  store double %t2376, double* %l20
  %t2377 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2378 = load double, double* %l20
  br label %loop.header30
loop.header30:
  %t2427 = phi { %Diagnostic*, i64 }* [ %t2377, %then28 ], [ %t2425, %loop.latch32 ]
  %t2428 = phi double [ %t2378, %then28 ], [ %t2426, %loop.latch32 ]
  store { %Diagnostic*, i64 }* %t2427, { %Diagnostic*, i64 }** %l19
  store double %t2428, double* %l20
  br label %loop.body31
loop.body31:
  %t2379 = load double, double* %l20
  %t2380 = extractvalue %Statement %statement, 0
  %t2381 = alloca %Statement
  store %Statement %statement, %Statement* %t2381
  %t2382 = getelementptr inbounds %Statement, %Statement* %t2381, i32 0, i32 1
  %t2383 = bitcast [24 x i8]* %t2382 to i8*
  %t2384 = getelementptr inbounds i8, i8* %t2383, i64 8
  %t2385 = bitcast i8* %t2384 to { %MatchCase**, i64 }**
  %t2386 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t2385
  %t2387 = icmp eq i32 %t2380, 18
  %t2388 = select i1 %t2387, { %MatchCase**, i64 }* %t2386, { %MatchCase**, i64 }* null
  %t2389 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t2388
  %t2390 = extractvalue { %MatchCase**, i64 } %t2389, 1
  %t2391 = sitofp i64 %t2390 to double
  %t2392 = fcmp oge double %t2379, %t2391
  %t2393 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2394 = load double, double* %l20
  br i1 %t2392, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t2395 = extractvalue %Statement %statement, 0
  %t2396 = alloca %Statement
  store %Statement %statement, %Statement* %t2396
  %t2397 = getelementptr inbounds %Statement, %Statement* %t2396, i32 0, i32 1
  %t2398 = bitcast [24 x i8]* %t2397 to i8*
  %t2399 = getelementptr inbounds i8, i8* %t2398, i64 8
  %t2400 = bitcast i8* %t2399 to { %MatchCase**, i64 }**
  %t2401 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t2400
  %t2402 = icmp eq i32 %t2395, 18
  %t2403 = select i1 %t2402, { %MatchCase**, i64 }* %t2401, { %MatchCase**, i64 }* null
  %t2404 = load double, double* %l20
  %t2405 = call double @llvm.round.f64(double %t2404)
  %t2406 = fptosi double %t2405 to i64
  %t2407 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t2403
  %t2408 = extractvalue { %MatchCase**, i64 } %t2407, 0
  %t2409 = extractvalue { %MatchCase**, i64 } %t2407, 1
  %t2410 = icmp uge i64 %t2406, %t2409
  ; bounds check: %t2410 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t2406, i64 %t2409)
  %t2411 = getelementptr %MatchCase*, %MatchCase** %t2408, i64 %t2406
  %t2412 = load %MatchCase*, %MatchCase** %t2411
  store %MatchCase* %t2412, %MatchCase** %l21
  %t2413 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2414 = load %MatchCase*, %MatchCase** %l21
  %t2415 = getelementptr %MatchCase, %MatchCase* %t2414, i32 0, i32 2
  %t2416 = load %Block, %Block* %t2415
  %t2417 = call { %Diagnostic*, i64 }* @check_block(%Block %t2416, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2418 = bitcast { %Diagnostic*, i64 }* %t2413 to { i8**, i64 }*
  %t2419 = bitcast { %Diagnostic*, i64 }* %t2417 to { i8**, i64 }*
  %t2420 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2418, { i8**, i64 }* %t2419)
  %t2421 = bitcast { i8**, i64 }* %t2420 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t2421, { %Diagnostic*, i64 }** %l19
  %t2422 = load double, double* %l20
  %t2423 = sitofp i64 1 to double
  %t2424 = fadd double %t2422, %t2423
  store double %t2424, double* %l20
  br label %loop.latch32
loop.latch32:
  %t2425 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2426 = load double, double* %l20
  br label %loop.header30
afterloop33:
  %t2429 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2430 = load double, double* %l20
  %t2431 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2432 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2431, 0
  %t2433 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2434 = bitcast { %Diagnostic*, i64 }* %t2433 to { %Diagnostic**, i64 }*
  %t2435 = insertvalue %ScopeResult %t2432, { %Diagnostic**, i64 }* %t2434, 1
  ret %ScopeResult %t2435
merge29:
  %t2436 = extractvalue %Statement %statement, 0
  %t2437 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2438 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2439 = icmp eq i32 %t2436, 0
  %t2440 = select i1 %t2439, i8* %t2438, i8* %t2437
  %t2441 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2442 = icmp eq i32 %t2436, 1
  %t2443 = select i1 %t2442, i8* %t2441, i8* %t2440
  %t2444 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2445 = icmp eq i32 %t2436, 2
  %t2446 = select i1 %t2445, i8* %t2444, i8* %t2443
  %t2447 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2448 = icmp eq i32 %t2436, 3
  %t2449 = select i1 %t2448, i8* %t2447, i8* %t2446
  %t2450 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2451 = icmp eq i32 %t2436, 4
  %t2452 = select i1 %t2451, i8* %t2450, i8* %t2449
  %t2453 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2454 = icmp eq i32 %t2436, 5
  %t2455 = select i1 %t2454, i8* %t2453, i8* %t2452
  %t2456 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2457 = icmp eq i32 %t2436, 6
  %t2458 = select i1 %t2457, i8* %t2456, i8* %t2455
  %t2459 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2460 = icmp eq i32 %t2436, 7
  %t2461 = select i1 %t2460, i8* %t2459, i8* %t2458
  %t2462 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2463 = icmp eq i32 %t2436, 8
  %t2464 = select i1 %t2463, i8* %t2462, i8* %t2461
  %t2465 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2466 = icmp eq i32 %t2436, 9
  %t2467 = select i1 %t2466, i8* %t2465, i8* %t2464
  %t2468 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2469 = icmp eq i32 %t2436, 10
  %t2470 = select i1 %t2469, i8* %t2468, i8* %t2467
  %t2471 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2472 = icmp eq i32 %t2436, 11
  %t2473 = select i1 %t2472, i8* %t2471, i8* %t2470
  %t2474 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2475 = icmp eq i32 %t2436, 12
  %t2476 = select i1 %t2475, i8* %t2474, i8* %t2473
  %t2477 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2478 = icmp eq i32 %t2436, 13
  %t2479 = select i1 %t2478, i8* %t2477, i8* %t2476
  %t2480 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2481 = icmp eq i32 %t2436, 14
  %t2482 = select i1 %t2481, i8* %t2480, i8* %t2479
  %t2483 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2484 = icmp eq i32 %t2436, 15
  %t2485 = select i1 %t2484, i8* %t2483, i8* %t2482
  %t2486 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2487 = icmp eq i32 %t2436, 16
  %t2488 = select i1 %t2487, i8* %t2486, i8* %t2485
  %t2489 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2490 = icmp eq i32 %t2436, 17
  %t2491 = select i1 %t2490, i8* %t2489, i8* %t2488
  %t2492 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2493 = icmp eq i32 %t2436, 18
  %t2494 = select i1 %t2493, i8* %t2492, i8* %t2491
  %t2495 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2496 = icmp eq i32 %t2436, 19
  %t2497 = select i1 %t2496, i8* %t2495, i8* %t2494
  %t2498 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2499 = icmp eq i32 %t2436, 20
  %t2500 = select i1 %t2499, i8* %t2498, i8* %t2497
  %t2501 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2502 = icmp eq i32 %t2436, 21
  %t2503 = select i1 %t2502, i8* %t2501, i8* %t2500
  %t2504 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2505 = icmp eq i32 %t2436, 22
  %t2506 = select i1 %t2505, i8* %t2504, i8* %t2503
  %s2507 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1566780570, i32 0, i32 0
  %t2508 = call i1 @strings_equal(i8* %t2506, i8* %s2507)
  br i1 %t2508, label %then36, label %merge37
then36:
  %t2509 = extractvalue %Statement %statement, 0
  %t2510 = alloca %Statement
  store %Statement %statement, %Statement* %t2510
  %t2511 = getelementptr inbounds %Statement, %Statement* %t2510, i32 0, i32 1
  %t2512 = bitcast [32 x i8]* %t2511 to i8*
  %t2513 = getelementptr inbounds i8, i8* %t2512, i64 8
  %t2514 = bitcast i8* %t2513 to %Block*
  %t2515 = load %Block, %Block* %t2514
  %t2516 = icmp eq i32 %t2509, 19
  %t2517 = select i1 %t2516, %Block %t2515, %Block zeroinitializer
  %t2518 = call { %Diagnostic*, i64 }* @check_block(%Block %t2517, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t2518, { %Diagnostic*, i64 }** %l22
  %t2519 = extractvalue %Statement %statement, 0
  %t2520 = alloca %Statement
  store %Statement %statement, %Statement* %t2520
  %t2521 = getelementptr inbounds %Statement, %Statement* %t2520, i32 0, i32 1
  %t2522 = bitcast [32 x i8]* %t2521 to i8*
  %t2523 = getelementptr inbounds i8, i8* %t2522, i64 16
  %t2524 = bitcast i8* %t2523 to %ElseBranch**
  %t2525 = load %ElseBranch*, %ElseBranch** %t2524
  %t2526 = icmp eq i32 %t2519, 19
  %t2527 = select i1 %t2526, %ElseBranch* %t2525, %ElseBranch* null
  %t2528 = icmp ne %ElseBranch* %t2527, null
  %t2529 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br i1 %t2528, label %then38, label %merge39
then38:
  %t2530 = extractvalue %Statement %statement, 0
  %t2531 = alloca %Statement
  store %Statement %statement, %Statement* %t2531
  %t2532 = getelementptr inbounds %Statement, %Statement* %t2531, i32 0, i32 1
  %t2533 = bitcast [32 x i8]* %t2532 to i8*
  %t2534 = getelementptr inbounds i8, i8* %t2533, i64 16
  %t2535 = bitcast i8* %t2534 to %ElseBranch**
  %t2536 = load %ElseBranch*, %ElseBranch** %t2535
  %t2537 = icmp eq i32 %t2530, 19
  %t2538 = select i1 %t2537, %ElseBranch* %t2536, %ElseBranch* null
  store %ElseBranch* %t2538, %ElseBranch** %l23
  %t2539 = load %ElseBranch*, %ElseBranch** %l23
  %t2540 = getelementptr %ElseBranch, %ElseBranch* %t2539, i32 0, i32 1
  %t2541 = load %Block*, %Block** %t2540
  %t2542 = icmp ne %Block* %t2541, null
  %t2543 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2544 = load %ElseBranch*, %ElseBranch** %l23
  br i1 %t2542, label %then40, label %merge41
then40:
  %t2545 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2546 = load %ElseBranch*, %ElseBranch** %l23
  %t2547 = getelementptr %ElseBranch, %ElseBranch* %t2546, i32 0, i32 1
  %t2548 = load %Block*, %Block** %t2547
  %t2549 = load %Block, %Block* %t2548
  %t2550 = call { %Diagnostic*, i64 }* @check_block(%Block %t2549, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2551 = bitcast { %Diagnostic*, i64 }* %t2545 to { i8**, i64 }*
  %t2552 = bitcast { %Diagnostic*, i64 }* %t2550 to { i8**, i64 }*
  %t2553 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2551, { i8**, i64 }* %t2552)
  %t2554 = bitcast { i8**, i64 }* %t2553 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t2554, { %Diagnostic*, i64 }** %l22
  %t2555 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br label %merge41
merge41:
  %t2556 = phi { %Diagnostic*, i64 }* [ %t2555, %then40 ], [ %t2543, %then38 ]
  store { %Diagnostic*, i64 }* %t2556, { %Diagnostic*, i64 }** %l22
  %t2557 = load %ElseBranch*, %ElseBranch** %l23
  %t2558 = getelementptr %ElseBranch, %ElseBranch* %t2557, i32 0, i32 0
  %t2559 = load %Statement*, %Statement** %t2558
  %t2560 = icmp ne %Statement* %t2559, null
  %t2561 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2562 = load %ElseBranch*, %ElseBranch** %l23
  br i1 %t2560, label %then42, label %merge43
then42:
  %t2563 = load %ElseBranch*, %ElseBranch** %l23
  %t2564 = getelementptr %ElseBranch, %ElseBranch* %t2563, i32 0, i32 0
  %t2565 = load %Statement*, %Statement** %t2564
  %t2566 = load %Statement, %Statement* %t2565
  %t2567 = call %ScopeResult @check_statement(%Statement %t2566, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  store %ScopeResult %t2567, %ScopeResult* %l24
  %t2568 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2569 = load %ScopeResult, %ScopeResult* %l24
  %t2570 = extractvalue %ScopeResult %t2569, 1
  %t2571 = bitcast { %Diagnostic*, i64 }* %t2568 to { i8**, i64 }*
  %t2572 = bitcast { %Diagnostic**, i64 }* %t2570 to { i8**, i64 }*
  %t2573 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2571, { i8**, i64 }* %t2572)
  %t2574 = bitcast { i8**, i64 }* %t2573 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t2574, { %Diagnostic*, i64 }** %l22
  %t2575 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br label %merge43
merge43:
  %t2576 = phi { %Diagnostic*, i64 }* [ %t2575, %then42 ], [ %t2561, %merge41 ]
  store { %Diagnostic*, i64 }* %t2576, { %Diagnostic*, i64 }** %l22
  %t2577 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2578 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br label %merge39
merge39:
  %t2579 = phi { %Diagnostic*, i64 }* [ %t2577, %merge43 ], [ %t2529, %then36 ]
  %t2580 = phi { %Diagnostic*, i64 }* [ %t2578, %merge43 ], [ %t2529, %then36 ]
  store { %Diagnostic*, i64 }* %t2579, { %Diagnostic*, i64 }** %l22
  store { %Diagnostic*, i64 }* %t2580, { %Diagnostic*, i64 }** %l22
  %t2581 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2582 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2581, 0
  %t2583 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2584 = bitcast { %Diagnostic*, i64 }* %t2583 to { %Diagnostic**, i64 }*
  %t2585 = insertvalue %ScopeResult %t2582, { %Diagnostic**, i64 }* %t2584, 1
  ret %ScopeResult %t2585
merge37:
  %t2586 = extractvalue %Statement %statement, 0
  %t2587 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2588 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2589 = icmp eq i32 %t2586, 0
  %t2590 = select i1 %t2589, i8* %t2588, i8* %t2587
  %t2591 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2592 = icmp eq i32 %t2586, 1
  %t2593 = select i1 %t2592, i8* %t2591, i8* %t2590
  %t2594 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2595 = icmp eq i32 %t2586, 2
  %t2596 = select i1 %t2595, i8* %t2594, i8* %t2593
  %t2597 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2598 = icmp eq i32 %t2586, 3
  %t2599 = select i1 %t2598, i8* %t2597, i8* %t2596
  %t2600 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2601 = icmp eq i32 %t2586, 4
  %t2602 = select i1 %t2601, i8* %t2600, i8* %t2599
  %t2603 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2604 = icmp eq i32 %t2586, 5
  %t2605 = select i1 %t2604, i8* %t2603, i8* %t2602
  %t2606 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2607 = icmp eq i32 %t2586, 6
  %t2608 = select i1 %t2607, i8* %t2606, i8* %t2605
  %t2609 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2610 = icmp eq i32 %t2586, 7
  %t2611 = select i1 %t2610, i8* %t2609, i8* %t2608
  %t2612 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2613 = icmp eq i32 %t2586, 8
  %t2614 = select i1 %t2613, i8* %t2612, i8* %t2611
  %t2615 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2616 = icmp eq i32 %t2586, 9
  %t2617 = select i1 %t2616, i8* %t2615, i8* %t2614
  %t2618 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2619 = icmp eq i32 %t2586, 10
  %t2620 = select i1 %t2619, i8* %t2618, i8* %t2617
  %t2621 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2622 = icmp eq i32 %t2586, 11
  %t2623 = select i1 %t2622, i8* %t2621, i8* %t2620
  %t2624 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2625 = icmp eq i32 %t2586, 12
  %t2626 = select i1 %t2625, i8* %t2624, i8* %t2623
  %t2627 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2628 = icmp eq i32 %t2586, 13
  %t2629 = select i1 %t2628, i8* %t2627, i8* %t2626
  %t2630 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2631 = icmp eq i32 %t2586, 14
  %t2632 = select i1 %t2631, i8* %t2630, i8* %t2629
  %t2633 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2634 = icmp eq i32 %t2586, 15
  %t2635 = select i1 %t2634, i8* %t2633, i8* %t2632
  %t2636 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2637 = icmp eq i32 %t2586, 16
  %t2638 = select i1 %t2637, i8* %t2636, i8* %t2635
  %t2639 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2640 = icmp eq i32 %t2586, 17
  %t2641 = select i1 %t2640, i8* %t2639, i8* %t2638
  %t2642 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2643 = icmp eq i32 %t2586, 18
  %t2644 = select i1 %t2643, i8* %t2642, i8* %t2641
  %t2645 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2646 = icmp eq i32 %t2586, 19
  %t2647 = select i1 %t2646, i8* %t2645, i8* %t2644
  %t2648 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2649 = icmp eq i32 %t2586, 20
  %t2650 = select i1 %t2649, i8* %t2648, i8* %t2647
  %t2651 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2652 = icmp eq i32 %t2586, 21
  %t2653 = select i1 %t2652, i8* %t2651, i8* %t2650
  %t2654 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2655 = icmp eq i32 %t2586, 22
  %t2656 = select i1 %t2655, i8* %t2654, i8* %t2653
  %s2657 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1067284810, i32 0, i32 0
  %t2658 = call i1 @strings_equal(i8* %t2656, i8* %s2657)
  br i1 %t2658, label %then44, label %merge45
then44:
  %t2659 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2660 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2659, 0
  %t2661 = extractvalue %Statement %statement, 0
  %t2662 = alloca %Statement
  store %Statement %statement, %Statement* %t2662
  %t2663 = getelementptr inbounds %Statement, %Statement* %t2662, i32 0, i32 1
  %t2664 = bitcast [24 x i8]* %t2663 to i8*
  %t2665 = getelementptr inbounds i8, i8* %t2664, i64 8
  %t2666 = bitcast i8* %t2665 to %Block*
  %t2667 = load %Block, %Block* %t2666
  %t2668 = icmp eq i32 %t2661, 4
  %t2669 = select i1 %t2668, %Block %t2667, %Block zeroinitializer
  %t2670 = getelementptr inbounds %Statement, %Statement* %t2662, i32 0, i32 1
  %t2671 = bitcast [24 x i8]* %t2670 to i8*
  %t2672 = getelementptr inbounds i8, i8* %t2671, i64 8
  %t2673 = bitcast i8* %t2672 to %Block*
  %t2674 = load %Block, %Block* %t2673
  %t2675 = icmp eq i32 %t2661, 5
  %t2676 = select i1 %t2675, %Block %t2674, %Block %t2669
  %t2677 = getelementptr inbounds %Statement, %Statement* %t2662, i32 0, i32 1
  %t2678 = bitcast [40 x i8]* %t2677 to i8*
  %t2679 = getelementptr inbounds i8, i8* %t2678, i64 16
  %t2680 = bitcast i8* %t2679 to %Block*
  %t2681 = load %Block, %Block* %t2680
  %t2682 = icmp eq i32 %t2661, 6
  %t2683 = select i1 %t2682, %Block %t2681, %Block %t2676
  %t2684 = getelementptr inbounds %Statement, %Statement* %t2662, i32 0, i32 1
  %t2685 = bitcast [24 x i8]* %t2684 to i8*
  %t2686 = getelementptr inbounds i8, i8* %t2685, i64 8
  %t2687 = bitcast i8* %t2686 to %Block*
  %t2688 = load %Block, %Block* %t2687
  %t2689 = icmp eq i32 %t2661, 7
  %t2690 = select i1 %t2689, %Block %t2688, %Block %t2683
  %t2691 = getelementptr inbounds %Statement, %Statement* %t2662, i32 0, i32 1
  %t2692 = bitcast [40 x i8]* %t2691 to i8*
  %t2693 = getelementptr inbounds i8, i8* %t2692, i64 24
  %t2694 = bitcast i8* %t2693 to %Block*
  %t2695 = load %Block, %Block* %t2694
  %t2696 = icmp eq i32 %t2661, 12
  %t2697 = select i1 %t2696, %Block %t2695, %Block %t2690
  %t2698 = getelementptr inbounds %Statement, %Statement* %t2662, i32 0, i32 1
  %t2699 = bitcast [24 x i8]* %t2698 to i8*
  %t2700 = getelementptr inbounds i8, i8* %t2699, i64 8
  %t2701 = bitcast i8* %t2700 to %Block*
  %t2702 = load %Block, %Block* %t2701
  %t2703 = icmp eq i32 %t2661, 13
  %t2704 = select i1 %t2703, %Block %t2702, %Block %t2697
  %t2705 = getelementptr inbounds %Statement, %Statement* %t2662, i32 0, i32 1
  %t2706 = bitcast [24 x i8]* %t2705 to i8*
  %t2707 = getelementptr inbounds i8, i8* %t2706, i64 8
  %t2708 = bitcast i8* %t2707 to %Block*
  %t2709 = load %Block, %Block* %t2708
  %t2710 = icmp eq i32 %t2661, 14
  %t2711 = select i1 %t2710, %Block %t2709, %Block %t2704
  %t2712 = getelementptr inbounds %Statement, %Statement* %t2662, i32 0, i32 1
  %t2713 = bitcast [16 x i8]* %t2712 to i8*
  %t2714 = bitcast i8* %t2713 to %Block*
  %t2715 = load %Block, %Block* %t2714
  %t2716 = icmp eq i32 %t2661, 15
  %t2717 = select i1 %t2716, %Block %t2715, %Block %t2711
  %t2718 = call { %Diagnostic*, i64 }* @check_block(%Block %t2717, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2719 = bitcast { %Diagnostic*, i64 }* %t2718 to { %Diagnostic**, i64 }*
  %t2720 = insertvalue %ScopeResult %t2660, { %Diagnostic**, i64 }* %t2719, 1
  ret %ScopeResult %t2720
merge45:
  %t2721 = extractvalue %Statement %statement, 0
  %t2722 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2723 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2724 = icmp eq i32 %t2721, 0
  %t2725 = select i1 %t2724, i8* %t2723, i8* %t2722
  %t2726 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2727 = icmp eq i32 %t2721, 1
  %t2728 = select i1 %t2727, i8* %t2726, i8* %t2725
  %t2729 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2730 = icmp eq i32 %t2721, 2
  %t2731 = select i1 %t2730, i8* %t2729, i8* %t2728
  %t2732 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2733 = icmp eq i32 %t2721, 3
  %t2734 = select i1 %t2733, i8* %t2732, i8* %t2731
  %t2735 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2736 = icmp eq i32 %t2721, 4
  %t2737 = select i1 %t2736, i8* %t2735, i8* %t2734
  %t2738 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2739 = icmp eq i32 %t2721, 5
  %t2740 = select i1 %t2739, i8* %t2738, i8* %t2737
  %t2741 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2742 = icmp eq i32 %t2721, 6
  %t2743 = select i1 %t2742, i8* %t2741, i8* %t2740
  %t2744 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2745 = icmp eq i32 %t2721, 7
  %t2746 = select i1 %t2745, i8* %t2744, i8* %t2743
  %t2747 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2748 = icmp eq i32 %t2721, 8
  %t2749 = select i1 %t2748, i8* %t2747, i8* %t2746
  %t2750 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2751 = icmp eq i32 %t2721, 9
  %t2752 = select i1 %t2751, i8* %t2750, i8* %t2749
  %t2753 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2754 = icmp eq i32 %t2721, 10
  %t2755 = select i1 %t2754, i8* %t2753, i8* %t2752
  %t2756 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2757 = icmp eq i32 %t2721, 11
  %t2758 = select i1 %t2757, i8* %t2756, i8* %t2755
  %t2759 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2760 = icmp eq i32 %t2721, 12
  %t2761 = select i1 %t2760, i8* %t2759, i8* %t2758
  %t2762 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2763 = icmp eq i32 %t2721, 13
  %t2764 = select i1 %t2763, i8* %t2762, i8* %t2761
  %t2765 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2766 = icmp eq i32 %t2721, 14
  %t2767 = select i1 %t2766, i8* %t2765, i8* %t2764
  %t2768 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2769 = icmp eq i32 %t2721, 15
  %t2770 = select i1 %t2769, i8* %t2768, i8* %t2767
  %t2771 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2772 = icmp eq i32 %t2721, 16
  %t2773 = select i1 %t2772, i8* %t2771, i8* %t2770
  %t2774 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2775 = icmp eq i32 %t2721, 17
  %t2776 = select i1 %t2775, i8* %t2774, i8* %t2773
  %t2777 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2778 = icmp eq i32 %t2721, 18
  %t2779 = select i1 %t2778, i8* %t2777, i8* %t2776
  %t2780 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2781 = icmp eq i32 %t2721, 19
  %t2782 = select i1 %t2781, i8* %t2780, i8* %t2779
  %t2783 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2784 = icmp eq i32 %t2721, 20
  %t2785 = select i1 %t2784, i8* %t2783, i8* %t2782
  %t2786 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2787 = icmp eq i32 %t2721, 21
  %t2788 = select i1 %t2787, i8* %t2786, i8* %t2785
  %t2789 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2790 = icmp eq i32 %t2721, 22
  %t2791 = select i1 %t2790, i8* %t2789, i8* %t2788
  %s2792 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1496093543, i32 0, i32 0
  %t2793 = call i1 @strings_equal(i8* %t2791, i8* %s2792)
  br i1 %t2793, label %then46, label %merge47
then46:
  %t2794 = extractvalue %Statement %statement, 0
  %t2795 = alloca %Statement
  store %Statement %statement, %Statement* %t2795
  %t2796 = getelementptr inbounds %Statement, %Statement* %t2795, i32 0, i32 1
  %t2797 = bitcast [48 x i8]* %t2796 to i8*
  %t2798 = bitcast i8* %t2797 to i8**
  %t2799 = load i8*, i8** %t2798
  %t2800 = icmp eq i32 %t2794, 2
  %t2801 = select i1 %t2800, i8* %t2799, i8* null
  %t2802 = getelementptr inbounds %Statement, %Statement* %t2795, i32 0, i32 1
  %t2803 = bitcast [48 x i8]* %t2802 to i8*
  %t2804 = bitcast i8* %t2803 to i8**
  %t2805 = load i8*, i8** %t2804
  %t2806 = icmp eq i32 %t2794, 3
  %t2807 = select i1 %t2806, i8* %t2805, i8* %t2801
  %t2808 = getelementptr inbounds %Statement, %Statement* %t2795, i32 0, i32 1
  %t2809 = bitcast [40 x i8]* %t2808 to i8*
  %t2810 = bitcast i8* %t2809 to i8**
  %t2811 = load i8*, i8** %t2810
  %t2812 = icmp eq i32 %t2794, 6
  %t2813 = select i1 %t2812, i8* %t2811, i8* %t2807
  %t2814 = getelementptr inbounds %Statement, %Statement* %t2795, i32 0, i32 1
  %t2815 = bitcast [56 x i8]* %t2814 to i8*
  %t2816 = bitcast i8* %t2815 to i8**
  %t2817 = load i8*, i8** %t2816
  %t2818 = icmp eq i32 %t2794, 8
  %t2819 = select i1 %t2818, i8* %t2817, i8* %t2813
  %t2820 = getelementptr inbounds %Statement, %Statement* %t2795, i32 0, i32 1
  %t2821 = bitcast [40 x i8]* %t2820 to i8*
  %t2822 = bitcast i8* %t2821 to i8**
  %t2823 = load i8*, i8** %t2822
  %t2824 = icmp eq i32 %t2794, 9
  %t2825 = select i1 %t2824, i8* %t2823, i8* %t2819
  %t2826 = getelementptr inbounds %Statement, %Statement* %t2795, i32 0, i32 1
  %t2827 = bitcast [40 x i8]* %t2826 to i8*
  %t2828 = bitcast i8* %t2827 to i8**
  %t2829 = load i8*, i8** %t2828
  %t2830 = icmp eq i32 %t2794, 10
  %t2831 = select i1 %t2830, i8* %t2829, i8* %t2825
  %t2832 = getelementptr inbounds %Statement, %Statement* %t2795, i32 0, i32 1
  %t2833 = bitcast [40 x i8]* %t2832 to i8*
  %t2834 = bitcast i8* %t2833 to i8**
  %t2835 = load i8*, i8** %t2834
  %t2836 = icmp eq i32 %t2794, 11
  %t2837 = select i1 %t2836, i8* %t2835, i8* %t2831
  %s2838 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h276192845, i32 0, i32 0
  %t2839 = extractvalue %Statement %statement, 0
  %t2840 = alloca %Statement
  store %Statement %statement, %Statement* %t2840
  %t2841 = getelementptr inbounds %Statement, %Statement* %t2840, i32 0, i32 1
  %t2842 = bitcast [48 x i8]* %t2841 to i8*
  %t2843 = getelementptr inbounds i8, i8* %t2842, i64 8
  %t2844 = bitcast i8* %t2843 to %SourceSpan**
  %t2845 = load %SourceSpan*, %SourceSpan** %t2844
  %t2846 = icmp eq i32 %t2839, 3
  %t2847 = select i1 %t2846, %SourceSpan* %t2845, %SourceSpan* null
  %t2848 = getelementptr inbounds %Statement, %Statement* %t2840, i32 0, i32 1
  %t2849 = bitcast [40 x i8]* %t2848 to i8*
  %t2850 = getelementptr inbounds i8, i8* %t2849, i64 8
  %t2851 = bitcast i8* %t2850 to %SourceSpan**
  %t2852 = load %SourceSpan*, %SourceSpan** %t2851
  %t2853 = icmp eq i32 %t2839, 6
  %t2854 = select i1 %t2853, %SourceSpan* %t2852, %SourceSpan* %t2847
  %t2855 = getelementptr inbounds %Statement, %Statement* %t2840, i32 0, i32 1
  %t2856 = bitcast [56 x i8]* %t2855 to i8*
  %t2857 = getelementptr inbounds i8, i8* %t2856, i64 8
  %t2858 = bitcast i8* %t2857 to %SourceSpan**
  %t2859 = load %SourceSpan*, %SourceSpan** %t2858
  %t2860 = icmp eq i32 %t2839, 8
  %t2861 = select i1 %t2860, %SourceSpan* %t2859, %SourceSpan* %t2854
  %t2862 = getelementptr inbounds %Statement, %Statement* %t2840, i32 0, i32 1
  %t2863 = bitcast [40 x i8]* %t2862 to i8*
  %t2864 = getelementptr inbounds i8, i8* %t2863, i64 8
  %t2865 = bitcast i8* %t2864 to %SourceSpan**
  %t2866 = load %SourceSpan*, %SourceSpan** %t2865
  %t2867 = icmp eq i32 %t2839, 9
  %t2868 = select i1 %t2867, %SourceSpan* %t2866, %SourceSpan* %t2861
  %t2869 = getelementptr inbounds %Statement, %Statement* %t2840, i32 0, i32 1
  %t2870 = bitcast [40 x i8]* %t2869 to i8*
  %t2871 = getelementptr inbounds i8, i8* %t2870, i64 8
  %t2872 = bitcast i8* %t2871 to %SourceSpan**
  %t2873 = load %SourceSpan*, %SourceSpan** %t2872
  %t2874 = icmp eq i32 %t2839, 10
  %t2875 = select i1 %t2874, %SourceSpan* %t2873, %SourceSpan* %t2868
  %t2876 = getelementptr inbounds %Statement, %Statement* %t2840, i32 0, i32 1
  %t2877 = bitcast [40 x i8]* %t2876 to i8*
  %t2878 = getelementptr inbounds i8, i8* %t2877, i64 8
  %t2879 = bitcast i8* %t2878 to %SourceSpan**
  %t2880 = load %SourceSpan*, %SourceSpan** %t2879
  %t2881 = icmp eq i32 %t2839, 11
  %t2882 = select i1 %t2881, %SourceSpan* %t2880, %SourceSpan* %t2875
  %t2883 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t2837, i8* %s2838, %SourceSpan* %t2882)
  store %ScopeResult %t2883, %ScopeResult* %l25
  %t2884 = load %ScopeResult, %ScopeResult* %l25
  %t2885 = extractvalue %ScopeResult %t2884, 1
  %t2886 = extractvalue %Statement %statement, 0
  %t2887 = alloca %Statement
  store %Statement %statement, %Statement* %t2887
  %t2888 = getelementptr inbounds %Statement, %Statement* %t2887, i32 0, i32 1
  %t2889 = bitcast [56 x i8]* %t2888 to i8*
  %t2890 = getelementptr inbounds i8, i8* %t2889, i64 16
  %t2891 = bitcast i8* %t2890 to { %TypeParameter**, i64 }**
  %t2892 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2891
  %t2893 = icmp eq i32 %t2886, 8
  %t2894 = select i1 %t2893, { %TypeParameter**, i64 }* %t2892, { %TypeParameter**, i64 }* null
  %t2895 = getelementptr inbounds %Statement, %Statement* %t2887, i32 0, i32 1
  %t2896 = bitcast [40 x i8]* %t2895 to i8*
  %t2897 = getelementptr inbounds i8, i8* %t2896, i64 16
  %t2898 = bitcast i8* %t2897 to { %TypeParameter**, i64 }**
  %t2899 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2898
  %t2900 = icmp eq i32 %t2886, 9
  %t2901 = select i1 %t2900, { %TypeParameter**, i64 }* %t2899, { %TypeParameter**, i64 }* %t2894
  %t2902 = getelementptr inbounds %Statement, %Statement* %t2887, i32 0, i32 1
  %t2903 = bitcast [40 x i8]* %t2902 to i8*
  %t2904 = getelementptr inbounds i8, i8* %t2903, i64 16
  %t2905 = bitcast i8* %t2904 to { %TypeParameter**, i64 }**
  %t2906 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2905
  %t2907 = icmp eq i32 %t2886, 10
  %t2908 = select i1 %t2907, { %TypeParameter**, i64 }* %t2906, { %TypeParameter**, i64 }* %t2901
  %t2909 = getelementptr inbounds %Statement, %Statement* %t2887, i32 0, i32 1
  %t2910 = bitcast [40 x i8]* %t2909 to i8*
  %t2911 = getelementptr inbounds i8, i8* %t2910, i64 16
  %t2912 = bitcast i8* %t2911 to { %TypeParameter**, i64 }**
  %t2913 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2912
  %t2914 = icmp eq i32 %t2886, 11
  %t2915 = select i1 %t2914, { %TypeParameter**, i64 }* %t2913, { %TypeParameter**, i64 }* %t2908
  %t2916 = bitcast { %TypeParameter**, i64 }* %t2915 to { %TypeParameter*, i64 }*
  %t2917 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t2916)
  %t2918 = bitcast { %Diagnostic**, i64 }* %t2885 to { i8**, i64 }*
  %t2919 = bitcast { %Diagnostic*, i64 }* %t2917 to { i8**, i64 }*
  %t2920 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2918, { i8**, i64 }* %t2919)
  store { i8**, i64 }* %t2920, { i8**, i64 }** %l26
  %t2921 = load %ScopeResult, %ScopeResult* %l25
  %t2922 = extractvalue %ScopeResult %t2921, 0
  %t2923 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2922, 0
  %t2924 = load { i8**, i64 }*, { i8**, i64 }** %l26
  %t2925 = bitcast { i8**, i64 }* %t2924 to { %Diagnostic**, i64 }*
  %t2926 = insertvalue %ScopeResult %t2923, { %Diagnostic**, i64 }* %t2925, 1
  ret %ScopeResult %t2926
merge47:
  %t2927 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2928 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2927, 0
  %t2929 = getelementptr [0 x %Diagnostic*], [0 x %Diagnostic*]* null, i32 1
  %t2930 = ptrtoint [0 x %Diagnostic*]* %t2929 to i64
  %t2931 = icmp eq i64 %t2930, 0
  %t2932 = select i1 %t2931, i64 1, i64 %t2930
  %t2933 = call i8* @malloc(i64 %t2932)
  %t2934 = bitcast i8* %t2933 to %Diagnostic**
  %t2935 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* null, i32 1
  %t2936 = ptrtoint { %Diagnostic**, i64 }* %t2935 to i64
  %t2937 = call i8* @malloc(i64 %t2936)
  %t2938 = bitcast i8* %t2937 to { %Diagnostic**, i64 }*
  %t2939 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t2938, i32 0, i32 0
  store %Diagnostic** %t2934, %Diagnostic*** %t2939
  %t2940 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t2938, i32 0, i32 1
  store i64 0, i64* %t2940
  %t2941 = insertvalue %ScopeResult %t2928, { %Diagnostic**, i64 }* %t2938, 1
  ret %ScopeResult %t2941
}

define { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %signature, %Block %body, { %Statement*, i64 }* %interfaces) {
block.entry:
  %l0 = alloca %ScopeResult
  %l1 = alloca { %Diagnostic*, i64 }*
  %t0 = call %ScopeResult @seed_parameter_scope(%FunctionSignature %signature)
  store %ScopeResult %t0, %ScopeResult* %l0
  %t1 = load %ScopeResult, %ScopeResult* %l0
  %t2 = extractvalue %ScopeResult %t1, 0
  %t3 = bitcast { %SymbolEntry**, i64 }* %t2 to { %SymbolEntry*, i64 }*
  %t4 = call { %Diagnostic*, i64 }* @check_block(%Block %body, { %SymbolEntry*, i64 }* %t3, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t4, { %Diagnostic*, i64 }** %l1
  %t5 = load %ScopeResult, %ScopeResult* %l0
  %t6 = extractvalue %ScopeResult %t5, 1
  %t7 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t8 = bitcast { %Diagnostic**, i64 }* %t6 to { i8**, i64 }*
  %t9 = bitcast { %Diagnostic*, i64 }* %t7 to { i8**, i64 }*
  %t10 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t9)
  %t11 = bitcast { i8**, i64 }* %t10 to { %Diagnostic*, i64 }*
  ret { %Diagnostic*, i64 }* %t11
}

define %ScopeResult @seed_parameter_scope(%FunctionSignature %signature) {
block.entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %Parameter*
  %l4 = alloca %ScopeResult
  %t0 = getelementptr [0 x %SymbolEntry], [0 x %SymbolEntry]* null, i32 1
  %t1 = ptrtoint [0 x %SymbolEntry]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %SymbolEntry*
  %t6 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* null, i32 1
  %t7 = ptrtoint { %SymbolEntry*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %SymbolEntry*, i64 }*
  %t10 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t9, i32 0, i32 0
  store %SymbolEntry* %t5, %SymbolEntry** %t10
  %t11 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %SymbolEntry*, i64 }* %t9, { %SymbolEntry*, i64 }** %l0
  %t12 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t13 = ptrtoint [0 x %Diagnostic]* %t12 to i64
  %t14 = icmp eq i64 %t13, 0
  %t15 = select i1 %t14, i64 1, i64 %t13
  %t16 = call i8* @malloc(i64 %t15)
  %t17 = bitcast i8* %t16 to %Diagnostic*
  %t18 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t19 = ptrtoint { %Diagnostic*, i64 }* %t18 to i64
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to { %Diagnostic*, i64 }*
  %t22 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t21, i32 0, i32 0
  store %Diagnostic* %t17, %Diagnostic** %t22
  %t23 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t21, i32 0, i32 1
  store i64 0, i64* %t23
  store { %Diagnostic*, i64 }* %t21, { %Diagnostic*, i64 }** %l1
  %t24 = extractvalue %FunctionSignature %signature, 2
  %t25 = getelementptr { %Parameter**, i64 }, { %Parameter**, i64 }* %t24, i32 0, i32 1
  %t26 = load i64, i64* %t25
  %t27 = getelementptr { %Parameter**, i64 }, { %Parameter**, i64 }* %t24, i32 0, i32 0
  %t28 = load %Parameter**, %Parameter*** %t27
  store i64 0, i64* %l2
  store %Parameter* null, %Parameter** %l3
  br label %for0
for0:
  %t29 = load i64, i64* %l2
  %t30 = icmp slt i64 %t29, %t26
  br i1 %t30, label %forbody1, label %afterfor3
forbody1:
  %t31 = load i64, i64* %l2
  %t32 = getelementptr %Parameter*, %Parameter** %t28, i64 %t31
  %t33 = load %Parameter*, %Parameter** %t32
  store %Parameter* %t33, %Parameter** %l3
  %t34 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t35 = load %Parameter*, %Parameter** %l3
  %t36 = getelementptr %Parameter, %Parameter* %t35, i32 0, i32 0
  %t37 = load i8*, i8** %t36
  %s38 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1747065903, i32 0, i32 0
  %t39 = load %Parameter*, %Parameter** %l3
  %t40 = getelementptr %Parameter, %Parameter* %t39, i32 0, i32 4
  %t41 = load %SourceSpan*, %SourceSpan** %t40
  %t42 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %t34, i8* %t37, i8* %s38, %SourceSpan* %t41)
  store %ScopeResult %t42, %ScopeResult* %l4
  %t43 = load %ScopeResult, %ScopeResult* %l4
  %t44 = extractvalue %ScopeResult %t43, 0
  %t45 = bitcast { %SymbolEntry**, i64 }* %t44 to { %SymbolEntry*, i64 }*
  store { %SymbolEntry*, i64 }* %t45, { %SymbolEntry*, i64 }** %l0
  %t46 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t47 = load %ScopeResult, %ScopeResult* %l4
  %t48 = extractvalue %ScopeResult %t47, 1
  %t49 = bitcast { %Diagnostic*, i64 }* %t46 to { i8**, i64 }*
  %t50 = bitcast { %Diagnostic**, i64 }* %t48 to { i8**, i64 }*
  %t51 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t49, { i8**, i64 }* %t50)
  %t52 = bitcast { i8**, i64 }* %t51 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t52, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t53 = load i64, i64* %l2
  %t54 = add i64 %t53, 1
  store i64 %t54, i64* %l2
  br label %for0
afterfor3:
  %t55 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t56 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t57 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t58 = bitcast { %SymbolEntry*, i64 }* %t57 to { %SymbolEntry**, i64 }*
  %t59 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t58, 0
  %t60 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t61 = bitcast { %Diagnostic*, i64 }* %t60 to { %Diagnostic**, i64 }*
  %t62 = insertvalue %ScopeResult %t59, { %Diagnostic**, i64 }* %t61, 1
  ret %ScopeResult %t62
}

define { %Diagnostic*, i64 }* @check_block(%Block %block, { %SymbolEntry*, i64 }* %parent_bindings, { %Statement*, i64 }* %interfaces) {
block.entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %Statement*
  %l4 = alloca %ScopeResult
  %t0 = call { %SymbolEntry*, i64 }* @clone_bindings({ %SymbolEntry*, i64 }* %parent_bindings)
  store { %SymbolEntry*, i64 }* %t0, { %SymbolEntry*, i64 }** %l0
  %t1 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t2 = ptrtoint [0 x %Diagnostic]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to %Diagnostic*
  %t7 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t8 = ptrtoint { %Diagnostic*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %Diagnostic*, i64 }*
  %t11 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t10, i32 0, i32 0
  store %Diagnostic* %t6, %Diagnostic** %t11
  %t12 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { %Diagnostic*, i64 }* %t10, { %Diagnostic*, i64 }** %l1
  %t13 = extractvalue %Block %block, 2
  %t14 = getelementptr { %Statement**, i64 }, { %Statement**, i64 }* %t13, i32 0, i32 1
  %t15 = load i64, i64* %t14
  %t16 = getelementptr { %Statement**, i64 }, { %Statement**, i64 }* %t13, i32 0, i32 0
  %t17 = load %Statement**, %Statement*** %t16
  store i64 0, i64* %l2
  store %Statement* null, %Statement** %l3
  br label %for0
for0:
  %t18 = load i64, i64* %l2
  %t19 = icmp slt i64 %t18, %t15
  br i1 %t19, label %forbody1, label %afterfor3
forbody1:
  %t20 = load i64, i64* %l2
  %t21 = getelementptr %Statement*, %Statement** %t17, i64 %t20
  %t22 = load %Statement*, %Statement** %t21
  store %Statement* %t22, %Statement** %l3
  %t23 = load %Statement*, %Statement** %l3
  %t24 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t25 = load %Statement, %Statement* %t23
  %t26 = call %ScopeResult @check_statement(%Statement %t25, { %SymbolEntry*, i64 }* %t24, { %Statement*, i64 }* %interfaces)
  store %ScopeResult %t26, %ScopeResult* %l4
  %t27 = load %ScopeResult, %ScopeResult* %l4
  %t28 = extractvalue %ScopeResult %t27, 0
  %t29 = bitcast { %SymbolEntry**, i64 }* %t28 to { %SymbolEntry*, i64 }*
  store { %SymbolEntry*, i64 }* %t29, { %SymbolEntry*, i64 }** %l0
  %t30 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t31 = load %ScopeResult, %ScopeResult* %l4
  %t32 = extractvalue %ScopeResult %t31, 1
  %t33 = bitcast { %Diagnostic*, i64 }* %t30 to { i8**, i64 }*
  %t34 = bitcast { %Diagnostic**, i64 }* %t32 to { i8**, i64 }*
  %t35 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t33, { i8**, i64 }* %t34)
  %t36 = bitcast { i8**, i64 }* %t35 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t36, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t37 = load i64, i64* %l2
  %t38 = add i64 %t37, 1
  store i64 %t38, i64* %l2
  br label %for0
afterfor3:
  %t39 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t40 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t41 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t41
}

define { %Diagnostic*, i64 }* @check_struct_implements_interfaces(%Statement %statement, { %Statement*, i64 }* %interfaces) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i64
  %l2 = alloca %MethodDeclaration*
  %l3 = alloca { %Diagnostic*, i64 }*
  %l4 = alloca i64
  %l5 = alloca %TypeAnnotation*
  %l6 = alloca %Statement*
  %l7 = alloca i8*
  %l8 = alloca i64
  %l9 = alloca %FunctionSignature*
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [56 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 24
  %t5 = bitcast i8* %t4 to { %TypeAnnotation**, i64 }**
  %t6 = load { %TypeAnnotation**, i64 }*, { %TypeAnnotation**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 8
  %t8 = select i1 %t7, { %TypeAnnotation**, i64 }* %t6, { %TypeAnnotation**, i64 }* null
  %t9 = load { %TypeAnnotation**, i64 }, { %TypeAnnotation**, i64 }* %t8
  %t10 = extractvalue { %TypeAnnotation**, i64 } %t9, 1
  %t11 = icmp eq i64 %t10, 0
  br i1 %t11, label %then0, label %merge1
then0:
  %t12 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t13 = ptrtoint [0 x %Diagnostic]* %t12 to i64
  %t14 = icmp eq i64 %t13, 0
  %t15 = select i1 %t14, i64 1, i64 %t13
  %t16 = call i8* @malloc(i64 %t15)
  %t17 = bitcast i8* %t16 to %Diagnostic*
  %t18 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t19 = ptrtoint { %Diagnostic*, i64 }* %t18 to i64
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to { %Diagnostic*, i64 }*
  %t22 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t21, i32 0, i32 0
  store %Diagnostic* %t17, %Diagnostic** %t22
  %t23 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t21, i32 0, i32 1
  store i64 0, i64* %t23
  ret { %Diagnostic*, i64 }* %t21
merge1:
  %t24 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t25 = ptrtoint [0 x i8*]* %t24 to i64
  %t26 = icmp eq i64 %t25, 0
  %t27 = select i1 %t26, i64 1, i64 %t25
  %t28 = call i8* @malloc(i64 %t27)
  %t29 = bitcast i8* %t28 to i8**
  %t30 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t31 = ptrtoint { i8**, i64 }* %t30 to i64
  %t32 = call i8* @malloc(i64 %t31)
  %t33 = bitcast i8* %t32 to { i8**, i64 }*
  %t34 = getelementptr { i8**, i64 }, { i8**, i64 }* %t33, i32 0, i32 0
  store i8** %t29, i8*** %t34
  %t35 = getelementptr { i8**, i64 }, { i8**, i64 }* %t33, i32 0, i32 1
  store i64 0, i64* %t35
  store { i8**, i64 }* %t33, { i8**, i64 }** %l0
  %t36 = extractvalue %Statement %statement, 0
  %t37 = alloca %Statement
  store %Statement %statement, %Statement* %t37
  %t38 = getelementptr inbounds %Statement, %Statement* %t37, i32 0, i32 1
  %t39 = bitcast [56 x i8]* %t38 to i8*
  %t40 = getelementptr inbounds i8, i8* %t39, i64 40
  %t41 = bitcast i8* %t40 to { %MethodDeclaration**, i64 }**
  %t42 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t41
  %t43 = icmp eq i32 %t36, 8
  %t44 = select i1 %t43, { %MethodDeclaration**, i64 }* %t42, { %MethodDeclaration**, i64 }* null
  %t45 = getelementptr { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t44, i32 0, i32 1
  %t46 = load i64, i64* %t45
  %t47 = getelementptr { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t44, i32 0, i32 0
  %t48 = load %MethodDeclaration**, %MethodDeclaration*** %t47
  store i64 0, i64* %l1
  store %MethodDeclaration* null, %MethodDeclaration** %l2
  br label %for2
for2:
  %t49 = load i64, i64* %l1
  %t50 = icmp slt i64 %t49, %t46
  br i1 %t50, label %forbody3, label %afterfor5
forbody3:
  %t51 = load i64, i64* %l1
  %t52 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t48, i64 %t51
  %t53 = load %MethodDeclaration*, %MethodDeclaration** %t52
  store %MethodDeclaration* %t53, %MethodDeclaration** %l2
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load %MethodDeclaration*, %MethodDeclaration** %l2
  %t56 = getelementptr %MethodDeclaration, %MethodDeclaration* %t55, i32 0, i32 0
  %t57 = load %FunctionSignature, %FunctionSignature* %t56
  %t58 = extractvalue %FunctionSignature %t57, 0
  %t59 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t60 = ptrtoint [1 x i8*]* %t59 to i64
  %t61 = icmp eq i64 %t60, 0
  %t62 = select i1 %t61, i64 1, i64 %t60
  %t63 = call i8* @malloc(i64 %t62)
  %t64 = bitcast i8* %t63 to i8**
  %t65 = getelementptr i8*, i8** %t64, i64 0
  store i8* %t58, i8** %t65
  %t66 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t67 = ptrtoint { i8**, i64 }* %t66 to i64
  %t68 = call i8* @malloc(i64 %t67)
  %t69 = bitcast i8* %t68 to { i8**, i64 }*
  %t70 = getelementptr { i8**, i64 }, { i8**, i64 }* %t69, i32 0, i32 0
  store i8** %t64, i8*** %t70
  %t71 = getelementptr { i8**, i64 }, { i8**, i64 }* %t69, i32 0, i32 1
  store i64 1, i64* %t71
  %t72 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t54, { i8**, i64 }* %t69)
  store { i8**, i64 }* %t72, { i8**, i64 }** %l0
  br label %forinc4
forinc4:
  %t73 = load i64, i64* %l1
  %t74 = add i64 %t73, 1
  store i64 %t74, i64* %l1
  br label %for2
afterfor5:
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t76 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t77 = ptrtoint [0 x %Diagnostic]* %t76 to i64
  %t78 = icmp eq i64 %t77, 0
  %t79 = select i1 %t78, i64 1, i64 %t77
  %t80 = call i8* @malloc(i64 %t79)
  %t81 = bitcast i8* %t80 to %Diagnostic*
  %t82 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t83 = ptrtoint { %Diagnostic*, i64 }* %t82 to i64
  %t84 = call i8* @malloc(i64 %t83)
  %t85 = bitcast i8* %t84 to { %Diagnostic*, i64 }*
  %t86 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t85, i32 0, i32 0
  store %Diagnostic* %t81, %Diagnostic** %t86
  %t87 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t85, i32 0, i32 1
  store i64 0, i64* %t87
  store { %Diagnostic*, i64 }* %t85, { %Diagnostic*, i64 }** %l3
  %t88 = extractvalue %Statement %statement, 0
  %t89 = alloca %Statement
  store %Statement %statement, %Statement* %t89
  %t90 = getelementptr inbounds %Statement, %Statement* %t89, i32 0, i32 1
  %t91 = bitcast [56 x i8]* %t90 to i8*
  %t92 = getelementptr inbounds i8, i8* %t91, i64 24
  %t93 = bitcast i8* %t92 to { %TypeAnnotation**, i64 }**
  %t94 = load { %TypeAnnotation**, i64 }*, { %TypeAnnotation**, i64 }** %t93
  %t95 = icmp eq i32 %t88, 8
  %t96 = select i1 %t95, { %TypeAnnotation**, i64 }* %t94, { %TypeAnnotation**, i64 }* null
  %t97 = getelementptr { %TypeAnnotation**, i64 }, { %TypeAnnotation**, i64 }* %t96, i32 0, i32 1
  %t98 = load i64, i64* %t97
  %t99 = getelementptr { %TypeAnnotation**, i64 }, { %TypeAnnotation**, i64 }* %t96, i32 0, i32 0
  %t100 = load %TypeAnnotation**, %TypeAnnotation*** %t99
  store i64 0, i64* %l4
  store %TypeAnnotation* null, %TypeAnnotation** %l5
  br label %for6
for6:
  %t101 = load i64, i64* %l4
  %t102 = icmp slt i64 %t101, %t98
  br i1 %t102, label %forbody7, label %afterfor9
forbody7:
  %t103 = load i64, i64* %l4
  %t104 = getelementptr %TypeAnnotation*, %TypeAnnotation** %t100, i64 %t103
  %t105 = load %TypeAnnotation*, %TypeAnnotation** %t104
  store %TypeAnnotation* %t105, %TypeAnnotation** %l5
  %t106 = load %TypeAnnotation*, %TypeAnnotation** %l5
  %t107 = load %TypeAnnotation, %TypeAnnotation* %t106
  %t108 = call %Statement* @resolve_interface_annotation(%TypeAnnotation %t107, { %Statement*, i64 }* %interfaces)
  store %Statement* %t108, %Statement** %l6
  %t109 = load %Statement*, %Statement** %l6
  %t110 = icmp eq %Statement* %t109, null
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t112 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  %t113 = load %TypeAnnotation*, %TypeAnnotation** %l5
  %t114 = load %Statement*, %Statement** %l6
  br i1 %t110, label %then10, label %merge11
then10:
  br label %forinc8
merge11:
  %t115 = load %Statement*, %Statement** %l6
  %t116 = getelementptr inbounds %Statement, %Statement* %t115, i32 0, i32 0
  %t117 = load i32, i32* %t116
  %t118 = getelementptr inbounds %Statement, %Statement* %t115, i32 0, i32 1
  %t119 = bitcast [48 x i8]* %t118 to i8*
  %t120 = bitcast i8* %t119 to i8**
  %t121 = load i8*, i8** %t120
  %t122 = icmp eq i32 %t117, 2
  %t123 = select i1 %t122, i8* %t121, i8* null
  %t124 = getelementptr inbounds %Statement, %Statement* %t115, i32 0, i32 1
  %t125 = bitcast [48 x i8]* %t124 to i8*
  %t126 = bitcast i8* %t125 to i8**
  %t127 = load i8*, i8** %t126
  %t128 = icmp eq i32 %t117, 3
  %t129 = select i1 %t128, i8* %t127, i8* %t123
  %t130 = getelementptr inbounds %Statement, %Statement* %t115, i32 0, i32 1
  %t131 = bitcast [40 x i8]* %t130 to i8*
  %t132 = bitcast i8* %t131 to i8**
  %t133 = load i8*, i8** %t132
  %t134 = icmp eq i32 %t117, 6
  %t135 = select i1 %t134, i8* %t133, i8* %t129
  %t136 = getelementptr inbounds %Statement, %Statement* %t115, i32 0, i32 1
  %t137 = bitcast [56 x i8]* %t136 to i8*
  %t138 = bitcast i8* %t137 to i8**
  %t139 = load i8*, i8** %t138
  %t140 = icmp eq i32 %t117, 8
  %t141 = select i1 %t140, i8* %t139, i8* %t135
  %t142 = getelementptr inbounds %Statement, %Statement* %t115, i32 0, i32 1
  %t143 = bitcast [40 x i8]* %t142 to i8*
  %t144 = bitcast i8* %t143 to i8**
  %t145 = load i8*, i8** %t144
  %t146 = icmp eq i32 %t117, 9
  %t147 = select i1 %t146, i8* %t145, i8* %t141
  %t148 = getelementptr inbounds %Statement, %Statement* %t115, i32 0, i32 1
  %t149 = bitcast [40 x i8]* %t148 to i8*
  %t150 = bitcast i8* %t149 to i8**
  %t151 = load i8*, i8** %t150
  %t152 = icmp eq i32 %t117, 10
  %t153 = select i1 %t152, i8* %t151, i8* %t147
  %t154 = getelementptr inbounds %Statement, %Statement* %t115, i32 0, i32 1
  %t155 = bitcast [40 x i8]* %t154 to i8*
  %t156 = bitcast i8* %t155 to i8**
  %t157 = load i8*, i8** %t156
  %t158 = icmp eq i32 %t117, 11
  %t159 = select i1 %t158, i8* %t157, i8* %t153
  store i8* %t159, i8** %l7
  %t160 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  %t161 = extractvalue %Statement %statement, 0
  %t162 = alloca %Statement
  store %Statement %statement, %Statement* %t162
  %t163 = getelementptr inbounds %Statement, %Statement* %t162, i32 0, i32 1
  %t164 = bitcast [48 x i8]* %t163 to i8*
  %t165 = bitcast i8* %t164 to i8**
  %t166 = load i8*, i8** %t165
  %t167 = icmp eq i32 %t161, 2
  %t168 = select i1 %t167, i8* %t166, i8* null
  %t169 = getelementptr inbounds %Statement, %Statement* %t162, i32 0, i32 1
  %t170 = bitcast [48 x i8]* %t169 to i8*
  %t171 = bitcast i8* %t170 to i8**
  %t172 = load i8*, i8** %t171
  %t173 = icmp eq i32 %t161, 3
  %t174 = select i1 %t173, i8* %t172, i8* %t168
  %t175 = getelementptr inbounds %Statement, %Statement* %t162, i32 0, i32 1
  %t176 = bitcast [40 x i8]* %t175 to i8*
  %t177 = bitcast i8* %t176 to i8**
  %t178 = load i8*, i8** %t177
  %t179 = icmp eq i32 %t161, 6
  %t180 = select i1 %t179, i8* %t178, i8* %t174
  %t181 = getelementptr inbounds %Statement, %Statement* %t162, i32 0, i32 1
  %t182 = bitcast [56 x i8]* %t181 to i8*
  %t183 = bitcast i8* %t182 to i8**
  %t184 = load i8*, i8** %t183
  %t185 = icmp eq i32 %t161, 8
  %t186 = select i1 %t185, i8* %t184, i8* %t180
  %t187 = getelementptr inbounds %Statement, %Statement* %t162, i32 0, i32 1
  %t188 = bitcast [40 x i8]* %t187 to i8*
  %t189 = bitcast i8* %t188 to i8**
  %t190 = load i8*, i8** %t189
  %t191 = icmp eq i32 %t161, 9
  %t192 = select i1 %t191, i8* %t190, i8* %t186
  %t193 = getelementptr inbounds %Statement, %Statement* %t162, i32 0, i32 1
  %t194 = bitcast [40 x i8]* %t193 to i8*
  %t195 = bitcast i8* %t194 to i8**
  %t196 = load i8*, i8** %t195
  %t197 = icmp eq i32 %t161, 10
  %t198 = select i1 %t197, i8* %t196, i8* %t192
  %t199 = getelementptr inbounds %Statement, %Statement* %t162, i32 0, i32 1
  %t200 = bitcast [40 x i8]* %t199 to i8*
  %t201 = bitcast i8* %t200 to i8**
  %t202 = load i8*, i8** %t201
  %t203 = icmp eq i32 %t161, 11
  %t204 = select i1 %t203, i8* %t202, i8* %t198
  %t205 = load %Statement*, %Statement** %l6
  %t206 = load %TypeAnnotation*, %TypeAnnotation** %l5
  %t207 = load %Statement, %Statement* %t205
  %t208 = load %TypeAnnotation, %TypeAnnotation* %t206
  %t209 = call { %Diagnostic*, i64 }* @validate_interface_annotation(i8* %t204, %Statement %t207, %TypeAnnotation %t208)
  %t210 = bitcast { %Diagnostic*, i64 }* %t160 to { i8**, i64 }*
  %t211 = bitcast { %Diagnostic*, i64 }* %t209 to { i8**, i64 }*
  %t212 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t210, { i8**, i64 }* %t211)
  %t213 = bitcast { i8**, i64 }* %t212 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t213, { %Diagnostic*, i64 }** %l3
  %t214 = load %Statement*, %Statement** %l6
  %t215 = getelementptr inbounds %Statement, %Statement* %t214, i32 0, i32 0
  %t216 = load i32, i32* %t215
  %t217 = getelementptr inbounds %Statement, %Statement* %t214, i32 0, i32 1
  %t218 = bitcast [40 x i8]* %t217 to i8*
  %t219 = getelementptr inbounds i8, i8* %t218, i64 24
  %t220 = bitcast i8* %t219 to { %FunctionSignature**, i64 }**
  %t221 = load { %FunctionSignature**, i64 }*, { %FunctionSignature**, i64 }** %t220
  %t222 = icmp eq i32 %t216, 10
  %t223 = select i1 %t222, { %FunctionSignature**, i64 }* %t221, { %FunctionSignature**, i64 }* null
  %t224 = getelementptr { %FunctionSignature**, i64 }, { %FunctionSignature**, i64 }* %t223, i32 0, i32 1
  %t225 = load i64, i64* %t224
  %t226 = getelementptr { %FunctionSignature**, i64 }, { %FunctionSignature**, i64 }* %t223, i32 0, i32 0
  %t227 = load %FunctionSignature**, %FunctionSignature*** %t226
  store i64 0, i64* %l8
  store %FunctionSignature* null, %FunctionSignature** %l9
  br label %for12
for12:
  %t228 = load i64, i64* %l8
  %t229 = icmp slt i64 %t228, %t225
  br i1 %t229, label %forbody13, label %afterfor15
forbody13:
  %t230 = load i64, i64* %l8
  %t231 = getelementptr %FunctionSignature*, %FunctionSignature** %t227, i64 %t230
  %t232 = load %FunctionSignature*, %FunctionSignature** %t231
  store %FunctionSignature* %t232, %FunctionSignature** %l9
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t234 = load %FunctionSignature*, %FunctionSignature** %l9
  %t235 = getelementptr %FunctionSignature, %FunctionSignature* %t234, i32 0, i32 0
  %t236 = load i8*, i8** %t235
  %t237 = call i1 @contains_string({ i8**, i64 }* %t233, i8* %t236)
  %t238 = xor i1 %t237, 1
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t240 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  %t241 = load %TypeAnnotation*, %TypeAnnotation** %l5
  %t242 = load %Statement*, %Statement** %l6
  %t243 = load i8*, i8** %l7
  %t244 = load %FunctionSignature*, %FunctionSignature** %l9
  br i1 %t238, label %then16, label %merge17
then16:
  %t245 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  %t246 = extractvalue %Statement %statement, 0
  %t247 = alloca %Statement
  store %Statement %statement, %Statement* %t247
  %t248 = getelementptr inbounds %Statement, %Statement* %t247, i32 0, i32 1
  %t249 = bitcast [48 x i8]* %t248 to i8*
  %t250 = bitcast i8* %t249 to i8**
  %t251 = load i8*, i8** %t250
  %t252 = icmp eq i32 %t246, 2
  %t253 = select i1 %t252, i8* %t251, i8* null
  %t254 = getelementptr inbounds %Statement, %Statement* %t247, i32 0, i32 1
  %t255 = bitcast [48 x i8]* %t254 to i8*
  %t256 = bitcast i8* %t255 to i8**
  %t257 = load i8*, i8** %t256
  %t258 = icmp eq i32 %t246, 3
  %t259 = select i1 %t258, i8* %t257, i8* %t253
  %t260 = getelementptr inbounds %Statement, %Statement* %t247, i32 0, i32 1
  %t261 = bitcast [40 x i8]* %t260 to i8*
  %t262 = bitcast i8* %t261 to i8**
  %t263 = load i8*, i8** %t262
  %t264 = icmp eq i32 %t246, 6
  %t265 = select i1 %t264, i8* %t263, i8* %t259
  %t266 = getelementptr inbounds %Statement, %Statement* %t247, i32 0, i32 1
  %t267 = bitcast [56 x i8]* %t266 to i8*
  %t268 = bitcast i8* %t267 to i8**
  %t269 = load i8*, i8** %t268
  %t270 = icmp eq i32 %t246, 8
  %t271 = select i1 %t270, i8* %t269, i8* %t265
  %t272 = getelementptr inbounds %Statement, %Statement* %t247, i32 0, i32 1
  %t273 = bitcast [40 x i8]* %t272 to i8*
  %t274 = bitcast i8* %t273 to i8**
  %t275 = load i8*, i8** %t274
  %t276 = icmp eq i32 %t246, 9
  %t277 = select i1 %t276, i8* %t275, i8* %t271
  %t278 = getelementptr inbounds %Statement, %Statement* %t247, i32 0, i32 1
  %t279 = bitcast [40 x i8]* %t278 to i8*
  %t280 = bitcast i8* %t279 to i8**
  %t281 = load i8*, i8** %t280
  %t282 = icmp eq i32 %t246, 10
  %t283 = select i1 %t282, i8* %t281, i8* %t277
  %t284 = getelementptr inbounds %Statement, %Statement* %t247, i32 0, i32 1
  %t285 = bitcast [40 x i8]* %t284 to i8*
  %t286 = bitcast i8* %t285 to i8**
  %t287 = load i8*, i8** %t286
  %t288 = icmp eq i32 %t246, 11
  %t289 = select i1 %t288, i8* %t287, i8* %t283
  %t290 = load i8*, i8** %l7
  %t291 = load %FunctionSignature*, %FunctionSignature** %l9
  %t292 = getelementptr %FunctionSignature, %FunctionSignature* %t291, i32 0, i32 0
  %t293 = load i8*, i8** %t292
  %t294 = call %Diagnostic @make_missing_interface_member_diagnostic(i8* %t289, i8* %t290, i8* %t293)
  %t295 = call noalias i8* @malloc(i64 24)
  %t296 = bitcast i8* %t295 to %Diagnostic*
  store %Diagnostic %t294, %Diagnostic* %t296
  %t297 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t298 = ptrtoint [1 x i8*]* %t297 to i64
  %t299 = icmp eq i64 %t298, 0
  %t300 = select i1 %t299, i64 1, i64 %t298
  %t301 = call i8* @malloc(i64 %t300)
  %t302 = bitcast i8* %t301 to i8**
  %t303 = getelementptr i8*, i8** %t302, i64 0
  store i8* %t295, i8** %t303
  %t304 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t305 = ptrtoint { i8**, i64 }* %t304 to i64
  %t306 = call i8* @malloc(i64 %t305)
  %t307 = bitcast i8* %t306 to { i8**, i64 }*
  %t308 = getelementptr { i8**, i64 }, { i8**, i64 }* %t307, i32 0, i32 0
  store i8** %t302, i8*** %t308
  %t309 = getelementptr { i8**, i64 }, { i8**, i64 }* %t307, i32 0, i32 1
  store i64 1, i64* %t309
  %t310 = bitcast { %Diagnostic*, i64 }* %t245 to { i8**, i64 }*
  %t311 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t310, { i8**, i64 }* %t307)
  %t312 = bitcast { i8**, i64 }* %t311 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t312, { %Diagnostic*, i64 }** %l3
  %t313 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  br label %merge17
merge17:
  %t314 = phi { %Diagnostic*, i64 }* [ %t313, %then16 ], [ %t240, %forbody13 ]
  store { %Diagnostic*, i64 }* %t314, { %Diagnostic*, i64 }** %l3
  br label %forinc14
forinc14:
  %t315 = load i64, i64* %l8
  %t316 = add i64 %t315, 1
  store i64 %t316, i64* %l8
  br label %for12
afterfor15:
  %t317 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  br label %forinc8
forinc8:
  %t318 = load i64, i64* %l4
  %t319 = add i64 %t318, 1
  store i64 %t319, i64* %l4
  br label %for6
afterfor9:
  %t320 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  %t321 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  ret { %Diagnostic*, i64 }* %t321
}

define %Statement* @resolve_interface_annotation(%TypeAnnotation %annotation, { %Statement*, i64 }* %interfaces) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i64
  %l2 = alloca %Statement
  %l3 = alloca i8*
  %l4 = alloca i8*
  %t0 = extractvalue %TypeAnnotation %annotation, 0
  store i8* %t0, i8** %l0
  %t1 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %interfaces, i32 0, i32 1
  %t2 = load i64, i64* %t1
  %t3 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %interfaces, i32 0, i32 0
  %t4 = load %Statement*, %Statement** %t3
  store i64 0, i64* %l1
  store %Statement zeroinitializer, %Statement* %l2
  br label %for0
for0:
  %t5 = load i64, i64* %l1
  %t6 = icmp slt i64 %t5, %t2
  br i1 %t6, label %forbody1, label %afterfor3
forbody1:
  %t7 = load i64, i64* %l1
  %t8 = getelementptr %Statement, %Statement* %t4, i64 %t7
  %t9 = load %Statement, %Statement* %t8
  store %Statement %t9, %Statement* %l2
  %t10 = load %Statement, %Statement* %l2
  %t11 = extractvalue %Statement %t10, 0
  %t12 = alloca %Statement
  store %Statement %t10, %Statement* %t12
  %t13 = getelementptr inbounds %Statement, %Statement* %t12, i32 0, i32 1
  %t14 = bitcast [48 x i8]* %t13 to i8*
  %t15 = bitcast i8* %t14 to i8**
  %t16 = load i8*, i8** %t15
  %t17 = icmp eq i32 %t11, 2
  %t18 = select i1 %t17, i8* %t16, i8* null
  %t19 = getelementptr inbounds %Statement, %Statement* %t12, i32 0, i32 1
  %t20 = bitcast [48 x i8]* %t19 to i8*
  %t21 = bitcast i8* %t20 to i8**
  %t22 = load i8*, i8** %t21
  %t23 = icmp eq i32 %t11, 3
  %t24 = select i1 %t23, i8* %t22, i8* %t18
  %t25 = getelementptr inbounds %Statement, %Statement* %t12, i32 0, i32 1
  %t26 = bitcast [40 x i8]* %t25 to i8*
  %t27 = bitcast i8* %t26 to i8**
  %t28 = load i8*, i8** %t27
  %t29 = icmp eq i32 %t11, 6
  %t30 = select i1 %t29, i8* %t28, i8* %t24
  %t31 = getelementptr inbounds %Statement, %Statement* %t12, i32 0, i32 1
  %t32 = bitcast [56 x i8]* %t31 to i8*
  %t33 = bitcast i8* %t32 to i8**
  %t34 = load i8*, i8** %t33
  %t35 = icmp eq i32 %t11, 8
  %t36 = select i1 %t35, i8* %t34, i8* %t30
  %t37 = getelementptr inbounds %Statement, %Statement* %t12, i32 0, i32 1
  %t38 = bitcast [40 x i8]* %t37 to i8*
  %t39 = bitcast i8* %t38 to i8**
  %t40 = load i8*, i8** %t39
  %t41 = icmp eq i32 %t11, 9
  %t42 = select i1 %t41, i8* %t40, i8* %t36
  %t43 = getelementptr inbounds %Statement, %Statement* %t12, i32 0, i32 1
  %t44 = bitcast [40 x i8]* %t43 to i8*
  %t45 = bitcast i8* %t44 to i8**
  %t46 = load i8*, i8** %t45
  %t47 = icmp eq i32 %t11, 10
  %t48 = select i1 %t47, i8* %t46, i8* %t42
  %t49 = getelementptr inbounds %Statement, %Statement* %t12, i32 0, i32 1
  %t50 = bitcast [40 x i8]* %t49 to i8*
  %t51 = bitcast i8* %t50 to i8**
  %t52 = load i8*, i8** %t51
  %t53 = icmp eq i32 %t11, 11
  %t54 = select i1 %t53, i8* %t52, i8* %t48
  store i8* %t54, i8** %l3
  %t55 = load i8*, i8** %l0
  %t56 = load i8*, i8** %l3
  %t57 = call i1 @strings_equal(i8* %t55, i8* %t56)
  %t58 = load i8*, i8** %l0
  %t59 = load %Statement, %Statement* %l2
  %t60 = load i8*, i8** %l3
  br i1 %t57, label %then4, label %merge5
then4:
  %t61 = load %Statement, %Statement* %l2
  %t62 = alloca %Statement
  store %Statement %t61, %Statement* %t62
  ret %Statement* %t62
merge5:
  %t63 = load i8*, i8** %l3
  %t64 = alloca [2 x i8], align 1
  %t65 = getelementptr [2 x i8], [2 x i8]* %t64, i32 0, i32 0
  store i8 60, i8* %t65
  %t66 = getelementptr [2 x i8], [2 x i8]* %t64, i32 0, i32 1
  store i8 0, i8* %t66
  %t67 = getelementptr [2 x i8], [2 x i8]* %t64, i32 0, i32 0
  %t68 = call i8* @sailfin_runtime_string_concat(i8* %t63, i8* %t67)
  store i8* %t68, i8** %l4
  %t69 = load i8*, i8** %l0
  %t70 = load i8*, i8** %l4
  %t71 = call i1 @starts_with(i8* %t69, i8* %t70)
  %t72 = load i8*, i8** %l0
  %t73 = load %Statement, %Statement* %l2
  %t74 = load i8*, i8** %l3
  %t75 = load i8*, i8** %l4
  br i1 %t71, label %then6, label %merge7
then6:
  %t76 = load %Statement, %Statement* %l2
  %t77 = alloca %Statement
  store %Statement %t76, %Statement* %t77
  ret %Statement* %t77
merge7:
  br label %forinc2
forinc2:
  %t78 = load i64, i64* %l1
  %t79 = add i64 %t78, 1
  store i64 %t79, i64* %l1
  br label %for0
afterfor3:
  %t80 = bitcast i8* null to %Statement*
  ret %Statement* %t80
}

define { %Diagnostic*, i64 }* @check_struct_fields({ %FieldDeclaration*, i64 }* %fields) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %FieldDeclaration
  %l4 = alloca i8*
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
  %t12 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t13 = ptrtoint [0 x %Diagnostic]* %t12 to i64
  %t14 = icmp eq i64 %t13, 0
  %t15 = select i1 %t14, i64 1, i64 %t13
  %t16 = call i8* @malloc(i64 %t15)
  %t17 = bitcast i8* %t16 to %Diagnostic*
  %t18 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t19 = ptrtoint { %Diagnostic*, i64 }* %t18 to i64
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to { %Diagnostic*, i64 }*
  %t22 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t21, i32 0, i32 0
  store %Diagnostic* %t17, %Diagnostic** %t22
  %t23 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t21, i32 0, i32 1
  store i64 0, i64* %t23
  store { %Diagnostic*, i64 }* %t21, { %Diagnostic*, i64 }** %l1
  %t24 = getelementptr { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %fields, i32 0, i32 1
  %t25 = load i64, i64* %t24
  %t26 = getelementptr { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %fields, i32 0, i32 0
  %t27 = load %FieldDeclaration*, %FieldDeclaration** %t26
  store i64 0, i64* %l2
  store %FieldDeclaration zeroinitializer, %FieldDeclaration* %l3
  br label %for0
for0:
  %t28 = load i64, i64* %l2
  %t29 = icmp slt i64 %t28, %t25
  br i1 %t29, label %forbody1, label %afterfor3
forbody1:
  %t30 = load i64, i64* %l2
  %t31 = getelementptr %FieldDeclaration, %FieldDeclaration* %t27, i64 %t30
  %t32 = load %FieldDeclaration, %FieldDeclaration* %t31
  store %FieldDeclaration %t32, %FieldDeclaration* %l3
  %t33 = load %FieldDeclaration, %FieldDeclaration* %l3
  %t34 = extractvalue %FieldDeclaration %t33, 0
  store i8* %t34, i8** %l4
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load i8*, i8** %l4
  %t37 = call i1 @contains_string({ i8**, i64 }* %t35, i8* %t36)
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t40 = load %FieldDeclaration, %FieldDeclaration* %l3
  %t41 = load i8*, i8** %l4
  br i1 %t37, label %then4, label %else5
then4:
  %t42 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t43 = load i8*, i8** %l4
  %s44 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h766506979, i32 0, i32 0
  %t45 = load i8*, i8** %l4
  %t46 = load %FieldDeclaration, %FieldDeclaration* %l3
  %t47 = extractvalue %FieldDeclaration %t46, 3
  %t48 = call %Token* @token_from_name(i8* %t45, %SourceSpan* %t47)
  %t49 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t43, i8* %s44, %Token* %t48)
  %t50 = call noalias i8* @malloc(i64 24)
  %t51 = bitcast i8* %t50 to %Diagnostic*
  store %Diagnostic %t49, %Diagnostic* %t51
  %t52 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t53 = ptrtoint [1 x i8*]* %t52 to i64
  %t54 = icmp eq i64 %t53, 0
  %t55 = select i1 %t54, i64 1, i64 %t53
  %t56 = call i8* @malloc(i64 %t55)
  %t57 = bitcast i8* %t56 to i8**
  %t58 = getelementptr i8*, i8** %t57, i64 0
  store i8* %t50, i8** %t58
  %t59 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t60 = ptrtoint { i8**, i64 }* %t59 to i64
  %t61 = call i8* @malloc(i64 %t60)
  %t62 = bitcast i8* %t61 to { i8**, i64 }*
  %t63 = getelementptr { i8**, i64 }, { i8**, i64 }* %t62, i32 0, i32 0
  store i8** %t57, i8*** %t63
  %t64 = getelementptr { i8**, i64 }, { i8**, i64 }* %t62, i32 0, i32 1
  store i64 1, i64* %t64
  %t65 = bitcast { %Diagnostic*, i64 }* %t42 to { i8**, i64 }*
  %t66 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t65, { i8**, i64 }* %t62)
  %t67 = bitcast { i8**, i64 }* %t66 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t67, { %Diagnostic*, i64 }** %l1
  %t68 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load i8*, i8** %l4
  %t71 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t72 = ptrtoint [1 x i8*]* %t71 to i64
  %t73 = icmp eq i64 %t72, 0
  %t74 = select i1 %t73, i64 1, i64 %t72
  %t75 = call i8* @malloc(i64 %t74)
  %t76 = bitcast i8* %t75 to i8**
  %t77 = getelementptr i8*, i8** %t76, i64 0
  store i8* %t70, i8** %t77
  %t78 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t79 = ptrtoint { i8**, i64 }* %t78 to i64
  %t80 = call i8* @malloc(i64 %t79)
  %t81 = bitcast i8* %t80 to { i8**, i64 }*
  %t82 = getelementptr { i8**, i64 }, { i8**, i64 }* %t81, i32 0, i32 0
  store i8** %t76, i8*** %t82
  %t83 = getelementptr { i8**, i64 }, { i8**, i64 }* %t81, i32 0, i32 1
  store i64 1, i64* %t83
  %t84 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t69, { i8**, i64 }* %t81)
  store { i8**, i64 }* %t84, { i8**, i64 }** %l0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t86 = phi { %Diagnostic*, i64 }* [ %t68, %then4 ], [ %t39, %else5 ]
  %t87 = phi { i8**, i64 }* [ %t38, %then4 ], [ %t85, %else5 ]
  store { %Diagnostic*, i64 }* %t86, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t87, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t88 = load i64, i64* %l2
  %t89 = add i64 %t88, 1
  store i64 %t89, i64* %l2
  br label %for0
afterfor3:
  %t90 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t92 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t92
}

define { %Diagnostic*, i64 }* @validate_interface_annotation(i8* %struct_name, %Statement %interface_definition, %TypeAnnotation %annotation) {
block.entry:
  %l0 = alloca i64
  %l1 = alloca { i8**, i64 }*
  %t0 = extractvalue %Statement %interface_definition, 0
  %t1 = alloca %Statement
  store %Statement %interface_definition, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [56 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 16
  %t5 = bitcast i8* %t4 to { %TypeParameter**, i64 }**
  %t6 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 8
  %t8 = select i1 %t7, { %TypeParameter**, i64 }* %t6, { %TypeParameter**, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [40 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { %TypeParameter**, i64 }**
  %t13 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 9
  %t15 = select i1 %t14, { %TypeParameter**, i64 }* %t13, { %TypeParameter**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [40 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { %TypeParameter**, i64 }**
  %t20 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 10
  %t22 = select i1 %t21, { %TypeParameter**, i64 }* %t20, { %TypeParameter**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 16
  %t26 = bitcast i8* %t25 to { %TypeParameter**, i64 }**
  %t27 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 11
  %t29 = select i1 %t28, { %TypeParameter**, i64 }* %t27, { %TypeParameter**, i64 }* %t22
  %t30 = load { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t29
  %t31 = extractvalue { %TypeParameter**, i64 } %t30, 1
  store i64 %t31, i64* %l0
  %t32 = extractvalue %TypeAnnotation %annotation, 0
  %t33 = call { i8**, i64 }* @parse_type_arguments(i8* %t32)
  store { i8**, i64 }* %t33, { i8**, i64 }** %l1
  %t34 = load i64, i64* %l0
  %t35 = icmp eq i64 %t34, 0
  %t36 = load i64, i64* %l0
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t35, label %then0, label %merge1
then0:
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = load { i8**, i64 }, { i8**, i64 }* %t38
  %t40 = extractvalue { i8**, i64 } %t39, 1
  %t41 = icmp sgt i64 %t40, 0
  %t42 = load i64, i64* %l0
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t41, label %then2, label %merge3
then2:
  %t44 = extractvalue %TypeAnnotation %annotation, 0
  %t45 = call i8* @trim_text(i8* %t44)
  %t46 = extractvalue %Statement %interface_definition, 0
  %t47 = alloca %Statement
  store %Statement %interface_definition, %Statement* %t47
  %t48 = getelementptr inbounds %Statement, %Statement* %t47, i32 0, i32 1
  %t49 = bitcast [48 x i8]* %t48 to i8*
  %t50 = bitcast i8* %t49 to i8**
  %t51 = load i8*, i8** %t50
  %t52 = icmp eq i32 %t46, 2
  %t53 = select i1 %t52, i8* %t51, i8* null
  %t54 = getelementptr inbounds %Statement, %Statement* %t47, i32 0, i32 1
  %t55 = bitcast [48 x i8]* %t54 to i8*
  %t56 = bitcast i8* %t55 to i8**
  %t57 = load i8*, i8** %t56
  %t58 = icmp eq i32 %t46, 3
  %t59 = select i1 %t58, i8* %t57, i8* %t53
  %t60 = getelementptr inbounds %Statement, %Statement* %t47, i32 0, i32 1
  %t61 = bitcast [40 x i8]* %t60 to i8*
  %t62 = bitcast i8* %t61 to i8**
  %t63 = load i8*, i8** %t62
  %t64 = icmp eq i32 %t46, 6
  %t65 = select i1 %t64, i8* %t63, i8* %t59
  %t66 = getelementptr inbounds %Statement, %Statement* %t47, i32 0, i32 1
  %t67 = bitcast [56 x i8]* %t66 to i8*
  %t68 = bitcast i8* %t67 to i8**
  %t69 = load i8*, i8** %t68
  %t70 = icmp eq i32 %t46, 8
  %t71 = select i1 %t70, i8* %t69, i8* %t65
  %t72 = getelementptr inbounds %Statement, %Statement* %t47, i32 0, i32 1
  %t73 = bitcast [40 x i8]* %t72 to i8*
  %t74 = bitcast i8* %t73 to i8**
  %t75 = load i8*, i8** %t74
  %t76 = icmp eq i32 %t46, 9
  %t77 = select i1 %t76, i8* %t75, i8* %t71
  %t78 = getelementptr inbounds %Statement, %Statement* %t47, i32 0, i32 1
  %t79 = bitcast [40 x i8]* %t78 to i8*
  %t80 = bitcast i8* %t79 to i8**
  %t81 = load i8*, i8** %t80
  %t82 = icmp eq i32 %t46, 10
  %t83 = select i1 %t82, i8* %t81, i8* %t77
  %t84 = getelementptr inbounds %Statement, %Statement* %t47, i32 0, i32 1
  %t85 = bitcast [40 x i8]* %t84 to i8*
  %t86 = bitcast i8* %t85 to i8**
  %t87 = load i8*, i8** %t86
  %t88 = icmp eq i32 %t46, 11
  %t89 = select i1 %t88, i8* %t87, i8* %t83
  %t90 = call %Diagnostic @make_interface_no_type_arguments_diagnostic(i8* %struct_name, i8* %t45, i8* %t89)
  %t91 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 1
  %t92 = ptrtoint [1 x %Diagnostic]* %t91 to i64
  %t93 = icmp eq i64 %t92, 0
  %t94 = select i1 %t93, i64 1, i64 %t92
  %t95 = call i8* @malloc(i64 %t94)
  %t96 = bitcast i8* %t95 to %Diagnostic*
  %t97 = getelementptr %Diagnostic, %Diagnostic* %t96, i64 0
  store %Diagnostic %t90, %Diagnostic* %t97
  %t98 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t99 = ptrtoint { %Diagnostic*, i64 }* %t98 to i64
  %t100 = call i8* @malloc(i64 %t99)
  %t101 = bitcast i8* %t100 to { %Diagnostic*, i64 }*
  %t102 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t101, i32 0, i32 0
  store %Diagnostic* %t96, %Diagnostic** %t102
  %t103 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t101, i32 0, i32 1
  store i64 1, i64* %t103
  ret { %Diagnostic*, i64 }* %t101
merge3:
  %t104 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t105 = ptrtoint [0 x %Diagnostic]* %t104 to i64
  %t106 = icmp eq i64 %t105, 0
  %t107 = select i1 %t106, i64 1, i64 %t105
  %t108 = call i8* @malloc(i64 %t107)
  %t109 = bitcast i8* %t108 to %Diagnostic*
  %t110 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t111 = ptrtoint { %Diagnostic*, i64 }* %t110 to i64
  %t112 = call i8* @malloc(i64 %t111)
  %t113 = bitcast i8* %t112 to { %Diagnostic*, i64 }*
  %t114 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t113, i32 0, i32 0
  store %Diagnostic* %t109, %Diagnostic** %t114
  %t115 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t113, i32 0, i32 1
  store i64 0, i64* %t115
  ret { %Diagnostic*, i64 }* %t113
merge1:
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t117 = load { i8**, i64 }, { i8**, i64 }* %t116
  %t118 = extractvalue { i8**, i64 } %t117, 1
  %t119 = icmp eq i64 %t118, 0
  %t120 = load i64, i64* %l0
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t119, label %then4, label %merge5
then4:
  %t122 = extractvalue %Statement %interface_definition, 0
  %t123 = alloca %Statement
  store %Statement %interface_definition, %Statement* %t123
  %t124 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t125 = bitcast [48 x i8]* %t124 to i8*
  %t126 = bitcast i8* %t125 to i8**
  %t127 = load i8*, i8** %t126
  %t128 = icmp eq i32 %t122, 2
  %t129 = select i1 %t128, i8* %t127, i8* null
  %t130 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t131 = bitcast [48 x i8]* %t130 to i8*
  %t132 = bitcast i8* %t131 to i8**
  %t133 = load i8*, i8** %t132
  %t134 = icmp eq i32 %t122, 3
  %t135 = select i1 %t134, i8* %t133, i8* %t129
  %t136 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t137 = bitcast [40 x i8]* %t136 to i8*
  %t138 = bitcast i8* %t137 to i8**
  %t139 = load i8*, i8** %t138
  %t140 = icmp eq i32 %t122, 6
  %t141 = select i1 %t140, i8* %t139, i8* %t135
  %t142 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t143 = bitcast [56 x i8]* %t142 to i8*
  %t144 = bitcast i8* %t143 to i8**
  %t145 = load i8*, i8** %t144
  %t146 = icmp eq i32 %t122, 8
  %t147 = select i1 %t146, i8* %t145, i8* %t141
  %t148 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t149 = bitcast [40 x i8]* %t148 to i8*
  %t150 = bitcast i8* %t149 to i8**
  %t151 = load i8*, i8** %t150
  %t152 = icmp eq i32 %t122, 9
  %t153 = select i1 %t152, i8* %t151, i8* %t147
  %t154 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t155 = bitcast [40 x i8]* %t154 to i8*
  %t156 = bitcast i8* %t155 to i8**
  %t157 = load i8*, i8** %t156
  %t158 = icmp eq i32 %t122, 10
  %t159 = select i1 %t158, i8* %t157, i8* %t153
  %t160 = getelementptr inbounds %Statement, %Statement* %t123, i32 0, i32 1
  %t161 = bitcast [40 x i8]* %t160 to i8*
  %t162 = bitcast i8* %t161 to i8**
  %t163 = load i8*, i8** %t162
  %t164 = icmp eq i32 %t122, 11
  %t165 = select i1 %t164, i8* %t163, i8* %t159
  %t166 = call i8* @format_interface_signature(%Statement %interface_definition)
  %t167 = call %Diagnostic @make_interface_missing_type_arguments_diagnostic(i8* %struct_name, i8* %t165, i8* %t166)
  %t168 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 1
  %t169 = ptrtoint [1 x %Diagnostic]* %t168 to i64
  %t170 = icmp eq i64 %t169, 0
  %t171 = select i1 %t170, i64 1, i64 %t169
  %t172 = call i8* @malloc(i64 %t171)
  %t173 = bitcast i8* %t172 to %Diagnostic*
  %t174 = getelementptr %Diagnostic, %Diagnostic* %t173, i64 0
  store %Diagnostic %t167, %Diagnostic* %t174
  %t175 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t176 = ptrtoint { %Diagnostic*, i64 }* %t175 to i64
  %t177 = call i8* @malloc(i64 %t176)
  %t178 = bitcast i8* %t177 to { %Diagnostic*, i64 }*
  %t179 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t178, i32 0, i32 0
  store %Diagnostic* %t173, %Diagnostic** %t179
  %t180 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t178, i32 0, i32 1
  store i64 1, i64* %t180
  ret { %Diagnostic*, i64 }* %t178
merge5:
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t182 = load { i8**, i64 }, { i8**, i64 }* %t181
  %t183 = extractvalue { i8**, i64 } %t182, 1
  %t184 = load i64, i64* %l0
  %t185 = icmp ne i64 %t183, %t184
  %t186 = load i64, i64* %l0
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t185, label %then6, label %merge7
then6:
  %t188 = extractvalue %TypeAnnotation %annotation, 0
  %t189 = call i8* @trim_text(i8* %t188)
  %t190 = call i8* @format_interface_signature(%Statement %interface_definition)
  %t191 = call %Diagnostic @make_interface_type_argument_mismatch_diagnostic(i8* %struct_name, i8* %t189, i8* %t190)
  %t192 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 1
  %t193 = ptrtoint [1 x %Diagnostic]* %t192 to i64
  %t194 = icmp eq i64 %t193, 0
  %t195 = select i1 %t194, i64 1, i64 %t193
  %t196 = call i8* @malloc(i64 %t195)
  %t197 = bitcast i8* %t196 to %Diagnostic*
  %t198 = getelementptr %Diagnostic, %Diagnostic* %t197, i64 0
  store %Diagnostic %t191, %Diagnostic* %t198
  %t199 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t200 = ptrtoint { %Diagnostic*, i64 }* %t199 to i64
  %t201 = call i8* @malloc(i64 %t200)
  %t202 = bitcast i8* %t201 to { %Diagnostic*, i64 }*
  %t203 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t202, i32 0, i32 0
  store %Diagnostic* %t197, %Diagnostic** %t203
  %t204 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t202, i32 0, i32 1
  store i64 1, i64* %t204
  ret { %Diagnostic*, i64 }* %t202
merge7:
  %t205 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t206 = ptrtoint [0 x %Diagnostic]* %t205 to i64
  %t207 = icmp eq i64 %t206, 0
  %t208 = select i1 %t207, i64 1, i64 %t206
  %t209 = call i8* @malloc(i64 %t208)
  %t210 = bitcast i8* %t209 to %Diagnostic*
  %t211 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t212 = ptrtoint { %Diagnostic*, i64 }* %t211 to i64
  %t213 = call i8* @malloc(i64 %t212)
  %t214 = bitcast i8* %t213 to { %Diagnostic*, i64 }*
  %t215 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t214, i32 0, i32 0
  store %Diagnostic* %t210, %Diagnostic** %t215
  %t216 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t214, i32 0, i32 1
  store i64 0, i64* %t216
  ret { %Diagnostic*, i64 }* %t214
}

define i8* @format_interface_signature(%Statement %interface_definition) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i64
  %l2 = alloca %TypeParameter*
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
  %t12 = extractvalue %Statement %interface_definition, 0
  %t13 = alloca %Statement
  store %Statement %interface_definition, %Statement* %t13
  %t14 = getelementptr inbounds %Statement, %Statement* %t13, i32 0, i32 1
  %t15 = bitcast [56 x i8]* %t14 to i8*
  %t16 = getelementptr inbounds i8, i8* %t15, i64 16
  %t17 = bitcast i8* %t16 to { %TypeParameter**, i64 }**
  %t18 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t17
  %t19 = icmp eq i32 %t12, 8
  %t20 = select i1 %t19, { %TypeParameter**, i64 }* %t18, { %TypeParameter**, i64 }* null
  %t21 = getelementptr inbounds %Statement, %Statement* %t13, i32 0, i32 1
  %t22 = bitcast [40 x i8]* %t21 to i8*
  %t23 = getelementptr inbounds i8, i8* %t22, i64 16
  %t24 = bitcast i8* %t23 to { %TypeParameter**, i64 }**
  %t25 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t24
  %t26 = icmp eq i32 %t12, 9
  %t27 = select i1 %t26, { %TypeParameter**, i64 }* %t25, { %TypeParameter**, i64 }* %t20
  %t28 = getelementptr inbounds %Statement, %Statement* %t13, i32 0, i32 1
  %t29 = bitcast [40 x i8]* %t28 to i8*
  %t30 = getelementptr inbounds i8, i8* %t29, i64 16
  %t31 = bitcast i8* %t30 to { %TypeParameter**, i64 }**
  %t32 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t31
  %t33 = icmp eq i32 %t12, 10
  %t34 = select i1 %t33, { %TypeParameter**, i64 }* %t32, { %TypeParameter**, i64 }* %t27
  %t35 = getelementptr inbounds %Statement, %Statement* %t13, i32 0, i32 1
  %t36 = bitcast [40 x i8]* %t35 to i8*
  %t37 = getelementptr inbounds i8, i8* %t36, i64 16
  %t38 = bitcast i8* %t37 to { %TypeParameter**, i64 }**
  %t39 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t38
  %t40 = icmp eq i32 %t12, 11
  %t41 = select i1 %t40, { %TypeParameter**, i64 }* %t39, { %TypeParameter**, i64 }* %t34
  %t42 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t41, i32 0, i32 1
  %t43 = load i64, i64* %t42
  %t44 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t41, i32 0, i32 0
  %t45 = load %TypeParameter**, %TypeParameter*** %t44
  store i64 0, i64* %l1
  store %TypeParameter* null, %TypeParameter** %l2
  br label %for0
for0:
  %t46 = load i64, i64* %l1
  %t47 = icmp slt i64 %t46, %t43
  br i1 %t47, label %forbody1, label %afterfor3
forbody1:
  %t48 = load i64, i64* %l1
  %t49 = getelementptr %TypeParameter*, %TypeParameter** %t45, i64 %t48
  %t50 = load %TypeParameter*, %TypeParameter** %t49
  store %TypeParameter* %t50, %TypeParameter** %l2
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load %TypeParameter*, %TypeParameter** %l2
  %t53 = getelementptr %TypeParameter, %TypeParameter* %t52, i32 0, i32 0
  %t54 = load i8*, i8** %t53
  %t55 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t56 = ptrtoint [1 x i8*]* %t55 to i64
  %t57 = icmp eq i64 %t56, 0
  %t58 = select i1 %t57, i64 1, i64 %t56
  %t59 = call i8* @malloc(i64 %t58)
  %t60 = bitcast i8* %t59 to i8**
  %t61 = getelementptr i8*, i8** %t60, i64 0
  store i8* %t54, i8** %t61
  %t62 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t63 = ptrtoint { i8**, i64 }* %t62 to i64
  %t64 = call i8* @malloc(i64 %t63)
  %t65 = bitcast i8* %t64 to { i8**, i64 }*
  %t66 = getelementptr { i8**, i64 }, { i8**, i64 }* %t65, i32 0, i32 0
  store i8** %t60, i8*** %t66
  %t67 = getelementptr { i8**, i64 }, { i8**, i64 }* %t65, i32 0, i32 1
  store i64 1, i64* %t67
  %t68 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t51, { i8**, i64 }* %t65)
  store { i8**, i64 }* %t68, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t69 = load i64, i64* %l1
  %t70 = add i64 %t69, 1
  store i64 %t70, i64* %l1
  br label %for0
afterfor3:
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t73 = load { i8**, i64 }, { i8**, i64 }* %t72
  %t74 = extractvalue { i8**, i64 } %t73, 1
  %t75 = icmp eq i64 %t74, 0
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br i1 %t75, label %then4, label %merge5
then4:
  %t77 = extractvalue %Statement %interface_definition, 0
  %t78 = alloca %Statement
  store %Statement %interface_definition, %Statement* %t78
  %t79 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t80 = bitcast [48 x i8]* %t79 to i8*
  %t81 = bitcast i8* %t80 to i8**
  %t82 = load i8*, i8** %t81
  %t83 = icmp eq i32 %t77, 2
  %t84 = select i1 %t83, i8* %t82, i8* null
  %t85 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t86 = bitcast [48 x i8]* %t85 to i8*
  %t87 = bitcast i8* %t86 to i8**
  %t88 = load i8*, i8** %t87
  %t89 = icmp eq i32 %t77, 3
  %t90 = select i1 %t89, i8* %t88, i8* %t84
  %t91 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t92 = bitcast [40 x i8]* %t91 to i8*
  %t93 = bitcast i8* %t92 to i8**
  %t94 = load i8*, i8** %t93
  %t95 = icmp eq i32 %t77, 6
  %t96 = select i1 %t95, i8* %t94, i8* %t90
  %t97 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t98 = bitcast [56 x i8]* %t97 to i8*
  %t99 = bitcast i8* %t98 to i8**
  %t100 = load i8*, i8** %t99
  %t101 = icmp eq i32 %t77, 8
  %t102 = select i1 %t101, i8* %t100, i8* %t96
  %t103 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t104 = bitcast [40 x i8]* %t103 to i8*
  %t105 = bitcast i8* %t104 to i8**
  %t106 = load i8*, i8** %t105
  %t107 = icmp eq i32 %t77, 9
  %t108 = select i1 %t107, i8* %t106, i8* %t102
  %t109 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t110 = bitcast [40 x i8]* %t109 to i8*
  %t111 = bitcast i8* %t110 to i8**
  %t112 = load i8*, i8** %t111
  %t113 = icmp eq i32 %t77, 10
  %t114 = select i1 %t113, i8* %t112, i8* %t108
  %t115 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t116 = bitcast [40 x i8]* %t115 to i8*
  %t117 = bitcast i8* %t116 to i8**
  %t118 = load i8*, i8** %t117
  %t119 = icmp eq i32 %t77, 11
  %t120 = select i1 %t119, i8* %t118, i8* %t114
  call void @sailfin_runtime_mark_persistent(i8* %t120)
  ret i8* %t120
merge5:
  %t121 = extractvalue %Statement %interface_definition, 0
  %t122 = alloca %Statement
  store %Statement %interface_definition, %Statement* %t122
  %t123 = getelementptr inbounds %Statement, %Statement* %t122, i32 0, i32 1
  %t124 = bitcast [48 x i8]* %t123 to i8*
  %t125 = bitcast i8* %t124 to i8**
  %t126 = load i8*, i8** %t125
  %t127 = icmp eq i32 %t121, 2
  %t128 = select i1 %t127, i8* %t126, i8* null
  %t129 = getelementptr inbounds %Statement, %Statement* %t122, i32 0, i32 1
  %t130 = bitcast [48 x i8]* %t129 to i8*
  %t131 = bitcast i8* %t130 to i8**
  %t132 = load i8*, i8** %t131
  %t133 = icmp eq i32 %t121, 3
  %t134 = select i1 %t133, i8* %t132, i8* %t128
  %t135 = getelementptr inbounds %Statement, %Statement* %t122, i32 0, i32 1
  %t136 = bitcast [40 x i8]* %t135 to i8*
  %t137 = bitcast i8* %t136 to i8**
  %t138 = load i8*, i8** %t137
  %t139 = icmp eq i32 %t121, 6
  %t140 = select i1 %t139, i8* %t138, i8* %t134
  %t141 = getelementptr inbounds %Statement, %Statement* %t122, i32 0, i32 1
  %t142 = bitcast [56 x i8]* %t141 to i8*
  %t143 = bitcast i8* %t142 to i8**
  %t144 = load i8*, i8** %t143
  %t145 = icmp eq i32 %t121, 8
  %t146 = select i1 %t145, i8* %t144, i8* %t140
  %t147 = getelementptr inbounds %Statement, %Statement* %t122, i32 0, i32 1
  %t148 = bitcast [40 x i8]* %t147 to i8*
  %t149 = bitcast i8* %t148 to i8**
  %t150 = load i8*, i8** %t149
  %t151 = icmp eq i32 %t121, 9
  %t152 = select i1 %t151, i8* %t150, i8* %t146
  %t153 = getelementptr inbounds %Statement, %Statement* %t122, i32 0, i32 1
  %t154 = bitcast [40 x i8]* %t153 to i8*
  %t155 = bitcast i8* %t154 to i8**
  %t156 = load i8*, i8** %t155
  %t157 = icmp eq i32 %t121, 10
  %t158 = select i1 %t157, i8* %t156, i8* %t152
  %t159 = getelementptr inbounds %Statement, %Statement* %t122, i32 0, i32 1
  %t160 = bitcast [40 x i8]* %t159 to i8*
  %t161 = bitcast i8* %t160 to i8**
  %t162 = load i8*, i8** %t161
  %t163 = icmp eq i32 %t121, 11
  %t164 = select i1 %t163, i8* %t162, i8* %t158
  %t165 = alloca [2 x i8], align 1
  %t166 = getelementptr [2 x i8], [2 x i8]* %t165, i32 0, i32 0
  store i8 60, i8* %t166
  %t167 = getelementptr [2 x i8], [2 x i8]* %t165, i32 0, i32 1
  store i8 0, i8* %t167
  %t168 = getelementptr [2 x i8], [2 x i8]* %t165, i32 0, i32 0
  %t169 = call i8* @sailfin_runtime_string_concat(i8* %t164, i8* %t168)
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s171 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t172 = call i8* @join_with_separator({ i8**, i64 }* %t170, i8* %s171)
  %t173 = call i8* @sailfin_runtime_string_concat(i8* %t169, i8* %t172)
  %t174 = alloca [2 x i8], align 1
  %t175 = getelementptr [2 x i8], [2 x i8]* %t174, i32 0, i32 0
  store i8 62, i8* %t175
  %t176 = getelementptr [2 x i8], [2 x i8]* %t174, i32 0, i32 1
  store i8 0, i8* %t176
  %t177 = getelementptr [2 x i8], [2 x i8]* %t174, i32 0, i32 0
  %t178 = call i8* @sailfin_runtime_string_concat(i8* %t173, i8* %t177)
  call void @sailfin_runtime_mark_persistent(i8* %t178)
  ret i8* %t178
}

define i8* @join_with_separator({ i8**, i64 }* %items, i8* %separator) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %t0 = load { i8**, i64 }, { i8**, i64 }* %items
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s3)
  ret i8* %s3
merge1:
  %t4 = load { i8**, i64 }, { i8**, i64 }* %items
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
  %t14 = load { i8**, i64 }, { i8**, i64 }* %items
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
  %t25 = load { i8**, i64 }, { i8**, i64 }* %items
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

define { i8**, i64 }* @parse_type_arguments(i8* %annotation_text) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i8* @extract_generic_argument_block(i8* %annotation_text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = icmp eq i8* %t1, null
  %t3 = load i8*, i8** %l0
  br i1 %t2, label %then0, label %merge1
then0:
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
  ret { i8**, i64 }* %t13
merge1:
  %t16 = load i8*, i8** %l0
  %t17 = call { i8**, i64 }* @split_generic_argument_list(i8* %t16)
  ret { i8**, i64 }* %t17
}

define i8* @extract_generic_argument_block(i8* %annotation_text) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8
  %t0 = call i8* @trim_text(i8* %annotation_text)
  store i8* %t0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l2
  %t3 = sitofp i64 -1 to double
  store double %t3, double* %l3
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  %t6 = load double, double* %l2
  %t7 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t89 = phi double [ %t7, %block.entry ], [ %t86, %loop.latch2 ]
  %t90 = phi double [ %t6, %block.entry ], [ %t87, %loop.latch2 ]
  %t91 = phi double [ %t5, %block.entry ], [ %t88, %loop.latch2 ]
  store double %t89, double* %l3
  store double %t90, double* %l2
  store double %t91, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load i8*, i8** %l0
  %t10 = call i64 @sailfin_runtime_string_length(i8* %t9)
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load i8*, i8** %l0
  %t14 = load double, double* %l1
  %t15 = load double, double* %l2
  %t16 = load double, double* %l3
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t17 = load i8*, i8** %l0
  %t18 = load double, double* %l1
  %t19 = call double @llvm.round.f64(double %t18)
  %t20 = fptosi double %t19 to i64
  %t21 = getelementptr i8, i8* %t17, i64 %t20
  %t22 = load i8, i8* %t21
  store i8 %t22, i8* %l4
  %t23 = load i8, i8* %l4
  %t24 = icmp eq i8 %t23, 60
  %t25 = load i8*, i8** %l0
  %t26 = load double, double* %l1
  %t27 = load double, double* %l2
  %t28 = load double, double* %l3
  %t29 = load i8, i8* %l4
  br i1 %t24, label %then6, label %else7
then6:
  %t30 = load double, double* %l2
  %t31 = sitofp i64 0 to double
  %t32 = fcmp oeq double %t30, %t31
  %t33 = load i8*, i8** %l0
  %t34 = load double, double* %l1
  %t35 = load double, double* %l2
  %t36 = load double, double* %l3
  %t37 = load i8, i8* %l4
  br i1 %t32, label %then9, label %merge10
then9:
  %t38 = load double, double* %l1
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l3
  %t41 = load double, double* %l3
  br label %merge10
merge10:
  %t42 = phi double [ %t41, %then9 ], [ %t36, %then6 ]
  store double %t42, double* %l3
  %t43 = load double, double* %l2
  %t44 = sitofp i64 1 to double
  %t45 = fadd double %t43, %t44
  store double %t45, double* %l2
  %t46 = load double, double* %l3
  %t47 = load double, double* %l2
  br label %merge8
else7:
  %t48 = load i8, i8* %l4
  %t49 = icmp eq i8 %t48, 62
  %t50 = load i8*, i8** %l0
  %t51 = load double, double* %l1
  %t52 = load double, double* %l2
  %t53 = load double, double* %l3
  %t54 = load i8, i8* %l4
  br i1 %t49, label %then11, label %merge12
then11:
  %t55 = load double, double* %l2
  %t56 = sitofp i64 0 to double
  %t57 = fcmp oeq double %t55, %t56
  %t58 = load i8*, i8** %l0
  %t59 = load double, double* %l1
  %t60 = load double, double* %l2
  %t61 = load double, double* %l3
  %t62 = load i8, i8* %l4
  br i1 %t57, label %then13, label %merge14
then13:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge14:
  %t63 = load double, double* %l2
  %t64 = sitofp i64 1 to double
  %t65 = fsub double %t63, %t64
  store double %t65, double* %l2
  %t66 = load double, double* %l2
  %t67 = sitofp i64 0 to double
  %t68 = fcmp oeq double %t66, %t67
  %t69 = load i8*, i8** %l0
  %t70 = load double, double* %l1
  %t71 = load double, double* %l2
  %t72 = load double, double* %l3
  %t73 = load i8, i8* %l4
  br i1 %t68, label %then15, label %merge16
then15:
  %t74 = load i8*, i8** %l0
  %t75 = load double, double* %l3
  %t76 = load double, double* %l1
  %t77 = call i8* @slice_text(i8* %t74, double %t75, double %t76)
  call void @sailfin_runtime_mark_persistent(i8* %t77)
  ret i8* %t77
merge16:
  %t78 = load double, double* %l2
  br label %merge12
merge12:
  %t79 = phi double [ %t78, %merge16 ], [ %t52, %else7 ]
  store double %t79, double* %l2
  %t80 = load double, double* %l2
  br label %merge8
merge8:
  %t81 = phi double [ %t46, %merge10 ], [ %t28, %merge12 ]
  %t82 = phi double [ %t47, %merge10 ], [ %t80, %merge12 ]
  store double %t81, double* %l3
  store double %t82, double* %l2
  %t83 = load double, double* %l1
  %t84 = sitofp i64 1 to double
  %t85 = fadd double %t83, %t84
  store double %t85, double* %l1
  br label %loop.latch2
loop.latch2:
  %t86 = load double, double* %l3
  %t87 = load double, double* %l2
  %t88 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t92 = load double, double* %l3
  %t93 = load double, double* %l2
  %t94 = load double, double* %l1
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
}

define { i8**, i64 }* @split_generic_argument_list(i8* %block) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8
  %l5 = alloca i8*
  %l6 = alloca i8*
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
  %s12 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s12, i8** %l1
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l2
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l3
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = load i8*, i8** %l1
  %t17 = load double, double* %l2
  %t18 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t177 = phi double [ %t17, %block.entry ], [ %t173, %loop.latch2 ]
  %t178 = phi i8* [ %t16, %block.entry ], [ %t174, %loop.latch2 ]
  %t179 = phi { i8**, i64 }* [ %t15, %block.entry ], [ %t175, %loop.latch2 ]
  %t180 = phi double [ %t18, %block.entry ], [ %t176, %loop.latch2 ]
  store double %t177, double* %l2
  store i8* %t178, i8** %l1
  store { i8**, i64 }* %t179, { i8**, i64 }** %l0
  store double %t180, double* %l3
  br label %loop.body1
loop.body1:
  %t19 = load double, double* %l3
  %t20 = call i64 @sailfin_runtime_string_length(i8* %block)
  %t21 = sitofp i64 %t20 to double
  %t22 = fcmp oge double %t19, %t21
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load i8*, i8** %l1
  %t25 = load double, double* %l2
  %t26 = load double, double* %l3
  br i1 %t22, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t27 = load double, double* %l3
  %t28 = call double @llvm.round.f64(double %t27)
  %t29 = fptosi double %t28 to i64
  %t30 = getelementptr i8, i8* %block, i64 %t29
  %t31 = load i8, i8* %t30
  store i8 %t31, i8* %l4
  %t32 = load i8, i8* %l4
  %t33 = icmp eq i8 %t32, 60
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
  %t42 = load i8*, i8** %l1
  %t43 = load i8, i8* %l4
  %t44 = alloca [2 x i8], align 1
  %t45 = getelementptr [2 x i8], [2 x i8]* %t44, i32 0, i32 0
  store i8 %t43, i8* %t45
  %t46 = getelementptr [2 x i8], [2 x i8]* %t44, i32 0, i32 1
  store i8 0, i8* %t46
  %t47 = getelementptr [2 x i8], [2 x i8]* %t44, i32 0, i32 0
  %t48 = call i8* @sailfin_runtime_string_concat(i8* %t42, i8* %t47)
  store i8* %t48, i8** %l1
  %t49 = load double, double* %l2
  %t50 = load i8*, i8** %l1
  br label %merge8
else7:
  %t51 = load i8, i8* %l4
  %t52 = icmp eq i8 %t51, 62
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load i8*, i8** %l1
  %t55 = load double, double* %l2
  %t56 = load double, double* %l3
  %t57 = load i8, i8* %l4
  br i1 %t52, label %then9, label %else10
then9:
  %t58 = load double, double* %l2
  %t59 = sitofp i64 0 to double
  %t60 = fcmp ogt double %t58, %t59
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t62 = load i8*, i8** %l1
  %t63 = load double, double* %l2
  %t64 = load double, double* %l3
  %t65 = load i8, i8* %l4
  br i1 %t60, label %then12, label %merge13
then12:
  %t66 = load double, double* %l2
  %t67 = sitofp i64 1 to double
  %t68 = fsub double %t66, %t67
  store double %t68, double* %l2
  %t69 = load double, double* %l2
  br label %merge13
merge13:
  %t70 = phi double [ %t69, %then12 ], [ %t63, %then9 ]
  store double %t70, double* %l2
  %t71 = load i8*, i8** %l1
  %t72 = load i8, i8* %l4
  %t73 = alloca [2 x i8], align 1
  %t74 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 0
  store i8 %t72, i8* %t74
  %t75 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 1
  store i8 0, i8* %t75
  %t76 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 0
  %t77 = call i8* @sailfin_runtime_string_concat(i8* %t71, i8* %t76)
  store i8* %t77, i8** %l1
  %t78 = load double, double* %l2
  %t79 = load i8*, i8** %l1
  br label %merge11
else10:
  %t80 = load i8, i8* %l4
  %t81 = icmp eq i8 %t80, 44
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t83 = load i8*, i8** %l1
  %t84 = load double, double* %l2
  %t85 = load double, double* %l3
  %t86 = load i8, i8* %l4
  br i1 %t81, label %then14, label %else15
then14:
  %t87 = load double, double* %l2
  %t88 = sitofp i64 0 to double
  %t89 = fcmp oeq double %t87, %t88
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t91 = load i8*, i8** %l1
  %t92 = load double, double* %l2
  %t93 = load double, double* %l3
  %t94 = load i8, i8* %l4
  br i1 %t89, label %then17, label %merge18
then17:
  %t95 = load i8*, i8** %l1
  %t96 = call i8* @trim_text(i8* %t95)
  store i8* %t96, i8** %l5
  %t97 = load i8*, i8** %l5
  %t98 = call i64 @sailfin_runtime_string_length(i8* %t97)
  %t99 = icmp sgt i64 %t98, 0
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t101 = load i8*, i8** %l1
  %t102 = load double, double* %l2
  %t103 = load double, double* %l3
  %t104 = load i8, i8* %l4
  %t105 = load i8*, i8** %l5
  br i1 %t99, label %then19, label %merge20
then19:
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t107 = load i8*, i8** %l5
  %t108 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t109 = ptrtoint [1 x i8*]* %t108 to i64
  %t110 = icmp eq i64 %t109, 0
  %t111 = select i1 %t110, i64 1, i64 %t109
  %t112 = call i8* @malloc(i64 %t111)
  %t113 = bitcast i8* %t112 to i8**
  %t114 = getelementptr i8*, i8** %t113, i64 0
  store i8* %t107, i8** %t114
  %t115 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t116 = ptrtoint { i8**, i64 }* %t115 to i64
  %t117 = call i8* @malloc(i64 %t116)
  %t118 = bitcast i8* %t117 to { i8**, i64 }*
  %t119 = getelementptr { i8**, i64 }, { i8**, i64 }* %t118, i32 0, i32 0
  store i8** %t113, i8*** %t119
  %t120 = getelementptr { i8**, i64 }, { i8**, i64 }* %t118, i32 0, i32 1
  store i64 1, i64* %t120
  %t121 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t106, { i8**, i64 }* %t118)
  store { i8**, i64 }* %t121, { i8**, i64 }** %l0
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge20
merge20:
  %t123 = phi { i8**, i64 }* [ %t122, %then19 ], [ %t100, %then17 ]
  store { i8**, i64 }* %t123, { i8**, i64 }** %l0
  %s124 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s124, i8** %l1
  %t125 = load double, double* %l3
  %t126 = sitofp i64 1 to double
  %t127 = fadd double %t125, %t126
  store double %t127, double* %l3
  br label %loop.latch2
merge18:
  %t128 = load i8*, i8** %l1
  %t129 = load i8, i8* %l4
  %t130 = alloca [2 x i8], align 1
  %t131 = getelementptr [2 x i8], [2 x i8]* %t130, i32 0, i32 0
  store i8 %t129, i8* %t131
  %t132 = getelementptr [2 x i8], [2 x i8]* %t130, i32 0, i32 1
  store i8 0, i8* %t132
  %t133 = getelementptr [2 x i8], [2 x i8]* %t130, i32 0, i32 0
  %t134 = call i8* @sailfin_runtime_string_concat(i8* %t128, i8* %t133)
  store i8* %t134, i8** %l1
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t136 = load i8*, i8** %l1
  %t137 = load double, double* %l3
  %t138 = load i8*, i8** %l1
  br label %merge16
else15:
  %t139 = load i8*, i8** %l1
  %t140 = load i8, i8* %l4
  %t141 = alloca [2 x i8], align 1
  %t142 = getelementptr [2 x i8], [2 x i8]* %t141, i32 0, i32 0
  store i8 %t140, i8* %t142
  %t143 = getelementptr [2 x i8], [2 x i8]* %t141, i32 0, i32 1
  store i8 0, i8* %t143
  %t144 = getelementptr [2 x i8], [2 x i8]* %t141, i32 0, i32 0
  %t145 = call i8* @sailfin_runtime_string_concat(i8* %t139, i8* %t144)
  store i8* %t145, i8** %l1
  %t146 = load i8*, i8** %l1
  br label %merge16
merge16:
  %t147 = phi { i8**, i64 }* [ %t135, %merge18 ], [ %t82, %else15 ]
  %t148 = phi i8* [ %t136, %merge18 ], [ %t146, %else15 ]
  %t149 = phi double [ %t137, %merge18 ], [ %t85, %else15 ]
  store { i8**, i64 }* %t147, { i8**, i64 }** %l0
  store i8* %t148, i8** %l1
  store double %t149, double* %l3
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t151 = load i8*, i8** %l1
  %t152 = load double, double* %l3
  %t153 = load i8*, i8** %l1
  %t154 = load i8*, i8** %l1
  br label %merge11
merge11:
  %t155 = phi double [ %t78, %merge13 ], [ %t55, %merge16 ]
  %t156 = phi i8* [ %t79, %merge13 ], [ %t151, %merge16 ]
  %t157 = phi { i8**, i64 }* [ %t53, %merge13 ], [ %t150, %merge16 ]
  %t158 = phi double [ %t56, %merge13 ], [ %t152, %merge16 ]
  store double %t155, double* %l2
  store i8* %t156, i8** %l1
  store { i8**, i64 }* %t157, { i8**, i64 }** %l0
  store double %t158, double* %l3
  %t159 = load double, double* %l2
  %t160 = load i8*, i8** %l1
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t162 = load i8*, i8** %l1
  %t163 = load double, double* %l3
  %t164 = load i8*, i8** %l1
  %t165 = load i8*, i8** %l1
  br label %merge8
merge8:
  %t166 = phi double [ %t49, %then6 ], [ %t159, %merge11 ]
  %t167 = phi i8* [ %t50, %then6 ], [ %t160, %merge11 ]
  %t168 = phi { i8**, i64 }* [ %t34, %then6 ], [ %t161, %merge11 ]
  %t169 = phi double [ %t37, %then6 ], [ %t163, %merge11 ]
  store double %t166, double* %l2
  store i8* %t167, i8** %l1
  store { i8**, i64 }* %t168, { i8**, i64 }** %l0
  store double %t169, double* %l3
  %t170 = load double, double* %l3
  %t171 = sitofp i64 1 to double
  %t172 = fadd double %t170, %t171
  store double %t172, double* %l3
  br label %loop.latch2
loop.latch2:
  %t173 = load double, double* %l2
  %t174 = load i8*, i8** %l1
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t176 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t181 = load double, double* %l2
  %t182 = load i8*, i8** %l1
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t184 = load double, double* %l3
  %t185 = load i8*, i8** %l1
  %t186 = call i8* @trim_text(i8* %t185)
  store i8* %t186, i8** %l6
  %t187 = load i8*, i8** %l6
  %t188 = call i64 @sailfin_runtime_string_length(i8* %t187)
  %t189 = icmp sgt i64 %t188, 0
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t191 = load i8*, i8** %l1
  %t192 = load double, double* %l2
  %t193 = load double, double* %l3
  %t194 = load i8*, i8** %l6
  br i1 %t189, label %then21, label %merge22
then21:
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t196 = load i8*, i8** %l6
  %t197 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t198 = ptrtoint [1 x i8*]* %t197 to i64
  %t199 = icmp eq i64 %t198, 0
  %t200 = select i1 %t199, i64 1, i64 %t198
  %t201 = call i8* @malloc(i64 %t200)
  %t202 = bitcast i8* %t201 to i8**
  %t203 = getelementptr i8*, i8** %t202, i64 0
  store i8* %t196, i8** %t203
  %t204 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t205 = ptrtoint { i8**, i64 }* %t204 to i64
  %t206 = call i8* @malloc(i64 %t205)
  %t207 = bitcast i8* %t206 to { i8**, i64 }*
  %t208 = getelementptr { i8**, i64 }, { i8**, i64 }* %t207, i32 0, i32 0
  store i8** %t202, i8*** %t208
  %t209 = getelementptr { i8**, i64 }, { i8**, i64 }* %t207, i32 0, i32 1
  store i64 1, i64* %t209
  %t210 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t195, { i8**, i64 }* %t207)
  store { i8**, i64 }* %t210, { i8**, i64 }** %l0
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge22
merge22:
  %t212 = phi { i8**, i64 }* [ %t211, %then21 ], [ %t190, %afterloop3 ]
  store { i8**, i64 }* %t212, { i8**, i64 }** %l0
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t213
}

define i8* @trim_text(i8* %value) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t2 = sitofp i64 %t1 to double
  store double %t2, double* %l1
  %t3 = load double, double* %l0
  %t4 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t26 = phi double [ %t3, %block.entry ], [ %t25, %loop.latch2 ]
  store double %t26, double* %l0
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
  %t15 = alloca [2 x i8], align 1
  %t16 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  store i8 %t14, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 1
  store i8 0, i8* %t17
  %t18 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  %t19 = call i1 @is_whitespace(i8* %t18)
  %t20 = load double, double* %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then6, label %merge7
then6:
  %t22 = load double, double* %l0
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
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
  %t29 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t53 = phi double [ %t29, %afterloop3 ], [ %t52, %loop.latch10 ]
  store double %t53, double* %l1
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
  %t35 = load double, double* %l1
  %t36 = sitofp i64 1 to double
  %t37 = fsub double %t35, %t36
  %t38 = call double @llvm.round.f64(double %t37)
  %t39 = fptosi double %t38 to i64
  %t40 = getelementptr i8, i8* %value, i64 %t39
  %t41 = load i8, i8* %t40
  %t42 = alloca [2 x i8], align 1
  %t43 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  store i8 %t41, i8* %t43
  %t44 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 1
  store i8 0, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  %t46 = call i1 @is_whitespace(i8* %t45)
  %t47 = load double, double* %l0
  %t48 = load double, double* %l1
  br i1 %t46, label %then14, label %merge15
then14:
  %t49 = load double, double* %l1
  %t50 = sitofp i64 1 to double
  %t51 = fsub double %t49, %t50
  store double %t51, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t52 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t54 = load double, double* %l1
  %t55 = load double, double* %l0
  %t56 = load double, double* %l1
  %t57 = call i8* @slice_text(i8* %value, double %t55, double %t56)
  call void @sailfin_runtime_mark_persistent(i8* %t57)
  ret i8* %t57
}

define i8* @slice_text(i8* %value, double %start, double %end) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  store double %start, double* %l0
  store double %end, double* %l1
  %t0 = load double, double* %l0
  %t1 = sitofp i64 0 to double
  %t2 = fcmp olt double %t0, %t1
  %t3 = load double, double* %l0
  %t4 = load double, double* %l1
  br i1 %t2, label %then0, label %merge1
then0:
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l0
  %t6 = load double, double* %l0
  br label %merge1
merge1:
  %t7 = phi double [ %t6, %then0 ], [ %t3, %block.entry ]
  store double %t7, double* %l0
  %t8 = load double, double* %l1
  %t9 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t10 = sitofp i64 %t9 to double
  %t11 = fcmp ogt double %t8, %t10
  %t12 = load double, double* %l0
  %t13 = load double, double* %l1
  br i1 %t11, label %then2, label %merge3
then2:
  %t14 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t15 = sitofp i64 %t14 to double
  store double %t15, double* %l1
  %t16 = load double, double* %l1
  br label %merge3
merge3:
  %t17 = phi double [ %t16, %then2 ], [ %t13, %merge1 ]
  store double %t17, double* %l1
  %t18 = load double, double* %l1
  %t19 = load double, double* %l0
  %t20 = fcmp ole double %t18, %t19
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  br i1 %t20, label %then4, label %merge5
then4:
  %s23 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s23)
  ret i8* %s23
merge5:
  %s24 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s24, i8** %l2
  %t25 = load double, double* %l0
  store double %t25, double* %l3
  %t26 = load double, double* %l0
  %t27 = load double, double* %l1
  %t28 = load i8*, i8** %l2
  %t29 = load double, double* %l3
  br label %loop.header6
loop.header6:
  %t53 = phi i8* [ %t28, %merge5 ], [ %t51, %loop.latch8 ]
  %t54 = phi double [ %t29, %merge5 ], [ %t52, %loop.latch8 ]
  store i8* %t53, i8** %l2
  store double %t54, double* %l3
  br label %loop.body7
loop.body7:
  %t30 = load double, double* %l3
  %t31 = load double, double* %l1
  %t32 = fcmp oge double %t30, %t31
  %t33 = load double, double* %l0
  %t34 = load double, double* %l1
  %t35 = load i8*, i8** %l2
  %t36 = load double, double* %l3
  br i1 %t32, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t37 = load i8*, i8** %l2
  %t38 = load double, double* %l3
  %t39 = call double @llvm.round.f64(double %t38)
  %t40 = fptosi double %t39 to i64
  %t41 = getelementptr i8, i8* %value, i64 %t40
  %t42 = load i8, i8* %t41
  %t43 = alloca [2 x i8], align 1
  %t44 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  store i8 %t42, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 1
  store i8 0, i8* %t45
  %t46 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %t37, i8* %t46)
  store i8* %t47, i8** %l2
  %t48 = load double, double* %l3
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l3
  br label %loop.latch8
loop.latch8:
  %t51 = load i8*, i8** %l2
  %t52 = load double, double* %l3
  br label %loop.header6
afterloop9:
  %t55 = load i8*, i8** %l2
  %t56 = load double, double* %l3
  %t57 = load i8*, i8** %l2
  call void @sailfin_runtime_mark_persistent(i8* %t57)
  ret i8* %t57
}

define i1 @is_whitespace(i8* %ch) {
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
  %t8 = icmp eq i8 %t7, 9
  br label %logical_or_entry_6

logical_or_entry_6:
  br i1 %t8, label %logical_or_merge_6, label %logical_or_right_6

logical_or_right_6:
  %t9 = load i8, i8* %ch
  %t10 = icmp eq i8 %t9, 13
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

define { %Diagnostic*, i64 }* @check_struct_methods({ %MethodDeclaration*, i64 }* %methods) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %MethodDeclaration
  %l4 = alloca i8*
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
  %t12 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t13 = ptrtoint [0 x %Diagnostic]* %t12 to i64
  %t14 = icmp eq i64 %t13, 0
  %t15 = select i1 %t14, i64 1, i64 %t13
  %t16 = call i8* @malloc(i64 %t15)
  %t17 = bitcast i8* %t16 to %Diagnostic*
  %t18 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t19 = ptrtoint { %Diagnostic*, i64 }* %t18 to i64
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to { %Diagnostic*, i64 }*
  %t22 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t21, i32 0, i32 0
  store %Diagnostic* %t17, %Diagnostic** %t22
  %t23 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t21, i32 0, i32 1
  store i64 0, i64* %t23
  store { %Diagnostic*, i64 }* %t21, { %Diagnostic*, i64 }** %l1
  %t24 = getelementptr { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %methods, i32 0, i32 1
  %t25 = load i64, i64* %t24
  %t26 = getelementptr { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %methods, i32 0, i32 0
  %t27 = load %MethodDeclaration*, %MethodDeclaration** %t26
  store i64 0, i64* %l2
  store %MethodDeclaration zeroinitializer, %MethodDeclaration* %l3
  br label %for0
for0:
  %t28 = load i64, i64* %l2
  %t29 = icmp slt i64 %t28, %t25
  br i1 %t29, label %forbody1, label %afterfor3
forbody1:
  %t30 = load i64, i64* %l2
  %t31 = getelementptr %MethodDeclaration, %MethodDeclaration* %t27, i64 %t30
  %t32 = load %MethodDeclaration, %MethodDeclaration* %t31
  store %MethodDeclaration %t32, %MethodDeclaration* %l3
  %t33 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t34 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t35 = extractvalue %MethodDeclaration %t34, 0
  %t36 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t35)
  %t37 = bitcast { %Diagnostic*, i64 }* %t33 to { i8**, i64 }*
  %t38 = bitcast { %Diagnostic*, i64 }* %t36 to { i8**, i64 }*
  %t39 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t37, { i8**, i64 }* %t38)
  %t40 = bitcast { i8**, i64 }* %t39 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t40, { %Diagnostic*, i64 }** %l1
  %t41 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t42 = extractvalue %MethodDeclaration %t41, 0
  %t43 = extractvalue %FunctionSignature %t42, 0
  store i8* %t43, i8** %l4
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load i8*, i8** %l4
  %t46 = call i1 @contains_string({ i8**, i64 }* %t44, i8* %t45)
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t49 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t50 = load i8*, i8** %l4
  br i1 %t46, label %then4, label %else5
then4:
  %t51 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t52 = load i8*, i8** %l4
  %s53 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1045703541, i32 0, i32 0
  %t54 = load i8*, i8** %l4
  %t55 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t56 = extractvalue %MethodDeclaration %t55, 0
  %t57 = extractvalue %FunctionSignature %t56, 6
  %t58 = call %Token* @token_from_name(i8* %t54, %SourceSpan* %t57)
  %t59 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t52, i8* %s53, %Token* %t58)
  %t60 = call noalias i8* @malloc(i64 24)
  %t61 = bitcast i8* %t60 to %Diagnostic*
  store %Diagnostic %t59, %Diagnostic* %t61
  %t62 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t63 = ptrtoint [1 x i8*]* %t62 to i64
  %t64 = icmp eq i64 %t63, 0
  %t65 = select i1 %t64, i64 1, i64 %t63
  %t66 = call i8* @malloc(i64 %t65)
  %t67 = bitcast i8* %t66 to i8**
  %t68 = getelementptr i8*, i8** %t67, i64 0
  store i8* %t60, i8** %t68
  %t69 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t70 = ptrtoint { i8**, i64 }* %t69 to i64
  %t71 = call i8* @malloc(i64 %t70)
  %t72 = bitcast i8* %t71 to { i8**, i64 }*
  %t73 = getelementptr { i8**, i64 }, { i8**, i64 }* %t72, i32 0, i32 0
  store i8** %t67, i8*** %t73
  %t74 = getelementptr { i8**, i64 }, { i8**, i64 }* %t72, i32 0, i32 1
  store i64 1, i64* %t74
  %t75 = bitcast { %Diagnostic*, i64 }* %t51 to { i8**, i64 }*
  %t76 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t75, { i8**, i64 }* %t72)
  %t77 = bitcast { i8**, i64 }* %t76 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t77, { %Diagnostic*, i64 }** %l1
  %t78 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t80 = load i8*, i8** %l4
  %t81 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t82 = ptrtoint [1 x i8*]* %t81 to i64
  %t83 = icmp eq i64 %t82, 0
  %t84 = select i1 %t83, i64 1, i64 %t82
  %t85 = call i8* @malloc(i64 %t84)
  %t86 = bitcast i8* %t85 to i8**
  %t87 = getelementptr i8*, i8** %t86, i64 0
  store i8* %t80, i8** %t87
  %t88 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t89 = ptrtoint { i8**, i64 }* %t88 to i64
  %t90 = call i8* @malloc(i64 %t89)
  %t91 = bitcast i8* %t90 to { i8**, i64 }*
  %t92 = getelementptr { i8**, i64 }, { i8**, i64 }* %t91, i32 0, i32 0
  store i8** %t86, i8*** %t92
  %t93 = getelementptr { i8**, i64 }, { i8**, i64 }* %t91, i32 0, i32 1
  store i64 1, i64* %t93
  %t94 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t79, { i8**, i64 }* %t91)
  store { i8**, i64 }* %t94, { i8**, i64 }** %l0
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t96 = phi { %Diagnostic*, i64 }* [ %t78, %then4 ], [ %t48, %else5 ]
  %t97 = phi { i8**, i64 }* [ %t47, %then4 ], [ %t95, %else5 ]
  store { %Diagnostic*, i64 }* %t96, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t97, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t98 = load i64, i64* %l2
  %t99 = add i64 %t98, 1
  store i64 %t99, i64* %l2
  br label %for0
afterfor3:
  %t100 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t102 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t102
}

define { %Diagnostic*, i64 }* @check_enum_variants({ %EnumVariant*, i64 }* %variants) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %EnumVariant
  %l4 = alloca i8*
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
  %t12 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t13 = ptrtoint [0 x %Diagnostic]* %t12 to i64
  %t14 = icmp eq i64 %t13, 0
  %t15 = select i1 %t14, i64 1, i64 %t13
  %t16 = call i8* @malloc(i64 %t15)
  %t17 = bitcast i8* %t16 to %Diagnostic*
  %t18 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t19 = ptrtoint { %Diagnostic*, i64 }* %t18 to i64
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to { %Diagnostic*, i64 }*
  %t22 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t21, i32 0, i32 0
  store %Diagnostic* %t17, %Diagnostic** %t22
  %t23 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t21, i32 0, i32 1
  store i64 0, i64* %t23
  store { %Diagnostic*, i64 }* %t21, { %Diagnostic*, i64 }** %l1
  %t24 = getelementptr { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %variants, i32 0, i32 1
  %t25 = load i64, i64* %t24
  %t26 = getelementptr { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %variants, i32 0, i32 0
  %t27 = load %EnumVariant*, %EnumVariant** %t26
  store i64 0, i64* %l2
  store %EnumVariant zeroinitializer, %EnumVariant* %l3
  br label %for0
for0:
  %t28 = load i64, i64* %l2
  %t29 = icmp slt i64 %t28, %t25
  br i1 %t29, label %forbody1, label %afterfor3
forbody1:
  %t30 = load i64, i64* %l2
  %t31 = getelementptr %EnumVariant, %EnumVariant* %t27, i64 %t30
  %t32 = load %EnumVariant, %EnumVariant* %t31
  store %EnumVariant %t32, %EnumVariant* %l3
  %t33 = load %EnumVariant, %EnumVariant* %l3
  %t34 = extractvalue %EnumVariant %t33, 0
  store i8* %t34, i8** %l4
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load i8*, i8** %l4
  %t37 = call i1 @contains_string({ i8**, i64 }* %t35, i8* %t36)
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t40 = load %EnumVariant, %EnumVariant* %l3
  %t41 = load i8*, i8** %l4
  br i1 %t37, label %then4, label %else5
then4:
  %t42 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t43 = load i8*, i8** %l4
  %s44 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h328844387, i32 0, i32 0
  %t45 = load i8*, i8** %l4
  %t46 = load %EnumVariant, %EnumVariant* %l3
  %t47 = extractvalue %EnumVariant %t46, 2
  %t48 = call %Token* @token_from_name(i8* %t45, %SourceSpan* %t47)
  %t49 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t43, i8* %s44, %Token* %t48)
  %t50 = call noalias i8* @malloc(i64 24)
  %t51 = bitcast i8* %t50 to %Diagnostic*
  store %Diagnostic %t49, %Diagnostic* %t51
  %t52 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t53 = ptrtoint [1 x i8*]* %t52 to i64
  %t54 = icmp eq i64 %t53, 0
  %t55 = select i1 %t54, i64 1, i64 %t53
  %t56 = call i8* @malloc(i64 %t55)
  %t57 = bitcast i8* %t56 to i8**
  %t58 = getelementptr i8*, i8** %t57, i64 0
  store i8* %t50, i8** %t58
  %t59 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t60 = ptrtoint { i8**, i64 }* %t59 to i64
  %t61 = call i8* @malloc(i64 %t60)
  %t62 = bitcast i8* %t61 to { i8**, i64 }*
  %t63 = getelementptr { i8**, i64 }, { i8**, i64 }* %t62, i32 0, i32 0
  store i8** %t57, i8*** %t63
  %t64 = getelementptr { i8**, i64 }, { i8**, i64 }* %t62, i32 0, i32 1
  store i64 1, i64* %t64
  %t65 = bitcast { %Diagnostic*, i64 }* %t42 to { i8**, i64 }*
  %t66 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t65, { i8**, i64 }* %t62)
  %t67 = bitcast { i8**, i64 }* %t66 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t67, { %Diagnostic*, i64 }** %l1
  %t68 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load i8*, i8** %l4
  %t71 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t72 = ptrtoint [1 x i8*]* %t71 to i64
  %t73 = icmp eq i64 %t72, 0
  %t74 = select i1 %t73, i64 1, i64 %t72
  %t75 = call i8* @malloc(i64 %t74)
  %t76 = bitcast i8* %t75 to i8**
  %t77 = getelementptr i8*, i8** %t76, i64 0
  store i8* %t70, i8** %t77
  %t78 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t79 = ptrtoint { i8**, i64 }* %t78 to i64
  %t80 = call i8* @malloc(i64 %t79)
  %t81 = bitcast i8* %t80 to { i8**, i64 }*
  %t82 = getelementptr { i8**, i64 }, { i8**, i64 }* %t81, i32 0, i32 0
  store i8** %t76, i8*** %t82
  %t83 = getelementptr { i8**, i64 }, { i8**, i64 }* %t81, i32 0, i32 1
  store i64 1, i64* %t83
  %t84 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t69, { i8**, i64 }* %t81)
  store { i8**, i64 }* %t84, { i8**, i64 }** %l0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t86 = phi { %Diagnostic*, i64 }* [ %t68, %then4 ], [ %t39, %else5 ]
  %t87 = phi { i8**, i64 }* [ %t38, %then4 ], [ %t85, %else5 ]
  store { %Diagnostic*, i64 }* %t86, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t87, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t88 = load i64, i64* %l2
  %t89 = add i64 %t88, 1
  store i64 %t89, i64* %l2
  br label %for0
afterfor3:
  %t90 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t92 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t92
}

define { %Diagnostic*, i64 }* @check_interface_members({ %FunctionSignature*, i64 }* %members) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %FunctionSignature
  %l4 = alloca i8*
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
  %t12 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t13 = ptrtoint [0 x %Diagnostic]* %t12 to i64
  %t14 = icmp eq i64 %t13, 0
  %t15 = select i1 %t14, i64 1, i64 %t13
  %t16 = call i8* @malloc(i64 %t15)
  %t17 = bitcast i8* %t16 to %Diagnostic*
  %t18 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t19 = ptrtoint { %Diagnostic*, i64 }* %t18 to i64
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to { %Diagnostic*, i64 }*
  %t22 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t21, i32 0, i32 0
  store %Diagnostic* %t17, %Diagnostic** %t22
  %t23 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t21, i32 0, i32 1
  store i64 0, i64* %t23
  store { %Diagnostic*, i64 }* %t21, { %Diagnostic*, i64 }** %l1
  %t24 = getelementptr { %FunctionSignature*, i64 }, { %FunctionSignature*, i64 }* %members, i32 0, i32 1
  %t25 = load i64, i64* %t24
  %t26 = getelementptr { %FunctionSignature*, i64 }, { %FunctionSignature*, i64 }* %members, i32 0, i32 0
  %t27 = load %FunctionSignature*, %FunctionSignature** %t26
  store i64 0, i64* %l2
  store %FunctionSignature zeroinitializer, %FunctionSignature* %l3
  br label %for0
for0:
  %t28 = load i64, i64* %l2
  %t29 = icmp slt i64 %t28, %t25
  br i1 %t29, label %forbody1, label %afterfor3
forbody1:
  %t30 = load i64, i64* %l2
  %t31 = getelementptr %FunctionSignature, %FunctionSignature* %t27, i64 %t30
  %t32 = load %FunctionSignature, %FunctionSignature* %t31
  store %FunctionSignature %t32, %FunctionSignature* %l3
  %t33 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t34 = load %FunctionSignature, %FunctionSignature* %l3
  %t35 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t34)
  %t36 = bitcast { %Diagnostic*, i64 }* %t33 to { i8**, i64 }*
  %t37 = bitcast { %Diagnostic*, i64 }* %t35 to { i8**, i64 }*
  %t38 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t36, { i8**, i64 }* %t37)
  %t39 = bitcast { i8**, i64 }* %t38 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t39, { %Diagnostic*, i64 }** %l1
  %t40 = load %FunctionSignature, %FunctionSignature* %l3
  %t41 = extractvalue %FunctionSignature %t40, 0
  store i8* %t41, i8** %l4
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load i8*, i8** %l4
  %t44 = call i1 @contains_string({ i8**, i64 }* %t42, i8* %t43)
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t46 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t47 = load %FunctionSignature, %FunctionSignature* %l3
  %t48 = load i8*, i8** %l4
  br i1 %t44, label %then4, label %else5
then4:
  %t49 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t50 = load i8*, i8** %l4
  %s51 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h994638848, i32 0, i32 0
  %t52 = load i8*, i8** %l4
  %t53 = load %FunctionSignature, %FunctionSignature* %l3
  %t54 = extractvalue %FunctionSignature %t53, 6
  %t55 = call %Token* @token_from_name(i8* %t52, %SourceSpan* %t54)
  %t56 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t50, i8* %s51, %Token* %t55)
  %t57 = call noalias i8* @malloc(i64 24)
  %t58 = bitcast i8* %t57 to %Diagnostic*
  store %Diagnostic %t56, %Diagnostic* %t58
  %t59 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t60 = ptrtoint [1 x i8*]* %t59 to i64
  %t61 = icmp eq i64 %t60, 0
  %t62 = select i1 %t61, i64 1, i64 %t60
  %t63 = call i8* @malloc(i64 %t62)
  %t64 = bitcast i8* %t63 to i8**
  %t65 = getelementptr i8*, i8** %t64, i64 0
  store i8* %t57, i8** %t65
  %t66 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t67 = ptrtoint { i8**, i64 }* %t66 to i64
  %t68 = call i8* @malloc(i64 %t67)
  %t69 = bitcast i8* %t68 to { i8**, i64 }*
  %t70 = getelementptr { i8**, i64 }, { i8**, i64 }* %t69, i32 0, i32 0
  store i8** %t64, i8*** %t70
  %t71 = getelementptr { i8**, i64 }, { i8**, i64 }* %t69, i32 0, i32 1
  store i64 1, i64* %t71
  %t72 = bitcast { %Diagnostic*, i64 }* %t49 to { i8**, i64 }*
  %t73 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t72, { i8**, i64 }* %t69)
  %t74 = bitcast { i8**, i64 }* %t73 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t74, { %Diagnostic*, i64 }** %l1
  %t75 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t77 = load i8*, i8** %l4
  %t78 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t79 = ptrtoint [1 x i8*]* %t78 to i64
  %t80 = icmp eq i64 %t79, 0
  %t81 = select i1 %t80, i64 1, i64 %t79
  %t82 = call i8* @malloc(i64 %t81)
  %t83 = bitcast i8* %t82 to i8**
  %t84 = getelementptr i8*, i8** %t83, i64 0
  store i8* %t77, i8** %t84
  %t85 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t86 = ptrtoint { i8**, i64 }* %t85 to i64
  %t87 = call i8* @malloc(i64 %t86)
  %t88 = bitcast i8* %t87 to { i8**, i64 }*
  %t89 = getelementptr { i8**, i64 }, { i8**, i64 }* %t88, i32 0, i32 0
  store i8** %t83, i8*** %t89
  %t90 = getelementptr { i8**, i64 }, { i8**, i64 }* %t88, i32 0, i32 1
  store i64 1, i64* %t90
  %t91 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t76, { i8**, i64 }* %t88)
  store { i8**, i64 }* %t91, { i8**, i64 }** %l0
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t93 = phi { %Diagnostic*, i64 }* [ %t75, %then4 ], [ %t46, %else5 ]
  %t94 = phi { i8**, i64 }* [ %t45, %then4 ], [ %t92, %else5 ]
  store { %Diagnostic*, i64 }* %t93, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t94, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t95 = load i64, i64* %l2
  %t96 = add i64 %t95, 1
  store i64 %t96, i64* %l2
  br label %for0
afterfor3:
  %t97 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t99 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t99
}

define { %Diagnostic*, i64 }* @check_model_properties({ %ModelProperty*, i64 }* %properties) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %ModelProperty
  %l4 = alloca i8*
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
  %t12 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t13 = ptrtoint [0 x %Diagnostic]* %t12 to i64
  %t14 = icmp eq i64 %t13, 0
  %t15 = select i1 %t14, i64 1, i64 %t13
  %t16 = call i8* @malloc(i64 %t15)
  %t17 = bitcast i8* %t16 to %Diagnostic*
  %t18 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t19 = ptrtoint { %Diagnostic*, i64 }* %t18 to i64
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to { %Diagnostic*, i64 }*
  %t22 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t21, i32 0, i32 0
  store %Diagnostic* %t17, %Diagnostic** %t22
  %t23 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t21, i32 0, i32 1
  store i64 0, i64* %t23
  store { %Diagnostic*, i64 }* %t21, { %Diagnostic*, i64 }** %l1
  %t24 = getelementptr { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %properties, i32 0, i32 1
  %t25 = load i64, i64* %t24
  %t26 = getelementptr { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %properties, i32 0, i32 0
  %t27 = load %ModelProperty*, %ModelProperty** %t26
  store i64 0, i64* %l2
  store %ModelProperty zeroinitializer, %ModelProperty* %l3
  br label %for0
for0:
  %t28 = load i64, i64* %l2
  %t29 = icmp slt i64 %t28, %t25
  br i1 %t29, label %forbody1, label %afterfor3
forbody1:
  %t30 = load i64, i64* %l2
  %t31 = getelementptr %ModelProperty, %ModelProperty* %t27, i64 %t30
  %t32 = load %ModelProperty, %ModelProperty* %t31
  store %ModelProperty %t32, %ModelProperty* %l3
  %t33 = load %ModelProperty, %ModelProperty* %l3
  %t34 = extractvalue %ModelProperty %t33, 0
  store i8* %t34, i8** %l4
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load i8*, i8** %l4
  %t37 = call i1 @contains_string({ i8**, i64 }* %t35, i8* %t36)
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t40 = load %ModelProperty, %ModelProperty* %l3
  %t41 = load i8*, i8** %l4
  br i1 %t37, label %then4, label %else5
then4:
  %t42 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t43 = load i8*, i8** %l4
  %s44 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h812083909, i32 0, i32 0
  %t45 = load i8*, i8** %l4
  %t46 = load %ModelProperty, %ModelProperty* %l3
  %t47 = extractvalue %ModelProperty %t46, 2
  %t48 = call %Token* @token_from_name(i8* %t45, %SourceSpan* %t47)
  %t49 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t43, i8* %s44, %Token* %t48)
  %t50 = call noalias i8* @malloc(i64 24)
  %t51 = bitcast i8* %t50 to %Diagnostic*
  store %Diagnostic %t49, %Diagnostic* %t51
  %t52 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t53 = ptrtoint [1 x i8*]* %t52 to i64
  %t54 = icmp eq i64 %t53, 0
  %t55 = select i1 %t54, i64 1, i64 %t53
  %t56 = call i8* @malloc(i64 %t55)
  %t57 = bitcast i8* %t56 to i8**
  %t58 = getelementptr i8*, i8** %t57, i64 0
  store i8* %t50, i8** %t58
  %t59 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t60 = ptrtoint { i8**, i64 }* %t59 to i64
  %t61 = call i8* @malloc(i64 %t60)
  %t62 = bitcast i8* %t61 to { i8**, i64 }*
  %t63 = getelementptr { i8**, i64 }, { i8**, i64 }* %t62, i32 0, i32 0
  store i8** %t57, i8*** %t63
  %t64 = getelementptr { i8**, i64 }, { i8**, i64 }* %t62, i32 0, i32 1
  store i64 1, i64* %t64
  %t65 = bitcast { %Diagnostic*, i64 }* %t42 to { i8**, i64 }*
  %t66 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t65, { i8**, i64 }* %t62)
  %t67 = bitcast { i8**, i64 }* %t66 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t67, { %Diagnostic*, i64 }** %l1
  %t68 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load i8*, i8** %l4
  %t71 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t72 = ptrtoint [1 x i8*]* %t71 to i64
  %t73 = icmp eq i64 %t72, 0
  %t74 = select i1 %t73, i64 1, i64 %t72
  %t75 = call i8* @malloc(i64 %t74)
  %t76 = bitcast i8* %t75 to i8**
  %t77 = getelementptr i8*, i8** %t76, i64 0
  store i8* %t70, i8** %t77
  %t78 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t79 = ptrtoint { i8**, i64 }* %t78 to i64
  %t80 = call i8* @malloc(i64 %t79)
  %t81 = bitcast i8* %t80 to { i8**, i64 }*
  %t82 = getelementptr { i8**, i64 }, { i8**, i64 }* %t81, i32 0, i32 0
  store i8** %t76, i8*** %t82
  %t83 = getelementptr { i8**, i64 }, { i8**, i64 }* %t81, i32 0, i32 1
  store i64 1, i64* %t83
  %t84 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t69, { i8**, i64 }* %t81)
  store { i8**, i64 }* %t84, { i8**, i64 }** %l0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t86 = phi { %Diagnostic*, i64 }* [ %t68, %then4 ], [ %t39, %else5 ]
  %t87 = phi { i8**, i64 }* [ %t38, %then4 ], [ %t85, %else5 ]
  store { %Diagnostic*, i64 }* %t86, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t87, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t88 = load i64, i64* %l2
  %t89 = add i64 %t88, 1
  store i64 %t89, i64* %l2
  br label %for0
afterfor3:
  %t90 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t92 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t92
}

define { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %signature) {
block.entry:
  %t0 = extractvalue %FunctionSignature %signature, 5
  %t1 = bitcast { %TypeParameter**, i64 }* %t0 to { %TypeParameter*, i64 }*
  %t2 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t1)
  ret { %Diagnostic*, i64 }* %t2
}

define { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %type_parameters) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %TypeParameter
  %l4 = alloca i8*
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
  %t12 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t13 = ptrtoint [0 x %Diagnostic]* %t12 to i64
  %t14 = icmp eq i64 %t13, 0
  %t15 = select i1 %t14, i64 1, i64 %t13
  %t16 = call i8* @malloc(i64 %t15)
  %t17 = bitcast i8* %t16 to %Diagnostic*
  %t18 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t19 = ptrtoint { %Diagnostic*, i64 }* %t18 to i64
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to { %Diagnostic*, i64 }*
  %t22 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t21, i32 0, i32 0
  store %Diagnostic* %t17, %Diagnostic** %t22
  %t23 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t21, i32 0, i32 1
  store i64 0, i64* %t23
  store { %Diagnostic*, i64 }* %t21, { %Diagnostic*, i64 }** %l1
  %t24 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %type_parameters, i32 0, i32 1
  %t25 = load i64, i64* %t24
  %t26 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %type_parameters, i32 0, i32 0
  %t27 = load %TypeParameter*, %TypeParameter** %t26
  store i64 0, i64* %l2
  store %TypeParameter zeroinitializer, %TypeParameter* %l3
  br label %for0
for0:
  %t28 = load i64, i64* %l2
  %t29 = icmp slt i64 %t28, %t25
  br i1 %t29, label %forbody1, label %afterfor3
forbody1:
  %t30 = load i64, i64* %l2
  %t31 = getelementptr %TypeParameter, %TypeParameter* %t27, i64 %t30
  %t32 = load %TypeParameter, %TypeParameter* %t31
  store %TypeParameter %t32, %TypeParameter* %l3
  %t33 = load %TypeParameter, %TypeParameter* %l3
  %t34 = extractvalue %TypeParameter %t33, 0
  store i8* %t34, i8** %l4
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load i8*, i8** %l4
  %t37 = call i1 @contains_string({ i8**, i64 }* %t35, i8* %t36)
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t40 = load %TypeParameter, %TypeParameter* %l3
  %t41 = load i8*, i8** %l4
  br i1 %t37, label %then4, label %else5
then4:
  %t42 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t43 = load i8*, i8** %l4
  %s44 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h513489323, i32 0, i32 0
  %t45 = load i8*, i8** %l4
  %t46 = load %TypeParameter, %TypeParameter* %l3
  %t47 = extractvalue %TypeParameter %t46, 2
  %t48 = call %Token* @token_from_name(i8* %t45, %SourceSpan* %t47)
  %t49 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t43, i8* %s44, %Token* %t48)
  %t50 = call noalias i8* @malloc(i64 24)
  %t51 = bitcast i8* %t50 to %Diagnostic*
  store %Diagnostic %t49, %Diagnostic* %t51
  %t52 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t53 = ptrtoint [1 x i8*]* %t52 to i64
  %t54 = icmp eq i64 %t53, 0
  %t55 = select i1 %t54, i64 1, i64 %t53
  %t56 = call i8* @malloc(i64 %t55)
  %t57 = bitcast i8* %t56 to i8**
  %t58 = getelementptr i8*, i8** %t57, i64 0
  store i8* %t50, i8** %t58
  %t59 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t60 = ptrtoint { i8**, i64 }* %t59 to i64
  %t61 = call i8* @malloc(i64 %t60)
  %t62 = bitcast i8* %t61 to { i8**, i64 }*
  %t63 = getelementptr { i8**, i64 }, { i8**, i64 }* %t62, i32 0, i32 0
  store i8** %t57, i8*** %t63
  %t64 = getelementptr { i8**, i64 }, { i8**, i64 }* %t62, i32 0, i32 1
  store i64 1, i64* %t64
  %t65 = bitcast { %Diagnostic*, i64 }* %t42 to { i8**, i64 }*
  %t66 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t65, { i8**, i64 }* %t62)
  %t67 = bitcast { i8**, i64 }* %t66 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t67, { %Diagnostic*, i64 }** %l1
  %t68 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load i8*, i8** %l4
  %t71 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t72 = ptrtoint [1 x i8*]* %t71 to i64
  %t73 = icmp eq i64 %t72, 0
  %t74 = select i1 %t73, i64 1, i64 %t72
  %t75 = call i8* @malloc(i64 %t74)
  %t76 = bitcast i8* %t75 to i8**
  %t77 = getelementptr i8*, i8** %t76, i64 0
  store i8* %t70, i8** %t77
  %t78 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t79 = ptrtoint { i8**, i64 }* %t78 to i64
  %t80 = call i8* @malloc(i64 %t79)
  %t81 = bitcast i8* %t80 to { i8**, i64 }*
  %t82 = getelementptr { i8**, i64 }, { i8**, i64 }* %t81, i32 0, i32 0
  store i8** %t76, i8*** %t82
  %t83 = getelementptr { i8**, i64 }, { i8**, i64 }* %t81, i32 0, i32 1
  store i64 1, i64* %t83
  %t84 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t69, { i8**, i64 }* %t81)
  store { i8**, i64 }* %t84, { i8**, i64 }** %l0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t86 = phi { %Diagnostic*, i64 }* [ %t68, %then4 ], [ %t39, %else5 ]
  %t87 = phi { i8**, i64 }* [ %t38, %then4 ], [ %t85, %else5 ]
  store { %Diagnostic*, i64 }* %t86, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t87, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t88 = load i64, i64* %l2
  %t89 = add i64 %t88, 1
  store i64 %t89, i64* %l2
  br label %for0
afterfor3:
  %t90 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t92 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t92
}

define { %Diagnostic*, i64 }* @build_effect_diagnostics(%Program %program) {
block.entry:
  %l0 = alloca { %EffectViolation*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca double
  %l3 = alloca %EffectViolation
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca %EffectRequirement*
  %t0 = call { %EffectViolation*, i64 }* @validate_effects(%Program %program)
  store { %EffectViolation*, i64 }* %t0, { %EffectViolation*, i64 }** %l0
  %t1 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t2 = ptrtoint [0 x %Diagnostic]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to %Diagnostic*
  %t7 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t8 = ptrtoint { %Diagnostic*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %Diagnostic*, i64 }*
  %t11 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t10, i32 0, i32 0
  store %Diagnostic* %t6, %Diagnostic** %t11
  %t12 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { %Diagnostic*, i64 }* %t10, { %Diagnostic*, i64 }** %l1
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l2
  %t14 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t15 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t16 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t114 = phi { %Diagnostic*, i64 }* [ %t15, %block.entry ], [ %t112, %loop.latch2 ]
  %t115 = phi double [ %t16, %block.entry ], [ %t113, %loop.latch2 ]
  store { %Diagnostic*, i64 }* %t114, { %Diagnostic*, i64 }** %l1
  store double %t115, double* %l2
  br label %loop.body1
loop.body1:
  %t17 = load double, double* %l2
  %t18 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t19 = load { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t18
  %t20 = extractvalue { %EffectViolation*, i64 } %t19, 1
  %t21 = sitofp i64 %t20 to double
  %t22 = fcmp oge double %t17, %t21
  %t23 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t24 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t25 = load double, double* %l2
  br i1 %t22, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t26 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t27 = load double, double* %l2
  %t28 = call double @llvm.round.f64(double %t27)
  %t29 = fptosi double %t28 to i64
  %t30 = load { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t26
  %t31 = extractvalue { %EffectViolation*, i64 } %t30, 0
  %t32 = extractvalue { %EffectViolation*, i64 } %t30, 1
  %t33 = icmp uge i64 %t29, %t32
  ; bounds check: %t33 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t29, i64 %t32)
  %t34 = getelementptr %EffectViolation, %EffectViolation* %t31, i64 %t29
  %t35 = load %EffectViolation, %EffectViolation* %t34
  store %EffectViolation %t35, %EffectViolation* %l3
  %t36 = sitofp i64 0 to double
  store double %t36, double* %l4
  %t37 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t38 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t39 = load double, double* %l2
  %t40 = load %EffectViolation, %EffectViolation* %l3
  %t41 = load double, double* %l4
  br label %loop.header6
loop.header6:
  %t105 = phi { %Diagnostic*, i64 }* [ %t38, %merge5 ], [ %t103, %loop.latch8 ]
  %t106 = phi double [ %t41, %merge5 ], [ %t104, %loop.latch8 ]
  store { %Diagnostic*, i64 }* %t105, { %Diagnostic*, i64 }** %l1
  store double %t106, double* %l4
  br label %loop.body7
loop.body7:
  %t42 = load double, double* %l4
  %t43 = load %EffectViolation, %EffectViolation* %l3
  %t44 = extractvalue %EffectViolation %t43, 1
  %t45 = load { i8**, i64 }, { i8**, i64 }* %t44
  %t46 = extractvalue { i8**, i64 } %t45, 1
  %t47 = sitofp i64 %t46 to double
  %t48 = fcmp oge double %t42, %t47
  %t49 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t50 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t51 = load double, double* %l2
  %t52 = load %EffectViolation, %EffectViolation* %l3
  %t53 = load double, double* %l4
  br i1 %t48, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t54 = load %EffectViolation, %EffectViolation* %l3
  %t55 = extractvalue %EffectViolation %t54, 1
  %t56 = load double, double* %l4
  %t57 = call double @llvm.round.f64(double %t56)
  %t58 = fptosi double %t57 to i64
  %t59 = load { i8**, i64 }, { i8**, i64 }* %t55
  %t60 = extractvalue { i8**, i64 } %t59, 0
  %t61 = extractvalue { i8**, i64 } %t59, 1
  %t62 = icmp uge i64 %t58, %t61
  ; bounds check: %t62 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t58, i64 %t61)
  %t63 = getelementptr i8*, i8** %t60, i64 %t58
  %t64 = load i8*, i8** %t63
  store i8* %t64, i8** %l5
  %t65 = load %EffectViolation, %EffectViolation* %l3
  %t66 = extractvalue %EffectViolation %t65, 2
  %t67 = load i8*, i8** %l5
  %t68 = bitcast { %EffectRequirement**, i64 }* %t66 to { %EffectRequirement*, i64 }*
  %t69 = call %EffectRequirement* @select_requirement_for_effect({ %EffectRequirement*, i64 }* %t68, i8* %t67)
  store %EffectRequirement* %t69, %EffectRequirement** %l6
  %t70 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %s71 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h902271367, i32 0, i32 0
  %t72 = insertvalue %Diagnostic undef, i8* %s71, 0
  %t73 = load %EffectViolation, %EffectViolation* %l3
  %t74 = extractvalue %EffectViolation %t73, 0
  %t75 = load i8*, i8** %l5
  %t76 = load %EffectRequirement*, %EffectRequirement** %l6
  %t77 = call i8* @format_effect_message(i8* %t74, i8* %t75, %EffectRequirement* %t76)
  %t78 = insertvalue %Diagnostic %t72, i8* %t77, 1
  %t79 = load %EffectRequirement*, %EffectRequirement** %l6
  %t80 = call %Token* @requirement_primary_token(%EffectRequirement* %t79)
  %t81 = insertvalue %Diagnostic %t78, %Token* %t80, 2
  %t82 = call noalias i8* @malloc(i64 24)
  %t83 = bitcast i8* %t82 to %Diagnostic*
  store %Diagnostic %t81, %Diagnostic* %t83
  %t84 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t85 = ptrtoint [1 x i8*]* %t84 to i64
  %t86 = icmp eq i64 %t85, 0
  %t87 = select i1 %t86, i64 1, i64 %t85
  %t88 = call i8* @malloc(i64 %t87)
  %t89 = bitcast i8* %t88 to i8**
  %t90 = getelementptr i8*, i8** %t89, i64 0
  store i8* %t82, i8** %t90
  %t91 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t92 = ptrtoint { i8**, i64 }* %t91 to i64
  %t93 = call i8* @malloc(i64 %t92)
  %t94 = bitcast i8* %t93 to { i8**, i64 }*
  %t95 = getelementptr { i8**, i64 }, { i8**, i64 }* %t94, i32 0, i32 0
  store i8** %t89, i8*** %t95
  %t96 = getelementptr { i8**, i64 }, { i8**, i64 }* %t94, i32 0, i32 1
  store i64 1, i64* %t96
  %t97 = bitcast { %Diagnostic*, i64 }* %t70 to { i8**, i64 }*
  %t98 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t97, { i8**, i64 }* %t94)
  %t99 = bitcast { i8**, i64 }* %t98 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t99, { %Diagnostic*, i64 }** %l1
  %t100 = load double, double* %l4
  %t101 = sitofp i64 1 to double
  %t102 = fadd double %t100, %t101
  store double %t102, double* %l4
  br label %loop.latch8
loop.latch8:
  %t103 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t104 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t107 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t108 = load double, double* %l4
  %t109 = load double, double* %l2
  %t110 = sitofp i64 1 to double
  %t111 = fadd double %t109, %t110
  store double %t111, double* %l2
  br label %loop.latch2
loop.latch2:
  %t112 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t113 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t116 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t117 = load double, double* %l2
  %t118 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t118
}

define %EffectRequirement* @select_requirement_for_effect({ %EffectRequirement*, i64 }* %requirements, i8* %effect) {
block.entry:
  %l0 = alloca double
  %l1 = alloca %EffectRequirement
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t28 = phi double [ %t1, %block.entry ], [ %t27, %loop.latch2 ]
  store double %t28, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %requirements
  %t4 = extractvalue { %EffectRequirement*, i64 } %t3, 1
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
  %t11 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %requirements
  %t12 = extractvalue { %EffectRequirement*, i64 } %t11, 0
  %t13 = extractvalue { %EffectRequirement*, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t10, i64 %t13)
  %t15 = getelementptr %EffectRequirement, %EffectRequirement* %t12, i64 %t10
  %t16 = load %EffectRequirement, %EffectRequirement* %t15
  store %EffectRequirement %t16, %EffectRequirement* %l1
  %t17 = load %EffectRequirement, %EffectRequirement* %l1
  %t18 = extractvalue %EffectRequirement %t17, 0
  %t19 = call i1 @strings_equal(i8* %t18, i8* %effect)
  %t20 = load double, double* %l0
  %t21 = load %EffectRequirement, %EffectRequirement* %l1
  br i1 %t19, label %then6, label %merge7
then6:
  %t22 = load %EffectRequirement, %EffectRequirement* %l1
  %t23 = alloca %EffectRequirement
  store %EffectRequirement %t22, %EffectRequirement* %t23
  ret %EffectRequirement* %t23
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
  %t30 = bitcast i8* null to %EffectRequirement*
  ret %EffectRequirement* %t30
}

define %Token* @requirement_primary_token(%EffectRequirement* %requirement) {
block.entry:
  %t0 = icmp eq %EffectRequirement* %requirement, null
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = bitcast i8* null to %Token*
  ret %Token* %t1
merge1:
  %t2 = getelementptr %EffectRequirement, %EffectRequirement* %requirement, i32 0, i32 1
  %t3 = load %Token*, %Token** %t2
  ret %Token* %t3
}

define i8* @format_effect_message(i8* %routine_name, i8* %effect, %EffectRequirement* %requirement) {
block.entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1863181231, i32 0, i32 0
  %t1 = call i8* @sailfin_runtime_string_concat(i8* %routine_name, i8* %s0)
  %t2 = call i8* @sailfin_runtime_string_concat(i8* %t1, i8* %effect)
  %t3 = alloca [2 x i8], align 1
  %t4 = getelementptr [2 x i8], [2 x i8]* %t3, i32 0, i32 0
  store i8 39, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t3, i32 0, i32 1
  store i8 0, i8* %t5
  %t6 = getelementptr [2 x i8], [2 x i8]* %t3, i32 0, i32 0
  %t7 = call i8* @sailfin_runtime_string_concat(i8* %t2, i8* %t6)
  store i8* %t7, i8** %l0
  %t8 = icmp ne %EffectRequirement* %requirement, null
  %t9 = load i8*, i8** %l0
  br i1 %t8, label %then0, label %merge1
then0:
  %t10 = load i8*, i8** %l0
  %s11 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h980936743, i32 0, i32 0
  %t12 = call i8* @sailfin_runtime_string_concat(i8* %t10, i8* %s11)
  %t13 = getelementptr %EffectRequirement, %EffectRequirement* %requirement, i32 0, i32 2
  %t14 = load i8*, i8** %t13
  %t15 = call i8* @sailfin_runtime_string_concat(i8* %t12, i8* %t14)
  store i8* %t15, i8** %l0
  %t16 = load i8*, i8** %l0
  br label %merge1
merge1:
  %t17 = phi i8* [ %t16, %then0 ], [ %t9, %block.entry ]
  store i8* %t17, i8** %l0
  %t18 = load i8*, i8** %l0
  %s19 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1876709041, i32 0, i32 0
  %t20 = call i8* @sailfin_runtime_string_concat(i8* %t18, i8* %s19)
  %t21 = call i8* @sailfin_runtime_string_concat(i8* %t20, i8* %effect)
  %s22 = getelementptr inbounds [61 x i8], [61 x i8]* @.str.len60.h1899438158, i32 0, i32 0
  %t23 = call i8* @sailfin_runtime_string_concat(i8* %t21, i8* %s22)
  store i8* %t23, i8** %l0
  %t24 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t24)
  ret i8* %t24
}

define i1 @contains_string({ i8**, i64 }* %items, i8* %candidate) {
block.entry:
  %l0 = alloca i64
  %l1 = alloca i8*
  %t0 = getelementptr { i8**, i64 }, { i8**, i64 }* %items, i32 0, i32 1
  %t1 = load i64, i64* %t0
  %t2 = getelementptr { i8**, i64 }, { i8**, i64 }* %items, i32 0, i32 0
  %t3 = load i8**, i8*** %t2
  store i64 0, i64* %l0
  store i8* null, i8** %l1
  br label %for0
for0:
  %t4 = load i64, i64* %l0
  %t5 = icmp slt i64 %t4, %t1
  br i1 %t5, label %forbody1, label %afterfor3
forbody1:
  %t6 = load i64, i64* %l0
  %t7 = getelementptr i8*, i8** %t3, i64 %t6
  %t8 = load i8*, i8** %t7
  store i8* %t8, i8** %l1
  %t9 = load i8*, i8** %l1
  %t10 = call i1 @strings_equal(i8* %t9, i8* %candidate)
  %t11 = load i8*, i8** %l1
  br i1 %t10, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  br label %forinc2
forinc2:
  %t12 = load i64, i64* %l0
  %t13 = add i64 %t12, 1
  store i64 %t13, i64* %l0
  br label %for0
afterfor3:
  ret i1 0
}

define %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %name, i8* %kind, %SourceSpan* %span) {
block.entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %t0 = call i1 @has_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %name)
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1, 0
  %t3 = call %Token* @token_from_name(i8* %name, %SourceSpan* %span)
  %t4 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %name, i8* %kind, %Token* %t3)
  %t5 = call noalias i8* @malloc(i64 24)
  %t6 = bitcast i8* %t5 to %Diagnostic*
  store %Diagnostic %t4, %Diagnostic* %t6
  %t7 = bitcast i8* %t5 to %Diagnostic*
  %t8 = getelementptr [1 x %Diagnostic*], [1 x %Diagnostic*]* null, i32 1
  %t9 = ptrtoint [1 x %Diagnostic*]* %t8 to i64
  %t10 = icmp eq i64 %t9, 0
  %t11 = select i1 %t10, i64 1, i64 %t9
  %t12 = call i8* @malloc(i64 %t11)
  %t13 = bitcast i8* %t12 to %Diagnostic**
  %t14 = getelementptr %Diagnostic*, %Diagnostic** %t13, i64 0
  store %Diagnostic* %t7, %Diagnostic** %t14
  %t15 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* null, i32 1
  %t16 = ptrtoint { %Diagnostic**, i64 }* %t15 to i64
  %t17 = call i8* @malloc(i64 %t16)
  %t18 = bitcast i8* %t17 to { %Diagnostic**, i64 }*
  %t19 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t18, i32 0, i32 0
  store %Diagnostic** %t13, %Diagnostic*** %t19
  %t20 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t18, i32 0, i32 1
  store i64 1, i64* %t20
  %t21 = insertvalue %ScopeResult %t2, { %Diagnostic**, i64 }* %t18, 1
  ret %ScopeResult %t21
merge1:
  %t22 = call { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %name, i8* %kind, %SourceSpan* %span)
  store { %SymbolEntry*, i64 }* %t22, { %SymbolEntry*, i64 }** %l0
  %t23 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t24 = bitcast { %SymbolEntry*, i64 }* %t23 to { %SymbolEntry**, i64 }*
  %t25 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t24, 0
  %t26 = getelementptr [0 x %Diagnostic*], [0 x %Diagnostic*]* null, i32 1
  %t27 = ptrtoint [0 x %Diagnostic*]* %t26 to i64
  %t28 = icmp eq i64 %t27, 0
  %t29 = select i1 %t28, i64 1, i64 %t27
  %t30 = call i8* @malloc(i64 %t29)
  %t31 = bitcast i8* %t30 to %Diagnostic**
  %t32 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* null, i32 1
  %t33 = ptrtoint { %Diagnostic**, i64 }* %t32 to i64
  %t34 = call i8* @malloc(i64 %t33)
  %t35 = bitcast i8* %t34 to { %Diagnostic**, i64 }*
  %t36 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t35, i32 0, i32 0
  store %Diagnostic** %t31, %Diagnostic*** %t36
  %t37 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t35, i32 0, i32 1
  store i64 0, i64* %t37
  %t38 = insertvalue %ScopeResult %t25, { %Diagnostic**, i64 }* %t35, 1
  ret %ScopeResult %t38
}

define %SymbolCollectionResult @register_symbol(i8* %name, i8* %kind, %SourceSpan* %span, { %SymbolEntry*, i64 }* %existing) {
block.entry:
  %t0 = call i1 @has_symbol({ %SymbolEntry*, i64 }* %existing, i8* %name)
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = bitcast { %SymbolEntry*, i64 }* %existing to { %SymbolEntry**, i64 }*
  %t2 = insertvalue %SymbolCollectionResult undef, { %SymbolEntry**, i64 }* %t1, 0
  %t3 = call %Token* @token_from_name(i8* %name, %SourceSpan* %span)
  %t4 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %name, i8* %kind, %Token* %t3)
  %t5 = call noalias i8* @malloc(i64 24)
  %t6 = bitcast i8* %t5 to %Diagnostic*
  store %Diagnostic %t4, %Diagnostic* %t6
  %t7 = bitcast i8* %t5 to %Diagnostic*
  %t8 = getelementptr [1 x %Diagnostic*], [1 x %Diagnostic*]* null, i32 1
  %t9 = ptrtoint [1 x %Diagnostic*]* %t8 to i64
  %t10 = icmp eq i64 %t9, 0
  %t11 = select i1 %t10, i64 1, i64 %t9
  %t12 = call i8* @malloc(i64 %t11)
  %t13 = bitcast i8* %t12 to %Diagnostic**
  %t14 = getelementptr %Diagnostic*, %Diagnostic** %t13, i64 0
  store %Diagnostic* %t7, %Diagnostic** %t14
  %t15 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* null, i32 1
  %t16 = ptrtoint { %Diagnostic**, i64 }* %t15 to i64
  %t17 = call i8* @malloc(i64 %t16)
  %t18 = bitcast i8* %t17 to { %Diagnostic**, i64 }*
  %t19 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t18, i32 0, i32 0
  store %Diagnostic** %t13, %Diagnostic*** %t19
  %t20 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t18, i32 0, i32 1
  store i64 1, i64* %t20
  %t21 = insertvalue %SymbolCollectionResult %t2, { %Diagnostic**, i64 }* %t18, 1
  ret %SymbolCollectionResult %t21
merge1:
  %t22 = call { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %existing, i8* %name, i8* %kind, %SourceSpan* %span)
  %t23 = bitcast { %SymbolEntry*, i64 }* %t22 to { %SymbolEntry**, i64 }*
  %t24 = insertvalue %SymbolCollectionResult undef, { %SymbolEntry**, i64 }* %t23, 0
  %t25 = getelementptr [0 x %Diagnostic*], [0 x %Diagnostic*]* null, i32 1
  %t26 = ptrtoint [0 x %Diagnostic*]* %t25 to i64
  %t27 = icmp eq i64 %t26, 0
  %t28 = select i1 %t27, i64 1, i64 %t26
  %t29 = call i8* @malloc(i64 %t28)
  %t30 = bitcast i8* %t29 to %Diagnostic**
  %t31 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* null, i32 1
  %t32 = ptrtoint { %Diagnostic**, i64 }* %t31 to i64
  %t33 = call i8* @malloc(i64 %t32)
  %t34 = bitcast i8* %t33 to { %Diagnostic**, i64 }*
  %t35 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t34, i32 0, i32 0
  store %Diagnostic** %t30, %Diagnostic*** %t35
  %t36 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t34, i32 0, i32 1
  store i64 0, i64* %t36
  %t37 = insertvalue %SymbolCollectionResult %t24, { %Diagnostic**, i64 }* %t34, 1
  ret %SymbolCollectionResult %t37
}

define { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %symbols, i8* %name, i8* %kind, %SourceSpan* %span) {
block.entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %t0 = call { %SymbolEntry*, i64 }* @clone_bindings({ %SymbolEntry*, i64 }* %symbols)
  store { %SymbolEntry*, i64 }* %t0, { %SymbolEntry*, i64 }** %l0
  %t1 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t2 = insertvalue %SymbolEntry undef, i8* %name, 0
  %t3 = insertvalue %SymbolEntry %t2, i8* %kind, 1
  %t4 = insertvalue %SymbolEntry %t3, %SourceSpan* %span, 2
  %t5 = getelementptr [1 x %SymbolEntry], [1 x %SymbolEntry]* null, i32 1
  %t6 = ptrtoint [1 x %SymbolEntry]* %t5 to i64
  %t7 = icmp eq i64 %t6, 0
  %t8 = select i1 %t7, i64 1, i64 %t6
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to %SymbolEntry*
  %t11 = getelementptr %SymbolEntry, %SymbolEntry* %t10, i64 0
  store %SymbolEntry %t4, %SymbolEntry* %t11
  %t12 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* null, i32 1
  %t13 = ptrtoint { %SymbolEntry*, i64 }* %t12 to i64
  %t14 = call i8* @malloc(i64 %t13)
  %t15 = bitcast i8* %t14 to { %SymbolEntry*, i64 }*
  %t16 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t15, i32 0, i32 0
  store %SymbolEntry* %t10, %SymbolEntry** %t16
  %t17 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t15, i32 0, i32 1
  store i64 1, i64* %t17
  %t18 = bitcast { %SymbolEntry*, i64 }* %t1 to { i8**, i64 }*
  %t19 = bitcast { %SymbolEntry*, i64 }* %t15 to { i8**, i64 }*
  %t20 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t18, { i8**, i64 }* %t19)
  %t21 = bitcast { i8**, i64 }* %t20 to { %SymbolEntry*, i64 }*
  ret { %SymbolEntry*, i64 }* %t21
}

define { %SymbolEntry*, i64 }* @clone_bindings({ %SymbolEntry*, i64 }* %source) {
block.entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca i64
  %l2 = alloca %SymbolEntry
  %t0 = getelementptr [0 x %SymbolEntry], [0 x %SymbolEntry]* null, i32 1
  %t1 = ptrtoint [0 x %SymbolEntry]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %SymbolEntry*
  %t6 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* null, i32 1
  %t7 = ptrtoint { %SymbolEntry*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %SymbolEntry*, i64 }*
  %t10 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t9, i32 0, i32 0
  store %SymbolEntry* %t5, %SymbolEntry** %t10
  %t11 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %SymbolEntry*, i64 }* %t9, { %SymbolEntry*, i64 }** %l0
  %t12 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %source, i32 0, i32 1
  %t13 = load i64, i64* %t12
  %t14 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %source, i32 0, i32 0
  %t15 = load %SymbolEntry*, %SymbolEntry** %t14
  store i64 0, i64* %l1
  store %SymbolEntry zeroinitializer, %SymbolEntry* %l2
  br label %for0
for0:
  %t16 = load i64, i64* %l1
  %t17 = icmp slt i64 %t16, %t13
  br i1 %t17, label %forbody1, label %afterfor3
forbody1:
  %t18 = load i64, i64* %l1
  %t19 = getelementptr %SymbolEntry, %SymbolEntry* %t15, i64 %t18
  %t20 = load %SymbolEntry, %SymbolEntry* %t19
  store %SymbolEntry %t20, %SymbolEntry* %l2
  %t21 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t22 = load %SymbolEntry, %SymbolEntry* %l2
  %t23 = call noalias i8* @malloc(i64 24)
  %t24 = bitcast i8* %t23 to %SymbolEntry*
  store %SymbolEntry %t22, %SymbolEntry* %t24
  %t25 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t26 = ptrtoint [1 x i8*]* %t25 to i64
  %t27 = icmp eq i64 %t26, 0
  %t28 = select i1 %t27, i64 1, i64 %t26
  %t29 = call i8* @malloc(i64 %t28)
  %t30 = bitcast i8* %t29 to i8**
  %t31 = getelementptr i8*, i8** %t30, i64 0
  store i8* %t23, i8** %t31
  %t32 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t33 = ptrtoint { i8**, i64 }* %t32 to i64
  %t34 = call i8* @malloc(i64 %t33)
  %t35 = bitcast i8* %t34 to { i8**, i64 }*
  %t36 = getelementptr { i8**, i64 }, { i8**, i64 }* %t35, i32 0, i32 0
  store i8** %t30, i8*** %t36
  %t37 = getelementptr { i8**, i64 }, { i8**, i64 }* %t35, i32 0, i32 1
  store i64 1, i64* %t37
  %t38 = bitcast { %SymbolEntry*, i64 }* %t21 to { i8**, i64 }*
  %t39 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t38, { i8**, i64 }* %t35)
  %t40 = bitcast { i8**, i64 }* %t39 to { %SymbolEntry*, i64 }*
  store { %SymbolEntry*, i64 }* %t40, { %SymbolEntry*, i64 }** %l0
  br label %forinc2
forinc2:
  %t41 = load i64, i64* %l1
  %t42 = add i64 %t41, 1
  store i64 %t42, i64* %l1
  br label %for0
afterfor3:
  %t43 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t44 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  ret { %SymbolEntry*, i64 }* %t44
}

define i1 @has_symbol({ %SymbolEntry*, i64 }* %symbols, i8* %name) {
block.entry:
  %l0 = alloca i64
  %l1 = alloca %SymbolEntry
  %t0 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %symbols, i32 0, i32 1
  %t1 = load i64, i64* %t0
  %t2 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %symbols, i32 0, i32 0
  %t3 = load %SymbolEntry*, %SymbolEntry** %t2
  store i64 0, i64* %l0
  store %SymbolEntry zeroinitializer, %SymbolEntry* %l1
  br label %for0
for0:
  %t4 = load i64, i64* %l0
  %t5 = icmp slt i64 %t4, %t1
  br i1 %t5, label %forbody1, label %afterfor3
forbody1:
  %t6 = load i64, i64* %l0
  %t7 = getelementptr %SymbolEntry, %SymbolEntry* %t3, i64 %t6
  %t8 = load %SymbolEntry, %SymbolEntry* %t7
  store %SymbolEntry %t8, %SymbolEntry* %l1
  %t9 = load %SymbolEntry, %SymbolEntry* %l1
  %t10 = extractvalue %SymbolEntry %t9, 0
  %t11 = call i1 @strings_equal(i8* %t10, i8* %name)
  %t12 = load %SymbolEntry, %SymbolEntry* %l1
  br i1 %t11, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  br label %forinc2
forinc2:
  %t13 = load i64, i64* %l0
  %t14 = add i64 %t13, 1
  store i64 %t14, i64* %l0
  br label %for0
afterfor3:
  ret i1 0
}

define %Diagnostic @make_interface_missing_type_arguments_diagnostic(i8* %struct_name, i8* %interface_name, i8* %interface_signature) {
block.entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h743728889, i32 0, i32 0
  %t1 = insertvalue %Diagnostic undef, i8* %s0, 0
  %s2 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t3 = call i8* @sailfin_runtime_string_concat(i8* %s2, i8* %struct_name)
  %s4 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h2084565287, i32 0, i32 0
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t3, i8* %s4)
  %t6 = call i8* @sailfin_runtime_string_concat(i8* %t5, i8* %interface_name)
  %s7 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.len18.h1304509209, i32 0, i32 0
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %t6, i8* %s7)
  %t9 = call i8* @sailfin_runtime_string_concat(i8* %t8, i8* %interface_signature)
  %s10 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1487231025, i32 0, i32 0
  %t11 = call i8* @sailfin_runtime_string_concat(i8* %t9, i8* %s10)
  %t12 = insertvalue %Diagnostic %t1, i8* %t11, 1
  %t13 = bitcast i8* null to %Token*
  %t14 = insertvalue %Diagnostic %t12, %Token* %t13, 2
  ret %Diagnostic %t14
}

define %Diagnostic @make_interface_type_argument_mismatch_diagnostic(i8* %struct_name, i8* %annotation_text, i8* %interface_signature) {
block.entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h743728889, i32 0, i32 0
  %t1 = insertvalue %Diagnostic undef, i8* %s0, 0
  %s2 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t3 = call i8* @sailfin_runtime_string_concat(i8* %s2, i8* %struct_name)
  %s4 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h2084565287, i32 0, i32 0
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t3, i8* %s4)
  %t6 = call i8* @sailfin_runtime_string_concat(i8* %t5, i8* %annotation_text)
  %s7 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h302658750, i32 0, i32 0
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %t6, i8* %s7)
  %t9 = call i8* @sailfin_runtime_string_concat(i8* %t8, i8* %interface_signature)
  %s10 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1487231025, i32 0, i32 0
  %t11 = call i8* @sailfin_runtime_string_concat(i8* %t9, i8* %s10)
  %t12 = insertvalue %Diagnostic %t1, i8* %t11, 1
  %t13 = bitcast i8* null to %Token*
  %t14 = insertvalue %Diagnostic %t12, %Token* %t13, 2
  ret %Diagnostic %t14
}

define %Diagnostic @make_interface_no_type_arguments_diagnostic(i8* %struct_name, i8* %annotation_text, i8* %interface_name) {
block.entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h743728889, i32 0, i32 0
  %t1 = insertvalue %Diagnostic undef, i8* %s0, 0
  %s2 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t3 = call i8* @sailfin_runtime_string_concat(i8* %s2, i8* %struct_name)
  %s4 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h2084565287, i32 0, i32 0
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t3, i8* %s4)
  %t6 = call i8* @sailfin_runtime_string_concat(i8* %t5, i8* %annotation_text)
  %s7 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1504944345, i32 0, i32 0
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %t6, i8* %s7)
  %t9 = call i8* @sailfin_runtime_string_concat(i8* %t8, i8* %interface_name)
  %s10 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h85694398, i32 0, i32 0
  %t11 = call i8* @sailfin_runtime_string_concat(i8* %t9, i8* %s10)
  %t12 = insertvalue %Diagnostic %t1, i8* %t11, 1
  %t13 = bitcast i8* null to %Token*
  %t14 = insertvalue %Diagnostic %t12, %Token* %t13, 2
  ret %Diagnostic %t14
}

define %Token* @token_from_name(i8* %name, %SourceSpan* %span) {
block.entry:
  %t0 = icmp eq %SourceSpan* %span, null
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = bitcast i8* null to %Token*
  ret %Token* %t1
merge1:
  %t2 = alloca %TokenKind
  %t3 = getelementptr inbounds %TokenKind, %TokenKind* %t2, i32 0, i32 0
  store i32 0, i32* %t3
  %t4 = getelementptr inbounds %TokenKind, %TokenKind* %t2, i32 0, i32 1
  %t5 = bitcast [8 x i8]* %t4 to i8*
  %t6 = bitcast i8* %t5 to i8**
  store i8* %name, i8** %t6
  %t7 = load %TokenKind, %TokenKind* %t2
  %t8 = insertvalue %Token undef, %TokenKind %t7, 0
  %t9 = insertvalue %Token %t8, i8* %name, 1
  %t10 = getelementptr %SourceSpan, %SourceSpan* %span, i32 0, i32 0
  %t11 = load double, double* %t10
  %t12 = insertvalue %Token %t9, double %t11, 2
  %t13 = getelementptr %SourceSpan, %SourceSpan* %span, i32 0, i32 1
  %t14 = load double, double* %t13
  %t15 = insertvalue %Token %t12, double %t14, 3
  %t16 = alloca %Token
  store %Token %t15, %Token* %t16
  ret %Token* %t16
}

define %Diagnostic @make_duplicate_symbol_diagnostic(i8* %name, i8* %kind, %Token* %token) {
block.entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h743621045, i32 0, i32 0
  %t1 = insertvalue %Diagnostic undef, i8* %s0, 0
  %s2 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h6072819, i32 0, i32 0
  %t3 = call i8* @sailfin_runtime_string_concat(i8* %s2, i8* %kind)
  %s4 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415015, i32 0, i32 0
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t3, i8* %s4)
  %t6 = call i8* @sailfin_runtime_string_concat(i8* %t5, i8* %name)
  %s7 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1855834391, i32 0, i32 0
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %t6, i8* %s7)
  %t9 = insertvalue %Diagnostic %t1, i8* %t8, 1
  %t10 = insertvalue %Diagnostic %t9, %Token* %token, 2
  ret %Diagnostic %t10
}

define %Diagnostic @make_missing_interface_member_diagnostic(i8* %struct_name, i8* %interface_name, i8* %member_name) {
block.entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h743728856, i32 0, i32 0
  %t1 = insertvalue %Diagnostic undef, i8* %s0, 0
  %s2 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t3 = call i8* @sailfin_runtime_string_concat(i8* %s2, i8* %struct_name)
  %s4 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h2084565287, i32 0, i32 0
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t3, i8* %s4)
  %t6 = call i8* @sailfin_runtime_string_concat(i8* %t5, i8* %interface_name)
  %s7 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.len24.h680377687, i32 0, i32 0
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %t6, i8* %s7)
  %t9 = call i8* @sailfin_runtime_string_concat(i8* %t8, i8* %member_name)
  %t10 = alloca [2 x i8], align 1
  %t11 = getelementptr [2 x i8], [2 x i8]* %t10, i32 0, i32 0
  store i8 96, i8* %t11
  %t12 = getelementptr [2 x i8], [2 x i8]* %t10, i32 0, i32 1
  store i8 0, i8* %t12
  %t13 = getelementptr [2 x i8], [2 x i8]* %t10, i32 0, i32 0
  %t14 = call i8* @sailfin_runtime_string_concat(i8* %t9, i8* %t13)
  %t15 = insertvalue %Diagnostic %t1, i8* %t14, 1
  %t16 = bitcast i8* null to %Token*
  %t17 = insertvalue %Diagnostic %t15, %Token* %t16, 2
  ret %Diagnostic %t17
}

define i1 @starts_with(i8* %value, i8* %prefix) {
block.entry:
  %l0 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %prefix)
  %t1 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t2 = icmp sgt i64 %t0, %t1
  br i1 %t2, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l0
  %t4 = load double, double* %l0
  br label %loop.header2
loop.header2:
  %t26 = phi double [ %t4, %merge1 ], [ %t25, %loop.latch4 ]
  store double %t26, double* %l0
  br label %loop.body3
loop.body3:
  %t5 = load double, double* %l0
  %t6 = call i64 @sailfin_runtime_string_length(i8* %prefix)
  %t7 = sitofp i64 %t6 to double
  %t8 = fcmp oge double %t5, %t7
  %t9 = load double, double* %l0
  br i1 %t8, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t10 = load double, double* %l0
  %t11 = call double @llvm.round.f64(double %t10)
  %t12 = fptosi double %t11 to i64
  %t13 = getelementptr i8, i8* %value, i64 %t12
  %t14 = load i8, i8* %t13
  %t15 = load double, double* %l0
  %t16 = call double @llvm.round.f64(double %t15)
  %t17 = fptosi double %t16 to i64
  %t18 = getelementptr i8, i8* %prefix, i64 %t17
  %t19 = load i8, i8* %t18
  %t20 = icmp ne i8 %t14, %t19
  %t21 = load double, double* %l0
  br i1 %t20, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t22 = load double, double* %l0
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l0
  br label %loop.latch4
loop.latch4:
  %t25 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t27 = load double, double* %l0
  ret i1 1
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
@.str.len4.h258014432 = private unnamed_addr constant [5 x i8] c"enum\00"
@.str.len4.h276192845 = private unnamed_addr constant [5 x i8] c"type\00"
@.enum.Statement.InterfaceDeclaration.variant = private unnamed_addr constant [21 x i8] c"InterfaceDeclaration\00"
@.str.len12.h84042670 = private unnamed_addr constant [13 x i8] c"ForStatement\00"
@.str.len16.h2043328844 = private unnamed_addr constant [17 x i8] c"ModelDeclaration\00"
@.enum.Statement.StructDeclaration.variant = private unnamed_addr constant [18 x i8] c"StructDeclaration\00"
@.str.len16.h994638848 = private unnamed_addr constant [17 x i8] c"interface member\00"
@.enum.Statement.ContinueStatement.variant = private unnamed_addr constant [18 x i8] c"ContinueStatement\00"
@.str.len15.h1067284810 = private unnamed_addr constant [16 x i8] c"PromptStatement\00"
@.enum.Statement.BreakStatement.variant = private unnamed_addr constant [15 x i8] c"BreakStatement\00"
@.str.len11.h1566780570 = private unnamed_addr constant [12 x i8] c"IfStatement\00"
@.str.len17.h1842783069 = private unnamed_addr constant [18 x i8] c"StructDeclaration\00"
@.str.len4.h275832617 = private unnamed_addr constant [5 x i8] c"tool\00"
@.str.len19.h479148896 = private unnamed_addr constant [20 x i8] c"PipelineDeclaration\00"
@.enum.Statement.TypeAliasDeclaration.variant = private unnamed_addr constant [21 x i8] c"TypeAliasDeclaration\00"
@.enum.Statement.LoopStatement.variant = private unnamed_addr constant [14 x i8] c"LoopStatement\00"
@.enum.Statement.EnumDeclaration.variant = private unnamed_addr constant [16 x i8] c"EnumDeclaration\00"
@.enum.Statement.VariableDeclaration.variant = private unnamed_addr constant [20 x i8] c"VariableDeclaration\00"
@.enum.Statement.ToolDeclaration.variant = private unnamed_addr constant [16 x i8] c"ToolDeclaration\00"
@.str.len19.h486335986 = private unnamed_addr constant [20 x i8] c"FunctionDeclaration\00"
@.str.len13.h1925822000 = private unnamed_addr constant [14 x i8] c"WithStatement\00"
@.enum.Statement.FunctionDeclaration.variant = private unnamed_addr constant [20 x i8] c"FunctionDeclaration\00"
@.enum.Statement.MatchStatement.variant = private unnamed_addr constant [15 x i8] c"MatchStatement\00"
@.str.len8.h1925814595 = private unnamed_addr constant [9 x i8] c"variable\00"
@.enum.Statement.ModelDeclaration.variant = private unnamed_addr constant [17 x i8] c"ModelDeclaration\00"
@.enum.Statement.ImportDeclaration.variant = private unnamed_addr constant [18 x i8] c"ImportDeclaration\00"
@.enum.Statement.PipelineDeclaration.variant = private unnamed_addr constant [20 x i8] c"PipelineDeclaration\00"
@.enum.Statement.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.str.len20.h1496093543 = private unnamed_addr constant [21 x i8] c"TypeAliasDeclaration\00"
@.enum.Statement.ReturnStatement.variant = private unnamed_addr constant [16 x i8] c"ReturnStatement\00"
@.str.len14.h812083909 = private unnamed_addr constant [15 x i8] c"model property\00"
@.str.len15.h902271367 = private unnamed_addr constant [16 x i8] c"effects.missing\00"
@.str.len8.h1603982015 = private unnamed_addr constant [9 x i8] c"function\00"
@.str.len14.h513489323 = private unnamed_addr constant [15 x i8] c"type parameter\00"
@.str.len8.h2003786807 = private unnamed_addr constant [9 x i8] c"pipeline\00"
@.enum.Statement.WithStatement.variant = private unnamed_addr constant [14 x i8] c"WithStatement\00"
@.str.len14.h196308685 = private unnamed_addr constant [15 x i8] c"MatchStatement\00"
@.str.len4.h275477867 = private unnamed_addr constant [5 x i8] c"test\00"
@.str.len15.h889179835 = private unnamed_addr constant [16 x i8] c"TestDeclaration\00"
@.str.len5.h238194529 = private unnamed_addr constant [6 x i8] c"model\00"
@.enum.Statement.Unknown.variant = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.str.len12.h328844387 = private unnamed_addr constant [13 x i8] c"enum variant\00"
@.str.len19.h1204027478 = private unnamed_addr constant [20 x i8] c"VariableDeclaration\00"
@.enum.Statement.ExpressionStatement.variant = private unnamed_addr constant [20 x i8] c"ExpressionStatement\00"
@.enum.Statement.TestDeclaration.variant = private unnamed_addr constant [16 x i8] c"TestDeclaration\00"
@.str.len20.h666604742 = private unnamed_addr constant [21 x i8] c"InterfaceDeclaration\00"
@.enum.Statement.ExportDeclaration.variant = private unnamed_addr constant [18 x i8] c"ExportDeclaration\00"
@.str.len15.h579804543 = private unnamed_addr constant [16 x i8] c"EnumDeclaration\00"
@.str.len9.h1313193687 = private unnamed_addr constant [10 x i8] c"interface\00"
@.str.len15.h571715647 = private unnamed_addr constant [16 x i8] c"ToolDeclaration\00"
@.str.len9.h1747065903 = private unnamed_addr constant [10 x i8] c"parameter\00"
@.str.len14.h980936743 = private unnamed_addr constant [15 x i8] c"; required by \00"
@.enum.Statement.ForStatement.variant = private unnamed_addr constant [13 x i8] c"ForStatement\00"
@.enum.Statement.IfStatement.variant = private unnamed_addr constant [12 x i8] c"IfStatement\00"
@.str.len6.h1045703541 = private unnamed_addr constant [7 x i8] c"method\00"
@.str.len6.h789690461 = private unnamed_addr constant [7 x i8] c"struct\00"
@.enum.Statement.PromptStatement.variant = private unnamed_addr constant [16 x i8] c"PromptStatement\00"
@.str.len12.h766506979 = private unnamed_addr constant [13 x i8] c"struct field\00"
