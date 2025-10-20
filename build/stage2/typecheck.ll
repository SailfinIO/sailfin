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

declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)

declare noalias i8* @malloc(i64)

@.str.153 = private unnamed_addr constant [3 x i8] c", \00"
@.str.5 = private unnamed_addr constant [1 x i8] c"\00"
@.str.7 = private unnamed_addr constant [1 x i8] c"\00"
@.str.0 = private unnamed_addr constant [21 x i8] c" is missing effect '\00"
@.str.13 = private unnamed_addr constant [15 x i8] c". hint: add ![\00"
@.str.18 = private unnamed_addr constant [61 x i8] c"] to the signature or accept the CLI fix prompt when offered\00"

define %TypecheckResult @typecheck_program(%Program %program) {
entry:
  %l0 = alloca %SymbolCollectionResult
  %l1 = alloca { %Statement*, i64 }*
  %l2 = alloca { %Diagnostic*, i64 }*
  %l3 = alloca { %Diagnostic*, i64 }*
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
  %t7 = insertvalue %TypecheckResult undef, { %Diagnostic**, i64 }* null, 0
  %t8 = load %SymbolCollectionResult, %SymbolCollectionResult* %l0
  %t9 = extractvalue %SymbolCollectionResult %t8, 0
  %t10 = insertvalue %TypecheckResult %t7, { %SymbolEntry**, i64 }* %t9, 1
  ret %TypecheckResult %t10
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
  %t94 = alloca [1 x %Statement*]
  %t95 = getelementptr [1 x %Statement*], [1 x %Statement*]* %t94, i32 0, i32 0
  %t96 = getelementptr %Statement*, %Statement** %t95, i64 0
  store %Statement* %t93, %Statement** %t96
  %t97 = alloca { %Statement**, i64 }
  %t98 = getelementptr { %Statement**, i64 }, { %Statement**, i64 }* %t97, i32 0, i32 0
  store %Statement** %t95, %Statement*** %t98
  %t99 = getelementptr { %Statement**, i64 }, { %Statement**, i64 }* %t97, i32 0, i32 1
  store i64 1, i64* %t99
  %t100 = bitcast { %Statement*, i64 }* %t92 to { i8**, i64 }*
  %t101 = bitcast { %Statement**, i64 }* %t97 to { i8**, i64 }*
  %t102 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t100, { i8**, i64 }* %t101)
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
  %t116 = bitcast %SourceSpan* %t115 to i8*
  %t117 = call %SymbolCollectionResult @register_symbol(i8* %t93, i8* %s94, i8* %t116, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t117
merge1:
  %t118 = extractvalue %Statement %statement, 0
  %t119 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t120 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t118, 0
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %t123 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t124 = icmp eq i32 %t118, 1
  %t125 = select i1 %t124, i8* %t123, i8* %t122
  %t126 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t127 = icmp eq i32 %t118, 2
  %t128 = select i1 %t127, i8* %t126, i8* %t125
  %t129 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t130 = icmp eq i32 %t118, 3
  %t131 = select i1 %t130, i8* %t129, i8* %t128
  %t132 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t118, 4
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t118, 5
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t118, 6
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t118, 7
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t118, 8
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t118, 9
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t118, 10
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t118, 11
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t118, 12
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t118, 13
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %t162 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t118, 14
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t118, 15
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %t168 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t169 = icmp eq i32 %t118, 16
  %t170 = select i1 %t169, i8* %t168, i8* %t167
  %t171 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t172 = icmp eq i32 %t118, 17
  %t173 = select i1 %t172, i8* %t171, i8* %t170
  %t174 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t175 = icmp eq i32 %t118, 18
  %t176 = select i1 %t175, i8* %t174, i8* %t173
  %t177 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t178 = icmp eq i32 %t118, 19
  %t179 = select i1 %t178, i8* %t177, i8* %t176
  %t180 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t181 = icmp eq i32 %t118, 20
  %t182 = select i1 %t181, i8* %t180, i8* %t179
  %t183 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t184 = icmp eq i32 %t118, 21
  %t185 = select i1 %t184, i8* %t183, i8* %t182
  %t186 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t187 = icmp eq i32 %t118, 22
  %t188 = select i1 %t187, i8* %t186, i8* %t185
  %s189 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.189, i32 0, i32 0
  %t190 = icmp eq i8* %t188, %s189
  br i1 %t190, label %then2, label %merge3
then2:
  %t191 = extractvalue %Statement %statement, 0
  %t192 = alloca %Statement
  store %Statement %statement, %Statement* %t192
  %t193 = getelementptr inbounds %Statement, %Statement* %t192, i32 0, i32 1
  %t194 = bitcast [48 x i8]* %t193 to i8*
  %t195 = bitcast i8* %t194 to i8**
  %t196 = load i8*, i8** %t195
  %t197 = icmp eq i32 %t191, 2
  %t198 = select i1 %t197, i8* %t196, i8* null
  %t199 = getelementptr inbounds %Statement, %Statement* %t192, i32 0, i32 1
  %t200 = bitcast [48 x i8]* %t199 to i8*
  %t201 = bitcast i8* %t200 to i8**
  %t202 = load i8*, i8** %t201
  %t203 = icmp eq i32 %t191, 3
  %t204 = select i1 %t203, i8* %t202, i8* %t198
  %t205 = getelementptr inbounds %Statement, %Statement* %t192, i32 0, i32 1
  %t206 = bitcast [40 x i8]* %t205 to i8*
  %t207 = bitcast i8* %t206 to i8**
  %t208 = load i8*, i8** %t207
  %t209 = icmp eq i32 %t191, 6
  %t210 = select i1 %t209, i8* %t208, i8* %t204
  %t211 = getelementptr inbounds %Statement, %Statement* %t192, i32 0, i32 1
  %t212 = bitcast [56 x i8]* %t211 to i8*
  %t213 = bitcast i8* %t212 to i8**
  %t214 = load i8*, i8** %t213
  %t215 = icmp eq i32 %t191, 8
  %t216 = select i1 %t215, i8* %t214, i8* %t210
  %t217 = getelementptr inbounds %Statement, %Statement* %t192, i32 0, i32 1
  %t218 = bitcast [40 x i8]* %t217 to i8*
  %t219 = bitcast i8* %t218 to i8**
  %t220 = load i8*, i8** %t219
  %t221 = icmp eq i32 %t191, 9
  %t222 = select i1 %t221, i8* %t220, i8* %t216
  %t223 = getelementptr inbounds %Statement, %Statement* %t192, i32 0, i32 1
  %t224 = bitcast [40 x i8]* %t223 to i8*
  %t225 = bitcast i8* %t224 to i8**
  %t226 = load i8*, i8** %t225
  %t227 = icmp eq i32 %t191, 10
  %t228 = select i1 %t227, i8* %t226, i8* %t222
  %t229 = getelementptr inbounds %Statement, %Statement* %t192, i32 0, i32 1
  %t230 = bitcast [40 x i8]* %t229 to i8*
  %t231 = bitcast i8* %t230 to i8**
  %t232 = load i8*, i8** %t231
  %t233 = icmp eq i32 %t191, 11
  %t234 = select i1 %t233, i8* %t232, i8* %t228
  %s235 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.235, i32 0, i32 0
  %t236 = extractvalue %Statement %statement, 0
  %t237 = alloca %Statement
  store %Statement %statement, %Statement* %t237
  %t238 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t239 = bitcast [48 x i8]* %t238 to i8*
  %t240 = getelementptr inbounds i8, i8* %t239, i64 8
  %t241 = bitcast i8* %t240 to %SourceSpan**
  %t242 = load %SourceSpan*, %SourceSpan** %t241
  %t243 = icmp eq i32 %t236, 3
  %t244 = select i1 %t243, %SourceSpan* %t242, %SourceSpan* null
  %t245 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t246 = bitcast [40 x i8]* %t245 to i8*
  %t247 = getelementptr inbounds i8, i8* %t246, i64 8
  %t248 = bitcast i8* %t247 to %SourceSpan**
  %t249 = load %SourceSpan*, %SourceSpan** %t248
  %t250 = icmp eq i32 %t236, 6
  %t251 = select i1 %t250, %SourceSpan* %t249, %SourceSpan* %t244
  %t252 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t253 = bitcast [56 x i8]* %t252 to i8*
  %t254 = getelementptr inbounds i8, i8* %t253, i64 8
  %t255 = bitcast i8* %t254 to %SourceSpan**
  %t256 = load %SourceSpan*, %SourceSpan** %t255
  %t257 = icmp eq i32 %t236, 8
  %t258 = select i1 %t257, %SourceSpan* %t256, %SourceSpan* %t251
  %t259 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t260 = bitcast [40 x i8]* %t259 to i8*
  %t261 = getelementptr inbounds i8, i8* %t260, i64 8
  %t262 = bitcast i8* %t261 to %SourceSpan**
  %t263 = load %SourceSpan*, %SourceSpan** %t262
  %t264 = icmp eq i32 %t236, 9
  %t265 = select i1 %t264, %SourceSpan* %t263, %SourceSpan* %t258
  %t266 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t267 = bitcast [40 x i8]* %t266 to i8*
  %t268 = getelementptr inbounds i8, i8* %t267, i64 8
  %t269 = bitcast i8* %t268 to %SourceSpan**
  %t270 = load %SourceSpan*, %SourceSpan** %t269
  %t271 = icmp eq i32 %t236, 10
  %t272 = select i1 %t271, %SourceSpan* %t270, %SourceSpan* %t265
  %t273 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t274 = bitcast [40 x i8]* %t273 to i8*
  %t275 = getelementptr inbounds i8, i8* %t274, i64 8
  %t276 = bitcast i8* %t275 to %SourceSpan**
  %t277 = load %SourceSpan*, %SourceSpan** %t276
  %t278 = icmp eq i32 %t236, 11
  %t279 = select i1 %t278, %SourceSpan* %t277, %SourceSpan* %t272
  %t280 = bitcast %SourceSpan* %t279 to i8*
  %t281 = call %SymbolCollectionResult @register_symbol(i8* %t234, i8* %s235, i8* %t280, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t281
merge3:
  %t282 = extractvalue %Statement %statement, 0
  %t283 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t284 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t285 = icmp eq i32 %t282, 0
  %t286 = select i1 %t285, i8* %t284, i8* %t283
  %t287 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t288 = icmp eq i32 %t282, 1
  %t289 = select i1 %t288, i8* %t287, i8* %t286
  %t290 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t291 = icmp eq i32 %t282, 2
  %t292 = select i1 %t291, i8* %t290, i8* %t289
  %t293 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t294 = icmp eq i32 %t282, 3
  %t295 = select i1 %t294, i8* %t293, i8* %t292
  %t296 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t297 = icmp eq i32 %t282, 4
  %t298 = select i1 %t297, i8* %t296, i8* %t295
  %t299 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t300 = icmp eq i32 %t282, 5
  %t301 = select i1 %t300, i8* %t299, i8* %t298
  %t302 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t303 = icmp eq i32 %t282, 6
  %t304 = select i1 %t303, i8* %t302, i8* %t301
  %t305 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t306 = icmp eq i32 %t282, 7
  %t307 = select i1 %t306, i8* %t305, i8* %t304
  %t308 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t309 = icmp eq i32 %t282, 8
  %t310 = select i1 %t309, i8* %t308, i8* %t307
  %t311 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t312 = icmp eq i32 %t282, 9
  %t313 = select i1 %t312, i8* %t311, i8* %t310
  %t314 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t315 = icmp eq i32 %t282, 10
  %t316 = select i1 %t315, i8* %t314, i8* %t313
  %t317 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t318 = icmp eq i32 %t282, 11
  %t319 = select i1 %t318, i8* %t317, i8* %t316
  %t320 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t321 = icmp eq i32 %t282, 12
  %t322 = select i1 %t321, i8* %t320, i8* %t319
  %t323 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t324 = icmp eq i32 %t282, 13
  %t325 = select i1 %t324, i8* %t323, i8* %t322
  %t326 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t327 = icmp eq i32 %t282, 14
  %t328 = select i1 %t327, i8* %t326, i8* %t325
  %t329 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t330 = icmp eq i32 %t282, 15
  %t331 = select i1 %t330, i8* %t329, i8* %t328
  %t332 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t333 = icmp eq i32 %t282, 16
  %t334 = select i1 %t333, i8* %t332, i8* %t331
  %t335 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t336 = icmp eq i32 %t282, 17
  %t337 = select i1 %t336, i8* %t335, i8* %t334
  %t338 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t339 = icmp eq i32 %t282, 18
  %t340 = select i1 %t339, i8* %t338, i8* %t337
  %t341 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t342 = icmp eq i32 %t282, 19
  %t343 = select i1 %t342, i8* %t341, i8* %t340
  %t344 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t345 = icmp eq i32 %t282, 20
  %t346 = select i1 %t345, i8* %t344, i8* %t343
  %t347 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t348 = icmp eq i32 %t282, 21
  %t349 = select i1 %t348, i8* %t347, i8* %t346
  %t350 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t351 = icmp eq i32 %t282, 22
  %t352 = select i1 %t351, i8* %t350, i8* %t349
  %s353 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.353, i32 0, i32 0
  %t354 = icmp eq i8* %t352, %s353
  br i1 %t354, label %then4, label %merge5
then4:
  %t355 = extractvalue %Statement %statement, 0
  %t356 = alloca %Statement
  store %Statement %statement, %Statement* %t356
  %t357 = getelementptr inbounds %Statement, %Statement* %t356, i32 0, i32 1
  %t358 = bitcast [48 x i8]* %t357 to i8*
  %t359 = bitcast i8* %t358 to i8**
  %t360 = load i8*, i8** %t359
  %t361 = icmp eq i32 %t355, 2
  %t362 = select i1 %t361, i8* %t360, i8* null
  %t363 = getelementptr inbounds %Statement, %Statement* %t356, i32 0, i32 1
  %t364 = bitcast [48 x i8]* %t363 to i8*
  %t365 = bitcast i8* %t364 to i8**
  %t366 = load i8*, i8** %t365
  %t367 = icmp eq i32 %t355, 3
  %t368 = select i1 %t367, i8* %t366, i8* %t362
  %t369 = getelementptr inbounds %Statement, %Statement* %t356, i32 0, i32 1
  %t370 = bitcast [40 x i8]* %t369 to i8*
  %t371 = bitcast i8* %t370 to i8**
  %t372 = load i8*, i8** %t371
  %t373 = icmp eq i32 %t355, 6
  %t374 = select i1 %t373, i8* %t372, i8* %t368
  %t375 = getelementptr inbounds %Statement, %Statement* %t356, i32 0, i32 1
  %t376 = bitcast [56 x i8]* %t375 to i8*
  %t377 = bitcast i8* %t376 to i8**
  %t378 = load i8*, i8** %t377
  %t379 = icmp eq i32 %t355, 8
  %t380 = select i1 %t379, i8* %t378, i8* %t374
  %t381 = getelementptr inbounds %Statement, %Statement* %t356, i32 0, i32 1
  %t382 = bitcast [40 x i8]* %t381 to i8*
  %t383 = bitcast i8* %t382 to i8**
  %t384 = load i8*, i8** %t383
  %t385 = icmp eq i32 %t355, 9
  %t386 = select i1 %t385, i8* %t384, i8* %t380
  %t387 = getelementptr inbounds %Statement, %Statement* %t356, i32 0, i32 1
  %t388 = bitcast [40 x i8]* %t387 to i8*
  %t389 = bitcast i8* %t388 to i8**
  %t390 = load i8*, i8** %t389
  %t391 = icmp eq i32 %t355, 10
  %t392 = select i1 %t391, i8* %t390, i8* %t386
  %t393 = getelementptr inbounds %Statement, %Statement* %t356, i32 0, i32 1
  %t394 = bitcast [40 x i8]* %t393 to i8*
  %t395 = bitcast i8* %t394 to i8**
  %t396 = load i8*, i8** %t395
  %t397 = icmp eq i32 %t355, 11
  %t398 = select i1 %t397, i8* %t396, i8* %t392
  %s399 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.399, i32 0, i32 0
  %t400 = extractvalue %Statement %statement, 0
  %t401 = alloca %Statement
  store %Statement %statement, %Statement* %t401
  %t402 = getelementptr inbounds %Statement, %Statement* %t401, i32 0, i32 1
  %t403 = bitcast [48 x i8]* %t402 to i8*
  %t404 = getelementptr inbounds i8, i8* %t403, i64 8
  %t405 = bitcast i8* %t404 to %SourceSpan**
  %t406 = load %SourceSpan*, %SourceSpan** %t405
  %t407 = icmp eq i32 %t400, 3
  %t408 = select i1 %t407, %SourceSpan* %t406, %SourceSpan* null
  %t409 = getelementptr inbounds %Statement, %Statement* %t401, i32 0, i32 1
  %t410 = bitcast [40 x i8]* %t409 to i8*
  %t411 = getelementptr inbounds i8, i8* %t410, i64 8
  %t412 = bitcast i8* %t411 to %SourceSpan**
  %t413 = load %SourceSpan*, %SourceSpan** %t412
  %t414 = icmp eq i32 %t400, 6
  %t415 = select i1 %t414, %SourceSpan* %t413, %SourceSpan* %t408
  %t416 = getelementptr inbounds %Statement, %Statement* %t401, i32 0, i32 1
  %t417 = bitcast [56 x i8]* %t416 to i8*
  %t418 = getelementptr inbounds i8, i8* %t417, i64 8
  %t419 = bitcast i8* %t418 to %SourceSpan**
  %t420 = load %SourceSpan*, %SourceSpan** %t419
  %t421 = icmp eq i32 %t400, 8
  %t422 = select i1 %t421, %SourceSpan* %t420, %SourceSpan* %t415
  %t423 = getelementptr inbounds %Statement, %Statement* %t401, i32 0, i32 1
  %t424 = bitcast [40 x i8]* %t423 to i8*
  %t425 = getelementptr inbounds i8, i8* %t424, i64 8
  %t426 = bitcast i8* %t425 to %SourceSpan**
  %t427 = load %SourceSpan*, %SourceSpan** %t426
  %t428 = icmp eq i32 %t400, 9
  %t429 = select i1 %t428, %SourceSpan* %t427, %SourceSpan* %t422
  %t430 = getelementptr inbounds %Statement, %Statement* %t401, i32 0, i32 1
  %t431 = bitcast [40 x i8]* %t430 to i8*
  %t432 = getelementptr inbounds i8, i8* %t431, i64 8
  %t433 = bitcast i8* %t432 to %SourceSpan**
  %t434 = load %SourceSpan*, %SourceSpan** %t433
  %t435 = icmp eq i32 %t400, 10
  %t436 = select i1 %t435, %SourceSpan* %t434, %SourceSpan* %t429
  %t437 = getelementptr inbounds %Statement, %Statement* %t401, i32 0, i32 1
  %t438 = bitcast [40 x i8]* %t437 to i8*
  %t439 = getelementptr inbounds i8, i8* %t438, i64 8
  %t440 = bitcast i8* %t439 to %SourceSpan**
  %t441 = load %SourceSpan*, %SourceSpan** %t440
  %t442 = icmp eq i32 %t400, 11
  %t443 = select i1 %t442, %SourceSpan* %t441, %SourceSpan* %t436
  %t444 = bitcast %SourceSpan* %t443 to i8*
  %t445 = call %SymbolCollectionResult @register_symbol(i8* %t398, i8* %s399, i8* %t444, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t445
merge5:
  %t446 = extractvalue %Statement %statement, 0
  %t447 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t448 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t449 = icmp eq i32 %t446, 0
  %t450 = select i1 %t449, i8* %t448, i8* %t447
  %t451 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t452 = icmp eq i32 %t446, 1
  %t453 = select i1 %t452, i8* %t451, i8* %t450
  %t454 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t455 = icmp eq i32 %t446, 2
  %t456 = select i1 %t455, i8* %t454, i8* %t453
  %t457 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t458 = icmp eq i32 %t446, 3
  %t459 = select i1 %t458, i8* %t457, i8* %t456
  %t460 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t461 = icmp eq i32 %t446, 4
  %t462 = select i1 %t461, i8* %t460, i8* %t459
  %t463 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t464 = icmp eq i32 %t446, 5
  %t465 = select i1 %t464, i8* %t463, i8* %t462
  %t466 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t467 = icmp eq i32 %t446, 6
  %t468 = select i1 %t467, i8* %t466, i8* %t465
  %t469 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t470 = icmp eq i32 %t446, 7
  %t471 = select i1 %t470, i8* %t469, i8* %t468
  %t472 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t473 = icmp eq i32 %t446, 8
  %t474 = select i1 %t473, i8* %t472, i8* %t471
  %t475 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t476 = icmp eq i32 %t446, 9
  %t477 = select i1 %t476, i8* %t475, i8* %t474
  %t478 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t479 = icmp eq i32 %t446, 10
  %t480 = select i1 %t479, i8* %t478, i8* %t477
  %t481 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t482 = icmp eq i32 %t446, 11
  %t483 = select i1 %t482, i8* %t481, i8* %t480
  %t484 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t485 = icmp eq i32 %t446, 12
  %t486 = select i1 %t485, i8* %t484, i8* %t483
  %t487 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t488 = icmp eq i32 %t446, 13
  %t489 = select i1 %t488, i8* %t487, i8* %t486
  %t490 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t491 = icmp eq i32 %t446, 14
  %t492 = select i1 %t491, i8* %t490, i8* %t489
  %t493 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t494 = icmp eq i32 %t446, 15
  %t495 = select i1 %t494, i8* %t493, i8* %t492
  %t496 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t497 = icmp eq i32 %t446, 16
  %t498 = select i1 %t497, i8* %t496, i8* %t495
  %t499 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t500 = icmp eq i32 %t446, 17
  %t501 = select i1 %t500, i8* %t499, i8* %t498
  %t502 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t503 = icmp eq i32 %t446, 18
  %t504 = select i1 %t503, i8* %t502, i8* %t501
  %t505 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t506 = icmp eq i32 %t446, 19
  %t507 = select i1 %t506, i8* %t505, i8* %t504
  %t508 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t509 = icmp eq i32 %t446, 20
  %t510 = select i1 %t509, i8* %t508, i8* %t507
  %t511 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t512 = icmp eq i32 %t446, 21
  %t513 = select i1 %t512, i8* %t511, i8* %t510
  %t514 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t515 = icmp eq i32 %t446, 22
  %t516 = select i1 %t515, i8* %t514, i8* %t513
  %s517 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.517, i32 0, i32 0
  %t518 = icmp eq i8* %t516, %s517
  br i1 %t518, label %then6, label %merge7
then6:
  %t519 = extractvalue %Statement %statement, 0
  %t520 = alloca %Statement
  store %Statement %statement, %Statement* %t520
  %t521 = getelementptr inbounds %Statement, %Statement* %t520, i32 0, i32 1
  %t522 = bitcast [48 x i8]* %t521 to i8*
  %t523 = bitcast i8* %t522 to i8**
  %t524 = load i8*, i8** %t523
  %t525 = icmp eq i32 %t519, 2
  %t526 = select i1 %t525, i8* %t524, i8* null
  %t527 = getelementptr inbounds %Statement, %Statement* %t520, i32 0, i32 1
  %t528 = bitcast [48 x i8]* %t527 to i8*
  %t529 = bitcast i8* %t528 to i8**
  %t530 = load i8*, i8** %t529
  %t531 = icmp eq i32 %t519, 3
  %t532 = select i1 %t531, i8* %t530, i8* %t526
  %t533 = getelementptr inbounds %Statement, %Statement* %t520, i32 0, i32 1
  %t534 = bitcast [40 x i8]* %t533 to i8*
  %t535 = bitcast i8* %t534 to i8**
  %t536 = load i8*, i8** %t535
  %t537 = icmp eq i32 %t519, 6
  %t538 = select i1 %t537, i8* %t536, i8* %t532
  %t539 = getelementptr inbounds %Statement, %Statement* %t520, i32 0, i32 1
  %t540 = bitcast [56 x i8]* %t539 to i8*
  %t541 = bitcast i8* %t540 to i8**
  %t542 = load i8*, i8** %t541
  %t543 = icmp eq i32 %t519, 8
  %t544 = select i1 %t543, i8* %t542, i8* %t538
  %t545 = getelementptr inbounds %Statement, %Statement* %t520, i32 0, i32 1
  %t546 = bitcast [40 x i8]* %t545 to i8*
  %t547 = bitcast i8* %t546 to i8**
  %t548 = load i8*, i8** %t547
  %t549 = icmp eq i32 %t519, 9
  %t550 = select i1 %t549, i8* %t548, i8* %t544
  %t551 = getelementptr inbounds %Statement, %Statement* %t520, i32 0, i32 1
  %t552 = bitcast [40 x i8]* %t551 to i8*
  %t553 = bitcast i8* %t552 to i8**
  %t554 = load i8*, i8** %t553
  %t555 = icmp eq i32 %t519, 10
  %t556 = select i1 %t555, i8* %t554, i8* %t550
  %t557 = getelementptr inbounds %Statement, %Statement* %t520, i32 0, i32 1
  %t558 = bitcast [40 x i8]* %t557 to i8*
  %t559 = bitcast i8* %t558 to i8**
  %t560 = load i8*, i8** %t559
  %t561 = icmp eq i32 %t519, 11
  %t562 = select i1 %t561, i8* %t560, i8* %t556
  %s563 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.563, i32 0, i32 0
  %t564 = extractvalue %Statement %statement, 0
  %t565 = alloca %Statement
  store %Statement %statement, %Statement* %t565
  %t566 = getelementptr inbounds %Statement, %Statement* %t565, i32 0, i32 1
  %t567 = bitcast [48 x i8]* %t566 to i8*
  %t568 = getelementptr inbounds i8, i8* %t567, i64 8
  %t569 = bitcast i8* %t568 to %SourceSpan**
  %t570 = load %SourceSpan*, %SourceSpan** %t569
  %t571 = icmp eq i32 %t564, 3
  %t572 = select i1 %t571, %SourceSpan* %t570, %SourceSpan* null
  %t573 = getelementptr inbounds %Statement, %Statement* %t565, i32 0, i32 1
  %t574 = bitcast [40 x i8]* %t573 to i8*
  %t575 = getelementptr inbounds i8, i8* %t574, i64 8
  %t576 = bitcast i8* %t575 to %SourceSpan**
  %t577 = load %SourceSpan*, %SourceSpan** %t576
  %t578 = icmp eq i32 %t564, 6
  %t579 = select i1 %t578, %SourceSpan* %t577, %SourceSpan* %t572
  %t580 = getelementptr inbounds %Statement, %Statement* %t565, i32 0, i32 1
  %t581 = bitcast [56 x i8]* %t580 to i8*
  %t582 = getelementptr inbounds i8, i8* %t581, i64 8
  %t583 = bitcast i8* %t582 to %SourceSpan**
  %t584 = load %SourceSpan*, %SourceSpan** %t583
  %t585 = icmp eq i32 %t564, 8
  %t586 = select i1 %t585, %SourceSpan* %t584, %SourceSpan* %t579
  %t587 = getelementptr inbounds %Statement, %Statement* %t565, i32 0, i32 1
  %t588 = bitcast [40 x i8]* %t587 to i8*
  %t589 = getelementptr inbounds i8, i8* %t588, i64 8
  %t590 = bitcast i8* %t589 to %SourceSpan**
  %t591 = load %SourceSpan*, %SourceSpan** %t590
  %t592 = icmp eq i32 %t564, 9
  %t593 = select i1 %t592, %SourceSpan* %t591, %SourceSpan* %t586
  %t594 = getelementptr inbounds %Statement, %Statement* %t565, i32 0, i32 1
  %t595 = bitcast [40 x i8]* %t594 to i8*
  %t596 = getelementptr inbounds i8, i8* %t595, i64 8
  %t597 = bitcast i8* %t596 to %SourceSpan**
  %t598 = load %SourceSpan*, %SourceSpan** %t597
  %t599 = icmp eq i32 %t564, 10
  %t600 = select i1 %t599, %SourceSpan* %t598, %SourceSpan* %t593
  %t601 = getelementptr inbounds %Statement, %Statement* %t565, i32 0, i32 1
  %t602 = bitcast [40 x i8]* %t601 to i8*
  %t603 = getelementptr inbounds i8, i8* %t602, i64 8
  %t604 = bitcast i8* %t603 to %SourceSpan**
  %t605 = load %SourceSpan*, %SourceSpan** %t604
  %t606 = icmp eq i32 %t564, 11
  %t607 = select i1 %t606, %SourceSpan* %t605, %SourceSpan* %t600
  %t608 = bitcast %SourceSpan* %t607 to i8*
  %t609 = call %SymbolCollectionResult @register_symbol(i8* %t562, i8* %s563, i8* %t608, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t609
merge7:
  %t610 = extractvalue %Statement %statement, 0
  %t611 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t612 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t613 = icmp eq i32 %t610, 0
  %t614 = select i1 %t613, i8* %t612, i8* %t611
  %t615 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t616 = icmp eq i32 %t610, 1
  %t617 = select i1 %t616, i8* %t615, i8* %t614
  %t618 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t619 = icmp eq i32 %t610, 2
  %t620 = select i1 %t619, i8* %t618, i8* %t617
  %t621 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t622 = icmp eq i32 %t610, 3
  %t623 = select i1 %t622, i8* %t621, i8* %t620
  %t624 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t625 = icmp eq i32 %t610, 4
  %t626 = select i1 %t625, i8* %t624, i8* %t623
  %t627 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t628 = icmp eq i32 %t610, 5
  %t629 = select i1 %t628, i8* %t627, i8* %t626
  %t630 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t631 = icmp eq i32 %t610, 6
  %t632 = select i1 %t631, i8* %t630, i8* %t629
  %t633 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t634 = icmp eq i32 %t610, 7
  %t635 = select i1 %t634, i8* %t633, i8* %t632
  %t636 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t637 = icmp eq i32 %t610, 8
  %t638 = select i1 %t637, i8* %t636, i8* %t635
  %t639 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t640 = icmp eq i32 %t610, 9
  %t641 = select i1 %t640, i8* %t639, i8* %t638
  %t642 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t643 = icmp eq i32 %t610, 10
  %t644 = select i1 %t643, i8* %t642, i8* %t641
  %t645 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t646 = icmp eq i32 %t610, 11
  %t647 = select i1 %t646, i8* %t645, i8* %t644
  %t648 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t649 = icmp eq i32 %t610, 12
  %t650 = select i1 %t649, i8* %t648, i8* %t647
  %t651 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t652 = icmp eq i32 %t610, 13
  %t653 = select i1 %t652, i8* %t651, i8* %t650
  %t654 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t655 = icmp eq i32 %t610, 14
  %t656 = select i1 %t655, i8* %t654, i8* %t653
  %t657 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t658 = icmp eq i32 %t610, 15
  %t659 = select i1 %t658, i8* %t657, i8* %t656
  %t660 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t661 = icmp eq i32 %t610, 16
  %t662 = select i1 %t661, i8* %t660, i8* %t659
  %t663 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t664 = icmp eq i32 %t610, 17
  %t665 = select i1 %t664, i8* %t663, i8* %t662
  %t666 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t667 = icmp eq i32 %t610, 18
  %t668 = select i1 %t667, i8* %t666, i8* %t665
  %t669 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t670 = icmp eq i32 %t610, 19
  %t671 = select i1 %t670, i8* %t669, i8* %t668
  %t672 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t673 = icmp eq i32 %t610, 20
  %t674 = select i1 %t673, i8* %t672, i8* %t671
  %t675 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t676 = icmp eq i32 %t610, 21
  %t677 = select i1 %t676, i8* %t675, i8* %t674
  %t678 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t679 = icmp eq i32 %t610, 22
  %t680 = select i1 %t679, i8* %t678, i8* %t677
  %s681 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.681, i32 0, i32 0
  %t682 = icmp eq i8* %t680, %s681
  br i1 %t682, label %then8, label %merge9
then8:
  %t683 = extractvalue %Statement %statement, 0
  %t684 = alloca %Statement
  store %Statement %statement, %Statement* %t684
  %t685 = getelementptr inbounds %Statement, %Statement* %t684, i32 0, i32 1
  %t686 = bitcast [48 x i8]* %t685 to i8*
  %t687 = bitcast i8* %t686 to i8**
  %t688 = load i8*, i8** %t687
  %t689 = icmp eq i32 %t683, 2
  %t690 = select i1 %t689, i8* %t688, i8* null
  %t691 = getelementptr inbounds %Statement, %Statement* %t684, i32 0, i32 1
  %t692 = bitcast [48 x i8]* %t691 to i8*
  %t693 = bitcast i8* %t692 to i8**
  %t694 = load i8*, i8** %t693
  %t695 = icmp eq i32 %t683, 3
  %t696 = select i1 %t695, i8* %t694, i8* %t690
  %t697 = getelementptr inbounds %Statement, %Statement* %t684, i32 0, i32 1
  %t698 = bitcast [40 x i8]* %t697 to i8*
  %t699 = bitcast i8* %t698 to i8**
  %t700 = load i8*, i8** %t699
  %t701 = icmp eq i32 %t683, 6
  %t702 = select i1 %t701, i8* %t700, i8* %t696
  %t703 = getelementptr inbounds %Statement, %Statement* %t684, i32 0, i32 1
  %t704 = bitcast [56 x i8]* %t703 to i8*
  %t705 = bitcast i8* %t704 to i8**
  %t706 = load i8*, i8** %t705
  %t707 = icmp eq i32 %t683, 8
  %t708 = select i1 %t707, i8* %t706, i8* %t702
  %t709 = getelementptr inbounds %Statement, %Statement* %t684, i32 0, i32 1
  %t710 = bitcast [40 x i8]* %t709 to i8*
  %t711 = bitcast i8* %t710 to i8**
  %t712 = load i8*, i8** %t711
  %t713 = icmp eq i32 %t683, 9
  %t714 = select i1 %t713, i8* %t712, i8* %t708
  %t715 = getelementptr inbounds %Statement, %Statement* %t684, i32 0, i32 1
  %t716 = bitcast [40 x i8]* %t715 to i8*
  %t717 = bitcast i8* %t716 to i8**
  %t718 = load i8*, i8** %t717
  %t719 = icmp eq i32 %t683, 10
  %t720 = select i1 %t719, i8* %t718, i8* %t714
  %t721 = getelementptr inbounds %Statement, %Statement* %t684, i32 0, i32 1
  %t722 = bitcast [40 x i8]* %t721 to i8*
  %t723 = bitcast i8* %t722 to i8**
  %t724 = load i8*, i8** %t723
  %t725 = icmp eq i32 %t683, 11
  %t726 = select i1 %t725, i8* %t724, i8* %t720
  %s727 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.727, i32 0, i32 0
  %t728 = extractvalue %Statement %statement, 0
  %t729 = alloca %Statement
  store %Statement %statement, %Statement* %t729
  %t730 = getelementptr inbounds %Statement, %Statement* %t729, i32 0, i32 1
  %t731 = bitcast [48 x i8]* %t730 to i8*
  %t732 = getelementptr inbounds i8, i8* %t731, i64 8
  %t733 = bitcast i8* %t732 to %SourceSpan**
  %t734 = load %SourceSpan*, %SourceSpan** %t733
  %t735 = icmp eq i32 %t728, 3
  %t736 = select i1 %t735, %SourceSpan* %t734, %SourceSpan* null
  %t737 = getelementptr inbounds %Statement, %Statement* %t729, i32 0, i32 1
  %t738 = bitcast [40 x i8]* %t737 to i8*
  %t739 = getelementptr inbounds i8, i8* %t738, i64 8
  %t740 = bitcast i8* %t739 to %SourceSpan**
  %t741 = load %SourceSpan*, %SourceSpan** %t740
  %t742 = icmp eq i32 %t728, 6
  %t743 = select i1 %t742, %SourceSpan* %t741, %SourceSpan* %t736
  %t744 = getelementptr inbounds %Statement, %Statement* %t729, i32 0, i32 1
  %t745 = bitcast [56 x i8]* %t744 to i8*
  %t746 = getelementptr inbounds i8, i8* %t745, i64 8
  %t747 = bitcast i8* %t746 to %SourceSpan**
  %t748 = load %SourceSpan*, %SourceSpan** %t747
  %t749 = icmp eq i32 %t728, 8
  %t750 = select i1 %t749, %SourceSpan* %t748, %SourceSpan* %t743
  %t751 = getelementptr inbounds %Statement, %Statement* %t729, i32 0, i32 1
  %t752 = bitcast [40 x i8]* %t751 to i8*
  %t753 = getelementptr inbounds i8, i8* %t752, i64 8
  %t754 = bitcast i8* %t753 to %SourceSpan**
  %t755 = load %SourceSpan*, %SourceSpan** %t754
  %t756 = icmp eq i32 %t728, 9
  %t757 = select i1 %t756, %SourceSpan* %t755, %SourceSpan* %t750
  %t758 = getelementptr inbounds %Statement, %Statement* %t729, i32 0, i32 1
  %t759 = bitcast [40 x i8]* %t758 to i8*
  %t760 = getelementptr inbounds i8, i8* %t759, i64 8
  %t761 = bitcast i8* %t760 to %SourceSpan**
  %t762 = load %SourceSpan*, %SourceSpan** %t761
  %t763 = icmp eq i32 %t728, 10
  %t764 = select i1 %t763, %SourceSpan* %t762, %SourceSpan* %t757
  %t765 = getelementptr inbounds %Statement, %Statement* %t729, i32 0, i32 1
  %t766 = bitcast [40 x i8]* %t765 to i8*
  %t767 = getelementptr inbounds i8, i8* %t766, i64 8
  %t768 = bitcast i8* %t767 to %SourceSpan**
  %t769 = load %SourceSpan*, %SourceSpan** %t768
  %t770 = icmp eq i32 %t728, 11
  %t771 = select i1 %t770, %SourceSpan* %t769, %SourceSpan* %t764
  %t772 = bitcast %SourceSpan* %t771 to i8*
  %t773 = call %SymbolCollectionResult @register_symbol(i8* %t726, i8* %s727, i8* %t772, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t773
merge9:
  %t774 = extractvalue %Statement %statement, 0
  %t775 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t776 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t777 = icmp eq i32 %t774, 0
  %t778 = select i1 %t777, i8* %t776, i8* %t775
  %t779 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t780 = icmp eq i32 %t774, 1
  %t781 = select i1 %t780, i8* %t779, i8* %t778
  %t782 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t783 = icmp eq i32 %t774, 2
  %t784 = select i1 %t783, i8* %t782, i8* %t781
  %t785 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t786 = icmp eq i32 %t774, 3
  %t787 = select i1 %t786, i8* %t785, i8* %t784
  %t788 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t789 = icmp eq i32 %t774, 4
  %t790 = select i1 %t789, i8* %t788, i8* %t787
  %t791 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t792 = icmp eq i32 %t774, 5
  %t793 = select i1 %t792, i8* %t791, i8* %t790
  %t794 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t795 = icmp eq i32 %t774, 6
  %t796 = select i1 %t795, i8* %t794, i8* %t793
  %t797 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t798 = icmp eq i32 %t774, 7
  %t799 = select i1 %t798, i8* %t797, i8* %t796
  %t800 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t801 = icmp eq i32 %t774, 8
  %t802 = select i1 %t801, i8* %t800, i8* %t799
  %t803 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t804 = icmp eq i32 %t774, 9
  %t805 = select i1 %t804, i8* %t803, i8* %t802
  %t806 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t807 = icmp eq i32 %t774, 10
  %t808 = select i1 %t807, i8* %t806, i8* %t805
  %t809 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t810 = icmp eq i32 %t774, 11
  %t811 = select i1 %t810, i8* %t809, i8* %t808
  %t812 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t813 = icmp eq i32 %t774, 12
  %t814 = select i1 %t813, i8* %t812, i8* %t811
  %t815 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t816 = icmp eq i32 %t774, 13
  %t817 = select i1 %t816, i8* %t815, i8* %t814
  %t818 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t819 = icmp eq i32 %t774, 14
  %t820 = select i1 %t819, i8* %t818, i8* %t817
  %t821 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t822 = icmp eq i32 %t774, 15
  %t823 = select i1 %t822, i8* %t821, i8* %t820
  %t824 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t825 = icmp eq i32 %t774, 16
  %t826 = select i1 %t825, i8* %t824, i8* %t823
  %t827 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t828 = icmp eq i32 %t774, 17
  %t829 = select i1 %t828, i8* %t827, i8* %t826
  %t830 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t831 = icmp eq i32 %t774, 18
  %t832 = select i1 %t831, i8* %t830, i8* %t829
  %t833 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t834 = icmp eq i32 %t774, 19
  %t835 = select i1 %t834, i8* %t833, i8* %t832
  %t836 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t837 = icmp eq i32 %t774, 20
  %t838 = select i1 %t837, i8* %t836, i8* %t835
  %t839 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t840 = icmp eq i32 %t774, 21
  %t841 = select i1 %t840, i8* %t839, i8* %t838
  %t842 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t843 = icmp eq i32 %t774, 22
  %t844 = select i1 %t843, i8* %t842, i8* %t841
  %s845 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.845, i32 0, i32 0
  %t846 = icmp eq i8* %t844, %s845
  br i1 %t846, label %then10, label %merge11
then10:
  %t847 = extractvalue %Statement %statement, 0
  %t848 = alloca %Statement
  store %Statement %statement, %Statement* %t848
  %t849 = getelementptr inbounds %Statement, %Statement* %t848, i32 0, i32 1
  %t850 = bitcast [24 x i8]* %t849 to i8*
  %t851 = bitcast i8* %t850 to %FunctionSignature*
  %t852 = load %FunctionSignature, %FunctionSignature* %t851
  %t853 = icmp eq i32 %t847, 4
  %t854 = select i1 %t853, %FunctionSignature %t852, %FunctionSignature zeroinitializer
  %t855 = getelementptr inbounds %Statement, %Statement* %t848, i32 0, i32 1
  %t856 = bitcast [24 x i8]* %t855 to i8*
  %t857 = bitcast i8* %t856 to %FunctionSignature*
  %t858 = load %FunctionSignature, %FunctionSignature* %t857
  %t859 = icmp eq i32 %t847, 5
  %t860 = select i1 %t859, %FunctionSignature %t858, %FunctionSignature %t854
  %t861 = getelementptr inbounds %Statement, %Statement* %t848, i32 0, i32 1
  %t862 = bitcast [24 x i8]* %t861 to i8*
  %t863 = bitcast i8* %t862 to %FunctionSignature*
  %t864 = load %FunctionSignature, %FunctionSignature* %t863
  %t865 = icmp eq i32 %t847, 7
  %t866 = select i1 %t865, %FunctionSignature %t864, %FunctionSignature %t860
  %t867 = extractvalue %FunctionSignature %t866, 0
  %s868 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.868, i32 0, i32 0
  %t869 = extractvalue %Statement %statement, 0
  %t870 = alloca %Statement
  store %Statement %statement, %Statement* %t870
  %t871 = getelementptr inbounds %Statement, %Statement* %t870, i32 0, i32 1
  %t872 = bitcast [24 x i8]* %t871 to i8*
  %t873 = bitcast i8* %t872 to %FunctionSignature*
  %t874 = load %FunctionSignature, %FunctionSignature* %t873
  %t875 = icmp eq i32 %t869, 4
  %t876 = select i1 %t875, %FunctionSignature %t874, %FunctionSignature zeroinitializer
  %t877 = getelementptr inbounds %Statement, %Statement* %t870, i32 0, i32 1
  %t878 = bitcast [24 x i8]* %t877 to i8*
  %t879 = bitcast i8* %t878 to %FunctionSignature*
  %t880 = load %FunctionSignature, %FunctionSignature* %t879
  %t881 = icmp eq i32 %t869, 5
  %t882 = select i1 %t881, %FunctionSignature %t880, %FunctionSignature %t876
  %t883 = getelementptr inbounds %Statement, %Statement* %t870, i32 0, i32 1
  %t884 = bitcast [24 x i8]* %t883 to i8*
  %t885 = bitcast i8* %t884 to %FunctionSignature*
  %t886 = load %FunctionSignature, %FunctionSignature* %t885
  %t887 = icmp eq i32 %t869, 7
  %t888 = select i1 %t887, %FunctionSignature %t886, %FunctionSignature %t882
  %t889 = extractvalue %FunctionSignature %t888, 6
  %t890 = bitcast %SourceSpan* %t889 to i8*
  %t891 = call %SymbolCollectionResult @register_symbol(i8* %t867, i8* %s868, i8* %t890, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t891
merge11:
  %t892 = extractvalue %Statement %statement, 0
  %t893 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t894 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t895 = icmp eq i32 %t892, 0
  %t896 = select i1 %t895, i8* %t894, i8* %t893
  %t897 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t898 = icmp eq i32 %t892, 1
  %t899 = select i1 %t898, i8* %t897, i8* %t896
  %t900 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t901 = icmp eq i32 %t892, 2
  %t902 = select i1 %t901, i8* %t900, i8* %t899
  %t903 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t904 = icmp eq i32 %t892, 3
  %t905 = select i1 %t904, i8* %t903, i8* %t902
  %t906 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t907 = icmp eq i32 %t892, 4
  %t908 = select i1 %t907, i8* %t906, i8* %t905
  %t909 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t910 = icmp eq i32 %t892, 5
  %t911 = select i1 %t910, i8* %t909, i8* %t908
  %t912 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t913 = icmp eq i32 %t892, 6
  %t914 = select i1 %t913, i8* %t912, i8* %t911
  %t915 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t916 = icmp eq i32 %t892, 7
  %t917 = select i1 %t916, i8* %t915, i8* %t914
  %t918 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t919 = icmp eq i32 %t892, 8
  %t920 = select i1 %t919, i8* %t918, i8* %t917
  %t921 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t922 = icmp eq i32 %t892, 9
  %t923 = select i1 %t922, i8* %t921, i8* %t920
  %t924 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t925 = icmp eq i32 %t892, 10
  %t926 = select i1 %t925, i8* %t924, i8* %t923
  %t927 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t928 = icmp eq i32 %t892, 11
  %t929 = select i1 %t928, i8* %t927, i8* %t926
  %t930 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t931 = icmp eq i32 %t892, 12
  %t932 = select i1 %t931, i8* %t930, i8* %t929
  %t933 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t934 = icmp eq i32 %t892, 13
  %t935 = select i1 %t934, i8* %t933, i8* %t932
  %t936 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t937 = icmp eq i32 %t892, 14
  %t938 = select i1 %t937, i8* %t936, i8* %t935
  %t939 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t940 = icmp eq i32 %t892, 15
  %t941 = select i1 %t940, i8* %t939, i8* %t938
  %t942 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t943 = icmp eq i32 %t892, 16
  %t944 = select i1 %t943, i8* %t942, i8* %t941
  %t945 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t946 = icmp eq i32 %t892, 17
  %t947 = select i1 %t946, i8* %t945, i8* %t944
  %t948 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t949 = icmp eq i32 %t892, 18
  %t950 = select i1 %t949, i8* %t948, i8* %t947
  %t951 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t952 = icmp eq i32 %t892, 19
  %t953 = select i1 %t952, i8* %t951, i8* %t950
  %t954 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t955 = icmp eq i32 %t892, 20
  %t956 = select i1 %t955, i8* %t954, i8* %t953
  %t957 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t958 = icmp eq i32 %t892, 21
  %t959 = select i1 %t958, i8* %t957, i8* %t956
  %t960 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t961 = icmp eq i32 %t892, 22
  %t962 = select i1 %t961, i8* %t960, i8* %t959
  %s963 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.963, i32 0, i32 0
  %t964 = icmp eq i8* %t962, %s963
  br i1 %t964, label %then12, label %merge13
then12:
  %t965 = extractvalue %Statement %statement, 0
  %t966 = alloca %Statement
  store %Statement %statement, %Statement* %t966
  %t967 = getelementptr inbounds %Statement, %Statement* %t966, i32 0, i32 1
  %t968 = bitcast [24 x i8]* %t967 to i8*
  %t969 = bitcast i8* %t968 to %FunctionSignature*
  %t970 = load %FunctionSignature, %FunctionSignature* %t969
  %t971 = icmp eq i32 %t965, 4
  %t972 = select i1 %t971, %FunctionSignature %t970, %FunctionSignature zeroinitializer
  %t973 = getelementptr inbounds %Statement, %Statement* %t966, i32 0, i32 1
  %t974 = bitcast [24 x i8]* %t973 to i8*
  %t975 = bitcast i8* %t974 to %FunctionSignature*
  %t976 = load %FunctionSignature, %FunctionSignature* %t975
  %t977 = icmp eq i32 %t965, 5
  %t978 = select i1 %t977, %FunctionSignature %t976, %FunctionSignature %t972
  %t979 = getelementptr inbounds %Statement, %Statement* %t966, i32 0, i32 1
  %t980 = bitcast [24 x i8]* %t979 to i8*
  %t981 = bitcast i8* %t980 to %FunctionSignature*
  %t982 = load %FunctionSignature, %FunctionSignature* %t981
  %t983 = icmp eq i32 %t965, 7
  %t984 = select i1 %t983, %FunctionSignature %t982, %FunctionSignature %t978
  %t985 = extractvalue %FunctionSignature %t984, 0
  %s986 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.986, i32 0, i32 0
  %t987 = extractvalue %Statement %statement, 0
  %t988 = alloca %Statement
  store %Statement %statement, %Statement* %t988
  %t989 = getelementptr inbounds %Statement, %Statement* %t988, i32 0, i32 1
  %t990 = bitcast [24 x i8]* %t989 to i8*
  %t991 = bitcast i8* %t990 to %FunctionSignature*
  %t992 = load %FunctionSignature, %FunctionSignature* %t991
  %t993 = icmp eq i32 %t987, 4
  %t994 = select i1 %t993, %FunctionSignature %t992, %FunctionSignature zeroinitializer
  %t995 = getelementptr inbounds %Statement, %Statement* %t988, i32 0, i32 1
  %t996 = bitcast [24 x i8]* %t995 to i8*
  %t997 = bitcast i8* %t996 to %FunctionSignature*
  %t998 = load %FunctionSignature, %FunctionSignature* %t997
  %t999 = icmp eq i32 %t987, 5
  %t1000 = select i1 %t999, %FunctionSignature %t998, %FunctionSignature %t994
  %t1001 = getelementptr inbounds %Statement, %Statement* %t988, i32 0, i32 1
  %t1002 = bitcast [24 x i8]* %t1001 to i8*
  %t1003 = bitcast i8* %t1002 to %FunctionSignature*
  %t1004 = load %FunctionSignature, %FunctionSignature* %t1003
  %t1005 = icmp eq i32 %t987, 7
  %t1006 = select i1 %t1005, %FunctionSignature %t1004, %FunctionSignature %t1000
  %t1007 = extractvalue %FunctionSignature %t1006, 6
  %t1008 = bitcast %SourceSpan* %t1007 to i8*
  %t1009 = call %SymbolCollectionResult @register_symbol(i8* %t985, i8* %s986, i8* %t1008, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1009
merge13:
  %t1010 = extractvalue %Statement %statement, 0
  %t1011 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1012 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1013 = icmp eq i32 %t1010, 0
  %t1014 = select i1 %t1013, i8* %t1012, i8* %t1011
  %t1015 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1016 = icmp eq i32 %t1010, 1
  %t1017 = select i1 %t1016, i8* %t1015, i8* %t1014
  %t1018 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1019 = icmp eq i32 %t1010, 2
  %t1020 = select i1 %t1019, i8* %t1018, i8* %t1017
  %t1021 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1022 = icmp eq i32 %t1010, 3
  %t1023 = select i1 %t1022, i8* %t1021, i8* %t1020
  %t1024 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1025 = icmp eq i32 %t1010, 4
  %t1026 = select i1 %t1025, i8* %t1024, i8* %t1023
  %t1027 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1028 = icmp eq i32 %t1010, 5
  %t1029 = select i1 %t1028, i8* %t1027, i8* %t1026
  %t1030 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1031 = icmp eq i32 %t1010, 6
  %t1032 = select i1 %t1031, i8* %t1030, i8* %t1029
  %t1033 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1034 = icmp eq i32 %t1010, 7
  %t1035 = select i1 %t1034, i8* %t1033, i8* %t1032
  %t1036 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1037 = icmp eq i32 %t1010, 8
  %t1038 = select i1 %t1037, i8* %t1036, i8* %t1035
  %t1039 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1040 = icmp eq i32 %t1010, 9
  %t1041 = select i1 %t1040, i8* %t1039, i8* %t1038
  %t1042 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1043 = icmp eq i32 %t1010, 10
  %t1044 = select i1 %t1043, i8* %t1042, i8* %t1041
  %t1045 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1046 = icmp eq i32 %t1010, 11
  %t1047 = select i1 %t1046, i8* %t1045, i8* %t1044
  %t1048 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1049 = icmp eq i32 %t1010, 12
  %t1050 = select i1 %t1049, i8* %t1048, i8* %t1047
  %t1051 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1052 = icmp eq i32 %t1010, 13
  %t1053 = select i1 %t1052, i8* %t1051, i8* %t1050
  %t1054 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1055 = icmp eq i32 %t1010, 14
  %t1056 = select i1 %t1055, i8* %t1054, i8* %t1053
  %t1057 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1058 = icmp eq i32 %t1010, 15
  %t1059 = select i1 %t1058, i8* %t1057, i8* %t1056
  %t1060 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1061 = icmp eq i32 %t1010, 16
  %t1062 = select i1 %t1061, i8* %t1060, i8* %t1059
  %t1063 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1064 = icmp eq i32 %t1010, 17
  %t1065 = select i1 %t1064, i8* %t1063, i8* %t1062
  %t1066 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1067 = icmp eq i32 %t1010, 18
  %t1068 = select i1 %t1067, i8* %t1066, i8* %t1065
  %t1069 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1070 = icmp eq i32 %t1010, 19
  %t1071 = select i1 %t1070, i8* %t1069, i8* %t1068
  %t1072 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1073 = icmp eq i32 %t1010, 20
  %t1074 = select i1 %t1073, i8* %t1072, i8* %t1071
  %t1075 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1076 = icmp eq i32 %t1010, 21
  %t1077 = select i1 %t1076, i8* %t1075, i8* %t1074
  %t1078 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1079 = icmp eq i32 %t1010, 22
  %t1080 = select i1 %t1079, i8* %t1078, i8* %t1077
  %s1081 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1081, i32 0, i32 0
  %t1082 = icmp eq i8* %t1080, %s1081
  br i1 %t1082, label %then14, label %merge15
then14:
  %t1083 = extractvalue %Statement %statement, 0
  %t1084 = alloca %Statement
  store %Statement %statement, %Statement* %t1084
  %t1085 = getelementptr inbounds %Statement, %Statement* %t1084, i32 0, i32 1
  %t1086 = bitcast [48 x i8]* %t1085 to i8*
  %t1087 = bitcast i8* %t1086 to i8**
  %t1088 = load i8*, i8** %t1087
  %t1089 = icmp eq i32 %t1083, 2
  %t1090 = select i1 %t1089, i8* %t1088, i8* null
  %t1091 = getelementptr inbounds %Statement, %Statement* %t1084, i32 0, i32 1
  %t1092 = bitcast [48 x i8]* %t1091 to i8*
  %t1093 = bitcast i8* %t1092 to i8**
  %t1094 = load i8*, i8** %t1093
  %t1095 = icmp eq i32 %t1083, 3
  %t1096 = select i1 %t1095, i8* %t1094, i8* %t1090
  %t1097 = getelementptr inbounds %Statement, %Statement* %t1084, i32 0, i32 1
  %t1098 = bitcast [40 x i8]* %t1097 to i8*
  %t1099 = bitcast i8* %t1098 to i8**
  %t1100 = load i8*, i8** %t1099
  %t1101 = icmp eq i32 %t1083, 6
  %t1102 = select i1 %t1101, i8* %t1100, i8* %t1096
  %t1103 = getelementptr inbounds %Statement, %Statement* %t1084, i32 0, i32 1
  %t1104 = bitcast [56 x i8]* %t1103 to i8*
  %t1105 = bitcast i8* %t1104 to i8**
  %t1106 = load i8*, i8** %t1105
  %t1107 = icmp eq i32 %t1083, 8
  %t1108 = select i1 %t1107, i8* %t1106, i8* %t1102
  %t1109 = getelementptr inbounds %Statement, %Statement* %t1084, i32 0, i32 1
  %t1110 = bitcast [40 x i8]* %t1109 to i8*
  %t1111 = bitcast i8* %t1110 to i8**
  %t1112 = load i8*, i8** %t1111
  %t1113 = icmp eq i32 %t1083, 9
  %t1114 = select i1 %t1113, i8* %t1112, i8* %t1108
  %t1115 = getelementptr inbounds %Statement, %Statement* %t1084, i32 0, i32 1
  %t1116 = bitcast [40 x i8]* %t1115 to i8*
  %t1117 = bitcast i8* %t1116 to i8**
  %t1118 = load i8*, i8** %t1117
  %t1119 = icmp eq i32 %t1083, 10
  %t1120 = select i1 %t1119, i8* %t1118, i8* %t1114
  %t1121 = getelementptr inbounds %Statement, %Statement* %t1084, i32 0, i32 1
  %t1122 = bitcast [40 x i8]* %t1121 to i8*
  %t1123 = bitcast i8* %t1122 to i8**
  %t1124 = load i8*, i8** %t1123
  %t1125 = icmp eq i32 %t1083, 11
  %t1126 = select i1 %t1125, i8* %t1124, i8* %t1120
  %s1127 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1127, i32 0, i32 0
  %t1128 = extractvalue %Statement %statement, 0
  %t1129 = alloca %Statement
  store %Statement %statement, %Statement* %t1129
  %t1130 = getelementptr inbounds %Statement, %Statement* %t1129, i32 0, i32 1
  %t1131 = bitcast [48 x i8]* %t1130 to i8*
  %t1132 = getelementptr inbounds i8, i8* %t1131, i64 8
  %t1133 = bitcast i8* %t1132 to %SourceSpan**
  %t1134 = load %SourceSpan*, %SourceSpan** %t1133
  %t1135 = icmp eq i32 %t1128, 3
  %t1136 = select i1 %t1135, %SourceSpan* %t1134, %SourceSpan* null
  %t1137 = getelementptr inbounds %Statement, %Statement* %t1129, i32 0, i32 1
  %t1138 = bitcast [40 x i8]* %t1137 to i8*
  %t1139 = getelementptr inbounds i8, i8* %t1138, i64 8
  %t1140 = bitcast i8* %t1139 to %SourceSpan**
  %t1141 = load %SourceSpan*, %SourceSpan** %t1140
  %t1142 = icmp eq i32 %t1128, 6
  %t1143 = select i1 %t1142, %SourceSpan* %t1141, %SourceSpan* %t1136
  %t1144 = getelementptr inbounds %Statement, %Statement* %t1129, i32 0, i32 1
  %t1145 = bitcast [56 x i8]* %t1144 to i8*
  %t1146 = getelementptr inbounds i8, i8* %t1145, i64 8
  %t1147 = bitcast i8* %t1146 to %SourceSpan**
  %t1148 = load %SourceSpan*, %SourceSpan** %t1147
  %t1149 = icmp eq i32 %t1128, 8
  %t1150 = select i1 %t1149, %SourceSpan* %t1148, %SourceSpan* %t1143
  %t1151 = getelementptr inbounds %Statement, %Statement* %t1129, i32 0, i32 1
  %t1152 = bitcast [40 x i8]* %t1151 to i8*
  %t1153 = getelementptr inbounds i8, i8* %t1152, i64 8
  %t1154 = bitcast i8* %t1153 to %SourceSpan**
  %t1155 = load %SourceSpan*, %SourceSpan** %t1154
  %t1156 = icmp eq i32 %t1128, 9
  %t1157 = select i1 %t1156, %SourceSpan* %t1155, %SourceSpan* %t1150
  %t1158 = getelementptr inbounds %Statement, %Statement* %t1129, i32 0, i32 1
  %t1159 = bitcast [40 x i8]* %t1158 to i8*
  %t1160 = getelementptr inbounds i8, i8* %t1159, i64 8
  %t1161 = bitcast i8* %t1160 to %SourceSpan**
  %t1162 = load %SourceSpan*, %SourceSpan** %t1161
  %t1163 = icmp eq i32 %t1128, 10
  %t1164 = select i1 %t1163, %SourceSpan* %t1162, %SourceSpan* %t1157
  %t1165 = getelementptr inbounds %Statement, %Statement* %t1129, i32 0, i32 1
  %t1166 = bitcast [40 x i8]* %t1165 to i8*
  %t1167 = getelementptr inbounds i8, i8* %t1166, i64 8
  %t1168 = bitcast i8* %t1167 to %SourceSpan**
  %t1169 = load %SourceSpan*, %SourceSpan** %t1168
  %t1170 = icmp eq i32 %t1128, 11
  %t1171 = select i1 %t1170, %SourceSpan* %t1169, %SourceSpan* %t1164
  %t1172 = bitcast %SourceSpan* %t1171 to i8*
  %t1173 = call %SymbolCollectionResult @register_symbol(i8* %t1126, i8* %s1127, i8* %t1172, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1173
merge15:
  %t1174 = extractvalue %Statement %statement, 0
  %t1175 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1176 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1177 = icmp eq i32 %t1174, 0
  %t1178 = select i1 %t1177, i8* %t1176, i8* %t1175
  %t1179 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1180 = icmp eq i32 %t1174, 1
  %t1181 = select i1 %t1180, i8* %t1179, i8* %t1178
  %t1182 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1183 = icmp eq i32 %t1174, 2
  %t1184 = select i1 %t1183, i8* %t1182, i8* %t1181
  %t1185 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1186 = icmp eq i32 %t1174, 3
  %t1187 = select i1 %t1186, i8* %t1185, i8* %t1184
  %t1188 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1189 = icmp eq i32 %t1174, 4
  %t1190 = select i1 %t1189, i8* %t1188, i8* %t1187
  %t1191 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1192 = icmp eq i32 %t1174, 5
  %t1193 = select i1 %t1192, i8* %t1191, i8* %t1190
  %t1194 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1195 = icmp eq i32 %t1174, 6
  %t1196 = select i1 %t1195, i8* %t1194, i8* %t1193
  %t1197 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1198 = icmp eq i32 %t1174, 7
  %t1199 = select i1 %t1198, i8* %t1197, i8* %t1196
  %t1200 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1201 = icmp eq i32 %t1174, 8
  %t1202 = select i1 %t1201, i8* %t1200, i8* %t1199
  %t1203 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1204 = icmp eq i32 %t1174, 9
  %t1205 = select i1 %t1204, i8* %t1203, i8* %t1202
  %t1206 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1207 = icmp eq i32 %t1174, 10
  %t1208 = select i1 %t1207, i8* %t1206, i8* %t1205
  %t1209 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1210 = icmp eq i32 %t1174, 11
  %t1211 = select i1 %t1210, i8* %t1209, i8* %t1208
  %t1212 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1213 = icmp eq i32 %t1174, 12
  %t1214 = select i1 %t1213, i8* %t1212, i8* %t1211
  %t1215 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1216 = icmp eq i32 %t1174, 13
  %t1217 = select i1 %t1216, i8* %t1215, i8* %t1214
  %t1218 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1219 = icmp eq i32 %t1174, 14
  %t1220 = select i1 %t1219, i8* %t1218, i8* %t1217
  %t1221 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1222 = icmp eq i32 %t1174, 15
  %t1223 = select i1 %t1222, i8* %t1221, i8* %t1220
  %t1224 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1225 = icmp eq i32 %t1174, 16
  %t1226 = select i1 %t1225, i8* %t1224, i8* %t1223
  %t1227 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1228 = icmp eq i32 %t1174, 17
  %t1229 = select i1 %t1228, i8* %t1227, i8* %t1226
  %t1230 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1231 = icmp eq i32 %t1174, 18
  %t1232 = select i1 %t1231, i8* %t1230, i8* %t1229
  %t1233 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1234 = icmp eq i32 %t1174, 19
  %t1235 = select i1 %t1234, i8* %t1233, i8* %t1232
  %t1236 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1237 = icmp eq i32 %t1174, 20
  %t1238 = select i1 %t1237, i8* %t1236, i8* %t1235
  %t1239 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1240 = icmp eq i32 %t1174, 21
  %t1241 = select i1 %t1240, i8* %t1239, i8* %t1238
  %t1242 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1243 = icmp eq i32 %t1174, 22
  %t1244 = select i1 %t1243, i8* %t1242, i8* %t1241
  %s1245 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.1245, i32 0, i32 0
  %t1246 = icmp eq i8* %t1244, %s1245
  br i1 %t1246, label %then16, label %merge17
then16:
  %t1247 = extractvalue %Statement %statement, 0
  %t1248 = alloca %Statement
  store %Statement %statement, %Statement* %t1248
  %t1249 = getelementptr inbounds %Statement, %Statement* %t1248, i32 0, i32 1
  %t1250 = bitcast [48 x i8]* %t1249 to i8*
  %t1251 = bitcast i8* %t1250 to i8**
  %t1252 = load i8*, i8** %t1251
  %t1253 = icmp eq i32 %t1247, 2
  %t1254 = select i1 %t1253, i8* %t1252, i8* null
  %t1255 = getelementptr inbounds %Statement, %Statement* %t1248, i32 0, i32 1
  %t1256 = bitcast [48 x i8]* %t1255 to i8*
  %t1257 = bitcast i8* %t1256 to i8**
  %t1258 = load i8*, i8** %t1257
  %t1259 = icmp eq i32 %t1247, 3
  %t1260 = select i1 %t1259, i8* %t1258, i8* %t1254
  %t1261 = getelementptr inbounds %Statement, %Statement* %t1248, i32 0, i32 1
  %t1262 = bitcast [40 x i8]* %t1261 to i8*
  %t1263 = bitcast i8* %t1262 to i8**
  %t1264 = load i8*, i8** %t1263
  %t1265 = icmp eq i32 %t1247, 6
  %t1266 = select i1 %t1265, i8* %t1264, i8* %t1260
  %t1267 = getelementptr inbounds %Statement, %Statement* %t1248, i32 0, i32 1
  %t1268 = bitcast [56 x i8]* %t1267 to i8*
  %t1269 = bitcast i8* %t1268 to i8**
  %t1270 = load i8*, i8** %t1269
  %t1271 = icmp eq i32 %t1247, 8
  %t1272 = select i1 %t1271, i8* %t1270, i8* %t1266
  %t1273 = getelementptr inbounds %Statement, %Statement* %t1248, i32 0, i32 1
  %t1274 = bitcast [40 x i8]* %t1273 to i8*
  %t1275 = bitcast i8* %t1274 to i8**
  %t1276 = load i8*, i8** %t1275
  %t1277 = icmp eq i32 %t1247, 9
  %t1278 = select i1 %t1277, i8* %t1276, i8* %t1272
  %t1279 = getelementptr inbounds %Statement, %Statement* %t1248, i32 0, i32 1
  %t1280 = bitcast [40 x i8]* %t1279 to i8*
  %t1281 = bitcast i8* %t1280 to i8**
  %t1282 = load i8*, i8** %t1281
  %t1283 = icmp eq i32 %t1247, 10
  %t1284 = select i1 %t1283, i8* %t1282, i8* %t1278
  %t1285 = getelementptr inbounds %Statement, %Statement* %t1248, i32 0, i32 1
  %t1286 = bitcast [40 x i8]* %t1285 to i8*
  %t1287 = bitcast i8* %t1286 to i8**
  %t1288 = load i8*, i8** %t1287
  %t1289 = icmp eq i32 %t1247, 11
  %t1290 = select i1 %t1289, i8* %t1288, i8* %t1284
  %s1291 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1291, i32 0, i32 0
  %t1292 = extractvalue %Statement %statement, 0
  %t1293 = alloca %Statement
  store %Statement %statement, %Statement* %t1293
  %t1294 = getelementptr inbounds %Statement, %Statement* %t1293, i32 0, i32 1
  %t1295 = bitcast [48 x i8]* %t1294 to i8*
  %t1296 = getelementptr inbounds i8, i8* %t1295, i64 8
  %t1297 = bitcast i8* %t1296 to %SourceSpan**
  %t1298 = load %SourceSpan*, %SourceSpan** %t1297
  %t1299 = icmp eq i32 %t1292, 3
  %t1300 = select i1 %t1299, %SourceSpan* %t1298, %SourceSpan* null
  %t1301 = getelementptr inbounds %Statement, %Statement* %t1293, i32 0, i32 1
  %t1302 = bitcast [40 x i8]* %t1301 to i8*
  %t1303 = getelementptr inbounds i8, i8* %t1302, i64 8
  %t1304 = bitcast i8* %t1303 to %SourceSpan**
  %t1305 = load %SourceSpan*, %SourceSpan** %t1304
  %t1306 = icmp eq i32 %t1292, 6
  %t1307 = select i1 %t1306, %SourceSpan* %t1305, %SourceSpan* %t1300
  %t1308 = getelementptr inbounds %Statement, %Statement* %t1293, i32 0, i32 1
  %t1309 = bitcast [56 x i8]* %t1308 to i8*
  %t1310 = getelementptr inbounds i8, i8* %t1309, i64 8
  %t1311 = bitcast i8* %t1310 to %SourceSpan**
  %t1312 = load %SourceSpan*, %SourceSpan** %t1311
  %t1313 = icmp eq i32 %t1292, 8
  %t1314 = select i1 %t1313, %SourceSpan* %t1312, %SourceSpan* %t1307
  %t1315 = getelementptr inbounds %Statement, %Statement* %t1293, i32 0, i32 1
  %t1316 = bitcast [40 x i8]* %t1315 to i8*
  %t1317 = getelementptr inbounds i8, i8* %t1316, i64 8
  %t1318 = bitcast i8* %t1317 to %SourceSpan**
  %t1319 = load %SourceSpan*, %SourceSpan** %t1318
  %t1320 = icmp eq i32 %t1292, 9
  %t1321 = select i1 %t1320, %SourceSpan* %t1319, %SourceSpan* %t1314
  %t1322 = getelementptr inbounds %Statement, %Statement* %t1293, i32 0, i32 1
  %t1323 = bitcast [40 x i8]* %t1322 to i8*
  %t1324 = getelementptr inbounds i8, i8* %t1323, i64 8
  %t1325 = bitcast i8* %t1324 to %SourceSpan**
  %t1326 = load %SourceSpan*, %SourceSpan** %t1325
  %t1327 = icmp eq i32 %t1292, 10
  %t1328 = select i1 %t1327, %SourceSpan* %t1326, %SourceSpan* %t1321
  %t1329 = getelementptr inbounds %Statement, %Statement* %t1293, i32 0, i32 1
  %t1330 = bitcast [40 x i8]* %t1329 to i8*
  %t1331 = getelementptr inbounds i8, i8* %t1330, i64 8
  %t1332 = bitcast i8* %t1331 to %SourceSpan**
  %t1333 = load %SourceSpan*, %SourceSpan** %t1332
  %t1334 = icmp eq i32 %t1292, 11
  %t1335 = select i1 %t1334, %SourceSpan* %t1333, %SourceSpan* %t1328
  %t1336 = bitcast %SourceSpan* %t1335 to i8*
  %t1337 = call %SymbolCollectionResult @register_symbol(i8* %t1290, i8* %s1291, i8* %t1336, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1337
merge17:
  %t1338 = extractvalue %Statement %statement, 0
  %t1339 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1340 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1341 = icmp eq i32 %t1338, 0
  %t1342 = select i1 %t1341, i8* %t1340, i8* %t1339
  %t1343 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1344 = icmp eq i32 %t1338, 1
  %t1345 = select i1 %t1344, i8* %t1343, i8* %t1342
  %t1346 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1347 = icmp eq i32 %t1338, 2
  %t1348 = select i1 %t1347, i8* %t1346, i8* %t1345
  %t1349 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1350 = icmp eq i32 %t1338, 3
  %t1351 = select i1 %t1350, i8* %t1349, i8* %t1348
  %t1352 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1353 = icmp eq i32 %t1338, 4
  %t1354 = select i1 %t1353, i8* %t1352, i8* %t1351
  %t1355 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1356 = icmp eq i32 %t1338, 5
  %t1357 = select i1 %t1356, i8* %t1355, i8* %t1354
  %t1358 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1359 = icmp eq i32 %t1338, 6
  %t1360 = select i1 %t1359, i8* %t1358, i8* %t1357
  %t1361 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1362 = icmp eq i32 %t1338, 7
  %t1363 = select i1 %t1362, i8* %t1361, i8* %t1360
  %t1364 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1365 = icmp eq i32 %t1338, 8
  %t1366 = select i1 %t1365, i8* %t1364, i8* %t1363
  %t1367 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1368 = icmp eq i32 %t1338, 9
  %t1369 = select i1 %t1368, i8* %t1367, i8* %t1366
  %t1370 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1371 = icmp eq i32 %t1338, 10
  %t1372 = select i1 %t1371, i8* %t1370, i8* %t1369
  %t1373 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1374 = icmp eq i32 %t1338, 11
  %t1375 = select i1 %t1374, i8* %t1373, i8* %t1372
  %t1376 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1377 = icmp eq i32 %t1338, 12
  %t1378 = select i1 %t1377, i8* %t1376, i8* %t1375
  %t1379 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1380 = icmp eq i32 %t1338, 13
  %t1381 = select i1 %t1380, i8* %t1379, i8* %t1378
  %t1382 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1383 = icmp eq i32 %t1338, 14
  %t1384 = select i1 %t1383, i8* %t1382, i8* %t1381
  %t1385 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1386 = icmp eq i32 %t1338, 15
  %t1387 = select i1 %t1386, i8* %t1385, i8* %t1384
  %t1388 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1389 = icmp eq i32 %t1338, 16
  %t1390 = select i1 %t1389, i8* %t1388, i8* %t1387
  %t1391 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1392 = icmp eq i32 %t1338, 17
  %t1393 = select i1 %t1392, i8* %t1391, i8* %t1390
  %t1394 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1395 = icmp eq i32 %t1338, 18
  %t1396 = select i1 %t1395, i8* %t1394, i8* %t1393
  %t1397 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1398 = icmp eq i32 %t1338, 19
  %t1399 = select i1 %t1398, i8* %t1397, i8* %t1396
  %t1400 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1401 = icmp eq i32 %t1338, 20
  %t1402 = select i1 %t1401, i8* %t1400, i8* %t1399
  %t1403 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1404 = icmp eq i32 %t1338, 21
  %t1405 = select i1 %t1404, i8* %t1403, i8* %t1402
  %t1406 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1407 = icmp eq i32 %t1338, 22
  %t1408 = select i1 %t1407, i8* %t1406, i8* %t1405
  %s1409 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1409, i32 0, i32 0
  %t1410 = icmp eq i8* %t1408, %s1409
  br i1 %t1410, label %then18, label %merge19
then18:
  %t1411 = extractvalue %Statement %statement, 0
  %t1412 = alloca %Statement
  store %Statement %statement, %Statement* %t1412
  %t1413 = getelementptr inbounds %Statement, %Statement* %t1412, i32 0, i32 1
  %t1414 = bitcast [48 x i8]* %t1413 to i8*
  %t1415 = bitcast i8* %t1414 to i8**
  %t1416 = load i8*, i8** %t1415
  %t1417 = icmp eq i32 %t1411, 2
  %t1418 = select i1 %t1417, i8* %t1416, i8* null
  %t1419 = getelementptr inbounds %Statement, %Statement* %t1412, i32 0, i32 1
  %t1420 = bitcast [48 x i8]* %t1419 to i8*
  %t1421 = bitcast i8* %t1420 to i8**
  %t1422 = load i8*, i8** %t1421
  %t1423 = icmp eq i32 %t1411, 3
  %t1424 = select i1 %t1423, i8* %t1422, i8* %t1418
  %t1425 = getelementptr inbounds %Statement, %Statement* %t1412, i32 0, i32 1
  %t1426 = bitcast [40 x i8]* %t1425 to i8*
  %t1427 = bitcast i8* %t1426 to i8**
  %t1428 = load i8*, i8** %t1427
  %t1429 = icmp eq i32 %t1411, 6
  %t1430 = select i1 %t1429, i8* %t1428, i8* %t1424
  %t1431 = getelementptr inbounds %Statement, %Statement* %t1412, i32 0, i32 1
  %t1432 = bitcast [56 x i8]* %t1431 to i8*
  %t1433 = bitcast i8* %t1432 to i8**
  %t1434 = load i8*, i8** %t1433
  %t1435 = icmp eq i32 %t1411, 8
  %t1436 = select i1 %t1435, i8* %t1434, i8* %t1430
  %t1437 = getelementptr inbounds %Statement, %Statement* %t1412, i32 0, i32 1
  %t1438 = bitcast [40 x i8]* %t1437 to i8*
  %t1439 = bitcast i8* %t1438 to i8**
  %t1440 = load i8*, i8** %t1439
  %t1441 = icmp eq i32 %t1411, 9
  %t1442 = select i1 %t1441, i8* %t1440, i8* %t1436
  %t1443 = getelementptr inbounds %Statement, %Statement* %t1412, i32 0, i32 1
  %t1444 = bitcast [40 x i8]* %t1443 to i8*
  %t1445 = bitcast i8* %t1444 to i8**
  %t1446 = load i8*, i8** %t1445
  %t1447 = icmp eq i32 %t1411, 10
  %t1448 = select i1 %t1447, i8* %t1446, i8* %t1442
  %t1449 = getelementptr inbounds %Statement, %Statement* %t1412, i32 0, i32 1
  %t1450 = bitcast [40 x i8]* %t1449 to i8*
  %t1451 = bitcast i8* %t1450 to i8**
  %t1452 = load i8*, i8** %t1451
  %t1453 = icmp eq i32 %t1411, 11
  %t1454 = select i1 %t1453, i8* %t1452, i8* %t1448
  %s1455 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1455, i32 0, i32 0
  %t1456 = extractvalue %Statement %statement, 0
  %t1457 = alloca %Statement
  store %Statement %statement, %Statement* %t1457
  %t1458 = getelementptr inbounds %Statement, %Statement* %t1457, i32 0, i32 1
  %t1459 = bitcast [48 x i8]* %t1458 to i8*
  %t1460 = getelementptr inbounds i8, i8* %t1459, i64 32
  %t1461 = bitcast i8* %t1460 to %SourceSpan**
  %t1462 = load %SourceSpan*, %SourceSpan** %t1461
  %t1463 = icmp eq i32 %t1456, 2
  %t1464 = select i1 %t1463, %SourceSpan* %t1462, %SourceSpan* null
  %t1465 = getelementptr inbounds %Statement, %Statement* %t1457, i32 0, i32 1
  %t1466 = bitcast [16 x i8]* %t1465 to i8*
  %t1467 = getelementptr inbounds i8, i8* %t1466, i64 8
  %t1468 = bitcast i8* %t1467 to %SourceSpan**
  %t1469 = load %SourceSpan*, %SourceSpan** %t1468
  %t1470 = icmp eq i32 %t1456, 20
  %t1471 = select i1 %t1470, %SourceSpan* %t1469, %SourceSpan* %t1464
  %t1472 = getelementptr inbounds %Statement, %Statement* %t1457, i32 0, i32 1
  %t1473 = bitcast [16 x i8]* %t1472 to i8*
  %t1474 = getelementptr inbounds i8, i8* %t1473, i64 8
  %t1475 = bitcast i8* %t1474 to %SourceSpan**
  %t1476 = load %SourceSpan*, %SourceSpan** %t1475
  %t1477 = icmp eq i32 %t1456, 21
  %t1478 = select i1 %t1477, %SourceSpan* %t1476, %SourceSpan* %t1471
  %t1479 = bitcast %SourceSpan* %t1478 to i8*
  %t1480 = call %SymbolCollectionResult @register_symbol(i8* %t1454, i8* %s1455, i8* %t1479, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1480
merge19:
  %t1481 = bitcast { %SymbolEntry*, i64 }* %existing to { %SymbolEntry**, i64 }*
  %t1482 = insertvalue %SymbolCollectionResult undef, { %SymbolEntry**, i64 }* %t1481, 0
  %t1483 = alloca [0 x %Diagnostic*]
  %t1484 = getelementptr [0 x %Diagnostic*], [0 x %Diagnostic*]* %t1483, i32 0, i32 0
  %t1485 = alloca { %Diagnostic**, i64 }
  %t1486 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t1485, i32 0, i32 0
  store %Diagnostic** %t1484, %Diagnostic*** %t1486
  %t1487 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t1485, i32 0, i32 1
  store i64 0, i64* %t1487
  %t1488 = insertvalue %SymbolCollectionResult %t1482, { %Diagnostic**, i64 }* %t1485, 1
  ret %SymbolCollectionResult %t1488
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
  %t141 = bitcast %SourceSpan* %t140 to i8*
  %t142 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t116, i8* %s117, i8* %t141)
  ret %ScopeResult %t142
merge1:
  %t143 = extractvalue %Statement %statement, 0
  %t144 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t145 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t143, 0
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t143, 1
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t143, 2
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t143, 3
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t143, 4
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %t160 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t161 = icmp eq i32 %t143, 5
  %t162 = select i1 %t161, i8* %t160, i8* %t159
  %t163 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t164 = icmp eq i32 %t143, 6
  %t165 = select i1 %t164, i8* %t163, i8* %t162
  %t166 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t167 = icmp eq i32 %t143, 7
  %t168 = select i1 %t167, i8* %t166, i8* %t165
  %t169 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t170 = icmp eq i32 %t143, 8
  %t171 = select i1 %t170, i8* %t169, i8* %t168
  %t172 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t173 = icmp eq i32 %t143, 9
  %t174 = select i1 %t173, i8* %t172, i8* %t171
  %t175 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t176 = icmp eq i32 %t143, 10
  %t177 = select i1 %t176, i8* %t175, i8* %t174
  %t178 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t179 = icmp eq i32 %t143, 11
  %t180 = select i1 %t179, i8* %t178, i8* %t177
  %t181 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t182 = icmp eq i32 %t143, 12
  %t183 = select i1 %t182, i8* %t181, i8* %t180
  %t184 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t185 = icmp eq i32 %t143, 13
  %t186 = select i1 %t185, i8* %t184, i8* %t183
  %t187 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t188 = icmp eq i32 %t143, 14
  %t189 = select i1 %t188, i8* %t187, i8* %t186
  %t190 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t191 = icmp eq i32 %t143, 15
  %t192 = select i1 %t191, i8* %t190, i8* %t189
  %t193 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t194 = icmp eq i32 %t143, 16
  %t195 = select i1 %t194, i8* %t193, i8* %t192
  %t196 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t197 = icmp eq i32 %t143, 17
  %t198 = select i1 %t197, i8* %t196, i8* %t195
  %t199 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t200 = icmp eq i32 %t143, 18
  %t201 = select i1 %t200, i8* %t199, i8* %t198
  %t202 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t203 = icmp eq i32 %t143, 19
  %t204 = select i1 %t203, i8* %t202, i8* %t201
  %t205 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t206 = icmp eq i32 %t143, 20
  %t207 = select i1 %t206, i8* %t205, i8* %t204
  %t208 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t209 = icmp eq i32 %t143, 21
  %t210 = select i1 %t209, i8* %t208, i8* %t207
  %t211 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t212 = icmp eq i32 %t143, 22
  %t213 = select i1 %t212, i8* %t211, i8* %t210
  %s214 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.214, i32 0, i32 0
  %t215 = icmp eq i8* %t213, %s214
  br i1 %t215, label %then2, label %merge3
then2:
  %t216 = extractvalue %Statement %statement, 0
  %t217 = alloca %Statement
  store %Statement %statement, %Statement* %t217
  %t218 = getelementptr inbounds %Statement, %Statement* %t217, i32 0, i32 1
  %t219 = bitcast [24 x i8]* %t218 to i8*
  %t220 = bitcast i8* %t219 to %FunctionSignature*
  %t221 = load %FunctionSignature, %FunctionSignature* %t220
  %t222 = icmp eq i32 %t216, 4
  %t223 = select i1 %t222, %FunctionSignature %t221, %FunctionSignature zeroinitializer
  %t224 = getelementptr inbounds %Statement, %Statement* %t217, i32 0, i32 1
  %t225 = bitcast [24 x i8]* %t224 to i8*
  %t226 = bitcast i8* %t225 to %FunctionSignature*
  %t227 = load %FunctionSignature, %FunctionSignature* %t226
  %t228 = icmp eq i32 %t216, 5
  %t229 = select i1 %t228, %FunctionSignature %t227, %FunctionSignature %t223
  %t230 = getelementptr inbounds %Statement, %Statement* %t217, i32 0, i32 1
  %t231 = bitcast [24 x i8]* %t230 to i8*
  %t232 = bitcast i8* %t231 to %FunctionSignature*
  %t233 = load %FunctionSignature, %FunctionSignature* %t232
  %t234 = icmp eq i32 %t216, 7
  %t235 = select i1 %t234, %FunctionSignature %t233, %FunctionSignature %t229
  %t236 = extractvalue %FunctionSignature %t235, 0
  %s237 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.237, i32 0, i32 0
  %t238 = extractvalue %Statement %statement, 0
  %t239 = alloca %Statement
  store %Statement %statement, %Statement* %t239
  %t240 = getelementptr inbounds %Statement, %Statement* %t239, i32 0, i32 1
  %t241 = bitcast [24 x i8]* %t240 to i8*
  %t242 = bitcast i8* %t241 to %FunctionSignature*
  %t243 = load %FunctionSignature, %FunctionSignature* %t242
  %t244 = icmp eq i32 %t238, 4
  %t245 = select i1 %t244, %FunctionSignature %t243, %FunctionSignature zeroinitializer
  %t246 = getelementptr inbounds %Statement, %Statement* %t239, i32 0, i32 1
  %t247 = bitcast [24 x i8]* %t246 to i8*
  %t248 = bitcast i8* %t247 to %FunctionSignature*
  %t249 = load %FunctionSignature, %FunctionSignature* %t248
  %t250 = icmp eq i32 %t238, 5
  %t251 = select i1 %t250, %FunctionSignature %t249, %FunctionSignature %t245
  %t252 = getelementptr inbounds %Statement, %Statement* %t239, i32 0, i32 1
  %t253 = bitcast [24 x i8]* %t252 to i8*
  %t254 = bitcast i8* %t253 to %FunctionSignature*
  %t255 = load %FunctionSignature, %FunctionSignature* %t254
  %t256 = icmp eq i32 %t238, 7
  %t257 = select i1 %t256, %FunctionSignature %t255, %FunctionSignature %t251
  %t258 = extractvalue %FunctionSignature %t257, 6
  %t259 = bitcast %SourceSpan* %t258 to i8*
  %t260 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t236, i8* %s237, i8* %t259)
  store %ScopeResult %t260, %ScopeResult* %l0
  %t261 = load %ScopeResult, %ScopeResult* %l0
  %t262 = extractvalue %ScopeResult %t261, 1
  store { %Diagnostic**, i64 }* %t262, { %Diagnostic**, i64 }** %l1
  %t263 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l1
  %t264 = extractvalue %Statement %statement, 0
  %t265 = alloca %Statement
  store %Statement %statement, %Statement* %t265
  %t266 = getelementptr inbounds %Statement, %Statement* %t265, i32 0, i32 1
  %t267 = bitcast [24 x i8]* %t266 to i8*
  %t268 = bitcast i8* %t267 to %FunctionSignature*
  %t269 = load %FunctionSignature, %FunctionSignature* %t268
  %t270 = icmp eq i32 %t264, 4
  %t271 = select i1 %t270, %FunctionSignature %t269, %FunctionSignature zeroinitializer
  %t272 = getelementptr inbounds %Statement, %Statement* %t265, i32 0, i32 1
  %t273 = bitcast [24 x i8]* %t272 to i8*
  %t274 = bitcast i8* %t273 to %FunctionSignature*
  %t275 = load %FunctionSignature, %FunctionSignature* %t274
  %t276 = icmp eq i32 %t264, 5
  %t277 = select i1 %t276, %FunctionSignature %t275, %FunctionSignature %t271
  %t278 = getelementptr inbounds %Statement, %Statement* %t265, i32 0, i32 1
  %t279 = bitcast [24 x i8]* %t278 to i8*
  %t280 = bitcast i8* %t279 to %FunctionSignature*
  %t281 = load %FunctionSignature, %FunctionSignature* %t280
  %t282 = icmp eq i32 %t264, 7
  %t283 = select i1 %t282, %FunctionSignature %t281, %FunctionSignature %t277
  %t284 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t283)
  %t285 = bitcast { %Diagnostic**, i64 }* %t263 to { i8**, i64 }*
  %t286 = bitcast { %Diagnostic*, i64 }* %t284 to { i8**, i64 }*
  %t287 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t285, { i8**, i64 }* %t286)
  %t288 = bitcast { i8**, i64 }* %t287 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t288, { %Diagnostic**, i64 }** %l1
  %t289 = extractvalue %Statement %statement, 0
  %t290 = alloca %Statement
  store %Statement %statement, %Statement* %t290
  %t291 = getelementptr inbounds %Statement, %Statement* %t290, i32 0, i32 1
  %t292 = bitcast [24 x i8]* %t291 to i8*
  %t293 = bitcast i8* %t292 to %FunctionSignature*
  %t294 = load %FunctionSignature, %FunctionSignature* %t293
  %t295 = icmp eq i32 %t289, 4
  %t296 = select i1 %t295, %FunctionSignature %t294, %FunctionSignature zeroinitializer
  %t297 = getelementptr inbounds %Statement, %Statement* %t290, i32 0, i32 1
  %t298 = bitcast [24 x i8]* %t297 to i8*
  %t299 = bitcast i8* %t298 to %FunctionSignature*
  %t300 = load %FunctionSignature, %FunctionSignature* %t299
  %t301 = icmp eq i32 %t289, 5
  %t302 = select i1 %t301, %FunctionSignature %t300, %FunctionSignature %t296
  %t303 = getelementptr inbounds %Statement, %Statement* %t290, i32 0, i32 1
  %t304 = bitcast [24 x i8]* %t303 to i8*
  %t305 = bitcast i8* %t304 to %FunctionSignature*
  %t306 = load %FunctionSignature, %FunctionSignature* %t305
  %t307 = icmp eq i32 %t289, 7
  %t308 = select i1 %t307, %FunctionSignature %t306, %FunctionSignature %t302
  %t309 = extractvalue %Statement %statement, 0
  %t310 = alloca %Statement
  store %Statement %statement, %Statement* %t310
  %t311 = getelementptr inbounds %Statement, %Statement* %t310, i32 0, i32 1
  %t312 = bitcast [24 x i8]* %t311 to i8*
  %t313 = getelementptr inbounds i8, i8* %t312, i64 8
  %t314 = bitcast i8* %t313 to %Block*
  %t315 = load %Block, %Block* %t314
  %t316 = icmp eq i32 %t309, 4
  %t317 = select i1 %t316, %Block %t315, %Block zeroinitializer
  %t318 = getelementptr inbounds %Statement, %Statement* %t310, i32 0, i32 1
  %t319 = bitcast [24 x i8]* %t318 to i8*
  %t320 = getelementptr inbounds i8, i8* %t319, i64 8
  %t321 = bitcast i8* %t320 to %Block*
  %t322 = load %Block, %Block* %t321
  %t323 = icmp eq i32 %t309, 5
  %t324 = select i1 %t323, %Block %t322, %Block %t317
  %t325 = getelementptr inbounds %Statement, %Statement* %t310, i32 0, i32 1
  %t326 = bitcast [40 x i8]* %t325 to i8*
  %t327 = getelementptr inbounds i8, i8* %t326, i64 16
  %t328 = bitcast i8* %t327 to %Block*
  %t329 = load %Block, %Block* %t328
  %t330 = icmp eq i32 %t309, 6
  %t331 = select i1 %t330, %Block %t329, %Block %t324
  %t332 = getelementptr inbounds %Statement, %Statement* %t310, i32 0, i32 1
  %t333 = bitcast [24 x i8]* %t332 to i8*
  %t334 = getelementptr inbounds i8, i8* %t333, i64 8
  %t335 = bitcast i8* %t334 to %Block*
  %t336 = load %Block, %Block* %t335
  %t337 = icmp eq i32 %t309, 7
  %t338 = select i1 %t337, %Block %t336, %Block %t331
  %t339 = getelementptr inbounds %Statement, %Statement* %t310, i32 0, i32 1
  %t340 = bitcast [40 x i8]* %t339 to i8*
  %t341 = getelementptr inbounds i8, i8* %t340, i64 24
  %t342 = bitcast i8* %t341 to %Block*
  %t343 = load %Block, %Block* %t342
  %t344 = icmp eq i32 %t309, 12
  %t345 = select i1 %t344, %Block %t343, %Block %t338
  %t346 = getelementptr inbounds %Statement, %Statement* %t310, i32 0, i32 1
  %t347 = bitcast [24 x i8]* %t346 to i8*
  %t348 = getelementptr inbounds i8, i8* %t347, i64 8
  %t349 = bitcast i8* %t348 to %Block*
  %t350 = load %Block, %Block* %t349
  %t351 = icmp eq i32 %t309, 13
  %t352 = select i1 %t351, %Block %t350, %Block %t345
  %t353 = getelementptr inbounds %Statement, %Statement* %t310, i32 0, i32 1
  %t354 = bitcast [24 x i8]* %t353 to i8*
  %t355 = getelementptr inbounds i8, i8* %t354, i64 8
  %t356 = bitcast i8* %t355 to %Block*
  %t357 = load %Block, %Block* %t356
  %t358 = icmp eq i32 %t309, 14
  %t359 = select i1 %t358, %Block %t357, %Block %t352
  %t360 = getelementptr inbounds %Statement, %Statement* %t310, i32 0, i32 1
  %t361 = bitcast [16 x i8]* %t360 to i8*
  %t362 = bitcast i8* %t361 to %Block*
  %t363 = load %Block, %Block* %t362
  %t364 = icmp eq i32 %t309, 15
  %t365 = select i1 %t364, %Block %t363, %Block %t359
  %t366 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t308, %Block %t365, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t366, { %Diagnostic*, i64 }** %l2
  %t367 = load %ScopeResult, %ScopeResult* %l0
  %t368 = extractvalue %ScopeResult %t367, 0
  %t369 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t368, 0
  %t370 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l1
  %t371 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l2
  %t372 = bitcast { %Diagnostic**, i64 }* %t370 to { i8**, i64 }*
  %t373 = bitcast { %Diagnostic*, i64 }* %t371 to { i8**, i64 }*
  %t374 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t372, { i8**, i64 }* %t373)
  %t375 = bitcast { i8**, i64 }* %t374 to { %Diagnostic**, i64 }*
  %t376 = insertvalue %ScopeResult %t369, { %Diagnostic**, i64 }* %t375, 1
  ret %ScopeResult %t376
merge3:
  %t377 = extractvalue %Statement %statement, 0
  %t378 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t379 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t380 = icmp eq i32 %t377, 0
  %t381 = select i1 %t380, i8* %t379, i8* %t378
  %t382 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t383 = icmp eq i32 %t377, 1
  %t384 = select i1 %t383, i8* %t382, i8* %t381
  %t385 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t386 = icmp eq i32 %t377, 2
  %t387 = select i1 %t386, i8* %t385, i8* %t384
  %t388 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t389 = icmp eq i32 %t377, 3
  %t390 = select i1 %t389, i8* %t388, i8* %t387
  %t391 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t392 = icmp eq i32 %t377, 4
  %t393 = select i1 %t392, i8* %t391, i8* %t390
  %t394 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t395 = icmp eq i32 %t377, 5
  %t396 = select i1 %t395, i8* %t394, i8* %t393
  %t397 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t398 = icmp eq i32 %t377, 6
  %t399 = select i1 %t398, i8* %t397, i8* %t396
  %t400 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t401 = icmp eq i32 %t377, 7
  %t402 = select i1 %t401, i8* %t400, i8* %t399
  %t403 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t404 = icmp eq i32 %t377, 8
  %t405 = select i1 %t404, i8* %t403, i8* %t402
  %t406 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t407 = icmp eq i32 %t377, 9
  %t408 = select i1 %t407, i8* %t406, i8* %t405
  %t409 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t410 = icmp eq i32 %t377, 10
  %t411 = select i1 %t410, i8* %t409, i8* %t408
  %t412 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t413 = icmp eq i32 %t377, 11
  %t414 = select i1 %t413, i8* %t412, i8* %t411
  %t415 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t416 = icmp eq i32 %t377, 12
  %t417 = select i1 %t416, i8* %t415, i8* %t414
  %t418 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t419 = icmp eq i32 %t377, 13
  %t420 = select i1 %t419, i8* %t418, i8* %t417
  %t421 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t422 = icmp eq i32 %t377, 14
  %t423 = select i1 %t422, i8* %t421, i8* %t420
  %t424 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t425 = icmp eq i32 %t377, 15
  %t426 = select i1 %t425, i8* %t424, i8* %t423
  %t427 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t428 = icmp eq i32 %t377, 16
  %t429 = select i1 %t428, i8* %t427, i8* %t426
  %t430 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t431 = icmp eq i32 %t377, 17
  %t432 = select i1 %t431, i8* %t430, i8* %t429
  %t433 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t434 = icmp eq i32 %t377, 18
  %t435 = select i1 %t434, i8* %t433, i8* %t432
  %t436 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t437 = icmp eq i32 %t377, 19
  %t438 = select i1 %t437, i8* %t436, i8* %t435
  %t439 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t440 = icmp eq i32 %t377, 20
  %t441 = select i1 %t440, i8* %t439, i8* %t438
  %t442 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t443 = icmp eq i32 %t377, 21
  %t444 = select i1 %t443, i8* %t442, i8* %t441
  %t445 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t446 = icmp eq i32 %t377, 22
  %t447 = select i1 %t446, i8* %t445, i8* %t444
  %s448 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.448, i32 0, i32 0
  %t449 = icmp eq i8* %t447, %s448
  br i1 %t449, label %then4, label %merge5
then4:
  %t450 = extractvalue %Statement %statement, 0
  %t451 = alloca %Statement
  store %Statement %statement, %Statement* %t451
  %t452 = getelementptr inbounds %Statement, %Statement* %t451, i32 0, i32 1
  %t453 = bitcast [48 x i8]* %t452 to i8*
  %t454 = bitcast i8* %t453 to i8**
  %t455 = load i8*, i8** %t454
  %t456 = icmp eq i32 %t450, 2
  %t457 = select i1 %t456, i8* %t455, i8* null
  %t458 = getelementptr inbounds %Statement, %Statement* %t451, i32 0, i32 1
  %t459 = bitcast [48 x i8]* %t458 to i8*
  %t460 = bitcast i8* %t459 to i8**
  %t461 = load i8*, i8** %t460
  %t462 = icmp eq i32 %t450, 3
  %t463 = select i1 %t462, i8* %t461, i8* %t457
  %t464 = getelementptr inbounds %Statement, %Statement* %t451, i32 0, i32 1
  %t465 = bitcast [40 x i8]* %t464 to i8*
  %t466 = bitcast i8* %t465 to i8**
  %t467 = load i8*, i8** %t466
  %t468 = icmp eq i32 %t450, 6
  %t469 = select i1 %t468, i8* %t467, i8* %t463
  %t470 = getelementptr inbounds %Statement, %Statement* %t451, i32 0, i32 1
  %t471 = bitcast [56 x i8]* %t470 to i8*
  %t472 = bitcast i8* %t471 to i8**
  %t473 = load i8*, i8** %t472
  %t474 = icmp eq i32 %t450, 8
  %t475 = select i1 %t474, i8* %t473, i8* %t469
  %t476 = getelementptr inbounds %Statement, %Statement* %t451, i32 0, i32 1
  %t477 = bitcast [40 x i8]* %t476 to i8*
  %t478 = bitcast i8* %t477 to i8**
  %t479 = load i8*, i8** %t478
  %t480 = icmp eq i32 %t450, 9
  %t481 = select i1 %t480, i8* %t479, i8* %t475
  %t482 = getelementptr inbounds %Statement, %Statement* %t451, i32 0, i32 1
  %t483 = bitcast [40 x i8]* %t482 to i8*
  %t484 = bitcast i8* %t483 to i8**
  %t485 = load i8*, i8** %t484
  %t486 = icmp eq i32 %t450, 10
  %t487 = select i1 %t486, i8* %t485, i8* %t481
  %t488 = getelementptr inbounds %Statement, %Statement* %t451, i32 0, i32 1
  %t489 = bitcast [40 x i8]* %t488 to i8*
  %t490 = bitcast i8* %t489 to i8**
  %t491 = load i8*, i8** %t490
  %t492 = icmp eq i32 %t450, 11
  %t493 = select i1 %t492, i8* %t491, i8* %t487
  %s494 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.494, i32 0, i32 0
  %t495 = extractvalue %Statement %statement, 0
  %t496 = alloca %Statement
  store %Statement %statement, %Statement* %t496
  %t497 = getelementptr inbounds %Statement, %Statement* %t496, i32 0, i32 1
  %t498 = bitcast [48 x i8]* %t497 to i8*
  %t499 = getelementptr inbounds i8, i8* %t498, i64 8
  %t500 = bitcast i8* %t499 to %SourceSpan**
  %t501 = load %SourceSpan*, %SourceSpan** %t500
  %t502 = icmp eq i32 %t495, 3
  %t503 = select i1 %t502, %SourceSpan* %t501, %SourceSpan* null
  %t504 = getelementptr inbounds %Statement, %Statement* %t496, i32 0, i32 1
  %t505 = bitcast [40 x i8]* %t504 to i8*
  %t506 = getelementptr inbounds i8, i8* %t505, i64 8
  %t507 = bitcast i8* %t506 to %SourceSpan**
  %t508 = load %SourceSpan*, %SourceSpan** %t507
  %t509 = icmp eq i32 %t495, 6
  %t510 = select i1 %t509, %SourceSpan* %t508, %SourceSpan* %t503
  %t511 = getelementptr inbounds %Statement, %Statement* %t496, i32 0, i32 1
  %t512 = bitcast [56 x i8]* %t511 to i8*
  %t513 = getelementptr inbounds i8, i8* %t512, i64 8
  %t514 = bitcast i8* %t513 to %SourceSpan**
  %t515 = load %SourceSpan*, %SourceSpan** %t514
  %t516 = icmp eq i32 %t495, 8
  %t517 = select i1 %t516, %SourceSpan* %t515, %SourceSpan* %t510
  %t518 = getelementptr inbounds %Statement, %Statement* %t496, i32 0, i32 1
  %t519 = bitcast [40 x i8]* %t518 to i8*
  %t520 = getelementptr inbounds i8, i8* %t519, i64 8
  %t521 = bitcast i8* %t520 to %SourceSpan**
  %t522 = load %SourceSpan*, %SourceSpan** %t521
  %t523 = icmp eq i32 %t495, 9
  %t524 = select i1 %t523, %SourceSpan* %t522, %SourceSpan* %t517
  %t525 = getelementptr inbounds %Statement, %Statement* %t496, i32 0, i32 1
  %t526 = bitcast [40 x i8]* %t525 to i8*
  %t527 = getelementptr inbounds i8, i8* %t526, i64 8
  %t528 = bitcast i8* %t527 to %SourceSpan**
  %t529 = load %SourceSpan*, %SourceSpan** %t528
  %t530 = icmp eq i32 %t495, 10
  %t531 = select i1 %t530, %SourceSpan* %t529, %SourceSpan* %t524
  %t532 = getelementptr inbounds %Statement, %Statement* %t496, i32 0, i32 1
  %t533 = bitcast [40 x i8]* %t532 to i8*
  %t534 = getelementptr inbounds i8, i8* %t533, i64 8
  %t535 = bitcast i8* %t534 to %SourceSpan**
  %t536 = load %SourceSpan*, %SourceSpan** %t535
  %t537 = icmp eq i32 %t495, 11
  %t538 = select i1 %t537, %SourceSpan* %t536, %SourceSpan* %t531
  %t539 = bitcast %SourceSpan* %t538 to i8*
  %t540 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t493, i8* %s494, i8* %t539)
  store %ScopeResult %t540, %ScopeResult* %l3
  %t541 = load %ScopeResult, %ScopeResult* %l3
  %t542 = extractvalue %ScopeResult %t541, 1
  store { %Diagnostic**, i64 }* %t542, { %Diagnostic**, i64 }** %l4
  %t543 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t544 = extractvalue %Statement %statement, 0
  %t545 = alloca %Statement
  store %Statement %statement, %Statement* %t545
  %t546 = getelementptr inbounds %Statement, %Statement* %t545, i32 0, i32 1
  %t547 = bitcast [56 x i8]* %t546 to i8*
  %t548 = getelementptr inbounds i8, i8* %t547, i64 16
  %t549 = bitcast i8* %t548 to { %TypeParameter**, i64 }**
  %t550 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t549
  %t551 = icmp eq i32 %t544, 8
  %t552 = select i1 %t551, { %TypeParameter**, i64 }* %t550, { %TypeParameter**, i64 }* null
  %t553 = getelementptr inbounds %Statement, %Statement* %t545, i32 0, i32 1
  %t554 = bitcast [40 x i8]* %t553 to i8*
  %t555 = getelementptr inbounds i8, i8* %t554, i64 16
  %t556 = bitcast i8* %t555 to { %TypeParameter**, i64 }**
  %t557 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t556
  %t558 = icmp eq i32 %t544, 9
  %t559 = select i1 %t558, { %TypeParameter**, i64 }* %t557, { %TypeParameter**, i64 }* %t552
  %t560 = getelementptr inbounds %Statement, %Statement* %t545, i32 0, i32 1
  %t561 = bitcast [40 x i8]* %t560 to i8*
  %t562 = getelementptr inbounds i8, i8* %t561, i64 16
  %t563 = bitcast i8* %t562 to { %TypeParameter**, i64 }**
  %t564 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t563
  %t565 = icmp eq i32 %t544, 10
  %t566 = select i1 %t565, { %TypeParameter**, i64 }* %t564, { %TypeParameter**, i64 }* %t559
  %t567 = getelementptr inbounds %Statement, %Statement* %t545, i32 0, i32 1
  %t568 = bitcast [40 x i8]* %t567 to i8*
  %t569 = getelementptr inbounds i8, i8* %t568, i64 16
  %t570 = bitcast i8* %t569 to { %TypeParameter**, i64 }**
  %t571 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t570
  %t572 = icmp eq i32 %t544, 11
  %t573 = select i1 %t572, { %TypeParameter**, i64 }* %t571, { %TypeParameter**, i64 }* %t566
  %t574 = bitcast { %TypeParameter**, i64 }* %t573 to { %TypeParameter*, i64 }*
  %t575 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t574)
  %t576 = bitcast { %Diagnostic**, i64 }* %t543 to { i8**, i64 }*
  %t577 = bitcast { %Diagnostic*, i64 }* %t575 to { i8**, i64 }*
  %t578 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t576, { i8**, i64 }* %t577)
  %t579 = bitcast { i8**, i64 }* %t578 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t579, { %Diagnostic**, i64 }** %l4
  %t580 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t581 = extractvalue %Statement %statement, 0
  %t582 = alloca %Statement
  store %Statement %statement, %Statement* %t582
  %t583 = getelementptr inbounds %Statement, %Statement* %t582, i32 0, i32 1
  %t584 = bitcast [56 x i8]* %t583 to i8*
  %t585 = getelementptr inbounds i8, i8* %t584, i64 32
  %t586 = bitcast i8* %t585 to { %FieldDeclaration**, i64 }**
  %t587 = load { %FieldDeclaration**, i64 }*, { %FieldDeclaration**, i64 }** %t586
  %t588 = icmp eq i32 %t581, 8
  %t589 = select i1 %t588, { %FieldDeclaration**, i64 }* %t587, { %FieldDeclaration**, i64 }* null
  %t590 = bitcast { %FieldDeclaration**, i64 }* %t589 to { %FieldDeclaration*, i64 }*
  %t591 = call { %Diagnostic*, i64 }* @check_struct_fields({ %FieldDeclaration*, i64 }* %t590)
  %t592 = bitcast { %Diagnostic**, i64 }* %t580 to { i8**, i64 }*
  %t593 = bitcast { %Diagnostic*, i64 }* %t591 to { i8**, i64 }*
  %t594 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t592, { i8**, i64 }* %t593)
  %t595 = bitcast { i8**, i64 }* %t594 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t595, { %Diagnostic**, i64 }** %l4
  %t596 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t597 = extractvalue %Statement %statement, 0
  %t598 = alloca %Statement
  store %Statement %statement, %Statement* %t598
  %t599 = getelementptr inbounds %Statement, %Statement* %t598, i32 0, i32 1
  %t600 = bitcast [56 x i8]* %t599 to i8*
  %t601 = getelementptr inbounds i8, i8* %t600, i64 40
  %t602 = bitcast i8* %t601 to { %MethodDeclaration**, i64 }**
  %t603 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t602
  %t604 = icmp eq i32 %t597, 8
  %t605 = select i1 %t604, { %MethodDeclaration**, i64 }* %t603, { %MethodDeclaration**, i64 }* null
  %t606 = bitcast { %MethodDeclaration**, i64 }* %t605 to { %MethodDeclaration*, i64 }*
  %t607 = call { %Diagnostic*, i64 }* @check_struct_methods({ %MethodDeclaration*, i64 }* %t606)
  %t608 = bitcast { %Diagnostic**, i64 }* %t596 to { i8**, i64 }*
  %t609 = bitcast { %Diagnostic*, i64 }* %t607 to { i8**, i64 }*
  %t610 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t608, { i8**, i64 }* %t609)
  %t611 = bitcast { i8**, i64 }* %t610 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t611, { %Diagnostic**, i64 }** %l4
  %t612 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t613 = call { %Diagnostic*, i64 }* @check_struct_implements_interfaces(%Statement %statement, { %Statement*, i64 }* %interfaces)
  %t614 = bitcast { %Diagnostic**, i64 }* %t612 to { i8**, i64 }*
  %t615 = bitcast { %Diagnostic*, i64 }* %t613 to { i8**, i64 }*
  %t616 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t614, { i8**, i64 }* %t615)
  %t617 = bitcast { i8**, i64 }* %t616 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t617, { %Diagnostic**, i64 }** %l4
  %t618 = sitofp i64 0 to double
  store double %t618, double* %l5
  %t619 = load %ScopeResult, %ScopeResult* %l3
  %t620 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t621 = load double, double* %l5
  br label %loop.header6
