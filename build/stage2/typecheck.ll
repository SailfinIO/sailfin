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
@.str.4 = private unnamed_addr constant [1 x i8] c"\00"
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
  %t5 = insertvalue %TypecheckResult undef, { i8**, i64 }* null, 0
  %t6 = load %SymbolCollectionResult, %SymbolCollectionResult* %l0
  %t7 = extractvalue %SymbolCollectionResult %t6, 0
  %t8 = insertvalue %TypecheckResult %t5, { i8**, i64 }* %t7, 1
  ret %TypecheckResult %t8
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
  store { %SymbolEntry*, i64 }* null, { %SymbolEntry*, i64 }** %l0
  %t25 = load %SymbolCollectionResult, %SymbolCollectionResult* %l4
  %t26 = extractvalue %SymbolCollectionResult %t25, 1
  %t27 = call double @diagnosticsconcat({ i8**, i64 }* %t26)
  store { %Diagnostic*, i64 }* null, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t28 = load i64, i64* %l2
  %t29 = add i64 %t28, 1
  store i64 %t29, i64* %l2
  br label %for0
afterfor3:
  %t30 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t31 = insertvalue %SymbolCollectionResult undef, { i8**, i64 }* null, 0
  %t32 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t33 = insertvalue %SymbolCollectionResult %t31, { i8**, i64 }* null, 1
  ret %SymbolCollectionResult %t33
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
  %t1462 = insertvalue %SymbolCollectionResult undef, { i8**, i64 }* null, 0
  %t1463 = alloca [0 x i8*]
  %t1464 = getelementptr [0 x i8*], [0 x i8*]* %t1463, i32 0, i32 0
  %t1465 = alloca { i8**, i64 }
  %t1466 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1465, i32 0, i32 0
  store i8** %t1464, i8*** %t1466
  %t1467 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1465, i32 0, i32 1
  store i64 0, i64* %t1467
  %t1468 = insertvalue %SymbolCollectionResult %t1462, { i8**, i64 }* %t1465, 1
  ret %SymbolCollectionResult %t1468
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
  store { %SymbolEntry*, i64 }* null, { %SymbolEntry*, i64 }** %l0
  %t25 = load %ScopeResult, %ScopeResult* %l4
  %t26 = extractvalue %ScopeResult %t25, 1
  %t27 = call double @diagnosticsconcat({ i8**, i64 }* %t26)
  store { %Diagnostic*, i64 }* null, { %Diagnostic*, i64 }** %l1
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
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca double
  %l15 = alloca double
  %l16 = alloca double
  %l17 = alloca %ScopeResult
  %l18 = alloca double
  %l19 = alloca { %Diagnostic*, i64 }*
  %l20 = alloca double
  %l21 = alloca i8*
  %l22 = alloca { %Diagnostic*, i64 }*
  %l23 = alloca i8*
  %l24 = alloca %ScopeResult
  %l25 = alloca double
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
  %t257 = extractvalue %Statement %statement, 0
  %t258 = alloca %Statement
  store %Statement %statement, %Statement* %t258
  %t259 = getelementptr inbounds %Statement, %Statement* %t258, i32 0, i32 1
  %t260 = bitcast [24 x i8]* %t259 to i8*
  %t261 = bitcast i8* %t260 to i8**
  %t262 = load i8*, i8** %t261
  %t263 = icmp eq i32 %t257, 4
  %t264 = select i1 %t263, i8* %t262, i8* null
  %t265 = getelementptr inbounds %Statement, %Statement* %t258, i32 0, i32 1
  %t266 = bitcast [24 x i8]* %t265 to i8*
  %t267 = bitcast i8* %t266 to i8**
  %t268 = load i8*, i8** %t267
  %t269 = icmp eq i32 %t257, 5
  %t270 = select i1 %t269, i8* %t268, i8* %t264
  %t271 = getelementptr inbounds %Statement, %Statement* %t258, i32 0, i32 1
  %t272 = bitcast [24 x i8]* %t271 to i8*
  %t273 = bitcast i8* %t272 to i8**
  %t274 = load i8*, i8** %t273
  %t275 = icmp eq i32 %t257, 7
  %t276 = select i1 %t275, i8* %t274, i8* %t270
  %t277 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature zeroinitializer)
  %t278 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t277)
  store double %t278, double* %l1
  %t279 = extractvalue %Statement %statement, 0
  %t280 = alloca %Statement
  store %Statement %statement, %Statement* %t280
  %t281 = getelementptr inbounds %Statement, %Statement* %t280, i32 0, i32 1
  %t282 = bitcast [24 x i8]* %t281 to i8*
  %t283 = bitcast i8* %t282 to i8**
  %t284 = load i8*, i8** %t283
  %t285 = icmp eq i32 %t279, 4
  %t286 = select i1 %t285, i8* %t284, i8* null
  %t287 = getelementptr inbounds %Statement, %Statement* %t280, i32 0, i32 1
  %t288 = bitcast [24 x i8]* %t287 to i8*
  %t289 = bitcast i8* %t288 to i8**
  %t290 = load i8*, i8** %t289
  %t291 = icmp eq i32 %t279, 5
  %t292 = select i1 %t291, i8* %t290, i8* %t286
  %t293 = getelementptr inbounds %Statement, %Statement* %t280, i32 0, i32 1
  %t294 = bitcast [24 x i8]* %t293 to i8*
  %t295 = bitcast i8* %t294 to i8**
  %t296 = load i8*, i8** %t295
  %t297 = icmp eq i32 %t279, 7
  %t298 = select i1 %t297, i8* %t296, i8* %t292
  %t299 = extractvalue %Statement %statement, 0
  %t300 = alloca %Statement
  store %Statement %statement, %Statement* %t300
  %t301 = getelementptr inbounds %Statement, %Statement* %t300, i32 0, i32 1
  %t302 = bitcast [24 x i8]* %t301 to i8*
  %t303 = getelementptr inbounds i8, i8* %t302, i64 8
  %t304 = bitcast i8* %t303 to i8**
  %t305 = load i8*, i8** %t304
  %t306 = icmp eq i32 %t299, 4
  %t307 = select i1 %t306, i8* %t305, i8* null
  %t308 = getelementptr inbounds %Statement, %Statement* %t300, i32 0, i32 1
  %t309 = bitcast [24 x i8]* %t308 to i8*
  %t310 = getelementptr inbounds i8, i8* %t309, i64 8
  %t311 = bitcast i8* %t310 to i8**
  %t312 = load i8*, i8** %t311
  %t313 = icmp eq i32 %t299, 5
  %t314 = select i1 %t313, i8* %t312, i8* %t307
  %t315 = getelementptr inbounds %Statement, %Statement* %t300, i32 0, i32 1
  %t316 = bitcast [40 x i8]* %t315 to i8*
  %t317 = getelementptr inbounds i8, i8* %t316, i64 16
  %t318 = bitcast i8* %t317 to i8**
  %t319 = load i8*, i8** %t318
  %t320 = icmp eq i32 %t299, 6
  %t321 = select i1 %t320, i8* %t319, i8* %t314
  %t322 = getelementptr inbounds %Statement, %Statement* %t300, i32 0, i32 1
  %t323 = bitcast [24 x i8]* %t322 to i8*
  %t324 = getelementptr inbounds i8, i8* %t323, i64 8
  %t325 = bitcast i8* %t324 to i8**
  %t326 = load i8*, i8** %t325
  %t327 = icmp eq i32 %t299, 7
  %t328 = select i1 %t327, i8* %t326, i8* %t321
  %t329 = getelementptr inbounds %Statement, %Statement* %t300, i32 0, i32 1
  %t330 = bitcast [40 x i8]* %t329 to i8*
  %t331 = getelementptr inbounds i8, i8* %t330, i64 24
  %t332 = bitcast i8* %t331 to i8**
  %t333 = load i8*, i8** %t332
  %t334 = icmp eq i32 %t299, 12
  %t335 = select i1 %t334, i8* %t333, i8* %t328
  %t336 = getelementptr inbounds %Statement, %Statement* %t300, i32 0, i32 1
  %t337 = bitcast [24 x i8]* %t336 to i8*
  %t338 = getelementptr inbounds i8, i8* %t337, i64 8
  %t339 = bitcast i8* %t338 to i8**
  %t340 = load i8*, i8** %t339
  %t341 = icmp eq i32 %t299, 13
  %t342 = select i1 %t341, i8* %t340, i8* %t335
  %t343 = getelementptr inbounds %Statement, %Statement* %t300, i32 0, i32 1
  %t344 = bitcast [24 x i8]* %t343 to i8*
  %t345 = getelementptr inbounds i8, i8* %t344, i64 8
  %t346 = bitcast i8* %t345 to i8**
  %t347 = load i8*, i8** %t346
  %t348 = icmp eq i32 %t299, 14
  %t349 = select i1 %t348, i8* %t347, i8* %t342
  %t350 = getelementptr inbounds %Statement, %Statement* %t300, i32 0, i32 1
  %t351 = bitcast [16 x i8]* %t350 to i8*
  %t352 = bitcast i8* %t351 to i8**
  %t353 = load i8*, i8** %t352
  %t354 = icmp eq i32 %t299, 15
  %t355 = select i1 %t354, i8* %t353, i8* %t349
  %t356 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature zeroinitializer, %Block zeroinitializer, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t356, { %Diagnostic*, i64 }** %l2
  %t357 = load double, double* %l0
  %t358 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t359 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l2
  %t360 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t359)
  %t361 = insertvalue %ScopeResult %t358, { i8**, i64 }* null, 1
  ret %ScopeResult %t361
merge3:
  %t362 = extractvalue %Statement %statement, 0
  %t363 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t364 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t365 = icmp eq i32 %t362, 0
  %t366 = select i1 %t365, i8* %t364, i8* %t363
  %t367 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t368 = icmp eq i32 %t362, 1
  %t369 = select i1 %t368, i8* %t367, i8* %t366
  %t370 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t371 = icmp eq i32 %t362, 2
  %t372 = select i1 %t371, i8* %t370, i8* %t369
  %t373 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t374 = icmp eq i32 %t362, 3
  %t375 = select i1 %t374, i8* %t373, i8* %t372
  %t376 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t377 = icmp eq i32 %t362, 4
  %t378 = select i1 %t377, i8* %t376, i8* %t375
  %t379 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t380 = icmp eq i32 %t362, 5
  %t381 = select i1 %t380, i8* %t379, i8* %t378
  %t382 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t383 = icmp eq i32 %t362, 6
  %t384 = select i1 %t383, i8* %t382, i8* %t381
  %t385 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t386 = icmp eq i32 %t362, 7
  %t387 = select i1 %t386, i8* %t385, i8* %t384
  %t388 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t389 = icmp eq i32 %t362, 8
  %t390 = select i1 %t389, i8* %t388, i8* %t387
  %t391 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t392 = icmp eq i32 %t362, 9
  %t393 = select i1 %t392, i8* %t391, i8* %t390
  %t394 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t395 = icmp eq i32 %t362, 10
  %t396 = select i1 %t395, i8* %t394, i8* %t393
  %t397 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t398 = icmp eq i32 %t362, 11
  %t399 = select i1 %t398, i8* %t397, i8* %t396
  %t400 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t401 = icmp eq i32 %t362, 12
  %t402 = select i1 %t401, i8* %t400, i8* %t399
  %t403 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t404 = icmp eq i32 %t362, 13
  %t405 = select i1 %t404, i8* %t403, i8* %t402
  %t406 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t407 = icmp eq i32 %t362, 14
  %t408 = select i1 %t407, i8* %t406, i8* %t405
  %t409 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t410 = icmp eq i32 %t362, 15
  %t411 = select i1 %t410, i8* %t409, i8* %t408
  %t412 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t413 = icmp eq i32 %t362, 16
  %t414 = select i1 %t413, i8* %t412, i8* %t411
  %t415 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t416 = icmp eq i32 %t362, 17
  %t417 = select i1 %t416, i8* %t415, i8* %t414
  %t418 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t419 = icmp eq i32 %t362, 18
  %t420 = select i1 %t419, i8* %t418, i8* %t417
  %t421 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t422 = icmp eq i32 %t362, 19
  %t423 = select i1 %t422, i8* %t421, i8* %t420
  %t424 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t425 = icmp eq i32 %t362, 20
  %t426 = select i1 %t425, i8* %t424, i8* %t423
  %t427 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t428 = icmp eq i32 %t362, 21
  %t429 = select i1 %t428, i8* %t427, i8* %t426
  %t430 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t431 = icmp eq i32 %t362, 22
  %t432 = select i1 %t431, i8* %t430, i8* %t429
  %s433 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.433, i32 0, i32 0
  %t434 = icmp eq i8* %t432, %s433
  br i1 %t434, label %then4, label %merge5
then4:
  %t435 = extractvalue %Statement %statement, 0
  %t436 = alloca %Statement
  store %Statement %statement, %Statement* %t436
  %t437 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t438 = bitcast [48 x i8]* %t437 to i8*
  %t439 = bitcast i8* %t438 to i8**
  %t440 = load i8*, i8** %t439
  %t441 = icmp eq i32 %t435, 2
  %t442 = select i1 %t441, i8* %t440, i8* null
  %t443 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t444 = bitcast [48 x i8]* %t443 to i8*
  %t445 = bitcast i8* %t444 to i8**
  %t446 = load i8*, i8** %t445
  %t447 = icmp eq i32 %t435, 3
  %t448 = select i1 %t447, i8* %t446, i8* %t442
  %t449 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t450 = bitcast [40 x i8]* %t449 to i8*
  %t451 = bitcast i8* %t450 to i8**
  %t452 = load i8*, i8** %t451
  %t453 = icmp eq i32 %t435, 6
  %t454 = select i1 %t453, i8* %t452, i8* %t448
  %t455 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t456 = bitcast [56 x i8]* %t455 to i8*
  %t457 = bitcast i8* %t456 to i8**
  %t458 = load i8*, i8** %t457
  %t459 = icmp eq i32 %t435, 8
  %t460 = select i1 %t459, i8* %t458, i8* %t454
  %t461 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t462 = bitcast [40 x i8]* %t461 to i8*
  %t463 = bitcast i8* %t462 to i8**
  %t464 = load i8*, i8** %t463
  %t465 = icmp eq i32 %t435, 9
  %t466 = select i1 %t465, i8* %t464, i8* %t460
  %t467 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t468 = bitcast [40 x i8]* %t467 to i8*
  %t469 = bitcast i8* %t468 to i8**
  %t470 = load i8*, i8** %t469
  %t471 = icmp eq i32 %t435, 10
  %t472 = select i1 %t471, i8* %t470, i8* %t466
  %t473 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t474 = bitcast [40 x i8]* %t473 to i8*
  %t475 = bitcast i8* %t474 to i8**
  %t476 = load i8*, i8** %t475
  %t477 = icmp eq i32 %t435, 11
  %t478 = select i1 %t477, i8* %t476, i8* %t472
  %s479 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.479, i32 0, i32 0
  %t480 = extractvalue %Statement %statement, 0
  %t481 = alloca %Statement
  store %Statement %statement, %Statement* %t481
  %t482 = getelementptr inbounds %Statement, %Statement* %t481, i32 0, i32 1
  %t483 = bitcast [48 x i8]* %t482 to i8*
  %t484 = getelementptr inbounds i8, i8* %t483, i64 8
  %t485 = bitcast i8* %t484 to i8**
  %t486 = load i8*, i8** %t485
  %t487 = icmp eq i32 %t480, 3
  %t488 = select i1 %t487, i8* %t486, i8* null
  %t489 = getelementptr inbounds %Statement, %Statement* %t481, i32 0, i32 1
  %t490 = bitcast [40 x i8]* %t489 to i8*
  %t491 = getelementptr inbounds i8, i8* %t490, i64 8
  %t492 = bitcast i8* %t491 to i8**
  %t493 = load i8*, i8** %t492
  %t494 = icmp eq i32 %t480, 6
  %t495 = select i1 %t494, i8* %t493, i8* %t488
  %t496 = getelementptr inbounds %Statement, %Statement* %t481, i32 0, i32 1
  %t497 = bitcast [56 x i8]* %t496 to i8*
  %t498 = getelementptr inbounds i8, i8* %t497, i64 8
  %t499 = bitcast i8* %t498 to i8**
  %t500 = load i8*, i8** %t499
  %t501 = icmp eq i32 %t480, 8
  %t502 = select i1 %t501, i8* %t500, i8* %t495
  %t503 = getelementptr inbounds %Statement, %Statement* %t481, i32 0, i32 1
  %t504 = bitcast [40 x i8]* %t503 to i8*
  %t505 = getelementptr inbounds i8, i8* %t504, i64 8
  %t506 = bitcast i8* %t505 to i8**
  %t507 = load i8*, i8** %t506
  %t508 = icmp eq i32 %t480, 9
  %t509 = select i1 %t508, i8* %t507, i8* %t502
  %t510 = getelementptr inbounds %Statement, %Statement* %t481, i32 0, i32 1
  %t511 = bitcast [40 x i8]* %t510 to i8*
  %t512 = getelementptr inbounds i8, i8* %t511, i64 8
  %t513 = bitcast i8* %t512 to i8**
  %t514 = load i8*, i8** %t513
  %t515 = icmp eq i32 %t480, 10
  %t516 = select i1 %t515, i8* %t514, i8* %t509
  %t517 = getelementptr inbounds %Statement, %Statement* %t481, i32 0, i32 1
  %t518 = bitcast [40 x i8]* %t517 to i8*
  %t519 = getelementptr inbounds i8, i8* %t518, i64 8
  %t520 = bitcast i8* %t519 to i8**
  %t521 = load i8*, i8** %t520
  %t522 = icmp eq i32 %t480, 11
  %t523 = select i1 %t522, i8* %t521, i8* %t516
  %t524 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t478, i8* %s479, i8* %t523)
  store %ScopeResult %t524, %ScopeResult* %l3
  %t525 = load %ScopeResult, %ScopeResult* %l3
  %t526 = extractvalue %ScopeResult %t525, 1
  store { i8**, i64 }* %t526, { i8**, i64 }** %l4
  %t527 = extractvalue %Statement %statement, 0
  %t528 = alloca %Statement
  store %Statement %statement, %Statement* %t528
  %t529 = getelementptr inbounds %Statement, %Statement* %t528, i32 0, i32 1
  %t530 = bitcast [56 x i8]* %t529 to i8*
  %t531 = getelementptr inbounds i8, i8* %t530, i64 16
  %t532 = bitcast i8* %t531 to { i8**, i64 }**
  %t533 = load { i8**, i64 }*, { i8**, i64 }** %t532
  %t534 = icmp eq i32 %t527, 8
  %t535 = select i1 %t534, { i8**, i64 }* %t533, { i8**, i64 }* null
  %t536 = getelementptr inbounds %Statement, %Statement* %t528, i32 0, i32 1
  %t537 = bitcast [40 x i8]* %t536 to i8*
  %t538 = getelementptr inbounds i8, i8* %t537, i64 16
  %t539 = bitcast i8* %t538 to { i8**, i64 }**
  %t540 = load { i8**, i64 }*, { i8**, i64 }** %t539
  %t541 = icmp eq i32 %t527, 9
  %t542 = select i1 %t541, { i8**, i64 }* %t540, { i8**, i64 }* %t535
  %t543 = getelementptr inbounds %Statement, %Statement* %t528, i32 0, i32 1
  %t544 = bitcast [40 x i8]* %t543 to i8*
  %t545 = getelementptr inbounds i8, i8* %t544, i64 16
  %t546 = bitcast i8* %t545 to { i8**, i64 }**
  %t547 = load { i8**, i64 }*, { i8**, i64 }** %t546
  %t548 = icmp eq i32 %t527, 10
  %t549 = select i1 %t548, { i8**, i64 }* %t547, { i8**, i64 }* %t542
  %t550 = getelementptr inbounds %Statement, %Statement* %t528, i32 0, i32 1
  %t551 = bitcast [40 x i8]* %t550 to i8*
  %t552 = getelementptr inbounds i8, i8* %t551, i64 16
  %t553 = bitcast i8* %t552 to { i8**, i64 }**
  %t554 = load { i8**, i64 }*, { i8**, i64 }** %t553
  %t555 = icmp eq i32 %t527, 11
  %t556 = select i1 %t555, { i8**, i64 }* %t554, { i8**, i64 }* %t549
  %t557 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* null)
  %t558 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t557)
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t559 = extractvalue %Statement %statement, 0
  %t560 = alloca %Statement
  store %Statement %statement, %Statement* %t560
  %t561 = getelementptr inbounds %Statement, %Statement* %t560, i32 0, i32 1
  %t562 = bitcast [56 x i8]* %t561 to i8*
  %t563 = getelementptr inbounds i8, i8* %t562, i64 32
  %t564 = bitcast i8* %t563 to { i8**, i64 }**
  %t565 = load { i8**, i64 }*, { i8**, i64 }** %t564
  %t566 = icmp eq i32 %t559, 8
  %t567 = select i1 %t566, { i8**, i64 }* %t565, { i8**, i64 }* null
  %t568 = call { %Diagnostic*, i64 }* @check_struct_fields({ %FieldDeclaration*, i64 }* null)
  %t569 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t568)
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t570 = extractvalue %Statement %statement, 0
  %t571 = alloca %Statement
  store %Statement %statement, %Statement* %t571
  %t572 = getelementptr inbounds %Statement, %Statement* %t571, i32 0, i32 1
  %t573 = bitcast [56 x i8]* %t572 to i8*
  %t574 = getelementptr inbounds i8, i8* %t573, i64 40
  %t575 = bitcast i8* %t574 to { i8**, i64 }**
  %t576 = load { i8**, i64 }*, { i8**, i64 }** %t575
  %t577 = icmp eq i32 %t570, 8
  %t578 = select i1 %t577, { i8**, i64 }* %t576, { i8**, i64 }* null
  %t579 = call { %Diagnostic*, i64 }* @check_struct_methods({ %MethodDeclaration*, i64 }* null)
  %t580 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t579)
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t581 = call { %Diagnostic*, i64 }* @check_struct_implements_interfaces(%Statement %statement, { %Statement*, i64 }* %interfaces)
  %t582 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t581)
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t583 = sitofp i64 0 to double
  store double %t583, double* %l5
  %t584 = load %ScopeResult, %ScopeResult* %l3
  %t585 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t586 = load double, double* %l5
  br label %loop.header6
loop.header6:
  %t627 = phi { i8**, i64 }* [ %t585, %then4 ], [ %t625, %loop.latch8 ]
  %t628 = phi double [ %t586, %then4 ], [ %t626, %loop.latch8 ]
  store { i8**, i64 }* %t627, { i8**, i64 }** %l4
  store double %t628, double* %l5
  br label %loop.body7
