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

@.str.154 = private unnamed_addr constant [3 x i8] c", \00"
@.str.5 = private unnamed_addr constant [1 x i8] c"\00"
@.str.7 = private unnamed_addr constant [1 x i8] c"\00"
@.str.0 = private unnamed_addr constant [21 x i8] c" is missing effect '\00"
@.str.15 = private unnamed_addr constant [15 x i8] c". hint: add ![\00"
@.str.22 = private unnamed_addr constant [61 x i8] c"] to the signature or accept the CLI fix prompt when offered\00"

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
  %t22 = call %SymbolCollectionResult @register_top_level_symbol(%Statement zeroinitializer, { %SymbolEntry*, i64 }* %t21)
  store %SymbolCollectionResult %t22, %SymbolCollectionResult* %l4
  %t23 = load %SymbolCollectionResult, %SymbolCollectionResult* %l4
  %t24 = extractvalue %SymbolCollectionResult %t23, 0
  %t25 = bitcast { %SymbolEntry**, i64 }* %t24 to { %SymbolEntry*, i64 }*
  store { %SymbolEntry*, i64 }* %t25, { %SymbolEntry*, i64 }** %l0
  %t26 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t27 = load %SymbolCollectionResult, %SymbolCollectionResult* %l4
  %t28 = extractvalue %SymbolCollectionResult %t27, 1
  %t29 = bitcast { %Diagnostic*, i64 }* %t26 to { i8**, i64 }*
  %t30 = bitcast { %Diagnostic**, i64 }* %t28 to { i8**, i64 }*
  %t31 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t29, { i8**, i64 }* %t30)
  %t32 = bitcast { i8**, i64 }* %t31 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t32, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t33 = load i64, i64* %l2
  %t34 = add i64 %t33, 1
  store i64 %t34, i64* %l2
  br label %for0
afterfor3:
  %t35 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t36 = bitcast { %SymbolEntry*, i64 }* %t35 to { %SymbolEntry**, i64 }*
  %t37 = insertvalue %SymbolCollectionResult undef, { %SymbolEntry**, i64 }* %t36, 0
  %t38 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t39 = bitcast { %Diagnostic*, i64 }* %t38 to { %Diagnostic**, i64 }*
  %t40 = insertvalue %SymbolCollectionResult %t37, { %Diagnostic**, i64 }* %t39, 1
  ret %SymbolCollectionResult %t40
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
  %t22 = call %ScopeResult @check_statement(%Statement zeroinitializer, { %SymbolEntry*, i64 }* %t21, { %Statement*, i64 }* %interfaces)
  store %ScopeResult %t22, %ScopeResult* %l4
  %t23 = load %ScopeResult, %ScopeResult* %l4
  %t24 = extractvalue %ScopeResult %t23, 0
  %t25 = bitcast { %SymbolEntry**, i64 }* %t24 to { %SymbolEntry*, i64 }*
  store { %SymbolEntry*, i64 }* %t25, { %SymbolEntry*, i64 }** %l0
  %t26 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t27 = load %ScopeResult, %ScopeResult* %l4
  %t28 = extractvalue %ScopeResult %t27, 1
  %t29 = bitcast { %Diagnostic*, i64 }* %t26 to { i8**, i64 }*
  %t30 = bitcast { %Diagnostic**, i64 }* %t28 to { i8**, i64 }*
  %t31 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t29, { i8**, i64 }* %t30)
  %t32 = bitcast { i8**, i64 }* %t31 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t32, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t33 = load i64, i64* %l2
  %t34 = add i64 %t33, 1
  store i64 %t34, i64* %l2
  br label %for0
afterfor3:
  %t35 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t35
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
  %t286 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature zeroinitializer)
  %t287 = bitcast { %Diagnostic**, i64 }* %t265 to { i8**, i64 }*
  %t288 = bitcast { %Diagnostic*, i64 }* %t286 to { i8**, i64 }*
  %t289 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t287, { i8**, i64 }* %t288)
  %t290 = bitcast { i8**, i64 }* %t289 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t290, { %Diagnostic**, i64 }** %l1
  %t291 = extractvalue %Statement %statement, 0
  %t292 = alloca %Statement
  store %Statement %statement, %Statement* %t292
  %t293 = getelementptr inbounds %Statement, %Statement* %t292, i32 0, i32 1
  %t294 = bitcast [24 x i8]* %t293 to i8*
  %t295 = bitcast i8* %t294 to %FunctionSignature**
  %t296 = load %FunctionSignature*, %FunctionSignature** %t295
  %t297 = icmp eq i32 %t291, 4
  %t298 = select i1 %t297, %FunctionSignature* %t296, %FunctionSignature* null
  %t299 = getelementptr inbounds %Statement, %Statement* %t292, i32 0, i32 1
  %t300 = bitcast [24 x i8]* %t299 to i8*
  %t301 = bitcast i8* %t300 to %FunctionSignature**
  %t302 = load %FunctionSignature*, %FunctionSignature** %t301
  %t303 = icmp eq i32 %t291, 5
  %t304 = select i1 %t303, %FunctionSignature* %t302, %FunctionSignature* %t298
  %t305 = getelementptr inbounds %Statement, %Statement* %t292, i32 0, i32 1
  %t306 = bitcast [24 x i8]* %t305 to i8*
  %t307 = bitcast i8* %t306 to %FunctionSignature**
  %t308 = load %FunctionSignature*, %FunctionSignature** %t307
  %t309 = icmp eq i32 %t291, 7
  %t310 = select i1 %t309, %FunctionSignature* %t308, %FunctionSignature* %t304
  %t311 = extractvalue %Statement %statement, 0
  %t312 = alloca %Statement
  store %Statement %statement, %Statement* %t312
  %t313 = getelementptr inbounds %Statement, %Statement* %t312, i32 0, i32 1
  %t314 = bitcast [24 x i8]* %t313 to i8*
  %t315 = getelementptr inbounds i8, i8* %t314, i64 8
  %t316 = bitcast i8* %t315 to %Block**
  %t317 = load %Block*, %Block** %t316
  %t318 = icmp eq i32 %t311, 4
  %t319 = select i1 %t318, %Block* %t317, %Block* null
  %t320 = getelementptr inbounds %Statement, %Statement* %t312, i32 0, i32 1
  %t321 = bitcast [24 x i8]* %t320 to i8*
  %t322 = getelementptr inbounds i8, i8* %t321, i64 8
  %t323 = bitcast i8* %t322 to %Block**
  %t324 = load %Block*, %Block** %t323
  %t325 = icmp eq i32 %t311, 5
  %t326 = select i1 %t325, %Block* %t324, %Block* %t319
  %t327 = getelementptr inbounds %Statement, %Statement* %t312, i32 0, i32 1
  %t328 = bitcast [40 x i8]* %t327 to i8*
  %t329 = getelementptr inbounds i8, i8* %t328, i64 16
  %t330 = bitcast i8* %t329 to %Block**
  %t331 = load %Block*, %Block** %t330
  %t332 = icmp eq i32 %t311, 6
  %t333 = select i1 %t332, %Block* %t331, %Block* %t326
  %t334 = getelementptr inbounds %Statement, %Statement* %t312, i32 0, i32 1
  %t335 = bitcast [24 x i8]* %t334 to i8*
  %t336 = getelementptr inbounds i8, i8* %t335, i64 8
  %t337 = bitcast i8* %t336 to %Block**
  %t338 = load %Block*, %Block** %t337
  %t339 = icmp eq i32 %t311, 7
  %t340 = select i1 %t339, %Block* %t338, %Block* %t333
  %t341 = getelementptr inbounds %Statement, %Statement* %t312, i32 0, i32 1
  %t342 = bitcast [40 x i8]* %t341 to i8*
  %t343 = getelementptr inbounds i8, i8* %t342, i64 24
  %t344 = bitcast i8* %t343 to %Block**
  %t345 = load %Block*, %Block** %t344
  %t346 = icmp eq i32 %t311, 12
  %t347 = select i1 %t346, %Block* %t345, %Block* %t340
  %t348 = getelementptr inbounds %Statement, %Statement* %t312, i32 0, i32 1
  %t349 = bitcast [24 x i8]* %t348 to i8*
  %t350 = getelementptr inbounds i8, i8* %t349, i64 8
  %t351 = bitcast i8* %t350 to %Block**
  %t352 = load %Block*, %Block** %t351
  %t353 = icmp eq i32 %t311, 13
  %t354 = select i1 %t353, %Block* %t352, %Block* %t347
  %t355 = getelementptr inbounds %Statement, %Statement* %t312, i32 0, i32 1
  %t356 = bitcast [24 x i8]* %t355 to i8*
  %t357 = getelementptr inbounds i8, i8* %t356, i64 8
  %t358 = bitcast i8* %t357 to %Block**
  %t359 = load %Block*, %Block** %t358
  %t360 = icmp eq i32 %t311, 14
  %t361 = select i1 %t360, %Block* %t359, %Block* %t354
  %t362 = getelementptr inbounds %Statement, %Statement* %t312, i32 0, i32 1
  %t363 = bitcast [16 x i8]* %t362 to i8*
  %t364 = bitcast i8* %t363 to %Block**
  %t365 = load %Block*, %Block** %t364
  %t366 = icmp eq i32 %t311, 15
  %t367 = select i1 %t366, %Block* %t365, %Block* %t361
  %t368 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature zeroinitializer, %Block zeroinitializer, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t368, { %Diagnostic*, i64 }** %l2
  %t369 = load %ScopeResult, %ScopeResult* %l0
  %t370 = extractvalue %ScopeResult %t369, 0
  %t371 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t370, 0
  %t372 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l1
  %t373 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l2
  %t374 = bitcast { %Diagnostic**, i64 }* %t372 to { i8**, i64 }*
  %t375 = bitcast { %Diagnostic*, i64 }* %t373 to { i8**, i64 }*
  %t376 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t374, { i8**, i64 }* %t375)
  %t377 = bitcast { i8**, i64 }* %t376 to { %Diagnostic**, i64 }*
  %t378 = insertvalue %ScopeResult %t371, { %Diagnostic**, i64 }* %t377, 1
  ret %ScopeResult %t378
merge3:
  %t379 = extractvalue %Statement %statement, 0
  %t380 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t381 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t382 = icmp eq i32 %t379, 0
  %t383 = select i1 %t382, i8* %t381, i8* %t380
  %t384 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t385 = icmp eq i32 %t379, 1
  %t386 = select i1 %t385, i8* %t384, i8* %t383
  %t387 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t388 = icmp eq i32 %t379, 2
  %t389 = select i1 %t388, i8* %t387, i8* %t386
  %t390 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t391 = icmp eq i32 %t379, 3
  %t392 = select i1 %t391, i8* %t390, i8* %t389
  %t393 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t394 = icmp eq i32 %t379, 4
  %t395 = select i1 %t394, i8* %t393, i8* %t392
  %t396 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t397 = icmp eq i32 %t379, 5
  %t398 = select i1 %t397, i8* %t396, i8* %t395
  %t399 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t400 = icmp eq i32 %t379, 6
  %t401 = select i1 %t400, i8* %t399, i8* %t398
  %t402 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t403 = icmp eq i32 %t379, 7
  %t404 = select i1 %t403, i8* %t402, i8* %t401
  %t405 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t406 = icmp eq i32 %t379, 8
  %t407 = select i1 %t406, i8* %t405, i8* %t404
  %t408 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t409 = icmp eq i32 %t379, 9
  %t410 = select i1 %t409, i8* %t408, i8* %t407
  %t411 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t412 = icmp eq i32 %t379, 10
  %t413 = select i1 %t412, i8* %t411, i8* %t410
  %t414 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t415 = icmp eq i32 %t379, 11
  %t416 = select i1 %t415, i8* %t414, i8* %t413
  %t417 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t418 = icmp eq i32 %t379, 12
  %t419 = select i1 %t418, i8* %t417, i8* %t416
  %t420 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t421 = icmp eq i32 %t379, 13
  %t422 = select i1 %t421, i8* %t420, i8* %t419
  %t423 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t424 = icmp eq i32 %t379, 14
  %t425 = select i1 %t424, i8* %t423, i8* %t422
  %t426 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t427 = icmp eq i32 %t379, 15
  %t428 = select i1 %t427, i8* %t426, i8* %t425
  %t429 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t430 = icmp eq i32 %t379, 16
  %t431 = select i1 %t430, i8* %t429, i8* %t428
  %t432 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t433 = icmp eq i32 %t379, 17
  %t434 = select i1 %t433, i8* %t432, i8* %t431
  %t435 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t436 = icmp eq i32 %t379, 18
  %t437 = select i1 %t436, i8* %t435, i8* %t434
  %t438 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t439 = icmp eq i32 %t379, 19
  %t440 = select i1 %t439, i8* %t438, i8* %t437
  %t441 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t442 = icmp eq i32 %t379, 20
  %t443 = select i1 %t442, i8* %t441, i8* %t440
  %t444 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t445 = icmp eq i32 %t379, 21
  %t446 = select i1 %t445, i8* %t444, i8* %t443
  %t447 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t448 = icmp eq i32 %t379, 22
  %t449 = select i1 %t448, i8* %t447, i8* %t446
  %s450 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.450, i32 0, i32 0
  %t451 = icmp eq i8* %t449, %s450
  br i1 %t451, label %then4, label %merge5
then4:
  %t452 = extractvalue %Statement %statement, 0
  %t453 = alloca %Statement
  store %Statement %statement, %Statement* %t453
  %t454 = getelementptr inbounds %Statement, %Statement* %t453, i32 0, i32 1
  %t455 = bitcast [48 x i8]* %t454 to i8*
  %t456 = bitcast i8* %t455 to i8**
  %t457 = load i8*, i8** %t456
  %t458 = icmp eq i32 %t452, 2
  %t459 = select i1 %t458, i8* %t457, i8* null
  %t460 = getelementptr inbounds %Statement, %Statement* %t453, i32 0, i32 1
  %t461 = bitcast [48 x i8]* %t460 to i8*
  %t462 = bitcast i8* %t461 to i8**
  %t463 = load i8*, i8** %t462
  %t464 = icmp eq i32 %t452, 3
  %t465 = select i1 %t464, i8* %t463, i8* %t459
  %t466 = getelementptr inbounds %Statement, %Statement* %t453, i32 0, i32 1
  %t467 = bitcast [40 x i8]* %t466 to i8*
  %t468 = bitcast i8* %t467 to i8**
  %t469 = load i8*, i8** %t468
  %t470 = icmp eq i32 %t452, 6
  %t471 = select i1 %t470, i8* %t469, i8* %t465
  %t472 = getelementptr inbounds %Statement, %Statement* %t453, i32 0, i32 1
  %t473 = bitcast [56 x i8]* %t472 to i8*
  %t474 = bitcast i8* %t473 to i8**
  %t475 = load i8*, i8** %t474
  %t476 = icmp eq i32 %t452, 8
  %t477 = select i1 %t476, i8* %t475, i8* %t471
  %t478 = getelementptr inbounds %Statement, %Statement* %t453, i32 0, i32 1
  %t479 = bitcast [40 x i8]* %t478 to i8*
  %t480 = bitcast i8* %t479 to i8**
  %t481 = load i8*, i8** %t480
  %t482 = icmp eq i32 %t452, 9
  %t483 = select i1 %t482, i8* %t481, i8* %t477
  %t484 = getelementptr inbounds %Statement, %Statement* %t453, i32 0, i32 1
  %t485 = bitcast [40 x i8]* %t484 to i8*
  %t486 = bitcast i8* %t485 to i8**
  %t487 = load i8*, i8** %t486
  %t488 = icmp eq i32 %t452, 10
  %t489 = select i1 %t488, i8* %t487, i8* %t483
  %t490 = getelementptr inbounds %Statement, %Statement* %t453, i32 0, i32 1
  %t491 = bitcast [40 x i8]* %t490 to i8*
  %t492 = bitcast i8* %t491 to i8**
  %t493 = load i8*, i8** %t492
  %t494 = icmp eq i32 %t452, 11
  %t495 = select i1 %t494, i8* %t493, i8* %t489
  %s496 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.496, i32 0, i32 0
  %t497 = extractvalue %Statement %statement, 0
  %t498 = alloca %Statement
  store %Statement %statement, %Statement* %t498
  %t499 = getelementptr inbounds %Statement, %Statement* %t498, i32 0, i32 1
  %t500 = bitcast [48 x i8]* %t499 to i8*
  %t501 = getelementptr inbounds i8, i8* %t500, i64 8
  %t502 = bitcast i8* %t501 to %SourceSpan**
  %t503 = load %SourceSpan*, %SourceSpan** %t502
  %t504 = icmp eq i32 %t497, 3
  %t505 = select i1 %t504, %SourceSpan* %t503, %SourceSpan* null
  %t506 = getelementptr inbounds %Statement, %Statement* %t498, i32 0, i32 1
  %t507 = bitcast [40 x i8]* %t506 to i8*
  %t508 = getelementptr inbounds i8, i8* %t507, i64 8
  %t509 = bitcast i8* %t508 to %SourceSpan**
  %t510 = load %SourceSpan*, %SourceSpan** %t509
  %t511 = icmp eq i32 %t497, 6
  %t512 = select i1 %t511, %SourceSpan* %t510, %SourceSpan* %t505
  %t513 = getelementptr inbounds %Statement, %Statement* %t498, i32 0, i32 1
  %t514 = bitcast [56 x i8]* %t513 to i8*
  %t515 = getelementptr inbounds i8, i8* %t514, i64 8
  %t516 = bitcast i8* %t515 to %SourceSpan**
  %t517 = load %SourceSpan*, %SourceSpan** %t516
  %t518 = icmp eq i32 %t497, 8
  %t519 = select i1 %t518, %SourceSpan* %t517, %SourceSpan* %t512
  %t520 = getelementptr inbounds %Statement, %Statement* %t498, i32 0, i32 1
  %t521 = bitcast [40 x i8]* %t520 to i8*
  %t522 = getelementptr inbounds i8, i8* %t521, i64 8
  %t523 = bitcast i8* %t522 to %SourceSpan**
  %t524 = load %SourceSpan*, %SourceSpan** %t523
  %t525 = icmp eq i32 %t497, 9
  %t526 = select i1 %t525, %SourceSpan* %t524, %SourceSpan* %t519
  %t527 = getelementptr inbounds %Statement, %Statement* %t498, i32 0, i32 1
  %t528 = bitcast [40 x i8]* %t527 to i8*
  %t529 = getelementptr inbounds i8, i8* %t528, i64 8
  %t530 = bitcast i8* %t529 to %SourceSpan**
  %t531 = load %SourceSpan*, %SourceSpan** %t530
  %t532 = icmp eq i32 %t497, 10
  %t533 = select i1 %t532, %SourceSpan* %t531, %SourceSpan* %t526
  %t534 = getelementptr inbounds %Statement, %Statement* %t498, i32 0, i32 1
  %t535 = bitcast [40 x i8]* %t534 to i8*
  %t536 = getelementptr inbounds i8, i8* %t535, i64 8
  %t537 = bitcast i8* %t536 to %SourceSpan**
  %t538 = load %SourceSpan*, %SourceSpan** %t537
  %t539 = icmp eq i32 %t497, 11
  %t540 = select i1 %t539, %SourceSpan* %t538, %SourceSpan* %t533
  %t541 = bitcast %SourceSpan* %t540 to i8*
  %t542 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t495, i8* %s496, i8* %t541)
  store %ScopeResult %t542, %ScopeResult* %l3
  %t543 = load %ScopeResult, %ScopeResult* %l3
  %t544 = extractvalue %ScopeResult %t543, 1
  store { %Diagnostic**, i64 }* %t544, { %Diagnostic**, i64 }** %l4
  %t545 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t546 = extractvalue %Statement %statement, 0
  %t547 = alloca %Statement
  store %Statement %statement, %Statement* %t547
  %t548 = getelementptr inbounds %Statement, %Statement* %t547, i32 0, i32 1
  %t549 = bitcast [56 x i8]* %t548 to i8*
  %t550 = getelementptr inbounds i8, i8* %t549, i64 16
  %t551 = bitcast i8* %t550 to { %TypeParameter**, i64 }**
  %t552 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t551
  %t553 = icmp eq i32 %t546, 8
  %t554 = select i1 %t553, { %TypeParameter**, i64 }* %t552, { %TypeParameter**, i64 }* null
  %t555 = getelementptr inbounds %Statement, %Statement* %t547, i32 0, i32 1
  %t556 = bitcast [40 x i8]* %t555 to i8*
  %t557 = getelementptr inbounds i8, i8* %t556, i64 16
  %t558 = bitcast i8* %t557 to { %TypeParameter**, i64 }**
  %t559 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t558
  %t560 = icmp eq i32 %t546, 9
  %t561 = select i1 %t560, { %TypeParameter**, i64 }* %t559, { %TypeParameter**, i64 }* %t554
  %t562 = getelementptr inbounds %Statement, %Statement* %t547, i32 0, i32 1
  %t563 = bitcast [40 x i8]* %t562 to i8*
  %t564 = getelementptr inbounds i8, i8* %t563, i64 16
  %t565 = bitcast i8* %t564 to { %TypeParameter**, i64 }**
  %t566 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t565
  %t567 = icmp eq i32 %t546, 10
  %t568 = select i1 %t567, { %TypeParameter**, i64 }* %t566, { %TypeParameter**, i64 }* %t561
  %t569 = getelementptr inbounds %Statement, %Statement* %t547, i32 0, i32 1
  %t570 = bitcast [40 x i8]* %t569 to i8*
  %t571 = getelementptr inbounds i8, i8* %t570, i64 16
  %t572 = bitcast i8* %t571 to { %TypeParameter**, i64 }**
  %t573 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t572
  %t574 = icmp eq i32 %t546, 11
  %t575 = select i1 %t574, { %TypeParameter**, i64 }* %t573, { %TypeParameter**, i64 }* %t568
  %t576 = bitcast { %TypeParameter**, i64 }* %t575 to { %TypeParameter*, i64 }*
  %t577 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t576)
  %t578 = bitcast { %Diagnostic**, i64 }* %t545 to { i8**, i64 }*
  %t579 = bitcast { %Diagnostic*, i64 }* %t577 to { i8**, i64 }*
  %t580 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t578, { i8**, i64 }* %t579)
  %t581 = bitcast { i8**, i64 }* %t580 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t581, { %Diagnostic**, i64 }** %l4
  %t582 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t583 = extractvalue %Statement %statement, 0
  %t584 = alloca %Statement
  store %Statement %statement, %Statement* %t584
  %t585 = getelementptr inbounds %Statement, %Statement* %t584, i32 0, i32 1
  %t586 = bitcast [56 x i8]* %t585 to i8*
  %t587 = getelementptr inbounds i8, i8* %t586, i64 32
  %t588 = bitcast i8* %t587 to { %FieldDeclaration**, i64 }**
  %t589 = load { %FieldDeclaration**, i64 }*, { %FieldDeclaration**, i64 }** %t588
  %t590 = icmp eq i32 %t583, 8
  %t591 = select i1 %t590, { %FieldDeclaration**, i64 }* %t589, { %FieldDeclaration**, i64 }* null
  %t592 = bitcast { %FieldDeclaration**, i64 }* %t591 to { %FieldDeclaration*, i64 }*
  %t593 = call { %Diagnostic*, i64 }* @check_struct_fields({ %FieldDeclaration*, i64 }* %t592)
  %t594 = bitcast { %Diagnostic**, i64 }* %t582 to { i8**, i64 }*
  %t595 = bitcast { %Diagnostic*, i64 }* %t593 to { i8**, i64 }*
  %t596 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t594, { i8**, i64 }* %t595)
  %t597 = bitcast { i8**, i64 }* %t596 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t597, { %Diagnostic**, i64 }** %l4
  %t598 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t599 = extractvalue %Statement %statement, 0
  %t600 = alloca %Statement
  store %Statement %statement, %Statement* %t600
  %t601 = getelementptr inbounds %Statement, %Statement* %t600, i32 0, i32 1
  %t602 = bitcast [56 x i8]* %t601 to i8*
  %t603 = getelementptr inbounds i8, i8* %t602, i64 40
  %t604 = bitcast i8* %t603 to { %MethodDeclaration**, i64 }**
  %t605 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t604
  %t606 = icmp eq i32 %t599, 8
  %t607 = select i1 %t606, { %MethodDeclaration**, i64 }* %t605, { %MethodDeclaration**, i64 }* null
  %t608 = bitcast { %MethodDeclaration**, i64 }* %t607 to { %MethodDeclaration*, i64 }*
  %t609 = call { %Diagnostic*, i64 }* @check_struct_methods({ %MethodDeclaration*, i64 }* %t608)
  %t610 = bitcast { %Diagnostic**, i64 }* %t598 to { i8**, i64 }*
  %t611 = bitcast { %Diagnostic*, i64 }* %t609 to { i8**, i64 }*
  %t612 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t610, { i8**, i64 }* %t611)
  %t613 = bitcast { i8**, i64 }* %t612 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t613, { %Diagnostic**, i64 }** %l4
  %t614 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t615 = call { %Diagnostic*, i64 }* @check_struct_implements_interfaces(%Statement %statement, { %Statement*, i64 }* %interfaces)
  %t616 = bitcast { %Diagnostic**, i64 }* %t614 to { i8**, i64 }*
  %t617 = bitcast { %Diagnostic*, i64 }* %t615 to { i8**, i64 }*
  %t618 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t616, { i8**, i64 }* %t617)
  %t619 = bitcast { i8**, i64 }* %t618 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t619, { %Diagnostic**, i64 }** %l4
  %t620 = sitofp i64 0 to double
  store double %t620, double* %l5
  %t621 = load %ScopeResult, %ScopeResult* %l3
  %t622 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t623 = load double, double* %l5
  br label %loop.header6
