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
  %t96 = icmp eq i8* %t94, %s95
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
  %t72 = icmp eq i8* %t70, %s71
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
  %t189 = icmp eq i8* %t187, %s188
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
  %t352 = icmp eq i8* %t350, %s351
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
  %t515 = icmp eq i8* %t513, %s514
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
  %t678 = icmp eq i8* %t676, %s677
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
  %t841 = icmp eq i8* %t839, %s840
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
  %t958 = icmp eq i8* %t956, %s957
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
  %t1075 = icmp eq i8* %t1073, %s1074
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
  %t1238 = icmp eq i8* %t1236, %s1237
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
  %t1401 = icmp eq i8* %t1399, %s1400
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
  %t72 = icmp eq i8* %t70, %s71
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
  %t214 = icmp eq i8* %t212, %s213
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
  %t447 = icmp eq i8* %t445, %s446
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
  %t670 = phi { %Diagnostic**, i64 }* [ %t617, %then4 ], [ %t668, %loop.latch8 ]
  %t671 = phi double [ %t618, %then4 ], [ %t669, %loop.latch8 ]
  store { %Diagnostic**, i64 }* %t670, { %Diagnostic**, i64 }** %l4
  store double %t671, double* %l5
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
  %t646 = fptosi double %t645 to i64
  %t647 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t644
  %t648 = extractvalue { %MethodDeclaration**, i64 } %t647, 0
  %t649 = extractvalue { %MethodDeclaration**, i64 } %t647, 1
  %t650 = icmp uge i64 %t646, %t649
  ; bounds check: %t650 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t646, i64 %t649)
  %t651 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t648, i64 %t646
  %t652 = load %MethodDeclaration*, %MethodDeclaration** %t651
  store %MethodDeclaration* %t652, %MethodDeclaration** %l6
  %t653 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t654 = load %MethodDeclaration*, %MethodDeclaration** %l6
  %t655 = getelementptr %MethodDeclaration, %MethodDeclaration* %t654, i32 0, i32 0
  %t656 = load %FunctionSignature, %FunctionSignature* %t655
  %t657 = load %MethodDeclaration*, %MethodDeclaration** %l6
  %t658 = getelementptr %MethodDeclaration, %MethodDeclaration* %t657, i32 0, i32 1
  %t659 = load %Block, %Block* %t658
  %t660 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t656, %Block %t659, { %Statement*, i64 }* %interfaces)
  %t661 = bitcast { %Diagnostic**, i64 }* %t653 to { i8**, i64 }*
  %t662 = bitcast { %Diagnostic*, i64 }* %t660 to { i8**, i64 }*
  %t663 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t661, { i8**, i64 }* %t662)
  %t664 = bitcast { i8**, i64 }* %t663 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t664, { %Diagnostic**, i64 }** %l4
  %t665 = load double, double* %l5
  %t666 = sitofp i64 1 to double
  %t667 = fadd double %t665, %t666
  store double %t667, double* %l5
  br label %loop.latch8
loop.latch8:
  %t668 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t669 = load double, double* %l5
  br label %loop.header6
afterloop9:
  %t672 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t673 = load double, double* %l5
  %t674 = load %ScopeResult, %ScopeResult* %l3
  %t675 = extractvalue %ScopeResult %t674, 0
  %t676 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t675, 0
  %t677 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t678 = insertvalue %ScopeResult %t676, { %Diagnostic**, i64 }* %t677, 1
  ret %ScopeResult %t678
merge5:
  %t679 = extractvalue %Statement %statement, 0
  %t680 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t681 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t682 = icmp eq i32 %t679, 0
  %t683 = select i1 %t682, i8* %t681, i8* %t680
  %t684 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t685 = icmp eq i32 %t679, 1
  %t686 = select i1 %t685, i8* %t684, i8* %t683
  %t687 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t688 = icmp eq i32 %t679, 2
  %t689 = select i1 %t688, i8* %t687, i8* %t686
  %t690 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t691 = icmp eq i32 %t679, 3
  %t692 = select i1 %t691, i8* %t690, i8* %t689
  %t693 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t694 = icmp eq i32 %t679, 4
  %t695 = select i1 %t694, i8* %t693, i8* %t692
  %t696 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t697 = icmp eq i32 %t679, 5
  %t698 = select i1 %t697, i8* %t696, i8* %t695
  %t699 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t700 = icmp eq i32 %t679, 6
  %t701 = select i1 %t700, i8* %t699, i8* %t698
  %t702 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t703 = icmp eq i32 %t679, 7
  %t704 = select i1 %t703, i8* %t702, i8* %t701
  %t705 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t706 = icmp eq i32 %t679, 8
  %t707 = select i1 %t706, i8* %t705, i8* %t704
  %t708 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t709 = icmp eq i32 %t679, 9
  %t710 = select i1 %t709, i8* %t708, i8* %t707
  %t711 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t712 = icmp eq i32 %t679, 10
  %t713 = select i1 %t712, i8* %t711, i8* %t710
  %t714 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t715 = icmp eq i32 %t679, 11
  %t716 = select i1 %t715, i8* %t714, i8* %t713
  %t717 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t718 = icmp eq i32 %t679, 12
  %t719 = select i1 %t718, i8* %t717, i8* %t716
  %t720 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t721 = icmp eq i32 %t679, 13
  %t722 = select i1 %t721, i8* %t720, i8* %t719
  %t723 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t724 = icmp eq i32 %t679, 14
  %t725 = select i1 %t724, i8* %t723, i8* %t722
  %t726 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t727 = icmp eq i32 %t679, 15
  %t728 = select i1 %t727, i8* %t726, i8* %t725
  %t729 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t730 = icmp eq i32 %t679, 16
  %t731 = select i1 %t730, i8* %t729, i8* %t728
  %t732 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t733 = icmp eq i32 %t679, 17
  %t734 = select i1 %t733, i8* %t732, i8* %t731
  %t735 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t736 = icmp eq i32 %t679, 18
  %t737 = select i1 %t736, i8* %t735, i8* %t734
  %t738 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t739 = icmp eq i32 %t679, 19
  %t740 = select i1 %t739, i8* %t738, i8* %t737
  %t741 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t742 = icmp eq i32 %t679, 20
  %t743 = select i1 %t742, i8* %t741, i8* %t740
  %t744 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t745 = icmp eq i32 %t679, 21
  %t746 = select i1 %t745, i8* %t744, i8* %t743
  %t747 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t748 = icmp eq i32 %t679, 22
  %t749 = select i1 %t748, i8* %t747, i8* %t746
  %s750 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h579804543, i32 0, i32 0
  %t751 = icmp eq i8* %t749, %s750
  br i1 %t751, label %then12, label %merge13
then12:
  %t752 = extractvalue %Statement %statement, 0
  %t753 = alloca %Statement
  store %Statement %statement, %Statement* %t753
  %t754 = getelementptr inbounds %Statement, %Statement* %t753, i32 0, i32 1
  %t755 = bitcast [48 x i8]* %t754 to i8*
  %t756 = bitcast i8* %t755 to i8**
  %t757 = load i8*, i8** %t756
  %t758 = icmp eq i32 %t752, 2
  %t759 = select i1 %t758, i8* %t757, i8* null
  %t760 = getelementptr inbounds %Statement, %Statement* %t753, i32 0, i32 1
  %t761 = bitcast [48 x i8]* %t760 to i8*
  %t762 = bitcast i8* %t761 to i8**
  %t763 = load i8*, i8** %t762
  %t764 = icmp eq i32 %t752, 3
  %t765 = select i1 %t764, i8* %t763, i8* %t759
  %t766 = getelementptr inbounds %Statement, %Statement* %t753, i32 0, i32 1
  %t767 = bitcast [40 x i8]* %t766 to i8*
  %t768 = bitcast i8* %t767 to i8**
  %t769 = load i8*, i8** %t768
  %t770 = icmp eq i32 %t752, 6
  %t771 = select i1 %t770, i8* %t769, i8* %t765
  %t772 = getelementptr inbounds %Statement, %Statement* %t753, i32 0, i32 1
  %t773 = bitcast [56 x i8]* %t772 to i8*
  %t774 = bitcast i8* %t773 to i8**
  %t775 = load i8*, i8** %t774
  %t776 = icmp eq i32 %t752, 8
  %t777 = select i1 %t776, i8* %t775, i8* %t771
  %t778 = getelementptr inbounds %Statement, %Statement* %t753, i32 0, i32 1
  %t779 = bitcast [40 x i8]* %t778 to i8*
  %t780 = bitcast i8* %t779 to i8**
  %t781 = load i8*, i8** %t780
  %t782 = icmp eq i32 %t752, 9
  %t783 = select i1 %t782, i8* %t781, i8* %t777
  %t784 = getelementptr inbounds %Statement, %Statement* %t753, i32 0, i32 1
  %t785 = bitcast [40 x i8]* %t784 to i8*
  %t786 = bitcast i8* %t785 to i8**
  %t787 = load i8*, i8** %t786
  %t788 = icmp eq i32 %t752, 10
  %t789 = select i1 %t788, i8* %t787, i8* %t783
  %t790 = getelementptr inbounds %Statement, %Statement* %t753, i32 0, i32 1
  %t791 = bitcast [40 x i8]* %t790 to i8*
  %t792 = bitcast i8* %t791 to i8**
  %t793 = load i8*, i8** %t792
  %t794 = icmp eq i32 %t752, 11
  %t795 = select i1 %t794, i8* %t793, i8* %t789
  %s796 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h258014432, i32 0, i32 0
  %t797 = extractvalue %Statement %statement, 0
  %t798 = alloca %Statement
  store %Statement %statement, %Statement* %t798
  %t799 = getelementptr inbounds %Statement, %Statement* %t798, i32 0, i32 1
  %t800 = bitcast [48 x i8]* %t799 to i8*
  %t801 = getelementptr inbounds i8, i8* %t800, i64 8
  %t802 = bitcast i8* %t801 to %SourceSpan**
  %t803 = load %SourceSpan*, %SourceSpan** %t802
  %t804 = icmp eq i32 %t797, 3
  %t805 = select i1 %t804, %SourceSpan* %t803, %SourceSpan* null
  %t806 = getelementptr inbounds %Statement, %Statement* %t798, i32 0, i32 1
  %t807 = bitcast [40 x i8]* %t806 to i8*
  %t808 = getelementptr inbounds i8, i8* %t807, i64 8
  %t809 = bitcast i8* %t808 to %SourceSpan**
  %t810 = load %SourceSpan*, %SourceSpan** %t809
  %t811 = icmp eq i32 %t797, 6
  %t812 = select i1 %t811, %SourceSpan* %t810, %SourceSpan* %t805
  %t813 = getelementptr inbounds %Statement, %Statement* %t798, i32 0, i32 1
  %t814 = bitcast [56 x i8]* %t813 to i8*
  %t815 = getelementptr inbounds i8, i8* %t814, i64 8
  %t816 = bitcast i8* %t815 to %SourceSpan**
  %t817 = load %SourceSpan*, %SourceSpan** %t816
  %t818 = icmp eq i32 %t797, 8
  %t819 = select i1 %t818, %SourceSpan* %t817, %SourceSpan* %t812
  %t820 = getelementptr inbounds %Statement, %Statement* %t798, i32 0, i32 1
  %t821 = bitcast [40 x i8]* %t820 to i8*
  %t822 = getelementptr inbounds i8, i8* %t821, i64 8
  %t823 = bitcast i8* %t822 to %SourceSpan**
  %t824 = load %SourceSpan*, %SourceSpan** %t823
  %t825 = icmp eq i32 %t797, 9
  %t826 = select i1 %t825, %SourceSpan* %t824, %SourceSpan* %t819
  %t827 = getelementptr inbounds %Statement, %Statement* %t798, i32 0, i32 1
  %t828 = bitcast [40 x i8]* %t827 to i8*
  %t829 = getelementptr inbounds i8, i8* %t828, i64 8
  %t830 = bitcast i8* %t829 to %SourceSpan**
  %t831 = load %SourceSpan*, %SourceSpan** %t830
  %t832 = icmp eq i32 %t797, 10
  %t833 = select i1 %t832, %SourceSpan* %t831, %SourceSpan* %t826
  %t834 = getelementptr inbounds %Statement, %Statement* %t798, i32 0, i32 1
  %t835 = bitcast [40 x i8]* %t834 to i8*
  %t836 = getelementptr inbounds i8, i8* %t835, i64 8
  %t837 = bitcast i8* %t836 to %SourceSpan**
  %t838 = load %SourceSpan*, %SourceSpan** %t837
  %t839 = icmp eq i32 %t797, 11
  %t840 = select i1 %t839, %SourceSpan* %t838, %SourceSpan* %t833
  %t841 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t795, i8* %s796, %SourceSpan* %t840)
  store %ScopeResult %t841, %ScopeResult* %l7
  %t842 = load %ScopeResult, %ScopeResult* %l7
  %t843 = extractvalue %ScopeResult %t842, 1
  store { %Diagnostic**, i64 }* %t843, { %Diagnostic**, i64 }** %l8
  %t844 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l8
  %t845 = extractvalue %Statement %statement, 0
  %t846 = alloca %Statement
  store %Statement %statement, %Statement* %t846
  %t847 = getelementptr inbounds %Statement, %Statement* %t846, i32 0, i32 1
  %t848 = bitcast [56 x i8]* %t847 to i8*
  %t849 = getelementptr inbounds i8, i8* %t848, i64 16
  %t850 = bitcast i8* %t849 to { %TypeParameter**, i64 }**
  %t851 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t850
  %t852 = icmp eq i32 %t845, 8
  %t853 = select i1 %t852, { %TypeParameter**, i64 }* %t851, { %TypeParameter**, i64 }* null
  %t854 = getelementptr inbounds %Statement, %Statement* %t846, i32 0, i32 1
  %t855 = bitcast [40 x i8]* %t854 to i8*
  %t856 = getelementptr inbounds i8, i8* %t855, i64 16
  %t857 = bitcast i8* %t856 to { %TypeParameter**, i64 }**
  %t858 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t857
  %t859 = icmp eq i32 %t845, 9
  %t860 = select i1 %t859, { %TypeParameter**, i64 }* %t858, { %TypeParameter**, i64 }* %t853
  %t861 = getelementptr inbounds %Statement, %Statement* %t846, i32 0, i32 1
  %t862 = bitcast [40 x i8]* %t861 to i8*
  %t863 = getelementptr inbounds i8, i8* %t862, i64 16
  %t864 = bitcast i8* %t863 to { %TypeParameter**, i64 }**
  %t865 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t864
  %t866 = icmp eq i32 %t845, 10
  %t867 = select i1 %t866, { %TypeParameter**, i64 }* %t865, { %TypeParameter**, i64 }* %t860
  %t868 = getelementptr inbounds %Statement, %Statement* %t846, i32 0, i32 1
  %t869 = bitcast [40 x i8]* %t868 to i8*
  %t870 = getelementptr inbounds i8, i8* %t869, i64 16
  %t871 = bitcast i8* %t870 to { %TypeParameter**, i64 }**
  %t872 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t871
  %t873 = icmp eq i32 %t845, 11
  %t874 = select i1 %t873, { %TypeParameter**, i64 }* %t872, { %TypeParameter**, i64 }* %t867
  %t875 = bitcast { %TypeParameter**, i64 }* %t874 to { %TypeParameter*, i64 }*
  %t876 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t875)
  %t877 = bitcast { %Diagnostic**, i64 }* %t844 to { i8**, i64 }*
  %t878 = bitcast { %Diagnostic*, i64 }* %t876 to { i8**, i64 }*
  %t879 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t877, { i8**, i64 }* %t878)
  %t880 = bitcast { i8**, i64 }* %t879 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t880, { %Diagnostic**, i64 }** %l8
  %t881 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l8
  %t882 = extractvalue %Statement %statement, 0
  %t883 = alloca %Statement
  store %Statement %statement, %Statement* %t883
  %t884 = getelementptr inbounds %Statement, %Statement* %t883, i32 0, i32 1
  %t885 = bitcast [40 x i8]* %t884 to i8*
  %t886 = getelementptr inbounds i8, i8* %t885, i64 24
  %t887 = bitcast i8* %t886 to { %EnumVariant**, i64 }**
  %t888 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t887
  %t889 = icmp eq i32 %t882, 11
  %t890 = select i1 %t889, { %EnumVariant**, i64 }* %t888, { %EnumVariant**, i64 }* null
  %t891 = bitcast { %EnumVariant**, i64 }* %t890 to { %EnumVariant*, i64 }*
  %t892 = call { %Diagnostic*, i64 }* @check_enum_variants({ %EnumVariant*, i64 }* %t891)
  %t893 = bitcast { %Diagnostic**, i64 }* %t881 to { i8**, i64 }*
  %t894 = bitcast { %Diagnostic*, i64 }* %t892 to { i8**, i64 }*
  %t895 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t893, { i8**, i64 }* %t894)
  %t896 = bitcast { i8**, i64 }* %t895 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t896, { %Diagnostic**, i64 }** %l8
  %t897 = load %ScopeResult, %ScopeResult* %l7
  %t898 = extractvalue %ScopeResult %t897, 0
  %t899 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t898, 0
  %t900 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l8
  %t901 = insertvalue %ScopeResult %t899, { %Diagnostic**, i64 }* %t900, 1
  ret %ScopeResult %t901
merge13:
  %t902 = extractvalue %Statement %statement, 0
  %t903 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t904 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t905 = icmp eq i32 %t902, 0
  %t906 = select i1 %t905, i8* %t904, i8* %t903
  %t907 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t908 = icmp eq i32 %t902, 1
  %t909 = select i1 %t908, i8* %t907, i8* %t906
  %t910 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t911 = icmp eq i32 %t902, 2
  %t912 = select i1 %t911, i8* %t910, i8* %t909
  %t913 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t914 = icmp eq i32 %t902, 3
  %t915 = select i1 %t914, i8* %t913, i8* %t912
  %t916 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t917 = icmp eq i32 %t902, 4
  %t918 = select i1 %t917, i8* %t916, i8* %t915
  %t919 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t920 = icmp eq i32 %t902, 5
  %t921 = select i1 %t920, i8* %t919, i8* %t918
  %t922 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t923 = icmp eq i32 %t902, 6
  %t924 = select i1 %t923, i8* %t922, i8* %t921
  %t925 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t926 = icmp eq i32 %t902, 7
  %t927 = select i1 %t926, i8* %t925, i8* %t924
  %t928 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t929 = icmp eq i32 %t902, 8
  %t930 = select i1 %t929, i8* %t928, i8* %t927
  %t931 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t932 = icmp eq i32 %t902, 9
  %t933 = select i1 %t932, i8* %t931, i8* %t930
  %t934 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t935 = icmp eq i32 %t902, 10
  %t936 = select i1 %t935, i8* %t934, i8* %t933
  %t937 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t938 = icmp eq i32 %t902, 11
  %t939 = select i1 %t938, i8* %t937, i8* %t936
  %t940 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t941 = icmp eq i32 %t902, 12
  %t942 = select i1 %t941, i8* %t940, i8* %t939
  %t943 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t944 = icmp eq i32 %t902, 13
  %t945 = select i1 %t944, i8* %t943, i8* %t942
  %t946 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t947 = icmp eq i32 %t902, 14
  %t948 = select i1 %t947, i8* %t946, i8* %t945
  %t949 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t950 = icmp eq i32 %t902, 15
  %t951 = select i1 %t950, i8* %t949, i8* %t948
  %t952 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t953 = icmp eq i32 %t902, 16
  %t954 = select i1 %t953, i8* %t952, i8* %t951
  %t955 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t956 = icmp eq i32 %t902, 17
  %t957 = select i1 %t956, i8* %t955, i8* %t954
  %t958 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t959 = icmp eq i32 %t902, 18
  %t960 = select i1 %t959, i8* %t958, i8* %t957
  %t961 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t962 = icmp eq i32 %t902, 19
  %t963 = select i1 %t962, i8* %t961, i8* %t960
  %t964 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t965 = icmp eq i32 %t902, 20
  %t966 = select i1 %t965, i8* %t964, i8* %t963
  %t967 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t968 = icmp eq i32 %t902, 21
  %t969 = select i1 %t968, i8* %t967, i8* %t966
  %t970 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t971 = icmp eq i32 %t902, 22
  %t972 = select i1 %t971, i8* %t970, i8* %t969
  %s973 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h666604742, i32 0, i32 0
  %t974 = icmp eq i8* %t972, %s973
  br i1 %t974, label %then14, label %merge15
