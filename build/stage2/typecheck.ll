; ModuleID = 'sailfin'
source_filename = "sailfin"

%Diagnostic = type { i8*, i8*, i8* }
%SymbolEntry = type { i8*, i8*, i8* }
%TypecheckResult = type { { i8**, i64 }*, { i8**, i64 }* }
%SymbolCollectionResult = type { { i8**, i64 }*, { i8**, i64 }* }
%ScopeResult = type { { i8**, i64 }*, { i8**, i64 }* }
%Program = type { { i8**, i64 }* }
%TypeAnnotation = type { i8* }
%TypeParameter = type { i8*, i8*, i8* }
%Block = type { { i8**, i64 }*, i8*, { i8**, i64 }* }
%SourceSpan = type { double, double, double, double }
%Parameter = type { i8*, i8*, i8*, i1, i8* }
%WithClause = type { i8* }
%ObjectField = type { i8*, i8* }
%ElseBranch = type { i8*, i8* }
%ForClause = type { i8*, i8*, { i8**, i64 }* }
%MatchCase = type { i8*, i8*, i8* }
%ModelProperty = type { i8*, i8*, i8* }
%FieldDeclaration = type { i8*, i8*, i1, i8* }
%MethodDeclaration = type { i8*, i8*, { i8**, i64 }* }
%EnumVariant = type { i8*, { i8**, i64 }*, i8* }
%FunctionSignature = type { i8*, i1, { i8**, i64 }*, i8*, { i8**, i64 }*, { i8**, i64 }*, i8* }
%PipelineDeclaration = type { i8*, i8*, { i8**, i64 }* }
%ToolDeclaration = type { i8*, i8*, { i8**, i64 }* }
%TestDeclaration = type { i8*, i8*, { i8**, i64 }*, { i8**, i64 }* }
%ModelDeclaration = type { i8*, i8*, { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }* }
%Decorator = type { i8*, { i8**, i64 }* }
%DecoratorArgument = type { i8*, i8* }
%ImportSpecifier = type { i8*, i8* }
%ExportSpecifier = type { i8*, i8* }
%Token = type { i8*, i8*, double, double }
%EffectRequirement = type { i8*, i8*, i8* }
%EffectViolation = type { i8*, { i8**, i64 }*, { i8**, i64 }* }

%Expression = type { i32, [24 x i8] }
%Statement = type { i32, [56 x i8] }
%TokenKind = type { i32, [8 x i8] }

declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)

declare noalias i8* @malloc(i64)

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
  %t7 = insertvalue %TypecheckResult undef, { i8**, i64 }* null, 0
  %t8 = load %SymbolCollectionResult, %SymbolCollectionResult* %l0
  %t9 = extractvalue %SymbolCollectionResult %t8, 0
  %t10 = insertvalue %TypecheckResult %t7, { i8**, i64 }* %t9, 1
  ret %TypecheckResult %t10
}

define { %Statement*, i64 }* @collect_interface_definitions(%Program %program) {
entry:
  %l0 = alloca { %Statement*, i64 }*
  %l1 = alloca i64
  %l2 = alloca i8*
  %t0 = alloca [0 x %Statement]
  %t1 = getelementptr [0 x %Statement], [0 x %Statement]* %t0, i32 0, i32 0
  %t2 = alloca { %Statement*, i64 }
  %t3 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t2, i32 0, i32 0
  store %Statement* %t1, %Statement** %t3
  %t4 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Statement*, i64 }* %t2, { %Statement*, i64 }** %l0
  %t5 = extractvalue %Program %program, 0
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  %t7 = load i64, i64* %t6
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  %t9 = load i8**, i8*** %t8
  store i64 0, i64* %l1
  store i8* null, i8** %l2
  br label %for0
for0:
  %t10 = load i64, i64* %l1
  %t11 = icmp slt i64 %t10, %t7
  br i1 %t11, label %forbody1, label %afterfor3
forbody1:
  %t12 = load i64, i64* %l1
  %t13 = getelementptr i8*, i8** %t9, i64 %t12
  %t14 = load i8*, i8** %t13
  store i8* %t14, i8** %l2
  %t15 = load i8*, i8** %l2
  br label %forinc2
forinc2:
  %t16 = load i64, i64* %l1
  %t17 = add i64 %t16, 1
  store i64 %t17, i64* %l1
  br label %for0
afterfor3:
  %t18 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  ret { %Statement*, i64 }* %t18
}

define %SymbolCollectionResult @collect_top_level_symbols(%Program %program) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca i8*
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
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  %t12 = load i64, i64* %t11
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  %t14 = load i8**, i8*** %t13
  store i64 0, i64* %l2
  store i8* null, i8** %l3
  br label %for0
for0:
  %t15 = load i64, i64* %l2
  %t16 = icmp slt i64 %t15, %t12
  br i1 %t16, label %forbody1, label %afterfor3
forbody1:
  %t17 = load i64, i64* %l2
  %t18 = getelementptr i8*, i8** %t14, i64 %t17
  %t19 = load i8*, i8** %t18
  store i8* %t19, i8** %l3
  %t20 = load i8*, i8** %l3
  %t21 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t22 = call %SymbolCollectionResult @register_top_level_symbol(%Statement zeroinitializer, { %SymbolEntry*, i64 }* %t21)
  store %SymbolCollectionResult %t22, %SymbolCollectionResult* %l4
  %t23 = load %SymbolCollectionResult, %SymbolCollectionResult* %l4
  %t24 = extractvalue %SymbolCollectionResult %t23, 0
  %t25 = bitcast { i8**, i64 }* %t24 to { %SymbolEntry*, i64 }*
  store { %SymbolEntry*, i64 }* %t25, { %SymbolEntry*, i64 }** %l0
  %t26 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t27 = load %SymbolCollectionResult, %SymbolCollectionResult* %l4
  %t28 = extractvalue %SymbolCollectionResult %t27, 1
  %t29 = bitcast { %Diagnostic*, i64 }* %t26 to { i8**, i64 }*
  %t30 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t29, { i8**, i64 }* %t28)
  %t31 = bitcast { i8**, i64 }* %t30 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t31, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t32 = load i64, i64* %l2
  %t33 = add i64 %t32, 1
  store i64 %t33, i64* %l2
  br label %for0
afterfor3:
  %t34 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t35 = bitcast { %SymbolEntry*, i64 }* %t34 to { i8**, i64 }*
  %t36 = insertvalue %SymbolCollectionResult undef, { i8**, i64 }* %t35, 0
  %t37 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t38 = bitcast { %Diagnostic*, i64 }* %t37 to { i8**, i64 }*
  %t39 = insertvalue %SymbolCollectionResult %t36, { i8**, i64 }* %t38, 1
  ret %SymbolCollectionResult %t39
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
  %t77 = bitcast i8* %t76 to i8**
  %t78 = load i8*, i8** %t77
  %t79 = icmp eq i32 %t73, 4
  %t80 = select i1 %t79, i8* %t78, i8* null
  %t81 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t82 = bitcast [24 x i8]* %t81 to i8*
  %t83 = bitcast i8* %t82 to i8**
  %t84 = load i8*, i8** %t83
  %t85 = icmp eq i32 %t73, 5
  %t86 = select i1 %t85, i8* %t84, i8* %t80
  %t87 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t88 = bitcast [24 x i8]* %t87 to i8*
  %t89 = bitcast i8* %t88 to i8**
  %t90 = load i8*, i8** %t89
  %t91 = icmp eq i32 %t73, 7
  %t92 = select i1 %t91, i8* %t90, i8* %t86
  %s93 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.93, i32 0, i32 0
  %t94 = extractvalue %Statement %statement, 0
  %t95 = alloca %Statement
  store %Statement %statement, %Statement* %t95
  %t96 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t97 = bitcast [24 x i8]* %t96 to i8*
  %t98 = bitcast i8* %t97 to i8**
  %t99 = load i8*, i8** %t98
  %t100 = icmp eq i32 %t94, 4
  %t101 = select i1 %t100, i8* %t99, i8* null
  %t102 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t103 = bitcast [24 x i8]* %t102 to i8*
  %t104 = bitcast i8* %t103 to i8**
  %t105 = load i8*, i8** %t104
  %t106 = icmp eq i32 %t94, 5
  %t107 = select i1 %t106, i8* %t105, i8* %t101
  %t108 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t109 = bitcast [24 x i8]* %t108 to i8*
  %t110 = bitcast i8* %t109 to i8**
  %t111 = load i8*, i8** %t110
  %t112 = icmp eq i32 %t94, 7
  %t113 = select i1 %t112, i8* %t111, i8* %t107
  ret %SymbolCollectionResult zeroinitializer
merge1:
  %t114 = extractvalue %Statement %statement, 0
  %t115 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t116 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t114, 0
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %t119 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t114, 1
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %t122 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t123 = icmp eq i32 %t114, 2
  %t124 = select i1 %t123, i8* %t122, i8* %t121
  %t125 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t126 = icmp eq i32 %t114, 3
  %t127 = select i1 %t126, i8* %t125, i8* %t124
  %t128 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t129 = icmp eq i32 %t114, 4
  %t130 = select i1 %t129, i8* %t128, i8* %t127
  %t131 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t132 = icmp eq i32 %t114, 5
  %t133 = select i1 %t132, i8* %t131, i8* %t130
  %t134 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t114, 6
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t114, 7
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t114, 8
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t114, 9
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t114, 10
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t114, 11
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t114, 12
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t114, 13
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t114, 14
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t114, 15
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t114, 16
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t114, 17
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t114, 18
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t114, 19
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %t176 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t177 = icmp eq i32 %t114, 20
  %t178 = select i1 %t177, i8* %t176, i8* %t175
  %t179 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t114, 21
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t114, 22
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %s185 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.185, i32 0, i32 0
  %t186 = icmp eq i8* %t184, %s185
  br i1 %t186, label %then2, label %merge3