loop.body7:
  %t587 = load double, double* %l5
  %t588 = extractvalue %Statement %statement, 0
  %t589 = alloca %Statement
  store %Statement %statement, %Statement* %t589
  %t590 = getelementptr inbounds %Statement, %Statement* %t589, i32 0, i32 1
  %t591 = bitcast [56 x i8]* %t590 to i8*
  %t592 = getelementptr inbounds i8, i8* %t591, i64 40
  %t593 = bitcast i8* %t592 to { i8**, i64 }**
  %t594 = load { i8**, i64 }*, { i8**, i64 }** %t593
  %t595 = icmp eq i32 %t588, 8
  %t596 = select i1 %t595, { i8**, i64 }* %t594, { i8**, i64 }* null
  %t597 = load { i8**, i64 }, { i8**, i64 }* %t596
  %t598 = extractvalue { i8**, i64 } %t597, 1
  %t599 = sitofp i64 %t598 to double
  %t600 = fcmp oge double %t587, %t599
  %t601 = load %ScopeResult, %ScopeResult* %l3
  %t602 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t603 = load double, double* %l5
  br i1 %t600, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t604 = extractvalue %Statement %statement, 0
  %t605 = alloca %Statement
  store %Statement %statement, %Statement* %t605
  %t606 = getelementptr inbounds %Statement, %Statement* %t605, i32 0, i32 1
  %t607 = bitcast [56 x i8]* %t606 to i8*
  %t608 = getelementptr inbounds i8, i8* %t607, i64 40
  %t609 = bitcast i8* %t608 to { i8**, i64 }**
  %t610 = load { i8**, i64 }*, { i8**, i64 }** %t609
  %t611 = icmp eq i32 %t604, 8
  %t612 = select i1 %t611, { i8**, i64 }* %t610, { i8**, i64 }* null
  %t613 = load double, double* %l5
  %t614 = load { i8**, i64 }, { i8**, i64 }* %t612
  %t615 = extractvalue { i8**, i64 } %t614, 0
  %t616 = extractvalue { i8**, i64 } %t614, 1
  %t617 = icmp uge i64 %t613, %t616
  ; bounds check: %t617 (if true, out of bounds)
  %t618 = getelementptr i8*, i8** %t615, i64 %t613
  %t619 = load i8*, i8** %t618
  store i8* %t619, i8** %l6
  %t620 = load i8*, i8** %l6
  %t621 = load i8*, i8** %l6
  %t622 = load double, double* %l5
  %t623 = sitofp i64 1 to double
  %t624 = fadd double %t622, %t623
  store double %t624, double* %l5
  br label %loop.latch8
loop.latch8:
  %t625 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t626 = load double, double* %l5
  br label %loop.header6
afterloop9:
  %t629 = load %ScopeResult, %ScopeResult* %l3
  %t630 = extractvalue %ScopeResult %t629, 0
  %t631 = insertvalue %ScopeResult undef, { i8**, i64 }* %t630, 0
  %t632 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t633 = insertvalue %ScopeResult %t631, { i8**, i64 }* %t632, 1
  ret %ScopeResult %t633
merge5:
  %t634 = extractvalue %Statement %statement, 0
  %t635 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t636 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t637 = icmp eq i32 %t634, 0
  %t638 = select i1 %t637, i8* %t636, i8* %t635
  %t639 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t640 = icmp eq i32 %t634, 1
  %t641 = select i1 %t640, i8* %t639, i8* %t638
  %t642 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t643 = icmp eq i32 %t634, 2
  %t644 = select i1 %t643, i8* %t642, i8* %t641
  %t645 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t646 = icmp eq i32 %t634, 3
  %t647 = select i1 %t646, i8* %t645, i8* %t644
  %t648 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t649 = icmp eq i32 %t634, 4
  %t650 = select i1 %t649, i8* %t648, i8* %t647
  %t651 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t652 = icmp eq i32 %t634, 5
  %t653 = select i1 %t652, i8* %t651, i8* %t650
  %t654 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t655 = icmp eq i32 %t634, 6
  %t656 = select i1 %t655, i8* %t654, i8* %t653
  %t657 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t658 = icmp eq i32 %t634, 7
  %t659 = select i1 %t658, i8* %t657, i8* %t656
  %t660 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t661 = icmp eq i32 %t634, 8
  %t662 = select i1 %t661, i8* %t660, i8* %t659
  %t663 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t664 = icmp eq i32 %t634, 9
  %t665 = select i1 %t664, i8* %t663, i8* %t662
  %t666 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t667 = icmp eq i32 %t634, 10
  %t668 = select i1 %t667, i8* %t666, i8* %t665
  %t669 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t670 = icmp eq i32 %t634, 11
  %t671 = select i1 %t670, i8* %t669, i8* %t668
  %t672 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t673 = icmp eq i32 %t634, 12
  %t674 = select i1 %t673, i8* %t672, i8* %t671
  %t675 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t676 = icmp eq i32 %t634, 13
  %t677 = select i1 %t676, i8* %t675, i8* %t674
  %t678 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t679 = icmp eq i32 %t634, 14
  %t680 = select i1 %t679, i8* %t678, i8* %t677
  %t681 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t682 = icmp eq i32 %t634, 15
  %t683 = select i1 %t682, i8* %t681, i8* %t680
  %t684 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t685 = icmp eq i32 %t634, 16
  %t686 = select i1 %t685, i8* %t684, i8* %t683
  %t687 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t688 = icmp eq i32 %t634, 17
  %t689 = select i1 %t688, i8* %t687, i8* %t686
  %t690 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t691 = icmp eq i32 %t634, 18
  %t692 = select i1 %t691, i8* %t690, i8* %t689
  %t693 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t694 = icmp eq i32 %t634, 19
  %t695 = select i1 %t694, i8* %t693, i8* %t692
  %t696 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t697 = icmp eq i32 %t634, 20
  %t698 = select i1 %t697, i8* %t696, i8* %t695
  %t699 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t700 = icmp eq i32 %t634, 21
  %t701 = select i1 %t700, i8* %t699, i8* %t698
  %t702 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t703 = icmp eq i32 %t634, 22
  %t704 = select i1 %t703, i8* %t702, i8* %t701
  %s705 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.705, i32 0, i32 0
  %t706 = icmp eq i8* %t704, %s705
  br i1 %t706, label %then12, label %merge13
then12:
  %t707 = extractvalue %Statement %statement, 0
  %t708 = alloca %Statement
  store %Statement %statement, %Statement* %t708
  %t709 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t710 = bitcast [48 x i8]* %t709 to i8*
  %t711 = bitcast i8* %t710 to i8**
  %t712 = load i8*, i8** %t711
  %t713 = icmp eq i32 %t707, 2
  %t714 = select i1 %t713, i8* %t712, i8* null
  %t715 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t716 = bitcast [48 x i8]* %t715 to i8*
  %t717 = bitcast i8* %t716 to i8**
  %t718 = load i8*, i8** %t717
  %t719 = icmp eq i32 %t707, 3
  %t720 = select i1 %t719, i8* %t718, i8* %t714
  %t721 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t722 = bitcast [40 x i8]* %t721 to i8*
  %t723 = bitcast i8* %t722 to i8**
  %t724 = load i8*, i8** %t723
  %t725 = icmp eq i32 %t707, 6
  %t726 = select i1 %t725, i8* %t724, i8* %t720
  %t727 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t728 = bitcast [56 x i8]* %t727 to i8*
  %t729 = bitcast i8* %t728 to i8**
  %t730 = load i8*, i8** %t729
  %t731 = icmp eq i32 %t707, 8
  %t732 = select i1 %t731, i8* %t730, i8* %t726
  %t733 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t734 = bitcast [40 x i8]* %t733 to i8*
  %t735 = bitcast i8* %t734 to i8**
  %t736 = load i8*, i8** %t735
  %t737 = icmp eq i32 %t707, 9
  %t738 = select i1 %t737, i8* %t736, i8* %t732
  %t739 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t740 = bitcast [40 x i8]* %t739 to i8*
  %t741 = bitcast i8* %t740 to i8**
  %t742 = load i8*, i8** %t741
  %t743 = icmp eq i32 %t707, 10
  %t744 = select i1 %t743, i8* %t742, i8* %t738
  %t745 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t746 = bitcast [40 x i8]* %t745 to i8*
  %t747 = bitcast i8* %t746 to i8**
  %t748 = load i8*, i8** %t747
  %t749 = icmp eq i32 %t707, 11
  %t750 = select i1 %t749, i8* %t748, i8* %t744
  %s751 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.751, i32 0, i32 0
  %t752 = extractvalue %Statement %statement, 0
  %t753 = alloca %Statement
  store %Statement %statement, %Statement* %t753
  %t754 = getelementptr inbounds %Statement, %Statement* %t753, i32 0, i32 1
  %t755 = bitcast [48 x i8]* %t754 to i8*
  %t756 = getelementptr inbounds i8, i8* %t755, i64 8
  %t757 = bitcast i8* %t756 to i8**
  %t758 = load i8*, i8** %t757
  %t759 = icmp eq i32 %t752, 3
  %t760 = select i1 %t759, i8* %t758, i8* null
  %t761 = getelementptr inbounds %Statement, %Statement* %t753, i32 0, i32 1
  %t762 = bitcast [40 x i8]* %t761 to i8*
  %t763 = getelementptr inbounds i8, i8* %t762, i64 8
  %t764 = bitcast i8* %t763 to i8**
  %t765 = load i8*, i8** %t764
  %t766 = icmp eq i32 %t752, 6
  %t767 = select i1 %t766, i8* %t765, i8* %t760
  %t768 = getelementptr inbounds %Statement, %Statement* %t753, i32 0, i32 1
  %t769 = bitcast [56 x i8]* %t768 to i8*
  %t770 = getelementptr inbounds i8, i8* %t769, i64 8
  %t771 = bitcast i8* %t770 to i8**
  %t772 = load i8*, i8** %t771
  %t773 = icmp eq i32 %t752, 8
  %t774 = select i1 %t773, i8* %t772, i8* %t767
  %t775 = getelementptr inbounds %Statement, %Statement* %t753, i32 0, i32 1
  %t776 = bitcast [40 x i8]* %t775 to i8*
  %t777 = getelementptr inbounds i8, i8* %t776, i64 8
  %t778 = bitcast i8* %t777 to i8**
  %t779 = load i8*, i8** %t778
  %t780 = icmp eq i32 %t752, 9
  %t781 = select i1 %t780, i8* %t779, i8* %t774
  %t782 = getelementptr inbounds %Statement, %Statement* %t753, i32 0, i32 1
  %t783 = bitcast [40 x i8]* %t782 to i8*
  %t784 = getelementptr inbounds i8, i8* %t783, i64 8
  %t785 = bitcast i8* %t784 to i8**
  %t786 = load i8*, i8** %t785
  %t787 = icmp eq i32 %t752, 10
  %t788 = select i1 %t787, i8* %t786, i8* %t781
  %t789 = getelementptr inbounds %Statement, %Statement* %t753, i32 0, i32 1
  %t790 = bitcast [40 x i8]* %t789 to i8*
  %t791 = getelementptr inbounds i8, i8* %t790, i64 8
  %t792 = bitcast i8* %t791 to i8**
  %t793 = load i8*, i8** %t792
  %t794 = icmp eq i32 %t752, 11
  %t795 = select i1 %t794, i8* %t793, i8* %t788
  %t796 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t750, i8* %s751, i8* %t795)
  store %ScopeResult %t796, %ScopeResult* %l7
  %t797 = load %ScopeResult, %ScopeResult* %l7
  %t798 = extractvalue %ScopeResult %t797, 1
  store { i8**, i64 }* %t798, { i8**, i64 }** %l8
  %t799 = extractvalue %Statement %statement, 0
  %t800 = alloca %Statement
  store %Statement %statement, %Statement* %t800
  %t801 = getelementptr inbounds %Statement, %Statement* %t800, i32 0, i32 1
  %t802 = bitcast [56 x i8]* %t801 to i8*
  %t803 = getelementptr inbounds i8, i8* %t802, i64 16
  %t804 = bitcast i8* %t803 to { i8**, i64 }**
  %t805 = load { i8**, i64 }*, { i8**, i64 }** %t804
  %t806 = icmp eq i32 %t799, 8
  %t807 = select i1 %t806, { i8**, i64 }* %t805, { i8**, i64 }* null
  %t808 = getelementptr inbounds %Statement, %Statement* %t800, i32 0, i32 1
  %t809 = bitcast [40 x i8]* %t808 to i8*
  %t810 = getelementptr inbounds i8, i8* %t809, i64 16
  %t811 = bitcast i8* %t810 to { i8**, i64 }**
  %t812 = load { i8**, i64 }*, { i8**, i64 }** %t811
  %t813 = icmp eq i32 %t799, 9
  %t814 = select i1 %t813, { i8**, i64 }* %t812, { i8**, i64 }* %t807
  %t815 = getelementptr inbounds %Statement, %Statement* %t800, i32 0, i32 1
  %t816 = bitcast [40 x i8]* %t815 to i8*
  %t817 = getelementptr inbounds i8, i8* %t816, i64 16
  %t818 = bitcast i8* %t817 to { i8**, i64 }**
  %t819 = load { i8**, i64 }*, { i8**, i64 }** %t818
  %t820 = icmp eq i32 %t799, 10
  %t821 = select i1 %t820, { i8**, i64 }* %t819, { i8**, i64 }* %t814
  %t822 = getelementptr inbounds %Statement, %Statement* %t800, i32 0, i32 1
  %t823 = bitcast [40 x i8]* %t822 to i8*
  %t824 = getelementptr inbounds i8, i8* %t823, i64 16
  %t825 = bitcast i8* %t824 to { i8**, i64 }**
  %t826 = load { i8**, i64 }*, { i8**, i64 }** %t825
  %t827 = icmp eq i32 %t799, 11
  %t828 = select i1 %t827, { i8**, i64 }* %t826, { i8**, i64 }* %t821
  %t829 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* null)
  %t830 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t829)
  store { i8**, i64 }* null, { i8**, i64 }** %l8
  %t831 = extractvalue %Statement %statement, 0
  %t832 = alloca %Statement
  store %Statement %statement, %Statement* %t832
  %t833 = getelementptr inbounds %Statement, %Statement* %t832, i32 0, i32 1
  %t834 = bitcast [40 x i8]* %t833 to i8*
  %t835 = getelementptr inbounds i8, i8* %t834, i64 24
  %t836 = bitcast i8* %t835 to { i8**, i64 }**
  %t837 = load { i8**, i64 }*, { i8**, i64 }** %t836
  %t838 = icmp eq i32 %t831, 11
  %t839 = select i1 %t838, { i8**, i64 }* %t837, { i8**, i64 }* null
  %t840 = call { %Diagnostic*, i64 }* @check_enum_variants({ %EnumVariant*, i64 }* null)
  %t841 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t840)
  store { i8**, i64 }* null, { i8**, i64 }** %l8
  %t842 = load %ScopeResult, %ScopeResult* %l7
  %t843 = extractvalue %ScopeResult %t842, 0
  %t844 = insertvalue %ScopeResult undef, { i8**, i64 }* %t843, 0
  %t845 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t846 = insertvalue %ScopeResult %t844, { i8**, i64 }* %t845, 1
  ret %ScopeResult %t846
merge13:
  %t847 = extractvalue %Statement %statement, 0
  %t848 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t849 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t850 = icmp eq i32 %t847, 0
  %t851 = select i1 %t850, i8* %t849, i8* %t848
  %t852 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t853 = icmp eq i32 %t847, 1
  %t854 = select i1 %t853, i8* %t852, i8* %t851
  %t855 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t856 = icmp eq i32 %t847, 2
  %t857 = select i1 %t856, i8* %t855, i8* %t854
  %t858 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t859 = icmp eq i32 %t847, 3
  %t860 = select i1 %t859, i8* %t858, i8* %t857
  %t861 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t862 = icmp eq i32 %t847, 4
  %t863 = select i1 %t862, i8* %t861, i8* %t860
  %t864 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t865 = icmp eq i32 %t847, 5
  %t866 = select i1 %t865, i8* %t864, i8* %t863
  %t867 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t868 = icmp eq i32 %t847, 6
  %t869 = select i1 %t868, i8* %t867, i8* %t866
  %t870 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t871 = icmp eq i32 %t847, 7
  %t872 = select i1 %t871, i8* %t870, i8* %t869
  %t873 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t874 = icmp eq i32 %t847, 8
  %t875 = select i1 %t874, i8* %t873, i8* %t872
  %t876 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t877 = icmp eq i32 %t847, 9
  %t878 = select i1 %t877, i8* %t876, i8* %t875
  %t879 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t880 = icmp eq i32 %t847, 10
  %t881 = select i1 %t880, i8* %t879, i8* %t878
  %t882 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t883 = icmp eq i32 %t847, 11
  %t884 = select i1 %t883, i8* %t882, i8* %t881
  %t885 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t886 = icmp eq i32 %t847, 12
  %t887 = select i1 %t886, i8* %t885, i8* %t884
  %t888 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t889 = icmp eq i32 %t847, 13
  %t890 = select i1 %t889, i8* %t888, i8* %t887
  %t891 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t892 = icmp eq i32 %t847, 14
  %t893 = select i1 %t892, i8* %t891, i8* %t890
  %t894 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t895 = icmp eq i32 %t847, 15
  %t896 = select i1 %t895, i8* %t894, i8* %t893
  %t897 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t898 = icmp eq i32 %t847, 16
  %t899 = select i1 %t898, i8* %t897, i8* %t896
  %t900 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t901 = icmp eq i32 %t847, 17
  %t902 = select i1 %t901, i8* %t900, i8* %t899
  %t903 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t904 = icmp eq i32 %t847, 18
  %t905 = select i1 %t904, i8* %t903, i8* %t902
  %t906 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t907 = icmp eq i32 %t847, 19
  %t908 = select i1 %t907, i8* %t906, i8* %t905
  %t909 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t910 = icmp eq i32 %t847, 20
  %t911 = select i1 %t910, i8* %t909, i8* %t908
  %t912 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t913 = icmp eq i32 %t847, 21
  %t914 = select i1 %t913, i8* %t912, i8* %t911
  %t915 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t916 = icmp eq i32 %t847, 22
  %t917 = select i1 %t916, i8* %t915, i8* %t914
  %s918 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.918, i32 0, i32 0
  %t919 = icmp eq i8* %t917, %s918
  br i1 %t919, label %then14, label %merge15