then14:
  %t975 = extractvalue %Statement %statement, 0
  %t976 = alloca %Statement
  store %Statement %statement, %Statement* %t976
  %t977 = getelementptr inbounds %Statement, %Statement* %t976, i32 0, i32 1
  %t978 = bitcast [48 x i8]* %t977 to i8*
  %t979 = bitcast i8* %t978 to i8**
  %t980 = load i8*, i8** %t979
  %t981 = icmp eq i32 %t975, 2
  %t982 = select i1 %t981, i8* %t980, i8* null
  %t983 = getelementptr inbounds %Statement, %Statement* %t976, i32 0, i32 1
  %t984 = bitcast [48 x i8]* %t983 to i8*
  %t985 = bitcast i8* %t984 to i8**
  %t986 = load i8*, i8** %t985
  %t987 = icmp eq i32 %t975, 3
  %t988 = select i1 %t987, i8* %t986, i8* %t982
  %t989 = getelementptr inbounds %Statement, %Statement* %t976, i32 0, i32 1
  %t990 = bitcast [40 x i8]* %t989 to i8*
  %t991 = bitcast i8* %t990 to i8**
  %t992 = load i8*, i8** %t991
  %t993 = icmp eq i32 %t975, 6
  %t994 = select i1 %t993, i8* %t992, i8* %t988
  %t995 = getelementptr inbounds %Statement, %Statement* %t976, i32 0, i32 1
  %t996 = bitcast [56 x i8]* %t995 to i8*
  %t997 = bitcast i8* %t996 to i8**
  %t998 = load i8*, i8** %t997
  %t999 = icmp eq i32 %t975, 8
  %t1000 = select i1 %t999, i8* %t998, i8* %t994
  %t1001 = getelementptr inbounds %Statement, %Statement* %t976, i32 0, i32 1
  %t1002 = bitcast [40 x i8]* %t1001 to i8*
  %t1003 = bitcast i8* %t1002 to i8**
  %t1004 = load i8*, i8** %t1003
  %t1005 = icmp eq i32 %t975, 9
  %t1006 = select i1 %t1005, i8* %t1004, i8* %t1000
  %t1007 = getelementptr inbounds %Statement, %Statement* %t976, i32 0, i32 1
  %t1008 = bitcast [40 x i8]* %t1007 to i8*
  %t1009 = bitcast i8* %t1008 to i8**
  %t1010 = load i8*, i8** %t1009
  %t1011 = icmp eq i32 %t975, 10
  %t1012 = select i1 %t1011, i8* %t1010, i8* %t1006
  %t1013 = getelementptr inbounds %Statement, %Statement* %t976, i32 0, i32 1
  %t1014 = bitcast [40 x i8]* %t1013 to i8*
  %t1015 = bitcast i8* %t1014 to i8**
  %t1016 = load i8*, i8** %t1015
  %t1017 = icmp eq i32 %t975, 11
  %t1018 = select i1 %t1017, i8* %t1016, i8* %t1012
  %s1019 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1313193687, i32 0, i32 0
  %t1020 = extractvalue %Statement %statement, 0
  %t1021 = alloca %Statement
  store %Statement %statement, %Statement* %t1021
  %t1022 = getelementptr inbounds %Statement, %Statement* %t1021, i32 0, i32 1
  %t1023 = bitcast [48 x i8]* %t1022 to i8*
  %t1024 = getelementptr inbounds i8, i8* %t1023, i64 8
  %t1025 = bitcast i8* %t1024 to %SourceSpan**
  %t1026 = load %SourceSpan*, %SourceSpan** %t1025
  %t1027 = icmp eq i32 %t1020, 3
  %t1028 = select i1 %t1027, %SourceSpan* %t1026, %SourceSpan* null
  %t1029 = getelementptr inbounds %Statement, %Statement* %t1021, i32 0, i32 1
  %t1030 = bitcast [40 x i8]* %t1029 to i8*
  %t1031 = getelementptr inbounds i8, i8* %t1030, i64 8
  %t1032 = bitcast i8* %t1031 to %SourceSpan**
  %t1033 = load %SourceSpan*, %SourceSpan** %t1032
  %t1034 = icmp eq i32 %t1020, 6
  %t1035 = select i1 %t1034, %SourceSpan* %t1033, %SourceSpan* %t1028
  %t1036 = getelementptr inbounds %Statement, %Statement* %t1021, i32 0, i32 1
  %t1037 = bitcast [56 x i8]* %t1036 to i8*
  %t1038 = getelementptr inbounds i8, i8* %t1037, i64 8
  %t1039 = bitcast i8* %t1038 to %SourceSpan**
  %t1040 = load %SourceSpan*, %SourceSpan** %t1039
  %t1041 = icmp eq i32 %t1020, 8
  %t1042 = select i1 %t1041, %SourceSpan* %t1040, %SourceSpan* %t1035
  %t1043 = getelementptr inbounds %Statement, %Statement* %t1021, i32 0, i32 1
  %t1044 = bitcast [40 x i8]* %t1043 to i8*
  %t1045 = getelementptr inbounds i8, i8* %t1044, i64 8
  %t1046 = bitcast i8* %t1045 to %SourceSpan**
  %t1047 = load %SourceSpan*, %SourceSpan** %t1046
  %t1048 = icmp eq i32 %t1020, 9
  %t1049 = select i1 %t1048, %SourceSpan* %t1047, %SourceSpan* %t1042
  %t1050 = getelementptr inbounds %Statement, %Statement* %t1021, i32 0, i32 1
  %t1051 = bitcast [40 x i8]* %t1050 to i8*
  %t1052 = getelementptr inbounds i8, i8* %t1051, i64 8
  %t1053 = bitcast i8* %t1052 to %SourceSpan**
  %t1054 = load %SourceSpan*, %SourceSpan** %t1053
  %t1055 = icmp eq i32 %t1020, 10
  %t1056 = select i1 %t1055, %SourceSpan* %t1054, %SourceSpan* %t1049
  %t1057 = getelementptr inbounds %Statement, %Statement* %t1021, i32 0, i32 1
  %t1058 = bitcast [40 x i8]* %t1057 to i8*
  %t1059 = getelementptr inbounds i8, i8* %t1058, i64 8
  %t1060 = bitcast i8* %t1059 to %SourceSpan**
  %t1061 = load %SourceSpan*, %SourceSpan** %t1060
  %t1062 = icmp eq i32 %t1020, 11
  %t1063 = select i1 %t1062, %SourceSpan* %t1061, %SourceSpan* %t1056
  %t1064 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1018, i8* %s1019, %SourceSpan* %t1063)
  store %ScopeResult %t1064, %ScopeResult* %l9
  %t1065 = load %ScopeResult, %ScopeResult* %l9
  %t1066 = extractvalue %ScopeResult %t1065, 1
  store { %Diagnostic**, i64 }* %t1066, { %Diagnostic**, i64 }** %l10
  %t1067 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l10
  %t1068 = extractvalue %Statement %statement, 0
  %t1069 = alloca %Statement
  store %Statement %statement, %Statement* %t1069
  %t1070 = getelementptr inbounds %Statement, %Statement* %t1069, i32 0, i32 1
  %t1071 = bitcast [56 x i8]* %t1070 to i8*
  %t1072 = getelementptr inbounds i8, i8* %t1071, i64 16
  %t1073 = bitcast i8* %t1072 to { %TypeParameter**, i64 }**
  %t1074 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1073
  %t1075 = icmp eq i32 %t1068, 8
  %t1076 = select i1 %t1075, { %TypeParameter**, i64 }* %t1074, { %TypeParameter**, i64 }* null
  %t1077 = getelementptr inbounds %Statement, %Statement* %t1069, i32 0, i32 1
  %t1078 = bitcast [40 x i8]* %t1077 to i8*
  %t1079 = getelementptr inbounds i8, i8* %t1078, i64 16
  %t1080 = bitcast i8* %t1079 to { %TypeParameter**, i64 }**
  %t1081 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1080
  %t1082 = icmp eq i32 %t1068, 9
  %t1083 = select i1 %t1082, { %TypeParameter**, i64 }* %t1081, { %TypeParameter**, i64 }* %t1076
  %t1084 = getelementptr inbounds %Statement, %Statement* %t1069, i32 0, i32 1
  %t1085 = bitcast [40 x i8]* %t1084 to i8*
  %t1086 = getelementptr inbounds i8, i8* %t1085, i64 16
  %t1087 = bitcast i8* %t1086 to { %TypeParameter**, i64 }**
  %t1088 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1087
  %t1089 = icmp eq i32 %t1068, 10
  %t1090 = select i1 %t1089, { %TypeParameter**, i64 }* %t1088, { %TypeParameter**, i64 }* %t1083
  %t1091 = getelementptr inbounds %Statement, %Statement* %t1069, i32 0, i32 1
  %t1092 = bitcast [40 x i8]* %t1091 to i8*
  %t1093 = getelementptr inbounds i8, i8* %t1092, i64 16
  %t1094 = bitcast i8* %t1093 to { %TypeParameter**, i64 }**
  %t1095 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1094
  %t1096 = icmp eq i32 %t1068, 11
  %t1097 = select i1 %t1096, { %TypeParameter**, i64 }* %t1095, { %TypeParameter**, i64 }* %t1090
  %t1098 = bitcast { %TypeParameter**, i64 }* %t1097 to { %TypeParameter*, i64 }*
  %t1099 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t1098)
  %t1100 = bitcast { %Diagnostic**, i64 }* %t1067 to { i8**, i64 }*
  %t1101 = bitcast { %Diagnostic*, i64 }* %t1099 to { i8**, i64 }*
  %t1102 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1100, { i8**, i64 }* %t1101)
  %t1103 = bitcast { i8**, i64 }* %t1102 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1103, { %Diagnostic**, i64 }** %l10
  %t1104 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l10
  %t1105 = extractvalue %Statement %statement, 0
  %t1106 = alloca %Statement
  store %Statement %statement, %Statement* %t1106
  %t1107 = getelementptr inbounds %Statement, %Statement* %t1106, i32 0, i32 1
  %t1108 = bitcast [40 x i8]* %t1107 to i8*
  %t1109 = getelementptr inbounds i8, i8* %t1108, i64 24
  %t1110 = bitcast i8* %t1109 to { %FunctionSignature**, i64 }**
  %t1111 = load { %FunctionSignature**, i64 }*, { %FunctionSignature**, i64 }** %t1110
  %t1112 = icmp eq i32 %t1105, 10
  %t1113 = select i1 %t1112, { %FunctionSignature**, i64 }* %t1111, { %FunctionSignature**, i64 }* null
  %t1114 = bitcast { %FunctionSignature**, i64 }* %t1113 to { %FunctionSignature*, i64 }*
  %t1115 = call { %Diagnostic*, i64 }* @check_interface_members({ %FunctionSignature*, i64 }* %t1114)
  %t1116 = bitcast { %Diagnostic**, i64 }* %t1104 to { i8**, i64 }*
  %t1117 = bitcast { %Diagnostic*, i64 }* %t1115 to { i8**, i64 }*
  %t1118 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1116, { i8**, i64 }* %t1117)
  %t1119 = bitcast { i8**, i64 }* %t1118 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1119, { %Diagnostic**, i64 }** %l10
  %t1120 = load %ScopeResult, %ScopeResult* %l9
  %t1121 = extractvalue %ScopeResult %t1120, 0
  %t1122 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1121, 0
  %t1123 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l10
  %t1124 = insertvalue %ScopeResult %t1122, { %Diagnostic**, i64 }* %t1123, 1
  ret %ScopeResult %t1124
merge15:
  %t1125 = extractvalue %Statement %statement, 0
  %t1126 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1127 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1128 = icmp eq i32 %t1125, 0
  %t1129 = select i1 %t1128, i8* %t1127, i8* %t1126
  %t1130 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1131 = icmp eq i32 %t1125, 1
  %t1132 = select i1 %t1131, i8* %t1130, i8* %t1129
  %t1133 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1134 = icmp eq i32 %t1125, 2
  %t1135 = select i1 %t1134, i8* %t1133, i8* %t1132
  %t1136 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1137 = icmp eq i32 %t1125, 3
  %t1138 = select i1 %t1137, i8* %t1136, i8* %t1135
  %t1139 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1140 = icmp eq i32 %t1125, 4
  %t1141 = select i1 %t1140, i8* %t1139, i8* %t1138
  %t1142 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1143 = icmp eq i32 %t1125, 5
  %t1144 = select i1 %t1143, i8* %t1142, i8* %t1141
  %t1145 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1146 = icmp eq i32 %t1125, 6
  %t1147 = select i1 %t1146, i8* %t1145, i8* %t1144
  %t1148 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1149 = icmp eq i32 %t1125, 7
  %t1150 = select i1 %t1149, i8* %t1148, i8* %t1147
  %t1151 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1152 = icmp eq i32 %t1125, 8
  %t1153 = select i1 %t1152, i8* %t1151, i8* %t1150
  %t1154 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1155 = icmp eq i32 %t1125, 9
  %t1156 = select i1 %t1155, i8* %t1154, i8* %t1153
  %t1157 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1158 = icmp eq i32 %t1125, 10
  %t1159 = select i1 %t1158, i8* %t1157, i8* %t1156
  %t1160 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1161 = icmp eq i32 %t1125, 11
  %t1162 = select i1 %t1161, i8* %t1160, i8* %t1159
  %t1163 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1164 = icmp eq i32 %t1125, 12
  %t1165 = select i1 %t1164, i8* %t1163, i8* %t1162
  %t1166 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1167 = icmp eq i32 %t1125, 13
  %t1168 = select i1 %t1167, i8* %t1166, i8* %t1165
  %t1169 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1170 = icmp eq i32 %t1125, 14
  %t1171 = select i1 %t1170, i8* %t1169, i8* %t1168
  %t1172 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1173 = icmp eq i32 %t1125, 15
  %t1174 = select i1 %t1173, i8* %t1172, i8* %t1171
  %t1175 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1176 = icmp eq i32 %t1125, 16
  %t1177 = select i1 %t1176, i8* %t1175, i8* %t1174
  %t1178 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1179 = icmp eq i32 %t1125, 17
  %t1180 = select i1 %t1179, i8* %t1178, i8* %t1177
  %t1181 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1182 = icmp eq i32 %t1125, 18
  %t1183 = select i1 %t1182, i8* %t1181, i8* %t1180
  %t1184 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1185 = icmp eq i32 %t1125, 19
  %t1186 = select i1 %t1185, i8* %t1184, i8* %t1183
  %t1187 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1188 = icmp eq i32 %t1125, 20
  %t1189 = select i1 %t1188, i8* %t1187, i8* %t1186
  %t1190 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1191 = icmp eq i32 %t1125, 21
  %t1192 = select i1 %t1191, i8* %t1190, i8* %t1189
  %t1193 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1194 = icmp eq i32 %t1125, 22
  %t1195 = select i1 %t1194, i8* %t1193, i8* %t1192
  %s1196 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h2043328844, i32 0, i32 0
  %t1197 = icmp eq i8* %t1195, %s1196
  br i1 %t1197, label %then16, label %merge17
then16:
  %t1198 = extractvalue %Statement %statement, 0
  %t1199 = alloca %Statement
  store %Statement %statement, %Statement* %t1199
  %t1200 = getelementptr inbounds %Statement, %Statement* %t1199, i32 0, i32 1
  %t1201 = bitcast [48 x i8]* %t1200 to i8*
  %t1202 = bitcast i8* %t1201 to i8**
  %t1203 = load i8*, i8** %t1202
  %t1204 = icmp eq i32 %t1198, 2
  %t1205 = select i1 %t1204, i8* %t1203, i8* null
  %t1206 = getelementptr inbounds %Statement, %Statement* %t1199, i32 0, i32 1
  %t1207 = bitcast [48 x i8]* %t1206 to i8*
  %t1208 = bitcast i8* %t1207 to i8**
  %t1209 = load i8*, i8** %t1208
  %t1210 = icmp eq i32 %t1198, 3
  %t1211 = select i1 %t1210, i8* %t1209, i8* %t1205
  %t1212 = getelementptr inbounds %Statement, %Statement* %t1199, i32 0, i32 1
  %t1213 = bitcast [40 x i8]* %t1212 to i8*
  %t1214 = bitcast i8* %t1213 to i8**
  %t1215 = load i8*, i8** %t1214
  %t1216 = icmp eq i32 %t1198, 6
  %t1217 = select i1 %t1216, i8* %t1215, i8* %t1211
  %t1218 = getelementptr inbounds %Statement, %Statement* %t1199, i32 0, i32 1
  %t1219 = bitcast [56 x i8]* %t1218 to i8*
  %t1220 = bitcast i8* %t1219 to i8**
  %t1221 = load i8*, i8** %t1220
  %t1222 = icmp eq i32 %t1198, 8
  %t1223 = select i1 %t1222, i8* %t1221, i8* %t1217
  %t1224 = getelementptr inbounds %Statement, %Statement* %t1199, i32 0, i32 1
  %t1225 = bitcast [40 x i8]* %t1224 to i8*
  %t1226 = bitcast i8* %t1225 to i8**
  %t1227 = load i8*, i8** %t1226
  %t1228 = icmp eq i32 %t1198, 9
  %t1229 = select i1 %t1228, i8* %t1227, i8* %t1223
  %t1230 = getelementptr inbounds %Statement, %Statement* %t1199, i32 0, i32 1
  %t1231 = bitcast [40 x i8]* %t1230 to i8*
  %t1232 = bitcast i8* %t1231 to i8**
  %t1233 = load i8*, i8** %t1232
  %t1234 = icmp eq i32 %t1198, 10
  %t1235 = select i1 %t1234, i8* %t1233, i8* %t1229
  %t1236 = getelementptr inbounds %Statement, %Statement* %t1199, i32 0, i32 1
  %t1237 = bitcast [40 x i8]* %t1236 to i8*
  %t1238 = bitcast i8* %t1237 to i8**
  %t1239 = load i8*, i8** %t1238
  %t1240 = icmp eq i32 %t1198, 11
  %t1241 = select i1 %t1240, i8* %t1239, i8* %t1235
  %s1242 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h238194529, i32 0, i32 0
  %t1243 = extractvalue %Statement %statement, 0
  %t1244 = alloca %Statement
  store %Statement %statement, %Statement* %t1244
  %t1245 = getelementptr inbounds %Statement, %Statement* %t1244, i32 0, i32 1
  %t1246 = bitcast [48 x i8]* %t1245 to i8*
  %t1247 = getelementptr inbounds i8, i8* %t1246, i64 8
  %t1248 = bitcast i8* %t1247 to %SourceSpan**
  %t1249 = load %SourceSpan*, %SourceSpan** %t1248
  %t1250 = icmp eq i32 %t1243, 3
  %t1251 = select i1 %t1250, %SourceSpan* %t1249, %SourceSpan* null
  %t1252 = getelementptr inbounds %Statement, %Statement* %t1244, i32 0, i32 1
  %t1253 = bitcast [40 x i8]* %t1252 to i8*
  %t1254 = getelementptr inbounds i8, i8* %t1253, i64 8
  %t1255 = bitcast i8* %t1254 to %SourceSpan**
  %t1256 = load %SourceSpan*, %SourceSpan** %t1255
  %t1257 = icmp eq i32 %t1243, 6
  %t1258 = select i1 %t1257, %SourceSpan* %t1256, %SourceSpan* %t1251
  %t1259 = getelementptr inbounds %Statement, %Statement* %t1244, i32 0, i32 1
  %t1260 = bitcast [56 x i8]* %t1259 to i8*
  %t1261 = getelementptr inbounds i8, i8* %t1260, i64 8
  %t1262 = bitcast i8* %t1261 to %SourceSpan**
  %t1263 = load %SourceSpan*, %SourceSpan** %t1262
  %t1264 = icmp eq i32 %t1243, 8
  %t1265 = select i1 %t1264, %SourceSpan* %t1263, %SourceSpan* %t1258
  %t1266 = getelementptr inbounds %Statement, %Statement* %t1244, i32 0, i32 1
  %t1267 = bitcast [40 x i8]* %t1266 to i8*
  %t1268 = getelementptr inbounds i8, i8* %t1267, i64 8
  %t1269 = bitcast i8* %t1268 to %SourceSpan**
  %t1270 = load %SourceSpan*, %SourceSpan** %t1269
  %t1271 = icmp eq i32 %t1243, 9
  %t1272 = select i1 %t1271, %SourceSpan* %t1270, %SourceSpan* %t1265
  %t1273 = getelementptr inbounds %Statement, %Statement* %t1244, i32 0, i32 1
  %t1274 = bitcast [40 x i8]* %t1273 to i8*
  %t1275 = getelementptr inbounds i8, i8* %t1274, i64 8
  %t1276 = bitcast i8* %t1275 to %SourceSpan**
  %t1277 = load %SourceSpan*, %SourceSpan** %t1276
  %t1278 = icmp eq i32 %t1243, 10
  %t1279 = select i1 %t1278, %SourceSpan* %t1277, %SourceSpan* %t1272
  %t1280 = getelementptr inbounds %Statement, %Statement* %t1244, i32 0, i32 1
  %t1281 = bitcast [40 x i8]* %t1280 to i8*
  %t1282 = getelementptr inbounds i8, i8* %t1281, i64 8
  %t1283 = bitcast i8* %t1282 to %SourceSpan**
  %t1284 = load %SourceSpan*, %SourceSpan** %t1283
  %t1285 = icmp eq i32 %t1243, 11
  %t1286 = select i1 %t1285, %SourceSpan* %t1284, %SourceSpan* %t1279
  %t1287 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1241, i8* %s1242, %SourceSpan* %t1286)
  store %ScopeResult %t1287, %ScopeResult* %l11
  %t1288 = load %ScopeResult, %ScopeResult* %l11
  %t1289 = extractvalue %ScopeResult %t1288, 1
  %t1290 = extractvalue %Statement %statement, 0
  %t1291 = alloca %Statement
  store %Statement %statement, %Statement* %t1291
  %t1292 = getelementptr inbounds %Statement, %Statement* %t1291, i32 0, i32 1
  %t1293 = bitcast [48 x i8]* %t1292 to i8*
  %t1294 = getelementptr inbounds i8, i8* %t1293, i64 24
  %t1295 = bitcast i8* %t1294 to { %ModelProperty**, i64 }**
  %t1296 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1295
  %t1297 = icmp eq i32 %t1290, 3
  %t1298 = select i1 %t1297, { %ModelProperty**, i64 }* %t1296, { %ModelProperty**, i64 }* null
  %t1299 = bitcast { %ModelProperty**, i64 }* %t1298 to { %ModelProperty*, i64 }*
  %t1300 = call { %Diagnostic*, i64 }* @check_model_properties({ %ModelProperty*, i64 }* %t1299)
  %t1301 = bitcast { %Diagnostic**, i64 }* %t1289 to { i8**, i64 }*
  %t1302 = bitcast { %Diagnostic*, i64 }* %t1300 to { i8**, i64 }*
  %t1303 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1301, { i8**, i64 }* %t1302)
  store { i8**, i64 }* %t1303, { i8**, i64 }** %l12
  %t1304 = load %ScopeResult, %ScopeResult* %l11
  %t1305 = extractvalue %ScopeResult %t1304, 0
  %t1306 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1305, 0
  %t1307 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %t1308 = bitcast { i8**, i64 }* %t1307 to { %Diagnostic**, i64 }*
  %t1309 = insertvalue %ScopeResult %t1306, { %Diagnostic**, i64 }* %t1308, 1
  ret %ScopeResult %t1309
merge17:
  %t1310 = extractvalue %Statement %statement, 0
  %t1311 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1312 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1313 = icmp eq i32 %t1310, 0
  %t1314 = select i1 %t1313, i8* %t1312, i8* %t1311
  %t1315 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1316 = icmp eq i32 %t1310, 1
  %t1317 = select i1 %t1316, i8* %t1315, i8* %t1314
  %t1318 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1319 = icmp eq i32 %t1310, 2
  %t1320 = select i1 %t1319, i8* %t1318, i8* %t1317
  %t1321 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1322 = icmp eq i32 %t1310, 3
  %t1323 = select i1 %t1322, i8* %t1321, i8* %t1320
  %t1324 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1325 = icmp eq i32 %t1310, 4
  %t1326 = select i1 %t1325, i8* %t1324, i8* %t1323
  %t1327 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1328 = icmp eq i32 %t1310, 5
  %t1329 = select i1 %t1328, i8* %t1327, i8* %t1326
  %t1330 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1331 = icmp eq i32 %t1310, 6
  %t1332 = select i1 %t1331, i8* %t1330, i8* %t1329
  %t1333 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1334 = icmp eq i32 %t1310, 7
  %t1335 = select i1 %t1334, i8* %t1333, i8* %t1332
  %t1336 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1337 = icmp eq i32 %t1310, 8
  %t1338 = select i1 %t1337, i8* %t1336, i8* %t1335
  %t1339 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1340 = icmp eq i32 %t1310, 9
  %t1341 = select i1 %t1340, i8* %t1339, i8* %t1338
  %t1342 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1343 = icmp eq i32 %t1310, 10
  %t1344 = select i1 %t1343, i8* %t1342, i8* %t1341
  %t1345 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1346 = icmp eq i32 %t1310, 11
  %t1347 = select i1 %t1346, i8* %t1345, i8* %t1344
  %t1348 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1349 = icmp eq i32 %t1310, 12
  %t1350 = select i1 %t1349, i8* %t1348, i8* %t1347
  %t1351 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1352 = icmp eq i32 %t1310, 13
  %t1353 = select i1 %t1352, i8* %t1351, i8* %t1350
  %t1354 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1355 = icmp eq i32 %t1310, 14
  %t1356 = select i1 %t1355, i8* %t1354, i8* %t1353
  %t1357 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1358 = icmp eq i32 %t1310, 15
  %t1359 = select i1 %t1358, i8* %t1357, i8* %t1356
  %t1360 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1361 = icmp eq i32 %t1310, 16
  %t1362 = select i1 %t1361, i8* %t1360, i8* %t1359
  %t1363 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1364 = icmp eq i32 %t1310, 17
  %t1365 = select i1 %t1364, i8* %t1363, i8* %t1362
  %t1366 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1367 = icmp eq i32 %t1310, 18
  %t1368 = select i1 %t1367, i8* %t1366, i8* %t1365
  %t1369 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1370 = icmp eq i32 %t1310, 19
  %t1371 = select i1 %t1370, i8* %t1369, i8* %t1368
  %t1372 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1373 = icmp eq i32 %t1310, 20
  %t1374 = select i1 %t1373, i8* %t1372, i8* %t1371
  %t1375 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1376 = icmp eq i32 %t1310, 21
  %t1377 = select i1 %t1376, i8* %t1375, i8* %t1374
  %t1378 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1379 = icmp eq i32 %t1310, 22
  %t1380 = select i1 %t1379, i8* %t1378, i8* %t1377
  %s1381 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h479148896, i32 0, i32 0
  %t1382 = icmp eq i8* %t1380, %s1381
  br i1 %t1382, label %then18, label %merge19
