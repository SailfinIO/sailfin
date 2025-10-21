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

declare i8* @sailfin_runtime_get_field(i8*, i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

@.str.153 = private unnamed_addr constant [3 x i8] c", \00"
@.str.5 = private unnamed_addr constant [1 x i8] c"\00"
@.str.22 = private unnamed_addr constant [1 x i8] c"\00"
@.str.0 = private unnamed_addr constant [21 x i8] c" is missing effect '\00"
@.str.17 = private unnamed_addr constant [15 x i8] c". hint: add ![\00"
@.str.2 = private unnamed_addr constant [8 x i8] c"struct \00"
@.str.4 = private unnamed_addr constant [13 x i8] c" implements \00"
@.str.7 = private unnamed_addr constant [19 x i8] c" but must specify \00"
@.str.10 = private unnamed_addr constant [16 x i8] c" type arguments\00"

define %TypecheckResult @typecheck_program(%Program %program) {
entry:
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
entry:
  %l0 = alloca { %Statement*, i64 }*
  %l1 = alloca i64
  %l2 = alloca %Statement*
  %t0 = alloca [0 x %Statement]
  %t1 = getelementptr [0 x %Statement], [0 x %Statement]* %t0, i32 0, i32 0
  %t2 = alloca { %Statement*, i64 }
  %t3 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t2, i32 0, i32 0
  store %Statement* %t1, %Statement** %t3
  %t4 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Statement*, i64 }* %t2, { %Statement*, i64 }** %l0
  %t5 = extractvalue %Program %program, 0
  %t6 = getelementptr { %Statement**, i64 }, { %Statement**, i64 }* %t5, i32 0, i32 1
  %t7 = load i64, i64* %t6
  %t8 = getelementptr { %Statement**, i64 }, { %Statement**, i64 }* %t5, i32 0, i32 0
  %t9 = load %Statement**, %Statement*** %t8
  store i64 0, i64* %l1
  store %Statement* null, %Statement** %l2
  br label %for0
for0:
  %t10 = load i64, i64* %l1
  %t11 = icmp slt i64 %t10, %t7
  br i1 %t11, label %forbody1, label %afterfor3
forbody1:
  %t12 = load i64, i64* %l1
  %t13 = getelementptr %Statement*, %Statement** %t9, i64 %t12
  %t14 = load %Statement*, %Statement** %t13
  store %Statement* %t14, %Statement** %l2
  %t15 = load %Statement*, %Statement** %l2
  %t16 = getelementptr inbounds %Statement, %Statement* %t15, i32 0, i32 0
  %t17 = load i32, i32* %t16
  %t18 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t19 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t20 = icmp eq i32 %t17, 0
  %t21 = select i1 %t20, i8* %t19, i8* %t18
  %t22 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t23 = icmp eq i32 %t17, 1
  %t24 = select i1 %t23, i8* %t22, i8* %t21
  %t25 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t17, 2
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t17, 3
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %t31 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t32 = icmp eq i32 %t17, 4
  %t33 = select i1 %t32, i8* %t31, i8* %t30
  %t34 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t17, 5
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %t37 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t17, 6
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %t40 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t41 = icmp eq i32 %t17, 7
  %t42 = select i1 %t41, i8* %t40, i8* %t39
  %t43 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t44 = icmp eq i32 %t17, 8
  %t45 = select i1 %t44, i8* %t43, i8* %t42
  %t46 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t47 = icmp eq i32 %t17, 9
  %t48 = select i1 %t47, i8* %t46, i8* %t45
  %t49 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t50 = icmp eq i32 %t17, 10
  %t51 = select i1 %t50, i8* %t49, i8* %t48
  %t52 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t53 = icmp eq i32 %t17, 11
  %t54 = select i1 %t53, i8* %t52, i8* %t51
  %t55 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t17, 12
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t17, 13
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t17, 14
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t17, 15
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t17, 16
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t17, 17
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t17, 18
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %t76 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t17, 19
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %t79 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t17, 20
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t17, 21
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %t85 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t17, 22
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %s88 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.88, i32 0, i32 0
  %t89 = icmp eq i8* %t87, %s88
  %t90 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  %t91 = load %Statement*, %Statement** %l2
  br i1 %t89, label %then4, label %merge5
then4:
  %t92 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  %t93 = load %Statement*, %Statement** %l2
  %t94 = bitcast %Statement* %t93 to i8*
  %t95 = alloca [1 x i8*]
  %t96 = getelementptr [1 x i8*], [1 x i8*]* %t95, i32 0, i32 0
  %t97 = getelementptr i8*, i8** %t96, i64 0
  store i8* %t94, i8** %t97
  %t98 = alloca { i8**, i64 }
  %t99 = getelementptr { i8**, i64 }, { i8**, i64 }* %t98, i32 0, i32 0
  store i8** %t96, i8*** %t99
  %t100 = getelementptr { i8**, i64 }, { i8**, i64 }* %t98, i32 0, i32 1
  store i64 1, i64* %t100
  %t101 = bitcast { %Statement*, i64 }* %t92 to { i8**, i64 }*
  %t102 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t101, { i8**, i64 }* %t98)
  %t103 = bitcast { i8**, i64 }* %t102 to { %Statement*, i64 }*
  store { %Statement*, i64 }* %t103, { %Statement*, i64 }** %l0
  br label %merge5
merge5:
  %t104 = phi { %Statement*, i64 }* [ %t103, %then4 ], [ %t90, %forbody1 ]
  store { %Statement*, i64 }* %t104, { %Statement*, i64 }** %l0
  br label %forinc2
forinc2:
  %t105 = load i64, i64* %l1
  %t106 = add i64 %t105, 1
  store i64 %t106, i64* %l1
  br label %for0
afterfor3:
  %t107 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  ret { %Statement*, i64 }* %t107
}

define %SymbolCollectionResult @collect_top_level_symbols(%Program %program) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %Statement*
  %l4 = alloca %SymbolCollectionResult
  %t0 = alloca [0 x %SymbolEntry]
  %t1 = getelementptr [0 x %SymbolEntry], [0 x %SymbolEntry]* %t0, i32 0, i32 0
  %t2 = alloca { %SymbolEntry*, i64 }
  %t3 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t2, i32 0, i32 0
  store %SymbolEntry* %t1, %SymbolEntry** %t3
  %t4 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %SymbolEntry*, i64 }* %t2, { %SymbolEntry*, i64 }** %l0
  %t5 = alloca [0 x %Diagnostic]
  %t6 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t5, i32 0, i32 0
  %t7 = alloca { %Diagnostic*, i64 }
  %t8 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 0
  store %Diagnostic* %t6, %Diagnostic** %t8
  %t9 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %Diagnostic*, i64 }* %t7, { %Diagnostic*, i64 }** %l1
  %t10 = extractvalue %Program %program, 0
  %t11 = getelementptr { %Statement**, i64 }, { %Statement**, i64 }* %t10, i32 0, i32 1
  %t12 = load i64, i64* %t11
  %t13 = getelementptr { %Statement**, i64 }, { %Statement**, i64 }* %t10, i32 0, i32 0
  %t14 = load %Statement**, %Statement*** %t13
  store i64 0, i64* %l2
  store %Statement* null, %Statement** %l3
  br label %for0
for0:
  %t15 = load i64, i64* %l2
  %t16 = icmp slt i64 %t15, %t12
  br i1 %t16, label %forbody1, label %afterfor3
forbody1:
  %t17 = load i64, i64* %l2
  %t18 = getelementptr %Statement*, %Statement** %t14, i64 %t17
  %t19 = load %Statement*, %Statement** %t18
  store %Statement* %t19, %Statement** %l3
  %t20 = load %Statement*, %Statement** %l3
  %t21 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t22 = load %Statement, %Statement* %t20
  %t23 = call %SymbolCollectionResult @register_top_level_symbol(%Statement %t22, { %SymbolEntry*, i64 }* %t21)
  store %SymbolCollectionResult %t23, %SymbolCollectionResult* %l4
  %t24 = load %SymbolCollectionResult, %SymbolCollectionResult* %l4
  %t25 = extractvalue %SymbolCollectionResult %t24, 0
  %t26 = bitcast { %SymbolEntry**, i64 }* %t25 to { %SymbolEntry*, i64 }*
  store { %SymbolEntry*, i64 }* %t26, { %SymbolEntry*, i64 }** %l0
  %t27 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t28 = load %SymbolCollectionResult, %SymbolCollectionResult* %l4
  %t29 = extractvalue %SymbolCollectionResult %t28, 1
  %t30 = bitcast { %Diagnostic*, i64 }* %t27 to { i8**, i64 }*
  %t31 = bitcast { %Diagnostic**, i64 }* %t29 to { i8**, i64 }*
  %t32 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t30, { i8**, i64 }* %t31)
  %t33 = bitcast { i8**, i64 }* %t32 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t33, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t34 = load i64, i64* %l2
  %t35 = add i64 %t34, 1
  store i64 %t35, i64* %l2
  br label %for0
afterfor3:
  %t36 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t37 = bitcast { %SymbolEntry*, i64 }* %t36 to { %SymbolEntry**, i64 }*
  %t38 = insertvalue %SymbolCollectionResult undef, { %SymbolEntry**, i64 }* %t37, 0
  %t39 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t40 = bitcast { %Diagnostic*, i64 }* %t39 to { %Diagnostic**, i64 }*
  %t41 = insertvalue %SymbolCollectionResult %t38, { %Diagnostic**, i64 }* %t40, 1
  ret %SymbolCollectionResult %t41
}

define %SymbolCollectionResult @register_top_level_symbol(%Statement %statement, { %SymbolEntry*, i64 }* %existing) {
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
  %s94 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.94, i32 0, i32 0
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
  %s188 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.188, i32 0, i32 0
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
  %s234 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.234, i32 0, i32 0
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
  %s351 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.351, i32 0, i32 0
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
  %s397 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.397, i32 0, i32 0
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
  %s514 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.514, i32 0, i32 0
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
  %s560 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.560, i32 0, i32 0
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
  %s677 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.677, i32 0, i32 0
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
  %s723 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.723, i32 0, i32 0
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
  %s840 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.840, i32 0, i32 0
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
  %s863 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.863, i32 0, i32 0
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
  %s957 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.957, i32 0, i32 0
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
  %s980 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.980, i32 0, i32 0
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
  %s1074 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1074, i32 0, i32 0
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
  %s1120 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1120, i32 0, i32 0
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
  %s1237 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.1237, i32 0, i32 0
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
  %s1283 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1283, i32 0, i32 0
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
  %s1400 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1400, i32 0, i32 0
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
  %s1446 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1446, i32 0, i32 0
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
  %t1473 = alloca [0 x %Diagnostic*]
  %t1474 = getelementptr [0 x %Diagnostic*], [0 x %Diagnostic*]* %t1473, i32 0, i32 0
  %t1475 = alloca { %Diagnostic**, i64 }
  %t1476 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t1475, i32 0, i32 0
  store %Diagnostic** %t1474, %Diagnostic*** %t1476
  %t1477 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t1475, i32 0, i32 1
  store i64 0, i64* %t1477
  %t1478 = insertvalue %SymbolCollectionResult %t1472, { %Diagnostic**, i64 }* %t1475, 1
  ret %SymbolCollectionResult %t1478
}

define { %Diagnostic*, i64 }* @check_program_scopes(%Program %program, { %Statement*, i64 }* %interfaces) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %Statement*
  %l4 = alloca %ScopeResult
  %t0 = alloca [0 x %SymbolEntry]
  %t1 = getelementptr [0 x %SymbolEntry], [0 x %SymbolEntry]* %t0, i32 0, i32 0
  %t2 = alloca { %SymbolEntry*, i64 }
  %t3 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t2, i32 0, i32 0
  store %SymbolEntry* %t1, %SymbolEntry** %t3
  %t4 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %SymbolEntry*, i64 }* %t2, { %SymbolEntry*, i64 }** %l0
  %t5 = alloca [0 x %Diagnostic]
  %t6 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t5, i32 0, i32 0
  %t7 = alloca { %Diagnostic*, i64 }
  %t8 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 0
  store %Diagnostic* %t6, %Diagnostic** %t8
  %t9 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %Diagnostic*, i64 }* %t7, { %Diagnostic*, i64 }** %l1
  %t10 = extractvalue %Program %program, 0
  %t11 = getelementptr { %Statement**, i64 }, { %Statement**, i64 }* %t10, i32 0, i32 1
  %t12 = load i64, i64* %t11
  %t13 = getelementptr { %Statement**, i64 }, { %Statement**, i64 }* %t10, i32 0, i32 0
  %t14 = load %Statement**, %Statement*** %t13
  store i64 0, i64* %l2
  store %Statement* null, %Statement** %l3
  br label %for0
for0:
  %t15 = load i64, i64* %l2
  %t16 = icmp slt i64 %t15, %t12
  br i1 %t16, label %forbody1, label %afterfor3
forbody1:
  %t17 = load i64, i64* %l2
  %t18 = getelementptr %Statement*, %Statement** %t14, i64 %t17
  %t19 = load %Statement*, %Statement** %t18
  store %Statement* %t19, %Statement** %l3
  %t20 = load %Statement*, %Statement** %l3
  %t21 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t22 = load %Statement, %Statement* %t20
  %t23 = call %ScopeResult @check_statement(%Statement %t22, { %SymbolEntry*, i64 }* %t21, { %Statement*, i64 }* %interfaces)
  store %ScopeResult %t23, %ScopeResult* %l4
  %t24 = load %ScopeResult, %ScopeResult* %l4
  %t25 = extractvalue %ScopeResult %t24, 0
  %t26 = bitcast { %SymbolEntry**, i64 }* %t25 to { %SymbolEntry*, i64 }*
  store { %SymbolEntry*, i64 }* %t26, { %SymbolEntry*, i64 }** %l0
  %t27 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t28 = load %ScopeResult, %ScopeResult* %l4
  %t29 = extractvalue %ScopeResult %t28, 1
  %t30 = bitcast { %Diagnostic*, i64 }* %t27 to { i8**, i64 }*
  %t31 = bitcast { %Diagnostic**, i64 }* %t29 to { i8**, i64 }*
  %t32 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t30, { i8**, i64 }* %t31)
  %t33 = bitcast { i8**, i64 }* %t32 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t33, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t34 = load i64, i64* %l2
  %t35 = add i64 %t34, 1
  store i64 %t35, i64* %l2
  br label %for0
afterfor3:
  %t36 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t36
}

define %ScopeResult @check_statement(%Statement %statement, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces) {
entry:
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
  %s71 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.71, i32 0, i32 0
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
  %s117 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.117, i32 0, i32 0
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
  %s213 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.213, i32 0, i32 0
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
  %s236 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.236, i32 0, i32 0
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
  %s446 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.446, i32 0, i32 0
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
  %s492 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.492, i32 0, i32 0
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
  %t672 = load %ScopeResult, %ScopeResult* %l3
  %t673 = extractvalue %ScopeResult %t672, 0
  %t674 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t673, 0
  %t675 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t676 = insertvalue %ScopeResult %t674, { %Diagnostic**, i64 }* %t675, 1
  ret %ScopeResult %t676
merge5:
  %t677 = extractvalue %Statement %statement, 0
  %t678 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t679 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t680 = icmp eq i32 %t677, 0
  %t681 = select i1 %t680, i8* %t679, i8* %t678
  %t682 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t683 = icmp eq i32 %t677, 1
  %t684 = select i1 %t683, i8* %t682, i8* %t681
  %t685 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t686 = icmp eq i32 %t677, 2
  %t687 = select i1 %t686, i8* %t685, i8* %t684
  %t688 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t689 = icmp eq i32 %t677, 3
  %t690 = select i1 %t689, i8* %t688, i8* %t687
  %t691 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t692 = icmp eq i32 %t677, 4
  %t693 = select i1 %t692, i8* %t691, i8* %t690
  %t694 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t695 = icmp eq i32 %t677, 5
  %t696 = select i1 %t695, i8* %t694, i8* %t693
  %t697 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t698 = icmp eq i32 %t677, 6
  %t699 = select i1 %t698, i8* %t697, i8* %t696
  %t700 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t701 = icmp eq i32 %t677, 7
  %t702 = select i1 %t701, i8* %t700, i8* %t699
  %t703 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t704 = icmp eq i32 %t677, 8
  %t705 = select i1 %t704, i8* %t703, i8* %t702
  %t706 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t707 = icmp eq i32 %t677, 9
  %t708 = select i1 %t707, i8* %t706, i8* %t705
  %t709 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t710 = icmp eq i32 %t677, 10
  %t711 = select i1 %t710, i8* %t709, i8* %t708
  %t712 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t713 = icmp eq i32 %t677, 11
  %t714 = select i1 %t713, i8* %t712, i8* %t711
  %t715 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t716 = icmp eq i32 %t677, 12
  %t717 = select i1 %t716, i8* %t715, i8* %t714
  %t718 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t719 = icmp eq i32 %t677, 13
  %t720 = select i1 %t719, i8* %t718, i8* %t717
  %t721 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t722 = icmp eq i32 %t677, 14
  %t723 = select i1 %t722, i8* %t721, i8* %t720
  %t724 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t725 = icmp eq i32 %t677, 15
  %t726 = select i1 %t725, i8* %t724, i8* %t723
  %t727 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t728 = icmp eq i32 %t677, 16
  %t729 = select i1 %t728, i8* %t727, i8* %t726
  %t730 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t731 = icmp eq i32 %t677, 17
  %t732 = select i1 %t731, i8* %t730, i8* %t729
  %t733 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t734 = icmp eq i32 %t677, 18
  %t735 = select i1 %t734, i8* %t733, i8* %t732
  %t736 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t737 = icmp eq i32 %t677, 19
  %t738 = select i1 %t737, i8* %t736, i8* %t735
  %t739 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t740 = icmp eq i32 %t677, 20
  %t741 = select i1 %t740, i8* %t739, i8* %t738
  %t742 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t743 = icmp eq i32 %t677, 21
  %t744 = select i1 %t743, i8* %t742, i8* %t741
  %t745 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t746 = icmp eq i32 %t677, 22
  %t747 = select i1 %t746, i8* %t745, i8* %t744
  %s748 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.748, i32 0, i32 0
  %t749 = icmp eq i8* %t747, %s748
  br i1 %t749, label %then12, label %merge13
then12:
  %t750 = extractvalue %Statement %statement, 0
  %t751 = alloca %Statement
  store %Statement %statement, %Statement* %t751
  %t752 = getelementptr inbounds %Statement, %Statement* %t751, i32 0, i32 1
  %t753 = bitcast [48 x i8]* %t752 to i8*
  %t754 = bitcast i8* %t753 to i8**
  %t755 = load i8*, i8** %t754
  %t756 = icmp eq i32 %t750, 2
  %t757 = select i1 %t756, i8* %t755, i8* null
  %t758 = getelementptr inbounds %Statement, %Statement* %t751, i32 0, i32 1
  %t759 = bitcast [48 x i8]* %t758 to i8*
  %t760 = bitcast i8* %t759 to i8**
  %t761 = load i8*, i8** %t760
  %t762 = icmp eq i32 %t750, 3
  %t763 = select i1 %t762, i8* %t761, i8* %t757
  %t764 = getelementptr inbounds %Statement, %Statement* %t751, i32 0, i32 1
  %t765 = bitcast [40 x i8]* %t764 to i8*
  %t766 = bitcast i8* %t765 to i8**
  %t767 = load i8*, i8** %t766
  %t768 = icmp eq i32 %t750, 6
  %t769 = select i1 %t768, i8* %t767, i8* %t763
  %t770 = getelementptr inbounds %Statement, %Statement* %t751, i32 0, i32 1
  %t771 = bitcast [56 x i8]* %t770 to i8*
  %t772 = bitcast i8* %t771 to i8**
  %t773 = load i8*, i8** %t772
  %t774 = icmp eq i32 %t750, 8
  %t775 = select i1 %t774, i8* %t773, i8* %t769
  %t776 = getelementptr inbounds %Statement, %Statement* %t751, i32 0, i32 1
  %t777 = bitcast [40 x i8]* %t776 to i8*
  %t778 = bitcast i8* %t777 to i8**
  %t779 = load i8*, i8** %t778
  %t780 = icmp eq i32 %t750, 9
  %t781 = select i1 %t780, i8* %t779, i8* %t775
  %t782 = getelementptr inbounds %Statement, %Statement* %t751, i32 0, i32 1
  %t783 = bitcast [40 x i8]* %t782 to i8*
  %t784 = bitcast i8* %t783 to i8**
  %t785 = load i8*, i8** %t784
  %t786 = icmp eq i32 %t750, 10
  %t787 = select i1 %t786, i8* %t785, i8* %t781
  %t788 = getelementptr inbounds %Statement, %Statement* %t751, i32 0, i32 1
  %t789 = bitcast [40 x i8]* %t788 to i8*
  %t790 = bitcast i8* %t789 to i8**
  %t791 = load i8*, i8** %t790
  %t792 = icmp eq i32 %t750, 11
  %t793 = select i1 %t792, i8* %t791, i8* %t787
  %s794 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.794, i32 0, i32 0
  %t795 = extractvalue %Statement %statement, 0
  %t796 = alloca %Statement
  store %Statement %statement, %Statement* %t796
  %t797 = getelementptr inbounds %Statement, %Statement* %t796, i32 0, i32 1
  %t798 = bitcast [48 x i8]* %t797 to i8*
  %t799 = getelementptr inbounds i8, i8* %t798, i64 8
  %t800 = bitcast i8* %t799 to %SourceSpan**
  %t801 = load %SourceSpan*, %SourceSpan** %t800
  %t802 = icmp eq i32 %t795, 3
  %t803 = select i1 %t802, %SourceSpan* %t801, %SourceSpan* null
  %t804 = getelementptr inbounds %Statement, %Statement* %t796, i32 0, i32 1
  %t805 = bitcast [40 x i8]* %t804 to i8*
  %t806 = getelementptr inbounds i8, i8* %t805, i64 8
  %t807 = bitcast i8* %t806 to %SourceSpan**
  %t808 = load %SourceSpan*, %SourceSpan** %t807
  %t809 = icmp eq i32 %t795, 6
  %t810 = select i1 %t809, %SourceSpan* %t808, %SourceSpan* %t803
  %t811 = getelementptr inbounds %Statement, %Statement* %t796, i32 0, i32 1
  %t812 = bitcast [56 x i8]* %t811 to i8*
  %t813 = getelementptr inbounds i8, i8* %t812, i64 8
  %t814 = bitcast i8* %t813 to %SourceSpan**
  %t815 = load %SourceSpan*, %SourceSpan** %t814
  %t816 = icmp eq i32 %t795, 8
  %t817 = select i1 %t816, %SourceSpan* %t815, %SourceSpan* %t810
  %t818 = getelementptr inbounds %Statement, %Statement* %t796, i32 0, i32 1
  %t819 = bitcast [40 x i8]* %t818 to i8*
  %t820 = getelementptr inbounds i8, i8* %t819, i64 8
  %t821 = bitcast i8* %t820 to %SourceSpan**
  %t822 = load %SourceSpan*, %SourceSpan** %t821
  %t823 = icmp eq i32 %t795, 9
  %t824 = select i1 %t823, %SourceSpan* %t822, %SourceSpan* %t817
  %t825 = getelementptr inbounds %Statement, %Statement* %t796, i32 0, i32 1
  %t826 = bitcast [40 x i8]* %t825 to i8*
  %t827 = getelementptr inbounds i8, i8* %t826, i64 8
  %t828 = bitcast i8* %t827 to %SourceSpan**
  %t829 = load %SourceSpan*, %SourceSpan** %t828
  %t830 = icmp eq i32 %t795, 10
  %t831 = select i1 %t830, %SourceSpan* %t829, %SourceSpan* %t824
  %t832 = getelementptr inbounds %Statement, %Statement* %t796, i32 0, i32 1
  %t833 = bitcast [40 x i8]* %t832 to i8*
  %t834 = getelementptr inbounds i8, i8* %t833, i64 8
  %t835 = bitcast i8* %t834 to %SourceSpan**
  %t836 = load %SourceSpan*, %SourceSpan** %t835
  %t837 = icmp eq i32 %t795, 11
  %t838 = select i1 %t837, %SourceSpan* %t836, %SourceSpan* %t831
  %t839 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t793, i8* %s794, %SourceSpan* %t838)
  store %ScopeResult %t839, %ScopeResult* %l7
  %t840 = load %ScopeResult, %ScopeResult* %l7
  %t841 = extractvalue %ScopeResult %t840, 1
  store { %Diagnostic**, i64 }* %t841, { %Diagnostic**, i64 }** %l8
  %t842 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l8
  %t843 = extractvalue %Statement %statement, 0
  %t844 = alloca %Statement
  store %Statement %statement, %Statement* %t844
  %t845 = getelementptr inbounds %Statement, %Statement* %t844, i32 0, i32 1
  %t846 = bitcast [56 x i8]* %t845 to i8*
  %t847 = getelementptr inbounds i8, i8* %t846, i64 16
  %t848 = bitcast i8* %t847 to { %TypeParameter**, i64 }**
  %t849 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t848
  %t850 = icmp eq i32 %t843, 8
  %t851 = select i1 %t850, { %TypeParameter**, i64 }* %t849, { %TypeParameter**, i64 }* null
  %t852 = getelementptr inbounds %Statement, %Statement* %t844, i32 0, i32 1
  %t853 = bitcast [40 x i8]* %t852 to i8*
  %t854 = getelementptr inbounds i8, i8* %t853, i64 16
  %t855 = bitcast i8* %t854 to { %TypeParameter**, i64 }**
  %t856 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t855
  %t857 = icmp eq i32 %t843, 9
  %t858 = select i1 %t857, { %TypeParameter**, i64 }* %t856, { %TypeParameter**, i64 }* %t851
  %t859 = getelementptr inbounds %Statement, %Statement* %t844, i32 0, i32 1
  %t860 = bitcast [40 x i8]* %t859 to i8*
  %t861 = getelementptr inbounds i8, i8* %t860, i64 16
  %t862 = bitcast i8* %t861 to { %TypeParameter**, i64 }**
  %t863 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t862
  %t864 = icmp eq i32 %t843, 10
  %t865 = select i1 %t864, { %TypeParameter**, i64 }* %t863, { %TypeParameter**, i64 }* %t858
  %t866 = getelementptr inbounds %Statement, %Statement* %t844, i32 0, i32 1
  %t867 = bitcast [40 x i8]* %t866 to i8*
  %t868 = getelementptr inbounds i8, i8* %t867, i64 16
  %t869 = bitcast i8* %t868 to { %TypeParameter**, i64 }**
  %t870 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t869
  %t871 = icmp eq i32 %t843, 11
  %t872 = select i1 %t871, { %TypeParameter**, i64 }* %t870, { %TypeParameter**, i64 }* %t865
  %t873 = bitcast { %TypeParameter**, i64 }* %t872 to { %TypeParameter*, i64 }*
  %t874 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t873)
  %t875 = bitcast { %Diagnostic**, i64 }* %t842 to { i8**, i64 }*
  %t876 = bitcast { %Diagnostic*, i64 }* %t874 to { i8**, i64 }*
  %t877 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t875, { i8**, i64 }* %t876)
  %t878 = bitcast { i8**, i64 }* %t877 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t878, { %Diagnostic**, i64 }** %l8
  %t879 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l8
  %t880 = extractvalue %Statement %statement, 0
  %t881 = alloca %Statement
  store %Statement %statement, %Statement* %t881
  %t882 = getelementptr inbounds %Statement, %Statement* %t881, i32 0, i32 1
  %t883 = bitcast [40 x i8]* %t882 to i8*
  %t884 = getelementptr inbounds i8, i8* %t883, i64 24
  %t885 = bitcast i8* %t884 to { %EnumVariant**, i64 }**
  %t886 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t885
  %t887 = icmp eq i32 %t880, 11
  %t888 = select i1 %t887, { %EnumVariant**, i64 }* %t886, { %EnumVariant**, i64 }* null
  %t889 = bitcast { %EnumVariant**, i64 }* %t888 to { %EnumVariant*, i64 }*
  %t890 = call { %Diagnostic*, i64 }* @check_enum_variants({ %EnumVariant*, i64 }* %t889)
  %t891 = bitcast { %Diagnostic**, i64 }* %t879 to { i8**, i64 }*
  %t892 = bitcast { %Diagnostic*, i64 }* %t890 to { i8**, i64 }*
  %t893 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t891, { i8**, i64 }* %t892)
  %t894 = bitcast { i8**, i64 }* %t893 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t894, { %Diagnostic**, i64 }** %l8
  %t895 = load %ScopeResult, %ScopeResult* %l7
  %t896 = extractvalue %ScopeResult %t895, 0
  %t897 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t896, 0
  %t898 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l8
  %t899 = insertvalue %ScopeResult %t897, { %Diagnostic**, i64 }* %t898, 1
  ret %ScopeResult %t899
merge13:
  %t900 = extractvalue %Statement %statement, 0
  %t901 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t902 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t903 = icmp eq i32 %t900, 0
  %t904 = select i1 %t903, i8* %t902, i8* %t901
  %t905 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t906 = icmp eq i32 %t900, 1
  %t907 = select i1 %t906, i8* %t905, i8* %t904
  %t908 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t909 = icmp eq i32 %t900, 2
  %t910 = select i1 %t909, i8* %t908, i8* %t907
  %t911 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t912 = icmp eq i32 %t900, 3
  %t913 = select i1 %t912, i8* %t911, i8* %t910
  %t914 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t915 = icmp eq i32 %t900, 4
  %t916 = select i1 %t915, i8* %t914, i8* %t913
  %t917 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t918 = icmp eq i32 %t900, 5
  %t919 = select i1 %t918, i8* %t917, i8* %t916
  %t920 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t921 = icmp eq i32 %t900, 6
  %t922 = select i1 %t921, i8* %t920, i8* %t919
  %t923 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t924 = icmp eq i32 %t900, 7
  %t925 = select i1 %t924, i8* %t923, i8* %t922
  %t926 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t927 = icmp eq i32 %t900, 8
  %t928 = select i1 %t927, i8* %t926, i8* %t925
  %t929 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t930 = icmp eq i32 %t900, 9
  %t931 = select i1 %t930, i8* %t929, i8* %t928
  %t932 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t933 = icmp eq i32 %t900, 10
  %t934 = select i1 %t933, i8* %t932, i8* %t931
  %t935 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t936 = icmp eq i32 %t900, 11
  %t937 = select i1 %t936, i8* %t935, i8* %t934
  %t938 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t939 = icmp eq i32 %t900, 12
  %t940 = select i1 %t939, i8* %t938, i8* %t937
  %t941 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t942 = icmp eq i32 %t900, 13
  %t943 = select i1 %t942, i8* %t941, i8* %t940
  %t944 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t945 = icmp eq i32 %t900, 14
  %t946 = select i1 %t945, i8* %t944, i8* %t943
  %t947 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t948 = icmp eq i32 %t900, 15
  %t949 = select i1 %t948, i8* %t947, i8* %t946
  %t950 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t951 = icmp eq i32 %t900, 16
  %t952 = select i1 %t951, i8* %t950, i8* %t949
  %t953 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t954 = icmp eq i32 %t900, 17
  %t955 = select i1 %t954, i8* %t953, i8* %t952
  %t956 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t957 = icmp eq i32 %t900, 18
  %t958 = select i1 %t957, i8* %t956, i8* %t955
  %t959 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t960 = icmp eq i32 %t900, 19
  %t961 = select i1 %t960, i8* %t959, i8* %t958
  %t962 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t963 = icmp eq i32 %t900, 20
  %t964 = select i1 %t963, i8* %t962, i8* %t961
  %t965 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t966 = icmp eq i32 %t900, 21
  %t967 = select i1 %t966, i8* %t965, i8* %t964
  %t968 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t969 = icmp eq i32 %t900, 22
  %t970 = select i1 %t969, i8* %t968, i8* %t967
  %s971 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.971, i32 0, i32 0
  %t972 = icmp eq i8* %t970, %s971
  br i1 %t972, label %then14, label %merge15
