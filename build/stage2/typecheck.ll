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
  %t641 = phi { i8**, i64 }* [ %t598, %then4 ], [ %t639, %loop.latch8 ]
  %t642 = phi double [ %t599, %then4 ], [ %t640, %loop.latch8 ]
  store { i8**, i64 }* %t641, { i8**, i64 }** %l4
  store double %t642, double* %l5
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
  %t627 = load { i8**, i64 }, { i8**, i64 }* %t625
  %t628 = extractvalue { i8**, i64 } %t627, 0
  %t629 = extractvalue { i8**, i64 } %t627, 1
  %t630 = icmp uge i64 %t626, %t629
  ; bounds check: %t630 (if true, out of bounds)
  %t631 = getelementptr i8*, i8** %t628, i64 %t626
  %t632 = load i8*, i8** %t631
  store i8* %t632, i8** %l6
  %t633 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t634 = load i8*, i8** %l6
  %t635 = load i8*, i8** %l6
  %t636 = load double, double* %l5
  %t637 = sitofp i64 1 to double
  %t638 = fadd double %t636, %t637
  store double %t638, double* %l5
  br label %loop.latch8
loop.latch8:
  %t639 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t640 = load double, double* %l5
  br label %loop.header6
afterloop9:
  %t643 = load %ScopeResult, %ScopeResult* %l3
  %t644 = extractvalue %ScopeResult %t643, 0
  %t645 = insertvalue %ScopeResult undef, { i8**, i64 }* %t644, 0
  %t646 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t647 = insertvalue %ScopeResult %t645, { i8**, i64 }* %t646, 1
  ret %ScopeResult %t647
merge5:
  %t648 = extractvalue %Statement %statement, 0
  %t649 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t650 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t651 = icmp eq i32 %t648, 0
  %t652 = select i1 %t651, i8* %t650, i8* %t649
  %t653 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t654 = icmp eq i32 %t648, 1
  %t655 = select i1 %t654, i8* %t653, i8* %t652
  %t656 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t657 = icmp eq i32 %t648, 2
  %t658 = select i1 %t657, i8* %t656, i8* %t655
  %t659 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t660 = icmp eq i32 %t648, 3
  %t661 = select i1 %t660, i8* %t659, i8* %t658
  %t662 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t663 = icmp eq i32 %t648, 4
  %t664 = select i1 %t663, i8* %t662, i8* %t661
  %t665 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t666 = icmp eq i32 %t648, 5
  %t667 = select i1 %t666, i8* %t665, i8* %t664
  %t668 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t669 = icmp eq i32 %t648, 6
  %t670 = select i1 %t669, i8* %t668, i8* %t667
  %t671 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t672 = icmp eq i32 %t648, 7
  %t673 = select i1 %t672, i8* %t671, i8* %t670
  %t674 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t675 = icmp eq i32 %t648, 8
  %t676 = select i1 %t675, i8* %t674, i8* %t673
  %t677 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t678 = icmp eq i32 %t648, 9
  %t679 = select i1 %t678, i8* %t677, i8* %t676
  %t680 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t681 = icmp eq i32 %t648, 10
  %t682 = select i1 %t681, i8* %t680, i8* %t679
  %t683 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t684 = icmp eq i32 %t648, 11
  %t685 = select i1 %t684, i8* %t683, i8* %t682
  %t686 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t687 = icmp eq i32 %t648, 12
  %t688 = select i1 %t687, i8* %t686, i8* %t685
  %t689 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t690 = icmp eq i32 %t648, 13
  %t691 = select i1 %t690, i8* %t689, i8* %t688
  %t692 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t693 = icmp eq i32 %t648, 14
  %t694 = select i1 %t693, i8* %t692, i8* %t691
  %t695 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t696 = icmp eq i32 %t648, 15
  %t697 = select i1 %t696, i8* %t695, i8* %t694
  %t698 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t699 = icmp eq i32 %t648, 16
  %t700 = select i1 %t699, i8* %t698, i8* %t697
  %t701 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t702 = icmp eq i32 %t648, 17
  %t703 = select i1 %t702, i8* %t701, i8* %t700
  %t704 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t705 = icmp eq i32 %t648, 18
  %t706 = select i1 %t705, i8* %t704, i8* %t703
  %t707 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t708 = icmp eq i32 %t648, 19
  %t709 = select i1 %t708, i8* %t707, i8* %t706
  %t710 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t711 = icmp eq i32 %t648, 20
  %t712 = select i1 %t711, i8* %t710, i8* %t709
  %t713 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t714 = icmp eq i32 %t648, 21
  %t715 = select i1 %t714, i8* %t713, i8* %t712
  %t716 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t717 = icmp eq i32 %t648, 22
  %t718 = select i1 %t717, i8* %t716, i8* %t715
  %s719 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.719, i32 0, i32 0
  %t720 = icmp eq i8* %t718, %s719
  br i1 %t720, label %then12, label %merge13
then12:
  %t721 = extractvalue %Statement %statement, 0
  %t722 = alloca %Statement
  store %Statement %statement, %Statement* %t722
  %t723 = getelementptr inbounds %Statement, %Statement* %t722, i32 0, i32 1
  %t724 = bitcast [48 x i8]* %t723 to i8*
  %t725 = bitcast i8* %t724 to i8**
  %t726 = load i8*, i8** %t725
  %t727 = icmp eq i32 %t721, 2
  %t728 = select i1 %t727, i8* %t726, i8* null
  %t729 = getelementptr inbounds %Statement, %Statement* %t722, i32 0, i32 1
  %t730 = bitcast [48 x i8]* %t729 to i8*
  %t731 = bitcast i8* %t730 to i8**
  %t732 = load i8*, i8** %t731
  %t733 = icmp eq i32 %t721, 3
  %t734 = select i1 %t733, i8* %t732, i8* %t728
  %t735 = getelementptr inbounds %Statement, %Statement* %t722, i32 0, i32 1
  %t736 = bitcast [40 x i8]* %t735 to i8*
  %t737 = bitcast i8* %t736 to i8**
  %t738 = load i8*, i8** %t737
  %t739 = icmp eq i32 %t721, 6
  %t740 = select i1 %t739, i8* %t738, i8* %t734
  %t741 = getelementptr inbounds %Statement, %Statement* %t722, i32 0, i32 1
  %t742 = bitcast [56 x i8]* %t741 to i8*
  %t743 = bitcast i8* %t742 to i8**
  %t744 = load i8*, i8** %t743
  %t745 = icmp eq i32 %t721, 8
  %t746 = select i1 %t745, i8* %t744, i8* %t740
  %t747 = getelementptr inbounds %Statement, %Statement* %t722, i32 0, i32 1
  %t748 = bitcast [40 x i8]* %t747 to i8*
  %t749 = bitcast i8* %t748 to i8**
  %t750 = load i8*, i8** %t749
  %t751 = icmp eq i32 %t721, 9
  %t752 = select i1 %t751, i8* %t750, i8* %t746
  %t753 = getelementptr inbounds %Statement, %Statement* %t722, i32 0, i32 1
  %t754 = bitcast [40 x i8]* %t753 to i8*
  %t755 = bitcast i8* %t754 to i8**
  %t756 = load i8*, i8** %t755
  %t757 = icmp eq i32 %t721, 10
  %t758 = select i1 %t757, i8* %t756, i8* %t752
  %t759 = getelementptr inbounds %Statement, %Statement* %t722, i32 0, i32 1
  %t760 = bitcast [40 x i8]* %t759 to i8*
  %t761 = bitcast i8* %t760 to i8**
  %t762 = load i8*, i8** %t761
  %t763 = icmp eq i32 %t721, 11
  %t764 = select i1 %t763, i8* %t762, i8* %t758
  %s765 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.765, i32 0, i32 0
  %t766 = extractvalue %Statement %statement, 0
  %t767 = alloca %Statement
  store %Statement %statement, %Statement* %t767
  %t768 = getelementptr inbounds %Statement, %Statement* %t767, i32 0, i32 1
  %t769 = bitcast [48 x i8]* %t768 to i8*
  %t770 = getelementptr inbounds i8, i8* %t769, i64 8
  %t771 = bitcast i8* %t770 to i8**
  %t772 = load i8*, i8** %t771
  %t773 = icmp eq i32 %t766, 3
  %t774 = select i1 %t773, i8* %t772, i8* null
  %t775 = getelementptr inbounds %Statement, %Statement* %t767, i32 0, i32 1
  %t776 = bitcast [40 x i8]* %t775 to i8*
  %t777 = getelementptr inbounds i8, i8* %t776, i64 8
  %t778 = bitcast i8* %t777 to i8**
  %t779 = load i8*, i8** %t778
  %t780 = icmp eq i32 %t766, 6
  %t781 = select i1 %t780, i8* %t779, i8* %t774
  %t782 = getelementptr inbounds %Statement, %Statement* %t767, i32 0, i32 1
  %t783 = bitcast [56 x i8]* %t782 to i8*
  %t784 = getelementptr inbounds i8, i8* %t783, i64 8
  %t785 = bitcast i8* %t784 to i8**
  %t786 = load i8*, i8** %t785
  %t787 = icmp eq i32 %t766, 8
  %t788 = select i1 %t787, i8* %t786, i8* %t781
  %t789 = getelementptr inbounds %Statement, %Statement* %t767, i32 0, i32 1
  %t790 = bitcast [40 x i8]* %t789 to i8*
  %t791 = getelementptr inbounds i8, i8* %t790, i64 8
  %t792 = bitcast i8* %t791 to i8**
  %t793 = load i8*, i8** %t792
  %t794 = icmp eq i32 %t766, 9
  %t795 = select i1 %t794, i8* %t793, i8* %t788
  %t796 = getelementptr inbounds %Statement, %Statement* %t767, i32 0, i32 1
  %t797 = bitcast [40 x i8]* %t796 to i8*
  %t798 = getelementptr inbounds i8, i8* %t797, i64 8
  %t799 = bitcast i8* %t798 to i8**
  %t800 = load i8*, i8** %t799
  %t801 = icmp eq i32 %t766, 10
  %t802 = select i1 %t801, i8* %t800, i8* %t795
  %t803 = getelementptr inbounds %Statement, %Statement* %t767, i32 0, i32 1
  %t804 = bitcast [40 x i8]* %t803 to i8*
  %t805 = getelementptr inbounds i8, i8* %t804, i64 8
  %t806 = bitcast i8* %t805 to i8**
  %t807 = load i8*, i8** %t806
  %t808 = icmp eq i32 %t766, 11
  %t809 = select i1 %t808, i8* %t807, i8* %t802
  %t810 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t764, i8* %s765, i8* %t809)
  store %ScopeResult %t810, %ScopeResult* %l7
  %t811 = load %ScopeResult, %ScopeResult* %l7
  %t812 = extractvalue %ScopeResult %t811, 1
  store { i8**, i64 }* %t812, { i8**, i64 }** %l8
  %t813 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t814 = extractvalue %Statement %statement, 0
  %t815 = alloca %Statement
  store %Statement %statement, %Statement* %t815
  %t816 = getelementptr inbounds %Statement, %Statement* %t815, i32 0, i32 1
  %t817 = bitcast [56 x i8]* %t816 to i8*
  %t818 = getelementptr inbounds i8, i8* %t817, i64 16
  %t819 = bitcast i8* %t818 to { i8**, i64 }**
  %t820 = load { i8**, i64 }*, { i8**, i64 }** %t819
  %t821 = icmp eq i32 %t814, 8
  %t822 = select i1 %t821, { i8**, i64 }* %t820, { i8**, i64 }* null
  %t823 = getelementptr inbounds %Statement, %Statement* %t815, i32 0, i32 1
  %t824 = bitcast [40 x i8]* %t823 to i8*
  %t825 = getelementptr inbounds i8, i8* %t824, i64 16
  %t826 = bitcast i8* %t825 to { i8**, i64 }**
  %t827 = load { i8**, i64 }*, { i8**, i64 }** %t826
  %t828 = icmp eq i32 %t814, 9
  %t829 = select i1 %t828, { i8**, i64 }* %t827, { i8**, i64 }* %t822
  %t830 = getelementptr inbounds %Statement, %Statement* %t815, i32 0, i32 1
  %t831 = bitcast [40 x i8]* %t830 to i8*
  %t832 = getelementptr inbounds i8, i8* %t831, i64 16
  %t833 = bitcast i8* %t832 to { i8**, i64 }**
  %t834 = load { i8**, i64 }*, { i8**, i64 }** %t833
  %t835 = icmp eq i32 %t814, 10
  %t836 = select i1 %t835, { i8**, i64 }* %t834, { i8**, i64 }* %t829
  %t837 = getelementptr inbounds %Statement, %Statement* %t815, i32 0, i32 1
  %t838 = bitcast [40 x i8]* %t837 to i8*
  %t839 = getelementptr inbounds i8, i8* %t838, i64 16
  %t840 = bitcast i8* %t839 to { i8**, i64 }**
  %t841 = load { i8**, i64 }*, { i8**, i64 }** %t840
  %t842 = icmp eq i32 %t814, 11
  %t843 = select i1 %t842, { i8**, i64 }* %t841, { i8**, i64 }* %t836
  %t844 = bitcast { i8**, i64 }* %t843 to { %TypeParameter*, i64 }*
  %t845 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t844)
  %t846 = bitcast { %Diagnostic*, i64 }* %t845 to { i8**, i64 }*
  %t847 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t813, { i8**, i64 }* %t846)
  store { i8**, i64 }* %t847, { i8**, i64 }** %l8
  %t848 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t849 = extractvalue %Statement %statement, 0
  %t850 = alloca %Statement
  store %Statement %statement, %Statement* %t850
  %t851 = getelementptr inbounds %Statement, %Statement* %t850, i32 0, i32 1
  %t852 = bitcast [40 x i8]* %t851 to i8*
  %t853 = getelementptr inbounds i8, i8* %t852, i64 24
  %t854 = bitcast i8* %t853 to { i8**, i64 }**
  %t855 = load { i8**, i64 }*, { i8**, i64 }** %t854
  %t856 = icmp eq i32 %t849, 11
  %t857 = select i1 %t856, { i8**, i64 }* %t855, { i8**, i64 }* null
  %t858 = bitcast { i8**, i64 }* %t857 to { %EnumVariant*, i64 }*
  %t859 = call { %Diagnostic*, i64 }* @check_enum_variants({ %EnumVariant*, i64 }* %t858)
  %t860 = bitcast { %Diagnostic*, i64 }* %t859 to { i8**, i64 }*
  %t861 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t848, { i8**, i64 }* %t860)
  store { i8**, i64 }* %t861, { i8**, i64 }** %l8
  %t862 = load %ScopeResult, %ScopeResult* %l7
  %t863 = extractvalue %ScopeResult %t862, 0
  %t864 = insertvalue %ScopeResult undef, { i8**, i64 }* %t863, 0
  %t865 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t866 = insertvalue %ScopeResult %t864, { i8**, i64 }* %t865, 1
  ret %ScopeResult %t866
merge13:
  %t867 = extractvalue %Statement %statement, 0
  %t868 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t869 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t870 = icmp eq i32 %t867, 0
  %t871 = select i1 %t870, i8* %t869, i8* %t868
  %t872 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t873 = icmp eq i32 %t867, 1
  %t874 = select i1 %t873, i8* %t872, i8* %t871
  %t875 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t876 = icmp eq i32 %t867, 2
  %t877 = select i1 %t876, i8* %t875, i8* %t874
  %t878 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t879 = icmp eq i32 %t867, 3
  %t880 = select i1 %t879, i8* %t878, i8* %t877
  %t881 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t882 = icmp eq i32 %t867, 4
  %t883 = select i1 %t882, i8* %t881, i8* %t880
  %t884 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t885 = icmp eq i32 %t867, 5
  %t886 = select i1 %t885, i8* %t884, i8* %t883
  %t887 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t888 = icmp eq i32 %t867, 6
  %t889 = select i1 %t888, i8* %t887, i8* %t886
  %t890 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t891 = icmp eq i32 %t867, 7
  %t892 = select i1 %t891, i8* %t890, i8* %t889
  %t893 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t894 = icmp eq i32 %t867, 8
  %t895 = select i1 %t894, i8* %t893, i8* %t892
  %t896 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t897 = icmp eq i32 %t867, 9
  %t898 = select i1 %t897, i8* %t896, i8* %t895
  %t899 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t900 = icmp eq i32 %t867, 10
  %t901 = select i1 %t900, i8* %t899, i8* %t898
  %t902 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t903 = icmp eq i32 %t867, 11
  %t904 = select i1 %t903, i8* %t902, i8* %t901
  %t905 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t906 = icmp eq i32 %t867, 12
  %t907 = select i1 %t906, i8* %t905, i8* %t904
  %t908 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t909 = icmp eq i32 %t867, 13
  %t910 = select i1 %t909, i8* %t908, i8* %t907
  %t911 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t912 = icmp eq i32 %t867, 14
  %t913 = select i1 %t912, i8* %t911, i8* %t910
  %t914 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t915 = icmp eq i32 %t867, 15
  %t916 = select i1 %t915, i8* %t914, i8* %t913
  %t917 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t918 = icmp eq i32 %t867, 16
  %t919 = select i1 %t918, i8* %t917, i8* %t916
  %t920 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t921 = icmp eq i32 %t867, 17
  %t922 = select i1 %t921, i8* %t920, i8* %t919
  %t923 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t924 = icmp eq i32 %t867, 18
  %t925 = select i1 %t924, i8* %t923, i8* %t922
  %t926 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t927 = icmp eq i32 %t867, 19
  %t928 = select i1 %t927, i8* %t926, i8* %t925
  %t929 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t930 = icmp eq i32 %t867, 20
  %t931 = select i1 %t930, i8* %t929, i8* %t928
  %t932 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t933 = icmp eq i32 %t867, 21
  %t934 = select i1 %t933, i8* %t932, i8* %t931
  %t935 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t936 = icmp eq i32 %t867, 22
  %t937 = select i1 %t936, i8* %t935, i8* %t934
  %s938 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.938, i32 0, i32 0
  %t939 = icmp eq i8* %t937, %s938
  br i1 %t939, label %then14, label %merge15