then2:
  %t187 = extractvalue %Statement %statement, 0
  %t188 = alloca %Statement
  store %Statement %statement, %Statement* %t188
  %t189 = getelementptr inbounds %Statement, %Statement* %t188, i32 0, i32 1
  %t190 = bitcast [48 x i8]* %t189 to i8*
  %t191 = bitcast i8* %t190 to i8**
  %t192 = load i8*, i8** %t191
  %t193 = icmp eq i32 %t187, 2
  %t194 = select i1 %t193, i8* %t192, i8* null
  %t195 = getelementptr inbounds %Statement, %Statement* %t188, i32 0, i32 1
  %t196 = bitcast [48 x i8]* %t195 to i8*
  %t197 = bitcast i8* %t196 to i8**
  %t198 = load i8*, i8** %t197
  %t199 = icmp eq i32 %t187, 3
  %t200 = select i1 %t199, i8* %t198, i8* %t194
  %t201 = getelementptr inbounds %Statement, %Statement* %t188, i32 0, i32 1
  %t202 = bitcast [40 x i8]* %t201 to i8*
  %t203 = bitcast i8* %t202 to i8**
  %t204 = load i8*, i8** %t203
  %t205 = icmp eq i32 %t187, 6
  %t206 = select i1 %t205, i8* %t204, i8* %t200
  %t207 = getelementptr inbounds %Statement, %Statement* %t188, i32 0, i32 1
  %t208 = bitcast [56 x i8]* %t207 to i8*
  %t209 = bitcast i8* %t208 to i8**
  %t210 = load i8*, i8** %t209
  %t211 = icmp eq i32 %t187, 8
  %t212 = select i1 %t211, i8* %t210, i8* %t206
  %t213 = getelementptr inbounds %Statement, %Statement* %t188, i32 0, i32 1
  %t214 = bitcast [40 x i8]* %t213 to i8*
  %t215 = bitcast i8* %t214 to i8**
  %t216 = load i8*, i8** %t215
  %t217 = icmp eq i32 %t187, 9
  %t218 = select i1 %t217, i8* %t216, i8* %t212
  %t219 = getelementptr inbounds %Statement, %Statement* %t188, i32 0, i32 1
  %t220 = bitcast [40 x i8]* %t219 to i8*
  %t221 = bitcast i8* %t220 to i8**
  %t222 = load i8*, i8** %t221
  %t223 = icmp eq i32 %t187, 10
  %t224 = select i1 %t223, i8* %t222, i8* %t218
  %t225 = getelementptr inbounds %Statement, %Statement* %t188, i32 0, i32 1
  %t226 = bitcast [40 x i8]* %t225 to i8*
  %t227 = bitcast i8* %t226 to i8**
  %t228 = load i8*, i8** %t227
  %t229 = icmp eq i32 %t187, 11
  %t230 = select i1 %t229, i8* %t228, i8* %t224
  %s231 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.231, i32 0, i32 0
  %t232 = extractvalue %Statement %statement, 0
  %t233 = alloca %Statement
  store %Statement %statement, %Statement* %t233
  %t234 = getelementptr inbounds %Statement, %Statement* %t233, i32 0, i32 1
  %t235 = bitcast [48 x i8]* %t234 to i8*
  %t236 = getelementptr inbounds i8, i8* %t235, i64 8
  %t237 = bitcast i8* %t236 to i8**
  %t238 = load i8*, i8** %t237
  %t239 = icmp eq i32 %t232, 3
  %t240 = select i1 %t239, i8* %t238, i8* null
  %t241 = getelementptr inbounds %Statement, %Statement* %t233, i32 0, i32 1
  %t242 = bitcast [40 x i8]* %t241 to i8*
  %t243 = getelementptr inbounds i8, i8* %t242, i64 8
  %t244 = bitcast i8* %t243 to i8**
  %t245 = load i8*, i8** %t244
  %t246 = icmp eq i32 %t232, 6
  %t247 = select i1 %t246, i8* %t245, i8* %t240
  %t248 = getelementptr inbounds %Statement, %Statement* %t233, i32 0, i32 1
  %t249 = bitcast [56 x i8]* %t248 to i8*
  %t250 = getelementptr inbounds i8, i8* %t249, i64 8
  %t251 = bitcast i8* %t250 to i8**
  %t252 = load i8*, i8** %t251
  %t253 = icmp eq i32 %t232, 8
  %t254 = select i1 %t253, i8* %t252, i8* %t247
  %t255 = getelementptr inbounds %Statement, %Statement* %t233, i32 0, i32 1
  %t256 = bitcast [40 x i8]* %t255 to i8*
  %t257 = getelementptr inbounds i8, i8* %t256, i64 8
  %t258 = bitcast i8* %t257 to i8**
  %t259 = load i8*, i8** %t258
  %t260 = icmp eq i32 %t232, 9
  %t261 = select i1 %t260, i8* %t259, i8* %t254
  %t262 = getelementptr inbounds %Statement, %Statement* %t233, i32 0, i32 1
  %t263 = bitcast [40 x i8]* %t262 to i8*
  %t264 = getelementptr inbounds i8, i8* %t263, i64 8
  %t265 = bitcast i8* %t264 to i8**
  %t266 = load i8*, i8** %t265
  %t267 = icmp eq i32 %t232, 10
  %t268 = select i1 %t267, i8* %t266, i8* %t261
  %t269 = getelementptr inbounds %Statement, %Statement* %t233, i32 0, i32 1
  %t270 = bitcast [40 x i8]* %t269 to i8*
  %t271 = getelementptr inbounds i8, i8* %t270, i64 8
  %t272 = bitcast i8* %t271 to i8**
  %t273 = load i8*, i8** %t272
  %t274 = icmp eq i32 %t232, 11
  %t275 = select i1 %t274, i8* %t273, i8* %t268
  %t276 = call %SymbolCollectionResult @register_symbol(i8* %t230, i8* %s231, i8* %t275, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t276
merge3:
  %t277 = extractvalue %Statement %statement, 0
  %t278 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t279 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t280 = icmp eq i32 %t277, 0
  %t281 = select i1 %t280, i8* %t279, i8* %t278
  %t282 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t283 = icmp eq i32 %t277, 1
  %t284 = select i1 %t283, i8* %t282, i8* %t281
  %t285 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t286 = icmp eq i32 %t277, 2
  %t287 = select i1 %t286, i8* %t285, i8* %t284
  %t288 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t289 = icmp eq i32 %t277, 3
  %t290 = select i1 %t289, i8* %t288, i8* %t287
  %t291 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t292 = icmp eq i32 %t277, 4
  %t293 = select i1 %t292, i8* %t291, i8* %t290
  %t294 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t295 = icmp eq i32 %t277, 5
  %t296 = select i1 %t295, i8* %t294, i8* %t293
  %t297 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t298 = icmp eq i32 %t277, 6
  %t299 = select i1 %t298, i8* %t297, i8* %t296
  %t300 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t301 = icmp eq i32 %t277, 7
  %t302 = select i1 %t301, i8* %t300, i8* %t299
  %t303 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t304 = icmp eq i32 %t277, 8
  %t305 = select i1 %t304, i8* %t303, i8* %t302
  %t306 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t307 = icmp eq i32 %t277, 9
  %t308 = select i1 %t307, i8* %t306, i8* %t305
  %t309 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t310 = icmp eq i32 %t277, 10
  %t311 = select i1 %t310, i8* %t309, i8* %t308
  %t312 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t313 = icmp eq i32 %t277, 11
  %t314 = select i1 %t313, i8* %t312, i8* %t311
  %t315 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t316 = icmp eq i32 %t277, 12
  %t317 = select i1 %t316, i8* %t315, i8* %t314
  %t318 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t319 = icmp eq i32 %t277, 13
  %t320 = select i1 %t319, i8* %t318, i8* %t317
  %t321 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t322 = icmp eq i32 %t277, 14
  %t323 = select i1 %t322, i8* %t321, i8* %t320
  %t324 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t325 = icmp eq i32 %t277, 15
  %t326 = select i1 %t325, i8* %t324, i8* %t323
  %t327 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t328 = icmp eq i32 %t277, 16
  %t329 = select i1 %t328, i8* %t327, i8* %t326
  %t330 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t331 = icmp eq i32 %t277, 17
  %t332 = select i1 %t331, i8* %t330, i8* %t329
  %t333 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t334 = icmp eq i32 %t277, 18
  %t335 = select i1 %t334, i8* %t333, i8* %t332
  %t336 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t337 = icmp eq i32 %t277, 19
  %t338 = select i1 %t337, i8* %t336, i8* %t335
  %t339 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t340 = icmp eq i32 %t277, 20
  %t341 = select i1 %t340, i8* %t339, i8* %t338
  %t342 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t343 = icmp eq i32 %t277, 21
  %t344 = select i1 %t343, i8* %t342, i8* %t341
  %t345 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t346 = icmp eq i32 %t277, 22
  %t347 = select i1 %t346, i8* %t345, i8* %t344
  %s348 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.348, i32 0, i32 0
  %t349 = icmp eq i8* %t347, %s348
  br i1 %t349, label %then4, label %merge5
then4:
  %t350 = extractvalue %Statement %statement, 0
  %t351 = alloca %Statement
  store %Statement %statement, %Statement* %t351
  %t352 = getelementptr inbounds %Statement, %Statement* %t351, i32 0, i32 1
  %t353 = bitcast [48 x i8]* %t352 to i8*
  %t354 = bitcast i8* %t353 to i8**
  %t355 = load i8*, i8** %t354
  %t356 = icmp eq i32 %t350, 2
  %t357 = select i1 %t356, i8* %t355, i8* null
  %t358 = getelementptr inbounds %Statement, %Statement* %t351, i32 0, i32 1
  %t359 = bitcast [48 x i8]* %t358 to i8*
  %t360 = bitcast i8* %t359 to i8**
  %t361 = load i8*, i8** %t360
  %t362 = icmp eq i32 %t350, 3
  %t363 = select i1 %t362, i8* %t361, i8* %t357
  %t364 = getelementptr inbounds %Statement, %Statement* %t351, i32 0, i32 1
  %t365 = bitcast [40 x i8]* %t364 to i8*
  %t366 = bitcast i8* %t365 to i8**
  %t367 = load i8*, i8** %t366
  %t368 = icmp eq i32 %t350, 6
  %t369 = select i1 %t368, i8* %t367, i8* %t363
  %t370 = getelementptr inbounds %Statement, %Statement* %t351, i32 0, i32 1
  %t371 = bitcast [56 x i8]* %t370 to i8*
  %t372 = bitcast i8* %t371 to i8**
  %t373 = load i8*, i8** %t372
  %t374 = icmp eq i32 %t350, 8
  %t375 = select i1 %t374, i8* %t373, i8* %t369
  %t376 = getelementptr inbounds %Statement, %Statement* %t351, i32 0, i32 1
  %t377 = bitcast [40 x i8]* %t376 to i8*
  %t378 = bitcast i8* %t377 to i8**
  %t379 = load i8*, i8** %t378
  %t380 = icmp eq i32 %t350, 9
  %t381 = select i1 %t380, i8* %t379, i8* %t375
  %t382 = getelementptr inbounds %Statement, %Statement* %t351, i32 0, i32 1
  %t383 = bitcast [40 x i8]* %t382 to i8*
  %t384 = bitcast i8* %t383 to i8**
  %t385 = load i8*, i8** %t384
  %t386 = icmp eq i32 %t350, 10
  %t387 = select i1 %t386, i8* %t385, i8* %t381
  %t388 = getelementptr inbounds %Statement, %Statement* %t351, i32 0, i32 1
  %t389 = bitcast [40 x i8]* %t388 to i8*
  %t390 = bitcast i8* %t389 to i8**
  %t391 = load i8*, i8** %t390
  %t392 = icmp eq i32 %t350, 11
  %t393 = select i1 %t392, i8* %t391, i8* %t387
  %s394 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.394, i32 0, i32 0
  %t395 = extractvalue %Statement %statement, 0
  %t396 = alloca %Statement
  store %Statement %statement, %Statement* %t396
  %t397 = getelementptr inbounds %Statement, %Statement* %t396, i32 0, i32 1
  %t398 = bitcast [48 x i8]* %t397 to i8*
  %t399 = getelementptr inbounds i8, i8* %t398, i64 8
  %t400 = bitcast i8* %t399 to i8**
  %t401 = load i8*, i8** %t400
  %t402 = icmp eq i32 %t395, 3
  %t403 = select i1 %t402, i8* %t401, i8* null
  %t404 = getelementptr inbounds %Statement, %Statement* %t396, i32 0, i32 1
  %t405 = bitcast [40 x i8]* %t404 to i8*
  %t406 = getelementptr inbounds i8, i8* %t405, i64 8
  %t407 = bitcast i8* %t406 to i8**
  %t408 = load i8*, i8** %t407
  %t409 = icmp eq i32 %t395, 6
  %t410 = select i1 %t409, i8* %t408, i8* %t403
  %t411 = getelementptr inbounds %Statement, %Statement* %t396, i32 0, i32 1
  %t412 = bitcast [56 x i8]* %t411 to i8*
  %t413 = getelementptr inbounds i8, i8* %t412, i64 8
  %t414 = bitcast i8* %t413 to i8**
  %t415 = load i8*, i8** %t414
  %t416 = icmp eq i32 %t395, 8
  %t417 = select i1 %t416, i8* %t415, i8* %t410
  %t418 = getelementptr inbounds %Statement, %Statement* %t396, i32 0, i32 1
  %t419 = bitcast [40 x i8]* %t418 to i8*
  %t420 = getelementptr inbounds i8, i8* %t419, i64 8
  %t421 = bitcast i8* %t420 to i8**
  %t422 = load i8*, i8** %t421
  %t423 = icmp eq i32 %t395, 9
  %t424 = select i1 %t423, i8* %t422, i8* %t417
  %t425 = getelementptr inbounds %Statement, %Statement* %t396, i32 0, i32 1
  %t426 = bitcast [40 x i8]* %t425 to i8*
  %t427 = getelementptr inbounds i8, i8* %t426, i64 8
  %t428 = bitcast i8* %t427 to i8**
  %t429 = load i8*, i8** %t428
  %t430 = icmp eq i32 %t395, 10
  %t431 = select i1 %t430, i8* %t429, i8* %t424
  %t432 = getelementptr inbounds %Statement, %Statement* %t396, i32 0, i32 1
  %t433 = bitcast [40 x i8]* %t432 to i8*
  %t434 = getelementptr inbounds i8, i8* %t433, i64 8
  %t435 = bitcast i8* %t434 to i8**
  %t436 = load i8*, i8** %t435
  %t437 = icmp eq i32 %t395, 11
  %t438 = select i1 %t437, i8* %t436, i8* %t431
  %t439 = call %SymbolCollectionResult @register_symbol(i8* %t393, i8* %s394, i8* %t438, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t439
merge5:
  %t440 = extractvalue %Statement %statement, 0
  %t441 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t442 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t443 = icmp eq i32 %t440, 0
  %t444 = select i1 %t443, i8* %t442, i8* %t441
  %t445 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t446 = icmp eq i32 %t440, 1
  %t447 = select i1 %t446, i8* %t445, i8* %t444
  %t448 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t449 = icmp eq i32 %t440, 2
  %t450 = select i1 %t449, i8* %t448, i8* %t447
  %t451 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t452 = icmp eq i32 %t440, 3
  %t453 = select i1 %t452, i8* %t451, i8* %t450
  %t454 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t455 = icmp eq i32 %t440, 4
  %t456 = select i1 %t455, i8* %t454, i8* %t453
  %t457 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t458 = icmp eq i32 %t440, 5
  %t459 = select i1 %t458, i8* %t457, i8* %t456
  %t460 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t461 = icmp eq i32 %t440, 6
  %t462 = select i1 %t461, i8* %t460, i8* %t459
  %t463 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t464 = icmp eq i32 %t440, 7
  %t465 = select i1 %t464, i8* %t463, i8* %t462
  %t466 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t467 = icmp eq i32 %t440, 8
  %t468 = select i1 %t467, i8* %t466, i8* %t465
  %t469 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t470 = icmp eq i32 %t440, 9
  %t471 = select i1 %t470, i8* %t469, i8* %t468
  %t472 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t473 = icmp eq i32 %t440, 10
  %t474 = select i1 %t473, i8* %t472, i8* %t471
  %t475 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t476 = icmp eq i32 %t440, 11
  %t477 = select i1 %t476, i8* %t475, i8* %t474
  %t478 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t479 = icmp eq i32 %t440, 12
  %t480 = select i1 %t479, i8* %t478, i8* %t477
  %t481 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t482 = icmp eq i32 %t440, 13
  %t483 = select i1 %t482, i8* %t481, i8* %t480
  %t484 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t485 = icmp eq i32 %t440, 14
  %t486 = select i1 %t485, i8* %t484, i8* %t483
  %t487 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t488 = icmp eq i32 %t440, 15
  %t489 = select i1 %t488, i8* %t487, i8* %t486
  %t490 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t491 = icmp eq i32 %t440, 16
  %t492 = select i1 %t491, i8* %t490, i8* %t489
  %t493 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t494 = icmp eq i32 %t440, 17
  %t495 = select i1 %t494, i8* %t493, i8* %t492
  %t496 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t497 = icmp eq i32 %t440, 18
  %t498 = select i1 %t497, i8* %t496, i8* %t495
  %t499 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t500 = icmp eq i32 %t440, 19
  %t501 = select i1 %t500, i8* %t499, i8* %t498
  %t502 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t503 = icmp eq i32 %t440, 20
  %t504 = select i1 %t503, i8* %t502, i8* %t501
  %t505 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t506 = icmp eq i32 %t440, 21
  %t507 = select i1 %t506, i8* %t505, i8* %t504
  %t508 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t509 = icmp eq i32 %t440, 22
  %t510 = select i1 %t509, i8* %t508, i8* %t507
  %s511 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.511, i32 0, i32 0
  %t512 = icmp eq i8* %t510, %s511
  br i1 %t512, label %then6, label %merge7
then6:
  %t513 = extractvalue %Statement %statement, 0
  %t514 = alloca %Statement
  store %Statement %statement, %Statement* %t514
  %t515 = getelementptr inbounds %Statement, %Statement* %t514, i32 0, i32 1
  %t516 = bitcast [48 x i8]* %t515 to i8*
  %t517 = bitcast i8* %t516 to i8**
  %t518 = load i8*, i8** %t517
  %t519 = icmp eq i32 %t513, 2
  %t520 = select i1 %t519, i8* %t518, i8* null
  %t521 = getelementptr inbounds %Statement, %Statement* %t514, i32 0, i32 1
  %t522 = bitcast [48 x i8]* %t521 to i8*
  %t523 = bitcast i8* %t522 to i8**
  %t524 = load i8*, i8** %t523
  %t525 = icmp eq i32 %t513, 3
  %t526 = select i1 %t525, i8* %t524, i8* %t520
  %t527 = getelementptr inbounds %Statement, %Statement* %t514, i32 0, i32 1
  %t528 = bitcast [40 x i8]* %t527 to i8*
  %t529 = bitcast i8* %t528 to i8**
  %t530 = load i8*, i8** %t529
  %t531 = icmp eq i32 %t513, 6
  %t532 = select i1 %t531, i8* %t530, i8* %t526
  %t533 = getelementptr inbounds %Statement, %Statement* %t514, i32 0, i32 1
  %t534 = bitcast [56 x i8]* %t533 to i8*
  %t535 = bitcast i8* %t534 to i8**
  %t536 = load i8*, i8** %t535
  %t537 = icmp eq i32 %t513, 8
  %t538 = select i1 %t537, i8* %t536, i8* %t532
  %t539 = getelementptr inbounds %Statement, %Statement* %t514, i32 0, i32 1
  %t540 = bitcast [40 x i8]* %t539 to i8*
  %t541 = bitcast i8* %t540 to i8**
  %t542 = load i8*, i8** %t541
  %t543 = icmp eq i32 %t513, 9
  %t544 = select i1 %t543, i8* %t542, i8* %t538
  %t545 = getelementptr inbounds %Statement, %Statement* %t514, i32 0, i32 1
  %t546 = bitcast [40 x i8]* %t545 to i8*
  %t547 = bitcast i8* %t546 to i8**
  %t548 = load i8*, i8** %t547
  %t549 = icmp eq i32 %t513, 10
  %t550 = select i1 %t549, i8* %t548, i8* %t544
  %t551 = getelementptr inbounds %Statement, %Statement* %t514, i32 0, i32 1
  %t552 = bitcast [40 x i8]* %t551 to i8*
  %t553 = bitcast i8* %t552 to i8**
  %t554 = load i8*, i8** %t553
  %t555 = icmp eq i32 %t513, 11
  %t556 = select i1 %t555, i8* %t554, i8* %t550
  %s557 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.557, i32 0, i32 0
  %t558 = extractvalue %Statement %statement, 0
  %t559 = alloca %Statement
  store %Statement %statement, %Statement* %t559
  %t560 = getelementptr inbounds %Statement, %Statement* %t559, i32 0, i32 1
  %t561 = bitcast [48 x i8]* %t560 to i8*
  %t562 = getelementptr inbounds i8, i8* %t561, i64 8
  %t563 = bitcast i8* %t562 to i8**
  %t564 = load i8*, i8** %t563
  %t565 = icmp eq i32 %t558, 3
  %t566 = select i1 %t565, i8* %t564, i8* null
  %t567 = getelementptr inbounds %Statement, %Statement* %t559, i32 0, i32 1
  %t568 = bitcast [40 x i8]* %t567 to i8*
  %t569 = getelementptr inbounds i8, i8* %t568, i64 8
  %t570 = bitcast i8* %t569 to i8**
  %t571 = load i8*, i8** %t570
  %t572 = icmp eq i32 %t558, 6
  %t573 = select i1 %t572, i8* %t571, i8* %t566
  %t574 = getelementptr inbounds %Statement, %Statement* %t559, i32 0, i32 1
  %t575 = bitcast [56 x i8]* %t574 to i8*
  %t576 = getelementptr inbounds i8, i8* %t575, i64 8
  %t577 = bitcast i8* %t576 to i8**
  %t578 = load i8*, i8** %t577
  %t579 = icmp eq i32 %t558, 8
  %t580 = select i1 %t579, i8* %t578, i8* %t573
  %t581 = getelementptr inbounds %Statement, %Statement* %t559, i32 0, i32 1
  %t582 = bitcast [40 x i8]* %t581 to i8*
  %t583 = getelementptr inbounds i8, i8* %t582, i64 8
  %t584 = bitcast i8* %t583 to i8**
  %t585 = load i8*, i8** %t584
  %t586 = icmp eq i32 %t558, 9
  %t587 = select i1 %t586, i8* %t585, i8* %t580
  %t588 = getelementptr inbounds %Statement, %Statement* %t559, i32 0, i32 1
  %t589 = bitcast [40 x i8]* %t588 to i8*
  %t590 = getelementptr inbounds i8, i8* %t589, i64 8
  %t591 = bitcast i8* %t590 to i8**
  %t592 = load i8*, i8** %t591
  %t593 = icmp eq i32 %t558, 10
  %t594 = select i1 %t593, i8* %t592, i8* %t587
  %t595 = getelementptr inbounds %Statement, %Statement* %t559, i32 0, i32 1
  %t596 = bitcast [40 x i8]* %t595 to i8*
  %t597 = getelementptr inbounds i8, i8* %t596, i64 8
  %t598 = bitcast i8* %t597 to i8**
  %t599 = load i8*, i8** %t598
  %t600 = icmp eq i32 %t558, 11
  %t601 = select i1 %t600, i8* %t599, i8* %t594
  %t602 = call %SymbolCollectionResult @register_symbol(i8* %t556, i8* %s557, i8* %t601, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t602
merge7:
  %t603 = extractvalue %Statement %statement, 0
  %t604 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t605 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t606 = icmp eq i32 %t603, 0
  %t607 = select i1 %t606, i8* %t605, i8* %t604
  %t608 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t609 = icmp eq i32 %t603, 1
  %t610 = select i1 %t609, i8* %t608, i8* %t607
  %t611 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t612 = icmp eq i32 %t603, 2
  %t613 = select i1 %t612, i8* %t611, i8* %t610
  %t614 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t615 = icmp eq i32 %t603, 3
  %t616 = select i1 %t615, i8* %t614, i8* %t613
  %t617 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t618 = icmp eq i32 %t603, 4
  %t619 = select i1 %t618, i8* %t617, i8* %t616
  %t620 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t621 = icmp eq i32 %t603, 5
  %t622 = select i1 %t621, i8* %t620, i8* %t619
  %t623 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t624 = icmp eq i32 %t603, 6
  %t625 = select i1 %t624, i8* %t623, i8* %t622
  %t626 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t627 = icmp eq i32 %t603, 7
  %t628 = select i1 %t627, i8* %t626, i8* %t625
  %t629 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t630 = icmp eq i32 %t603, 8
  %t631 = select i1 %t630, i8* %t629, i8* %t628
  %t632 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t633 = icmp eq i32 %t603, 9
  %t634 = select i1 %t633, i8* %t632, i8* %t631
  %t635 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t636 = icmp eq i32 %t603, 10
  %t637 = select i1 %t636, i8* %t635, i8* %t634
  %t638 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t639 = icmp eq i32 %t603, 11
  %t640 = select i1 %t639, i8* %t638, i8* %t637
  %t641 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t642 = icmp eq i32 %t603, 12
  %t643 = select i1 %t642, i8* %t641, i8* %t640
  %t644 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t645 = icmp eq i32 %t603, 13
  %t646 = select i1 %t645, i8* %t644, i8* %t643
  %t647 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t648 = icmp eq i32 %t603, 14
  %t649 = select i1 %t648, i8* %t647, i8* %t646
  %t650 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t651 = icmp eq i32 %t603, 15
  %t652 = select i1 %t651, i8* %t650, i8* %t649
  %t653 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t654 = icmp eq i32 %t603, 16
  %t655 = select i1 %t654, i8* %t653, i8* %t652
  %t656 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t657 = icmp eq i32 %t603, 17
  %t658 = select i1 %t657, i8* %t656, i8* %t655
  %t659 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t660 = icmp eq i32 %t603, 18
  %t661 = select i1 %t660, i8* %t659, i8* %t658
  %t662 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t663 = icmp eq i32 %t603, 19
  %t664 = select i1 %t663, i8* %t662, i8* %t661
  %t665 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t666 = icmp eq i32 %t603, 20
  %t667 = select i1 %t666, i8* %t665, i8* %t664
  %t668 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t669 = icmp eq i32 %t603, 21
  %t670 = select i1 %t669, i8* %t668, i8* %t667
  %t671 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t672 = icmp eq i32 %t603, 22
  %t673 = select i1 %t672, i8* %t671, i8* %t670
  %s674 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.674, i32 0, i32 0
  %t675 = icmp eq i8* %t673, %s674
  br i1 %t675, label %then8, label %merge9
then8:
  %t676 = extractvalue %Statement %statement, 0
  %t677 = alloca %Statement
  store %Statement %statement, %Statement* %t677
  %t678 = getelementptr inbounds %Statement, %Statement* %t677, i32 0, i32 1
  %t679 = bitcast [48 x i8]* %t678 to i8*
  %t680 = bitcast i8* %t679 to i8**
  %t681 = load i8*, i8** %t680
  %t682 = icmp eq i32 %t676, 2
  %t683 = select i1 %t682, i8* %t681, i8* null
  %t684 = getelementptr inbounds %Statement, %Statement* %t677, i32 0, i32 1
  %t685 = bitcast [48 x i8]* %t684 to i8*
  %t686 = bitcast i8* %t685 to i8**
  %t687 = load i8*, i8** %t686
  %t688 = icmp eq i32 %t676, 3
  %t689 = select i1 %t688, i8* %t687, i8* %t683
  %t690 = getelementptr inbounds %Statement, %Statement* %t677, i32 0, i32 1
  %t691 = bitcast [40 x i8]* %t690 to i8*
  %t692 = bitcast i8* %t691 to i8**
  %t693 = load i8*, i8** %t692
  %t694 = icmp eq i32 %t676, 6
  %t695 = select i1 %t694, i8* %t693, i8* %t689
  %t696 = getelementptr inbounds %Statement, %Statement* %t677, i32 0, i32 1
  %t697 = bitcast [56 x i8]* %t696 to i8*
  %t698 = bitcast i8* %t697 to i8**
  %t699 = load i8*, i8** %t698
  %t700 = icmp eq i32 %t676, 8
  %t701 = select i1 %t700, i8* %t699, i8* %t695
  %t702 = getelementptr inbounds %Statement, %Statement* %t677, i32 0, i32 1
  %t703 = bitcast [40 x i8]* %t702 to i8*
  %t704 = bitcast i8* %t703 to i8**
  %t705 = load i8*, i8** %t704
  %t706 = icmp eq i32 %t676, 9
  %t707 = select i1 %t706, i8* %t705, i8* %t701
  %t708 = getelementptr inbounds %Statement, %Statement* %t677, i32 0, i32 1
  %t709 = bitcast [40 x i8]* %t708 to i8*
  %t710 = bitcast i8* %t709 to i8**
  %t711 = load i8*, i8** %t710
  %t712 = icmp eq i32 %t676, 10
  %t713 = select i1 %t712, i8* %t711, i8* %t707
  %t714 = getelementptr inbounds %Statement, %Statement* %t677, i32 0, i32 1
  %t715 = bitcast [40 x i8]* %t714 to i8*
  %t716 = bitcast i8* %t715 to i8**
  %t717 = load i8*, i8** %t716
  %t718 = icmp eq i32 %t676, 11
  %t719 = select i1 %t718, i8* %t717, i8* %t713
  %s720 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.720, i32 0, i32 0
  %t721 = extractvalue %Statement %statement, 0
  %t722 = alloca %Statement
  store %Statement %statement, %Statement* %t722
  %t723 = getelementptr inbounds %Statement, %Statement* %t722, i32 0, i32 1
  %t724 = bitcast [48 x i8]* %t723 to i8*
  %t725 = getelementptr inbounds i8, i8* %t724, i64 8
  %t726 = bitcast i8* %t725 to i8**
  %t727 = load i8*, i8** %t726
  %t728 = icmp eq i32 %t721, 3
  %t729 = select i1 %t728, i8* %t727, i8* null
  %t730 = getelementptr inbounds %Statement, %Statement* %t722, i32 0, i32 1
  %t731 = bitcast [40 x i8]* %t730 to i8*
  %t732 = getelementptr inbounds i8, i8* %t731, i64 8
  %t733 = bitcast i8* %t732 to i8**
  %t734 = load i8*, i8** %t733
  %t735 = icmp eq i32 %t721, 6
  %t736 = select i1 %t735, i8* %t734, i8* %t729
  %t737 = getelementptr inbounds %Statement, %Statement* %t722, i32 0, i32 1
  %t738 = bitcast [56 x i8]* %t737 to i8*
  %t739 = getelementptr inbounds i8, i8* %t738, i64 8
  %t740 = bitcast i8* %t739 to i8**
  %t741 = load i8*, i8** %t740
  %t742 = icmp eq i32 %t721, 8
  %t743 = select i1 %t742, i8* %t741, i8* %t736
  %t744 = getelementptr inbounds %Statement, %Statement* %t722, i32 0, i32 1
  %t745 = bitcast [40 x i8]* %t744 to i8*
  %t746 = getelementptr inbounds i8, i8* %t745, i64 8
  %t747 = bitcast i8* %t746 to i8**
  %t748 = load i8*, i8** %t747
  %t749 = icmp eq i32 %t721, 9
  %t750 = select i1 %t749, i8* %t748, i8* %t743
  %t751 = getelementptr inbounds %Statement, %Statement* %t722, i32 0, i32 1
  %t752 = bitcast [40 x i8]* %t751 to i8*
  %t753 = getelementptr inbounds i8, i8* %t752, i64 8
  %t754 = bitcast i8* %t753 to i8**
  %t755 = load i8*, i8** %t754
  %t756 = icmp eq i32 %t721, 10
  %t757 = select i1 %t756, i8* %t755, i8* %t750
  %t758 = getelementptr inbounds %Statement, %Statement* %t722, i32 0, i32 1
  %t759 = bitcast [40 x i8]* %t758 to i8*
  %t760 = getelementptr inbounds i8, i8* %t759, i64 8
  %t761 = bitcast i8* %t760 to i8**
  %t762 = load i8*, i8** %t761
  %t763 = icmp eq i32 %t721, 11
  %t764 = select i1 %t763, i8* %t762, i8* %t757
  %t765 = call %SymbolCollectionResult @register_symbol(i8* %t719, i8* %s720, i8* %t764, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t765
merge9:
  %t766 = extractvalue %Statement %statement, 0
  %t767 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t768 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t769 = icmp eq i32 %t766, 0
  %t770 = select i1 %t769, i8* %t768, i8* %t767
  %t771 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t772 = icmp eq i32 %t766, 1
  %t773 = select i1 %t772, i8* %t771, i8* %t770
  %t774 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t775 = icmp eq i32 %t766, 2
  %t776 = select i1 %t775, i8* %t774, i8* %t773
  %t777 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t778 = icmp eq i32 %t766, 3
  %t779 = select i1 %t778, i8* %t777, i8* %t776
  %t780 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t781 = icmp eq i32 %t766, 4
  %t782 = select i1 %t781, i8* %t780, i8* %t779
  %t783 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t784 = icmp eq i32 %t766, 5
  %t785 = select i1 %t784, i8* %t783, i8* %t782
  %t786 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t787 = icmp eq i32 %t766, 6
  %t788 = select i1 %t787, i8* %t786, i8* %t785
  %t789 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t790 = icmp eq i32 %t766, 7
  %t791 = select i1 %t790, i8* %t789, i8* %t788
  %t792 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t793 = icmp eq i32 %t766, 8
  %t794 = select i1 %t793, i8* %t792, i8* %t791
  %t795 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t796 = icmp eq i32 %t766, 9
  %t797 = select i1 %t796, i8* %t795, i8* %t794
  %t798 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t799 = icmp eq i32 %t766, 10
  %t800 = select i1 %t799, i8* %t798, i8* %t797
  %t801 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t802 = icmp eq i32 %t766, 11
  %t803 = select i1 %t802, i8* %t801, i8* %t800
  %t804 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t805 = icmp eq i32 %t766, 12
  %t806 = select i1 %t805, i8* %t804, i8* %t803
  %t807 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t808 = icmp eq i32 %t766, 13
  %t809 = select i1 %t808, i8* %t807, i8* %t806
  %t810 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t811 = icmp eq i32 %t766, 14
  %t812 = select i1 %t811, i8* %t810, i8* %t809
  %t813 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t814 = icmp eq i32 %t766, 15
  %t815 = select i1 %t814, i8* %t813, i8* %t812
  %t816 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t817 = icmp eq i32 %t766, 16
  %t818 = select i1 %t817, i8* %t816, i8* %t815
  %t819 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t820 = icmp eq i32 %t766, 17
  %t821 = select i1 %t820, i8* %t819, i8* %t818
  %t822 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t823 = icmp eq i32 %t766, 18
  %t824 = select i1 %t823, i8* %t822, i8* %t821
  %t825 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t826 = icmp eq i32 %t766, 19
  %t827 = select i1 %t826, i8* %t825, i8* %t824
  %t828 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t829 = icmp eq i32 %t766, 20
  %t830 = select i1 %t829, i8* %t828, i8* %t827
  %t831 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t832 = icmp eq i32 %t766, 21
  %t833 = select i1 %t832, i8* %t831, i8* %t830
  %t834 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t835 = icmp eq i32 %t766, 22
  %t836 = select i1 %t835, i8* %t834, i8* %t833
  %s837 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.837, i32 0, i32 0
  %t838 = icmp eq i8* %t836, %s837
  br i1 %t838, label %then10, label %merge11
then10:
  %t839 = extractvalue %Statement %statement, 0
  %t840 = alloca %Statement
  store %Statement %statement, %Statement* %t840
  %t841 = getelementptr inbounds %Statement, %Statement* %t840, i32 0, i32 1
  %t842 = bitcast [24 x i8]* %t841 to i8*
  %t843 = bitcast i8* %t842 to i8**
  %t844 = load i8*, i8** %t843
  %t845 = icmp eq i32 %t839, 4
  %t846 = select i1 %t845, i8* %t844, i8* null
  %t847 = getelementptr inbounds %Statement, %Statement* %t840, i32 0, i32 1
  %t848 = bitcast [24 x i8]* %t847 to i8*
  %t849 = bitcast i8* %t848 to i8**
  %t850 = load i8*, i8** %t849
  %t851 = icmp eq i32 %t839, 5
  %t852 = select i1 %t851, i8* %t850, i8* %t846
  %t853 = getelementptr inbounds %Statement, %Statement* %t840, i32 0, i32 1
  %t854 = bitcast [24 x i8]* %t853 to i8*
  %t855 = bitcast i8* %t854 to i8**
  %t856 = load i8*, i8** %t855
  %t857 = icmp eq i32 %t839, 7
  %t858 = select i1 %t857, i8* %t856, i8* %t852
  %s859 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.859, i32 0, i32 0
  %t860 = extractvalue %Statement %statement, 0
  %t861 = alloca %Statement
  store %Statement %statement, %Statement* %t861
  %t862 = getelementptr inbounds %Statement, %Statement* %t861, i32 0, i32 1
  %t863 = bitcast [24 x i8]* %t862 to i8*
  %t864 = bitcast i8* %t863 to i8**
  %t865 = load i8*, i8** %t864
  %t866 = icmp eq i32 %t860, 4
  %t867 = select i1 %t866, i8* %t865, i8* null
  %t868 = getelementptr inbounds %Statement, %Statement* %t861, i32 0, i32 1
  %t869 = bitcast [24 x i8]* %t868 to i8*
  %t870 = bitcast i8* %t869 to i8**
  %t871 = load i8*, i8** %t870
  %t872 = icmp eq i32 %t860, 5
  %t873 = select i1 %t872, i8* %t871, i8* %t867
  %t874 = getelementptr inbounds %Statement, %Statement* %t861, i32 0, i32 1
  %t875 = bitcast [24 x i8]* %t874 to i8*
  %t876 = bitcast i8* %t875 to i8**
  %t877 = load i8*, i8** %t876
  %t878 = icmp eq i32 %t860, 7
  %t879 = select i1 %t878, i8* %t877, i8* %t873
  ret %SymbolCollectionResult zeroinitializer
merge11:
  %t880 = extractvalue %Statement %statement, 0
  %t881 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t882 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t883 = icmp eq i32 %t880, 0
  %t884 = select i1 %t883, i8* %t882, i8* %t881
  %t885 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t886 = icmp eq i32 %t880, 1
  %t887 = select i1 %t886, i8* %t885, i8* %t884
  %t888 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t889 = icmp eq i32 %t880, 2
  %t890 = select i1 %t889, i8* %t888, i8* %t887
  %t891 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t892 = icmp eq i32 %t880, 3
  %t893 = select i1 %t892, i8* %t891, i8* %t890
  %t894 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t895 = icmp eq i32 %t880, 4
  %t896 = select i1 %t895, i8* %t894, i8* %t893
  %t897 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t898 = icmp eq i32 %t880, 5
  %t899 = select i1 %t898, i8* %t897, i8* %t896
  %t900 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t901 = icmp eq i32 %t880, 6
  %t902 = select i1 %t901, i8* %t900, i8* %t899
  %t903 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t904 = icmp eq i32 %t880, 7
  %t905 = select i1 %t904, i8* %t903, i8* %t902
  %t906 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t907 = icmp eq i32 %t880, 8
  %t908 = select i1 %t907, i8* %t906, i8* %t905
  %t909 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t910 = icmp eq i32 %t880, 9
  %t911 = select i1 %t910, i8* %t909, i8* %t908
  %t912 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t913 = icmp eq i32 %t880, 10
  %t914 = select i1 %t913, i8* %t912, i8* %t911
  %t915 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t916 = icmp eq i32 %t880, 11
  %t917 = select i1 %t916, i8* %t915, i8* %t914
  %t918 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t919 = icmp eq i32 %t880, 12
  %t920 = select i1 %t919, i8* %t918, i8* %t917
  %t921 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t922 = icmp eq i32 %t880, 13
  %t923 = select i1 %t922, i8* %t921, i8* %t920
  %t924 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t925 = icmp eq i32 %t880, 14
  %t926 = select i1 %t925, i8* %t924, i8* %t923
  %t927 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t928 = icmp eq i32 %t880, 15
  %t929 = select i1 %t928, i8* %t927, i8* %t926
  %t930 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t931 = icmp eq i32 %t880, 16
  %t932 = select i1 %t931, i8* %t930, i8* %t929
  %t933 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t934 = icmp eq i32 %t880, 17
  %t935 = select i1 %t934, i8* %t933, i8* %t932
  %t936 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t937 = icmp eq i32 %t880, 18
  %t938 = select i1 %t937, i8* %t936, i8* %t935
  %t939 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t940 = icmp eq i32 %t880, 19
  %t941 = select i1 %t940, i8* %t939, i8* %t938
  %t942 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t943 = icmp eq i32 %t880, 20
  %t944 = select i1 %t943, i8* %t942, i8* %t941
  %t945 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t946 = icmp eq i32 %t880, 21
  %t947 = select i1 %t946, i8* %t945, i8* %t944
  %t948 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t949 = icmp eq i32 %t880, 22
  %t950 = select i1 %t949, i8* %t948, i8* %t947
  %s951 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.951, i32 0, i32 0
  %t952 = icmp eq i8* %t950, %s951
  br i1 %t952, label %then12, label %merge13
then12:
  %t953 = extractvalue %Statement %statement, 0
  %t954 = alloca %Statement
  store %Statement %statement, %Statement* %t954
  %t955 = getelementptr inbounds %Statement, %Statement* %t954, i32 0, i32 1
  %t956 = bitcast [24 x i8]* %t955 to i8*
  %t957 = bitcast i8* %t956 to i8**
  %t958 = load i8*, i8** %t957
  %t959 = icmp eq i32 %t953, 4
  %t960 = select i1 %t959, i8* %t958, i8* null
  %t961 = getelementptr inbounds %Statement, %Statement* %t954, i32 0, i32 1
  %t962 = bitcast [24 x i8]* %t961 to i8*
  %t963 = bitcast i8* %t962 to i8**
  %t964 = load i8*, i8** %t963
  %t965 = icmp eq i32 %t953, 5
  %t966 = select i1 %t965, i8* %t964, i8* %t960
  %t967 = getelementptr inbounds %Statement, %Statement* %t954, i32 0, i32 1
  %t968 = bitcast [24 x i8]* %t967 to i8*
  %t969 = bitcast i8* %t968 to i8**
  %t970 = load i8*, i8** %t969
  %t971 = icmp eq i32 %t953, 7
  %t972 = select i1 %t971, i8* %t970, i8* %t966
  %s973 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.973, i32 0, i32 0
  %t974 = extractvalue %Statement %statement, 0
  %t975 = alloca %Statement
  store %Statement %statement, %Statement* %t975
  %t976 = getelementptr inbounds %Statement, %Statement* %t975, i32 0, i32 1
  %t977 = bitcast [24 x i8]* %t976 to i8*
  %t978 = bitcast i8* %t977 to i8**
  %t979 = load i8*, i8** %t978
  %t980 = icmp eq i32 %t974, 4
  %t981 = select i1 %t980, i8* %t979, i8* null
  %t982 = getelementptr inbounds %Statement, %Statement* %t975, i32 0, i32 1
  %t983 = bitcast [24 x i8]* %t982 to i8*
  %t984 = bitcast i8* %t983 to i8**
  %t985 = load i8*, i8** %t984
  %t986 = icmp eq i32 %t974, 5
  %t987 = select i1 %t986, i8* %t985, i8* %t981
  %t988 = getelementptr inbounds %Statement, %Statement* %t975, i32 0, i32 1
  %t989 = bitcast [24 x i8]* %t988 to i8*
  %t990 = bitcast i8* %t989 to i8**
  %t991 = load i8*, i8** %t990
  %t992 = icmp eq i32 %t974, 7
  %t993 = select i1 %t992, i8* %t991, i8* %t987
  ret %SymbolCollectionResult zeroinitializer
merge13:
  %t994 = extractvalue %Statement %statement, 0
  %t995 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t996 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t997 = icmp eq i32 %t994, 0
  %t998 = select i1 %t997, i8* %t996, i8* %t995
  %t999 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1000 = icmp eq i32 %t994, 1
  %t1001 = select i1 %t1000, i8* %t999, i8* %t998
  %t1002 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1003 = icmp eq i32 %t994, 2
  %t1004 = select i1 %t1003, i8* %t1002, i8* %t1001
  %t1005 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1006 = icmp eq i32 %t994, 3
  %t1007 = select i1 %t1006, i8* %t1005, i8* %t1004
  %t1008 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1009 = icmp eq i32 %t994, 4
  %t1010 = select i1 %t1009, i8* %t1008, i8* %t1007
  %t1011 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1012 = icmp eq i32 %t994, 5
  %t1013 = select i1 %t1012, i8* %t1011, i8* %t1010
  %t1014 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1015 = icmp eq i32 %t994, 6
  %t1016 = select i1 %t1015, i8* %t1014, i8* %t1013
  %t1017 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1018 = icmp eq i32 %t994, 7
  %t1019 = select i1 %t1018, i8* %t1017, i8* %t1016
  %t1020 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1021 = icmp eq i32 %t994, 8
  %t1022 = select i1 %t1021, i8* %t1020, i8* %t1019
  %t1023 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1024 = icmp eq i32 %t994, 9
  %t1025 = select i1 %t1024, i8* %t1023, i8* %t1022
  %t1026 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1027 = icmp eq i32 %t994, 10
  %t1028 = select i1 %t1027, i8* %t1026, i8* %t1025
  %t1029 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1030 = icmp eq i32 %t994, 11
  %t1031 = select i1 %t1030, i8* %t1029, i8* %t1028
  %t1032 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1033 = icmp eq i32 %t994, 12
  %t1034 = select i1 %t1033, i8* %t1032, i8* %t1031
  %t1035 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1036 = icmp eq i32 %t994, 13
  %t1037 = select i1 %t1036, i8* %t1035, i8* %t1034
  %t1038 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1039 = icmp eq i32 %t994, 14
  %t1040 = select i1 %t1039, i8* %t1038, i8* %t1037
  %t1041 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1042 = icmp eq i32 %t994, 15
  %t1043 = select i1 %t1042, i8* %t1041, i8* %t1040
  %t1044 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1045 = icmp eq i32 %t994, 16
  %t1046 = select i1 %t1045, i8* %t1044, i8* %t1043
  %t1047 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1048 = icmp eq i32 %t994, 17
  %t1049 = select i1 %t1048, i8* %t1047, i8* %t1046
  %t1050 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1051 = icmp eq i32 %t994, 18
  %t1052 = select i1 %t1051, i8* %t1050, i8* %t1049
  %t1053 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1054 = icmp eq i32 %t994, 19
  %t1055 = select i1 %t1054, i8* %t1053, i8* %t1052
  %t1056 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1057 = icmp eq i32 %t994, 20
  %t1058 = select i1 %t1057, i8* %t1056, i8* %t1055
  %t1059 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1060 = icmp eq i32 %t994, 21
  %t1061 = select i1 %t1060, i8* %t1059, i8* %t1058
  %t1062 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1063 = icmp eq i32 %t994, 22
  %t1064 = select i1 %t1063, i8* %t1062, i8* %t1061
  %s1065 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1065, i32 0, i32 0
  %t1066 = icmp eq i8* %t1064, %s1065
  br i1 %t1066, label %then14, label %merge15
then14:
  %t1067 = extractvalue %Statement %statement, 0
  %t1068 = alloca %Statement
  store %Statement %statement, %Statement* %t1068
  %t1069 = getelementptr inbounds %Statement, %Statement* %t1068, i32 0, i32 1
  %t1070 = bitcast [48 x i8]* %t1069 to i8*
  %t1071 = bitcast i8* %t1070 to i8**
  %t1072 = load i8*, i8** %t1071
  %t1073 = icmp eq i32 %t1067, 2
  %t1074 = select i1 %t1073, i8* %t1072, i8* null
  %t1075 = getelementptr inbounds %Statement, %Statement* %t1068, i32 0, i32 1
  %t1076 = bitcast [48 x i8]* %t1075 to i8*
  %t1077 = bitcast i8* %t1076 to i8**
  %t1078 = load i8*, i8** %t1077
  %t1079 = icmp eq i32 %t1067, 3
  %t1080 = select i1 %t1079, i8* %t1078, i8* %t1074
  %t1081 = getelementptr inbounds %Statement, %Statement* %t1068, i32 0, i32 1
  %t1082 = bitcast [40 x i8]* %t1081 to i8*
  %t1083 = bitcast i8* %t1082 to i8**
  %t1084 = load i8*, i8** %t1083
  %t1085 = icmp eq i32 %t1067, 6
  %t1086 = select i1 %t1085, i8* %t1084, i8* %t1080
  %t1087 = getelementptr inbounds %Statement, %Statement* %t1068, i32 0, i32 1
  %t1088 = bitcast [56 x i8]* %t1087 to i8*
  %t1089 = bitcast i8* %t1088 to i8**
  %t1090 = load i8*, i8** %t1089
  %t1091 = icmp eq i32 %t1067, 8
  %t1092 = select i1 %t1091, i8* %t1090, i8* %t1086
  %t1093 = getelementptr inbounds %Statement, %Statement* %t1068, i32 0, i32 1
  %t1094 = bitcast [40 x i8]* %t1093 to i8*
  %t1095 = bitcast i8* %t1094 to i8**
  %t1096 = load i8*, i8** %t1095
  %t1097 = icmp eq i32 %t1067, 9
  %t1098 = select i1 %t1097, i8* %t1096, i8* %t1092
  %t1099 = getelementptr inbounds %Statement, %Statement* %t1068, i32 0, i32 1
  %t1100 = bitcast [40 x i8]* %t1099 to i8*
  %t1101 = bitcast i8* %t1100 to i8**
  %t1102 = load i8*, i8** %t1101
  %t1103 = icmp eq i32 %t1067, 10
  %t1104 = select i1 %t1103, i8* %t1102, i8* %t1098
  %t1105 = getelementptr inbounds %Statement, %Statement* %t1068, i32 0, i32 1
  %t1106 = bitcast [40 x i8]* %t1105 to i8*
  %t1107 = bitcast i8* %t1106 to i8**
  %t1108 = load i8*, i8** %t1107
  %t1109 = icmp eq i32 %t1067, 11
  %t1110 = select i1 %t1109, i8* %t1108, i8* %t1104
  %s1111 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1111, i32 0, i32 0
  %t1112 = extractvalue %Statement %statement, 0
  %t1113 = alloca %Statement
  store %Statement %statement, %Statement* %t1113
  %t1114 = getelementptr inbounds %Statement, %Statement* %t1113, i32 0, i32 1
  %t1115 = bitcast [48 x i8]* %t1114 to i8*
  %t1116 = getelementptr inbounds i8, i8* %t1115, i64 8
  %t1117 = bitcast i8* %t1116 to i8**
  %t1118 = load i8*, i8** %t1117
  %t1119 = icmp eq i32 %t1112, 3
  %t1120 = select i1 %t1119, i8* %t1118, i8* null
  %t1121 = getelementptr inbounds %Statement, %Statement* %t1113, i32 0, i32 1
  %t1122 = bitcast [40 x i8]* %t1121 to i8*
  %t1123 = getelementptr inbounds i8, i8* %t1122, i64 8
  %t1124 = bitcast i8* %t1123 to i8**
  %t1125 = load i8*, i8** %t1124
  %t1126 = icmp eq i32 %t1112, 6
  %t1127 = select i1 %t1126, i8* %t1125, i8* %t1120
  %t1128 = getelementptr inbounds %Statement, %Statement* %t1113, i32 0, i32 1
  %t1129 = bitcast [56 x i8]* %t1128 to i8*
  %t1130 = getelementptr inbounds i8, i8* %t1129, i64 8
  %t1131 = bitcast i8* %t1130 to i8**
  %t1132 = load i8*, i8** %t1131
  %t1133 = icmp eq i32 %t1112, 8
  %t1134 = select i1 %t1133, i8* %t1132, i8* %t1127
  %t1135 = getelementptr inbounds %Statement, %Statement* %t1113, i32 0, i32 1
  %t1136 = bitcast [40 x i8]* %t1135 to i8*
  %t1137 = getelementptr inbounds i8, i8* %t1136, i64 8
  %t1138 = bitcast i8* %t1137 to i8**
  %t1139 = load i8*, i8** %t1138
  %t1140 = icmp eq i32 %t1112, 9
  %t1141 = select i1 %t1140, i8* %t1139, i8* %t1134
  %t1142 = getelementptr inbounds %Statement, %Statement* %t1113, i32 0, i32 1
  %t1143 = bitcast [40 x i8]* %t1142 to i8*
  %t1144 = getelementptr inbounds i8, i8* %t1143, i64 8
  %t1145 = bitcast i8* %t1144 to i8**
  %t1146 = load i8*, i8** %t1145
  %t1147 = icmp eq i32 %t1112, 10
  %t1148 = select i1 %t1147, i8* %t1146, i8* %t1141
  %t1149 = getelementptr inbounds %Statement, %Statement* %t1113, i32 0, i32 1
  %t1150 = bitcast [40 x i8]* %t1149 to i8*
  %t1151 = getelementptr inbounds i8, i8* %t1150, i64 8
  %t1152 = bitcast i8* %t1151 to i8**
  %t1153 = load i8*, i8** %t1152
  %t1154 = icmp eq i32 %t1112, 11
  %t1155 = select i1 %t1154, i8* %t1153, i8* %t1148
  %t1156 = call %SymbolCollectionResult @register_symbol(i8* %t1110, i8* %s1111, i8* %t1155, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1156
merge15:
  %t1157 = extractvalue %Statement %statement, 0
  %t1158 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1159 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1160 = icmp eq i32 %t1157, 0
  %t1161 = select i1 %t1160, i8* %t1159, i8* %t1158
  %t1162 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1163 = icmp eq i32 %t1157, 1
  %t1164 = select i1 %t1163, i8* %t1162, i8* %t1161
  %t1165 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1166 = icmp eq i32 %t1157, 2
  %t1167 = select i1 %t1166, i8* %t1165, i8* %t1164
  %t1168 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1169 = icmp eq i32 %t1157, 3
  %t1170 = select i1 %t1169, i8* %t1168, i8* %t1167
  %t1171 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1172 = icmp eq i32 %t1157, 4
  %t1173 = select i1 %t1172, i8* %t1171, i8* %t1170
  %t1174 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1175 = icmp eq i32 %t1157, 5
  %t1176 = select i1 %t1175, i8* %t1174, i8* %t1173
  %t1177 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1178 = icmp eq i32 %t1157, 6
  %t1179 = select i1 %t1178, i8* %t1177, i8* %t1176
  %t1180 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1181 = icmp eq i32 %t1157, 7
  %t1182 = select i1 %t1181, i8* %t1180, i8* %t1179
  %t1183 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1184 = icmp eq i32 %t1157, 8
  %t1185 = select i1 %t1184, i8* %t1183, i8* %t1182
  %t1186 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1187 = icmp eq i32 %t1157, 9
  %t1188 = select i1 %t1187, i8* %t1186, i8* %t1185
  %t1189 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1190 = icmp eq i32 %t1157, 10
  %t1191 = select i1 %t1190, i8* %t1189, i8* %t1188
  %t1192 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1193 = icmp eq i32 %t1157, 11
  %t1194 = select i1 %t1193, i8* %t1192, i8* %t1191
  %t1195 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1196 = icmp eq i32 %t1157, 12
  %t1197 = select i1 %t1196, i8* %t1195, i8* %t1194
  %t1198 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1199 = icmp eq i32 %t1157, 13
  %t1200 = select i1 %t1199, i8* %t1198, i8* %t1197
  %t1201 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1202 = icmp eq i32 %t1157, 14
  %t1203 = select i1 %t1202, i8* %t1201, i8* %t1200
  %t1204 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1205 = icmp eq i32 %t1157, 15
  %t1206 = select i1 %t1205, i8* %t1204, i8* %t1203
  %t1207 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1208 = icmp eq i32 %t1157, 16
  %t1209 = select i1 %t1208, i8* %t1207, i8* %t1206
  %t1210 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1211 = icmp eq i32 %t1157, 17
  %t1212 = select i1 %t1211, i8* %t1210, i8* %t1209
  %t1213 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1214 = icmp eq i32 %t1157, 18
  %t1215 = select i1 %t1214, i8* %t1213, i8* %t1212
  %t1216 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1217 = icmp eq i32 %t1157, 19
  %t1218 = select i1 %t1217, i8* %t1216, i8* %t1215
  %t1219 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1220 = icmp eq i32 %t1157, 20
  %t1221 = select i1 %t1220, i8* %t1219, i8* %t1218
  %t1222 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1223 = icmp eq i32 %t1157, 21
  %t1224 = select i1 %t1223, i8* %t1222, i8* %t1221
  %t1225 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1226 = icmp eq i32 %t1157, 22
  %t1227 = select i1 %t1226, i8* %t1225, i8* %t1224
  %s1228 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.1228, i32 0, i32 0
  %t1229 = icmp eq i8* %t1227, %s1228
  br i1 %t1229, label %then16, label %merge17
then16:
  %t1230 = extractvalue %Statement %statement, 0
  %t1231 = alloca %Statement
  store %Statement %statement, %Statement* %t1231
  %t1232 = getelementptr inbounds %Statement, %Statement* %t1231, i32 0, i32 1
  %t1233 = bitcast [48 x i8]* %t1232 to i8*
  %t1234 = bitcast i8* %t1233 to i8**
  %t1235 = load i8*, i8** %t1234
  %t1236 = icmp eq i32 %t1230, 2
  %t1237 = select i1 %t1236, i8* %t1235, i8* null
  %t1238 = getelementptr inbounds %Statement, %Statement* %t1231, i32 0, i32 1
  %t1239 = bitcast [48 x i8]* %t1238 to i8*
  %t1240 = bitcast i8* %t1239 to i8**
  %t1241 = load i8*, i8** %t1240
  %t1242 = icmp eq i32 %t1230, 3
  %t1243 = select i1 %t1242, i8* %t1241, i8* %t1237
  %t1244 = getelementptr inbounds %Statement, %Statement* %t1231, i32 0, i32 1
  %t1245 = bitcast [40 x i8]* %t1244 to i8*
  %t1246 = bitcast i8* %t1245 to i8**
  %t1247 = load i8*, i8** %t1246
  %t1248 = icmp eq i32 %t1230, 6
  %t1249 = select i1 %t1248, i8* %t1247, i8* %t1243
  %t1250 = getelementptr inbounds %Statement, %Statement* %t1231, i32 0, i32 1
  %t1251 = bitcast [56 x i8]* %t1250 to i8*
  %t1252 = bitcast i8* %t1251 to i8**
  %t1253 = load i8*, i8** %t1252
  %t1254 = icmp eq i32 %t1230, 8
  %t1255 = select i1 %t1254, i8* %t1253, i8* %t1249
  %t1256 = getelementptr inbounds %Statement, %Statement* %t1231, i32 0, i32 1
  %t1257 = bitcast [40 x i8]* %t1256 to i8*
  %t1258 = bitcast i8* %t1257 to i8**
  %t1259 = load i8*, i8** %t1258
  %t1260 = icmp eq i32 %t1230, 9
  %t1261 = select i1 %t1260, i8* %t1259, i8* %t1255
  %t1262 = getelementptr inbounds %Statement, %Statement* %t1231, i32 0, i32 1
  %t1263 = bitcast [40 x i8]* %t1262 to i8*
  %t1264 = bitcast i8* %t1263 to i8**
  %t1265 = load i8*, i8** %t1264
  %t1266 = icmp eq i32 %t1230, 10
  %t1267 = select i1 %t1266, i8* %t1265, i8* %t1261
  %t1268 = getelementptr inbounds %Statement, %Statement* %t1231, i32 0, i32 1
  %t1269 = bitcast [40 x i8]* %t1268 to i8*
  %t1270 = bitcast i8* %t1269 to i8**
  %t1271 = load i8*, i8** %t1270
  %t1272 = icmp eq i32 %t1230, 11
  %t1273 = select i1 %t1272, i8* %t1271, i8* %t1267
  %s1274 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1274, i32 0, i32 0
  %t1275 = extractvalue %Statement %statement, 0
  %t1276 = alloca %Statement
  store %Statement %statement, %Statement* %t1276
  %t1277 = getelementptr inbounds %Statement, %Statement* %t1276, i32 0, i32 1
  %t1278 = bitcast [48 x i8]* %t1277 to i8*
  %t1279 = getelementptr inbounds i8, i8* %t1278, i64 8
  %t1280 = bitcast i8* %t1279 to i8**
  %t1281 = load i8*, i8** %t1280
  %t1282 = icmp eq i32 %t1275, 3
  %t1283 = select i1 %t1282, i8* %t1281, i8* null
  %t1284 = getelementptr inbounds %Statement, %Statement* %t1276, i32 0, i32 1
  %t1285 = bitcast [40 x i8]* %t1284 to i8*
  %t1286 = getelementptr inbounds i8, i8* %t1285, i64 8
  %t1287 = bitcast i8* %t1286 to i8**
  %t1288 = load i8*, i8** %t1287
  %t1289 = icmp eq i32 %t1275, 6
  %t1290 = select i1 %t1289, i8* %t1288, i8* %t1283
  %t1291 = getelementptr inbounds %Statement, %Statement* %t1276, i32 0, i32 1
  %t1292 = bitcast [56 x i8]* %t1291 to i8*
  %t1293 = getelementptr inbounds i8, i8* %t1292, i64 8
  %t1294 = bitcast i8* %t1293 to i8**
  %t1295 = load i8*, i8** %t1294
  %t1296 = icmp eq i32 %t1275, 8
  %t1297 = select i1 %t1296, i8* %t1295, i8* %t1290
  %t1298 = getelementptr inbounds %Statement, %Statement* %t1276, i32 0, i32 1
  %t1299 = bitcast [40 x i8]* %t1298 to i8*
  %t1300 = getelementptr inbounds i8, i8* %t1299, i64 8
  %t1301 = bitcast i8* %t1300 to i8**
  %t1302 = load i8*, i8** %t1301
  %t1303 = icmp eq i32 %t1275, 9
  %t1304 = select i1 %t1303, i8* %t1302, i8* %t1297
  %t1305 = getelementptr inbounds %Statement, %Statement* %t1276, i32 0, i32 1
  %t1306 = bitcast [40 x i8]* %t1305 to i8*
  %t1307 = getelementptr inbounds i8, i8* %t1306, i64 8
  %t1308 = bitcast i8* %t1307 to i8**
  %t1309 = load i8*, i8** %t1308
  %t1310 = icmp eq i32 %t1275, 10
  %t1311 = select i1 %t1310, i8* %t1309, i8* %t1304
  %t1312 = getelementptr inbounds %Statement, %Statement* %t1276, i32 0, i32 1
  %t1313 = bitcast [40 x i8]* %t1312 to i8*
  %t1314 = getelementptr inbounds i8, i8* %t1313, i64 8
  %t1315 = bitcast i8* %t1314 to i8**
  %t1316 = load i8*, i8** %t1315
  %t1317 = icmp eq i32 %t1275, 11
  %t1318 = select i1 %t1317, i8* %t1316, i8* %t1311
  %t1319 = call %SymbolCollectionResult @register_symbol(i8* %t1273, i8* %s1274, i8* %t1318, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1319
merge17:
  %t1320 = extractvalue %Statement %statement, 0
  %t1321 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1322 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1323 = icmp eq i32 %t1320, 0
  %t1324 = select i1 %t1323, i8* %t1322, i8* %t1321
  %t1325 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1326 = icmp eq i32 %t1320, 1
  %t1327 = select i1 %t1326, i8* %t1325, i8* %t1324
  %t1328 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1329 = icmp eq i32 %t1320, 2
  %t1330 = select i1 %t1329, i8* %t1328, i8* %t1327
  %t1331 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1332 = icmp eq i32 %t1320, 3
  %t1333 = select i1 %t1332, i8* %t1331, i8* %t1330
  %t1334 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1335 = icmp eq i32 %t1320, 4
  %t1336 = select i1 %t1335, i8* %t1334, i8* %t1333
  %t1337 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1338 = icmp eq i32 %t1320, 5
  %t1339 = select i1 %t1338, i8* %t1337, i8* %t1336
  %t1340 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1341 = icmp eq i32 %t1320, 6
  %t1342 = select i1 %t1341, i8* %t1340, i8* %t1339
  %t1343 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1344 = icmp eq i32 %t1320, 7
  %t1345 = select i1 %t1344, i8* %t1343, i8* %t1342
  %t1346 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1347 = icmp eq i32 %t1320, 8
  %t1348 = select i1 %t1347, i8* %t1346, i8* %t1345
  %t1349 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1350 = icmp eq i32 %t1320, 9
  %t1351 = select i1 %t1350, i8* %t1349, i8* %t1348
  %t1352 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1353 = icmp eq i32 %t1320, 10
  %t1354 = select i1 %t1353, i8* %t1352, i8* %t1351
  %t1355 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1356 = icmp eq i32 %t1320, 11
  %t1357 = select i1 %t1356, i8* %t1355, i8* %t1354
  %t1358 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1359 = icmp eq i32 %t1320, 12
  %t1360 = select i1 %t1359, i8* %t1358, i8* %t1357
  %t1361 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1362 = icmp eq i32 %t1320, 13
  %t1363 = select i1 %t1362, i8* %t1361, i8* %t1360
  %t1364 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1365 = icmp eq i32 %t1320, 14
  %t1366 = select i1 %t1365, i8* %t1364, i8* %t1363
  %t1367 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1368 = icmp eq i32 %t1320, 15
  %t1369 = select i1 %t1368, i8* %t1367, i8* %t1366
  %t1370 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1371 = icmp eq i32 %t1320, 16
  %t1372 = select i1 %t1371, i8* %t1370, i8* %t1369
  %t1373 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1374 = icmp eq i32 %t1320, 17
  %t1375 = select i1 %t1374, i8* %t1373, i8* %t1372
  %t1376 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1377 = icmp eq i32 %t1320, 18
  %t1378 = select i1 %t1377, i8* %t1376, i8* %t1375
  %t1379 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1380 = icmp eq i32 %t1320, 19
  %t1381 = select i1 %t1380, i8* %t1379, i8* %t1378
  %t1382 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1383 = icmp eq i32 %t1320, 20
  %t1384 = select i1 %t1383, i8* %t1382, i8* %t1381
  %t1385 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1386 = icmp eq i32 %t1320, 21
  %t1387 = select i1 %t1386, i8* %t1385, i8* %t1384
  %t1388 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1389 = icmp eq i32 %t1320, 22
  %t1390 = select i1 %t1389, i8* %t1388, i8* %t1387
  %s1391 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1391, i32 0, i32 0
  %t1392 = icmp eq i8* %t1390, %s1391
  br i1 %t1392, label %then18, label %merge19
then18:
  %t1393 = extractvalue %Statement %statement, 0
  %t1394 = alloca %Statement
  store %Statement %statement, %Statement* %t1394
  %t1395 = getelementptr inbounds %Statement, %Statement* %t1394, i32 0, i32 1
  %t1396 = bitcast [48 x i8]* %t1395 to i8*
  %t1397 = bitcast i8* %t1396 to i8**
  %t1398 = load i8*, i8** %t1397
  %t1399 = icmp eq i32 %t1393, 2
  %t1400 = select i1 %t1399, i8* %t1398, i8* null
  %t1401 = getelementptr inbounds %Statement, %Statement* %t1394, i32 0, i32 1
  %t1402 = bitcast [48 x i8]* %t1401 to i8*
  %t1403 = bitcast i8* %t1402 to i8**
  %t1404 = load i8*, i8** %t1403
  %t1405 = icmp eq i32 %t1393, 3
  %t1406 = select i1 %t1405, i8* %t1404, i8* %t1400
  %t1407 = getelementptr inbounds %Statement, %Statement* %t1394, i32 0, i32 1
  %t1408 = bitcast [40 x i8]* %t1407 to i8*
  %t1409 = bitcast i8* %t1408 to i8**
  %t1410 = load i8*, i8** %t1409
  %t1411 = icmp eq i32 %t1393, 6
  %t1412 = select i1 %t1411, i8* %t1410, i8* %t1406
  %t1413 = getelementptr inbounds %Statement, %Statement* %t1394, i32 0, i32 1
  %t1414 = bitcast [56 x i8]* %t1413 to i8*
  %t1415 = bitcast i8* %t1414 to i8**
  %t1416 = load i8*, i8** %t1415
  %t1417 = icmp eq i32 %t1393, 8
  %t1418 = select i1 %t1417, i8* %t1416, i8* %t1412
  %t1419 = getelementptr inbounds %Statement, %Statement* %t1394, i32 0, i32 1
  %t1420 = bitcast [40 x i8]* %t1419 to i8*
  %t1421 = bitcast i8* %t1420 to i8**
  %t1422 = load i8*, i8** %t1421
  %t1423 = icmp eq i32 %t1393, 9
  %t1424 = select i1 %t1423, i8* %t1422, i8* %t1418
  %t1425 = getelementptr inbounds %Statement, %Statement* %t1394, i32 0, i32 1
  %t1426 = bitcast [40 x i8]* %t1425 to i8*
  %t1427 = bitcast i8* %t1426 to i8**
  %t1428 = load i8*, i8** %t1427
  %t1429 = icmp eq i32 %t1393, 10
  %t1430 = select i1 %t1429, i8* %t1428, i8* %t1424
  %t1431 = getelementptr inbounds %Statement, %Statement* %t1394, i32 0, i32 1
  %t1432 = bitcast [40 x i8]* %t1431 to i8*
  %t1433 = bitcast i8* %t1432 to i8**
  %t1434 = load i8*, i8** %t1433
  %t1435 = icmp eq i32 %t1393, 11
  %t1436 = select i1 %t1435, i8* %t1434, i8* %t1430
  %s1437 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1437, i32 0, i32 0
  %t1438 = extractvalue %Statement %statement, 0
  %t1439 = alloca %Statement
  store %Statement %statement, %Statement* %t1439
  %t1440 = getelementptr inbounds %Statement, %Statement* %t1439, i32 0, i32 1
  %t1441 = bitcast [48 x i8]* %t1440 to i8*
  %t1442 = getelementptr inbounds i8, i8* %t1441, i64 32
  %t1443 = bitcast i8* %t1442 to i8**
  %t1444 = load i8*, i8** %t1443
  %t1445 = icmp eq i32 %t1438, 2
  %t1446 = select i1 %t1445, i8* %t1444, i8* null
  %t1447 = getelementptr inbounds %Statement, %Statement* %t1439, i32 0, i32 1
  %t1448 = bitcast [16 x i8]* %t1447 to i8*
  %t1449 = getelementptr inbounds i8, i8* %t1448, i64 8
  %t1450 = bitcast i8* %t1449 to i8**
  %t1451 = load i8*, i8** %t1450
  %t1452 = icmp eq i32 %t1438, 20
  %t1453 = select i1 %t1452, i8* %t1451, i8* %t1446
  %t1454 = getelementptr inbounds %Statement, %Statement* %t1439, i32 0, i32 1
  %t1455 = bitcast [16 x i8]* %t1454 to i8*
  %t1456 = getelementptr inbounds i8, i8* %t1455, i64 8
  %t1457 = bitcast i8* %t1456 to i8**
  %t1458 = load i8*, i8** %t1457
  %t1459 = icmp eq i32 %t1438, 21
  %t1460 = select i1 %t1459, i8* %t1458, i8* %t1453
  %t1461 = call %SymbolCollectionResult @register_symbol(i8* %t1436, i8* %s1437, i8* %t1460, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1461
merge19:
  %t1462 = bitcast { %SymbolEntry*, i64 }* %existing to { i8**, i64 }*
  %t1463 = insertvalue %SymbolCollectionResult undef, { i8**, i64 }* %t1462, 0
  %t1464 = alloca [0 x i8*]
  %t1465 = getelementptr [0 x i8*], [0 x i8*]* %t1464, i32 0, i32 0
  %t1466 = alloca { i8**, i64 }
  %t1467 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1466, i32 0, i32 0
  store i8** %t1465, i8*** %t1467
  %t1468 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1466, i32 0, i32 1
  store i64 0, i64* %t1468
  %t1469 = insertvalue %SymbolCollectionResult %t1463, { i8**, i64 }* %t1466, 1
  ret %SymbolCollectionResult %t1469
}

define { %Diagnostic*, i64 }* @check_program_scopes(%Program %program, { %Statement*, i64 }* %interfaces) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca i8*
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
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  %t12 = load i64, i64* %t11
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  %t14 = load i8**, i8*** %t13
  store i64 0, i64* %l2
  store i8* null, i8** %l3
  br label %for0
for0:
  %t15 = load i64, i64* %l2
  %t16 = icmp slt i64 %t15, %t12
  br i1 %t16, label %forbody1, label %afterfor3
forbody1:
  %t17 = load i64, i64* %l2
  %t18 = getelementptr i8*, i8** %t14, i64 %t17
  %t19 = load i8*, i8** %t18
  store i8* %t19, i8** %l3
  %t20 = load i8*, i8** %l3
  %t21 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t22 = call %ScopeResult @check_statement(%Statement zeroinitializer, { %SymbolEntry*, i64 }* %t21, { %Statement*, i64 }* %interfaces)
  store %ScopeResult %t22, %ScopeResult* %l4
  %t23 = load %ScopeResult, %ScopeResult* %l4
  %t24 = extractvalue %ScopeResult %t23, 0
  %t25 = bitcast { i8**, i64 }* %t24 to { %SymbolEntry*, i64 }*
  store { %SymbolEntry*, i64 }* %t25, { %SymbolEntry*, i64 }** %l0
  %t26 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t27 = load %ScopeResult, %ScopeResult* %l4
  %t28 = extractvalue %ScopeResult %t27, 1
  %t29 = bitcast { %Diagnostic*, i64 }* %t26 to { i8**, i64 }*
  %t30 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t29, { i8**, i64 }* %t28)
  %t31 = bitcast { i8**, i64 }* %t30 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t31, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t32 = load i64, i64* %l2
  %t33 = add i64 %t32, 1
  store i64 %t33, i64* %l2
  br label %for0
afterfor3:
  %t34 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t34
}

define %ScopeResult @check_statement(%Statement %statement, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca { %Diagnostic*, i64 }*
  %l3 = alloca %ScopeResult
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca %ScopeResult
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca %ScopeResult
  %l10 = alloca { i8**, i64 }*
  %l11 = alloca %ScopeResult
  %l12 = alloca { i8**, i64 }*
  %l13 = alloca double
  %l14 = alloca double
  %l15 = alloca double
  %l16 = alloca double
  %l17 = alloca %ScopeResult
  %l18 = alloca { i8**, i64 }*
  %l19 = alloca { %Diagnostic*, i64 }*
  %l20 = alloca double
  %l21 = alloca i8*
  %l22 = alloca { %Diagnostic*, i64 }*
  %l23 = alloca i8*
  %l24 = alloca %ScopeResult
  %l25 = alloca { i8**, i64 }*
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
  %t123 = bitcast i8* %t122 to i8**
  %t124 = load i8*, i8** %t123
  %t125 = icmp eq i32 %t118, 2
  %t126 = select i1 %t125, i8* %t124, i8* null
  %t127 = getelementptr inbounds %Statement, %Statement* %t119, i32 0, i32 1
  %t128 = bitcast [16 x i8]* %t127 to i8*
  %t129 = getelementptr inbounds i8, i8* %t128, i64 8
  %t130 = bitcast i8* %t129 to i8**
  %t131 = load i8*, i8** %t130
  %t132 = icmp eq i32 %t118, 20
  %t133 = select i1 %t132, i8* %t131, i8* %t126
  %t134 = getelementptr inbounds %Statement, %Statement* %t119, i32 0, i32 1
  %t135 = bitcast [16 x i8]* %t134 to i8*
  %t136 = getelementptr inbounds i8, i8* %t135, i64 8
  %t137 = bitcast i8* %t136 to i8**
  %t138 = load i8*, i8** %t137
  %t139 = icmp eq i32 %t118, 21
  %t140 = select i1 %t139, i8* %t138, i8* %t133
  %t141 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t116, i8* %s117, i8* %t140)
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
  %t219 = bitcast i8* %t218 to i8**
  %t220 = load i8*, i8** %t219
  %t221 = icmp eq i32 %t215, 4
  %t222 = select i1 %t221, i8* %t220, i8* null
  %t223 = getelementptr inbounds %Statement, %Statement* %t216, i32 0, i32 1
  %t224 = bitcast [24 x i8]* %t223 to i8*
  %t225 = bitcast i8* %t224 to i8**
  %t226 = load i8*, i8** %t225
  %t227 = icmp eq i32 %t215, 5
  %t228 = select i1 %t227, i8* %t226, i8* %t222
  %t229 = getelementptr inbounds %Statement, %Statement* %t216, i32 0, i32 1
  %t230 = bitcast [24 x i8]* %t229 to i8*
  %t231 = bitcast i8* %t230 to i8**
  %t232 = load i8*, i8** %t231
  %t233 = icmp eq i32 %t215, 7
  %t234 = select i1 %t233, i8* %t232, i8* %t228
  %s235 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.235, i32 0, i32 0
  %t236 = extractvalue %Statement %statement, 0
  %t237 = alloca %Statement
  store %Statement %statement, %Statement* %t237
  %t238 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t239 = bitcast [24 x i8]* %t238 to i8*
  %t240 = bitcast i8* %t239 to i8**
  %t241 = load i8*, i8** %t240
  %t242 = icmp eq i32 %t236, 4
  %t243 = select i1 %t242, i8* %t241, i8* null
  %t244 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t245 = bitcast [24 x i8]* %t244 to i8*
  %t246 = bitcast i8* %t245 to i8**
  %t247 = load i8*, i8** %t246
  %t248 = icmp eq i32 %t236, 5
  %t249 = select i1 %t248, i8* %t247, i8* %t243
  %t250 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t251 = bitcast [24 x i8]* %t250 to i8*
  %t252 = bitcast i8* %t251 to i8**
  %t253 = load i8*, i8** %t252
  %t254 = icmp eq i32 %t236, 7
  %t255 = select i1 %t254, i8* %t253, i8* %t249
  store double 0.0, double* %l0
  %t256 = load double, double* %l0
  store double 0.0, double* %l1
  %t257 = load double, double* %l1
  %t258 = extractvalue %Statement %statement, 0
  %t259 = alloca %Statement
  store %Statement %statement, %Statement* %t259
  %t260 = getelementptr inbounds %Statement, %Statement* %t259, i32 0, i32 1
  %t261 = bitcast [24 x i8]* %t260 to i8*
  %t262 = bitcast i8* %t261 to i8**
  %t263 = load i8*, i8** %t262
  %t264 = icmp eq i32 %t258, 4
  %t265 = select i1 %t264, i8* %t263, i8* null
  %t266 = getelementptr inbounds %Statement, %Statement* %t259, i32 0, i32 1
  %t267 = bitcast [24 x i8]* %t266 to i8*
  %t268 = bitcast i8* %t267 to i8**
  %t269 = load i8*, i8** %t268
  %t270 = icmp eq i32 %t258, 5
  %t271 = select i1 %t270, i8* %t269, i8* %t265
  %t272 = getelementptr inbounds %Statement, %Statement* %t259, i32 0, i32 1
  %t273 = bitcast [24 x i8]* %t272 to i8*
  %t274 = bitcast i8* %t273 to i8**
  %t275 = load i8*, i8** %t274
  %t276 = icmp eq i32 %t258, 7
  %t277 = select i1 %t276, i8* %t275, i8* %t271
  %t278 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature zeroinitializer)
  %t279 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t278)
  store double %t279, double* %l1
  %t280 = extractvalue %Statement %statement, 0
  %t281 = alloca %Statement
  store %Statement %statement, %Statement* %t281
  %t282 = getelementptr inbounds %Statement, %Statement* %t281, i32 0, i32 1
  %t283 = bitcast [24 x i8]* %t282 to i8*
  %t284 = bitcast i8* %t283 to i8**
  %t285 = load i8*, i8** %t284
  %t286 = icmp eq i32 %t280, 4
  %t287 = select i1 %t286, i8* %t285, i8* null
  %t288 = getelementptr inbounds %Statement, %Statement* %t281, i32 0, i32 1
  %t289 = bitcast [24 x i8]* %t288 to i8*
  %t290 = bitcast i8* %t289 to i8**
  %t291 = load i8*, i8** %t290
  %t292 = icmp eq i32 %t280, 5
  %t293 = select i1 %t292, i8* %t291, i8* %t287
  %t294 = getelementptr inbounds %Statement, %Statement* %t281, i32 0, i32 1
  %t295 = bitcast [24 x i8]* %t294 to i8*
  %t296 = bitcast i8* %t295 to i8**
  %t297 = load i8*, i8** %t296
  %t298 = icmp eq i32 %t280, 7
  %t299 = select i1 %t298, i8* %t297, i8* %t293
  %t300 = extractvalue %Statement %statement, 0
  %t301 = alloca %Statement
  store %Statement %statement, %Statement* %t301
  %t302 = getelementptr inbounds %Statement, %Statement* %t301, i32 0, i32 1
  %t303 = bitcast [24 x i8]* %t302 to i8*
  %t304 = getelementptr inbounds i8, i8* %t303, i64 8
  %t305 = bitcast i8* %t304 to i8**
  %t306 = load i8*, i8** %t305
  %t307 = icmp eq i32 %t300, 4
  %t308 = select i1 %t307, i8* %t306, i8* null
  %t309 = getelementptr inbounds %Statement, %Statement* %t301, i32 0, i32 1
  %t310 = bitcast [24 x i8]* %t309 to i8*
  %t311 = getelementptr inbounds i8, i8* %t310, i64 8
  %t312 = bitcast i8* %t311 to i8**
  %t313 = load i8*, i8** %t312
  %t314 = icmp eq i32 %t300, 5
  %t315 = select i1 %t314, i8* %t313, i8* %t308
  %t316 = getelementptr inbounds %Statement, %Statement* %t301, i32 0, i32 1
  %t317 = bitcast [40 x i8]* %t316 to i8*
  %t318 = getelementptr inbounds i8, i8* %t317, i64 16
  %t319 = bitcast i8* %t318 to i8**
  %t320 = load i8*, i8** %t319
  %t321 = icmp eq i32 %t300, 6
  %t322 = select i1 %t321, i8* %t320, i8* %t315
  %t323 = getelementptr inbounds %Statement, %Statement* %t301, i32 0, i32 1
  %t324 = bitcast [24 x i8]* %t323 to i8*
  %t325 = getelementptr inbounds i8, i8* %t324, i64 8
  %t326 = bitcast i8* %t325 to i8**
  %t327 = load i8*, i8** %t326
  %t328 = icmp eq i32 %t300, 7
  %t329 = select i1 %t328, i8* %t327, i8* %t322
  %t330 = getelementptr inbounds %Statement, %Statement* %t301, i32 0, i32 1
  %t331 = bitcast [40 x i8]* %t330 to i8*
  %t332 = getelementptr inbounds i8, i8* %t331, i64 24
  %t333 = bitcast i8* %t332 to i8**
  %t334 = load i8*, i8** %t333
  %t335 = icmp eq i32 %t300, 12
  %t336 = select i1 %t335, i8* %t334, i8* %t329
  %t337 = getelementptr inbounds %Statement, %Statement* %t301, i32 0, i32 1
  %t338 = bitcast [24 x i8]* %t337 to i8*
  %t339 = getelementptr inbounds i8, i8* %t338, i64 8
  %t340 = bitcast i8* %t339 to i8**
  %t341 = load i8*, i8** %t340
  %t342 = icmp eq i32 %t300, 13
  %t343 = select i1 %t342, i8* %t341, i8* %t336
  %t344 = getelementptr inbounds %Statement, %Statement* %t301, i32 0, i32 1
  %t345 = bitcast [24 x i8]* %t344 to i8*
  %t346 = getelementptr inbounds i8, i8* %t345, i64 8
  %t347 = bitcast i8* %t346 to i8**
  %t348 = load i8*, i8** %t347
  %t349 = icmp eq i32 %t300, 14
  %t350 = select i1 %t349, i8* %t348, i8* %t343
  %t351 = getelementptr inbounds %Statement, %Statement* %t301, i32 0, i32 1
  %t352 = bitcast [16 x i8]* %t351 to i8*
  %t353 = bitcast i8* %t352 to i8**
  %t354 = load i8*, i8** %t353
  %t355 = icmp eq i32 %t300, 15
  %t356 = select i1 %t355, i8* %t354, i8* %t350
  %t357 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature zeroinitializer, %Block zeroinitializer, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t357, { %Diagnostic*, i64 }** %l2
  %t358 = load double, double* %l0
  %t359 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t360 = load double, double* %l1
  %t361 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l2
  %t362 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t361)
  %t363 = insertvalue %ScopeResult %t359, { i8**, i64 }* null, 1
  ret %ScopeResult %t363
merge3:
  %t364 = extractvalue %Statement %statement, 0
  %t365 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t366 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t367 = icmp eq i32 %t364, 0
  %t368 = select i1 %t367, i8* %t366, i8* %t365
  %t369 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t370 = icmp eq i32 %t364, 1
  %t371 = select i1 %t370, i8* %t369, i8* %t368
  %t372 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t373 = icmp eq i32 %t364, 2
  %t374 = select i1 %t373, i8* %t372, i8* %t371
  %t375 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t376 = icmp eq i32 %t364, 3
  %t377 = select i1 %t376, i8* %t375, i8* %t374
  %t378 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t379 = icmp eq i32 %t364, 4
  %t380 = select i1 %t379, i8* %t378, i8* %t377
  %t381 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t382 = icmp eq i32 %t364, 5
  %t383 = select i1 %t382, i8* %t381, i8* %t380
  %t384 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t385 = icmp eq i32 %t364, 6
  %t386 = select i1 %t385, i8* %t384, i8* %t383
  %t387 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t388 = icmp eq i32 %t364, 7
  %t389 = select i1 %t388, i8* %t387, i8* %t386
  %t390 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t391 = icmp eq i32 %t364, 8
  %t392 = select i1 %t391, i8* %t390, i8* %t389
  %t393 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t394 = icmp eq i32 %t364, 9
  %t395 = select i1 %t394, i8* %t393, i8* %t392
  %t396 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t397 = icmp eq i32 %t364, 10
  %t398 = select i1 %t397, i8* %t396, i8* %t395
  %t399 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t400 = icmp eq i32 %t364, 11
  %t401 = select i1 %t400, i8* %t399, i8* %t398
  %t402 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t403 = icmp eq i32 %t364, 12
  %t404 = select i1 %t403, i8* %t402, i8* %t401
  %t405 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t406 = icmp eq i32 %t364, 13
  %t407 = select i1 %t406, i8* %t405, i8* %t404
  %t408 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t409 = icmp eq i32 %t364, 14
  %t410 = select i1 %t409, i8* %t408, i8* %t407
  %t411 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t412 = icmp eq i32 %t364, 15
  %t413 = select i1 %t412, i8* %t411, i8* %t410
  %t414 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t415 = icmp eq i32 %t364, 16
  %t416 = select i1 %t415, i8* %t414, i8* %t413
  %t417 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t418 = icmp eq i32 %t364, 17
  %t419 = select i1 %t418, i8* %t417, i8* %t416
  %t420 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t421 = icmp eq i32 %t364, 18
  %t422 = select i1 %t421, i8* %t420, i8* %t419
  %t423 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t424 = icmp eq i32 %t364, 19
  %t425 = select i1 %t424, i8* %t423, i8* %t422
  %t426 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t427 = icmp eq i32 %t364, 20
  %t428 = select i1 %t427, i8* %t426, i8* %t425
  %t429 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t430 = icmp eq i32 %t364, 21
  %t431 = select i1 %t430, i8* %t429, i8* %t428
  %t432 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t433 = icmp eq i32 %t364, 22
  %t434 = select i1 %t433, i8* %t432, i8* %t431
  %s435 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.435, i32 0, i32 0
  %t436 = icmp eq i8* %t434, %s435
  br i1 %t436, label %then4, label %merge5
then4:
  %t437 = extractvalue %Statement %statement, 0
  %t438 = alloca %Statement
  store %Statement %statement, %Statement* %t438
  %t439 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t440 = bitcast [48 x i8]* %t439 to i8*
  %t441 = bitcast i8* %t440 to i8**
  %t442 = load i8*, i8** %t441
  %t443 = icmp eq i32 %t437, 2
  %t444 = select i1 %t443, i8* %t442, i8* null
  %t445 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t446 = bitcast [48 x i8]* %t445 to i8*
  %t447 = bitcast i8* %t446 to i8**
  %t448 = load i8*, i8** %t447
  %t449 = icmp eq i32 %t437, 3
  %t450 = select i1 %t449, i8* %t448, i8* %t444
  %t451 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t452 = bitcast [40 x i8]* %t451 to i8*
  %t453 = bitcast i8* %t452 to i8**
  %t454 = load i8*, i8** %t453
  %t455 = icmp eq i32 %t437, 6
  %t456 = select i1 %t455, i8* %t454, i8* %t450
  %t457 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t458 = bitcast [56 x i8]* %t457 to i8*
  %t459 = bitcast i8* %t458 to i8**
  %t460 = load i8*, i8** %t459
  %t461 = icmp eq i32 %t437, 8
  %t462 = select i1 %t461, i8* %t460, i8* %t456
  %t463 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t464 = bitcast [40 x i8]* %t463 to i8*
  %t465 = bitcast i8* %t464 to i8**
  %t466 = load i8*, i8** %t465
  %t467 = icmp eq i32 %t437, 9
  %t468 = select i1 %t467, i8* %t466, i8* %t462
  %t469 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t470 = bitcast [40 x i8]* %t469 to i8*
  %t471 = bitcast i8* %t470 to i8**
  %t472 = load i8*, i8** %t471
  %t473 = icmp eq i32 %t437, 10
  %t474 = select i1 %t473, i8* %t472, i8* %t468
  %t475 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t476 = bitcast [40 x i8]* %t475 to i8*
  %t477 = bitcast i8* %t476 to i8**
  %t478 = load i8*, i8** %t477
  %t479 = icmp eq i32 %t437, 11
  %t480 = select i1 %t479, i8* %t478, i8* %t474
  %s481 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.481, i32 0, i32 0
  %t482 = extractvalue %Statement %statement, 0
  %t483 = alloca %Statement
  store %Statement %statement, %Statement* %t483
  %t484 = getelementptr inbounds %Statement, %Statement* %t483, i32 0, i32 1
  %t485 = bitcast [48 x i8]* %t484 to i8*
  %t486 = getelementptr inbounds i8, i8* %t485, i64 8
  %t487 = bitcast i8* %t486 to i8**
  %t488 = load i8*, i8** %t487
  %t489 = icmp eq i32 %t482, 3
  %t490 = select i1 %t489, i8* %t488, i8* null
  %t491 = getelementptr inbounds %Statement, %Statement* %t483, i32 0, i32 1
  %t492 = bitcast [40 x i8]* %t491 to i8*
  %t493 = getelementptr inbounds i8, i8* %t492, i64 8
  %t494 = bitcast i8* %t493 to i8**
  %t495 = load i8*, i8** %t494
  %t496 = icmp eq i32 %t482, 6
  %t497 = select i1 %t496, i8* %t495, i8* %t490
  %t498 = getelementptr inbounds %Statement, %Statement* %t483, i32 0, i32 1
  %t499 = bitcast [56 x i8]* %t498 to i8*
  %t500 = getelementptr inbounds i8, i8* %t499, i64 8
  %t501 = bitcast i8* %t500 to i8**
  %t502 = load i8*, i8** %t501
  %t503 = icmp eq i32 %t482, 8
  %t504 = select i1 %t503, i8* %t502, i8* %t497
  %t505 = getelementptr inbounds %Statement, %Statement* %t483, i32 0, i32 1
  %t506 = bitcast [40 x i8]* %t505 to i8*
  %t507 = getelementptr inbounds i8, i8* %t506, i64 8
  %t508 = bitcast i8* %t507 to i8**
  %t509 = load i8*, i8** %t508
  %t510 = icmp eq i32 %t482, 9
  %t511 = select i1 %t510, i8* %t509, i8* %t504
  %t512 = getelementptr inbounds %Statement, %Statement* %t483, i32 0, i32 1
  %t513 = bitcast [40 x i8]* %t512 to i8*
  %t514 = getelementptr inbounds i8, i8* %t513, i64 8
  %t515 = bitcast i8* %t514 to i8**
  %t516 = load i8*, i8** %t515
  %t517 = icmp eq i32 %t482, 10
  %t518 = select i1 %t517, i8* %t516, i8* %t511
  %t519 = getelementptr inbounds %Statement, %Statement* %t483, i32 0, i32 1
  %t520 = bitcast [40 x i8]* %t519 to i8*
  %t521 = getelementptr inbounds i8, i8* %t520, i64 8
  %t522 = bitcast i8* %t521 to i8**
  %t523 = load i8*, i8** %t522
  %t524 = icmp eq i32 %t482, 11
  %t525 = select i1 %t524, i8* %t523, i8* %t518
  %t526 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t480, i8* %s481, i8* %t525)
  store %ScopeResult %t526, %ScopeResult* %l3
  %t527 = load %ScopeResult, %ScopeResult* %l3
  %t528 = extractvalue %ScopeResult %t527, 1
  store { i8**, i64 }* %t528, { i8**, i64 }** %l4
  %t529 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t530 = extractvalue %Statement %statement, 0
  %t531 = alloca %Statement
  store %Statement %statement, %Statement* %t531
  %t532 = getelementptr inbounds %Statement, %Statement* %t531, i32 0, i32 1
  %t533 = bitcast [56 x i8]* %t532 to i8*
  %t534 = getelementptr inbounds i8, i8* %t533, i64 16
  %t535 = bitcast i8* %t534 to { i8**, i64 }**
  %t536 = load { i8**, i64 }*, { i8**, i64 }** %t535
  %t537 = icmp eq i32 %t530, 8
  %t538 = select i1 %t537, { i8**, i64 }* %t536, { i8**, i64 }* null
  %t539 = getelementptr inbounds %Statement, %Statement* %t531, i32 0, i32 1
  %t540 = bitcast [40 x i8]* %t539 to i8*
  %t541 = getelementptr inbounds i8, i8* %t540, i64 16
  %t542 = bitcast i8* %t541 to { i8**, i64 }**
  %t543 = load { i8**, i64 }*, { i8**, i64 }** %t542
  %t544 = icmp eq i32 %t530, 9
  %t545 = select i1 %t544, { i8**, i64 }* %t543, { i8**, i64 }* %t538
  %t546 = getelementptr inbounds %Statement, %Statement* %t531, i32 0, i32 1
  %t547 = bitcast [40 x i8]* %t546 to i8*
  %t548 = getelementptr inbounds i8, i8* %t547, i64 16
  %t549 = bitcast i8* %t548 to { i8**, i64 }**
  %t550 = load { i8**, i64 }*, { i8**, i64 }** %t549
  %t551 = icmp eq i32 %t530, 10
  %t552 = select i1 %t551, { i8**, i64 }* %t550, { i8**, i64 }* %t545
  %t553 = getelementptr inbounds %Statement, %Statement* %t531, i32 0, i32 1
  %t554 = bitcast [40 x i8]* %t553 to i8*
  %t555 = getelementptr inbounds i8, i8* %t554, i64 16
  %t556 = bitcast i8* %t555 to { i8**, i64 }**
  %t557 = load { i8**, i64 }*, { i8**, i64 }** %t556
  %t558 = icmp eq i32 %t530, 11
  %t559 = select i1 %t558, { i8**, i64 }* %t557, { i8**, i64 }* %t552
  %t560 = bitcast { i8**, i64 }* %t559 to { %TypeParameter*, i64 }*
  %t561 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t560)
  %t562 = bitcast { %Diagnostic*, i64 }* %t561 to { i8**, i64 }*
  %t563 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t529, { i8**, i64 }* %t562)
  store { i8**, i64 }* %t563, { i8**, i64 }** %l4
  %t564 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t565 = extractvalue %Statement %statement, 0
  %t566 = alloca %Statement
  store %Statement %statement, %Statement* %t566
  %t567 = getelementptr inbounds %Statement, %Statement* %t566, i32 0, i32 1
  %t568 = bitcast [56 x i8]* %t567 to i8*
  %t569 = getelementptr inbounds i8, i8* %t568, i64 32
  %t570 = bitcast i8* %t569 to { i8**, i64 }**
  %t571 = load { i8**, i64 }*, { i8**, i64 }** %t570
  %t572 = icmp eq i32 %t565, 8
  %t573 = select i1 %t572, { i8**, i64 }* %t571, { i8**, i64 }* null
  %t574 = bitcast { i8**, i64 }* %t573 to { %FieldDeclaration*, i64 }*
  %t575 = call { %Diagnostic*, i64 }* @check_struct_fields({ %FieldDeclaration*, i64 }* %t574)
  %t576 = bitcast { %Diagnostic*, i64 }* %t575 to { i8**, i64 }*
  %t577 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t564, { i8**, i64 }* %t576)
  store { i8**, i64 }* %t577, { i8**, i64 }** %l4
  %t578 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t579 = extractvalue %Statement %statement, 0
  %t580 = alloca %Statement
  store %Statement %statement, %Statement* %t580
  %t581 = getelementptr inbounds %Statement, %Statement* %t580, i32 0, i32 1
  %t582 = bitcast [56 x i8]* %t581 to i8*
  %t583 = getelementptr inbounds i8, i8* %t582, i64 40
  %t584 = bitcast i8* %t583 to { i8**, i64 }**
  %t585 = load { i8**, i64 }*, { i8**, i64 }** %t584
  %t586 = icmp eq i32 %t579, 8
  %t587 = select i1 %t586, { i8**, i64 }* %t585, { i8**, i64 }* null
  %t588 = bitcast { i8**, i64 }* %t587 to { %MethodDeclaration*, i64 }*
  %t589 = call { %Diagnostic*, i64 }* @check_struct_methods({ %MethodDeclaration*, i64 }* %t588)
  %t590 = bitcast { %Diagnostic*, i64 }* %t589 to { i8**, i64 }*
  %t591 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t578, { i8**, i64 }* %t590)
  store { i8**, i64 }* %t591, { i8**, i64 }** %l4
  %t592 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t593 = call { %Diagnostic*, i64 }* @check_struct_implements_interfaces(%Statement %statement, { %Statement*, i64 }* %interfaces)
  %t594 = bitcast { %Diagnostic*, i64 }* %t593 to { i8**, i64 }*
  %t595 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t592, { i8**, i64 }* %t594)
  store { i8**, i64 }* %t595, { i8**, i64 }** %l4
  %t596 = sitofp i64 0 to double
  store double %t596, double* %l5
  %t597 = load %ScopeResult, %ScopeResult* %l3
  %t598 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t599 = load double, double* %l5
  br label %loop.header6