then14:
  %t973 = extractvalue %Statement %statement, 0
  %t974 = alloca %Statement
  store %Statement %statement, %Statement* %t974
  %t975 = getelementptr inbounds %Statement, %Statement* %t974, i32 0, i32 1
  %t976 = bitcast [48 x i8]* %t975 to i8*
  %t977 = bitcast i8* %t976 to i8**
  %t978 = load i8*, i8** %t977
  %t979 = icmp eq i32 %t973, 2
  %t980 = select i1 %t979, i8* %t978, i8* null
  %t981 = getelementptr inbounds %Statement, %Statement* %t974, i32 0, i32 1
  %t982 = bitcast [48 x i8]* %t981 to i8*
  %t983 = bitcast i8* %t982 to i8**
  %t984 = load i8*, i8** %t983
  %t985 = icmp eq i32 %t973, 3
  %t986 = select i1 %t985, i8* %t984, i8* %t980
  %t987 = getelementptr inbounds %Statement, %Statement* %t974, i32 0, i32 1
  %t988 = bitcast [40 x i8]* %t987 to i8*
  %t989 = bitcast i8* %t988 to i8**
  %t990 = load i8*, i8** %t989
  %t991 = icmp eq i32 %t973, 6
  %t992 = select i1 %t991, i8* %t990, i8* %t986
  %t993 = getelementptr inbounds %Statement, %Statement* %t974, i32 0, i32 1
  %t994 = bitcast [56 x i8]* %t993 to i8*
  %t995 = bitcast i8* %t994 to i8**
  %t996 = load i8*, i8** %t995
  %t997 = icmp eq i32 %t973, 8
  %t998 = select i1 %t997, i8* %t996, i8* %t992
  %t999 = getelementptr inbounds %Statement, %Statement* %t974, i32 0, i32 1
  %t1000 = bitcast [40 x i8]* %t999 to i8*
  %t1001 = bitcast i8* %t1000 to i8**
  %t1002 = load i8*, i8** %t1001
  %t1003 = icmp eq i32 %t973, 9
  %t1004 = select i1 %t1003, i8* %t1002, i8* %t998
  %t1005 = getelementptr inbounds %Statement, %Statement* %t974, i32 0, i32 1
  %t1006 = bitcast [40 x i8]* %t1005 to i8*
  %t1007 = bitcast i8* %t1006 to i8**
  %t1008 = load i8*, i8** %t1007
  %t1009 = icmp eq i32 %t973, 10
  %t1010 = select i1 %t1009, i8* %t1008, i8* %t1004
  %t1011 = getelementptr inbounds %Statement, %Statement* %t974, i32 0, i32 1
  %t1012 = bitcast [40 x i8]* %t1011 to i8*
  %t1013 = bitcast i8* %t1012 to i8**
  %t1014 = load i8*, i8** %t1013
  %t1015 = icmp eq i32 %t973, 11
  %t1016 = select i1 %t1015, i8* %t1014, i8* %t1010
  %s1017 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.1017, i32 0, i32 0
  %t1018 = extractvalue %Statement %statement, 0
  %t1019 = alloca %Statement
  store %Statement %statement, %Statement* %t1019
  %t1020 = getelementptr inbounds %Statement, %Statement* %t1019, i32 0, i32 1
  %t1021 = bitcast [48 x i8]* %t1020 to i8*
  %t1022 = getelementptr inbounds i8, i8* %t1021, i64 8
  %t1023 = bitcast i8* %t1022 to %SourceSpan**
  %t1024 = load %SourceSpan*, %SourceSpan** %t1023
  %t1025 = icmp eq i32 %t1018, 3
  %t1026 = select i1 %t1025, %SourceSpan* %t1024, %SourceSpan* null
  %t1027 = getelementptr inbounds %Statement, %Statement* %t1019, i32 0, i32 1
  %t1028 = bitcast [40 x i8]* %t1027 to i8*
  %t1029 = getelementptr inbounds i8, i8* %t1028, i64 8
  %t1030 = bitcast i8* %t1029 to %SourceSpan**
  %t1031 = load %SourceSpan*, %SourceSpan** %t1030
  %t1032 = icmp eq i32 %t1018, 6
  %t1033 = select i1 %t1032, %SourceSpan* %t1031, %SourceSpan* %t1026
  %t1034 = getelementptr inbounds %Statement, %Statement* %t1019, i32 0, i32 1
  %t1035 = bitcast [56 x i8]* %t1034 to i8*
  %t1036 = getelementptr inbounds i8, i8* %t1035, i64 8
  %t1037 = bitcast i8* %t1036 to %SourceSpan**
  %t1038 = load %SourceSpan*, %SourceSpan** %t1037
  %t1039 = icmp eq i32 %t1018, 8
  %t1040 = select i1 %t1039, %SourceSpan* %t1038, %SourceSpan* %t1033
  %t1041 = getelementptr inbounds %Statement, %Statement* %t1019, i32 0, i32 1
  %t1042 = bitcast [40 x i8]* %t1041 to i8*
  %t1043 = getelementptr inbounds i8, i8* %t1042, i64 8
  %t1044 = bitcast i8* %t1043 to %SourceSpan**
  %t1045 = load %SourceSpan*, %SourceSpan** %t1044
  %t1046 = icmp eq i32 %t1018, 9
  %t1047 = select i1 %t1046, %SourceSpan* %t1045, %SourceSpan* %t1040
  %t1048 = getelementptr inbounds %Statement, %Statement* %t1019, i32 0, i32 1
  %t1049 = bitcast [40 x i8]* %t1048 to i8*
  %t1050 = getelementptr inbounds i8, i8* %t1049, i64 8
  %t1051 = bitcast i8* %t1050 to %SourceSpan**
  %t1052 = load %SourceSpan*, %SourceSpan** %t1051
  %t1053 = icmp eq i32 %t1018, 10
  %t1054 = select i1 %t1053, %SourceSpan* %t1052, %SourceSpan* %t1047
  %t1055 = getelementptr inbounds %Statement, %Statement* %t1019, i32 0, i32 1
  %t1056 = bitcast [40 x i8]* %t1055 to i8*
  %t1057 = getelementptr inbounds i8, i8* %t1056, i64 8
  %t1058 = bitcast i8* %t1057 to %SourceSpan**
  %t1059 = load %SourceSpan*, %SourceSpan** %t1058
  %t1060 = icmp eq i32 %t1018, 11
  %t1061 = select i1 %t1060, %SourceSpan* %t1059, %SourceSpan* %t1054
  %t1062 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1016, i8* %s1017, %SourceSpan* %t1061)
  store %ScopeResult %t1062, %ScopeResult* %l9
  %t1063 = load %ScopeResult, %ScopeResult* %l9
  %t1064 = extractvalue %ScopeResult %t1063, 1
  store { %Diagnostic**, i64 }* %t1064, { %Diagnostic**, i64 }** %l10
  %t1065 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l10
  %t1066 = extractvalue %Statement %statement, 0
  %t1067 = alloca %Statement
  store %Statement %statement, %Statement* %t1067
  %t1068 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1069 = bitcast [56 x i8]* %t1068 to i8*
  %t1070 = getelementptr inbounds i8, i8* %t1069, i64 16
  %t1071 = bitcast i8* %t1070 to { %TypeParameter**, i64 }**
  %t1072 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1071
  %t1073 = icmp eq i32 %t1066, 8
  %t1074 = select i1 %t1073, { %TypeParameter**, i64 }* %t1072, { %TypeParameter**, i64 }* null
  %t1075 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1076 = bitcast [40 x i8]* %t1075 to i8*
  %t1077 = getelementptr inbounds i8, i8* %t1076, i64 16
  %t1078 = bitcast i8* %t1077 to { %TypeParameter**, i64 }**
  %t1079 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1078
  %t1080 = icmp eq i32 %t1066, 9
  %t1081 = select i1 %t1080, { %TypeParameter**, i64 }* %t1079, { %TypeParameter**, i64 }* %t1074
  %t1082 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1083 = bitcast [40 x i8]* %t1082 to i8*
  %t1084 = getelementptr inbounds i8, i8* %t1083, i64 16
  %t1085 = bitcast i8* %t1084 to { %TypeParameter**, i64 }**
  %t1086 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1085
  %t1087 = icmp eq i32 %t1066, 10
  %t1088 = select i1 %t1087, { %TypeParameter**, i64 }* %t1086, { %TypeParameter**, i64 }* %t1081
  %t1089 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1090 = bitcast [40 x i8]* %t1089 to i8*
  %t1091 = getelementptr inbounds i8, i8* %t1090, i64 16
  %t1092 = bitcast i8* %t1091 to { %TypeParameter**, i64 }**
  %t1093 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1092
  %t1094 = icmp eq i32 %t1066, 11
  %t1095 = select i1 %t1094, { %TypeParameter**, i64 }* %t1093, { %TypeParameter**, i64 }* %t1088
  %t1096 = bitcast { %TypeParameter**, i64 }* %t1095 to { %TypeParameter*, i64 }*
  %t1097 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t1096)
  %t1098 = bitcast { %Diagnostic**, i64 }* %t1065 to { i8**, i64 }*
  %t1099 = bitcast { %Diagnostic*, i64 }* %t1097 to { i8**, i64 }*
  %t1100 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1098, { i8**, i64 }* %t1099)
  %t1101 = bitcast { i8**, i64 }* %t1100 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1101, { %Diagnostic**, i64 }** %l10
  %t1102 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l10
  %t1103 = extractvalue %Statement %statement, 0
  %t1104 = alloca %Statement
  store %Statement %statement, %Statement* %t1104
  %t1105 = getelementptr inbounds %Statement, %Statement* %t1104, i32 0, i32 1
  %t1106 = bitcast [40 x i8]* %t1105 to i8*
  %t1107 = getelementptr inbounds i8, i8* %t1106, i64 24
  %t1108 = bitcast i8* %t1107 to { %FunctionSignature**, i64 }**
  %t1109 = load { %FunctionSignature**, i64 }*, { %FunctionSignature**, i64 }** %t1108
  %t1110 = icmp eq i32 %t1103, 10
  %t1111 = select i1 %t1110, { %FunctionSignature**, i64 }* %t1109, { %FunctionSignature**, i64 }* null
  %t1112 = bitcast { %FunctionSignature**, i64 }* %t1111 to { %FunctionSignature*, i64 }*
  %t1113 = call { %Diagnostic*, i64 }* @check_interface_members({ %FunctionSignature*, i64 }* %t1112)
  %t1114 = bitcast { %Diagnostic**, i64 }* %t1102 to { i8**, i64 }*
  %t1115 = bitcast { %Diagnostic*, i64 }* %t1113 to { i8**, i64 }*
  %t1116 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1114, { i8**, i64 }* %t1115)
  %t1117 = bitcast { i8**, i64 }* %t1116 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1117, { %Diagnostic**, i64 }** %l10
  %t1118 = load %ScopeResult, %ScopeResult* %l9
  %t1119 = extractvalue %ScopeResult %t1118, 0
  %t1120 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1119, 0
  %t1121 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l10
  %t1122 = insertvalue %ScopeResult %t1120, { %Diagnostic**, i64 }* %t1121, 1
  ret %ScopeResult %t1122
merge15:
  %t1123 = extractvalue %Statement %statement, 0
  %t1124 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1125 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1126 = icmp eq i32 %t1123, 0
  %t1127 = select i1 %t1126, i8* %t1125, i8* %t1124
  %t1128 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1129 = icmp eq i32 %t1123, 1
  %t1130 = select i1 %t1129, i8* %t1128, i8* %t1127
  %t1131 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1132 = icmp eq i32 %t1123, 2
  %t1133 = select i1 %t1132, i8* %t1131, i8* %t1130
  %t1134 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1135 = icmp eq i32 %t1123, 3
  %t1136 = select i1 %t1135, i8* %t1134, i8* %t1133
  %t1137 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1138 = icmp eq i32 %t1123, 4
  %t1139 = select i1 %t1138, i8* %t1137, i8* %t1136
  %t1140 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1141 = icmp eq i32 %t1123, 5
  %t1142 = select i1 %t1141, i8* %t1140, i8* %t1139
  %t1143 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1144 = icmp eq i32 %t1123, 6
  %t1145 = select i1 %t1144, i8* %t1143, i8* %t1142
  %t1146 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1147 = icmp eq i32 %t1123, 7
  %t1148 = select i1 %t1147, i8* %t1146, i8* %t1145
  %t1149 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1150 = icmp eq i32 %t1123, 8
  %t1151 = select i1 %t1150, i8* %t1149, i8* %t1148
  %t1152 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1153 = icmp eq i32 %t1123, 9
  %t1154 = select i1 %t1153, i8* %t1152, i8* %t1151
  %t1155 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1156 = icmp eq i32 %t1123, 10
  %t1157 = select i1 %t1156, i8* %t1155, i8* %t1154
  %t1158 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1159 = icmp eq i32 %t1123, 11
  %t1160 = select i1 %t1159, i8* %t1158, i8* %t1157
  %t1161 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1162 = icmp eq i32 %t1123, 12
  %t1163 = select i1 %t1162, i8* %t1161, i8* %t1160
  %t1164 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1165 = icmp eq i32 %t1123, 13
  %t1166 = select i1 %t1165, i8* %t1164, i8* %t1163
  %t1167 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1168 = icmp eq i32 %t1123, 14
  %t1169 = select i1 %t1168, i8* %t1167, i8* %t1166
  %t1170 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1171 = icmp eq i32 %t1123, 15
  %t1172 = select i1 %t1171, i8* %t1170, i8* %t1169
  %t1173 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1174 = icmp eq i32 %t1123, 16
  %t1175 = select i1 %t1174, i8* %t1173, i8* %t1172
  %t1176 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1177 = icmp eq i32 %t1123, 17
  %t1178 = select i1 %t1177, i8* %t1176, i8* %t1175
  %t1179 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1180 = icmp eq i32 %t1123, 18
  %t1181 = select i1 %t1180, i8* %t1179, i8* %t1178
  %t1182 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1183 = icmp eq i32 %t1123, 19
  %t1184 = select i1 %t1183, i8* %t1182, i8* %t1181
  %t1185 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1186 = icmp eq i32 %t1123, 20
  %t1187 = select i1 %t1186, i8* %t1185, i8* %t1184
  %t1188 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1189 = icmp eq i32 %t1123, 21
  %t1190 = select i1 %t1189, i8* %t1188, i8* %t1187
  %t1191 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1192 = icmp eq i32 %t1123, 22
  %t1193 = select i1 %t1192, i8* %t1191, i8* %t1190
  %s1194 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.1194, i32 0, i32 0
  %t1195 = icmp eq i8* %t1193, %s1194
  br i1 %t1195, label %then16, label %merge17
then16:
  %t1196 = extractvalue %Statement %statement, 0
  %t1197 = alloca %Statement
  store %Statement %statement, %Statement* %t1197
  %t1198 = getelementptr inbounds %Statement, %Statement* %t1197, i32 0, i32 1
  %t1199 = bitcast [48 x i8]* %t1198 to i8*
  %t1200 = bitcast i8* %t1199 to i8**
  %t1201 = load i8*, i8** %t1200
  %t1202 = icmp eq i32 %t1196, 2
  %t1203 = select i1 %t1202, i8* %t1201, i8* null
  %t1204 = getelementptr inbounds %Statement, %Statement* %t1197, i32 0, i32 1
  %t1205 = bitcast [48 x i8]* %t1204 to i8*
  %t1206 = bitcast i8* %t1205 to i8**
  %t1207 = load i8*, i8** %t1206
  %t1208 = icmp eq i32 %t1196, 3
  %t1209 = select i1 %t1208, i8* %t1207, i8* %t1203
  %t1210 = getelementptr inbounds %Statement, %Statement* %t1197, i32 0, i32 1
  %t1211 = bitcast [40 x i8]* %t1210 to i8*
  %t1212 = bitcast i8* %t1211 to i8**
  %t1213 = load i8*, i8** %t1212
  %t1214 = icmp eq i32 %t1196, 6
  %t1215 = select i1 %t1214, i8* %t1213, i8* %t1209
  %t1216 = getelementptr inbounds %Statement, %Statement* %t1197, i32 0, i32 1
  %t1217 = bitcast [56 x i8]* %t1216 to i8*
  %t1218 = bitcast i8* %t1217 to i8**
  %t1219 = load i8*, i8** %t1218
  %t1220 = icmp eq i32 %t1196, 8
  %t1221 = select i1 %t1220, i8* %t1219, i8* %t1215
  %t1222 = getelementptr inbounds %Statement, %Statement* %t1197, i32 0, i32 1
  %t1223 = bitcast [40 x i8]* %t1222 to i8*
  %t1224 = bitcast i8* %t1223 to i8**
  %t1225 = load i8*, i8** %t1224
  %t1226 = icmp eq i32 %t1196, 9
  %t1227 = select i1 %t1226, i8* %t1225, i8* %t1221
  %t1228 = getelementptr inbounds %Statement, %Statement* %t1197, i32 0, i32 1
  %t1229 = bitcast [40 x i8]* %t1228 to i8*
  %t1230 = bitcast i8* %t1229 to i8**
  %t1231 = load i8*, i8** %t1230
  %t1232 = icmp eq i32 %t1196, 10
  %t1233 = select i1 %t1232, i8* %t1231, i8* %t1227
  %t1234 = getelementptr inbounds %Statement, %Statement* %t1197, i32 0, i32 1
  %t1235 = bitcast [40 x i8]* %t1234 to i8*
  %t1236 = bitcast i8* %t1235 to i8**
  %t1237 = load i8*, i8** %t1236
  %t1238 = icmp eq i32 %t1196, 11
  %t1239 = select i1 %t1238, i8* %t1237, i8* %t1233
  %s1240 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1240, i32 0, i32 0
  %t1241 = extractvalue %Statement %statement, 0
  %t1242 = alloca %Statement
  store %Statement %statement, %Statement* %t1242
  %t1243 = getelementptr inbounds %Statement, %Statement* %t1242, i32 0, i32 1
  %t1244 = bitcast [48 x i8]* %t1243 to i8*
  %t1245 = getelementptr inbounds i8, i8* %t1244, i64 8
  %t1246 = bitcast i8* %t1245 to %SourceSpan**
  %t1247 = load %SourceSpan*, %SourceSpan** %t1246
  %t1248 = icmp eq i32 %t1241, 3
  %t1249 = select i1 %t1248, %SourceSpan* %t1247, %SourceSpan* null
  %t1250 = getelementptr inbounds %Statement, %Statement* %t1242, i32 0, i32 1
  %t1251 = bitcast [40 x i8]* %t1250 to i8*
  %t1252 = getelementptr inbounds i8, i8* %t1251, i64 8
  %t1253 = bitcast i8* %t1252 to %SourceSpan**
  %t1254 = load %SourceSpan*, %SourceSpan** %t1253
  %t1255 = icmp eq i32 %t1241, 6
  %t1256 = select i1 %t1255, %SourceSpan* %t1254, %SourceSpan* %t1249
  %t1257 = getelementptr inbounds %Statement, %Statement* %t1242, i32 0, i32 1
  %t1258 = bitcast [56 x i8]* %t1257 to i8*
  %t1259 = getelementptr inbounds i8, i8* %t1258, i64 8
  %t1260 = bitcast i8* %t1259 to %SourceSpan**
  %t1261 = load %SourceSpan*, %SourceSpan** %t1260
  %t1262 = icmp eq i32 %t1241, 8
  %t1263 = select i1 %t1262, %SourceSpan* %t1261, %SourceSpan* %t1256
  %t1264 = getelementptr inbounds %Statement, %Statement* %t1242, i32 0, i32 1
  %t1265 = bitcast [40 x i8]* %t1264 to i8*
  %t1266 = getelementptr inbounds i8, i8* %t1265, i64 8
  %t1267 = bitcast i8* %t1266 to %SourceSpan**
  %t1268 = load %SourceSpan*, %SourceSpan** %t1267
  %t1269 = icmp eq i32 %t1241, 9
  %t1270 = select i1 %t1269, %SourceSpan* %t1268, %SourceSpan* %t1263
  %t1271 = getelementptr inbounds %Statement, %Statement* %t1242, i32 0, i32 1
  %t1272 = bitcast [40 x i8]* %t1271 to i8*
  %t1273 = getelementptr inbounds i8, i8* %t1272, i64 8
  %t1274 = bitcast i8* %t1273 to %SourceSpan**
  %t1275 = load %SourceSpan*, %SourceSpan** %t1274
  %t1276 = icmp eq i32 %t1241, 10
  %t1277 = select i1 %t1276, %SourceSpan* %t1275, %SourceSpan* %t1270
  %t1278 = getelementptr inbounds %Statement, %Statement* %t1242, i32 0, i32 1
  %t1279 = bitcast [40 x i8]* %t1278 to i8*
  %t1280 = getelementptr inbounds i8, i8* %t1279, i64 8
  %t1281 = bitcast i8* %t1280 to %SourceSpan**
  %t1282 = load %SourceSpan*, %SourceSpan** %t1281
  %t1283 = icmp eq i32 %t1241, 11
  %t1284 = select i1 %t1283, %SourceSpan* %t1282, %SourceSpan* %t1277
  %t1285 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1239, i8* %s1240, %SourceSpan* %t1284)
  store %ScopeResult %t1285, %ScopeResult* %l11
  %t1286 = load %ScopeResult, %ScopeResult* %l11
  %t1287 = extractvalue %ScopeResult %t1286, 1
  %t1288 = extractvalue %Statement %statement, 0
  %t1289 = alloca %Statement
  store %Statement %statement, %Statement* %t1289
  %t1290 = getelementptr inbounds %Statement, %Statement* %t1289, i32 0, i32 1
  %t1291 = bitcast [48 x i8]* %t1290 to i8*
  %t1292 = getelementptr inbounds i8, i8* %t1291, i64 24
  %t1293 = bitcast i8* %t1292 to { %ModelProperty**, i64 }**
  %t1294 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1293
  %t1295 = icmp eq i32 %t1288, 3
  %t1296 = select i1 %t1295, { %ModelProperty**, i64 }* %t1294, { %ModelProperty**, i64 }* null
  %t1297 = bitcast { %ModelProperty**, i64 }* %t1296 to { %ModelProperty*, i64 }*
  %t1298 = call { %Diagnostic*, i64 }* @check_model_properties({ %ModelProperty*, i64 }* %t1297)
  %t1299 = bitcast { %Diagnostic**, i64 }* %t1287 to { i8**, i64 }*
  %t1300 = bitcast { %Diagnostic*, i64 }* %t1298 to { i8**, i64 }*
  %t1301 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1299, { i8**, i64 }* %t1300)
  store { i8**, i64 }* %t1301, { i8**, i64 }** %l12
  %t1302 = load %ScopeResult, %ScopeResult* %l11
  %t1303 = extractvalue %ScopeResult %t1302, 0
  %t1304 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1303, 0
  %t1305 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %t1306 = bitcast { i8**, i64 }* %t1305 to { %Diagnostic**, i64 }*
  %t1307 = insertvalue %ScopeResult %t1304, { %Diagnostic**, i64 }* %t1306, 1
  ret %ScopeResult %t1307
merge17:
  %t1308 = extractvalue %Statement %statement, 0
  %t1309 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1310 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1311 = icmp eq i32 %t1308, 0
  %t1312 = select i1 %t1311, i8* %t1310, i8* %t1309
  %t1313 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1314 = icmp eq i32 %t1308, 1
  %t1315 = select i1 %t1314, i8* %t1313, i8* %t1312
  %t1316 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1317 = icmp eq i32 %t1308, 2
  %t1318 = select i1 %t1317, i8* %t1316, i8* %t1315
  %t1319 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1320 = icmp eq i32 %t1308, 3
  %t1321 = select i1 %t1320, i8* %t1319, i8* %t1318
  %t1322 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1323 = icmp eq i32 %t1308, 4
  %t1324 = select i1 %t1323, i8* %t1322, i8* %t1321
  %t1325 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1326 = icmp eq i32 %t1308, 5
  %t1327 = select i1 %t1326, i8* %t1325, i8* %t1324
  %t1328 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1329 = icmp eq i32 %t1308, 6
  %t1330 = select i1 %t1329, i8* %t1328, i8* %t1327
  %t1331 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1332 = icmp eq i32 %t1308, 7
  %t1333 = select i1 %t1332, i8* %t1331, i8* %t1330
  %t1334 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1335 = icmp eq i32 %t1308, 8
  %t1336 = select i1 %t1335, i8* %t1334, i8* %t1333
  %t1337 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1338 = icmp eq i32 %t1308, 9
  %t1339 = select i1 %t1338, i8* %t1337, i8* %t1336
  %t1340 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1341 = icmp eq i32 %t1308, 10
  %t1342 = select i1 %t1341, i8* %t1340, i8* %t1339
  %t1343 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1344 = icmp eq i32 %t1308, 11
  %t1345 = select i1 %t1344, i8* %t1343, i8* %t1342
  %t1346 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1347 = icmp eq i32 %t1308, 12
  %t1348 = select i1 %t1347, i8* %t1346, i8* %t1345
  %t1349 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1350 = icmp eq i32 %t1308, 13
  %t1351 = select i1 %t1350, i8* %t1349, i8* %t1348
  %t1352 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1353 = icmp eq i32 %t1308, 14
  %t1354 = select i1 %t1353, i8* %t1352, i8* %t1351
  %t1355 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1356 = icmp eq i32 %t1308, 15
  %t1357 = select i1 %t1356, i8* %t1355, i8* %t1354
  %t1358 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1359 = icmp eq i32 %t1308, 16
  %t1360 = select i1 %t1359, i8* %t1358, i8* %t1357
  %t1361 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1362 = icmp eq i32 %t1308, 17
  %t1363 = select i1 %t1362, i8* %t1361, i8* %t1360
  %t1364 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1365 = icmp eq i32 %t1308, 18
  %t1366 = select i1 %t1365, i8* %t1364, i8* %t1363
  %t1367 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1368 = icmp eq i32 %t1308, 19
  %t1369 = select i1 %t1368, i8* %t1367, i8* %t1366
  %t1370 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1371 = icmp eq i32 %t1308, 20
  %t1372 = select i1 %t1371, i8* %t1370, i8* %t1369
  %t1373 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1374 = icmp eq i32 %t1308, 21
  %t1375 = select i1 %t1374, i8* %t1373, i8* %t1372
  %t1376 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1377 = icmp eq i32 %t1308, 22
  %t1378 = select i1 %t1377, i8* %t1376, i8* %t1375
  %s1379 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1379, i32 0, i32 0
  %t1380 = icmp eq i8* %t1378, %s1379
  br i1 %t1380, label %then18, label %merge19
then18:
  %t1381 = extractvalue %Statement %statement, 0
  %t1382 = alloca %Statement
  store %Statement %statement, %Statement* %t1382
  %t1383 = getelementptr inbounds %Statement, %Statement* %t1382, i32 0, i32 1
  %t1384 = bitcast [24 x i8]* %t1383 to i8*
  %t1385 = bitcast i8* %t1384 to %FunctionSignature*
  %t1386 = load %FunctionSignature, %FunctionSignature* %t1385
  %t1387 = icmp eq i32 %t1381, 4
  %t1388 = select i1 %t1387, %FunctionSignature %t1386, %FunctionSignature zeroinitializer
  %t1389 = getelementptr inbounds %Statement, %Statement* %t1382, i32 0, i32 1
  %t1390 = bitcast [24 x i8]* %t1389 to i8*
  %t1391 = bitcast i8* %t1390 to %FunctionSignature*
  %t1392 = load %FunctionSignature, %FunctionSignature* %t1391
  %t1393 = icmp eq i32 %t1381, 5
  %t1394 = select i1 %t1393, %FunctionSignature %t1392, %FunctionSignature %t1388
  %t1395 = getelementptr inbounds %Statement, %Statement* %t1382, i32 0, i32 1
  %t1396 = bitcast [24 x i8]* %t1395 to i8*
  %t1397 = bitcast i8* %t1396 to %FunctionSignature*
  %t1398 = load %FunctionSignature, %FunctionSignature* %t1397
  %t1399 = icmp eq i32 %t1381, 7
  %t1400 = select i1 %t1399, %FunctionSignature %t1398, %FunctionSignature %t1394
  %t1401 = extractvalue %FunctionSignature %t1400, 0
  %s1402 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1402, i32 0, i32 0
  %t1403 = extractvalue %Statement %statement, 0
  %t1404 = alloca %Statement
  store %Statement %statement, %Statement* %t1404
  %t1405 = getelementptr inbounds %Statement, %Statement* %t1404, i32 0, i32 1
  %t1406 = bitcast [24 x i8]* %t1405 to i8*
  %t1407 = bitcast i8* %t1406 to %FunctionSignature*
  %t1408 = load %FunctionSignature, %FunctionSignature* %t1407
  %t1409 = icmp eq i32 %t1403, 4
  %t1410 = select i1 %t1409, %FunctionSignature %t1408, %FunctionSignature zeroinitializer
  %t1411 = getelementptr inbounds %Statement, %Statement* %t1404, i32 0, i32 1
  %t1412 = bitcast [24 x i8]* %t1411 to i8*
  %t1413 = bitcast i8* %t1412 to %FunctionSignature*
  %t1414 = load %FunctionSignature, %FunctionSignature* %t1413
  %t1415 = icmp eq i32 %t1403, 5
  %t1416 = select i1 %t1415, %FunctionSignature %t1414, %FunctionSignature %t1410
  %t1417 = getelementptr inbounds %Statement, %Statement* %t1404, i32 0, i32 1
  %t1418 = bitcast [24 x i8]* %t1417 to i8*
  %t1419 = bitcast i8* %t1418 to %FunctionSignature*
  %t1420 = load %FunctionSignature, %FunctionSignature* %t1419
  %t1421 = icmp eq i32 %t1403, 7
  %t1422 = select i1 %t1421, %FunctionSignature %t1420, %FunctionSignature %t1416
  %t1423 = extractvalue %FunctionSignature %t1422, 6
  %t1424 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1401, i8* %s1402, %SourceSpan* %t1423)
  store %ScopeResult %t1424, %ScopeResult* %l13
  %t1425 = load %ScopeResult, %ScopeResult* %l13
  %t1426 = extractvalue %ScopeResult %t1425, 1
  store { %Diagnostic**, i64 }* %t1426, { %Diagnostic**, i64 }** %l14
  %t1427 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l14
  %t1428 = extractvalue %Statement %statement, 0
  %t1429 = alloca %Statement
  store %Statement %statement, %Statement* %t1429
  %t1430 = getelementptr inbounds %Statement, %Statement* %t1429, i32 0, i32 1
  %t1431 = bitcast [24 x i8]* %t1430 to i8*
  %t1432 = bitcast i8* %t1431 to %FunctionSignature*
  %t1433 = load %FunctionSignature, %FunctionSignature* %t1432
  %t1434 = icmp eq i32 %t1428, 4
  %t1435 = select i1 %t1434, %FunctionSignature %t1433, %FunctionSignature zeroinitializer
  %t1436 = getelementptr inbounds %Statement, %Statement* %t1429, i32 0, i32 1
  %t1437 = bitcast [24 x i8]* %t1436 to i8*
  %t1438 = bitcast i8* %t1437 to %FunctionSignature*
  %t1439 = load %FunctionSignature, %FunctionSignature* %t1438
  %t1440 = icmp eq i32 %t1428, 5
  %t1441 = select i1 %t1440, %FunctionSignature %t1439, %FunctionSignature %t1435
  %t1442 = getelementptr inbounds %Statement, %Statement* %t1429, i32 0, i32 1
  %t1443 = bitcast [24 x i8]* %t1442 to i8*
  %t1444 = bitcast i8* %t1443 to %FunctionSignature*
  %t1445 = load %FunctionSignature, %FunctionSignature* %t1444
  %t1446 = icmp eq i32 %t1428, 7
  %t1447 = select i1 %t1446, %FunctionSignature %t1445, %FunctionSignature %t1441
  %t1448 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t1447)
  %t1449 = bitcast { %Diagnostic**, i64 }* %t1427 to { i8**, i64 }*
  %t1450 = bitcast { %Diagnostic*, i64 }* %t1448 to { i8**, i64 }*
  %t1451 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1449, { i8**, i64 }* %t1450)
  %t1452 = bitcast { i8**, i64 }* %t1451 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1452, { %Diagnostic**, i64 }** %l14
  %t1453 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l14
  %t1454 = extractvalue %Statement %statement, 0
  %t1455 = alloca %Statement
  store %Statement %statement, %Statement* %t1455
  %t1456 = getelementptr inbounds %Statement, %Statement* %t1455, i32 0, i32 1
  %t1457 = bitcast [24 x i8]* %t1456 to i8*
  %t1458 = bitcast i8* %t1457 to %FunctionSignature*
  %t1459 = load %FunctionSignature, %FunctionSignature* %t1458
  %t1460 = icmp eq i32 %t1454, 4
  %t1461 = select i1 %t1460, %FunctionSignature %t1459, %FunctionSignature zeroinitializer
  %t1462 = getelementptr inbounds %Statement, %Statement* %t1455, i32 0, i32 1
  %t1463 = bitcast [24 x i8]* %t1462 to i8*
  %t1464 = bitcast i8* %t1463 to %FunctionSignature*
  %t1465 = load %FunctionSignature, %FunctionSignature* %t1464
  %t1466 = icmp eq i32 %t1454, 5
  %t1467 = select i1 %t1466, %FunctionSignature %t1465, %FunctionSignature %t1461
  %t1468 = getelementptr inbounds %Statement, %Statement* %t1455, i32 0, i32 1
  %t1469 = bitcast [24 x i8]* %t1468 to i8*
  %t1470 = bitcast i8* %t1469 to %FunctionSignature*
  %t1471 = load %FunctionSignature, %FunctionSignature* %t1470
  %t1472 = icmp eq i32 %t1454, 7
  %t1473 = select i1 %t1472, %FunctionSignature %t1471, %FunctionSignature %t1467
  %t1474 = extractvalue %Statement %statement, 0
  %t1475 = alloca %Statement
  store %Statement %statement, %Statement* %t1475
  %t1476 = getelementptr inbounds %Statement, %Statement* %t1475, i32 0, i32 1
  %t1477 = bitcast [24 x i8]* %t1476 to i8*
  %t1478 = getelementptr inbounds i8, i8* %t1477, i64 8
  %t1479 = bitcast i8* %t1478 to %Block*
  %t1480 = load %Block, %Block* %t1479
  %t1481 = icmp eq i32 %t1474, 4
  %t1482 = select i1 %t1481, %Block %t1480, %Block zeroinitializer
  %t1483 = getelementptr inbounds %Statement, %Statement* %t1475, i32 0, i32 1
  %t1484 = bitcast [24 x i8]* %t1483 to i8*
  %t1485 = getelementptr inbounds i8, i8* %t1484, i64 8
  %t1486 = bitcast i8* %t1485 to %Block*
  %t1487 = load %Block, %Block* %t1486
  %t1488 = icmp eq i32 %t1474, 5
  %t1489 = select i1 %t1488, %Block %t1487, %Block %t1482
  %t1490 = getelementptr inbounds %Statement, %Statement* %t1475, i32 0, i32 1
  %t1491 = bitcast [40 x i8]* %t1490 to i8*
  %t1492 = getelementptr inbounds i8, i8* %t1491, i64 16
  %t1493 = bitcast i8* %t1492 to %Block*
  %t1494 = load %Block, %Block* %t1493
  %t1495 = icmp eq i32 %t1474, 6
  %t1496 = select i1 %t1495, %Block %t1494, %Block %t1489
  %t1497 = getelementptr inbounds %Statement, %Statement* %t1475, i32 0, i32 1
  %t1498 = bitcast [24 x i8]* %t1497 to i8*
  %t1499 = getelementptr inbounds i8, i8* %t1498, i64 8
  %t1500 = bitcast i8* %t1499 to %Block*
  %t1501 = load %Block, %Block* %t1500
  %t1502 = icmp eq i32 %t1474, 7
  %t1503 = select i1 %t1502, %Block %t1501, %Block %t1496
  %t1504 = getelementptr inbounds %Statement, %Statement* %t1475, i32 0, i32 1
  %t1505 = bitcast [40 x i8]* %t1504 to i8*
  %t1506 = getelementptr inbounds i8, i8* %t1505, i64 24
  %t1507 = bitcast i8* %t1506 to %Block*
  %t1508 = load %Block, %Block* %t1507
  %t1509 = icmp eq i32 %t1474, 12
  %t1510 = select i1 %t1509, %Block %t1508, %Block %t1503
  %t1511 = getelementptr inbounds %Statement, %Statement* %t1475, i32 0, i32 1
  %t1512 = bitcast [24 x i8]* %t1511 to i8*
  %t1513 = getelementptr inbounds i8, i8* %t1512, i64 8
  %t1514 = bitcast i8* %t1513 to %Block*
  %t1515 = load %Block, %Block* %t1514
  %t1516 = icmp eq i32 %t1474, 13
  %t1517 = select i1 %t1516, %Block %t1515, %Block %t1510
  %t1518 = getelementptr inbounds %Statement, %Statement* %t1475, i32 0, i32 1
  %t1519 = bitcast [24 x i8]* %t1518 to i8*
  %t1520 = getelementptr inbounds i8, i8* %t1519, i64 8
  %t1521 = bitcast i8* %t1520 to %Block*
  %t1522 = load %Block, %Block* %t1521
  %t1523 = icmp eq i32 %t1474, 14
  %t1524 = select i1 %t1523, %Block %t1522, %Block %t1517
  %t1525 = getelementptr inbounds %Statement, %Statement* %t1475, i32 0, i32 1
  %t1526 = bitcast [16 x i8]* %t1525 to i8*
  %t1527 = bitcast i8* %t1526 to %Block*
  %t1528 = load %Block, %Block* %t1527
  %t1529 = icmp eq i32 %t1474, 15
  %t1530 = select i1 %t1529, %Block %t1528, %Block %t1524
  %t1531 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t1473, %Block %t1530, { %Statement*, i64 }* %interfaces)
  %t1532 = bitcast { %Diagnostic**, i64 }* %t1453 to { i8**, i64 }*
  %t1533 = bitcast { %Diagnostic*, i64 }* %t1531 to { i8**, i64 }*
  %t1534 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1532, { i8**, i64 }* %t1533)
  %t1535 = bitcast { i8**, i64 }* %t1534 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1535, { %Diagnostic**, i64 }** %l14
  %t1536 = load %ScopeResult, %ScopeResult* %l13
  %t1537 = extractvalue %ScopeResult %t1536, 0
  %t1538 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1537, 0
  %t1539 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l14
  %t1540 = insertvalue %ScopeResult %t1538, { %Diagnostic**, i64 }* %t1539, 1
  ret %ScopeResult %t1540