loop.header6:
  %t675 = phi { %Diagnostic**, i64 }* [ %t622, %then4 ], [ %t673, %loop.latch8 ]
  %t676 = phi double [ %t623, %then4 ], [ %t674, %loop.latch8 ]
  store { %Diagnostic**, i64 }* %t675, { %Diagnostic**, i64 }** %l4
  store double %t676, double* %l5
  br label %loop.body7
loop.body7:
  %t624 = load double, double* %l5
  %t625 = extractvalue %Statement %statement, 0
  %t626 = alloca %Statement
  store %Statement %statement, %Statement* %t626
  %t627 = getelementptr inbounds %Statement, %Statement* %t626, i32 0, i32 1
  %t628 = bitcast [56 x i8]* %t627 to i8*
  %t629 = getelementptr inbounds i8, i8* %t628, i64 40
  %t630 = bitcast i8* %t629 to { %MethodDeclaration**, i64 }**
  %t631 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t630
  %t632 = icmp eq i32 %t625, 8
  %t633 = select i1 %t632, { %MethodDeclaration**, i64 }* %t631, { %MethodDeclaration**, i64 }* null
  %t634 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t633
  %t635 = extractvalue { %MethodDeclaration**, i64 } %t634, 1
  %t636 = sitofp i64 %t635 to double
  %t637 = fcmp oge double %t624, %t636
  %t638 = load %ScopeResult, %ScopeResult* %l3
  %t639 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t640 = load double, double* %l5
  br i1 %t637, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t641 = extractvalue %Statement %statement, 0
  %t642 = alloca %Statement
  store %Statement %statement, %Statement* %t642
  %t643 = getelementptr inbounds %Statement, %Statement* %t642, i32 0, i32 1
  %t644 = bitcast [56 x i8]* %t643 to i8*
  %t645 = getelementptr inbounds i8, i8* %t644, i64 40
  %t646 = bitcast i8* %t645 to { %MethodDeclaration**, i64 }**
  %t647 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t646
  %t648 = icmp eq i32 %t641, 8
  %t649 = select i1 %t648, { %MethodDeclaration**, i64 }* %t647, { %MethodDeclaration**, i64 }* null
  %t650 = load double, double* %l5
  %t651 = fptosi double %t650 to i64
  %t652 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t649
  %t653 = extractvalue { %MethodDeclaration**, i64 } %t652, 0
  %t654 = extractvalue { %MethodDeclaration**, i64 } %t652, 1
  %t655 = icmp uge i64 %t651, %t654
  ; bounds check: %t655 (if true, out of bounds)
  %t656 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t653, i64 %t651
  %t657 = load %MethodDeclaration*, %MethodDeclaration** %t656
  store %MethodDeclaration* %t657, %MethodDeclaration** %l6
  %t658 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t659 = load %MethodDeclaration*, %MethodDeclaration** %l6
  %t660 = getelementptr %MethodDeclaration, %MethodDeclaration* %t659, i32 0, i32 0
  %t661 = load %FunctionSignature*, %FunctionSignature** %t660
  %t662 = load %MethodDeclaration*, %MethodDeclaration** %l6
  %t663 = getelementptr %MethodDeclaration, %MethodDeclaration* %t662, i32 0, i32 1
  %t664 = load %Block*, %Block** %t663
  %t665 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature zeroinitializer, %Block zeroinitializer, { %Statement*, i64 }* %interfaces)
  %t666 = bitcast { %Diagnostic**, i64 }* %t658 to { i8**, i64 }*
  %t667 = bitcast { %Diagnostic*, i64 }* %t665 to { i8**, i64 }*
  %t668 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t666, { i8**, i64 }* %t667)
  %t669 = bitcast { i8**, i64 }* %t668 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t669, { %Diagnostic**, i64 }** %l4
  %t670 = load double, double* %l5
  %t671 = sitofp i64 1 to double
  %t672 = fadd double %t670, %t671
  store double %t672, double* %l5
  br label %loop.latch8
loop.latch8:
  %t673 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t674 = load double, double* %l5
  br label %loop.header6
afterloop9:
  %t677 = load %ScopeResult, %ScopeResult* %l3
  %t678 = extractvalue %ScopeResult %t677, 0
  %t679 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t678, 0
  %t680 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l4
  %t681 = insertvalue %ScopeResult %t679, { %Diagnostic**, i64 }* %t680, 1
  ret %ScopeResult %t681
merge5:
  %t682 = extractvalue %Statement %statement, 0
  %t683 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t684 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t685 = icmp eq i32 %t682, 0
  %t686 = select i1 %t685, i8* %t684, i8* %t683
  %t687 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t688 = icmp eq i32 %t682, 1
  %t689 = select i1 %t688, i8* %t687, i8* %t686
  %t690 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t691 = icmp eq i32 %t682, 2
  %t692 = select i1 %t691, i8* %t690, i8* %t689
  %t693 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t694 = icmp eq i32 %t682, 3
  %t695 = select i1 %t694, i8* %t693, i8* %t692
  %t696 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t697 = icmp eq i32 %t682, 4
  %t698 = select i1 %t697, i8* %t696, i8* %t695
  %t699 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t700 = icmp eq i32 %t682, 5
  %t701 = select i1 %t700, i8* %t699, i8* %t698
  %t702 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t703 = icmp eq i32 %t682, 6
  %t704 = select i1 %t703, i8* %t702, i8* %t701
  %t705 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t706 = icmp eq i32 %t682, 7
  %t707 = select i1 %t706, i8* %t705, i8* %t704
  %t708 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t709 = icmp eq i32 %t682, 8
  %t710 = select i1 %t709, i8* %t708, i8* %t707
  %t711 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t712 = icmp eq i32 %t682, 9
  %t713 = select i1 %t712, i8* %t711, i8* %t710
  %t714 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t715 = icmp eq i32 %t682, 10
  %t716 = select i1 %t715, i8* %t714, i8* %t713
  %t717 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t718 = icmp eq i32 %t682, 11
  %t719 = select i1 %t718, i8* %t717, i8* %t716
  %t720 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t721 = icmp eq i32 %t682, 12
  %t722 = select i1 %t721, i8* %t720, i8* %t719
  %t723 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t724 = icmp eq i32 %t682, 13
  %t725 = select i1 %t724, i8* %t723, i8* %t722
  %t726 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t727 = icmp eq i32 %t682, 14
  %t728 = select i1 %t727, i8* %t726, i8* %t725
  %t729 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t730 = icmp eq i32 %t682, 15
  %t731 = select i1 %t730, i8* %t729, i8* %t728
  %t732 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t733 = icmp eq i32 %t682, 16
  %t734 = select i1 %t733, i8* %t732, i8* %t731
  %t735 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t736 = icmp eq i32 %t682, 17
  %t737 = select i1 %t736, i8* %t735, i8* %t734
  %t738 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t739 = icmp eq i32 %t682, 18
  %t740 = select i1 %t739, i8* %t738, i8* %t737
  %t741 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t742 = icmp eq i32 %t682, 19
  %t743 = select i1 %t742, i8* %t741, i8* %t740
  %t744 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t745 = icmp eq i32 %t682, 20
  %t746 = select i1 %t745, i8* %t744, i8* %t743
  %t747 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t748 = icmp eq i32 %t682, 21
  %t749 = select i1 %t748, i8* %t747, i8* %t746
  %t750 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t751 = icmp eq i32 %t682, 22
  %t752 = select i1 %t751, i8* %t750, i8* %t749
  %s753 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.753, i32 0, i32 0
  %t754 = icmp eq i8* %t752, %s753
  br i1 %t754, label %then12, label %merge13
then12:
  %t755 = extractvalue %Statement %statement, 0
  %t756 = alloca %Statement
  store %Statement %statement, %Statement* %t756
  %t757 = getelementptr inbounds %Statement, %Statement* %t756, i32 0, i32 1
  %t758 = bitcast [48 x i8]* %t757 to i8*
  %t759 = bitcast i8* %t758 to i8**
  %t760 = load i8*, i8** %t759
  %t761 = icmp eq i32 %t755, 2
  %t762 = select i1 %t761, i8* %t760, i8* null
  %t763 = getelementptr inbounds %Statement, %Statement* %t756, i32 0, i32 1
  %t764 = bitcast [48 x i8]* %t763 to i8*
  %t765 = bitcast i8* %t764 to i8**
  %t766 = load i8*, i8** %t765
  %t767 = icmp eq i32 %t755, 3
  %t768 = select i1 %t767, i8* %t766, i8* %t762
  %t769 = getelementptr inbounds %Statement, %Statement* %t756, i32 0, i32 1
  %t770 = bitcast [40 x i8]* %t769 to i8*
  %t771 = bitcast i8* %t770 to i8**
  %t772 = load i8*, i8** %t771
  %t773 = icmp eq i32 %t755, 6
  %t774 = select i1 %t773, i8* %t772, i8* %t768
  %t775 = getelementptr inbounds %Statement, %Statement* %t756, i32 0, i32 1
  %t776 = bitcast [56 x i8]* %t775 to i8*
  %t777 = bitcast i8* %t776 to i8**
  %t778 = load i8*, i8** %t777
  %t779 = icmp eq i32 %t755, 8
  %t780 = select i1 %t779, i8* %t778, i8* %t774
  %t781 = getelementptr inbounds %Statement, %Statement* %t756, i32 0, i32 1
  %t782 = bitcast [40 x i8]* %t781 to i8*
  %t783 = bitcast i8* %t782 to i8**
  %t784 = load i8*, i8** %t783
  %t785 = icmp eq i32 %t755, 9
  %t786 = select i1 %t785, i8* %t784, i8* %t780
  %t787 = getelementptr inbounds %Statement, %Statement* %t756, i32 0, i32 1
  %t788 = bitcast [40 x i8]* %t787 to i8*
  %t789 = bitcast i8* %t788 to i8**
  %t790 = load i8*, i8** %t789
  %t791 = icmp eq i32 %t755, 10
  %t792 = select i1 %t791, i8* %t790, i8* %t786
  %t793 = getelementptr inbounds %Statement, %Statement* %t756, i32 0, i32 1
  %t794 = bitcast [40 x i8]* %t793 to i8*
  %t795 = bitcast i8* %t794 to i8**
  %t796 = load i8*, i8** %t795
  %t797 = icmp eq i32 %t755, 11
  %t798 = select i1 %t797, i8* %t796, i8* %t792
  %s799 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.799, i32 0, i32 0
  %t800 = extractvalue %Statement %statement, 0
  %t801 = alloca %Statement
  store %Statement %statement, %Statement* %t801
  %t802 = getelementptr inbounds %Statement, %Statement* %t801, i32 0, i32 1
  %t803 = bitcast [48 x i8]* %t802 to i8*
  %t804 = getelementptr inbounds i8, i8* %t803, i64 8
  %t805 = bitcast i8* %t804 to %SourceSpan**
  %t806 = load %SourceSpan*, %SourceSpan** %t805
  %t807 = icmp eq i32 %t800, 3
  %t808 = select i1 %t807, %SourceSpan* %t806, %SourceSpan* null
  %t809 = getelementptr inbounds %Statement, %Statement* %t801, i32 0, i32 1
  %t810 = bitcast [40 x i8]* %t809 to i8*
  %t811 = getelementptr inbounds i8, i8* %t810, i64 8
  %t812 = bitcast i8* %t811 to %SourceSpan**
  %t813 = load %SourceSpan*, %SourceSpan** %t812
  %t814 = icmp eq i32 %t800, 6
  %t815 = select i1 %t814, %SourceSpan* %t813, %SourceSpan* %t808
  %t816 = getelementptr inbounds %Statement, %Statement* %t801, i32 0, i32 1
  %t817 = bitcast [56 x i8]* %t816 to i8*
  %t818 = getelementptr inbounds i8, i8* %t817, i64 8
  %t819 = bitcast i8* %t818 to %SourceSpan**
  %t820 = load %SourceSpan*, %SourceSpan** %t819
  %t821 = icmp eq i32 %t800, 8
  %t822 = select i1 %t821, %SourceSpan* %t820, %SourceSpan* %t815
  %t823 = getelementptr inbounds %Statement, %Statement* %t801, i32 0, i32 1
  %t824 = bitcast [40 x i8]* %t823 to i8*
  %t825 = getelementptr inbounds i8, i8* %t824, i64 8
  %t826 = bitcast i8* %t825 to %SourceSpan**
  %t827 = load %SourceSpan*, %SourceSpan** %t826
  %t828 = icmp eq i32 %t800, 9
  %t829 = select i1 %t828, %SourceSpan* %t827, %SourceSpan* %t822
  %t830 = getelementptr inbounds %Statement, %Statement* %t801, i32 0, i32 1
  %t831 = bitcast [40 x i8]* %t830 to i8*
  %t832 = getelementptr inbounds i8, i8* %t831, i64 8
  %t833 = bitcast i8* %t832 to %SourceSpan**
  %t834 = load %SourceSpan*, %SourceSpan** %t833
  %t835 = icmp eq i32 %t800, 10
  %t836 = select i1 %t835, %SourceSpan* %t834, %SourceSpan* %t829
  %t837 = getelementptr inbounds %Statement, %Statement* %t801, i32 0, i32 1
  %t838 = bitcast [40 x i8]* %t837 to i8*
  %t839 = getelementptr inbounds i8, i8* %t838, i64 8
  %t840 = bitcast i8* %t839 to %SourceSpan**
  %t841 = load %SourceSpan*, %SourceSpan** %t840
  %t842 = icmp eq i32 %t800, 11
  %t843 = select i1 %t842, %SourceSpan* %t841, %SourceSpan* %t836
  %t844 = bitcast %SourceSpan* %t843 to i8*
  %t845 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t798, i8* %s799, i8* %t844)
  store %ScopeResult %t845, %ScopeResult* %l7
  %t846 = load %ScopeResult, %ScopeResult* %l7
  %t847 = extractvalue %ScopeResult %t846, 1
  store { %Diagnostic**, i64 }* %t847, { %Diagnostic**, i64 }** %l8
  %t848 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l8
  %t849 = extractvalue %Statement %statement, 0
  %t850 = alloca %Statement
  store %Statement %statement, %Statement* %t850
  %t851 = getelementptr inbounds %Statement, %Statement* %t850, i32 0, i32 1
  %t852 = bitcast [56 x i8]* %t851 to i8*
  %t853 = getelementptr inbounds i8, i8* %t852, i64 16
  %t854 = bitcast i8* %t853 to { %TypeParameter**, i64 }**
  %t855 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t854
  %t856 = icmp eq i32 %t849, 8
  %t857 = select i1 %t856, { %TypeParameter**, i64 }* %t855, { %TypeParameter**, i64 }* null
  %t858 = getelementptr inbounds %Statement, %Statement* %t850, i32 0, i32 1
  %t859 = bitcast [40 x i8]* %t858 to i8*
  %t860 = getelementptr inbounds i8, i8* %t859, i64 16
  %t861 = bitcast i8* %t860 to { %TypeParameter**, i64 }**
  %t862 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t861
  %t863 = icmp eq i32 %t849, 9
  %t864 = select i1 %t863, { %TypeParameter**, i64 }* %t862, { %TypeParameter**, i64 }* %t857
  %t865 = getelementptr inbounds %Statement, %Statement* %t850, i32 0, i32 1
  %t866 = bitcast [40 x i8]* %t865 to i8*
  %t867 = getelementptr inbounds i8, i8* %t866, i64 16
  %t868 = bitcast i8* %t867 to { %TypeParameter**, i64 }**
  %t869 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t868
  %t870 = icmp eq i32 %t849, 10
  %t871 = select i1 %t870, { %TypeParameter**, i64 }* %t869, { %TypeParameter**, i64 }* %t864
  %t872 = getelementptr inbounds %Statement, %Statement* %t850, i32 0, i32 1
  %t873 = bitcast [40 x i8]* %t872 to i8*
  %t874 = getelementptr inbounds i8, i8* %t873, i64 16
  %t875 = bitcast i8* %t874 to { %TypeParameter**, i64 }**
  %t876 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t875
  %t877 = icmp eq i32 %t849, 11
  %t878 = select i1 %t877, { %TypeParameter**, i64 }* %t876, { %TypeParameter**, i64 }* %t871
  %t879 = bitcast { %TypeParameter**, i64 }* %t878 to { %TypeParameter*, i64 }*
  %t880 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t879)
  %t881 = bitcast { %Diagnostic**, i64 }* %t848 to { i8**, i64 }*
  %t882 = bitcast { %Diagnostic*, i64 }* %t880 to { i8**, i64 }*
  %t883 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t881, { i8**, i64 }* %t882)
  %t884 = bitcast { i8**, i64 }* %t883 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t884, { %Diagnostic**, i64 }** %l8
  %t885 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l8
  %t886 = extractvalue %Statement %statement, 0
  %t887 = alloca %Statement
  store %Statement %statement, %Statement* %t887
  %t888 = getelementptr inbounds %Statement, %Statement* %t887, i32 0, i32 1
  %t889 = bitcast [40 x i8]* %t888 to i8*
  %t890 = getelementptr inbounds i8, i8* %t889, i64 24
  %t891 = bitcast i8* %t890 to { %EnumVariant**, i64 }**
  %t892 = load { %EnumVariant**, i64 }*, { %EnumVariant**, i64 }** %t891
  %t893 = icmp eq i32 %t886, 11
  %t894 = select i1 %t893, { %EnumVariant**, i64 }* %t892, { %EnumVariant**, i64 }* null
  %t895 = bitcast { %EnumVariant**, i64 }* %t894 to { %EnumVariant*, i64 }*
  %t896 = call { %Diagnostic*, i64 }* @check_enum_variants({ %EnumVariant*, i64 }* %t895)
  %t897 = bitcast { %Diagnostic**, i64 }* %t885 to { i8**, i64 }*
  %t898 = bitcast { %Diagnostic*, i64 }* %t896 to { i8**, i64 }*
  %t899 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t897, { i8**, i64 }* %t898)
  %t900 = bitcast { i8**, i64 }* %t899 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t900, { %Diagnostic**, i64 }** %l8
  %t901 = load %ScopeResult, %ScopeResult* %l7
  %t902 = extractvalue %ScopeResult %t901, 0
  %t903 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t902, 0
  %t904 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l8
  %t905 = insertvalue %ScopeResult %t903, { %Diagnostic**, i64 }* %t904, 1
  ret %ScopeResult %t905
merge13:
  %t906 = extractvalue %Statement %statement, 0
  %t907 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t908 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t909 = icmp eq i32 %t906, 0
  %t910 = select i1 %t909, i8* %t908, i8* %t907
  %t911 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t912 = icmp eq i32 %t906, 1
  %t913 = select i1 %t912, i8* %t911, i8* %t910
  %t914 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t915 = icmp eq i32 %t906, 2
  %t916 = select i1 %t915, i8* %t914, i8* %t913
  %t917 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t918 = icmp eq i32 %t906, 3
  %t919 = select i1 %t918, i8* %t917, i8* %t916
  %t920 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t921 = icmp eq i32 %t906, 4
  %t922 = select i1 %t921, i8* %t920, i8* %t919
  %t923 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t924 = icmp eq i32 %t906, 5
  %t925 = select i1 %t924, i8* %t923, i8* %t922
  %t926 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t927 = icmp eq i32 %t906, 6
  %t928 = select i1 %t927, i8* %t926, i8* %t925
  %t929 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t930 = icmp eq i32 %t906, 7
  %t931 = select i1 %t930, i8* %t929, i8* %t928
  %t932 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t933 = icmp eq i32 %t906, 8
  %t934 = select i1 %t933, i8* %t932, i8* %t931
  %t935 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t936 = icmp eq i32 %t906, 9
  %t937 = select i1 %t936, i8* %t935, i8* %t934
  %t938 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t939 = icmp eq i32 %t906, 10
  %t940 = select i1 %t939, i8* %t938, i8* %t937
  %t941 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t942 = icmp eq i32 %t906, 11
  %t943 = select i1 %t942, i8* %t941, i8* %t940
  %t944 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t945 = icmp eq i32 %t906, 12
  %t946 = select i1 %t945, i8* %t944, i8* %t943
  %t947 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t948 = icmp eq i32 %t906, 13
  %t949 = select i1 %t948, i8* %t947, i8* %t946
  %t950 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t951 = icmp eq i32 %t906, 14
  %t952 = select i1 %t951, i8* %t950, i8* %t949
  %t953 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t954 = icmp eq i32 %t906, 15
  %t955 = select i1 %t954, i8* %t953, i8* %t952
  %t956 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t957 = icmp eq i32 %t906, 16
  %t958 = select i1 %t957, i8* %t956, i8* %t955
  %t959 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t960 = icmp eq i32 %t906, 17
  %t961 = select i1 %t960, i8* %t959, i8* %t958
  %t962 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t963 = icmp eq i32 %t906, 18
  %t964 = select i1 %t963, i8* %t962, i8* %t961
  %t965 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t966 = icmp eq i32 %t906, 19
  %t967 = select i1 %t966, i8* %t965, i8* %t964
  %t968 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t969 = icmp eq i32 %t906, 20
  %t970 = select i1 %t969, i8* %t968, i8* %t967
  %t971 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t972 = icmp eq i32 %t906, 21
  %t973 = select i1 %t972, i8* %t971, i8* %t970
  %t974 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t975 = icmp eq i32 %t906, 22
  %t976 = select i1 %t975, i8* %t974, i8* %t973
  %s977 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.977, i32 0, i32 0
  %t978 = icmp eq i8* %t976, %s977
  br i1 %t978, label %then14, label %merge15
