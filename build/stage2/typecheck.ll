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
%WithClause = type { %Expression* }
%ObjectField = type { i8*, %Expression* }
%ElseBranch = type { %Statement*, %Block* }
%ForClause = type { %Expression*, %Expression*, { %Token**, i64 }* }
%MatchCase = type { %Expression*, %Expression*, %Block* }
%ModelProperty = type { i8*, %Expression*, %SourceSpan* }
%FieldDeclaration = type { i8*, %TypeAnnotation*, i1, %SourceSpan* }
%MethodDeclaration = type { %FunctionSignature*, %Block*, { %Decorator**, i64 }* }
%EnumVariant = type { i8*, { %FieldDeclaration**, i64 }*, %SourceSpan* }
%FunctionSignature = type { i8*, i1, { %Parameter**, i64 }*, %TypeAnnotation*, { i8**, i64 }*, { %TypeParameter**, i64 }*, %SourceSpan* }
%PipelineDeclaration = type { %FunctionSignature*, %Block*, { %Decorator**, i64 }* }
%ToolDeclaration = type { %FunctionSignature*, %Block*, { %Decorator**, i64 }* }
%TestDeclaration = type { i8*, %Block*, { i8**, i64 }*, { %Decorator**, i64 }* }
%ModelDeclaration = type { i8*, %TypeAnnotation*, { %ModelProperty**, i64 }*, { i8**, i64 }*, { %Decorator**, i64 }* }
%Decorator = type { i8*, { %DecoratorArgument**, i64 }* }
%DecoratorArgument = type { i8*, %Expression* }
%ImportSpecifier = type { i8*, i8* }
%ExportSpecifier = type { i8*, i8* }
%Token = type { %TokenKind*, i8*, double, double }
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
  %t77 = bitcast i8* %t76 to %FunctionSignature**
  %t78 = load %FunctionSignature*, %FunctionSignature** %t77
  %t79 = icmp eq i32 %t73, 4
  %t80 = select i1 %t79, %FunctionSignature* %t78, %FunctionSignature* null
  %t81 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t82 = bitcast [24 x i8]* %t81 to i8*
  %t83 = bitcast i8* %t82 to %FunctionSignature**
  %t84 = load %FunctionSignature*, %FunctionSignature** %t83
  %t85 = icmp eq i32 %t73, 5
  %t86 = select i1 %t85, %FunctionSignature* %t84, %FunctionSignature* %t80
  %t87 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t88 = bitcast [24 x i8]* %t87 to i8*
  %t89 = bitcast i8* %t88 to %FunctionSignature**
  %t90 = load %FunctionSignature*, %FunctionSignature** %t89
  %t91 = icmp eq i32 %t73, 7
  %t92 = select i1 %t91, %FunctionSignature* %t90, %FunctionSignature* %t86
  %t93 = getelementptr %FunctionSignature, %FunctionSignature* %t92, i32 0, i32 0
  %t94 = load i8*, i8** %t93
  %s95 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.95, i32 0, i32 0
  %t96 = extractvalue %Statement %statement, 0
  %t97 = alloca %Statement
  store %Statement %statement, %Statement* %t97
  %t98 = getelementptr inbounds %Statement, %Statement* %t97, i32 0, i32 1
  %t99 = bitcast [24 x i8]* %t98 to i8*
  %t100 = bitcast i8* %t99 to %FunctionSignature**
  %t101 = load %FunctionSignature*, %FunctionSignature** %t100
  %t102 = icmp eq i32 %t96, 4
  %t103 = select i1 %t102, %FunctionSignature* %t101, %FunctionSignature* null
  %t104 = getelementptr inbounds %Statement, %Statement* %t97, i32 0, i32 1
  %t105 = bitcast [24 x i8]* %t104 to i8*
  %t106 = bitcast i8* %t105 to %FunctionSignature**
  %t107 = load %FunctionSignature*, %FunctionSignature** %t106
  %t108 = icmp eq i32 %t96, 5
  %t109 = select i1 %t108, %FunctionSignature* %t107, %FunctionSignature* %t103
  %t110 = getelementptr inbounds %Statement, %Statement* %t97, i32 0, i32 1
  %t111 = bitcast [24 x i8]* %t110 to i8*
  %t112 = bitcast i8* %t111 to %FunctionSignature**
  %t113 = load %FunctionSignature*, %FunctionSignature** %t112
  %t114 = icmp eq i32 %t96, 7
  %t115 = select i1 %t114, %FunctionSignature* %t113, %FunctionSignature* %t109
  %t116 = getelementptr %FunctionSignature, %FunctionSignature* %t115, i32 0, i32 6
  %t117 = load %SourceSpan*, %SourceSpan** %t116
  %t118 = bitcast %SourceSpan* %t117 to i8*
  %t119 = call %SymbolCollectionResult @register_symbol(i8* %t94, i8* %s95, i8* %t118, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t119
merge1:
  %t120 = extractvalue %Statement %statement, 0
  %t121 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t122 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t123 = icmp eq i32 %t120, 0
  %t124 = select i1 %t123, i8* %t122, i8* %t121
  %t125 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t126 = icmp eq i32 %t120, 1
  %t127 = select i1 %t126, i8* %t125, i8* %t124
  %t128 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t129 = icmp eq i32 %t120, 2
  %t130 = select i1 %t129, i8* %t128, i8* %t127
  %t131 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t132 = icmp eq i32 %t120, 3
  %t133 = select i1 %t132, i8* %t131, i8* %t130
  %t134 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t120, 4
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t120, 5
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t120, 6
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t120, 7
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t120, 8
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t120, 9
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t120, 10
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t120, 11
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t120, 12
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t120, 13
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t120, 14
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t120, 15
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t120, 16
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t120, 17
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %t176 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t177 = icmp eq i32 %t120, 18
  %t178 = select i1 %t177, i8* %t176, i8* %t175
  %t179 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t120, 19
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t120, 20
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t120, 21
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %t188 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t120, 22
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %s191 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.191, i32 0, i32 0
  %t192 = icmp eq i8* %t190, %s191
  br i1 %t192, label %then2, label %merge3
then2:
  %t193 = extractvalue %Statement %statement, 0
  %t194 = alloca %Statement
  store %Statement %statement, %Statement* %t194
  %t195 = getelementptr inbounds %Statement, %Statement* %t194, i32 0, i32 1
  %t196 = bitcast [48 x i8]* %t195 to i8*
  %t197 = bitcast i8* %t196 to i8**
  %t198 = load i8*, i8** %t197
  %t199 = icmp eq i32 %t193, 2
  %t200 = select i1 %t199, i8* %t198, i8* null
  %t201 = getelementptr inbounds %Statement, %Statement* %t194, i32 0, i32 1
  %t202 = bitcast [48 x i8]* %t201 to i8*
  %t203 = bitcast i8* %t202 to i8**
  %t204 = load i8*, i8** %t203
  %t205 = icmp eq i32 %t193, 3
  %t206 = select i1 %t205, i8* %t204, i8* %t200
  %t207 = getelementptr inbounds %Statement, %Statement* %t194, i32 0, i32 1
  %t208 = bitcast [40 x i8]* %t207 to i8*
  %t209 = bitcast i8* %t208 to i8**
  %t210 = load i8*, i8** %t209
  %t211 = icmp eq i32 %t193, 6
  %t212 = select i1 %t211, i8* %t210, i8* %t206
  %t213 = getelementptr inbounds %Statement, %Statement* %t194, i32 0, i32 1
  %t214 = bitcast [56 x i8]* %t213 to i8*
  %t215 = bitcast i8* %t214 to i8**
  %t216 = load i8*, i8** %t215
  %t217 = icmp eq i32 %t193, 8
  %t218 = select i1 %t217, i8* %t216, i8* %t212
  %t219 = getelementptr inbounds %Statement, %Statement* %t194, i32 0, i32 1
  %t220 = bitcast [40 x i8]* %t219 to i8*
  %t221 = bitcast i8* %t220 to i8**
  %t222 = load i8*, i8** %t221
  %t223 = icmp eq i32 %t193, 9
  %t224 = select i1 %t223, i8* %t222, i8* %t218
  %t225 = getelementptr inbounds %Statement, %Statement* %t194, i32 0, i32 1
  %t226 = bitcast [40 x i8]* %t225 to i8*
  %t227 = bitcast i8* %t226 to i8**
  %t228 = load i8*, i8** %t227
  %t229 = icmp eq i32 %t193, 10
  %t230 = select i1 %t229, i8* %t228, i8* %t224
  %t231 = getelementptr inbounds %Statement, %Statement* %t194, i32 0, i32 1
  %t232 = bitcast [40 x i8]* %t231 to i8*
  %t233 = bitcast i8* %t232 to i8**
  %t234 = load i8*, i8** %t233
  %t235 = icmp eq i32 %t193, 11
  %t236 = select i1 %t235, i8* %t234, i8* %t230
  %s237 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.237, i32 0, i32 0
  %t238 = extractvalue %Statement %statement, 0
  %t239 = alloca %Statement
  store %Statement %statement, %Statement* %t239
  %t240 = getelementptr inbounds %Statement, %Statement* %t239, i32 0, i32 1
  %t241 = bitcast [48 x i8]* %t240 to i8*
  %t242 = getelementptr inbounds i8, i8* %t241, i64 8
  %t243 = bitcast i8* %t242 to %SourceSpan**
  %t244 = load %SourceSpan*, %SourceSpan** %t243
  %t245 = icmp eq i32 %t238, 3
  %t246 = select i1 %t245, %SourceSpan* %t244, %SourceSpan* null
  %t247 = getelementptr inbounds %Statement, %Statement* %t239, i32 0, i32 1
  %t248 = bitcast [40 x i8]* %t247 to i8*
  %t249 = getelementptr inbounds i8, i8* %t248, i64 8
  %t250 = bitcast i8* %t249 to %SourceSpan**
  %t251 = load %SourceSpan*, %SourceSpan** %t250
  %t252 = icmp eq i32 %t238, 6
  %t253 = select i1 %t252, %SourceSpan* %t251, %SourceSpan* %t246
  %t254 = getelementptr inbounds %Statement, %Statement* %t239, i32 0, i32 1
  %t255 = bitcast [56 x i8]* %t254 to i8*
  %t256 = getelementptr inbounds i8, i8* %t255, i64 8
  %t257 = bitcast i8* %t256 to %SourceSpan**
  %t258 = load %SourceSpan*, %SourceSpan** %t257
  %t259 = icmp eq i32 %t238, 8
  %t260 = select i1 %t259, %SourceSpan* %t258, %SourceSpan* %t253
  %t261 = getelementptr inbounds %Statement, %Statement* %t239, i32 0, i32 1
  %t262 = bitcast [40 x i8]* %t261 to i8*
  %t263 = getelementptr inbounds i8, i8* %t262, i64 8
  %t264 = bitcast i8* %t263 to %SourceSpan**
  %t265 = load %SourceSpan*, %SourceSpan** %t264
  %t266 = icmp eq i32 %t238, 9
  %t267 = select i1 %t266, %SourceSpan* %t265, %SourceSpan* %t260
  %t268 = getelementptr inbounds %Statement, %Statement* %t239, i32 0, i32 1
  %t269 = bitcast [40 x i8]* %t268 to i8*
  %t270 = getelementptr inbounds i8, i8* %t269, i64 8
  %t271 = bitcast i8* %t270 to %SourceSpan**
  %t272 = load %SourceSpan*, %SourceSpan** %t271
  %t273 = icmp eq i32 %t238, 10
  %t274 = select i1 %t273, %SourceSpan* %t272, %SourceSpan* %t267
  %t275 = getelementptr inbounds %Statement, %Statement* %t239, i32 0, i32 1
  %t276 = bitcast [40 x i8]* %t275 to i8*
  %t277 = getelementptr inbounds i8, i8* %t276, i64 8
  %t278 = bitcast i8* %t277 to %SourceSpan**
  %t279 = load %SourceSpan*, %SourceSpan** %t278
  %t280 = icmp eq i32 %t238, 11
  %t281 = select i1 %t280, %SourceSpan* %t279, %SourceSpan* %t274
  %t282 = bitcast %SourceSpan* %t281 to i8*
  %t283 = call %SymbolCollectionResult @register_symbol(i8* %t236, i8* %s237, i8* %t282, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t283
merge3:
  %t284 = extractvalue %Statement %statement, 0
  %t285 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t286 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t287 = icmp eq i32 %t284, 0
  %t288 = select i1 %t287, i8* %t286, i8* %t285
  %t289 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t290 = icmp eq i32 %t284, 1
  %t291 = select i1 %t290, i8* %t289, i8* %t288
  %t292 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t293 = icmp eq i32 %t284, 2
  %t294 = select i1 %t293, i8* %t292, i8* %t291
  %t295 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t296 = icmp eq i32 %t284, 3
  %t297 = select i1 %t296, i8* %t295, i8* %t294
  %t298 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t299 = icmp eq i32 %t284, 4
  %t300 = select i1 %t299, i8* %t298, i8* %t297
  %t301 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t302 = icmp eq i32 %t284, 5
  %t303 = select i1 %t302, i8* %t301, i8* %t300
  %t304 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t305 = icmp eq i32 %t284, 6
  %t306 = select i1 %t305, i8* %t304, i8* %t303
  %t307 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t308 = icmp eq i32 %t284, 7
  %t309 = select i1 %t308, i8* %t307, i8* %t306
  %t310 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t311 = icmp eq i32 %t284, 8
  %t312 = select i1 %t311, i8* %t310, i8* %t309
  %t313 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t314 = icmp eq i32 %t284, 9
  %t315 = select i1 %t314, i8* %t313, i8* %t312
  %t316 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t317 = icmp eq i32 %t284, 10
  %t318 = select i1 %t317, i8* %t316, i8* %t315
  %t319 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t320 = icmp eq i32 %t284, 11
  %t321 = select i1 %t320, i8* %t319, i8* %t318
  %t322 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t323 = icmp eq i32 %t284, 12
  %t324 = select i1 %t323, i8* %t322, i8* %t321
  %t325 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t326 = icmp eq i32 %t284, 13
  %t327 = select i1 %t326, i8* %t325, i8* %t324
  %t328 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t329 = icmp eq i32 %t284, 14
  %t330 = select i1 %t329, i8* %t328, i8* %t327
  %t331 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t332 = icmp eq i32 %t284, 15
  %t333 = select i1 %t332, i8* %t331, i8* %t330
  %t334 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t335 = icmp eq i32 %t284, 16
  %t336 = select i1 %t335, i8* %t334, i8* %t333
  %t337 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t338 = icmp eq i32 %t284, 17
  %t339 = select i1 %t338, i8* %t337, i8* %t336
  %t340 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t341 = icmp eq i32 %t284, 18
  %t342 = select i1 %t341, i8* %t340, i8* %t339
  %t343 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t344 = icmp eq i32 %t284, 19
  %t345 = select i1 %t344, i8* %t343, i8* %t342
  %t346 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t347 = icmp eq i32 %t284, 20
  %t348 = select i1 %t347, i8* %t346, i8* %t345
  %t349 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t350 = icmp eq i32 %t284, 21
  %t351 = select i1 %t350, i8* %t349, i8* %t348
  %t352 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t353 = icmp eq i32 %t284, 22
  %t354 = select i1 %t353, i8* %t352, i8* %t351
  %s355 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.355, i32 0, i32 0
  %t356 = icmp eq i8* %t354, %s355
  br i1 %t356, label %then4, label %merge5
then4:
  %t357 = extractvalue %Statement %statement, 0
  %t358 = alloca %Statement
  store %Statement %statement, %Statement* %t358
  %t359 = getelementptr inbounds %Statement, %Statement* %t358, i32 0, i32 1
  %t360 = bitcast [48 x i8]* %t359 to i8*
  %t361 = bitcast i8* %t360 to i8**
  %t362 = load i8*, i8** %t361
  %t363 = icmp eq i32 %t357, 2
  %t364 = select i1 %t363, i8* %t362, i8* null
  %t365 = getelementptr inbounds %Statement, %Statement* %t358, i32 0, i32 1
  %t366 = bitcast [48 x i8]* %t365 to i8*
  %t367 = bitcast i8* %t366 to i8**
  %t368 = load i8*, i8** %t367
  %t369 = icmp eq i32 %t357, 3
  %t370 = select i1 %t369, i8* %t368, i8* %t364
  %t371 = getelementptr inbounds %Statement, %Statement* %t358, i32 0, i32 1
  %t372 = bitcast [40 x i8]* %t371 to i8*
  %t373 = bitcast i8* %t372 to i8**
  %t374 = load i8*, i8** %t373
  %t375 = icmp eq i32 %t357, 6
  %t376 = select i1 %t375, i8* %t374, i8* %t370
  %t377 = getelementptr inbounds %Statement, %Statement* %t358, i32 0, i32 1
  %t378 = bitcast [56 x i8]* %t377 to i8*
  %t379 = bitcast i8* %t378 to i8**
  %t380 = load i8*, i8** %t379
  %t381 = icmp eq i32 %t357, 8
  %t382 = select i1 %t381, i8* %t380, i8* %t376
  %t383 = getelementptr inbounds %Statement, %Statement* %t358, i32 0, i32 1
  %t384 = bitcast [40 x i8]* %t383 to i8*
  %t385 = bitcast i8* %t384 to i8**
  %t386 = load i8*, i8** %t385
  %t387 = icmp eq i32 %t357, 9
  %t388 = select i1 %t387, i8* %t386, i8* %t382
  %t389 = getelementptr inbounds %Statement, %Statement* %t358, i32 0, i32 1
  %t390 = bitcast [40 x i8]* %t389 to i8*
  %t391 = bitcast i8* %t390 to i8**
  %t392 = load i8*, i8** %t391
  %t393 = icmp eq i32 %t357, 10
  %t394 = select i1 %t393, i8* %t392, i8* %t388
  %t395 = getelementptr inbounds %Statement, %Statement* %t358, i32 0, i32 1
  %t396 = bitcast [40 x i8]* %t395 to i8*
  %t397 = bitcast i8* %t396 to i8**
  %t398 = load i8*, i8** %t397
  %t399 = icmp eq i32 %t357, 11
  %t400 = select i1 %t399, i8* %t398, i8* %t394
  %s401 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.401, i32 0, i32 0
  %t402 = extractvalue %Statement %statement, 0
  %t403 = alloca %Statement
  store %Statement %statement, %Statement* %t403
  %t404 = getelementptr inbounds %Statement, %Statement* %t403, i32 0, i32 1
  %t405 = bitcast [48 x i8]* %t404 to i8*
  %t406 = getelementptr inbounds i8, i8* %t405, i64 8
  %t407 = bitcast i8* %t406 to %SourceSpan**
  %t408 = load %SourceSpan*, %SourceSpan** %t407
  %t409 = icmp eq i32 %t402, 3
  %t410 = select i1 %t409, %SourceSpan* %t408, %SourceSpan* null
  %t411 = getelementptr inbounds %Statement, %Statement* %t403, i32 0, i32 1
  %t412 = bitcast [40 x i8]* %t411 to i8*
  %t413 = getelementptr inbounds i8, i8* %t412, i64 8
  %t414 = bitcast i8* %t413 to %SourceSpan**
  %t415 = load %SourceSpan*, %SourceSpan** %t414
  %t416 = icmp eq i32 %t402, 6
  %t417 = select i1 %t416, %SourceSpan* %t415, %SourceSpan* %t410
  %t418 = getelementptr inbounds %Statement, %Statement* %t403, i32 0, i32 1
  %t419 = bitcast [56 x i8]* %t418 to i8*
  %t420 = getelementptr inbounds i8, i8* %t419, i64 8
  %t421 = bitcast i8* %t420 to %SourceSpan**
  %t422 = load %SourceSpan*, %SourceSpan** %t421
  %t423 = icmp eq i32 %t402, 8
  %t424 = select i1 %t423, %SourceSpan* %t422, %SourceSpan* %t417
  %t425 = getelementptr inbounds %Statement, %Statement* %t403, i32 0, i32 1
  %t426 = bitcast [40 x i8]* %t425 to i8*
  %t427 = getelementptr inbounds i8, i8* %t426, i64 8
  %t428 = bitcast i8* %t427 to %SourceSpan**
  %t429 = load %SourceSpan*, %SourceSpan** %t428
  %t430 = icmp eq i32 %t402, 9
  %t431 = select i1 %t430, %SourceSpan* %t429, %SourceSpan* %t424
  %t432 = getelementptr inbounds %Statement, %Statement* %t403, i32 0, i32 1
  %t433 = bitcast [40 x i8]* %t432 to i8*
  %t434 = getelementptr inbounds i8, i8* %t433, i64 8
  %t435 = bitcast i8* %t434 to %SourceSpan**
  %t436 = load %SourceSpan*, %SourceSpan** %t435
  %t437 = icmp eq i32 %t402, 10
  %t438 = select i1 %t437, %SourceSpan* %t436, %SourceSpan* %t431
  %t439 = getelementptr inbounds %Statement, %Statement* %t403, i32 0, i32 1
  %t440 = bitcast [40 x i8]* %t439 to i8*
  %t441 = getelementptr inbounds i8, i8* %t440, i64 8
  %t442 = bitcast i8* %t441 to %SourceSpan**
  %t443 = load %SourceSpan*, %SourceSpan** %t442
  %t444 = icmp eq i32 %t402, 11
  %t445 = select i1 %t444, %SourceSpan* %t443, %SourceSpan* %t438
  %t446 = bitcast %SourceSpan* %t445 to i8*
  %t447 = call %SymbolCollectionResult @register_symbol(i8* %t400, i8* %s401, i8* %t446, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t447
merge5:
  %t448 = extractvalue %Statement %statement, 0
  %t449 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t450 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t451 = icmp eq i32 %t448, 0
  %t452 = select i1 %t451, i8* %t450, i8* %t449
  %t453 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t454 = icmp eq i32 %t448, 1
  %t455 = select i1 %t454, i8* %t453, i8* %t452
  %t456 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t457 = icmp eq i32 %t448, 2
  %t458 = select i1 %t457, i8* %t456, i8* %t455
  %t459 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t460 = icmp eq i32 %t448, 3
  %t461 = select i1 %t460, i8* %t459, i8* %t458
  %t462 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t463 = icmp eq i32 %t448, 4
  %t464 = select i1 %t463, i8* %t462, i8* %t461
  %t465 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t466 = icmp eq i32 %t448, 5
  %t467 = select i1 %t466, i8* %t465, i8* %t464
  %t468 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t469 = icmp eq i32 %t448, 6
  %t470 = select i1 %t469, i8* %t468, i8* %t467
  %t471 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t472 = icmp eq i32 %t448, 7
  %t473 = select i1 %t472, i8* %t471, i8* %t470
  %t474 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t475 = icmp eq i32 %t448, 8
  %t476 = select i1 %t475, i8* %t474, i8* %t473
  %t477 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t478 = icmp eq i32 %t448, 9
  %t479 = select i1 %t478, i8* %t477, i8* %t476
  %t480 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t481 = icmp eq i32 %t448, 10
  %t482 = select i1 %t481, i8* %t480, i8* %t479
  %t483 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t484 = icmp eq i32 %t448, 11
  %t485 = select i1 %t484, i8* %t483, i8* %t482
  %t486 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t487 = icmp eq i32 %t448, 12
  %t488 = select i1 %t487, i8* %t486, i8* %t485
  %t489 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t490 = icmp eq i32 %t448, 13
  %t491 = select i1 %t490, i8* %t489, i8* %t488
  %t492 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t493 = icmp eq i32 %t448, 14
  %t494 = select i1 %t493, i8* %t492, i8* %t491
  %t495 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t496 = icmp eq i32 %t448, 15
  %t497 = select i1 %t496, i8* %t495, i8* %t494
  %t498 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t499 = icmp eq i32 %t448, 16
  %t500 = select i1 %t499, i8* %t498, i8* %t497
  %t501 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t502 = icmp eq i32 %t448, 17
  %t503 = select i1 %t502, i8* %t501, i8* %t500
  %t504 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t505 = icmp eq i32 %t448, 18
  %t506 = select i1 %t505, i8* %t504, i8* %t503
  %t507 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t508 = icmp eq i32 %t448, 19
  %t509 = select i1 %t508, i8* %t507, i8* %t506
  %t510 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t511 = icmp eq i32 %t448, 20
  %t512 = select i1 %t511, i8* %t510, i8* %t509
  %t513 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t514 = icmp eq i32 %t448, 21
  %t515 = select i1 %t514, i8* %t513, i8* %t512
  %t516 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t517 = icmp eq i32 %t448, 22
  %t518 = select i1 %t517, i8* %t516, i8* %t515
  %s519 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.519, i32 0, i32 0
  %t520 = icmp eq i8* %t518, %s519
  br i1 %t520, label %then6, label %merge7
then6:
  %t521 = extractvalue %Statement %statement, 0
  %t522 = alloca %Statement
  store %Statement %statement, %Statement* %t522
  %t523 = getelementptr inbounds %Statement, %Statement* %t522, i32 0, i32 1
  %t524 = bitcast [48 x i8]* %t523 to i8*
  %t525 = bitcast i8* %t524 to i8**
  %t526 = load i8*, i8** %t525
  %t527 = icmp eq i32 %t521, 2
  %t528 = select i1 %t527, i8* %t526, i8* null
  %t529 = getelementptr inbounds %Statement, %Statement* %t522, i32 0, i32 1
  %t530 = bitcast [48 x i8]* %t529 to i8*
  %t531 = bitcast i8* %t530 to i8**
  %t532 = load i8*, i8** %t531
  %t533 = icmp eq i32 %t521, 3
  %t534 = select i1 %t533, i8* %t532, i8* %t528
  %t535 = getelementptr inbounds %Statement, %Statement* %t522, i32 0, i32 1
  %t536 = bitcast [40 x i8]* %t535 to i8*
  %t537 = bitcast i8* %t536 to i8**
  %t538 = load i8*, i8** %t537
  %t539 = icmp eq i32 %t521, 6
  %t540 = select i1 %t539, i8* %t538, i8* %t534
  %t541 = getelementptr inbounds %Statement, %Statement* %t522, i32 0, i32 1
  %t542 = bitcast [56 x i8]* %t541 to i8*
  %t543 = bitcast i8* %t542 to i8**
  %t544 = load i8*, i8** %t543
  %t545 = icmp eq i32 %t521, 8
  %t546 = select i1 %t545, i8* %t544, i8* %t540
  %t547 = getelementptr inbounds %Statement, %Statement* %t522, i32 0, i32 1
  %t548 = bitcast [40 x i8]* %t547 to i8*
  %t549 = bitcast i8* %t548 to i8**
  %t550 = load i8*, i8** %t549
  %t551 = icmp eq i32 %t521, 9
  %t552 = select i1 %t551, i8* %t550, i8* %t546
  %t553 = getelementptr inbounds %Statement, %Statement* %t522, i32 0, i32 1
  %t554 = bitcast [40 x i8]* %t553 to i8*
  %t555 = bitcast i8* %t554 to i8**
  %t556 = load i8*, i8** %t555
  %t557 = icmp eq i32 %t521, 10
  %t558 = select i1 %t557, i8* %t556, i8* %t552
  %t559 = getelementptr inbounds %Statement, %Statement* %t522, i32 0, i32 1
  %t560 = bitcast [40 x i8]* %t559 to i8*
  %t561 = bitcast i8* %t560 to i8**
  %t562 = load i8*, i8** %t561
  %t563 = icmp eq i32 %t521, 11
  %t564 = select i1 %t563, i8* %t562, i8* %t558
  %s565 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.565, i32 0, i32 0
  %t566 = extractvalue %Statement %statement, 0
  %t567 = alloca %Statement
  store %Statement %statement, %Statement* %t567
  %t568 = getelementptr inbounds %Statement, %Statement* %t567, i32 0, i32 1
  %t569 = bitcast [48 x i8]* %t568 to i8*
  %t570 = getelementptr inbounds i8, i8* %t569, i64 8
  %t571 = bitcast i8* %t570 to %SourceSpan**
  %t572 = load %SourceSpan*, %SourceSpan** %t571
  %t573 = icmp eq i32 %t566, 3
  %t574 = select i1 %t573, %SourceSpan* %t572, %SourceSpan* null
  %t575 = getelementptr inbounds %Statement, %Statement* %t567, i32 0, i32 1
  %t576 = bitcast [40 x i8]* %t575 to i8*
  %t577 = getelementptr inbounds i8, i8* %t576, i64 8
  %t578 = bitcast i8* %t577 to %SourceSpan**
  %t579 = load %SourceSpan*, %SourceSpan** %t578
  %t580 = icmp eq i32 %t566, 6
  %t581 = select i1 %t580, %SourceSpan* %t579, %SourceSpan* %t574
  %t582 = getelementptr inbounds %Statement, %Statement* %t567, i32 0, i32 1
  %t583 = bitcast [56 x i8]* %t582 to i8*
  %t584 = getelementptr inbounds i8, i8* %t583, i64 8
  %t585 = bitcast i8* %t584 to %SourceSpan**
  %t586 = load %SourceSpan*, %SourceSpan** %t585
  %t587 = icmp eq i32 %t566, 8
  %t588 = select i1 %t587, %SourceSpan* %t586, %SourceSpan* %t581
  %t589 = getelementptr inbounds %Statement, %Statement* %t567, i32 0, i32 1
  %t590 = bitcast [40 x i8]* %t589 to i8*
  %t591 = getelementptr inbounds i8, i8* %t590, i64 8
  %t592 = bitcast i8* %t591 to %SourceSpan**
  %t593 = load %SourceSpan*, %SourceSpan** %t592
  %t594 = icmp eq i32 %t566, 9
  %t595 = select i1 %t594, %SourceSpan* %t593, %SourceSpan* %t588
  %t596 = getelementptr inbounds %Statement, %Statement* %t567, i32 0, i32 1
  %t597 = bitcast [40 x i8]* %t596 to i8*
  %t598 = getelementptr inbounds i8, i8* %t597, i64 8
  %t599 = bitcast i8* %t598 to %SourceSpan**
  %t600 = load %SourceSpan*, %SourceSpan** %t599
  %t601 = icmp eq i32 %t566, 10
  %t602 = select i1 %t601, %SourceSpan* %t600, %SourceSpan* %t595
  %t603 = getelementptr inbounds %Statement, %Statement* %t567, i32 0, i32 1
  %t604 = bitcast [40 x i8]* %t603 to i8*
  %t605 = getelementptr inbounds i8, i8* %t604, i64 8
  %t606 = bitcast i8* %t605 to %SourceSpan**
  %t607 = load %SourceSpan*, %SourceSpan** %t606
  %t608 = icmp eq i32 %t566, 11
  %t609 = select i1 %t608, %SourceSpan* %t607, %SourceSpan* %t602
  %t610 = bitcast %SourceSpan* %t609 to i8*
  %t611 = call %SymbolCollectionResult @register_symbol(i8* %t564, i8* %s565, i8* %t610, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t611
merge7:
  %t612 = extractvalue %Statement %statement, 0
  %t613 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t614 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t615 = icmp eq i32 %t612, 0
  %t616 = select i1 %t615, i8* %t614, i8* %t613
  %t617 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t618 = icmp eq i32 %t612, 1
  %t619 = select i1 %t618, i8* %t617, i8* %t616
  %t620 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t621 = icmp eq i32 %t612, 2
  %t622 = select i1 %t621, i8* %t620, i8* %t619
  %t623 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t624 = icmp eq i32 %t612, 3
  %t625 = select i1 %t624, i8* %t623, i8* %t622
  %t626 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t627 = icmp eq i32 %t612, 4
  %t628 = select i1 %t627, i8* %t626, i8* %t625
  %t629 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t630 = icmp eq i32 %t612, 5
  %t631 = select i1 %t630, i8* %t629, i8* %t628
  %t632 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t633 = icmp eq i32 %t612, 6
  %t634 = select i1 %t633, i8* %t632, i8* %t631
  %t635 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t636 = icmp eq i32 %t612, 7
  %t637 = select i1 %t636, i8* %t635, i8* %t634
  %t638 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t639 = icmp eq i32 %t612, 8
  %t640 = select i1 %t639, i8* %t638, i8* %t637
  %t641 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t642 = icmp eq i32 %t612, 9
  %t643 = select i1 %t642, i8* %t641, i8* %t640
  %t644 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t645 = icmp eq i32 %t612, 10
  %t646 = select i1 %t645, i8* %t644, i8* %t643
  %t647 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t648 = icmp eq i32 %t612, 11
  %t649 = select i1 %t648, i8* %t647, i8* %t646
  %t650 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t651 = icmp eq i32 %t612, 12
  %t652 = select i1 %t651, i8* %t650, i8* %t649
  %t653 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t654 = icmp eq i32 %t612, 13
  %t655 = select i1 %t654, i8* %t653, i8* %t652
  %t656 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t657 = icmp eq i32 %t612, 14
  %t658 = select i1 %t657, i8* %t656, i8* %t655
  %t659 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t660 = icmp eq i32 %t612, 15
  %t661 = select i1 %t660, i8* %t659, i8* %t658
  %t662 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t663 = icmp eq i32 %t612, 16
  %t664 = select i1 %t663, i8* %t662, i8* %t661
  %t665 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t666 = icmp eq i32 %t612, 17
  %t667 = select i1 %t666, i8* %t665, i8* %t664
  %t668 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t669 = icmp eq i32 %t612, 18
  %t670 = select i1 %t669, i8* %t668, i8* %t667
  %t671 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t672 = icmp eq i32 %t612, 19
  %t673 = select i1 %t672, i8* %t671, i8* %t670
  %t674 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t675 = icmp eq i32 %t612, 20
  %t676 = select i1 %t675, i8* %t674, i8* %t673
  %t677 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t678 = icmp eq i32 %t612, 21
  %t679 = select i1 %t678, i8* %t677, i8* %t676
  %t680 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t681 = icmp eq i32 %t612, 22
  %t682 = select i1 %t681, i8* %t680, i8* %t679
  %s683 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.683, i32 0, i32 0
  %t684 = icmp eq i8* %t682, %s683
  br i1 %t684, label %then8, label %merge9
then8:
  %t685 = extractvalue %Statement %statement, 0
  %t686 = alloca %Statement
  store %Statement %statement, %Statement* %t686
  %t687 = getelementptr inbounds %Statement, %Statement* %t686, i32 0, i32 1
  %t688 = bitcast [48 x i8]* %t687 to i8*
  %t689 = bitcast i8* %t688 to i8**
  %t690 = load i8*, i8** %t689
  %t691 = icmp eq i32 %t685, 2
  %t692 = select i1 %t691, i8* %t690, i8* null
  %t693 = getelementptr inbounds %Statement, %Statement* %t686, i32 0, i32 1
  %t694 = bitcast [48 x i8]* %t693 to i8*
  %t695 = bitcast i8* %t694 to i8**
  %t696 = load i8*, i8** %t695
  %t697 = icmp eq i32 %t685, 3
  %t698 = select i1 %t697, i8* %t696, i8* %t692
  %t699 = getelementptr inbounds %Statement, %Statement* %t686, i32 0, i32 1
  %t700 = bitcast [40 x i8]* %t699 to i8*
  %t701 = bitcast i8* %t700 to i8**
  %t702 = load i8*, i8** %t701
  %t703 = icmp eq i32 %t685, 6
  %t704 = select i1 %t703, i8* %t702, i8* %t698
  %t705 = getelementptr inbounds %Statement, %Statement* %t686, i32 0, i32 1
  %t706 = bitcast [56 x i8]* %t705 to i8*
  %t707 = bitcast i8* %t706 to i8**
  %t708 = load i8*, i8** %t707
  %t709 = icmp eq i32 %t685, 8
  %t710 = select i1 %t709, i8* %t708, i8* %t704
  %t711 = getelementptr inbounds %Statement, %Statement* %t686, i32 0, i32 1
  %t712 = bitcast [40 x i8]* %t711 to i8*
  %t713 = bitcast i8* %t712 to i8**
  %t714 = load i8*, i8** %t713
  %t715 = icmp eq i32 %t685, 9
  %t716 = select i1 %t715, i8* %t714, i8* %t710
  %t717 = getelementptr inbounds %Statement, %Statement* %t686, i32 0, i32 1
  %t718 = bitcast [40 x i8]* %t717 to i8*
  %t719 = bitcast i8* %t718 to i8**
  %t720 = load i8*, i8** %t719
  %t721 = icmp eq i32 %t685, 10
  %t722 = select i1 %t721, i8* %t720, i8* %t716
  %t723 = getelementptr inbounds %Statement, %Statement* %t686, i32 0, i32 1
  %t724 = bitcast [40 x i8]* %t723 to i8*
  %t725 = bitcast i8* %t724 to i8**
  %t726 = load i8*, i8** %t725
  %t727 = icmp eq i32 %t685, 11
  %t728 = select i1 %t727, i8* %t726, i8* %t722
  %s729 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.729, i32 0, i32 0
  %t730 = extractvalue %Statement %statement, 0
  %t731 = alloca %Statement
  store %Statement %statement, %Statement* %t731
  %t732 = getelementptr inbounds %Statement, %Statement* %t731, i32 0, i32 1
  %t733 = bitcast [48 x i8]* %t732 to i8*
  %t734 = getelementptr inbounds i8, i8* %t733, i64 8
  %t735 = bitcast i8* %t734 to %SourceSpan**
  %t736 = load %SourceSpan*, %SourceSpan** %t735
  %t737 = icmp eq i32 %t730, 3
  %t738 = select i1 %t737, %SourceSpan* %t736, %SourceSpan* null
  %t739 = getelementptr inbounds %Statement, %Statement* %t731, i32 0, i32 1
  %t740 = bitcast [40 x i8]* %t739 to i8*
  %t741 = getelementptr inbounds i8, i8* %t740, i64 8
  %t742 = bitcast i8* %t741 to %SourceSpan**
  %t743 = load %SourceSpan*, %SourceSpan** %t742
  %t744 = icmp eq i32 %t730, 6
  %t745 = select i1 %t744, %SourceSpan* %t743, %SourceSpan* %t738
  %t746 = getelementptr inbounds %Statement, %Statement* %t731, i32 0, i32 1
  %t747 = bitcast [56 x i8]* %t746 to i8*
  %t748 = getelementptr inbounds i8, i8* %t747, i64 8
  %t749 = bitcast i8* %t748 to %SourceSpan**
  %t750 = load %SourceSpan*, %SourceSpan** %t749
  %t751 = icmp eq i32 %t730, 8
  %t752 = select i1 %t751, %SourceSpan* %t750, %SourceSpan* %t745
  %t753 = getelementptr inbounds %Statement, %Statement* %t731, i32 0, i32 1
  %t754 = bitcast [40 x i8]* %t753 to i8*
  %t755 = getelementptr inbounds i8, i8* %t754, i64 8
  %t756 = bitcast i8* %t755 to %SourceSpan**
  %t757 = load %SourceSpan*, %SourceSpan** %t756
  %t758 = icmp eq i32 %t730, 9
  %t759 = select i1 %t758, %SourceSpan* %t757, %SourceSpan* %t752
  %t760 = getelementptr inbounds %Statement, %Statement* %t731, i32 0, i32 1
  %t761 = bitcast [40 x i8]* %t760 to i8*
  %t762 = getelementptr inbounds i8, i8* %t761, i64 8
  %t763 = bitcast i8* %t762 to %SourceSpan**
  %t764 = load %SourceSpan*, %SourceSpan** %t763
  %t765 = icmp eq i32 %t730, 10
  %t766 = select i1 %t765, %SourceSpan* %t764, %SourceSpan* %t759
  %t767 = getelementptr inbounds %Statement, %Statement* %t731, i32 0, i32 1
  %t768 = bitcast [40 x i8]* %t767 to i8*
  %t769 = getelementptr inbounds i8, i8* %t768, i64 8
  %t770 = bitcast i8* %t769 to %SourceSpan**
  %t771 = load %SourceSpan*, %SourceSpan** %t770
  %t772 = icmp eq i32 %t730, 11
  %t773 = select i1 %t772, %SourceSpan* %t771, %SourceSpan* %t766
  %t774 = bitcast %SourceSpan* %t773 to i8*
  %t775 = call %SymbolCollectionResult @register_symbol(i8* %t728, i8* %s729, i8* %t774, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t775
merge9:
  %t776 = extractvalue %Statement %statement, 0
  %t777 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t778 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t779 = icmp eq i32 %t776, 0
  %t780 = select i1 %t779, i8* %t778, i8* %t777
  %t781 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t782 = icmp eq i32 %t776, 1
  %t783 = select i1 %t782, i8* %t781, i8* %t780
  %t784 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t785 = icmp eq i32 %t776, 2
  %t786 = select i1 %t785, i8* %t784, i8* %t783
  %t787 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t788 = icmp eq i32 %t776, 3
  %t789 = select i1 %t788, i8* %t787, i8* %t786
  %t790 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t791 = icmp eq i32 %t776, 4
  %t792 = select i1 %t791, i8* %t790, i8* %t789
  %t793 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t794 = icmp eq i32 %t776, 5
  %t795 = select i1 %t794, i8* %t793, i8* %t792
  %t796 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t797 = icmp eq i32 %t776, 6
  %t798 = select i1 %t797, i8* %t796, i8* %t795
  %t799 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t800 = icmp eq i32 %t776, 7
  %t801 = select i1 %t800, i8* %t799, i8* %t798
  %t802 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t803 = icmp eq i32 %t776, 8
  %t804 = select i1 %t803, i8* %t802, i8* %t801
  %t805 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t806 = icmp eq i32 %t776, 9
  %t807 = select i1 %t806, i8* %t805, i8* %t804
  %t808 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t809 = icmp eq i32 %t776, 10
  %t810 = select i1 %t809, i8* %t808, i8* %t807
  %t811 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t812 = icmp eq i32 %t776, 11
  %t813 = select i1 %t812, i8* %t811, i8* %t810
  %t814 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t815 = icmp eq i32 %t776, 12
  %t816 = select i1 %t815, i8* %t814, i8* %t813
  %t817 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t818 = icmp eq i32 %t776, 13
  %t819 = select i1 %t818, i8* %t817, i8* %t816
  %t820 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t821 = icmp eq i32 %t776, 14
  %t822 = select i1 %t821, i8* %t820, i8* %t819
  %t823 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t824 = icmp eq i32 %t776, 15
  %t825 = select i1 %t824, i8* %t823, i8* %t822
  %t826 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t827 = icmp eq i32 %t776, 16
  %t828 = select i1 %t827, i8* %t826, i8* %t825
  %t829 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t830 = icmp eq i32 %t776, 17
  %t831 = select i1 %t830, i8* %t829, i8* %t828
  %t832 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t833 = icmp eq i32 %t776, 18
  %t834 = select i1 %t833, i8* %t832, i8* %t831
  %t835 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t836 = icmp eq i32 %t776, 19
  %t837 = select i1 %t836, i8* %t835, i8* %t834
  %t838 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t839 = icmp eq i32 %t776, 20
  %t840 = select i1 %t839, i8* %t838, i8* %t837
  %t841 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t842 = icmp eq i32 %t776, 21
  %t843 = select i1 %t842, i8* %t841, i8* %t840
  %t844 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t845 = icmp eq i32 %t776, 22
  %t846 = select i1 %t845, i8* %t844, i8* %t843
  %s847 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.847, i32 0, i32 0
  %t848 = icmp eq i8* %t846, %s847
  br i1 %t848, label %then10, label %merge11
then10:
  %t849 = extractvalue %Statement %statement, 0
  %t850 = alloca %Statement
  store %Statement %statement, %Statement* %t850
  %t851 = getelementptr inbounds %Statement, %Statement* %t850, i32 0, i32 1
  %t852 = bitcast [24 x i8]* %t851 to i8*
  %t853 = bitcast i8* %t852 to %FunctionSignature**
  %t854 = load %FunctionSignature*, %FunctionSignature** %t853
  %t855 = icmp eq i32 %t849, 4
  %t856 = select i1 %t855, %FunctionSignature* %t854, %FunctionSignature* null
  %t857 = getelementptr inbounds %Statement, %Statement* %t850, i32 0, i32 1
  %t858 = bitcast [24 x i8]* %t857 to i8*
  %t859 = bitcast i8* %t858 to %FunctionSignature**
  %t860 = load %FunctionSignature*, %FunctionSignature** %t859
  %t861 = icmp eq i32 %t849, 5
  %t862 = select i1 %t861, %FunctionSignature* %t860, %FunctionSignature* %t856
  %t863 = getelementptr inbounds %Statement, %Statement* %t850, i32 0, i32 1
  %t864 = bitcast [24 x i8]* %t863 to i8*
  %t865 = bitcast i8* %t864 to %FunctionSignature**
  %t866 = load %FunctionSignature*, %FunctionSignature** %t865
  %t867 = icmp eq i32 %t849, 7
  %t868 = select i1 %t867, %FunctionSignature* %t866, %FunctionSignature* %t862
  %t869 = getelementptr %FunctionSignature, %FunctionSignature* %t868, i32 0, i32 0
  %t870 = load i8*, i8** %t869
  %s871 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.871, i32 0, i32 0
  %t872 = extractvalue %Statement %statement, 0
  %t873 = alloca %Statement
  store %Statement %statement, %Statement* %t873
  %t874 = getelementptr inbounds %Statement, %Statement* %t873, i32 0, i32 1
  %t875 = bitcast [24 x i8]* %t874 to i8*
  %t876 = bitcast i8* %t875 to %FunctionSignature**
  %t877 = load %FunctionSignature*, %FunctionSignature** %t876
  %t878 = icmp eq i32 %t872, 4
  %t879 = select i1 %t878, %FunctionSignature* %t877, %FunctionSignature* null
  %t880 = getelementptr inbounds %Statement, %Statement* %t873, i32 0, i32 1
  %t881 = bitcast [24 x i8]* %t880 to i8*
  %t882 = bitcast i8* %t881 to %FunctionSignature**
  %t883 = load %FunctionSignature*, %FunctionSignature** %t882
  %t884 = icmp eq i32 %t872, 5
  %t885 = select i1 %t884, %FunctionSignature* %t883, %FunctionSignature* %t879
  %t886 = getelementptr inbounds %Statement, %Statement* %t873, i32 0, i32 1
  %t887 = bitcast [24 x i8]* %t886 to i8*
  %t888 = bitcast i8* %t887 to %FunctionSignature**
  %t889 = load %FunctionSignature*, %FunctionSignature** %t888
  %t890 = icmp eq i32 %t872, 7
  %t891 = select i1 %t890, %FunctionSignature* %t889, %FunctionSignature* %t885
  %t892 = getelementptr %FunctionSignature, %FunctionSignature* %t891, i32 0, i32 6
  %t893 = load %SourceSpan*, %SourceSpan** %t892
  %t894 = bitcast %SourceSpan* %t893 to i8*
  %t895 = call %SymbolCollectionResult @register_symbol(i8* %t870, i8* %s871, i8* %t894, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t895
merge11:
  %t896 = extractvalue %Statement %statement, 0
  %t897 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t898 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t899 = icmp eq i32 %t896, 0
  %t900 = select i1 %t899, i8* %t898, i8* %t897
  %t901 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t902 = icmp eq i32 %t896, 1
  %t903 = select i1 %t902, i8* %t901, i8* %t900
  %t904 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t905 = icmp eq i32 %t896, 2
  %t906 = select i1 %t905, i8* %t904, i8* %t903
  %t907 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t908 = icmp eq i32 %t896, 3
  %t909 = select i1 %t908, i8* %t907, i8* %t906
  %t910 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t911 = icmp eq i32 %t896, 4
  %t912 = select i1 %t911, i8* %t910, i8* %t909
  %t913 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t914 = icmp eq i32 %t896, 5
  %t915 = select i1 %t914, i8* %t913, i8* %t912
  %t916 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t917 = icmp eq i32 %t896, 6
  %t918 = select i1 %t917, i8* %t916, i8* %t915
  %t919 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t920 = icmp eq i32 %t896, 7
  %t921 = select i1 %t920, i8* %t919, i8* %t918
  %t922 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t923 = icmp eq i32 %t896, 8
  %t924 = select i1 %t923, i8* %t922, i8* %t921
  %t925 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t926 = icmp eq i32 %t896, 9
  %t927 = select i1 %t926, i8* %t925, i8* %t924
  %t928 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t929 = icmp eq i32 %t896, 10
  %t930 = select i1 %t929, i8* %t928, i8* %t927
  %t931 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t932 = icmp eq i32 %t896, 11
  %t933 = select i1 %t932, i8* %t931, i8* %t930
  %t934 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t935 = icmp eq i32 %t896, 12
  %t936 = select i1 %t935, i8* %t934, i8* %t933
  %t937 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t938 = icmp eq i32 %t896, 13
  %t939 = select i1 %t938, i8* %t937, i8* %t936
  %t940 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t941 = icmp eq i32 %t896, 14
  %t942 = select i1 %t941, i8* %t940, i8* %t939
  %t943 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t944 = icmp eq i32 %t896, 15
  %t945 = select i1 %t944, i8* %t943, i8* %t942
  %t946 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t947 = icmp eq i32 %t896, 16
  %t948 = select i1 %t947, i8* %t946, i8* %t945
  %t949 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t950 = icmp eq i32 %t896, 17
  %t951 = select i1 %t950, i8* %t949, i8* %t948
  %t952 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t953 = icmp eq i32 %t896, 18
  %t954 = select i1 %t953, i8* %t952, i8* %t951
  %t955 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t956 = icmp eq i32 %t896, 19
  %t957 = select i1 %t956, i8* %t955, i8* %t954
  %t958 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t959 = icmp eq i32 %t896, 20
  %t960 = select i1 %t959, i8* %t958, i8* %t957
  %t961 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t962 = icmp eq i32 %t896, 21
  %t963 = select i1 %t962, i8* %t961, i8* %t960
  %t964 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t965 = icmp eq i32 %t896, 22
  %t966 = select i1 %t965, i8* %t964, i8* %t963
  %s967 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.967, i32 0, i32 0
  %t968 = icmp eq i8* %t966, %s967
  br i1 %t968, label %then12, label %merge13
then12:
  %t969 = extractvalue %Statement %statement, 0
  %t970 = alloca %Statement
  store %Statement %statement, %Statement* %t970
  %t971 = getelementptr inbounds %Statement, %Statement* %t970, i32 0, i32 1
  %t972 = bitcast [24 x i8]* %t971 to i8*
  %t973 = bitcast i8* %t972 to %FunctionSignature**
  %t974 = load %FunctionSignature*, %FunctionSignature** %t973
  %t975 = icmp eq i32 %t969, 4
  %t976 = select i1 %t975, %FunctionSignature* %t974, %FunctionSignature* null
  %t977 = getelementptr inbounds %Statement, %Statement* %t970, i32 0, i32 1
  %t978 = bitcast [24 x i8]* %t977 to i8*
  %t979 = bitcast i8* %t978 to %FunctionSignature**
  %t980 = load %FunctionSignature*, %FunctionSignature** %t979
  %t981 = icmp eq i32 %t969, 5
  %t982 = select i1 %t981, %FunctionSignature* %t980, %FunctionSignature* %t976
  %t983 = getelementptr inbounds %Statement, %Statement* %t970, i32 0, i32 1
  %t984 = bitcast [24 x i8]* %t983 to i8*
  %t985 = bitcast i8* %t984 to %FunctionSignature**
  %t986 = load %FunctionSignature*, %FunctionSignature** %t985
  %t987 = icmp eq i32 %t969, 7
  %t988 = select i1 %t987, %FunctionSignature* %t986, %FunctionSignature* %t982
  %t989 = getelementptr %FunctionSignature, %FunctionSignature* %t988, i32 0, i32 0
  %t990 = load i8*, i8** %t989
  %s991 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.991, i32 0, i32 0
  %t992 = extractvalue %Statement %statement, 0
  %t993 = alloca %Statement
  store %Statement %statement, %Statement* %t993
  %t994 = getelementptr inbounds %Statement, %Statement* %t993, i32 0, i32 1
  %t995 = bitcast [24 x i8]* %t994 to i8*
  %t996 = bitcast i8* %t995 to %FunctionSignature**
  %t997 = load %FunctionSignature*, %FunctionSignature** %t996
  %t998 = icmp eq i32 %t992, 4
  %t999 = select i1 %t998, %FunctionSignature* %t997, %FunctionSignature* null
  %t1000 = getelementptr inbounds %Statement, %Statement* %t993, i32 0, i32 1
  %t1001 = bitcast [24 x i8]* %t1000 to i8*
  %t1002 = bitcast i8* %t1001 to %FunctionSignature**
  %t1003 = load %FunctionSignature*, %FunctionSignature** %t1002
  %t1004 = icmp eq i32 %t992, 5
  %t1005 = select i1 %t1004, %FunctionSignature* %t1003, %FunctionSignature* %t999
  %t1006 = getelementptr inbounds %Statement, %Statement* %t993, i32 0, i32 1
  %t1007 = bitcast [24 x i8]* %t1006 to i8*
  %t1008 = bitcast i8* %t1007 to %FunctionSignature**
  %t1009 = load %FunctionSignature*, %FunctionSignature** %t1008
  %t1010 = icmp eq i32 %t992, 7
  %t1011 = select i1 %t1010, %FunctionSignature* %t1009, %FunctionSignature* %t1005
  %t1012 = getelementptr %FunctionSignature, %FunctionSignature* %t1011, i32 0, i32 6
  %t1013 = load %SourceSpan*, %SourceSpan** %t1012
  %t1014 = bitcast %SourceSpan* %t1013 to i8*
  %t1015 = call %SymbolCollectionResult @register_symbol(i8* %t990, i8* %s991, i8* %t1014, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1015
merge13:
  %t1016 = extractvalue %Statement %statement, 0
  %t1017 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1018 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1019 = icmp eq i32 %t1016, 0
  %t1020 = select i1 %t1019, i8* %t1018, i8* %t1017
  %t1021 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1022 = icmp eq i32 %t1016, 1
  %t1023 = select i1 %t1022, i8* %t1021, i8* %t1020
  %t1024 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1025 = icmp eq i32 %t1016, 2
  %t1026 = select i1 %t1025, i8* %t1024, i8* %t1023
  %t1027 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1028 = icmp eq i32 %t1016, 3
  %t1029 = select i1 %t1028, i8* %t1027, i8* %t1026
  %t1030 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1031 = icmp eq i32 %t1016, 4
  %t1032 = select i1 %t1031, i8* %t1030, i8* %t1029
  %t1033 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1034 = icmp eq i32 %t1016, 5
  %t1035 = select i1 %t1034, i8* %t1033, i8* %t1032
  %t1036 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1037 = icmp eq i32 %t1016, 6
  %t1038 = select i1 %t1037, i8* %t1036, i8* %t1035
  %t1039 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1040 = icmp eq i32 %t1016, 7
  %t1041 = select i1 %t1040, i8* %t1039, i8* %t1038
  %t1042 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1043 = icmp eq i32 %t1016, 8
  %t1044 = select i1 %t1043, i8* %t1042, i8* %t1041
  %t1045 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1046 = icmp eq i32 %t1016, 9
  %t1047 = select i1 %t1046, i8* %t1045, i8* %t1044
  %t1048 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1049 = icmp eq i32 %t1016, 10
  %t1050 = select i1 %t1049, i8* %t1048, i8* %t1047
  %t1051 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1052 = icmp eq i32 %t1016, 11
  %t1053 = select i1 %t1052, i8* %t1051, i8* %t1050
  %t1054 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1055 = icmp eq i32 %t1016, 12
  %t1056 = select i1 %t1055, i8* %t1054, i8* %t1053
  %t1057 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1058 = icmp eq i32 %t1016, 13
  %t1059 = select i1 %t1058, i8* %t1057, i8* %t1056
  %t1060 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1061 = icmp eq i32 %t1016, 14
  %t1062 = select i1 %t1061, i8* %t1060, i8* %t1059
  %t1063 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1064 = icmp eq i32 %t1016, 15
  %t1065 = select i1 %t1064, i8* %t1063, i8* %t1062
  %t1066 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1067 = icmp eq i32 %t1016, 16
  %t1068 = select i1 %t1067, i8* %t1066, i8* %t1065
  %t1069 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1070 = icmp eq i32 %t1016, 17
  %t1071 = select i1 %t1070, i8* %t1069, i8* %t1068
  %t1072 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1073 = icmp eq i32 %t1016, 18
  %t1074 = select i1 %t1073, i8* %t1072, i8* %t1071
  %t1075 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1076 = icmp eq i32 %t1016, 19
  %t1077 = select i1 %t1076, i8* %t1075, i8* %t1074
  %t1078 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1079 = icmp eq i32 %t1016, 20
  %t1080 = select i1 %t1079, i8* %t1078, i8* %t1077
  %t1081 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1082 = icmp eq i32 %t1016, 21
  %t1083 = select i1 %t1082, i8* %t1081, i8* %t1080
  %t1084 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1085 = icmp eq i32 %t1016, 22
  %t1086 = select i1 %t1085, i8* %t1084, i8* %t1083
  %s1087 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1087, i32 0, i32 0
  %t1088 = icmp eq i8* %t1086, %s1087
  br i1 %t1088, label %then14, label %merge15
then14:
  %t1089 = extractvalue %Statement %statement, 0
  %t1090 = alloca %Statement
  store %Statement %statement, %Statement* %t1090
  %t1091 = getelementptr inbounds %Statement, %Statement* %t1090, i32 0, i32 1
  %t1092 = bitcast [48 x i8]* %t1091 to i8*
  %t1093 = bitcast i8* %t1092 to i8**
  %t1094 = load i8*, i8** %t1093
  %t1095 = icmp eq i32 %t1089, 2
  %t1096 = select i1 %t1095, i8* %t1094, i8* null
  %t1097 = getelementptr inbounds %Statement, %Statement* %t1090, i32 0, i32 1
  %t1098 = bitcast [48 x i8]* %t1097 to i8*
  %t1099 = bitcast i8* %t1098 to i8**
  %t1100 = load i8*, i8** %t1099
  %t1101 = icmp eq i32 %t1089, 3
  %t1102 = select i1 %t1101, i8* %t1100, i8* %t1096
  %t1103 = getelementptr inbounds %Statement, %Statement* %t1090, i32 0, i32 1
  %t1104 = bitcast [40 x i8]* %t1103 to i8*
  %t1105 = bitcast i8* %t1104 to i8**
  %t1106 = load i8*, i8** %t1105
  %t1107 = icmp eq i32 %t1089, 6
  %t1108 = select i1 %t1107, i8* %t1106, i8* %t1102
  %t1109 = getelementptr inbounds %Statement, %Statement* %t1090, i32 0, i32 1
  %t1110 = bitcast [56 x i8]* %t1109 to i8*
  %t1111 = bitcast i8* %t1110 to i8**
  %t1112 = load i8*, i8** %t1111
  %t1113 = icmp eq i32 %t1089, 8
  %t1114 = select i1 %t1113, i8* %t1112, i8* %t1108
  %t1115 = getelementptr inbounds %Statement, %Statement* %t1090, i32 0, i32 1
  %t1116 = bitcast [40 x i8]* %t1115 to i8*
  %t1117 = bitcast i8* %t1116 to i8**
  %t1118 = load i8*, i8** %t1117
  %t1119 = icmp eq i32 %t1089, 9
  %t1120 = select i1 %t1119, i8* %t1118, i8* %t1114
  %t1121 = getelementptr inbounds %Statement, %Statement* %t1090, i32 0, i32 1
  %t1122 = bitcast [40 x i8]* %t1121 to i8*
  %t1123 = bitcast i8* %t1122 to i8**
  %t1124 = load i8*, i8** %t1123
  %t1125 = icmp eq i32 %t1089, 10
  %t1126 = select i1 %t1125, i8* %t1124, i8* %t1120
  %t1127 = getelementptr inbounds %Statement, %Statement* %t1090, i32 0, i32 1
  %t1128 = bitcast [40 x i8]* %t1127 to i8*
  %t1129 = bitcast i8* %t1128 to i8**
  %t1130 = load i8*, i8** %t1129
  %t1131 = icmp eq i32 %t1089, 11
  %t1132 = select i1 %t1131, i8* %t1130, i8* %t1126
  %s1133 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1133, i32 0, i32 0
  %t1134 = extractvalue %Statement %statement, 0
  %t1135 = alloca %Statement
  store %Statement %statement, %Statement* %t1135
  %t1136 = getelementptr inbounds %Statement, %Statement* %t1135, i32 0, i32 1
  %t1137 = bitcast [48 x i8]* %t1136 to i8*
  %t1138 = getelementptr inbounds i8, i8* %t1137, i64 8
  %t1139 = bitcast i8* %t1138 to %SourceSpan**
  %t1140 = load %SourceSpan*, %SourceSpan** %t1139
  %t1141 = icmp eq i32 %t1134, 3
  %t1142 = select i1 %t1141, %SourceSpan* %t1140, %SourceSpan* null
  %t1143 = getelementptr inbounds %Statement, %Statement* %t1135, i32 0, i32 1
  %t1144 = bitcast [40 x i8]* %t1143 to i8*
  %t1145 = getelementptr inbounds i8, i8* %t1144, i64 8
  %t1146 = bitcast i8* %t1145 to %SourceSpan**
  %t1147 = load %SourceSpan*, %SourceSpan** %t1146
  %t1148 = icmp eq i32 %t1134, 6
  %t1149 = select i1 %t1148, %SourceSpan* %t1147, %SourceSpan* %t1142
  %t1150 = getelementptr inbounds %Statement, %Statement* %t1135, i32 0, i32 1
  %t1151 = bitcast [56 x i8]* %t1150 to i8*
  %t1152 = getelementptr inbounds i8, i8* %t1151, i64 8
  %t1153 = bitcast i8* %t1152 to %SourceSpan**
  %t1154 = load %SourceSpan*, %SourceSpan** %t1153
  %t1155 = icmp eq i32 %t1134, 8
  %t1156 = select i1 %t1155, %SourceSpan* %t1154, %SourceSpan* %t1149
  %t1157 = getelementptr inbounds %Statement, %Statement* %t1135, i32 0, i32 1
  %t1158 = bitcast [40 x i8]* %t1157 to i8*
  %t1159 = getelementptr inbounds i8, i8* %t1158, i64 8
  %t1160 = bitcast i8* %t1159 to %SourceSpan**
  %t1161 = load %SourceSpan*, %SourceSpan** %t1160
  %t1162 = icmp eq i32 %t1134, 9
  %t1163 = select i1 %t1162, %SourceSpan* %t1161, %SourceSpan* %t1156
  %t1164 = getelementptr inbounds %Statement, %Statement* %t1135, i32 0, i32 1
  %t1165 = bitcast [40 x i8]* %t1164 to i8*
  %t1166 = getelementptr inbounds i8, i8* %t1165, i64 8
  %t1167 = bitcast i8* %t1166 to %SourceSpan**
  %t1168 = load %SourceSpan*, %SourceSpan** %t1167
  %t1169 = icmp eq i32 %t1134, 10
  %t1170 = select i1 %t1169, %SourceSpan* %t1168, %SourceSpan* %t1163
  %t1171 = getelementptr inbounds %Statement, %Statement* %t1135, i32 0, i32 1
  %t1172 = bitcast [40 x i8]* %t1171 to i8*
  %t1173 = getelementptr inbounds i8, i8* %t1172, i64 8
  %t1174 = bitcast i8* %t1173 to %SourceSpan**
  %t1175 = load %SourceSpan*, %SourceSpan** %t1174
  %t1176 = icmp eq i32 %t1134, 11
  %t1177 = select i1 %t1176, %SourceSpan* %t1175, %SourceSpan* %t1170
  %t1178 = bitcast %SourceSpan* %t1177 to i8*
  %t1179 = call %SymbolCollectionResult @register_symbol(i8* %t1132, i8* %s1133, i8* %t1178, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1179
merge15:
  %t1180 = extractvalue %Statement %statement, 0
  %t1181 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1182 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1183 = icmp eq i32 %t1180, 0
  %t1184 = select i1 %t1183, i8* %t1182, i8* %t1181
  %t1185 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1186 = icmp eq i32 %t1180, 1
  %t1187 = select i1 %t1186, i8* %t1185, i8* %t1184
  %t1188 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1189 = icmp eq i32 %t1180, 2
  %t1190 = select i1 %t1189, i8* %t1188, i8* %t1187
  %t1191 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1192 = icmp eq i32 %t1180, 3
  %t1193 = select i1 %t1192, i8* %t1191, i8* %t1190
  %t1194 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1195 = icmp eq i32 %t1180, 4
  %t1196 = select i1 %t1195, i8* %t1194, i8* %t1193
  %t1197 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1198 = icmp eq i32 %t1180, 5
  %t1199 = select i1 %t1198, i8* %t1197, i8* %t1196
  %t1200 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1201 = icmp eq i32 %t1180, 6
  %t1202 = select i1 %t1201, i8* %t1200, i8* %t1199
  %t1203 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1204 = icmp eq i32 %t1180, 7
  %t1205 = select i1 %t1204, i8* %t1203, i8* %t1202
  %t1206 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1207 = icmp eq i32 %t1180, 8
  %t1208 = select i1 %t1207, i8* %t1206, i8* %t1205
  %t1209 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1210 = icmp eq i32 %t1180, 9
  %t1211 = select i1 %t1210, i8* %t1209, i8* %t1208
  %t1212 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1213 = icmp eq i32 %t1180, 10
  %t1214 = select i1 %t1213, i8* %t1212, i8* %t1211
  %t1215 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1216 = icmp eq i32 %t1180, 11
  %t1217 = select i1 %t1216, i8* %t1215, i8* %t1214
  %t1218 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1219 = icmp eq i32 %t1180, 12
  %t1220 = select i1 %t1219, i8* %t1218, i8* %t1217
  %t1221 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1222 = icmp eq i32 %t1180, 13
  %t1223 = select i1 %t1222, i8* %t1221, i8* %t1220
  %t1224 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1225 = icmp eq i32 %t1180, 14
  %t1226 = select i1 %t1225, i8* %t1224, i8* %t1223
  %t1227 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1228 = icmp eq i32 %t1180, 15
  %t1229 = select i1 %t1228, i8* %t1227, i8* %t1226
  %t1230 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1231 = icmp eq i32 %t1180, 16
  %t1232 = select i1 %t1231, i8* %t1230, i8* %t1229
  %t1233 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1234 = icmp eq i32 %t1180, 17
  %t1235 = select i1 %t1234, i8* %t1233, i8* %t1232
  %t1236 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1237 = icmp eq i32 %t1180, 18
  %t1238 = select i1 %t1237, i8* %t1236, i8* %t1235
  %t1239 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1240 = icmp eq i32 %t1180, 19
  %t1241 = select i1 %t1240, i8* %t1239, i8* %t1238
  %t1242 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1243 = icmp eq i32 %t1180, 20
  %t1244 = select i1 %t1243, i8* %t1242, i8* %t1241
  %t1245 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1246 = icmp eq i32 %t1180, 21
  %t1247 = select i1 %t1246, i8* %t1245, i8* %t1244
  %t1248 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1249 = icmp eq i32 %t1180, 22
  %t1250 = select i1 %t1249, i8* %t1248, i8* %t1247
  %s1251 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.1251, i32 0, i32 0
  %t1252 = icmp eq i8* %t1250, %s1251
  br i1 %t1252, label %then16, label %merge17
then16:
  %t1253 = extractvalue %Statement %statement, 0
  %t1254 = alloca %Statement
  store %Statement %statement, %Statement* %t1254
  %t1255 = getelementptr inbounds %Statement, %Statement* %t1254, i32 0, i32 1
  %t1256 = bitcast [48 x i8]* %t1255 to i8*
  %t1257 = bitcast i8* %t1256 to i8**
  %t1258 = load i8*, i8** %t1257
  %t1259 = icmp eq i32 %t1253, 2
  %t1260 = select i1 %t1259, i8* %t1258, i8* null
  %t1261 = getelementptr inbounds %Statement, %Statement* %t1254, i32 0, i32 1
  %t1262 = bitcast [48 x i8]* %t1261 to i8*
  %t1263 = bitcast i8* %t1262 to i8**
  %t1264 = load i8*, i8** %t1263
  %t1265 = icmp eq i32 %t1253, 3
  %t1266 = select i1 %t1265, i8* %t1264, i8* %t1260
  %t1267 = getelementptr inbounds %Statement, %Statement* %t1254, i32 0, i32 1
  %t1268 = bitcast [40 x i8]* %t1267 to i8*
  %t1269 = bitcast i8* %t1268 to i8**
  %t1270 = load i8*, i8** %t1269
  %t1271 = icmp eq i32 %t1253, 6
  %t1272 = select i1 %t1271, i8* %t1270, i8* %t1266
  %t1273 = getelementptr inbounds %Statement, %Statement* %t1254, i32 0, i32 1
  %t1274 = bitcast [56 x i8]* %t1273 to i8*
  %t1275 = bitcast i8* %t1274 to i8**
  %t1276 = load i8*, i8** %t1275
  %t1277 = icmp eq i32 %t1253, 8
  %t1278 = select i1 %t1277, i8* %t1276, i8* %t1272
  %t1279 = getelementptr inbounds %Statement, %Statement* %t1254, i32 0, i32 1
  %t1280 = bitcast [40 x i8]* %t1279 to i8*
  %t1281 = bitcast i8* %t1280 to i8**
  %t1282 = load i8*, i8** %t1281
  %t1283 = icmp eq i32 %t1253, 9
  %t1284 = select i1 %t1283, i8* %t1282, i8* %t1278
  %t1285 = getelementptr inbounds %Statement, %Statement* %t1254, i32 0, i32 1
  %t1286 = bitcast [40 x i8]* %t1285 to i8*
  %t1287 = bitcast i8* %t1286 to i8**
  %t1288 = load i8*, i8** %t1287
  %t1289 = icmp eq i32 %t1253, 10
  %t1290 = select i1 %t1289, i8* %t1288, i8* %t1284
  %t1291 = getelementptr inbounds %Statement, %Statement* %t1254, i32 0, i32 1
  %t1292 = bitcast [40 x i8]* %t1291 to i8*
  %t1293 = bitcast i8* %t1292 to i8**
  %t1294 = load i8*, i8** %t1293
  %t1295 = icmp eq i32 %t1253, 11
  %t1296 = select i1 %t1295, i8* %t1294, i8* %t1290
  %s1297 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1297, i32 0, i32 0
  %t1298 = extractvalue %Statement %statement, 0
  %t1299 = alloca %Statement
  store %Statement %statement, %Statement* %t1299
  %t1300 = getelementptr inbounds %Statement, %Statement* %t1299, i32 0, i32 1
  %t1301 = bitcast [48 x i8]* %t1300 to i8*
  %t1302 = getelementptr inbounds i8, i8* %t1301, i64 8
  %t1303 = bitcast i8* %t1302 to %SourceSpan**
  %t1304 = load %SourceSpan*, %SourceSpan** %t1303
  %t1305 = icmp eq i32 %t1298, 3
  %t1306 = select i1 %t1305, %SourceSpan* %t1304, %SourceSpan* null
  %t1307 = getelementptr inbounds %Statement, %Statement* %t1299, i32 0, i32 1
  %t1308 = bitcast [40 x i8]* %t1307 to i8*
  %t1309 = getelementptr inbounds i8, i8* %t1308, i64 8
  %t1310 = bitcast i8* %t1309 to %SourceSpan**
  %t1311 = load %SourceSpan*, %SourceSpan** %t1310
  %t1312 = icmp eq i32 %t1298, 6
  %t1313 = select i1 %t1312, %SourceSpan* %t1311, %SourceSpan* %t1306
  %t1314 = getelementptr inbounds %Statement, %Statement* %t1299, i32 0, i32 1
  %t1315 = bitcast [56 x i8]* %t1314 to i8*
  %t1316 = getelementptr inbounds i8, i8* %t1315, i64 8
  %t1317 = bitcast i8* %t1316 to %SourceSpan**
  %t1318 = load %SourceSpan*, %SourceSpan** %t1317
  %t1319 = icmp eq i32 %t1298, 8
  %t1320 = select i1 %t1319, %SourceSpan* %t1318, %SourceSpan* %t1313
  %t1321 = getelementptr inbounds %Statement, %Statement* %t1299, i32 0, i32 1
  %t1322 = bitcast [40 x i8]* %t1321 to i8*
  %t1323 = getelementptr inbounds i8, i8* %t1322, i64 8
  %t1324 = bitcast i8* %t1323 to %SourceSpan**
  %t1325 = load %SourceSpan*, %SourceSpan** %t1324
  %t1326 = icmp eq i32 %t1298, 9
  %t1327 = select i1 %t1326, %SourceSpan* %t1325, %SourceSpan* %t1320
  %t1328 = getelementptr inbounds %Statement, %Statement* %t1299, i32 0, i32 1
  %t1329 = bitcast [40 x i8]* %t1328 to i8*
  %t1330 = getelementptr inbounds i8, i8* %t1329, i64 8
  %t1331 = bitcast i8* %t1330 to %SourceSpan**
  %t1332 = load %SourceSpan*, %SourceSpan** %t1331
  %t1333 = icmp eq i32 %t1298, 10
  %t1334 = select i1 %t1333, %SourceSpan* %t1332, %SourceSpan* %t1327
  %t1335 = getelementptr inbounds %Statement, %Statement* %t1299, i32 0, i32 1
  %t1336 = bitcast [40 x i8]* %t1335 to i8*
  %t1337 = getelementptr inbounds i8, i8* %t1336, i64 8
  %t1338 = bitcast i8* %t1337 to %SourceSpan**
  %t1339 = load %SourceSpan*, %SourceSpan** %t1338
  %t1340 = icmp eq i32 %t1298, 11
  %t1341 = select i1 %t1340, %SourceSpan* %t1339, %SourceSpan* %t1334
  %t1342 = bitcast %SourceSpan* %t1341 to i8*
  %t1343 = call %SymbolCollectionResult @register_symbol(i8* %t1296, i8* %s1297, i8* %t1342, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1343
merge17:
  %t1344 = extractvalue %Statement %statement, 0
  %t1345 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1346 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1347 = icmp eq i32 %t1344, 0
  %t1348 = select i1 %t1347, i8* %t1346, i8* %t1345
  %t1349 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1350 = icmp eq i32 %t1344, 1
  %t1351 = select i1 %t1350, i8* %t1349, i8* %t1348
  %t1352 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1353 = icmp eq i32 %t1344, 2
  %t1354 = select i1 %t1353, i8* %t1352, i8* %t1351
  %t1355 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1356 = icmp eq i32 %t1344, 3
  %t1357 = select i1 %t1356, i8* %t1355, i8* %t1354
  %t1358 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1359 = icmp eq i32 %t1344, 4
  %t1360 = select i1 %t1359, i8* %t1358, i8* %t1357
  %t1361 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1362 = icmp eq i32 %t1344, 5
  %t1363 = select i1 %t1362, i8* %t1361, i8* %t1360
  %t1364 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1365 = icmp eq i32 %t1344, 6
  %t1366 = select i1 %t1365, i8* %t1364, i8* %t1363
  %t1367 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1368 = icmp eq i32 %t1344, 7
  %t1369 = select i1 %t1368, i8* %t1367, i8* %t1366
  %t1370 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1371 = icmp eq i32 %t1344, 8
  %t1372 = select i1 %t1371, i8* %t1370, i8* %t1369
  %t1373 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1374 = icmp eq i32 %t1344, 9
  %t1375 = select i1 %t1374, i8* %t1373, i8* %t1372
  %t1376 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1377 = icmp eq i32 %t1344, 10
  %t1378 = select i1 %t1377, i8* %t1376, i8* %t1375
  %t1379 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1380 = icmp eq i32 %t1344, 11
  %t1381 = select i1 %t1380, i8* %t1379, i8* %t1378
  %t1382 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1383 = icmp eq i32 %t1344, 12
  %t1384 = select i1 %t1383, i8* %t1382, i8* %t1381
  %t1385 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1386 = icmp eq i32 %t1344, 13
  %t1387 = select i1 %t1386, i8* %t1385, i8* %t1384
  %t1388 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1389 = icmp eq i32 %t1344, 14
  %t1390 = select i1 %t1389, i8* %t1388, i8* %t1387
  %t1391 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1392 = icmp eq i32 %t1344, 15
  %t1393 = select i1 %t1392, i8* %t1391, i8* %t1390
  %t1394 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1395 = icmp eq i32 %t1344, 16
  %t1396 = select i1 %t1395, i8* %t1394, i8* %t1393
  %t1397 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1398 = icmp eq i32 %t1344, 17
  %t1399 = select i1 %t1398, i8* %t1397, i8* %t1396
  %t1400 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1401 = icmp eq i32 %t1344, 18
  %t1402 = select i1 %t1401, i8* %t1400, i8* %t1399
  %t1403 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1404 = icmp eq i32 %t1344, 19
  %t1405 = select i1 %t1404, i8* %t1403, i8* %t1402
  %t1406 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1407 = icmp eq i32 %t1344, 20
  %t1408 = select i1 %t1407, i8* %t1406, i8* %t1405
  %t1409 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1410 = icmp eq i32 %t1344, 21
  %t1411 = select i1 %t1410, i8* %t1409, i8* %t1408
  %t1412 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1413 = icmp eq i32 %t1344, 22
  %t1414 = select i1 %t1413, i8* %t1412, i8* %t1411
  %s1415 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1415, i32 0, i32 0
  %t1416 = icmp eq i8* %t1414, %s1415
  br i1 %t1416, label %then18, label %merge19
then18:
  %t1417 = extractvalue %Statement %statement, 0
  %t1418 = alloca %Statement
  store %Statement %statement, %Statement* %t1418
  %t1419 = getelementptr inbounds %Statement, %Statement* %t1418, i32 0, i32 1
  %t1420 = bitcast [48 x i8]* %t1419 to i8*
  %t1421 = bitcast i8* %t1420 to i8**
  %t1422 = load i8*, i8** %t1421
  %t1423 = icmp eq i32 %t1417, 2
  %t1424 = select i1 %t1423, i8* %t1422, i8* null
  %t1425 = getelementptr inbounds %Statement, %Statement* %t1418, i32 0, i32 1
  %t1426 = bitcast [48 x i8]* %t1425 to i8*
  %t1427 = bitcast i8* %t1426 to i8**
  %t1428 = load i8*, i8** %t1427
  %t1429 = icmp eq i32 %t1417, 3
  %t1430 = select i1 %t1429, i8* %t1428, i8* %t1424
  %t1431 = getelementptr inbounds %Statement, %Statement* %t1418, i32 0, i32 1
  %t1432 = bitcast [40 x i8]* %t1431 to i8*
  %t1433 = bitcast i8* %t1432 to i8**
  %t1434 = load i8*, i8** %t1433
  %t1435 = icmp eq i32 %t1417, 6
  %t1436 = select i1 %t1435, i8* %t1434, i8* %t1430
  %t1437 = getelementptr inbounds %Statement, %Statement* %t1418, i32 0, i32 1
  %t1438 = bitcast [56 x i8]* %t1437 to i8*
  %t1439 = bitcast i8* %t1438 to i8**
  %t1440 = load i8*, i8** %t1439
  %t1441 = icmp eq i32 %t1417, 8
  %t1442 = select i1 %t1441, i8* %t1440, i8* %t1436
  %t1443 = getelementptr inbounds %Statement, %Statement* %t1418, i32 0, i32 1
  %t1444 = bitcast [40 x i8]* %t1443 to i8*
  %t1445 = bitcast i8* %t1444 to i8**
  %t1446 = load i8*, i8** %t1445
  %t1447 = icmp eq i32 %t1417, 9
  %t1448 = select i1 %t1447, i8* %t1446, i8* %t1442
  %t1449 = getelementptr inbounds %Statement, %Statement* %t1418, i32 0, i32 1
  %t1450 = bitcast [40 x i8]* %t1449 to i8*
  %t1451 = bitcast i8* %t1450 to i8**
  %t1452 = load i8*, i8** %t1451
  %t1453 = icmp eq i32 %t1417, 10
  %t1454 = select i1 %t1453, i8* %t1452, i8* %t1448
  %t1455 = getelementptr inbounds %Statement, %Statement* %t1418, i32 0, i32 1
  %t1456 = bitcast [40 x i8]* %t1455 to i8*
  %t1457 = bitcast i8* %t1456 to i8**
  %t1458 = load i8*, i8** %t1457
  %t1459 = icmp eq i32 %t1417, 11
  %t1460 = select i1 %t1459, i8* %t1458, i8* %t1454
  %s1461 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1461, i32 0, i32 0
  %t1462 = extractvalue %Statement %statement, 0
  %t1463 = alloca %Statement
  store %Statement %statement, %Statement* %t1463
  %t1464 = getelementptr inbounds %Statement, %Statement* %t1463, i32 0, i32 1
  %t1465 = bitcast [48 x i8]* %t1464 to i8*
  %t1466 = getelementptr inbounds i8, i8* %t1465, i64 32
  %t1467 = bitcast i8* %t1466 to %SourceSpan**
  %t1468 = load %SourceSpan*, %SourceSpan** %t1467
  %t1469 = icmp eq i32 %t1462, 2
  %t1470 = select i1 %t1469, %SourceSpan* %t1468, %SourceSpan* null
  %t1471 = getelementptr inbounds %Statement, %Statement* %t1463, i32 0, i32 1
  %t1472 = bitcast [16 x i8]* %t1471 to i8*
  %t1473 = getelementptr inbounds i8, i8* %t1472, i64 8
  %t1474 = bitcast i8* %t1473 to %SourceSpan**
  %t1475 = load %SourceSpan*, %SourceSpan** %t1474
  %t1476 = icmp eq i32 %t1462, 20
  %t1477 = select i1 %t1476, %SourceSpan* %t1475, %SourceSpan* %t1470
  %t1478 = getelementptr inbounds %Statement, %Statement* %t1463, i32 0, i32 1
  %t1479 = bitcast [16 x i8]* %t1478 to i8*
  %t1480 = getelementptr inbounds i8, i8* %t1479, i64 8
  %t1481 = bitcast i8* %t1480 to %SourceSpan**
  %t1482 = load %SourceSpan*, %SourceSpan** %t1481
  %t1483 = icmp eq i32 %t1462, 21
  %t1484 = select i1 %t1483, %SourceSpan* %t1482, %SourceSpan* %t1477
  %t1485 = bitcast %SourceSpan* %t1484 to i8*
  %t1486 = call %SymbolCollectionResult @register_symbol(i8* %t1460, i8* %s1461, i8* %t1485, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1486
merge19:
  %t1487 = bitcast { %SymbolEntry*, i64 }* %existing to { %SymbolEntry**, i64 }*
  %t1488 = insertvalue %SymbolCollectionResult undef, { %SymbolEntry**, i64 }* %t1487, 0
  %t1489 = alloca [0 x %Diagnostic*]
  %t1490 = getelementptr [0 x %Diagnostic*], [0 x %Diagnostic*]* %t1489, i32 0, i32 0
  %t1491 = alloca { %Diagnostic**, i64 }
  %t1492 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t1491, i32 0, i32 0
  store %Diagnostic** %t1490, %Diagnostic*** %t1492
  %t1493 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t1491, i32 0, i32 1
  store i64 0, i64* %t1493
  %t1494 = insertvalue %SymbolCollectionResult %t1488, { %Diagnostic**, i64 }* %t1491, 1
  ret %SymbolCollectionResult %t1494
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
  %l23 = alloca %ScopeResult
  %l24 = alloca { i8**, i64 }*
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
  %t220 = bitcast i8* %t219 to %FunctionSignature**
  %t221 = load %FunctionSignature*, %FunctionSignature** %t220
  %t222 = icmp eq i32 %t216, 4
  %t223 = select i1 %t222, %FunctionSignature* %t221, %FunctionSignature* null
  %t224 = getelementptr inbounds %Statement, %Statement* %t217, i32 0, i32 1
  %t225 = bitcast [24 x i8]* %t224 to i8*
  %t226 = bitcast i8* %t225 to %FunctionSignature**
  %t227 = load %FunctionSignature*, %FunctionSignature** %t226
  %t228 = icmp eq i32 %t216, 5
  %t229 = select i1 %t228, %FunctionSignature* %t227, %FunctionSignature* %t223
  %t230 = getelementptr inbounds %Statement, %Statement* %t217, i32 0, i32 1
  %t231 = bitcast [24 x i8]* %t230 to i8*
  %t232 = bitcast i8* %t231 to %FunctionSignature**
  %t233 = load %FunctionSignature*, %FunctionSignature** %t232
  %t234 = icmp eq i32 %t216, 7
  %t235 = select i1 %t234, %FunctionSignature* %t233, %FunctionSignature* %t229
  %t236 = getelementptr %FunctionSignature, %FunctionSignature* %t235, i32 0, i32 0
  %t237 = load i8*, i8** %t236
  %s238 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.238, i32 0, i32 0
  %t239 = extractvalue %Statement %statement, 0
  %t240 = alloca %Statement
  store %Statement %statement, %Statement* %t240
  %t241 = getelementptr inbounds %Statement, %Statement* %t240, i32 0, i32 1
  %t242 = bitcast [24 x i8]* %t241 to i8*
  %t243 = bitcast i8* %t242 to %FunctionSignature**
  %t244 = load %FunctionSignature*, %FunctionSignature** %t243
  %t245 = icmp eq i32 %t239, 4
  %t246 = select i1 %t245, %FunctionSignature* %t244, %FunctionSignature* null
  %t247 = getelementptr inbounds %Statement, %Statement* %t240, i32 0, i32 1
  %t248 = bitcast [24 x i8]* %t247 to i8*
  %t249 = bitcast i8* %t248 to %FunctionSignature**
  %t250 = load %FunctionSignature*, %FunctionSignature** %t249
  %t251 = icmp eq i32 %t239, 5
  %t252 = select i1 %t251, %FunctionSignature* %t250, %FunctionSignature* %t246
  %t253 = getelementptr inbounds %Statement, %Statement* %t240, i32 0, i32 1
  %t254 = bitcast [24 x i8]* %t253 to i8*
  %t255 = bitcast i8* %t254 to %FunctionSignature**
  %t256 = load %FunctionSignature*, %FunctionSignature** %t255
  %t257 = icmp eq i32 %t239, 7
  %t258 = select i1 %t257, %FunctionSignature* %t256, %FunctionSignature* %t252
  %t259 = getelementptr %FunctionSignature, %FunctionSignature* %t258, i32 0, i32 6
  %t260 = load %SourceSpan*, %SourceSpan** %t259
  %t261 = bitcast %SourceSpan* %t260 to i8*
  %t262 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t237, i8* %s238, i8* %t261)
  store %ScopeResult %t262, %ScopeResult* %l0
  %t263 = load %ScopeResult, %ScopeResult* %l0
  %t264 = extractvalue %ScopeResult %t263, 1
  store { %Diagnostic**, i64 }* %t264, { %Diagnostic**, i64 }** %l1
  %t265 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l1
  %t266 = extractvalue %Statement %statement, 0
  %t267 = alloca %Statement
  store %Statement %statement, %Statement* %t267
  %t268 = getelementptr inbounds %Statement, %Statement* %t267, i32 0, i32 1
  %t269 = bitcast [24 x i8]* %t268 to i8*
  %t270 = bitcast i8* %t269 to %FunctionSignature**
  %t271 = load %FunctionSignature*, %FunctionSignature** %t270
  %t272 = icmp eq i32 %t266, 4
  %t273 = select i1 %t272, %FunctionSignature* %t271, %FunctionSignature* null
  %t274 = getelementptr inbounds %Statement, %Statement* %t267, i32 0, i32 1
  %t275 = bitcast [24 x i8]* %t274 to i8*
  %t276 = bitcast i8* %t275 to %FunctionSignature**
  %t277 = load %FunctionSignature*, %FunctionSignature** %t276
  %t278 = icmp eq i32 %t266, 5
  %t279 = select i1 %t278, %FunctionSignature* %t277, %FunctionSignature* %t273
  %t280 = getelementptr inbounds %Statement, %Statement* %t267, i32 0, i32 1
  %t281 = bitcast [24 x i8]* %t280 to i8*
  %t282 = bitcast i8* %t281 to %FunctionSignature**
  %t283 = load %FunctionSignature*, %FunctionSignature** %t282
  %t284 = icmp eq i32 %t266, 7
  %t285 = select i1 %t284, %FunctionSignature* %t283, %FunctionSignature* %t279
  %t286 = load %FunctionSignature, %FunctionSignature* %t285
  %t287 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t286)
  %t288 = bitcast { %Diagnostic**, i64 }* %t265 to { i8**, i64 }*
  %t289 = bitcast { %Diagnostic*, i64 }* %t287 to { i8**, i64 }*
  %t290 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t288, { i8**, i64 }* %t289)
  %t291 = bitcast { i8**, i64 }* %t290 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t291, { %Diagnostic**, i64 }** %l1
  %t292 = extractvalue %Statement %statement, 0
  %t293 = alloca %Statement
  store %Statement %statement, %Statement* %t293
  %t294 = getelementptr inbounds %Statement, %Statement* %t293, i32 0, i32 1
  %t295 = bitcast [24 x i8]* %t294 to i8*
  %t296 = bitcast i8* %t295 to %FunctionSignature**
  %t297 = load %FunctionSignature*, %FunctionSignature** %t296
  %t298 = icmp eq i32 %t292, 4
  %t299 = select i1 %t298, %FunctionSignature* %t297, %FunctionSignature* null
  %t300 = getelementptr inbounds %Statement, %Statement* %t293, i32 0, i32 1
  %t301 = bitcast [24 x i8]* %t300 to i8*
  %t302 = bitcast i8* %t301 to %FunctionSignature**
  %t303 = load %FunctionSignature*, %FunctionSignature** %t302
  %t304 = icmp eq i32 %t292, 5
  %t305 = select i1 %t304, %FunctionSignature* %t303, %FunctionSignature* %t299
  %t306 = getelementptr inbounds %Statement, %Statement* %t293, i32 0, i32 1
  %t307 = bitcast [24 x i8]* %t306 to i8*
  %t308 = bitcast i8* %t307 to %FunctionSignature**
  %t309 = load %FunctionSignature*, %FunctionSignature** %t308
  %t310 = icmp eq i32 %t292, 7
  %t311 = select i1 %t310, %FunctionSignature* %t309, %FunctionSignature* %t305
  %t312 = extractvalue %Statement %statement, 0
  %t313 = alloca %Statement
  store %Statement %statement, %Statement* %t313
  %t314 = getelementptr inbounds %Statement, %Statement* %t313, i32 0, i32 1
  %t315 = bitcast [24 x i8]* %t314 to i8*
  %t316 = getelementptr inbounds i8, i8* %t315, i64 8
  %t317 = bitcast i8* %t316 to %Block**
  %t318 = load %Block*, %Block** %t317
  %t319 = icmp eq i32 %t312, 4
  %t320 = select i1 %t319, %Block* %t318, %Block* null
  %t321 = getelementptr inbounds %Statement, %Statement* %t313, i32 0, i32 1
  %t322 = bitcast [24 x i8]* %t321 to i8*
  %t323 = getelementptr inbounds i8, i8* %t322, i64 8
  %t324 = bitcast i8* %t323 to %Block**
  %t325 = load %Block*, %Block** %t324
  %t326 = icmp eq i32 %t312, 5
  %t327 = select i1 %t326, %Block* %t325, %Block* %t320
  %t328 = getelementptr inbounds %Statement, %Statement* %t313, i32 0, i32 1
  %t329 = bitcast [40 x i8]* %t328 to i8*
  %t330 = getelementptr inbounds i8, i8* %t329, i64 16
  %t331 = bitcast i8* %t330 to %Block**
  %t332 = load %Block*, %Block** %t331
  %t333 = icmp eq i32 %t312, 6
  %t334 = select i1 %t333, %Block* %t332, %Block* %t327
  %t335 = getelementptr inbounds %Statement, %Statement* %t313, i32 0, i32 1
  %t336 = bitcast [24 x i8]* %t335 to i8*
  %t337 = getelementptr inbounds i8, i8* %t336, i64 8
  %t338 = bitcast i8* %t337 to %Block**
  %t339 = load %Block*, %Block** %t338
  %t340 = icmp eq i32 %t312, 7
  %t341 = select i1 %t340, %Block* %t339, %Block* %t334
  %t342 = getelementptr inbounds %Statement, %Statement* %t313, i32 0, i32 1
  %t343 = bitcast [40 x i8]* %t342 to i8*
  %t344 = getelementptr inbounds i8, i8* %t343, i64 24
  %t345 = bitcast i8* %t344 to %Block**
  %t346 = load %Block*, %Block** %t345
  %t347 = icmp eq i32 %t312, 12
  %t348 = select i1 %t347, %Block* %t346, %Block* %t341
  %t349 = getelementptr inbounds %Statement, %Statement* %t313, i32 0, i32 1
  %t350 = bitcast [24 x i8]* %t349 to i8*
  %t351 = getelementptr inbounds i8, i8* %t350, i64 8
  %t352 = bitcast i8* %t351 to %Block**
  %t353 = load %Block*, %Block** %t352
  %t354 = icmp eq i32 %t312, 13
  %t355 = select i1 %t354, %Block* %t353, %Block* %t348
  %t356 = getelementptr inbounds %Statement, %Statement* %t313, i32 0, i32 1
  %t357 = bitcast [24 x i8]* %t356 to i8*
  %t358 = getelementptr inbounds i8, i8* %t357, i64 8
  %t359 = bitcast i8* %t358 to %Block**
  %t360 = load %Block*, %Block** %t359
  %t361 = icmp eq i32 %t312, 14
  %t362 = select i1 %t361, %Block* %t360, %Block* %t355
  %t363 = getelementptr inbounds %Statement, %Statement* %t313, i32 0, i32 1
  %t364 = bitcast [16 x i8]* %t363 to i8*
  %t365 = bitcast i8* %t364 to %Block**
  %t366 = load %Block*, %Block** %t365
  %t367 = icmp eq i32 %t312, 15
  %t368 = select i1 %t367, %Block* %t366, %Block* %t362
  %t369 = load %FunctionSignature, %FunctionSignature* %t311
  %t370 = load %Block, %Block* %t368
  %t371 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t369, %Block %t370, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t371, { %Diagnostic*, i64 }** %l2
  %t372 = load %ScopeResult, %ScopeResult* %l0
  %t373 = extractvalue %ScopeResult %t372, 0
  %t374 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t373, 0
  %t375 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l1
  %t376 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l2
  %t377 = bitcast { %Diagnostic**, i64 }* %t375 to { i8**, i64 }*
  %t378 = bitcast { %Diagnostic*, i64 }* %t376 to { i8**, i64 }*
  %t379 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t377, { i8**, i64 }* %t378)
  %t380 = bitcast { i8**, i64 }* %t379 to { %Diagnostic**, i64 }*
  %t381 = insertvalue %ScopeResult %t374, { %Diagnostic**, i64 }* %t380, 1
  ret %ScopeResult %t381
merge3:
  %t382 = extractvalue %Statement %statement, 0
  %t383 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t384 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t385 = icmp eq i32 %t382, 0
  %t386 = select i1 %t385, i8* %t384, i8* %t383
  %t387 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t388 = icmp eq i32 %t382, 1
  %t389 = select i1 %t388, i8* %t387, i8* %t386
  %t390 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t391 = icmp eq i32 %t382, 2
  %t392 = select i1 %t391, i8* %t390, i8* %t389
  %t393 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t394 = icmp eq i32 %t382, 3
  %t395 = select i1 %t394, i8* %t393, i8* %t392
  %t396 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t397 = icmp eq i32 %t382, 4
  %t398 = select i1 %t397, i8* %t396, i8* %t395
  %t399 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t400 = icmp eq i32 %t382, 5
  %t401 = select i1 %t400, i8* %t399, i8* %t398
  %t402 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t403 = icmp eq i32 %t382, 6
  %t404 = select i1 %t403, i8* %t402, i8* %t401
  %t405 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t406 = icmp eq i32 %t382, 7
  %t407 = select i1 %t406, i8* %t405, i8* %t404
  %t408 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t409 = icmp eq i32 %t382, 8
  %t410 = select i1 %t409, i8* %t408, i8* %t407
  %t411 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t412 = icmp eq i32 %t382, 9
  %t413 = select i1 %t412, i8* %t411, i8* %t410
  %t414 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t415 = icmp eq i32 %t382, 10
  %t416 = select i1 %t415, i8* %t414, i8* %t413
  %t417 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t418 = icmp eq i32 %t382, 11
  %t419 = select i1 %t418, i8* %t417, i8* %t416
  %t420 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t421 = icmp eq i32 %t382, 12
  %t422 = select i1 %t421, i8* %t420, i8* %t419
  %t423 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t424 = icmp eq i32 %t382, 13
  %t425 = select i1 %t424, i8* %t423, i8* %t422
  %t426 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t427 = icmp eq i32 %t382, 14
  %t428 = select i1 %t427, i8* %t426, i8* %t425
  %t429 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t430 = icmp eq i32 %t382, 15
  %t431 = select i1 %t430, i8* %t429, i8* %t428
  %t432 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t433 = icmp eq i32 %t382, 16
  %t434 = select i1 %t433, i8* %t432, i8* %t431
  %t435 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t436 = icmp eq i32 %t382, 17
  %t437 = select i1 %t436, i8* %t435, i8* %t434
  %t438 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t439 = icmp eq i32 %t382, 18
  %t440 = select i1 %t439, i8* %t438, i8* %t437
  %t441 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t442 = icmp eq i32 %t382, 19
  %t443 = select i1 %t442, i8* %t441, i8* %t440
  %t444 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t445 = icmp eq i32 %t382, 20
  %t446 = select i1 %t445, i8* %t444, i8* %t443
  %t447 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t448 = icmp eq i32 %t382, 21
  %t449 = select i1 %t448, i8* %t447, i8* %t446
  %t450 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t451 = icmp eq i32 %t382, 22
  %t452 = select i1 %t451, i8* %t450, i8* %t449
  %s453 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.453, i32 0, i32 0
  %t454 = icmp eq i8* %t452, %s453
  br i1 %t454, label %then4, label %merge5
then4:
  %t455 = extractvalue %Statement %statement, 0
  %t456 = alloca %Statement
  store %Statement %statement, %Statement* %t456
  %t457 = getelementptr inbounds %Statement, %Statement* %t456, i32 0, i32 1
  %t458 = bitcast [48 x i8]* %t457 to i8*
  %t459 = bitcast i8* %t458 to i8**
  %t460 = load i8*, i8** %t459
  %t461 = icmp eq i32 %t455, 2
  %t462 = select i1 %t461, i8* %t460, i8* null
  %t463 = getelementptr inbounds %Statement, %Statement* %t456, i32 0, i32 1
  %t464 = bitcast [48 x i8]* %t463 to i8*
  %t465 = bitcast i8* %t464 to i8**
  %t466 = load i8*, i8** %t465
  %t467 = icmp eq i32 %t455, 3
  %t468 = select i1 %t467, i8* %t466, i8* %t462
  %t469 = getelementptr inbounds %Statement, %Statement* %t456, i32 0, i32 1
  %t470 = bitcast [40 x i8]* %t469 to i8*
  %t471 = bitcast i8* %t470 to i8**
  %t472 = load i8*, i8** %t471
  %t473 = icmp eq i32 %t455, 6
  %t474 = select i1 %t473, i8* %t472, i8* %t468
  %t475 = getelementptr inbounds %Statement, %Statement* %t456, i32 0, i32 1
  %t476 = bitcast [56 x i8]* %t475 to i8*
  %t477 = bitcast i8* %t476 to i8**
  %t478 = load i8*, i8** %t477
  %t479 = icmp eq i32 %t455, 8
  %t480 = select i1 %t479, i8* %t478, i8* %t474
  %t481 = getelementptr inbounds %Statement, %Statement* %t456, i32 0, i32 1
  %t482 = bitcast [40 x i8]* %t481 to i8*
  %t483 = bitcast i8* %t482 to i8**
  %t484 = load i8*, i8** %t483
  %t485 = icmp eq i32 %t455, 9
  %t486 = select i1 %t485, i8* %t484, i8* %t480
  %t487 = getelementptr inbounds %Statement, %Statement* %t456, i32 0, i32 1
  %t488 = bitcast [40 x i8]* %t487 to i8*
  %t489 = bitcast i8* %t488 to i8**
  %t490 = load i8*, i8** %t489
  %t491 = icmp eq i32 %t455, 10
  %t492 = select i1 %t491, i8* %t490, i8* %t486
  %t493 = getelementptr inbounds %Statement, %Statement* %t456, i32 0, i32 1
  %t494 = bitcast [40 x i8]* %t493 to i8*
  %t495 = bitcast i8* %t494 to i8**
  %t496 = load i8*, i8** %t495
  %t497 = icmp eq i32 %t455, 11
  %t498 = select i1 %t497, i8* %t496, i8* %t492
  %s499 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.499, i32 0, i32 0
  %t500 = extractvalue %Statement %statement, 0
  %t501 = alloca %Statement
  store %Statement %statement, %Statement* %t501
  %t502 = getelementptr inbounds %Statement, %Statement* %t501, i32 0, i32 1
  %t503 = bitcast [48 x i8]* %t502 to i8*
  %t504 = getelementptr inbounds i8, i8* %t503, i64 8
  %t505 = bitcast i8* %t504 to %SourceSpan**
  %t506 = load %SourceSpan*, %SourceSpan** %t505
  %t507 = icmp eq i32 %t500, 3
  %t508 = select i1 %t507, %SourceSpan* %t506, %SourceSpan* null
  %t509 = getelementptr inbounds %Statement, %Statement* %t501, i32 0, i32 1
  %t510 = bitcast [40 x i8]* %t509 to i8*
  %t511 = getelementptr inbounds i8, i8* %t510, i64 8
  %t512 = bitcast i8* %t511 to %SourceSpan**
  %t513 = load %SourceSpan*, %SourceSpan** %t512
  %t514 = icmp eq i32 %t500, 6
  %t515 = select i1 %t514, %SourceSpan* %t513, %SourceSpan* %t508
  %t516 = getelementptr inbounds %Statement, %Statement* %t501, i32 0, i32 1
  %t517 = bitcast [56 x i8]* %t516 to i8*
  %t518 = getelementptr inbounds i8, i8* %t517, i64 8
  %t519 = bitcast i8* %t518 to %SourceSpan**
  %t520 = load %SourceSpan*, %SourceSpan** %t519
  %t521 = icmp eq i32 %t500, 8
  %t522 = select i1 %t521, %SourceSpan* %t520, %SourceSpan* %t515
  %t523 = getelementptr inbounds %Statement, %Statement* %t501, i32 0, i32 1
  %t524 = bitcast [40 x i8]* %t523 to i8*
  %t525 = getelementptr inbounds i8, i8* %t524, i64 8
  %t526 = bitcast i8* %t525 to %SourceSpan**
  %t527 = load %SourceSpan*, %SourceSpan** %t526
  %t528 = icmp eq i32 %t500, 9
  %t529 = select i1 %t528, %SourceSpan* %t527, %SourceSpan* %t522
  %t530 = getelementptr inbounds %Statement, %Statement* %t501, i32 0, i32 1
  %t531 = bitcast [40 x i8]* %t530 to i8*
  %t532 = getelementptr inbounds i8, i8* %t531, i64 8
  %t533 = bitcast i8* %t532 to %SourceSpan**
  %t534 = load %SourceSpan*, %SourceSpan** %t533
  %t535 = icmp eq i32 %t500, 10
  %t536 = select i1 %t535, %SourceSpan* %t534, %SourceSpan* %t529
  %t537 = getelementptr inbounds %Statement, %Statement* %t501, i32 0, i32 1
  %t538 = bitcast [40 x i8]* %t537 to i8*
  %t539 = getelementptr inbounds i8, i8* %t538, i64 8
  %t540 = bitcast i8* %t539 to %SourceSpan**
  %t541 = load %SourceSpan*, %SourceSpan** %t540
  %t542 = icmp eq i32 %t500, 11
  %t543 = select i1 %t542, %SourceSpan* %t541, %SourceSpan* %t536
  %t544 = bitcast %SourceSpan* %t543 to i8*
  %t545 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t498, i8* %s499, i8* %t544)
  store %ScopeResult %t545, %ScopeResult* %l3
  %t546 = load %ScopeResult, %ScopeResult* %l3
  %t547 = extractvalue %ScopeResult %t546, 1
  store { %Diagnostic**, i64 }* %t547, { %Diagnostic**, i64 }** %l4
  %t548 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t549 = extractvalue %Statement %statement, 0
  %t550 = alloca %Statement
  store %Statement %statement, %Statement* %t550
  %t551 = getelementptr inbounds %Statement, %Statement* %t550, i32 0, i32 1
  %t552 = bitcast [56 x i8]* %t551 to i8*
  %t553 = getelementptr inbounds i8, i8* %t552, i64 16
  %t554 = bitcast i8* %t553 to { %TypeParameter**, i64 }**
  %t555 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t554
  %t556 = icmp eq i32 %t549, 8
  %t557 = select i1 %t556, { %TypeParameter**, i64 }* %t555, { %TypeParameter**, i64 }* null
  %t558 = getelementptr inbounds %Statement, %Statement* %t550, i32 0, i32 1
  %t559 = bitcast [40 x i8]* %t558 to i8*
  %t560 = getelementptr inbounds i8, i8* %t559, i64 16
  %t561 = bitcast i8* %t560 to { %TypeParameter**, i64 }**
  %t562 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t561
  %t563 = icmp eq i32 %t549, 9
  %t564 = select i1 %t563, { %TypeParameter**, i64 }* %t562, { %TypeParameter**, i64 }* %t557
  %t565 = getelementptr inbounds %Statement, %Statement* %t550, i32 0, i32 1
  %t566 = bitcast [40 x i8]* %t565 to i8*
  %t567 = getelementptr inbounds i8, i8* %t566, i64 16
  %t568 = bitcast i8* %t567 to { %TypeParameter**, i64 }**
  %t569 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t568
  %t570 = icmp eq i32 %t549, 10
  %t571 = select i1 %t570, { %TypeParameter**, i64 }* %t569, { %TypeParameter**, i64 }* %t564
  %t572 = getelementptr inbounds %Statement, %Statement* %t550, i32 0, i32 1
  %t573 = bitcast [40 x i8]* %t572 to i8*
  %t574 = getelementptr inbounds i8, i8* %t573, i64 16
  %t575 = bitcast i8* %t574 to { %TypeParameter**, i64 }**
  %t576 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t575
  %t577 = icmp eq i32 %t549, 11
  %t578 = select i1 %t577, { %TypeParameter**, i64 }* %t576, { %TypeParameter**, i64 }* %t571
  %t579 = bitcast { %TypeParameter**, i64 }* %t578 to { %TypeParameter*, i64 }*
  %t580 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t579)
  %t581 = bitcast { %Diagnostic**, i64 }* %t548 to { i8**, i64 }*
  %t582 = bitcast { %Diagnostic*, i64 }* %t580 to { i8**, i64 }*
  %t583 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t581, { i8**, i64 }* %t582)
  %t584 = bitcast { i8**, i64 }* %t583 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t584, { %Diagnostic**, i64 }** %l4
  %t585 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t586 = extractvalue %Statement %statement, 0
  %t587 = alloca %Statement
  store %Statement %statement, %Statement* %t587
  %t588 = getelementptr inbounds %Statement, %Statement* %t587, i32 0, i32 1
  %t589 = bitcast [56 x i8]* %t588 to i8*
  %t590 = getelementptr inbounds i8, i8* %t589, i64 32
  %t591 = bitcast i8* %t590 to { %FieldDeclaration**, i64 }**
  %t592 = load { %FieldDeclaration**, i64 }*, { %FieldDeclaration**, i64 }** %t591
  %t593 = icmp eq i32 %t586, 8
  %t594 = select i1 %t593, { %FieldDeclaration**, i64 }* %t592, { %FieldDeclaration**, i64 }* null
  %t595 = bitcast { %FieldDeclaration**, i64 }* %t594 to { %FieldDeclaration*, i64 }*
  %t596 = call { %Diagnostic*, i64 }* @check_struct_fields({ %FieldDeclaration*, i64 }* %t595)
  %t597 = bitcast { %Diagnostic**, i64 }* %t585 to { i8**, i64 }*
  %t598 = bitcast { %Diagnostic*, i64 }* %t596 to { i8**, i64 }*
  %t599 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t597, { i8**, i64 }* %t598)
  %t600 = bitcast { i8**, i64 }* %t599 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t600, { %Diagnostic**, i64 }** %l4
  %t601 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t602 = extractvalue %Statement %statement, 0
  %t603 = alloca %Statement
  store %Statement %statement, %Statement* %t603
  %t604 = getelementptr inbounds %Statement, %Statement* %t603, i32 0, i32 1
  %t605 = bitcast [56 x i8]* %t604 to i8*
  %t606 = getelementptr inbounds i8, i8* %t605, i64 40
  %t607 = bitcast i8* %t606 to { %MethodDeclaration**, i64 }**
  %t608 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t607
  %t609 = icmp eq i32 %t602, 8
  %t610 = select i1 %t609, { %MethodDeclaration**, i64 }* %t608, { %MethodDeclaration**, i64 }* null
  %t611 = bitcast { %MethodDeclaration**, i64 }* %t610 to { %MethodDeclaration*, i64 }*
  %t612 = call { %Diagnostic*, i64 }* @check_struct_methods({ %MethodDeclaration*, i64 }* %t611)
  %t613 = bitcast { %Diagnostic**, i64 }* %t601 to { i8**, i64 }*
  %t614 = bitcast { %Diagnostic*, i64 }* %t612 to { i8**, i64 }*
  %t615 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t613, { i8**, i64 }* %t614)
  %t616 = bitcast { i8**, i64 }* %t615 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t616, { %Diagnostic**, i64 }** %l4
  %t617 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t618 = call { %Diagnostic*, i64 }* @check_struct_implements_interfaces(%Statement %statement, { %Statement*, i64 }* %interfaces)
  %t619 = bitcast { %Diagnostic**, i64 }* %t617 to { i8**, i64 }*
  %t620 = bitcast { %Diagnostic*, i64 }* %t618 to { i8**, i64 }*
  %t621 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t619, { i8**, i64 }* %t620)
  %t622 = bitcast { i8**, i64 }* %t621 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t622, { %Diagnostic**, i64 }** %l4
  %t623 = sitofp i64 0 to double
  store double %t623, double* %l5
  %t624 = load %ScopeResult, %ScopeResult* %l3
  %t625 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t626 = load double, double* %l5
  br label %loop.header6