then18:
  %t1383 = extractvalue %Statement %statement, 0
  %t1384 = alloca %Statement
  store %Statement %statement, %Statement* %t1384
  %t1385 = getelementptr inbounds %Statement, %Statement* %t1384, i32 0, i32 1
  %t1386 = bitcast [24 x i8]* %t1385 to i8*
  %t1387 = bitcast i8* %t1386 to %FunctionSignature*
  %t1388 = load %FunctionSignature, %FunctionSignature* %t1387
  %t1389 = icmp eq i32 %t1383, 4
  %t1390 = select i1 %t1389, %FunctionSignature %t1388, %FunctionSignature zeroinitializer
  %t1391 = getelementptr inbounds %Statement, %Statement* %t1384, i32 0, i32 1
  %t1392 = bitcast [24 x i8]* %t1391 to i8*
  %t1393 = bitcast i8* %t1392 to %FunctionSignature*
  %t1394 = load %FunctionSignature, %FunctionSignature* %t1393
  %t1395 = icmp eq i32 %t1383, 5
  %t1396 = select i1 %t1395, %FunctionSignature %t1394, %FunctionSignature %t1390
  %t1397 = getelementptr inbounds %Statement, %Statement* %t1384, i32 0, i32 1
  %t1398 = bitcast [24 x i8]* %t1397 to i8*
  %t1399 = bitcast i8* %t1398 to %FunctionSignature*
  %t1400 = load %FunctionSignature, %FunctionSignature* %t1399
  %t1401 = icmp eq i32 %t1383, 7
  %t1402 = select i1 %t1401, %FunctionSignature %t1400, %FunctionSignature %t1396
  %t1403 = extractvalue %FunctionSignature %t1402, 0
  %s1404 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h2003786807, i32 0, i32 0
  %t1405 = extractvalue %Statement %statement, 0
  %t1406 = alloca %Statement
  store %Statement %statement, %Statement* %t1406
  %t1407 = getelementptr inbounds %Statement, %Statement* %t1406, i32 0, i32 1
  %t1408 = bitcast [24 x i8]* %t1407 to i8*
  %t1409 = bitcast i8* %t1408 to %FunctionSignature*
  %t1410 = load %FunctionSignature, %FunctionSignature* %t1409
  %t1411 = icmp eq i32 %t1405, 4
  %t1412 = select i1 %t1411, %FunctionSignature %t1410, %FunctionSignature zeroinitializer
  %t1413 = getelementptr inbounds %Statement, %Statement* %t1406, i32 0, i32 1
  %t1414 = bitcast [24 x i8]* %t1413 to i8*
  %t1415 = bitcast i8* %t1414 to %FunctionSignature*
  %t1416 = load %FunctionSignature, %FunctionSignature* %t1415
  %t1417 = icmp eq i32 %t1405, 5
  %t1418 = select i1 %t1417, %FunctionSignature %t1416, %FunctionSignature %t1412
  %t1419 = getelementptr inbounds %Statement, %Statement* %t1406, i32 0, i32 1
  %t1420 = bitcast [24 x i8]* %t1419 to i8*
  %t1421 = bitcast i8* %t1420 to %FunctionSignature*
  %t1422 = load %FunctionSignature, %FunctionSignature* %t1421
  %t1423 = icmp eq i32 %t1405, 7
  %t1424 = select i1 %t1423, %FunctionSignature %t1422, %FunctionSignature %t1418
  %t1425 = extractvalue %FunctionSignature %t1424, 6
  %t1426 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1403, i8* %s1404, %SourceSpan* %t1425)
  store %ScopeResult %t1426, %ScopeResult* %l13
  %t1427 = load %ScopeResult, %ScopeResult* %l13
  %t1428 = extractvalue %ScopeResult %t1427, 1
  store { %Diagnostic**, i64 }* %t1428, { %Diagnostic**, i64 }** %l14
  %t1429 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l14
  %t1430 = extractvalue %Statement %statement, 0
  %t1431 = alloca %Statement
  store %Statement %statement, %Statement* %t1431
  %t1432 = getelementptr inbounds %Statement, %Statement* %t1431, i32 0, i32 1
  %t1433 = bitcast [24 x i8]* %t1432 to i8*
  %t1434 = bitcast i8* %t1433 to %FunctionSignature*
  %t1435 = load %FunctionSignature, %FunctionSignature* %t1434
  %t1436 = icmp eq i32 %t1430, 4
  %t1437 = select i1 %t1436, %FunctionSignature %t1435, %FunctionSignature zeroinitializer
  %t1438 = getelementptr inbounds %Statement, %Statement* %t1431, i32 0, i32 1
  %t1439 = bitcast [24 x i8]* %t1438 to i8*
  %t1440 = bitcast i8* %t1439 to %FunctionSignature*
  %t1441 = load %FunctionSignature, %FunctionSignature* %t1440
  %t1442 = icmp eq i32 %t1430, 5
  %t1443 = select i1 %t1442, %FunctionSignature %t1441, %FunctionSignature %t1437
  %t1444 = getelementptr inbounds %Statement, %Statement* %t1431, i32 0, i32 1
  %t1445 = bitcast [24 x i8]* %t1444 to i8*
  %t1446 = bitcast i8* %t1445 to %FunctionSignature*
  %t1447 = load %FunctionSignature, %FunctionSignature* %t1446
  %t1448 = icmp eq i32 %t1430, 7
  %t1449 = select i1 %t1448, %FunctionSignature %t1447, %FunctionSignature %t1443
  %t1450 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t1449)
  %t1451 = bitcast { %Diagnostic**, i64 }* %t1429 to { i8**, i64 }*
  %t1452 = bitcast { %Diagnostic*, i64 }* %t1450 to { i8**, i64 }*
  %t1453 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1451, { i8**, i64 }* %t1452)
  %t1454 = bitcast { i8**, i64 }* %t1453 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1454, { %Diagnostic**, i64 }** %l14
  %t1455 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l14
  %t1456 = extractvalue %Statement %statement, 0
  %t1457 = alloca %Statement
  store %Statement %statement, %Statement* %t1457
  %t1458 = getelementptr inbounds %Statement, %Statement* %t1457, i32 0, i32 1
  %t1459 = bitcast [24 x i8]* %t1458 to i8*
  %t1460 = bitcast i8* %t1459 to %FunctionSignature*
  %t1461 = load %FunctionSignature, %FunctionSignature* %t1460
  %t1462 = icmp eq i32 %t1456, 4
  %t1463 = select i1 %t1462, %FunctionSignature %t1461, %FunctionSignature zeroinitializer
  %t1464 = getelementptr inbounds %Statement, %Statement* %t1457, i32 0, i32 1
  %t1465 = bitcast [24 x i8]* %t1464 to i8*
  %t1466 = bitcast i8* %t1465 to %FunctionSignature*
  %t1467 = load %FunctionSignature, %FunctionSignature* %t1466
  %t1468 = icmp eq i32 %t1456, 5
  %t1469 = select i1 %t1468, %FunctionSignature %t1467, %FunctionSignature %t1463
  %t1470 = getelementptr inbounds %Statement, %Statement* %t1457, i32 0, i32 1
  %t1471 = bitcast [24 x i8]* %t1470 to i8*
  %t1472 = bitcast i8* %t1471 to %FunctionSignature*
  %t1473 = load %FunctionSignature, %FunctionSignature* %t1472
  %t1474 = icmp eq i32 %t1456, 7
  %t1475 = select i1 %t1474, %FunctionSignature %t1473, %FunctionSignature %t1469
  %t1476 = extractvalue %Statement %statement, 0
  %t1477 = alloca %Statement
  store %Statement %statement, %Statement* %t1477
  %t1478 = getelementptr inbounds %Statement, %Statement* %t1477, i32 0, i32 1
  %t1479 = bitcast [24 x i8]* %t1478 to i8*
  %t1480 = getelementptr inbounds i8, i8* %t1479, i64 8
  %t1481 = bitcast i8* %t1480 to %Block*
  %t1482 = load %Block, %Block* %t1481
  %t1483 = icmp eq i32 %t1476, 4
  %t1484 = select i1 %t1483, %Block %t1482, %Block zeroinitializer
  %t1485 = getelementptr inbounds %Statement, %Statement* %t1477, i32 0, i32 1
  %t1486 = bitcast [24 x i8]* %t1485 to i8*
  %t1487 = getelementptr inbounds i8, i8* %t1486, i64 8
  %t1488 = bitcast i8* %t1487 to %Block*
  %t1489 = load %Block, %Block* %t1488
  %t1490 = icmp eq i32 %t1476, 5
  %t1491 = select i1 %t1490, %Block %t1489, %Block %t1484
  %t1492 = getelementptr inbounds %Statement, %Statement* %t1477, i32 0, i32 1
  %t1493 = bitcast [40 x i8]* %t1492 to i8*
  %t1494 = getelementptr inbounds i8, i8* %t1493, i64 16
  %t1495 = bitcast i8* %t1494 to %Block*
  %t1496 = load %Block, %Block* %t1495
  %t1497 = icmp eq i32 %t1476, 6
  %t1498 = select i1 %t1497, %Block %t1496, %Block %t1491
  %t1499 = getelementptr inbounds %Statement, %Statement* %t1477, i32 0, i32 1
  %t1500 = bitcast [24 x i8]* %t1499 to i8*
  %t1501 = getelementptr inbounds i8, i8* %t1500, i64 8
  %t1502 = bitcast i8* %t1501 to %Block*
  %t1503 = load %Block, %Block* %t1502
  %t1504 = icmp eq i32 %t1476, 7
  %t1505 = select i1 %t1504, %Block %t1503, %Block %t1498
  %t1506 = getelementptr inbounds %Statement, %Statement* %t1477, i32 0, i32 1
  %t1507 = bitcast [40 x i8]* %t1506 to i8*
  %t1508 = getelementptr inbounds i8, i8* %t1507, i64 24
  %t1509 = bitcast i8* %t1508 to %Block*
  %t1510 = load %Block, %Block* %t1509
  %t1511 = icmp eq i32 %t1476, 12
  %t1512 = select i1 %t1511, %Block %t1510, %Block %t1505
  %t1513 = getelementptr inbounds %Statement, %Statement* %t1477, i32 0, i32 1
  %t1514 = bitcast [24 x i8]* %t1513 to i8*
  %t1515 = getelementptr inbounds i8, i8* %t1514, i64 8
  %t1516 = bitcast i8* %t1515 to %Block*
  %t1517 = load %Block, %Block* %t1516
  %t1518 = icmp eq i32 %t1476, 13
  %t1519 = select i1 %t1518, %Block %t1517, %Block %t1512
  %t1520 = getelementptr inbounds %Statement, %Statement* %t1477, i32 0, i32 1
  %t1521 = bitcast [24 x i8]* %t1520 to i8*
  %t1522 = getelementptr inbounds i8, i8* %t1521, i64 8
  %t1523 = bitcast i8* %t1522 to %Block*
  %t1524 = load %Block, %Block* %t1523
  %t1525 = icmp eq i32 %t1476, 14
  %t1526 = select i1 %t1525, %Block %t1524, %Block %t1519
  %t1527 = getelementptr inbounds %Statement, %Statement* %t1477, i32 0, i32 1
  %t1528 = bitcast [16 x i8]* %t1527 to i8*
  %t1529 = bitcast i8* %t1528 to %Block*
  %t1530 = load %Block, %Block* %t1529
  %t1531 = icmp eq i32 %t1476, 15
  %t1532 = select i1 %t1531, %Block %t1530, %Block %t1526
  %t1533 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t1475, %Block %t1532, { %Statement*, i64 }* %interfaces)
  %t1534 = bitcast { %Diagnostic**, i64 }* %t1455 to { i8**, i64 }*
  %t1535 = bitcast { %Diagnostic*, i64 }* %t1533 to { i8**, i64 }*
  %t1536 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1534, { i8**, i64 }* %t1535)
  %t1537 = bitcast { i8**, i64 }* %t1536 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1537, { %Diagnostic**, i64 }** %l14
  %t1538 = load %ScopeResult, %ScopeResult* %l13
  %t1539 = extractvalue %ScopeResult %t1538, 0
  %t1540 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1539, 0
  %t1541 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l14
  %t1542 = insertvalue %ScopeResult %t1540, { %Diagnostic**, i64 }* %t1541, 1
  ret %ScopeResult %t1542
merge19:
  %t1543 = extractvalue %Statement %statement, 0
  %t1544 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1545 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1546 = icmp eq i32 %t1543, 0
  %t1547 = select i1 %t1546, i8* %t1545, i8* %t1544
  %t1548 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1549 = icmp eq i32 %t1543, 1
  %t1550 = select i1 %t1549, i8* %t1548, i8* %t1547
  %t1551 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1552 = icmp eq i32 %t1543, 2
  %t1553 = select i1 %t1552, i8* %t1551, i8* %t1550
  %t1554 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1555 = icmp eq i32 %t1543, 3
  %t1556 = select i1 %t1555, i8* %t1554, i8* %t1553
  %t1557 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1558 = icmp eq i32 %t1543, 4
  %t1559 = select i1 %t1558, i8* %t1557, i8* %t1556
  %t1560 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1561 = icmp eq i32 %t1543, 5
  %t1562 = select i1 %t1561, i8* %t1560, i8* %t1559
  %t1563 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1564 = icmp eq i32 %t1543, 6
  %t1565 = select i1 %t1564, i8* %t1563, i8* %t1562
  %t1566 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1567 = icmp eq i32 %t1543, 7
  %t1568 = select i1 %t1567, i8* %t1566, i8* %t1565
  %t1569 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1570 = icmp eq i32 %t1543, 8
  %t1571 = select i1 %t1570, i8* %t1569, i8* %t1568
  %t1572 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1573 = icmp eq i32 %t1543, 9
  %t1574 = select i1 %t1573, i8* %t1572, i8* %t1571
  %t1575 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1576 = icmp eq i32 %t1543, 10
  %t1577 = select i1 %t1576, i8* %t1575, i8* %t1574
  %t1578 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1579 = icmp eq i32 %t1543, 11
  %t1580 = select i1 %t1579, i8* %t1578, i8* %t1577
  %t1581 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1582 = icmp eq i32 %t1543, 12
  %t1583 = select i1 %t1582, i8* %t1581, i8* %t1580
  %t1584 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1585 = icmp eq i32 %t1543, 13
  %t1586 = select i1 %t1585, i8* %t1584, i8* %t1583
  %t1587 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1588 = icmp eq i32 %t1543, 14
  %t1589 = select i1 %t1588, i8* %t1587, i8* %t1586
  %t1590 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1591 = icmp eq i32 %t1543, 15
  %t1592 = select i1 %t1591, i8* %t1590, i8* %t1589
  %t1593 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1594 = icmp eq i32 %t1543, 16
  %t1595 = select i1 %t1594, i8* %t1593, i8* %t1592
  %t1596 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1597 = icmp eq i32 %t1543, 17
  %t1598 = select i1 %t1597, i8* %t1596, i8* %t1595
  %t1599 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1600 = icmp eq i32 %t1543, 18
  %t1601 = select i1 %t1600, i8* %t1599, i8* %t1598
  %t1602 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1603 = icmp eq i32 %t1543, 19
  %t1604 = select i1 %t1603, i8* %t1602, i8* %t1601
  %t1605 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1606 = icmp eq i32 %t1543, 20
  %t1607 = select i1 %t1606, i8* %t1605, i8* %t1604
  %t1608 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1609 = icmp eq i32 %t1543, 21
  %t1610 = select i1 %t1609, i8* %t1608, i8* %t1607
  %t1611 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1612 = icmp eq i32 %t1543, 22
  %t1613 = select i1 %t1612, i8* %t1611, i8* %t1610
  %s1614 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h571715647, i32 0, i32 0
  %t1615 = icmp eq i8* %t1613, %s1614
  br i1 %t1615, label %then20, label %merge21
