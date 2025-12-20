; ModuleID = 'sailfin'
source_filename = "sailfin"

%Diagnostic = type { i8*, i8*, %Token* }
%SymbolEntry = type { i8*, i8*, %SourceSpan* }
%TypecheckResult = type { { %Diagnostic*, i64 }*, { %SymbolEntry*, i64 }* }
%SymbolCollectionResult = type { { %SymbolEntry*, i64 }*, { %Diagnostic*, i64 }* }
%ScopeResult = type { { %SymbolEntry*, i64 }*, { %Diagnostic*, i64 }* }
%Program = type { { %Statement*, i64 }* }
%TypeAnnotation = type { i8* }
%TypeParameter = type { i8*, %TypeAnnotation*, %SourceSpan* }
%Block = type { { %Token*, i64 }*, i8*, { %Statement*, i64 }* }
%SourceSpan = type { double, double, double, double }
%Parameter = type { i8*, %TypeAnnotation*, %Expression*, i1, %SourceSpan* }
%WithClause = type { %Expression }
%ObjectField = type { i8*, %Expression }
%ElseBranch = type { %Statement*, %Block* }
%ForClause = type { %Expression, %Expression, { %Token*, i64 }* }
%MatchCase = type { %Expression, %Expression*, %Block }
%ModelProperty = type { i8*, %Expression, %SourceSpan* }
%FieldDeclaration = type { i8*, %TypeAnnotation, i1, %SourceSpan* }
%MethodDeclaration = type { %FunctionSignature, %Block, { %Decorator*, i64 }* }
%EnumVariant = type { i8*, { %FieldDeclaration*, i64 }*, %SourceSpan* }
%FunctionSignature = type { i8*, i1, { %Parameter*, i64 }*, %TypeAnnotation*, { i8**, i64 }*, { %TypeParameter*, i64 }*, %SourceSpan* }
%PipelineDeclaration = type { %FunctionSignature, %Block, { %Decorator*, i64 }* }
%ToolDeclaration = type { %FunctionSignature, %Block, { %Decorator*, i64 }* }
%TestDeclaration = type { i8*, %Block, { i8**, i64 }*, { %Decorator*, i64 }* }
%ModelDeclaration = type { i8*, %TypeAnnotation, { %ModelProperty*, i64 }*, { i8**, i64 }*, { %Decorator*, i64 }* }
%Decorator = type { i8*, { %DecoratorArgument*, i64 }* }
%DecoratorArgument = type { i8*, %Expression }
%ImportSpecifier = type { i8*, i8* }
%ExportSpecifier = type { i8*, i8* }
%Token = type { %TokenKind, i8*, double, double }
%EffectRequirement = type { i8*, %Token*, i8* }
%EffectViolation = type { i8*, { i8**, i64 }*, { %EffectRequirement*, i64 }* }

%Expression = type { i32, [40 x i8] }
%Statement = type { i32, [136 x i8] }
%TokenKind = type { i32 }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare i1 @strings_equal(i8*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)
declare void @sailfin_runtime_mark_persistent(i8*)

declare %Token @eof_token(double, double)
declare { %EffectViolation*, i64 }* @validate_effects(%Program)
declare { %EffectViolation*, i64 }* @analyze_statement(%Statement)
declare { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature, %Block, { %Decorator*, i64 }*, i8*)
declare { %EffectRequirement*, i64 }* @required_effects(%Block)
declare { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block)
declare { %EffectRequirement*, i64 }* @collect_effects_from_optional_block(%Block*)
declare { %EffectRequirement*, i64 }* @collect_effects_from_optional_statement(%Statement*)
declare { %EffectRequirement*, i64 }* @collect_effects_from_statement(%Statement)
declare { %EffectRequirement*, i64 }* @collect_effects_from_else_branch(%ElseBranch)
declare { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase)
declare { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression*)
declare { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }*)
declare i8* @token_text(%Token)
declare { %EffectRequirement*, i64 }* @append_prompt_effect({ %EffectRequirement*, i64 }*, { %Token*, i64 }*)
declare { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }*, { %Token*, i64 }*, i8*, i8*, i8*)
declare { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }*, { %Token*, i64 }*, i8*, i8*, i8*)
declare { %Token*, i64 }* @find_identifier_followed_by_symbol({ %Token*, i64 }*, i8*, i8*)
declare { %Token*, i64 }* @find_identifier_call({ %Token*, i64 }*, i8*)
declare double @next_non_trivia({ %Token*, i64 }*, double)
declare i1 @is_trivia_token(%Token)
declare i1 @is_identifier_token(%Token, i8*)
declare i1 @is_symbol_token(%Token, i8*)
declare { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }*, { %EffectViolation*, i64 }*)
declare { %EffectViolation*, i64 }* @append_violation({ %EffectViolation*, i64 }*, %EffectViolation)
declare { i8**, i64 }* @append_unique_effect({ i8**, i64 }*, i8*)
declare i1 @contains_effect({ i8**, i64 }*, i8*)
declare { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }*, %EffectRequirement)
declare { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }*)
declare i1 @contains_requirement_for_effect({ %EffectRequirement*, i64 }*, i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

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

declare void @sailfin_runtime_copy_bytes(i8*, i8*, i64)

define %TypecheckResult @typecheck_program(%Program %program) {
block.entry:
  %l0 = alloca %SymbolCollectionResult
  %l1 = alloca { %Statement*, i64 }*
  %l2 = alloca { %Diagnostic*, i64 }*
  %l3 = alloca { %Diagnostic*, i64 }*
  %l4 = alloca { %Diagnostic*, i64 }*
  %l5 = alloca { %Diagnostic*, i64 }*
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
  %t8 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t6, i32 0, i32 0
  %t9 = load %Diagnostic*, %Diagnostic** %t8
  %t10 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t6, i32 0, i32 1
  %t11 = load i64, i64* %t10
  %t12 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 0
  %t13 = load %Diagnostic*, %Diagnostic** %t12
  %t14 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 1
  %t15 = load i64, i64* %t14
  %t16 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t17 = ptrtoint %Diagnostic* %t16 to i64
  %t18 = add i64 %t11, %t15
  %t19 = mul i64 %t17, %t18
  %t20 = call noalias i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to %Diagnostic*
  %t22 = bitcast %Diagnostic* %t21 to i8*
  %t23 = mul i64 %t17, %t11
  %t24 = bitcast %Diagnostic* %t9 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t22, i8* %t24, i64 %t23)
  %t25 = mul i64 %t17, %t15
  %t26 = bitcast %Diagnostic* %t13 to i8*
  %t27 = getelementptr %Diagnostic, %Diagnostic* %t21, i64 %t11
  %t28 = bitcast %Diagnostic* %t27 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t28, i8* %t26, i64 %t25)
  %t29 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t30 = ptrtoint { %Diagnostic*, i64 }* %t29 to i64
  %t31 = call i8* @malloc(i64 %t30)
  %t32 = bitcast i8* %t31 to { %Diagnostic*, i64 }*
  %t33 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t32, i32 0, i32 0
  store %Diagnostic* %t21, %Diagnostic** %t33
  %t34 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t32, i32 0, i32 1
  store i64 %t18, i64* %t34
  store { %Diagnostic*, i64 }* %t32, { %Diagnostic*, i64 }** %l4
  %t35 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t36 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  %t37 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t35, i32 0, i32 0
  %t38 = load %Diagnostic*, %Diagnostic** %t37
  %t39 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t35, i32 0, i32 1
  %t40 = load i64, i64* %t39
  %t41 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t36, i32 0, i32 0
  %t42 = load %Diagnostic*, %Diagnostic** %t41
  %t43 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t36, i32 0, i32 1
  %t44 = load i64, i64* %t43
  %t45 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t46 = ptrtoint %Diagnostic* %t45 to i64
  %t47 = add i64 %t40, %t44
  %t48 = mul i64 %t46, %t47
  %t49 = call noalias i8* @malloc(i64 %t48)
  %t50 = bitcast i8* %t49 to %Diagnostic*
  %t51 = bitcast %Diagnostic* %t50 to i8*
  %t52 = mul i64 %t46, %t40
  %t53 = bitcast %Diagnostic* %t38 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t51, i8* %t53, i64 %t52)
  %t54 = mul i64 %t46, %t44
  %t55 = bitcast %Diagnostic* %t42 to i8*
  %t56 = getelementptr %Diagnostic, %Diagnostic* %t50, i64 %t40
  %t57 = bitcast %Diagnostic* %t56 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t57, i8* %t55, i64 %t54)
  %t58 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t59 = ptrtoint { %Diagnostic*, i64 }* %t58 to i64
  %t60 = call i8* @malloc(i64 %t59)
  %t61 = bitcast i8* %t60 to { %Diagnostic*, i64 }*
  %t62 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t61, i32 0, i32 0
  store %Diagnostic* %t50, %Diagnostic** %t62
  %t63 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t61, i32 0, i32 1
  store i64 %t47, i64* %t63
  store { %Diagnostic*, i64 }* %t61, { %Diagnostic*, i64 }** %l5
  %t64 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l5
  %t65 = insertvalue %TypecheckResult undef, { %Diagnostic*, i64 }* %t64, 0
  %t66 = load %SymbolCollectionResult, %SymbolCollectionResult* %l0
  %t67 = extractvalue %SymbolCollectionResult %t66, 0
  %t68 = insertvalue %TypecheckResult %t65, { %SymbolEntry*, i64 }* %t67, 1
  ret %TypecheckResult %t68
}

define { %Statement*, i64 }* @collect_interface_definitions(%Program %program) {
block.entry:
  %l0 = alloca { %Statement*, i64 }*
  %l1 = alloca i64
  %l2 = alloca %Statement
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
  %t13 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t12, i32 0, i32 1
  %t14 = load i64, i64* %t13
  %t15 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t12, i32 0, i32 0
  %t16 = load %Statement*, %Statement** %t15
  store i64 0, i64* %l1
  store %Statement zeroinitializer, %Statement* %l2
  br label %for0
for0:
  %t17 = load i64, i64* %l1
  %t18 = icmp slt i64 %t17, %t14
  br i1 %t18, label %forbody1, label %afterfor3
forbody1:
  %t19 = load i64, i64* %l1
  %t20 = getelementptr %Statement, %Statement* %t16, i64 %t19
  %t21 = load %Statement, %Statement* %t20
  store %Statement %t21, %Statement* %l2
  %t22 = load %Statement, %Statement* %l2
  %t23 = extractvalue %Statement %t22, 0
  %t24 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t25 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t23, 0
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t23, 1
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %t31 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t32 = icmp eq i32 %t23, 2
  %t33 = select i1 %t32, i8* %t31, i8* %t30
  %t34 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t23, 3
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %t37 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t23, 4
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %t40 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t41 = icmp eq i32 %t23, 5
  %t42 = select i1 %t41, i8* %t40, i8* %t39
  %t43 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t44 = icmp eq i32 %t23, 6
  %t45 = select i1 %t44, i8* %t43, i8* %t42
  %t46 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t47 = icmp eq i32 %t23, 7
  %t48 = select i1 %t47, i8* %t46, i8* %t45
  %t49 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t50 = icmp eq i32 %t23, 8
  %t51 = select i1 %t50, i8* %t49, i8* %t48
  %t52 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t53 = icmp eq i32 %t23, 9
  %t54 = select i1 %t53, i8* %t52, i8* %t51
  %t55 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t23, 10
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t23, 11
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t23, 12
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t23, 13
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t23, 14
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t23, 15
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t23, 16
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %t76 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t23, 17
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %t79 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t23, 18
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t23, 19
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %t85 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t23, 20
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t23, 21
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t23, 22
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = call i8* @malloc(i64 21)
  %t95 = bitcast i8* %t94 to [21 x i8]*
  store [21 x i8] c"InterfaceDeclaration\00", [21 x i8]* %t95
  %t96 = call i1 @strings_equal(i8* %t93, i8* %t94)
  %t97 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  %t98 = load %Statement, %Statement* %l2
  br i1 %t96, label %then4, label %merge5
then4:
  %t99 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  %t100 = load %Statement, %Statement* %l2
  %t101 = getelementptr [1 x %Statement], [1 x %Statement]* null, i32 1
  %t102 = ptrtoint [1 x %Statement]* %t101 to i64
  %t103 = icmp eq i64 %t102, 0
  %t104 = select i1 %t103, i64 1, i64 %t102
  %t105 = call i8* @malloc(i64 %t104)
  %t106 = bitcast i8* %t105 to %Statement*
  %t107 = getelementptr %Statement, %Statement* %t106, i64 0
  store %Statement %t100, %Statement* %t107
  %t108 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* null, i32 1
  %t109 = ptrtoint { %Statement*, i64 }* %t108 to i64
  %t110 = call i8* @malloc(i64 %t109)
  %t111 = bitcast i8* %t110 to { %Statement*, i64 }*
  %t112 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t111, i32 0, i32 0
  store %Statement* %t106, %Statement** %t112
  %t113 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t111, i32 0, i32 1
  store i64 1, i64* %t113
  %t114 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t99, i32 0, i32 0
  %t115 = load %Statement*, %Statement** %t114
  %t116 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t99, i32 0, i32 1
  %t117 = load i64, i64* %t116
  %t118 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t111, i32 0, i32 0
  %t119 = load %Statement*, %Statement** %t118
  %t120 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t111, i32 0, i32 1
  %t121 = load i64, i64* %t120
  %t122 = getelementptr [1 x %Statement], [1 x %Statement]* null, i32 0, i32 1
  %t123 = ptrtoint %Statement* %t122 to i64
  %t124 = add i64 %t117, %t121
  %t125 = mul i64 %t123, %t124
  %t126 = call noalias i8* @malloc(i64 %t125)
  %t127 = bitcast i8* %t126 to %Statement*
  %t128 = bitcast %Statement* %t127 to i8*
  %t129 = mul i64 %t123, %t117
  %t130 = bitcast %Statement* %t115 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t128, i8* %t130, i64 %t129)
  %t131 = mul i64 %t123, %t121
  %t132 = bitcast %Statement* %t119 to i8*
  %t133 = getelementptr %Statement, %Statement* %t127, i64 %t117
  %t134 = bitcast %Statement* %t133 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t134, i8* %t132, i64 %t131)
  %t135 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* null, i32 1
  %t136 = ptrtoint { %Statement*, i64 }* %t135 to i64
  %t137 = call i8* @malloc(i64 %t136)
  %t138 = bitcast i8* %t137 to { %Statement*, i64 }*
  %t139 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t138, i32 0, i32 0
  store %Statement* %t127, %Statement** %t139
  %t140 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t138, i32 0, i32 1
  store i64 %t124, i64* %t140
  store { %Statement*, i64 }* %t138, { %Statement*, i64 }** %l0
  %t141 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  br label %merge5
merge5:
  %t142 = phi { %Statement*, i64 }* [ %t141, %then4 ], [ %t97, %forbody1 ]
  store { %Statement*, i64 }* %t142, { %Statement*, i64 }** %l0
  br label %forinc2
forinc2:
  %t143 = load i64, i64* %l1
  %t144 = add i64 %t143, 1
  store i64 %t144, i64* %l1
  br label %for0
afterfor3:
  %t145 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  %t146 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  ret { %Statement*, i64 }* %t146
}

define %SymbolCollectionResult @collect_top_level_symbols(%Program %program) {
block.entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %Statement
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
  %t25 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t24, i32 0, i32 1
  %t26 = load i64, i64* %t25
  %t27 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t24, i32 0, i32 0
  %t28 = load %Statement*, %Statement** %t27
  store i64 0, i64* %l2
  store %Statement zeroinitializer, %Statement* %l3
  br label %for0
for0:
  %t29 = load i64, i64* %l2
  %t30 = icmp slt i64 %t29, %t26
  br i1 %t30, label %forbody1, label %afterfor3
forbody1:
  %t31 = load i64, i64* %l2
  %t32 = getelementptr %Statement, %Statement* %t28, i64 %t31
  %t33 = load %Statement, %Statement* %t32
  store %Statement %t33, %Statement* %l3
  %t34 = load %Statement, %Statement* %l3
  %t35 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t36 = call %SymbolCollectionResult @register_top_level_symbol(%Statement %t34, { %SymbolEntry*, i64 }* %t35)
  store %SymbolCollectionResult %t36, %SymbolCollectionResult* %l4
  %t37 = load %SymbolCollectionResult, %SymbolCollectionResult* %l4
  %t38 = extractvalue %SymbolCollectionResult %t37, 0
  store { %SymbolEntry*, i64 }* %t38, { %SymbolEntry*, i64 }** %l0
  %t39 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t40 = load %SymbolCollectionResult, %SymbolCollectionResult* %l4
  %t41 = extractvalue %SymbolCollectionResult %t40, 1
  %t42 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t39, i32 0, i32 0
  %t43 = load %Diagnostic*, %Diagnostic** %t42
  %t44 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t39, i32 0, i32 1
  %t45 = load i64, i64* %t44
  %t46 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t41, i32 0, i32 0
  %t47 = load %Diagnostic*, %Diagnostic** %t46
  %t48 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t41, i32 0, i32 1
  %t49 = load i64, i64* %t48
  %t50 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t51 = ptrtoint %Diagnostic* %t50 to i64
  %t52 = add i64 %t45, %t49
  %t53 = mul i64 %t51, %t52
  %t54 = call noalias i8* @malloc(i64 %t53)
  %t55 = bitcast i8* %t54 to %Diagnostic*
  %t56 = bitcast %Diagnostic* %t55 to i8*
  %t57 = mul i64 %t51, %t45
  %t58 = bitcast %Diagnostic* %t43 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t56, i8* %t58, i64 %t57)
  %t59 = mul i64 %t51, %t49
  %t60 = bitcast %Diagnostic* %t47 to i8*
  %t61 = getelementptr %Diagnostic, %Diagnostic* %t55, i64 %t45
  %t62 = bitcast %Diagnostic* %t61 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t62, i8* %t60, i64 %t59)
  %t63 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t64 = ptrtoint { %Diagnostic*, i64 }* %t63 to i64
  %t65 = call i8* @malloc(i64 %t64)
  %t66 = bitcast i8* %t65 to { %Diagnostic*, i64 }*
  %t67 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t66, i32 0, i32 0
  store %Diagnostic* %t55, %Diagnostic** %t67
  %t68 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t66, i32 0, i32 1
  store i64 %t52, i64* %t68
  store { %Diagnostic*, i64 }* %t66, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t69 = load i64, i64* %l2
  %t70 = add i64 %t69, 1
  store i64 %t70, i64* %l2
  br label %for0
afterfor3:
  %t71 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t72 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t73 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t74 = insertvalue %SymbolCollectionResult undef, { %SymbolEntry*, i64 }* %t73, 0
  %t75 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t76 = insertvalue %SymbolCollectionResult %t74, { %Diagnostic*, i64 }* %t75, 1
  ret %SymbolCollectionResult %t76
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
  %t71 = call i8* @malloc(i64 20)
  %t72 = bitcast i8* %t71 to [20 x i8]*
  store [20 x i8] c"FunctionDeclaration\00", [20 x i8]* %t72
  %t73 = call i1 @strings_equal(i8* %t70, i8* %t71)
  br i1 %t73, label %then0, label %merge1
then0:
  %t74 = extractvalue %Statement %statement, 0
  %t75 = alloca %Statement
  store %Statement %statement, %Statement* %t75
  %t76 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t77 = bitcast [88 x i8]* %t76 to i8*
  %t78 = bitcast i8* %t77 to %FunctionSignature*
  %t79 = load %FunctionSignature, %FunctionSignature* %t78
  %t80 = icmp eq i32 %t74, 4
  %t81 = select i1 %t80, %FunctionSignature %t79, %FunctionSignature zeroinitializer
  %t82 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t83 = bitcast [88 x i8]* %t82 to i8*
  %t84 = bitcast i8* %t83 to %FunctionSignature*
  %t85 = load %FunctionSignature, %FunctionSignature* %t84
  %t86 = icmp eq i32 %t74, 5
  %t87 = select i1 %t86, %FunctionSignature %t85, %FunctionSignature %t81
  %t88 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t89 = bitcast [88 x i8]* %t88 to i8*
  %t90 = bitcast i8* %t89 to %FunctionSignature*
  %t91 = load %FunctionSignature, %FunctionSignature* %t90
  %t92 = icmp eq i32 %t74, 7
  %t93 = select i1 %t92, %FunctionSignature %t91, %FunctionSignature %t87
  %t94 = extractvalue %FunctionSignature %t93, 0
  %t95 = call i8* @malloc(i64 9)
  %t96 = bitcast i8* %t95 to [9 x i8]*
  store [9 x i8] c"function\00", [9 x i8]* %t96
  %t97 = extractvalue %Statement %statement, 0
  %t98 = alloca %Statement
  store %Statement %statement, %Statement* %t98
  %t99 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t100 = bitcast [88 x i8]* %t99 to i8*
  %t101 = bitcast i8* %t100 to %FunctionSignature*
  %t102 = load %FunctionSignature, %FunctionSignature* %t101
  %t103 = icmp eq i32 %t97, 4
  %t104 = select i1 %t103, %FunctionSignature %t102, %FunctionSignature zeroinitializer
  %t105 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t106 = bitcast [88 x i8]* %t105 to i8*
  %t107 = bitcast i8* %t106 to %FunctionSignature*
  %t108 = load %FunctionSignature, %FunctionSignature* %t107
  %t109 = icmp eq i32 %t97, 5
  %t110 = select i1 %t109, %FunctionSignature %t108, %FunctionSignature %t104
  %t111 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t112 = bitcast [88 x i8]* %t111 to i8*
  %t113 = bitcast i8* %t112 to %FunctionSignature*
  %t114 = load %FunctionSignature, %FunctionSignature* %t113
  %t115 = icmp eq i32 %t97, 7
  %t116 = select i1 %t115, %FunctionSignature %t114, %FunctionSignature %t110
  %t117 = extractvalue %FunctionSignature %t116, 6
  %t118 = call %SymbolCollectionResult @register_symbol(i8* %t94, i8* %t95, %SourceSpan* %t117, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t118
merge1:
  %t119 = extractvalue %Statement %statement, 0
  %t120 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t121 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t122 = icmp eq i32 %t119, 0
  %t123 = select i1 %t122, i8* %t121, i8* %t120
  %t124 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t125 = icmp eq i32 %t119, 1
  %t126 = select i1 %t125, i8* %t124, i8* %t123
  %t127 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t128 = icmp eq i32 %t119, 2
  %t129 = select i1 %t128, i8* %t127, i8* %t126
  %t130 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t131 = icmp eq i32 %t119, 3
  %t132 = select i1 %t131, i8* %t130, i8* %t129
  %t133 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t134 = icmp eq i32 %t119, 4
  %t135 = select i1 %t134, i8* %t133, i8* %t132
  %t136 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t119, 5
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t119, 6
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t119, 7
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t119, 8
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t119, 9
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t119, 10
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t119, 11
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t119, 12
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %t160 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t161 = icmp eq i32 %t119, 13
  %t162 = select i1 %t161, i8* %t160, i8* %t159
  %t163 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t164 = icmp eq i32 %t119, 14
  %t165 = select i1 %t164, i8* %t163, i8* %t162
  %t166 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t167 = icmp eq i32 %t119, 15
  %t168 = select i1 %t167, i8* %t166, i8* %t165
  %t169 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t170 = icmp eq i32 %t119, 16
  %t171 = select i1 %t170, i8* %t169, i8* %t168
  %t172 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t173 = icmp eq i32 %t119, 17
  %t174 = select i1 %t173, i8* %t172, i8* %t171
  %t175 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t176 = icmp eq i32 %t119, 18
  %t177 = select i1 %t176, i8* %t175, i8* %t174
  %t178 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t179 = icmp eq i32 %t119, 19
  %t180 = select i1 %t179, i8* %t178, i8* %t177
  %t181 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t182 = icmp eq i32 %t119, 20
  %t183 = select i1 %t182, i8* %t181, i8* %t180
  %t184 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t185 = icmp eq i32 %t119, 21
  %t186 = select i1 %t185, i8* %t184, i8* %t183
  %t187 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t188 = icmp eq i32 %t119, 22
  %t189 = select i1 %t188, i8* %t187, i8* %t186
  %t190 = call i8* @malloc(i64 18)
  %t191 = bitcast i8* %t190 to [18 x i8]*
  store [18 x i8] c"StructDeclaration\00", [18 x i8]* %t191
  %t192 = call i1 @strings_equal(i8* %t189, i8* %t190)
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
  %t208 = bitcast [56 x i8]* %t207 to i8*
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
  %t237 = call i8* @malloc(i64 7)
  %t238 = bitcast i8* %t237 to [7 x i8]*
  store [7 x i8] c"struct\00", [7 x i8]* %t238
  %t239 = extractvalue %Statement %statement, 0
  %t240 = alloca %Statement
  store %Statement %statement, %Statement* %t240
  %t241 = getelementptr inbounds %Statement, %Statement* %t240, i32 0, i32 1
  %t242 = bitcast [48 x i8]* %t241 to i8*
  %t243 = getelementptr inbounds i8, i8* %t242, i64 8
  %t244 = bitcast i8* %t243 to %SourceSpan**
  %t245 = load %SourceSpan*, %SourceSpan** %t244
  %t246 = icmp eq i32 %t239, 3
  %t247 = select i1 %t246, %SourceSpan* %t245, %SourceSpan* null
  %t248 = getelementptr inbounds %Statement, %Statement* %t240, i32 0, i32 1
  %t249 = bitcast [56 x i8]* %t248 to i8*
  %t250 = getelementptr inbounds i8, i8* %t249, i64 8
  %t251 = bitcast i8* %t250 to %SourceSpan**
  %t252 = load %SourceSpan*, %SourceSpan** %t251
  %t253 = icmp eq i32 %t239, 6
  %t254 = select i1 %t253, %SourceSpan* %t252, %SourceSpan* %t247
  %t255 = getelementptr inbounds %Statement, %Statement* %t240, i32 0, i32 1
  %t256 = bitcast [56 x i8]* %t255 to i8*
  %t257 = getelementptr inbounds i8, i8* %t256, i64 8
  %t258 = bitcast i8* %t257 to %SourceSpan**
  %t259 = load %SourceSpan*, %SourceSpan** %t258
  %t260 = icmp eq i32 %t239, 8
  %t261 = select i1 %t260, %SourceSpan* %t259, %SourceSpan* %t254
  %t262 = getelementptr inbounds %Statement, %Statement* %t240, i32 0, i32 1
  %t263 = bitcast [40 x i8]* %t262 to i8*
  %t264 = getelementptr inbounds i8, i8* %t263, i64 8
  %t265 = bitcast i8* %t264 to %SourceSpan**
  %t266 = load %SourceSpan*, %SourceSpan** %t265
  %t267 = icmp eq i32 %t239, 9
  %t268 = select i1 %t267, %SourceSpan* %t266, %SourceSpan* %t261
  %t269 = getelementptr inbounds %Statement, %Statement* %t240, i32 0, i32 1
  %t270 = bitcast [40 x i8]* %t269 to i8*
  %t271 = getelementptr inbounds i8, i8* %t270, i64 8
  %t272 = bitcast i8* %t271 to %SourceSpan**
  %t273 = load %SourceSpan*, %SourceSpan** %t272
  %t274 = icmp eq i32 %t239, 10
  %t275 = select i1 %t274, %SourceSpan* %t273, %SourceSpan* %t268
  %t276 = getelementptr inbounds %Statement, %Statement* %t240, i32 0, i32 1
  %t277 = bitcast [40 x i8]* %t276 to i8*
  %t278 = getelementptr inbounds i8, i8* %t277, i64 8
  %t279 = bitcast i8* %t278 to %SourceSpan**
  %t280 = load %SourceSpan*, %SourceSpan** %t279
  %t281 = icmp eq i32 %t239, 11
  %t282 = select i1 %t281, %SourceSpan* %t280, %SourceSpan* %t275
  %t283 = call %SymbolCollectionResult @register_symbol(i8* %t236, i8* %t237, %SourceSpan* %t282, { %SymbolEntry*, i64 }* %existing)
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
  %t355 = call i8* @malloc(i64 16)
  %t356 = bitcast i8* %t355 to [16 x i8]*
  store [16 x i8] c"EnumDeclaration\00", [16 x i8]* %t356
  %t357 = call i1 @strings_equal(i8* %t354, i8* %t355)
  br i1 %t357, label %then4, label %merge5
then4:
  %t358 = extractvalue %Statement %statement, 0
  %t359 = alloca %Statement
  store %Statement %statement, %Statement* %t359
  %t360 = getelementptr inbounds %Statement, %Statement* %t359, i32 0, i32 1
  %t361 = bitcast [48 x i8]* %t360 to i8*
  %t362 = bitcast i8* %t361 to i8**
  %t363 = load i8*, i8** %t362
  %t364 = icmp eq i32 %t358, 2
  %t365 = select i1 %t364, i8* %t363, i8* null
  %t366 = getelementptr inbounds %Statement, %Statement* %t359, i32 0, i32 1
  %t367 = bitcast [48 x i8]* %t366 to i8*
  %t368 = bitcast i8* %t367 to i8**
  %t369 = load i8*, i8** %t368
  %t370 = icmp eq i32 %t358, 3
  %t371 = select i1 %t370, i8* %t369, i8* %t365
  %t372 = getelementptr inbounds %Statement, %Statement* %t359, i32 0, i32 1
  %t373 = bitcast [56 x i8]* %t372 to i8*
  %t374 = bitcast i8* %t373 to i8**
  %t375 = load i8*, i8** %t374
  %t376 = icmp eq i32 %t358, 6
  %t377 = select i1 %t376, i8* %t375, i8* %t371
  %t378 = getelementptr inbounds %Statement, %Statement* %t359, i32 0, i32 1
  %t379 = bitcast [56 x i8]* %t378 to i8*
  %t380 = bitcast i8* %t379 to i8**
  %t381 = load i8*, i8** %t380
  %t382 = icmp eq i32 %t358, 8
  %t383 = select i1 %t382, i8* %t381, i8* %t377
  %t384 = getelementptr inbounds %Statement, %Statement* %t359, i32 0, i32 1
  %t385 = bitcast [40 x i8]* %t384 to i8*
  %t386 = bitcast i8* %t385 to i8**
  %t387 = load i8*, i8** %t386
  %t388 = icmp eq i32 %t358, 9
  %t389 = select i1 %t388, i8* %t387, i8* %t383
  %t390 = getelementptr inbounds %Statement, %Statement* %t359, i32 0, i32 1
  %t391 = bitcast [40 x i8]* %t390 to i8*
  %t392 = bitcast i8* %t391 to i8**
  %t393 = load i8*, i8** %t392
  %t394 = icmp eq i32 %t358, 10
  %t395 = select i1 %t394, i8* %t393, i8* %t389
  %t396 = getelementptr inbounds %Statement, %Statement* %t359, i32 0, i32 1
  %t397 = bitcast [40 x i8]* %t396 to i8*
  %t398 = bitcast i8* %t397 to i8**
  %t399 = load i8*, i8** %t398
  %t400 = icmp eq i32 %t358, 11
  %t401 = select i1 %t400, i8* %t399, i8* %t395
  %t402 = call i8* @malloc(i64 5)
  %t403 = bitcast i8* %t402 to [5 x i8]*
  store [5 x i8] c"enum\00", [5 x i8]* %t403
  %t404 = extractvalue %Statement %statement, 0
  %t405 = alloca %Statement
  store %Statement %statement, %Statement* %t405
  %t406 = getelementptr inbounds %Statement, %Statement* %t405, i32 0, i32 1
  %t407 = bitcast [48 x i8]* %t406 to i8*
  %t408 = getelementptr inbounds i8, i8* %t407, i64 8
  %t409 = bitcast i8* %t408 to %SourceSpan**
  %t410 = load %SourceSpan*, %SourceSpan** %t409
  %t411 = icmp eq i32 %t404, 3
  %t412 = select i1 %t411, %SourceSpan* %t410, %SourceSpan* null
  %t413 = getelementptr inbounds %Statement, %Statement* %t405, i32 0, i32 1
  %t414 = bitcast [56 x i8]* %t413 to i8*
  %t415 = getelementptr inbounds i8, i8* %t414, i64 8
  %t416 = bitcast i8* %t415 to %SourceSpan**
  %t417 = load %SourceSpan*, %SourceSpan** %t416
  %t418 = icmp eq i32 %t404, 6
  %t419 = select i1 %t418, %SourceSpan* %t417, %SourceSpan* %t412
  %t420 = getelementptr inbounds %Statement, %Statement* %t405, i32 0, i32 1
  %t421 = bitcast [56 x i8]* %t420 to i8*
  %t422 = getelementptr inbounds i8, i8* %t421, i64 8
  %t423 = bitcast i8* %t422 to %SourceSpan**
  %t424 = load %SourceSpan*, %SourceSpan** %t423
  %t425 = icmp eq i32 %t404, 8
  %t426 = select i1 %t425, %SourceSpan* %t424, %SourceSpan* %t419
  %t427 = getelementptr inbounds %Statement, %Statement* %t405, i32 0, i32 1
  %t428 = bitcast [40 x i8]* %t427 to i8*
  %t429 = getelementptr inbounds i8, i8* %t428, i64 8
  %t430 = bitcast i8* %t429 to %SourceSpan**
  %t431 = load %SourceSpan*, %SourceSpan** %t430
  %t432 = icmp eq i32 %t404, 9
  %t433 = select i1 %t432, %SourceSpan* %t431, %SourceSpan* %t426
  %t434 = getelementptr inbounds %Statement, %Statement* %t405, i32 0, i32 1
  %t435 = bitcast [40 x i8]* %t434 to i8*
  %t436 = getelementptr inbounds i8, i8* %t435, i64 8
  %t437 = bitcast i8* %t436 to %SourceSpan**
  %t438 = load %SourceSpan*, %SourceSpan** %t437
  %t439 = icmp eq i32 %t404, 10
  %t440 = select i1 %t439, %SourceSpan* %t438, %SourceSpan* %t433
  %t441 = getelementptr inbounds %Statement, %Statement* %t405, i32 0, i32 1
  %t442 = bitcast [40 x i8]* %t441 to i8*
  %t443 = getelementptr inbounds i8, i8* %t442, i64 8
  %t444 = bitcast i8* %t443 to %SourceSpan**
  %t445 = load %SourceSpan*, %SourceSpan** %t444
  %t446 = icmp eq i32 %t404, 11
  %t447 = select i1 %t446, %SourceSpan* %t445, %SourceSpan* %t440
  %t448 = call %SymbolCollectionResult @register_symbol(i8* %t401, i8* %t402, %SourceSpan* %t447, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t448
merge5:
  %t449 = extractvalue %Statement %statement, 0
  %t450 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t451 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t452 = icmp eq i32 %t449, 0
  %t453 = select i1 %t452, i8* %t451, i8* %t450
  %t454 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t455 = icmp eq i32 %t449, 1
  %t456 = select i1 %t455, i8* %t454, i8* %t453
  %t457 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t458 = icmp eq i32 %t449, 2
  %t459 = select i1 %t458, i8* %t457, i8* %t456
  %t460 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t461 = icmp eq i32 %t449, 3
  %t462 = select i1 %t461, i8* %t460, i8* %t459
  %t463 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t464 = icmp eq i32 %t449, 4
  %t465 = select i1 %t464, i8* %t463, i8* %t462
  %t466 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t467 = icmp eq i32 %t449, 5
  %t468 = select i1 %t467, i8* %t466, i8* %t465
  %t469 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t470 = icmp eq i32 %t449, 6
  %t471 = select i1 %t470, i8* %t469, i8* %t468
  %t472 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t473 = icmp eq i32 %t449, 7
  %t474 = select i1 %t473, i8* %t472, i8* %t471
  %t475 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t476 = icmp eq i32 %t449, 8
  %t477 = select i1 %t476, i8* %t475, i8* %t474
  %t478 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t479 = icmp eq i32 %t449, 9
  %t480 = select i1 %t479, i8* %t478, i8* %t477
  %t481 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t482 = icmp eq i32 %t449, 10
  %t483 = select i1 %t482, i8* %t481, i8* %t480
  %t484 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t485 = icmp eq i32 %t449, 11
  %t486 = select i1 %t485, i8* %t484, i8* %t483
  %t487 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t488 = icmp eq i32 %t449, 12
  %t489 = select i1 %t488, i8* %t487, i8* %t486
  %t490 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t491 = icmp eq i32 %t449, 13
  %t492 = select i1 %t491, i8* %t490, i8* %t489
  %t493 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t494 = icmp eq i32 %t449, 14
  %t495 = select i1 %t494, i8* %t493, i8* %t492
  %t496 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t497 = icmp eq i32 %t449, 15
  %t498 = select i1 %t497, i8* %t496, i8* %t495
  %t499 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t500 = icmp eq i32 %t449, 16
  %t501 = select i1 %t500, i8* %t499, i8* %t498
  %t502 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t503 = icmp eq i32 %t449, 17
  %t504 = select i1 %t503, i8* %t502, i8* %t501
  %t505 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t506 = icmp eq i32 %t449, 18
  %t507 = select i1 %t506, i8* %t505, i8* %t504
  %t508 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t509 = icmp eq i32 %t449, 19
  %t510 = select i1 %t509, i8* %t508, i8* %t507
  %t511 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t512 = icmp eq i32 %t449, 20
  %t513 = select i1 %t512, i8* %t511, i8* %t510
  %t514 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t515 = icmp eq i32 %t449, 21
  %t516 = select i1 %t515, i8* %t514, i8* %t513
  %t517 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t518 = icmp eq i32 %t449, 22
  %t519 = select i1 %t518, i8* %t517, i8* %t516
  %t520 = call i8* @malloc(i64 21)
  %t521 = bitcast i8* %t520 to [21 x i8]*
  store [21 x i8] c"InterfaceDeclaration\00", [21 x i8]* %t521
  %t522 = call i1 @strings_equal(i8* %t519, i8* %t520)
  br i1 %t522, label %then6, label %merge7
then6:
  %t523 = extractvalue %Statement %statement, 0
  %t524 = alloca %Statement
  store %Statement %statement, %Statement* %t524
  %t525 = getelementptr inbounds %Statement, %Statement* %t524, i32 0, i32 1
  %t526 = bitcast [48 x i8]* %t525 to i8*
  %t527 = bitcast i8* %t526 to i8**
  %t528 = load i8*, i8** %t527
  %t529 = icmp eq i32 %t523, 2
  %t530 = select i1 %t529, i8* %t528, i8* null
  %t531 = getelementptr inbounds %Statement, %Statement* %t524, i32 0, i32 1
  %t532 = bitcast [48 x i8]* %t531 to i8*
  %t533 = bitcast i8* %t532 to i8**
  %t534 = load i8*, i8** %t533
  %t535 = icmp eq i32 %t523, 3
  %t536 = select i1 %t535, i8* %t534, i8* %t530
  %t537 = getelementptr inbounds %Statement, %Statement* %t524, i32 0, i32 1
  %t538 = bitcast [56 x i8]* %t537 to i8*
  %t539 = bitcast i8* %t538 to i8**
  %t540 = load i8*, i8** %t539
  %t541 = icmp eq i32 %t523, 6
  %t542 = select i1 %t541, i8* %t540, i8* %t536
  %t543 = getelementptr inbounds %Statement, %Statement* %t524, i32 0, i32 1
  %t544 = bitcast [56 x i8]* %t543 to i8*
  %t545 = bitcast i8* %t544 to i8**
  %t546 = load i8*, i8** %t545
  %t547 = icmp eq i32 %t523, 8
  %t548 = select i1 %t547, i8* %t546, i8* %t542
  %t549 = getelementptr inbounds %Statement, %Statement* %t524, i32 0, i32 1
  %t550 = bitcast [40 x i8]* %t549 to i8*
  %t551 = bitcast i8* %t550 to i8**
  %t552 = load i8*, i8** %t551
  %t553 = icmp eq i32 %t523, 9
  %t554 = select i1 %t553, i8* %t552, i8* %t548
  %t555 = getelementptr inbounds %Statement, %Statement* %t524, i32 0, i32 1
  %t556 = bitcast [40 x i8]* %t555 to i8*
  %t557 = bitcast i8* %t556 to i8**
  %t558 = load i8*, i8** %t557
  %t559 = icmp eq i32 %t523, 10
  %t560 = select i1 %t559, i8* %t558, i8* %t554
  %t561 = getelementptr inbounds %Statement, %Statement* %t524, i32 0, i32 1
  %t562 = bitcast [40 x i8]* %t561 to i8*
  %t563 = bitcast i8* %t562 to i8**
  %t564 = load i8*, i8** %t563
  %t565 = icmp eq i32 %t523, 11
  %t566 = select i1 %t565, i8* %t564, i8* %t560
  %t567 = call i8* @malloc(i64 10)
  %t568 = bitcast i8* %t567 to [10 x i8]*
  store [10 x i8] c"interface\00", [10 x i8]* %t568
  %t569 = extractvalue %Statement %statement, 0
  %t570 = alloca %Statement
  store %Statement %statement, %Statement* %t570
  %t571 = getelementptr inbounds %Statement, %Statement* %t570, i32 0, i32 1
  %t572 = bitcast [48 x i8]* %t571 to i8*
  %t573 = getelementptr inbounds i8, i8* %t572, i64 8
  %t574 = bitcast i8* %t573 to %SourceSpan**
  %t575 = load %SourceSpan*, %SourceSpan** %t574
  %t576 = icmp eq i32 %t569, 3
  %t577 = select i1 %t576, %SourceSpan* %t575, %SourceSpan* null
  %t578 = getelementptr inbounds %Statement, %Statement* %t570, i32 0, i32 1
  %t579 = bitcast [56 x i8]* %t578 to i8*
  %t580 = getelementptr inbounds i8, i8* %t579, i64 8
  %t581 = bitcast i8* %t580 to %SourceSpan**
  %t582 = load %SourceSpan*, %SourceSpan** %t581
  %t583 = icmp eq i32 %t569, 6
  %t584 = select i1 %t583, %SourceSpan* %t582, %SourceSpan* %t577
  %t585 = getelementptr inbounds %Statement, %Statement* %t570, i32 0, i32 1
  %t586 = bitcast [56 x i8]* %t585 to i8*
  %t587 = getelementptr inbounds i8, i8* %t586, i64 8
  %t588 = bitcast i8* %t587 to %SourceSpan**
  %t589 = load %SourceSpan*, %SourceSpan** %t588
  %t590 = icmp eq i32 %t569, 8
  %t591 = select i1 %t590, %SourceSpan* %t589, %SourceSpan* %t584
  %t592 = getelementptr inbounds %Statement, %Statement* %t570, i32 0, i32 1
  %t593 = bitcast [40 x i8]* %t592 to i8*
  %t594 = getelementptr inbounds i8, i8* %t593, i64 8
  %t595 = bitcast i8* %t594 to %SourceSpan**
  %t596 = load %SourceSpan*, %SourceSpan** %t595
  %t597 = icmp eq i32 %t569, 9
  %t598 = select i1 %t597, %SourceSpan* %t596, %SourceSpan* %t591
  %t599 = getelementptr inbounds %Statement, %Statement* %t570, i32 0, i32 1
  %t600 = bitcast [40 x i8]* %t599 to i8*
  %t601 = getelementptr inbounds i8, i8* %t600, i64 8
  %t602 = bitcast i8* %t601 to %SourceSpan**
  %t603 = load %SourceSpan*, %SourceSpan** %t602
  %t604 = icmp eq i32 %t569, 10
  %t605 = select i1 %t604, %SourceSpan* %t603, %SourceSpan* %t598
  %t606 = getelementptr inbounds %Statement, %Statement* %t570, i32 0, i32 1
  %t607 = bitcast [40 x i8]* %t606 to i8*
  %t608 = getelementptr inbounds i8, i8* %t607, i64 8
  %t609 = bitcast i8* %t608 to %SourceSpan**
  %t610 = load %SourceSpan*, %SourceSpan** %t609
  %t611 = icmp eq i32 %t569, 11
  %t612 = select i1 %t611, %SourceSpan* %t610, %SourceSpan* %t605
  %t613 = call %SymbolCollectionResult @register_symbol(i8* %t566, i8* %t567, %SourceSpan* %t612, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t613
merge7:
  %t614 = extractvalue %Statement %statement, 0
  %t615 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t616 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t617 = icmp eq i32 %t614, 0
  %t618 = select i1 %t617, i8* %t616, i8* %t615
  %t619 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t620 = icmp eq i32 %t614, 1
  %t621 = select i1 %t620, i8* %t619, i8* %t618
  %t622 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t623 = icmp eq i32 %t614, 2
  %t624 = select i1 %t623, i8* %t622, i8* %t621
  %t625 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t626 = icmp eq i32 %t614, 3
  %t627 = select i1 %t626, i8* %t625, i8* %t624
  %t628 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t629 = icmp eq i32 %t614, 4
  %t630 = select i1 %t629, i8* %t628, i8* %t627
  %t631 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t632 = icmp eq i32 %t614, 5
  %t633 = select i1 %t632, i8* %t631, i8* %t630
  %t634 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t635 = icmp eq i32 %t614, 6
  %t636 = select i1 %t635, i8* %t634, i8* %t633
  %t637 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t638 = icmp eq i32 %t614, 7
  %t639 = select i1 %t638, i8* %t637, i8* %t636
  %t640 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t641 = icmp eq i32 %t614, 8
  %t642 = select i1 %t641, i8* %t640, i8* %t639
  %t643 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t644 = icmp eq i32 %t614, 9
  %t645 = select i1 %t644, i8* %t643, i8* %t642
  %t646 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t647 = icmp eq i32 %t614, 10
  %t648 = select i1 %t647, i8* %t646, i8* %t645
  %t649 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t650 = icmp eq i32 %t614, 11
  %t651 = select i1 %t650, i8* %t649, i8* %t648
  %t652 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t653 = icmp eq i32 %t614, 12
  %t654 = select i1 %t653, i8* %t652, i8* %t651
  %t655 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t656 = icmp eq i32 %t614, 13
  %t657 = select i1 %t656, i8* %t655, i8* %t654
  %t658 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t659 = icmp eq i32 %t614, 14
  %t660 = select i1 %t659, i8* %t658, i8* %t657
  %t661 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t662 = icmp eq i32 %t614, 15
  %t663 = select i1 %t662, i8* %t661, i8* %t660
  %t664 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t665 = icmp eq i32 %t614, 16
  %t666 = select i1 %t665, i8* %t664, i8* %t663
  %t667 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t668 = icmp eq i32 %t614, 17
  %t669 = select i1 %t668, i8* %t667, i8* %t666
  %t670 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t671 = icmp eq i32 %t614, 18
  %t672 = select i1 %t671, i8* %t670, i8* %t669
  %t673 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t674 = icmp eq i32 %t614, 19
  %t675 = select i1 %t674, i8* %t673, i8* %t672
  %t676 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t677 = icmp eq i32 %t614, 20
  %t678 = select i1 %t677, i8* %t676, i8* %t675
  %t679 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t680 = icmp eq i32 %t614, 21
  %t681 = select i1 %t680, i8* %t679, i8* %t678
  %t682 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t683 = icmp eq i32 %t614, 22
  %t684 = select i1 %t683, i8* %t682, i8* %t681
  %t685 = call i8* @malloc(i64 17)
  %t686 = bitcast i8* %t685 to [17 x i8]*
  store [17 x i8] c"ModelDeclaration\00", [17 x i8]* %t686
  %t687 = call i1 @strings_equal(i8* %t684, i8* %t685)
  br i1 %t687, label %then8, label %merge9
then8:
  %t688 = extractvalue %Statement %statement, 0
  %t689 = alloca %Statement
  store %Statement %statement, %Statement* %t689
  %t690 = getelementptr inbounds %Statement, %Statement* %t689, i32 0, i32 1
  %t691 = bitcast [48 x i8]* %t690 to i8*
  %t692 = bitcast i8* %t691 to i8**
  %t693 = load i8*, i8** %t692
  %t694 = icmp eq i32 %t688, 2
  %t695 = select i1 %t694, i8* %t693, i8* null
  %t696 = getelementptr inbounds %Statement, %Statement* %t689, i32 0, i32 1
  %t697 = bitcast [48 x i8]* %t696 to i8*
  %t698 = bitcast i8* %t697 to i8**
  %t699 = load i8*, i8** %t698
  %t700 = icmp eq i32 %t688, 3
  %t701 = select i1 %t700, i8* %t699, i8* %t695
  %t702 = getelementptr inbounds %Statement, %Statement* %t689, i32 0, i32 1
  %t703 = bitcast [56 x i8]* %t702 to i8*
  %t704 = bitcast i8* %t703 to i8**
  %t705 = load i8*, i8** %t704
  %t706 = icmp eq i32 %t688, 6
  %t707 = select i1 %t706, i8* %t705, i8* %t701
  %t708 = getelementptr inbounds %Statement, %Statement* %t689, i32 0, i32 1
  %t709 = bitcast [56 x i8]* %t708 to i8*
  %t710 = bitcast i8* %t709 to i8**
  %t711 = load i8*, i8** %t710
  %t712 = icmp eq i32 %t688, 8
  %t713 = select i1 %t712, i8* %t711, i8* %t707
  %t714 = getelementptr inbounds %Statement, %Statement* %t689, i32 0, i32 1
  %t715 = bitcast [40 x i8]* %t714 to i8*
  %t716 = bitcast i8* %t715 to i8**
  %t717 = load i8*, i8** %t716
  %t718 = icmp eq i32 %t688, 9
  %t719 = select i1 %t718, i8* %t717, i8* %t713
  %t720 = getelementptr inbounds %Statement, %Statement* %t689, i32 0, i32 1
  %t721 = bitcast [40 x i8]* %t720 to i8*
  %t722 = bitcast i8* %t721 to i8**
  %t723 = load i8*, i8** %t722
  %t724 = icmp eq i32 %t688, 10
  %t725 = select i1 %t724, i8* %t723, i8* %t719
  %t726 = getelementptr inbounds %Statement, %Statement* %t689, i32 0, i32 1
  %t727 = bitcast [40 x i8]* %t726 to i8*
  %t728 = bitcast i8* %t727 to i8**
  %t729 = load i8*, i8** %t728
  %t730 = icmp eq i32 %t688, 11
  %t731 = select i1 %t730, i8* %t729, i8* %t725
  %t732 = call i8* @malloc(i64 6)
  %t733 = bitcast i8* %t732 to [6 x i8]*
  store [6 x i8] c"model\00", [6 x i8]* %t733
  %t734 = extractvalue %Statement %statement, 0
  %t735 = alloca %Statement
  store %Statement %statement, %Statement* %t735
  %t736 = getelementptr inbounds %Statement, %Statement* %t735, i32 0, i32 1
  %t737 = bitcast [48 x i8]* %t736 to i8*
  %t738 = getelementptr inbounds i8, i8* %t737, i64 8
  %t739 = bitcast i8* %t738 to %SourceSpan**
  %t740 = load %SourceSpan*, %SourceSpan** %t739
  %t741 = icmp eq i32 %t734, 3
  %t742 = select i1 %t741, %SourceSpan* %t740, %SourceSpan* null
  %t743 = getelementptr inbounds %Statement, %Statement* %t735, i32 0, i32 1
  %t744 = bitcast [56 x i8]* %t743 to i8*
  %t745 = getelementptr inbounds i8, i8* %t744, i64 8
  %t746 = bitcast i8* %t745 to %SourceSpan**
  %t747 = load %SourceSpan*, %SourceSpan** %t746
  %t748 = icmp eq i32 %t734, 6
  %t749 = select i1 %t748, %SourceSpan* %t747, %SourceSpan* %t742
  %t750 = getelementptr inbounds %Statement, %Statement* %t735, i32 0, i32 1
  %t751 = bitcast [56 x i8]* %t750 to i8*
  %t752 = getelementptr inbounds i8, i8* %t751, i64 8
  %t753 = bitcast i8* %t752 to %SourceSpan**
  %t754 = load %SourceSpan*, %SourceSpan** %t753
  %t755 = icmp eq i32 %t734, 8
  %t756 = select i1 %t755, %SourceSpan* %t754, %SourceSpan* %t749
  %t757 = getelementptr inbounds %Statement, %Statement* %t735, i32 0, i32 1
  %t758 = bitcast [40 x i8]* %t757 to i8*
  %t759 = getelementptr inbounds i8, i8* %t758, i64 8
  %t760 = bitcast i8* %t759 to %SourceSpan**
  %t761 = load %SourceSpan*, %SourceSpan** %t760
  %t762 = icmp eq i32 %t734, 9
  %t763 = select i1 %t762, %SourceSpan* %t761, %SourceSpan* %t756
  %t764 = getelementptr inbounds %Statement, %Statement* %t735, i32 0, i32 1
  %t765 = bitcast [40 x i8]* %t764 to i8*
  %t766 = getelementptr inbounds i8, i8* %t765, i64 8
  %t767 = bitcast i8* %t766 to %SourceSpan**
  %t768 = load %SourceSpan*, %SourceSpan** %t767
  %t769 = icmp eq i32 %t734, 10
  %t770 = select i1 %t769, %SourceSpan* %t768, %SourceSpan* %t763
  %t771 = getelementptr inbounds %Statement, %Statement* %t735, i32 0, i32 1
  %t772 = bitcast [40 x i8]* %t771 to i8*
  %t773 = getelementptr inbounds i8, i8* %t772, i64 8
  %t774 = bitcast i8* %t773 to %SourceSpan**
  %t775 = load %SourceSpan*, %SourceSpan** %t774
  %t776 = icmp eq i32 %t734, 11
  %t777 = select i1 %t776, %SourceSpan* %t775, %SourceSpan* %t770
  %t778 = call %SymbolCollectionResult @register_symbol(i8* %t731, i8* %t732, %SourceSpan* %t777, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t778
merge9:
  %t779 = extractvalue %Statement %statement, 0
  %t780 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t781 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t782 = icmp eq i32 %t779, 0
  %t783 = select i1 %t782, i8* %t781, i8* %t780
  %t784 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t785 = icmp eq i32 %t779, 1
  %t786 = select i1 %t785, i8* %t784, i8* %t783
  %t787 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t788 = icmp eq i32 %t779, 2
  %t789 = select i1 %t788, i8* %t787, i8* %t786
  %t790 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t791 = icmp eq i32 %t779, 3
  %t792 = select i1 %t791, i8* %t790, i8* %t789
  %t793 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t794 = icmp eq i32 %t779, 4
  %t795 = select i1 %t794, i8* %t793, i8* %t792
  %t796 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t797 = icmp eq i32 %t779, 5
  %t798 = select i1 %t797, i8* %t796, i8* %t795
  %t799 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t800 = icmp eq i32 %t779, 6
  %t801 = select i1 %t800, i8* %t799, i8* %t798
  %t802 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t803 = icmp eq i32 %t779, 7
  %t804 = select i1 %t803, i8* %t802, i8* %t801
  %t805 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t806 = icmp eq i32 %t779, 8
  %t807 = select i1 %t806, i8* %t805, i8* %t804
  %t808 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t809 = icmp eq i32 %t779, 9
  %t810 = select i1 %t809, i8* %t808, i8* %t807
  %t811 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t812 = icmp eq i32 %t779, 10
  %t813 = select i1 %t812, i8* %t811, i8* %t810
  %t814 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t815 = icmp eq i32 %t779, 11
  %t816 = select i1 %t815, i8* %t814, i8* %t813
  %t817 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t818 = icmp eq i32 %t779, 12
  %t819 = select i1 %t818, i8* %t817, i8* %t816
  %t820 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t821 = icmp eq i32 %t779, 13
  %t822 = select i1 %t821, i8* %t820, i8* %t819
  %t823 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t824 = icmp eq i32 %t779, 14
  %t825 = select i1 %t824, i8* %t823, i8* %t822
  %t826 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t827 = icmp eq i32 %t779, 15
  %t828 = select i1 %t827, i8* %t826, i8* %t825
  %t829 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t830 = icmp eq i32 %t779, 16
  %t831 = select i1 %t830, i8* %t829, i8* %t828
  %t832 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t833 = icmp eq i32 %t779, 17
  %t834 = select i1 %t833, i8* %t832, i8* %t831
  %t835 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t836 = icmp eq i32 %t779, 18
  %t837 = select i1 %t836, i8* %t835, i8* %t834
  %t838 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t839 = icmp eq i32 %t779, 19
  %t840 = select i1 %t839, i8* %t838, i8* %t837
  %t841 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t842 = icmp eq i32 %t779, 20
  %t843 = select i1 %t842, i8* %t841, i8* %t840
  %t844 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t845 = icmp eq i32 %t779, 21
  %t846 = select i1 %t845, i8* %t844, i8* %t843
  %t847 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t848 = icmp eq i32 %t779, 22
  %t849 = select i1 %t848, i8* %t847, i8* %t846
  %t850 = call i8* @malloc(i64 20)
  %t851 = bitcast i8* %t850 to [20 x i8]*
  store [20 x i8] c"PipelineDeclaration\00", [20 x i8]* %t851
  %t852 = call i1 @strings_equal(i8* %t849, i8* %t850)
  br i1 %t852, label %then10, label %merge11
then10:
  %t853 = extractvalue %Statement %statement, 0
  %t854 = alloca %Statement
  store %Statement %statement, %Statement* %t854
  %t855 = getelementptr inbounds %Statement, %Statement* %t854, i32 0, i32 1
  %t856 = bitcast [88 x i8]* %t855 to i8*
  %t857 = bitcast i8* %t856 to %FunctionSignature*
  %t858 = load %FunctionSignature, %FunctionSignature* %t857
  %t859 = icmp eq i32 %t853, 4
  %t860 = select i1 %t859, %FunctionSignature %t858, %FunctionSignature zeroinitializer
  %t861 = getelementptr inbounds %Statement, %Statement* %t854, i32 0, i32 1
  %t862 = bitcast [88 x i8]* %t861 to i8*
  %t863 = bitcast i8* %t862 to %FunctionSignature*
  %t864 = load %FunctionSignature, %FunctionSignature* %t863
  %t865 = icmp eq i32 %t853, 5
  %t866 = select i1 %t865, %FunctionSignature %t864, %FunctionSignature %t860
  %t867 = getelementptr inbounds %Statement, %Statement* %t854, i32 0, i32 1
  %t868 = bitcast [88 x i8]* %t867 to i8*
  %t869 = bitcast i8* %t868 to %FunctionSignature*
  %t870 = load %FunctionSignature, %FunctionSignature* %t869
  %t871 = icmp eq i32 %t853, 7
  %t872 = select i1 %t871, %FunctionSignature %t870, %FunctionSignature %t866
  %t873 = extractvalue %FunctionSignature %t872, 0
  %t874 = call i8* @malloc(i64 9)
  %t875 = bitcast i8* %t874 to [9 x i8]*
  store [9 x i8] c"pipeline\00", [9 x i8]* %t875
  %t876 = extractvalue %Statement %statement, 0
  %t877 = alloca %Statement
  store %Statement %statement, %Statement* %t877
  %t878 = getelementptr inbounds %Statement, %Statement* %t877, i32 0, i32 1
  %t879 = bitcast [88 x i8]* %t878 to i8*
  %t880 = bitcast i8* %t879 to %FunctionSignature*
  %t881 = load %FunctionSignature, %FunctionSignature* %t880
  %t882 = icmp eq i32 %t876, 4
  %t883 = select i1 %t882, %FunctionSignature %t881, %FunctionSignature zeroinitializer
  %t884 = getelementptr inbounds %Statement, %Statement* %t877, i32 0, i32 1
  %t885 = bitcast [88 x i8]* %t884 to i8*
  %t886 = bitcast i8* %t885 to %FunctionSignature*
  %t887 = load %FunctionSignature, %FunctionSignature* %t886
  %t888 = icmp eq i32 %t876, 5
  %t889 = select i1 %t888, %FunctionSignature %t887, %FunctionSignature %t883
  %t890 = getelementptr inbounds %Statement, %Statement* %t877, i32 0, i32 1
  %t891 = bitcast [88 x i8]* %t890 to i8*
  %t892 = bitcast i8* %t891 to %FunctionSignature*
  %t893 = load %FunctionSignature, %FunctionSignature* %t892
  %t894 = icmp eq i32 %t876, 7
  %t895 = select i1 %t894, %FunctionSignature %t893, %FunctionSignature %t889
  %t896 = extractvalue %FunctionSignature %t895, 6
  %t897 = call %SymbolCollectionResult @register_symbol(i8* %t873, i8* %t874, %SourceSpan* %t896, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t897
merge11:
  %t898 = extractvalue %Statement %statement, 0
  %t899 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t900 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t901 = icmp eq i32 %t898, 0
  %t902 = select i1 %t901, i8* %t900, i8* %t899
  %t903 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t904 = icmp eq i32 %t898, 1
  %t905 = select i1 %t904, i8* %t903, i8* %t902
  %t906 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t907 = icmp eq i32 %t898, 2
  %t908 = select i1 %t907, i8* %t906, i8* %t905
  %t909 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t910 = icmp eq i32 %t898, 3
  %t911 = select i1 %t910, i8* %t909, i8* %t908
  %t912 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t913 = icmp eq i32 %t898, 4
  %t914 = select i1 %t913, i8* %t912, i8* %t911
  %t915 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t916 = icmp eq i32 %t898, 5
  %t917 = select i1 %t916, i8* %t915, i8* %t914
  %t918 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t919 = icmp eq i32 %t898, 6
  %t920 = select i1 %t919, i8* %t918, i8* %t917
  %t921 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t922 = icmp eq i32 %t898, 7
  %t923 = select i1 %t922, i8* %t921, i8* %t920
  %t924 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t925 = icmp eq i32 %t898, 8
  %t926 = select i1 %t925, i8* %t924, i8* %t923
  %t927 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t928 = icmp eq i32 %t898, 9
  %t929 = select i1 %t928, i8* %t927, i8* %t926
  %t930 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t931 = icmp eq i32 %t898, 10
  %t932 = select i1 %t931, i8* %t930, i8* %t929
  %t933 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t934 = icmp eq i32 %t898, 11
  %t935 = select i1 %t934, i8* %t933, i8* %t932
  %t936 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t937 = icmp eq i32 %t898, 12
  %t938 = select i1 %t937, i8* %t936, i8* %t935
  %t939 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t940 = icmp eq i32 %t898, 13
  %t941 = select i1 %t940, i8* %t939, i8* %t938
  %t942 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t943 = icmp eq i32 %t898, 14
  %t944 = select i1 %t943, i8* %t942, i8* %t941
  %t945 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t946 = icmp eq i32 %t898, 15
  %t947 = select i1 %t946, i8* %t945, i8* %t944
  %t948 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t949 = icmp eq i32 %t898, 16
  %t950 = select i1 %t949, i8* %t948, i8* %t947
  %t951 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t952 = icmp eq i32 %t898, 17
  %t953 = select i1 %t952, i8* %t951, i8* %t950
  %t954 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t955 = icmp eq i32 %t898, 18
  %t956 = select i1 %t955, i8* %t954, i8* %t953
  %t957 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t958 = icmp eq i32 %t898, 19
  %t959 = select i1 %t958, i8* %t957, i8* %t956
  %t960 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t961 = icmp eq i32 %t898, 20
  %t962 = select i1 %t961, i8* %t960, i8* %t959
  %t963 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t964 = icmp eq i32 %t898, 21
  %t965 = select i1 %t964, i8* %t963, i8* %t962
  %t966 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t967 = icmp eq i32 %t898, 22
  %t968 = select i1 %t967, i8* %t966, i8* %t965
  %t969 = call i8* @malloc(i64 16)
  %t970 = bitcast i8* %t969 to [16 x i8]*
  store [16 x i8] c"ToolDeclaration\00", [16 x i8]* %t970
  %t971 = call i1 @strings_equal(i8* %t968, i8* %t969)
  br i1 %t971, label %then12, label %merge13
then12:
  %t972 = extractvalue %Statement %statement, 0
  %t973 = alloca %Statement
  store %Statement %statement, %Statement* %t973
  %t974 = getelementptr inbounds %Statement, %Statement* %t973, i32 0, i32 1
  %t975 = bitcast [88 x i8]* %t974 to i8*
  %t976 = bitcast i8* %t975 to %FunctionSignature*
  %t977 = load %FunctionSignature, %FunctionSignature* %t976
  %t978 = icmp eq i32 %t972, 4
  %t979 = select i1 %t978, %FunctionSignature %t977, %FunctionSignature zeroinitializer
  %t980 = getelementptr inbounds %Statement, %Statement* %t973, i32 0, i32 1
  %t981 = bitcast [88 x i8]* %t980 to i8*
  %t982 = bitcast i8* %t981 to %FunctionSignature*
  %t983 = load %FunctionSignature, %FunctionSignature* %t982
  %t984 = icmp eq i32 %t972, 5
  %t985 = select i1 %t984, %FunctionSignature %t983, %FunctionSignature %t979
  %t986 = getelementptr inbounds %Statement, %Statement* %t973, i32 0, i32 1
  %t987 = bitcast [88 x i8]* %t986 to i8*
  %t988 = bitcast i8* %t987 to %FunctionSignature*
  %t989 = load %FunctionSignature, %FunctionSignature* %t988
  %t990 = icmp eq i32 %t972, 7
  %t991 = select i1 %t990, %FunctionSignature %t989, %FunctionSignature %t985
  %t992 = extractvalue %FunctionSignature %t991, 0
  %t993 = call i8* @malloc(i64 5)
  %t994 = bitcast i8* %t993 to [5 x i8]*
  store [5 x i8] c"tool\00", [5 x i8]* %t994
  %t995 = extractvalue %Statement %statement, 0
  %t996 = alloca %Statement
  store %Statement %statement, %Statement* %t996
  %t997 = getelementptr inbounds %Statement, %Statement* %t996, i32 0, i32 1
  %t998 = bitcast [88 x i8]* %t997 to i8*
  %t999 = bitcast i8* %t998 to %FunctionSignature*
  %t1000 = load %FunctionSignature, %FunctionSignature* %t999
  %t1001 = icmp eq i32 %t995, 4
  %t1002 = select i1 %t1001, %FunctionSignature %t1000, %FunctionSignature zeroinitializer
  %t1003 = getelementptr inbounds %Statement, %Statement* %t996, i32 0, i32 1
  %t1004 = bitcast [88 x i8]* %t1003 to i8*
  %t1005 = bitcast i8* %t1004 to %FunctionSignature*
  %t1006 = load %FunctionSignature, %FunctionSignature* %t1005
  %t1007 = icmp eq i32 %t995, 5
  %t1008 = select i1 %t1007, %FunctionSignature %t1006, %FunctionSignature %t1002
  %t1009 = getelementptr inbounds %Statement, %Statement* %t996, i32 0, i32 1
  %t1010 = bitcast [88 x i8]* %t1009 to i8*
  %t1011 = bitcast i8* %t1010 to %FunctionSignature*
  %t1012 = load %FunctionSignature, %FunctionSignature* %t1011
  %t1013 = icmp eq i32 %t995, 7
  %t1014 = select i1 %t1013, %FunctionSignature %t1012, %FunctionSignature %t1008
  %t1015 = extractvalue %FunctionSignature %t1014, 6
  %t1016 = call %SymbolCollectionResult @register_symbol(i8* %t992, i8* %t993, %SourceSpan* %t1015, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1016
merge13:
  %t1017 = extractvalue %Statement %statement, 0
  %t1018 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1019 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1020 = icmp eq i32 %t1017, 0
  %t1021 = select i1 %t1020, i8* %t1019, i8* %t1018
  %t1022 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1023 = icmp eq i32 %t1017, 1
  %t1024 = select i1 %t1023, i8* %t1022, i8* %t1021
  %t1025 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1026 = icmp eq i32 %t1017, 2
  %t1027 = select i1 %t1026, i8* %t1025, i8* %t1024
  %t1028 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1029 = icmp eq i32 %t1017, 3
  %t1030 = select i1 %t1029, i8* %t1028, i8* %t1027
  %t1031 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1032 = icmp eq i32 %t1017, 4
  %t1033 = select i1 %t1032, i8* %t1031, i8* %t1030
  %t1034 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1035 = icmp eq i32 %t1017, 5
  %t1036 = select i1 %t1035, i8* %t1034, i8* %t1033
  %t1037 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1038 = icmp eq i32 %t1017, 6
  %t1039 = select i1 %t1038, i8* %t1037, i8* %t1036
  %t1040 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1041 = icmp eq i32 %t1017, 7
  %t1042 = select i1 %t1041, i8* %t1040, i8* %t1039
  %t1043 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1044 = icmp eq i32 %t1017, 8
  %t1045 = select i1 %t1044, i8* %t1043, i8* %t1042
  %t1046 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1047 = icmp eq i32 %t1017, 9
  %t1048 = select i1 %t1047, i8* %t1046, i8* %t1045
  %t1049 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1050 = icmp eq i32 %t1017, 10
  %t1051 = select i1 %t1050, i8* %t1049, i8* %t1048
  %t1052 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1053 = icmp eq i32 %t1017, 11
  %t1054 = select i1 %t1053, i8* %t1052, i8* %t1051
  %t1055 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1056 = icmp eq i32 %t1017, 12
  %t1057 = select i1 %t1056, i8* %t1055, i8* %t1054
  %t1058 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1059 = icmp eq i32 %t1017, 13
  %t1060 = select i1 %t1059, i8* %t1058, i8* %t1057
  %t1061 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1062 = icmp eq i32 %t1017, 14
  %t1063 = select i1 %t1062, i8* %t1061, i8* %t1060
  %t1064 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1065 = icmp eq i32 %t1017, 15
  %t1066 = select i1 %t1065, i8* %t1064, i8* %t1063
  %t1067 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1068 = icmp eq i32 %t1017, 16
  %t1069 = select i1 %t1068, i8* %t1067, i8* %t1066
  %t1070 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1071 = icmp eq i32 %t1017, 17
  %t1072 = select i1 %t1071, i8* %t1070, i8* %t1069
  %t1073 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1074 = icmp eq i32 %t1017, 18
  %t1075 = select i1 %t1074, i8* %t1073, i8* %t1072
  %t1076 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1077 = icmp eq i32 %t1017, 19
  %t1078 = select i1 %t1077, i8* %t1076, i8* %t1075
  %t1079 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1080 = icmp eq i32 %t1017, 20
  %t1081 = select i1 %t1080, i8* %t1079, i8* %t1078
  %t1082 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1083 = icmp eq i32 %t1017, 21
  %t1084 = select i1 %t1083, i8* %t1082, i8* %t1081
  %t1085 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1086 = icmp eq i32 %t1017, 22
  %t1087 = select i1 %t1086, i8* %t1085, i8* %t1084
  %t1088 = call i8* @malloc(i64 16)
  %t1089 = bitcast i8* %t1088 to [16 x i8]*
  store [16 x i8] c"TestDeclaration\00", [16 x i8]* %t1089
  %t1090 = call i1 @strings_equal(i8* %t1087, i8* %t1088)
  br i1 %t1090, label %then14, label %merge15
then14:
  %t1091 = extractvalue %Statement %statement, 0
  %t1092 = alloca %Statement
  store %Statement %statement, %Statement* %t1092
  %t1093 = getelementptr inbounds %Statement, %Statement* %t1092, i32 0, i32 1
  %t1094 = bitcast [48 x i8]* %t1093 to i8*
  %t1095 = bitcast i8* %t1094 to i8**
  %t1096 = load i8*, i8** %t1095
  %t1097 = icmp eq i32 %t1091, 2
  %t1098 = select i1 %t1097, i8* %t1096, i8* null
  %t1099 = getelementptr inbounds %Statement, %Statement* %t1092, i32 0, i32 1
  %t1100 = bitcast [48 x i8]* %t1099 to i8*
  %t1101 = bitcast i8* %t1100 to i8**
  %t1102 = load i8*, i8** %t1101
  %t1103 = icmp eq i32 %t1091, 3
  %t1104 = select i1 %t1103, i8* %t1102, i8* %t1098
  %t1105 = getelementptr inbounds %Statement, %Statement* %t1092, i32 0, i32 1
  %t1106 = bitcast [56 x i8]* %t1105 to i8*
  %t1107 = bitcast i8* %t1106 to i8**
  %t1108 = load i8*, i8** %t1107
  %t1109 = icmp eq i32 %t1091, 6
  %t1110 = select i1 %t1109, i8* %t1108, i8* %t1104
  %t1111 = getelementptr inbounds %Statement, %Statement* %t1092, i32 0, i32 1
  %t1112 = bitcast [56 x i8]* %t1111 to i8*
  %t1113 = bitcast i8* %t1112 to i8**
  %t1114 = load i8*, i8** %t1113
  %t1115 = icmp eq i32 %t1091, 8
  %t1116 = select i1 %t1115, i8* %t1114, i8* %t1110
  %t1117 = getelementptr inbounds %Statement, %Statement* %t1092, i32 0, i32 1
  %t1118 = bitcast [40 x i8]* %t1117 to i8*
  %t1119 = bitcast i8* %t1118 to i8**
  %t1120 = load i8*, i8** %t1119
  %t1121 = icmp eq i32 %t1091, 9
  %t1122 = select i1 %t1121, i8* %t1120, i8* %t1116
  %t1123 = getelementptr inbounds %Statement, %Statement* %t1092, i32 0, i32 1
  %t1124 = bitcast [40 x i8]* %t1123 to i8*
  %t1125 = bitcast i8* %t1124 to i8**
  %t1126 = load i8*, i8** %t1125
  %t1127 = icmp eq i32 %t1091, 10
  %t1128 = select i1 %t1127, i8* %t1126, i8* %t1122
  %t1129 = getelementptr inbounds %Statement, %Statement* %t1092, i32 0, i32 1
  %t1130 = bitcast [40 x i8]* %t1129 to i8*
  %t1131 = bitcast i8* %t1130 to i8**
  %t1132 = load i8*, i8** %t1131
  %t1133 = icmp eq i32 %t1091, 11
  %t1134 = select i1 %t1133, i8* %t1132, i8* %t1128
  %t1135 = call i8* @malloc(i64 5)
  %t1136 = bitcast i8* %t1135 to [5 x i8]*
  store [5 x i8] c"test\00", [5 x i8]* %t1136
  %t1137 = extractvalue %Statement %statement, 0
  %t1138 = alloca %Statement
  store %Statement %statement, %Statement* %t1138
  %t1139 = getelementptr inbounds %Statement, %Statement* %t1138, i32 0, i32 1
  %t1140 = bitcast [48 x i8]* %t1139 to i8*
  %t1141 = getelementptr inbounds i8, i8* %t1140, i64 8
  %t1142 = bitcast i8* %t1141 to %SourceSpan**
  %t1143 = load %SourceSpan*, %SourceSpan** %t1142
  %t1144 = icmp eq i32 %t1137, 3
  %t1145 = select i1 %t1144, %SourceSpan* %t1143, %SourceSpan* null
  %t1146 = getelementptr inbounds %Statement, %Statement* %t1138, i32 0, i32 1
  %t1147 = bitcast [56 x i8]* %t1146 to i8*
  %t1148 = getelementptr inbounds i8, i8* %t1147, i64 8
  %t1149 = bitcast i8* %t1148 to %SourceSpan**
  %t1150 = load %SourceSpan*, %SourceSpan** %t1149
  %t1151 = icmp eq i32 %t1137, 6
  %t1152 = select i1 %t1151, %SourceSpan* %t1150, %SourceSpan* %t1145
  %t1153 = getelementptr inbounds %Statement, %Statement* %t1138, i32 0, i32 1
  %t1154 = bitcast [56 x i8]* %t1153 to i8*
  %t1155 = getelementptr inbounds i8, i8* %t1154, i64 8
  %t1156 = bitcast i8* %t1155 to %SourceSpan**
  %t1157 = load %SourceSpan*, %SourceSpan** %t1156
  %t1158 = icmp eq i32 %t1137, 8
  %t1159 = select i1 %t1158, %SourceSpan* %t1157, %SourceSpan* %t1152
  %t1160 = getelementptr inbounds %Statement, %Statement* %t1138, i32 0, i32 1
  %t1161 = bitcast [40 x i8]* %t1160 to i8*
  %t1162 = getelementptr inbounds i8, i8* %t1161, i64 8
  %t1163 = bitcast i8* %t1162 to %SourceSpan**
  %t1164 = load %SourceSpan*, %SourceSpan** %t1163
  %t1165 = icmp eq i32 %t1137, 9
  %t1166 = select i1 %t1165, %SourceSpan* %t1164, %SourceSpan* %t1159
  %t1167 = getelementptr inbounds %Statement, %Statement* %t1138, i32 0, i32 1
  %t1168 = bitcast [40 x i8]* %t1167 to i8*
  %t1169 = getelementptr inbounds i8, i8* %t1168, i64 8
  %t1170 = bitcast i8* %t1169 to %SourceSpan**
  %t1171 = load %SourceSpan*, %SourceSpan** %t1170
  %t1172 = icmp eq i32 %t1137, 10
  %t1173 = select i1 %t1172, %SourceSpan* %t1171, %SourceSpan* %t1166
  %t1174 = getelementptr inbounds %Statement, %Statement* %t1138, i32 0, i32 1
  %t1175 = bitcast [40 x i8]* %t1174 to i8*
  %t1176 = getelementptr inbounds i8, i8* %t1175, i64 8
  %t1177 = bitcast i8* %t1176 to %SourceSpan**
  %t1178 = load %SourceSpan*, %SourceSpan** %t1177
  %t1179 = icmp eq i32 %t1137, 11
  %t1180 = select i1 %t1179, %SourceSpan* %t1178, %SourceSpan* %t1173
  %t1181 = call %SymbolCollectionResult @register_symbol(i8* %t1134, i8* %t1135, %SourceSpan* %t1180, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1181
merge15:
  %t1182 = extractvalue %Statement %statement, 0
  %t1183 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1184 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1185 = icmp eq i32 %t1182, 0
  %t1186 = select i1 %t1185, i8* %t1184, i8* %t1183
  %t1187 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1188 = icmp eq i32 %t1182, 1
  %t1189 = select i1 %t1188, i8* %t1187, i8* %t1186
  %t1190 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1191 = icmp eq i32 %t1182, 2
  %t1192 = select i1 %t1191, i8* %t1190, i8* %t1189
  %t1193 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1194 = icmp eq i32 %t1182, 3
  %t1195 = select i1 %t1194, i8* %t1193, i8* %t1192
  %t1196 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1197 = icmp eq i32 %t1182, 4
  %t1198 = select i1 %t1197, i8* %t1196, i8* %t1195
  %t1199 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1200 = icmp eq i32 %t1182, 5
  %t1201 = select i1 %t1200, i8* %t1199, i8* %t1198
  %t1202 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1203 = icmp eq i32 %t1182, 6
  %t1204 = select i1 %t1203, i8* %t1202, i8* %t1201
  %t1205 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1206 = icmp eq i32 %t1182, 7
  %t1207 = select i1 %t1206, i8* %t1205, i8* %t1204
  %t1208 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1209 = icmp eq i32 %t1182, 8
  %t1210 = select i1 %t1209, i8* %t1208, i8* %t1207
  %t1211 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1212 = icmp eq i32 %t1182, 9
  %t1213 = select i1 %t1212, i8* %t1211, i8* %t1210
  %t1214 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1215 = icmp eq i32 %t1182, 10
  %t1216 = select i1 %t1215, i8* %t1214, i8* %t1213
  %t1217 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1218 = icmp eq i32 %t1182, 11
  %t1219 = select i1 %t1218, i8* %t1217, i8* %t1216
  %t1220 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1221 = icmp eq i32 %t1182, 12
  %t1222 = select i1 %t1221, i8* %t1220, i8* %t1219
  %t1223 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1224 = icmp eq i32 %t1182, 13
  %t1225 = select i1 %t1224, i8* %t1223, i8* %t1222
  %t1226 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1227 = icmp eq i32 %t1182, 14
  %t1228 = select i1 %t1227, i8* %t1226, i8* %t1225
  %t1229 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1230 = icmp eq i32 %t1182, 15
  %t1231 = select i1 %t1230, i8* %t1229, i8* %t1228
  %t1232 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1233 = icmp eq i32 %t1182, 16
  %t1234 = select i1 %t1233, i8* %t1232, i8* %t1231
  %t1235 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1236 = icmp eq i32 %t1182, 17
  %t1237 = select i1 %t1236, i8* %t1235, i8* %t1234
  %t1238 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1239 = icmp eq i32 %t1182, 18
  %t1240 = select i1 %t1239, i8* %t1238, i8* %t1237
  %t1241 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1242 = icmp eq i32 %t1182, 19
  %t1243 = select i1 %t1242, i8* %t1241, i8* %t1240
  %t1244 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1245 = icmp eq i32 %t1182, 20
  %t1246 = select i1 %t1245, i8* %t1244, i8* %t1243
  %t1247 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1248 = icmp eq i32 %t1182, 21
  %t1249 = select i1 %t1248, i8* %t1247, i8* %t1246
  %t1250 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1251 = icmp eq i32 %t1182, 22
  %t1252 = select i1 %t1251, i8* %t1250, i8* %t1249
  %t1253 = call i8* @malloc(i64 21)
  %t1254 = bitcast i8* %t1253 to [21 x i8]*
  store [21 x i8] c"TypeAliasDeclaration\00", [21 x i8]* %t1254
  %t1255 = call i1 @strings_equal(i8* %t1252, i8* %t1253)
  br i1 %t1255, label %then16, label %merge17
then16:
  %t1256 = extractvalue %Statement %statement, 0
  %t1257 = alloca %Statement
  store %Statement %statement, %Statement* %t1257
  %t1258 = getelementptr inbounds %Statement, %Statement* %t1257, i32 0, i32 1
  %t1259 = bitcast [48 x i8]* %t1258 to i8*
  %t1260 = bitcast i8* %t1259 to i8**
  %t1261 = load i8*, i8** %t1260
  %t1262 = icmp eq i32 %t1256, 2
  %t1263 = select i1 %t1262, i8* %t1261, i8* null
  %t1264 = getelementptr inbounds %Statement, %Statement* %t1257, i32 0, i32 1
  %t1265 = bitcast [48 x i8]* %t1264 to i8*
  %t1266 = bitcast i8* %t1265 to i8**
  %t1267 = load i8*, i8** %t1266
  %t1268 = icmp eq i32 %t1256, 3
  %t1269 = select i1 %t1268, i8* %t1267, i8* %t1263
  %t1270 = getelementptr inbounds %Statement, %Statement* %t1257, i32 0, i32 1
  %t1271 = bitcast [56 x i8]* %t1270 to i8*
  %t1272 = bitcast i8* %t1271 to i8**
  %t1273 = load i8*, i8** %t1272
  %t1274 = icmp eq i32 %t1256, 6
  %t1275 = select i1 %t1274, i8* %t1273, i8* %t1269
  %t1276 = getelementptr inbounds %Statement, %Statement* %t1257, i32 0, i32 1
  %t1277 = bitcast [56 x i8]* %t1276 to i8*
  %t1278 = bitcast i8* %t1277 to i8**
  %t1279 = load i8*, i8** %t1278
  %t1280 = icmp eq i32 %t1256, 8
  %t1281 = select i1 %t1280, i8* %t1279, i8* %t1275
  %t1282 = getelementptr inbounds %Statement, %Statement* %t1257, i32 0, i32 1
  %t1283 = bitcast [40 x i8]* %t1282 to i8*
  %t1284 = bitcast i8* %t1283 to i8**
  %t1285 = load i8*, i8** %t1284
  %t1286 = icmp eq i32 %t1256, 9
  %t1287 = select i1 %t1286, i8* %t1285, i8* %t1281
  %t1288 = getelementptr inbounds %Statement, %Statement* %t1257, i32 0, i32 1
  %t1289 = bitcast [40 x i8]* %t1288 to i8*
  %t1290 = bitcast i8* %t1289 to i8**
  %t1291 = load i8*, i8** %t1290
  %t1292 = icmp eq i32 %t1256, 10
  %t1293 = select i1 %t1292, i8* %t1291, i8* %t1287
  %t1294 = getelementptr inbounds %Statement, %Statement* %t1257, i32 0, i32 1
  %t1295 = bitcast [40 x i8]* %t1294 to i8*
  %t1296 = bitcast i8* %t1295 to i8**
  %t1297 = load i8*, i8** %t1296
  %t1298 = icmp eq i32 %t1256, 11
  %t1299 = select i1 %t1298, i8* %t1297, i8* %t1293
  %t1300 = call i8* @malloc(i64 5)
  %t1301 = bitcast i8* %t1300 to [5 x i8]*
  store [5 x i8] c"type\00", [5 x i8]* %t1301
  %t1302 = extractvalue %Statement %statement, 0
  %t1303 = alloca %Statement
  store %Statement %statement, %Statement* %t1303
  %t1304 = getelementptr inbounds %Statement, %Statement* %t1303, i32 0, i32 1
  %t1305 = bitcast [48 x i8]* %t1304 to i8*
  %t1306 = getelementptr inbounds i8, i8* %t1305, i64 8
  %t1307 = bitcast i8* %t1306 to %SourceSpan**
  %t1308 = load %SourceSpan*, %SourceSpan** %t1307
  %t1309 = icmp eq i32 %t1302, 3
  %t1310 = select i1 %t1309, %SourceSpan* %t1308, %SourceSpan* null
  %t1311 = getelementptr inbounds %Statement, %Statement* %t1303, i32 0, i32 1
  %t1312 = bitcast [56 x i8]* %t1311 to i8*
  %t1313 = getelementptr inbounds i8, i8* %t1312, i64 8
  %t1314 = bitcast i8* %t1313 to %SourceSpan**
  %t1315 = load %SourceSpan*, %SourceSpan** %t1314
  %t1316 = icmp eq i32 %t1302, 6
  %t1317 = select i1 %t1316, %SourceSpan* %t1315, %SourceSpan* %t1310
  %t1318 = getelementptr inbounds %Statement, %Statement* %t1303, i32 0, i32 1
  %t1319 = bitcast [56 x i8]* %t1318 to i8*
  %t1320 = getelementptr inbounds i8, i8* %t1319, i64 8
  %t1321 = bitcast i8* %t1320 to %SourceSpan**
  %t1322 = load %SourceSpan*, %SourceSpan** %t1321
  %t1323 = icmp eq i32 %t1302, 8
  %t1324 = select i1 %t1323, %SourceSpan* %t1322, %SourceSpan* %t1317
  %t1325 = getelementptr inbounds %Statement, %Statement* %t1303, i32 0, i32 1
  %t1326 = bitcast [40 x i8]* %t1325 to i8*
  %t1327 = getelementptr inbounds i8, i8* %t1326, i64 8
  %t1328 = bitcast i8* %t1327 to %SourceSpan**
  %t1329 = load %SourceSpan*, %SourceSpan** %t1328
  %t1330 = icmp eq i32 %t1302, 9
  %t1331 = select i1 %t1330, %SourceSpan* %t1329, %SourceSpan* %t1324
  %t1332 = getelementptr inbounds %Statement, %Statement* %t1303, i32 0, i32 1
  %t1333 = bitcast [40 x i8]* %t1332 to i8*
  %t1334 = getelementptr inbounds i8, i8* %t1333, i64 8
  %t1335 = bitcast i8* %t1334 to %SourceSpan**
  %t1336 = load %SourceSpan*, %SourceSpan** %t1335
  %t1337 = icmp eq i32 %t1302, 10
  %t1338 = select i1 %t1337, %SourceSpan* %t1336, %SourceSpan* %t1331
  %t1339 = getelementptr inbounds %Statement, %Statement* %t1303, i32 0, i32 1
  %t1340 = bitcast [40 x i8]* %t1339 to i8*
  %t1341 = getelementptr inbounds i8, i8* %t1340, i64 8
  %t1342 = bitcast i8* %t1341 to %SourceSpan**
  %t1343 = load %SourceSpan*, %SourceSpan** %t1342
  %t1344 = icmp eq i32 %t1302, 11
  %t1345 = select i1 %t1344, %SourceSpan* %t1343, %SourceSpan* %t1338
  %t1346 = call %SymbolCollectionResult @register_symbol(i8* %t1299, i8* %t1300, %SourceSpan* %t1345, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1346
merge17:
  %t1347 = extractvalue %Statement %statement, 0
  %t1348 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1349 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1350 = icmp eq i32 %t1347, 0
  %t1351 = select i1 %t1350, i8* %t1349, i8* %t1348
  %t1352 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1353 = icmp eq i32 %t1347, 1
  %t1354 = select i1 %t1353, i8* %t1352, i8* %t1351
  %t1355 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1356 = icmp eq i32 %t1347, 2
  %t1357 = select i1 %t1356, i8* %t1355, i8* %t1354
  %t1358 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1359 = icmp eq i32 %t1347, 3
  %t1360 = select i1 %t1359, i8* %t1358, i8* %t1357
  %t1361 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1362 = icmp eq i32 %t1347, 4
  %t1363 = select i1 %t1362, i8* %t1361, i8* %t1360
  %t1364 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1365 = icmp eq i32 %t1347, 5
  %t1366 = select i1 %t1365, i8* %t1364, i8* %t1363
  %t1367 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1368 = icmp eq i32 %t1347, 6
  %t1369 = select i1 %t1368, i8* %t1367, i8* %t1366
  %t1370 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1371 = icmp eq i32 %t1347, 7
  %t1372 = select i1 %t1371, i8* %t1370, i8* %t1369
  %t1373 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1374 = icmp eq i32 %t1347, 8
  %t1375 = select i1 %t1374, i8* %t1373, i8* %t1372
  %t1376 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1377 = icmp eq i32 %t1347, 9
  %t1378 = select i1 %t1377, i8* %t1376, i8* %t1375
  %t1379 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1380 = icmp eq i32 %t1347, 10
  %t1381 = select i1 %t1380, i8* %t1379, i8* %t1378
  %t1382 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1383 = icmp eq i32 %t1347, 11
  %t1384 = select i1 %t1383, i8* %t1382, i8* %t1381
  %t1385 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1386 = icmp eq i32 %t1347, 12
  %t1387 = select i1 %t1386, i8* %t1385, i8* %t1384
  %t1388 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1389 = icmp eq i32 %t1347, 13
  %t1390 = select i1 %t1389, i8* %t1388, i8* %t1387
  %t1391 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1392 = icmp eq i32 %t1347, 14
  %t1393 = select i1 %t1392, i8* %t1391, i8* %t1390
  %t1394 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1395 = icmp eq i32 %t1347, 15
  %t1396 = select i1 %t1395, i8* %t1394, i8* %t1393
  %t1397 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1398 = icmp eq i32 %t1347, 16
  %t1399 = select i1 %t1398, i8* %t1397, i8* %t1396
  %t1400 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1401 = icmp eq i32 %t1347, 17
  %t1402 = select i1 %t1401, i8* %t1400, i8* %t1399
  %t1403 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1404 = icmp eq i32 %t1347, 18
  %t1405 = select i1 %t1404, i8* %t1403, i8* %t1402
  %t1406 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1407 = icmp eq i32 %t1347, 19
  %t1408 = select i1 %t1407, i8* %t1406, i8* %t1405
  %t1409 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1410 = icmp eq i32 %t1347, 20
  %t1411 = select i1 %t1410, i8* %t1409, i8* %t1408
  %t1412 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1413 = icmp eq i32 %t1347, 21
  %t1414 = select i1 %t1413, i8* %t1412, i8* %t1411
  %t1415 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1416 = icmp eq i32 %t1347, 22
  %t1417 = select i1 %t1416, i8* %t1415, i8* %t1414
  %t1418 = call i8* @malloc(i64 20)
  %t1419 = bitcast i8* %t1418 to [20 x i8]*
  store [20 x i8] c"VariableDeclaration\00", [20 x i8]* %t1419
  %t1420 = call i1 @strings_equal(i8* %t1417, i8* %t1418)
  br i1 %t1420, label %then18, label %merge19
then18:
  %t1421 = extractvalue %Statement %statement, 0
  %t1422 = alloca %Statement
  store %Statement %statement, %Statement* %t1422
  %t1423 = getelementptr inbounds %Statement, %Statement* %t1422, i32 0, i32 1
  %t1424 = bitcast [48 x i8]* %t1423 to i8*
  %t1425 = bitcast i8* %t1424 to i8**
  %t1426 = load i8*, i8** %t1425
  %t1427 = icmp eq i32 %t1421, 2
  %t1428 = select i1 %t1427, i8* %t1426, i8* null
  %t1429 = getelementptr inbounds %Statement, %Statement* %t1422, i32 0, i32 1
  %t1430 = bitcast [48 x i8]* %t1429 to i8*
  %t1431 = bitcast i8* %t1430 to i8**
  %t1432 = load i8*, i8** %t1431
  %t1433 = icmp eq i32 %t1421, 3
  %t1434 = select i1 %t1433, i8* %t1432, i8* %t1428
  %t1435 = getelementptr inbounds %Statement, %Statement* %t1422, i32 0, i32 1
  %t1436 = bitcast [56 x i8]* %t1435 to i8*
  %t1437 = bitcast i8* %t1436 to i8**
  %t1438 = load i8*, i8** %t1437
  %t1439 = icmp eq i32 %t1421, 6
  %t1440 = select i1 %t1439, i8* %t1438, i8* %t1434
  %t1441 = getelementptr inbounds %Statement, %Statement* %t1422, i32 0, i32 1
  %t1442 = bitcast [56 x i8]* %t1441 to i8*
  %t1443 = bitcast i8* %t1442 to i8**
  %t1444 = load i8*, i8** %t1443
  %t1445 = icmp eq i32 %t1421, 8
  %t1446 = select i1 %t1445, i8* %t1444, i8* %t1440
  %t1447 = getelementptr inbounds %Statement, %Statement* %t1422, i32 0, i32 1
  %t1448 = bitcast [40 x i8]* %t1447 to i8*
  %t1449 = bitcast i8* %t1448 to i8**
  %t1450 = load i8*, i8** %t1449
  %t1451 = icmp eq i32 %t1421, 9
  %t1452 = select i1 %t1451, i8* %t1450, i8* %t1446
  %t1453 = getelementptr inbounds %Statement, %Statement* %t1422, i32 0, i32 1
  %t1454 = bitcast [40 x i8]* %t1453 to i8*
  %t1455 = bitcast i8* %t1454 to i8**
  %t1456 = load i8*, i8** %t1455
  %t1457 = icmp eq i32 %t1421, 10
  %t1458 = select i1 %t1457, i8* %t1456, i8* %t1452
  %t1459 = getelementptr inbounds %Statement, %Statement* %t1422, i32 0, i32 1
  %t1460 = bitcast [40 x i8]* %t1459 to i8*
  %t1461 = bitcast i8* %t1460 to i8**
  %t1462 = load i8*, i8** %t1461
  %t1463 = icmp eq i32 %t1421, 11
  %t1464 = select i1 %t1463, i8* %t1462, i8* %t1458
  %t1465 = call i8* @malloc(i64 9)
  %t1466 = bitcast i8* %t1465 to [9 x i8]*
  store [9 x i8] c"variable\00", [9 x i8]* %t1466
  %t1467 = extractvalue %Statement %statement, 0
  %t1468 = alloca %Statement
  store %Statement %statement, %Statement* %t1468
  %t1469 = getelementptr inbounds %Statement, %Statement* %t1468, i32 0, i32 1
  %t1470 = bitcast [48 x i8]* %t1469 to i8*
  %t1471 = getelementptr inbounds i8, i8* %t1470, i64 32
  %t1472 = bitcast i8* %t1471 to %SourceSpan**
  %t1473 = load %SourceSpan*, %SourceSpan** %t1472
  %t1474 = icmp eq i32 %t1467, 2
  %t1475 = select i1 %t1474, %SourceSpan* %t1473, %SourceSpan* null
  %t1476 = getelementptr inbounds %Statement, %Statement* %t1468, i32 0, i32 1
  %t1477 = bitcast [16 x i8]* %t1476 to i8*
  %t1478 = getelementptr inbounds i8, i8* %t1477, i64 8
  %t1479 = bitcast i8* %t1478 to %SourceSpan**
  %t1480 = load %SourceSpan*, %SourceSpan** %t1479
  %t1481 = icmp eq i32 %t1467, 20
  %t1482 = select i1 %t1481, %SourceSpan* %t1480, %SourceSpan* %t1475
  %t1483 = getelementptr inbounds %Statement, %Statement* %t1468, i32 0, i32 1
  %t1484 = bitcast [56 x i8]* %t1483 to i8*
  %t1485 = getelementptr inbounds i8, i8* %t1484, i64 48
  %t1486 = bitcast i8* %t1485 to %SourceSpan**
  %t1487 = load %SourceSpan*, %SourceSpan** %t1486
  %t1488 = icmp eq i32 %t1467, 21
  %t1489 = select i1 %t1488, %SourceSpan* %t1487, %SourceSpan* %t1482
  %t1490 = call %SymbolCollectionResult @register_symbol(i8* %t1464, i8* %t1465, %SourceSpan* %t1489, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1490
merge19:
  %t1491 = insertvalue %SymbolCollectionResult undef, { %SymbolEntry*, i64 }* %existing, 0
  %t1492 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t1493 = ptrtoint [0 x %Diagnostic]* %t1492 to i64
  %t1494 = icmp eq i64 %t1493, 0
  %t1495 = select i1 %t1494, i64 1, i64 %t1493
  %t1496 = call i8* @malloc(i64 %t1495)
  %t1497 = bitcast i8* %t1496 to %Diagnostic*
  %t1498 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1499 = ptrtoint { %Diagnostic*, i64 }* %t1498 to i64
  %t1500 = call i8* @malloc(i64 %t1499)
  %t1501 = bitcast i8* %t1500 to { %Diagnostic*, i64 }*
  %t1502 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1501, i32 0, i32 0
  store %Diagnostic* %t1497, %Diagnostic** %t1502
  %t1503 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1501, i32 0, i32 1
  store i64 0, i64* %t1503
  %t1504 = insertvalue %SymbolCollectionResult %t1491, { %Diagnostic*, i64 }* %t1501, 1
  ret %SymbolCollectionResult %t1504
}

define { %Diagnostic*, i64 }* @check_program_scopes(%Program %program, { %Statement*, i64 }* %interfaces) {
block.entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %Statement
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
  %t25 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t24, i32 0, i32 1
  %t26 = load i64, i64* %t25
  %t27 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t24, i32 0, i32 0
  %t28 = load %Statement*, %Statement** %t27
  store i64 0, i64* %l2
  store %Statement zeroinitializer, %Statement* %l3
  br label %for0
for0:
  %t29 = load i64, i64* %l2
  %t30 = icmp slt i64 %t29, %t26
  br i1 %t30, label %forbody1, label %afterfor3
forbody1:
  %t31 = load i64, i64* %l2
  %t32 = getelementptr %Statement, %Statement* %t28, i64 %t31
  %t33 = load %Statement, %Statement* %t32
  store %Statement %t33, %Statement* %l3
  %t34 = load %Statement, %Statement* %l3
  %t35 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t36 = call %ScopeResult @check_statement(%Statement %t34, { %SymbolEntry*, i64 }* %t35, { %Statement*, i64 }* %interfaces)
  store %ScopeResult %t36, %ScopeResult* %l4
  %t37 = load %ScopeResult, %ScopeResult* %l4
  %t38 = extractvalue %ScopeResult %t37, 0
  store { %SymbolEntry*, i64 }* %t38, { %SymbolEntry*, i64 }** %l0
  %t39 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t40 = load %ScopeResult, %ScopeResult* %l4
  %t41 = extractvalue %ScopeResult %t40, 1
  %t42 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t39, i32 0, i32 0
  %t43 = load %Diagnostic*, %Diagnostic** %t42
  %t44 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t39, i32 0, i32 1
  %t45 = load i64, i64* %t44
  %t46 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t41, i32 0, i32 0
  %t47 = load %Diagnostic*, %Diagnostic** %t46
  %t48 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t41, i32 0, i32 1
  %t49 = load i64, i64* %t48
  %t50 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t51 = ptrtoint %Diagnostic* %t50 to i64
  %t52 = add i64 %t45, %t49
  %t53 = mul i64 %t51, %t52
  %t54 = call noalias i8* @malloc(i64 %t53)
  %t55 = bitcast i8* %t54 to %Diagnostic*
  %t56 = bitcast %Diagnostic* %t55 to i8*
  %t57 = mul i64 %t51, %t45
  %t58 = bitcast %Diagnostic* %t43 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t56, i8* %t58, i64 %t57)
  %t59 = mul i64 %t51, %t49
  %t60 = bitcast %Diagnostic* %t47 to i8*
  %t61 = getelementptr %Diagnostic, %Diagnostic* %t55, i64 %t45
  %t62 = bitcast %Diagnostic* %t61 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t62, i8* %t60, i64 %t59)
  %t63 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t64 = ptrtoint { %Diagnostic*, i64 }* %t63 to i64
  %t65 = call i8* @malloc(i64 %t64)
  %t66 = bitcast i8* %t65 to { %Diagnostic*, i64 }*
  %t67 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t66, i32 0, i32 0
  store %Diagnostic* %t55, %Diagnostic** %t67
  %t68 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t66, i32 0, i32 1
  store i64 %t52, i64* %t68
  store { %Diagnostic*, i64 }* %t66, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t69 = load i64, i64* %l2
  %t70 = add i64 %t69, 1
  store i64 %t70, i64* %l2
  br label %for0
afterfor3:
  %t71 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t72 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t73 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t73
}

define %ScopeResult @check_statement(%Statement %statement, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces) {
block.entry:
  %l0 = alloca %ScopeResult
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca { %Diagnostic*, i64 }*
  %l3 = alloca %ScopeResult
  %l4 = alloca { %Diagnostic*, i64 }*
  %l5 = alloca double
  %l6 = alloca %MethodDeclaration
  %l7 = alloca %ScopeResult
  %l8 = alloca { %Diagnostic*, i64 }*
  %l9 = alloca %ScopeResult
  %l10 = alloca { %Diagnostic*, i64 }*
  %l11 = alloca %ScopeResult
  %l12 = alloca { %Diagnostic*, i64 }*
  %l13 = alloca %ScopeResult
  %l14 = alloca { %Diagnostic*, i64 }*
  %l15 = alloca %ScopeResult
  %l16 = alloca { %Diagnostic*, i64 }*
  %l17 = alloca %ScopeResult
  %l18 = alloca { %Diagnostic*, i64 }*
  %l19 = alloca { %Diagnostic*, i64 }*
  %l20 = alloca double
  %l21 = alloca %MatchCase
  %l22 = alloca { %Diagnostic*, i64 }*
  %l23 = alloca %ElseBranch*
  %l24 = alloca %ScopeResult
  %l25 = alloca %ScopeResult
  %l26 = alloca { %Diagnostic*, i64 }*
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
  %t71 = call i8* @malloc(i64 20)
  %t72 = bitcast i8* %t71 to [20 x i8]*
  store [20 x i8] c"VariableDeclaration\00", [20 x i8]* %t72
  %t73 = call i1 @strings_equal(i8* %t70, i8* %t71)
  br i1 %t73, label %then0, label %merge1
then0:
  %t74 = extractvalue %Statement %statement, 0
  %t75 = alloca %Statement
  store %Statement %statement, %Statement* %t75
  %t76 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t77 = bitcast [48 x i8]* %t76 to i8*
  %t78 = bitcast i8* %t77 to i8**
  %t79 = load i8*, i8** %t78
  %t80 = icmp eq i32 %t74, 2
  %t81 = select i1 %t80, i8* %t79, i8* null
  %t82 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t83 = bitcast [48 x i8]* %t82 to i8*
  %t84 = bitcast i8* %t83 to i8**
  %t85 = load i8*, i8** %t84
  %t86 = icmp eq i32 %t74, 3
  %t87 = select i1 %t86, i8* %t85, i8* %t81
  %t88 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t89 = bitcast [56 x i8]* %t88 to i8*
  %t90 = bitcast i8* %t89 to i8**
  %t91 = load i8*, i8** %t90
  %t92 = icmp eq i32 %t74, 6
  %t93 = select i1 %t92, i8* %t91, i8* %t87
  %t94 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t95 = bitcast [56 x i8]* %t94 to i8*
  %t96 = bitcast i8* %t95 to i8**
  %t97 = load i8*, i8** %t96
  %t98 = icmp eq i32 %t74, 8
  %t99 = select i1 %t98, i8* %t97, i8* %t93
  %t100 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t101 = bitcast [40 x i8]* %t100 to i8*
  %t102 = bitcast i8* %t101 to i8**
  %t103 = load i8*, i8** %t102
  %t104 = icmp eq i32 %t74, 9
  %t105 = select i1 %t104, i8* %t103, i8* %t99
  %t106 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t107 = bitcast [40 x i8]* %t106 to i8*
  %t108 = bitcast i8* %t107 to i8**
  %t109 = load i8*, i8** %t108
  %t110 = icmp eq i32 %t74, 10
  %t111 = select i1 %t110, i8* %t109, i8* %t105
  %t112 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t113 = bitcast [40 x i8]* %t112 to i8*
  %t114 = bitcast i8* %t113 to i8**
  %t115 = load i8*, i8** %t114
  %t116 = icmp eq i32 %t74, 11
  %t117 = select i1 %t116, i8* %t115, i8* %t111
  %t118 = call i8* @malloc(i64 9)
  %t119 = bitcast i8* %t118 to [9 x i8]*
  store [9 x i8] c"variable\00", [9 x i8]* %t119
  %t120 = extractvalue %Statement %statement, 0
  %t121 = alloca %Statement
  store %Statement %statement, %Statement* %t121
  %t122 = getelementptr inbounds %Statement, %Statement* %t121, i32 0, i32 1
  %t123 = bitcast [48 x i8]* %t122 to i8*
  %t124 = getelementptr inbounds i8, i8* %t123, i64 32
  %t125 = bitcast i8* %t124 to %SourceSpan**
  %t126 = load %SourceSpan*, %SourceSpan** %t125
  %t127 = icmp eq i32 %t120, 2
  %t128 = select i1 %t127, %SourceSpan* %t126, %SourceSpan* null
  %t129 = getelementptr inbounds %Statement, %Statement* %t121, i32 0, i32 1
  %t130 = bitcast [16 x i8]* %t129 to i8*
  %t131 = getelementptr inbounds i8, i8* %t130, i64 8
  %t132 = bitcast i8* %t131 to %SourceSpan**
  %t133 = load %SourceSpan*, %SourceSpan** %t132
  %t134 = icmp eq i32 %t120, 20
  %t135 = select i1 %t134, %SourceSpan* %t133, %SourceSpan* %t128
  %t136 = getelementptr inbounds %Statement, %Statement* %t121, i32 0, i32 1
  %t137 = bitcast [56 x i8]* %t136 to i8*
  %t138 = getelementptr inbounds i8, i8* %t137, i64 48
  %t139 = bitcast i8* %t138 to %SourceSpan**
  %t140 = load %SourceSpan*, %SourceSpan** %t139
  %t141 = icmp eq i32 %t120, 21
  %t142 = select i1 %t141, %SourceSpan* %t140, %SourceSpan* %t135
  %t143 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t117, i8* %t118, %SourceSpan* %t142)
  ret %ScopeResult %t143
merge1:
  %t144 = extractvalue %Statement %statement, 0
  %t145 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t146 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t144, 0
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t144, 1
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t144, 2
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t144, 3
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t144, 4
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t144, 5
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t144, 6
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t144, 7
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t144, 8
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t144, 9
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %t176 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t177 = icmp eq i32 %t144, 10
  %t178 = select i1 %t177, i8* %t176, i8* %t175
  %t179 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t144, 11
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t144, 12
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t144, 13
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %t188 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t144, 14
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %t191 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t192 = icmp eq i32 %t144, 15
  %t193 = select i1 %t192, i8* %t191, i8* %t190
  %t194 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t195 = icmp eq i32 %t144, 16
  %t196 = select i1 %t195, i8* %t194, i8* %t193
  %t197 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t198 = icmp eq i32 %t144, 17
  %t199 = select i1 %t198, i8* %t197, i8* %t196
  %t200 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t201 = icmp eq i32 %t144, 18
  %t202 = select i1 %t201, i8* %t200, i8* %t199
  %t203 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t204 = icmp eq i32 %t144, 19
  %t205 = select i1 %t204, i8* %t203, i8* %t202
  %t206 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t207 = icmp eq i32 %t144, 20
  %t208 = select i1 %t207, i8* %t206, i8* %t205
  %t209 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t210 = icmp eq i32 %t144, 21
  %t211 = select i1 %t210, i8* %t209, i8* %t208
  %t212 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t213 = icmp eq i32 %t144, 22
  %t214 = select i1 %t213, i8* %t212, i8* %t211
  %t215 = call i8* @malloc(i64 20)
  %t216 = bitcast i8* %t215 to [20 x i8]*
  store [20 x i8] c"FunctionDeclaration\00", [20 x i8]* %t216
  %t217 = call i1 @strings_equal(i8* %t214, i8* %t215)
  br i1 %t217, label %then2, label %merge3
then2:
  %t218 = extractvalue %Statement %statement, 0
  %t219 = alloca %Statement
  store %Statement %statement, %Statement* %t219
  %t220 = getelementptr inbounds %Statement, %Statement* %t219, i32 0, i32 1
  %t221 = bitcast [88 x i8]* %t220 to i8*
  %t222 = bitcast i8* %t221 to %FunctionSignature*
  %t223 = load %FunctionSignature, %FunctionSignature* %t222
  %t224 = icmp eq i32 %t218, 4
  %t225 = select i1 %t224, %FunctionSignature %t223, %FunctionSignature zeroinitializer
  %t226 = getelementptr inbounds %Statement, %Statement* %t219, i32 0, i32 1
  %t227 = bitcast [88 x i8]* %t226 to i8*
  %t228 = bitcast i8* %t227 to %FunctionSignature*
  %t229 = load %FunctionSignature, %FunctionSignature* %t228
  %t230 = icmp eq i32 %t218, 5
  %t231 = select i1 %t230, %FunctionSignature %t229, %FunctionSignature %t225
  %t232 = getelementptr inbounds %Statement, %Statement* %t219, i32 0, i32 1
  %t233 = bitcast [88 x i8]* %t232 to i8*
  %t234 = bitcast i8* %t233 to %FunctionSignature*
  %t235 = load %FunctionSignature, %FunctionSignature* %t234
  %t236 = icmp eq i32 %t218, 7
  %t237 = select i1 %t236, %FunctionSignature %t235, %FunctionSignature %t231
  %t238 = extractvalue %FunctionSignature %t237, 0
  %t239 = call i8* @malloc(i64 9)
  %t240 = bitcast i8* %t239 to [9 x i8]*
  store [9 x i8] c"function\00", [9 x i8]* %t240
  %t241 = extractvalue %Statement %statement, 0
  %t242 = alloca %Statement
  store %Statement %statement, %Statement* %t242
  %t243 = getelementptr inbounds %Statement, %Statement* %t242, i32 0, i32 1
  %t244 = bitcast [88 x i8]* %t243 to i8*
  %t245 = bitcast i8* %t244 to %FunctionSignature*
  %t246 = load %FunctionSignature, %FunctionSignature* %t245
  %t247 = icmp eq i32 %t241, 4
  %t248 = select i1 %t247, %FunctionSignature %t246, %FunctionSignature zeroinitializer
  %t249 = getelementptr inbounds %Statement, %Statement* %t242, i32 0, i32 1
  %t250 = bitcast [88 x i8]* %t249 to i8*
  %t251 = bitcast i8* %t250 to %FunctionSignature*
  %t252 = load %FunctionSignature, %FunctionSignature* %t251
  %t253 = icmp eq i32 %t241, 5
  %t254 = select i1 %t253, %FunctionSignature %t252, %FunctionSignature %t248
  %t255 = getelementptr inbounds %Statement, %Statement* %t242, i32 0, i32 1
  %t256 = bitcast [88 x i8]* %t255 to i8*
  %t257 = bitcast i8* %t256 to %FunctionSignature*
  %t258 = load %FunctionSignature, %FunctionSignature* %t257
  %t259 = icmp eq i32 %t241, 7
  %t260 = select i1 %t259, %FunctionSignature %t258, %FunctionSignature %t254
  %t261 = extractvalue %FunctionSignature %t260, 6
  %t262 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t238, i8* %t239, %SourceSpan* %t261)
  store %ScopeResult %t262, %ScopeResult* %l0
  %t263 = load %ScopeResult, %ScopeResult* %l0
  %t264 = extractvalue %ScopeResult %t263, 1
  store { %Diagnostic*, i64 }* %t264, { %Diagnostic*, i64 }** %l1
  %t265 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t266 = extractvalue %Statement %statement, 0
  %t267 = alloca %Statement
  store %Statement %statement, %Statement* %t267
  %t268 = getelementptr inbounds %Statement, %Statement* %t267, i32 0, i32 1
  %t269 = bitcast [88 x i8]* %t268 to i8*
  %t270 = bitcast i8* %t269 to %FunctionSignature*
  %t271 = load %FunctionSignature, %FunctionSignature* %t270
  %t272 = icmp eq i32 %t266, 4
  %t273 = select i1 %t272, %FunctionSignature %t271, %FunctionSignature zeroinitializer
  %t274 = getelementptr inbounds %Statement, %Statement* %t267, i32 0, i32 1
  %t275 = bitcast [88 x i8]* %t274 to i8*
  %t276 = bitcast i8* %t275 to %FunctionSignature*
  %t277 = load %FunctionSignature, %FunctionSignature* %t276
  %t278 = icmp eq i32 %t266, 5
  %t279 = select i1 %t278, %FunctionSignature %t277, %FunctionSignature %t273
  %t280 = getelementptr inbounds %Statement, %Statement* %t267, i32 0, i32 1
  %t281 = bitcast [88 x i8]* %t280 to i8*
  %t282 = bitcast i8* %t281 to %FunctionSignature*
  %t283 = load %FunctionSignature, %FunctionSignature* %t282
  %t284 = icmp eq i32 %t266, 7
  %t285 = select i1 %t284, %FunctionSignature %t283, %FunctionSignature %t279
  %t286 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t285)
  %t287 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t265, i32 0, i32 0
  %t288 = load %Diagnostic*, %Diagnostic** %t287
  %t289 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t265, i32 0, i32 1
  %t290 = load i64, i64* %t289
  %t291 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t286, i32 0, i32 0
  %t292 = load %Diagnostic*, %Diagnostic** %t291
  %t293 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t286, i32 0, i32 1
  %t294 = load i64, i64* %t293
  %t295 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t296 = ptrtoint %Diagnostic* %t295 to i64
  %t297 = add i64 %t290, %t294
  %t298 = mul i64 %t296, %t297
  %t299 = call noalias i8* @malloc(i64 %t298)
  %t300 = bitcast i8* %t299 to %Diagnostic*
  %t301 = bitcast %Diagnostic* %t300 to i8*
  %t302 = mul i64 %t296, %t290
  %t303 = bitcast %Diagnostic* %t288 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t301, i8* %t303, i64 %t302)
  %t304 = mul i64 %t296, %t294
  %t305 = bitcast %Diagnostic* %t292 to i8*
  %t306 = getelementptr %Diagnostic, %Diagnostic* %t300, i64 %t290
  %t307 = bitcast %Diagnostic* %t306 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t307, i8* %t305, i64 %t304)
  %t308 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t309 = ptrtoint { %Diagnostic*, i64 }* %t308 to i64
  %t310 = call i8* @malloc(i64 %t309)
  %t311 = bitcast i8* %t310 to { %Diagnostic*, i64 }*
  %t312 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t311, i32 0, i32 0
  store %Diagnostic* %t300, %Diagnostic** %t312
  %t313 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t311, i32 0, i32 1
  store i64 %t297, i64* %t313
  store { %Diagnostic*, i64 }* %t311, { %Diagnostic*, i64 }** %l1
  %t314 = extractvalue %Statement %statement, 0
  %t315 = alloca %Statement
  store %Statement %statement, %Statement* %t315
  %t316 = getelementptr inbounds %Statement, %Statement* %t315, i32 0, i32 1
  %t317 = bitcast [88 x i8]* %t316 to i8*
  %t318 = bitcast i8* %t317 to %FunctionSignature*
  %t319 = load %FunctionSignature, %FunctionSignature* %t318
  %t320 = icmp eq i32 %t314, 4
  %t321 = select i1 %t320, %FunctionSignature %t319, %FunctionSignature zeroinitializer
  %t322 = getelementptr inbounds %Statement, %Statement* %t315, i32 0, i32 1
  %t323 = bitcast [88 x i8]* %t322 to i8*
  %t324 = bitcast i8* %t323 to %FunctionSignature*
  %t325 = load %FunctionSignature, %FunctionSignature* %t324
  %t326 = icmp eq i32 %t314, 5
  %t327 = select i1 %t326, %FunctionSignature %t325, %FunctionSignature %t321
  %t328 = getelementptr inbounds %Statement, %Statement* %t315, i32 0, i32 1
  %t329 = bitcast [88 x i8]* %t328 to i8*
  %t330 = bitcast i8* %t329 to %FunctionSignature*
  %t331 = load %FunctionSignature, %FunctionSignature* %t330
  %t332 = icmp eq i32 %t314, 7
  %t333 = select i1 %t332, %FunctionSignature %t331, %FunctionSignature %t327
  %t334 = extractvalue %Statement %statement, 0
  %t335 = alloca %Statement
  store %Statement %statement, %Statement* %t335
  %t336 = getelementptr inbounds %Statement, %Statement* %t335, i32 0, i32 1
  %t337 = bitcast [88 x i8]* %t336 to i8*
  %t338 = getelementptr inbounds i8, i8* %t337, i64 56
  %t339 = bitcast i8* %t338 to %Block*
  %t340 = load %Block, %Block* %t339
  %t341 = icmp eq i32 %t334, 4
  %t342 = select i1 %t341, %Block %t340, %Block zeroinitializer
  %t343 = getelementptr inbounds %Statement, %Statement* %t335, i32 0, i32 1
  %t344 = bitcast [88 x i8]* %t343 to i8*
  %t345 = getelementptr inbounds i8, i8* %t344, i64 56
  %t346 = bitcast i8* %t345 to %Block*
  %t347 = load %Block, %Block* %t346
  %t348 = icmp eq i32 %t334, 5
  %t349 = select i1 %t348, %Block %t347, %Block %t342
  %t350 = getelementptr inbounds %Statement, %Statement* %t335, i32 0, i32 1
  %t351 = bitcast [56 x i8]* %t350 to i8*
  %t352 = getelementptr inbounds i8, i8* %t351, i64 16
  %t353 = bitcast i8* %t352 to %Block*
  %t354 = load %Block, %Block* %t353
  %t355 = icmp eq i32 %t334, 6
  %t356 = select i1 %t355, %Block %t354, %Block %t349
  %t357 = getelementptr inbounds %Statement, %Statement* %t335, i32 0, i32 1
  %t358 = bitcast [88 x i8]* %t357 to i8*
  %t359 = getelementptr inbounds i8, i8* %t358, i64 56
  %t360 = bitcast i8* %t359 to %Block*
  %t361 = load %Block, %Block* %t360
  %t362 = icmp eq i32 %t334, 7
  %t363 = select i1 %t362, %Block %t361, %Block %t356
  %t364 = getelementptr inbounds %Statement, %Statement* %t335, i32 0, i32 1
  %t365 = bitcast [120 x i8]* %t364 to i8*
  %t366 = getelementptr inbounds i8, i8* %t365, i64 88
  %t367 = bitcast i8* %t366 to %Block*
  %t368 = load %Block, %Block* %t367
  %t369 = icmp eq i32 %t334, 12
  %t370 = select i1 %t369, %Block %t368, %Block %t363
  %t371 = getelementptr inbounds %Statement, %Statement* %t335, i32 0, i32 1
  %t372 = bitcast [40 x i8]* %t371 to i8*
  %t373 = getelementptr inbounds i8, i8* %t372, i64 8
  %t374 = bitcast i8* %t373 to %Block*
  %t375 = load %Block, %Block* %t374
  %t376 = icmp eq i32 %t334, 13
  %t377 = select i1 %t376, %Block %t375, %Block %t370
  %t378 = getelementptr inbounds %Statement, %Statement* %t335, i32 0, i32 1
  %t379 = bitcast [136 x i8]* %t378 to i8*
  %t380 = getelementptr inbounds i8, i8* %t379, i64 104
  %t381 = bitcast i8* %t380 to %Block*
  %t382 = load %Block, %Block* %t381
  %t383 = icmp eq i32 %t334, 14
  %t384 = select i1 %t383, %Block %t382, %Block %t377
  %t385 = getelementptr inbounds %Statement, %Statement* %t335, i32 0, i32 1
  %t386 = bitcast [32 x i8]* %t385 to i8*
  %t387 = bitcast i8* %t386 to %Block*
  %t388 = load %Block, %Block* %t387
  %t389 = icmp eq i32 %t334, 15
  %t390 = select i1 %t389, %Block %t388, %Block %t384
  %t391 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t333, %Block %t390, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t391, { %Diagnostic*, i64 }** %l2
  %t392 = load %ScopeResult, %ScopeResult* %l0
  %t393 = extractvalue %ScopeResult %t392, 0
  %t394 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t393, 0
  %t395 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t396 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l2
  %t397 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t395, i32 0, i32 0
  %t398 = load %Diagnostic*, %Diagnostic** %t397
  %t399 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t395, i32 0, i32 1
  %t400 = load i64, i64* %t399
  %t401 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t396, i32 0, i32 0
  %t402 = load %Diagnostic*, %Diagnostic** %t401
  %t403 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t396, i32 0, i32 1
  %t404 = load i64, i64* %t403
  %t405 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t406 = ptrtoint %Diagnostic* %t405 to i64
  %t407 = add i64 %t400, %t404
  %t408 = mul i64 %t406, %t407
  %t409 = call noalias i8* @malloc(i64 %t408)
  %t410 = bitcast i8* %t409 to %Diagnostic*
  %t411 = bitcast %Diagnostic* %t410 to i8*
  %t412 = mul i64 %t406, %t400
  %t413 = bitcast %Diagnostic* %t398 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t411, i8* %t413, i64 %t412)
  %t414 = mul i64 %t406, %t404
  %t415 = bitcast %Diagnostic* %t402 to i8*
  %t416 = getelementptr %Diagnostic, %Diagnostic* %t410, i64 %t400
  %t417 = bitcast %Diagnostic* %t416 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t417, i8* %t415, i64 %t414)
  %t418 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t419 = ptrtoint { %Diagnostic*, i64 }* %t418 to i64
  %t420 = call i8* @malloc(i64 %t419)
  %t421 = bitcast i8* %t420 to { %Diagnostic*, i64 }*
  %t422 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t421, i32 0, i32 0
  store %Diagnostic* %t410, %Diagnostic** %t422
  %t423 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t421, i32 0, i32 1
  store i64 %t407, i64* %t423
  %t424 = insertvalue %ScopeResult %t394, { %Diagnostic*, i64 }* %t421, 1
  ret %ScopeResult %t424
merge3:
  %t425 = extractvalue %Statement %statement, 0
  %t426 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t427 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t428 = icmp eq i32 %t425, 0
  %t429 = select i1 %t428, i8* %t427, i8* %t426
  %t430 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t431 = icmp eq i32 %t425, 1
  %t432 = select i1 %t431, i8* %t430, i8* %t429
  %t433 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t434 = icmp eq i32 %t425, 2
  %t435 = select i1 %t434, i8* %t433, i8* %t432
  %t436 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t437 = icmp eq i32 %t425, 3
  %t438 = select i1 %t437, i8* %t436, i8* %t435
  %t439 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t440 = icmp eq i32 %t425, 4
  %t441 = select i1 %t440, i8* %t439, i8* %t438
  %t442 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t443 = icmp eq i32 %t425, 5
  %t444 = select i1 %t443, i8* %t442, i8* %t441
  %t445 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t446 = icmp eq i32 %t425, 6
  %t447 = select i1 %t446, i8* %t445, i8* %t444
  %t448 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t449 = icmp eq i32 %t425, 7
  %t450 = select i1 %t449, i8* %t448, i8* %t447
  %t451 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t452 = icmp eq i32 %t425, 8
  %t453 = select i1 %t452, i8* %t451, i8* %t450
  %t454 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t455 = icmp eq i32 %t425, 9
  %t456 = select i1 %t455, i8* %t454, i8* %t453
  %t457 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t458 = icmp eq i32 %t425, 10
  %t459 = select i1 %t458, i8* %t457, i8* %t456
  %t460 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t461 = icmp eq i32 %t425, 11
  %t462 = select i1 %t461, i8* %t460, i8* %t459
  %t463 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t464 = icmp eq i32 %t425, 12
  %t465 = select i1 %t464, i8* %t463, i8* %t462
  %t466 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t467 = icmp eq i32 %t425, 13
  %t468 = select i1 %t467, i8* %t466, i8* %t465
  %t469 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t470 = icmp eq i32 %t425, 14
  %t471 = select i1 %t470, i8* %t469, i8* %t468
  %t472 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t473 = icmp eq i32 %t425, 15
  %t474 = select i1 %t473, i8* %t472, i8* %t471
  %t475 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t476 = icmp eq i32 %t425, 16
  %t477 = select i1 %t476, i8* %t475, i8* %t474
  %t478 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t479 = icmp eq i32 %t425, 17
  %t480 = select i1 %t479, i8* %t478, i8* %t477
  %t481 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t482 = icmp eq i32 %t425, 18
  %t483 = select i1 %t482, i8* %t481, i8* %t480
  %t484 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t485 = icmp eq i32 %t425, 19
  %t486 = select i1 %t485, i8* %t484, i8* %t483
  %t487 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t488 = icmp eq i32 %t425, 20
  %t489 = select i1 %t488, i8* %t487, i8* %t486
  %t490 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t491 = icmp eq i32 %t425, 21
  %t492 = select i1 %t491, i8* %t490, i8* %t489
  %t493 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t494 = icmp eq i32 %t425, 22
  %t495 = select i1 %t494, i8* %t493, i8* %t492
  %t496 = call i8* @malloc(i64 18)
  %t497 = bitcast i8* %t496 to [18 x i8]*
  store [18 x i8] c"StructDeclaration\00", [18 x i8]* %t497
  %t498 = call i1 @strings_equal(i8* %t495, i8* %t496)
  br i1 %t498, label %then4, label %merge5
then4:
  %t499 = extractvalue %Statement %statement, 0
  %t500 = alloca %Statement
  store %Statement %statement, %Statement* %t500
  %t501 = getelementptr inbounds %Statement, %Statement* %t500, i32 0, i32 1
  %t502 = bitcast [48 x i8]* %t501 to i8*
  %t503 = bitcast i8* %t502 to i8**
  %t504 = load i8*, i8** %t503
  %t505 = icmp eq i32 %t499, 2
  %t506 = select i1 %t505, i8* %t504, i8* null
  %t507 = getelementptr inbounds %Statement, %Statement* %t500, i32 0, i32 1
  %t508 = bitcast [48 x i8]* %t507 to i8*
  %t509 = bitcast i8* %t508 to i8**
  %t510 = load i8*, i8** %t509
  %t511 = icmp eq i32 %t499, 3
  %t512 = select i1 %t511, i8* %t510, i8* %t506
  %t513 = getelementptr inbounds %Statement, %Statement* %t500, i32 0, i32 1
  %t514 = bitcast [56 x i8]* %t513 to i8*
  %t515 = bitcast i8* %t514 to i8**
  %t516 = load i8*, i8** %t515
  %t517 = icmp eq i32 %t499, 6
  %t518 = select i1 %t517, i8* %t516, i8* %t512
  %t519 = getelementptr inbounds %Statement, %Statement* %t500, i32 0, i32 1
  %t520 = bitcast [56 x i8]* %t519 to i8*
  %t521 = bitcast i8* %t520 to i8**
  %t522 = load i8*, i8** %t521
  %t523 = icmp eq i32 %t499, 8
  %t524 = select i1 %t523, i8* %t522, i8* %t518
  %t525 = getelementptr inbounds %Statement, %Statement* %t500, i32 0, i32 1
  %t526 = bitcast [40 x i8]* %t525 to i8*
  %t527 = bitcast i8* %t526 to i8**
  %t528 = load i8*, i8** %t527
  %t529 = icmp eq i32 %t499, 9
  %t530 = select i1 %t529, i8* %t528, i8* %t524
  %t531 = getelementptr inbounds %Statement, %Statement* %t500, i32 0, i32 1
  %t532 = bitcast [40 x i8]* %t531 to i8*
  %t533 = bitcast i8* %t532 to i8**
  %t534 = load i8*, i8** %t533
  %t535 = icmp eq i32 %t499, 10
  %t536 = select i1 %t535, i8* %t534, i8* %t530
  %t537 = getelementptr inbounds %Statement, %Statement* %t500, i32 0, i32 1
  %t538 = bitcast [40 x i8]* %t537 to i8*
  %t539 = bitcast i8* %t538 to i8**
  %t540 = load i8*, i8** %t539
  %t541 = icmp eq i32 %t499, 11
  %t542 = select i1 %t541, i8* %t540, i8* %t536
  %t543 = call i8* @malloc(i64 7)
  %t544 = bitcast i8* %t543 to [7 x i8]*
  store [7 x i8] c"struct\00", [7 x i8]* %t544
  %t545 = extractvalue %Statement %statement, 0
  %t546 = alloca %Statement
  store %Statement %statement, %Statement* %t546
  %t547 = getelementptr inbounds %Statement, %Statement* %t546, i32 0, i32 1
  %t548 = bitcast [48 x i8]* %t547 to i8*
  %t549 = getelementptr inbounds i8, i8* %t548, i64 8
  %t550 = bitcast i8* %t549 to %SourceSpan**
  %t551 = load %SourceSpan*, %SourceSpan** %t550
  %t552 = icmp eq i32 %t545, 3
  %t553 = select i1 %t552, %SourceSpan* %t551, %SourceSpan* null
  %t554 = getelementptr inbounds %Statement, %Statement* %t546, i32 0, i32 1
  %t555 = bitcast [56 x i8]* %t554 to i8*
  %t556 = getelementptr inbounds i8, i8* %t555, i64 8
  %t557 = bitcast i8* %t556 to %SourceSpan**
  %t558 = load %SourceSpan*, %SourceSpan** %t557
  %t559 = icmp eq i32 %t545, 6
  %t560 = select i1 %t559, %SourceSpan* %t558, %SourceSpan* %t553
  %t561 = getelementptr inbounds %Statement, %Statement* %t546, i32 0, i32 1
  %t562 = bitcast [56 x i8]* %t561 to i8*
  %t563 = getelementptr inbounds i8, i8* %t562, i64 8
  %t564 = bitcast i8* %t563 to %SourceSpan**
  %t565 = load %SourceSpan*, %SourceSpan** %t564
  %t566 = icmp eq i32 %t545, 8
  %t567 = select i1 %t566, %SourceSpan* %t565, %SourceSpan* %t560
  %t568 = getelementptr inbounds %Statement, %Statement* %t546, i32 0, i32 1
  %t569 = bitcast [40 x i8]* %t568 to i8*
  %t570 = getelementptr inbounds i8, i8* %t569, i64 8
  %t571 = bitcast i8* %t570 to %SourceSpan**
  %t572 = load %SourceSpan*, %SourceSpan** %t571
  %t573 = icmp eq i32 %t545, 9
  %t574 = select i1 %t573, %SourceSpan* %t572, %SourceSpan* %t567
  %t575 = getelementptr inbounds %Statement, %Statement* %t546, i32 0, i32 1
  %t576 = bitcast [40 x i8]* %t575 to i8*
  %t577 = getelementptr inbounds i8, i8* %t576, i64 8
  %t578 = bitcast i8* %t577 to %SourceSpan**
  %t579 = load %SourceSpan*, %SourceSpan** %t578
  %t580 = icmp eq i32 %t545, 10
  %t581 = select i1 %t580, %SourceSpan* %t579, %SourceSpan* %t574
  %t582 = getelementptr inbounds %Statement, %Statement* %t546, i32 0, i32 1
  %t583 = bitcast [40 x i8]* %t582 to i8*
  %t584 = getelementptr inbounds i8, i8* %t583, i64 8
  %t585 = bitcast i8* %t584 to %SourceSpan**
  %t586 = load %SourceSpan*, %SourceSpan** %t585
  %t587 = icmp eq i32 %t545, 11
  %t588 = select i1 %t587, %SourceSpan* %t586, %SourceSpan* %t581
  %t589 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t542, i8* %t543, %SourceSpan* %t588)
  store %ScopeResult %t589, %ScopeResult* %l3
  %t590 = load %ScopeResult, %ScopeResult* %l3
  %t591 = extractvalue %ScopeResult %t590, 1
  store { %Diagnostic*, i64 }* %t591, { %Diagnostic*, i64 }** %l4
  %t592 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t593 = extractvalue %Statement %statement, 0
  %t594 = alloca %Statement
  store %Statement %statement, %Statement* %t594
  %t595 = getelementptr inbounds %Statement, %Statement* %t594, i32 0, i32 1
  %t596 = bitcast [56 x i8]* %t595 to i8*
  %t597 = getelementptr inbounds i8, i8* %t596, i64 16
  %t598 = bitcast i8* %t597 to { %TypeParameter*, i64 }**
  %t599 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t598
  %t600 = icmp eq i32 %t593, 8
  %t601 = select i1 %t600, { %TypeParameter*, i64 }* %t599, { %TypeParameter*, i64 }* null
  %t602 = getelementptr inbounds %Statement, %Statement* %t594, i32 0, i32 1
  %t603 = bitcast [40 x i8]* %t602 to i8*
  %t604 = getelementptr inbounds i8, i8* %t603, i64 16
  %t605 = bitcast i8* %t604 to { %TypeParameter*, i64 }**
  %t606 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t605
  %t607 = icmp eq i32 %t593, 9
  %t608 = select i1 %t607, { %TypeParameter*, i64 }* %t606, { %TypeParameter*, i64 }* %t601
  %t609 = getelementptr inbounds %Statement, %Statement* %t594, i32 0, i32 1
  %t610 = bitcast [40 x i8]* %t609 to i8*
  %t611 = getelementptr inbounds i8, i8* %t610, i64 16
  %t612 = bitcast i8* %t611 to { %TypeParameter*, i64 }**
  %t613 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t612
  %t614 = icmp eq i32 %t593, 10
  %t615 = select i1 %t614, { %TypeParameter*, i64 }* %t613, { %TypeParameter*, i64 }* %t608
  %t616 = getelementptr inbounds %Statement, %Statement* %t594, i32 0, i32 1
  %t617 = bitcast [40 x i8]* %t616 to i8*
  %t618 = getelementptr inbounds i8, i8* %t617, i64 16
  %t619 = bitcast i8* %t618 to { %TypeParameter*, i64 }**
  %t620 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t619
  %t621 = icmp eq i32 %t593, 11
  %t622 = select i1 %t621, { %TypeParameter*, i64 }* %t620, { %TypeParameter*, i64 }* %t615
  %t623 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t622)
  %t624 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t592, i32 0, i32 0
  %t625 = load %Diagnostic*, %Diagnostic** %t624
  %t626 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t592, i32 0, i32 1
  %t627 = load i64, i64* %t626
  %t628 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t623, i32 0, i32 0
  %t629 = load %Diagnostic*, %Diagnostic** %t628
  %t630 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t623, i32 0, i32 1
  %t631 = load i64, i64* %t630
  %t632 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t633 = ptrtoint %Diagnostic* %t632 to i64
  %t634 = add i64 %t627, %t631
  %t635 = mul i64 %t633, %t634
  %t636 = call noalias i8* @malloc(i64 %t635)
  %t637 = bitcast i8* %t636 to %Diagnostic*
  %t638 = bitcast %Diagnostic* %t637 to i8*
  %t639 = mul i64 %t633, %t627
  %t640 = bitcast %Diagnostic* %t625 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t638, i8* %t640, i64 %t639)
  %t641 = mul i64 %t633, %t631
  %t642 = bitcast %Diagnostic* %t629 to i8*
  %t643 = getelementptr %Diagnostic, %Diagnostic* %t637, i64 %t627
  %t644 = bitcast %Diagnostic* %t643 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t644, i8* %t642, i64 %t641)
  %t645 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t646 = ptrtoint { %Diagnostic*, i64 }* %t645 to i64
  %t647 = call i8* @malloc(i64 %t646)
  %t648 = bitcast i8* %t647 to { %Diagnostic*, i64 }*
  %t649 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t648, i32 0, i32 0
  store %Diagnostic* %t637, %Diagnostic** %t649
  %t650 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t648, i32 0, i32 1
  store i64 %t634, i64* %t650
  store { %Diagnostic*, i64 }* %t648, { %Diagnostic*, i64 }** %l4
  %t651 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t652 = extractvalue %Statement %statement, 0
  %t653 = alloca %Statement
  store %Statement %statement, %Statement* %t653
  %t654 = getelementptr inbounds %Statement, %Statement* %t653, i32 0, i32 1
  %t655 = bitcast [56 x i8]* %t654 to i8*
  %t656 = getelementptr inbounds i8, i8* %t655, i64 32
  %t657 = bitcast i8* %t656 to { %FieldDeclaration*, i64 }**
  %t658 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %t657
  %t659 = icmp eq i32 %t652, 8
  %t660 = select i1 %t659, { %FieldDeclaration*, i64 }* %t658, { %FieldDeclaration*, i64 }* null
  %t661 = call { %Diagnostic*, i64 }* @check_struct_fields({ %FieldDeclaration*, i64 }* %t660)
  %t662 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t651, i32 0, i32 0
  %t663 = load %Diagnostic*, %Diagnostic** %t662
  %t664 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t651, i32 0, i32 1
  %t665 = load i64, i64* %t664
  %t666 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t661, i32 0, i32 0
  %t667 = load %Diagnostic*, %Diagnostic** %t666
  %t668 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t661, i32 0, i32 1
  %t669 = load i64, i64* %t668
  %t670 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t671 = ptrtoint %Diagnostic* %t670 to i64
  %t672 = add i64 %t665, %t669
  %t673 = mul i64 %t671, %t672
  %t674 = call noalias i8* @malloc(i64 %t673)
  %t675 = bitcast i8* %t674 to %Diagnostic*
  %t676 = bitcast %Diagnostic* %t675 to i8*
  %t677 = mul i64 %t671, %t665
  %t678 = bitcast %Diagnostic* %t663 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t676, i8* %t678, i64 %t677)
  %t679 = mul i64 %t671, %t669
  %t680 = bitcast %Diagnostic* %t667 to i8*
  %t681 = getelementptr %Diagnostic, %Diagnostic* %t675, i64 %t665
  %t682 = bitcast %Diagnostic* %t681 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t682, i8* %t680, i64 %t679)
  %t683 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t684 = ptrtoint { %Diagnostic*, i64 }* %t683 to i64
  %t685 = call i8* @malloc(i64 %t684)
  %t686 = bitcast i8* %t685 to { %Diagnostic*, i64 }*
  %t687 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t686, i32 0, i32 0
  store %Diagnostic* %t675, %Diagnostic** %t687
  %t688 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t686, i32 0, i32 1
  store i64 %t672, i64* %t688
  store { %Diagnostic*, i64 }* %t686, { %Diagnostic*, i64 }** %l4
  %t689 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t690 = extractvalue %Statement %statement, 0
  %t691 = alloca %Statement
  store %Statement %statement, %Statement* %t691
  %t692 = getelementptr inbounds %Statement, %Statement* %t691, i32 0, i32 1
  %t693 = bitcast [56 x i8]* %t692 to i8*
  %t694 = getelementptr inbounds i8, i8* %t693, i64 40
  %t695 = bitcast i8* %t694 to { %MethodDeclaration*, i64 }**
  %t696 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t695
  %t697 = icmp eq i32 %t690, 8
  %t698 = select i1 %t697, { %MethodDeclaration*, i64 }* %t696, { %MethodDeclaration*, i64 }* null
  %t699 = call { %Diagnostic*, i64 }* @check_struct_methods({ %MethodDeclaration*, i64 }* %t698)
  %t700 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t689, i32 0, i32 0
  %t701 = load %Diagnostic*, %Diagnostic** %t700
  %t702 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t689, i32 0, i32 1
  %t703 = load i64, i64* %t702
  %t704 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t699, i32 0, i32 0
  %t705 = load %Diagnostic*, %Diagnostic** %t704
  %t706 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t699, i32 0, i32 1
  %t707 = load i64, i64* %t706
  %t708 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t709 = ptrtoint %Diagnostic* %t708 to i64
  %t710 = add i64 %t703, %t707
  %t711 = mul i64 %t709, %t710
  %t712 = call noalias i8* @malloc(i64 %t711)
  %t713 = bitcast i8* %t712 to %Diagnostic*
  %t714 = bitcast %Diagnostic* %t713 to i8*
  %t715 = mul i64 %t709, %t703
  %t716 = bitcast %Diagnostic* %t701 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t714, i8* %t716, i64 %t715)
  %t717 = mul i64 %t709, %t707
  %t718 = bitcast %Diagnostic* %t705 to i8*
  %t719 = getelementptr %Diagnostic, %Diagnostic* %t713, i64 %t703
  %t720 = bitcast %Diagnostic* %t719 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t720, i8* %t718, i64 %t717)
  %t721 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t722 = ptrtoint { %Diagnostic*, i64 }* %t721 to i64
  %t723 = call i8* @malloc(i64 %t722)
  %t724 = bitcast i8* %t723 to { %Diagnostic*, i64 }*
  %t725 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t724, i32 0, i32 0
  store %Diagnostic* %t713, %Diagnostic** %t725
  %t726 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t724, i32 0, i32 1
  store i64 %t710, i64* %t726
  store { %Diagnostic*, i64 }* %t724, { %Diagnostic*, i64 }** %l4
  %t727 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t728 = call { %Diagnostic*, i64 }* @check_struct_implements_interfaces(%Statement %statement, { %Statement*, i64 }* %interfaces)
  %t729 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t727, i32 0, i32 0
  %t730 = load %Diagnostic*, %Diagnostic** %t729
  %t731 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t727, i32 0, i32 1
  %t732 = load i64, i64* %t731
  %t733 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t728, i32 0, i32 0
  %t734 = load %Diagnostic*, %Diagnostic** %t733
  %t735 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t728, i32 0, i32 1
  %t736 = load i64, i64* %t735
  %t737 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t738 = ptrtoint %Diagnostic* %t737 to i64
  %t739 = add i64 %t732, %t736
  %t740 = mul i64 %t738, %t739
  %t741 = call noalias i8* @malloc(i64 %t740)
  %t742 = bitcast i8* %t741 to %Diagnostic*
  %t743 = bitcast %Diagnostic* %t742 to i8*
  %t744 = mul i64 %t738, %t732
  %t745 = bitcast %Diagnostic* %t730 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t743, i8* %t745, i64 %t744)
  %t746 = mul i64 %t738, %t736
  %t747 = bitcast %Diagnostic* %t734 to i8*
  %t748 = getelementptr %Diagnostic, %Diagnostic* %t742, i64 %t732
  %t749 = bitcast %Diagnostic* %t748 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t749, i8* %t747, i64 %t746)
  %t750 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t751 = ptrtoint { %Diagnostic*, i64 }* %t750 to i64
  %t752 = call i8* @malloc(i64 %t751)
  %t753 = bitcast i8* %t752 to { %Diagnostic*, i64 }*
  %t754 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t753, i32 0, i32 0
  store %Diagnostic* %t742, %Diagnostic** %t754
  %t755 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t753, i32 0, i32 1
  store i64 %t739, i64* %t755
  store { %Diagnostic*, i64 }* %t753, { %Diagnostic*, i64 }** %l4
  %t756 = sitofp i64 0 to double
  store double %t756, double* %l5
  %t757 = load %ScopeResult, %ScopeResult* %l3
  %t758 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t759 = load double, double* %l5
  br label %loop.header6
loop.header6:
  %t833 = phi { %Diagnostic*, i64 }* [ %t758, %then4 ], [ %t831, %loop.latch8 ]
  %t834 = phi double [ %t759, %then4 ], [ %t832, %loop.latch8 ]
  store { %Diagnostic*, i64 }* %t833, { %Diagnostic*, i64 }** %l4
  store double %t834, double* %l5
  br label %loop.body7
loop.body7:
  %t760 = load double, double* %l5
  %t761 = extractvalue %Statement %statement, 0
  %t762 = alloca %Statement
  store %Statement %statement, %Statement* %t762
  %t763 = getelementptr inbounds %Statement, %Statement* %t762, i32 0, i32 1
  %t764 = bitcast [56 x i8]* %t763 to i8*
  %t765 = getelementptr inbounds i8, i8* %t764, i64 40
  %t766 = bitcast i8* %t765 to { %MethodDeclaration*, i64 }**
  %t767 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t766
  %t768 = icmp eq i32 %t761, 8
  %t769 = select i1 %t768, { %MethodDeclaration*, i64 }* %t767, { %MethodDeclaration*, i64 }* null
  %t770 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t769
  %t771 = extractvalue { %MethodDeclaration*, i64 } %t770, 1
  %t772 = sitofp i64 %t771 to double
  %t773 = fcmp oge double %t760, %t772
  %t774 = load %ScopeResult, %ScopeResult* %l3
  %t775 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t776 = load double, double* %l5
  br i1 %t773, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t777 = extractvalue %Statement %statement, 0
  %t778 = alloca %Statement
  store %Statement %statement, %Statement* %t778
  %t779 = getelementptr inbounds %Statement, %Statement* %t778, i32 0, i32 1
  %t780 = bitcast [56 x i8]* %t779 to i8*
  %t781 = getelementptr inbounds i8, i8* %t780, i64 40
  %t782 = bitcast i8* %t781 to { %MethodDeclaration*, i64 }**
  %t783 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t782
  %t784 = icmp eq i32 %t777, 8
  %t785 = select i1 %t784, { %MethodDeclaration*, i64 }* %t783, { %MethodDeclaration*, i64 }* null
  %t786 = load double, double* %l5
  %t787 = call double @llvm.round.f64(double %t786)
  %t788 = fptosi double %t787 to i64
  %t789 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t785
  %t790 = extractvalue { %MethodDeclaration*, i64 } %t789, 0
  %t791 = extractvalue { %MethodDeclaration*, i64 } %t789, 1
  %t792 = icmp uge i64 %t788, %t791
  ; bounds check: %t792 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t788, i64 %t791)
  %t793 = getelementptr %MethodDeclaration, %MethodDeclaration* %t790, i64 %t788
  %t794 = load %MethodDeclaration, %MethodDeclaration* %t793
  store %MethodDeclaration %t794, %MethodDeclaration* %l6
  %t795 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t796 = load %MethodDeclaration, %MethodDeclaration* %l6
  %t797 = extractvalue %MethodDeclaration %t796, 0
  %t798 = load %MethodDeclaration, %MethodDeclaration* %l6
  %t799 = extractvalue %MethodDeclaration %t798, 1
  %t800 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t797, %Block %t799, { %Statement*, i64 }* %interfaces)
  %t801 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t795, i32 0, i32 0
  %t802 = load %Diagnostic*, %Diagnostic** %t801
  %t803 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t795, i32 0, i32 1
  %t804 = load i64, i64* %t803
  %t805 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t800, i32 0, i32 0
  %t806 = load %Diagnostic*, %Diagnostic** %t805
  %t807 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t800, i32 0, i32 1
  %t808 = load i64, i64* %t807
  %t809 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t810 = ptrtoint %Diagnostic* %t809 to i64
  %t811 = add i64 %t804, %t808
  %t812 = mul i64 %t810, %t811
  %t813 = call noalias i8* @malloc(i64 %t812)
  %t814 = bitcast i8* %t813 to %Diagnostic*
  %t815 = bitcast %Diagnostic* %t814 to i8*
  %t816 = mul i64 %t810, %t804
  %t817 = bitcast %Diagnostic* %t802 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t815, i8* %t817, i64 %t816)
  %t818 = mul i64 %t810, %t808
  %t819 = bitcast %Diagnostic* %t806 to i8*
  %t820 = getelementptr %Diagnostic, %Diagnostic* %t814, i64 %t804
  %t821 = bitcast %Diagnostic* %t820 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t821, i8* %t819, i64 %t818)
  %t822 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t823 = ptrtoint { %Diagnostic*, i64 }* %t822 to i64
  %t824 = call i8* @malloc(i64 %t823)
  %t825 = bitcast i8* %t824 to { %Diagnostic*, i64 }*
  %t826 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t825, i32 0, i32 0
  store %Diagnostic* %t814, %Diagnostic** %t826
  %t827 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t825, i32 0, i32 1
  store i64 %t811, i64* %t827
  store { %Diagnostic*, i64 }* %t825, { %Diagnostic*, i64 }** %l4
  %t828 = load double, double* %l5
  %t829 = sitofp i64 1 to double
  %t830 = fadd double %t828, %t829
  store double %t830, double* %l5
  br label %loop.latch8
loop.latch8:
  %t831 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t832 = load double, double* %l5
  br label %loop.header6
afterloop9:
  %t835 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t836 = load double, double* %l5
  %t837 = load %ScopeResult, %ScopeResult* %l3
  %t838 = extractvalue %ScopeResult %t837, 0
  %t839 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t838, 0
  %t840 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t841 = insertvalue %ScopeResult %t839, { %Diagnostic*, i64 }* %t840, 1
  ret %ScopeResult %t841
merge5:
  %t842 = extractvalue %Statement %statement, 0
  %t843 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t844 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t845 = icmp eq i32 %t842, 0
  %t846 = select i1 %t845, i8* %t844, i8* %t843
  %t847 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t848 = icmp eq i32 %t842, 1
  %t849 = select i1 %t848, i8* %t847, i8* %t846
  %t850 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t851 = icmp eq i32 %t842, 2
  %t852 = select i1 %t851, i8* %t850, i8* %t849
  %t853 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t854 = icmp eq i32 %t842, 3
  %t855 = select i1 %t854, i8* %t853, i8* %t852
  %t856 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t857 = icmp eq i32 %t842, 4
  %t858 = select i1 %t857, i8* %t856, i8* %t855
  %t859 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t860 = icmp eq i32 %t842, 5
  %t861 = select i1 %t860, i8* %t859, i8* %t858
  %t862 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t863 = icmp eq i32 %t842, 6
  %t864 = select i1 %t863, i8* %t862, i8* %t861
  %t865 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t866 = icmp eq i32 %t842, 7
  %t867 = select i1 %t866, i8* %t865, i8* %t864
  %t868 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t869 = icmp eq i32 %t842, 8
  %t870 = select i1 %t869, i8* %t868, i8* %t867
  %t871 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t872 = icmp eq i32 %t842, 9
  %t873 = select i1 %t872, i8* %t871, i8* %t870
  %t874 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t875 = icmp eq i32 %t842, 10
  %t876 = select i1 %t875, i8* %t874, i8* %t873
  %t877 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t878 = icmp eq i32 %t842, 11
  %t879 = select i1 %t878, i8* %t877, i8* %t876
  %t880 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t881 = icmp eq i32 %t842, 12
  %t882 = select i1 %t881, i8* %t880, i8* %t879
  %t883 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t884 = icmp eq i32 %t842, 13
  %t885 = select i1 %t884, i8* %t883, i8* %t882
  %t886 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t887 = icmp eq i32 %t842, 14
  %t888 = select i1 %t887, i8* %t886, i8* %t885
  %t889 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t890 = icmp eq i32 %t842, 15
  %t891 = select i1 %t890, i8* %t889, i8* %t888
  %t892 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t893 = icmp eq i32 %t842, 16
  %t894 = select i1 %t893, i8* %t892, i8* %t891
  %t895 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t896 = icmp eq i32 %t842, 17
  %t897 = select i1 %t896, i8* %t895, i8* %t894
  %t898 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t899 = icmp eq i32 %t842, 18
  %t900 = select i1 %t899, i8* %t898, i8* %t897
  %t901 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t902 = icmp eq i32 %t842, 19
  %t903 = select i1 %t902, i8* %t901, i8* %t900
  %t904 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t905 = icmp eq i32 %t842, 20
  %t906 = select i1 %t905, i8* %t904, i8* %t903
  %t907 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t908 = icmp eq i32 %t842, 21
  %t909 = select i1 %t908, i8* %t907, i8* %t906
  %t910 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t911 = icmp eq i32 %t842, 22
  %t912 = select i1 %t911, i8* %t910, i8* %t909
  %t913 = call i8* @malloc(i64 16)
  %t914 = bitcast i8* %t913 to [16 x i8]*
  store [16 x i8] c"EnumDeclaration\00", [16 x i8]* %t914
  %t915 = call i1 @strings_equal(i8* %t912, i8* %t913)
  br i1 %t915, label %then12, label %merge13
then12:
  %t916 = extractvalue %Statement %statement, 0
  %t917 = alloca %Statement
  store %Statement %statement, %Statement* %t917
  %t918 = getelementptr inbounds %Statement, %Statement* %t917, i32 0, i32 1
  %t919 = bitcast [48 x i8]* %t918 to i8*
  %t920 = bitcast i8* %t919 to i8**
  %t921 = load i8*, i8** %t920
  %t922 = icmp eq i32 %t916, 2
  %t923 = select i1 %t922, i8* %t921, i8* null
  %t924 = getelementptr inbounds %Statement, %Statement* %t917, i32 0, i32 1
  %t925 = bitcast [48 x i8]* %t924 to i8*
  %t926 = bitcast i8* %t925 to i8**
  %t927 = load i8*, i8** %t926
  %t928 = icmp eq i32 %t916, 3
  %t929 = select i1 %t928, i8* %t927, i8* %t923
  %t930 = getelementptr inbounds %Statement, %Statement* %t917, i32 0, i32 1
  %t931 = bitcast [56 x i8]* %t930 to i8*
  %t932 = bitcast i8* %t931 to i8**
  %t933 = load i8*, i8** %t932
  %t934 = icmp eq i32 %t916, 6
  %t935 = select i1 %t934, i8* %t933, i8* %t929
  %t936 = getelementptr inbounds %Statement, %Statement* %t917, i32 0, i32 1
  %t937 = bitcast [56 x i8]* %t936 to i8*
  %t938 = bitcast i8* %t937 to i8**
  %t939 = load i8*, i8** %t938
  %t940 = icmp eq i32 %t916, 8
  %t941 = select i1 %t940, i8* %t939, i8* %t935
  %t942 = getelementptr inbounds %Statement, %Statement* %t917, i32 0, i32 1
  %t943 = bitcast [40 x i8]* %t942 to i8*
  %t944 = bitcast i8* %t943 to i8**
  %t945 = load i8*, i8** %t944
  %t946 = icmp eq i32 %t916, 9
  %t947 = select i1 %t946, i8* %t945, i8* %t941
  %t948 = getelementptr inbounds %Statement, %Statement* %t917, i32 0, i32 1
  %t949 = bitcast [40 x i8]* %t948 to i8*
  %t950 = bitcast i8* %t949 to i8**
  %t951 = load i8*, i8** %t950
  %t952 = icmp eq i32 %t916, 10
  %t953 = select i1 %t952, i8* %t951, i8* %t947
  %t954 = getelementptr inbounds %Statement, %Statement* %t917, i32 0, i32 1
  %t955 = bitcast [40 x i8]* %t954 to i8*
  %t956 = bitcast i8* %t955 to i8**
  %t957 = load i8*, i8** %t956
  %t958 = icmp eq i32 %t916, 11
  %t959 = select i1 %t958, i8* %t957, i8* %t953
  %t960 = call i8* @malloc(i64 5)
  %t961 = bitcast i8* %t960 to [5 x i8]*
  store [5 x i8] c"enum\00", [5 x i8]* %t961
  %t962 = extractvalue %Statement %statement, 0
  %t963 = alloca %Statement
  store %Statement %statement, %Statement* %t963
  %t964 = getelementptr inbounds %Statement, %Statement* %t963, i32 0, i32 1
  %t965 = bitcast [48 x i8]* %t964 to i8*
  %t966 = getelementptr inbounds i8, i8* %t965, i64 8
  %t967 = bitcast i8* %t966 to %SourceSpan**
  %t968 = load %SourceSpan*, %SourceSpan** %t967
  %t969 = icmp eq i32 %t962, 3
  %t970 = select i1 %t969, %SourceSpan* %t968, %SourceSpan* null
  %t971 = getelementptr inbounds %Statement, %Statement* %t963, i32 0, i32 1
  %t972 = bitcast [56 x i8]* %t971 to i8*
  %t973 = getelementptr inbounds i8, i8* %t972, i64 8
  %t974 = bitcast i8* %t973 to %SourceSpan**
  %t975 = load %SourceSpan*, %SourceSpan** %t974
  %t976 = icmp eq i32 %t962, 6
  %t977 = select i1 %t976, %SourceSpan* %t975, %SourceSpan* %t970
  %t978 = getelementptr inbounds %Statement, %Statement* %t963, i32 0, i32 1
  %t979 = bitcast [56 x i8]* %t978 to i8*
  %t980 = getelementptr inbounds i8, i8* %t979, i64 8
  %t981 = bitcast i8* %t980 to %SourceSpan**
  %t982 = load %SourceSpan*, %SourceSpan** %t981
  %t983 = icmp eq i32 %t962, 8
  %t984 = select i1 %t983, %SourceSpan* %t982, %SourceSpan* %t977
  %t985 = getelementptr inbounds %Statement, %Statement* %t963, i32 0, i32 1
  %t986 = bitcast [40 x i8]* %t985 to i8*
  %t987 = getelementptr inbounds i8, i8* %t986, i64 8
  %t988 = bitcast i8* %t987 to %SourceSpan**
  %t989 = load %SourceSpan*, %SourceSpan** %t988
  %t990 = icmp eq i32 %t962, 9
  %t991 = select i1 %t990, %SourceSpan* %t989, %SourceSpan* %t984
  %t992 = getelementptr inbounds %Statement, %Statement* %t963, i32 0, i32 1
  %t993 = bitcast [40 x i8]* %t992 to i8*
  %t994 = getelementptr inbounds i8, i8* %t993, i64 8
  %t995 = bitcast i8* %t994 to %SourceSpan**
  %t996 = load %SourceSpan*, %SourceSpan** %t995
  %t997 = icmp eq i32 %t962, 10
  %t998 = select i1 %t997, %SourceSpan* %t996, %SourceSpan* %t991
  %t999 = getelementptr inbounds %Statement, %Statement* %t963, i32 0, i32 1
  %t1000 = bitcast [40 x i8]* %t999 to i8*
  %t1001 = getelementptr inbounds i8, i8* %t1000, i64 8
  %t1002 = bitcast i8* %t1001 to %SourceSpan**
  %t1003 = load %SourceSpan*, %SourceSpan** %t1002
  %t1004 = icmp eq i32 %t962, 11
  %t1005 = select i1 %t1004, %SourceSpan* %t1003, %SourceSpan* %t998
  %t1006 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t959, i8* %t960, %SourceSpan* %t1005)
  store %ScopeResult %t1006, %ScopeResult* %l7
  %t1007 = load %ScopeResult, %ScopeResult* %l7
  %t1008 = extractvalue %ScopeResult %t1007, 1
  store { %Diagnostic*, i64 }* %t1008, { %Diagnostic*, i64 }** %l8
  %t1009 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l8
  %t1010 = extractvalue %Statement %statement, 0
  %t1011 = alloca %Statement
  store %Statement %statement, %Statement* %t1011
  %t1012 = getelementptr inbounds %Statement, %Statement* %t1011, i32 0, i32 1
  %t1013 = bitcast [56 x i8]* %t1012 to i8*
  %t1014 = getelementptr inbounds i8, i8* %t1013, i64 16
  %t1015 = bitcast i8* %t1014 to { %TypeParameter*, i64 }**
  %t1016 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1015
  %t1017 = icmp eq i32 %t1010, 8
  %t1018 = select i1 %t1017, { %TypeParameter*, i64 }* %t1016, { %TypeParameter*, i64 }* null
  %t1019 = getelementptr inbounds %Statement, %Statement* %t1011, i32 0, i32 1
  %t1020 = bitcast [40 x i8]* %t1019 to i8*
  %t1021 = getelementptr inbounds i8, i8* %t1020, i64 16
  %t1022 = bitcast i8* %t1021 to { %TypeParameter*, i64 }**
  %t1023 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1022
  %t1024 = icmp eq i32 %t1010, 9
  %t1025 = select i1 %t1024, { %TypeParameter*, i64 }* %t1023, { %TypeParameter*, i64 }* %t1018
  %t1026 = getelementptr inbounds %Statement, %Statement* %t1011, i32 0, i32 1
  %t1027 = bitcast [40 x i8]* %t1026 to i8*
  %t1028 = getelementptr inbounds i8, i8* %t1027, i64 16
  %t1029 = bitcast i8* %t1028 to { %TypeParameter*, i64 }**
  %t1030 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1029
  %t1031 = icmp eq i32 %t1010, 10
  %t1032 = select i1 %t1031, { %TypeParameter*, i64 }* %t1030, { %TypeParameter*, i64 }* %t1025
  %t1033 = getelementptr inbounds %Statement, %Statement* %t1011, i32 0, i32 1
  %t1034 = bitcast [40 x i8]* %t1033 to i8*
  %t1035 = getelementptr inbounds i8, i8* %t1034, i64 16
  %t1036 = bitcast i8* %t1035 to { %TypeParameter*, i64 }**
  %t1037 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1036
  %t1038 = icmp eq i32 %t1010, 11
  %t1039 = select i1 %t1038, { %TypeParameter*, i64 }* %t1037, { %TypeParameter*, i64 }* %t1032
  %t1040 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t1039)
  %t1041 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1009, i32 0, i32 0
  %t1042 = load %Diagnostic*, %Diagnostic** %t1041
  %t1043 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1009, i32 0, i32 1
  %t1044 = load i64, i64* %t1043
  %t1045 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1040, i32 0, i32 0
  %t1046 = load %Diagnostic*, %Diagnostic** %t1045
  %t1047 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1040, i32 0, i32 1
  %t1048 = load i64, i64* %t1047
  %t1049 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t1050 = ptrtoint %Diagnostic* %t1049 to i64
  %t1051 = add i64 %t1044, %t1048
  %t1052 = mul i64 %t1050, %t1051
  %t1053 = call noalias i8* @malloc(i64 %t1052)
  %t1054 = bitcast i8* %t1053 to %Diagnostic*
  %t1055 = bitcast %Diagnostic* %t1054 to i8*
  %t1056 = mul i64 %t1050, %t1044
  %t1057 = bitcast %Diagnostic* %t1042 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1055, i8* %t1057, i64 %t1056)
  %t1058 = mul i64 %t1050, %t1048
  %t1059 = bitcast %Diagnostic* %t1046 to i8*
  %t1060 = getelementptr %Diagnostic, %Diagnostic* %t1054, i64 %t1044
  %t1061 = bitcast %Diagnostic* %t1060 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1061, i8* %t1059, i64 %t1058)
  %t1062 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1063 = ptrtoint { %Diagnostic*, i64 }* %t1062 to i64
  %t1064 = call i8* @malloc(i64 %t1063)
  %t1065 = bitcast i8* %t1064 to { %Diagnostic*, i64 }*
  %t1066 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1065, i32 0, i32 0
  store %Diagnostic* %t1054, %Diagnostic** %t1066
  %t1067 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1065, i32 0, i32 1
  store i64 %t1051, i64* %t1067
  store { %Diagnostic*, i64 }* %t1065, { %Diagnostic*, i64 }** %l8
  %t1068 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l8
  %t1069 = extractvalue %Statement %statement, 0
  %t1070 = alloca %Statement
  store %Statement %statement, %Statement* %t1070
  %t1071 = getelementptr inbounds %Statement, %Statement* %t1070, i32 0, i32 1
  %t1072 = bitcast [40 x i8]* %t1071 to i8*
  %t1073 = getelementptr inbounds i8, i8* %t1072, i64 24
  %t1074 = bitcast i8* %t1073 to { %EnumVariant*, i64 }**
  %t1075 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %t1074
  %t1076 = icmp eq i32 %t1069, 11
  %t1077 = select i1 %t1076, { %EnumVariant*, i64 }* %t1075, { %EnumVariant*, i64 }* null
  %t1078 = call { %Diagnostic*, i64 }* @check_enum_variants({ %EnumVariant*, i64 }* %t1077)
  %t1079 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1068, i32 0, i32 0
  %t1080 = load %Diagnostic*, %Diagnostic** %t1079
  %t1081 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1068, i32 0, i32 1
  %t1082 = load i64, i64* %t1081
  %t1083 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1078, i32 0, i32 0
  %t1084 = load %Diagnostic*, %Diagnostic** %t1083
  %t1085 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1078, i32 0, i32 1
  %t1086 = load i64, i64* %t1085
  %t1087 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t1088 = ptrtoint %Diagnostic* %t1087 to i64
  %t1089 = add i64 %t1082, %t1086
  %t1090 = mul i64 %t1088, %t1089
  %t1091 = call noalias i8* @malloc(i64 %t1090)
  %t1092 = bitcast i8* %t1091 to %Diagnostic*
  %t1093 = bitcast %Diagnostic* %t1092 to i8*
  %t1094 = mul i64 %t1088, %t1082
  %t1095 = bitcast %Diagnostic* %t1080 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1093, i8* %t1095, i64 %t1094)
  %t1096 = mul i64 %t1088, %t1086
  %t1097 = bitcast %Diagnostic* %t1084 to i8*
  %t1098 = getelementptr %Diagnostic, %Diagnostic* %t1092, i64 %t1082
  %t1099 = bitcast %Diagnostic* %t1098 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1099, i8* %t1097, i64 %t1096)
  %t1100 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1101 = ptrtoint { %Diagnostic*, i64 }* %t1100 to i64
  %t1102 = call i8* @malloc(i64 %t1101)
  %t1103 = bitcast i8* %t1102 to { %Diagnostic*, i64 }*
  %t1104 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1103, i32 0, i32 0
  store %Diagnostic* %t1092, %Diagnostic** %t1104
  %t1105 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1103, i32 0, i32 1
  store i64 %t1089, i64* %t1105
  store { %Diagnostic*, i64 }* %t1103, { %Diagnostic*, i64 }** %l8
  %t1106 = load %ScopeResult, %ScopeResult* %l7
  %t1107 = extractvalue %ScopeResult %t1106, 0
  %t1108 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t1107, 0
  %t1109 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l8
  %t1110 = insertvalue %ScopeResult %t1108, { %Diagnostic*, i64 }* %t1109, 1
  ret %ScopeResult %t1110
merge13:
  %t1111 = extractvalue %Statement %statement, 0
  %t1112 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1113 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1114 = icmp eq i32 %t1111, 0
  %t1115 = select i1 %t1114, i8* %t1113, i8* %t1112
  %t1116 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1117 = icmp eq i32 %t1111, 1
  %t1118 = select i1 %t1117, i8* %t1116, i8* %t1115
  %t1119 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1120 = icmp eq i32 %t1111, 2
  %t1121 = select i1 %t1120, i8* %t1119, i8* %t1118
  %t1122 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1123 = icmp eq i32 %t1111, 3
  %t1124 = select i1 %t1123, i8* %t1122, i8* %t1121
  %t1125 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1126 = icmp eq i32 %t1111, 4
  %t1127 = select i1 %t1126, i8* %t1125, i8* %t1124
  %t1128 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1129 = icmp eq i32 %t1111, 5
  %t1130 = select i1 %t1129, i8* %t1128, i8* %t1127
  %t1131 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1132 = icmp eq i32 %t1111, 6
  %t1133 = select i1 %t1132, i8* %t1131, i8* %t1130
  %t1134 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1135 = icmp eq i32 %t1111, 7
  %t1136 = select i1 %t1135, i8* %t1134, i8* %t1133
  %t1137 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1138 = icmp eq i32 %t1111, 8
  %t1139 = select i1 %t1138, i8* %t1137, i8* %t1136
  %t1140 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1141 = icmp eq i32 %t1111, 9
  %t1142 = select i1 %t1141, i8* %t1140, i8* %t1139
  %t1143 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1144 = icmp eq i32 %t1111, 10
  %t1145 = select i1 %t1144, i8* %t1143, i8* %t1142
  %t1146 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1147 = icmp eq i32 %t1111, 11
  %t1148 = select i1 %t1147, i8* %t1146, i8* %t1145
  %t1149 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1150 = icmp eq i32 %t1111, 12
  %t1151 = select i1 %t1150, i8* %t1149, i8* %t1148
  %t1152 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1153 = icmp eq i32 %t1111, 13
  %t1154 = select i1 %t1153, i8* %t1152, i8* %t1151
  %t1155 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1156 = icmp eq i32 %t1111, 14
  %t1157 = select i1 %t1156, i8* %t1155, i8* %t1154
  %t1158 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1159 = icmp eq i32 %t1111, 15
  %t1160 = select i1 %t1159, i8* %t1158, i8* %t1157
  %t1161 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1162 = icmp eq i32 %t1111, 16
  %t1163 = select i1 %t1162, i8* %t1161, i8* %t1160
  %t1164 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1165 = icmp eq i32 %t1111, 17
  %t1166 = select i1 %t1165, i8* %t1164, i8* %t1163
  %t1167 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1168 = icmp eq i32 %t1111, 18
  %t1169 = select i1 %t1168, i8* %t1167, i8* %t1166
  %t1170 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1171 = icmp eq i32 %t1111, 19
  %t1172 = select i1 %t1171, i8* %t1170, i8* %t1169
  %t1173 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1174 = icmp eq i32 %t1111, 20
  %t1175 = select i1 %t1174, i8* %t1173, i8* %t1172
  %t1176 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1177 = icmp eq i32 %t1111, 21
  %t1178 = select i1 %t1177, i8* %t1176, i8* %t1175
  %t1179 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1180 = icmp eq i32 %t1111, 22
  %t1181 = select i1 %t1180, i8* %t1179, i8* %t1178
  %t1182 = call i8* @malloc(i64 21)
  %t1183 = bitcast i8* %t1182 to [21 x i8]*
  store [21 x i8] c"InterfaceDeclaration\00", [21 x i8]* %t1183
  %t1184 = call i1 @strings_equal(i8* %t1181, i8* %t1182)
  br i1 %t1184, label %then14, label %merge15
then14:
  %t1185 = extractvalue %Statement %statement, 0
  %t1186 = alloca %Statement
  store %Statement %statement, %Statement* %t1186
  %t1187 = getelementptr inbounds %Statement, %Statement* %t1186, i32 0, i32 1
  %t1188 = bitcast [48 x i8]* %t1187 to i8*
  %t1189 = bitcast i8* %t1188 to i8**
  %t1190 = load i8*, i8** %t1189
  %t1191 = icmp eq i32 %t1185, 2
  %t1192 = select i1 %t1191, i8* %t1190, i8* null
  %t1193 = getelementptr inbounds %Statement, %Statement* %t1186, i32 0, i32 1
  %t1194 = bitcast [48 x i8]* %t1193 to i8*
  %t1195 = bitcast i8* %t1194 to i8**
  %t1196 = load i8*, i8** %t1195
  %t1197 = icmp eq i32 %t1185, 3
  %t1198 = select i1 %t1197, i8* %t1196, i8* %t1192
  %t1199 = getelementptr inbounds %Statement, %Statement* %t1186, i32 0, i32 1
  %t1200 = bitcast [56 x i8]* %t1199 to i8*
  %t1201 = bitcast i8* %t1200 to i8**
  %t1202 = load i8*, i8** %t1201
  %t1203 = icmp eq i32 %t1185, 6
  %t1204 = select i1 %t1203, i8* %t1202, i8* %t1198
  %t1205 = getelementptr inbounds %Statement, %Statement* %t1186, i32 0, i32 1
  %t1206 = bitcast [56 x i8]* %t1205 to i8*
  %t1207 = bitcast i8* %t1206 to i8**
  %t1208 = load i8*, i8** %t1207
  %t1209 = icmp eq i32 %t1185, 8
  %t1210 = select i1 %t1209, i8* %t1208, i8* %t1204
  %t1211 = getelementptr inbounds %Statement, %Statement* %t1186, i32 0, i32 1
  %t1212 = bitcast [40 x i8]* %t1211 to i8*
  %t1213 = bitcast i8* %t1212 to i8**
  %t1214 = load i8*, i8** %t1213
  %t1215 = icmp eq i32 %t1185, 9
  %t1216 = select i1 %t1215, i8* %t1214, i8* %t1210
  %t1217 = getelementptr inbounds %Statement, %Statement* %t1186, i32 0, i32 1
  %t1218 = bitcast [40 x i8]* %t1217 to i8*
  %t1219 = bitcast i8* %t1218 to i8**
  %t1220 = load i8*, i8** %t1219
  %t1221 = icmp eq i32 %t1185, 10
  %t1222 = select i1 %t1221, i8* %t1220, i8* %t1216
  %t1223 = getelementptr inbounds %Statement, %Statement* %t1186, i32 0, i32 1
  %t1224 = bitcast [40 x i8]* %t1223 to i8*
  %t1225 = bitcast i8* %t1224 to i8**
  %t1226 = load i8*, i8** %t1225
  %t1227 = icmp eq i32 %t1185, 11
  %t1228 = select i1 %t1227, i8* %t1226, i8* %t1222
  %t1229 = call i8* @malloc(i64 10)
  %t1230 = bitcast i8* %t1229 to [10 x i8]*
  store [10 x i8] c"interface\00", [10 x i8]* %t1230
  %t1231 = extractvalue %Statement %statement, 0
  %t1232 = alloca %Statement
  store %Statement %statement, %Statement* %t1232
  %t1233 = getelementptr inbounds %Statement, %Statement* %t1232, i32 0, i32 1
  %t1234 = bitcast [48 x i8]* %t1233 to i8*
  %t1235 = getelementptr inbounds i8, i8* %t1234, i64 8
  %t1236 = bitcast i8* %t1235 to %SourceSpan**
  %t1237 = load %SourceSpan*, %SourceSpan** %t1236
  %t1238 = icmp eq i32 %t1231, 3
  %t1239 = select i1 %t1238, %SourceSpan* %t1237, %SourceSpan* null
  %t1240 = getelementptr inbounds %Statement, %Statement* %t1232, i32 0, i32 1
  %t1241 = bitcast [56 x i8]* %t1240 to i8*
  %t1242 = getelementptr inbounds i8, i8* %t1241, i64 8
  %t1243 = bitcast i8* %t1242 to %SourceSpan**
  %t1244 = load %SourceSpan*, %SourceSpan** %t1243
  %t1245 = icmp eq i32 %t1231, 6
  %t1246 = select i1 %t1245, %SourceSpan* %t1244, %SourceSpan* %t1239
  %t1247 = getelementptr inbounds %Statement, %Statement* %t1232, i32 0, i32 1
  %t1248 = bitcast [56 x i8]* %t1247 to i8*
  %t1249 = getelementptr inbounds i8, i8* %t1248, i64 8
  %t1250 = bitcast i8* %t1249 to %SourceSpan**
  %t1251 = load %SourceSpan*, %SourceSpan** %t1250
  %t1252 = icmp eq i32 %t1231, 8
  %t1253 = select i1 %t1252, %SourceSpan* %t1251, %SourceSpan* %t1246
  %t1254 = getelementptr inbounds %Statement, %Statement* %t1232, i32 0, i32 1
  %t1255 = bitcast [40 x i8]* %t1254 to i8*
  %t1256 = getelementptr inbounds i8, i8* %t1255, i64 8
  %t1257 = bitcast i8* %t1256 to %SourceSpan**
  %t1258 = load %SourceSpan*, %SourceSpan** %t1257
  %t1259 = icmp eq i32 %t1231, 9
  %t1260 = select i1 %t1259, %SourceSpan* %t1258, %SourceSpan* %t1253
  %t1261 = getelementptr inbounds %Statement, %Statement* %t1232, i32 0, i32 1
  %t1262 = bitcast [40 x i8]* %t1261 to i8*
  %t1263 = getelementptr inbounds i8, i8* %t1262, i64 8
  %t1264 = bitcast i8* %t1263 to %SourceSpan**
  %t1265 = load %SourceSpan*, %SourceSpan** %t1264
  %t1266 = icmp eq i32 %t1231, 10
  %t1267 = select i1 %t1266, %SourceSpan* %t1265, %SourceSpan* %t1260
  %t1268 = getelementptr inbounds %Statement, %Statement* %t1232, i32 0, i32 1
  %t1269 = bitcast [40 x i8]* %t1268 to i8*
  %t1270 = getelementptr inbounds i8, i8* %t1269, i64 8
  %t1271 = bitcast i8* %t1270 to %SourceSpan**
  %t1272 = load %SourceSpan*, %SourceSpan** %t1271
  %t1273 = icmp eq i32 %t1231, 11
  %t1274 = select i1 %t1273, %SourceSpan* %t1272, %SourceSpan* %t1267
  %t1275 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1228, i8* %t1229, %SourceSpan* %t1274)
  store %ScopeResult %t1275, %ScopeResult* %l9
  %t1276 = load %ScopeResult, %ScopeResult* %l9
  %t1277 = extractvalue %ScopeResult %t1276, 1
  store { %Diagnostic*, i64 }* %t1277, { %Diagnostic*, i64 }** %l10
  %t1278 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l10
  %t1279 = extractvalue %Statement %statement, 0
  %t1280 = alloca %Statement
  store %Statement %statement, %Statement* %t1280
  %t1281 = getelementptr inbounds %Statement, %Statement* %t1280, i32 0, i32 1
  %t1282 = bitcast [56 x i8]* %t1281 to i8*
  %t1283 = getelementptr inbounds i8, i8* %t1282, i64 16
  %t1284 = bitcast i8* %t1283 to { %TypeParameter*, i64 }**
  %t1285 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1284
  %t1286 = icmp eq i32 %t1279, 8
  %t1287 = select i1 %t1286, { %TypeParameter*, i64 }* %t1285, { %TypeParameter*, i64 }* null
  %t1288 = getelementptr inbounds %Statement, %Statement* %t1280, i32 0, i32 1
  %t1289 = bitcast [40 x i8]* %t1288 to i8*
  %t1290 = getelementptr inbounds i8, i8* %t1289, i64 16
  %t1291 = bitcast i8* %t1290 to { %TypeParameter*, i64 }**
  %t1292 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1291
  %t1293 = icmp eq i32 %t1279, 9
  %t1294 = select i1 %t1293, { %TypeParameter*, i64 }* %t1292, { %TypeParameter*, i64 }* %t1287
  %t1295 = getelementptr inbounds %Statement, %Statement* %t1280, i32 0, i32 1
  %t1296 = bitcast [40 x i8]* %t1295 to i8*
  %t1297 = getelementptr inbounds i8, i8* %t1296, i64 16
  %t1298 = bitcast i8* %t1297 to { %TypeParameter*, i64 }**
  %t1299 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1298
  %t1300 = icmp eq i32 %t1279, 10
  %t1301 = select i1 %t1300, { %TypeParameter*, i64 }* %t1299, { %TypeParameter*, i64 }* %t1294
  %t1302 = getelementptr inbounds %Statement, %Statement* %t1280, i32 0, i32 1
  %t1303 = bitcast [40 x i8]* %t1302 to i8*
  %t1304 = getelementptr inbounds i8, i8* %t1303, i64 16
  %t1305 = bitcast i8* %t1304 to { %TypeParameter*, i64 }**
  %t1306 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1305
  %t1307 = icmp eq i32 %t1279, 11
  %t1308 = select i1 %t1307, { %TypeParameter*, i64 }* %t1306, { %TypeParameter*, i64 }* %t1301
  %t1309 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t1308)
  %t1310 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1278, i32 0, i32 0
  %t1311 = load %Diagnostic*, %Diagnostic** %t1310
  %t1312 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1278, i32 0, i32 1
  %t1313 = load i64, i64* %t1312
  %t1314 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1309, i32 0, i32 0
  %t1315 = load %Diagnostic*, %Diagnostic** %t1314
  %t1316 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1309, i32 0, i32 1
  %t1317 = load i64, i64* %t1316
  %t1318 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t1319 = ptrtoint %Diagnostic* %t1318 to i64
  %t1320 = add i64 %t1313, %t1317
  %t1321 = mul i64 %t1319, %t1320
  %t1322 = call noalias i8* @malloc(i64 %t1321)
  %t1323 = bitcast i8* %t1322 to %Diagnostic*
  %t1324 = bitcast %Diagnostic* %t1323 to i8*
  %t1325 = mul i64 %t1319, %t1313
  %t1326 = bitcast %Diagnostic* %t1311 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1324, i8* %t1326, i64 %t1325)
  %t1327 = mul i64 %t1319, %t1317
  %t1328 = bitcast %Diagnostic* %t1315 to i8*
  %t1329 = getelementptr %Diagnostic, %Diagnostic* %t1323, i64 %t1313
  %t1330 = bitcast %Diagnostic* %t1329 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1330, i8* %t1328, i64 %t1327)
  %t1331 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1332 = ptrtoint { %Diagnostic*, i64 }* %t1331 to i64
  %t1333 = call i8* @malloc(i64 %t1332)
  %t1334 = bitcast i8* %t1333 to { %Diagnostic*, i64 }*
  %t1335 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1334, i32 0, i32 0
  store %Diagnostic* %t1323, %Diagnostic** %t1335
  %t1336 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1334, i32 0, i32 1
  store i64 %t1320, i64* %t1336
  store { %Diagnostic*, i64 }* %t1334, { %Diagnostic*, i64 }** %l10
  %t1337 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l10
  %t1338 = extractvalue %Statement %statement, 0
  %t1339 = alloca %Statement
  store %Statement %statement, %Statement* %t1339
  %t1340 = getelementptr inbounds %Statement, %Statement* %t1339, i32 0, i32 1
  %t1341 = bitcast [40 x i8]* %t1340 to i8*
  %t1342 = getelementptr inbounds i8, i8* %t1341, i64 24
  %t1343 = bitcast i8* %t1342 to { %FunctionSignature*, i64 }**
  %t1344 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %t1343
  %t1345 = icmp eq i32 %t1338, 10
  %t1346 = select i1 %t1345, { %FunctionSignature*, i64 }* %t1344, { %FunctionSignature*, i64 }* null
  %t1347 = call { %Diagnostic*, i64 }* @check_interface_members({ %FunctionSignature*, i64 }* %t1346)
  %t1348 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1337, i32 0, i32 0
  %t1349 = load %Diagnostic*, %Diagnostic** %t1348
  %t1350 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1337, i32 0, i32 1
  %t1351 = load i64, i64* %t1350
  %t1352 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1347, i32 0, i32 0
  %t1353 = load %Diagnostic*, %Diagnostic** %t1352
  %t1354 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1347, i32 0, i32 1
  %t1355 = load i64, i64* %t1354
  %t1356 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t1357 = ptrtoint %Diagnostic* %t1356 to i64
  %t1358 = add i64 %t1351, %t1355
  %t1359 = mul i64 %t1357, %t1358
  %t1360 = call noalias i8* @malloc(i64 %t1359)
  %t1361 = bitcast i8* %t1360 to %Diagnostic*
  %t1362 = bitcast %Diagnostic* %t1361 to i8*
  %t1363 = mul i64 %t1357, %t1351
  %t1364 = bitcast %Diagnostic* %t1349 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1362, i8* %t1364, i64 %t1363)
  %t1365 = mul i64 %t1357, %t1355
  %t1366 = bitcast %Diagnostic* %t1353 to i8*
  %t1367 = getelementptr %Diagnostic, %Diagnostic* %t1361, i64 %t1351
  %t1368 = bitcast %Diagnostic* %t1367 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1368, i8* %t1366, i64 %t1365)
  %t1369 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1370 = ptrtoint { %Diagnostic*, i64 }* %t1369 to i64
  %t1371 = call i8* @malloc(i64 %t1370)
  %t1372 = bitcast i8* %t1371 to { %Diagnostic*, i64 }*
  %t1373 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1372, i32 0, i32 0
  store %Diagnostic* %t1361, %Diagnostic** %t1373
  %t1374 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1372, i32 0, i32 1
  store i64 %t1358, i64* %t1374
  store { %Diagnostic*, i64 }* %t1372, { %Diagnostic*, i64 }** %l10
  %t1375 = load %ScopeResult, %ScopeResult* %l9
  %t1376 = extractvalue %ScopeResult %t1375, 0
  %t1377 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t1376, 0
  %t1378 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l10
  %t1379 = insertvalue %ScopeResult %t1377, { %Diagnostic*, i64 }* %t1378, 1
  ret %ScopeResult %t1379
merge15:
  %t1380 = extractvalue %Statement %statement, 0
  %t1381 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1382 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1383 = icmp eq i32 %t1380, 0
  %t1384 = select i1 %t1383, i8* %t1382, i8* %t1381
  %t1385 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1386 = icmp eq i32 %t1380, 1
  %t1387 = select i1 %t1386, i8* %t1385, i8* %t1384
  %t1388 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1389 = icmp eq i32 %t1380, 2
  %t1390 = select i1 %t1389, i8* %t1388, i8* %t1387
  %t1391 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1392 = icmp eq i32 %t1380, 3
  %t1393 = select i1 %t1392, i8* %t1391, i8* %t1390
  %t1394 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1395 = icmp eq i32 %t1380, 4
  %t1396 = select i1 %t1395, i8* %t1394, i8* %t1393
  %t1397 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1398 = icmp eq i32 %t1380, 5
  %t1399 = select i1 %t1398, i8* %t1397, i8* %t1396
  %t1400 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1401 = icmp eq i32 %t1380, 6
  %t1402 = select i1 %t1401, i8* %t1400, i8* %t1399
  %t1403 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1404 = icmp eq i32 %t1380, 7
  %t1405 = select i1 %t1404, i8* %t1403, i8* %t1402
  %t1406 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1407 = icmp eq i32 %t1380, 8
  %t1408 = select i1 %t1407, i8* %t1406, i8* %t1405
  %t1409 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1410 = icmp eq i32 %t1380, 9
  %t1411 = select i1 %t1410, i8* %t1409, i8* %t1408
  %t1412 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1413 = icmp eq i32 %t1380, 10
  %t1414 = select i1 %t1413, i8* %t1412, i8* %t1411
  %t1415 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1416 = icmp eq i32 %t1380, 11
  %t1417 = select i1 %t1416, i8* %t1415, i8* %t1414
  %t1418 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1419 = icmp eq i32 %t1380, 12
  %t1420 = select i1 %t1419, i8* %t1418, i8* %t1417
  %t1421 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1422 = icmp eq i32 %t1380, 13
  %t1423 = select i1 %t1422, i8* %t1421, i8* %t1420
  %t1424 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1425 = icmp eq i32 %t1380, 14
  %t1426 = select i1 %t1425, i8* %t1424, i8* %t1423
  %t1427 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1428 = icmp eq i32 %t1380, 15
  %t1429 = select i1 %t1428, i8* %t1427, i8* %t1426
  %t1430 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1431 = icmp eq i32 %t1380, 16
  %t1432 = select i1 %t1431, i8* %t1430, i8* %t1429
  %t1433 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1434 = icmp eq i32 %t1380, 17
  %t1435 = select i1 %t1434, i8* %t1433, i8* %t1432
  %t1436 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1437 = icmp eq i32 %t1380, 18
  %t1438 = select i1 %t1437, i8* %t1436, i8* %t1435
  %t1439 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1440 = icmp eq i32 %t1380, 19
  %t1441 = select i1 %t1440, i8* %t1439, i8* %t1438
  %t1442 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1443 = icmp eq i32 %t1380, 20
  %t1444 = select i1 %t1443, i8* %t1442, i8* %t1441
  %t1445 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1446 = icmp eq i32 %t1380, 21
  %t1447 = select i1 %t1446, i8* %t1445, i8* %t1444
  %t1448 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1449 = icmp eq i32 %t1380, 22
  %t1450 = select i1 %t1449, i8* %t1448, i8* %t1447
  %t1451 = call i8* @malloc(i64 17)
  %t1452 = bitcast i8* %t1451 to [17 x i8]*
  store [17 x i8] c"ModelDeclaration\00", [17 x i8]* %t1452
  %t1453 = call i1 @strings_equal(i8* %t1450, i8* %t1451)
  br i1 %t1453, label %then16, label %merge17
then16:
  %t1454 = extractvalue %Statement %statement, 0
  %t1455 = alloca %Statement
  store %Statement %statement, %Statement* %t1455
  %t1456 = getelementptr inbounds %Statement, %Statement* %t1455, i32 0, i32 1
  %t1457 = bitcast [48 x i8]* %t1456 to i8*
  %t1458 = bitcast i8* %t1457 to i8**
  %t1459 = load i8*, i8** %t1458
  %t1460 = icmp eq i32 %t1454, 2
  %t1461 = select i1 %t1460, i8* %t1459, i8* null
  %t1462 = getelementptr inbounds %Statement, %Statement* %t1455, i32 0, i32 1
  %t1463 = bitcast [48 x i8]* %t1462 to i8*
  %t1464 = bitcast i8* %t1463 to i8**
  %t1465 = load i8*, i8** %t1464
  %t1466 = icmp eq i32 %t1454, 3
  %t1467 = select i1 %t1466, i8* %t1465, i8* %t1461
  %t1468 = getelementptr inbounds %Statement, %Statement* %t1455, i32 0, i32 1
  %t1469 = bitcast [56 x i8]* %t1468 to i8*
  %t1470 = bitcast i8* %t1469 to i8**
  %t1471 = load i8*, i8** %t1470
  %t1472 = icmp eq i32 %t1454, 6
  %t1473 = select i1 %t1472, i8* %t1471, i8* %t1467
  %t1474 = getelementptr inbounds %Statement, %Statement* %t1455, i32 0, i32 1
  %t1475 = bitcast [56 x i8]* %t1474 to i8*
  %t1476 = bitcast i8* %t1475 to i8**
  %t1477 = load i8*, i8** %t1476
  %t1478 = icmp eq i32 %t1454, 8
  %t1479 = select i1 %t1478, i8* %t1477, i8* %t1473
  %t1480 = getelementptr inbounds %Statement, %Statement* %t1455, i32 0, i32 1
  %t1481 = bitcast [40 x i8]* %t1480 to i8*
  %t1482 = bitcast i8* %t1481 to i8**
  %t1483 = load i8*, i8** %t1482
  %t1484 = icmp eq i32 %t1454, 9
  %t1485 = select i1 %t1484, i8* %t1483, i8* %t1479
  %t1486 = getelementptr inbounds %Statement, %Statement* %t1455, i32 0, i32 1
  %t1487 = bitcast [40 x i8]* %t1486 to i8*
  %t1488 = bitcast i8* %t1487 to i8**
  %t1489 = load i8*, i8** %t1488
  %t1490 = icmp eq i32 %t1454, 10
  %t1491 = select i1 %t1490, i8* %t1489, i8* %t1485
  %t1492 = getelementptr inbounds %Statement, %Statement* %t1455, i32 0, i32 1
  %t1493 = bitcast [40 x i8]* %t1492 to i8*
  %t1494 = bitcast i8* %t1493 to i8**
  %t1495 = load i8*, i8** %t1494
  %t1496 = icmp eq i32 %t1454, 11
  %t1497 = select i1 %t1496, i8* %t1495, i8* %t1491
  %t1498 = call i8* @malloc(i64 6)
  %t1499 = bitcast i8* %t1498 to [6 x i8]*
  store [6 x i8] c"model\00", [6 x i8]* %t1499
  %t1500 = extractvalue %Statement %statement, 0
  %t1501 = alloca %Statement
  store %Statement %statement, %Statement* %t1501
  %t1502 = getelementptr inbounds %Statement, %Statement* %t1501, i32 0, i32 1
  %t1503 = bitcast [48 x i8]* %t1502 to i8*
  %t1504 = getelementptr inbounds i8, i8* %t1503, i64 8
  %t1505 = bitcast i8* %t1504 to %SourceSpan**
  %t1506 = load %SourceSpan*, %SourceSpan** %t1505
  %t1507 = icmp eq i32 %t1500, 3
  %t1508 = select i1 %t1507, %SourceSpan* %t1506, %SourceSpan* null
  %t1509 = getelementptr inbounds %Statement, %Statement* %t1501, i32 0, i32 1
  %t1510 = bitcast [56 x i8]* %t1509 to i8*
  %t1511 = getelementptr inbounds i8, i8* %t1510, i64 8
  %t1512 = bitcast i8* %t1511 to %SourceSpan**
  %t1513 = load %SourceSpan*, %SourceSpan** %t1512
  %t1514 = icmp eq i32 %t1500, 6
  %t1515 = select i1 %t1514, %SourceSpan* %t1513, %SourceSpan* %t1508
  %t1516 = getelementptr inbounds %Statement, %Statement* %t1501, i32 0, i32 1
  %t1517 = bitcast [56 x i8]* %t1516 to i8*
  %t1518 = getelementptr inbounds i8, i8* %t1517, i64 8
  %t1519 = bitcast i8* %t1518 to %SourceSpan**
  %t1520 = load %SourceSpan*, %SourceSpan** %t1519
  %t1521 = icmp eq i32 %t1500, 8
  %t1522 = select i1 %t1521, %SourceSpan* %t1520, %SourceSpan* %t1515
  %t1523 = getelementptr inbounds %Statement, %Statement* %t1501, i32 0, i32 1
  %t1524 = bitcast [40 x i8]* %t1523 to i8*
  %t1525 = getelementptr inbounds i8, i8* %t1524, i64 8
  %t1526 = bitcast i8* %t1525 to %SourceSpan**
  %t1527 = load %SourceSpan*, %SourceSpan** %t1526
  %t1528 = icmp eq i32 %t1500, 9
  %t1529 = select i1 %t1528, %SourceSpan* %t1527, %SourceSpan* %t1522
  %t1530 = getelementptr inbounds %Statement, %Statement* %t1501, i32 0, i32 1
  %t1531 = bitcast [40 x i8]* %t1530 to i8*
  %t1532 = getelementptr inbounds i8, i8* %t1531, i64 8
  %t1533 = bitcast i8* %t1532 to %SourceSpan**
  %t1534 = load %SourceSpan*, %SourceSpan** %t1533
  %t1535 = icmp eq i32 %t1500, 10
  %t1536 = select i1 %t1535, %SourceSpan* %t1534, %SourceSpan* %t1529
  %t1537 = getelementptr inbounds %Statement, %Statement* %t1501, i32 0, i32 1
  %t1538 = bitcast [40 x i8]* %t1537 to i8*
  %t1539 = getelementptr inbounds i8, i8* %t1538, i64 8
  %t1540 = bitcast i8* %t1539 to %SourceSpan**
  %t1541 = load %SourceSpan*, %SourceSpan** %t1540
  %t1542 = icmp eq i32 %t1500, 11
  %t1543 = select i1 %t1542, %SourceSpan* %t1541, %SourceSpan* %t1536
  %t1544 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1497, i8* %t1498, %SourceSpan* %t1543)
  store %ScopeResult %t1544, %ScopeResult* %l11
  %t1545 = load %ScopeResult, %ScopeResult* %l11
  %t1546 = extractvalue %ScopeResult %t1545, 1
  %t1547 = extractvalue %Statement %statement, 0
  %t1548 = alloca %Statement
  store %Statement %statement, %Statement* %t1548
  %t1549 = getelementptr inbounds %Statement, %Statement* %t1548, i32 0, i32 1
  %t1550 = bitcast [48 x i8]* %t1549 to i8*
  %t1551 = getelementptr inbounds i8, i8* %t1550, i64 24
  %t1552 = bitcast i8* %t1551 to { %ModelProperty*, i64 }**
  %t1553 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %t1552
  %t1554 = icmp eq i32 %t1547, 3
  %t1555 = select i1 %t1554, { %ModelProperty*, i64 }* %t1553, { %ModelProperty*, i64 }* null
  %t1556 = call { %Diagnostic*, i64 }* @check_model_properties({ %ModelProperty*, i64 }* %t1555)
  %t1557 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1546, i32 0, i32 0
  %t1558 = load %Diagnostic*, %Diagnostic** %t1557
  %t1559 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1546, i32 0, i32 1
  %t1560 = load i64, i64* %t1559
  %t1561 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1556, i32 0, i32 0
  %t1562 = load %Diagnostic*, %Diagnostic** %t1561
  %t1563 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1556, i32 0, i32 1
  %t1564 = load i64, i64* %t1563
  %t1565 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t1566 = ptrtoint %Diagnostic* %t1565 to i64
  %t1567 = add i64 %t1560, %t1564
  %t1568 = mul i64 %t1566, %t1567
  %t1569 = call noalias i8* @malloc(i64 %t1568)
  %t1570 = bitcast i8* %t1569 to %Diagnostic*
  %t1571 = bitcast %Diagnostic* %t1570 to i8*
  %t1572 = mul i64 %t1566, %t1560
  %t1573 = bitcast %Diagnostic* %t1558 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1571, i8* %t1573, i64 %t1572)
  %t1574 = mul i64 %t1566, %t1564
  %t1575 = bitcast %Diagnostic* %t1562 to i8*
  %t1576 = getelementptr %Diagnostic, %Diagnostic* %t1570, i64 %t1560
  %t1577 = bitcast %Diagnostic* %t1576 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1577, i8* %t1575, i64 %t1574)
  %t1578 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1579 = ptrtoint { %Diagnostic*, i64 }* %t1578 to i64
  %t1580 = call i8* @malloc(i64 %t1579)
  %t1581 = bitcast i8* %t1580 to { %Diagnostic*, i64 }*
  %t1582 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1581, i32 0, i32 0
  store %Diagnostic* %t1570, %Diagnostic** %t1582
  %t1583 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1581, i32 0, i32 1
  store i64 %t1567, i64* %t1583
  store { %Diagnostic*, i64 }* %t1581, { %Diagnostic*, i64 }** %l12
  %t1584 = load %ScopeResult, %ScopeResult* %l11
  %t1585 = extractvalue %ScopeResult %t1584, 0
  %t1586 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t1585, 0
  %t1587 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l12
  %t1588 = insertvalue %ScopeResult %t1586, { %Diagnostic*, i64 }* %t1587, 1
  ret %ScopeResult %t1588
merge17:
  %t1589 = extractvalue %Statement %statement, 0
  %t1590 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1591 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1592 = icmp eq i32 %t1589, 0
  %t1593 = select i1 %t1592, i8* %t1591, i8* %t1590
  %t1594 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1595 = icmp eq i32 %t1589, 1
  %t1596 = select i1 %t1595, i8* %t1594, i8* %t1593
  %t1597 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1598 = icmp eq i32 %t1589, 2
  %t1599 = select i1 %t1598, i8* %t1597, i8* %t1596
  %t1600 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1601 = icmp eq i32 %t1589, 3
  %t1602 = select i1 %t1601, i8* %t1600, i8* %t1599
  %t1603 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1604 = icmp eq i32 %t1589, 4
  %t1605 = select i1 %t1604, i8* %t1603, i8* %t1602
  %t1606 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1607 = icmp eq i32 %t1589, 5
  %t1608 = select i1 %t1607, i8* %t1606, i8* %t1605
  %t1609 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1610 = icmp eq i32 %t1589, 6
  %t1611 = select i1 %t1610, i8* %t1609, i8* %t1608
  %t1612 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1613 = icmp eq i32 %t1589, 7
  %t1614 = select i1 %t1613, i8* %t1612, i8* %t1611
  %t1615 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1616 = icmp eq i32 %t1589, 8
  %t1617 = select i1 %t1616, i8* %t1615, i8* %t1614
  %t1618 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1619 = icmp eq i32 %t1589, 9
  %t1620 = select i1 %t1619, i8* %t1618, i8* %t1617
  %t1621 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1622 = icmp eq i32 %t1589, 10
  %t1623 = select i1 %t1622, i8* %t1621, i8* %t1620
  %t1624 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1625 = icmp eq i32 %t1589, 11
  %t1626 = select i1 %t1625, i8* %t1624, i8* %t1623
  %t1627 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1628 = icmp eq i32 %t1589, 12
  %t1629 = select i1 %t1628, i8* %t1627, i8* %t1626
  %t1630 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1631 = icmp eq i32 %t1589, 13
  %t1632 = select i1 %t1631, i8* %t1630, i8* %t1629
  %t1633 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1634 = icmp eq i32 %t1589, 14
  %t1635 = select i1 %t1634, i8* %t1633, i8* %t1632
  %t1636 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1637 = icmp eq i32 %t1589, 15
  %t1638 = select i1 %t1637, i8* %t1636, i8* %t1635
  %t1639 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1640 = icmp eq i32 %t1589, 16
  %t1641 = select i1 %t1640, i8* %t1639, i8* %t1638
  %t1642 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1643 = icmp eq i32 %t1589, 17
  %t1644 = select i1 %t1643, i8* %t1642, i8* %t1641
  %t1645 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1646 = icmp eq i32 %t1589, 18
  %t1647 = select i1 %t1646, i8* %t1645, i8* %t1644
  %t1648 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1649 = icmp eq i32 %t1589, 19
  %t1650 = select i1 %t1649, i8* %t1648, i8* %t1647
  %t1651 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1652 = icmp eq i32 %t1589, 20
  %t1653 = select i1 %t1652, i8* %t1651, i8* %t1650
  %t1654 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1655 = icmp eq i32 %t1589, 21
  %t1656 = select i1 %t1655, i8* %t1654, i8* %t1653
  %t1657 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1658 = icmp eq i32 %t1589, 22
  %t1659 = select i1 %t1658, i8* %t1657, i8* %t1656
  %t1660 = call i8* @malloc(i64 20)
  %t1661 = bitcast i8* %t1660 to [20 x i8]*
  store [20 x i8] c"PipelineDeclaration\00", [20 x i8]* %t1661
  %t1662 = call i1 @strings_equal(i8* %t1659, i8* %t1660)
  br i1 %t1662, label %then18, label %merge19
then18:
  %t1663 = extractvalue %Statement %statement, 0
  %t1664 = alloca %Statement
  store %Statement %statement, %Statement* %t1664
  %t1665 = getelementptr inbounds %Statement, %Statement* %t1664, i32 0, i32 1
  %t1666 = bitcast [88 x i8]* %t1665 to i8*
  %t1667 = bitcast i8* %t1666 to %FunctionSignature*
  %t1668 = load %FunctionSignature, %FunctionSignature* %t1667
  %t1669 = icmp eq i32 %t1663, 4
  %t1670 = select i1 %t1669, %FunctionSignature %t1668, %FunctionSignature zeroinitializer
  %t1671 = getelementptr inbounds %Statement, %Statement* %t1664, i32 0, i32 1
  %t1672 = bitcast [88 x i8]* %t1671 to i8*
  %t1673 = bitcast i8* %t1672 to %FunctionSignature*
  %t1674 = load %FunctionSignature, %FunctionSignature* %t1673
  %t1675 = icmp eq i32 %t1663, 5
  %t1676 = select i1 %t1675, %FunctionSignature %t1674, %FunctionSignature %t1670
  %t1677 = getelementptr inbounds %Statement, %Statement* %t1664, i32 0, i32 1
  %t1678 = bitcast [88 x i8]* %t1677 to i8*
  %t1679 = bitcast i8* %t1678 to %FunctionSignature*
  %t1680 = load %FunctionSignature, %FunctionSignature* %t1679
  %t1681 = icmp eq i32 %t1663, 7
  %t1682 = select i1 %t1681, %FunctionSignature %t1680, %FunctionSignature %t1676
  %t1683 = extractvalue %FunctionSignature %t1682, 0
  %t1684 = call i8* @malloc(i64 9)
  %t1685 = bitcast i8* %t1684 to [9 x i8]*
  store [9 x i8] c"pipeline\00", [9 x i8]* %t1685
  %t1686 = extractvalue %Statement %statement, 0
  %t1687 = alloca %Statement
  store %Statement %statement, %Statement* %t1687
  %t1688 = getelementptr inbounds %Statement, %Statement* %t1687, i32 0, i32 1
  %t1689 = bitcast [88 x i8]* %t1688 to i8*
  %t1690 = bitcast i8* %t1689 to %FunctionSignature*
  %t1691 = load %FunctionSignature, %FunctionSignature* %t1690
  %t1692 = icmp eq i32 %t1686, 4
  %t1693 = select i1 %t1692, %FunctionSignature %t1691, %FunctionSignature zeroinitializer
  %t1694 = getelementptr inbounds %Statement, %Statement* %t1687, i32 0, i32 1
  %t1695 = bitcast [88 x i8]* %t1694 to i8*
  %t1696 = bitcast i8* %t1695 to %FunctionSignature*
  %t1697 = load %FunctionSignature, %FunctionSignature* %t1696
  %t1698 = icmp eq i32 %t1686, 5
  %t1699 = select i1 %t1698, %FunctionSignature %t1697, %FunctionSignature %t1693
  %t1700 = getelementptr inbounds %Statement, %Statement* %t1687, i32 0, i32 1
  %t1701 = bitcast [88 x i8]* %t1700 to i8*
  %t1702 = bitcast i8* %t1701 to %FunctionSignature*
  %t1703 = load %FunctionSignature, %FunctionSignature* %t1702
  %t1704 = icmp eq i32 %t1686, 7
  %t1705 = select i1 %t1704, %FunctionSignature %t1703, %FunctionSignature %t1699
  %t1706 = extractvalue %FunctionSignature %t1705, 6
  %t1707 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1683, i8* %t1684, %SourceSpan* %t1706)
  store %ScopeResult %t1707, %ScopeResult* %l13
  %t1708 = load %ScopeResult, %ScopeResult* %l13
  %t1709 = extractvalue %ScopeResult %t1708, 1
  store { %Diagnostic*, i64 }* %t1709, { %Diagnostic*, i64 }** %l14
  %t1710 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l14
  %t1711 = extractvalue %Statement %statement, 0
  %t1712 = alloca %Statement
  store %Statement %statement, %Statement* %t1712
  %t1713 = getelementptr inbounds %Statement, %Statement* %t1712, i32 0, i32 1
  %t1714 = bitcast [88 x i8]* %t1713 to i8*
  %t1715 = bitcast i8* %t1714 to %FunctionSignature*
  %t1716 = load %FunctionSignature, %FunctionSignature* %t1715
  %t1717 = icmp eq i32 %t1711, 4
  %t1718 = select i1 %t1717, %FunctionSignature %t1716, %FunctionSignature zeroinitializer
  %t1719 = getelementptr inbounds %Statement, %Statement* %t1712, i32 0, i32 1
  %t1720 = bitcast [88 x i8]* %t1719 to i8*
  %t1721 = bitcast i8* %t1720 to %FunctionSignature*
  %t1722 = load %FunctionSignature, %FunctionSignature* %t1721
  %t1723 = icmp eq i32 %t1711, 5
  %t1724 = select i1 %t1723, %FunctionSignature %t1722, %FunctionSignature %t1718
  %t1725 = getelementptr inbounds %Statement, %Statement* %t1712, i32 0, i32 1
  %t1726 = bitcast [88 x i8]* %t1725 to i8*
  %t1727 = bitcast i8* %t1726 to %FunctionSignature*
  %t1728 = load %FunctionSignature, %FunctionSignature* %t1727
  %t1729 = icmp eq i32 %t1711, 7
  %t1730 = select i1 %t1729, %FunctionSignature %t1728, %FunctionSignature %t1724
  %t1731 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t1730)
  %t1732 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1710, i32 0, i32 0
  %t1733 = load %Diagnostic*, %Diagnostic** %t1732
  %t1734 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1710, i32 0, i32 1
  %t1735 = load i64, i64* %t1734
  %t1736 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1731, i32 0, i32 0
  %t1737 = load %Diagnostic*, %Diagnostic** %t1736
  %t1738 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1731, i32 0, i32 1
  %t1739 = load i64, i64* %t1738
  %t1740 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t1741 = ptrtoint %Diagnostic* %t1740 to i64
  %t1742 = add i64 %t1735, %t1739
  %t1743 = mul i64 %t1741, %t1742
  %t1744 = call noalias i8* @malloc(i64 %t1743)
  %t1745 = bitcast i8* %t1744 to %Diagnostic*
  %t1746 = bitcast %Diagnostic* %t1745 to i8*
  %t1747 = mul i64 %t1741, %t1735
  %t1748 = bitcast %Diagnostic* %t1733 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1746, i8* %t1748, i64 %t1747)
  %t1749 = mul i64 %t1741, %t1739
  %t1750 = bitcast %Diagnostic* %t1737 to i8*
  %t1751 = getelementptr %Diagnostic, %Diagnostic* %t1745, i64 %t1735
  %t1752 = bitcast %Diagnostic* %t1751 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1752, i8* %t1750, i64 %t1749)
  %t1753 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1754 = ptrtoint { %Diagnostic*, i64 }* %t1753 to i64
  %t1755 = call i8* @malloc(i64 %t1754)
  %t1756 = bitcast i8* %t1755 to { %Diagnostic*, i64 }*
  %t1757 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1756, i32 0, i32 0
  store %Diagnostic* %t1745, %Diagnostic** %t1757
  %t1758 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1756, i32 0, i32 1
  store i64 %t1742, i64* %t1758
  store { %Diagnostic*, i64 }* %t1756, { %Diagnostic*, i64 }** %l14
  %t1759 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l14
  %t1760 = extractvalue %Statement %statement, 0
  %t1761 = alloca %Statement
  store %Statement %statement, %Statement* %t1761
  %t1762 = getelementptr inbounds %Statement, %Statement* %t1761, i32 0, i32 1
  %t1763 = bitcast [88 x i8]* %t1762 to i8*
  %t1764 = bitcast i8* %t1763 to %FunctionSignature*
  %t1765 = load %FunctionSignature, %FunctionSignature* %t1764
  %t1766 = icmp eq i32 %t1760, 4
  %t1767 = select i1 %t1766, %FunctionSignature %t1765, %FunctionSignature zeroinitializer
  %t1768 = getelementptr inbounds %Statement, %Statement* %t1761, i32 0, i32 1
  %t1769 = bitcast [88 x i8]* %t1768 to i8*
  %t1770 = bitcast i8* %t1769 to %FunctionSignature*
  %t1771 = load %FunctionSignature, %FunctionSignature* %t1770
  %t1772 = icmp eq i32 %t1760, 5
  %t1773 = select i1 %t1772, %FunctionSignature %t1771, %FunctionSignature %t1767
  %t1774 = getelementptr inbounds %Statement, %Statement* %t1761, i32 0, i32 1
  %t1775 = bitcast [88 x i8]* %t1774 to i8*
  %t1776 = bitcast i8* %t1775 to %FunctionSignature*
  %t1777 = load %FunctionSignature, %FunctionSignature* %t1776
  %t1778 = icmp eq i32 %t1760, 7
  %t1779 = select i1 %t1778, %FunctionSignature %t1777, %FunctionSignature %t1773
  %t1780 = extractvalue %Statement %statement, 0
  %t1781 = alloca %Statement
  store %Statement %statement, %Statement* %t1781
  %t1782 = getelementptr inbounds %Statement, %Statement* %t1781, i32 0, i32 1
  %t1783 = bitcast [88 x i8]* %t1782 to i8*
  %t1784 = getelementptr inbounds i8, i8* %t1783, i64 56
  %t1785 = bitcast i8* %t1784 to %Block*
  %t1786 = load %Block, %Block* %t1785
  %t1787 = icmp eq i32 %t1780, 4
  %t1788 = select i1 %t1787, %Block %t1786, %Block zeroinitializer
  %t1789 = getelementptr inbounds %Statement, %Statement* %t1781, i32 0, i32 1
  %t1790 = bitcast [88 x i8]* %t1789 to i8*
  %t1791 = getelementptr inbounds i8, i8* %t1790, i64 56
  %t1792 = bitcast i8* %t1791 to %Block*
  %t1793 = load %Block, %Block* %t1792
  %t1794 = icmp eq i32 %t1780, 5
  %t1795 = select i1 %t1794, %Block %t1793, %Block %t1788
  %t1796 = getelementptr inbounds %Statement, %Statement* %t1781, i32 0, i32 1
  %t1797 = bitcast [56 x i8]* %t1796 to i8*
  %t1798 = getelementptr inbounds i8, i8* %t1797, i64 16
  %t1799 = bitcast i8* %t1798 to %Block*
  %t1800 = load %Block, %Block* %t1799
  %t1801 = icmp eq i32 %t1780, 6
  %t1802 = select i1 %t1801, %Block %t1800, %Block %t1795
  %t1803 = getelementptr inbounds %Statement, %Statement* %t1781, i32 0, i32 1
  %t1804 = bitcast [88 x i8]* %t1803 to i8*
  %t1805 = getelementptr inbounds i8, i8* %t1804, i64 56
  %t1806 = bitcast i8* %t1805 to %Block*
  %t1807 = load %Block, %Block* %t1806
  %t1808 = icmp eq i32 %t1780, 7
  %t1809 = select i1 %t1808, %Block %t1807, %Block %t1802
  %t1810 = getelementptr inbounds %Statement, %Statement* %t1781, i32 0, i32 1
  %t1811 = bitcast [120 x i8]* %t1810 to i8*
  %t1812 = getelementptr inbounds i8, i8* %t1811, i64 88
  %t1813 = bitcast i8* %t1812 to %Block*
  %t1814 = load %Block, %Block* %t1813
  %t1815 = icmp eq i32 %t1780, 12
  %t1816 = select i1 %t1815, %Block %t1814, %Block %t1809
  %t1817 = getelementptr inbounds %Statement, %Statement* %t1781, i32 0, i32 1
  %t1818 = bitcast [40 x i8]* %t1817 to i8*
  %t1819 = getelementptr inbounds i8, i8* %t1818, i64 8
  %t1820 = bitcast i8* %t1819 to %Block*
  %t1821 = load %Block, %Block* %t1820
  %t1822 = icmp eq i32 %t1780, 13
  %t1823 = select i1 %t1822, %Block %t1821, %Block %t1816
  %t1824 = getelementptr inbounds %Statement, %Statement* %t1781, i32 0, i32 1
  %t1825 = bitcast [136 x i8]* %t1824 to i8*
  %t1826 = getelementptr inbounds i8, i8* %t1825, i64 104
  %t1827 = bitcast i8* %t1826 to %Block*
  %t1828 = load %Block, %Block* %t1827
  %t1829 = icmp eq i32 %t1780, 14
  %t1830 = select i1 %t1829, %Block %t1828, %Block %t1823
  %t1831 = getelementptr inbounds %Statement, %Statement* %t1781, i32 0, i32 1
  %t1832 = bitcast [32 x i8]* %t1831 to i8*
  %t1833 = bitcast i8* %t1832 to %Block*
  %t1834 = load %Block, %Block* %t1833
  %t1835 = icmp eq i32 %t1780, 15
  %t1836 = select i1 %t1835, %Block %t1834, %Block %t1830
  %t1837 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t1779, %Block %t1836, { %Statement*, i64 }* %interfaces)
  %t1838 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1759, i32 0, i32 0
  %t1839 = load %Diagnostic*, %Diagnostic** %t1838
  %t1840 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1759, i32 0, i32 1
  %t1841 = load i64, i64* %t1840
  %t1842 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1837, i32 0, i32 0
  %t1843 = load %Diagnostic*, %Diagnostic** %t1842
  %t1844 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1837, i32 0, i32 1
  %t1845 = load i64, i64* %t1844
  %t1846 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t1847 = ptrtoint %Diagnostic* %t1846 to i64
  %t1848 = add i64 %t1841, %t1845
  %t1849 = mul i64 %t1847, %t1848
  %t1850 = call noalias i8* @malloc(i64 %t1849)
  %t1851 = bitcast i8* %t1850 to %Diagnostic*
  %t1852 = bitcast %Diagnostic* %t1851 to i8*
  %t1853 = mul i64 %t1847, %t1841
  %t1854 = bitcast %Diagnostic* %t1839 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1852, i8* %t1854, i64 %t1853)
  %t1855 = mul i64 %t1847, %t1845
  %t1856 = bitcast %Diagnostic* %t1843 to i8*
  %t1857 = getelementptr %Diagnostic, %Diagnostic* %t1851, i64 %t1841
  %t1858 = bitcast %Diagnostic* %t1857 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1858, i8* %t1856, i64 %t1855)
  %t1859 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1860 = ptrtoint { %Diagnostic*, i64 }* %t1859 to i64
  %t1861 = call i8* @malloc(i64 %t1860)
  %t1862 = bitcast i8* %t1861 to { %Diagnostic*, i64 }*
  %t1863 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1862, i32 0, i32 0
  store %Diagnostic* %t1851, %Diagnostic** %t1863
  %t1864 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1862, i32 0, i32 1
  store i64 %t1848, i64* %t1864
  store { %Diagnostic*, i64 }* %t1862, { %Diagnostic*, i64 }** %l14
  %t1865 = load %ScopeResult, %ScopeResult* %l13
  %t1866 = extractvalue %ScopeResult %t1865, 0
  %t1867 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t1866, 0
  %t1868 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l14
  %t1869 = insertvalue %ScopeResult %t1867, { %Diagnostic*, i64 }* %t1868, 1
  ret %ScopeResult %t1869
merge19:
  %t1870 = extractvalue %Statement %statement, 0
  %t1871 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1872 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1873 = icmp eq i32 %t1870, 0
  %t1874 = select i1 %t1873, i8* %t1872, i8* %t1871
  %t1875 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1876 = icmp eq i32 %t1870, 1
  %t1877 = select i1 %t1876, i8* %t1875, i8* %t1874
  %t1878 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1879 = icmp eq i32 %t1870, 2
  %t1880 = select i1 %t1879, i8* %t1878, i8* %t1877
  %t1881 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1882 = icmp eq i32 %t1870, 3
  %t1883 = select i1 %t1882, i8* %t1881, i8* %t1880
  %t1884 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1885 = icmp eq i32 %t1870, 4
  %t1886 = select i1 %t1885, i8* %t1884, i8* %t1883
  %t1887 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1888 = icmp eq i32 %t1870, 5
  %t1889 = select i1 %t1888, i8* %t1887, i8* %t1886
  %t1890 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1891 = icmp eq i32 %t1870, 6
  %t1892 = select i1 %t1891, i8* %t1890, i8* %t1889
  %t1893 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1894 = icmp eq i32 %t1870, 7
  %t1895 = select i1 %t1894, i8* %t1893, i8* %t1892
  %t1896 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1897 = icmp eq i32 %t1870, 8
  %t1898 = select i1 %t1897, i8* %t1896, i8* %t1895
  %t1899 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1900 = icmp eq i32 %t1870, 9
  %t1901 = select i1 %t1900, i8* %t1899, i8* %t1898
  %t1902 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1903 = icmp eq i32 %t1870, 10
  %t1904 = select i1 %t1903, i8* %t1902, i8* %t1901
  %t1905 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1906 = icmp eq i32 %t1870, 11
  %t1907 = select i1 %t1906, i8* %t1905, i8* %t1904
  %t1908 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1909 = icmp eq i32 %t1870, 12
  %t1910 = select i1 %t1909, i8* %t1908, i8* %t1907
  %t1911 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1912 = icmp eq i32 %t1870, 13
  %t1913 = select i1 %t1912, i8* %t1911, i8* %t1910
  %t1914 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1915 = icmp eq i32 %t1870, 14
  %t1916 = select i1 %t1915, i8* %t1914, i8* %t1913
  %t1917 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1918 = icmp eq i32 %t1870, 15
  %t1919 = select i1 %t1918, i8* %t1917, i8* %t1916
  %t1920 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1921 = icmp eq i32 %t1870, 16
  %t1922 = select i1 %t1921, i8* %t1920, i8* %t1919
  %t1923 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1924 = icmp eq i32 %t1870, 17
  %t1925 = select i1 %t1924, i8* %t1923, i8* %t1922
  %t1926 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1927 = icmp eq i32 %t1870, 18
  %t1928 = select i1 %t1927, i8* %t1926, i8* %t1925
  %t1929 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1930 = icmp eq i32 %t1870, 19
  %t1931 = select i1 %t1930, i8* %t1929, i8* %t1928
  %t1932 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1933 = icmp eq i32 %t1870, 20
  %t1934 = select i1 %t1933, i8* %t1932, i8* %t1931
  %t1935 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1936 = icmp eq i32 %t1870, 21
  %t1937 = select i1 %t1936, i8* %t1935, i8* %t1934
  %t1938 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1939 = icmp eq i32 %t1870, 22
  %t1940 = select i1 %t1939, i8* %t1938, i8* %t1937
  %t1941 = call i8* @malloc(i64 16)
  %t1942 = bitcast i8* %t1941 to [16 x i8]*
  store [16 x i8] c"ToolDeclaration\00", [16 x i8]* %t1942
  %t1943 = call i1 @strings_equal(i8* %t1940, i8* %t1941)
  br i1 %t1943, label %then20, label %merge21
then20:
  %t1944 = extractvalue %Statement %statement, 0
  %t1945 = alloca %Statement
  store %Statement %statement, %Statement* %t1945
  %t1946 = getelementptr inbounds %Statement, %Statement* %t1945, i32 0, i32 1
  %t1947 = bitcast [88 x i8]* %t1946 to i8*
  %t1948 = bitcast i8* %t1947 to %FunctionSignature*
  %t1949 = load %FunctionSignature, %FunctionSignature* %t1948
  %t1950 = icmp eq i32 %t1944, 4
  %t1951 = select i1 %t1950, %FunctionSignature %t1949, %FunctionSignature zeroinitializer
  %t1952 = getelementptr inbounds %Statement, %Statement* %t1945, i32 0, i32 1
  %t1953 = bitcast [88 x i8]* %t1952 to i8*
  %t1954 = bitcast i8* %t1953 to %FunctionSignature*
  %t1955 = load %FunctionSignature, %FunctionSignature* %t1954
  %t1956 = icmp eq i32 %t1944, 5
  %t1957 = select i1 %t1956, %FunctionSignature %t1955, %FunctionSignature %t1951
  %t1958 = getelementptr inbounds %Statement, %Statement* %t1945, i32 0, i32 1
  %t1959 = bitcast [88 x i8]* %t1958 to i8*
  %t1960 = bitcast i8* %t1959 to %FunctionSignature*
  %t1961 = load %FunctionSignature, %FunctionSignature* %t1960
  %t1962 = icmp eq i32 %t1944, 7
  %t1963 = select i1 %t1962, %FunctionSignature %t1961, %FunctionSignature %t1957
  %t1964 = extractvalue %FunctionSignature %t1963, 0
  %t1965 = call i8* @malloc(i64 5)
  %t1966 = bitcast i8* %t1965 to [5 x i8]*
  store [5 x i8] c"tool\00", [5 x i8]* %t1966
  %t1967 = extractvalue %Statement %statement, 0
  %t1968 = alloca %Statement
  store %Statement %statement, %Statement* %t1968
  %t1969 = getelementptr inbounds %Statement, %Statement* %t1968, i32 0, i32 1
  %t1970 = bitcast [88 x i8]* %t1969 to i8*
  %t1971 = bitcast i8* %t1970 to %FunctionSignature*
  %t1972 = load %FunctionSignature, %FunctionSignature* %t1971
  %t1973 = icmp eq i32 %t1967, 4
  %t1974 = select i1 %t1973, %FunctionSignature %t1972, %FunctionSignature zeroinitializer
  %t1975 = getelementptr inbounds %Statement, %Statement* %t1968, i32 0, i32 1
  %t1976 = bitcast [88 x i8]* %t1975 to i8*
  %t1977 = bitcast i8* %t1976 to %FunctionSignature*
  %t1978 = load %FunctionSignature, %FunctionSignature* %t1977
  %t1979 = icmp eq i32 %t1967, 5
  %t1980 = select i1 %t1979, %FunctionSignature %t1978, %FunctionSignature %t1974
  %t1981 = getelementptr inbounds %Statement, %Statement* %t1968, i32 0, i32 1
  %t1982 = bitcast [88 x i8]* %t1981 to i8*
  %t1983 = bitcast i8* %t1982 to %FunctionSignature*
  %t1984 = load %FunctionSignature, %FunctionSignature* %t1983
  %t1985 = icmp eq i32 %t1967, 7
  %t1986 = select i1 %t1985, %FunctionSignature %t1984, %FunctionSignature %t1980
  %t1987 = extractvalue %FunctionSignature %t1986, 6
  %t1988 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1964, i8* %t1965, %SourceSpan* %t1987)
  store %ScopeResult %t1988, %ScopeResult* %l15
  %t1989 = load %ScopeResult, %ScopeResult* %l15
  %t1990 = extractvalue %ScopeResult %t1989, 1
  store { %Diagnostic*, i64 }* %t1990, { %Diagnostic*, i64 }** %l16
  %t1991 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l16
  %t1992 = extractvalue %Statement %statement, 0
  %t1993 = alloca %Statement
  store %Statement %statement, %Statement* %t1993
  %t1994 = getelementptr inbounds %Statement, %Statement* %t1993, i32 0, i32 1
  %t1995 = bitcast [88 x i8]* %t1994 to i8*
  %t1996 = bitcast i8* %t1995 to %FunctionSignature*
  %t1997 = load %FunctionSignature, %FunctionSignature* %t1996
  %t1998 = icmp eq i32 %t1992, 4
  %t1999 = select i1 %t1998, %FunctionSignature %t1997, %FunctionSignature zeroinitializer
  %t2000 = getelementptr inbounds %Statement, %Statement* %t1993, i32 0, i32 1
  %t2001 = bitcast [88 x i8]* %t2000 to i8*
  %t2002 = bitcast i8* %t2001 to %FunctionSignature*
  %t2003 = load %FunctionSignature, %FunctionSignature* %t2002
  %t2004 = icmp eq i32 %t1992, 5
  %t2005 = select i1 %t2004, %FunctionSignature %t2003, %FunctionSignature %t1999
  %t2006 = getelementptr inbounds %Statement, %Statement* %t1993, i32 0, i32 1
  %t2007 = bitcast [88 x i8]* %t2006 to i8*
  %t2008 = bitcast i8* %t2007 to %FunctionSignature*
  %t2009 = load %FunctionSignature, %FunctionSignature* %t2008
  %t2010 = icmp eq i32 %t1992, 7
  %t2011 = select i1 %t2010, %FunctionSignature %t2009, %FunctionSignature %t2005
  %t2012 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t2011)
  %t2013 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1991, i32 0, i32 0
  %t2014 = load %Diagnostic*, %Diagnostic** %t2013
  %t2015 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1991, i32 0, i32 1
  %t2016 = load i64, i64* %t2015
  %t2017 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2012, i32 0, i32 0
  %t2018 = load %Diagnostic*, %Diagnostic** %t2017
  %t2019 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2012, i32 0, i32 1
  %t2020 = load i64, i64* %t2019
  %t2021 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t2022 = ptrtoint %Diagnostic* %t2021 to i64
  %t2023 = add i64 %t2016, %t2020
  %t2024 = mul i64 %t2022, %t2023
  %t2025 = call noalias i8* @malloc(i64 %t2024)
  %t2026 = bitcast i8* %t2025 to %Diagnostic*
  %t2027 = bitcast %Diagnostic* %t2026 to i8*
  %t2028 = mul i64 %t2022, %t2016
  %t2029 = bitcast %Diagnostic* %t2014 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2027, i8* %t2029, i64 %t2028)
  %t2030 = mul i64 %t2022, %t2020
  %t2031 = bitcast %Diagnostic* %t2018 to i8*
  %t2032 = getelementptr %Diagnostic, %Diagnostic* %t2026, i64 %t2016
  %t2033 = bitcast %Diagnostic* %t2032 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2033, i8* %t2031, i64 %t2030)
  %t2034 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t2035 = ptrtoint { %Diagnostic*, i64 }* %t2034 to i64
  %t2036 = call i8* @malloc(i64 %t2035)
  %t2037 = bitcast i8* %t2036 to { %Diagnostic*, i64 }*
  %t2038 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2037, i32 0, i32 0
  store %Diagnostic* %t2026, %Diagnostic** %t2038
  %t2039 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2037, i32 0, i32 1
  store i64 %t2023, i64* %t2039
  store { %Diagnostic*, i64 }* %t2037, { %Diagnostic*, i64 }** %l16
  %t2040 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l16
  %t2041 = extractvalue %Statement %statement, 0
  %t2042 = alloca %Statement
  store %Statement %statement, %Statement* %t2042
  %t2043 = getelementptr inbounds %Statement, %Statement* %t2042, i32 0, i32 1
  %t2044 = bitcast [88 x i8]* %t2043 to i8*
  %t2045 = bitcast i8* %t2044 to %FunctionSignature*
  %t2046 = load %FunctionSignature, %FunctionSignature* %t2045
  %t2047 = icmp eq i32 %t2041, 4
  %t2048 = select i1 %t2047, %FunctionSignature %t2046, %FunctionSignature zeroinitializer
  %t2049 = getelementptr inbounds %Statement, %Statement* %t2042, i32 0, i32 1
  %t2050 = bitcast [88 x i8]* %t2049 to i8*
  %t2051 = bitcast i8* %t2050 to %FunctionSignature*
  %t2052 = load %FunctionSignature, %FunctionSignature* %t2051
  %t2053 = icmp eq i32 %t2041, 5
  %t2054 = select i1 %t2053, %FunctionSignature %t2052, %FunctionSignature %t2048
  %t2055 = getelementptr inbounds %Statement, %Statement* %t2042, i32 0, i32 1
  %t2056 = bitcast [88 x i8]* %t2055 to i8*
  %t2057 = bitcast i8* %t2056 to %FunctionSignature*
  %t2058 = load %FunctionSignature, %FunctionSignature* %t2057
  %t2059 = icmp eq i32 %t2041, 7
  %t2060 = select i1 %t2059, %FunctionSignature %t2058, %FunctionSignature %t2054
  %t2061 = extractvalue %Statement %statement, 0
  %t2062 = alloca %Statement
  store %Statement %statement, %Statement* %t2062
  %t2063 = getelementptr inbounds %Statement, %Statement* %t2062, i32 0, i32 1
  %t2064 = bitcast [88 x i8]* %t2063 to i8*
  %t2065 = getelementptr inbounds i8, i8* %t2064, i64 56
  %t2066 = bitcast i8* %t2065 to %Block*
  %t2067 = load %Block, %Block* %t2066
  %t2068 = icmp eq i32 %t2061, 4
  %t2069 = select i1 %t2068, %Block %t2067, %Block zeroinitializer
  %t2070 = getelementptr inbounds %Statement, %Statement* %t2062, i32 0, i32 1
  %t2071 = bitcast [88 x i8]* %t2070 to i8*
  %t2072 = getelementptr inbounds i8, i8* %t2071, i64 56
  %t2073 = bitcast i8* %t2072 to %Block*
  %t2074 = load %Block, %Block* %t2073
  %t2075 = icmp eq i32 %t2061, 5
  %t2076 = select i1 %t2075, %Block %t2074, %Block %t2069
  %t2077 = getelementptr inbounds %Statement, %Statement* %t2062, i32 0, i32 1
  %t2078 = bitcast [56 x i8]* %t2077 to i8*
  %t2079 = getelementptr inbounds i8, i8* %t2078, i64 16
  %t2080 = bitcast i8* %t2079 to %Block*
  %t2081 = load %Block, %Block* %t2080
  %t2082 = icmp eq i32 %t2061, 6
  %t2083 = select i1 %t2082, %Block %t2081, %Block %t2076
  %t2084 = getelementptr inbounds %Statement, %Statement* %t2062, i32 0, i32 1
  %t2085 = bitcast [88 x i8]* %t2084 to i8*
  %t2086 = getelementptr inbounds i8, i8* %t2085, i64 56
  %t2087 = bitcast i8* %t2086 to %Block*
  %t2088 = load %Block, %Block* %t2087
  %t2089 = icmp eq i32 %t2061, 7
  %t2090 = select i1 %t2089, %Block %t2088, %Block %t2083
  %t2091 = getelementptr inbounds %Statement, %Statement* %t2062, i32 0, i32 1
  %t2092 = bitcast [120 x i8]* %t2091 to i8*
  %t2093 = getelementptr inbounds i8, i8* %t2092, i64 88
  %t2094 = bitcast i8* %t2093 to %Block*
  %t2095 = load %Block, %Block* %t2094
  %t2096 = icmp eq i32 %t2061, 12
  %t2097 = select i1 %t2096, %Block %t2095, %Block %t2090
  %t2098 = getelementptr inbounds %Statement, %Statement* %t2062, i32 0, i32 1
  %t2099 = bitcast [40 x i8]* %t2098 to i8*
  %t2100 = getelementptr inbounds i8, i8* %t2099, i64 8
  %t2101 = bitcast i8* %t2100 to %Block*
  %t2102 = load %Block, %Block* %t2101
  %t2103 = icmp eq i32 %t2061, 13
  %t2104 = select i1 %t2103, %Block %t2102, %Block %t2097
  %t2105 = getelementptr inbounds %Statement, %Statement* %t2062, i32 0, i32 1
  %t2106 = bitcast [136 x i8]* %t2105 to i8*
  %t2107 = getelementptr inbounds i8, i8* %t2106, i64 104
  %t2108 = bitcast i8* %t2107 to %Block*
  %t2109 = load %Block, %Block* %t2108
  %t2110 = icmp eq i32 %t2061, 14
  %t2111 = select i1 %t2110, %Block %t2109, %Block %t2104
  %t2112 = getelementptr inbounds %Statement, %Statement* %t2062, i32 0, i32 1
  %t2113 = bitcast [32 x i8]* %t2112 to i8*
  %t2114 = bitcast i8* %t2113 to %Block*
  %t2115 = load %Block, %Block* %t2114
  %t2116 = icmp eq i32 %t2061, 15
  %t2117 = select i1 %t2116, %Block %t2115, %Block %t2111
  %t2118 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t2060, %Block %t2117, { %Statement*, i64 }* %interfaces)
  %t2119 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2040, i32 0, i32 0
  %t2120 = load %Diagnostic*, %Diagnostic** %t2119
  %t2121 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2040, i32 0, i32 1
  %t2122 = load i64, i64* %t2121
  %t2123 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2118, i32 0, i32 0
  %t2124 = load %Diagnostic*, %Diagnostic** %t2123
  %t2125 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2118, i32 0, i32 1
  %t2126 = load i64, i64* %t2125
  %t2127 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t2128 = ptrtoint %Diagnostic* %t2127 to i64
  %t2129 = add i64 %t2122, %t2126
  %t2130 = mul i64 %t2128, %t2129
  %t2131 = call noalias i8* @malloc(i64 %t2130)
  %t2132 = bitcast i8* %t2131 to %Diagnostic*
  %t2133 = bitcast %Diagnostic* %t2132 to i8*
  %t2134 = mul i64 %t2128, %t2122
  %t2135 = bitcast %Diagnostic* %t2120 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2133, i8* %t2135, i64 %t2134)
  %t2136 = mul i64 %t2128, %t2126
  %t2137 = bitcast %Diagnostic* %t2124 to i8*
  %t2138 = getelementptr %Diagnostic, %Diagnostic* %t2132, i64 %t2122
  %t2139 = bitcast %Diagnostic* %t2138 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2139, i8* %t2137, i64 %t2136)
  %t2140 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t2141 = ptrtoint { %Diagnostic*, i64 }* %t2140 to i64
  %t2142 = call i8* @malloc(i64 %t2141)
  %t2143 = bitcast i8* %t2142 to { %Diagnostic*, i64 }*
  %t2144 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2143, i32 0, i32 0
  store %Diagnostic* %t2132, %Diagnostic** %t2144
  %t2145 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2143, i32 0, i32 1
  store i64 %t2129, i64* %t2145
  store { %Diagnostic*, i64 }* %t2143, { %Diagnostic*, i64 }** %l16
  %t2146 = load %ScopeResult, %ScopeResult* %l15
  %t2147 = extractvalue %ScopeResult %t2146, 0
  %t2148 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t2147, 0
  %t2149 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l16
  %t2150 = insertvalue %ScopeResult %t2148, { %Diagnostic*, i64 }* %t2149, 1
  ret %ScopeResult %t2150
merge21:
  %t2151 = extractvalue %Statement %statement, 0
  %t2152 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2153 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2154 = icmp eq i32 %t2151, 0
  %t2155 = select i1 %t2154, i8* %t2153, i8* %t2152
  %t2156 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2157 = icmp eq i32 %t2151, 1
  %t2158 = select i1 %t2157, i8* %t2156, i8* %t2155
  %t2159 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2160 = icmp eq i32 %t2151, 2
  %t2161 = select i1 %t2160, i8* %t2159, i8* %t2158
  %t2162 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2163 = icmp eq i32 %t2151, 3
  %t2164 = select i1 %t2163, i8* %t2162, i8* %t2161
  %t2165 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2166 = icmp eq i32 %t2151, 4
  %t2167 = select i1 %t2166, i8* %t2165, i8* %t2164
  %t2168 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2169 = icmp eq i32 %t2151, 5
  %t2170 = select i1 %t2169, i8* %t2168, i8* %t2167
  %t2171 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2172 = icmp eq i32 %t2151, 6
  %t2173 = select i1 %t2172, i8* %t2171, i8* %t2170
  %t2174 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2175 = icmp eq i32 %t2151, 7
  %t2176 = select i1 %t2175, i8* %t2174, i8* %t2173
  %t2177 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2178 = icmp eq i32 %t2151, 8
  %t2179 = select i1 %t2178, i8* %t2177, i8* %t2176
  %t2180 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2181 = icmp eq i32 %t2151, 9
  %t2182 = select i1 %t2181, i8* %t2180, i8* %t2179
  %t2183 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2184 = icmp eq i32 %t2151, 10
  %t2185 = select i1 %t2184, i8* %t2183, i8* %t2182
  %t2186 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2187 = icmp eq i32 %t2151, 11
  %t2188 = select i1 %t2187, i8* %t2186, i8* %t2185
  %t2189 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2190 = icmp eq i32 %t2151, 12
  %t2191 = select i1 %t2190, i8* %t2189, i8* %t2188
  %t2192 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2193 = icmp eq i32 %t2151, 13
  %t2194 = select i1 %t2193, i8* %t2192, i8* %t2191
  %t2195 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2196 = icmp eq i32 %t2151, 14
  %t2197 = select i1 %t2196, i8* %t2195, i8* %t2194
  %t2198 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2199 = icmp eq i32 %t2151, 15
  %t2200 = select i1 %t2199, i8* %t2198, i8* %t2197
  %t2201 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2202 = icmp eq i32 %t2151, 16
  %t2203 = select i1 %t2202, i8* %t2201, i8* %t2200
  %t2204 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2205 = icmp eq i32 %t2151, 17
  %t2206 = select i1 %t2205, i8* %t2204, i8* %t2203
  %t2207 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2208 = icmp eq i32 %t2151, 18
  %t2209 = select i1 %t2208, i8* %t2207, i8* %t2206
  %t2210 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2211 = icmp eq i32 %t2151, 19
  %t2212 = select i1 %t2211, i8* %t2210, i8* %t2209
  %t2213 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2214 = icmp eq i32 %t2151, 20
  %t2215 = select i1 %t2214, i8* %t2213, i8* %t2212
  %t2216 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2217 = icmp eq i32 %t2151, 21
  %t2218 = select i1 %t2217, i8* %t2216, i8* %t2215
  %t2219 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2220 = icmp eq i32 %t2151, 22
  %t2221 = select i1 %t2220, i8* %t2219, i8* %t2218
  %t2222 = call i8* @malloc(i64 16)
  %t2223 = bitcast i8* %t2222 to [16 x i8]*
  store [16 x i8] c"TestDeclaration\00", [16 x i8]* %t2223
  %t2224 = call i1 @strings_equal(i8* %t2221, i8* %t2222)
  br i1 %t2224, label %then22, label %merge23
then22:
  %t2225 = extractvalue %Statement %statement, 0
  %t2226 = alloca %Statement
  store %Statement %statement, %Statement* %t2226
  %t2227 = getelementptr inbounds %Statement, %Statement* %t2226, i32 0, i32 1
  %t2228 = bitcast [48 x i8]* %t2227 to i8*
  %t2229 = bitcast i8* %t2228 to i8**
  %t2230 = load i8*, i8** %t2229
  %t2231 = icmp eq i32 %t2225, 2
  %t2232 = select i1 %t2231, i8* %t2230, i8* null
  %t2233 = getelementptr inbounds %Statement, %Statement* %t2226, i32 0, i32 1
  %t2234 = bitcast [48 x i8]* %t2233 to i8*
  %t2235 = bitcast i8* %t2234 to i8**
  %t2236 = load i8*, i8** %t2235
  %t2237 = icmp eq i32 %t2225, 3
  %t2238 = select i1 %t2237, i8* %t2236, i8* %t2232
  %t2239 = getelementptr inbounds %Statement, %Statement* %t2226, i32 0, i32 1
  %t2240 = bitcast [56 x i8]* %t2239 to i8*
  %t2241 = bitcast i8* %t2240 to i8**
  %t2242 = load i8*, i8** %t2241
  %t2243 = icmp eq i32 %t2225, 6
  %t2244 = select i1 %t2243, i8* %t2242, i8* %t2238
  %t2245 = getelementptr inbounds %Statement, %Statement* %t2226, i32 0, i32 1
  %t2246 = bitcast [56 x i8]* %t2245 to i8*
  %t2247 = bitcast i8* %t2246 to i8**
  %t2248 = load i8*, i8** %t2247
  %t2249 = icmp eq i32 %t2225, 8
  %t2250 = select i1 %t2249, i8* %t2248, i8* %t2244
  %t2251 = getelementptr inbounds %Statement, %Statement* %t2226, i32 0, i32 1
  %t2252 = bitcast [40 x i8]* %t2251 to i8*
  %t2253 = bitcast i8* %t2252 to i8**
  %t2254 = load i8*, i8** %t2253
  %t2255 = icmp eq i32 %t2225, 9
  %t2256 = select i1 %t2255, i8* %t2254, i8* %t2250
  %t2257 = getelementptr inbounds %Statement, %Statement* %t2226, i32 0, i32 1
  %t2258 = bitcast [40 x i8]* %t2257 to i8*
  %t2259 = bitcast i8* %t2258 to i8**
  %t2260 = load i8*, i8** %t2259
  %t2261 = icmp eq i32 %t2225, 10
  %t2262 = select i1 %t2261, i8* %t2260, i8* %t2256
  %t2263 = getelementptr inbounds %Statement, %Statement* %t2226, i32 0, i32 1
  %t2264 = bitcast [40 x i8]* %t2263 to i8*
  %t2265 = bitcast i8* %t2264 to i8**
  %t2266 = load i8*, i8** %t2265
  %t2267 = icmp eq i32 %t2225, 11
  %t2268 = select i1 %t2267, i8* %t2266, i8* %t2262
  %t2269 = call i8* @malloc(i64 5)
  %t2270 = bitcast i8* %t2269 to [5 x i8]*
  store [5 x i8] c"test\00", [5 x i8]* %t2270
  %t2271 = extractvalue %Statement %statement, 0
  %t2272 = alloca %Statement
  store %Statement %statement, %Statement* %t2272
  %t2273 = getelementptr inbounds %Statement, %Statement* %t2272, i32 0, i32 1
  %t2274 = bitcast [48 x i8]* %t2273 to i8*
  %t2275 = getelementptr inbounds i8, i8* %t2274, i64 8
  %t2276 = bitcast i8* %t2275 to %SourceSpan**
  %t2277 = load %SourceSpan*, %SourceSpan** %t2276
  %t2278 = icmp eq i32 %t2271, 3
  %t2279 = select i1 %t2278, %SourceSpan* %t2277, %SourceSpan* null
  %t2280 = getelementptr inbounds %Statement, %Statement* %t2272, i32 0, i32 1
  %t2281 = bitcast [56 x i8]* %t2280 to i8*
  %t2282 = getelementptr inbounds i8, i8* %t2281, i64 8
  %t2283 = bitcast i8* %t2282 to %SourceSpan**
  %t2284 = load %SourceSpan*, %SourceSpan** %t2283
  %t2285 = icmp eq i32 %t2271, 6
  %t2286 = select i1 %t2285, %SourceSpan* %t2284, %SourceSpan* %t2279
  %t2287 = getelementptr inbounds %Statement, %Statement* %t2272, i32 0, i32 1
  %t2288 = bitcast [56 x i8]* %t2287 to i8*
  %t2289 = getelementptr inbounds i8, i8* %t2288, i64 8
  %t2290 = bitcast i8* %t2289 to %SourceSpan**
  %t2291 = load %SourceSpan*, %SourceSpan** %t2290
  %t2292 = icmp eq i32 %t2271, 8
  %t2293 = select i1 %t2292, %SourceSpan* %t2291, %SourceSpan* %t2286
  %t2294 = getelementptr inbounds %Statement, %Statement* %t2272, i32 0, i32 1
  %t2295 = bitcast [40 x i8]* %t2294 to i8*
  %t2296 = getelementptr inbounds i8, i8* %t2295, i64 8
  %t2297 = bitcast i8* %t2296 to %SourceSpan**
  %t2298 = load %SourceSpan*, %SourceSpan** %t2297
  %t2299 = icmp eq i32 %t2271, 9
  %t2300 = select i1 %t2299, %SourceSpan* %t2298, %SourceSpan* %t2293
  %t2301 = getelementptr inbounds %Statement, %Statement* %t2272, i32 0, i32 1
  %t2302 = bitcast [40 x i8]* %t2301 to i8*
  %t2303 = getelementptr inbounds i8, i8* %t2302, i64 8
  %t2304 = bitcast i8* %t2303 to %SourceSpan**
  %t2305 = load %SourceSpan*, %SourceSpan** %t2304
  %t2306 = icmp eq i32 %t2271, 10
  %t2307 = select i1 %t2306, %SourceSpan* %t2305, %SourceSpan* %t2300
  %t2308 = getelementptr inbounds %Statement, %Statement* %t2272, i32 0, i32 1
  %t2309 = bitcast [40 x i8]* %t2308 to i8*
  %t2310 = getelementptr inbounds i8, i8* %t2309, i64 8
  %t2311 = bitcast i8* %t2310 to %SourceSpan**
  %t2312 = load %SourceSpan*, %SourceSpan** %t2311
  %t2313 = icmp eq i32 %t2271, 11
  %t2314 = select i1 %t2313, %SourceSpan* %t2312, %SourceSpan* %t2307
  %t2315 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t2268, i8* %t2269, %SourceSpan* %t2314)
  store %ScopeResult %t2315, %ScopeResult* %l17
  %t2316 = load %ScopeResult, %ScopeResult* %l17
  %t2317 = extractvalue %ScopeResult %t2316, 1
  %t2318 = extractvalue %Statement %statement, 0
  %t2319 = alloca %Statement
  store %Statement %statement, %Statement* %t2319
  %t2320 = getelementptr inbounds %Statement, %Statement* %t2319, i32 0, i32 1
  %t2321 = bitcast [88 x i8]* %t2320 to i8*
  %t2322 = getelementptr inbounds i8, i8* %t2321, i64 56
  %t2323 = bitcast i8* %t2322 to %Block*
  %t2324 = load %Block, %Block* %t2323
  %t2325 = icmp eq i32 %t2318, 4
  %t2326 = select i1 %t2325, %Block %t2324, %Block zeroinitializer
  %t2327 = getelementptr inbounds %Statement, %Statement* %t2319, i32 0, i32 1
  %t2328 = bitcast [88 x i8]* %t2327 to i8*
  %t2329 = getelementptr inbounds i8, i8* %t2328, i64 56
  %t2330 = bitcast i8* %t2329 to %Block*
  %t2331 = load %Block, %Block* %t2330
  %t2332 = icmp eq i32 %t2318, 5
  %t2333 = select i1 %t2332, %Block %t2331, %Block %t2326
  %t2334 = getelementptr inbounds %Statement, %Statement* %t2319, i32 0, i32 1
  %t2335 = bitcast [56 x i8]* %t2334 to i8*
  %t2336 = getelementptr inbounds i8, i8* %t2335, i64 16
  %t2337 = bitcast i8* %t2336 to %Block*
  %t2338 = load %Block, %Block* %t2337
  %t2339 = icmp eq i32 %t2318, 6
  %t2340 = select i1 %t2339, %Block %t2338, %Block %t2333
  %t2341 = getelementptr inbounds %Statement, %Statement* %t2319, i32 0, i32 1
  %t2342 = bitcast [88 x i8]* %t2341 to i8*
  %t2343 = getelementptr inbounds i8, i8* %t2342, i64 56
  %t2344 = bitcast i8* %t2343 to %Block*
  %t2345 = load %Block, %Block* %t2344
  %t2346 = icmp eq i32 %t2318, 7
  %t2347 = select i1 %t2346, %Block %t2345, %Block %t2340
  %t2348 = getelementptr inbounds %Statement, %Statement* %t2319, i32 0, i32 1
  %t2349 = bitcast [120 x i8]* %t2348 to i8*
  %t2350 = getelementptr inbounds i8, i8* %t2349, i64 88
  %t2351 = bitcast i8* %t2350 to %Block*
  %t2352 = load %Block, %Block* %t2351
  %t2353 = icmp eq i32 %t2318, 12
  %t2354 = select i1 %t2353, %Block %t2352, %Block %t2347
  %t2355 = getelementptr inbounds %Statement, %Statement* %t2319, i32 0, i32 1
  %t2356 = bitcast [40 x i8]* %t2355 to i8*
  %t2357 = getelementptr inbounds i8, i8* %t2356, i64 8
  %t2358 = bitcast i8* %t2357 to %Block*
  %t2359 = load %Block, %Block* %t2358
  %t2360 = icmp eq i32 %t2318, 13
  %t2361 = select i1 %t2360, %Block %t2359, %Block %t2354
  %t2362 = getelementptr inbounds %Statement, %Statement* %t2319, i32 0, i32 1
  %t2363 = bitcast [136 x i8]* %t2362 to i8*
  %t2364 = getelementptr inbounds i8, i8* %t2363, i64 104
  %t2365 = bitcast i8* %t2364 to %Block*
  %t2366 = load %Block, %Block* %t2365
  %t2367 = icmp eq i32 %t2318, 14
  %t2368 = select i1 %t2367, %Block %t2366, %Block %t2361
  %t2369 = getelementptr inbounds %Statement, %Statement* %t2319, i32 0, i32 1
  %t2370 = bitcast [32 x i8]* %t2369 to i8*
  %t2371 = bitcast i8* %t2370 to %Block*
  %t2372 = load %Block, %Block* %t2371
  %t2373 = icmp eq i32 %t2318, 15
  %t2374 = select i1 %t2373, %Block %t2372, %Block %t2368
  %t2375 = getelementptr [0 x %SymbolEntry], [0 x %SymbolEntry]* null, i32 1
  %t2376 = ptrtoint [0 x %SymbolEntry]* %t2375 to i64
  %t2377 = icmp eq i64 %t2376, 0
  %t2378 = select i1 %t2377, i64 1, i64 %t2376
  %t2379 = call i8* @malloc(i64 %t2378)
  %t2380 = bitcast i8* %t2379 to %SymbolEntry*
  %t2381 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* null, i32 1
  %t2382 = ptrtoint { %SymbolEntry*, i64 }* %t2381 to i64
  %t2383 = call i8* @malloc(i64 %t2382)
  %t2384 = bitcast i8* %t2383 to { %SymbolEntry*, i64 }*
  %t2385 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t2384, i32 0, i32 0
  store %SymbolEntry* %t2380, %SymbolEntry** %t2385
  %t2386 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t2384, i32 0, i32 1
  store i64 0, i64* %t2386
  %t2387 = call { %Diagnostic*, i64 }* @check_block(%Block %t2374, { %SymbolEntry*, i64 }* %t2384, { %Statement*, i64 }* %interfaces)
  %t2388 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2317, i32 0, i32 0
  %t2389 = load %Diagnostic*, %Diagnostic** %t2388
  %t2390 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2317, i32 0, i32 1
  %t2391 = load i64, i64* %t2390
  %t2392 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2387, i32 0, i32 0
  %t2393 = load %Diagnostic*, %Diagnostic** %t2392
  %t2394 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2387, i32 0, i32 1
  %t2395 = load i64, i64* %t2394
  %t2396 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t2397 = ptrtoint %Diagnostic* %t2396 to i64
  %t2398 = add i64 %t2391, %t2395
  %t2399 = mul i64 %t2397, %t2398
  %t2400 = call noalias i8* @malloc(i64 %t2399)
  %t2401 = bitcast i8* %t2400 to %Diagnostic*
  %t2402 = bitcast %Diagnostic* %t2401 to i8*
  %t2403 = mul i64 %t2397, %t2391
  %t2404 = bitcast %Diagnostic* %t2389 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2402, i8* %t2404, i64 %t2403)
  %t2405 = mul i64 %t2397, %t2395
  %t2406 = bitcast %Diagnostic* %t2393 to i8*
  %t2407 = getelementptr %Diagnostic, %Diagnostic* %t2401, i64 %t2391
  %t2408 = bitcast %Diagnostic* %t2407 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2408, i8* %t2406, i64 %t2405)
  %t2409 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t2410 = ptrtoint { %Diagnostic*, i64 }* %t2409 to i64
  %t2411 = call i8* @malloc(i64 %t2410)
  %t2412 = bitcast i8* %t2411 to { %Diagnostic*, i64 }*
  %t2413 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2412, i32 0, i32 0
  store %Diagnostic* %t2401, %Diagnostic** %t2413
  %t2414 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2412, i32 0, i32 1
  store i64 %t2398, i64* %t2414
  store { %Diagnostic*, i64 }* %t2412, { %Diagnostic*, i64 }** %l18
  %t2415 = load %ScopeResult, %ScopeResult* %l17
  %t2416 = extractvalue %ScopeResult %t2415, 0
  %t2417 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t2416, 0
  %t2418 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l18
  %t2419 = insertvalue %ScopeResult %t2417, { %Diagnostic*, i64 }* %t2418, 1
  ret %ScopeResult %t2419
merge23:
  %t2420 = extractvalue %Statement %statement, 0
  %t2421 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2422 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2423 = icmp eq i32 %t2420, 0
  %t2424 = select i1 %t2423, i8* %t2422, i8* %t2421
  %t2425 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2426 = icmp eq i32 %t2420, 1
  %t2427 = select i1 %t2426, i8* %t2425, i8* %t2424
  %t2428 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2429 = icmp eq i32 %t2420, 2
  %t2430 = select i1 %t2429, i8* %t2428, i8* %t2427
  %t2431 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2432 = icmp eq i32 %t2420, 3
  %t2433 = select i1 %t2432, i8* %t2431, i8* %t2430
  %t2434 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2435 = icmp eq i32 %t2420, 4
  %t2436 = select i1 %t2435, i8* %t2434, i8* %t2433
  %t2437 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2438 = icmp eq i32 %t2420, 5
  %t2439 = select i1 %t2438, i8* %t2437, i8* %t2436
  %t2440 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2441 = icmp eq i32 %t2420, 6
  %t2442 = select i1 %t2441, i8* %t2440, i8* %t2439
  %t2443 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2444 = icmp eq i32 %t2420, 7
  %t2445 = select i1 %t2444, i8* %t2443, i8* %t2442
  %t2446 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2447 = icmp eq i32 %t2420, 8
  %t2448 = select i1 %t2447, i8* %t2446, i8* %t2445
  %t2449 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2450 = icmp eq i32 %t2420, 9
  %t2451 = select i1 %t2450, i8* %t2449, i8* %t2448
  %t2452 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2453 = icmp eq i32 %t2420, 10
  %t2454 = select i1 %t2453, i8* %t2452, i8* %t2451
  %t2455 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2456 = icmp eq i32 %t2420, 11
  %t2457 = select i1 %t2456, i8* %t2455, i8* %t2454
  %t2458 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2459 = icmp eq i32 %t2420, 12
  %t2460 = select i1 %t2459, i8* %t2458, i8* %t2457
  %t2461 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2462 = icmp eq i32 %t2420, 13
  %t2463 = select i1 %t2462, i8* %t2461, i8* %t2460
  %t2464 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2465 = icmp eq i32 %t2420, 14
  %t2466 = select i1 %t2465, i8* %t2464, i8* %t2463
  %t2467 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2468 = icmp eq i32 %t2420, 15
  %t2469 = select i1 %t2468, i8* %t2467, i8* %t2466
  %t2470 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2471 = icmp eq i32 %t2420, 16
  %t2472 = select i1 %t2471, i8* %t2470, i8* %t2469
  %t2473 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2474 = icmp eq i32 %t2420, 17
  %t2475 = select i1 %t2474, i8* %t2473, i8* %t2472
  %t2476 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2477 = icmp eq i32 %t2420, 18
  %t2478 = select i1 %t2477, i8* %t2476, i8* %t2475
  %t2479 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2480 = icmp eq i32 %t2420, 19
  %t2481 = select i1 %t2480, i8* %t2479, i8* %t2478
  %t2482 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2483 = icmp eq i32 %t2420, 20
  %t2484 = select i1 %t2483, i8* %t2482, i8* %t2481
  %t2485 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2486 = icmp eq i32 %t2420, 21
  %t2487 = select i1 %t2486, i8* %t2485, i8* %t2484
  %t2488 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2489 = icmp eq i32 %t2420, 22
  %t2490 = select i1 %t2489, i8* %t2488, i8* %t2487
  %t2491 = call i8* @malloc(i64 14)
  %t2492 = bitcast i8* %t2491 to [14 x i8]*
  store [14 x i8] c"WithStatement\00", [14 x i8]* %t2492
  %t2493 = call i1 @strings_equal(i8* %t2490, i8* %t2491)
  br i1 %t2493, label %then24, label %merge25
then24:
  %t2494 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %bindings, 0
  %t2495 = extractvalue %Statement %statement, 0
  %t2496 = alloca %Statement
  store %Statement %statement, %Statement* %t2496
  %t2497 = getelementptr inbounds %Statement, %Statement* %t2496, i32 0, i32 1
  %t2498 = bitcast [88 x i8]* %t2497 to i8*
  %t2499 = getelementptr inbounds i8, i8* %t2498, i64 56
  %t2500 = bitcast i8* %t2499 to %Block*
  %t2501 = load %Block, %Block* %t2500
  %t2502 = icmp eq i32 %t2495, 4
  %t2503 = select i1 %t2502, %Block %t2501, %Block zeroinitializer
  %t2504 = getelementptr inbounds %Statement, %Statement* %t2496, i32 0, i32 1
  %t2505 = bitcast [88 x i8]* %t2504 to i8*
  %t2506 = getelementptr inbounds i8, i8* %t2505, i64 56
  %t2507 = bitcast i8* %t2506 to %Block*
  %t2508 = load %Block, %Block* %t2507
  %t2509 = icmp eq i32 %t2495, 5
  %t2510 = select i1 %t2509, %Block %t2508, %Block %t2503
  %t2511 = getelementptr inbounds %Statement, %Statement* %t2496, i32 0, i32 1
  %t2512 = bitcast [56 x i8]* %t2511 to i8*
  %t2513 = getelementptr inbounds i8, i8* %t2512, i64 16
  %t2514 = bitcast i8* %t2513 to %Block*
  %t2515 = load %Block, %Block* %t2514
  %t2516 = icmp eq i32 %t2495, 6
  %t2517 = select i1 %t2516, %Block %t2515, %Block %t2510
  %t2518 = getelementptr inbounds %Statement, %Statement* %t2496, i32 0, i32 1
  %t2519 = bitcast [88 x i8]* %t2518 to i8*
  %t2520 = getelementptr inbounds i8, i8* %t2519, i64 56
  %t2521 = bitcast i8* %t2520 to %Block*
  %t2522 = load %Block, %Block* %t2521
  %t2523 = icmp eq i32 %t2495, 7
  %t2524 = select i1 %t2523, %Block %t2522, %Block %t2517
  %t2525 = getelementptr inbounds %Statement, %Statement* %t2496, i32 0, i32 1
  %t2526 = bitcast [120 x i8]* %t2525 to i8*
  %t2527 = getelementptr inbounds i8, i8* %t2526, i64 88
  %t2528 = bitcast i8* %t2527 to %Block*
  %t2529 = load %Block, %Block* %t2528
  %t2530 = icmp eq i32 %t2495, 12
  %t2531 = select i1 %t2530, %Block %t2529, %Block %t2524
  %t2532 = getelementptr inbounds %Statement, %Statement* %t2496, i32 0, i32 1
  %t2533 = bitcast [40 x i8]* %t2532 to i8*
  %t2534 = getelementptr inbounds i8, i8* %t2533, i64 8
  %t2535 = bitcast i8* %t2534 to %Block*
  %t2536 = load %Block, %Block* %t2535
  %t2537 = icmp eq i32 %t2495, 13
  %t2538 = select i1 %t2537, %Block %t2536, %Block %t2531
  %t2539 = getelementptr inbounds %Statement, %Statement* %t2496, i32 0, i32 1
  %t2540 = bitcast [136 x i8]* %t2539 to i8*
  %t2541 = getelementptr inbounds i8, i8* %t2540, i64 104
  %t2542 = bitcast i8* %t2541 to %Block*
  %t2543 = load %Block, %Block* %t2542
  %t2544 = icmp eq i32 %t2495, 14
  %t2545 = select i1 %t2544, %Block %t2543, %Block %t2538
  %t2546 = getelementptr inbounds %Statement, %Statement* %t2496, i32 0, i32 1
  %t2547 = bitcast [32 x i8]* %t2546 to i8*
  %t2548 = bitcast i8* %t2547 to %Block*
  %t2549 = load %Block, %Block* %t2548
  %t2550 = icmp eq i32 %t2495, 15
  %t2551 = select i1 %t2550, %Block %t2549, %Block %t2545
  %t2552 = call { %Diagnostic*, i64 }* @check_block(%Block %t2551, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2553 = insertvalue %ScopeResult %t2494, { %Diagnostic*, i64 }* %t2552, 1
  ret %ScopeResult %t2553
merge25:
  %t2554 = extractvalue %Statement %statement, 0
  %t2555 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2556 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2557 = icmp eq i32 %t2554, 0
  %t2558 = select i1 %t2557, i8* %t2556, i8* %t2555
  %t2559 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2560 = icmp eq i32 %t2554, 1
  %t2561 = select i1 %t2560, i8* %t2559, i8* %t2558
  %t2562 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2563 = icmp eq i32 %t2554, 2
  %t2564 = select i1 %t2563, i8* %t2562, i8* %t2561
  %t2565 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2566 = icmp eq i32 %t2554, 3
  %t2567 = select i1 %t2566, i8* %t2565, i8* %t2564
  %t2568 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2569 = icmp eq i32 %t2554, 4
  %t2570 = select i1 %t2569, i8* %t2568, i8* %t2567
  %t2571 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2572 = icmp eq i32 %t2554, 5
  %t2573 = select i1 %t2572, i8* %t2571, i8* %t2570
  %t2574 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2575 = icmp eq i32 %t2554, 6
  %t2576 = select i1 %t2575, i8* %t2574, i8* %t2573
  %t2577 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2578 = icmp eq i32 %t2554, 7
  %t2579 = select i1 %t2578, i8* %t2577, i8* %t2576
  %t2580 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2581 = icmp eq i32 %t2554, 8
  %t2582 = select i1 %t2581, i8* %t2580, i8* %t2579
  %t2583 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2584 = icmp eq i32 %t2554, 9
  %t2585 = select i1 %t2584, i8* %t2583, i8* %t2582
  %t2586 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2587 = icmp eq i32 %t2554, 10
  %t2588 = select i1 %t2587, i8* %t2586, i8* %t2585
  %t2589 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2590 = icmp eq i32 %t2554, 11
  %t2591 = select i1 %t2590, i8* %t2589, i8* %t2588
  %t2592 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2593 = icmp eq i32 %t2554, 12
  %t2594 = select i1 %t2593, i8* %t2592, i8* %t2591
  %t2595 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2596 = icmp eq i32 %t2554, 13
  %t2597 = select i1 %t2596, i8* %t2595, i8* %t2594
  %t2598 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2599 = icmp eq i32 %t2554, 14
  %t2600 = select i1 %t2599, i8* %t2598, i8* %t2597
  %t2601 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2602 = icmp eq i32 %t2554, 15
  %t2603 = select i1 %t2602, i8* %t2601, i8* %t2600
  %t2604 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2605 = icmp eq i32 %t2554, 16
  %t2606 = select i1 %t2605, i8* %t2604, i8* %t2603
  %t2607 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2608 = icmp eq i32 %t2554, 17
  %t2609 = select i1 %t2608, i8* %t2607, i8* %t2606
  %t2610 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2611 = icmp eq i32 %t2554, 18
  %t2612 = select i1 %t2611, i8* %t2610, i8* %t2609
  %t2613 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2614 = icmp eq i32 %t2554, 19
  %t2615 = select i1 %t2614, i8* %t2613, i8* %t2612
  %t2616 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2617 = icmp eq i32 %t2554, 20
  %t2618 = select i1 %t2617, i8* %t2616, i8* %t2615
  %t2619 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2620 = icmp eq i32 %t2554, 21
  %t2621 = select i1 %t2620, i8* %t2619, i8* %t2618
  %t2622 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2623 = icmp eq i32 %t2554, 22
  %t2624 = select i1 %t2623, i8* %t2622, i8* %t2621
  %t2625 = call i8* @malloc(i64 13)
  %t2626 = bitcast i8* %t2625 to [13 x i8]*
  store [13 x i8] c"ForStatement\00", [13 x i8]* %t2626
  %t2627 = call i1 @strings_equal(i8* %t2624, i8* %t2625)
  br i1 %t2627, label %then26, label %merge27
then26:
  %t2628 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %bindings, 0
  %t2629 = extractvalue %Statement %statement, 0
  %t2630 = alloca %Statement
  store %Statement %statement, %Statement* %t2630
  %t2631 = getelementptr inbounds %Statement, %Statement* %t2630, i32 0, i32 1
  %t2632 = bitcast [88 x i8]* %t2631 to i8*
  %t2633 = getelementptr inbounds i8, i8* %t2632, i64 56
  %t2634 = bitcast i8* %t2633 to %Block*
  %t2635 = load %Block, %Block* %t2634
  %t2636 = icmp eq i32 %t2629, 4
  %t2637 = select i1 %t2636, %Block %t2635, %Block zeroinitializer
  %t2638 = getelementptr inbounds %Statement, %Statement* %t2630, i32 0, i32 1
  %t2639 = bitcast [88 x i8]* %t2638 to i8*
  %t2640 = getelementptr inbounds i8, i8* %t2639, i64 56
  %t2641 = bitcast i8* %t2640 to %Block*
  %t2642 = load %Block, %Block* %t2641
  %t2643 = icmp eq i32 %t2629, 5
  %t2644 = select i1 %t2643, %Block %t2642, %Block %t2637
  %t2645 = getelementptr inbounds %Statement, %Statement* %t2630, i32 0, i32 1
  %t2646 = bitcast [56 x i8]* %t2645 to i8*
  %t2647 = getelementptr inbounds i8, i8* %t2646, i64 16
  %t2648 = bitcast i8* %t2647 to %Block*
  %t2649 = load %Block, %Block* %t2648
  %t2650 = icmp eq i32 %t2629, 6
  %t2651 = select i1 %t2650, %Block %t2649, %Block %t2644
  %t2652 = getelementptr inbounds %Statement, %Statement* %t2630, i32 0, i32 1
  %t2653 = bitcast [88 x i8]* %t2652 to i8*
  %t2654 = getelementptr inbounds i8, i8* %t2653, i64 56
  %t2655 = bitcast i8* %t2654 to %Block*
  %t2656 = load %Block, %Block* %t2655
  %t2657 = icmp eq i32 %t2629, 7
  %t2658 = select i1 %t2657, %Block %t2656, %Block %t2651
  %t2659 = getelementptr inbounds %Statement, %Statement* %t2630, i32 0, i32 1
  %t2660 = bitcast [120 x i8]* %t2659 to i8*
  %t2661 = getelementptr inbounds i8, i8* %t2660, i64 88
  %t2662 = bitcast i8* %t2661 to %Block*
  %t2663 = load %Block, %Block* %t2662
  %t2664 = icmp eq i32 %t2629, 12
  %t2665 = select i1 %t2664, %Block %t2663, %Block %t2658
  %t2666 = getelementptr inbounds %Statement, %Statement* %t2630, i32 0, i32 1
  %t2667 = bitcast [40 x i8]* %t2666 to i8*
  %t2668 = getelementptr inbounds i8, i8* %t2667, i64 8
  %t2669 = bitcast i8* %t2668 to %Block*
  %t2670 = load %Block, %Block* %t2669
  %t2671 = icmp eq i32 %t2629, 13
  %t2672 = select i1 %t2671, %Block %t2670, %Block %t2665
  %t2673 = getelementptr inbounds %Statement, %Statement* %t2630, i32 0, i32 1
  %t2674 = bitcast [136 x i8]* %t2673 to i8*
  %t2675 = getelementptr inbounds i8, i8* %t2674, i64 104
  %t2676 = bitcast i8* %t2675 to %Block*
  %t2677 = load %Block, %Block* %t2676
  %t2678 = icmp eq i32 %t2629, 14
  %t2679 = select i1 %t2678, %Block %t2677, %Block %t2672
  %t2680 = getelementptr inbounds %Statement, %Statement* %t2630, i32 0, i32 1
  %t2681 = bitcast [32 x i8]* %t2680 to i8*
  %t2682 = bitcast i8* %t2681 to %Block*
  %t2683 = load %Block, %Block* %t2682
  %t2684 = icmp eq i32 %t2629, 15
  %t2685 = select i1 %t2684, %Block %t2683, %Block %t2679
  %t2686 = call { %Diagnostic*, i64 }* @check_block(%Block %t2685, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2687 = insertvalue %ScopeResult %t2628, { %Diagnostic*, i64 }* %t2686, 1
  ret %ScopeResult %t2687
merge27:
  %t2688 = extractvalue %Statement %statement, 0
  %t2689 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2690 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2691 = icmp eq i32 %t2688, 0
  %t2692 = select i1 %t2691, i8* %t2690, i8* %t2689
  %t2693 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2694 = icmp eq i32 %t2688, 1
  %t2695 = select i1 %t2694, i8* %t2693, i8* %t2692
  %t2696 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2697 = icmp eq i32 %t2688, 2
  %t2698 = select i1 %t2697, i8* %t2696, i8* %t2695
  %t2699 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2700 = icmp eq i32 %t2688, 3
  %t2701 = select i1 %t2700, i8* %t2699, i8* %t2698
  %t2702 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2703 = icmp eq i32 %t2688, 4
  %t2704 = select i1 %t2703, i8* %t2702, i8* %t2701
  %t2705 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2706 = icmp eq i32 %t2688, 5
  %t2707 = select i1 %t2706, i8* %t2705, i8* %t2704
  %t2708 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2709 = icmp eq i32 %t2688, 6
  %t2710 = select i1 %t2709, i8* %t2708, i8* %t2707
  %t2711 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2712 = icmp eq i32 %t2688, 7
  %t2713 = select i1 %t2712, i8* %t2711, i8* %t2710
  %t2714 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2715 = icmp eq i32 %t2688, 8
  %t2716 = select i1 %t2715, i8* %t2714, i8* %t2713
  %t2717 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2718 = icmp eq i32 %t2688, 9
  %t2719 = select i1 %t2718, i8* %t2717, i8* %t2716
  %t2720 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2721 = icmp eq i32 %t2688, 10
  %t2722 = select i1 %t2721, i8* %t2720, i8* %t2719
  %t2723 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2724 = icmp eq i32 %t2688, 11
  %t2725 = select i1 %t2724, i8* %t2723, i8* %t2722
  %t2726 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2727 = icmp eq i32 %t2688, 12
  %t2728 = select i1 %t2727, i8* %t2726, i8* %t2725
  %t2729 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2730 = icmp eq i32 %t2688, 13
  %t2731 = select i1 %t2730, i8* %t2729, i8* %t2728
  %t2732 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2733 = icmp eq i32 %t2688, 14
  %t2734 = select i1 %t2733, i8* %t2732, i8* %t2731
  %t2735 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2736 = icmp eq i32 %t2688, 15
  %t2737 = select i1 %t2736, i8* %t2735, i8* %t2734
  %t2738 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2739 = icmp eq i32 %t2688, 16
  %t2740 = select i1 %t2739, i8* %t2738, i8* %t2737
  %t2741 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2742 = icmp eq i32 %t2688, 17
  %t2743 = select i1 %t2742, i8* %t2741, i8* %t2740
  %t2744 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2745 = icmp eq i32 %t2688, 18
  %t2746 = select i1 %t2745, i8* %t2744, i8* %t2743
  %t2747 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2748 = icmp eq i32 %t2688, 19
  %t2749 = select i1 %t2748, i8* %t2747, i8* %t2746
  %t2750 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2751 = icmp eq i32 %t2688, 20
  %t2752 = select i1 %t2751, i8* %t2750, i8* %t2749
  %t2753 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2754 = icmp eq i32 %t2688, 21
  %t2755 = select i1 %t2754, i8* %t2753, i8* %t2752
  %t2756 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2757 = icmp eq i32 %t2688, 22
  %t2758 = select i1 %t2757, i8* %t2756, i8* %t2755
  %t2759 = call i8* @malloc(i64 15)
  %t2760 = bitcast i8* %t2759 to [15 x i8]*
  store [15 x i8] c"MatchStatement\00", [15 x i8]* %t2760
  %t2761 = call i1 @strings_equal(i8* %t2758, i8* %t2759)
  br i1 %t2761, label %then28, label %merge29
then28:
  %t2762 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t2763 = ptrtoint [0 x %Diagnostic]* %t2762 to i64
  %t2764 = icmp eq i64 %t2763, 0
  %t2765 = select i1 %t2764, i64 1, i64 %t2763
  %t2766 = call i8* @malloc(i64 %t2765)
  %t2767 = bitcast i8* %t2766 to %Diagnostic*
  %t2768 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t2769 = ptrtoint { %Diagnostic*, i64 }* %t2768 to i64
  %t2770 = call i8* @malloc(i64 %t2769)
  %t2771 = bitcast i8* %t2770 to { %Diagnostic*, i64 }*
  %t2772 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2771, i32 0, i32 0
  store %Diagnostic* %t2767, %Diagnostic** %t2772
  %t2773 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2771, i32 0, i32 1
  store i64 0, i64* %t2773
  store { %Diagnostic*, i64 }* %t2771, { %Diagnostic*, i64 }** %l19
  %t2774 = sitofp i64 0 to double
  store double %t2774, double* %l20
  %t2775 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2776 = load double, double* %l20
  br label %loop.header30
loop.header30:
  %t2847 = phi { %Diagnostic*, i64 }* [ %t2775, %then28 ], [ %t2845, %loop.latch32 ]
  %t2848 = phi double [ %t2776, %then28 ], [ %t2846, %loop.latch32 ]
  store { %Diagnostic*, i64 }* %t2847, { %Diagnostic*, i64 }** %l19
  store double %t2848, double* %l20
  br label %loop.body31
loop.body31:
  %t2777 = load double, double* %l20
  %t2778 = extractvalue %Statement %statement, 0
  %t2779 = alloca %Statement
  store %Statement %statement, %Statement* %t2779
  %t2780 = getelementptr inbounds %Statement, %Statement* %t2779, i32 0, i32 1
  %t2781 = bitcast [64 x i8]* %t2780 to i8*
  %t2782 = getelementptr inbounds i8, i8* %t2781, i64 48
  %t2783 = bitcast i8* %t2782 to { %MatchCase*, i64 }**
  %t2784 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %t2783
  %t2785 = icmp eq i32 %t2778, 18
  %t2786 = select i1 %t2785, { %MatchCase*, i64 }* %t2784, { %MatchCase*, i64 }* null
  %t2787 = load { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t2786
  %t2788 = extractvalue { %MatchCase*, i64 } %t2787, 1
  %t2789 = sitofp i64 %t2788 to double
  %t2790 = fcmp oge double %t2777, %t2789
  %t2791 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2792 = load double, double* %l20
  br i1 %t2790, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t2793 = extractvalue %Statement %statement, 0
  %t2794 = alloca %Statement
  store %Statement %statement, %Statement* %t2794
  %t2795 = getelementptr inbounds %Statement, %Statement* %t2794, i32 0, i32 1
  %t2796 = bitcast [64 x i8]* %t2795 to i8*
  %t2797 = getelementptr inbounds i8, i8* %t2796, i64 48
  %t2798 = bitcast i8* %t2797 to { %MatchCase*, i64 }**
  %t2799 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %t2798
  %t2800 = icmp eq i32 %t2793, 18
  %t2801 = select i1 %t2800, { %MatchCase*, i64 }* %t2799, { %MatchCase*, i64 }* null
  %t2802 = load double, double* %l20
  %t2803 = call double @llvm.round.f64(double %t2802)
  %t2804 = fptosi double %t2803 to i64
  %t2805 = load { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t2801
  %t2806 = extractvalue { %MatchCase*, i64 } %t2805, 0
  %t2807 = extractvalue { %MatchCase*, i64 } %t2805, 1
  %t2808 = icmp uge i64 %t2804, %t2807
  ; bounds check: %t2808 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t2804, i64 %t2807)
  %t2809 = getelementptr %MatchCase, %MatchCase* %t2806, i64 %t2804
  %t2810 = load %MatchCase, %MatchCase* %t2809
  store %MatchCase %t2810, %MatchCase* %l21
  %t2811 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2812 = load %MatchCase, %MatchCase* %l21
  %t2813 = extractvalue %MatchCase %t2812, 2
  %t2814 = call { %Diagnostic*, i64 }* @check_block(%Block %t2813, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2815 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2811, i32 0, i32 0
  %t2816 = load %Diagnostic*, %Diagnostic** %t2815
  %t2817 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2811, i32 0, i32 1
  %t2818 = load i64, i64* %t2817
  %t2819 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2814, i32 0, i32 0
  %t2820 = load %Diagnostic*, %Diagnostic** %t2819
  %t2821 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2814, i32 0, i32 1
  %t2822 = load i64, i64* %t2821
  %t2823 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t2824 = ptrtoint %Diagnostic* %t2823 to i64
  %t2825 = add i64 %t2818, %t2822
  %t2826 = mul i64 %t2824, %t2825
  %t2827 = call noalias i8* @malloc(i64 %t2826)
  %t2828 = bitcast i8* %t2827 to %Diagnostic*
  %t2829 = bitcast %Diagnostic* %t2828 to i8*
  %t2830 = mul i64 %t2824, %t2818
  %t2831 = bitcast %Diagnostic* %t2816 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2829, i8* %t2831, i64 %t2830)
  %t2832 = mul i64 %t2824, %t2822
  %t2833 = bitcast %Diagnostic* %t2820 to i8*
  %t2834 = getelementptr %Diagnostic, %Diagnostic* %t2828, i64 %t2818
  %t2835 = bitcast %Diagnostic* %t2834 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2835, i8* %t2833, i64 %t2832)
  %t2836 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t2837 = ptrtoint { %Diagnostic*, i64 }* %t2836 to i64
  %t2838 = call i8* @malloc(i64 %t2837)
  %t2839 = bitcast i8* %t2838 to { %Diagnostic*, i64 }*
  %t2840 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2839, i32 0, i32 0
  store %Diagnostic* %t2828, %Diagnostic** %t2840
  %t2841 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2839, i32 0, i32 1
  store i64 %t2825, i64* %t2841
  store { %Diagnostic*, i64 }* %t2839, { %Diagnostic*, i64 }** %l19
  %t2842 = load double, double* %l20
  %t2843 = sitofp i64 1 to double
  %t2844 = fadd double %t2842, %t2843
  store double %t2844, double* %l20
  br label %loop.latch32
loop.latch32:
  %t2845 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2846 = load double, double* %l20
  br label %loop.header30
afterloop33:
  %t2849 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2850 = load double, double* %l20
  %t2851 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %bindings, 0
  %t2852 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2853 = insertvalue %ScopeResult %t2851, { %Diagnostic*, i64 }* %t2852, 1
  ret %ScopeResult %t2853
merge29:
  %t2854 = extractvalue %Statement %statement, 0
  %t2855 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2856 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2857 = icmp eq i32 %t2854, 0
  %t2858 = select i1 %t2857, i8* %t2856, i8* %t2855
  %t2859 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2860 = icmp eq i32 %t2854, 1
  %t2861 = select i1 %t2860, i8* %t2859, i8* %t2858
  %t2862 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2863 = icmp eq i32 %t2854, 2
  %t2864 = select i1 %t2863, i8* %t2862, i8* %t2861
  %t2865 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2866 = icmp eq i32 %t2854, 3
  %t2867 = select i1 %t2866, i8* %t2865, i8* %t2864
  %t2868 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2869 = icmp eq i32 %t2854, 4
  %t2870 = select i1 %t2869, i8* %t2868, i8* %t2867
  %t2871 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2872 = icmp eq i32 %t2854, 5
  %t2873 = select i1 %t2872, i8* %t2871, i8* %t2870
  %t2874 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2875 = icmp eq i32 %t2854, 6
  %t2876 = select i1 %t2875, i8* %t2874, i8* %t2873
  %t2877 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2878 = icmp eq i32 %t2854, 7
  %t2879 = select i1 %t2878, i8* %t2877, i8* %t2876
  %t2880 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2881 = icmp eq i32 %t2854, 8
  %t2882 = select i1 %t2881, i8* %t2880, i8* %t2879
  %t2883 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2884 = icmp eq i32 %t2854, 9
  %t2885 = select i1 %t2884, i8* %t2883, i8* %t2882
  %t2886 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2887 = icmp eq i32 %t2854, 10
  %t2888 = select i1 %t2887, i8* %t2886, i8* %t2885
  %t2889 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2890 = icmp eq i32 %t2854, 11
  %t2891 = select i1 %t2890, i8* %t2889, i8* %t2888
  %t2892 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2893 = icmp eq i32 %t2854, 12
  %t2894 = select i1 %t2893, i8* %t2892, i8* %t2891
  %t2895 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2896 = icmp eq i32 %t2854, 13
  %t2897 = select i1 %t2896, i8* %t2895, i8* %t2894
  %t2898 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2899 = icmp eq i32 %t2854, 14
  %t2900 = select i1 %t2899, i8* %t2898, i8* %t2897
  %t2901 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2902 = icmp eq i32 %t2854, 15
  %t2903 = select i1 %t2902, i8* %t2901, i8* %t2900
  %t2904 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2905 = icmp eq i32 %t2854, 16
  %t2906 = select i1 %t2905, i8* %t2904, i8* %t2903
  %t2907 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2908 = icmp eq i32 %t2854, 17
  %t2909 = select i1 %t2908, i8* %t2907, i8* %t2906
  %t2910 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2911 = icmp eq i32 %t2854, 18
  %t2912 = select i1 %t2911, i8* %t2910, i8* %t2909
  %t2913 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2914 = icmp eq i32 %t2854, 19
  %t2915 = select i1 %t2914, i8* %t2913, i8* %t2912
  %t2916 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2917 = icmp eq i32 %t2854, 20
  %t2918 = select i1 %t2917, i8* %t2916, i8* %t2915
  %t2919 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2920 = icmp eq i32 %t2854, 21
  %t2921 = select i1 %t2920, i8* %t2919, i8* %t2918
  %t2922 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2923 = icmp eq i32 %t2854, 22
  %t2924 = select i1 %t2923, i8* %t2922, i8* %t2921
  %t2925 = call i8* @malloc(i64 12)
  %t2926 = bitcast i8* %t2925 to [12 x i8]*
  store [12 x i8] c"IfStatement\00", [12 x i8]* %t2926
  %t2927 = call i1 @strings_equal(i8* %t2924, i8* %t2925)
  br i1 %t2927, label %then36, label %merge37
then36:
  %t2928 = extractvalue %Statement %statement, 0
  %t2929 = alloca %Statement
  store %Statement %statement, %Statement* %t2929
  %t2930 = getelementptr inbounds %Statement, %Statement* %t2929, i32 0, i32 1
  %t2931 = bitcast [88 x i8]* %t2930 to i8*
  %t2932 = getelementptr inbounds i8, i8* %t2931, i64 48
  %t2933 = bitcast i8* %t2932 to %Block*
  %t2934 = load %Block, %Block* %t2933
  %t2935 = icmp eq i32 %t2928, 19
  %t2936 = select i1 %t2935, %Block %t2934, %Block zeroinitializer
  %t2937 = call { %Diagnostic*, i64 }* @check_block(%Block %t2936, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t2937, { %Diagnostic*, i64 }** %l22
  %t2938 = extractvalue %Statement %statement, 0
  %t2939 = alloca %Statement
  store %Statement %statement, %Statement* %t2939
  %t2940 = getelementptr inbounds %Statement, %Statement* %t2939, i32 0, i32 1
  %t2941 = bitcast [88 x i8]* %t2940 to i8*
  %t2942 = getelementptr inbounds i8, i8* %t2941, i64 72
  %t2943 = bitcast i8* %t2942 to %ElseBranch**
  %t2944 = load %ElseBranch*, %ElseBranch** %t2943
  %t2945 = icmp eq i32 %t2938, 19
  %t2946 = select i1 %t2945, %ElseBranch* %t2944, %ElseBranch* null
  %t2947 = icmp ne %ElseBranch* %t2946, null
  %t2948 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br i1 %t2947, label %then38, label %merge39
then38:
  %t2949 = extractvalue %Statement %statement, 0
  %t2950 = alloca %Statement
  store %Statement %statement, %Statement* %t2950
  %t2951 = getelementptr inbounds %Statement, %Statement* %t2950, i32 0, i32 1
  %t2952 = bitcast [88 x i8]* %t2951 to i8*
  %t2953 = getelementptr inbounds i8, i8* %t2952, i64 72
  %t2954 = bitcast i8* %t2953 to %ElseBranch**
  %t2955 = load %ElseBranch*, %ElseBranch** %t2954
  %t2956 = icmp eq i32 %t2949, 19
  %t2957 = select i1 %t2956, %ElseBranch* %t2955, %ElseBranch* null
  store %ElseBranch* %t2957, %ElseBranch** %l23
  %t2958 = load %ElseBranch*, %ElseBranch** %l23
  %t2959 = getelementptr %ElseBranch, %ElseBranch* %t2958, i32 0, i32 1
  %t2960 = load %Block*, %Block** %t2959
  %t2961 = icmp ne %Block* %t2960, null
  %t2962 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2963 = load %ElseBranch*, %ElseBranch** %l23
  br i1 %t2961, label %then40, label %merge41
then40:
  %t2964 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2965 = load %ElseBranch*, %ElseBranch** %l23
  %t2966 = getelementptr %ElseBranch, %ElseBranch* %t2965, i32 0, i32 1
  %t2967 = load %Block*, %Block** %t2966
  %t2968 = load %Block, %Block* %t2967
  %t2969 = call { %Diagnostic*, i64 }* @check_block(%Block %t2968, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2970 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2964, i32 0, i32 0
  %t2971 = load %Diagnostic*, %Diagnostic** %t2970
  %t2972 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2964, i32 0, i32 1
  %t2973 = load i64, i64* %t2972
  %t2974 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2969, i32 0, i32 0
  %t2975 = load %Diagnostic*, %Diagnostic** %t2974
  %t2976 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2969, i32 0, i32 1
  %t2977 = load i64, i64* %t2976
  %t2978 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t2979 = ptrtoint %Diagnostic* %t2978 to i64
  %t2980 = add i64 %t2973, %t2977
  %t2981 = mul i64 %t2979, %t2980
  %t2982 = call noalias i8* @malloc(i64 %t2981)
  %t2983 = bitcast i8* %t2982 to %Diagnostic*
  %t2984 = bitcast %Diagnostic* %t2983 to i8*
  %t2985 = mul i64 %t2979, %t2973
  %t2986 = bitcast %Diagnostic* %t2971 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2984, i8* %t2986, i64 %t2985)
  %t2987 = mul i64 %t2979, %t2977
  %t2988 = bitcast %Diagnostic* %t2975 to i8*
  %t2989 = getelementptr %Diagnostic, %Diagnostic* %t2983, i64 %t2973
  %t2990 = bitcast %Diagnostic* %t2989 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2990, i8* %t2988, i64 %t2987)
  %t2991 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t2992 = ptrtoint { %Diagnostic*, i64 }* %t2991 to i64
  %t2993 = call i8* @malloc(i64 %t2992)
  %t2994 = bitcast i8* %t2993 to { %Diagnostic*, i64 }*
  %t2995 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2994, i32 0, i32 0
  store %Diagnostic* %t2983, %Diagnostic** %t2995
  %t2996 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2994, i32 0, i32 1
  store i64 %t2980, i64* %t2996
  store { %Diagnostic*, i64 }* %t2994, { %Diagnostic*, i64 }** %l22
  %t2997 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br label %merge41
merge41:
  %t2998 = phi { %Diagnostic*, i64 }* [ %t2997, %then40 ], [ %t2962, %then38 ]
  store { %Diagnostic*, i64 }* %t2998, { %Diagnostic*, i64 }** %l22
  %t2999 = load %ElseBranch*, %ElseBranch** %l23
  %t3000 = getelementptr %ElseBranch, %ElseBranch* %t2999, i32 0, i32 0
  %t3001 = load %Statement*, %Statement** %t3000
  %t3002 = icmp ne %Statement* %t3001, null
  %t3003 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t3004 = load %ElseBranch*, %ElseBranch** %l23
  br i1 %t3002, label %then42, label %merge43
then42:
  %t3005 = load %ElseBranch*, %ElseBranch** %l23
  %t3006 = getelementptr %ElseBranch, %ElseBranch* %t3005, i32 0, i32 0
  %t3007 = load %Statement*, %Statement** %t3006
  %t3008 = load %Statement, %Statement* %t3007
  %t3009 = call %ScopeResult @check_statement(%Statement %t3008, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  store %ScopeResult %t3009, %ScopeResult* %l24
  %t3010 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t3011 = load %ScopeResult, %ScopeResult* %l24
  %t3012 = extractvalue %ScopeResult %t3011, 1
  %t3013 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3010, i32 0, i32 0
  %t3014 = load %Diagnostic*, %Diagnostic** %t3013
  %t3015 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3010, i32 0, i32 1
  %t3016 = load i64, i64* %t3015
  %t3017 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3012, i32 0, i32 0
  %t3018 = load %Diagnostic*, %Diagnostic** %t3017
  %t3019 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3012, i32 0, i32 1
  %t3020 = load i64, i64* %t3019
  %t3021 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t3022 = ptrtoint %Diagnostic* %t3021 to i64
  %t3023 = add i64 %t3016, %t3020
  %t3024 = mul i64 %t3022, %t3023
  %t3025 = call noalias i8* @malloc(i64 %t3024)
  %t3026 = bitcast i8* %t3025 to %Diagnostic*
  %t3027 = bitcast %Diagnostic* %t3026 to i8*
  %t3028 = mul i64 %t3022, %t3016
  %t3029 = bitcast %Diagnostic* %t3014 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t3027, i8* %t3029, i64 %t3028)
  %t3030 = mul i64 %t3022, %t3020
  %t3031 = bitcast %Diagnostic* %t3018 to i8*
  %t3032 = getelementptr %Diagnostic, %Diagnostic* %t3026, i64 %t3016
  %t3033 = bitcast %Diagnostic* %t3032 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t3033, i8* %t3031, i64 %t3030)
  %t3034 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t3035 = ptrtoint { %Diagnostic*, i64 }* %t3034 to i64
  %t3036 = call i8* @malloc(i64 %t3035)
  %t3037 = bitcast i8* %t3036 to { %Diagnostic*, i64 }*
  %t3038 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3037, i32 0, i32 0
  store %Diagnostic* %t3026, %Diagnostic** %t3038
  %t3039 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3037, i32 0, i32 1
  store i64 %t3023, i64* %t3039
  store { %Diagnostic*, i64 }* %t3037, { %Diagnostic*, i64 }** %l22
  %t3040 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br label %merge43
merge43:
  %t3041 = phi { %Diagnostic*, i64 }* [ %t3040, %then42 ], [ %t3003, %merge41 ]
  store { %Diagnostic*, i64 }* %t3041, { %Diagnostic*, i64 }** %l22
  %t3042 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t3043 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br label %merge39
merge39:
  %t3044 = phi { %Diagnostic*, i64 }* [ %t3042, %merge43 ], [ %t2948, %then36 ]
  %t3045 = phi { %Diagnostic*, i64 }* [ %t3043, %merge43 ], [ %t2948, %then36 ]
  store { %Diagnostic*, i64 }* %t3044, { %Diagnostic*, i64 }** %l22
  store { %Diagnostic*, i64 }* %t3045, { %Diagnostic*, i64 }** %l22
  %t3046 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %bindings, 0
  %t3047 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t3048 = insertvalue %ScopeResult %t3046, { %Diagnostic*, i64 }* %t3047, 1
  ret %ScopeResult %t3048
merge37:
  %t3049 = extractvalue %Statement %statement, 0
  %t3050 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t3051 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t3052 = icmp eq i32 %t3049, 0
  %t3053 = select i1 %t3052, i8* %t3051, i8* %t3050
  %t3054 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t3055 = icmp eq i32 %t3049, 1
  %t3056 = select i1 %t3055, i8* %t3054, i8* %t3053
  %t3057 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t3058 = icmp eq i32 %t3049, 2
  %t3059 = select i1 %t3058, i8* %t3057, i8* %t3056
  %t3060 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t3061 = icmp eq i32 %t3049, 3
  %t3062 = select i1 %t3061, i8* %t3060, i8* %t3059
  %t3063 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t3064 = icmp eq i32 %t3049, 4
  %t3065 = select i1 %t3064, i8* %t3063, i8* %t3062
  %t3066 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t3067 = icmp eq i32 %t3049, 5
  %t3068 = select i1 %t3067, i8* %t3066, i8* %t3065
  %t3069 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t3070 = icmp eq i32 %t3049, 6
  %t3071 = select i1 %t3070, i8* %t3069, i8* %t3068
  %t3072 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t3073 = icmp eq i32 %t3049, 7
  %t3074 = select i1 %t3073, i8* %t3072, i8* %t3071
  %t3075 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t3076 = icmp eq i32 %t3049, 8
  %t3077 = select i1 %t3076, i8* %t3075, i8* %t3074
  %t3078 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t3079 = icmp eq i32 %t3049, 9
  %t3080 = select i1 %t3079, i8* %t3078, i8* %t3077
  %t3081 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t3082 = icmp eq i32 %t3049, 10
  %t3083 = select i1 %t3082, i8* %t3081, i8* %t3080
  %t3084 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t3085 = icmp eq i32 %t3049, 11
  %t3086 = select i1 %t3085, i8* %t3084, i8* %t3083
  %t3087 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t3088 = icmp eq i32 %t3049, 12
  %t3089 = select i1 %t3088, i8* %t3087, i8* %t3086
  %t3090 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t3091 = icmp eq i32 %t3049, 13
  %t3092 = select i1 %t3091, i8* %t3090, i8* %t3089
  %t3093 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t3094 = icmp eq i32 %t3049, 14
  %t3095 = select i1 %t3094, i8* %t3093, i8* %t3092
  %t3096 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t3097 = icmp eq i32 %t3049, 15
  %t3098 = select i1 %t3097, i8* %t3096, i8* %t3095
  %t3099 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t3100 = icmp eq i32 %t3049, 16
  %t3101 = select i1 %t3100, i8* %t3099, i8* %t3098
  %t3102 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t3103 = icmp eq i32 %t3049, 17
  %t3104 = select i1 %t3103, i8* %t3102, i8* %t3101
  %t3105 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t3106 = icmp eq i32 %t3049, 18
  %t3107 = select i1 %t3106, i8* %t3105, i8* %t3104
  %t3108 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t3109 = icmp eq i32 %t3049, 19
  %t3110 = select i1 %t3109, i8* %t3108, i8* %t3107
  %t3111 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t3112 = icmp eq i32 %t3049, 20
  %t3113 = select i1 %t3112, i8* %t3111, i8* %t3110
  %t3114 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t3115 = icmp eq i32 %t3049, 21
  %t3116 = select i1 %t3115, i8* %t3114, i8* %t3113
  %t3117 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t3118 = icmp eq i32 %t3049, 22
  %t3119 = select i1 %t3118, i8* %t3117, i8* %t3116
  %t3120 = call i8* @malloc(i64 16)
  %t3121 = bitcast i8* %t3120 to [16 x i8]*
  store [16 x i8] c"PromptStatement\00", [16 x i8]* %t3121
  %t3122 = call i1 @strings_equal(i8* %t3119, i8* %t3120)
  br i1 %t3122, label %then44, label %merge45
then44:
  %t3123 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %bindings, 0
  %t3124 = extractvalue %Statement %statement, 0
  %t3125 = alloca %Statement
  store %Statement %statement, %Statement* %t3125
  %t3126 = getelementptr inbounds %Statement, %Statement* %t3125, i32 0, i32 1
  %t3127 = bitcast [88 x i8]* %t3126 to i8*
  %t3128 = getelementptr inbounds i8, i8* %t3127, i64 56
  %t3129 = bitcast i8* %t3128 to %Block*
  %t3130 = load %Block, %Block* %t3129
  %t3131 = icmp eq i32 %t3124, 4
  %t3132 = select i1 %t3131, %Block %t3130, %Block zeroinitializer
  %t3133 = getelementptr inbounds %Statement, %Statement* %t3125, i32 0, i32 1
  %t3134 = bitcast [88 x i8]* %t3133 to i8*
  %t3135 = getelementptr inbounds i8, i8* %t3134, i64 56
  %t3136 = bitcast i8* %t3135 to %Block*
  %t3137 = load %Block, %Block* %t3136
  %t3138 = icmp eq i32 %t3124, 5
  %t3139 = select i1 %t3138, %Block %t3137, %Block %t3132
  %t3140 = getelementptr inbounds %Statement, %Statement* %t3125, i32 0, i32 1
  %t3141 = bitcast [56 x i8]* %t3140 to i8*
  %t3142 = getelementptr inbounds i8, i8* %t3141, i64 16
  %t3143 = bitcast i8* %t3142 to %Block*
  %t3144 = load %Block, %Block* %t3143
  %t3145 = icmp eq i32 %t3124, 6
  %t3146 = select i1 %t3145, %Block %t3144, %Block %t3139
  %t3147 = getelementptr inbounds %Statement, %Statement* %t3125, i32 0, i32 1
  %t3148 = bitcast [88 x i8]* %t3147 to i8*
  %t3149 = getelementptr inbounds i8, i8* %t3148, i64 56
  %t3150 = bitcast i8* %t3149 to %Block*
  %t3151 = load %Block, %Block* %t3150
  %t3152 = icmp eq i32 %t3124, 7
  %t3153 = select i1 %t3152, %Block %t3151, %Block %t3146
  %t3154 = getelementptr inbounds %Statement, %Statement* %t3125, i32 0, i32 1
  %t3155 = bitcast [120 x i8]* %t3154 to i8*
  %t3156 = getelementptr inbounds i8, i8* %t3155, i64 88
  %t3157 = bitcast i8* %t3156 to %Block*
  %t3158 = load %Block, %Block* %t3157
  %t3159 = icmp eq i32 %t3124, 12
  %t3160 = select i1 %t3159, %Block %t3158, %Block %t3153
  %t3161 = getelementptr inbounds %Statement, %Statement* %t3125, i32 0, i32 1
  %t3162 = bitcast [40 x i8]* %t3161 to i8*
  %t3163 = getelementptr inbounds i8, i8* %t3162, i64 8
  %t3164 = bitcast i8* %t3163 to %Block*
  %t3165 = load %Block, %Block* %t3164
  %t3166 = icmp eq i32 %t3124, 13
  %t3167 = select i1 %t3166, %Block %t3165, %Block %t3160
  %t3168 = getelementptr inbounds %Statement, %Statement* %t3125, i32 0, i32 1
  %t3169 = bitcast [136 x i8]* %t3168 to i8*
  %t3170 = getelementptr inbounds i8, i8* %t3169, i64 104
  %t3171 = bitcast i8* %t3170 to %Block*
  %t3172 = load %Block, %Block* %t3171
  %t3173 = icmp eq i32 %t3124, 14
  %t3174 = select i1 %t3173, %Block %t3172, %Block %t3167
  %t3175 = getelementptr inbounds %Statement, %Statement* %t3125, i32 0, i32 1
  %t3176 = bitcast [32 x i8]* %t3175 to i8*
  %t3177 = bitcast i8* %t3176 to %Block*
  %t3178 = load %Block, %Block* %t3177
  %t3179 = icmp eq i32 %t3124, 15
  %t3180 = select i1 %t3179, %Block %t3178, %Block %t3174
  %t3181 = call { %Diagnostic*, i64 }* @check_block(%Block %t3180, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t3182 = insertvalue %ScopeResult %t3123, { %Diagnostic*, i64 }* %t3181, 1
  ret %ScopeResult %t3182
merge45:
  %t3183 = extractvalue %Statement %statement, 0
  %t3184 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t3185 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t3186 = icmp eq i32 %t3183, 0
  %t3187 = select i1 %t3186, i8* %t3185, i8* %t3184
  %t3188 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t3189 = icmp eq i32 %t3183, 1
  %t3190 = select i1 %t3189, i8* %t3188, i8* %t3187
  %t3191 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t3192 = icmp eq i32 %t3183, 2
  %t3193 = select i1 %t3192, i8* %t3191, i8* %t3190
  %t3194 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t3195 = icmp eq i32 %t3183, 3
  %t3196 = select i1 %t3195, i8* %t3194, i8* %t3193
  %t3197 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t3198 = icmp eq i32 %t3183, 4
  %t3199 = select i1 %t3198, i8* %t3197, i8* %t3196
  %t3200 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t3201 = icmp eq i32 %t3183, 5
  %t3202 = select i1 %t3201, i8* %t3200, i8* %t3199
  %t3203 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t3204 = icmp eq i32 %t3183, 6
  %t3205 = select i1 %t3204, i8* %t3203, i8* %t3202
  %t3206 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t3207 = icmp eq i32 %t3183, 7
  %t3208 = select i1 %t3207, i8* %t3206, i8* %t3205
  %t3209 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t3210 = icmp eq i32 %t3183, 8
  %t3211 = select i1 %t3210, i8* %t3209, i8* %t3208
  %t3212 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t3213 = icmp eq i32 %t3183, 9
  %t3214 = select i1 %t3213, i8* %t3212, i8* %t3211
  %t3215 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t3216 = icmp eq i32 %t3183, 10
  %t3217 = select i1 %t3216, i8* %t3215, i8* %t3214
  %t3218 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t3219 = icmp eq i32 %t3183, 11
  %t3220 = select i1 %t3219, i8* %t3218, i8* %t3217
  %t3221 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t3222 = icmp eq i32 %t3183, 12
  %t3223 = select i1 %t3222, i8* %t3221, i8* %t3220
  %t3224 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t3225 = icmp eq i32 %t3183, 13
  %t3226 = select i1 %t3225, i8* %t3224, i8* %t3223
  %t3227 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t3228 = icmp eq i32 %t3183, 14
  %t3229 = select i1 %t3228, i8* %t3227, i8* %t3226
  %t3230 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t3231 = icmp eq i32 %t3183, 15
  %t3232 = select i1 %t3231, i8* %t3230, i8* %t3229
  %t3233 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t3234 = icmp eq i32 %t3183, 16
  %t3235 = select i1 %t3234, i8* %t3233, i8* %t3232
  %t3236 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t3237 = icmp eq i32 %t3183, 17
  %t3238 = select i1 %t3237, i8* %t3236, i8* %t3235
  %t3239 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t3240 = icmp eq i32 %t3183, 18
  %t3241 = select i1 %t3240, i8* %t3239, i8* %t3238
  %t3242 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t3243 = icmp eq i32 %t3183, 19
  %t3244 = select i1 %t3243, i8* %t3242, i8* %t3241
  %t3245 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t3246 = icmp eq i32 %t3183, 20
  %t3247 = select i1 %t3246, i8* %t3245, i8* %t3244
  %t3248 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t3249 = icmp eq i32 %t3183, 21
  %t3250 = select i1 %t3249, i8* %t3248, i8* %t3247
  %t3251 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t3252 = icmp eq i32 %t3183, 22
  %t3253 = select i1 %t3252, i8* %t3251, i8* %t3250
  %t3254 = call i8* @malloc(i64 21)
  %t3255 = bitcast i8* %t3254 to [21 x i8]*
  store [21 x i8] c"TypeAliasDeclaration\00", [21 x i8]* %t3255
  %t3256 = call i1 @strings_equal(i8* %t3253, i8* %t3254)
  br i1 %t3256, label %then46, label %merge47
then46:
  %t3257 = extractvalue %Statement %statement, 0
  %t3258 = alloca %Statement
  store %Statement %statement, %Statement* %t3258
  %t3259 = getelementptr inbounds %Statement, %Statement* %t3258, i32 0, i32 1
  %t3260 = bitcast [48 x i8]* %t3259 to i8*
  %t3261 = bitcast i8* %t3260 to i8**
  %t3262 = load i8*, i8** %t3261
  %t3263 = icmp eq i32 %t3257, 2
  %t3264 = select i1 %t3263, i8* %t3262, i8* null
  %t3265 = getelementptr inbounds %Statement, %Statement* %t3258, i32 0, i32 1
  %t3266 = bitcast [48 x i8]* %t3265 to i8*
  %t3267 = bitcast i8* %t3266 to i8**
  %t3268 = load i8*, i8** %t3267
  %t3269 = icmp eq i32 %t3257, 3
  %t3270 = select i1 %t3269, i8* %t3268, i8* %t3264
  %t3271 = getelementptr inbounds %Statement, %Statement* %t3258, i32 0, i32 1
  %t3272 = bitcast [56 x i8]* %t3271 to i8*
  %t3273 = bitcast i8* %t3272 to i8**
  %t3274 = load i8*, i8** %t3273
  %t3275 = icmp eq i32 %t3257, 6
  %t3276 = select i1 %t3275, i8* %t3274, i8* %t3270
  %t3277 = getelementptr inbounds %Statement, %Statement* %t3258, i32 0, i32 1
  %t3278 = bitcast [56 x i8]* %t3277 to i8*
  %t3279 = bitcast i8* %t3278 to i8**
  %t3280 = load i8*, i8** %t3279
  %t3281 = icmp eq i32 %t3257, 8
  %t3282 = select i1 %t3281, i8* %t3280, i8* %t3276
  %t3283 = getelementptr inbounds %Statement, %Statement* %t3258, i32 0, i32 1
  %t3284 = bitcast [40 x i8]* %t3283 to i8*
  %t3285 = bitcast i8* %t3284 to i8**
  %t3286 = load i8*, i8** %t3285
  %t3287 = icmp eq i32 %t3257, 9
  %t3288 = select i1 %t3287, i8* %t3286, i8* %t3282
  %t3289 = getelementptr inbounds %Statement, %Statement* %t3258, i32 0, i32 1
  %t3290 = bitcast [40 x i8]* %t3289 to i8*
  %t3291 = bitcast i8* %t3290 to i8**
  %t3292 = load i8*, i8** %t3291
  %t3293 = icmp eq i32 %t3257, 10
  %t3294 = select i1 %t3293, i8* %t3292, i8* %t3288
  %t3295 = getelementptr inbounds %Statement, %Statement* %t3258, i32 0, i32 1
  %t3296 = bitcast [40 x i8]* %t3295 to i8*
  %t3297 = bitcast i8* %t3296 to i8**
  %t3298 = load i8*, i8** %t3297
  %t3299 = icmp eq i32 %t3257, 11
  %t3300 = select i1 %t3299, i8* %t3298, i8* %t3294
  %t3301 = call i8* @malloc(i64 5)
  %t3302 = bitcast i8* %t3301 to [5 x i8]*
  store [5 x i8] c"type\00", [5 x i8]* %t3302
  %t3303 = extractvalue %Statement %statement, 0
  %t3304 = alloca %Statement
  store %Statement %statement, %Statement* %t3304
  %t3305 = getelementptr inbounds %Statement, %Statement* %t3304, i32 0, i32 1
  %t3306 = bitcast [48 x i8]* %t3305 to i8*
  %t3307 = getelementptr inbounds i8, i8* %t3306, i64 8
  %t3308 = bitcast i8* %t3307 to %SourceSpan**
  %t3309 = load %SourceSpan*, %SourceSpan** %t3308
  %t3310 = icmp eq i32 %t3303, 3
  %t3311 = select i1 %t3310, %SourceSpan* %t3309, %SourceSpan* null
  %t3312 = getelementptr inbounds %Statement, %Statement* %t3304, i32 0, i32 1
  %t3313 = bitcast [56 x i8]* %t3312 to i8*
  %t3314 = getelementptr inbounds i8, i8* %t3313, i64 8
  %t3315 = bitcast i8* %t3314 to %SourceSpan**
  %t3316 = load %SourceSpan*, %SourceSpan** %t3315
  %t3317 = icmp eq i32 %t3303, 6
  %t3318 = select i1 %t3317, %SourceSpan* %t3316, %SourceSpan* %t3311
  %t3319 = getelementptr inbounds %Statement, %Statement* %t3304, i32 0, i32 1
  %t3320 = bitcast [56 x i8]* %t3319 to i8*
  %t3321 = getelementptr inbounds i8, i8* %t3320, i64 8
  %t3322 = bitcast i8* %t3321 to %SourceSpan**
  %t3323 = load %SourceSpan*, %SourceSpan** %t3322
  %t3324 = icmp eq i32 %t3303, 8
  %t3325 = select i1 %t3324, %SourceSpan* %t3323, %SourceSpan* %t3318
  %t3326 = getelementptr inbounds %Statement, %Statement* %t3304, i32 0, i32 1
  %t3327 = bitcast [40 x i8]* %t3326 to i8*
  %t3328 = getelementptr inbounds i8, i8* %t3327, i64 8
  %t3329 = bitcast i8* %t3328 to %SourceSpan**
  %t3330 = load %SourceSpan*, %SourceSpan** %t3329
  %t3331 = icmp eq i32 %t3303, 9
  %t3332 = select i1 %t3331, %SourceSpan* %t3330, %SourceSpan* %t3325
  %t3333 = getelementptr inbounds %Statement, %Statement* %t3304, i32 0, i32 1
  %t3334 = bitcast [40 x i8]* %t3333 to i8*
  %t3335 = getelementptr inbounds i8, i8* %t3334, i64 8
  %t3336 = bitcast i8* %t3335 to %SourceSpan**
  %t3337 = load %SourceSpan*, %SourceSpan** %t3336
  %t3338 = icmp eq i32 %t3303, 10
  %t3339 = select i1 %t3338, %SourceSpan* %t3337, %SourceSpan* %t3332
  %t3340 = getelementptr inbounds %Statement, %Statement* %t3304, i32 0, i32 1
  %t3341 = bitcast [40 x i8]* %t3340 to i8*
  %t3342 = getelementptr inbounds i8, i8* %t3341, i64 8
  %t3343 = bitcast i8* %t3342 to %SourceSpan**
  %t3344 = load %SourceSpan*, %SourceSpan** %t3343
  %t3345 = icmp eq i32 %t3303, 11
  %t3346 = select i1 %t3345, %SourceSpan* %t3344, %SourceSpan* %t3339
  %t3347 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t3300, i8* %t3301, %SourceSpan* %t3346)
  store %ScopeResult %t3347, %ScopeResult* %l25
  %t3348 = load %ScopeResult, %ScopeResult* %l25
  %t3349 = extractvalue %ScopeResult %t3348, 1
  %t3350 = extractvalue %Statement %statement, 0
  %t3351 = alloca %Statement
  store %Statement %statement, %Statement* %t3351
  %t3352 = getelementptr inbounds %Statement, %Statement* %t3351, i32 0, i32 1
  %t3353 = bitcast [56 x i8]* %t3352 to i8*
  %t3354 = getelementptr inbounds i8, i8* %t3353, i64 16
  %t3355 = bitcast i8* %t3354 to { %TypeParameter*, i64 }**
  %t3356 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t3355
  %t3357 = icmp eq i32 %t3350, 8
  %t3358 = select i1 %t3357, { %TypeParameter*, i64 }* %t3356, { %TypeParameter*, i64 }* null
  %t3359 = getelementptr inbounds %Statement, %Statement* %t3351, i32 0, i32 1
  %t3360 = bitcast [40 x i8]* %t3359 to i8*
  %t3361 = getelementptr inbounds i8, i8* %t3360, i64 16
  %t3362 = bitcast i8* %t3361 to { %TypeParameter*, i64 }**
  %t3363 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t3362
  %t3364 = icmp eq i32 %t3350, 9
  %t3365 = select i1 %t3364, { %TypeParameter*, i64 }* %t3363, { %TypeParameter*, i64 }* %t3358
  %t3366 = getelementptr inbounds %Statement, %Statement* %t3351, i32 0, i32 1
  %t3367 = bitcast [40 x i8]* %t3366 to i8*
  %t3368 = getelementptr inbounds i8, i8* %t3367, i64 16
  %t3369 = bitcast i8* %t3368 to { %TypeParameter*, i64 }**
  %t3370 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t3369
  %t3371 = icmp eq i32 %t3350, 10
  %t3372 = select i1 %t3371, { %TypeParameter*, i64 }* %t3370, { %TypeParameter*, i64 }* %t3365
  %t3373 = getelementptr inbounds %Statement, %Statement* %t3351, i32 0, i32 1
  %t3374 = bitcast [40 x i8]* %t3373 to i8*
  %t3375 = getelementptr inbounds i8, i8* %t3374, i64 16
  %t3376 = bitcast i8* %t3375 to { %TypeParameter*, i64 }**
  %t3377 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t3376
  %t3378 = icmp eq i32 %t3350, 11
  %t3379 = select i1 %t3378, { %TypeParameter*, i64 }* %t3377, { %TypeParameter*, i64 }* %t3372
  %t3380 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t3379)
  %t3381 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3349, i32 0, i32 0
  %t3382 = load %Diagnostic*, %Diagnostic** %t3381
  %t3383 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3349, i32 0, i32 1
  %t3384 = load i64, i64* %t3383
  %t3385 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3380, i32 0, i32 0
  %t3386 = load %Diagnostic*, %Diagnostic** %t3385
  %t3387 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3380, i32 0, i32 1
  %t3388 = load i64, i64* %t3387
  %t3389 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t3390 = ptrtoint %Diagnostic* %t3389 to i64
  %t3391 = add i64 %t3384, %t3388
  %t3392 = mul i64 %t3390, %t3391
  %t3393 = call noalias i8* @malloc(i64 %t3392)
  %t3394 = bitcast i8* %t3393 to %Diagnostic*
  %t3395 = bitcast %Diagnostic* %t3394 to i8*
  %t3396 = mul i64 %t3390, %t3384
  %t3397 = bitcast %Diagnostic* %t3382 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t3395, i8* %t3397, i64 %t3396)
  %t3398 = mul i64 %t3390, %t3388
  %t3399 = bitcast %Diagnostic* %t3386 to i8*
  %t3400 = getelementptr %Diagnostic, %Diagnostic* %t3394, i64 %t3384
  %t3401 = bitcast %Diagnostic* %t3400 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t3401, i8* %t3399, i64 %t3398)
  %t3402 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t3403 = ptrtoint { %Diagnostic*, i64 }* %t3402 to i64
  %t3404 = call i8* @malloc(i64 %t3403)
  %t3405 = bitcast i8* %t3404 to { %Diagnostic*, i64 }*
  %t3406 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3405, i32 0, i32 0
  store %Diagnostic* %t3394, %Diagnostic** %t3406
  %t3407 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3405, i32 0, i32 1
  store i64 %t3391, i64* %t3407
  store { %Diagnostic*, i64 }* %t3405, { %Diagnostic*, i64 }** %l26
  %t3408 = load %ScopeResult, %ScopeResult* %l25
  %t3409 = extractvalue %ScopeResult %t3408, 0
  %t3410 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t3409, 0
  %t3411 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l26
  %t3412 = insertvalue %ScopeResult %t3410, { %Diagnostic*, i64 }* %t3411, 1
  ret %ScopeResult %t3412
merge47:
  %t3413 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %bindings, 0
  %t3414 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t3415 = ptrtoint [0 x %Diagnostic]* %t3414 to i64
  %t3416 = icmp eq i64 %t3415, 0
  %t3417 = select i1 %t3416, i64 1, i64 %t3415
  %t3418 = call i8* @malloc(i64 %t3417)
  %t3419 = bitcast i8* %t3418 to %Diagnostic*
  %t3420 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t3421 = ptrtoint { %Diagnostic*, i64 }* %t3420 to i64
  %t3422 = call i8* @malloc(i64 %t3421)
  %t3423 = bitcast i8* %t3422 to { %Diagnostic*, i64 }*
  %t3424 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3423, i32 0, i32 0
  store %Diagnostic* %t3419, %Diagnostic** %t3424
  %t3425 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3423, i32 0, i32 1
  store i64 0, i64* %t3425
  %t3426 = insertvalue %ScopeResult %t3413, { %Diagnostic*, i64 }* %t3423, 1
  ret %ScopeResult %t3426
}

define { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %signature, %Block %body, { %Statement*, i64 }* %interfaces) {
block.entry:
  %l0 = alloca %ScopeResult
  %l1 = alloca { %Diagnostic*, i64 }*
  %t0 = call %ScopeResult @seed_parameter_scope(%FunctionSignature %signature)
  store %ScopeResult %t0, %ScopeResult* %l0
  %t1 = load %ScopeResult, %ScopeResult* %l0
  %t2 = extractvalue %ScopeResult %t1, 0
  %t3 = call { %Diagnostic*, i64 }* @check_block(%Block %body, { %SymbolEntry*, i64 }* %t2, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t3, { %Diagnostic*, i64 }** %l1
  %t4 = load %ScopeResult, %ScopeResult* %l0
  %t5 = extractvalue %ScopeResult %t4, 1
  %t6 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t7 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t5, i32 0, i32 0
  %t8 = load %Diagnostic*, %Diagnostic** %t7
  %t9 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t5, i32 0, i32 1
  %t10 = load i64, i64* %t9
  %t11 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t6, i32 0, i32 0
  %t12 = load %Diagnostic*, %Diagnostic** %t11
  %t13 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t6, i32 0, i32 1
  %t14 = load i64, i64* %t13
  %t15 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t16 = ptrtoint %Diagnostic* %t15 to i64
  %t17 = add i64 %t10, %t14
  %t18 = mul i64 %t16, %t17
  %t19 = call noalias i8* @malloc(i64 %t18)
  %t20 = bitcast i8* %t19 to %Diagnostic*
  %t21 = bitcast %Diagnostic* %t20 to i8*
  %t22 = mul i64 %t16, %t10
  %t23 = bitcast %Diagnostic* %t8 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t21, i8* %t23, i64 %t22)
  %t24 = mul i64 %t16, %t14
  %t25 = bitcast %Diagnostic* %t12 to i8*
  %t26 = getelementptr %Diagnostic, %Diagnostic* %t20, i64 %t10
  %t27 = bitcast %Diagnostic* %t26 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t25, i64 %t24)
  %t28 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t29 = ptrtoint { %Diagnostic*, i64 }* %t28 to i64
  %t30 = call i8* @malloc(i64 %t29)
  %t31 = bitcast i8* %t30 to { %Diagnostic*, i64 }*
  %t32 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t31, i32 0, i32 0
  store %Diagnostic* %t20, %Diagnostic** %t32
  %t33 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t31, i32 0, i32 1
  store i64 %t17, i64* %t33
  ret { %Diagnostic*, i64 }* %t31
}

define %ScopeResult @seed_parameter_scope(%FunctionSignature %signature) {
block.entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %Parameter
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
  %t25 = getelementptr { %Parameter*, i64 }, { %Parameter*, i64 }* %t24, i32 0, i32 1
  %t26 = load i64, i64* %t25
  %t27 = getelementptr { %Parameter*, i64 }, { %Parameter*, i64 }* %t24, i32 0, i32 0
  %t28 = load %Parameter*, %Parameter** %t27
  store i64 0, i64* %l2
  store %Parameter zeroinitializer, %Parameter* %l3
  br label %for0
for0:
  %t29 = load i64, i64* %l2
  %t30 = icmp slt i64 %t29, %t26
  br i1 %t30, label %forbody1, label %afterfor3
forbody1:
  %t31 = load i64, i64* %l2
  %t32 = getelementptr %Parameter, %Parameter* %t28, i64 %t31
  %t33 = load %Parameter, %Parameter* %t32
  store %Parameter %t33, %Parameter* %l3
  %t34 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t35 = load %Parameter, %Parameter* %l3
  %t36 = extractvalue %Parameter %t35, 0
  %t37 = call i8* @malloc(i64 10)
  %t38 = bitcast i8* %t37 to [10 x i8]*
  store [10 x i8] c"parameter\00", [10 x i8]* %t38
  %t39 = load %Parameter, %Parameter* %l3
  %t40 = extractvalue %Parameter %t39, 4
  %t41 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %t34, i8* %t36, i8* %t37, %SourceSpan* %t40)
  store %ScopeResult %t41, %ScopeResult* %l4
  %t42 = load %ScopeResult, %ScopeResult* %l4
  %t43 = extractvalue %ScopeResult %t42, 0
  store { %SymbolEntry*, i64 }* %t43, { %SymbolEntry*, i64 }** %l0
  %t44 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t45 = load %ScopeResult, %ScopeResult* %l4
  %t46 = extractvalue %ScopeResult %t45, 1
  %t47 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t44, i32 0, i32 0
  %t48 = load %Diagnostic*, %Diagnostic** %t47
  %t49 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t44, i32 0, i32 1
  %t50 = load i64, i64* %t49
  %t51 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t46, i32 0, i32 0
  %t52 = load %Diagnostic*, %Diagnostic** %t51
  %t53 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t46, i32 0, i32 1
  %t54 = load i64, i64* %t53
  %t55 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t56 = ptrtoint %Diagnostic* %t55 to i64
  %t57 = add i64 %t50, %t54
  %t58 = mul i64 %t56, %t57
  %t59 = call noalias i8* @malloc(i64 %t58)
  %t60 = bitcast i8* %t59 to %Diagnostic*
  %t61 = bitcast %Diagnostic* %t60 to i8*
  %t62 = mul i64 %t56, %t50
  %t63 = bitcast %Diagnostic* %t48 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t61, i8* %t63, i64 %t62)
  %t64 = mul i64 %t56, %t54
  %t65 = bitcast %Diagnostic* %t52 to i8*
  %t66 = getelementptr %Diagnostic, %Diagnostic* %t60, i64 %t50
  %t67 = bitcast %Diagnostic* %t66 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t67, i8* %t65, i64 %t64)
  %t68 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t69 = ptrtoint { %Diagnostic*, i64 }* %t68 to i64
  %t70 = call i8* @malloc(i64 %t69)
  %t71 = bitcast i8* %t70 to { %Diagnostic*, i64 }*
  %t72 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t71, i32 0, i32 0
  store %Diagnostic* %t60, %Diagnostic** %t72
  %t73 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t71, i32 0, i32 1
  store i64 %t57, i64* %t73
  store { %Diagnostic*, i64 }* %t71, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t74 = load i64, i64* %l2
  %t75 = add i64 %t74, 1
  store i64 %t75, i64* %l2
  br label %for0
afterfor3:
  %t76 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t77 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t78 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t79 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t78, 0
  %t80 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t81 = insertvalue %ScopeResult %t79, { %Diagnostic*, i64 }* %t80, 1
  ret %ScopeResult %t81
}

define { %Diagnostic*, i64 }* @check_block(%Block %block, { %SymbolEntry*, i64 }* %parent_bindings, { %Statement*, i64 }* %interfaces) {
block.entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %Statement
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
  %t14 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t13, i32 0, i32 1
  %t15 = load i64, i64* %t14
  %t16 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t13, i32 0, i32 0
  %t17 = load %Statement*, %Statement** %t16
  store i64 0, i64* %l2
  store %Statement zeroinitializer, %Statement* %l3
  br label %for0
for0:
  %t18 = load i64, i64* %l2
  %t19 = icmp slt i64 %t18, %t15
  br i1 %t19, label %forbody1, label %afterfor3
forbody1:
  %t20 = load i64, i64* %l2
  %t21 = getelementptr %Statement, %Statement* %t17, i64 %t20
  %t22 = load %Statement, %Statement* %t21
  store %Statement %t22, %Statement* %l3
  %t23 = load %Statement, %Statement* %l3
  %t24 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t25 = call %ScopeResult @check_statement(%Statement %t23, { %SymbolEntry*, i64 }* %t24, { %Statement*, i64 }* %interfaces)
  store %ScopeResult %t25, %ScopeResult* %l4
  %t26 = load %ScopeResult, %ScopeResult* %l4
  %t27 = extractvalue %ScopeResult %t26, 0
  store { %SymbolEntry*, i64 }* %t27, { %SymbolEntry*, i64 }** %l0
  %t28 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t29 = load %ScopeResult, %ScopeResult* %l4
  %t30 = extractvalue %ScopeResult %t29, 1
  %t31 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t28, i32 0, i32 0
  %t32 = load %Diagnostic*, %Diagnostic** %t31
  %t33 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t28, i32 0, i32 1
  %t34 = load i64, i64* %t33
  %t35 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t30, i32 0, i32 0
  %t36 = load %Diagnostic*, %Diagnostic** %t35
  %t37 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t30, i32 0, i32 1
  %t38 = load i64, i64* %t37
  %t39 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t40 = ptrtoint %Diagnostic* %t39 to i64
  %t41 = add i64 %t34, %t38
  %t42 = mul i64 %t40, %t41
  %t43 = call noalias i8* @malloc(i64 %t42)
  %t44 = bitcast i8* %t43 to %Diagnostic*
  %t45 = bitcast %Diagnostic* %t44 to i8*
  %t46 = mul i64 %t40, %t34
  %t47 = bitcast %Diagnostic* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t45, i8* %t47, i64 %t46)
  %t48 = mul i64 %t40, %t38
  %t49 = bitcast %Diagnostic* %t36 to i8*
  %t50 = getelementptr %Diagnostic, %Diagnostic* %t44, i64 %t34
  %t51 = bitcast %Diagnostic* %t50 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t51, i8* %t49, i64 %t48)
  %t52 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t53 = ptrtoint { %Diagnostic*, i64 }* %t52 to i64
  %t54 = call i8* @malloc(i64 %t53)
  %t55 = bitcast i8* %t54 to { %Diagnostic*, i64 }*
  %t56 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t55, i32 0, i32 0
  store %Diagnostic* %t44, %Diagnostic** %t56
  %t57 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t55, i32 0, i32 1
  store i64 %t41, i64* %t57
  store { %Diagnostic*, i64 }* %t55, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t58 = load i64, i64* %l2
  %t59 = add i64 %t58, 1
  store i64 %t59, i64* %l2
  br label %for0
afterfor3:
  %t60 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t61 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t62 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t62
}

define { %Diagnostic*, i64 }* @check_struct_implements_interfaces(%Statement %statement, { %Statement*, i64 }* %interfaces) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i64
  %l2 = alloca %MethodDeclaration
  %l3 = alloca { %Diagnostic*, i64 }*
  %l4 = alloca i64
  %l5 = alloca %TypeAnnotation
  %l6 = alloca %Statement*
  %l7 = alloca i8*
  %l8 = alloca i64
  %l9 = alloca %FunctionSignature
  %t0 = extractvalue %Statement %statement, 0
  %t1 = alloca %Statement
  store %Statement %statement, %Statement* %t1
  %t2 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t3 = bitcast [56 x i8]* %t2 to i8*
  %t4 = getelementptr inbounds i8, i8* %t3, i64 24
  %t5 = bitcast i8* %t4 to { %TypeAnnotation*, i64 }**
  %t6 = load { %TypeAnnotation*, i64 }*, { %TypeAnnotation*, i64 }** %t5
  %t7 = icmp eq i32 %t0, 8
  %t8 = select i1 %t7, { %TypeAnnotation*, i64 }* %t6, { %TypeAnnotation*, i64 }* null
  %t9 = load { %TypeAnnotation*, i64 }, { %TypeAnnotation*, i64 }* %t8
  %t10 = extractvalue { %TypeAnnotation*, i64 } %t9, 1
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
  %t41 = bitcast i8* %t40 to { %MethodDeclaration*, i64 }**
  %t42 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t41
  %t43 = icmp eq i32 %t36, 8
  %t44 = select i1 %t43, { %MethodDeclaration*, i64 }* %t42, { %MethodDeclaration*, i64 }* null
  %t45 = getelementptr { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t44, i32 0, i32 1
  %t46 = load i64, i64* %t45
  %t47 = getelementptr { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t44, i32 0, i32 0
  %t48 = load %MethodDeclaration*, %MethodDeclaration** %t47
  store i64 0, i64* %l1
  store %MethodDeclaration zeroinitializer, %MethodDeclaration* %l2
  br label %for2
for2:
  %t49 = load i64, i64* %l1
  %t50 = icmp slt i64 %t49, %t46
  br i1 %t50, label %forbody3, label %afterfor5
forbody3:
  %t51 = load i64, i64* %l1
  %t52 = getelementptr %MethodDeclaration, %MethodDeclaration* %t48, i64 %t51
  %t53 = load %MethodDeclaration, %MethodDeclaration* %t52
  store %MethodDeclaration %t53, %MethodDeclaration* %l2
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load %MethodDeclaration, %MethodDeclaration* %l2
  %t56 = extractvalue %MethodDeclaration %t55, 0
  %t57 = extractvalue %FunctionSignature %t56, 0
  %t58 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t59 = ptrtoint [1 x i8*]* %t58 to i64
  %t60 = icmp eq i64 %t59, 0
  %t61 = select i1 %t60, i64 1, i64 %t59
  %t62 = call i8* @malloc(i64 %t61)
  %t63 = bitcast i8* %t62 to i8**
  %t64 = getelementptr i8*, i8** %t63, i64 0
  store i8* %t57, i8** %t64
  %t65 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t66 = ptrtoint { i8**, i64 }* %t65 to i64
  %t67 = call i8* @malloc(i64 %t66)
  %t68 = bitcast i8* %t67 to { i8**, i64 }*
  %t69 = getelementptr { i8**, i64 }, { i8**, i64 }* %t68, i32 0, i32 0
  store i8** %t63, i8*** %t69
  %t70 = getelementptr { i8**, i64 }, { i8**, i64 }* %t68, i32 0, i32 1
  store i64 1, i64* %t70
  %t71 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t54, { i8**, i64 }* %t68)
  store { i8**, i64 }* %t71, { i8**, i64 }** %l0
  br label %forinc4
forinc4:
  %t72 = load i64, i64* %l1
  %t73 = add i64 %t72, 1
  store i64 %t73, i64* %l1
  br label %for2
afterfor5:
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t75 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t76 = ptrtoint [0 x %Diagnostic]* %t75 to i64
  %t77 = icmp eq i64 %t76, 0
  %t78 = select i1 %t77, i64 1, i64 %t76
  %t79 = call i8* @malloc(i64 %t78)
  %t80 = bitcast i8* %t79 to %Diagnostic*
  %t81 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t82 = ptrtoint { %Diagnostic*, i64 }* %t81 to i64
  %t83 = call i8* @malloc(i64 %t82)
  %t84 = bitcast i8* %t83 to { %Diagnostic*, i64 }*
  %t85 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t84, i32 0, i32 0
  store %Diagnostic* %t80, %Diagnostic** %t85
  %t86 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t84, i32 0, i32 1
  store i64 0, i64* %t86
  store { %Diagnostic*, i64 }* %t84, { %Diagnostic*, i64 }** %l3
  %t87 = extractvalue %Statement %statement, 0
  %t88 = alloca %Statement
  store %Statement %statement, %Statement* %t88
  %t89 = getelementptr inbounds %Statement, %Statement* %t88, i32 0, i32 1
  %t90 = bitcast [56 x i8]* %t89 to i8*
  %t91 = getelementptr inbounds i8, i8* %t90, i64 24
  %t92 = bitcast i8* %t91 to { %TypeAnnotation*, i64 }**
  %t93 = load { %TypeAnnotation*, i64 }*, { %TypeAnnotation*, i64 }** %t92
  %t94 = icmp eq i32 %t87, 8
  %t95 = select i1 %t94, { %TypeAnnotation*, i64 }* %t93, { %TypeAnnotation*, i64 }* null
  %t96 = getelementptr { %TypeAnnotation*, i64 }, { %TypeAnnotation*, i64 }* %t95, i32 0, i32 1
  %t97 = load i64, i64* %t96
  %t98 = getelementptr { %TypeAnnotation*, i64 }, { %TypeAnnotation*, i64 }* %t95, i32 0, i32 0
  %t99 = load %TypeAnnotation*, %TypeAnnotation** %t98
  store i64 0, i64* %l4
  store %TypeAnnotation zeroinitializer, %TypeAnnotation* %l5
  br label %for6
for6:
  %t100 = load i64, i64* %l4
  %t101 = icmp slt i64 %t100, %t97
  br i1 %t101, label %forbody7, label %afterfor9
forbody7:
  %t102 = load i64, i64* %l4
  %t103 = getelementptr %TypeAnnotation, %TypeAnnotation* %t99, i64 %t102
  %t104 = load %TypeAnnotation, %TypeAnnotation* %t103
  store %TypeAnnotation %t104, %TypeAnnotation* %l5
  %t105 = load %TypeAnnotation, %TypeAnnotation* %l5
  %t106 = call %Statement* @resolve_interface_annotation(%TypeAnnotation %t105, { %Statement*, i64 }* %interfaces)
  store %Statement* %t106, %Statement** %l6
  %t107 = load %Statement*, %Statement** %l6
  %t108 = icmp eq %Statement* %t107, null
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t110 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  %t111 = load %TypeAnnotation, %TypeAnnotation* %l5
  %t112 = load %Statement*, %Statement** %l6
  br i1 %t108, label %then10, label %merge11
then10:
  br label %forinc8
merge11:
  %t113 = load %Statement*, %Statement** %l6
  %t114 = getelementptr inbounds %Statement, %Statement* %t113, i32 0, i32 0
  %t115 = load i32, i32* %t114
  %t116 = getelementptr inbounds %Statement, %Statement* %t113, i32 0, i32 1
  %t117 = bitcast [48 x i8]* %t116 to i8*
  %t118 = bitcast i8* %t117 to i8**
  %t119 = load i8*, i8** %t118
  %t120 = icmp eq i32 %t115, 2
  %t121 = select i1 %t120, i8* %t119, i8* null
  %t122 = getelementptr inbounds %Statement, %Statement* %t113, i32 0, i32 1
  %t123 = bitcast [48 x i8]* %t122 to i8*
  %t124 = bitcast i8* %t123 to i8**
  %t125 = load i8*, i8** %t124
  %t126 = icmp eq i32 %t115, 3
  %t127 = select i1 %t126, i8* %t125, i8* %t121
  %t128 = getelementptr inbounds %Statement, %Statement* %t113, i32 0, i32 1
  %t129 = bitcast [56 x i8]* %t128 to i8*
  %t130 = bitcast i8* %t129 to i8**
  %t131 = load i8*, i8** %t130
  %t132 = icmp eq i32 %t115, 6
  %t133 = select i1 %t132, i8* %t131, i8* %t127
  %t134 = getelementptr inbounds %Statement, %Statement* %t113, i32 0, i32 1
  %t135 = bitcast [56 x i8]* %t134 to i8*
  %t136 = bitcast i8* %t135 to i8**
  %t137 = load i8*, i8** %t136
  %t138 = icmp eq i32 %t115, 8
  %t139 = select i1 %t138, i8* %t137, i8* %t133
  %t140 = getelementptr inbounds %Statement, %Statement* %t113, i32 0, i32 1
  %t141 = bitcast [40 x i8]* %t140 to i8*
  %t142 = bitcast i8* %t141 to i8**
  %t143 = load i8*, i8** %t142
  %t144 = icmp eq i32 %t115, 9
  %t145 = select i1 %t144, i8* %t143, i8* %t139
  %t146 = getelementptr inbounds %Statement, %Statement* %t113, i32 0, i32 1
  %t147 = bitcast [40 x i8]* %t146 to i8*
  %t148 = bitcast i8* %t147 to i8**
  %t149 = load i8*, i8** %t148
  %t150 = icmp eq i32 %t115, 10
  %t151 = select i1 %t150, i8* %t149, i8* %t145
  %t152 = getelementptr inbounds %Statement, %Statement* %t113, i32 0, i32 1
  %t153 = bitcast [40 x i8]* %t152 to i8*
  %t154 = bitcast i8* %t153 to i8**
  %t155 = load i8*, i8** %t154
  %t156 = icmp eq i32 %t115, 11
  %t157 = select i1 %t156, i8* %t155, i8* %t151
  store i8* %t157, i8** %l7
  %t158 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  %t159 = extractvalue %Statement %statement, 0
  %t160 = alloca %Statement
  store %Statement %statement, %Statement* %t160
  %t161 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t162 = bitcast [48 x i8]* %t161 to i8*
  %t163 = bitcast i8* %t162 to i8**
  %t164 = load i8*, i8** %t163
  %t165 = icmp eq i32 %t159, 2
  %t166 = select i1 %t165, i8* %t164, i8* null
  %t167 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t168 = bitcast [48 x i8]* %t167 to i8*
  %t169 = bitcast i8* %t168 to i8**
  %t170 = load i8*, i8** %t169
  %t171 = icmp eq i32 %t159, 3
  %t172 = select i1 %t171, i8* %t170, i8* %t166
  %t173 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t174 = bitcast [56 x i8]* %t173 to i8*
  %t175 = bitcast i8* %t174 to i8**
  %t176 = load i8*, i8** %t175
  %t177 = icmp eq i32 %t159, 6
  %t178 = select i1 %t177, i8* %t176, i8* %t172
  %t179 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t180 = bitcast [56 x i8]* %t179 to i8*
  %t181 = bitcast i8* %t180 to i8**
  %t182 = load i8*, i8** %t181
  %t183 = icmp eq i32 %t159, 8
  %t184 = select i1 %t183, i8* %t182, i8* %t178
  %t185 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t186 = bitcast [40 x i8]* %t185 to i8*
  %t187 = bitcast i8* %t186 to i8**
  %t188 = load i8*, i8** %t187
  %t189 = icmp eq i32 %t159, 9
  %t190 = select i1 %t189, i8* %t188, i8* %t184
  %t191 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t192 = bitcast [40 x i8]* %t191 to i8*
  %t193 = bitcast i8* %t192 to i8**
  %t194 = load i8*, i8** %t193
  %t195 = icmp eq i32 %t159, 10
  %t196 = select i1 %t195, i8* %t194, i8* %t190
  %t197 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t198 = bitcast [40 x i8]* %t197 to i8*
  %t199 = bitcast i8* %t198 to i8**
  %t200 = load i8*, i8** %t199
  %t201 = icmp eq i32 %t159, 11
  %t202 = select i1 %t201, i8* %t200, i8* %t196
  %t203 = load %Statement*, %Statement** %l6
  %t204 = load %TypeAnnotation, %TypeAnnotation* %l5
  %t205 = load %Statement, %Statement* %t203
  %t206 = call { %Diagnostic*, i64 }* @validate_interface_annotation(i8* %t202, %Statement %t205, %TypeAnnotation %t204)
  %t207 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t158, i32 0, i32 0
  %t208 = load %Diagnostic*, %Diagnostic** %t207
  %t209 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t158, i32 0, i32 1
  %t210 = load i64, i64* %t209
  %t211 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t206, i32 0, i32 0
  %t212 = load %Diagnostic*, %Diagnostic** %t211
  %t213 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t206, i32 0, i32 1
  %t214 = load i64, i64* %t213
  %t215 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t216 = ptrtoint %Diagnostic* %t215 to i64
  %t217 = add i64 %t210, %t214
  %t218 = mul i64 %t216, %t217
  %t219 = call noalias i8* @malloc(i64 %t218)
  %t220 = bitcast i8* %t219 to %Diagnostic*
  %t221 = bitcast %Diagnostic* %t220 to i8*
  %t222 = mul i64 %t216, %t210
  %t223 = bitcast %Diagnostic* %t208 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t221, i8* %t223, i64 %t222)
  %t224 = mul i64 %t216, %t214
  %t225 = bitcast %Diagnostic* %t212 to i8*
  %t226 = getelementptr %Diagnostic, %Diagnostic* %t220, i64 %t210
  %t227 = bitcast %Diagnostic* %t226 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t227, i8* %t225, i64 %t224)
  %t228 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t229 = ptrtoint { %Diagnostic*, i64 }* %t228 to i64
  %t230 = call i8* @malloc(i64 %t229)
  %t231 = bitcast i8* %t230 to { %Diagnostic*, i64 }*
  %t232 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t231, i32 0, i32 0
  store %Diagnostic* %t220, %Diagnostic** %t232
  %t233 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t231, i32 0, i32 1
  store i64 %t217, i64* %t233
  store { %Diagnostic*, i64 }* %t231, { %Diagnostic*, i64 }** %l3
  %t234 = load %Statement*, %Statement** %l6
  %t235 = getelementptr inbounds %Statement, %Statement* %t234, i32 0, i32 0
  %t236 = load i32, i32* %t235
  %t237 = getelementptr inbounds %Statement, %Statement* %t234, i32 0, i32 1
  %t238 = bitcast [40 x i8]* %t237 to i8*
  %t239 = getelementptr inbounds i8, i8* %t238, i64 24
  %t240 = bitcast i8* %t239 to { %FunctionSignature*, i64 }**
  %t241 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %t240
  %t242 = icmp eq i32 %t236, 10
  %t243 = select i1 %t242, { %FunctionSignature*, i64 }* %t241, { %FunctionSignature*, i64 }* null
  %t244 = getelementptr { %FunctionSignature*, i64 }, { %FunctionSignature*, i64 }* %t243, i32 0, i32 1
  %t245 = load i64, i64* %t244
  %t246 = getelementptr { %FunctionSignature*, i64 }, { %FunctionSignature*, i64 }* %t243, i32 0, i32 0
  %t247 = load %FunctionSignature*, %FunctionSignature** %t246
  store i64 0, i64* %l8
  store %FunctionSignature zeroinitializer, %FunctionSignature* %l9
  br label %for12
for12:
  %t248 = load i64, i64* %l8
  %t249 = icmp slt i64 %t248, %t245
  br i1 %t249, label %forbody13, label %afterfor15
forbody13:
  %t250 = load i64, i64* %l8
  %t251 = getelementptr %FunctionSignature, %FunctionSignature* %t247, i64 %t250
  %t252 = load %FunctionSignature, %FunctionSignature* %t251
  store %FunctionSignature %t252, %FunctionSignature* %l9
  %t253 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t254 = load %FunctionSignature, %FunctionSignature* %l9
  %t255 = extractvalue %FunctionSignature %t254, 0
  %t256 = call i1 @contains_string({ i8**, i64 }* %t253, i8* %t255)
  %t257 = xor i1 %t256, 1
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t259 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  %t260 = load %TypeAnnotation, %TypeAnnotation* %l5
  %t261 = load %Statement*, %Statement** %l6
  %t262 = load i8*, i8** %l7
  %t263 = load %FunctionSignature, %FunctionSignature* %l9
  br i1 %t257, label %then16, label %merge17
then16:
  %t264 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  %t265 = extractvalue %Statement %statement, 0
  %t266 = alloca %Statement
  store %Statement %statement, %Statement* %t266
  %t267 = getelementptr inbounds %Statement, %Statement* %t266, i32 0, i32 1
  %t268 = bitcast [48 x i8]* %t267 to i8*
  %t269 = bitcast i8* %t268 to i8**
  %t270 = load i8*, i8** %t269
  %t271 = icmp eq i32 %t265, 2
  %t272 = select i1 %t271, i8* %t270, i8* null
  %t273 = getelementptr inbounds %Statement, %Statement* %t266, i32 0, i32 1
  %t274 = bitcast [48 x i8]* %t273 to i8*
  %t275 = bitcast i8* %t274 to i8**
  %t276 = load i8*, i8** %t275
  %t277 = icmp eq i32 %t265, 3
  %t278 = select i1 %t277, i8* %t276, i8* %t272
  %t279 = getelementptr inbounds %Statement, %Statement* %t266, i32 0, i32 1
  %t280 = bitcast [56 x i8]* %t279 to i8*
  %t281 = bitcast i8* %t280 to i8**
  %t282 = load i8*, i8** %t281
  %t283 = icmp eq i32 %t265, 6
  %t284 = select i1 %t283, i8* %t282, i8* %t278
  %t285 = getelementptr inbounds %Statement, %Statement* %t266, i32 0, i32 1
  %t286 = bitcast [56 x i8]* %t285 to i8*
  %t287 = bitcast i8* %t286 to i8**
  %t288 = load i8*, i8** %t287
  %t289 = icmp eq i32 %t265, 8
  %t290 = select i1 %t289, i8* %t288, i8* %t284
  %t291 = getelementptr inbounds %Statement, %Statement* %t266, i32 0, i32 1
  %t292 = bitcast [40 x i8]* %t291 to i8*
  %t293 = bitcast i8* %t292 to i8**
  %t294 = load i8*, i8** %t293
  %t295 = icmp eq i32 %t265, 9
  %t296 = select i1 %t295, i8* %t294, i8* %t290
  %t297 = getelementptr inbounds %Statement, %Statement* %t266, i32 0, i32 1
  %t298 = bitcast [40 x i8]* %t297 to i8*
  %t299 = bitcast i8* %t298 to i8**
  %t300 = load i8*, i8** %t299
  %t301 = icmp eq i32 %t265, 10
  %t302 = select i1 %t301, i8* %t300, i8* %t296
  %t303 = getelementptr inbounds %Statement, %Statement* %t266, i32 0, i32 1
  %t304 = bitcast [40 x i8]* %t303 to i8*
  %t305 = bitcast i8* %t304 to i8**
  %t306 = load i8*, i8** %t305
  %t307 = icmp eq i32 %t265, 11
  %t308 = select i1 %t307, i8* %t306, i8* %t302
  %t309 = load i8*, i8** %l7
  %t310 = load %FunctionSignature, %FunctionSignature* %l9
  %t311 = extractvalue %FunctionSignature %t310, 0
  %t312 = call %Diagnostic @make_missing_interface_member_diagnostic(i8* %t308, i8* %t309, i8* %t311)
  %t313 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 1
  %t314 = ptrtoint [1 x %Diagnostic]* %t313 to i64
  %t315 = icmp eq i64 %t314, 0
  %t316 = select i1 %t315, i64 1, i64 %t314
  %t317 = call i8* @malloc(i64 %t316)
  %t318 = bitcast i8* %t317 to %Diagnostic*
  %t319 = getelementptr %Diagnostic, %Diagnostic* %t318, i64 0
  store %Diagnostic %t312, %Diagnostic* %t319
  %t320 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t321 = ptrtoint { %Diagnostic*, i64 }* %t320 to i64
  %t322 = call i8* @malloc(i64 %t321)
  %t323 = bitcast i8* %t322 to { %Diagnostic*, i64 }*
  %t324 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t323, i32 0, i32 0
  store %Diagnostic* %t318, %Diagnostic** %t324
  %t325 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t323, i32 0, i32 1
  store i64 1, i64* %t325
  %t326 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t264, i32 0, i32 0
  %t327 = load %Diagnostic*, %Diagnostic** %t326
  %t328 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t264, i32 0, i32 1
  %t329 = load i64, i64* %t328
  %t330 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t323, i32 0, i32 0
  %t331 = load %Diagnostic*, %Diagnostic** %t330
  %t332 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t323, i32 0, i32 1
  %t333 = load i64, i64* %t332
  %t334 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t335 = ptrtoint %Diagnostic* %t334 to i64
  %t336 = add i64 %t329, %t333
  %t337 = mul i64 %t335, %t336
  %t338 = call noalias i8* @malloc(i64 %t337)
  %t339 = bitcast i8* %t338 to %Diagnostic*
  %t340 = bitcast %Diagnostic* %t339 to i8*
  %t341 = mul i64 %t335, %t329
  %t342 = bitcast %Diagnostic* %t327 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t340, i8* %t342, i64 %t341)
  %t343 = mul i64 %t335, %t333
  %t344 = bitcast %Diagnostic* %t331 to i8*
  %t345 = getelementptr %Diagnostic, %Diagnostic* %t339, i64 %t329
  %t346 = bitcast %Diagnostic* %t345 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t346, i8* %t344, i64 %t343)
  %t347 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t348 = ptrtoint { %Diagnostic*, i64 }* %t347 to i64
  %t349 = call i8* @malloc(i64 %t348)
  %t350 = bitcast i8* %t349 to { %Diagnostic*, i64 }*
  %t351 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t350, i32 0, i32 0
  store %Diagnostic* %t339, %Diagnostic** %t351
  %t352 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t350, i32 0, i32 1
  store i64 %t336, i64* %t352
  store { %Diagnostic*, i64 }* %t350, { %Diagnostic*, i64 }** %l3
  %t353 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  br label %merge17
merge17:
  %t354 = phi { %Diagnostic*, i64 }* [ %t353, %then16 ], [ %t259, %forbody13 ]
  store { %Diagnostic*, i64 }* %t354, { %Diagnostic*, i64 }** %l3
  br label %forinc14
forinc14:
  %t355 = load i64, i64* %l8
  %t356 = add i64 %t355, 1
  store i64 %t356, i64* %l8
  br label %for12
afterfor15:
  %t357 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  br label %forinc8
forinc8:
  %t358 = load i64, i64* %l4
  %t359 = add i64 %t358, 1
  store i64 %t359, i64* %l4
  br label %for6
afterfor9:
  %t360 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  %t361 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l3
  ret { %Diagnostic*, i64 }* %t361
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
  %t26 = bitcast [56 x i8]* %t25 to i8*
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
  %t62 = getelementptr %Statement, %Statement* null, i32 1
  %t63 = ptrtoint %Statement* %t62 to i64
  %t64 = call noalias i8* @malloc(i64 %t63)
  %t65 = bitcast i8* %t64 to %Statement*
  store %Statement %t61, %Statement* %t65
  call void @sailfin_runtime_mark_persistent(i8* %t64)
  ret %Statement* %t65
merge5:
  %t66 = load i8*, i8** %l3
  %t67 = add i64 0, 2
  %t68 = call i8* @malloc(i64 %t67)
  store i8 60, i8* %t68
  %t69 = getelementptr i8, i8* %t68, i64 1
  store i8 0, i8* %t69
  call void @sailfin_runtime_mark_persistent(i8* %t68)
  %t70 = call i8* @sailfin_runtime_string_concat(i8* %t66, i8* %t68)
  store i8* %t70, i8** %l4
  %t71 = load i8*, i8** %l0
  %t72 = load i8*, i8** %l4
  %t73 = call i1 @starts_with(i8* %t71, i8* %t72)
  %t74 = load i8*, i8** %l0
  %t75 = load %Statement, %Statement* %l2
  %t76 = load i8*, i8** %l3
  %t77 = load i8*, i8** %l4
  br i1 %t73, label %then6, label %merge7
then6:
  %t78 = load %Statement, %Statement* %l2
  %t79 = getelementptr %Statement, %Statement* null, i32 1
  %t80 = ptrtoint %Statement* %t79 to i64
  %t81 = call noalias i8* @malloc(i64 %t80)
  %t82 = bitcast i8* %t81 to %Statement*
  store %Statement %t78, %Statement* %t82
  call void @sailfin_runtime_mark_persistent(i8* %t81)
  ret %Statement* %t82
merge7:
  br label %forinc2
forinc2:
  %t83 = load i64, i64* %l1
  %t84 = add i64 %t83, 1
  store i64 %t84, i64* %l1
  br label %for0
afterfor3:
  %t85 = bitcast i8* null to %Statement*
  ret %Statement* %t85
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
  %t44 = call i8* @malloc(i64 13)
  %t45 = bitcast i8* %t44 to [13 x i8]*
  store [13 x i8] c"struct field\00", [13 x i8]* %t45
  %t46 = load i8*, i8** %l4
  %t47 = load %FieldDeclaration, %FieldDeclaration* %l3
  %t48 = extractvalue %FieldDeclaration %t47, 3
  %t49 = call %Token* @token_from_name(i8* %t46, %SourceSpan* %t48)
  %t50 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t43, i8* %t44, %Token* %t49)
  %t51 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 1
  %t52 = ptrtoint [1 x %Diagnostic]* %t51 to i64
  %t53 = icmp eq i64 %t52, 0
  %t54 = select i1 %t53, i64 1, i64 %t52
  %t55 = call i8* @malloc(i64 %t54)
  %t56 = bitcast i8* %t55 to %Diagnostic*
  %t57 = getelementptr %Diagnostic, %Diagnostic* %t56, i64 0
  store %Diagnostic %t50, %Diagnostic* %t57
  %t58 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t59 = ptrtoint { %Diagnostic*, i64 }* %t58 to i64
  %t60 = call i8* @malloc(i64 %t59)
  %t61 = bitcast i8* %t60 to { %Diagnostic*, i64 }*
  %t62 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t61, i32 0, i32 0
  store %Diagnostic* %t56, %Diagnostic** %t62
  %t63 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t61, i32 0, i32 1
  store i64 1, i64* %t63
  %t64 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t42, i32 0, i32 0
  %t65 = load %Diagnostic*, %Diagnostic** %t64
  %t66 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t42, i32 0, i32 1
  %t67 = load i64, i64* %t66
  %t68 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t61, i32 0, i32 0
  %t69 = load %Diagnostic*, %Diagnostic** %t68
  %t70 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t61, i32 0, i32 1
  %t71 = load i64, i64* %t70
  %t72 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t73 = ptrtoint %Diagnostic* %t72 to i64
  %t74 = add i64 %t67, %t71
  %t75 = mul i64 %t73, %t74
  %t76 = call noalias i8* @malloc(i64 %t75)
  %t77 = bitcast i8* %t76 to %Diagnostic*
  %t78 = bitcast %Diagnostic* %t77 to i8*
  %t79 = mul i64 %t73, %t67
  %t80 = bitcast %Diagnostic* %t65 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t78, i8* %t80, i64 %t79)
  %t81 = mul i64 %t73, %t71
  %t82 = bitcast %Diagnostic* %t69 to i8*
  %t83 = getelementptr %Diagnostic, %Diagnostic* %t77, i64 %t67
  %t84 = bitcast %Diagnostic* %t83 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t84, i8* %t82, i64 %t81)
  %t85 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t86 = ptrtoint { %Diagnostic*, i64 }* %t85 to i64
  %t87 = call i8* @malloc(i64 %t86)
  %t88 = bitcast i8* %t87 to { %Diagnostic*, i64 }*
  %t89 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t88, i32 0, i32 0
  store %Diagnostic* %t77, %Diagnostic** %t89
  %t90 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t88, i32 0, i32 1
  store i64 %t74, i64* %t90
  store { %Diagnostic*, i64 }* %t88, { %Diagnostic*, i64 }** %l1
  %t91 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t93 = load i8*, i8** %l4
  %t94 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t95 = ptrtoint [1 x i8*]* %t94 to i64
  %t96 = icmp eq i64 %t95, 0
  %t97 = select i1 %t96, i64 1, i64 %t95
  %t98 = call i8* @malloc(i64 %t97)
  %t99 = bitcast i8* %t98 to i8**
  %t100 = getelementptr i8*, i8** %t99, i64 0
  store i8* %t93, i8** %t100
  %t101 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t102 = ptrtoint { i8**, i64 }* %t101 to i64
  %t103 = call i8* @malloc(i64 %t102)
  %t104 = bitcast i8* %t103 to { i8**, i64 }*
  %t105 = getelementptr { i8**, i64 }, { i8**, i64 }* %t104, i32 0, i32 0
  store i8** %t99, i8*** %t105
  %t106 = getelementptr { i8**, i64 }, { i8**, i64 }* %t104, i32 0, i32 1
  store i64 1, i64* %t106
  %t107 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t92, { i8**, i64 }* %t104)
  store { i8**, i64 }* %t107, { i8**, i64 }** %l0
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t109 = phi { %Diagnostic*, i64 }* [ %t91, %then4 ], [ %t39, %else5 ]
  %t110 = phi { i8**, i64 }* [ %t38, %then4 ], [ %t108, %else5 ]
  store { %Diagnostic*, i64 }* %t109, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t110, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t111 = load i64, i64* %l2
  %t112 = add i64 %t111, 1
  store i64 %t112, i64* %l2
  br label %for0
afterfor3:
  %t113 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t115 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t115
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
  %t5 = bitcast i8* %t4 to { %TypeParameter*, i64 }**
  %t6 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t5
  %t7 = icmp eq i32 %t0, 8
  %t8 = select i1 %t7, { %TypeParameter*, i64 }* %t6, { %TypeParameter*, i64 }* null
  %t9 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t10 = bitcast [40 x i8]* %t9 to i8*
  %t11 = getelementptr inbounds i8, i8* %t10, i64 16
  %t12 = bitcast i8* %t11 to { %TypeParameter*, i64 }**
  %t13 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t12
  %t14 = icmp eq i32 %t0, 9
  %t15 = select i1 %t14, { %TypeParameter*, i64 }* %t13, { %TypeParameter*, i64 }* %t8
  %t16 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t17 = bitcast [40 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 16
  %t19 = bitcast i8* %t18 to { %TypeParameter*, i64 }**
  %t20 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t19
  %t21 = icmp eq i32 %t0, 10
  %t22 = select i1 %t21, { %TypeParameter*, i64 }* %t20, { %TypeParameter*, i64 }* %t15
  %t23 = getelementptr inbounds %Statement, %Statement* %t1, i32 0, i32 1
  %t24 = bitcast [40 x i8]* %t23 to i8*
  %t25 = getelementptr inbounds i8, i8* %t24, i64 16
  %t26 = bitcast i8* %t25 to { %TypeParameter*, i64 }**
  %t27 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t26
  %t28 = icmp eq i32 %t0, 11
  %t29 = select i1 %t28, { %TypeParameter*, i64 }* %t27, { %TypeParameter*, i64 }* %t22
  %t30 = load { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %t29
  %t31 = extractvalue { %TypeParameter*, i64 } %t30, 1
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
  %t61 = bitcast [56 x i8]* %t60 to i8*
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
  %t137 = bitcast [56 x i8]* %t136 to i8*
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
  %l2 = alloca %TypeParameter
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
  %t17 = bitcast i8* %t16 to { %TypeParameter*, i64 }**
  %t18 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t17
  %t19 = icmp eq i32 %t12, 8
  %t20 = select i1 %t19, { %TypeParameter*, i64 }* %t18, { %TypeParameter*, i64 }* null
  %t21 = getelementptr inbounds %Statement, %Statement* %t13, i32 0, i32 1
  %t22 = bitcast [40 x i8]* %t21 to i8*
  %t23 = getelementptr inbounds i8, i8* %t22, i64 16
  %t24 = bitcast i8* %t23 to { %TypeParameter*, i64 }**
  %t25 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t24
  %t26 = icmp eq i32 %t12, 9
  %t27 = select i1 %t26, { %TypeParameter*, i64 }* %t25, { %TypeParameter*, i64 }* %t20
  %t28 = getelementptr inbounds %Statement, %Statement* %t13, i32 0, i32 1
  %t29 = bitcast [40 x i8]* %t28 to i8*
  %t30 = getelementptr inbounds i8, i8* %t29, i64 16
  %t31 = bitcast i8* %t30 to { %TypeParameter*, i64 }**
  %t32 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t31
  %t33 = icmp eq i32 %t12, 10
  %t34 = select i1 %t33, { %TypeParameter*, i64 }* %t32, { %TypeParameter*, i64 }* %t27
  %t35 = getelementptr inbounds %Statement, %Statement* %t13, i32 0, i32 1
  %t36 = bitcast [40 x i8]* %t35 to i8*
  %t37 = getelementptr inbounds i8, i8* %t36, i64 16
  %t38 = bitcast i8* %t37 to { %TypeParameter*, i64 }**
  %t39 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t38
  %t40 = icmp eq i32 %t12, 11
  %t41 = select i1 %t40, { %TypeParameter*, i64 }* %t39, { %TypeParameter*, i64 }* %t34
  %t42 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %t41, i32 0, i32 1
  %t43 = load i64, i64* %t42
  %t44 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %t41, i32 0, i32 0
  %t45 = load %TypeParameter*, %TypeParameter** %t44
  store i64 0, i64* %l1
  store %TypeParameter zeroinitializer, %TypeParameter* %l2
  br label %for0
for0:
  %t46 = load i64, i64* %l1
  %t47 = icmp slt i64 %t46, %t43
  br i1 %t47, label %forbody1, label %afterfor3
forbody1:
  %t48 = load i64, i64* %l1
  %t49 = getelementptr %TypeParameter, %TypeParameter* %t45, i64 %t48
  %t50 = load %TypeParameter, %TypeParameter* %t49
  store %TypeParameter %t50, %TypeParameter* %l2
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load %TypeParameter, %TypeParameter* %l2
  %t53 = extractvalue %TypeParameter %t52, 0
  %t54 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t55 = ptrtoint [1 x i8*]* %t54 to i64
  %t56 = icmp eq i64 %t55, 0
  %t57 = select i1 %t56, i64 1, i64 %t55
  %t58 = call i8* @malloc(i64 %t57)
  %t59 = bitcast i8* %t58 to i8**
  %t60 = getelementptr i8*, i8** %t59, i64 0
  store i8* %t53, i8** %t60
  %t61 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t62 = ptrtoint { i8**, i64 }* %t61 to i64
  %t63 = call i8* @malloc(i64 %t62)
  %t64 = bitcast i8* %t63 to { i8**, i64 }*
  %t65 = getelementptr { i8**, i64 }, { i8**, i64 }* %t64, i32 0, i32 0
  store i8** %t59, i8*** %t65
  %t66 = getelementptr { i8**, i64 }, { i8**, i64 }* %t64, i32 0, i32 1
  store i64 1, i64* %t66
  %t67 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t51, { i8**, i64 }* %t64)
  store { i8**, i64 }* %t67, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t68 = load i64, i64* %l1
  %t69 = add i64 %t68, 1
  store i64 %t69, i64* %l1
  br label %for0
afterfor3:
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = load { i8**, i64 }, { i8**, i64 }* %t71
  %t73 = extractvalue { i8**, i64 } %t72, 1
  %t74 = icmp eq i64 %t73, 0
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br i1 %t74, label %then4, label %merge5
then4:
  %t76 = extractvalue %Statement %interface_definition, 0
  %t77 = alloca %Statement
  store %Statement %interface_definition, %Statement* %t77
  %t78 = getelementptr inbounds %Statement, %Statement* %t77, i32 0, i32 1
  %t79 = bitcast [48 x i8]* %t78 to i8*
  %t80 = bitcast i8* %t79 to i8**
  %t81 = load i8*, i8** %t80
  %t82 = icmp eq i32 %t76, 2
  %t83 = select i1 %t82, i8* %t81, i8* null
  %t84 = getelementptr inbounds %Statement, %Statement* %t77, i32 0, i32 1
  %t85 = bitcast [48 x i8]* %t84 to i8*
  %t86 = bitcast i8* %t85 to i8**
  %t87 = load i8*, i8** %t86
  %t88 = icmp eq i32 %t76, 3
  %t89 = select i1 %t88, i8* %t87, i8* %t83
  %t90 = getelementptr inbounds %Statement, %Statement* %t77, i32 0, i32 1
  %t91 = bitcast [56 x i8]* %t90 to i8*
  %t92 = bitcast i8* %t91 to i8**
  %t93 = load i8*, i8** %t92
  %t94 = icmp eq i32 %t76, 6
  %t95 = select i1 %t94, i8* %t93, i8* %t89
  %t96 = getelementptr inbounds %Statement, %Statement* %t77, i32 0, i32 1
  %t97 = bitcast [56 x i8]* %t96 to i8*
  %t98 = bitcast i8* %t97 to i8**
  %t99 = load i8*, i8** %t98
  %t100 = icmp eq i32 %t76, 8
  %t101 = select i1 %t100, i8* %t99, i8* %t95
  %t102 = getelementptr inbounds %Statement, %Statement* %t77, i32 0, i32 1
  %t103 = bitcast [40 x i8]* %t102 to i8*
  %t104 = bitcast i8* %t103 to i8**
  %t105 = load i8*, i8** %t104
  %t106 = icmp eq i32 %t76, 9
  %t107 = select i1 %t106, i8* %t105, i8* %t101
  %t108 = getelementptr inbounds %Statement, %Statement* %t77, i32 0, i32 1
  %t109 = bitcast [40 x i8]* %t108 to i8*
  %t110 = bitcast i8* %t109 to i8**
  %t111 = load i8*, i8** %t110
  %t112 = icmp eq i32 %t76, 10
  %t113 = select i1 %t112, i8* %t111, i8* %t107
  %t114 = getelementptr inbounds %Statement, %Statement* %t77, i32 0, i32 1
  %t115 = bitcast [40 x i8]* %t114 to i8*
  %t116 = bitcast i8* %t115 to i8**
  %t117 = load i8*, i8** %t116
  %t118 = icmp eq i32 %t76, 11
  %t119 = select i1 %t118, i8* %t117, i8* %t113
  call void @sailfin_runtime_mark_persistent(i8* %t119)
  ret i8* %t119
merge5:
  %t120 = extractvalue %Statement %interface_definition, 0
  %t121 = alloca %Statement
  store %Statement %interface_definition, %Statement* %t121
  %t122 = getelementptr inbounds %Statement, %Statement* %t121, i32 0, i32 1
  %t123 = bitcast [48 x i8]* %t122 to i8*
  %t124 = bitcast i8* %t123 to i8**
  %t125 = load i8*, i8** %t124
  %t126 = icmp eq i32 %t120, 2
  %t127 = select i1 %t126, i8* %t125, i8* null
  %t128 = getelementptr inbounds %Statement, %Statement* %t121, i32 0, i32 1
  %t129 = bitcast [48 x i8]* %t128 to i8*
  %t130 = bitcast i8* %t129 to i8**
  %t131 = load i8*, i8** %t130
  %t132 = icmp eq i32 %t120, 3
  %t133 = select i1 %t132, i8* %t131, i8* %t127
  %t134 = getelementptr inbounds %Statement, %Statement* %t121, i32 0, i32 1
  %t135 = bitcast [56 x i8]* %t134 to i8*
  %t136 = bitcast i8* %t135 to i8**
  %t137 = load i8*, i8** %t136
  %t138 = icmp eq i32 %t120, 6
  %t139 = select i1 %t138, i8* %t137, i8* %t133
  %t140 = getelementptr inbounds %Statement, %Statement* %t121, i32 0, i32 1
  %t141 = bitcast [56 x i8]* %t140 to i8*
  %t142 = bitcast i8* %t141 to i8**
  %t143 = load i8*, i8** %t142
  %t144 = icmp eq i32 %t120, 8
  %t145 = select i1 %t144, i8* %t143, i8* %t139
  %t146 = getelementptr inbounds %Statement, %Statement* %t121, i32 0, i32 1
  %t147 = bitcast [40 x i8]* %t146 to i8*
  %t148 = bitcast i8* %t147 to i8**
  %t149 = load i8*, i8** %t148
  %t150 = icmp eq i32 %t120, 9
  %t151 = select i1 %t150, i8* %t149, i8* %t145
  %t152 = getelementptr inbounds %Statement, %Statement* %t121, i32 0, i32 1
  %t153 = bitcast [40 x i8]* %t152 to i8*
  %t154 = bitcast i8* %t153 to i8**
  %t155 = load i8*, i8** %t154
  %t156 = icmp eq i32 %t120, 10
  %t157 = select i1 %t156, i8* %t155, i8* %t151
  %t158 = getelementptr inbounds %Statement, %Statement* %t121, i32 0, i32 1
  %t159 = bitcast [40 x i8]* %t158 to i8*
  %t160 = bitcast i8* %t159 to i8**
  %t161 = load i8*, i8** %t160
  %t162 = icmp eq i32 %t120, 11
  %t163 = select i1 %t162, i8* %t161, i8* %t157
  %t164 = add i64 0, 2
  %t165 = call i8* @malloc(i64 %t164)
  store i8 60, i8* %t165
  %t166 = getelementptr i8, i8* %t165, i64 1
  store i8 0, i8* %t166
  call void @sailfin_runtime_mark_persistent(i8* %t165)
  %t167 = call i8* @sailfin_runtime_string_concat(i8* %t163, i8* %t165)
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t169 = call i8* @malloc(i64 3)
  %t170 = bitcast i8* %t169 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t170
  %t171 = call i8* @join_with_separator({ i8**, i64 }* %t168, i8* %t169)
  %t172 = call i8* @sailfin_runtime_string_concat(i8* %t167, i8* %t171)
  %t173 = add i64 0, 2
  %t174 = call i8* @malloc(i64 %t173)
  store i8 62, i8* %t174
  %t175 = getelementptr i8, i8* %t174, i64 1
  store i8 0, i8* %t175
  call void @sailfin_runtime_mark_persistent(i8* %t174)
  %t176 = call i8* @sailfin_runtime_string_concat(i8* %t172, i8* %t174)
  call void @sailfin_runtime_mark_persistent(i8* %t176)
  ret i8* %t176
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
  %t3 = call i8* @malloc(i64 1)
  %t4 = bitcast i8* %t3 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t4
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  ret i8* %t3
merge1:
  %t5 = load { i8**, i64 }, { i8**, i64 }* %items
  %t6 = extractvalue { i8**, i64 } %t5, 0
  %t7 = extractvalue { i8**, i64 } %t5, 1
  %t8 = icmp uge i64 0, %t7
  ; bounds check: %t8 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t7)
  %t9 = getelementptr i8*, i8** %t6, i64 0
  %t10 = load i8*, i8** %t9
  store i8* %t10, i8** %l0
  %t11 = sitofp i64 1 to double
  store double %t11, double* %l1
  %t12 = load i8*, i8** %l0
  %t13 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t38 = phi i8* [ %t12, %merge1 ], [ %t36, %loop.latch4 ]
  %t39 = phi double [ %t13, %merge1 ], [ %t37, %loop.latch4 ]
  store i8* %t38, i8** %l0
  store double %t39, double* %l1
  br label %loop.body3
loop.body3:
  %t14 = load double, double* %l1
  %t15 = load { i8**, i64 }, { i8**, i64 }* %items
  %t16 = extractvalue { i8**, i64 } %t15, 1
  %t17 = sitofp i64 %t16 to double
  %t18 = fcmp oge double %t14, %t17
  %t19 = load i8*, i8** %l0
  %t20 = load double, double* %l1
  br i1 %t18, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t21 = load i8*, i8** %l0
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %t21, i8* %separator)
  %t23 = load double, double* %l1
  %t24 = call double @llvm.round.f64(double %t23)
  %t25 = fptosi double %t24 to i64
  %t26 = load { i8**, i64 }, { i8**, i64 }* %items
  %t27 = extractvalue { i8**, i64 } %t26, 0
  %t28 = extractvalue { i8**, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t25, i64 %t28)
  %t30 = getelementptr i8*, i8** %t27, i64 %t25
  %t31 = load i8*, i8** %t30
  %t32 = call i8* @sailfin_runtime_string_concat(i8* %t22, i8* %t31)
  store i8* %t32, i8** %l0
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch4
loop.latch4:
  %t36 = load i8*, i8** %l0
  %t37 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t40 = load i8*, i8** %l0
  %t41 = load double, double* %l1
  %t42 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t42)
  ret i8* %t42
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
  %t12 = call i8* @malloc(i64 1)
  %t13 = bitcast i8* %t12 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t13
  store i8* %t12, i8** %l1
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l2
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l3
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load i8*, i8** %l1
  %t18 = load double, double* %l2
  %t19 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t175 = phi double [ %t18, %block.entry ], [ %t171, %loop.latch2 ]
  %t176 = phi i8* [ %t17, %block.entry ], [ %t172, %loop.latch2 ]
  %t177 = phi { i8**, i64 }* [ %t16, %block.entry ], [ %t173, %loop.latch2 ]
  %t178 = phi double [ %t19, %block.entry ], [ %t174, %loop.latch2 ]
  store double %t175, double* %l2
  store i8* %t176, i8** %l1
  store { i8**, i64 }* %t177, { i8**, i64 }** %l0
  store double %t178, double* %l3
  br label %loop.body1
loop.body1:
  %t20 = load double, double* %l3
  %t21 = call i64 @sailfin_runtime_string_length(i8* %block)
  %t22 = sitofp i64 %t21 to double
  %t23 = fcmp oge double %t20, %t22
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load i8*, i8** %l1
  %t26 = load double, double* %l2
  %t27 = load double, double* %l3
  br i1 %t23, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t28 = load double, double* %l3
  %t29 = call double @llvm.round.f64(double %t28)
  %t30 = fptosi double %t29 to i64
  %t31 = getelementptr i8, i8* %block, i64 %t30
  %t32 = load i8, i8* %t31
  store i8 %t32, i8* %l4
  %t33 = load i8, i8* %l4
  %t34 = icmp eq i8 %t33, 60
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load i8*, i8** %l1
  %t37 = load double, double* %l2
  %t38 = load double, double* %l3
  %t39 = load i8, i8* %l4
  br i1 %t34, label %then6, label %else7
then6:
  %t40 = load double, double* %l2
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l2
  %t43 = load i8*, i8** %l1
  %t44 = load i8, i8* %l4
  %t45 = add i64 0, 2
  %t46 = call i8* @malloc(i64 %t45)
  store i8 %t44, i8* %t46
  %t47 = getelementptr i8, i8* %t46, i64 1
  store i8 0, i8* %t47
  call void @sailfin_runtime_mark_persistent(i8* %t46)
  %t48 = call i8* @sailfin_runtime_string_concat(i8* %t43, i8* %t46)
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
  %t73 = add i64 0, 2
  %t74 = call i8* @malloc(i64 %t73)
  store i8 %t72, i8* %t74
  %t75 = getelementptr i8, i8* %t74, i64 1
  store i8 0, i8* %t75
  call void @sailfin_runtime_mark_persistent(i8* %t74)
  %t76 = call i8* @sailfin_runtime_string_concat(i8* %t71, i8* %t74)
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
  %t123 = call i8* @malloc(i64 1)
  %t124 = bitcast i8* %t123 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t124
  store i8* %t123, i8** %l1
  %t125 = load double, double* %l3
  %t126 = sitofp i64 1 to double
  %t127 = fadd double %t125, %t126
  store double %t127, double* %l3
  br label %loop.latch2
merge18:
  %t128 = load i8*, i8** %l1
  %t129 = load i8, i8* %l4
  %t130 = add i64 0, 2
  %t131 = call i8* @malloc(i64 %t130)
  store i8 %t129, i8* %t131
  %t132 = getelementptr i8, i8* %t131, i64 1
  store i8 0, i8* %t132
  call void @sailfin_runtime_mark_persistent(i8* %t131)
  %t133 = call i8* @sailfin_runtime_string_concat(i8* %t128, i8* %t131)
  store i8* %t133, i8** %l1
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t135 = load i8*, i8** %l1
  %t136 = load double, double* %l3
  %t137 = load i8*, i8** %l1
  br label %merge16
else15:
  %t138 = load i8*, i8** %l1
  %t139 = load i8, i8* %l4
  %t140 = add i64 0, 2
  %t141 = call i8* @malloc(i64 %t140)
  store i8 %t139, i8* %t141
  %t142 = getelementptr i8, i8* %t141, i64 1
  store i8 0, i8* %t142
  call void @sailfin_runtime_mark_persistent(i8* %t141)
  %t143 = call i8* @sailfin_runtime_string_concat(i8* %t138, i8* %t141)
  store i8* %t143, i8** %l1
  %t144 = load i8*, i8** %l1
  br label %merge16
merge16:
  %t145 = phi { i8**, i64 }* [ %t134, %merge18 ], [ %t81, %else15 ]
  %t146 = phi i8* [ %t135, %merge18 ], [ %t144, %else15 ]
  %t147 = phi double [ %t136, %merge18 ], [ %t84, %else15 ]
  store { i8**, i64 }* %t145, { i8**, i64 }** %l0
  store i8* %t146, i8** %l1
  store double %t147, double* %l3
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t149 = load i8*, i8** %l1
  %t150 = load double, double* %l3
  %t151 = load i8*, i8** %l1
  %t152 = load i8*, i8** %l1
  br label %merge11
merge11:
  %t153 = phi double [ %t77, %merge13 ], [ %t55, %merge16 ]
  %t154 = phi i8* [ %t78, %merge13 ], [ %t149, %merge16 ]
  %t155 = phi { i8**, i64 }* [ %t53, %merge13 ], [ %t148, %merge16 ]
  %t156 = phi double [ %t56, %merge13 ], [ %t150, %merge16 ]
  store double %t153, double* %l2
  store i8* %t154, i8** %l1
  store { i8**, i64 }* %t155, { i8**, i64 }** %l0
  store double %t156, double* %l3
  %t157 = load double, double* %l2
  %t158 = load i8*, i8** %l1
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t160 = load i8*, i8** %l1
  %t161 = load double, double* %l3
  %t162 = load i8*, i8** %l1
  %t163 = load i8*, i8** %l1
  br label %merge8
merge8:
  %t164 = phi double [ %t49, %then6 ], [ %t157, %merge11 ]
  %t165 = phi i8* [ %t50, %then6 ], [ %t158, %merge11 ]
  %t166 = phi { i8**, i64 }* [ %t35, %then6 ], [ %t159, %merge11 ]
  %t167 = phi double [ %t38, %then6 ], [ %t161, %merge11 ]
  store double %t164, double* %l2
  store i8* %t165, i8** %l1
  store { i8**, i64 }* %t166, { i8**, i64 }** %l0
  store double %t167, double* %l3
  %t168 = load double, double* %l3
  %t169 = sitofp i64 1 to double
  %t170 = fadd double %t168, %t169
  store double %t170, double* %l3
  br label %loop.latch2
loop.latch2:
  %t171 = load double, double* %l2
  %t172 = load i8*, i8** %l1
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t174 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t179 = load double, double* %l2
  %t180 = load i8*, i8** %l1
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t182 = load double, double* %l3
  %t183 = load i8*, i8** %l1
  %t184 = call i8* @trim_text(i8* %t183)
  store i8* %t184, i8** %l6
  %t185 = load i8*, i8** %l6
  %t186 = call i64 @sailfin_runtime_string_length(i8* %t185)
  %t187 = icmp sgt i64 %t186, 0
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t189 = load i8*, i8** %l1
  %t190 = load double, double* %l2
  %t191 = load double, double* %l3
  %t192 = load i8*, i8** %l6
  br i1 %t187, label %then21, label %merge22
then21:
  %t193 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t194 = load i8*, i8** %l6
  %t195 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t196 = ptrtoint [1 x i8*]* %t195 to i64
  %t197 = icmp eq i64 %t196, 0
  %t198 = select i1 %t197, i64 1, i64 %t196
  %t199 = call i8* @malloc(i64 %t198)
  %t200 = bitcast i8* %t199 to i8**
  %t201 = getelementptr i8*, i8** %t200, i64 0
  store i8* %t194, i8** %t201
  %t202 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t203 = ptrtoint { i8**, i64 }* %t202 to i64
  %t204 = call i8* @malloc(i64 %t203)
  %t205 = bitcast i8* %t204 to { i8**, i64 }*
  %t206 = getelementptr { i8**, i64 }, { i8**, i64 }* %t205, i32 0, i32 0
  store i8** %t200, i8*** %t206
  %t207 = getelementptr { i8**, i64 }, { i8**, i64 }* %t205, i32 0, i32 1
  store i64 1, i64* %t207
  %t208 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t193, { i8**, i64 }* %t205)
  store { i8**, i64 }* %t208, { i8**, i64 }** %l0
  %t209 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge22
merge22:
  %t210 = phi { i8**, i64 }* [ %t209, %then21 ], [ %t188, %afterloop3 ]
  store { i8**, i64 }* %t210, { i8**, i64 }** %l0
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t211
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
  %t11 = call double @llvm.round.f64(double %t10)
  %t12 = fptosi double %t11 to i64
  %t13 = getelementptr i8, i8* %value, i64 %t12
  %t14 = load i8, i8* %t13
  %t15 = add i64 0, 2
  %t16 = call i8* @malloc(i64 %t15)
  store i8 %t14, i8* %t16
  %t17 = getelementptr i8, i8* %t16, i64 1
  store i8 0, i8* %t17
  call void @sailfin_runtime_mark_persistent(i8* %t16)
  %t18 = call i1 @is_whitespace(i8* %t16)
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
  %t37 = call double @llvm.round.f64(double %t36)
  %t38 = fptosi double %t37 to i64
  %t39 = getelementptr i8, i8* %value, i64 %t38
  %t40 = load i8, i8* %t39
  %t41 = add i64 0, 2
  %t42 = call i8* @malloc(i64 %t41)
  store i8 %t40, i8* %t42
  %t43 = getelementptr i8, i8* %t42, i64 1
  store i8 0, i8* %t43
  call void @sailfin_runtime_mark_persistent(i8* %t42)
  %t44 = call i1 @is_whitespace(i8* %t42)
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
  call void @sailfin_runtime_mark_persistent(i8* %t55)
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
  %t23 = call i8* @malloc(i64 1)
  %t24 = bitcast i8* %t23 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t24
  call void @sailfin_runtime_mark_persistent(i8* %t23)
  ret i8* %t23
merge5:
  %t25 = call i8* @malloc(i64 1)
  %t26 = bitcast i8* %t25 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t26
  store i8* %t25, i8** %l2
  %t27 = load double, double* %l0
  store double %t27, double* %l3
  %t28 = load double, double* %l0
  %t29 = load double, double* %l1
  %t30 = load i8*, i8** %l2
  %t31 = load double, double* %l3
  br label %loop.header6
loop.header6:
  %t54 = phi i8* [ %t30, %merge5 ], [ %t52, %loop.latch8 ]
  %t55 = phi double [ %t31, %merge5 ], [ %t53, %loop.latch8 ]
  store i8* %t54, i8** %l2
  store double %t55, double* %l3
  br label %loop.body7
loop.body7:
  %t32 = load double, double* %l3
  %t33 = load double, double* %l1
  %t34 = fcmp oge double %t32, %t33
  %t35 = load double, double* %l0
  %t36 = load double, double* %l1
  %t37 = load i8*, i8** %l2
  %t38 = load double, double* %l3
  br i1 %t34, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t39 = load i8*, i8** %l2
  %t40 = load double, double* %l3
  %t41 = call double @llvm.round.f64(double %t40)
  %t42 = fptosi double %t41 to i64
  %t43 = getelementptr i8, i8* %value, i64 %t42
  %t44 = load i8, i8* %t43
  %t45 = add i64 0, 2
  %t46 = call i8* @malloc(i64 %t45)
  store i8 %t44, i8* %t46
  %t47 = getelementptr i8, i8* %t46, i64 1
  store i8 0, i8* %t47
  call void @sailfin_runtime_mark_persistent(i8* %t46)
  %t48 = call i8* @sailfin_runtime_string_concat(i8* %t39, i8* %t46)
  store i8* %t48, i8** %l2
  %t49 = load double, double* %l3
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l3
  br label %loop.latch8
loop.latch8:
  %t52 = load i8*, i8** %l2
  %t53 = load double, double* %l3
  br label %loop.header6
afterloop9:
  %t56 = load i8*, i8** %l2
  %t57 = load double, double* %l3
  %t58 = load i8*, i8** %l2
  call void @sailfin_runtime_mark_persistent(i8* %t58)
  ret i8* %t58
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
  %t37 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t33, i32 0, i32 0
  %t38 = load %Diagnostic*, %Diagnostic** %t37
  %t39 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t33, i32 0, i32 1
  %t40 = load i64, i64* %t39
  %t41 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t36, i32 0, i32 0
  %t42 = load %Diagnostic*, %Diagnostic** %t41
  %t43 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t36, i32 0, i32 1
  %t44 = load i64, i64* %t43
  %t45 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t46 = ptrtoint %Diagnostic* %t45 to i64
  %t47 = add i64 %t40, %t44
  %t48 = mul i64 %t46, %t47
  %t49 = call noalias i8* @malloc(i64 %t48)
  %t50 = bitcast i8* %t49 to %Diagnostic*
  %t51 = bitcast %Diagnostic* %t50 to i8*
  %t52 = mul i64 %t46, %t40
  %t53 = bitcast %Diagnostic* %t38 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t51, i8* %t53, i64 %t52)
  %t54 = mul i64 %t46, %t44
  %t55 = bitcast %Diagnostic* %t42 to i8*
  %t56 = getelementptr %Diagnostic, %Diagnostic* %t50, i64 %t40
  %t57 = bitcast %Diagnostic* %t56 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t57, i8* %t55, i64 %t54)
  %t58 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t59 = ptrtoint { %Diagnostic*, i64 }* %t58 to i64
  %t60 = call i8* @malloc(i64 %t59)
  %t61 = bitcast i8* %t60 to { %Diagnostic*, i64 }*
  %t62 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t61, i32 0, i32 0
  store %Diagnostic* %t50, %Diagnostic** %t62
  %t63 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t61, i32 0, i32 1
  store i64 %t47, i64* %t63
  store { %Diagnostic*, i64 }* %t61, { %Diagnostic*, i64 }** %l1
  %t64 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t65 = extractvalue %MethodDeclaration %t64, 0
  %t66 = extractvalue %FunctionSignature %t65, 0
  store i8* %t66, i8** %l4
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t68 = load i8*, i8** %l4
  %t69 = call i1 @contains_string({ i8**, i64 }* %t67, i8* %t68)
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t72 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t73 = load i8*, i8** %l4
  br i1 %t69, label %then4, label %else5
then4:
  %t74 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t75 = load i8*, i8** %l4
  %t76 = call i8* @malloc(i64 7)
  %t77 = bitcast i8* %t76 to [7 x i8]*
  store [7 x i8] c"method\00", [7 x i8]* %t77
  %t78 = load i8*, i8** %l4
  %t79 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t80 = extractvalue %MethodDeclaration %t79, 0
  %t81 = extractvalue %FunctionSignature %t80, 6
  %t82 = call %Token* @token_from_name(i8* %t78, %SourceSpan* %t81)
  %t83 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t75, i8* %t76, %Token* %t82)
  %t84 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 1
  %t85 = ptrtoint [1 x %Diagnostic]* %t84 to i64
  %t86 = icmp eq i64 %t85, 0
  %t87 = select i1 %t86, i64 1, i64 %t85
  %t88 = call i8* @malloc(i64 %t87)
  %t89 = bitcast i8* %t88 to %Diagnostic*
  %t90 = getelementptr %Diagnostic, %Diagnostic* %t89, i64 0
  store %Diagnostic %t83, %Diagnostic* %t90
  %t91 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t92 = ptrtoint { %Diagnostic*, i64 }* %t91 to i64
  %t93 = call i8* @malloc(i64 %t92)
  %t94 = bitcast i8* %t93 to { %Diagnostic*, i64 }*
  %t95 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t94, i32 0, i32 0
  store %Diagnostic* %t89, %Diagnostic** %t95
  %t96 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t94, i32 0, i32 1
  store i64 1, i64* %t96
  %t97 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t74, i32 0, i32 0
  %t98 = load %Diagnostic*, %Diagnostic** %t97
  %t99 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t74, i32 0, i32 1
  %t100 = load i64, i64* %t99
  %t101 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t94, i32 0, i32 0
  %t102 = load %Diagnostic*, %Diagnostic** %t101
  %t103 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t94, i32 0, i32 1
  %t104 = load i64, i64* %t103
  %t105 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t106 = ptrtoint %Diagnostic* %t105 to i64
  %t107 = add i64 %t100, %t104
  %t108 = mul i64 %t106, %t107
  %t109 = call noalias i8* @malloc(i64 %t108)
  %t110 = bitcast i8* %t109 to %Diagnostic*
  %t111 = bitcast %Diagnostic* %t110 to i8*
  %t112 = mul i64 %t106, %t100
  %t113 = bitcast %Diagnostic* %t98 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t111, i8* %t113, i64 %t112)
  %t114 = mul i64 %t106, %t104
  %t115 = bitcast %Diagnostic* %t102 to i8*
  %t116 = getelementptr %Diagnostic, %Diagnostic* %t110, i64 %t100
  %t117 = bitcast %Diagnostic* %t116 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t117, i8* %t115, i64 %t114)
  %t118 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t119 = ptrtoint { %Diagnostic*, i64 }* %t118 to i64
  %t120 = call i8* @malloc(i64 %t119)
  %t121 = bitcast i8* %t120 to { %Diagnostic*, i64 }*
  %t122 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t121, i32 0, i32 0
  store %Diagnostic* %t110, %Diagnostic** %t122
  %t123 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t121, i32 0, i32 1
  store i64 %t107, i64* %t123
  store { %Diagnostic*, i64 }* %t121, { %Diagnostic*, i64 }** %l1
  %t124 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t126 = load i8*, i8** %l4
  %t127 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t128 = ptrtoint [1 x i8*]* %t127 to i64
  %t129 = icmp eq i64 %t128, 0
  %t130 = select i1 %t129, i64 1, i64 %t128
  %t131 = call i8* @malloc(i64 %t130)
  %t132 = bitcast i8* %t131 to i8**
  %t133 = getelementptr i8*, i8** %t132, i64 0
  store i8* %t126, i8** %t133
  %t134 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t135 = ptrtoint { i8**, i64 }* %t134 to i64
  %t136 = call i8* @malloc(i64 %t135)
  %t137 = bitcast i8* %t136 to { i8**, i64 }*
  %t138 = getelementptr { i8**, i64 }, { i8**, i64 }* %t137, i32 0, i32 0
  store i8** %t132, i8*** %t138
  %t139 = getelementptr { i8**, i64 }, { i8**, i64 }* %t137, i32 0, i32 1
  store i64 1, i64* %t139
  %t140 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t125, { i8**, i64 }* %t137)
  store { i8**, i64 }* %t140, { i8**, i64 }** %l0
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t142 = phi { %Diagnostic*, i64 }* [ %t124, %then4 ], [ %t71, %else5 ]
  %t143 = phi { i8**, i64 }* [ %t70, %then4 ], [ %t141, %else5 ]
  store { %Diagnostic*, i64 }* %t142, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t143, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t144 = load i64, i64* %l2
  %t145 = add i64 %t144, 1
  store i64 %t145, i64* %l2
  br label %for0
afterfor3:
  %t146 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t148 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t148
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
  %t44 = call i8* @malloc(i64 13)
  %t45 = bitcast i8* %t44 to [13 x i8]*
  store [13 x i8] c"enum variant\00", [13 x i8]* %t45
  %t46 = load i8*, i8** %l4
  %t47 = load %EnumVariant, %EnumVariant* %l3
  %t48 = extractvalue %EnumVariant %t47, 2
  %t49 = call %Token* @token_from_name(i8* %t46, %SourceSpan* %t48)
  %t50 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t43, i8* %t44, %Token* %t49)
  %t51 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 1
  %t52 = ptrtoint [1 x %Diagnostic]* %t51 to i64
  %t53 = icmp eq i64 %t52, 0
  %t54 = select i1 %t53, i64 1, i64 %t52
  %t55 = call i8* @malloc(i64 %t54)
  %t56 = bitcast i8* %t55 to %Diagnostic*
  %t57 = getelementptr %Diagnostic, %Diagnostic* %t56, i64 0
  store %Diagnostic %t50, %Diagnostic* %t57
  %t58 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t59 = ptrtoint { %Diagnostic*, i64 }* %t58 to i64
  %t60 = call i8* @malloc(i64 %t59)
  %t61 = bitcast i8* %t60 to { %Diagnostic*, i64 }*
  %t62 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t61, i32 0, i32 0
  store %Diagnostic* %t56, %Diagnostic** %t62
  %t63 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t61, i32 0, i32 1
  store i64 1, i64* %t63
  %t64 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t42, i32 0, i32 0
  %t65 = load %Diagnostic*, %Diagnostic** %t64
  %t66 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t42, i32 0, i32 1
  %t67 = load i64, i64* %t66
  %t68 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t61, i32 0, i32 0
  %t69 = load %Diagnostic*, %Diagnostic** %t68
  %t70 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t61, i32 0, i32 1
  %t71 = load i64, i64* %t70
  %t72 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t73 = ptrtoint %Diagnostic* %t72 to i64
  %t74 = add i64 %t67, %t71
  %t75 = mul i64 %t73, %t74
  %t76 = call noalias i8* @malloc(i64 %t75)
  %t77 = bitcast i8* %t76 to %Diagnostic*
  %t78 = bitcast %Diagnostic* %t77 to i8*
  %t79 = mul i64 %t73, %t67
  %t80 = bitcast %Diagnostic* %t65 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t78, i8* %t80, i64 %t79)
  %t81 = mul i64 %t73, %t71
  %t82 = bitcast %Diagnostic* %t69 to i8*
  %t83 = getelementptr %Diagnostic, %Diagnostic* %t77, i64 %t67
  %t84 = bitcast %Diagnostic* %t83 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t84, i8* %t82, i64 %t81)
  %t85 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t86 = ptrtoint { %Diagnostic*, i64 }* %t85 to i64
  %t87 = call i8* @malloc(i64 %t86)
  %t88 = bitcast i8* %t87 to { %Diagnostic*, i64 }*
  %t89 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t88, i32 0, i32 0
  store %Diagnostic* %t77, %Diagnostic** %t89
  %t90 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t88, i32 0, i32 1
  store i64 %t74, i64* %t90
  store { %Diagnostic*, i64 }* %t88, { %Diagnostic*, i64 }** %l1
  %t91 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t93 = load i8*, i8** %l4
  %t94 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t95 = ptrtoint [1 x i8*]* %t94 to i64
  %t96 = icmp eq i64 %t95, 0
  %t97 = select i1 %t96, i64 1, i64 %t95
  %t98 = call i8* @malloc(i64 %t97)
  %t99 = bitcast i8* %t98 to i8**
  %t100 = getelementptr i8*, i8** %t99, i64 0
  store i8* %t93, i8** %t100
  %t101 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t102 = ptrtoint { i8**, i64 }* %t101 to i64
  %t103 = call i8* @malloc(i64 %t102)
  %t104 = bitcast i8* %t103 to { i8**, i64 }*
  %t105 = getelementptr { i8**, i64 }, { i8**, i64 }* %t104, i32 0, i32 0
  store i8** %t99, i8*** %t105
  %t106 = getelementptr { i8**, i64 }, { i8**, i64 }* %t104, i32 0, i32 1
  store i64 1, i64* %t106
  %t107 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t92, { i8**, i64 }* %t104)
  store { i8**, i64 }* %t107, { i8**, i64 }** %l0
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t109 = phi { %Diagnostic*, i64 }* [ %t91, %then4 ], [ %t39, %else5 ]
  %t110 = phi { i8**, i64 }* [ %t38, %then4 ], [ %t108, %else5 ]
  store { %Diagnostic*, i64 }* %t109, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t110, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t111 = load i64, i64* %l2
  %t112 = add i64 %t111, 1
  store i64 %t112, i64* %l2
  br label %for0
afterfor3:
  %t113 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t115 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t115
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
  %t36 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t33, i32 0, i32 0
  %t37 = load %Diagnostic*, %Diagnostic** %t36
  %t38 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t33, i32 0, i32 1
  %t39 = load i64, i64* %t38
  %t40 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t35, i32 0, i32 0
  %t41 = load %Diagnostic*, %Diagnostic** %t40
  %t42 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t35, i32 0, i32 1
  %t43 = load i64, i64* %t42
  %t44 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t45 = ptrtoint %Diagnostic* %t44 to i64
  %t46 = add i64 %t39, %t43
  %t47 = mul i64 %t45, %t46
  %t48 = call noalias i8* @malloc(i64 %t47)
  %t49 = bitcast i8* %t48 to %Diagnostic*
  %t50 = bitcast %Diagnostic* %t49 to i8*
  %t51 = mul i64 %t45, %t39
  %t52 = bitcast %Diagnostic* %t37 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t50, i8* %t52, i64 %t51)
  %t53 = mul i64 %t45, %t43
  %t54 = bitcast %Diagnostic* %t41 to i8*
  %t55 = getelementptr %Diagnostic, %Diagnostic* %t49, i64 %t39
  %t56 = bitcast %Diagnostic* %t55 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t56, i8* %t54, i64 %t53)
  %t57 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t58 = ptrtoint { %Diagnostic*, i64 }* %t57 to i64
  %t59 = call i8* @malloc(i64 %t58)
  %t60 = bitcast i8* %t59 to { %Diagnostic*, i64 }*
  %t61 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t60, i32 0, i32 0
  store %Diagnostic* %t49, %Diagnostic** %t61
  %t62 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t60, i32 0, i32 1
  store i64 %t46, i64* %t62
  store { %Diagnostic*, i64 }* %t60, { %Diagnostic*, i64 }** %l1
  %t63 = load %FunctionSignature, %FunctionSignature* %l3
  %t64 = extractvalue %FunctionSignature %t63, 0
  store i8* %t64, i8** %l4
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load i8*, i8** %l4
  %t67 = call i1 @contains_string({ i8**, i64 }* %t65, i8* %t66)
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t70 = load %FunctionSignature, %FunctionSignature* %l3
  %t71 = load i8*, i8** %l4
  br i1 %t67, label %then4, label %else5
then4:
  %t72 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t73 = load i8*, i8** %l4
  %t74 = call i8* @malloc(i64 17)
  %t75 = bitcast i8* %t74 to [17 x i8]*
  store [17 x i8] c"interface member\00", [17 x i8]* %t75
  %t76 = load i8*, i8** %l4
  %t77 = load %FunctionSignature, %FunctionSignature* %l3
  %t78 = extractvalue %FunctionSignature %t77, 6
  %t79 = call %Token* @token_from_name(i8* %t76, %SourceSpan* %t78)
  %t80 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t73, i8* %t74, %Token* %t79)
  %t81 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 1
  %t82 = ptrtoint [1 x %Diagnostic]* %t81 to i64
  %t83 = icmp eq i64 %t82, 0
  %t84 = select i1 %t83, i64 1, i64 %t82
  %t85 = call i8* @malloc(i64 %t84)
  %t86 = bitcast i8* %t85 to %Diagnostic*
  %t87 = getelementptr %Diagnostic, %Diagnostic* %t86, i64 0
  store %Diagnostic %t80, %Diagnostic* %t87
  %t88 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t89 = ptrtoint { %Diagnostic*, i64 }* %t88 to i64
  %t90 = call i8* @malloc(i64 %t89)
  %t91 = bitcast i8* %t90 to { %Diagnostic*, i64 }*
  %t92 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t91, i32 0, i32 0
  store %Diagnostic* %t86, %Diagnostic** %t92
  %t93 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t91, i32 0, i32 1
  store i64 1, i64* %t93
  %t94 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t72, i32 0, i32 0
  %t95 = load %Diagnostic*, %Diagnostic** %t94
  %t96 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t72, i32 0, i32 1
  %t97 = load i64, i64* %t96
  %t98 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t91, i32 0, i32 0
  %t99 = load %Diagnostic*, %Diagnostic** %t98
  %t100 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t91, i32 0, i32 1
  %t101 = load i64, i64* %t100
  %t102 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t103 = ptrtoint %Diagnostic* %t102 to i64
  %t104 = add i64 %t97, %t101
  %t105 = mul i64 %t103, %t104
  %t106 = call noalias i8* @malloc(i64 %t105)
  %t107 = bitcast i8* %t106 to %Diagnostic*
  %t108 = bitcast %Diagnostic* %t107 to i8*
  %t109 = mul i64 %t103, %t97
  %t110 = bitcast %Diagnostic* %t95 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t108, i8* %t110, i64 %t109)
  %t111 = mul i64 %t103, %t101
  %t112 = bitcast %Diagnostic* %t99 to i8*
  %t113 = getelementptr %Diagnostic, %Diagnostic* %t107, i64 %t97
  %t114 = bitcast %Diagnostic* %t113 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t114, i8* %t112, i64 %t111)
  %t115 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t116 = ptrtoint { %Diagnostic*, i64 }* %t115 to i64
  %t117 = call i8* @malloc(i64 %t116)
  %t118 = bitcast i8* %t117 to { %Diagnostic*, i64 }*
  %t119 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t118, i32 0, i32 0
  store %Diagnostic* %t107, %Diagnostic** %t119
  %t120 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t118, i32 0, i32 1
  store i64 %t104, i64* %t120
  store { %Diagnostic*, i64 }* %t118, { %Diagnostic*, i64 }** %l1
  %t121 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t123 = load i8*, i8** %l4
  %t124 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t125 = ptrtoint [1 x i8*]* %t124 to i64
  %t126 = icmp eq i64 %t125, 0
  %t127 = select i1 %t126, i64 1, i64 %t125
  %t128 = call i8* @malloc(i64 %t127)
  %t129 = bitcast i8* %t128 to i8**
  %t130 = getelementptr i8*, i8** %t129, i64 0
  store i8* %t123, i8** %t130
  %t131 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t132 = ptrtoint { i8**, i64 }* %t131 to i64
  %t133 = call i8* @malloc(i64 %t132)
  %t134 = bitcast i8* %t133 to { i8**, i64 }*
  %t135 = getelementptr { i8**, i64 }, { i8**, i64 }* %t134, i32 0, i32 0
  store i8** %t129, i8*** %t135
  %t136 = getelementptr { i8**, i64 }, { i8**, i64 }* %t134, i32 0, i32 1
  store i64 1, i64* %t136
  %t137 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t122, { i8**, i64 }* %t134)
  store { i8**, i64 }* %t137, { i8**, i64 }** %l0
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t139 = phi { %Diagnostic*, i64 }* [ %t121, %then4 ], [ %t69, %else5 ]
  %t140 = phi { i8**, i64 }* [ %t68, %then4 ], [ %t138, %else5 ]
  store { %Diagnostic*, i64 }* %t139, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t140, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t141 = load i64, i64* %l2
  %t142 = add i64 %t141, 1
  store i64 %t142, i64* %l2
  br label %for0
afterfor3:
  %t143 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t145 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t145
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
  %t44 = call i8* @malloc(i64 15)
  %t45 = bitcast i8* %t44 to [15 x i8]*
  store [15 x i8] c"model property\00", [15 x i8]* %t45
  %t46 = load i8*, i8** %l4
  %t47 = load %ModelProperty, %ModelProperty* %l3
  %t48 = extractvalue %ModelProperty %t47, 2
  %t49 = call %Token* @token_from_name(i8* %t46, %SourceSpan* %t48)
  %t50 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t43, i8* %t44, %Token* %t49)
  %t51 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 1
  %t52 = ptrtoint [1 x %Diagnostic]* %t51 to i64
  %t53 = icmp eq i64 %t52, 0
  %t54 = select i1 %t53, i64 1, i64 %t52
  %t55 = call i8* @malloc(i64 %t54)
  %t56 = bitcast i8* %t55 to %Diagnostic*
  %t57 = getelementptr %Diagnostic, %Diagnostic* %t56, i64 0
  store %Diagnostic %t50, %Diagnostic* %t57
  %t58 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t59 = ptrtoint { %Diagnostic*, i64 }* %t58 to i64
  %t60 = call i8* @malloc(i64 %t59)
  %t61 = bitcast i8* %t60 to { %Diagnostic*, i64 }*
  %t62 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t61, i32 0, i32 0
  store %Diagnostic* %t56, %Diagnostic** %t62
  %t63 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t61, i32 0, i32 1
  store i64 1, i64* %t63
  %t64 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t42, i32 0, i32 0
  %t65 = load %Diagnostic*, %Diagnostic** %t64
  %t66 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t42, i32 0, i32 1
  %t67 = load i64, i64* %t66
  %t68 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t61, i32 0, i32 0
  %t69 = load %Diagnostic*, %Diagnostic** %t68
  %t70 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t61, i32 0, i32 1
  %t71 = load i64, i64* %t70
  %t72 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t73 = ptrtoint %Diagnostic* %t72 to i64
  %t74 = add i64 %t67, %t71
  %t75 = mul i64 %t73, %t74
  %t76 = call noalias i8* @malloc(i64 %t75)
  %t77 = bitcast i8* %t76 to %Diagnostic*
  %t78 = bitcast %Diagnostic* %t77 to i8*
  %t79 = mul i64 %t73, %t67
  %t80 = bitcast %Diagnostic* %t65 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t78, i8* %t80, i64 %t79)
  %t81 = mul i64 %t73, %t71
  %t82 = bitcast %Diagnostic* %t69 to i8*
  %t83 = getelementptr %Diagnostic, %Diagnostic* %t77, i64 %t67
  %t84 = bitcast %Diagnostic* %t83 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t84, i8* %t82, i64 %t81)
  %t85 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t86 = ptrtoint { %Diagnostic*, i64 }* %t85 to i64
  %t87 = call i8* @malloc(i64 %t86)
  %t88 = bitcast i8* %t87 to { %Diagnostic*, i64 }*
  %t89 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t88, i32 0, i32 0
  store %Diagnostic* %t77, %Diagnostic** %t89
  %t90 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t88, i32 0, i32 1
  store i64 %t74, i64* %t90
  store { %Diagnostic*, i64 }* %t88, { %Diagnostic*, i64 }** %l1
  %t91 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t93 = load i8*, i8** %l4
  %t94 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t95 = ptrtoint [1 x i8*]* %t94 to i64
  %t96 = icmp eq i64 %t95, 0
  %t97 = select i1 %t96, i64 1, i64 %t95
  %t98 = call i8* @malloc(i64 %t97)
  %t99 = bitcast i8* %t98 to i8**
  %t100 = getelementptr i8*, i8** %t99, i64 0
  store i8* %t93, i8** %t100
  %t101 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t102 = ptrtoint { i8**, i64 }* %t101 to i64
  %t103 = call i8* @malloc(i64 %t102)
  %t104 = bitcast i8* %t103 to { i8**, i64 }*
  %t105 = getelementptr { i8**, i64 }, { i8**, i64 }* %t104, i32 0, i32 0
  store i8** %t99, i8*** %t105
  %t106 = getelementptr { i8**, i64 }, { i8**, i64 }* %t104, i32 0, i32 1
  store i64 1, i64* %t106
  %t107 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t92, { i8**, i64 }* %t104)
  store { i8**, i64 }* %t107, { i8**, i64 }** %l0
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t109 = phi { %Diagnostic*, i64 }* [ %t91, %then4 ], [ %t39, %else5 ]
  %t110 = phi { i8**, i64 }* [ %t38, %then4 ], [ %t108, %else5 ]
  store { %Diagnostic*, i64 }* %t109, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t110, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t111 = load i64, i64* %l2
  %t112 = add i64 %t111, 1
  store i64 %t112, i64* %l2
  br label %for0
afterfor3:
  %t113 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t115 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t115
}

define { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %signature) {
block.entry:
  %t0 = extractvalue %FunctionSignature %signature, 5
  %t1 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t0)
  ret { %Diagnostic*, i64 }* %t1
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
  %t44 = call i8* @malloc(i64 15)
  %t45 = bitcast i8* %t44 to [15 x i8]*
  store [15 x i8] c"type parameter\00", [15 x i8]* %t45
  %t46 = load i8*, i8** %l4
  %t47 = load %TypeParameter, %TypeParameter* %l3
  %t48 = extractvalue %TypeParameter %t47, 2
  %t49 = call %Token* @token_from_name(i8* %t46, %SourceSpan* %t48)
  %t50 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t43, i8* %t44, %Token* %t49)
  %t51 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 1
  %t52 = ptrtoint [1 x %Diagnostic]* %t51 to i64
  %t53 = icmp eq i64 %t52, 0
  %t54 = select i1 %t53, i64 1, i64 %t52
  %t55 = call i8* @malloc(i64 %t54)
  %t56 = bitcast i8* %t55 to %Diagnostic*
  %t57 = getelementptr %Diagnostic, %Diagnostic* %t56, i64 0
  store %Diagnostic %t50, %Diagnostic* %t57
  %t58 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t59 = ptrtoint { %Diagnostic*, i64 }* %t58 to i64
  %t60 = call i8* @malloc(i64 %t59)
  %t61 = bitcast i8* %t60 to { %Diagnostic*, i64 }*
  %t62 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t61, i32 0, i32 0
  store %Diagnostic* %t56, %Diagnostic** %t62
  %t63 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t61, i32 0, i32 1
  store i64 1, i64* %t63
  %t64 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t42, i32 0, i32 0
  %t65 = load %Diagnostic*, %Diagnostic** %t64
  %t66 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t42, i32 0, i32 1
  %t67 = load i64, i64* %t66
  %t68 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t61, i32 0, i32 0
  %t69 = load %Diagnostic*, %Diagnostic** %t68
  %t70 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t61, i32 0, i32 1
  %t71 = load i64, i64* %t70
  %t72 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t73 = ptrtoint %Diagnostic* %t72 to i64
  %t74 = add i64 %t67, %t71
  %t75 = mul i64 %t73, %t74
  %t76 = call noalias i8* @malloc(i64 %t75)
  %t77 = bitcast i8* %t76 to %Diagnostic*
  %t78 = bitcast %Diagnostic* %t77 to i8*
  %t79 = mul i64 %t73, %t67
  %t80 = bitcast %Diagnostic* %t65 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t78, i8* %t80, i64 %t79)
  %t81 = mul i64 %t73, %t71
  %t82 = bitcast %Diagnostic* %t69 to i8*
  %t83 = getelementptr %Diagnostic, %Diagnostic* %t77, i64 %t67
  %t84 = bitcast %Diagnostic* %t83 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t84, i8* %t82, i64 %t81)
  %t85 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t86 = ptrtoint { %Diagnostic*, i64 }* %t85 to i64
  %t87 = call i8* @malloc(i64 %t86)
  %t88 = bitcast i8* %t87 to { %Diagnostic*, i64 }*
  %t89 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t88, i32 0, i32 0
  store %Diagnostic* %t77, %Diagnostic** %t89
  %t90 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t88, i32 0, i32 1
  store i64 %t74, i64* %t90
  store { %Diagnostic*, i64 }* %t88, { %Diagnostic*, i64 }** %l1
  %t91 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t93 = load i8*, i8** %l4
  %t94 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t95 = ptrtoint [1 x i8*]* %t94 to i64
  %t96 = icmp eq i64 %t95, 0
  %t97 = select i1 %t96, i64 1, i64 %t95
  %t98 = call i8* @malloc(i64 %t97)
  %t99 = bitcast i8* %t98 to i8**
  %t100 = getelementptr i8*, i8** %t99, i64 0
  store i8* %t93, i8** %t100
  %t101 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t102 = ptrtoint { i8**, i64 }* %t101 to i64
  %t103 = call i8* @malloc(i64 %t102)
  %t104 = bitcast i8* %t103 to { i8**, i64 }*
  %t105 = getelementptr { i8**, i64 }, { i8**, i64 }* %t104, i32 0, i32 0
  store i8** %t99, i8*** %t105
  %t106 = getelementptr { i8**, i64 }, { i8**, i64 }* %t104, i32 0, i32 1
  store i64 1, i64* %t106
  %t107 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t92, { i8**, i64 }* %t104)
  store { i8**, i64 }* %t107, { i8**, i64 }** %l0
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t109 = phi { %Diagnostic*, i64 }* [ %t91, %then4 ], [ %t39, %else5 ]
  %t110 = phi { i8**, i64 }* [ %t38, %then4 ], [ %t108, %else5 ]
  store { %Diagnostic*, i64 }* %t109, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t110, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t111 = load i64, i64* %l2
  %t112 = add i64 %t111, 1
  store i64 %t112, i64* %l2
  br label %for0
afterfor3:
  %t113 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t115 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t115
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
  %t136 = phi { %Diagnostic*, i64 }* [ %t15, %block.entry ], [ %t134, %loop.latch2 ]
  %t137 = phi double [ %t16, %block.entry ], [ %t135, %loop.latch2 ]
  store { %Diagnostic*, i64 }* %t136, { %Diagnostic*, i64 }** %l1
  store double %t137, double* %l2
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
  %t127 = phi { %Diagnostic*, i64 }* [ %t38, %merge5 ], [ %t125, %loop.latch8 ]
  %t128 = phi double [ %t41, %merge5 ], [ %t126, %loop.latch8 ]
  store { %Diagnostic*, i64 }* %t127, { %Diagnostic*, i64 }** %l1
  store double %t128, double* %l4
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
  %t68 = call %EffectRequirement* @select_requirement_for_effect({ %EffectRequirement*, i64 }* %t66, i8* %t67)
  store %EffectRequirement* %t68, %EffectRequirement** %l6
  %t69 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t70 = call i8* @malloc(i64 16)
  %t71 = bitcast i8* %t70 to [16 x i8]*
  store [16 x i8] c"effects.missing\00", [16 x i8]* %t71
  %t72 = insertvalue %Diagnostic undef, i8* %t70, 0
  %t73 = load %EffectViolation, %EffectViolation* %l3
  %t74 = extractvalue %EffectViolation %t73, 0
  %t75 = load i8*, i8** %l5
  %t76 = load %EffectRequirement*, %EffectRequirement** %l6
  %t77 = call i8* @format_effect_message(i8* %t74, i8* %t75, %EffectRequirement* %t76)
  %t78 = insertvalue %Diagnostic %t72, i8* %t77, 1
  %t79 = load %EffectRequirement*, %EffectRequirement** %l6
  %t80 = call %Token* @requirement_primary_token(%EffectRequirement* %t79)
  %t81 = insertvalue %Diagnostic %t78, %Token* %t80, 2
  %t82 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 1
  %t83 = ptrtoint [1 x %Diagnostic]* %t82 to i64
  %t84 = icmp eq i64 %t83, 0
  %t85 = select i1 %t84, i64 1, i64 %t83
  %t86 = call i8* @malloc(i64 %t85)
  %t87 = bitcast i8* %t86 to %Diagnostic*
  %t88 = getelementptr %Diagnostic, %Diagnostic* %t87, i64 0
  store %Diagnostic %t81, %Diagnostic* %t88
  %t89 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t90 = ptrtoint { %Diagnostic*, i64 }* %t89 to i64
  %t91 = call i8* @malloc(i64 %t90)
  %t92 = bitcast i8* %t91 to { %Diagnostic*, i64 }*
  %t93 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t92, i32 0, i32 0
  store %Diagnostic* %t87, %Diagnostic** %t93
  %t94 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t92, i32 0, i32 1
  store i64 1, i64* %t94
  %t95 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t69, i32 0, i32 0
  %t96 = load %Diagnostic*, %Diagnostic** %t95
  %t97 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t69, i32 0, i32 1
  %t98 = load i64, i64* %t97
  %t99 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t92, i32 0, i32 0
  %t100 = load %Diagnostic*, %Diagnostic** %t99
  %t101 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t92, i32 0, i32 1
  %t102 = load i64, i64* %t101
  %t103 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t104 = ptrtoint %Diagnostic* %t103 to i64
  %t105 = add i64 %t98, %t102
  %t106 = mul i64 %t104, %t105
  %t107 = call noalias i8* @malloc(i64 %t106)
  %t108 = bitcast i8* %t107 to %Diagnostic*
  %t109 = bitcast %Diagnostic* %t108 to i8*
  %t110 = mul i64 %t104, %t98
  %t111 = bitcast %Diagnostic* %t96 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t109, i8* %t111, i64 %t110)
  %t112 = mul i64 %t104, %t102
  %t113 = bitcast %Diagnostic* %t100 to i8*
  %t114 = getelementptr %Diagnostic, %Diagnostic* %t108, i64 %t98
  %t115 = bitcast %Diagnostic* %t114 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t115, i8* %t113, i64 %t112)
  %t116 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t117 = ptrtoint { %Diagnostic*, i64 }* %t116 to i64
  %t118 = call i8* @malloc(i64 %t117)
  %t119 = bitcast i8* %t118 to { %Diagnostic*, i64 }*
  %t120 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t119, i32 0, i32 0
  store %Diagnostic* %t108, %Diagnostic** %t120
  %t121 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t119, i32 0, i32 1
  store i64 %t105, i64* %t121
  store { %Diagnostic*, i64 }* %t119, { %Diagnostic*, i64 }** %l1
  %t122 = load double, double* %l4
  %t123 = sitofp i64 1 to double
  %t124 = fadd double %t122, %t123
  store double %t124, double* %l4
  br label %loop.latch8
loop.latch8:
  %t125 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t126 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t129 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t130 = load double, double* %l4
  %t131 = load double, double* %l2
  %t132 = sitofp i64 1 to double
  %t133 = fadd double %t131, %t132
  store double %t133, double* %l2
  br label %loop.latch2
loop.latch2:
  %t134 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t135 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t138 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t139 = load double, double* %l2
  %t140 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t140
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
  %t31 = phi double [ %t1, %block.entry ], [ %t30, %loop.latch2 ]
  store double %t31, double* %l0
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
  %t23 = getelementptr %EffectRequirement, %EffectRequirement* null, i32 1
  %t24 = ptrtoint %EffectRequirement* %t23 to i64
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %EffectRequirement*
  store %EffectRequirement %t22, %EffectRequirement* %t26
  call void @sailfin_runtime_mark_persistent(i8* %t25)
  ret %EffectRequirement* %t26
merge7:
  %t27 = load double, double* %l0
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l0
  br label %loop.latch2
loop.latch2:
  %t30 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t32 = load double, double* %l0
  %t33 = bitcast i8* null to %EffectRequirement*
  ret %EffectRequirement* %t33
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
  %t0 = call i8* @malloc(i64 21)
  %t1 = bitcast i8* %t0 to [21 x i8]*
  store [21 x i8] c" is missing effect '\00", [21 x i8]* %t1
  %t2 = call i8* @sailfin_runtime_string_concat(i8* %routine_name, i8* %t0)
  %t3 = call i8* @sailfin_runtime_string_concat(i8* %t2, i8* %effect)
  %t4 = add i64 0, 2
  %t5 = call i8* @malloc(i64 %t4)
  store i8 39, i8* %t5
  %t6 = getelementptr i8, i8* %t5, i64 1
  store i8 0, i8* %t6
  call void @sailfin_runtime_mark_persistent(i8* %t5)
  %t7 = call i8* @sailfin_runtime_string_concat(i8* %t3, i8* %t5)
  store i8* %t7, i8** %l0
  %t8 = icmp ne %EffectRequirement* %requirement, null
  %t9 = load i8*, i8** %l0
  br i1 %t8, label %then0, label %merge1
then0:
  %t10 = load i8*, i8** %l0
  %t11 = call i8* @malloc(i64 15)
  %t12 = bitcast i8* %t11 to [15 x i8]*
  store [15 x i8] c"; required by \00", [15 x i8]* %t12
  %t13 = call i8* @sailfin_runtime_string_concat(i8* %t10, i8* %t11)
  %t14 = getelementptr %EffectRequirement, %EffectRequirement* %requirement, i32 0, i32 2
  %t15 = load i8*, i8** %t14
  %t16 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %t15)
  store i8* %t16, i8** %l0
  %t17 = load i8*, i8** %l0
  br label %merge1
merge1:
  %t18 = phi i8* [ %t17, %then0 ], [ %t9, %block.entry ]
  store i8* %t18, i8** %l0
  %t19 = load i8*, i8** %l0
  %t20 = call i8* @malloc(i64 15)
  %t21 = bitcast i8* %t20 to [15 x i8]*
  store [15 x i8] c". hint: add ![\00", [15 x i8]* %t21
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %t19, i8* %t20)
  %t23 = call i8* @sailfin_runtime_string_concat(i8* %t22, i8* %effect)
  %t24 = call i8* @malloc(i64 61)
  %t25 = bitcast i8* %t24 to [61 x i8]*
  store [61 x i8] c"] to the signature or accept the CLI fix prompt when offered\00", [61 x i8]* %t25
  %t26 = call i8* @sailfin_runtime_string_concat(i8* %t23, i8* %t24)
  store i8* %t26, i8** %l0
  %t27 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t27)
  ret i8* %t27
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
  %t1 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %bindings, 0
  %t2 = call %Token* @token_from_name(i8* %name, %SourceSpan* %span)
  %t3 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %name, i8* %kind, %Token* %t2)
  %t4 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 1
  %t5 = ptrtoint [1 x %Diagnostic]* %t4 to i64
  %t6 = icmp eq i64 %t5, 0
  %t7 = select i1 %t6, i64 1, i64 %t5
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to %Diagnostic*
  %t10 = getelementptr %Diagnostic, %Diagnostic* %t9, i64 0
  store %Diagnostic %t3, %Diagnostic* %t10
  %t11 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t12 = ptrtoint { %Diagnostic*, i64 }* %t11 to i64
  %t13 = call i8* @malloc(i64 %t12)
  %t14 = bitcast i8* %t13 to { %Diagnostic*, i64 }*
  %t15 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t14, i32 0, i32 0
  store %Diagnostic* %t9, %Diagnostic** %t15
  %t16 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t14, i32 0, i32 1
  store i64 1, i64* %t16
  %t17 = insertvalue %ScopeResult %t1, { %Diagnostic*, i64 }* %t14, 1
  ret %ScopeResult %t17
merge1:
  %t18 = call { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %name, i8* %kind, %SourceSpan* %span)
  store { %SymbolEntry*, i64 }* %t18, { %SymbolEntry*, i64 }** %l0
  %t19 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t20 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t19, 0
  %t21 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t22 = ptrtoint [0 x %Diagnostic]* %t21 to i64
  %t23 = icmp eq i64 %t22, 0
  %t24 = select i1 %t23, i64 1, i64 %t22
  %t25 = call i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %Diagnostic*
  %t27 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t28 = ptrtoint { %Diagnostic*, i64 }* %t27 to i64
  %t29 = call i8* @malloc(i64 %t28)
  %t30 = bitcast i8* %t29 to { %Diagnostic*, i64 }*
  %t31 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t30, i32 0, i32 0
  store %Diagnostic* %t26, %Diagnostic** %t31
  %t32 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t30, i32 0, i32 1
  store i64 0, i64* %t32
  %t33 = insertvalue %ScopeResult %t20, { %Diagnostic*, i64 }* %t30, 1
  ret %ScopeResult %t33
}

define %SymbolCollectionResult @register_symbol(i8* %name, i8* %kind, %SourceSpan* %span, { %SymbolEntry*, i64 }* %existing) {
block.entry:
  %t0 = call i1 @has_symbol({ %SymbolEntry*, i64 }* %existing, i8* %name)
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = insertvalue %SymbolCollectionResult undef, { %SymbolEntry*, i64 }* %existing, 0
  %t2 = call %Token* @token_from_name(i8* %name, %SourceSpan* %span)
  %t3 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %name, i8* %kind, %Token* %t2)
  %t4 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 1
  %t5 = ptrtoint [1 x %Diagnostic]* %t4 to i64
  %t6 = icmp eq i64 %t5, 0
  %t7 = select i1 %t6, i64 1, i64 %t5
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to %Diagnostic*
  %t10 = getelementptr %Diagnostic, %Diagnostic* %t9, i64 0
  store %Diagnostic %t3, %Diagnostic* %t10
  %t11 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t12 = ptrtoint { %Diagnostic*, i64 }* %t11 to i64
  %t13 = call i8* @malloc(i64 %t12)
  %t14 = bitcast i8* %t13 to { %Diagnostic*, i64 }*
  %t15 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t14, i32 0, i32 0
  store %Diagnostic* %t9, %Diagnostic** %t15
  %t16 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t14, i32 0, i32 1
  store i64 1, i64* %t16
  %t17 = insertvalue %SymbolCollectionResult %t1, { %Diagnostic*, i64 }* %t14, 1
  ret %SymbolCollectionResult %t17
merge1:
  %t18 = call { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %existing, i8* %name, i8* %kind, %SourceSpan* %span)
  %t19 = insertvalue %SymbolCollectionResult undef, { %SymbolEntry*, i64 }* %t18, 0
  %t20 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t21 = ptrtoint [0 x %Diagnostic]* %t20 to i64
  %t22 = icmp eq i64 %t21, 0
  %t23 = select i1 %t22, i64 1, i64 %t21
  %t24 = call i8* @malloc(i64 %t23)
  %t25 = bitcast i8* %t24 to %Diagnostic*
  %t26 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t27 = ptrtoint { %Diagnostic*, i64 }* %t26 to i64
  %t28 = call i8* @malloc(i64 %t27)
  %t29 = bitcast i8* %t28 to { %Diagnostic*, i64 }*
  %t30 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t29, i32 0, i32 0
  store %Diagnostic* %t25, %Diagnostic** %t30
  %t31 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t29, i32 0, i32 1
  store i64 0, i64* %t31
  %t32 = insertvalue %SymbolCollectionResult %t19, { %Diagnostic*, i64 }* %t29, 1
  ret %SymbolCollectionResult %t32
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
  %t18 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t1, i32 0, i32 0
  %t19 = load %SymbolEntry*, %SymbolEntry** %t18
  %t20 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t1, i32 0, i32 1
  %t21 = load i64, i64* %t20
  %t22 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t15, i32 0, i32 0
  %t23 = load %SymbolEntry*, %SymbolEntry** %t22
  %t24 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t15, i32 0, i32 1
  %t25 = load i64, i64* %t24
  %t26 = getelementptr [1 x %SymbolEntry], [1 x %SymbolEntry]* null, i32 0, i32 1
  %t27 = ptrtoint %SymbolEntry* %t26 to i64
  %t28 = add i64 %t21, %t25
  %t29 = mul i64 %t27, %t28
  %t30 = call noalias i8* @malloc(i64 %t29)
  %t31 = bitcast i8* %t30 to %SymbolEntry*
  %t32 = bitcast %SymbolEntry* %t31 to i8*
  %t33 = mul i64 %t27, %t21
  %t34 = bitcast %SymbolEntry* %t19 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t32, i8* %t34, i64 %t33)
  %t35 = mul i64 %t27, %t25
  %t36 = bitcast %SymbolEntry* %t23 to i8*
  %t37 = getelementptr %SymbolEntry, %SymbolEntry* %t31, i64 %t21
  %t38 = bitcast %SymbolEntry* %t37 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t38, i8* %t36, i64 %t35)
  %t39 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* null, i32 1
  %t40 = ptrtoint { %SymbolEntry*, i64 }* %t39 to i64
  %t41 = call i8* @malloc(i64 %t40)
  %t42 = bitcast i8* %t41 to { %SymbolEntry*, i64 }*
  %t43 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t42, i32 0, i32 0
  store %SymbolEntry* %t31, %SymbolEntry** %t43
  %t44 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t42, i32 0, i32 1
  store i64 %t28, i64* %t44
  ret { %SymbolEntry*, i64 }* %t42
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
  %t23 = getelementptr [1 x %SymbolEntry], [1 x %SymbolEntry]* null, i32 1
  %t24 = ptrtoint [1 x %SymbolEntry]* %t23 to i64
  %t25 = icmp eq i64 %t24, 0
  %t26 = select i1 %t25, i64 1, i64 %t24
  %t27 = call i8* @malloc(i64 %t26)
  %t28 = bitcast i8* %t27 to %SymbolEntry*
  %t29 = getelementptr %SymbolEntry, %SymbolEntry* %t28, i64 0
  store %SymbolEntry %t22, %SymbolEntry* %t29
  %t30 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* null, i32 1
  %t31 = ptrtoint { %SymbolEntry*, i64 }* %t30 to i64
  %t32 = call i8* @malloc(i64 %t31)
  %t33 = bitcast i8* %t32 to { %SymbolEntry*, i64 }*
  %t34 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t33, i32 0, i32 0
  store %SymbolEntry* %t28, %SymbolEntry** %t34
  %t35 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t33, i32 0, i32 1
  store i64 1, i64* %t35
  %t36 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t21, i32 0, i32 0
  %t37 = load %SymbolEntry*, %SymbolEntry** %t36
  %t38 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t21, i32 0, i32 1
  %t39 = load i64, i64* %t38
  %t40 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t33, i32 0, i32 0
  %t41 = load %SymbolEntry*, %SymbolEntry** %t40
  %t42 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t33, i32 0, i32 1
  %t43 = load i64, i64* %t42
  %t44 = getelementptr [1 x %SymbolEntry], [1 x %SymbolEntry]* null, i32 0, i32 1
  %t45 = ptrtoint %SymbolEntry* %t44 to i64
  %t46 = add i64 %t39, %t43
  %t47 = mul i64 %t45, %t46
  %t48 = call noalias i8* @malloc(i64 %t47)
  %t49 = bitcast i8* %t48 to %SymbolEntry*
  %t50 = bitcast %SymbolEntry* %t49 to i8*
  %t51 = mul i64 %t45, %t39
  %t52 = bitcast %SymbolEntry* %t37 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t50, i8* %t52, i64 %t51)
  %t53 = mul i64 %t45, %t43
  %t54 = bitcast %SymbolEntry* %t41 to i8*
  %t55 = getelementptr %SymbolEntry, %SymbolEntry* %t49, i64 %t39
  %t56 = bitcast %SymbolEntry* %t55 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t56, i8* %t54, i64 %t53)
  %t57 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* null, i32 1
  %t58 = ptrtoint { %SymbolEntry*, i64 }* %t57 to i64
  %t59 = call i8* @malloc(i64 %t58)
  %t60 = bitcast i8* %t59 to { %SymbolEntry*, i64 }*
  %t61 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t60, i32 0, i32 0
  store %SymbolEntry* %t49, %SymbolEntry** %t61
  %t62 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t60, i32 0, i32 1
  store i64 %t46, i64* %t62
  store { %SymbolEntry*, i64 }* %t60, { %SymbolEntry*, i64 }** %l0
  br label %forinc2
forinc2:
  %t63 = load i64, i64* %l1
  %t64 = add i64 %t63, 1
  store i64 %t64, i64* %l1
  br label %for0
afterfor3:
  %t65 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t66 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  ret { %SymbolEntry*, i64 }* %t66
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
  %t0 = call i8* @malloc(i64 6)
  %t1 = bitcast i8* %t0 to [6 x i8]*
  store [6 x i8] c"E0302\00", [6 x i8]* %t1
  %t2 = insertvalue %Diagnostic undef, i8* %t0, 0
  %t3 = call i8* @malloc(i64 8)
  %t4 = bitcast i8* %t3 to [8 x i8]*
  store [8 x i8] c"struct \00", [8 x i8]* %t4
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t3, i8* %struct_name)
  %t6 = call i8* @malloc(i64 13)
  %t7 = bitcast i8* %t6 to [13 x i8]*
  store [13 x i8] c" implements \00", [13 x i8]* %t7
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %t5, i8* %t6)
  %t9 = call i8* @sailfin_runtime_string_concat(i8* %t8, i8* %interface_name)
  %t10 = call i8* @malloc(i64 19)
  %t11 = bitcast i8* %t10 to [19 x i8]*
  store [19 x i8] c" but must specify \00", [19 x i8]* %t11
  %t12 = call i8* @sailfin_runtime_string_concat(i8* %t9, i8* %t10)
  %t13 = call i8* @sailfin_runtime_string_concat(i8* %t12, i8* %interface_signature)
  %t14 = call i8* @malloc(i64 16)
  %t15 = bitcast i8* %t14 to [16 x i8]*
  store [16 x i8] c" type arguments\00", [16 x i8]* %t15
  %t16 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %t14)
  %t17 = insertvalue %Diagnostic %t2, i8* %t16, 1
  %t18 = bitcast i8* null to %Token*
  %t19 = insertvalue %Diagnostic %t17, %Token* %t18, 2
  ret %Diagnostic %t19
}

define %Diagnostic @make_interface_type_argument_mismatch_diagnostic(i8* %struct_name, i8* %annotation_text, i8* %interface_signature) {
block.entry:
  %t0 = call i8* @malloc(i64 6)
  %t1 = bitcast i8* %t0 to [6 x i8]*
  store [6 x i8] c"E0302\00", [6 x i8]* %t1
  %t2 = insertvalue %Diagnostic undef, i8* %t0, 0
  %t3 = call i8* @malloc(i64 8)
  %t4 = bitcast i8* %t3 to [8 x i8]*
  store [8 x i8] c"struct \00", [8 x i8]* %t4
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t3, i8* %struct_name)
  %t6 = call i8* @malloc(i64 13)
  %t7 = bitcast i8* %t6 to [13 x i8]*
  store [13 x i8] c" implements \00", [13 x i8]* %t7
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %t5, i8* %t6)
  %t9 = call i8* @sailfin_runtime_string_concat(i8* %t8, i8* %annotation_text)
  %t10 = call i8* @malloc(i64 17)
  %t11 = bitcast i8* %t10 to [17 x i8]*
  store [17 x i8] c" but must match \00", [17 x i8]* %t11
  %t12 = call i8* @sailfin_runtime_string_concat(i8* %t9, i8* %t10)
  %t13 = call i8* @sailfin_runtime_string_concat(i8* %t12, i8* %interface_signature)
  %t14 = call i8* @malloc(i64 16)
  %t15 = bitcast i8* %t14 to [16 x i8]*
  store [16 x i8] c" type arguments\00", [16 x i8]* %t15
  %t16 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %t14)
  %t17 = insertvalue %Diagnostic %t2, i8* %t16, 1
  %t18 = bitcast i8* null to %Token*
  %t19 = insertvalue %Diagnostic %t17, %Token* %t18, 2
  ret %Diagnostic %t19
}

define %Diagnostic @make_interface_no_type_arguments_diagnostic(i8* %struct_name, i8* %annotation_text, i8* %interface_name) {
block.entry:
  %t0 = call i8* @malloc(i64 6)
  %t1 = bitcast i8* %t0 to [6 x i8]*
  store [6 x i8] c"E0302\00", [6 x i8]* %t1
  %t2 = insertvalue %Diagnostic undef, i8* %t0, 0
  %t3 = call i8* @malloc(i64 8)
  %t4 = bitcast i8* %t3 to [8 x i8]*
  store [8 x i8] c"struct \00", [8 x i8]* %t4
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t3, i8* %struct_name)
  %t6 = call i8* @malloc(i64 13)
  %t7 = bitcast i8* %t6 to [13 x i8]*
  store [13 x i8] c" implements \00", [13 x i8]* %t7
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %t5, i8* %t6)
  %t9 = call i8* @sailfin_runtime_string_concat(i8* %t8, i8* %annotation_text)
  %t10 = call i8* @malloc(i64 6)
  %t11 = bitcast i8* %t10 to [6 x i8]*
  store [6 x i8] c" but \00", [6 x i8]* %t11
  %t12 = call i8* @sailfin_runtime_string_concat(i8* %t9, i8* %t10)
  %t13 = call i8* @sailfin_runtime_string_concat(i8* %t12, i8* %interface_name)
  %t14 = call i8* @malloc(i64 30)
  %t15 = bitcast i8* %t14 to [30 x i8]*
  store [30 x i8] c" does not take type arguments\00", [30 x i8]* %t15
  %t16 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %t14)
  %t17 = insertvalue %Diagnostic %t2, i8* %t16, 1
  %t18 = bitcast i8* null to %Token*
  %t19 = insertvalue %Diagnostic %t17, %Token* %t18, 2
  ret %Diagnostic %t19
}

define %Token* @token_from_name(i8* %name, %SourceSpan* %span) {
block.entry:
  %t0 = icmp eq %SourceSpan* %span, null
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = bitcast i8* null to %Token*
  ret %Token* %t1
merge1:
  %t2 = insertvalue %TokenKind undef, i32 0, 0
  %t3 = insertvalue %Token undef, %TokenKind %t2, 0
  %t4 = insertvalue %Token %t3, i8* %name, 1
  %t5 = getelementptr %SourceSpan, %SourceSpan* %span, i32 0, i32 0
  %t6 = load double, double* %t5
  %t7 = insertvalue %Token %t4, double %t6, 2
  %t8 = getelementptr %SourceSpan, %SourceSpan* %span, i32 0, i32 1
  %t9 = load double, double* %t8
  %t10 = insertvalue %Token %t7, double %t9, 3
  %t11 = getelementptr %Token, %Token* null, i32 1
  %t12 = ptrtoint %Token* %t11 to i64
  %t13 = call noalias i8* @malloc(i64 %t12)
  %t14 = bitcast i8* %t13 to %Token*
  store %Token %t10, %Token* %t14
  call void @sailfin_runtime_mark_persistent(i8* %t13)
  ret %Token* %t14
}

define %Diagnostic @make_duplicate_symbol_diagnostic(i8* %name, i8* %kind, %Token* %token) {
block.entry:
  %t0 = call i8* @malloc(i64 6)
  %t1 = bitcast i8* %t0 to [6 x i8]*
  store [6 x i8] c"E0001\00", [6 x i8]* %t1
  %t2 = insertvalue %Diagnostic undef, i8* %t0, 0
  %t3 = call i8* @malloc(i64 11)
  %t4 = bitcast i8* %t3 to [11 x i8]*
  store [11 x i8] c"duplicate \00", [11 x i8]* %t4
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t3, i8* %kind)
  %t6 = call i8* @malloc(i64 3)
  %t7 = bitcast i8* %t6 to [3 x i8]*
  store [3 x i8] c" `\00", [3 x i8]* %t7
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %t5, i8* %t6)
  %t9 = call i8* @sailfin_runtime_string_concat(i8* %t8, i8* %name)
  %t10 = call i8* @malloc(i64 11)
  %t11 = bitcast i8* %t10 to [11 x i8]*
  store [11 x i8] c"` declared\00", [11 x i8]* %t11
  %t12 = call i8* @sailfin_runtime_string_concat(i8* %t9, i8* %t10)
  %t13 = insertvalue %Diagnostic %t2, i8* %t12, 1
  %t14 = insertvalue %Diagnostic %t13, %Token* %token, 2
  ret %Diagnostic %t14
}

define %Diagnostic @make_missing_interface_member_diagnostic(i8* %struct_name, i8* %interface_name, i8* %member_name) {
block.entry:
  %t0 = call i8* @malloc(i64 6)
  %t1 = bitcast i8* %t0 to [6 x i8]*
  store [6 x i8] c"E0301\00", [6 x i8]* %t1
  %t2 = insertvalue %Diagnostic undef, i8* %t0, 0
  %t3 = call i8* @malloc(i64 8)
  %t4 = bitcast i8* %t3 to [8 x i8]*
  store [8 x i8] c"struct \00", [8 x i8]* %t4
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t3, i8* %struct_name)
  %t6 = call i8* @malloc(i64 13)
  %t7 = bitcast i8* %t6 to [13 x i8]*
  store [13 x i8] c" implements \00", [13 x i8]* %t7
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %t5, i8* %t6)
  %t9 = call i8* @sailfin_runtime_string_concat(i8* %t8, i8* %interface_name)
  %t10 = call i8* @malloc(i64 25)
  %t11 = bitcast i8* %t10 to [25 x i8]*
  store [25 x i8] c" but is missing member `\00", [25 x i8]* %t11
  %t12 = call i8* @sailfin_runtime_string_concat(i8* %t9, i8* %t10)
  %t13 = call i8* @sailfin_runtime_string_concat(i8* %t12, i8* %member_name)
  %t14 = add i64 0, 2
  %t15 = call i8* @malloc(i64 %t14)
  store i8 96, i8* %t15
  %t16 = getelementptr i8, i8* %t15, i64 1
  store i8 0, i8* %t16
  call void @sailfin_runtime_mark_persistent(i8* %t15)
  %t17 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %t15)
  %t18 = insertvalue %Diagnostic %t2, i8* %t17, 1
  %t19 = bitcast i8* null to %Token*
  %t20 = insertvalue %Diagnostic %t18, %Token* %t19, 2
  ret %Diagnostic %t20
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