loop.header6:
  %t673 = phi { %Diagnostic**, i64 }* [ %t620, %then4 ], [ %t671, %loop.latch8 ]
  %t674 = phi double [ %t621, %then4 ], [ %t672, %loop.latch8 ]
  store { %Diagnostic**, i64 }* %t673, { %Diagnostic**, i64 }** %l4
  store double %t674, double* %l5
  br label %loop.body7
loop.body7:
  %t622 = load double, double* %l5
  %t623 = extractvalue %Statement %statement, 0
  %t624 = alloca %Statement
  store %Statement %statement, %Statement* %t624
  %t625 = getelementptr inbounds %Statement, %Statement* %t624, i32 0, i32 1
  %t626 = bitcast [56 x i8]* %t625 to i8*
  %t627 = getelementptr inbounds i8, i8* %t626, i64 40
  %t628 = bitcast i8* %t627 to { %MethodDeclaration**, i64 }**
  %t629 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t628
  %t630 = icmp eq i32 %t623, 8
  %t631 = select i1 %t630, { %MethodDeclaration**, i64 }* %t629, { %MethodDeclaration**, i64 }* null
  %t632 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t631
  %t633 = extractvalue { %MethodDeclaration**, i64 } %t632, 1
  %t634 = sitofp i64 %t633 to double
  %t635 = fcmp oge double %t622, %t634
  %t636 = load %ScopeResult, %ScopeResult* %l3
  %t637 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t638 = load double, double* %l5
  br i1 %t635, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t639 = extractvalue %Statement %statement, 0
  %t640 = alloca %Statement
  store %Statement %statement, %Statement* %t640
  %t641 = getelementptr inbounds %Statement, %Statement* %t640, i32 0, i32 1
  %t642 = bitcast [56 x i8]* %t641 to i8*
  %t643 = getelementptr inbounds i8, i8* %t642, i64 40
  %t644 = bitcast i8* %t643 to { %MethodDeclaration**, i64 }**
  %t645 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t644
  %t646 = icmp eq i32 %t639, 8
  %t647 = select i1 %t646, { %MethodDeclaration**, i64 }* %t645, { %MethodDeclaration**, i64 }* null
  %t648 = load double, double* %l5
  %t649 = fptosi double %t648 to i64
  %t650 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t647
  %t651 = extractvalue { %MethodDeclaration**, i64 } %t650, 0
  %t652 = extractvalue { %MethodDeclaration**, i64 } %t650, 1
  %t653 = icmp uge i64 %t649, %t652
  ; bounds check: %t653 (if true, out of bounds)
  %t654 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t651, i64 %t649
  %t655 = load %MethodDeclaration*, %MethodDeclaration** %t654
  store %MethodDeclaration* %t655, %MethodDeclaration** %l6
  %t656 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t657 = load %MethodDeclaration*, %MethodDeclaration** %l6
  %t658 = getelementptr %MethodDeclaration, %MethodDeclaration* %t657, i32 0, i32 0
  %t659 = load %FunctionSignature, %FunctionSignature* %t658
  %t660 = load %MethodDeclaration*, %MethodDeclaration** %l6
  %t661 = getelementptr %MethodDeclaration, %MethodDeclaration* %t660, i32 0, i32 1
  %t662 = load %Block, %Block* %t661
  %t663 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t659, %Block %t662, { %Statement*, i64 }* %interfaces)
  %t664 = bitcast { %Diagnostic**, i64 }* %t656 to { i8**, i64 }*
  %t665 = bitcast { %Diagnostic*, i64 }* %t663 to { i8**, i64 }*
  %t666 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t664, { i8**, i64 }* %t665)
  %t667 = bitcast { i8**, i64 }* %t666 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t667, { %Diagnostic**, i64 }** %l4
  %t668 = load double, double* %l5
  %t669 = sitofp i64 1 to double
  %t670 = fadd double %t668, %t669
  store double %t670, double* %l5
  br label %loop.latch8