then20:
  %t1616 = extractvalue %Statement %statement, 0
  %t1617 = alloca %Statement
  store %Statement %statement, %Statement* %t1617
  %t1618 = getelementptr inbounds %Statement, %Statement* %t1617, i32 0, i32 1
  %t1619 = bitcast [24 x i8]* %t1618 to i8*
  %t1620 = bitcast i8* %t1619 to %FunctionSignature*
  %t1621 = load %FunctionSignature, %FunctionSignature* %t1620
  %t1622 = icmp eq i32 %t1616, 4
  %t1623 = select i1 %t1622, %FunctionSignature %t1621, %FunctionSignature zeroinitializer
  %t1624 = getelementptr inbounds %Statement, %Statement* %t1617, i32 0, i32 1
  %t1625 = bitcast [24 x i8]* %t1624 to i8*
  %t1626 = bitcast i8* %t1625 to %FunctionSignature*
  %t1627 = load %FunctionSignature, %FunctionSignature* %t1626
  %t1628 = icmp eq i32 %t1616, 5
  %t1629 = select i1 %t1628, %FunctionSignature %t1627, %FunctionSignature %t1623
  %t1630 = getelementptr inbounds %Statement, %Statement* %t1617, i32 0, i32 1
  %t1631 = bitcast [24 x i8]* %t1630 to i8*
  %t1632 = bitcast i8* %t1631 to %FunctionSignature*
  %t1633 = load %FunctionSignature, %FunctionSignature* %t1632
  %t1634 = icmp eq i32 %t1616, 7
  %t1635 = select i1 %t1634, %FunctionSignature %t1633, %FunctionSignature %t1629
  %t1636 = extractvalue %FunctionSignature %t1635, 0
  %s1637 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275832617, i32 0, i32 0
  %t1638 = extractvalue %Statement %statement, 0
  %t1639 = alloca %Statement
  store %Statement %statement, %Statement* %t1639
  %t1640 = getelementptr inbounds %Statement, %Statement* %t1639, i32 0, i32 1
  %t1641 = bitcast [24 x i8]* %t1640 to i8*
  %t1642 = bitcast i8* %t1641 to %FunctionSignature*
  %t1643 = load %FunctionSignature, %FunctionSignature* %t1642
  %t1644 = icmp eq i32 %t1638, 4
  %t1645 = select i1 %t1644, %FunctionSignature %t1643, %FunctionSignature zeroinitializer
  %t1646 = getelementptr inbounds %Statement, %Statement* %t1639, i32 0, i32 1
  %t1647 = bitcast [24 x i8]* %t1646 to i8*
  %t1648 = bitcast i8* %t1647 to %FunctionSignature*
  %t1649 = load %FunctionSignature, %FunctionSignature* %t1648
  %t1650 = icmp eq i32 %t1638, 5
  %t1651 = select i1 %t1650, %FunctionSignature %t1649, %FunctionSignature %t1645
  %t1652 = getelementptr inbounds %Statement, %Statement* %t1639, i32 0, i32 1
  %t1653 = bitcast [24 x i8]* %t1652 to i8*
  %t1654 = bitcast i8* %t1653 to %FunctionSignature*
  %t1655 = load %FunctionSignature, %FunctionSignature* %t1654
  %t1656 = icmp eq i32 %t1638, 7
  %t1657 = select i1 %t1656, %FunctionSignature %t1655, %FunctionSignature %t1651
  %t1658 = extractvalue %FunctionSignature %t1657, 6
  %t1659 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1636, i8* %s1637, %SourceSpan* %t1658)
  store %ScopeResult %t1659, %ScopeResult* %l15
  %t1660 = load %ScopeResult, %ScopeResult* %l15
  %t1661 = extractvalue %ScopeResult %t1660, 1
  store { %Diagnostic**, i64 }* %t1661, { %Diagnostic**, i64 }** %l16
  %t1662 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l16
  %t1663 = extractvalue %Statement %statement, 0
  %t1664 = alloca %Statement
  store %Statement %statement, %Statement* %t1664
  %t1665 = getelementptr inbounds %Statement, %Statement* %t1664, i32 0, i32 1
  %t1666 = bitcast [24 x i8]* %t1665 to i8*
  %t1667 = bitcast i8* %t1666 to %FunctionSignature*
  %t1668 = load %FunctionSignature, %FunctionSignature* %t1667
  %t1669 = icmp eq i32 %t1663, 4
  %t1670 = select i1 %t1669, %FunctionSignature %t1668, %FunctionSignature zeroinitializer
  %t1671 = getelementptr inbounds %Statement, %Statement* %t1664, i32 0, i32 1
  %t1672 = bitcast [24 x i8]* %t1671 to i8*
  %t1673 = bitcast i8* %t1672 to %FunctionSignature*
  %t1674 = load %FunctionSignature, %FunctionSignature* %t1673
  %t1675 = icmp eq i32 %t1663, 5
  %t1676 = select i1 %t1675, %FunctionSignature %t1674, %FunctionSignature %t1670
  %t1677 = getelementptr inbounds %Statement, %Statement* %t1664, i32 0, i32 1
  %t1678 = bitcast [24 x i8]* %t1677 to i8*
  %t1679 = bitcast i8* %t1678 to %FunctionSignature*
  %t1680 = load %FunctionSignature, %FunctionSignature* %t1679
  %t1681 = icmp eq i32 %t1663, 7
  %t1682 = select i1 %t1681, %FunctionSignature %t1680, %FunctionSignature %t1676
  %t1683 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t1682)
  %t1684 = bitcast { %Diagnostic**, i64 }* %t1662 to { i8**, i64 }*
  %t1685 = bitcast { %Diagnostic*, i64 }* %t1683 to { i8**, i64 }*
  %t1686 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1684, { i8**, i64 }* %t1685)
  %t1687 = bitcast { i8**, i64 }* %t1686 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1687, { %Diagnostic**, i64 }** %l16
  %t1688 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l16
  %t1689 = extractvalue %Statement %statement, 0
  %t1690 = alloca %Statement
  store %Statement %statement, %Statement* %t1690
  %t1691 = getelementptr inbounds %Statement, %Statement* %t1690, i32 0, i32 1
  %t1692 = bitcast [24 x i8]* %t1691 to i8*
  %t1693 = bitcast i8* %t1692 to %FunctionSignature*
  %t1694 = load %FunctionSignature, %FunctionSignature* %t1693
  %t1695 = icmp eq i32 %t1689, 4
  %t1696 = select i1 %t1695, %FunctionSignature %t1694, %FunctionSignature zeroinitializer
  %t1697 = getelementptr inbounds %Statement, %Statement* %t1690, i32 0, i32 1
  %t1698 = bitcast [24 x i8]* %t1697 to i8*
  %t1699 = bitcast i8* %t1698 to %FunctionSignature*
  %t1700 = load %FunctionSignature, %FunctionSignature* %t1699
  %t1701 = icmp eq i32 %t1689, 5
  %t1702 = select i1 %t1701, %FunctionSignature %t1700, %FunctionSignature %t1696
  %t1703 = getelementptr inbounds %Statement, %Statement* %t1690, i32 0, i32 1
  %t1704 = bitcast [24 x i8]* %t1703 to i8*
  %t1705 = bitcast i8* %t1704 to %FunctionSignature*
  %t1706 = load %FunctionSignature, %FunctionSignature* %t1705
  %t1707 = icmp eq i32 %t1689, 7
  %t1708 = select i1 %t1707, %FunctionSignature %t1706, %FunctionSignature %t1702
  %t1709 = extractvalue %Statement %statement, 0
  %t1710 = alloca %Statement
  store %Statement %statement, %Statement* %t1710
  %t1711 = getelementptr inbounds %Statement, %Statement* %t1710, i32 0, i32 1
  %t1712 = bitcast [24 x i8]* %t1711 to i8*
  %t1713 = getelementptr inbounds i8, i8* %t1712, i64 8
  %t1714 = bitcast i8* %t1713 to %Block*
  %t1715 = load %Block, %Block* %t1714
  %t1716 = icmp eq i32 %t1709, 4
  %t1717 = select i1 %t1716, %Block %t1715, %Block zeroinitializer
  %t1718 = getelementptr inbounds %Statement, %Statement* %t1710, i32 0, i32 1
  %t1719 = bitcast [24 x i8]* %t1718 to i8*
  %t1720 = getelementptr inbounds i8, i8* %t1719, i64 8
  %t1721 = bitcast i8* %t1720 to %Block*
  %t1722 = load %Block, %Block* %t1721
  %t1723 = icmp eq i32 %t1709, 5
  %t1724 = select i1 %t1723, %Block %t1722, %Block %t1717
  %t1725 = getelementptr inbounds %Statement, %Statement* %t1710, i32 0, i32 1
  %t1726 = bitcast [40 x i8]* %t1725 to i8*
  %t1727 = getelementptr inbounds i8, i8* %t1726, i64 16
  %t1728 = bitcast i8* %t1727 to %Block*
  %t1729 = load %Block, %Block* %t1728
  %t1730 = icmp eq i32 %t1709, 6
  %t1731 = select i1 %t1730, %Block %t1729, %Block %t1724
  %t1732 = getelementptr inbounds %Statement, %Statement* %t1710, i32 0, i32 1
  %t1733 = bitcast [24 x i8]* %t1732 to i8*
  %t1734 = getelementptr inbounds i8, i8* %t1733, i64 8
  %t1735 = bitcast i8* %t1734 to %Block*
  %t1736 = load %Block, %Block* %t1735
  %t1737 = icmp eq i32 %t1709, 7
  %t1738 = select i1 %t1737, %Block %t1736, %Block %t1731
  %t1739 = getelementptr inbounds %Statement, %Statement* %t1710, i32 0, i32 1
  %t1740 = bitcast [40 x i8]* %t1739 to i8*
  %t1741 = getelementptr inbounds i8, i8* %t1740, i64 24
  %t1742 = bitcast i8* %t1741 to %Block*
  %t1743 = load %Block, %Block* %t1742
  %t1744 = icmp eq i32 %t1709, 12
  %t1745 = select i1 %t1744, %Block %t1743, %Block %t1738
  %t1746 = getelementptr inbounds %Statement, %Statement* %t1710, i32 0, i32 1
  %t1747 = bitcast [24 x i8]* %t1746 to i8*
  %t1748 = getelementptr inbounds i8, i8* %t1747, i64 8
  %t1749 = bitcast i8* %t1748 to %Block*
  %t1750 = load %Block, %Block* %t1749
  %t1751 = icmp eq i32 %t1709, 13
  %t1752 = select i1 %t1751, %Block %t1750, %Block %t1745
  %t1753 = getelementptr inbounds %Statement, %Statement* %t1710, i32 0, i32 1
  %t1754 = bitcast [24 x i8]* %t1753 to i8*
  %t1755 = getelementptr inbounds i8, i8* %t1754, i64 8
  %t1756 = bitcast i8* %t1755 to %Block*
  %t1757 = load %Block, %Block* %t1756
  %t1758 = icmp eq i32 %t1709, 14
  %t1759 = select i1 %t1758, %Block %t1757, %Block %t1752
  %t1760 = getelementptr inbounds %Statement, %Statement* %t1710, i32 0, i32 1
  %t1761 = bitcast [16 x i8]* %t1760 to i8*
  %t1762 = bitcast i8* %t1761 to %Block*
  %t1763 = load %Block, %Block* %t1762
  %t1764 = icmp eq i32 %t1709, 15
  %t1765 = select i1 %t1764, %Block %t1763, %Block %t1759
  %t1766 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t1708, %Block %t1765, { %Statement*, i64 }* %interfaces)
  %t1767 = bitcast { %Diagnostic**, i64 }* %t1688 to { i8**, i64 }*
  %t1768 = bitcast { %Diagnostic*, i64 }* %t1766 to { i8**, i64 }*
  %t1769 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1767, { i8**, i64 }* %t1768)
  %t1770 = bitcast { i8**, i64 }* %t1769 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1770, { %Diagnostic**, i64 }** %l16
  %t1771 = load %ScopeResult, %ScopeResult* %l15
  %t1772 = extractvalue %ScopeResult %t1771, 0
  %t1773 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1772, 0
  %t1774 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l16
  %t1775 = insertvalue %ScopeResult %t1773, { %Diagnostic**, i64 }* %t1774, 1
  ret %ScopeResult %t1775
merge21:
  %t1776 = extractvalue %Statement %statement, 0
  %t1777 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1778 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1779 = icmp eq i32 %t1776, 0
  %t1780 = select i1 %t1779, i8* %t1778, i8* %t1777
  %t1781 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1782 = icmp eq i32 %t1776, 1
  %t1783 = select i1 %t1782, i8* %t1781, i8* %t1780
  %t1784 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1785 = icmp eq i32 %t1776, 2
  %t1786 = select i1 %t1785, i8* %t1784, i8* %t1783
  %t1787 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1788 = icmp eq i32 %t1776, 3
  %t1789 = select i1 %t1788, i8* %t1787, i8* %t1786
  %t1790 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1791 = icmp eq i32 %t1776, 4
  %t1792 = select i1 %t1791, i8* %t1790, i8* %t1789
  %t1793 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1794 = icmp eq i32 %t1776, 5
  %t1795 = select i1 %t1794, i8* %t1793, i8* %t1792
  %t1796 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1797 = icmp eq i32 %t1776, 6
  %t1798 = select i1 %t1797, i8* %t1796, i8* %t1795
  %t1799 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1800 = icmp eq i32 %t1776, 7
  %t1801 = select i1 %t1800, i8* %t1799, i8* %t1798
  %t1802 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1803 = icmp eq i32 %t1776, 8
  %t1804 = select i1 %t1803, i8* %t1802, i8* %t1801
  %t1805 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1806 = icmp eq i32 %t1776, 9
  %t1807 = select i1 %t1806, i8* %t1805, i8* %t1804
  %t1808 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1809 = icmp eq i32 %t1776, 10
  %t1810 = select i1 %t1809, i8* %t1808, i8* %t1807
  %t1811 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1812 = icmp eq i32 %t1776, 11
  %t1813 = select i1 %t1812, i8* %t1811, i8* %t1810
  %t1814 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1815 = icmp eq i32 %t1776, 12
  %t1816 = select i1 %t1815, i8* %t1814, i8* %t1813
  %t1817 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1818 = icmp eq i32 %t1776, 13
  %t1819 = select i1 %t1818, i8* %t1817, i8* %t1816
  %t1820 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1821 = icmp eq i32 %t1776, 14
  %t1822 = select i1 %t1821, i8* %t1820, i8* %t1819
  %t1823 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1824 = icmp eq i32 %t1776, 15
  %t1825 = select i1 %t1824, i8* %t1823, i8* %t1822
  %t1826 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1827 = icmp eq i32 %t1776, 16
  %t1828 = select i1 %t1827, i8* %t1826, i8* %t1825
  %t1829 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1830 = icmp eq i32 %t1776, 17
  %t1831 = select i1 %t1830, i8* %t1829, i8* %t1828
  %t1832 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1833 = icmp eq i32 %t1776, 18
  %t1834 = select i1 %t1833, i8* %t1832, i8* %t1831
  %t1835 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1836 = icmp eq i32 %t1776, 19
  %t1837 = select i1 %t1836, i8* %t1835, i8* %t1834
  %t1838 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1839 = icmp eq i32 %t1776, 20
  %t1840 = select i1 %t1839, i8* %t1838, i8* %t1837
  %t1841 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1842 = icmp eq i32 %t1776, 21
  %t1843 = select i1 %t1842, i8* %t1841, i8* %t1840
  %t1844 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1845 = icmp eq i32 %t1776, 22
  %t1846 = select i1 %t1845, i8* %t1844, i8* %t1843
  %s1847 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h889179835, i32 0, i32 0
  %t1848 = icmp eq i8* %t1846, %s1847
  br i1 %t1848, label %then22, label %merge23
then22:
  %t1849 = extractvalue %Statement %statement, 0
  %t1850 = alloca %Statement
  store %Statement %statement, %Statement* %t1850
  %t1851 = getelementptr inbounds %Statement, %Statement* %t1850, i32 0, i32 1
  %t1852 = bitcast [48 x i8]* %t1851 to i8*
  %t1853 = bitcast i8* %t1852 to i8**
  %t1854 = load i8*, i8** %t1853
  %t1855 = icmp eq i32 %t1849, 2
  %t1856 = select i1 %t1855, i8* %t1854, i8* null
  %t1857 = getelementptr inbounds %Statement, %Statement* %t1850, i32 0, i32 1
  %t1858 = bitcast [48 x i8]* %t1857 to i8*
  %t1859 = bitcast i8* %t1858 to i8**
  %t1860 = load i8*, i8** %t1859
  %t1861 = icmp eq i32 %t1849, 3
  %t1862 = select i1 %t1861, i8* %t1860, i8* %t1856
  %t1863 = getelementptr inbounds %Statement, %Statement* %t1850, i32 0, i32 1
  %t1864 = bitcast [40 x i8]* %t1863 to i8*
  %t1865 = bitcast i8* %t1864 to i8**
  %t1866 = load i8*, i8** %t1865
  %t1867 = icmp eq i32 %t1849, 6
  %t1868 = select i1 %t1867, i8* %t1866, i8* %t1862
  %t1869 = getelementptr inbounds %Statement, %Statement* %t1850, i32 0, i32 1
  %t1870 = bitcast [56 x i8]* %t1869 to i8*
  %t1871 = bitcast i8* %t1870 to i8**
  %t1872 = load i8*, i8** %t1871
  %t1873 = icmp eq i32 %t1849, 8
  %t1874 = select i1 %t1873, i8* %t1872, i8* %t1868
  %t1875 = getelementptr inbounds %Statement, %Statement* %t1850, i32 0, i32 1
  %t1876 = bitcast [40 x i8]* %t1875 to i8*
  %t1877 = bitcast i8* %t1876 to i8**
  %t1878 = load i8*, i8** %t1877
  %t1879 = icmp eq i32 %t1849, 9
  %t1880 = select i1 %t1879, i8* %t1878, i8* %t1874
  %t1881 = getelementptr inbounds %Statement, %Statement* %t1850, i32 0, i32 1
  %t1882 = bitcast [40 x i8]* %t1881 to i8*
  %t1883 = bitcast i8* %t1882 to i8**
  %t1884 = load i8*, i8** %t1883
  %t1885 = icmp eq i32 %t1849, 10
  %t1886 = select i1 %t1885, i8* %t1884, i8* %t1880
  %t1887 = getelementptr inbounds %Statement, %Statement* %t1850, i32 0, i32 1
  %t1888 = bitcast [40 x i8]* %t1887 to i8*
  %t1889 = bitcast i8* %t1888 to i8**
  %t1890 = load i8*, i8** %t1889
  %t1891 = icmp eq i32 %t1849, 11
  %t1892 = select i1 %t1891, i8* %t1890, i8* %t1886
  %s1893 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275477867, i32 0, i32 0
  %t1894 = extractvalue %Statement %statement, 0
  %t1895 = alloca %Statement
  store %Statement %statement, %Statement* %t1895
  %t1896 = getelementptr inbounds %Statement, %Statement* %t1895, i32 0, i32 1
  %t1897 = bitcast [48 x i8]* %t1896 to i8*
  %t1898 = getelementptr inbounds i8, i8* %t1897, i64 8
  %t1899 = bitcast i8* %t1898 to %SourceSpan**
  %t1900 = load %SourceSpan*, %SourceSpan** %t1899
  %t1901 = icmp eq i32 %t1894, 3
  %t1902 = select i1 %t1901, %SourceSpan* %t1900, %SourceSpan* null
  %t1903 = getelementptr inbounds %Statement, %Statement* %t1895, i32 0, i32 1
  %t1904 = bitcast [40 x i8]* %t1903 to i8*
  %t1905 = getelementptr inbounds i8, i8* %t1904, i64 8
  %t1906 = bitcast i8* %t1905 to %SourceSpan**
  %t1907 = load %SourceSpan*, %SourceSpan** %t1906
  %t1908 = icmp eq i32 %t1894, 6
  %t1909 = select i1 %t1908, %SourceSpan* %t1907, %SourceSpan* %t1902
  %t1910 = getelementptr inbounds %Statement, %Statement* %t1895, i32 0, i32 1
  %t1911 = bitcast [56 x i8]* %t1910 to i8*
  %t1912 = getelementptr inbounds i8, i8* %t1911, i64 8
  %t1913 = bitcast i8* %t1912 to %SourceSpan**
  %t1914 = load %SourceSpan*, %SourceSpan** %t1913
  %t1915 = icmp eq i32 %t1894, 8
  %t1916 = select i1 %t1915, %SourceSpan* %t1914, %SourceSpan* %t1909
  %t1917 = getelementptr inbounds %Statement, %Statement* %t1895, i32 0, i32 1
  %t1918 = bitcast [40 x i8]* %t1917 to i8*
  %t1919 = getelementptr inbounds i8, i8* %t1918, i64 8
  %t1920 = bitcast i8* %t1919 to %SourceSpan**
  %t1921 = load %SourceSpan*, %SourceSpan** %t1920
  %t1922 = icmp eq i32 %t1894, 9
  %t1923 = select i1 %t1922, %SourceSpan* %t1921, %SourceSpan* %t1916
  %t1924 = getelementptr inbounds %Statement, %Statement* %t1895, i32 0, i32 1
  %t1925 = bitcast [40 x i8]* %t1924 to i8*
  %t1926 = getelementptr inbounds i8, i8* %t1925, i64 8
  %t1927 = bitcast i8* %t1926 to %SourceSpan**
  %t1928 = load %SourceSpan*, %SourceSpan** %t1927
  %t1929 = icmp eq i32 %t1894, 10
  %t1930 = select i1 %t1929, %SourceSpan* %t1928, %SourceSpan* %t1923
  %t1931 = getelementptr inbounds %Statement, %Statement* %t1895, i32 0, i32 1
  %t1932 = bitcast [40 x i8]* %t1931 to i8*
  %t1933 = getelementptr inbounds i8, i8* %t1932, i64 8
  %t1934 = bitcast i8* %t1933 to %SourceSpan**
  %t1935 = load %SourceSpan*, %SourceSpan** %t1934
  %t1936 = icmp eq i32 %t1894, 11
  %t1937 = select i1 %t1936, %SourceSpan* %t1935, %SourceSpan* %t1930
  %t1938 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1892, i8* %s1893, %SourceSpan* %t1937)
  store %ScopeResult %t1938, %ScopeResult* %l17
  %t1939 = load %ScopeResult, %ScopeResult* %l17
  %t1940 = extractvalue %ScopeResult %t1939, 1
  %t1941 = extractvalue %Statement %statement, 0
  %t1942 = alloca %Statement
  store %Statement %statement, %Statement* %t1942
  %t1943 = getelementptr inbounds %Statement, %Statement* %t1942, i32 0, i32 1
  %t1944 = bitcast [24 x i8]* %t1943 to i8*
  %t1945 = getelementptr inbounds i8, i8* %t1944, i64 8
  %t1946 = bitcast i8* %t1945 to %Block*
  %t1947 = load %Block, %Block* %t1946
  %t1948 = icmp eq i32 %t1941, 4
  %t1949 = select i1 %t1948, %Block %t1947, %Block zeroinitializer
  %t1950 = getelementptr inbounds %Statement, %Statement* %t1942, i32 0, i32 1
  %t1951 = bitcast [24 x i8]* %t1950 to i8*
  %t1952 = getelementptr inbounds i8, i8* %t1951, i64 8
  %t1953 = bitcast i8* %t1952 to %Block*
  %t1954 = load %Block, %Block* %t1953
  %t1955 = icmp eq i32 %t1941, 5
  %t1956 = select i1 %t1955, %Block %t1954, %Block %t1949
  %t1957 = getelementptr inbounds %Statement, %Statement* %t1942, i32 0, i32 1
  %t1958 = bitcast [40 x i8]* %t1957 to i8*
  %t1959 = getelementptr inbounds i8, i8* %t1958, i64 16
  %t1960 = bitcast i8* %t1959 to %Block*
  %t1961 = load %Block, %Block* %t1960
  %t1962 = icmp eq i32 %t1941, 6
  %t1963 = select i1 %t1962, %Block %t1961, %Block %t1956
  %t1964 = getelementptr inbounds %Statement, %Statement* %t1942, i32 0, i32 1
  %t1965 = bitcast [24 x i8]* %t1964 to i8*
  %t1966 = getelementptr inbounds i8, i8* %t1965, i64 8
  %t1967 = bitcast i8* %t1966 to %Block*
  %t1968 = load %Block, %Block* %t1967
  %t1969 = icmp eq i32 %t1941, 7
  %t1970 = select i1 %t1969, %Block %t1968, %Block %t1963
  %t1971 = getelementptr inbounds %Statement, %Statement* %t1942, i32 0, i32 1
  %t1972 = bitcast [40 x i8]* %t1971 to i8*
  %t1973 = getelementptr inbounds i8, i8* %t1972, i64 24
  %t1974 = bitcast i8* %t1973 to %Block*
  %t1975 = load %Block, %Block* %t1974
  %t1976 = icmp eq i32 %t1941, 12
  %t1977 = select i1 %t1976, %Block %t1975, %Block %t1970
  %t1978 = getelementptr inbounds %Statement, %Statement* %t1942, i32 0, i32 1
  %t1979 = bitcast [24 x i8]* %t1978 to i8*
  %t1980 = getelementptr inbounds i8, i8* %t1979, i64 8
  %t1981 = bitcast i8* %t1980 to %Block*
  %t1982 = load %Block, %Block* %t1981
  %t1983 = icmp eq i32 %t1941, 13
  %t1984 = select i1 %t1983, %Block %t1982, %Block %t1977
  %t1985 = getelementptr inbounds %Statement, %Statement* %t1942, i32 0, i32 1
  %t1986 = bitcast [24 x i8]* %t1985 to i8*
  %t1987 = getelementptr inbounds i8, i8* %t1986, i64 8
  %t1988 = bitcast i8* %t1987 to %Block*
  %t1989 = load %Block, %Block* %t1988
  %t1990 = icmp eq i32 %t1941, 14
  %t1991 = select i1 %t1990, %Block %t1989, %Block %t1984
  %t1992 = getelementptr inbounds %Statement, %Statement* %t1942, i32 0, i32 1
  %t1993 = bitcast [16 x i8]* %t1992 to i8*
  %t1994 = bitcast i8* %t1993 to %Block*
  %t1995 = load %Block, %Block* %t1994
  %t1996 = icmp eq i32 %t1941, 15
  %t1997 = select i1 %t1996, %Block %t1995, %Block %t1991
  %t1998 = getelementptr [0 x %SymbolEntry], [0 x %SymbolEntry]* null, i32 1
  %t1999 = ptrtoint [0 x %SymbolEntry]* %t1998 to i64
  %t2000 = icmp eq i64 %t1999, 0
  %t2001 = select i1 %t2000, i64 1, i64 %t1999
  %t2002 = call i8* @malloc(i64 %t2001)
  %t2003 = bitcast i8* %t2002 to %SymbolEntry*
  %t2004 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* null, i32 1
  %t2005 = ptrtoint { %SymbolEntry*, i64 }* %t2004 to i64
  %t2006 = call i8* @malloc(i64 %t2005)
  %t2007 = bitcast i8* %t2006 to { %SymbolEntry*, i64 }*
  %t2008 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t2007, i32 0, i32 0
  store %SymbolEntry* %t2003, %SymbolEntry** %t2008
  %t2009 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t2007, i32 0, i32 1
  store i64 0, i64* %t2009
  %t2010 = call { %Diagnostic*, i64 }* @check_block(%Block %t1997, { %SymbolEntry*, i64 }* %t2007, { %Statement*, i64 }* %interfaces)
  %t2011 = bitcast { %Diagnostic**, i64 }* %t1940 to { i8**, i64 }*
  %t2012 = bitcast { %Diagnostic*, i64 }* %t2010 to { i8**, i64 }*
  %t2013 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2011, { i8**, i64 }* %t2012)
  store { i8**, i64 }* %t2013, { i8**, i64 }** %l18
  %t2014 = load %ScopeResult, %ScopeResult* %l17
  %t2015 = extractvalue %ScopeResult %t2014, 0
  %t2016 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2015, 0
  %t2017 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t2018 = bitcast { i8**, i64 }* %t2017 to { %Diagnostic**, i64 }*
  %t2019 = insertvalue %ScopeResult %t2016, { %Diagnostic**, i64 }* %t2018, 1
  ret %ScopeResult %t2019