then14:
  %t979 = extractvalue %Statement %statement, 0
  %t980 = alloca %Statement
  store %Statement %statement, %Statement* %t980
  %t981 = getelementptr inbounds %Statement, %Statement* %t980, i32 0, i32 1
  %t982 = bitcast [48 x i8]* %t981 to i8*
  %t983 = bitcast i8* %t982 to i8**
  %t984 = load i8*, i8** %t983
  %t985 = icmp eq i32 %t979, 2
  %t986 = select i1 %t985, i8* %t984, i8* null
  %t987 = getelementptr inbounds %Statement, %Statement* %t980, i32 0, i32 1
  %t988 = bitcast [48 x i8]* %t987 to i8*
  %t989 = bitcast i8* %t988 to i8**
  %t990 = load i8*, i8** %t989
  %t991 = icmp eq i32 %t979, 3
  %t992 = select i1 %t991, i8* %t990, i8* %t986
  %t993 = getelementptr inbounds %Statement, %Statement* %t980, i32 0, i32 1
  %t994 = bitcast [40 x i8]* %t993 to i8*
  %t995 = bitcast i8* %t994 to i8**
  %t996 = load i8*, i8** %t995
  %t997 = icmp eq i32 %t979, 6
  %t998 = select i1 %t997, i8* %t996, i8* %t992
  %t999 = getelementptr inbounds %Statement, %Statement* %t980, i32 0, i32 1
  %t1000 = bitcast [56 x i8]* %t999 to i8*
  %t1001 = bitcast i8* %t1000 to i8**
  %t1002 = load i8*, i8** %t1001
  %t1003 = icmp eq i32 %t979, 8
  %t1004 = select i1 %t1003, i8* %t1002, i8* %t998
  %t1005 = getelementptr inbounds %Statement, %Statement* %t980, i32 0, i32 1
  %t1006 = bitcast [40 x i8]* %t1005 to i8*
  %t1007 = bitcast i8* %t1006 to i8**
  %t1008 = load i8*, i8** %t1007
  %t1009 = icmp eq i32 %t979, 9
  %t1010 = select i1 %t1009, i8* %t1008, i8* %t1004
  %t1011 = getelementptr inbounds %Statement, %Statement* %t980, i32 0, i32 1
  %t1012 = bitcast [40 x i8]* %t1011 to i8*
  %t1013 = bitcast i8* %t1012 to i8**
  %t1014 = load i8*, i8** %t1013
  %t1015 = icmp eq i32 %t979, 10
  %t1016 = select i1 %t1015, i8* %t1014, i8* %t1010
  %t1017 = getelementptr inbounds %Statement, %Statement* %t980, i32 0, i32 1
  %t1018 = bitcast [40 x i8]* %t1017 to i8*
  %t1019 = bitcast i8* %t1018 to i8**
  %t1020 = load i8*, i8** %t1019
  %t1021 = icmp eq i32 %t979, 11
  %t1022 = select i1 %t1021, i8* %t1020, i8* %t1016
  %s1023 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.1023, i32 0, i32 0
  %t1024 = extractvalue %Statement %statement, 0
  %t1025 = alloca %Statement
  store %Statement %statement, %Statement* %t1025
  %t1026 = getelementptr inbounds %Statement, %Statement* %t1025, i32 0, i32 1
  %t1027 = bitcast [48 x i8]* %t1026 to i8*
  %t1028 = getelementptr inbounds i8, i8* %t1027, i64 8
  %t1029 = bitcast i8* %t1028 to %SourceSpan**
  %t1030 = load %SourceSpan*, %SourceSpan** %t1029
  %t1031 = icmp eq i32 %t1024, 3
  %t1032 = select i1 %t1031, %SourceSpan* %t1030, %SourceSpan* null
  %t1033 = getelementptr inbounds %Statement, %Statement* %t1025, i32 0, i32 1
  %t1034 = bitcast [40 x i8]* %t1033 to i8*
  %t1035 = getelementptr inbounds i8, i8* %t1034, i64 8
  %t1036 = bitcast i8* %t1035 to %SourceSpan**
  %t1037 = load %SourceSpan*, %SourceSpan** %t1036
  %t1038 = icmp eq i32 %t1024, 6
  %t1039 = select i1 %t1038, %SourceSpan* %t1037, %SourceSpan* %t1032
  %t1040 = getelementptr inbounds %Statement, %Statement* %t1025, i32 0, i32 1
  %t1041 = bitcast [56 x i8]* %t1040 to i8*
  %t1042 = getelementptr inbounds i8, i8* %t1041, i64 8
  %t1043 = bitcast i8* %t1042 to %SourceSpan**
  %t1044 = load %SourceSpan*, %SourceSpan** %t1043
  %t1045 = icmp eq i32 %t1024, 8
  %t1046 = select i1 %t1045, %SourceSpan* %t1044, %SourceSpan* %t1039
  %t1047 = getelementptr inbounds %Statement, %Statement* %t1025, i32 0, i32 1
  %t1048 = bitcast [40 x i8]* %t1047 to i8*
  %t1049 = getelementptr inbounds i8, i8* %t1048, i64 8
  %t1050 = bitcast i8* %t1049 to %SourceSpan**
  %t1051 = load %SourceSpan*, %SourceSpan** %t1050
  %t1052 = icmp eq i32 %t1024, 9
  %t1053 = select i1 %t1052, %SourceSpan* %t1051, %SourceSpan* %t1046
  %t1054 = getelementptr inbounds %Statement, %Statement* %t1025, i32 0, i32 1
  %t1055 = bitcast [40 x i8]* %t1054 to i8*
  %t1056 = getelementptr inbounds i8, i8* %t1055, i64 8
  %t1057 = bitcast i8* %t1056 to %SourceSpan**
  %t1058 = load %SourceSpan*, %SourceSpan** %t1057
  %t1059 = icmp eq i32 %t1024, 10
  %t1060 = select i1 %t1059, %SourceSpan* %t1058, %SourceSpan* %t1053
  %t1061 = getelementptr inbounds %Statement, %Statement* %t1025, i32 0, i32 1
  %t1062 = bitcast [40 x i8]* %t1061 to i8*
  %t1063 = getelementptr inbounds i8, i8* %t1062, i64 8
  %t1064 = bitcast i8* %t1063 to %SourceSpan**
  %t1065 = load %SourceSpan*, %SourceSpan** %t1064
  %t1066 = icmp eq i32 %t1024, 11
  %t1067 = select i1 %t1066, %SourceSpan* %t1065, %SourceSpan* %t1060
  %t1068 = bitcast %SourceSpan* %t1067 to i8*
  %t1069 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1022, i8* %s1023, i8* %t1068)
  store %ScopeResult %t1069, %ScopeResult* %l9
  %t1070 = load %ScopeResult, %ScopeResult* %l9
  %t1071 = extractvalue %ScopeResult %t1070, 1
  store { %Diagnostic**, i64 }* %t1071, { %Diagnostic**, i64 }** %l10
  %t1072 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l10
  %t1073 = extractvalue %Statement %statement, 0
  %t1074 = alloca %Statement
  store %Statement %statement, %Statement* %t1074
  %t1075 = getelementptr inbounds %Statement, %Statement* %t1074, i32 0, i32 1
  %t1076 = bitcast [56 x i8]* %t1075 to i8*
  %t1077 = getelementptr inbounds i8, i8* %t1076, i64 16
  %t1078 = bitcast i8* %t1077 to { %TypeParameter**, i64 }**
  %t1079 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1078
  %t1080 = icmp eq i32 %t1073, 8
  %t1081 = select i1 %t1080, { %TypeParameter**, i64 }* %t1079, { %TypeParameter**, i64 }* null
  %t1082 = getelementptr inbounds %Statement, %Statement* %t1074, i32 0, i32 1
  %t1083 = bitcast [40 x i8]* %t1082 to i8*
  %t1084 = getelementptr inbounds i8, i8* %t1083, i64 16
  %t1085 = bitcast i8* %t1084 to { %TypeParameter**, i64 }**
  %t1086 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1085
  %t1087 = icmp eq i32 %t1073, 9
  %t1088 = select i1 %t1087, { %TypeParameter**, i64 }* %t1086, { %TypeParameter**, i64 }* %t1081
  %t1089 = getelementptr inbounds %Statement, %Statement* %t1074, i32 0, i32 1
  %t1090 = bitcast [40 x i8]* %t1089 to i8*
  %t1091 = getelementptr inbounds i8, i8* %t1090, i64 16
  %t1092 = bitcast i8* %t1091 to { %TypeParameter**, i64 }**
  %t1093 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1092
  %t1094 = icmp eq i32 %t1073, 10
  %t1095 = select i1 %t1094, { %TypeParameter**, i64 }* %t1093, { %TypeParameter**, i64 }* %t1088
  %t1096 = getelementptr inbounds %Statement, %Statement* %t1074, i32 0, i32 1
  %t1097 = bitcast [40 x i8]* %t1096 to i8*
  %t1098 = getelementptr inbounds i8, i8* %t1097, i64 16
  %t1099 = bitcast i8* %t1098 to { %TypeParameter**, i64 }**
  %t1100 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t1099
  %t1101 = icmp eq i32 %t1073, 11
  %t1102 = select i1 %t1101, { %TypeParameter**, i64 }* %t1100, { %TypeParameter**, i64 }* %t1095
  %t1103 = bitcast { %TypeParameter**, i64 }* %t1102 to { %TypeParameter*, i64 }*
  %t1104 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t1103)
  %t1105 = bitcast { %Diagnostic**, i64 }* %t1072 to { i8**, i64 }*
  %t1106 = bitcast { %Diagnostic*, i64 }* %t1104 to { i8**, i64 }*
  %t1107 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1105, { i8**, i64 }* %t1106)
  %t1108 = bitcast { i8**, i64 }* %t1107 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1108, { %Diagnostic**, i64 }** %l10
  %t1109 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l10
  %t1110 = extractvalue %Statement %statement, 0
  %t1111 = alloca %Statement
  store %Statement %statement, %Statement* %t1111
  %t1112 = getelementptr inbounds %Statement, %Statement* %t1111, i32 0, i32 1
  %t1113 = bitcast [40 x i8]* %t1112 to i8*
  %t1114 = getelementptr inbounds i8, i8* %t1113, i64 24
  %t1115 = bitcast i8* %t1114 to { %FunctionSignature**, i64 }**
  %t1116 = load { %FunctionSignature**, i64 }*, { %FunctionSignature**, i64 }** %t1115
  %t1117 = icmp eq i32 %t1110, 10
  %t1118 = select i1 %t1117, { %FunctionSignature**, i64 }* %t1116, { %FunctionSignature**, i64 }* null
  %t1119 = bitcast { %FunctionSignature**, i64 }* %t1118 to { %FunctionSignature*, i64 }*
  %t1120 = call { %Diagnostic*, i64 }* @check_interface_members({ %FunctionSignature*, i64 }* %t1119)
  %t1121 = bitcast { %Diagnostic**, i64 }* %t1109 to { i8**, i64 }*
  %t1122 = bitcast { %Diagnostic*, i64 }* %t1120 to { i8**, i64 }*
  %t1123 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1121, { i8**, i64 }* %t1122)
  %t1124 = bitcast { i8**, i64 }* %t1123 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1124, { %Diagnostic**, i64 }** %l10
  %t1125 = load %ScopeResult, %ScopeResult* %l9
  %t1126 = extractvalue %ScopeResult %t1125, 0
  %t1127 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1126, 0
  %t1128 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l10
  %t1129 = insertvalue %ScopeResult %t1127, { %Diagnostic**, i64 }* %t1128, 1
  ret %ScopeResult %t1129
merge15:
  %t1130 = extractvalue %Statement %statement, 0
  %t1131 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1132 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1133 = icmp eq i32 %t1130, 0
  %t1134 = select i1 %t1133, i8* %t1132, i8* %t1131
  %t1135 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1136 = icmp eq i32 %t1130, 1
  %t1137 = select i1 %t1136, i8* %t1135, i8* %t1134
  %t1138 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1139 = icmp eq i32 %t1130, 2
  %t1140 = select i1 %t1139, i8* %t1138, i8* %t1137
  %t1141 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1142 = icmp eq i32 %t1130, 3
  %t1143 = select i1 %t1142, i8* %t1141, i8* %t1140
  %t1144 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1145 = icmp eq i32 %t1130, 4
  %t1146 = select i1 %t1145, i8* %t1144, i8* %t1143
  %t1147 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1148 = icmp eq i32 %t1130, 5
  %t1149 = select i1 %t1148, i8* %t1147, i8* %t1146
  %t1150 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1151 = icmp eq i32 %t1130, 6
  %t1152 = select i1 %t1151, i8* %t1150, i8* %t1149
  %t1153 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1154 = icmp eq i32 %t1130, 7
  %t1155 = select i1 %t1154, i8* %t1153, i8* %t1152
  %t1156 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1157 = icmp eq i32 %t1130, 8
  %t1158 = select i1 %t1157, i8* %t1156, i8* %t1155
  %t1159 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1160 = icmp eq i32 %t1130, 9
  %t1161 = select i1 %t1160, i8* %t1159, i8* %t1158
  %t1162 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1163 = icmp eq i32 %t1130, 10
  %t1164 = select i1 %t1163, i8* %t1162, i8* %t1161
  %t1165 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1166 = icmp eq i32 %t1130, 11
  %t1167 = select i1 %t1166, i8* %t1165, i8* %t1164
  %t1168 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1169 = icmp eq i32 %t1130, 12
  %t1170 = select i1 %t1169, i8* %t1168, i8* %t1167
  %t1171 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1172 = icmp eq i32 %t1130, 13
  %t1173 = select i1 %t1172, i8* %t1171, i8* %t1170
  %t1174 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1175 = icmp eq i32 %t1130, 14
  %t1176 = select i1 %t1175, i8* %t1174, i8* %t1173
  %t1177 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1178 = icmp eq i32 %t1130, 15
  %t1179 = select i1 %t1178, i8* %t1177, i8* %t1176
  %t1180 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1181 = icmp eq i32 %t1130, 16
  %t1182 = select i1 %t1181, i8* %t1180, i8* %t1179
  %t1183 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1184 = icmp eq i32 %t1130, 17
  %t1185 = select i1 %t1184, i8* %t1183, i8* %t1182
  %t1186 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1187 = icmp eq i32 %t1130, 18
  %t1188 = select i1 %t1187, i8* %t1186, i8* %t1185
  %t1189 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1190 = icmp eq i32 %t1130, 19
  %t1191 = select i1 %t1190, i8* %t1189, i8* %t1188
  %t1192 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1193 = icmp eq i32 %t1130, 20
  %t1194 = select i1 %t1193, i8* %t1192, i8* %t1191
  %t1195 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1196 = icmp eq i32 %t1130, 21
  %t1197 = select i1 %t1196, i8* %t1195, i8* %t1194
  %t1198 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1199 = icmp eq i32 %t1130, 22
  %t1200 = select i1 %t1199, i8* %t1198, i8* %t1197
  %s1201 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.1201, i32 0, i32 0
  %t1202 = icmp eq i8* %t1200, %s1201
  br i1 %t1202, label %then16, label %merge17
then16:
  %t1203 = extractvalue %Statement %statement, 0
  %t1204 = alloca %Statement
  store %Statement %statement, %Statement* %t1204
  %t1205 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1206 = bitcast [48 x i8]* %t1205 to i8*
  %t1207 = bitcast i8* %t1206 to i8**
  %t1208 = load i8*, i8** %t1207
  %t1209 = icmp eq i32 %t1203, 2
  %t1210 = select i1 %t1209, i8* %t1208, i8* null
  %t1211 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1212 = bitcast [48 x i8]* %t1211 to i8*
  %t1213 = bitcast i8* %t1212 to i8**
  %t1214 = load i8*, i8** %t1213
  %t1215 = icmp eq i32 %t1203, 3
  %t1216 = select i1 %t1215, i8* %t1214, i8* %t1210
  %t1217 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1218 = bitcast [40 x i8]* %t1217 to i8*
  %t1219 = bitcast i8* %t1218 to i8**
  %t1220 = load i8*, i8** %t1219
  %t1221 = icmp eq i32 %t1203, 6
  %t1222 = select i1 %t1221, i8* %t1220, i8* %t1216
  %t1223 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1224 = bitcast [56 x i8]* %t1223 to i8*
  %t1225 = bitcast i8* %t1224 to i8**
  %t1226 = load i8*, i8** %t1225
  %t1227 = icmp eq i32 %t1203, 8
  %t1228 = select i1 %t1227, i8* %t1226, i8* %t1222
  %t1229 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1230 = bitcast [40 x i8]* %t1229 to i8*
  %t1231 = bitcast i8* %t1230 to i8**
  %t1232 = load i8*, i8** %t1231
  %t1233 = icmp eq i32 %t1203, 9
  %t1234 = select i1 %t1233, i8* %t1232, i8* %t1228
  %t1235 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1236 = bitcast [40 x i8]* %t1235 to i8*
  %t1237 = bitcast i8* %t1236 to i8**
  %t1238 = load i8*, i8** %t1237
  %t1239 = icmp eq i32 %t1203, 10
  %t1240 = select i1 %t1239, i8* %t1238, i8* %t1234
  %t1241 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1242 = bitcast [40 x i8]* %t1241 to i8*
  %t1243 = bitcast i8* %t1242 to i8**
  %t1244 = load i8*, i8** %t1243
  %t1245 = icmp eq i32 %t1203, 11
  %t1246 = select i1 %t1245, i8* %t1244, i8* %t1240
  %s1247 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1247, i32 0, i32 0
  %t1248 = extractvalue %Statement %statement, 0
  %t1249 = alloca %Statement
  store %Statement %statement, %Statement* %t1249
  %t1250 = getelementptr inbounds %Statement, %Statement* %t1249, i32 0, i32 1
  %t1251 = bitcast [48 x i8]* %t1250 to i8*
  %t1252 = getelementptr inbounds i8, i8* %t1251, i64 8
  %t1253 = bitcast i8* %t1252 to %SourceSpan**
  %t1254 = load %SourceSpan*, %SourceSpan** %t1253
  %t1255 = icmp eq i32 %t1248, 3
  %t1256 = select i1 %t1255, %SourceSpan* %t1254, %SourceSpan* null
  %t1257 = getelementptr inbounds %Statement, %Statement* %t1249, i32 0, i32 1
  %t1258 = bitcast [40 x i8]* %t1257 to i8*
  %t1259 = getelementptr inbounds i8, i8* %t1258, i64 8
  %t1260 = bitcast i8* %t1259 to %SourceSpan**
  %t1261 = load %SourceSpan*, %SourceSpan** %t1260
  %t1262 = icmp eq i32 %t1248, 6
  %t1263 = select i1 %t1262, %SourceSpan* %t1261, %SourceSpan* %t1256
  %t1264 = getelementptr inbounds %Statement, %Statement* %t1249, i32 0, i32 1
  %t1265 = bitcast [56 x i8]* %t1264 to i8*
  %t1266 = getelementptr inbounds i8, i8* %t1265, i64 8
  %t1267 = bitcast i8* %t1266 to %SourceSpan**
  %t1268 = load %SourceSpan*, %SourceSpan** %t1267
  %t1269 = icmp eq i32 %t1248, 8
  %t1270 = select i1 %t1269, %SourceSpan* %t1268, %SourceSpan* %t1263
  %t1271 = getelementptr inbounds %Statement, %Statement* %t1249, i32 0, i32 1
  %t1272 = bitcast [40 x i8]* %t1271 to i8*
  %t1273 = getelementptr inbounds i8, i8* %t1272, i64 8
  %t1274 = bitcast i8* %t1273 to %SourceSpan**
  %t1275 = load %SourceSpan*, %SourceSpan** %t1274
  %t1276 = icmp eq i32 %t1248, 9
  %t1277 = select i1 %t1276, %SourceSpan* %t1275, %SourceSpan* %t1270
  %t1278 = getelementptr inbounds %Statement, %Statement* %t1249, i32 0, i32 1
  %t1279 = bitcast [40 x i8]* %t1278 to i8*
  %t1280 = getelementptr inbounds i8, i8* %t1279, i64 8
  %t1281 = bitcast i8* %t1280 to %SourceSpan**
  %t1282 = load %SourceSpan*, %SourceSpan** %t1281
  %t1283 = icmp eq i32 %t1248, 10
  %t1284 = select i1 %t1283, %SourceSpan* %t1282, %SourceSpan* %t1277
  %t1285 = getelementptr inbounds %Statement, %Statement* %t1249, i32 0, i32 1
  %t1286 = bitcast [40 x i8]* %t1285 to i8*
  %t1287 = getelementptr inbounds i8, i8* %t1286, i64 8
  %t1288 = bitcast i8* %t1287 to %SourceSpan**
  %t1289 = load %SourceSpan*, %SourceSpan** %t1288
  %t1290 = icmp eq i32 %t1248, 11
  %t1291 = select i1 %t1290, %SourceSpan* %t1289, %SourceSpan* %t1284
  %t1292 = bitcast %SourceSpan* %t1291 to i8*
  %t1293 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1246, i8* %s1247, i8* %t1292)
  store %ScopeResult %t1293, %ScopeResult* %l11
  %t1294 = load %ScopeResult, %ScopeResult* %l11
  %t1295 = extractvalue %ScopeResult %t1294, 1
  %t1296 = extractvalue %Statement %statement, 0
  %t1297 = alloca %Statement
  store %Statement %statement, %Statement* %t1297
  %t1298 = getelementptr inbounds %Statement, %Statement* %t1297, i32 0, i32 1
  %t1299 = bitcast [48 x i8]* %t1298 to i8*
  %t1300 = getelementptr inbounds i8, i8* %t1299, i64 24
  %t1301 = bitcast i8* %t1300 to { %ModelProperty**, i64 }**
  %t1302 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1301
  %t1303 = icmp eq i32 %t1296, 3
  %t1304 = select i1 %t1303, { %ModelProperty**, i64 }* %t1302, { %ModelProperty**, i64 }* null
  %t1305 = bitcast { %ModelProperty**, i64 }* %t1304 to { %ModelProperty*, i64 }*
  %t1306 = call { %Diagnostic*, i64 }* @check_model_properties({ %ModelProperty*, i64 }* %t1305)
  %t1307 = bitcast { %Diagnostic**, i64 }* %t1295 to { i8**, i64 }*
  %t1308 = bitcast { %Diagnostic*, i64 }* %t1306 to { i8**, i64 }*
  %t1309 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1307, { i8**, i64 }* %t1308)
  store { i8**, i64 }* %t1309, { i8**, i64 }** %l12
  %t1310 = load %ScopeResult, %ScopeResult* %l11
  %t1311 = extractvalue %ScopeResult %t1310, 0
  %t1312 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1311, 0
  %t1313 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %t1314 = bitcast { i8**, i64 }* %t1313 to { %Diagnostic**, i64 }*
  %t1315 = insertvalue %ScopeResult %t1312, { %Diagnostic**, i64 }* %t1314, 1
  ret %ScopeResult %t1315