merge19:
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
  %s1612 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1612, i32 0, i32 0
  %t1613 = icmp eq i8* %t1611, %s1612
  br i1 %t1613, label %then20, label %merge21
then20:
  %t1614 = extractvalue %Statement %statement, 0
  %t1615 = alloca %Statement
  store %Statement %statement, %Statement* %t1615
  %t1616 = getelementptr inbounds %Statement, %Statement* %t1615, i32 0, i32 1
  %t1617 = bitcast [24 x i8]* %t1616 to i8*
  %t1618 = bitcast i8* %t1617 to %FunctionSignature*
  %t1619 = load %FunctionSignature, %FunctionSignature* %t1618
  %t1620 = icmp eq i32 %t1614, 4
  %t1621 = select i1 %t1620, %FunctionSignature %t1619, %FunctionSignature zeroinitializer
  %t1622 = getelementptr inbounds %Statement, %Statement* %t1615, i32 0, i32 1
  %t1623 = bitcast [24 x i8]* %t1622 to i8*
  %t1624 = bitcast i8* %t1623 to %FunctionSignature*
  %t1625 = load %FunctionSignature, %FunctionSignature* %t1624
  %t1626 = icmp eq i32 %t1614, 5
  %t1627 = select i1 %t1626, %FunctionSignature %t1625, %FunctionSignature %t1621
  %t1628 = getelementptr inbounds %Statement, %Statement* %t1615, i32 0, i32 1
  %t1629 = bitcast [24 x i8]* %t1628 to i8*
  %t1630 = bitcast i8* %t1629 to %FunctionSignature*
  %t1631 = load %FunctionSignature, %FunctionSignature* %t1630
  %t1632 = icmp eq i32 %t1614, 7
  %t1633 = select i1 %t1632, %FunctionSignature %t1631, %FunctionSignature %t1627
  %t1634 = extractvalue %FunctionSignature %t1633, 0
  %s1635 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1635, i32 0, i32 0
  %t1636 = extractvalue %Statement %statement, 0
  %t1637 = alloca %Statement
  store %Statement %statement, %Statement* %t1637
  %t1638 = getelementptr inbounds %Statement, %Statement* %t1637, i32 0, i32 1
  %t1639 = bitcast [24 x i8]* %t1638 to i8*
  %t1640 = bitcast i8* %t1639 to %FunctionSignature*
  %t1641 = load %FunctionSignature, %FunctionSignature* %t1640
  %t1642 = icmp eq i32 %t1636, 4
  %t1643 = select i1 %t1642, %FunctionSignature %t1641, %FunctionSignature zeroinitializer
  %t1644 = getelementptr inbounds %Statement, %Statement* %t1637, i32 0, i32 1
  %t1645 = bitcast [24 x i8]* %t1644 to i8*
  %t1646 = bitcast i8* %t1645 to %FunctionSignature*
  %t1647 = load %FunctionSignature, %FunctionSignature* %t1646
  %t1648 = icmp eq i32 %t1636, 5
  %t1649 = select i1 %t1648, %FunctionSignature %t1647, %FunctionSignature %t1643
  %t1650 = getelementptr inbounds %Statement, %Statement* %t1637, i32 0, i32 1
  %t1651 = bitcast [24 x i8]* %t1650 to i8*
  %t1652 = bitcast i8* %t1651 to %FunctionSignature*
  %t1653 = load %FunctionSignature, %FunctionSignature* %t1652
  %t1654 = icmp eq i32 %t1636, 7
  %t1655 = select i1 %t1654, %FunctionSignature %t1653, %FunctionSignature %t1649
  %t1656 = extractvalue %FunctionSignature %t1655, 6
  %t1657 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1634, i8* %s1635, %SourceSpan* %t1656)
  store %ScopeResult %t1657, %ScopeResult* %l15
  %t1658 = load %ScopeResult, %ScopeResult* %l15
  %t1659 = extractvalue %ScopeResult %t1658, 1
  store { %Diagnostic**, i64 }* %t1659, { %Diagnostic**, i64 }** %l16
  %t1660 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l16
  %t1661 = extractvalue %Statement %statement, 0
  %t1662 = alloca %Statement
  store %Statement %statement, %Statement* %t1662
  %t1663 = getelementptr inbounds %Statement, %Statement* %t1662, i32 0, i32 1
  %t1664 = bitcast [24 x i8]* %t1663 to i8*
  %t1665 = bitcast i8* %t1664 to %FunctionSignature*
  %t1666 = load %FunctionSignature, %FunctionSignature* %t1665
  %t1667 = icmp eq i32 %t1661, 4
  %t1668 = select i1 %t1667, %FunctionSignature %t1666, %FunctionSignature zeroinitializer
  %t1669 = getelementptr inbounds %Statement, %Statement* %t1662, i32 0, i32 1
  %t1670 = bitcast [24 x i8]* %t1669 to i8*
  %t1671 = bitcast i8* %t1670 to %FunctionSignature*
  %t1672 = load %FunctionSignature, %FunctionSignature* %t1671
  %t1673 = icmp eq i32 %t1661, 5
  %t1674 = select i1 %t1673, %FunctionSignature %t1672, %FunctionSignature %t1668
  %t1675 = getelementptr inbounds %Statement, %Statement* %t1662, i32 0, i32 1
  %t1676 = bitcast [24 x i8]* %t1675 to i8*
  %t1677 = bitcast i8* %t1676 to %FunctionSignature*
  %t1678 = load %FunctionSignature, %FunctionSignature* %t1677
  %t1679 = icmp eq i32 %t1661, 7
  %t1680 = select i1 %t1679, %FunctionSignature %t1678, %FunctionSignature %t1674
  %t1681 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t1680)
  %t1682 = bitcast { %Diagnostic**, i64 }* %t1660 to { i8**, i64 }*
  %t1683 = bitcast { %Diagnostic*, i64 }* %t1681 to { i8**, i64 }*
  %t1684 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1682, { i8**, i64 }* %t1683)
  %t1685 = bitcast { i8**, i64 }* %t1684 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1685, { %Diagnostic**, i64 }** %l16
  %t1686 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l16
  %t1687 = extractvalue %Statement %statement, 0
  %t1688 = alloca %Statement
  store %Statement %statement, %Statement* %t1688
  %t1689 = getelementptr inbounds %Statement, %Statement* %t1688, i32 0, i32 1
  %t1690 = bitcast [24 x i8]* %t1689 to i8*
  %t1691 = bitcast i8* %t1690 to %FunctionSignature*
  %t1692 = load %FunctionSignature, %FunctionSignature* %t1691
  %t1693 = icmp eq i32 %t1687, 4
  %t1694 = select i1 %t1693, %FunctionSignature %t1692, %FunctionSignature zeroinitializer
  %t1695 = getelementptr inbounds %Statement, %Statement* %t1688, i32 0, i32 1
  %t1696 = bitcast [24 x i8]* %t1695 to i8*
  %t1697 = bitcast i8* %t1696 to %FunctionSignature*
  %t1698 = load %FunctionSignature, %FunctionSignature* %t1697
  %t1699 = icmp eq i32 %t1687, 5
  %t1700 = select i1 %t1699, %FunctionSignature %t1698, %FunctionSignature %t1694
  %t1701 = getelementptr inbounds %Statement, %Statement* %t1688, i32 0, i32 1
  %t1702 = bitcast [24 x i8]* %t1701 to i8*
  %t1703 = bitcast i8* %t1702 to %FunctionSignature*
  %t1704 = load %FunctionSignature, %FunctionSignature* %t1703
  %t1705 = icmp eq i32 %t1687, 7
  %t1706 = select i1 %t1705, %FunctionSignature %t1704, %FunctionSignature %t1700
  %t1707 = extractvalue %Statement %statement, 0
  %t1708 = alloca %Statement
  store %Statement %statement, %Statement* %t1708
  %t1709 = getelementptr inbounds %Statement, %Statement* %t1708, i32 0, i32 1
  %t1710 = bitcast [24 x i8]* %t1709 to i8*
  %t1711 = getelementptr inbounds i8, i8* %t1710, i64 8
  %t1712 = bitcast i8* %t1711 to %Block*
  %t1713 = load %Block, %Block* %t1712
  %t1714 = icmp eq i32 %t1707, 4
  %t1715 = select i1 %t1714, %Block %t1713, %Block zeroinitializer
  %t1716 = getelementptr inbounds %Statement, %Statement* %t1708, i32 0, i32 1
  %t1717 = bitcast [24 x i8]* %t1716 to i8*
  %t1718 = getelementptr inbounds i8, i8* %t1717, i64 8
  %t1719 = bitcast i8* %t1718 to %Block*
  %t1720 = load %Block, %Block* %t1719
  %t1721 = icmp eq i32 %t1707, 5
  %t1722 = select i1 %t1721, %Block %t1720, %Block %t1715
  %t1723 = getelementptr inbounds %Statement, %Statement* %t1708, i32 0, i32 1
  %t1724 = bitcast [40 x i8]* %t1723 to i8*
  %t1725 = getelementptr inbounds i8, i8* %t1724, i64 16
  %t1726 = bitcast i8* %t1725 to %Block*
  %t1727 = load %Block, %Block* %t1726
  %t1728 = icmp eq i32 %t1707, 6
  %t1729 = select i1 %t1728, %Block %t1727, %Block %t1722
  %t1730 = getelementptr inbounds %Statement, %Statement* %t1708, i32 0, i32 1
  %t1731 = bitcast [24 x i8]* %t1730 to i8*
  %t1732 = getelementptr inbounds i8, i8* %t1731, i64 8
  %t1733 = bitcast i8* %t1732 to %Block*
  %t1734 = load %Block, %Block* %t1733
  %t1735 = icmp eq i32 %t1707, 7
  %t1736 = select i1 %t1735, %Block %t1734, %Block %t1729
  %t1737 = getelementptr inbounds %Statement, %Statement* %t1708, i32 0, i32 1
  %t1738 = bitcast [40 x i8]* %t1737 to i8*
  %t1739 = getelementptr inbounds i8, i8* %t1738, i64 24
  %t1740 = bitcast i8* %t1739 to %Block*
  %t1741 = load %Block, %Block* %t1740
  %t1742 = icmp eq i32 %t1707, 12
  %t1743 = select i1 %t1742, %Block %t1741, %Block %t1736
  %t1744 = getelementptr inbounds %Statement, %Statement* %t1708, i32 0, i32 1
  %t1745 = bitcast [24 x i8]* %t1744 to i8*
  %t1746 = getelementptr inbounds i8, i8* %t1745, i64 8
  %t1747 = bitcast i8* %t1746 to %Block*
  %t1748 = load %Block, %Block* %t1747
  %t1749 = icmp eq i32 %t1707, 13
  %t1750 = select i1 %t1749, %Block %t1748, %Block %t1743
  %t1751 = getelementptr inbounds %Statement, %Statement* %t1708, i32 0, i32 1
  %t1752 = bitcast [24 x i8]* %t1751 to i8*
  %t1753 = getelementptr inbounds i8, i8* %t1752, i64 8
  %t1754 = bitcast i8* %t1753 to %Block*
  %t1755 = load %Block, %Block* %t1754
  %t1756 = icmp eq i32 %t1707, 14
  %t1757 = select i1 %t1756, %Block %t1755, %Block %t1750
  %t1758 = getelementptr inbounds %Statement, %Statement* %t1708, i32 0, i32 1
  %t1759 = bitcast [16 x i8]* %t1758 to i8*
  %t1760 = bitcast i8* %t1759 to %Block*
  %t1761 = load %Block, %Block* %t1760
  %t1762 = icmp eq i32 %t1707, 15
  %t1763 = select i1 %t1762, %Block %t1761, %Block %t1757
  %t1764 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t1706, %Block %t1763, { %Statement*, i64 }* %interfaces)
  %t1765 = bitcast { %Diagnostic**, i64 }* %t1686 to { i8**, i64 }*
  %t1766 = bitcast { %Diagnostic*, i64 }* %t1764 to { i8**, i64 }*
  %t1767 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1765, { i8**, i64 }* %t1766)
  %t1768 = bitcast { i8**, i64 }* %t1767 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1768, { %Diagnostic**, i64 }** %l16
  %t1769 = load %ScopeResult, %ScopeResult* %l15
  %t1770 = extractvalue %ScopeResult %t1769, 0
  %t1771 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1770, 0
  %t1772 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l16
  %t1773 = insertvalue %ScopeResult %t1771, { %Diagnostic**, i64 }* %t1772, 1
  ret %ScopeResult %t1773
merge21:
  %t1774 = extractvalue %Statement %statement, 0
  %t1775 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1776 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1777 = icmp eq i32 %t1774, 0
  %t1778 = select i1 %t1777, i8* %t1776, i8* %t1775
  %t1779 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1780 = icmp eq i32 %t1774, 1
  %t1781 = select i1 %t1780, i8* %t1779, i8* %t1778
  %t1782 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1783 = icmp eq i32 %t1774, 2
  %t1784 = select i1 %t1783, i8* %t1782, i8* %t1781
  %t1785 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1786 = icmp eq i32 %t1774, 3
  %t1787 = select i1 %t1786, i8* %t1785, i8* %t1784
  %t1788 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1789 = icmp eq i32 %t1774, 4
  %t1790 = select i1 %t1789, i8* %t1788, i8* %t1787
  %t1791 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1792 = icmp eq i32 %t1774, 5
  %t1793 = select i1 %t1792, i8* %t1791, i8* %t1790
  %t1794 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1795 = icmp eq i32 %t1774, 6
  %t1796 = select i1 %t1795, i8* %t1794, i8* %t1793
  %t1797 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1798 = icmp eq i32 %t1774, 7
  %t1799 = select i1 %t1798, i8* %t1797, i8* %t1796
  %t1800 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1801 = icmp eq i32 %t1774, 8
  %t1802 = select i1 %t1801, i8* %t1800, i8* %t1799
  %t1803 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1804 = icmp eq i32 %t1774, 9
  %t1805 = select i1 %t1804, i8* %t1803, i8* %t1802
  %t1806 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1807 = icmp eq i32 %t1774, 10
  %t1808 = select i1 %t1807, i8* %t1806, i8* %t1805
  %t1809 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1810 = icmp eq i32 %t1774, 11
  %t1811 = select i1 %t1810, i8* %t1809, i8* %t1808
  %t1812 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1813 = icmp eq i32 %t1774, 12
  %t1814 = select i1 %t1813, i8* %t1812, i8* %t1811
  %t1815 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1816 = icmp eq i32 %t1774, 13
  %t1817 = select i1 %t1816, i8* %t1815, i8* %t1814
  %t1818 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1819 = icmp eq i32 %t1774, 14
  %t1820 = select i1 %t1819, i8* %t1818, i8* %t1817
  %t1821 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1822 = icmp eq i32 %t1774, 15
  %t1823 = select i1 %t1822, i8* %t1821, i8* %t1820
  %t1824 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1825 = icmp eq i32 %t1774, 16
  %t1826 = select i1 %t1825, i8* %t1824, i8* %t1823
  %t1827 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1828 = icmp eq i32 %t1774, 17
  %t1829 = select i1 %t1828, i8* %t1827, i8* %t1826
  %t1830 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1831 = icmp eq i32 %t1774, 18
  %t1832 = select i1 %t1831, i8* %t1830, i8* %t1829
  %t1833 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1834 = icmp eq i32 %t1774, 19
  %t1835 = select i1 %t1834, i8* %t1833, i8* %t1832
  %t1836 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1837 = icmp eq i32 %t1774, 20
  %t1838 = select i1 %t1837, i8* %t1836, i8* %t1835
  %t1839 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1840 = icmp eq i32 %t1774, 21
  %t1841 = select i1 %t1840, i8* %t1839, i8* %t1838
  %t1842 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1843 = icmp eq i32 %t1774, 22
  %t1844 = select i1 %t1843, i8* %t1842, i8* %t1841
  %s1845 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1845, i32 0, i32 0
  %t1846 = icmp eq i8* %t1844, %s1845
  br i1 %t1846, label %then22, label %merge23
then22:
  %t1847 = extractvalue %Statement %statement, 0
  %t1848 = alloca %Statement
  store %Statement %statement, %Statement* %t1848
  %t1849 = getelementptr inbounds %Statement, %Statement* %t1848, i32 0, i32 1
  %t1850 = bitcast [48 x i8]* %t1849 to i8*
  %t1851 = bitcast i8* %t1850 to i8**
  %t1852 = load i8*, i8** %t1851
  %t1853 = icmp eq i32 %t1847, 2
  %t1854 = select i1 %t1853, i8* %t1852, i8* null
  %t1855 = getelementptr inbounds %Statement, %Statement* %t1848, i32 0, i32 1
  %t1856 = bitcast [48 x i8]* %t1855 to i8*
  %t1857 = bitcast i8* %t1856 to i8**
  %t1858 = load i8*, i8** %t1857
  %t1859 = icmp eq i32 %t1847, 3
  %t1860 = select i1 %t1859, i8* %t1858, i8* %t1854
  %t1861 = getelementptr inbounds %Statement, %Statement* %t1848, i32 0, i32 1
  %t1862 = bitcast [40 x i8]* %t1861 to i8*
  %t1863 = bitcast i8* %t1862 to i8**
  %t1864 = load i8*, i8** %t1863
  %t1865 = icmp eq i32 %t1847, 6
  %t1866 = select i1 %t1865, i8* %t1864, i8* %t1860
  %t1867 = getelementptr inbounds %Statement, %Statement* %t1848, i32 0, i32 1
  %t1868 = bitcast [56 x i8]* %t1867 to i8*
  %t1869 = bitcast i8* %t1868 to i8**
  %t1870 = load i8*, i8** %t1869
  %t1871 = icmp eq i32 %t1847, 8
  %t1872 = select i1 %t1871, i8* %t1870, i8* %t1866
  %t1873 = getelementptr inbounds %Statement, %Statement* %t1848, i32 0, i32 1
  %t1874 = bitcast [40 x i8]* %t1873 to i8*
  %t1875 = bitcast i8* %t1874 to i8**
  %t1876 = load i8*, i8** %t1875
  %t1877 = icmp eq i32 %t1847, 9
  %t1878 = select i1 %t1877, i8* %t1876, i8* %t1872
  %t1879 = getelementptr inbounds %Statement, %Statement* %t1848, i32 0, i32 1
  %t1880 = bitcast [40 x i8]* %t1879 to i8*
  %t1881 = bitcast i8* %t1880 to i8**
  %t1882 = load i8*, i8** %t1881
  %t1883 = icmp eq i32 %t1847, 10
  %t1884 = select i1 %t1883, i8* %t1882, i8* %t1878
  %t1885 = getelementptr inbounds %Statement, %Statement* %t1848, i32 0, i32 1
  %t1886 = bitcast [40 x i8]* %t1885 to i8*
  %t1887 = bitcast i8* %t1886 to i8**
  %t1888 = load i8*, i8** %t1887
  %t1889 = icmp eq i32 %t1847, 11
  %t1890 = select i1 %t1889, i8* %t1888, i8* %t1884
  %s1891 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1891, i32 0, i32 0
  %t1892 = extractvalue %Statement %statement, 0
  %t1893 = alloca %Statement
  store %Statement %statement, %Statement* %t1893
  %t1894 = getelementptr inbounds %Statement, %Statement* %t1893, i32 0, i32 1
  %t1895 = bitcast [48 x i8]* %t1894 to i8*
  %t1896 = getelementptr inbounds i8, i8* %t1895, i64 8
  %t1897 = bitcast i8* %t1896 to %SourceSpan**
  %t1898 = load %SourceSpan*, %SourceSpan** %t1897
  %t1899 = icmp eq i32 %t1892, 3
  %t1900 = select i1 %t1899, %SourceSpan* %t1898, %SourceSpan* null
  %t1901 = getelementptr inbounds %Statement, %Statement* %t1893, i32 0, i32 1
  %t1902 = bitcast [40 x i8]* %t1901 to i8*
  %t1903 = getelementptr inbounds i8, i8* %t1902, i64 8
  %t1904 = bitcast i8* %t1903 to %SourceSpan**
  %t1905 = load %SourceSpan*, %SourceSpan** %t1904
  %t1906 = icmp eq i32 %t1892, 6
  %t1907 = select i1 %t1906, %SourceSpan* %t1905, %SourceSpan* %t1900
  %t1908 = getelementptr inbounds %Statement, %Statement* %t1893, i32 0, i32 1
  %t1909 = bitcast [56 x i8]* %t1908 to i8*
  %t1910 = getelementptr inbounds i8, i8* %t1909, i64 8
  %t1911 = bitcast i8* %t1910 to %SourceSpan**
  %t1912 = load %SourceSpan*, %SourceSpan** %t1911
  %t1913 = icmp eq i32 %t1892, 8
  %t1914 = select i1 %t1913, %SourceSpan* %t1912, %SourceSpan* %t1907
  %t1915 = getelementptr inbounds %Statement, %Statement* %t1893, i32 0, i32 1
  %t1916 = bitcast [40 x i8]* %t1915 to i8*
  %t1917 = getelementptr inbounds i8, i8* %t1916, i64 8
  %t1918 = bitcast i8* %t1917 to %SourceSpan**
  %t1919 = load %SourceSpan*, %SourceSpan** %t1918
  %t1920 = icmp eq i32 %t1892, 9
  %t1921 = select i1 %t1920, %SourceSpan* %t1919, %SourceSpan* %t1914
  %t1922 = getelementptr inbounds %Statement, %Statement* %t1893, i32 0, i32 1
  %t1923 = bitcast [40 x i8]* %t1922 to i8*
  %t1924 = getelementptr inbounds i8, i8* %t1923, i64 8
  %t1925 = bitcast i8* %t1924 to %SourceSpan**
  %t1926 = load %SourceSpan*, %SourceSpan** %t1925
  %t1927 = icmp eq i32 %t1892, 10
  %t1928 = select i1 %t1927, %SourceSpan* %t1926, %SourceSpan* %t1921
  %t1929 = getelementptr inbounds %Statement, %Statement* %t1893, i32 0, i32 1
  %t1930 = bitcast [40 x i8]* %t1929 to i8*
  %t1931 = getelementptr inbounds i8, i8* %t1930, i64 8
  %t1932 = bitcast i8* %t1931 to %SourceSpan**
  %t1933 = load %SourceSpan*, %SourceSpan** %t1932
  %t1934 = icmp eq i32 %t1892, 11
  %t1935 = select i1 %t1934, %SourceSpan* %t1933, %SourceSpan* %t1928
  %t1936 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1890, i8* %s1891, %SourceSpan* %t1935)
  store %ScopeResult %t1936, %ScopeResult* %l17
  %t1937 = load %ScopeResult, %ScopeResult* %l17
  %t1938 = extractvalue %ScopeResult %t1937, 1
  %t1939 = extractvalue %Statement %statement, 0
  %t1940 = alloca %Statement
  store %Statement %statement, %Statement* %t1940
  %t1941 = getelementptr inbounds %Statement, %Statement* %t1940, i32 0, i32 1
  %t1942 = bitcast [24 x i8]* %t1941 to i8*
  %t1943 = getelementptr inbounds i8, i8* %t1942, i64 8
  %t1944 = bitcast i8* %t1943 to %Block*
  %t1945 = load %Block, %Block* %t1944
  %t1946 = icmp eq i32 %t1939, 4
  %t1947 = select i1 %t1946, %Block %t1945, %Block zeroinitializer
  %t1948 = getelementptr inbounds %Statement, %Statement* %t1940, i32 0, i32 1
  %t1949 = bitcast [24 x i8]* %t1948 to i8*
  %t1950 = getelementptr inbounds i8, i8* %t1949, i64 8
  %t1951 = bitcast i8* %t1950 to %Block*
  %t1952 = load %Block, %Block* %t1951
  %t1953 = icmp eq i32 %t1939, 5
  %t1954 = select i1 %t1953, %Block %t1952, %Block %t1947
  %t1955 = getelementptr inbounds %Statement, %Statement* %t1940, i32 0, i32 1
  %t1956 = bitcast [40 x i8]* %t1955 to i8*
  %t1957 = getelementptr inbounds i8, i8* %t1956, i64 16
  %t1958 = bitcast i8* %t1957 to %Block*
  %t1959 = load %Block, %Block* %t1958
  %t1960 = icmp eq i32 %t1939, 6
  %t1961 = select i1 %t1960, %Block %t1959, %Block %t1954
  %t1962 = getelementptr inbounds %Statement, %Statement* %t1940, i32 0, i32 1
  %t1963 = bitcast [24 x i8]* %t1962 to i8*
  %t1964 = getelementptr inbounds i8, i8* %t1963, i64 8
  %t1965 = bitcast i8* %t1964 to %Block*
  %t1966 = load %Block, %Block* %t1965
  %t1967 = icmp eq i32 %t1939, 7
  %t1968 = select i1 %t1967, %Block %t1966, %Block %t1961
  %t1969 = getelementptr inbounds %Statement, %Statement* %t1940, i32 0, i32 1
  %t1970 = bitcast [40 x i8]* %t1969 to i8*
  %t1971 = getelementptr inbounds i8, i8* %t1970, i64 24
  %t1972 = bitcast i8* %t1971 to %Block*
  %t1973 = load %Block, %Block* %t1972
  %t1974 = icmp eq i32 %t1939, 12
  %t1975 = select i1 %t1974, %Block %t1973, %Block %t1968
  %t1976 = getelementptr inbounds %Statement, %Statement* %t1940, i32 0, i32 1
  %t1977 = bitcast [24 x i8]* %t1976 to i8*
  %t1978 = getelementptr inbounds i8, i8* %t1977, i64 8
  %t1979 = bitcast i8* %t1978 to %Block*
  %t1980 = load %Block, %Block* %t1979
  %t1981 = icmp eq i32 %t1939, 13
  %t1982 = select i1 %t1981, %Block %t1980, %Block %t1975
  %t1983 = getelementptr inbounds %Statement, %Statement* %t1940, i32 0, i32 1
  %t1984 = bitcast [24 x i8]* %t1983 to i8*
  %t1985 = getelementptr inbounds i8, i8* %t1984, i64 8
  %t1986 = bitcast i8* %t1985 to %Block*
  %t1987 = load %Block, %Block* %t1986
  %t1988 = icmp eq i32 %t1939, 14
  %t1989 = select i1 %t1988, %Block %t1987, %Block %t1982
  %t1990 = getelementptr inbounds %Statement, %Statement* %t1940, i32 0, i32 1
  %t1991 = bitcast [16 x i8]* %t1990 to i8*
  %t1992 = bitcast i8* %t1991 to %Block*
  %t1993 = load %Block, %Block* %t1992
  %t1994 = icmp eq i32 %t1939, 15
  %t1995 = select i1 %t1994, %Block %t1993, %Block %t1989
  %t1996 = alloca [0 x %SymbolEntry]
  %t1997 = getelementptr [0 x %SymbolEntry], [0 x %SymbolEntry]* %t1996, i32 0, i32 0
  %t1998 = alloca { %SymbolEntry*, i64 }
  %t1999 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t1998, i32 0, i32 0
  store %SymbolEntry* %t1997, %SymbolEntry** %t1999
  %t2000 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t1998, i32 0, i32 1
  store i64 0, i64* %t2000
  %t2001 = call { %Diagnostic*, i64 }* @check_block(%Block %t1995, { %SymbolEntry*, i64 }* %t1998, { %Statement*, i64 }* %interfaces)
  %t2002 = bitcast { %Diagnostic**, i64 }* %t1938 to { i8**, i64 }*
  %t2003 = bitcast { %Diagnostic*, i64 }* %t2001 to { i8**, i64 }*
  %t2004 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2002, { i8**, i64 }* %t2003)
  store { i8**, i64 }* %t2004, { i8**, i64 }** %l18
  %t2005 = load %ScopeResult, %ScopeResult* %l17
  %t2006 = extractvalue %ScopeResult %t2005, 0
  %t2007 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2006, 0
  %t2008 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t2009 = bitcast { i8**, i64 }* %t2008 to { %Diagnostic**, i64 }*
  %t2010 = insertvalue %ScopeResult %t2007, { %Diagnostic**, i64 }* %t2009, 1
  ret %ScopeResult %t2010