loop.header6:
  %t680 = phi { %Diagnostic**, i64 }* [ %t625, %then4 ], [ %t678, %loop.latch8 ]
  %t681 = phi double [ %t626, %then4 ], [ %t679, %loop.latch8 ]
  store { %Diagnostic**, i64 }* %t680, { %Diagnostic**, i64 }** %l4
  store double %t681, double* %l5
  br label %loop.body7
loop.body7:
  %t627 = load double, double* %l5
  %t628 = extractvalue %Statement %statement, 0
  %t629 = alloca %Statement
  store %Statement %statement, %Statement* %t629
  %t630 = getelementptr inbounds %Statement, %Statement* %t629, i32 0, i32 1
  %t631 = bitcast [56 x i8]* %t630 to i8*
  %t632 = getelementptr inbounds i8, i8* %t631, i64 40
  %t633 = bitcast i8* %t632 to { %MethodDeclaration**, i64 }**
  %t634 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t633
  %t635 = icmp eq i32 %t628, 8
  %t636 = select i1 %t635, { %MethodDeclaration**, i64 }* %t634, { %MethodDeclaration**, i64 }* null
  %t637 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t636
  %t638 = extractvalue { %MethodDeclaration**, i64 } %t637, 1
  %t639 = sitofp i64 %t638 to double
  %t640 = fcmp oge double %t627, %t639
  %t641 = load %ScopeResult, %ScopeResult* %l3
  %t642 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t643 = load double, double* %l5
  br i1 %t640, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t644 = extractvalue %Statement %statement, 0
  %t645 = alloca %Statement
  store %Statement %statement, %Statement* %t645
  %t646 = getelementptr inbounds %Statement, %Statement* %t645, i32 0, i32 1
  %t647 = bitcast [56 x i8]* %t646 to i8*
  %t648 = getelementptr inbounds i8, i8* %t647, i64 40
  %t649 = bitcast i8* %t648 to { %MethodDeclaration**, i64 }**
  %t650 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t649
  %t651 = icmp eq i32 %t644, 8
  %t652 = select i1 %t651, { %MethodDeclaration**, i64 }* %t650, { %MethodDeclaration**, i64 }* null
  %t653 = load double, double* %l5
  %t654 = fptosi double %t653 to i64
  %t655 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t652
  %t656 = extractvalue { %MethodDeclaration**, i64 } %t655, 0
  %t657 = extractvalue { %MethodDeclaration**, i64 } %t655, 1
  %t658 = icmp uge i64 %t654, %t657
  ; bounds check: %t658 (if true, out of bounds)
  %t659 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t656, i64 %t654
  %t660 = load %MethodDeclaration*, %MethodDeclaration** %t659
  store %MethodDeclaration* %t660, %MethodDeclaration** %l6
  %t661 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t662 = load %MethodDeclaration*, %MethodDeclaration** %l6
  %t663 = getelementptr %MethodDeclaration, %MethodDeclaration* %t662, i32 0, i32 0
  %t664 = load %FunctionSignature*, %FunctionSignature** %t663
  %t665 = load %MethodDeclaration*, %MethodDeclaration** %l6
  %t666 = getelementptr %MethodDeclaration, %MethodDeclaration* %t665, i32 0, i32 1
  %t667 = load %Block*, %Block** %t666
  %t668 = load %FunctionSignature, %FunctionSignature* %t664
  %t669 = load %Block, %Block* %t667
  %t670 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t668, %Block %t669, { %Statement*, i64 }* %interfaces)
  %t671 = bitcast { %Diagnostic**, i64 }* %t661 to { i8**, i64 }*
  %t672 = bitcast { %Diagnostic*, i64 }* %t670 to { i8**, i64 }*
  %t673 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t671, { i8**, i64 }* %t672)
  %t674 = bitcast { i8**, i64 }* %t673 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t674, { %Diagnostic**, i64 }** %l4
  %t675 = load double, double* %l5
  %t676 = sitofp i64 1 to double
  %t677 = fadd double %t675, %t676
  store double %t677, double* %l5
  br label %loop.latch8