then14:
  %t920 = extractvalue %Statement %statement, 0
  %t921 = alloca %Statement
  store %Statement %statement, %Statement* %t921
  %t922 = getelementptr inbounds %Statement, %Statement* %t921, i32 0, i32 1
  %t923 = bitcast [48 x i8]* %t922 to i8*
  %t924 = bitcast i8* %t923 to i8**
  %t925 = load i8*, i8** %t924
  %t926 = icmp eq i32 %t920, 2
  %t927 = select i1 %t926, i8* %t925, i8* null
  %t928 = getelementptr inbounds %Statement, %Statement* %t921, i32 0, i32 1
  %t929 = bitcast [48 x i8]* %t928 to i8*
  %t930 = bitcast i8* %t929 to i8**
  %t931 = load i8*, i8** %t930
  %t932 = icmp eq i32 %t920, 3
  %t933 = select i1 %t932, i8* %t931, i8* %t927
  %t934 = getelementptr inbounds %Statement, %Statement* %t921, i32 0, i32 1
  %t935 = bitcast [40 x i8]* %t934 to i8*
  %t936 = bitcast i8* %t935 to i8**
  %t937 = load i8*, i8** %t936
  %t938 = icmp eq i32 %t920, 6
  %t939 = select i1 %t938, i8* %t937, i8* %t933
  %t940 = getelementptr inbounds %Statement, %Statement* %t921, i32 0, i32 1
  %t941 = bitcast [56 x i8]* %t940 to i8*
  %t942 = bitcast i8* %t941 to i8**
  %t943 = load i8*, i8** %t942
  %t944 = icmp eq i32 %t920, 8
  %t945 = select i1 %t944, i8* %t943, i8* %t939
  %t946 = getelementptr inbounds %Statement, %Statement* %t921, i32 0, i32 1
  %t947 = bitcast [40 x i8]* %t946 to i8*
  %t948 = bitcast i8* %t947 to i8**
  %t949 = load i8*, i8** %t948
  %t950 = icmp eq i32 %t920, 9
  %t951 = select i1 %t950, i8* %t949, i8* %t945
  %t952 = getelementptr inbounds %Statement, %Statement* %t921, i32 0, i32 1
  %t953 = bitcast [40 x i8]* %t952 to i8*
  %t954 = bitcast i8* %t953 to i8**
  %t955 = load i8*, i8** %t954
  %t956 = icmp eq i32 %t920, 10
  %t957 = select i1 %t956, i8* %t955, i8* %t951
  %t958 = getelementptr inbounds %Statement, %Statement* %t921, i32 0, i32 1
  %t959 = bitcast [40 x i8]* %t958 to i8*
  %t960 = bitcast i8* %t959 to i8**
  %t961 = load i8*, i8** %t960
  %t962 = icmp eq i32 %t920, 11
  %t963 = select i1 %t962, i8* %t961, i8* %t957
  %s964 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.964, i32 0, i32 0
  %t965 = extractvalue %Statement %statement, 0
  %t966 = alloca %Statement
  store %Statement %statement, %Statement* %t966
  %t967 = getelementptr inbounds %Statement, %Statement* %t966, i32 0, i32 1
  %t968 = bitcast [48 x i8]* %t967 to i8*
  %t969 = getelementptr inbounds i8, i8* %t968, i64 8
  %t970 = bitcast i8* %t969 to i8**
  %t971 = load i8*, i8** %t970
  %t972 = icmp eq i32 %t965, 3
  %t973 = select i1 %t972, i8* %t971, i8* null
  %t974 = getelementptr inbounds %Statement, %Statement* %t966, i32 0, i32 1
  %t975 = bitcast [40 x i8]* %t974 to i8*
  %t976 = getelementptr inbounds i8, i8* %t975, i64 8
  %t977 = bitcast i8* %t976 to i8**
  %t978 = load i8*, i8** %t977
  %t979 = icmp eq i32 %t965, 6
  %t980 = select i1 %t979, i8* %t978, i8* %t973
  %t981 = getelementptr inbounds %Statement, %Statement* %t966, i32 0, i32 1
  %t982 = bitcast [56 x i8]* %t981 to i8*
  %t983 = getelementptr inbounds i8, i8* %t982, i64 8
  %t984 = bitcast i8* %t983 to i8**
  %t985 = load i8*, i8** %t984
  %t986 = icmp eq i32 %t965, 8
  %t987 = select i1 %t986, i8* %t985, i8* %t980
  %t988 = getelementptr inbounds %Statement, %Statement* %t966, i32 0, i32 1
  %t989 = bitcast [40 x i8]* %t988 to i8*
  %t990 = getelementptr inbounds i8, i8* %t989, i64 8
  %t991 = bitcast i8* %t990 to i8**
  %t992 = load i8*, i8** %t991
  %t993 = icmp eq i32 %t965, 9
  %t994 = select i1 %t993, i8* %t992, i8* %t987
  %t995 = getelementptr inbounds %Statement, %Statement* %t966, i32 0, i32 1
  %t996 = bitcast [40 x i8]* %t995 to i8*
  %t997 = getelementptr inbounds i8, i8* %t996, i64 8
  %t998 = bitcast i8* %t997 to i8**
  %t999 = load i8*, i8** %t998
  %t1000 = icmp eq i32 %t965, 10
  %t1001 = select i1 %t1000, i8* %t999, i8* %t994
  %t1002 = getelementptr inbounds %Statement, %Statement* %t966, i32 0, i32 1
  %t1003 = bitcast [40 x i8]* %t1002 to i8*
  %t1004 = getelementptr inbounds i8, i8* %t1003, i64 8
  %t1005 = bitcast i8* %t1004 to i8**
  %t1006 = load i8*, i8** %t1005
  %t1007 = icmp eq i32 %t965, 11
  %t1008 = select i1 %t1007, i8* %t1006, i8* %t1001
  %t1009 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t963, i8* %s964, i8* %t1008)
  store %ScopeResult %t1009, %ScopeResult* %l9
  %t1010 = load %ScopeResult, %ScopeResult* %l9
  %t1011 = extractvalue %ScopeResult %t1010, 1
  store { i8**, i64 }* %t1011, { i8**, i64 }** %l10
  %t1012 = extractvalue %Statement %statement, 0
  %t1013 = alloca %Statement
  store %Statement %statement, %Statement* %t1013
  %t1014 = getelementptr inbounds %Statement, %Statement* %t1013, i32 0, i32 1
  %t1015 = bitcast [56 x i8]* %t1014 to i8*
  %t1016 = getelementptr inbounds i8, i8* %t1015, i64 16
  %t1017 = bitcast i8* %t1016 to { i8**, i64 }**
  %t1018 = load { i8**, i64 }*, { i8**, i64 }** %t1017
  %t1019 = icmp eq i32 %t1012, 8
  %t1020 = select i1 %t1019, { i8**, i64 }* %t1018, { i8**, i64 }* null
  %t1021 = getelementptr inbounds %Statement, %Statement* %t1013, i32 0, i32 1
  %t1022 = bitcast [40 x i8]* %t1021 to i8*
  %t1023 = getelementptr inbounds i8, i8* %t1022, i64 16
  %t1024 = bitcast i8* %t1023 to { i8**, i64 }**
  %t1025 = load { i8**, i64 }*, { i8**, i64 }** %t1024
  %t1026 = icmp eq i32 %t1012, 9
  %t1027 = select i1 %t1026, { i8**, i64 }* %t1025, { i8**, i64 }* %t1020
  %t1028 = getelementptr inbounds %Statement, %Statement* %t1013, i32 0, i32 1
  %t1029 = bitcast [40 x i8]* %t1028 to i8*
  %t1030 = getelementptr inbounds i8, i8* %t1029, i64 16
  %t1031 = bitcast i8* %t1030 to { i8**, i64 }**
  %t1032 = load { i8**, i64 }*, { i8**, i64 }** %t1031
  %t1033 = icmp eq i32 %t1012, 10
  %t1034 = select i1 %t1033, { i8**, i64 }* %t1032, { i8**, i64 }* %t1027
  %t1035 = getelementptr inbounds %Statement, %Statement* %t1013, i32 0, i32 1
  %t1036 = bitcast [40 x i8]* %t1035 to i8*
  %t1037 = getelementptr inbounds i8, i8* %t1036, i64 16
  %t1038 = bitcast i8* %t1037 to { i8**, i64 }**
  %t1039 = load { i8**, i64 }*, { i8**, i64 }** %t1038
  %t1040 = icmp eq i32 %t1012, 11
  %t1041 = select i1 %t1040, { i8**, i64 }* %t1039, { i8**, i64 }* %t1034
  %t1042 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* null)
  %t1043 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t1042)
  store { i8**, i64 }* null, { i8**, i64 }** %l10
  %t1044 = extractvalue %Statement %statement, 0
  %t1045 = alloca %Statement
  store %Statement %statement, %Statement* %t1045
  %t1046 = getelementptr inbounds %Statement, %Statement* %t1045, i32 0, i32 1
  %t1047 = bitcast [40 x i8]* %t1046 to i8*
  %t1048 = getelementptr inbounds i8, i8* %t1047, i64 24
  %t1049 = bitcast i8* %t1048 to { i8**, i64 }**
  %t1050 = load { i8**, i64 }*, { i8**, i64 }** %t1049
  %t1051 = icmp eq i32 %t1044, 10
  %t1052 = select i1 %t1051, { i8**, i64 }* %t1050, { i8**, i64 }* null
  %t1053 = call { %Diagnostic*, i64 }* @check_interface_members({ %FunctionSignature*, i64 }* null)
  %t1054 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t1053)
  store { i8**, i64 }* null, { i8**, i64 }** %l10
  %t1055 = load %ScopeResult, %ScopeResult* %l9
  %t1056 = extractvalue %ScopeResult %t1055, 0
  %t1057 = insertvalue %ScopeResult undef, { i8**, i64 }* %t1056, 0
  %t1058 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t1059 = insertvalue %ScopeResult %t1057, { i8**, i64 }* %t1058, 1
  ret %ScopeResult %t1059
merge15:
  %t1060 = extractvalue %Statement %statement, 0
  %t1061 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1062 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1063 = icmp eq i32 %t1060, 0
  %t1064 = select i1 %t1063, i8* %t1062, i8* %t1061
  %t1065 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1066 = icmp eq i32 %t1060, 1
  %t1067 = select i1 %t1066, i8* %t1065, i8* %t1064
  %t1068 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1069 = icmp eq i32 %t1060, 2
  %t1070 = select i1 %t1069, i8* %t1068, i8* %t1067
  %t1071 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1072 = icmp eq i32 %t1060, 3
  %t1073 = select i1 %t1072, i8* %t1071, i8* %t1070
  %t1074 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1075 = icmp eq i32 %t1060, 4
  %t1076 = select i1 %t1075, i8* %t1074, i8* %t1073
  %t1077 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1078 = icmp eq i32 %t1060, 5
  %t1079 = select i1 %t1078, i8* %t1077, i8* %t1076
  %t1080 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1081 = icmp eq i32 %t1060, 6
  %t1082 = select i1 %t1081, i8* %t1080, i8* %t1079
  %t1083 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1084 = icmp eq i32 %t1060, 7
  %t1085 = select i1 %t1084, i8* %t1083, i8* %t1082
  %t1086 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1087 = icmp eq i32 %t1060, 8
  %t1088 = select i1 %t1087, i8* %t1086, i8* %t1085
  %t1089 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1090 = icmp eq i32 %t1060, 9
  %t1091 = select i1 %t1090, i8* %t1089, i8* %t1088
  %t1092 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1093 = icmp eq i32 %t1060, 10
  %t1094 = select i1 %t1093, i8* %t1092, i8* %t1091
  %t1095 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1096 = icmp eq i32 %t1060, 11
  %t1097 = select i1 %t1096, i8* %t1095, i8* %t1094
  %t1098 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1099 = icmp eq i32 %t1060, 12
  %t1100 = select i1 %t1099, i8* %t1098, i8* %t1097
  %t1101 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1102 = icmp eq i32 %t1060, 13
  %t1103 = select i1 %t1102, i8* %t1101, i8* %t1100
  %t1104 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1105 = icmp eq i32 %t1060, 14
  %t1106 = select i1 %t1105, i8* %t1104, i8* %t1103
  %t1107 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1108 = icmp eq i32 %t1060, 15
  %t1109 = select i1 %t1108, i8* %t1107, i8* %t1106
  %t1110 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1111 = icmp eq i32 %t1060, 16
  %t1112 = select i1 %t1111, i8* %t1110, i8* %t1109
  %t1113 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1114 = icmp eq i32 %t1060, 17
  %t1115 = select i1 %t1114, i8* %t1113, i8* %t1112
  %t1116 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1117 = icmp eq i32 %t1060, 18
  %t1118 = select i1 %t1117, i8* %t1116, i8* %t1115
  %t1119 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1120 = icmp eq i32 %t1060, 19
  %t1121 = select i1 %t1120, i8* %t1119, i8* %t1118
  %t1122 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1123 = icmp eq i32 %t1060, 20
  %t1124 = select i1 %t1123, i8* %t1122, i8* %t1121
  %t1125 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1126 = icmp eq i32 %t1060, 21
  %t1127 = select i1 %t1126, i8* %t1125, i8* %t1124
  %t1128 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1129 = icmp eq i32 %t1060, 22
  %t1130 = select i1 %t1129, i8* %t1128, i8* %t1127
  %s1131 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.1131, i32 0, i32 0
  %t1132 = icmp eq i8* %t1130, %s1131
  br i1 %t1132, label %then16, label %merge17
then16:
  %t1133 = extractvalue %Statement %statement, 0
  %t1134 = alloca %Statement
  store %Statement %statement, %Statement* %t1134
  %t1135 = getelementptr inbounds %Statement, %Statement* %t1134, i32 0, i32 1
  %t1136 = bitcast [48 x i8]* %t1135 to i8*
  %t1137 = bitcast i8* %t1136 to i8**
  %t1138 = load i8*, i8** %t1137
  %t1139 = icmp eq i32 %t1133, 2
  %t1140 = select i1 %t1139, i8* %t1138, i8* null
  %t1141 = getelementptr inbounds %Statement, %Statement* %t1134, i32 0, i32 1
  %t1142 = bitcast [48 x i8]* %t1141 to i8*
  %t1143 = bitcast i8* %t1142 to i8**
  %t1144 = load i8*, i8** %t1143
  %t1145 = icmp eq i32 %t1133, 3
  %t1146 = select i1 %t1145, i8* %t1144, i8* %t1140
  %t1147 = getelementptr inbounds %Statement, %Statement* %t1134, i32 0, i32 1
  %t1148 = bitcast [40 x i8]* %t1147 to i8*
  %t1149 = bitcast i8* %t1148 to i8**
  %t1150 = load i8*, i8** %t1149
  %t1151 = icmp eq i32 %t1133, 6
  %t1152 = select i1 %t1151, i8* %t1150, i8* %t1146
  %t1153 = getelementptr inbounds %Statement, %Statement* %t1134, i32 0, i32 1
  %t1154 = bitcast [56 x i8]* %t1153 to i8*
  %t1155 = bitcast i8* %t1154 to i8**
  %t1156 = load i8*, i8** %t1155
  %t1157 = icmp eq i32 %t1133, 8
  %t1158 = select i1 %t1157, i8* %t1156, i8* %t1152
  %t1159 = getelementptr inbounds %Statement, %Statement* %t1134, i32 0, i32 1
  %t1160 = bitcast [40 x i8]* %t1159 to i8*
  %t1161 = bitcast i8* %t1160 to i8**
  %t1162 = load i8*, i8** %t1161
  %t1163 = icmp eq i32 %t1133, 9
  %t1164 = select i1 %t1163, i8* %t1162, i8* %t1158
  %t1165 = getelementptr inbounds %Statement, %Statement* %t1134, i32 0, i32 1
  %t1166 = bitcast [40 x i8]* %t1165 to i8*
  %t1167 = bitcast i8* %t1166 to i8**
  %t1168 = load i8*, i8** %t1167
  %t1169 = icmp eq i32 %t1133, 10
  %t1170 = select i1 %t1169, i8* %t1168, i8* %t1164
  %t1171 = getelementptr inbounds %Statement, %Statement* %t1134, i32 0, i32 1
  %t1172 = bitcast [40 x i8]* %t1171 to i8*
  %t1173 = bitcast i8* %t1172 to i8**
  %t1174 = load i8*, i8** %t1173
  %t1175 = icmp eq i32 %t1133, 11
  %t1176 = select i1 %t1175, i8* %t1174, i8* %t1170
  %s1177 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1177, i32 0, i32 0
  %t1178 = extractvalue %Statement %statement, 0
  %t1179 = alloca %Statement
  store %Statement %statement, %Statement* %t1179
  %t1180 = getelementptr inbounds %Statement, %Statement* %t1179, i32 0, i32 1
  %t1181 = bitcast [48 x i8]* %t1180 to i8*
  %t1182 = getelementptr inbounds i8, i8* %t1181, i64 8
  %t1183 = bitcast i8* %t1182 to i8**
  %t1184 = load i8*, i8** %t1183
  %t1185 = icmp eq i32 %t1178, 3
  %t1186 = select i1 %t1185, i8* %t1184, i8* null
  %t1187 = getelementptr inbounds %Statement, %Statement* %t1179, i32 0, i32 1
  %t1188 = bitcast [40 x i8]* %t1187 to i8*
  %t1189 = getelementptr inbounds i8, i8* %t1188, i64 8
  %t1190 = bitcast i8* %t1189 to i8**
  %t1191 = load i8*, i8** %t1190
  %t1192 = icmp eq i32 %t1178, 6
  %t1193 = select i1 %t1192, i8* %t1191, i8* %t1186
  %t1194 = getelementptr inbounds %Statement, %Statement* %t1179, i32 0, i32 1
  %t1195 = bitcast [56 x i8]* %t1194 to i8*
  %t1196 = getelementptr inbounds i8, i8* %t1195, i64 8
  %t1197 = bitcast i8* %t1196 to i8**
  %t1198 = load i8*, i8** %t1197
  %t1199 = icmp eq i32 %t1178, 8
  %t1200 = select i1 %t1199, i8* %t1198, i8* %t1193
  %t1201 = getelementptr inbounds %Statement, %Statement* %t1179, i32 0, i32 1
  %t1202 = bitcast [40 x i8]* %t1201 to i8*
  %t1203 = getelementptr inbounds i8, i8* %t1202, i64 8
  %t1204 = bitcast i8* %t1203 to i8**
  %t1205 = load i8*, i8** %t1204
  %t1206 = icmp eq i32 %t1178, 9
  %t1207 = select i1 %t1206, i8* %t1205, i8* %t1200
  %t1208 = getelementptr inbounds %Statement, %Statement* %t1179, i32 0, i32 1
  %t1209 = bitcast [40 x i8]* %t1208 to i8*
  %t1210 = getelementptr inbounds i8, i8* %t1209, i64 8
  %t1211 = bitcast i8* %t1210 to i8**
  %t1212 = load i8*, i8** %t1211
  %t1213 = icmp eq i32 %t1178, 10
  %t1214 = select i1 %t1213, i8* %t1212, i8* %t1207
  %t1215 = getelementptr inbounds %Statement, %Statement* %t1179, i32 0, i32 1
  %t1216 = bitcast [40 x i8]* %t1215 to i8*
  %t1217 = getelementptr inbounds i8, i8* %t1216, i64 8
  %t1218 = bitcast i8* %t1217 to i8**
  %t1219 = load i8*, i8** %t1218
  %t1220 = icmp eq i32 %t1178, 11
  %t1221 = select i1 %t1220, i8* %t1219, i8* %t1214
  %t1222 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1176, i8* %s1177, i8* %t1221)
  store %ScopeResult %t1222, %ScopeResult* %l11
  %t1223 = extractvalue %Statement %statement, 0
  %t1224 = alloca %Statement
  store %Statement %statement, %Statement* %t1224
  %t1225 = getelementptr inbounds %Statement, %Statement* %t1224, i32 0, i32 1
  %t1226 = bitcast [48 x i8]* %t1225 to i8*
  %t1227 = getelementptr inbounds i8, i8* %t1226, i64 24
  %t1228 = bitcast i8* %t1227 to { i8**, i64 }**
  %t1229 = load { i8**, i64 }*, { i8**, i64 }** %t1228
  %t1230 = icmp eq i32 %t1223, 3
  %t1231 = select i1 %t1230, { i8**, i64 }* %t1229, { i8**, i64 }* null
  %t1232 = call { %Diagnostic*, i64 }* @check_model_properties({ %ModelProperty*, i64 }* null)
  %t1233 = call double @registrationdiagnosticsconcat({ %Diagnostic*, i64 }* %t1232)
  store double %t1233, double* %l12
  %t1234 = load %ScopeResult, %ScopeResult* %l11
  %t1235 = extractvalue %ScopeResult %t1234, 0
  %t1236 = insertvalue %ScopeResult undef, { i8**, i64 }* %t1235, 0
  %t1237 = load double, double* %l12
  %t1238 = insertvalue %ScopeResult %t1236, { i8**, i64 }* null, 1
  ret %ScopeResult %t1238
merge17:
  %t1239 = extractvalue %Statement %statement, 0
  %t1240 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1241 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1242 = icmp eq i32 %t1239, 0
  %t1243 = select i1 %t1242, i8* %t1241, i8* %t1240
  %t1244 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1245 = icmp eq i32 %t1239, 1
  %t1246 = select i1 %t1245, i8* %t1244, i8* %t1243
  %t1247 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1248 = icmp eq i32 %t1239, 2
  %t1249 = select i1 %t1248, i8* %t1247, i8* %t1246
  %t1250 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1251 = icmp eq i32 %t1239, 3
  %t1252 = select i1 %t1251, i8* %t1250, i8* %t1249
  %t1253 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1254 = icmp eq i32 %t1239, 4
  %t1255 = select i1 %t1254, i8* %t1253, i8* %t1252
  %t1256 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1257 = icmp eq i32 %t1239, 5
  %t1258 = select i1 %t1257, i8* %t1256, i8* %t1255
  %t1259 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1260 = icmp eq i32 %t1239, 6
  %t1261 = select i1 %t1260, i8* %t1259, i8* %t1258
  %t1262 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1263 = icmp eq i32 %t1239, 7
  %t1264 = select i1 %t1263, i8* %t1262, i8* %t1261
  %t1265 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1266 = icmp eq i32 %t1239, 8
  %t1267 = select i1 %t1266, i8* %t1265, i8* %t1264
  %t1268 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1269 = icmp eq i32 %t1239, 9
  %t1270 = select i1 %t1269, i8* %t1268, i8* %t1267
  %t1271 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1272 = icmp eq i32 %t1239, 10
  %t1273 = select i1 %t1272, i8* %t1271, i8* %t1270
  %t1274 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1275 = icmp eq i32 %t1239, 11
  %t1276 = select i1 %t1275, i8* %t1274, i8* %t1273
  %t1277 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1278 = icmp eq i32 %t1239, 12
  %t1279 = select i1 %t1278, i8* %t1277, i8* %t1276
  %t1280 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1281 = icmp eq i32 %t1239, 13
  %t1282 = select i1 %t1281, i8* %t1280, i8* %t1279
  %t1283 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1284 = icmp eq i32 %t1239, 14
  %t1285 = select i1 %t1284, i8* %t1283, i8* %t1282
  %t1286 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1287 = icmp eq i32 %t1239, 15
  %t1288 = select i1 %t1287, i8* %t1286, i8* %t1285
  %t1289 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1290 = icmp eq i32 %t1239, 16
  %t1291 = select i1 %t1290, i8* %t1289, i8* %t1288
  %t1292 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1293 = icmp eq i32 %t1239, 17
  %t1294 = select i1 %t1293, i8* %t1292, i8* %t1291
  %t1295 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1296 = icmp eq i32 %t1239, 18
  %t1297 = select i1 %t1296, i8* %t1295, i8* %t1294
  %t1298 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1299 = icmp eq i32 %t1239, 19
  %t1300 = select i1 %t1299, i8* %t1298, i8* %t1297
  %t1301 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1302 = icmp eq i32 %t1239, 20
  %t1303 = select i1 %t1302, i8* %t1301, i8* %t1300
  %t1304 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1305 = icmp eq i32 %t1239, 21
  %t1306 = select i1 %t1305, i8* %t1304, i8* %t1303
  %t1307 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1308 = icmp eq i32 %t1239, 22
  %t1309 = select i1 %t1308, i8* %t1307, i8* %t1306
  %s1310 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1310, i32 0, i32 0
  %t1311 = icmp eq i8* %t1309, %s1310
  br i1 %t1311, label %then18, label %merge19