then14:
  %t940 = extractvalue %Statement %statement, 0
  %t941 = alloca %Statement
  store %Statement %statement, %Statement* %t941
  %t942 = getelementptr inbounds %Statement, %Statement* %t941, i32 0, i32 1
  %t943 = bitcast [48 x i8]* %t942 to i8*
  %t944 = bitcast i8* %t943 to i8**
  %t945 = load i8*, i8** %t944
  %t946 = icmp eq i32 %t940, 2
  %t947 = select i1 %t946, i8* %t945, i8* null
  %t948 = getelementptr inbounds %Statement, %Statement* %t941, i32 0, i32 1
  %t949 = bitcast [48 x i8]* %t948 to i8*
  %t950 = bitcast i8* %t949 to i8**
  %t951 = load i8*, i8** %t950
  %t952 = icmp eq i32 %t940, 3
  %t953 = select i1 %t952, i8* %t951, i8* %t947
  %t954 = getelementptr inbounds %Statement, %Statement* %t941, i32 0, i32 1
  %t955 = bitcast [40 x i8]* %t954 to i8*
  %t956 = bitcast i8* %t955 to i8**
  %t957 = load i8*, i8** %t956
  %t958 = icmp eq i32 %t940, 6
  %t959 = select i1 %t958, i8* %t957, i8* %t953
  %t960 = getelementptr inbounds %Statement, %Statement* %t941, i32 0, i32 1
  %t961 = bitcast [56 x i8]* %t960 to i8*
  %t962 = bitcast i8* %t961 to i8**
  %t963 = load i8*, i8** %t962
  %t964 = icmp eq i32 %t940, 8
  %t965 = select i1 %t964, i8* %t963, i8* %t959
  %t966 = getelementptr inbounds %Statement, %Statement* %t941, i32 0, i32 1
  %t967 = bitcast [40 x i8]* %t966 to i8*
  %t968 = bitcast i8* %t967 to i8**
  %t969 = load i8*, i8** %t968
  %t970 = icmp eq i32 %t940, 9
  %t971 = select i1 %t970, i8* %t969, i8* %t965
  %t972 = getelementptr inbounds %Statement, %Statement* %t941, i32 0, i32 1
  %t973 = bitcast [40 x i8]* %t972 to i8*
  %t974 = bitcast i8* %t973 to i8**
  %t975 = load i8*, i8** %t974
  %t976 = icmp eq i32 %t940, 10
  %t977 = select i1 %t976, i8* %t975, i8* %t971
  %t978 = getelementptr inbounds %Statement, %Statement* %t941, i32 0, i32 1
  %t979 = bitcast [40 x i8]* %t978 to i8*
  %t980 = bitcast i8* %t979 to i8**
  %t981 = load i8*, i8** %t980
  %t982 = icmp eq i32 %t940, 11
  %t983 = select i1 %t982, i8* %t981, i8* %t977
  %s984 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.984, i32 0, i32 0
  %t985 = extractvalue %Statement %statement, 0
  %t986 = alloca %Statement
  store %Statement %statement, %Statement* %t986
  %t987 = getelementptr inbounds %Statement, %Statement* %t986, i32 0, i32 1
  %t988 = bitcast [48 x i8]* %t987 to i8*
  %t989 = getelementptr inbounds i8, i8* %t988, i64 8
  %t990 = bitcast i8* %t989 to i8**
  %t991 = load i8*, i8** %t990
  %t992 = icmp eq i32 %t985, 3
  %t993 = select i1 %t992, i8* %t991, i8* null
  %t994 = getelementptr inbounds %Statement, %Statement* %t986, i32 0, i32 1
  %t995 = bitcast [40 x i8]* %t994 to i8*
  %t996 = getelementptr inbounds i8, i8* %t995, i64 8
  %t997 = bitcast i8* %t996 to i8**
  %t998 = load i8*, i8** %t997
  %t999 = icmp eq i32 %t985, 6
  %t1000 = select i1 %t999, i8* %t998, i8* %t993
  %t1001 = getelementptr inbounds %Statement, %Statement* %t986, i32 0, i32 1
  %t1002 = bitcast [56 x i8]* %t1001 to i8*
  %t1003 = getelementptr inbounds i8, i8* %t1002, i64 8
  %t1004 = bitcast i8* %t1003 to i8**
  %t1005 = load i8*, i8** %t1004
  %t1006 = icmp eq i32 %t985, 8
  %t1007 = select i1 %t1006, i8* %t1005, i8* %t1000
  %t1008 = getelementptr inbounds %Statement, %Statement* %t986, i32 0, i32 1
  %t1009 = bitcast [40 x i8]* %t1008 to i8*
  %t1010 = getelementptr inbounds i8, i8* %t1009, i64 8
  %t1011 = bitcast i8* %t1010 to i8**
  %t1012 = load i8*, i8** %t1011
  %t1013 = icmp eq i32 %t985, 9
  %t1014 = select i1 %t1013, i8* %t1012, i8* %t1007
  %t1015 = getelementptr inbounds %Statement, %Statement* %t986, i32 0, i32 1
  %t1016 = bitcast [40 x i8]* %t1015 to i8*
  %t1017 = getelementptr inbounds i8, i8* %t1016, i64 8
  %t1018 = bitcast i8* %t1017 to i8**
  %t1019 = load i8*, i8** %t1018
  %t1020 = icmp eq i32 %t985, 10
  %t1021 = select i1 %t1020, i8* %t1019, i8* %t1014
  %t1022 = getelementptr inbounds %Statement, %Statement* %t986, i32 0, i32 1
  %t1023 = bitcast [40 x i8]* %t1022 to i8*
  %t1024 = getelementptr inbounds i8, i8* %t1023, i64 8
  %t1025 = bitcast i8* %t1024 to i8**
  %t1026 = load i8*, i8** %t1025
  %t1027 = icmp eq i32 %t985, 11
  %t1028 = select i1 %t1027, i8* %t1026, i8* %t1021
  %t1029 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t983, i8* %s984, i8* %t1028)
  store %ScopeResult %t1029, %ScopeResult* %l9
  %t1030 = load %ScopeResult, %ScopeResult* %l9
  %t1031 = extractvalue %ScopeResult %t1030, 1
  store { i8**, i64 }* %t1031, { i8**, i64 }** %l10
  %t1032 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t1033 = extractvalue %Statement %statement, 0
  %t1034 = alloca %Statement
  store %Statement %statement, %Statement* %t1034
  %t1035 = getelementptr inbounds %Statement, %Statement* %t1034, i32 0, i32 1
  %t1036 = bitcast [56 x i8]* %t1035 to i8*
  %t1037 = getelementptr inbounds i8, i8* %t1036, i64 16
  %t1038 = bitcast i8* %t1037 to { i8**, i64 }**
  %t1039 = load { i8**, i64 }*, { i8**, i64 }** %t1038
  %t1040 = icmp eq i32 %t1033, 8
  %t1041 = select i1 %t1040, { i8**, i64 }* %t1039, { i8**, i64 }* null
  %t1042 = getelementptr inbounds %Statement, %Statement* %t1034, i32 0, i32 1
  %t1043 = bitcast [40 x i8]* %t1042 to i8*
  %t1044 = getelementptr inbounds i8, i8* %t1043, i64 16
  %t1045 = bitcast i8* %t1044 to { i8**, i64 }**
  %t1046 = load { i8**, i64 }*, { i8**, i64 }** %t1045
  %t1047 = icmp eq i32 %t1033, 9
  %t1048 = select i1 %t1047, { i8**, i64 }* %t1046, { i8**, i64 }* %t1041
  %t1049 = getelementptr inbounds %Statement, %Statement* %t1034, i32 0, i32 1
  %t1050 = bitcast [40 x i8]* %t1049 to i8*
  %t1051 = getelementptr inbounds i8, i8* %t1050, i64 16
  %t1052 = bitcast i8* %t1051 to { i8**, i64 }**
  %t1053 = load { i8**, i64 }*, { i8**, i64 }** %t1052
  %t1054 = icmp eq i32 %t1033, 10
  %t1055 = select i1 %t1054, { i8**, i64 }* %t1053, { i8**, i64 }* %t1048
  %t1056 = getelementptr inbounds %Statement, %Statement* %t1034, i32 0, i32 1
  %t1057 = bitcast [40 x i8]* %t1056 to i8*
  %t1058 = getelementptr inbounds i8, i8* %t1057, i64 16
  %t1059 = bitcast i8* %t1058 to { i8**, i64 }**
  %t1060 = load { i8**, i64 }*, { i8**, i64 }** %t1059
  %t1061 = icmp eq i32 %t1033, 11
  %t1062 = select i1 %t1061, { i8**, i64 }* %t1060, { i8**, i64 }* %t1055
  %t1063 = bitcast { i8**, i64 }* %t1062 to { %TypeParameter*, i64 }*
  %t1064 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t1063)
  %t1065 = bitcast { %Diagnostic*, i64 }* %t1064 to { i8**, i64 }*
  %t1066 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1032, { i8**, i64 }* %t1065)
  store { i8**, i64 }* %t1066, { i8**, i64 }** %l10
  %t1067 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t1068 = extractvalue %Statement %statement, 0
  %t1069 = alloca %Statement
  store %Statement %statement, %Statement* %t1069
  %t1070 = getelementptr inbounds %Statement, %Statement* %t1069, i32 0, i32 1
  %t1071 = bitcast [40 x i8]* %t1070 to i8*
  %t1072 = getelementptr inbounds i8, i8* %t1071, i64 24
  %t1073 = bitcast i8* %t1072 to { i8**, i64 }**
  %t1074 = load { i8**, i64 }*, { i8**, i64 }** %t1073
  %t1075 = icmp eq i32 %t1068, 10
  %t1076 = select i1 %t1075, { i8**, i64 }* %t1074, { i8**, i64 }* null
  %t1077 = bitcast { i8**, i64 }* %t1076 to { %FunctionSignature*, i64 }*
  %t1078 = call { %Diagnostic*, i64 }* @check_interface_members({ %FunctionSignature*, i64 }* %t1077)
  %t1079 = bitcast { %Diagnostic*, i64 }* %t1078 to { i8**, i64 }*
  %t1080 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1067, { i8**, i64 }* %t1079)
  store { i8**, i64 }* %t1080, { i8**, i64 }** %l10
  %t1081 = load %ScopeResult, %ScopeResult* %l9
  %t1082 = extractvalue %ScopeResult %t1081, 0
  %t1083 = insertvalue %ScopeResult undef, { i8**, i64 }* %t1082, 0
  %t1084 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t1085 = insertvalue %ScopeResult %t1083, { i8**, i64 }* %t1084, 1
  ret %ScopeResult %t1085
merge15:
  %t1086 = extractvalue %Statement %statement, 0
  %t1087 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1088 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1089 = icmp eq i32 %t1086, 0
  %t1090 = select i1 %t1089, i8* %t1088, i8* %t1087
  %t1091 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1092 = icmp eq i32 %t1086, 1
  %t1093 = select i1 %t1092, i8* %t1091, i8* %t1090
  %t1094 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1095 = icmp eq i32 %t1086, 2
  %t1096 = select i1 %t1095, i8* %t1094, i8* %t1093
  %t1097 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1098 = icmp eq i32 %t1086, 3
  %t1099 = select i1 %t1098, i8* %t1097, i8* %t1096
  %t1100 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1101 = icmp eq i32 %t1086, 4
  %t1102 = select i1 %t1101, i8* %t1100, i8* %t1099
  %t1103 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1104 = icmp eq i32 %t1086, 5
  %t1105 = select i1 %t1104, i8* %t1103, i8* %t1102
  %t1106 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1107 = icmp eq i32 %t1086, 6
  %t1108 = select i1 %t1107, i8* %t1106, i8* %t1105
  %t1109 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1110 = icmp eq i32 %t1086, 7
  %t1111 = select i1 %t1110, i8* %t1109, i8* %t1108
  %t1112 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1113 = icmp eq i32 %t1086, 8
  %t1114 = select i1 %t1113, i8* %t1112, i8* %t1111
  %t1115 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1116 = icmp eq i32 %t1086, 9
  %t1117 = select i1 %t1116, i8* %t1115, i8* %t1114
  %t1118 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1119 = icmp eq i32 %t1086, 10
  %t1120 = select i1 %t1119, i8* %t1118, i8* %t1117
  %t1121 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1122 = icmp eq i32 %t1086, 11
  %t1123 = select i1 %t1122, i8* %t1121, i8* %t1120
  %t1124 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1125 = icmp eq i32 %t1086, 12
  %t1126 = select i1 %t1125, i8* %t1124, i8* %t1123
  %t1127 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1128 = icmp eq i32 %t1086, 13
  %t1129 = select i1 %t1128, i8* %t1127, i8* %t1126
  %t1130 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1131 = icmp eq i32 %t1086, 14
  %t1132 = select i1 %t1131, i8* %t1130, i8* %t1129
  %t1133 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1134 = icmp eq i32 %t1086, 15
  %t1135 = select i1 %t1134, i8* %t1133, i8* %t1132
  %t1136 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1137 = icmp eq i32 %t1086, 16
  %t1138 = select i1 %t1137, i8* %t1136, i8* %t1135
  %t1139 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1140 = icmp eq i32 %t1086, 17
  %t1141 = select i1 %t1140, i8* %t1139, i8* %t1138
  %t1142 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1143 = icmp eq i32 %t1086, 18
  %t1144 = select i1 %t1143, i8* %t1142, i8* %t1141
  %t1145 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1146 = icmp eq i32 %t1086, 19
  %t1147 = select i1 %t1146, i8* %t1145, i8* %t1144
  %t1148 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1149 = icmp eq i32 %t1086, 20
  %t1150 = select i1 %t1149, i8* %t1148, i8* %t1147
  %t1151 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1152 = icmp eq i32 %t1086, 21
  %t1153 = select i1 %t1152, i8* %t1151, i8* %t1150
  %t1154 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1155 = icmp eq i32 %t1086, 22
  %t1156 = select i1 %t1155, i8* %t1154, i8* %t1153
  %s1157 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.1157, i32 0, i32 0
  %t1158 = icmp eq i8* %t1156, %s1157
  br i1 %t1158, label %then16, label %merge17
then16:
  %t1159 = extractvalue %Statement %statement, 0
  %t1160 = alloca %Statement
  store %Statement %statement, %Statement* %t1160
  %t1161 = getelementptr inbounds %Statement, %Statement* %t1160, i32 0, i32 1
  %t1162 = bitcast [48 x i8]* %t1161 to i8*
  %t1163 = bitcast i8* %t1162 to i8**
  %t1164 = load i8*, i8** %t1163
  %t1165 = icmp eq i32 %t1159, 2
  %t1166 = select i1 %t1165, i8* %t1164, i8* null
  %t1167 = getelementptr inbounds %Statement, %Statement* %t1160, i32 0, i32 1
  %t1168 = bitcast [48 x i8]* %t1167 to i8*
  %t1169 = bitcast i8* %t1168 to i8**
  %t1170 = load i8*, i8** %t1169
  %t1171 = icmp eq i32 %t1159, 3
  %t1172 = select i1 %t1171, i8* %t1170, i8* %t1166
  %t1173 = getelementptr inbounds %Statement, %Statement* %t1160, i32 0, i32 1
  %t1174 = bitcast [40 x i8]* %t1173 to i8*
  %t1175 = bitcast i8* %t1174 to i8**
  %t1176 = load i8*, i8** %t1175
  %t1177 = icmp eq i32 %t1159, 6
  %t1178 = select i1 %t1177, i8* %t1176, i8* %t1172
  %t1179 = getelementptr inbounds %Statement, %Statement* %t1160, i32 0, i32 1
  %t1180 = bitcast [56 x i8]* %t1179 to i8*
  %t1181 = bitcast i8* %t1180 to i8**
  %t1182 = load i8*, i8** %t1181
  %t1183 = icmp eq i32 %t1159, 8
  %t1184 = select i1 %t1183, i8* %t1182, i8* %t1178
  %t1185 = getelementptr inbounds %Statement, %Statement* %t1160, i32 0, i32 1
  %t1186 = bitcast [40 x i8]* %t1185 to i8*
  %t1187 = bitcast i8* %t1186 to i8**
  %t1188 = load i8*, i8** %t1187
  %t1189 = icmp eq i32 %t1159, 9
  %t1190 = select i1 %t1189, i8* %t1188, i8* %t1184
  %t1191 = getelementptr inbounds %Statement, %Statement* %t1160, i32 0, i32 1
  %t1192 = bitcast [40 x i8]* %t1191 to i8*
  %t1193 = bitcast i8* %t1192 to i8**
  %t1194 = load i8*, i8** %t1193
  %t1195 = icmp eq i32 %t1159, 10
  %t1196 = select i1 %t1195, i8* %t1194, i8* %t1190
  %t1197 = getelementptr inbounds %Statement, %Statement* %t1160, i32 0, i32 1
  %t1198 = bitcast [40 x i8]* %t1197 to i8*
  %t1199 = bitcast i8* %t1198 to i8**
  %t1200 = load i8*, i8** %t1199
  %t1201 = icmp eq i32 %t1159, 11
  %t1202 = select i1 %t1201, i8* %t1200, i8* %t1196
  %s1203 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1203, i32 0, i32 0
  %t1204 = extractvalue %Statement %statement, 0
  %t1205 = alloca %Statement
  store %Statement %statement, %Statement* %t1205
  %t1206 = getelementptr inbounds %Statement, %Statement* %t1205, i32 0, i32 1
  %t1207 = bitcast [48 x i8]* %t1206 to i8*
  %t1208 = getelementptr inbounds i8, i8* %t1207, i64 8
  %t1209 = bitcast i8* %t1208 to i8**
  %t1210 = load i8*, i8** %t1209
  %t1211 = icmp eq i32 %t1204, 3
  %t1212 = select i1 %t1211, i8* %t1210, i8* null
  %t1213 = getelementptr inbounds %Statement, %Statement* %t1205, i32 0, i32 1
  %t1214 = bitcast [40 x i8]* %t1213 to i8*
  %t1215 = getelementptr inbounds i8, i8* %t1214, i64 8
  %t1216 = bitcast i8* %t1215 to i8**
  %t1217 = load i8*, i8** %t1216
  %t1218 = icmp eq i32 %t1204, 6
  %t1219 = select i1 %t1218, i8* %t1217, i8* %t1212
  %t1220 = getelementptr inbounds %Statement, %Statement* %t1205, i32 0, i32 1
  %t1221 = bitcast [56 x i8]* %t1220 to i8*
  %t1222 = getelementptr inbounds i8, i8* %t1221, i64 8
  %t1223 = bitcast i8* %t1222 to i8**
  %t1224 = load i8*, i8** %t1223
  %t1225 = icmp eq i32 %t1204, 8
  %t1226 = select i1 %t1225, i8* %t1224, i8* %t1219
  %t1227 = getelementptr inbounds %Statement, %Statement* %t1205, i32 0, i32 1
  %t1228 = bitcast [40 x i8]* %t1227 to i8*
  %t1229 = getelementptr inbounds i8, i8* %t1228, i64 8
  %t1230 = bitcast i8* %t1229 to i8**
  %t1231 = load i8*, i8** %t1230
  %t1232 = icmp eq i32 %t1204, 9
  %t1233 = select i1 %t1232, i8* %t1231, i8* %t1226
  %t1234 = getelementptr inbounds %Statement, %Statement* %t1205, i32 0, i32 1
  %t1235 = bitcast [40 x i8]* %t1234 to i8*
  %t1236 = getelementptr inbounds i8, i8* %t1235, i64 8
  %t1237 = bitcast i8* %t1236 to i8**
  %t1238 = load i8*, i8** %t1237
  %t1239 = icmp eq i32 %t1204, 10
  %t1240 = select i1 %t1239, i8* %t1238, i8* %t1233
  %t1241 = getelementptr inbounds %Statement, %Statement* %t1205, i32 0, i32 1
  %t1242 = bitcast [40 x i8]* %t1241 to i8*
  %t1243 = getelementptr inbounds i8, i8* %t1242, i64 8
  %t1244 = bitcast i8* %t1243 to i8**
  %t1245 = load i8*, i8** %t1244
  %t1246 = icmp eq i32 %t1204, 11
  %t1247 = select i1 %t1246, i8* %t1245, i8* %t1240
  %t1248 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1202, i8* %s1203, i8* %t1247)
  store %ScopeResult %t1248, %ScopeResult* %l11
  %t1249 = load %ScopeResult, %ScopeResult* %l11
  %t1250 = extractvalue %ScopeResult %t1249, 1
  %t1251 = extractvalue %Statement %statement, 0
  %t1252 = alloca %Statement
  store %Statement %statement, %Statement* %t1252
  %t1253 = getelementptr inbounds %Statement, %Statement* %t1252, i32 0, i32 1
  %t1254 = bitcast [48 x i8]* %t1253 to i8*
  %t1255 = getelementptr inbounds i8, i8* %t1254, i64 24
  %t1256 = bitcast i8* %t1255 to { i8**, i64 }**
  %t1257 = load { i8**, i64 }*, { i8**, i64 }** %t1256
  %t1258 = icmp eq i32 %t1251, 3
  %t1259 = select i1 %t1258, { i8**, i64 }* %t1257, { i8**, i64 }* null
  %t1260 = bitcast { i8**, i64 }* %t1259 to { %ModelProperty*, i64 }*
  %t1261 = call { %Diagnostic*, i64 }* @check_model_properties({ %ModelProperty*, i64 }* %t1260)
  %t1262 = bitcast { %Diagnostic*, i64 }* %t1261 to { i8**, i64 }*
  %t1263 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1250, { i8**, i64 }* %t1262)
  store { i8**, i64 }* %t1263, { i8**, i64 }** %l12
  %t1264 = load %ScopeResult, %ScopeResult* %l11
  %t1265 = extractvalue %ScopeResult %t1264, 0
  %t1266 = insertvalue %ScopeResult undef, { i8**, i64 }* %t1265, 0
  %t1267 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %t1268 = insertvalue %ScopeResult %t1266, { i8**, i64 }* %t1267, 1
  ret %ScopeResult %t1268