loop.latch8:
  %t678 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t679 = load double, double* %l5
  br label %loop.header6
afterloop9:
  %t682 = load %ScopeResult, %ScopeResult* %l3
  %t683 = extractvalue %ScopeResult %t682, 0
  %t684 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t683, 0
  %t685 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t686 = insertvalue %ScopeResult %t684, { %Diagnostic**, i64 }* %t685, 1
  ret %ScopeResult %t686
merge5:
  %t687 = extractvalue %Statement %statement, 0
  %t688 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t689 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t690 = icmp eq i32 %t687, 0
  %t691 = select i1 %t690, i8* %t689, i8* %t688
  %t692 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t693 = icmp eq i32 %t687, 1
  %t694 = select i1 %t693, i8* %t692, i8* %t691
  %t695 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t696 = icmp eq i32 %t687, 2
  %t697 = select i1 %t696, i8* %t695, i8* %t694
  %t698 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t699 = icmp eq i32 %t687, 3
  %t700 = select i1 %t699, i8* %t698, i8* %t697
  %t701 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t702 = icmp eq i32 %t687, 4
  %t703 = select i1 %t702, i8* %t701, i8* %t700
  %t704 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t705 = icmp eq i32 %t687, 5
  %t706 = select i1 %t705, i8* %t704, i8* %t703
  %t707 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t708 = icmp eq i32 %t687, 6
  %t709 = select i1 %t708, i8* %t707, i8* %t706
  %t710 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t711 = icmp eq i32 %t687, 7
  %t712 = select i1 %t711, i8* %t710, i8* %t709
  %t713 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t714 = icmp eq i32 %t687, 8
  %t715 = select i1 %t714, i8* %t713, i8* %t712
  %t716 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t717 = icmp eq i32 %t687, 9
  %t718 = select i1 %t717, i8* %t716, i8* %t715
  %t719 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t720 = icmp eq i32 %t687, 10
  %t721 = select i1 %t720, i8* %t719, i8* %t718
  %t722 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t723 = icmp eq i32 %t687, 11
  %t724 = select i1 %t723, i8* %t722, i8* %t721
  %t725 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t726 = icmp eq i32 %t687, 12
  %t727 = select i1 %t726, i8* %t725, i8* %t724
  %t728 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t729 = icmp eq i32 %t687, 13
  %t730 = select i1 %t729, i8* %t728, i8* %t727
  %t731 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t732 = icmp eq i32 %t687, 14
  %t733 = select i1 %t732, i8* %t731, i8* %t730
  %t734 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t735 = icmp eq i32 %t687, 15
  %t736 = select i1 %t735, i8* %t734, i8* %t733
  %t737 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t738 = icmp eq i32 %t687, 16
  %t739 = select i1 %t738, i8* %t737, i8* %t736
  %t740 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t741 = icmp eq i32 %t687, 17
  %t742 = select i1 %t741, i8* %t740, i8* %t739
  %t743 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t744 = icmp eq i32 %t687, 18
  %t745 = select i1 %t744, i8* %t743, i8* %t742
  %t746 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t747 = icmp eq i32 %t687, 19
  %t748 = select i1 %t747, i8* %t746, i8* %t745
  %t749 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t750 = icmp eq i32 %t687, 20
  %t751 = select i1 %t750, i8* %t749, i8* %t748
  %t752 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t753 = icmp eq i32 %t687, 21
  %t754 = select i1 %t753, i8* %t752, i8* %t751
  %t755 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t756 = icmp eq i32 %t687, 22
  %t757 = select i1 %t756, i8* %t755, i8* %t754
  %s758 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.758, i32 0, i32 0
  %t759 = icmp eq i8* %t757, %s758
  br i1 %t759, label %then12, label %merge13