then18:
  %t1312 = extractvalue %Statement %statement, 0
  %t1313 = alloca %Statement
  store %Statement %statement, %Statement* %t1313
  %t1314 = getelementptr inbounds %Statement, %Statement* %t1313, i32 0, i32 1
  %t1315 = bitcast [24 x i8]* %t1314 to i8*
  %t1316 = bitcast i8* %t1315 to i8**
  %t1317 = load i8*, i8** %t1316
  %t1318 = icmp eq i32 %t1312, 4
  %t1319 = select i1 %t1318, i8* %t1317, i8* null
  %t1320 = getelementptr inbounds %Statement, %Statement* %t1313, i32 0, i32 1
  %t1321 = bitcast [24 x i8]* %t1320 to i8*
  %t1322 = bitcast i8* %t1321 to i8**
  %t1323 = load i8*, i8** %t1322
  %t1324 = icmp eq i32 %t1312, 5
  %t1325 = select i1 %t1324, i8* %t1323, i8* %t1319
  %t1326 = getelementptr inbounds %Statement, %Statement* %t1313, i32 0, i32 1
  %t1327 = bitcast [24 x i8]* %t1326 to i8*
  %t1328 = bitcast i8* %t1327 to i8**
  %t1329 = load i8*, i8** %t1328
  %t1330 = icmp eq i32 %t1312, 7
  %t1331 = select i1 %t1330, i8* %t1329, i8* %t1325
  %s1332 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1332, i32 0, i32 0
  %t1333 = extractvalue %Statement %statement, 0
  %t1334 = alloca %Statement
  store %Statement %statement, %Statement* %t1334
  %t1335 = getelementptr inbounds %Statement, %Statement* %t1334, i32 0, i32 1
  %t1336 = bitcast [24 x i8]* %t1335 to i8*
  %t1337 = bitcast i8* %t1336 to i8**
  %t1338 = load i8*, i8** %t1337
  %t1339 = icmp eq i32 %t1333, 4
  %t1340 = select i1 %t1339, i8* %t1338, i8* null
  %t1341 = getelementptr inbounds %Statement, %Statement* %t1334, i32 0, i32 1
  %t1342 = bitcast [24 x i8]* %t1341 to i8*
  %t1343 = bitcast i8* %t1342 to i8**
  %t1344 = load i8*, i8** %t1343
  %t1345 = icmp eq i32 %t1333, 5
  %t1346 = select i1 %t1345, i8* %t1344, i8* %t1340
  %t1347 = getelementptr inbounds %Statement, %Statement* %t1334, i32 0, i32 1
  %t1348 = bitcast [24 x i8]* %t1347 to i8*
  %t1349 = bitcast i8* %t1348 to i8**
  %t1350 = load i8*, i8** %t1349
  %t1351 = icmp eq i32 %t1333, 7
  %t1352 = select i1 %t1351, i8* %t1350, i8* %t1346
  store double 0.0, double* %l13
  %t1353 = load double, double* %l13
  store double 0.0, double* %l14
  %t1354 = extractvalue %Statement %statement, 0
  %t1355 = alloca %Statement
  store %Statement %statement, %Statement* %t1355
  %t1356 = getelementptr inbounds %Statement, %Statement* %t1355, i32 0, i32 1
  %t1357 = bitcast [24 x i8]* %t1356 to i8*
  %t1358 = bitcast i8* %t1357 to i8**
  %t1359 = load i8*, i8** %t1358
  %t1360 = icmp eq i32 %t1354, 4
  %t1361 = select i1 %t1360, i8* %t1359, i8* null
  %t1362 = getelementptr inbounds %Statement, %Statement* %t1355, i32 0, i32 1
  %t1363 = bitcast [24 x i8]* %t1362 to i8*
  %t1364 = bitcast i8* %t1363 to i8**
  %t1365 = load i8*, i8** %t1364
  %t1366 = icmp eq i32 %t1354, 5
  %t1367 = select i1 %t1366, i8* %t1365, i8* %t1361
  %t1368 = getelementptr inbounds %Statement, %Statement* %t1355, i32 0, i32 1
  %t1369 = bitcast [24 x i8]* %t1368 to i8*
  %t1370 = bitcast i8* %t1369 to i8**
  %t1371 = load i8*, i8** %t1370
  %t1372 = icmp eq i32 %t1354, 7
  %t1373 = select i1 %t1372, i8* %t1371, i8* %t1367
  %t1374 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature zeroinitializer)
  %t1375 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t1374)
  store double %t1375, double* %l14
  %t1376 = extractvalue %Statement %statement, 0
  %t1377 = alloca %Statement
  store %Statement %statement, %Statement* %t1377
  %t1378 = getelementptr inbounds %Statement, %Statement* %t1377, i32 0, i32 1
  %t1379 = bitcast [24 x i8]* %t1378 to i8*
  %t1380 = bitcast i8* %t1379 to i8**
  %t1381 = load i8*, i8** %t1380
  %t1382 = icmp eq i32 %t1376, 4
  %t1383 = select i1 %t1382, i8* %t1381, i8* null
  %t1384 = getelementptr inbounds %Statement, %Statement* %t1377, i32 0, i32 1
  %t1385 = bitcast [24 x i8]* %t1384 to i8*
  %t1386 = bitcast i8* %t1385 to i8**
  %t1387 = load i8*, i8** %t1386
  %t1388 = icmp eq i32 %t1376, 5
  %t1389 = select i1 %t1388, i8* %t1387, i8* %t1383
  %t1390 = getelementptr inbounds %Statement, %Statement* %t1377, i32 0, i32 1
  %t1391 = bitcast [24 x i8]* %t1390 to i8*
  %t1392 = bitcast i8* %t1391 to i8**
  %t1393 = load i8*, i8** %t1392
  %t1394 = icmp eq i32 %t1376, 7
  %t1395 = select i1 %t1394, i8* %t1393, i8* %t1389
  %t1396 = extractvalue %Statement %statement, 0
  %t1397 = alloca %Statement
  store %Statement %statement, %Statement* %t1397
  %t1398 = getelementptr inbounds %Statement, %Statement* %t1397, i32 0, i32 1
  %t1399 = bitcast [24 x i8]* %t1398 to i8*
  %t1400 = getelementptr inbounds i8, i8* %t1399, i64 8
  %t1401 = bitcast i8* %t1400 to i8**
  %t1402 = load i8*, i8** %t1401
  %t1403 = icmp eq i32 %t1396, 4
  %t1404 = select i1 %t1403, i8* %t1402, i8* null
  %t1405 = getelementptr inbounds %Statement, %Statement* %t1397, i32 0, i32 1
  %t1406 = bitcast [24 x i8]* %t1405 to i8*
  %t1407 = getelementptr inbounds i8, i8* %t1406, i64 8
  %t1408 = bitcast i8* %t1407 to i8**
  %t1409 = load i8*, i8** %t1408
  %t1410 = icmp eq i32 %t1396, 5
  %t1411 = select i1 %t1410, i8* %t1409, i8* %t1404
  %t1412 = getelementptr inbounds %Statement, %Statement* %t1397, i32 0, i32 1
  %t1413 = bitcast [40 x i8]* %t1412 to i8*
  %t1414 = getelementptr inbounds i8, i8* %t1413, i64 16
  %t1415 = bitcast i8* %t1414 to i8**
  %t1416 = load i8*, i8** %t1415
  %t1417 = icmp eq i32 %t1396, 6
  %t1418 = select i1 %t1417, i8* %t1416, i8* %t1411
  %t1419 = getelementptr inbounds %Statement, %Statement* %t1397, i32 0, i32 1
  %t1420 = bitcast [24 x i8]* %t1419 to i8*
  %t1421 = getelementptr inbounds i8, i8* %t1420, i64 8
  %t1422 = bitcast i8* %t1421 to i8**
  %t1423 = load i8*, i8** %t1422
  %t1424 = icmp eq i32 %t1396, 7
  %t1425 = select i1 %t1424, i8* %t1423, i8* %t1418
  %t1426 = getelementptr inbounds %Statement, %Statement* %t1397, i32 0, i32 1
  %t1427 = bitcast [40 x i8]* %t1426 to i8*
  %t1428 = getelementptr inbounds i8, i8* %t1427, i64 24
  %t1429 = bitcast i8* %t1428 to i8**
  %t1430 = load i8*, i8** %t1429
  %t1431 = icmp eq i32 %t1396, 12
  %t1432 = select i1 %t1431, i8* %t1430, i8* %t1425
  %t1433 = getelementptr inbounds %Statement, %Statement* %t1397, i32 0, i32 1
  %t1434 = bitcast [24 x i8]* %t1433 to i8*
  %t1435 = getelementptr inbounds i8, i8* %t1434, i64 8
  %t1436 = bitcast i8* %t1435 to i8**
  %t1437 = load i8*, i8** %t1436
  %t1438 = icmp eq i32 %t1396, 13
  %t1439 = select i1 %t1438, i8* %t1437, i8* %t1432
  %t1440 = getelementptr inbounds %Statement, %Statement* %t1397, i32 0, i32 1
  %t1441 = bitcast [24 x i8]* %t1440 to i8*
  %t1442 = getelementptr inbounds i8, i8* %t1441, i64 8
  %t1443 = bitcast i8* %t1442 to i8**
  %t1444 = load i8*, i8** %t1443
  %t1445 = icmp eq i32 %t1396, 14
  %t1446 = select i1 %t1445, i8* %t1444, i8* %t1439
  %t1447 = getelementptr inbounds %Statement, %Statement* %t1397, i32 0, i32 1
  %t1448 = bitcast [16 x i8]* %t1447 to i8*
  %t1449 = bitcast i8* %t1448 to i8**
  %t1450 = load i8*, i8** %t1449
  %t1451 = icmp eq i32 %t1396, 15
  %t1452 = select i1 %t1451, i8* %t1450, i8* %t1446
  %t1453 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature zeroinitializer, %Block zeroinitializer, { %Statement*, i64 }* %interfaces)
  %t1454 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t1453)
  store double %t1454, double* %l14
  %t1455 = load double, double* %l13
  %t1456 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t1457 = load double, double* %l14
  %t1458 = insertvalue %ScopeResult %t1456, { i8**, i64 }* null, 1
  ret %ScopeResult %t1458
merge19:
  %t1459 = extractvalue %Statement %statement, 0
  %t1460 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1461 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1462 = icmp eq i32 %t1459, 0
  %t1463 = select i1 %t1462, i8* %t1461, i8* %t1460
  %t1464 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1465 = icmp eq i32 %t1459, 1
  %t1466 = select i1 %t1465, i8* %t1464, i8* %t1463
  %t1467 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1468 = icmp eq i32 %t1459, 2
  %t1469 = select i1 %t1468, i8* %t1467, i8* %t1466
  %t1470 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1471 = icmp eq i32 %t1459, 3
  %t1472 = select i1 %t1471, i8* %t1470, i8* %t1469
  %t1473 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1474 = icmp eq i32 %t1459, 4
  %t1475 = select i1 %t1474, i8* %t1473, i8* %t1472
  %t1476 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1477 = icmp eq i32 %t1459, 5
  %t1478 = select i1 %t1477, i8* %t1476, i8* %t1475
  %t1479 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1480 = icmp eq i32 %t1459, 6
  %t1481 = select i1 %t1480, i8* %t1479, i8* %t1478
  %t1482 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1483 = icmp eq i32 %t1459, 7
  %t1484 = select i1 %t1483, i8* %t1482, i8* %t1481
  %t1485 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1486 = icmp eq i32 %t1459, 8
  %t1487 = select i1 %t1486, i8* %t1485, i8* %t1484
  %t1488 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1489 = icmp eq i32 %t1459, 9
  %t1490 = select i1 %t1489, i8* %t1488, i8* %t1487
  %t1491 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1492 = icmp eq i32 %t1459, 10
  %t1493 = select i1 %t1492, i8* %t1491, i8* %t1490
  %t1494 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1495 = icmp eq i32 %t1459, 11
  %t1496 = select i1 %t1495, i8* %t1494, i8* %t1493
  %t1497 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1498 = icmp eq i32 %t1459, 12
  %t1499 = select i1 %t1498, i8* %t1497, i8* %t1496
  %t1500 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1501 = icmp eq i32 %t1459, 13
  %t1502 = select i1 %t1501, i8* %t1500, i8* %t1499
  %t1503 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1504 = icmp eq i32 %t1459, 14
  %t1505 = select i1 %t1504, i8* %t1503, i8* %t1502
  %t1506 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1507 = icmp eq i32 %t1459, 15
  %t1508 = select i1 %t1507, i8* %t1506, i8* %t1505
  %t1509 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1510 = icmp eq i32 %t1459, 16
  %t1511 = select i1 %t1510, i8* %t1509, i8* %t1508
  %t1512 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1513 = icmp eq i32 %t1459, 17
  %t1514 = select i1 %t1513, i8* %t1512, i8* %t1511
  %t1515 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1516 = icmp eq i32 %t1459, 18
  %t1517 = select i1 %t1516, i8* %t1515, i8* %t1514
  %t1518 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1519 = icmp eq i32 %t1459, 19
  %t1520 = select i1 %t1519, i8* %t1518, i8* %t1517
  %t1521 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1522 = icmp eq i32 %t1459, 20
  %t1523 = select i1 %t1522, i8* %t1521, i8* %t1520
  %t1524 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1525 = icmp eq i32 %t1459, 21
  %t1526 = select i1 %t1525, i8* %t1524, i8* %t1523
  %t1527 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1528 = icmp eq i32 %t1459, 22
  %t1529 = select i1 %t1528, i8* %t1527, i8* %t1526
  %s1530 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1530, i32 0, i32 0
  %t1531 = icmp eq i8* %t1529, %s1530
  br i1 %t1531, label %then20, label %merge21
then20:
  %t1532 = extractvalue %Statement %statement, 0
  %t1533 = alloca %Statement
  store %Statement %statement, %Statement* %t1533
  %t1534 = getelementptr inbounds %Statement, %Statement* %t1533, i32 0, i32 1
  %t1535 = bitcast [24 x i8]* %t1534 to i8*
  %t1536 = bitcast i8* %t1535 to i8**
  %t1537 = load i8*, i8** %t1536
  %t1538 = icmp eq i32 %t1532, 4
  %t1539 = select i1 %t1538, i8* %t1537, i8* null
  %t1540 = getelementptr inbounds %Statement, %Statement* %t1533, i32 0, i32 1
  %t1541 = bitcast [24 x i8]* %t1540 to i8*
  %t1542 = bitcast i8* %t1541 to i8**
  %t1543 = load i8*, i8** %t1542
  %t1544 = icmp eq i32 %t1532, 5
  %t1545 = select i1 %t1544, i8* %t1543, i8* %t1539
  %t1546 = getelementptr inbounds %Statement, %Statement* %t1533, i32 0, i32 1
  %t1547 = bitcast [24 x i8]* %t1546 to i8*
  %t1548 = bitcast i8* %t1547 to i8**
  %t1549 = load i8*, i8** %t1548
  %t1550 = icmp eq i32 %t1532, 7
  %t1551 = select i1 %t1550, i8* %t1549, i8* %t1545
  %s1552 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1552, i32 0, i32 0
  %t1553 = extractvalue %Statement %statement, 0
  %t1554 = alloca %Statement
  store %Statement %statement, %Statement* %t1554
  %t1555 = getelementptr inbounds %Statement, %Statement* %t1554, i32 0, i32 1
  %t1556 = bitcast [24 x i8]* %t1555 to i8*
  %t1557 = bitcast i8* %t1556 to i8**
  %t1558 = load i8*, i8** %t1557
  %t1559 = icmp eq i32 %t1553, 4
  %t1560 = select i1 %t1559, i8* %t1558, i8* null
  %t1561 = getelementptr inbounds %Statement, %Statement* %t1554, i32 0, i32 1
  %t1562 = bitcast [24 x i8]* %t1561 to i8*
  %t1563 = bitcast i8* %t1562 to i8**
  %t1564 = load i8*, i8** %t1563
  %t1565 = icmp eq i32 %t1553, 5
  %t1566 = select i1 %t1565, i8* %t1564, i8* %t1560
  %t1567 = getelementptr inbounds %Statement, %Statement* %t1554, i32 0, i32 1
  %t1568 = bitcast [24 x i8]* %t1567 to i8*
  %t1569 = bitcast i8* %t1568 to i8**
  %t1570 = load i8*, i8** %t1569
  %t1571 = icmp eq i32 %t1553, 7
  %t1572 = select i1 %t1571, i8* %t1570, i8* %t1566
  store double 0.0, double* %l15
  %t1573 = load double, double* %l15
  store double 0.0, double* %l16
  %t1574 = extractvalue %Statement %statement, 0
  %t1575 = alloca %Statement
  store %Statement %statement, %Statement* %t1575
  %t1576 = getelementptr inbounds %Statement, %Statement* %t1575, i32 0, i32 1
  %t1577 = bitcast [24 x i8]* %t1576 to i8*
  %t1578 = bitcast i8* %t1577 to i8**
  %t1579 = load i8*, i8** %t1578
  %t1580 = icmp eq i32 %t1574, 4
  %t1581 = select i1 %t1580, i8* %t1579, i8* null
  %t1582 = getelementptr inbounds %Statement, %Statement* %t1575, i32 0, i32 1
  %t1583 = bitcast [24 x i8]* %t1582 to i8*
  %t1584 = bitcast i8* %t1583 to i8**
  %t1585 = load i8*, i8** %t1584
  %t1586 = icmp eq i32 %t1574, 5
  %t1587 = select i1 %t1586, i8* %t1585, i8* %t1581
  %t1588 = getelementptr inbounds %Statement, %Statement* %t1575, i32 0, i32 1
  %t1589 = bitcast [24 x i8]* %t1588 to i8*
  %t1590 = bitcast i8* %t1589 to i8**
  %t1591 = load i8*, i8** %t1590
  %t1592 = icmp eq i32 %t1574, 7
  %t1593 = select i1 %t1592, i8* %t1591, i8* %t1587
  %t1594 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature zeroinitializer)
  %t1595 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t1594)
  store double %t1595, double* %l16
  %t1596 = extractvalue %Statement %statement, 0
  %t1597 = alloca %Statement
  store %Statement %statement, %Statement* %t1597
  %t1598 = getelementptr inbounds %Statement, %Statement* %t1597, i32 0, i32 1
  %t1599 = bitcast [24 x i8]* %t1598 to i8*
  %t1600 = bitcast i8* %t1599 to i8**
  %t1601 = load i8*, i8** %t1600
  %t1602 = icmp eq i32 %t1596, 4
  %t1603 = select i1 %t1602, i8* %t1601, i8* null
  %t1604 = getelementptr inbounds %Statement, %Statement* %t1597, i32 0, i32 1
  %t1605 = bitcast [24 x i8]* %t1604 to i8*
  %t1606 = bitcast i8* %t1605 to i8**
  %t1607 = load i8*, i8** %t1606
  %t1608 = icmp eq i32 %t1596, 5
  %t1609 = select i1 %t1608, i8* %t1607, i8* %t1603
  %t1610 = getelementptr inbounds %Statement, %Statement* %t1597, i32 0, i32 1
  %t1611 = bitcast [24 x i8]* %t1610 to i8*
  %t1612 = bitcast i8* %t1611 to i8**
  %t1613 = load i8*, i8** %t1612
  %t1614 = icmp eq i32 %t1596, 7
  %t1615 = select i1 %t1614, i8* %t1613, i8* %t1609
  %t1616 = extractvalue %Statement %statement, 0
  %t1617 = alloca %Statement
  store %Statement %statement, %Statement* %t1617
  %t1618 = getelementptr inbounds %Statement, %Statement* %t1617, i32 0, i32 1
  %t1619 = bitcast [24 x i8]* %t1618 to i8*
  %t1620 = getelementptr inbounds i8, i8* %t1619, i64 8
  %t1621 = bitcast i8* %t1620 to i8**
  %t1622 = load i8*, i8** %t1621
  %t1623 = icmp eq i32 %t1616, 4
  %t1624 = select i1 %t1623, i8* %t1622, i8* null
  %t1625 = getelementptr inbounds %Statement, %Statement* %t1617, i32 0, i32 1
  %t1626 = bitcast [24 x i8]* %t1625 to i8*
  %t1627 = getelementptr inbounds i8, i8* %t1626, i64 8
  %t1628 = bitcast i8* %t1627 to i8**
  %t1629 = load i8*, i8** %t1628
  %t1630 = icmp eq i32 %t1616, 5
  %t1631 = select i1 %t1630, i8* %t1629, i8* %t1624
  %t1632 = getelementptr inbounds %Statement, %Statement* %t1617, i32 0, i32 1
  %t1633 = bitcast [40 x i8]* %t1632 to i8*
  %t1634 = getelementptr inbounds i8, i8* %t1633, i64 16
  %t1635 = bitcast i8* %t1634 to i8**
  %t1636 = load i8*, i8** %t1635
  %t1637 = icmp eq i32 %t1616, 6
  %t1638 = select i1 %t1637, i8* %t1636, i8* %t1631
  %t1639 = getelementptr inbounds %Statement, %Statement* %t1617, i32 0, i32 1
  %t1640 = bitcast [24 x i8]* %t1639 to i8*
  %t1641 = getelementptr inbounds i8, i8* %t1640, i64 8
  %t1642 = bitcast i8* %t1641 to i8**
  %t1643 = load i8*, i8** %t1642
  %t1644 = icmp eq i32 %t1616, 7
  %t1645 = select i1 %t1644, i8* %t1643, i8* %t1638
  %t1646 = getelementptr inbounds %Statement, %Statement* %t1617, i32 0, i32 1
  %t1647 = bitcast [40 x i8]* %t1646 to i8*
  %t1648 = getelementptr inbounds i8, i8* %t1647, i64 24
  %t1649 = bitcast i8* %t1648 to i8**
  %t1650 = load i8*, i8** %t1649
  %t1651 = icmp eq i32 %t1616, 12
  %t1652 = select i1 %t1651, i8* %t1650, i8* %t1645
  %t1653 = getelementptr inbounds %Statement, %Statement* %t1617, i32 0, i32 1
  %t1654 = bitcast [24 x i8]* %t1653 to i8*
  %t1655 = getelementptr inbounds i8, i8* %t1654, i64 8
  %t1656 = bitcast i8* %t1655 to i8**
  %t1657 = load i8*, i8** %t1656
  %t1658 = icmp eq i32 %t1616, 13
  %t1659 = select i1 %t1658, i8* %t1657, i8* %t1652
  %t1660 = getelementptr inbounds %Statement, %Statement* %t1617, i32 0, i32 1
  %t1661 = bitcast [24 x i8]* %t1660 to i8*
  %t1662 = getelementptr inbounds i8, i8* %t1661, i64 8
  %t1663 = bitcast i8* %t1662 to i8**
  %t1664 = load i8*, i8** %t1663
  %t1665 = icmp eq i32 %t1616, 14
  %t1666 = select i1 %t1665, i8* %t1664, i8* %t1659
  %t1667 = getelementptr inbounds %Statement, %Statement* %t1617, i32 0, i32 1
  %t1668 = bitcast [16 x i8]* %t1667 to i8*
  %t1669 = bitcast i8* %t1668 to i8**
  %t1670 = load i8*, i8** %t1669
  %t1671 = icmp eq i32 %t1616, 15
  %t1672 = select i1 %t1671, i8* %t1670, i8* %t1666
  %t1673 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature zeroinitializer, %Block zeroinitializer, { %Statement*, i64 }* %interfaces)
  %t1674 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t1673)
  store double %t1674, double* %l16
  %t1675 = load double, double* %l15
  %t1676 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t1677 = load double, double* %l16
  %t1678 = insertvalue %ScopeResult %t1676, { i8**, i64 }* null, 1
  ret %ScopeResult %t1678