merge23:
  %t2011 = extractvalue %Statement %statement, 0
  %t2012 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2013 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2014 = icmp eq i32 %t2011, 0
  %t2015 = select i1 %t2014, i8* %t2013, i8* %t2012
  %t2016 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2017 = icmp eq i32 %t2011, 1
  %t2018 = select i1 %t2017, i8* %t2016, i8* %t2015
  %t2019 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2020 = icmp eq i32 %t2011, 2
  %t2021 = select i1 %t2020, i8* %t2019, i8* %t2018
  %t2022 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2023 = icmp eq i32 %t2011, 3
  %t2024 = select i1 %t2023, i8* %t2022, i8* %t2021
  %t2025 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2026 = icmp eq i32 %t2011, 4
  %t2027 = select i1 %t2026, i8* %t2025, i8* %t2024
  %t2028 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2029 = icmp eq i32 %t2011, 5
  %t2030 = select i1 %t2029, i8* %t2028, i8* %t2027
  %t2031 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2032 = icmp eq i32 %t2011, 6
  %t2033 = select i1 %t2032, i8* %t2031, i8* %t2030
  %t2034 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2035 = icmp eq i32 %t2011, 7
  %t2036 = select i1 %t2035, i8* %t2034, i8* %t2033
  %t2037 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2038 = icmp eq i32 %t2011, 8
  %t2039 = select i1 %t2038, i8* %t2037, i8* %t2036
  %t2040 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2041 = icmp eq i32 %t2011, 9
  %t2042 = select i1 %t2041, i8* %t2040, i8* %t2039
  %t2043 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2044 = icmp eq i32 %t2011, 10
  %t2045 = select i1 %t2044, i8* %t2043, i8* %t2042
  %t2046 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2047 = icmp eq i32 %t2011, 11
  %t2048 = select i1 %t2047, i8* %t2046, i8* %t2045
  %t2049 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2050 = icmp eq i32 %t2011, 12
  %t2051 = select i1 %t2050, i8* %t2049, i8* %t2048
  %t2052 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2053 = icmp eq i32 %t2011, 13
  %t2054 = select i1 %t2053, i8* %t2052, i8* %t2051
  %t2055 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2056 = icmp eq i32 %t2011, 14
  %t2057 = select i1 %t2056, i8* %t2055, i8* %t2054
  %t2058 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2059 = icmp eq i32 %t2011, 15
  %t2060 = select i1 %t2059, i8* %t2058, i8* %t2057
  %t2061 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2062 = icmp eq i32 %t2011, 16
  %t2063 = select i1 %t2062, i8* %t2061, i8* %t2060
  %t2064 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2065 = icmp eq i32 %t2011, 17
  %t2066 = select i1 %t2065, i8* %t2064, i8* %t2063
  %t2067 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2068 = icmp eq i32 %t2011, 18
  %t2069 = select i1 %t2068, i8* %t2067, i8* %t2066
  %t2070 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2071 = icmp eq i32 %t2011, 19
  %t2072 = select i1 %t2071, i8* %t2070, i8* %t2069
  %t2073 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2074 = icmp eq i32 %t2011, 20
  %t2075 = select i1 %t2074, i8* %t2073, i8* %t2072
  %t2076 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2077 = icmp eq i32 %t2011, 21
  %t2078 = select i1 %t2077, i8* %t2076, i8* %t2075
  %t2079 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2080 = icmp eq i32 %t2011, 22
  %t2081 = select i1 %t2080, i8* %t2079, i8* %t2078
  %s2082 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.2082, i32 0, i32 0
  %t2083 = icmp eq i8* %t2081, %s2082
  br i1 %t2083, label %then24, label %merge25
then24:
  %t2084 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2085 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2084, 0
  %t2086 = extractvalue %Statement %statement, 0
  %t2087 = alloca %Statement
  store %Statement %statement, %Statement* %t2087
  %t2088 = getelementptr inbounds %Statement, %Statement* %t2087, i32 0, i32 1
  %t2089 = bitcast [24 x i8]* %t2088 to i8*
  %t2090 = getelementptr inbounds i8, i8* %t2089, i64 8
  %t2091 = bitcast i8* %t2090 to %Block*
  %t2092 = load %Block, %Block* %t2091
  %t2093 = icmp eq i32 %t2086, 4
  %t2094 = select i1 %t2093, %Block %t2092, %Block zeroinitializer
  %t2095 = getelementptr inbounds %Statement, %Statement* %t2087, i32 0, i32 1
  %t2096 = bitcast [24 x i8]* %t2095 to i8*
  %t2097 = getelementptr inbounds i8, i8* %t2096, i64 8
  %t2098 = bitcast i8* %t2097 to %Block*
  %t2099 = load %Block, %Block* %t2098
  %t2100 = icmp eq i32 %t2086, 5
  %t2101 = select i1 %t2100, %Block %t2099, %Block %t2094
  %t2102 = getelementptr inbounds %Statement, %Statement* %t2087, i32 0, i32 1
  %t2103 = bitcast [40 x i8]* %t2102 to i8*
  %t2104 = getelementptr inbounds i8, i8* %t2103, i64 16
  %t2105 = bitcast i8* %t2104 to %Block*
  %t2106 = load %Block, %Block* %t2105
  %t2107 = icmp eq i32 %t2086, 6
  %t2108 = select i1 %t2107, %Block %t2106, %Block %t2101
  %t2109 = getelementptr inbounds %Statement, %Statement* %t2087, i32 0, i32 1
  %t2110 = bitcast [24 x i8]* %t2109 to i8*
  %t2111 = getelementptr inbounds i8, i8* %t2110, i64 8
  %t2112 = bitcast i8* %t2111 to %Block*
  %t2113 = load %Block, %Block* %t2112
  %t2114 = icmp eq i32 %t2086, 7
  %t2115 = select i1 %t2114, %Block %t2113, %Block %t2108
  %t2116 = getelementptr inbounds %Statement, %Statement* %t2087, i32 0, i32 1
  %t2117 = bitcast [40 x i8]* %t2116 to i8*
  %t2118 = getelementptr inbounds i8, i8* %t2117, i64 24
  %t2119 = bitcast i8* %t2118 to %Block*
  %t2120 = load %Block, %Block* %t2119
  %t2121 = icmp eq i32 %t2086, 12
  %t2122 = select i1 %t2121, %Block %t2120, %Block %t2115
  %t2123 = getelementptr inbounds %Statement, %Statement* %t2087, i32 0, i32 1
  %t2124 = bitcast [24 x i8]* %t2123 to i8*
  %t2125 = getelementptr inbounds i8, i8* %t2124, i64 8
  %t2126 = bitcast i8* %t2125 to %Block*
  %t2127 = load %Block, %Block* %t2126
  %t2128 = icmp eq i32 %t2086, 13
  %t2129 = select i1 %t2128, %Block %t2127, %Block %t2122
  %t2130 = getelementptr inbounds %Statement, %Statement* %t2087, i32 0, i32 1
  %t2131 = bitcast [24 x i8]* %t2130 to i8*
  %t2132 = getelementptr inbounds i8, i8* %t2131, i64 8
  %t2133 = bitcast i8* %t2132 to %Block*
  %t2134 = load %Block, %Block* %t2133
  %t2135 = icmp eq i32 %t2086, 14
  %t2136 = select i1 %t2135, %Block %t2134, %Block %t2129
  %t2137 = getelementptr inbounds %Statement, %Statement* %t2087, i32 0, i32 1
  %t2138 = bitcast [16 x i8]* %t2137 to i8*
  %t2139 = bitcast i8* %t2138 to %Block*
  %t2140 = load %Block, %Block* %t2139
  %t2141 = icmp eq i32 %t2086, 15
  %t2142 = select i1 %t2141, %Block %t2140, %Block %t2136
  %t2143 = call { %Diagnostic*, i64 }* @check_block(%Block %t2142, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2144 = bitcast { %Diagnostic*, i64 }* %t2143 to { %Diagnostic**, i64 }*
  %t2145 = insertvalue %ScopeResult %t2085, { %Diagnostic**, i64 }* %t2144, 1
  ret %ScopeResult %t2145
merge25:
  %t2146 = extractvalue %Statement %statement, 0
  %t2147 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2148 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2149 = icmp eq i32 %t2146, 0
  %t2150 = select i1 %t2149, i8* %t2148, i8* %t2147
  %t2151 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2152 = icmp eq i32 %t2146, 1
  %t2153 = select i1 %t2152, i8* %t2151, i8* %t2150
  %t2154 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2155 = icmp eq i32 %t2146, 2
  %t2156 = select i1 %t2155, i8* %t2154, i8* %t2153
  %t2157 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2158 = icmp eq i32 %t2146, 3
  %t2159 = select i1 %t2158, i8* %t2157, i8* %t2156
  %t2160 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2161 = icmp eq i32 %t2146, 4
  %t2162 = select i1 %t2161, i8* %t2160, i8* %t2159
  %t2163 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2164 = icmp eq i32 %t2146, 5
  %t2165 = select i1 %t2164, i8* %t2163, i8* %t2162
  %t2166 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2167 = icmp eq i32 %t2146, 6
  %t2168 = select i1 %t2167, i8* %t2166, i8* %t2165
  %t2169 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2170 = icmp eq i32 %t2146, 7
  %t2171 = select i1 %t2170, i8* %t2169, i8* %t2168
  %t2172 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2173 = icmp eq i32 %t2146, 8
  %t2174 = select i1 %t2173, i8* %t2172, i8* %t2171
  %t2175 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2176 = icmp eq i32 %t2146, 9
  %t2177 = select i1 %t2176, i8* %t2175, i8* %t2174
  %t2178 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2179 = icmp eq i32 %t2146, 10
  %t2180 = select i1 %t2179, i8* %t2178, i8* %t2177
  %t2181 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2182 = icmp eq i32 %t2146, 11
  %t2183 = select i1 %t2182, i8* %t2181, i8* %t2180
  %t2184 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2185 = icmp eq i32 %t2146, 12
  %t2186 = select i1 %t2185, i8* %t2184, i8* %t2183
  %t2187 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2188 = icmp eq i32 %t2146, 13
  %t2189 = select i1 %t2188, i8* %t2187, i8* %t2186
  %t2190 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2191 = icmp eq i32 %t2146, 14
  %t2192 = select i1 %t2191, i8* %t2190, i8* %t2189
  %t2193 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2194 = icmp eq i32 %t2146, 15
  %t2195 = select i1 %t2194, i8* %t2193, i8* %t2192
  %t2196 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2197 = icmp eq i32 %t2146, 16
  %t2198 = select i1 %t2197, i8* %t2196, i8* %t2195
  %t2199 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2200 = icmp eq i32 %t2146, 17
  %t2201 = select i1 %t2200, i8* %t2199, i8* %t2198
  %t2202 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2203 = icmp eq i32 %t2146, 18
  %t2204 = select i1 %t2203, i8* %t2202, i8* %t2201
  %t2205 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2206 = icmp eq i32 %t2146, 19
  %t2207 = select i1 %t2206, i8* %t2205, i8* %t2204
  %t2208 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2209 = icmp eq i32 %t2146, 20
  %t2210 = select i1 %t2209, i8* %t2208, i8* %t2207
  %t2211 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2212 = icmp eq i32 %t2146, 21
  %t2213 = select i1 %t2212, i8* %t2211, i8* %t2210
  %t2214 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2215 = icmp eq i32 %t2146, 22
  %t2216 = select i1 %t2215, i8* %t2214, i8* %t2213
  %s2217 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.2217, i32 0, i32 0
  %t2218 = icmp eq i8* %t2216, %s2217
  br i1 %t2218, label %then26, label %merge27
then26:
  %t2219 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2220 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2219, 0
  %t2221 = extractvalue %Statement %statement, 0
  %t2222 = alloca %Statement
  store %Statement %statement, %Statement* %t2222
  %t2223 = getelementptr inbounds %Statement, %Statement* %t2222, i32 0, i32 1
  %t2224 = bitcast [24 x i8]* %t2223 to i8*
  %t2225 = getelementptr inbounds i8, i8* %t2224, i64 8
  %t2226 = bitcast i8* %t2225 to %Block*
  %t2227 = load %Block, %Block* %t2226
  %t2228 = icmp eq i32 %t2221, 4
  %t2229 = select i1 %t2228, %Block %t2227, %Block zeroinitializer
  %t2230 = getelementptr inbounds %Statement, %Statement* %t2222, i32 0, i32 1
  %t2231 = bitcast [24 x i8]* %t2230 to i8*
  %t2232 = getelementptr inbounds i8, i8* %t2231, i64 8
  %t2233 = bitcast i8* %t2232 to %Block*
  %t2234 = load %Block, %Block* %t2233
  %t2235 = icmp eq i32 %t2221, 5
  %t2236 = select i1 %t2235, %Block %t2234, %Block %t2229
  %t2237 = getelementptr inbounds %Statement, %Statement* %t2222, i32 0, i32 1
  %t2238 = bitcast [40 x i8]* %t2237 to i8*
  %t2239 = getelementptr inbounds i8, i8* %t2238, i64 16
  %t2240 = bitcast i8* %t2239 to %Block*
  %t2241 = load %Block, %Block* %t2240
  %t2242 = icmp eq i32 %t2221, 6
  %t2243 = select i1 %t2242, %Block %t2241, %Block %t2236
  %t2244 = getelementptr inbounds %Statement, %Statement* %t2222, i32 0, i32 1
  %t2245 = bitcast [24 x i8]* %t2244 to i8*
  %t2246 = getelementptr inbounds i8, i8* %t2245, i64 8
  %t2247 = bitcast i8* %t2246 to %Block*
  %t2248 = load %Block, %Block* %t2247
  %t2249 = icmp eq i32 %t2221, 7
  %t2250 = select i1 %t2249, %Block %t2248, %Block %t2243
  %t2251 = getelementptr inbounds %Statement, %Statement* %t2222, i32 0, i32 1
  %t2252 = bitcast [40 x i8]* %t2251 to i8*
  %t2253 = getelementptr inbounds i8, i8* %t2252, i64 24
  %t2254 = bitcast i8* %t2253 to %Block*
  %t2255 = load %Block, %Block* %t2254
  %t2256 = icmp eq i32 %t2221, 12
  %t2257 = select i1 %t2256, %Block %t2255, %Block %t2250
  %t2258 = getelementptr inbounds %Statement, %Statement* %t2222, i32 0, i32 1
  %t2259 = bitcast [24 x i8]* %t2258 to i8*
  %t2260 = getelementptr inbounds i8, i8* %t2259, i64 8
  %t2261 = bitcast i8* %t2260 to %Block*
  %t2262 = load %Block, %Block* %t2261
  %t2263 = icmp eq i32 %t2221, 13
  %t2264 = select i1 %t2263, %Block %t2262, %Block %t2257
  %t2265 = getelementptr inbounds %Statement, %Statement* %t2222, i32 0, i32 1
  %t2266 = bitcast [24 x i8]* %t2265 to i8*
  %t2267 = getelementptr inbounds i8, i8* %t2266, i64 8
  %t2268 = bitcast i8* %t2267 to %Block*
  %t2269 = load %Block, %Block* %t2268
  %t2270 = icmp eq i32 %t2221, 14
  %t2271 = select i1 %t2270, %Block %t2269, %Block %t2264
  %t2272 = getelementptr inbounds %Statement, %Statement* %t2222, i32 0, i32 1
  %t2273 = bitcast [16 x i8]* %t2272 to i8*
  %t2274 = bitcast i8* %t2273 to %Block*
  %t2275 = load %Block, %Block* %t2274
  %t2276 = icmp eq i32 %t2221, 15
  %t2277 = select i1 %t2276, %Block %t2275, %Block %t2271
  %t2278 = call { %Diagnostic*, i64 }* @check_block(%Block %t2277, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2279 = bitcast { %Diagnostic*, i64 }* %t2278 to { %Diagnostic**, i64 }*
  %t2280 = insertvalue %ScopeResult %t2220, { %Diagnostic**, i64 }* %t2279, 1
  ret %ScopeResult %t2280
merge27:
  %t2281 = extractvalue %Statement %statement, 0
  %t2282 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2283 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2284 = icmp eq i32 %t2281, 0
  %t2285 = select i1 %t2284, i8* %t2283, i8* %t2282
  %t2286 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2287 = icmp eq i32 %t2281, 1
  %t2288 = select i1 %t2287, i8* %t2286, i8* %t2285
  %t2289 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2290 = icmp eq i32 %t2281, 2
  %t2291 = select i1 %t2290, i8* %t2289, i8* %t2288
  %t2292 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2293 = icmp eq i32 %t2281, 3
  %t2294 = select i1 %t2293, i8* %t2292, i8* %t2291
  %t2295 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2296 = icmp eq i32 %t2281, 4
  %t2297 = select i1 %t2296, i8* %t2295, i8* %t2294
  %t2298 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2299 = icmp eq i32 %t2281, 5
  %t2300 = select i1 %t2299, i8* %t2298, i8* %t2297
  %t2301 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2302 = icmp eq i32 %t2281, 6
  %t2303 = select i1 %t2302, i8* %t2301, i8* %t2300
  %t2304 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2305 = icmp eq i32 %t2281, 7
  %t2306 = select i1 %t2305, i8* %t2304, i8* %t2303
  %t2307 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2308 = icmp eq i32 %t2281, 8
  %t2309 = select i1 %t2308, i8* %t2307, i8* %t2306
  %t2310 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2311 = icmp eq i32 %t2281, 9
  %t2312 = select i1 %t2311, i8* %t2310, i8* %t2309
  %t2313 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2314 = icmp eq i32 %t2281, 10
  %t2315 = select i1 %t2314, i8* %t2313, i8* %t2312
  %t2316 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2317 = icmp eq i32 %t2281, 11
  %t2318 = select i1 %t2317, i8* %t2316, i8* %t2315
  %t2319 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2320 = icmp eq i32 %t2281, 12
  %t2321 = select i1 %t2320, i8* %t2319, i8* %t2318
  %t2322 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2323 = icmp eq i32 %t2281, 13
  %t2324 = select i1 %t2323, i8* %t2322, i8* %t2321
  %t2325 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2326 = icmp eq i32 %t2281, 14
  %t2327 = select i1 %t2326, i8* %t2325, i8* %t2324
  %t2328 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2329 = icmp eq i32 %t2281, 15
  %t2330 = select i1 %t2329, i8* %t2328, i8* %t2327
  %t2331 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2332 = icmp eq i32 %t2281, 16
  %t2333 = select i1 %t2332, i8* %t2331, i8* %t2330
  %t2334 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2335 = icmp eq i32 %t2281, 17
  %t2336 = select i1 %t2335, i8* %t2334, i8* %t2333
  %t2337 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2338 = icmp eq i32 %t2281, 18
  %t2339 = select i1 %t2338, i8* %t2337, i8* %t2336
  %t2340 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2341 = icmp eq i32 %t2281, 19
  %t2342 = select i1 %t2341, i8* %t2340, i8* %t2339
  %t2343 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2344 = icmp eq i32 %t2281, 20
  %t2345 = select i1 %t2344, i8* %t2343, i8* %t2342
  %t2346 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2347 = icmp eq i32 %t2281, 21
  %t2348 = select i1 %t2347, i8* %t2346, i8* %t2345
  %t2349 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2350 = icmp eq i32 %t2281, 22
  %t2351 = select i1 %t2350, i8* %t2349, i8* %t2348
  %s2352 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.2352, i32 0, i32 0
  %t2353 = icmp eq i8* %t2351, %s2352
  br i1 %t2353, label %then28, label %merge29
then28:
  %t2354 = alloca [0 x %Diagnostic]
  %t2355 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t2354, i32 0, i32 0
  %t2356 = alloca { %Diagnostic*, i64 }
  %t2357 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2356, i32 0, i32 0
  store %Diagnostic* %t2355, %Diagnostic** %t2357
  %t2358 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2356, i32 0, i32 1
  store i64 0, i64* %t2358
  store { %Diagnostic*, i64 }* %t2356, { %Diagnostic*, i64 }** %l19
  %t2359 = sitofp i64 0 to double
  store double %t2359, double* %l20
  %t2360 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2361 = load double, double* %l20
  br label %loop.header30
loop.header30:
  %t2409 = phi { %Diagnostic*, i64 }* [ %t2360, %then28 ], [ %t2407, %loop.latch32 ]
  %t2410 = phi double [ %t2361, %then28 ], [ %t2408, %loop.latch32 ]
  store { %Diagnostic*, i64 }* %t2409, { %Diagnostic*, i64 }** %l19
  store double %t2410, double* %l20
  br label %loop.body31
loop.body31:
  %t2362 = load double, double* %l20
  %t2363 = extractvalue %Statement %statement, 0
  %t2364 = alloca %Statement
  store %Statement %statement, %Statement* %t2364
  %t2365 = getelementptr inbounds %Statement, %Statement* %t2364, i32 0, i32 1
  %t2366 = bitcast [24 x i8]* %t2365 to i8*
  %t2367 = getelementptr inbounds i8, i8* %t2366, i64 8
  %t2368 = bitcast i8* %t2367 to { %MatchCase**, i64 }**
  %t2369 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t2368
  %t2370 = icmp eq i32 %t2363, 18
  %t2371 = select i1 %t2370, { %MatchCase**, i64 }* %t2369, { %MatchCase**, i64 }* null
  %t2372 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t2371
  %t2373 = extractvalue { %MatchCase**, i64 } %t2372, 1
  %t2374 = sitofp i64 %t2373 to double
  %t2375 = fcmp oge double %t2362, %t2374
  %t2376 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2377 = load double, double* %l20
  br i1 %t2375, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t2378 = extractvalue %Statement %statement, 0
  %t2379 = alloca %Statement
  store %Statement %statement, %Statement* %t2379
  %t2380 = getelementptr inbounds %Statement, %Statement* %t2379, i32 0, i32 1
  %t2381 = bitcast [24 x i8]* %t2380 to i8*
  %t2382 = getelementptr inbounds i8, i8* %t2381, i64 8
  %t2383 = bitcast i8* %t2382 to { %MatchCase**, i64 }**
  %t2384 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t2383
  %t2385 = icmp eq i32 %t2378, 18
  %t2386 = select i1 %t2385, { %MatchCase**, i64 }* %t2384, { %MatchCase**, i64 }* null
  %t2387 = load double, double* %l20
  %t2388 = fptosi double %t2387 to i64
  %t2389 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t2386
  %t2390 = extractvalue { %MatchCase**, i64 } %t2389, 0
  %t2391 = extractvalue { %MatchCase**, i64 } %t2389, 1
  %t2392 = icmp uge i64 %t2388, %t2391
  ; bounds check: %t2392 (if true, out of bounds)
  %t2393 = getelementptr %MatchCase*, %MatchCase** %t2390, i64 %t2388
  %t2394 = load %MatchCase*, %MatchCase** %t2393
  store %MatchCase* %t2394, %MatchCase** %l21
  %t2395 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2396 = load %MatchCase*, %MatchCase** %l21
  %t2397 = getelementptr %MatchCase, %MatchCase* %t2396, i32 0, i32 2
  %t2398 = load %Block, %Block* %t2397
  %t2399 = call { %Diagnostic*, i64 }* @check_block(%Block %t2398, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2400 = bitcast { %Diagnostic*, i64 }* %t2395 to { i8**, i64 }*
  %t2401 = bitcast { %Diagnostic*, i64 }* %t2399 to { i8**, i64 }*
  %t2402 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2400, { i8**, i64 }* %t2401)
  %t2403 = bitcast { i8**, i64 }* %t2402 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t2403, { %Diagnostic*, i64 }** %l19
  %t2404 = load double, double* %l20
  %t2405 = sitofp i64 1 to double
  %t2406 = fadd double %t2404, %t2405
  store double %t2406, double* %l20
  br label %loop.latch32
loop.latch32:
  %t2407 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2408 = load double, double* %l20
  br label %loop.header30
afterloop33:
  %t2411 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2412 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2411, 0
  %t2413 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2414 = bitcast { %Diagnostic*, i64 }* %t2413 to { %Diagnostic**, i64 }*
  %t2415 = insertvalue %ScopeResult %t2412, { %Diagnostic**, i64 }* %t2414, 1
  ret %ScopeResult %t2415
merge29:
  %t2416 = extractvalue %Statement %statement, 0
  %t2417 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2418 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2419 = icmp eq i32 %t2416, 0
  %t2420 = select i1 %t2419, i8* %t2418, i8* %t2417
  %t2421 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2422 = icmp eq i32 %t2416, 1
  %t2423 = select i1 %t2422, i8* %t2421, i8* %t2420
  %t2424 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2425 = icmp eq i32 %t2416, 2
  %t2426 = select i1 %t2425, i8* %t2424, i8* %t2423
  %t2427 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2428 = icmp eq i32 %t2416, 3
  %t2429 = select i1 %t2428, i8* %t2427, i8* %t2426
  %t2430 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2431 = icmp eq i32 %t2416, 4
  %t2432 = select i1 %t2431, i8* %t2430, i8* %t2429
  %t2433 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2434 = icmp eq i32 %t2416, 5
  %t2435 = select i1 %t2434, i8* %t2433, i8* %t2432
  %t2436 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2437 = icmp eq i32 %t2416, 6
  %t2438 = select i1 %t2437, i8* %t2436, i8* %t2435
  %t2439 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2440 = icmp eq i32 %t2416, 7
  %t2441 = select i1 %t2440, i8* %t2439, i8* %t2438
  %t2442 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2443 = icmp eq i32 %t2416, 8
  %t2444 = select i1 %t2443, i8* %t2442, i8* %t2441
  %t2445 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2446 = icmp eq i32 %t2416, 9
  %t2447 = select i1 %t2446, i8* %t2445, i8* %t2444
  %t2448 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2449 = icmp eq i32 %t2416, 10
  %t2450 = select i1 %t2449, i8* %t2448, i8* %t2447
  %t2451 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2452 = icmp eq i32 %t2416, 11
  %t2453 = select i1 %t2452, i8* %t2451, i8* %t2450
  %t2454 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2455 = icmp eq i32 %t2416, 12
  %t2456 = select i1 %t2455, i8* %t2454, i8* %t2453
  %t2457 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2458 = icmp eq i32 %t2416, 13
  %t2459 = select i1 %t2458, i8* %t2457, i8* %t2456
  %t2460 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2461 = icmp eq i32 %t2416, 14
  %t2462 = select i1 %t2461, i8* %t2460, i8* %t2459
  %t2463 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2464 = icmp eq i32 %t2416, 15
  %t2465 = select i1 %t2464, i8* %t2463, i8* %t2462
  %t2466 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2467 = icmp eq i32 %t2416, 16
  %t2468 = select i1 %t2467, i8* %t2466, i8* %t2465
  %t2469 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2470 = icmp eq i32 %t2416, 17
  %t2471 = select i1 %t2470, i8* %t2469, i8* %t2468
  %t2472 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2473 = icmp eq i32 %t2416, 18
  %t2474 = select i1 %t2473, i8* %t2472, i8* %t2471
  %t2475 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2476 = icmp eq i32 %t2416, 19
  %t2477 = select i1 %t2476, i8* %t2475, i8* %t2474
  %t2478 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2479 = icmp eq i32 %t2416, 20
  %t2480 = select i1 %t2479, i8* %t2478, i8* %t2477
  %t2481 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2482 = icmp eq i32 %t2416, 21
  %t2483 = select i1 %t2482, i8* %t2481, i8* %t2480
  %t2484 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2485 = icmp eq i32 %t2416, 22
  %t2486 = select i1 %t2485, i8* %t2484, i8* %t2483
  %s2487 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.2487, i32 0, i32 0
  %t2488 = icmp eq i8* %t2486, %s2487
  br i1 %t2488, label %then36, label %merge37
then36:
  %t2489 = extractvalue %Statement %statement, 0
  %t2490 = alloca %Statement
  store %Statement %statement, %Statement* %t2490
  %t2491 = getelementptr inbounds %Statement, %Statement* %t2490, i32 0, i32 1
  %t2492 = bitcast [32 x i8]* %t2491 to i8*
  %t2493 = getelementptr inbounds i8, i8* %t2492, i64 8
  %t2494 = bitcast i8* %t2493 to %Block*
  %t2495 = load %Block, %Block* %t2494
  %t2496 = icmp eq i32 %t2489, 19
  %t2497 = select i1 %t2496, %Block %t2495, %Block zeroinitializer
  %t2498 = call { %Diagnostic*, i64 }* @check_block(%Block %t2497, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t2498, { %Diagnostic*, i64 }** %l22
  %t2499 = extractvalue %Statement %statement, 0
  %t2500 = alloca %Statement
  store %Statement %statement, %Statement* %t2500
  %t2501 = getelementptr inbounds %Statement, %Statement* %t2500, i32 0, i32 1
  %t2502 = bitcast [32 x i8]* %t2501 to i8*
  %t2503 = getelementptr inbounds i8, i8* %t2502, i64 16
  %t2504 = bitcast i8* %t2503 to %ElseBranch**
  %t2505 = load %ElseBranch*, %ElseBranch** %t2504
  %t2506 = icmp eq i32 %t2499, 19
  %t2507 = select i1 %t2506, %ElseBranch* %t2505, %ElseBranch* null
  %t2508 = icmp ne %ElseBranch* %t2507, null
  %t2509 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br i1 %t2508, label %then38, label %merge39
then38:
  %t2510 = extractvalue %Statement %statement, 0
  %t2511 = alloca %Statement
  store %Statement %statement, %Statement* %t2511
  %t2512 = getelementptr inbounds %Statement, %Statement* %t2511, i32 0, i32 1
  %t2513 = bitcast [32 x i8]* %t2512 to i8*
  %t2514 = getelementptr inbounds i8, i8* %t2513, i64 16
  %t2515 = bitcast i8* %t2514 to %ElseBranch**
  %t2516 = load %ElseBranch*, %ElseBranch** %t2515
  %t2517 = icmp eq i32 %t2510, 19
  %t2518 = select i1 %t2517, %ElseBranch* %t2516, %ElseBranch* null
  store %ElseBranch* %t2518, %ElseBranch** %l23
  %t2519 = load %ElseBranch*, %ElseBranch** %l23
  %t2520 = getelementptr %ElseBranch, %ElseBranch* %t2519, i32 0, i32 1
  %t2521 = load %Block*, %Block** %t2520
  %t2522 = icmp ne %Block* %t2521, null
  %t2523 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2524 = load %ElseBranch*, %ElseBranch** %l23
  br i1 %t2522, label %then40, label %merge41
then40:
  %t2525 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2526 = load %ElseBranch*, %ElseBranch** %l23
  %t2527 = getelementptr %ElseBranch, %ElseBranch* %t2526, i32 0, i32 1
  %t2528 = load %Block*, %Block** %t2527
  %t2529 = load %Block, %Block* %t2528
  %t2530 = call { %Diagnostic*, i64 }* @check_block(%Block %t2529, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2531 = bitcast { %Diagnostic*, i64 }* %t2525 to { i8**, i64 }*
  %t2532 = bitcast { %Diagnostic*, i64 }* %t2530 to { i8**, i64 }*
  %t2533 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2531, { i8**, i64 }* %t2532)
  %t2534 = bitcast { i8**, i64 }* %t2533 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t2534, { %Diagnostic*, i64 }** %l22
  br label %merge41
merge41:
  %t2535 = phi { %Diagnostic*, i64 }* [ %t2534, %then40 ], [ %t2523, %then38 ]
  store { %Diagnostic*, i64 }* %t2535, { %Diagnostic*, i64 }** %l22
  %t2536 = load %ElseBranch*, %ElseBranch** %l23
  %t2537 = getelementptr %ElseBranch, %ElseBranch* %t2536, i32 0, i32 0
  %t2538 = load %Statement*, %Statement** %t2537
  %t2539 = icmp ne %Statement* %t2538, null
  %t2540 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2541 = load %ElseBranch*, %ElseBranch** %l23
  br i1 %t2539, label %then42, label %merge43
then42:
  %t2542 = load %ElseBranch*, %ElseBranch** %l23
  %t2543 = getelementptr %ElseBranch, %ElseBranch* %t2542, i32 0, i32 0
  %t2544 = load %Statement*, %Statement** %t2543
  %t2545 = load %Statement, %Statement* %t2544
  %t2546 = call %ScopeResult @check_statement(%Statement %t2545, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  store %ScopeResult %t2546, %ScopeResult* %l24
  %t2547 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2548 = load %ScopeResult, %ScopeResult* %l24
  %t2549 = extractvalue %ScopeResult %t2548, 1
  %t2550 = bitcast { %Diagnostic*, i64 }* %t2547 to { i8**, i64 }*
  %t2551 = bitcast { %Diagnostic**, i64 }* %t2549 to { i8**, i64 }*
  %t2552 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2550, { i8**, i64 }* %t2551)
  %t2553 = bitcast { i8**, i64 }* %t2552 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t2553, { %Diagnostic*, i64 }** %l22
  br label %merge43
merge43:
  %t2554 = phi { %Diagnostic*, i64 }* [ %t2553, %then42 ], [ %t2540, %then38 ]
  store { %Diagnostic*, i64 }* %t2554, { %Diagnostic*, i64 }** %l22
  br label %merge39
merge39:
  %t2555 = phi { %Diagnostic*, i64 }* [ %t2534, %then38 ], [ %t2509, %then36 ]
  %t2556 = phi { %Diagnostic*, i64 }* [ %t2553, %then38 ], [ %t2509, %then36 ]
  store { %Diagnostic*, i64 }* %t2555, { %Diagnostic*, i64 }** %l22
  store { %Diagnostic*, i64 }* %t2556, { %Diagnostic*, i64 }** %l22
  %t2557 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2558 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2557, 0
  %t2559 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2560 = bitcast { %Diagnostic*, i64 }* %t2559 to { %Diagnostic**, i64 }*
  %t2561 = insertvalue %ScopeResult %t2558, { %Diagnostic**, i64 }* %t2560, 1
  ret %ScopeResult %t2561
merge37:
  %t2562 = extractvalue %Statement %statement, 0
  %t2563 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2564 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2565 = icmp eq i32 %t2562, 0
  %t2566 = select i1 %t2565, i8* %t2564, i8* %t2563
  %t2567 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2568 = icmp eq i32 %t2562, 1
  %t2569 = select i1 %t2568, i8* %t2567, i8* %t2566
  %t2570 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2571 = icmp eq i32 %t2562, 2
  %t2572 = select i1 %t2571, i8* %t2570, i8* %t2569
  %t2573 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2574 = icmp eq i32 %t2562, 3
  %t2575 = select i1 %t2574, i8* %t2573, i8* %t2572
  %t2576 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2577 = icmp eq i32 %t2562, 4
  %t2578 = select i1 %t2577, i8* %t2576, i8* %t2575
  %t2579 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2580 = icmp eq i32 %t2562, 5
  %t2581 = select i1 %t2580, i8* %t2579, i8* %t2578
  %t2582 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2583 = icmp eq i32 %t2562, 6
  %t2584 = select i1 %t2583, i8* %t2582, i8* %t2581
  %t2585 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2586 = icmp eq i32 %t2562, 7
  %t2587 = select i1 %t2586, i8* %t2585, i8* %t2584
  %t2588 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2589 = icmp eq i32 %t2562, 8
  %t2590 = select i1 %t2589, i8* %t2588, i8* %t2587
  %t2591 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2592 = icmp eq i32 %t2562, 9
  %t2593 = select i1 %t2592, i8* %t2591, i8* %t2590
  %t2594 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2595 = icmp eq i32 %t2562, 10
  %t2596 = select i1 %t2595, i8* %t2594, i8* %t2593
  %t2597 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2598 = icmp eq i32 %t2562, 11
  %t2599 = select i1 %t2598, i8* %t2597, i8* %t2596
  %t2600 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2601 = icmp eq i32 %t2562, 12
  %t2602 = select i1 %t2601, i8* %t2600, i8* %t2599
  %t2603 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2604 = icmp eq i32 %t2562, 13
  %t2605 = select i1 %t2604, i8* %t2603, i8* %t2602
  %t2606 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2607 = icmp eq i32 %t2562, 14
  %t2608 = select i1 %t2607, i8* %t2606, i8* %t2605
  %t2609 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2610 = icmp eq i32 %t2562, 15
  %t2611 = select i1 %t2610, i8* %t2609, i8* %t2608
  %t2612 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2613 = icmp eq i32 %t2562, 16
  %t2614 = select i1 %t2613, i8* %t2612, i8* %t2611
  %t2615 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2616 = icmp eq i32 %t2562, 17
  %t2617 = select i1 %t2616, i8* %t2615, i8* %t2614
  %t2618 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2619 = icmp eq i32 %t2562, 18
  %t2620 = select i1 %t2619, i8* %t2618, i8* %t2617
  %t2621 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2622 = icmp eq i32 %t2562, 19
  %t2623 = select i1 %t2622, i8* %t2621, i8* %t2620
  %t2624 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2625 = icmp eq i32 %t2562, 20
  %t2626 = select i1 %t2625, i8* %t2624, i8* %t2623
  %t2627 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2628 = icmp eq i32 %t2562, 21
  %t2629 = select i1 %t2628, i8* %t2627, i8* %t2626
  %t2630 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2631 = icmp eq i32 %t2562, 22
  %t2632 = select i1 %t2631, i8* %t2630, i8* %t2629
  %s2633 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.2633, i32 0, i32 0
  %t2634 = icmp eq i8* %t2632, %s2633
  br i1 %t2634, label %then44, label %merge45
then44:
  %t2635 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2636 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2635, 0
  %t2637 = extractvalue %Statement %statement, 0
  %t2638 = alloca %Statement
  store %Statement %statement, %Statement* %t2638
  %t2639 = getelementptr inbounds %Statement, %Statement* %t2638, i32 0, i32 1
  %t2640 = bitcast [24 x i8]* %t2639 to i8*
  %t2641 = getelementptr inbounds i8, i8* %t2640, i64 8
  %t2642 = bitcast i8* %t2641 to %Block*
  %t2643 = load %Block, %Block* %t2642
  %t2644 = icmp eq i32 %t2637, 4
  %t2645 = select i1 %t2644, %Block %t2643, %Block zeroinitializer
  %t2646 = getelementptr inbounds %Statement, %Statement* %t2638, i32 0, i32 1
  %t2647 = bitcast [24 x i8]* %t2646 to i8*
  %t2648 = getelementptr inbounds i8, i8* %t2647, i64 8
  %t2649 = bitcast i8* %t2648 to %Block*
  %t2650 = load %Block, %Block* %t2649
  %t2651 = icmp eq i32 %t2637, 5
  %t2652 = select i1 %t2651, %Block %t2650, %Block %t2645
  %t2653 = getelementptr inbounds %Statement, %Statement* %t2638, i32 0, i32 1
  %t2654 = bitcast [40 x i8]* %t2653 to i8*
  %t2655 = getelementptr inbounds i8, i8* %t2654, i64 16
  %t2656 = bitcast i8* %t2655 to %Block*
  %t2657 = load %Block, %Block* %t2656
  %t2658 = icmp eq i32 %t2637, 6
  %t2659 = select i1 %t2658, %Block %t2657, %Block %t2652
  %t2660 = getelementptr inbounds %Statement, %Statement* %t2638, i32 0, i32 1
  %t2661 = bitcast [24 x i8]* %t2660 to i8*
  %t2662 = getelementptr inbounds i8, i8* %t2661, i64 8
  %t2663 = bitcast i8* %t2662 to %Block*
  %t2664 = load %Block, %Block* %t2663
  %t2665 = icmp eq i32 %t2637, 7
  %t2666 = select i1 %t2665, %Block %t2664, %Block %t2659
  %t2667 = getelementptr inbounds %Statement, %Statement* %t2638, i32 0, i32 1
  %t2668 = bitcast [40 x i8]* %t2667 to i8*
  %t2669 = getelementptr inbounds i8, i8* %t2668, i64 24
  %t2670 = bitcast i8* %t2669 to %Block*
  %t2671 = load %Block, %Block* %t2670
  %t2672 = icmp eq i32 %t2637, 12
  %t2673 = select i1 %t2672, %Block %t2671, %Block %t2666
  %t2674 = getelementptr inbounds %Statement, %Statement* %t2638, i32 0, i32 1
  %t2675 = bitcast [24 x i8]* %t2674 to i8*
  %t2676 = getelementptr inbounds i8, i8* %t2675, i64 8
  %t2677 = bitcast i8* %t2676 to %Block*
  %t2678 = load %Block, %Block* %t2677
  %t2679 = icmp eq i32 %t2637, 13
  %t2680 = select i1 %t2679, %Block %t2678, %Block %t2673
  %t2681 = getelementptr inbounds %Statement, %Statement* %t2638, i32 0, i32 1
  %t2682 = bitcast [24 x i8]* %t2681 to i8*
  %t2683 = getelementptr inbounds i8, i8* %t2682, i64 8
  %t2684 = bitcast i8* %t2683 to %Block*
  %t2685 = load %Block, %Block* %t2684
  %t2686 = icmp eq i32 %t2637, 14
  %t2687 = select i1 %t2686, %Block %t2685, %Block %t2680
  %t2688 = getelementptr inbounds %Statement, %Statement* %t2638, i32 0, i32 1
  %t2689 = bitcast [16 x i8]* %t2688 to i8*
  %t2690 = bitcast i8* %t2689 to %Block*
  %t2691 = load %Block, %Block* %t2690
  %t2692 = icmp eq i32 %t2637, 15
  %t2693 = select i1 %t2692, %Block %t2691, %Block %t2687
  %t2694 = call { %Diagnostic*, i64 }* @check_block(%Block %t2693, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2695 = bitcast { %Diagnostic*, i64 }* %t2694 to { %Diagnostic**, i64 }*
  %t2696 = insertvalue %ScopeResult %t2636, { %Diagnostic**, i64 }* %t2695, 1
  ret %ScopeResult %t2696
merge45:
  %t2697 = extractvalue %Statement %statement, 0
  %t2698 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2699 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2700 = icmp eq i32 %t2697, 0
  %t2701 = select i1 %t2700, i8* %t2699, i8* %t2698
  %t2702 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2703 = icmp eq i32 %t2697, 1
  %t2704 = select i1 %t2703, i8* %t2702, i8* %t2701
  %t2705 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2706 = icmp eq i32 %t2697, 2
  %t2707 = select i1 %t2706, i8* %t2705, i8* %t2704
  %t2708 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2709 = icmp eq i32 %t2697, 3
  %t2710 = select i1 %t2709, i8* %t2708, i8* %t2707
  %t2711 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2712 = icmp eq i32 %t2697, 4
  %t2713 = select i1 %t2712, i8* %t2711, i8* %t2710
  %t2714 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2715 = icmp eq i32 %t2697, 5
  %t2716 = select i1 %t2715, i8* %t2714, i8* %t2713
  %t2717 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2718 = icmp eq i32 %t2697, 6
  %t2719 = select i1 %t2718, i8* %t2717, i8* %t2716
  %t2720 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2721 = icmp eq i32 %t2697, 7
  %t2722 = select i1 %t2721, i8* %t2720, i8* %t2719
  %t2723 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2724 = icmp eq i32 %t2697, 8
  %t2725 = select i1 %t2724, i8* %t2723, i8* %t2722
  %t2726 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2727 = icmp eq i32 %t2697, 9
  %t2728 = select i1 %t2727, i8* %t2726, i8* %t2725
  %t2729 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2730 = icmp eq i32 %t2697, 10
  %t2731 = select i1 %t2730, i8* %t2729, i8* %t2728
  %t2732 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2733 = icmp eq i32 %t2697, 11
  %t2734 = select i1 %t2733, i8* %t2732, i8* %t2731
  %t2735 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2736 = icmp eq i32 %t2697, 12
  %t2737 = select i1 %t2736, i8* %t2735, i8* %t2734
  %t2738 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2739 = icmp eq i32 %t2697, 13
  %t2740 = select i1 %t2739, i8* %t2738, i8* %t2737
  %t2741 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2742 = icmp eq i32 %t2697, 14
  %t2743 = select i1 %t2742, i8* %t2741, i8* %t2740
  %t2744 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2745 = icmp eq i32 %t2697, 15
  %t2746 = select i1 %t2745, i8* %t2744, i8* %t2743
  %t2747 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2748 = icmp eq i32 %t2697, 16
  %t2749 = select i1 %t2748, i8* %t2747, i8* %t2746
  %t2750 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2751 = icmp eq i32 %t2697, 17
  %t2752 = select i1 %t2751, i8* %t2750, i8* %t2749
  %t2753 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2754 = icmp eq i32 %t2697, 18
  %t2755 = select i1 %t2754, i8* %t2753, i8* %t2752
  %t2756 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2757 = icmp eq i32 %t2697, 19
  %t2758 = select i1 %t2757, i8* %t2756, i8* %t2755
  %t2759 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2760 = icmp eq i32 %t2697, 20
  %t2761 = select i1 %t2760, i8* %t2759, i8* %t2758
  %t2762 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2763 = icmp eq i32 %t2697, 21
  %t2764 = select i1 %t2763, i8* %t2762, i8* %t2761
  %t2765 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2766 = icmp eq i32 %t2697, 22
  %t2767 = select i1 %t2766, i8* %t2765, i8* %t2764
  %s2768 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.2768, i32 0, i32 0
  %t2769 = icmp eq i8* %t2767, %s2768
  br i1 %t2769, label %then46, label %merge47
then46:
  %t2770 = extractvalue %Statement %statement, 0
  %t2771 = alloca %Statement
  store %Statement %statement, %Statement* %t2771
  %t2772 = getelementptr inbounds %Statement, %Statement* %t2771, i32 0, i32 1
  %t2773 = bitcast [48 x i8]* %t2772 to i8*
  %t2774 = bitcast i8* %t2773 to i8**
  %t2775 = load i8*, i8** %t2774
  %t2776 = icmp eq i32 %t2770, 2
  %t2777 = select i1 %t2776, i8* %t2775, i8* null
  %t2778 = getelementptr inbounds %Statement, %Statement* %t2771, i32 0, i32 1
  %t2779 = bitcast [48 x i8]* %t2778 to i8*
  %t2780 = bitcast i8* %t2779 to i8**
  %t2781 = load i8*, i8** %t2780
  %t2782 = icmp eq i32 %t2770, 3
  %t2783 = select i1 %t2782, i8* %t2781, i8* %t2777
  %t2784 = getelementptr inbounds %Statement, %Statement* %t2771, i32 0, i32 1
  %t2785 = bitcast [40 x i8]* %t2784 to i8*
  %t2786 = bitcast i8* %t2785 to i8**
  %t2787 = load i8*, i8** %t2786
  %t2788 = icmp eq i32 %t2770, 6
  %t2789 = select i1 %t2788, i8* %t2787, i8* %t2783
  %t2790 = getelementptr inbounds %Statement, %Statement* %t2771, i32 0, i32 1
  %t2791 = bitcast [56 x i8]* %t2790 to i8*
  %t2792 = bitcast i8* %t2791 to i8**
  %t2793 = load i8*, i8** %t2792
  %t2794 = icmp eq i32 %t2770, 8
  %t2795 = select i1 %t2794, i8* %t2793, i8* %t2789
  %t2796 = getelementptr inbounds %Statement, %Statement* %t2771, i32 0, i32 1
  %t2797 = bitcast [40 x i8]* %t2796 to i8*
  %t2798 = bitcast i8* %t2797 to i8**
  %t2799 = load i8*, i8** %t2798
  %t2800 = icmp eq i32 %t2770, 9
  %t2801 = select i1 %t2800, i8* %t2799, i8* %t2795
  %t2802 = getelementptr inbounds %Statement, %Statement* %t2771, i32 0, i32 1
  %t2803 = bitcast [40 x i8]* %t2802 to i8*
  %t2804 = bitcast i8* %t2803 to i8**
  %t2805 = load i8*, i8** %t2804
  %t2806 = icmp eq i32 %t2770, 10
  %t2807 = select i1 %t2806, i8* %t2805, i8* %t2801
  %t2808 = getelementptr inbounds %Statement, %Statement* %t2771, i32 0, i32 1
  %t2809 = bitcast [40 x i8]* %t2808 to i8*
  %t2810 = bitcast i8* %t2809 to i8**
  %t2811 = load i8*, i8** %t2810
  %t2812 = icmp eq i32 %t2770, 11
  %t2813 = select i1 %t2812, i8* %t2811, i8* %t2807
  %s2814 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2814, i32 0, i32 0
  %t2815 = extractvalue %Statement %statement, 0
  %t2816 = alloca %Statement
  store %Statement %statement, %Statement* %t2816
  %t2817 = getelementptr inbounds %Statement, %Statement* %t2816, i32 0, i32 1
  %t2818 = bitcast [48 x i8]* %t2817 to i8*
  %t2819 = getelementptr inbounds i8, i8* %t2818, i64 8
  %t2820 = bitcast i8* %t2819 to %SourceSpan**
  %t2821 = load %SourceSpan*, %SourceSpan** %t2820
  %t2822 = icmp eq i32 %t2815, 3
  %t2823 = select i1 %t2822, %SourceSpan* %t2821, %SourceSpan* null
  %t2824 = getelementptr inbounds %Statement, %Statement* %t2816, i32 0, i32 1
  %t2825 = bitcast [40 x i8]* %t2824 to i8*
  %t2826 = getelementptr inbounds i8, i8* %t2825, i64 8
  %t2827 = bitcast i8* %t2826 to %SourceSpan**
  %t2828 = load %SourceSpan*, %SourceSpan** %t2827
  %t2829 = icmp eq i32 %t2815, 6
  %t2830 = select i1 %t2829, %SourceSpan* %t2828, %SourceSpan* %t2823
  %t2831 = getelementptr inbounds %Statement, %Statement* %t2816, i32 0, i32 1
  %t2832 = bitcast [56 x i8]* %t2831 to i8*
  %t2833 = getelementptr inbounds i8, i8* %t2832, i64 8
  %t2834 = bitcast i8* %t2833 to %SourceSpan**
  %t2835 = load %SourceSpan*, %SourceSpan** %t2834
  %t2836 = icmp eq i32 %t2815, 8
  %t2837 = select i1 %t2836, %SourceSpan* %t2835, %SourceSpan* %t2830
  %t2838 = getelementptr inbounds %Statement, %Statement* %t2816, i32 0, i32 1
  %t2839 = bitcast [40 x i8]* %t2838 to i8*
  %t2840 = getelementptr inbounds i8, i8* %t2839, i64 8
  %t2841 = bitcast i8* %t2840 to %SourceSpan**
  %t2842 = load %SourceSpan*, %SourceSpan** %t2841
  %t2843 = icmp eq i32 %t2815, 9
  %t2844 = select i1 %t2843, %SourceSpan* %t2842, %SourceSpan* %t2837
  %t2845 = getelementptr inbounds %Statement, %Statement* %t2816, i32 0, i32 1
  %t2846 = bitcast [40 x i8]* %t2845 to i8*
  %t2847 = getelementptr inbounds i8, i8* %t2846, i64 8
  %t2848 = bitcast i8* %t2847 to %SourceSpan**
  %t2849 = load %SourceSpan*, %SourceSpan** %t2848
  %t2850 = icmp eq i32 %t2815, 10
  %t2851 = select i1 %t2850, %SourceSpan* %t2849, %SourceSpan* %t2844
  %t2852 = getelementptr inbounds %Statement, %Statement* %t2816, i32 0, i32 1
  %t2853 = bitcast [40 x i8]* %t2852 to i8*
  %t2854 = getelementptr inbounds i8, i8* %t2853, i64 8
  %t2855 = bitcast i8* %t2854 to %SourceSpan**
  %t2856 = load %SourceSpan*, %SourceSpan** %t2855
  %t2857 = icmp eq i32 %t2815, 11
  %t2858 = select i1 %t2857, %SourceSpan* %t2856, %SourceSpan* %t2851
  %t2859 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t2813, i8* %s2814, %SourceSpan* %t2858)
  store %ScopeResult %t2859, %ScopeResult* %l25
  %t2860 = load %ScopeResult, %ScopeResult* %l25
  %t2861 = extractvalue %ScopeResult %t2860, 1
  %t2862 = extractvalue %Statement %statement, 0
  %t2863 = alloca %Statement
  store %Statement %statement, %Statement* %t2863
  %t2864 = getelementptr inbounds %Statement, %Statement* %t2863, i32 0, i32 1
  %t2865 = bitcast [56 x i8]* %t2864 to i8*
  %t2866 = getelementptr inbounds i8, i8* %t2865, i64 16
  %t2867 = bitcast i8* %t2866 to { %TypeParameter**, i64 }**
  %t2868 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2867
  %t2869 = icmp eq i32 %t2862, 8
  %t2870 = select i1 %t2869, { %TypeParameter**, i64 }* %t2868, { %TypeParameter**, i64 }* null
  %t2871 = getelementptr inbounds %Statement, %Statement* %t2863, i32 0, i32 1
  %t2872 = bitcast [40 x i8]* %t2871 to i8*
  %t2873 = getelementptr inbounds i8, i8* %t2872, i64 16
  %t2874 = bitcast i8* %t2873 to { %TypeParameter**, i64 }**
  %t2875 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2874
  %t2876 = icmp eq i32 %t2862, 9
  %t2877 = select i1 %t2876, { %TypeParameter**, i64 }* %t2875, { %TypeParameter**, i64 }* %t2870
  %t2878 = getelementptr inbounds %Statement, %Statement* %t2863, i32 0, i32 1
  %t2879 = bitcast [40 x i8]* %t2878 to i8*
  %t2880 = getelementptr inbounds i8, i8* %t2879, i64 16
  %t2881 = bitcast i8* %t2880 to { %TypeParameter**, i64 }**
  %t2882 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2881
  %t2883 = icmp eq i32 %t2862, 10
  %t2884 = select i1 %t2883, { %TypeParameter**, i64 }* %t2882, { %TypeParameter**, i64 }* %t2877
  %t2885 = getelementptr inbounds %Statement, %Statement* %t2863, i32 0, i32 1
  %t2886 = bitcast [40 x i8]* %t2885 to i8*
  %t2887 = getelementptr inbounds i8, i8* %t2886, i64 16
  %t2888 = bitcast i8* %t2887 to { %TypeParameter**, i64 }**
  %t2889 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2888
  %t2890 = icmp eq i32 %t2862, 11
  %t2891 = select i1 %t2890, { %TypeParameter**, i64 }* %t2889, { %TypeParameter**, i64 }* %t2884
  %t2892 = bitcast { %TypeParameter**, i64 }* %t2891 to { %TypeParameter*, i64 }*
  %t2893 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t2892)
  %t2894 = bitcast { %Diagnostic**, i64 }* %t2861 to { i8**, i64 }*
  %t2895 = bitcast { %Diagnostic*, i64 }* %t2893 to { i8**, i64 }*
  %t2896 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2894, { i8**, i64 }* %t2895)
  store { i8**, i64 }* %t2896, { i8**, i64 }** %l26
  %t2897 = load %ScopeResult, %ScopeResult* %l25
  %t2898 = extractvalue %ScopeResult %t2897, 0
  %t2899 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2898, 0
  %t2900 = load { i8**, i64 }*, { i8**, i64 }** %l26
  %t2901 = bitcast { i8**, i64 }* %t2900 to { %Diagnostic**, i64 }*
  %t2902 = insertvalue %ScopeResult %t2899, { %Diagnostic**, i64 }* %t2901, 1
  ret %ScopeResult %t2902
merge47:
  %t2903 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2904 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2903, 0
  %t2905 = alloca [0 x %Diagnostic*]
  %t2906 = getelementptr [0 x %Diagnostic*], [0 x %Diagnostic*]* %t2905, i32 0, i32 0
  %t2907 = alloca { %Diagnostic**, i64 }
  %t2908 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t2907, i32 0, i32 0
  store %Diagnostic** %t2906, %Diagnostic*** %t2908
  %t2909 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t2907, i32 0, i32 1
  store i64 0, i64* %t2909
  %t2910 = insertvalue %ScopeResult %t2904, { %Diagnostic**, i64 }* %t2907, 1
  ret %ScopeResult %t2910
}

define { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %signature, %Block %body, { %Statement*, i64 }* %interfaces) {
entry:
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
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %Parameter*
  %l4 = alloca %ScopeResult
  %t0 = alloca [0 x %SymbolEntry]
  %t1 = getelementptr [0 x %SymbolEntry], [0 x %SymbolEntry]* %t0, i32 0, i32 0
  %t2 = alloca { %SymbolEntry*, i64 }
  %t3 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t2, i32 0, i32 0
  store %SymbolEntry* %t1, %SymbolEntry** %t3
  %t4 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %SymbolEntry*, i64 }* %t2, { %SymbolEntry*, i64 }** %l0
  %t5 = alloca [0 x %Diagnostic]
  %t6 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t5, i32 0, i32 0
  %t7 = alloca { %Diagnostic*, i64 }
  %t8 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 0
  store %Diagnostic* %t6, %Diagnostic** %t8
  %t9 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %Diagnostic*, i64 }* %t7, { %Diagnostic*, i64 }** %l1
  %t10 = extractvalue %FunctionSignature %signature, 2
  %t11 = getelementptr { %Parameter**, i64 }, { %Parameter**, i64 }* %t10, i32 0, i32 1
  %t12 = load i64, i64* %t11
  %t13 = getelementptr { %Parameter**, i64 }, { %Parameter**, i64 }* %t10, i32 0, i32 0
  %t14 = load %Parameter**, %Parameter*** %t13
  store i64 0, i64* %l2
  store %Parameter* null, %Parameter** %l3
  br label %for0
for0:
  %t15 = load i64, i64* %l2
  %t16 = icmp slt i64 %t15, %t12
  br i1 %t16, label %forbody1, label %afterfor3
forbody1:
  %t17 = load i64, i64* %l2
  %t18 = getelementptr %Parameter*, %Parameter** %t14, i64 %t17
  %t19 = load %Parameter*, %Parameter** %t18
  store %Parameter* %t19, %Parameter** %l3
  %t20 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t21 = load %Parameter*, %Parameter** %l3
  %t22 = getelementptr %Parameter, %Parameter* %t21, i32 0, i32 0
  %t23 = load i8*, i8** %t22
  %s24 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.24, i32 0, i32 0
  %t25 = load %Parameter*, %Parameter** %l3
  %t26 = getelementptr %Parameter, %Parameter* %t25, i32 0, i32 4
  %t27 = load %SourceSpan*, %SourceSpan** %t26
  %t28 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %t20, i8* %t23, i8* %s24, %SourceSpan* %t27)
  store %ScopeResult %t28, %ScopeResult* %l4
  %t29 = load %ScopeResult, %ScopeResult* %l4
  %t30 = extractvalue %ScopeResult %t29, 0
  %t31 = bitcast { %SymbolEntry**, i64 }* %t30 to { %SymbolEntry*, i64 }*
  store { %SymbolEntry*, i64 }* %t31, { %SymbolEntry*, i64 }** %l0
  %t32 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t33 = load %ScopeResult, %ScopeResult* %l4
  %t34 = extractvalue %ScopeResult %t33, 1
  %t35 = bitcast { %Diagnostic*, i64 }* %t32 to { i8**, i64 }*
  %t36 = bitcast { %Diagnostic**, i64 }* %t34 to { i8**, i64 }*
  %t37 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t35, { i8**, i64 }* %t36)
  %t38 = bitcast { i8**, i64 }* %t37 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t38, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t39 = load i64, i64* %l2
  %t40 = add i64 %t39, 1
  store i64 %t40, i64* %l2
  br label %for0
afterfor3:
  %t41 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t42 = bitcast { %SymbolEntry*, i64 }* %t41 to { %SymbolEntry**, i64 }*
  %t43 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t42, 0
  %t44 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t45 = bitcast { %Diagnostic*, i64 }* %t44 to { %Diagnostic**, i64 }*
  %t46 = insertvalue %ScopeResult %t43, { %Diagnostic**, i64 }* %t45, 1
  ret %ScopeResult %t46
}

define { %Diagnostic*, i64 }* @check_block(%Block %block, { %SymbolEntry*, i64 }* %parent_bindings, { %Statement*, i64 }* %interfaces) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %Statement*
  %l4 = alloca %ScopeResult
  %t0 = call { %SymbolEntry*, i64 }* @clone_bindings({ %SymbolEntry*, i64 }* %parent_bindings)
  store { %SymbolEntry*, i64 }* %t0, { %SymbolEntry*, i64 }** %l0
  %t1 = alloca [0 x %Diagnostic]
  %t2 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t1, i32 0, i32 0
  %t3 = alloca { %Diagnostic*, i64 }
  %t4 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3, i32 0, i32 0
  store %Diagnostic* %t2, %Diagnostic** %t4
  %t5 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { %Diagnostic*, i64 }* %t3, { %Diagnostic*, i64 }** %l1
  %t6 = extractvalue %Block %block, 2
  %t7 = getelementptr { %Statement**, i64 }, { %Statement**, i64 }* %t6, i32 0, i32 1
  %t8 = load i64, i64* %t7
  %t9 = getelementptr { %Statement**, i64 }, { %Statement**, i64 }* %t6, i32 0, i32 0
  %t10 = load %Statement**, %Statement*** %t9
  store i64 0, i64* %l2
  store %Statement* null, %Statement** %l3
  br label %for0
for0:
  %t11 = load i64, i64* %l2
  %t12 = icmp slt i64 %t11, %t8
  br i1 %t12, label %forbody1, label %afterfor3
forbody1:
  %t13 = load i64, i64* %l2
  %t14 = getelementptr %Statement*, %Statement** %t10, i64 %t13
  %t15 = load %Statement*, %Statement** %t14
  store %Statement* %t15, %Statement** %l3
  %t16 = load %Statement*, %Statement** %l3
  %t17 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t18 = load %Statement, %Statement* %t16
  %t19 = call %ScopeResult @check_statement(%Statement %t18, { %SymbolEntry*, i64 }* %t17, { %Statement*, i64 }* %interfaces)
  store %ScopeResult %t19, %ScopeResult* %l4
  %t20 = load %ScopeResult, %ScopeResult* %l4
  %t21 = extractvalue %ScopeResult %t20, 0
  %t22 = bitcast { %SymbolEntry**, i64 }* %t21 to { %SymbolEntry*, i64 }*
  store { %SymbolEntry*, i64 }* %t22, { %SymbolEntry*, i64 }** %l0
  %t23 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t24 = load %ScopeResult, %ScopeResult* %l4
  %t25 = extractvalue %ScopeResult %t24, 1
  %t26 = bitcast { %Diagnostic*, i64 }* %t23 to { i8**, i64 }*
  %t27 = bitcast { %Diagnostic**, i64 }* %t25 to { i8**, i64 }*
  %t28 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t26, { i8**, i64 }* %t27)
  %t29 = bitcast { i8**, i64 }* %t28 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t29, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t30 = load i64, i64* %l2
  %t31 = add i64 %t30, 1
  store i64 %t31, i64* %l2
  br label %for0
afterfor3:
  %t32 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t32
}