then12:
  %t760 = extractvalue %Statement %statement, 0
  %t761 = alloca %Statement
  store %Statement %statement, %Statement* %t761
  %t762 = getelementptr inbounds %Statement, %Statement* %t761, i32 0, i32 1
  %t763 = bitcast [48 x i8]* %t762 to i8*
  %t764 = bitcast i8* %t763 to i8**
  %t765 = load i8*, i8** %t764
  %t766 = icmp eq i32 %t760, 2
  %t767 = select i1 %t766, i8* %t765, i8* null
  %t768 = getelementptr inbounds %Statement, %Statement* %t761, i32 0, i32 1
  %t769 = bitcast [48 x i8]* %t768 to i8*
  %t770 = bitcast i8* %t769 to i8**
  %t771 = load i8*, i8** %t770
  %t772 = icmp eq i32 %t760, 3
  %t773 = select i1 %t772, i8* %t771, i8* %t767
  %t774 = getelementptr inbounds %Statement, %Statement* %t761, i32 0, i32 1
  %t775 = bitcast [40 x i8]* %t774 to i8*
  %t776 = bitcast i8* %t775 to i8**
  %t777 = load i8*, i8** %t776
  %t778 = icmp eq i32 %t760, 6
  %t779 = select i1 %t778, i8* %t777, i8* %t773
  %t780 = getelementptr inbounds %Statement, %Statement* %t761, i32 0, i32 1
  %t781 = bitcast [56 x i8]* %t780 to i8*
  %t782 = bitcast i8* %t781 to i8**
  %t783 = load i8*, i8** %t782
  %t784 = icmp eq i32 %t760, 8
  %t785 = select i1 %t784, i8* %t783, i8* %t779
  %t786 = getelementptr inbounds %Statement, %Statement* %t761, i32 0, i32 1
  %t787 = bitcast [40 x i8]* %t786 to i8*
  %t788 = bitcast i8* %t787 to i8**
  %t789 = load i8*, i8** %t788
  %t790 = icmp eq i32 %t760, 9
  %t791 = select i1 %t790, i8* %t789, i8* %t785
  %t792 = getelementptr inbounds %Statement, %Statement* %t761, i32 0, i32 1
  %t793 = bitcast [40 x i8]* %t792 to i8*
  %t794 = bitcast i8* %t793 to i8**
  %t795 = load i8*, i8** %t794
  %t796 = icmp eq i32 %t760, 10
  %t797 = select i1 %t796, i8* %t795, i8* %t791
  %t798 = getelementptr inbounds %Statement, %Statement* %t761, i32 0, i32 1
  %t799 = bitcast [40 x i8]* %t798 to i8*
  %t800 = bitcast i8* %t799 to i8**
  %t801 = load i8*, i8** %t800
  %t802 = icmp eq i32 %t760, 11
  %t803 = select i1 %t802, i8* %t801, i8* %t797
  %s804 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.804, i32 0, i32 0
  %t805 = extractvalue %Statement %statement, 0
  %t806 = alloca %Statement
  store %Statement %statement, %Statement* %t806
  %t807 = getelementptr inbounds %Statement, %Statement* %t806, i32 0, i32 1
  %t808 = bitcast [48 x i8]* %t807 to i8*
  %t809 = getelementptr inbounds i8, i8* %t808, i64 8
  %t810 = bitcast i8* %t809 to %SourceSpan**
  %t811 = load %SourceSpan*, %SourceSpan** %t810
  %t812 = icmp eq i32 %t805, 3
  %t813 = select i1 %t812, %SourceSpan* %t811, %SourceSpan* null
  %t814 = getelementptr inbounds %Statement, %Statement* %t806, i32 0, i32 1
  %t815 = bitcast [40 x i8]* %t814 to i8*
  %t816 = getelementptr inbounds i8, i8* %t815, i64 8
  %t817 = bitcast i8* %t816 to %SourceSpan**
  %t818 = load %SourceSpan*, %SourceSpan** %t817
  %t819 = icmp eq i32 %t805, 6
  %t820 = select i1 %t819, %SourceSpan* %t818, %SourceSpan* %t813
  %t821 = getelementptr inbounds %Statement, %Statement* %t806, i32 0, i32 1
  %t822 = bitcast [56 x i8]* %t821 to i8*
  %t823 = getelementptr inbounds i8, i8* %t822, i64 8
  %t824 = bitcast i8* %t823 to %SourceSpan**
  %t825 = load %SourceSpan*, %SourceSpan** %t824
  %t826 = icmp eq i32 %t805, 8
  %t827 = select i1 %t826, %SourceSpan* %t825, %SourceSpan* %t820
  %t828 = getelementptr inbounds %Statement, %Statement* %t806, i32 0, i32 1
  %t829 = bitcast [40 x i8]* %t828 to i8*
  %t830 = getelementptr inbounds i8, i8* %t829, i64 8
  %t831 = bitcast i8* %t830 to %SourceSpan**
  %t832 = load %SourceSpan*, %SourceSpan** %t831
  %t833 = icmp eq i32 %t805, 9
  %t834 = select i1 %t833, %SourceSpan* %t832, %SourceSpan* %t827
  %t835 = getelementptr inbounds %Statement, %Statement* %t806, i32 0, i32 1
  %t836 = bitcast [40 x i8]* %t835 to i8*
  %t837 = getelementptr inbounds i8, i8* %t836, i64 8
  %t838 = bitcast i8* %t837 to %SourceSpan**
  %t839 = load %SourceSpan*, %SourceSpan** %t838
  %t840 = icmp eq i32 %t805, 10
  %t841 = select i1 %t840, %SourceSpan* %t839, %SourceSpan* %t834
  %t842 = getelementptr inbounds %Statement, %Statement* %t806, i32 0, i32 1
  %t843 = bitcast [40 x i8]* %t842 to i8*
  %t844 = getelementptr inbounds i8, i8* %t843, i64 8
  %t845 = bitcast i8* %t844 to %SourceSpan**
  %t846 = load %SourceSpan*, %SourceSpan** %t845
  %t847 = icmp eq i32 %t805, 11
  %t848 = select i1 %t847, %SourceSpan* %t846, %SourceSpan* %t841
  %t849 = bitcast %SourceSpan* %t848 to i8*
  %t850 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t803, i8* %s804, i8* %t849)
  store %ScopeResult %t850, %ScopeResult* %l7
  %t851 = load %ScopeResult, %ScopeResult* %l7
  %t852 = extractvalue %ScopeResult %t851, 1
  store { %Diagnostic**, i64 }* %t852, { %Diagnostic**, i64 }** %l8
  %t853 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l8
  %t854 = extractvalue %Statement %statement, 0
  %t855 = alloca %Statement
  store %Statement %statement, %Statement* %t855
  %t856 = getelementptr inbounds %Statement, %Statement* %t855, i32 0, i32 1
  %t857 = bitcast [56 x i8]* %t856 to i8*
  %t858 = getelementptr inbounds i8, i8* %t857, i64 16
  %t859 = bitcast i8* %t858 to { %TypeParameter**, i64 }**
  %t860 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t859
  %t861 = icmp eq i32 %t854, 8
  %t862 = select i1 %t861, { %TypeParameter**, i64 }* %t860, { %TypeParameter**, i64 }* null
  %t863 = getelementptr inbounds %Statement, %Statement* %t855, i32 0, i32 1
  %t864 = bitcast [40 x i8]* %t863 to i8*
  %t865 = getelementptr inbounds i8, i8* %t864, i64 16
  %t866 = bitcast i8* %t865 to { %TypeParameter**, i64 }**
  %t867 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t866
  %t868 = icmp eq i32 %t854, 9
  %t869 = select i1 %t868, { %TypeParameter**, i64 }* %t867, { %TypeParameter**, i64 }* %t862
  %t870 = getelementptr inbounds %Statement, %Statement* %t855, i32 0, i32 1
  %t871 = bitcast [40 x i8]* %t870 to i8*
  %t872 = getelementptr inbounds i8, i8* %t871, i64 16
  %t873 = bitcast i8* %t872 to { %TypeParameter**, i64 }**
  %t874 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t873
  %t875 = icmp eq i32 %t854, 10
  %t876 = select i1 %t875, { %TypeParameter**, i64 }* %t874, { %TypeParameter**, i64 }* %t869
  %t877 = getelementptr inbounds %Statement, %Statement* %t855, i32 0, i32 1
  %t878 = bitcast [40 x i8]* %t877 to i8*
  %t879 = getelementptr inbounds i8, i8* %t878, i64 16
  %t880 = bitcast i8* %t879 to { %TypeParameter**, i64 }**
  %t881 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t880
  %t882 = icmp eq i32 %t854, 11
  %t883 = select i1 %t882, { %TypeParameter**, i64 }* %t881, { %TypeParameter**, i64 }* %t876
  %t884 = bitcast { %TypeParameter**, i64 }* %t883 to { %TypeParameter*, i64 }*
  %t885 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t884)
  %t886 = bitcast { %Diagnostic**, i64 }* %t853 to { i8**, i64 }*
  %t887 = bitcast { %Diagnostic*, i64 }* %t885 to { i8**, i64 }*
  %t888 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t886, { i8**, i64 }* %t887)
  %t889 = bitcast { i8**, i64 }* %t888 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t889, { %Diagnostic**, i64 }** %l8
  %t890 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l8
  %t891 = extractvalue %Statement %statement, 0
  %t892 = alloca %Statement
  store %Statement %statement, %Statement* %t892
  %t893 = getelementptr inbounds %Statement, %Statement* %t892, i32 0, i32 1
  %t894 = bitcast [40 x i8]* %t893 to i8*
  %t895 = getelementptr inbounds i8, i8* %t894, i64 24
  %t896 = bitcast i8* %t895 to { %EnumVariant**, i64 }**
  %t897 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t896
  %t898 = icmp eq i32 %t891, 11
  %t899 = select i1 %t898, { %EnumVariant**, i64 }* %t897, { %EnumVariant**, i64 }* null
  %t900 = bitcast { %EnumVariant**, i64 }* %t899 to { %EnumVariant*, i64 }*
  %t901 = call { %Diagnostic*, i64 }* @check_enum_variants({ %EnumVariant*, i64 }* %t900)
  %t902 = bitcast { %Diagnostic**, i64 }* %t890 to { i8**, i64 }*
  %t903 = bitcast { %Diagnostic*, i64 }* %t901 to { i8**, i64 }*
  %t904 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t902, { i8**, i64 }* %t903)
  %t905 = bitcast { i8**, i64 }* %t904 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t905, { %Diagnostic**, i64 }** %l8
  %t906 = load %ScopeResult, %ScopeResult* %l7
  %t907 = extractvalue %ScopeResult %t906, 0
  %t908 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t907, 0
  %t909 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l8
  %t910 = insertvalue %ScopeResult %t908, { %Diagnostic**, i64 }* %t909, 1
  ret %ScopeResult %t910
merge13:
  %t911 = extractvalue %Statement %statement, 0
  %t912 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t913 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t914 = icmp eq i32 %t911, 0
  %t915 = select i1 %t914, i8* %t913, i8* %t912
  %t916 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t917 = icmp eq i32 %t911, 1
  %t918 = select i1 %t917, i8* %t916, i8* %t915
  %t919 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t920 = icmp eq i32 %t911, 2
  %t921 = select i1 %t920, i8* %t919, i8* %t918
  %t922 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t923 = icmp eq i32 %t911, 3
  %t924 = select i1 %t923, i8* %t922, i8* %t921
  %t925 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t926 = icmp eq i32 %t911, 4
  %t927 = select i1 %t926, i8* %t925, i8* %t924
  %t928 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t929 = icmp eq i32 %t911, 5
  %t930 = select i1 %t929, i8* %t928, i8* %t927
  %t931 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t932 = icmp eq i32 %t911, 6
  %t933 = select i1 %t932, i8* %t931, i8* %t930
  %t934 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t935 = icmp eq i32 %t911, 7
  %t936 = select i1 %t935, i8* %t934, i8* %t933
  %t937 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t938 = icmp eq i32 %t911, 8
  %t939 = select i1 %t938, i8* %t937, i8* %t936
  %t940 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t941 = icmp eq i32 %t911, 9
  %t942 = select i1 %t941, i8* %t940, i8* %t939
  %t943 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t944 = icmp eq i32 %t911, 10
  %t945 = select i1 %t944, i8* %t943, i8* %t942
  %t946 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t947 = icmp eq i32 %t911, 11
  %t948 = select i1 %t947, i8* %t946, i8* %t945
  %t949 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t950 = icmp eq i32 %t911, 12
  %t951 = select i1 %t950, i8* %t949, i8* %t948
  %t952 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t953 = icmp eq i32 %t911, 13
  %t954 = select i1 %t953, i8* %t952, i8* %t951
  %t955 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t956 = icmp eq i32 %t911, 14
  %t957 = select i1 %t956, i8* %t955, i8* %t954
  %t958 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t959 = icmp eq i32 %t911, 15
  %t960 = select i1 %t959, i8* %t958, i8* %t957
  %t961 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t962 = icmp eq i32 %t911, 16
  %t963 = select i1 %t962, i8* %t961, i8* %t960
  %t964 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t965 = icmp eq i32 %t911, 17
  %t966 = select i1 %t965, i8* %t964, i8* %t963
  %t967 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t968 = icmp eq i32 %t911, 18
  %t969 = select i1 %t968, i8* %t967, i8* %t966
  %t970 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t971 = icmp eq i32 %t911, 19
  %t972 = select i1 %t971, i8* %t970, i8* %t969
  %t973 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t974 = icmp eq i32 %t911, 20
  %t975 = select i1 %t974, i8* %t973, i8* %t972
  %t976 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t977 = icmp eq i32 %t911, 21
  %t978 = select i1 %t977, i8* %t976, i8* %t975
  %t979 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t980 = icmp eq i32 %t911, 22
  %t981 = select i1 %t980, i8* %t979, i8* %t978
  %s982 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.982, i32 0, i32 0
  %t983 = icmp eq i8* %t981, %s982
  br i1 %t983, label %then14, label %merge15