merge17:
  %t1269 = extractvalue %Statement %statement, 0
  %t1270 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1271 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1272 = icmp eq i32 %t1269, 0
  %t1273 = select i1 %t1272, i8* %t1271, i8* %t1270
  %t1274 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1275 = icmp eq i32 %t1269, 1
  %t1276 = select i1 %t1275, i8* %t1274, i8* %t1273
  %t1277 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1278 = icmp eq i32 %t1269, 2
  %t1279 = select i1 %t1278, i8* %t1277, i8* %t1276
  %t1280 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1281 = icmp eq i32 %t1269, 3
  %t1282 = select i1 %t1281, i8* %t1280, i8* %t1279
  %t1283 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1284 = icmp eq i32 %t1269, 4
  %t1285 = select i1 %t1284, i8* %t1283, i8* %t1282
  %t1286 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1287 = icmp eq i32 %t1269, 5
  %t1288 = select i1 %t1287, i8* %t1286, i8* %t1285
  %t1289 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1290 = icmp eq i32 %t1269, 6
  %t1291 = select i1 %t1290, i8* %t1289, i8* %t1288
  %t1292 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1293 = icmp eq i32 %t1269, 7
  %t1294 = select i1 %t1293, i8* %t1292, i8* %t1291
  %t1295 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1296 = icmp eq i32 %t1269, 8
  %t1297 = select i1 %t1296, i8* %t1295, i8* %t1294
  %t1298 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1299 = icmp eq i32 %t1269, 9
  %t1300 = select i1 %t1299, i8* %t1298, i8* %t1297
  %t1301 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1302 = icmp eq i32 %t1269, 10
  %t1303 = select i1 %t1302, i8* %t1301, i8* %t1300
  %t1304 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1305 = icmp eq i32 %t1269, 11
  %t1306 = select i1 %t1305, i8* %t1304, i8* %t1303
  %t1307 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1308 = icmp eq i32 %t1269, 12
  %t1309 = select i1 %t1308, i8* %t1307, i8* %t1306
  %t1310 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1311 = icmp eq i32 %t1269, 13
  %t1312 = select i1 %t1311, i8* %t1310, i8* %t1309
  %t1313 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1314 = icmp eq i32 %t1269, 14
  %t1315 = select i1 %t1314, i8* %t1313, i8* %t1312
  %t1316 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1317 = icmp eq i32 %t1269, 15
  %t1318 = select i1 %t1317, i8* %t1316, i8* %t1315
  %t1319 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1320 = icmp eq i32 %t1269, 16
  %t1321 = select i1 %t1320, i8* %t1319, i8* %t1318
  %t1322 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1323 = icmp eq i32 %t1269, 17
  %t1324 = select i1 %t1323, i8* %t1322, i8* %t1321
  %t1325 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1326 = icmp eq i32 %t1269, 18
  %t1327 = select i1 %t1326, i8* %t1325, i8* %t1324
  %t1328 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1329 = icmp eq i32 %t1269, 19
  %t1330 = select i1 %t1329, i8* %t1328, i8* %t1327
  %t1331 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1332 = icmp eq i32 %t1269, 20
  %t1333 = select i1 %t1332, i8* %t1331, i8* %t1330
  %t1334 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1335 = icmp eq i32 %t1269, 21
  %t1336 = select i1 %t1335, i8* %t1334, i8* %t1333
  %t1337 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1338 = icmp eq i32 %t1269, 22
  %t1339 = select i1 %t1338, i8* %t1337, i8* %t1336
  %s1340 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1340, i32 0, i32 0
  %t1341 = icmp eq i8* %t1339, %s1340
  br i1 %t1341, label %then18, label %merge19
then18:
  %t1342 = extractvalue %Statement %statement, 0
  %t1343 = alloca %Statement
  store %Statement %statement, %Statement* %t1343
  %t1344 = getelementptr inbounds %Statement, %Statement* %t1343, i32 0, i32 1
  %t1345 = bitcast [24 x i8]* %t1344 to i8*
  %t1346 = bitcast i8* %t1345 to i8**
  %t1347 = load i8*, i8** %t1346
  %t1348 = icmp eq i32 %t1342, 4
  %t1349 = select i1 %t1348, i8* %t1347, i8* null
  %t1350 = getelementptr inbounds %Statement, %Statement* %t1343, i32 0, i32 1
  %t1351 = bitcast [24 x i8]* %t1350 to i8*
  %t1352 = bitcast i8* %t1351 to i8**
  %t1353 = load i8*, i8** %t1352
  %t1354 = icmp eq i32 %t1342, 5
  %t1355 = select i1 %t1354, i8* %t1353, i8* %t1349
  %t1356 = getelementptr inbounds %Statement, %Statement* %t1343, i32 0, i32 1
  %t1357 = bitcast [24 x i8]* %t1356 to i8*
  %t1358 = bitcast i8* %t1357 to i8**
  %t1359 = load i8*, i8** %t1358
  %t1360 = icmp eq i32 %t1342, 7
  %t1361 = select i1 %t1360, i8* %t1359, i8* %t1355
  %s1362 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1362, i32 0, i32 0
  %t1363 = extractvalue %Statement %statement, 0
  %t1364 = alloca %Statement
  store %Statement %statement, %Statement* %t1364
  %t1365 = getelementptr inbounds %Statement, %Statement* %t1364, i32 0, i32 1
  %t1366 = bitcast [24 x i8]* %t1365 to i8*
  %t1367 = bitcast i8* %t1366 to i8**
  %t1368 = load i8*, i8** %t1367
  %t1369 = icmp eq i32 %t1363, 4
  %t1370 = select i1 %t1369, i8* %t1368, i8* null
  %t1371 = getelementptr inbounds %Statement, %Statement* %t1364, i32 0, i32 1
  %t1372 = bitcast [24 x i8]* %t1371 to i8*
  %t1373 = bitcast i8* %t1372 to i8**
  %t1374 = load i8*, i8** %t1373
  %t1375 = icmp eq i32 %t1363, 5
  %t1376 = select i1 %t1375, i8* %t1374, i8* %t1370
  %t1377 = getelementptr inbounds %Statement, %Statement* %t1364, i32 0, i32 1
  %t1378 = bitcast [24 x i8]* %t1377 to i8*
  %t1379 = bitcast i8* %t1378 to i8**
  %t1380 = load i8*, i8** %t1379
  %t1381 = icmp eq i32 %t1363, 7
  %t1382 = select i1 %t1381, i8* %t1380, i8* %t1376
  store double 0.0, double* %l13
  %t1383 = load double, double* %l13
  store double 0.0, double* %l14
  %t1384 = load double, double* %l14
  %t1385 = extractvalue %Statement %statement, 0
  %t1386 = alloca %Statement
  store %Statement %statement, %Statement* %t1386
  %t1387 = getelementptr inbounds %Statement, %Statement* %t1386, i32 0, i32 1
  %t1388 = bitcast [24 x i8]* %t1387 to i8*
  %t1389 = bitcast i8* %t1388 to i8**
  %t1390 = load i8*, i8** %t1389
  %t1391 = icmp eq i32 %t1385, 4
  %t1392 = select i1 %t1391, i8* %t1390, i8* null
  %t1393 = getelementptr inbounds %Statement, %Statement* %t1386, i32 0, i32 1
  %t1394 = bitcast [24 x i8]* %t1393 to i8*
  %t1395 = bitcast i8* %t1394 to i8**
  %t1396 = load i8*, i8** %t1395
  %t1397 = icmp eq i32 %t1385, 5
  %t1398 = select i1 %t1397, i8* %t1396, i8* %t1392
  %t1399 = getelementptr inbounds %Statement, %Statement* %t1386, i32 0, i32 1
  %t1400 = bitcast [24 x i8]* %t1399 to i8*
  %t1401 = bitcast i8* %t1400 to i8**
  %t1402 = load i8*, i8** %t1401
  %t1403 = icmp eq i32 %t1385, 7
  %t1404 = select i1 %t1403, i8* %t1402, i8* %t1398
  %t1405 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature zeroinitializer)
  %t1406 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t1405)
  store double %t1406, double* %l14
  %t1407 = load double, double* %l14
  %t1408 = extractvalue %Statement %statement, 0
  %t1409 = alloca %Statement
  store %Statement %statement, %Statement* %t1409
  %t1410 = getelementptr inbounds %Statement, %Statement* %t1409, i32 0, i32 1
  %t1411 = bitcast [24 x i8]* %t1410 to i8*
  %t1412 = bitcast i8* %t1411 to i8**
  %t1413 = load i8*, i8** %t1412
  %t1414 = icmp eq i32 %t1408, 4
  %t1415 = select i1 %t1414, i8* %t1413, i8* null
  %t1416 = getelementptr inbounds %Statement, %Statement* %t1409, i32 0, i32 1
  %t1417 = bitcast [24 x i8]* %t1416 to i8*
  %t1418 = bitcast i8* %t1417 to i8**
  %t1419 = load i8*, i8** %t1418
  %t1420 = icmp eq i32 %t1408, 5
  %t1421 = select i1 %t1420, i8* %t1419, i8* %t1415
  %t1422 = getelementptr inbounds %Statement, %Statement* %t1409, i32 0, i32 1
  %t1423 = bitcast [24 x i8]* %t1422 to i8*
  %t1424 = bitcast i8* %t1423 to i8**
  %t1425 = load i8*, i8** %t1424
  %t1426 = icmp eq i32 %t1408, 7
  %t1427 = select i1 %t1426, i8* %t1425, i8* %t1421
  %t1428 = extractvalue %Statement %statement, 0
  %t1429 = alloca %Statement
  store %Statement %statement, %Statement* %t1429
  %t1430 = getelementptr inbounds %Statement, %Statement* %t1429, i32 0, i32 1
  %t1431 = bitcast [24 x i8]* %t1430 to i8*
  %t1432 = getelementptr inbounds i8, i8* %t1431, i64 8
  %t1433 = bitcast i8* %t1432 to i8**
  %t1434 = load i8*, i8** %t1433
  %t1435 = icmp eq i32 %t1428, 4
  %t1436 = select i1 %t1435, i8* %t1434, i8* null
  %t1437 = getelementptr inbounds %Statement, %Statement* %t1429, i32 0, i32 1
  %t1438 = bitcast [24 x i8]* %t1437 to i8*
  %t1439 = getelementptr inbounds i8, i8* %t1438, i64 8
  %t1440 = bitcast i8* %t1439 to i8**
  %t1441 = load i8*, i8** %t1440
  %t1442 = icmp eq i32 %t1428, 5
  %t1443 = select i1 %t1442, i8* %t1441, i8* %t1436
  %t1444 = getelementptr inbounds %Statement, %Statement* %t1429, i32 0, i32 1
  %t1445 = bitcast [40 x i8]* %t1444 to i8*
  %t1446 = getelementptr inbounds i8, i8* %t1445, i64 16
  %t1447 = bitcast i8* %t1446 to i8**
  %t1448 = load i8*, i8** %t1447
  %t1449 = icmp eq i32 %t1428, 6
  %t1450 = select i1 %t1449, i8* %t1448, i8* %t1443
  %t1451 = getelementptr inbounds %Statement, %Statement* %t1429, i32 0, i32 1
  %t1452 = bitcast [24 x i8]* %t1451 to i8*
  %t1453 = getelementptr inbounds i8, i8* %t1452, i64 8
  %t1454 = bitcast i8* %t1453 to i8**
  %t1455 = load i8*, i8** %t1454
  %t1456 = icmp eq i32 %t1428, 7
  %t1457 = select i1 %t1456, i8* %t1455, i8* %t1450
  %t1458 = getelementptr inbounds %Statement, %Statement* %t1429, i32 0, i32 1
  %t1459 = bitcast [40 x i8]* %t1458 to i8*
  %t1460 = getelementptr inbounds i8, i8* %t1459, i64 24
  %t1461 = bitcast i8* %t1460 to i8**
  %t1462 = load i8*, i8** %t1461
  %t1463 = icmp eq i32 %t1428, 12
  %t1464 = select i1 %t1463, i8* %t1462, i8* %t1457
  %t1465 = getelementptr inbounds %Statement, %Statement* %t1429, i32 0, i32 1
  %t1466 = bitcast [24 x i8]* %t1465 to i8*
  %t1467 = getelementptr inbounds i8, i8* %t1466, i64 8
  %t1468 = bitcast i8* %t1467 to i8**
  %t1469 = load i8*, i8** %t1468
  %t1470 = icmp eq i32 %t1428, 13
  %t1471 = select i1 %t1470, i8* %t1469, i8* %t1464
  %t1472 = getelementptr inbounds %Statement, %Statement* %t1429, i32 0, i32 1
  %t1473 = bitcast [24 x i8]* %t1472 to i8*
  %t1474 = getelementptr inbounds i8, i8* %t1473, i64 8
  %t1475 = bitcast i8* %t1474 to i8**
  %t1476 = load i8*, i8** %t1475
  %t1477 = icmp eq i32 %t1428, 14
  %t1478 = select i1 %t1477, i8* %t1476, i8* %t1471
  %t1479 = getelementptr inbounds %Statement, %Statement* %t1429, i32 0, i32 1
  %t1480 = bitcast [16 x i8]* %t1479 to i8*
  %t1481 = bitcast i8* %t1480 to i8**
  %t1482 = load i8*, i8** %t1481
  %t1483 = icmp eq i32 %t1428, 15
  %t1484 = select i1 %t1483, i8* %t1482, i8* %t1478
  %t1485 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature zeroinitializer, %Block zeroinitializer, { %Statement*, i64 }* %interfaces)
  %t1486 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t1485)
  store double %t1486, double* %l14
  %t1487 = load double, double* %l13
  %t1488 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t1489 = load double, double* %l14
  %t1490 = insertvalue %ScopeResult %t1488, { i8**, i64 }* null, 1
  ret %ScopeResult %t1490
merge19:
  %t1491 = extractvalue %Statement %statement, 0
  %t1492 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1493 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1494 = icmp eq i32 %t1491, 0
  %t1495 = select i1 %t1494, i8* %t1493, i8* %t1492
  %t1496 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1497 = icmp eq i32 %t1491, 1
  %t1498 = select i1 %t1497, i8* %t1496, i8* %t1495
  %t1499 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1500 = icmp eq i32 %t1491, 2
  %t1501 = select i1 %t1500, i8* %t1499, i8* %t1498
  %t1502 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1503 = icmp eq i32 %t1491, 3
  %t1504 = select i1 %t1503, i8* %t1502, i8* %t1501
  %t1505 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1506 = icmp eq i32 %t1491, 4
  %t1507 = select i1 %t1506, i8* %t1505, i8* %t1504
  %t1508 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1509 = icmp eq i32 %t1491, 5
  %t1510 = select i1 %t1509, i8* %t1508, i8* %t1507
  %t1511 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1512 = icmp eq i32 %t1491, 6
  %t1513 = select i1 %t1512, i8* %t1511, i8* %t1510
  %t1514 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1515 = icmp eq i32 %t1491, 7
  %t1516 = select i1 %t1515, i8* %t1514, i8* %t1513
  %t1517 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1518 = icmp eq i32 %t1491, 8
  %t1519 = select i1 %t1518, i8* %t1517, i8* %t1516
  %t1520 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1521 = icmp eq i32 %t1491, 9
  %t1522 = select i1 %t1521, i8* %t1520, i8* %t1519
  %t1523 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1524 = icmp eq i32 %t1491, 10
  %t1525 = select i1 %t1524, i8* %t1523, i8* %t1522
  %t1526 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1527 = icmp eq i32 %t1491, 11
  %t1528 = select i1 %t1527, i8* %t1526, i8* %t1525
  %t1529 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1530 = icmp eq i32 %t1491, 12
  %t1531 = select i1 %t1530, i8* %t1529, i8* %t1528
  %t1532 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1533 = icmp eq i32 %t1491, 13
  %t1534 = select i1 %t1533, i8* %t1532, i8* %t1531
  %t1535 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1536 = icmp eq i32 %t1491, 14
  %t1537 = select i1 %t1536, i8* %t1535, i8* %t1534
  %t1538 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1539 = icmp eq i32 %t1491, 15
  %t1540 = select i1 %t1539, i8* %t1538, i8* %t1537
  %t1541 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1542 = icmp eq i32 %t1491, 16
  %t1543 = select i1 %t1542, i8* %t1541, i8* %t1540
  %t1544 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1545 = icmp eq i32 %t1491, 17
  %t1546 = select i1 %t1545, i8* %t1544, i8* %t1543
  %t1547 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1548 = icmp eq i32 %t1491, 18
  %t1549 = select i1 %t1548, i8* %t1547, i8* %t1546
  %t1550 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1551 = icmp eq i32 %t1491, 19
  %t1552 = select i1 %t1551, i8* %t1550, i8* %t1549
  %t1553 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1554 = icmp eq i32 %t1491, 20
  %t1555 = select i1 %t1554, i8* %t1553, i8* %t1552
  %t1556 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1557 = icmp eq i32 %t1491, 21
  %t1558 = select i1 %t1557, i8* %t1556, i8* %t1555
  %t1559 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1560 = icmp eq i32 %t1491, 22
  %t1561 = select i1 %t1560, i8* %t1559, i8* %t1558
  %s1562 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1562, i32 0, i32 0
  %t1563 = icmp eq i8* %t1561, %s1562
  br i1 %t1563, label %then20, label %merge21
