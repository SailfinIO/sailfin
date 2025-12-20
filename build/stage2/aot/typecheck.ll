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
declare i8* @sailfin_runtime_number_to_string(double)
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

@runtime__typecheck = external global i8**

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
@.enum.Statement.BlockStatement.variant = private unnamed_addr constant [15 x i8] c"BlockStatement\00"
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
  %t85 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t23, 20
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t23, 21
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t23, 22
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t23, 23
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = call i8* @malloc(i64 21)
  %t98 = bitcast i8* %t97 to [21 x i8]*
  store [21 x i8] c"InterfaceDeclaration\00", [21 x i8]* %t98
  %t99 = call i1 @strings_equal(i8* %t96, i8* %t97)
  %t100 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  %t101 = load %Statement, %Statement* %l2
  br i1 %t99, label %then4, label %merge5
then4:
  %t102 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  %t103 = load %Statement, %Statement* %l2
  %t104 = getelementptr [1 x %Statement], [1 x %Statement]* null, i32 1
  %t105 = ptrtoint [1 x %Statement]* %t104 to i64
  %t106 = icmp eq i64 %t105, 0
  %t107 = select i1 %t106, i64 1, i64 %t105
  %t108 = call i8* @malloc(i64 %t107)
  %t109 = bitcast i8* %t108 to %Statement*
  %t110 = getelementptr %Statement, %Statement* %t109, i64 0
  store %Statement %t103, %Statement* %t110
  %t111 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* null, i32 1
  %t112 = ptrtoint { %Statement*, i64 }* %t111 to i64
  %t113 = call i8* @malloc(i64 %t112)
  %t114 = bitcast i8* %t113 to { %Statement*, i64 }*
  %t115 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t114, i32 0, i32 0
  store %Statement* %t109, %Statement** %t115
  %t116 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t114, i32 0, i32 1
  store i64 1, i64* %t116
  %t117 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t102, i32 0, i32 0
  %t118 = load %Statement*, %Statement** %t117
  %t119 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t102, i32 0, i32 1
  %t120 = load i64, i64* %t119
  %t121 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t114, i32 0, i32 0
  %t122 = load %Statement*, %Statement** %t121
  %t123 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t114, i32 0, i32 1
  %t124 = load i64, i64* %t123
  %t125 = getelementptr [1 x %Statement], [1 x %Statement]* null, i32 0, i32 1
  %t126 = ptrtoint %Statement* %t125 to i64
  %t127 = add i64 %t120, %t124
  %t128 = mul i64 %t126, %t127
  %t129 = call noalias i8* @malloc(i64 %t128)
  %t130 = bitcast i8* %t129 to %Statement*
  %t131 = bitcast %Statement* %t130 to i8*
  %t132 = mul i64 %t126, %t120
  %t133 = bitcast %Statement* %t118 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t131, i8* %t133, i64 %t132)
  %t134 = mul i64 %t126, %t124
  %t135 = bitcast %Statement* %t122 to i8*
  %t136 = getelementptr %Statement, %Statement* %t130, i64 %t120
  %t137 = bitcast %Statement* %t136 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t137, i8* %t135, i64 %t134)
  %t138 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* null, i32 1
  %t139 = ptrtoint { %Statement*, i64 }* %t138 to i64
  %t140 = call i8* @malloc(i64 %t139)
  %t141 = bitcast i8* %t140 to { %Statement*, i64 }*
  %t142 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t141, i32 0, i32 0
  store %Statement* %t130, %Statement** %t142
  %t143 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t141, i32 0, i32 1
  store i64 %t127, i64* %t143
  store { %Statement*, i64 }* %t141, { %Statement*, i64 }** %l0
  %t144 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  br label %merge5
merge5:
  %t145 = phi { %Statement*, i64 }* [ %t144, %then4 ], [ %t100, %forbody1 ]
  store { %Statement*, i64 }* %t145, { %Statement*, i64 }** %l0
  br label %forinc2
forinc2:
  %t146 = load i64, i64* %l1
  %t147 = add i64 %t146, 1
  store i64 %t147, i64* %l1
  br label %for0
afterfor3:
  %t148 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  %t149 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  ret { %Statement*, i64 }* %t149
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
  %t62 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t0, 20
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t0, 21
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t0, 22
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t0, 23
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = call i8* @malloc(i64 20)
  %t75 = bitcast i8* %t74 to [20 x i8]*
  store [20 x i8] c"FunctionDeclaration\00", [20 x i8]* %t75
  %t76 = call i1 @strings_equal(i8* %t73, i8* %t74)
  br i1 %t76, label %then0, label %merge1
then0:
  %t77 = extractvalue %Statement %statement, 0
  %t78 = alloca %Statement
  store %Statement %statement, %Statement* %t78
  %t79 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t80 = bitcast [88 x i8]* %t79 to i8*
  %t81 = bitcast i8* %t80 to %FunctionSignature*
  %t82 = load %FunctionSignature, %FunctionSignature* %t81
  %t83 = icmp eq i32 %t77, 4
  %t84 = select i1 %t83, %FunctionSignature %t82, %FunctionSignature zeroinitializer
  %t85 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t86 = bitcast [88 x i8]* %t85 to i8*
  %t87 = bitcast i8* %t86 to %FunctionSignature*
  %t88 = load %FunctionSignature, %FunctionSignature* %t87
  %t89 = icmp eq i32 %t77, 5
  %t90 = select i1 %t89, %FunctionSignature %t88, %FunctionSignature %t84
  %t91 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t92 = bitcast [88 x i8]* %t91 to i8*
  %t93 = bitcast i8* %t92 to %FunctionSignature*
  %t94 = load %FunctionSignature, %FunctionSignature* %t93
  %t95 = icmp eq i32 %t77, 7
  %t96 = select i1 %t95, %FunctionSignature %t94, %FunctionSignature %t90
  %t97 = extractvalue %FunctionSignature %t96, 0
  %t98 = call i8* @malloc(i64 9)
  %t99 = bitcast i8* %t98 to [9 x i8]*
  store [9 x i8] c"function\00", [9 x i8]* %t99
  %t100 = extractvalue %Statement %statement, 0
  %t101 = alloca %Statement
  store %Statement %statement, %Statement* %t101
  %t102 = getelementptr inbounds %Statement, %Statement* %t101, i32 0, i32 1
  %t103 = bitcast [88 x i8]* %t102 to i8*
  %t104 = bitcast i8* %t103 to %FunctionSignature*
  %t105 = load %FunctionSignature, %FunctionSignature* %t104
  %t106 = icmp eq i32 %t100, 4
  %t107 = select i1 %t106, %FunctionSignature %t105, %FunctionSignature zeroinitializer
  %t108 = getelementptr inbounds %Statement, %Statement* %t101, i32 0, i32 1
  %t109 = bitcast [88 x i8]* %t108 to i8*
  %t110 = bitcast i8* %t109 to %FunctionSignature*
  %t111 = load %FunctionSignature, %FunctionSignature* %t110
  %t112 = icmp eq i32 %t100, 5
  %t113 = select i1 %t112, %FunctionSignature %t111, %FunctionSignature %t107
  %t114 = getelementptr inbounds %Statement, %Statement* %t101, i32 0, i32 1
  %t115 = bitcast [88 x i8]* %t114 to i8*
  %t116 = bitcast i8* %t115 to %FunctionSignature*
  %t117 = load %FunctionSignature, %FunctionSignature* %t116
  %t118 = icmp eq i32 %t100, 7
  %t119 = select i1 %t118, %FunctionSignature %t117, %FunctionSignature %t113
  %t120 = extractvalue %FunctionSignature %t119, 6
  %t121 = call %SymbolCollectionResult @register_symbol(i8* %t97, i8* %t98, %SourceSpan* %t120, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t121
merge1:
  %t122 = extractvalue %Statement %statement, 0
  %t123 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t124 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t125 = icmp eq i32 %t122, 0
  %t126 = select i1 %t125, i8* %t124, i8* %t123
  %t127 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t128 = icmp eq i32 %t122, 1
  %t129 = select i1 %t128, i8* %t127, i8* %t126
  %t130 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t131 = icmp eq i32 %t122, 2
  %t132 = select i1 %t131, i8* %t130, i8* %t129
  %t133 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t134 = icmp eq i32 %t122, 3
  %t135 = select i1 %t134, i8* %t133, i8* %t132
  %t136 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t122, 4
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t122, 5
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t122, 6
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t122, 7
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t122, 8
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t122, 9
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t122, 10
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t122, 11
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %t160 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t161 = icmp eq i32 %t122, 12
  %t162 = select i1 %t161, i8* %t160, i8* %t159
  %t163 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t164 = icmp eq i32 %t122, 13
  %t165 = select i1 %t164, i8* %t163, i8* %t162
  %t166 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t167 = icmp eq i32 %t122, 14
  %t168 = select i1 %t167, i8* %t166, i8* %t165
  %t169 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t170 = icmp eq i32 %t122, 15
  %t171 = select i1 %t170, i8* %t169, i8* %t168
  %t172 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t173 = icmp eq i32 %t122, 16
  %t174 = select i1 %t173, i8* %t172, i8* %t171
  %t175 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t176 = icmp eq i32 %t122, 17
  %t177 = select i1 %t176, i8* %t175, i8* %t174
  %t178 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t179 = icmp eq i32 %t122, 18
  %t180 = select i1 %t179, i8* %t178, i8* %t177
  %t181 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t182 = icmp eq i32 %t122, 19
  %t183 = select i1 %t182, i8* %t181, i8* %t180
  %t184 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t185 = icmp eq i32 %t122, 20
  %t186 = select i1 %t185, i8* %t184, i8* %t183
  %t187 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t188 = icmp eq i32 %t122, 21
  %t189 = select i1 %t188, i8* %t187, i8* %t186
  %t190 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t191 = icmp eq i32 %t122, 22
  %t192 = select i1 %t191, i8* %t190, i8* %t189
  %t193 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t194 = icmp eq i32 %t122, 23
  %t195 = select i1 %t194, i8* %t193, i8* %t192
  %t196 = call i8* @malloc(i64 18)
  %t197 = bitcast i8* %t196 to [18 x i8]*
  store [18 x i8] c"StructDeclaration\00", [18 x i8]* %t197
  %t198 = call i1 @strings_equal(i8* %t195, i8* %t196)
  br i1 %t198, label %then2, label %merge3
then2:
  %t199 = extractvalue %Statement %statement, 0
  %t200 = alloca %Statement
  store %Statement %statement, %Statement* %t200
  %t201 = getelementptr inbounds %Statement, %Statement* %t200, i32 0, i32 1
  %t202 = bitcast [48 x i8]* %t201 to i8*
  %t203 = bitcast i8* %t202 to i8**
  %t204 = load i8*, i8** %t203
  %t205 = icmp eq i32 %t199, 2
  %t206 = select i1 %t205, i8* %t204, i8* null
  %t207 = getelementptr inbounds %Statement, %Statement* %t200, i32 0, i32 1
  %t208 = bitcast [48 x i8]* %t207 to i8*
  %t209 = bitcast i8* %t208 to i8**
  %t210 = load i8*, i8** %t209
  %t211 = icmp eq i32 %t199, 3
  %t212 = select i1 %t211, i8* %t210, i8* %t206
  %t213 = getelementptr inbounds %Statement, %Statement* %t200, i32 0, i32 1
  %t214 = bitcast [56 x i8]* %t213 to i8*
  %t215 = bitcast i8* %t214 to i8**
  %t216 = load i8*, i8** %t215
  %t217 = icmp eq i32 %t199, 6
  %t218 = select i1 %t217, i8* %t216, i8* %t212
  %t219 = getelementptr inbounds %Statement, %Statement* %t200, i32 0, i32 1
  %t220 = bitcast [56 x i8]* %t219 to i8*
  %t221 = bitcast i8* %t220 to i8**
  %t222 = load i8*, i8** %t221
  %t223 = icmp eq i32 %t199, 8
  %t224 = select i1 %t223, i8* %t222, i8* %t218
  %t225 = getelementptr inbounds %Statement, %Statement* %t200, i32 0, i32 1
  %t226 = bitcast [40 x i8]* %t225 to i8*
  %t227 = bitcast i8* %t226 to i8**
  %t228 = load i8*, i8** %t227
  %t229 = icmp eq i32 %t199, 9
  %t230 = select i1 %t229, i8* %t228, i8* %t224
  %t231 = getelementptr inbounds %Statement, %Statement* %t200, i32 0, i32 1
  %t232 = bitcast [40 x i8]* %t231 to i8*
  %t233 = bitcast i8* %t232 to i8**
  %t234 = load i8*, i8** %t233
  %t235 = icmp eq i32 %t199, 10
  %t236 = select i1 %t235, i8* %t234, i8* %t230
  %t237 = getelementptr inbounds %Statement, %Statement* %t200, i32 0, i32 1
  %t238 = bitcast [40 x i8]* %t237 to i8*
  %t239 = bitcast i8* %t238 to i8**
  %t240 = load i8*, i8** %t239
  %t241 = icmp eq i32 %t199, 11
  %t242 = select i1 %t241, i8* %t240, i8* %t236
  %t243 = call i8* @malloc(i64 7)
  %t244 = bitcast i8* %t243 to [7 x i8]*
  store [7 x i8] c"struct\00", [7 x i8]* %t244
  %t245 = extractvalue %Statement %statement, 0
  %t246 = alloca %Statement
  store %Statement %statement, %Statement* %t246
  %t247 = getelementptr inbounds %Statement, %Statement* %t246, i32 0, i32 1
  %t248 = bitcast [48 x i8]* %t247 to i8*
  %t249 = getelementptr inbounds i8, i8* %t248, i64 8
  %t250 = bitcast i8* %t249 to %SourceSpan**
  %t251 = load %SourceSpan*, %SourceSpan** %t250
  %t252 = icmp eq i32 %t245, 3
  %t253 = select i1 %t252, %SourceSpan* %t251, %SourceSpan* null
  %t254 = getelementptr inbounds %Statement, %Statement* %t246, i32 0, i32 1
  %t255 = bitcast [56 x i8]* %t254 to i8*
  %t256 = getelementptr inbounds i8, i8* %t255, i64 8
  %t257 = bitcast i8* %t256 to %SourceSpan**
  %t258 = load %SourceSpan*, %SourceSpan** %t257
  %t259 = icmp eq i32 %t245, 6
  %t260 = select i1 %t259, %SourceSpan* %t258, %SourceSpan* %t253
  %t261 = getelementptr inbounds %Statement, %Statement* %t246, i32 0, i32 1
  %t262 = bitcast [56 x i8]* %t261 to i8*
  %t263 = getelementptr inbounds i8, i8* %t262, i64 8
  %t264 = bitcast i8* %t263 to %SourceSpan**
  %t265 = load %SourceSpan*, %SourceSpan** %t264
  %t266 = icmp eq i32 %t245, 8
  %t267 = select i1 %t266, %SourceSpan* %t265, %SourceSpan* %t260
  %t268 = getelementptr inbounds %Statement, %Statement* %t246, i32 0, i32 1
  %t269 = bitcast [40 x i8]* %t268 to i8*
  %t270 = getelementptr inbounds i8, i8* %t269, i64 8
  %t271 = bitcast i8* %t270 to %SourceSpan**
  %t272 = load %SourceSpan*, %SourceSpan** %t271
  %t273 = icmp eq i32 %t245, 9
  %t274 = select i1 %t273, %SourceSpan* %t272, %SourceSpan* %t267
  %t275 = getelementptr inbounds %Statement, %Statement* %t246, i32 0, i32 1
  %t276 = bitcast [40 x i8]* %t275 to i8*
  %t277 = getelementptr inbounds i8, i8* %t276, i64 8
  %t278 = bitcast i8* %t277 to %SourceSpan**
  %t279 = load %SourceSpan*, %SourceSpan** %t278
  %t280 = icmp eq i32 %t245, 10
  %t281 = select i1 %t280, %SourceSpan* %t279, %SourceSpan* %t274
  %t282 = getelementptr inbounds %Statement, %Statement* %t246, i32 0, i32 1
  %t283 = bitcast [40 x i8]* %t282 to i8*
  %t284 = getelementptr inbounds i8, i8* %t283, i64 8
  %t285 = bitcast i8* %t284 to %SourceSpan**
  %t286 = load %SourceSpan*, %SourceSpan** %t285
  %t287 = icmp eq i32 %t245, 11
  %t288 = select i1 %t287, %SourceSpan* %t286, %SourceSpan* %t281
  %t289 = call %SymbolCollectionResult @register_symbol(i8* %t242, i8* %t243, %SourceSpan* %t288, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t289
merge3:
  %t290 = extractvalue %Statement %statement, 0
  %t291 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t292 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t293 = icmp eq i32 %t290, 0
  %t294 = select i1 %t293, i8* %t292, i8* %t291
  %t295 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t296 = icmp eq i32 %t290, 1
  %t297 = select i1 %t296, i8* %t295, i8* %t294
  %t298 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t299 = icmp eq i32 %t290, 2
  %t300 = select i1 %t299, i8* %t298, i8* %t297
  %t301 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t302 = icmp eq i32 %t290, 3
  %t303 = select i1 %t302, i8* %t301, i8* %t300
  %t304 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t305 = icmp eq i32 %t290, 4
  %t306 = select i1 %t305, i8* %t304, i8* %t303
  %t307 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t308 = icmp eq i32 %t290, 5
  %t309 = select i1 %t308, i8* %t307, i8* %t306
  %t310 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t311 = icmp eq i32 %t290, 6
  %t312 = select i1 %t311, i8* %t310, i8* %t309
  %t313 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t314 = icmp eq i32 %t290, 7
  %t315 = select i1 %t314, i8* %t313, i8* %t312
  %t316 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t317 = icmp eq i32 %t290, 8
  %t318 = select i1 %t317, i8* %t316, i8* %t315
  %t319 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t320 = icmp eq i32 %t290, 9
  %t321 = select i1 %t320, i8* %t319, i8* %t318
  %t322 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t323 = icmp eq i32 %t290, 10
  %t324 = select i1 %t323, i8* %t322, i8* %t321
  %t325 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t326 = icmp eq i32 %t290, 11
  %t327 = select i1 %t326, i8* %t325, i8* %t324
  %t328 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t329 = icmp eq i32 %t290, 12
  %t330 = select i1 %t329, i8* %t328, i8* %t327
  %t331 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t332 = icmp eq i32 %t290, 13
  %t333 = select i1 %t332, i8* %t331, i8* %t330
  %t334 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t335 = icmp eq i32 %t290, 14
  %t336 = select i1 %t335, i8* %t334, i8* %t333
  %t337 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t338 = icmp eq i32 %t290, 15
  %t339 = select i1 %t338, i8* %t337, i8* %t336
  %t340 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t341 = icmp eq i32 %t290, 16
  %t342 = select i1 %t341, i8* %t340, i8* %t339
  %t343 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t344 = icmp eq i32 %t290, 17
  %t345 = select i1 %t344, i8* %t343, i8* %t342
  %t346 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t347 = icmp eq i32 %t290, 18
  %t348 = select i1 %t347, i8* %t346, i8* %t345
  %t349 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t350 = icmp eq i32 %t290, 19
  %t351 = select i1 %t350, i8* %t349, i8* %t348
  %t352 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t353 = icmp eq i32 %t290, 20
  %t354 = select i1 %t353, i8* %t352, i8* %t351
  %t355 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t356 = icmp eq i32 %t290, 21
  %t357 = select i1 %t356, i8* %t355, i8* %t354
  %t358 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t359 = icmp eq i32 %t290, 22
  %t360 = select i1 %t359, i8* %t358, i8* %t357
  %t361 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t362 = icmp eq i32 %t290, 23
  %t363 = select i1 %t362, i8* %t361, i8* %t360
  %t364 = call i8* @malloc(i64 16)
  %t365 = bitcast i8* %t364 to [16 x i8]*
  store [16 x i8] c"EnumDeclaration\00", [16 x i8]* %t365
  %t366 = call i1 @strings_equal(i8* %t363, i8* %t364)
  br i1 %t366, label %then4, label %merge5
then4:
  %t367 = extractvalue %Statement %statement, 0
  %t368 = alloca %Statement
  store %Statement %statement, %Statement* %t368
  %t369 = getelementptr inbounds %Statement, %Statement* %t368, i32 0, i32 1
  %t370 = bitcast [48 x i8]* %t369 to i8*
  %t371 = bitcast i8* %t370 to i8**
  %t372 = load i8*, i8** %t371
  %t373 = icmp eq i32 %t367, 2
  %t374 = select i1 %t373, i8* %t372, i8* null
  %t375 = getelementptr inbounds %Statement, %Statement* %t368, i32 0, i32 1
  %t376 = bitcast [48 x i8]* %t375 to i8*
  %t377 = bitcast i8* %t376 to i8**
  %t378 = load i8*, i8** %t377
  %t379 = icmp eq i32 %t367, 3
  %t380 = select i1 %t379, i8* %t378, i8* %t374
  %t381 = getelementptr inbounds %Statement, %Statement* %t368, i32 0, i32 1
  %t382 = bitcast [56 x i8]* %t381 to i8*
  %t383 = bitcast i8* %t382 to i8**
  %t384 = load i8*, i8** %t383
  %t385 = icmp eq i32 %t367, 6
  %t386 = select i1 %t385, i8* %t384, i8* %t380
  %t387 = getelementptr inbounds %Statement, %Statement* %t368, i32 0, i32 1
  %t388 = bitcast [56 x i8]* %t387 to i8*
  %t389 = bitcast i8* %t388 to i8**
  %t390 = load i8*, i8** %t389
  %t391 = icmp eq i32 %t367, 8
  %t392 = select i1 %t391, i8* %t390, i8* %t386
  %t393 = getelementptr inbounds %Statement, %Statement* %t368, i32 0, i32 1
  %t394 = bitcast [40 x i8]* %t393 to i8*
  %t395 = bitcast i8* %t394 to i8**
  %t396 = load i8*, i8** %t395
  %t397 = icmp eq i32 %t367, 9
  %t398 = select i1 %t397, i8* %t396, i8* %t392
  %t399 = getelementptr inbounds %Statement, %Statement* %t368, i32 0, i32 1
  %t400 = bitcast [40 x i8]* %t399 to i8*
  %t401 = bitcast i8* %t400 to i8**
  %t402 = load i8*, i8** %t401
  %t403 = icmp eq i32 %t367, 10
  %t404 = select i1 %t403, i8* %t402, i8* %t398
  %t405 = getelementptr inbounds %Statement, %Statement* %t368, i32 0, i32 1
  %t406 = bitcast [40 x i8]* %t405 to i8*
  %t407 = bitcast i8* %t406 to i8**
  %t408 = load i8*, i8** %t407
  %t409 = icmp eq i32 %t367, 11
  %t410 = select i1 %t409, i8* %t408, i8* %t404
  %t411 = call i8* @malloc(i64 5)
  %t412 = bitcast i8* %t411 to [5 x i8]*
  store [5 x i8] c"enum\00", [5 x i8]* %t412
  %t413 = extractvalue %Statement %statement, 0
  %t414 = alloca %Statement
  store %Statement %statement, %Statement* %t414
  %t415 = getelementptr inbounds %Statement, %Statement* %t414, i32 0, i32 1
  %t416 = bitcast [48 x i8]* %t415 to i8*
  %t417 = getelementptr inbounds i8, i8* %t416, i64 8
  %t418 = bitcast i8* %t417 to %SourceSpan**
  %t419 = load %SourceSpan*, %SourceSpan** %t418
  %t420 = icmp eq i32 %t413, 3
  %t421 = select i1 %t420, %SourceSpan* %t419, %SourceSpan* null
  %t422 = getelementptr inbounds %Statement, %Statement* %t414, i32 0, i32 1
  %t423 = bitcast [56 x i8]* %t422 to i8*
  %t424 = getelementptr inbounds i8, i8* %t423, i64 8
  %t425 = bitcast i8* %t424 to %SourceSpan**
  %t426 = load %SourceSpan*, %SourceSpan** %t425
  %t427 = icmp eq i32 %t413, 6
  %t428 = select i1 %t427, %SourceSpan* %t426, %SourceSpan* %t421
  %t429 = getelementptr inbounds %Statement, %Statement* %t414, i32 0, i32 1
  %t430 = bitcast [56 x i8]* %t429 to i8*
  %t431 = getelementptr inbounds i8, i8* %t430, i64 8
  %t432 = bitcast i8* %t431 to %SourceSpan**
  %t433 = load %SourceSpan*, %SourceSpan** %t432
  %t434 = icmp eq i32 %t413, 8
  %t435 = select i1 %t434, %SourceSpan* %t433, %SourceSpan* %t428
  %t436 = getelementptr inbounds %Statement, %Statement* %t414, i32 0, i32 1
  %t437 = bitcast [40 x i8]* %t436 to i8*
  %t438 = getelementptr inbounds i8, i8* %t437, i64 8
  %t439 = bitcast i8* %t438 to %SourceSpan**
  %t440 = load %SourceSpan*, %SourceSpan** %t439
  %t441 = icmp eq i32 %t413, 9
  %t442 = select i1 %t441, %SourceSpan* %t440, %SourceSpan* %t435
  %t443 = getelementptr inbounds %Statement, %Statement* %t414, i32 0, i32 1
  %t444 = bitcast [40 x i8]* %t443 to i8*
  %t445 = getelementptr inbounds i8, i8* %t444, i64 8
  %t446 = bitcast i8* %t445 to %SourceSpan**
  %t447 = load %SourceSpan*, %SourceSpan** %t446
  %t448 = icmp eq i32 %t413, 10
  %t449 = select i1 %t448, %SourceSpan* %t447, %SourceSpan* %t442
  %t450 = getelementptr inbounds %Statement, %Statement* %t414, i32 0, i32 1
  %t451 = bitcast [40 x i8]* %t450 to i8*
  %t452 = getelementptr inbounds i8, i8* %t451, i64 8
  %t453 = bitcast i8* %t452 to %SourceSpan**
  %t454 = load %SourceSpan*, %SourceSpan** %t453
  %t455 = icmp eq i32 %t413, 11
  %t456 = select i1 %t455, %SourceSpan* %t454, %SourceSpan* %t449
  %t457 = call %SymbolCollectionResult @register_symbol(i8* %t410, i8* %t411, %SourceSpan* %t456, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t457
merge5:
  %t458 = extractvalue %Statement %statement, 0
  %t459 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t460 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t461 = icmp eq i32 %t458, 0
  %t462 = select i1 %t461, i8* %t460, i8* %t459
  %t463 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t464 = icmp eq i32 %t458, 1
  %t465 = select i1 %t464, i8* %t463, i8* %t462
  %t466 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t467 = icmp eq i32 %t458, 2
  %t468 = select i1 %t467, i8* %t466, i8* %t465
  %t469 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t470 = icmp eq i32 %t458, 3
  %t471 = select i1 %t470, i8* %t469, i8* %t468
  %t472 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t473 = icmp eq i32 %t458, 4
  %t474 = select i1 %t473, i8* %t472, i8* %t471
  %t475 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t476 = icmp eq i32 %t458, 5
  %t477 = select i1 %t476, i8* %t475, i8* %t474
  %t478 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t479 = icmp eq i32 %t458, 6
  %t480 = select i1 %t479, i8* %t478, i8* %t477
  %t481 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t482 = icmp eq i32 %t458, 7
  %t483 = select i1 %t482, i8* %t481, i8* %t480
  %t484 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t485 = icmp eq i32 %t458, 8
  %t486 = select i1 %t485, i8* %t484, i8* %t483
  %t487 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t488 = icmp eq i32 %t458, 9
  %t489 = select i1 %t488, i8* %t487, i8* %t486
  %t490 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t491 = icmp eq i32 %t458, 10
  %t492 = select i1 %t491, i8* %t490, i8* %t489
  %t493 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t494 = icmp eq i32 %t458, 11
  %t495 = select i1 %t494, i8* %t493, i8* %t492
  %t496 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t497 = icmp eq i32 %t458, 12
  %t498 = select i1 %t497, i8* %t496, i8* %t495
  %t499 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t500 = icmp eq i32 %t458, 13
  %t501 = select i1 %t500, i8* %t499, i8* %t498
  %t502 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t503 = icmp eq i32 %t458, 14
  %t504 = select i1 %t503, i8* %t502, i8* %t501
  %t505 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t506 = icmp eq i32 %t458, 15
  %t507 = select i1 %t506, i8* %t505, i8* %t504
  %t508 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t509 = icmp eq i32 %t458, 16
  %t510 = select i1 %t509, i8* %t508, i8* %t507
  %t511 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t512 = icmp eq i32 %t458, 17
  %t513 = select i1 %t512, i8* %t511, i8* %t510
  %t514 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t515 = icmp eq i32 %t458, 18
  %t516 = select i1 %t515, i8* %t514, i8* %t513
  %t517 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t518 = icmp eq i32 %t458, 19
  %t519 = select i1 %t518, i8* %t517, i8* %t516
  %t520 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t521 = icmp eq i32 %t458, 20
  %t522 = select i1 %t521, i8* %t520, i8* %t519
  %t523 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t524 = icmp eq i32 %t458, 21
  %t525 = select i1 %t524, i8* %t523, i8* %t522
  %t526 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t527 = icmp eq i32 %t458, 22
  %t528 = select i1 %t527, i8* %t526, i8* %t525
  %t529 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t530 = icmp eq i32 %t458, 23
  %t531 = select i1 %t530, i8* %t529, i8* %t528
  %t532 = call i8* @malloc(i64 21)
  %t533 = bitcast i8* %t532 to [21 x i8]*
  store [21 x i8] c"InterfaceDeclaration\00", [21 x i8]* %t533
  %t534 = call i1 @strings_equal(i8* %t531, i8* %t532)
  br i1 %t534, label %then6, label %merge7
then6:
  %t535 = extractvalue %Statement %statement, 0
  %t536 = alloca %Statement
  store %Statement %statement, %Statement* %t536
  %t537 = getelementptr inbounds %Statement, %Statement* %t536, i32 0, i32 1
  %t538 = bitcast [48 x i8]* %t537 to i8*
  %t539 = bitcast i8* %t538 to i8**
  %t540 = load i8*, i8** %t539
  %t541 = icmp eq i32 %t535, 2
  %t542 = select i1 %t541, i8* %t540, i8* null
  %t543 = getelementptr inbounds %Statement, %Statement* %t536, i32 0, i32 1
  %t544 = bitcast [48 x i8]* %t543 to i8*
  %t545 = bitcast i8* %t544 to i8**
  %t546 = load i8*, i8** %t545
  %t547 = icmp eq i32 %t535, 3
  %t548 = select i1 %t547, i8* %t546, i8* %t542
  %t549 = getelementptr inbounds %Statement, %Statement* %t536, i32 0, i32 1
  %t550 = bitcast [56 x i8]* %t549 to i8*
  %t551 = bitcast i8* %t550 to i8**
  %t552 = load i8*, i8** %t551
  %t553 = icmp eq i32 %t535, 6
  %t554 = select i1 %t553, i8* %t552, i8* %t548
  %t555 = getelementptr inbounds %Statement, %Statement* %t536, i32 0, i32 1
  %t556 = bitcast [56 x i8]* %t555 to i8*
  %t557 = bitcast i8* %t556 to i8**
  %t558 = load i8*, i8** %t557
  %t559 = icmp eq i32 %t535, 8
  %t560 = select i1 %t559, i8* %t558, i8* %t554
  %t561 = getelementptr inbounds %Statement, %Statement* %t536, i32 0, i32 1
  %t562 = bitcast [40 x i8]* %t561 to i8*
  %t563 = bitcast i8* %t562 to i8**
  %t564 = load i8*, i8** %t563
  %t565 = icmp eq i32 %t535, 9
  %t566 = select i1 %t565, i8* %t564, i8* %t560
  %t567 = getelementptr inbounds %Statement, %Statement* %t536, i32 0, i32 1
  %t568 = bitcast [40 x i8]* %t567 to i8*
  %t569 = bitcast i8* %t568 to i8**
  %t570 = load i8*, i8** %t569
  %t571 = icmp eq i32 %t535, 10
  %t572 = select i1 %t571, i8* %t570, i8* %t566
  %t573 = getelementptr inbounds %Statement, %Statement* %t536, i32 0, i32 1
  %t574 = bitcast [40 x i8]* %t573 to i8*
  %t575 = bitcast i8* %t574 to i8**
  %t576 = load i8*, i8** %t575
  %t577 = icmp eq i32 %t535, 11
  %t578 = select i1 %t577, i8* %t576, i8* %t572
  %t579 = call i8* @malloc(i64 10)
  %t580 = bitcast i8* %t579 to [10 x i8]*
  store [10 x i8] c"interface\00", [10 x i8]* %t580
  %t581 = extractvalue %Statement %statement, 0
  %t582 = alloca %Statement
  store %Statement %statement, %Statement* %t582
  %t583 = getelementptr inbounds %Statement, %Statement* %t582, i32 0, i32 1
  %t584 = bitcast [48 x i8]* %t583 to i8*
  %t585 = getelementptr inbounds i8, i8* %t584, i64 8
  %t586 = bitcast i8* %t585 to %SourceSpan**
  %t587 = load %SourceSpan*, %SourceSpan** %t586
  %t588 = icmp eq i32 %t581, 3
  %t589 = select i1 %t588, %SourceSpan* %t587, %SourceSpan* null
  %t590 = getelementptr inbounds %Statement, %Statement* %t582, i32 0, i32 1
  %t591 = bitcast [56 x i8]* %t590 to i8*
  %t592 = getelementptr inbounds i8, i8* %t591, i64 8
  %t593 = bitcast i8* %t592 to %SourceSpan**
  %t594 = load %SourceSpan*, %SourceSpan** %t593
  %t595 = icmp eq i32 %t581, 6
  %t596 = select i1 %t595, %SourceSpan* %t594, %SourceSpan* %t589
  %t597 = getelementptr inbounds %Statement, %Statement* %t582, i32 0, i32 1
  %t598 = bitcast [56 x i8]* %t597 to i8*
  %t599 = getelementptr inbounds i8, i8* %t598, i64 8
  %t600 = bitcast i8* %t599 to %SourceSpan**
  %t601 = load %SourceSpan*, %SourceSpan** %t600
  %t602 = icmp eq i32 %t581, 8
  %t603 = select i1 %t602, %SourceSpan* %t601, %SourceSpan* %t596
  %t604 = getelementptr inbounds %Statement, %Statement* %t582, i32 0, i32 1
  %t605 = bitcast [40 x i8]* %t604 to i8*
  %t606 = getelementptr inbounds i8, i8* %t605, i64 8
  %t607 = bitcast i8* %t606 to %SourceSpan**
  %t608 = load %SourceSpan*, %SourceSpan** %t607
  %t609 = icmp eq i32 %t581, 9
  %t610 = select i1 %t609, %SourceSpan* %t608, %SourceSpan* %t603
  %t611 = getelementptr inbounds %Statement, %Statement* %t582, i32 0, i32 1
  %t612 = bitcast [40 x i8]* %t611 to i8*
  %t613 = getelementptr inbounds i8, i8* %t612, i64 8
  %t614 = bitcast i8* %t613 to %SourceSpan**
  %t615 = load %SourceSpan*, %SourceSpan** %t614
  %t616 = icmp eq i32 %t581, 10
  %t617 = select i1 %t616, %SourceSpan* %t615, %SourceSpan* %t610
  %t618 = getelementptr inbounds %Statement, %Statement* %t582, i32 0, i32 1
  %t619 = bitcast [40 x i8]* %t618 to i8*
  %t620 = getelementptr inbounds i8, i8* %t619, i64 8
  %t621 = bitcast i8* %t620 to %SourceSpan**
  %t622 = load %SourceSpan*, %SourceSpan** %t621
  %t623 = icmp eq i32 %t581, 11
  %t624 = select i1 %t623, %SourceSpan* %t622, %SourceSpan* %t617
  %t625 = call %SymbolCollectionResult @register_symbol(i8* %t578, i8* %t579, %SourceSpan* %t624, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t625
merge7:
  %t626 = extractvalue %Statement %statement, 0
  %t627 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t628 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t629 = icmp eq i32 %t626, 0
  %t630 = select i1 %t629, i8* %t628, i8* %t627
  %t631 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t632 = icmp eq i32 %t626, 1
  %t633 = select i1 %t632, i8* %t631, i8* %t630
  %t634 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t635 = icmp eq i32 %t626, 2
  %t636 = select i1 %t635, i8* %t634, i8* %t633
  %t637 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t638 = icmp eq i32 %t626, 3
  %t639 = select i1 %t638, i8* %t637, i8* %t636
  %t640 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t641 = icmp eq i32 %t626, 4
  %t642 = select i1 %t641, i8* %t640, i8* %t639
  %t643 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t644 = icmp eq i32 %t626, 5
  %t645 = select i1 %t644, i8* %t643, i8* %t642
  %t646 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t647 = icmp eq i32 %t626, 6
  %t648 = select i1 %t647, i8* %t646, i8* %t645
  %t649 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t650 = icmp eq i32 %t626, 7
  %t651 = select i1 %t650, i8* %t649, i8* %t648
  %t652 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t653 = icmp eq i32 %t626, 8
  %t654 = select i1 %t653, i8* %t652, i8* %t651
  %t655 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t656 = icmp eq i32 %t626, 9
  %t657 = select i1 %t656, i8* %t655, i8* %t654
  %t658 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t659 = icmp eq i32 %t626, 10
  %t660 = select i1 %t659, i8* %t658, i8* %t657
  %t661 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t662 = icmp eq i32 %t626, 11
  %t663 = select i1 %t662, i8* %t661, i8* %t660
  %t664 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t665 = icmp eq i32 %t626, 12
  %t666 = select i1 %t665, i8* %t664, i8* %t663
  %t667 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t668 = icmp eq i32 %t626, 13
  %t669 = select i1 %t668, i8* %t667, i8* %t666
  %t670 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t671 = icmp eq i32 %t626, 14
  %t672 = select i1 %t671, i8* %t670, i8* %t669
  %t673 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t674 = icmp eq i32 %t626, 15
  %t675 = select i1 %t674, i8* %t673, i8* %t672
  %t676 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t677 = icmp eq i32 %t626, 16
  %t678 = select i1 %t677, i8* %t676, i8* %t675
  %t679 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t680 = icmp eq i32 %t626, 17
  %t681 = select i1 %t680, i8* %t679, i8* %t678
  %t682 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t683 = icmp eq i32 %t626, 18
  %t684 = select i1 %t683, i8* %t682, i8* %t681
  %t685 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t686 = icmp eq i32 %t626, 19
  %t687 = select i1 %t686, i8* %t685, i8* %t684
  %t688 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t689 = icmp eq i32 %t626, 20
  %t690 = select i1 %t689, i8* %t688, i8* %t687
  %t691 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t692 = icmp eq i32 %t626, 21
  %t693 = select i1 %t692, i8* %t691, i8* %t690
  %t694 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t695 = icmp eq i32 %t626, 22
  %t696 = select i1 %t695, i8* %t694, i8* %t693
  %t697 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t698 = icmp eq i32 %t626, 23
  %t699 = select i1 %t698, i8* %t697, i8* %t696
  %t700 = call i8* @malloc(i64 17)
  %t701 = bitcast i8* %t700 to [17 x i8]*
  store [17 x i8] c"ModelDeclaration\00", [17 x i8]* %t701
  %t702 = call i1 @strings_equal(i8* %t699, i8* %t700)
  br i1 %t702, label %then8, label %merge9
then8:
  %t703 = extractvalue %Statement %statement, 0
  %t704 = alloca %Statement
  store %Statement %statement, %Statement* %t704
  %t705 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t706 = bitcast [48 x i8]* %t705 to i8*
  %t707 = bitcast i8* %t706 to i8**
  %t708 = load i8*, i8** %t707
  %t709 = icmp eq i32 %t703, 2
  %t710 = select i1 %t709, i8* %t708, i8* null
  %t711 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t712 = bitcast [48 x i8]* %t711 to i8*
  %t713 = bitcast i8* %t712 to i8**
  %t714 = load i8*, i8** %t713
  %t715 = icmp eq i32 %t703, 3
  %t716 = select i1 %t715, i8* %t714, i8* %t710
  %t717 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t718 = bitcast [56 x i8]* %t717 to i8*
  %t719 = bitcast i8* %t718 to i8**
  %t720 = load i8*, i8** %t719
  %t721 = icmp eq i32 %t703, 6
  %t722 = select i1 %t721, i8* %t720, i8* %t716
  %t723 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t724 = bitcast [56 x i8]* %t723 to i8*
  %t725 = bitcast i8* %t724 to i8**
  %t726 = load i8*, i8** %t725
  %t727 = icmp eq i32 %t703, 8
  %t728 = select i1 %t727, i8* %t726, i8* %t722
  %t729 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t730 = bitcast [40 x i8]* %t729 to i8*
  %t731 = bitcast i8* %t730 to i8**
  %t732 = load i8*, i8** %t731
  %t733 = icmp eq i32 %t703, 9
  %t734 = select i1 %t733, i8* %t732, i8* %t728
  %t735 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t736 = bitcast [40 x i8]* %t735 to i8*
  %t737 = bitcast i8* %t736 to i8**
  %t738 = load i8*, i8** %t737
  %t739 = icmp eq i32 %t703, 10
  %t740 = select i1 %t739, i8* %t738, i8* %t734
  %t741 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t742 = bitcast [40 x i8]* %t741 to i8*
  %t743 = bitcast i8* %t742 to i8**
  %t744 = load i8*, i8** %t743
  %t745 = icmp eq i32 %t703, 11
  %t746 = select i1 %t745, i8* %t744, i8* %t740
  %t747 = call i8* @malloc(i64 6)
  %t748 = bitcast i8* %t747 to [6 x i8]*
  store [6 x i8] c"model\00", [6 x i8]* %t748
  %t749 = extractvalue %Statement %statement, 0
  %t750 = alloca %Statement
  store %Statement %statement, %Statement* %t750
  %t751 = getelementptr inbounds %Statement, %Statement* %t750, i32 0, i32 1
  %t752 = bitcast [48 x i8]* %t751 to i8*
  %t753 = getelementptr inbounds i8, i8* %t752, i64 8
  %t754 = bitcast i8* %t753 to %SourceSpan**
  %t755 = load %SourceSpan*, %SourceSpan** %t754
  %t756 = icmp eq i32 %t749, 3
  %t757 = select i1 %t756, %SourceSpan* %t755, %SourceSpan* null
  %t758 = getelementptr inbounds %Statement, %Statement* %t750, i32 0, i32 1
  %t759 = bitcast [56 x i8]* %t758 to i8*
  %t760 = getelementptr inbounds i8, i8* %t759, i64 8
  %t761 = bitcast i8* %t760 to %SourceSpan**
  %t762 = load %SourceSpan*, %SourceSpan** %t761
  %t763 = icmp eq i32 %t749, 6
  %t764 = select i1 %t763, %SourceSpan* %t762, %SourceSpan* %t757
  %t765 = getelementptr inbounds %Statement, %Statement* %t750, i32 0, i32 1
  %t766 = bitcast [56 x i8]* %t765 to i8*
  %t767 = getelementptr inbounds i8, i8* %t766, i64 8
  %t768 = bitcast i8* %t767 to %SourceSpan**
  %t769 = load %SourceSpan*, %SourceSpan** %t768
  %t770 = icmp eq i32 %t749, 8
  %t771 = select i1 %t770, %SourceSpan* %t769, %SourceSpan* %t764
  %t772 = getelementptr inbounds %Statement, %Statement* %t750, i32 0, i32 1
  %t773 = bitcast [40 x i8]* %t772 to i8*
  %t774 = getelementptr inbounds i8, i8* %t773, i64 8
  %t775 = bitcast i8* %t774 to %SourceSpan**
  %t776 = load %SourceSpan*, %SourceSpan** %t775
  %t777 = icmp eq i32 %t749, 9
  %t778 = select i1 %t777, %SourceSpan* %t776, %SourceSpan* %t771
  %t779 = getelementptr inbounds %Statement, %Statement* %t750, i32 0, i32 1
  %t780 = bitcast [40 x i8]* %t779 to i8*
  %t781 = getelementptr inbounds i8, i8* %t780, i64 8
  %t782 = bitcast i8* %t781 to %SourceSpan**
  %t783 = load %SourceSpan*, %SourceSpan** %t782
  %t784 = icmp eq i32 %t749, 10
  %t785 = select i1 %t784, %SourceSpan* %t783, %SourceSpan* %t778
  %t786 = getelementptr inbounds %Statement, %Statement* %t750, i32 0, i32 1
  %t787 = bitcast [40 x i8]* %t786 to i8*
  %t788 = getelementptr inbounds i8, i8* %t787, i64 8
  %t789 = bitcast i8* %t788 to %SourceSpan**
  %t790 = load %SourceSpan*, %SourceSpan** %t789
  %t791 = icmp eq i32 %t749, 11
  %t792 = select i1 %t791, %SourceSpan* %t790, %SourceSpan* %t785
  %t793 = call %SymbolCollectionResult @register_symbol(i8* %t746, i8* %t747, %SourceSpan* %t792, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t793
merge9:
  %t794 = extractvalue %Statement %statement, 0
  %t795 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t796 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t797 = icmp eq i32 %t794, 0
  %t798 = select i1 %t797, i8* %t796, i8* %t795
  %t799 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t800 = icmp eq i32 %t794, 1
  %t801 = select i1 %t800, i8* %t799, i8* %t798
  %t802 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t803 = icmp eq i32 %t794, 2
  %t804 = select i1 %t803, i8* %t802, i8* %t801
  %t805 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t806 = icmp eq i32 %t794, 3
  %t807 = select i1 %t806, i8* %t805, i8* %t804
  %t808 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t809 = icmp eq i32 %t794, 4
  %t810 = select i1 %t809, i8* %t808, i8* %t807
  %t811 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t812 = icmp eq i32 %t794, 5
  %t813 = select i1 %t812, i8* %t811, i8* %t810
  %t814 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t815 = icmp eq i32 %t794, 6
  %t816 = select i1 %t815, i8* %t814, i8* %t813
  %t817 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t818 = icmp eq i32 %t794, 7
  %t819 = select i1 %t818, i8* %t817, i8* %t816
  %t820 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t821 = icmp eq i32 %t794, 8
  %t822 = select i1 %t821, i8* %t820, i8* %t819
  %t823 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t824 = icmp eq i32 %t794, 9
  %t825 = select i1 %t824, i8* %t823, i8* %t822
  %t826 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t827 = icmp eq i32 %t794, 10
  %t828 = select i1 %t827, i8* %t826, i8* %t825
  %t829 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t830 = icmp eq i32 %t794, 11
  %t831 = select i1 %t830, i8* %t829, i8* %t828
  %t832 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t833 = icmp eq i32 %t794, 12
  %t834 = select i1 %t833, i8* %t832, i8* %t831
  %t835 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t836 = icmp eq i32 %t794, 13
  %t837 = select i1 %t836, i8* %t835, i8* %t834
  %t838 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t839 = icmp eq i32 %t794, 14
  %t840 = select i1 %t839, i8* %t838, i8* %t837
  %t841 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t842 = icmp eq i32 %t794, 15
  %t843 = select i1 %t842, i8* %t841, i8* %t840
  %t844 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t845 = icmp eq i32 %t794, 16
  %t846 = select i1 %t845, i8* %t844, i8* %t843
  %t847 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t848 = icmp eq i32 %t794, 17
  %t849 = select i1 %t848, i8* %t847, i8* %t846
  %t850 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t851 = icmp eq i32 %t794, 18
  %t852 = select i1 %t851, i8* %t850, i8* %t849
  %t853 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t854 = icmp eq i32 %t794, 19
  %t855 = select i1 %t854, i8* %t853, i8* %t852
  %t856 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t857 = icmp eq i32 %t794, 20
  %t858 = select i1 %t857, i8* %t856, i8* %t855
  %t859 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t860 = icmp eq i32 %t794, 21
  %t861 = select i1 %t860, i8* %t859, i8* %t858
  %t862 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t863 = icmp eq i32 %t794, 22
  %t864 = select i1 %t863, i8* %t862, i8* %t861
  %t865 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t866 = icmp eq i32 %t794, 23
  %t867 = select i1 %t866, i8* %t865, i8* %t864
  %t868 = call i8* @malloc(i64 20)
  %t869 = bitcast i8* %t868 to [20 x i8]*
  store [20 x i8] c"PipelineDeclaration\00", [20 x i8]* %t869
  %t870 = call i1 @strings_equal(i8* %t867, i8* %t868)
  br i1 %t870, label %then10, label %merge11
then10:
  %t871 = extractvalue %Statement %statement, 0
  %t872 = alloca %Statement
  store %Statement %statement, %Statement* %t872
  %t873 = getelementptr inbounds %Statement, %Statement* %t872, i32 0, i32 1
  %t874 = bitcast [88 x i8]* %t873 to i8*
  %t875 = bitcast i8* %t874 to %FunctionSignature*
  %t876 = load %FunctionSignature, %FunctionSignature* %t875
  %t877 = icmp eq i32 %t871, 4
  %t878 = select i1 %t877, %FunctionSignature %t876, %FunctionSignature zeroinitializer
  %t879 = getelementptr inbounds %Statement, %Statement* %t872, i32 0, i32 1
  %t880 = bitcast [88 x i8]* %t879 to i8*
  %t881 = bitcast i8* %t880 to %FunctionSignature*
  %t882 = load %FunctionSignature, %FunctionSignature* %t881
  %t883 = icmp eq i32 %t871, 5
  %t884 = select i1 %t883, %FunctionSignature %t882, %FunctionSignature %t878
  %t885 = getelementptr inbounds %Statement, %Statement* %t872, i32 0, i32 1
  %t886 = bitcast [88 x i8]* %t885 to i8*
  %t887 = bitcast i8* %t886 to %FunctionSignature*
  %t888 = load %FunctionSignature, %FunctionSignature* %t887
  %t889 = icmp eq i32 %t871, 7
  %t890 = select i1 %t889, %FunctionSignature %t888, %FunctionSignature %t884
  %t891 = extractvalue %FunctionSignature %t890, 0
  %t892 = call i8* @malloc(i64 9)
  %t893 = bitcast i8* %t892 to [9 x i8]*
  store [9 x i8] c"pipeline\00", [9 x i8]* %t893
  %t894 = extractvalue %Statement %statement, 0
  %t895 = alloca %Statement
  store %Statement %statement, %Statement* %t895
  %t896 = getelementptr inbounds %Statement, %Statement* %t895, i32 0, i32 1
  %t897 = bitcast [88 x i8]* %t896 to i8*
  %t898 = bitcast i8* %t897 to %FunctionSignature*
  %t899 = load %FunctionSignature, %FunctionSignature* %t898
  %t900 = icmp eq i32 %t894, 4
  %t901 = select i1 %t900, %FunctionSignature %t899, %FunctionSignature zeroinitializer
  %t902 = getelementptr inbounds %Statement, %Statement* %t895, i32 0, i32 1
  %t903 = bitcast [88 x i8]* %t902 to i8*
  %t904 = bitcast i8* %t903 to %FunctionSignature*
  %t905 = load %FunctionSignature, %FunctionSignature* %t904
  %t906 = icmp eq i32 %t894, 5
  %t907 = select i1 %t906, %FunctionSignature %t905, %FunctionSignature %t901
  %t908 = getelementptr inbounds %Statement, %Statement* %t895, i32 0, i32 1
  %t909 = bitcast [88 x i8]* %t908 to i8*
  %t910 = bitcast i8* %t909 to %FunctionSignature*
  %t911 = load %FunctionSignature, %FunctionSignature* %t910
  %t912 = icmp eq i32 %t894, 7
  %t913 = select i1 %t912, %FunctionSignature %t911, %FunctionSignature %t907
  %t914 = extractvalue %FunctionSignature %t913, 6
  %t915 = call %SymbolCollectionResult @register_symbol(i8* %t891, i8* %t892, %SourceSpan* %t914, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t915
merge11:
  %t916 = extractvalue %Statement %statement, 0
  %t917 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t918 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t919 = icmp eq i32 %t916, 0
  %t920 = select i1 %t919, i8* %t918, i8* %t917
  %t921 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t922 = icmp eq i32 %t916, 1
  %t923 = select i1 %t922, i8* %t921, i8* %t920
  %t924 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t925 = icmp eq i32 %t916, 2
  %t926 = select i1 %t925, i8* %t924, i8* %t923
  %t927 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t928 = icmp eq i32 %t916, 3
  %t929 = select i1 %t928, i8* %t927, i8* %t926
  %t930 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t931 = icmp eq i32 %t916, 4
  %t932 = select i1 %t931, i8* %t930, i8* %t929
  %t933 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t934 = icmp eq i32 %t916, 5
  %t935 = select i1 %t934, i8* %t933, i8* %t932
  %t936 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t937 = icmp eq i32 %t916, 6
  %t938 = select i1 %t937, i8* %t936, i8* %t935
  %t939 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t940 = icmp eq i32 %t916, 7
  %t941 = select i1 %t940, i8* %t939, i8* %t938
  %t942 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t943 = icmp eq i32 %t916, 8
  %t944 = select i1 %t943, i8* %t942, i8* %t941
  %t945 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t946 = icmp eq i32 %t916, 9
  %t947 = select i1 %t946, i8* %t945, i8* %t944
  %t948 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t949 = icmp eq i32 %t916, 10
  %t950 = select i1 %t949, i8* %t948, i8* %t947
  %t951 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t952 = icmp eq i32 %t916, 11
  %t953 = select i1 %t952, i8* %t951, i8* %t950
  %t954 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t955 = icmp eq i32 %t916, 12
  %t956 = select i1 %t955, i8* %t954, i8* %t953
  %t957 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t958 = icmp eq i32 %t916, 13
  %t959 = select i1 %t958, i8* %t957, i8* %t956
  %t960 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t961 = icmp eq i32 %t916, 14
  %t962 = select i1 %t961, i8* %t960, i8* %t959
  %t963 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t964 = icmp eq i32 %t916, 15
  %t965 = select i1 %t964, i8* %t963, i8* %t962
  %t966 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t967 = icmp eq i32 %t916, 16
  %t968 = select i1 %t967, i8* %t966, i8* %t965
  %t969 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t970 = icmp eq i32 %t916, 17
  %t971 = select i1 %t970, i8* %t969, i8* %t968
  %t972 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t973 = icmp eq i32 %t916, 18
  %t974 = select i1 %t973, i8* %t972, i8* %t971
  %t975 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t976 = icmp eq i32 %t916, 19
  %t977 = select i1 %t976, i8* %t975, i8* %t974
  %t978 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t979 = icmp eq i32 %t916, 20
  %t980 = select i1 %t979, i8* %t978, i8* %t977
  %t981 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t982 = icmp eq i32 %t916, 21
  %t983 = select i1 %t982, i8* %t981, i8* %t980
  %t984 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t985 = icmp eq i32 %t916, 22
  %t986 = select i1 %t985, i8* %t984, i8* %t983
  %t987 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t988 = icmp eq i32 %t916, 23
  %t989 = select i1 %t988, i8* %t987, i8* %t986
  %t990 = call i8* @malloc(i64 16)
  %t991 = bitcast i8* %t990 to [16 x i8]*
  store [16 x i8] c"ToolDeclaration\00", [16 x i8]* %t991
  %t992 = call i1 @strings_equal(i8* %t989, i8* %t990)
  br i1 %t992, label %then12, label %merge13
then12:
  %t993 = extractvalue %Statement %statement, 0
  %t994 = alloca %Statement
  store %Statement %statement, %Statement* %t994
  %t995 = getelementptr inbounds %Statement, %Statement* %t994, i32 0, i32 1
  %t996 = bitcast [88 x i8]* %t995 to i8*
  %t997 = bitcast i8* %t996 to %FunctionSignature*
  %t998 = load %FunctionSignature, %FunctionSignature* %t997
  %t999 = icmp eq i32 %t993, 4
  %t1000 = select i1 %t999, %FunctionSignature %t998, %FunctionSignature zeroinitializer
  %t1001 = getelementptr inbounds %Statement, %Statement* %t994, i32 0, i32 1
  %t1002 = bitcast [88 x i8]* %t1001 to i8*
  %t1003 = bitcast i8* %t1002 to %FunctionSignature*
  %t1004 = load %FunctionSignature, %FunctionSignature* %t1003
  %t1005 = icmp eq i32 %t993, 5
  %t1006 = select i1 %t1005, %FunctionSignature %t1004, %FunctionSignature %t1000
  %t1007 = getelementptr inbounds %Statement, %Statement* %t994, i32 0, i32 1
  %t1008 = bitcast [88 x i8]* %t1007 to i8*
  %t1009 = bitcast i8* %t1008 to %FunctionSignature*
  %t1010 = load %FunctionSignature, %FunctionSignature* %t1009
  %t1011 = icmp eq i32 %t993, 7
  %t1012 = select i1 %t1011, %FunctionSignature %t1010, %FunctionSignature %t1006
  %t1013 = extractvalue %FunctionSignature %t1012, 0
  %t1014 = call i8* @malloc(i64 5)
  %t1015 = bitcast i8* %t1014 to [5 x i8]*
  store [5 x i8] c"tool\00", [5 x i8]* %t1015
  %t1016 = extractvalue %Statement %statement, 0
  %t1017 = alloca %Statement
  store %Statement %statement, %Statement* %t1017
  %t1018 = getelementptr inbounds %Statement, %Statement* %t1017, i32 0, i32 1
  %t1019 = bitcast [88 x i8]* %t1018 to i8*
  %t1020 = bitcast i8* %t1019 to %FunctionSignature*
  %t1021 = load %FunctionSignature, %FunctionSignature* %t1020
  %t1022 = icmp eq i32 %t1016, 4
  %t1023 = select i1 %t1022, %FunctionSignature %t1021, %FunctionSignature zeroinitializer
  %t1024 = getelementptr inbounds %Statement, %Statement* %t1017, i32 0, i32 1
  %t1025 = bitcast [88 x i8]* %t1024 to i8*
  %t1026 = bitcast i8* %t1025 to %FunctionSignature*
  %t1027 = load %FunctionSignature, %FunctionSignature* %t1026
  %t1028 = icmp eq i32 %t1016, 5
  %t1029 = select i1 %t1028, %FunctionSignature %t1027, %FunctionSignature %t1023
  %t1030 = getelementptr inbounds %Statement, %Statement* %t1017, i32 0, i32 1
  %t1031 = bitcast [88 x i8]* %t1030 to i8*
  %t1032 = bitcast i8* %t1031 to %FunctionSignature*
  %t1033 = load %FunctionSignature, %FunctionSignature* %t1032
  %t1034 = icmp eq i32 %t1016, 7
  %t1035 = select i1 %t1034, %FunctionSignature %t1033, %FunctionSignature %t1029
  %t1036 = extractvalue %FunctionSignature %t1035, 6
  %t1037 = call %SymbolCollectionResult @register_symbol(i8* %t1013, i8* %t1014, %SourceSpan* %t1036, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1037
merge13:
  %t1038 = extractvalue %Statement %statement, 0
  %t1039 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1040 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1041 = icmp eq i32 %t1038, 0
  %t1042 = select i1 %t1041, i8* %t1040, i8* %t1039
  %t1043 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1044 = icmp eq i32 %t1038, 1
  %t1045 = select i1 %t1044, i8* %t1043, i8* %t1042
  %t1046 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1047 = icmp eq i32 %t1038, 2
  %t1048 = select i1 %t1047, i8* %t1046, i8* %t1045
  %t1049 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1050 = icmp eq i32 %t1038, 3
  %t1051 = select i1 %t1050, i8* %t1049, i8* %t1048
  %t1052 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1053 = icmp eq i32 %t1038, 4
  %t1054 = select i1 %t1053, i8* %t1052, i8* %t1051
  %t1055 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1056 = icmp eq i32 %t1038, 5
  %t1057 = select i1 %t1056, i8* %t1055, i8* %t1054
  %t1058 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1059 = icmp eq i32 %t1038, 6
  %t1060 = select i1 %t1059, i8* %t1058, i8* %t1057
  %t1061 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1062 = icmp eq i32 %t1038, 7
  %t1063 = select i1 %t1062, i8* %t1061, i8* %t1060
  %t1064 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1065 = icmp eq i32 %t1038, 8
  %t1066 = select i1 %t1065, i8* %t1064, i8* %t1063
  %t1067 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1068 = icmp eq i32 %t1038, 9
  %t1069 = select i1 %t1068, i8* %t1067, i8* %t1066
  %t1070 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1071 = icmp eq i32 %t1038, 10
  %t1072 = select i1 %t1071, i8* %t1070, i8* %t1069
  %t1073 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1074 = icmp eq i32 %t1038, 11
  %t1075 = select i1 %t1074, i8* %t1073, i8* %t1072
  %t1076 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1077 = icmp eq i32 %t1038, 12
  %t1078 = select i1 %t1077, i8* %t1076, i8* %t1075
  %t1079 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1080 = icmp eq i32 %t1038, 13
  %t1081 = select i1 %t1080, i8* %t1079, i8* %t1078
  %t1082 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1083 = icmp eq i32 %t1038, 14
  %t1084 = select i1 %t1083, i8* %t1082, i8* %t1081
  %t1085 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1086 = icmp eq i32 %t1038, 15
  %t1087 = select i1 %t1086, i8* %t1085, i8* %t1084
  %t1088 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1089 = icmp eq i32 %t1038, 16
  %t1090 = select i1 %t1089, i8* %t1088, i8* %t1087
  %t1091 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1092 = icmp eq i32 %t1038, 17
  %t1093 = select i1 %t1092, i8* %t1091, i8* %t1090
  %t1094 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1095 = icmp eq i32 %t1038, 18
  %t1096 = select i1 %t1095, i8* %t1094, i8* %t1093
  %t1097 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1098 = icmp eq i32 %t1038, 19
  %t1099 = select i1 %t1098, i8* %t1097, i8* %t1096
  %t1100 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t1101 = icmp eq i32 %t1038, 20
  %t1102 = select i1 %t1101, i8* %t1100, i8* %t1099
  %t1103 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1104 = icmp eq i32 %t1038, 21
  %t1105 = select i1 %t1104, i8* %t1103, i8* %t1102
  %t1106 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1107 = icmp eq i32 %t1038, 22
  %t1108 = select i1 %t1107, i8* %t1106, i8* %t1105
  %t1109 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1110 = icmp eq i32 %t1038, 23
  %t1111 = select i1 %t1110, i8* %t1109, i8* %t1108
  %t1112 = call i8* @malloc(i64 16)
  %t1113 = bitcast i8* %t1112 to [16 x i8]*
  store [16 x i8] c"TestDeclaration\00", [16 x i8]* %t1113
  %t1114 = call i1 @strings_equal(i8* %t1111, i8* %t1112)
  br i1 %t1114, label %then14, label %merge15
then14:
  %t1115 = extractvalue %Statement %statement, 0
  %t1116 = alloca %Statement
  store %Statement %statement, %Statement* %t1116
  %t1117 = getelementptr inbounds %Statement, %Statement* %t1116, i32 0, i32 1
  %t1118 = bitcast [48 x i8]* %t1117 to i8*
  %t1119 = bitcast i8* %t1118 to i8**
  %t1120 = load i8*, i8** %t1119
  %t1121 = icmp eq i32 %t1115, 2
  %t1122 = select i1 %t1121, i8* %t1120, i8* null
  %t1123 = getelementptr inbounds %Statement, %Statement* %t1116, i32 0, i32 1
  %t1124 = bitcast [48 x i8]* %t1123 to i8*
  %t1125 = bitcast i8* %t1124 to i8**
  %t1126 = load i8*, i8** %t1125
  %t1127 = icmp eq i32 %t1115, 3
  %t1128 = select i1 %t1127, i8* %t1126, i8* %t1122
  %t1129 = getelementptr inbounds %Statement, %Statement* %t1116, i32 0, i32 1
  %t1130 = bitcast [56 x i8]* %t1129 to i8*
  %t1131 = bitcast i8* %t1130 to i8**
  %t1132 = load i8*, i8** %t1131
  %t1133 = icmp eq i32 %t1115, 6
  %t1134 = select i1 %t1133, i8* %t1132, i8* %t1128
  %t1135 = getelementptr inbounds %Statement, %Statement* %t1116, i32 0, i32 1
  %t1136 = bitcast [56 x i8]* %t1135 to i8*
  %t1137 = bitcast i8* %t1136 to i8**
  %t1138 = load i8*, i8** %t1137
  %t1139 = icmp eq i32 %t1115, 8
  %t1140 = select i1 %t1139, i8* %t1138, i8* %t1134
  %t1141 = getelementptr inbounds %Statement, %Statement* %t1116, i32 0, i32 1
  %t1142 = bitcast [40 x i8]* %t1141 to i8*
  %t1143 = bitcast i8* %t1142 to i8**
  %t1144 = load i8*, i8** %t1143
  %t1145 = icmp eq i32 %t1115, 9
  %t1146 = select i1 %t1145, i8* %t1144, i8* %t1140
  %t1147 = getelementptr inbounds %Statement, %Statement* %t1116, i32 0, i32 1
  %t1148 = bitcast [40 x i8]* %t1147 to i8*
  %t1149 = bitcast i8* %t1148 to i8**
  %t1150 = load i8*, i8** %t1149
  %t1151 = icmp eq i32 %t1115, 10
  %t1152 = select i1 %t1151, i8* %t1150, i8* %t1146
  %t1153 = getelementptr inbounds %Statement, %Statement* %t1116, i32 0, i32 1
  %t1154 = bitcast [40 x i8]* %t1153 to i8*
  %t1155 = bitcast i8* %t1154 to i8**
  %t1156 = load i8*, i8** %t1155
  %t1157 = icmp eq i32 %t1115, 11
  %t1158 = select i1 %t1157, i8* %t1156, i8* %t1152
  %t1159 = call i8* @malloc(i64 5)
  %t1160 = bitcast i8* %t1159 to [5 x i8]*
  store [5 x i8] c"test\00", [5 x i8]* %t1160
  %t1161 = extractvalue %Statement %statement, 0
  %t1162 = alloca %Statement
  store %Statement %statement, %Statement* %t1162
  %t1163 = getelementptr inbounds %Statement, %Statement* %t1162, i32 0, i32 1
  %t1164 = bitcast [48 x i8]* %t1163 to i8*
  %t1165 = getelementptr inbounds i8, i8* %t1164, i64 8
  %t1166 = bitcast i8* %t1165 to %SourceSpan**
  %t1167 = load %SourceSpan*, %SourceSpan** %t1166
  %t1168 = icmp eq i32 %t1161, 3
  %t1169 = select i1 %t1168, %SourceSpan* %t1167, %SourceSpan* null
  %t1170 = getelementptr inbounds %Statement, %Statement* %t1162, i32 0, i32 1
  %t1171 = bitcast [56 x i8]* %t1170 to i8*
  %t1172 = getelementptr inbounds i8, i8* %t1171, i64 8
  %t1173 = bitcast i8* %t1172 to %SourceSpan**
  %t1174 = load %SourceSpan*, %SourceSpan** %t1173
  %t1175 = icmp eq i32 %t1161, 6
  %t1176 = select i1 %t1175, %SourceSpan* %t1174, %SourceSpan* %t1169
  %t1177 = getelementptr inbounds %Statement, %Statement* %t1162, i32 0, i32 1
  %t1178 = bitcast [56 x i8]* %t1177 to i8*
  %t1179 = getelementptr inbounds i8, i8* %t1178, i64 8
  %t1180 = bitcast i8* %t1179 to %SourceSpan**
  %t1181 = load %SourceSpan*, %SourceSpan** %t1180
  %t1182 = icmp eq i32 %t1161, 8
  %t1183 = select i1 %t1182, %SourceSpan* %t1181, %SourceSpan* %t1176
  %t1184 = getelementptr inbounds %Statement, %Statement* %t1162, i32 0, i32 1
  %t1185 = bitcast [40 x i8]* %t1184 to i8*
  %t1186 = getelementptr inbounds i8, i8* %t1185, i64 8
  %t1187 = bitcast i8* %t1186 to %SourceSpan**
  %t1188 = load %SourceSpan*, %SourceSpan** %t1187
  %t1189 = icmp eq i32 %t1161, 9
  %t1190 = select i1 %t1189, %SourceSpan* %t1188, %SourceSpan* %t1183
  %t1191 = getelementptr inbounds %Statement, %Statement* %t1162, i32 0, i32 1
  %t1192 = bitcast [40 x i8]* %t1191 to i8*
  %t1193 = getelementptr inbounds i8, i8* %t1192, i64 8
  %t1194 = bitcast i8* %t1193 to %SourceSpan**
  %t1195 = load %SourceSpan*, %SourceSpan** %t1194
  %t1196 = icmp eq i32 %t1161, 10
  %t1197 = select i1 %t1196, %SourceSpan* %t1195, %SourceSpan* %t1190
  %t1198 = getelementptr inbounds %Statement, %Statement* %t1162, i32 0, i32 1
  %t1199 = bitcast [40 x i8]* %t1198 to i8*
  %t1200 = getelementptr inbounds i8, i8* %t1199, i64 8
  %t1201 = bitcast i8* %t1200 to %SourceSpan**
  %t1202 = load %SourceSpan*, %SourceSpan** %t1201
  %t1203 = icmp eq i32 %t1161, 11
  %t1204 = select i1 %t1203, %SourceSpan* %t1202, %SourceSpan* %t1197
  %t1205 = call %SymbolCollectionResult @register_symbol(i8* %t1158, i8* %t1159, %SourceSpan* %t1204, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1205
merge15:
  %t1206 = extractvalue %Statement %statement, 0
  %t1207 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1208 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1209 = icmp eq i32 %t1206, 0
  %t1210 = select i1 %t1209, i8* %t1208, i8* %t1207
  %t1211 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1212 = icmp eq i32 %t1206, 1
  %t1213 = select i1 %t1212, i8* %t1211, i8* %t1210
  %t1214 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1215 = icmp eq i32 %t1206, 2
  %t1216 = select i1 %t1215, i8* %t1214, i8* %t1213
  %t1217 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1218 = icmp eq i32 %t1206, 3
  %t1219 = select i1 %t1218, i8* %t1217, i8* %t1216
  %t1220 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1221 = icmp eq i32 %t1206, 4
  %t1222 = select i1 %t1221, i8* %t1220, i8* %t1219
  %t1223 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1224 = icmp eq i32 %t1206, 5
  %t1225 = select i1 %t1224, i8* %t1223, i8* %t1222
  %t1226 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1227 = icmp eq i32 %t1206, 6
  %t1228 = select i1 %t1227, i8* %t1226, i8* %t1225
  %t1229 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1230 = icmp eq i32 %t1206, 7
  %t1231 = select i1 %t1230, i8* %t1229, i8* %t1228
  %t1232 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1233 = icmp eq i32 %t1206, 8
  %t1234 = select i1 %t1233, i8* %t1232, i8* %t1231
  %t1235 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1236 = icmp eq i32 %t1206, 9
  %t1237 = select i1 %t1236, i8* %t1235, i8* %t1234
  %t1238 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1239 = icmp eq i32 %t1206, 10
  %t1240 = select i1 %t1239, i8* %t1238, i8* %t1237
  %t1241 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1242 = icmp eq i32 %t1206, 11
  %t1243 = select i1 %t1242, i8* %t1241, i8* %t1240
  %t1244 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1245 = icmp eq i32 %t1206, 12
  %t1246 = select i1 %t1245, i8* %t1244, i8* %t1243
  %t1247 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1248 = icmp eq i32 %t1206, 13
  %t1249 = select i1 %t1248, i8* %t1247, i8* %t1246
  %t1250 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1251 = icmp eq i32 %t1206, 14
  %t1252 = select i1 %t1251, i8* %t1250, i8* %t1249
  %t1253 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1254 = icmp eq i32 %t1206, 15
  %t1255 = select i1 %t1254, i8* %t1253, i8* %t1252
  %t1256 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1257 = icmp eq i32 %t1206, 16
  %t1258 = select i1 %t1257, i8* %t1256, i8* %t1255
  %t1259 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1260 = icmp eq i32 %t1206, 17
  %t1261 = select i1 %t1260, i8* %t1259, i8* %t1258
  %t1262 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1263 = icmp eq i32 %t1206, 18
  %t1264 = select i1 %t1263, i8* %t1262, i8* %t1261
  %t1265 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1266 = icmp eq i32 %t1206, 19
  %t1267 = select i1 %t1266, i8* %t1265, i8* %t1264
  %t1268 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t1269 = icmp eq i32 %t1206, 20
  %t1270 = select i1 %t1269, i8* %t1268, i8* %t1267
  %t1271 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1272 = icmp eq i32 %t1206, 21
  %t1273 = select i1 %t1272, i8* %t1271, i8* %t1270
  %t1274 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1275 = icmp eq i32 %t1206, 22
  %t1276 = select i1 %t1275, i8* %t1274, i8* %t1273
  %t1277 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1278 = icmp eq i32 %t1206, 23
  %t1279 = select i1 %t1278, i8* %t1277, i8* %t1276
  %t1280 = call i8* @malloc(i64 21)
  %t1281 = bitcast i8* %t1280 to [21 x i8]*
  store [21 x i8] c"TypeAliasDeclaration\00", [21 x i8]* %t1281
  %t1282 = call i1 @strings_equal(i8* %t1279, i8* %t1280)
  br i1 %t1282, label %then16, label %merge17
then16:
  %t1283 = extractvalue %Statement %statement, 0
  %t1284 = alloca %Statement
  store %Statement %statement, %Statement* %t1284
  %t1285 = getelementptr inbounds %Statement, %Statement* %t1284, i32 0, i32 1
  %t1286 = bitcast [48 x i8]* %t1285 to i8*
  %t1287 = bitcast i8* %t1286 to i8**
  %t1288 = load i8*, i8** %t1287
  %t1289 = icmp eq i32 %t1283, 2
  %t1290 = select i1 %t1289, i8* %t1288, i8* null
  %t1291 = getelementptr inbounds %Statement, %Statement* %t1284, i32 0, i32 1
  %t1292 = bitcast [48 x i8]* %t1291 to i8*
  %t1293 = bitcast i8* %t1292 to i8**
  %t1294 = load i8*, i8** %t1293
  %t1295 = icmp eq i32 %t1283, 3
  %t1296 = select i1 %t1295, i8* %t1294, i8* %t1290
  %t1297 = getelementptr inbounds %Statement, %Statement* %t1284, i32 0, i32 1
  %t1298 = bitcast [56 x i8]* %t1297 to i8*
  %t1299 = bitcast i8* %t1298 to i8**
  %t1300 = load i8*, i8** %t1299
  %t1301 = icmp eq i32 %t1283, 6
  %t1302 = select i1 %t1301, i8* %t1300, i8* %t1296
  %t1303 = getelementptr inbounds %Statement, %Statement* %t1284, i32 0, i32 1
  %t1304 = bitcast [56 x i8]* %t1303 to i8*
  %t1305 = bitcast i8* %t1304 to i8**
  %t1306 = load i8*, i8** %t1305
  %t1307 = icmp eq i32 %t1283, 8
  %t1308 = select i1 %t1307, i8* %t1306, i8* %t1302
  %t1309 = getelementptr inbounds %Statement, %Statement* %t1284, i32 0, i32 1
  %t1310 = bitcast [40 x i8]* %t1309 to i8*
  %t1311 = bitcast i8* %t1310 to i8**
  %t1312 = load i8*, i8** %t1311
  %t1313 = icmp eq i32 %t1283, 9
  %t1314 = select i1 %t1313, i8* %t1312, i8* %t1308
  %t1315 = getelementptr inbounds %Statement, %Statement* %t1284, i32 0, i32 1
  %t1316 = bitcast [40 x i8]* %t1315 to i8*
  %t1317 = bitcast i8* %t1316 to i8**
  %t1318 = load i8*, i8** %t1317
  %t1319 = icmp eq i32 %t1283, 10
  %t1320 = select i1 %t1319, i8* %t1318, i8* %t1314
  %t1321 = getelementptr inbounds %Statement, %Statement* %t1284, i32 0, i32 1
  %t1322 = bitcast [40 x i8]* %t1321 to i8*
  %t1323 = bitcast i8* %t1322 to i8**
  %t1324 = load i8*, i8** %t1323
  %t1325 = icmp eq i32 %t1283, 11
  %t1326 = select i1 %t1325, i8* %t1324, i8* %t1320
  %t1327 = call i8* @malloc(i64 5)
  %t1328 = bitcast i8* %t1327 to [5 x i8]*
  store [5 x i8] c"type\00", [5 x i8]* %t1328
  %t1329 = extractvalue %Statement %statement, 0
  %t1330 = alloca %Statement
  store %Statement %statement, %Statement* %t1330
  %t1331 = getelementptr inbounds %Statement, %Statement* %t1330, i32 0, i32 1
  %t1332 = bitcast [48 x i8]* %t1331 to i8*
  %t1333 = getelementptr inbounds i8, i8* %t1332, i64 8
  %t1334 = bitcast i8* %t1333 to %SourceSpan**
  %t1335 = load %SourceSpan*, %SourceSpan** %t1334
  %t1336 = icmp eq i32 %t1329, 3
  %t1337 = select i1 %t1336, %SourceSpan* %t1335, %SourceSpan* null
  %t1338 = getelementptr inbounds %Statement, %Statement* %t1330, i32 0, i32 1
  %t1339 = bitcast [56 x i8]* %t1338 to i8*
  %t1340 = getelementptr inbounds i8, i8* %t1339, i64 8
  %t1341 = bitcast i8* %t1340 to %SourceSpan**
  %t1342 = load %SourceSpan*, %SourceSpan** %t1341
  %t1343 = icmp eq i32 %t1329, 6
  %t1344 = select i1 %t1343, %SourceSpan* %t1342, %SourceSpan* %t1337
  %t1345 = getelementptr inbounds %Statement, %Statement* %t1330, i32 0, i32 1
  %t1346 = bitcast [56 x i8]* %t1345 to i8*
  %t1347 = getelementptr inbounds i8, i8* %t1346, i64 8
  %t1348 = bitcast i8* %t1347 to %SourceSpan**
  %t1349 = load %SourceSpan*, %SourceSpan** %t1348
  %t1350 = icmp eq i32 %t1329, 8
  %t1351 = select i1 %t1350, %SourceSpan* %t1349, %SourceSpan* %t1344
  %t1352 = getelementptr inbounds %Statement, %Statement* %t1330, i32 0, i32 1
  %t1353 = bitcast [40 x i8]* %t1352 to i8*
  %t1354 = getelementptr inbounds i8, i8* %t1353, i64 8
  %t1355 = bitcast i8* %t1354 to %SourceSpan**
  %t1356 = load %SourceSpan*, %SourceSpan** %t1355
  %t1357 = icmp eq i32 %t1329, 9
  %t1358 = select i1 %t1357, %SourceSpan* %t1356, %SourceSpan* %t1351
  %t1359 = getelementptr inbounds %Statement, %Statement* %t1330, i32 0, i32 1
  %t1360 = bitcast [40 x i8]* %t1359 to i8*
  %t1361 = getelementptr inbounds i8, i8* %t1360, i64 8
  %t1362 = bitcast i8* %t1361 to %SourceSpan**
  %t1363 = load %SourceSpan*, %SourceSpan** %t1362
  %t1364 = icmp eq i32 %t1329, 10
  %t1365 = select i1 %t1364, %SourceSpan* %t1363, %SourceSpan* %t1358
  %t1366 = getelementptr inbounds %Statement, %Statement* %t1330, i32 0, i32 1
  %t1367 = bitcast [40 x i8]* %t1366 to i8*
  %t1368 = getelementptr inbounds i8, i8* %t1367, i64 8
  %t1369 = bitcast i8* %t1368 to %SourceSpan**
  %t1370 = load %SourceSpan*, %SourceSpan** %t1369
  %t1371 = icmp eq i32 %t1329, 11
  %t1372 = select i1 %t1371, %SourceSpan* %t1370, %SourceSpan* %t1365
  %t1373 = call %SymbolCollectionResult @register_symbol(i8* %t1326, i8* %t1327, %SourceSpan* %t1372, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1373
merge17:
  %t1374 = extractvalue %Statement %statement, 0
  %t1375 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1376 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1377 = icmp eq i32 %t1374, 0
  %t1378 = select i1 %t1377, i8* %t1376, i8* %t1375
  %t1379 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1380 = icmp eq i32 %t1374, 1
  %t1381 = select i1 %t1380, i8* %t1379, i8* %t1378
  %t1382 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1383 = icmp eq i32 %t1374, 2
  %t1384 = select i1 %t1383, i8* %t1382, i8* %t1381
  %t1385 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1386 = icmp eq i32 %t1374, 3
  %t1387 = select i1 %t1386, i8* %t1385, i8* %t1384
  %t1388 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1389 = icmp eq i32 %t1374, 4
  %t1390 = select i1 %t1389, i8* %t1388, i8* %t1387
  %t1391 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1392 = icmp eq i32 %t1374, 5
  %t1393 = select i1 %t1392, i8* %t1391, i8* %t1390
  %t1394 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1395 = icmp eq i32 %t1374, 6
  %t1396 = select i1 %t1395, i8* %t1394, i8* %t1393
  %t1397 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1398 = icmp eq i32 %t1374, 7
  %t1399 = select i1 %t1398, i8* %t1397, i8* %t1396
  %t1400 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1401 = icmp eq i32 %t1374, 8
  %t1402 = select i1 %t1401, i8* %t1400, i8* %t1399
  %t1403 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1404 = icmp eq i32 %t1374, 9
  %t1405 = select i1 %t1404, i8* %t1403, i8* %t1402
  %t1406 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1407 = icmp eq i32 %t1374, 10
  %t1408 = select i1 %t1407, i8* %t1406, i8* %t1405
  %t1409 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1410 = icmp eq i32 %t1374, 11
  %t1411 = select i1 %t1410, i8* %t1409, i8* %t1408
  %t1412 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1413 = icmp eq i32 %t1374, 12
  %t1414 = select i1 %t1413, i8* %t1412, i8* %t1411
  %t1415 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1416 = icmp eq i32 %t1374, 13
  %t1417 = select i1 %t1416, i8* %t1415, i8* %t1414
  %t1418 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1419 = icmp eq i32 %t1374, 14
  %t1420 = select i1 %t1419, i8* %t1418, i8* %t1417
  %t1421 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1422 = icmp eq i32 %t1374, 15
  %t1423 = select i1 %t1422, i8* %t1421, i8* %t1420
  %t1424 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1425 = icmp eq i32 %t1374, 16
  %t1426 = select i1 %t1425, i8* %t1424, i8* %t1423
  %t1427 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1428 = icmp eq i32 %t1374, 17
  %t1429 = select i1 %t1428, i8* %t1427, i8* %t1426
  %t1430 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1431 = icmp eq i32 %t1374, 18
  %t1432 = select i1 %t1431, i8* %t1430, i8* %t1429
  %t1433 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1434 = icmp eq i32 %t1374, 19
  %t1435 = select i1 %t1434, i8* %t1433, i8* %t1432
  %t1436 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t1437 = icmp eq i32 %t1374, 20
  %t1438 = select i1 %t1437, i8* %t1436, i8* %t1435
  %t1439 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1440 = icmp eq i32 %t1374, 21
  %t1441 = select i1 %t1440, i8* %t1439, i8* %t1438
  %t1442 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1443 = icmp eq i32 %t1374, 22
  %t1444 = select i1 %t1443, i8* %t1442, i8* %t1441
  %t1445 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1446 = icmp eq i32 %t1374, 23
  %t1447 = select i1 %t1446, i8* %t1445, i8* %t1444
  %t1448 = call i8* @malloc(i64 20)
  %t1449 = bitcast i8* %t1448 to [20 x i8]*
  store [20 x i8] c"VariableDeclaration\00", [20 x i8]* %t1449
  %t1450 = call i1 @strings_equal(i8* %t1447, i8* %t1448)
  br i1 %t1450, label %then18, label %merge19
then18:
  %t1451 = extractvalue %Statement %statement, 0
  %t1452 = alloca %Statement
  store %Statement %statement, %Statement* %t1452
  %t1453 = getelementptr inbounds %Statement, %Statement* %t1452, i32 0, i32 1
  %t1454 = bitcast [48 x i8]* %t1453 to i8*
  %t1455 = bitcast i8* %t1454 to i8**
  %t1456 = load i8*, i8** %t1455
  %t1457 = icmp eq i32 %t1451, 2
  %t1458 = select i1 %t1457, i8* %t1456, i8* null
  %t1459 = getelementptr inbounds %Statement, %Statement* %t1452, i32 0, i32 1
  %t1460 = bitcast [48 x i8]* %t1459 to i8*
  %t1461 = bitcast i8* %t1460 to i8**
  %t1462 = load i8*, i8** %t1461
  %t1463 = icmp eq i32 %t1451, 3
  %t1464 = select i1 %t1463, i8* %t1462, i8* %t1458
  %t1465 = getelementptr inbounds %Statement, %Statement* %t1452, i32 0, i32 1
  %t1466 = bitcast [56 x i8]* %t1465 to i8*
  %t1467 = bitcast i8* %t1466 to i8**
  %t1468 = load i8*, i8** %t1467
  %t1469 = icmp eq i32 %t1451, 6
  %t1470 = select i1 %t1469, i8* %t1468, i8* %t1464
  %t1471 = getelementptr inbounds %Statement, %Statement* %t1452, i32 0, i32 1
  %t1472 = bitcast [56 x i8]* %t1471 to i8*
  %t1473 = bitcast i8* %t1472 to i8**
  %t1474 = load i8*, i8** %t1473
  %t1475 = icmp eq i32 %t1451, 8
  %t1476 = select i1 %t1475, i8* %t1474, i8* %t1470
  %t1477 = getelementptr inbounds %Statement, %Statement* %t1452, i32 0, i32 1
  %t1478 = bitcast [40 x i8]* %t1477 to i8*
  %t1479 = bitcast i8* %t1478 to i8**
  %t1480 = load i8*, i8** %t1479
  %t1481 = icmp eq i32 %t1451, 9
  %t1482 = select i1 %t1481, i8* %t1480, i8* %t1476
  %t1483 = getelementptr inbounds %Statement, %Statement* %t1452, i32 0, i32 1
  %t1484 = bitcast [40 x i8]* %t1483 to i8*
  %t1485 = bitcast i8* %t1484 to i8**
  %t1486 = load i8*, i8** %t1485
  %t1487 = icmp eq i32 %t1451, 10
  %t1488 = select i1 %t1487, i8* %t1486, i8* %t1482
  %t1489 = getelementptr inbounds %Statement, %Statement* %t1452, i32 0, i32 1
  %t1490 = bitcast [40 x i8]* %t1489 to i8*
  %t1491 = bitcast i8* %t1490 to i8**
  %t1492 = load i8*, i8** %t1491
  %t1493 = icmp eq i32 %t1451, 11
  %t1494 = select i1 %t1493, i8* %t1492, i8* %t1488
  %t1495 = call i8* @malloc(i64 9)
  %t1496 = bitcast i8* %t1495 to [9 x i8]*
  store [9 x i8] c"variable\00", [9 x i8]* %t1496
  %t1497 = extractvalue %Statement %statement, 0
  %t1498 = alloca %Statement
  store %Statement %statement, %Statement* %t1498
  %t1499 = getelementptr inbounds %Statement, %Statement* %t1498, i32 0, i32 1
  %t1500 = bitcast [48 x i8]* %t1499 to i8*
  %t1501 = getelementptr inbounds i8, i8* %t1500, i64 32
  %t1502 = bitcast i8* %t1501 to %SourceSpan**
  %t1503 = load %SourceSpan*, %SourceSpan** %t1502
  %t1504 = icmp eq i32 %t1497, 2
  %t1505 = select i1 %t1504, %SourceSpan* %t1503, %SourceSpan* null
  %t1506 = getelementptr inbounds %Statement, %Statement* %t1498, i32 0, i32 1
  %t1507 = bitcast [16 x i8]* %t1506 to i8*
  %t1508 = getelementptr inbounds i8, i8* %t1507, i64 8
  %t1509 = bitcast i8* %t1508 to %SourceSpan**
  %t1510 = load %SourceSpan*, %SourceSpan** %t1509
  %t1511 = icmp eq i32 %t1497, 21
  %t1512 = select i1 %t1511, %SourceSpan* %t1510, %SourceSpan* %t1505
  %t1513 = getelementptr inbounds %Statement, %Statement* %t1498, i32 0, i32 1
  %t1514 = bitcast [56 x i8]* %t1513 to i8*
  %t1515 = getelementptr inbounds i8, i8* %t1514, i64 48
  %t1516 = bitcast i8* %t1515 to %SourceSpan**
  %t1517 = load %SourceSpan*, %SourceSpan** %t1516
  %t1518 = icmp eq i32 %t1497, 22
  %t1519 = select i1 %t1518, %SourceSpan* %t1517, %SourceSpan* %t1512
  %t1520 = call %SymbolCollectionResult @register_symbol(i8* %t1494, i8* %t1495, %SourceSpan* %t1519, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1520
merge19:
  %t1521 = insertvalue %SymbolCollectionResult undef, { %SymbolEntry*, i64 }* %existing, 0
  %t1522 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t1523 = ptrtoint [0 x %Diagnostic]* %t1522 to i64
  %t1524 = icmp eq i64 %t1523, 0
  %t1525 = select i1 %t1524, i64 1, i64 %t1523
  %t1526 = call i8* @malloc(i64 %t1525)
  %t1527 = bitcast i8* %t1526 to %Diagnostic*
  %t1528 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1529 = ptrtoint { %Diagnostic*, i64 }* %t1528 to i64
  %t1530 = call i8* @malloc(i64 %t1529)
  %t1531 = bitcast i8* %t1530 to { %Diagnostic*, i64 }*
  %t1532 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1531, i32 0, i32 0
  store %Diagnostic* %t1527, %Diagnostic** %t1532
  %t1533 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1531, i32 0, i32 1
  store i64 0, i64* %t1533
  %t1534 = insertvalue %SymbolCollectionResult %t1521, { %Diagnostic*, i64 }* %t1531, 1
  ret %SymbolCollectionResult %t1534
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
  %t62 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t0, 20
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t0, 21
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t0, 22
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t0, 23
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = call i8* @malloc(i64 20)
  %t75 = bitcast i8* %t74 to [20 x i8]*
  store [20 x i8] c"VariableDeclaration\00", [20 x i8]* %t75
  %t76 = call i1 @strings_equal(i8* %t73, i8* %t74)
  br i1 %t76, label %then0, label %merge1
then0:
  %t77 = extractvalue %Statement %statement, 0
  %t78 = alloca %Statement
  store %Statement %statement, %Statement* %t78
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
  %t92 = bitcast [56 x i8]* %t91 to i8*
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
  %t121 = call i8* @malloc(i64 9)
  %t122 = bitcast i8* %t121 to [9 x i8]*
  store [9 x i8] c"variable\00", [9 x i8]* %t122
  %t123 = extractvalue %Statement %statement, 0
  %t124 = alloca %Statement
  store %Statement %statement, %Statement* %t124
  %t125 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t126 = bitcast [48 x i8]* %t125 to i8*
  %t127 = getelementptr inbounds i8, i8* %t126, i64 32
  %t128 = bitcast i8* %t127 to %SourceSpan**
  %t129 = load %SourceSpan*, %SourceSpan** %t128
  %t130 = icmp eq i32 %t123, 2
  %t131 = select i1 %t130, %SourceSpan* %t129, %SourceSpan* null
  %t132 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t133 = bitcast [16 x i8]* %t132 to i8*
  %t134 = getelementptr inbounds i8, i8* %t133, i64 8
  %t135 = bitcast i8* %t134 to %SourceSpan**
  %t136 = load %SourceSpan*, %SourceSpan** %t135
  %t137 = icmp eq i32 %t123, 21
  %t138 = select i1 %t137, %SourceSpan* %t136, %SourceSpan* %t131
  %t139 = getelementptr inbounds %Statement, %Statement* %t124, i32 0, i32 1
  %t140 = bitcast [56 x i8]* %t139 to i8*
  %t141 = getelementptr inbounds i8, i8* %t140, i64 48
  %t142 = bitcast i8* %t141 to %SourceSpan**
  %t143 = load %SourceSpan*, %SourceSpan** %t142
  %t144 = icmp eq i32 %t123, 22
  %t145 = select i1 %t144, %SourceSpan* %t143, %SourceSpan* %t138
  %t146 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t120, i8* %t121, %SourceSpan* %t145)
  ret %ScopeResult %t146
merge1:
  %t147 = extractvalue %Statement %statement, 0
  %t148 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t149 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t147, 0
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t147, 1
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t147, 2
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t147, 3
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t147, 4
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t147, 5
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t147, 6
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t147, 7
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t147, 8
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %t176 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t177 = icmp eq i32 %t147, 9
  %t178 = select i1 %t177, i8* %t176, i8* %t175
  %t179 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t147, 10
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t147, 11
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t147, 12
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %t188 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t147, 13
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %t191 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t192 = icmp eq i32 %t147, 14
  %t193 = select i1 %t192, i8* %t191, i8* %t190
  %t194 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t195 = icmp eq i32 %t147, 15
  %t196 = select i1 %t195, i8* %t194, i8* %t193
  %t197 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t198 = icmp eq i32 %t147, 16
  %t199 = select i1 %t198, i8* %t197, i8* %t196
  %t200 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t201 = icmp eq i32 %t147, 17
  %t202 = select i1 %t201, i8* %t200, i8* %t199
  %t203 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t204 = icmp eq i32 %t147, 18
  %t205 = select i1 %t204, i8* %t203, i8* %t202
  %t206 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t207 = icmp eq i32 %t147, 19
  %t208 = select i1 %t207, i8* %t206, i8* %t205
  %t209 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t210 = icmp eq i32 %t147, 20
  %t211 = select i1 %t210, i8* %t209, i8* %t208
  %t212 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t213 = icmp eq i32 %t147, 21
  %t214 = select i1 %t213, i8* %t212, i8* %t211
  %t215 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t216 = icmp eq i32 %t147, 22
  %t217 = select i1 %t216, i8* %t215, i8* %t214
  %t218 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t219 = icmp eq i32 %t147, 23
  %t220 = select i1 %t219, i8* %t218, i8* %t217
  %t221 = call i8* @malloc(i64 20)
  %t222 = bitcast i8* %t221 to [20 x i8]*
  store [20 x i8] c"FunctionDeclaration\00", [20 x i8]* %t222
  %t223 = call i1 @strings_equal(i8* %t220, i8* %t221)
  br i1 %t223, label %then2, label %merge3
then2:
  %t224 = extractvalue %Statement %statement, 0
  %t225 = alloca %Statement
  store %Statement %statement, %Statement* %t225
  %t226 = getelementptr inbounds %Statement, %Statement* %t225, i32 0, i32 1
  %t227 = bitcast [88 x i8]* %t226 to i8*
  %t228 = bitcast i8* %t227 to %FunctionSignature*
  %t229 = load %FunctionSignature, %FunctionSignature* %t228
  %t230 = icmp eq i32 %t224, 4
  %t231 = select i1 %t230, %FunctionSignature %t229, %FunctionSignature zeroinitializer
  %t232 = getelementptr inbounds %Statement, %Statement* %t225, i32 0, i32 1
  %t233 = bitcast [88 x i8]* %t232 to i8*
  %t234 = bitcast i8* %t233 to %FunctionSignature*
  %t235 = load %FunctionSignature, %FunctionSignature* %t234
  %t236 = icmp eq i32 %t224, 5
  %t237 = select i1 %t236, %FunctionSignature %t235, %FunctionSignature %t231
  %t238 = getelementptr inbounds %Statement, %Statement* %t225, i32 0, i32 1
  %t239 = bitcast [88 x i8]* %t238 to i8*
  %t240 = bitcast i8* %t239 to %FunctionSignature*
  %t241 = load %FunctionSignature, %FunctionSignature* %t240
  %t242 = icmp eq i32 %t224, 7
  %t243 = select i1 %t242, %FunctionSignature %t241, %FunctionSignature %t237
  %t244 = extractvalue %FunctionSignature %t243, 0
  %t245 = call i8* @malloc(i64 9)
  %t246 = bitcast i8* %t245 to [9 x i8]*
  store [9 x i8] c"function\00", [9 x i8]* %t246
  %t247 = extractvalue %Statement %statement, 0
  %t248 = alloca %Statement
  store %Statement %statement, %Statement* %t248
  %t249 = getelementptr inbounds %Statement, %Statement* %t248, i32 0, i32 1
  %t250 = bitcast [88 x i8]* %t249 to i8*
  %t251 = bitcast i8* %t250 to %FunctionSignature*
  %t252 = load %FunctionSignature, %FunctionSignature* %t251
  %t253 = icmp eq i32 %t247, 4
  %t254 = select i1 %t253, %FunctionSignature %t252, %FunctionSignature zeroinitializer
  %t255 = getelementptr inbounds %Statement, %Statement* %t248, i32 0, i32 1
  %t256 = bitcast [88 x i8]* %t255 to i8*
  %t257 = bitcast i8* %t256 to %FunctionSignature*
  %t258 = load %FunctionSignature, %FunctionSignature* %t257
  %t259 = icmp eq i32 %t247, 5
  %t260 = select i1 %t259, %FunctionSignature %t258, %FunctionSignature %t254
  %t261 = getelementptr inbounds %Statement, %Statement* %t248, i32 0, i32 1
  %t262 = bitcast [88 x i8]* %t261 to i8*
  %t263 = bitcast i8* %t262 to %FunctionSignature*
  %t264 = load %FunctionSignature, %FunctionSignature* %t263
  %t265 = icmp eq i32 %t247, 7
  %t266 = select i1 %t265, %FunctionSignature %t264, %FunctionSignature %t260
  %t267 = extractvalue %FunctionSignature %t266, 6
  %t268 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t244, i8* %t245, %SourceSpan* %t267)
  store %ScopeResult %t268, %ScopeResult* %l0
  %t269 = load %ScopeResult, %ScopeResult* %l0
  %t270 = extractvalue %ScopeResult %t269, 1
  store { %Diagnostic*, i64 }* %t270, { %Diagnostic*, i64 }** %l1
  %t271 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t272 = extractvalue %Statement %statement, 0
  %t273 = alloca %Statement
  store %Statement %statement, %Statement* %t273
  %t274 = getelementptr inbounds %Statement, %Statement* %t273, i32 0, i32 1
  %t275 = bitcast [88 x i8]* %t274 to i8*
  %t276 = bitcast i8* %t275 to %FunctionSignature*
  %t277 = load %FunctionSignature, %FunctionSignature* %t276
  %t278 = icmp eq i32 %t272, 4
  %t279 = select i1 %t278, %FunctionSignature %t277, %FunctionSignature zeroinitializer
  %t280 = getelementptr inbounds %Statement, %Statement* %t273, i32 0, i32 1
  %t281 = bitcast [88 x i8]* %t280 to i8*
  %t282 = bitcast i8* %t281 to %FunctionSignature*
  %t283 = load %FunctionSignature, %FunctionSignature* %t282
  %t284 = icmp eq i32 %t272, 5
  %t285 = select i1 %t284, %FunctionSignature %t283, %FunctionSignature %t279
  %t286 = getelementptr inbounds %Statement, %Statement* %t273, i32 0, i32 1
  %t287 = bitcast [88 x i8]* %t286 to i8*
  %t288 = bitcast i8* %t287 to %FunctionSignature*
  %t289 = load %FunctionSignature, %FunctionSignature* %t288
  %t290 = icmp eq i32 %t272, 7
  %t291 = select i1 %t290, %FunctionSignature %t289, %FunctionSignature %t285
  %t292 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t291)
  %t293 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t271, i32 0, i32 0
  %t294 = load %Diagnostic*, %Diagnostic** %t293
  %t295 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t271, i32 0, i32 1
  %t296 = load i64, i64* %t295
  %t297 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t292, i32 0, i32 0
  %t298 = load %Diagnostic*, %Diagnostic** %t297
  %t299 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t292, i32 0, i32 1
  %t300 = load i64, i64* %t299
  %t301 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t302 = ptrtoint %Diagnostic* %t301 to i64
  %t303 = add i64 %t296, %t300
  %t304 = mul i64 %t302, %t303
  %t305 = call noalias i8* @malloc(i64 %t304)
  %t306 = bitcast i8* %t305 to %Diagnostic*
  %t307 = bitcast %Diagnostic* %t306 to i8*
  %t308 = mul i64 %t302, %t296
  %t309 = bitcast %Diagnostic* %t294 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t307, i8* %t309, i64 %t308)
  %t310 = mul i64 %t302, %t300
  %t311 = bitcast %Diagnostic* %t298 to i8*
  %t312 = getelementptr %Diagnostic, %Diagnostic* %t306, i64 %t296
  %t313 = bitcast %Diagnostic* %t312 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t313, i8* %t311, i64 %t310)
  %t314 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t315 = ptrtoint { %Diagnostic*, i64 }* %t314 to i64
  %t316 = call i8* @malloc(i64 %t315)
  %t317 = bitcast i8* %t316 to { %Diagnostic*, i64 }*
  %t318 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t317, i32 0, i32 0
  store %Diagnostic* %t306, %Diagnostic** %t318
  %t319 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t317, i32 0, i32 1
  store i64 %t303, i64* %t319
  store { %Diagnostic*, i64 }* %t317, { %Diagnostic*, i64 }** %l1
  %t320 = extractvalue %Statement %statement, 0
  %t321 = alloca %Statement
  store %Statement %statement, %Statement* %t321
  %t322 = getelementptr inbounds %Statement, %Statement* %t321, i32 0, i32 1
  %t323 = bitcast [88 x i8]* %t322 to i8*
  %t324 = bitcast i8* %t323 to %FunctionSignature*
  %t325 = load %FunctionSignature, %FunctionSignature* %t324
  %t326 = icmp eq i32 %t320, 4
  %t327 = select i1 %t326, %FunctionSignature %t325, %FunctionSignature zeroinitializer
  %t328 = getelementptr inbounds %Statement, %Statement* %t321, i32 0, i32 1
  %t329 = bitcast [88 x i8]* %t328 to i8*
  %t330 = bitcast i8* %t329 to %FunctionSignature*
  %t331 = load %FunctionSignature, %FunctionSignature* %t330
  %t332 = icmp eq i32 %t320, 5
  %t333 = select i1 %t332, %FunctionSignature %t331, %FunctionSignature %t327
  %t334 = getelementptr inbounds %Statement, %Statement* %t321, i32 0, i32 1
  %t335 = bitcast [88 x i8]* %t334 to i8*
  %t336 = bitcast i8* %t335 to %FunctionSignature*
  %t337 = load %FunctionSignature, %FunctionSignature* %t336
  %t338 = icmp eq i32 %t320, 7
  %t339 = select i1 %t338, %FunctionSignature %t337, %FunctionSignature %t333
  %t340 = extractvalue %Statement %statement, 0
  %t341 = alloca %Statement
  store %Statement %statement, %Statement* %t341
  %t342 = getelementptr inbounds %Statement, %Statement* %t341, i32 0, i32 1
  %t343 = bitcast [88 x i8]* %t342 to i8*
  %t344 = getelementptr inbounds i8, i8* %t343, i64 56
  %t345 = bitcast i8* %t344 to %Block*
  %t346 = load %Block, %Block* %t345
  %t347 = icmp eq i32 %t340, 4
  %t348 = select i1 %t347, %Block %t346, %Block zeroinitializer
  %t349 = getelementptr inbounds %Statement, %Statement* %t341, i32 0, i32 1
  %t350 = bitcast [88 x i8]* %t349 to i8*
  %t351 = getelementptr inbounds i8, i8* %t350, i64 56
  %t352 = bitcast i8* %t351 to %Block*
  %t353 = load %Block, %Block* %t352
  %t354 = icmp eq i32 %t340, 5
  %t355 = select i1 %t354, %Block %t353, %Block %t348
  %t356 = getelementptr inbounds %Statement, %Statement* %t341, i32 0, i32 1
  %t357 = bitcast [56 x i8]* %t356 to i8*
  %t358 = getelementptr inbounds i8, i8* %t357, i64 16
  %t359 = bitcast i8* %t358 to %Block*
  %t360 = load %Block, %Block* %t359
  %t361 = icmp eq i32 %t340, 6
  %t362 = select i1 %t361, %Block %t360, %Block %t355
  %t363 = getelementptr inbounds %Statement, %Statement* %t341, i32 0, i32 1
  %t364 = bitcast [88 x i8]* %t363 to i8*
  %t365 = getelementptr inbounds i8, i8* %t364, i64 56
  %t366 = bitcast i8* %t365 to %Block*
  %t367 = load %Block, %Block* %t366
  %t368 = icmp eq i32 %t340, 7
  %t369 = select i1 %t368, %Block %t367, %Block %t362
  %t370 = getelementptr inbounds %Statement, %Statement* %t341, i32 0, i32 1
  %t371 = bitcast [120 x i8]* %t370 to i8*
  %t372 = getelementptr inbounds i8, i8* %t371, i64 88
  %t373 = bitcast i8* %t372 to %Block*
  %t374 = load %Block, %Block* %t373
  %t375 = icmp eq i32 %t340, 12
  %t376 = select i1 %t375, %Block %t374, %Block %t369
  %t377 = getelementptr inbounds %Statement, %Statement* %t341, i32 0, i32 1
  %t378 = bitcast [40 x i8]* %t377 to i8*
  %t379 = getelementptr inbounds i8, i8* %t378, i64 8
  %t380 = bitcast i8* %t379 to %Block*
  %t381 = load %Block, %Block* %t380
  %t382 = icmp eq i32 %t340, 13
  %t383 = select i1 %t382, %Block %t381, %Block %t376
  %t384 = getelementptr inbounds %Statement, %Statement* %t341, i32 0, i32 1
  %t385 = bitcast [136 x i8]* %t384 to i8*
  %t386 = getelementptr inbounds i8, i8* %t385, i64 104
  %t387 = bitcast i8* %t386 to %Block*
  %t388 = load %Block, %Block* %t387
  %t389 = icmp eq i32 %t340, 14
  %t390 = select i1 %t389, %Block %t388, %Block %t383
  %t391 = getelementptr inbounds %Statement, %Statement* %t341, i32 0, i32 1
  %t392 = bitcast [32 x i8]* %t391 to i8*
  %t393 = bitcast i8* %t392 to %Block*
  %t394 = load %Block, %Block* %t393
  %t395 = icmp eq i32 %t340, 15
  %t396 = select i1 %t395, %Block %t394, %Block %t390
  %t397 = getelementptr inbounds %Statement, %Statement* %t341, i32 0, i32 1
  %t398 = bitcast [24 x i8]* %t397 to i8*
  %t399 = bitcast i8* %t398 to %Block*
  %t400 = load %Block, %Block* %t399
  %t401 = icmp eq i32 %t340, 20
  %t402 = select i1 %t401, %Block %t400, %Block %t396
  %t403 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t339, %Block %t402, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t403, { %Diagnostic*, i64 }** %l2
  %t404 = load %ScopeResult, %ScopeResult* %l0
  %t405 = extractvalue %ScopeResult %t404, 0
  %t406 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t405, 0
  %t407 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t408 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l2
  %t409 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t407, i32 0, i32 0
  %t410 = load %Diagnostic*, %Diagnostic** %t409
  %t411 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t407, i32 0, i32 1
  %t412 = load i64, i64* %t411
  %t413 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t408, i32 0, i32 0
  %t414 = load %Diagnostic*, %Diagnostic** %t413
  %t415 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t408, i32 0, i32 1
  %t416 = load i64, i64* %t415
  %t417 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t418 = ptrtoint %Diagnostic* %t417 to i64
  %t419 = add i64 %t412, %t416
  %t420 = mul i64 %t418, %t419
  %t421 = call noalias i8* @malloc(i64 %t420)
  %t422 = bitcast i8* %t421 to %Diagnostic*
  %t423 = bitcast %Diagnostic* %t422 to i8*
  %t424 = mul i64 %t418, %t412
  %t425 = bitcast %Diagnostic* %t410 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t423, i8* %t425, i64 %t424)
  %t426 = mul i64 %t418, %t416
  %t427 = bitcast %Diagnostic* %t414 to i8*
  %t428 = getelementptr %Diagnostic, %Diagnostic* %t422, i64 %t412
  %t429 = bitcast %Diagnostic* %t428 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t429, i8* %t427, i64 %t426)
  %t430 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t431 = ptrtoint { %Diagnostic*, i64 }* %t430 to i64
  %t432 = call i8* @malloc(i64 %t431)
  %t433 = bitcast i8* %t432 to { %Diagnostic*, i64 }*
  %t434 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t433, i32 0, i32 0
  store %Diagnostic* %t422, %Diagnostic** %t434
  %t435 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t433, i32 0, i32 1
  store i64 %t419, i64* %t435
  %t436 = insertvalue %ScopeResult %t406, { %Diagnostic*, i64 }* %t433, 1
  ret %ScopeResult %t436
merge3:
  %t437 = extractvalue %Statement %statement, 0
  %t438 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t439 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t440 = icmp eq i32 %t437, 0
  %t441 = select i1 %t440, i8* %t439, i8* %t438
  %t442 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t443 = icmp eq i32 %t437, 1
  %t444 = select i1 %t443, i8* %t442, i8* %t441
  %t445 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t446 = icmp eq i32 %t437, 2
  %t447 = select i1 %t446, i8* %t445, i8* %t444
  %t448 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t449 = icmp eq i32 %t437, 3
  %t450 = select i1 %t449, i8* %t448, i8* %t447
  %t451 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t452 = icmp eq i32 %t437, 4
  %t453 = select i1 %t452, i8* %t451, i8* %t450
  %t454 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t455 = icmp eq i32 %t437, 5
  %t456 = select i1 %t455, i8* %t454, i8* %t453
  %t457 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t458 = icmp eq i32 %t437, 6
  %t459 = select i1 %t458, i8* %t457, i8* %t456
  %t460 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t461 = icmp eq i32 %t437, 7
  %t462 = select i1 %t461, i8* %t460, i8* %t459
  %t463 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t464 = icmp eq i32 %t437, 8
  %t465 = select i1 %t464, i8* %t463, i8* %t462
  %t466 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t467 = icmp eq i32 %t437, 9
  %t468 = select i1 %t467, i8* %t466, i8* %t465
  %t469 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t470 = icmp eq i32 %t437, 10
  %t471 = select i1 %t470, i8* %t469, i8* %t468
  %t472 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t473 = icmp eq i32 %t437, 11
  %t474 = select i1 %t473, i8* %t472, i8* %t471
  %t475 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t476 = icmp eq i32 %t437, 12
  %t477 = select i1 %t476, i8* %t475, i8* %t474
  %t478 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t479 = icmp eq i32 %t437, 13
  %t480 = select i1 %t479, i8* %t478, i8* %t477
  %t481 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t482 = icmp eq i32 %t437, 14
  %t483 = select i1 %t482, i8* %t481, i8* %t480
  %t484 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t485 = icmp eq i32 %t437, 15
  %t486 = select i1 %t485, i8* %t484, i8* %t483
  %t487 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t488 = icmp eq i32 %t437, 16
  %t489 = select i1 %t488, i8* %t487, i8* %t486
  %t490 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t491 = icmp eq i32 %t437, 17
  %t492 = select i1 %t491, i8* %t490, i8* %t489
  %t493 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t494 = icmp eq i32 %t437, 18
  %t495 = select i1 %t494, i8* %t493, i8* %t492
  %t496 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t497 = icmp eq i32 %t437, 19
  %t498 = select i1 %t497, i8* %t496, i8* %t495
  %t499 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t500 = icmp eq i32 %t437, 20
  %t501 = select i1 %t500, i8* %t499, i8* %t498
  %t502 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t503 = icmp eq i32 %t437, 21
  %t504 = select i1 %t503, i8* %t502, i8* %t501
  %t505 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t506 = icmp eq i32 %t437, 22
  %t507 = select i1 %t506, i8* %t505, i8* %t504
  %t508 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t509 = icmp eq i32 %t437, 23
  %t510 = select i1 %t509, i8* %t508, i8* %t507
  %t511 = call i8* @malloc(i64 18)
  %t512 = bitcast i8* %t511 to [18 x i8]*
  store [18 x i8] c"StructDeclaration\00", [18 x i8]* %t512
  %t513 = call i1 @strings_equal(i8* %t510, i8* %t511)
  br i1 %t513, label %then4, label %merge5
then4:
  %t514 = extractvalue %Statement %statement, 0
  %t515 = alloca %Statement
  store %Statement %statement, %Statement* %t515
  %t516 = getelementptr inbounds %Statement, %Statement* %t515, i32 0, i32 1
  %t517 = bitcast [48 x i8]* %t516 to i8*
  %t518 = bitcast i8* %t517 to i8**
  %t519 = load i8*, i8** %t518
  %t520 = icmp eq i32 %t514, 2
  %t521 = select i1 %t520, i8* %t519, i8* null
  %t522 = getelementptr inbounds %Statement, %Statement* %t515, i32 0, i32 1
  %t523 = bitcast [48 x i8]* %t522 to i8*
  %t524 = bitcast i8* %t523 to i8**
  %t525 = load i8*, i8** %t524
  %t526 = icmp eq i32 %t514, 3
  %t527 = select i1 %t526, i8* %t525, i8* %t521
  %t528 = getelementptr inbounds %Statement, %Statement* %t515, i32 0, i32 1
  %t529 = bitcast [56 x i8]* %t528 to i8*
  %t530 = bitcast i8* %t529 to i8**
  %t531 = load i8*, i8** %t530
  %t532 = icmp eq i32 %t514, 6
  %t533 = select i1 %t532, i8* %t531, i8* %t527
  %t534 = getelementptr inbounds %Statement, %Statement* %t515, i32 0, i32 1
  %t535 = bitcast [56 x i8]* %t534 to i8*
  %t536 = bitcast i8* %t535 to i8**
  %t537 = load i8*, i8** %t536
  %t538 = icmp eq i32 %t514, 8
  %t539 = select i1 %t538, i8* %t537, i8* %t533
  %t540 = getelementptr inbounds %Statement, %Statement* %t515, i32 0, i32 1
  %t541 = bitcast [40 x i8]* %t540 to i8*
  %t542 = bitcast i8* %t541 to i8**
  %t543 = load i8*, i8** %t542
  %t544 = icmp eq i32 %t514, 9
  %t545 = select i1 %t544, i8* %t543, i8* %t539
  %t546 = getelementptr inbounds %Statement, %Statement* %t515, i32 0, i32 1
  %t547 = bitcast [40 x i8]* %t546 to i8*
  %t548 = bitcast i8* %t547 to i8**
  %t549 = load i8*, i8** %t548
  %t550 = icmp eq i32 %t514, 10
  %t551 = select i1 %t550, i8* %t549, i8* %t545
  %t552 = getelementptr inbounds %Statement, %Statement* %t515, i32 0, i32 1
  %t553 = bitcast [40 x i8]* %t552 to i8*
  %t554 = bitcast i8* %t553 to i8**
  %t555 = load i8*, i8** %t554
  %t556 = icmp eq i32 %t514, 11
  %t557 = select i1 %t556, i8* %t555, i8* %t551
  %t558 = call i8* @malloc(i64 7)
  %t559 = bitcast i8* %t558 to [7 x i8]*
  store [7 x i8] c"struct\00", [7 x i8]* %t559
  %t560 = extractvalue %Statement %statement, 0
  %t561 = alloca %Statement
  store %Statement %statement, %Statement* %t561
  %t562 = getelementptr inbounds %Statement, %Statement* %t561, i32 0, i32 1
  %t563 = bitcast [48 x i8]* %t562 to i8*
  %t564 = getelementptr inbounds i8, i8* %t563, i64 8
  %t565 = bitcast i8* %t564 to %SourceSpan**
  %t566 = load %SourceSpan*, %SourceSpan** %t565
  %t567 = icmp eq i32 %t560, 3
  %t568 = select i1 %t567, %SourceSpan* %t566, %SourceSpan* null
  %t569 = getelementptr inbounds %Statement, %Statement* %t561, i32 0, i32 1
  %t570 = bitcast [56 x i8]* %t569 to i8*
  %t571 = getelementptr inbounds i8, i8* %t570, i64 8
  %t572 = bitcast i8* %t571 to %SourceSpan**
  %t573 = load %SourceSpan*, %SourceSpan** %t572
  %t574 = icmp eq i32 %t560, 6
  %t575 = select i1 %t574, %SourceSpan* %t573, %SourceSpan* %t568
  %t576 = getelementptr inbounds %Statement, %Statement* %t561, i32 0, i32 1
  %t577 = bitcast [56 x i8]* %t576 to i8*
  %t578 = getelementptr inbounds i8, i8* %t577, i64 8
  %t579 = bitcast i8* %t578 to %SourceSpan**
  %t580 = load %SourceSpan*, %SourceSpan** %t579
  %t581 = icmp eq i32 %t560, 8
  %t582 = select i1 %t581, %SourceSpan* %t580, %SourceSpan* %t575
  %t583 = getelementptr inbounds %Statement, %Statement* %t561, i32 0, i32 1
  %t584 = bitcast [40 x i8]* %t583 to i8*
  %t585 = getelementptr inbounds i8, i8* %t584, i64 8
  %t586 = bitcast i8* %t585 to %SourceSpan**
  %t587 = load %SourceSpan*, %SourceSpan** %t586
  %t588 = icmp eq i32 %t560, 9
  %t589 = select i1 %t588, %SourceSpan* %t587, %SourceSpan* %t582
  %t590 = getelementptr inbounds %Statement, %Statement* %t561, i32 0, i32 1
  %t591 = bitcast [40 x i8]* %t590 to i8*
  %t592 = getelementptr inbounds i8, i8* %t591, i64 8
  %t593 = bitcast i8* %t592 to %SourceSpan**
  %t594 = load %SourceSpan*, %SourceSpan** %t593
  %t595 = icmp eq i32 %t560, 10
  %t596 = select i1 %t595, %SourceSpan* %t594, %SourceSpan* %t589
  %t597 = getelementptr inbounds %Statement, %Statement* %t561, i32 0, i32 1
  %t598 = bitcast [40 x i8]* %t597 to i8*
  %t599 = getelementptr inbounds i8, i8* %t598, i64 8
  %t600 = bitcast i8* %t599 to %SourceSpan**
  %t601 = load %SourceSpan*, %SourceSpan** %t600
  %t602 = icmp eq i32 %t560, 11
  %t603 = select i1 %t602, %SourceSpan* %t601, %SourceSpan* %t596
  %t604 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t557, i8* %t558, %SourceSpan* %t603)
  store %ScopeResult %t604, %ScopeResult* %l3
  %t605 = load %ScopeResult, %ScopeResult* %l3
  %t606 = extractvalue %ScopeResult %t605, 1
  store { %Diagnostic*, i64 }* %t606, { %Diagnostic*, i64 }** %l4
  %t607 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t608 = extractvalue %Statement %statement, 0
  %t609 = alloca %Statement
  store %Statement %statement, %Statement* %t609
  %t610 = getelementptr inbounds %Statement, %Statement* %t609, i32 0, i32 1
  %t611 = bitcast [56 x i8]* %t610 to i8*
  %t612 = getelementptr inbounds i8, i8* %t611, i64 16
  %t613 = bitcast i8* %t612 to { %TypeParameter*, i64 }**
  %t614 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t613
  %t615 = icmp eq i32 %t608, 8
  %t616 = select i1 %t615, { %TypeParameter*, i64 }* %t614, { %TypeParameter*, i64 }* null
  %t617 = getelementptr inbounds %Statement, %Statement* %t609, i32 0, i32 1
  %t618 = bitcast [40 x i8]* %t617 to i8*
  %t619 = getelementptr inbounds i8, i8* %t618, i64 16
  %t620 = bitcast i8* %t619 to { %TypeParameter*, i64 }**
  %t621 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t620
  %t622 = icmp eq i32 %t608, 9
  %t623 = select i1 %t622, { %TypeParameter*, i64 }* %t621, { %TypeParameter*, i64 }* %t616
  %t624 = getelementptr inbounds %Statement, %Statement* %t609, i32 0, i32 1
  %t625 = bitcast [40 x i8]* %t624 to i8*
  %t626 = getelementptr inbounds i8, i8* %t625, i64 16
  %t627 = bitcast i8* %t626 to { %TypeParameter*, i64 }**
  %t628 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t627
  %t629 = icmp eq i32 %t608, 10
  %t630 = select i1 %t629, { %TypeParameter*, i64 }* %t628, { %TypeParameter*, i64 }* %t623
  %t631 = getelementptr inbounds %Statement, %Statement* %t609, i32 0, i32 1
  %t632 = bitcast [40 x i8]* %t631 to i8*
  %t633 = getelementptr inbounds i8, i8* %t632, i64 16
  %t634 = bitcast i8* %t633 to { %TypeParameter*, i64 }**
  %t635 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t634
  %t636 = icmp eq i32 %t608, 11
  %t637 = select i1 %t636, { %TypeParameter*, i64 }* %t635, { %TypeParameter*, i64 }* %t630
  %t638 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t637)
  %t639 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t607, i32 0, i32 0
  %t640 = load %Diagnostic*, %Diagnostic** %t639
  %t641 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t607, i32 0, i32 1
  %t642 = load i64, i64* %t641
  %t643 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t638, i32 0, i32 0
  %t644 = load %Diagnostic*, %Diagnostic** %t643
  %t645 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t638, i32 0, i32 1
  %t646 = load i64, i64* %t645
  %t647 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t648 = ptrtoint %Diagnostic* %t647 to i64
  %t649 = add i64 %t642, %t646
  %t650 = mul i64 %t648, %t649
  %t651 = call noalias i8* @malloc(i64 %t650)
  %t652 = bitcast i8* %t651 to %Diagnostic*
  %t653 = bitcast %Diagnostic* %t652 to i8*
  %t654 = mul i64 %t648, %t642
  %t655 = bitcast %Diagnostic* %t640 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t653, i8* %t655, i64 %t654)
  %t656 = mul i64 %t648, %t646
  %t657 = bitcast %Diagnostic* %t644 to i8*
  %t658 = getelementptr %Diagnostic, %Diagnostic* %t652, i64 %t642
  %t659 = bitcast %Diagnostic* %t658 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t659, i8* %t657, i64 %t656)
  %t660 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t661 = ptrtoint { %Diagnostic*, i64 }* %t660 to i64
  %t662 = call i8* @malloc(i64 %t661)
  %t663 = bitcast i8* %t662 to { %Diagnostic*, i64 }*
  %t664 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t663, i32 0, i32 0
  store %Diagnostic* %t652, %Diagnostic** %t664
  %t665 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t663, i32 0, i32 1
  store i64 %t649, i64* %t665
  store { %Diagnostic*, i64 }* %t663, { %Diagnostic*, i64 }** %l4
  %t666 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t667 = extractvalue %Statement %statement, 0
  %t668 = alloca %Statement
  store %Statement %statement, %Statement* %t668
  %t669 = getelementptr inbounds %Statement, %Statement* %t668, i32 0, i32 1
  %t670 = bitcast [56 x i8]* %t669 to i8*
  %t671 = getelementptr inbounds i8, i8* %t670, i64 32
  %t672 = bitcast i8* %t671 to { %FieldDeclaration*, i64 }**
  %t673 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %t672
  %t674 = icmp eq i32 %t667, 8
  %t675 = select i1 %t674, { %FieldDeclaration*, i64 }* %t673, { %FieldDeclaration*, i64 }* null
  %t676 = call { %Diagnostic*, i64 }* @check_struct_fields({ %FieldDeclaration*, i64 }* %t675)
  %t677 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t666, i32 0, i32 0
  %t678 = load %Diagnostic*, %Diagnostic** %t677
  %t679 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t666, i32 0, i32 1
  %t680 = load i64, i64* %t679
  %t681 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t676, i32 0, i32 0
  %t682 = load %Diagnostic*, %Diagnostic** %t681
  %t683 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t676, i32 0, i32 1
  %t684 = load i64, i64* %t683
  %t685 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t686 = ptrtoint %Diagnostic* %t685 to i64
  %t687 = add i64 %t680, %t684
  %t688 = mul i64 %t686, %t687
  %t689 = call noalias i8* @malloc(i64 %t688)
  %t690 = bitcast i8* %t689 to %Diagnostic*
  %t691 = bitcast %Diagnostic* %t690 to i8*
  %t692 = mul i64 %t686, %t680
  %t693 = bitcast %Diagnostic* %t678 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t691, i8* %t693, i64 %t692)
  %t694 = mul i64 %t686, %t684
  %t695 = bitcast %Diagnostic* %t682 to i8*
  %t696 = getelementptr %Diagnostic, %Diagnostic* %t690, i64 %t680
  %t697 = bitcast %Diagnostic* %t696 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t697, i8* %t695, i64 %t694)
  %t698 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t699 = ptrtoint { %Diagnostic*, i64 }* %t698 to i64
  %t700 = call i8* @malloc(i64 %t699)
  %t701 = bitcast i8* %t700 to { %Diagnostic*, i64 }*
  %t702 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t701, i32 0, i32 0
  store %Diagnostic* %t690, %Diagnostic** %t702
  %t703 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t701, i32 0, i32 1
  store i64 %t687, i64* %t703
  store { %Diagnostic*, i64 }* %t701, { %Diagnostic*, i64 }** %l4
  %t704 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t705 = extractvalue %Statement %statement, 0
  %t706 = alloca %Statement
  store %Statement %statement, %Statement* %t706
  %t707 = getelementptr inbounds %Statement, %Statement* %t706, i32 0, i32 1
  %t708 = bitcast [56 x i8]* %t707 to i8*
  %t709 = getelementptr inbounds i8, i8* %t708, i64 40
  %t710 = bitcast i8* %t709 to { %MethodDeclaration*, i64 }**
  %t711 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t710
  %t712 = icmp eq i32 %t705, 8
  %t713 = select i1 %t712, { %MethodDeclaration*, i64 }* %t711, { %MethodDeclaration*, i64 }* null
  %t714 = call { %Diagnostic*, i64 }* @check_struct_methods({ %MethodDeclaration*, i64 }* %t713)
  %t715 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t704, i32 0, i32 0
  %t716 = load %Diagnostic*, %Diagnostic** %t715
  %t717 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t704, i32 0, i32 1
  %t718 = load i64, i64* %t717
  %t719 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t714, i32 0, i32 0
  %t720 = load %Diagnostic*, %Diagnostic** %t719
  %t721 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t714, i32 0, i32 1
  %t722 = load i64, i64* %t721
  %t723 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t724 = ptrtoint %Diagnostic* %t723 to i64
  %t725 = add i64 %t718, %t722
  %t726 = mul i64 %t724, %t725
  %t727 = call noalias i8* @malloc(i64 %t726)
  %t728 = bitcast i8* %t727 to %Diagnostic*
  %t729 = bitcast %Diagnostic* %t728 to i8*
  %t730 = mul i64 %t724, %t718
  %t731 = bitcast %Diagnostic* %t716 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t729, i8* %t731, i64 %t730)
  %t732 = mul i64 %t724, %t722
  %t733 = bitcast %Diagnostic* %t720 to i8*
  %t734 = getelementptr %Diagnostic, %Diagnostic* %t728, i64 %t718
  %t735 = bitcast %Diagnostic* %t734 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t735, i8* %t733, i64 %t732)
  %t736 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t737 = ptrtoint { %Diagnostic*, i64 }* %t736 to i64
  %t738 = call i8* @malloc(i64 %t737)
  %t739 = bitcast i8* %t738 to { %Diagnostic*, i64 }*
  %t740 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t739, i32 0, i32 0
  store %Diagnostic* %t728, %Diagnostic** %t740
  %t741 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t739, i32 0, i32 1
  store i64 %t725, i64* %t741
  store { %Diagnostic*, i64 }* %t739, { %Diagnostic*, i64 }** %l4
  %t742 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t743 = call { %Diagnostic*, i64 }* @check_struct_implements_interfaces(%Statement %statement, { %Statement*, i64 }* %interfaces)
  %t744 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t742, i32 0, i32 0
  %t745 = load %Diagnostic*, %Diagnostic** %t744
  %t746 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t742, i32 0, i32 1
  %t747 = load i64, i64* %t746
  %t748 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t743, i32 0, i32 0
  %t749 = load %Diagnostic*, %Diagnostic** %t748
  %t750 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t743, i32 0, i32 1
  %t751 = load i64, i64* %t750
  %t752 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t753 = ptrtoint %Diagnostic* %t752 to i64
  %t754 = add i64 %t747, %t751
  %t755 = mul i64 %t753, %t754
  %t756 = call noalias i8* @malloc(i64 %t755)
  %t757 = bitcast i8* %t756 to %Diagnostic*
  %t758 = bitcast %Diagnostic* %t757 to i8*
  %t759 = mul i64 %t753, %t747
  %t760 = bitcast %Diagnostic* %t745 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t758, i8* %t760, i64 %t759)
  %t761 = mul i64 %t753, %t751
  %t762 = bitcast %Diagnostic* %t749 to i8*
  %t763 = getelementptr %Diagnostic, %Diagnostic* %t757, i64 %t747
  %t764 = bitcast %Diagnostic* %t763 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t764, i8* %t762, i64 %t761)
  %t765 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t766 = ptrtoint { %Diagnostic*, i64 }* %t765 to i64
  %t767 = call i8* @malloc(i64 %t766)
  %t768 = bitcast i8* %t767 to { %Diagnostic*, i64 }*
  %t769 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t768, i32 0, i32 0
  store %Diagnostic* %t757, %Diagnostic** %t769
  %t770 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t768, i32 0, i32 1
  store i64 %t754, i64* %t770
  store { %Diagnostic*, i64 }* %t768, { %Diagnostic*, i64 }** %l4
  %t771 = sitofp i64 0 to double
  store double %t771, double* %l5
  %t772 = load %ScopeResult, %ScopeResult* %l3
  %t773 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t774 = load double, double* %l5
  br label %loop.header6
loop.header6:
  %t848 = phi { %Diagnostic*, i64 }* [ %t773, %then4 ], [ %t846, %loop.latch8 ]
  %t849 = phi double [ %t774, %then4 ], [ %t847, %loop.latch8 ]
  store { %Diagnostic*, i64 }* %t848, { %Diagnostic*, i64 }** %l4
  store double %t849, double* %l5
  br label %loop.body7
loop.body7:
  %t775 = load double, double* %l5
  %t776 = extractvalue %Statement %statement, 0
  %t777 = alloca %Statement
  store %Statement %statement, %Statement* %t777
  %t778 = getelementptr inbounds %Statement, %Statement* %t777, i32 0, i32 1
  %t779 = bitcast [56 x i8]* %t778 to i8*
  %t780 = getelementptr inbounds i8, i8* %t779, i64 40
  %t781 = bitcast i8* %t780 to { %MethodDeclaration*, i64 }**
  %t782 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t781
  %t783 = icmp eq i32 %t776, 8
  %t784 = select i1 %t783, { %MethodDeclaration*, i64 }* %t782, { %MethodDeclaration*, i64 }* null
  %t785 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t784
  %t786 = extractvalue { %MethodDeclaration*, i64 } %t785, 1
  %t787 = sitofp i64 %t786 to double
  %t788 = fcmp oge double %t775, %t787
  %t789 = load %ScopeResult, %ScopeResult* %l3
  %t790 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t791 = load double, double* %l5
  br i1 %t788, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t792 = extractvalue %Statement %statement, 0
  %t793 = alloca %Statement
  store %Statement %statement, %Statement* %t793
  %t794 = getelementptr inbounds %Statement, %Statement* %t793, i32 0, i32 1
  %t795 = bitcast [56 x i8]* %t794 to i8*
  %t796 = getelementptr inbounds i8, i8* %t795, i64 40
  %t797 = bitcast i8* %t796 to { %MethodDeclaration*, i64 }**
  %t798 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t797
  %t799 = icmp eq i32 %t792, 8
  %t800 = select i1 %t799, { %MethodDeclaration*, i64 }* %t798, { %MethodDeclaration*, i64 }* null
  %t801 = load double, double* %l5
  %t802 = call double @llvm.round.f64(double %t801)
  %t803 = fptosi double %t802 to i64
  %t804 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t800
  %t805 = extractvalue { %MethodDeclaration*, i64 } %t804, 0
  %t806 = extractvalue { %MethodDeclaration*, i64 } %t804, 1
  %t807 = icmp uge i64 %t803, %t806
  ; bounds check: %t807 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t803, i64 %t806)
  %t808 = getelementptr %MethodDeclaration, %MethodDeclaration* %t805, i64 %t803
  %t809 = load %MethodDeclaration, %MethodDeclaration* %t808
  store %MethodDeclaration %t809, %MethodDeclaration* %l6
  %t810 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t811 = load %MethodDeclaration, %MethodDeclaration* %l6
  %t812 = extractvalue %MethodDeclaration %t811, 0
  %t813 = load %MethodDeclaration, %MethodDeclaration* %l6
  %t814 = extractvalue %MethodDeclaration %t813, 1
  %t815 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t812, %Block %t814, { %Statement*, i64 }* %interfaces)
  %t816 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t810, i32 0, i32 0
  %t817 = load %Diagnostic*, %Diagnostic** %t816
  %t818 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t810, i32 0, i32 1
  %t819 = load i64, i64* %t818
  %t820 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t815, i32 0, i32 0
  %t821 = load %Diagnostic*, %Diagnostic** %t820
  %t822 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t815, i32 0, i32 1
  %t823 = load i64, i64* %t822
  %t824 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t825 = ptrtoint %Diagnostic* %t824 to i64
  %t826 = add i64 %t819, %t823
  %t827 = mul i64 %t825, %t826
  %t828 = call noalias i8* @malloc(i64 %t827)
  %t829 = bitcast i8* %t828 to %Diagnostic*
  %t830 = bitcast %Diagnostic* %t829 to i8*
  %t831 = mul i64 %t825, %t819
  %t832 = bitcast %Diagnostic* %t817 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t830, i8* %t832, i64 %t831)
  %t833 = mul i64 %t825, %t823
  %t834 = bitcast %Diagnostic* %t821 to i8*
  %t835 = getelementptr %Diagnostic, %Diagnostic* %t829, i64 %t819
  %t836 = bitcast %Diagnostic* %t835 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t836, i8* %t834, i64 %t833)
  %t837 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t838 = ptrtoint { %Diagnostic*, i64 }* %t837 to i64
  %t839 = call i8* @malloc(i64 %t838)
  %t840 = bitcast i8* %t839 to { %Diagnostic*, i64 }*
  %t841 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t840, i32 0, i32 0
  store %Diagnostic* %t829, %Diagnostic** %t841
  %t842 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t840, i32 0, i32 1
  store i64 %t826, i64* %t842
  store { %Diagnostic*, i64 }* %t840, { %Diagnostic*, i64 }** %l4
  %t843 = load double, double* %l5
  %t844 = sitofp i64 1 to double
  %t845 = fadd double %t843, %t844
  store double %t845, double* %l5
  br label %loop.latch8
loop.latch8:
  %t846 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t847 = load double, double* %l5
  br label %loop.header6
afterloop9:
  %t850 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t851 = load double, double* %l5
  %t852 = load %ScopeResult, %ScopeResult* %l3
  %t853 = extractvalue %ScopeResult %t852, 0
  %t854 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t853, 0
  %t855 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t856 = insertvalue %ScopeResult %t854, { %Diagnostic*, i64 }* %t855, 1
  ret %ScopeResult %t856
merge5:
  %t857 = extractvalue %Statement %statement, 0
  %t858 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t859 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t860 = icmp eq i32 %t857, 0
  %t861 = select i1 %t860, i8* %t859, i8* %t858
  %t862 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t863 = icmp eq i32 %t857, 1
  %t864 = select i1 %t863, i8* %t862, i8* %t861
  %t865 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t866 = icmp eq i32 %t857, 2
  %t867 = select i1 %t866, i8* %t865, i8* %t864
  %t868 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t869 = icmp eq i32 %t857, 3
  %t870 = select i1 %t869, i8* %t868, i8* %t867
  %t871 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t872 = icmp eq i32 %t857, 4
  %t873 = select i1 %t872, i8* %t871, i8* %t870
  %t874 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t875 = icmp eq i32 %t857, 5
  %t876 = select i1 %t875, i8* %t874, i8* %t873
  %t877 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t878 = icmp eq i32 %t857, 6
  %t879 = select i1 %t878, i8* %t877, i8* %t876
  %t880 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t881 = icmp eq i32 %t857, 7
  %t882 = select i1 %t881, i8* %t880, i8* %t879
  %t883 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t884 = icmp eq i32 %t857, 8
  %t885 = select i1 %t884, i8* %t883, i8* %t882
  %t886 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t887 = icmp eq i32 %t857, 9
  %t888 = select i1 %t887, i8* %t886, i8* %t885
  %t889 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t890 = icmp eq i32 %t857, 10
  %t891 = select i1 %t890, i8* %t889, i8* %t888
  %t892 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t893 = icmp eq i32 %t857, 11
  %t894 = select i1 %t893, i8* %t892, i8* %t891
  %t895 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t896 = icmp eq i32 %t857, 12
  %t897 = select i1 %t896, i8* %t895, i8* %t894
  %t898 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t899 = icmp eq i32 %t857, 13
  %t900 = select i1 %t899, i8* %t898, i8* %t897
  %t901 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t902 = icmp eq i32 %t857, 14
  %t903 = select i1 %t902, i8* %t901, i8* %t900
  %t904 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t905 = icmp eq i32 %t857, 15
  %t906 = select i1 %t905, i8* %t904, i8* %t903
  %t907 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t908 = icmp eq i32 %t857, 16
  %t909 = select i1 %t908, i8* %t907, i8* %t906
  %t910 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t911 = icmp eq i32 %t857, 17
  %t912 = select i1 %t911, i8* %t910, i8* %t909
  %t913 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t914 = icmp eq i32 %t857, 18
  %t915 = select i1 %t914, i8* %t913, i8* %t912
  %t916 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t917 = icmp eq i32 %t857, 19
  %t918 = select i1 %t917, i8* %t916, i8* %t915
  %t919 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t920 = icmp eq i32 %t857, 20
  %t921 = select i1 %t920, i8* %t919, i8* %t918
  %t922 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t923 = icmp eq i32 %t857, 21
  %t924 = select i1 %t923, i8* %t922, i8* %t921
  %t925 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t926 = icmp eq i32 %t857, 22
  %t927 = select i1 %t926, i8* %t925, i8* %t924
  %t928 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t929 = icmp eq i32 %t857, 23
  %t930 = select i1 %t929, i8* %t928, i8* %t927
  %t931 = call i8* @malloc(i64 16)
  %t932 = bitcast i8* %t931 to [16 x i8]*
  store [16 x i8] c"EnumDeclaration\00", [16 x i8]* %t932
  %t933 = call i1 @strings_equal(i8* %t930, i8* %t931)
  br i1 %t933, label %then12, label %merge13
then12:
  %t934 = extractvalue %Statement %statement, 0
  %t935 = alloca %Statement
  store %Statement %statement, %Statement* %t935
  %t936 = getelementptr inbounds %Statement, %Statement* %t935, i32 0, i32 1
  %t937 = bitcast [48 x i8]* %t936 to i8*
  %t938 = bitcast i8* %t937 to i8**
  %t939 = load i8*, i8** %t938
  %t940 = icmp eq i32 %t934, 2
  %t941 = select i1 %t940, i8* %t939, i8* null
  %t942 = getelementptr inbounds %Statement, %Statement* %t935, i32 0, i32 1
  %t943 = bitcast [48 x i8]* %t942 to i8*
  %t944 = bitcast i8* %t943 to i8**
  %t945 = load i8*, i8** %t944
  %t946 = icmp eq i32 %t934, 3
  %t947 = select i1 %t946, i8* %t945, i8* %t941
  %t948 = getelementptr inbounds %Statement, %Statement* %t935, i32 0, i32 1
  %t949 = bitcast [56 x i8]* %t948 to i8*
  %t950 = bitcast i8* %t949 to i8**
  %t951 = load i8*, i8** %t950
  %t952 = icmp eq i32 %t934, 6
  %t953 = select i1 %t952, i8* %t951, i8* %t947
  %t954 = getelementptr inbounds %Statement, %Statement* %t935, i32 0, i32 1
  %t955 = bitcast [56 x i8]* %t954 to i8*
  %t956 = bitcast i8* %t955 to i8**
  %t957 = load i8*, i8** %t956
  %t958 = icmp eq i32 %t934, 8
  %t959 = select i1 %t958, i8* %t957, i8* %t953
  %t960 = getelementptr inbounds %Statement, %Statement* %t935, i32 0, i32 1
  %t961 = bitcast [40 x i8]* %t960 to i8*
  %t962 = bitcast i8* %t961 to i8**
  %t963 = load i8*, i8** %t962
  %t964 = icmp eq i32 %t934, 9
  %t965 = select i1 %t964, i8* %t963, i8* %t959
  %t966 = getelementptr inbounds %Statement, %Statement* %t935, i32 0, i32 1
  %t967 = bitcast [40 x i8]* %t966 to i8*
  %t968 = bitcast i8* %t967 to i8**
  %t969 = load i8*, i8** %t968
  %t970 = icmp eq i32 %t934, 10
  %t971 = select i1 %t970, i8* %t969, i8* %t965
  %t972 = getelementptr inbounds %Statement, %Statement* %t935, i32 0, i32 1
  %t973 = bitcast [40 x i8]* %t972 to i8*
  %t974 = bitcast i8* %t973 to i8**
  %t975 = load i8*, i8** %t974
  %t976 = icmp eq i32 %t934, 11
  %t977 = select i1 %t976, i8* %t975, i8* %t971
  %t978 = call i8* @malloc(i64 5)
  %t979 = bitcast i8* %t978 to [5 x i8]*
  store [5 x i8] c"enum\00", [5 x i8]* %t979
  %t980 = extractvalue %Statement %statement, 0
  %t981 = alloca %Statement
  store %Statement %statement, %Statement* %t981
  %t982 = getelementptr inbounds %Statement, %Statement* %t981, i32 0, i32 1
  %t983 = bitcast [48 x i8]* %t982 to i8*
  %t984 = getelementptr inbounds i8, i8* %t983, i64 8
  %t985 = bitcast i8* %t984 to %SourceSpan**
  %t986 = load %SourceSpan*, %SourceSpan** %t985
  %t987 = icmp eq i32 %t980, 3
  %t988 = select i1 %t987, %SourceSpan* %t986, %SourceSpan* null
  %t989 = getelementptr inbounds %Statement, %Statement* %t981, i32 0, i32 1
  %t990 = bitcast [56 x i8]* %t989 to i8*
  %t991 = getelementptr inbounds i8, i8* %t990, i64 8
  %t992 = bitcast i8* %t991 to %SourceSpan**
  %t993 = load %SourceSpan*, %SourceSpan** %t992
  %t994 = icmp eq i32 %t980, 6
  %t995 = select i1 %t994, %SourceSpan* %t993, %SourceSpan* %t988
  %t996 = getelementptr inbounds %Statement, %Statement* %t981, i32 0, i32 1
  %t997 = bitcast [56 x i8]* %t996 to i8*
  %t998 = getelementptr inbounds i8, i8* %t997, i64 8
  %t999 = bitcast i8* %t998 to %SourceSpan**
  %t1000 = load %SourceSpan*, %SourceSpan** %t999
  %t1001 = icmp eq i32 %t980, 8
  %t1002 = select i1 %t1001, %SourceSpan* %t1000, %SourceSpan* %t995
  %t1003 = getelementptr inbounds %Statement, %Statement* %t981, i32 0, i32 1
  %t1004 = bitcast [40 x i8]* %t1003 to i8*
  %t1005 = getelementptr inbounds i8, i8* %t1004, i64 8
  %t1006 = bitcast i8* %t1005 to %SourceSpan**
  %t1007 = load %SourceSpan*, %SourceSpan** %t1006
  %t1008 = icmp eq i32 %t980, 9
  %t1009 = select i1 %t1008, %SourceSpan* %t1007, %SourceSpan* %t1002
  %t1010 = getelementptr inbounds %Statement, %Statement* %t981, i32 0, i32 1
  %t1011 = bitcast [40 x i8]* %t1010 to i8*
  %t1012 = getelementptr inbounds i8, i8* %t1011, i64 8
  %t1013 = bitcast i8* %t1012 to %SourceSpan**
  %t1014 = load %SourceSpan*, %SourceSpan** %t1013
  %t1015 = icmp eq i32 %t980, 10
  %t1016 = select i1 %t1015, %SourceSpan* %t1014, %SourceSpan* %t1009
  %t1017 = getelementptr inbounds %Statement, %Statement* %t981, i32 0, i32 1
  %t1018 = bitcast [40 x i8]* %t1017 to i8*
  %t1019 = getelementptr inbounds i8, i8* %t1018, i64 8
  %t1020 = bitcast i8* %t1019 to %SourceSpan**
  %t1021 = load %SourceSpan*, %SourceSpan** %t1020
  %t1022 = icmp eq i32 %t980, 11
  %t1023 = select i1 %t1022, %SourceSpan* %t1021, %SourceSpan* %t1016
  %t1024 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t977, i8* %t978, %SourceSpan* %t1023)
  store %ScopeResult %t1024, %ScopeResult* %l7
  %t1025 = load %ScopeResult, %ScopeResult* %l7
  %t1026 = extractvalue %ScopeResult %t1025, 1
  store { %Diagnostic*, i64 }* %t1026, { %Diagnostic*, i64 }** %l8
  %t1027 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l8
  %t1028 = extractvalue %Statement %statement, 0
  %t1029 = alloca %Statement
  store %Statement %statement, %Statement* %t1029
  %t1030 = getelementptr inbounds %Statement, %Statement* %t1029, i32 0, i32 1
  %t1031 = bitcast [56 x i8]* %t1030 to i8*
  %t1032 = getelementptr inbounds i8, i8* %t1031, i64 16
  %t1033 = bitcast i8* %t1032 to { %TypeParameter*, i64 }**
  %t1034 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1033
  %t1035 = icmp eq i32 %t1028, 8
  %t1036 = select i1 %t1035, { %TypeParameter*, i64 }* %t1034, { %TypeParameter*, i64 }* null
  %t1037 = getelementptr inbounds %Statement, %Statement* %t1029, i32 0, i32 1
  %t1038 = bitcast [40 x i8]* %t1037 to i8*
  %t1039 = getelementptr inbounds i8, i8* %t1038, i64 16
  %t1040 = bitcast i8* %t1039 to { %TypeParameter*, i64 }**
  %t1041 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1040
  %t1042 = icmp eq i32 %t1028, 9
  %t1043 = select i1 %t1042, { %TypeParameter*, i64 }* %t1041, { %TypeParameter*, i64 }* %t1036
  %t1044 = getelementptr inbounds %Statement, %Statement* %t1029, i32 0, i32 1
  %t1045 = bitcast [40 x i8]* %t1044 to i8*
  %t1046 = getelementptr inbounds i8, i8* %t1045, i64 16
  %t1047 = bitcast i8* %t1046 to { %TypeParameter*, i64 }**
  %t1048 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1047
  %t1049 = icmp eq i32 %t1028, 10
  %t1050 = select i1 %t1049, { %TypeParameter*, i64 }* %t1048, { %TypeParameter*, i64 }* %t1043
  %t1051 = getelementptr inbounds %Statement, %Statement* %t1029, i32 0, i32 1
  %t1052 = bitcast [40 x i8]* %t1051 to i8*
  %t1053 = getelementptr inbounds i8, i8* %t1052, i64 16
  %t1054 = bitcast i8* %t1053 to { %TypeParameter*, i64 }**
  %t1055 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1054
  %t1056 = icmp eq i32 %t1028, 11
  %t1057 = select i1 %t1056, { %TypeParameter*, i64 }* %t1055, { %TypeParameter*, i64 }* %t1050
  %t1058 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t1057)
  %t1059 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1027, i32 0, i32 0
  %t1060 = load %Diagnostic*, %Diagnostic** %t1059
  %t1061 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1027, i32 0, i32 1
  %t1062 = load i64, i64* %t1061
  %t1063 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1058, i32 0, i32 0
  %t1064 = load %Diagnostic*, %Diagnostic** %t1063
  %t1065 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1058, i32 0, i32 1
  %t1066 = load i64, i64* %t1065
  %t1067 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t1068 = ptrtoint %Diagnostic* %t1067 to i64
  %t1069 = add i64 %t1062, %t1066
  %t1070 = mul i64 %t1068, %t1069
  %t1071 = call noalias i8* @malloc(i64 %t1070)
  %t1072 = bitcast i8* %t1071 to %Diagnostic*
  %t1073 = bitcast %Diagnostic* %t1072 to i8*
  %t1074 = mul i64 %t1068, %t1062
  %t1075 = bitcast %Diagnostic* %t1060 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1073, i8* %t1075, i64 %t1074)
  %t1076 = mul i64 %t1068, %t1066
  %t1077 = bitcast %Diagnostic* %t1064 to i8*
  %t1078 = getelementptr %Diagnostic, %Diagnostic* %t1072, i64 %t1062
  %t1079 = bitcast %Diagnostic* %t1078 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1079, i8* %t1077, i64 %t1076)
  %t1080 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1081 = ptrtoint { %Diagnostic*, i64 }* %t1080 to i64
  %t1082 = call i8* @malloc(i64 %t1081)
  %t1083 = bitcast i8* %t1082 to { %Diagnostic*, i64 }*
  %t1084 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1083, i32 0, i32 0
  store %Diagnostic* %t1072, %Diagnostic** %t1084
  %t1085 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1083, i32 0, i32 1
  store i64 %t1069, i64* %t1085
  store { %Diagnostic*, i64 }* %t1083, { %Diagnostic*, i64 }** %l8
  %t1086 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l8
  %t1087 = extractvalue %Statement %statement, 0
  %t1088 = alloca %Statement
  store %Statement %statement, %Statement* %t1088
  %t1089 = getelementptr inbounds %Statement, %Statement* %t1088, i32 0, i32 1
  %t1090 = bitcast [40 x i8]* %t1089 to i8*
  %t1091 = getelementptr inbounds i8, i8* %t1090, i64 24
  %t1092 = bitcast i8* %t1091 to { %EnumVariant*, i64 }**
  %t1093 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %t1092
  %t1094 = icmp eq i32 %t1087, 11
  %t1095 = select i1 %t1094, { %EnumVariant*, i64 }* %t1093, { %EnumVariant*, i64 }* null
  %t1096 = call { %Diagnostic*, i64 }* @check_enum_variants({ %EnumVariant*, i64 }* %t1095)
  %t1097 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1086, i32 0, i32 0
  %t1098 = load %Diagnostic*, %Diagnostic** %t1097
  %t1099 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1086, i32 0, i32 1
  %t1100 = load i64, i64* %t1099
  %t1101 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1096, i32 0, i32 0
  %t1102 = load %Diagnostic*, %Diagnostic** %t1101
  %t1103 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1096, i32 0, i32 1
  %t1104 = load i64, i64* %t1103
  %t1105 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t1106 = ptrtoint %Diagnostic* %t1105 to i64
  %t1107 = add i64 %t1100, %t1104
  %t1108 = mul i64 %t1106, %t1107
  %t1109 = call noalias i8* @malloc(i64 %t1108)
  %t1110 = bitcast i8* %t1109 to %Diagnostic*
  %t1111 = bitcast %Diagnostic* %t1110 to i8*
  %t1112 = mul i64 %t1106, %t1100
  %t1113 = bitcast %Diagnostic* %t1098 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1111, i8* %t1113, i64 %t1112)
  %t1114 = mul i64 %t1106, %t1104
  %t1115 = bitcast %Diagnostic* %t1102 to i8*
  %t1116 = getelementptr %Diagnostic, %Diagnostic* %t1110, i64 %t1100
  %t1117 = bitcast %Diagnostic* %t1116 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1117, i8* %t1115, i64 %t1114)
  %t1118 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1119 = ptrtoint { %Diagnostic*, i64 }* %t1118 to i64
  %t1120 = call i8* @malloc(i64 %t1119)
  %t1121 = bitcast i8* %t1120 to { %Diagnostic*, i64 }*
  %t1122 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1121, i32 0, i32 0
  store %Diagnostic* %t1110, %Diagnostic** %t1122
  %t1123 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1121, i32 0, i32 1
  store i64 %t1107, i64* %t1123
  store { %Diagnostic*, i64 }* %t1121, { %Diagnostic*, i64 }** %l8
  %t1124 = load %ScopeResult, %ScopeResult* %l7
  %t1125 = extractvalue %ScopeResult %t1124, 0
  %t1126 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t1125, 0
  %t1127 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l8
  %t1128 = insertvalue %ScopeResult %t1126, { %Diagnostic*, i64 }* %t1127, 1
  ret %ScopeResult %t1128
merge13:
  %t1129 = extractvalue %Statement %statement, 0
  %t1130 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1131 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1132 = icmp eq i32 %t1129, 0
  %t1133 = select i1 %t1132, i8* %t1131, i8* %t1130
  %t1134 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1135 = icmp eq i32 %t1129, 1
  %t1136 = select i1 %t1135, i8* %t1134, i8* %t1133
  %t1137 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1138 = icmp eq i32 %t1129, 2
  %t1139 = select i1 %t1138, i8* %t1137, i8* %t1136
  %t1140 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1141 = icmp eq i32 %t1129, 3
  %t1142 = select i1 %t1141, i8* %t1140, i8* %t1139
  %t1143 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1144 = icmp eq i32 %t1129, 4
  %t1145 = select i1 %t1144, i8* %t1143, i8* %t1142
  %t1146 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1147 = icmp eq i32 %t1129, 5
  %t1148 = select i1 %t1147, i8* %t1146, i8* %t1145
  %t1149 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1150 = icmp eq i32 %t1129, 6
  %t1151 = select i1 %t1150, i8* %t1149, i8* %t1148
  %t1152 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1153 = icmp eq i32 %t1129, 7
  %t1154 = select i1 %t1153, i8* %t1152, i8* %t1151
  %t1155 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1156 = icmp eq i32 %t1129, 8
  %t1157 = select i1 %t1156, i8* %t1155, i8* %t1154
  %t1158 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1159 = icmp eq i32 %t1129, 9
  %t1160 = select i1 %t1159, i8* %t1158, i8* %t1157
  %t1161 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1162 = icmp eq i32 %t1129, 10
  %t1163 = select i1 %t1162, i8* %t1161, i8* %t1160
  %t1164 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1165 = icmp eq i32 %t1129, 11
  %t1166 = select i1 %t1165, i8* %t1164, i8* %t1163
  %t1167 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1168 = icmp eq i32 %t1129, 12
  %t1169 = select i1 %t1168, i8* %t1167, i8* %t1166
  %t1170 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1171 = icmp eq i32 %t1129, 13
  %t1172 = select i1 %t1171, i8* %t1170, i8* %t1169
  %t1173 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1174 = icmp eq i32 %t1129, 14
  %t1175 = select i1 %t1174, i8* %t1173, i8* %t1172
  %t1176 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1177 = icmp eq i32 %t1129, 15
  %t1178 = select i1 %t1177, i8* %t1176, i8* %t1175
  %t1179 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1180 = icmp eq i32 %t1129, 16
  %t1181 = select i1 %t1180, i8* %t1179, i8* %t1178
  %t1182 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1183 = icmp eq i32 %t1129, 17
  %t1184 = select i1 %t1183, i8* %t1182, i8* %t1181
  %t1185 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1186 = icmp eq i32 %t1129, 18
  %t1187 = select i1 %t1186, i8* %t1185, i8* %t1184
  %t1188 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1189 = icmp eq i32 %t1129, 19
  %t1190 = select i1 %t1189, i8* %t1188, i8* %t1187
  %t1191 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t1192 = icmp eq i32 %t1129, 20
  %t1193 = select i1 %t1192, i8* %t1191, i8* %t1190
  %t1194 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1195 = icmp eq i32 %t1129, 21
  %t1196 = select i1 %t1195, i8* %t1194, i8* %t1193
  %t1197 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1198 = icmp eq i32 %t1129, 22
  %t1199 = select i1 %t1198, i8* %t1197, i8* %t1196
  %t1200 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1201 = icmp eq i32 %t1129, 23
  %t1202 = select i1 %t1201, i8* %t1200, i8* %t1199
  %t1203 = call i8* @malloc(i64 21)
  %t1204 = bitcast i8* %t1203 to [21 x i8]*
  store [21 x i8] c"InterfaceDeclaration\00", [21 x i8]* %t1204
  %t1205 = call i1 @strings_equal(i8* %t1202, i8* %t1203)
  br i1 %t1205, label %then14, label %merge15
then14:
  %t1206 = extractvalue %Statement %statement, 0
  %t1207 = alloca %Statement
  store %Statement %statement, %Statement* %t1207
  %t1208 = getelementptr inbounds %Statement, %Statement* %t1207, i32 0, i32 1
  %t1209 = bitcast [48 x i8]* %t1208 to i8*
  %t1210 = bitcast i8* %t1209 to i8**
  %t1211 = load i8*, i8** %t1210
  %t1212 = icmp eq i32 %t1206, 2
  %t1213 = select i1 %t1212, i8* %t1211, i8* null
  %t1214 = getelementptr inbounds %Statement, %Statement* %t1207, i32 0, i32 1
  %t1215 = bitcast [48 x i8]* %t1214 to i8*
  %t1216 = bitcast i8* %t1215 to i8**
  %t1217 = load i8*, i8** %t1216
  %t1218 = icmp eq i32 %t1206, 3
  %t1219 = select i1 %t1218, i8* %t1217, i8* %t1213
  %t1220 = getelementptr inbounds %Statement, %Statement* %t1207, i32 0, i32 1
  %t1221 = bitcast [56 x i8]* %t1220 to i8*
  %t1222 = bitcast i8* %t1221 to i8**
  %t1223 = load i8*, i8** %t1222
  %t1224 = icmp eq i32 %t1206, 6
  %t1225 = select i1 %t1224, i8* %t1223, i8* %t1219
  %t1226 = getelementptr inbounds %Statement, %Statement* %t1207, i32 0, i32 1
  %t1227 = bitcast [56 x i8]* %t1226 to i8*
  %t1228 = bitcast i8* %t1227 to i8**
  %t1229 = load i8*, i8** %t1228
  %t1230 = icmp eq i32 %t1206, 8
  %t1231 = select i1 %t1230, i8* %t1229, i8* %t1225
  %t1232 = getelementptr inbounds %Statement, %Statement* %t1207, i32 0, i32 1
  %t1233 = bitcast [40 x i8]* %t1232 to i8*
  %t1234 = bitcast i8* %t1233 to i8**
  %t1235 = load i8*, i8** %t1234
  %t1236 = icmp eq i32 %t1206, 9
  %t1237 = select i1 %t1236, i8* %t1235, i8* %t1231
  %t1238 = getelementptr inbounds %Statement, %Statement* %t1207, i32 0, i32 1
  %t1239 = bitcast [40 x i8]* %t1238 to i8*
  %t1240 = bitcast i8* %t1239 to i8**
  %t1241 = load i8*, i8** %t1240
  %t1242 = icmp eq i32 %t1206, 10
  %t1243 = select i1 %t1242, i8* %t1241, i8* %t1237
  %t1244 = getelementptr inbounds %Statement, %Statement* %t1207, i32 0, i32 1
  %t1245 = bitcast [40 x i8]* %t1244 to i8*
  %t1246 = bitcast i8* %t1245 to i8**
  %t1247 = load i8*, i8** %t1246
  %t1248 = icmp eq i32 %t1206, 11
  %t1249 = select i1 %t1248, i8* %t1247, i8* %t1243
  %t1250 = call i8* @malloc(i64 10)
  %t1251 = bitcast i8* %t1250 to [10 x i8]*
  store [10 x i8] c"interface\00", [10 x i8]* %t1251
  %t1252 = extractvalue %Statement %statement, 0
  %t1253 = alloca %Statement
  store %Statement %statement, %Statement* %t1253
  %t1254 = getelementptr inbounds %Statement, %Statement* %t1253, i32 0, i32 1
  %t1255 = bitcast [48 x i8]* %t1254 to i8*
  %t1256 = getelementptr inbounds i8, i8* %t1255, i64 8
  %t1257 = bitcast i8* %t1256 to %SourceSpan**
  %t1258 = load %SourceSpan*, %SourceSpan** %t1257
  %t1259 = icmp eq i32 %t1252, 3
  %t1260 = select i1 %t1259, %SourceSpan* %t1258, %SourceSpan* null
  %t1261 = getelementptr inbounds %Statement, %Statement* %t1253, i32 0, i32 1
  %t1262 = bitcast [56 x i8]* %t1261 to i8*
  %t1263 = getelementptr inbounds i8, i8* %t1262, i64 8
  %t1264 = bitcast i8* %t1263 to %SourceSpan**
  %t1265 = load %SourceSpan*, %SourceSpan** %t1264
  %t1266 = icmp eq i32 %t1252, 6
  %t1267 = select i1 %t1266, %SourceSpan* %t1265, %SourceSpan* %t1260
  %t1268 = getelementptr inbounds %Statement, %Statement* %t1253, i32 0, i32 1
  %t1269 = bitcast [56 x i8]* %t1268 to i8*
  %t1270 = getelementptr inbounds i8, i8* %t1269, i64 8
  %t1271 = bitcast i8* %t1270 to %SourceSpan**
  %t1272 = load %SourceSpan*, %SourceSpan** %t1271
  %t1273 = icmp eq i32 %t1252, 8
  %t1274 = select i1 %t1273, %SourceSpan* %t1272, %SourceSpan* %t1267
  %t1275 = getelementptr inbounds %Statement, %Statement* %t1253, i32 0, i32 1
  %t1276 = bitcast [40 x i8]* %t1275 to i8*
  %t1277 = getelementptr inbounds i8, i8* %t1276, i64 8
  %t1278 = bitcast i8* %t1277 to %SourceSpan**
  %t1279 = load %SourceSpan*, %SourceSpan** %t1278
  %t1280 = icmp eq i32 %t1252, 9
  %t1281 = select i1 %t1280, %SourceSpan* %t1279, %SourceSpan* %t1274
  %t1282 = getelementptr inbounds %Statement, %Statement* %t1253, i32 0, i32 1
  %t1283 = bitcast [40 x i8]* %t1282 to i8*
  %t1284 = getelementptr inbounds i8, i8* %t1283, i64 8
  %t1285 = bitcast i8* %t1284 to %SourceSpan**
  %t1286 = load %SourceSpan*, %SourceSpan** %t1285
  %t1287 = icmp eq i32 %t1252, 10
  %t1288 = select i1 %t1287, %SourceSpan* %t1286, %SourceSpan* %t1281
  %t1289 = getelementptr inbounds %Statement, %Statement* %t1253, i32 0, i32 1
  %t1290 = bitcast [40 x i8]* %t1289 to i8*
  %t1291 = getelementptr inbounds i8, i8* %t1290, i64 8
  %t1292 = bitcast i8* %t1291 to %SourceSpan**
  %t1293 = load %SourceSpan*, %SourceSpan** %t1292
  %t1294 = icmp eq i32 %t1252, 11
  %t1295 = select i1 %t1294, %SourceSpan* %t1293, %SourceSpan* %t1288
  %t1296 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1249, i8* %t1250, %SourceSpan* %t1295)
  store %ScopeResult %t1296, %ScopeResult* %l9
  %t1297 = load %ScopeResult, %ScopeResult* %l9
  %t1298 = extractvalue %ScopeResult %t1297, 1
  store { %Diagnostic*, i64 }* %t1298, { %Diagnostic*, i64 }** %l10
  %t1299 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l10
  %t1300 = extractvalue %Statement %statement, 0
  %t1301 = alloca %Statement
  store %Statement %statement, %Statement* %t1301
  %t1302 = getelementptr inbounds %Statement, %Statement* %t1301, i32 0, i32 1
  %t1303 = bitcast [56 x i8]* %t1302 to i8*
  %t1304 = getelementptr inbounds i8, i8* %t1303, i64 16
  %t1305 = bitcast i8* %t1304 to { %TypeParameter*, i64 }**
  %t1306 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1305
  %t1307 = icmp eq i32 %t1300, 8
  %t1308 = select i1 %t1307, { %TypeParameter*, i64 }* %t1306, { %TypeParameter*, i64 }* null
  %t1309 = getelementptr inbounds %Statement, %Statement* %t1301, i32 0, i32 1
  %t1310 = bitcast [40 x i8]* %t1309 to i8*
  %t1311 = getelementptr inbounds i8, i8* %t1310, i64 16
  %t1312 = bitcast i8* %t1311 to { %TypeParameter*, i64 }**
  %t1313 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1312
  %t1314 = icmp eq i32 %t1300, 9
  %t1315 = select i1 %t1314, { %TypeParameter*, i64 }* %t1313, { %TypeParameter*, i64 }* %t1308
  %t1316 = getelementptr inbounds %Statement, %Statement* %t1301, i32 0, i32 1
  %t1317 = bitcast [40 x i8]* %t1316 to i8*
  %t1318 = getelementptr inbounds i8, i8* %t1317, i64 16
  %t1319 = bitcast i8* %t1318 to { %TypeParameter*, i64 }**
  %t1320 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1319
  %t1321 = icmp eq i32 %t1300, 10
  %t1322 = select i1 %t1321, { %TypeParameter*, i64 }* %t1320, { %TypeParameter*, i64 }* %t1315
  %t1323 = getelementptr inbounds %Statement, %Statement* %t1301, i32 0, i32 1
  %t1324 = bitcast [40 x i8]* %t1323 to i8*
  %t1325 = getelementptr inbounds i8, i8* %t1324, i64 16
  %t1326 = bitcast i8* %t1325 to { %TypeParameter*, i64 }**
  %t1327 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1326
  %t1328 = icmp eq i32 %t1300, 11
  %t1329 = select i1 %t1328, { %TypeParameter*, i64 }* %t1327, { %TypeParameter*, i64 }* %t1322
  %t1330 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t1329)
  %t1331 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1299, i32 0, i32 0
  %t1332 = load %Diagnostic*, %Diagnostic** %t1331
  %t1333 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1299, i32 0, i32 1
  %t1334 = load i64, i64* %t1333
  %t1335 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1330, i32 0, i32 0
  %t1336 = load %Diagnostic*, %Diagnostic** %t1335
  %t1337 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1330, i32 0, i32 1
  %t1338 = load i64, i64* %t1337
  %t1339 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t1340 = ptrtoint %Diagnostic* %t1339 to i64
  %t1341 = add i64 %t1334, %t1338
  %t1342 = mul i64 %t1340, %t1341
  %t1343 = call noalias i8* @malloc(i64 %t1342)
  %t1344 = bitcast i8* %t1343 to %Diagnostic*
  %t1345 = bitcast %Diagnostic* %t1344 to i8*
  %t1346 = mul i64 %t1340, %t1334
  %t1347 = bitcast %Diagnostic* %t1332 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1345, i8* %t1347, i64 %t1346)
  %t1348 = mul i64 %t1340, %t1338
  %t1349 = bitcast %Diagnostic* %t1336 to i8*
  %t1350 = getelementptr %Diagnostic, %Diagnostic* %t1344, i64 %t1334
  %t1351 = bitcast %Diagnostic* %t1350 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1351, i8* %t1349, i64 %t1348)
  %t1352 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1353 = ptrtoint { %Diagnostic*, i64 }* %t1352 to i64
  %t1354 = call i8* @malloc(i64 %t1353)
  %t1355 = bitcast i8* %t1354 to { %Diagnostic*, i64 }*
  %t1356 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1355, i32 0, i32 0
  store %Diagnostic* %t1344, %Diagnostic** %t1356
  %t1357 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1355, i32 0, i32 1
  store i64 %t1341, i64* %t1357
  store { %Diagnostic*, i64 }* %t1355, { %Diagnostic*, i64 }** %l10
  %t1358 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l10
  %t1359 = extractvalue %Statement %statement, 0
  %t1360 = alloca %Statement
  store %Statement %statement, %Statement* %t1360
  %t1361 = getelementptr inbounds %Statement, %Statement* %t1360, i32 0, i32 1
  %t1362 = bitcast [40 x i8]* %t1361 to i8*
  %t1363 = getelementptr inbounds i8, i8* %t1362, i64 24
  %t1364 = bitcast i8* %t1363 to { %FunctionSignature*, i64 }**
  %t1365 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %t1364
  %t1366 = icmp eq i32 %t1359, 10
  %t1367 = select i1 %t1366, { %FunctionSignature*, i64 }* %t1365, { %FunctionSignature*, i64 }* null
  %t1368 = call { %Diagnostic*, i64 }* @check_interface_members({ %FunctionSignature*, i64 }* %t1367)
  %t1369 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1358, i32 0, i32 0
  %t1370 = load %Diagnostic*, %Diagnostic** %t1369
  %t1371 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1358, i32 0, i32 1
  %t1372 = load i64, i64* %t1371
  %t1373 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1368, i32 0, i32 0
  %t1374 = load %Diagnostic*, %Diagnostic** %t1373
  %t1375 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1368, i32 0, i32 1
  %t1376 = load i64, i64* %t1375
  %t1377 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t1378 = ptrtoint %Diagnostic* %t1377 to i64
  %t1379 = add i64 %t1372, %t1376
  %t1380 = mul i64 %t1378, %t1379
  %t1381 = call noalias i8* @malloc(i64 %t1380)
  %t1382 = bitcast i8* %t1381 to %Diagnostic*
  %t1383 = bitcast %Diagnostic* %t1382 to i8*
  %t1384 = mul i64 %t1378, %t1372
  %t1385 = bitcast %Diagnostic* %t1370 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1383, i8* %t1385, i64 %t1384)
  %t1386 = mul i64 %t1378, %t1376
  %t1387 = bitcast %Diagnostic* %t1374 to i8*
  %t1388 = getelementptr %Diagnostic, %Diagnostic* %t1382, i64 %t1372
  %t1389 = bitcast %Diagnostic* %t1388 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1389, i8* %t1387, i64 %t1386)
  %t1390 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1391 = ptrtoint { %Diagnostic*, i64 }* %t1390 to i64
  %t1392 = call i8* @malloc(i64 %t1391)
  %t1393 = bitcast i8* %t1392 to { %Diagnostic*, i64 }*
  %t1394 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1393, i32 0, i32 0
  store %Diagnostic* %t1382, %Diagnostic** %t1394
  %t1395 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1393, i32 0, i32 1
  store i64 %t1379, i64* %t1395
  store { %Diagnostic*, i64 }* %t1393, { %Diagnostic*, i64 }** %l10
  %t1396 = load %ScopeResult, %ScopeResult* %l9
  %t1397 = extractvalue %ScopeResult %t1396, 0
  %t1398 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t1397, 0
  %t1399 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l10
  %t1400 = insertvalue %ScopeResult %t1398, { %Diagnostic*, i64 }* %t1399, 1
  ret %ScopeResult %t1400
merge15:
  %t1401 = extractvalue %Statement %statement, 0
  %t1402 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1403 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1404 = icmp eq i32 %t1401, 0
  %t1405 = select i1 %t1404, i8* %t1403, i8* %t1402
  %t1406 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1407 = icmp eq i32 %t1401, 1
  %t1408 = select i1 %t1407, i8* %t1406, i8* %t1405
  %t1409 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1410 = icmp eq i32 %t1401, 2
  %t1411 = select i1 %t1410, i8* %t1409, i8* %t1408
  %t1412 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1413 = icmp eq i32 %t1401, 3
  %t1414 = select i1 %t1413, i8* %t1412, i8* %t1411
  %t1415 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1416 = icmp eq i32 %t1401, 4
  %t1417 = select i1 %t1416, i8* %t1415, i8* %t1414
  %t1418 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1419 = icmp eq i32 %t1401, 5
  %t1420 = select i1 %t1419, i8* %t1418, i8* %t1417
  %t1421 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1422 = icmp eq i32 %t1401, 6
  %t1423 = select i1 %t1422, i8* %t1421, i8* %t1420
  %t1424 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1425 = icmp eq i32 %t1401, 7
  %t1426 = select i1 %t1425, i8* %t1424, i8* %t1423
  %t1427 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1428 = icmp eq i32 %t1401, 8
  %t1429 = select i1 %t1428, i8* %t1427, i8* %t1426
  %t1430 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1431 = icmp eq i32 %t1401, 9
  %t1432 = select i1 %t1431, i8* %t1430, i8* %t1429
  %t1433 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1434 = icmp eq i32 %t1401, 10
  %t1435 = select i1 %t1434, i8* %t1433, i8* %t1432
  %t1436 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1437 = icmp eq i32 %t1401, 11
  %t1438 = select i1 %t1437, i8* %t1436, i8* %t1435
  %t1439 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1440 = icmp eq i32 %t1401, 12
  %t1441 = select i1 %t1440, i8* %t1439, i8* %t1438
  %t1442 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1443 = icmp eq i32 %t1401, 13
  %t1444 = select i1 %t1443, i8* %t1442, i8* %t1441
  %t1445 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1446 = icmp eq i32 %t1401, 14
  %t1447 = select i1 %t1446, i8* %t1445, i8* %t1444
  %t1448 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1449 = icmp eq i32 %t1401, 15
  %t1450 = select i1 %t1449, i8* %t1448, i8* %t1447
  %t1451 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1452 = icmp eq i32 %t1401, 16
  %t1453 = select i1 %t1452, i8* %t1451, i8* %t1450
  %t1454 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1455 = icmp eq i32 %t1401, 17
  %t1456 = select i1 %t1455, i8* %t1454, i8* %t1453
  %t1457 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1458 = icmp eq i32 %t1401, 18
  %t1459 = select i1 %t1458, i8* %t1457, i8* %t1456
  %t1460 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1461 = icmp eq i32 %t1401, 19
  %t1462 = select i1 %t1461, i8* %t1460, i8* %t1459
  %t1463 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t1464 = icmp eq i32 %t1401, 20
  %t1465 = select i1 %t1464, i8* %t1463, i8* %t1462
  %t1466 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1467 = icmp eq i32 %t1401, 21
  %t1468 = select i1 %t1467, i8* %t1466, i8* %t1465
  %t1469 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1470 = icmp eq i32 %t1401, 22
  %t1471 = select i1 %t1470, i8* %t1469, i8* %t1468
  %t1472 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1473 = icmp eq i32 %t1401, 23
  %t1474 = select i1 %t1473, i8* %t1472, i8* %t1471
  %t1475 = call i8* @malloc(i64 17)
  %t1476 = bitcast i8* %t1475 to [17 x i8]*
  store [17 x i8] c"ModelDeclaration\00", [17 x i8]* %t1476
  %t1477 = call i1 @strings_equal(i8* %t1474, i8* %t1475)
  br i1 %t1477, label %then16, label %merge17
then16:
  %t1478 = extractvalue %Statement %statement, 0
  %t1479 = alloca %Statement
  store %Statement %statement, %Statement* %t1479
  %t1480 = getelementptr inbounds %Statement, %Statement* %t1479, i32 0, i32 1
  %t1481 = bitcast [48 x i8]* %t1480 to i8*
  %t1482 = bitcast i8* %t1481 to i8**
  %t1483 = load i8*, i8** %t1482
  %t1484 = icmp eq i32 %t1478, 2
  %t1485 = select i1 %t1484, i8* %t1483, i8* null
  %t1486 = getelementptr inbounds %Statement, %Statement* %t1479, i32 0, i32 1
  %t1487 = bitcast [48 x i8]* %t1486 to i8*
  %t1488 = bitcast i8* %t1487 to i8**
  %t1489 = load i8*, i8** %t1488
  %t1490 = icmp eq i32 %t1478, 3
  %t1491 = select i1 %t1490, i8* %t1489, i8* %t1485
  %t1492 = getelementptr inbounds %Statement, %Statement* %t1479, i32 0, i32 1
  %t1493 = bitcast [56 x i8]* %t1492 to i8*
  %t1494 = bitcast i8* %t1493 to i8**
  %t1495 = load i8*, i8** %t1494
  %t1496 = icmp eq i32 %t1478, 6
  %t1497 = select i1 %t1496, i8* %t1495, i8* %t1491
  %t1498 = getelementptr inbounds %Statement, %Statement* %t1479, i32 0, i32 1
  %t1499 = bitcast [56 x i8]* %t1498 to i8*
  %t1500 = bitcast i8* %t1499 to i8**
  %t1501 = load i8*, i8** %t1500
  %t1502 = icmp eq i32 %t1478, 8
  %t1503 = select i1 %t1502, i8* %t1501, i8* %t1497
  %t1504 = getelementptr inbounds %Statement, %Statement* %t1479, i32 0, i32 1
  %t1505 = bitcast [40 x i8]* %t1504 to i8*
  %t1506 = bitcast i8* %t1505 to i8**
  %t1507 = load i8*, i8** %t1506
  %t1508 = icmp eq i32 %t1478, 9
  %t1509 = select i1 %t1508, i8* %t1507, i8* %t1503
  %t1510 = getelementptr inbounds %Statement, %Statement* %t1479, i32 0, i32 1
  %t1511 = bitcast [40 x i8]* %t1510 to i8*
  %t1512 = bitcast i8* %t1511 to i8**
  %t1513 = load i8*, i8** %t1512
  %t1514 = icmp eq i32 %t1478, 10
  %t1515 = select i1 %t1514, i8* %t1513, i8* %t1509
  %t1516 = getelementptr inbounds %Statement, %Statement* %t1479, i32 0, i32 1
  %t1517 = bitcast [40 x i8]* %t1516 to i8*
  %t1518 = bitcast i8* %t1517 to i8**
  %t1519 = load i8*, i8** %t1518
  %t1520 = icmp eq i32 %t1478, 11
  %t1521 = select i1 %t1520, i8* %t1519, i8* %t1515
  %t1522 = call i8* @malloc(i64 6)
  %t1523 = bitcast i8* %t1522 to [6 x i8]*
  store [6 x i8] c"model\00", [6 x i8]* %t1523
  %t1524 = extractvalue %Statement %statement, 0
  %t1525 = alloca %Statement
  store %Statement %statement, %Statement* %t1525
  %t1526 = getelementptr inbounds %Statement, %Statement* %t1525, i32 0, i32 1
  %t1527 = bitcast [48 x i8]* %t1526 to i8*
  %t1528 = getelementptr inbounds i8, i8* %t1527, i64 8
  %t1529 = bitcast i8* %t1528 to %SourceSpan**
  %t1530 = load %SourceSpan*, %SourceSpan** %t1529
  %t1531 = icmp eq i32 %t1524, 3
  %t1532 = select i1 %t1531, %SourceSpan* %t1530, %SourceSpan* null
  %t1533 = getelementptr inbounds %Statement, %Statement* %t1525, i32 0, i32 1
  %t1534 = bitcast [56 x i8]* %t1533 to i8*
  %t1535 = getelementptr inbounds i8, i8* %t1534, i64 8
  %t1536 = bitcast i8* %t1535 to %SourceSpan**
  %t1537 = load %SourceSpan*, %SourceSpan** %t1536
  %t1538 = icmp eq i32 %t1524, 6
  %t1539 = select i1 %t1538, %SourceSpan* %t1537, %SourceSpan* %t1532
  %t1540 = getelementptr inbounds %Statement, %Statement* %t1525, i32 0, i32 1
  %t1541 = bitcast [56 x i8]* %t1540 to i8*
  %t1542 = getelementptr inbounds i8, i8* %t1541, i64 8
  %t1543 = bitcast i8* %t1542 to %SourceSpan**
  %t1544 = load %SourceSpan*, %SourceSpan** %t1543
  %t1545 = icmp eq i32 %t1524, 8
  %t1546 = select i1 %t1545, %SourceSpan* %t1544, %SourceSpan* %t1539
  %t1547 = getelementptr inbounds %Statement, %Statement* %t1525, i32 0, i32 1
  %t1548 = bitcast [40 x i8]* %t1547 to i8*
  %t1549 = getelementptr inbounds i8, i8* %t1548, i64 8
  %t1550 = bitcast i8* %t1549 to %SourceSpan**
  %t1551 = load %SourceSpan*, %SourceSpan** %t1550
  %t1552 = icmp eq i32 %t1524, 9
  %t1553 = select i1 %t1552, %SourceSpan* %t1551, %SourceSpan* %t1546
  %t1554 = getelementptr inbounds %Statement, %Statement* %t1525, i32 0, i32 1
  %t1555 = bitcast [40 x i8]* %t1554 to i8*
  %t1556 = getelementptr inbounds i8, i8* %t1555, i64 8
  %t1557 = bitcast i8* %t1556 to %SourceSpan**
  %t1558 = load %SourceSpan*, %SourceSpan** %t1557
  %t1559 = icmp eq i32 %t1524, 10
  %t1560 = select i1 %t1559, %SourceSpan* %t1558, %SourceSpan* %t1553
  %t1561 = getelementptr inbounds %Statement, %Statement* %t1525, i32 0, i32 1
  %t1562 = bitcast [40 x i8]* %t1561 to i8*
  %t1563 = getelementptr inbounds i8, i8* %t1562, i64 8
  %t1564 = bitcast i8* %t1563 to %SourceSpan**
  %t1565 = load %SourceSpan*, %SourceSpan** %t1564
  %t1566 = icmp eq i32 %t1524, 11
  %t1567 = select i1 %t1566, %SourceSpan* %t1565, %SourceSpan* %t1560
  %t1568 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1521, i8* %t1522, %SourceSpan* %t1567)
  store %ScopeResult %t1568, %ScopeResult* %l11
  %t1569 = load %ScopeResult, %ScopeResult* %l11
  %t1570 = extractvalue %ScopeResult %t1569, 1
  %t1571 = extractvalue %Statement %statement, 0
  %t1572 = alloca %Statement
  store %Statement %statement, %Statement* %t1572
  %t1573 = getelementptr inbounds %Statement, %Statement* %t1572, i32 0, i32 1
  %t1574 = bitcast [48 x i8]* %t1573 to i8*
  %t1575 = getelementptr inbounds i8, i8* %t1574, i64 24
  %t1576 = bitcast i8* %t1575 to { %ModelProperty*, i64 }**
  %t1577 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %t1576
  %t1578 = icmp eq i32 %t1571, 3
  %t1579 = select i1 %t1578, { %ModelProperty*, i64 }* %t1577, { %ModelProperty*, i64 }* null
  %t1580 = call { %Diagnostic*, i64 }* @check_model_properties({ %ModelProperty*, i64 }* %t1579)
  %t1581 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1570, i32 0, i32 0
  %t1582 = load %Diagnostic*, %Diagnostic** %t1581
  %t1583 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1570, i32 0, i32 1
  %t1584 = load i64, i64* %t1583
  %t1585 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1580, i32 0, i32 0
  %t1586 = load %Diagnostic*, %Diagnostic** %t1585
  %t1587 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1580, i32 0, i32 1
  %t1588 = load i64, i64* %t1587
  %t1589 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t1590 = ptrtoint %Diagnostic* %t1589 to i64
  %t1591 = add i64 %t1584, %t1588
  %t1592 = mul i64 %t1590, %t1591
  %t1593 = call noalias i8* @malloc(i64 %t1592)
  %t1594 = bitcast i8* %t1593 to %Diagnostic*
  %t1595 = bitcast %Diagnostic* %t1594 to i8*
  %t1596 = mul i64 %t1590, %t1584
  %t1597 = bitcast %Diagnostic* %t1582 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1595, i8* %t1597, i64 %t1596)
  %t1598 = mul i64 %t1590, %t1588
  %t1599 = bitcast %Diagnostic* %t1586 to i8*
  %t1600 = getelementptr %Diagnostic, %Diagnostic* %t1594, i64 %t1584
  %t1601 = bitcast %Diagnostic* %t1600 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1601, i8* %t1599, i64 %t1598)
  %t1602 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1603 = ptrtoint { %Diagnostic*, i64 }* %t1602 to i64
  %t1604 = call i8* @malloc(i64 %t1603)
  %t1605 = bitcast i8* %t1604 to { %Diagnostic*, i64 }*
  %t1606 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1605, i32 0, i32 0
  store %Diagnostic* %t1594, %Diagnostic** %t1606
  %t1607 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1605, i32 0, i32 1
  store i64 %t1591, i64* %t1607
  store { %Diagnostic*, i64 }* %t1605, { %Diagnostic*, i64 }** %l12
  %t1608 = load %ScopeResult, %ScopeResult* %l11
  %t1609 = extractvalue %ScopeResult %t1608, 0
  %t1610 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t1609, 0
  %t1611 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l12
  %t1612 = insertvalue %ScopeResult %t1610, { %Diagnostic*, i64 }* %t1611, 1
  ret %ScopeResult %t1612
merge17:
  %t1613 = extractvalue %Statement %statement, 0
  %t1614 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1615 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1616 = icmp eq i32 %t1613, 0
  %t1617 = select i1 %t1616, i8* %t1615, i8* %t1614
  %t1618 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1619 = icmp eq i32 %t1613, 1
  %t1620 = select i1 %t1619, i8* %t1618, i8* %t1617
  %t1621 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1622 = icmp eq i32 %t1613, 2
  %t1623 = select i1 %t1622, i8* %t1621, i8* %t1620
  %t1624 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1625 = icmp eq i32 %t1613, 3
  %t1626 = select i1 %t1625, i8* %t1624, i8* %t1623
  %t1627 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1628 = icmp eq i32 %t1613, 4
  %t1629 = select i1 %t1628, i8* %t1627, i8* %t1626
  %t1630 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1631 = icmp eq i32 %t1613, 5
  %t1632 = select i1 %t1631, i8* %t1630, i8* %t1629
  %t1633 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1634 = icmp eq i32 %t1613, 6
  %t1635 = select i1 %t1634, i8* %t1633, i8* %t1632
  %t1636 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1637 = icmp eq i32 %t1613, 7
  %t1638 = select i1 %t1637, i8* %t1636, i8* %t1635
  %t1639 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1640 = icmp eq i32 %t1613, 8
  %t1641 = select i1 %t1640, i8* %t1639, i8* %t1638
  %t1642 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1643 = icmp eq i32 %t1613, 9
  %t1644 = select i1 %t1643, i8* %t1642, i8* %t1641
  %t1645 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1646 = icmp eq i32 %t1613, 10
  %t1647 = select i1 %t1646, i8* %t1645, i8* %t1644
  %t1648 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1649 = icmp eq i32 %t1613, 11
  %t1650 = select i1 %t1649, i8* %t1648, i8* %t1647
  %t1651 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1652 = icmp eq i32 %t1613, 12
  %t1653 = select i1 %t1652, i8* %t1651, i8* %t1650
  %t1654 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1655 = icmp eq i32 %t1613, 13
  %t1656 = select i1 %t1655, i8* %t1654, i8* %t1653
  %t1657 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1658 = icmp eq i32 %t1613, 14
  %t1659 = select i1 %t1658, i8* %t1657, i8* %t1656
  %t1660 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1661 = icmp eq i32 %t1613, 15
  %t1662 = select i1 %t1661, i8* %t1660, i8* %t1659
  %t1663 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1664 = icmp eq i32 %t1613, 16
  %t1665 = select i1 %t1664, i8* %t1663, i8* %t1662
  %t1666 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1667 = icmp eq i32 %t1613, 17
  %t1668 = select i1 %t1667, i8* %t1666, i8* %t1665
  %t1669 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1670 = icmp eq i32 %t1613, 18
  %t1671 = select i1 %t1670, i8* %t1669, i8* %t1668
  %t1672 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1673 = icmp eq i32 %t1613, 19
  %t1674 = select i1 %t1673, i8* %t1672, i8* %t1671
  %t1675 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t1676 = icmp eq i32 %t1613, 20
  %t1677 = select i1 %t1676, i8* %t1675, i8* %t1674
  %t1678 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1679 = icmp eq i32 %t1613, 21
  %t1680 = select i1 %t1679, i8* %t1678, i8* %t1677
  %t1681 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1682 = icmp eq i32 %t1613, 22
  %t1683 = select i1 %t1682, i8* %t1681, i8* %t1680
  %t1684 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1685 = icmp eq i32 %t1613, 23
  %t1686 = select i1 %t1685, i8* %t1684, i8* %t1683
  %t1687 = call i8* @malloc(i64 20)
  %t1688 = bitcast i8* %t1687 to [20 x i8]*
  store [20 x i8] c"PipelineDeclaration\00", [20 x i8]* %t1688
  %t1689 = call i1 @strings_equal(i8* %t1686, i8* %t1687)
  br i1 %t1689, label %then18, label %merge19
then18:
  %t1690 = extractvalue %Statement %statement, 0
  %t1691 = alloca %Statement
  store %Statement %statement, %Statement* %t1691
  %t1692 = getelementptr inbounds %Statement, %Statement* %t1691, i32 0, i32 1
  %t1693 = bitcast [88 x i8]* %t1692 to i8*
  %t1694 = bitcast i8* %t1693 to %FunctionSignature*
  %t1695 = load %FunctionSignature, %FunctionSignature* %t1694
  %t1696 = icmp eq i32 %t1690, 4
  %t1697 = select i1 %t1696, %FunctionSignature %t1695, %FunctionSignature zeroinitializer
  %t1698 = getelementptr inbounds %Statement, %Statement* %t1691, i32 0, i32 1
  %t1699 = bitcast [88 x i8]* %t1698 to i8*
  %t1700 = bitcast i8* %t1699 to %FunctionSignature*
  %t1701 = load %FunctionSignature, %FunctionSignature* %t1700
  %t1702 = icmp eq i32 %t1690, 5
  %t1703 = select i1 %t1702, %FunctionSignature %t1701, %FunctionSignature %t1697
  %t1704 = getelementptr inbounds %Statement, %Statement* %t1691, i32 0, i32 1
  %t1705 = bitcast [88 x i8]* %t1704 to i8*
  %t1706 = bitcast i8* %t1705 to %FunctionSignature*
  %t1707 = load %FunctionSignature, %FunctionSignature* %t1706
  %t1708 = icmp eq i32 %t1690, 7
  %t1709 = select i1 %t1708, %FunctionSignature %t1707, %FunctionSignature %t1703
  %t1710 = extractvalue %FunctionSignature %t1709, 0
  %t1711 = call i8* @malloc(i64 9)
  %t1712 = bitcast i8* %t1711 to [9 x i8]*
  store [9 x i8] c"pipeline\00", [9 x i8]* %t1712
  %t1713 = extractvalue %Statement %statement, 0
  %t1714 = alloca %Statement
  store %Statement %statement, %Statement* %t1714
  %t1715 = getelementptr inbounds %Statement, %Statement* %t1714, i32 0, i32 1
  %t1716 = bitcast [88 x i8]* %t1715 to i8*
  %t1717 = bitcast i8* %t1716 to %FunctionSignature*
  %t1718 = load %FunctionSignature, %FunctionSignature* %t1717
  %t1719 = icmp eq i32 %t1713, 4
  %t1720 = select i1 %t1719, %FunctionSignature %t1718, %FunctionSignature zeroinitializer
  %t1721 = getelementptr inbounds %Statement, %Statement* %t1714, i32 0, i32 1
  %t1722 = bitcast [88 x i8]* %t1721 to i8*
  %t1723 = bitcast i8* %t1722 to %FunctionSignature*
  %t1724 = load %FunctionSignature, %FunctionSignature* %t1723
  %t1725 = icmp eq i32 %t1713, 5
  %t1726 = select i1 %t1725, %FunctionSignature %t1724, %FunctionSignature %t1720
  %t1727 = getelementptr inbounds %Statement, %Statement* %t1714, i32 0, i32 1
  %t1728 = bitcast [88 x i8]* %t1727 to i8*
  %t1729 = bitcast i8* %t1728 to %FunctionSignature*
  %t1730 = load %FunctionSignature, %FunctionSignature* %t1729
  %t1731 = icmp eq i32 %t1713, 7
  %t1732 = select i1 %t1731, %FunctionSignature %t1730, %FunctionSignature %t1726
  %t1733 = extractvalue %FunctionSignature %t1732, 6
  %t1734 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1710, i8* %t1711, %SourceSpan* %t1733)
  store %ScopeResult %t1734, %ScopeResult* %l13
  %t1735 = load %ScopeResult, %ScopeResult* %l13
  %t1736 = extractvalue %ScopeResult %t1735, 1
  store { %Diagnostic*, i64 }* %t1736, { %Diagnostic*, i64 }** %l14
  %t1737 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l14
  %t1738 = extractvalue %Statement %statement, 0
  %t1739 = alloca %Statement
  store %Statement %statement, %Statement* %t1739
  %t1740 = getelementptr inbounds %Statement, %Statement* %t1739, i32 0, i32 1
  %t1741 = bitcast [88 x i8]* %t1740 to i8*
  %t1742 = bitcast i8* %t1741 to %FunctionSignature*
  %t1743 = load %FunctionSignature, %FunctionSignature* %t1742
  %t1744 = icmp eq i32 %t1738, 4
  %t1745 = select i1 %t1744, %FunctionSignature %t1743, %FunctionSignature zeroinitializer
  %t1746 = getelementptr inbounds %Statement, %Statement* %t1739, i32 0, i32 1
  %t1747 = bitcast [88 x i8]* %t1746 to i8*
  %t1748 = bitcast i8* %t1747 to %FunctionSignature*
  %t1749 = load %FunctionSignature, %FunctionSignature* %t1748
  %t1750 = icmp eq i32 %t1738, 5
  %t1751 = select i1 %t1750, %FunctionSignature %t1749, %FunctionSignature %t1745
  %t1752 = getelementptr inbounds %Statement, %Statement* %t1739, i32 0, i32 1
  %t1753 = bitcast [88 x i8]* %t1752 to i8*
  %t1754 = bitcast i8* %t1753 to %FunctionSignature*
  %t1755 = load %FunctionSignature, %FunctionSignature* %t1754
  %t1756 = icmp eq i32 %t1738, 7
  %t1757 = select i1 %t1756, %FunctionSignature %t1755, %FunctionSignature %t1751
  %t1758 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t1757)
  %t1759 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1737, i32 0, i32 0
  %t1760 = load %Diagnostic*, %Diagnostic** %t1759
  %t1761 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1737, i32 0, i32 1
  %t1762 = load i64, i64* %t1761
  %t1763 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1758, i32 0, i32 0
  %t1764 = load %Diagnostic*, %Diagnostic** %t1763
  %t1765 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1758, i32 0, i32 1
  %t1766 = load i64, i64* %t1765
  %t1767 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t1768 = ptrtoint %Diagnostic* %t1767 to i64
  %t1769 = add i64 %t1762, %t1766
  %t1770 = mul i64 %t1768, %t1769
  %t1771 = call noalias i8* @malloc(i64 %t1770)
  %t1772 = bitcast i8* %t1771 to %Diagnostic*
  %t1773 = bitcast %Diagnostic* %t1772 to i8*
  %t1774 = mul i64 %t1768, %t1762
  %t1775 = bitcast %Diagnostic* %t1760 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1773, i8* %t1775, i64 %t1774)
  %t1776 = mul i64 %t1768, %t1766
  %t1777 = bitcast %Diagnostic* %t1764 to i8*
  %t1778 = getelementptr %Diagnostic, %Diagnostic* %t1772, i64 %t1762
  %t1779 = bitcast %Diagnostic* %t1778 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1779, i8* %t1777, i64 %t1776)
  %t1780 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1781 = ptrtoint { %Diagnostic*, i64 }* %t1780 to i64
  %t1782 = call i8* @malloc(i64 %t1781)
  %t1783 = bitcast i8* %t1782 to { %Diagnostic*, i64 }*
  %t1784 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1783, i32 0, i32 0
  store %Diagnostic* %t1772, %Diagnostic** %t1784
  %t1785 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1783, i32 0, i32 1
  store i64 %t1769, i64* %t1785
  store { %Diagnostic*, i64 }* %t1783, { %Diagnostic*, i64 }** %l14
  %t1786 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l14
  %t1787 = extractvalue %Statement %statement, 0
  %t1788 = alloca %Statement
  store %Statement %statement, %Statement* %t1788
  %t1789 = getelementptr inbounds %Statement, %Statement* %t1788, i32 0, i32 1
  %t1790 = bitcast [88 x i8]* %t1789 to i8*
  %t1791 = bitcast i8* %t1790 to %FunctionSignature*
  %t1792 = load %FunctionSignature, %FunctionSignature* %t1791
  %t1793 = icmp eq i32 %t1787, 4
  %t1794 = select i1 %t1793, %FunctionSignature %t1792, %FunctionSignature zeroinitializer
  %t1795 = getelementptr inbounds %Statement, %Statement* %t1788, i32 0, i32 1
  %t1796 = bitcast [88 x i8]* %t1795 to i8*
  %t1797 = bitcast i8* %t1796 to %FunctionSignature*
  %t1798 = load %FunctionSignature, %FunctionSignature* %t1797
  %t1799 = icmp eq i32 %t1787, 5
  %t1800 = select i1 %t1799, %FunctionSignature %t1798, %FunctionSignature %t1794
  %t1801 = getelementptr inbounds %Statement, %Statement* %t1788, i32 0, i32 1
  %t1802 = bitcast [88 x i8]* %t1801 to i8*
  %t1803 = bitcast i8* %t1802 to %FunctionSignature*
  %t1804 = load %FunctionSignature, %FunctionSignature* %t1803
  %t1805 = icmp eq i32 %t1787, 7
  %t1806 = select i1 %t1805, %FunctionSignature %t1804, %FunctionSignature %t1800
  %t1807 = extractvalue %Statement %statement, 0
  %t1808 = alloca %Statement
  store %Statement %statement, %Statement* %t1808
  %t1809 = getelementptr inbounds %Statement, %Statement* %t1808, i32 0, i32 1
  %t1810 = bitcast [88 x i8]* %t1809 to i8*
  %t1811 = getelementptr inbounds i8, i8* %t1810, i64 56
  %t1812 = bitcast i8* %t1811 to %Block*
  %t1813 = load %Block, %Block* %t1812
  %t1814 = icmp eq i32 %t1807, 4
  %t1815 = select i1 %t1814, %Block %t1813, %Block zeroinitializer
  %t1816 = getelementptr inbounds %Statement, %Statement* %t1808, i32 0, i32 1
  %t1817 = bitcast [88 x i8]* %t1816 to i8*
  %t1818 = getelementptr inbounds i8, i8* %t1817, i64 56
  %t1819 = bitcast i8* %t1818 to %Block*
  %t1820 = load %Block, %Block* %t1819
  %t1821 = icmp eq i32 %t1807, 5
  %t1822 = select i1 %t1821, %Block %t1820, %Block %t1815
  %t1823 = getelementptr inbounds %Statement, %Statement* %t1808, i32 0, i32 1
  %t1824 = bitcast [56 x i8]* %t1823 to i8*
  %t1825 = getelementptr inbounds i8, i8* %t1824, i64 16
  %t1826 = bitcast i8* %t1825 to %Block*
  %t1827 = load %Block, %Block* %t1826
  %t1828 = icmp eq i32 %t1807, 6
  %t1829 = select i1 %t1828, %Block %t1827, %Block %t1822
  %t1830 = getelementptr inbounds %Statement, %Statement* %t1808, i32 0, i32 1
  %t1831 = bitcast [88 x i8]* %t1830 to i8*
  %t1832 = getelementptr inbounds i8, i8* %t1831, i64 56
  %t1833 = bitcast i8* %t1832 to %Block*
  %t1834 = load %Block, %Block* %t1833
  %t1835 = icmp eq i32 %t1807, 7
  %t1836 = select i1 %t1835, %Block %t1834, %Block %t1829
  %t1837 = getelementptr inbounds %Statement, %Statement* %t1808, i32 0, i32 1
  %t1838 = bitcast [120 x i8]* %t1837 to i8*
  %t1839 = getelementptr inbounds i8, i8* %t1838, i64 88
  %t1840 = bitcast i8* %t1839 to %Block*
  %t1841 = load %Block, %Block* %t1840
  %t1842 = icmp eq i32 %t1807, 12
  %t1843 = select i1 %t1842, %Block %t1841, %Block %t1836
  %t1844 = getelementptr inbounds %Statement, %Statement* %t1808, i32 0, i32 1
  %t1845 = bitcast [40 x i8]* %t1844 to i8*
  %t1846 = getelementptr inbounds i8, i8* %t1845, i64 8
  %t1847 = bitcast i8* %t1846 to %Block*
  %t1848 = load %Block, %Block* %t1847
  %t1849 = icmp eq i32 %t1807, 13
  %t1850 = select i1 %t1849, %Block %t1848, %Block %t1843
  %t1851 = getelementptr inbounds %Statement, %Statement* %t1808, i32 0, i32 1
  %t1852 = bitcast [136 x i8]* %t1851 to i8*
  %t1853 = getelementptr inbounds i8, i8* %t1852, i64 104
  %t1854 = bitcast i8* %t1853 to %Block*
  %t1855 = load %Block, %Block* %t1854
  %t1856 = icmp eq i32 %t1807, 14
  %t1857 = select i1 %t1856, %Block %t1855, %Block %t1850
  %t1858 = getelementptr inbounds %Statement, %Statement* %t1808, i32 0, i32 1
  %t1859 = bitcast [32 x i8]* %t1858 to i8*
  %t1860 = bitcast i8* %t1859 to %Block*
  %t1861 = load %Block, %Block* %t1860
  %t1862 = icmp eq i32 %t1807, 15
  %t1863 = select i1 %t1862, %Block %t1861, %Block %t1857
  %t1864 = getelementptr inbounds %Statement, %Statement* %t1808, i32 0, i32 1
  %t1865 = bitcast [24 x i8]* %t1864 to i8*
  %t1866 = bitcast i8* %t1865 to %Block*
  %t1867 = load %Block, %Block* %t1866
  %t1868 = icmp eq i32 %t1807, 20
  %t1869 = select i1 %t1868, %Block %t1867, %Block %t1863
  %t1870 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t1806, %Block %t1869, { %Statement*, i64 }* %interfaces)
  %t1871 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1786, i32 0, i32 0
  %t1872 = load %Diagnostic*, %Diagnostic** %t1871
  %t1873 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1786, i32 0, i32 1
  %t1874 = load i64, i64* %t1873
  %t1875 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1870, i32 0, i32 0
  %t1876 = load %Diagnostic*, %Diagnostic** %t1875
  %t1877 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1870, i32 0, i32 1
  %t1878 = load i64, i64* %t1877
  %t1879 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t1880 = ptrtoint %Diagnostic* %t1879 to i64
  %t1881 = add i64 %t1874, %t1878
  %t1882 = mul i64 %t1880, %t1881
  %t1883 = call noalias i8* @malloc(i64 %t1882)
  %t1884 = bitcast i8* %t1883 to %Diagnostic*
  %t1885 = bitcast %Diagnostic* %t1884 to i8*
  %t1886 = mul i64 %t1880, %t1874
  %t1887 = bitcast %Diagnostic* %t1872 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1885, i8* %t1887, i64 %t1886)
  %t1888 = mul i64 %t1880, %t1878
  %t1889 = bitcast %Diagnostic* %t1876 to i8*
  %t1890 = getelementptr %Diagnostic, %Diagnostic* %t1884, i64 %t1874
  %t1891 = bitcast %Diagnostic* %t1890 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1891, i8* %t1889, i64 %t1888)
  %t1892 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1893 = ptrtoint { %Diagnostic*, i64 }* %t1892 to i64
  %t1894 = call i8* @malloc(i64 %t1893)
  %t1895 = bitcast i8* %t1894 to { %Diagnostic*, i64 }*
  %t1896 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1895, i32 0, i32 0
  store %Diagnostic* %t1884, %Diagnostic** %t1896
  %t1897 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1895, i32 0, i32 1
  store i64 %t1881, i64* %t1897
  store { %Diagnostic*, i64 }* %t1895, { %Diagnostic*, i64 }** %l14
  %t1898 = load %ScopeResult, %ScopeResult* %l13
  %t1899 = extractvalue %ScopeResult %t1898, 0
  %t1900 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t1899, 0
  %t1901 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l14
  %t1902 = insertvalue %ScopeResult %t1900, { %Diagnostic*, i64 }* %t1901, 1
  ret %ScopeResult %t1902
merge19:
  %t1903 = extractvalue %Statement %statement, 0
  %t1904 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1905 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1906 = icmp eq i32 %t1903, 0
  %t1907 = select i1 %t1906, i8* %t1905, i8* %t1904
  %t1908 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1909 = icmp eq i32 %t1903, 1
  %t1910 = select i1 %t1909, i8* %t1908, i8* %t1907
  %t1911 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1912 = icmp eq i32 %t1903, 2
  %t1913 = select i1 %t1912, i8* %t1911, i8* %t1910
  %t1914 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1915 = icmp eq i32 %t1903, 3
  %t1916 = select i1 %t1915, i8* %t1914, i8* %t1913
  %t1917 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1918 = icmp eq i32 %t1903, 4
  %t1919 = select i1 %t1918, i8* %t1917, i8* %t1916
  %t1920 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1921 = icmp eq i32 %t1903, 5
  %t1922 = select i1 %t1921, i8* %t1920, i8* %t1919
  %t1923 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1924 = icmp eq i32 %t1903, 6
  %t1925 = select i1 %t1924, i8* %t1923, i8* %t1922
  %t1926 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1927 = icmp eq i32 %t1903, 7
  %t1928 = select i1 %t1927, i8* %t1926, i8* %t1925
  %t1929 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1930 = icmp eq i32 %t1903, 8
  %t1931 = select i1 %t1930, i8* %t1929, i8* %t1928
  %t1932 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1933 = icmp eq i32 %t1903, 9
  %t1934 = select i1 %t1933, i8* %t1932, i8* %t1931
  %t1935 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1936 = icmp eq i32 %t1903, 10
  %t1937 = select i1 %t1936, i8* %t1935, i8* %t1934
  %t1938 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1939 = icmp eq i32 %t1903, 11
  %t1940 = select i1 %t1939, i8* %t1938, i8* %t1937
  %t1941 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1942 = icmp eq i32 %t1903, 12
  %t1943 = select i1 %t1942, i8* %t1941, i8* %t1940
  %t1944 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1945 = icmp eq i32 %t1903, 13
  %t1946 = select i1 %t1945, i8* %t1944, i8* %t1943
  %t1947 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1948 = icmp eq i32 %t1903, 14
  %t1949 = select i1 %t1948, i8* %t1947, i8* %t1946
  %t1950 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1951 = icmp eq i32 %t1903, 15
  %t1952 = select i1 %t1951, i8* %t1950, i8* %t1949
  %t1953 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1954 = icmp eq i32 %t1903, 16
  %t1955 = select i1 %t1954, i8* %t1953, i8* %t1952
  %t1956 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1957 = icmp eq i32 %t1903, 17
  %t1958 = select i1 %t1957, i8* %t1956, i8* %t1955
  %t1959 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1960 = icmp eq i32 %t1903, 18
  %t1961 = select i1 %t1960, i8* %t1959, i8* %t1958
  %t1962 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1963 = icmp eq i32 %t1903, 19
  %t1964 = select i1 %t1963, i8* %t1962, i8* %t1961
  %t1965 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t1966 = icmp eq i32 %t1903, 20
  %t1967 = select i1 %t1966, i8* %t1965, i8* %t1964
  %t1968 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1969 = icmp eq i32 %t1903, 21
  %t1970 = select i1 %t1969, i8* %t1968, i8* %t1967
  %t1971 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1972 = icmp eq i32 %t1903, 22
  %t1973 = select i1 %t1972, i8* %t1971, i8* %t1970
  %t1974 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1975 = icmp eq i32 %t1903, 23
  %t1976 = select i1 %t1975, i8* %t1974, i8* %t1973
  %t1977 = call i8* @malloc(i64 16)
  %t1978 = bitcast i8* %t1977 to [16 x i8]*
  store [16 x i8] c"ToolDeclaration\00", [16 x i8]* %t1978
  %t1979 = call i1 @strings_equal(i8* %t1976, i8* %t1977)
  br i1 %t1979, label %then20, label %merge21
then20:
  %t1980 = extractvalue %Statement %statement, 0
  %t1981 = alloca %Statement
  store %Statement %statement, %Statement* %t1981
  %t1982 = getelementptr inbounds %Statement, %Statement* %t1981, i32 0, i32 1
  %t1983 = bitcast [88 x i8]* %t1982 to i8*
  %t1984 = bitcast i8* %t1983 to %FunctionSignature*
  %t1985 = load %FunctionSignature, %FunctionSignature* %t1984
  %t1986 = icmp eq i32 %t1980, 4
  %t1987 = select i1 %t1986, %FunctionSignature %t1985, %FunctionSignature zeroinitializer
  %t1988 = getelementptr inbounds %Statement, %Statement* %t1981, i32 0, i32 1
  %t1989 = bitcast [88 x i8]* %t1988 to i8*
  %t1990 = bitcast i8* %t1989 to %FunctionSignature*
  %t1991 = load %FunctionSignature, %FunctionSignature* %t1990
  %t1992 = icmp eq i32 %t1980, 5
  %t1993 = select i1 %t1992, %FunctionSignature %t1991, %FunctionSignature %t1987
  %t1994 = getelementptr inbounds %Statement, %Statement* %t1981, i32 0, i32 1
  %t1995 = bitcast [88 x i8]* %t1994 to i8*
  %t1996 = bitcast i8* %t1995 to %FunctionSignature*
  %t1997 = load %FunctionSignature, %FunctionSignature* %t1996
  %t1998 = icmp eq i32 %t1980, 7
  %t1999 = select i1 %t1998, %FunctionSignature %t1997, %FunctionSignature %t1993
  %t2000 = extractvalue %FunctionSignature %t1999, 0
  %t2001 = call i8* @malloc(i64 5)
  %t2002 = bitcast i8* %t2001 to [5 x i8]*
  store [5 x i8] c"tool\00", [5 x i8]* %t2002
  %t2003 = extractvalue %Statement %statement, 0
  %t2004 = alloca %Statement
  store %Statement %statement, %Statement* %t2004
  %t2005 = getelementptr inbounds %Statement, %Statement* %t2004, i32 0, i32 1
  %t2006 = bitcast [88 x i8]* %t2005 to i8*
  %t2007 = bitcast i8* %t2006 to %FunctionSignature*
  %t2008 = load %FunctionSignature, %FunctionSignature* %t2007
  %t2009 = icmp eq i32 %t2003, 4
  %t2010 = select i1 %t2009, %FunctionSignature %t2008, %FunctionSignature zeroinitializer
  %t2011 = getelementptr inbounds %Statement, %Statement* %t2004, i32 0, i32 1
  %t2012 = bitcast [88 x i8]* %t2011 to i8*
  %t2013 = bitcast i8* %t2012 to %FunctionSignature*
  %t2014 = load %FunctionSignature, %FunctionSignature* %t2013
  %t2015 = icmp eq i32 %t2003, 5
  %t2016 = select i1 %t2015, %FunctionSignature %t2014, %FunctionSignature %t2010
  %t2017 = getelementptr inbounds %Statement, %Statement* %t2004, i32 0, i32 1
  %t2018 = bitcast [88 x i8]* %t2017 to i8*
  %t2019 = bitcast i8* %t2018 to %FunctionSignature*
  %t2020 = load %FunctionSignature, %FunctionSignature* %t2019
  %t2021 = icmp eq i32 %t2003, 7
  %t2022 = select i1 %t2021, %FunctionSignature %t2020, %FunctionSignature %t2016
  %t2023 = extractvalue %FunctionSignature %t2022, 6
  %t2024 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t2000, i8* %t2001, %SourceSpan* %t2023)
  store %ScopeResult %t2024, %ScopeResult* %l15
  %t2025 = load %ScopeResult, %ScopeResult* %l15
  %t2026 = extractvalue %ScopeResult %t2025, 1
  store { %Diagnostic*, i64 }* %t2026, { %Diagnostic*, i64 }** %l16
  %t2027 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l16
  %t2028 = extractvalue %Statement %statement, 0
  %t2029 = alloca %Statement
  store %Statement %statement, %Statement* %t2029
  %t2030 = getelementptr inbounds %Statement, %Statement* %t2029, i32 0, i32 1
  %t2031 = bitcast [88 x i8]* %t2030 to i8*
  %t2032 = bitcast i8* %t2031 to %FunctionSignature*
  %t2033 = load %FunctionSignature, %FunctionSignature* %t2032
  %t2034 = icmp eq i32 %t2028, 4
  %t2035 = select i1 %t2034, %FunctionSignature %t2033, %FunctionSignature zeroinitializer
  %t2036 = getelementptr inbounds %Statement, %Statement* %t2029, i32 0, i32 1
  %t2037 = bitcast [88 x i8]* %t2036 to i8*
  %t2038 = bitcast i8* %t2037 to %FunctionSignature*
  %t2039 = load %FunctionSignature, %FunctionSignature* %t2038
  %t2040 = icmp eq i32 %t2028, 5
  %t2041 = select i1 %t2040, %FunctionSignature %t2039, %FunctionSignature %t2035
  %t2042 = getelementptr inbounds %Statement, %Statement* %t2029, i32 0, i32 1
  %t2043 = bitcast [88 x i8]* %t2042 to i8*
  %t2044 = bitcast i8* %t2043 to %FunctionSignature*
  %t2045 = load %FunctionSignature, %FunctionSignature* %t2044
  %t2046 = icmp eq i32 %t2028, 7
  %t2047 = select i1 %t2046, %FunctionSignature %t2045, %FunctionSignature %t2041
  %t2048 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t2047)
  %t2049 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2027, i32 0, i32 0
  %t2050 = load %Diagnostic*, %Diagnostic** %t2049
  %t2051 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2027, i32 0, i32 1
  %t2052 = load i64, i64* %t2051
  %t2053 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2048, i32 0, i32 0
  %t2054 = load %Diagnostic*, %Diagnostic** %t2053
  %t2055 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2048, i32 0, i32 1
  %t2056 = load i64, i64* %t2055
  %t2057 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t2058 = ptrtoint %Diagnostic* %t2057 to i64
  %t2059 = add i64 %t2052, %t2056
  %t2060 = mul i64 %t2058, %t2059
  %t2061 = call noalias i8* @malloc(i64 %t2060)
  %t2062 = bitcast i8* %t2061 to %Diagnostic*
  %t2063 = bitcast %Diagnostic* %t2062 to i8*
  %t2064 = mul i64 %t2058, %t2052
  %t2065 = bitcast %Diagnostic* %t2050 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2063, i8* %t2065, i64 %t2064)
  %t2066 = mul i64 %t2058, %t2056
  %t2067 = bitcast %Diagnostic* %t2054 to i8*
  %t2068 = getelementptr %Diagnostic, %Diagnostic* %t2062, i64 %t2052
  %t2069 = bitcast %Diagnostic* %t2068 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2069, i8* %t2067, i64 %t2066)
  %t2070 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t2071 = ptrtoint { %Diagnostic*, i64 }* %t2070 to i64
  %t2072 = call i8* @malloc(i64 %t2071)
  %t2073 = bitcast i8* %t2072 to { %Diagnostic*, i64 }*
  %t2074 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2073, i32 0, i32 0
  store %Diagnostic* %t2062, %Diagnostic** %t2074
  %t2075 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2073, i32 0, i32 1
  store i64 %t2059, i64* %t2075
  store { %Diagnostic*, i64 }* %t2073, { %Diagnostic*, i64 }** %l16
  %t2076 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l16
  %t2077 = extractvalue %Statement %statement, 0
  %t2078 = alloca %Statement
  store %Statement %statement, %Statement* %t2078
  %t2079 = getelementptr inbounds %Statement, %Statement* %t2078, i32 0, i32 1
  %t2080 = bitcast [88 x i8]* %t2079 to i8*
  %t2081 = bitcast i8* %t2080 to %FunctionSignature*
  %t2082 = load %FunctionSignature, %FunctionSignature* %t2081
  %t2083 = icmp eq i32 %t2077, 4
  %t2084 = select i1 %t2083, %FunctionSignature %t2082, %FunctionSignature zeroinitializer
  %t2085 = getelementptr inbounds %Statement, %Statement* %t2078, i32 0, i32 1
  %t2086 = bitcast [88 x i8]* %t2085 to i8*
  %t2087 = bitcast i8* %t2086 to %FunctionSignature*
  %t2088 = load %FunctionSignature, %FunctionSignature* %t2087
  %t2089 = icmp eq i32 %t2077, 5
  %t2090 = select i1 %t2089, %FunctionSignature %t2088, %FunctionSignature %t2084
  %t2091 = getelementptr inbounds %Statement, %Statement* %t2078, i32 0, i32 1
  %t2092 = bitcast [88 x i8]* %t2091 to i8*
  %t2093 = bitcast i8* %t2092 to %FunctionSignature*
  %t2094 = load %FunctionSignature, %FunctionSignature* %t2093
  %t2095 = icmp eq i32 %t2077, 7
  %t2096 = select i1 %t2095, %FunctionSignature %t2094, %FunctionSignature %t2090
  %t2097 = extractvalue %Statement %statement, 0
  %t2098 = alloca %Statement
  store %Statement %statement, %Statement* %t2098
  %t2099 = getelementptr inbounds %Statement, %Statement* %t2098, i32 0, i32 1
  %t2100 = bitcast [88 x i8]* %t2099 to i8*
  %t2101 = getelementptr inbounds i8, i8* %t2100, i64 56
  %t2102 = bitcast i8* %t2101 to %Block*
  %t2103 = load %Block, %Block* %t2102
  %t2104 = icmp eq i32 %t2097, 4
  %t2105 = select i1 %t2104, %Block %t2103, %Block zeroinitializer
  %t2106 = getelementptr inbounds %Statement, %Statement* %t2098, i32 0, i32 1
  %t2107 = bitcast [88 x i8]* %t2106 to i8*
  %t2108 = getelementptr inbounds i8, i8* %t2107, i64 56
  %t2109 = bitcast i8* %t2108 to %Block*
  %t2110 = load %Block, %Block* %t2109
  %t2111 = icmp eq i32 %t2097, 5
  %t2112 = select i1 %t2111, %Block %t2110, %Block %t2105
  %t2113 = getelementptr inbounds %Statement, %Statement* %t2098, i32 0, i32 1
  %t2114 = bitcast [56 x i8]* %t2113 to i8*
  %t2115 = getelementptr inbounds i8, i8* %t2114, i64 16
  %t2116 = bitcast i8* %t2115 to %Block*
  %t2117 = load %Block, %Block* %t2116
  %t2118 = icmp eq i32 %t2097, 6
  %t2119 = select i1 %t2118, %Block %t2117, %Block %t2112
  %t2120 = getelementptr inbounds %Statement, %Statement* %t2098, i32 0, i32 1
  %t2121 = bitcast [88 x i8]* %t2120 to i8*
  %t2122 = getelementptr inbounds i8, i8* %t2121, i64 56
  %t2123 = bitcast i8* %t2122 to %Block*
  %t2124 = load %Block, %Block* %t2123
  %t2125 = icmp eq i32 %t2097, 7
  %t2126 = select i1 %t2125, %Block %t2124, %Block %t2119
  %t2127 = getelementptr inbounds %Statement, %Statement* %t2098, i32 0, i32 1
  %t2128 = bitcast [120 x i8]* %t2127 to i8*
  %t2129 = getelementptr inbounds i8, i8* %t2128, i64 88
  %t2130 = bitcast i8* %t2129 to %Block*
  %t2131 = load %Block, %Block* %t2130
  %t2132 = icmp eq i32 %t2097, 12
  %t2133 = select i1 %t2132, %Block %t2131, %Block %t2126
  %t2134 = getelementptr inbounds %Statement, %Statement* %t2098, i32 0, i32 1
  %t2135 = bitcast [40 x i8]* %t2134 to i8*
  %t2136 = getelementptr inbounds i8, i8* %t2135, i64 8
  %t2137 = bitcast i8* %t2136 to %Block*
  %t2138 = load %Block, %Block* %t2137
  %t2139 = icmp eq i32 %t2097, 13
  %t2140 = select i1 %t2139, %Block %t2138, %Block %t2133
  %t2141 = getelementptr inbounds %Statement, %Statement* %t2098, i32 0, i32 1
  %t2142 = bitcast [136 x i8]* %t2141 to i8*
  %t2143 = getelementptr inbounds i8, i8* %t2142, i64 104
  %t2144 = bitcast i8* %t2143 to %Block*
  %t2145 = load %Block, %Block* %t2144
  %t2146 = icmp eq i32 %t2097, 14
  %t2147 = select i1 %t2146, %Block %t2145, %Block %t2140
  %t2148 = getelementptr inbounds %Statement, %Statement* %t2098, i32 0, i32 1
  %t2149 = bitcast [32 x i8]* %t2148 to i8*
  %t2150 = bitcast i8* %t2149 to %Block*
  %t2151 = load %Block, %Block* %t2150
  %t2152 = icmp eq i32 %t2097, 15
  %t2153 = select i1 %t2152, %Block %t2151, %Block %t2147
  %t2154 = getelementptr inbounds %Statement, %Statement* %t2098, i32 0, i32 1
  %t2155 = bitcast [24 x i8]* %t2154 to i8*
  %t2156 = bitcast i8* %t2155 to %Block*
  %t2157 = load %Block, %Block* %t2156
  %t2158 = icmp eq i32 %t2097, 20
  %t2159 = select i1 %t2158, %Block %t2157, %Block %t2153
  %t2160 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t2096, %Block %t2159, { %Statement*, i64 }* %interfaces)
  %t2161 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2076, i32 0, i32 0
  %t2162 = load %Diagnostic*, %Diagnostic** %t2161
  %t2163 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2076, i32 0, i32 1
  %t2164 = load i64, i64* %t2163
  %t2165 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2160, i32 0, i32 0
  %t2166 = load %Diagnostic*, %Diagnostic** %t2165
  %t2167 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2160, i32 0, i32 1
  %t2168 = load i64, i64* %t2167
  %t2169 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t2170 = ptrtoint %Diagnostic* %t2169 to i64
  %t2171 = add i64 %t2164, %t2168
  %t2172 = mul i64 %t2170, %t2171
  %t2173 = call noalias i8* @malloc(i64 %t2172)
  %t2174 = bitcast i8* %t2173 to %Diagnostic*
  %t2175 = bitcast %Diagnostic* %t2174 to i8*
  %t2176 = mul i64 %t2170, %t2164
  %t2177 = bitcast %Diagnostic* %t2162 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2175, i8* %t2177, i64 %t2176)
  %t2178 = mul i64 %t2170, %t2168
  %t2179 = bitcast %Diagnostic* %t2166 to i8*
  %t2180 = getelementptr %Diagnostic, %Diagnostic* %t2174, i64 %t2164
  %t2181 = bitcast %Diagnostic* %t2180 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2181, i8* %t2179, i64 %t2178)
  %t2182 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t2183 = ptrtoint { %Diagnostic*, i64 }* %t2182 to i64
  %t2184 = call i8* @malloc(i64 %t2183)
  %t2185 = bitcast i8* %t2184 to { %Diagnostic*, i64 }*
  %t2186 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2185, i32 0, i32 0
  store %Diagnostic* %t2174, %Diagnostic** %t2186
  %t2187 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2185, i32 0, i32 1
  store i64 %t2171, i64* %t2187
  store { %Diagnostic*, i64 }* %t2185, { %Diagnostic*, i64 }** %l16
  %t2188 = load %ScopeResult, %ScopeResult* %l15
  %t2189 = extractvalue %ScopeResult %t2188, 0
  %t2190 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t2189, 0
  %t2191 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l16
  %t2192 = insertvalue %ScopeResult %t2190, { %Diagnostic*, i64 }* %t2191, 1
  ret %ScopeResult %t2192
merge21:
  %t2193 = extractvalue %Statement %statement, 0
  %t2194 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2195 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2196 = icmp eq i32 %t2193, 0
  %t2197 = select i1 %t2196, i8* %t2195, i8* %t2194
  %t2198 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2199 = icmp eq i32 %t2193, 1
  %t2200 = select i1 %t2199, i8* %t2198, i8* %t2197
  %t2201 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2202 = icmp eq i32 %t2193, 2
  %t2203 = select i1 %t2202, i8* %t2201, i8* %t2200
  %t2204 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2205 = icmp eq i32 %t2193, 3
  %t2206 = select i1 %t2205, i8* %t2204, i8* %t2203
  %t2207 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2208 = icmp eq i32 %t2193, 4
  %t2209 = select i1 %t2208, i8* %t2207, i8* %t2206
  %t2210 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2211 = icmp eq i32 %t2193, 5
  %t2212 = select i1 %t2211, i8* %t2210, i8* %t2209
  %t2213 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2214 = icmp eq i32 %t2193, 6
  %t2215 = select i1 %t2214, i8* %t2213, i8* %t2212
  %t2216 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2217 = icmp eq i32 %t2193, 7
  %t2218 = select i1 %t2217, i8* %t2216, i8* %t2215
  %t2219 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2220 = icmp eq i32 %t2193, 8
  %t2221 = select i1 %t2220, i8* %t2219, i8* %t2218
  %t2222 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2223 = icmp eq i32 %t2193, 9
  %t2224 = select i1 %t2223, i8* %t2222, i8* %t2221
  %t2225 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2226 = icmp eq i32 %t2193, 10
  %t2227 = select i1 %t2226, i8* %t2225, i8* %t2224
  %t2228 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2229 = icmp eq i32 %t2193, 11
  %t2230 = select i1 %t2229, i8* %t2228, i8* %t2227
  %t2231 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2232 = icmp eq i32 %t2193, 12
  %t2233 = select i1 %t2232, i8* %t2231, i8* %t2230
  %t2234 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2235 = icmp eq i32 %t2193, 13
  %t2236 = select i1 %t2235, i8* %t2234, i8* %t2233
  %t2237 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2238 = icmp eq i32 %t2193, 14
  %t2239 = select i1 %t2238, i8* %t2237, i8* %t2236
  %t2240 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2241 = icmp eq i32 %t2193, 15
  %t2242 = select i1 %t2241, i8* %t2240, i8* %t2239
  %t2243 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2244 = icmp eq i32 %t2193, 16
  %t2245 = select i1 %t2244, i8* %t2243, i8* %t2242
  %t2246 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2247 = icmp eq i32 %t2193, 17
  %t2248 = select i1 %t2247, i8* %t2246, i8* %t2245
  %t2249 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2250 = icmp eq i32 %t2193, 18
  %t2251 = select i1 %t2250, i8* %t2249, i8* %t2248
  %t2252 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2253 = icmp eq i32 %t2193, 19
  %t2254 = select i1 %t2253, i8* %t2252, i8* %t2251
  %t2255 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t2256 = icmp eq i32 %t2193, 20
  %t2257 = select i1 %t2256, i8* %t2255, i8* %t2254
  %t2258 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2259 = icmp eq i32 %t2193, 21
  %t2260 = select i1 %t2259, i8* %t2258, i8* %t2257
  %t2261 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2262 = icmp eq i32 %t2193, 22
  %t2263 = select i1 %t2262, i8* %t2261, i8* %t2260
  %t2264 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2265 = icmp eq i32 %t2193, 23
  %t2266 = select i1 %t2265, i8* %t2264, i8* %t2263
  %t2267 = call i8* @malloc(i64 16)
  %t2268 = bitcast i8* %t2267 to [16 x i8]*
  store [16 x i8] c"TestDeclaration\00", [16 x i8]* %t2268
  %t2269 = call i1 @strings_equal(i8* %t2266, i8* %t2267)
  br i1 %t2269, label %then22, label %merge23
then22:
  %t2270 = extractvalue %Statement %statement, 0
  %t2271 = alloca %Statement
  store %Statement %statement, %Statement* %t2271
  %t2272 = getelementptr inbounds %Statement, %Statement* %t2271, i32 0, i32 1
  %t2273 = bitcast [48 x i8]* %t2272 to i8*
  %t2274 = bitcast i8* %t2273 to i8**
  %t2275 = load i8*, i8** %t2274
  %t2276 = icmp eq i32 %t2270, 2
  %t2277 = select i1 %t2276, i8* %t2275, i8* null
  %t2278 = getelementptr inbounds %Statement, %Statement* %t2271, i32 0, i32 1
  %t2279 = bitcast [48 x i8]* %t2278 to i8*
  %t2280 = bitcast i8* %t2279 to i8**
  %t2281 = load i8*, i8** %t2280
  %t2282 = icmp eq i32 %t2270, 3
  %t2283 = select i1 %t2282, i8* %t2281, i8* %t2277
  %t2284 = getelementptr inbounds %Statement, %Statement* %t2271, i32 0, i32 1
  %t2285 = bitcast [56 x i8]* %t2284 to i8*
  %t2286 = bitcast i8* %t2285 to i8**
  %t2287 = load i8*, i8** %t2286
  %t2288 = icmp eq i32 %t2270, 6
  %t2289 = select i1 %t2288, i8* %t2287, i8* %t2283
  %t2290 = getelementptr inbounds %Statement, %Statement* %t2271, i32 0, i32 1
  %t2291 = bitcast [56 x i8]* %t2290 to i8*
  %t2292 = bitcast i8* %t2291 to i8**
  %t2293 = load i8*, i8** %t2292
  %t2294 = icmp eq i32 %t2270, 8
  %t2295 = select i1 %t2294, i8* %t2293, i8* %t2289
  %t2296 = getelementptr inbounds %Statement, %Statement* %t2271, i32 0, i32 1
  %t2297 = bitcast [40 x i8]* %t2296 to i8*
  %t2298 = bitcast i8* %t2297 to i8**
  %t2299 = load i8*, i8** %t2298
  %t2300 = icmp eq i32 %t2270, 9
  %t2301 = select i1 %t2300, i8* %t2299, i8* %t2295
  %t2302 = getelementptr inbounds %Statement, %Statement* %t2271, i32 0, i32 1
  %t2303 = bitcast [40 x i8]* %t2302 to i8*
  %t2304 = bitcast i8* %t2303 to i8**
  %t2305 = load i8*, i8** %t2304
  %t2306 = icmp eq i32 %t2270, 10
  %t2307 = select i1 %t2306, i8* %t2305, i8* %t2301
  %t2308 = getelementptr inbounds %Statement, %Statement* %t2271, i32 0, i32 1
  %t2309 = bitcast [40 x i8]* %t2308 to i8*
  %t2310 = bitcast i8* %t2309 to i8**
  %t2311 = load i8*, i8** %t2310
  %t2312 = icmp eq i32 %t2270, 11
  %t2313 = select i1 %t2312, i8* %t2311, i8* %t2307
  %t2314 = call i8* @malloc(i64 5)
  %t2315 = bitcast i8* %t2314 to [5 x i8]*
  store [5 x i8] c"test\00", [5 x i8]* %t2315
  %t2316 = extractvalue %Statement %statement, 0
  %t2317 = alloca %Statement
  store %Statement %statement, %Statement* %t2317
  %t2318 = getelementptr inbounds %Statement, %Statement* %t2317, i32 0, i32 1
  %t2319 = bitcast [48 x i8]* %t2318 to i8*
  %t2320 = getelementptr inbounds i8, i8* %t2319, i64 8
  %t2321 = bitcast i8* %t2320 to %SourceSpan**
  %t2322 = load %SourceSpan*, %SourceSpan** %t2321
  %t2323 = icmp eq i32 %t2316, 3
  %t2324 = select i1 %t2323, %SourceSpan* %t2322, %SourceSpan* null
  %t2325 = getelementptr inbounds %Statement, %Statement* %t2317, i32 0, i32 1
  %t2326 = bitcast [56 x i8]* %t2325 to i8*
  %t2327 = getelementptr inbounds i8, i8* %t2326, i64 8
  %t2328 = bitcast i8* %t2327 to %SourceSpan**
  %t2329 = load %SourceSpan*, %SourceSpan** %t2328
  %t2330 = icmp eq i32 %t2316, 6
  %t2331 = select i1 %t2330, %SourceSpan* %t2329, %SourceSpan* %t2324
  %t2332 = getelementptr inbounds %Statement, %Statement* %t2317, i32 0, i32 1
  %t2333 = bitcast [56 x i8]* %t2332 to i8*
  %t2334 = getelementptr inbounds i8, i8* %t2333, i64 8
  %t2335 = bitcast i8* %t2334 to %SourceSpan**
  %t2336 = load %SourceSpan*, %SourceSpan** %t2335
  %t2337 = icmp eq i32 %t2316, 8
  %t2338 = select i1 %t2337, %SourceSpan* %t2336, %SourceSpan* %t2331
  %t2339 = getelementptr inbounds %Statement, %Statement* %t2317, i32 0, i32 1
  %t2340 = bitcast [40 x i8]* %t2339 to i8*
  %t2341 = getelementptr inbounds i8, i8* %t2340, i64 8
  %t2342 = bitcast i8* %t2341 to %SourceSpan**
  %t2343 = load %SourceSpan*, %SourceSpan** %t2342
  %t2344 = icmp eq i32 %t2316, 9
  %t2345 = select i1 %t2344, %SourceSpan* %t2343, %SourceSpan* %t2338
  %t2346 = getelementptr inbounds %Statement, %Statement* %t2317, i32 0, i32 1
  %t2347 = bitcast [40 x i8]* %t2346 to i8*
  %t2348 = getelementptr inbounds i8, i8* %t2347, i64 8
  %t2349 = bitcast i8* %t2348 to %SourceSpan**
  %t2350 = load %SourceSpan*, %SourceSpan** %t2349
  %t2351 = icmp eq i32 %t2316, 10
  %t2352 = select i1 %t2351, %SourceSpan* %t2350, %SourceSpan* %t2345
  %t2353 = getelementptr inbounds %Statement, %Statement* %t2317, i32 0, i32 1
  %t2354 = bitcast [40 x i8]* %t2353 to i8*
  %t2355 = getelementptr inbounds i8, i8* %t2354, i64 8
  %t2356 = bitcast i8* %t2355 to %SourceSpan**
  %t2357 = load %SourceSpan*, %SourceSpan** %t2356
  %t2358 = icmp eq i32 %t2316, 11
  %t2359 = select i1 %t2358, %SourceSpan* %t2357, %SourceSpan* %t2352
  %t2360 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t2313, i8* %t2314, %SourceSpan* %t2359)
  store %ScopeResult %t2360, %ScopeResult* %l17
  %t2361 = load %ScopeResult, %ScopeResult* %l17
  %t2362 = extractvalue %ScopeResult %t2361, 1
  %t2363 = extractvalue %Statement %statement, 0
  %t2364 = alloca %Statement
  store %Statement %statement, %Statement* %t2364
  %t2365 = getelementptr inbounds %Statement, %Statement* %t2364, i32 0, i32 1
  %t2366 = bitcast [88 x i8]* %t2365 to i8*
  %t2367 = getelementptr inbounds i8, i8* %t2366, i64 56
  %t2368 = bitcast i8* %t2367 to %Block*
  %t2369 = load %Block, %Block* %t2368
  %t2370 = icmp eq i32 %t2363, 4
  %t2371 = select i1 %t2370, %Block %t2369, %Block zeroinitializer
  %t2372 = getelementptr inbounds %Statement, %Statement* %t2364, i32 0, i32 1
  %t2373 = bitcast [88 x i8]* %t2372 to i8*
  %t2374 = getelementptr inbounds i8, i8* %t2373, i64 56
  %t2375 = bitcast i8* %t2374 to %Block*
  %t2376 = load %Block, %Block* %t2375
  %t2377 = icmp eq i32 %t2363, 5
  %t2378 = select i1 %t2377, %Block %t2376, %Block %t2371
  %t2379 = getelementptr inbounds %Statement, %Statement* %t2364, i32 0, i32 1
  %t2380 = bitcast [56 x i8]* %t2379 to i8*
  %t2381 = getelementptr inbounds i8, i8* %t2380, i64 16
  %t2382 = bitcast i8* %t2381 to %Block*
  %t2383 = load %Block, %Block* %t2382
  %t2384 = icmp eq i32 %t2363, 6
  %t2385 = select i1 %t2384, %Block %t2383, %Block %t2378
  %t2386 = getelementptr inbounds %Statement, %Statement* %t2364, i32 0, i32 1
  %t2387 = bitcast [88 x i8]* %t2386 to i8*
  %t2388 = getelementptr inbounds i8, i8* %t2387, i64 56
  %t2389 = bitcast i8* %t2388 to %Block*
  %t2390 = load %Block, %Block* %t2389
  %t2391 = icmp eq i32 %t2363, 7
  %t2392 = select i1 %t2391, %Block %t2390, %Block %t2385
  %t2393 = getelementptr inbounds %Statement, %Statement* %t2364, i32 0, i32 1
  %t2394 = bitcast [120 x i8]* %t2393 to i8*
  %t2395 = getelementptr inbounds i8, i8* %t2394, i64 88
  %t2396 = bitcast i8* %t2395 to %Block*
  %t2397 = load %Block, %Block* %t2396
  %t2398 = icmp eq i32 %t2363, 12
  %t2399 = select i1 %t2398, %Block %t2397, %Block %t2392
  %t2400 = getelementptr inbounds %Statement, %Statement* %t2364, i32 0, i32 1
  %t2401 = bitcast [40 x i8]* %t2400 to i8*
  %t2402 = getelementptr inbounds i8, i8* %t2401, i64 8
  %t2403 = bitcast i8* %t2402 to %Block*
  %t2404 = load %Block, %Block* %t2403
  %t2405 = icmp eq i32 %t2363, 13
  %t2406 = select i1 %t2405, %Block %t2404, %Block %t2399
  %t2407 = getelementptr inbounds %Statement, %Statement* %t2364, i32 0, i32 1
  %t2408 = bitcast [136 x i8]* %t2407 to i8*
  %t2409 = getelementptr inbounds i8, i8* %t2408, i64 104
  %t2410 = bitcast i8* %t2409 to %Block*
  %t2411 = load %Block, %Block* %t2410
  %t2412 = icmp eq i32 %t2363, 14
  %t2413 = select i1 %t2412, %Block %t2411, %Block %t2406
  %t2414 = getelementptr inbounds %Statement, %Statement* %t2364, i32 0, i32 1
  %t2415 = bitcast [32 x i8]* %t2414 to i8*
  %t2416 = bitcast i8* %t2415 to %Block*
  %t2417 = load %Block, %Block* %t2416
  %t2418 = icmp eq i32 %t2363, 15
  %t2419 = select i1 %t2418, %Block %t2417, %Block %t2413
  %t2420 = getelementptr inbounds %Statement, %Statement* %t2364, i32 0, i32 1
  %t2421 = bitcast [24 x i8]* %t2420 to i8*
  %t2422 = bitcast i8* %t2421 to %Block*
  %t2423 = load %Block, %Block* %t2422
  %t2424 = icmp eq i32 %t2363, 20
  %t2425 = select i1 %t2424, %Block %t2423, %Block %t2419
  %t2426 = getelementptr [0 x %SymbolEntry], [0 x %SymbolEntry]* null, i32 1
  %t2427 = ptrtoint [0 x %SymbolEntry]* %t2426 to i64
  %t2428 = icmp eq i64 %t2427, 0
  %t2429 = select i1 %t2428, i64 1, i64 %t2427
  %t2430 = call i8* @malloc(i64 %t2429)
  %t2431 = bitcast i8* %t2430 to %SymbolEntry*
  %t2432 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* null, i32 1
  %t2433 = ptrtoint { %SymbolEntry*, i64 }* %t2432 to i64
  %t2434 = call i8* @malloc(i64 %t2433)
  %t2435 = bitcast i8* %t2434 to { %SymbolEntry*, i64 }*
  %t2436 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t2435, i32 0, i32 0
  store %SymbolEntry* %t2431, %SymbolEntry** %t2436
  %t2437 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t2435, i32 0, i32 1
  store i64 0, i64* %t2437
  %t2438 = call { %Diagnostic*, i64 }* @check_block(%Block %t2425, { %SymbolEntry*, i64 }* %t2435, { %Statement*, i64 }* %interfaces)
  %t2439 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2362, i32 0, i32 0
  %t2440 = load %Diagnostic*, %Diagnostic** %t2439
  %t2441 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2362, i32 0, i32 1
  %t2442 = load i64, i64* %t2441
  %t2443 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2438, i32 0, i32 0
  %t2444 = load %Diagnostic*, %Diagnostic** %t2443
  %t2445 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2438, i32 0, i32 1
  %t2446 = load i64, i64* %t2445
  %t2447 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t2448 = ptrtoint %Diagnostic* %t2447 to i64
  %t2449 = add i64 %t2442, %t2446
  %t2450 = mul i64 %t2448, %t2449
  %t2451 = call noalias i8* @malloc(i64 %t2450)
  %t2452 = bitcast i8* %t2451 to %Diagnostic*
  %t2453 = bitcast %Diagnostic* %t2452 to i8*
  %t2454 = mul i64 %t2448, %t2442
  %t2455 = bitcast %Diagnostic* %t2440 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2453, i8* %t2455, i64 %t2454)
  %t2456 = mul i64 %t2448, %t2446
  %t2457 = bitcast %Diagnostic* %t2444 to i8*
  %t2458 = getelementptr %Diagnostic, %Diagnostic* %t2452, i64 %t2442
  %t2459 = bitcast %Diagnostic* %t2458 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2459, i8* %t2457, i64 %t2456)
  %t2460 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t2461 = ptrtoint { %Diagnostic*, i64 }* %t2460 to i64
  %t2462 = call i8* @malloc(i64 %t2461)
  %t2463 = bitcast i8* %t2462 to { %Diagnostic*, i64 }*
  %t2464 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2463, i32 0, i32 0
  store %Diagnostic* %t2452, %Diagnostic** %t2464
  %t2465 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2463, i32 0, i32 1
  store i64 %t2449, i64* %t2465
  store { %Diagnostic*, i64 }* %t2463, { %Diagnostic*, i64 }** %l18
  %t2466 = load %ScopeResult, %ScopeResult* %l17
  %t2467 = extractvalue %ScopeResult %t2466, 0
  %t2468 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t2467, 0
  %t2469 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l18
  %t2470 = insertvalue %ScopeResult %t2468, { %Diagnostic*, i64 }* %t2469, 1
  ret %ScopeResult %t2470
merge23:
  %t2471 = extractvalue %Statement %statement, 0
  %t2472 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2473 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2474 = icmp eq i32 %t2471, 0
  %t2475 = select i1 %t2474, i8* %t2473, i8* %t2472
  %t2476 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2477 = icmp eq i32 %t2471, 1
  %t2478 = select i1 %t2477, i8* %t2476, i8* %t2475
  %t2479 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2480 = icmp eq i32 %t2471, 2
  %t2481 = select i1 %t2480, i8* %t2479, i8* %t2478
  %t2482 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2483 = icmp eq i32 %t2471, 3
  %t2484 = select i1 %t2483, i8* %t2482, i8* %t2481
  %t2485 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2486 = icmp eq i32 %t2471, 4
  %t2487 = select i1 %t2486, i8* %t2485, i8* %t2484
  %t2488 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2489 = icmp eq i32 %t2471, 5
  %t2490 = select i1 %t2489, i8* %t2488, i8* %t2487
  %t2491 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2492 = icmp eq i32 %t2471, 6
  %t2493 = select i1 %t2492, i8* %t2491, i8* %t2490
  %t2494 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2495 = icmp eq i32 %t2471, 7
  %t2496 = select i1 %t2495, i8* %t2494, i8* %t2493
  %t2497 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2498 = icmp eq i32 %t2471, 8
  %t2499 = select i1 %t2498, i8* %t2497, i8* %t2496
  %t2500 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2501 = icmp eq i32 %t2471, 9
  %t2502 = select i1 %t2501, i8* %t2500, i8* %t2499
  %t2503 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2504 = icmp eq i32 %t2471, 10
  %t2505 = select i1 %t2504, i8* %t2503, i8* %t2502
  %t2506 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2507 = icmp eq i32 %t2471, 11
  %t2508 = select i1 %t2507, i8* %t2506, i8* %t2505
  %t2509 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2510 = icmp eq i32 %t2471, 12
  %t2511 = select i1 %t2510, i8* %t2509, i8* %t2508
  %t2512 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2513 = icmp eq i32 %t2471, 13
  %t2514 = select i1 %t2513, i8* %t2512, i8* %t2511
  %t2515 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2516 = icmp eq i32 %t2471, 14
  %t2517 = select i1 %t2516, i8* %t2515, i8* %t2514
  %t2518 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2519 = icmp eq i32 %t2471, 15
  %t2520 = select i1 %t2519, i8* %t2518, i8* %t2517
  %t2521 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2522 = icmp eq i32 %t2471, 16
  %t2523 = select i1 %t2522, i8* %t2521, i8* %t2520
  %t2524 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2525 = icmp eq i32 %t2471, 17
  %t2526 = select i1 %t2525, i8* %t2524, i8* %t2523
  %t2527 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2528 = icmp eq i32 %t2471, 18
  %t2529 = select i1 %t2528, i8* %t2527, i8* %t2526
  %t2530 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2531 = icmp eq i32 %t2471, 19
  %t2532 = select i1 %t2531, i8* %t2530, i8* %t2529
  %t2533 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t2534 = icmp eq i32 %t2471, 20
  %t2535 = select i1 %t2534, i8* %t2533, i8* %t2532
  %t2536 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2537 = icmp eq i32 %t2471, 21
  %t2538 = select i1 %t2537, i8* %t2536, i8* %t2535
  %t2539 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2540 = icmp eq i32 %t2471, 22
  %t2541 = select i1 %t2540, i8* %t2539, i8* %t2538
  %t2542 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2543 = icmp eq i32 %t2471, 23
  %t2544 = select i1 %t2543, i8* %t2542, i8* %t2541
  %t2545 = call i8* @malloc(i64 14)
  %t2546 = bitcast i8* %t2545 to [14 x i8]*
  store [14 x i8] c"WithStatement\00", [14 x i8]* %t2546
  %t2547 = call i1 @strings_equal(i8* %t2544, i8* %t2545)
  br i1 %t2547, label %then24, label %merge25
then24:
  %t2548 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %bindings, 0
  %t2549 = extractvalue %Statement %statement, 0
  %t2550 = alloca %Statement
  store %Statement %statement, %Statement* %t2550
  %t2551 = getelementptr inbounds %Statement, %Statement* %t2550, i32 0, i32 1
  %t2552 = bitcast [88 x i8]* %t2551 to i8*
  %t2553 = getelementptr inbounds i8, i8* %t2552, i64 56
  %t2554 = bitcast i8* %t2553 to %Block*
  %t2555 = load %Block, %Block* %t2554
  %t2556 = icmp eq i32 %t2549, 4
  %t2557 = select i1 %t2556, %Block %t2555, %Block zeroinitializer
  %t2558 = getelementptr inbounds %Statement, %Statement* %t2550, i32 0, i32 1
  %t2559 = bitcast [88 x i8]* %t2558 to i8*
  %t2560 = getelementptr inbounds i8, i8* %t2559, i64 56
  %t2561 = bitcast i8* %t2560 to %Block*
  %t2562 = load %Block, %Block* %t2561
  %t2563 = icmp eq i32 %t2549, 5
  %t2564 = select i1 %t2563, %Block %t2562, %Block %t2557
  %t2565 = getelementptr inbounds %Statement, %Statement* %t2550, i32 0, i32 1
  %t2566 = bitcast [56 x i8]* %t2565 to i8*
  %t2567 = getelementptr inbounds i8, i8* %t2566, i64 16
  %t2568 = bitcast i8* %t2567 to %Block*
  %t2569 = load %Block, %Block* %t2568
  %t2570 = icmp eq i32 %t2549, 6
  %t2571 = select i1 %t2570, %Block %t2569, %Block %t2564
  %t2572 = getelementptr inbounds %Statement, %Statement* %t2550, i32 0, i32 1
  %t2573 = bitcast [88 x i8]* %t2572 to i8*
  %t2574 = getelementptr inbounds i8, i8* %t2573, i64 56
  %t2575 = bitcast i8* %t2574 to %Block*
  %t2576 = load %Block, %Block* %t2575
  %t2577 = icmp eq i32 %t2549, 7
  %t2578 = select i1 %t2577, %Block %t2576, %Block %t2571
  %t2579 = getelementptr inbounds %Statement, %Statement* %t2550, i32 0, i32 1
  %t2580 = bitcast [120 x i8]* %t2579 to i8*
  %t2581 = getelementptr inbounds i8, i8* %t2580, i64 88
  %t2582 = bitcast i8* %t2581 to %Block*
  %t2583 = load %Block, %Block* %t2582
  %t2584 = icmp eq i32 %t2549, 12
  %t2585 = select i1 %t2584, %Block %t2583, %Block %t2578
  %t2586 = getelementptr inbounds %Statement, %Statement* %t2550, i32 0, i32 1
  %t2587 = bitcast [40 x i8]* %t2586 to i8*
  %t2588 = getelementptr inbounds i8, i8* %t2587, i64 8
  %t2589 = bitcast i8* %t2588 to %Block*
  %t2590 = load %Block, %Block* %t2589
  %t2591 = icmp eq i32 %t2549, 13
  %t2592 = select i1 %t2591, %Block %t2590, %Block %t2585
  %t2593 = getelementptr inbounds %Statement, %Statement* %t2550, i32 0, i32 1
  %t2594 = bitcast [136 x i8]* %t2593 to i8*
  %t2595 = getelementptr inbounds i8, i8* %t2594, i64 104
  %t2596 = bitcast i8* %t2595 to %Block*
  %t2597 = load %Block, %Block* %t2596
  %t2598 = icmp eq i32 %t2549, 14
  %t2599 = select i1 %t2598, %Block %t2597, %Block %t2592
  %t2600 = getelementptr inbounds %Statement, %Statement* %t2550, i32 0, i32 1
  %t2601 = bitcast [32 x i8]* %t2600 to i8*
  %t2602 = bitcast i8* %t2601 to %Block*
  %t2603 = load %Block, %Block* %t2602
  %t2604 = icmp eq i32 %t2549, 15
  %t2605 = select i1 %t2604, %Block %t2603, %Block %t2599
  %t2606 = getelementptr inbounds %Statement, %Statement* %t2550, i32 0, i32 1
  %t2607 = bitcast [24 x i8]* %t2606 to i8*
  %t2608 = bitcast i8* %t2607 to %Block*
  %t2609 = load %Block, %Block* %t2608
  %t2610 = icmp eq i32 %t2549, 20
  %t2611 = select i1 %t2610, %Block %t2609, %Block %t2605
  %t2612 = call { %Diagnostic*, i64 }* @check_block(%Block %t2611, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2613 = insertvalue %ScopeResult %t2548, { %Diagnostic*, i64 }* %t2612, 1
  ret %ScopeResult %t2613
merge25:
  %t2614 = extractvalue %Statement %statement, 0
  %t2615 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2616 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2617 = icmp eq i32 %t2614, 0
  %t2618 = select i1 %t2617, i8* %t2616, i8* %t2615
  %t2619 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2620 = icmp eq i32 %t2614, 1
  %t2621 = select i1 %t2620, i8* %t2619, i8* %t2618
  %t2622 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2623 = icmp eq i32 %t2614, 2
  %t2624 = select i1 %t2623, i8* %t2622, i8* %t2621
  %t2625 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2626 = icmp eq i32 %t2614, 3
  %t2627 = select i1 %t2626, i8* %t2625, i8* %t2624
  %t2628 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2629 = icmp eq i32 %t2614, 4
  %t2630 = select i1 %t2629, i8* %t2628, i8* %t2627
  %t2631 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2632 = icmp eq i32 %t2614, 5
  %t2633 = select i1 %t2632, i8* %t2631, i8* %t2630
  %t2634 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2635 = icmp eq i32 %t2614, 6
  %t2636 = select i1 %t2635, i8* %t2634, i8* %t2633
  %t2637 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2638 = icmp eq i32 %t2614, 7
  %t2639 = select i1 %t2638, i8* %t2637, i8* %t2636
  %t2640 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2641 = icmp eq i32 %t2614, 8
  %t2642 = select i1 %t2641, i8* %t2640, i8* %t2639
  %t2643 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2644 = icmp eq i32 %t2614, 9
  %t2645 = select i1 %t2644, i8* %t2643, i8* %t2642
  %t2646 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2647 = icmp eq i32 %t2614, 10
  %t2648 = select i1 %t2647, i8* %t2646, i8* %t2645
  %t2649 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2650 = icmp eq i32 %t2614, 11
  %t2651 = select i1 %t2650, i8* %t2649, i8* %t2648
  %t2652 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2653 = icmp eq i32 %t2614, 12
  %t2654 = select i1 %t2653, i8* %t2652, i8* %t2651
  %t2655 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2656 = icmp eq i32 %t2614, 13
  %t2657 = select i1 %t2656, i8* %t2655, i8* %t2654
  %t2658 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2659 = icmp eq i32 %t2614, 14
  %t2660 = select i1 %t2659, i8* %t2658, i8* %t2657
  %t2661 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2662 = icmp eq i32 %t2614, 15
  %t2663 = select i1 %t2662, i8* %t2661, i8* %t2660
  %t2664 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2665 = icmp eq i32 %t2614, 16
  %t2666 = select i1 %t2665, i8* %t2664, i8* %t2663
  %t2667 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2668 = icmp eq i32 %t2614, 17
  %t2669 = select i1 %t2668, i8* %t2667, i8* %t2666
  %t2670 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2671 = icmp eq i32 %t2614, 18
  %t2672 = select i1 %t2671, i8* %t2670, i8* %t2669
  %t2673 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2674 = icmp eq i32 %t2614, 19
  %t2675 = select i1 %t2674, i8* %t2673, i8* %t2672
  %t2676 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t2677 = icmp eq i32 %t2614, 20
  %t2678 = select i1 %t2677, i8* %t2676, i8* %t2675
  %t2679 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2680 = icmp eq i32 %t2614, 21
  %t2681 = select i1 %t2680, i8* %t2679, i8* %t2678
  %t2682 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2683 = icmp eq i32 %t2614, 22
  %t2684 = select i1 %t2683, i8* %t2682, i8* %t2681
  %t2685 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2686 = icmp eq i32 %t2614, 23
  %t2687 = select i1 %t2686, i8* %t2685, i8* %t2684
  %t2688 = call i8* @malloc(i64 13)
  %t2689 = bitcast i8* %t2688 to [13 x i8]*
  store [13 x i8] c"ForStatement\00", [13 x i8]* %t2689
  %t2690 = call i1 @strings_equal(i8* %t2687, i8* %t2688)
  br i1 %t2690, label %then26, label %merge27
then26:
  %t2691 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %bindings, 0
  %t2692 = extractvalue %Statement %statement, 0
  %t2693 = alloca %Statement
  store %Statement %statement, %Statement* %t2693
  %t2694 = getelementptr inbounds %Statement, %Statement* %t2693, i32 0, i32 1
  %t2695 = bitcast [88 x i8]* %t2694 to i8*
  %t2696 = getelementptr inbounds i8, i8* %t2695, i64 56
  %t2697 = bitcast i8* %t2696 to %Block*
  %t2698 = load %Block, %Block* %t2697
  %t2699 = icmp eq i32 %t2692, 4
  %t2700 = select i1 %t2699, %Block %t2698, %Block zeroinitializer
  %t2701 = getelementptr inbounds %Statement, %Statement* %t2693, i32 0, i32 1
  %t2702 = bitcast [88 x i8]* %t2701 to i8*
  %t2703 = getelementptr inbounds i8, i8* %t2702, i64 56
  %t2704 = bitcast i8* %t2703 to %Block*
  %t2705 = load %Block, %Block* %t2704
  %t2706 = icmp eq i32 %t2692, 5
  %t2707 = select i1 %t2706, %Block %t2705, %Block %t2700
  %t2708 = getelementptr inbounds %Statement, %Statement* %t2693, i32 0, i32 1
  %t2709 = bitcast [56 x i8]* %t2708 to i8*
  %t2710 = getelementptr inbounds i8, i8* %t2709, i64 16
  %t2711 = bitcast i8* %t2710 to %Block*
  %t2712 = load %Block, %Block* %t2711
  %t2713 = icmp eq i32 %t2692, 6
  %t2714 = select i1 %t2713, %Block %t2712, %Block %t2707
  %t2715 = getelementptr inbounds %Statement, %Statement* %t2693, i32 0, i32 1
  %t2716 = bitcast [88 x i8]* %t2715 to i8*
  %t2717 = getelementptr inbounds i8, i8* %t2716, i64 56
  %t2718 = bitcast i8* %t2717 to %Block*
  %t2719 = load %Block, %Block* %t2718
  %t2720 = icmp eq i32 %t2692, 7
  %t2721 = select i1 %t2720, %Block %t2719, %Block %t2714
  %t2722 = getelementptr inbounds %Statement, %Statement* %t2693, i32 0, i32 1
  %t2723 = bitcast [120 x i8]* %t2722 to i8*
  %t2724 = getelementptr inbounds i8, i8* %t2723, i64 88
  %t2725 = bitcast i8* %t2724 to %Block*
  %t2726 = load %Block, %Block* %t2725
  %t2727 = icmp eq i32 %t2692, 12
  %t2728 = select i1 %t2727, %Block %t2726, %Block %t2721
  %t2729 = getelementptr inbounds %Statement, %Statement* %t2693, i32 0, i32 1
  %t2730 = bitcast [40 x i8]* %t2729 to i8*
  %t2731 = getelementptr inbounds i8, i8* %t2730, i64 8
  %t2732 = bitcast i8* %t2731 to %Block*
  %t2733 = load %Block, %Block* %t2732
  %t2734 = icmp eq i32 %t2692, 13
  %t2735 = select i1 %t2734, %Block %t2733, %Block %t2728
  %t2736 = getelementptr inbounds %Statement, %Statement* %t2693, i32 0, i32 1
  %t2737 = bitcast [136 x i8]* %t2736 to i8*
  %t2738 = getelementptr inbounds i8, i8* %t2737, i64 104
  %t2739 = bitcast i8* %t2738 to %Block*
  %t2740 = load %Block, %Block* %t2739
  %t2741 = icmp eq i32 %t2692, 14
  %t2742 = select i1 %t2741, %Block %t2740, %Block %t2735
  %t2743 = getelementptr inbounds %Statement, %Statement* %t2693, i32 0, i32 1
  %t2744 = bitcast [32 x i8]* %t2743 to i8*
  %t2745 = bitcast i8* %t2744 to %Block*
  %t2746 = load %Block, %Block* %t2745
  %t2747 = icmp eq i32 %t2692, 15
  %t2748 = select i1 %t2747, %Block %t2746, %Block %t2742
  %t2749 = getelementptr inbounds %Statement, %Statement* %t2693, i32 0, i32 1
  %t2750 = bitcast [24 x i8]* %t2749 to i8*
  %t2751 = bitcast i8* %t2750 to %Block*
  %t2752 = load %Block, %Block* %t2751
  %t2753 = icmp eq i32 %t2692, 20
  %t2754 = select i1 %t2753, %Block %t2752, %Block %t2748
  %t2755 = call { %Diagnostic*, i64 }* @check_block(%Block %t2754, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2756 = insertvalue %ScopeResult %t2691, { %Diagnostic*, i64 }* %t2755, 1
  ret %ScopeResult %t2756
merge27:
  %t2757 = extractvalue %Statement %statement, 0
  %t2758 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2759 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2760 = icmp eq i32 %t2757, 0
  %t2761 = select i1 %t2760, i8* %t2759, i8* %t2758
  %t2762 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2763 = icmp eq i32 %t2757, 1
  %t2764 = select i1 %t2763, i8* %t2762, i8* %t2761
  %t2765 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2766 = icmp eq i32 %t2757, 2
  %t2767 = select i1 %t2766, i8* %t2765, i8* %t2764
  %t2768 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2769 = icmp eq i32 %t2757, 3
  %t2770 = select i1 %t2769, i8* %t2768, i8* %t2767
  %t2771 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2772 = icmp eq i32 %t2757, 4
  %t2773 = select i1 %t2772, i8* %t2771, i8* %t2770
  %t2774 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2775 = icmp eq i32 %t2757, 5
  %t2776 = select i1 %t2775, i8* %t2774, i8* %t2773
  %t2777 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2778 = icmp eq i32 %t2757, 6
  %t2779 = select i1 %t2778, i8* %t2777, i8* %t2776
  %t2780 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2781 = icmp eq i32 %t2757, 7
  %t2782 = select i1 %t2781, i8* %t2780, i8* %t2779
  %t2783 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2784 = icmp eq i32 %t2757, 8
  %t2785 = select i1 %t2784, i8* %t2783, i8* %t2782
  %t2786 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2787 = icmp eq i32 %t2757, 9
  %t2788 = select i1 %t2787, i8* %t2786, i8* %t2785
  %t2789 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2790 = icmp eq i32 %t2757, 10
  %t2791 = select i1 %t2790, i8* %t2789, i8* %t2788
  %t2792 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2793 = icmp eq i32 %t2757, 11
  %t2794 = select i1 %t2793, i8* %t2792, i8* %t2791
  %t2795 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2796 = icmp eq i32 %t2757, 12
  %t2797 = select i1 %t2796, i8* %t2795, i8* %t2794
  %t2798 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2799 = icmp eq i32 %t2757, 13
  %t2800 = select i1 %t2799, i8* %t2798, i8* %t2797
  %t2801 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2802 = icmp eq i32 %t2757, 14
  %t2803 = select i1 %t2802, i8* %t2801, i8* %t2800
  %t2804 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2805 = icmp eq i32 %t2757, 15
  %t2806 = select i1 %t2805, i8* %t2804, i8* %t2803
  %t2807 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2808 = icmp eq i32 %t2757, 16
  %t2809 = select i1 %t2808, i8* %t2807, i8* %t2806
  %t2810 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2811 = icmp eq i32 %t2757, 17
  %t2812 = select i1 %t2811, i8* %t2810, i8* %t2809
  %t2813 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2814 = icmp eq i32 %t2757, 18
  %t2815 = select i1 %t2814, i8* %t2813, i8* %t2812
  %t2816 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2817 = icmp eq i32 %t2757, 19
  %t2818 = select i1 %t2817, i8* %t2816, i8* %t2815
  %t2819 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t2820 = icmp eq i32 %t2757, 20
  %t2821 = select i1 %t2820, i8* %t2819, i8* %t2818
  %t2822 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2823 = icmp eq i32 %t2757, 21
  %t2824 = select i1 %t2823, i8* %t2822, i8* %t2821
  %t2825 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2826 = icmp eq i32 %t2757, 22
  %t2827 = select i1 %t2826, i8* %t2825, i8* %t2824
  %t2828 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2829 = icmp eq i32 %t2757, 23
  %t2830 = select i1 %t2829, i8* %t2828, i8* %t2827
  %t2831 = call i8* @malloc(i64 15)
  %t2832 = bitcast i8* %t2831 to [15 x i8]*
  store [15 x i8] c"MatchStatement\00", [15 x i8]* %t2832
  %t2833 = call i1 @strings_equal(i8* %t2830, i8* %t2831)
  br i1 %t2833, label %then28, label %merge29
then28:
  %t2834 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t2835 = ptrtoint [0 x %Diagnostic]* %t2834 to i64
  %t2836 = icmp eq i64 %t2835, 0
  %t2837 = select i1 %t2836, i64 1, i64 %t2835
  %t2838 = call i8* @malloc(i64 %t2837)
  %t2839 = bitcast i8* %t2838 to %Diagnostic*
  %t2840 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t2841 = ptrtoint { %Diagnostic*, i64 }* %t2840 to i64
  %t2842 = call i8* @malloc(i64 %t2841)
  %t2843 = bitcast i8* %t2842 to { %Diagnostic*, i64 }*
  %t2844 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2843, i32 0, i32 0
  store %Diagnostic* %t2839, %Diagnostic** %t2844
  %t2845 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2843, i32 0, i32 1
  store i64 0, i64* %t2845
  store { %Diagnostic*, i64 }* %t2843, { %Diagnostic*, i64 }** %l19
  %t2846 = sitofp i64 0 to double
  store double %t2846, double* %l20
  %t2847 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2848 = load double, double* %l20
  br label %loop.header30
loop.header30:
  %t2919 = phi { %Diagnostic*, i64 }* [ %t2847, %then28 ], [ %t2917, %loop.latch32 ]
  %t2920 = phi double [ %t2848, %then28 ], [ %t2918, %loop.latch32 ]
  store { %Diagnostic*, i64 }* %t2919, { %Diagnostic*, i64 }** %l19
  store double %t2920, double* %l20
  br label %loop.body31
loop.body31:
  %t2849 = load double, double* %l20
  %t2850 = extractvalue %Statement %statement, 0
  %t2851 = alloca %Statement
  store %Statement %statement, %Statement* %t2851
  %t2852 = getelementptr inbounds %Statement, %Statement* %t2851, i32 0, i32 1
  %t2853 = bitcast [64 x i8]* %t2852 to i8*
  %t2854 = getelementptr inbounds i8, i8* %t2853, i64 48
  %t2855 = bitcast i8* %t2854 to { %MatchCase*, i64 }**
  %t2856 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %t2855
  %t2857 = icmp eq i32 %t2850, 18
  %t2858 = select i1 %t2857, { %MatchCase*, i64 }* %t2856, { %MatchCase*, i64 }* null
  %t2859 = load { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t2858
  %t2860 = extractvalue { %MatchCase*, i64 } %t2859, 1
  %t2861 = sitofp i64 %t2860 to double
  %t2862 = fcmp oge double %t2849, %t2861
  %t2863 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2864 = load double, double* %l20
  br i1 %t2862, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t2865 = extractvalue %Statement %statement, 0
  %t2866 = alloca %Statement
  store %Statement %statement, %Statement* %t2866
  %t2867 = getelementptr inbounds %Statement, %Statement* %t2866, i32 0, i32 1
  %t2868 = bitcast [64 x i8]* %t2867 to i8*
  %t2869 = getelementptr inbounds i8, i8* %t2868, i64 48
  %t2870 = bitcast i8* %t2869 to { %MatchCase*, i64 }**
  %t2871 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %t2870
  %t2872 = icmp eq i32 %t2865, 18
  %t2873 = select i1 %t2872, { %MatchCase*, i64 }* %t2871, { %MatchCase*, i64 }* null
  %t2874 = load double, double* %l20
  %t2875 = call double @llvm.round.f64(double %t2874)
  %t2876 = fptosi double %t2875 to i64
  %t2877 = load { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t2873
  %t2878 = extractvalue { %MatchCase*, i64 } %t2877, 0
  %t2879 = extractvalue { %MatchCase*, i64 } %t2877, 1
  %t2880 = icmp uge i64 %t2876, %t2879
  ; bounds check: %t2880 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t2876, i64 %t2879)
  %t2881 = getelementptr %MatchCase, %MatchCase* %t2878, i64 %t2876
  %t2882 = load %MatchCase, %MatchCase* %t2881
  store %MatchCase %t2882, %MatchCase* %l21
  %t2883 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2884 = load %MatchCase, %MatchCase* %l21
  %t2885 = extractvalue %MatchCase %t2884, 2
  %t2886 = call { %Diagnostic*, i64 }* @check_block(%Block %t2885, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2887 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2883, i32 0, i32 0
  %t2888 = load %Diagnostic*, %Diagnostic** %t2887
  %t2889 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2883, i32 0, i32 1
  %t2890 = load i64, i64* %t2889
  %t2891 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2886, i32 0, i32 0
  %t2892 = load %Diagnostic*, %Diagnostic** %t2891
  %t2893 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2886, i32 0, i32 1
  %t2894 = load i64, i64* %t2893
  %t2895 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t2896 = ptrtoint %Diagnostic* %t2895 to i64
  %t2897 = add i64 %t2890, %t2894
  %t2898 = mul i64 %t2896, %t2897
  %t2899 = call noalias i8* @malloc(i64 %t2898)
  %t2900 = bitcast i8* %t2899 to %Diagnostic*
  %t2901 = bitcast %Diagnostic* %t2900 to i8*
  %t2902 = mul i64 %t2896, %t2890
  %t2903 = bitcast %Diagnostic* %t2888 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2901, i8* %t2903, i64 %t2902)
  %t2904 = mul i64 %t2896, %t2894
  %t2905 = bitcast %Diagnostic* %t2892 to i8*
  %t2906 = getelementptr %Diagnostic, %Diagnostic* %t2900, i64 %t2890
  %t2907 = bitcast %Diagnostic* %t2906 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2907, i8* %t2905, i64 %t2904)
  %t2908 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t2909 = ptrtoint { %Diagnostic*, i64 }* %t2908 to i64
  %t2910 = call i8* @malloc(i64 %t2909)
  %t2911 = bitcast i8* %t2910 to { %Diagnostic*, i64 }*
  %t2912 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2911, i32 0, i32 0
  store %Diagnostic* %t2900, %Diagnostic** %t2912
  %t2913 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2911, i32 0, i32 1
  store i64 %t2897, i64* %t2913
  store { %Diagnostic*, i64 }* %t2911, { %Diagnostic*, i64 }** %l19
  %t2914 = load double, double* %l20
  %t2915 = sitofp i64 1 to double
  %t2916 = fadd double %t2914, %t2915
  store double %t2916, double* %l20
  br label %loop.latch32
loop.latch32:
  %t2917 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2918 = load double, double* %l20
  br label %loop.header30
afterloop33:
  %t2921 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2922 = load double, double* %l20
  %t2923 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %bindings, 0
  %t2924 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2925 = insertvalue %ScopeResult %t2923, { %Diagnostic*, i64 }* %t2924, 1
  ret %ScopeResult %t2925
merge29:
  %t2926 = extractvalue %Statement %statement, 0
  %t2927 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2928 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2929 = icmp eq i32 %t2926, 0
  %t2930 = select i1 %t2929, i8* %t2928, i8* %t2927
  %t2931 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2932 = icmp eq i32 %t2926, 1
  %t2933 = select i1 %t2932, i8* %t2931, i8* %t2930
  %t2934 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2935 = icmp eq i32 %t2926, 2
  %t2936 = select i1 %t2935, i8* %t2934, i8* %t2933
  %t2937 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2938 = icmp eq i32 %t2926, 3
  %t2939 = select i1 %t2938, i8* %t2937, i8* %t2936
  %t2940 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2941 = icmp eq i32 %t2926, 4
  %t2942 = select i1 %t2941, i8* %t2940, i8* %t2939
  %t2943 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2944 = icmp eq i32 %t2926, 5
  %t2945 = select i1 %t2944, i8* %t2943, i8* %t2942
  %t2946 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2947 = icmp eq i32 %t2926, 6
  %t2948 = select i1 %t2947, i8* %t2946, i8* %t2945
  %t2949 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2950 = icmp eq i32 %t2926, 7
  %t2951 = select i1 %t2950, i8* %t2949, i8* %t2948
  %t2952 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2953 = icmp eq i32 %t2926, 8
  %t2954 = select i1 %t2953, i8* %t2952, i8* %t2951
  %t2955 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2956 = icmp eq i32 %t2926, 9
  %t2957 = select i1 %t2956, i8* %t2955, i8* %t2954
  %t2958 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2959 = icmp eq i32 %t2926, 10
  %t2960 = select i1 %t2959, i8* %t2958, i8* %t2957
  %t2961 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2962 = icmp eq i32 %t2926, 11
  %t2963 = select i1 %t2962, i8* %t2961, i8* %t2960
  %t2964 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2965 = icmp eq i32 %t2926, 12
  %t2966 = select i1 %t2965, i8* %t2964, i8* %t2963
  %t2967 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2968 = icmp eq i32 %t2926, 13
  %t2969 = select i1 %t2968, i8* %t2967, i8* %t2966
  %t2970 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2971 = icmp eq i32 %t2926, 14
  %t2972 = select i1 %t2971, i8* %t2970, i8* %t2969
  %t2973 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2974 = icmp eq i32 %t2926, 15
  %t2975 = select i1 %t2974, i8* %t2973, i8* %t2972
  %t2976 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2977 = icmp eq i32 %t2926, 16
  %t2978 = select i1 %t2977, i8* %t2976, i8* %t2975
  %t2979 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2980 = icmp eq i32 %t2926, 17
  %t2981 = select i1 %t2980, i8* %t2979, i8* %t2978
  %t2982 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2983 = icmp eq i32 %t2926, 18
  %t2984 = select i1 %t2983, i8* %t2982, i8* %t2981
  %t2985 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2986 = icmp eq i32 %t2926, 19
  %t2987 = select i1 %t2986, i8* %t2985, i8* %t2984
  %t2988 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t2989 = icmp eq i32 %t2926, 20
  %t2990 = select i1 %t2989, i8* %t2988, i8* %t2987
  %t2991 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2992 = icmp eq i32 %t2926, 21
  %t2993 = select i1 %t2992, i8* %t2991, i8* %t2990
  %t2994 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2995 = icmp eq i32 %t2926, 22
  %t2996 = select i1 %t2995, i8* %t2994, i8* %t2993
  %t2997 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2998 = icmp eq i32 %t2926, 23
  %t2999 = select i1 %t2998, i8* %t2997, i8* %t2996
  %t3000 = call i8* @malloc(i64 12)
  %t3001 = bitcast i8* %t3000 to [12 x i8]*
  store [12 x i8] c"IfStatement\00", [12 x i8]* %t3001
  %t3002 = call i1 @strings_equal(i8* %t2999, i8* %t3000)
  br i1 %t3002, label %then36, label %merge37
then36:
  %t3003 = extractvalue %Statement %statement, 0
  %t3004 = alloca %Statement
  store %Statement %statement, %Statement* %t3004
  %t3005 = getelementptr inbounds %Statement, %Statement* %t3004, i32 0, i32 1
  %t3006 = bitcast [88 x i8]* %t3005 to i8*
  %t3007 = getelementptr inbounds i8, i8* %t3006, i64 48
  %t3008 = bitcast i8* %t3007 to %Block*
  %t3009 = load %Block, %Block* %t3008
  %t3010 = icmp eq i32 %t3003, 19
  %t3011 = select i1 %t3010, %Block %t3009, %Block zeroinitializer
  %t3012 = call { %Diagnostic*, i64 }* @check_block(%Block %t3011, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t3012, { %Diagnostic*, i64 }** %l22
  %t3013 = extractvalue %Statement %statement, 0
  %t3014 = alloca %Statement
  store %Statement %statement, %Statement* %t3014
  %t3015 = getelementptr inbounds %Statement, %Statement* %t3014, i32 0, i32 1
  %t3016 = bitcast [88 x i8]* %t3015 to i8*
  %t3017 = getelementptr inbounds i8, i8* %t3016, i64 72
  %t3018 = bitcast i8* %t3017 to %ElseBranch**
  %t3019 = load %ElseBranch*, %ElseBranch** %t3018
  %t3020 = icmp eq i32 %t3013, 19
  %t3021 = select i1 %t3020, %ElseBranch* %t3019, %ElseBranch* null
  %t3022 = icmp ne %ElseBranch* %t3021, null
  %t3023 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br i1 %t3022, label %then38, label %merge39
then38:
  %t3024 = extractvalue %Statement %statement, 0
  %t3025 = alloca %Statement
  store %Statement %statement, %Statement* %t3025
  %t3026 = getelementptr inbounds %Statement, %Statement* %t3025, i32 0, i32 1
  %t3027 = bitcast [88 x i8]* %t3026 to i8*
  %t3028 = getelementptr inbounds i8, i8* %t3027, i64 72
  %t3029 = bitcast i8* %t3028 to %ElseBranch**
  %t3030 = load %ElseBranch*, %ElseBranch** %t3029
  %t3031 = icmp eq i32 %t3024, 19
  %t3032 = select i1 %t3031, %ElseBranch* %t3030, %ElseBranch* null
  store %ElseBranch* %t3032, %ElseBranch** %l23
  %t3033 = load %ElseBranch*, %ElseBranch** %l23
  %t3034 = getelementptr %ElseBranch, %ElseBranch* %t3033, i32 0, i32 1
  %t3035 = load %Block*, %Block** %t3034
  %t3036 = icmp ne %Block* %t3035, null
  %t3037 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t3038 = load %ElseBranch*, %ElseBranch** %l23
  br i1 %t3036, label %then40, label %merge41
then40:
  %t3039 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t3040 = load %ElseBranch*, %ElseBranch** %l23
  %t3041 = getelementptr %ElseBranch, %ElseBranch* %t3040, i32 0, i32 1
  %t3042 = load %Block*, %Block** %t3041
  %t3043 = load %Block, %Block* %t3042
  %t3044 = call { %Diagnostic*, i64 }* @check_block(%Block %t3043, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t3045 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3039, i32 0, i32 0
  %t3046 = load %Diagnostic*, %Diagnostic** %t3045
  %t3047 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3039, i32 0, i32 1
  %t3048 = load i64, i64* %t3047
  %t3049 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3044, i32 0, i32 0
  %t3050 = load %Diagnostic*, %Diagnostic** %t3049
  %t3051 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3044, i32 0, i32 1
  %t3052 = load i64, i64* %t3051
  %t3053 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t3054 = ptrtoint %Diagnostic* %t3053 to i64
  %t3055 = add i64 %t3048, %t3052
  %t3056 = mul i64 %t3054, %t3055
  %t3057 = call noalias i8* @malloc(i64 %t3056)
  %t3058 = bitcast i8* %t3057 to %Diagnostic*
  %t3059 = bitcast %Diagnostic* %t3058 to i8*
  %t3060 = mul i64 %t3054, %t3048
  %t3061 = bitcast %Diagnostic* %t3046 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t3059, i8* %t3061, i64 %t3060)
  %t3062 = mul i64 %t3054, %t3052
  %t3063 = bitcast %Diagnostic* %t3050 to i8*
  %t3064 = getelementptr %Diagnostic, %Diagnostic* %t3058, i64 %t3048
  %t3065 = bitcast %Diagnostic* %t3064 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t3065, i8* %t3063, i64 %t3062)
  %t3066 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t3067 = ptrtoint { %Diagnostic*, i64 }* %t3066 to i64
  %t3068 = call i8* @malloc(i64 %t3067)
  %t3069 = bitcast i8* %t3068 to { %Diagnostic*, i64 }*
  %t3070 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3069, i32 0, i32 0
  store %Diagnostic* %t3058, %Diagnostic** %t3070
  %t3071 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3069, i32 0, i32 1
  store i64 %t3055, i64* %t3071
  store { %Diagnostic*, i64 }* %t3069, { %Diagnostic*, i64 }** %l22
  %t3072 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br label %merge41
merge41:
  %t3073 = phi { %Diagnostic*, i64 }* [ %t3072, %then40 ], [ %t3037, %then38 ]
  store { %Diagnostic*, i64 }* %t3073, { %Diagnostic*, i64 }** %l22
  %t3074 = load %ElseBranch*, %ElseBranch** %l23
  %t3075 = getelementptr %ElseBranch, %ElseBranch* %t3074, i32 0, i32 0
  %t3076 = load %Statement*, %Statement** %t3075
  %t3077 = icmp ne %Statement* %t3076, null
  %t3078 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t3079 = load %ElseBranch*, %ElseBranch** %l23
  br i1 %t3077, label %then42, label %merge43
then42:
  %t3080 = load %ElseBranch*, %ElseBranch** %l23
  %t3081 = getelementptr %ElseBranch, %ElseBranch* %t3080, i32 0, i32 0
  %t3082 = load %Statement*, %Statement** %t3081
  %t3083 = load %Statement, %Statement* %t3082
  %t3084 = call %ScopeResult @check_statement(%Statement %t3083, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  store %ScopeResult %t3084, %ScopeResult* %l24
  %t3085 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t3086 = load %ScopeResult, %ScopeResult* %l24
  %t3087 = extractvalue %ScopeResult %t3086, 1
  %t3088 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3085, i32 0, i32 0
  %t3089 = load %Diagnostic*, %Diagnostic** %t3088
  %t3090 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3085, i32 0, i32 1
  %t3091 = load i64, i64* %t3090
  %t3092 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3087, i32 0, i32 0
  %t3093 = load %Diagnostic*, %Diagnostic** %t3092
  %t3094 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3087, i32 0, i32 1
  %t3095 = load i64, i64* %t3094
  %t3096 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t3097 = ptrtoint %Diagnostic* %t3096 to i64
  %t3098 = add i64 %t3091, %t3095
  %t3099 = mul i64 %t3097, %t3098
  %t3100 = call noalias i8* @malloc(i64 %t3099)
  %t3101 = bitcast i8* %t3100 to %Diagnostic*
  %t3102 = bitcast %Diagnostic* %t3101 to i8*
  %t3103 = mul i64 %t3097, %t3091
  %t3104 = bitcast %Diagnostic* %t3089 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t3102, i8* %t3104, i64 %t3103)
  %t3105 = mul i64 %t3097, %t3095
  %t3106 = bitcast %Diagnostic* %t3093 to i8*
  %t3107 = getelementptr %Diagnostic, %Diagnostic* %t3101, i64 %t3091
  %t3108 = bitcast %Diagnostic* %t3107 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t3108, i8* %t3106, i64 %t3105)
  %t3109 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t3110 = ptrtoint { %Diagnostic*, i64 }* %t3109 to i64
  %t3111 = call i8* @malloc(i64 %t3110)
  %t3112 = bitcast i8* %t3111 to { %Diagnostic*, i64 }*
  %t3113 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3112, i32 0, i32 0
  store %Diagnostic* %t3101, %Diagnostic** %t3113
  %t3114 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3112, i32 0, i32 1
  store i64 %t3098, i64* %t3114
  store { %Diagnostic*, i64 }* %t3112, { %Diagnostic*, i64 }** %l22
  %t3115 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br label %merge43
merge43:
  %t3116 = phi { %Diagnostic*, i64 }* [ %t3115, %then42 ], [ %t3078, %merge41 ]
  store { %Diagnostic*, i64 }* %t3116, { %Diagnostic*, i64 }** %l22
  %t3117 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t3118 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br label %merge39
merge39:
  %t3119 = phi { %Diagnostic*, i64 }* [ %t3117, %merge43 ], [ %t3023, %then36 ]
  %t3120 = phi { %Diagnostic*, i64 }* [ %t3118, %merge43 ], [ %t3023, %then36 ]
  store { %Diagnostic*, i64 }* %t3119, { %Diagnostic*, i64 }** %l22
  store { %Diagnostic*, i64 }* %t3120, { %Diagnostic*, i64 }** %l22
  %t3121 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %bindings, 0
  %t3122 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t3123 = insertvalue %ScopeResult %t3121, { %Diagnostic*, i64 }* %t3122, 1
  ret %ScopeResult %t3123
merge37:
  %t3124 = extractvalue %Statement %statement, 0
  %t3125 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t3126 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t3127 = icmp eq i32 %t3124, 0
  %t3128 = select i1 %t3127, i8* %t3126, i8* %t3125
  %t3129 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t3130 = icmp eq i32 %t3124, 1
  %t3131 = select i1 %t3130, i8* %t3129, i8* %t3128
  %t3132 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t3133 = icmp eq i32 %t3124, 2
  %t3134 = select i1 %t3133, i8* %t3132, i8* %t3131
  %t3135 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t3136 = icmp eq i32 %t3124, 3
  %t3137 = select i1 %t3136, i8* %t3135, i8* %t3134
  %t3138 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t3139 = icmp eq i32 %t3124, 4
  %t3140 = select i1 %t3139, i8* %t3138, i8* %t3137
  %t3141 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t3142 = icmp eq i32 %t3124, 5
  %t3143 = select i1 %t3142, i8* %t3141, i8* %t3140
  %t3144 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t3145 = icmp eq i32 %t3124, 6
  %t3146 = select i1 %t3145, i8* %t3144, i8* %t3143
  %t3147 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t3148 = icmp eq i32 %t3124, 7
  %t3149 = select i1 %t3148, i8* %t3147, i8* %t3146
  %t3150 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t3151 = icmp eq i32 %t3124, 8
  %t3152 = select i1 %t3151, i8* %t3150, i8* %t3149
  %t3153 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t3154 = icmp eq i32 %t3124, 9
  %t3155 = select i1 %t3154, i8* %t3153, i8* %t3152
  %t3156 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t3157 = icmp eq i32 %t3124, 10
  %t3158 = select i1 %t3157, i8* %t3156, i8* %t3155
  %t3159 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t3160 = icmp eq i32 %t3124, 11
  %t3161 = select i1 %t3160, i8* %t3159, i8* %t3158
  %t3162 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t3163 = icmp eq i32 %t3124, 12
  %t3164 = select i1 %t3163, i8* %t3162, i8* %t3161
  %t3165 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t3166 = icmp eq i32 %t3124, 13
  %t3167 = select i1 %t3166, i8* %t3165, i8* %t3164
  %t3168 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t3169 = icmp eq i32 %t3124, 14
  %t3170 = select i1 %t3169, i8* %t3168, i8* %t3167
  %t3171 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t3172 = icmp eq i32 %t3124, 15
  %t3173 = select i1 %t3172, i8* %t3171, i8* %t3170
  %t3174 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t3175 = icmp eq i32 %t3124, 16
  %t3176 = select i1 %t3175, i8* %t3174, i8* %t3173
  %t3177 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t3178 = icmp eq i32 %t3124, 17
  %t3179 = select i1 %t3178, i8* %t3177, i8* %t3176
  %t3180 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t3181 = icmp eq i32 %t3124, 18
  %t3182 = select i1 %t3181, i8* %t3180, i8* %t3179
  %t3183 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t3184 = icmp eq i32 %t3124, 19
  %t3185 = select i1 %t3184, i8* %t3183, i8* %t3182
  %t3186 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t3187 = icmp eq i32 %t3124, 20
  %t3188 = select i1 %t3187, i8* %t3186, i8* %t3185
  %t3189 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t3190 = icmp eq i32 %t3124, 21
  %t3191 = select i1 %t3190, i8* %t3189, i8* %t3188
  %t3192 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t3193 = icmp eq i32 %t3124, 22
  %t3194 = select i1 %t3193, i8* %t3192, i8* %t3191
  %t3195 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t3196 = icmp eq i32 %t3124, 23
  %t3197 = select i1 %t3196, i8* %t3195, i8* %t3194
  %t3198 = call i8* @malloc(i64 15)
  %t3199 = bitcast i8* %t3198 to [15 x i8]*
  store [15 x i8] c"BlockStatement\00", [15 x i8]* %t3199
  %t3200 = call i1 @strings_equal(i8* %t3197, i8* %t3198)
  br i1 %t3200, label %then44, label %merge45
then44:
  %t3201 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %bindings, 0
  %t3202 = extractvalue %Statement %statement, 0
  %t3203 = alloca %Statement
  store %Statement %statement, %Statement* %t3203
  %t3204 = getelementptr inbounds %Statement, %Statement* %t3203, i32 0, i32 1
  %t3205 = bitcast [88 x i8]* %t3204 to i8*
  %t3206 = getelementptr inbounds i8, i8* %t3205, i64 56
  %t3207 = bitcast i8* %t3206 to %Block*
  %t3208 = load %Block, %Block* %t3207
  %t3209 = icmp eq i32 %t3202, 4
  %t3210 = select i1 %t3209, %Block %t3208, %Block zeroinitializer
  %t3211 = getelementptr inbounds %Statement, %Statement* %t3203, i32 0, i32 1
  %t3212 = bitcast [88 x i8]* %t3211 to i8*
  %t3213 = getelementptr inbounds i8, i8* %t3212, i64 56
  %t3214 = bitcast i8* %t3213 to %Block*
  %t3215 = load %Block, %Block* %t3214
  %t3216 = icmp eq i32 %t3202, 5
  %t3217 = select i1 %t3216, %Block %t3215, %Block %t3210
  %t3218 = getelementptr inbounds %Statement, %Statement* %t3203, i32 0, i32 1
  %t3219 = bitcast [56 x i8]* %t3218 to i8*
  %t3220 = getelementptr inbounds i8, i8* %t3219, i64 16
  %t3221 = bitcast i8* %t3220 to %Block*
  %t3222 = load %Block, %Block* %t3221
  %t3223 = icmp eq i32 %t3202, 6
  %t3224 = select i1 %t3223, %Block %t3222, %Block %t3217
  %t3225 = getelementptr inbounds %Statement, %Statement* %t3203, i32 0, i32 1
  %t3226 = bitcast [88 x i8]* %t3225 to i8*
  %t3227 = getelementptr inbounds i8, i8* %t3226, i64 56
  %t3228 = bitcast i8* %t3227 to %Block*
  %t3229 = load %Block, %Block* %t3228
  %t3230 = icmp eq i32 %t3202, 7
  %t3231 = select i1 %t3230, %Block %t3229, %Block %t3224
  %t3232 = getelementptr inbounds %Statement, %Statement* %t3203, i32 0, i32 1
  %t3233 = bitcast [120 x i8]* %t3232 to i8*
  %t3234 = getelementptr inbounds i8, i8* %t3233, i64 88
  %t3235 = bitcast i8* %t3234 to %Block*
  %t3236 = load %Block, %Block* %t3235
  %t3237 = icmp eq i32 %t3202, 12
  %t3238 = select i1 %t3237, %Block %t3236, %Block %t3231
  %t3239 = getelementptr inbounds %Statement, %Statement* %t3203, i32 0, i32 1
  %t3240 = bitcast [40 x i8]* %t3239 to i8*
  %t3241 = getelementptr inbounds i8, i8* %t3240, i64 8
  %t3242 = bitcast i8* %t3241 to %Block*
  %t3243 = load %Block, %Block* %t3242
  %t3244 = icmp eq i32 %t3202, 13
  %t3245 = select i1 %t3244, %Block %t3243, %Block %t3238
  %t3246 = getelementptr inbounds %Statement, %Statement* %t3203, i32 0, i32 1
  %t3247 = bitcast [136 x i8]* %t3246 to i8*
  %t3248 = getelementptr inbounds i8, i8* %t3247, i64 104
  %t3249 = bitcast i8* %t3248 to %Block*
  %t3250 = load %Block, %Block* %t3249
  %t3251 = icmp eq i32 %t3202, 14
  %t3252 = select i1 %t3251, %Block %t3250, %Block %t3245
  %t3253 = getelementptr inbounds %Statement, %Statement* %t3203, i32 0, i32 1
  %t3254 = bitcast [32 x i8]* %t3253 to i8*
  %t3255 = bitcast i8* %t3254 to %Block*
  %t3256 = load %Block, %Block* %t3255
  %t3257 = icmp eq i32 %t3202, 15
  %t3258 = select i1 %t3257, %Block %t3256, %Block %t3252
  %t3259 = getelementptr inbounds %Statement, %Statement* %t3203, i32 0, i32 1
  %t3260 = bitcast [24 x i8]* %t3259 to i8*
  %t3261 = bitcast i8* %t3260 to %Block*
  %t3262 = load %Block, %Block* %t3261
  %t3263 = icmp eq i32 %t3202, 20
  %t3264 = select i1 %t3263, %Block %t3262, %Block %t3258
  %t3265 = call { %Diagnostic*, i64 }* @check_block(%Block %t3264, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t3266 = insertvalue %ScopeResult %t3201, { %Diagnostic*, i64 }* %t3265, 1
  ret %ScopeResult %t3266
merge45:
  %t3267 = extractvalue %Statement %statement, 0
  %t3268 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t3269 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t3270 = icmp eq i32 %t3267, 0
  %t3271 = select i1 %t3270, i8* %t3269, i8* %t3268
  %t3272 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t3273 = icmp eq i32 %t3267, 1
  %t3274 = select i1 %t3273, i8* %t3272, i8* %t3271
  %t3275 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t3276 = icmp eq i32 %t3267, 2
  %t3277 = select i1 %t3276, i8* %t3275, i8* %t3274
  %t3278 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t3279 = icmp eq i32 %t3267, 3
  %t3280 = select i1 %t3279, i8* %t3278, i8* %t3277
  %t3281 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t3282 = icmp eq i32 %t3267, 4
  %t3283 = select i1 %t3282, i8* %t3281, i8* %t3280
  %t3284 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t3285 = icmp eq i32 %t3267, 5
  %t3286 = select i1 %t3285, i8* %t3284, i8* %t3283
  %t3287 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t3288 = icmp eq i32 %t3267, 6
  %t3289 = select i1 %t3288, i8* %t3287, i8* %t3286
  %t3290 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t3291 = icmp eq i32 %t3267, 7
  %t3292 = select i1 %t3291, i8* %t3290, i8* %t3289
  %t3293 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t3294 = icmp eq i32 %t3267, 8
  %t3295 = select i1 %t3294, i8* %t3293, i8* %t3292
  %t3296 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t3297 = icmp eq i32 %t3267, 9
  %t3298 = select i1 %t3297, i8* %t3296, i8* %t3295
  %t3299 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t3300 = icmp eq i32 %t3267, 10
  %t3301 = select i1 %t3300, i8* %t3299, i8* %t3298
  %t3302 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t3303 = icmp eq i32 %t3267, 11
  %t3304 = select i1 %t3303, i8* %t3302, i8* %t3301
  %t3305 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t3306 = icmp eq i32 %t3267, 12
  %t3307 = select i1 %t3306, i8* %t3305, i8* %t3304
  %t3308 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t3309 = icmp eq i32 %t3267, 13
  %t3310 = select i1 %t3309, i8* %t3308, i8* %t3307
  %t3311 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t3312 = icmp eq i32 %t3267, 14
  %t3313 = select i1 %t3312, i8* %t3311, i8* %t3310
  %t3314 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t3315 = icmp eq i32 %t3267, 15
  %t3316 = select i1 %t3315, i8* %t3314, i8* %t3313
  %t3317 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t3318 = icmp eq i32 %t3267, 16
  %t3319 = select i1 %t3318, i8* %t3317, i8* %t3316
  %t3320 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t3321 = icmp eq i32 %t3267, 17
  %t3322 = select i1 %t3321, i8* %t3320, i8* %t3319
  %t3323 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t3324 = icmp eq i32 %t3267, 18
  %t3325 = select i1 %t3324, i8* %t3323, i8* %t3322
  %t3326 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t3327 = icmp eq i32 %t3267, 19
  %t3328 = select i1 %t3327, i8* %t3326, i8* %t3325
  %t3329 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t3330 = icmp eq i32 %t3267, 20
  %t3331 = select i1 %t3330, i8* %t3329, i8* %t3328
  %t3332 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t3333 = icmp eq i32 %t3267, 21
  %t3334 = select i1 %t3333, i8* %t3332, i8* %t3331
  %t3335 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t3336 = icmp eq i32 %t3267, 22
  %t3337 = select i1 %t3336, i8* %t3335, i8* %t3334
  %t3338 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t3339 = icmp eq i32 %t3267, 23
  %t3340 = select i1 %t3339, i8* %t3338, i8* %t3337
  %t3341 = call i8* @malloc(i64 16)
  %t3342 = bitcast i8* %t3341 to [16 x i8]*
  store [16 x i8] c"PromptStatement\00", [16 x i8]* %t3342
  %t3343 = call i1 @strings_equal(i8* %t3340, i8* %t3341)
  br i1 %t3343, label %then46, label %merge47
then46:
  %t3344 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %bindings, 0
  %t3345 = extractvalue %Statement %statement, 0
  %t3346 = alloca %Statement
  store %Statement %statement, %Statement* %t3346
  %t3347 = getelementptr inbounds %Statement, %Statement* %t3346, i32 0, i32 1
  %t3348 = bitcast [88 x i8]* %t3347 to i8*
  %t3349 = getelementptr inbounds i8, i8* %t3348, i64 56
  %t3350 = bitcast i8* %t3349 to %Block*
  %t3351 = load %Block, %Block* %t3350
  %t3352 = icmp eq i32 %t3345, 4
  %t3353 = select i1 %t3352, %Block %t3351, %Block zeroinitializer
  %t3354 = getelementptr inbounds %Statement, %Statement* %t3346, i32 0, i32 1
  %t3355 = bitcast [88 x i8]* %t3354 to i8*
  %t3356 = getelementptr inbounds i8, i8* %t3355, i64 56
  %t3357 = bitcast i8* %t3356 to %Block*
  %t3358 = load %Block, %Block* %t3357
  %t3359 = icmp eq i32 %t3345, 5
  %t3360 = select i1 %t3359, %Block %t3358, %Block %t3353
  %t3361 = getelementptr inbounds %Statement, %Statement* %t3346, i32 0, i32 1
  %t3362 = bitcast [56 x i8]* %t3361 to i8*
  %t3363 = getelementptr inbounds i8, i8* %t3362, i64 16
  %t3364 = bitcast i8* %t3363 to %Block*
  %t3365 = load %Block, %Block* %t3364
  %t3366 = icmp eq i32 %t3345, 6
  %t3367 = select i1 %t3366, %Block %t3365, %Block %t3360
  %t3368 = getelementptr inbounds %Statement, %Statement* %t3346, i32 0, i32 1
  %t3369 = bitcast [88 x i8]* %t3368 to i8*
  %t3370 = getelementptr inbounds i8, i8* %t3369, i64 56
  %t3371 = bitcast i8* %t3370 to %Block*
  %t3372 = load %Block, %Block* %t3371
  %t3373 = icmp eq i32 %t3345, 7
  %t3374 = select i1 %t3373, %Block %t3372, %Block %t3367
  %t3375 = getelementptr inbounds %Statement, %Statement* %t3346, i32 0, i32 1
  %t3376 = bitcast [120 x i8]* %t3375 to i8*
  %t3377 = getelementptr inbounds i8, i8* %t3376, i64 88
  %t3378 = bitcast i8* %t3377 to %Block*
  %t3379 = load %Block, %Block* %t3378
  %t3380 = icmp eq i32 %t3345, 12
  %t3381 = select i1 %t3380, %Block %t3379, %Block %t3374
  %t3382 = getelementptr inbounds %Statement, %Statement* %t3346, i32 0, i32 1
  %t3383 = bitcast [40 x i8]* %t3382 to i8*
  %t3384 = getelementptr inbounds i8, i8* %t3383, i64 8
  %t3385 = bitcast i8* %t3384 to %Block*
  %t3386 = load %Block, %Block* %t3385
  %t3387 = icmp eq i32 %t3345, 13
  %t3388 = select i1 %t3387, %Block %t3386, %Block %t3381
  %t3389 = getelementptr inbounds %Statement, %Statement* %t3346, i32 0, i32 1
  %t3390 = bitcast [136 x i8]* %t3389 to i8*
  %t3391 = getelementptr inbounds i8, i8* %t3390, i64 104
  %t3392 = bitcast i8* %t3391 to %Block*
  %t3393 = load %Block, %Block* %t3392
  %t3394 = icmp eq i32 %t3345, 14
  %t3395 = select i1 %t3394, %Block %t3393, %Block %t3388
  %t3396 = getelementptr inbounds %Statement, %Statement* %t3346, i32 0, i32 1
  %t3397 = bitcast [32 x i8]* %t3396 to i8*
  %t3398 = bitcast i8* %t3397 to %Block*
  %t3399 = load %Block, %Block* %t3398
  %t3400 = icmp eq i32 %t3345, 15
  %t3401 = select i1 %t3400, %Block %t3399, %Block %t3395
  %t3402 = getelementptr inbounds %Statement, %Statement* %t3346, i32 0, i32 1
  %t3403 = bitcast [24 x i8]* %t3402 to i8*
  %t3404 = bitcast i8* %t3403 to %Block*
  %t3405 = load %Block, %Block* %t3404
  %t3406 = icmp eq i32 %t3345, 20
  %t3407 = select i1 %t3406, %Block %t3405, %Block %t3401
  %t3408 = call { %Diagnostic*, i64 }* @check_block(%Block %t3407, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t3409 = insertvalue %ScopeResult %t3344, { %Diagnostic*, i64 }* %t3408, 1
  ret %ScopeResult %t3409
merge47:
  %t3410 = extractvalue %Statement %statement, 0
  %t3411 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t3412 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t3413 = icmp eq i32 %t3410, 0
  %t3414 = select i1 %t3413, i8* %t3412, i8* %t3411
  %t3415 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t3416 = icmp eq i32 %t3410, 1
  %t3417 = select i1 %t3416, i8* %t3415, i8* %t3414
  %t3418 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t3419 = icmp eq i32 %t3410, 2
  %t3420 = select i1 %t3419, i8* %t3418, i8* %t3417
  %t3421 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t3422 = icmp eq i32 %t3410, 3
  %t3423 = select i1 %t3422, i8* %t3421, i8* %t3420
  %t3424 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t3425 = icmp eq i32 %t3410, 4
  %t3426 = select i1 %t3425, i8* %t3424, i8* %t3423
  %t3427 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t3428 = icmp eq i32 %t3410, 5
  %t3429 = select i1 %t3428, i8* %t3427, i8* %t3426
  %t3430 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t3431 = icmp eq i32 %t3410, 6
  %t3432 = select i1 %t3431, i8* %t3430, i8* %t3429
  %t3433 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t3434 = icmp eq i32 %t3410, 7
  %t3435 = select i1 %t3434, i8* %t3433, i8* %t3432
  %t3436 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t3437 = icmp eq i32 %t3410, 8
  %t3438 = select i1 %t3437, i8* %t3436, i8* %t3435
  %t3439 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t3440 = icmp eq i32 %t3410, 9
  %t3441 = select i1 %t3440, i8* %t3439, i8* %t3438
  %t3442 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t3443 = icmp eq i32 %t3410, 10
  %t3444 = select i1 %t3443, i8* %t3442, i8* %t3441
  %t3445 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t3446 = icmp eq i32 %t3410, 11
  %t3447 = select i1 %t3446, i8* %t3445, i8* %t3444
  %t3448 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t3449 = icmp eq i32 %t3410, 12
  %t3450 = select i1 %t3449, i8* %t3448, i8* %t3447
  %t3451 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t3452 = icmp eq i32 %t3410, 13
  %t3453 = select i1 %t3452, i8* %t3451, i8* %t3450
  %t3454 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t3455 = icmp eq i32 %t3410, 14
  %t3456 = select i1 %t3455, i8* %t3454, i8* %t3453
  %t3457 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t3458 = icmp eq i32 %t3410, 15
  %t3459 = select i1 %t3458, i8* %t3457, i8* %t3456
  %t3460 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t3461 = icmp eq i32 %t3410, 16
  %t3462 = select i1 %t3461, i8* %t3460, i8* %t3459
  %t3463 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t3464 = icmp eq i32 %t3410, 17
  %t3465 = select i1 %t3464, i8* %t3463, i8* %t3462
  %t3466 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t3467 = icmp eq i32 %t3410, 18
  %t3468 = select i1 %t3467, i8* %t3466, i8* %t3465
  %t3469 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t3470 = icmp eq i32 %t3410, 19
  %t3471 = select i1 %t3470, i8* %t3469, i8* %t3468
  %t3472 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t3473 = icmp eq i32 %t3410, 20
  %t3474 = select i1 %t3473, i8* %t3472, i8* %t3471
  %t3475 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t3476 = icmp eq i32 %t3410, 21
  %t3477 = select i1 %t3476, i8* %t3475, i8* %t3474
  %t3478 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t3479 = icmp eq i32 %t3410, 22
  %t3480 = select i1 %t3479, i8* %t3478, i8* %t3477
  %t3481 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t3482 = icmp eq i32 %t3410, 23
  %t3483 = select i1 %t3482, i8* %t3481, i8* %t3480
  %t3484 = call i8* @malloc(i64 21)
  %t3485 = bitcast i8* %t3484 to [21 x i8]*
  store [21 x i8] c"TypeAliasDeclaration\00", [21 x i8]* %t3485
  %t3486 = call i1 @strings_equal(i8* %t3483, i8* %t3484)
  br i1 %t3486, label %then48, label %merge49
then48:
  %t3487 = extractvalue %Statement %statement, 0
  %t3488 = alloca %Statement
  store %Statement %statement, %Statement* %t3488
  %t3489 = getelementptr inbounds %Statement, %Statement* %t3488, i32 0, i32 1
  %t3490 = bitcast [48 x i8]* %t3489 to i8*
  %t3491 = bitcast i8* %t3490 to i8**
  %t3492 = load i8*, i8** %t3491
  %t3493 = icmp eq i32 %t3487, 2
  %t3494 = select i1 %t3493, i8* %t3492, i8* null
  %t3495 = getelementptr inbounds %Statement, %Statement* %t3488, i32 0, i32 1
  %t3496 = bitcast [48 x i8]* %t3495 to i8*
  %t3497 = bitcast i8* %t3496 to i8**
  %t3498 = load i8*, i8** %t3497
  %t3499 = icmp eq i32 %t3487, 3
  %t3500 = select i1 %t3499, i8* %t3498, i8* %t3494
  %t3501 = getelementptr inbounds %Statement, %Statement* %t3488, i32 0, i32 1
  %t3502 = bitcast [56 x i8]* %t3501 to i8*
  %t3503 = bitcast i8* %t3502 to i8**
  %t3504 = load i8*, i8** %t3503
  %t3505 = icmp eq i32 %t3487, 6
  %t3506 = select i1 %t3505, i8* %t3504, i8* %t3500
  %t3507 = getelementptr inbounds %Statement, %Statement* %t3488, i32 0, i32 1
  %t3508 = bitcast [56 x i8]* %t3507 to i8*
  %t3509 = bitcast i8* %t3508 to i8**
  %t3510 = load i8*, i8** %t3509
  %t3511 = icmp eq i32 %t3487, 8
  %t3512 = select i1 %t3511, i8* %t3510, i8* %t3506
  %t3513 = getelementptr inbounds %Statement, %Statement* %t3488, i32 0, i32 1
  %t3514 = bitcast [40 x i8]* %t3513 to i8*
  %t3515 = bitcast i8* %t3514 to i8**
  %t3516 = load i8*, i8** %t3515
  %t3517 = icmp eq i32 %t3487, 9
  %t3518 = select i1 %t3517, i8* %t3516, i8* %t3512
  %t3519 = getelementptr inbounds %Statement, %Statement* %t3488, i32 0, i32 1
  %t3520 = bitcast [40 x i8]* %t3519 to i8*
  %t3521 = bitcast i8* %t3520 to i8**
  %t3522 = load i8*, i8** %t3521
  %t3523 = icmp eq i32 %t3487, 10
  %t3524 = select i1 %t3523, i8* %t3522, i8* %t3518
  %t3525 = getelementptr inbounds %Statement, %Statement* %t3488, i32 0, i32 1
  %t3526 = bitcast [40 x i8]* %t3525 to i8*
  %t3527 = bitcast i8* %t3526 to i8**
  %t3528 = load i8*, i8** %t3527
  %t3529 = icmp eq i32 %t3487, 11
  %t3530 = select i1 %t3529, i8* %t3528, i8* %t3524
  %t3531 = call i8* @malloc(i64 5)
  %t3532 = bitcast i8* %t3531 to [5 x i8]*
  store [5 x i8] c"type\00", [5 x i8]* %t3532
  %t3533 = extractvalue %Statement %statement, 0
  %t3534 = alloca %Statement
  store %Statement %statement, %Statement* %t3534
  %t3535 = getelementptr inbounds %Statement, %Statement* %t3534, i32 0, i32 1
  %t3536 = bitcast [48 x i8]* %t3535 to i8*
  %t3537 = getelementptr inbounds i8, i8* %t3536, i64 8
  %t3538 = bitcast i8* %t3537 to %SourceSpan**
  %t3539 = load %SourceSpan*, %SourceSpan** %t3538
  %t3540 = icmp eq i32 %t3533, 3
  %t3541 = select i1 %t3540, %SourceSpan* %t3539, %SourceSpan* null
  %t3542 = getelementptr inbounds %Statement, %Statement* %t3534, i32 0, i32 1
  %t3543 = bitcast [56 x i8]* %t3542 to i8*
  %t3544 = getelementptr inbounds i8, i8* %t3543, i64 8
  %t3545 = bitcast i8* %t3544 to %SourceSpan**
  %t3546 = load %SourceSpan*, %SourceSpan** %t3545
  %t3547 = icmp eq i32 %t3533, 6
  %t3548 = select i1 %t3547, %SourceSpan* %t3546, %SourceSpan* %t3541
  %t3549 = getelementptr inbounds %Statement, %Statement* %t3534, i32 0, i32 1
  %t3550 = bitcast [56 x i8]* %t3549 to i8*
  %t3551 = getelementptr inbounds i8, i8* %t3550, i64 8
  %t3552 = bitcast i8* %t3551 to %SourceSpan**
  %t3553 = load %SourceSpan*, %SourceSpan** %t3552
  %t3554 = icmp eq i32 %t3533, 8
  %t3555 = select i1 %t3554, %SourceSpan* %t3553, %SourceSpan* %t3548
  %t3556 = getelementptr inbounds %Statement, %Statement* %t3534, i32 0, i32 1
  %t3557 = bitcast [40 x i8]* %t3556 to i8*
  %t3558 = getelementptr inbounds i8, i8* %t3557, i64 8
  %t3559 = bitcast i8* %t3558 to %SourceSpan**
  %t3560 = load %SourceSpan*, %SourceSpan** %t3559
  %t3561 = icmp eq i32 %t3533, 9
  %t3562 = select i1 %t3561, %SourceSpan* %t3560, %SourceSpan* %t3555
  %t3563 = getelementptr inbounds %Statement, %Statement* %t3534, i32 0, i32 1
  %t3564 = bitcast [40 x i8]* %t3563 to i8*
  %t3565 = getelementptr inbounds i8, i8* %t3564, i64 8
  %t3566 = bitcast i8* %t3565 to %SourceSpan**
  %t3567 = load %SourceSpan*, %SourceSpan** %t3566
  %t3568 = icmp eq i32 %t3533, 10
  %t3569 = select i1 %t3568, %SourceSpan* %t3567, %SourceSpan* %t3562
  %t3570 = getelementptr inbounds %Statement, %Statement* %t3534, i32 0, i32 1
  %t3571 = bitcast [40 x i8]* %t3570 to i8*
  %t3572 = getelementptr inbounds i8, i8* %t3571, i64 8
  %t3573 = bitcast i8* %t3572 to %SourceSpan**
  %t3574 = load %SourceSpan*, %SourceSpan** %t3573
  %t3575 = icmp eq i32 %t3533, 11
  %t3576 = select i1 %t3575, %SourceSpan* %t3574, %SourceSpan* %t3569
  %t3577 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t3530, i8* %t3531, %SourceSpan* %t3576)
  store %ScopeResult %t3577, %ScopeResult* %l25
  %t3578 = load %ScopeResult, %ScopeResult* %l25
  %t3579 = extractvalue %ScopeResult %t3578, 1
  %t3580 = extractvalue %Statement %statement, 0
  %t3581 = alloca %Statement
  store %Statement %statement, %Statement* %t3581
  %t3582 = getelementptr inbounds %Statement, %Statement* %t3581, i32 0, i32 1
  %t3583 = bitcast [56 x i8]* %t3582 to i8*
  %t3584 = getelementptr inbounds i8, i8* %t3583, i64 16
  %t3585 = bitcast i8* %t3584 to { %TypeParameter*, i64 }**
  %t3586 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t3585
  %t3587 = icmp eq i32 %t3580, 8
  %t3588 = select i1 %t3587, { %TypeParameter*, i64 }* %t3586, { %TypeParameter*, i64 }* null
  %t3589 = getelementptr inbounds %Statement, %Statement* %t3581, i32 0, i32 1
  %t3590 = bitcast [40 x i8]* %t3589 to i8*
  %t3591 = getelementptr inbounds i8, i8* %t3590, i64 16
  %t3592 = bitcast i8* %t3591 to { %TypeParameter*, i64 }**
  %t3593 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t3592
  %t3594 = icmp eq i32 %t3580, 9
  %t3595 = select i1 %t3594, { %TypeParameter*, i64 }* %t3593, { %TypeParameter*, i64 }* %t3588
  %t3596 = getelementptr inbounds %Statement, %Statement* %t3581, i32 0, i32 1
  %t3597 = bitcast [40 x i8]* %t3596 to i8*
  %t3598 = getelementptr inbounds i8, i8* %t3597, i64 16
  %t3599 = bitcast i8* %t3598 to { %TypeParameter*, i64 }**
  %t3600 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t3599
  %t3601 = icmp eq i32 %t3580, 10
  %t3602 = select i1 %t3601, { %TypeParameter*, i64 }* %t3600, { %TypeParameter*, i64 }* %t3595
  %t3603 = getelementptr inbounds %Statement, %Statement* %t3581, i32 0, i32 1
  %t3604 = bitcast [40 x i8]* %t3603 to i8*
  %t3605 = getelementptr inbounds i8, i8* %t3604, i64 16
  %t3606 = bitcast i8* %t3605 to { %TypeParameter*, i64 }**
  %t3607 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t3606
  %t3608 = icmp eq i32 %t3580, 11
  %t3609 = select i1 %t3608, { %TypeParameter*, i64 }* %t3607, { %TypeParameter*, i64 }* %t3602
  %t3610 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t3609)
  %t3611 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3579, i32 0, i32 0
  %t3612 = load %Diagnostic*, %Diagnostic** %t3611
  %t3613 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3579, i32 0, i32 1
  %t3614 = load i64, i64* %t3613
  %t3615 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3610, i32 0, i32 0
  %t3616 = load %Diagnostic*, %Diagnostic** %t3615
  %t3617 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3610, i32 0, i32 1
  %t3618 = load i64, i64* %t3617
  %t3619 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t3620 = ptrtoint %Diagnostic* %t3619 to i64
  %t3621 = add i64 %t3614, %t3618
  %t3622 = mul i64 %t3620, %t3621
  %t3623 = call noalias i8* @malloc(i64 %t3622)
  %t3624 = bitcast i8* %t3623 to %Diagnostic*
  %t3625 = bitcast %Diagnostic* %t3624 to i8*
  %t3626 = mul i64 %t3620, %t3614
  %t3627 = bitcast %Diagnostic* %t3612 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t3625, i8* %t3627, i64 %t3626)
  %t3628 = mul i64 %t3620, %t3618
  %t3629 = bitcast %Diagnostic* %t3616 to i8*
  %t3630 = getelementptr %Diagnostic, %Diagnostic* %t3624, i64 %t3614
  %t3631 = bitcast %Diagnostic* %t3630 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t3631, i8* %t3629, i64 %t3628)
  %t3632 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t3633 = ptrtoint { %Diagnostic*, i64 }* %t3632 to i64
  %t3634 = call i8* @malloc(i64 %t3633)
  %t3635 = bitcast i8* %t3634 to { %Diagnostic*, i64 }*
  %t3636 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3635, i32 0, i32 0
  store %Diagnostic* %t3624, %Diagnostic** %t3636
  %t3637 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3635, i32 0, i32 1
  store i64 %t3621, i64* %t3637
  store { %Diagnostic*, i64 }* %t3635, { %Diagnostic*, i64 }** %l26
  %t3638 = load %ScopeResult, %ScopeResult* %l25
  %t3639 = extractvalue %ScopeResult %t3638, 0
  %t3640 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t3639, 0
  %t3641 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l26
  %t3642 = insertvalue %ScopeResult %t3640, { %Diagnostic*, i64 }* %t3641, 1
  ret %ScopeResult %t3642
merge49:
  %t3643 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %bindings, 0
  %t3644 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t3645 = ptrtoint [0 x %Diagnostic]* %t3644 to i64
  %t3646 = icmp eq i64 %t3645, 0
  %t3647 = select i1 %t3646, i64 1, i64 %t3645
  %t3648 = call i8* @malloc(i64 %t3647)
  %t3649 = bitcast i8* %t3648 to %Diagnostic*
  %t3650 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t3651 = ptrtoint { %Diagnostic*, i64 }* %t3650 to i64
  %t3652 = call i8* @malloc(i64 %t3651)
  %t3653 = bitcast i8* %t3652 to { %Diagnostic*, i64 }*
  %t3654 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3653, i32 0, i32 0
  store %Diagnostic* %t3649, %Diagnostic** %t3654
  %t3655 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3653, i32 0, i32 1
  store i64 0, i64* %t3655
  %t3656 = insertvalue %ScopeResult %t3643, { %Diagnostic*, i64 }* %t3653, 1
  ret %ScopeResult %t3656
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
  %t256 = call i1 @contains_string__typecheck({ i8**, i64 }* %t253, i8* %t255)
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
  %t73 = call i1 @starts_with__typecheck(i8* %t71, i8* %t72)
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
  %t37 = call i1 @contains_string__typecheck({ i8**, i64 }* %t35, i8* %t36)
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
  %t45 = call i8* @trim_text__typecheck(i8* %t44)
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
  %t189 = call i8* @trim_text__typecheck(i8* %t188)
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
  %t171 = call i8* @join_with_separator__typecheck({ i8**, i64 }* %t168, i8* %t169)
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

define i8* @join_with_separator__typecheck({ i8**, i64 }* %items, i8* %separator) {
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
  %t0 = call i8* @trim_text__typecheck(i8* %annotation_text)
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
  %t77 = call i8* @slice_text__typecheck(i8* %t74, double %t75, double %t76)
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
  %t95 = call i8* @trim_text__typecheck(i8* %t94)
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
  %t184 = call i8* @trim_text__typecheck(i8* %t183)
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

define i8* @trim_text__typecheck(i8* %value) {
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
  %t18 = call i1 @is_whitespace__typecheck(i8* %t16)
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
  %t44 = call i1 @is_whitespace__typecheck(i8* %t42)
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
  %t55 = call i8* @slice_text__typecheck(i8* %value, double %t53, double %t54)
  call void @sailfin_runtime_mark_persistent(i8* %t55)
  ret i8* %t55
}

define i8* @slice_text__typecheck(i8* %value, double %start, double %end) {
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

define i1 @is_whitespace__typecheck(i8* %ch) {
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
  %t69 = call i1 @contains_string__typecheck({ i8**, i64 }* %t67, i8* %t68)
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
  %t37 = call i1 @contains_string__typecheck({ i8**, i64 }* %t35, i8* %t36)
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
  %t67 = call i1 @contains_string__typecheck({ i8**, i64 }* %t65, i8* %t66)
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
  %t37 = call i1 @contains_string__typecheck({ i8**, i64 }* %t35, i8* %t36)
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
  %t37 = call i1 @contains_string__typecheck({ i8**, i64 }* %t35, i8* %t36)
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

define i1 @contains_string__typecheck({ i8**, i64 }* %items, i8* %candidate) {
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

define i1 @starts_with__typecheck(i8* %value, i8* %prefix) {
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

define double @add__typecheck(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}