loop.header6:
  %t642 = phi { i8**, i64 }* [ %t598, %then4 ], [ %t640, %loop.latch8 ]
  %t643 = phi double [ %t599, %then4 ], [ %t641, %loop.latch8 ]
  store { i8**, i64 }* %t642, { i8**, i64 }** %l4
  store double %t643, double* %l5
  br label %loop.body7
loop.body7:
  %t600 = load double, double* %l5
  %t601 = extractvalue %Statement %statement, 0
  %t602 = alloca %Statement
  store %Statement %statement, %Statement* %t602
  %t603 = getelementptr inbounds %Statement, %Statement* %t602, i32 0, i32 1
  %t604 = bitcast [56 x i8]* %t603 to i8*
  %t605 = getelementptr inbounds i8, i8* %t604, i64 40
  %t606 = bitcast i8* %t605 to { i8**, i64 }**
  %t607 = load { i8**, i64 }*, { i8**, i64 }** %t606
  %t608 = icmp eq i32 %t601, 8
  %t609 = select i1 %t608, { i8**, i64 }* %t607, { i8**, i64 }* null
  %t610 = load { i8**, i64 }, { i8**, i64 }* %t609
  %t611 = extractvalue { i8**, i64 } %t610, 1
  %t612 = sitofp i64 %t611 to double
  %t613 = fcmp oge double %t600, %t612
  %t614 = load %ScopeResult, %ScopeResult* %l3
  %t615 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t616 = load double, double* %l5
  br i1 %t613, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t617 = extractvalue %Statement %statement, 0
  %t618 = alloca %Statement
  store %Statement %statement, %Statement* %t618
  %t619 = getelementptr inbounds %Statement, %Statement* %t618, i32 0, i32 1
  %t620 = bitcast [56 x i8]* %t619 to i8*
  %t621 = getelementptr inbounds i8, i8* %t620, i64 40
  %t622 = bitcast i8* %t621 to { i8**, i64 }**
  %t623 = load { i8**, i64 }*, { i8**, i64 }** %t622
  %t624 = icmp eq i32 %t617, 8
  %t625 = select i1 %t624, { i8**, i64 }* %t623, { i8**, i64 }* null
  %t626 = load double, double* %l5
  %t627 = fptosi double %t626 to i64
  %t628 = load { i8**, i64 }, { i8**, i64 }* %t625
  %t629 = extractvalue { i8**, i64 } %t628, 0
  %t630 = extractvalue { i8**, i64 } %t628, 1
  %t631 = icmp uge i64 %t627, %t630
  ; bounds check: %t631 (if true, out of bounds)
  %t632 = getelementptr i8*, i8** %t629, i64 %t627
  %t633 = load i8*, i8** %t632
  store i8* %t633, i8** %l6
  %t634 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t635 = load i8*, i8** %l6
  %t636 = load i8*, i8** %l6
  %t637 = load double, double* %l5
  %t638 = sitofp i64 1 to double
  %t639 = fadd double %t637, %t638
  store double %t639, double* %l5
  br label %loop.latch8