define { %Diagnostic*, i64 }* @check_struct_implements_interfaces(%Statement %statement, { %Statement*, i64 }* %interfaces) {
entry:
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
  %t12 = alloca [0 x %Diagnostic]
  %t13 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t12, i32 0, i32 0
  %t14 = alloca { %Diagnostic*, i64 }
  %t15 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t14, i32 0, i32 0
  store %Diagnostic* %t13, %Diagnostic** %t15
  %t16 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  ret { %Diagnostic*, i64 }* %t14
merge1:
  %t17 = alloca [0 x i8*]
  %t18 = getelementptr [0 x i8*], [0 x i8*]* %t17, i32 0, i32 0
  %t19 = alloca { i8**, i64 }
  %t20 = getelementptr { i8**, i64 }, { i8**, i64 }* %t19, i32 0, i32 0
  store i8** %t18, i8*** %t20
  %t21 = getelementptr { i8**, i64 }, { i8**, i64 }* %t19, i32 0, i32 1
  store i64 0, i64* %t21
  store { i8**, i64 }* %t19, { i8**, i64 }** %l0
  %t22 = extractvalue %Statement %statement, 0
  %t23 = alloca %Statement
  store %Statement %statement, %Statement* %t23
  %t24 = getelementptr inbounds %Statement, %Statement* %t23, i32 0, i32 1
  %t25 = bitcast [56 x i8]* %t24 to i8*
  %t26 = getelementptr inbounds i8, i8* %t25, i64 40
  %t27 = bitcast i8* %t26 to { %MethodDeclaration**, i64 }**
  %t28 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t27
  %t29 = icmp eq i32 %t22, 8
  %t30 = select i1 %t29, { %MethodDeclaration**, i64 }* %t28, { %MethodDeclaration**, i64 }* null
  %t31 = getelementptr { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t30, i32 0, i32 1
  %t32 = load i64, i64* %t31
  %t33 = getelementptr { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t30, i32 0, i32 0
  %t34 = load %MethodDeclaration**, %MethodDeclaration*** %t33
  store i64 0, i64* %l1
  store %MethodDeclaration* null, %MethodDeclaration** %l2
  br label %for2
for2:
  %t35 = load i64, i64* %l1
  %t36 = icmp slt i64 %t35, %t32
  br i1 %t36, label %forbody3, label %afterfor5
forbody3:
  %t37 = load i64, i64* %l1
  %t38 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t34, i64 %t37
  %t39 = load %MethodDeclaration*, %MethodDeclaration** %t38
  store %MethodDeclaration* %t39, %MethodDeclaration** %l2
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load %MethodDeclaration*, %MethodDeclaration** %l2
  %t42 = getelementptr %MethodDeclaration, %MethodDeclaration* %t41, i32 0, i32 0
  %t43 = load %FunctionSignature, %FunctionSignature* %t42
  %t44 = extractvalue %FunctionSignature %t43, 0
  %t45 = alloca [1 x i8*]
  %t46 = getelementptr [1 x i8*], [1 x i8*]* %t45, i32 0, i32 0
  %t47 = getelementptr i8*, i8** %t46, i64 0
  store i8* %t44, i8** %t47
  %t48 = alloca { i8**, i64 }
  %t49 = getelementptr { i8**, i64 }, { i8**, i64 }* %t48, i32 0, i32 0
  store i8** %t46, i8*** %t49
  %t50 = getelementptr { i8**, i64 }, { i8**, i64 }* %t48, i32 0, i32 1
  store i64 1, i64* %t50
  %t51 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t40, { i8**, i64 }* %t48)
  store { i8**, i64 }* %t51, { i8**, i64 }** %l0
  br label %forinc4
forinc4:
  %t52 = load i64, i64* %l1
  %t53 = add i64 %t52, 1
  store i64 %t53, i64* %l1
  br label %for2
afterfor5:
  %t54 = alloca [0 x %Diagnostic]
  %t55 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t54, i32 0, i32 0
  %t56 = alloca { %Diagnostic*, i64 }
  %t57 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t56, i32 0, i32 0
  store %Diagnostic* %t55, %Diagnostic** %t57
  %t58 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t56, i32 0, i32 1
  store i64 0, i64* %t58
  store { %Diagnostic*, i64 }* %t56, { %Diagnostic*, i64 }** %l3
  %t59 = extractvalue %Statement %statement, 0
  %t60 = alloca %Statement
  store %Statement %statement, %Statement* %t60
  %t61 = getelementptr inbounds %Statement, %Statement* %t60, i32 0, i32 1
  %t62 = bitcast [56 x i8]* %t61 to i8*
  %t63 = getelementptr inbounds i8, i8* %t62, i64 24
  %t64 = bitcast i8* %t63 to { %TypeAnnotation**, i64 }**
  %t65 = load { %TypeAnnotation**, i64 }*, { %TypeAnnotation**, i64 }** %t64
  %t66 = icmp eq i32 %t59, 8
  %t67 = select i1 %t66, { %TypeAnnotation**, i64 }* %t65, { %TypeAnnotation**, i64 }* null
  %t68 = getelementptr { %TypeAnnotation**, i64 }, { %TypeAnnotation**, i64 }* %t67, i32 0, i32 1
  %t69 = load i64, i64* %t68
  %t70 = getelementptr { %TypeAnnotation**, i64 }, { %TypeAnnotation**, i64 }* %t67, i32 0, i32 0
  %t71 = load %TypeAnnotation**, %TypeAnnotation*** %t70
  store i64 0, i64* %l4
  store %TypeAnnotation* null, %TypeAnnotation** %l5
  br label %for6
for6:
  %t72 = load i64, i64* %l4
  %t73 = icmp slt i64 %t72, %t69
  br i1 %t73, label %forbody7, label %afterfor9
forbody7:
  %t74 = load i64, i64* %l4
  %t75 = getelementptr %TypeAnnotation*, %TypeAnnotation** %t71, i64 %t74
  %t76 = load %TypeAnnotation*, %TypeAnnotation** %t75
  store %TypeAnnotation* %t76, %TypeAnnotation** %l5
  %t77 = load %TypeAnnotation*, %TypeAnnotation** %l5
  %t78 = load %TypeAnnotation, %TypeAnnotation* %t77
  %t79 = call %Statement* @resolve_interface_annotation(%TypeAnnotation %t78, { %Statement*, i64 }* %interfaces)
  store %Statement* %t79, %Statement** %l6
  %t80 = load %Statement*, %Statement** %l6
  %t81 = icmp eq %Statement* %t80, null
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t83 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  %t84 = load %TypeAnnotation*, %TypeAnnotation** %l5
  %t85 = load %Statement*, %Statement** %l6
  br i1 %t81, label %then10, label %merge11
then10:
  br label %forinc8
merge11:
  %t86 = load %Statement*, %Statement** %l6
  %t87 = getelementptr inbounds %Statement, %Statement* %t86, i32 0, i32 0
  %t88 = load i32, i32* %t87
  %t89 = getelementptr inbounds %Statement, %Statement* %t86, i32 0, i32 1
  %t90 = bitcast [48 x i8]* %t89 to i8*
  %t91 = bitcast i8* %t90 to i8**
  %t92 = load i8*, i8** %t91
  %t93 = icmp eq i32 %t88, 2
  %t94 = select i1 %t93, i8* %t92, i8* null
  %t95 = getelementptr inbounds %Statement, %Statement* %t86, i32 0, i32 1
  %t96 = bitcast [48 x i8]* %t95 to i8*
  %t97 = bitcast i8* %t96 to i8**
  %t98 = load i8*, i8** %t97
  %t99 = icmp eq i32 %t88, 3
  %t100 = select i1 %t99, i8* %t98, i8* %t94
  %t101 = getelementptr inbounds %Statement, %Statement* %t86, i32 0, i32 1
  %t102 = bitcast [40 x i8]* %t101 to i8*
  %t103 = bitcast i8* %t102 to i8**
  %t104 = load i8*, i8** %t103
  %t105 = icmp eq i32 %t88, 6
  %t106 = select i1 %t105, i8* %t104, i8* %t100
  %t107 = getelementptr inbounds %Statement, %Statement* %t86, i32 0, i32 1
  %t108 = bitcast [56 x i8]* %t107 to i8*
  %t109 = bitcast i8* %t108 to i8**
  %t110 = load i8*, i8** %t109
  %t111 = icmp eq i32 %t88, 8
  %t112 = select i1 %t111, i8* %t110, i8* %t106
  %t113 = getelementptr inbounds %Statement, %Statement* %t86, i32 0, i32 1
  %t114 = bitcast [40 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to i8**
  %t116 = load i8*, i8** %t115
  %t117 = icmp eq i32 %t88, 9
  %t118 = select i1 %t117, i8* %t116, i8* %t112
  %t119 = getelementptr inbounds %Statement, %Statement* %t86, i32 0, i32 1
  %t120 = bitcast [40 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to i8**
  %t122 = load i8*, i8** %t121
  %t123 = icmp eq i32 %t88, 10
  %t124 = select i1 %t123, i8* %t122, i8* %t118
  %t125 = getelementptr inbounds %Statement, %Statement* %t86, i32 0, i32 1
  %t126 = bitcast [40 x i8]* %t125 to i8*
  %t127 = bitcast i8* %t126 to i8**
  %t128 = load i8*, i8** %t127
  %t129 = icmp eq i32 %t88, 11
  %t130 = select i1 %t129, i8* %t128, i8* %t124
  store i8* %t130, i8** %l7
  %t131 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  %t132 = extractvalue %Statement %statement, 0
  %t133 = alloca %Statement
  store %Statement %statement, %Statement* %t133
  %t134 = getelementptr inbounds %Statement, %Statement* %t133, i32 0, i32 1
  %t135 = bitcast [48 x i8]* %t134 to i8*
  %t136 = bitcast i8* %t135 to i8**
  %t137 = load i8*, i8** %t136
  %t138 = icmp eq i32 %t132, 2
  %t139 = select i1 %t138, i8* %t137, i8* null
  %t140 = getelementptr inbounds %Statement, %Statement* %t133, i32 0, i32 1
  %t141 = bitcast [48 x i8]* %t140 to i8*
  %t142 = bitcast i8* %t141 to i8**
  %t143 = load i8*, i8** %t142
  %t144 = icmp eq i32 %t132, 3
  %t145 = select i1 %t144, i8* %t143, i8* %t139
  %t146 = getelementptr inbounds %Statement, %Statement* %t133, i32 0, i32 1
  %t147 = bitcast [40 x i8]* %t146 to i8*
  %t148 = bitcast i8* %t147 to i8**
  %t149 = load i8*, i8** %t148
  %t150 = icmp eq i32 %t132, 6
  %t151 = select i1 %t150, i8* %t149, i8* %t145
  %t152 = getelementptr inbounds %Statement, %Statement* %t133, i32 0, i32 1
  %t153 = bitcast [56 x i8]* %t152 to i8*
  %t154 = bitcast i8* %t153 to i8**
  %t155 = load i8*, i8** %t154
  %t156 = icmp eq i32 %t132, 8
  %t157 = select i1 %t156, i8* %t155, i8* %t151
  %t158 = getelementptr inbounds %Statement, %Statement* %t133, i32 0, i32 1
  %t159 = bitcast [40 x i8]* %t158 to i8*
  %t160 = bitcast i8* %t159 to i8**
  %t161 = load i8*, i8** %t160
  %t162 = icmp eq i32 %t132, 9
  %t163 = select i1 %t162, i8* %t161, i8* %t157
  %t164 = getelementptr inbounds %Statement, %Statement* %t133, i32 0, i32 1
  %t165 = bitcast [40 x i8]* %t164 to i8*
  %t166 = bitcast i8* %t165 to i8**
  %t167 = load i8*, i8** %t166
  %t168 = icmp eq i32 %t132, 10
  %t169 = select i1 %t168, i8* %t167, i8* %t163
  %t170 = getelementptr inbounds %Statement, %Statement* %t133, i32 0, i32 1
  %t171 = bitcast [40 x i8]* %t170 to i8*
  %t172 = bitcast i8* %t171 to i8**
  %t173 = load i8*, i8** %t172
  %t174 = icmp eq i32 %t132, 11
  %t175 = select i1 %t174, i8* %t173, i8* %t169
  %t176 = load %Statement*, %Statement** %l6
  %t177 = load %TypeAnnotation*, %TypeAnnotation** %l5
  %t178 = load %Statement, %Statement* %t176
  %t179 = load %TypeAnnotation, %TypeAnnotation* %t177
  %t180 = call { %Diagnostic*, i64 }* @validate_interface_annotation(i8* %t175, %Statement %t178, %TypeAnnotation %t179)
  %t181 = bitcast { %Diagnostic*, i64 }* %t131 to { i8**, i64 }*
  %t182 = bitcast { %Diagnostic*, i64 }* %t180 to { i8**, i64 }*
  %t183 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t181, { i8**, i64 }* %t182)
  %t184 = bitcast { i8**, i64 }* %t183 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t184, { %Diagnostic*, i64 }** %l3
  %t185 = load %Statement*, %Statement** %l6
  %t186 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 0
  %t187 = load i32, i32* %t186
  %t188 = getelementptr inbounds %Statement, %Statement* %t185, i32 0, i32 1
  %t189 = bitcast [40 x i8]* %t188 to i8*
  %t190 = getelementptr inbounds i8, i8* %t189, i64 24
  %t191 = bitcast i8* %t190 to { %FunctionSignature**, i64 }**
  %t192 = load { %FunctionSignature**, i64 }*, { %FunctionSignature**, i64 }** %t191
  %t193 = icmp eq i32 %t187, 10
  %t194 = select i1 %t193, { %FunctionSignature**, i64 }* %t192, { %FunctionSignature**, i64 }* null
  %t195 = getelementptr { %FunctionSignature**, i64 }, { %FunctionSignature**, i64 }* %t194, i32 0, i32 1
  %t196 = load i64, i64* %t195
  %t197 = getelementptr { %FunctionSignature**, i64 }, { %FunctionSignature**, i64 }* %t194, i32 0, i32 0
  %t198 = load %FunctionSignature**, %FunctionSignature*** %t197
  store i64 0, i64* %l8
  store %FunctionSignature* null, %FunctionSignature** %l9
  br label %for12
for12:
  %t199 = load i64, i64* %l8
  %t200 = icmp slt i64 %t199, %t196
  br i1 %t200, label %forbody13, label %afterfor15
forbody13:
  %t201 = load i64, i64* %l8
  %t202 = getelementptr %FunctionSignature*, %FunctionSignature** %t198, i64 %t201
  %t203 = load %FunctionSignature*, %FunctionSignature** %t202
  store %FunctionSignature* %t203, %FunctionSignature** %l9
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t205 = load %FunctionSignature*, %FunctionSignature** %l9
  %t206 = getelementptr %FunctionSignature, %FunctionSignature* %t205, i32 0, i32 0
  %t207 = load i8*, i8** %t206
  %t208 = call i1 @contains_string({ i8**, i64 }* %t204, i8* %t207)
  %t209 = xor i1 %t208, 1
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t211 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  %t212 = load %TypeAnnotation*, %TypeAnnotation** %l5
  %t213 = load %Statement*, %Statement** %l6
  %t214 = load i8*, i8** %l7
  %t215 = load %FunctionSignature*, %FunctionSignature** %l9
  br i1 %t209, label %then16, label %merge17
then16:
  %t216 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  %t217 = extractvalue %Statement %statement, 0
  %t218 = alloca %Statement
  store %Statement %statement, %Statement* %t218
  %t219 = getelementptr inbounds %Statement, %Statement* %t218, i32 0, i32 1
  %t220 = bitcast [48 x i8]* %t219 to i8*
  %t221 = bitcast i8* %t220 to i8**
  %t222 = load i8*, i8** %t221
  %t223 = icmp eq i32 %t217, 2
  %t224 = select i1 %t223, i8* %t222, i8* null
  %t225 = getelementptr inbounds %Statement, %Statement* %t218, i32 0, i32 1
  %t226 = bitcast [48 x i8]* %t225 to i8*
  %t227 = bitcast i8* %t226 to i8**
  %t228 = load i8*, i8** %t227
  %t229 = icmp eq i32 %t217, 3
  %t230 = select i1 %t229, i8* %t228, i8* %t224
  %t231 = getelementptr inbounds %Statement, %Statement* %t218, i32 0, i32 1
  %t232 = bitcast [40 x i8]* %t231 to i8*
  %t233 = bitcast i8* %t232 to i8**
  %t234 = load i8*, i8** %t233
  %t235 = icmp eq i32 %t217, 6
  %t236 = select i1 %t235, i8* %t234, i8* %t230
  %t237 = getelementptr inbounds %Statement, %Statement* %t218, i32 0, i32 1
  %t238 = bitcast [56 x i8]* %t237 to i8*
  %t239 = bitcast i8* %t238 to i8**
  %t240 = load i8*, i8** %t239
  %t241 = icmp eq i32 %t217, 8
  %t242 = select i1 %t241, i8* %t240, i8* %t236
  %t243 = getelementptr inbounds %Statement, %Statement* %t218, i32 0, i32 1
  %t244 = bitcast [40 x i8]* %t243 to i8*
  %t245 = bitcast i8* %t244 to i8**
  %t246 = load i8*, i8** %t245
  %t247 = icmp eq i32 %t217, 9
  %t248 = select i1 %t247, i8* %t246, i8* %t242
  %t249 = getelementptr inbounds %Statement, %Statement* %t218, i32 0, i32 1
  %t250 = bitcast [40 x i8]* %t249 to i8*
  %t251 = bitcast i8* %t250 to i8**
  %t252 = load i8*, i8** %t251
  %t253 = icmp eq i32 %t217, 10
  %t254 = select i1 %t253, i8* %t252, i8* %t248
  %t255 = getelementptr inbounds %Statement, %Statement* %t218, i32 0, i32 1
  %t256 = bitcast [40 x i8]* %t255 to i8*
  %t257 = bitcast i8* %t256 to i8**
  %t258 = load i8*, i8** %t257
  %t259 = icmp eq i32 %t217, 11
  %t260 = select i1 %t259, i8* %t258, i8* %t254
  %t261 = load i8*, i8** %l7
  %t262 = load %FunctionSignature*, %FunctionSignature** %l9
  %t263 = getelementptr %FunctionSignature, %FunctionSignature* %t262, i32 0, i32 0
  %t264 = load i8*, i8** %t263
  %t265 = call %Diagnostic @make_missing_interface_member_diagnostic(i8* %t260, i8* %t261, i8* %t264)
  %t266 = call noalias i8* @malloc(i64 24)
  %t267 = bitcast i8* %t266 to %Diagnostic*
  store %Diagnostic %t265, %Diagnostic* %t267
  %t268 = alloca [1 x i8*]
  %t269 = getelementptr [1 x i8*], [1 x i8*]* %t268, i32 0, i32 0
  %t270 = getelementptr i8*, i8** %t269, i64 0
  store i8* %t266, i8** %t270
  %t271 = alloca { i8**, i64 }
  %t272 = getelementptr { i8**, i64 }, { i8**, i64 }* %t271, i32 0, i32 0
  store i8** %t269, i8*** %t272
  %t273 = getelementptr { i8**, i64 }, { i8**, i64 }* %t271, i32 0, i32 1
  store i64 1, i64* %t273
  %t274 = bitcast { %Diagnostic*, i64 }* %t216 to { i8**, i64 }*
  %t275 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t274, { i8**, i64 }* %t271)
  %t276 = bitcast { i8**, i64 }* %t275 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t276, { %Diagnostic*, i64 }** %l3
  br label %merge17
merge17:
  %t277 = phi { %Diagnostic*, i64 }* [ %t276, %then16 ], [ %t211, %forbody13 ]
  store { %Diagnostic*, i64 }* %t277, { %Diagnostic*, i64 }** %l3
  br label %forinc14
forinc14:
  %t278 = load i64, i64* %l8
  %t279 = add i64 %t278, 1
  store i64 %t279, i64* %l8
  br label %for12
afterfor15:
  br label %forinc8
forinc8:
  %t280 = load i64, i64* %l4
  %t281 = add i64 %t280, 1
  store i64 %t281, i64* %l4
  br label %for6
afterfor9:
  %t282 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  ret { %Diagnostic*, i64 }* %t282
}

define %Statement* @resolve_interface_annotation(%TypeAnnotation %annotation, { %Statement*, i64 }* %interfaces) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i64
  %l2 = alloca %Statement
  %l3 = alloca i8*
  %l4 = alloca i8
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
  %t64 = load i8, i8* %t63
  %t65 = add i8 %t64, 60
  store i8 %t65, i8* %l4
  %t66 = load i8*, i8** %l0
  %t67 = load i8, i8* %l4
  %t68 = alloca [2 x i8], align 1
  %t69 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 0
  store i8 %t67, i8* %t69
  %t70 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 1
  store i8 0, i8* %t70
  %t71 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 0
  %t72 = call i1 @starts_with(i8* %t66, i8* %t71)
  %t73 = load i8*, i8** %l0
  %t74 = load %Statement, %Statement* %l2
  %t75 = load i8*, i8** %l3
  %t76 = load i8, i8* %l4
  br i1 %t72, label %then6, label %merge7
then6:
  %t77 = load %Statement, %Statement* %l2
  %t78 = alloca %Statement
  store %Statement %t77, %Statement* %t78
  ret %Statement* %t78
merge7:
  br label %forinc2
forinc2:
  %t79 = load i64, i64* %l1
  %t80 = add i64 %t79, 1
  store i64 %t80, i64* %l1
  br label %for0
afterfor3:
  %t81 = bitcast i8* null to %Statement*
  ret %Statement* %t81
}

define { %Diagnostic*, i64 }* @check_struct_fields({ %FieldDeclaration*, i64 }* %fields) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %FieldDeclaration
  %l4 = alloca i8*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = alloca [0 x %Diagnostic]
  %t6 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t5, i32 0, i32 0
  %t7 = alloca { %Diagnostic*, i64 }
  %t8 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 0
  store %Diagnostic* %t6, %Diagnostic** %t8
  %t9 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %Diagnostic*, i64 }* %t7, { %Diagnostic*, i64 }** %l1
  %t10 = getelementptr { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %fields, i32 0, i32 1
  %t11 = load i64, i64* %t10
  %t12 = getelementptr { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %fields, i32 0, i32 0
  %t13 = load %FieldDeclaration*, %FieldDeclaration** %t12
  store i64 0, i64* %l2
  store %FieldDeclaration zeroinitializer, %FieldDeclaration* %l3
  br label %for0
for0:
  %t14 = load i64, i64* %l2
  %t15 = icmp slt i64 %t14, %t11
  br i1 %t15, label %forbody1, label %afterfor3
forbody1:
  %t16 = load i64, i64* %l2
  %t17 = getelementptr %FieldDeclaration, %FieldDeclaration* %t13, i64 %t16
  %t18 = load %FieldDeclaration, %FieldDeclaration* %t17
  store %FieldDeclaration %t18, %FieldDeclaration* %l3
  %t19 = load %FieldDeclaration, %FieldDeclaration* %l3
  %t20 = extractvalue %FieldDeclaration %t19, 0
  store i8* %t20, i8** %l4
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load i8*, i8** %l4
  %t23 = call i1 @contains_string({ i8**, i64 }* %t21, i8* %t22)
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t26 = load %FieldDeclaration, %FieldDeclaration* %l3
  %t27 = load i8*, i8** %l4
  br i1 %t23, label %then4, label %else5
then4:
  %t28 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t29 = load i8*, i8** %l4
  %s30 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.30, i32 0, i32 0
  %t31 = load i8*, i8** %l4
  %t32 = load %FieldDeclaration, %FieldDeclaration* %l3
  %t33 = extractvalue %FieldDeclaration %t32, 3
  %t34 = call %Token* @token_from_name(i8* %t31, %SourceSpan* %t33)
  %t35 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t29, i8* %s30, %Token* %t34)
  %t36 = call noalias i8* @malloc(i64 24)
  %t37 = bitcast i8* %t36 to %Diagnostic*
  store %Diagnostic %t35, %Diagnostic* %t37
  %t38 = alloca [1 x i8*]
  %t39 = getelementptr [1 x i8*], [1 x i8*]* %t38, i32 0, i32 0
  %t40 = getelementptr i8*, i8** %t39, i64 0
  store i8* %t36, i8** %t40
  %t41 = alloca { i8**, i64 }
  %t42 = getelementptr { i8**, i64 }, { i8**, i64 }* %t41, i32 0, i32 0
  store i8** %t39, i8*** %t42
  %t43 = getelementptr { i8**, i64 }, { i8**, i64 }* %t41, i32 0, i32 1
  store i64 1, i64* %t43
  %t44 = bitcast { %Diagnostic*, i64 }* %t28 to { i8**, i64 }*
  %t45 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t44, { i8**, i64 }* %t41)
  %t46 = bitcast { i8**, i64 }* %t45 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t46, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load i8*, i8** %l4
  %t49 = alloca [1 x i8*]
  %t50 = getelementptr [1 x i8*], [1 x i8*]* %t49, i32 0, i32 0
  %t51 = getelementptr i8*, i8** %t50, i64 0
  store i8* %t48, i8** %t51
  %t52 = alloca { i8**, i64 }
  %t53 = getelementptr { i8**, i64 }, { i8**, i64 }* %t52, i32 0, i32 0
  store i8** %t50, i8*** %t53
  %t54 = getelementptr { i8**, i64 }, { i8**, i64 }* %t52, i32 0, i32 1
  store i64 1, i64* %t54
  %t55 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t47, { i8**, i64 }* %t52)
  store { i8**, i64 }* %t55, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t56 = phi { %Diagnostic*, i64 }* [ %t46, %then4 ], [ %t25, %else5 ]
  %t57 = phi { i8**, i64 }* [ %t24, %then4 ], [ %t55, %else5 ]
  store { %Diagnostic*, i64 }* %t56, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t57, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t58 = load i64, i64* %l2
  %t59 = add i64 %t58, 1
  store i64 %t59, i64* %l2
  br label %for0
afterfor3:
  %t60 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t60
}

define { %Diagnostic*, i64 }* @validate_interface_annotation(i8* %struct_name, %Statement %interface_definition, %TypeAnnotation %annotation) {
entry:
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
  %t91 = alloca [1 x %Diagnostic]
  %t92 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* %t91, i32 0, i32 0
  %t93 = getelementptr %Diagnostic, %Diagnostic* %t92, i64 0
  store %Diagnostic %t90, %Diagnostic* %t93
  %t94 = alloca { %Diagnostic*, i64 }
  %t95 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t94, i32 0, i32 0
  store %Diagnostic* %t92, %Diagnostic** %t95
  %t96 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t94, i32 0, i32 1
  store i64 1, i64* %t96
  ret { %Diagnostic*, i64 }* %t94
merge3:
  %t97 = alloca [0 x %Diagnostic]
  %t98 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t97, i32 0, i32 0
  %t99 = alloca { %Diagnostic*, i64 }
  %t100 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t99, i32 0, i32 0
  store %Diagnostic* %t98, %Diagnostic** %t100
  %t101 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t99, i32 0, i32 1
  store i64 0, i64* %t101
  ret { %Diagnostic*, i64 }* %t99
merge1:
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t103 = load { i8**, i64 }, { i8**, i64 }* %t102
  %t104 = extractvalue { i8**, i64 } %t103, 1
  %t105 = icmp eq i64 %t104, 0
  %t106 = load i64, i64* %l0
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t105, label %then4, label %merge5
then4:
  %t108 = extractvalue %Statement %interface_definition, 0
  %t109 = alloca %Statement
  store %Statement %interface_definition, %Statement* %t109
  %t110 = getelementptr inbounds %Statement, %Statement* %t109, i32 0, i32 1
  %t111 = bitcast [48 x i8]* %t110 to i8*
  %t112 = bitcast i8* %t111 to i8**
  %t113 = load i8*, i8** %t112
  %t114 = icmp eq i32 %t108, 2
  %t115 = select i1 %t114, i8* %t113, i8* null
  %t116 = getelementptr inbounds %Statement, %Statement* %t109, i32 0, i32 1
  %t117 = bitcast [48 x i8]* %t116 to i8*
  %t118 = bitcast i8* %t117 to i8**
  %t119 = load i8*, i8** %t118
  %t120 = icmp eq i32 %t108, 3
  %t121 = select i1 %t120, i8* %t119, i8* %t115
  %t122 = getelementptr inbounds %Statement, %Statement* %t109, i32 0, i32 1
  %t123 = bitcast [40 x i8]* %t122 to i8*
  %t124 = bitcast i8* %t123 to i8**
  %t125 = load i8*, i8** %t124
  %t126 = icmp eq i32 %t108, 6
  %t127 = select i1 %t126, i8* %t125, i8* %t121
  %t128 = getelementptr inbounds %Statement, %Statement* %t109, i32 0, i32 1
  %t129 = bitcast [56 x i8]* %t128 to i8*
  %t130 = bitcast i8* %t129 to i8**
  %t131 = load i8*, i8** %t130
  %t132 = icmp eq i32 %t108, 8
  %t133 = select i1 %t132, i8* %t131, i8* %t127
  %t134 = getelementptr inbounds %Statement, %Statement* %t109, i32 0, i32 1
  %t135 = bitcast [40 x i8]* %t134 to i8*
  %t136 = bitcast i8* %t135 to i8**
  %t137 = load i8*, i8** %t136
  %t138 = icmp eq i32 %t108, 9
  %t139 = select i1 %t138, i8* %t137, i8* %t133
  %t140 = getelementptr inbounds %Statement, %Statement* %t109, i32 0, i32 1
  %t141 = bitcast [40 x i8]* %t140 to i8*
  %t142 = bitcast i8* %t141 to i8**
  %t143 = load i8*, i8** %t142
  %t144 = icmp eq i32 %t108, 10
  %t145 = select i1 %t144, i8* %t143, i8* %t139
  %t146 = getelementptr inbounds %Statement, %Statement* %t109, i32 0, i32 1
  %t147 = bitcast [40 x i8]* %t146 to i8*
  %t148 = bitcast i8* %t147 to i8**
  %t149 = load i8*, i8** %t148
  %t150 = icmp eq i32 %t108, 11
  %t151 = select i1 %t150, i8* %t149, i8* %t145
  %t152 = call i8* @format_interface_signature(%Statement %interface_definition)
  %t153 = call %Diagnostic @make_interface_missing_type_arguments_diagnostic(i8* %struct_name, i8* %t151, i8* %t152)
  %t154 = alloca [1 x %Diagnostic]
  %t155 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* %t154, i32 0, i32 0
  %t156 = getelementptr %Diagnostic, %Diagnostic* %t155, i64 0
  store %Diagnostic %t153, %Diagnostic* %t156
  %t157 = alloca { %Diagnostic*, i64 }
  %t158 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t157, i32 0, i32 0
  store %Diagnostic* %t155, %Diagnostic** %t158
  %t159 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t157, i32 0, i32 1
  store i64 1, i64* %t159
  ret { %Diagnostic*, i64 }* %t157
merge5:
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t161 = load { i8**, i64 }, { i8**, i64 }* %t160
  %t162 = extractvalue { i8**, i64 } %t161, 1
  %t163 = load i64, i64* %l0
  %t164 = icmp ne i64 %t162, %t163
  %t165 = load i64, i64* %l0
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t164, label %then6, label %merge7
then6:
  %t167 = extractvalue %TypeAnnotation %annotation, 0
  %t168 = call i8* @trim_text(i8* %t167)
  %t169 = call i8* @format_interface_signature(%Statement %interface_definition)
  %t170 = call %Diagnostic @make_interface_type_argument_mismatch_diagnostic(i8* %struct_name, i8* %t168, i8* %t169)
  %t171 = alloca [1 x %Diagnostic]
  %t172 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* %t171, i32 0, i32 0
  %t173 = getelementptr %Diagnostic, %Diagnostic* %t172, i64 0
  store %Diagnostic %t170, %Diagnostic* %t173
  %t174 = alloca { %Diagnostic*, i64 }
  %t175 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t174, i32 0, i32 0
  store %Diagnostic* %t172, %Diagnostic** %t175
  %t176 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t174, i32 0, i32 1
  store i64 1, i64* %t176
  ret { %Diagnostic*, i64 }* %t174
merge7:
  %t177 = alloca [0 x %Diagnostic]
  %t178 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t177, i32 0, i32 0
  %t179 = alloca { %Diagnostic*, i64 }
  %t180 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t179, i32 0, i32 0
  store %Diagnostic* %t178, %Diagnostic** %t180
  %t181 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t179, i32 0, i32 1
  store i64 0, i64* %t181
  ret { %Diagnostic*, i64 }* %t179
}

define i8* @format_interface_signature(%Statement %interface_definition) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i64
  %l2 = alloca %TypeParameter*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = extractvalue %Statement %interface_definition, 0
  %t6 = alloca %Statement
  store %Statement %interface_definition, %Statement* %t6
  %t7 = getelementptr inbounds %Statement, %Statement* %t6, i32 0, i32 1
  %t8 = bitcast [56 x i8]* %t7 to i8*
  %t9 = getelementptr inbounds i8, i8* %t8, i64 16
  %t10 = bitcast i8* %t9 to { %TypeParameter**, i64 }**
  %t11 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t10
  %t12 = icmp eq i32 %t5, 8
  %t13 = select i1 %t12, { %TypeParameter**, i64 }* %t11, { %TypeParameter**, i64 }* null
  %t14 = getelementptr inbounds %Statement, %Statement* %t6, i32 0, i32 1
  %t15 = bitcast [40 x i8]* %t14 to i8*
  %t16 = getelementptr inbounds i8, i8* %t15, i64 16
  %t17 = bitcast i8* %t16 to { %TypeParameter**, i64 }**
  %t18 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t17
  %t19 = icmp eq i32 %t5, 9
  %t20 = select i1 %t19, { %TypeParameter**, i64 }* %t18, { %TypeParameter**, i64 }* %t13
  %t21 = getelementptr inbounds %Statement, %Statement* %t6, i32 0, i32 1
  %t22 = bitcast [40 x i8]* %t21 to i8*
  %t23 = getelementptr inbounds i8, i8* %t22, i64 16
  %t24 = bitcast i8* %t23 to { %TypeParameter**, i64 }**
  %t25 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t24
  %t26 = icmp eq i32 %t5, 10
  %t27 = select i1 %t26, { %TypeParameter**, i64 }* %t25, { %TypeParameter**, i64 }* %t20
  %t28 = getelementptr inbounds %Statement, %Statement* %t6, i32 0, i32 1
  %t29 = bitcast [40 x i8]* %t28 to i8*
  %t30 = getelementptr inbounds i8, i8* %t29, i64 16
  %t31 = bitcast i8* %t30 to { %TypeParameter**, i64 }**
  %t32 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t31
  %t33 = icmp eq i32 %t5, 11
  %t34 = select i1 %t33, { %TypeParameter**, i64 }* %t32, { %TypeParameter**, i64 }* %t27
  %t35 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t34, i32 0, i32 1
  %t36 = load i64, i64* %t35
  %t37 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t34, i32 0, i32 0
  %t38 = load %TypeParameter**, %TypeParameter*** %t37
  store i64 0, i64* %l1
  store %TypeParameter* null, %TypeParameter** %l2
  br label %for0
for0:
  %t39 = load i64, i64* %l1
  %t40 = icmp slt i64 %t39, %t36
  br i1 %t40, label %forbody1, label %afterfor3
forbody1:
  %t41 = load i64, i64* %l1
  %t42 = getelementptr %TypeParameter*, %TypeParameter** %t38, i64 %t41
  %t43 = load %TypeParameter*, %TypeParameter** %t42
  store %TypeParameter* %t43, %TypeParameter** %l2
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load %TypeParameter*, %TypeParameter** %l2
  %t46 = getelementptr %TypeParameter, %TypeParameter* %t45, i32 0, i32 0
  %t47 = load i8*, i8** %t46
  %t48 = alloca [1 x i8*]
  %t49 = getelementptr [1 x i8*], [1 x i8*]* %t48, i32 0, i32 0
  %t50 = getelementptr i8*, i8** %t49, i64 0
  store i8* %t47, i8** %t50
  %t51 = alloca { i8**, i64 }
  %t52 = getelementptr { i8**, i64 }, { i8**, i64 }* %t51, i32 0, i32 0
  store i8** %t49, i8*** %t52
  %t53 = getelementptr { i8**, i64 }, { i8**, i64 }* %t51, i32 0, i32 1
  store i64 1, i64* %t53
  %t54 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t44, { i8**, i64 }* %t51)
  store { i8**, i64 }* %t54, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t55 = load i64, i64* %l1
  %t56 = add i64 %t55, 1
  store i64 %t56, i64* %l1
  br label %for0
afterfor3:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = load { i8**, i64 }, { i8**, i64 }* %t57
  %t59 = extractvalue { i8**, i64 } %t58, 1
  %t60 = icmp eq i64 %t59, 0
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br i1 %t60, label %then4, label %merge5
then4:
  %t62 = extractvalue %Statement %interface_definition, 0
  %t63 = alloca %Statement
  store %Statement %interface_definition, %Statement* %t63
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
  ret i8* %t105