merge21:
  %t1679 = extractvalue %Statement %statement, 0
  %t1680 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1681 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1682 = icmp eq i32 %t1679, 0
  %t1683 = select i1 %t1682, i8* %t1681, i8* %t1680
  %t1684 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1685 = icmp eq i32 %t1679, 1
  %t1686 = select i1 %t1685, i8* %t1684, i8* %t1683
  %t1687 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1688 = icmp eq i32 %t1679, 2
  %t1689 = select i1 %t1688, i8* %t1687, i8* %t1686
  %t1690 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1691 = icmp eq i32 %t1679, 3
  %t1692 = select i1 %t1691, i8* %t1690, i8* %t1689
  %t1693 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1694 = icmp eq i32 %t1679, 4
  %t1695 = select i1 %t1694, i8* %t1693, i8* %t1692
  %t1696 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1697 = icmp eq i32 %t1679, 5
  %t1698 = select i1 %t1697, i8* %t1696, i8* %t1695
  %t1699 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1700 = icmp eq i32 %t1679, 6
  %t1701 = select i1 %t1700, i8* %t1699, i8* %t1698
  %t1702 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1703 = icmp eq i32 %t1679, 7
  %t1704 = select i1 %t1703, i8* %t1702, i8* %t1701
  %t1705 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1706 = icmp eq i32 %t1679, 8
  %t1707 = select i1 %t1706, i8* %t1705, i8* %t1704
  %t1708 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1709 = icmp eq i32 %t1679, 9
  %t1710 = select i1 %t1709, i8* %t1708, i8* %t1707
  %t1711 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1712 = icmp eq i32 %t1679, 10
  %t1713 = select i1 %t1712, i8* %t1711, i8* %t1710
  %t1714 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1715 = icmp eq i32 %t1679, 11
  %t1716 = select i1 %t1715, i8* %t1714, i8* %t1713
  %t1717 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1718 = icmp eq i32 %t1679, 12
  %t1719 = select i1 %t1718, i8* %t1717, i8* %t1716
  %t1720 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1721 = icmp eq i32 %t1679, 13
  %t1722 = select i1 %t1721, i8* %t1720, i8* %t1719
  %t1723 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1724 = icmp eq i32 %t1679, 14
  %t1725 = select i1 %t1724, i8* %t1723, i8* %t1722
  %t1726 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1727 = icmp eq i32 %t1679, 15
  %t1728 = select i1 %t1727, i8* %t1726, i8* %t1725
  %t1729 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1730 = icmp eq i32 %t1679, 16
  %t1731 = select i1 %t1730, i8* %t1729, i8* %t1728
  %t1732 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1733 = icmp eq i32 %t1679, 17
  %t1734 = select i1 %t1733, i8* %t1732, i8* %t1731
  %t1735 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1736 = icmp eq i32 %t1679, 18
  %t1737 = select i1 %t1736, i8* %t1735, i8* %t1734
  %t1738 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1739 = icmp eq i32 %t1679, 19
  %t1740 = select i1 %t1739, i8* %t1738, i8* %t1737
  %t1741 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1742 = icmp eq i32 %t1679, 20
  %t1743 = select i1 %t1742, i8* %t1741, i8* %t1740
  %t1744 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1745 = icmp eq i32 %t1679, 21
  %t1746 = select i1 %t1745, i8* %t1744, i8* %t1743
  %t1747 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1748 = icmp eq i32 %t1679, 22
  %t1749 = select i1 %t1748, i8* %t1747, i8* %t1746
  %s1750 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1750, i32 0, i32 0
  %t1751 = icmp eq i8* %t1749, %s1750
  br i1 %t1751, label %then22, label %merge23
then22:
  %t1752 = extractvalue %Statement %statement, 0
  %t1753 = alloca %Statement
  store %Statement %statement, %Statement* %t1753
  %t1754 = getelementptr inbounds %Statement, %Statement* %t1753, i32 0, i32 1
  %t1755 = bitcast [48 x i8]* %t1754 to i8*
  %t1756 = bitcast i8* %t1755 to i8**
  %t1757 = load i8*, i8** %t1756
  %t1758 = icmp eq i32 %t1752, 2
  %t1759 = select i1 %t1758, i8* %t1757, i8* null
  %t1760 = getelementptr inbounds %Statement, %Statement* %t1753, i32 0, i32 1
  %t1761 = bitcast [48 x i8]* %t1760 to i8*
  %t1762 = bitcast i8* %t1761 to i8**
  %t1763 = load i8*, i8** %t1762
  %t1764 = icmp eq i32 %t1752, 3
  %t1765 = select i1 %t1764, i8* %t1763, i8* %t1759
  %t1766 = getelementptr inbounds %Statement, %Statement* %t1753, i32 0, i32 1
  %t1767 = bitcast [40 x i8]* %t1766 to i8*
  %t1768 = bitcast i8* %t1767 to i8**
  %t1769 = load i8*, i8** %t1768
  %t1770 = icmp eq i32 %t1752, 6
  %t1771 = select i1 %t1770, i8* %t1769, i8* %t1765
  %t1772 = getelementptr inbounds %Statement, %Statement* %t1753, i32 0, i32 1
  %t1773 = bitcast [56 x i8]* %t1772 to i8*
  %t1774 = bitcast i8* %t1773 to i8**
  %t1775 = load i8*, i8** %t1774
  %t1776 = icmp eq i32 %t1752, 8
  %t1777 = select i1 %t1776, i8* %t1775, i8* %t1771
  %t1778 = getelementptr inbounds %Statement, %Statement* %t1753, i32 0, i32 1
  %t1779 = bitcast [40 x i8]* %t1778 to i8*
  %t1780 = bitcast i8* %t1779 to i8**
  %t1781 = load i8*, i8** %t1780
  %t1782 = icmp eq i32 %t1752, 9
  %t1783 = select i1 %t1782, i8* %t1781, i8* %t1777
  %t1784 = getelementptr inbounds %Statement, %Statement* %t1753, i32 0, i32 1
  %t1785 = bitcast [40 x i8]* %t1784 to i8*
  %t1786 = bitcast i8* %t1785 to i8**
  %t1787 = load i8*, i8** %t1786
  %t1788 = icmp eq i32 %t1752, 10
  %t1789 = select i1 %t1788, i8* %t1787, i8* %t1783
  %t1790 = getelementptr inbounds %Statement, %Statement* %t1753, i32 0, i32 1
  %t1791 = bitcast [40 x i8]* %t1790 to i8*
  %t1792 = bitcast i8* %t1791 to i8**
  %t1793 = load i8*, i8** %t1792
  %t1794 = icmp eq i32 %t1752, 11
  %t1795 = select i1 %t1794, i8* %t1793, i8* %t1789
  %s1796 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1796, i32 0, i32 0
  %t1797 = extractvalue %Statement %statement, 0
  %t1798 = alloca %Statement
  store %Statement %statement, %Statement* %t1798
  %t1799 = getelementptr inbounds %Statement, %Statement* %t1798, i32 0, i32 1
  %t1800 = bitcast [48 x i8]* %t1799 to i8*
  %t1801 = getelementptr inbounds i8, i8* %t1800, i64 8
  %t1802 = bitcast i8* %t1801 to i8**
  %t1803 = load i8*, i8** %t1802
  %t1804 = icmp eq i32 %t1797, 3
  %t1805 = select i1 %t1804, i8* %t1803, i8* null
  %t1806 = getelementptr inbounds %Statement, %Statement* %t1798, i32 0, i32 1
  %t1807 = bitcast [40 x i8]* %t1806 to i8*
  %t1808 = getelementptr inbounds i8, i8* %t1807, i64 8
  %t1809 = bitcast i8* %t1808 to i8**
  %t1810 = load i8*, i8** %t1809
  %t1811 = icmp eq i32 %t1797, 6
  %t1812 = select i1 %t1811, i8* %t1810, i8* %t1805
  %t1813 = getelementptr inbounds %Statement, %Statement* %t1798, i32 0, i32 1
  %t1814 = bitcast [56 x i8]* %t1813 to i8*
  %t1815 = getelementptr inbounds i8, i8* %t1814, i64 8
  %t1816 = bitcast i8* %t1815 to i8**
  %t1817 = load i8*, i8** %t1816
  %t1818 = icmp eq i32 %t1797, 8
  %t1819 = select i1 %t1818, i8* %t1817, i8* %t1812
  %t1820 = getelementptr inbounds %Statement, %Statement* %t1798, i32 0, i32 1
  %t1821 = bitcast [40 x i8]* %t1820 to i8*
  %t1822 = getelementptr inbounds i8, i8* %t1821, i64 8
  %t1823 = bitcast i8* %t1822 to i8**
  %t1824 = load i8*, i8** %t1823
  %t1825 = icmp eq i32 %t1797, 9
  %t1826 = select i1 %t1825, i8* %t1824, i8* %t1819
  %t1827 = getelementptr inbounds %Statement, %Statement* %t1798, i32 0, i32 1
  %t1828 = bitcast [40 x i8]* %t1827 to i8*
  %t1829 = getelementptr inbounds i8, i8* %t1828, i64 8
  %t1830 = bitcast i8* %t1829 to i8**
  %t1831 = load i8*, i8** %t1830
  %t1832 = icmp eq i32 %t1797, 10
  %t1833 = select i1 %t1832, i8* %t1831, i8* %t1826
  %t1834 = getelementptr inbounds %Statement, %Statement* %t1798, i32 0, i32 1
  %t1835 = bitcast [40 x i8]* %t1834 to i8*
  %t1836 = getelementptr inbounds i8, i8* %t1835, i64 8
  %t1837 = bitcast i8* %t1836 to i8**
  %t1838 = load i8*, i8** %t1837
  %t1839 = icmp eq i32 %t1797, 11
  %t1840 = select i1 %t1839, i8* %t1838, i8* %t1833
  %t1841 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1795, i8* %s1796, i8* %t1840)
  store %ScopeResult %t1841, %ScopeResult* %l17
  %t1842 = extractvalue %Statement %statement, 0
  %t1843 = alloca %Statement
  store %Statement %statement, %Statement* %t1843
  %t1844 = getelementptr inbounds %Statement, %Statement* %t1843, i32 0, i32 1
  %t1845 = bitcast [24 x i8]* %t1844 to i8*
  %t1846 = getelementptr inbounds i8, i8* %t1845, i64 8
  %t1847 = bitcast i8* %t1846 to i8**
  %t1848 = load i8*, i8** %t1847
  %t1849 = icmp eq i32 %t1842, 4
  %t1850 = select i1 %t1849, i8* %t1848, i8* null
  %t1851 = getelementptr inbounds %Statement, %Statement* %t1843, i32 0, i32 1
  %t1852 = bitcast [24 x i8]* %t1851 to i8*
  %t1853 = getelementptr inbounds i8, i8* %t1852, i64 8
  %t1854 = bitcast i8* %t1853 to i8**
  %t1855 = load i8*, i8** %t1854
  %t1856 = icmp eq i32 %t1842, 5
  %t1857 = select i1 %t1856, i8* %t1855, i8* %t1850
  %t1858 = getelementptr inbounds %Statement, %Statement* %t1843, i32 0, i32 1
  %t1859 = bitcast [40 x i8]* %t1858 to i8*
  %t1860 = getelementptr inbounds i8, i8* %t1859, i64 16
  %t1861 = bitcast i8* %t1860 to i8**
  %t1862 = load i8*, i8** %t1861
  %t1863 = icmp eq i32 %t1842, 6
  %t1864 = select i1 %t1863, i8* %t1862, i8* %t1857
  %t1865 = getelementptr inbounds %Statement, %Statement* %t1843, i32 0, i32 1
  %t1866 = bitcast [24 x i8]* %t1865 to i8*
  %t1867 = getelementptr inbounds i8, i8* %t1866, i64 8
  %t1868 = bitcast i8* %t1867 to i8**
  %t1869 = load i8*, i8** %t1868
  %t1870 = icmp eq i32 %t1842, 7
  %t1871 = select i1 %t1870, i8* %t1869, i8* %t1864
  %t1872 = getelementptr inbounds %Statement, %Statement* %t1843, i32 0, i32 1
  %t1873 = bitcast [40 x i8]* %t1872 to i8*
  %t1874 = getelementptr inbounds i8, i8* %t1873, i64 24
  %t1875 = bitcast i8* %t1874 to i8**
  %t1876 = load i8*, i8** %t1875
  %t1877 = icmp eq i32 %t1842, 12
  %t1878 = select i1 %t1877, i8* %t1876, i8* %t1871
  %t1879 = getelementptr inbounds %Statement, %Statement* %t1843, i32 0, i32 1
  %t1880 = bitcast [24 x i8]* %t1879 to i8*
  %t1881 = getelementptr inbounds i8, i8* %t1880, i64 8
  %t1882 = bitcast i8* %t1881 to i8**
  %t1883 = load i8*, i8** %t1882
  %t1884 = icmp eq i32 %t1842, 13
  %t1885 = select i1 %t1884, i8* %t1883, i8* %t1878
  %t1886 = getelementptr inbounds %Statement, %Statement* %t1843, i32 0, i32 1
  %t1887 = bitcast [24 x i8]* %t1886 to i8*
  %t1888 = getelementptr inbounds i8, i8* %t1887, i64 8
  %t1889 = bitcast i8* %t1888 to i8**
  %t1890 = load i8*, i8** %t1889
  %t1891 = icmp eq i32 %t1842, 14
  %t1892 = select i1 %t1891, i8* %t1890, i8* %t1885
  %t1893 = getelementptr inbounds %Statement, %Statement* %t1843, i32 0, i32 1
  %t1894 = bitcast [16 x i8]* %t1893 to i8*
  %t1895 = bitcast i8* %t1894 to i8**
  %t1896 = load i8*, i8** %t1895
  %t1897 = icmp eq i32 %t1842, 15
  %t1898 = select i1 %t1897, i8* %t1896, i8* %t1892
  %t1899 = alloca [0 x double]
  %t1900 = getelementptr [0 x double], [0 x double]* %t1899, i32 0, i32 0
  %t1901 = alloca { double*, i64 }
  %t1902 = getelementptr { double*, i64 }, { double*, i64 }* %t1901, i32 0, i32 0
  store double* %t1900, double** %t1902
  %t1903 = getelementptr { double*, i64 }, { double*, i64 }* %t1901, i32 0, i32 1
  store i64 0, i64* %t1903
  %t1904 = call { %Diagnostic*, i64 }* @check_block(%Block zeroinitializer, { %SymbolEntry*, i64 }* null, { %Statement*, i64 }* %interfaces)
  %t1905 = call double @registrationdiagnosticsconcat({ %Diagnostic*, i64 }* %t1904)
  store double %t1905, double* %l18
  %t1906 = load %ScopeResult, %ScopeResult* %l17
  %t1907 = extractvalue %ScopeResult %t1906, 0
  %t1908 = insertvalue %ScopeResult undef, { i8**, i64 }* %t1907, 0
  %t1909 = load double, double* %l18
  %t1910 = insertvalue %ScopeResult %t1908, { i8**, i64 }* null, 1
  ret %ScopeResult %t1910
merge23:
  %t1911 = extractvalue %Statement %statement, 0
  %t1912 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1913 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1914 = icmp eq i32 %t1911, 0
  %t1915 = select i1 %t1914, i8* %t1913, i8* %t1912
  %t1916 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1917 = icmp eq i32 %t1911, 1
  %t1918 = select i1 %t1917, i8* %t1916, i8* %t1915
  %t1919 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1920 = icmp eq i32 %t1911, 2
  %t1921 = select i1 %t1920, i8* %t1919, i8* %t1918
  %t1922 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1923 = icmp eq i32 %t1911, 3
  %t1924 = select i1 %t1923, i8* %t1922, i8* %t1921
  %t1925 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1926 = icmp eq i32 %t1911, 4
  %t1927 = select i1 %t1926, i8* %t1925, i8* %t1924
  %t1928 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1929 = icmp eq i32 %t1911, 5
  %t1930 = select i1 %t1929, i8* %t1928, i8* %t1927
  %t1931 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1932 = icmp eq i32 %t1911, 6
  %t1933 = select i1 %t1932, i8* %t1931, i8* %t1930
  %t1934 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1935 = icmp eq i32 %t1911, 7
  %t1936 = select i1 %t1935, i8* %t1934, i8* %t1933
  %t1937 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1938 = icmp eq i32 %t1911, 8
  %t1939 = select i1 %t1938, i8* %t1937, i8* %t1936
  %t1940 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1941 = icmp eq i32 %t1911, 9
  %t1942 = select i1 %t1941, i8* %t1940, i8* %t1939
  %t1943 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1944 = icmp eq i32 %t1911, 10
  %t1945 = select i1 %t1944, i8* %t1943, i8* %t1942
  %t1946 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1947 = icmp eq i32 %t1911, 11
  %t1948 = select i1 %t1947, i8* %t1946, i8* %t1945
  %t1949 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1950 = icmp eq i32 %t1911, 12
  %t1951 = select i1 %t1950, i8* %t1949, i8* %t1948
  %t1952 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1953 = icmp eq i32 %t1911, 13
  %t1954 = select i1 %t1953, i8* %t1952, i8* %t1951
  %t1955 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1956 = icmp eq i32 %t1911, 14
  %t1957 = select i1 %t1956, i8* %t1955, i8* %t1954
  %t1958 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1959 = icmp eq i32 %t1911, 15
  %t1960 = select i1 %t1959, i8* %t1958, i8* %t1957
  %t1961 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1962 = icmp eq i32 %t1911, 16
  %t1963 = select i1 %t1962, i8* %t1961, i8* %t1960
  %t1964 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1965 = icmp eq i32 %t1911, 17
  %t1966 = select i1 %t1965, i8* %t1964, i8* %t1963
  %t1967 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1968 = icmp eq i32 %t1911, 18
  %t1969 = select i1 %t1968, i8* %t1967, i8* %t1966
  %t1970 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1971 = icmp eq i32 %t1911, 19
  %t1972 = select i1 %t1971, i8* %t1970, i8* %t1969
  %t1973 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1974 = icmp eq i32 %t1911, 20
  %t1975 = select i1 %t1974, i8* %t1973, i8* %t1972
  %t1976 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1977 = icmp eq i32 %t1911, 21
  %t1978 = select i1 %t1977, i8* %t1976, i8* %t1975
  %t1979 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1980 = icmp eq i32 %t1911, 22
  %t1981 = select i1 %t1980, i8* %t1979, i8* %t1978
  %s1982 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.1982, i32 0, i32 0
  %t1983 = icmp eq i8* %t1981, %s1982
  br i1 %t1983, label %then24, label %merge25