loop.latch8:
  %t640 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t641 = load double, double* %l5
  br label %loop.header6
afterloop9:
  %t644 = load %ScopeResult, %ScopeResult* %l3
  %t645 = extractvalue %ScopeResult %t644, 0
  %t646 = insertvalue %ScopeResult undef, { i8**, i64 }* %t645, 0
  %t647 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t648 = insertvalue %ScopeResult %t646, { i8**, i64 }* %t647, 1
  ret %ScopeResult %t648
merge5:
  %t649 = extractvalue %Statement %statement, 0
  %t650 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t651 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t652 = icmp eq i32 %t649, 0
  %t653 = select i1 %t652, i8* %t651, i8* %t650
  %t654 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t655 = icmp eq i32 %t649, 1
  %t656 = select i1 %t655, i8* %t654, i8* %t653
  %t657 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t658 = icmp eq i32 %t649, 2
  %t659 = select i1 %t658, i8* %t657, i8* %t656
  %t660 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t661 = icmp eq i32 %t649, 3
  %t662 = select i1 %t661, i8* %t660, i8* %t659
  %t663 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t664 = icmp eq i32 %t649, 4
  %t665 = select i1 %t664, i8* %t663, i8* %t662
  %t666 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t667 = icmp eq i32 %t649, 5
  %t668 = select i1 %t667, i8* %t666, i8* %t665
  %t669 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t670 = icmp eq i32 %t649, 6
  %t671 = select i1 %t670, i8* %t669, i8* %t668
  %t672 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t673 = icmp eq i32 %t649, 7
  %t674 = select i1 %t673, i8* %t672, i8* %t671
  %t675 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t676 = icmp eq i32 %t649, 8
  %t677 = select i1 %t676, i8* %t675, i8* %t674
  %t678 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t679 = icmp eq i32 %t649, 9
  %t680 = select i1 %t679, i8* %t678, i8* %t677
  %t681 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t682 = icmp eq i32 %t649, 10
  %t683 = select i1 %t682, i8* %t681, i8* %t680
  %t684 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t685 = icmp eq i32 %t649, 11
  %t686 = select i1 %t685, i8* %t684, i8* %t683
  %t687 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t688 = icmp eq i32 %t649, 12
  %t689 = select i1 %t688, i8* %t687, i8* %t686
  %t690 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t691 = icmp eq i32 %t649, 13
  %t692 = select i1 %t691, i8* %t690, i8* %t689
  %t693 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t694 = icmp eq i32 %t649, 14
  %t695 = select i1 %t694, i8* %t693, i8* %t692
  %t696 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t697 = icmp eq i32 %t649, 15
  %t698 = select i1 %t697, i8* %t696, i8* %t695
  %t699 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t700 = icmp eq i32 %t649, 16
  %t701 = select i1 %t700, i8* %t699, i8* %t698
  %t702 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t703 = icmp eq i32 %t649, 17
  %t704 = select i1 %t703, i8* %t702, i8* %t701
  %t705 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t706 = icmp eq i32 %t649, 18
  %t707 = select i1 %t706, i8* %t705, i8* %t704
  %t708 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t709 = icmp eq i32 %t649, 19
  %t710 = select i1 %t709, i8* %t708, i8* %t707
  %t711 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t712 = icmp eq i32 %t649, 20
  %t713 = select i1 %t712, i8* %t711, i8* %t710
  %t714 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t715 = icmp eq i32 %t649, 21
  %t716 = select i1 %t715, i8* %t714, i8* %t713
  %t717 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t718 = icmp eq i32 %t649, 22
  %t719 = select i1 %t718, i8* %t717, i8* %t716
  %s720 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.720, i32 0, i32 0
  %t721 = icmp eq i8* %t719, %s720
  br i1 %t721, label %then12, label %merge13
then12:
  %t722 = extractvalue %Statement %statement, 0
  %t723 = alloca %Statement
  store %Statement %statement, %Statement* %t723
  %t724 = getelementptr inbounds %Statement, %Statement* %t723, i32 0, i32 1
  %t725 = bitcast [48 x i8]* %t724 to i8*
  %t726 = bitcast i8* %t725 to i8**
  %t727 = load i8*, i8** %t726
  %t728 = icmp eq i32 %t722, 2
  %t729 = select i1 %t728, i8* %t727, i8* null
  %t730 = getelementptr inbounds %Statement, %Statement* %t723, i32 0, i32 1
  %t731 = bitcast [48 x i8]* %t730 to i8*
  %t732 = bitcast i8* %t731 to i8**
  %t733 = load i8*, i8** %t732
  %t734 = icmp eq i32 %t722, 3
  %t735 = select i1 %t734, i8* %t733, i8* %t729
  %t736 = getelementptr inbounds %Statement, %Statement* %t723, i32 0, i32 1
  %t737 = bitcast [40 x i8]* %t736 to i8*
  %t738 = bitcast i8* %t737 to i8**
  %t739 = load i8*, i8** %t738
  %t740 = icmp eq i32 %t722, 6
  %t741 = select i1 %t740, i8* %t739, i8* %t735
  %t742 = getelementptr inbounds %Statement, %Statement* %t723, i32 0, i32 1
  %t743 = bitcast [56 x i8]* %t742 to i8*
  %t744 = bitcast i8* %t743 to i8**
  %t745 = load i8*, i8** %t744
  %t746 = icmp eq i32 %t722, 8
  %t747 = select i1 %t746, i8* %t745, i8* %t741
  %t748 = getelementptr inbounds %Statement, %Statement* %t723, i32 0, i32 1
  %t749 = bitcast [40 x i8]* %t748 to i8*
  %t750 = bitcast i8* %t749 to i8**
  %t751 = load i8*, i8** %t750
  %t752 = icmp eq i32 %t722, 9
  %t753 = select i1 %t752, i8* %t751, i8* %t747
  %t754 = getelementptr inbounds %Statement, %Statement* %t723, i32 0, i32 1
  %t755 = bitcast [40 x i8]* %t754 to i8*
  %t756 = bitcast i8* %t755 to i8**
  %t757 = load i8*, i8** %t756
  %t758 = icmp eq i32 %t722, 10
  %t759 = select i1 %t758, i8* %t757, i8* %t753
  %t760 = getelementptr inbounds %Statement, %Statement* %t723, i32 0, i32 1
  %t761 = bitcast [40 x i8]* %t760 to i8*
  %t762 = bitcast i8* %t761 to i8**
  %t763 = load i8*, i8** %t762
  %t764 = icmp eq i32 %t722, 11
  %t765 = select i1 %t764, i8* %t763, i8* %t759
  %s766 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.766, i32 0, i32 0
  %t767 = extractvalue %Statement %statement, 0
  %t768 = alloca %Statement
  store %Statement %statement, %Statement* %t768
  %t769 = getelementptr inbounds %Statement, %Statement* %t768, i32 0, i32 1
  %t770 = bitcast [48 x i8]* %t769 to i8*
  %t771 = getelementptr inbounds i8, i8* %t770, i64 8
  %t772 = bitcast i8* %t771 to i8**
  %t773 = load i8*, i8** %t772
  %t774 = icmp eq i32 %t767, 3
  %t775 = select i1 %t774, i8* %t773, i8* null
  %t776 = getelementptr inbounds %Statement, %Statement* %t768, i32 0, i32 1
  %t777 = bitcast [40 x i8]* %t776 to i8*
  %t778 = getelementptr inbounds i8, i8* %t777, i64 8
  %t779 = bitcast i8* %t778 to i8**
  %t780 = load i8*, i8** %t779
  %t781 = icmp eq i32 %t767, 6
  %t782 = select i1 %t781, i8* %t780, i8* %t775
  %t783 = getelementptr inbounds %Statement, %Statement* %t768, i32 0, i32 1
  %t784 = bitcast [56 x i8]* %t783 to i8*
  %t785 = getelementptr inbounds i8, i8* %t784, i64 8
  %t786 = bitcast i8* %t785 to i8**
  %t787 = load i8*, i8** %t786
  %t788 = icmp eq i32 %t767, 8
  %t789 = select i1 %t788, i8* %t787, i8* %t782
  %t790 = getelementptr inbounds %Statement, %Statement* %t768, i32 0, i32 1
  %t791 = bitcast [40 x i8]* %t790 to i8*
  %t792 = getelementptr inbounds i8, i8* %t791, i64 8
  %t793 = bitcast i8* %t792 to i8**
  %t794 = load i8*, i8** %t793
  %t795 = icmp eq i32 %t767, 9
  %t796 = select i1 %t795, i8* %t794, i8* %t789
  %t797 = getelementptr inbounds %Statement, %Statement* %t768, i32 0, i32 1
  %t798 = bitcast [40 x i8]* %t797 to i8*
  %t799 = getelementptr inbounds i8, i8* %t798, i64 8
  %t800 = bitcast i8* %t799 to i8**
  %t801 = load i8*, i8** %t800
  %t802 = icmp eq i32 %t767, 10
  %t803 = select i1 %t802, i8* %t801, i8* %t796
  %t804 = getelementptr inbounds %Statement, %Statement* %t768, i32 0, i32 1
  %t805 = bitcast [40 x i8]* %t804 to i8*
  %t806 = getelementptr inbounds i8, i8* %t805, i64 8
  %t807 = bitcast i8* %t806 to i8**
  %t808 = load i8*, i8** %t807
  %t809 = icmp eq i32 %t767, 11
  %t810 = select i1 %t809, i8* %t808, i8* %t803
  %t811 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t765, i8* %s766, i8* %t810)
  store %ScopeResult %t811, %ScopeResult* %l7
  %t812 = load %ScopeResult, %ScopeResult* %l7
  %t813 = extractvalue %ScopeResult %t812, 1
  store { i8**, i64 }* %t813, { i8**, i64 }** %l8
  %t814 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t815 = extractvalue %Statement %statement, 0
  %t816 = alloca %Statement
  store %Statement %statement, %Statement* %t816
  %t817 = getelementptr inbounds %Statement, %Statement* %t816, i32 0, i32 1
  %t818 = bitcast [56 x i8]* %t817 to i8*
  %t819 = getelementptr inbounds i8, i8* %t818, i64 16
  %t820 = bitcast i8* %t819 to { i8**, i64 }**
  %t821 = load { i8**, i64 }*, { i8**, i64 }** %t820
  %t822 = icmp eq i32 %t815, 8
  %t823 = select i1 %t822, { i8**, i64 }* %t821, { i8**, i64 }* null
  %t824 = getelementptr inbounds %Statement, %Statement* %t816, i32 0, i32 1
  %t825 = bitcast [40 x i8]* %t824 to i8*
  %t826 = getelementptr inbounds i8, i8* %t825, i64 16
  %t827 = bitcast i8* %t826 to { i8**, i64 }**
  %t828 = load { i8**, i64 }*, { i8**, i64 }** %t827
  %t829 = icmp eq i32 %t815, 9
  %t830 = select i1 %t829, { i8**, i64 }* %t828, { i8**, i64 }* %t823
  %t831 = getelementptr inbounds %Statement, %Statement* %t816, i32 0, i32 1
  %t832 = bitcast [40 x i8]* %t831 to i8*
  %t833 = getelementptr inbounds i8, i8* %t832, i64 16
  %t834 = bitcast i8* %t833 to { i8**, i64 }**
  %t835 = load { i8**, i64 }*, { i8**, i64 }** %t834
  %t836 = icmp eq i32 %t815, 10
  %t837 = select i1 %t836, { i8**, i64 }* %t835, { i8**, i64 }* %t830
  %t838 = getelementptr inbounds %Statement, %Statement* %t816, i32 0, i32 1
  %t839 = bitcast [40 x i8]* %t838 to i8*
  %t840 = getelementptr inbounds i8, i8* %t839, i64 16
  %t841 = bitcast i8* %t840 to { i8**, i64 }**
  %t842 = load { i8**, i64 }*, { i8**, i64 }** %t841
  %t843 = icmp eq i32 %t815, 11
  %t844 = select i1 %t843, { i8**, i64 }* %t842, { i8**, i64 }* %t837
  %t845 = bitcast { i8**, i64 }* %t844 to { %TypeParameter*, i64 }*
  %t846 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t845)
  %t847 = bitcast { %Diagnostic*, i64 }* %t846 to { i8**, i64 }*
  %t848 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t814, { i8**, i64 }* %t847)
  store { i8**, i64 }* %t848, { i8**, i64 }** %l8
  %t849 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t850 = extractvalue %Statement %statement, 0
  %t851 = alloca %Statement
  store %Statement %statement, %Statement* %t851
  %t852 = getelementptr inbounds %Statement, %Statement* %t851, i32 0, i32 1
  %t853 = bitcast [40 x i8]* %t852 to i8*
  %t854 = getelementptr inbounds i8, i8* %t853, i64 24
  %t855 = bitcast i8* %t854 to { i8**, i64 }**
  %t856 = load { i8**, i64 }*, { i8**, i64 }** %t855
  %t857 = icmp eq i32 %t850, 11
  %t858 = select i1 %t857, { i8**, i64 }* %t856, { i8**, i64 }* null
  %t859 = bitcast { i8**, i64 }* %t858 to { %EnumVariant*, i64 }*
  %t860 = call { %Diagnostic*, i64 }* @check_enum_variants({ %EnumVariant*, i64 }* %t859)
  %t861 = bitcast { %Diagnostic*, i64 }* %t860 to { i8**, i64 }*
  %t862 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t849, { i8**, i64 }* %t861)
  store { i8**, i64 }* %t862, { i8**, i64 }** %l8
  %t863 = load %ScopeResult, %ScopeResult* %l7
  %t864 = extractvalue %ScopeResult %t863, 0
  %t865 = insertvalue %ScopeResult undef, { i8**, i64 }* %t864, 0
  %t866 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t867 = insertvalue %ScopeResult %t865, { i8**, i64 }* %t866, 1
  ret %ScopeResult %t867
merge13:
  %t868 = extractvalue %Statement %statement, 0
  %t869 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t870 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t871 = icmp eq i32 %t868, 0
  %t872 = select i1 %t871, i8* %t870, i8* %t869
  %t873 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t874 = icmp eq i32 %t868, 1
  %t875 = select i1 %t874, i8* %t873, i8* %t872
  %t876 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t877 = icmp eq i32 %t868, 2
  %t878 = select i1 %t877, i8* %t876, i8* %t875
  %t879 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t880 = icmp eq i32 %t868, 3
  %t881 = select i1 %t880, i8* %t879, i8* %t878
  %t882 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t883 = icmp eq i32 %t868, 4
  %t884 = select i1 %t883, i8* %t882, i8* %t881
  %t885 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t886 = icmp eq i32 %t868, 5
  %t887 = select i1 %t886, i8* %t885, i8* %t884
  %t888 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t889 = icmp eq i32 %t868, 6
  %t890 = select i1 %t889, i8* %t888, i8* %t887
  %t891 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t892 = icmp eq i32 %t868, 7
  %t893 = select i1 %t892, i8* %t891, i8* %t890
  %t894 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t895 = icmp eq i32 %t868, 8
  %t896 = select i1 %t895, i8* %t894, i8* %t893
  %t897 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t898 = icmp eq i32 %t868, 9
  %t899 = select i1 %t898, i8* %t897, i8* %t896
  %t900 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t901 = icmp eq i32 %t868, 10
  %t902 = select i1 %t901, i8* %t900, i8* %t899
  %t903 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t904 = icmp eq i32 %t868, 11
  %t905 = select i1 %t904, i8* %t903, i8* %t902
  %t906 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t907 = icmp eq i32 %t868, 12
  %t908 = select i1 %t907, i8* %t906, i8* %t905
  %t909 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t910 = icmp eq i32 %t868, 13
  %t911 = select i1 %t910, i8* %t909, i8* %t908
  %t912 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t913 = icmp eq i32 %t868, 14
  %t914 = select i1 %t913, i8* %t912, i8* %t911
  %t915 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t916 = icmp eq i32 %t868, 15
  %t917 = select i1 %t916, i8* %t915, i8* %t914
  %t918 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t919 = icmp eq i32 %t868, 16
  %t920 = select i1 %t919, i8* %t918, i8* %t917
  %t921 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t922 = icmp eq i32 %t868, 17
  %t923 = select i1 %t922, i8* %t921, i8* %t920
  %t924 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t925 = icmp eq i32 %t868, 18
  %t926 = select i1 %t925, i8* %t924, i8* %t923
  %t927 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t928 = icmp eq i32 %t868, 19
  %t929 = select i1 %t928, i8* %t927, i8* %t926
  %t930 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t931 = icmp eq i32 %t868, 20
  %t932 = select i1 %t931, i8* %t930, i8* %t929
  %t933 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t934 = icmp eq i32 %t868, 21
  %t935 = select i1 %t934, i8* %t933, i8* %t932
  %t936 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t937 = icmp eq i32 %t868, 22
  %t938 = select i1 %t937, i8* %t936, i8* %t935
  %s939 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.939, i32 0, i32 0
  %t940 = icmp eq i8* %t938, %s939
  br i1 %t940, label %then14, label %merge15
then14:
  %t941 = extractvalue %Statement %statement, 0
  %t942 = alloca %Statement
  store %Statement %statement, %Statement* %t942
  %t943 = getelementptr inbounds %Statement, %Statement* %t942, i32 0, i32 1
  %t944 = bitcast [48 x i8]* %t943 to i8*
  %t945 = bitcast i8* %t944 to i8**
  %t946 = load i8*, i8** %t945
  %t947 = icmp eq i32 %t941, 2
  %t948 = select i1 %t947, i8* %t946, i8* null
  %t949 = getelementptr inbounds %Statement, %Statement* %t942, i32 0, i32 1
  %t950 = bitcast [48 x i8]* %t949 to i8*
  %t951 = bitcast i8* %t950 to i8**
  %t952 = load i8*, i8** %t951
  %t953 = icmp eq i32 %t941, 3
  %t954 = select i1 %t953, i8* %t952, i8* %t948
  %t955 = getelementptr inbounds %Statement, %Statement* %t942, i32 0, i32 1
  %t956 = bitcast [40 x i8]* %t955 to i8*
  %t957 = bitcast i8* %t956 to i8**
  %t958 = load i8*, i8** %t957
  %t959 = icmp eq i32 %t941, 6
  %t960 = select i1 %t959, i8* %t958, i8* %t954
  %t961 = getelementptr inbounds %Statement, %Statement* %t942, i32 0, i32 1
  %t962 = bitcast [56 x i8]* %t961 to i8*
  %t963 = bitcast i8* %t962 to i8**
  %t964 = load i8*, i8** %t963
  %t965 = icmp eq i32 %t941, 8
  %t966 = select i1 %t965, i8* %t964, i8* %t960
  %t967 = getelementptr inbounds %Statement, %Statement* %t942, i32 0, i32 1
  %t968 = bitcast [40 x i8]* %t967 to i8*
  %t969 = bitcast i8* %t968 to i8**
  %t970 = load i8*, i8** %t969
  %t971 = icmp eq i32 %t941, 9
  %t972 = select i1 %t971, i8* %t970, i8* %t966
  %t973 = getelementptr inbounds %Statement, %Statement* %t942, i32 0, i32 1
  %t974 = bitcast [40 x i8]* %t973 to i8*
  %t975 = bitcast i8* %t974 to i8**
  %t976 = load i8*, i8** %t975
  %t977 = icmp eq i32 %t941, 10
  %t978 = select i1 %t977, i8* %t976, i8* %t972
  %t979 = getelementptr inbounds %Statement, %Statement* %t942, i32 0, i32 1
  %t980 = bitcast [40 x i8]* %t979 to i8*
  %t981 = bitcast i8* %t980 to i8**
  %t982 = load i8*, i8** %t981
  %t983 = icmp eq i32 %t941, 11
  %t984 = select i1 %t983, i8* %t982, i8* %t978
  %s985 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.985, i32 0, i32 0
  %t986 = extractvalue %Statement %statement, 0
  %t987 = alloca %Statement
  store %Statement %statement, %Statement* %t987
  %t988 = getelementptr inbounds %Statement, %Statement* %t987, i32 0, i32 1
  %t989 = bitcast [48 x i8]* %t988 to i8*
  %t990 = getelementptr inbounds i8, i8* %t989, i64 8
  %t991 = bitcast i8* %t990 to i8**
  %t992 = load i8*, i8** %t991
  %t993 = icmp eq i32 %t986, 3
  %t994 = select i1 %t993, i8* %t992, i8* null
  %t995 = getelementptr inbounds %Statement, %Statement* %t987, i32 0, i32 1
  %t996 = bitcast [40 x i8]* %t995 to i8*
  %t997 = getelementptr inbounds i8, i8* %t996, i64 8
  %t998 = bitcast i8* %t997 to i8**
  %t999 = load i8*, i8** %t998
  %t1000 = icmp eq i32 %t986, 6
  %t1001 = select i1 %t1000, i8* %t999, i8* %t994
  %t1002 = getelementptr inbounds %Statement, %Statement* %t987, i32 0, i32 1
  %t1003 = bitcast [56 x i8]* %t1002 to i8*
  %t1004 = getelementptr inbounds i8, i8* %t1003, i64 8
  %t1005 = bitcast i8* %t1004 to i8**
  %t1006 = load i8*, i8** %t1005
  %t1007 = icmp eq i32 %t986, 8
  %t1008 = select i1 %t1007, i8* %t1006, i8* %t1001
  %t1009 = getelementptr inbounds %Statement, %Statement* %t987, i32 0, i32 1
  %t1010 = bitcast [40 x i8]* %t1009 to i8*
  %t1011 = getelementptr inbounds i8, i8* %t1010, i64 8
  %t1012 = bitcast i8* %t1011 to i8**
  %t1013 = load i8*, i8** %t1012
  %t1014 = icmp eq i32 %t986, 9
  %t1015 = select i1 %t1014, i8* %t1013, i8* %t1008
  %t1016 = getelementptr inbounds %Statement, %Statement* %t987, i32 0, i32 1
  %t1017 = bitcast [40 x i8]* %t1016 to i8*
  %t1018 = getelementptr inbounds i8, i8* %t1017, i64 8
  %t1019 = bitcast i8* %t1018 to i8**
  %t1020 = load i8*, i8** %t1019
  %t1021 = icmp eq i32 %t986, 10
  %t1022 = select i1 %t1021, i8* %t1020, i8* %t1015
  %t1023 = getelementptr inbounds %Statement, %Statement* %t987, i32 0, i32 1
  %t1024 = bitcast [40 x i8]* %t1023 to i8*
  %t1025 = getelementptr inbounds i8, i8* %t1024, i64 8
  %t1026 = bitcast i8* %t1025 to i8**
  %t1027 = load i8*, i8** %t1026
  %t1028 = icmp eq i32 %t986, 11
  %t1029 = select i1 %t1028, i8* %t1027, i8* %t1022
  %t1030 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t984, i8* %s985, i8* %t1029)
  store %ScopeResult %t1030, %ScopeResult* %l9
  %t1031 = load %ScopeResult, %ScopeResult* %l9
  %t1032 = extractvalue %ScopeResult %t1031, 1
  store { i8**, i64 }* %t1032, { i8**, i64 }** %l10
  %t1033 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t1034 = extractvalue %Statement %statement, 0
  %t1035 = alloca %Statement
  store %Statement %statement, %Statement* %t1035
  %t1036 = getelementptr inbounds %Statement, %Statement* %t1035, i32 0, i32 1
  %t1037 = bitcast [56 x i8]* %t1036 to i8*
  %t1038 = getelementptr inbounds i8, i8* %t1037, i64 16
  %t1039 = bitcast i8* %t1038 to { i8**, i64 }**
  %t1040 = load { i8**, i64 }*, { i8**, i64 }** %t1039
  %t1041 = icmp eq i32 %t1034, 8
  %t1042 = select i1 %t1041, { i8**, i64 }* %t1040, { i8**, i64 }* null
  %t1043 = getelementptr inbounds %Statement, %Statement* %t1035, i32 0, i32 1
  %t1044 = bitcast [40 x i8]* %t1043 to i8*
  %t1045 = getelementptr inbounds i8, i8* %t1044, i64 16
  %t1046 = bitcast i8* %t1045 to { i8**, i64 }**
  %t1047 = load { i8**, i64 }*, { i8**, i64 }** %t1046
  %t1048 = icmp eq i32 %t1034, 9
  %t1049 = select i1 %t1048, { i8**, i64 }* %t1047, { i8**, i64 }* %t1042
  %t1050 = getelementptr inbounds %Statement, %Statement* %t1035, i32 0, i32 1
  %t1051 = bitcast [40 x i8]* %t1050 to i8*
  %t1052 = getelementptr inbounds i8, i8* %t1051, i64 16
  %t1053 = bitcast i8* %t1052 to { i8**, i64 }**
  %t1054 = load { i8**, i64 }*, { i8**, i64 }** %t1053
  %t1055 = icmp eq i32 %t1034, 10
  %t1056 = select i1 %t1055, { i8**, i64 }* %t1054, { i8**, i64 }* %t1049
  %t1057 = getelementptr inbounds %Statement, %Statement* %t1035, i32 0, i32 1
  %t1058 = bitcast [40 x i8]* %t1057 to i8*
  %t1059 = getelementptr inbounds i8, i8* %t1058, i64 16
  %t1060 = bitcast i8* %t1059 to { i8**, i64 }**
  %t1061 = load { i8**, i64 }*, { i8**, i64 }** %t1060
  %t1062 = icmp eq i32 %t1034, 11
  %t1063 = select i1 %t1062, { i8**, i64 }* %t1061, { i8**, i64 }* %t1056
  %t1064 = bitcast { i8**, i64 }* %t1063 to { %TypeParameter*, i64 }*
  %t1065 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t1064)
  %t1066 = bitcast { %Diagnostic*, i64 }* %t1065 to { i8**, i64 }*
  %t1067 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1033, { i8**, i64 }* %t1066)
  store { i8**, i64 }* %t1067, { i8**, i64 }** %l10
  %t1068 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t1069 = extractvalue %Statement %statement, 0
  %t1070 = alloca %Statement
  store %Statement %statement, %Statement* %t1070
  %t1071 = getelementptr inbounds %Statement, %Statement* %t1070, i32 0, i32 1
  %t1072 = bitcast [40 x i8]* %t1071 to i8*
  %t1073 = getelementptr inbounds i8, i8* %t1072, i64 24
  %t1074 = bitcast i8* %t1073 to { i8**, i64 }**
  %t1075 = load { i8**, i64 }*, { i8**, i64 }** %t1074
  %t1076 = icmp eq i32 %t1069, 10
  %t1077 = select i1 %t1076, { i8**, i64 }* %t1075, { i8**, i64 }* null
  %t1078 = bitcast { i8**, i64 }* %t1077 to { %FunctionSignature*, i64 }*
  %t1079 = call { %Diagnostic*, i64 }* @check_interface_members({ %FunctionSignature*, i64 }* %t1078)
  %t1080 = bitcast { %Diagnostic*, i64 }* %t1079 to { i8**, i64 }*
  %t1081 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1068, { i8**, i64 }* %t1080)
  store { i8**, i64 }* %t1081, { i8**, i64 }** %l10
  %t1082 = load %ScopeResult, %ScopeResult* %l9
  %t1083 = extractvalue %ScopeResult %t1082, 0
  %t1084 = insertvalue %ScopeResult undef, { i8**, i64 }* %t1083, 0
  %t1085 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t1086 = insertvalue %ScopeResult %t1084, { i8**, i64 }* %t1085, 1
  ret %ScopeResult %t1086
merge15:
  %t1087 = extractvalue %Statement %statement, 0
  %t1088 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1089 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1090 = icmp eq i32 %t1087, 0
  %t1091 = select i1 %t1090, i8* %t1089, i8* %t1088
  %t1092 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1093 = icmp eq i32 %t1087, 1
  %t1094 = select i1 %t1093, i8* %t1092, i8* %t1091
  %t1095 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1096 = icmp eq i32 %t1087, 2
  %t1097 = select i1 %t1096, i8* %t1095, i8* %t1094
  %t1098 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1099 = icmp eq i32 %t1087, 3
  %t1100 = select i1 %t1099, i8* %t1098, i8* %t1097
  %t1101 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1102 = icmp eq i32 %t1087, 4
  %t1103 = select i1 %t1102, i8* %t1101, i8* %t1100
  %t1104 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1105 = icmp eq i32 %t1087, 5
  %t1106 = select i1 %t1105, i8* %t1104, i8* %t1103
  %t1107 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1108 = icmp eq i32 %t1087, 6
  %t1109 = select i1 %t1108, i8* %t1107, i8* %t1106
  %t1110 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1111 = icmp eq i32 %t1087, 7
  %t1112 = select i1 %t1111, i8* %t1110, i8* %t1109
  %t1113 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1114 = icmp eq i32 %t1087, 8
  %t1115 = select i1 %t1114, i8* %t1113, i8* %t1112
  %t1116 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1117 = icmp eq i32 %t1087, 9
  %t1118 = select i1 %t1117, i8* %t1116, i8* %t1115
  %t1119 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1120 = icmp eq i32 %t1087, 10
  %t1121 = select i1 %t1120, i8* %t1119, i8* %t1118
  %t1122 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1123 = icmp eq i32 %t1087, 11
  %t1124 = select i1 %t1123, i8* %t1122, i8* %t1121
  %t1125 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1126 = icmp eq i32 %t1087, 12
  %t1127 = select i1 %t1126, i8* %t1125, i8* %t1124
  %t1128 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1129 = icmp eq i32 %t1087, 13
  %t1130 = select i1 %t1129, i8* %t1128, i8* %t1127
  %t1131 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1132 = icmp eq i32 %t1087, 14
  %t1133 = select i1 %t1132, i8* %t1131, i8* %t1130
  %t1134 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1135 = icmp eq i32 %t1087, 15
  %t1136 = select i1 %t1135, i8* %t1134, i8* %t1133
  %t1137 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1138 = icmp eq i32 %t1087, 16
  %t1139 = select i1 %t1138, i8* %t1137, i8* %t1136
  %t1140 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1141 = icmp eq i32 %t1087, 17
  %t1142 = select i1 %t1141, i8* %t1140, i8* %t1139
  %t1143 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1144 = icmp eq i32 %t1087, 18
  %t1145 = select i1 %t1144, i8* %t1143, i8* %t1142
  %t1146 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1147 = icmp eq i32 %t1087, 19
  %t1148 = select i1 %t1147, i8* %t1146, i8* %t1145
  %t1149 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1150 = icmp eq i32 %t1087, 20
  %t1151 = select i1 %t1150, i8* %t1149, i8* %t1148
  %t1152 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1153 = icmp eq i32 %t1087, 21
  %t1154 = select i1 %t1153, i8* %t1152, i8* %t1151
  %t1155 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1156 = icmp eq i32 %t1087, 22
  %t1157 = select i1 %t1156, i8* %t1155, i8* %t1154
  %s1158 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.1158, i32 0, i32 0
  %t1159 = icmp eq i8* %t1157, %s1158
  br i1 %t1159, label %then16, label %merge17