loop.latch8:
  %t671 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t672 = load double, double* %l5
  br label %loop.header6
afterloop9:
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
  %s751 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.751, i32 0, i32 0
  %t752 = icmp eq i8* %t750, %s751
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
  %s797 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.797, i32 0, i32 0
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
  %t842 = bitcast %SourceSpan* %t841 to i8*
  %t843 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t796, i8* %s797, i8* %t842)
  store %ScopeResult %t843, %ScopeResult* %l7
  %t844 = load %ScopeResult, %ScopeResult* %l7
  %t845 = extractvalue %ScopeResult %t844, 1
  store { %Diagnostic**, i64 }* %t845, { %Diagnostic**, i64 }** %l8
  %t846 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l8
  %t847 = extractvalue %Statement %statement, 0
  %t848 = alloca %Statement
  store %Statement %statement, %Statement* %t848
  %t849 = getelementptr inbounds %Statement, %Statement* %t848, i32 0, i32 1
  %t850 = bitcast [56 x i8]* %t849 to i8*
  %t851 = getelementptr inbounds i8, i8* %t850, i64 16
  %t852 = bitcast i8* %t851 to { %TypeParameter**, i64 }**
  %t853 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t852
  %t854 = icmp eq i32 %t847, 8
  %t855 = select i1 %t854, { %TypeParameter**, i64 }* %t853, { %TypeParameter**, i64 }* null
  %t856 = getelementptr inbounds %Statement, %Statement* %t848, i32 0, i32 1
  %t857 = bitcast [40 x i8]* %t856 to i8*
  %t858 = getelementptr inbounds i8, i8* %t857, i64 16
  %t859 = bitcast i8* %t858 to { %TypeParameter**, i64 }**
  %t860 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t859
  %t861 = icmp eq i32 %t847, 9
  %t862 = select i1 %t861, { %TypeParameter**, i64 }* %t860, { %TypeParameter**, i64 }* %t855
  %t863 = getelementptr inbounds %Statement, %Statement* %t848, i32 0, i32 1
  %t864 = bitcast [40 x i8]* %t863 to i8*
  %t865 = getelementptr inbounds i8, i8* %t864, i64 16
  %t866 = bitcast i8* %t865 to { %TypeParameter**, i64 }**
  %t867 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t866
  %t868 = icmp eq i32 %t847, 10
  %t869 = select i1 %t868, { %TypeParameter**, i64 }* %t867, { %TypeParameter**, i64 }* %t862
  %t870 = getelementptr inbounds %Statement, %Statement* %t848, i32 0, i32 1
  %t871 = bitcast [40 x i8]* %t870 to i8*
  %t872 = getelementptr inbounds i8, i8* %t871, i64 16
  %t873 = bitcast i8* %t872 to { %TypeParameter**, i64 }**
  %t874 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t873
  %t875 = icmp eq i32 %t847, 11
  %t876 = select i1 %t875, { %TypeParameter**, i64 }* %t874, { %TypeParameter**, i64 }* %t869
  %t877 = bitcast { %TypeParameter**, i64 }* %t876 to { %TypeParameter*, i64 }*
  %t878 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t877)
  %t879 = bitcast { %Diagnostic**, i64 }* %t846 to { i8**, i64 }*
  %t880 = bitcast { %Diagnostic*, i64 }* %t878 to { i8**, i64 }*
  %t881 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t879, { i8**, i64 }* %t880)
  %t882 = bitcast { i8**, i64 }* %t881 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t882, { %Diagnostic**, i64 }** %l8
  %t883 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l8
  %t884 = extractvalue %Statement %statement, 0
  %t885 = alloca %Statement
  store %Statement %statement, %Statement* %t885
  %t886 = getelementptr inbounds %Statement, %Statement* %t885, i32 0, i32 1
  %t887 = bitcast [40 x i8]* %t886 to i8*
  %t888 = getelementptr inbounds i8, i8* %t887, i64 24
  %t889 = bitcast i8* %t888 to { %EnumVariant**, i64 }**
  %t890 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t889
  %t891 = icmp eq i32 %t884, 11
  %t892 = select i1 %t891, { %EnumVariant**, i64 }* %t890, { %EnumVariant**, i64 }* null
  %t893 = bitcast { %EnumVariant**, i64 }* %t892 to { %EnumVariant*, i64 }*
  %t894 = call { %Diagnostic*, i64 }* @check_enum_variants({ %EnumVariant*, i64 }* %t893)
  %t895 = bitcast { %Diagnostic**, i64 }* %t883 to { i8**, i64 }*
  %t896 = bitcast { %Diagnostic*, i64 }* %t894 to { i8**, i64 }*
  %t897 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t895, { i8**, i64 }* %t896)
  %t898 = bitcast { i8**, i64 }* %t897 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t898, { %Diagnostic**, i64 }** %l8
  %t899 = load %ScopeResult, %ScopeResult* %l7
  %t900 = extractvalue %ScopeResult %t899, 0
  %t901 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t900, 0
  %t902 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l8
  %t903 = insertvalue %ScopeResult %t901, { %Diagnostic**, i64 }* %t902, 1
  ret %ScopeResult %t903