merge5:
  %t106 = extractvalue %Statement %interface_definition, 0
  %t107 = alloca %Statement
  store %Statement %interface_definition, %Statement* %t107
  %t108 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t109 = bitcast [48 x i8]* %t108 to i8*
  %t110 = bitcast i8* %t109 to i8**
  %t111 = load i8*, i8** %t110
  %t112 = icmp eq i32 %t106, 2
  %t113 = select i1 %t112, i8* %t111, i8* null
  %t114 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t115 = bitcast [48 x i8]* %t114 to i8*
  %t116 = bitcast i8* %t115 to i8**
  %t117 = load i8*, i8** %t116
  %t118 = icmp eq i32 %t106, 3
  %t119 = select i1 %t118, i8* %t117, i8* %t113
  %t120 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t121 = bitcast [40 x i8]* %t120 to i8*
  %t122 = bitcast i8* %t121 to i8**
  %t123 = load i8*, i8** %t122
  %t124 = icmp eq i32 %t106, 6
  %t125 = select i1 %t124, i8* %t123, i8* %t119
  %t126 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t127 = bitcast [56 x i8]* %t126 to i8*
  %t128 = bitcast i8* %t127 to i8**
  %t129 = load i8*, i8** %t128
  %t130 = icmp eq i32 %t106, 8
  %t131 = select i1 %t130, i8* %t129, i8* %t125
  %t132 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t133 = bitcast [40 x i8]* %t132 to i8*
  %t134 = bitcast i8* %t133 to i8**
  %t135 = load i8*, i8** %t134
  %t136 = icmp eq i32 %t106, 9
  %t137 = select i1 %t136, i8* %t135, i8* %t131
  %t138 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t139 = bitcast [40 x i8]* %t138 to i8*
  %t140 = bitcast i8* %t139 to i8**
  %t141 = load i8*, i8** %t140
  %t142 = icmp eq i32 %t106, 10
  %t143 = select i1 %t142, i8* %t141, i8* %t137
  %t144 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t145 = bitcast [40 x i8]* %t144 to i8*
  %t146 = bitcast i8* %t145 to i8**
  %t147 = load i8*, i8** %t146
  %t148 = icmp eq i32 %t106, 11
  %t149 = select i1 %t148, i8* %t147, i8* %t143
  %t150 = load i8, i8* %t149
  %t151 = add i8 %t150, 60
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s153 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.153, i32 0, i32 0
  %t154 = call i8* @join_with_separator({ i8**, i64 }* %t152, i8* %s153)
  %t155 = load i8, i8* %t154
  %t156 = add i8 %t151, %t155
  %t157 = add i8 %t156, 62
  %t158 = alloca [2 x i8], align 1
  %t159 = getelementptr [2 x i8], [2 x i8]* %t158, i32 0, i32 0
  store i8 %t157, i8* %t159
  %t160 = getelementptr [2 x i8], [2 x i8]* %t158, i32 0, i32 1
  store i8 0, i8* %t160
  %t161 = getelementptr [2 x i8], [2 x i8]* %t158, i32 0, i32 0
  ret i8* %t161
}

define i8* @join_with_separator({ i8**, i64 }* %items, i8* %separator) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %t0 = load { i8**, i64 }, { i8**, i64 }* %items
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge1:
  %t4 = load { i8**, i64 }, { i8**, i64 }* %items
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
  %t21 = add i8* %t20, %separator
  %t22 = load double, double* %l1
  %t23 = fptosi double %t22 to i64
  %t24 = load { i8**, i64 }, { i8**, i64 }* %items
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

define { i8**, i64 }* @parse_type_arguments(i8* %annotation_text) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @extract_generic_argument_block(i8* %annotation_text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = icmp eq i8* %t1, null
  %t3 = load i8*, i8** %l0
  br i1 %t2, label %then0, label %merge1
then0:
  %t4 = alloca [0 x i8*]
  %t5 = getelementptr [0 x i8*], [0 x i8*]* %t4, i32 0, i32 0
  %t6 = alloca { i8**, i64 }
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 0
  store i8** %t5, i8*** %t7
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  ret { i8**, i64 }* %t6
merge1:
  %t9 = load i8*, i8** %l0
  %t10 = call { i8**, i64 }* @split_generic_argument_list(i8* %t9)
  ret { i8**, i64 }* %t10
}

define i8* @extract_generic_argument_block(i8* %annotation_text) {
entry:
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
  %t83 = phi double [ %t7, %entry ], [ %t80, %loop.latch2 ]
  %t84 = phi double [ %t6, %entry ], [ %t81, %loop.latch2 ]
  %t85 = phi double [ %t5, %entry ], [ %t82, %loop.latch2 ]
  store double %t83, double* %l3
  store double %t84, double* %l2
  store double %t85, double* %l1
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
  br label %merge10
merge10:
  %t40 = phi double [ %t39, %then9 ], [ %t35, %then6 ]
  store double %t40, double* %l3
  %t41 = load double, double* %l2
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l2
  br label %merge8
else7:
  %t44 = load i8, i8* %l4
  %t45 = icmp eq i8 %t44, 62
  %t46 = load i8*, i8** %l0
  %t47 = load double, double* %l1
  %t48 = load double, double* %l2
  %t49 = load double, double* %l3
  %t50 = load i8, i8* %l4
  br i1 %t45, label %then11, label %merge12
then11:
  %t51 = load double, double* %l2
  %t52 = sitofp i64 0 to double
  %t53 = fcmp oeq double %t51, %t52
  %t54 = load i8*, i8** %l0
  %t55 = load double, double* %l1
  %t56 = load double, double* %l2
  %t57 = load double, double* %l3
  %t58 = load i8, i8* %l4
  br i1 %t53, label %then13, label %merge14
then13:
  ret i8* null
merge14:
  %t59 = load double, double* %l2
  %t60 = sitofp i64 1 to double
  %t61 = fsub double %t59, %t60
  store double %t61, double* %l2
  %t62 = load double, double* %l2
  %t63 = sitofp i64 0 to double
  %t64 = fcmp oeq double %t62, %t63
  %t65 = load i8*, i8** %l0
  %t66 = load double, double* %l1
  %t67 = load double, double* %l2
  %t68 = load double, double* %l3
  %t69 = load i8, i8* %l4
  br i1 %t64, label %then15, label %merge16
then15:
  %t70 = load i8*, i8** %l0
  %t71 = load double, double* %l3
  %t72 = load double, double* %l1
  %t73 = call i8* @slice_text(i8* %t70, double %t71, double %t72)
  ret i8* %t73
merge16:
  br label %merge12
merge12:
  %t74 = phi double [ %t61, %then11 ], [ %t48, %else7 ]
  store double %t74, double* %l2
  br label %merge8
merge8:
  %t75 = phi double [ %t39, %then6 ], [ %t27, %else7 ]
  %t76 = phi double [ %t43, %then6 ], [ %t61, %else7 ]
  store double %t75, double* %l3
  store double %t76, double* %l2
  %t77 = load double, double* %l1
  %t78 = sitofp i64 1 to double
  %t79 = fadd double %t77, %t78
  store double %t79, double* %l1
  br label %loop.latch2
loop.latch2:
  %t80 = load double, double* %l3
  %t81 = load double, double* %l2
  %t82 = load double, double* %l1
  br label %loop.header0
afterloop3:
  ret i8* null
}

define { i8**, i64 }* @split_generic_argument_list(i8* %block) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8
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
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.5, i32 0, i32 0
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
  %t143 = phi double [ %t10, %entry ], [ %t139, %loop.latch2 ]
  %t144 = phi i8* [ %t9, %entry ], [ %t140, %loop.latch2 ]
  %t145 = phi { i8**, i64 }* [ %t8, %entry ], [ %t141, %loop.latch2 ]
  %t146 = phi double [ %t11, %entry ], [ %t142, %loop.latch2 ]
  store double %t143, double* %l2
  store i8* %t144, i8** %l1
  store { i8**, i64 }* %t145, { i8**, i64 }** %l0
  store double %t146, double* %l3
  br label %loop.body1
loop.body1:
  %t12 = load double, double* %l3
  %t13 = call i64 @sailfin_runtime_string_length(i8* %block)
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
  %t22 = getelementptr i8, i8* %block, i64 %t21
  %t23 = load i8, i8* %t22
  store i8 %t23, i8* %l4
  %t24 = load i8, i8* %l4
  %t25 = icmp eq i8 %t24, 60
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load i8*, i8** %l1
  %t28 = load double, double* %l2
  %t29 = load double, double* %l3
  %t30 = load i8, i8* %l4
  br i1 %t25, label %then6, label %else7
then6:
  %t31 = load double, double* %l2
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l2
  %t34 = load i8*, i8** %l1
  %t35 = load i8, i8* %l4
  %t36 = load i8, i8* %t34
  %t37 = add i8 %t36, %t35
  %t38 = alloca [2 x i8], align 1
  %t39 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 0
  store i8 %t37, i8* %t39
  %t40 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 1
  store i8 0, i8* %t40
  %t41 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 0
  store i8* %t41, i8** %l1
  br label %merge8
else7:
  %t42 = load i8, i8* %l4
  %t43 = icmp eq i8 %t42, 62
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load i8*, i8** %l1
  %t46 = load double, double* %l2
  %t47 = load double, double* %l3
  %t48 = load i8, i8* %l4
  br i1 %t43, label %then9, label %else10
then9:
  %t49 = load double, double* %l2
  %t50 = sitofp i64 0 to double
  %t51 = fcmp ogt double %t49, %t50
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load i8*, i8** %l1
  %t54 = load double, double* %l2
  %t55 = load double, double* %l3
  %t56 = load i8, i8* %l4
  br i1 %t51, label %then12, label %merge13
then12:
  %t57 = load double, double* %l2
  %t58 = sitofp i64 1 to double
  %t59 = fsub double %t57, %t58
  store double %t59, double* %l2
  br label %merge13
merge13:
  %t60 = phi double [ %t59, %then12 ], [ %t54, %then9 ]
  store double %t60, double* %l2
  %t61 = load i8*, i8** %l1
  %t62 = load i8, i8* %l4
  %t63 = load i8, i8* %t61
  %t64 = add i8 %t63, %t62
  %t65 = alloca [2 x i8], align 1
  %t66 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 0
  store i8 %t64, i8* %t66
  %t67 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 1
  store i8 0, i8* %t67
  %t68 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 0
  store i8* %t68, i8** %l1
  br label %merge11
else10:
  %t69 = load i8, i8* %l4
  %t70 = icmp eq i8 %t69, 44
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = load i8*, i8** %l1
  %t73 = load double, double* %l2
  %t74 = load double, double* %l3
  %t75 = load i8, i8* %l4
  br i1 %t70, label %then14, label %else15
then14:
  %t76 = load double, double* %l2
  %t77 = sitofp i64 0 to double
  %t78 = fcmp oeq double %t76, %t77
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t80 = load i8*, i8** %l1
  %t81 = load double, double* %l2
  %t82 = load double, double* %l3
  %t83 = load i8, i8* %l4
  br i1 %t78, label %then17, label %merge18
then17:
  %t84 = load i8*, i8** %l1
  %t85 = call i8* @trim_text(i8* %t84)
  store i8* %t85, i8** %l5
  %t86 = load i8*, i8** %l5
  %t87 = call i64 @sailfin_runtime_string_length(i8* %t86)
  %t88 = icmp sgt i64 %t87, 0
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t90 = load i8*, i8** %l1
  %t91 = load double, double* %l2
  %t92 = load double, double* %l3
  %t93 = load i8, i8* %l4
  %t94 = load i8*, i8** %l5
  br i1 %t88, label %then19, label %merge20
then19:
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t96 = load i8*, i8** %l5
  %t97 = alloca [1 x i8*]
  %t98 = getelementptr [1 x i8*], [1 x i8*]* %t97, i32 0, i32 0
  %t99 = getelementptr i8*, i8** %t98, i64 0
  store i8* %t96, i8** %t99
  %t100 = alloca { i8**, i64 }
  %t101 = getelementptr { i8**, i64 }, { i8**, i64 }* %t100, i32 0, i32 0
  store i8** %t98, i8*** %t101
  %t102 = getelementptr { i8**, i64 }, { i8**, i64 }* %t100, i32 0, i32 1
  store i64 1, i64* %t102
  %t103 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t95, { i8**, i64 }* %t100)
  store { i8**, i64 }* %t103, { i8**, i64 }** %l0
  br label %merge20
merge20:
  %t104 = phi { i8**, i64 }* [ %t103, %then19 ], [ %t89, %then17 ]
  store { i8**, i64 }* %t104, { i8**, i64 }** %l0
  %s105 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.105, i32 0, i32 0
  store i8* %s105, i8** %l1
  %t106 = load double, double* %l3
  %t107 = sitofp i64 1 to double
  %t108 = fadd double %t106, %t107
  store double %t108, double* %l3
  br label %loop.latch2
merge18:
  %t109 = load i8*, i8** %l1
  %t110 = load i8, i8* %l4
  %t111 = load i8, i8* %t109
  %t112 = add i8 %t111, %t110
  %t113 = alloca [2 x i8], align 1
  %t114 = getelementptr [2 x i8], [2 x i8]* %t113, i32 0, i32 0
  store i8 %t112, i8* %t114
  %t115 = getelementptr [2 x i8], [2 x i8]* %t113, i32 0, i32 1
  store i8 0, i8* %t115
  %t116 = getelementptr [2 x i8], [2 x i8]* %t113, i32 0, i32 0
  store i8* %t116, i8** %l1
  br label %merge16
else15:
  %t117 = load i8*, i8** %l1
  %t118 = load i8, i8* %l4
  %t119 = load i8, i8* %t117
  %t120 = add i8 %t119, %t118
  %t121 = alloca [2 x i8], align 1
  %t122 = getelementptr [2 x i8], [2 x i8]* %t121, i32 0, i32 0
  store i8 %t120, i8* %t122
  %t123 = getelementptr [2 x i8], [2 x i8]* %t121, i32 0, i32 1
  store i8 0, i8* %t123
  %t124 = getelementptr [2 x i8], [2 x i8]* %t121, i32 0, i32 0
  store i8* %t124, i8** %l1
  br label %merge16
merge16:
  %t125 = phi { i8**, i64 }* [ %t103, %then14 ], [ %t71, %else15 ]
  %t126 = phi i8* [ %s105, %then14 ], [ %t124, %else15 ]
  %t127 = phi double [ %t108, %then14 ], [ %t74, %else15 ]
  store { i8**, i64 }* %t125, { i8**, i64 }** %l0
  store i8* %t126, i8** %l1
  store double %t127, double* %l3
  br label %merge11
merge11:
  %t128 = phi double [ %t59, %then9 ], [ %t46, %else10 ]
  %t129 = phi i8* [ %t68, %then9 ], [ %s105, %else10 ]
  %t130 = phi { i8**, i64 }* [ %t44, %then9 ], [ %t103, %else10 ]
  %t131 = phi double [ %t47, %then9 ], [ %t108, %else10 ]
  store double %t128, double* %l2
  store i8* %t129, i8** %l1
  store { i8**, i64 }* %t130, { i8**, i64 }** %l0
  store double %t131, double* %l3
  br label %merge8
merge8:
  %t132 = phi double [ %t33, %then6 ], [ %t59, %else7 ]
  %t133 = phi i8* [ %t41, %then6 ], [ %t68, %else7 ]
  %t134 = phi { i8**, i64 }* [ %t26, %then6 ], [ %t103, %else7 ]
  %t135 = phi double [ %t29, %then6 ], [ %t108, %else7 ]
  store double %t132, double* %l2
  store i8* %t133, i8** %l1
  store { i8**, i64 }* %t134, { i8**, i64 }** %l0
  store double %t135, double* %l3
  %t136 = load double, double* %l3
  %t137 = sitofp i64 1 to double
  %t138 = fadd double %t136, %t137
  store double %t138, double* %l3
  br label %loop.latch2
loop.latch2:
  %t139 = load double, double* %l2
  %t140 = load i8*, i8** %l1
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t142 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t147 = load i8*, i8** %l1
  %t148 = call i8* @trim_text(i8* %t147)
  store i8* %t148, i8** %l6
  %t149 = load i8*, i8** %l6
  %t150 = call i64 @sailfin_runtime_string_length(i8* %t149)
  %t151 = icmp sgt i64 %t150, 0
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t153 = load i8*, i8** %l1
  %t154 = load double, double* %l2
  %t155 = load double, double* %l3
  %t156 = load i8*, i8** %l6
  br i1 %t151, label %then21, label %merge22
then21:
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t158 = load i8*, i8** %l6
  %t159 = alloca [1 x i8*]
  %t160 = getelementptr [1 x i8*], [1 x i8*]* %t159, i32 0, i32 0
  %t161 = getelementptr i8*, i8** %t160, i64 0
  store i8* %t158, i8** %t161
  %t162 = alloca { i8**, i64 }
  %t163 = getelementptr { i8**, i64 }, { i8**, i64 }* %t162, i32 0, i32 0
  store i8** %t160, i8*** %t163
  %t164 = getelementptr { i8**, i64 }, { i8**, i64 }* %t162, i32 0, i32 1
  store i64 1, i64* %t164
  %t165 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t157, { i8**, i64 }* %t162)
  store { i8**, i64 }* %t165, { i8**, i64 }** %l0
  br label %merge22
merge22:
  %t166 = phi { i8**, i64 }* [ %t165, %then21 ], [ %t152, %entry ]
  store { i8**, i64 }* %t166, { i8**, i64 }** %l0
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t167
}

define i8* @trim_text(i8* %value) {
entry:
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
  %t25 = phi double [ %t3, %entry ], [ %t24, %loop.latch2 ]
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
  %t27 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t50 = phi double [ %t27, %entry ], [ %t49, %loop.latch10 ]
  store double %t50, double* %l1
  br label %loop.body9
loop.body9:
  %t28 = load double, double* %l1
  %t29 = load double, double* %l0
  %t30 = fcmp ole double %t28, %t29
  %t31 = load double, double* %l0
  %t32 = load double, double* %l1
  br i1 %t30, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fsub double %t33, %t34
  %t36 = fptosi double %t35 to i64
  %t37 = getelementptr i8, i8* %value, i64 %t36
  %t38 = load i8, i8* %t37
  %t39 = alloca [2 x i8], align 1
  %t40 = getelementptr [2 x i8], [2 x i8]* %t39, i32 0, i32 0
  store i8 %t38, i8* %t40
  %t41 = getelementptr [2 x i8], [2 x i8]* %t39, i32 0, i32 1
  store i8 0, i8* %t41
  %t42 = getelementptr [2 x i8], [2 x i8]* %t39, i32 0, i32 0
  %t43 = call i1 @is_whitespace(i8* %t42)
  %t44 = load double, double* %l0
  %t45 = load double, double* %l1
  br i1 %t43, label %then14, label %merge15
then14:
  %t46 = load double, double* %l1
  %t47 = sitofp i64 1 to double
  %t48 = fsub double %t46, %t47
  store double %t48, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t49 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t51 = load double, double* %l0
  %t52 = load double, double* %l1
  %t53 = call i8* @slice_text(i8* %value, double %t51, double %t52)
  ret i8* %t53
}

define i8* @slice_text(i8* %value, double %start, double %end) {
entry:
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
  br label %merge1
merge1:
  %t6 = phi double [ %t5, %then0 ], [ %t3, %entry ]
  store double %t6, double* %l0
  %t7 = load double, double* %l1
  %t8 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp ogt double %t7, %t9
  %t11 = load double, double* %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then2, label %merge3
then2:
  %t13 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t14 = sitofp i64 %t13 to double
  store double %t14, double* %l1
  br label %merge3
merge3:
  %t15 = phi double [ %t14, %then2 ], [ %t12, %entry ]
  store double %t15, double* %l1
  %t16 = load double, double* %l1
  %t17 = load double, double* %l0
  %t18 = fcmp ole double %t16, %t17
  %t19 = load double, double* %l0
  %t20 = load double, double* %l1
  br i1 %t18, label %then4, label %merge5
then4:
  %s21 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.21, i32 0, i32 0
  ret i8* %s21
merge5:
  %s22 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.22, i32 0, i32 0
  store i8* %s22, i8** %l2
  %t23 = load double, double* %l0
  store double %t23, double* %l3
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  %t26 = load i8*, i8** %l2
  %t27 = load double, double* %l3
  br label %loop.header6
loop.header6:
  %t51 = phi i8* [ %t26, %entry ], [ %t49, %loop.latch8 ]
  %t52 = phi double [ %t27, %entry ], [ %t50, %loop.latch8 ]
  store i8* %t51, i8** %l2
  store double %t52, double* %l3
  br label %loop.body7
loop.body7:
  %t28 = load double, double* %l3
  %t29 = load double, double* %l1
  %t30 = fcmp oge double %t28, %t29
  %t31 = load double, double* %l0
  %t32 = load double, double* %l1
  %t33 = load i8*, i8** %l2
  %t34 = load double, double* %l3
  br i1 %t30, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t35 = load i8*, i8** %l2
  %t36 = load double, double* %l3
  %t37 = fptosi double %t36 to i64
  %t38 = getelementptr i8, i8* %value, i64 %t37
  %t39 = load i8, i8* %t38
  %t40 = load i8, i8* %t35
  %t41 = add i8 %t40, %t39
  %t42 = alloca [2 x i8], align 1
  %t43 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  store i8 %t41, i8* %t43
  %t44 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 1
  store i8 0, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  store i8* %t45, i8** %l2
  %t46 = load double, double* %l3
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  store double %t48, double* %l3
  br label %loop.latch8
loop.latch8:
  %t49 = load i8*, i8** %l2
  %t50 = load double, double* %l3
  br label %loop.header6
afterloop9:
  %t53 = load i8*, i8** %l2
  ret i8* %t53
}

define i1 @is_whitespace(i8* %ch) {
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
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %MethodDeclaration
  %l4 = alloca i8*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = alloca [0 x %Diagnostic]
  %t6 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t5, i32 0, i32 0
  %t7 = alloca { %Diagnostic*, i64 }
  %t8 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 0
  store %Diagnostic* %t6, %Diagnostic** %t8
  %t9 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %Diagnostic*, i64 }* %t7, { %Diagnostic*, i64 }** %l1
  %t10 = getelementptr { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %methods, i32 0, i32 1
  %t11 = load i64, i64* %t10
  %t12 = getelementptr { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %methods, i32 0, i32 0
  %t13 = load %MethodDeclaration*, %MethodDeclaration** %t12
  store i64 0, i64* %l2
  store %MethodDeclaration zeroinitializer, %MethodDeclaration* %l3
  br label %for0
for0:
  %t14 = load i64, i64* %l2
  %t15 = icmp slt i64 %t14, %t11
  br i1 %t15, label %forbody1, label %afterfor3
forbody1:
  %t16 = load i64, i64* %l2
  %t17 = getelementptr %MethodDeclaration, %MethodDeclaration* %t13, i64 %t16
  %t18 = load %MethodDeclaration, %MethodDeclaration* %t17
  store %MethodDeclaration %t18, %MethodDeclaration* %l3
  %t19 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t20 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t21 = extractvalue %MethodDeclaration %t20, 0
  %t22 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t21)
  %t23 = bitcast { %Diagnostic*, i64 }* %t19 to { i8**, i64 }*
  %t24 = bitcast { %Diagnostic*, i64 }* %t22 to { i8**, i64 }*
  %t25 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t23, { i8**, i64 }* %t24)
  %t26 = bitcast { i8**, i64 }* %t25 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t26, { %Diagnostic*, i64 }** %l1
  %t27 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t28 = extractvalue %MethodDeclaration %t27, 0
  %t29 = extractvalue %FunctionSignature %t28, 0
  store i8* %t29, i8** %l4
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load i8*, i8** %l4
  %t32 = call i1 @contains_string({ i8**, i64 }* %t30, i8* %t31)
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t35 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t36 = load i8*, i8** %l4
  br i1 %t32, label %then4, label %else5
then4:
  %t37 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t38 = load i8*, i8** %l4
  %s39 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.39, i32 0, i32 0
  %t40 = load i8*, i8** %l4
  %t41 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t42 = extractvalue %MethodDeclaration %t41, 0
  %t43 = extractvalue %FunctionSignature %t42, 6
  %t44 = call %Token* @token_from_name(i8* %t40, %SourceSpan* %t43)
  %t45 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t38, i8* %s39, %Token* %t44)
  %t46 = call noalias i8* @malloc(i64 24)
  %t47 = bitcast i8* %t46 to %Diagnostic*
  store %Diagnostic %t45, %Diagnostic* %t47
  %t48 = alloca [1 x i8*]
  %t49 = getelementptr [1 x i8*], [1 x i8*]* %t48, i32 0, i32 0
  %t50 = getelementptr i8*, i8** %t49, i64 0
  store i8* %t46, i8** %t50
  %t51 = alloca { i8**, i64 }
  %t52 = getelementptr { i8**, i64 }, { i8**, i64 }* %t51, i32 0, i32 0
  store i8** %t49, i8*** %t52
  %t53 = getelementptr { i8**, i64 }, { i8**, i64 }* %t51, i32 0, i32 1
  store i64 1, i64* %t53
  %t54 = bitcast { %Diagnostic*, i64 }* %t37 to { i8**, i64 }*
  %t55 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t54, { i8**, i64 }* %t51)
  %t56 = bitcast { i8**, i64 }* %t55 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t56, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = load i8*, i8** %l4
  %t59 = alloca [1 x i8*]
  %t60 = getelementptr [1 x i8*], [1 x i8*]* %t59, i32 0, i32 0
  %t61 = getelementptr i8*, i8** %t60, i64 0
  store i8* %t58, i8** %t61
  %t62 = alloca { i8**, i64 }
  %t63 = getelementptr { i8**, i64 }, { i8**, i64 }* %t62, i32 0, i32 0
  store i8** %t60, i8*** %t63
  %t64 = getelementptr { i8**, i64 }, { i8**, i64 }* %t62, i32 0, i32 1
  store i64 1, i64* %t64
  %t65 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t57, { i8**, i64 }* %t62)
  store { i8**, i64 }* %t65, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t66 = phi { %Diagnostic*, i64 }* [ %t56, %then4 ], [ %t34, %else5 ]
  %t67 = phi { i8**, i64 }* [ %t33, %then4 ], [ %t65, %else5 ]
  store { %Diagnostic*, i64 }* %t66, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t67, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t68 = load i64, i64* %l2
  %t69 = add i64 %t68, 1
  store i64 %t69, i64* %l2
  br label %for0
afterfor3:
  %t70 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t70
}

define { %Diagnostic*, i64 }* @check_enum_variants({ %EnumVariant*, i64 }* %variants) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %EnumVariant
  %l4 = alloca i8*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = alloca [0 x %Diagnostic]
  %t6 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t5, i32 0, i32 0
  %t7 = alloca { %Diagnostic*, i64 }
  %t8 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 0
  store %Diagnostic* %t6, %Diagnostic** %t8
  %t9 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %Diagnostic*, i64 }* %t7, { %Diagnostic*, i64 }** %l1
  %t10 = getelementptr { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %variants, i32 0, i32 1
  %t11 = load i64, i64* %t10
  %t12 = getelementptr { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %variants, i32 0, i32 0
  %t13 = load %EnumVariant*, %EnumVariant** %t12
  store i64 0, i64* %l2
  store %EnumVariant zeroinitializer, %EnumVariant* %l3
  br label %for0
for0:
  %t14 = load i64, i64* %l2
  %t15 = icmp slt i64 %t14, %t11
  br i1 %t15, label %forbody1, label %afterfor3
forbody1:
  %t16 = load i64, i64* %l2
  %t17 = getelementptr %EnumVariant, %EnumVariant* %t13, i64 %t16
  %t18 = load %EnumVariant, %EnumVariant* %t17
  store %EnumVariant %t18, %EnumVariant* %l3
  %t19 = load %EnumVariant, %EnumVariant* %l3
  %t20 = extractvalue %EnumVariant %t19, 0
  store i8* %t20, i8** %l4
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load i8*, i8** %l4
  %t23 = call i1 @contains_string({ i8**, i64 }* %t21, i8* %t22)
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t26 = load %EnumVariant, %EnumVariant* %l3
  %t27 = load i8*, i8** %l4
  br i1 %t23, label %then4, label %else5
then4:
  %t28 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t29 = load i8*, i8** %l4
  %s30 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.30, i32 0, i32 0
  %t31 = load i8*, i8** %l4
  %t32 = load %EnumVariant, %EnumVariant* %l3
  %t33 = extractvalue %EnumVariant %t32, 2
  %t34 = call %Token* @token_from_name(i8* %t31, %SourceSpan* %t33)
  %t35 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t29, i8* %s30, %Token* %t34)
  %t36 = call noalias i8* @malloc(i64 24)
  %t37 = bitcast i8* %t36 to %Diagnostic*
  store %Diagnostic %t35, %Diagnostic* %t37
  %t38 = alloca [1 x i8*]
  %t39 = getelementptr [1 x i8*], [1 x i8*]* %t38, i32 0, i32 0
  %t40 = getelementptr i8*, i8** %t39, i64 0
  store i8* %t36, i8** %t40
  %t41 = alloca { i8**, i64 }
  %t42 = getelementptr { i8**, i64 }, { i8**, i64 }* %t41, i32 0, i32 0
  store i8** %t39, i8*** %t42
  %t43 = getelementptr { i8**, i64 }, { i8**, i64 }* %t41, i32 0, i32 1
  store i64 1, i64* %t43
  %t44 = bitcast { %Diagnostic*, i64 }* %t28 to { i8**, i64 }*
  %t45 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t44, { i8**, i64 }* %t41)
  %t46 = bitcast { i8**, i64 }* %t45 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t46, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load i8*, i8** %l4
  %t49 = alloca [1 x i8*]
  %t50 = getelementptr [1 x i8*], [1 x i8*]* %t49, i32 0, i32 0
  %t51 = getelementptr i8*, i8** %t50, i64 0
  store i8* %t48, i8** %t51
  %t52 = alloca { i8**, i64 }
  %t53 = getelementptr { i8**, i64 }, { i8**, i64 }* %t52, i32 0, i32 0
  store i8** %t50, i8*** %t53
  %t54 = getelementptr { i8**, i64 }, { i8**, i64 }* %t52, i32 0, i32 1
  store i64 1, i64* %t54
  %t55 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t47, { i8**, i64 }* %t52)
  store { i8**, i64 }* %t55, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t56 = phi { %Diagnostic*, i64 }* [ %t46, %then4 ], [ %t25, %else5 ]
  %t57 = phi { i8**, i64 }* [ %t24, %then4 ], [ %t55, %else5 ]
  store { %Diagnostic*, i64 }* %t56, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t57, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t58 = load i64, i64* %l2
  %t59 = add i64 %t58, 1
  store i64 %t59, i64* %l2
  br label %for0
afterfor3:
  %t60 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t60
}

define { %Diagnostic*, i64 }* @check_interface_members({ %FunctionSignature*, i64 }* %members) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %FunctionSignature
  %l4 = alloca i8*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = alloca [0 x %Diagnostic]
  %t6 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t5, i32 0, i32 0
  %t7 = alloca { %Diagnostic*, i64 }
  %t8 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 0
  store %Diagnostic* %t6, %Diagnostic** %t8
  %t9 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %Diagnostic*, i64 }* %t7, { %Diagnostic*, i64 }** %l1
  %t10 = getelementptr { %FunctionSignature*, i64 }, { %FunctionSignature*, i64 }* %members, i32 0, i32 1
  %t11 = load i64, i64* %t10
  %t12 = getelementptr { %FunctionSignature*, i64 }, { %FunctionSignature*, i64 }* %members, i32 0, i32 0
  %t13 = load %FunctionSignature*, %FunctionSignature** %t12
  store i64 0, i64* %l2
  store %FunctionSignature zeroinitializer, %FunctionSignature* %l3
  br label %for0
for0:
  %t14 = load i64, i64* %l2
  %t15 = icmp slt i64 %t14, %t11
  br i1 %t15, label %forbody1, label %afterfor3
forbody1:
  %t16 = load i64, i64* %l2
  %t17 = getelementptr %FunctionSignature, %FunctionSignature* %t13, i64 %t16
  %t18 = load %FunctionSignature, %FunctionSignature* %t17
  store %FunctionSignature %t18, %FunctionSignature* %l3
  %t19 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t20 = load %FunctionSignature, %FunctionSignature* %l3
  %t21 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t20)
  %t22 = bitcast { %Diagnostic*, i64 }* %t19 to { i8**, i64 }*
  %t23 = bitcast { %Diagnostic*, i64 }* %t21 to { i8**, i64 }*
  %t24 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t22, { i8**, i64 }* %t23)
  %t25 = bitcast { i8**, i64 }* %t24 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t25, { %Diagnostic*, i64 }** %l1
  %t26 = load %FunctionSignature, %FunctionSignature* %l3
  %t27 = extractvalue %FunctionSignature %t26, 0
  store i8* %t27, i8** %l4
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load i8*, i8** %l4
  %t30 = call i1 @contains_string({ i8**, i64 }* %t28, i8* %t29)
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t33 = load %FunctionSignature, %FunctionSignature* %l3
  %t34 = load i8*, i8** %l4
  br i1 %t30, label %then4, label %else5