then14:
  %t984 = extractvalue %Statement %statement, 0
  %t985 = alloca %Statement
  store %Statement %statement, %Statement* %t985
  %t986 = getelementptr inbounds %Statement, %Statement* %t985, i32 0, i32 1
  %t987 = bitcast [48 x i8]* %t986 to i8*
  %t988 = bitcast i8* %t987 to i8**
  %t989 = load i8*, i8** %t988
  %t990 = icmp eq i32 %t984, 2
  %t991 = select i1 %t990, i8* %t989, i8* null
  %t992 = getelementptr inbounds %Statement, %Statement* %t985, i32 0, i32 1
  %t993 = bitcast [48 x i8]* %t992 to i8*
  %t994 = bitcast i8* %t993 to i8**
  %t995 = load i8*, i8** %t994
  %t996 = icmp eq i32 %t984, 3
  %t997 = select i1 %t996, i8* %t995, i8* %t991
  %t998 = getelementptr inbounds %Statement, %Statement* %t985, i32 0, i32 1
  %t999 = bitcast [40 x i8]* %t998 to i8*
  %t1000 = bitcast i8* %t999 to i8**
  %t1001 = load i8*, i8** %t1000
  %t1002 = icmp eq i32 %t984, 6
  %t1003 = select i1 %t1002, i8* %t1001, i8* %t997
  %t1004 = getelementptr inbounds %Statement, %Statement* %t985, i32 0, i32 1
  %t1005 = bitcast [56 x i8]* %t1004 to i8*
  %t1006 = bitcast i8* %t1005 to i8**
  %t1007 = load i8*, i8** %t1006
  %t1008 = icmp eq i32 %t984, 8
  %t1009 = select i1 %t1008, i8* %t1007, i8* %t1003
  %t1010 = getelementptr inbounds %Statement, %Statement* %t985, i32 0, i32 1
  %t1011 = bitcast [40 x i8]* %t1010 to i8*
  %t1012 = bitcast i8* %t1011 to i8**
  %t1013 = load i8*, i8** %t1012
  %t1014 = icmp eq i32 %t984, 9
  %t1015 = select i1 %t1014, i8* %t1013, i8* %t1009
  %t1016 = getelementptr inbounds %Statement, %Statement* %t985, i32 0, i32 1
  %t1017 = bitcast [40 x i8]* %t1016 to i8*
  %t1018 = bitcast i8* %t1017 to i8**
  %t1019 = load i8*, i8** %t1018
  %t1020 = icmp eq i32 %t984, 10
  %t1021 = select i1 %t1020, i8* %t1019, i8* %t1015
  %t1022 = getelementptr inbounds %Statement, %Statement* %t985, i32 0, i32 1
  %t1023 = bitcast [40 x i8]* %t1022 to i8*
  %t1024 = bitcast i8* %t1023 to i8**
  %t1025 = load i8*, i8** %t1024
  %t1026 = icmp eq i32 %t984, 11
  %t1027 = select i1 %t1026, i8* %t1025, i8* %t1021
  %s1028 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.1028, i32 0, i32 0
  %t1029 = extractvalue %Statement %statement, 0
  %t1030 = alloca %Statement
  store %Statement %statement, %Statement* %t1030
  %t1031 = getelementptr inbounds %Statement, %Statement* %t1030, i32 0, i32 1
  %t1032 = bitcast [48 x i8]* %t1031 to i8*
  %t1033 = getelementptr inbounds i8, i8* %t1032, i64 8
  %t1034 = bitcast i8* %t1033 to %SourceSpan**
  %t1035 = load %SourceSpan*, %SourceSpan** %t1034
  %t1036 = icmp eq i32 %t1029, 3
  %t1037 = select i1 %t1036, %SourceSpan* %t1035, %SourceSpan* null
  %t1038 = getelementptr inbounds %Statement, %Statement* %t1030, i32 0, i32 1
  %t1039 = bitcast [40 x i8]* %t1038 to i8*
  %t1040 = getelementptr inbounds i8, i8* %t1039, i64 8
  %t1041 = bitcast i8* %t1040 to %SourceSpan**
  %t1042 = load %SourceSpan*, %SourceSpan** %t1041
  %t1043 = icmp eq i32 %t1029, 6
  %t1044 = select i1 %t1043, %SourceSpan* %t1042, %SourceSpan* %t1037
  %t1045 = getelementptr inbounds %Statement, %Statement* %t1030, i32 0, i32 1
  %t1046 = bitcast [56 x i8]* %t1045 to i8*
  %t1047 = getelementptr inbounds i8, i8* %t1046, i64 8
  %t1048 = bitcast i8* %t1047 to %SourceSpan**
  %t1049 = load %SourceSpan*, %SourceSpan** %t1048
  %t1050 = icmp eq i32 %t1029, 8
  %t1051 = select i1 %t1050, %SourceSpan* %t1049, %SourceSpan* %t1044
  %t1052 = getelementptr inbounds %Statement, %Statement* %t1030, i32 0, i32 1
  %t1053 = bitcast [40 x i8]* %t1052 to i8*
  %t1054 = getelementptr inbounds i8, i8* %t1053, i64 8
  %t1055 = bitcast i8* %t1054 to %SourceSpan**
  %t1056 = load %SourceSpan*, %SourceSpan** %t1055
  %t1057 = icmp eq i32 %t1029, 9
  %t1058 = select i1 %t1057, %SourceSpan* %t1056, %SourceSpan* %t1051
  %t1059 = getelementptr inbounds %Statement, %Statement* %t1030, i32 0, i32 1
  %t1060 = bitcast [40 x i8]* %t1059 to i8*
  %t1061 = getelementptr inbounds i8, i8* %t1060, i64 8
  %t1062 = bitcast i8* %t1061 to %SourceSpan**
  %t1063 = load %SourceSpan*, %SourceSpan** %t1062
  %t1064 = icmp eq i32 %t1029, 10
  %t1065 = select i1 %t1064, %SourceSpan* %t1063, %SourceSpan* %t1058
  %t1066 = getelementptr inbounds %Statement, %Statement* %t1030, i32 0, i32 1
  %t1067 = bitcast [40 x i8]* %t1066 to i8*
  %t1068 = getelementptr inbounds i8, i8* %t1067, i64 8
  %t1069 = bitcast i8* %t1068 to %SourceSpan**
  %t1070 = load %SourceSpan*, %SourceSpan** %t1069
  %t1071 = icmp eq i32 %t1029, 11
  %t1072 = select i1 %t1071, %SourceSpan* %t1070, %SourceSpan* %t1065
  %t1073 = bitcast %SourceSpan* %t1072 to i8*
  %t1074 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1027, i8* %s1028, i8* %t1073)
  store %ScopeResult %t1074, %ScopeResult* %l9
  %t1075 = load %ScopeResult, %ScopeResult* %l9
  %t1076 = extractvalue %ScopeResult %t1075, 1
  store { %Diagnostic**, i64 }* %t1076, { %Diagnostic**, i64 }** %l10
  %t1077 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l10
  %t1078 = extractvalue %Statement %statement, 0
  %t1079 = alloca %Statement
  store %Statement %statement, %Statement* %t1079
  %t1080 = getelementptr inbounds %Statement, %Statement* %t1079, i32 0, i32 1
  %t1081 = bitcast [56 x i8]* %t1080 to i8*
  %t1082 = getelementptr inbounds i8, i8* %t1081, i64 16
  %t1083 = bitcast i8* %t1082 to { %TypeParameter**, i64 }**
  %t1084 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1083
  %t1085 = icmp eq i32 %t1078, 8
  %t1086 = select i1 %t1085, { %TypeParameter**, i64 }* %t1084, { %TypeParameter**, i64 }* null
  %t1087 = getelementptr inbounds %Statement, %Statement* %t1079, i32 0, i32 1
  %t1088 = bitcast [40 x i8]* %t1087 to i8*
  %t1089 = getelementptr inbounds i8, i8* %t1088, i64 16
  %t1090 = bitcast i8* %t1089 to { %TypeParameter**, i64 }**
  %t1091 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1090
  %t1092 = icmp eq i32 %t1078, 9
  %t1093 = select i1 %t1092, { %TypeParameter**, i64 }* %t1091, { %TypeParameter**, i64 }* %t1086
  %t1094 = getelementptr inbounds %Statement, %Statement* %t1079, i32 0, i32 1
  %t1095 = bitcast [40 x i8]* %t1094 to i8*
  %t1096 = getelementptr inbounds i8, i8* %t1095, i64 16
  %t1097 = bitcast i8* %t1096 to { %TypeParameter**, i64 }**
  %t1098 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1097
  %t1099 = icmp eq i32 %t1078, 10
  %t1100 = select i1 %t1099, { %TypeParameter**, i64 }* %t1098, { %TypeParameter**, i64 }* %t1093
  %t1101 = getelementptr inbounds %Statement, %Statement* %t1079, i32 0, i32 1
  %t1102 = bitcast [40 x i8]* %t1101 to i8*
  %t1103 = getelementptr inbounds i8, i8* %t1102, i64 16
  %t1104 = bitcast i8* %t1103 to { %TypeParameter**, i64 }**
  %t1105 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1104
  %t1106 = icmp eq i32 %t1078, 11
  %t1107 = select i1 %t1106, { %TypeParameter**, i64 }* %t1105, { %TypeParameter**, i64 }* %t1100
  %t1108 = bitcast { %TypeParameter**, i64 }* %t1107 to { %TypeParameter*, i64 }*
  %t1109 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t1108)
  %t1110 = bitcast { %Diagnostic**, i64 }* %t1077 to { i8**, i64 }*
  %t1111 = bitcast { %Diagnostic*, i64 }* %t1109 to { i8**, i64 }*
  %t1112 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1110, { i8**, i64 }* %t1111)
  %t1113 = bitcast { i8**, i64 }* %t1112 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1113, { %Diagnostic**, i64 }** %l10
  %t1114 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l10
  %t1115 = extractvalue %Statement %statement, 0
  %t1116 = alloca %Statement
  store %Statement %statement, %Statement* %t1116
  %t1117 = getelementptr inbounds %Statement, %Statement* %t1116, i32 0, i32 1
  %t1118 = bitcast [40 x i8]* %t1117 to i8*
  %t1119 = getelementptr inbounds i8, i8* %t1118, i64 24
  %t1120 = bitcast i8* %t1119 to { %FunctionSignature**, i64 }**
  %t1121 = load { %FunctionSignature**, i64 }*, { %FunctionSignature**, i64 }** %t1120
  %t1122 = icmp eq i32 %t1115, 10
  %t1123 = select i1 %t1122, { %FunctionSignature**, i64 }* %t1121, { %FunctionSignature**, i64 }* null
  %t1124 = bitcast { %FunctionSignature**, i64 }* %t1123 to { %FunctionSignature*, i64 }*
  %t1125 = call { %Diagnostic*, i64 }* @check_interface_members({ %FunctionSignature*, i64 }* %t1124)
  %t1126 = bitcast { %Diagnostic**, i64 }* %t1114 to { i8**, i64 }*
  %t1127 = bitcast { %Diagnostic*, i64 }* %t1125 to { i8**, i64 }*
  %t1128 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1126, { i8**, i64 }* %t1127)
  %t1129 = bitcast { i8**, i64 }* %t1128 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1129, { %Diagnostic**, i64 }** %l10
  %t1130 = load %ScopeResult, %ScopeResult* %l9
  %t1131 = extractvalue %ScopeResult %t1130, 0
  %t1132 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1131, 0
  %t1133 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l10
  %t1134 = insertvalue %ScopeResult %t1132, { %Diagnostic**, i64 }* %t1133, 1
  ret %ScopeResult %t1134
merge15:
  %t1135 = extractvalue %Statement %statement, 0
  %t1136 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1137 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1138 = icmp eq i32 %t1135, 0
  %t1139 = select i1 %t1138, i8* %t1137, i8* %t1136
  %t1140 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1141 = icmp eq i32 %t1135, 1
  %t1142 = select i1 %t1141, i8* %t1140, i8* %t1139
  %t1143 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1144 = icmp eq i32 %t1135, 2
  %t1145 = select i1 %t1144, i8* %t1143, i8* %t1142
  %t1146 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1147 = icmp eq i32 %t1135, 3
  %t1148 = select i1 %t1147, i8* %t1146, i8* %t1145
  %t1149 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1150 = icmp eq i32 %t1135, 4
  %t1151 = select i1 %t1150, i8* %t1149, i8* %t1148
  %t1152 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1153 = icmp eq i32 %t1135, 5
  %t1154 = select i1 %t1153, i8* %t1152, i8* %t1151
  %t1155 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1156 = icmp eq i32 %t1135, 6
  %t1157 = select i1 %t1156, i8* %t1155, i8* %t1154
  %t1158 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1159 = icmp eq i32 %t1135, 7
  %t1160 = select i1 %t1159, i8* %t1158, i8* %t1157
  %t1161 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1162 = icmp eq i32 %t1135, 8
  %t1163 = select i1 %t1162, i8* %t1161, i8* %t1160
  %t1164 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1165 = icmp eq i32 %t1135, 9
  %t1166 = select i1 %t1165, i8* %t1164, i8* %t1163
  %t1167 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1168 = icmp eq i32 %t1135, 10
  %t1169 = select i1 %t1168, i8* %t1167, i8* %t1166
  %t1170 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1171 = icmp eq i32 %t1135, 11
  %t1172 = select i1 %t1171, i8* %t1170, i8* %t1169
  %t1173 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1174 = icmp eq i32 %t1135, 12
  %t1175 = select i1 %t1174, i8* %t1173, i8* %t1172
  %t1176 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1177 = icmp eq i32 %t1135, 13
  %t1178 = select i1 %t1177, i8* %t1176, i8* %t1175
  %t1179 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1180 = icmp eq i32 %t1135, 14
  %t1181 = select i1 %t1180, i8* %t1179, i8* %t1178
  %t1182 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1183 = icmp eq i32 %t1135, 15
  %t1184 = select i1 %t1183, i8* %t1182, i8* %t1181
  %t1185 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1186 = icmp eq i32 %t1135, 16
  %t1187 = select i1 %t1186, i8* %t1185, i8* %t1184
  %t1188 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1189 = icmp eq i32 %t1135, 17
  %t1190 = select i1 %t1189, i8* %t1188, i8* %t1187
  %t1191 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1192 = icmp eq i32 %t1135, 18
  %t1193 = select i1 %t1192, i8* %t1191, i8* %t1190
  %t1194 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1195 = icmp eq i32 %t1135, 19
  %t1196 = select i1 %t1195, i8* %t1194, i8* %t1193
  %t1197 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1198 = icmp eq i32 %t1135, 20
  %t1199 = select i1 %t1198, i8* %t1197, i8* %t1196
  %t1200 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1201 = icmp eq i32 %t1135, 21
  %t1202 = select i1 %t1201, i8* %t1200, i8* %t1199
  %t1203 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1204 = icmp eq i32 %t1135, 22
  %t1205 = select i1 %t1204, i8* %t1203, i8* %t1202
  %s1206 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.1206, i32 0, i32 0
  %t1207 = icmp eq i8* %t1205, %s1206
  br i1 %t1207, label %then16, label %merge17
then16:
  %t1208 = extractvalue %Statement %statement, 0
  %t1209 = alloca %Statement
  store %Statement %statement, %Statement* %t1209
  %t1210 = getelementptr inbounds %Statement, %Statement* %t1209, i32 0, i32 1
  %t1211 = bitcast [48 x i8]* %t1210 to i8*
  %t1212 = bitcast i8* %t1211 to i8**
  %t1213 = load i8*, i8** %t1212
  %t1214 = icmp eq i32 %t1208, 2
  %t1215 = select i1 %t1214, i8* %t1213, i8* null
  %t1216 = getelementptr inbounds %Statement, %Statement* %t1209, i32 0, i32 1
  %t1217 = bitcast [48 x i8]* %t1216 to i8*
  %t1218 = bitcast i8* %t1217 to i8**
  %t1219 = load i8*, i8** %t1218
  %t1220 = icmp eq i32 %t1208, 3
  %t1221 = select i1 %t1220, i8* %t1219, i8* %t1215
  %t1222 = getelementptr inbounds %Statement, %Statement* %t1209, i32 0, i32 1
  %t1223 = bitcast [40 x i8]* %t1222 to i8*
  %t1224 = bitcast i8* %t1223 to i8**
  %t1225 = load i8*, i8** %t1224
  %t1226 = icmp eq i32 %t1208, 6
  %t1227 = select i1 %t1226, i8* %t1225, i8* %t1221
  %t1228 = getelementptr inbounds %Statement, %Statement* %t1209, i32 0, i32 1
  %t1229 = bitcast [56 x i8]* %t1228 to i8*
  %t1230 = bitcast i8* %t1229 to i8**
  %t1231 = load i8*, i8** %t1230
  %t1232 = icmp eq i32 %t1208, 8
  %t1233 = select i1 %t1232, i8* %t1231, i8* %t1227
  %t1234 = getelementptr inbounds %Statement, %Statement* %t1209, i32 0, i32 1
  %t1235 = bitcast [40 x i8]* %t1234 to i8*
  %t1236 = bitcast i8* %t1235 to i8**
  %t1237 = load i8*, i8** %t1236
  %t1238 = icmp eq i32 %t1208, 9
  %t1239 = select i1 %t1238, i8* %t1237, i8* %t1233
  %t1240 = getelementptr inbounds %Statement, %Statement* %t1209, i32 0, i32 1
  %t1241 = bitcast [40 x i8]* %t1240 to i8*
  %t1242 = bitcast i8* %t1241 to i8**
  %t1243 = load i8*, i8** %t1242
  %t1244 = icmp eq i32 %t1208, 10
  %t1245 = select i1 %t1244, i8* %t1243, i8* %t1239
  %t1246 = getelementptr inbounds %Statement, %Statement* %t1209, i32 0, i32 1
  %t1247 = bitcast [40 x i8]* %t1246 to i8*
  %t1248 = bitcast i8* %t1247 to i8**
  %t1249 = load i8*, i8** %t1248
  %t1250 = icmp eq i32 %t1208, 11
  %t1251 = select i1 %t1250, i8* %t1249, i8* %t1245
  %s1252 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1252, i32 0, i32 0
  %t1253 = extractvalue %Statement %statement, 0
  %t1254 = alloca %Statement
  store %Statement %statement, %Statement* %t1254
  %t1255 = getelementptr inbounds %Statement, %Statement* %t1254, i32 0, i32 1
  %t1256 = bitcast [48 x i8]* %t1255 to i8*
  %t1257 = getelementptr inbounds i8, i8* %t1256, i64 8
  %t1258 = bitcast i8* %t1257 to %SourceSpan**
  %t1259 = load %SourceSpan*, %SourceSpan** %t1258
  %t1260 = icmp eq i32 %t1253, 3
  %t1261 = select i1 %t1260, %SourceSpan* %t1259, %SourceSpan* null
  %t1262 = getelementptr inbounds %Statement, %Statement* %t1254, i32 0, i32 1
  %t1263 = bitcast [40 x i8]* %t1262 to i8*
  %t1264 = getelementptr inbounds i8, i8* %t1263, i64 8
  %t1265 = bitcast i8* %t1264 to %SourceSpan**
  %t1266 = load %SourceSpan*, %SourceSpan** %t1265
  %t1267 = icmp eq i32 %t1253, 6
  %t1268 = select i1 %t1267, %SourceSpan* %t1266, %SourceSpan* %t1261
  %t1269 = getelementptr inbounds %Statement, %Statement* %t1254, i32 0, i32 1
  %t1270 = bitcast [56 x i8]* %t1269 to i8*
  %t1271 = getelementptr inbounds i8, i8* %t1270, i64 8
  %t1272 = bitcast i8* %t1271 to %SourceSpan**
  %t1273 = load %SourceSpan*, %SourceSpan** %t1272
  %t1274 = icmp eq i32 %t1253, 8
  %t1275 = select i1 %t1274, %SourceSpan* %t1273, %SourceSpan* %t1268
  %t1276 = getelementptr inbounds %Statement, %Statement* %t1254, i32 0, i32 1
  %t1277 = bitcast [40 x i8]* %t1276 to i8*
  %t1278 = getelementptr inbounds i8, i8* %t1277, i64 8
  %t1279 = bitcast i8* %t1278 to %SourceSpan**
  %t1280 = load %SourceSpan*, %SourceSpan** %t1279
  %t1281 = icmp eq i32 %t1253, 9
  %t1282 = select i1 %t1281, %SourceSpan* %t1280, %SourceSpan* %t1275
  %t1283 = getelementptr inbounds %Statement, %Statement* %t1254, i32 0, i32 1
  %t1284 = bitcast [40 x i8]* %t1283 to i8*
  %t1285 = getelementptr inbounds i8, i8* %t1284, i64 8
  %t1286 = bitcast i8* %t1285 to %SourceSpan**
  %t1287 = load %SourceSpan*, %SourceSpan** %t1286
  %t1288 = icmp eq i32 %t1253, 10
  %t1289 = select i1 %t1288, %SourceSpan* %t1287, %SourceSpan* %t1282
  %t1290 = getelementptr inbounds %Statement, %Statement* %t1254, i32 0, i32 1
  %t1291 = bitcast [40 x i8]* %t1290 to i8*
  %t1292 = getelementptr inbounds i8, i8* %t1291, i64 8
  %t1293 = bitcast i8* %t1292 to %SourceSpan**
  %t1294 = load %SourceSpan*, %SourceSpan** %t1293
  %t1295 = icmp eq i32 %t1253, 11
  %t1296 = select i1 %t1295, %SourceSpan* %t1294, %SourceSpan* %t1289
  %t1297 = bitcast %SourceSpan* %t1296 to i8*
  %t1298 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1251, i8* %s1252, i8* %t1297)
  store %ScopeResult %t1298, %ScopeResult* %l11
  %t1299 = load %ScopeResult, %ScopeResult* %l11
  %t1300 = extractvalue %ScopeResult %t1299, 1
  %t1301 = extractvalue %Statement %statement, 0
  %t1302 = alloca %Statement
  store %Statement %statement, %Statement* %t1302
  %t1303 = getelementptr inbounds %Statement, %Statement* %t1302, i32 0, i32 1
  %t1304 = bitcast [48 x i8]* %t1303 to i8*
  %t1305 = getelementptr inbounds i8, i8* %t1304, i64 24
  %t1306 = bitcast i8* %t1305 to { %ModelProperty**, i64 }**
  %t1307 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1306
  %t1308 = icmp eq i32 %t1301, 3
  %t1309 = select i1 %t1308, { %ModelProperty**, i64 }* %t1307, { %ModelProperty**, i64 }* null
  %t1310 = bitcast { %ModelProperty**, i64 }* %t1309 to { %ModelProperty*, i64 }*
  %t1311 = call { %Diagnostic*, i64 }* @check_model_properties({ %ModelProperty*, i64 }* %t1310)
  %t1312 = bitcast { %Diagnostic**, i64 }* %t1300 to { i8**, i64 }*
  %t1313 = bitcast { %Diagnostic*, i64 }* %t1311 to { i8**, i64 }*
  %t1314 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1312, { i8**, i64 }* %t1313)
  store { i8**, i64 }* %t1314, { i8**, i64 }** %l12
  %t1315 = load %ScopeResult, %ScopeResult* %l11
  %t1316 = extractvalue %ScopeResult %t1315, 0
  %t1317 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1316, 0
  %t1318 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %t1319 = bitcast { i8**, i64 }* %t1318 to { %Diagnostic**, i64 }*
  %t1320 = insertvalue %ScopeResult %t1317, { %Diagnostic**, i64 }* %t1319, 1
  ret %ScopeResult %t1320
merge17:
  %t1321 = extractvalue %Statement %statement, 0
  %t1322 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1323 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1324 = icmp eq i32 %t1321, 0
  %t1325 = select i1 %t1324, i8* %t1323, i8* %t1322
  %t1326 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1327 = icmp eq i32 %t1321, 1
  %t1328 = select i1 %t1327, i8* %t1326, i8* %t1325
  %t1329 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1330 = icmp eq i32 %t1321, 2
  %t1331 = select i1 %t1330, i8* %t1329, i8* %t1328
  %t1332 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1333 = icmp eq i32 %t1321, 3
  %t1334 = select i1 %t1333, i8* %t1332, i8* %t1331
  %t1335 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1336 = icmp eq i32 %t1321, 4
  %t1337 = select i1 %t1336, i8* %t1335, i8* %t1334
  %t1338 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1339 = icmp eq i32 %t1321, 5
  %t1340 = select i1 %t1339, i8* %t1338, i8* %t1337
  %t1341 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1342 = icmp eq i32 %t1321, 6
  %t1343 = select i1 %t1342, i8* %t1341, i8* %t1340
  %t1344 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1345 = icmp eq i32 %t1321, 7
  %t1346 = select i1 %t1345, i8* %t1344, i8* %t1343
  %t1347 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1348 = icmp eq i32 %t1321, 8
  %t1349 = select i1 %t1348, i8* %t1347, i8* %t1346
  %t1350 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1351 = icmp eq i32 %t1321, 9
  %t1352 = select i1 %t1351, i8* %t1350, i8* %t1349
  %t1353 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1354 = icmp eq i32 %t1321, 10
  %t1355 = select i1 %t1354, i8* %t1353, i8* %t1352
  %t1356 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1357 = icmp eq i32 %t1321, 11
  %t1358 = select i1 %t1357, i8* %t1356, i8* %t1355
  %t1359 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1360 = icmp eq i32 %t1321, 12
  %t1361 = select i1 %t1360, i8* %t1359, i8* %t1358
  %t1362 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1363 = icmp eq i32 %t1321, 13
  %t1364 = select i1 %t1363, i8* %t1362, i8* %t1361
  %t1365 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1366 = icmp eq i32 %t1321, 14
  %t1367 = select i1 %t1366, i8* %t1365, i8* %t1364
  %t1368 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1369 = icmp eq i32 %t1321, 15
  %t1370 = select i1 %t1369, i8* %t1368, i8* %t1367
  %t1371 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1372 = icmp eq i32 %t1321, 16
  %t1373 = select i1 %t1372, i8* %t1371, i8* %t1370
  %t1374 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1375 = icmp eq i32 %t1321, 17
  %t1376 = select i1 %t1375, i8* %t1374, i8* %t1373
  %t1377 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1378 = icmp eq i32 %t1321, 18
  %t1379 = select i1 %t1378, i8* %t1377, i8* %t1376
  %t1380 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1381 = icmp eq i32 %t1321, 19
  %t1382 = select i1 %t1381, i8* %t1380, i8* %t1379
  %t1383 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1384 = icmp eq i32 %t1321, 20
  %t1385 = select i1 %t1384, i8* %t1383, i8* %t1382
  %t1386 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1387 = icmp eq i32 %t1321, 21
  %t1388 = select i1 %t1387, i8* %t1386, i8* %t1385
  %t1389 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1390 = icmp eq i32 %t1321, 22
  %t1391 = select i1 %t1390, i8* %t1389, i8* %t1388
  %s1392 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1392, i32 0, i32 0
  %t1393 = icmp eq i8* %t1391, %s1392
  br i1 %t1393, label %then18, label %merge19
then18:
  %t1394 = extractvalue %Statement %statement, 0
  %t1395 = alloca %Statement
  store %Statement %statement, %Statement* %t1395
  %t1396 = getelementptr inbounds %Statement, %Statement* %t1395, i32 0, i32 1
  %t1397 = bitcast [24 x i8]* %t1396 to i8*
  %t1398 = bitcast i8* %t1397 to %FunctionSignature**
  %t1399 = load %FunctionSignature*, %FunctionSignature** %t1398
  %t1400 = icmp eq i32 %t1394, 4
  %t1401 = select i1 %t1400, %FunctionSignature* %t1399, %FunctionSignature* null
  %t1402 = getelementptr inbounds %Statement, %Statement* %t1395, i32 0, i32 1
  %t1403 = bitcast [24 x i8]* %t1402 to i8*
  %t1404 = bitcast i8* %t1403 to %FunctionSignature**
  %t1405 = load %FunctionSignature*, %FunctionSignature** %t1404
  %t1406 = icmp eq i32 %t1394, 5
  %t1407 = select i1 %t1406, %FunctionSignature* %t1405, %FunctionSignature* %t1401
  %t1408 = getelementptr inbounds %Statement, %Statement* %t1395, i32 0, i32 1
  %t1409 = bitcast [24 x i8]* %t1408 to i8*
  %t1410 = bitcast i8* %t1409 to %FunctionSignature**
  %t1411 = load %FunctionSignature*, %FunctionSignature** %t1410
  %t1412 = icmp eq i32 %t1394, 7
  %t1413 = select i1 %t1412, %FunctionSignature* %t1411, %FunctionSignature* %t1407
  %t1414 = getelementptr %FunctionSignature, %FunctionSignature* %t1413, i32 0, i32 0
  %t1415 = load i8*, i8** %t1414
  %s1416 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1416, i32 0, i32 0
  %t1417 = extractvalue %Statement %statement, 0
  %t1418 = alloca %Statement
  store %Statement %statement, %Statement* %t1418
  %t1419 = getelementptr inbounds %Statement, %Statement* %t1418, i32 0, i32 1
  %t1420 = bitcast [24 x i8]* %t1419 to i8*
  %t1421 = bitcast i8* %t1420 to %FunctionSignature**
  %t1422 = load %FunctionSignature*, %FunctionSignature** %t1421
  %t1423 = icmp eq i32 %t1417, 4
  %t1424 = select i1 %t1423, %FunctionSignature* %t1422, %FunctionSignature* null
  %t1425 = getelementptr inbounds %Statement, %Statement* %t1418, i32 0, i32 1
  %t1426 = bitcast [24 x i8]* %t1425 to i8*
  %t1427 = bitcast i8* %t1426 to %FunctionSignature**
  %t1428 = load %FunctionSignature*, %FunctionSignature** %t1427
  %t1429 = icmp eq i32 %t1417, 5
  %t1430 = select i1 %t1429, %FunctionSignature* %t1428, %FunctionSignature* %t1424
  %t1431 = getelementptr inbounds %Statement, %Statement* %t1418, i32 0, i32 1
  %t1432 = bitcast [24 x i8]* %t1431 to i8*
  %t1433 = bitcast i8* %t1432 to %FunctionSignature**
  %t1434 = load %FunctionSignature*, %FunctionSignature** %t1433
  %t1435 = icmp eq i32 %t1417, 7
  %t1436 = select i1 %t1435, %FunctionSignature* %t1434, %FunctionSignature* %t1430
  %t1437 = getelementptr %FunctionSignature, %FunctionSignature* %t1436, i32 0, i32 6
  %t1438 = load %SourceSpan*, %SourceSpan** %t1437
  %t1439 = bitcast %SourceSpan* %t1438 to i8*
  %t1440 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1415, i8* %s1416, i8* %t1439)
  store %ScopeResult %t1440, %ScopeResult* %l13
  %t1441 = load %ScopeResult, %ScopeResult* %l13
  %t1442 = extractvalue %ScopeResult %t1441, 1
  store { %Diagnostic**, i64 }* %t1442, { %Diagnostic**, i64 }** %l14
  %t1443 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l14
  %t1444 = extractvalue %Statement %statement, 0
  %t1445 = alloca %Statement
  store %Statement %statement, %Statement* %t1445
  %t1446 = getelementptr inbounds %Statement, %Statement* %t1445, i32 0, i32 1
  %t1447 = bitcast [24 x i8]* %t1446 to i8*
  %t1448 = bitcast i8* %t1447 to %FunctionSignature**
  %t1449 = load %FunctionSignature*, %FunctionSignature** %t1448
  %t1450 = icmp eq i32 %t1444, 4
  %t1451 = select i1 %t1450, %FunctionSignature* %t1449, %FunctionSignature* null
  %t1452 = getelementptr inbounds %Statement, %Statement* %t1445, i32 0, i32 1
  %t1453 = bitcast [24 x i8]* %t1452 to i8*
  %t1454 = bitcast i8* %t1453 to %FunctionSignature**
  %t1455 = load %FunctionSignature*, %FunctionSignature** %t1454
  %t1456 = icmp eq i32 %t1444, 5
  %t1457 = select i1 %t1456, %FunctionSignature* %t1455, %FunctionSignature* %t1451
  %t1458 = getelementptr inbounds %Statement, %Statement* %t1445, i32 0, i32 1
  %t1459 = bitcast [24 x i8]* %t1458 to i8*
  %t1460 = bitcast i8* %t1459 to %FunctionSignature**
  %t1461 = load %FunctionSignature*, %FunctionSignature** %t1460
  %t1462 = icmp eq i32 %t1444, 7
  %t1463 = select i1 %t1462, %FunctionSignature* %t1461, %FunctionSignature* %t1457
  %t1464 = load %FunctionSignature, %FunctionSignature* %t1463
  %t1465 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t1464)
  %t1466 = bitcast { %Diagnostic**, i64 }* %t1443 to { i8**, i64 }*
  %t1467 = bitcast { %Diagnostic*, i64 }* %t1465 to { i8**, i64 }*
  %t1468 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1466, { i8**, i64 }* %t1467)
  %t1469 = bitcast { i8**, i64 }* %t1468 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1469, { %Diagnostic**, i64 }** %l14
  %t1470 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l14
  %t1471 = extractvalue %Statement %statement, 0
  %t1472 = alloca %Statement
  store %Statement %statement, %Statement* %t1472
  %t1473 = getelementptr inbounds %Statement, %Statement* %t1472, i32 0, i32 1
  %t1474 = bitcast [24 x i8]* %t1473 to i8*
  %t1475 = bitcast i8* %t1474 to %FunctionSignature**
  %t1476 = load %FunctionSignature*, %FunctionSignature** %t1475
  %t1477 = icmp eq i32 %t1471, 4
  %t1478 = select i1 %t1477, %FunctionSignature* %t1476, %FunctionSignature* null
  %t1479 = getelementptr inbounds %Statement, %Statement* %t1472, i32 0, i32 1
  %t1480 = bitcast [24 x i8]* %t1479 to i8*
  %t1481 = bitcast i8* %t1480 to %FunctionSignature**
  %t1482 = load %FunctionSignature*, %FunctionSignature** %t1481
  %t1483 = icmp eq i32 %t1471, 5
  %t1484 = select i1 %t1483, %FunctionSignature* %t1482, %FunctionSignature* %t1478
  %t1485 = getelementptr inbounds %Statement, %Statement* %t1472, i32 0, i32 1
  %t1486 = bitcast [24 x i8]* %t1485 to i8*
  %t1487 = bitcast i8* %t1486 to %FunctionSignature**
  %t1488 = load %FunctionSignature*, %FunctionSignature** %t1487
  %t1489 = icmp eq i32 %t1471, 7
  %t1490 = select i1 %t1489, %FunctionSignature* %t1488, %FunctionSignature* %t1484
  %t1491 = extractvalue %Statement %statement, 0
  %t1492 = alloca %Statement
  store %Statement %statement, %Statement* %t1492
  %t1493 = getelementptr inbounds %Statement, %Statement* %t1492, i32 0, i32 1
  %t1494 = bitcast [24 x i8]* %t1493 to i8*
  %t1495 = getelementptr inbounds i8, i8* %t1494, i64 8
  %t1496 = bitcast i8* %t1495 to %Block**
  %t1497 = load %Block*, %Block** %t1496
  %t1498 = icmp eq i32 %t1491, 4
  %t1499 = select i1 %t1498, %Block* %t1497, %Block* null
  %t1500 = getelementptr inbounds %Statement, %Statement* %t1492, i32 0, i32 1
  %t1501 = bitcast [24 x i8]* %t1500 to i8*
  %t1502 = getelementptr inbounds i8, i8* %t1501, i64 8
  %t1503 = bitcast i8* %t1502 to %Block**
  %t1504 = load %Block*, %Block** %t1503
  %t1505 = icmp eq i32 %t1491, 5
  %t1506 = select i1 %t1505, %Block* %t1504, %Block* %t1499
  %t1507 = getelementptr inbounds %Statement, %Statement* %t1492, i32 0, i32 1
  %t1508 = bitcast [40 x i8]* %t1507 to i8*
  %t1509 = getelementptr inbounds i8, i8* %t1508, i64 16
  %t1510 = bitcast i8* %t1509 to %Block**
  %t1511 = load %Block*, %Block** %t1510
  %t1512 = icmp eq i32 %t1491, 6
  %t1513 = select i1 %t1512, %Block* %t1511, %Block* %t1506
  %t1514 = getelementptr inbounds %Statement, %Statement* %t1492, i32 0, i32 1
  %t1515 = bitcast [24 x i8]* %t1514 to i8*
  %t1516 = getelementptr inbounds i8, i8* %t1515, i64 8
  %t1517 = bitcast i8* %t1516 to %Block**
  %t1518 = load %Block*, %Block** %t1517
  %t1519 = icmp eq i32 %t1491, 7
  %t1520 = select i1 %t1519, %Block* %t1518, %Block* %t1513
  %t1521 = getelementptr inbounds %Statement, %Statement* %t1492, i32 0, i32 1
  %t1522 = bitcast [40 x i8]* %t1521 to i8*
  %t1523 = getelementptr inbounds i8, i8* %t1522, i64 24
  %t1524 = bitcast i8* %t1523 to %Block**
  %t1525 = load %Block*, %Block** %t1524
  %t1526 = icmp eq i32 %t1491, 12
  %t1527 = select i1 %t1526, %Block* %t1525, %Block* %t1520
  %t1528 = getelementptr inbounds %Statement, %Statement* %t1492, i32 0, i32 1
  %t1529 = bitcast [24 x i8]* %t1528 to i8*
  %t1530 = getelementptr inbounds i8, i8* %t1529, i64 8
  %t1531 = bitcast i8* %t1530 to %Block**
  %t1532 = load %Block*, %Block** %t1531
  %t1533 = icmp eq i32 %t1491, 13
  %t1534 = select i1 %t1533, %Block* %t1532, %Block* %t1527
  %t1535 = getelementptr inbounds %Statement, %Statement* %t1492, i32 0, i32 1
  %t1536 = bitcast [24 x i8]* %t1535 to i8*
  %t1537 = getelementptr inbounds i8, i8* %t1536, i64 8
  %t1538 = bitcast i8* %t1537 to %Block**
  %t1539 = load %Block*, %Block** %t1538
  %t1540 = icmp eq i32 %t1491, 14
  %t1541 = select i1 %t1540, %Block* %t1539, %Block* %t1534
  %t1542 = getelementptr inbounds %Statement, %Statement* %t1492, i32 0, i32 1
  %t1543 = bitcast [16 x i8]* %t1542 to i8*
  %t1544 = bitcast i8* %t1543 to %Block**
  %t1545 = load %Block*, %Block** %t1544
  %t1546 = icmp eq i32 %t1491, 15
  %t1547 = select i1 %t1546, %Block* %t1545, %Block* %t1541
  %t1548 = load %FunctionSignature, %FunctionSignature* %t1490
  %t1549 = load %Block, %Block* %t1547
  %t1550 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t1548, %Block %t1549, { %Statement*, i64 }* %interfaces)
  %t1551 = bitcast { %Diagnostic**, i64 }* %t1470 to { i8**, i64 }*
  %t1552 = bitcast { %Diagnostic*, i64 }* %t1550 to { i8**, i64 }*
  %t1553 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1551, { i8**, i64 }* %t1552)
  %t1554 = bitcast { i8**, i64 }* %t1553 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1554, { %Diagnostic**, i64 }** %l14
  %t1555 = load %ScopeResult, %ScopeResult* %l13
  %t1556 = extractvalue %ScopeResult %t1555, 0
  %t1557 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1556, 0
  %t1558 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l14
  %t1559 = insertvalue %ScopeResult %t1557, { %Diagnostic**, i64 }* %t1558, 1
  ret %ScopeResult %t1559