merge17:
  %t1316 = extractvalue %Statement %statement, 0
  %t1317 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1318 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1319 = icmp eq i32 %t1316, 0
  %t1320 = select i1 %t1319, i8* %t1318, i8* %t1317
  %t1321 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1322 = icmp eq i32 %t1316, 1
  %t1323 = select i1 %t1322, i8* %t1321, i8* %t1320
  %t1324 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1325 = icmp eq i32 %t1316, 2
  %t1326 = select i1 %t1325, i8* %t1324, i8* %t1323
  %t1327 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1328 = icmp eq i32 %t1316, 3
  %t1329 = select i1 %t1328, i8* %t1327, i8* %t1326
  %t1330 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1331 = icmp eq i32 %t1316, 4
  %t1332 = select i1 %t1331, i8* %t1330, i8* %t1329
  %t1333 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1334 = icmp eq i32 %t1316, 5
  %t1335 = select i1 %t1334, i8* %t1333, i8* %t1332
  %t1336 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1337 = icmp eq i32 %t1316, 6
  %t1338 = select i1 %t1337, i8* %t1336, i8* %t1335
  %t1339 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1340 = icmp eq i32 %t1316, 7
  %t1341 = select i1 %t1340, i8* %t1339, i8* %t1338
  %t1342 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1343 = icmp eq i32 %t1316, 8
  %t1344 = select i1 %t1343, i8* %t1342, i8* %t1341
  %t1345 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1346 = icmp eq i32 %t1316, 9
  %t1347 = select i1 %t1346, i8* %t1345, i8* %t1344
  %t1348 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1349 = icmp eq i32 %t1316, 10
  %t1350 = select i1 %t1349, i8* %t1348, i8* %t1347
  %t1351 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1352 = icmp eq i32 %t1316, 11
  %t1353 = select i1 %t1352, i8* %t1351, i8* %t1350
  %t1354 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1355 = icmp eq i32 %t1316, 12
  %t1356 = select i1 %t1355, i8* %t1354, i8* %t1353
  %t1357 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1358 = icmp eq i32 %t1316, 13
  %t1359 = select i1 %t1358, i8* %t1357, i8* %t1356
  %t1360 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1361 = icmp eq i32 %t1316, 14
  %t1362 = select i1 %t1361, i8* %t1360, i8* %t1359
  %t1363 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1364 = icmp eq i32 %t1316, 15
  %t1365 = select i1 %t1364, i8* %t1363, i8* %t1362
  %t1366 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1367 = icmp eq i32 %t1316, 16
  %t1368 = select i1 %t1367, i8* %t1366, i8* %t1365
  %t1369 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1370 = icmp eq i32 %t1316, 17
  %t1371 = select i1 %t1370, i8* %t1369, i8* %t1368
  %t1372 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1373 = icmp eq i32 %t1316, 18
  %t1374 = select i1 %t1373, i8* %t1372, i8* %t1371
  %t1375 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1376 = icmp eq i32 %t1316, 19
  %t1377 = select i1 %t1376, i8* %t1375, i8* %t1374
  %t1378 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1379 = icmp eq i32 %t1316, 20
  %t1380 = select i1 %t1379, i8* %t1378, i8* %t1377
  %t1381 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1382 = icmp eq i32 %t1316, 21
  %t1383 = select i1 %t1382, i8* %t1381, i8* %t1380
  %t1384 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1385 = icmp eq i32 %t1316, 22
  %t1386 = select i1 %t1385, i8* %t1384, i8* %t1383
  %s1387 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1387, i32 0, i32 0
  %t1388 = icmp eq i8* %t1386, %s1387
  br i1 %t1388, label %then18, label %merge19
then18:
  %t1389 = extractvalue %Statement %statement, 0
  %t1390 = alloca %Statement
  store %Statement %statement, %Statement* %t1390
  %t1391 = getelementptr inbounds %Statement, %Statement* %t1390, i32 0, i32 1
  %t1392 = bitcast [24 x i8]* %t1391 to i8*
  %t1393 = bitcast i8* %t1392 to %FunctionSignature**
  %t1394 = load %FunctionSignature*, %FunctionSignature** %t1393
  %t1395 = icmp eq i32 %t1389, 4
  %t1396 = select i1 %t1395, %FunctionSignature* %t1394, %FunctionSignature* null
  %t1397 = getelementptr inbounds %Statement, %Statement* %t1390, i32 0, i32 1
  %t1398 = bitcast [24 x i8]* %t1397 to i8*
  %t1399 = bitcast i8* %t1398 to %FunctionSignature**
  %t1400 = load %FunctionSignature*, %FunctionSignature** %t1399
  %t1401 = icmp eq i32 %t1389, 5
  %t1402 = select i1 %t1401, %FunctionSignature* %t1400, %FunctionSignature* %t1396
  %t1403 = getelementptr inbounds %Statement, %Statement* %t1390, i32 0, i32 1
  %t1404 = bitcast [24 x i8]* %t1403 to i8*
  %t1405 = bitcast i8* %t1404 to %FunctionSignature**
  %t1406 = load %FunctionSignature*, %FunctionSignature** %t1405
  %t1407 = icmp eq i32 %t1389, 7
  %t1408 = select i1 %t1407, %FunctionSignature* %t1406, %FunctionSignature* %t1402
  %t1409 = getelementptr %FunctionSignature, %FunctionSignature* %t1408, i32 0, i32 0
  %t1410 = load i8*, i8** %t1409
  %s1411 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1411, i32 0, i32 0
  %t1412 = extractvalue %Statement %statement, 0
  %t1413 = alloca %Statement
  store %Statement %statement, %Statement* %t1413
  %t1414 = getelementptr inbounds %Statement, %Statement* %t1413, i32 0, i32 1
  %t1415 = bitcast [24 x i8]* %t1414 to i8*
  %t1416 = bitcast i8* %t1415 to %FunctionSignature**
  %t1417 = load %FunctionSignature*, %FunctionSignature** %t1416
  %t1418 = icmp eq i32 %t1412, 4
  %t1419 = select i1 %t1418, %FunctionSignature* %t1417, %FunctionSignature* null
  %t1420 = getelementptr inbounds %Statement, %Statement* %t1413, i32 0, i32 1
  %t1421 = bitcast [24 x i8]* %t1420 to i8*
  %t1422 = bitcast i8* %t1421 to %FunctionSignature**
  %t1423 = load %FunctionSignature*, %FunctionSignature** %t1422
  %t1424 = icmp eq i32 %t1412, 5
  %t1425 = select i1 %t1424, %FunctionSignature* %t1423, %FunctionSignature* %t1419
  %t1426 = getelementptr inbounds %Statement, %Statement* %t1413, i32 0, i32 1
  %t1427 = bitcast [24 x i8]* %t1426 to i8*
  %t1428 = bitcast i8* %t1427 to %FunctionSignature**
  %t1429 = load %FunctionSignature*, %FunctionSignature** %t1428
  %t1430 = icmp eq i32 %t1412, 7
  %t1431 = select i1 %t1430, %FunctionSignature* %t1429, %FunctionSignature* %t1425
  %t1432 = getelementptr %FunctionSignature, %FunctionSignature* %t1431, i32 0, i32 6
  %t1433 = load %SourceSpan*, %SourceSpan** %t1432
  %t1434 = bitcast %SourceSpan* %t1433 to i8*
  %t1435 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1410, i8* %s1411, i8* %t1434)
  store %ScopeResult %t1435, %ScopeResult* %l13
  %t1436 = load %ScopeResult, %ScopeResult* %l13
  %t1437 = extractvalue %ScopeResult %t1436, 1
  store { %Diagnostic**, i64 }* %t1437, { %Diagnostic**, i64 }** %l14
  %t1438 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l14
  %t1439 = extractvalue %Statement %statement, 0
  %t1440 = alloca %Statement
  store %Statement %statement, %Statement* %t1440
  %t1441 = getelementptr inbounds %Statement, %Statement* %t1440, i32 0, i32 1
  %t1442 = bitcast [24 x i8]* %t1441 to i8*
  %t1443 = bitcast i8* %t1442 to %FunctionSignature**
  %t1444 = load %FunctionSignature*, %FunctionSignature** %t1443
  %t1445 = icmp eq i32 %t1439, 4
  %t1446 = select i1 %t1445, %FunctionSignature* %t1444, %FunctionSignature* null
  %t1447 = getelementptr inbounds %Statement, %Statement* %t1440, i32 0, i32 1
  %t1448 = bitcast [24 x i8]* %t1447 to i8*
  %t1449 = bitcast i8* %t1448 to %FunctionSignature**
  %t1450 = load %FunctionSignature*, %FunctionSignature** %t1449
  %t1451 = icmp eq i32 %t1439, 5
  %t1452 = select i1 %t1451, %FunctionSignature* %t1450, %FunctionSignature* %t1446
  %t1453 = getelementptr inbounds %Statement, %Statement* %t1440, i32 0, i32 1
  %t1454 = bitcast [24 x i8]* %t1453 to i8*
  %t1455 = bitcast i8* %t1454 to %FunctionSignature**
  %t1456 = load %FunctionSignature*, %FunctionSignature** %t1455
  %t1457 = icmp eq i32 %t1439, 7
  %t1458 = select i1 %t1457, %FunctionSignature* %t1456, %FunctionSignature* %t1452
  %t1459 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature zeroinitializer)
  %t1460 = bitcast { %Diagnostic**, i64 }* %t1438 to { i8**, i64 }*
  %t1461 = bitcast { %Diagnostic*, i64 }* %t1459 to { i8**, i64 }*
  %t1462 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1460, { i8**, i64 }* %t1461)
  %t1463 = bitcast { i8**, i64 }* %t1462 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1463, { %Diagnostic**, i64 }** %l14
  %t1464 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l14
  %t1465 = extractvalue %Statement %statement, 0
  %t1466 = alloca %Statement
  store %Statement %statement, %Statement* %t1466
  %t1467 = getelementptr inbounds %Statement, %Statement* %t1466, i32 0, i32 1
  %t1468 = bitcast [24 x i8]* %t1467 to i8*
  %t1469 = bitcast i8* %t1468 to %FunctionSignature**
  %t1470 = load %FunctionSignature*, %FunctionSignature** %t1469
  %t1471 = icmp eq i32 %t1465, 4
  %t1472 = select i1 %t1471, %FunctionSignature* %t1470, %FunctionSignature* null
  %t1473 = getelementptr inbounds %Statement, %Statement* %t1466, i32 0, i32 1
  %t1474 = bitcast [24 x i8]* %t1473 to i8*
  %t1475 = bitcast i8* %t1474 to %FunctionSignature**
  %t1476 = load %FunctionSignature*, %FunctionSignature** %t1475
  %t1477 = icmp eq i32 %t1465, 5
  %t1478 = select i1 %t1477, %FunctionSignature* %t1476, %FunctionSignature* %t1472
  %t1479 = getelementptr inbounds %Statement, %Statement* %t1466, i32 0, i32 1
  %t1480 = bitcast [24 x i8]* %t1479 to i8*
  %t1481 = bitcast i8* %t1480 to %FunctionSignature**
  %t1482 = load %FunctionSignature*, %FunctionSignature** %t1481
  %t1483 = icmp eq i32 %t1465, 7
  %t1484 = select i1 %t1483, %FunctionSignature* %t1482, %FunctionSignature* %t1478
  %t1485 = extractvalue %Statement %statement, 0
  %t1486 = alloca %Statement
  store %Statement %statement, %Statement* %t1486
  %t1487 = getelementptr inbounds %Statement, %Statement* %t1486, i32 0, i32 1
  %t1488 = bitcast [24 x i8]* %t1487 to i8*
  %t1489 = getelementptr inbounds i8, i8* %t1488, i64 8
  %t1490 = bitcast i8* %t1489 to %Block**
  %t1491 = load %Block*, %Block** %t1490
  %t1492 = icmp eq i32 %t1485, 4
  %t1493 = select i1 %t1492, %Block* %t1491, %Block* null
  %t1494 = getelementptr inbounds %Statement, %Statement* %t1486, i32 0, i32 1
  %t1495 = bitcast [24 x i8]* %t1494 to i8*
  %t1496 = getelementptr inbounds i8, i8* %t1495, i64 8
  %t1497 = bitcast i8* %t1496 to %Block**
  %t1498 = load %Block*, %Block** %t1497
  %t1499 = icmp eq i32 %t1485, 5
  %t1500 = select i1 %t1499, %Block* %t1498, %Block* %t1493
  %t1501 = getelementptr inbounds %Statement, %Statement* %t1486, i32 0, i32 1
  %t1502 = bitcast [40 x i8]* %t1501 to i8*
  %t1503 = getelementptr inbounds i8, i8* %t1502, i64 16
  %t1504 = bitcast i8* %t1503 to %Block**
  %t1505 = load %Block*, %Block** %t1504
  %t1506 = icmp eq i32 %t1485, 6
  %t1507 = select i1 %t1506, %Block* %t1505, %Block* %t1500
  %t1508 = getelementptr inbounds %Statement, %Statement* %t1486, i32 0, i32 1
  %t1509 = bitcast [24 x i8]* %t1508 to i8*
  %t1510 = getelementptr inbounds i8, i8* %t1509, i64 8
  %t1511 = bitcast i8* %t1510 to %Block**
  %t1512 = load %Block*, %Block** %t1511
  %t1513 = icmp eq i32 %t1485, 7
  %t1514 = select i1 %t1513, %Block* %t1512, %Block* %t1507
  %t1515 = getelementptr inbounds %Statement, %Statement* %t1486, i32 0, i32 1
  %t1516 = bitcast [40 x i8]* %t1515 to i8*
  %t1517 = getelementptr inbounds i8, i8* %t1516, i64 24
  %t1518 = bitcast i8* %t1517 to %Block**
  %t1519 = load %Block*, %Block** %t1518
  %t1520 = icmp eq i32 %t1485, 12
  %t1521 = select i1 %t1520, %Block* %t1519, %Block* %t1514
  %t1522 = getelementptr inbounds %Statement, %Statement* %t1486, i32 0, i32 1
  %t1523 = bitcast [24 x i8]* %t1522 to i8*
  %t1524 = getelementptr inbounds i8, i8* %t1523, i64 8
  %t1525 = bitcast i8* %t1524 to %Block**
  %t1526 = load %Block*, %Block** %t1525
  %t1527 = icmp eq i32 %t1485, 13
  %t1528 = select i1 %t1527, %Block* %t1526, %Block* %t1521
  %t1529 = getelementptr inbounds %Statement, %Statement* %t1486, i32 0, i32 1
  %t1530 = bitcast [24 x i8]* %t1529 to i8*
  %t1531 = getelementptr inbounds i8, i8* %t1530, i64 8
  %t1532 = bitcast i8* %t1531 to %Block**
  %t1533 = load %Block*, %Block** %t1532
  %t1534 = icmp eq i32 %t1485, 14
  %t1535 = select i1 %t1534, %Block* %t1533, %Block* %t1528
  %t1536 = getelementptr inbounds %Statement, %Statement* %t1486, i32 0, i32 1
  %t1537 = bitcast [16 x i8]* %t1536 to i8*
  %t1538 = bitcast i8* %t1537 to %Block**
  %t1539 = load %Block*, %Block** %t1538
  %t1540 = icmp eq i32 %t1485, 15
  %t1541 = select i1 %t1540, %Block* %t1539, %Block* %t1535
  %t1542 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature zeroinitializer, %Block zeroinitializer, { %Statement*, i64 }* %interfaces)
  %t1543 = bitcast { %Diagnostic**, i64 }* %t1464 to { i8**, i64 }*
  %t1544 = bitcast { %Diagnostic*, i64 }* %t1542 to { i8**, i64 }*
  %t1545 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1543, { i8**, i64 }* %t1544)
  %t1546 = bitcast { i8**, i64 }* %t1545 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1546, { %Diagnostic**, i64 }** %l14
  %t1547 = load %ScopeResult, %ScopeResult* %l13
  %t1548 = extractvalue %ScopeResult %t1547, 0
  %t1549 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1548, 0
  %t1550 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l14
  %t1551 = insertvalue %ScopeResult %t1549, { %Diagnostic**, i64 }* %t1550, 1
  ret %ScopeResult %t1551
merge19:
  %t1552 = extractvalue %Statement %statement, 0
  %t1553 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1554 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1555 = icmp eq i32 %t1552, 0
  %t1556 = select i1 %t1555, i8* %t1554, i8* %t1553
  %t1557 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1558 = icmp eq i32 %t1552, 1
  %t1559 = select i1 %t1558, i8* %t1557, i8* %t1556
  %t1560 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1561 = icmp eq i32 %t1552, 2
  %t1562 = select i1 %t1561, i8* %t1560, i8* %t1559
  %t1563 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1564 = icmp eq i32 %t1552, 3
  %t1565 = select i1 %t1564, i8* %t1563, i8* %t1562
  %t1566 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1567 = icmp eq i32 %t1552, 4
  %t1568 = select i1 %t1567, i8* %t1566, i8* %t1565
  %t1569 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1570 = icmp eq i32 %t1552, 5
  %t1571 = select i1 %t1570, i8* %t1569, i8* %t1568
  %t1572 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1573 = icmp eq i32 %t1552, 6
  %t1574 = select i1 %t1573, i8* %t1572, i8* %t1571
  %t1575 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1576 = icmp eq i32 %t1552, 7
  %t1577 = select i1 %t1576, i8* %t1575, i8* %t1574
  %t1578 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1579 = icmp eq i32 %t1552, 8
  %t1580 = select i1 %t1579, i8* %t1578, i8* %t1577
  %t1581 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1582 = icmp eq i32 %t1552, 9
  %t1583 = select i1 %t1582, i8* %t1581, i8* %t1580
  %t1584 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1585 = icmp eq i32 %t1552, 10
  %t1586 = select i1 %t1585, i8* %t1584, i8* %t1583
  %t1587 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1588 = icmp eq i32 %t1552, 11
  %t1589 = select i1 %t1588, i8* %t1587, i8* %t1586
  %t1590 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1591 = icmp eq i32 %t1552, 12
  %t1592 = select i1 %t1591, i8* %t1590, i8* %t1589
  %t1593 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1594 = icmp eq i32 %t1552, 13
  %t1595 = select i1 %t1594, i8* %t1593, i8* %t1592
  %t1596 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1597 = icmp eq i32 %t1552, 14
  %t1598 = select i1 %t1597, i8* %t1596, i8* %t1595
  %t1599 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1600 = icmp eq i32 %t1552, 15
  %t1601 = select i1 %t1600, i8* %t1599, i8* %t1598
  %t1602 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1603 = icmp eq i32 %t1552, 16
  %t1604 = select i1 %t1603, i8* %t1602, i8* %t1601
  %t1605 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1606 = icmp eq i32 %t1552, 17
  %t1607 = select i1 %t1606, i8* %t1605, i8* %t1604
  %t1608 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1609 = icmp eq i32 %t1552, 18
  %t1610 = select i1 %t1609, i8* %t1608, i8* %t1607
  %t1611 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1612 = icmp eq i32 %t1552, 19
  %t1613 = select i1 %t1612, i8* %t1611, i8* %t1610
  %t1614 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1615 = icmp eq i32 %t1552, 20
  %t1616 = select i1 %t1615, i8* %t1614, i8* %t1613
  %t1617 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1618 = icmp eq i32 %t1552, 21
  %t1619 = select i1 %t1618, i8* %t1617, i8* %t1616
  %t1620 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1621 = icmp eq i32 %t1552, 22
  %t1622 = select i1 %t1621, i8* %t1620, i8* %t1619
  %s1623 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1623, i32 0, i32 0
  %t1624 = icmp eq i8* %t1622, %s1623
  br i1 %t1624, label %then20, label %merge21