then4:
  %t35 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t36 = load i8*, i8** %l4
  %s37 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.37, i32 0, i32 0
  %t38 = load i8*, i8** %l4
  %t39 = load %FunctionSignature, %FunctionSignature* %l3
  %t40 = extractvalue %FunctionSignature %t39, 6
  %t41 = call %Token* @token_from_name(i8* %t38, %SourceSpan* %t40)
  %t42 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t36, i8* %s37, %Token* %t41)
  %t43 = call noalias i8* @malloc(i64 24)
  %t44 = bitcast i8* %t43 to %Diagnostic*
  store %Diagnostic %t42, %Diagnostic* %t44
  %t45 = alloca [1 x i8*]
  %t46 = getelementptr [1 x i8*], [1 x i8*]* %t45, i32 0, i32 0
  %t47 = getelementptr i8*, i8** %t46, i64 0
  store i8* %t43, i8** %t47
  %t48 = alloca { i8**, i64 }
  %t49 = getelementptr { i8**, i64 }, { i8**, i64 }* %t48, i32 0, i32 0
  store i8** %t46, i8*** %t49
  %t50 = getelementptr { i8**, i64 }, { i8**, i64 }* %t48, i32 0, i32 1
  store i64 1, i64* %t50
  %t51 = bitcast { %Diagnostic*, i64 }* %t35 to { i8**, i64 }*
  %t52 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t51, { i8**, i64 }* %t48)
  %t53 = bitcast { i8**, i64 }* %t52 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t53, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load i8*, i8** %l4
  %t56 = alloca [1 x i8*]
  %t57 = getelementptr [1 x i8*], [1 x i8*]* %t56, i32 0, i32 0
  %t58 = getelementptr i8*, i8** %t57, i64 0
  store i8* %t55, i8** %t58
  %t59 = alloca { i8**, i64 }
  %t60 = getelementptr { i8**, i64 }, { i8**, i64 }* %t59, i32 0, i32 0
  store i8** %t57, i8*** %t60
  %t61 = getelementptr { i8**, i64 }, { i8**, i64 }* %t59, i32 0, i32 1
  store i64 1, i64* %t61
  %t62 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t54, { i8**, i64 }* %t59)
  store { i8**, i64 }* %t62, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t63 = phi { %Diagnostic*, i64 }* [ %t53, %then4 ], [ %t32, %else5 ]
  %t64 = phi { i8**, i64 }* [ %t31, %then4 ], [ %t62, %else5 ]
  store { %Diagnostic*, i64 }* %t63, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t64, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t65 = load i64, i64* %l2
  %t66 = add i64 %t65, 1
  store i64 %t66, i64* %l2
  br label %for0
afterfor3:
  %t67 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t67
}

define { %Diagnostic*, i64 }* @check_model_properties({ %ModelProperty*, i64 }* %properties) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %ModelProperty
  %l4 = alloca i8*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = alloca [0 x %Diagnostic]
  %t6 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t5, i32 0, i32 0
  %t7 = alloca { %Diagnostic*, i64 }
  %t8 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 0
  store %Diagnostic* %t6, %Diagnostic** %t8
  %t9 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %Diagnostic*, i64 }* %t7, { %Diagnostic*, i64 }** %l1
  %t10 = getelementptr { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %properties, i32 0, i32 1
  %t11 = load i64, i64* %t10
  %t12 = getelementptr { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %properties, i32 0, i32 0
  %t13 = load %ModelProperty*, %ModelProperty** %t12
  store i64 0, i64* %l2
  store %ModelProperty zeroinitializer, %ModelProperty* %l3
  br label %for0
for0:
  %t14 = load i64, i64* %l2
  %t15 = icmp slt i64 %t14, %t11
  br i1 %t15, label %forbody1, label %afterfor3
forbody1:
  %t16 = load i64, i64* %l2
  %t17 = getelementptr %ModelProperty, %ModelProperty* %t13, i64 %t16
  %t18 = load %ModelProperty, %ModelProperty* %t17
  store %ModelProperty %t18, %ModelProperty* %l3
  %t19 = load %ModelProperty, %ModelProperty* %l3
  %t20 = extractvalue %ModelProperty %t19, 0
  store i8* %t20, i8** %l4
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load i8*, i8** %l4
  %t23 = call i1 @contains_string({ i8**, i64 }* %t21, i8* %t22)
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t26 = load %ModelProperty, %ModelProperty* %l3
  %t27 = load i8*, i8** %l4
  br i1 %t23, label %then4, label %else5
then4:
  %t28 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t29 = load i8*, i8** %l4
  %s30 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.30, i32 0, i32 0
  %t31 = load i8*, i8** %l4
  %t32 = load %ModelProperty, %ModelProperty* %l3
  %t33 = extractvalue %ModelProperty %t32, 2
  %t34 = call %Token* @token_from_name(i8* %t31, %SourceSpan* %t33)
  %t35 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t29, i8* %s30, %Token* %t34)
  %t36 = call noalias i8* @malloc(i64 24)
  %t37 = bitcast i8* %t36 to %Diagnostic*
  store %Diagnostic %t35, %Diagnostic* %t37
  %t38 = alloca [1 x i8*]
  %t39 = getelementptr [1 x i8*], [1 x i8*]* %t38, i32 0, i32 0
  %t40 = getelementptr i8*, i8** %t39, i64 0
  store i8* %t36, i8** %t40
  %t41 = alloca { i8**, i64 }
  %t42 = getelementptr { i8**, i64 }, { i8**, i64 }* %t41, i32 0, i32 0
  store i8** %t39, i8*** %t42
  %t43 = getelementptr { i8**, i64 }, { i8**, i64 }* %t41, i32 0, i32 1
  store i64 1, i64* %t43
  %t44 = bitcast { %Diagnostic*, i64 }* %t28 to { i8**, i64 }*
  %t45 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t44, { i8**, i64 }* %t41)
  %t46 = bitcast { i8**, i64 }* %t45 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t46, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load i8*, i8** %l4
  %t49 = alloca [1 x i8*]
  %t50 = getelementptr [1 x i8*], [1 x i8*]* %t49, i32 0, i32 0
  %t51 = getelementptr i8*, i8** %t50, i64 0
  store i8* %t48, i8** %t51
  %t52 = alloca { i8**, i64 }
  %t53 = getelementptr { i8**, i64 }, { i8**, i64 }* %t52, i32 0, i32 0
  store i8** %t50, i8*** %t53
  %t54 = getelementptr { i8**, i64 }, { i8**, i64 }* %t52, i32 0, i32 1
  store i64 1, i64* %t54
  %t55 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t47, { i8**, i64 }* %t52)
  store { i8**, i64 }* %t55, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t56 = phi { %Diagnostic*, i64 }* [ %t46, %then4 ], [ %t25, %else5 ]
  %t57 = phi { i8**, i64 }* [ %t24, %then4 ], [ %t55, %else5 ]
  store { %Diagnostic*, i64 }* %t56, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t57, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t58 = load i64, i64* %l2
  %t59 = add i64 %t58, 1
  store i64 %t59, i64* %l2
  br label %for0
afterfor3:
  %t60 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t60
}

define { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %signature) {
entry:
  %t0 = extractvalue %FunctionSignature %signature, 5
  %t1 = bitcast { %TypeParameter**, i64 }* %t0 to { %TypeParameter*, i64 }*
  %t2 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t1)
  ret { %Diagnostic*, i64 }* %t2
}

define { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %type_parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %TypeParameter
  %l4 = alloca i8*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = alloca [0 x %Diagnostic]
  %t6 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t5, i32 0, i32 0
  %t7 = alloca { %Diagnostic*, i64 }
  %t8 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 0
  store %Diagnostic* %t6, %Diagnostic** %t8
  %t9 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %Diagnostic*, i64 }* %t7, { %Diagnostic*, i64 }** %l1
  %t10 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %type_parameters, i32 0, i32 1
  %t11 = load i64, i64* %t10
  %t12 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %type_parameters, i32 0, i32 0
  %t13 = load %TypeParameter*, %TypeParameter** %t12
  store i64 0, i64* %l2
  store %TypeParameter zeroinitializer, %TypeParameter* %l3
  br label %for0
for0:
  %t14 = load i64, i64* %l2
  %t15 = icmp slt i64 %t14, %t11
  br i1 %t15, label %forbody1, label %afterfor3
forbody1:
  %t16 = load i64, i64* %l2
  %t17 = getelementptr %TypeParameter, %TypeParameter* %t13, i64 %t16
  %t18 = load %TypeParameter, %TypeParameter* %t17
  store %TypeParameter %t18, %TypeParameter* %l3
  %t19 = load %TypeParameter, %TypeParameter* %l3
  %t20 = extractvalue %TypeParameter %t19, 0
  store i8* %t20, i8** %l4
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load i8*, i8** %l4
  %t23 = call i1 @contains_string({ i8**, i64 }* %t21, i8* %t22)
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t26 = load %TypeParameter, %TypeParameter* %l3
  %t27 = load i8*, i8** %l4
  br i1 %t23, label %then4, label %else5
then4:
  %t28 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t29 = load i8*, i8** %l4
  %s30 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.30, i32 0, i32 0
  %t31 = load i8*, i8** %l4
  %t32 = load %TypeParameter, %TypeParameter* %l3
  %t33 = extractvalue %TypeParameter %t32, 2
  %t34 = call %Token* @token_from_name(i8* %t31, %SourceSpan* %t33)
  %t35 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t29, i8* %s30, %Token* %t34)
  %t36 = call noalias i8* @malloc(i64 24)
  %t37 = bitcast i8* %t36 to %Diagnostic*
  store %Diagnostic %t35, %Diagnostic* %t37
  %t38 = alloca [1 x i8*]
  %t39 = getelementptr [1 x i8*], [1 x i8*]* %t38, i32 0, i32 0
  %t40 = getelementptr i8*, i8** %t39, i64 0
  store i8* %t36, i8** %t40
  %t41 = alloca { i8**, i64 }
  %t42 = getelementptr { i8**, i64 }, { i8**, i64 }* %t41, i32 0, i32 0
  store i8** %t39, i8*** %t42
  %t43 = getelementptr { i8**, i64 }, { i8**, i64 }* %t41, i32 0, i32 1
  store i64 1, i64* %t43
  %t44 = bitcast { %Diagnostic*, i64 }* %t28 to { i8**, i64 }*
  %t45 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t44, { i8**, i64 }* %t41)
  %t46 = bitcast { i8**, i64 }* %t45 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t46, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load i8*, i8** %l4
  %t49 = alloca [1 x i8*]
  %t50 = getelementptr [1 x i8*], [1 x i8*]* %t49, i32 0, i32 0
  %t51 = getelementptr i8*, i8** %t50, i64 0
  store i8* %t48, i8** %t51
  %t52 = alloca { i8**, i64 }
  %t53 = getelementptr { i8**, i64 }, { i8**, i64 }* %t52, i32 0, i32 0
  store i8** %t50, i8*** %t53
  %t54 = getelementptr { i8**, i64 }, { i8**, i64 }* %t52, i32 0, i32 1
  store i64 1, i64* %t54
  %t55 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t47, { i8**, i64 }* %t52)
  store { i8**, i64 }* %t55, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t56 = phi { %Diagnostic*, i64 }* [ %t46, %then4 ], [ %t25, %else5 ]
  %t57 = phi { i8**, i64 }* [ %t24, %then4 ], [ %t55, %else5 ]
  store { %Diagnostic*, i64 }* %t56, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t57, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t58 = load i64, i64* %l2
  %t59 = add i64 %t58, 1
  store i64 %t59, i64* %l2
  br label %for0
afterfor3:
  %t60 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t60
}

define { %Diagnostic*, i64 }* @build_effect_diagnostics(%Program %program) {
entry:
  %l0 = alloca { %EffectViolation*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca double
  %l3 = alloca %EffectViolation
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca %EffectRequirement*
  %t0 = call { %EffectViolation*, i64 }* @validate_effects(%Program %program)
  store { %EffectViolation*, i64 }* %t0, { %EffectViolation*, i64 }** %l0
  %t1 = alloca [0 x %Diagnostic]
  %t2 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t1, i32 0, i32 0
  %t3 = alloca { %Diagnostic*, i64 }
  %t4 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3, i32 0, i32 0
  store %Diagnostic* %t2, %Diagnostic** %t4
  %t5 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { %Diagnostic*, i64 }* %t3, { %Diagnostic*, i64 }** %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t8 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t96 = phi { %Diagnostic*, i64 }* [ %t8, %entry ], [ %t94, %loop.latch2 ]
  %t97 = phi double [ %t9, %entry ], [ %t95, %loop.latch2 ]
  store { %Diagnostic*, i64 }* %t96, { %Diagnostic*, i64 }** %l1
  store double %t97, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t12 = load { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t11
  %t13 = extractvalue { %EffectViolation*, i64 } %t12, 1
  %t14 = sitofp i64 %t13 to double
  %t15 = fcmp oge double %t10, %t14
  %t16 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t17 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t18 = load double, double* %l2
  br i1 %t15, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t19 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t20 = load double, double* %l2
  %t21 = fptosi double %t20 to i64
  %t22 = load { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t19
  %t23 = extractvalue { %EffectViolation*, i64 } %t22, 0
  %t24 = extractvalue { %EffectViolation*, i64 } %t22, 1
  %t25 = icmp uge i64 %t21, %t24
  ; bounds check: %t25 (if true, out of bounds)
  %t26 = getelementptr %EffectViolation, %EffectViolation* %t23, i64 %t21
  %t27 = load %EffectViolation, %EffectViolation* %t26
  store %EffectViolation %t27, %EffectViolation* %l3
  %t28 = sitofp i64 0 to double
  store double %t28, double* %l4
  %t29 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t30 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t31 = load double, double* %l2
  %t32 = load %EffectViolation, %EffectViolation* %l3
  %t33 = load double, double* %l4
  br label %loop.header6
loop.header6:
  %t89 = phi { %Diagnostic*, i64 }* [ %t30, %loop.body1 ], [ %t87, %loop.latch8 ]
  %t90 = phi double [ %t33, %loop.body1 ], [ %t88, %loop.latch8 ]
  store { %Diagnostic*, i64 }* %t89, { %Diagnostic*, i64 }** %l1
  store double %t90, double* %l4
  br label %loop.body7
loop.body7:
  %t34 = load double, double* %l4
  %t35 = load %EffectViolation, %EffectViolation* %l3
  %t36 = extractvalue %EffectViolation %t35, 1
  %t37 = load { i8**, i64 }, { i8**, i64 }* %t36
  %t38 = extractvalue { i8**, i64 } %t37, 1
  %t39 = sitofp i64 %t38 to double
  %t40 = fcmp oge double %t34, %t39
  %t41 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t42 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t43 = load double, double* %l2
  %t44 = load %EffectViolation, %EffectViolation* %l3
  %t45 = load double, double* %l4
  br i1 %t40, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t46 = load %EffectViolation, %EffectViolation* %l3
  %t47 = extractvalue %EffectViolation %t46, 1
  %t48 = load double, double* %l4
  %t49 = fptosi double %t48 to i64
  %t50 = load { i8**, i64 }, { i8**, i64 }* %t47
  %t51 = extractvalue { i8**, i64 } %t50, 0
  %t52 = extractvalue { i8**, i64 } %t50, 1
  %t53 = icmp uge i64 %t49, %t52
  ; bounds check: %t53 (if true, out of bounds)
  %t54 = getelementptr i8*, i8** %t51, i64 %t49
  %t55 = load i8*, i8** %t54
  store i8* %t55, i8** %l5
  %t56 = load %EffectViolation, %EffectViolation* %l3
  %t57 = extractvalue %EffectViolation %t56, 2
  %t58 = load i8*, i8** %l5
  %t59 = bitcast { %EffectRequirement**, i64 }* %t57 to { %EffectRequirement*, i64 }*
  %t60 = call %EffectRequirement* @select_requirement_for_effect({ %EffectRequirement*, i64 }* %t59, i8* %t58)
  store %EffectRequirement* %t60, %EffectRequirement** %l6
  %t61 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %s62 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.62, i32 0, i32 0
  %t63 = insertvalue %Diagnostic undef, i8* %s62, 0
  %t64 = load %EffectViolation, %EffectViolation* %l3
  %t65 = extractvalue %EffectViolation %t64, 0
  %t66 = load i8*, i8** %l5
  %t67 = load %EffectRequirement*, %EffectRequirement** %l6
  %t68 = call i8* @format_effect_message(i8* %t65, i8* %t66, %EffectRequirement* %t67)
  %t69 = insertvalue %Diagnostic %t63, i8* %t68, 1
  %t70 = load %EffectRequirement*, %EffectRequirement** %l6
  %t71 = call %Token* @requirement_primary_token(%EffectRequirement* %t70)
  %t72 = insertvalue %Diagnostic %t69, %Token* %t71, 2
  %t73 = call noalias i8* @malloc(i64 24)
  %t74 = bitcast i8* %t73 to %Diagnostic*
  store %Diagnostic %t72, %Diagnostic* %t74
  %t75 = alloca [1 x i8*]
  %t76 = getelementptr [1 x i8*], [1 x i8*]* %t75, i32 0, i32 0
  %t77 = getelementptr i8*, i8** %t76, i64 0
  store i8* %t73, i8** %t77
  %t78 = alloca { i8**, i64 }
  %t79 = getelementptr { i8**, i64 }, { i8**, i64 }* %t78, i32 0, i32 0
  store i8** %t76, i8*** %t79
  %t80 = getelementptr { i8**, i64 }, { i8**, i64 }* %t78, i32 0, i32 1
  store i64 1, i64* %t80
  %t81 = bitcast { %Diagnostic*, i64 }* %t61 to { i8**, i64 }*
  %t82 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t81, { i8**, i64 }* %t78)
  %t83 = bitcast { i8**, i64 }* %t82 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t83, { %Diagnostic*, i64 }** %l1
  %t84 = load double, double* %l4
  %t85 = sitofp i64 1 to double
  %t86 = fadd double %t84, %t85
  store double %t86, double* %l4
  br label %loop.latch8
loop.latch8:
  %t87 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t88 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t91 = load double, double* %l2
  %t92 = sitofp i64 1 to double
  %t93 = fadd double %t91, %t92
  store double %t93, double* %l2
  br label %loop.latch2
loop.latch2:
  %t94 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t95 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t98 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t98
}

define %EffectRequirement* @select_requirement_for_effect({ %EffectRequirement*, i64 }* %requirements, i8* %effect) {
entry:
  %l0 = alloca double
  %l1 = alloca %EffectRequirement
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t27 = phi double [ %t1, %entry ], [ %t26, %loop.latch2 ]
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
  %t28 = bitcast i8* null to %EffectRequirement*
  ret %EffectRequirement* %t28
}

define %Token* @requirement_primary_token(%EffectRequirement* %requirement) {
entry:
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
entry:
  %l0 = alloca i8
  %s0 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.0, i32 0, i32 0
  %t1 = add i8* %routine_name, %s0
  %t2 = add i8* %t1, %effect
  %t3 = load i8, i8* %t2
  %t4 = add i8 %t3, 39
  store i8 %t4, i8* %l0
  %t5 = icmp ne %EffectRequirement* %requirement, null
  %t6 = load i8, i8* %l0
  br i1 %t5, label %then0, label %merge1
then0:
  %t7 = load i8, i8* %l0
  %s8 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.8, i32 0, i32 0
  %t9 = load i8, i8* %s8
  %t10 = add i8 %t7, %t9
  %t11 = getelementptr %EffectRequirement, %EffectRequirement* %requirement, i32 0, i32 2
  %t12 = load i8*, i8** %t11
  %t13 = load i8, i8* %t12
  %t14 = add i8 %t10, %t13
  store i8 %t14, i8* %l0
  br label %merge1
merge1:
  %t15 = phi i8 [ %t14, %then0 ], [ %t6, %entry ]
  store i8 %t15, i8* %l0
  %t16 = load i8, i8* %l0
  %s17 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.17, i32 0, i32 0
  %t18 = load i8, i8* %s17
  %t19 = add i8 %t16, %t18
  %t20 = load i8, i8* %effect
  %t21 = add i8 %t19, %t20
  %s22 = getelementptr inbounds [61 x i8], [61 x i8]* @.str.22, i32 0, i32 0
  %t23 = load i8, i8* %s22
  %t24 = add i8 %t21, %t23
  store i8 %t24, i8* %l0
  %t25 = load i8, i8* %l0
  %t26 = alloca [2 x i8], align 1
  %t27 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 0
  store i8 %t25, i8* %t27
  %t28 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 1
  store i8 0, i8* %t28
  %t29 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 0
  ret i8* %t29
}

define i1 @contains_string({ i8**, i64 }* %items, i8* %candidate) {
entry:
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
entry:
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
  %t8 = alloca [1 x %Diagnostic*]
  %t9 = getelementptr [1 x %Diagnostic*], [1 x %Diagnostic*]* %t8, i32 0, i32 0
  %t10 = getelementptr %Diagnostic*, %Diagnostic** %t9, i64 0
  store %Diagnostic* %t7, %Diagnostic** %t10
  %t11 = alloca { %Diagnostic**, i64 }
  %t12 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t11, i32 0, i32 0
  store %Diagnostic** %t9, %Diagnostic*** %t12
  %t13 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t11, i32 0, i32 1
  store i64 1, i64* %t13
  %t14 = insertvalue %ScopeResult %t2, { %Diagnostic**, i64 }* %t11, 1
  ret %ScopeResult %t14
merge1:
  %t15 = call { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %name, i8* %kind, %SourceSpan* %span)
  store { %SymbolEntry*, i64 }* %t15, { %SymbolEntry*, i64 }** %l0
  %t16 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t17 = bitcast { %SymbolEntry*, i64 }* %t16 to { %SymbolEntry**, i64 }*
  %t18 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t17, 0
  %t19 = alloca [0 x %Diagnostic*]
  %t20 = getelementptr [0 x %Diagnostic*], [0 x %Diagnostic*]* %t19, i32 0, i32 0
  %t21 = alloca { %Diagnostic**, i64 }
  %t22 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t21, i32 0, i32 0
  store %Diagnostic** %t20, %Diagnostic*** %t22
  %t23 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t21, i32 0, i32 1
  store i64 0, i64* %t23
  %t24 = insertvalue %ScopeResult %t18, { %Diagnostic**, i64 }* %t21, 1
  ret %ScopeResult %t24
}

define %SymbolCollectionResult @register_symbol(i8* %name, i8* %kind, %SourceSpan* %span, { %SymbolEntry*, i64 }* %existing) {
entry:
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
  %t8 = alloca [1 x %Diagnostic*]
  %t9 = getelementptr [1 x %Diagnostic*], [1 x %Diagnostic*]* %t8, i32 0, i32 0
  %t10 = getelementptr %Diagnostic*, %Diagnostic** %t9, i64 0
  store %Diagnostic* %t7, %Diagnostic** %t10
  %t11 = alloca { %Diagnostic**, i64 }
  %t12 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t11, i32 0, i32 0
  store %Diagnostic** %t9, %Diagnostic*** %t12
  %t13 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t11, i32 0, i32 1
  store i64 1, i64* %t13
  %t14 = insertvalue %SymbolCollectionResult %t2, { %Diagnostic**, i64 }* %t11, 1
  ret %SymbolCollectionResult %t14
merge1:
  %t15 = call { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %existing, i8* %name, i8* %kind, %SourceSpan* %span)
  %t16 = bitcast { %SymbolEntry*, i64 }* %t15 to { %SymbolEntry**, i64 }*
  %t17 = insertvalue %SymbolCollectionResult undef, { %SymbolEntry**, i64 }* %t16, 0
  %t18 = alloca [0 x %Diagnostic*]
  %t19 = getelementptr [0 x %Diagnostic*], [0 x %Diagnostic*]* %t18, i32 0, i32 0
  %t20 = alloca { %Diagnostic**, i64 }
  %t21 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t20, i32 0, i32 0
  store %Diagnostic** %t19, %Diagnostic*** %t21
  %t22 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t20, i32 0, i32 1
  store i64 0, i64* %t22
  %t23 = insertvalue %SymbolCollectionResult %t17, { %Diagnostic**, i64 }* %t20, 1
  ret %SymbolCollectionResult %t23
}

define { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %symbols, i8* %name, i8* %kind, %SourceSpan* %span) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %t0 = call { %SymbolEntry*, i64 }* @clone_bindings({ %SymbolEntry*, i64 }* %symbols)
  store { %SymbolEntry*, i64 }* %t0, { %SymbolEntry*, i64 }** %l0
  %t1 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t2 = insertvalue %SymbolEntry undef, i8* %name, 0
  %t3 = insertvalue %SymbolEntry %t2, i8* %kind, 1
  %t4 = insertvalue %SymbolEntry %t3, %SourceSpan* %span, 2
  %t5 = alloca [1 x %SymbolEntry]
  %t6 = getelementptr [1 x %SymbolEntry], [1 x %SymbolEntry]* %t5, i32 0, i32 0
  %t7 = getelementptr %SymbolEntry, %SymbolEntry* %t6, i64 0
  store %SymbolEntry %t4, %SymbolEntry* %t7
  %t8 = alloca { %SymbolEntry*, i64 }
  %t9 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t8, i32 0, i32 0
  store %SymbolEntry* %t6, %SymbolEntry** %t9
  %t10 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t8, i32 0, i32 1
  store i64 1, i64* %t10
  %t11 = bitcast { %SymbolEntry*, i64 }* %t1 to { i8**, i64 }*
  %t12 = bitcast { %SymbolEntry*, i64 }* %t8 to { i8**, i64 }*
  %t13 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t11, { i8**, i64 }* %t12)
  %t14 = bitcast { i8**, i64 }* %t13 to { %SymbolEntry*, i64 }*
  ret { %SymbolEntry*, i64 }* %t14
}

define { %SymbolEntry*, i64 }* @clone_bindings({ %SymbolEntry*, i64 }* %source) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca i64
  %l2 = alloca %SymbolEntry
  %t0 = alloca [0 x %SymbolEntry]
  %t1 = getelementptr [0 x %SymbolEntry], [0 x %SymbolEntry]* %t0, i32 0, i32 0
  %t2 = alloca { %SymbolEntry*, i64 }
  %t3 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t2, i32 0, i32 0
  store %SymbolEntry* %t1, %SymbolEntry** %t3
  %t4 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %SymbolEntry*, i64 }* %t2, { %SymbolEntry*, i64 }** %l0
  %t5 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %source, i32 0, i32 1
  %t6 = load i64, i64* %t5
  %t7 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %source, i32 0, i32 0
  %t8 = load %SymbolEntry*, %SymbolEntry** %t7
  store i64 0, i64* %l1
  store %SymbolEntry zeroinitializer, %SymbolEntry* %l2
  br label %for0
for0:
  %t9 = load i64, i64* %l1
  %t10 = icmp slt i64 %t9, %t6
  br i1 %t10, label %forbody1, label %afterfor3
forbody1:
  %t11 = load i64, i64* %l1
  %t12 = getelementptr %SymbolEntry, %SymbolEntry* %t8, i64 %t11
  %t13 = load %SymbolEntry, %SymbolEntry* %t12
  store %SymbolEntry %t13, %SymbolEntry* %l2
  %t14 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t15 = load %SymbolEntry, %SymbolEntry* %l2
  %t16 = call noalias i8* @malloc(i64 24)
  %t17 = bitcast i8* %t16 to %SymbolEntry*
  store %SymbolEntry %t15, %SymbolEntry* %t17
  %t18 = alloca [1 x i8*]
  %t19 = getelementptr [1 x i8*], [1 x i8*]* %t18, i32 0, i32 0
  %t20 = getelementptr i8*, i8** %t19, i64 0
  store i8* %t16, i8** %t20
  %t21 = alloca { i8**, i64 }
  %t22 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 0
  store i8** %t19, i8*** %t22
  %t23 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 1
  store i64 1, i64* %t23
  %t24 = bitcast { %SymbolEntry*, i64 }* %t14 to { i8**, i64 }*
  %t25 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t24, { i8**, i64 }* %t21)
  %t26 = bitcast { i8**, i64 }* %t25 to { %SymbolEntry*, i64 }*
  store { %SymbolEntry*, i64 }* %t26, { %SymbolEntry*, i64 }** %l0
  br label %forinc2
forinc2:
  %t27 = load i64, i64* %l1
  %t28 = add i64 %t27, 1
  store i64 %t28, i64* %l1
  br label %for0
afterfor3:
  %t29 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  ret { %SymbolEntry*, i64 }* %t29
}

define i1 @has_symbol({ %SymbolEntry*, i64 }* %symbols, i8* %name) {
entry:
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
entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  %t1 = insertvalue %Diagnostic undef, i8* %s0, 0
  %s2 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.2, i32 0, i32 0
  %t3 = add i8* %s2, %struct_name
  %s4 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.4, i32 0, i32 0
  %t5 = add i8* %t3, %s4
  %t6 = add i8* %t5, %interface_name
  %s7 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.7, i32 0, i32 0
  %t8 = add i8* %t6, %s7
  %t9 = add i8* %t8, %interface_signature
  %s10 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.10, i32 0, i32 0
  %t11 = add i8* %t9, %s10
  %t12 = insertvalue %Diagnostic %t1, i8* %t11, 1
  %t13 = bitcast i8* null to %Token*
  %t14 = insertvalue %Diagnostic %t12, %Token* %t13, 2
  ret %Diagnostic %t14
}

define %Diagnostic @make_interface_type_argument_mismatch_diagnostic(i8* %struct_name, i8* %annotation_text, i8* %interface_signature) {
entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  %t1 = insertvalue %Diagnostic undef, i8* %s0, 0
  %s2 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.2, i32 0, i32 0
  %t3 = add i8* %s2, %struct_name
  %s4 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.4, i32 0, i32 0
  %t5 = add i8* %t3, %s4
  %t6 = add i8* %t5, %annotation_text
  %s7 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.7, i32 0, i32 0
  %t8 = add i8* %t6, %s7
  %t9 = add i8* %t8, %interface_signature
  %s10 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.10, i32 0, i32 0
  %t11 = add i8* %t9, %s10
  %t12 = insertvalue %Diagnostic %t1, i8* %t11, 1
  %t13 = bitcast i8* null to %Token*
  %t14 = insertvalue %Diagnostic %t12, %Token* %t13, 2
  ret %Diagnostic %t14
}

define %Diagnostic @make_interface_no_type_arguments_diagnostic(i8* %struct_name, i8* %annotation_text, i8* %interface_name) {
entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  %t1 = insertvalue %Diagnostic undef, i8* %s0, 0
  %s2 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.2, i32 0, i32 0
  %t3 = add i8* %s2, %struct_name
  %s4 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.4, i32 0, i32 0
  %t5 = add i8* %t3, %s4
  %t6 = add i8* %t5, %annotation_text
  %s7 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.7, i32 0, i32 0
  %t8 = add i8* %t6, %s7
  %t9 = add i8* %t8, %interface_name
  %s10 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.10, i32 0, i32 0
  %t11 = add i8* %t9, %s10
  %t12 = insertvalue %Diagnostic %t1, i8* %t11, 1
  %t13 = bitcast i8* null to %Token*
  %t14 = insertvalue %Diagnostic %t12, %Token* %t13, 2
  ret %Diagnostic %t14
}

define %Token* @token_from_name(i8* %name, %SourceSpan* %span) {
entry:
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
entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  %t1 = insertvalue %Diagnostic undef, i8* %s0, 0
  %s2 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.2, i32 0, i32 0
  %t3 = add i8* %s2, %kind
  %s4 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.4, i32 0, i32 0
  %t5 = add i8* %t3, %s4
  %t6 = add i8* %t5, %name
  %s7 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.7, i32 0, i32 0
  %t8 = add i8* %t6, %s7
  %t9 = insertvalue %Diagnostic %t1, i8* %t8, 1
  %t10 = insertvalue %Diagnostic %t9, %Token* %token, 2
  ret %Diagnostic %t10
}

define %Diagnostic @make_missing_interface_member_diagnostic(i8* %struct_name, i8* %interface_name, i8* %member_name) {
entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  %t1 = insertvalue %Diagnostic undef, i8* %s0, 0
  %s2 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.2, i32 0, i32 0
  %t3 = add i8* %s2, %struct_name
  %s4 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.4, i32 0, i32 0
  %t5 = add i8* %t3, %s4
  %t6 = add i8* %t5, %interface_name
  %s7 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.7, i32 0, i32 0
  %t8 = add i8* %t6, %s7
  %t9 = add i8* %t8, %member_name
  %t10 = load i8, i8* %t9
  %t11 = add i8 %t10, 96
  %t12 = alloca [2 x i8], align 1
  %t13 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  store i8 %t11, i8* %t13
  %t14 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 1
  store i8 0, i8* %t14
  %t15 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  %t16 = insertvalue %Diagnostic %t1, i8* %t15, 1
  %t17 = bitcast i8* null to %Token*
  %t18 = insertvalue %Diagnostic %t16, %Token* %t17, 2
  ret %Diagnostic %t18
}

define i1 @starts_with(i8* %value, i8* %prefix) {
entry:
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
  %t24 = phi double [ %t4, %entry ], [ %t23, %loop.latch4 ]
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
  ret i1 1
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