merge13:
  %t904 = extractvalue %Statement %statement, 0
  %t905 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t906 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t907 = icmp eq i32 %t904, 0
  %t908 = select i1 %t907, i8* %t906, i8* %t905
  %t909 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t910 = icmp eq i32 %t904, 1
  %t911 = select i1 %t910, i8* %t909, i8* %t908
  %t912 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t913 = icmp eq i32 %t904, 2
  %t914 = select i1 %t913, i8* %t912, i8* %t911
  %t915 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t916 = icmp eq i32 %t904, 3
  %t917 = select i1 %t916, i8* %t915, i8* %t914
  %t918 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t919 = icmp eq i32 %t904, 4
  %t920 = select i1 %t919, i8* %t918, i8* %t917
  %t921 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t922 = icmp eq i32 %t904, 5
  %t923 = select i1 %t922, i8* %t921, i8* %t920
  %t924 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t925 = icmp eq i32 %t904, 6
  %t926 = select i1 %t925, i8* %t924, i8* %t923
  %t927 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t928 = icmp eq i32 %t904, 7
  %t929 = select i1 %t928, i8* %t927, i8* %t926
  %t930 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t931 = icmp eq i32 %t904, 8
  %t932 = select i1 %t931, i8* %t930, i8* %t929
  %t933 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t934 = icmp eq i32 %t904, 9
  %t935 = select i1 %t934, i8* %t933, i8* %t932
  %t936 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t937 = icmp eq i32 %t904, 10
  %t938 = select i1 %t937, i8* %t936, i8* %t935
  %t939 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t940 = icmp eq i32 %t904, 11
  %t941 = select i1 %t940, i8* %t939, i8* %t938
  %t942 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t943 = icmp eq i32 %t904, 12
  %t944 = select i1 %t943, i8* %t942, i8* %t941
  %t945 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t946 = icmp eq i32 %t904, 13
  %t947 = select i1 %t946, i8* %t945, i8* %t944
  %t948 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t949 = icmp eq i32 %t904, 14
  %t950 = select i1 %t949, i8* %t948, i8* %t947
  %t951 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t952 = icmp eq i32 %t904, 15
  %t953 = select i1 %t952, i8* %t951, i8* %t950
  %t954 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t955 = icmp eq i32 %t904, 16
  %t956 = select i1 %t955, i8* %t954, i8* %t953
  %t957 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t958 = icmp eq i32 %t904, 17
  %t959 = select i1 %t958, i8* %t957, i8* %t956
  %t960 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t961 = icmp eq i32 %t904, 18
  %t962 = select i1 %t961, i8* %t960, i8* %t959
  %t963 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t964 = icmp eq i32 %t904, 19
  %t965 = select i1 %t964, i8* %t963, i8* %t962
  %t966 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t967 = icmp eq i32 %t904, 20
  %t968 = select i1 %t967, i8* %t966, i8* %t965
  %t969 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t970 = icmp eq i32 %t904, 21
  %t971 = select i1 %t970, i8* %t969, i8* %t968
  %t972 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t973 = icmp eq i32 %t904, 22
  %t974 = select i1 %t973, i8* %t972, i8* %t971
  %s975 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.975, i32 0, i32 0
  %t976 = icmp eq i8* %t974, %s975
  br i1 %t976, label %then14, label %merge15