merge23:
  %t2020 = extractvalue %Statement %statement, 0
  %t2021 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2022 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2023 = icmp eq i32 %t2020, 0
  %t2024 = select i1 %t2023, i8* %t2022, i8* %t2021
  %t2025 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2026 = icmp eq i32 %t2020, 1
  %t2027 = select i1 %t2026, i8* %t2025, i8* %t2024
  %t2028 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2029 = icmp eq i32 %t2020, 2
  %t2030 = select i1 %t2029, i8* %t2028, i8* %t2027
  %t2031 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2032 = icmp eq i32 %t2020, 3
  %t2033 = select i1 %t2032, i8* %t2031, i8* %t2030
  %t2034 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2035 = icmp eq i32 %t2020, 4
  %t2036 = select i1 %t2035, i8* %t2034, i8* %t2033
  %t2037 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2038 = icmp eq i32 %t2020, 5
  %t2039 = select i1 %t2038, i8* %t2037, i8* %t2036
  %t2040 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2041 = icmp eq i32 %t2020, 6
  %t2042 = select i1 %t2041, i8* %t2040, i8* %t2039
  %t2043 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2044 = icmp eq i32 %t2020, 7
  %t2045 = select i1 %t2044, i8* %t2043, i8* %t2042
  %t2046 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2047 = icmp eq i32 %t2020, 8
  %t2048 = select i1 %t2047, i8* %t2046, i8* %t2045
  %t2049 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2050 = icmp eq i32 %t2020, 9
  %t2051 = select i1 %t2050, i8* %t2049, i8* %t2048
  %t2052 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2053 = icmp eq i32 %t2020, 10
  %t2054 = select i1 %t2053, i8* %t2052, i8* %t2051
  %t2055 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2056 = icmp eq i32 %t2020, 11
  %t2057 = select i1 %t2056, i8* %t2055, i8* %t2054
  %t2058 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2059 = icmp eq i32 %t2020, 12
  %t2060 = select i1 %t2059, i8* %t2058, i8* %t2057
  %t2061 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2062 = icmp eq i32 %t2020, 13
  %t2063 = select i1 %t2062, i8* %t2061, i8* %t2060
  %t2064 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2065 = icmp eq i32 %t2020, 14
  %t2066 = select i1 %t2065, i8* %t2064, i8* %t2063
  %t2067 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2068 = icmp eq i32 %t2020, 15
  %t2069 = select i1 %t2068, i8* %t2067, i8* %t2066
  %t2070 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2071 = icmp eq i32 %t2020, 16
  %t2072 = select i1 %t2071, i8* %t2070, i8* %t2069
  %t2073 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2074 = icmp eq i32 %t2020, 17
  %t2075 = select i1 %t2074, i8* %t2073, i8* %t2072
  %t2076 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2077 = icmp eq i32 %t2020, 18
  %t2078 = select i1 %t2077, i8* %t2076, i8* %t2075
  %t2079 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2080 = icmp eq i32 %t2020, 19
  %t2081 = select i1 %t2080, i8* %t2079, i8* %t2078
  %t2082 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2083 = icmp eq i32 %t2020, 20
  %t2084 = select i1 %t2083, i8* %t2082, i8* %t2081
  %t2085 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2086 = icmp eq i32 %t2020, 21
  %t2087 = select i1 %t2086, i8* %t2085, i8* %t2084
  %t2088 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2089 = icmp eq i32 %t2020, 22
  %t2090 = select i1 %t2089, i8* %t2088, i8* %t2087
  %s2091 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1925822000, i32 0, i32 0
  %t2092 = icmp eq i8* %t2090, %s2091
  br i1 %t2092, label %then24, label %merge25