then20:
  %t1564 = extractvalue %Statement %statement, 0
  %t1565 = alloca %Statement
  store %Statement %statement, %Statement* %t1565
  %t1566 = getelementptr inbounds %Statement, %Statement* %t1565, i32 0, i32 1
  %t1567 = bitcast [24 x i8]* %t1566 to i8*
  %t1568 = bitcast i8* %t1567 to i8**
  %t1569 = load i8*, i8** %t1568
  %t1570 = icmp eq i32 %t1564, 4
  %t1571 = select i1 %t1570, i8* %t1569, i8* null
  %t1572 = getelementptr inbounds %Statement, %Statement* %t1565, i32 0, i32 1
  %t1573 = bitcast [24 x i8]* %t1572 to i8*
  %t1574 = bitcast i8* %t1573 to i8**
  %t1575 = load i8*, i8** %t1574
  %t1576 = icmp eq i32 %t1564, 5
  %t1577 = select i1 %t1576, i8* %t1575, i8* %t1571
  %t1578 = getelementptr inbounds %Statement, %Statement* %t1565, i32 0, i32 1
  %t1579 = bitcast [24 x i8]* %t1578 to i8*
  %t1580 = bitcast i8* %t1579 to i8**
  %t1581 = load i8*, i8** %t1580
  %t1582 = icmp eq i32 %t1564, 7
  %t1583 = select i1 %t1582, i8* %t1581, i8* %t1577
  %s1584 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1584, i32 0, i32 0
  %t1585 = extractvalue %Statement %statement, 0
  %t1586 = alloca %Statement
  store %Statement %statement, %Statement* %t1586
  %t1587 = getelementptr inbounds %Statement, %Statement* %t1586, i32 0, i32 1
  %t1588 = bitcast [24 x i8]* %t1587 to i8*
  %t1589 = bitcast i8* %t1588 to i8**
  %t1590 = load i8*, i8** %t1589
  %t1591 = icmp eq i32 %t1585, 4
  %t1592 = select i1 %t1591, i8* %t1590, i8* null
  %t1593 = getelementptr inbounds %Statement, %Statement* %t1586, i32 0, i32 1
  %t1594 = bitcast [24 x i8]* %t1593 to i8*
  %t1595 = bitcast i8* %t1594 to i8**
  %t1596 = load i8*, i8** %t1595
  %t1597 = icmp eq i32 %t1585, 5
  %t1598 = select i1 %t1597, i8* %t1596, i8* %t1592
  %t1599 = getelementptr inbounds %Statement, %Statement* %t1586, i32 0, i32 1
  %t1600 = bitcast [24 x i8]* %t1599 to i8*
  %t1601 = bitcast i8* %t1600 to i8**
  %t1602 = load i8*, i8** %t1601
  %t1603 = icmp eq i32 %t1585, 7
  %t1604 = select i1 %t1603, i8* %t1602, i8* %t1598
  store double 0.0, double* %l15
  %t1605 = load double, double* %l15
  store double 0.0, double* %l16
  %t1606 = load double, double* %l16
  %t1607 = extractvalue %Statement %statement, 0
  %t1608 = alloca %Statement
  store %Statement %statement, %Statement* %t1608
  %t1609 = getelementptr inbounds %Statement, %Statement* %t1608, i32 0, i32 1
  %t1610 = bitcast [24 x i8]* %t1609 to i8*
  %t1611 = bitcast i8* %t1610 to i8**
  %t1612 = load i8*, i8** %t1611
  %t1613 = icmp eq i32 %t1607, 4
  %t1614 = select i1 %t1613, i8* %t1612, i8* null
  %t1615 = getelementptr inbounds %Statement, %Statement* %t1608, i32 0, i32 1
  %t1616 = bitcast [24 x i8]* %t1615 to i8*
  %t1617 = bitcast i8* %t1616 to i8**
  %t1618 = load i8*, i8** %t1617
  %t1619 = icmp eq i32 %t1607, 5
  %t1620 = select i1 %t1619, i8* %t1618, i8* %t1614
  %t1621 = getelementptr inbounds %Statement, %Statement* %t1608, i32 0, i32 1
  %t1622 = bitcast [24 x i8]* %t1621 to i8*
  %t1623 = bitcast i8* %t1622 to i8**
  %t1624 = load i8*, i8** %t1623
  %t1625 = icmp eq i32 %t1607, 7
  %t1626 = select i1 %t1625, i8* %t1624, i8* %t1620
  %t1627 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature zeroinitializer)
  %t1628 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t1627)
  store double %t1628, double* %l16
  %t1629 = load double, double* %l16
  %t1630 = extractvalue %Statement %statement, 0
  %t1631 = alloca %Statement
  store %Statement %statement, %Statement* %t1631
  %t1632 = getelementptr inbounds %Statement, %Statement* %t1631, i32 0, i32 1
  %t1633 = bitcast [24 x i8]* %t1632 to i8*
  %t1634 = bitcast i8* %t1633 to i8**
  %t1635 = load i8*, i8** %t1634
  %t1636 = icmp eq i32 %t1630, 4
  %t1637 = select i1 %t1636, i8* %t1635, i8* null
  %t1638 = getelementptr inbounds %Statement, %Statement* %t1631, i32 0, i32 1
  %t1639 = bitcast [24 x i8]* %t1638 to i8*
  %t1640 = bitcast i8* %t1639 to i8**
  %t1641 = load i8*, i8** %t1640
  %t1642 = icmp eq i32 %t1630, 5
  %t1643 = select i1 %t1642, i8* %t1641, i8* %t1637
  %t1644 = getelementptr inbounds %Statement, %Statement* %t1631, i32 0, i32 1
  %t1645 = bitcast [24 x i8]* %t1644 to i8*
  %t1646 = bitcast i8* %t1645 to i8**
  %t1647 = load i8*, i8** %t1646
  %t1648 = icmp eq i32 %t1630, 7
  %t1649 = select i1 %t1648, i8* %t1647, i8* %t1643
  %t1650 = extractvalue %Statement %statement, 0
  %t1651 = alloca %Statement
  store %Statement %statement, %Statement* %t1651
  %t1652 = getelementptr inbounds %Statement, %Statement* %t1651, i32 0, i32 1
  %t1653 = bitcast [24 x i8]* %t1652 to i8*
  %t1654 = getelementptr inbounds i8, i8* %t1653, i64 8
  %t1655 = bitcast i8* %t1654 to i8**
  %t1656 = load i8*, i8** %t1655
  %t1657 = icmp eq i32 %t1650, 4
  %t1658 = select i1 %t1657, i8* %t1656, i8* null
  %t1659 = getelementptr inbounds %Statement, %Statement* %t1651, i32 0, i32 1
  %t1660 = bitcast [24 x i8]* %t1659 to i8*
  %t1661 = getelementptr inbounds i8, i8* %t1660, i64 8
  %t1662 = bitcast i8* %t1661 to i8**
  %t1663 = load i8*, i8** %t1662
  %t1664 = icmp eq i32 %t1650, 5
  %t1665 = select i1 %t1664, i8* %t1663, i8* %t1658
  %t1666 = getelementptr inbounds %Statement, %Statement* %t1651, i32 0, i32 1
  %t1667 = bitcast [40 x i8]* %t1666 to i8*
  %t1668 = getelementptr inbounds i8, i8* %t1667, i64 16
  %t1669 = bitcast i8* %t1668 to i8**
  %t1670 = load i8*, i8** %t1669
  %t1671 = icmp eq i32 %t1650, 6
  %t1672 = select i1 %t1671, i8* %t1670, i8* %t1665
  %t1673 = getelementptr inbounds %Statement, %Statement* %t1651, i32 0, i32 1
  %t1674 = bitcast [24 x i8]* %t1673 to i8*
  %t1675 = getelementptr inbounds i8, i8* %t1674, i64 8
  %t1676 = bitcast i8* %t1675 to i8**
  %t1677 = load i8*, i8** %t1676
  %t1678 = icmp eq i32 %t1650, 7
  %t1679 = select i1 %t1678, i8* %t1677, i8* %t1672
  %t1680 = getelementptr inbounds %Statement, %Statement* %t1651, i32 0, i32 1
  %t1681 = bitcast [40 x i8]* %t1680 to i8*
  %t1682 = getelementptr inbounds i8, i8* %t1681, i64 24
  %t1683 = bitcast i8* %t1682 to i8**
  %t1684 = load i8*, i8** %t1683
  %t1685 = icmp eq i32 %t1650, 12
  %t1686 = select i1 %t1685, i8* %t1684, i8* %t1679
  %t1687 = getelementptr inbounds %Statement, %Statement* %t1651, i32 0, i32 1
  %t1688 = bitcast [24 x i8]* %t1687 to i8*
  %t1689 = getelementptr inbounds i8, i8* %t1688, i64 8
  %t1690 = bitcast i8* %t1689 to i8**
  %t1691 = load i8*, i8** %t1690
  %t1692 = icmp eq i32 %t1650, 13
  %t1693 = select i1 %t1692, i8* %t1691, i8* %t1686
  %t1694 = getelementptr inbounds %Statement, %Statement* %t1651, i32 0, i32 1
  %t1695 = bitcast [24 x i8]* %t1694 to i8*
  %t1696 = getelementptr inbounds i8, i8* %t1695, i64 8
  %t1697 = bitcast i8* %t1696 to i8**
  %t1698 = load i8*, i8** %t1697
  %t1699 = icmp eq i32 %t1650, 14
  %t1700 = select i1 %t1699, i8* %t1698, i8* %t1693
  %t1701 = getelementptr inbounds %Statement, %Statement* %t1651, i32 0, i32 1
  %t1702 = bitcast [16 x i8]* %t1701 to i8*
  %t1703 = bitcast i8* %t1702 to i8**
  %t1704 = load i8*, i8** %t1703
  %t1705 = icmp eq i32 %t1650, 15
  %t1706 = select i1 %t1705, i8* %t1704, i8* %t1700
  %t1707 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature zeroinitializer, %Block zeroinitializer, { %Statement*, i64 }* %interfaces)
  %t1708 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t1707)
  store double %t1708, double* %l16
  %t1709 = load double, double* %l15
  %t1710 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t1711 = load double, double* %l16
  %t1712 = insertvalue %ScopeResult %t1710, { i8**, i64 }* null, 1
  ret %ScopeResult %t1712
merge21:
  %t1713 = extractvalue %Statement %statement, 0
  %t1714 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1715 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1716 = icmp eq i32 %t1713, 0
  %t1717 = select i1 %t1716, i8* %t1715, i8* %t1714
  %t1718 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1719 = icmp eq i32 %t1713, 1
  %t1720 = select i1 %t1719, i8* %t1718, i8* %t1717
  %t1721 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1722 = icmp eq i32 %t1713, 2
  %t1723 = select i1 %t1722, i8* %t1721, i8* %t1720
  %t1724 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1725 = icmp eq i32 %t1713, 3
  %t1726 = select i1 %t1725, i8* %t1724, i8* %t1723
  %t1727 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1728 = icmp eq i32 %t1713, 4
  %t1729 = select i1 %t1728, i8* %t1727, i8* %t1726
  %t1730 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1731 = icmp eq i32 %t1713, 5
  %t1732 = select i1 %t1731, i8* %t1730, i8* %t1729
  %t1733 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1734 = icmp eq i32 %t1713, 6
  %t1735 = select i1 %t1734, i8* %t1733, i8* %t1732
  %t1736 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1737 = icmp eq i32 %t1713, 7
  %t1738 = select i1 %t1737, i8* %t1736, i8* %t1735
  %t1739 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1740 = icmp eq i32 %t1713, 8
  %t1741 = select i1 %t1740, i8* %t1739, i8* %t1738
  %t1742 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1743 = icmp eq i32 %t1713, 9
  %t1744 = select i1 %t1743, i8* %t1742, i8* %t1741
  %t1745 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1746 = icmp eq i32 %t1713, 10
  %t1747 = select i1 %t1746, i8* %t1745, i8* %t1744
  %t1748 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1749 = icmp eq i32 %t1713, 11
  %t1750 = select i1 %t1749, i8* %t1748, i8* %t1747
  %t1751 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1752 = icmp eq i32 %t1713, 12
  %t1753 = select i1 %t1752, i8* %t1751, i8* %t1750
  %t1754 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1755 = icmp eq i32 %t1713, 13
  %t1756 = select i1 %t1755, i8* %t1754, i8* %t1753
  %t1757 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1758 = icmp eq i32 %t1713, 14
  %t1759 = select i1 %t1758, i8* %t1757, i8* %t1756
  %t1760 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1761 = icmp eq i32 %t1713, 15
  %t1762 = select i1 %t1761, i8* %t1760, i8* %t1759
  %t1763 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1764 = icmp eq i32 %t1713, 16
  %t1765 = select i1 %t1764, i8* %t1763, i8* %t1762
  %t1766 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1767 = icmp eq i32 %t1713, 17
  %t1768 = select i1 %t1767, i8* %t1766, i8* %t1765
  %t1769 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1770 = icmp eq i32 %t1713, 18
  %t1771 = select i1 %t1770, i8* %t1769, i8* %t1768
  %t1772 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1773 = icmp eq i32 %t1713, 19
  %t1774 = select i1 %t1773, i8* %t1772, i8* %t1771
  %t1775 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1776 = icmp eq i32 %t1713, 20
  %t1777 = select i1 %t1776, i8* %t1775, i8* %t1774
  %t1778 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1779 = icmp eq i32 %t1713, 21
  %t1780 = select i1 %t1779, i8* %t1778, i8* %t1777
  %t1781 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1782 = icmp eq i32 %t1713, 22
  %t1783 = select i1 %t1782, i8* %t1781, i8* %t1780
  %s1784 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1784, i32 0, i32 0
  %t1785 = icmp eq i8* %t1783, %s1784
  br i1 %t1785, label %then22, label %merge23