then20:
  %t1625 = extractvalue %Statement %statement, 0
  %t1626 = alloca %Statement
  store %Statement %statement, %Statement* %t1626
  %t1627 = getelementptr inbounds %Statement, %Statement* %t1626, i32 0, i32 1
  %t1628 = bitcast [24 x i8]* %t1627 to i8*
  %t1629 = bitcast i8* %t1628 to %FunctionSignature**
  %t1630 = load %FunctionSignature*, %FunctionSignature** %t1629
  %t1631 = icmp eq i32 %t1625, 4
  %t1632 = select i1 %t1631, %FunctionSignature* %t1630, %FunctionSignature* null
  %t1633 = getelementptr inbounds %Statement, %Statement* %t1626, i32 0, i32 1
  %t1634 = bitcast [24 x i8]* %t1633 to i8*
  %t1635 = bitcast i8* %t1634 to %FunctionSignature**
  %t1636 = load %FunctionSignature*, %FunctionSignature** %t1635
  %t1637 = icmp eq i32 %t1625, 5
  %t1638 = select i1 %t1637, %FunctionSignature* %t1636, %FunctionSignature* %t1632
  %t1639 = getelementptr inbounds %Statement, %Statement* %t1626, i32 0, i32 1
  %t1640 = bitcast [24 x i8]* %t1639 to i8*
  %t1641 = bitcast i8* %t1640 to %FunctionSignature**
  %t1642 = load %FunctionSignature*, %FunctionSignature** %t1641
  %t1643 = icmp eq i32 %t1625, 7
  %t1644 = select i1 %t1643, %FunctionSignature* %t1642, %FunctionSignature* %t1638
  %t1645 = getelementptr %FunctionSignature, %FunctionSignature* %t1644, i32 0, i32 0
  %t1646 = load i8*, i8** %t1645
  %s1647 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1647, i32 0, i32 0
  %t1648 = extractvalue %Statement %statement, 0
  %t1649 = alloca %Statement
  store %Statement %statement, %Statement* %t1649
  %t1650 = getelementptr inbounds %Statement, %Statement* %t1649, i32 0, i32 1
  %t1651 = bitcast [24 x i8]* %t1650 to i8*
  %t1652 = bitcast i8* %t1651 to %FunctionSignature**
  %t1653 = load %FunctionSignature*, %FunctionSignature** %t1652
  %t1654 = icmp eq i32 %t1648, 4
  %t1655 = select i1 %t1654, %FunctionSignature* %t1653, %FunctionSignature* null
  %t1656 = getelementptr inbounds %Statement, %Statement* %t1649, i32 0, i32 1
  %t1657 = bitcast [24 x i8]* %t1656 to i8*
  %t1658 = bitcast i8* %t1657 to %FunctionSignature**
  %t1659 = load %FunctionSignature*, %FunctionSignature** %t1658
  %t1660 = icmp eq i32 %t1648, 5
  %t1661 = select i1 %t1660, %FunctionSignature* %t1659, %FunctionSignature* %t1655
  %t1662 = getelementptr inbounds %Statement, %Statement* %t1649, i32 0, i32 1
  %t1663 = bitcast [24 x i8]* %t1662 to i8*
  %t1664 = bitcast i8* %t1663 to %FunctionSignature**
  %t1665 = load %FunctionSignature*, %FunctionSignature** %t1664
  %t1666 = icmp eq i32 %t1648, 7
  %t1667 = select i1 %t1666, %FunctionSignature* %t1665, %FunctionSignature* %t1661
  %t1668 = getelementptr %FunctionSignature, %FunctionSignature* %t1667, i32 0, i32 6
  %t1669 = load %SourceSpan*, %SourceSpan** %t1668
  %t1670 = bitcast %SourceSpan* %t1669 to i8*
  %t1671 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1646, i8* %s1647, i8* %t1670)
  store %ScopeResult %t1671, %ScopeResult* %l15
  %t1672 = load %ScopeResult, %ScopeResult* %l15
  %t1673 = extractvalue %ScopeResult %t1672, 1
  store { %Diagnostic**, i64 }* %t1673, { %Diagnostic**, i64 }** %l16
  %t1674 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l16
  %t1675 = extractvalue %Statement %statement, 0
  %t1676 = alloca %Statement
  store %Statement %statement, %Statement* %t1676
  %t1677 = getelementptr inbounds %Statement, %Statement* %t1676, i32 0, i32 1
  %t1678 = bitcast [24 x i8]* %t1677 to i8*
  %t1679 = bitcast i8* %t1678 to %FunctionSignature**
  %t1680 = load %FunctionSignature*, %FunctionSignature** %t1679
  %t1681 = icmp eq i32 %t1675, 4
  %t1682 = select i1 %t1681, %FunctionSignature* %t1680, %FunctionSignature* null
  %t1683 = getelementptr inbounds %Statement, %Statement* %t1676, i32 0, i32 1
  %t1684 = bitcast [24 x i8]* %t1683 to i8*
  %t1685 = bitcast i8* %t1684 to %FunctionSignature**
  %t1686 = load %FunctionSignature*, %FunctionSignature** %t1685
  %t1687 = icmp eq i32 %t1675, 5
  %t1688 = select i1 %t1687, %FunctionSignature* %t1686, %FunctionSignature* %t1682
  %t1689 = getelementptr inbounds %Statement, %Statement* %t1676, i32 0, i32 1
  %t1690 = bitcast [24 x i8]* %t1689 to i8*
  %t1691 = bitcast i8* %t1690 to %FunctionSignature**
  %t1692 = load %FunctionSignature*, %FunctionSignature** %t1691
  %t1693 = icmp eq i32 %t1675, 7
  %t1694 = select i1 %t1693, %FunctionSignature* %t1692, %FunctionSignature* %t1688
  %t1695 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature zeroinitializer)
  %t1696 = bitcast { %Diagnostic**, i64 }* %t1674 to { i8**, i64 }*
  %t1697 = bitcast { %Diagnostic*, i64 }* %t1695 to { i8**, i64 }*
  %t1698 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1696, { i8**, i64 }* %t1697)
  %t1699 = bitcast { i8**, i64 }* %t1698 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1699, { %Diagnostic**, i64 }** %l16
  %t1700 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l16
  %t1701 = extractvalue %Statement %statement, 0
  %t1702 = alloca %Statement
  store %Statement %statement, %Statement* %t1702
  %t1703 = getelementptr inbounds %Statement, %Statement* %t1702, i32 0, i32 1
  %t1704 = bitcast [24 x i8]* %t1703 to i8*
  %t1705 = bitcast i8* %t1704 to %FunctionSignature**
  %t1706 = load %FunctionSignature*, %FunctionSignature** %t1705
  %t1707 = icmp eq i32 %t1701, 4
  %t1708 = select i1 %t1707, %FunctionSignature* %t1706, %FunctionSignature* null
  %t1709 = getelementptr inbounds %Statement, %Statement* %t1702, i32 0, i32 1
  %t1710 = bitcast [24 x i8]* %t1709 to i8*
  %t1711 = bitcast i8* %t1710 to %FunctionSignature**
  %t1712 = load %FunctionSignature*, %FunctionSignature** %t1711
  %t1713 = icmp eq i32 %t1701, 5
  %t1714 = select i1 %t1713, %FunctionSignature* %t1712, %FunctionSignature* %t1708
  %t1715 = getelementptr inbounds %Statement, %Statement* %t1702, i32 0, i32 1
  %t1716 = bitcast [24 x i8]* %t1715 to i8*
  %t1717 = bitcast i8* %t1716 to %FunctionSignature**
  %t1718 = load %FunctionSignature*, %FunctionSignature** %t1717
  %t1719 = icmp eq i32 %t1701, 7
  %t1720 = select i1 %t1719, %FunctionSignature* %t1718, %FunctionSignature* %t1714
  %t1721 = extractvalue %Statement %statement, 0
  %t1722 = alloca %Statement
  store %Statement %statement, %Statement* %t1722
  %t1723 = getelementptr inbounds %Statement, %Statement* %t1722, i32 0, i32 1
  %t1724 = bitcast [24 x i8]* %t1723 to i8*
  %t1725 = getelementptr inbounds i8, i8* %t1724, i64 8
  %t1726 = bitcast i8* %t1725 to %Block**
  %t1727 = load %Block*, %Block** %t1726
  %t1728 = icmp eq i32 %t1721, 4
  %t1729 = select i1 %t1728, %Block* %t1727, %Block* null
  %t1730 = getelementptr inbounds %Statement, %Statement* %t1722, i32 0, i32 1
  %t1731 = bitcast [24 x i8]* %t1730 to i8*
  %t1732 = getelementptr inbounds i8, i8* %t1731, i64 8
  %t1733 = bitcast i8* %t1732 to %Block**
  %t1734 = load %Block*, %Block** %t1733
  %t1735 = icmp eq i32 %t1721, 5
  %t1736 = select i1 %t1735, %Block* %t1734, %Block* %t1729
  %t1737 = getelementptr inbounds %Statement, %Statement* %t1722, i32 0, i32 1
  %t1738 = bitcast [40 x i8]* %t1737 to i8*
  %t1739 = getelementptr inbounds i8, i8* %t1738, i64 16
  %t1740 = bitcast i8* %t1739 to %Block**
  %t1741 = load %Block*, %Block** %t1740
  %t1742 = icmp eq i32 %t1721, 6
  %t1743 = select i1 %t1742, %Block* %t1741, %Block* %t1736
  %t1744 = getelementptr inbounds %Statement, %Statement* %t1722, i32 0, i32 1
  %t1745 = bitcast [24 x i8]* %t1744 to i8*
  %t1746 = getelementptr inbounds i8, i8* %t1745, i64 8
  %t1747 = bitcast i8* %t1746 to %Block**
  %t1748 = load %Block*, %Block** %t1747
  %t1749 = icmp eq i32 %t1721, 7
  %t1750 = select i1 %t1749, %Block* %t1748, %Block* %t1743
  %t1751 = getelementptr inbounds %Statement, %Statement* %t1722, i32 0, i32 1
  %t1752 = bitcast [40 x i8]* %t1751 to i8*
  %t1753 = getelementptr inbounds i8, i8* %t1752, i64 24
  %t1754 = bitcast i8* %t1753 to %Block**
  %t1755 = load %Block*, %Block** %t1754
  %t1756 = icmp eq i32 %t1721, 12
  %t1757 = select i1 %t1756, %Block* %t1755, %Block* %t1750
  %t1758 = getelementptr inbounds %Statement, %Statement* %t1722, i32 0, i32 1
  %t1759 = bitcast [24 x i8]* %t1758 to i8*
  %t1760 = getelementptr inbounds i8, i8* %t1759, i64 8
  %t1761 = bitcast i8* %t1760 to %Block**
  %t1762 = load %Block*, %Block** %t1761
  %t1763 = icmp eq i32 %t1721, 13
  %t1764 = select i1 %t1763, %Block* %t1762, %Block* %t1757
  %t1765 = getelementptr inbounds %Statement, %Statement* %t1722, i32 0, i32 1
  %t1766 = bitcast [24 x i8]* %t1765 to i8*
  %t1767 = getelementptr inbounds i8, i8* %t1766, i64 8
  %t1768 = bitcast i8* %t1767 to %Block**
  %t1769 = load %Block*, %Block** %t1768
  %t1770 = icmp eq i32 %t1721, 14
  %t1771 = select i1 %t1770, %Block* %t1769, %Block* %t1764
  %t1772 = getelementptr inbounds %Statement, %Statement* %t1722, i32 0, i32 1
  %t1773 = bitcast [16 x i8]* %t1772 to i8*
  %t1774 = bitcast i8* %t1773 to %Block**
  %t1775 = load %Block*, %Block** %t1774
  %t1776 = icmp eq i32 %t1721, 15
  %t1777 = select i1 %t1776, %Block* %t1775, %Block* %t1771
  %t1778 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature zeroinitializer, %Block zeroinitializer, { %Statement*, i64 }* %interfaces)
  %t1779 = bitcast { %Diagnostic**, i64 }* %t1700 to { i8**, i64 }*
  %t1780 = bitcast { %Diagnostic*, i64 }* %t1778 to { i8**, i64 }*
  %t1781 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1779, { i8**, i64 }* %t1780)
  %t1782 = bitcast { i8**, i64 }* %t1781 to { %Diagnostic**, i64 }*
  store { %Diagnostic**, i64 }* %t1782, { %Diagnostic**, i64 }** %l16
  %t1783 = load %ScopeResult, %ScopeResult* %l15
  %t1784 = extractvalue %ScopeResult %t1783, 0
  %t1785 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t1784, 0
  %t1786 = load { %Diagnostic**, i64 }*, { %Diagnostic**, i64 }** %l16
  %t1787 = insertvalue %ScopeResult %t1785, { %Diagnostic**, i64 }* %t1786, 1
  ret %ScopeResult %t1787
merge21:
  %t1788 = extractvalue %Statement %statement, 0
  %t1789 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1790 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1791 = icmp eq i32 %t1788, 0
  %t1792 = select i1 %t1791, i8* %t1790, i8* %t1789
  %t1793 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1794 = icmp eq i32 %t1788, 1
  %t1795 = select i1 %t1794, i8* %t1793, i8* %t1792
  %t1796 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1797 = icmp eq i32 %t1788, 2
  %t1798 = select i1 %t1797, i8* %t1796, i8* %t1795
  %t1799 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1800 = icmp eq i32 %t1788, 3
  %t1801 = select i1 %t1800, i8* %t1799, i8* %t1798
  %t1802 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1803 = icmp eq i32 %t1788, 4
  %t1804 = select i1 %t1803, i8* %t1802, i8* %t1801
  %t1805 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1806 = icmp eq i32 %t1788, 5
  %t1807 = select i1 %t1806, i8* %t1805, i8* %t1804
  %t1808 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1809 = icmp eq i32 %t1788, 6
  %t1810 = select i1 %t1809, i8* %t1808, i8* %t1807
  %t1811 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1812 = icmp eq i32 %t1788, 7
  %t1813 = select i1 %t1812, i8* %t1811, i8* %t1810
  %t1814 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1815 = icmp eq i32 %t1788, 8
  %t1816 = select i1 %t1815, i8* %t1814, i8* %t1813
  %t1817 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1818 = icmp eq i32 %t1788, 9
  %t1819 = select i1 %t1818, i8* %t1817, i8* %t1816
  %t1820 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1821 = icmp eq i32 %t1788, 10
  %t1822 = select i1 %t1821, i8* %t1820, i8* %t1819
  %t1823 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1824 = icmp eq i32 %t1788, 11
  %t1825 = select i1 %t1824, i8* %t1823, i8* %t1822
  %t1826 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1827 = icmp eq i32 %t1788, 12
  %t1828 = select i1 %t1827, i8* %t1826, i8* %t1825
  %t1829 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1830 = icmp eq i32 %t1788, 13
  %t1831 = select i1 %t1830, i8* %t1829, i8* %t1828
  %t1832 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1833 = icmp eq i32 %t1788, 14
  %t1834 = select i1 %t1833, i8* %t1832, i8* %t1831
  %t1835 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1836 = icmp eq i32 %t1788, 15
  %t1837 = select i1 %t1836, i8* %t1835, i8* %t1834
  %t1838 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1839 = icmp eq i32 %t1788, 16
  %t1840 = select i1 %t1839, i8* %t1838, i8* %t1837
  %t1841 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1842 = icmp eq i32 %t1788, 17
  %t1843 = select i1 %t1842, i8* %t1841, i8* %t1840
  %t1844 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1845 = icmp eq i32 %t1788, 18
  %t1846 = select i1 %t1845, i8* %t1844, i8* %t1843
  %t1847 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1848 = icmp eq i32 %t1788, 19
  %t1849 = select i1 %t1848, i8* %t1847, i8* %t1846
  %t1850 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1851 = icmp eq i32 %t1788, 20
  %t1852 = select i1 %t1851, i8* %t1850, i8* %t1849
  %t1853 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1854 = icmp eq i32 %t1788, 21
  %t1855 = select i1 %t1854, i8* %t1853, i8* %t1852
  %t1856 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1857 = icmp eq i32 %t1788, 22
  %t1858 = select i1 %t1857, i8* %t1856, i8* %t1855
  %s1859 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1859, i32 0, i32 0
  %t1860 = icmp eq i8* %t1858, %s1859
  br i1 %t1860, label %then22, label %merge23
then22:
  %t1861 = extractvalue %Statement %statement, 0
  %t1862 = alloca %Statement
  store %Statement %statement, %Statement* %t1862
  %t1863 = getelementptr inbounds %Statement, %Statement* %t1862, i32 0, i32 1
  %t1864 = bitcast [48 x i8]* %t1863 to i8*
  %t1865 = bitcast i8* %t1864 to i8**
  %t1866 = load i8*, i8** %t1865
  %t1867 = icmp eq i32 %t1861, 2
  %t1868 = select i1 %t1867, i8* %t1866, i8* null
  %t1869 = getelementptr inbounds %Statement, %Statement* %t1862, i32 0, i32 1
  %t1870 = bitcast [48 x i8]* %t1869 to i8*
  %t1871 = bitcast i8* %t1870 to i8**
  %t1872 = load i8*, i8** %t1871
  %t1873 = icmp eq i32 %t1861, 3
  %t1874 = select i1 %t1873, i8* %t1872, i8* %t1868
  %t1875 = getelementptr inbounds %Statement, %Statement* %t1862, i32 0, i32 1
  %t1876 = bitcast [40 x i8]* %t1875 to i8*
  %t1877 = bitcast i8* %t1876 to i8**
  %t1878 = load i8*, i8** %t1877
  %t1879 = icmp eq i32 %t1861, 6
  %t1880 = select i1 %t1879, i8* %t1878, i8* %t1874
  %t1881 = getelementptr inbounds %Statement, %Statement* %t1862, i32 0, i32 1
  %t1882 = bitcast [56 x i8]* %t1881 to i8*
  %t1883 = bitcast i8* %t1882 to i8**
  %t1884 = load i8*, i8** %t1883
  %t1885 = icmp eq i32 %t1861, 8
  %t1886 = select i1 %t1885, i8* %t1884, i8* %t1880
  %t1887 = getelementptr inbounds %Statement, %Statement* %t1862, i32 0, i32 1
  %t1888 = bitcast [40 x i8]* %t1887 to i8*
  %t1889 = bitcast i8* %t1888 to i8**
  %t1890 = load i8*, i8** %t1889
  %t1891 = icmp eq i32 %t1861, 9
  %t1892 = select i1 %t1891, i8* %t1890, i8* %t1886
  %t1893 = getelementptr inbounds %Statement, %Statement* %t1862, i32 0, i32 1
  %t1894 = bitcast [40 x i8]* %t1893 to i8*
  %t1895 = bitcast i8* %t1894 to i8**
  %t1896 = load i8*, i8** %t1895
  %t1897 = icmp eq i32 %t1861, 10
  %t1898 = select i1 %t1897, i8* %t1896, i8* %t1892
  %t1899 = getelementptr inbounds %Statement, %Statement* %t1862, i32 0, i32 1
  %t1900 = bitcast [40 x i8]* %t1899 to i8*
  %t1901 = bitcast i8* %t1900 to i8**
  %t1902 = load i8*, i8** %t1901
  %t1903 = icmp eq i32 %t1861, 11
  %t1904 = select i1 %t1903, i8* %t1902, i8* %t1898
  %s1905 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1905, i32 0, i32 0
  %t1906 = extractvalue %Statement %statement, 0
  %t1907 = alloca %Statement
  store %Statement %statement, %Statement* %t1907
  %t1908 = getelementptr inbounds %Statement, %Statement* %t1907, i32 0, i32 1
  %t1909 = bitcast [48 x i8]* %t1908 to i8*
  %t1910 = getelementptr inbounds i8, i8* %t1909, i64 8
  %t1911 = bitcast i8* %t1910 to %SourceSpan**
  %t1912 = load %SourceSpan*, %SourceSpan** %t1911
  %t1913 = icmp eq i32 %t1906, 3
  %t1914 = select i1 %t1913, %SourceSpan* %t1912, %SourceSpan* null
  %t1915 = getelementptr inbounds %Statement, %Statement* %t1907, i32 0, i32 1
  %t1916 = bitcast [40 x i8]* %t1915 to i8*
  %t1917 = getelementptr inbounds i8, i8* %t1916, i64 8
  %t1918 = bitcast i8* %t1917 to %SourceSpan**
  %t1919 = load %SourceSpan*, %SourceSpan** %t1918
  %t1920 = icmp eq i32 %t1906, 6
  %t1921 = select i1 %t1920, %SourceSpan* %t1919, %SourceSpan* %t1914
  %t1922 = getelementptr inbounds %Statement, %Statement* %t1907, i32 0, i32 1
  %t1923 = bitcast [56 x i8]* %t1922 to i8*
  %t1924 = getelementptr inbounds i8, i8* %t1923, i64 8
  %t1925 = bitcast i8* %t1924 to %SourceSpan**
  %t1926 = load %SourceSpan*, %SourceSpan** %t1925
  %t1927 = icmp eq i32 %t1906, 8
  %t1928 = select i1 %t1927, %SourceSpan* %t1926, %SourceSpan* %t1921
  %t1929 = getelementptr inbounds %Statement, %Statement* %t1907, i32 0, i32 1
  %t1930 = bitcast [40 x i8]* %t1929 to i8*
  %t1931 = getelementptr inbounds i8, i8* %t1930, i64 8
  %t1932 = bitcast i8* %t1931 to %SourceSpan**
  %t1933 = load %SourceSpan*, %SourceSpan** %t1932
  %t1934 = icmp eq i32 %t1906, 9
  %t1935 = select i1 %t1934, %SourceSpan* %t1933, %SourceSpan* %t1928
  %t1936 = getelementptr inbounds %Statement, %Statement* %t1907, i32 0, i32 1
  %t1937 = bitcast [40 x i8]* %t1936 to i8*
  %t1938 = getelementptr inbounds i8, i8* %t1937, i64 8
  %t1939 = bitcast i8* %t1938 to %SourceSpan**
  %t1940 = load %SourceSpan*, %SourceSpan** %t1939
  %t1941 = icmp eq i32 %t1906, 10
  %t1942 = select i1 %t1941, %SourceSpan* %t1940, %SourceSpan* %t1935
  %t1943 = getelementptr inbounds %Statement, %Statement* %t1907, i32 0, i32 1
  %t1944 = bitcast [40 x i8]* %t1943 to i8*
  %t1945 = getelementptr inbounds i8, i8* %t1944, i64 8
  %t1946 = bitcast i8* %t1945 to %SourceSpan**
  %t1947 = load %SourceSpan*, %SourceSpan** %t1946
  %t1948 = icmp eq i32 %t1906, 11
  %t1949 = select i1 %t1948, %SourceSpan* %t1947, %SourceSpan* %t1942
  %t1950 = bitcast %SourceSpan* %t1949 to i8*
  %t1951 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1904, i8* %s1905, i8* %t1950)
  store %ScopeResult %t1951, %ScopeResult* %l17
  %t1952 = load %ScopeResult, %ScopeResult* %l17
  %t1953 = extractvalue %ScopeResult %t1952, 1
  %t1954 = extractvalue %Statement %statement, 0
  %t1955 = alloca %Statement
  store %Statement %statement, %Statement* %t1955
  %t1956 = getelementptr inbounds %Statement, %Statement* %t1955, i32 0, i32 1
  %t1957 = bitcast [24 x i8]* %t1956 to i8*
  %t1958 = getelementptr inbounds i8, i8* %t1957, i64 8
  %t1959 = bitcast i8* %t1958 to %Block**
  %t1960 = load %Block*, %Block** %t1959
  %t1961 = icmp eq i32 %t1954, 4
  %t1962 = select i1 %t1961, %Block* %t1960, %Block* null
  %t1963 = getelementptr inbounds %Statement, %Statement* %t1955, i32 0, i32 1
  %t1964 = bitcast [24 x i8]* %t1963 to i8*
  %t1965 = getelementptr inbounds i8, i8* %t1964, i64 8
  %t1966 = bitcast i8* %t1965 to %Block**
  %t1967 = load %Block*, %Block** %t1966
  %t1968 = icmp eq i32 %t1954, 5
  %t1969 = select i1 %t1968, %Block* %t1967, %Block* %t1962
  %t1970 = getelementptr inbounds %Statement, %Statement* %t1955, i32 0, i32 1
  %t1971 = bitcast [40 x i8]* %t1970 to i8*
  %t1972 = getelementptr inbounds i8, i8* %t1971, i64 16
  %t1973 = bitcast i8* %t1972 to %Block**
  %t1974 = load %Block*, %Block** %t1973
  %t1975 = icmp eq i32 %t1954, 6
  %t1976 = select i1 %t1975, %Block* %t1974, %Block* %t1969
  %t1977 = getelementptr inbounds %Statement, %Statement* %t1955, i32 0, i32 1
  %t1978 = bitcast [24 x i8]* %t1977 to i8*
  %t1979 = getelementptr inbounds i8, i8* %t1978, i64 8
  %t1980 = bitcast i8* %t1979 to %Block**
  %t1981 = load %Block*, %Block** %t1980
  %t1982 = icmp eq i32 %t1954, 7
  %t1983 = select i1 %t1982, %Block* %t1981, %Block* %t1976
  %t1984 = getelementptr inbounds %Statement, %Statement* %t1955, i32 0, i32 1
  %t1985 = bitcast [40 x i8]* %t1984 to i8*
  %t1986 = getelementptr inbounds i8, i8* %t1985, i64 24
  %t1987 = bitcast i8* %t1986 to %Block**
  %t1988 = load %Block*, %Block** %t1987
  %t1989 = icmp eq i32 %t1954, 12
  %t1990 = select i1 %t1989, %Block* %t1988, %Block* %t1983
  %t1991 = getelementptr inbounds %Statement, %Statement* %t1955, i32 0, i32 1
  %t1992 = bitcast [24 x i8]* %t1991 to i8*
  %t1993 = getelementptr inbounds i8, i8* %t1992, i64 8
  %t1994 = bitcast i8* %t1993 to %Block**
  %t1995 = load %Block*, %Block** %t1994
  %t1996 = icmp eq i32 %t1954, 13
  %t1997 = select i1 %t1996, %Block* %t1995, %Block* %t1990
  %t1998 = getelementptr inbounds %Statement, %Statement* %t1955, i32 0, i32 1
  %t1999 = bitcast [24 x i8]* %t1998 to i8*
  %t2000 = getelementptr inbounds i8, i8* %t1999, i64 8
  %t2001 = bitcast i8* %t2000 to %Block**
  %t2002 = load %Block*, %Block** %t2001
  %t2003 = icmp eq i32 %t1954, 14
  %t2004 = select i1 %t2003, %Block* %t2002, %Block* %t1997
  %t2005 = getelementptr inbounds %Statement, %Statement* %t1955, i32 0, i32 1
  %t2006 = bitcast [16 x i8]* %t2005 to i8*
  %t2007 = bitcast i8* %t2006 to %Block**
  %t2008 = load %Block*, %Block** %t2007
  %t2009 = icmp eq i32 %t1954, 15
  %t2010 = select i1 %t2009, %Block* %t2008, %Block* %t2004
  %t2011 = alloca [0 x double]
  %t2012 = getelementptr [0 x double], [0 x double]* %t2011, i32 0, i32 0
  %t2013 = alloca { double*, i64 }
  %t2014 = getelementptr { double*, i64 }, { double*, i64 }* %t2013, i32 0, i32 0
  store double* %t2012, double** %t2014
  %t2015 = getelementptr { double*, i64 }, { double*, i64 }* %t2013, i32 0, i32 1
  store i64 0, i64* %t2015
  %t2016 = bitcast { double*, i64 }* %t2013 to { %SymbolEntry*, i64 }*
  %t2017 = call { %Diagnostic*, i64 }* @check_block(%Block zeroinitializer, { %SymbolEntry*, i64 }* %t2016, { %Statement*, i64 }* %interfaces)
  %t2018 = bitcast { %Diagnostic**, i64 }* %t1953 to { i8**, i64 }*
  %t2019 = bitcast { %Diagnostic*, i64 }* %t2017 to { i8**, i64 }*
  %t2020 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2018, { i8**, i64 }* %t2019)
  store { i8**, i64 }* %t2020, { i8**, i64 }** %l18
  %t2021 = load %ScopeResult, %ScopeResult* %l17
  %t2022 = extractvalue %ScopeResult %t2021, 0
  %t2023 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2022, 0
  %t2024 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t2025 = bitcast { i8**, i64 }* %t2024 to { %Diagnostic**, i64 }*
  %t2026 = insertvalue %ScopeResult %t2023, { %Diagnostic**, i64 }* %t2025, 1
  ret %ScopeResult %t2026