then24:
  %t2093 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2094 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2093, 0
  %t2095 = extractvalue %Statement %statement, 0
  %t2096 = alloca %Statement
  store %Statement %statement, %Statement* %t2096
  %t2097 = getelementptr inbounds %Statement, %Statement* %t2096, i32 0, i32 1
  %t2098 = bitcast [24 x i8]* %t2097 to i8*
  %t2099 = getelementptr inbounds i8, i8* %t2098, i64 8
  %t2100 = bitcast i8* %t2099 to %Block*
  %t2101 = load %Block, %Block* %t2100
  %t2102 = icmp eq i32 %t2095, 4
  %t2103 = select i1 %t2102, %Block %t2101, %Block zeroinitializer
  %t2104 = getelementptr inbounds %Statement, %Statement* %t2096, i32 0, i32 1
  %t2105 = bitcast [24 x i8]* %t2104 to i8*
  %t2106 = getelementptr inbounds i8, i8* %t2105, i64 8
  %t2107 = bitcast i8* %t2106 to %Block*
  %t2108 = load %Block, %Block* %t2107
  %t2109 = icmp eq i32 %t2095, 5
  %t2110 = select i1 %t2109, %Block %t2108, %Block %t2103
  %t2111 = getelementptr inbounds %Statement, %Statement* %t2096, i32 0, i32 1
  %t2112 = bitcast [40 x i8]* %t2111 to i8*
  %t2113 = getelementptr inbounds i8, i8* %t2112, i64 16
  %t2114 = bitcast i8* %t2113 to %Block*
  %t2115 = load %Block, %Block* %t2114
  %t2116 = icmp eq i32 %t2095, 6
  %t2117 = select i1 %t2116, %Block %t2115, %Block %t2110
  %t2118 = getelementptr inbounds %Statement, %Statement* %t2096, i32 0, i32 1
  %t2119 = bitcast [24 x i8]* %t2118 to i8*
  %t2120 = getelementptr inbounds i8, i8* %t2119, i64 8
  %t2121 = bitcast i8* %t2120 to %Block*
  %t2122 = load %Block, %Block* %t2121
  %t2123 = icmp eq i32 %t2095, 7
  %t2124 = select i1 %t2123, %Block %t2122, %Block %t2117
  %t2125 = getelementptr inbounds %Statement, %Statement* %t2096, i32 0, i32 1
  %t2126 = bitcast [40 x i8]* %t2125 to i8*
  %t2127 = getelementptr inbounds i8, i8* %t2126, i64 24
  %t2128 = bitcast i8* %t2127 to %Block*
  %t2129 = load %Block, %Block* %t2128
  %t2130 = icmp eq i32 %t2095, 12
  %t2131 = select i1 %t2130, %Block %t2129, %Block %t2124
  %t2132 = getelementptr inbounds %Statement, %Statement* %t2096, i32 0, i32 1
  %t2133 = bitcast [24 x i8]* %t2132 to i8*
  %t2134 = getelementptr inbounds i8, i8* %t2133, i64 8
  %t2135 = bitcast i8* %t2134 to %Block*
  %t2136 = load %Block, %Block* %t2135
  %t2137 = icmp eq i32 %t2095, 13
  %t2138 = select i1 %t2137, %Block %t2136, %Block %t2131
  %t2139 = getelementptr inbounds %Statement, %Statement* %t2096, i32 0, i32 1
  %t2140 = bitcast [24 x i8]* %t2139 to i8*
  %t2141 = getelementptr inbounds i8, i8* %t2140, i64 8
  %t2142 = bitcast i8* %t2141 to %Block*
  %t2143 = load %Block, %Block* %t2142
  %t2144 = icmp eq i32 %t2095, 14
  %t2145 = select i1 %t2144, %Block %t2143, %Block %t2138
  %t2146 = getelementptr inbounds %Statement, %Statement* %t2096, i32 0, i32 1
  %t2147 = bitcast [16 x i8]* %t2146 to i8*
  %t2148 = bitcast i8* %t2147 to %Block*
  %t2149 = load %Block, %Block* %t2148
  %t2150 = icmp eq i32 %t2095, 15
  %t2151 = select i1 %t2150, %Block %t2149, %Block %t2145
  %t2152 = call { %Diagnostic*, i64 }* @check_block(%Block %t2151, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2153 = bitcast { %Diagnostic*, i64 }* %t2152 to { %Diagnostic**, i64 }*
  %t2154 = insertvalue %ScopeResult %t2094, { %Diagnostic**, i64 }* %t2153, 1
  ret %ScopeResult %t2154
merge25:
  %t2155 = extractvalue %Statement %statement, 0
  %t2156 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2157 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2158 = icmp eq i32 %t2155, 0
  %t2159 = select i1 %t2158, i8* %t2157, i8* %t2156
  %t2160 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2161 = icmp eq i32 %t2155, 1
  %t2162 = select i1 %t2161, i8* %t2160, i8* %t2159
  %t2163 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2164 = icmp eq i32 %t2155, 2
  %t2165 = select i1 %t2164, i8* %t2163, i8* %t2162
  %t2166 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2167 = icmp eq i32 %t2155, 3
  %t2168 = select i1 %t2167, i8* %t2166, i8* %t2165
  %t2169 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2170 = icmp eq i32 %t2155, 4
  %t2171 = select i1 %t2170, i8* %t2169, i8* %t2168
  %t2172 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2173 = icmp eq i32 %t2155, 5
  %t2174 = select i1 %t2173, i8* %t2172, i8* %t2171
  %t2175 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2176 = icmp eq i32 %t2155, 6
  %t2177 = select i1 %t2176, i8* %t2175, i8* %t2174
  %t2178 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2179 = icmp eq i32 %t2155, 7
  %t2180 = select i1 %t2179, i8* %t2178, i8* %t2177
  %t2181 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2182 = icmp eq i32 %t2155, 8
  %t2183 = select i1 %t2182, i8* %t2181, i8* %t2180
  %t2184 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2185 = icmp eq i32 %t2155, 9
  %t2186 = select i1 %t2185, i8* %t2184, i8* %t2183
  %t2187 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2188 = icmp eq i32 %t2155, 10
  %t2189 = select i1 %t2188, i8* %t2187, i8* %t2186
  %t2190 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2191 = icmp eq i32 %t2155, 11
  %t2192 = select i1 %t2191, i8* %t2190, i8* %t2189
  %t2193 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2194 = icmp eq i32 %t2155, 12
  %t2195 = select i1 %t2194, i8* %t2193, i8* %t2192
  %t2196 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2197 = icmp eq i32 %t2155, 13
  %t2198 = select i1 %t2197, i8* %t2196, i8* %t2195
  %t2199 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2200 = icmp eq i32 %t2155, 14
  %t2201 = select i1 %t2200, i8* %t2199, i8* %t2198
  %t2202 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2203 = icmp eq i32 %t2155, 15
  %t2204 = select i1 %t2203, i8* %t2202, i8* %t2201
  %t2205 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2206 = icmp eq i32 %t2155, 16
  %t2207 = select i1 %t2206, i8* %t2205, i8* %t2204
  %t2208 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2209 = icmp eq i32 %t2155, 17
  %t2210 = select i1 %t2209, i8* %t2208, i8* %t2207
  %t2211 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2212 = icmp eq i32 %t2155, 18
  %t2213 = select i1 %t2212, i8* %t2211, i8* %t2210
  %t2214 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2215 = icmp eq i32 %t2155, 19
  %t2216 = select i1 %t2215, i8* %t2214, i8* %t2213
  %t2217 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2218 = icmp eq i32 %t2155, 20
  %t2219 = select i1 %t2218, i8* %t2217, i8* %t2216
  %t2220 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2221 = icmp eq i32 %t2155, 21
  %t2222 = select i1 %t2221, i8* %t2220, i8* %t2219
  %t2223 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2224 = icmp eq i32 %t2155, 22
  %t2225 = select i1 %t2224, i8* %t2223, i8* %t2222
  %s2226 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h84042670, i32 0, i32 0
  %t2227 = icmp eq i8* %t2225, %s2226
  br i1 %t2227, label %then26, label %merge27
then26:
  %t2228 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2229 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2228, 0
  %t2230 = extractvalue %Statement %statement, 0
  %t2231 = alloca %Statement
  store %Statement %statement, %Statement* %t2231
  %t2232 = getelementptr inbounds %Statement, %Statement* %t2231, i32 0, i32 1
  %t2233 = bitcast [24 x i8]* %t2232 to i8*
  %t2234 = getelementptr inbounds i8, i8* %t2233, i64 8
  %t2235 = bitcast i8* %t2234 to %Block*
  %t2236 = load %Block, %Block* %t2235
  %t2237 = icmp eq i32 %t2230, 4
  %t2238 = select i1 %t2237, %Block %t2236, %Block zeroinitializer
  %t2239 = getelementptr inbounds %Statement, %Statement* %t2231, i32 0, i32 1
  %t2240 = bitcast [24 x i8]* %t2239 to i8*
  %t2241 = getelementptr inbounds i8, i8* %t2240, i64 8
  %t2242 = bitcast i8* %t2241 to %Block*
  %t2243 = load %Block, %Block* %t2242
  %t2244 = icmp eq i32 %t2230, 5
  %t2245 = select i1 %t2244, %Block %t2243, %Block %t2238
  %t2246 = getelementptr inbounds %Statement, %Statement* %t2231, i32 0, i32 1
  %t2247 = bitcast [40 x i8]* %t2246 to i8*
  %t2248 = getelementptr inbounds i8, i8* %t2247, i64 16
  %t2249 = bitcast i8* %t2248 to %Block*
  %t2250 = load %Block, %Block* %t2249
  %t2251 = icmp eq i32 %t2230, 6
  %t2252 = select i1 %t2251, %Block %t2250, %Block %t2245
  %t2253 = getelementptr inbounds %Statement, %Statement* %t2231, i32 0, i32 1
  %t2254 = bitcast [24 x i8]* %t2253 to i8*
  %t2255 = getelementptr inbounds i8, i8* %t2254, i64 8
  %t2256 = bitcast i8* %t2255 to %Block*
  %t2257 = load %Block, %Block* %t2256
  %t2258 = icmp eq i32 %t2230, 7
  %t2259 = select i1 %t2258, %Block %t2257, %Block %t2252
  %t2260 = getelementptr inbounds %Statement, %Statement* %t2231, i32 0, i32 1
  %t2261 = bitcast [40 x i8]* %t2260 to i8*
  %t2262 = getelementptr inbounds i8, i8* %t2261, i64 24
  %t2263 = bitcast i8* %t2262 to %Block*
  %t2264 = load %Block, %Block* %t2263
  %t2265 = icmp eq i32 %t2230, 12
  %t2266 = select i1 %t2265, %Block %t2264, %Block %t2259
  %t2267 = getelementptr inbounds %Statement, %Statement* %t2231, i32 0, i32 1
  %t2268 = bitcast [24 x i8]* %t2267 to i8*
  %t2269 = getelementptr inbounds i8, i8* %t2268, i64 8
  %t2270 = bitcast i8* %t2269 to %Block*
  %t2271 = load %Block, %Block* %t2270
  %t2272 = icmp eq i32 %t2230, 13
  %t2273 = select i1 %t2272, %Block %t2271, %Block %t2266
  %t2274 = getelementptr inbounds %Statement, %Statement* %t2231, i32 0, i32 1
  %t2275 = bitcast [24 x i8]* %t2274 to i8*
  %t2276 = getelementptr inbounds i8, i8* %t2275, i64 8
  %t2277 = bitcast i8* %t2276 to %Block*
  %t2278 = load %Block, %Block* %t2277
  %t2279 = icmp eq i32 %t2230, 14
  %t2280 = select i1 %t2279, %Block %t2278, %Block %t2273
  %t2281 = getelementptr inbounds %Statement, %Statement* %t2231, i32 0, i32 1
  %t2282 = bitcast [16 x i8]* %t2281 to i8*
  %t2283 = bitcast i8* %t2282 to %Block*
  %t2284 = load %Block, %Block* %t2283
  %t2285 = icmp eq i32 %t2230, 15
  %t2286 = select i1 %t2285, %Block %t2284, %Block %t2280
  %t2287 = call { %Diagnostic*, i64 }* @check_block(%Block %t2286, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2288 = bitcast { %Diagnostic*, i64 }* %t2287 to { %Diagnostic**, i64 }*
  %t2289 = insertvalue %ScopeResult %t2229, { %Diagnostic**, i64 }* %t2288, 1
  ret %ScopeResult %t2289
merge27:
  %t2290 = extractvalue %Statement %statement, 0
  %t2291 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2292 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2293 = icmp eq i32 %t2290, 0
  %t2294 = select i1 %t2293, i8* %t2292, i8* %t2291
  %t2295 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2296 = icmp eq i32 %t2290, 1
  %t2297 = select i1 %t2296, i8* %t2295, i8* %t2294
  %t2298 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2299 = icmp eq i32 %t2290, 2
  %t2300 = select i1 %t2299, i8* %t2298, i8* %t2297
  %t2301 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2302 = icmp eq i32 %t2290, 3
  %t2303 = select i1 %t2302, i8* %t2301, i8* %t2300
  %t2304 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2305 = icmp eq i32 %t2290, 4
  %t2306 = select i1 %t2305, i8* %t2304, i8* %t2303
  %t2307 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2308 = icmp eq i32 %t2290, 5
  %t2309 = select i1 %t2308, i8* %t2307, i8* %t2306
  %t2310 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2311 = icmp eq i32 %t2290, 6
  %t2312 = select i1 %t2311, i8* %t2310, i8* %t2309
  %t2313 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2314 = icmp eq i32 %t2290, 7
  %t2315 = select i1 %t2314, i8* %t2313, i8* %t2312
  %t2316 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2317 = icmp eq i32 %t2290, 8
  %t2318 = select i1 %t2317, i8* %t2316, i8* %t2315
  %t2319 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2320 = icmp eq i32 %t2290, 9
  %t2321 = select i1 %t2320, i8* %t2319, i8* %t2318
  %t2322 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2323 = icmp eq i32 %t2290, 10
  %t2324 = select i1 %t2323, i8* %t2322, i8* %t2321
  %t2325 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2326 = icmp eq i32 %t2290, 11
  %t2327 = select i1 %t2326, i8* %t2325, i8* %t2324
  %t2328 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2329 = icmp eq i32 %t2290, 12
  %t2330 = select i1 %t2329, i8* %t2328, i8* %t2327
  %t2331 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2332 = icmp eq i32 %t2290, 13
  %t2333 = select i1 %t2332, i8* %t2331, i8* %t2330
  %t2334 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2335 = icmp eq i32 %t2290, 14
  %t2336 = select i1 %t2335, i8* %t2334, i8* %t2333
  %t2337 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2338 = icmp eq i32 %t2290, 15
  %t2339 = select i1 %t2338, i8* %t2337, i8* %t2336
  %t2340 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2341 = icmp eq i32 %t2290, 16
  %t2342 = select i1 %t2341, i8* %t2340, i8* %t2339
  %t2343 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2344 = icmp eq i32 %t2290, 17
  %t2345 = select i1 %t2344, i8* %t2343, i8* %t2342
  %t2346 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2347 = icmp eq i32 %t2290, 18
  %t2348 = select i1 %t2347, i8* %t2346, i8* %t2345
  %t2349 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2350 = icmp eq i32 %t2290, 19
  %t2351 = select i1 %t2350, i8* %t2349, i8* %t2348
  %t2352 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2353 = icmp eq i32 %t2290, 20
  %t2354 = select i1 %t2353, i8* %t2352, i8* %t2351
  %t2355 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2356 = icmp eq i32 %t2290, 21
  %t2357 = select i1 %t2356, i8* %t2355, i8* %t2354
  %t2358 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2359 = icmp eq i32 %t2290, 22
  %t2360 = select i1 %t2359, i8* %t2358, i8* %t2357
  %s2361 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h196308685, i32 0, i32 0
  %t2362 = icmp eq i8* %t2360, %s2361
  br i1 %t2362, label %then28, label %merge29
then28:
  %t2363 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t2364 = ptrtoint [0 x %Diagnostic]* %t2363 to i64
  %t2365 = icmp eq i64 %t2364, 0
  %t2366 = select i1 %t2365, i64 1, i64 %t2364
  %t2367 = call i8* @malloc(i64 %t2366)
  %t2368 = bitcast i8* %t2367 to %Diagnostic*
  %t2369 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t2370 = ptrtoint { %Diagnostic*, i64 }* %t2369 to i64
  %t2371 = call i8* @malloc(i64 %t2370)
  %t2372 = bitcast i8* %t2371 to { %Diagnostic*, i64 }*
  %t2373 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2372, i32 0, i32 0
  store %Diagnostic* %t2368, %Diagnostic** %t2373
  %t2374 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2372, i32 0, i32 1
  store i64 0, i64* %t2374
  store { %Diagnostic*, i64 }* %t2372, { %Diagnostic*, i64 }** %l19
  %t2375 = sitofp i64 0 to double
  store double %t2375, double* %l20
  %t2376 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2377 = load double, double* %l20
  br label %loop.header30
loop.header30:
  %t2425 = phi { %Diagnostic*, i64 }* [ %t2376, %then28 ], [ %t2423, %loop.latch32 ]
  %t2426 = phi double [ %t2377, %then28 ], [ %t2424, %loop.latch32 ]
  store { %Diagnostic*, i64 }* %t2425, { %Diagnostic*, i64 }** %l19
  store double %t2426, double* %l20
  br label %loop.body31
loop.body31:
  %t2378 = load double, double* %l20
  %t2379 = extractvalue %Statement %statement, 0
  %t2380 = alloca %Statement
  store %Statement %statement, %Statement* %t2380
  %t2381 = getelementptr inbounds %Statement, %Statement* %t2380, i32 0, i32 1
  %t2382 = bitcast [24 x i8]* %t2381 to i8*
  %t2383 = getelementptr inbounds i8, i8* %t2382, i64 8
  %t2384 = bitcast i8* %t2383 to { %MatchCase**, i64 }**
  %t2385 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t2384
  %t2386 = icmp eq i32 %t2379, 18
  %t2387 = select i1 %t2386, { %MatchCase**, i64 }* %t2385, { %MatchCase**, i64 }* null
  %t2388 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t2387
  %t2389 = extractvalue { %MatchCase**, i64 } %t2388, 1
  %t2390 = sitofp i64 %t2389 to double
  %t2391 = fcmp oge double %t2378, %t2390
  %t2392 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2393 = load double, double* %l20
  br i1 %t2391, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t2394 = extractvalue %Statement %statement, 0
  %t2395 = alloca %Statement
  store %Statement %statement, %Statement* %t2395
  %t2396 = getelementptr inbounds %Statement, %Statement* %t2395, i32 0, i32 1
  %t2397 = bitcast [24 x i8]* %t2396 to i8*
  %t2398 = getelementptr inbounds i8, i8* %t2397, i64 8
  %t2399 = bitcast i8* %t2398 to { %MatchCase**, i64 }**
  %t2400 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t2399
  %t2401 = icmp eq i32 %t2394, 18
  %t2402 = select i1 %t2401, { %MatchCase**, i64 }* %t2400, { %MatchCase**, i64 }* null
  %t2403 = load double, double* %l20
  %t2404 = fptosi double %t2403 to i64
  %t2405 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t2402
  %t2406 = extractvalue { %MatchCase**, i64 } %t2405, 0
  %t2407 = extractvalue { %MatchCase**, i64 } %t2405, 1
  %t2408 = icmp uge i64 %t2404, %t2407
  ; bounds check: %t2408 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t2404, i64 %t2407)
  %t2409 = getelementptr %MatchCase*, %MatchCase** %t2406, i64 %t2404
  %t2410 = load %MatchCase*, %MatchCase** %t2409
  store %MatchCase* %t2410, %MatchCase** %l21
  %t2411 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2412 = load %MatchCase*, %MatchCase** %l21
  %t2413 = getelementptr %MatchCase, %MatchCase* %t2412, i32 0, i32 2
  %t2414 = load %Block, %Block* %t2413
  %t2415 = call { %Diagnostic*, i64 }* @check_block(%Block %t2414, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2416 = bitcast { %Diagnostic*, i64 }* %t2411 to { i8**, i64 }*
  %t2417 = bitcast { %Diagnostic*, i64 }* %t2415 to { i8**, i64 }*
  %t2418 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2416, { i8**, i64 }* %t2417)
  %t2419 = bitcast { i8**, i64 }* %t2418 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t2419, { %Diagnostic*, i64 }** %l19
  %t2420 = load double, double* %l20
  %t2421 = sitofp i64 1 to double
  %t2422 = fadd double %t2420, %t2421
  store double %t2422, double* %l20
  br label %loop.latch32
loop.latch32:
  %t2423 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2424 = load double, double* %l20
  br label %loop.header30
afterloop33:
  %t2427 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2428 = load double, double* %l20
  %t2429 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2430 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2429, 0
  %t2431 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2432 = bitcast { %Diagnostic*, i64 }* %t2431 to { %Diagnostic**, i64 }*
  %t2433 = insertvalue %ScopeResult %t2430, { %Diagnostic**, i64 }* %t2432, 1
  ret %ScopeResult %t2433
merge29:
  %t2434 = extractvalue %Statement %statement, 0
  %t2435 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2436 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2437 = icmp eq i32 %t2434, 0
  %t2438 = select i1 %t2437, i8* %t2436, i8* %t2435
  %t2439 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2440 = icmp eq i32 %t2434, 1
  %t2441 = select i1 %t2440, i8* %t2439, i8* %t2438
  %t2442 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2443 = icmp eq i32 %t2434, 2
  %t2444 = select i1 %t2443, i8* %t2442, i8* %t2441
  %t2445 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2446 = icmp eq i32 %t2434, 3
  %t2447 = select i1 %t2446, i8* %t2445, i8* %t2444
  %t2448 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2449 = icmp eq i32 %t2434, 4
  %t2450 = select i1 %t2449, i8* %t2448, i8* %t2447
  %t2451 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2452 = icmp eq i32 %t2434, 5
  %t2453 = select i1 %t2452, i8* %t2451, i8* %t2450
  %t2454 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2455 = icmp eq i32 %t2434, 6
  %t2456 = select i1 %t2455, i8* %t2454, i8* %t2453
  %t2457 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2458 = icmp eq i32 %t2434, 7
  %t2459 = select i1 %t2458, i8* %t2457, i8* %t2456
  %t2460 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2461 = icmp eq i32 %t2434, 8
  %t2462 = select i1 %t2461, i8* %t2460, i8* %t2459
  %t2463 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2464 = icmp eq i32 %t2434, 9
  %t2465 = select i1 %t2464, i8* %t2463, i8* %t2462
  %t2466 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2467 = icmp eq i32 %t2434, 10
  %t2468 = select i1 %t2467, i8* %t2466, i8* %t2465
  %t2469 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2470 = icmp eq i32 %t2434, 11
  %t2471 = select i1 %t2470, i8* %t2469, i8* %t2468
  %t2472 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2473 = icmp eq i32 %t2434, 12
  %t2474 = select i1 %t2473, i8* %t2472, i8* %t2471
  %t2475 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2476 = icmp eq i32 %t2434, 13
  %t2477 = select i1 %t2476, i8* %t2475, i8* %t2474
  %t2478 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2479 = icmp eq i32 %t2434, 14
  %t2480 = select i1 %t2479, i8* %t2478, i8* %t2477
  %t2481 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2482 = icmp eq i32 %t2434, 15
  %t2483 = select i1 %t2482, i8* %t2481, i8* %t2480
  %t2484 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2485 = icmp eq i32 %t2434, 16
  %t2486 = select i1 %t2485, i8* %t2484, i8* %t2483
  %t2487 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2488 = icmp eq i32 %t2434, 17
  %t2489 = select i1 %t2488, i8* %t2487, i8* %t2486
  %t2490 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2491 = icmp eq i32 %t2434, 18
  %t2492 = select i1 %t2491, i8* %t2490, i8* %t2489
  %t2493 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2494 = icmp eq i32 %t2434, 19
  %t2495 = select i1 %t2494, i8* %t2493, i8* %t2492
  %t2496 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2497 = icmp eq i32 %t2434, 20
  %t2498 = select i1 %t2497, i8* %t2496, i8* %t2495
  %t2499 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2500 = icmp eq i32 %t2434, 21
  %t2501 = select i1 %t2500, i8* %t2499, i8* %t2498
  %t2502 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2503 = icmp eq i32 %t2434, 22
  %t2504 = select i1 %t2503, i8* %t2502, i8* %t2501
  %s2505 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1566780570, i32 0, i32 0
  %t2506 = icmp eq i8* %t2504, %s2505
  br i1 %t2506, label %then36, label %merge37
then36:
  %t2507 = extractvalue %Statement %statement, 0
  %t2508 = alloca %Statement
  store %Statement %statement, %Statement* %t2508
  %t2509 = getelementptr inbounds %Statement, %Statement* %t2508, i32 0, i32 1
  %t2510 = bitcast [32 x i8]* %t2509 to i8*
  %t2511 = getelementptr inbounds i8, i8* %t2510, i64 8
  %t2512 = bitcast i8* %t2511 to %Block*
  %t2513 = load %Block, %Block* %t2512
  %t2514 = icmp eq i32 %t2507, 19
  %t2515 = select i1 %t2514, %Block %t2513, %Block zeroinitializer
  %t2516 = call { %Diagnostic*, i64 }* @check_block(%Block %t2515, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t2516, { %Diagnostic*, i64 }** %l22
  %t2517 = extractvalue %Statement %statement, 0
  %t2518 = alloca %Statement
  store %Statement %statement, %Statement* %t2518
  %t2519 = getelementptr inbounds %Statement, %Statement* %t2518, i32 0, i32 1
  %t2520 = bitcast [32 x i8]* %t2519 to i8*
  %t2521 = getelementptr inbounds i8, i8* %t2520, i64 16
  %t2522 = bitcast i8* %t2521 to %ElseBranch**
  %t2523 = load %ElseBranch*, %ElseBranch** %t2522
  %t2524 = icmp eq i32 %t2517, 19
  %t2525 = select i1 %t2524, %ElseBranch* %t2523, %ElseBranch* null
  %t2526 = icmp ne %ElseBranch* %t2525, null
  %t2527 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br i1 %t2526, label %then38, label %merge39
then38:
  %t2528 = extractvalue %Statement %statement, 0
  %t2529 = alloca %Statement
  store %Statement %statement, %Statement* %t2529
  %t2530 = getelementptr inbounds %Statement, %Statement* %t2529, i32 0, i32 1
  %t2531 = bitcast [32 x i8]* %t2530 to i8*
  %t2532 = getelementptr inbounds i8, i8* %t2531, i64 16
  %t2533 = bitcast i8* %t2532 to %ElseBranch**
  %t2534 = load %ElseBranch*, %ElseBranch** %t2533
  %t2535 = icmp eq i32 %t2528, 19
  %t2536 = select i1 %t2535, %ElseBranch* %t2534, %ElseBranch* null
  store %ElseBranch* %t2536, %ElseBranch** %l23
  %t2537 = load %ElseBranch*, %ElseBranch** %l23
  %t2538 = getelementptr %ElseBranch, %ElseBranch* %t2537, i32 0, i32 1
  %t2539 = load %Block*, %Block** %t2538
  %t2540 = icmp ne %Block* %t2539, null
  %t2541 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2542 = load %ElseBranch*, %ElseBranch** %l23
  br i1 %t2540, label %then40, label %merge41
then40:
  %t2543 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2544 = load %ElseBranch*, %ElseBranch** %l23
  %t2545 = getelementptr %ElseBranch, %ElseBranch* %t2544, i32 0, i32 1
  %t2546 = load %Block*, %Block** %t2545
  %t2547 = load %Block, %Block* %t2546
  %t2548 = call { %Diagnostic*, i64 }* @check_block(%Block %t2547, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2549 = bitcast { %Diagnostic*, i64 }* %t2543 to { i8**, i64 }*
  %t2550 = bitcast { %Diagnostic*, i64 }* %t2548 to { i8**, i64 }*
  %t2551 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2549, { i8**, i64 }* %t2550)
  %t2552 = bitcast { i8**, i64 }* %t2551 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t2552, { %Diagnostic*, i64 }** %l22
  %t2553 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br label %merge41
merge41:
  %t2554 = phi { %Diagnostic*, i64 }* [ %t2553, %then40 ], [ %t2541, %then38 ]
  store { %Diagnostic*, i64 }* %t2554, { %Diagnostic*, i64 }** %l22
  %t2555 = load %ElseBranch*, %ElseBranch** %l23
  %t2556 = getelementptr %ElseBranch, %ElseBranch* %t2555, i32 0, i32 0
  %t2557 = load %Statement*, %Statement** %t2556
  %t2558 = icmp ne %Statement* %t2557, null
  %t2559 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2560 = load %ElseBranch*, %ElseBranch** %l23
  br i1 %t2558, label %then42, label %merge43
then42:
  %t2561 = load %ElseBranch*, %ElseBranch** %l23
  %t2562 = getelementptr %ElseBranch, %ElseBranch* %t2561, i32 0, i32 0
  %t2563 = load %Statement*, %Statement** %t2562
  %t2564 = load %Statement, %Statement* %t2563
  %t2565 = call %ScopeResult @check_statement(%Statement %t2564, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  store %ScopeResult %t2565, %ScopeResult* %l24
  %t2566 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2567 = load %ScopeResult, %ScopeResult* %l24
  %t2568 = extractvalue %ScopeResult %t2567, 1
  %t2569 = bitcast { %Diagnostic*, i64 }* %t2566 to { i8**, i64 }*
  %t2570 = bitcast { %Diagnostic**, i64 }* %t2568 to { i8**, i64 }*
  %t2571 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2569, { i8**, i64 }* %t2570)
  %t2572 = bitcast { i8**, i64 }* %t2571 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t2572, { %Diagnostic*, i64 }** %l22
  %t2573 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br label %merge43
merge43:
  %t2574 = phi { %Diagnostic*, i64 }* [ %t2573, %then42 ], [ %t2559, %merge41 ]
  store { %Diagnostic*, i64 }* %t2574, { %Diagnostic*, i64 }** %l22
  %t2575 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2576 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br label %merge39
merge39:
  %t2577 = phi { %Diagnostic*, i64 }* [ %t2575, %merge43 ], [ %t2527, %then36 ]
  %t2578 = phi { %Diagnostic*, i64 }* [ %t2576, %merge43 ], [ %t2527, %then36 ]
  store { %Diagnostic*, i64 }* %t2577, { %Diagnostic*, i64 }** %l22
  store { %Diagnostic*, i64 }* %t2578, { %Diagnostic*, i64 }** %l22
  %t2579 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2580 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2579, 0
  %t2581 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2582 = bitcast { %Diagnostic*, i64 }* %t2581 to { %Diagnostic**, i64 }*
  %t2583 = insertvalue %ScopeResult %t2580, { %Diagnostic**, i64 }* %t2582, 1
  ret %ScopeResult %t2583
merge37:
  %t2584 = extractvalue %Statement %statement, 0
  %t2585 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2586 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2587 = icmp eq i32 %t2584, 0
  %t2588 = select i1 %t2587, i8* %t2586, i8* %t2585
  %t2589 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2590 = icmp eq i32 %t2584, 1
  %t2591 = select i1 %t2590, i8* %t2589, i8* %t2588
  %t2592 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2593 = icmp eq i32 %t2584, 2
  %t2594 = select i1 %t2593, i8* %t2592, i8* %t2591
  %t2595 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2596 = icmp eq i32 %t2584, 3
  %t2597 = select i1 %t2596, i8* %t2595, i8* %t2594
  %t2598 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2599 = icmp eq i32 %t2584, 4
  %t2600 = select i1 %t2599, i8* %t2598, i8* %t2597
  %t2601 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2602 = icmp eq i32 %t2584, 5
  %t2603 = select i1 %t2602, i8* %t2601, i8* %t2600
  %t2604 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2605 = icmp eq i32 %t2584, 6
  %t2606 = select i1 %t2605, i8* %t2604, i8* %t2603
  %t2607 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2608 = icmp eq i32 %t2584, 7
  %t2609 = select i1 %t2608, i8* %t2607, i8* %t2606
  %t2610 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2611 = icmp eq i32 %t2584, 8
  %t2612 = select i1 %t2611, i8* %t2610, i8* %t2609
  %t2613 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2614 = icmp eq i32 %t2584, 9
  %t2615 = select i1 %t2614, i8* %t2613, i8* %t2612
  %t2616 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2617 = icmp eq i32 %t2584, 10
  %t2618 = select i1 %t2617, i8* %t2616, i8* %t2615
  %t2619 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2620 = icmp eq i32 %t2584, 11
  %t2621 = select i1 %t2620, i8* %t2619, i8* %t2618
  %t2622 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2623 = icmp eq i32 %t2584, 12
  %t2624 = select i1 %t2623, i8* %t2622, i8* %t2621
  %t2625 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2626 = icmp eq i32 %t2584, 13
  %t2627 = select i1 %t2626, i8* %t2625, i8* %t2624
  %t2628 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2629 = icmp eq i32 %t2584, 14
  %t2630 = select i1 %t2629, i8* %t2628, i8* %t2627
  %t2631 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2632 = icmp eq i32 %t2584, 15
  %t2633 = select i1 %t2632, i8* %t2631, i8* %t2630
  %t2634 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2635 = icmp eq i32 %t2584, 16
  %t2636 = select i1 %t2635, i8* %t2634, i8* %t2633
  %t2637 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2638 = icmp eq i32 %t2584, 17
  %t2639 = select i1 %t2638, i8* %t2637, i8* %t2636
  %t2640 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2641 = icmp eq i32 %t2584, 18
  %t2642 = select i1 %t2641, i8* %t2640, i8* %t2639
  %t2643 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2644 = icmp eq i32 %t2584, 19
  %t2645 = select i1 %t2644, i8* %t2643, i8* %t2642
  %t2646 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2647 = icmp eq i32 %t2584, 20
  %t2648 = select i1 %t2647, i8* %t2646, i8* %t2645
  %t2649 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2650 = icmp eq i32 %t2584, 21
  %t2651 = select i1 %t2650, i8* %t2649, i8* %t2648
  %t2652 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2653 = icmp eq i32 %t2584, 22
  %t2654 = select i1 %t2653, i8* %t2652, i8* %t2651
  %s2655 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1067284810, i32 0, i32 0
  %t2656 = icmp eq i8* %t2654, %s2655
  br i1 %t2656, label %then44, label %merge45
then44:
  %t2657 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2658 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2657, 0
  %t2659 = extractvalue %Statement %statement, 0
  %t2660 = alloca %Statement
  store %Statement %statement, %Statement* %t2660
  %t2661 = getelementptr inbounds %Statement, %Statement* %t2660, i32 0, i32 1
  %t2662 = bitcast [24 x i8]* %t2661 to i8*
  %t2663 = getelementptr inbounds i8, i8* %t2662, i64 8
  %t2664 = bitcast i8* %t2663 to %Block*
  %t2665 = load %Block, %Block* %t2664
  %t2666 = icmp eq i32 %t2659, 4
  %t2667 = select i1 %t2666, %Block %t2665, %Block zeroinitializer
  %t2668 = getelementptr inbounds %Statement, %Statement* %t2660, i32 0, i32 1
  %t2669 = bitcast [24 x i8]* %t2668 to i8*
  %t2670 = getelementptr inbounds i8, i8* %t2669, i64 8
  %t2671 = bitcast i8* %t2670 to %Block*
  %t2672 = load %Block, %Block* %t2671
  %t2673 = icmp eq i32 %t2659, 5
  %t2674 = select i1 %t2673, %Block %t2672, %Block %t2667
  %t2675 = getelementptr inbounds %Statement, %Statement* %t2660, i32 0, i32 1
  %t2676 = bitcast [40 x i8]* %t2675 to i8*
  %t2677 = getelementptr inbounds i8, i8* %t2676, i64 16
  %t2678 = bitcast i8* %t2677 to %Block*
  %t2679 = load %Block, %Block* %t2678
  %t2680 = icmp eq i32 %t2659, 6
  %t2681 = select i1 %t2680, %Block %t2679, %Block %t2674
  %t2682 = getelementptr inbounds %Statement, %Statement* %t2660, i32 0, i32 1
  %t2683 = bitcast [24 x i8]* %t2682 to i8*
  %t2684 = getelementptr inbounds i8, i8* %t2683, i64 8
  %t2685 = bitcast i8* %t2684 to %Block*
  %t2686 = load %Block, %Block* %t2685
  %t2687 = icmp eq i32 %t2659, 7
  %t2688 = select i1 %t2687, %Block %t2686, %Block %t2681
  %t2689 = getelementptr inbounds %Statement, %Statement* %t2660, i32 0, i32 1
  %t2690 = bitcast [40 x i8]* %t2689 to i8*
  %t2691 = getelementptr inbounds i8, i8* %t2690, i64 24
  %t2692 = bitcast i8* %t2691 to %Block*
  %t2693 = load %Block, %Block* %t2692
  %t2694 = icmp eq i32 %t2659, 12
  %t2695 = select i1 %t2694, %Block %t2693, %Block %t2688
  %t2696 = getelementptr inbounds %Statement, %Statement* %t2660, i32 0, i32 1
  %t2697 = bitcast [24 x i8]* %t2696 to i8*
  %t2698 = getelementptr inbounds i8, i8* %t2697, i64 8
  %t2699 = bitcast i8* %t2698 to %Block*
  %t2700 = load %Block, %Block* %t2699
  %t2701 = icmp eq i32 %t2659, 13
  %t2702 = select i1 %t2701, %Block %t2700, %Block %t2695
  %t2703 = getelementptr inbounds %Statement, %Statement* %t2660, i32 0, i32 1
  %t2704 = bitcast [24 x i8]* %t2703 to i8*
  %t2705 = getelementptr inbounds i8, i8* %t2704, i64 8
  %t2706 = bitcast i8* %t2705 to %Block*
  %t2707 = load %Block, %Block* %t2706
  %t2708 = icmp eq i32 %t2659, 14
  %t2709 = select i1 %t2708, %Block %t2707, %Block %t2702
  %t2710 = getelementptr inbounds %Statement, %Statement* %t2660, i32 0, i32 1
  %t2711 = bitcast [16 x i8]* %t2710 to i8*
  %t2712 = bitcast i8* %t2711 to %Block*
  %t2713 = load %Block, %Block* %t2712
  %t2714 = icmp eq i32 %t2659, 15
  %t2715 = select i1 %t2714, %Block %t2713, %Block %t2709
  %t2716 = call { %Diagnostic*, i64 }* @check_block(%Block %t2715, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2717 = bitcast { %Diagnostic*, i64 }* %t2716 to { %Diagnostic**, i64 }*
  %t2718 = insertvalue %ScopeResult %t2658, { %Diagnostic**, i64 }* %t2717, 1
  ret %ScopeResult %t2718
merge45:
  %t2719 = extractvalue %Statement %statement, 0
  %t2720 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2721 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2722 = icmp eq i32 %t2719, 0
  %t2723 = select i1 %t2722, i8* %t2721, i8* %t2720
  %t2724 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2725 = icmp eq i32 %t2719, 1
  %t2726 = select i1 %t2725, i8* %t2724, i8* %t2723
  %t2727 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2728 = icmp eq i32 %t2719, 2
  %t2729 = select i1 %t2728, i8* %t2727, i8* %t2726
  %t2730 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2731 = icmp eq i32 %t2719, 3
  %t2732 = select i1 %t2731, i8* %t2730, i8* %t2729
  %t2733 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2734 = icmp eq i32 %t2719, 4
  %t2735 = select i1 %t2734, i8* %t2733, i8* %t2732
  %t2736 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2737 = icmp eq i32 %t2719, 5
  %t2738 = select i1 %t2737, i8* %t2736, i8* %t2735
  %t2739 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2740 = icmp eq i32 %t2719, 6
  %t2741 = select i1 %t2740, i8* %t2739, i8* %t2738
  %t2742 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2743 = icmp eq i32 %t2719, 7
  %t2744 = select i1 %t2743, i8* %t2742, i8* %t2741
  %t2745 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2746 = icmp eq i32 %t2719, 8
  %t2747 = select i1 %t2746, i8* %t2745, i8* %t2744
  %t2748 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2749 = icmp eq i32 %t2719, 9
  %t2750 = select i1 %t2749, i8* %t2748, i8* %t2747
  %t2751 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2752 = icmp eq i32 %t2719, 10
  %t2753 = select i1 %t2752, i8* %t2751, i8* %t2750
  %t2754 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2755 = icmp eq i32 %t2719, 11
  %t2756 = select i1 %t2755, i8* %t2754, i8* %t2753
  %t2757 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2758 = icmp eq i32 %t2719, 12
  %t2759 = select i1 %t2758, i8* %t2757, i8* %t2756
  %t2760 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2761 = icmp eq i32 %t2719, 13
  %t2762 = select i1 %t2761, i8* %t2760, i8* %t2759
  %t2763 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2764 = icmp eq i32 %t2719, 14
  %t2765 = select i1 %t2764, i8* %t2763, i8* %t2762
  %t2766 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2767 = icmp eq i32 %t2719, 15
  %t2768 = select i1 %t2767, i8* %t2766, i8* %t2765
  %t2769 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2770 = icmp eq i32 %t2719, 16
  %t2771 = select i1 %t2770, i8* %t2769, i8* %t2768
  %t2772 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2773 = icmp eq i32 %t2719, 17
  %t2774 = select i1 %t2773, i8* %t2772, i8* %t2771
  %t2775 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2776 = icmp eq i32 %t2719, 18
  %t2777 = select i1 %t2776, i8* %t2775, i8* %t2774
  %t2778 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2779 = icmp eq i32 %t2719, 19
  %t2780 = select i1 %t2779, i8* %t2778, i8* %t2777
  %t2781 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2782 = icmp eq i32 %t2719, 20
  %t2783 = select i1 %t2782, i8* %t2781, i8* %t2780
  %t2784 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2785 = icmp eq i32 %t2719, 21
  %t2786 = select i1 %t2785, i8* %t2784, i8* %t2783
  %t2787 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2788 = icmp eq i32 %t2719, 22
  %t2789 = select i1 %t2788, i8* %t2787, i8* %t2786
  %s2790 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1496093543, i32 0, i32 0
  %t2791 = icmp eq i8* %t2789, %s2790
  br i1 %t2791, label %then46, label %merge47
then46:
  %t2792 = extractvalue %Statement %statement, 0
  %t2793 = alloca %Statement
  store %Statement %statement, %Statement* %t2793
  %t2794 = getelementptr inbounds %Statement, %Statement* %t2793, i32 0, i32 1
  %t2795 = bitcast [48 x i8]* %t2794 to i8*
  %t2796 = bitcast i8* %t2795 to i8**
  %t2797 = load i8*, i8** %t2796
  %t2798 = icmp eq i32 %t2792, 2
  %t2799 = select i1 %t2798, i8* %t2797, i8* null
  %t2800 = getelementptr inbounds %Statement, %Statement* %t2793, i32 0, i32 1
  %t2801 = bitcast [48 x i8]* %t2800 to i8*
  %t2802 = bitcast i8* %t2801 to i8**
  %t2803 = load i8*, i8** %t2802
  %t2804 = icmp eq i32 %t2792, 3
  %t2805 = select i1 %t2804, i8* %t2803, i8* %t2799
  %t2806 = getelementptr inbounds %Statement, %Statement* %t2793, i32 0, i32 1
  %t2807 = bitcast [40 x i8]* %t2806 to i8*
  %t2808 = bitcast i8* %t2807 to i8**
  %t2809 = load i8*, i8** %t2808
  %t2810 = icmp eq i32 %t2792, 6
  %t2811 = select i1 %t2810, i8* %t2809, i8* %t2805
  %t2812 = getelementptr inbounds %Statement, %Statement* %t2793, i32 0, i32 1
  %t2813 = bitcast [56 x i8]* %t2812 to i8*
  %t2814 = bitcast i8* %t2813 to i8**
  %t2815 = load i8*, i8** %t2814
  %t2816 = icmp eq i32 %t2792, 8
  %t2817 = select i1 %t2816, i8* %t2815, i8* %t2811
  %t2818 = getelementptr inbounds %Statement, %Statement* %t2793, i32 0, i32 1
  %t2819 = bitcast [40 x i8]* %t2818 to i8*
  %t2820 = bitcast i8* %t2819 to i8**
  %t2821 = load i8*, i8** %t2820
  %t2822 = icmp eq i32 %t2792, 9
  %t2823 = select i1 %t2822, i8* %t2821, i8* %t2817
  %t2824 = getelementptr inbounds %Statement, %Statement* %t2793, i32 0, i32 1
  %t2825 = bitcast [40 x i8]* %t2824 to i8*
  %t2826 = bitcast i8* %t2825 to i8**
  %t2827 = load i8*, i8** %t2826
  %t2828 = icmp eq i32 %t2792, 10
  %t2829 = select i1 %t2828, i8* %t2827, i8* %t2823
  %t2830 = getelementptr inbounds %Statement, %Statement* %t2793, i32 0, i32 1
  %t2831 = bitcast [40 x i8]* %t2830 to i8*
  %t2832 = bitcast i8* %t2831 to i8**
  %t2833 = load i8*, i8** %t2832
  %t2834 = icmp eq i32 %t2792, 11
  %t2835 = select i1 %t2834, i8* %t2833, i8* %t2829
  %s2836 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h276192845, i32 0, i32 0
  %t2837 = extractvalue %Statement %statement, 0
  %t2838 = alloca %Statement
  store %Statement %statement, %Statement* %t2838
  %t2839 = getelementptr inbounds %Statement, %Statement* %t2838, i32 0, i32 1
  %t2840 = bitcast [48 x i8]* %t2839 to i8*
  %t2841 = getelementptr inbounds i8, i8* %t2840, i64 8
  %t2842 = bitcast i8* %t2841 to %SourceSpan**
  %t2843 = load %SourceSpan*, %SourceSpan** %t2842
  %t2844 = icmp eq i32 %t2837, 3
  %t2845 = select i1 %t2844, %SourceSpan* %t2843, %SourceSpan* null
  %t2846 = getelementptr inbounds %Statement, %Statement* %t2838, i32 0, i32 1
  %t2847 = bitcast [40 x i8]* %t2846 to i8*
  %t2848 = getelementptr inbounds i8, i8* %t2847, i64 8
  %t2849 = bitcast i8* %t2848 to %SourceSpan**
  %t2850 = load %SourceSpan*, %SourceSpan** %t2849
  %t2851 = icmp eq i32 %t2837, 6
  %t2852 = select i1 %t2851, %SourceSpan* %t2850, %SourceSpan* %t2845
  %t2853 = getelementptr inbounds %Statement, %Statement* %t2838, i32 0, i32 1
  %t2854 = bitcast [56 x i8]* %t2853 to i8*
  %t2855 = getelementptr inbounds i8, i8* %t2854, i64 8
  %t2856 = bitcast i8* %t2855 to %SourceSpan**
  %t2857 = load %SourceSpan*, %SourceSpan** %t2856
  %t2858 = icmp eq i32 %t2837, 8
  %t2859 = select i1 %t2858, %SourceSpan* %t2857, %SourceSpan* %t2852
  %t2860 = getelementptr inbounds %Statement, %Statement* %t2838, i32 0, i32 1
  %t2861 = bitcast [40 x i8]* %t2860 to i8*
  %t2862 = getelementptr inbounds i8, i8* %t2861, i64 8
  %t2863 = bitcast i8* %t2862 to %SourceSpan**
  %t2864 = load %SourceSpan*, %SourceSpan** %t2863
  %t2865 = icmp eq i32 %t2837, 9
  %t2866 = select i1 %t2865, %SourceSpan* %t2864, %SourceSpan* %t2859
  %t2867 = getelementptr inbounds %Statement, %Statement* %t2838, i32 0, i32 1
  %t2868 = bitcast [40 x i8]* %t2867 to i8*
  %t2869 = getelementptr inbounds i8, i8* %t2868, i64 8
  %t2870 = bitcast i8* %t2869 to %SourceSpan**
  %t2871 = load %SourceSpan*, %SourceSpan** %t2870
  %t2872 = icmp eq i32 %t2837, 10
  %t2873 = select i1 %t2872, %SourceSpan* %t2871, %SourceSpan* %t2866
  %t2874 = getelementptr inbounds %Statement, %Statement* %t2838, i32 0, i32 1
  %t2875 = bitcast [40 x i8]* %t2874 to i8*
  %t2876 = getelementptr inbounds i8, i8* %t2875, i64 8
  %t2877 = bitcast i8* %t2876 to %SourceSpan**
  %t2878 = load %SourceSpan*, %SourceSpan** %t2877
  %t2879 = icmp eq i32 %t2837, 11
  %t2880 = select i1 %t2879, %SourceSpan* %t2878, %SourceSpan* %t2873
  %t2881 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t2835, i8* %s2836, %SourceSpan* %t2880)
  store %ScopeResult %t2881, %ScopeResult* %l25
  %t2882 = load %ScopeResult, %ScopeResult* %l25
  %t2883 = extractvalue %ScopeResult %t2882, 1
  %t2884 = extractvalue %Statement %statement, 0
  %t2885 = alloca %Statement
  store %Statement %statement, %Statement* %t2885
  %t2886 = getelementptr inbounds %Statement, %Statement* %t2885, i32 0, i32 1
  %t2887 = bitcast [56 x i8]* %t2886 to i8*
  %t2888 = getelementptr inbounds i8, i8* %t2887, i64 16
  %t2889 = bitcast i8* %t2888 to { %TypeParameter**, i64 }**
  %t2890 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2889
  %t2891 = icmp eq i32 %t2884, 8
  %t2892 = select i1 %t2891, { %TypeParameter**, i64 }* %t2890, { %TypeParameter**, i64 }* null
  %t2893 = getelementptr inbounds %Statement, %Statement* %t2885, i32 0, i32 1
  %t2894 = bitcast [40 x i8]* %t2893 to i8*
  %t2895 = getelementptr inbounds i8, i8* %t2894, i64 16
  %t2896 = bitcast i8* %t2895 to { %TypeParameter**, i64 }**
  %t2897 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2896
  %t2898 = icmp eq i32 %t2884, 9
  %t2899 = select i1 %t2898, { %TypeParameter**, i64 }* %t2897, { %TypeParameter**, i64 }* %t2892
  %t2900 = getelementptr inbounds %Statement, %Statement* %t2885, i32 0, i32 1
  %t2901 = bitcast [40 x i8]* %t2900 to i8*
  %t2902 = getelementptr inbounds i8, i8* %t2901, i64 16
  %t2903 = bitcast i8* %t2902 to { %TypeParameter**, i64 }**
  %t2904 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2903
  %t2905 = icmp eq i32 %t2884, 10
  %t2906 = select i1 %t2905, { %TypeParameter**, i64 }* %t2904, { %TypeParameter**, i64 }* %t2899
  %t2907 = getelementptr inbounds %Statement, %Statement* %t2885, i32 0, i32 1
  %t2908 = bitcast [40 x i8]* %t2907 to i8*
  %t2909 = getelementptr inbounds i8, i8* %t2908, i64 16
  %t2910 = bitcast i8* %t2909 to { %TypeParameter**, i64 }**
  %t2911 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2910
  %t2912 = icmp eq i32 %t2884, 11
  %t2913 = select i1 %t2912, { %TypeParameter**, i64 }* %t2911, { %TypeParameter**, i64 }* %t2906
  %t2914 = bitcast { %TypeParameter**, i64 }* %t2913 to { %TypeParameter*, i64 }*
  %t2915 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t2914)
  %t2916 = bitcast { %Diagnostic**, i64 }* %t2883 to { i8**, i64 }*
  %t2917 = bitcast { %Diagnostic*, i64 }* %t2915 to { i8**, i64 }*
  %t2918 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2916, { i8**, i64 }* %t2917)
  store { i8**, i64 }* %t2918, { i8**, i64 }** %l26
  %t2919 = load %ScopeResult, %ScopeResult* %l25
  %t2920 = extractvalue %ScopeResult %t2919, 0
  %t2921 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2920, 0
  %t2922 = load { i8**, i64 }*, { i8**, i64 }** %l26
  %t2923 = bitcast { i8**, i64 }* %t2922 to { %Diagnostic**, i64 }*
  %t2924 = insertvalue %ScopeResult %t2921, { %Diagnostic**, i64 }* %t2923, 1
  ret %ScopeResult %t2924