then22:
  %t1786 = extractvalue %Statement %statement, 0
  %t1787 = alloca %Statement
  store %Statement %statement, %Statement* %t1787
  %t1788 = getelementptr inbounds %Statement, %Statement* %t1787, i32 0, i32 1
  %t1789 = bitcast [48 x i8]* %t1788 to i8*
  %t1790 = bitcast i8* %t1789 to i8**
  %t1791 = load i8*, i8** %t1790
  %t1792 = icmp eq i32 %t1786, 2
  %t1793 = select i1 %t1792, i8* %t1791, i8* null
  %t1794 = getelementptr inbounds %Statement, %Statement* %t1787, i32 0, i32 1
  %t1795 = bitcast [48 x i8]* %t1794 to i8*
  %t1796 = bitcast i8* %t1795 to i8**
  %t1797 = load i8*, i8** %t1796
  %t1798 = icmp eq i32 %t1786, 3
  %t1799 = select i1 %t1798, i8* %t1797, i8* %t1793
  %t1800 = getelementptr inbounds %Statement, %Statement* %t1787, i32 0, i32 1
  %t1801 = bitcast [40 x i8]* %t1800 to i8*
  %t1802 = bitcast i8* %t1801 to i8**
  %t1803 = load i8*, i8** %t1802
  %t1804 = icmp eq i32 %t1786, 6
  %t1805 = select i1 %t1804, i8* %t1803, i8* %t1799
  %t1806 = getelementptr inbounds %Statement, %Statement* %t1787, i32 0, i32 1
  %t1807 = bitcast [56 x i8]* %t1806 to i8*
  %t1808 = bitcast i8* %t1807 to i8**
  %t1809 = load i8*, i8** %t1808
  %t1810 = icmp eq i32 %t1786, 8
  %t1811 = select i1 %t1810, i8* %t1809, i8* %t1805
  %t1812 = getelementptr inbounds %Statement, %Statement* %t1787, i32 0, i32 1
  %t1813 = bitcast [40 x i8]* %t1812 to i8*
  %t1814 = bitcast i8* %t1813 to i8**
  %t1815 = load i8*, i8** %t1814
  %t1816 = icmp eq i32 %t1786, 9
  %t1817 = select i1 %t1816, i8* %t1815, i8* %t1811
  %t1818 = getelementptr inbounds %Statement, %Statement* %t1787, i32 0, i32 1
  %t1819 = bitcast [40 x i8]* %t1818 to i8*
  %t1820 = bitcast i8* %t1819 to i8**
  %t1821 = load i8*, i8** %t1820
  %t1822 = icmp eq i32 %t1786, 10
  %t1823 = select i1 %t1822, i8* %t1821, i8* %t1817
  %t1824 = getelementptr inbounds %Statement, %Statement* %t1787, i32 0, i32 1
  %t1825 = bitcast [40 x i8]* %t1824 to i8*
  %t1826 = bitcast i8* %t1825 to i8**
  %t1827 = load i8*, i8** %t1826
  %t1828 = icmp eq i32 %t1786, 11
  %t1829 = select i1 %t1828, i8* %t1827, i8* %t1823
  %s1830 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1830, i32 0, i32 0
  %t1831 = extractvalue %Statement %statement, 0
  %t1832 = alloca %Statement
  store %Statement %statement, %Statement* %t1832
  %t1833 = getelementptr inbounds %Statement, %Statement* %t1832, i32 0, i32 1
  %t1834 = bitcast [48 x i8]* %t1833 to i8*
  %t1835 = getelementptr inbounds i8, i8* %t1834, i64 8
  %t1836 = bitcast i8* %t1835 to i8**
  %t1837 = load i8*, i8** %t1836
  %t1838 = icmp eq i32 %t1831, 3
  %t1839 = select i1 %t1838, i8* %t1837, i8* null
  %t1840 = getelementptr inbounds %Statement, %Statement* %t1832, i32 0, i32 1
  %t1841 = bitcast [40 x i8]* %t1840 to i8*
  %t1842 = getelementptr inbounds i8, i8* %t1841, i64 8
  %t1843 = bitcast i8* %t1842 to i8**
  %t1844 = load i8*, i8** %t1843
  %t1845 = icmp eq i32 %t1831, 6
  %t1846 = select i1 %t1845, i8* %t1844, i8* %t1839
  %t1847 = getelementptr inbounds %Statement, %Statement* %t1832, i32 0, i32 1
  %t1848 = bitcast [56 x i8]* %t1847 to i8*
  %t1849 = getelementptr inbounds i8, i8* %t1848, i64 8
  %t1850 = bitcast i8* %t1849 to i8**
  %t1851 = load i8*, i8** %t1850
  %t1852 = icmp eq i32 %t1831, 8
  %t1853 = select i1 %t1852, i8* %t1851, i8* %t1846
  %t1854 = getelementptr inbounds %Statement, %Statement* %t1832, i32 0, i32 1
  %t1855 = bitcast [40 x i8]* %t1854 to i8*
  %t1856 = getelementptr inbounds i8, i8* %t1855, i64 8
  %t1857 = bitcast i8* %t1856 to i8**
  %t1858 = load i8*, i8** %t1857
  %t1859 = icmp eq i32 %t1831, 9
  %t1860 = select i1 %t1859, i8* %t1858, i8* %t1853
  %t1861 = getelementptr inbounds %Statement, %Statement* %t1832, i32 0, i32 1
  %t1862 = bitcast [40 x i8]* %t1861 to i8*
  %t1863 = getelementptr inbounds i8, i8* %t1862, i64 8
  %t1864 = bitcast i8* %t1863 to i8**
  %t1865 = load i8*, i8** %t1864
  %t1866 = icmp eq i32 %t1831, 10
  %t1867 = select i1 %t1866, i8* %t1865, i8* %t1860
  %t1868 = getelementptr inbounds %Statement, %Statement* %t1832, i32 0, i32 1
  %t1869 = bitcast [40 x i8]* %t1868 to i8*
  %t1870 = getelementptr inbounds i8, i8* %t1869, i64 8
  %t1871 = bitcast i8* %t1870 to i8**
  %t1872 = load i8*, i8** %t1871
  %t1873 = icmp eq i32 %t1831, 11
  %t1874 = select i1 %t1873, i8* %t1872, i8* %t1867
  %t1875 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1829, i8* %s1830, i8* %t1874)
  store %ScopeResult %t1875, %ScopeResult* %l17
  %t1876 = load %ScopeResult, %ScopeResult* %l17
  %t1877 = extractvalue %ScopeResult %t1876, 1
  %t1878 = extractvalue %Statement %statement, 0
  %t1879 = alloca %Statement
  store %Statement %statement, %Statement* %t1879
  %t1880 = getelementptr inbounds %Statement, %Statement* %t1879, i32 0, i32 1
  %t1881 = bitcast [24 x i8]* %t1880 to i8*
  %t1882 = getelementptr inbounds i8, i8* %t1881, i64 8
  %t1883 = bitcast i8* %t1882 to i8**
  %t1884 = load i8*, i8** %t1883
  %t1885 = icmp eq i32 %t1878, 4
  %t1886 = select i1 %t1885, i8* %t1884, i8* null
  %t1887 = getelementptr inbounds %Statement, %Statement* %t1879, i32 0, i32 1
  %t1888 = bitcast [24 x i8]* %t1887 to i8*
  %t1889 = getelementptr inbounds i8, i8* %t1888, i64 8
  %t1890 = bitcast i8* %t1889 to i8**
  %t1891 = load i8*, i8** %t1890
  %t1892 = icmp eq i32 %t1878, 5
  %t1893 = select i1 %t1892, i8* %t1891, i8* %t1886
  %t1894 = getelementptr inbounds %Statement, %Statement* %t1879, i32 0, i32 1
  %t1895 = bitcast [40 x i8]* %t1894 to i8*
  %t1896 = getelementptr inbounds i8, i8* %t1895, i64 16
  %t1897 = bitcast i8* %t1896 to i8**
  %t1898 = load i8*, i8** %t1897
  %t1899 = icmp eq i32 %t1878, 6
  %t1900 = select i1 %t1899, i8* %t1898, i8* %t1893
  %t1901 = getelementptr inbounds %Statement, %Statement* %t1879, i32 0, i32 1
  %t1902 = bitcast [24 x i8]* %t1901 to i8*
  %t1903 = getelementptr inbounds i8, i8* %t1902, i64 8
  %t1904 = bitcast i8* %t1903 to i8**
  %t1905 = load i8*, i8** %t1904
  %t1906 = icmp eq i32 %t1878, 7
  %t1907 = select i1 %t1906, i8* %t1905, i8* %t1900
  %t1908 = getelementptr inbounds %Statement, %Statement* %t1879, i32 0, i32 1
  %t1909 = bitcast [40 x i8]* %t1908 to i8*
  %t1910 = getelementptr inbounds i8, i8* %t1909, i64 24
  %t1911 = bitcast i8* %t1910 to i8**
  %t1912 = load i8*, i8** %t1911
  %t1913 = icmp eq i32 %t1878, 12
  %t1914 = select i1 %t1913, i8* %t1912, i8* %t1907
  %t1915 = getelementptr inbounds %Statement, %Statement* %t1879, i32 0, i32 1
  %t1916 = bitcast [24 x i8]* %t1915 to i8*
  %t1917 = getelementptr inbounds i8, i8* %t1916, i64 8
  %t1918 = bitcast i8* %t1917 to i8**
  %t1919 = load i8*, i8** %t1918
  %t1920 = icmp eq i32 %t1878, 13
  %t1921 = select i1 %t1920, i8* %t1919, i8* %t1914
  %t1922 = getelementptr inbounds %Statement, %Statement* %t1879, i32 0, i32 1
  %t1923 = bitcast [24 x i8]* %t1922 to i8*
  %t1924 = getelementptr inbounds i8, i8* %t1923, i64 8
  %t1925 = bitcast i8* %t1924 to i8**
  %t1926 = load i8*, i8** %t1925
  %t1927 = icmp eq i32 %t1878, 14
  %t1928 = select i1 %t1927, i8* %t1926, i8* %t1921
  %t1929 = getelementptr inbounds %Statement, %Statement* %t1879, i32 0, i32 1
  %t1930 = bitcast [16 x i8]* %t1929 to i8*
  %t1931 = bitcast i8* %t1930 to i8**
  %t1932 = load i8*, i8** %t1931
  %t1933 = icmp eq i32 %t1878, 15
  %t1934 = select i1 %t1933, i8* %t1932, i8* %t1928
  %t1935 = alloca [0 x double]
  %t1936 = getelementptr [0 x double], [0 x double]* %t1935, i32 0, i32 0
  %t1937 = alloca { double*, i64 }
  %t1938 = getelementptr { double*, i64 }, { double*, i64 }* %t1937, i32 0, i32 0
  store double* %t1936, double** %t1938
  %t1939 = getelementptr { double*, i64 }, { double*, i64 }* %t1937, i32 0, i32 1
  store i64 0, i64* %t1939
  %t1940 = bitcast { double*, i64 }* %t1937 to { %SymbolEntry*, i64 }*
  %t1941 = call { %Diagnostic*, i64 }* @check_block(%Block zeroinitializer, { %SymbolEntry*, i64 }* %t1940, { %Statement*, i64 }* %interfaces)
  %t1942 = bitcast { %Diagnostic*, i64 }* %t1941 to { i8**, i64 }*
  %t1943 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1877, { i8**, i64 }* %t1942)
  store { i8**, i64 }* %t1943, { i8**, i64 }** %l18
  %t1944 = load %ScopeResult, %ScopeResult* %l17
  %t1945 = extractvalue %ScopeResult %t1944, 0
  %t1946 = insertvalue %ScopeResult undef, { i8**, i64 }* %t1945, 0
  %t1947 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t1948 = insertvalue %ScopeResult %t1946, { i8**, i64 }* %t1947, 1
  ret %ScopeResult %t1948
merge23:
  %t1949 = extractvalue %Statement %statement, 0
  %t1950 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1951 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1952 = icmp eq i32 %t1949, 0
  %t1953 = select i1 %t1952, i8* %t1951, i8* %t1950
  %t1954 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1955 = icmp eq i32 %t1949, 1
  %t1956 = select i1 %t1955, i8* %t1954, i8* %t1953
  %t1957 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1958 = icmp eq i32 %t1949, 2
  %t1959 = select i1 %t1958, i8* %t1957, i8* %t1956
  %t1960 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1961 = icmp eq i32 %t1949, 3
  %t1962 = select i1 %t1961, i8* %t1960, i8* %t1959
  %t1963 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1964 = icmp eq i32 %t1949, 4
  %t1965 = select i1 %t1964, i8* %t1963, i8* %t1962
  %t1966 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1967 = icmp eq i32 %t1949, 5
  %t1968 = select i1 %t1967, i8* %t1966, i8* %t1965
  %t1969 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1970 = icmp eq i32 %t1949, 6
  %t1971 = select i1 %t1970, i8* %t1969, i8* %t1968
  %t1972 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1973 = icmp eq i32 %t1949, 7
  %t1974 = select i1 %t1973, i8* %t1972, i8* %t1971
  %t1975 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1976 = icmp eq i32 %t1949, 8
  %t1977 = select i1 %t1976, i8* %t1975, i8* %t1974
  %t1978 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1979 = icmp eq i32 %t1949, 9
  %t1980 = select i1 %t1979, i8* %t1978, i8* %t1977
  %t1981 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1982 = icmp eq i32 %t1949, 10
  %t1983 = select i1 %t1982, i8* %t1981, i8* %t1980
  %t1984 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1985 = icmp eq i32 %t1949, 11
  %t1986 = select i1 %t1985, i8* %t1984, i8* %t1983
  %t1987 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1988 = icmp eq i32 %t1949, 12
  %t1989 = select i1 %t1988, i8* %t1987, i8* %t1986
  %t1990 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1991 = icmp eq i32 %t1949, 13
  %t1992 = select i1 %t1991, i8* %t1990, i8* %t1989
  %t1993 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1994 = icmp eq i32 %t1949, 14
  %t1995 = select i1 %t1994, i8* %t1993, i8* %t1992
  %t1996 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1997 = icmp eq i32 %t1949, 15
  %t1998 = select i1 %t1997, i8* %t1996, i8* %t1995
  %t1999 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2000 = icmp eq i32 %t1949, 16
  %t2001 = select i1 %t2000, i8* %t1999, i8* %t1998
  %t2002 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2003 = icmp eq i32 %t1949, 17
  %t2004 = select i1 %t2003, i8* %t2002, i8* %t2001
  %t2005 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2006 = icmp eq i32 %t1949, 18
  %t2007 = select i1 %t2006, i8* %t2005, i8* %t2004
  %t2008 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2009 = icmp eq i32 %t1949, 19
  %t2010 = select i1 %t2009, i8* %t2008, i8* %t2007
  %t2011 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2012 = icmp eq i32 %t1949, 20
  %t2013 = select i1 %t2012, i8* %t2011, i8* %t2010
  %t2014 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2015 = icmp eq i32 %t1949, 21
  %t2016 = select i1 %t2015, i8* %t2014, i8* %t2013
  %t2017 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2018 = icmp eq i32 %t1949, 22
  %t2019 = select i1 %t2018, i8* %t2017, i8* %t2016
  %s2020 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.2020, i32 0, i32 0
  %t2021 = icmp eq i8* %t2019, %s2020
  br i1 %t2021, label %then24, label %merge25