then14:
  %t977 = extractvalue %Statement %statement, 0
  %t978 = alloca %Statement
  store %Statement %statement, %Statement* %t978
  %t979 = getelementptr inbounds %Statement, %Statement* %t978, i32 0, i32 1
  %t980 = bitcast [48 x i8]* %t979 to i8*
  %t981 = bitcast i8* %t980 to i8**
  %t982 = load i8*, i8** %t981
  %t983 = icmp eq i32 %t977, 2
  %t984 = select i1 %t983, i8* %t982, i8* null
  %t985 = getelementptr inbounds %Statement, %Statement* %t978, i32 0, i32 1
  %t986 = bitcast [48 x i8]* %t985 to i8*
  %t987 = bitcast i8* %t986 to i8**
  %t988 = load i8*, i8** %t987
  %t989 = icmp eq i32 %t977, 3
  %t990 = select i1 %t989, i8* %t988, i8* %t984
  %t991 = getelementptr inbounds %Statement, %Statement* %t978, i32 0, i32 1
  %t992 = bitcast [40 x i8]* %t991 to i8*
  %t993 = bitcast i8* %t992 to i8**
  %t994 = load i8*, i8** %t993
  %t995 = icmp eq i32 %t977, 6
  %t996 = select i1 %t995, i8* %t994, i8* %t990
  %t997 = getelementptr inbounds %Statement, %Statement* %t978, i32 0, i32 1
  %t998 = bitcast [56 x i8]* %t997 to i8*
  %t999 = bitcast i8* %t998 to i8**
  %t1000 = load i8*, i8** %t999
  %t1001 = icmp eq i32 %t977, 8
  %t1002 = select i1 %t1001, i8* %t1000, i8* %t996
  %t1003 = getelementptr inbounds %Statement, %Statement* %t978, i32 0, i32 1
  %t1004 = bitcast [40 x i8]* %t1003 to i8*
  %t1005 = bitcast i8* %t1004 to i8**
  %t1006 = load i8*, i8** %t1005
  %t1007 = icmp eq i32 %t977, 9
  %t1008 = select i1 %t1007, i8* %t1006, i8* %t1002
  %t1009 = getelementptr inbounds %Statement, %Statement* %t978, i32 0, i32 1
  %t1010 = bitcast [40 x i8]* %t1009 to i8*
  %t1011 = bitcast i8* %t1010 to i8**
  %t1012 = load i8*, i8** %t1011
  %t1013 = icmp eq i32 %t977, 10
  %t1014 = select i1 %t1013, i8* %t1012, i8* %t1008
  %t1015 = getelementptr inbounds %Statement, %Statement* %t978, i32 0, i32 1
  %t1016 = bitcast [40 x i8]* %t1015 to i8*
  %t1017 = bitcast i8* %t1016 to i8**
  %t1018 = load i8*, i8** %t1017
  %t1019 = icmp eq i32 %t977, 11
  %t1020 = select i1 %t1019, i8* %t1018, i8* %t1014
  %s1021 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.1021, i32 0, i32 0
  %t1022 = extractvalue %Statement %statement, 0
  %t1023 = alloca %Statement
  store %Statement %statement, %Statement* %t1023
  %t1024 = getelementptr inbounds %Statement, %Statement* %t1023, i32 0, i32 1
  %t1025 = bitcast [48 x i8]* %t1024 to i8*
  %t1026 = getelementptr inbounds i8, i8* %t1025, i64 8
  %t1027 = bitcast i8* %t1026 to %SourceSpan**
  %t1028 = load %SourceSpan*, %SourceSpan** %t1027
  %t1029 = icmp eq i32 %t1022, 3
  %t1030 = select i1 %t1029, %SourceSpan* %t1028, %SourceSpan* null
  %t1031 = getelementptr inbounds %Statement, %Statement* %t1023, i32 0, i32 1
  %t1032 = bitcast [40 x i8]* %t1031 to i8*
  %t1033 = getelementptr inbounds i8, i8* %t1032, i64 8
  %t1034 = bitcast i8* %t1033 to %SourceSpan**
  %t1035 = load %SourceSpan*, %SourceSpan** %t1034
  %t1036 = icmp eq i32 %t1022, 6
  %t1037 = select i1 %t1036, %SourceSpan* %t1035, %SourceSpan* %t1030
  %t1038 = getelementptr inbounds %Statement, %Statement* %t1023, i32 0, i32 1
  %t1039 = bitcast [56 x i8]* %t1038 to i8*
  %t1040 = getelementptr inbounds i8, i8* %t1039, i64 8
  %t1041 = bitcast i8* %t1040 to %SourceSpan**
  %t1042 = load %SourceSpan*, %SourceSpan** %t1041
  %t1043 = icmp eq i32 %t1022, 8
  %t1044 = select i1 %t1043, %SourceSpan* %t1042, %SourceSpan* %t1037
  %t1045 = getelementptr inbounds %Statement, %Statement* %t1023, i32 0, i32 1
  %t1046 = bitcast [40 x i8]* %t1045 to i8*
  %t1047 = getelementptr inbounds i8, i8* %t1046, i64 8
  %t1048 = bitcast i8* %t1047 to %SourceSpan**
  %t1049 = load %SourceSpan*, %SourceSpan** %t1048
  %t1050 = icmp eq i32 %t1022, 9
  %t1051 = select i1 %t1050, %SourceSpan* %t1049, %SourceSpan* %t1044
  %t1052 = getelementptr inbounds %Statement, %Statement* %t1023, i32 0, i32 1
  %t1053 = bitcast [40 x i8]* %t1052 to i8*
  %t1054 = getelementptr inbounds i8, i8* %t1053, i64 8
  %t1055 = bitcast i8* %t1054 to %SourceSpan**
  %t1056 = load %SourceSpan*, %SourceSpan** %t1055
  %t1057 = icmp eq i32 %t1022, 10
  %t1058 = select i1 %t1057, %SourceSpan* %t1056, %SourceSpan* %t1051
  %t1059 = getelementptr inbounds %Statement, %Statement* %t1023, i32 0, i32 1
  %t1060 = bitcast [40 x i8]* %t1059 to i8*
  %t1061 = getelementptr inbounds i8, i8* %t1060, i64 8
  %t1062 = bitcast i8* %t1061 to %SourceSpan**
  %t1063 = load %SourceSpan*, %SourceSpan** %t1062
  %t1064 = icmp eq i32 %t1022, 11
  %t1065 = select i1 %t1064, %SourceSpan* %t1063, %SourceSpan* %t1058
  %t1066 = bitcast %SourceSpan* %t1065 to i8*
  %t1067 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1020, i8* %s1021, i8* %t1066)
  store %ScopeResult %t1067, %ScopeResult* %l9
  %t1068 = load %ScopeResult, %ScopeResult* %l9
  %t1069 = extractvalue %ScopeResult %t1068, 1
  store { %Diagnostic**, i64 }* %t1069, { %Diagnostic**, i64 }** %l10
  %t1070 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l10
  %t1071 = extractvalue %Statement %statement, 0
  %t1072 = alloca %Statement
  store %Statement %statement, %Statement* %t1072
  %t1073 = getelementptr inbounds %Statement, %Statement* %t1072, i32 0, i32 1
  %t1074 = bitcast [56 x i8]* %t1073 to i8*
  %t1075 = getelementptr inbounds i8, i8* %t1074, i64 16
  %t1076 = bitcast i8* %t1075 to { %TypeParameter**, i64 }**
  %t1077 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1076
  %t1078 = icmp eq i32 %t1071, 8
  %t1079 = select i1 %t1078, { %TypeParameter**, i64 }* %t1077, { %TypeParameter**, i64 }* null
  %t1080 = getelementptr inbounds %Statement, %Statement* %t1072, i32 0, i32 1
  %t1081 = bitcast [40 x i8]* %t1080 to i8*
  %t1082 = getelementptr inbounds i8, i8* %t1081, i64 16
  %t1083 = bitcast i8* %t1082 to { %TypeParameter**, i64 }**
  %t1084 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1083
  %t1085 = icmp eq i32 %t1071, 9
  %t1086 = select i1 %t1085, { %TypeParameter**, i64 }* %t1084, { %TypeParameter**, i64 }* %t1079
  %t1087 = getelementptr inbounds %Statement, %Statement* %t1072, i32 0, i32 1
  %t1088 = bitcast [40 x i8]* %t1087 to i8*
  %t1089 = getelementptr inbounds i8, i8* %t1088, i64 16
  %t1090 = bitcast i8* %t1089 to { %TypeParameter**, i64 }**
  %t1091 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1090
  %t1092 = icmp eq i32 %t1071, 10
  %t1093 = select i1 %t1092, { %TypeParameter**, i64 }* %t1091, { %TypeParameter**, i64 }* %t1086
  %t1094 = getelementptr inbounds %Statement, %Statement* %t1072, i32 0, i32 1
  %t1095 = bitcast [40 x i8]* %t1094 to i8*
  %t1096 = getelementptr inbounds i8, i8* %t1095, i64 16
  %t1097 = bitcast i8* %t1096 to { %TypeParameter**, i64 }**
  %t1098 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1097
  %t1099 = icmp eq i32 %t1071, 11
  %t1100 = select i1 %t1099, { %TypeParameter**, i64 }* %t1098, { %TypeParameter**, i64 }* %t1093
  %t1101 = bitcast { %TypeParameter**, i64 }* %t1100 to { %TypeParameter*, i64 }*
  %t1102 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t1101)
  %t1103 = bitcast { %Diagnostic**, i64 }* %t1070 to { i8**, i64 }*
  %t1104 = bitcast { %Diagnostic*, i64 }* %t1102 to { i8**, i64 }*
  %t1105 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1103, { i8**, i64 }* %t1104)
  %t1106 = bitcast { i8**, i64 }* %t1105 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1106, { %Diagnostic**, i64 }** %l10
  %t1107 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l10
  %t1108 = extractvalue %Statement %statement, 0
  %t1109 = alloca %Statement
  store %Statement %statement, %Statement* %t1109
  %t1110 = getelementptr inbounds %Statement, %Statement* %t1109, i32 0, i32 1
  %t1111 = bitcast [40 x i8]* %t1110 to i8*
  %t1112 = getelementptr inbounds i8, i8* %t1111, i64 24
  %t1113 = bitcast i8* %t1112 to { %FunctionSignature**, i64 }**
  %t1114 = load { %FunctionSignature**, i64 }*, { %FunctionSignature**, i64 }** %t1113
  %t1115 = icmp eq i32 %t1108, 10
  %t1116 = select i1 %t1115, { %FunctionSignature**, i64 }* %t1114, { %FunctionSignature**, i64 }* null
  %t1117 = bitcast { %FunctionSignature**, i64 }* %t1116 to { %FunctionSignature*, i64 }*
  %t1118 = call { %Diagnostic*, i64 }* @check_interface_members({ %FunctionSignature*, i64 }* %t1117)
  %t1119 = bitcast { %Diagnostic**, i64 }* %t1107 to { i8**, i64 }*
  %t1120 = bitcast { %Diagnostic*, i64 }* %t1118 to { i8**, i64 }*
  %t1121 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1119, { i8**, i64 }* %t1120)
  %t1122 = bitcast { i8**, i64 }* %t1121 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1122, { %Diagnostic**, i64 }** %l10
  %t1123 = load %ScopeResult, %ScopeResult* %l9
  %t1124 = extractvalue %ScopeResult %t1123, 0
  %t1125 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1124, 0
  %t1126 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l10
  %t1127 = insertvalue %ScopeResult %t1125, { %Diagnostic**, i64 }* %t1126, 1
  ret %ScopeResult %t1127
merge15:
  %t1128 = extractvalue %Statement %statement, 0
  %t1129 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1130 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1131 = icmp eq i32 %t1128, 0
  %t1132 = select i1 %t1131, i8* %t1130, i8* %t1129
  %t1133 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1134 = icmp eq i32 %t1128, 1
  %t1135 = select i1 %t1134, i8* %t1133, i8* %t1132
  %t1136 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1137 = icmp eq i32 %t1128, 2
  %t1138 = select i1 %t1137, i8* %t1136, i8* %t1135
  %t1139 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1140 = icmp eq i32 %t1128, 3
  %t1141 = select i1 %t1140, i8* %t1139, i8* %t1138
  %t1142 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1143 = icmp eq i32 %t1128, 4
  %t1144 = select i1 %t1143, i8* %t1142, i8* %t1141
  %t1145 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1146 = icmp eq i32 %t1128, 5
  %t1147 = select i1 %t1146, i8* %t1145, i8* %t1144
  %t1148 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1149 = icmp eq i32 %t1128, 6
  %t1150 = select i1 %t1149, i8* %t1148, i8* %t1147
  %t1151 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1152 = icmp eq i32 %t1128, 7
  %t1153 = select i1 %t1152, i8* %t1151, i8* %t1150
  %t1154 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1155 = icmp eq i32 %t1128, 8
  %t1156 = select i1 %t1155, i8* %t1154, i8* %t1153
  %t1157 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1158 = icmp eq i32 %t1128, 9
  %t1159 = select i1 %t1158, i8* %t1157, i8* %t1156
  %t1160 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1161 = icmp eq i32 %t1128, 10
  %t1162 = select i1 %t1161, i8* %t1160, i8* %t1159
  %t1163 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1164 = icmp eq i32 %t1128, 11
  %t1165 = select i1 %t1164, i8* %t1163, i8* %t1162
  %t1166 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1167 = icmp eq i32 %t1128, 12
  %t1168 = select i1 %t1167, i8* %t1166, i8* %t1165
  %t1169 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1170 = icmp eq i32 %t1128, 13
  %t1171 = select i1 %t1170, i8* %t1169, i8* %t1168
  %t1172 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1173 = icmp eq i32 %t1128, 14
  %t1174 = select i1 %t1173, i8* %t1172, i8* %t1171
  %t1175 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1176 = icmp eq i32 %t1128, 15
  %t1177 = select i1 %t1176, i8* %t1175, i8* %t1174
  %t1178 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1179 = icmp eq i32 %t1128, 16
  %t1180 = select i1 %t1179, i8* %t1178, i8* %t1177
  %t1181 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1182 = icmp eq i32 %t1128, 17
  %t1183 = select i1 %t1182, i8* %t1181, i8* %t1180
  %t1184 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1185 = icmp eq i32 %t1128, 18
  %t1186 = select i1 %t1185, i8* %t1184, i8* %t1183
  %t1187 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1188 = icmp eq i32 %t1128, 19
  %t1189 = select i1 %t1188, i8* %t1187, i8* %t1186
  %t1190 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1191 = icmp eq i32 %t1128, 20
  %t1192 = select i1 %t1191, i8* %t1190, i8* %t1189
  %t1193 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1194 = icmp eq i32 %t1128, 21
  %t1195 = select i1 %t1194, i8* %t1193, i8* %t1192
  %t1196 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1197 = icmp eq i32 %t1128, 22
  %t1198 = select i1 %t1197, i8* %t1196, i8* %t1195
  %s1199 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.1199, i32 0, i32 0
  %t1200 = icmp eq i8* %t1198, %s1199
  br i1 %t1200, label %then16, label %merge17
then16:
  %t1201 = extractvalue %Statement %statement, 0
  %t1202 = alloca %Statement
  store %Statement %statement, %Statement* %t1202
  %t1203 = getelementptr inbounds %Statement, %Statement* %t1202, i32 0, i32 1
  %t1204 = bitcast [48 x i8]* %t1203 to i8*
  %t1205 = bitcast i8* %t1204 to i8**
  %t1206 = load i8*, i8** %t1205
  %t1207 = icmp eq i32 %t1201, 2
  %t1208 = select i1 %t1207, i8* %t1206, i8* null
  %t1209 = getelementptr inbounds %Statement, %Statement* %t1202, i32 0, i32 1
  %t1210 = bitcast [48 x i8]* %t1209 to i8*
  %t1211 = bitcast i8* %t1210 to i8**
  %t1212 = load i8*, i8** %t1211
  %t1213 = icmp eq i32 %t1201, 3
  %t1214 = select i1 %t1213, i8* %t1212, i8* %t1208
  %t1215 = getelementptr inbounds %Statement, %Statement* %t1202, i32 0, i32 1
  %t1216 = bitcast [40 x i8]* %t1215 to i8*
  %t1217 = bitcast i8* %t1216 to i8**
  %t1218 = load i8*, i8** %t1217
  %t1219 = icmp eq i32 %t1201, 6
  %t1220 = select i1 %t1219, i8* %t1218, i8* %t1214
  %t1221 = getelementptr inbounds %Statement, %Statement* %t1202, i32 0, i32 1
  %t1222 = bitcast [56 x i8]* %t1221 to i8*
  %t1223 = bitcast i8* %t1222 to i8**
  %t1224 = load i8*, i8** %t1223
  %t1225 = icmp eq i32 %t1201, 8
  %t1226 = select i1 %t1225, i8* %t1224, i8* %t1220
  %t1227 = getelementptr inbounds %Statement, %Statement* %t1202, i32 0, i32 1
  %t1228 = bitcast [40 x i8]* %t1227 to i8*
  %t1229 = bitcast i8* %t1228 to i8**
  %t1230 = load i8*, i8** %t1229
  %t1231 = icmp eq i32 %t1201, 9
  %t1232 = select i1 %t1231, i8* %t1230, i8* %t1226
  %t1233 = getelementptr inbounds %Statement, %Statement* %t1202, i32 0, i32 1
  %t1234 = bitcast [40 x i8]* %t1233 to i8*
  %t1235 = bitcast i8* %t1234 to i8**
  %t1236 = load i8*, i8** %t1235
  %t1237 = icmp eq i32 %t1201, 10
  %t1238 = select i1 %t1237, i8* %t1236, i8* %t1232
  %t1239 = getelementptr inbounds %Statement, %Statement* %t1202, i32 0, i32 1
  %t1240 = bitcast [40 x i8]* %t1239 to i8*
  %t1241 = bitcast i8* %t1240 to i8**
  %t1242 = load i8*, i8** %t1241
  %t1243 = icmp eq i32 %t1201, 11
  %t1244 = select i1 %t1243, i8* %t1242, i8* %t1238
  %s1245 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1245, i32 0, i32 0
  %t1246 = extractvalue %Statement %statement, 0
  %t1247 = alloca %Statement
  store %Statement %statement, %Statement* %t1247
  %t1248 = getelementptr inbounds %Statement, %Statement* %t1247, i32 0, i32 1
  %t1249 = bitcast [48 x i8]* %t1248 to i8*
  %t1250 = getelementptr inbounds i8, i8* %t1249, i64 8
  %t1251 = bitcast i8* %t1250 to %SourceSpan**
  %t1252 = load %SourceSpan*, %SourceSpan** %t1251
  %t1253 = icmp eq i32 %t1246, 3
  %t1254 = select i1 %t1253, %SourceSpan* %t1252, %SourceSpan* null
  %t1255 = getelementptr inbounds %Statement, %Statement* %t1247, i32 0, i32 1
  %t1256 = bitcast [40 x i8]* %t1255 to i8*
  %t1257 = getelementptr inbounds i8, i8* %t1256, i64 8
  %t1258 = bitcast i8* %t1257 to %SourceSpan**
  %t1259 = load %SourceSpan*, %SourceSpan** %t1258
  %t1260 = icmp eq i32 %t1246, 6
  %t1261 = select i1 %t1260, %SourceSpan* %t1259, %SourceSpan* %t1254
  %t1262 = getelementptr inbounds %Statement, %Statement* %t1247, i32 0, i32 1
  %t1263 = bitcast [56 x i8]* %t1262 to i8*
  %t1264 = getelementptr inbounds i8, i8* %t1263, i64 8
  %t1265 = bitcast i8* %t1264 to %SourceSpan**
  %t1266 = load %SourceSpan*, %SourceSpan** %t1265
  %t1267 = icmp eq i32 %t1246, 8
  %t1268 = select i1 %t1267, %SourceSpan* %t1266, %SourceSpan* %t1261
  %t1269 = getelementptr inbounds %Statement, %Statement* %t1247, i32 0, i32 1
  %t1270 = bitcast [40 x i8]* %t1269 to i8*
  %t1271 = getelementptr inbounds i8, i8* %t1270, i64 8
  %t1272 = bitcast i8* %t1271 to %SourceSpan**
  %t1273 = load %SourceSpan*, %SourceSpan** %t1272
  %t1274 = icmp eq i32 %t1246, 9
  %t1275 = select i1 %t1274, %SourceSpan* %t1273, %SourceSpan* %t1268
  %t1276 = getelementptr inbounds %Statement, %Statement* %t1247, i32 0, i32 1
  %t1277 = bitcast [40 x i8]* %t1276 to i8*
  %t1278 = getelementptr inbounds i8, i8* %t1277, i64 8
  %t1279 = bitcast i8* %t1278 to %SourceSpan**
  %t1280 = load %SourceSpan*, %SourceSpan** %t1279
  %t1281 = icmp eq i32 %t1246, 10
  %t1282 = select i1 %t1281, %SourceSpan* %t1280, %SourceSpan* %t1275
  %t1283 = getelementptr inbounds %Statement, %Statement* %t1247, i32 0, i32 1
  %t1284 = bitcast [40 x i8]* %t1283 to i8*
  %t1285 = getelementptr inbounds i8, i8* %t1284, i64 8
  %t1286 = bitcast i8* %t1285 to %SourceSpan**
  %t1287 = load %SourceSpan*, %SourceSpan** %t1286
  %t1288 = icmp eq i32 %t1246, 11
  %t1289 = select i1 %t1288, %SourceSpan* %t1287, %SourceSpan* %t1282
  %t1290 = bitcast %SourceSpan* %t1289 to i8*
  %t1291 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1244, i8* %s1245, i8* %t1290)
  store %ScopeResult %t1291, %ScopeResult* %l11
  %t1292 = load %ScopeResult, %ScopeResult* %l11
  %t1293 = extractvalue %ScopeResult %t1292, 1
  %t1294 = extractvalue %Statement %statement, 0
  %t1295 = alloca %Statement
  store %Statement %statement, %Statement* %t1295
  %t1296 = getelementptr inbounds %Statement, %Statement* %t1295, i32 0, i32 1
  %t1297 = bitcast [48 x i8]* %t1296 to i8*
  %t1298 = getelementptr inbounds i8, i8* %t1297, i64 24
  %t1299 = bitcast i8* %t1298 to { %ModelProperty**, i64 }**
  %t1300 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1299
  %t1301 = icmp eq i32 %t1294, 3
  %t1302 = select i1 %t1301, { %ModelProperty**, i64 }* %t1300, { %ModelProperty**, i64 }* null
  %t1303 = bitcast { %ModelProperty**, i64 }* %t1302 to { %ModelProperty*, i64 }*
  %t1304 = call { %Diagnostic*, i64 }* @check_model_properties({ %ModelProperty*, i64 }* %t1303)
  %t1305 = bitcast { %Diagnostic**, i64 }* %t1293 to { i8**, i64 }*
  %t1306 = bitcast { %Diagnostic*, i64 }* %t1304 to { i8**, i64 }*
  %t1307 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1305, { i8**, i64 }* %t1306)
  store { i8**, i64 }* %t1307, { i8**, i64 }** %l12
  %t1308 = load %ScopeResult, %ScopeResult* %l11
  %t1309 = extractvalue %ScopeResult %t1308, 0
  %t1310 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1309, 0
  %t1311 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %t1312 = bitcast { i8**, i64 }* %t1311 to { %Diagnostic**, i64 }*
  %t1313 = insertvalue %ScopeResult %t1310, { %Diagnostic**, i64 }* %t1312, 1
  ret %ScopeResult %t1313
merge17:
  %t1314 = extractvalue %Statement %statement, 0
  %t1315 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1316 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1317 = icmp eq i32 %t1314, 0
  %t1318 = select i1 %t1317, i8* %t1316, i8* %t1315
  %t1319 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1320 = icmp eq i32 %t1314, 1
  %t1321 = select i1 %t1320, i8* %t1319, i8* %t1318
  %t1322 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1323 = icmp eq i32 %t1314, 2
  %t1324 = select i1 %t1323, i8* %t1322, i8* %t1321
  %t1325 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1326 = icmp eq i32 %t1314, 3
  %t1327 = select i1 %t1326, i8* %t1325, i8* %t1324
  %t1328 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1329 = icmp eq i32 %t1314, 4
  %t1330 = select i1 %t1329, i8* %t1328, i8* %t1327
  %t1331 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1332 = icmp eq i32 %t1314, 5
  %t1333 = select i1 %t1332, i8* %t1331, i8* %t1330
  %t1334 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1335 = icmp eq i32 %t1314, 6
  %t1336 = select i1 %t1335, i8* %t1334, i8* %t1333
  %t1337 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1338 = icmp eq i32 %t1314, 7
  %t1339 = select i1 %t1338, i8* %t1337, i8* %t1336
  %t1340 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1341 = icmp eq i32 %t1314, 8
  %t1342 = select i1 %t1341, i8* %t1340, i8* %t1339
  %t1343 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1344 = icmp eq i32 %t1314, 9
  %t1345 = select i1 %t1344, i8* %t1343, i8* %t1342
  %t1346 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1347 = icmp eq i32 %t1314, 10
  %t1348 = select i1 %t1347, i8* %t1346, i8* %t1345
  %t1349 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1350 = icmp eq i32 %t1314, 11
  %t1351 = select i1 %t1350, i8* %t1349, i8* %t1348
  %t1352 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1353 = icmp eq i32 %t1314, 12
  %t1354 = select i1 %t1353, i8* %t1352, i8* %t1351
  %t1355 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1356 = icmp eq i32 %t1314, 13
  %t1357 = select i1 %t1356, i8* %t1355, i8* %t1354
  %t1358 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1359 = icmp eq i32 %t1314, 14
  %t1360 = select i1 %t1359, i8* %t1358, i8* %t1357
  %t1361 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1362 = icmp eq i32 %t1314, 15
  %t1363 = select i1 %t1362, i8* %t1361, i8* %t1360
  %t1364 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1365 = icmp eq i32 %t1314, 16
  %t1366 = select i1 %t1365, i8* %t1364, i8* %t1363
  %t1367 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1368 = icmp eq i32 %t1314, 17
  %t1369 = select i1 %t1368, i8* %t1367, i8* %t1366
  %t1370 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1371 = icmp eq i32 %t1314, 18
  %t1372 = select i1 %t1371, i8* %t1370, i8* %t1369
  %t1373 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1374 = icmp eq i32 %t1314, 19
  %t1375 = select i1 %t1374, i8* %t1373, i8* %t1372
  %t1376 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1377 = icmp eq i32 %t1314, 20
  %t1378 = select i1 %t1377, i8* %t1376, i8* %t1375
  %t1379 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1380 = icmp eq i32 %t1314, 21
  %t1381 = select i1 %t1380, i8* %t1379, i8* %t1378
  %t1382 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1383 = icmp eq i32 %t1314, 22
  %t1384 = select i1 %t1383, i8* %t1382, i8* %t1381
  %s1385 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1385, i32 0, i32 0
  %t1386 = icmp eq i8* %t1384, %s1385
  br i1 %t1386, label %then18, label %merge19
then18:
  %t1387 = extractvalue %Statement %statement, 0
  %t1388 = alloca %Statement
  store %Statement %statement, %Statement* %t1388
  %t1389 = getelementptr inbounds %Statement, %Statement* %t1388, i32 0, i32 1
  %t1390 = bitcast [24 x i8]* %t1389 to i8*
  %t1391 = bitcast i8* %t1390 to %FunctionSignature*
  %t1392 = load %FunctionSignature, %FunctionSignature* %t1391
  %t1393 = icmp eq i32 %t1387, 4
  %t1394 = select i1 %t1393, %FunctionSignature %t1392, %FunctionSignature zeroinitializer
  %t1395 = getelementptr inbounds %Statement, %Statement* %t1388, i32 0, i32 1
  %t1396 = bitcast [24 x i8]* %t1395 to i8*
  %t1397 = bitcast i8* %t1396 to %FunctionSignature*
  %t1398 = load %FunctionSignature, %FunctionSignature* %t1397
  %t1399 = icmp eq i32 %t1387, 5
  %t1400 = select i1 %t1399, %FunctionSignature %t1398, %FunctionSignature %t1394
  %t1401 = getelementptr inbounds %Statement, %Statement* %t1388, i32 0, i32 1
  %t1402 = bitcast [24 x i8]* %t1401 to i8*
  %t1403 = bitcast i8* %t1402 to %FunctionSignature*
  %t1404 = load %FunctionSignature, %FunctionSignature* %t1403
  %t1405 = icmp eq i32 %t1387, 7
  %t1406 = select i1 %t1405, %FunctionSignature %t1404, %FunctionSignature %t1400
  %t1407 = extractvalue %FunctionSignature %t1406, 0
  %s1408 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1408, i32 0, i32 0
  %t1409 = extractvalue %Statement %statement, 0
  %t1410 = alloca %Statement
  store %Statement %statement, %Statement* %t1410
  %t1411 = getelementptr inbounds %Statement, %Statement* %t1410, i32 0, i32 1
  %t1412 = bitcast [24 x i8]* %t1411 to i8*
  %t1413 = bitcast i8* %t1412 to %FunctionSignature*
  %t1414 = load %FunctionSignature, %FunctionSignature* %t1413
  %t1415 = icmp eq i32 %t1409, 4
  %t1416 = select i1 %t1415, %FunctionSignature %t1414, %FunctionSignature zeroinitializer
  %t1417 = getelementptr inbounds %Statement, %Statement* %t1410, i32 0, i32 1
  %t1418 = bitcast [24 x i8]* %t1417 to i8*
  %t1419 = bitcast i8* %t1418 to %FunctionSignature*
  %t1420 = load %FunctionSignature, %FunctionSignature* %t1419
  %t1421 = icmp eq i32 %t1409, 5
  %t1422 = select i1 %t1421, %FunctionSignature %t1420, %FunctionSignature %t1416
  %t1423 = getelementptr inbounds %Statement, %Statement* %t1410, i32 0, i32 1
  %t1424 = bitcast [24 x i8]* %t1423 to i8*
  %t1425 = bitcast i8* %t1424 to %FunctionSignature*
  %t1426 = load %FunctionSignature, %FunctionSignature* %t1425
  %t1427 = icmp eq i32 %t1409, 7
  %t1428 = select i1 %t1427, %FunctionSignature %t1426, %FunctionSignature %t1422
  %t1429 = extractvalue %FunctionSignature %t1428, 6
  %t1430 = bitcast %SourceSpan* %t1429 to i8*
  %t1431 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1407, i8* %s1408, i8* %t1430)
  store %ScopeResult %t1431, %ScopeResult* %l13
  %t1432 = load %ScopeResult, %ScopeResult* %l13
  %t1433 = extractvalue %ScopeResult %t1432, 1
  store { %Diagnostic**, i64 }* %t1433, { %Diagnostic**, i64 }** %l14
  %t1434 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l14
  %t1435 = extractvalue %Statement %statement, 0
  %t1436 = alloca %Statement
  store %Statement %statement, %Statement* %t1436
  %t1437 = getelementptr inbounds %Statement, %Statement* %t1436, i32 0, i32 1
  %t1438 = bitcast [24 x i8]* %t1437 to i8*
  %t1439 = bitcast i8* %t1438 to %FunctionSignature*
  %t1440 = load %FunctionSignature, %FunctionSignature* %t1439
  %t1441 = icmp eq i32 %t1435, 4
  %t1442 = select i1 %t1441, %FunctionSignature %t1440, %FunctionSignature zeroinitializer
  %t1443 = getelementptr inbounds %Statement, %Statement* %t1436, i32 0, i32 1
  %t1444 = bitcast [24 x i8]* %t1443 to i8*
  %t1445 = bitcast i8* %t1444 to %FunctionSignature*
  %t1446 = load %FunctionSignature, %FunctionSignature* %t1445
  %t1447 = icmp eq i32 %t1435, 5
  %t1448 = select i1 %t1447, %FunctionSignature %t1446, %FunctionSignature %t1442
  %t1449 = getelementptr inbounds %Statement, %Statement* %t1436, i32 0, i32 1
  %t1450 = bitcast [24 x i8]* %t1449 to i8*
  %t1451 = bitcast i8* %t1450 to %FunctionSignature*
  %t1452 = load %FunctionSignature, %FunctionSignature* %t1451
  %t1453 = icmp eq i32 %t1435, 7
  %t1454 = select i1 %t1453, %FunctionSignature %t1452, %FunctionSignature %t1448
  %t1455 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t1454)
  %t1456 = bitcast { %Diagnostic**, i64 }* %t1434 to { i8**, i64 }*
  %t1457 = bitcast { %Diagnostic*, i64 }* %t1455 to { i8**, i64 }*
  %t1458 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1456, { i8**, i64 }* %t1457)
  %t1459 = bitcast { i8**, i64 }* %t1458 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1459, { %Diagnostic**, i64 }** %l14
  %t1460 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l14
  %t1461 = extractvalue %Statement %statement, 0
  %t1462 = alloca %Statement
  store %Statement %statement, %Statement* %t1462
  %t1463 = getelementptr inbounds %Statement, %Statement* %t1462, i32 0, i32 1
  %t1464 = bitcast [24 x i8]* %t1463 to i8*
  %t1465 = bitcast i8* %t1464 to %FunctionSignature*
  %t1466 = load %FunctionSignature, %FunctionSignature* %t1465
  %t1467 = icmp eq i32 %t1461, 4
  %t1468 = select i1 %t1467, %FunctionSignature %t1466, %FunctionSignature zeroinitializer
  %t1469 = getelementptr inbounds %Statement, %Statement* %t1462, i32 0, i32 1
  %t1470 = bitcast [24 x i8]* %t1469 to i8*
  %t1471 = bitcast i8* %t1470 to %FunctionSignature*
  %t1472 = load %FunctionSignature, %FunctionSignature* %t1471
  %t1473 = icmp eq i32 %t1461, 5
  %t1474 = select i1 %t1473, %FunctionSignature %t1472, %FunctionSignature %t1468
  %t1475 = getelementptr inbounds %Statement, %Statement* %t1462, i32 0, i32 1
  %t1476 = bitcast [24 x i8]* %t1475 to i8*
  %t1477 = bitcast i8* %t1476 to %FunctionSignature*
  %t1478 = load %FunctionSignature, %FunctionSignature* %t1477
  %t1479 = icmp eq i32 %t1461, 7
  %t1480 = select i1 %t1479, %FunctionSignature %t1478, %FunctionSignature %t1474
  %t1481 = extractvalue %Statement %statement, 0
  %t1482 = alloca %Statement
  store %Statement %statement, %Statement* %t1482
  %t1483 = getelementptr inbounds %Statement, %Statement* %t1482, i32 0, i32 1
  %t1484 = bitcast [24 x i8]* %t1483 to i8*
  %t1485 = getelementptr inbounds i8, i8* %t1484, i64 8
  %t1486 = bitcast i8* %t1485 to %Block*
  %t1487 = load %Block, %Block* %t1486
  %t1488 = icmp eq i32 %t1481, 4
  %t1489 = select i1 %t1488, %Block %t1487, %Block zeroinitializer
  %t1490 = getelementptr inbounds %Statement, %Statement* %t1482, i32 0, i32 1
  %t1491 = bitcast [24 x i8]* %t1490 to i8*
  %t1492 = getelementptr inbounds i8, i8* %t1491, i64 8
  %t1493 = bitcast i8* %t1492 to %Block*
  %t1494 = load %Block, %Block* %t1493
  %t1495 = icmp eq i32 %t1481, 5
  %t1496 = select i1 %t1495, %Block %t1494, %Block %t1489
  %t1497 = getelementptr inbounds %Statement, %Statement* %t1482, i32 0, i32 1
  %t1498 = bitcast [40 x i8]* %t1497 to i8*
  %t1499 = getelementptr inbounds i8, i8* %t1498, i64 16
  %t1500 = bitcast i8* %t1499 to %Block*
  %t1501 = load %Block, %Block* %t1500
  %t1502 = icmp eq i32 %t1481, 6
  %t1503 = select i1 %t1502, %Block %t1501, %Block %t1496
  %t1504 = getelementptr inbounds %Statement, %Statement* %t1482, i32 0, i32 1
  %t1505 = bitcast [24 x i8]* %t1504 to i8*
  %t1506 = getelementptr inbounds i8, i8* %t1505, i64 8
  %t1507 = bitcast i8* %t1506 to %Block*
  %t1508 = load %Block, %Block* %t1507
  %t1509 = icmp eq i32 %t1481, 7
  %t1510 = select i1 %t1509, %Block %t1508, %Block %t1503
  %t1511 = getelementptr inbounds %Statement, %Statement* %t1482, i32 0, i32 1
  %t1512 = bitcast [40 x i8]* %t1511 to i8*
  %t1513 = getelementptr inbounds i8, i8* %t1512, i64 24
  %t1514 = bitcast i8* %t1513 to %Block*
  %t1515 = load %Block, %Block* %t1514
  %t1516 = icmp eq i32 %t1481, 12
  %t1517 = select i1 %t1516, %Block %t1515, %Block %t1510
  %t1518 = getelementptr inbounds %Statement, %Statement* %t1482, i32 0, i32 1
  %t1519 = bitcast [24 x i8]* %t1518 to i8*
  %t1520 = getelementptr inbounds i8, i8* %t1519, i64 8
  %t1521 = bitcast i8* %t1520 to %Block*
  %t1522 = load %Block, %Block* %t1521
  %t1523 = icmp eq i32 %t1481, 13
  %t1524 = select i1 %t1523, %Block %t1522, %Block %t1517
  %t1525 = getelementptr inbounds %Statement, %Statement* %t1482, i32 0, i32 1
  %t1526 = bitcast [24 x i8]* %t1525 to i8*
  %t1527 = getelementptr inbounds i8, i8* %t1526, i64 8
  %t1528 = bitcast i8* %t1527 to %Block*
  %t1529 = load %Block, %Block* %t1528
  %t1530 = icmp eq i32 %t1481, 14
  %t1531 = select i1 %t1530, %Block %t1529, %Block %t1524
  %t1532 = getelementptr inbounds %Statement, %Statement* %t1482, i32 0, i32 1
  %t1533 = bitcast [16 x i8]* %t1532 to i8*
  %t1534 = bitcast i8* %t1533 to %Block*
  %t1535 = load %Block, %Block* %t1534
  %t1536 = icmp eq i32 %t1481, 15
  %t1537 = select i1 %t1536, %Block %t1535, %Block %t1531
  %t1538 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t1480, %Block %t1537, { %Statement*, i64 }* %interfaces)
  %t1539 = bitcast { %Diagnostic**, i64 }* %t1460 to { i8**, i64 }*
  %t1540 = bitcast { %Diagnostic*, i64 }* %t1538 to { i8**, i64 }*
  %t1541 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1539, { i8**, i64 }* %t1540)
  %t1542 = bitcast { i8**, i64 }* %t1541 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1542, { %Diagnostic**, i64 }** %l14
  %t1543 = load %ScopeResult, %ScopeResult* %l13
  %t1544 = extractvalue %ScopeResult %t1543, 0
  %t1545 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1544, 0
  %t1546 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l14
  %t1547 = insertvalue %ScopeResult %t1545, { %Diagnostic**, i64 }* %t1546, 1
  ret %ScopeResult %t1547