merge47:
  %t2925 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2926 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2925, 0
  %t2927 = getelementptr [0 x %Diagnostic*], [0 x %Diagnostic*]* null, i32 1
  %t2928 = ptrtoint [0 x %Diagnostic*]* %t2927 to i64
  %t2929 = icmp eq i64 %t2928, 0
  %t2930 = select i1 %t2929, i64 1, i64 %t2928
  %t2931 = call i8* @malloc(i64 %t2930)
  %t2932 = bitcast i8* %t2931 to %Diagnostic**
  %t2933 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* null, i32 1
  %t2934 = ptrtoint { %Diagnostic**, i64 }* %t2933 to i64
  %t2935 = call i8* @malloc(i64 %t2934)
  %t2936 = bitcast i8* %t2935 to { %Diagnostic**, i64 }*
  %t2937 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t2936, i32 0, i32 0
  store %Diagnostic** %t2932, %Diagnostic*** %t2937
  %t2938 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t2936, i32 0, i32 1
  store i64 0, i64* %t2938
  %t2939 = insertvalue %ScopeResult %t2926, { %Diagnostic**, i64 }* %t2936, 1
  ret %ScopeResult %t2939
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
  %t57 = icmp eq i8* %t55, %t56
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
  %t36 = phi i8* [ %t11, %merge1 ], [ %t34, %loop.latch4 ]
  %t37 = phi double [ %t12, %merge1 ], [ %t35, %loop.latch4 ]
  store i8* %t36, i8** %l0
  store double %t37, double* %l1
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
  %t23 = fptosi double %t22 to i64
  %t24 = load { i8**, i64 }, { i8**, i64 }* %items
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
  %t88 = phi double [ %t7, %block.entry ], [ %t85, %loop.latch2 ]
  %t89 = phi double [ %t6, %block.entry ], [ %t86, %loop.latch2 ]
  %t90 = phi double [ %t5, %block.entry ], [ %t87, %loop.latch2 ]
  store double %t88, double* %l3
  store double %t89, double* %l2
  store double %t90, double* %l1
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
  %t19 = fptosi double %t18 to i64
  %t20 = getelementptr i8, i8* %t17, i64 %t19
  %t21 = load i8, i8* %t20
  store i8 %t21, i8* %l4
  %t22 = load i8, i8* %l4
  %t23 = icmp eq i8 %t22, 60
  %t24 = load i8*, i8** %l0
  %t25 = load double, double* %l1
  %t26 = load double, double* %l2
  %t27 = load double, double* %l3
  %t28 = load i8, i8* %l4
  br i1 %t23, label %then6, label %else7
then6:
  %t29 = load double, double* %l2
  %t30 = sitofp i64 0 to double
  %t31 = fcmp oeq double %t29, %t30
  %t32 = load i8*, i8** %l0
  %t33 = load double, double* %l1
  %t34 = load double, double* %l2
  %t35 = load double, double* %l3
  %t36 = load i8, i8* %l4
  br i1 %t31, label %then9, label %merge10
then9:
  %t37 = load double, double* %l1
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l3
  %t40 = load double, double* %l3
  br label %merge10
merge10:
  %t41 = phi double [ %t40, %then9 ], [ %t35, %then6 ]
  store double %t41, double* %l3
  %t42 = load double, double* %l2
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  store double %t44, double* %l2
  %t45 = load double, double* %l3
  %t46 = load double, double* %l2
  br label %merge8
else7:
  %t47 = load i8, i8* %l4
  %t48 = icmp eq i8 %t47, 62
  %t49 = load i8*, i8** %l0
  %t50 = load double, double* %l1
  %t51 = load double, double* %l2
  %t52 = load double, double* %l3
  %t53 = load i8, i8* %l4
  br i1 %t48, label %then11, label %merge12
then11:
  %t54 = load double, double* %l2
  %t55 = sitofp i64 0 to double
  %t56 = fcmp oeq double %t54, %t55
  %t57 = load i8*, i8** %l0
  %t58 = load double, double* %l1
  %t59 = load double, double* %l2
  %t60 = load double, double* %l3
  %t61 = load i8, i8* %l4
  br i1 %t56, label %then13, label %merge14
then13:
  ret i8* null
merge14:
  %t62 = load double, double* %l2
  %t63 = sitofp i64 1 to double
  %t64 = fsub double %t62, %t63
  store double %t64, double* %l2
  %t65 = load double, double* %l2
  %t66 = sitofp i64 0 to double
  %t67 = fcmp oeq double %t65, %t66
  %t68 = load i8*, i8** %l0
  %t69 = load double, double* %l1
  %t70 = load double, double* %l2
  %t71 = load double, double* %l3
  %t72 = load i8, i8* %l4
  br i1 %t67, label %then15, label %merge16
then15:
  %t73 = load i8*, i8** %l0
  %t74 = load double, double* %l3
  %t75 = load double, double* %l1
  %t76 = call i8* @slice_text(i8* %t73, double %t74, double %t75)
  ret i8* %t76
merge16:
  %t77 = load double, double* %l2
  br label %merge12
merge12:
  %t78 = phi double [ %t77, %merge16 ], [ %t51, %else7 ]
  store double %t78, double* %l2
  %t79 = load double, double* %l2
  br label %merge8
merge8:
  %t80 = phi double [ %t45, %merge10 ], [ %t27, %merge12 ]
  %t81 = phi double [ %t46, %merge10 ], [ %t79, %merge12 ]
  store double %t80, double* %l3
  store double %t81, double* %l2
  %t82 = load double, double* %l1
  %t83 = sitofp i64 1 to double
  %t84 = fadd double %t82, %t83
  store double %t84, double* %l1
  br label %loop.latch2
loop.latch2:
  %t85 = load double, double* %l3
  %t86 = load double, double* %l2
  %t87 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t91 = load double, double* %l3
  %t92 = load double, double* %l2
  %t93 = load double, double* %l1
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
  %t176 = phi double [ %t17, %block.entry ], [ %t172, %loop.latch2 ]
  %t177 = phi i8* [ %t16, %block.entry ], [ %t173, %loop.latch2 ]
  %t178 = phi { i8**, i64 }* [ %t15, %block.entry ], [ %t174, %loop.latch2 ]
  %t179 = phi double [ %t18, %block.entry ], [ %t175, %loop.latch2 ]
  store double %t176, double* %l2
  store i8* %t177, i8** %l1
  store { i8**, i64 }* %t178, { i8**, i64 }** %l0
  store double %t179, double* %l3
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
  %t28 = fptosi double %t27 to i64
  %t29 = getelementptr i8, i8* %block, i64 %t28
  %t30 = load i8, i8* %t29
  store i8 %t30, i8* %l4
  %t31 = load i8, i8* %l4
  %t32 = icmp eq i8 %t31, 60
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load i8*, i8** %l1
  %t35 = load double, double* %l2
  %t36 = load double, double* %l3
  %t37 = load i8, i8* %l4
  br i1 %t32, label %then6, label %else7
then6:
  %t38 = load double, double* %l2
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l2
  %t41 = load i8*, i8** %l1
  %t42 = load i8, i8* %l4
  %t43 = alloca [2 x i8], align 1
  %t44 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  store i8 %t42, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 1
  store i8 0, i8* %t45
  %t46 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %t41, i8* %t46)
  store i8* %t47, i8** %l1
  %t48 = load double, double* %l2
  %t49 = load i8*, i8** %l1
  br label %merge8
else7:
  %t50 = load i8, i8* %l4
  %t51 = icmp eq i8 %t50, 62
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load i8*, i8** %l1
  %t54 = load double, double* %l2
  %t55 = load double, double* %l3
  %t56 = load i8, i8* %l4
  br i1 %t51, label %then9, label %else10
then9:
  %t57 = load double, double* %l2
  %t58 = sitofp i64 0 to double
  %t59 = fcmp ogt double %t57, %t58
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t61 = load i8*, i8** %l1
  %t62 = load double, double* %l2
  %t63 = load double, double* %l3
  %t64 = load i8, i8* %l4
  br i1 %t59, label %then12, label %merge13
then12:
  %t65 = load double, double* %l2
  %t66 = sitofp i64 1 to double
  %t67 = fsub double %t65, %t66
  store double %t67, double* %l2
  %t68 = load double, double* %l2
  br label %merge13
merge13:
  %t69 = phi double [ %t68, %then12 ], [ %t62, %then9 ]
  store double %t69, double* %l2
  %t70 = load i8*, i8** %l1
  %t71 = load i8, i8* %l4
  %t72 = alloca [2 x i8], align 1
  %t73 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 0
  store i8 %t71, i8* %t73
  %t74 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 1
  store i8 0, i8* %t74
  %t75 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 0
  %t76 = call i8* @sailfin_runtime_string_concat(i8* %t70, i8* %t75)
  store i8* %t76, i8** %l1
  %t77 = load double, double* %l2
  %t78 = load i8*, i8** %l1
  br label %merge11
else10:
  %t79 = load i8, i8* %l4
  %t80 = icmp eq i8 %t79, 44
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t82 = load i8*, i8** %l1
  %t83 = load double, double* %l2
  %t84 = load double, double* %l3
  %t85 = load i8, i8* %l4
  br i1 %t80, label %then14, label %else15
then14:
  %t86 = load double, double* %l2
  %t87 = sitofp i64 0 to double
  %t88 = fcmp oeq double %t86, %t87
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t90 = load i8*, i8** %l1
  %t91 = load double, double* %l2
  %t92 = load double, double* %l3
  %t93 = load i8, i8* %l4
  br i1 %t88, label %then17, label %merge18
then17:
  %t94 = load i8*, i8** %l1
  %t95 = call i8* @trim_text(i8* %t94)
  store i8* %t95, i8** %l5
  %t96 = load i8*, i8** %l5
  %t97 = call i64 @sailfin_runtime_string_length(i8* %t96)
  %t98 = icmp sgt i64 %t97, 0
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t100 = load i8*, i8** %l1
  %t101 = load double, double* %l2
  %t102 = load double, double* %l3
  %t103 = load i8, i8* %l4
  %t104 = load i8*, i8** %l5
  br i1 %t98, label %then19, label %merge20
then19:
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t106 = load i8*, i8** %l5
  %t107 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t108 = ptrtoint [1 x i8*]* %t107 to i64
  %t109 = icmp eq i64 %t108, 0
  %t110 = select i1 %t109, i64 1, i64 %t108
  %t111 = call i8* @malloc(i64 %t110)
  %t112 = bitcast i8* %t111 to i8**
  %t113 = getelementptr i8*, i8** %t112, i64 0
  store i8* %t106, i8** %t113
  %t114 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t115 = ptrtoint { i8**, i64 }* %t114 to i64
  %t116 = call i8* @malloc(i64 %t115)
  %t117 = bitcast i8* %t116 to { i8**, i64 }*
  %t118 = getelementptr { i8**, i64 }, { i8**, i64 }* %t117, i32 0, i32 0
  store i8** %t112, i8*** %t118
  %t119 = getelementptr { i8**, i64 }, { i8**, i64 }* %t117, i32 0, i32 1
  store i64 1, i64* %t119
  %t120 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t105, { i8**, i64 }* %t117)
  store { i8**, i64 }* %t120, { i8**, i64 }** %l0
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge20
merge20:
  %t122 = phi { i8**, i64 }* [ %t121, %then19 ], [ %t99, %then17 ]
  store { i8**, i64 }* %t122, { i8**, i64 }** %l0
  %s123 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s123, i8** %l1
  %t124 = load double, double* %l3
  %t125 = sitofp i64 1 to double
  %t126 = fadd double %t124, %t125
  store double %t126, double* %l3
  br label %loop.latch2
merge18:
  %t127 = load i8*, i8** %l1
  %t128 = load i8, i8* %l4
  %t129 = alloca [2 x i8], align 1
  %t130 = getelementptr [2 x i8], [2 x i8]* %t129, i32 0, i32 0
  store i8 %t128, i8* %t130
  %t131 = getelementptr [2 x i8], [2 x i8]* %t129, i32 0, i32 1
  store i8 0, i8* %t131
  %t132 = getelementptr [2 x i8], [2 x i8]* %t129, i32 0, i32 0
  %t133 = call i8* @sailfin_runtime_string_concat(i8* %t127, i8* %t132)
  store i8* %t133, i8** %l1
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t135 = load i8*, i8** %l1
  %t136 = load double, double* %l3
  %t137 = load i8*, i8** %l1
  br label %merge16