then24:
  %t2022 = bitcast { %SymbolEntry*, i64 }* %bindings to { i8**, i64 }*
  %t2023 = insertvalue %ScopeResult undef, { i8**, i64 }* %t2022, 0
  %t2024 = extractvalue %Statement %statement, 0
  %t2025 = alloca %Statement
  store %Statement %statement, %Statement* %t2025
  %t2026 = getelementptr inbounds %Statement, %Statement* %t2025, i32 0, i32 1
  %t2027 = bitcast [24 x i8]* %t2026 to i8*
  %t2028 = getelementptr inbounds i8, i8* %t2027, i64 8
  %t2029 = bitcast i8* %t2028 to i8**
  %t2030 = load i8*, i8** %t2029
  %t2031 = icmp eq i32 %t2024, 4
  %t2032 = select i1 %t2031, i8* %t2030, i8* null
  %t2033 = getelementptr inbounds %Statement, %Statement* %t2025, i32 0, i32 1
  %t2034 = bitcast [24 x i8]* %t2033 to i8*
  %t2035 = getelementptr inbounds i8, i8* %t2034, i64 8
  %t2036 = bitcast i8* %t2035 to i8**
  %t2037 = load i8*, i8** %t2036
  %t2038 = icmp eq i32 %t2024, 5
  %t2039 = select i1 %t2038, i8* %t2037, i8* %t2032
  %t2040 = getelementptr inbounds %Statement, %Statement* %t2025, i32 0, i32 1
  %t2041 = bitcast [40 x i8]* %t2040 to i8*
  %t2042 = getelementptr inbounds i8, i8* %t2041, i64 16
  %t2043 = bitcast i8* %t2042 to i8**
  %t2044 = load i8*, i8** %t2043
  %t2045 = icmp eq i32 %t2024, 6
  %t2046 = select i1 %t2045, i8* %t2044, i8* %t2039
  %t2047 = getelementptr inbounds %Statement, %Statement* %t2025, i32 0, i32 1
  %t2048 = bitcast [24 x i8]* %t2047 to i8*
  %t2049 = getelementptr inbounds i8, i8* %t2048, i64 8
  %t2050 = bitcast i8* %t2049 to i8**
  %t2051 = load i8*, i8** %t2050
  %t2052 = icmp eq i32 %t2024, 7
  %t2053 = select i1 %t2052, i8* %t2051, i8* %t2046
  %t2054 = getelementptr inbounds %Statement, %Statement* %t2025, i32 0, i32 1
  %t2055 = bitcast [40 x i8]* %t2054 to i8*
  %t2056 = getelementptr inbounds i8, i8* %t2055, i64 24
  %t2057 = bitcast i8* %t2056 to i8**
  %t2058 = load i8*, i8** %t2057
  %t2059 = icmp eq i32 %t2024, 12
  %t2060 = select i1 %t2059, i8* %t2058, i8* %t2053
  %t2061 = getelementptr inbounds %Statement, %Statement* %t2025, i32 0, i32 1
  %t2062 = bitcast [24 x i8]* %t2061 to i8*
  %t2063 = getelementptr inbounds i8, i8* %t2062, i64 8
  %t2064 = bitcast i8* %t2063 to i8**
  %t2065 = load i8*, i8** %t2064
  %t2066 = icmp eq i32 %t2024, 13
  %t2067 = select i1 %t2066, i8* %t2065, i8* %t2060
  %t2068 = getelementptr inbounds %Statement, %Statement* %t2025, i32 0, i32 1
  %t2069 = bitcast [24 x i8]* %t2068 to i8*
  %t2070 = getelementptr inbounds i8, i8* %t2069, i64 8
  %t2071 = bitcast i8* %t2070 to i8**
  %t2072 = load i8*, i8** %t2071
  %t2073 = icmp eq i32 %t2024, 14
  %t2074 = select i1 %t2073, i8* %t2072, i8* %t2067
  %t2075 = getelementptr inbounds %Statement, %Statement* %t2025, i32 0, i32 1
  %t2076 = bitcast [16 x i8]* %t2075 to i8*
  %t2077 = bitcast i8* %t2076 to i8**
  %t2078 = load i8*, i8** %t2077
  %t2079 = icmp eq i32 %t2024, 15
  %t2080 = select i1 %t2079, i8* %t2078, i8* %t2074
  %t2081 = call { %Diagnostic*, i64 }* @check_block(%Block zeroinitializer, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2082 = bitcast { %Diagnostic*, i64 }* %t2081 to { i8**, i64 }*
  %t2083 = insertvalue %ScopeResult %t2023, { i8**, i64 }* %t2082, 1
  ret %ScopeResult %t2083
merge25:
  %t2084 = extractvalue %Statement %statement, 0
  %t2085 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2086 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2087 = icmp eq i32 %t2084, 0
  %t2088 = select i1 %t2087, i8* %t2086, i8* %t2085
  %t2089 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2090 = icmp eq i32 %t2084, 1
  %t2091 = select i1 %t2090, i8* %t2089, i8* %t2088
  %t2092 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2093 = icmp eq i32 %t2084, 2
  %t2094 = select i1 %t2093, i8* %t2092, i8* %t2091
  %t2095 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2096 = icmp eq i32 %t2084, 3
  %t2097 = select i1 %t2096, i8* %t2095, i8* %t2094
  %t2098 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2099 = icmp eq i32 %t2084, 4
  %t2100 = select i1 %t2099, i8* %t2098, i8* %t2097
  %t2101 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2102 = icmp eq i32 %t2084, 5
  %t2103 = select i1 %t2102, i8* %t2101, i8* %t2100
  %t2104 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2105 = icmp eq i32 %t2084, 6
  %t2106 = select i1 %t2105, i8* %t2104, i8* %t2103
  %t2107 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2108 = icmp eq i32 %t2084, 7
  %t2109 = select i1 %t2108, i8* %t2107, i8* %t2106
  %t2110 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2111 = icmp eq i32 %t2084, 8
  %t2112 = select i1 %t2111, i8* %t2110, i8* %t2109
  %t2113 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2114 = icmp eq i32 %t2084, 9
  %t2115 = select i1 %t2114, i8* %t2113, i8* %t2112
  %t2116 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2117 = icmp eq i32 %t2084, 10
  %t2118 = select i1 %t2117, i8* %t2116, i8* %t2115
  %t2119 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2120 = icmp eq i32 %t2084, 11
  %t2121 = select i1 %t2120, i8* %t2119, i8* %t2118
  %t2122 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2123 = icmp eq i32 %t2084, 12
  %t2124 = select i1 %t2123, i8* %t2122, i8* %t2121
  %t2125 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2126 = icmp eq i32 %t2084, 13
  %t2127 = select i1 %t2126, i8* %t2125, i8* %t2124
  %t2128 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2129 = icmp eq i32 %t2084, 14
  %t2130 = select i1 %t2129, i8* %t2128, i8* %t2127
  %t2131 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2132 = icmp eq i32 %t2084, 15
  %t2133 = select i1 %t2132, i8* %t2131, i8* %t2130
  %t2134 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2135 = icmp eq i32 %t2084, 16
  %t2136 = select i1 %t2135, i8* %t2134, i8* %t2133
  %t2137 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2138 = icmp eq i32 %t2084, 17
  %t2139 = select i1 %t2138, i8* %t2137, i8* %t2136
  %t2140 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2141 = icmp eq i32 %t2084, 18
  %t2142 = select i1 %t2141, i8* %t2140, i8* %t2139
  %t2143 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2144 = icmp eq i32 %t2084, 19
  %t2145 = select i1 %t2144, i8* %t2143, i8* %t2142
  %t2146 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2147 = icmp eq i32 %t2084, 20
  %t2148 = select i1 %t2147, i8* %t2146, i8* %t2145
  %t2149 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2150 = icmp eq i32 %t2084, 21
  %t2151 = select i1 %t2150, i8* %t2149, i8* %t2148
  %t2152 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2153 = icmp eq i32 %t2084, 22
  %t2154 = select i1 %t2153, i8* %t2152, i8* %t2151
  %s2155 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.2155, i32 0, i32 0
  %t2156 = icmp eq i8* %t2154, %s2155
  br i1 %t2156, label %then26, label %merge27
then26:
  %t2157 = bitcast { %SymbolEntry*, i64 }* %bindings to { i8**, i64 }*
  %t2158 = insertvalue %ScopeResult undef, { i8**, i64 }* %t2157, 0
  %t2159 = extractvalue %Statement %statement, 0
  %t2160 = alloca %Statement
  store %Statement %statement, %Statement* %t2160
  %t2161 = getelementptr inbounds %Statement, %Statement* %t2160, i32 0, i32 1
  %t2162 = bitcast [24 x i8]* %t2161 to i8*
  %t2163 = getelementptr inbounds i8, i8* %t2162, i64 8
  %t2164 = bitcast i8* %t2163 to i8**
  %t2165 = load i8*, i8** %t2164
  %t2166 = icmp eq i32 %t2159, 4
  %t2167 = select i1 %t2166, i8* %t2165, i8* null
  %t2168 = getelementptr inbounds %Statement, %Statement* %t2160, i32 0, i32 1
  %t2169 = bitcast [24 x i8]* %t2168 to i8*
  %t2170 = getelementptr inbounds i8, i8* %t2169, i64 8
  %t2171 = bitcast i8* %t2170 to i8**
  %t2172 = load i8*, i8** %t2171
  %t2173 = icmp eq i32 %t2159, 5
  %t2174 = select i1 %t2173, i8* %t2172, i8* %t2167
  %t2175 = getelementptr inbounds %Statement, %Statement* %t2160, i32 0, i32 1
  %t2176 = bitcast [40 x i8]* %t2175 to i8*
  %t2177 = getelementptr inbounds i8, i8* %t2176, i64 16
  %t2178 = bitcast i8* %t2177 to i8**
  %t2179 = load i8*, i8** %t2178
  %t2180 = icmp eq i32 %t2159, 6
  %t2181 = select i1 %t2180, i8* %t2179, i8* %t2174
  %t2182 = getelementptr inbounds %Statement, %Statement* %t2160, i32 0, i32 1
  %t2183 = bitcast [24 x i8]* %t2182 to i8*
  %t2184 = getelementptr inbounds i8, i8* %t2183, i64 8
  %t2185 = bitcast i8* %t2184 to i8**
  %t2186 = load i8*, i8** %t2185
  %t2187 = icmp eq i32 %t2159, 7
  %t2188 = select i1 %t2187, i8* %t2186, i8* %t2181
  %t2189 = getelementptr inbounds %Statement, %Statement* %t2160, i32 0, i32 1
  %t2190 = bitcast [40 x i8]* %t2189 to i8*
  %t2191 = getelementptr inbounds i8, i8* %t2190, i64 24
  %t2192 = bitcast i8* %t2191 to i8**
  %t2193 = load i8*, i8** %t2192
  %t2194 = icmp eq i32 %t2159, 12
  %t2195 = select i1 %t2194, i8* %t2193, i8* %t2188
  %t2196 = getelementptr inbounds %Statement, %Statement* %t2160, i32 0, i32 1
  %t2197 = bitcast [24 x i8]* %t2196 to i8*
  %t2198 = getelementptr inbounds i8, i8* %t2197, i64 8
  %t2199 = bitcast i8* %t2198 to i8**
  %t2200 = load i8*, i8** %t2199
  %t2201 = icmp eq i32 %t2159, 13
  %t2202 = select i1 %t2201, i8* %t2200, i8* %t2195
  %t2203 = getelementptr inbounds %Statement, %Statement* %t2160, i32 0, i32 1
  %t2204 = bitcast [24 x i8]* %t2203 to i8*
  %t2205 = getelementptr inbounds i8, i8* %t2204, i64 8
  %t2206 = bitcast i8* %t2205 to i8**
  %t2207 = load i8*, i8** %t2206
  %t2208 = icmp eq i32 %t2159, 14
  %t2209 = select i1 %t2208, i8* %t2207, i8* %t2202
  %t2210 = getelementptr inbounds %Statement, %Statement* %t2160, i32 0, i32 1
  %t2211 = bitcast [16 x i8]* %t2210 to i8*
  %t2212 = bitcast i8* %t2211 to i8**
  %t2213 = load i8*, i8** %t2212
  %t2214 = icmp eq i32 %t2159, 15
  %t2215 = select i1 %t2214, i8* %t2213, i8* %t2209
  %t2216 = call { %Diagnostic*, i64 }* @check_block(%Block zeroinitializer, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2217 = bitcast { %Diagnostic*, i64 }* %t2216 to { i8**, i64 }*
  %t2218 = insertvalue %ScopeResult %t2158, { i8**, i64 }* %t2217, 1
  ret %ScopeResult %t2218
merge27:
  %t2219 = extractvalue %Statement %statement, 0
  %t2220 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2221 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2222 = icmp eq i32 %t2219, 0
  %t2223 = select i1 %t2222, i8* %t2221, i8* %t2220
  %t2224 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2225 = icmp eq i32 %t2219, 1
  %t2226 = select i1 %t2225, i8* %t2224, i8* %t2223
  %t2227 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2228 = icmp eq i32 %t2219, 2
  %t2229 = select i1 %t2228, i8* %t2227, i8* %t2226
  %t2230 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2231 = icmp eq i32 %t2219, 3
  %t2232 = select i1 %t2231, i8* %t2230, i8* %t2229
  %t2233 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2234 = icmp eq i32 %t2219, 4
  %t2235 = select i1 %t2234, i8* %t2233, i8* %t2232
  %t2236 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2237 = icmp eq i32 %t2219, 5
  %t2238 = select i1 %t2237, i8* %t2236, i8* %t2235
  %t2239 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2240 = icmp eq i32 %t2219, 6
  %t2241 = select i1 %t2240, i8* %t2239, i8* %t2238
  %t2242 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2243 = icmp eq i32 %t2219, 7
  %t2244 = select i1 %t2243, i8* %t2242, i8* %t2241
  %t2245 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2246 = icmp eq i32 %t2219, 8
  %t2247 = select i1 %t2246, i8* %t2245, i8* %t2244
  %t2248 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2249 = icmp eq i32 %t2219, 9
  %t2250 = select i1 %t2249, i8* %t2248, i8* %t2247
  %t2251 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2252 = icmp eq i32 %t2219, 10
  %t2253 = select i1 %t2252, i8* %t2251, i8* %t2250
  %t2254 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2255 = icmp eq i32 %t2219, 11
  %t2256 = select i1 %t2255, i8* %t2254, i8* %t2253
  %t2257 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2258 = icmp eq i32 %t2219, 12
  %t2259 = select i1 %t2258, i8* %t2257, i8* %t2256
  %t2260 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2261 = icmp eq i32 %t2219, 13
  %t2262 = select i1 %t2261, i8* %t2260, i8* %t2259
  %t2263 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2264 = icmp eq i32 %t2219, 14
  %t2265 = select i1 %t2264, i8* %t2263, i8* %t2262
  %t2266 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2267 = icmp eq i32 %t2219, 15
  %t2268 = select i1 %t2267, i8* %t2266, i8* %t2265
  %t2269 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2270 = icmp eq i32 %t2219, 16
  %t2271 = select i1 %t2270, i8* %t2269, i8* %t2268
  %t2272 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2273 = icmp eq i32 %t2219, 17
  %t2274 = select i1 %t2273, i8* %t2272, i8* %t2271
  %t2275 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2276 = icmp eq i32 %t2219, 18
  %t2277 = select i1 %t2276, i8* %t2275, i8* %t2274
  %t2278 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2279 = icmp eq i32 %t2219, 19
  %t2280 = select i1 %t2279, i8* %t2278, i8* %t2277
  %t2281 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2282 = icmp eq i32 %t2219, 20
  %t2283 = select i1 %t2282, i8* %t2281, i8* %t2280
  %t2284 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2285 = icmp eq i32 %t2219, 21
  %t2286 = select i1 %t2285, i8* %t2284, i8* %t2283
  %t2287 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2288 = icmp eq i32 %t2219, 22
  %t2289 = select i1 %t2288, i8* %t2287, i8* %t2286
  %s2290 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.2290, i32 0, i32 0
  %t2291 = icmp eq i8* %t2289, %s2290
  br i1 %t2291, label %then28, label %merge29
then28:
  %t2292 = alloca [0 x %Diagnostic]
  %t2293 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t2292, i32 0, i32 0
  %t2294 = alloca { %Diagnostic*, i64 }
  %t2295 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2294, i32 0, i32 0
  store %Diagnostic* %t2293, %Diagnostic** %t2295
  %t2296 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2294, i32 0, i32 1
  store i64 0, i64* %t2296
  store { %Diagnostic*, i64 }* %t2294, { %Diagnostic*, i64 }** %l19
  %t2297 = sitofp i64 0 to double
  store double %t2297, double* %l20
  %t2298 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2299 = load double, double* %l20
  br label %loop.header30
loop.header30:
  %t2339 = phi { %Diagnostic*, i64 }* [ %t2298, %then28 ], [ %t2337, %loop.latch32 ]
  %t2340 = phi double [ %t2299, %then28 ], [ %t2338, %loop.latch32 ]
  store { %Diagnostic*, i64 }* %t2339, { %Diagnostic*, i64 }** %l19
  store double %t2340, double* %l20
  br label %loop.body31
loop.body31:
  %t2300 = load double, double* %l20
  %t2301 = extractvalue %Statement %statement, 0
  %t2302 = alloca %Statement
  store %Statement %statement, %Statement* %t2302
  %t2303 = getelementptr inbounds %Statement, %Statement* %t2302, i32 0, i32 1
  %t2304 = bitcast [24 x i8]* %t2303 to i8*
  %t2305 = getelementptr inbounds i8, i8* %t2304, i64 8
  %t2306 = bitcast i8* %t2305 to { i8**, i64 }**
  %t2307 = load { i8**, i64 }*, { i8**, i64 }** %t2306
  %t2308 = icmp eq i32 %t2301, 18
  %t2309 = select i1 %t2308, { i8**, i64 }* %t2307, { i8**, i64 }* null
  %t2310 = load { i8**, i64 }, { i8**, i64 }* %t2309
  %t2311 = extractvalue { i8**, i64 } %t2310, 1
  %t2312 = sitofp i64 %t2311 to double
  %t2313 = fcmp oge double %t2300, %t2312
  %t2314 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2315 = load double, double* %l20
  br i1 %t2313, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t2316 = extractvalue %Statement %statement, 0
  %t2317 = alloca %Statement
  store %Statement %statement, %Statement* %t2317
  %t2318 = getelementptr inbounds %Statement, %Statement* %t2317, i32 0, i32 1
  %t2319 = bitcast [24 x i8]* %t2318 to i8*
  %t2320 = getelementptr inbounds i8, i8* %t2319, i64 8
  %t2321 = bitcast i8* %t2320 to { i8**, i64 }**
  %t2322 = load { i8**, i64 }*, { i8**, i64 }** %t2321
  %t2323 = icmp eq i32 %t2316, 18
  %t2324 = select i1 %t2323, { i8**, i64 }* %t2322, { i8**, i64 }* null
  %t2325 = load double, double* %l20
  %t2326 = load { i8**, i64 }, { i8**, i64 }* %t2324
  %t2327 = extractvalue { i8**, i64 } %t2326, 0
  %t2328 = extractvalue { i8**, i64 } %t2326, 1
  %t2329 = icmp uge i64 %t2325, %t2328
  ; bounds check: %t2329 (if true, out of bounds)
  %t2330 = getelementptr i8*, i8** %t2327, i64 %t2325
  %t2331 = load i8*, i8** %t2330
  store i8* %t2331, i8** %l21
  %t2332 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2333 = load i8*, i8** %l21
  %t2334 = load double, double* %l20
  %t2335 = sitofp i64 1 to double
  %t2336 = fadd double %t2334, %t2335
  store double %t2336, double* %l20
  br label %loop.latch32
loop.latch32:
  %t2337 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2338 = load double, double* %l20
  br label %loop.header30
afterloop33:
  %t2341 = bitcast { %SymbolEntry*, i64 }* %bindings to { i8**, i64 }*
  %t2342 = insertvalue %ScopeResult undef, { i8**, i64 }* %t2341, 0
  %t2343 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2344 = bitcast { %Diagnostic*, i64 }* %t2343 to { i8**, i64 }*
  %t2345 = insertvalue %ScopeResult %t2342, { i8**, i64 }* %t2344, 1
  ret %ScopeResult %t2345
merge29:
  %t2346 = extractvalue %Statement %statement, 0
  %t2347 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2348 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2349 = icmp eq i32 %t2346, 0
  %t2350 = select i1 %t2349, i8* %t2348, i8* %t2347
  %t2351 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2352 = icmp eq i32 %t2346, 1
  %t2353 = select i1 %t2352, i8* %t2351, i8* %t2350
  %t2354 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2355 = icmp eq i32 %t2346, 2
  %t2356 = select i1 %t2355, i8* %t2354, i8* %t2353
  %t2357 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2358 = icmp eq i32 %t2346, 3
  %t2359 = select i1 %t2358, i8* %t2357, i8* %t2356
  %t2360 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2361 = icmp eq i32 %t2346, 4
  %t2362 = select i1 %t2361, i8* %t2360, i8* %t2359
  %t2363 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2364 = icmp eq i32 %t2346, 5
  %t2365 = select i1 %t2364, i8* %t2363, i8* %t2362
  %t2366 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2367 = icmp eq i32 %t2346, 6
  %t2368 = select i1 %t2367, i8* %t2366, i8* %t2365
  %t2369 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2370 = icmp eq i32 %t2346, 7
  %t2371 = select i1 %t2370, i8* %t2369, i8* %t2368
  %t2372 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2373 = icmp eq i32 %t2346, 8
  %t2374 = select i1 %t2373, i8* %t2372, i8* %t2371
  %t2375 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2376 = icmp eq i32 %t2346, 9
  %t2377 = select i1 %t2376, i8* %t2375, i8* %t2374
  %t2378 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2379 = icmp eq i32 %t2346, 10
  %t2380 = select i1 %t2379, i8* %t2378, i8* %t2377
  %t2381 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2382 = icmp eq i32 %t2346, 11
  %t2383 = select i1 %t2382, i8* %t2381, i8* %t2380
  %t2384 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2385 = icmp eq i32 %t2346, 12
  %t2386 = select i1 %t2385, i8* %t2384, i8* %t2383
  %t2387 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2388 = icmp eq i32 %t2346, 13
  %t2389 = select i1 %t2388, i8* %t2387, i8* %t2386
  %t2390 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2391 = icmp eq i32 %t2346, 14
  %t2392 = select i1 %t2391, i8* %t2390, i8* %t2389
  %t2393 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2394 = icmp eq i32 %t2346, 15
  %t2395 = select i1 %t2394, i8* %t2393, i8* %t2392
  %t2396 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2397 = icmp eq i32 %t2346, 16
  %t2398 = select i1 %t2397, i8* %t2396, i8* %t2395
  %t2399 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2400 = icmp eq i32 %t2346, 17
  %t2401 = select i1 %t2400, i8* %t2399, i8* %t2398
  %t2402 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2403 = icmp eq i32 %t2346, 18
  %t2404 = select i1 %t2403, i8* %t2402, i8* %t2401
  %t2405 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2406 = icmp eq i32 %t2346, 19
  %t2407 = select i1 %t2406, i8* %t2405, i8* %t2404
  %t2408 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2409 = icmp eq i32 %t2346, 20
  %t2410 = select i1 %t2409, i8* %t2408, i8* %t2407
  %t2411 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2412 = icmp eq i32 %t2346, 21
  %t2413 = select i1 %t2412, i8* %t2411, i8* %t2410
  %t2414 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2415 = icmp eq i32 %t2346, 22
  %t2416 = select i1 %t2415, i8* %t2414, i8* %t2413
  %s2417 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.2417, i32 0, i32 0
  %t2418 = icmp eq i8* %t2416, %s2417
  br i1 %t2418, label %then36, label %merge37
then36:
  %t2419 = extractvalue %Statement %statement, 0
  %t2420 = alloca %Statement
  store %Statement %statement, %Statement* %t2420
  %t2421 = getelementptr inbounds %Statement, %Statement* %t2420, i32 0, i32 1
  %t2422 = bitcast [32 x i8]* %t2421 to i8*
  %t2423 = getelementptr inbounds i8, i8* %t2422, i64 8
  %t2424 = bitcast i8* %t2423 to i8**
  %t2425 = load i8*, i8** %t2424
  %t2426 = icmp eq i32 %t2419, 19
  %t2427 = select i1 %t2426, i8* %t2425, i8* null
  %t2428 = call { %Diagnostic*, i64 }* @check_block(%Block zeroinitializer, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t2428, { %Diagnostic*, i64 }** %l22
  %t2429 = extractvalue %Statement %statement, 0
  %t2430 = alloca %Statement
  store %Statement %statement, %Statement* %t2430
  %t2431 = getelementptr inbounds %Statement, %Statement* %t2430, i32 0, i32 1
  %t2432 = bitcast [32 x i8]* %t2431 to i8*
  %t2433 = getelementptr inbounds i8, i8* %t2432, i64 16
  %t2434 = bitcast i8* %t2433 to i8**
  %t2435 = load i8*, i8** %t2434
  %t2436 = icmp eq i32 %t2429, 19
  %t2437 = select i1 %t2436, i8* %t2435, i8* null
  %t2438 = icmp ne i8* %t2437, null
  %t2439 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br i1 %t2438, label %then38, label %merge39
then38:
  %t2440 = extractvalue %Statement %statement, 0
  %t2441 = alloca %Statement
  store %Statement %statement, %Statement* %t2441
  %t2442 = getelementptr inbounds %Statement, %Statement* %t2441, i32 0, i32 1
  %t2443 = bitcast [32 x i8]* %t2442 to i8*
  %t2444 = getelementptr inbounds i8, i8* %t2443, i64 16
  %t2445 = bitcast i8* %t2444 to i8**
  %t2446 = load i8*, i8** %t2445
  %t2447 = icmp eq i32 %t2440, 19
  %t2448 = select i1 %t2447, i8* %t2446, i8* null
  store i8* %t2448, i8** %l23
  %t2449 = load i8*, i8** %l23
  %t2450 = load i8*, i8** %l23
  br label %merge39
merge39:
  %t2451 = bitcast { %SymbolEntry*, i64 }* %bindings to { i8**, i64 }*
  %t2452 = insertvalue %ScopeResult undef, { i8**, i64 }* %t2451, 0
  %t2453 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2454 = bitcast { %Diagnostic*, i64 }* %t2453 to { i8**, i64 }*
  %t2455 = insertvalue %ScopeResult %t2452, { i8**, i64 }* %t2454, 1
  ret %ScopeResult %t2455
merge37:
  %t2456 = extractvalue %Statement %statement, 0
  %t2457 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2458 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2459 = icmp eq i32 %t2456, 0
  %t2460 = select i1 %t2459, i8* %t2458, i8* %t2457
  %t2461 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2462 = icmp eq i32 %t2456, 1
  %t2463 = select i1 %t2462, i8* %t2461, i8* %t2460
  %t2464 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2465 = icmp eq i32 %t2456, 2
  %t2466 = select i1 %t2465, i8* %t2464, i8* %t2463
  %t2467 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2468 = icmp eq i32 %t2456, 3
  %t2469 = select i1 %t2468, i8* %t2467, i8* %t2466
  %t2470 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2471 = icmp eq i32 %t2456, 4
  %t2472 = select i1 %t2471, i8* %t2470, i8* %t2469
  %t2473 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2474 = icmp eq i32 %t2456, 5
  %t2475 = select i1 %t2474, i8* %t2473, i8* %t2472
  %t2476 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2477 = icmp eq i32 %t2456, 6
  %t2478 = select i1 %t2477, i8* %t2476, i8* %t2475
  %t2479 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2480 = icmp eq i32 %t2456, 7
  %t2481 = select i1 %t2480, i8* %t2479, i8* %t2478
  %t2482 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2483 = icmp eq i32 %t2456, 8
  %t2484 = select i1 %t2483, i8* %t2482, i8* %t2481
  %t2485 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2486 = icmp eq i32 %t2456, 9
  %t2487 = select i1 %t2486, i8* %t2485, i8* %t2484
  %t2488 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2489 = icmp eq i32 %t2456, 10
  %t2490 = select i1 %t2489, i8* %t2488, i8* %t2487
  %t2491 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2492 = icmp eq i32 %t2456, 11
  %t2493 = select i1 %t2492, i8* %t2491, i8* %t2490
  %t2494 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2495 = icmp eq i32 %t2456, 12
  %t2496 = select i1 %t2495, i8* %t2494, i8* %t2493
  %t2497 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2498 = icmp eq i32 %t2456, 13
  %t2499 = select i1 %t2498, i8* %t2497, i8* %t2496
  %t2500 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2501 = icmp eq i32 %t2456, 14
  %t2502 = select i1 %t2501, i8* %t2500, i8* %t2499
  %t2503 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2504 = icmp eq i32 %t2456, 15
  %t2505 = select i1 %t2504, i8* %t2503, i8* %t2502
  %t2506 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2507 = icmp eq i32 %t2456, 16
  %t2508 = select i1 %t2507, i8* %t2506, i8* %t2505
  %t2509 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2510 = icmp eq i32 %t2456, 17
  %t2511 = select i1 %t2510, i8* %t2509, i8* %t2508
  %t2512 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2513 = icmp eq i32 %t2456, 18
  %t2514 = select i1 %t2513, i8* %t2512, i8* %t2511
  %t2515 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2516 = icmp eq i32 %t2456, 19
  %t2517 = select i1 %t2516, i8* %t2515, i8* %t2514
  %t2518 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2519 = icmp eq i32 %t2456, 20
  %t2520 = select i1 %t2519, i8* %t2518, i8* %t2517
  %t2521 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2522 = icmp eq i32 %t2456, 21
  %t2523 = select i1 %t2522, i8* %t2521, i8* %t2520
  %t2524 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2525 = icmp eq i32 %t2456, 22
  %t2526 = select i1 %t2525, i8* %t2524, i8* %t2523
  %s2527 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.2527, i32 0, i32 0
  %t2528 = icmp eq i8* %t2526, %s2527
  br i1 %t2528, label %then40, label %merge41
then40:
  %t2529 = bitcast { %SymbolEntry*, i64 }* %bindings to { i8**, i64 }*
  %t2530 = insertvalue %ScopeResult undef, { i8**, i64 }* %t2529, 0
  %t2531 = extractvalue %Statement %statement, 0
  %t2532 = alloca %Statement
  store %Statement %statement, %Statement* %t2532
  %t2533 = getelementptr inbounds %Statement, %Statement* %t2532, i32 0, i32 1
  %t2534 = bitcast [24 x i8]* %t2533 to i8*
  %t2535 = getelementptr inbounds i8, i8* %t2534, i64 8
  %t2536 = bitcast i8* %t2535 to i8**
  %t2537 = load i8*, i8** %t2536
  %t2538 = icmp eq i32 %t2531, 4
  %t2539 = select i1 %t2538, i8* %t2537, i8* null
  %t2540 = getelementptr inbounds %Statement, %Statement* %t2532, i32 0, i32 1
  %t2541 = bitcast [24 x i8]* %t2540 to i8*
  %t2542 = getelementptr inbounds i8, i8* %t2541, i64 8
  %t2543 = bitcast i8* %t2542 to i8**
  %t2544 = load i8*, i8** %t2543
  %t2545 = icmp eq i32 %t2531, 5
  %t2546 = select i1 %t2545, i8* %t2544, i8* %t2539
  %t2547 = getelementptr inbounds %Statement, %Statement* %t2532, i32 0, i32 1
  %t2548 = bitcast [40 x i8]* %t2547 to i8*
  %t2549 = getelementptr inbounds i8, i8* %t2548, i64 16
  %t2550 = bitcast i8* %t2549 to i8**
  %t2551 = load i8*, i8** %t2550
  %t2552 = icmp eq i32 %t2531, 6
  %t2553 = select i1 %t2552, i8* %t2551, i8* %t2546
  %t2554 = getelementptr inbounds %Statement, %Statement* %t2532, i32 0, i32 1
  %t2555 = bitcast [24 x i8]* %t2554 to i8*
  %t2556 = getelementptr inbounds i8, i8* %t2555, i64 8
  %t2557 = bitcast i8* %t2556 to i8**
  %t2558 = load i8*, i8** %t2557
  %t2559 = icmp eq i32 %t2531, 7
  %t2560 = select i1 %t2559, i8* %t2558, i8* %t2553
  %t2561 = getelementptr inbounds %Statement, %Statement* %t2532, i32 0, i32 1
  %t2562 = bitcast [40 x i8]* %t2561 to i8*
  %t2563 = getelementptr inbounds i8, i8* %t2562, i64 24
  %t2564 = bitcast i8* %t2563 to i8**
  %t2565 = load i8*, i8** %t2564
  %t2566 = icmp eq i32 %t2531, 12
  %t2567 = select i1 %t2566, i8* %t2565, i8* %t2560
  %t2568 = getelementptr inbounds %Statement, %Statement* %t2532, i32 0, i32 1
  %t2569 = bitcast [24 x i8]* %t2568 to i8*
  %t2570 = getelementptr inbounds i8, i8* %t2569, i64 8
  %t2571 = bitcast i8* %t2570 to i8**
  %t2572 = load i8*, i8** %t2571
  %t2573 = icmp eq i32 %t2531, 13
  %t2574 = select i1 %t2573, i8* %t2572, i8* %t2567
  %t2575 = getelementptr inbounds %Statement, %Statement* %t2532, i32 0, i32 1
  %t2576 = bitcast [24 x i8]* %t2575 to i8*
  %t2577 = getelementptr inbounds i8, i8* %t2576, i64 8
  %t2578 = bitcast i8* %t2577 to i8**
  %t2579 = load i8*, i8** %t2578
  %t2580 = icmp eq i32 %t2531, 14
  %t2581 = select i1 %t2580, i8* %t2579, i8* %t2574
  %t2582 = getelementptr inbounds %Statement, %Statement* %t2532, i32 0, i32 1
  %t2583 = bitcast [16 x i8]* %t2582 to i8*
  %t2584 = bitcast i8* %t2583 to i8**
  %t2585 = load i8*, i8** %t2584
  %t2586 = icmp eq i32 %t2531, 15
  %t2587 = select i1 %t2586, i8* %t2585, i8* %t2581
  %t2588 = call { %Diagnostic*, i64 }* @check_block(%Block zeroinitializer, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2589 = bitcast { %Diagnostic*, i64 }* %t2588 to { i8**, i64 }*
  %t2590 = insertvalue %ScopeResult %t2530, { i8**, i64 }* %t2589, 1
  ret %ScopeResult %t2590
merge41:
  %t2591 = extractvalue %Statement %statement, 0
  %t2592 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2593 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2594 = icmp eq i32 %t2591, 0
  %t2595 = select i1 %t2594, i8* %t2593, i8* %t2592
  %t2596 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2597 = icmp eq i32 %t2591, 1
  %t2598 = select i1 %t2597, i8* %t2596, i8* %t2595
  %t2599 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2600 = icmp eq i32 %t2591, 2
  %t2601 = select i1 %t2600, i8* %t2599, i8* %t2598
  %t2602 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2603 = icmp eq i32 %t2591, 3
  %t2604 = select i1 %t2603, i8* %t2602, i8* %t2601
  %t2605 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2606 = icmp eq i32 %t2591, 4
  %t2607 = select i1 %t2606, i8* %t2605, i8* %t2604
  %t2608 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2609 = icmp eq i32 %t2591, 5
  %t2610 = select i1 %t2609, i8* %t2608, i8* %t2607
  %t2611 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2612 = icmp eq i32 %t2591, 6
  %t2613 = select i1 %t2612, i8* %t2611, i8* %t2610
  %t2614 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2615 = icmp eq i32 %t2591, 7
  %t2616 = select i1 %t2615, i8* %t2614, i8* %t2613
  %t2617 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2618 = icmp eq i32 %t2591, 8
  %t2619 = select i1 %t2618, i8* %t2617, i8* %t2616
  %t2620 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2621 = icmp eq i32 %t2591, 9
  %t2622 = select i1 %t2621, i8* %t2620, i8* %t2619
  %t2623 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2624 = icmp eq i32 %t2591, 10
  %t2625 = select i1 %t2624, i8* %t2623, i8* %t2622
  %t2626 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2627 = icmp eq i32 %t2591, 11
  %t2628 = select i1 %t2627, i8* %t2626, i8* %t2625
  %t2629 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2630 = icmp eq i32 %t2591, 12
  %t2631 = select i1 %t2630, i8* %t2629, i8* %t2628
  %t2632 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2633 = icmp eq i32 %t2591, 13
  %t2634 = select i1 %t2633, i8* %t2632, i8* %t2631
  %t2635 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2636 = icmp eq i32 %t2591, 14
  %t2637 = select i1 %t2636, i8* %t2635, i8* %t2634
  %t2638 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2639 = icmp eq i32 %t2591, 15
  %t2640 = select i1 %t2639, i8* %t2638, i8* %t2637
  %t2641 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2642 = icmp eq i32 %t2591, 16
  %t2643 = select i1 %t2642, i8* %t2641, i8* %t2640
  %t2644 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2645 = icmp eq i32 %t2591, 17
  %t2646 = select i1 %t2645, i8* %t2644, i8* %t2643
  %t2647 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2648 = icmp eq i32 %t2591, 18
  %t2649 = select i1 %t2648, i8* %t2647, i8* %t2646
  %t2650 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2651 = icmp eq i32 %t2591, 19
  %t2652 = select i1 %t2651, i8* %t2650, i8* %t2649
  %t2653 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2654 = icmp eq i32 %t2591, 20
  %t2655 = select i1 %t2654, i8* %t2653, i8* %t2652
  %t2656 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2657 = icmp eq i32 %t2591, 21
  %t2658 = select i1 %t2657, i8* %t2656, i8* %t2655
  %t2659 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2660 = icmp eq i32 %t2591, 22
  %t2661 = select i1 %t2660, i8* %t2659, i8* %t2658
  %s2662 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.2662, i32 0, i32 0
  %t2663 = icmp eq i8* %t2661, %s2662
  br i1 %t2663, label %then42, label %merge43
then42:
  %t2664 = extractvalue %Statement %statement, 0
  %t2665 = alloca %Statement
  store %Statement %statement, %Statement* %t2665
  %t2666 = getelementptr inbounds %Statement, %Statement* %t2665, i32 0, i32 1
  %t2667 = bitcast [48 x i8]* %t2666 to i8*
  %t2668 = bitcast i8* %t2667 to i8**
  %t2669 = load i8*, i8** %t2668
  %t2670 = icmp eq i32 %t2664, 2
  %t2671 = select i1 %t2670, i8* %t2669, i8* null
  %t2672 = getelementptr inbounds %Statement, %Statement* %t2665, i32 0, i32 1
  %t2673 = bitcast [48 x i8]* %t2672 to i8*
  %t2674 = bitcast i8* %t2673 to i8**
  %t2675 = load i8*, i8** %t2674
  %t2676 = icmp eq i32 %t2664, 3
  %t2677 = select i1 %t2676, i8* %t2675, i8* %t2671
  %t2678 = getelementptr inbounds %Statement, %Statement* %t2665, i32 0, i32 1
  %t2679 = bitcast [40 x i8]* %t2678 to i8*
  %t2680 = bitcast i8* %t2679 to i8**
  %t2681 = load i8*, i8** %t2680
  %t2682 = icmp eq i32 %t2664, 6
  %t2683 = select i1 %t2682, i8* %t2681, i8* %t2677
  %t2684 = getelementptr inbounds %Statement, %Statement* %t2665, i32 0, i32 1
  %t2685 = bitcast [56 x i8]* %t2684 to i8*
  %t2686 = bitcast i8* %t2685 to i8**
  %t2687 = load i8*, i8** %t2686
  %t2688 = icmp eq i32 %t2664, 8
  %t2689 = select i1 %t2688, i8* %t2687, i8* %t2683
  %t2690 = getelementptr inbounds %Statement, %Statement* %t2665, i32 0, i32 1
  %t2691 = bitcast [40 x i8]* %t2690 to i8*
  %t2692 = bitcast i8* %t2691 to i8**
  %t2693 = load i8*, i8** %t2692
  %t2694 = icmp eq i32 %t2664, 9
  %t2695 = select i1 %t2694, i8* %t2693, i8* %t2689
  %t2696 = getelementptr inbounds %Statement, %Statement* %t2665, i32 0, i32 1
  %t2697 = bitcast [40 x i8]* %t2696 to i8*
  %t2698 = bitcast i8* %t2697 to i8**
  %t2699 = load i8*, i8** %t2698
  %t2700 = icmp eq i32 %t2664, 10
  %t2701 = select i1 %t2700, i8* %t2699, i8* %t2695
  %t2702 = getelementptr inbounds %Statement, %Statement* %t2665, i32 0, i32 1
  %t2703 = bitcast [40 x i8]* %t2702 to i8*
  %t2704 = bitcast i8* %t2703 to i8**
  %t2705 = load i8*, i8** %t2704
  %t2706 = icmp eq i32 %t2664, 11
  %t2707 = select i1 %t2706, i8* %t2705, i8* %t2701
  %s2708 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2708, i32 0, i32 0
  %t2709 = extractvalue %Statement %statement, 0
  %t2710 = alloca %Statement
  store %Statement %statement, %Statement* %t2710
  %t2711 = getelementptr inbounds %Statement, %Statement* %t2710, i32 0, i32 1
  %t2712 = bitcast [48 x i8]* %t2711 to i8*
  %t2713 = getelementptr inbounds i8, i8* %t2712, i64 8
  %t2714 = bitcast i8* %t2713 to i8**
  %t2715 = load i8*, i8** %t2714
  %t2716 = icmp eq i32 %t2709, 3
  %t2717 = select i1 %t2716, i8* %t2715, i8* null
  %t2718 = getelementptr inbounds %Statement, %Statement* %t2710, i32 0, i32 1
  %t2719 = bitcast [40 x i8]* %t2718 to i8*
  %t2720 = getelementptr inbounds i8, i8* %t2719, i64 8
  %t2721 = bitcast i8* %t2720 to i8**
  %t2722 = load i8*, i8** %t2721
  %t2723 = icmp eq i32 %t2709, 6
  %t2724 = select i1 %t2723, i8* %t2722, i8* %t2717
  %t2725 = getelementptr inbounds %Statement, %Statement* %t2710, i32 0, i32 1
  %t2726 = bitcast [56 x i8]* %t2725 to i8*
  %t2727 = getelementptr inbounds i8, i8* %t2726, i64 8
  %t2728 = bitcast i8* %t2727 to i8**
  %t2729 = load i8*, i8** %t2728
  %t2730 = icmp eq i32 %t2709, 8
  %t2731 = select i1 %t2730, i8* %t2729, i8* %t2724
  %t2732 = getelementptr inbounds %Statement, %Statement* %t2710, i32 0, i32 1
  %t2733 = bitcast [40 x i8]* %t2732 to i8*
  %t2734 = getelementptr inbounds i8, i8* %t2733, i64 8
  %t2735 = bitcast i8* %t2734 to i8**
  %t2736 = load i8*, i8** %t2735
  %t2737 = icmp eq i32 %t2709, 9
  %t2738 = select i1 %t2737, i8* %t2736, i8* %t2731
  %t2739 = getelementptr inbounds %Statement, %Statement* %t2710, i32 0, i32 1
  %t2740 = bitcast [40 x i8]* %t2739 to i8*
  %t2741 = getelementptr inbounds i8, i8* %t2740, i64 8
  %t2742 = bitcast i8* %t2741 to i8**
  %t2743 = load i8*, i8** %t2742
  %t2744 = icmp eq i32 %t2709, 10
  %t2745 = select i1 %t2744, i8* %t2743, i8* %t2738
  %t2746 = getelementptr inbounds %Statement, %Statement* %t2710, i32 0, i32 1
  %t2747 = bitcast [40 x i8]* %t2746 to i8*
  %t2748 = getelementptr inbounds i8, i8* %t2747, i64 8
  %t2749 = bitcast i8* %t2748 to i8**
  %t2750 = load i8*, i8** %t2749
  %t2751 = icmp eq i32 %t2709, 11
  %t2752 = select i1 %t2751, i8* %t2750, i8* %t2745
  %t2753 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t2707, i8* %s2708, i8* %t2752)
  store %ScopeResult %t2753, %ScopeResult* %l24
  %t2754 = load %ScopeResult, %ScopeResult* %l24
  %t2755 = extractvalue %ScopeResult %t2754, 1
  %t2756 = extractvalue %Statement %statement, 0
  %t2757 = alloca %Statement
  store %Statement %statement, %Statement* %t2757
  %t2758 = getelementptr inbounds %Statement, %Statement* %t2757, i32 0, i32 1
  %t2759 = bitcast [56 x i8]* %t2758 to i8*
  %t2760 = getelementptr inbounds i8, i8* %t2759, i64 16
  %t2761 = bitcast i8* %t2760 to { i8**, i64 }**
  %t2762 = load { i8**, i64 }*, { i8**, i64 }** %t2761
  %t2763 = icmp eq i32 %t2756, 8
  %t2764 = select i1 %t2763, { i8**, i64 }* %t2762, { i8**, i64 }* null
  %t2765 = getelementptr inbounds %Statement, %Statement* %t2757, i32 0, i32 1
  %t2766 = bitcast [40 x i8]* %t2765 to i8*
  %t2767 = getelementptr inbounds i8, i8* %t2766, i64 16
  %t2768 = bitcast i8* %t2767 to { i8**, i64 }**
  %t2769 = load { i8**, i64 }*, { i8**, i64 }** %t2768
  %t2770 = icmp eq i32 %t2756, 9
  %t2771 = select i1 %t2770, { i8**, i64 }* %t2769, { i8**, i64 }* %t2764
  %t2772 = getelementptr inbounds %Statement, %Statement* %t2757, i32 0, i32 1
  %t2773 = bitcast [40 x i8]* %t2772 to i8*
  %t2774 = getelementptr inbounds i8, i8* %t2773, i64 16
  %t2775 = bitcast i8* %t2774 to { i8**, i64 }**
  %t2776 = load { i8**, i64 }*, { i8**, i64 }** %t2775
  %t2777 = icmp eq i32 %t2756, 10
  %t2778 = select i1 %t2777, { i8**, i64 }* %t2776, { i8**, i64 }* %t2771
  %t2779 = getelementptr inbounds %Statement, %Statement* %t2757, i32 0, i32 1
  %t2780 = bitcast [40 x i8]* %t2779 to i8*
  %t2781 = getelementptr inbounds i8, i8* %t2780, i64 16
  %t2782 = bitcast i8* %t2781 to { i8**, i64 }**
  %t2783 = load { i8**, i64 }*, { i8**, i64 }** %t2782
  %t2784 = icmp eq i32 %t2756, 11
  %t2785 = select i1 %t2784, { i8**, i64 }* %t2783, { i8**, i64 }* %t2778
  %t2786 = bitcast { i8**, i64 }* %t2785 to { %TypeParameter*, i64 }*
  %t2787 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t2786)
  %t2788 = bitcast { %Diagnostic*, i64 }* %t2787 to { i8**, i64 }*
  %t2789 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2755, { i8**, i64 }* %t2788)
  store { i8**, i64 }* %t2789, { i8**, i64 }** %l25
  %t2790 = load %ScopeResult, %ScopeResult* %l24
  %t2791 = extractvalue %ScopeResult %t2790, 0
  %t2792 = insertvalue %ScopeResult undef, { i8**, i64 }* %t2791, 0
  %t2793 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t2794 = insertvalue %ScopeResult %t2792, { i8**, i64 }* %t2793, 1
  ret %ScopeResult %t2794
merge43:
  %t2795 = bitcast { %SymbolEntry*, i64 }* %bindings to { i8**, i64 }*
  %t2796 = insertvalue %ScopeResult undef, { i8**, i64 }* %t2795, 0
  %t2797 = alloca [0 x i8*]
  %t2798 = getelementptr [0 x i8*], [0 x i8*]* %t2797, i32 0, i32 0
  %t2799 = alloca { i8**, i64 }
  %t2800 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2799, i32 0, i32 0
  store i8** %t2798, i8*** %t2800
  %t2801 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2799, i32 0, i32 1
  store i64 0, i64* %t2801
  %t2802 = insertvalue %ScopeResult %t2796, { i8**, i64 }* %t2799, 1
  ret %ScopeResult %t2802
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
  %t71 = load double, double* %l6
  br label %forinc8
forinc8:
  %t72 = load i64, i64* %l4
  %t73 = add i64 %t72, 1
  store i64 %t73, i64* %l4
  br label %for6
afterfor9:
  %t74 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  ret { %Diagnostic*, i64 }* %t74
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
  br label %merge6
else5:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load i8*, i8** %l4
  %t30 = alloca [1 x i8*]
  %t31 = getelementptr [1 x i8*], [1 x i8*]* %t30, i32 0, i32 0
  %t32 = getelementptr i8*, i8** %t31, i64 0
  store i8* %t29, i8** %t32
  %t33 = alloca { i8**, i64 }
  %t34 = getelementptr { i8**, i64 }, { i8**, i64 }* %t33, i32 0, i32 0
  store i8** %t31, i8*** %t34
  %t35 = getelementptr { i8**, i64 }, { i8**, i64 }* %t33, i32 0, i32 1
  store i64 1, i64* %t35
  %t36 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t28, { i8**, i64 }* %t33)
  store { i8**, i64 }* %t36, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t37 = phi { %Diagnostic*, i64 }* [ null, %then4 ], [ %t25, %else5 ]
  %t38 = phi { i8**, i64 }* [ %t24, %then4 ], [ %t36, %else5 ]
  store { %Diagnostic*, i64 }* %t37, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t39 = load i64, i64* %l2
  %t40 = add i64 %t39, 1
  store i64 %t40, i64* %l2
  br label %for0