merge19:
  %t1560 = extractvalue %Statement %statement, 0
  %t1561 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1562 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1563 = icmp eq i32 %t1560, 0
  %t1564 = select i1 %t1563, i8* %t1562, i8* %t1561
  %t1565 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1566 = icmp eq i32 %t1560, 1
  %t1567 = select i1 %t1566, i8* %t1565, i8* %t1564
  %t1568 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1569 = icmp eq i32 %t1560, 2
  %t1570 = select i1 %t1569, i8* %t1568, i8* %t1567
  %t1571 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1572 = icmp eq i32 %t1560, 3
  %t1573 = select i1 %t1572, i8* %t1571, i8* %t1570
  %t1574 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1575 = icmp eq i32 %t1560, 4
  %t1576 = select i1 %t1575, i8* %t1574, i8* %t1573
  %t1577 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1578 = icmp eq i32 %t1560, 5
  %t1579 = select i1 %t1578, i8* %t1577, i8* %t1576
  %t1580 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1581 = icmp eq i32 %t1560, 6
  %t1582 = select i1 %t1581, i8* %t1580, i8* %t1579
  %t1583 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1584 = icmp eq i32 %t1560, 7
  %t1585 = select i1 %t1584, i8* %t1583, i8* %t1582
  %t1586 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1587 = icmp eq i32 %t1560, 8
  %t1588 = select i1 %t1587, i8* %t1586, i8* %t1585
  %t1589 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1590 = icmp eq i32 %t1560, 9
  %t1591 = select i1 %t1590, i8* %t1589, i8* %t1588
  %t1592 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1593 = icmp eq i32 %t1560, 10
  %t1594 = select i1 %t1593, i8* %t1592, i8* %t1591
  %t1595 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1596 = icmp eq i32 %t1560, 11
  %t1597 = select i1 %t1596, i8* %t1595, i8* %t1594
  %t1598 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1599 = icmp eq i32 %t1560, 12
  %t1600 = select i1 %t1599, i8* %t1598, i8* %t1597
  %t1601 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1602 = icmp eq i32 %t1560, 13
  %t1603 = select i1 %t1602, i8* %t1601, i8* %t1600
  %t1604 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1605 = icmp eq i32 %t1560, 14
  %t1606 = select i1 %t1605, i8* %t1604, i8* %t1603
  %t1607 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1608 = icmp eq i32 %t1560, 15
  %t1609 = select i1 %t1608, i8* %t1607, i8* %t1606
  %t1610 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1611 = icmp eq i32 %t1560, 16
  %t1612 = select i1 %t1611, i8* %t1610, i8* %t1609
  %t1613 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1614 = icmp eq i32 %t1560, 17
  %t1615 = select i1 %t1614, i8* %t1613, i8* %t1612
  %t1616 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1617 = icmp eq i32 %t1560, 18
  %t1618 = select i1 %t1617, i8* %t1616, i8* %t1615
  %t1619 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1620 = icmp eq i32 %t1560, 19
  %t1621 = select i1 %t1620, i8* %t1619, i8* %t1618
  %t1622 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1623 = icmp eq i32 %t1560, 20
  %t1624 = select i1 %t1623, i8* %t1622, i8* %t1621
  %t1625 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1626 = icmp eq i32 %t1560, 21
  %t1627 = select i1 %t1626, i8* %t1625, i8* %t1624
  %t1628 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1629 = icmp eq i32 %t1560, 22
  %t1630 = select i1 %t1629, i8* %t1628, i8* %t1627
  %s1631 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1631, i32 0, i32 0
  %t1632 = icmp eq i8* %t1630, %s1631
  br i1 %t1632, label %then20, label %merge21
then20:
  %t1633 = extractvalue %Statement %statement, 0
  %t1634 = alloca %Statement
  store %Statement %statement, %Statement* %t1634
  %t1635 = getelementptr inbounds %Statement, %Statement* %t1634, i32 0, i32 1
  %t1636 = bitcast [24 x i8]* %t1635 to i8*
  %t1637 = bitcast i8* %t1636 to %FunctionSignature**
  %t1638 = load %FunctionSignature*, %FunctionSignature** %t1637
  %t1639 = icmp eq i32 %t1633, 4
  %t1640 = select i1 %t1639, %FunctionSignature* %t1638, %FunctionSignature* null
  %t1641 = getelementptr inbounds %Statement, %Statement* %t1634, i32 0, i32 1
  %t1642 = bitcast [24 x i8]* %t1641 to i8*
  %t1643 = bitcast i8* %t1642 to %FunctionSignature**
  %t1644 = load %FunctionSignature*, %FunctionSignature** %t1643
  %t1645 = icmp eq i32 %t1633, 5
  %t1646 = select i1 %t1645, %FunctionSignature* %t1644, %FunctionSignature* %t1640
  %t1647 = getelementptr inbounds %Statement, %Statement* %t1634, i32 0, i32 1
  %t1648 = bitcast [24 x i8]* %t1647 to i8*
  %t1649 = bitcast i8* %t1648 to %FunctionSignature**
  %t1650 = load %FunctionSignature*, %FunctionSignature** %t1649
  %t1651 = icmp eq i32 %t1633, 7
  %t1652 = select i1 %t1651, %FunctionSignature* %t1650, %FunctionSignature* %t1646
  %t1653 = getelementptr %FunctionSignature, %FunctionSignature* %t1652, i32 0, i32 0
  %t1654 = load i8*, i8** %t1653
  %s1655 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1655, i32 0, i32 0
  %t1656 = extractvalue %Statement %statement, 0
  %t1657 = alloca %Statement
  store %Statement %statement, %Statement* %t1657
  %t1658 = getelementptr inbounds %Statement, %Statement* %t1657, i32 0, i32 1
  %t1659 = bitcast [24 x i8]* %t1658 to i8*
  %t1660 = bitcast i8* %t1659 to %FunctionSignature**
  %t1661 = load %FunctionSignature*, %FunctionSignature** %t1660
  %t1662 = icmp eq i32 %t1656, 4
  %t1663 = select i1 %t1662, %FunctionSignature* %t1661, %FunctionSignature* null
  %t1664 = getelementptr inbounds %Statement, %Statement* %t1657, i32 0, i32 1
  %t1665 = bitcast [24 x i8]* %t1664 to i8*
  %t1666 = bitcast i8* %t1665 to %FunctionSignature**
  %t1667 = load %FunctionSignature*, %FunctionSignature** %t1666
  %t1668 = icmp eq i32 %t1656, 5
  %t1669 = select i1 %t1668, %FunctionSignature* %t1667, %FunctionSignature* %t1663
  %t1670 = getelementptr inbounds %Statement, %Statement* %t1657, i32 0, i32 1
  %t1671 = bitcast [24 x i8]* %t1670 to i8*
  %t1672 = bitcast i8* %t1671 to %FunctionSignature**
  %t1673 = load %FunctionSignature*, %FunctionSignature** %t1672
  %t1674 = icmp eq i32 %t1656, 7
  %t1675 = select i1 %t1674, %FunctionSignature* %t1673, %FunctionSignature* %t1669
  %t1676 = getelementptr %FunctionSignature, %FunctionSignature* %t1675, i32 0, i32 6
  %t1677 = load %SourceSpan*, %SourceSpan** %t1676
  %t1678 = bitcast %SourceSpan* %t1677 to i8*
  %t1679 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1654, i8* %s1655, i8* %t1678)
  store %ScopeResult %t1679, %ScopeResult* %l15
  %t1680 = load %ScopeResult, %ScopeResult* %l15
  %t1681 = extractvalue %ScopeResult %t1680, 1
  store { %Diagnostic**, i64 }* %t1681, { %Diagnostic**, i64 }** %l16
  %t1682 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l16
  %t1683 = extractvalue %Statement %statement, 0
  %t1684 = alloca %Statement
  store %Statement %statement, %Statement* %t1684
  %t1685 = getelementptr inbounds %Statement, %Statement* %t1684, i32 0, i32 1
  %t1686 = bitcast [24 x i8]* %t1685 to i8*
  %t1687 = bitcast i8* %t1686 to %FunctionSignature**
  %t1688 = load %FunctionSignature*, %FunctionSignature** %t1687
  %t1689 = icmp eq i32 %t1683, 4
  %t1690 = select i1 %t1689, %FunctionSignature* %t1688, %FunctionSignature* null
  %t1691 = getelementptr inbounds %Statement, %Statement* %t1684, i32 0, i32 1
  %t1692 = bitcast [24 x i8]* %t1691 to i8*
  %t1693 = bitcast i8* %t1692 to %FunctionSignature**
  %t1694 = load %FunctionSignature*, %FunctionSignature** %t1693
  %t1695 = icmp eq i32 %t1683, 5
  %t1696 = select i1 %t1695, %FunctionSignature* %t1694, %FunctionSignature* %t1690
  %t1697 = getelementptr inbounds %Statement, %Statement* %t1684, i32 0, i32 1
  %t1698 = bitcast [24 x i8]* %t1697 to i8*
  %t1699 = bitcast i8* %t1698 to %FunctionSignature**
  %t1700 = load %FunctionSignature*, %FunctionSignature** %t1699
  %t1701 = icmp eq i32 %t1683, 7
  %t1702 = select i1 %t1701, %FunctionSignature* %t1700, %FunctionSignature* %t1696
  %t1703 = load %FunctionSignature, %FunctionSignature* %t1702
  %t1704 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t1703)
  %t1705 = bitcast { %Diagnostic**, i64 }* %t1682 to { i8**, i64 }*
  %t1706 = bitcast { %Diagnostic*, i64 }* %t1704 to { i8**, i64 }*
  %t1707 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1705, { i8**, i64 }* %t1706)
  %t1708 = bitcast { i8**, i64 }* %t1707 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1708, { %Diagnostic**, i64 }** %l16
  %t1709 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l16
  %t1710 = extractvalue %Statement %statement, 0
  %t1711 = alloca %Statement
  store %Statement %statement, %Statement* %t1711
  %t1712 = getelementptr inbounds %Statement, %Statement* %t1711, i32 0, i32 1
  %t1713 = bitcast [24 x i8]* %t1712 to i8*
  %t1714 = bitcast i8* %t1713 to %FunctionSignature**
  %t1715 = load %FunctionSignature*, %FunctionSignature** %t1714
  %t1716 = icmp eq i32 %t1710, 4
  %t1717 = select i1 %t1716, %FunctionSignature* %t1715, %FunctionSignature* null
  %t1718 = getelementptr inbounds %Statement, %Statement* %t1711, i32 0, i32 1
  %t1719 = bitcast [24 x i8]* %t1718 to i8*
  %t1720 = bitcast i8* %t1719 to %FunctionSignature**
  %t1721 = load %FunctionSignature*, %FunctionSignature** %t1720
  %t1722 = icmp eq i32 %t1710, 5
  %t1723 = select i1 %t1722, %FunctionSignature* %t1721, %FunctionSignature* %t1717
  %t1724 = getelementptr inbounds %Statement, %Statement* %t1711, i32 0, i32 1
  %t1725 = bitcast [24 x i8]* %t1724 to i8*
  %t1726 = bitcast i8* %t1725 to %FunctionSignature**
  %t1727 = load %FunctionSignature*, %FunctionSignature** %t1726
  %t1728 = icmp eq i32 %t1710, 7
  %t1729 = select i1 %t1728, %FunctionSignature* %t1727, %FunctionSignature* %t1723
  %t1730 = extractvalue %Statement %statement, 0
  %t1731 = alloca %Statement
  store %Statement %statement, %Statement* %t1731
  %t1732 = getelementptr inbounds %Statement, %Statement* %t1731, i32 0, i32 1
  %t1733 = bitcast [24 x i8]* %t1732 to i8*
  %t1734 = getelementptr inbounds i8, i8* %t1733, i64 8
  %t1735 = bitcast i8* %t1734 to %Block**
  %t1736 = load %Block*, %Block** %t1735
  %t1737 = icmp eq i32 %t1730, 4
  %t1738 = select i1 %t1737, %Block* %t1736, %Block* null
  %t1739 = getelementptr inbounds %Statement, %Statement* %t1731, i32 0, i32 1
  %t1740 = bitcast [24 x i8]* %t1739 to i8*
  %t1741 = getelementptr inbounds i8, i8* %t1740, i64 8
  %t1742 = bitcast i8* %t1741 to %Block**
  %t1743 = load %Block*, %Block** %t1742
  %t1744 = icmp eq i32 %t1730, 5
  %t1745 = select i1 %t1744, %Block* %t1743, %Block* %t1738
  %t1746 = getelementptr inbounds %Statement, %Statement* %t1731, i32 0, i32 1
  %t1747 = bitcast [40 x i8]* %t1746 to i8*
  %t1748 = getelementptr inbounds i8, i8* %t1747, i64 16
  %t1749 = bitcast i8* %t1748 to %Block**
  %t1750 = load %Block*, %Block** %t1749
  %t1751 = icmp eq i32 %t1730, 6
  %t1752 = select i1 %t1751, %Block* %t1750, %Block* %t1745
  %t1753 = getelementptr inbounds %Statement, %Statement* %t1731, i32 0, i32 1
  %t1754 = bitcast [24 x i8]* %t1753 to i8*
  %t1755 = getelementptr inbounds i8, i8* %t1754, i64 8
  %t1756 = bitcast i8* %t1755 to %Block**
  %t1757 = load %Block*, %Block** %t1756
  %t1758 = icmp eq i32 %t1730, 7
  %t1759 = select i1 %t1758, %Block* %t1757, %Block* %t1752
  %t1760 = getelementptr inbounds %Statement, %Statement* %t1731, i32 0, i32 1
  %t1761 = bitcast [40 x i8]* %t1760 to i8*
  %t1762 = getelementptr inbounds i8, i8* %t1761, i64 24
  %t1763 = bitcast i8* %t1762 to %Block**
  %t1764 = load %Block*, %Block** %t1763
  %t1765 = icmp eq i32 %t1730, 12
  %t1766 = select i1 %t1765, %Block* %t1764, %Block* %t1759
  %t1767 = getelementptr inbounds %Statement, %Statement* %t1731, i32 0, i32 1
  %t1768 = bitcast [24 x i8]* %t1767 to i8*
  %t1769 = getelementptr inbounds i8, i8* %t1768, i64 8
  %t1770 = bitcast i8* %t1769 to %Block**
  %t1771 = load %Block*, %Block** %t1770
  %t1772 = icmp eq i32 %t1730, 13
  %t1773 = select i1 %t1772, %Block* %t1771, %Block* %t1766
  %t1774 = getelementptr inbounds %Statement, %Statement* %t1731, i32 0, i32 1
  %t1775 = bitcast [24 x i8]* %t1774 to i8*
  %t1776 = getelementptr inbounds i8, i8* %t1775, i64 8
  %t1777 = bitcast i8* %t1776 to %Block**
  %t1778 = load %Block*, %Block** %t1777
  %t1779 = icmp eq i32 %t1730, 14
  %t1780 = select i1 %t1779, %Block* %t1778, %Block* %t1773
  %t1781 = getelementptr inbounds %Statement, %Statement* %t1731, i32 0, i32 1
  %t1782 = bitcast [16 x i8]* %t1781 to i8*
  %t1783 = bitcast i8* %t1782 to %Block**
  %t1784 = load %Block*, %Block** %t1783
  %t1785 = icmp eq i32 %t1730, 15
  %t1786 = select i1 %t1785, %Block* %t1784, %Block* %t1780
  %t1787 = load %FunctionSignature, %FunctionSignature* %t1729
  %t1788 = load %Block, %Block* %t1786
  %t1789 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t1787, %Block %t1788, { %Statement*, i64 }* %interfaces)
  %t1790 = bitcast { %Diagnostic**, i64 }* %t1709 to { i8**, i64 }*
  %t1791 = bitcast { %Diagnostic*, i64 }* %t1789 to { i8**, i64 }*
  %t1792 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1790, { i8**, i64 }* %t1791)
  %t1793 = bitcast { i8**, i64 }* %t1792 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1793, { %Diagnostic**, i64 }** %l16
  %t1794 = load %ScopeResult, %ScopeResult* %l15
  %t1795 = extractvalue %ScopeResult %t1794, 0
  %t1796 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1795, 0
  %t1797 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l16
  %t1798 = insertvalue %ScopeResult %t1796, { %Diagnostic**, i64 }* %t1797, 1
  ret %ScopeResult %t1798
merge21:
  %t1799 = extractvalue %Statement %statement, 0
  %t1800 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1801 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1802 = icmp eq i32 %t1799, 0
  %t1803 = select i1 %t1802, i8* %t1801, i8* %t1800
  %t1804 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1805 = icmp eq i32 %t1799, 1
  %t1806 = select i1 %t1805, i8* %t1804, i8* %t1803
  %t1807 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1808 = icmp eq i32 %t1799, 2
  %t1809 = select i1 %t1808, i8* %t1807, i8* %t1806
  %t1810 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1811 = icmp eq i32 %t1799, 3
  %t1812 = select i1 %t1811, i8* %t1810, i8* %t1809
  %t1813 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1814 = icmp eq i32 %t1799, 4
  %t1815 = select i1 %t1814, i8* %t1813, i8* %t1812
  %t1816 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1817 = icmp eq i32 %t1799, 5
  %t1818 = select i1 %t1817, i8* %t1816, i8* %t1815
  %t1819 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1820 = icmp eq i32 %t1799, 6
  %t1821 = select i1 %t1820, i8* %t1819, i8* %t1818
  %t1822 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1823 = icmp eq i32 %t1799, 7
  %t1824 = select i1 %t1823, i8* %t1822, i8* %t1821
  %t1825 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1826 = icmp eq i32 %t1799, 8
  %t1827 = select i1 %t1826, i8* %t1825, i8* %t1824
  %t1828 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1829 = icmp eq i32 %t1799, 9
  %t1830 = select i1 %t1829, i8* %t1828, i8* %t1827
  %t1831 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1832 = icmp eq i32 %t1799, 10
  %t1833 = select i1 %t1832, i8* %t1831, i8* %t1830
  %t1834 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1835 = icmp eq i32 %t1799, 11
  %t1836 = select i1 %t1835, i8* %t1834, i8* %t1833
  %t1837 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1838 = icmp eq i32 %t1799, 12
  %t1839 = select i1 %t1838, i8* %t1837, i8* %t1836
  %t1840 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1841 = icmp eq i32 %t1799, 13
  %t1842 = select i1 %t1841, i8* %t1840, i8* %t1839
  %t1843 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1844 = icmp eq i32 %t1799, 14
  %t1845 = select i1 %t1844, i8* %t1843, i8* %t1842
  %t1846 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1847 = icmp eq i32 %t1799, 15
  %t1848 = select i1 %t1847, i8* %t1846, i8* %t1845
  %t1849 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1850 = icmp eq i32 %t1799, 16
  %t1851 = select i1 %t1850, i8* %t1849, i8* %t1848
  %t1852 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1853 = icmp eq i32 %t1799, 17
  %t1854 = select i1 %t1853, i8* %t1852, i8* %t1851
  %t1855 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1856 = icmp eq i32 %t1799, 18
  %t1857 = select i1 %t1856, i8* %t1855, i8* %t1854
  %t1858 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1859 = icmp eq i32 %t1799, 19
  %t1860 = select i1 %t1859, i8* %t1858, i8* %t1857
  %t1861 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1862 = icmp eq i32 %t1799, 20
  %t1863 = select i1 %t1862, i8* %t1861, i8* %t1860
  %t1864 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1865 = icmp eq i32 %t1799, 21
  %t1866 = select i1 %t1865, i8* %t1864, i8* %t1863
  %t1867 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1868 = icmp eq i32 %t1799, 22
  %t1869 = select i1 %t1868, i8* %t1867, i8* %t1866
  %s1870 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1870, i32 0, i32 0
  %t1871 = icmp eq i8* %t1869, %s1870
  br i1 %t1871, label %then22, label %merge23
then22:
  %t1872 = extractvalue %Statement %statement, 0
  %t1873 = alloca %Statement
  store %Statement %statement, %Statement* %t1873
  %t1874 = getelementptr inbounds %Statement, %Statement* %t1873, i32 0, i32 1
  %t1875 = bitcast [48 x i8]* %t1874 to i8*
  %t1876 = bitcast i8* %t1875 to i8**
  %t1877 = load i8*, i8** %t1876
  %t1878 = icmp eq i32 %t1872, 2
  %t1879 = select i1 %t1878, i8* %t1877, i8* null
  %t1880 = getelementptr inbounds %Statement, %Statement* %t1873, i32 0, i32 1
  %t1881 = bitcast [48 x i8]* %t1880 to i8*
  %t1882 = bitcast i8* %t1881 to i8**
  %t1883 = load i8*, i8** %t1882
  %t1884 = icmp eq i32 %t1872, 3
  %t1885 = select i1 %t1884, i8* %t1883, i8* %t1879
  %t1886 = getelementptr inbounds %Statement, %Statement* %t1873, i32 0, i32 1
  %t1887 = bitcast [40 x i8]* %t1886 to i8*
  %t1888 = bitcast i8* %t1887 to i8**
  %t1889 = load i8*, i8** %t1888
  %t1890 = icmp eq i32 %t1872, 6
  %t1891 = select i1 %t1890, i8* %t1889, i8* %t1885
  %t1892 = getelementptr inbounds %Statement, %Statement* %t1873, i32 0, i32 1
  %t1893 = bitcast [56 x i8]* %t1892 to i8*
  %t1894 = bitcast i8* %t1893 to i8**
  %t1895 = load i8*, i8** %t1894
  %t1896 = icmp eq i32 %t1872, 8
  %t1897 = select i1 %t1896, i8* %t1895, i8* %t1891
  %t1898 = getelementptr inbounds %Statement, %Statement* %t1873, i32 0, i32 1
  %t1899 = bitcast [40 x i8]* %t1898 to i8*
  %t1900 = bitcast i8* %t1899 to i8**
  %t1901 = load i8*, i8** %t1900
  %t1902 = icmp eq i32 %t1872, 9
  %t1903 = select i1 %t1902, i8* %t1901, i8* %t1897
  %t1904 = getelementptr inbounds %Statement, %Statement* %t1873, i32 0, i32 1
  %t1905 = bitcast [40 x i8]* %t1904 to i8*
  %t1906 = bitcast i8* %t1905 to i8**
  %t1907 = load i8*, i8** %t1906
  %t1908 = icmp eq i32 %t1872, 10
  %t1909 = select i1 %t1908, i8* %t1907, i8* %t1903
  %t1910 = getelementptr inbounds %Statement, %Statement* %t1873, i32 0, i32 1
  %t1911 = bitcast [40 x i8]* %t1910 to i8*
  %t1912 = bitcast i8* %t1911 to i8**
  %t1913 = load i8*, i8** %t1912
  %t1914 = icmp eq i32 %t1872, 11
  %t1915 = select i1 %t1914, i8* %t1913, i8* %t1909
  %s1916 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1916, i32 0, i32 0
  %t1917 = extractvalue %Statement %statement, 0
  %t1918 = alloca %Statement
  store %Statement %statement, %Statement* %t1918
  %t1919 = getelementptr inbounds %Statement, %Statement* %t1918, i32 0, i32 1
  %t1920 = bitcast [48 x i8]* %t1919 to i8*
  %t1921 = getelementptr inbounds i8, i8* %t1920, i64 8
  %t1922 = bitcast i8* %t1921 to %SourceSpan**
  %t1923 = load %SourceSpan*, %SourceSpan** %t1922
  %t1924 = icmp eq i32 %t1917, 3
  %t1925 = select i1 %t1924, %SourceSpan* %t1923, %SourceSpan* null
  %t1926 = getelementptr inbounds %Statement, %Statement* %t1918, i32 0, i32 1
  %t1927 = bitcast [40 x i8]* %t1926 to i8*
  %t1928 = getelementptr inbounds i8, i8* %t1927, i64 8
  %t1929 = bitcast i8* %t1928 to %SourceSpan**
  %t1930 = load %SourceSpan*, %SourceSpan** %t1929
  %t1931 = icmp eq i32 %t1917, 6
  %t1932 = select i1 %t1931, %SourceSpan* %t1930, %SourceSpan* %t1925
  %t1933 = getelementptr inbounds %Statement, %Statement* %t1918, i32 0, i32 1
  %t1934 = bitcast [56 x i8]* %t1933 to i8*
  %t1935 = getelementptr inbounds i8, i8* %t1934, i64 8
  %t1936 = bitcast i8* %t1935 to %SourceSpan**
  %t1937 = load %SourceSpan*, %SourceSpan** %t1936
  %t1938 = icmp eq i32 %t1917, 8
  %t1939 = select i1 %t1938, %SourceSpan* %t1937, %SourceSpan* %t1932
  %t1940 = getelementptr inbounds %Statement, %Statement* %t1918, i32 0, i32 1
  %t1941 = bitcast [40 x i8]* %t1940 to i8*
  %t1942 = getelementptr inbounds i8, i8* %t1941, i64 8
  %t1943 = bitcast i8* %t1942 to %SourceSpan**
  %t1944 = load %SourceSpan*, %SourceSpan** %t1943
  %t1945 = icmp eq i32 %t1917, 9
  %t1946 = select i1 %t1945, %SourceSpan* %t1944, %SourceSpan* %t1939
  %t1947 = getelementptr inbounds %Statement, %Statement* %t1918, i32 0, i32 1
  %t1948 = bitcast [40 x i8]* %t1947 to i8*
  %t1949 = getelementptr inbounds i8, i8* %t1948, i64 8
  %t1950 = bitcast i8* %t1949 to %SourceSpan**
  %t1951 = load %SourceSpan*, %SourceSpan** %t1950
  %t1952 = icmp eq i32 %t1917, 10
  %t1953 = select i1 %t1952, %SourceSpan* %t1951, %SourceSpan* %t1946
  %t1954 = getelementptr inbounds %Statement, %Statement* %t1918, i32 0, i32 1
  %t1955 = bitcast [40 x i8]* %t1954 to i8*
  %t1956 = getelementptr inbounds i8, i8* %t1955, i64 8
  %t1957 = bitcast i8* %t1956 to %SourceSpan**
  %t1958 = load %SourceSpan*, %SourceSpan** %t1957
  %t1959 = icmp eq i32 %t1917, 11
  %t1960 = select i1 %t1959, %SourceSpan* %t1958, %SourceSpan* %t1953
  %t1961 = bitcast %SourceSpan* %t1960 to i8*
  %t1962 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1915, i8* %s1916, i8* %t1961)
  store %ScopeResult %t1962, %ScopeResult* %l17
  %t1963 = load %ScopeResult, %ScopeResult* %l17
  %t1964 = extractvalue %ScopeResult %t1963, 1
  %t1965 = extractvalue %Statement %statement, 0
  %t1966 = alloca %Statement
  store %Statement %statement, %Statement* %t1966
  %t1967 = getelementptr inbounds %Statement, %Statement* %t1966, i32 0, i32 1
  %t1968 = bitcast [24 x i8]* %t1967 to i8*
  %t1969 = getelementptr inbounds i8, i8* %t1968, i64 8
  %t1970 = bitcast i8* %t1969 to %Block**
  %t1971 = load %Block*, %Block** %t1970
  %t1972 = icmp eq i32 %t1965, 4
  %t1973 = select i1 %t1972, %Block* %t1971, %Block* null
  %t1974 = getelementptr inbounds %Statement, %Statement* %t1966, i32 0, i32 1
  %t1975 = bitcast [24 x i8]* %t1974 to i8*
  %t1976 = getelementptr inbounds i8, i8* %t1975, i64 8
  %t1977 = bitcast i8* %t1976 to %Block**
  %t1978 = load %Block*, %Block** %t1977
  %t1979 = icmp eq i32 %t1965, 5
  %t1980 = select i1 %t1979, %Block* %t1978, %Block* %t1973
  %t1981 = getelementptr inbounds %Statement, %Statement* %t1966, i32 0, i32 1
  %t1982 = bitcast [40 x i8]* %t1981 to i8*
  %t1983 = getelementptr inbounds i8, i8* %t1982, i64 16
  %t1984 = bitcast i8* %t1983 to %Block**
  %t1985 = load %Block*, %Block** %t1984
  %t1986 = icmp eq i32 %t1965, 6
  %t1987 = select i1 %t1986, %Block* %t1985, %Block* %t1980
  %t1988 = getelementptr inbounds %Statement, %Statement* %t1966, i32 0, i32 1
  %t1989 = bitcast [24 x i8]* %t1988 to i8*
  %t1990 = getelementptr inbounds i8, i8* %t1989, i64 8
  %t1991 = bitcast i8* %t1990 to %Block**
  %t1992 = load %Block*, %Block** %t1991
  %t1993 = icmp eq i32 %t1965, 7
  %t1994 = select i1 %t1993, %Block* %t1992, %Block* %t1987
  %t1995 = getelementptr inbounds %Statement, %Statement* %t1966, i32 0, i32 1
  %t1996 = bitcast [40 x i8]* %t1995 to i8*
  %t1997 = getelementptr inbounds i8, i8* %t1996, i64 24
  %t1998 = bitcast i8* %t1997 to %Block**
  %t1999 = load %Block*, %Block** %t1998
  %t2000 = icmp eq i32 %t1965, 12
  %t2001 = select i1 %t2000, %Block* %t1999, %Block* %t1994
  %t2002 = getelementptr inbounds %Statement, %Statement* %t1966, i32 0, i32 1
  %t2003 = bitcast [24 x i8]* %t2002 to i8*
  %t2004 = getelementptr inbounds i8, i8* %t2003, i64 8
  %t2005 = bitcast i8* %t2004 to %Block**
  %t2006 = load %Block*, %Block** %t2005
  %t2007 = icmp eq i32 %t1965, 13
  %t2008 = select i1 %t2007, %Block* %t2006, %Block* %t2001
  %t2009 = getelementptr inbounds %Statement, %Statement* %t1966, i32 0, i32 1
  %t2010 = bitcast [24 x i8]* %t2009 to i8*
  %t2011 = getelementptr inbounds i8, i8* %t2010, i64 8
  %t2012 = bitcast i8* %t2011 to %Block**
  %t2013 = load %Block*, %Block** %t2012
  %t2014 = icmp eq i32 %t1965, 14
  %t2015 = select i1 %t2014, %Block* %t2013, %Block* %t2008
  %t2016 = getelementptr inbounds %Statement, %Statement* %t1966, i32 0, i32 1
  %t2017 = bitcast [16 x i8]* %t2016 to i8*
  %t2018 = bitcast i8* %t2017 to %Block**
  %t2019 = load %Block*, %Block** %t2018
  %t2020 = icmp eq i32 %t1965, 15
  %t2021 = select i1 %t2020, %Block* %t2019, %Block* %t2015
  %t2022 = alloca [0 x double]
  %t2023 = getelementptr [0 x double], [0 x double]* %t2022, i32 0, i32 0
  %t2024 = alloca { double*, i64 }
  %t2025 = getelementptr { double*, i64 }, { double*, i64 }* %t2024, i32 0, i32 0
  store double* %t2023, double** %t2025
  %t2026 = getelementptr { double*, i64 }, { double*, i64 }* %t2024, i32 0, i32 1
  store i64 0, i64* %t2026
  %t2027 = load %Block, %Block* %t2021
  %t2028 = bitcast { double*, i64 }* %t2024 to { %SymbolEntry*, i64 }*
  %t2029 = call { %Diagnostic*, i64 }* @check_block(%Block %t2027, { %SymbolEntry*, i64 }* %t2028, { %Statement*, i64 }* %interfaces)
  %t2030 = bitcast { %Diagnostic**, i64 }* %t1964 to { i8**, i64 }*
  %t2031 = bitcast { %Diagnostic*, i64 }* %t2029 to { i8**, i64 }*
  %t2032 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2030, { i8**, i64 }* %t2031)
  store { i8**, i64 }* %t2032, { i8**, i64 }** %l18
  %t2033 = load %ScopeResult, %ScopeResult* %l17
  %t2034 = extractvalue %ScopeResult %t2033, 0
  %t2035 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2034, 0
  %t2036 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t2037 = bitcast { i8**, i64 }* %t2036 to { %Diagnostic**, i64 }*
  %t2038 = insertvalue %ScopeResult %t2035, { %Diagnostic**, i64 }* %t2037, 1
  ret %ScopeResult %t2038