then16:
  %t1160 = extractvalue %Statement %statement, 0
  %t1161 = alloca %Statement
  store %Statement %statement, %Statement* %t1161
  %t1162 = getelementptr inbounds %Statement, %Statement* %t1161, i32 0, i32 1
  %t1163 = bitcast [48 x i8]* %t1162 to i8*
  %t1164 = bitcast i8* %t1163 to i8**
  %t1165 = load i8*, i8** %t1164
  %t1166 = icmp eq i32 %t1160, 2
  %t1167 = select i1 %t1166, i8* %t1165, i8* null
  %t1168 = getelementptr inbounds %Statement, %Statement* %t1161, i32 0, i32 1
  %t1169 = bitcast [48 x i8]* %t1168 to i8*
  %t1170 = bitcast i8* %t1169 to i8**
  %t1171 = load i8*, i8** %t1170
  %t1172 = icmp eq i32 %t1160, 3
  %t1173 = select i1 %t1172, i8* %t1171, i8* %t1167
  %t1174 = getelementptr inbounds %Statement, %Statement* %t1161, i32 0, i32 1
  %t1175 = bitcast [40 x i8]* %t1174 to i8*
  %t1176 = bitcast i8* %t1175 to i8**
  %t1177 = load i8*, i8** %t1176
  %t1178 = icmp eq i32 %t1160, 6
  %t1179 = select i1 %t1178, i8* %t1177, i8* %t1173
  %t1180 = getelementptr inbounds %Statement, %Statement* %t1161, i32 0, i32 1
  %t1181 = bitcast [56 x i8]* %t1180 to i8*
  %t1182 = bitcast i8* %t1181 to i8**
  %t1183 = load i8*, i8** %t1182
  %t1184 = icmp eq i32 %t1160, 8
  %t1185 = select i1 %t1184, i8* %t1183, i8* %t1179
  %t1186 = getelementptr inbounds %Statement, %Statement* %t1161, i32 0, i32 1
  %t1187 = bitcast [40 x i8]* %t1186 to i8*
  %t1188 = bitcast i8* %t1187 to i8**
  %t1189 = load i8*, i8** %t1188
  %t1190 = icmp eq i32 %t1160, 9
  %t1191 = select i1 %t1190, i8* %t1189, i8* %t1185
  %t1192 = getelementptr inbounds %Statement, %Statement* %t1161, i32 0, i32 1
  %t1193 = bitcast [40 x i8]* %t1192 to i8*
  %t1194 = bitcast i8* %t1193 to i8**
  %t1195 = load i8*, i8** %t1194
  %t1196 = icmp eq i32 %t1160, 10
  %t1197 = select i1 %t1196, i8* %t1195, i8* %t1191
  %t1198 = getelementptr inbounds %Statement, %Statement* %t1161, i32 0, i32 1
  %t1199 = bitcast [40 x i8]* %t1198 to i8*
  %t1200 = bitcast i8* %t1199 to i8**
  %t1201 = load i8*, i8** %t1200
  %t1202 = icmp eq i32 %t1160, 11
  %t1203 = select i1 %t1202, i8* %t1201, i8* %t1197
  %s1204 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1204, i32 0, i32 0
  %t1205 = extractvalue %Statement %statement, 0
  %t1206 = alloca %Statement
  store %Statement %statement, %Statement* %t1206
  %t1207 = getelementptr inbounds %Statement, %Statement* %t1206, i32 0, i32 1
  %t1208 = bitcast [48 x i8]* %t1207 to i8*
  %t1209 = getelementptr inbounds i8, i8* %t1208, i64 8
  %t1210 = bitcast i8* %t1209 to i8**
  %t1211 = load i8*, i8** %t1210
  %t1212 = icmp eq i32 %t1205, 3
  %t1213 = select i1 %t1212, i8* %t1211, i8* null
  %t1214 = getelementptr inbounds %Statement, %Statement* %t1206, i32 0, i32 1
  %t1215 = bitcast [40 x i8]* %t1214 to i8*
  %t1216 = getelementptr inbounds i8, i8* %t1215, i64 8
  %t1217 = bitcast i8* %t1216 to i8**
  %t1218 = load i8*, i8** %t1217
  %t1219 = icmp eq i32 %t1205, 6
  %t1220 = select i1 %t1219, i8* %t1218, i8* %t1213
  %t1221 = getelementptr inbounds %Statement, %Statement* %t1206, i32 0, i32 1
  %t1222 = bitcast [56 x i8]* %t1221 to i8*
  %t1223 = getelementptr inbounds i8, i8* %t1222, i64 8
  %t1224 = bitcast i8* %t1223 to i8**
  %t1225 = load i8*, i8** %t1224
  %t1226 = icmp eq i32 %t1205, 8
  %t1227 = select i1 %t1226, i8* %t1225, i8* %t1220
  %t1228 = getelementptr inbounds %Statement, %Statement* %t1206, i32 0, i32 1
  %t1229 = bitcast [40 x i8]* %t1228 to i8*
  %t1230 = getelementptr inbounds i8, i8* %t1229, i64 8
  %t1231 = bitcast i8* %t1230 to i8**
  %t1232 = load i8*, i8** %t1231
  %t1233 = icmp eq i32 %t1205, 9
  %t1234 = select i1 %t1233, i8* %t1232, i8* %t1227
  %t1235 = getelementptr inbounds %Statement, %Statement* %t1206, i32 0, i32 1
  %t1236 = bitcast [40 x i8]* %t1235 to i8*
  %t1237 = getelementptr inbounds i8, i8* %t1236, i64 8
  %t1238 = bitcast i8* %t1237 to i8**
  %t1239 = load i8*, i8** %t1238
  %t1240 = icmp eq i32 %t1205, 10
  %t1241 = select i1 %t1240, i8* %t1239, i8* %t1234
  %t1242 = getelementptr inbounds %Statement, %Statement* %t1206, i32 0, i32 1
  %t1243 = bitcast [40 x i8]* %t1242 to i8*
  %t1244 = getelementptr inbounds i8, i8* %t1243, i64 8
  %t1245 = bitcast i8* %t1244 to i8**
  %t1246 = load i8*, i8** %t1245
  %t1247 = icmp eq i32 %t1205, 11
  %t1248 = select i1 %t1247, i8* %t1246, i8* %t1241
  %t1249 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1203, i8* %s1204, i8* %t1248)
  store %ScopeResult %t1249, %ScopeResult* %l11
  %t1250 = load %ScopeResult, %ScopeResult* %l11
  %t1251 = extractvalue %ScopeResult %t1250, 1
  %t1252 = extractvalue %Statement %statement, 0
  %t1253 = alloca %Statement
  store %Statement %statement, %Statement* %t1253
  %t1254 = getelementptr inbounds %Statement, %Statement* %t1253, i32 0, i32 1
  %t1255 = bitcast [48 x i8]* %t1254 to i8*
  %t1256 = getelementptr inbounds i8, i8* %t1255, i64 24
  %t1257 = bitcast i8* %t1256 to { i8**, i64 }**
  %t1258 = load { i8**, i64 }*, { i8**, i64 }** %t1257
  %t1259 = icmp eq i32 %t1252, 3
  %t1260 = select i1 %t1259, { i8**, i64 }* %t1258, { i8**, i64 }* null
  %t1261 = bitcast { i8**, i64 }* %t1260 to { %ModelProperty*, i64 }*
  %t1262 = call { %Diagnostic*, i64 }* @check_model_properties({ %ModelProperty*, i64 }* %t1261)
  %t1263 = bitcast { %Diagnostic*, i64 }* %t1262 to { i8**, i64 }*
  %t1264 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1251, { i8**, i64 }* %t1263)
  store { i8**, i64 }* %t1264, { i8**, i64 }** %l12
  %t1265 = load %ScopeResult, %ScopeResult* %l11
  %t1266 = extractvalue %ScopeResult %t1265, 0
  %t1267 = insertvalue %ScopeResult undef, { i8**, i64 }* %t1266, 0
  %t1268 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %t1269 = insertvalue %ScopeResult %t1267, { i8**, i64 }* %t1268, 1
  ret %ScopeResult %t1269
merge17:
  %t1270 = extractvalue %Statement %statement, 0
  %t1271 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1272 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1273 = icmp eq i32 %t1270, 0
  %t1274 = select i1 %t1273, i8* %t1272, i8* %t1271
  %t1275 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1276 = icmp eq i32 %t1270, 1
  %t1277 = select i1 %t1276, i8* %t1275, i8* %t1274
  %t1278 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1279 = icmp eq i32 %t1270, 2
  %t1280 = select i1 %t1279, i8* %t1278, i8* %t1277
  %t1281 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1282 = icmp eq i32 %t1270, 3
  %t1283 = select i1 %t1282, i8* %t1281, i8* %t1280
  %t1284 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1285 = icmp eq i32 %t1270, 4
  %t1286 = select i1 %t1285, i8* %t1284, i8* %t1283
  %t1287 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1288 = icmp eq i32 %t1270, 5
  %t1289 = select i1 %t1288, i8* %t1287, i8* %t1286
  %t1290 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1291 = icmp eq i32 %t1270, 6
  %t1292 = select i1 %t1291, i8* %t1290, i8* %t1289
  %t1293 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1294 = icmp eq i32 %t1270, 7
  %t1295 = select i1 %t1294, i8* %t1293, i8* %t1292
  %t1296 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1297 = icmp eq i32 %t1270, 8
  %t1298 = select i1 %t1297, i8* %t1296, i8* %t1295
  %t1299 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1300 = icmp eq i32 %t1270, 9
  %t1301 = select i1 %t1300, i8* %t1299, i8* %t1298
  %t1302 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1303 = icmp eq i32 %t1270, 10
  %t1304 = select i1 %t1303, i8* %t1302, i8* %t1301
  %t1305 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1306 = icmp eq i32 %t1270, 11
  %t1307 = select i1 %t1306, i8* %t1305, i8* %t1304
  %t1308 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1309 = icmp eq i32 %t1270, 12
  %t1310 = select i1 %t1309, i8* %t1308, i8* %t1307
  %t1311 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1312 = icmp eq i32 %t1270, 13
  %t1313 = select i1 %t1312, i8* %t1311, i8* %t1310
  %t1314 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1315 = icmp eq i32 %t1270, 14
  %t1316 = select i1 %t1315, i8* %t1314, i8* %t1313
  %t1317 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1318 = icmp eq i32 %t1270, 15
  %t1319 = select i1 %t1318, i8* %t1317, i8* %t1316
  %t1320 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1321 = icmp eq i32 %t1270, 16
  %t1322 = select i1 %t1321, i8* %t1320, i8* %t1319
  %t1323 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1324 = icmp eq i32 %t1270, 17
  %t1325 = select i1 %t1324, i8* %t1323, i8* %t1322
  %t1326 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1327 = icmp eq i32 %t1270, 18
  %t1328 = select i1 %t1327, i8* %t1326, i8* %t1325
  %t1329 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1330 = icmp eq i32 %t1270, 19
  %t1331 = select i1 %t1330, i8* %t1329, i8* %t1328
  %t1332 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1333 = icmp eq i32 %t1270, 20
  %t1334 = select i1 %t1333, i8* %t1332, i8* %t1331
  %t1335 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1336 = icmp eq i32 %t1270, 21
  %t1337 = select i1 %t1336, i8* %t1335, i8* %t1334
  %t1338 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1339 = icmp eq i32 %t1270, 22
  %t1340 = select i1 %t1339, i8* %t1338, i8* %t1337
  %s1341 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1341, i32 0, i32 0
  %t1342 = icmp eq i8* %t1340, %s1341
  br i1 %t1342, label %then18, label %merge19
then18:
  %t1343 = extractvalue %Statement %statement, 0
  %t1344 = alloca %Statement
  store %Statement %statement, %Statement* %t1344
  %t1345 = getelementptr inbounds %Statement, %Statement* %t1344, i32 0, i32 1
  %t1346 = bitcast [24 x i8]* %t1345 to i8*
  %t1347 = bitcast i8* %t1346 to i8**
  %t1348 = load i8*, i8** %t1347
  %t1349 = icmp eq i32 %t1343, 4
  %t1350 = select i1 %t1349, i8* %t1348, i8* null
  %t1351 = getelementptr inbounds %Statement, %Statement* %t1344, i32 0, i32 1
  %t1352 = bitcast [24 x i8]* %t1351 to i8*
  %t1353 = bitcast i8* %t1352 to i8**
  %t1354 = load i8*, i8** %t1353
  %t1355 = icmp eq i32 %t1343, 5
  %t1356 = select i1 %t1355, i8* %t1354, i8* %t1350
  %t1357 = getelementptr inbounds %Statement, %Statement* %t1344, i32 0, i32 1
  %t1358 = bitcast [24 x i8]* %t1357 to i8*
  %t1359 = bitcast i8* %t1358 to i8**
  %t1360 = load i8*, i8** %t1359
  %t1361 = icmp eq i32 %t1343, 7
  %t1362 = select i1 %t1361, i8* %t1360, i8* %t1356
  %s1363 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1363, i32 0, i32 0
  %t1364 = extractvalue %Statement %statement, 0
  %t1365 = alloca %Statement
  store %Statement %statement, %Statement* %t1365
  %t1366 = getelementptr inbounds %Statement, %Statement* %t1365, i32 0, i32 1
  %t1367 = bitcast [24 x i8]* %t1366 to i8*
  %t1368 = bitcast i8* %t1367 to i8**
  %t1369 = load i8*, i8** %t1368
  %t1370 = icmp eq i32 %t1364, 4
  %t1371 = select i1 %t1370, i8* %t1369, i8* null
  %t1372 = getelementptr inbounds %Statement, %Statement* %t1365, i32 0, i32 1
  %t1373 = bitcast [24 x i8]* %t1372 to i8*
  %t1374 = bitcast i8* %t1373 to i8**
  %t1375 = load i8*, i8** %t1374
  %t1376 = icmp eq i32 %t1364, 5
  %t1377 = select i1 %t1376, i8* %t1375, i8* %t1371
  %t1378 = getelementptr inbounds %Statement, %Statement* %t1365, i32 0, i32 1
  %t1379 = bitcast [24 x i8]* %t1378 to i8*
  %t1380 = bitcast i8* %t1379 to i8**
  %t1381 = load i8*, i8** %t1380
  %t1382 = icmp eq i32 %t1364, 7
  %t1383 = select i1 %t1382, i8* %t1381, i8* %t1377
  store double 0.0, double* %l13
  %t1384 = load double, double* %l13
  store double 0.0, double* %l14
  %t1385 = load double, double* %l14
  %t1386 = extractvalue %Statement %statement, 0
  %t1387 = alloca %Statement
  store %Statement %statement, %Statement* %t1387
  %t1388 = getelementptr inbounds %Statement, %Statement* %t1387, i32 0, i32 1
  %t1389 = bitcast [24 x i8]* %t1388 to i8*
  %t1390 = bitcast i8* %t1389 to i8**
  %t1391 = load i8*, i8** %t1390
  %t1392 = icmp eq i32 %t1386, 4
  %t1393 = select i1 %t1392, i8* %t1391, i8* null
  %t1394 = getelementptr inbounds %Statement, %Statement* %t1387, i32 0, i32 1
  %t1395 = bitcast [24 x i8]* %t1394 to i8*
  %t1396 = bitcast i8* %t1395 to i8**
  %t1397 = load i8*, i8** %t1396
  %t1398 = icmp eq i32 %t1386, 5
  %t1399 = select i1 %t1398, i8* %t1397, i8* %t1393
  %t1400 = getelementptr inbounds %Statement, %Statement* %t1387, i32 0, i32 1
  %t1401 = bitcast [24 x i8]* %t1400 to i8*
  %t1402 = bitcast i8* %t1401 to i8**
  %t1403 = load i8*, i8** %t1402
  %t1404 = icmp eq i32 %t1386, 7
  %t1405 = select i1 %t1404, i8* %t1403, i8* %t1399
  %t1406 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature zeroinitializer)
  %t1407 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t1406)
  store double %t1407, double* %l14
  %t1408 = load double, double* %l14
  %t1409 = extractvalue %Statement %statement, 0
  %t1410 = alloca %Statement
  store %Statement %statement, %Statement* %t1410
  %t1411 = getelementptr inbounds %Statement, %Statement* %t1410, i32 0, i32 1
  %t1412 = bitcast [24 x i8]* %t1411 to i8*
  %t1413 = bitcast i8* %t1412 to i8**
  %t1414 = load i8*, i8** %t1413
  %t1415 = icmp eq i32 %t1409, 4
  %t1416 = select i1 %t1415, i8* %t1414, i8* null
  %t1417 = getelementptr inbounds %Statement, %Statement* %t1410, i32 0, i32 1
  %t1418 = bitcast [24 x i8]* %t1417 to i8*
  %t1419 = bitcast i8* %t1418 to i8**
  %t1420 = load i8*, i8** %t1419
  %t1421 = icmp eq i32 %t1409, 5
  %t1422 = select i1 %t1421, i8* %t1420, i8* %t1416
  %t1423 = getelementptr inbounds %Statement, %Statement* %t1410, i32 0, i32 1
  %t1424 = bitcast [24 x i8]* %t1423 to i8*
  %t1425 = bitcast i8* %t1424 to i8**
  %t1426 = load i8*, i8** %t1425
  %t1427 = icmp eq i32 %t1409, 7
  %t1428 = select i1 %t1427, i8* %t1426, i8* %t1422
  %t1429 = extractvalue %Statement %statement, 0
  %t1430 = alloca %Statement
  store %Statement %statement, %Statement* %t1430
  %t1431 = getelementptr inbounds %Statement, %Statement* %t1430, i32 0, i32 1
  %t1432 = bitcast [24 x i8]* %t1431 to i8*
  %t1433 = getelementptr inbounds i8, i8* %t1432, i64 8
  %t1434 = bitcast i8* %t1433 to i8**
  %t1435 = load i8*, i8** %t1434
  %t1436 = icmp eq i32 %t1429, 4
  %t1437 = select i1 %t1436, i8* %t1435, i8* null
  %t1438 = getelementptr inbounds %Statement, %Statement* %t1430, i32 0, i32 1
  %t1439 = bitcast [24 x i8]* %t1438 to i8*
  %t1440 = getelementptr inbounds i8, i8* %t1439, i64 8
  %t1441 = bitcast i8* %t1440 to i8**
  %t1442 = load i8*, i8** %t1441
  %t1443 = icmp eq i32 %t1429, 5
  %t1444 = select i1 %t1443, i8* %t1442, i8* %t1437
  %t1445 = getelementptr inbounds %Statement, %Statement* %t1430, i32 0, i32 1
  %t1446 = bitcast [40 x i8]* %t1445 to i8*
  %t1447 = getelementptr inbounds i8, i8* %t1446, i64 16
  %t1448 = bitcast i8* %t1447 to i8**
  %t1449 = load i8*, i8** %t1448
  %t1450 = icmp eq i32 %t1429, 6
  %t1451 = select i1 %t1450, i8* %t1449, i8* %t1444
  %t1452 = getelementptr inbounds %Statement, %Statement* %t1430, i32 0, i32 1
  %t1453 = bitcast [24 x i8]* %t1452 to i8*
  %t1454 = getelementptr inbounds i8, i8* %t1453, i64 8
  %t1455 = bitcast i8* %t1454 to i8**
  %t1456 = load i8*, i8** %t1455
  %t1457 = icmp eq i32 %t1429, 7
  %t1458 = select i1 %t1457, i8* %t1456, i8* %t1451
  %t1459 = getelementptr inbounds %Statement, %Statement* %t1430, i32 0, i32 1
  %t1460 = bitcast [40 x i8]* %t1459 to i8*
  %t1461 = getelementptr inbounds i8, i8* %t1460, i64 24
  %t1462 = bitcast i8* %t1461 to i8**
  %t1463 = load i8*, i8** %t1462
  %t1464 = icmp eq i32 %t1429, 12
  %t1465 = select i1 %t1464, i8* %t1463, i8* %t1458
  %t1466 = getelementptr inbounds %Statement, %Statement* %t1430, i32 0, i32 1
  %t1467 = bitcast [24 x i8]* %t1466 to i8*
  %t1468 = getelementptr inbounds i8, i8* %t1467, i64 8
  %t1469 = bitcast i8* %t1468 to i8**
  %t1470 = load i8*, i8** %t1469
  %t1471 = icmp eq i32 %t1429, 13
  %t1472 = select i1 %t1471, i8* %t1470, i8* %t1465
  %t1473 = getelementptr inbounds %Statement, %Statement* %t1430, i32 0, i32 1
  %t1474 = bitcast [24 x i8]* %t1473 to i8*
  %t1475 = getelementptr inbounds i8, i8* %t1474, i64 8
  %t1476 = bitcast i8* %t1475 to i8**
  %t1477 = load i8*, i8** %t1476
  %t1478 = icmp eq i32 %t1429, 14
  %t1479 = select i1 %t1478, i8* %t1477, i8* %t1472
  %t1480 = getelementptr inbounds %Statement, %Statement* %t1430, i32 0, i32 1
  %t1481 = bitcast [16 x i8]* %t1480 to i8*
  %t1482 = bitcast i8* %t1481 to i8**
  %t1483 = load i8*, i8** %t1482
  %t1484 = icmp eq i32 %t1429, 15
  %t1485 = select i1 %t1484, i8* %t1483, i8* %t1479
  %t1486 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature zeroinitializer, %Block zeroinitializer, { %Statement*, i64 }* %interfaces)
  %t1487 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t1486)
  store double %t1487, double* %l14
  %t1488 = load double, double* %l13
  %t1489 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t1490 = load double, double* %l14
  %t1491 = insertvalue %ScopeResult %t1489, { i8**, i64 }* null, 1
  ret %ScopeResult %t1491
merge19:
  %t1492 = extractvalue %Statement %statement, 0
  %t1493 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1494 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1495 = icmp eq i32 %t1492, 0
  %t1496 = select i1 %t1495, i8* %t1494, i8* %t1493
  %t1497 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1498 = icmp eq i32 %t1492, 1
  %t1499 = select i1 %t1498, i8* %t1497, i8* %t1496
  %t1500 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1501 = icmp eq i32 %t1492, 2
  %t1502 = select i1 %t1501, i8* %t1500, i8* %t1499
  %t1503 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1504 = icmp eq i32 %t1492, 3
  %t1505 = select i1 %t1504, i8* %t1503, i8* %t1502
  %t1506 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1507 = icmp eq i32 %t1492, 4
  %t1508 = select i1 %t1507, i8* %t1506, i8* %t1505
  %t1509 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1510 = icmp eq i32 %t1492, 5
  %t1511 = select i1 %t1510, i8* %t1509, i8* %t1508
  %t1512 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1513 = icmp eq i32 %t1492, 6
  %t1514 = select i1 %t1513, i8* %t1512, i8* %t1511
  %t1515 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1516 = icmp eq i32 %t1492, 7
  %t1517 = select i1 %t1516, i8* %t1515, i8* %t1514
  %t1518 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1519 = icmp eq i32 %t1492, 8
  %t1520 = select i1 %t1519, i8* %t1518, i8* %t1517
  %t1521 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1522 = icmp eq i32 %t1492, 9
  %t1523 = select i1 %t1522, i8* %t1521, i8* %t1520
  %t1524 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1525 = icmp eq i32 %t1492, 10
  %t1526 = select i1 %t1525, i8* %t1524, i8* %t1523
  %t1527 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1528 = icmp eq i32 %t1492, 11
  %t1529 = select i1 %t1528, i8* %t1527, i8* %t1526
  %t1530 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1531 = icmp eq i32 %t1492, 12
  %t1532 = select i1 %t1531, i8* %t1530, i8* %t1529
  %t1533 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1534 = icmp eq i32 %t1492, 13
  %t1535 = select i1 %t1534, i8* %t1533, i8* %t1532
  %t1536 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1537 = icmp eq i32 %t1492, 14
  %t1538 = select i1 %t1537, i8* %t1536, i8* %t1535
  %t1539 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1540 = icmp eq i32 %t1492, 15
  %t1541 = select i1 %t1540, i8* %t1539, i8* %t1538
  %t1542 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1543 = icmp eq i32 %t1492, 16
  %t1544 = select i1 %t1543, i8* %t1542, i8* %t1541
  %t1545 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1546 = icmp eq i32 %t1492, 17
  %t1547 = select i1 %t1546, i8* %t1545, i8* %t1544
  %t1548 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1549 = icmp eq i32 %t1492, 18
  %t1550 = select i1 %t1549, i8* %t1548, i8* %t1547
  %t1551 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1552 = icmp eq i32 %t1492, 19
  %t1553 = select i1 %t1552, i8* %t1551, i8* %t1550
  %t1554 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1555 = icmp eq i32 %t1492, 20
  %t1556 = select i1 %t1555, i8* %t1554, i8* %t1553
  %t1557 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1558 = icmp eq i32 %t1492, 21
  %t1559 = select i1 %t1558, i8* %t1557, i8* %t1556
  %t1560 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1561 = icmp eq i32 %t1492, 22
  %t1562 = select i1 %t1561, i8* %t1560, i8* %t1559
  %s1563 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1563, i32 0, i32 0
  %t1564 = icmp eq i8* %t1562, %s1563
  br i1 %t1564, label %then20, label %merge21
then20:
  %t1565 = extractvalue %Statement %statement, 0
  %t1566 = alloca %Statement
  store %Statement %statement, %Statement* %t1566
  %t1567 = getelementptr inbounds %Statement, %Statement* %t1566, i32 0, i32 1
  %t1568 = bitcast [24 x i8]* %t1567 to i8*
  %t1569 = bitcast i8* %t1568 to i8**
  %t1570 = load i8*, i8** %t1569
  %t1571 = icmp eq i32 %t1565, 4
  %t1572 = select i1 %t1571, i8* %t1570, i8* null
  %t1573 = getelementptr inbounds %Statement, %Statement* %t1566, i32 0, i32 1
  %t1574 = bitcast [24 x i8]* %t1573 to i8*
  %t1575 = bitcast i8* %t1574 to i8**
  %t1576 = load i8*, i8** %t1575
  %t1577 = icmp eq i32 %t1565, 5
  %t1578 = select i1 %t1577, i8* %t1576, i8* %t1572
  %t1579 = getelementptr inbounds %Statement, %Statement* %t1566, i32 0, i32 1
  %t1580 = bitcast [24 x i8]* %t1579 to i8*
  %t1581 = bitcast i8* %t1580 to i8**
  %t1582 = load i8*, i8** %t1581
  %t1583 = icmp eq i32 %t1565, 7
  %t1584 = select i1 %t1583, i8* %t1582, i8* %t1578
  %s1585 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1585, i32 0, i32 0
  %t1586 = extractvalue %Statement %statement, 0
  %t1587 = alloca %Statement
  store %Statement %statement, %Statement* %t1587
  %t1588 = getelementptr inbounds %Statement, %Statement* %t1587, i32 0, i32 1
  %t1589 = bitcast [24 x i8]* %t1588 to i8*
  %t1590 = bitcast i8* %t1589 to i8**
  %t1591 = load i8*, i8** %t1590
  %t1592 = icmp eq i32 %t1586, 4
  %t1593 = select i1 %t1592, i8* %t1591, i8* null
  %t1594 = getelementptr inbounds %Statement, %Statement* %t1587, i32 0, i32 1
  %t1595 = bitcast [24 x i8]* %t1594 to i8*
  %t1596 = bitcast i8* %t1595 to i8**
  %t1597 = load i8*, i8** %t1596
  %t1598 = icmp eq i32 %t1586, 5
  %t1599 = select i1 %t1598, i8* %t1597, i8* %t1593
  %t1600 = getelementptr inbounds %Statement, %Statement* %t1587, i32 0, i32 1
  %t1601 = bitcast [24 x i8]* %t1600 to i8*
  %t1602 = bitcast i8* %t1601 to i8**
  %t1603 = load i8*, i8** %t1602
  %t1604 = icmp eq i32 %t1586, 7
  %t1605 = select i1 %t1604, i8* %t1603, i8* %t1599
  store double 0.0, double* %l15
  %t1606 = load double, double* %l15
  store double 0.0, double* %l16
  %t1607 = load double, double* %l16
  %t1608 = extractvalue %Statement %statement, 0
  %t1609 = alloca %Statement
  store %Statement %statement, %Statement* %t1609
  %t1610 = getelementptr inbounds %Statement, %Statement* %t1609, i32 0, i32 1
  %t1611 = bitcast [24 x i8]* %t1610 to i8*
  %t1612 = bitcast i8* %t1611 to i8**
  %t1613 = load i8*, i8** %t1612
  %t1614 = icmp eq i32 %t1608, 4
  %t1615 = select i1 %t1614, i8* %t1613, i8* null
  %t1616 = getelementptr inbounds %Statement, %Statement* %t1609, i32 0, i32 1
  %t1617 = bitcast [24 x i8]* %t1616 to i8*
  %t1618 = bitcast i8* %t1617 to i8**
  %t1619 = load i8*, i8** %t1618
  %t1620 = icmp eq i32 %t1608, 5
  %t1621 = select i1 %t1620, i8* %t1619, i8* %t1615
  %t1622 = getelementptr inbounds %Statement, %Statement* %t1609, i32 0, i32 1
  %t1623 = bitcast [24 x i8]* %t1622 to i8*
  %t1624 = bitcast i8* %t1623 to i8**
  %t1625 = load i8*, i8** %t1624
  %t1626 = icmp eq i32 %t1608, 7
  %t1627 = select i1 %t1626, i8* %t1625, i8* %t1621
  %t1628 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature zeroinitializer)
  %t1629 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t1628)
  store double %t1629, double* %l16
  %t1630 = load double, double* %l16
  %t1631 = extractvalue %Statement %statement, 0
  %t1632 = alloca %Statement
  store %Statement %statement, %Statement* %t1632
  %t1633 = getelementptr inbounds %Statement, %Statement* %t1632, i32 0, i32 1
  %t1634 = bitcast [24 x i8]* %t1633 to i8*
  %t1635 = bitcast i8* %t1634 to i8**
  %t1636 = load i8*, i8** %t1635
  %t1637 = icmp eq i32 %t1631, 4
  %t1638 = select i1 %t1637, i8* %t1636, i8* null
  %t1639 = getelementptr inbounds %Statement, %Statement* %t1632, i32 0, i32 1
  %t1640 = bitcast [24 x i8]* %t1639 to i8*
  %t1641 = bitcast i8* %t1640 to i8**
  %t1642 = load i8*, i8** %t1641
  %t1643 = icmp eq i32 %t1631, 5
  %t1644 = select i1 %t1643, i8* %t1642, i8* %t1638
  %t1645 = getelementptr inbounds %Statement, %Statement* %t1632, i32 0, i32 1
  %t1646 = bitcast [24 x i8]* %t1645 to i8*
  %t1647 = bitcast i8* %t1646 to i8**
  %t1648 = load i8*, i8** %t1647
  %t1649 = icmp eq i32 %t1631, 7
  %t1650 = select i1 %t1649, i8* %t1648, i8* %t1644
  %t1651 = extractvalue %Statement %statement, 0
  %t1652 = alloca %Statement
  store %Statement %statement, %Statement* %t1652
  %t1653 = getelementptr inbounds %Statement, %Statement* %t1652, i32 0, i32 1
  %t1654 = bitcast [24 x i8]* %t1653 to i8*
  %t1655 = getelementptr inbounds i8, i8* %t1654, i64 8
  %t1656 = bitcast i8* %t1655 to i8**
  %t1657 = load i8*, i8** %t1656
  %t1658 = icmp eq i32 %t1651, 4
  %t1659 = select i1 %t1658, i8* %t1657, i8* null
  %t1660 = getelementptr inbounds %Statement, %Statement* %t1652, i32 0, i32 1
  %t1661 = bitcast [24 x i8]* %t1660 to i8*
  %t1662 = getelementptr inbounds i8, i8* %t1661, i64 8
  %t1663 = bitcast i8* %t1662 to i8**
  %t1664 = load i8*, i8** %t1663
  %t1665 = icmp eq i32 %t1651, 5
  %t1666 = select i1 %t1665, i8* %t1664, i8* %t1659
  %t1667 = getelementptr inbounds %Statement, %Statement* %t1652, i32 0, i32 1
  %t1668 = bitcast [40 x i8]* %t1667 to i8*
  %t1669 = getelementptr inbounds i8, i8* %t1668, i64 16
  %t1670 = bitcast i8* %t1669 to i8**
  %t1671 = load i8*, i8** %t1670
  %t1672 = icmp eq i32 %t1651, 6
  %t1673 = select i1 %t1672, i8* %t1671, i8* %t1666
  %t1674 = getelementptr inbounds %Statement, %Statement* %t1652, i32 0, i32 1
  %t1675 = bitcast [24 x i8]* %t1674 to i8*
  %t1676 = getelementptr inbounds i8, i8* %t1675, i64 8
  %t1677 = bitcast i8* %t1676 to i8**
  %t1678 = load i8*, i8** %t1677
  %t1679 = icmp eq i32 %t1651, 7
  %t1680 = select i1 %t1679, i8* %t1678, i8* %t1673
  %t1681 = getelementptr inbounds %Statement, %Statement* %t1652, i32 0, i32 1
  %t1682 = bitcast [40 x i8]* %t1681 to i8*
  %t1683 = getelementptr inbounds i8, i8* %t1682, i64 24
  %t1684 = bitcast i8* %t1683 to i8**
  %t1685 = load i8*, i8** %t1684
  %t1686 = icmp eq i32 %t1651, 12
  %t1687 = select i1 %t1686, i8* %t1685, i8* %t1680
  %t1688 = getelementptr inbounds %Statement, %Statement* %t1652, i32 0, i32 1
  %t1689 = bitcast [24 x i8]* %t1688 to i8*
  %t1690 = getelementptr inbounds i8, i8* %t1689, i64 8
  %t1691 = bitcast i8* %t1690 to i8**
  %t1692 = load i8*, i8** %t1691
  %t1693 = icmp eq i32 %t1651, 13
  %t1694 = select i1 %t1693, i8* %t1692, i8* %t1687
  %t1695 = getelementptr inbounds %Statement, %Statement* %t1652, i32 0, i32 1
  %t1696 = bitcast [24 x i8]* %t1695 to i8*
  %t1697 = getelementptr inbounds i8, i8* %t1696, i64 8
  %t1698 = bitcast i8* %t1697 to i8**
  %t1699 = load i8*, i8** %t1698
  %t1700 = icmp eq i32 %t1651, 14
  %t1701 = select i1 %t1700, i8* %t1699, i8* %t1694
  %t1702 = getelementptr inbounds %Statement, %Statement* %t1652, i32 0, i32 1
  %t1703 = bitcast [16 x i8]* %t1702 to i8*
  %t1704 = bitcast i8* %t1703 to i8**
  %t1705 = load i8*, i8** %t1704
  %t1706 = icmp eq i32 %t1651, 15
  %t1707 = select i1 %t1706, i8* %t1705, i8* %t1701
  %t1708 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature zeroinitializer, %Block zeroinitializer, { %Statement*, i64 }* %interfaces)
  %t1709 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t1708)
  store double %t1709, double* %l16
  %t1710 = load double, double* %l15
  %t1711 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t1712 = load double, double* %l16
  %t1713 = insertvalue %ScopeResult %t1711, { i8**, i64 }* null, 1
  ret %ScopeResult %t1713