merge23:
  %t2027 = extractvalue %Statement %statement, 0
  %t2028 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2029 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2030 = icmp eq i32 %t2027, 0
  %t2031 = select i1 %t2030, i8* %t2029, i8* %t2028
  %t2032 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2033 = icmp eq i32 %t2027, 1
  %t2034 = select i1 %t2033, i8* %t2032, i8* %t2031
  %t2035 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2036 = icmp eq i32 %t2027, 2
  %t2037 = select i1 %t2036, i8* %t2035, i8* %t2034
  %t2038 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2039 = icmp eq i32 %t2027, 3
  %t2040 = select i1 %t2039, i8* %t2038, i8* %t2037
  %t2041 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2042 = icmp eq i32 %t2027, 4
  %t2043 = select i1 %t2042, i8* %t2041, i8* %t2040
  %t2044 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2045 = icmp eq i32 %t2027, 5
  %t2046 = select i1 %t2045, i8* %t2044, i8* %t2043
  %t2047 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2048 = icmp eq i32 %t2027, 6
  %t2049 = select i1 %t2048, i8* %t2047, i8* %t2046
  %t2050 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2051 = icmp eq i32 %t2027, 7
  %t2052 = select i1 %t2051, i8* %t2050, i8* %t2049
  %t2053 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2054 = icmp eq i32 %t2027, 8
  %t2055 = select i1 %t2054, i8* %t2053, i8* %t2052
  %t2056 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2057 = icmp eq i32 %t2027, 9
  %t2058 = select i1 %t2057, i8* %t2056, i8* %t2055
  %t2059 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2060 = icmp eq i32 %t2027, 10
  %t2061 = select i1 %t2060, i8* %t2059, i8* %t2058
  %t2062 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2063 = icmp eq i32 %t2027, 11
  %t2064 = select i1 %t2063, i8* %t2062, i8* %t2061
  %t2065 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2066 = icmp eq i32 %t2027, 12
  %t2067 = select i1 %t2066, i8* %t2065, i8* %t2064
  %t2068 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2069 = icmp eq i32 %t2027, 13
  %t2070 = select i1 %t2069, i8* %t2068, i8* %t2067
  %t2071 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2072 = icmp eq i32 %t2027, 14
  %t2073 = select i1 %t2072, i8* %t2071, i8* %t2070
  %t2074 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2075 = icmp eq i32 %t2027, 15
  %t2076 = select i1 %t2075, i8* %t2074, i8* %t2073
  %t2077 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2078 = icmp eq i32 %t2027, 16
  %t2079 = select i1 %t2078, i8* %t2077, i8* %t2076
  %t2080 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2081 = icmp eq i32 %t2027, 17
  %t2082 = select i1 %t2081, i8* %t2080, i8* %t2079
  %t2083 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2084 = icmp eq i32 %t2027, 18
  %t2085 = select i1 %t2084, i8* %t2083, i8* %t2082
  %t2086 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2087 = icmp eq i32 %t2027, 19
  %t2088 = select i1 %t2087, i8* %t2086, i8* %t2085
  %t2089 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2090 = icmp eq i32 %t2027, 20
  %t2091 = select i1 %t2090, i8* %t2089, i8* %t2088
  %t2092 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2093 = icmp eq i32 %t2027, 21
  %t2094 = select i1 %t2093, i8* %t2092, i8* %t2091
  %t2095 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2096 = icmp eq i32 %t2027, 22
  %t2097 = select i1 %t2096, i8* %t2095, i8* %t2094
  %s2098 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.2098, i32 0, i32 0
  %t2099 = icmp eq i8* %t2097, %s2098
  br i1 %t2099, label %then24, label %merge25