merge19:
  %t1548 = extractvalue %Statement %statement, 0
  %t1549 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1550 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1551 = icmp eq i32 %t1548, 0
  %t1552 = select i1 %t1551, i8* %t1550, i8* %t1549
  %t1553 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1554 = icmp eq i32 %t1548, 1
  %t1555 = select i1 %t1554, i8* %t1553, i8* %t1552
  %t1556 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1557 = icmp eq i32 %t1548, 2
  %t1558 = select i1 %t1557, i8* %t1556, i8* %t1555
  %t1559 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1560 = icmp eq i32 %t1548, 3
  %t1561 = select i1 %t1560, i8* %t1559, i8* %t1558
  %t1562 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1563 = icmp eq i32 %t1548, 4
  %t1564 = select i1 %t1563, i8* %t1562, i8* %t1561
  %t1565 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1566 = icmp eq i32 %t1548, 5
  %t1567 = select i1 %t1566, i8* %t1565, i8* %t1564
  %t1568 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1569 = icmp eq i32 %t1548, 6
  %t1570 = select i1 %t1569, i8* %t1568, i8* %t1567
  %t1571 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1572 = icmp eq i32 %t1548, 7
  %t1573 = select i1 %t1572, i8* %t1571, i8* %t1570
  %t1574 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1575 = icmp eq i32 %t1548, 8
  %t1576 = select i1 %t1575, i8* %t1574, i8* %t1573
  %t1577 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1578 = icmp eq i32 %t1548, 9
  %t1579 = select i1 %t1578, i8* %t1577, i8* %t1576
  %t1580 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1581 = icmp eq i32 %t1548, 10
  %t1582 = select i1 %t1581, i8* %t1580, i8* %t1579
  %t1583 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1584 = icmp eq i32 %t1548, 11
  %t1585 = select i1 %t1584, i8* %t1583, i8* %t1582
  %t1586 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1587 = icmp eq i32 %t1548, 12
  %t1588 = select i1 %t1587, i8* %t1586, i8* %t1585
  %t1589 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1590 = icmp eq i32 %t1548, 13
  %t1591 = select i1 %t1590, i8* %t1589, i8* %t1588
  %t1592 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1593 = icmp eq i32 %t1548, 14
  %t1594 = select i1 %t1593, i8* %t1592, i8* %t1591
  %t1595 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1596 = icmp eq i32 %t1548, 15
  %t1597 = select i1 %t1596, i8* %t1595, i8* %t1594
  %t1598 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1599 = icmp eq i32 %t1548, 16
  %t1600 = select i1 %t1599, i8* %t1598, i8* %t1597
  %t1601 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1602 = icmp eq i32 %t1548, 17
  %t1603 = select i1 %t1602, i8* %t1601, i8* %t1600
  %t1604 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1605 = icmp eq i32 %t1548, 18
  %t1606 = select i1 %t1605, i8* %t1604, i8* %t1603
  %t1607 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1608 = icmp eq i32 %t1548, 19
  %t1609 = select i1 %t1608, i8* %t1607, i8* %t1606
  %t1610 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1611 = icmp eq i32 %t1548, 20
  %t1612 = select i1 %t1611, i8* %t1610, i8* %t1609
  %t1613 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1614 = icmp eq i32 %t1548, 21
  %t1615 = select i1 %t1614, i8* %t1613, i8* %t1612
  %t1616 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1617 = icmp eq i32 %t1548, 22
  %t1618 = select i1 %t1617, i8* %t1616, i8* %t1615
  %s1619 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1619, i32 0, i32 0
  %t1620 = icmp eq i8* %t1618, %s1619
  br i1 %t1620, label %then20, label %merge21
then20:
  %t1621 = extractvalue %Statement %statement, 0
  %t1622 = alloca %Statement
  store %Statement %statement, %Statement* %t1622
  %t1623 = getelementptr inbounds %Statement, %Statement* %t1622, i32 0, i32 1
  %t1624 = bitcast [24 x i8]* %t1623 to i8*
  %t1625 = bitcast i8* %t1624 to %FunctionSignature*
  %t1626 = load %FunctionSignature, %FunctionSignature* %t1625
  %t1627 = icmp eq i32 %t1621, 4
  %t1628 = select i1 %t1627, %FunctionSignature %t1626, %FunctionSignature zeroinitializer
  %t1629 = getelementptr inbounds %Statement, %Statement* %t1622, i32 0, i32 1
  %t1630 = bitcast [24 x i8]* %t1629 to i8*
  %t1631 = bitcast i8* %t1630 to %FunctionSignature*
  %t1632 = load %FunctionSignature, %FunctionSignature* %t1631
  %t1633 = icmp eq i32 %t1621, 5
  %t1634 = select i1 %t1633, %FunctionSignature %t1632, %FunctionSignature %t1628
  %t1635 = getelementptr inbounds %Statement, %Statement* %t1622, i32 0, i32 1
  %t1636 = bitcast [24 x i8]* %t1635 to i8*
  %t1637 = bitcast i8* %t1636 to %FunctionSignature*
  %t1638 = load %FunctionSignature, %FunctionSignature* %t1637
  %t1639 = icmp eq i32 %t1621, 7
  %t1640 = select i1 %t1639, %FunctionSignature %t1638, %FunctionSignature %t1634
  %t1641 = extractvalue %FunctionSignature %t1640, 0
  %s1642 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1642, i32 0, i32 0
  %t1643 = extractvalue %Statement %statement, 0
  %t1644 = alloca %Statement
  store %Statement %statement, %Statement* %t1644
  %t1645 = getelementptr inbounds %Statement, %Statement* %t1644, i32 0, i32 1
  %t1646 = bitcast [24 x i8]* %t1645 to i8*
  %t1647 = bitcast i8* %t1646 to %FunctionSignature*
  %t1648 = load %FunctionSignature, %FunctionSignature* %t1647
  %t1649 = icmp eq i32 %t1643, 4
  %t1650 = select i1 %t1649, %FunctionSignature %t1648, %FunctionSignature zeroinitializer
  %t1651 = getelementptr inbounds %Statement, %Statement* %t1644, i32 0, i32 1
  %t1652 = bitcast [24 x i8]* %t1651 to i8*
  %t1653 = bitcast i8* %t1652 to %FunctionSignature*
  %t1654 = load %FunctionSignature, %FunctionSignature* %t1653
  %t1655 = icmp eq i32 %t1643, 5
  %t1656 = select i1 %t1655, %FunctionSignature %t1654, %FunctionSignature %t1650
  %t1657 = getelementptr inbounds %Statement, %Statement* %t1644, i32 0, i32 1
  %t1658 = bitcast [24 x i8]* %t1657 to i8*
  %t1659 = bitcast i8* %t1658 to %FunctionSignature*
  %t1660 = load %FunctionSignature, %FunctionSignature* %t1659
  %t1661 = icmp eq i32 %t1643, 7
  %t1662 = select i1 %t1661, %FunctionSignature %t1660, %FunctionSignature %t1656
  %t1663 = extractvalue %FunctionSignature %t1662, 6
  %t1664 = bitcast %SourceSpan* %t1663 to i8*
  %t1665 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1641, i8* %s1642, i8* %t1664)
  store %ScopeResult %t1665, %ScopeResult* %l15
  %t1666 = load %ScopeResult, %ScopeResult* %l15
  %t1667 = extractvalue %ScopeResult %t1666, 1
  store { %Diagnostic**, i64 }* %t1667, { %Diagnostic**, i64 }** %l16
  %t1668 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l16
  %t1669 = extractvalue %Statement %statement, 0
  %t1670 = alloca %Statement
  store %Statement %statement, %Statement* %t1670
  %t1671 = getelementptr inbounds %Statement, %Statement* %t1670, i32 0, i32 1
  %t1672 = bitcast [24 x i8]* %t1671 to i8*
  %t1673 = bitcast i8* %t1672 to %FunctionSignature*
  %t1674 = load %FunctionSignature, %FunctionSignature* %t1673
  %t1675 = icmp eq i32 %t1669, 4
  %t1676 = select i1 %t1675, %FunctionSignature %t1674, %FunctionSignature zeroinitializer
  %t1677 = getelementptr inbounds %Statement, %Statement* %t1670, i32 0, i32 1
  %t1678 = bitcast [24 x i8]* %t1677 to i8*
  %t1679 = bitcast i8* %t1678 to %FunctionSignature*
  %t1680 = load %FunctionSignature, %FunctionSignature* %t1679
  %t1681 = icmp eq i32 %t1669, 5
  %t1682 = select i1 %t1681, %FunctionSignature %t1680, %FunctionSignature %t1676
  %t1683 = getelementptr inbounds %Statement, %Statement* %t1670, i32 0, i32 1
  %t1684 = bitcast [24 x i8]* %t1683 to i8*
  %t1685 = bitcast i8* %t1684 to %FunctionSignature*
  %t1686 = load %FunctionSignature, %FunctionSignature* %t1685
  %t1687 = icmp eq i32 %t1669, 7
  %t1688 = select i1 %t1687, %FunctionSignature %t1686, %FunctionSignature %t1682
  %t1689 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t1688)
  %t1690 = bitcast { %Diagnostic**, i64 }* %t1668 to { i8**, i64 }*
  %t1691 = bitcast { %Diagnostic*, i64 }* %t1689 to { i8**, i64 }*
  %t1692 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1690, { i8**, i64 }* %t1691)
  %t1693 = bitcast { i8**, i64 }* %t1692 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1693, { %Diagnostic**, i64 }** %l16
  %t1694 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l16
  %t1695 = extractvalue %Statement %statement, 0
  %t1696 = alloca %Statement
  store %Statement %statement, %Statement* %t1696
  %t1697 = getelementptr inbounds %Statement, %Statement* %t1696, i32 0, i32 1
  %t1698 = bitcast [24 x i8]* %t1697 to i8*
  %t1699 = bitcast i8* %t1698 to %FunctionSignature*
  %t1700 = load %FunctionSignature, %FunctionSignature* %t1699
  %t1701 = icmp eq i32 %t1695, 4
  %t1702 = select i1 %t1701, %FunctionSignature %t1700, %FunctionSignature zeroinitializer
  %t1703 = getelementptr inbounds %Statement, %Statement* %t1696, i32 0, i32 1
  %t1704 = bitcast [24 x i8]* %t1703 to i8*
  %t1705 = bitcast i8* %t1704 to %FunctionSignature*
  %t1706 = load %FunctionSignature, %FunctionSignature* %t1705
  %t1707 = icmp eq i32 %t1695, 5
  %t1708 = select i1 %t1707, %FunctionSignature %t1706, %FunctionSignature %t1702
  %t1709 = getelementptr inbounds %Statement, %Statement* %t1696, i32 0, i32 1
  %t1710 = bitcast [24 x i8]* %t1709 to i8*
  %t1711 = bitcast i8* %t1710 to %FunctionSignature*
  %t1712 = load %FunctionSignature, %FunctionSignature* %t1711
  %t1713 = icmp eq i32 %t1695, 7
  %t1714 = select i1 %t1713, %FunctionSignature %t1712, %FunctionSignature %t1708
  %t1715 = extractvalue %Statement %statement, 0
  %t1716 = alloca %Statement
  store %Statement %statement, %Statement* %t1716
  %t1717 = getelementptr inbounds %Statement, %Statement* %t1716, i32 0, i32 1
  %t1718 = bitcast [24 x i8]* %t1717 to i8*
  %t1719 = getelementptr inbounds i8, i8* %t1718, i64 8
  %t1720 = bitcast i8* %t1719 to %Block*
  %t1721 = load %Block, %Block* %t1720
  %t1722 = icmp eq i32 %t1715, 4
  %t1723 = select i1 %t1722, %Block %t1721, %Block zeroinitializer
  %t1724 = getelementptr inbounds %Statement, %Statement* %t1716, i32 0, i32 1
  %t1725 = bitcast [24 x i8]* %t1724 to i8*
  %t1726 = getelementptr inbounds i8, i8* %t1725, i64 8
  %t1727 = bitcast i8* %t1726 to %Block*
  %t1728 = load %Block, %Block* %t1727
  %t1729 = icmp eq i32 %t1715, 5
  %t1730 = select i1 %t1729, %Block %t1728, %Block %t1723
  %t1731 = getelementptr inbounds %Statement, %Statement* %t1716, i32 0, i32 1
  %t1732 = bitcast [40 x i8]* %t1731 to i8*
  %t1733 = getelementptr inbounds i8, i8* %t1732, i64 16
  %t1734 = bitcast i8* %t1733 to %Block*
  %t1735 = load %Block, %Block* %t1734
  %t1736 = icmp eq i32 %t1715, 6
  %t1737 = select i1 %t1736, %Block %t1735, %Block %t1730
  %t1738 = getelementptr inbounds %Statement, %Statement* %t1716, i32 0, i32 1
  %t1739 = bitcast [24 x i8]* %t1738 to i8*
  %t1740 = getelementptr inbounds i8, i8* %t1739, i64 8
  %t1741 = bitcast i8* %t1740 to %Block*
  %t1742 = load %Block, %Block* %t1741
  %t1743 = icmp eq i32 %t1715, 7
  %t1744 = select i1 %t1743, %Block %t1742, %Block %t1737
  %t1745 = getelementptr inbounds %Statement, %Statement* %t1716, i32 0, i32 1
  %t1746 = bitcast [40 x i8]* %t1745 to i8*
  %t1747 = getelementptr inbounds i8, i8* %t1746, i64 24
  %t1748 = bitcast i8* %t1747 to %Block*
  %t1749 = load %Block, %Block* %t1748
  %t1750 = icmp eq i32 %t1715, 12
  %t1751 = select i1 %t1750, %Block %t1749, %Block %t1744
  %t1752 = getelementptr inbounds %Statement, %Statement* %t1716, i32 0, i32 1
  %t1753 = bitcast [24 x i8]* %t1752 to i8*
  %t1754 = getelementptr inbounds i8, i8* %t1753, i64 8
  %t1755 = bitcast i8* %t1754 to %Block*
  %t1756 = load %Block, %Block* %t1755
  %t1757 = icmp eq i32 %t1715, 13
  %t1758 = select i1 %t1757, %Block %t1756, %Block %t1751
  %t1759 = getelementptr inbounds %Statement, %Statement* %t1716, i32 0, i32 1
  %t1760 = bitcast [24 x i8]* %t1759 to i8*
  %t1761 = getelementptr inbounds i8, i8* %t1760, i64 8
  %t1762 = bitcast i8* %t1761 to %Block*
  %t1763 = load %Block, %Block* %t1762
  %t1764 = icmp eq i32 %t1715, 14
  %t1765 = select i1 %t1764, %Block %t1763, %Block %t1758
  %t1766 = getelementptr inbounds %Statement, %Statement* %t1716, i32 0, i32 1
  %t1767 = bitcast [16 x i8]* %t1766 to i8*
  %t1768 = bitcast i8* %t1767 to %Block*
  %t1769 = load %Block, %Block* %t1768
  %t1770 = icmp eq i32 %t1715, 15
  %t1771 = select i1 %t1770, %Block %t1769, %Block %t1765
  %t1772 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t1714, %Block %t1771, { %Statement*, i64 }* %interfaces)
  %t1773 = bitcast { %Diagnostic**, i64 }* %t1694 to { i8**, i64 }*
  %t1774 = bitcast { %Diagnostic*, i64 }* %t1772 to { i8**, i64 }*
  %t1775 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1773, { i8**, i64 }* %t1774)
  %t1776 = bitcast { i8**, i64 }* %t1775 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1776, { %Diagnostic**, i64 }** %l16
  %t1777 = load %ScopeResult, %ScopeResult* %l15
  %t1778 = extractvalue %ScopeResult %t1777, 0
  %t1779 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1778, 0
  %t1780 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l16
  %t1781 = insertvalue %ScopeResult %t1779, { %Diagnostic**, i64 }* %t1780, 1
  ret %ScopeResult %t1781
merge21:
  %t1782 = extractvalue %Statement %statement, 0
  %t1783 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1784 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1785 = icmp eq i32 %t1782, 0
  %t1786 = select i1 %t1785, i8* %t1784, i8* %t1783
  %t1787 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1788 = icmp eq i32 %t1782, 1
  %t1789 = select i1 %t1788, i8* %t1787, i8* %t1786
  %t1790 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1791 = icmp eq i32 %t1782, 2
  %t1792 = select i1 %t1791, i8* %t1790, i8* %t1789
  %t1793 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1794 = icmp eq i32 %t1782, 3
  %t1795 = select i1 %t1794, i8* %t1793, i8* %t1792
  %t1796 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1797 = icmp eq i32 %t1782, 4
  %t1798 = select i1 %t1797, i8* %t1796, i8* %t1795
  %t1799 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1800 = icmp eq i32 %t1782, 5
  %t1801 = select i1 %t1800, i8* %t1799, i8* %t1798
  %t1802 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1803 = icmp eq i32 %t1782, 6
  %t1804 = select i1 %t1803, i8* %t1802, i8* %t1801
  %t1805 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1806 = icmp eq i32 %t1782, 7
  %t1807 = select i1 %t1806, i8* %t1805, i8* %t1804
  %t1808 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1809 = icmp eq i32 %t1782, 8
  %t1810 = select i1 %t1809, i8* %t1808, i8* %t1807
  %t1811 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1812 = icmp eq i32 %t1782, 9
  %t1813 = select i1 %t1812, i8* %t1811, i8* %t1810
  %t1814 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1815 = icmp eq i32 %t1782, 10
  %t1816 = select i1 %t1815, i8* %t1814, i8* %t1813
  %t1817 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1818 = icmp eq i32 %t1782, 11
  %t1819 = select i1 %t1818, i8* %t1817, i8* %t1816
  %t1820 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1821 = icmp eq i32 %t1782, 12
  %t1822 = select i1 %t1821, i8* %t1820, i8* %t1819
  %t1823 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1824 = icmp eq i32 %t1782, 13
  %t1825 = select i1 %t1824, i8* %t1823, i8* %t1822
  %t1826 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1827 = icmp eq i32 %t1782, 14
  %t1828 = select i1 %t1827, i8* %t1826, i8* %t1825
  %t1829 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1830 = icmp eq i32 %t1782, 15
  %t1831 = select i1 %t1830, i8* %t1829, i8* %t1828
  %t1832 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1833 = icmp eq i32 %t1782, 16
  %t1834 = select i1 %t1833, i8* %t1832, i8* %t1831
  %t1835 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1836 = icmp eq i32 %t1782, 17
  %t1837 = select i1 %t1836, i8* %t1835, i8* %t1834
  %t1838 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1839 = icmp eq i32 %t1782, 18
  %t1840 = select i1 %t1839, i8* %t1838, i8* %t1837
  %t1841 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1842 = icmp eq i32 %t1782, 19
  %t1843 = select i1 %t1842, i8* %t1841, i8* %t1840
  %t1844 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1845 = icmp eq i32 %t1782, 20
  %t1846 = select i1 %t1845, i8* %t1844, i8* %t1843
  %t1847 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1848 = icmp eq i32 %t1782, 21
  %t1849 = select i1 %t1848, i8* %t1847, i8* %t1846
  %t1850 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1851 = icmp eq i32 %t1782, 22
  %t1852 = select i1 %t1851, i8* %t1850, i8* %t1849
  %s1853 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1853, i32 0, i32 0
  %t1854 = icmp eq i8* %t1852, %s1853
  br i1 %t1854, label %then22, label %merge23
then22:
  %t1855 = extractvalue %Statement %statement, 0
  %t1856 = alloca %Statement
  store %Statement %statement, %Statement* %t1856
  %t1857 = getelementptr inbounds %Statement, %Statement* %t1856, i32 0, i32 1
  %t1858 = bitcast [48 x i8]* %t1857 to i8*
  %t1859 = bitcast i8* %t1858 to i8**
  %t1860 = load i8*, i8** %t1859
  %t1861 = icmp eq i32 %t1855, 2
  %t1862 = select i1 %t1861, i8* %t1860, i8* null
  %t1863 = getelementptr inbounds %Statement, %Statement* %t1856, i32 0, i32 1
  %t1864 = bitcast [48 x i8]* %t1863 to i8*
  %t1865 = bitcast i8* %t1864 to i8**
  %t1866 = load i8*, i8** %t1865
  %t1867 = icmp eq i32 %t1855, 3
  %t1868 = select i1 %t1867, i8* %t1866, i8* %t1862
  %t1869 = getelementptr inbounds %Statement, %Statement* %t1856, i32 0, i32 1
  %t1870 = bitcast [40 x i8]* %t1869 to i8*
  %t1871 = bitcast i8* %t1870 to i8**
  %t1872 = load i8*, i8** %t1871
  %t1873 = icmp eq i32 %t1855, 6
  %t1874 = select i1 %t1873, i8* %t1872, i8* %t1868
  %t1875 = getelementptr inbounds %Statement, %Statement* %t1856, i32 0, i32 1
  %t1876 = bitcast [56 x i8]* %t1875 to i8*
  %t1877 = bitcast i8* %t1876 to i8**
  %t1878 = load i8*, i8** %t1877
  %t1879 = icmp eq i32 %t1855, 8
  %t1880 = select i1 %t1879, i8* %t1878, i8* %t1874
  %t1881 = getelementptr inbounds %Statement, %Statement* %t1856, i32 0, i32 1
  %t1882 = bitcast [40 x i8]* %t1881 to i8*
  %t1883 = bitcast i8* %t1882 to i8**
  %t1884 = load i8*, i8** %t1883
  %t1885 = icmp eq i32 %t1855, 9
  %t1886 = select i1 %t1885, i8* %t1884, i8* %t1880
  %t1887 = getelementptr inbounds %Statement, %Statement* %t1856, i32 0, i32 1
  %t1888 = bitcast [40 x i8]* %t1887 to i8*
  %t1889 = bitcast i8* %t1888 to i8**
  %t1890 = load i8*, i8** %t1889
  %t1891 = icmp eq i32 %t1855, 10
  %t1892 = select i1 %t1891, i8* %t1890, i8* %t1886
  %t1893 = getelementptr inbounds %Statement, %Statement* %t1856, i32 0, i32 1
  %t1894 = bitcast [40 x i8]* %t1893 to i8*
  %t1895 = bitcast i8* %t1894 to i8**
  %t1896 = load i8*, i8** %t1895
  %t1897 = icmp eq i32 %t1855, 11
  %t1898 = select i1 %t1897, i8* %t1896, i8* %t1892
  %s1899 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1899, i32 0, i32 0
  %t1900 = extractvalue %Statement %statement, 0
  %t1901 = alloca %Statement
  store %Statement %statement, %Statement* %t1901
  %t1902 = getelementptr inbounds %Statement, %Statement* %t1901, i32 0, i32 1
  %t1903 = bitcast [48 x i8]* %t1902 to i8*
  %t1904 = getelementptr inbounds i8, i8* %t1903, i64 8
  %t1905 = bitcast i8* %t1904 to %SourceSpan**
  %t1906 = load %SourceSpan*, %SourceSpan** %t1905
  %t1907 = icmp eq i32 %t1900, 3
  %t1908 = select i1 %t1907, %SourceSpan* %t1906, %SourceSpan* null
  %t1909 = getelementptr inbounds %Statement, %Statement* %t1901, i32 0, i32 1
  %t1910 = bitcast [40 x i8]* %t1909 to i8*
  %t1911 = getelementptr inbounds i8, i8* %t1910, i64 8
  %t1912 = bitcast i8* %t1911 to %SourceSpan**
  %t1913 = load %SourceSpan*, %SourceSpan** %t1912
  %t1914 = icmp eq i32 %t1900, 6
  %t1915 = select i1 %t1914, %SourceSpan* %t1913, %SourceSpan* %t1908
  %t1916 = getelementptr inbounds %Statement, %Statement* %t1901, i32 0, i32 1
  %t1917 = bitcast [56 x i8]* %t1916 to i8*
  %t1918 = getelementptr inbounds i8, i8* %t1917, i64 8
  %t1919 = bitcast i8* %t1918 to %SourceSpan**
  %t1920 = load %SourceSpan*, %SourceSpan** %t1919
  %t1921 = icmp eq i32 %t1900, 8
  %t1922 = select i1 %t1921, %SourceSpan* %t1920, %SourceSpan* %t1915
  %t1923 = getelementptr inbounds %Statement, %Statement* %t1901, i32 0, i32 1
  %t1924 = bitcast [40 x i8]* %t1923 to i8*
  %t1925 = getelementptr inbounds i8, i8* %t1924, i64 8
  %t1926 = bitcast i8* %t1925 to %SourceSpan**
  %t1927 = load %SourceSpan*, %SourceSpan** %t1926
  %t1928 = icmp eq i32 %t1900, 9
  %t1929 = select i1 %t1928, %SourceSpan* %t1927, %SourceSpan* %t1922
  %t1930 = getelementptr inbounds %Statement, %Statement* %t1901, i32 0, i32 1
  %t1931 = bitcast [40 x i8]* %t1930 to i8*
  %t1932 = getelementptr inbounds i8, i8* %t1931, i64 8
  %t1933 = bitcast i8* %t1932 to %SourceSpan**
  %t1934 = load %SourceSpan*, %SourceSpan** %t1933
  %t1935 = icmp eq i32 %t1900, 10
  %t1936 = select i1 %t1935, %SourceSpan* %t1934, %SourceSpan* %t1929
  %t1937 = getelementptr inbounds %Statement, %Statement* %t1901, i32 0, i32 1
  %t1938 = bitcast [40 x i8]* %t1937 to i8*
  %t1939 = getelementptr inbounds i8, i8* %t1938, i64 8
  %t1940 = bitcast i8* %t1939 to %SourceSpan**
  %t1941 = load %SourceSpan*, %SourceSpan** %t1940
  %t1942 = icmp eq i32 %t1900, 11
  %t1943 = select i1 %t1942, %SourceSpan* %t1941, %SourceSpan* %t1936
  %t1944 = bitcast %SourceSpan* %t1943 to i8*
  %t1945 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1898, i8* %s1899, i8* %t1944)
  store %ScopeResult %t1945, %ScopeResult* %l17
  %t1946 = load %ScopeResult, %ScopeResult* %l17
  %t1947 = extractvalue %ScopeResult %t1946, 1
  %t1948 = extractvalue %Statement %statement, 0
  %t1949 = alloca %Statement
  store %Statement %statement, %Statement* %t1949
  %t1950 = getelementptr inbounds %Statement, %Statement* %t1949, i32 0, i32 1
  %t1951 = bitcast [24 x i8]* %t1950 to i8*
  %t1952 = getelementptr inbounds i8, i8* %t1951, i64 8
  %t1953 = bitcast i8* %t1952 to %Block*
  %t1954 = load %Block, %Block* %t1953
  %t1955 = icmp eq i32 %t1948, 4
  %t1956 = select i1 %t1955, %Block %t1954, %Block zeroinitializer
  %t1957 = getelementptr inbounds %Statement, %Statement* %t1949, i32 0, i32 1
  %t1958 = bitcast [24 x i8]* %t1957 to i8*
  %t1959 = getelementptr inbounds i8, i8* %t1958, i64 8
  %t1960 = bitcast i8* %t1959 to %Block*
  %t1961 = load %Block, %Block* %t1960
  %t1962 = icmp eq i32 %t1948, 5
  %t1963 = select i1 %t1962, %Block %t1961, %Block %t1956
  %t1964 = getelementptr inbounds %Statement, %Statement* %t1949, i32 0, i32 1
  %t1965 = bitcast [40 x i8]* %t1964 to i8*
  %t1966 = getelementptr inbounds i8, i8* %t1965, i64 16
  %t1967 = bitcast i8* %t1966 to %Block*
  %t1968 = load %Block, %Block* %t1967
  %t1969 = icmp eq i32 %t1948, 6
  %t1970 = select i1 %t1969, %Block %t1968, %Block %t1963
  %t1971 = getelementptr inbounds %Statement, %Statement* %t1949, i32 0, i32 1
  %t1972 = bitcast [24 x i8]* %t1971 to i8*
  %t1973 = getelementptr inbounds i8, i8* %t1972, i64 8
  %t1974 = bitcast i8* %t1973 to %Block*
  %t1975 = load %Block, %Block* %t1974
  %t1976 = icmp eq i32 %t1948, 7
  %t1977 = select i1 %t1976, %Block %t1975, %Block %t1970
  %t1978 = getelementptr inbounds %Statement, %Statement* %t1949, i32 0, i32 1
  %t1979 = bitcast [40 x i8]* %t1978 to i8*
  %t1980 = getelementptr inbounds i8, i8* %t1979, i64 24
  %t1981 = bitcast i8* %t1980 to %Block*
  %t1982 = load %Block, %Block* %t1981
  %t1983 = icmp eq i32 %t1948, 12
  %t1984 = select i1 %t1983, %Block %t1982, %Block %t1977
  %t1985 = getelementptr inbounds %Statement, %Statement* %t1949, i32 0, i32 1
  %t1986 = bitcast [24 x i8]* %t1985 to i8*
  %t1987 = getelementptr inbounds i8, i8* %t1986, i64 8
  %t1988 = bitcast i8* %t1987 to %Block*
  %t1989 = load %Block, %Block* %t1988
  %t1990 = icmp eq i32 %t1948, 13
  %t1991 = select i1 %t1990, %Block %t1989, %Block %t1984
  %t1992 = getelementptr inbounds %Statement, %Statement* %t1949, i32 0, i32 1
  %t1993 = bitcast [24 x i8]* %t1992 to i8*
  %t1994 = getelementptr inbounds i8, i8* %t1993, i64 8
  %t1995 = bitcast i8* %t1994 to %Block*
  %t1996 = load %Block, %Block* %t1995
  %t1997 = icmp eq i32 %t1948, 14
  %t1998 = select i1 %t1997, %Block %t1996, %Block %t1991
  %t1999 = getelementptr inbounds %Statement, %Statement* %t1949, i32 0, i32 1
  %t2000 = bitcast [16 x i8]* %t1999 to i8*
  %t2001 = bitcast i8* %t2000 to %Block*
  %t2002 = load %Block, %Block* %t2001
  %t2003 = icmp eq i32 %t1948, 15
  %t2004 = select i1 %t2003, %Block %t2002, %Block %t1998
  %t2005 = alloca [0 x double]
  %t2006 = getelementptr [0 x double], [0 x double]* %t2005, i32 0, i32 0
  %t2007 = alloca { double*, i64 }
  %t2008 = getelementptr { double*, i64 }, { double*, i64 }* %t2007, i32 0, i32 0
  store double* %t2006, double** %t2008
  %t2009 = getelementptr { double*, i64 }, { double*, i64 }* %t2007, i32 0, i32 1
  store i64 0, i64* %t2009
  %t2010 = bitcast { double*, i64 }* %t2007 to { %SymbolEntry*, i64 }*
  %t2011 = call { %Diagnostic*, i64 }* @check_block(%Block %t2004, { %SymbolEntry*, i64 }* %t2010, { %Statement*, i64 }* %interfaces)
  %t2012 = bitcast { %Diagnostic**, i64 }* %t1947 to { i8**, i64 }*
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
  %s2092 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.2092, i32 0, i32 0
  %t2093 = icmp eq i8* %t2091, %s2092
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
  %s2227 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.2227, i32 0, i32 0
  %t2228 = icmp eq i8* %t2226, %s2227
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
  %s2362 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.2362, i32 0, i32 0
  %t2363 = icmp eq i8* %t2361, %s2362
  br i1 %t2363, label %then28, label %merge29