merge21:
  %t1714 = extractvalue %Statement %statement, 0
  %t1715 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1716 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1717 = icmp eq i32 %t1714, 0
  %t1718 = select i1 %t1717, i8* %t1716, i8* %t1715
  %t1719 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1720 = icmp eq i32 %t1714, 1
  %t1721 = select i1 %t1720, i8* %t1719, i8* %t1718
  %t1722 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1723 = icmp eq i32 %t1714, 2
  %t1724 = select i1 %t1723, i8* %t1722, i8* %t1721
  %t1725 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1726 = icmp eq i32 %t1714, 3
  %t1727 = select i1 %t1726, i8* %t1725, i8* %t1724
  %t1728 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1729 = icmp eq i32 %t1714, 4
  %t1730 = select i1 %t1729, i8* %t1728, i8* %t1727
  %t1731 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1732 = icmp eq i32 %t1714, 5
  %t1733 = select i1 %t1732, i8* %t1731, i8* %t1730
  %t1734 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1735 = icmp eq i32 %t1714, 6
  %t1736 = select i1 %t1735, i8* %t1734, i8* %t1733
  %t1737 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1738 = icmp eq i32 %t1714, 7
  %t1739 = select i1 %t1738, i8* %t1737, i8* %t1736
  %t1740 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1741 = icmp eq i32 %t1714, 8
  %t1742 = select i1 %t1741, i8* %t1740, i8* %t1739
  %t1743 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1744 = icmp eq i32 %t1714, 9
  %t1745 = select i1 %t1744, i8* %t1743, i8* %t1742
  %t1746 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1747 = icmp eq i32 %t1714, 10
  %t1748 = select i1 %t1747, i8* %t1746, i8* %t1745
  %t1749 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1750 = icmp eq i32 %t1714, 11
  %t1751 = select i1 %t1750, i8* %t1749, i8* %t1748
  %t1752 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1753 = icmp eq i32 %t1714, 12
  %t1754 = select i1 %t1753, i8* %t1752, i8* %t1751
  %t1755 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1756 = icmp eq i32 %t1714, 13
  %t1757 = select i1 %t1756, i8* %t1755, i8* %t1754
  %t1758 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1759 = icmp eq i32 %t1714, 14
  %t1760 = select i1 %t1759, i8* %t1758, i8* %t1757
  %t1761 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1762 = icmp eq i32 %t1714, 15
  %t1763 = select i1 %t1762, i8* %t1761, i8* %t1760
  %t1764 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1765 = icmp eq i32 %t1714, 16
  %t1766 = select i1 %t1765, i8* %t1764, i8* %t1763
  %t1767 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1768 = icmp eq i32 %t1714, 17
  %t1769 = select i1 %t1768, i8* %t1767, i8* %t1766
  %t1770 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1771 = icmp eq i32 %t1714, 18
  %t1772 = select i1 %t1771, i8* %t1770, i8* %t1769
  %t1773 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1774 = icmp eq i32 %t1714, 19
  %t1775 = select i1 %t1774, i8* %t1773, i8* %t1772
  %t1776 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1777 = icmp eq i32 %t1714, 20
  %t1778 = select i1 %t1777, i8* %t1776, i8* %t1775
  %t1779 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1780 = icmp eq i32 %t1714, 21
  %t1781 = select i1 %t1780, i8* %t1779, i8* %t1778
  %t1782 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1783 = icmp eq i32 %t1714, 22
  %t1784 = select i1 %t1783, i8* %t1782, i8* %t1781
  %s1785 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1785, i32 0, i32 0
  %t1786 = icmp eq i8* %t1784, %s1785
  br i1 %t1786, label %then22, label %merge23
then22:
  %t1787 = extractvalue %Statement %statement, 0
  %t1788 = alloca %Statement
  store %Statement %statement, %Statement* %t1788
  %t1789 = getelementptr inbounds %Statement, %Statement* %t1788, i32 0, i32 1
  %t1790 = bitcast [48 x i8]* %t1789 to i8*
  %t1791 = bitcast i8* %t1790 to i8**
  %t1792 = load i8*, i8** %t1791
  %t1793 = icmp eq i32 %t1787, 2
  %t1794 = select i1 %t1793, i8* %t1792, i8* null
  %t1795 = getelementptr inbounds %Statement, %Statement* %t1788, i32 0, i32 1
  %t1796 = bitcast [48 x i8]* %t1795 to i8*
  %t1797 = bitcast i8* %t1796 to i8**
  %t1798 = load i8*, i8** %t1797
  %t1799 = icmp eq i32 %t1787, 3
  %t1800 = select i1 %t1799, i8* %t1798, i8* %t1794
  %t1801 = getelementptr inbounds %Statement, %Statement* %t1788, i32 0, i32 1
  %t1802 = bitcast [40 x i8]* %t1801 to i8*
  %t1803 = bitcast i8* %t1802 to i8**
  %t1804 = load i8*, i8** %t1803
  %t1805 = icmp eq i32 %t1787, 6
  %t1806 = select i1 %t1805, i8* %t1804, i8* %t1800
  %t1807 = getelementptr inbounds %Statement, %Statement* %t1788, i32 0, i32 1
  %t1808 = bitcast [56 x i8]* %t1807 to i8*
  %t1809 = bitcast i8* %t1808 to i8**
  %t1810 = load i8*, i8** %t1809
  %t1811 = icmp eq i32 %t1787, 8
  %t1812 = select i1 %t1811, i8* %t1810, i8* %t1806
  %t1813 = getelementptr inbounds %Statement, %Statement* %t1788, i32 0, i32 1
  %t1814 = bitcast [40 x i8]* %t1813 to i8*
  %t1815 = bitcast i8* %t1814 to i8**
  %t1816 = load i8*, i8** %t1815
  %t1817 = icmp eq i32 %t1787, 9
  %t1818 = select i1 %t1817, i8* %t1816, i8* %t1812
  %t1819 = getelementptr inbounds %Statement, %Statement* %t1788, i32 0, i32 1
  %t1820 = bitcast [40 x i8]* %t1819 to i8*
  %t1821 = bitcast i8* %t1820 to i8**
  %t1822 = load i8*, i8** %t1821
  %t1823 = icmp eq i32 %t1787, 10
  %t1824 = select i1 %t1823, i8* %t1822, i8* %t1818
  %t1825 = getelementptr inbounds %Statement, %Statement* %t1788, i32 0, i32 1
  %t1826 = bitcast [40 x i8]* %t1825 to i8*
  %t1827 = bitcast i8* %t1826 to i8**
  %t1828 = load i8*, i8** %t1827
  %t1829 = icmp eq i32 %t1787, 11
  %t1830 = select i1 %t1829, i8* %t1828, i8* %t1824
  %s1831 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1831, i32 0, i32 0
  %t1832 = extractvalue %Statement %statement, 0
  %t1833 = alloca %Statement
  store %Statement %statement, %Statement* %t1833
  %t1834 = getelementptr inbounds %Statement, %Statement* %t1833, i32 0, i32 1
  %t1835 = bitcast [48 x i8]* %t1834 to i8*
  %t1836 = getelementptr inbounds i8, i8* %t1835, i64 8
  %t1837 = bitcast i8* %t1836 to i8**
  %t1838 = load i8*, i8** %t1837
  %t1839 = icmp eq i32 %t1832, 3
  %t1840 = select i1 %t1839, i8* %t1838, i8* null
  %t1841 = getelementptr inbounds %Statement, %Statement* %t1833, i32 0, i32 1
  %t1842 = bitcast [40 x i8]* %t1841 to i8*
  %t1843 = getelementptr inbounds i8, i8* %t1842, i64 8
  %t1844 = bitcast i8* %t1843 to i8**
  %t1845 = load i8*, i8** %t1844
  %t1846 = icmp eq i32 %t1832, 6
  %t1847 = select i1 %t1846, i8* %t1845, i8* %t1840
  %t1848 = getelementptr inbounds %Statement, %Statement* %t1833, i32 0, i32 1
  %t1849 = bitcast [56 x i8]* %t1848 to i8*
  %t1850 = getelementptr inbounds i8, i8* %t1849, i64 8
  %t1851 = bitcast i8* %t1850 to i8**
  %t1852 = load i8*, i8** %t1851
  %t1853 = icmp eq i32 %t1832, 8
  %t1854 = select i1 %t1853, i8* %t1852, i8* %t1847
  %t1855 = getelementptr inbounds %Statement, %Statement* %t1833, i32 0, i32 1
  %t1856 = bitcast [40 x i8]* %t1855 to i8*
  %t1857 = getelementptr inbounds i8, i8* %t1856, i64 8
  %t1858 = bitcast i8* %t1857 to i8**
  %t1859 = load i8*, i8** %t1858
  %t1860 = icmp eq i32 %t1832, 9
  %t1861 = select i1 %t1860, i8* %t1859, i8* %t1854
  %t1862 = getelementptr inbounds %Statement, %Statement* %t1833, i32 0, i32 1
  %t1863 = bitcast [40 x i8]* %t1862 to i8*
  %t1864 = getelementptr inbounds i8, i8* %t1863, i64 8
  %t1865 = bitcast i8* %t1864 to i8**
  %t1866 = load i8*, i8** %t1865
  %t1867 = icmp eq i32 %t1832, 10
  %t1868 = select i1 %t1867, i8* %t1866, i8* %t1861
  %t1869 = getelementptr inbounds %Statement, %Statement* %t1833, i32 0, i32 1
  %t1870 = bitcast [40 x i8]* %t1869 to i8*
  %t1871 = getelementptr inbounds i8, i8* %t1870, i64 8
  %t1872 = bitcast i8* %t1871 to i8**
  %t1873 = load i8*, i8** %t1872
  %t1874 = icmp eq i32 %t1832, 11
  %t1875 = select i1 %t1874, i8* %t1873, i8* %t1868
  %t1876 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1830, i8* %s1831, i8* %t1875)
  store %ScopeResult %t1876, %ScopeResult* %l17
  %t1877 = load %ScopeResult, %ScopeResult* %l17
  %t1878 = extractvalue %ScopeResult %t1877, 1
  %t1879 = extractvalue %Statement %statement, 0
  %t1880 = alloca %Statement
  store %Statement %statement, %Statement* %t1880
  %t1881 = getelementptr inbounds %Statement, %Statement* %t1880, i32 0, i32 1
  %t1882 = bitcast [24 x i8]* %t1881 to i8*
  %t1883 = getelementptr inbounds i8, i8* %t1882, i64 8
  %t1884 = bitcast i8* %t1883 to i8**
  %t1885 = load i8*, i8** %t1884
  %t1886 = icmp eq i32 %t1879, 4
  %t1887 = select i1 %t1886, i8* %t1885, i8* null
  %t1888 = getelementptr inbounds %Statement, %Statement* %t1880, i32 0, i32 1
  %t1889 = bitcast [24 x i8]* %t1888 to i8*
  %t1890 = getelementptr inbounds i8, i8* %t1889, i64 8
  %t1891 = bitcast i8* %t1890 to i8**
  %t1892 = load i8*, i8** %t1891
  %t1893 = icmp eq i32 %t1879, 5
  %t1894 = select i1 %t1893, i8* %t1892, i8* %t1887
  %t1895 = getelementptr inbounds %Statement, %Statement* %t1880, i32 0, i32 1
  %t1896 = bitcast [40 x i8]* %t1895 to i8*
  %t1897 = getelementptr inbounds i8, i8* %t1896, i64 16
  %t1898 = bitcast i8* %t1897 to i8**
  %t1899 = load i8*, i8** %t1898
  %t1900 = icmp eq i32 %t1879, 6
  %t1901 = select i1 %t1900, i8* %t1899, i8* %t1894
  %t1902 = getelementptr inbounds %Statement, %Statement* %t1880, i32 0, i32 1
  %t1903 = bitcast [24 x i8]* %t1902 to i8*
  %t1904 = getelementptr inbounds i8, i8* %t1903, i64 8
  %t1905 = bitcast i8* %t1904 to i8**
  %t1906 = load i8*, i8** %t1905
  %t1907 = icmp eq i32 %t1879, 7
  %t1908 = select i1 %t1907, i8* %t1906, i8* %t1901
  %t1909 = getelementptr inbounds %Statement, %Statement* %t1880, i32 0, i32 1
  %t1910 = bitcast [40 x i8]* %t1909 to i8*
  %t1911 = getelementptr inbounds i8, i8* %t1910, i64 24
  %t1912 = bitcast i8* %t1911 to i8**
  %t1913 = load i8*, i8** %t1912
  %t1914 = icmp eq i32 %t1879, 12
  %t1915 = select i1 %t1914, i8* %t1913, i8* %t1908
  %t1916 = getelementptr inbounds %Statement, %Statement* %t1880, i32 0, i32 1
  %t1917 = bitcast [24 x i8]* %t1916 to i8*
  %t1918 = getelementptr inbounds i8, i8* %t1917, i64 8
  %t1919 = bitcast i8* %t1918 to i8**
  %t1920 = load i8*, i8** %t1919
  %t1921 = icmp eq i32 %t1879, 13
  %t1922 = select i1 %t1921, i8* %t1920, i8* %t1915
  %t1923 = getelementptr inbounds %Statement, %Statement* %t1880, i32 0, i32 1
  %t1924 = bitcast [24 x i8]* %t1923 to i8*
  %t1925 = getelementptr inbounds i8, i8* %t1924, i64 8
  %t1926 = bitcast i8* %t1925 to i8**
  %t1927 = load i8*, i8** %t1926
  %t1928 = icmp eq i32 %t1879, 14
  %t1929 = select i1 %t1928, i8* %t1927, i8* %t1922
  %t1930 = getelementptr inbounds %Statement, %Statement* %t1880, i32 0, i32 1
  %t1931 = bitcast [16 x i8]* %t1930 to i8*
  %t1932 = bitcast i8* %t1931 to i8**
  %t1933 = load i8*, i8** %t1932
  %t1934 = icmp eq i32 %t1879, 15
  %t1935 = select i1 %t1934, i8* %t1933, i8* %t1929
  %t1936 = alloca [0 x double]
  %t1937 = getelementptr [0 x double], [0 x double]* %t1936, i32 0, i32 0
  %t1938 = alloca { double*, i64 }
  %t1939 = getelementptr { double*, i64 }, { double*, i64 }* %t1938, i32 0, i32 0
  store double* %t1937, double** %t1939
  %t1940 = getelementptr { double*, i64 }, { double*, i64 }* %t1938, i32 0, i32 1
  store i64 0, i64* %t1940
  %t1941 = bitcast { double*, i64 }* %t1938 to { %SymbolEntry*, i64 }*
  %t1942 = call { %Diagnostic*, i64 }* @check_block(%Block zeroinitializer, { %SymbolEntry*, i64 }* %t1941, { %Statement*, i64 }* %interfaces)
  %t1943 = bitcast { %Diagnostic*, i64 }* %t1942 to { i8**, i64 }*
  %t1944 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1878, { i8**, i64 }* %t1943)
  store { i8**, i64 }* %t1944, { i8**, i64 }** %l18
  %t1945 = load %ScopeResult, %ScopeResult* %l17
  %t1946 = extractvalue %ScopeResult %t1945, 0
  %t1947 = insertvalue %ScopeResult undef, { i8**, i64 }* %t1946, 0
  %t1948 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t1949 = insertvalue %ScopeResult %t1947, { i8**, i64 }* %t1948, 1
  ret %ScopeResult %t1949
merge23:
  %t1950 = extractvalue %Statement %statement, 0
  %t1951 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1952 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1953 = icmp eq i32 %t1950, 0
  %t1954 = select i1 %t1953, i8* %t1952, i8* %t1951
  %t1955 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1956 = icmp eq i32 %t1950, 1
  %t1957 = select i1 %t1956, i8* %t1955, i8* %t1954
  %t1958 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1959 = icmp eq i32 %t1950, 2
  %t1960 = select i1 %t1959, i8* %t1958, i8* %t1957
  %t1961 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1962 = icmp eq i32 %t1950, 3
  %t1963 = select i1 %t1962, i8* %t1961, i8* %t1960
  %t1964 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1965 = icmp eq i32 %t1950, 4
  %t1966 = select i1 %t1965, i8* %t1964, i8* %t1963
  %t1967 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1968 = icmp eq i32 %t1950, 5
  %t1969 = select i1 %t1968, i8* %t1967, i8* %t1966
  %t1970 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1971 = icmp eq i32 %t1950, 6
  %t1972 = select i1 %t1971, i8* %t1970, i8* %t1969
  %t1973 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1974 = icmp eq i32 %t1950, 7
  %t1975 = select i1 %t1974, i8* %t1973, i8* %t1972
  %t1976 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1977 = icmp eq i32 %t1950, 8
  %t1978 = select i1 %t1977, i8* %t1976, i8* %t1975
  %t1979 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1980 = icmp eq i32 %t1950, 9
  %t1981 = select i1 %t1980, i8* %t1979, i8* %t1978
  %t1982 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1983 = icmp eq i32 %t1950, 10
  %t1984 = select i1 %t1983, i8* %t1982, i8* %t1981
  %t1985 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1986 = icmp eq i32 %t1950, 11
  %t1987 = select i1 %t1986, i8* %t1985, i8* %t1984
  %t1988 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1989 = icmp eq i32 %t1950, 12
  %t1990 = select i1 %t1989, i8* %t1988, i8* %t1987
  %t1991 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1992 = icmp eq i32 %t1950, 13
  %t1993 = select i1 %t1992, i8* %t1991, i8* %t1990
  %t1994 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1995 = icmp eq i32 %t1950, 14
  %t1996 = select i1 %t1995, i8* %t1994, i8* %t1993
  %t1997 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1998 = icmp eq i32 %t1950, 15
  %t1999 = select i1 %t1998, i8* %t1997, i8* %t1996
  %t2000 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2001 = icmp eq i32 %t1950, 16
  %t2002 = select i1 %t2001, i8* %t2000, i8* %t1999
  %t2003 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2004 = icmp eq i32 %t1950, 17
  %t2005 = select i1 %t2004, i8* %t2003, i8* %t2002
  %t2006 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2007 = icmp eq i32 %t1950, 18
  %t2008 = select i1 %t2007, i8* %t2006, i8* %t2005
  %t2009 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2010 = icmp eq i32 %t1950, 19
  %t2011 = select i1 %t2010, i8* %t2009, i8* %t2008
  %t2012 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2013 = icmp eq i32 %t1950, 20
  %t2014 = select i1 %t2013, i8* %t2012, i8* %t2011
  %t2015 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2016 = icmp eq i32 %t1950, 21
  %t2017 = select i1 %t2016, i8* %t2015, i8* %t2014
  %t2018 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2019 = icmp eq i32 %t1950, 22
  %t2020 = select i1 %t2019, i8* %t2018, i8* %t2017
  %s2021 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.2021, i32 0, i32 0
  %t2022 = icmp eq i8* %t2020, %s2021
  br i1 %t2022, label %then24, label %merge25