else15:
  %t138 = load i8*, i8** %l1
  %t139 = load i8, i8* %l4
  %t140 = alloca [2 x i8], align 1
  %t141 = getelementptr [2 x i8], [2 x i8]* %t140, i32 0, i32 0
  store i8 %t139, i8* %t141
  %t142 = getelementptr [2 x i8], [2 x i8]* %t140, i32 0, i32 1
  store i8 0, i8* %t142
  %t143 = getelementptr [2 x i8], [2 x i8]* %t140, i32 0, i32 0
  %t144 = call i8* @sailfin_runtime_string_concat(i8* %t138, i8* %t143)
  store i8* %t144, i8** %l1
  %t145 = load i8*, i8** %l1
  br label %merge16
merge16:
  %t146 = phi { i8**, i64 }* [ %t134, %merge18 ], [ %t81, %else15 ]
  %t147 = phi i8* [ %t135, %merge18 ], [ %t145, %else15 ]
  %t148 = phi double [ %t136, %merge18 ], [ %t84, %else15 ]
  store { i8**, i64 }* %t146, { i8**, i64 }** %l0
  store i8* %t147, i8** %l1
  store double %t148, double* %l3
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t150 = load i8*, i8** %l1
  %t151 = load double, double* %l3
  %t152 = load i8*, i8** %l1
  %t153 = load i8*, i8** %l1
  br label %merge11
merge11:
  %t154 = phi double [ %t77, %merge13 ], [ %t54, %merge16 ]
  %t155 = phi i8* [ %t78, %merge13 ], [ %t150, %merge16 ]
  %t156 = phi { i8**, i64 }* [ %t52, %merge13 ], [ %t149, %merge16 ]
  %t157 = phi double [ %t55, %merge13 ], [ %t151, %merge16 ]
  store double %t154, double* %l2
  store i8* %t155, i8** %l1
  store { i8**, i64 }* %t156, { i8**, i64 }** %l0
  store double %t157, double* %l3
  %t158 = load double, double* %l2
  %t159 = load i8*, i8** %l1
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t161 = load i8*, i8** %l1
  %t162 = load double, double* %l3
  %t163 = load i8*, i8** %l1
  %t164 = load i8*, i8** %l1
  br label %merge8
merge8:
  %t165 = phi double [ %t48, %then6 ], [ %t158, %merge11 ]
  %t166 = phi i8* [ %t49, %then6 ], [ %t159, %merge11 ]
  %t167 = phi { i8**, i64 }* [ %t33, %then6 ], [ %t160, %merge11 ]
  %t168 = phi double [ %t36, %then6 ], [ %t162, %merge11 ]
  store double %t165, double* %l2
  store i8* %t166, i8** %l1
  store { i8**, i64 }* %t167, { i8**, i64 }** %l0
  store double %t168, double* %l3
  %t169 = load double, double* %l3
  %t170 = sitofp i64 1 to double
  %t171 = fadd double %t169, %t170
  store double %t171, double* %l3
  br label %loop.latch2
loop.latch2:
  %t172 = load double, double* %l2
  %t173 = load i8*, i8** %l1
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t175 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t180 = load double, double* %l2
  %t181 = load i8*, i8** %l1
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t183 = load double, double* %l3
  %t184 = load i8*, i8** %l1
  %t185 = call i8* @trim_text(i8* %t184)
  store i8* %t185, i8** %l6
  %t186 = load i8*, i8** %l6
  %t187 = call i64 @sailfin_runtime_string_length(i8* %t186)
  %t188 = icmp sgt i64 %t187, 0
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t190 = load i8*, i8** %l1
  %t191 = load double, double* %l2
  %t192 = load double, double* %l3
  %t193 = load i8*, i8** %l6
  br i1 %t188, label %then21, label %merge22
then21:
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t195 = load i8*, i8** %l6
  %t196 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t197 = ptrtoint [1 x i8*]* %t196 to i64
  %t198 = icmp eq i64 %t197, 0
  %t199 = select i1 %t198, i64 1, i64 %t197
  %t200 = call i8* @malloc(i64 %t199)
  %t201 = bitcast i8* %t200 to i8**
  %t202 = getelementptr i8*, i8** %t201, i64 0
  store i8* %t195, i8** %t202
  %t203 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t204 = ptrtoint { i8**, i64 }* %t203 to i64
  %t205 = call i8* @malloc(i64 %t204)
  %t206 = bitcast i8* %t205 to { i8**, i64 }*
  %t207 = getelementptr { i8**, i64 }, { i8**, i64 }* %t206, i32 0, i32 0
  store i8** %t201, i8*** %t207
  %t208 = getelementptr { i8**, i64 }, { i8**, i64 }* %t206, i32 0, i32 1
  store i64 1, i64* %t208
  %t209 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t194, { i8**, i64 }* %t206)
  store { i8**, i64 }* %t209, { i8**, i64 }** %l0
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge22
merge22:
  %t211 = phi { i8**, i64 }* [ %t210, %then21 ], [ %t189, %afterloop3 ]
  store { i8**, i64 }* %t211, { i8**, i64 }** %l0
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t212
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
  %t25 = phi double [ %t3, %block.entry ], [ %t24, %loop.latch2 ]
  store double %t25, double* %l0
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
  %t14 = alloca [2 x i8], align 1
  %t15 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  store i8 %t13, i8* %t15
  %t16 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 1
  store i8 0, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  %t18 = call i1 @is_whitespace(i8* %t17)
  %t19 = load double, double* %l0
  %t20 = load double, double* %l1
  br i1 %t18, label %then6, label %merge7
then6:
  %t21 = load double, double* %l0
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
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
  %t28 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t51 = phi double [ %t28, %afterloop3 ], [ %t50, %loop.latch10 ]
  store double %t51, double* %l1
  br label %loop.body9
loop.body9:
  %t29 = load double, double* %l1
  %t30 = load double, double* %l0
  %t31 = fcmp ole double %t29, %t30
  %t32 = load double, double* %l0
  %t33 = load double, double* %l1
  br i1 %t31, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t34 = load double, double* %l1
  %t35 = sitofp i64 1 to double
  %t36 = fsub double %t34, %t35
  %t37 = fptosi double %t36 to i64
  %t38 = getelementptr i8, i8* %value, i64 %t37
  %t39 = load i8, i8* %t38
  %t40 = alloca [2 x i8], align 1
  %t41 = getelementptr [2 x i8], [2 x i8]* %t40, i32 0, i32 0
  store i8 %t39, i8* %t41
  %t42 = getelementptr [2 x i8], [2 x i8]* %t40, i32 0, i32 1
  store i8 0, i8* %t42
  %t43 = getelementptr [2 x i8], [2 x i8]* %t40, i32 0, i32 0
  %t44 = call i1 @is_whitespace(i8* %t43)
  %t45 = load double, double* %l0
  %t46 = load double, double* %l1
  br i1 %t44, label %then14, label %merge15
then14:
  %t47 = load double, double* %l1
  %t48 = sitofp i64 1 to double
  %t49 = fsub double %t47, %t48
  store double %t49, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t50 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t52 = load double, double* %l1
  %t53 = load double, double* %l0
  %t54 = load double, double* %l1
  %t55 = call i8* @slice_text(i8* %value, double %t53, double %t54)
  ret i8* %t55
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
  %t52 = phi i8* [ %t28, %merge5 ], [ %t50, %loop.latch8 ]
  %t53 = phi double [ %t29, %merge5 ], [ %t51, %loop.latch8 ]
  store i8* %t52, i8** %l2
  store double %t53, double* %l3
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
  %t39 = fptosi double %t38 to i64
  %t40 = getelementptr i8, i8* %value, i64 %t39
  %t41 = load i8, i8* %t40
  %t42 = alloca [2 x i8], align 1
  %t43 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  store i8 %t41, i8* %t43
  %t44 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 1
  store i8 0, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t37, i8* %t45)
  store i8* %t46, i8** %l2
  %t47 = load double, double* %l3
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l3
  br label %loop.latch8
loop.latch8:
  %t50 = load i8*, i8** %l2
  %t51 = load double, double* %l3
  br label %loop.header6
afterloop9:
  %t54 = load i8*, i8** %l2
  %t55 = load double, double* %l3
  %t56 = load i8*, i8** %l2
  ret i8* %t56
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
  %t112 = phi { %Diagnostic*, i64 }* [ %t15, %block.entry ], [ %t110, %loop.latch2 ]
  %t113 = phi double [ %t16, %block.entry ], [ %t111, %loop.latch2 ]
  store { %Diagnostic*, i64 }* %t112, { %Diagnostic*, i64 }** %l1
  store double %t113, double* %l2
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
  %t28 = fptosi double %t27 to i64
  %t29 = load { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t26
  %t30 = extractvalue { %EffectViolation*, i64 } %t29, 0
  %t31 = extractvalue { %EffectViolation*, i64 } %t29, 1
  %t32 = icmp uge i64 %t28, %t31
  ; bounds check: %t32 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t28, i64 %t31)
  %t33 = getelementptr %EffectViolation, %EffectViolation* %t30, i64 %t28
  %t34 = load %EffectViolation, %EffectViolation* %t33
  store %EffectViolation %t34, %EffectViolation* %l3
  %t35 = sitofp i64 0 to double
  store double %t35, double* %l4
  %t36 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t37 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t38 = load double, double* %l2
  %t39 = load %EffectViolation, %EffectViolation* %l3
  %t40 = load double, double* %l4
  br label %loop.header6
loop.header6:
  %t103 = phi { %Diagnostic*, i64 }* [ %t37, %merge5 ], [ %t101, %loop.latch8 ]
  %t104 = phi double [ %t40, %merge5 ], [ %t102, %loop.latch8 ]
  store { %Diagnostic*, i64 }* %t103, { %Diagnostic*, i64 }** %l1
  store double %t104, double* %l4
  br label %loop.body7
loop.body7:
  %t41 = load double, double* %l4
  %t42 = load %EffectViolation, %EffectViolation* %l3
  %t43 = extractvalue %EffectViolation %t42, 1
  %t44 = load { i8**, i64 }, { i8**, i64 }* %t43
  %t45 = extractvalue { i8**, i64 } %t44, 1
  %t46 = sitofp i64 %t45 to double
  %t47 = fcmp oge double %t41, %t46
  %t48 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t49 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t50 = load double, double* %l2
  %t51 = load %EffectViolation, %EffectViolation* %l3
  %t52 = load double, double* %l4
  br i1 %t47, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t53 = load %EffectViolation, %EffectViolation* %l3
  %t54 = extractvalue %EffectViolation %t53, 1
  %t55 = load double, double* %l4
  %t56 = fptosi double %t55 to i64
  %t57 = load { i8**, i64 }, { i8**, i64 }* %t54
  %t58 = extractvalue { i8**, i64 } %t57, 0
  %t59 = extractvalue { i8**, i64 } %t57, 1
  %t60 = icmp uge i64 %t56, %t59
  ; bounds check: %t60 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t56, i64 %t59)
  %t61 = getelementptr i8*, i8** %t58, i64 %t56
  %t62 = load i8*, i8** %t61
  store i8* %t62, i8** %l5
  %t63 = load %EffectViolation, %EffectViolation* %l3
  %t64 = extractvalue %EffectViolation %t63, 2
  %t65 = load i8*, i8** %l5
  %t66 = bitcast { %EffectRequirement**, i64 }* %t64 to { %EffectRequirement*, i64 }*
  %t67 = call %EffectRequirement* @select_requirement_for_effect({ %EffectRequirement*, i64 }* %t66, i8* %t65)
  store %EffectRequirement* %t67, %EffectRequirement** %l6
  %t68 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %s69 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h902271367, i32 0, i32 0
  %t70 = insertvalue %Diagnostic undef, i8* %s69, 0
  %t71 = load %EffectViolation, %EffectViolation* %l3
  %t72 = extractvalue %EffectViolation %t71, 0
  %t73 = load i8*, i8** %l5
  %t74 = load %EffectRequirement*, %EffectRequirement** %l6
  %t75 = call i8* @format_effect_message(i8* %t72, i8* %t73, %EffectRequirement* %t74)
  %t76 = insertvalue %Diagnostic %t70, i8* %t75, 1
  %t77 = load %EffectRequirement*, %EffectRequirement** %l6
  %t78 = call %Token* @requirement_primary_token(%EffectRequirement* %t77)
  %t79 = insertvalue %Diagnostic %t76, %Token* %t78, 2
  %t80 = call noalias i8* @malloc(i64 24)
  %t81 = bitcast i8* %t80 to %Diagnostic*
  store %Diagnostic %t79, %Diagnostic* %t81
  %t82 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t83 = ptrtoint [1 x i8*]* %t82 to i64
  %t84 = icmp eq i64 %t83, 0
  %t85 = select i1 %t84, i64 1, i64 %t83
  %t86 = call i8* @malloc(i64 %t85)
  %t87 = bitcast i8* %t86 to i8**
  %t88 = getelementptr i8*, i8** %t87, i64 0
  store i8* %t80, i8** %t88
  %t89 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t90 = ptrtoint { i8**, i64 }* %t89 to i64
  %t91 = call i8* @malloc(i64 %t90)
  %t92 = bitcast i8* %t91 to { i8**, i64 }*
  %t93 = getelementptr { i8**, i64 }, { i8**, i64 }* %t92, i32 0, i32 0
  store i8** %t87, i8*** %t93
  %t94 = getelementptr { i8**, i64 }, { i8**, i64 }* %t92, i32 0, i32 1
  store i64 1, i64* %t94
  %t95 = bitcast { %Diagnostic*, i64 }* %t68 to { i8**, i64 }*
  %t96 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t95, { i8**, i64 }* %t92)
  %t97 = bitcast { i8**, i64 }* %t96 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t97, { %Diagnostic*, i64 }** %l1
  %t98 = load double, double* %l4
  %t99 = sitofp i64 1 to double
  %t100 = fadd double %t98, %t99
  store double %t100, double* %l4
  br label %loop.latch8
loop.latch8:
  %t101 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t102 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t105 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t106 = load double, double* %l4
  %t107 = load double, double* %l2
  %t108 = sitofp i64 1 to double
  %t109 = fadd double %t107, %t108
  store double %t109, double* %l2
  br label %loop.latch2
loop.latch2:
  %t110 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t111 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t114 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t115 = load double, double* %l2
  %t116 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t116
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
  %t27 = phi double [ %t1, %block.entry ], [ %t26, %loop.latch2 ]
  store double %t27, double* %l0
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
  %t9 = fptosi double %t8 to i64
  %t10 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %requirements
  %t11 = extractvalue { %EffectRequirement*, i64 } %t10, 0
  %t12 = extractvalue { %EffectRequirement*, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t9, i64 %t12)
  %t14 = getelementptr %EffectRequirement, %EffectRequirement* %t11, i64 %t9
  %t15 = load %EffectRequirement, %EffectRequirement* %t14
  store %EffectRequirement %t15, %EffectRequirement* %l1
  %t16 = load %EffectRequirement, %EffectRequirement* %l1
  %t17 = extractvalue %EffectRequirement %t16, 0
  %t18 = icmp eq i8* %t17, %effect
  %t19 = load double, double* %l0
  %t20 = load %EffectRequirement, %EffectRequirement* %l1
  br i1 %t18, label %then6, label %merge7
then6:
  %t21 = load %EffectRequirement, %EffectRequirement* %l1
  %t22 = alloca %EffectRequirement
  store %EffectRequirement %t21, %EffectRequirement* %t22
  ret %EffectRequirement* %t22
merge7:
  %t23 = load double, double* %l0
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l0
  br label %loop.latch2
loop.latch2:
  %t26 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t28 = load double, double* %l0
  %t29 = bitcast i8* null to %EffectRequirement*
  ret %EffectRequirement* %t29
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
  %t10 = icmp eq i8* %t9, %candidate
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
  %t11 = icmp eq i8* %t10, %name
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
  %t24 = phi double [ %t4, %merge1 ], [ %t23, %loop.latch4 ]
  store double %t24, double* %l0
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
  %t11 = fptosi double %t10 to i64
  %t12 = getelementptr i8, i8* %value, i64 %t11
  %t13 = load i8, i8* %t12
  %t14 = load double, double* %l0
  %t15 = fptosi double %t14 to i64
  %t16 = getelementptr i8, i8* %prefix, i64 %t15
  %t17 = load i8, i8* %t16
  %t18 = icmp ne i8 %t13, %t17
  %t19 = load double, double* %l0
  br i1 %t18, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t20 = load double, double* %l0
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l0
  br label %loop.latch4
loop.latch4:
  %t23 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t25 = load double, double* %l0
  ret i1 1
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
@.enum.Statement.PipelineDeclaration.variant = private unnamed_addr constant [20 x i8] c"PipelineDeclaration\00"
@.enum.Statement.TestDeclaration.variant = private unnamed_addr constant [16 x i8] c"TestDeclaration\00"
@.str.len14.h980936743 = private unnamed_addr constant [15 x i8] c"; required by \00"
@.str.len15.h571715647 = private unnamed_addr constant [16 x i8] c"ToolDeclaration\00"
@.str.len4.h275477867 = private unnamed_addr constant [5 x i8] c"test\00"
@.enum.Statement.VariableDeclaration.variant = private unnamed_addr constant [20 x i8] c"VariableDeclaration\00"
@.enum.Statement.IfStatement.variant = private unnamed_addr constant [12 x i8] c"IfStatement\00"
@.str.len16.h994638848 = private unnamed_addr constant [17 x i8] c"interface member\00"
@.str.len13.h1925822000 = private unnamed_addr constant [14 x i8] c"WithStatement\00"
@.str.len16.h2043328844 = private unnamed_addr constant [17 x i8] c"ModelDeclaration\00"
@.str.len11.h1566780570 = private unnamed_addr constant [12 x i8] c"IfStatement\00"
@.enum.Statement.InterfaceDeclaration.variant = private unnamed_addr constant [21 x i8] c"InterfaceDeclaration\00"
@.enum.Statement.MatchStatement.variant = private unnamed_addr constant [15 x i8] c"MatchStatement\00"
@.enum.Statement.Unknown.variant = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.str.len19.h479148896 = private unnamed_addr constant [20 x i8] c"PipelineDeclaration\00"
@.str.len9.h1313193687 = private unnamed_addr constant [10 x i8] c"interface\00"
@.str.len12.h766506979 = private unnamed_addr constant [13 x i8] c"struct field\00"
@.str.len12.h84042670 = private unnamed_addr constant [13 x i8] c"ForStatement\00"
@.str.len4.h258014432 = private unnamed_addr constant [5 x i8] c"enum\00"
@.str.len8.h1603982015 = private unnamed_addr constant [9 x i8] c"function\00"
@.enum.Statement.StructDeclaration.variant = private unnamed_addr constant [18 x i8] c"StructDeclaration\00"
@.str.len14.h196308685 = private unnamed_addr constant [15 x i8] c"MatchStatement\00"
@.enum.Statement.ExpressionStatement.variant = private unnamed_addr constant [20 x i8] c"ExpressionStatement\00"
@.str.len14.h513489323 = private unnamed_addr constant [15 x i8] c"type parameter\00"
@.str.len14.h812083909 = private unnamed_addr constant [15 x i8] c"model property\00"
@.enum.Statement.PromptStatement.variant = private unnamed_addr constant [16 x i8] c"PromptStatement\00"
@.str.len19.h486335986 = private unnamed_addr constant [20 x i8] c"FunctionDeclaration\00"
@.enum.Statement.ReturnStatement.variant = private unnamed_addr constant [16 x i8] c"ReturnStatement\00"
@.str.len15.h579804543 = private unnamed_addr constant [16 x i8] c"EnumDeclaration\00"
@.str.len19.h1204027478 = private unnamed_addr constant [20 x i8] c"VariableDeclaration\00"
@.str.len4.h276192845 = private unnamed_addr constant [5 x i8] c"type\00"
@.str.len6.h789690461 = private unnamed_addr constant [7 x i8] c"struct\00"
@.enum.Statement.LoopStatement.variant = private unnamed_addr constant [14 x i8] c"LoopStatement\00"
@.str.len12.h328844387 = private unnamed_addr constant [13 x i8] c"enum variant\00"
@.str.len8.h1925814595 = private unnamed_addr constant [9 x i8] c"variable\00"
@.enum.Statement.ExportDeclaration.variant = private unnamed_addr constant [18 x i8] c"ExportDeclaration\00"
@.str.len15.h902271367 = private unnamed_addr constant [16 x i8] c"effects.missing\00"
@.enum.Statement.ForStatement.variant = private unnamed_addr constant [13 x i8] c"ForStatement\00"
@.enum.Statement.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.enum.Statement.EnumDeclaration.variant = private unnamed_addr constant [16 x i8] c"EnumDeclaration\00"
@.str.len20.h1496093543 = private unnamed_addr constant [21 x i8] c"TypeAliasDeclaration\00"
@.str.len17.h1842783069 = private unnamed_addr constant [18 x i8] c"StructDeclaration\00"
@.str.len5.h238194529 = private unnamed_addr constant [6 x i8] c"model\00"
@.str.len4.h275832617 = private unnamed_addr constant [5 x i8] c"tool\00"
@.str.len8.h2003786807 = private unnamed_addr constant [9 x i8] c"pipeline\00"
@.enum.Statement.FunctionDeclaration.variant = private unnamed_addr constant [20 x i8] c"FunctionDeclaration\00"
@.enum.Statement.BreakStatement.variant = private unnamed_addr constant [15 x i8] c"BreakStatement\00"
@.str.len15.h889179835 = private unnamed_addr constant [16 x i8] c"TestDeclaration\00"
@.str.len20.h666604742 = private unnamed_addr constant [21 x i8] c"InterfaceDeclaration\00"
@.enum.Statement.TypeAliasDeclaration.variant = private unnamed_addr constant [21 x i8] c"TypeAliasDeclaration\00"
@.str.len9.h1747065903 = private unnamed_addr constant [10 x i8] c"parameter\00"
@.enum.Statement.ToolDeclaration.variant = private unnamed_addr constant [16 x i8] c"ToolDeclaration\00"
@.str.len15.h1067284810 = private unnamed_addr constant [16 x i8] c"PromptStatement\00"
@.str.len6.h1045703541 = private unnamed_addr constant [7 x i8] c"method\00"
@.enum.Statement.ModelDeclaration.variant = private unnamed_addr constant [17 x i8] c"ModelDeclaration\00"
@.enum.Statement.ContinueStatement.variant = private unnamed_addr constant [18 x i8] c"ContinueStatement\00"
@.enum.Statement.WithStatement.variant = private unnamed_addr constant [14 x i8] c"WithStatement\00"
@.enum.Statement.ImportDeclaration.variant = private unnamed_addr constant [18 x i8] c"ImportDeclaration\00"