then28:
  %t2364 = alloca [0 x %Diagnostic]
  %t2365 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t2364, i32 0, i32 0
  %t2366 = alloca { %Diagnostic*, i64 }
  %t2367 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2366, i32 0, i32 0
  store %Diagnostic* %t2365, %Diagnostic** %t2367
  %t2368 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2366, i32 0, i32 1
  store i64 0, i64* %t2368
  store { %Diagnostic*, i64 }* %t2366, { %Diagnostic*, i64 }** %l19
  %t2369 = sitofp i64 0 to double
  store double %t2369, double* %l20
  %t2370 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2371 = load double, double* %l20
  br label %loop.header30
loop.header30:
  %t2419 = phi { %Diagnostic*, i64 }* [ %t2370, %then28 ], [ %t2417, %loop.latch32 ]
  %t2420 = phi double [ %t2371, %then28 ], [ %t2418, %loop.latch32 ]
  store { %Diagnostic*, i64 }* %t2419, { %Diagnostic*, i64 }** %l19
  store double %t2420, double* %l20
  br label %loop.body31
loop.body31:
  %t2372 = load double, double* %l20
  %t2373 = extractvalue %Statement %statement, 0
  %t2374 = alloca %Statement
  store %Statement %statement, %Statement* %t2374
  %t2375 = getelementptr inbounds %Statement, %Statement* %t2374, i32 0, i32 1
  %t2376 = bitcast [24 x i8]* %t2375 to i8*
  %t2377 = getelementptr inbounds i8, i8* %t2376, i64 8
  %t2378 = bitcast i8* %t2377 to { %MatchCase**, i64 }**
  %t2379 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t2378
  %t2380 = icmp eq i32 %t2373, 18
  %t2381 = select i1 %t2380, { %MatchCase**, i64 }* %t2379, { %MatchCase**, i64 }* null
  %t2382 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t2381
  %t2383 = extractvalue { %MatchCase**, i64 } %t2382, 1
  %t2384 = sitofp i64 %t2383 to double
  %t2385 = fcmp oge double %t2372, %t2384
  %t2386 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2387 = load double, double* %l20
  br i1 %t2385, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t2388 = extractvalue %Statement %statement, 0
  %t2389 = alloca %Statement
  store %Statement %statement, %Statement* %t2389
  %t2390 = getelementptr inbounds %Statement, %Statement* %t2389, i32 0, i32 1
  %t2391 = bitcast [24 x i8]* %t2390 to i8*
  %t2392 = getelementptr inbounds i8, i8* %t2391, i64 8
  %t2393 = bitcast i8* %t2392 to { %MatchCase**, i64 }**
  %t2394 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t2393
  %t2395 = icmp eq i32 %t2388, 18
  %t2396 = select i1 %t2395, { %MatchCase**, i64 }* %t2394, { %MatchCase**, i64 }* null
  %t2397 = load double, double* %l20
  %t2398 = fptosi double %t2397 to i64
  %t2399 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t2396
  %t2400 = extractvalue { %MatchCase**, i64 } %t2399, 0
  %t2401 = extractvalue { %MatchCase**, i64 } %t2399, 1
  %t2402 = icmp uge i64 %t2398, %t2401
  ; bounds check: %t2402 (if true, out of bounds)
  %t2403 = getelementptr %MatchCase*, %MatchCase** %t2400, i64 %t2398
  %t2404 = load %MatchCase*, %MatchCase** %t2403
  store %MatchCase* %t2404, %MatchCase** %l21
  %t2405 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2406 = load %MatchCase*, %MatchCase** %l21
  %t2407 = getelementptr %MatchCase, %MatchCase* %t2406, i32 0, i32 2
  %t2408 = load %Block, %Block* %t2407
  %t2409 = call { %Diagnostic*, i64 }* @check_block(%Block %t2408, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2410 = bitcast { %Diagnostic*, i64 }* %t2405 to { i8**, i64 }*
  %t2411 = bitcast { %Diagnostic*, i64 }* %t2409 to { i8**, i64 }*
  %t2412 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2410, { i8**, i64 }* %t2411)
  %t2413 = bitcast { i8**, i64 }* %t2412 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t2413, { %Diagnostic*, i64 }** %l19
  %t2414 = load double, double* %l20
  %t2415 = sitofp i64 1 to double
  %t2416 = fadd double %t2414, %t2415
  store double %t2416, double* %l20
  br label %loop.latch32
loop.latch32:
  %t2417 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2418 = load double, double* %l20
  br label %loop.header30
afterloop33:
  %t2421 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2422 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2421, 0
  %t2423 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2424 = bitcast { %Diagnostic*, i64 }* %t2423 to { %Diagnostic**, i64 }*
  %t2425 = insertvalue %ScopeResult %t2422, { %Diagnostic**, i64 }* %t2424, 1
  ret %ScopeResult %t2425
merge29:
  %t2426 = extractvalue %Statement %statement, 0
  %t2427 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2428 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2429 = icmp eq i32 %t2426, 0
  %t2430 = select i1 %t2429, i8* %t2428, i8* %t2427
  %t2431 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2432 = icmp eq i32 %t2426, 1
  %t2433 = select i1 %t2432, i8* %t2431, i8* %t2430
  %t2434 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2435 = icmp eq i32 %t2426, 2
  %t2436 = select i1 %t2435, i8* %t2434, i8* %t2433
  %t2437 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2438 = icmp eq i32 %t2426, 3
  %t2439 = select i1 %t2438, i8* %t2437, i8* %t2436
  %t2440 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2441 = icmp eq i32 %t2426, 4
  %t2442 = select i1 %t2441, i8* %t2440, i8* %t2439
  %t2443 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2444 = icmp eq i32 %t2426, 5
  %t2445 = select i1 %t2444, i8* %t2443, i8* %t2442
  %t2446 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2447 = icmp eq i32 %t2426, 6
  %t2448 = select i1 %t2447, i8* %t2446, i8* %t2445
  %t2449 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2450 = icmp eq i32 %t2426, 7
  %t2451 = select i1 %t2450, i8* %t2449, i8* %t2448
  %t2452 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2453 = icmp eq i32 %t2426, 8
  %t2454 = select i1 %t2453, i8* %t2452, i8* %t2451
  %t2455 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2456 = icmp eq i32 %t2426, 9
  %t2457 = select i1 %t2456, i8* %t2455, i8* %t2454
  %t2458 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2459 = icmp eq i32 %t2426, 10
  %t2460 = select i1 %t2459, i8* %t2458, i8* %t2457
  %t2461 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2462 = icmp eq i32 %t2426, 11
  %t2463 = select i1 %t2462, i8* %t2461, i8* %t2460
  %t2464 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2465 = icmp eq i32 %t2426, 12
  %t2466 = select i1 %t2465, i8* %t2464, i8* %t2463
  %t2467 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2468 = icmp eq i32 %t2426, 13
  %t2469 = select i1 %t2468, i8* %t2467, i8* %t2466
  %t2470 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2471 = icmp eq i32 %t2426, 14
  %t2472 = select i1 %t2471, i8* %t2470, i8* %t2469
  %t2473 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2474 = icmp eq i32 %t2426, 15
  %t2475 = select i1 %t2474, i8* %t2473, i8* %t2472
  %t2476 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2477 = icmp eq i32 %t2426, 16
  %t2478 = select i1 %t2477, i8* %t2476, i8* %t2475
  %t2479 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2480 = icmp eq i32 %t2426, 17
  %t2481 = select i1 %t2480, i8* %t2479, i8* %t2478
  %t2482 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2483 = icmp eq i32 %t2426, 18
  %t2484 = select i1 %t2483, i8* %t2482, i8* %t2481
  %t2485 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2486 = icmp eq i32 %t2426, 19
  %t2487 = select i1 %t2486, i8* %t2485, i8* %t2484
  %t2488 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2489 = icmp eq i32 %t2426, 20
  %t2490 = select i1 %t2489, i8* %t2488, i8* %t2487
  %t2491 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2492 = icmp eq i32 %t2426, 21
  %t2493 = select i1 %t2492, i8* %t2491, i8* %t2490
  %t2494 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2495 = icmp eq i32 %t2426, 22
  %t2496 = select i1 %t2495, i8* %t2494, i8* %t2493
  %s2497 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.2497, i32 0, i32 0
  %t2498 = icmp eq i8* %t2496, %s2497
  br i1 %t2498, label %then36, label %merge37
then36:
  %t2499 = extractvalue %Statement %statement, 0
  %t2500 = alloca %Statement
  store %Statement %statement, %Statement* %t2500
  %t2501 = getelementptr inbounds %Statement, %Statement* %t2500, i32 0, i32 1
  %t2502 = bitcast [32 x i8]* %t2501 to i8*
  %t2503 = getelementptr inbounds i8, i8* %t2502, i64 8
  %t2504 = bitcast i8* %t2503 to %Block*
  %t2505 = load %Block, %Block* %t2504
  %t2506 = icmp eq i32 %t2499, 19
  %t2507 = select i1 %t2506, %Block %t2505, %Block zeroinitializer
  %t2508 = call { %Diagnostic*, i64 }* @check_block(%Block %t2507, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t2508, { %Diagnostic*, i64 }** %l22
  %t2509 = extractvalue %Statement %statement, 0
  %t2510 = alloca %Statement
  store %Statement %statement, %Statement* %t2510
  %t2511 = getelementptr inbounds %Statement, %Statement* %t2510, i32 0, i32 1
  %t2512 = bitcast [32 x i8]* %t2511 to i8*
  %t2513 = getelementptr inbounds i8, i8* %t2512, i64 16
  %t2514 = bitcast i8* %t2513 to %ElseBranch**
  %t2515 = load %ElseBranch*, %ElseBranch** %t2514
  %t2516 = icmp eq i32 %t2509, 19
  %t2517 = select i1 %t2516, %ElseBranch* %t2515, %ElseBranch* null
  %t2518 = bitcast i8* null to %ElseBranch*
  %t2519 = icmp ne %ElseBranch* %t2517, %t2518
  %t2520 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br i1 %t2519, label %then38, label %merge39
then38:
  %t2521 = extractvalue %Statement %statement, 0
  %t2522 = alloca %Statement
  store %Statement %statement, %Statement* %t2522
  %t2523 = getelementptr inbounds %Statement, %Statement* %t2522, i32 0, i32 1
  %t2524 = bitcast [32 x i8]* %t2523 to i8*
  %t2525 = getelementptr inbounds i8, i8* %t2524, i64 16
  %t2526 = bitcast i8* %t2525 to %ElseBranch**
  %t2527 = load %ElseBranch*, %ElseBranch** %t2526
  %t2528 = icmp eq i32 %t2521, 19
  %t2529 = select i1 %t2528, %ElseBranch* %t2527, %ElseBranch* null
  store %ElseBranch* %t2529, %ElseBranch** %l23
  %t2530 = load %ElseBranch*, %ElseBranch** %l23
  %t2531 = getelementptr %ElseBranch, %ElseBranch* %t2530, i32 0, i32 1
  %t2532 = load %Block*, %Block** %t2531
  %t2533 = bitcast i8* null to %Block*
  %t2534 = icmp ne %Block* %t2532, %t2533
  %t2535 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2536 = load %ElseBranch*, %ElseBranch** %l23
  br i1 %t2534, label %then40, label %merge41
then40:
  %t2537 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2538 = load %ElseBranch*, %ElseBranch** %l23
  %t2539 = getelementptr %ElseBranch, %ElseBranch* %t2538, i32 0, i32 1
  %t2540 = load %Block*, %Block** %t2539
  %t2541 = load %Block, %Block* %t2540
  %t2542 = call { %Diagnostic*, i64 }* @check_block(%Block %t2541, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2543 = bitcast { %Diagnostic*, i64 }* %t2537 to { i8**, i64 }*
  %t2544 = bitcast { %Diagnostic*, i64 }* %t2542 to { i8**, i64 }*
  %t2545 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2543, { i8**, i64 }* %t2544)
  %t2546 = bitcast { i8**, i64 }* %t2545 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t2546, { %Diagnostic*, i64 }** %l22
  br label %merge41
merge41:
  %t2547 = phi { %Diagnostic*, i64 }* [ %t2546, %then40 ], [ %t2535, %then38 ]
  store { %Diagnostic*, i64 }* %t2547, { %Diagnostic*, i64 }** %l22
  %t2548 = load %ElseBranch*, %ElseBranch** %l23
  %t2549 = getelementptr %ElseBranch, %ElseBranch* %t2548, i32 0, i32 0
  %t2550 = load %Statement*, %Statement** %t2549
  %t2551 = bitcast i8* null to %Statement*
  %t2552 = icmp ne %Statement* %t2550, %t2551
  %t2553 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2554 = load %ElseBranch*, %ElseBranch** %l23
  br i1 %t2552, label %then42, label %merge43
then42:
  %t2555 = load %ElseBranch*, %ElseBranch** %l23
  %t2556 = getelementptr %ElseBranch, %ElseBranch* %t2555, i32 0, i32 0
  %t2557 = load %Statement*, %Statement** %t2556
  %t2558 = load %Statement, %Statement* %t2557
  %t2559 = call %ScopeResult @check_statement(%Statement %t2558, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  store %ScopeResult %t2559, %ScopeResult* %l24
  %t2560 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2561 = load %ScopeResult, %ScopeResult* %l24
  %t2562 = extractvalue %ScopeResult %t2561, 1
  %t2563 = bitcast { %Diagnostic*, i64 }* %t2560 to { i8**, i64 }*
  %t2564 = bitcast { %Diagnostic**, i64 }* %t2562 to { i8**, i64 }*
  %t2565 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2563, { i8**, i64 }* %t2564)
  %t2566 = bitcast { i8**, i64 }* %t2565 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t2566, { %Diagnostic*, i64 }** %l22
  br label %merge43
merge43:
  %t2567 = phi { %Diagnostic*, i64 }* [ %t2566, %then42 ], [ %t2553, %then38 ]
  store { %Diagnostic*, i64 }* %t2567, { %Diagnostic*, i64 }** %l22
  br label %merge39
merge39:
  %t2568 = phi { %Diagnostic*, i64 }* [ %t2546, %then38 ], [ %t2520, %then36 ]
  %t2569 = phi { %Diagnostic*, i64 }* [ %t2566, %then38 ], [ %t2520, %then36 ]
  store { %Diagnostic*, i64 }* %t2568, { %Diagnostic*, i64 }** %l22
  store { %Diagnostic*, i64 }* %t2569, { %Diagnostic*, i64 }** %l22
  %t2570 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2571 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2570, 0
  %t2572 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2573 = bitcast { %Diagnostic*, i64 }* %t2572 to { %Diagnostic**, i64 }*
  %t2574 = insertvalue %ScopeResult %t2571, { %Diagnostic**, i64 }* %t2573, 1
  ret %ScopeResult %t2574
merge37:
  %t2575 = extractvalue %Statement %statement, 0
  %t2576 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2577 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2578 = icmp eq i32 %t2575, 0
  %t2579 = select i1 %t2578, i8* %t2577, i8* %t2576
  %t2580 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2581 = icmp eq i32 %t2575, 1
  %t2582 = select i1 %t2581, i8* %t2580, i8* %t2579
  %t2583 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2584 = icmp eq i32 %t2575, 2
  %t2585 = select i1 %t2584, i8* %t2583, i8* %t2582
  %t2586 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2587 = icmp eq i32 %t2575, 3
  %t2588 = select i1 %t2587, i8* %t2586, i8* %t2585
  %t2589 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2590 = icmp eq i32 %t2575, 4
  %t2591 = select i1 %t2590, i8* %t2589, i8* %t2588
  %t2592 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2593 = icmp eq i32 %t2575, 5
  %t2594 = select i1 %t2593, i8* %t2592, i8* %t2591
  %t2595 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2596 = icmp eq i32 %t2575, 6
  %t2597 = select i1 %t2596, i8* %t2595, i8* %t2594
  %t2598 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2599 = icmp eq i32 %t2575, 7
  %t2600 = select i1 %t2599, i8* %t2598, i8* %t2597
  %t2601 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2602 = icmp eq i32 %t2575, 8
  %t2603 = select i1 %t2602, i8* %t2601, i8* %t2600
  %t2604 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2605 = icmp eq i32 %t2575, 9
  %t2606 = select i1 %t2605, i8* %t2604, i8* %t2603
  %t2607 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2608 = icmp eq i32 %t2575, 10
  %t2609 = select i1 %t2608, i8* %t2607, i8* %t2606
  %t2610 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2611 = icmp eq i32 %t2575, 11
  %t2612 = select i1 %t2611, i8* %t2610, i8* %t2609
  %t2613 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2614 = icmp eq i32 %t2575, 12
  %t2615 = select i1 %t2614, i8* %t2613, i8* %t2612
  %t2616 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2617 = icmp eq i32 %t2575, 13
  %t2618 = select i1 %t2617, i8* %t2616, i8* %t2615
  %t2619 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2620 = icmp eq i32 %t2575, 14
  %t2621 = select i1 %t2620, i8* %t2619, i8* %t2618
  %t2622 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2623 = icmp eq i32 %t2575, 15
  %t2624 = select i1 %t2623, i8* %t2622, i8* %t2621
  %t2625 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2626 = icmp eq i32 %t2575, 16
  %t2627 = select i1 %t2626, i8* %t2625, i8* %t2624
  %t2628 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2629 = icmp eq i32 %t2575, 17
  %t2630 = select i1 %t2629, i8* %t2628, i8* %t2627
  %t2631 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2632 = icmp eq i32 %t2575, 18
  %t2633 = select i1 %t2632, i8* %t2631, i8* %t2630
  %t2634 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2635 = icmp eq i32 %t2575, 19
  %t2636 = select i1 %t2635, i8* %t2634, i8* %t2633
  %t2637 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2638 = icmp eq i32 %t2575, 20
  %t2639 = select i1 %t2638, i8* %t2637, i8* %t2636
  %t2640 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2641 = icmp eq i32 %t2575, 21
  %t2642 = select i1 %t2641, i8* %t2640, i8* %t2639
  %t2643 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2644 = icmp eq i32 %t2575, 22
  %t2645 = select i1 %t2644, i8* %t2643, i8* %t2642
  %s2646 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.2646, i32 0, i32 0
  %t2647 = icmp eq i8* %t2645, %s2646
  br i1 %t2647, label %then44, label %merge45
then44:
  %t2648 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2649 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2648, 0
  %t2650 = extractvalue %Statement %statement, 0
  %t2651 = alloca %Statement
  store %Statement %statement, %Statement* %t2651
  %t2652 = getelementptr inbounds %Statement, %Statement* %t2651, i32 0, i32 1
  %t2653 = bitcast [24 x i8]* %t2652 to i8*
  %t2654 = getelementptr inbounds i8, i8* %t2653, i64 8
  %t2655 = bitcast i8* %t2654 to %Block*
  %t2656 = load %Block, %Block* %t2655
  %t2657 = icmp eq i32 %t2650, 4
  %t2658 = select i1 %t2657, %Block %t2656, %Block zeroinitializer
  %t2659 = getelementptr inbounds %Statement, %Statement* %t2651, i32 0, i32 1
  %t2660 = bitcast [24 x i8]* %t2659 to i8*
  %t2661 = getelementptr inbounds i8, i8* %t2660, i64 8
  %t2662 = bitcast i8* %t2661 to %Block*
  %t2663 = load %Block, %Block* %t2662
  %t2664 = icmp eq i32 %t2650, 5
  %t2665 = select i1 %t2664, %Block %t2663, %Block %t2658
  %t2666 = getelementptr inbounds %Statement, %Statement* %t2651, i32 0, i32 1
  %t2667 = bitcast [40 x i8]* %t2666 to i8*
  %t2668 = getelementptr inbounds i8, i8* %t2667, i64 16
  %t2669 = bitcast i8* %t2668 to %Block*
  %t2670 = load %Block, %Block* %t2669
  %t2671 = icmp eq i32 %t2650, 6
  %t2672 = select i1 %t2671, %Block %t2670, %Block %t2665
  %t2673 = getelementptr inbounds %Statement, %Statement* %t2651, i32 0, i32 1
  %t2674 = bitcast [24 x i8]* %t2673 to i8*
  %t2675 = getelementptr inbounds i8, i8* %t2674, i64 8
  %t2676 = bitcast i8* %t2675 to %Block*
  %t2677 = load %Block, %Block* %t2676
  %t2678 = icmp eq i32 %t2650, 7
  %t2679 = select i1 %t2678, %Block %t2677, %Block %t2672
  %t2680 = getelementptr inbounds %Statement, %Statement* %t2651, i32 0, i32 1
  %t2681 = bitcast [40 x i8]* %t2680 to i8*
  %t2682 = getelementptr inbounds i8, i8* %t2681, i64 24
  %t2683 = bitcast i8* %t2682 to %Block*
  %t2684 = load %Block, %Block* %t2683
  %t2685 = icmp eq i32 %t2650, 12
  %t2686 = select i1 %t2685, %Block %t2684, %Block %t2679
  %t2687 = getelementptr inbounds %Statement, %Statement* %t2651, i32 0, i32 1
  %t2688 = bitcast [24 x i8]* %t2687 to i8*
  %t2689 = getelementptr inbounds i8, i8* %t2688, i64 8
  %t2690 = bitcast i8* %t2689 to %Block*
  %t2691 = load %Block, %Block* %t2690
  %t2692 = icmp eq i32 %t2650, 13
  %t2693 = select i1 %t2692, %Block %t2691, %Block %t2686
  %t2694 = getelementptr inbounds %Statement, %Statement* %t2651, i32 0, i32 1
  %t2695 = bitcast [24 x i8]* %t2694 to i8*
  %t2696 = getelementptr inbounds i8, i8* %t2695, i64 8
  %t2697 = bitcast i8* %t2696 to %Block*
  %t2698 = load %Block, %Block* %t2697
  %t2699 = icmp eq i32 %t2650, 14
  %t2700 = select i1 %t2699, %Block %t2698, %Block %t2693
  %t2701 = getelementptr inbounds %Statement, %Statement* %t2651, i32 0, i32 1
  %t2702 = bitcast [16 x i8]* %t2701 to i8*
  %t2703 = bitcast i8* %t2702 to %Block*
  %t2704 = load %Block, %Block* %t2703
  %t2705 = icmp eq i32 %t2650, 15
  %t2706 = select i1 %t2705, %Block %t2704, %Block %t2700
  %t2707 = call { %Diagnostic*, i64 }* @check_block(%Block %t2706, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2708 = bitcast { %Diagnostic*, i64 }* %t2707 to { %Diagnostic**, i64 }*
  %t2709 = insertvalue %ScopeResult %t2649, { %Diagnostic**, i64 }* %t2708, 1
  ret %ScopeResult %t2709
merge45:
  %t2710 = extractvalue %Statement %statement, 0
  %t2711 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2712 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2713 = icmp eq i32 %t2710, 0
  %t2714 = select i1 %t2713, i8* %t2712, i8* %t2711
  %t2715 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2716 = icmp eq i32 %t2710, 1
  %t2717 = select i1 %t2716, i8* %t2715, i8* %t2714
  %t2718 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2719 = icmp eq i32 %t2710, 2
  %t2720 = select i1 %t2719, i8* %t2718, i8* %t2717
  %t2721 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2722 = icmp eq i32 %t2710, 3
  %t2723 = select i1 %t2722, i8* %t2721, i8* %t2720
  %t2724 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2725 = icmp eq i32 %t2710, 4
  %t2726 = select i1 %t2725, i8* %t2724, i8* %t2723
  %t2727 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2728 = icmp eq i32 %t2710, 5
  %t2729 = select i1 %t2728, i8* %t2727, i8* %t2726
  %t2730 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2731 = icmp eq i32 %t2710, 6
  %t2732 = select i1 %t2731, i8* %t2730, i8* %t2729
  %t2733 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2734 = icmp eq i32 %t2710, 7
  %t2735 = select i1 %t2734, i8* %t2733, i8* %t2732
  %t2736 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2737 = icmp eq i32 %t2710, 8
  %t2738 = select i1 %t2737, i8* %t2736, i8* %t2735
  %t2739 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2740 = icmp eq i32 %t2710, 9
  %t2741 = select i1 %t2740, i8* %t2739, i8* %t2738
  %t2742 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2743 = icmp eq i32 %t2710, 10
  %t2744 = select i1 %t2743, i8* %t2742, i8* %t2741
  %t2745 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2746 = icmp eq i32 %t2710, 11
  %t2747 = select i1 %t2746, i8* %t2745, i8* %t2744
  %t2748 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2749 = icmp eq i32 %t2710, 12
  %t2750 = select i1 %t2749, i8* %t2748, i8* %t2747
  %t2751 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2752 = icmp eq i32 %t2710, 13
  %t2753 = select i1 %t2752, i8* %t2751, i8* %t2750
  %t2754 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2755 = icmp eq i32 %t2710, 14
  %t2756 = select i1 %t2755, i8* %t2754, i8* %t2753
  %t2757 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2758 = icmp eq i32 %t2710, 15
  %t2759 = select i1 %t2758, i8* %t2757, i8* %t2756
  %t2760 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2761 = icmp eq i32 %t2710, 16
  %t2762 = select i1 %t2761, i8* %t2760, i8* %t2759
  %t2763 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2764 = icmp eq i32 %t2710, 17
  %t2765 = select i1 %t2764, i8* %t2763, i8* %t2762
  %t2766 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2767 = icmp eq i32 %t2710, 18
  %t2768 = select i1 %t2767, i8* %t2766, i8* %t2765
  %t2769 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2770 = icmp eq i32 %t2710, 19
  %t2771 = select i1 %t2770, i8* %t2769, i8* %t2768
  %t2772 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2773 = icmp eq i32 %t2710, 20
  %t2774 = select i1 %t2773, i8* %t2772, i8* %t2771
  %t2775 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2776 = icmp eq i32 %t2710, 21
  %t2777 = select i1 %t2776, i8* %t2775, i8* %t2774
  %t2778 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2779 = icmp eq i32 %t2710, 22
  %t2780 = select i1 %t2779, i8* %t2778, i8* %t2777
  %s2781 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.2781, i32 0, i32 0
  %t2782 = icmp eq i8* %t2780, %s2781
  br i1 %t2782, label %then46, label %merge47
then46:
  %t2783 = extractvalue %Statement %statement, 0
  %t2784 = alloca %Statement
  store %Statement %statement, %Statement* %t2784
  %t2785 = getelementptr inbounds %Statement, %Statement* %t2784, i32 0, i32 1
  %t2786 = bitcast [48 x i8]* %t2785 to i8*
  %t2787 = bitcast i8* %t2786 to i8**
  %t2788 = load i8*, i8** %t2787
  %t2789 = icmp eq i32 %t2783, 2
  %t2790 = select i1 %t2789, i8* %t2788, i8* null
  %t2791 = getelementptr inbounds %Statement, %Statement* %t2784, i32 0, i32 1
  %t2792 = bitcast [48 x i8]* %t2791 to i8*
  %t2793 = bitcast i8* %t2792 to i8**
  %t2794 = load i8*, i8** %t2793
  %t2795 = icmp eq i32 %t2783, 3
  %t2796 = select i1 %t2795, i8* %t2794, i8* %t2790
  %t2797 = getelementptr inbounds %Statement, %Statement* %t2784, i32 0, i32 1
  %t2798 = bitcast [40 x i8]* %t2797 to i8*
  %t2799 = bitcast i8* %t2798 to i8**
  %t2800 = load i8*, i8** %t2799
  %t2801 = icmp eq i32 %t2783, 6
  %t2802 = select i1 %t2801, i8* %t2800, i8* %t2796
  %t2803 = getelementptr inbounds %Statement, %Statement* %t2784, i32 0, i32 1
  %t2804 = bitcast [56 x i8]* %t2803 to i8*
  %t2805 = bitcast i8* %t2804 to i8**
  %t2806 = load i8*, i8** %t2805
  %t2807 = icmp eq i32 %t2783, 8
  %t2808 = select i1 %t2807, i8* %t2806, i8* %t2802
  %t2809 = getelementptr inbounds %Statement, %Statement* %t2784, i32 0, i32 1
  %t2810 = bitcast [40 x i8]* %t2809 to i8*
  %t2811 = bitcast i8* %t2810 to i8**
  %t2812 = load i8*, i8** %t2811
  %t2813 = icmp eq i32 %t2783, 9
  %t2814 = select i1 %t2813, i8* %t2812, i8* %t2808
  %t2815 = getelementptr inbounds %Statement, %Statement* %t2784, i32 0, i32 1
  %t2816 = bitcast [40 x i8]* %t2815 to i8*
  %t2817 = bitcast i8* %t2816 to i8**
  %t2818 = load i8*, i8** %t2817
  %t2819 = icmp eq i32 %t2783, 10
  %t2820 = select i1 %t2819, i8* %t2818, i8* %t2814
  %t2821 = getelementptr inbounds %Statement, %Statement* %t2784, i32 0, i32 1
  %t2822 = bitcast [40 x i8]* %t2821 to i8*
  %t2823 = bitcast i8* %t2822 to i8**
  %t2824 = load i8*, i8** %t2823
  %t2825 = icmp eq i32 %t2783, 11
  %t2826 = select i1 %t2825, i8* %t2824, i8* %t2820
  %s2827 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2827, i32 0, i32 0
  %t2828 = extractvalue %Statement %statement, 0
  %t2829 = alloca %Statement
  store %Statement %statement, %Statement* %t2829
  %t2830 = getelementptr inbounds %Statement, %Statement* %t2829, i32 0, i32 1
  %t2831 = bitcast [48 x i8]* %t2830 to i8*
  %t2832 = getelementptr inbounds i8, i8* %t2831, i64 8
  %t2833 = bitcast i8* %t2832 to %SourceSpan**
  %t2834 = load %SourceSpan*, %SourceSpan** %t2833
  %t2835 = icmp eq i32 %t2828, 3
  %t2836 = select i1 %t2835, %SourceSpan* %t2834, %SourceSpan* null
  %t2837 = getelementptr inbounds %Statement, %Statement* %t2829, i32 0, i32 1
  %t2838 = bitcast [40 x i8]* %t2837 to i8*
  %t2839 = getelementptr inbounds i8, i8* %t2838, i64 8
  %t2840 = bitcast i8* %t2839 to %SourceSpan**
  %t2841 = load %SourceSpan*, %SourceSpan** %t2840
  %t2842 = icmp eq i32 %t2828, 6
  %t2843 = select i1 %t2842, %SourceSpan* %t2841, %SourceSpan* %t2836
  %t2844 = getelementptr inbounds %Statement, %Statement* %t2829, i32 0, i32 1
  %t2845 = bitcast [56 x i8]* %t2844 to i8*
  %t2846 = getelementptr inbounds i8, i8* %t2845, i64 8
  %t2847 = bitcast i8* %t2846 to %SourceSpan**
  %t2848 = load %SourceSpan*, %SourceSpan** %t2847
  %t2849 = icmp eq i32 %t2828, 8
  %t2850 = select i1 %t2849, %SourceSpan* %t2848, %SourceSpan* %t2843
  %t2851 = getelementptr inbounds %Statement, %Statement* %t2829, i32 0, i32 1
  %t2852 = bitcast [40 x i8]* %t2851 to i8*
  %t2853 = getelementptr inbounds i8, i8* %t2852, i64 8
  %t2854 = bitcast i8* %t2853 to %SourceSpan**
  %t2855 = load %SourceSpan*, %SourceSpan** %t2854
  %t2856 = icmp eq i32 %t2828, 9
  %t2857 = select i1 %t2856, %SourceSpan* %t2855, %SourceSpan* %t2850
  %t2858 = getelementptr inbounds %Statement, %Statement* %t2829, i32 0, i32 1
  %t2859 = bitcast [40 x i8]* %t2858 to i8*
  %t2860 = getelementptr inbounds i8, i8* %t2859, i64 8
  %t2861 = bitcast i8* %t2860 to %SourceSpan**
  %t2862 = load %SourceSpan*, %SourceSpan** %t2861
  %t2863 = icmp eq i32 %t2828, 10
  %t2864 = select i1 %t2863, %SourceSpan* %t2862, %SourceSpan* %t2857
  %t2865 = getelementptr inbounds %Statement, %Statement* %t2829, i32 0, i32 1
  %t2866 = bitcast [40 x i8]* %t2865 to i8*
  %t2867 = getelementptr inbounds i8, i8* %t2866, i64 8
  %t2868 = bitcast i8* %t2867 to %SourceSpan**
  %t2869 = load %SourceSpan*, %SourceSpan** %t2868
  %t2870 = icmp eq i32 %t2828, 11
  %t2871 = select i1 %t2870, %SourceSpan* %t2869, %SourceSpan* %t2864
  %t2872 = bitcast %SourceSpan* %t2871 to i8*
  %t2873 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t2826, i8* %s2827, i8* %t2872)
  store %ScopeResult %t2873, %ScopeResult* %l25
  %t2874 = load %ScopeResult, %ScopeResult* %l25
  %t2875 = extractvalue %ScopeResult %t2874, 1
  %t2876 = extractvalue %Statement %statement, 0
  %t2877 = alloca %Statement
  store %Statement %statement, %Statement* %t2877
  %t2878 = getelementptr inbounds %Statement, %Statement* %t2877, i32 0, i32 1
  %t2879 = bitcast [56 x i8]* %t2878 to i8*
  %t2880 = getelementptr inbounds i8, i8* %t2879, i64 16
  %t2881 = bitcast i8* %t2880 to { %TypeParameter**, i64 }**
  %t2882 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2881
  %t2883 = icmp eq i32 %t2876, 8
  %t2884 = select i1 %t2883, { %TypeParameter**, i64 }* %t2882, { %TypeParameter**, i64 }* null
  %t2885 = getelementptr inbounds %Statement, %Statement* %t2877, i32 0, i32 1
  %t2886 = bitcast [40 x i8]* %t2885 to i8*
  %t2887 = getelementptr inbounds i8, i8* %t2886, i64 16
  %t2888 = bitcast i8* %t2887 to { %TypeParameter**, i64 }**
  %t2889 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2888
  %t2890 = icmp eq i32 %t2876, 9
  %t2891 = select i1 %t2890, { %TypeParameter**, i64 }* %t2889, { %TypeParameter**, i64 }* %t2884
  %t2892 = getelementptr inbounds %Statement, %Statement* %t2877, i32 0, i32 1
  %t2893 = bitcast [40 x i8]* %t2892 to i8*
  %t2894 = getelementptr inbounds i8, i8* %t2893, i64 16
  %t2895 = bitcast i8* %t2894 to { %TypeParameter**, i64 }**
  %t2896 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2895
  %t2897 = icmp eq i32 %t2876, 10
  %t2898 = select i1 %t2897, { %TypeParameter**, i64 }* %t2896, { %TypeParameter**, i64 }* %t2891
  %t2899 = getelementptr inbounds %Statement, %Statement* %t2877, i32 0, i32 1
  %t2900 = bitcast [40 x i8]* %t2899 to i8*
  %t2901 = getelementptr inbounds i8, i8* %t2900, i64 16
  %t2902 = bitcast i8* %t2901 to { %TypeParameter**, i64 }**
  %t2903 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2902
  %t2904 = icmp eq i32 %t2876, 11
  %t2905 = select i1 %t2904, { %TypeParameter**, i64 }* %t2903, { %TypeParameter**, i64 }* %t2898
  %t2906 = bitcast { %TypeParameter**, i64 }* %t2905 to { %TypeParameter*, i64 }*
  %t2907 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t2906)
  %t2908 = bitcast { %Diagnostic**, i64 }* %t2875 to { i8**, i64 }*
  %t2909 = bitcast { %Diagnostic*, i64 }* %t2907 to { i8**, i64 }*
  %t2910 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2908, { i8**, i64 }* %t2909)
  store { i8**, i64 }* %t2910, { i8**, i64 }** %l26
  %t2911 = load %ScopeResult, %ScopeResult* %l25
  %t2912 = extractvalue %ScopeResult %t2911, 0
  %t2913 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2912, 0
  %t2914 = load { i8**, i64 }*, { i8**, i64 }** %l26
  %t2915 = bitcast { i8**, i64 }* %t2914 to { %Diagnostic**, i64 }*
  %t2916 = insertvalue %ScopeResult %t2913, { %Diagnostic**, i64 }* %t2915, 1
  ret %ScopeResult %t2916