then24:
  %t2023 = bitcast { %SymbolEntry*, i64 }* %bindings to { i8**, i64 }*
  %t2024 = insertvalue %ScopeResult undef, { i8**, i64 }* %t2023, 0
  %t2025 = extractvalue %Statement %statement, 0
  %t2026 = alloca %Statement
  store %Statement %statement, %Statement* %t2026
  %t2027 = getelementptr inbounds %Statement, %Statement* %t2026, i32 0, i32 1
  %t2028 = bitcast [24 x i8]* %t2027 to i8*
  %t2029 = getelementptr inbounds i8, i8* %t2028, i64 8
  %t2030 = bitcast i8* %t2029 to i8**
  %t2031 = load i8*, i8** %t2030
  %t2032 = icmp eq i32 %t2025, 4
  %t2033 = select i1 %t2032, i8* %t2031, i8* null
  %t2034 = getelementptr inbounds %Statement, %Statement* %t2026, i32 0, i32 1
  %t2035 = bitcast [24 x i8]* %t2034 to i8*
  %t2036 = getelementptr inbounds i8, i8* %t2035, i64 8
  %t2037 = bitcast i8* %t2036 to i8**
  %t2038 = load i8*, i8** %t2037
  %t2039 = icmp eq i32 %t2025, 5
  %t2040 = select i1 %t2039, i8* %t2038, i8* %t2033
  %t2041 = getelementptr inbounds %Statement, %Statement* %t2026, i32 0, i32 1
  %t2042 = bitcast [40 x i8]* %t2041 to i8*
  %t2043 = getelementptr inbounds i8, i8* %t2042, i64 16
  %t2044 = bitcast i8* %t2043 to i8**
  %t2045 = load i8*, i8** %t2044
  %t2046 = icmp eq i32 %t2025, 6
  %t2047 = select i1 %t2046, i8* %t2045, i8* %t2040
  %t2048 = getelementptr inbounds %Statement, %Statement* %t2026, i32 0, i32 1
  %t2049 = bitcast [24 x i8]* %t2048 to i8*
  %t2050 = getelementptr inbounds i8, i8* %t2049, i64 8
  %t2051 = bitcast i8* %t2050 to i8**
  %t2052 = load i8*, i8** %t2051
  %t2053 = icmp eq i32 %t2025, 7
  %t2054 = select i1 %t2053, i8* %t2052, i8* %t2047
  %t2055 = getelementptr inbounds %Statement, %Statement* %t2026, i32 0, i32 1
  %t2056 = bitcast [40 x i8]* %t2055 to i8*
  %t2057 = getelementptr inbounds i8, i8* %t2056, i64 24
  %t2058 = bitcast i8* %t2057 to i8**
  %t2059 = load i8*, i8** %t2058
  %t2060 = icmp eq i32 %t2025, 12
  %t2061 = select i1 %t2060, i8* %t2059, i8* %t2054
  %t2062 = getelementptr inbounds %Statement, %Statement* %t2026, i32 0, i32 1
  %t2063 = bitcast [24 x i8]* %t2062 to i8*
  %t2064 = getelementptr inbounds i8, i8* %t2063, i64 8
  %t2065 = bitcast i8* %t2064 to i8**
  %t2066 = load i8*, i8** %t2065
  %t2067 = icmp eq i32 %t2025, 13
  %t2068 = select i1 %t2067, i8* %t2066, i8* %t2061
  %t2069 = getelementptr inbounds %Statement, %Statement* %t2026, i32 0, i32 1
  %t2070 = bitcast [24 x i8]* %t2069 to i8*
  %t2071 = getelementptr inbounds i8, i8* %t2070, i64 8
  %t2072 = bitcast i8* %t2071 to i8**
  %t2073 = load i8*, i8** %t2072
  %t2074 = icmp eq i32 %t2025, 14
  %t2075 = select i1 %t2074, i8* %t2073, i8* %t2068
  %t2076 = getelementptr inbounds %Statement, %Statement* %t2026, i32 0, i32 1
  %t2077 = bitcast [16 x i8]* %t2076 to i8*
  %t2078 = bitcast i8* %t2077 to i8**
  %t2079 = load i8*, i8** %t2078
  %t2080 = icmp eq i32 %t2025, 15
  %t2081 = select i1 %t2080, i8* %t2079, i8* %t2075
  %t2082 = call { %Diagnostic*, i64 }* @check_block(%Block zeroinitializer, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2083 = bitcast { %Diagnostic*, i64 }* %t2082 to { i8**, i64 }*
  %t2084 = insertvalue %ScopeResult %t2024, { i8**, i64 }* %t2083, 1
  ret %ScopeResult %t2084
merge25:
  %t2085 = extractvalue %Statement %statement, 0
  %t2086 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2087 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2088 = icmp eq i32 %t2085, 0
  %t2089 = select i1 %t2088, i8* %t2087, i8* %t2086
  %t2090 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2091 = icmp eq i32 %t2085, 1
  %t2092 = select i1 %t2091, i8* %t2090, i8* %t2089
  %t2093 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2094 = icmp eq i32 %t2085, 2
  %t2095 = select i1 %t2094, i8* %t2093, i8* %t2092
  %t2096 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2097 = icmp eq i32 %t2085, 3
  %t2098 = select i1 %t2097, i8* %t2096, i8* %t2095
  %t2099 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2100 = icmp eq i32 %t2085, 4
  %t2101 = select i1 %t2100, i8* %t2099, i8* %t2098
  %t2102 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2103 = icmp eq i32 %t2085, 5
  %t2104 = select i1 %t2103, i8* %t2102, i8* %t2101
  %t2105 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2106 = icmp eq i32 %t2085, 6
  %t2107 = select i1 %t2106, i8* %t2105, i8* %t2104
  %t2108 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2109 = icmp eq i32 %t2085, 7
  %t2110 = select i1 %t2109, i8* %t2108, i8* %t2107
  %t2111 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2112 = icmp eq i32 %t2085, 8
  %t2113 = select i1 %t2112, i8* %t2111, i8* %t2110
  %t2114 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2115 = icmp eq i32 %t2085, 9
  %t2116 = select i1 %t2115, i8* %t2114, i8* %t2113
  %t2117 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2118 = icmp eq i32 %t2085, 10
  %t2119 = select i1 %t2118, i8* %t2117, i8* %t2116
  %t2120 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2121 = icmp eq i32 %t2085, 11
  %t2122 = select i1 %t2121, i8* %t2120, i8* %t2119
  %t2123 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2124 = icmp eq i32 %t2085, 12
  %t2125 = select i1 %t2124, i8* %t2123, i8* %t2122
  %t2126 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2127 = icmp eq i32 %t2085, 13
  %t2128 = select i1 %t2127, i8* %t2126, i8* %t2125
  %t2129 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2130 = icmp eq i32 %t2085, 14
  %t2131 = select i1 %t2130, i8* %t2129, i8* %t2128
  %t2132 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2133 = icmp eq i32 %t2085, 15
  %t2134 = select i1 %t2133, i8* %t2132, i8* %t2131
  %t2135 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2136 = icmp eq i32 %t2085, 16
  %t2137 = select i1 %t2136, i8* %t2135, i8* %t2134
  %t2138 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2139 = icmp eq i32 %t2085, 17
  %t2140 = select i1 %t2139, i8* %t2138, i8* %t2137
  %t2141 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2142 = icmp eq i32 %t2085, 18
  %t2143 = select i1 %t2142, i8* %t2141, i8* %t2140
  %t2144 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2145 = icmp eq i32 %t2085, 19
  %t2146 = select i1 %t2145, i8* %t2144, i8* %t2143
  %t2147 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2148 = icmp eq i32 %t2085, 20
  %t2149 = select i1 %t2148, i8* %t2147, i8* %t2146
  %t2150 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2151 = icmp eq i32 %t2085, 21
  %t2152 = select i1 %t2151, i8* %t2150, i8* %t2149
  %t2153 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2154 = icmp eq i32 %t2085, 22
  %t2155 = select i1 %t2154, i8* %t2153, i8* %t2152
  %s2156 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.2156, i32 0, i32 0
  %t2157 = icmp eq i8* %t2155, %s2156
  br i1 %t2157, label %then26, label %merge27
then26:
  %t2158 = bitcast { %SymbolEntry*, i64 }* %bindings to { i8**, i64 }*
  %t2159 = insertvalue %ScopeResult undef, { i8**, i64 }* %t2158, 0
  %t2160 = extractvalue %Statement %statement, 0
  %t2161 = alloca %Statement
  store %Statement %statement, %Statement* %t2161
  %t2162 = getelementptr inbounds %Statement, %Statement* %t2161, i32 0, i32 1
  %t2163 = bitcast [24 x i8]* %t2162 to i8*
  %t2164 = getelementptr inbounds i8, i8* %t2163, i64 8
  %t2165 = bitcast i8* %t2164 to i8**
  %t2166 = load i8*, i8** %t2165
  %t2167 = icmp eq i32 %t2160, 4
  %t2168 = select i1 %t2167, i8* %t2166, i8* null
  %t2169 = getelementptr inbounds %Statement, %Statement* %t2161, i32 0, i32 1
  %t2170 = bitcast [24 x i8]* %t2169 to i8*
  %t2171 = getelementptr inbounds i8, i8* %t2170, i64 8
  %t2172 = bitcast i8* %t2171 to i8**
  %t2173 = load i8*, i8** %t2172
  %t2174 = icmp eq i32 %t2160, 5
  %t2175 = select i1 %t2174, i8* %t2173, i8* %t2168
  %t2176 = getelementptr inbounds %Statement, %Statement* %t2161, i32 0, i32 1
  %t2177 = bitcast [40 x i8]* %t2176 to i8*
  %t2178 = getelementptr inbounds i8, i8* %t2177, i64 16
  %t2179 = bitcast i8* %t2178 to i8**
  %t2180 = load i8*, i8** %t2179
  %t2181 = icmp eq i32 %t2160, 6
  %t2182 = select i1 %t2181, i8* %t2180, i8* %t2175
  %t2183 = getelementptr inbounds %Statement, %Statement* %t2161, i32 0, i32 1
  %t2184 = bitcast [24 x i8]* %t2183 to i8*
  %t2185 = getelementptr inbounds i8, i8* %t2184, i64 8
  %t2186 = bitcast i8* %t2185 to i8**
  %t2187 = load i8*, i8** %t2186
  %t2188 = icmp eq i32 %t2160, 7
  %t2189 = select i1 %t2188, i8* %t2187, i8* %t2182
  %t2190 = getelementptr inbounds %Statement, %Statement* %t2161, i32 0, i32 1
  %t2191 = bitcast [40 x i8]* %t2190 to i8*
  %t2192 = getelementptr inbounds i8, i8* %t2191, i64 24
  %t2193 = bitcast i8* %t2192 to i8**
  %t2194 = load i8*, i8** %t2193
  %t2195 = icmp eq i32 %t2160, 12
  %t2196 = select i1 %t2195, i8* %t2194, i8* %t2189
  %t2197 = getelementptr inbounds %Statement, %Statement* %t2161, i32 0, i32 1
  %t2198 = bitcast [24 x i8]* %t2197 to i8*
  %t2199 = getelementptr inbounds i8, i8* %t2198, i64 8
  %t2200 = bitcast i8* %t2199 to i8**
  %t2201 = load i8*, i8** %t2200
  %t2202 = icmp eq i32 %t2160, 13
  %t2203 = select i1 %t2202, i8* %t2201, i8* %t2196
  %t2204 = getelementptr inbounds %Statement, %Statement* %t2161, i32 0, i32 1
  %t2205 = bitcast [24 x i8]* %t2204 to i8*
  %t2206 = getelementptr inbounds i8, i8* %t2205, i64 8
  %t2207 = bitcast i8* %t2206 to i8**
  %t2208 = load i8*, i8** %t2207
  %t2209 = icmp eq i32 %t2160, 14
  %t2210 = select i1 %t2209, i8* %t2208, i8* %t2203
  %t2211 = getelementptr inbounds %Statement, %Statement* %t2161, i32 0, i32 1
  %t2212 = bitcast [16 x i8]* %t2211 to i8*
  %t2213 = bitcast i8* %t2212 to i8**
  %t2214 = load i8*, i8** %t2213
  %t2215 = icmp eq i32 %t2160, 15
  %t2216 = select i1 %t2215, i8* %t2214, i8* %t2210
  %t2217 = call { %Diagnostic*, i64 }* @check_block(%Block zeroinitializer, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2218 = bitcast { %Diagnostic*, i64 }* %t2217 to { i8**, i64 }*
  %t2219 = insertvalue %ScopeResult %t2159, { i8**, i64 }* %t2218, 1
  ret %ScopeResult %t2219
merge27:
  %t2220 = extractvalue %Statement %statement, 0
  %t2221 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2222 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2223 = icmp eq i32 %t2220, 0
  %t2224 = select i1 %t2223, i8* %t2222, i8* %t2221
  %t2225 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2226 = icmp eq i32 %t2220, 1
  %t2227 = select i1 %t2226, i8* %t2225, i8* %t2224
  %t2228 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2229 = icmp eq i32 %t2220, 2
  %t2230 = select i1 %t2229, i8* %t2228, i8* %t2227
  %t2231 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2232 = icmp eq i32 %t2220, 3
  %t2233 = select i1 %t2232, i8* %t2231, i8* %t2230
  %t2234 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2235 = icmp eq i32 %t2220, 4
  %t2236 = select i1 %t2235, i8* %t2234, i8* %t2233
  %t2237 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2238 = icmp eq i32 %t2220, 5
  %t2239 = select i1 %t2238, i8* %t2237, i8* %t2236
  %t2240 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2241 = icmp eq i32 %t2220, 6
  %t2242 = select i1 %t2241, i8* %t2240, i8* %t2239
  %t2243 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2244 = icmp eq i32 %t2220, 7
  %t2245 = select i1 %t2244, i8* %t2243, i8* %t2242
  %t2246 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2247 = icmp eq i32 %t2220, 8
  %t2248 = select i1 %t2247, i8* %t2246, i8* %t2245
  %t2249 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2250 = icmp eq i32 %t2220, 9
  %t2251 = select i1 %t2250, i8* %t2249, i8* %t2248
  %t2252 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2253 = icmp eq i32 %t2220, 10
  %t2254 = select i1 %t2253, i8* %t2252, i8* %t2251
  %t2255 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2256 = icmp eq i32 %t2220, 11
  %t2257 = select i1 %t2256, i8* %t2255, i8* %t2254
  %t2258 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2259 = icmp eq i32 %t2220, 12
  %t2260 = select i1 %t2259, i8* %t2258, i8* %t2257
  %t2261 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2262 = icmp eq i32 %t2220, 13
  %t2263 = select i1 %t2262, i8* %t2261, i8* %t2260
  %t2264 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2265 = icmp eq i32 %t2220, 14
  %t2266 = select i1 %t2265, i8* %t2264, i8* %t2263
  %t2267 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2268 = icmp eq i32 %t2220, 15
  %t2269 = select i1 %t2268, i8* %t2267, i8* %t2266
  %t2270 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2271 = icmp eq i32 %t2220, 16
  %t2272 = select i1 %t2271, i8* %t2270, i8* %t2269
  %t2273 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2274 = icmp eq i32 %t2220, 17
  %t2275 = select i1 %t2274, i8* %t2273, i8* %t2272
  %t2276 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2277 = icmp eq i32 %t2220, 18
  %t2278 = select i1 %t2277, i8* %t2276, i8* %t2275
  %t2279 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2280 = icmp eq i32 %t2220, 19
  %t2281 = select i1 %t2280, i8* %t2279, i8* %t2278
  %t2282 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2283 = icmp eq i32 %t2220, 20
  %t2284 = select i1 %t2283, i8* %t2282, i8* %t2281
  %t2285 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2286 = icmp eq i32 %t2220, 21
  %t2287 = select i1 %t2286, i8* %t2285, i8* %t2284
  %t2288 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2289 = icmp eq i32 %t2220, 22
  %t2290 = select i1 %t2289, i8* %t2288, i8* %t2287
  %s2291 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.2291, i32 0, i32 0
  %t2292 = icmp eq i8* %t2290, %s2291
  br i1 %t2292, label %then28, label %merge29
then28:
  %t2293 = alloca [0 x %Diagnostic]
  %t2294 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t2293, i32 0, i32 0
  %t2295 = alloca { %Diagnostic*, i64 }
  %t2296 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2295, i32 0, i32 0
  store %Diagnostic* %t2294, %Diagnostic** %t2296
  %t2297 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2295, i32 0, i32 1
  store i64 0, i64* %t2297
  store { %Diagnostic*, i64 }* %t2295, { %Diagnostic*, i64 }** %l19
  %t2298 = sitofp i64 0 to double
  store double %t2298, double* %l20
  %t2299 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2300 = load double, double* %l20
  br label %loop.header30
loop.header30:
  %t2341 = phi { %Diagnostic*, i64 }* [ %t2299, %then28 ], [ %t2339, %loop.latch32 ]
  %t2342 = phi double [ %t2300, %then28 ], [ %t2340, %loop.latch32 ]
  store { %Diagnostic*, i64 }* %t2341, { %Diagnostic*, i64 }** %l19
  store double %t2342, double* %l20
  br label %loop.body31
loop.body31:
  %t2301 = load double, double* %l20
  %t2302 = extractvalue %Statement %statement, 0
  %t2303 = alloca %Statement
  store %Statement %statement, %Statement* %t2303
  %t2304 = getelementptr inbounds %Statement, %Statement* %t2303, i32 0, i32 1
  %t2305 = bitcast [24 x i8]* %t2304 to i8*
  %t2306 = getelementptr inbounds i8, i8* %t2305, i64 8
  %t2307 = bitcast i8* %t2306 to { i8**, i64 }**
  %t2308 = load { i8**, i64 }*, { i8**, i64 }** %t2307
  %t2309 = icmp eq i32 %t2302, 18
  %t2310 = select i1 %t2309, { i8**, i64 }* %t2308, { i8**, i64 }* null
  %t2311 = load { i8**, i64 }, { i8**, i64 }* %t2310
  %t2312 = extractvalue { i8**, i64 } %t2311, 1
  %t2313 = sitofp i64 %t2312 to double
  %t2314 = fcmp oge double %t2301, %t2313
  %t2315 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2316 = load double, double* %l20
  br i1 %t2314, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t2317 = extractvalue %Statement %statement, 0
  %t2318 = alloca %Statement
  store %Statement %statement, %Statement* %t2318
  %t2319 = getelementptr inbounds %Statement, %Statement* %t2318, i32 0, i32 1
  %t2320 = bitcast [24 x i8]* %t2319 to i8*
  %t2321 = getelementptr inbounds i8, i8* %t2320, i64 8
  %t2322 = bitcast i8* %t2321 to { i8**, i64 }**
  %t2323 = load { i8**, i64 }*, { i8**, i64 }** %t2322
  %t2324 = icmp eq i32 %t2317, 18
  %t2325 = select i1 %t2324, { i8**, i64 }* %t2323, { i8**, i64 }* null
  %t2326 = load double, double* %l20
  %t2327 = fptosi double %t2326 to i64
  %t2328 = load { i8**, i64 }, { i8**, i64 }* %t2325
  %t2329 = extractvalue { i8**, i64 } %t2328, 0
  %t2330 = extractvalue { i8**, i64 } %t2328, 1
  %t2331 = icmp uge i64 %t2327, %t2330
  ; bounds check: %t2331 (if true, out of bounds)
  %t2332 = getelementptr i8*, i8** %t2329, i64 %t2327
  %t2333 = load i8*, i8** %t2332
  store i8* %t2333, i8** %l21
  %t2334 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2335 = load i8*, i8** %l21
  %t2336 = load double, double* %l20
  %t2337 = sitofp i64 1 to double
  %t2338 = fadd double %t2336, %t2337
  store double %t2338, double* %l20
  br label %loop.latch32
loop.latch32:
  %t2339 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2340 = load double, double* %l20
  br label %loop.header30
afterloop33:
  %t2343 = bitcast { %SymbolEntry*, i64 }* %bindings to { i8**, i64 }*
  %t2344 = insertvalue %ScopeResult undef, { i8**, i64 }* %t2343, 0
  %t2345 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2346 = bitcast { %Diagnostic*, i64 }* %t2345 to { i8**, i64 }*
  %t2347 = insertvalue %ScopeResult %t2344, { i8**, i64 }* %t2346, 1
  ret %ScopeResult %t2347
merge29:
  %t2348 = extractvalue %Statement %statement, 0
  %t2349 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2350 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2351 = icmp eq i32 %t2348, 0
  %t2352 = select i1 %t2351, i8* %t2350, i8* %t2349
  %t2353 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2354 = icmp eq i32 %t2348, 1
  %t2355 = select i1 %t2354, i8* %t2353, i8* %t2352
  %t2356 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2357 = icmp eq i32 %t2348, 2
  %t2358 = select i1 %t2357, i8* %t2356, i8* %t2355
  %t2359 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2360 = icmp eq i32 %t2348, 3
  %t2361 = select i1 %t2360, i8* %t2359, i8* %t2358
  %t2362 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2363 = icmp eq i32 %t2348, 4
  %t2364 = select i1 %t2363, i8* %t2362, i8* %t2361
  %t2365 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2366 = icmp eq i32 %t2348, 5
  %t2367 = select i1 %t2366, i8* %t2365, i8* %t2364
  %t2368 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2369 = icmp eq i32 %t2348, 6
  %t2370 = select i1 %t2369, i8* %t2368, i8* %t2367
  %t2371 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2372 = icmp eq i32 %t2348, 7
  %t2373 = select i1 %t2372, i8* %t2371, i8* %t2370
  %t2374 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2375 = icmp eq i32 %t2348, 8
  %t2376 = select i1 %t2375, i8* %t2374, i8* %t2373
  %t2377 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2378 = icmp eq i32 %t2348, 9
  %t2379 = select i1 %t2378, i8* %t2377, i8* %t2376
  %t2380 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2381 = icmp eq i32 %t2348, 10
  %t2382 = select i1 %t2381, i8* %t2380, i8* %t2379
  %t2383 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2384 = icmp eq i32 %t2348, 11
  %t2385 = select i1 %t2384, i8* %t2383, i8* %t2382
  %t2386 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2387 = icmp eq i32 %t2348, 12
  %t2388 = select i1 %t2387, i8* %t2386, i8* %t2385
  %t2389 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2390 = icmp eq i32 %t2348, 13
  %t2391 = select i1 %t2390, i8* %t2389, i8* %t2388
  %t2392 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2393 = icmp eq i32 %t2348, 14
  %t2394 = select i1 %t2393, i8* %t2392, i8* %t2391
  %t2395 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2396 = icmp eq i32 %t2348, 15
  %t2397 = select i1 %t2396, i8* %t2395, i8* %t2394
  %t2398 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2399 = icmp eq i32 %t2348, 16
  %t2400 = select i1 %t2399, i8* %t2398, i8* %t2397
  %t2401 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2402 = icmp eq i32 %t2348, 17
  %t2403 = select i1 %t2402, i8* %t2401, i8* %t2400
  %t2404 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2405 = icmp eq i32 %t2348, 18
  %t2406 = select i1 %t2405, i8* %t2404, i8* %t2403
  %t2407 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2408 = icmp eq i32 %t2348, 19
  %t2409 = select i1 %t2408, i8* %t2407, i8* %t2406
  %t2410 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2411 = icmp eq i32 %t2348, 20
  %t2412 = select i1 %t2411, i8* %t2410, i8* %t2409
  %t2413 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2414 = icmp eq i32 %t2348, 21
  %t2415 = select i1 %t2414, i8* %t2413, i8* %t2412
  %t2416 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2417 = icmp eq i32 %t2348, 22
  %t2418 = select i1 %t2417, i8* %t2416, i8* %t2415
  %s2419 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.2419, i32 0, i32 0
  %t2420 = icmp eq i8* %t2418, %s2419
  br i1 %t2420, label %then36, label %merge37
then36:
  %t2421 = extractvalue %Statement %statement, 0
  %t2422 = alloca %Statement
  store %Statement %statement, %Statement* %t2422
  %t2423 = getelementptr inbounds %Statement, %Statement* %t2422, i32 0, i32 1
  %t2424 = bitcast [32 x i8]* %t2423 to i8*
  %t2425 = getelementptr inbounds i8, i8* %t2424, i64 8
  %t2426 = bitcast i8* %t2425 to i8**
  %t2427 = load i8*, i8** %t2426
  %t2428 = icmp eq i32 %t2421, 19
  %t2429 = select i1 %t2428, i8* %t2427, i8* null
  %t2430 = call { %Diagnostic*, i64 }* @check_block(%Block zeroinitializer, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t2430, { %Diagnostic*, i64 }** %l22
  %t2431 = extractvalue %Statement %statement, 0
  %t2432 = alloca %Statement
  store %Statement %statement, %Statement* %t2432
  %t2433 = getelementptr inbounds %Statement, %Statement* %t2432, i32 0, i32 1
  %t2434 = bitcast [32 x i8]* %t2433 to i8*
  %t2435 = getelementptr inbounds i8, i8* %t2434, i64 16
  %t2436 = bitcast i8* %t2435 to i8**
  %t2437 = load i8*, i8** %t2436
  %t2438 = icmp eq i32 %t2431, 19
  %t2439 = select i1 %t2438, i8* %t2437, i8* null
  %t2440 = icmp ne i8* %t2439, null
  %t2441 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br i1 %t2440, label %then38, label %merge39
then38:
  %t2442 = extractvalue %Statement %statement, 0
  %t2443 = alloca %Statement
  store %Statement %statement, %Statement* %t2443
  %t2444 = getelementptr inbounds %Statement, %Statement* %t2443, i32 0, i32 1
  %t2445 = bitcast [32 x i8]* %t2444 to i8*
  %t2446 = getelementptr inbounds i8, i8* %t2445, i64 16
  %t2447 = bitcast i8* %t2446 to i8**
  %t2448 = load i8*, i8** %t2447
  %t2449 = icmp eq i32 %t2442, 19
  %t2450 = select i1 %t2449, i8* %t2448, i8* null
  store i8* %t2450, i8** %l23
  %t2451 = load i8*, i8** %l23
  %t2452 = load i8*, i8** %l23
  br label %merge39
merge39:
  %t2453 = bitcast { %SymbolEntry*, i64 }* %bindings to { i8**, i64 }*
  %t2454 = insertvalue %ScopeResult undef, { i8**, i64 }* %t2453, 0
  %t2455 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2456 = bitcast { %Diagnostic*, i64 }* %t2455 to { i8**, i64 }*
  %t2457 = insertvalue %ScopeResult %t2454, { i8**, i64 }* %t2456, 1
  ret %ScopeResult %t2457
merge37:
  %t2458 = extractvalue %Statement %statement, 0
  %t2459 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2460 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2461 = icmp eq i32 %t2458, 0
  %t2462 = select i1 %t2461, i8* %t2460, i8* %t2459
  %t2463 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2464 = icmp eq i32 %t2458, 1
  %t2465 = select i1 %t2464, i8* %t2463, i8* %t2462
  %t2466 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2467 = icmp eq i32 %t2458, 2
  %t2468 = select i1 %t2467, i8* %t2466, i8* %t2465
  %t2469 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2470 = icmp eq i32 %t2458, 3
  %t2471 = select i1 %t2470, i8* %t2469, i8* %t2468
  %t2472 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2473 = icmp eq i32 %t2458, 4
  %t2474 = select i1 %t2473, i8* %t2472, i8* %t2471
  %t2475 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2476 = icmp eq i32 %t2458, 5
  %t2477 = select i1 %t2476, i8* %t2475, i8* %t2474
  %t2478 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2479 = icmp eq i32 %t2458, 6
  %t2480 = select i1 %t2479, i8* %t2478, i8* %t2477
  %t2481 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2482 = icmp eq i32 %t2458, 7
  %t2483 = select i1 %t2482, i8* %t2481, i8* %t2480
  %t2484 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2485 = icmp eq i32 %t2458, 8
  %t2486 = select i1 %t2485, i8* %t2484, i8* %t2483
  %t2487 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2488 = icmp eq i32 %t2458, 9
  %t2489 = select i1 %t2488, i8* %t2487, i8* %t2486
  %t2490 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2491 = icmp eq i32 %t2458, 10
  %t2492 = select i1 %t2491, i8* %t2490, i8* %t2489
  %t2493 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2494 = icmp eq i32 %t2458, 11
  %t2495 = select i1 %t2494, i8* %t2493, i8* %t2492
  %t2496 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2497 = icmp eq i32 %t2458, 12
  %t2498 = select i1 %t2497, i8* %t2496, i8* %t2495
  %t2499 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2500 = icmp eq i32 %t2458, 13
  %t2501 = select i1 %t2500, i8* %t2499, i8* %t2498
  %t2502 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2503 = icmp eq i32 %t2458, 14
  %t2504 = select i1 %t2503, i8* %t2502, i8* %t2501
  %t2505 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2506 = icmp eq i32 %t2458, 15
  %t2507 = select i1 %t2506, i8* %t2505, i8* %t2504
  %t2508 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2509 = icmp eq i32 %t2458, 16
  %t2510 = select i1 %t2509, i8* %t2508, i8* %t2507
  %t2511 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2512 = icmp eq i32 %t2458, 17
  %t2513 = select i1 %t2512, i8* %t2511, i8* %t2510
  %t2514 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2515 = icmp eq i32 %t2458, 18
  %t2516 = select i1 %t2515, i8* %t2514, i8* %t2513
  %t2517 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2518 = icmp eq i32 %t2458, 19
  %t2519 = select i1 %t2518, i8* %t2517, i8* %t2516
  %t2520 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2521 = icmp eq i32 %t2458, 20
  %t2522 = select i1 %t2521, i8* %t2520, i8* %t2519
  %t2523 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2524 = icmp eq i32 %t2458, 21
  %t2525 = select i1 %t2524, i8* %t2523, i8* %t2522
  %t2526 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2527 = icmp eq i32 %t2458, 22
  %t2528 = select i1 %t2527, i8* %t2526, i8* %t2525
  %s2529 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.2529, i32 0, i32 0
  %t2530 = icmp eq i8* %t2528, %s2529
  br i1 %t2530, label %then40, label %merge41
then40:
  %t2531 = bitcast { %SymbolEntry*, i64 }* %bindings to { i8**, i64 }*
  %t2532 = insertvalue %ScopeResult undef, { i8**, i64 }* %t2531, 0
  %t2533 = extractvalue %Statement %statement, 0
  %t2534 = alloca %Statement
  store %Statement %statement, %Statement* %t2534
  %t2535 = getelementptr inbounds %Statement, %Statement* %t2534, i32 0, i32 1
  %t2536 = bitcast [24 x i8]* %t2535 to i8*
  %t2537 = getelementptr inbounds i8, i8* %t2536, i64 8
  %t2538 = bitcast i8* %t2537 to i8**
  %t2539 = load i8*, i8** %t2538
  %t2540 = icmp eq i32 %t2533, 4
  %t2541 = select i1 %t2540, i8* %t2539, i8* null
  %t2542 = getelementptr inbounds %Statement, %Statement* %t2534, i32 0, i32 1
  %t2543 = bitcast [24 x i8]* %t2542 to i8*
  %t2544 = getelementptr inbounds i8, i8* %t2543, i64 8
  %t2545 = bitcast i8* %t2544 to i8**
  %t2546 = load i8*, i8** %t2545
  %t2547 = icmp eq i32 %t2533, 5
  %t2548 = select i1 %t2547, i8* %t2546, i8* %t2541
  %t2549 = getelementptr inbounds %Statement, %Statement* %t2534, i32 0, i32 1
  %t2550 = bitcast [40 x i8]* %t2549 to i8*
  %t2551 = getelementptr inbounds i8, i8* %t2550, i64 16
  %t2552 = bitcast i8* %t2551 to i8**
  %t2553 = load i8*, i8** %t2552
  %t2554 = icmp eq i32 %t2533, 6
  %t2555 = select i1 %t2554, i8* %t2553, i8* %t2548
  %t2556 = getelementptr inbounds %Statement, %Statement* %t2534, i32 0, i32 1
  %t2557 = bitcast [24 x i8]* %t2556 to i8*
  %t2558 = getelementptr inbounds i8, i8* %t2557, i64 8
  %t2559 = bitcast i8* %t2558 to i8**
  %t2560 = load i8*, i8** %t2559
  %t2561 = icmp eq i32 %t2533, 7
  %t2562 = select i1 %t2561, i8* %t2560, i8* %t2555
  %t2563 = getelementptr inbounds %Statement, %Statement* %t2534, i32 0, i32 1
  %t2564 = bitcast [40 x i8]* %t2563 to i8*
  %t2565 = getelementptr inbounds i8, i8* %t2564, i64 24
  %t2566 = bitcast i8* %t2565 to i8**
  %t2567 = load i8*, i8** %t2566
  %t2568 = icmp eq i32 %t2533, 12
  %t2569 = select i1 %t2568, i8* %t2567, i8* %t2562
  %t2570 = getelementptr inbounds %Statement, %Statement* %t2534, i32 0, i32 1
  %t2571 = bitcast [24 x i8]* %t2570 to i8*
  %t2572 = getelementptr inbounds i8, i8* %t2571, i64 8
  %t2573 = bitcast i8* %t2572 to i8**
  %t2574 = load i8*, i8** %t2573
  %t2575 = icmp eq i32 %t2533, 13
  %t2576 = select i1 %t2575, i8* %t2574, i8* %t2569
  %t2577 = getelementptr inbounds %Statement, %Statement* %t2534, i32 0, i32 1
  %t2578 = bitcast [24 x i8]* %t2577 to i8*
  %t2579 = getelementptr inbounds i8, i8* %t2578, i64 8
  %t2580 = bitcast i8* %t2579 to i8**
  %t2581 = load i8*, i8** %t2580
  %t2582 = icmp eq i32 %t2533, 14
  %t2583 = select i1 %t2582, i8* %t2581, i8* %t2576
  %t2584 = getelementptr inbounds %Statement, %Statement* %t2534, i32 0, i32 1
  %t2585 = bitcast [16 x i8]* %t2584 to i8*
  %t2586 = bitcast i8* %t2585 to i8**
  %t2587 = load i8*, i8** %t2586
  %t2588 = icmp eq i32 %t2533, 15
  %t2589 = select i1 %t2588, i8* %t2587, i8* %t2583
  %t2590 = call { %Diagnostic*, i64 }* @check_block(%Block zeroinitializer, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2591 = bitcast { %Diagnostic*, i64 }* %t2590 to { i8**, i64 }*
  %t2592 = insertvalue %ScopeResult %t2532, { i8**, i64 }* %t2591, 1
  ret %ScopeResult %t2592
merge41:
  %t2593 = extractvalue %Statement %statement, 0
  %t2594 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2595 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2596 = icmp eq i32 %t2593, 0
  %t2597 = select i1 %t2596, i8* %t2595, i8* %t2594
  %t2598 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2599 = icmp eq i32 %t2593, 1
  %t2600 = select i1 %t2599, i8* %t2598, i8* %t2597
  %t2601 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2602 = icmp eq i32 %t2593, 2
  %t2603 = select i1 %t2602, i8* %t2601, i8* %t2600
  %t2604 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2605 = icmp eq i32 %t2593, 3
  %t2606 = select i1 %t2605, i8* %t2604, i8* %t2603
  %t2607 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2608 = icmp eq i32 %t2593, 4
  %t2609 = select i1 %t2608, i8* %t2607, i8* %t2606
  %t2610 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2611 = icmp eq i32 %t2593, 5
  %t2612 = select i1 %t2611, i8* %t2610, i8* %t2609
  %t2613 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2614 = icmp eq i32 %t2593, 6
  %t2615 = select i1 %t2614, i8* %t2613, i8* %t2612
  %t2616 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2617 = icmp eq i32 %t2593, 7
  %t2618 = select i1 %t2617, i8* %t2616, i8* %t2615
  %t2619 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2620 = icmp eq i32 %t2593, 8
  %t2621 = select i1 %t2620, i8* %t2619, i8* %t2618
  %t2622 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2623 = icmp eq i32 %t2593, 9
  %t2624 = select i1 %t2623, i8* %t2622, i8* %t2621
  %t2625 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2626 = icmp eq i32 %t2593, 10
  %t2627 = select i1 %t2626, i8* %t2625, i8* %t2624
  %t2628 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2629 = icmp eq i32 %t2593, 11
  %t2630 = select i1 %t2629, i8* %t2628, i8* %t2627
  %t2631 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2632 = icmp eq i32 %t2593, 12
  %t2633 = select i1 %t2632, i8* %t2631, i8* %t2630
  %t2634 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2635 = icmp eq i32 %t2593, 13
  %t2636 = select i1 %t2635, i8* %t2634, i8* %t2633
  %t2637 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2638 = icmp eq i32 %t2593, 14
  %t2639 = select i1 %t2638, i8* %t2637, i8* %t2636
  %t2640 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2641 = icmp eq i32 %t2593, 15
  %t2642 = select i1 %t2641, i8* %t2640, i8* %t2639
  %t2643 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2644 = icmp eq i32 %t2593, 16
  %t2645 = select i1 %t2644, i8* %t2643, i8* %t2642
  %t2646 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2647 = icmp eq i32 %t2593, 17
  %t2648 = select i1 %t2647, i8* %t2646, i8* %t2645
  %t2649 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2650 = icmp eq i32 %t2593, 18
  %t2651 = select i1 %t2650, i8* %t2649, i8* %t2648
  %t2652 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2653 = icmp eq i32 %t2593, 19
  %t2654 = select i1 %t2653, i8* %t2652, i8* %t2651
  %t2655 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2656 = icmp eq i32 %t2593, 20
  %t2657 = select i1 %t2656, i8* %t2655, i8* %t2654
  %t2658 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2659 = icmp eq i32 %t2593, 21
  %t2660 = select i1 %t2659, i8* %t2658, i8* %t2657
  %t2661 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2662 = icmp eq i32 %t2593, 22
  %t2663 = select i1 %t2662, i8* %t2661, i8* %t2660
  %s2664 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.2664, i32 0, i32 0
  %t2665 = icmp eq i8* %t2663, %s2664
  br i1 %t2665, label %then42, label %merge43
then42:
  %t2666 = extractvalue %Statement %statement, 0
  %t2667 = alloca %Statement
  store %Statement %statement, %Statement* %t2667
  %t2668 = getelementptr inbounds %Statement, %Statement* %t2667, i32 0, i32 1
  %t2669 = bitcast [48 x i8]* %t2668 to i8*
  %t2670 = bitcast i8* %t2669 to i8**
  %t2671 = load i8*, i8** %t2670
  %t2672 = icmp eq i32 %t2666, 2
  %t2673 = select i1 %t2672, i8* %t2671, i8* null
  %t2674 = getelementptr inbounds %Statement, %Statement* %t2667, i32 0, i32 1
  %t2675 = bitcast [48 x i8]* %t2674 to i8*
  %t2676 = bitcast i8* %t2675 to i8**
  %t2677 = load i8*, i8** %t2676
  %t2678 = icmp eq i32 %t2666, 3
  %t2679 = select i1 %t2678, i8* %t2677, i8* %t2673
  %t2680 = getelementptr inbounds %Statement, %Statement* %t2667, i32 0, i32 1
  %t2681 = bitcast [40 x i8]* %t2680 to i8*
  %t2682 = bitcast i8* %t2681 to i8**
  %t2683 = load i8*, i8** %t2682
  %t2684 = icmp eq i32 %t2666, 6
  %t2685 = select i1 %t2684, i8* %t2683, i8* %t2679
  %t2686 = getelementptr inbounds %Statement, %Statement* %t2667, i32 0, i32 1
  %t2687 = bitcast [56 x i8]* %t2686 to i8*
  %t2688 = bitcast i8* %t2687 to i8**
  %t2689 = load i8*, i8** %t2688
  %t2690 = icmp eq i32 %t2666, 8
  %t2691 = select i1 %t2690, i8* %t2689, i8* %t2685
  %t2692 = getelementptr inbounds %Statement, %Statement* %t2667, i32 0, i32 1
  %t2693 = bitcast [40 x i8]* %t2692 to i8*
  %t2694 = bitcast i8* %t2693 to i8**
  %t2695 = load i8*, i8** %t2694
  %t2696 = icmp eq i32 %t2666, 9
  %t2697 = select i1 %t2696, i8* %t2695, i8* %t2691
  %t2698 = getelementptr inbounds %Statement, %Statement* %t2667, i32 0, i32 1
  %t2699 = bitcast [40 x i8]* %t2698 to i8*
  %t2700 = bitcast i8* %t2699 to i8**
  %t2701 = load i8*, i8** %t2700
  %t2702 = icmp eq i32 %t2666, 10
  %t2703 = select i1 %t2702, i8* %t2701, i8* %t2697
  %t2704 = getelementptr inbounds %Statement, %Statement* %t2667, i32 0, i32 1
  %t2705 = bitcast [40 x i8]* %t2704 to i8*
  %t2706 = bitcast i8* %t2705 to i8**
  %t2707 = load i8*, i8** %t2706
  %t2708 = icmp eq i32 %t2666, 11
  %t2709 = select i1 %t2708, i8* %t2707, i8* %t2703
  %s2710 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2710, i32 0, i32 0
  %t2711 = extractvalue %Statement %statement, 0
  %t2712 = alloca %Statement
  store %Statement %statement, %Statement* %t2712
  %t2713 = getelementptr inbounds %Statement, %Statement* %t2712, i32 0, i32 1
  %t2714 = bitcast [48 x i8]* %t2713 to i8*
  %t2715 = getelementptr inbounds i8, i8* %t2714, i64 8
  %t2716 = bitcast i8* %t2715 to i8**
  %t2717 = load i8*, i8** %t2716
  %t2718 = icmp eq i32 %t2711, 3
  %t2719 = select i1 %t2718, i8* %t2717, i8* null
  %t2720 = getelementptr inbounds %Statement, %Statement* %t2712, i32 0, i32 1
  %t2721 = bitcast [40 x i8]* %t2720 to i8*
  %t2722 = getelementptr inbounds i8, i8* %t2721, i64 8
  %t2723 = bitcast i8* %t2722 to i8**
  %t2724 = load i8*, i8** %t2723
  %t2725 = icmp eq i32 %t2711, 6
  %t2726 = select i1 %t2725, i8* %t2724, i8* %t2719
  %t2727 = getelementptr inbounds %Statement, %Statement* %t2712, i32 0, i32 1
  %t2728 = bitcast [56 x i8]* %t2727 to i8*
  %t2729 = getelementptr inbounds i8, i8* %t2728, i64 8
  %t2730 = bitcast i8* %t2729 to i8**
  %t2731 = load i8*, i8** %t2730
  %t2732 = icmp eq i32 %t2711, 8
  %t2733 = select i1 %t2732, i8* %t2731, i8* %t2726
  %t2734 = getelementptr inbounds %Statement, %Statement* %t2712, i32 0, i32 1
  %t2735 = bitcast [40 x i8]* %t2734 to i8*
  %t2736 = getelementptr inbounds i8, i8* %t2735, i64 8
  %t2737 = bitcast i8* %t2736 to i8**
  %t2738 = load i8*, i8** %t2737
  %t2739 = icmp eq i32 %t2711, 9
  %t2740 = select i1 %t2739, i8* %t2738, i8* %t2733
  %t2741 = getelementptr inbounds %Statement, %Statement* %t2712, i32 0, i32 1
  %t2742 = bitcast [40 x i8]* %t2741 to i8*
  %t2743 = getelementptr inbounds i8, i8* %t2742, i64 8
  %t2744 = bitcast i8* %t2743 to i8**
  %t2745 = load i8*, i8** %t2744
  %t2746 = icmp eq i32 %t2711, 10
  %t2747 = select i1 %t2746, i8* %t2745, i8* %t2740
  %t2748 = getelementptr inbounds %Statement, %Statement* %t2712, i32 0, i32 1
  %t2749 = bitcast [40 x i8]* %t2748 to i8*
  %t2750 = getelementptr inbounds i8, i8* %t2749, i64 8
  %t2751 = bitcast i8* %t2750 to i8**
  %t2752 = load i8*, i8** %t2751
  %t2753 = icmp eq i32 %t2711, 11
  %t2754 = select i1 %t2753, i8* %t2752, i8* %t2747
  %t2755 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t2709, i8* %s2710, i8* %t2754)
  store %ScopeResult %t2755, %ScopeResult* %l24
  %t2756 = load %ScopeResult, %ScopeResult* %l24
  %t2757 = extractvalue %ScopeResult %t2756, 1
  %t2758 = extractvalue %Statement %statement, 0
  %t2759 = alloca %Statement
  store %Statement %statement, %Statement* %t2759
  %t2760 = getelementptr inbounds %Statement, %Statement* %t2759, i32 0, i32 1
  %t2761 = bitcast [56 x i8]* %t2760 to i8*
  %t2762 = getelementptr inbounds i8, i8* %t2761, i64 16
  %t2763 = bitcast i8* %t2762 to { i8**, i64 }**
  %t2764 = load { i8**, i64 }*, { i8**, i64 }** %t2763
  %t2765 = icmp eq i32 %t2758, 8
  %t2766 = select i1 %t2765, { i8**, i64 }* %t2764, { i8**, i64 }* null
  %t2767 = getelementptr inbounds %Statement, %Statement* %t2759, i32 0, i32 1
  %t2768 = bitcast [40 x i8]* %t2767 to i8*
  %t2769 = getelementptr inbounds i8, i8* %t2768, i64 16
  %t2770 = bitcast i8* %t2769 to { i8**, i64 }**
  %t2771 = load { i8**, i64 }*, { i8**, i64 }** %t2770
  %t2772 = icmp eq i32 %t2758, 9
  %t2773 = select i1 %t2772, { i8**, i64 }* %t2771, { i8**, i64 }* %t2766
  %t2774 = getelementptr inbounds %Statement, %Statement* %t2759, i32 0, i32 1
  %t2775 = bitcast [40 x i8]* %t2774 to i8*
  %t2776 = getelementptr inbounds i8, i8* %t2775, i64 16
  %t2777 = bitcast i8* %t2776 to { i8**, i64 }**
  %t2778 = load { i8**, i64 }*, { i8**, i64 }** %t2777
  %t2779 = icmp eq i32 %t2758, 10
  %t2780 = select i1 %t2779, { i8**, i64 }* %t2778, { i8**, i64 }* %t2773
  %t2781 = getelementptr inbounds %Statement, %Statement* %t2759, i32 0, i32 1
  %t2782 = bitcast [40 x i8]* %t2781 to i8*
  %t2783 = getelementptr inbounds i8, i8* %t2782, i64 16
  %t2784 = bitcast i8* %t2783 to { i8**, i64 }**
  %t2785 = load { i8**, i64 }*, { i8**, i64 }** %t2784
  %t2786 = icmp eq i32 %t2758, 11
  %t2787 = select i1 %t2786, { i8**, i64 }* %t2785, { i8**, i64 }* %t2780
  %t2788 = bitcast { i8**, i64 }* %t2787 to { %TypeParameter*, i64 }*
  %t2789 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t2788)
  %t2790 = bitcast { %Diagnostic*, i64 }* %t2789 to { i8**, i64 }*
  %t2791 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2757, { i8**, i64 }* %t2790)
  store { i8**, i64 }* %t2791, { i8**, i64 }** %l25
  %t2792 = load %ScopeResult, %ScopeResult* %l24
  %t2793 = extractvalue %ScopeResult %t2792, 0
  %t2794 = insertvalue %ScopeResult undef, { i8**, i64 }* %t2793, 0
  %t2795 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t2796 = insertvalue %ScopeResult %t2794, { i8**, i64 }* %t2795, 1
  ret %ScopeResult %t2796
merge43:
  %t2797 = bitcast { %SymbolEntry*, i64 }* %bindings to { i8**, i64 }*
  %t2798 = insertvalue %ScopeResult undef, { i8**, i64 }* %t2797, 0
  %t2799 = alloca [0 x i8*]
  %t2800 = getelementptr [0 x i8*], [0 x i8*]* %t2799, i32 0, i32 0
  %t2801 = alloca { i8**, i64 }
  %t2802 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2801, i32 0, i32 0
  store i8** %t2800, i8*** %t2802
  %t2803 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2801, i32 0, i32 1
  store i64 0, i64* %t2803
  %t2804 = insertvalue %ScopeResult %t2798, { i8**, i64 }* %t2801, 1
  ret %ScopeResult %t2804
}

define { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %signature, %Block %body, { %Statement*, i64 }* %interfaces) {
entry:
  %l0 = alloca %ScopeResult
  %l1 = alloca { %Diagnostic*, i64 }*
  %t0 = call %ScopeResult @seed_parameter_scope(%FunctionSignature %signature)
  store %ScopeResult %t0, %ScopeResult* %l0
  %t1 = load %ScopeResult, %ScopeResult* %l0
  %t2 = extractvalue %ScopeResult %t1, 0
  %t3 = bitcast { i8**, i64 }* %t2 to { %SymbolEntry*, i64 }*
  %t4 = call { %Diagnostic*, i64 }* @check_block(%Block %body, { %SymbolEntry*, i64 }* %t3, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t4, { %Diagnostic*, i64 }** %l1
  %t5 = load %ScopeResult, %ScopeResult* %l0
  %t6 = extractvalue %ScopeResult %t5, 1
  %t7 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t8 = bitcast { %Diagnostic*, i64 }* %t7 to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t8)
  %t10 = bitcast { i8**, i64 }* %t9 to { %Diagnostic*, i64 }*
  ret { %Diagnostic*, i64 }* %t10
}

define %ScopeResult @seed_parameter_scope(%FunctionSignature %signature) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca i8*
  %l4 = alloca double
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
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  %t12 = load i64, i64* %t11
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  %t14 = load i8**, i8*** %t13
  store i64 0, i64* %l2
  store i8* null, i8** %l3
  br label %for0
for0:
  %t15 = load i64, i64* %l2
  %t16 = icmp slt i64 %t15, %t12
  br i1 %t16, label %forbody1, label %afterfor3
forbody1:
  %t17 = load i64, i64* %l2
  %t18 = getelementptr i8*, i8** %t14, i64 %t17
  %t19 = load i8*, i8** %t18
  store i8* %t19, i8** %l3
  %t20 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t21 = load i8*, i8** %l3
  %s22 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.22, i32 0, i32 0
  %t23 = load i8*, i8** %l3
  store double 0.0, double* %l4
  %t24 = load double, double* %l4
  %t25 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t26 = load double, double* %l4
  br label %forinc2
forinc2:
  %t27 = load i64, i64* %l2
  %t28 = add i64 %t27, 1
  store i64 %t28, i64* %l2
  br label %for0
afterfor3:
  %t29 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t30 = bitcast { %SymbolEntry*, i64 }* %t29 to { i8**, i64 }*
  %t31 = insertvalue %ScopeResult undef, { i8**, i64 }* %t30, 0
  %t32 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t33 = bitcast { %Diagnostic*, i64 }* %t32 to { i8**, i64 }*
  %t34 = insertvalue %ScopeResult %t31, { i8**, i64 }* %t33, 1
  ret %ScopeResult %t34
}

define { %Diagnostic*, i64 }* @check_block(%Block %block, { %SymbolEntry*, i64 }* %parent_bindings, { %Statement*, i64 }* %interfaces) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca i8*
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
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 1
  %t8 = load i64, i64* %t7
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 0
  %t10 = load i8**, i8*** %t9
  store i64 0, i64* %l2
  store i8* null, i8** %l3
  br label %for0
for0:
  %t11 = load i64, i64* %l2
  %t12 = icmp slt i64 %t11, %t8
  br i1 %t12, label %forbody1, label %afterfor3