then24:
  %t1984 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t1985 = extractvalue %Statement %statement, 0
  %t1986 = alloca %Statement
  store %Statement %statement, %Statement* %t1986
  %t1987 = getelementptr inbounds %Statement, %Statement* %t1986, i32 0, i32 1
  %t1988 = bitcast [24 x i8]* %t1987 to i8*
  %t1989 = getelementptr inbounds i8, i8* %t1988, i64 8
  %t1990 = bitcast i8* %t1989 to i8**
  %t1991 = load i8*, i8** %t1990
  %t1992 = icmp eq i32 %t1985, 4
  %t1993 = select i1 %t1992, i8* %t1991, i8* null
  %t1994 = getelementptr inbounds %Statement, %Statement* %t1986, i32 0, i32 1
  %t1995 = bitcast [24 x i8]* %t1994 to i8*
  %t1996 = getelementptr inbounds i8, i8* %t1995, i64 8
  %t1997 = bitcast i8* %t1996 to i8**
  %t1998 = load i8*, i8** %t1997
  %t1999 = icmp eq i32 %t1985, 5
  %t2000 = select i1 %t1999, i8* %t1998, i8* %t1993
  %t2001 = getelementptr inbounds %Statement, %Statement* %t1986, i32 0, i32 1
  %t2002 = bitcast [40 x i8]* %t2001 to i8*
  %t2003 = getelementptr inbounds i8, i8* %t2002, i64 16
  %t2004 = bitcast i8* %t2003 to i8**
  %t2005 = load i8*, i8** %t2004
  %t2006 = icmp eq i32 %t1985, 6
  %t2007 = select i1 %t2006, i8* %t2005, i8* %t2000
  %t2008 = getelementptr inbounds %Statement, %Statement* %t1986, i32 0, i32 1
  %t2009 = bitcast [24 x i8]* %t2008 to i8*
  %t2010 = getelementptr inbounds i8, i8* %t2009, i64 8
  %t2011 = bitcast i8* %t2010 to i8**
  %t2012 = load i8*, i8** %t2011
  %t2013 = icmp eq i32 %t1985, 7
  %t2014 = select i1 %t2013, i8* %t2012, i8* %t2007
  %t2015 = getelementptr inbounds %Statement, %Statement* %t1986, i32 0, i32 1
  %t2016 = bitcast [40 x i8]* %t2015 to i8*
  %t2017 = getelementptr inbounds i8, i8* %t2016, i64 24
  %t2018 = bitcast i8* %t2017 to i8**
  %t2019 = load i8*, i8** %t2018
  %t2020 = icmp eq i32 %t1985, 12
  %t2021 = select i1 %t2020, i8* %t2019, i8* %t2014
  %t2022 = getelementptr inbounds %Statement, %Statement* %t1986, i32 0, i32 1
  %t2023 = bitcast [24 x i8]* %t2022 to i8*
  %t2024 = getelementptr inbounds i8, i8* %t2023, i64 8
  %t2025 = bitcast i8* %t2024 to i8**
  %t2026 = load i8*, i8** %t2025
  %t2027 = icmp eq i32 %t1985, 13
  %t2028 = select i1 %t2027, i8* %t2026, i8* %t2021
  %t2029 = getelementptr inbounds %Statement, %Statement* %t1986, i32 0, i32 1
  %t2030 = bitcast [24 x i8]* %t2029 to i8*
  %t2031 = getelementptr inbounds i8, i8* %t2030, i64 8
  %t2032 = bitcast i8* %t2031 to i8**
  %t2033 = load i8*, i8** %t2032
  %t2034 = icmp eq i32 %t1985, 14
  %t2035 = select i1 %t2034, i8* %t2033, i8* %t2028
  %t2036 = getelementptr inbounds %Statement, %Statement* %t1986, i32 0, i32 1
  %t2037 = bitcast [16 x i8]* %t2036 to i8*
  %t2038 = bitcast i8* %t2037 to i8**
  %t2039 = load i8*, i8** %t2038
  %t2040 = icmp eq i32 %t1985, 15
  %t2041 = select i1 %t2040, i8* %t2039, i8* %t2035
  %t2042 = call { %Diagnostic*, i64 }* @check_block(%Block zeroinitializer, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2043 = insertvalue %ScopeResult %t1984, { i8**, i64 }* null, 1
  ret %ScopeResult %t2043
merge25:
  %t2044 = extractvalue %Statement %statement, 0
  %t2045 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2046 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2047 = icmp eq i32 %t2044, 0
  %t2048 = select i1 %t2047, i8* %t2046, i8* %t2045
  %t2049 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2050 = icmp eq i32 %t2044, 1
  %t2051 = select i1 %t2050, i8* %t2049, i8* %t2048
  %t2052 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2053 = icmp eq i32 %t2044, 2
  %t2054 = select i1 %t2053, i8* %t2052, i8* %t2051
  %t2055 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2056 = icmp eq i32 %t2044, 3
  %t2057 = select i1 %t2056, i8* %t2055, i8* %t2054
  %t2058 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2059 = icmp eq i32 %t2044, 4
  %t2060 = select i1 %t2059, i8* %t2058, i8* %t2057
  %t2061 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2062 = icmp eq i32 %t2044, 5
  %t2063 = select i1 %t2062, i8* %t2061, i8* %t2060
  %t2064 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2065 = icmp eq i32 %t2044, 6
  %t2066 = select i1 %t2065, i8* %t2064, i8* %t2063
  %t2067 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2068 = icmp eq i32 %t2044, 7
  %t2069 = select i1 %t2068, i8* %t2067, i8* %t2066
  %t2070 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2071 = icmp eq i32 %t2044, 8
  %t2072 = select i1 %t2071, i8* %t2070, i8* %t2069
  %t2073 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2074 = icmp eq i32 %t2044, 9
  %t2075 = select i1 %t2074, i8* %t2073, i8* %t2072
  %t2076 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2077 = icmp eq i32 %t2044, 10
  %t2078 = select i1 %t2077, i8* %t2076, i8* %t2075
  %t2079 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2080 = icmp eq i32 %t2044, 11
  %t2081 = select i1 %t2080, i8* %t2079, i8* %t2078
  %t2082 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2083 = icmp eq i32 %t2044, 12
  %t2084 = select i1 %t2083, i8* %t2082, i8* %t2081
  %t2085 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2086 = icmp eq i32 %t2044, 13
  %t2087 = select i1 %t2086, i8* %t2085, i8* %t2084
  %t2088 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2089 = icmp eq i32 %t2044, 14
  %t2090 = select i1 %t2089, i8* %t2088, i8* %t2087
  %t2091 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2092 = icmp eq i32 %t2044, 15
  %t2093 = select i1 %t2092, i8* %t2091, i8* %t2090
  %t2094 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2095 = icmp eq i32 %t2044, 16
  %t2096 = select i1 %t2095, i8* %t2094, i8* %t2093
  %t2097 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2098 = icmp eq i32 %t2044, 17
  %t2099 = select i1 %t2098, i8* %t2097, i8* %t2096
  %t2100 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2101 = icmp eq i32 %t2044, 18
  %t2102 = select i1 %t2101, i8* %t2100, i8* %t2099
  %t2103 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2104 = icmp eq i32 %t2044, 19
  %t2105 = select i1 %t2104, i8* %t2103, i8* %t2102
  %t2106 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2107 = icmp eq i32 %t2044, 20
  %t2108 = select i1 %t2107, i8* %t2106, i8* %t2105
  %t2109 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2110 = icmp eq i32 %t2044, 21
  %t2111 = select i1 %t2110, i8* %t2109, i8* %t2108
  %t2112 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2113 = icmp eq i32 %t2044, 22
  %t2114 = select i1 %t2113, i8* %t2112, i8* %t2111
  %s2115 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.2115, i32 0, i32 0
  %t2116 = icmp eq i8* %t2114, %s2115
  br i1 %t2116, label %then26, label %merge27
then26:
  %t2117 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t2118 = extractvalue %Statement %statement, 0
  %t2119 = alloca %Statement
  store %Statement %statement, %Statement* %t2119
  %t2120 = getelementptr inbounds %Statement, %Statement* %t2119, i32 0, i32 1
  %t2121 = bitcast [24 x i8]* %t2120 to i8*
  %t2122 = getelementptr inbounds i8, i8* %t2121, i64 8
  %t2123 = bitcast i8* %t2122 to i8**
  %t2124 = load i8*, i8** %t2123
  %t2125 = icmp eq i32 %t2118, 4
  %t2126 = select i1 %t2125, i8* %t2124, i8* null
  %t2127 = getelementptr inbounds %Statement, %Statement* %t2119, i32 0, i32 1
  %t2128 = bitcast [24 x i8]* %t2127 to i8*
  %t2129 = getelementptr inbounds i8, i8* %t2128, i64 8
  %t2130 = bitcast i8* %t2129 to i8**
  %t2131 = load i8*, i8** %t2130
  %t2132 = icmp eq i32 %t2118, 5
  %t2133 = select i1 %t2132, i8* %t2131, i8* %t2126
  %t2134 = getelementptr inbounds %Statement, %Statement* %t2119, i32 0, i32 1
  %t2135 = bitcast [40 x i8]* %t2134 to i8*
  %t2136 = getelementptr inbounds i8, i8* %t2135, i64 16
  %t2137 = bitcast i8* %t2136 to i8**
  %t2138 = load i8*, i8** %t2137
  %t2139 = icmp eq i32 %t2118, 6
  %t2140 = select i1 %t2139, i8* %t2138, i8* %t2133
  %t2141 = getelementptr inbounds %Statement, %Statement* %t2119, i32 0, i32 1
  %t2142 = bitcast [24 x i8]* %t2141 to i8*
  %t2143 = getelementptr inbounds i8, i8* %t2142, i64 8
  %t2144 = bitcast i8* %t2143 to i8**
  %t2145 = load i8*, i8** %t2144
  %t2146 = icmp eq i32 %t2118, 7
  %t2147 = select i1 %t2146, i8* %t2145, i8* %t2140
  %t2148 = getelementptr inbounds %Statement, %Statement* %t2119, i32 0, i32 1
  %t2149 = bitcast [40 x i8]* %t2148 to i8*
  %t2150 = getelementptr inbounds i8, i8* %t2149, i64 24
  %t2151 = bitcast i8* %t2150 to i8**
  %t2152 = load i8*, i8** %t2151
  %t2153 = icmp eq i32 %t2118, 12
  %t2154 = select i1 %t2153, i8* %t2152, i8* %t2147
  %t2155 = getelementptr inbounds %Statement, %Statement* %t2119, i32 0, i32 1
  %t2156 = bitcast [24 x i8]* %t2155 to i8*
  %t2157 = getelementptr inbounds i8, i8* %t2156, i64 8
  %t2158 = bitcast i8* %t2157 to i8**
  %t2159 = load i8*, i8** %t2158
  %t2160 = icmp eq i32 %t2118, 13
  %t2161 = select i1 %t2160, i8* %t2159, i8* %t2154
  %t2162 = getelementptr inbounds %Statement, %Statement* %t2119, i32 0, i32 1
  %t2163 = bitcast [24 x i8]* %t2162 to i8*
  %t2164 = getelementptr inbounds i8, i8* %t2163, i64 8
  %t2165 = bitcast i8* %t2164 to i8**
  %t2166 = load i8*, i8** %t2165
  %t2167 = icmp eq i32 %t2118, 14
  %t2168 = select i1 %t2167, i8* %t2166, i8* %t2161
  %t2169 = getelementptr inbounds %Statement, %Statement* %t2119, i32 0, i32 1
  %t2170 = bitcast [16 x i8]* %t2169 to i8*
  %t2171 = bitcast i8* %t2170 to i8**
  %t2172 = load i8*, i8** %t2171
  %t2173 = icmp eq i32 %t2118, 15
  %t2174 = select i1 %t2173, i8* %t2172, i8* %t2168
  %t2175 = call { %Diagnostic*, i64 }* @check_block(%Block zeroinitializer, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2176 = insertvalue %ScopeResult %t2117, { i8**, i64 }* null, 1
  ret %ScopeResult %t2176
merge27:
  %t2177 = extractvalue %Statement %statement, 0
  %t2178 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2179 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2180 = icmp eq i32 %t2177, 0
  %t2181 = select i1 %t2180, i8* %t2179, i8* %t2178
  %t2182 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2183 = icmp eq i32 %t2177, 1
  %t2184 = select i1 %t2183, i8* %t2182, i8* %t2181
  %t2185 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2186 = icmp eq i32 %t2177, 2
  %t2187 = select i1 %t2186, i8* %t2185, i8* %t2184
  %t2188 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2189 = icmp eq i32 %t2177, 3
  %t2190 = select i1 %t2189, i8* %t2188, i8* %t2187
  %t2191 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2192 = icmp eq i32 %t2177, 4
  %t2193 = select i1 %t2192, i8* %t2191, i8* %t2190
  %t2194 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2195 = icmp eq i32 %t2177, 5
  %t2196 = select i1 %t2195, i8* %t2194, i8* %t2193
  %t2197 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2198 = icmp eq i32 %t2177, 6
  %t2199 = select i1 %t2198, i8* %t2197, i8* %t2196
  %t2200 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2201 = icmp eq i32 %t2177, 7
  %t2202 = select i1 %t2201, i8* %t2200, i8* %t2199
  %t2203 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2204 = icmp eq i32 %t2177, 8
  %t2205 = select i1 %t2204, i8* %t2203, i8* %t2202
  %t2206 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2207 = icmp eq i32 %t2177, 9
  %t2208 = select i1 %t2207, i8* %t2206, i8* %t2205
  %t2209 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2210 = icmp eq i32 %t2177, 10
  %t2211 = select i1 %t2210, i8* %t2209, i8* %t2208
  %t2212 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2213 = icmp eq i32 %t2177, 11
  %t2214 = select i1 %t2213, i8* %t2212, i8* %t2211
  %t2215 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2216 = icmp eq i32 %t2177, 12
  %t2217 = select i1 %t2216, i8* %t2215, i8* %t2214
  %t2218 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2219 = icmp eq i32 %t2177, 13
  %t2220 = select i1 %t2219, i8* %t2218, i8* %t2217
  %t2221 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2222 = icmp eq i32 %t2177, 14
  %t2223 = select i1 %t2222, i8* %t2221, i8* %t2220
  %t2224 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2225 = icmp eq i32 %t2177, 15
  %t2226 = select i1 %t2225, i8* %t2224, i8* %t2223
  %t2227 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2228 = icmp eq i32 %t2177, 16
  %t2229 = select i1 %t2228, i8* %t2227, i8* %t2226
  %t2230 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2231 = icmp eq i32 %t2177, 17
  %t2232 = select i1 %t2231, i8* %t2230, i8* %t2229
  %t2233 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2234 = icmp eq i32 %t2177, 18
  %t2235 = select i1 %t2234, i8* %t2233, i8* %t2232
  %t2236 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2237 = icmp eq i32 %t2177, 19
  %t2238 = select i1 %t2237, i8* %t2236, i8* %t2235
  %t2239 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2240 = icmp eq i32 %t2177, 20
  %t2241 = select i1 %t2240, i8* %t2239, i8* %t2238
  %t2242 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2243 = icmp eq i32 %t2177, 21
  %t2244 = select i1 %t2243, i8* %t2242, i8* %t2241
  %t2245 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2246 = icmp eq i32 %t2177, 22
  %t2247 = select i1 %t2246, i8* %t2245, i8* %t2244
  %s2248 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.2248, i32 0, i32 0
  %t2249 = icmp eq i8* %t2247, %s2248
  br i1 %t2249, label %then28, label %merge29
then28:
  %t2250 = alloca [0 x %Diagnostic]
  %t2251 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t2250, i32 0, i32 0
  %t2252 = alloca { %Diagnostic*, i64 }
  %t2253 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2252, i32 0, i32 0
  store %Diagnostic* %t2251, %Diagnostic** %t2253
  %t2254 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2252, i32 0, i32 1
  store i64 0, i64* %t2254
  store { %Diagnostic*, i64 }* %t2252, { %Diagnostic*, i64 }** %l19
  %t2255 = sitofp i64 0 to double
  store double %t2255, double* %l20
  %t2256 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2257 = load double, double* %l20
  br label %loop.header30
loop.header30:
  %t2296 = phi { %Diagnostic*, i64 }* [ %t2256, %then28 ], [ %t2294, %loop.latch32 ]
  %t2297 = phi double [ %t2257, %then28 ], [ %t2295, %loop.latch32 ]
  store { %Diagnostic*, i64 }* %t2296, { %Diagnostic*, i64 }** %l19
  store double %t2297, double* %l20
  br label %loop.body31
loop.body31:
  %t2258 = load double, double* %l20
  %t2259 = extractvalue %Statement %statement, 0
  %t2260 = alloca %Statement
  store %Statement %statement, %Statement* %t2260
  %t2261 = getelementptr inbounds %Statement, %Statement* %t2260, i32 0, i32 1
  %t2262 = bitcast [24 x i8]* %t2261 to i8*
  %t2263 = getelementptr inbounds i8, i8* %t2262, i64 8
  %t2264 = bitcast i8* %t2263 to { i8**, i64 }**
  %t2265 = load { i8**, i64 }*, { i8**, i64 }** %t2264
  %t2266 = icmp eq i32 %t2259, 18
  %t2267 = select i1 %t2266, { i8**, i64 }* %t2265, { i8**, i64 }* null
  %t2268 = load { i8**, i64 }, { i8**, i64 }* %t2267
  %t2269 = extractvalue { i8**, i64 } %t2268, 1
  %t2270 = sitofp i64 %t2269 to double
  %t2271 = fcmp oge double %t2258, %t2270
  %t2272 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2273 = load double, double* %l20
  br i1 %t2271, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t2274 = extractvalue %Statement %statement, 0
  %t2275 = alloca %Statement
  store %Statement %statement, %Statement* %t2275
  %t2276 = getelementptr inbounds %Statement, %Statement* %t2275, i32 0, i32 1
  %t2277 = bitcast [24 x i8]* %t2276 to i8*
  %t2278 = getelementptr inbounds i8, i8* %t2277, i64 8
  %t2279 = bitcast i8* %t2278 to { i8**, i64 }**
  %t2280 = load { i8**, i64 }*, { i8**, i64 }** %t2279
  %t2281 = icmp eq i32 %t2274, 18
  %t2282 = select i1 %t2281, { i8**, i64 }* %t2280, { i8**, i64 }* null
  %t2283 = load double, double* %l20
  %t2284 = load { i8**, i64 }, { i8**, i64 }* %t2282
  %t2285 = extractvalue { i8**, i64 } %t2284, 0
  %t2286 = extractvalue { i8**, i64 } %t2284, 1
  %t2287 = icmp uge i64 %t2283, %t2286
  ; bounds check: %t2287 (if true, out of bounds)
  %t2288 = getelementptr i8*, i8** %t2285, i64 %t2283
  %t2289 = load i8*, i8** %t2288
  store i8* %t2289, i8** %l21
  %t2290 = load i8*, i8** %l21
  %t2291 = load double, double* %l20
  %t2292 = sitofp i64 1 to double
  %t2293 = fadd double %t2291, %t2292
  store double %t2293, double* %l20
  br label %loop.latch32
loop.latch32:
  %t2294 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2295 = load double, double* %l20
  br label %loop.header30
afterloop33:
  %t2298 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t2299 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2300 = insertvalue %ScopeResult %t2298, { i8**, i64 }* null, 1
  ret %ScopeResult %t2300
merge29:
  %t2301 = extractvalue %Statement %statement, 0
  %t2302 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2303 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2304 = icmp eq i32 %t2301, 0
  %t2305 = select i1 %t2304, i8* %t2303, i8* %t2302
  %t2306 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2307 = icmp eq i32 %t2301, 1
  %t2308 = select i1 %t2307, i8* %t2306, i8* %t2305
  %t2309 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2310 = icmp eq i32 %t2301, 2
  %t2311 = select i1 %t2310, i8* %t2309, i8* %t2308
  %t2312 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2313 = icmp eq i32 %t2301, 3
  %t2314 = select i1 %t2313, i8* %t2312, i8* %t2311
  %t2315 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2316 = icmp eq i32 %t2301, 4
  %t2317 = select i1 %t2316, i8* %t2315, i8* %t2314
  %t2318 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2319 = icmp eq i32 %t2301, 5
  %t2320 = select i1 %t2319, i8* %t2318, i8* %t2317
  %t2321 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2322 = icmp eq i32 %t2301, 6
  %t2323 = select i1 %t2322, i8* %t2321, i8* %t2320
  %t2324 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2325 = icmp eq i32 %t2301, 7
  %t2326 = select i1 %t2325, i8* %t2324, i8* %t2323
  %t2327 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2328 = icmp eq i32 %t2301, 8
  %t2329 = select i1 %t2328, i8* %t2327, i8* %t2326
  %t2330 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2331 = icmp eq i32 %t2301, 9
  %t2332 = select i1 %t2331, i8* %t2330, i8* %t2329
  %t2333 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2334 = icmp eq i32 %t2301, 10
  %t2335 = select i1 %t2334, i8* %t2333, i8* %t2332
  %t2336 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2337 = icmp eq i32 %t2301, 11
  %t2338 = select i1 %t2337, i8* %t2336, i8* %t2335
  %t2339 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2340 = icmp eq i32 %t2301, 12
  %t2341 = select i1 %t2340, i8* %t2339, i8* %t2338
  %t2342 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2343 = icmp eq i32 %t2301, 13
  %t2344 = select i1 %t2343, i8* %t2342, i8* %t2341
  %t2345 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2346 = icmp eq i32 %t2301, 14
  %t2347 = select i1 %t2346, i8* %t2345, i8* %t2344
  %t2348 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2349 = icmp eq i32 %t2301, 15
  %t2350 = select i1 %t2349, i8* %t2348, i8* %t2347
  %t2351 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2352 = icmp eq i32 %t2301, 16
  %t2353 = select i1 %t2352, i8* %t2351, i8* %t2350
  %t2354 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2355 = icmp eq i32 %t2301, 17
  %t2356 = select i1 %t2355, i8* %t2354, i8* %t2353
  %t2357 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2358 = icmp eq i32 %t2301, 18
  %t2359 = select i1 %t2358, i8* %t2357, i8* %t2356
  %t2360 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2361 = icmp eq i32 %t2301, 19
  %t2362 = select i1 %t2361, i8* %t2360, i8* %t2359
  %t2363 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2364 = icmp eq i32 %t2301, 20
  %t2365 = select i1 %t2364, i8* %t2363, i8* %t2362
  %t2366 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2367 = icmp eq i32 %t2301, 21
  %t2368 = select i1 %t2367, i8* %t2366, i8* %t2365
  %t2369 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2370 = icmp eq i32 %t2301, 22
  %t2371 = select i1 %t2370, i8* %t2369, i8* %t2368
  %s2372 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.2372, i32 0, i32 0
  %t2373 = icmp eq i8* %t2371, %s2372
  br i1 %t2373, label %then36, label %merge37
then36:
  %t2374 = extractvalue %Statement %statement, 0
  %t2375 = alloca %Statement
  store %Statement %statement, %Statement* %t2375
  %t2376 = getelementptr inbounds %Statement, %Statement* %t2375, i32 0, i32 1
  %t2377 = bitcast [32 x i8]* %t2376 to i8*
  %t2378 = getelementptr inbounds i8, i8* %t2377, i64 8
  %t2379 = bitcast i8* %t2378 to i8**
  %t2380 = load i8*, i8** %t2379
  %t2381 = icmp eq i32 %t2374, 19
  %t2382 = select i1 %t2381, i8* %t2380, i8* null
  %t2383 = call { %Diagnostic*, i64 }* @check_block(%Block zeroinitializer, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t2383, { %Diagnostic*, i64 }** %l22
  %t2384 = extractvalue %Statement %statement, 0
  %t2385 = alloca %Statement
  store %Statement %statement, %Statement* %t2385
  %t2386 = getelementptr inbounds %Statement, %Statement* %t2385, i32 0, i32 1
  %t2387 = bitcast [32 x i8]* %t2386 to i8*
  %t2388 = getelementptr inbounds i8, i8* %t2387, i64 16
  %t2389 = bitcast i8* %t2388 to i8**
  %t2390 = load i8*, i8** %t2389
  %t2391 = icmp eq i32 %t2384, 19
  %t2392 = select i1 %t2391, i8* %t2390, i8* null
  %t2393 = icmp ne i8* %t2392, null
  %t2394 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br i1 %t2393, label %then38, label %merge39
then38:
  %t2395 = extractvalue %Statement %statement, 0
  %t2396 = alloca %Statement
  store %Statement %statement, %Statement* %t2396
  %t2397 = getelementptr inbounds %Statement, %Statement* %t2396, i32 0, i32 1
  %t2398 = bitcast [32 x i8]* %t2397 to i8*
  %t2399 = getelementptr inbounds i8, i8* %t2398, i64 16
  %t2400 = bitcast i8* %t2399 to i8**
  %t2401 = load i8*, i8** %t2400
  %t2402 = icmp eq i32 %t2395, 19
  %t2403 = select i1 %t2402, i8* %t2401, i8* null
  store i8* %t2403, i8** %l23
  %t2404 = load i8*, i8** %l23
  %t2405 = load i8*, i8** %l23
  br label %merge39
merge39:
  %t2406 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t2407 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2408 = insertvalue %ScopeResult %t2406, { i8**, i64 }* null, 1
  ret %ScopeResult %t2408
merge37:
  %t2409 = extractvalue %Statement %statement, 0
  %t2410 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2411 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2412 = icmp eq i32 %t2409, 0
  %t2413 = select i1 %t2412, i8* %t2411, i8* %t2410
  %t2414 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2415 = icmp eq i32 %t2409, 1
  %t2416 = select i1 %t2415, i8* %t2414, i8* %t2413
  %t2417 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2418 = icmp eq i32 %t2409, 2
  %t2419 = select i1 %t2418, i8* %t2417, i8* %t2416
  %t2420 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2421 = icmp eq i32 %t2409, 3
  %t2422 = select i1 %t2421, i8* %t2420, i8* %t2419
  %t2423 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2424 = icmp eq i32 %t2409, 4
  %t2425 = select i1 %t2424, i8* %t2423, i8* %t2422
  %t2426 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2427 = icmp eq i32 %t2409, 5
  %t2428 = select i1 %t2427, i8* %t2426, i8* %t2425
  %t2429 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2430 = icmp eq i32 %t2409, 6
  %t2431 = select i1 %t2430, i8* %t2429, i8* %t2428
  %t2432 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2433 = icmp eq i32 %t2409, 7
  %t2434 = select i1 %t2433, i8* %t2432, i8* %t2431
  %t2435 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2436 = icmp eq i32 %t2409, 8
  %t2437 = select i1 %t2436, i8* %t2435, i8* %t2434
  %t2438 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2439 = icmp eq i32 %t2409, 9
  %t2440 = select i1 %t2439, i8* %t2438, i8* %t2437
  %t2441 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2442 = icmp eq i32 %t2409, 10
  %t2443 = select i1 %t2442, i8* %t2441, i8* %t2440
  %t2444 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2445 = icmp eq i32 %t2409, 11
  %t2446 = select i1 %t2445, i8* %t2444, i8* %t2443
  %t2447 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2448 = icmp eq i32 %t2409, 12
  %t2449 = select i1 %t2448, i8* %t2447, i8* %t2446
  %t2450 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2451 = icmp eq i32 %t2409, 13
  %t2452 = select i1 %t2451, i8* %t2450, i8* %t2449
  %t2453 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2454 = icmp eq i32 %t2409, 14
  %t2455 = select i1 %t2454, i8* %t2453, i8* %t2452
  %t2456 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2457 = icmp eq i32 %t2409, 15
  %t2458 = select i1 %t2457, i8* %t2456, i8* %t2455
  %t2459 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2460 = icmp eq i32 %t2409, 16
  %t2461 = select i1 %t2460, i8* %t2459, i8* %t2458
  %t2462 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2463 = icmp eq i32 %t2409, 17
  %t2464 = select i1 %t2463, i8* %t2462, i8* %t2461
  %t2465 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2466 = icmp eq i32 %t2409, 18
  %t2467 = select i1 %t2466, i8* %t2465, i8* %t2464
  %t2468 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2469 = icmp eq i32 %t2409, 19
  %t2470 = select i1 %t2469, i8* %t2468, i8* %t2467
  %t2471 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2472 = icmp eq i32 %t2409, 20
  %t2473 = select i1 %t2472, i8* %t2471, i8* %t2470
  %t2474 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2475 = icmp eq i32 %t2409, 21
  %t2476 = select i1 %t2475, i8* %t2474, i8* %t2473
  %t2477 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2478 = icmp eq i32 %t2409, 22
  %t2479 = select i1 %t2478, i8* %t2477, i8* %t2476
  %s2480 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.2480, i32 0, i32 0
  %t2481 = icmp eq i8* %t2479, %s2480
  br i1 %t2481, label %then40, label %merge41
then40:
  %t2482 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t2483 = extractvalue %Statement %statement, 0
  %t2484 = alloca %Statement
  store %Statement %statement, %Statement* %t2484
  %t2485 = getelementptr inbounds %Statement, %Statement* %t2484, i32 0, i32 1
  %t2486 = bitcast [24 x i8]* %t2485 to i8*
  %t2487 = getelementptr inbounds i8, i8* %t2486, i64 8
  %t2488 = bitcast i8* %t2487 to i8**
  %t2489 = load i8*, i8** %t2488
  %t2490 = icmp eq i32 %t2483, 4
  %t2491 = select i1 %t2490, i8* %t2489, i8* null
  %t2492 = getelementptr inbounds %Statement, %Statement* %t2484, i32 0, i32 1
  %t2493 = bitcast [24 x i8]* %t2492 to i8*
  %t2494 = getelementptr inbounds i8, i8* %t2493, i64 8
  %t2495 = bitcast i8* %t2494 to i8**
  %t2496 = load i8*, i8** %t2495
  %t2497 = icmp eq i32 %t2483, 5
  %t2498 = select i1 %t2497, i8* %t2496, i8* %t2491
  %t2499 = getelementptr inbounds %Statement, %Statement* %t2484, i32 0, i32 1
  %t2500 = bitcast [40 x i8]* %t2499 to i8*
  %t2501 = getelementptr inbounds i8, i8* %t2500, i64 16
  %t2502 = bitcast i8* %t2501 to i8**
  %t2503 = load i8*, i8** %t2502
  %t2504 = icmp eq i32 %t2483, 6
  %t2505 = select i1 %t2504, i8* %t2503, i8* %t2498
  %t2506 = getelementptr inbounds %Statement, %Statement* %t2484, i32 0, i32 1
  %t2507 = bitcast [24 x i8]* %t2506 to i8*
  %t2508 = getelementptr inbounds i8, i8* %t2507, i64 8
  %t2509 = bitcast i8* %t2508 to i8**
  %t2510 = load i8*, i8** %t2509
  %t2511 = icmp eq i32 %t2483, 7
  %t2512 = select i1 %t2511, i8* %t2510, i8* %t2505
  %t2513 = getelementptr inbounds %Statement, %Statement* %t2484, i32 0, i32 1
  %t2514 = bitcast [40 x i8]* %t2513 to i8*
  %t2515 = getelementptr inbounds i8, i8* %t2514, i64 24
  %t2516 = bitcast i8* %t2515 to i8**
  %t2517 = load i8*, i8** %t2516
  %t2518 = icmp eq i32 %t2483, 12
  %t2519 = select i1 %t2518, i8* %t2517, i8* %t2512
  %t2520 = getelementptr inbounds %Statement, %Statement* %t2484, i32 0, i32 1
  %t2521 = bitcast [24 x i8]* %t2520 to i8*
  %t2522 = getelementptr inbounds i8, i8* %t2521, i64 8
  %t2523 = bitcast i8* %t2522 to i8**
  %t2524 = load i8*, i8** %t2523
  %t2525 = icmp eq i32 %t2483, 13
  %t2526 = select i1 %t2525, i8* %t2524, i8* %t2519
  %t2527 = getelementptr inbounds %Statement, %Statement* %t2484, i32 0, i32 1
  %t2528 = bitcast [24 x i8]* %t2527 to i8*
  %t2529 = getelementptr inbounds i8, i8* %t2528, i64 8
  %t2530 = bitcast i8* %t2529 to i8**
  %t2531 = load i8*, i8** %t2530
  %t2532 = icmp eq i32 %t2483, 14
  %t2533 = select i1 %t2532, i8* %t2531, i8* %t2526
  %t2534 = getelementptr inbounds %Statement, %Statement* %t2484, i32 0, i32 1
  %t2535 = bitcast [16 x i8]* %t2534 to i8*
  %t2536 = bitcast i8* %t2535 to i8**
  %t2537 = load i8*, i8** %t2536
  %t2538 = icmp eq i32 %t2483, 15
  %t2539 = select i1 %t2538, i8* %t2537, i8* %t2533
  %t2540 = call { %Diagnostic*, i64 }* @check_block(%Block zeroinitializer, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2541 = insertvalue %ScopeResult %t2482, { i8**, i64 }* null, 1
  ret %ScopeResult %t2541
merge41:
  %t2542 = extractvalue %Statement %statement, 0
  %t2543 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2544 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2545 = icmp eq i32 %t2542, 0
  %t2546 = select i1 %t2545, i8* %t2544, i8* %t2543
  %t2547 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2548 = icmp eq i32 %t2542, 1
  %t2549 = select i1 %t2548, i8* %t2547, i8* %t2546
  %t2550 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2551 = icmp eq i32 %t2542, 2
  %t2552 = select i1 %t2551, i8* %t2550, i8* %t2549
  %t2553 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2554 = icmp eq i32 %t2542, 3
  %t2555 = select i1 %t2554, i8* %t2553, i8* %t2552
  %t2556 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2557 = icmp eq i32 %t2542, 4
  %t2558 = select i1 %t2557, i8* %t2556, i8* %t2555
  %t2559 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2560 = icmp eq i32 %t2542, 5
  %t2561 = select i1 %t2560, i8* %t2559, i8* %t2558
  %t2562 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2563 = icmp eq i32 %t2542, 6
  %t2564 = select i1 %t2563, i8* %t2562, i8* %t2561
  %t2565 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2566 = icmp eq i32 %t2542, 7
  %t2567 = select i1 %t2566, i8* %t2565, i8* %t2564
  %t2568 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2569 = icmp eq i32 %t2542, 8
  %t2570 = select i1 %t2569, i8* %t2568, i8* %t2567
  %t2571 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2572 = icmp eq i32 %t2542, 9
  %t2573 = select i1 %t2572, i8* %t2571, i8* %t2570
  %t2574 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2575 = icmp eq i32 %t2542, 10
  %t2576 = select i1 %t2575, i8* %t2574, i8* %t2573
  %t2577 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2578 = icmp eq i32 %t2542, 11
  %t2579 = select i1 %t2578, i8* %t2577, i8* %t2576
  %t2580 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2581 = icmp eq i32 %t2542, 12
  %t2582 = select i1 %t2581, i8* %t2580, i8* %t2579
  %t2583 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2584 = icmp eq i32 %t2542, 13
  %t2585 = select i1 %t2584, i8* %t2583, i8* %t2582
  %t2586 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2587 = icmp eq i32 %t2542, 14
  %t2588 = select i1 %t2587, i8* %t2586, i8* %t2585
  %t2589 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2590 = icmp eq i32 %t2542, 15
  %t2591 = select i1 %t2590, i8* %t2589, i8* %t2588
  %t2592 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2593 = icmp eq i32 %t2542, 16
  %t2594 = select i1 %t2593, i8* %t2592, i8* %t2591
  %t2595 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2596 = icmp eq i32 %t2542, 17
  %t2597 = select i1 %t2596, i8* %t2595, i8* %t2594
  %t2598 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2599 = icmp eq i32 %t2542, 18
  %t2600 = select i1 %t2599, i8* %t2598, i8* %t2597
  %t2601 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2602 = icmp eq i32 %t2542, 19
  %t2603 = select i1 %t2602, i8* %t2601, i8* %t2600
  %t2604 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2605 = icmp eq i32 %t2542, 20
  %t2606 = select i1 %t2605, i8* %t2604, i8* %t2603
  %t2607 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2608 = icmp eq i32 %t2542, 21
  %t2609 = select i1 %t2608, i8* %t2607, i8* %t2606
  %t2610 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2611 = icmp eq i32 %t2542, 22
  %t2612 = select i1 %t2611, i8* %t2610, i8* %t2609
  %s2613 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.2613, i32 0, i32 0
  %t2614 = icmp eq i8* %t2612, %s2613
  br i1 %t2614, label %then42, label %merge43
then42:
  %t2615 = extractvalue %Statement %statement, 0
  %t2616 = alloca %Statement
  store %Statement %statement, %Statement* %t2616
  %t2617 = getelementptr inbounds %Statement, %Statement* %t2616, i32 0, i32 1
  %t2618 = bitcast [48 x i8]* %t2617 to i8*
  %t2619 = bitcast i8* %t2618 to i8**
  %t2620 = load i8*, i8** %t2619
  %t2621 = icmp eq i32 %t2615, 2
  %t2622 = select i1 %t2621, i8* %t2620, i8* null
  %t2623 = getelementptr inbounds %Statement, %Statement* %t2616, i32 0, i32 1
  %t2624 = bitcast [48 x i8]* %t2623 to i8*
  %t2625 = bitcast i8* %t2624 to i8**
  %t2626 = load i8*, i8** %t2625
  %t2627 = icmp eq i32 %t2615, 3
  %t2628 = select i1 %t2627, i8* %t2626, i8* %t2622
  %t2629 = getelementptr inbounds %Statement, %Statement* %t2616, i32 0, i32 1
  %t2630 = bitcast [40 x i8]* %t2629 to i8*
  %t2631 = bitcast i8* %t2630 to i8**
  %t2632 = load i8*, i8** %t2631
  %t2633 = icmp eq i32 %t2615, 6
  %t2634 = select i1 %t2633, i8* %t2632, i8* %t2628
  %t2635 = getelementptr inbounds %Statement, %Statement* %t2616, i32 0, i32 1
  %t2636 = bitcast [56 x i8]* %t2635 to i8*
  %t2637 = bitcast i8* %t2636 to i8**
  %t2638 = load i8*, i8** %t2637
  %t2639 = icmp eq i32 %t2615, 8
  %t2640 = select i1 %t2639, i8* %t2638, i8* %t2634
  %t2641 = getelementptr inbounds %Statement, %Statement* %t2616, i32 0, i32 1
  %t2642 = bitcast [40 x i8]* %t2641 to i8*
  %t2643 = bitcast i8* %t2642 to i8**
  %t2644 = load i8*, i8** %t2643
  %t2645 = icmp eq i32 %t2615, 9
  %t2646 = select i1 %t2645, i8* %t2644, i8* %t2640
  %t2647 = getelementptr inbounds %Statement, %Statement* %t2616, i32 0, i32 1
  %t2648 = bitcast [40 x i8]* %t2647 to i8*
  %t2649 = bitcast i8* %t2648 to i8**
  %t2650 = load i8*, i8** %t2649
  %t2651 = icmp eq i32 %t2615, 10
  %t2652 = select i1 %t2651, i8* %t2650, i8* %t2646
  %t2653 = getelementptr inbounds %Statement, %Statement* %t2616, i32 0, i32 1
  %t2654 = bitcast [40 x i8]* %t2653 to i8*
  %t2655 = bitcast i8* %t2654 to i8**
  %t2656 = load i8*, i8** %t2655
  %t2657 = icmp eq i32 %t2615, 11
  %t2658 = select i1 %t2657, i8* %t2656, i8* %t2652
  %s2659 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2659, i32 0, i32 0
  %t2660 = extractvalue %Statement %statement, 0
  %t2661 = alloca %Statement
  store %Statement %statement, %Statement* %t2661
  %t2662 = getelementptr inbounds %Statement, %Statement* %t2661, i32 0, i32 1
  %t2663 = bitcast [48 x i8]* %t2662 to i8*
  %t2664 = getelementptr inbounds i8, i8* %t2663, i64 8
  %t2665 = bitcast i8* %t2664 to i8**
  %t2666 = load i8*, i8** %t2665
  %t2667 = icmp eq i32 %t2660, 3
  %t2668 = select i1 %t2667, i8* %t2666, i8* null
  %t2669 = getelementptr inbounds %Statement, %Statement* %t2661, i32 0, i32 1
  %t2670 = bitcast [40 x i8]* %t2669 to i8*
  %t2671 = getelementptr inbounds i8, i8* %t2670, i64 8
  %t2672 = bitcast i8* %t2671 to i8**
  %t2673 = load i8*, i8** %t2672
  %t2674 = icmp eq i32 %t2660, 6
  %t2675 = select i1 %t2674, i8* %t2673, i8* %t2668
  %t2676 = getelementptr inbounds %Statement, %Statement* %t2661, i32 0, i32 1
  %t2677 = bitcast [56 x i8]* %t2676 to i8*
  %t2678 = getelementptr inbounds i8, i8* %t2677, i64 8
  %t2679 = bitcast i8* %t2678 to i8**
  %t2680 = load i8*, i8** %t2679
  %t2681 = icmp eq i32 %t2660, 8
  %t2682 = select i1 %t2681, i8* %t2680, i8* %t2675
  %t2683 = getelementptr inbounds %Statement, %Statement* %t2661, i32 0, i32 1
  %t2684 = bitcast [40 x i8]* %t2683 to i8*
  %t2685 = getelementptr inbounds i8, i8* %t2684, i64 8
  %t2686 = bitcast i8* %t2685 to i8**
  %t2687 = load i8*, i8** %t2686
  %t2688 = icmp eq i32 %t2660, 9
  %t2689 = select i1 %t2688, i8* %t2687, i8* %t2682
  %t2690 = getelementptr inbounds %Statement, %Statement* %t2661, i32 0, i32 1
  %t2691 = bitcast [40 x i8]* %t2690 to i8*
  %t2692 = getelementptr inbounds i8, i8* %t2691, i64 8
  %t2693 = bitcast i8* %t2692 to i8**
  %t2694 = load i8*, i8** %t2693
  %t2695 = icmp eq i32 %t2660, 10
  %t2696 = select i1 %t2695, i8* %t2694, i8* %t2689
  %t2697 = getelementptr inbounds %Statement, %Statement* %t2661, i32 0, i32 1
  %t2698 = bitcast [40 x i8]* %t2697 to i8*
  %t2699 = getelementptr inbounds i8, i8* %t2698, i64 8
  %t2700 = bitcast i8* %t2699 to i8**
  %t2701 = load i8*, i8** %t2700
  %t2702 = icmp eq i32 %t2660, 11
  %t2703 = select i1 %t2702, i8* %t2701, i8* %t2696
  %t2704 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t2658, i8* %s2659, i8* %t2703)
  store %ScopeResult %t2704, %ScopeResult* %l24
  %t2705 = extractvalue %Statement %statement, 0
  %t2706 = alloca %Statement
  store %Statement %statement, %Statement* %t2706
  %t2707 = getelementptr inbounds %Statement, %Statement* %t2706, i32 0, i32 1
  %t2708 = bitcast [56 x i8]* %t2707 to i8*
  %t2709 = getelementptr inbounds i8, i8* %t2708, i64 16
  %t2710 = bitcast i8* %t2709 to { i8**, i64 }**
  %t2711 = load { i8**, i64 }*, { i8**, i64 }** %t2710
  %t2712 = icmp eq i32 %t2705, 8
  %t2713 = select i1 %t2712, { i8**, i64 }* %t2711, { i8**, i64 }* null
  %t2714 = getelementptr inbounds %Statement, %Statement* %t2706, i32 0, i32 1
  %t2715 = bitcast [40 x i8]* %t2714 to i8*
  %t2716 = getelementptr inbounds i8, i8* %t2715, i64 16
  %t2717 = bitcast i8* %t2716 to { i8**, i64 }**
  %t2718 = load { i8**, i64 }*, { i8**, i64 }** %t2717
  %t2719 = icmp eq i32 %t2705, 9
  %t2720 = select i1 %t2719, { i8**, i64 }* %t2718, { i8**, i64 }* %t2713
  %t2721 = getelementptr inbounds %Statement, %Statement* %t2706, i32 0, i32 1
  %t2722 = bitcast [40 x i8]* %t2721 to i8*
  %t2723 = getelementptr inbounds i8, i8* %t2722, i64 16
  %t2724 = bitcast i8* %t2723 to { i8**, i64 }**
  %t2725 = load { i8**, i64 }*, { i8**, i64 }** %t2724
  %t2726 = icmp eq i32 %t2705, 10
  %t2727 = select i1 %t2726, { i8**, i64 }* %t2725, { i8**, i64 }* %t2720
  %t2728 = getelementptr inbounds %Statement, %Statement* %t2706, i32 0, i32 1
  %t2729 = bitcast [40 x i8]* %t2728 to i8*
  %t2730 = getelementptr inbounds i8, i8* %t2729, i64 16
  %t2731 = bitcast i8* %t2730 to { i8**, i64 }**
  %t2732 = load { i8**, i64 }*, { i8**, i64 }** %t2731
  %t2733 = icmp eq i32 %t2705, 11
  %t2734 = select i1 %t2733, { i8**, i64 }* %t2732, { i8**, i64 }* %t2727
  %t2735 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* null)
  %t2736 = call double @registrationdiagnosticsconcat({ %Diagnostic*, i64 }* %t2735)
  store double %t2736, double* %l25
  %t2737 = load %ScopeResult, %ScopeResult* %l24
  %t2738 = extractvalue %ScopeResult %t2737, 0
  %t2739 = insertvalue %ScopeResult undef, { i8**, i64 }* %t2738, 0
  %t2740 = load double, double* %l25
  %t2741 = insertvalue %ScopeResult %t2739, { i8**, i64 }* null, 1
  ret %ScopeResult %t2741
merge43:
  %t2742 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t2743 = alloca [0 x i8*]
  %t2744 = getelementptr [0 x i8*], [0 x i8*]* %t2743, i32 0, i32 0
  %t2745 = alloca { i8**, i64 }
  %t2746 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2745, i32 0, i32 0
  store i8** %t2744, i8*** %t2746
  %t2747 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2745, i32 0, i32 1
  store i64 0, i64* %t2747
  %t2748 = insertvalue %ScopeResult %t2742, { i8**, i64 }* %t2745, 1
  ret %ScopeResult %t2748
}

define { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %signature, %Block %body, { %Statement*, i64 }* %interfaces) {
entry:
  %l0 = alloca %ScopeResult
  %l1 = alloca { %Diagnostic*, i64 }*
  %t0 = call %ScopeResult @seed_parameter_scope(%FunctionSignature %signature)
  store %ScopeResult %t0, %ScopeResult* %l0
  %t1 = load %ScopeResult, %ScopeResult* %l0
  %t2 = extractvalue %ScopeResult %t1, 0
  %t3 = call { %Diagnostic*, i64 }* @check_block(%Block %body, { %SymbolEntry*, i64 }* null, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t3, { %Diagnostic*, i64 }** %l1
  %t4 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t5 = call double @parameter_scopediagnosticsconcat({ %Diagnostic*, i64 }* %t4)
  ret { %Diagnostic*, i64 }* null
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
  %t25 = load double, double* %l4
  br label %forinc2
forinc2:
  %t26 = load i64, i64* %l2
  %t27 = add i64 %t26, 1
  store i64 %t27, i64* %l2
  br label %for0
afterfor3:
  %t28 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t29 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t30 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t31 = insertvalue %ScopeResult %t29, { i8**, i64 }* null, 1
  ret %ScopeResult %t31
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
  store { %SymbolEntry*, i64 }* null, { %SymbolEntry*, i64 }** %l0
  %t21 = load %ScopeResult, %ScopeResult* %l4
  %t22 = extractvalue %ScopeResult %t21, 1
  %t23 = call double @diagnosticsconcat({ i8**, i64 }* %t22)
  store { %Diagnostic*, i64 }* null, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t24 = load i64, i64* %l2
  %t25 = add i64 %t24, 1
  store i64 %t25, i64* %l2
  br label %for0
afterfor3:
  %t26 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t26
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
  %t40 = load i8*, i8** %l2
  br label %forinc4
forinc4:
  %t41 = load i64, i64* %l1
  %t42 = add i64 %t41, 1
  store i64 %t42, i64* %l1
  br label %for2
afterfor5:
  %t43 = alloca [0 x %Diagnostic]
  %t44 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* %t43, i32 0, i32 0
  %t45 = alloca { %Diagnostic*, i64 }
  %t46 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t45, i32 0, i32 0
  store %Diagnostic* %t44, %Diagnostic** %t46
  %t47 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t45, i32 0, i32 1
  store i64 0, i64* %t47
  store { %Diagnostic*, i64 }* %t45, { %Diagnostic*, i64 }** %l3
  %t48 = extractvalue %Statement %statement, 0
  %t49 = alloca %Statement
  store %Statement %statement, %Statement* %t49
  %t50 = getelementptr inbounds %Statement, %Statement* %t49, i32 0, i32 1
  %t51 = bitcast [56 x i8]* %t50 to i8*
  %t52 = getelementptr inbounds i8, i8* %t51, i64 24
  %t53 = bitcast i8* %t52 to { i8**, i64 }**
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %t53
  %t55 = icmp eq i32 %t48, 8
  %t56 = select i1 %t55, { i8**, i64 }* %t54, { i8**, i64 }* null
  %t57 = getelementptr { i8**, i64 }, { i8**, i64 }* %t56, i32 0, i32 1
  %t58 = load i64, i64* %t57
  %t59 = getelementptr { i8**, i64 }, { i8**, i64 }* %t56, i32 0, i32 0
  %t60 = load i8**, i8*** %t59
  store i64 0, i64* %l4
  store i8* null, i8** %l5
  br label %for6
for6:
  %t61 = load i64, i64* %l4
  %t62 = icmp slt i64 %t61, %t58
  br i1 %t62, label %forbody7, label %afterfor9
forbody7:
  %t63 = load i64, i64* %l4
  %t64 = getelementptr i8*, i8** %t60, i64 %t63
  %t65 = load i8*, i8** %t64
  store i8* %t65, i8** %l5
  %t66 = load i8*, i8** %l5
  %t67 = call double @resolve_interface_annotation(%TypeAnnotation zeroinitializer, { %Statement*, i64 }* %interfaces)
  store double %t67, double* %l6
  %t68 = load double, double* %l6
  %t69 = load double, double* %l6
  store double 0.0, double* %l7
  %t70 = load double, double* %l6
  br label %forinc8
forinc8:
  %t71 = load i64, i64* %l4
  %t72 = add i64 %t71, 1
  store i64 %t72, i64* %l4
  br label %for6
afterfor9:
  %t73 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  ret { %Diagnostic*, i64 }* %t73
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
  %t28 = load i8*, i8** %l4
  %t29 = alloca [1 x i8*]
  %t30 = getelementptr [1 x i8*], [1 x i8*]* %t29, i32 0, i32 0
  %t31 = getelementptr i8*, i8** %t30, i64 0
  store i8* %t28, i8** %t31
  %t32 = alloca { i8**, i64 }
  %t33 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 0
  store i8** %t30, i8*** %t33
  %t34 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 1
  store i64 1, i64* %t34
  %t35 = call double @seenconcat({ i8**, i64 }* %t32)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t36 = phi { %Diagnostic*, i64 }* [ null, %then4 ], [ %t25, %else5 ]
  %t37 = phi { i8**, i64 }* [ %t24, %then4 ], [ null, %else5 ]
  store { %Diagnostic*, i64 }* %t36, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t38 = load i64, i64* %l2
  %t39 = add i64 %t38, 1
  store i64 %t39, i64* %l2
  br label %for0
afterfor3:
  %t40 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t40
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
  %t44 = load i8*, i8** %l2
  br label %forinc2
forinc2:
  %t45 = load i64, i64* %l1
  %t46 = add i64 %t45, 1
  store i64 %t46, i64* %l1
  br label %for0
afterfor3:
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load { i8**, i64 }, { i8**, i64 }* %t47
  %t49 = extractvalue { i8**, i64 } %t48, 1
  %t50 = icmp eq i64 %t49, 0
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br i1 %t50, label %then4, label %merge5
then4:
  %t52 = extractvalue %Statement %interface_definition, 0
  %t53 = alloca %Statement
  store %Statement %interface_definition, %Statement* %t53
  %t54 = getelementptr inbounds %Statement, %Statement* %t53, i32 0, i32 1
  %t55 = bitcast [48 x i8]* %t54 to i8*
  %t56 = bitcast i8* %t55 to i8**
  %t57 = load i8*, i8** %t56
  %t58 = icmp eq i32 %t52, 2
  %t59 = select i1 %t58, i8* %t57, i8* null
  %t60 = getelementptr inbounds %Statement, %Statement* %t53, i32 0, i32 1
  %t61 = bitcast [48 x i8]* %t60 to i8*
  %t62 = bitcast i8* %t61 to i8**
  %t63 = load i8*, i8** %t62
  %t64 = icmp eq i32 %t52, 3
  %t65 = select i1 %t64, i8* %t63, i8* %t59
  %t66 = getelementptr inbounds %Statement, %Statement* %t53, i32 0, i32 1
  %t67 = bitcast [40 x i8]* %t66 to i8*
  %t68 = bitcast i8* %t67 to i8**
  %t69 = load i8*, i8** %t68
  %t70 = icmp eq i32 %t52, 6
  %t71 = select i1 %t70, i8* %t69, i8* %t65
  %t72 = getelementptr inbounds %Statement, %Statement* %t53, i32 0, i32 1
  %t73 = bitcast [56 x i8]* %t72 to i8*
  %t74 = bitcast i8* %t73 to i8**
  %t75 = load i8*, i8** %t74
  %t76 = icmp eq i32 %t52, 8
  %t77 = select i1 %t76, i8* %t75, i8* %t71
  %t78 = getelementptr inbounds %Statement, %Statement* %t53, i32 0, i32 1
  %t79 = bitcast [40 x i8]* %t78 to i8*
  %t80 = bitcast i8* %t79 to i8**
  %t81 = load i8*, i8** %t80
  %t82 = icmp eq i32 %t52, 9
  %t83 = select i1 %t82, i8* %t81, i8* %t77
  %t84 = getelementptr inbounds %Statement, %Statement* %t53, i32 0, i32 1
  %t85 = bitcast [40 x i8]* %t84 to i8*
  %t86 = bitcast i8* %t85 to i8**
  %t87 = load i8*, i8** %t86
  %t88 = icmp eq i32 %t52, 10
  %t89 = select i1 %t88, i8* %t87, i8* %t83
  %t90 = getelementptr inbounds %Statement, %Statement* %t53, i32 0, i32 1
  %t91 = bitcast [40 x i8]* %t90 to i8*
  %t92 = bitcast i8* %t91 to i8**
  %t93 = load i8*, i8** %t92
  %t94 = icmp eq i32 %t52, 11
  %t95 = select i1 %t94, i8* %t93, i8* %t89
  ret i8* %t95
merge5:
  %t96 = extractvalue %Statement %interface_definition, 0
  %t97 = alloca %Statement
  store %Statement %interface_definition, %Statement* %t97
  %t98 = getelementptr inbounds %Statement, %Statement* %t97, i32 0, i32 1
  %t99 = bitcast [48 x i8]* %t98 to i8*
  %t100 = bitcast i8* %t99 to i8**
  %t101 = load i8*, i8** %t100
  %t102 = icmp eq i32 %t96, 2
  %t103 = select i1 %t102, i8* %t101, i8* null
  %t104 = getelementptr inbounds %Statement, %Statement* %t97, i32 0, i32 1
  %t105 = bitcast [48 x i8]* %t104 to i8*
  %t106 = bitcast i8* %t105 to i8**
  %t107 = load i8*, i8** %t106
  %t108 = icmp eq i32 %t96, 3
  %t109 = select i1 %t108, i8* %t107, i8* %t103
  %t110 = getelementptr inbounds %Statement, %Statement* %t97, i32 0, i32 1
  %t111 = bitcast [40 x i8]* %t110 to i8*
  %t112 = bitcast i8* %t111 to i8**
  %t113 = load i8*, i8** %t112
  %t114 = icmp eq i32 %t96, 6
  %t115 = select i1 %t114, i8* %t113, i8* %t109
  %t116 = getelementptr inbounds %Statement, %Statement* %t97, i32 0, i32 1
  %t117 = bitcast [56 x i8]* %t116 to i8*
  %t118 = bitcast i8* %t117 to i8**
  %t119 = load i8*, i8** %t118
  %t120 = icmp eq i32 %t96, 8
  %t121 = select i1 %t120, i8* %t119, i8* %t115
  %t122 = getelementptr inbounds %Statement, %Statement* %t97, i32 0, i32 1
  %t123 = bitcast [40 x i8]* %t122 to i8*
  %t124 = bitcast i8* %t123 to i8**
  %t125 = load i8*, i8** %t124
  %t126 = icmp eq i32 %t96, 9
  %t127 = select i1 %t126, i8* %t125, i8* %t121
  %t128 = getelementptr inbounds %Statement, %Statement* %t97, i32 0, i32 1
  %t129 = bitcast [40 x i8]* %t128 to i8*
  %t130 = bitcast i8* %t129 to i8**
  %t131 = load i8*, i8** %t130
  %t132 = icmp eq i32 %t96, 10
  %t133 = select i1 %t132, i8* %t131, i8* %t127
  %t134 = getelementptr inbounds %Statement, %Statement* %t97, i32 0, i32 1
  %t135 = bitcast [40 x i8]* %t134 to i8*
  %t136 = bitcast i8* %t135 to i8**
  %t137 = load i8*, i8** %t136
  %t138 = icmp eq i32 %t96, 11
  %t139 = select i1 %t138, i8* %t137, i8* %t133
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
  %t21 = phi double [ %t11, %entry ], [ %t20, %loop.latch2 ]
  store double %t21, double* %l3
  br label %loop.body1
loop.body1:
  %t12 = load double, double* %l3
  %t13 = load double, double* %l3
  %t14 = getelementptr i8, i8* %block, i64 %t13
  %t15 = load i8, i8* %t14
  store i8 %t15, i8* %l4
  %t16 = load i8, i8* %l4
  %t17 = load double, double* %l3
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l3
  br label %loop.latch2
loop.latch2:
  %t20 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t22 = load i8*, i8** %l1
  %t23 = call i8* @trim_text(i8* %t22)
  store i8* %t23, i8** %l5
  %t24 = load i8*, i8** %l5
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t25
}

define i8* @trim_text(i8* %value) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t18 = phi double [ %t1, %entry ], [ %t17, %loop.latch2 ]
  store double %t18, double* %l0
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l0
  %t4 = load double, double* %l1
  %t5 = fcmp oge double %t3, %t4
  %t6 = load double, double* %l0
  %t7 = load double, double* %l1
  br i1 %t5, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l0
  %t9 = getelementptr i8, i8* %value, i64 %t8
  %t10 = load i8, i8* %t9
  %t11 = call i1 @is_whitespace(i8* null)
  %t12 = load double, double* %l0
  %t13 = load double, double* %l1
  br i1 %t11, label %then6, label %merge7
then6:
  %t14 = load double, double* %l0
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  store double %t16, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t17 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t19 = load double, double* %l0
  %t20 = load double, double* %l1
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t21 = load double, double* %l1
  %t22 = load double, double* %l0
  %t23 = fcmp ole double %t21, %t22
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  br i1 %t23, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  br label %afterloop11
loop.latch10:
  br label %loop.header8
afterloop11:
  %t26 = load double, double* %l0
  %t27 = load double, double* %l1
  %t28 = call i8* @slice_text(i8* %value, double %t26, double %t27)
  ret i8* %t28
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
  %t2 = fcmp ole double %end, %start
  br i1 %t2, label %then2, label %merge3
then2:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge3:
  %s4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.4, i32 0, i32 0
  store i8* %s4, i8** %l0
  store double %start, double* %l1
  %t5 = load i8*, i8** %l0
  %t6 = load double, double* %l1
  br label %loop.header4
loop.header4:
  %t23 = phi i8* [ %t5, %entry ], [ %t21, %loop.latch6 ]
  %t24 = phi double [ %t6, %entry ], [ %t22, %loop.latch6 ]
  store i8* %t23, i8** %l0
  store double %t24, double* %l1
  br label %loop.body5
loop.body5:
  %t7 = load double, double* %l1
  %t8 = fcmp oge double %t7, %end
  %t9 = load i8*, i8** %l0
  %t10 = load double, double* %l1
  br i1 %t8, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  %t13 = getelementptr i8, i8* %value, i64 %t12
  %t14 = load i8, i8* %t13
  %t15 = getelementptr i8, i8* %t11, i64 0
  %t16 = load i8, i8* %t15
  %t17 = add i8 %t16, %t14
  store i8* null, i8** %l0
  %t18 = load double, double* %l1
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l1
  br label %loop.latch6
loop.latch6:
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l1
  br label %loop.header4
afterloop7:
  %t25 = load i8*, i8** %l0
  ret i8* %t25
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
  %t19 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t20 = extractvalue %MethodDeclaration %t19, 0
  %t21 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature zeroinitializer)
  %t22 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t21)
  store { %Diagnostic*, i64 }* null, { %Diagnostic*, i64 }** %l1
  %t23 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t24 = extractvalue %MethodDeclaration %t23, 0
  store double 0.0, double* %l4
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load double, double* %l4
  %t27 = call i1 @contains_string({ i8**, i64 }* %t25, i8* null)
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t30 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t31 = load double, double* %l4
  br i1 %t27, label %then4, label %else5