afterfor3:
  %t41 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t41
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
  %t35 = phi i8* [ %t11, %entry ], [ %t33, %loop.latch4 ]
  %t36 = phi double [ %t12, %entry ], [ %t34, %loop.latch4 ]
  store i8* %t35, i8** %l0
  store double %t36, double* %l1
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
  %t23 = load { i8**, i64 }, { i8**, i64 }* %items
  %t24 = extractvalue { i8**, i64 } %t23, 0
  %t25 = extractvalue { i8**, i64 } %t23, 1
  %t26 = icmp uge i64 %t22, %t25
  ; bounds check: %t26 (if true, out of bounds)
  %t27 = getelementptr i8*, i8** %t24, i64 %t22
  %t28 = load i8*, i8** %t27
  %t29 = add i8* %t21, %t28
  store i8* %t29, i8** %l0
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch4
loop.latch4:
  %t33 = load i8*, i8** %l0
  %t34 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t37 = load i8*, i8** %l0
  ret i8* %t37
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
  %t28 = phi double [ %t11, %entry ], [ %t27, %loop.latch2 ]
  store double %t28, double* %l3
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
  %t21 = getelementptr i8, i8* %block, i64 %t20
  %t22 = load i8, i8* %t21
  store i8 %t22, i8* %l4
  %t23 = load i8, i8* %l4
  %t24 = load double, double* %l3
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l3
  br label %loop.latch2