merge23:
  %t2039 = extractvalue %Statement %statement, 0
  %t2040 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2041 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2042 = icmp eq i32 %t2039, 0
  %t2043 = select i1 %t2042, i8* %t2041, i8* %t2040
  %t2044 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2045 = icmp eq i32 %t2039, 1
  %t2046 = select i1 %t2045, i8* %t2044, i8* %t2043
  %t2047 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2048 = icmp eq i32 %t2039, 2
  %t2049 = select i1 %t2048, i8* %t2047, i8* %t2046
  %t2050 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2051 = icmp eq i32 %t2039, 3
  %t2052 = select i1 %t2051, i8* %t2050, i8* %t2049
  %t2053 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2054 = icmp eq i32 %t2039, 4
  %t2055 = select i1 %t2054, i8* %t2053, i8* %t2052
  %t2056 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2057 = icmp eq i32 %t2039, 5
  %t2058 = select i1 %t2057, i8* %t2056, i8* %t2055
  %t2059 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2060 = icmp eq i32 %t2039, 6
  %t2061 = select i1 %t2060, i8* %t2059, i8* %t2058
  %t2062 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2063 = icmp eq i32 %t2039, 7
  %t2064 = select i1 %t2063, i8* %t2062, i8* %t2061
  %t2065 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2066 = icmp eq i32 %t2039, 8
  %t2067 = select i1 %t2066, i8* %t2065, i8* %t2064
  %t2068 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2069 = icmp eq i32 %t2039, 9
  %t2070 = select i1 %t2069, i8* %t2068, i8* %t2067
  %t2071 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2072 = icmp eq i32 %t2039, 10
  %t2073 = select i1 %t2072, i8* %t2071, i8* %t2070
  %t2074 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2075 = icmp eq i32 %t2039, 11
  %t2076 = select i1 %t2075, i8* %t2074, i8* %t2073
  %t2077 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2078 = icmp eq i32 %t2039, 12
  %t2079 = select i1 %t2078, i8* %t2077, i8* %t2076
  %t2080 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2081 = icmp eq i32 %t2039, 13
  %t2082 = select i1 %t2081, i8* %t2080, i8* %t2079
  %t2083 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2084 = icmp eq i32 %t2039, 14
  %t2085 = select i1 %t2084, i8* %t2083, i8* %t2082
  %t2086 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2087 = icmp eq i32 %t2039, 15
  %t2088 = select i1 %t2087, i8* %t2086, i8* %t2085
  %t2089 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2090 = icmp eq i32 %t2039, 16
  %t2091 = select i1 %t2090, i8* %t2089, i8* %t2088
  %t2092 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2093 = icmp eq i32 %t2039, 17
  %t2094 = select i1 %t2093, i8* %t2092, i8* %t2091
  %t2095 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2096 = icmp eq i32 %t2039, 18
  %t2097 = select i1 %t2096, i8* %t2095, i8* %t2094
  %t2098 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2099 = icmp eq i32 %t2039, 19
  %t2100 = select i1 %t2099, i8* %t2098, i8* %t2097
  %t2101 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2102 = icmp eq i32 %t2039, 20
  %t2103 = select i1 %t2102, i8* %t2101, i8* %t2100
  %t2104 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2105 = icmp eq i32 %t2039, 21
  %t2106 = select i1 %t2105, i8* %t2104, i8* %t2103
  %t2107 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2108 = icmp eq i32 %t2039, 22
  %t2109 = select i1 %t2108, i8* %t2107, i8* %t2106
  %s2110 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.2110, i32 0, i32 0
  %t2111 = icmp eq i8* %t2109, %s2110
  br i1 %t2111, label %then24, label %merge25
then24:
  %t2112 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2113 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2112, 0
  %t2114 = extractvalue %Statement %statement, 0
  %t2115 = alloca %Statement
  store %Statement %statement, %Statement* %t2115
  %t2116 = getelementptr inbounds %Statement, %Statement* %t2115, i32 0, i32 1
  %t2117 = bitcast [24 x i8]* %t2116 to i8*
  %t2118 = getelementptr inbounds i8, i8* %t2117, i64 8
  %t2119 = bitcast i8* %t2118 to %Block**
  %t2120 = load %Block*, %Block** %t2119
  %t2121 = icmp eq i32 %t2114, 4
  %t2122 = select i1 %t2121, %Block* %t2120, %Block* null
  %t2123 = getelementptr inbounds %Statement, %Statement* %t2115, i32 0, i32 1
  %t2124 = bitcast [24 x i8]* %t2123 to i8*
  %t2125 = getelementptr inbounds i8, i8* %t2124, i64 8
  %t2126 = bitcast i8* %t2125 to %Block**
  %t2127 = load %Block*, %Block** %t2126
  %t2128 = icmp eq i32 %t2114, 5
  %t2129 = select i1 %t2128, %Block* %t2127, %Block* %t2122
  %t2130 = getelementptr inbounds %Statement, %Statement* %t2115, i32 0, i32 1
  %t2131 = bitcast [40 x i8]* %t2130 to i8*
  %t2132 = getelementptr inbounds i8, i8* %t2131, i64 16
  %t2133 = bitcast i8* %t2132 to %Block**
  %t2134 = load %Block*, %Block** %t2133
  %t2135 = icmp eq i32 %t2114, 6
  %t2136 = select i1 %t2135, %Block* %t2134, %Block* %t2129
  %t2137 = getelementptr inbounds %Statement, %Statement* %t2115, i32 0, i32 1
  %t2138 = bitcast [24 x i8]* %t2137 to i8*
  %t2139 = getelementptr inbounds i8, i8* %t2138, i64 8
  %t2140 = bitcast i8* %t2139 to %Block**
  %t2141 = load %Block*, %Block** %t2140
  %t2142 = icmp eq i32 %t2114, 7
  %t2143 = select i1 %t2142, %Block* %t2141, %Block* %t2136
  %t2144 = getelementptr inbounds %Statement, %Statement* %t2115, i32 0, i32 1
  %t2145 = bitcast [40 x i8]* %t2144 to i8*
  %t2146 = getelementptr inbounds i8, i8* %t2145, i64 24
  %t2147 = bitcast i8* %t2146 to %Block**
  %t2148 = load %Block*, %Block** %t2147
  %t2149 = icmp eq i32 %t2114, 12
  %t2150 = select i1 %t2149, %Block* %t2148, %Block* %t2143
  %t2151 = getelementptr inbounds %Statement, %Statement* %t2115, i32 0, i32 1
  %t2152 = bitcast [24 x i8]* %t2151 to i8*
  %t2153 = getelementptr inbounds i8, i8* %t2152, i64 8
  %t2154 = bitcast i8* %t2153 to %Block**
  %t2155 = load %Block*, %Block** %t2154
  %t2156 = icmp eq i32 %t2114, 13
  %t2157 = select i1 %t2156, %Block* %t2155, %Block* %t2150
  %t2158 = getelementptr inbounds %Statement, %Statement* %t2115, i32 0, i32 1
  %t2159 = bitcast [24 x i8]* %t2158 to i8*
  %t2160 = getelementptr inbounds i8, i8* %t2159, i64 8
  %t2161 = bitcast i8* %t2160 to %Block**
  %t2162 = load %Block*, %Block** %t2161
  %t2163 = icmp eq i32 %t2114, 14
  %t2164 = select i1 %t2163, %Block* %t2162, %Block* %t2157
  %t2165 = getelementptr inbounds %Statement, %Statement* %t2115, i32 0, i32 1
  %t2166 = bitcast [16 x i8]* %t2165 to i8*
  %t2167 = bitcast i8* %t2166 to %Block**
  %t2168 = load %Block*, %Block** %t2167
  %t2169 = icmp eq i32 %t2114, 15
  %t2170 = select i1 %t2169, %Block* %t2168, %Block* %t2164
  %t2171 = load %Block, %Block* %t2170
  %t2172 = call { %Diagnostic*, i64 }* @check_block(%Block %t2171, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2173 = bitcast { %Diagnostic*, i64 }* %t2172 to { %Diagnostic**, i64 }*
  %t2174 = insertvalue %ScopeResult %t2113, { %Diagnostic**, i64 }* %t2173, 1
  ret %ScopeResult %t2174
merge25:
  %t2175 = extractvalue %Statement %statement, 0
  %t2176 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2177 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2178 = icmp eq i32 %t2175, 0
  %t2179 = select i1 %t2178, i8* %t2177, i8* %t2176
  %t2180 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2181 = icmp eq i32 %t2175, 1
  %t2182 = select i1 %t2181, i8* %t2180, i8* %t2179
  %t2183 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2184 = icmp eq i32 %t2175, 2
  %t2185 = select i1 %t2184, i8* %t2183, i8* %t2182
  %t2186 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2187 = icmp eq i32 %t2175, 3
  %t2188 = select i1 %t2187, i8* %t2186, i8* %t2185
  %t2189 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2190 = icmp eq i32 %t2175, 4
  %t2191 = select i1 %t2190, i8* %t2189, i8* %t2188
  %t2192 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2193 = icmp eq i32 %t2175, 5
  %t2194 = select i1 %t2193, i8* %t2192, i8* %t2191
  %t2195 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2196 = icmp eq i32 %t2175, 6
  %t2197 = select i1 %t2196, i8* %t2195, i8* %t2194
  %t2198 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2199 = icmp eq i32 %t2175, 7
  %t2200 = select i1 %t2199, i8* %t2198, i8* %t2197
  %t2201 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2202 = icmp eq i32 %t2175, 8
  %t2203 = select i1 %t2202, i8* %t2201, i8* %t2200
  %t2204 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2205 = icmp eq i32 %t2175, 9
  %t2206 = select i1 %t2205, i8* %t2204, i8* %t2203
  %t2207 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2208 = icmp eq i32 %t2175, 10
  %t2209 = select i1 %t2208, i8* %t2207, i8* %t2206
  %t2210 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2211 = icmp eq i32 %t2175, 11
  %t2212 = select i1 %t2211, i8* %t2210, i8* %t2209
  %t2213 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2214 = icmp eq i32 %t2175, 12
  %t2215 = select i1 %t2214, i8* %t2213, i8* %t2212
  %t2216 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2217 = icmp eq i32 %t2175, 13
  %t2218 = select i1 %t2217, i8* %t2216, i8* %t2215
  %t2219 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2220 = icmp eq i32 %t2175, 14
  %t2221 = select i1 %t2220, i8* %t2219, i8* %t2218
  %t2222 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2223 = icmp eq i32 %t2175, 15
  %t2224 = select i1 %t2223, i8* %t2222, i8* %t2221
  %t2225 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2226 = icmp eq i32 %t2175, 16
  %t2227 = select i1 %t2226, i8* %t2225, i8* %t2224
  %t2228 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2229 = icmp eq i32 %t2175, 17
  %t2230 = select i1 %t2229, i8* %t2228, i8* %t2227
  %t2231 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2232 = icmp eq i32 %t2175, 18
  %t2233 = select i1 %t2232, i8* %t2231, i8* %t2230
  %t2234 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2235 = icmp eq i32 %t2175, 19
  %t2236 = select i1 %t2235, i8* %t2234, i8* %t2233
  %t2237 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2238 = icmp eq i32 %t2175, 20
  %t2239 = select i1 %t2238, i8* %t2237, i8* %t2236
  %t2240 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2241 = icmp eq i32 %t2175, 21
  %t2242 = select i1 %t2241, i8* %t2240, i8* %t2239
  %t2243 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2244 = icmp eq i32 %t2175, 22
  %t2245 = select i1 %t2244, i8* %t2243, i8* %t2242
  %s2246 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.2246, i32 0, i32 0
  %t2247 = icmp eq i8* %t2245, %s2246
  br i1 %t2247, label %then26, label %merge27
then26:
  %t2248 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2249 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2248, 0
  %t2250 = extractvalue %Statement %statement, 0
  %t2251 = alloca %Statement
  store %Statement %statement, %Statement* %t2251
  %t2252 = getelementptr inbounds %Statement, %Statement* %t2251, i32 0, i32 1
  %t2253 = bitcast [24 x i8]* %t2252 to i8*
  %t2254 = getelementptr inbounds i8, i8* %t2253, i64 8
  %t2255 = bitcast i8* %t2254 to %Block**
  %t2256 = load %Block*, %Block** %t2255
  %t2257 = icmp eq i32 %t2250, 4
  %t2258 = select i1 %t2257, %Block* %t2256, %Block* null
  %t2259 = getelementptr inbounds %Statement, %Statement* %t2251, i32 0, i32 1
  %t2260 = bitcast [24 x i8]* %t2259 to i8*
  %t2261 = getelementptr inbounds i8, i8* %t2260, i64 8
  %t2262 = bitcast i8* %t2261 to %Block**
  %t2263 = load %Block*, %Block** %t2262
  %t2264 = icmp eq i32 %t2250, 5
  %t2265 = select i1 %t2264, %Block* %t2263, %Block* %t2258
  %t2266 = getelementptr inbounds %Statement, %Statement* %t2251, i32 0, i32 1
  %t2267 = bitcast [40 x i8]* %t2266 to i8*
  %t2268 = getelementptr inbounds i8, i8* %t2267, i64 16
  %t2269 = bitcast i8* %t2268 to %Block**
  %t2270 = load %Block*, %Block** %t2269
  %t2271 = icmp eq i32 %t2250, 6
  %t2272 = select i1 %t2271, %Block* %t2270, %Block* %t2265
  %t2273 = getelementptr inbounds %Statement, %Statement* %t2251, i32 0, i32 1
  %t2274 = bitcast [24 x i8]* %t2273 to i8*
  %t2275 = getelementptr inbounds i8, i8* %t2274, i64 8
  %t2276 = bitcast i8* %t2275 to %Block**
  %t2277 = load %Block*, %Block** %t2276
  %t2278 = icmp eq i32 %t2250, 7
  %t2279 = select i1 %t2278, %Block* %t2277, %Block* %t2272
  %t2280 = getelementptr inbounds %Statement, %Statement* %t2251, i32 0, i32 1
  %t2281 = bitcast [40 x i8]* %t2280 to i8*
  %t2282 = getelementptr inbounds i8, i8* %t2281, i64 24
  %t2283 = bitcast i8* %t2282 to %Block**
  %t2284 = load %Block*, %Block** %t2283
  %t2285 = icmp eq i32 %t2250, 12
  %t2286 = select i1 %t2285, %Block* %t2284, %Block* %t2279
  %t2287 = getelementptr inbounds %Statement, %Statement* %t2251, i32 0, i32 1
  %t2288 = bitcast [24 x i8]* %t2287 to i8*
  %t2289 = getelementptr inbounds i8, i8* %t2288, i64 8
  %t2290 = bitcast i8* %t2289 to %Block**
  %t2291 = load %Block*, %Block** %t2290
  %t2292 = icmp eq i32 %t2250, 13
  %t2293 = select i1 %t2292, %Block* %t2291, %Block* %t2286
  %t2294 = getelementptr inbounds %Statement, %Statement* %t2251, i32 0, i32 1
  %t2295 = bitcast [24 x i8]* %t2294 to i8*
  %t2296 = getelementptr inbounds i8, i8* %t2295, i64 8
  %t2297 = bitcast i8* %t2296 to %Block**
  %t2298 = load %Block*, %Block** %t2297
  %t2299 = icmp eq i32 %t2250, 14
  %t2300 = select i1 %t2299, %Block* %t2298, %Block* %t2293
  %t2301 = getelementptr inbounds %Statement, %Statement* %t2251, i32 0, i32 1
  %t2302 = bitcast [16 x i8]* %t2301 to i8*
  %t2303 = bitcast i8* %t2302 to %Block**
  %t2304 = load %Block*, %Block** %t2303
  %t2305 = icmp eq i32 %t2250, 15
  %t2306 = select i1 %t2305, %Block* %t2304, %Block* %t2300
  %t2307 = load %Block, %Block* %t2306
  %t2308 = call { %Diagnostic*, i64 }* @check_block(%Block %t2307, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2309 = bitcast { %Diagnostic*, i64 }* %t2308 to { %Diagnostic**, i64 }*
  %t2310 = insertvalue %ScopeResult %t2249, { %Diagnostic**, i64 }* %t2309, 1
  ret %ScopeResult %t2310
merge27:
  %t2311 = extractvalue %Statement %statement, 0
  %t2312 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2313 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2314 = icmp eq i32 %t2311, 0
  %t2315 = select i1 %t2314, i8* %t2313, i8* %t2312
  %t2316 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2317 = icmp eq i32 %t2311, 1
  %t2318 = select i1 %t2317, i8* %t2316, i8* %t2315
  %t2319 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2320 = icmp eq i32 %t2311, 2
  %t2321 = select i1 %t2320, i8* %t2319, i8* %t2318
  %t2322 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2323 = icmp eq i32 %t2311, 3
  %t2324 = select i1 %t2323, i8* %t2322, i8* %t2321
  %t2325 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2326 = icmp eq i32 %t2311, 4
  %t2327 = select i1 %t2326, i8* %t2325, i8* %t2324
  %t2328 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2329 = icmp eq i32 %t2311, 5
  %t2330 = select i1 %t2329, i8* %t2328, i8* %t2327
  %t2331 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2332 = icmp eq i32 %t2311, 6
  %t2333 = select i1 %t2332, i8* %t2331, i8* %t2330
  %t2334 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2335 = icmp eq i32 %t2311, 7
  %t2336 = select i1 %t2335, i8* %t2334, i8* %t2333
  %t2337 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2338 = icmp eq i32 %t2311, 8
  %t2339 = select i1 %t2338, i8* %t2337, i8* %t2336
  %t2340 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2341 = icmp eq i32 %t2311, 9
  %t2342 = select i1 %t2341, i8* %t2340, i8* %t2339
  %t2343 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2344 = icmp eq i32 %t2311, 10
  %t2345 = select i1 %t2344, i8* %t2343, i8* %t2342
  %t2346 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2347 = icmp eq i32 %t2311, 11
  %t2348 = select i1 %t2347, i8* %t2346, i8* %t2345
  %t2349 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2350 = icmp eq i32 %t2311, 12
  %t2351 = select i1 %t2350, i8* %t2349, i8* %t2348
  %t2352 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2353 = icmp eq i32 %t2311, 13
  %t2354 = select i1 %t2353, i8* %t2352, i8* %t2351
  %t2355 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2356 = icmp eq i32 %t2311, 14
  %t2357 = select i1 %t2356, i8* %t2355, i8* %t2354
  %t2358 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2359 = icmp eq i32 %t2311, 15
  %t2360 = select i1 %t2359, i8* %t2358, i8* %t2357
  %t2361 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2362 = icmp eq i32 %t2311, 16
  %t2363 = select i1 %t2362, i8* %t2361, i8* %t2360
  %t2364 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2365 = icmp eq i32 %t2311, 17
  %t2366 = select i1 %t2365, i8* %t2364, i8* %t2363
  %t2367 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2368 = icmp eq i32 %t2311, 18
  %t2369 = select i1 %t2368, i8* %t2367, i8* %t2366
  %t2370 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2371 = icmp eq i32 %t2311, 19
  %t2372 = select i1 %t2371, i8* %t2370, i8* %t2369
  %t2373 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2374 = icmp eq i32 %t2311, 20
  %t2375 = select i1 %t2374, i8* %t2373, i8* %t2372
  %t2376 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2377 = icmp eq i32 %t2311, 21
  %t2378 = select i1 %t2377, i8* %t2376, i8* %t2375
  %t2379 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2380 = icmp eq i32 %t2311, 22
  %t2381 = select i1 %t2380, i8* %t2379, i8* %t2378
  %s2382 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.2382, i32 0, i32 0
  %t2383 = icmp eq i8* %t2381, %s2382
  br i1 %t2383, label %then28, label %merge29
then28:
  %t2384 = alloca [0 x %Diagnostic]
  %t2385 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t2384, i32 0, i32 0
  %t2386 = alloca { %Diagnostic*, i64 }
  %t2387 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2386, i32 0, i32 0
  store %Diagnostic* %t2385, %Diagnostic** %t2387
  %t2388 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2386, i32 0, i32 1
  store i64 0, i64* %t2388
  store { %Diagnostic*, i64 }* %t2386, { %Diagnostic*, i64 }** %l19
  %t2389 = sitofp i64 0 to double
  store double %t2389, double* %l20
  %t2390 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2391 = load double, double* %l20
  br label %loop.header30
loop.header30:
  %t2440 = phi { %Diagnostic*, i64 }* [ %t2390, %then28 ], [ %t2438, %loop.latch32 ]
  %t2441 = phi double [ %t2391, %then28 ], [ %t2439, %loop.latch32 ]
  store { %Diagnostic*, i64 }* %t2440, { %Diagnostic*, i64 }** %l19
  store double %t2441, double* %l20
  br label %loop.body31
loop.body31:
  %t2392 = load double, double* %l20
  %t2393 = extractvalue %Statement %statement, 0
  %t2394 = alloca %Statement
  store %Statement %statement, %Statement* %t2394
  %t2395 = getelementptr inbounds %Statement, %Statement* %t2394, i32 0, i32 1
  %t2396 = bitcast [24 x i8]* %t2395 to i8*
  %t2397 = getelementptr inbounds i8, i8* %t2396, i64 8
  %t2398 = bitcast i8* %t2397 to { %MatchCase**, i64 }**
  %t2399 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t2398
  %t2400 = icmp eq i32 %t2393, 18
  %t2401 = select i1 %t2400, { %MatchCase**, i64 }* %t2399, { %MatchCase**, i64 }* null
  %t2402 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t2401
  %t2403 = extractvalue { %MatchCase**, i64 } %t2402, 1
  %t2404 = sitofp i64 %t2403 to double
  %t2405 = fcmp oge double %t2392, %t2404
  %t2406 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2407 = load double, double* %l20
  br i1 %t2405, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t2408 = extractvalue %Statement %statement, 0
  %t2409 = alloca %Statement
  store %Statement %statement, %Statement* %t2409
  %t2410 = getelementptr inbounds %Statement, %Statement* %t2409, i32 0, i32 1
  %t2411 = bitcast [24 x i8]* %t2410 to i8*
  %t2412 = getelementptr inbounds i8, i8* %t2411, i64 8
  %t2413 = bitcast i8* %t2412 to { %MatchCase**, i64 }**
  %t2414 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t2413
  %t2415 = icmp eq i32 %t2408, 18
  %t2416 = select i1 %t2415, { %MatchCase**, i64 }* %t2414, { %MatchCase**, i64 }* null
  %t2417 = load double, double* %l20
  %t2418 = fptosi double %t2417 to i64
  %t2419 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t2416
  %t2420 = extractvalue { %MatchCase**, i64 } %t2419, 0
  %t2421 = extractvalue { %MatchCase**, i64 } %t2419, 1
  %t2422 = icmp uge i64 %t2418, %t2421
  ; bounds check: %t2422 (if true, out of bounds)
  %t2423 = getelementptr %MatchCase*, %MatchCase** %t2420, i64 %t2418
  %t2424 = load %MatchCase*, %MatchCase** %t2423
  store %MatchCase* %t2424, %MatchCase** %l21
  %t2425 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2426 = load %MatchCase*, %MatchCase** %l21
  %t2427 = getelementptr %MatchCase, %MatchCase* %t2426, i32 0, i32 2
  %t2428 = load %Block*, %Block** %t2427
  %t2429 = load %Block, %Block* %t2428
  %t2430 = call { %Diagnostic*, i64 }* @check_block(%Block %t2429, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2431 = bitcast { %Diagnostic*, i64 }* %t2425 to { i8**, i64 }*
  %t2432 = bitcast { %Diagnostic*, i64 }* %t2430 to { i8**, i64 }*
  %t2433 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2431, { i8**, i64 }* %t2432)
  %t2434 = bitcast { i8**, i64 }* %t2433 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t2434, { %Diagnostic*, i64 }** %l19
  %t2435 = load double, double* %l20
  %t2436 = sitofp i64 1 to double
  %t2437 = fadd double %t2435, %t2436
  store double %t2437, double* %l20
  br label %loop.latch32
loop.latch32:
  %t2438 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2439 = load double, double* %l20
  br label %loop.header30
afterloop33:
  %t2442 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2443 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2442, 0
  %t2444 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2445 = bitcast { %Diagnostic*, i64 }* %t2444 to { %Diagnostic**, i64 }*
  %t2446 = insertvalue %ScopeResult %t2443, { %Diagnostic**, i64 }* %t2445, 1
  ret %ScopeResult %t2446
merge29:
  %t2447 = extractvalue %Statement %statement, 0
  %t2448 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2449 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2450 = icmp eq i32 %t2447, 0
  %t2451 = select i1 %t2450, i8* %t2449, i8* %t2448
  %t2452 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2453 = icmp eq i32 %t2447, 1
  %t2454 = select i1 %t2453, i8* %t2452, i8* %t2451
  %t2455 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2456 = icmp eq i32 %t2447, 2
  %t2457 = select i1 %t2456, i8* %t2455, i8* %t2454
  %t2458 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2459 = icmp eq i32 %t2447, 3
  %t2460 = select i1 %t2459, i8* %t2458, i8* %t2457
  %t2461 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2462 = icmp eq i32 %t2447, 4
  %t2463 = select i1 %t2462, i8* %t2461, i8* %t2460
  %t2464 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2465 = icmp eq i32 %t2447, 5
  %t2466 = select i1 %t2465, i8* %t2464, i8* %t2463
  %t2467 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2468 = icmp eq i32 %t2447, 6
  %t2469 = select i1 %t2468, i8* %t2467, i8* %t2466
  %t2470 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2471 = icmp eq i32 %t2447, 7
  %t2472 = select i1 %t2471, i8* %t2470, i8* %t2469
  %t2473 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2474 = icmp eq i32 %t2447, 8
  %t2475 = select i1 %t2474, i8* %t2473, i8* %t2472
  %t2476 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2477 = icmp eq i32 %t2447, 9
  %t2478 = select i1 %t2477, i8* %t2476, i8* %t2475
  %t2479 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2480 = icmp eq i32 %t2447, 10
  %t2481 = select i1 %t2480, i8* %t2479, i8* %t2478
  %t2482 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2483 = icmp eq i32 %t2447, 11
  %t2484 = select i1 %t2483, i8* %t2482, i8* %t2481
  %t2485 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2486 = icmp eq i32 %t2447, 12
  %t2487 = select i1 %t2486, i8* %t2485, i8* %t2484
  %t2488 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2489 = icmp eq i32 %t2447, 13
  %t2490 = select i1 %t2489, i8* %t2488, i8* %t2487
  %t2491 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2492 = icmp eq i32 %t2447, 14
  %t2493 = select i1 %t2492, i8* %t2491, i8* %t2490
  %t2494 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2495 = icmp eq i32 %t2447, 15
  %t2496 = select i1 %t2495, i8* %t2494, i8* %t2493
  %t2497 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2498 = icmp eq i32 %t2447, 16
  %t2499 = select i1 %t2498, i8* %t2497, i8* %t2496
  %t2500 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2501 = icmp eq i32 %t2447, 17
  %t2502 = select i1 %t2501, i8* %t2500, i8* %t2499
  %t2503 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2504 = icmp eq i32 %t2447, 18
  %t2505 = select i1 %t2504, i8* %t2503, i8* %t2502
  %t2506 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2507 = icmp eq i32 %t2447, 19
  %t2508 = select i1 %t2507, i8* %t2506, i8* %t2505
  %t2509 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2510 = icmp eq i32 %t2447, 20
  %t2511 = select i1 %t2510, i8* %t2509, i8* %t2508
  %t2512 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2513 = icmp eq i32 %t2447, 21
  %t2514 = select i1 %t2513, i8* %t2512, i8* %t2511
  %t2515 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2516 = icmp eq i32 %t2447, 22
  %t2517 = select i1 %t2516, i8* %t2515, i8* %t2514
  %s2518 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.2518, i32 0, i32 0
  %t2519 = icmp eq i8* %t2517, %s2518
  br i1 %t2519, label %then36, label %merge37
then36:
  %t2520 = extractvalue %Statement %statement, 0
  %t2521 = alloca %Statement
  store %Statement %statement, %Statement* %t2521
  %t2522 = getelementptr inbounds %Statement, %Statement* %t2521, i32 0, i32 1
  %t2523 = bitcast [32 x i8]* %t2522 to i8*
  %t2524 = getelementptr inbounds i8, i8* %t2523, i64 8
  %t2525 = bitcast i8* %t2524 to %Block**
  %t2526 = load %Block*, %Block** %t2525
  %t2527 = icmp eq i32 %t2520, 19
  %t2528 = select i1 %t2527, %Block* %t2526, %Block* null
  %t2529 = load %Block, %Block* %t2528
  %t2530 = call { %Diagnostic*, i64 }* @check_block(%Block %t2529, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t2530, { %Diagnostic*, i64 }** %l22
  %t2531 = extractvalue %Statement %statement, 0
  %t2532 = alloca %Statement
  store %Statement %statement, %Statement* %t2532
  %t2533 = getelementptr inbounds %Statement, %Statement* %t2532, i32 0, i32 1
  %t2534 = bitcast [32 x i8]* %t2533 to i8*
  %t2535 = getelementptr inbounds i8, i8* %t2534, i64 16
  %t2536 = bitcast i8* %t2535 to %ElseBranch**
  %t2537 = load %ElseBranch*, %ElseBranch** %t2536
  %t2538 = icmp eq i32 %t2531, 19
  %t2539 = select i1 %t2538, %ElseBranch* %t2537, %ElseBranch* null
  %t2540 = bitcast i8* null to %ElseBranch*
  %t2541 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2542 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2541, 0
  %t2543 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2544 = bitcast { %Diagnostic*, i64 }* %t2543 to { %Diagnostic**, i64 }*
  %t2545 = insertvalue %ScopeResult %t2542, { %Diagnostic**, i64 }* %t2544, 1
  ret %ScopeResult %t2545
merge37:
  %t2546 = extractvalue %Statement %statement, 0
  %t2547 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2548 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2549 = icmp eq i32 %t2546, 0
  %t2550 = select i1 %t2549, i8* %t2548, i8* %t2547
  %t2551 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2552 = icmp eq i32 %t2546, 1
  %t2553 = select i1 %t2552, i8* %t2551, i8* %t2550
  %t2554 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2555 = icmp eq i32 %t2546, 2
  %t2556 = select i1 %t2555, i8* %t2554, i8* %t2553
  %t2557 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2558 = icmp eq i32 %t2546, 3
  %t2559 = select i1 %t2558, i8* %t2557, i8* %t2556
  %t2560 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2561 = icmp eq i32 %t2546, 4
  %t2562 = select i1 %t2561, i8* %t2560, i8* %t2559
  %t2563 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2564 = icmp eq i32 %t2546, 5
  %t2565 = select i1 %t2564, i8* %t2563, i8* %t2562
  %t2566 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2567 = icmp eq i32 %t2546, 6
  %t2568 = select i1 %t2567, i8* %t2566, i8* %t2565
  %t2569 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2570 = icmp eq i32 %t2546, 7
  %t2571 = select i1 %t2570, i8* %t2569, i8* %t2568
  %t2572 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2573 = icmp eq i32 %t2546, 8
  %t2574 = select i1 %t2573, i8* %t2572, i8* %t2571
  %t2575 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2576 = icmp eq i32 %t2546, 9
  %t2577 = select i1 %t2576, i8* %t2575, i8* %t2574
  %t2578 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2579 = icmp eq i32 %t2546, 10
  %t2580 = select i1 %t2579, i8* %t2578, i8* %t2577
  %t2581 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2582 = icmp eq i32 %t2546, 11
  %t2583 = select i1 %t2582, i8* %t2581, i8* %t2580
  %t2584 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2585 = icmp eq i32 %t2546, 12
  %t2586 = select i1 %t2585, i8* %t2584, i8* %t2583
  %t2587 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2588 = icmp eq i32 %t2546, 13
  %t2589 = select i1 %t2588, i8* %t2587, i8* %t2586
  %t2590 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2591 = icmp eq i32 %t2546, 14
  %t2592 = select i1 %t2591, i8* %t2590, i8* %t2589
  %t2593 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2594 = icmp eq i32 %t2546, 15
  %t2595 = select i1 %t2594, i8* %t2593, i8* %t2592
  %t2596 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2597 = icmp eq i32 %t2546, 16
  %t2598 = select i1 %t2597, i8* %t2596, i8* %t2595
  %t2599 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2600 = icmp eq i32 %t2546, 17
  %t2601 = select i1 %t2600, i8* %t2599, i8* %t2598
  %t2602 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2603 = icmp eq i32 %t2546, 18
  %t2604 = select i1 %t2603, i8* %t2602, i8* %t2601
  %t2605 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2606 = icmp eq i32 %t2546, 19
  %t2607 = select i1 %t2606, i8* %t2605, i8* %t2604
  %t2608 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2609 = icmp eq i32 %t2546, 20
  %t2610 = select i1 %t2609, i8* %t2608, i8* %t2607
  %t2611 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2612 = icmp eq i32 %t2546, 21
  %t2613 = select i1 %t2612, i8* %t2611, i8* %t2610
  %t2614 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2615 = icmp eq i32 %t2546, 22
  %t2616 = select i1 %t2615, i8* %t2614, i8* %t2613
  %s2617 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.2617, i32 0, i32 0
  %t2618 = icmp eq i8* %t2616, %s2617
  br i1 %t2618, label %then38, label %merge39
then38:
  %t2619 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2620 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2619, 0
  %t2621 = extractvalue %Statement %statement, 0
  %t2622 = alloca %Statement
  store %Statement %statement, %Statement* %t2622
  %t2623 = getelementptr inbounds %Statement, %Statement* %t2622, i32 0, i32 1
  %t2624 = bitcast [24 x i8]* %t2623 to i8*
  %t2625 = getelementptr inbounds i8, i8* %t2624, i64 8
  %t2626 = bitcast i8* %t2625 to %Block**
  %t2627 = load %Block*, %Block** %t2626
  %t2628 = icmp eq i32 %t2621, 4
  %t2629 = select i1 %t2628, %Block* %t2627, %Block* null
  %t2630 = getelementptr inbounds %Statement, %Statement* %t2622, i32 0, i32 1
  %t2631 = bitcast [24 x i8]* %t2630 to i8*
  %t2632 = getelementptr inbounds i8, i8* %t2631, i64 8
  %t2633 = bitcast i8* %t2632 to %Block**
  %t2634 = load %Block*, %Block** %t2633
  %t2635 = icmp eq i32 %t2621, 5
  %t2636 = select i1 %t2635, %Block* %t2634, %Block* %t2629
  %t2637 = getelementptr inbounds %Statement, %Statement* %t2622, i32 0, i32 1
  %t2638 = bitcast [40 x i8]* %t2637 to i8*
  %t2639 = getelementptr inbounds i8, i8* %t2638, i64 16
  %t2640 = bitcast i8* %t2639 to %Block**
  %t2641 = load %Block*, %Block** %t2640
  %t2642 = icmp eq i32 %t2621, 6
  %t2643 = select i1 %t2642, %Block* %t2641, %Block* %t2636
  %t2644 = getelementptr inbounds %Statement, %Statement* %t2622, i32 0, i32 1
  %t2645 = bitcast [24 x i8]* %t2644 to i8*
  %t2646 = getelementptr inbounds i8, i8* %t2645, i64 8
  %t2647 = bitcast i8* %t2646 to %Block**
  %t2648 = load %Block*, %Block** %t2647
  %t2649 = icmp eq i32 %t2621, 7
  %t2650 = select i1 %t2649, %Block* %t2648, %Block* %t2643
  %t2651 = getelementptr inbounds %Statement, %Statement* %t2622, i32 0, i32 1
  %t2652 = bitcast [40 x i8]* %t2651 to i8*
  %t2653 = getelementptr inbounds i8, i8* %t2652, i64 24
  %t2654 = bitcast i8* %t2653 to %Block**
  %t2655 = load %Block*, %Block** %t2654
  %t2656 = icmp eq i32 %t2621, 12
  %t2657 = select i1 %t2656, %Block* %t2655, %Block* %t2650
  %t2658 = getelementptr inbounds %Statement, %Statement* %t2622, i32 0, i32 1
  %t2659 = bitcast [24 x i8]* %t2658 to i8*
  %t2660 = getelementptr inbounds i8, i8* %t2659, i64 8
  %t2661 = bitcast i8* %t2660 to %Block**
  %t2662 = load %Block*, %Block** %t2661
  %t2663 = icmp eq i32 %t2621, 13
  %t2664 = select i1 %t2663, %Block* %t2662, %Block* %t2657
  %t2665 = getelementptr inbounds %Statement, %Statement* %t2622, i32 0, i32 1
  %t2666 = bitcast [24 x i8]* %t2665 to i8*
  %t2667 = getelementptr inbounds i8, i8* %t2666, i64 8
  %t2668 = bitcast i8* %t2667 to %Block**
  %t2669 = load %Block*, %Block** %t2668
  %t2670 = icmp eq i32 %t2621, 14
  %t2671 = select i1 %t2670, %Block* %t2669, %Block* %t2664
  %t2672 = getelementptr inbounds %Statement, %Statement* %t2622, i32 0, i32 1
  %t2673 = bitcast [16 x i8]* %t2672 to i8*
  %t2674 = bitcast i8* %t2673 to %Block**
  %t2675 = load %Block*, %Block** %t2674
  %t2676 = icmp eq i32 %t2621, 15
  %t2677 = select i1 %t2676, %Block* %t2675, %Block* %t2671
  %t2678 = load %Block, %Block* %t2677
  %t2679 = call { %Diagnostic*, i64 }* @check_block(%Block %t2678, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2680 = bitcast { %Diagnostic*, i64 }* %t2679 to { %Diagnostic**, i64 }*
  %t2681 = insertvalue %ScopeResult %t2620, { %Diagnostic**, i64 }* %t2680, 1
  ret %ScopeResult %t2681
merge39:
  %t2682 = extractvalue %Statement %statement, 0
  %t2683 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2684 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2685 = icmp eq i32 %t2682, 0
  %t2686 = select i1 %t2685, i8* %t2684, i8* %t2683
  %t2687 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2688 = icmp eq i32 %t2682, 1
  %t2689 = select i1 %t2688, i8* %t2687, i8* %t2686
  %t2690 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2691 = icmp eq i32 %t2682, 2
  %t2692 = select i1 %t2691, i8* %t2690, i8* %t2689
  %t2693 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2694 = icmp eq i32 %t2682, 3
  %t2695 = select i1 %t2694, i8* %t2693, i8* %t2692
  %t2696 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2697 = icmp eq i32 %t2682, 4
  %t2698 = select i1 %t2697, i8* %t2696, i8* %t2695
  %t2699 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2700 = icmp eq i32 %t2682, 5
  %t2701 = select i1 %t2700, i8* %t2699, i8* %t2698
  %t2702 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2703 = icmp eq i32 %t2682, 6
  %t2704 = select i1 %t2703, i8* %t2702, i8* %t2701
  %t2705 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2706 = icmp eq i32 %t2682, 7
  %t2707 = select i1 %t2706, i8* %t2705, i8* %t2704
  %t2708 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2709 = icmp eq i32 %t2682, 8
  %t2710 = select i1 %t2709, i8* %t2708, i8* %t2707
  %t2711 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2712 = icmp eq i32 %t2682, 9
  %t2713 = select i1 %t2712, i8* %t2711, i8* %t2710
  %t2714 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2715 = icmp eq i32 %t2682, 10
  %t2716 = select i1 %t2715, i8* %t2714, i8* %t2713
  %t2717 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2718 = icmp eq i32 %t2682, 11
  %t2719 = select i1 %t2718, i8* %t2717, i8* %t2716
  %t2720 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2721 = icmp eq i32 %t2682, 12
  %t2722 = select i1 %t2721, i8* %t2720, i8* %t2719
  %t2723 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2724 = icmp eq i32 %t2682, 13
  %t2725 = select i1 %t2724, i8* %t2723, i8* %t2722
  %t2726 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2727 = icmp eq i32 %t2682, 14
  %t2728 = select i1 %t2727, i8* %t2726, i8* %t2725
  %t2729 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2730 = icmp eq i32 %t2682, 15
  %t2731 = select i1 %t2730, i8* %t2729, i8* %t2728
  %t2732 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2733 = icmp eq i32 %t2682, 16
  %t2734 = select i1 %t2733, i8* %t2732, i8* %t2731
  %t2735 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2736 = icmp eq i32 %t2682, 17
  %t2737 = select i1 %t2736, i8* %t2735, i8* %t2734
  %t2738 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2739 = icmp eq i32 %t2682, 18
  %t2740 = select i1 %t2739, i8* %t2738, i8* %t2737
  %t2741 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2742 = icmp eq i32 %t2682, 19
  %t2743 = select i1 %t2742, i8* %t2741, i8* %t2740
  %t2744 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2745 = icmp eq i32 %t2682, 20
  %t2746 = select i1 %t2745, i8* %t2744, i8* %t2743
  %t2747 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2748 = icmp eq i32 %t2682, 21
  %t2749 = select i1 %t2748, i8* %t2747, i8* %t2746
  %t2750 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2751 = icmp eq i32 %t2682, 22
  %t2752 = select i1 %t2751, i8* %t2750, i8* %t2749
  %s2753 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.2753, i32 0, i32 0
  %t2754 = icmp eq i8* %t2752, %s2753
  br i1 %t2754, label %then40, label %merge41
then40:
  %t2755 = extractvalue %Statement %statement, 0
  %t2756 = alloca %Statement
  store %Statement %statement, %Statement* %t2756
  %t2757 = getelementptr inbounds %Statement, %Statement* %t2756, i32 0, i32 1
  %t2758 = bitcast [48 x i8]* %t2757 to i8*
  %t2759 = bitcast i8* %t2758 to i8**
  %t2760 = load i8*, i8** %t2759
  %t2761 = icmp eq i32 %t2755, 2
  %t2762 = select i1 %t2761, i8* %t2760, i8* null
  %t2763 = getelementptr inbounds %Statement, %Statement* %t2756, i32 0, i32 1
  %t2764 = bitcast [48 x i8]* %t2763 to i8*
  %t2765 = bitcast i8* %t2764 to i8**
  %t2766 = load i8*, i8** %t2765
  %t2767 = icmp eq i32 %t2755, 3
  %t2768 = select i1 %t2767, i8* %t2766, i8* %t2762
  %t2769 = getelementptr inbounds %Statement, %Statement* %t2756, i32 0, i32 1
  %t2770 = bitcast [40 x i8]* %t2769 to i8*
  %t2771 = bitcast i8* %t2770 to i8**
  %t2772 = load i8*, i8** %t2771
  %t2773 = icmp eq i32 %t2755, 6
  %t2774 = select i1 %t2773, i8* %t2772, i8* %t2768
  %t2775 = getelementptr inbounds %Statement, %Statement* %t2756, i32 0, i32 1
  %t2776 = bitcast [56 x i8]* %t2775 to i8*
  %t2777 = bitcast i8* %t2776 to i8**
  %t2778 = load i8*, i8** %t2777
  %t2779 = icmp eq i32 %t2755, 8
  %t2780 = select i1 %t2779, i8* %t2778, i8* %t2774
  %t2781 = getelementptr inbounds %Statement, %Statement* %t2756, i32 0, i32 1
  %t2782 = bitcast [40 x i8]* %t2781 to i8*
  %t2783 = bitcast i8* %t2782 to i8**
  %t2784 = load i8*, i8** %t2783
  %t2785 = icmp eq i32 %t2755, 9
  %t2786 = select i1 %t2785, i8* %t2784, i8* %t2780
  %t2787 = getelementptr inbounds %Statement, %Statement* %t2756, i32 0, i32 1
  %t2788 = bitcast [40 x i8]* %t2787 to i8*
  %t2789 = bitcast i8* %t2788 to i8**
  %t2790 = load i8*, i8** %t2789
  %t2791 = icmp eq i32 %t2755, 10
  %t2792 = select i1 %t2791, i8* %t2790, i8* %t2786
  %t2793 = getelementptr inbounds %Statement, %Statement* %t2756, i32 0, i32 1
  %t2794 = bitcast [40 x i8]* %t2793 to i8*
  %t2795 = bitcast i8* %t2794 to i8**
  %t2796 = load i8*, i8** %t2795
  %t2797 = icmp eq i32 %t2755, 11
  %t2798 = select i1 %t2797, i8* %t2796, i8* %t2792
  %s2799 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2799, i32 0, i32 0
  %t2800 = extractvalue %Statement %statement, 0
  %t2801 = alloca %Statement
  store %Statement %statement, %Statement* %t2801
  %t2802 = getelementptr inbounds %Statement, %Statement* %t2801, i32 0, i32 1
  %t2803 = bitcast [48 x i8]* %t2802 to i8*
  %t2804 = getelementptr inbounds i8, i8* %t2803, i64 8
  %t2805 = bitcast i8* %t2804 to %SourceSpan**
  %t2806 = load %SourceSpan*, %SourceSpan** %t2805
  %t2807 = icmp eq i32 %t2800, 3
  %t2808 = select i1 %t2807, %SourceSpan* %t2806, %SourceSpan* null
  %t2809 = getelementptr inbounds %Statement, %Statement* %t2801, i32 0, i32 1
  %t2810 = bitcast [40 x i8]* %t2809 to i8*
  %t2811 = getelementptr inbounds i8, i8* %t2810, i64 8
  %t2812 = bitcast i8* %t2811 to %SourceSpan**
  %t2813 = load %SourceSpan*, %SourceSpan** %t2812
  %t2814 = icmp eq i32 %t2800, 6
  %t2815 = select i1 %t2814, %SourceSpan* %t2813, %SourceSpan* %t2808
  %t2816 = getelementptr inbounds %Statement, %Statement* %t2801, i32 0, i32 1
  %t2817 = bitcast [56 x i8]* %t2816 to i8*
  %t2818 = getelementptr inbounds i8, i8* %t2817, i64 8
  %t2819 = bitcast i8* %t2818 to %SourceSpan**
  %t2820 = load %SourceSpan*, %SourceSpan** %t2819
  %t2821 = icmp eq i32 %t2800, 8
  %t2822 = select i1 %t2821, %SourceSpan* %t2820, %SourceSpan* %t2815
  %t2823 = getelementptr inbounds %Statement, %Statement* %t2801, i32 0, i32 1
  %t2824 = bitcast [40 x i8]* %t2823 to i8*
  %t2825 = getelementptr inbounds i8, i8* %t2824, i64 8
  %t2826 = bitcast i8* %t2825 to %SourceSpan**
  %t2827 = load %SourceSpan*, %SourceSpan** %t2826
  %t2828 = icmp eq i32 %t2800, 9
  %t2829 = select i1 %t2828, %SourceSpan* %t2827, %SourceSpan* %t2822
  %t2830 = getelementptr inbounds %Statement, %Statement* %t2801, i32 0, i32 1
  %t2831 = bitcast [40 x i8]* %t2830 to i8*
  %t2832 = getelementptr inbounds i8, i8* %t2831, i64 8
  %t2833 = bitcast i8* %t2832 to %SourceSpan**
  %t2834 = load %SourceSpan*, %SourceSpan** %t2833
  %t2835 = icmp eq i32 %t2800, 10
  %t2836 = select i1 %t2835, %SourceSpan* %t2834, %SourceSpan* %t2829
  %t2837 = getelementptr inbounds %Statement, %Statement* %t2801, i32 0, i32 1
  %t2838 = bitcast [40 x i8]* %t2837 to i8*
  %t2839 = getelementptr inbounds i8, i8* %t2838, i64 8
  %t2840 = bitcast i8* %t2839 to %SourceSpan**
  %t2841 = load %SourceSpan*, %SourceSpan** %t2840
  %t2842 = icmp eq i32 %t2800, 11
  %t2843 = select i1 %t2842, %SourceSpan* %t2841, %SourceSpan* %t2836
  %t2844 = bitcast %SourceSpan* %t2843 to i8*
  %t2845 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t2798, i8* %s2799, i8* %t2844)
  store %ScopeResult %t2845, %ScopeResult* %l23
  %t2846 = load %ScopeResult, %ScopeResult* %l23
  %t2847 = extractvalue %ScopeResult %t2846, 1
  %t2848 = extractvalue %Statement %statement, 0
  %t2849 = alloca %Statement
  store %Statement %statement, %Statement* %t2849
  %t2850 = getelementptr inbounds %Statement, %Statement* %t2849, i32 0, i32 1
  %t2851 = bitcast [56 x i8]* %t2850 to i8*
  %t2852 = getelementptr inbounds i8, i8* %t2851, i64 16
  %t2853 = bitcast i8* %t2852 to { %TypeParameter**, i64 }**
  %t2854 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2853
  %t2855 = icmp eq i32 %t2848, 8
  %t2856 = select i1 %t2855, { %TypeParameter**, i64 }* %t2854, { %TypeParameter**, i64 }* null
  %t2857 = getelementptr inbounds %Statement, %Statement* %t2849, i32 0, i32 1
  %t2858 = bitcast [40 x i8]* %t2857 to i8*
  %t2859 = getelementptr inbounds i8, i8* %t2858, i64 16
  %t2860 = bitcast i8* %t2859 to { %TypeParameter**, i64 }**
  %t2861 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2860
  %t2862 = icmp eq i32 %t2848, 9
  %t2863 = select i1 %t2862, { %TypeParameter**, i64 }* %t2861, { %TypeParameter**, i64 }* %t2856
  %t2864 = getelementptr inbounds %Statement, %Statement* %t2849, i32 0, i32 1
  %t2865 = bitcast [40 x i8]* %t2864 to i8*
  %t2866 = getelementptr inbounds i8, i8* %t2865, i64 16
  %t2867 = bitcast i8* %t2866 to { %TypeParameter**, i64 }**
  %t2868 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2867
  %t2869 = icmp eq i32 %t2848, 10
  %t2870 = select i1 %t2869, { %TypeParameter**, i64 }* %t2868, { %TypeParameter**, i64 }* %t2863
  %t2871 = getelementptr inbounds %Statement, %Statement* %t2849, i32 0, i32 1
  %t2872 = bitcast [40 x i8]* %t2871 to i8*
  %t2873 = getelementptr inbounds i8, i8* %t2872, i64 16
  %t2874 = bitcast i8* %t2873 to { %TypeParameter**, i64 }**
  %t2875 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2874
  %t2876 = icmp eq i32 %t2848, 11
  %t2877 = select i1 %t2876, { %TypeParameter**, i64 }* %t2875, { %TypeParameter**, i64 }* %t2870
  %t2878 = bitcast { %TypeParameter**, i64 }* %t2877 to { %TypeParameter*, i64 }*
  %t2879 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t2878)
  %t2880 = bitcast { %Diagnostic**, i64 }* %t2847 to { i8**, i64 }*
  %t2881 = bitcast { %Diagnostic*, i64 }* %t2879 to { i8**, i64 }*
  %t2882 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2880, { i8**, i64 }* %t2881)
  store { i8**, i64 }* %t2882, { i8**, i64 }** %l24
  %t2883 = load %ScopeResult, %ScopeResult* %l23
  %t2884 = extractvalue %ScopeResult %t2883, 0
  %t2885 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2884, 0
  %t2886 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t2887 = bitcast { i8**, i64 }* %t2886 to { %Diagnostic**, i64 }*
  %t2888 = insertvalue %ScopeResult %t2885, { %Diagnostic**, i64 }* %t2887, 1
  ret %ScopeResult %t2888
merge41:
  %t2889 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2890 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2889, 0
  %t2891 = alloca [0 x %Diagnostic*]
  %t2892 = getelementptr [0 x %Diagnostic*], [0 x %Diagnostic*]* %t2891, i32 0, i32 0
  %t2893 = alloca { %Diagnostic**, i64 }
  %t2894 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t2893, i32 0, i32 0
  store %Diagnostic** %t2892, %Diagnostic*** %t2894
  %t2895 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t2893, i32 0, i32 1
  store i64 0, i64* %t2895
  %t2896 = insertvalue %ScopeResult %t2890, { %Diagnostic**, i64 }* %t2893, 1
  ret %ScopeResult %t2896
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
  %t43 = load %FunctionSignature*, %FunctionSignature** %t42
  %t44 = getelementptr %FunctionSignature, %FunctionSignature* %t43, i32 0, i32 0
  %t45 = load i8*, i8** %t44
  %t46 = alloca [1 x i8*]
  %t47 = getelementptr [1 x i8*], [1 x i8*]* %t46, i32 0, i32 0
  %t48 = getelementptr i8*, i8** %t47, i64 0
  store i8* %t45, i8** %t48
  %t49 = alloca { i8**, i64 }
  %t50 = getelementptr { i8**, i64 }, { i8**, i64 }* %t49, i32 0, i32 0
  store i8** %t47, i8*** %t50
  %t51 = getelementptr { i8**, i64 }, { i8**, i64 }* %t49, i32 0, i32 1
  store i64 1, i64* %t51
  %t52 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t40, { i8**, i64 }* %t49)
  store { i8**, i64 }* %t52, { i8**, i64 }** %l0
  br label %forinc4