then4:
  br label %merge6
else5:
  %t32 = load double, double* %l4
  %t33 = alloca [1 x double]
  %t34 = getelementptr [1 x double], [1 x double]* %t33, i32 0, i32 0
  %t35 = getelementptr double, double* %t34, i64 0
  store double %t32, double* %t35
  %t36 = alloca { double*, i64 }
  %t37 = getelementptr { double*, i64 }, { double*, i64 }* %t36, i32 0, i32 0
  store double* %t34, double** %t37
  %t38 = getelementptr { double*, i64 }, { double*, i64 }* %t36, i32 0, i32 1
  store i64 1, i64* %t38
  %t39 = call double @seenconcat({ double*, i64 }* %t36)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t40 = phi { %Diagnostic*, i64 }* [ null, %then4 ], [ %t29, %else5 ]
  %t41 = phi { i8**, i64 }* [ %t28, %then4 ], [ null, %else5 ]
  store { %Diagnostic*, i64 }* %t40, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t41, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t42 = load i64, i64* %l2
  %t43 = add i64 %t42, 1
  store i64 %t43, i64* %l2
  br label %for0
afterfor3:
  %t44 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t44
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
  %t28 = load i8*, i8** %l4
  %t29 = alloca [1 x i8*]
  %t30 = getelementptr [1 x i8*], [1 x i8*]* %t29, i32 0, i32 0
  %t31 = getelementptr i8*, i8** %t30, i64 0
  store i8* %t28, i8** %t31
  %t32 = alloca { i8**, i64 }
  %t33 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 0
  store i8** %t30, i8*** %t33
  %t34 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 1
  store i64 1, i64* %t34
  %t35 = call double @seenconcat({ i8**, i64 }* %t32)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t36 = phi { %Diagnostic*, i64 }* [ null, %then4 ], [ %t25, %else5 ]
  %t37 = phi { i8**, i64 }* [ %t24, %then4 ], [ null, %else5 ]
  store { %Diagnostic*, i64 }* %t36, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t38 = load i64, i64* %l2
  %t39 = add i64 %t38, 1
  store i64 %t39, i64* %l2
  br label %for0