merge47:
  %t2917 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2918 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2917, 0
  %t2919 = alloca [0 x %Diagnostic*]
  %t2920 = getelementptr [0 x %Diagnostic*], [0 x %Diagnostic*]* %t2919, i32 0, i32 0
  %t2921 = alloca { %Diagnostic**, i64 }
  %t2922 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t2921, i32 0, i32 0
  store %Diagnostic** %t2920, %Diagnostic*** %t2922
  %t2923 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t2921, i32 0, i32 1
  store i64 0, i64* %t2923
  %t2924 = insertvalue %ScopeResult %t2918, { %Diagnostic**, i64 }* %t2921, 1
  ret %ScopeResult %t2924
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
  %t28 = bitcast %SourceSpan* %t27 to i8*
  %t29 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %t20, i8* %t23, i8* %s24, i8* %t28)
  store %ScopeResult %t29, %ScopeResult* %l4
  %t30 = load %ScopeResult, %ScopeResult* %l4
  %t31 = extractvalue %ScopeResult %t30, 0
  %t32 = bitcast { %SymbolEntry**, i64 }* %t31 to { %SymbolEntry*, i64 }*
  store { %SymbolEntry*, i64 }* %t32, { %SymbolEntry*, i64 }** %l0
  %t33 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t34 = load %ScopeResult, %ScopeResult* %l4
  %t35 = extractvalue %ScopeResult %t34, 1
  %t36 = bitcast { %Diagnostic*, i64 }* %t33 to { i8**, i64 }*
  %t37 = bitcast { %Diagnostic**, i64 }* %t35 to { i8**, i64 }*
  %t38 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t36, { i8**, i64 }* %t37)
  %t39 = bitcast { i8**, i64 }* %t38 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t39, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t40 = load i64, i64* %l2
  %t41 = add i64 %t40, 1
  store i64 %t41, i64* %l2
  br label %for0
afterfor3:
  %t42 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t43 = bitcast { %SymbolEntry*, i64 }* %t42 to { %SymbolEntry**, i64 }*
  %t44 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t43, 0
  %t45 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t46 = bitcast { %Diagnostic*, i64 }* %t45 to { %Diagnostic**, i64 }*
  %t47 = insertvalue %ScopeResult %t44, { %Diagnostic**, i64 }* %t46, 1
  ret %ScopeResult %t47
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
  %l6 = alloca double
  %l7 = alloca double
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
  %t79 = call double @resolve_interface_annotation(%TypeAnnotation %t78, { %Statement*, i64 }* %interfaces)
  store double %t79, double* %l6
  %t80 = load double, double* %l6
  %t81 = load double, double* %l6
  store double 0.0, double* %l7
  %t82 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  %t83 = extractvalue %Statement %statement, 0
  %t84 = alloca %Statement
  store %Statement %statement, %Statement* %t84
  %t85 = getelementptr inbounds %Statement, %Statement* %t84, i32 0, i32 1
  %t86 = bitcast [48 x i8]* %t85 to i8*
  %t87 = bitcast i8* %t86 to i8**
  %t88 = load i8*, i8** %t87
  %t89 = icmp eq i32 %t83, 2
  %t90 = select i1 %t89, i8* %t88, i8* null
  %t91 = getelementptr inbounds %Statement, %Statement* %t84, i32 0, i32 1
  %t92 = bitcast [48 x i8]* %t91 to i8*
  %t93 = bitcast i8* %t92 to i8**
  %t94 = load i8*, i8** %t93
  %t95 = icmp eq i32 %t83, 3
  %t96 = select i1 %t95, i8* %t94, i8* %t90
  %t97 = getelementptr inbounds %Statement, %Statement* %t84, i32 0, i32 1
  %t98 = bitcast [40 x i8]* %t97 to i8*
  %t99 = bitcast i8* %t98 to i8**
  %t100 = load i8*, i8** %t99
  %t101 = icmp eq i32 %t83, 6
  %t102 = select i1 %t101, i8* %t100, i8* %t96
  %t103 = getelementptr inbounds %Statement, %Statement* %t84, i32 0, i32 1
  %t104 = bitcast [56 x i8]* %t103 to i8*
  %t105 = bitcast i8* %t104 to i8**
  %t106 = load i8*, i8** %t105
  %t107 = icmp eq i32 %t83, 8
  %t108 = select i1 %t107, i8* %t106, i8* %t102
  %t109 = getelementptr inbounds %Statement, %Statement* %t84, i32 0, i32 1
  %t110 = bitcast [40 x i8]* %t109 to i8*
  %t111 = bitcast i8* %t110 to i8**
  %t112 = load i8*, i8** %t111
  %t113 = icmp eq i32 %t83, 9
  %t114 = select i1 %t113, i8* %t112, i8* %t108
  %t115 = getelementptr inbounds %Statement, %Statement* %t84, i32 0, i32 1
  %t116 = bitcast [40 x i8]* %t115 to i8*
  %t117 = bitcast i8* %t116 to i8**
  %t118 = load i8*, i8** %t117
  %t119 = icmp eq i32 %t83, 10
  %t120 = select i1 %t119, i8* %t118, i8* %t114
  %t121 = getelementptr inbounds %Statement, %Statement* %t84, i32 0, i32 1
  %t122 = bitcast [40 x i8]* %t121 to i8*
  %t123 = bitcast i8* %t122 to i8**
  %t124 = load i8*, i8** %t123
  %t125 = icmp eq i32 %t83, 11
  %t126 = select i1 %t125, i8* %t124, i8* %t120
  %t127 = load double, double* %l6
  %t128 = load %TypeAnnotation*, %TypeAnnotation** %l5
  %t129 = load %TypeAnnotation, %TypeAnnotation* %t128
  %t130 = call { %Diagnostic*, i64 }* @validate_interface_annotation(i8* %t126, i8* null, %TypeAnnotation %t129)
  %t131 = bitcast { %Diagnostic*, i64 }* %t82 to { i8**, i64 }*
  %t132 = bitcast { %Diagnostic*, i64 }* %t130 to { i8**, i64 }*
  %t133 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t131, { i8**, i64 }* %t132)
  %t134 = bitcast { i8**, i64 }* %t133 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t134, { %Diagnostic*, i64 }** %l3
  %t135 = load double, double* %l6
  br label %forinc8
forinc8:
  %t136 = load i64, i64* %l4
  %t137 = add i64 %t136, 1
  store i64 %t137, i64* %l4
  br label %for6
afterfor9:
  %t138 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  ret { %Diagnostic*, i64 }* %t138
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
  %t34 = bitcast %SourceSpan* %t33 to i8*
  %t35 = call double @token_from_name(i8* %t31, i8* %t34)
  %t36 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t29, i8* %s30, i8* null)
  %t37 = alloca [1 x %Diagnostic]
  %t38 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* %t37, i32 0, i32 0
  %t39 = getelementptr %Diagnostic, %Diagnostic* %t38, i64 0
  store %Diagnostic %t36, %Diagnostic* %t39
  %t40 = alloca { %Diagnostic*, i64 }
  %t41 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t40, i32 0, i32 0
  store %Diagnostic* %t38, %Diagnostic** %t41
  %t42 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t40, i32 0, i32 1
  store i64 1, i64* %t42
  %t43 = bitcast { %Diagnostic*, i64 }* %t28 to { i8**, i64 }*
  %t44 = bitcast { %Diagnostic*, i64 }* %t40 to { i8**, i64 }*
  %t45 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t43, { i8**, i64 }* %t44)
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
  %l0 = alloca double
  %t0 = call double @extract_generic_argument_block(i8* %annotation_text)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = load double, double* %l0
  %t3 = call { i8**, i64 }* @split_generic_argument_list(i8* null)
  ret { i8**, i64 }* %t3
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
  br label %afterloop11
loop.latch10:
  br label %loop.header8
afterloop11:
  %t33 = load double, double* %l0
  %t34 = load double, double* %l1
  %t35 = call i8* @slice_text(i8* %value, double %t33, double %t34)
  ret i8* %t35
}

define i8* @slice_text(i8* %value, double %start, double %end) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %t0 = sitofp i64 0 to double
  %t1 = fcmp olt double %start, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  br label %merge1
merge1:
  %t2 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t3 = sitofp i64 %t2 to double
  %t4 = fcmp ogt double %end, %t3
  br i1 %t4, label %then2, label %merge3
then2:
  br label %merge3
merge3:
  %t5 = fcmp ole double %end, %start
  br i1 %t5, label %then4, label %merge5
then4:
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.6, i32 0, i32 0
  ret i8* %s6
merge5:
  %s7 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.7, i32 0, i32 0
  store i8* %s7, i8** %l0
  store double %start, double* %l1
  %t8 = load i8*, i8** %l0
  %t9 = load double, double* %l1
  br label %loop.header6
loop.header6:
  %t30 = phi i8* [ %t8, %entry ], [ %t28, %loop.latch8 ]
  %t31 = phi double [ %t9, %entry ], [ %t29, %loop.latch8 ]
  store i8* %t30, i8** %l0
  store double %t31, double* %l1
  br label %loop.body7
loop.body7:
  %t10 = load double, double* %l1
  %t11 = fcmp oge double %t10, %end
  %t12 = load i8*, i8** %l0
  %t13 = load double, double* %l1
  br i1 %t11, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t14 = load i8*, i8** %l0
  %t15 = load double, double* %l1
  %t16 = fptosi double %t15 to i64
  %t17 = getelementptr i8, i8* %value, i64 %t16
  %t18 = load i8, i8* %t17
  %t19 = load i8, i8* %t14
  %t20 = add i8 %t19, %t18
  %t21 = alloca [2 x i8], align 1
  %t22 = getelementptr [2 x i8], [2 x i8]* %t21, i32 0, i32 0
  store i8 %t20, i8* %t22
  %t23 = getelementptr [2 x i8], [2 x i8]* %t21, i32 0, i32 1
  store i8 0, i8* %t23
  %t24 = getelementptr [2 x i8], [2 x i8]* %t21, i32 0, i32 0
  store i8* %t24, i8** %l0
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l1
  br label %loop.latch8
loop.latch8:
  %t28 = load i8*, i8** %l0
  %t29 = load double, double* %l1
  br label %loop.header6
afterloop9:
  %t32 = load i8*, i8** %l0
  ret i8* %t32
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
  %t44 = bitcast %SourceSpan* %t43 to i8*
  %t45 = call double @token_from_name(i8* %t40, i8* %t44)
  %t46 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t38, i8* %s39, i8* null)
  %t47 = alloca [1 x %Diagnostic]
  %t48 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* %t47, i32 0, i32 0
  %t49 = getelementptr %Diagnostic, %Diagnostic* %t48, i64 0
  store %Diagnostic %t46, %Diagnostic* %t49
  %t50 = alloca { %Diagnostic*, i64 }
  %t51 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t50, i32 0, i32 0
  store %Diagnostic* %t48, %Diagnostic** %t51
  %t52 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t50, i32 0, i32 1
  store i64 1, i64* %t52
  %t53 = bitcast { %Diagnostic*, i64 }* %t37 to { i8**, i64 }*
  %t54 = bitcast { %Diagnostic*, i64 }* %t50 to { i8**, i64 }*
  %t55 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t53, { i8**, i64 }* %t54)
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
  %t34 = bitcast %SourceSpan* %t33 to i8*
  %t35 = call double @token_from_name(i8* %t31, i8* %t34)
  %t36 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t29, i8* %s30, i8* null)
  %t37 = alloca [1 x %Diagnostic]
  %t38 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* %t37, i32 0, i32 0
  %t39 = getelementptr %Diagnostic, %Diagnostic* %t38, i64 0
  store %Diagnostic %t36, %Diagnostic* %t39
  %t40 = alloca { %Diagnostic*, i64 }
  %t41 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t40, i32 0, i32 0
  store %Diagnostic* %t38, %Diagnostic** %t41
  %t42 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t40, i32 0, i32 1
  store i64 1, i64* %t42
  %t43 = bitcast { %Diagnostic*, i64 }* %t28 to { i8**, i64 }*
  %t44 = bitcast { %Diagnostic*, i64 }* %t40 to { i8**, i64 }*
  %t45 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t43, { i8**, i64 }* %t44)
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
  %t41 = bitcast %SourceSpan* %t40 to i8*
  %t42 = call double @token_from_name(i8* %t38, i8* %t41)
  %t43 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t36, i8* %s37, i8* null)
  %t44 = alloca [1 x %Diagnostic]
  %t45 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* %t44, i32 0, i32 0
  %t46 = getelementptr %Diagnostic, %Diagnostic* %t45, i64 0
  store %Diagnostic %t43, %Diagnostic* %t46
  %t47 = alloca { %Diagnostic*, i64 }
  %t48 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t47, i32 0, i32 0
  store %Diagnostic* %t45, %Diagnostic** %t48
  %t49 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t47, i32 0, i32 1
  store i64 1, i64* %t49
  %t50 = bitcast { %Diagnostic*, i64 }* %t35 to { i8**, i64 }*
  %t51 = bitcast { %Diagnostic*, i64 }* %t47 to { i8**, i64 }*
  %t52 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t50, { i8**, i64 }* %t51)
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
  %t34 = bitcast %SourceSpan* %t33 to i8*
  %t35 = call double @token_from_name(i8* %t31, i8* %t34)
  %t36 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t29, i8* %s30, i8* null)
  %t37 = alloca [1 x %Diagnostic]
  %t38 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* %t37, i32 0, i32 0
  %t39 = getelementptr %Diagnostic, %Diagnostic* %t38, i64 0
  store %Diagnostic %t36, %Diagnostic* %t39
  %t40 = alloca { %Diagnostic*, i64 }
  %t41 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t40, i32 0, i32 0
  store %Diagnostic* %t38, %Diagnostic** %t41
  %t42 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t40, i32 0, i32 1
  store i64 1, i64* %t42
  %t43 = bitcast { %Diagnostic*, i64 }* %t28 to { i8**, i64 }*
  %t44 = bitcast { %Diagnostic*, i64 }* %t40 to { i8**, i64 }*
  %t45 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t43, { i8**, i64 }* %t44)
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
  %t34 = bitcast %SourceSpan* %t33 to i8*
  %t35 = call double @token_from_name(i8* %t31, i8* %t34)
  %t36 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t29, i8* %s30, i8* null)
  %t37 = alloca [1 x %Diagnostic]
  %t38 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* %t37, i32 0, i32 0
  %t39 = getelementptr %Diagnostic, %Diagnostic* %t38, i64 0
  store %Diagnostic %t36, %Diagnostic* %t39
  %t40 = alloca { %Diagnostic*, i64 }
  %t41 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t40, i32 0, i32 0
  store %Diagnostic* %t38, %Diagnostic** %t41
  %t42 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t40, i32 0, i32 1
  store i64 1, i64* %t42
  %t43 = bitcast { %Diagnostic*, i64 }* %t28 to { i8**, i64 }*
  %t44 = bitcast { %Diagnostic*, i64 }* %t40 to { i8**, i64 }*
  %t45 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t43, { i8**, i64 }* %t44)
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
  %l0 = alloca double
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %t0 = call double @validate_effects(%Program %program)
  store double %t0, double* %l0
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
  %t7 = load double, double* %l0
  %t8 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t58 = phi { %Diagnostic*, i64 }* [ %t8, %entry ], [ %t56, %loop.latch2 ]
  %t59 = phi double [ %t9, %entry ], [ %t57, %loop.latch2 ]
  store { %Diagnostic*, i64 }* %t58, { %Diagnostic*, i64 }** %l1
  store double %t59, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load double, double* %l0
  %t12 = load double, double* %l0
  %t13 = load double, double* %l2
  %t14 = fptosi double %t13 to i64
  store double 0.0, double* %l3
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l4
  %t16 = load double, double* %l0
  %t17 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t18 = load double, double* %l2
  %t19 = load double, double* %l3
  %t20 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t51 = phi { %Diagnostic*, i64 }* [ %t17, %loop.body1 ], [ %t49, %loop.latch6 ]
  %t52 = phi double [ %t20, %loop.body1 ], [ %t50, %loop.latch6 ]
  store { %Diagnostic*, i64 }* %t51, { %Diagnostic*, i64 }** %l1
  store double %t52, double* %l4
  br label %loop.body5
loop.body5:
  %t21 = load double, double* %l4
  %t22 = load double, double* %l3
  %t23 = load double, double* %l3
  store double 0.0, double* %l5
  %t24 = load double, double* %l3
  %t25 = load double, double* %l5
  store double 0.0, double* %l6
  %t26 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %s27 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.27, i32 0, i32 0
  %t28 = insertvalue %Diagnostic undef, i8* %s27, 0
  %t29 = load double, double* %l3
  %t30 = load double, double* %l5
  %t31 = load double, double* %l6
  %t32 = insertvalue %Diagnostic %t28, i8* null, 1
  %t33 = load double, double* %l6
  %t34 = call double @requirement_primary_token(i8* null)
  %t35 = insertvalue %Diagnostic %t32, %Token* null, 2
  %t36 = alloca [1 x %Diagnostic]
  %t37 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* %t36, i32 0, i32 0
  %t38 = getelementptr %Diagnostic, %Diagnostic* %t37, i64 0
  store %Diagnostic %t35, %Diagnostic* %t38
  %t39 = alloca { %Diagnostic*, i64 }
  %t40 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t39, i32 0, i32 0
  store %Diagnostic* %t37, %Diagnostic** %t40
  %t41 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t39, i32 0, i32 1
  store i64 1, i64* %t41
  %t42 = bitcast { %Diagnostic*, i64 }* %t26 to { i8**, i64 }*
  %t43 = bitcast { %Diagnostic*, i64 }* %t39 to { i8**, i64 }*
  %t44 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t42, { i8**, i64 }* %t43)
  %t45 = bitcast { i8**, i64 }* %t44 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t45, { %Diagnostic*, i64 }** %l1
  %t46 = load double, double* %l4
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  store double %t48, double* %l4
  br label %loop.latch6
loop.latch6:
  %t49 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t50 = load double, double* %l4
  br label %loop.header4
afterloop7:
  %t53 = load double, double* %l2
  %t54 = sitofp i64 1 to double
  %t55 = fadd double %t53, %t54
  store double %t55, double* %l2
  br label %loop.latch2
loop.latch2:
  %t56 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t57 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t60 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t60
}

define i8* @format_effect_message(i8* %routine_name, i8* %effect, i8* %requirement) {
entry:
  %l0 = alloca i8
  %s0 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.0, i32 0, i32 0
  %t1 = add i8* %routine_name, %s0
  %t2 = add i8* %t1, %effect
  %t3 = load i8, i8* %t2
  %t4 = add i8 %t3, 39
  store i8 %t4, i8* %l0
  %t5 = icmp ne i8* %requirement, null
  %t6 = load i8, i8* %l0
  br i1 %t5, label %then0, label %merge1
then0:
  %t7 = load i8, i8* %l0
  %s8 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.8, i32 0, i32 0
  %t9 = load i8, i8* %s8
  %t10 = add i8 %t7, %t9
  br label %merge1
merge1:
  %t11 = phi i8 [ zeroinitializer, %then0 ], [ %t6, %entry ]
  store i8 %t11, i8* %l0
  %t12 = load i8, i8* %l0
  %s13 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.13, i32 0, i32 0
  %t14 = load i8, i8* %s13
  %t15 = add i8 %t12, %t14
  %t16 = load i8, i8* %effect
  %t17 = add i8 %t15, %t16
  %s18 = getelementptr inbounds [61 x i8], [61 x i8]* @.str.18, i32 0, i32 0
  %t19 = load i8, i8* %s18
  %t20 = add i8 %t17, %t19
  store i8 %t20, i8* %l0
  %t21 = load i8, i8* %l0
  %t22 = alloca [2 x i8], align 1
  %t23 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 0
  store i8 %t21, i8* %t23
  %t24 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 1
  store i8 0, i8* %t24
  %t25 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 0
  ret i8* %t25
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

define %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %name, i8* %kind, i8* %span) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %t0 = call i1 @has_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %name)
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1, 0
  %t3 = call double @token_from_name(i8* %name, i8* %span)
  %t4 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %name, i8* %kind, i8* null)
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
  %t15 = call { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %name, i8* %kind, i8* %span)
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

define %SymbolCollectionResult @register_symbol(i8* %name, i8* %kind, i8* %span, { %SymbolEntry*, i64 }* %existing) {
entry:
  %t0 = call i1 @has_symbol({ %SymbolEntry*, i64 }* %existing, i8* %name)
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = bitcast { %SymbolEntry*, i64 }* %existing to { %SymbolEntry**, i64 }*
  %t2 = insertvalue %SymbolCollectionResult undef, { %SymbolEntry**, i64 }* %t1, 0
  %t3 = call double @token_from_name(i8* %name, i8* %span)
  %t4 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %name, i8* %kind, i8* null)
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
  %t15 = call { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %existing, i8* %name, i8* %kind, i8* %span)
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

define { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %symbols, i8* %name, i8* %kind, i8* %span) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %t0 = call { %SymbolEntry*, i64 }* @clone_bindings({ %SymbolEntry*, i64 }* %symbols)
  store { %SymbolEntry*, i64 }* %t0, { %SymbolEntry*, i64 }** %l0
  %t1 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t2 = insertvalue %SymbolEntry undef, i8* %name, 0
  %t3 = insertvalue %SymbolEntry %t2, i8* %kind, 1
  %t4 = bitcast i8* %span to %SourceSpan*
  %t5 = insertvalue %SymbolEntry %t3, %SourceSpan* %t4, 2
  %t6 = alloca [1 x %SymbolEntry]
  %t7 = getelementptr [1 x %SymbolEntry], [1 x %SymbolEntry]* %t6, i32 0, i32 0
  %t8 = getelementptr %SymbolEntry, %SymbolEntry* %t7, i64 0
  store %SymbolEntry %t5, %SymbolEntry* %t8
  %t9 = alloca { %SymbolEntry*, i64 }
  %t10 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t9, i32 0, i32 0
  store %SymbolEntry* %t7, %SymbolEntry** %t10
  %t11 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t9, i32 0, i32 1
  store i64 1, i64* %t11
  %t12 = bitcast { %SymbolEntry*, i64 }* %t1 to { i8**, i64 }*
  %t13 = bitcast { %SymbolEntry*, i64 }* %t9 to { i8**, i64 }*
  %t14 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t12, { i8**, i64 }* %t13)
  %t15 = bitcast { i8**, i64 }* %t14 to { %SymbolEntry*, i64 }*
  ret { %SymbolEntry*, i64 }* %t15
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
  %t16 = alloca [1 x %SymbolEntry]
  %t17 = getelementptr [1 x %SymbolEntry], [1 x %SymbolEntry]* %t16, i32 0, i32 0
  %t18 = getelementptr %SymbolEntry, %SymbolEntry* %t17, i64 0
  store %SymbolEntry %t15, %SymbolEntry* %t18
  %t19 = alloca { %SymbolEntry*, i64 }
  %t20 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t19, i32 0, i32 0
  store %SymbolEntry* %t17, %SymbolEntry** %t20
  %t21 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t19, i32 0, i32 1
  store i64 1, i64* %t21
  %t22 = bitcast { %SymbolEntry*, i64 }* %t14 to { i8**, i64 }*
  %t23 = bitcast { %SymbolEntry*, i64 }* %t19 to { i8**, i64 }*
  %t24 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t22, { i8**, i64 }* %t23)
  %t25 = bitcast { i8**, i64 }* %t24 to { %SymbolEntry*, i64 }*
  store { %SymbolEntry*, i64 }* %t25, { %SymbolEntry*, i64 }** %l0
  br label %forinc2
forinc2:
  %t26 = load i64, i64* %l1
  %t27 = add i64 %t26, 1
  store i64 %t27, i64* %l1
  br label %for0
afterfor3:
  %t28 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  ret { %SymbolEntry*, i64 }* %t28
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
  ret %Diagnostic zeroinitializer
}

define %Diagnostic @make_interface_type_argument_mismatch_diagnostic(i8* %struct_name, i8* %annotation_text, i8* %interface_signature) {
entry:
  ret %Diagnostic zeroinitializer
}

define %Diagnostic @make_interface_no_type_arguments_diagnostic(i8* %struct_name, i8* %annotation_text, i8* %interface_name) {
entry:
  ret %Diagnostic zeroinitializer
}

define %Diagnostic @make_duplicate_symbol_diagnostic(i8* %name, i8* %kind, i8* %token) {
entry:
  ret %Diagnostic zeroinitializer
}

define %Diagnostic @make_missing_interface_member_diagnostic(i8* %struct_name, i8* %interface_name, i8* %member_name) {
entry:
  ret %Diagnostic zeroinitializer
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