loop.latch2:
  %t27 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t29 = load i8*, i8** %l1
  %t30 = call i8* @trim_text(i8* %t29)
  store i8* %t30, i8** %l5
  %t31 = load i8*, i8** %l5
  %t32 = call i64 @sailfin_runtime_string_length(i8* %t31)
  %t33 = icmp sgt i64 %t32, 0
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load i8*, i8** %l1
  %t36 = load double, double* %l2
  %t37 = load double, double* %l3
  %t38 = load i8*, i8** %l5
  br i1 %t33, label %then6, label %merge7
then6:
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load i8*, i8** %l5
  %t41 = alloca [1 x i8*]
  %t42 = getelementptr [1 x i8*], [1 x i8*]* %t41, i32 0, i32 0
  %t43 = getelementptr i8*, i8** %t42, i64 0
  store i8* %t40, i8** %t43
  %t44 = alloca { i8**, i64 }
  %t45 = getelementptr { i8**, i64 }, { i8**, i64 }* %t44, i32 0, i32 0
  store i8** %t42, i8*** %t45
  %t46 = getelementptr { i8**, i64 }, { i8**, i64 }* %t44, i32 0, i32 1
  store i64 1, i64* %t46
  %t47 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t39, { i8**, i64 }* %t44)
  store { i8**, i64 }* %t47, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t48 = phi { i8**, i64 }* [ %t47, %then6 ], [ %t34, %entry ]
  store { i8**, i64 }* %t48, { i8**, i64 }** %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t49
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
  %t20 = phi double [ %t3, %entry ], [ %t19, %loop.latch2 ]
  store double %t20, double* %l0
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
  %t11 = getelementptr i8, i8* %value, i64 %t10
  %t12 = load i8, i8* %t11
  %t13 = call i1 @is_whitespace(i8* null)
  %t14 = load double, double* %l0
  %t15 = load double, double* %l1
  br i1 %t13, label %then6, label %merge7
then6:
  %t16 = load double, double* %l0
  %t17 = sitofp i64 1 to double
  %t18 = fadd double %t16, %t17
  store double %t18, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t19 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t23 = load double, double* %l1
  %t24 = load double, double* %l0
  %t25 = fcmp ole double %t23, %t24
  %t26 = load double, double* %l0
  %t27 = load double, double* %l1
  br i1 %t25, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  br label %afterloop11
loop.latch10:
  br label %loop.header8
afterloop11:
  %t28 = load double, double* %l0
  %t29 = load double, double* %l1
  %t30 = call i8* @slice_text(i8* %value, double %t28, double %t29)
  ret i8* %t30
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
  %t26 = phi i8* [ %t8, %entry ], [ %t24, %loop.latch8 ]
  %t27 = phi double [ %t9, %entry ], [ %t25, %loop.latch8 ]
  store i8* %t26, i8** %l0
  store double %t27, double* %l1
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
  %t16 = getelementptr i8, i8* %value, i64 %t15
  %t17 = load i8, i8* %t16
  %t18 = getelementptr i8, i8* %t14, i64 0
  %t19 = load i8, i8* %t18
  %t20 = add i8 %t19, %t17
  store i8* null, i8** %l0
  %t21 = load double, double* %l1
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  store double %t23, double* %l1
  br label %loop.latch8
loop.latch8:
  %t24 = load i8*, i8** %l0
  %t25 = load double, double* %l1
  br label %loop.header6
afterloop9:
  %t28 = load i8*, i8** %l0
  ret i8* %t28
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
  br label %merge6
else5:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load double, double* %l4
  %t38 = alloca [1 x double]
  %t39 = getelementptr [1 x double], [1 x double]* %t38, i32 0, i32 0
  %t40 = getelementptr double, double* %t39, i64 0
  store double %t37, double* %t40
  %t41 = alloca { double*, i64 }
  %t42 = getelementptr { double*, i64 }, { double*, i64 }* %t41, i32 0, i32 0
  store double* %t39, double** %t42
  %t43 = getelementptr { double*, i64 }, { double*, i64 }* %t41, i32 0, i32 1
  store i64 1, i64* %t43
  %t44 = bitcast { double*, i64 }* %t41 to { i8**, i64 }*
  %t45 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t36, { i8**, i64 }* %t44)
  store { i8**, i64 }* %t45, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t46 = phi { %Diagnostic*, i64 }* [ null, %then4 ], [ %t33, %else5 ]
  %t47 = phi { i8**, i64 }* [ %t32, %then4 ], [ %t45, %else5 ]
  store { %Diagnostic*, i64 }* %t46, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t47, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t48 = load i64, i64* %l2
  %t49 = add i64 %t48, 1
  store i64 %t49, i64* %l2
  br label %for0
afterfor3:
  %t50 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t50
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
  br label %merge6
else5:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load i8*, i8** %l4
  %t30 = alloca [1 x i8*]
  %t31 = getelementptr [1 x i8*], [1 x i8*]* %t30, i32 0, i32 0
  %t32 = getelementptr i8*, i8** %t31, i64 0
  store i8* %t29, i8** %t32
  %t33 = alloca { i8**, i64 }
  %t34 = getelementptr { i8**, i64 }, { i8**, i64 }* %t33, i32 0, i32 0
  store i8** %t31, i8*** %t34
  %t35 = getelementptr { i8**, i64 }, { i8**, i64 }* %t33, i32 0, i32 1
  store i64 1, i64* %t35
  %t36 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t28, { i8**, i64 }* %t33)
  store { i8**, i64 }* %t36, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t37 = phi { %Diagnostic*, i64 }* [ null, %then4 ], [ %t25, %else5 ]
  %t38 = phi { i8**, i64 }* [ %t24, %then4 ], [ %t36, %else5 ]
  store { %Diagnostic*, i64 }* %t37, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t39 = load i64, i64* %l2
  %t40 = add i64 %t39, 1
  store i64 %t40, i64* %l2
  br label %for0
afterfor3:
  %t41 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t41
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
  br label %merge6
else5:
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load i8*, i8** %l4
  %t37 = alloca [1 x i8*]
  %t38 = getelementptr [1 x i8*], [1 x i8*]* %t37, i32 0, i32 0
  %t39 = getelementptr i8*, i8** %t38, i64 0
  store i8* %t36, i8** %t39
  %t40 = alloca { i8**, i64 }
  %t41 = getelementptr { i8**, i64 }, { i8**, i64 }* %t40, i32 0, i32 0
  store i8** %t38, i8*** %t41
  %t42 = getelementptr { i8**, i64 }, { i8**, i64 }* %t40, i32 0, i32 1
  store i64 1, i64* %t42
  %t43 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t35, { i8**, i64 }* %t40)
  store { i8**, i64 }* %t43, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t44 = phi { %Diagnostic*, i64 }* [ null, %then4 ], [ %t32, %else5 ]
  %t45 = phi { i8**, i64 }* [ %t31, %then4 ], [ %t43, %else5 ]
  store { %Diagnostic*, i64 }* %t44, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t45, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t46 = load i64, i64* %l2
  %t47 = add i64 %t46, 1
  store i64 %t47, i64* %l2
  br label %for0
afterfor3:
  %t48 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t48
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
  br label %merge6
else5:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load i8*, i8** %l4
  %t30 = alloca [1 x i8*]
  %t31 = getelementptr [1 x i8*], [1 x i8*]* %t30, i32 0, i32 0
  %t32 = getelementptr i8*, i8** %t31, i64 0
  store i8* %t29, i8** %t32
  %t33 = alloca { i8**, i64 }
  %t34 = getelementptr { i8**, i64 }, { i8**, i64 }* %t33, i32 0, i32 0
  store i8** %t31, i8*** %t34
  %t35 = getelementptr { i8**, i64 }, { i8**, i64 }* %t33, i32 0, i32 1
  store i64 1, i64* %t35
  %t36 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t28, { i8**, i64 }* %t33)
  store { i8**, i64 }* %t36, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t37 = phi { %Diagnostic*, i64 }* [ null, %then4 ], [ %t25, %else5 ]
  %t38 = phi { i8**, i64 }* [ %t24, %then4 ], [ %t36, %else5 ]
  store { %Diagnostic*, i64 }* %t37, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t39 = load i64, i64* %l2
  %t40 = add i64 %t39, 1
  store i64 %t40, i64* %l2
  br label %for0
afterfor3:
  %t41 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t41
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
  br label %merge6
else5:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load i8*, i8** %l4
  %t30 = alloca [1 x i8*]
  %t31 = getelementptr [1 x i8*], [1 x i8*]* %t30, i32 0, i32 0
  %t32 = getelementptr i8*, i8** %t31, i64 0
  store i8* %t29, i8** %t32
  %t33 = alloca { i8**, i64 }
  %t34 = getelementptr { i8**, i64 }, { i8**, i64 }* %t33, i32 0, i32 0
  store i8** %t31, i8*** %t34
  %t35 = getelementptr { i8**, i64 }, { i8**, i64 }* %t33, i32 0, i32 1
  store i64 1, i64* %t35
  %t36 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t28, { i8**, i64 }* %t33)
  store { i8**, i64 }* %t36, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t37 = phi { %Diagnostic*, i64 }* [ null, %then4 ], [ %t25, %else5 ]
  %t38 = phi { i8**, i64 }* [ %t24, %then4 ], [ %t36, %else5 ]
  store { %Diagnostic*, i64 }* %t37, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t39 = load i64, i64* %l2
  %t40 = add i64 %t39, 1
  store i64 %t40, i64* %l2
  br label %for0
afterfor3:
  %t41 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t41
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
  %t37 = phi { %Diagnostic*, i64 }* [ %t8, %entry ], [ %t35, %loop.latch2 ]
  %t38 = phi double [ %t9, %entry ], [ %t36, %loop.latch2 ]
  store { %Diagnostic*, i64 }* %t37, { %Diagnostic*, i64 }** %l1
  store double %t38, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load double, double* %l0
  %t12 = load double, double* %l0
  %t13 = load double, double* %l2
  store double 0.0, double* %l3
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l4
  %t15 = load double, double* %l0
  %t16 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t17 = load double, double* %l2
  %t18 = load double, double* %l3
  %t19 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t30 = phi { %Diagnostic*, i64 }* [ %t16, %loop.body1 ], [ %t28, %loop.latch6 ]
  %t31 = phi double [ %t19, %loop.body1 ], [ %t29, %loop.latch6 ]
  store { %Diagnostic*, i64 }* %t30, { %Diagnostic*, i64 }** %l1
  store double %t31, double* %l4
  br label %loop.body5
loop.body5:
  %t20 = load double, double* %l4
  %t21 = load double, double* %l3
  %t22 = load double, double* %l3
  store double 0.0, double* %l5
  %t23 = load double, double* %l3
  %t24 = load double, double* %l5
  store double 0.0, double* %l6
  %t25 = load double, double* %l4
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l4
  br label %loop.latch6
loop.latch6:
  %t28 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t29 = load double, double* %l4
  br label %loop.header4
afterloop7:
  %t32 = load double, double* %l2
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l2
  br label %loop.latch2
loop.latch2:
  %t35 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t36 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t39 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t39
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
  %t22 = phi double [ %t4, %entry ], [ %t21, %loop.latch4 ]
  store double %t22, double* %l0
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
  %t11 = getelementptr i8, i8* %value, i64 %t10
  %t12 = load i8, i8* %t11
  %t13 = load double, double* %l0
  %t14 = getelementptr i8, i8* %prefix, i64 %t13
  %t15 = load i8, i8* %t14
  %t16 = icmp ne i8 %t12, %t15
  %t17 = load double, double* %l0
  br i1 %t16, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t18 = load double, double* %l0
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l0
  br label %loop.latch4
loop.latch4:
  %t21 = load double, double* %l0
  br label %loop.header2
afterloop5:
  ret i1 1
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