afterfor3:
  %t40 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t40
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
  %t19 = load %FunctionSignature, %FunctionSignature* %l3
  %t20 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t19)
  %t21 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t20)
  store { %Diagnostic*, i64 }* null, { %Diagnostic*, i64 }** %l1
  %t22 = load %FunctionSignature, %FunctionSignature* %l3
  %t23 = extractvalue %FunctionSignature %t22, 0
  store i8* %t23, i8** %l4
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load i8*, i8** %l4
  %t26 = call i1 @contains_string({ i8**, i64 }* %t24, i8* %t25)
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t29 = load %FunctionSignature, %FunctionSignature* %l3
  %t30 = load i8*, i8** %l4
  br i1 %t26, label %then4, label %else5
then4:
  br label %merge6
else5:
  %t31 = load i8*, i8** %l4
  %t32 = alloca [1 x i8*]
  %t33 = getelementptr [1 x i8*], [1 x i8*]* %t32, i32 0, i32 0
  %t34 = getelementptr i8*, i8** %t33, i64 0
  store i8* %t31, i8** %t34
  %t35 = alloca { i8**, i64 }
  %t36 = getelementptr { i8**, i64 }, { i8**, i64 }* %t35, i32 0, i32 0
  store i8** %t33, i8*** %t36
  %t37 = getelementptr { i8**, i64 }, { i8**, i64 }* %t35, i32 0, i32 1
  store i64 1, i64* %t37
  %t38 = call double @seenconcat({ i8**, i64 }* %t35)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t39 = phi { %Diagnostic*, i64 }* [ null, %then4 ], [ %t28, %else5 ]
  %t40 = phi { i8**, i64 }* [ %t27, %then4 ], [ null, %else5 ]
  store { %Diagnostic*, i64 }* %t39, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t40, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t41 = load i64, i64* %l2
  %t42 = add i64 %t41, 1
  store i64 %t42, i64* %l2
  br label %for0
afterfor3:
  %t43 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t43
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
  %t28 = load i8*, i8** %l4
  %t29 = alloca [1 x i8*]
  %t30 = getelementptr [1 x i8*], [1 x i8*]* %t29, i32 0, i32 0
  %t31 = getelementptr i8*, i8** %t30, i64 0
  store i8* %t28, i8** %t31
  %t32 = alloca { i8**, i64 }
  %t33 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 0
  store i8** %t30, i8*** %t33
  %t34 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 1
  store i64 1, i64* %t34
  %t35 = call double @seenconcat({ i8**, i64 }* %t32)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t36 = phi { %Diagnostic*, i64 }* [ null, %then4 ], [ %t25, %else5 ]
  %t37 = phi { i8**, i64 }* [ %t24, %then4 ], [ null, %else5 ]
  store { %Diagnostic*, i64 }* %t36, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t38 = load i64, i64* %l2
  %t39 = add i64 %t38, 1
  store i64 %t39, i64* %l2
  br label %for0
afterfor3:
  %t40 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t40
}

define { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %signature) {
entry:
  %t0 = extractvalue %FunctionSignature %signature, 5
  %t1 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* null)
  ret { %Diagnostic*, i64 }* %t1
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
  %t28 = load i8*, i8** %l4
  %t29 = alloca [1 x i8*]
  %t30 = getelementptr [1 x i8*], [1 x i8*]* %t29, i32 0, i32 0
  %t31 = getelementptr i8*, i8** %t30, i64 0
  store i8* %t28, i8** %t31
  %t32 = alloca { i8**, i64 }
  %t33 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 0
  store i8** %t30, i8*** %t33
  %t34 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 1
  store i64 1, i64* %t34
  %t35 = call double @seenconcat({ i8**, i64 }* %t32)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t36 = phi { %Diagnostic*, i64 }* [ null, %then4 ], [ %t25, %else5 ]
  %t37 = phi { i8**, i64 }* [ %t24, %then4 ], [ null, %else5 ]
  store { %Diagnostic*, i64 }* %t36, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t38 = load i64, i64* %l2
  %t39 = add i64 %t38, 1
  store i64 %t39, i64* %l2
  br label %for0
afterfor3:
  %t40 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t40
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
  %t1 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t2 = call double @token_from_name(i8* %name, i8* %span)
  %t3 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %name, i8* %kind, i8* null)
  %t4 = insertvalue %ScopeResult %t1, { i8**, i64 }* null, 1
  ret %ScopeResult %t4
merge1:
  %t5 = call { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %name, i8* %kind, i8* %span)
  store { %SymbolEntry*, i64 }* %t5, { %SymbolEntry*, i64 }** %l0
  %t6 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t7 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t8 = alloca [0 x i8*]
  %t9 = getelementptr [0 x i8*], [0 x i8*]* %t8, i32 0, i32 0
  %t10 = alloca { i8**, i64 }
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t9, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  %t13 = insertvalue %ScopeResult %t7, { i8**, i64 }* %t10, 1
  ret %ScopeResult %t13
}

define %SymbolCollectionResult @register_symbol(i8* %name, i8* %kind, i8* %span, { %SymbolEntry*, i64 }* %existing) {
entry:
  %t0 = call i1 @has_symbol({ %SymbolEntry*, i64 }* %existing, i8* %name)
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = insertvalue %SymbolCollectionResult undef, { i8**, i64 }* null, 0
  %t2 = call double @token_from_name(i8* %name, i8* %span)
  %t3 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %name, i8* %kind, i8* null)
  %t4 = insertvalue %SymbolCollectionResult %t1, { i8**, i64 }* null, 1
  ret %SymbolCollectionResult %t4
merge1:
  %t5 = call { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %existing, i8* %name, i8* %kind, i8* %span)
  %t6 = insertvalue %SymbolCollectionResult undef, { i8**, i64 }* null, 0
  %t7 = alloca [0 x i8*]
  %t8 = getelementptr [0 x i8*], [0 x i8*]* %t7, i32 0, i32 0
  %t9 = alloca { i8**, i64 }
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t8, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  %t12 = insertvalue %SymbolCollectionResult %t6, { i8**, i64 }* %t9, 1
  ret %SymbolCollectionResult %t12
}

define { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %symbols, i8* %name, i8* %kind, i8* %span) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %t0 = call { %SymbolEntry*, i64 }* @clone_bindings({ %SymbolEntry*, i64 }* %symbols)
  store { %SymbolEntry*, i64 }* %t0, { %SymbolEntry*, i64 }** %l0
  %t1 = insertvalue %SymbolEntry undef, i8* %name, 0
  %t2 = insertvalue %SymbolEntry %t1, i8* %kind, 1
  %t3 = insertvalue %SymbolEntry %t2, i8* %span, 2
  %t4 = alloca [1 x %SymbolEntry]
  %t5 = getelementptr [1 x %SymbolEntry], [1 x %SymbolEntry]* %t4, i32 0, i32 0
  %t6 = getelementptr %SymbolEntry, %SymbolEntry* %t5, i64 0
  store %SymbolEntry %t3, %SymbolEntry* %t6
  %t7 = alloca { %SymbolEntry*, i64 }
  %t8 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t7, i32 0, i32 0
  store %SymbolEntry* %t5, %SymbolEntry** %t8
  %t9 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t7, i32 0, i32 1
  store i64 1, i64* %t9
  %t10 = call double @updatedconcat({ %SymbolEntry*, i64 }* %t7)
  ret { %SymbolEntry*, i64 }* null
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
  %t14 = load %SymbolEntry, %SymbolEntry* %l2
  %t15 = alloca [1 x %SymbolEntry]
  %t16 = getelementptr [1 x %SymbolEntry], [1 x %SymbolEntry]* %t15, i32 0, i32 0
  %t17 = getelementptr %SymbolEntry, %SymbolEntry* %t16, i64 0
  store %SymbolEntry %t14, %SymbolEntry* %t17
  %t18 = alloca { %SymbolEntry*, i64 }
  %t19 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t18, i32 0, i32 0
  store %SymbolEntry* %t16, %SymbolEntry** %t19
  %t20 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t18, i32 0, i32 1
  store i64 1, i64* %t20
  %t21 = call double @copyconcat({ %SymbolEntry*, i64 }* %t18)
  store { %SymbolEntry*, i64 }* null, { %SymbolEntry*, i64 }** %l0
  br label %forinc2
forinc2:
  %t22 = load i64, i64* %l1
  %t23 = add i64 %t22, 1
  store i64 %t23, i64* %l1
  br label %for0
afterfor3:
  %t24 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  ret { %SymbolEntry*, i64 }* %t24
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
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t15 = phi double [ %t1, %entry ], [ %t14, %loop.latch2 ]
  store double %t15, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = getelementptr i8, i8* %value, i64 %t3
  %t5 = load i8, i8* %t4
  %t6 = load double, double* %l0
  %t7 = getelementptr i8, i8* %prefix, i64 %t6
  %t8 = load i8, i8* %t7
  %t9 = icmp ne i8 %t5, %t8
  %t10 = load double, double* %l0
  br i1 %t9, label %then4, label %merge5
then4:
  ret i1 0
merge5:
  %t11 = load double, double* %l0
  %t12 = sitofp i64 1 to double
  %t13 = fadd double %t11, %t12
  store double %t13, double* %l0
  br label %loop.latch2
loop.latch2:
  %t14 = load double, double* %l0
  br label %loop.header0
afterloop3:
  ret i1 1
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