forbody1:
  %t13 = load i64, i64* %l2
  %t14 = getelementptr i8*, i8** %t10, i64 %t13
  %t15 = load i8*, i8** %t14
  store i8* %t15, i8** %l3
  %t16 = load i8*, i8** %l3
  %t17 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t18 = call %ScopeResult @check_statement(%Statement zeroinitializer, { %SymbolEntry*, i64 }* %t17, { %Statement*, i64 }* %interfaces)
  store %ScopeResult %t18, %ScopeResult* %l4
  %t19 = load %ScopeResult, %ScopeResult* %l4
  %t20 = extractvalue %ScopeResult %t19, 0
  %t21 = bitcast { i8**, i64 }* %t20 to { %SymbolEntry*, i64 }*
  store { %SymbolEntry*, i64 }* %t21, { %SymbolEntry*, i64 }** %l0
  %t22 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t23 = load %ScopeResult, %ScopeResult* %l4
  %t24 = extractvalue %ScopeResult %t23, 1
  %t25 = bitcast { %Diagnostic*, i64 }* %t22 to { i8**, i64 }*
  %t26 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t25, { i8**, i64 }* %t24)
  %t27 = bitcast { i8**, i64 }* %t26 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t27, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t28 = load i64, i64* %l2
  %t29 = add i64 %t28, 1
  store i64 %t29, i64* %l2
  br label %for0
afterfor3:
  %t30 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t30
}

define { %Diagnostic*, i64 }* @check_struct_implements_interfaces(%Statement %statement, { %Statement*, i64 }* %interfaces) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i64
  %l2 = alloca i8*
  %l3 = alloca { %Diagnostic*, i64 }*
  %l4 = alloca i64
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca double
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [56 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 24
  %t5 = bitcast i8* %t4 to { i8**, i64 }**
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 8
  %t8 = select i1 %t7, { i8**, i64 }* %t6, { i8**, i64 }* null
  %t9 = load { i8**, i64 }, { i8**, i64 }* %t8
  %t10 = extractvalue { i8**, i64 } %t9, 1
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
  %t27 = bitcast i8* %t26 to { i8**, i64 }**
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %t27
  %t29 = icmp eq i32 %t22, 8
  %t30 = select i1 %t29, { i8**, i64 }* %t28, { i8**, i64 }* null
  %t31 = getelementptr { i8**, i64 }, { i8**, i64 }* %t30, i32 0, i32 1
  %t32 = load i64, i64* %t31
  %t33 = getelementptr { i8**, i64 }, { i8**, i64 }* %t30, i32 0, i32 0
  %t34 = load i8**, i8*** %t33
  store i64 0, i64* %l1
  store i8* null, i8** %l2
  br label %for2
for2:
  %t35 = load i64, i64* %l1
  %t36 = icmp slt i64 %t35, %t32
  br i1 %t36, label %forbody3, label %afterfor5
forbody3:
  %t37 = load i64, i64* %l1
  %t38 = getelementptr i8*, i8** %t34, i64 %t37
  %t39 = load i8*, i8** %t38
  store i8* %t39, i8** %l2
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load i8*, i8** %l2
  br label %forinc4
forinc4:
  %t42 = load i64, i64* %l1
  %t43 = add i64 %t42, 1
  store i64 %t43, i64* %l1
  br label %for2
afterfor5:
  %t44 = alloca [0 x %Diagnostic]
  %t45 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t44, i32 0, i32 0
  %t46 = alloca { %Diagnostic*, i64 }
  %t47 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t46, i32 0, i32 0
  store %Diagnostic* %t45, %Diagnostic** %t47
  %t48 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t46, i32 0, i32 1
  store i64 0, i64* %t48
  store { %Diagnostic*, i64 }* %t46, { %Diagnostic*, i64 }** %l3
  %t49 = extractvalue %Statement %statement, 0
  %t50 = alloca %Statement
  store %Statement %statement, %Statement* %t50
  %t51 = getelementptr inbounds %Statement, %Statement* %t50, i32 0, i32 1
  %t52 = bitcast [56 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 24
  %t54 = bitcast i8* %t53 to { i8**, i64 }**
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %t54
  %t56 = icmp eq i32 %t49, 8
  %t57 = select i1 %t56, { i8**, i64 }* %t55, { i8**, i64 }* null
  %t58 = getelementptr { i8**, i64 }, { i8**, i64 }* %t57, i32 0, i32 1
  %t59 = load i64, i64* %t58
  %t60 = getelementptr { i8**, i64 }, { i8**, i64 }* %t57, i32 0, i32 0
  %t61 = load i8**, i8*** %t60
  store i64 0, i64* %l4
  store i8* null, i8** %l5
  br label %for6
for6:
  %t62 = load i64, i64* %l4
  %t63 = icmp slt i64 %t62, %t59
  br i1 %t63, label %forbody7, label %afterfor9
forbody7:
  %t64 = load i64, i64* %l4
  %t65 = getelementptr i8*, i8** %t61, i64 %t64
  %t66 = load i8*, i8** %t65
  store i8* %t66, i8** %l5
  %t67 = load i8*, i8** %l5
  %t68 = call double @resolve_interface_annotation(%TypeAnnotation zeroinitializer, { %Statement*, i64 }* %interfaces)
  store double %t68, double* %l6
  %t69 = load double, double* %l6
  %t70 = load double, double* %l6
  store double 0.0, double* %l7
  %t71 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  %t72 = extractvalue %Statement %statement, 0
  %t73 = alloca %Statement
  store %Statement %statement, %Statement* %t73
  %t74 = getelementptr inbounds %Statement, %Statement* %t73, i32 0, i32 1
  %t75 = bitcast [48 x i8]* %t74 to i8*
  %t76 = bitcast i8* %t75 to i8**
  %t77 = load i8*, i8** %t76
  %t78 = icmp eq i32 %t72, 2
  %t79 = select i1 %t78, i8* %t77, i8* null
  %t80 = getelementptr inbounds %Statement, %Statement* %t73, i32 0, i32 1
  %t81 = bitcast [48 x i8]* %t80 to i8*
  %t82 = bitcast i8* %t81 to i8**
  %t83 = load i8*, i8** %t82
  %t84 = icmp eq i32 %t72, 3
  %t85 = select i1 %t84, i8* %t83, i8* %t79
  %t86 = getelementptr inbounds %Statement, %Statement* %t73, i32 0, i32 1
  %t87 = bitcast [40 x i8]* %t86 to i8*
  %t88 = bitcast i8* %t87 to i8**
  %t89 = load i8*, i8** %t88
  %t90 = icmp eq i32 %t72, 6
  %t91 = select i1 %t90, i8* %t89, i8* %t85
  %t92 = getelementptr inbounds %Statement, %Statement* %t73, i32 0, i32 1
  %t93 = bitcast [56 x i8]* %t92 to i8*
  %t94 = bitcast i8* %t93 to i8**
  %t95 = load i8*, i8** %t94
  %t96 = icmp eq i32 %t72, 8
  %t97 = select i1 %t96, i8* %t95, i8* %t91
  %t98 = getelementptr inbounds %Statement, %Statement* %t73, i32 0, i32 1
  %t99 = bitcast [40 x i8]* %t98 to i8*
  %t100 = bitcast i8* %t99 to i8**
  %t101 = load i8*, i8** %t100
  %t102 = icmp eq i32 %t72, 9
  %t103 = select i1 %t102, i8* %t101, i8* %t97
  %t104 = getelementptr inbounds %Statement, %Statement* %t73, i32 0, i32 1
  %t105 = bitcast [40 x i8]* %t104 to i8*
  %t106 = bitcast i8* %t105 to i8**
  %t107 = load i8*, i8** %t106
  %t108 = icmp eq i32 %t72, 10
  %t109 = select i1 %t108, i8* %t107, i8* %t103
  %t110 = getelementptr inbounds %Statement, %Statement* %t73, i32 0, i32 1
  %t111 = bitcast [40 x i8]* %t110 to i8*
  %t112 = bitcast i8* %t111 to i8**
  %t113 = load i8*, i8** %t112
  %t114 = icmp eq i32 %t72, 11
  %t115 = select i1 %t114, i8* %t113, i8* %t109
  %t116 = load double, double* %l6
  %t117 = load i8*, i8** %l5
  %t118 = call { %Diagnostic*, i64 }* @validate_interface_annotation(i8* %t115, %Statement zeroinitializer, %TypeAnnotation zeroinitializer)
  %t119 = bitcast { %Diagnostic*, i64 }* %t71 to { i8**, i64 }*
  %t120 = bitcast { %Diagnostic*, i64 }* %t118 to { i8**, i64 }*
  %t121 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t119, { i8**, i64 }* %t120)
  %t122 = bitcast { i8**, i64 }* %t121 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t122, { %Diagnostic*, i64 }** %l3
  %t123 = load double, double* %l6
  br label %forinc8
forinc8:
  %t124 = load i64, i64* %l4
  %t125 = add i64 %t124, 1
  store i64 %t125, i64* %l4
  br label %for6
afterfor9:
  %t126 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  ret { %Diagnostic*, i64 }* %t126
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
  %t34 = call double @token_from_name(i8* %t31, i8* %t33)
  %t35 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t29, i8* %s30, i8* null)
  %t36 = alloca [1 x %Diagnostic]
  %t37 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* %t36, i32 0, i32 0
  %t38 = getelementptr %Diagnostic, %Diagnostic* %t37, i64 0
  store %Diagnostic %t35, %Diagnostic* %t38
  %t39 = alloca { %Diagnostic*, i64 }
  %t40 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t39, i32 0, i32 0
  store %Diagnostic* %t37, %Diagnostic** %t40
  %t41 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t39, i32 0, i32 1
  store i64 1, i64* %t41
  %t42 = bitcast { %Diagnostic*, i64 }* %t28 to { i8**, i64 }*
  %t43 = bitcast { %Diagnostic*, i64 }* %t39 to { i8**, i64 }*
  %t44 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t42, { i8**, i64 }* %t43)
  %t45 = bitcast { i8**, i64 }* %t44 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t45, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load i8*, i8** %l4
  %t48 = alloca [1 x i8*]
  %t49 = getelementptr [1 x i8*], [1 x i8*]* %t48, i32 0, i32 0
  %t50 = getelementptr i8*, i8** %t49, i64 0
  store i8* %t47, i8** %t50
  %t51 = alloca { i8**, i64 }
  %t52 = getelementptr { i8**, i64 }, { i8**, i64 }* %t51, i32 0, i32 0
  store i8** %t49, i8*** %t52
  %t53 = getelementptr { i8**, i64 }, { i8**, i64 }* %t51, i32 0, i32 1
  store i64 1, i64* %t53
  %t54 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t46, { i8**, i64 }* %t51)
  store { i8**, i64 }* %t54, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t55 = phi { %Diagnostic*, i64 }* [ %t45, %then4 ], [ %t25, %else5 ]
  %t56 = phi { i8**, i64 }* [ %t24, %then4 ], [ %t54, %else5 ]
  store { %Diagnostic*, i64 }* %t55, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t56, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t57 = load i64, i64* %l2
  %t58 = add i64 %t57, 1
  store i64 %t58, i64* %l2
  br label %for0
afterfor3:
  %t59 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t59
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
  %t5 = bitcast i8* %t4 to { i8**, i64 }**
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %t5
  %t7 = icmp eq i32 %t0, 8
  %t8 = select i1 %t7, { i8**, i64 }* %t6, { i8**, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [40 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { i8**, i64 }**
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %t12
  %t14 = icmp eq i32 %t0, 9
  %t15 = select i1 %t14, { i8**, i64 }* %t13, { i8**, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [40 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { i8**, i64 }**
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %t19
  %t21 = icmp eq i32 %t0, 10
  %t22 = select i1 %t21, { i8**, i64 }* %t20, { i8**, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 16
  %t26 = bitcast i8* %t25 to { i8**, i64 }**
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %t26
  %t28 = icmp eq i32 %t0, 11
  %t29 = select i1 %t28, { i8**, i64 }* %t27, { i8**, i64 }* %t22
  %t30 = load { i8**, i64 }, { i8**, i64 }* %t29
  %t31 = extractvalue { i8**, i64 } %t30, 1
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
  %l2 = alloca i8*
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
  %t10 = bitcast i8* %t9 to { i8**, i64 }**
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %t10
  %t12 = icmp eq i32 %t5, 8
  %t13 = select i1 %t12, { i8**, i64 }* %t11, { i8**, i64 }* null
  %t14 = getelementptr inbounds %Statement, %Statement* %t6, i32 0, i32 1
  %t15 = bitcast [40 x i8]* %t14 to i8*
  %t16 = getelementptr inbounds i8, i8* %t15, i64 16
  %t17 = bitcast i8* %t16 to { i8**, i64 }**
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %t17
  %t19 = icmp eq i32 %t5, 9
  %t20 = select i1 %t19, { i8**, i64 }* %t18, { i8**, i64 }* %t13
  %t21 = getelementptr inbounds %Statement, %Statement* %t6, i32 0, i32 1
  %t22 = bitcast [40 x i8]* %t21 to i8*
  %t23 = getelementptr inbounds i8, i8* %t22, i64 16
  %t24 = bitcast i8* %t23 to { i8**, i64 }**
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %t24
  %t26 = icmp eq i32 %t5, 10
  %t27 = select i1 %t26, { i8**, i64 }* %t25, { i8**, i64 }* %t20
  %t28 = getelementptr inbounds %Statement, %Statement* %t6, i32 0, i32 1
  %t29 = bitcast [40 x i8]* %t28 to i8*
  %t30 = getelementptr inbounds i8, i8* %t29, i64 16
  %t31 = bitcast i8* %t30 to { i8**, i64 }**
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %t31
  %t33 = icmp eq i32 %t5, 11
  %t34 = select i1 %t33, { i8**, i64 }* %t32, { i8**, i64 }* %t27
  %t35 = getelementptr { i8**, i64 }, { i8**, i64 }* %t34, i32 0, i32 1
  %t36 = load i64, i64* %t35
  %t37 = getelementptr { i8**, i64 }, { i8**, i64 }* %t34, i32 0, i32 0
  %t38 = load i8**, i8*** %t37
  store i64 0, i64* %l1
  store i8* null, i8** %l2
  br label %for0
for0:
  %t39 = load i64, i64* %l1
  %t40 = icmp slt i64 %t39, %t36
  br i1 %t40, label %forbody1, label %afterfor3
forbody1:
  %t41 = load i64, i64* %l1
  %t42 = getelementptr i8*, i8** %t38, i64 %t41
  %t43 = load i8*, i8** %t42
  store i8* %t43, i8** %l2
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load i8*, i8** %l2
  br label %forinc2
forinc2:
  %t46 = load i64, i64* %l1
  %t47 = add i64 %t46, 1
  store i64 %t47, i64* %l1
  br label %for0
afterfor3:
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load { i8**, i64 }, { i8**, i64 }* %t48
  %t50 = extractvalue { i8**, i64 } %t49, 1
  %t51 = icmp eq i64 %t50, 0
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br i1 %t51, label %then4, label %merge5
then4:
  %t53 = extractvalue %Statement %interface_definition, 0
  %t54 = alloca %Statement
  store %Statement %interface_definition, %Statement* %t54
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
  ret i8* %t96
merge5:
  %t97 = extractvalue %Statement %interface_definition, 0
  %t98 = alloca %Statement
  store %Statement %interface_definition, %Statement* %t98
  %t99 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t100 = bitcast [48 x i8]* %t99 to i8*
  %t101 = bitcast i8* %t100 to i8**
  %t102 = load i8*, i8** %t101
  %t103 = icmp eq i32 %t97, 2
  %t104 = select i1 %t103, i8* %t102, i8* null
  %t105 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t106 = bitcast [48 x i8]* %t105 to i8*
  %t107 = bitcast i8* %t106 to i8**
  %t108 = load i8*, i8** %t107
  %t109 = icmp eq i32 %t97, 3
  %t110 = select i1 %t109, i8* %t108, i8* %t104
  %t111 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t112 = bitcast [40 x i8]* %t111 to i8*
  %t113 = bitcast i8* %t112 to i8**
  %t114 = load i8*, i8** %t113
  %t115 = icmp eq i32 %t97, 6
  %t116 = select i1 %t115, i8* %t114, i8* %t110
  %t117 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t118 = bitcast [56 x i8]* %t117 to i8*
  %t119 = bitcast i8* %t118 to i8**
  %t120 = load i8*, i8** %t119
  %t121 = icmp eq i32 %t97, 8
  %t122 = select i1 %t121, i8* %t120, i8* %t116
  %t123 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t124 = bitcast [40 x i8]* %t123 to i8*
  %t125 = bitcast i8* %t124 to i8**
  %t126 = load i8*, i8** %t125
  %t127 = icmp eq i32 %t97, 9
  %t128 = select i1 %t127, i8* %t126, i8* %t122
  %t129 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t130 = bitcast [40 x i8]* %t129 to i8*
  %t131 = bitcast i8* %t130 to i8**
  %t132 = load i8*, i8** %t131
  %t133 = icmp eq i32 %t97, 10
  %t134 = select i1 %t133, i8* %t132, i8* %t128
  %t135 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t136 = bitcast [40 x i8]* %t135 to i8*
  %t137 = bitcast i8* %t136 to i8**
  %t138 = load i8*, i8** %t137
  %t139 = icmp eq i32 %t97, 11
  %t140 = select i1 %t139, i8* %t138, i8* %t134
  ret i8* null
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
  %t29 = phi double [ %t11, %entry ], [ %t28, %loop.latch2 ]
  store double %t29, double* %l3
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
  %t25 = load double, double* %l3
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l3
  br label %loop.latch2
loop.latch2:
  %t28 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t30 = load i8*, i8** %l1
  %t31 = call i8* @trim_text(i8* %t30)
  store i8* %t31, i8** %l5
  %t32 = load i8*, i8** %l5
  %t33 = call i64 @sailfin_runtime_string_length(i8* %t32)
  %t34 = icmp sgt i64 %t33, 0
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load i8*, i8** %l1
  %t37 = load double, double* %l2
  %t38 = load double, double* %l3
  %t39 = load i8*, i8** %l5
  br i1 %t34, label %then6, label %merge7
then6:
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load i8*, i8** %l5
  %t42 = alloca [1 x i8*]
  %t43 = getelementptr [1 x i8*], [1 x i8*]* %t42, i32 0, i32 0
  %t44 = getelementptr i8*, i8** %t43, i64 0
  store i8* %t41, i8** %t44
  %t45 = alloca { i8**, i64 }
  %t46 = getelementptr { i8**, i64 }, { i8**, i64 }* %t45, i32 0, i32 0
  store i8** %t43, i8*** %t46
  %t47 = getelementptr { i8**, i64 }, { i8**, i64 }* %t45, i32 0, i32 1
  store i64 1, i64* %t47
  %t48 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t40, { i8**, i64 }* %t45)
  store { i8**, i64 }* %t48, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t49 = phi { i8**, i64 }* [ %t48, %then6 ], [ %t35, %entry ]
  store { i8**, i64 }* %t49, { i8**, i64 }** %l0
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t50
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
  %t21 = phi double [ %t3, %entry ], [ %t20, %loop.latch2 ]
  store double %t21, double* %l0
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
  %t14 = call i1 @is_whitespace(i8* null)
  %t15 = load double, double* %l0
  %t16 = load double, double* %l1
  br i1 %t14, label %then6, label %merge7
then6:
  %t17 = load double, double* %l0
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t20 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t22 = load double, double* %l0
  %t23 = load double, double* %l1
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t24 = load double, double* %l1
  %t25 = load double, double* %l0
  %t26 = fcmp ole double %t24, %t25
  %t27 = load double, double* %l0
  %t28 = load double, double* %l1
  br i1 %t26, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  br label %afterloop11
loop.latch10:
  br label %loop.header8
afterloop11:
  %t29 = load double, double* %l0
  %t30 = load double, double* %l1
  %t31 = call i8* @slice_text(i8* %value, double %t29, double %t30)
  ret i8* %t31
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
  %t27 = phi i8* [ %t8, %entry ], [ %t25, %loop.latch8 ]
  %t28 = phi double [ %t9, %entry ], [ %t26, %loop.latch8 ]
  store i8* %t27, i8** %l0
  store double %t28, double* %l1
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
  store i8* null, i8** %l0
  %t22 = load double, double* %l1
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l1
  br label %loop.latch8
loop.latch8:
  %t25 = load i8*, i8** %l0
  %t26 = load double, double* %l1
  br label %loop.header6
afterloop9:
  %t29 = load i8*, i8** %l0
  ret i8* %t29
}

define i1 @is_whitespace(i8* %ch) {
entry:
  %t3 = getelementptr i8, i8* %ch, i64 0
  %t4 = load i8, i8* %t3
  %t5 = icmp eq i8 %t4, 32
  br label %logical_or_entry_2

logical_or_entry_2:
  br i1 %t5, label %logical_or_merge_2, label %logical_or_right_2

logical_or_right_2:
  %t6 = getelementptr i8, i8* %ch, i64 0
  %t7 = load i8, i8* %t6
  %t8 = icmp eq i8 %t7, 10
  br label %logical_or_right_end_2

logical_or_right_end_2:
  br label %logical_or_merge_2

logical_or_merge_2:
  %t9 = phi i1 [ true, %logical_or_entry_2 ], [ %t8, %logical_or_right_end_2 ]
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t9, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %t10 = getelementptr i8, i8* %ch, i64 0
  %t11 = load i8, i8* %t10
  %t12 = icmp eq i8 %t11, 9
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t13 = phi i1 [ true, %logical_or_entry_1 ], [ %t12, %logical_or_right_end_1 ]
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t13, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t14 = getelementptr i8, i8* %ch, i64 0
  %t15 = load i8, i8* %t14
  %t16 = icmp eq i8 %t15, 13
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
  %l4 = alloca double
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
  store double 0.0, double* %l4
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load double, double* %l4
  %t31 = call i1 @contains_string({ i8**, i64 }* %t29, i8* null)
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t34 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t35 = load double, double* %l4
  br i1 %t31, label %then4, label %else5
then4:
  %t36 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t37 = load double, double* %l4
  %s38 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.38, i32 0, i32 0
  %t39 = load double, double* %l4
  %t40 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t41 = extractvalue %MethodDeclaration %t40, 0
  br label %merge6
else5:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load double, double* %l4
  %t44 = alloca [1 x double]
  %t45 = getelementptr [1 x double], [1 x double]* %t44, i32 0, i32 0
  %t46 = getelementptr double, double* %t45, i64 0
  store double %t43, double* %t46
  %t47 = alloca { double*, i64 }
  %t48 = getelementptr { double*, i64 }, { double*, i64 }* %t47, i32 0, i32 0
  store double* %t45, double** %t48
  %t49 = getelementptr { double*, i64 }, { double*, i64 }* %t47, i32 0, i32 1
  store i64 1, i64* %t49
  %t50 = bitcast { double*, i64 }* %t47 to { i8**, i64 }*
  %t51 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t42, { i8**, i64 }* %t50)
  store { i8**, i64 }* %t51, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t52 = phi { %Diagnostic*, i64 }* [ null, %then4 ], [ %t33, %else5 ]
  %t53 = phi { i8**, i64 }* [ %t32, %then4 ], [ %t51, %else5 ]
  store { %Diagnostic*, i64 }* %t52, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t53, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t54 = load i64, i64* %l2
  %t55 = add i64 %t54, 1
  store i64 %t55, i64* %l2
  br label %for0
afterfor3:
  %t56 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t56
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
  %t34 = call double @token_from_name(i8* %t31, i8* %t33)
  %t35 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t29, i8* %s30, i8* null)
  %t36 = alloca [1 x %Diagnostic]
  %t37 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* %t36, i32 0, i32 0
  %t38 = getelementptr %Diagnostic, %Diagnostic* %t37, i64 0
  store %Diagnostic %t35, %Diagnostic* %t38
  %t39 = alloca { %Diagnostic*, i64 }
  %t40 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t39, i32 0, i32 0
  store %Diagnostic* %t37, %Diagnostic** %t40
  %t41 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t39, i32 0, i32 1
  store i64 1, i64* %t41
  %t42 = bitcast { %Diagnostic*, i64 }* %t28 to { i8**, i64 }*
  %t43 = bitcast { %Diagnostic*, i64 }* %t39 to { i8**, i64 }*
  %t44 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t42, { i8**, i64 }* %t43)
  %t45 = bitcast { i8**, i64 }* %t44 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t45, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load i8*, i8** %l4
  %t48 = alloca [1 x i8*]
  %t49 = getelementptr [1 x i8*], [1 x i8*]* %t48, i32 0, i32 0
  %t50 = getelementptr i8*, i8** %t49, i64 0
  store i8* %t47, i8** %t50
  %t51 = alloca { i8**, i64 }
  %t52 = getelementptr { i8**, i64 }, { i8**, i64 }* %t51, i32 0, i32 0
  store i8** %t49, i8*** %t52
  %t53 = getelementptr { i8**, i64 }, { i8**, i64 }* %t51, i32 0, i32 1
  store i64 1, i64* %t53
  %t54 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t46, { i8**, i64 }* %t51)
  store { i8**, i64 }* %t54, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t55 = phi { %Diagnostic*, i64 }* [ %t45, %then4 ], [ %t25, %else5 ]
  %t56 = phi { i8**, i64 }* [ %t24, %then4 ], [ %t54, %else5 ]
  store { %Diagnostic*, i64 }* %t55, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t56, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t57 = load i64, i64* %l2
  %t58 = add i64 %t57, 1
  store i64 %t58, i64* %l2
  br label %for0
afterfor3:
  %t59 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t59
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
  %t41 = call double @token_from_name(i8* %t38, i8* %t40)
  %t42 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t36, i8* %s37, i8* null)
  %t43 = alloca [1 x %Diagnostic]
  %t44 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* %t43, i32 0, i32 0
  %t45 = getelementptr %Diagnostic, %Diagnostic* %t44, i64 0
  store %Diagnostic %t42, %Diagnostic* %t45
  %t46 = alloca { %Diagnostic*, i64 }
  %t47 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t46, i32 0, i32 0
  store %Diagnostic* %t44, %Diagnostic** %t47
  %t48 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t46, i32 0, i32 1
  store i64 1, i64* %t48
  %t49 = bitcast { %Diagnostic*, i64 }* %t35 to { i8**, i64 }*
  %t50 = bitcast { %Diagnostic*, i64 }* %t46 to { i8**, i64 }*
  %t51 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t49, { i8**, i64 }* %t50)
  %t52 = bitcast { i8**, i64 }* %t51 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t52, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load i8*, i8** %l4
  %t55 = alloca [1 x i8*]
  %t56 = getelementptr [1 x i8*], [1 x i8*]* %t55, i32 0, i32 0
  %t57 = getelementptr i8*, i8** %t56, i64 0
  store i8* %t54, i8** %t57
  %t58 = alloca { i8**, i64 }
  %t59 = getelementptr { i8**, i64 }, { i8**, i64 }* %t58, i32 0, i32 0
  store i8** %t56, i8*** %t59
  %t60 = getelementptr { i8**, i64 }, { i8**, i64 }* %t58, i32 0, i32 1
  store i64 1, i64* %t60
  %t61 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t53, { i8**, i64 }* %t58)
  store { i8**, i64 }* %t61, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t62 = phi { %Diagnostic*, i64 }* [ %t52, %then4 ], [ %t32, %else5 ]
  %t63 = phi { i8**, i64 }* [ %t31, %then4 ], [ %t61, %else5 ]
  store { %Diagnostic*, i64 }* %t62, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t63, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t64 = load i64, i64* %l2
  %t65 = add i64 %t64, 1
  store i64 %t65, i64* %l2
  br label %for0
afterfor3:
  %t66 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t66
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
  %t34 = call double @token_from_name(i8* %t31, i8* %t33)
  %t35 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t29, i8* %s30, i8* null)
  %t36 = alloca [1 x %Diagnostic]
  %t37 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* %t36, i32 0, i32 0
  %t38 = getelementptr %Diagnostic, %Diagnostic* %t37, i64 0
  store %Diagnostic %t35, %Diagnostic* %t38
  %t39 = alloca { %Diagnostic*, i64 }
  %t40 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t39, i32 0, i32 0
  store %Diagnostic* %t37, %Diagnostic** %t40
  %t41 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t39, i32 0, i32 1
  store i64 1, i64* %t41
  %t42 = bitcast { %Diagnostic*, i64 }* %t28 to { i8**, i64 }*
  %t43 = bitcast { %Diagnostic*, i64 }* %t39 to { i8**, i64 }*
  %t44 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t42, { i8**, i64 }* %t43)
  %t45 = bitcast { i8**, i64 }* %t44 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t45, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load i8*, i8** %l4
  %t48 = alloca [1 x i8*]
  %t49 = getelementptr [1 x i8*], [1 x i8*]* %t48, i32 0, i32 0
  %t50 = getelementptr i8*, i8** %t49, i64 0
  store i8* %t47, i8** %t50
  %t51 = alloca { i8**, i64 }
  %t52 = getelementptr { i8**, i64 }, { i8**, i64 }* %t51, i32 0, i32 0
  store i8** %t49, i8*** %t52
  %t53 = getelementptr { i8**, i64 }, { i8**, i64 }* %t51, i32 0, i32 1
  store i64 1, i64* %t53
  %t54 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t46, { i8**, i64 }* %t51)
  store { i8**, i64 }* %t54, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t55 = phi { %Diagnostic*, i64 }* [ %t45, %then4 ], [ %t25, %else5 ]
  %t56 = phi { i8**, i64 }* [ %t24, %then4 ], [ %t54, %else5 ]
  store { %Diagnostic*, i64 }* %t55, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t56, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t57 = load i64, i64* %l2
  %t58 = add i64 %t57, 1
  store i64 %t58, i64* %l2
  br label %for0
afterfor3:
  %t59 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t59
}

define { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %signature) {
entry:
  %t0 = extractvalue %FunctionSignature %signature, 5
  %t1 = bitcast { i8**, i64 }* %t0 to { %TypeParameter*, i64 }*
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
  %t34 = call double @token_from_name(i8* %t31, i8* %t33)
  %t35 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t29, i8* %s30, i8* null)
  %t36 = alloca [1 x %Diagnostic]
  %t37 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* %t36, i32 0, i32 0
  %t38 = getelementptr %Diagnostic, %Diagnostic* %t37, i64 0
  store %Diagnostic %t35, %Diagnostic* %t38
  %t39 = alloca { %Diagnostic*, i64 }
  %t40 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t39, i32 0, i32 0
  store %Diagnostic* %t37, %Diagnostic** %t40
  %t41 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t39, i32 0, i32 1
  store i64 1, i64* %t41
  %t42 = bitcast { %Diagnostic*, i64 }* %t28 to { i8**, i64 }*
  %t43 = bitcast { %Diagnostic*, i64 }* %t39 to { i8**, i64 }*
  %t44 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t42, { i8**, i64 }* %t43)
  %t45 = bitcast { i8**, i64 }* %t44 to { %Diagnostic*, i64 }*
  store { %Diagnostic*, i64 }* %t45, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load i8*, i8** %l4
  %t48 = alloca [1 x i8*]
  %t49 = getelementptr [1 x i8*], [1 x i8*]* %t48, i32 0, i32 0
  %t50 = getelementptr i8*, i8** %t49, i64 0
  store i8* %t47, i8** %t50
  %t51 = alloca { i8**, i64 }
  %t52 = getelementptr { i8**, i64 }, { i8**, i64 }* %t51, i32 0, i32 0
  store i8** %t49, i8*** %t52
  %t53 = getelementptr { i8**, i64 }, { i8**, i64 }* %t51, i32 0, i32 1
  store i64 1, i64* %t53
  %t54 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t46, { i8**, i64 }* %t51)
  store { i8**, i64 }* %t54, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t55 = phi { %Diagnostic*, i64 }* [ %t45, %then4 ], [ %t25, %else5 ]
  %t56 = phi { i8**, i64 }* [ %t24, %then4 ], [ %t54, %else5 ]
  store { %Diagnostic*, i64 }* %t55, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t56, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t57 = load i64, i64* %l2
  %t58 = add i64 %t57, 1
  store i64 %t58, i64* %l2
  br label %for0
afterfor3:
  %t59 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t59
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
  %t35 = insertvalue %Diagnostic %t32, i8* null, 2
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
  ret i8* null
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
  %t1 = bitcast { %SymbolEntry*, i64 }* %bindings to { i8**, i64 }*
  %t2 = insertvalue %ScopeResult undef, { i8**, i64 }* %t1, 0
  %t3 = call double @token_from_name(i8* %name, i8* %span)
  %t4 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %name, i8* %kind, i8* null)
  %t5 = insertvalue %ScopeResult %t2, { i8**, i64 }* null, 1
  ret %ScopeResult %t5
merge1:
  %t6 = call { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %name, i8* %kind, i8* %span)
  store { %SymbolEntry*, i64 }* %t6, { %SymbolEntry*, i64 }** %l0
  %t7 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t8 = bitcast { %SymbolEntry*, i64 }* %t7 to { i8**, i64 }*
  %t9 = insertvalue %ScopeResult undef, { i8**, i64 }* %t8, 0
  %t10 = alloca [0 x i8*]
  %t11 = getelementptr [0 x i8*], [0 x i8*]* %t10, i32 0, i32 0
  %t12 = alloca { i8**, i64 }
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t11, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  %t15 = insertvalue %ScopeResult %t9, { i8**, i64 }* %t12, 1
  ret %ScopeResult %t15
}

define %SymbolCollectionResult @register_symbol(i8* %name, i8* %kind, i8* %span, { %SymbolEntry*, i64 }* %existing) {
entry:
  %t0 = call i1 @has_symbol({ %SymbolEntry*, i64 }* %existing, i8* %name)
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = bitcast { %SymbolEntry*, i64 }* %existing to { i8**, i64 }*
  %t2 = insertvalue %SymbolCollectionResult undef, { i8**, i64 }* %t1, 0
  %t3 = call double @token_from_name(i8* %name, i8* %span)
  %t4 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %name, i8* %kind, i8* null)
  %t5 = insertvalue %SymbolCollectionResult %t2, { i8**, i64 }* null, 1
  ret %SymbolCollectionResult %t5
merge1:
  %t6 = call { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %existing, i8* %name, i8* %kind, i8* %span)
  %t7 = bitcast { %SymbolEntry*, i64 }* %t6 to { i8**, i64 }*
  %t8 = insertvalue %SymbolCollectionResult undef, { i8**, i64 }* %t7, 0
  %t9 = alloca [0 x i8*]
  %t10 = getelementptr [0 x i8*], [0 x i8*]* %t9, i32 0, i32 0
  %t11 = alloca { i8**, i64 }
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t11, i32 0, i32 0
  store i8** %t10, i8*** %t12
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t11, i32 0, i32 1
  store i64 0, i64* %t13
  %t14 = insertvalue %SymbolCollectionResult %t8, { i8**, i64 }* %t11, 1
  ret %SymbolCollectionResult %t14
}

define { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %symbols, i8* %name, i8* %kind, i8* %span) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %t0 = call { %SymbolEntry*, i64 }* @clone_bindings({ %SymbolEntry*, i64 }* %symbols)
  store { %SymbolEntry*, i64 }* %t0, { %SymbolEntry*, i64 }** %l0
  %t1 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t2 = insertvalue %SymbolEntry undef, i8* %name, 0
  %t3 = insertvalue %SymbolEntry %t2, i8* %kind, 1
  %t4 = insertvalue %SymbolEntry %t3, i8* %span, 2
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