then24:
  %t2100 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2101 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2100, 0
  %t2102 = extractvalue %Statement %statement, 0
  %t2103 = alloca %Statement
  store %Statement %statement, %Statement* %t2103
  %t2104 = getelementptr inbounds %Statement, %Statement* %t2103, i32 0, i32 1
  %t2105 = bitcast [24 x i8]* %t2104 to i8*
  %t2106 = getelementptr inbounds i8, i8* %t2105, i64 8
  %t2107 = bitcast i8* %t2106 to %Block**
  %t2108 = load %Block*, %Block** %t2107
  %t2109 = icmp eq i32 %t2102, 4
  %t2110 = select i1 %t2109, %Block* %t2108, %Block* null
  %t2111 = getelementptr inbounds %Statement, %Statement* %t2103, i32 0, i32 1
  %t2112 = bitcast [24 x i8]* %t2111 to i8*
  %t2113 = getelementptr inbounds i8, i8* %t2112, i64 8
  %t2114 = bitcast i8* %t2113 to %Block**
  %t2115 = load %Block*, %Block** %t2114
  %t2116 = icmp eq i32 %t2102, 5
  %t2117 = select i1 %t2116, %Block* %t2115, %Block* %t2110
  %t2118 = getelementptr inbounds %Statement, %Statement* %t2103, i32 0, i32 1
  %t2119 = bitcast [40 x i8]* %t2118 to i8*
  %t2120 = getelementptr inbounds i8, i8* %t2119, i64 16
  %t2121 = bitcast i8* %t2120 to %Block**
  %t2122 = load %Block*, %Block** %t2121
  %t2123 = icmp eq i32 %t2102, 6
  %t2124 = select i1 %t2123, %Block* %t2122, %Block* %t2117
  %t2125 = getelementptr inbounds %Statement, %Statement* %t2103, i32 0, i32 1
  %t2126 = bitcast [24 x i8]* %t2125 to i8*
  %t2127 = getelementptr inbounds i8, i8* %t2126, i64 8
  %t2128 = bitcast i8* %t2127 to %Block**
  %t2129 = load %Block*, %Block** %t2128
  %t2130 = icmp eq i32 %t2102, 7
  %t2131 = select i1 %t2130, %Block* %t2129, %Block* %t2124
  %t2132 = getelementptr inbounds %Statement, %Statement* %t2103, i32 0, i32 1
  %t2133 = bitcast [40 x i8]* %t2132 to i8*
  %t2134 = getelementptr inbounds i8, i8* %t2133, i64 24
  %t2135 = bitcast i8* %t2134 to %Block**
  %t2136 = load %Block*, %Block** %t2135
  %t2137 = icmp eq i32 %t2102, 12
  %t2138 = select i1 %t2137, %Block* %t2136, %Block* %t2131
  %t2139 = getelementptr inbounds %Statement, %Statement* %t2103, i32 0, i32 1
  %t2140 = bitcast [24 x i8]* %t2139 to i8*
  %t2141 = getelementptr inbounds i8, i8* %t2140, i64 8
  %t2142 = bitcast i8* %t2141 to %Block**
  %t2143 = load %Block*, %Block** %t2142
  %t2144 = icmp eq i32 %t2102, 13
  %t2145 = select i1 %t2144, %Block* %t2143, %Block* %t2138
  %t2146 = getelementptr inbounds %Statement, %Statement* %t2103, i32 0, i32 1
  %t2147 = bitcast [24 x i8]* %t2146 to i8*
  %t2148 = getelementptr inbounds i8, i8* %t2147, i64 8
  %t2149 = bitcast i8* %t2148 to %Block**
  %t2150 = load %Block*, %Block** %t2149
  %t2151 = icmp eq i32 %t2102, 14
  %t2152 = select i1 %t2151, %Block* %t2150, %Block* %t2145
  %t2153 = getelementptr inbounds %Statement, %Statement* %t2103, i32 0, i32 1
  %t2154 = bitcast [16 x i8]* %t2153 to i8*
  %t2155 = bitcast i8* %t2154 to %Block**
  %t2156 = load %Block*, %Block** %t2155
  %t2157 = icmp eq i32 %t2102, 15
  %t2158 = select i1 %t2157, %Block* %t2156, %Block* %t2152
  %t2159 = call { %Diagnostic*, i64 }* @check_block(%Block zeroinitializer, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2160 = bitcast { %Diagnostic*, i64 }* %t2159 to { %Diagnostic**, i64 }*
  %t2161 = insertvalue %ScopeResult %t2101, { %Diagnostic**, i64 }* %t2160, 1
  ret %ScopeResult %t2161
merge25:
  %t2162 = extractvalue %Statement %statement, 0
  %t2163 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2164 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2165 = icmp eq i32 %t2162, 0
  %t2166 = select i1 %t2165, i8* %t2164, i8* %t2163
  %t2167 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2168 = icmp eq i32 %t2162, 1
  %t2169 = select i1 %t2168, i8* %t2167, i8* %t2166
  %t2170 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2171 = icmp eq i32 %t2162, 2
  %t2172 = select i1 %t2171, i8* %t2170, i8* %t2169
  %t2173 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2174 = icmp eq i32 %t2162, 3
  %t2175 = select i1 %t2174, i8* %t2173, i8* %t2172
  %t2176 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2177 = icmp eq i32 %t2162, 4
  %t2178 = select i1 %t2177, i8* %t2176, i8* %t2175
  %t2179 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2180 = icmp eq i32 %t2162, 5
  %t2181 = select i1 %t2180, i8* %t2179, i8* %t2178
  %t2182 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2183 = icmp eq i32 %t2162, 6
  %t2184 = select i1 %t2183, i8* %t2182, i8* %t2181
  %t2185 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2186 = icmp eq i32 %t2162, 7
  %t2187 = select i1 %t2186, i8* %t2185, i8* %t2184
  %t2188 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2189 = icmp eq i32 %t2162, 8
  %t2190 = select i1 %t2189, i8* %t2188, i8* %t2187
  %t2191 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2192 = icmp eq i32 %t2162, 9
  %t2193 = select i1 %t2192, i8* %t2191, i8* %t2190
  %t2194 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2195 = icmp eq i32 %t2162, 10
  %t2196 = select i1 %t2195, i8* %t2194, i8* %t2193
  %t2197 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2198 = icmp eq i32 %t2162, 11
  %t2199 = select i1 %t2198, i8* %t2197, i8* %t2196
  %t2200 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2201 = icmp eq i32 %t2162, 12
  %t2202 = select i1 %t2201, i8* %t2200, i8* %t2199
  %t2203 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2204 = icmp eq i32 %t2162, 13
  %t2205 = select i1 %t2204, i8* %t2203, i8* %t2202
  %t2206 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2207 = icmp eq i32 %t2162, 14
  %t2208 = select i1 %t2207, i8* %t2206, i8* %t2205
  %t2209 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2210 = icmp eq i32 %t2162, 15
  %t2211 = select i1 %t2210, i8* %t2209, i8* %t2208
  %t2212 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2213 = icmp eq i32 %t2162, 16
  %t2214 = select i1 %t2213, i8* %t2212, i8* %t2211
  %t2215 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2216 = icmp eq i32 %t2162, 17
  %t2217 = select i1 %t2216, i8* %t2215, i8* %t2214
  %t2218 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2219 = icmp eq i32 %t2162, 18
  %t2220 = select i1 %t2219, i8* %t2218, i8* %t2217
  %t2221 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2222 = icmp eq i32 %t2162, 19
  %t2223 = select i1 %t2222, i8* %t2221, i8* %t2220
  %t2224 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2225 = icmp eq i32 %t2162, 20
  %t2226 = select i1 %t2225, i8* %t2224, i8* %t2223
  %t2227 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2228 = icmp eq i32 %t2162, 21
  %t2229 = select i1 %t2228, i8* %t2227, i8* %t2226
  %t2230 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2231 = icmp eq i32 %t2162, 22
  %t2232 = select i1 %t2231, i8* %t2230, i8* %t2229
  %s2233 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.2233, i32 0, i32 0
  %t2234 = icmp eq i8* %t2232, %s2233
  br i1 %t2234, label %then26, label %merge27
then26:
  %t2235 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2236 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2235, 0
  %t2237 = extractvalue %Statement %statement, 0
  %t2238 = alloca %Statement
  store %Statement %statement, %Statement* %t2238
  %t2239 = getelementptr inbounds %Statement, %Statement* %t2238, i32 0, i32 1
  %t2240 = bitcast [24 x i8]* %t2239 to i8*
  %t2241 = getelementptr inbounds i8, i8* %t2240, i64 8
  %t2242 = bitcast i8* %t2241 to %Block**
  %t2243 = load %Block*, %Block** %t2242
  %t2244 = icmp eq i32 %t2237, 4
  %t2245 = select i1 %t2244, %Block* %t2243, %Block* null
  %t2246 = getelementptr inbounds %Statement, %Statement* %t2238, i32 0, i32 1
  %t2247 = bitcast [24 x i8]* %t2246 to i8*
  %t2248 = getelementptr inbounds i8, i8* %t2247, i64 8
  %t2249 = bitcast i8* %t2248 to %Block**
  %t2250 = load %Block*, %Block** %t2249
  %t2251 = icmp eq i32 %t2237, 5
  %t2252 = select i1 %t2251, %Block* %t2250, %Block* %t2245
  %t2253 = getelementptr inbounds %Statement, %Statement* %t2238, i32 0, i32 1
  %t2254 = bitcast [40 x i8]* %t2253 to i8*
  %t2255 = getelementptr inbounds i8, i8* %t2254, i64 16
  %t2256 = bitcast i8* %t2255 to %Block**
  %t2257 = load %Block*, %Block** %t2256
  %t2258 = icmp eq i32 %t2237, 6
  %t2259 = select i1 %t2258, %Block* %t2257, %Block* %t2252
  %t2260 = getelementptr inbounds %Statement, %Statement* %t2238, i32 0, i32 1
  %t2261 = bitcast [24 x i8]* %t2260 to i8*
  %t2262 = getelementptr inbounds i8, i8* %t2261, i64 8
  %t2263 = bitcast i8* %t2262 to %Block**
  %t2264 = load %Block*, %Block** %t2263
  %t2265 = icmp eq i32 %t2237, 7
  %t2266 = select i1 %t2265, %Block* %t2264, %Block* %t2259
  %t2267 = getelementptr inbounds %Statement, %Statement* %t2238, i32 0, i32 1
  %t2268 = bitcast [40 x i8]* %t2267 to i8*
  %t2269 = getelementptr inbounds i8, i8* %t2268, i64 24
  %t2270 = bitcast i8* %t2269 to %Block**
  %t2271 = load %Block*, %Block** %t2270
  %t2272 = icmp eq i32 %t2237, 12
  %t2273 = select i1 %t2272, %Block* %t2271, %Block* %t2266
  %t2274 = getelementptr inbounds %Statement, %Statement* %t2238, i32 0, i32 1
  %t2275 = bitcast [24 x i8]* %t2274 to i8*
  %t2276 = getelementptr inbounds i8, i8* %t2275, i64 8
  %t2277 = bitcast i8* %t2276 to %Block**
  %t2278 = load %Block*, %Block** %t2277
  %t2279 = icmp eq i32 %t2237, 13
  %t2280 = select i1 %t2279, %Block* %t2278, %Block* %t2273
  %t2281 = getelementptr inbounds %Statement, %Statement* %t2238, i32 0, i32 1
  %t2282 = bitcast [24 x i8]* %t2281 to i8*
  %t2283 = getelementptr inbounds i8, i8* %t2282, i64 8
  %t2284 = bitcast i8* %t2283 to %Block**
  %t2285 = load %Block*, %Block** %t2284
  %t2286 = icmp eq i32 %t2237, 14
  %t2287 = select i1 %t2286, %Block* %t2285, %Block* %t2280
  %t2288 = getelementptr inbounds %Statement, %Statement* %t2238, i32 0, i32 1
  %t2289 = bitcast [16 x i8]* %t2288 to i8*
  %t2290 = bitcast i8* %t2289 to %Block**
  %t2291 = load %Block*, %Block** %t2290
  %t2292 = icmp eq i32 %t2237, 15
  %t2293 = select i1 %t2292, %Block* %t2291, %Block* %t2287
  %t2294 = call { %Diagnostic*, i64 }* @check_block(%Block zeroinitializer, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2295 = bitcast { %Diagnostic*, i64 }* %t2294 to { %Diagnostic**, i64 }*
  %t2296 = insertvalue %ScopeResult %t2236, { %Diagnostic**, i64 }* %t2295, 1
  ret %ScopeResult %t2296
merge27:
  %t2297 = extractvalue %Statement %statement, 0
  %t2298 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2299 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2300 = icmp eq i32 %t2297, 0
  %t2301 = select i1 %t2300, i8* %t2299, i8* %t2298
  %t2302 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2303 = icmp eq i32 %t2297, 1
  %t2304 = select i1 %t2303, i8* %t2302, i8* %t2301
  %t2305 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2306 = icmp eq i32 %t2297, 2
  %t2307 = select i1 %t2306, i8* %t2305, i8* %t2304
  %t2308 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2309 = icmp eq i32 %t2297, 3
  %t2310 = select i1 %t2309, i8* %t2308, i8* %t2307
  %t2311 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2312 = icmp eq i32 %t2297, 4
  %t2313 = select i1 %t2312, i8* %t2311, i8* %t2310
  %t2314 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2315 = icmp eq i32 %t2297, 5
  %t2316 = select i1 %t2315, i8* %t2314, i8* %t2313
  %t2317 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2318 = icmp eq i32 %t2297, 6
  %t2319 = select i1 %t2318, i8* %t2317, i8* %t2316
  %t2320 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2321 = icmp eq i32 %t2297, 7
  %t2322 = select i1 %t2321, i8* %t2320, i8* %t2319
  %t2323 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2324 = icmp eq i32 %t2297, 8
  %t2325 = select i1 %t2324, i8* %t2323, i8* %t2322
  %t2326 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2327 = icmp eq i32 %t2297, 9
  %t2328 = select i1 %t2327, i8* %t2326, i8* %t2325
  %t2329 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2330 = icmp eq i32 %t2297, 10
  %t2331 = select i1 %t2330, i8* %t2329, i8* %t2328
  %t2332 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2333 = icmp eq i32 %t2297, 11
  %t2334 = select i1 %t2333, i8* %t2332, i8* %t2331
  %t2335 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2336 = icmp eq i32 %t2297, 12
  %t2337 = select i1 %t2336, i8* %t2335, i8* %t2334
  %t2338 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2339 = icmp eq i32 %t2297, 13
  %t2340 = select i1 %t2339, i8* %t2338, i8* %t2337
  %t2341 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2342 = icmp eq i32 %t2297, 14
  %t2343 = select i1 %t2342, i8* %t2341, i8* %t2340
  %t2344 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2345 = icmp eq i32 %t2297, 15
  %t2346 = select i1 %t2345, i8* %t2344, i8* %t2343
  %t2347 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2348 = icmp eq i32 %t2297, 16
  %t2349 = select i1 %t2348, i8* %t2347, i8* %t2346
  %t2350 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2351 = icmp eq i32 %t2297, 17
  %t2352 = select i1 %t2351, i8* %t2350, i8* %t2349
  %t2353 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2354 = icmp eq i32 %t2297, 18
  %t2355 = select i1 %t2354, i8* %t2353, i8* %t2352
  %t2356 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2357 = icmp eq i32 %t2297, 19
  %t2358 = select i1 %t2357, i8* %t2356, i8* %t2355
  %t2359 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2360 = icmp eq i32 %t2297, 20
  %t2361 = select i1 %t2360, i8* %t2359, i8* %t2358
  %t2362 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2363 = icmp eq i32 %t2297, 21
  %t2364 = select i1 %t2363, i8* %t2362, i8* %t2361
  %t2365 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2366 = icmp eq i32 %t2297, 22
  %t2367 = select i1 %t2366, i8* %t2365, i8* %t2364
  %s2368 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.2368, i32 0, i32 0
  %t2369 = icmp eq i8* %t2367, %s2368
  br i1 %t2369, label %then28, label %merge29
then28:
  %t2370 = alloca [0 x %Diagnostic]
  %t2371 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t2370, i32 0, i32 0
  %t2372 = alloca { %Diagnostic*, i64 }
  %t2373 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2372, i32 0, i32 0
  store %Diagnostic* %t2371, %Diagnostic** %t2373
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
  %t2409 = getelementptr %MatchCase*, %MatchCase** %t2406, i64 %t2404
  %t2410 = load %MatchCase*, %MatchCase** %t2409
  store %MatchCase* %t2410, %MatchCase** %l21
  %t2411 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2412 = load %MatchCase*, %MatchCase** %l21
  %t2413 = getelementptr %MatchCase, %MatchCase* %t2412, i32 0, i32 2
  %t2414 = load %Block*, %Block** %t2413
  %t2415 = call { %Diagnostic*, i64 }* @check_block(%Block zeroinitializer, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
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
  %t2427 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2428 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2427, 0
  %t2429 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2430 = bitcast { %Diagnostic*, i64 }* %t2429 to { %Diagnostic**, i64 }*
  %t2431 = insertvalue %ScopeResult %t2428, { %Diagnostic**, i64 }* %t2430, 1
  ret %ScopeResult %t2431
merge29:
  %t2432 = extractvalue %Statement %statement, 0
  %t2433 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2434 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2435 = icmp eq i32 %t2432, 0
  %t2436 = select i1 %t2435, i8* %t2434, i8* %t2433
  %t2437 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2438 = icmp eq i32 %t2432, 1
  %t2439 = select i1 %t2438, i8* %t2437, i8* %t2436
  %t2440 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2441 = icmp eq i32 %t2432, 2
  %t2442 = select i1 %t2441, i8* %t2440, i8* %t2439
  %t2443 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2444 = icmp eq i32 %t2432, 3
  %t2445 = select i1 %t2444, i8* %t2443, i8* %t2442
  %t2446 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2447 = icmp eq i32 %t2432, 4
  %t2448 = select i1 %t2447, i8* %t2446, i8* %t2445
  %t2449 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2450 = icmp eq i32 %t2432, 5
  %t2451 = select i1 %t2450, i8* %t2449, i8* %t2448
  %t2452 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2453 = icmp eq i32 %t2432, 6
  %t2454 = select i1 %t2453, i8* %t2452, i8* %t2451
  %t2455 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2456 = icmp eq i32 %t2432, 7
  %t2457 = select i1 %t2456, i8* %t2455, i8* %t2454
  %t2458 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2459 = icmp eq i32 %t2432, 8
  %t2460 = select i1 %t2459, i8* %t2458, i8* %t2457
  %t2461 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2462 = icmp eq i32 %t2432, 9
  %t2463 = select i1 %t2462, i8* %t2461, i8* %t2460
  %t2464 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2465 = icmp eq i32 %t2432, 10
  %t2466 = select i1 %t2465, i8* %t2464, i8* %t2463
  %t2467 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2468 = icmp eq i32 %t2432, 11
  %t2469 = select i1 %t2468, i8* %t2467, i8* %t2466
  %t2470 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2471 = icmp eq i32 %t2432, 12
  %t2472 = select i1 %t2471, i8* %t2470, i8* %t2469
  %t2473 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2474 = icmp eq i32 %t2432, 13
  %t2475 = select i1 %t2474, i8* %t2473, i8* %t2472
  %t2476 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2477 = icmp eq i32 %t2432, 14
  %t2478 = select i1 %t2477, i8* %t2476, i8* %t2475
  %t2479 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2480 = icmp eq i32 %t2432, 15
  %t2481 = select i1 %t2480, i8* %t2479, i8* %t2478
  %t2482 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2483 = icmp eq i32 %t2432, 16
  %t2484 = select i1 %t2483, i8* %t2482, i8* %t2481
  %t2485 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2486 = icmp eq i32 %t2432, 17
  %t2487 = select i1 %t2486, i8* %t2485, i8* %t2484
  %t2488 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2489 = icmp eq i32 %t2432, 18
  %t2490 = select i1 %t2489, i8* %t2488, i8* %t2487
  %t2491 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2492 = icmp eq i32 %t2432, 19
  %t2493 = select i1 %t2492, i8* %t2491, i8* %t2490
  %t2494 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2495 = icmp eq i32 %t2432, 20
  %t2496 = select i1 %t2495, i8* %t2494, i8* %t2493
  %t2497 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2498 = icmp eq i32 %t2432, 21
  %t2499 = select i1 %t2498, i8* %t2497, i8* %t2496
  %t2500 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2501 = icmp eq i32 %t2432, 22
  %t2502 = select i1 %t2501, i8* %t2500, i8* %t2499
  %s2503 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.2503, i32 0, i32 0
  %t2504 = icmp eq i8* %t2502, %s2503
  br i1 %t2504, label %then36, label %merge37
then36:
  %t2505 = extractvalue %Statement %statement, 0
  %t2506 = alloca %Statement
  store %Statement %statement, %Statement* %t2506
  %t2507 = getelementptr inbounds %Statement, %Statement* %t2506, i32 0, i32 1
  %t2508 = bitcast [32 x i8]* %t2507 to i8*
  %t2509 = getelementptr inbounds i8, i8* %t2508, i64 8
  %t2510 = bitcast i8* %t2509 to %Block**
  %t2511 = load %Block*, %Block** %t2510
  %t2512 = icmp eq i32 %t2505, 19
  %t2513 = select i1 %t2512, %Block* %t2511, %Block* null
  %t2514 = call { %Diagnostic*, i64 }* @check_block(%Block zeroinitializer, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t2514, { %Diagnostic*, i64 }** %l22
  %t2515 = extractvalue %Statement %statement, 0
  %t2516 = alloca %Statement
  store %Statement %statement, %Statement* %t2516
  %t2517 = getelementptr inbounds %Statement, %Statement* %t2516, i32 0, i32 1
  %t2518 = bitcast [32 x i8]* %t2517 to i8*
  %t2519 = getelementptr inbounds i8, i8* %t2518, i64 16
  %t2520 = bitcast i8* %t2519 to %ElseBranch**
  %t2521 = load %ElseBranch*, %ElseBranch** %t2520
  %t2522 = icmp eq i32 %t2515, 19
  %t2523 = select i1 %t2522, %ElseBranch* %t2521, %ElseBranch* null
  %t2524 = bitcast i8* null to %ElseBranch*
  %t2525 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2526 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2525, 0
  %t2527 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2528 = bitcast { %Diagnostic*, i64 }* %t2527 to { %Diagnostic**, i64 }*
  %t2529 = insertvalue %ScopeResult %t2526, { %Diagnostic**, i64 }* %t2528, 1
  ret %ScopeResult %t2529
merge37:
  %t2530 = extractvalue %Statement %statement, 0
  %t2531 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2532 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2533 = icmp eq i32 %t2530, 0
  %t2534 = select i1 %t2533, i8* %t2532, i8* %t2531
  %t2535 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2536 = icmp eq i32 %t2530, 1
  %t2537 = select i1 %t2536, i8* %t2535, i8* %t2534
  %t2538 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2539 = icmp eq i32 %t2530, 2
  %t2540 = select i1 %t2539, i8* %t2538, i8* %t2537
  %t2541 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2542 = icmp eq i32 %t2530, 3
  %t2543 = select i1 %t2542, i8* %t2541, i8* %t2540
  %t2544 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2545 = icmp eq i32 %t2530, 4
  %t2546 = select i1 %t2545, i8* %t2544, i8* %t2543
  %t2547 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2548 = icmp eq i32 %t2530, 5
  %t2549 = select i1 %t2548, i8* %t2547, i8* %t2546
  %t2550 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2551 = icmp eq i32 %t2530, 6
  %t2552 = select i1 %t2551, i8* %t2550, i8* %t2549
  %t2553 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2554 = icmp eq i32 %t2530, 7
  %t2555 = select i1 %t2554, i8* %t2553, i8* %t2552
  %t2556 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2557 = icmp eq i32 %t2530, 8
  %t2558 = select i1 %t2557, i8* %t2556, i8* %t2555
  %t2559 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2560 = icmp eq i32 %t2530, 9
  %t2561 = select i1 %t2560, i8* %t2559, i8* %t2558
  %t2562 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2563 = icmp eq i32 %t2530, 10
  %t2564 = select i1 %t2563, i8* %t2562, i8* %t2561
  %t2565 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2566 = icmp eq i32 %t2530, 11
  %t2567 = select i1 %t2566, i8* %t2565, i8* %t2564
  %t2568 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2569 = icmp eq i32 %t2530, 12
  %t2570 = select i1 %t2569, i8* %t2568, i8* %t2567
  %t2571 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2572 = icmp eq i32 %t2530, 13
  %t2573 = select i1 %t2572, i8* %t2571, i8* %t2570
  %t2574 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2575 = icmp eq i32 %t2530, 14
  %t2576 = select i1 %t2575, i8* %t2574, i8* %t2573
  %t2577 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2578 = icmp eq i32 %t2530, 15
  %t2579 = select i1 %t2578, i8* %t2577, i8* %t2576
  %t2580 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2581 = icmp eq i32 %t2530, 16
  %t2582 = select i1 %t2581, i8* %t2580, i8* %t2579
  %t2583 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2584 = icmp eq i32 %t2530, 17
  %t2585 = select i1 %t2584, i8* %t2583, i8* %t2582
  %t2586 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2587 = icmp eq i32 %t2530, 18
  %t2588 = select i1 %t2587, i8* %t2586, i8* %t2585
  %t2589 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2590 = icmp eq i32 %t2530, 19
  %t2591 = select i1 %t2590, i8* %t2589, i8* %t2588
  %t2592 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2593 = icmp eq i32 %t2530, 20
  %t2594 = select i1 %t2593, i8* %t2592, i8* %t2591
  %t2595 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2596 = icmp eq i32 %t2530, 21
  %t2597 = select i1 %t2596, i8* %t2595, i8* %t2594
  %t2598 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2599 = icmp eq i32 %t2530, 22
  %t2600 = select i1 %t2599, i8* %t2598, i8* %t2597
  %s2601 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.2601, i32 0, i32 0
  %t2602 = icmp eq i8* %t2600, %s2601
  br i1 %t2602, label %then38, label %merge39
then38:
  %t2603 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2604 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2603, 0
  %t2605 = extractvalue %Statement %statement, 0
  %t2606 = alloca %Statement
  store %Statement %statement, %Statement* %t2606
  %t2607 = getelementptr inbounds %Statement, %Statement* %t2606, i32 0, i32 1
  %t2608 = bitcast [24 x i8]* %t2607 to i8*
  %t2609 = getelementptr inbounds i8, i8* %t2608, i64 8
  %t2610 = bitcast i8* %t2609 to %Block**
  %t2611 = load %Block*, %Block** %t2610
  %t2612 = icmp eq i32 %t2605, 4
  %t2613 = select i1 %t2612, %Block* %t2611, %Block* null
  %t2614 = getelementptr inbounds %Statement, %Statement* %t2606, i32 0, i32 1
  %t2615 = bitcast [24 x i8]* %t2614 to i8*
  %t2616 = getelementptr inbounds i8, i8* %t2615, i64 8
  %t2617 = bitcast i8* %t2616 to %Block**
  %t2618 = load %Block*, %Block** %t2617
  %t2619 = icmp eq i32 %t2605, 5
  %t2620 = select i1 %t2619, %Block* %t2618, %Block* %t2613
  %t2621 = getelementptr inbounds %Statement, %Statement* %t2606, i32 0, i32 1
  %t2622 = bitcast [40 x i8]* %t2621 to i8*
  %t2623 = getelementptr inbounds i8, i8* %t2622, i64 16
  %t2624 = bitcast i8* %t2623 to %Block**
  %t2625 = load %Block*, %Block** %t2624
  %t2626 = icmp eq i32 %t2605, 6
  %t2627 = select i1 %t2626, %Block* %t2625, %Block* %t2620
  %t2628 = getelementptr inbounds %Statement, %Statement* %t2606, i32 0, i32 1
  %t2629 = bitcast [24 x i8]* %t2628 to i8*
  %t2630 = getelementptr inbounds i8, i8* %t2629, i64 8
  %t2631 = bitcast i8* %t2630 to %Block**
  %t2632 = load %Block*, %Block** %t2631
  %t2633 = icmp eq i32 %t2605, 7
  %t2634 = select i1 %t2633, %Block* %t2632, %Block* %t2627
  %t2635 = getelementptr inbounds %Statement, %Statement* %t2606, i32 0, i32 1
  %t2636 = bitcast [40 x i8]* %t2635 to i8*
  %t2637 = getelementptr inbounds i8, i8* %t2636, i64 24
  %t2638 = bitcast i8* %t2637 to %Block**
  %t2639 = load %Block*, %Block** %t2638
  %t2640 = icmp eq i32 %t2605, 12
  %t2641 = select i1 %t2640, %Block* %t2639, %Block* %t2634
  %t2642 = getelementptr inbounds %Statement, %Statement* %t2606, i32 0, i32 1
  %t2643 = bitcast [24 x i8]* %t2642 to i8*
  %t2644 = getelementptr inbounds i8, i8* %t2643, i64 8
  %t2645 = bitcast i8* %t2644 to %Block**
  %t2646 = load %Block*, %Block** %t2645
  %t2647 = icmp eq i32 %t2605, 13
  %t2648 = select i1 %t2647, %Block* %t2646, %Block* %t2641
  %t2649 = getelementptr inbounds %Statement, %Statement* %t2606, i32 0, i32 1
  %t2650 = bitcast [24 x i8]* %t2649 to i8*
  %t2651 = getelementptr inbounds i8, i8* %t2650, i64 8
  %t2652 = bitcast i8* %t2651 to %Block**
  %t2653 = load %Block*, %Block** %t2652
  %t2654 = icmp eq i32 %t2605, 14
  %t2655 = select i1 %t2654, %Block* %t2653, %Block* %t2648
  %t2656 = getelementptr inbounds %Statement, %Statement* %t2606, i32 0, i32 1
  %t2657 = bitcast [16 x i8]* %t2656 to i8*
  %t2658 = bitcast i8* %t2657 to %Block**
  %t2659 = load %Block*, %Block** %t2658
  %t2660 = icmp eq i32 %t2605, 15
  %t2661 = select i1 %t2660, %Block* %t2659, %Block* %t2655
  %t2662 = call { %Diagnostic*, i64 }* @check_block(%Block zeroinitializer, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2663 = bitcast { %Diagnostic*, i64 }* %t2662 to { %Diagnostic**, i64 }*
  %t2664 = insertvalue %ScopeResult %t2604, { %Diagnostic**, i64 }* %t2663, 1
  ret %ScopeResult %t2664
merge39:
  %t2665 = extractvalue %Statement %statement, 0
  %t2666 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2667 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2668 = icmp eq i32 %t2665, 0
  %t2669 = select i1 %t2668, i8* %t2667, i8* %t2666
  %t2670 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2671 = icmp eq i32 %t2665, 1
  %t2672 = select i1 %t2671, i8* %t2670, i8* %t2669
  %t2673 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2674 = icmp eq i32 %t2665, 2
  %t2675 = select i1 %t2674, i8* %t2673, i8* %t2672
  %t2676 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2677 = icmp eq i32 %t2665, 3
  %t2678 = select i1 %t2677, i8* %t2676, i8* %t2675
  %t2679 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2680 = icmp eq i32 %t2665, 4
  %t2681 = select i1 %t2680, i8* %t2679, i8* %t2678
  %t2682 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2683 = icmp eq i32 %t2665, 5
  %t2684 = select i1 %t2683, i8* %t2682, i8* %t2681
  %t2685 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2686 = icmp eq i32 %t2665, 6
  %t2687 = select i1 %t2686, i8* %t2685, i8* %t2684
  %t2688 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2689 = icmp eq i32 %t2665, 7
  %t2690 = select i1 %t2689, i8* %t2688, i8* %t2687
  %t2691 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2692 = icmp eq i32 %t2665, 8
  %t2693 = select i1 %t2692, i8* %t2691, i8* %t2690
  %t2694 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2695 = icmp eq i32 %t2665, 9
  %t2696 = select i1 %t2695, i8* %t2694, i8* %t2693
  %t2697 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2698 = icmp eq i32 %t2665, 10
  %t2699 = select i1 %t2698, i8* %t2697, i8* %t2696
  %t2700 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2701 = icmp eq i32 %t2665, 11
  %t2702 = select i1 %t2701, i8* %t2700, i8* %t2699
  %t2703 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2704 = icmp eq i32 %t2665, 12
  %t2705 = select i1 %t2704, i8* %t2703, i8* %t2702
  %t2706 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2707 = icmp eq i32 %t2665, 13
  %t2708 = select i1 %t2707, i8* %t2706, i8* %t2705
  %t2709 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2710 = icmp eq i32 %t2665, 14
  %t2711 = select i1 %t2710, i8* %t2709, i8* %t2708
  %t2712 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2713 = icmp eq i32 %t2665, 15
  %t2714 = select i1 %t2713, i8* %t2712, i8* %t2711
  %t2715 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2716 = icmp eq i32 %t2665, 16
  %t2717 = select i1 %t2716, i8* %t2715, i8* %t2714
  %t2718 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2719 = icmp eq i32 %t2665, 17
  %t2720 = select i1 %t2719, i8* %t2718, i8* %t2717
  %t2721 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2722 = icmp eq i32 %t2665, 18
  %t2723 = select i1 %t2722, i8* %t2721, i8* %t2720
  %t2724 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2725 = icmp eq i32 %t2665, 19
  %t2726 = select i1 %t2725, i8* %t2724, i8* %t2723
  %t2727 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2728 = icmp eq i32 %t2665, 20
  %t2729 = select i1 %t2728, i8* %t2727, i8* %t2726
  %t2730 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2731 = icmp eq i32 %t2665, 21
  %t2732 = select i1 %t2731, i8* %t2730, i8* %t2729
  %t2733 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2734 = icmp eq i32 %t2665, 22
  %t2735 = select i1 %t2734, i8* %t2733, i8* %t2732
  %s2736 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.2736, i32 0, i32 0
  %t2737 = icmp eq i8* %t2735, %s2736
  br i1 %t2737, label %then40, label %merge41
then40:
  %t2738 = extractvalue %Statement %statement, 0
  %t2739 = alloca %Statement
  store %Statement %statement, %Statement* %t2739
  %t2740 = getelementptr inbounds %Statement, %Statement* %t2739, i32 0, i32 1
  %t2741 = bitcast [48 x i8]* %t2740 to i8*
  %t2742 = bitcast i8* %t2741 to i8**
  %t2743 = load i8*, i8** %t2742
  %t2744 = icmp eq i32 %t2738, 2
  %t2745 = select i1 %t2744, i8* %t2743, i8* null
  %t2746 = getelementptr inbounds %Statement, %Statement* %t2739, i32 0, i32 1
  %t2747 = bitcast [48 x i8]* %t2746 to i8*
  %t2748 = bitcast i8* %t2747 to i8**
  %t2749 = load i8*, i8** %t2748
  %t2750 = icmp eq i32 %t2738, 3
  %t2751 = select i1 %t2750, i8* %t2749, i8* %t2745
  %t2752 = getelementptr inbounds %Statement, %Statement* %t2739, i32 0, i32 1
  %t2753 = bitcast [40 x i8]* %t2752 to i8*
  %t2754 = bitcast i8* %t2753 to i8**
  %t2755 = load i8*, i8** %t2754
  %t2756 = icmp eq i32 %t2738, 6
  %t2757 = select i1 %t2756, i8* %t2755, i8* %t2751
  %t2758 = getelementptr inbounds %Statement, %Statement* %t2739, i32 0, i32 1
  %t2759 = bitcast [56 x i8]* %t2758 to i8*
  %t2760 = bitcast i8* %t2759 to i8**
  %t2761 = load i8*, i8** %t2760
  %t2762 = icmp eq i32 %t2738, 8
  %t2763 = select i1 %t2762, i8* %t2761, i8* %t2757
  %t2764 = getelementptr inbounds %Statement, %Statement* %t2739, i32 0, i32 1
  %t2765 = bitcast [40 x i8]* %t2764 to i8*
  %t2766 = bitcast i8* %t2765 to i8**
  %t2767 = load i8*, i8** %t2766
  %t2768 = icmp eq i32 %t2738, 9
  %t2769 = select i1 %t2768, i8* %t2767, i8* %t2763
  %t2770 = getelementptr inbounds %Statement, %Statement* %t2739, i32 0, i32 1
  %t2771 = bitcast [40 x i8]* %t2770 to i8*
  %t2772 = bitcast i8* %t2771 to i8**
  %t2773 = load i8*, i8** %t2772
  %t2774 = icmp eq i32 %t2738, 10
  %t2775 = select i1 %t2774, i8* %t2773, i8* %t2769
  %t2776 = getelementptr inbounds %Statement, %Statement* %t2739, i32 0, i32 1
  %t2777 = bitcast [40 x i8]* %t2776 to i8*
  %t2778 = bitcast i8* %t2777 to i8**
  %t2779 = load i8*, i8** %t2778
  %t2780 = icmp eq i32 %t2738, 11
  %t2781 = select i1 %t2780, i8* %t2779, i8* %t2775
  %s2782 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2782, i32 0, i32 0
  %t2783 = extractvalue %Statement %statement, 0
  %t2784 = alloca %Statement
  store %Statement %statement, %Statement* %t2784
  %t2785 = getelementptr inbounds %Statement, %Statement* %t2784, i32 0, i32 1
  %t2786 = bitcast [48 x i8]* %t2785 to i8*
  %t2787 = getelementptr inbounds i8, i8* %t2786, i64 8
  %t2788 = bitcast i8* %t2787 to %SourceSpan**
  %t2789 = load %SourceSpan*, %SourceSpan** %t2788
  %t2790 = icmp eq i32 %t2783, 3
  %t2791 = select i1 %t2790, %SourceSpan* %t2789, %SourceSpan* null
  %t2792 = getelementptr inbounds %Statement, %Statement* %t2784, i32 0, i32 1
  %t2793 = bitcast [40 x i8]* %t2792 to i8*
  %t2794 = getelementptr inbounds i8, i8* %t2793, i64 8
  %t2795 = bitcast i8* %t2794 to %SourceSpan**
  %t2796 = load %SourceSpan*, %SourceSpan** %t2795
  %t2797 = icmp eq i32 %t2783, 6
  %t2798 = select i1 %t2797, %SourceSpan* %t2796, %SourceSpan* %t2791
  %t2799 = getelementptr inbounds %Statement, %Statement* %t2784, i32 0, i32 1
  %t2800 = bitcast [56 x i8]* %t2799 to i8*
  %t2801 = getelementptr inbounds i8, i8* %t2800, i64 8
  %t2802 = bitcast i8* %t2801 to %SourceSpan**
  %t2803 = load %SourceSpan*, %SourceSpan** %t2802
  %t2804 = icmp eq i32 %t2783, 8
  %t2805 = select i1 %t2804, %SourceSpan* %t2803, %SourceSpan* %t2798
  %t2806 = getelementptr inbounds %Statement, %Statement* %t2784, i32 0, i32 1
  %t2807 = bitcast [40 x i8]* %t2806 to i8*
  %t2808 = getelementptr inbounds i8, i8* %t2807, i64 8
  %t2809 = bitcast i8* %t2808 to %SourceSpan**
  %t2810 = load %SourceSpan*, %SourceSpan** %t2809
  %t2811 = icmp eq i32 %t2783, 9
  %t2812 = select i1 %t2811, %SourceSpan* %t2810, %SourceSpan* %t2805
  %t2813 = getelementptr inbounds %Statement, %Statement* %t2784, i32 0, i32 1
  %t2814 = bitcast [40 x i8]* %t2813 to i8*
  %t2815 = getelementptr inbounds i8, i8* %t2814, i64 8
  %t2816 = bitcast i8* %t2815 to %SourceSpan**
  %t2817 = load %SourceSpan*, %SourceSpan** %t2816
  %t2818 = icmp eq i32 %t2783, 10
  %t2819 = select i1 %t2818, %SourceSpan* %t2817, %SourceSpan* %t2812
  %t2820 = getelementptr inbounds %Statement, %Statement* %t2784, i32 0, i32 1
  %t2821 = bitcast [40 x i8]* %t2820 to i8*
  %t2822 = getelementptr inbounds i8, i8* %t2821, i64 8
  %t2823 = bitcast i8* %t2822 to %SourceSpan**
  %t2824 = load %SourceSpan*, %SourceSpan** %t2823
  %t2825 = icmp eq i32 %t2783, 11
  %t2826 = select i1 %t2825, %SourceSpan* %t2824, %SourceSpan* %t2819
  %t2827 = bitcast %SourceSpan* %t2826 to i8*
  %t2828 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t2781, i8* %s2782, i8* %t2827)
  store %ScopeResult %t2828, %ScopeResult* %l23
  %t2829 = load %ScopeResult, %ScopeResult* %l23
  %t2830 = extractvalue %ScopeResult %t2829, 1
  %t2831 = extractvalue %Statement %statement, 0
  %t2832 = alloca %Statement
  store %Statement %statement, %Statement* %t2832
  %t2833 = getelementptr inbounds %Statement, %Statement* %t2832, i32 0, i32 1
  %t2834 = bitcast [56 x i8]* %t2833 to i8*
  %t2835 = getelementptr inbounds i8, i8* %t2834, i64 16
  %t2836 = bitcast i8* %t2835 to { %TypeParameter**, i64 }**
  %t2837 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2836
  %t2838 = icmp eq i32 %t2831, 8
  %t2839 = select i1 %t2838, { %TypeParameter**, i64 }* %t2837, { %TypeParameter**, i64 }* null
  %t2840 = getelementptr inbounds %Statement, %Statement* %t2832, i32 0, i32 1
  %t2841 = bitcast [40 x i8]* %t2840 to i8*
  %t2842 = getelementptr inbounds i8, i8* %t2841, i64 16
  %t2843 = bitcast i8* %t2842 to { %TypeParameter**, i64 }**
  %t2844 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2843
  %t2845 = icmp eq i32 %t2831, 9
  %t2846 = select i1 %t2845, { %TypeParameter**, i64 }* %t2844, { %TypeParameter**, i64 }* %t2839
  %t2847 = getelementptr inbounds %Statement, %Statement* %t2832, i32 0, i32 1
  %t2848 = bitcast [40 x i8]* %t2847 to i8*
  %t2849 = getelementptr inbounds i8, i8* %t2848, i64 16
  %t2850 = bitcast i8* %t2849 to { %TypeParameter**, i64 }**
  %t2851 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2850
  %t2852 = icmp eq i32 %t2831, 10
  %t2853 = select i1 %t2852, { %TypeParameter**, i64 }* %t2851, { %TypeParameter**, i64 }* %t2846
  %t2854 = getelementptr inbounds %Statement, %Statement* %t2832, i32 0, i32 1
  %t2855 = bitcast [40 x i8]* %t2854 to i8*
  %t2856 = getelementptr inbounds i8, i8* %t2855, i64 16
  %t2857 = bitcast i8* %t2856 to { %TypeParameter**, i64 }**
  %t2858 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %t2857
  %t2859 = icmp eq i32 %t2831, 11
  %t2860 = select i1 %t2859, { %TypeParameter**, i64 }* %t2858, { %TypeParameter**, i64 }* %t2853
  %t2861 = bitcast { %TypeParameter**, i64 }* %t2860 to { %TypeParameter*, i64 }*
  %t2862 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t2861)
  %t2863 = bitcast { %Diagnostic**, i64 }* %t2830 to { i8**, i64 }*
  %t2864 = bitcast { %Diagnostic*, i64 }* %t2862 to { i8**, i64 }*
  %t2865 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2863, { i8**, i64 }* %t2864)
  store { i8**, i64 }* %t2865, { i8**, i64 }** %l24
  %t2866 = load %ScopeResult, %ScopeResult* %l23
  %t2867 = extractvalue %ScopeResult %t2866, 0
  %t2868 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2867, 0
  %t2869 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t2870 = bitcast { i8**, i64 }* %t2869 to { %Diagnostic**, i64 }*
  %t2871 = insertvalue %ScopeResult %t2868, { %Diagnostic**, i64 }* %t2870, 1
  ret %ScopeResult %t2871
merge41:
  %t2872 = bitcast { %SymbolEntry*, i64 }* %bindings to { %SymbolEntry**, i64 }*
  %t2873 = insertvalue %ScopeResult undef, { %SymbolEntry**, i64 }* %t2872, 0
  %t2874 = alloca [0 x %Diagnostic*]
  %t2875 = getelementptr [0 x %Diagnostic*], [0 x %Diagnostic*]* %t2874, i32 0, i32 0
  %t2876 = alloca { %Diagnostic**, i64 }
  %t2877 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t2876, i32 0, i32 0
  store %Diagnostic** %t2875, %Diagnostic*** %t2877
  %t2878 = getelementptr { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t2876, i32 0, i32 1
  store i64 0, i64* %t2878
  %t2879 = insertvalue %ScopeResult %t2873, { %Diagnostic**, i64 }* %t2876, 1
  ret %ScopeResult %t2879
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
  %t18 = call %ScopeResult @check_statement(%Statement zeroinitializer, { %SymbolEntry*, i64 }* %t17, { %Statement*, i64 }* %interfaces)
  store %ScopeResult %t18, %ScopeResult* %l4
  %t19 = load %ScopeResult, %ScopeResult* %l4
  %t20 = extractvalue %ScopeResult %t19, 0
  %t21 = bitcast { %SymbolEntry**, i64 }* %t20 to { %SymbolEntry*, i64 }*
  store { %SymbolEntry*, i64 }* %t21, { %SymbolEntry*, i64 }** %l0
  %t22 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t23 = load %ScopeResult, %ScopeResult* %l4
  %t24 = extractvalue %ScopeResult %t23, 1
  %t25 = bitcast { %Diagnostic*, i64 }* %t22 to { i8**, i64 }*
  %t26 = bitcast { %Diagnostic**, i64 }* %t24 to { i8**, i64 }*
  %t27 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t25, { i8**, i64 }* %t26)
  %t28 = bitcast { i8**, i64 }* %t27 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t28, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t29 = load i64, i64* %l2
  %t30 = add i64 %t29, 1
  store i64 %t30, i64* %l2
  br label %for0
afterfor3:
  %t31 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t31
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
  %t79 = call double @resolve_interface_annotation(%TypeAnnotation zeroinitializer, { %Statement*, i64 }* %interfaces)
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
  %t129 = call { %Diagnostic*, i64 }* @validate_interface_annotation(i8* %t126, %Statement zeroinitializer, %TypeAnnotation zeroinitializer)
  %t130 = bitcast { %Diagnostic*, i64 }* %t82 to { i8**, i64 }*
  %t131 = bitcast { %Diagnostic*, i64 }* %t129 to { i8**, i64 }*
  %t132 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t130, { i8**, i64 }* %t131)
  %t133 = bitcast { i8**, i64 }* %t132 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t133, { %Diagnostic*, i64 }** %l3
  %t134 = load double, double* %l6
  br label %forinc8
forinc8:
  %t135 = load i64, i64* %l4
  %t136 = add i64 %t135, 1
  store i64 %t136, i64* %l4
  br label %for6
afterfor9:
  %t137 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  ret { %Diagnostic*, i64 }* %t137
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
  %t150 = getelementptr i8, i8* %t149, i64 0
  %t151 = load i8, i8* %t150
  %t152 = add i8 %t151, 60
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s154 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.154, i32 0, i32 0
  %t155 = call i8* @join_with_separator({ i8**, i64 }* %t153, i8* %s154)
  %t156 = getelementptr i8, i8* %t155, i64 0
  %t157 = load i8, i8* %t156
  %t158 = add i8 %t152, %t157
  %t159 = add i8 %t158, 62
  %t160 = alloca [2 x i8], align 1
  %t161 = getelementptr [2 x i8], [2 x i8]* %t160, i32 0, i32 0
  store i8 %t159, i8* %t161
  %t162 = getelementptr [2 x i8], [2 x i8]* %t160, i32 0, i32 1
  store i8 0, i8* %t162
  %t163 = getelementptr [2 x i8], [2 x i8]* %t160, i32 0, i32 0
  ret i8* %t163
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
  %t147 = phi double [ %t10, %entry ], [ %t143, %loop.latch2 ]
  %t148 = phi i8* [ %t9, %entry ], [ %t144, %loop.latch2 ]
  %t149 = phi { i8**, i64 }* [ %t8, %entry ], [ %t145, %loop.latch2 ]
  %t150 = phi double [ %t11, %entry ], [ %t146, %loop.latch2 ]
  store double %t147, double* %l2
  store i8* %t148, i8** %l1
  store { i8**, i64 }* %t149, { i8**, i64 }** %l0
  store double %t150, double* %l3
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
  %t36 = getelementptr i8, i8* %t34, i64 0
  %t37 = load i8, i8* %t36
  %t38 = add i8 %t37, %t35
  %t39 = alloca [2 x i8], align 1
  %t40 = getelementptr [2 x i8], [2 x i8]* %t39, i32 0, i32 0
  store i8 %t38, i8* %t40
  %t41 = getelementptr [2 x i8], [2 x i8]* %t39, i32 0, i32 1
  store i8 0, i8* %t41
  %t42 = getelementptr [2 x i8], [2 x i8]* %t39, i32 0, i32 0
  store i8* %t42, i8** %l1
  br label %merge8
else7:
  %t43 = load i8, i8* %l4
  %t44 = icmp eq i8 %t43, 62
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t46 = load i8*, i8** %l1
  %t47 = load double, double* %l2
  %t48 = load double, double* %l3
  %t49 = load i8, i8* %l4
  br i1 %t44, label %then9, label %else10
then9:
  %t50 = load double, double* %l2
  %t51 = sitofp i64 0 to double
  %t52 = fcmp ogt double %t50, %t51
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load i8*, i8** %l1
  %t55 = load double, double* %l2
  %t56 = load double, double* %l3
  %t57 = load i8, i8* %l4
  br i1 %t52, label %then12, label %merge13
then12:
  %t58 = load double, double* %l2
  %t59 = sitofp i64 1 to double
  %t60 = fsub double %t58, %t59
  store double %t60, double* %l2
  br label %merge13
merge13:
  %t61 = phi double [ %t60, %then12 ], [ %t55, %then9 ]
  store double %t61, double* %l2
  %t62 = load i8*, i8** %l1
  %t63 = load i8, i8* %l4
  %t64 = getelementptr i8, i8* %t62, i64 0
  %t65 = load i8, i8* %t64
  %t66 = add i8 %t65, %t63
  %t67 = alloca [2 x i8], align 1
  %t68 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 0
  store i8 %t66, i8* %t68
  %t69 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 1
  store i8 0, i8* %t69
  %t70 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 0
  store i8* %t70, i8** %l1
  br label %merge11
else10:
  %t71 = load i8, i8* %l4
  %t72 = icmp eq i8 %t71, 44
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = load i8*, i8** %l1
  %t75 = load double, double* %l2
  %t76 = load double, double* %l3
  %t77 = load i8, i8* %l4
  br i1 %t72, label %then14, label %else15
then14:
  %t78 = load double, double* %l2
  %t79 = sitofp i64 0 to double
  %t80 = fcmp oeq double %t78, %t79
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t82 = load i8*, i8** %l1
  %t83 = load double, double* %l2
  %t84 = load double, double* %l3
  %t85 = load i8, i8* %l4
  br i1 %t80, label %then17, label %merge18
then17:
  %t86 = load i8*, i8** %l1
  %t87 = call i8* @trim_text(i8* %t86)
  store i8* %t87, i8** %l5
  %t88 = load i8*, i8** %l5
  %t89 = call i64 @sailfin_runtime_string_length(i8* %t88)
  %t90 = icmp sgt i64 %t89, 0
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t92 = load i8*, i8** %l1
  %t93 = load double, double* %l2
  %t94 = load double, double* %l3
  %t95 = load i8, i8* %l4
  %t96 = load i8*, i8** %l5
  br i1 %t90, label %then19, label %merge20
then19:
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t98 = load i8*, i8** %l5
  %t99 = alloca [1 x i8*]
  %t100 = getelementptr [1 x i8*], [1 x i8*]* %t99, i32 0, i32 0
  %t101 = getelementptr i8*, i8** %t100, i64 0
  store i8* %t98, i8** %t101
  %t102 = alloca { i8**, i64 }
  %t103 = getelementptr { i8**, i64 }, { i8**, i64 }* %t102, i32 0, i32 0
  store i8** %t100, i8*** %t103
  %t104 = getelementptr { i8**, i64 }, { i8**, i64 }* %t102, i32 0, i32 1
  store i64 1, i64* %t104
  %t105 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t97, { i8**, i64 }* %t102)
  store { i8**, i64 }* %t105, { i8**, i64 }** %l0
  br label %merge20