forinc4:
  %t53 = load i64, i64* %l1
  %t54 = add i64 %t53, 1
  store i64 %t54, i64* %l1
  br label %for2
afterfor5:
  %t55 = alloca [0 x %Diagnostic]
  %t56 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t55, i32 0, i32 0
  %t57 = alloca { %Diagnostic*, i64 }
  %t58 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t57, i32 0, i32 0
  store %Diagnostic* %t56, %Diagnostic** %t58
  %t59 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t57, i32 0, i32 1
  store i64 0, i64* %t59
  store { %Diagnostic*, i64 }* %t57, { %Diagnostic*, i64 }** %l3
  %t60 = extractvalue %Statement %statement, 0
  %t61 = alloca %Statement
  store %Statement %statement, %Statement* %t61
  %t62 = getelementptr inbounds %Statement, %Statement* %t61, i32 0, i32 1
  %t63 = bitcast [56 x i8]* %t62 to i8*
  %t64 = getelementptr inbounds i8, i8* %t63, i64 24
  %t65 = bitcast i8* %t64 to { %TypeAnnotation**, i64 }**
  %t66 = load { %TypeAnnotation**, i64 }*, { %TypeAnnotation**, i64 }** %t65
  %t67 = icmp eq i32 %t60, 8
  %t68 = select i1 %t67, { %TypeAnnotation**, i64 }* %t66, { %TypeAnnotation**, i64 }* null
  %t69 = getelementptr { %TypeAnnotation**, i64 }, { %TypeAnnotation**, i64 }* %t68, i32 0, i32 1
  %t70 = load i64, i64* %t69
  %t71 = getelementptr { %TypeAnnotation**, i64 }, { %TypeAnnotation**, i64 }* %t68, i32 0, i32 0
  %t72 = load %TypeAnnotation**, %TypeAnnotation*** %t71
  store i64 0, i64* %l4
  store %TypeAnnotation* null, %TypeAnnotation** %l5
  br label %for6
for6:
  %t73 = load i64, i64* %l4
  %t74 = icmp slt i64 %t73, %t70
  br i1 %t74, label %forbody7, label %afterfor9
forbody7:
  %t75 = load i64, i64* %l4
  %t76 = getelementptr %TypeAnnotation*, %TypeAnnotation** %t72, i64 %t75
  %t77 = load %TypeAnnotation*, %TypeAnnotation** %t76
  store %TypeAnnotation* %t77, %TypeAnnotation** %l5
  %t78 = load %TypeAnnotation*, %TypeAnnotation** %l5
  %t79 = load %TypeAnnotation, %TypeAnnotation* %t78
  %t80 = call double @resolve_interface_annotation(%TypeAnnotation %t79, { %Statement*, i64 }* %interfaces)
  store double %t80, double* %l6
  %t81 = load double, double* %l6
  %t82 = load double, double* %l6
  store double 0.0, double* %l7
  %t83 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  %t84 = extractvalue %Statement %statement, 0
  %t85 = alloca %Statement
  store %Statement %statement, %Statement* %t85
  %t86 = getelementptr inbounds %Statement, %Statement* %t85, i32 0, i32 1
  %t87 = bitcast [48 x i8]* %t86 to i8*
  %t88 = bitcast i8* %t87 to i8**
  %t89 = load i8*, i8** %t88
  %t90 = icmp eq i32 %t84, 2
  %t91 = select i1 %t90, i8* %t89, i8* null
  %t92 = getelementptr inbounds %Statement, %Statement* %t85, i32 0, i32 1
  %t93 = bitcast [48 x i8]* %t92 to i8*
  %t94 = bitcast i8* %t93 to i8**
  %t95 = load i8*, i8** %t94
  %t96 = icmp eq i32 %t84, 3
  %t97 = select i1 %t96, i8* %t95, i8* %t91
  %t98 = getelementptr inbounds %Statement, %Statement* %t85, i32 0, i32 1
  %t99 = bitcast [40 x i8]* %t98 to i8*
  %t100 = bitcast i8* %t99 to i8**
  %t101 = load i8*, i8** %t100
  %t102 = icmp eq i32 %t84, 6
  %t103 = select i1 %t102, i8* %t101, i8* %t97
  %t104 = getelementptr inbounds %Statement, %Statement* %t85, i32 0, i32 1
  %t105 = bitcast [56 x i8]* %t104 to i8*
  %t106 = bitcast i8* %t105 to i8**
  %t107 = load i8*, i8** %t106
  %t108 = icmp eq i32 %t84, 8
  %t109 = select i1 %t108, i8* %t107, i8* %t103
  %t110 = getelementptr inbounds %Statement, %Statement* %t85, i32 0, i32 1
  %t111 = bitcast [40 x i8]* %t110 to i8*
  %t112 = bitcast i8* %t111 to i8**
  %t113 = load i8*, i8** %t112
  %t114 = icmp eq i32 %t84, 9
  %t115 = select i1 %t114, i8* %t113, i8* %t109
  %t116 = getelementptr inbounds %Statement, %Statement* %t85, i32 0, i32 1
  %t117 = bitcast [40 x i8]* %t116 to i8*
  %t118 = bitcast i8* %t117 to i8**
  %t119 = load i8*, i8** %t118
  %t120 = icmp eq i32 %t84, 10
  %t121 = select i1 %t120, i8* %t119, i8* %t115
  %t122 = getelementptr inbounds %Statement, %Statement* %t85, i32 0, i32 1
  %t123 = bitcast [40 x i8]* %t122 to i8*
  %t124 = bitcast i8* %t123 to i8**
  %t125 = load i8*, i8** %t124
  %t126 = icmp eq i32 %t84, 11
  %t127 = select i1 %t126, i8* %t125, i8* %t121
  %t128 = load double, double* %l6
  %t129 = load %TypeAnnotation*, %TypeAnnotation** %l5
  %t130 = load %TypeAnnotation, %TypeAnnotation* %t129
  %t131 = call { %Diagnostic*, i64 }* @validate_interface_annotation(i8* %t127, %Statement zeroinitializer, %TypeAnnotation %t130)
  %t132 = bitcast { %Diagnostic*, i64 }* %t83 to { i8**, i64 }*
  %t133 = bitcast { %Diagnostic*, i64 }* %t131 to { i8**, i64 }*
  %t134 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t132, { i8**, i64 }* %t133)
  %t135 = bitcast { i8**, i64 }* %t134 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t135, { %Diagnostic*, i64 }** %l3
  %t136 = load double, double* %l6
  br label %forinc8
forinc8:
  %t137 = load i64, i64* %l4
  %t138 = add i64 %t137, 1
  store i64 %t138, i64* %l4
  br label %for6
afterfor9:
  %t139 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  ret { %Diagnostic*, i64 }* %t139
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
  %t22 = load %FunctionSignature, %FunctionSignature* %t21
  %t23 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t22)
  %t24 = bitcast { %Diagnostic*, i64 }* %t19 to { i8**, i64 }*
  %t25 = bitcast { %Diagnostic*, i64 }* %t23 to { i8**, i64 }*
  %t26 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t24, { i8**, i64 }* %t25)
  %t27 = bitcast { i8**, i64 }* %t26 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t27, { %Diagnostic*, i64 }** %l1
  %t28 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t29 = extractvalue %MethodDeclaration %t28, 0
  %t30 = getelementptr %FunctionSignature, %FunctionSignature* %t29, i32 0, i32 0
  %t31 = load i8*, i8** %t30
  store i8* %t31, i8** %l4
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load i8*, i8** %l4
  %t34 = call i1 @contains_string({ i8**, i64 }* %t32, i8* %t33)
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t37 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t38 = load i8*, i8** %l4
  br i1 %t34, label %then4, label %else5
then4:
  %t39 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t40 = load i8*, i8** %l4
  %s41 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.41, i32 0, i32 0
  %t42 = load i8*, i8** %l4
  %t43 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t44 = extractvalue %MethodDeclaration %t43, 0
  %t45 = getelementptr %FunctionSignature, %FunctionSignature* %t44, i32 0, i32 6
  %t46 = load %SourceSpan*, %SourceSpan** %t45
  %t47 = bitcast %SourceSpan* %t46 to i8*
  %t48 = call double @token_from_name(i8* %t42, i8* %t47)
  %t49 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t40, i8* %s41, i8* null)
  %t50 = alloca [1 x %Diagnostic]
  %t51 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* %t50, i32 0, i32 0
  %t52 = getelementptr %Diagnostic, %Diagnostic* %t51, i64 0
  store %Diagnostic %t49, %Diagnostic* %t52
  %t53 = alloca { %Diagnostic*, i64 }
  %t54 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t53, i32 0, i32 0
  store %Diagnostic* %t51, %Diagnostic** %t54
  %t55 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t53, i32 0, i32 1
  store i64 1, i64* %t55
  %t56 = bitcast { %Diagnostic*, i64 }* %t39 to { i8**, i64 }*
  %t57 = bitcast { %Diagnostic*, i64 }* %t53 to { i8**, i64 }*
  %t58 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t56, { i8**, i64 }* %t57)
  %t59 = bitcast { i8**, i64 }* %t58 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t59, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t61 = load i8*, i8** %l4
  %t62 = alloca [1 x i8*]
  %t63 = getelementptr [1 x i8*], [1 x i8*]* %t62, i32 0, i32 0
  %t64 = getelementptr i8*, i8** %t63, i64 0
  store i8* %t61, i8** %t64
  %t65 = alloca { i8**, i64 }
  %t66 = getelementptr { i8**, i64 }, { i8**, i64 }* %t65, i32 0, i32 0
  store i8** %t63, i8*** %t66
  %t67 = getelementptr { i8**, i64 }, { i8**, i64 }* %t65, i32 0, i32 1
  store i64 1, i64* %t67
  %t68 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t60, { i8**, i64 }* %t65)
  store { i8**, i64 }* %t68, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t69 = phi { %Diagnostic*, i64 }* [ %t59, %then4 ], [ %t36, %else5 ]
  %t70 = phi { i8**, i64 }* [ %t35, %then4 ], [ %t68, %else5 ]
  store { %Diagnostic*, i64 }* %t69, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t70, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t71 = load i64, i64* %l2
  %t72 = add i64 %t71, 1
  store i64 %t72, i64* %l2
  br label %for0
afterfor3:
  %t73 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t73
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