merge20:
  %t106 = phi { i8**, i64 }* [ %t105, %then19 ], [ %t91, %then17 ]
  store { i8**, i64 }* %t106, { i8**, i64 }** %l0
  %s107 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.107, i32 0, i32 0
  store i8* %s107, i8** %l1
  %t108 = load double, double* %l3
  %t109 = sitofp i64 1 to double
  %t110 = fadd double %t108, %t109
  store double %t110, double* %l3
  br label %loop.latch2
merge18:
  %t111 = load i8*, i8** %l1
  %t112 = load i8, i8* %l4
  %t113 = getelementptr i8, i8* %t111, i64 0
  %t114 = load i8, i8* %t113
  %t115 = add i8 %t114, %t112
  %t116 = alloca [2 x i8], align 1
  %t117 = getelementptr [2 x i8], [2 x i8]* %t116, i32 0, i32 0
  store i8 %t115, i8* %t117
  %t118 = getelementptr [2 x i8], [2 x i8]* %t116, i32 0, i32 1
  store i8 0, i8* %t118
  %t119 = getelementptr [2 x i8], [2 x i8]* %t116, i32 0, i32 0
  store i8* %t119, i8** %l1
  br label %merge16
else15:
  %t120 = load i8*, i8** %l1
  %t121 = load i8, i8* %l4
  %t122 = getelementptr i8, i8* %t120, i64 0
  %t123 = load i8, i8* %t122
  %t124 = add i8 %t123, %t121
  %t125 = alloca [2 x i8], align 1
  %t126 = getelementptr [2 x i8], [2 x i8]* %t125, i32 0, i32 0
  store i8 %t124, i8* %t126
  %t127 = getelementptr [2 x i8], [2 x i8]* %t125, i32 0, i32 1
  store i8 0, i8* %t127
  %t128 = getelementptr [2 x i8], [2 x i8]* %t125, i32 0, i32 0
  store i8* %t128, i8** %l1
  br label %merge16
merge16:
  %t129 = phi { i8**, i64 }* [ %t105, %then14 ], [ %t73, %else15 ]
  %t130 = phi i8* [ %s107, %then14 ], [ %t128, %else15 ]
  %t131 = phi double [ %t110, %then14 ], [ %t76, %else15 ]
  store { i8**, i64 }* %t129, { i8**, i64 }** %l0
  store i8* %t130, i8** %l1
  store double %t131, double* %l3
  br label %merge11
merge11:
  %t132 = phi double [ %t60, %then9 ], [ %t47, %else10 ]
  %t133 = phi i8* [ %t70, %then9 ], [ %s107, %else10 ]
  %t134 = phi { i8**, i64 }* [ %t45, %then9 ], [ %t105, %else10 ]
  %t135 = phi double [ %t48, %then9 ], [ %t110, %else10 ]
  store double %t132, double* %l2
  store i8* %t133, i8** %l1
  store { i8**, i64 }* %t134, { i8**, i64 }** %l0
  store double %t135, double* %l3
  br label %merge8
merge8:
  %t136 = phi double [ %t33, %then6 ], [ %t60, %else7 ]
  %t137 = phi i8* [ %t42, %then6 ], [ %t70, %else7 ]
  %t138 = phi { i8**, i64 }* [ %t26, %then6 ], [ %t105, %else7 ]
  %t139 = phi double [ %t29, %then6 ], [ %t110, %else7 ]
  store double %t136, double* %l2
  store i8* %t137, i8** %l1
  store { i8**, i64 }* %t138, { i8**, i64 }** %l0
  store double %t139, double* %l3
  %t140 = load double, double* %l3
  %t141 = sitofp i64 1 to double
  %t142 = fadd double %t140, %t141
  store double %t142, double* %l3
  br label %loop.latch2
loop.latch2:
  %t143 = load double, double* %l2
  %t144 = load i8*, i8** %l1
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t146 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t151 = load i8*, i8** %l1
  %t152 = call i8* @trim_text(i8* %t151)
  store i8* %t152, i8** %l6
  %t153 = load i8*, i8** %l6
  %t154 = call i64 @sailfin_runtime_string_length(i8* %t153)
  %t155 = icmp sgt i64 %t154, 0
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t157 = load i8*, i8** %l1
  %t158 = load double, double* %l2
  %t159 = load double, double* %l3
  %t160 = load i8*, i8** %l6
  br i1 %t155, label %then21, label %merge22
then21:
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t162 = load i8*, i8** %l6
  %t163 = alloca [1 x i8*]
  %t164 = getelementptr [1 x i8*], [1 x i8*]* %t163, i32 0, i32 0
  %t165 = getelementptr i8*, i8** %t164, i64 0
  store i8* %t162, i8** %t165
  %t166 = alloca { i8**, i64 }
  %t167 = getelementptr { i8**, i64 }, { i8**, i64 }* %t166, i32 0, i32 0
  store i8** %t164, i8*** %t167
  %t168 = getelementptr { i8**, i64 }, { i8**, i64 }* %t166, i32 0, i32 1
  store i64 1, i64* %t168
  %t169 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t161, { i8**, i64 }* %t166)
  store { i8**, i64 }* %t169, { i8**, i64 }** %l0
  br label %merge22
merge22:
  %t170 = phi { i8**, i64 }* [ %t169, %then21 ], [ %t156, %entry ]
  store { i8**, i64 }* %t170, { i8**, i64 }** %l0
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t171
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
  %t31 = phi i8* [ %t8, %entry ], [ %t29, %loop.latch8 ]
  %t32 = phi double [ %t9, %entry ], [ %t30, %loop.latch8 ]
  store i8* %t31, i8** %l0
  store double %t32, double* %l1
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
  %t19 = getelementptr i8, i8* %t14, i64 0
  %t20 = load i8, i8* %t19
  %t21 = add i8 %t20, %t18
  %t22 = alloca [2 x i8], align 1
  %t23 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 0
  store i8 %t21, i8* %t23
  %t24 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 1
  store i8 0, i8* %t24
  %t25 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 0
  store i8* %t25, i8** %l0
  %t26 = load double, double* %l1
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  store double %t28, double* %l1
  br label %loop.latch8
loop.latch8:
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l1
  br label %loop.header6
afterloop9:
  %t33 = load i8*, i8** %l0
  ret i8* %t33
}

define i1 @is_whitespace(i8* %ch) {
entry:
  %t1 = getelementptr i8, i8* %ch, i64 0
  %t2 = load i8, i8* %t1
  %t3 = icmp eq i8 %t2, 32
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t3, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t5 = getelementptr i8, i8* %ch, i64 0
  %t6 = load i8, i8* %t5
  %t7 = icmp eq i8 %t6, 10
  br label %logical_or_entry_4

logical_or_entry_4:
  br i1 %t7, label %logical_or_merge_4, label %logical_or_right_4

logical_or_right_4:
  %t9 = getelementptr i8, i8* %ch, i64 0
  %t10 = load i8, i8* %t9
  %t11 = icmp eq i8 %t10, 9
  br label %logical_or_entry_8

logical_or_entry_8:
  br i1 %t11, label %logical_or_merge_8, label %logical_or_right_8

logical_or_right_8:
  %t12 = getelementptr i8, i8* %ch, i64 0
  %t13 = load i8, i8* %t12
  %t14 = icmp eq i8 %t13, 13
  br label %logical_or_right_end_8

logical_or_right_end_8:
  br label %logical_or_merge_8

logical_or_merge_8:
  %t15 = phi i1 [ true, %logical_or_entry_8 ], [ %t14, %logical_or_right_end_8 ]
  br label %logical_or_right_end_4

logical_or_right_end_4:
  br label %logical_or_merge_4

logical_or_merge_4:
  %t16 = phi i1 [ true, %logical_or_entry_4 ], [ %t15, %logical_or_right_end_4 ]
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t17 = phi i1 [ true, %logical_or_entry_0 ], [ %t16, %logical_or_right_end_0 ]
  ret i1 %t17
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
  %t22 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature zeroinitializer)
  %t23 = bitcast { %Diagnostic*, i64 }* %t19 to { i8**, i64 }*
  %t24 = bitcast { %Diagnostic*, i64 }* %t22 to { i8**, i64 }*
  %t25 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t23, { i8**, i64 }* %t24)
  %t26 = bitcast { i8**, i64 }* %t25 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t26, { %Diagnostic*, i64 }** %l1
  %t27 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t28 = extractvalue %MethodDeclaration %t27, 0
  %t29 = getelementptr %FunctionSignature, %FunctionSignature* %t28, i32 0, i32 0
  %t30 = load i8*, i8** %t29
  store i8* %t30, i8** %l4
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load i8*, i8** %l4
  %t33 = call i1 @contains_string({ i8**, i64 }* %t31, i8* %t32)
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t36 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t37 = load i8*, i8** %l4
  br i1 %t33, label %then4, label %else5
then4:
  %t38 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t39 = load i8*, i8** %l4
  %s40 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.40, i32 0, i32 0
  %t41 = load i8*, i8** %l4
  %t42 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t43 = extractvalue %MethodDeclaration %t42, 0
  %t44 = getelementptr %FunctionSignature, %FunctionSignature* %t43, i32 0, i32 6
  %t45 = load %SourceSpan*, %SourceSpan** %t44
  %t46 = bitcast %SourceSpan* %t45 to i8*
  %t47 = call double @token_from_name(i8* %t41, i8* %t46)
  %t48 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t39, i8* %s40, i8* null)
  %t49 = alloca [1 x %Diagnostic]
  %t50 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* %t49, i32 0, i32 0
  %t51 = getelementptr %Diagnostic, %Diagnostic* %t50, i64 0
  store %Diagnostic %t48, %Diagnostic* %t51
  %t52 = alloca { %Diagnostic*, i64 }
  %t53 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t52, i32 0, i32 0
  store %Diagnostic* %t50, %Diagnostic** %t53
  %t54 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t52, i32 0, i32 1
  store i64 1, i64* %t54
  %t55 = bitcast { %Diagnostic*, i64 }* %t38 to { i8**, i64 }*
  %t56 = bitcast { %Diagnostic*, i64 }* %t52 to { i8**, i64 }*
  %t57 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t55, { i8**, i64 }* %t56)
  %t58 = bitcast { i8**, i64 }* %t57 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t58, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t60 = load i8*, i8** %l4
  %t61 = alloca [1 x i8*]
  %t62 = getelementptr [1 x i8*], [1 x i8*]* %t61, i32 0, i32 0
  %t63 = getelementptr i8*, i8** %t62, i64 0
  store i8* %t60, i8** %t63
  %t64 = alloca { i8**, i64 }
  %t65 = getelementptr { i8**, i64 }, { i8**, i64 }* %t64, i32 0, i32 0
  store i8** %t62, i8*** %t65
  %t66 = getelementptr { i8**, i64 }, { i8**, i64 }* %t64, i32 0, i32 1
  store i64 1, i64* %t66
  %t67 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t59, { i8**, i64 }* %t64)
  store { i8**, i64 }* %t67, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t68 = phi { %Diagnostic*, i64 }* [ %t58, %then4 ], [ %t35, %else5 ]
  %t69 = phi { i8**, i64 }* [ %t34, %then4 ], [ %t67, %else5 ]
  store { %Diagnostic*, i64 }* %t68, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t69, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t70 = load i64, i64* %l2
  %t71 = add i64 %t70, 1
  store i64 %t71, i64* %l2
  br label %for0
afterfor3:
  %t72 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t72
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
  %t3 = getelementptr i8, i8* %t2, i64 0
  %t4 = load i8, i8* %t3
  %t5 = add i8 %t4, 39
  store i8 %t5, i8* %l0
  %t6 = icmp ne i8* %requirement, null
  %t7 = load i8, i8* %l0
  br i1 %t6, label %then0, label %merge1
then0:
  %t8 = load i8, i8* %l0
  %s9 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.9, i32 0, i32 0
  %t10 = getelementptr i8, i8* %s9, i64 0
  %t11 = load i8, i8* %t10
  %t12 = add i8 %t8, %t11
  br label %merge1
merge1:
  %t13 = phi i8 [ zeroinitializer, %then0 ], [ %t7, %entry ]
  store i8 %t13, i8* %l0
  %t14 = load i8, i8* %l0
  %s15 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.15, i32 0, i32 0
  %t16 = getelementptr i8, i8* %s15, i64 0
  %t17 = load i8, i8* %t16
  %t18 = add i8 %t14, %t17
  %t19 = getelementptr i8, i8* %effect, i64 0
  %t20 = load i8, i8* %t19
  %t21 = add i8 %t18, %t20
  %s22 = getelementptr inbounds [61 x i8], [61 x i8]* @.str.22, i32 0, i32 0
  %t23 = getelementptr i8, i8* %s22, i64 0
  %t24 = load i8, i8* %t23
  %t25 = add i8 %t21, %t24
  store i8 %t25, i8* %l0
  %t26 = load i8, i8* %l0
  %t27 = alloca [2 x i8], align 1
  %t28 = getelementptr [2 x i8], [2 x i8]* %t27, i32 0, i32 0
  store i8 %t26, i8* %t28
  %t29 = getelementptr [2 x i8], [2 x i8]* %t27, i32 0, i32 1
  store i8 0, i8* %t29
  %t30 = getelementptr [2 x i8], [2 x i8]* %t27, i32 0, i32 0
  ret i8* %t30
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
