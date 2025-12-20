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
  %s94 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h666604742, i32 0, i32 0
  %t95 = call i1 @strings_equal(i8* %t93, i8* %s94)
  %t96 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  %t97 = load %Statement, %Statement* %l2
  br i1 %t95, label %then4, label %merge5
then4:
  %t98 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  %t99 = load %Statement, %Statement* %l2
  %t100 = getelementptr [1 x %Statement], [1 x %Statement]* null, i32 1
  %t101 = ptrtoint [1 x %Statement]* %t100 to i64
  %t102 = icmp eq i64 %t101, 0
  %t103 = select i1 %t102, i64 1, i64 %t101
  %t104 = call i8* @malloc(i64 %t103)
  %t105 = bitcast i8* %t104 to %Statement*
  %t106 = getelementptr %Statement, %Statement* %t105, i64 0
  store %Statement %t99, %Statement* %t106
  %t107 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* null, i32 1
  %t108 = ptrtoint { %Statement*, i64 }* %t107 to i64
  %t109 = call i8* @malloc(i64 %t108)
  %t110 = bitcast i8* %t109 to { %Statement*, i64 }*
  %t111 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t110, i32 0, i32 0
  store %Statement* %t105, %Statement** %t111
  %t112 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t110, i32 0, i32 1
  store i64 1, i64* %t112
  %t113 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t98, i32 0, i32 0
  %t114 = load %Statement*, %Statement** %t113
  %t115 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t98, i32 0, i32 1
  %t116 = load i64, i64* %t115
  %t117 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t110, i32 0, i32 0
  %t118 = load %Statement*, %Statement** %t117
  %t119 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t110, i32 0, i32 1
  %t120 = load i64, i64* %t119
  %t121 = getelementptr [1 x %Statement], [1 x %Statement]* null, i32 0, i32 1
  %t122 = ptrtoint %Statement* %t121 to i64
  %t123 = add i64 %t116, %t120
  %t124 = mul i64 %t122, %t123
  %t125 = call noalias i8* @malloc(i64 %t124)
  %t126 = bitcast i8* %t125 to %Statement*
  %t127 = bitcast %Statement* %t126 to i8*
  %t128 = mul i64 %t122, %t116
  %t129 = bitcast %Statement* %t114 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t127, i8* %t129, i64 %t128)
  %t130 = mul i64 %t122, %t120
  %t131 = bitcast %Statement* %t118 to i8*
  %t132 = getelementptr %Statement, %Statement* %t126, i64 %t116
  %t133 = bitcast %Statement* %t132 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t133, i8* %t131, i64 %t130)
  %t134 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* null, i32 1
  %t135 = ptrtoint { %Statement*, i64 }* %t134 to i64
  %t136 = call i8* @malloc(i64 %t135)
  %t137 = bitcast i8* %t136 to { %Statement*, i64 }*
  %t138 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t137, i32 0, i32 0
  store %Statement* %t126, %Statement** %t138
  %t139 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t137, i32 0, i32 1
  store i64 %t123, i64* %t139
  store { %Statement*, i64 }* %t137, { %Statement*, i64 }** %l0
  %t140 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  br label %merge5
merge5:
  %t141 = phi { %Statement*, i64 }* [ %t140, %then4 ], [ %t96, %forbody1 ]
  store { %Statement*, i64 }* %t141, { %Statement*, i64 }** %l0
  br label %forinc2
forinc2:
  %t142 = load i64, i64* %l1
  %t143 = add i64 %t142, 1
  store i64 %t143, i64* %l1
  br label %for0
afterfor3:
  %t144 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  %t145 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  ret { %Statement*, i64 }* %t145
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
  %s71 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h486335986, i32 0, i32 0
  %t72 = call i1 @strings_equal(i8* %t70, i8* %s71)
  br i1 %t72, label %then0, label %merge1
then0:
  %t73 = extractvalue %Statement %statement, 0
  %t74 = alloca %Statement
  store %Statement %statement, %Statement* %t74
  %t75 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t76 = bitcast [88 x i8]* %t75 to i8*
  %t77 = bitcast i8* %t76 to %FunctionSignature*
  %t78 = load %FunctionSignature, %FunctionSignature* %t77
  %t79 = icmp eq i32 %t73, 4
  %t80 = select i1 %t79, %FunctionSignature %t78, %FunctionSignature zeroinitializer
  %t81 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t82 = bitcast [88 x i8]* %t81 to i8*
  %t83 = bitcast i8* %t82 to %FunctionSignature*
  %t84 = load %FunctionSignature, %FunctionSignature* %t83
  %t85 = icmp eq i32 %t73, 5
  %t86 = select i1 %t85, %FunctionSignature %t84, %FunctionSignature %t80
  %t87 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t88 = bitcast [88 x i8]* %t87 to i8*
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
  %t98 = bitcast [88 x i8]* %t97 to i8*
  %t99 = bitcast i8* %t98 to %FunctionSignature*
  %t100 = load %FunctionSignature, %FunctionSignature* %t99
  %t101 = icmp eq i32 %t95, 4
  %t102 = select i1 %t101, %FunctionSignature %t100, %FunctionSignature zeroinitializer
  %t103 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t104 = bitcast [88 x i8]* %t103 to i8*
  %t105 = bitcast i8* %t104 to %FunctionSignature*
  %t106 = load %FunctionSignature, %FunctionSignature* %t105
  %t107 = icmp eq i32 %t95, 5
  %t108 = select i1 %t107, %FunctionSignature %t106, %FunctionSignature %t102
  %t109 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t110 = bitcast [88 x i8]* %t109 to i8*
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
  %t189 = call i1 @strings_equal(i8* %t187, i8* %s188)
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
  %t205 = bitcast [56 x i8]* %t204 to i8*
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
  %t245 = bitcast [56 x i8]* %t244 to i8*
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
  %t352 = call i1 @strings_equal(i8* %t350, i8* %s351)
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
  %t368 = bitcast [56 x i8]* %t367 to i8*
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
  %t408 = bitcast [56 x i8]* %t407 to i8*
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
  %t515 = call i1 @strings_equal(i8* %t513, i8* %s514)
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
  %t531 = bitcast [56 x i8]* %t530 to i8*
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
  %t571 = bitcast [56 x i8]* %t570 to i8*
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
  %t678 = call i1 @strings_equal(i8* %t676, i8* %s677)
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
  %t694 = bitcast [56 x i8]* %t693 to i8*
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
  %t734 = bitcast [56 x i8]* %t733 to i8*
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
  %t841 = call i1 @strings_equal(i8* %t839, i8* %s840)
  br i1 %t841, label %then10, label %merge11
then10:
  %t842 = extractvalue %Statement %statement, 0
  %t843 = alloca %Statement
  store %Statement %statement, %Statement* %t843
  %t844 = getelementptr inbounds %Statement, %Statement* %t843, i32 0, i32 1
  %t845 = bitcast [88 x i8]* %t844 to i8*
  %t846 = bitcast i8* %t845 to %FunctionSignature*
  %t847 = load %FunctionSignature, %FunctionSignature* %t846
  %t848 = icmp eq i32 %t842, 4
  %t849 = select i1 %t848, %FunctionSignature %t847, %FunctionSignature zeroinitializer
  %t850 = getelementptr inbounds %Statement, %Statement* %t843, i32 0, i32 1
  %t851 = bitcast [88 x i8]* %t850 to i8*
  %t852 = bitcast i8* %t851 to %FunctionSignature*
  %t853 = load %FunctionSignature, %FunctionSignature* %t852
  %t854 = icmp eq i32 %t842, 5
  %t855 = select i1 %t854, %FunctionSignature %t853, %FunctionSignature %t849
  %t856 = getelementptr inbounds %Statement, %Statement* %t843, i32 0, i32 1
  %t857 = bitcast [88 x i8]* %t856 to i8*
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
  %t867 = bitcast [88 x i8]* %t866 to i8*
  %t868 = bitcast i8* %t867 to %FunctionSignature*
  %t869 = load %FunctionSignature, %FunctionSignature* %t868
  %t870 = icmp eq i32 %t864, 4
  %t871 = select i1 %t870, %FunctionSignature %t869, %FunctionSignature zeroinitializer
  %t872 = getelementptr inbounds %Statement, %Statement* %t865, i32 0, i32 1
  %t873 = bitcast [88 x i8]* %t872 to i8*
  %t874 = bitcast i8* %t873 to %FunctionSignature*
  %t875 = load %FunctionSignature, %FunctionSignature* %t874
  %t876 = icmp eq i32 %t864, 5
  %t877 = select i1 %t876, %FunctionSignature %t875, %FunctionSignature %t871
  %t878 = getelementptr inbounds %Statement, %Statement* %t865, i32 0, i32 1
  %t879 = bitcast [88 x i8]* %t878 to i8*
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
  %t958 = call i1 @strings_equal(i8* %t956, i8* %s957)
  br i1 %t958, label %then12, label %merge13
then12:
  %t959 = extractvalue %Statement %statement, 0
  %t960 = alloca %Statement
  store %Statement %statement, %Statement* %t960
  %t961 = getelementptr inbounds %Statement, %Statement* %t960, i32 0, i32 1
  %t962 = bitcast [88 x i8]* %t961 to i8*
  %t963 = bitcast i8* %t962 to %FunctionSignature*
  %t964 = load %FunctionSignature, %FunctionSignature* %t963
  %t965 = icmp eq i32 %t959, 4
  %t966 = select i1 %t965, %FunctionSignature %t964, %FunctionSignature zeroinitializer
  %t967 = getelementptr inbounds %Statement, %Statement* %t960, i32 0, i32 1
  %t968 = bitcast [88 x i8]* %t967 to i8*
  %t969 = bitcast i8* %t968 to %FunctionSignature*
  %t970 = load %FunctionSignature, %FunctionSignature* %t969
  %t971 = icmp eq i32 %t959, 5
  %t972 = select i1 %t971, %FunctionSignature %t970, %FunctionSignature %t966
  %t973 = getelementptr inbounds %Statement, %Statement* %t960, i32 0, i32 1
  %t974 = bitcast [88 x i8]* %t973 to i8*
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
  %t984 = bitcast [88 x i8]* %t983 to i8*
  %t985 = bitcast i8* %t984 to %FunctionSignature*
  %t986 = load %FunctionSignature, %FunctionSignature* %t985
  %t987 = icmp eq i32 %t981, 4
  %t988 = select i1 %t987, %FunctionSignature %t986, %FunctionSignature zeroinitializer
  %t989 = getelementptr inbounds %Statement, %Statement* %t982, i32 0, i32 1
  %t990 = bitcast [88 x i8]* %t989 to i8*
  %t991 = bitcast i8* %t990 to %FunctionSignature*
  %t992 = load %FunctionSignature, %FunctionSignature* %t991
  %t993 = icmp eq i32 %t981, 5
  %t994 = select i1 %t993, %FunctionSignature %t992, %FunctionSignature %t988
  %t995 = getelementptr inbounds %Statement, %Statement* %t982, i32 0, i32 1
  %t996 = bitcast [88 x i8]* %t995 to i8*
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
  %t1075 = call i1 @strings_equal(i8* %t1073, i8* %s1074)
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
  %t1091 = bitcast [56 x i8]* %t1090 to i8*
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
  %t1131 = bitcast [56 x i8]* %t1130 to i8*
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
  %t1238 = call i1 @strings_equal(i8* %t1236, i8* %s1237)
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
  %t1254 = bitcast [56 x i8]* %t1253 to i8*
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
  %t1294 = bitcast [56 x i8]* %t1293 to i8*
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
  %t1401 = call i1 @strings_equal(i8* %t1399, i8* %s1400)
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
  %t1417 = bitcast [56 x i8]* %t1416 to i8*
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
  %t1464 = bitcast [56 x i8]* %t1463 to i8*
  %t1465 = getelementptr inbounds i8, i8* %t1464, i64 48
  %t1466 = bitcast i8* %t1465 to %SourceSpan**
  %t1467 = load %SourceSpan*, %SourceSpan** %t1466
  %t1468 = icmp eq i32 %t1447, 21
  %t1469 = select i1 %t1468, %SourceSpan* %t1467, %SourceSpan* %t1462
  %t1470 = call %SymbolCollectionResult @register_symbol(i8* %t1445, i8* %s1446, %SourceSpan* %t1469, { %SymbolEntry*, i64 }* %existing)
  ret %SymbolCollectionResult %t1470
merge19:
  %t1471 = insertvalue %SymbolCollectionResult undef, { %SymbolEntry*, i64 }* %existing, 0
  %t1472 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t1473 = ptrtoint [0 x %Diagnostic]* %t1472 to i64
  %t1474 = icmp eq i64 %t1473, 0
  %t1475 = select i1 %t1474, i64 1, i64 %t1473
  %t1476 = call i8* @malloc(i64 %t1475)
  %t1477 = bitcast i8* %t1476 to %Diagnostic*
  %t1478 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1479 = ptrtoint { %Diagnostic*, i64 }* %t1478 to i64
  %t1480 = call i8* @malloc(i64 %t1479)
  %t1481 = bitcast i8* %t1480 to { %Diagnostic*, i64 }*
  %t1482 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1481, i32 0, i32 0
  store %Diagnostic* %t1477, %Diagnostic** %t1482
  %t1483 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1481, i32 0, i32 1
  store i64 0, i64* %t1483
  %t1484 = insertvalue %SymbolCollectionResult %t1471, { %Diagnostic*, i64 }* %t1481, 1
  ret %SymbolCollectionResult %t1484
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
  %s71 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1204027478, i32 0, i32 0
  %t72 = call i1 @strings_equal(i8* %t70, i8* %s71)
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
  %t88 = bitcast [56 x i8]* %t87 to i8*
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
  %t135 = bitcast [56 x i8]* %t134 to i8*
  %t136 = getelementptr inbounds i8, i8* %t135, i64 48
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
  %t214 = call i1 @strings_equal(i8* %t212, i8* %s213)
  br i1 %t214, label %then2, label %merge3
then2:
  %t215 = extractvalue %Statement %statement, 0
  %t216 = alloca %Statement
  store %Statement %statement, %Statement* %t216
  %t217 = getelementptr inbounds %Statement, %Statement* %t216, i32 0, i32 1
  %t218 = bitcast [88 x i8]* %t217 to i8*
  %t219 = bitcast i8* %t218 to %FunctionSignature*
  %t220 = load %FunctionSignature, %FunctionSignature* %t219
  %t221 = icmp eq i32 %t215, 4
  %t222 = select i1 %t221, %FunctionSignature %t220, %FunctionSignature zeroinitializer
  %t223 = getelementptr inbounds %Statement, %Statement* %t216, i32 0, i32 1
  %t224 = bitcast [88 x i8]* %t223 to i8*
  %t225 = bitcast i8* %t224 to %FunctionSignature*
  %t226 = load %FunctionSignature, %FunctionSignature* %t225
  %t227 = icmp eq i32 %t215, 5
  %t228 = select i1 %t227, %FunctionSignature %t226, %FunctionSignature %t222
  %t229 = getelementptr inbounds %Statement, %Statement* %t216, i32 0, i32 1
  %t230 = bitcast [88 x i8]* %t229 to i8*
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
  %t240 = bitcast [88 x i8]* %t239 to i8*
  %t241 = bitcast i8* %t240 to %FunctionSignature*
  %t242 = load %FunctionSignature, %FunctionSignature* %t241
  %t243 = icmp eq i32 %t237, 4
  %t244 = select i1 %t243, %FunctionSignature %t242, %FunctionSignature zeroinitializer
  %t245 = getelementptr inbounds %Statement, %Statement* %t238, i32 0, i32 1
  %t246 = bitcast [88 x i8]* %t245 to i8*
  %t247 = bitcast i8* %t246 to %FunctionSignature*
  %t248 = load %FunctionSignature, %FunctionSignature* %t247
  %t249 = icmp eq i32 %t237, 5
  %t250 = select i1 %t249, %FunctionSignature %t248, %FunctionSignature %t244
  %t251 = getelementptr inbounds %Statement, %Statement* %t238, i32 0, i32 1
  %t252 = bitcast [88 x i8]* %t251 to i8*
  %t253 = bitcast i8* %t252 to %FunctionSignature*
  %t254 = load %FunctionSignature, %FunctionSignature* %t253
  %t255 = icmp eq i32 %t237, 7
  %t256 = select i1 %t255, %FunctionSignature %t254, %FunctionSignature %t250
  %t257 = extractvalue %FunctionSignature %t256, 6
  %t258 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t235, i8* %s236, %SourceSpan* %t257)
  store %ScopeResult %t258, %ScopeResult* %l0
  %t259 = load %ScopeResult, %ScopeResult* %l0
  %t260 = extractvalue %ScopeResult %t259, 1
  store { %Diagnostic*, i64 }* %t260, { %Diagnostic*, i64 }** %l1
  %t261 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t262 = extractvalue %Statement %statement, 0
  %t263 = alloca %Statement
  store %Statement %statement, %Statement* %t263
  %t264 = getelementptr inbounds %Statement, %Statement* %t263, i32 0, i32 1
  %t265 = bitcast [88 x i8]* %t264 to i8*
  %t266 = bitcast i8* %t265 to %FunctionSignature*
  %t267 = load %FunctionSignature, %FunctionSignature* %t266
  %t268 = icmp eq i32 %t262, 4
  %t269 = select i1 %t268, %FunctionSignature %t267, %FunctionSignature zeroinitializer
  %t270 = getelementptr inbounds %Statement, %Statement* %t263, i32 0, i32 1
  %t271 = bitcast [88 x i8]* %t270 to i8*
  %t272 = bitcast i8* %t271 to %FunctionSignature*
  %t273 = load %FunctionSignature, %FunctionSignature* %t272
  %t274 = icmp eq i32 %t262, 5
  %t275 = select i1 %t274, %FunctionSignature %t273, %FunctionSignature %t269
  %t276 = getelementptr inbounds %Statement, %Statement* %t263, i32 0, i32 1
  %t277 = bitcast [88 x i8]* %t276 to i8*
  %t278 = bitcast i8* %t277 to %FunctionSignature*
  %t279 = load %FunctionSignature, %FunctionSignature* %t278
  %t280 = icmp eq i32 %t262, 7
  %t281 = select i1 %t280, %FunctionSignature %t279, %FunctionSignature %t275
  %t282 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t281)
  %t283 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t261, i32 0, i32 0
  %t284 = load %Diagnostic*, %Diagnostic** %t283
  %t285 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t261, i32 0, i32 1
  %t286 = load i64, i64* %t285
  %t287 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t282, i32 0, i32 0
  %t288 = load %Diagnostic*, %Diagnostic** %t287
  %t289 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t282, i32 0, i32 1
  %t290 = load i64, i64* %t289
  %t291 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t292 = ptrtoint %Diagnostic* %t291 to i64
  %t293 = add i64 %t286, %t290
  %t294 = mul i64 %t292, %t293
  %t295 = call noalias i8* @malloc(i64 %t294)
  %t296 = bitcast i8* %t295 to %Diagnostic*
  %t297 = bitcast %Diagnostic* %t296 to i8*
  %t298 = mul i64 %t292, %t286
  %t299 = bitcast %Diagnostic* %t284 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t297, i8* %t299, i64 %t298)
  %t300 = mul i64 %t292, %t290
  %t301 = bitcast %Diagnostic* %t288 to i8*
  %t302 = getelementptr %Diagnostic, %Diagnostic* %t296, i64 %t286
  %t303 = bitcast %Diagnostic* %t302 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t303, i8* %t301, i64 %t300)
  %t304 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t305 = ptrtoint { %Diagnostic*, i64 }* %t304 to i64
  %t306 = call i8* @malloc(i64 %t305)
  %t307 = bitcast i8* %t306 to { %Diagnostic*, i64 }*
  %t308 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t307, i32 0, i32 0
  store %Diagnostic* %t296, %Diagnostic** %t308
  %t309 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t307, i32 0, i32 1
  store i64 %t293, i64* %t309
  store { %Diagnostic*, i64 }* %t307, { %Diagnostic*, i64 }** %l1
  %t310 = extractvalue %Statement %statement, 0
  %t311 = alloca %Statement
  store %Statement %statement, %Statement* %t311
  %t312 = getelementptr inbounds %Statement, %Statement* %t311, i32 0, i32 1
  %t313 = bitcast [88 x i8]* %t312 to i8*
  %t314 = bitcast i8* %t313 to %FunctionSignature*
  %t315 = load %FunctionSignature, %FunctionSignature* %t314
  %t316 = icmp eq i32 %t310, 4
  %t317 = select i1 %t316, %FunctionSignature %t315, %FunctionSignature zeroinitializer
  %t318 = getelementptr inbounds %Statement, %Statement* %t311, i32 0, i32 1
  %t319 = bitcast [88 x i8]* %t318 to i8*
  %t320 = bitcast i8* %t319 to %FunctionSignature*
  %t321 = load %FunctionSignature, %FunctionSignature* %t320
  %t322 = icmp eq i32 %t310, 5
  %t323 = select i1 %t322, %FunctionSignature %t321, %FunctionSignature %t317
  %t324 = getelementptr inbounds %Statement, %Statement* %t311, i32 0, i32 1
  %t325 = bitcast [88 x i8]* %t324 to i8*
  %t326 = bitcast i8* %t325 to %FunctionSignature*
  %t327 = load %FunctionSignature, %FunctionSignature* %t326
  %t328 = icmp eq i32 %t310, 7
  %t329 = select i1 %t328, %FunctionSignature %t327, %FunctionSignature %t323
  %t330 = extractvalue %Statement %statement, 0
  %t331 = alloca %Statement
  store %Statement %statement, %Statement* %t331
  %t332 = getelementptr inbounds %Statement, %Statement* %t331, i32 0, i32 1
  %t333 = bitcast [88 x i8]* %t332 to i8*
  %t334 = getelementptr inbounds i8, i8* %t333, i64 56
  %t335 = bitcast i8* %t334 to %Block*
  %t336 = load %Block, %Block* %t335
  %t337 = icmp eq i32 %t330, 4
  %t338 = select i1 %t337, %Block %t336, %Block zeroinitializer
  %t339 = getelementptr inbounds %Statement, %Statement* %t331, i32 0, i32 1
  %t340 = bitcast [88 x i8]* %t339 to i8*
  %t341 = getelementptr inbounds i8, i8* %t340, i64 56
  %t342 = bitcast i8* %t341 to %Block*
  %t343 = load %Block, %Block* %t342
  %t344 = icmp eq i32 %t330, 5
  %t345 = select i1 %t344, %Block %t343, %Block %t338
  %t346 = getelementptr inbounds %Statement, %Statement* %t331, i32 0, i32 1
  %t347 = bitcast [56 x i8]* %t346 to i8*
  %t348 = getelementptr inbounds i8, i8* %t347, i64 16
  %t349 = bitcast i8* %t348 to %Block*
  %t350 = load %Block, %Block* %t349
  %t351 = icmp eq i32 %t330, 6
  %t352 = select i1 %t351, %Block %t350, %Block %t345
  %t353 = getelementptr inbounds %Statement, %Statement* %t331, i32 0, i32 1
  %t354 = bitcast [88 x i8]* %t353 to i8*
  %t355 = getelementptr inbounds i8, i8* %t354, i64 56
  %t356 = bitcast i8* %t355 to %Block*
  %t357 = load %Block, %Block* %t356
  %t358 = icmp eq i32 %t330, 7
  %t359 = select i1 %t358, %Block %t357, %Block %t352
  %t360 = getelementptr inbounds %Statement, %Statement* %t331, i32 0, i32 1
  %t361 = bitcast [120 x i8]* %t360 to i8*
  %t362 = getelementptr inbounds i8, i8* %t361, i64 88
  %t363 = bitcast i8* %t362 to %Block*
  %t364 = load %Block, %Block* %t363
  %t365 = icmp eq i32 %t330, 12
  %t366 = select i1 %t365, %Block %t364, %Block %t359
  %t367 = getelementptr inbounds %Statement, %Statement* %t331, i32 0, i32 1
  %t368 = bitcast [40 x i8]* %t367 to i8*
  %t369 = getelementptr inbounds i8, i8* %t368, i64 8
  %t370 = bitcast i8* %t369 to %Block*
  %t371 = load %Block, %Block* %t370
  %t372 = icmp eq i32 %t330, 13
  %t373 = select i1 %t372, %Block %t371, %Block %t366
  %t374 = getelementptr inbounds %Statement, %Statement* %t331, i32 0, i32 1
  %t375 = bitcast [136 x i8]* %t374 to i8*
  %t376 = getelementptr inbounds i8, i8* %t375, i64 104
  %t377 = bitcast i8* %t376 to %Block*
  %t378 = load %Block, %Block* %t377
  %t379 = icmp eq i32 %t330, 14
  %t380 = select i1 %t379, %Block %t378, %Block %t373
  %t381 = getelementptr inbounds %Statement, %Statement* %t331, i32 0, i32 1
  %t382 = bitcast [32 x i8]* %t381 to i8*
  %t383 = bitcast i8* %t382 to %Block*
  %t384 = load %Block, %Block* %t383
  %t385 = icmp eq i32 %t330, 15
  %t386 = select i1 %t385, %Block %t384, %Block %t380
  %t387 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t329, %Block %t386, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t387, { %Diagnostic*, i64 }** %l2
  %t388 = load %ScopeResult, %ScopeResult* %l0
  %t389 = extractvalue %ScopeResult %t388, 0
  %t390 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t389, 0
  %t391 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t392 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l2
  %t393 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t391, i32 0, i32 0
  %t394 = load %Diagnostic*, %Diagnostic** %t393
  %t395 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t391, i32 0, i32 1
  %t396 = load i64, i64* %t395
  %t397 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t392, i32 0, i32 0
  %t398 = load %Diagnostic*, %Diagnostic** %t397
  %t399 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t392, i32 0, i32 1
  %t400 = load i64, i64* %t399
  %t401 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t402 = ptrtoint %Diagnostic* %t401 to i64
  %t403 = add i64 %t396, %t400
  %t404 = mul i64 %t402, %t403
  %t405 = call noalias i8* @malloc(i64 %t404)
  %t406 = bitcast i8* %t405 to %Diagnostic*
  %t407 = bitcast %Diagnostic* %t406 to i8*
  %t408 = mul i64 %t402, %t396
  %t409 = bitcast %Diagnostic* %t394 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t407, i8* %t409, i64 %t408)
  %t410 = mul i64 %t402, %t400
  %t411 = bitcast %Diagnostic* %t398 to i8*
  %t412 = getelementptr %Diagnostic, %Diagnostic* %t406, i64 %t396
  %t413 = bitcast %Diagnostic* %t412 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t413, i8* %t411, i64 %t410)
  %t414 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t415 = ptrtoint { %Diagnostic*, i64 }* %t414 to i64
  %t416 = call i8* @malloc(i64 %t415)
  %t417 = bitcast i8* %t416 to { %Diagnostic*, i64 }*
  %t418 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t417, i32 0, i32 0
  store %Diagnostic* %t406, %Diagnostic** %t418
  %t419 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t417, i32 0, i32 1
  store i64 %t403, i64* %t419
  %t420 = insertvalue %ScopeResult %t390, { %Diagnostic*, i64 }* %t417, 1
  ret %ScopeResult %t420
merge3:
  %t421 = extractvalue %Statement %statement, 0
  %t422 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t423 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t424 = icmp eq i32 %t421, 0
  %t425 = select i1 %t424, i8* %t423, i8* %t422
  %t426 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t427 = icmp eq i32 %t421, 1
  %t428 = select i1 %t427, i8* %t426, i8* %t425
  %t429 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t430 = icmp eq i32 %t421, 2
  %t431 = select i1 %t430, i8* %t429, i8* %t428
  %t432 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t433 = icmp eq i32 %t421, 3
  %t434 = select i1 %t433, i8* %t432, i8* %t431
  %t435 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t436 = icmp eq i32 %t421, 4
  %t437 = select i1 %t436, i8* %t435, i8* %t434
  %t438 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t439 = icmp eq i32 %t421, 5
  %t440 = select i1 %t439, i8* %t438, i8* %t437
  %t441 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t442 = icmp eq i32 %t421, 6
  %t443 = select i1 %t442, i8* %t441, i8* %t440
  %t444 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t445 = icmp eq i32 %t421, 7
  %t446 = select i1 %t445, i8* %t444, i8* %t443
  %t447 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t448 = icmp eq i32 %t421, 8
  %t449 = select i1 %t448, i8* %t447, i8* %t446
  %t450 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t451 = icmp eq i32 %t421, 9
  %t452 = select i1 %t451, i8* %t450, i8* %t449
  %t453 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t454 = icmp eq i32 %t421, 10
  %t455 = select i1 %t454, i8* %t453, i8* %t452
  %t456 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t457 = icmp eq i32 %t421, 11
  %t458 = select i1 %t457, i8* %t456, i8* %t455
  %t459 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t460 = icmp eq i32 %t421, 12
  %t461 = select i1 %t460, i8* %t459, i8* %t458
  %t462 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t463 = icmp eq i32 %t421, 13
  %t464 = select i1 %t463, i8* %t462, i8* %t461
  %t465 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t466 = icmp eq i32 %t421, 14
  %t467 = select i1 %t466, i8* %t465, i8* %t464
  %t468 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t469 = icmp eq i32 %t421, 15
  %t470 = select i1 %t469, i8* %t468, i8* %t467
  %t471 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t472 = icmp eq i32 %t421, 16
  %t473 = select i1 %t472, i8* %t471, i8* %t470
  %t474 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t475 = icmp eq i32 %t421, 17
  %t476 = select i1 %t475, i8* %t474, i8* %t473
  %t477 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t478 = icmp eq i32 %t421, 18
  %t479 = select i1 %t478, i8* %t477, i8* %t476
  %t480 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t481 = icmp eq i32 %t421, 19
  %t482 = select i1 %t481, i8* %t480, i8* %t479
  %t483 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t484 = icmp eq i32 %t421, 20
  %t485 = select i1 %t484, i8* %t483, i8* %t482
  %t486 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t487 = icmp eq i32 %t421, 21
  %t488 = select i1 %t487, i8* %t486, i8* %t485
  %t489 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t490 = icmp eq i32 %t421, 22
  %t491 = select i1 %t490, i8* %t489, i8* %t488
  %s492 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1842783069, i32 0, i32 0
  %t493 = call i1 @strings_equal(i8* %t491, i8* %s492)
  br i1 %t493, label %then4, label %merge5
then4:
  %t494 = extractvalue %Statement %statement, 0
  %t495 = alloca %Statement
  store %Statement %statement, %Statement* %t495
  %t496 = getelementptr inbounds %Statement, %Statement* %t495, i32 0, i32 1
  %t497 = bitcast [48 x i8]* %t496 to i8*
  %t498 = bitcast i8* %t497 to i8**
  %t499 = load i8*, i8** %t498
  %t500 = icmp eq i32 %t494, 2
  %t501 = select i1 %t500, i8* %t499, i8* null
  %t502 = getelementptr inbounds %Statement, %Statement* %t495, i32 0, i32 1
  %t503 = bitcast [48 x i8]* %t502 to i8*
  %t504 = bitcast i8* %t503 to i8**
  %t505 = load i8*, i8** %t504
  %t506 = icmp eq i32 %t494, 3
  %t507 = select i1 %t506, i8* %t505, i8* %t501
  %t508 = getelementptr inbounds %Statement, %Statement* %t495, i32 0, i32 1
  %t509 = bitcast [56 x i8]* %t508 to i8*
  %t510 = bitcast i8* %t509 to i8**
  %t511 = load i8*, i8** %t510
  %t512 = icmp eq i32 %t494, 6
  %t513 = select i1 %t512, i8* %t511, i8* %t507
  %t514 = getelementptr inbounds %Statement, %Statement* %t495, i32 0, i32 1
  %t515 = bitcast [56 x i8]* %t514 to i8*
  %t516 = bitcast i8* %t515 to i8**
  %t517 = load i8*, i8** %t516
  %t518 = icmp eq i32 %t494, 8
  %t519 = select i1 %t518, i8* %t517, i8* %t513
  %t520 = getelementptr inbounds %Statement, %Statement* %t495, i32 0, i32 1
  %t521 = bitcast [40 x i8]* %t520 to i8*
  %t522 = bitcast i8* %t521 to i8**
  %t523 = load i8*, i8** %t522
  %t524 = icmp eq i32 %t494, 9
  %t525 = select i1 %t524, i8* %t523, i8* %t519
  %t526 = getelementptr inbounds %Statement, %Statement* %t495, i32 0, i32 1
  %t527 = bitcast [40 x i8]* %t526 to i8*
  %t528 = bitcast i8* %t527 to i8**
  %t529 = load i8*, i8** %t528
  %t530 = icmp eq i32 %t494, 10
  %t531 = select i1 %t530, i8* %t529, i8* %t525
  %t532 = getelementptr inbounds %Statement, %Statement* %t495, i32 0, i32 1
  %t533 = bitcast [40 x i8]* %t532 to i8*
  %t534 = bitcast i8* %t533 to i8**
  %t535 = load i8*, i8** %t534
  %t536 = icmp eq i32 %t494, 11
  %t537 = select i1 %t536, i8* %t535, i8* %t531
  %s538 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h789690461, i32 0, i32 0
  %t539 = extractvalue %Statement %statement, 0
  %t540 = alloca %Statement
  store %Statement %statement, %Statement* %t540
  %t541 = getelementptr inbounds %Statement, %Statement* %t540, i32 0, i32 1
  %t542 = bitcast [48 x i8]* %t541 to i8*
  %t543 = getelementptr inbounds i8, i8* %t542, i64 8
  %t544 = bitcast i8* %t543 to %SourceSpan**
  %t545 = load %SourceSpan*, %SourceSpan** %t544
  %t546 = icmp eq i32 %t539, 3
  %t547 = select i1 %t546, %SourceSpan* %t545, %SourceSpan* null
  %t548 = getelementptr inbounds %Statement, %Statement* %t540, i32 0, i32 1
  %t549 = bitcast [56 x i8]* %t548 to i8*
  %t550 = getelementptr inbounds i8, i8* %t549, i64 8
  %t551 = bitcast i8* %t550 to %SourceSpan**
  %t552 = load %SourceSpan*, %SourceSpan** %t551
  %t553 = icmp eq i32 %t539, 6
  %t554 = select i1 %t553, %SourceSpan* %t552, %SourceSpan* %t547
  %t555 = getelementptr inbounds %Statement, %Statement* %t540, i32 0, i32 1
  %t556 = bitcast [56 x i8]* %t555 to i8*
  %t557 = getelementptr inbounds i8, i8* %t556, i64 8
  %t558 = bitcast i8* %t557 to %SourceSpan**
  %t559 = load %SourceSpan*, %SourceSpan** %t558
  %t560 = icmp eq i32 %t539, 8
  %t561 = select i1 %t560, %SourceSpan* %t559, %SourceSpan* %t554
  %t562 = getelementptr inbounds %Statement, %Statement* %t540, i32 0, i32 1
  %t563 = bitcast [40 x i8]* %t562 to i8*
  %t564 = getelementptr inbounds i8, i8* %t563, i64 8
  %t565 = bitcast i8* %t564 to %SourceSpan**
  %t566 = load %SourceSpan*, %SourceSpan** %t565
  %t567 = icmp eq i32 %t539, 9
  %t568 = select i1 %t567, %SourceSpan* %t566, %SourceSpan* %t561
  %t569 = getelementptr inbounds %Statement, %Statement* %t540, i32 0, i32 1
  %t570 = bitcast [40 x i8]* %t569 to i8*
  %t571 = getelementptr inbounds i8, i8* %t570, i64 8
  %t572 = bitcast i8* %t571 to %SourceSpan**
  %t573 = load %SourceSpan*, %SourceSpan** %t572
  %t574 = icmp eq i32 %t539, 10
  %t575 = select i1 %t574, %SourceSpan* %t573, %SourceSpan* %t568
  %t576 = getelementptr inbounds %Statement, %Statement* %t540, i32 0, i32 1
  %t577 = bitcast [40 x i8]* %t576 to i8*
  %t578 = getelementptr inbounds i8, i8* %t577, i64 8
  %t579 = bitcast i8* %t578 to %SourceSpan**
  %t580 = load %SourceSpan*, %SourceSpan** %t579
  %t581 = icmp eq i32 %t539, 11
  %t582 = select i1 %t581, %SourceSpan* %t580, %SourceSpan* %t575
  %t583 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t537, i8* %s538, %SourceSpan* %t582)
  store %ScopeResult %t583, %ScopeResult* %l3
  %t584 = load %ScopeResult, %ScopeResult* %l3
  %t585 = extractvalue %ScopeResult %t584, 1
  store { %Diagnostic*, i64 }* %t585, { %Diagnostic*, i64 }** %l4
  %t586 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t587 = extractvalue %Statement %statement, 0
  %t588 = alloca %Statement
  store %Statement %statement, %Statement* %t588
  %t589 = getelementptr inbounds %Statement, %Statement* %t588, i32 0, i32 1
  %t590 = bitcast [56 x i8]* %t589 to i8*
  %t591 = getelementptr inbounds i8, i8* %t590, i64 16
  %t592 = bitcast i8* %t591 to { %TypeParameter*, i64 }**
  %t593 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t592
  %t594 = icmp eq i32 %t587, 8
  %t595 = select i1 %t594, { %TypeParameter*, i64 }* %t593, { %TypeParameter*, i64 }* null
  %t596 = getelementptr inbounds %Statement, %Statement* %t588, i32 0, i32 1
  %t597 = bitcast [40 x i8]* %t596 to i8*
  %t598 = getelementptr inbounds i8, i8* %t597, i64 16
  %t599 = bitcast i8* %t598 to { %TypeParameter*, i64 }**
  %t600 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t599
  %t601 = icmp eq i32 %t587, 9
  %t602 = select i1 %t601, { %TypeParameter*, i64 }* %t600, { %TypeParameter*, i64 }* %t595
  %t603 = getelementptr inbounds %Statement, %Statement* %t588, i32 0, i32 1
  %t604 = bitcast [40 x i8]* %t603 to i8*
  %t605 = getelementptr inbounds i8, i8* %t604, i64 16
  %t606 = bitcast i8* %t605 to { %TypeParameter*, i64 }**
  %t607 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t606
  %t608 = icmp eq i32 %t587, 10
  %t609 = select i1 %t608, { %TypeParameter*, i64 }* %t607, { %TypeParameter*, i64 }* %t602
  %t610 = getelementptr inbounds %Statement, %Statement* %t588, i32 0, i32 1
  %t611 = bitcast [40 x i8]* %t610 to i8*
  %t612 = getelementptr inbounds i8, i8* %t611, i64 16
  %t613 = bitcast i8* %t612 to { %TypeParameter*, i64 }**
  %t614 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t613
  %t615 = icmp eq i32 %t587, 11
  %t616 = select i1 %t615, { %TypeParameter*, i64 }* %t614, { %TypeParameter*, i64 }* %t609
  %t617 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t616)
  %t618 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t586, i32 0, i32 0
  %t619 = load %Diagnostic*, %Diagnostic** %t618
  %t620 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t586, i32 0, i32 1
  %t621 = load i64, i64* %t620
  %t622 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t617, i32 0, i32 0
  %t623 = load %Diagnostic*, %Diagnostic** %t622
  %t624 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t617, i32 0, i32 1
  %t625 = load i64, i64* %t624
  %t626 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t627 = ptrtoint %Diagnostic* %t626 to i64
  %t628 = add i64 %t621, %t625
  %t629 = mul i64 %t627, %t628
  %t630 = call noalias i8* @malloc(i64 %t629)
  %t631 = bitcast i8* %t630 to %Diagnostic*
  %t632 = bitcast %Diagnostic* %t631 to i8*
  %t633 = mul i64 %t627, %t621
  %t634 = bitcast %Diagnostic* %t619 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t632, i8* %t634, i64 %t633)
  %t635 = mul i64 %t627, %t625
  %t636 = bitcast %Diagnostic* %t623 to i8*
  %t637 = getelementptr %Diagnostic, %Diagnostic* %t631, i64 %t621
  %t638 = bitcast %Diagnostic* %t637 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t638, i8* %t636, i64 %t635)
  %t639 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t640 = ptrtoint { %Diagnostic*, i64 }* %t639 to i64
  %t641 = call i8* @malloc(i64 %t640)
  %t642 = bitcast i8* %t641 to { %Diagnostic*, i64 }*
  %t643 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t642, i32 0, i32 0
  store %Diagnostic* %t631, %Diagnostic** %t643
  %t644 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t642, i32 0, i32 1
  store i64 %t628, i64* %t644
  store { %Diagnostic*, i64 }* %t642, { %Diagnostic*, i64 }** %l4
  %t645 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t646 = extractvalue %Statement %statement, 0
  %t647 = alloca %Statement
  store %Statement %statement, %Statement* %t647
  %t648 = getelementptr inbounds %Statement, %Statement* %t647, i32 0, i32 1
  %t649 = bitcast [56 x i8]* %t648 to i8*
  %t650 = getelementptr inbounds i8, i8* %t649, i64 32
  %t651 = bitcast i8* %t650 to { %FieldDeclaration*, i64 }**
  %t652 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %t651
  %t653 = icmp eq i32 %t646, 8
  %t654 = select i1 %t653, { %FieldDeclaration*, i64 }* %t652, { %FieldDeclaration*, i64 }* null
  %t655 = call { %Diagnostic*, i64 }* @check_struct_fields({ %FieldDeclaration*, i64 }* %t654)
  %t656 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t645, i32 0, i32 0
  %t657 = load %Diagnostic*, %Diagnostic** %t656
  %t658 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t645, i32 0, i32 1
  %t659 = load i64, i64* %t658
  %t660 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t655, i32 0, i32 0
  %t661 = load %Diagnostic*, %Diagnostic** %t660
  %t662 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t655, i32 0, i32 1
  %t663 = load i64, i64* %t662
  %t664 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t665 = ptrtoint %Diagnostic* %t664 to i64
  %t666 = add i64 %t659, %t663
  %t667 = mul i64 %t665, %t666
  %t668 = call noalias i8* @malloc(i64 %t667)
  %t669 = bitcast i8* %t668 to %Diagnostic*
  %t670 = bitcast %Diagnostic* %t669 to i8*
  %t671 = mul i64 %t665, %t659
  %t672 = bitcast %Diagnostic* %t657 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t670, i8* %t672, i64 %t671)
  %t673 = mul i64 %t665, %t663
  %t674 = bitcast %Diagnostic* %t661 to i8*
  %t675 = getelementptr %Diagnostic, %Diagnostic* %t669, i64 %t659
  %t676 = bitcast %Diagnostic* %t675 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t676, i8* %t674, i64 %t673)
  %t677 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t678 = ptrtoint { %Diagnostic*, i64 }* %t677 to i64
  %t679 = call i8* @malloc(i64 %t678)
  %t680 = bitcast i8* %t679 to { %Diagnostic*, i64 }*
  %t681 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t680, i32 0, i32 0
  store %Diagnostic* %t669, %Diagnostic** %t681
  %t682 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t680, i32 0, i32 1
  store i64 %t666, i64* %t682
  store { %Diagnostic*, i64 }* %t680, { %Diagnostic*, i64 }** %l4
  %t683 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t684 = extractvalue %Statement %statement, 0
  %t685 = alloca %Statement
  store %Statement %statement, %Statement* %t685
  %t686 = getelementptr inbounds %Statement, %Statement* %t685, i32 0, i32 1
  %t687 = bitcast [56 x i8]* %t686 to i8*
  %t688 = getelementptr inbounds i8, i8* %t687, i64 40
  %t689 = bitcast i8* %t688 to { %MethodDeclaration*, i64 }**
  %t690 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t689
  %t691 = icmp eq i32 %t684, 8
  %t692 = select i1 %t691, { %MethodDeclaration*, i64 }* %t690, { %MethodDeclaration*, i64 }* null
  %t693 = call { %Diagnostic*, i64 }* @check_struct_methods({ %MethodDeclaration*, i64 }* %t692)
  %t694 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t683, i32 0, i32 0
  %t695 = load %Diagnostic*, %Diagnostic** %t694
  %t696 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t683, i32 0, i32 1
  %t697 = load i64, i64* %t696
  %t698 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t693, i32 0, i32 0
  %t699 = load %Diagnostic*, %Diagnostic** %t698
  %t700 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t693, i32 0, i32 1
  %t701 = load i64, i64* %t700
  %t702 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t703 = ptrtoint %Diagnostic* %t702 to i64
  %t704 = add i64 %t697, %t701
  %t705 = mul i64 %t703, %t704
  %t706 = call noalias i8* @malloc(i64 %t705)
  %t707 = bitcast i8* %t706 to %Diagnostic*
  %t708 = bitcast %Diagnostic* %t707 to i8*
  %t709 = mul i64 %t703, %t697
  %t710 = bitcast %Diagnostic* %t695 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t708, i8* %t710, i64 %t709)
  %t711 = mul i64 %t703, %t701
  %t712 = bitcast %Diagnostic* %t699 to i8*
  %t713 = getelementptr %Diagnostic, %Diagnostic* %t707, i64 %t697
  %t714 = bitcast %Diagnostic* %t713 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t714, i8* %t712, i64 %t711)
  %t715 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t716 = ptrtoint { %Diagnostic*, i64 }* %t715 to i64
  %t717 = call i8* @malloc(i64 %t716)
  %t718 = bitcast i8* %t717 to { %Diagnostic*, i64 }*
  %t719 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t718, i32 0, i32 0
  store %Diagnostic* %t707, %Diagnostic** %t719
  %t720 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t718, i32 0, i32 1
  store i64 %t704, i64* %t720
  store { %Diagnostic*, i64 }* %t718, { %Diagnostic*, i64 }** %l4
  %t721 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t722 = call { %Diagnostic*, i64 }* @check_struct_implements_interfaces(%Statement %statement, { %Statement*, i64 }* %interfaces)
  %t723 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t721, i32 0, i32 0
  %t724 = load %Diagnostic*, %Diagnostic** %t723
  %t725 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t721, i32 0, i32 1
  %t726 = load i64, i64* %t725
  %t727 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t722, i32 0, i32 0
  %t728 = load %Diagnostic*, %Diagnostic** %t727
  %t729 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t722, i32 0, i32 1
  %t730 = load i64, i64* %t729
  %t731 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t732 = ptrtoint %Diagnostic* %t731 to i64
  %t733 = add i64 %t726, %t730
  %t734 = mul i64 %t732, %t733
  %t735 = call noalias i8* @malloc(i64 %t734)
  %t736 = bitcast i8* %t735 to %Diagnostic*
  %t737 = bitcast %Diagnostic* %t736 to i8*
  %t738 = mul i64 %t732, %t726
  %t739 = bitcast %Diagnostic* %t724 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t737, i8* %t739, i64 %t738)
  %t740 = mul i64 %t732, %t730
  %t741 = bitcast %Diagnostic* %t728 to i8*
  %t742 = getelementptr %Diagnostic, %Diagnostic* %t736, i64 %t726
  %t743 = bitcast %Diagnostic* %t742 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t743, i8* %t741, i64 %t740)
  %t744 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t745 = ptrtoint { %Diagnostic*, i64 }* %t744 to i64
  %t746 = call i8* @malloc(i64 %t745)
  %t747 = bitcast i8* %t746 to { %Diagnostic*, i64 }*
  %t748 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t747, i32 0, i32 0
  store %Diagnostic* %t736, %Diagnostic** %t748
  %t749 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t747, i32 0, i32 1
  store i64 %t733, i64* %t749
  store { %Diagnostic*, i64 }* %t747, { %Diagnostic*, i64 }** %l4
  %t750 = sitofp i64 0 to double
  store double %t750, double* %l5
  %t751 = load %ScopeResult, %ScopeResult* %l3
  %t752 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t753 = load double, double* %l5
  br label %loop.header6
loop.header6:
  %t827 = phi { %Diagnostic*, i64 }* [ %t752, %then4 ], [ %t825, %loop.latch8 ]
  %t828 = phi double [ %t753, %then4 ], [ %t826, %loop.latch8 ]
  store { %Diagnostic*, i64 }* %t827, { %Diagnostic*, i64 }** %l4
  store double %t828, double* %l5
  br label %loop.body7
loop.body7:
  %t754 = load double, double* %l5
  %t755 = extractvalue %Statement %statement, 0
  %t756 = alloca %Statement
  store %Statement %statement, %Statement* %t756
  %t757 = getelementptr inbounds %Statement, %Statement* %t756, i32 0, i32 1
  %t758 = bitcast [56 x i8]* %t757 to i8*
  %t759 = getelementptr inbounds i8, i8* %t758, i64 40
  %t760 = bitcast i8* %t759 to { %MethodDeclaration*, i64 }**
  %t761 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t760
  %t762 = icmp eq i32 %t755, 8
  %t763 = select i1 %t762, { %MethodDeclaration*, i64 }* %t761, { %MethodDeclaration*, i64 }* null
  %t764 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t763
  %t765 = extractvalue { %MethodDeclaration*, i64 } %t764, 1
  %t766 = sitofp i64 %t765 to double
  %t767 = fcmp oge double %t754, %t766
  %t768 = load %ScopeResult, %ScopeResult* %l3
  %t769 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t770 = load double, double* %l5
  br i1 %t767, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t771 = extractvalue %Statement %statement, 0
  %t772 = alloca %Statement
  store %Statement %statement, %Statement* %t772
  %t773 = getelementptr inbounds %Statement, %Statement* %t772, i32 0, i32 1
  %t774 = bitcast [56 x i8]* %t773 to i8*
  %t775 = getelementptr inbounds i8, i8* %t774, i64 40
  %t776 = bitcast i8* %t775 to { %MethodDeclaration*, i64 }**
  %t777 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t776
  %t778 = icmp eq i32 %t771, 8
  %t779 = select i1 %t778, { %MethodDeclaration*, i64 }* %t777, { %MethodDeclaration*, i64 }* null
  %t780 = load double, double* %l5
  %t781 = call double @llvm.round.f64(double %t780)
  %t782 = fptosi double %t781 to i64
  %t783 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t779
  %t784 = extractvalue { %MethodDeclaration*, i64 } %t783, 0
  %t785 = extractvalue { %MethodDeclaration*, i64 } %t783, 1
  %t786 = icmp uge i64 %t782, %t785
  ; bounds check: %t786 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t782, i64 %t785)
  %t787 = getelementptr %MethodDeclaration, %MethodDeclaration* %t784, i64 %t782
  %t788 = load %MethodDeclaration, %MethodDeclaration* %t787
  store %MethodDeclaration %t788, %MethodDeclaration* %l6
  %t789 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t790 = load %MethodDeclaration, %MethodDeclaration* %l6
  %t791 = extractvalue %MethodDeclaration %t790, 0
  %t792 = load %MethodDeclaration, %MethodDeclaration* %l6
  %t793 = extractvalue %MethodDeclaration %t792, 1
  %t794 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t791, %Block %t793, { %Statement*, i64 }* %interfaces)
  %t795 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t789, i32 0, i32 0
  %t796 = load %Diagnostic*, %Diagnostic** %t795
  %t797 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t789, i32 0, i32 1
  %t798 = load i64, i64* %t797
  %t799 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t794, i32 0, i32 0
  %t800 = load %Diagnostic*, %Diagnostic** %t799
  %t801 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t794, i32 0, i32 1
  %t802 = load i64, i64* %t801
  %t803 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t804 = ptrtoint %Diagnostic* %t803 to i64
  %t805 = add i64 %t798, %t802
  %t806 = mul i64 %t804, %t805
  %t807 = call noalias i8* @malloc(i64 %t806)
  %t808 = bitcast i8* %t807 to %Diagnostic*
  %t809 = bitcast %Diagnostic* %t808 to i8*
  %t810 = mul i64 %t804, %t798
  %t811 = bitcast %Diagnostic* %t796 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t809, i8* %t811, i64 %t810)
  %t812 = mul i64 %t804, %t802
  %t813 = bitcast %Diagnostic* %t800 to i8*
  %t814 = getelementptr %Diagnostic, %Diagnostic* %t808, i64 %t798
  %t815 = bitcast %Diagnostic* %t814 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t815, i8* %t813, i64 %t812)
  %t816 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t817 = ptrtoint { %Diagnostic*, i64 }* %t816 to i64
  %t818 = call i8* @malloc(i64 %t817)
  %t819 = bitcast i8* %t818 to { %Diagnostic*, i64 }*
  %t820 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t819, i32 0, i32 0
  store %Diagnostic* %t808, %Diagnostic** %t820
  %t821 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t819, i32 0, i32 1
  store i64 %t805, i64* %t821
  store { %Diagnostic*, i64 }* %t819, { %Diagnostic*, i64 }** %l4
  %t822 = load double, double* %l5
  %t823 = sitofp i64 1 to double
  %t824 = fadd double %t822, %t823
  store double %t824, double* %l5
  br label %loop.latch8
loop.latch8:
  %t825 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t826 = load double, double* %l5
  br label %loop.header6
afterloop9:
  %t829 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t830 = load double, double* %l5
  %t831 = load %ScopeResult, %ScopeResult* %l3
  %t832 = extractvalue %ScopeResult %t831, 0
  %t833 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t832, 0
  %t834 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l4
  %t835 = insertvalue %ScopeResult %t833, { %Diagnostic*, i64 }* %t834, 1
  ret %ScopeResult %t835
merge5:
  %t836 = extractvalue %Statement %statement, 0
  %t837 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t838 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t839 = icmp eq i32 %t836, 0
  %t840 = select i1 %t839, i8* %t838, i8* %t837
  %t841 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t842 = icmp eq i32 %t836, 1
  %t843 = select i1 %t842, i8* %t841, i8* %t840
  %t844 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t845 = icmp eq i32 %t836, 2
  %t846 = select i1 %t845, i8* %t844, i8* %t843
  %t847 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t848 = icmp eq i32 %t836, 3
  %t849 = select i1 %t848, i8* %t847, i8* %t846
  %t850 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t851 = icmp eq i32 %t836, 4
  %t852 = select i1 %t851, i8* %t850, i8* %t849
  %t853 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t854 = icmp eq i32 %t836, 5
  %t855 = select i1 %t854, i8* %t853, i8* %t852
  %t856 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t857 = icmp eq i32 %t836, 6
  %t858 = select i1 %t857, i8* %t856, i8* %t855
  %t859 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t860 = icmp eq i32 %t836, 7
  %t861 = select i1 %t860, i8* %t859, i8* %t858
  %t862 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t863 = icmp eq i32 %t836, 8
  %t864 = select i1 %t863, i8* %t862, i8* %t861
  %t865 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t866 = icmp eq i32 %t836, 9
  %t867 = select i1 %t866, i8* %t865, i8* %t864
  %t868 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t869 = icmp eq i32 %t836, 10
  %t870 = select i1 %t869, i8* %t868, i8* %t867
  %t871 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t872 = icmp eq i32 %t836, 11
  %t873 = select i1 %t872, i8* %t871, i8* %t870
  %t874 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t875 = icmp eq i32 %t836, 12
  %t876 = select i1 %t875, i8* %t874, i8* %t873
  %t877 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t878 = icmp eq i32 %t836, 13
  %t879 = select i1 %t878, i8* %t877, i8* %t876
  %t880 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t881 = icmp eq i32 %t836, 14
  %t882 = select i1 %t881, i8* %t880, i8* %t879
  %t883 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t884 = icmp eq i32 %t836, 15
  %t885 = select i1 %t884, i8* %t883, i8* %t882
  %t886 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t887 = icmp eq i32 %t836, 16
  %t888 = select i1 %t887, i8* %t886, i8* %t885
  %t889 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t890 = icmp eq i32 %t836, 17
  %t891 = select i1 %t890, i8* %t889, i8* %t888
  %t892 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t893 = icmp eq i32 %t836, 18
  %t894 = select i1 %t893, i8* %t892, i8* %t891
  %t895 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t896 = icmp eq i32 %t836, 19
  %t897 = select i1 %t896, i8* %t895, i8* %t894
  %t898 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t899 = icmp eq i32 %t836, 20
  %t900 = select i1 %t899, i8* %t898, i8* %t897
  %t901 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t902 = icmp eq i32 %t836, 21
  %t903 = select i1 %t902, i8* %t901, i8* %t900
  %t904 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t905 = icmp eq i32 %t836, 22
  %t906 = select i1 %t905, i8* %t904, i8* %t903
  %s907 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h579804543, i32 0, i32 0
  %t908 = call i1 @strings_equal(i8* %t906, i8* %s907)
  br i1 %t908, label %then12, label %merge13
then12:
  %t909 = extractvalue %Statement %statement, 0
  %t910 = alloca %Statement
  store %Statement %statement, %Statement* %t910
  %t911 = getelementptr inbounds %Statement, %Statement* %t910, i32 0, i32 1
  %t912 = bitcast [48 x i8]* %t911 to i8*
  %t913 = bitcast i8* %t912 to i8**
  %t914 = load i8*, i8** %t913
  %t915 = icmp eq i32 %t909, 2
  %t916 = select i1 %t915, i8* %t914, i8* null
  %t917 = getelementptr inbounds %Statement, %Statement* %t910, i32 0, i32 1
  %t918 = bitcast [48 x i8]* %t917 to i8*
  %t919 = bitcast i8* %t918 to i8**
  %t920 = load i8*, i8** %t919
  %t921 = icmp eq i32 %t909, 3
  %t922 = select i1 %t921, i8* %t920, i8* %t916
  %t923 = getelementptr inbounds %Statement, %Statement* %t910, i32 0, i32 1
  %t924 = bitcast [56 x i8]* %t923 to i8*
  %t925 = bitcast i8* %t924 to i8**
  %t926 = load i8*, i8** %t925
  %t927 = icmp eq i32 %t909, 6
  %t928 = select i1 %t927, i8* %t926, i8* %t922
  %t929 = getelementptr inbounds %Statement, %Statement* %t910, i32 0, i32 1
  %t930 = bitcast [56 x i8]* %t929 to i8*
  %t931 = bitcast i8* %t930 to i8**
  %t932 = load i8*, i8** %t931
  %t933 = icmp eq i32 %t909, 8
  %t934 = select i1 %t933, i8* %t932, i8* %t928
  %t935 = getelementptr inbounds %Statement, %Statement* %t910, i32 0, i32 1
  %t936 = bitcast [40 x i8]* %t935 to i8*
  %t937 = bitcast i8* %t936 to i8**
  %t938 = load i8*, i8** %t937
  %t939 = icmp eq i32 %t909, 9
  %t940 = select i1 %t939, i8* %t938, i8* %t934
  %t941 = getelementptr inbounds %Statement, %Statement* %t910, i32 0, i32 1
  %t942 = bitcast [40 x i8]* %t941 to i8*
  %t943 = bitcast i8* %t942 to i8**
  %t944 = load i8*, i8** %t943
  %t945 = icmp eq i32 %t909, 10
  %t946 = select i1 %t945, i8* %t944, i8* %t940
  %t947 = getelementptr inbounds %Statement, %Statement* %t910, i32 0, i32 1
  %t948 = bitcast [40 x i8]* %t947 to i8*
  %t949 = bitcast i8* %t948 to i8**
  %t950 = load i8*, i8** %t949
  %t951 = icmp eq i32 %t909, 11
  %t952 = select i1 %t951, i8* %t950, i8* %t946
  %s953 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h258014432, i32 0, i32 0
  %t954 = extractvalue %Statement %statement, 0
  %t955 = alloca %Statement
  store %Statement %statement, %Statement* %t955
  %t956 = getelementptr inbounds %Statement, %Statement* %t955, i32 0, i32 1
  %t957 = bitcast [48 x i8]* %t956 to i8*
  %t958 = getelementptr inbounds i8, i8* %t957, i64 8
  %t959 = bitcast i8* %t958 to %SourceSpan**
  %t960 = load %SourceSpan*, %SourceSpan** %t959
  %t961 = icmp eq i32 %t954, 3
  %t962 = select i1 %t961, %SourceSpan* %t960, %SourceSpan* null
  %t963 = getelementptr inbounds %Statement, %Statement* %t955, i32 0, i32 1
  %t964 = bitcast [56 x i8]* %t963 to i8*
  %t965 = getelementptr inbounds i8, i8* %t964, i64 8
  %t966 = bitcast i8* %t965 to %SourceSpan**
  %t967 = load %SourceSpan*, %SourceSpan** %t966
  %t968 = icmp eq i32 %t954, 6
  %t969 = select i1 %t968, %SourceSpan* %t967, %SourceSpan* %t962
  %t970 = getelementptr inbounds %Statement, %Statement* %t955, i32 0, i32 1
  %t971 = bitcast [56 x i8]* %t970 to i8*
  %t972 = getelementptr inbounds i8, i8* %t971, i64 8
  %t973 = bitcast i8* %t972 to %SourceSpan**
  %t974 = load %SourceSpan*, %SourceSpan** %t973
  %t975 = icmp eq i32 %t954, 8
  %t976 = select i1 %t975, %SourceSpan* %t974, %SourceSpan* %t969
  %t977 = getelementptr inbounds %Statement, %Statement* %t955, i32 0, i32 1
  %t978 = bitcast [40 x i8]* %t977 to i8*
  %t979 = getelementptr inbounds i8, i8* %t978, i64 8
  %t980 = bitcast i8* %t979 to %SourceSpan**
  %t981 = load %SourceSpan*, %SourceSpan** %t980
  %t982 = icmp eq i32 %t954, 9
  %t983 = select i1 %t982, %SourceSpan* %t981, %SourceSpan* %t976
  %t984 = getelementptr inbounds %Statement, %Statement* %t955, i32 0, i32 1
  %t985 = bitcast [40 x i8]* %t984 to i8*
  %t986 = getelementptr inbounds i8, i8* %t985, i64 8
  %t987 = bitcast i8* %t986 to %SourceSpan**
  %t988 = load %SourceSpan*, %SourceSpan** %t987
  %t989 = icmp eq i32 %t954, 10
  %t990 = select i1 %t989, %SourceSpan* %t988, %SourceSpan* %t983
  %t991 = getelementptr inbounds %Statement, %Statement* %t955, i32 0, i32 1
  %t992 = bitcast [40 x i8]* %t991 to i8*
  %t993 = getelementptr inbounds i8, i8* %t992, i64 8
  %t994 = bitcast i8* %t993 to %SourceSpan**
  %t995 = load %SourceSpan*, %SourceSpan** %t994
  %t996 = icmp eq i32 %t954, 11
  %t997 = select i1 %t996, %SourceSpan* %t995, %SourceSpan* %t990
  %t998 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t952, i8* %s953, %SourceSpan* %t997)
  store %ScopeResult %t998, %ScopeResult* %l7
  %t999 = load %ScopeResult, %ScopeResult* %l7
  %t1000 = extractvalue %ScopeResult %t999, 1
  store { %Diagnostic*, i64 }* %t1000, { %Diagnostic*, i64 }** %l8
  %t1001 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l8
  %t1002 = extractvalue %Statement %statement, 0
  %t1003 = alloca %Statement
  store %Statement %statement, %Statement* %t1003
  %t1004 = getelementptr inbounds %Statement, %Statement* %t1003, i32 0, i32 1
  %t1005 = bitcast [56 x i8]* %t1004 to i8*
  %t1006 = getelementptr inbounds i8, i8* %t1005, i64 16
  %t1007 = bitcast i8* %t1006 to { %TypeParameter*, i64 }**
  %t1008 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1007
  %t1009 = icmp eq i32 %t1002, 8
  %t1010 = select i1 %t1009, { %TypeParameter*, i64 }* %t1008, { %TypeParameter*, i64 }* null
  %t1011 = getelementptr inbounds %Statement, %Statement* %t1003, i32 0, i32 1
  %t1012 = bitcast [40 x i8]* %t1011 to i8*
  %t1013 = getelementptr inbounds i8, i8* %t1012, i64 16
  %t1014 = bitcast i8* %t1013 to { %TypeParameter*, i64 }**
  %t1015 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1014
  %t1016 = icmp eq i32 %t1002, 9
  %t1017 = select i1 %t1016, { %TypeParameter*, i64 }* %t1015, { %TypeParameter*, i64 }* %t1010
  %t1018 = getelementptr inbounds %Statement, %Statement* %t1003, i32 0, i32 1
  %t1019 = bitcast [40 x i8]* %t1018 to i8*
  %t1020 = getelementptr inbounds i8, i8* %t1019, i64 16
  %t1021 = bitcast i8* %t1020 to { %TypeParameter*, i64 }**
  %t1022 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1021
  %t1023 = icmp eq i32 %t1002, 10
  %t1024 = select i1 %t1023, { %TypeParameter*, i64 }* %t1022, { %TypeParameter*, i64 }* %t1017
  %t1025 = getelementptr inbounds %Statement, %Statement* %t1003, i32 0, i32 1
  %t1026 = bitcast [40 x i8]* %t1025 to i8*
  %t1027 = getelementptr inbounds i8, i8* %t1026, i64 16
  %t1028 = bitcast i8* %t1027 to { %TypeParameter*, i64 }**
  %t1029 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1028
  %t1030 = icmp eq i32 %t1002, 11
  %t1031 = select i1 %t1030, { %TypeParameter*, i64 }* %t1029, { %TypeParameter*, i64 }* %t1024
  %t1032 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t1031)
  %t1033 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1001, i32 0, i32 0
  %t1034 = load %Diagnostic*, %Diagnostic** %t1033
  %t1035 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1001, i32 0, i32 1
  %t1036 = load i64, i64* %t1035
  %t1037 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1032, i32 0, i32 0
  %t1038 = load %Diagnostic*, %Diagnostic** %t1037
  %t1039 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1032, i32 0, i32 1
  %t1040 = load i64, i64* %t1039
  %t1041 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t1042 = ptrtoint %Diagnostic* %t1041 to i64
  %t1043 = add i64 %t1036, %t1040
  %t1044 = mul i64 %t1042, %t1043
  %t1045 = call noalias i8* @malloc(i64 %t1044)
  %t1046 = bitcast i8* %t1045 to %Diagnostic*
  %t1047 = bitcast %Diagnostic* %t1046 to i8*
  %t1048 = mul i64 %t1042, %t1036
  %t1049 = bitcast %Diagnostic* %t1034 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1047, i8* %t1049, i64 %t1048)
  %t1050 = mul i64 %t1042, %t1040
  %t1051 = bitcast %Diagnostic* %t1038 to i8*
  %t1052 = getelementptr %Diagnostic, %Diagnostic* %t1046, i64 %t1036
  %t1053 = bitcast %Diagnostic* %t1052 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1053, i8* %t1051, i64 %t1050)
  %t1054 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1055 = ptrtoint { %Diagnostic*, i64 }* %t1054 to i64
  %t1056 = call i8* @malloc(i64 %t1055)
  %t1057 = bitcast i8* %t1056 to { %Diagnostic*, i64 }*
  %t1058 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1057, i32 0, i32 0
  store %Diagnostic* %t1046, %Diagnostic** %t1058
  %t1059 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1057, i32 0, i32 1
  store i64 %t1043, i64* %t1059
  store { %Diagnostic*, i64 }* %t1057, { %Diagnostic*, i64 }** %l8
  %t1060 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l8
  %t1061 = extractvalue %Statement %statement, 0
  %t1062 = alloca %Statement
  store %Statement %statement, %Statement* %t1062
  %t1063 = getelementptr inbounds %Statement, %Statement* %t1062, i32 0, i32 1
  %t1064 = bitcast [40 x i8]* %t1063 to i8*
  %t1065 = getelementptr inbounds i8, i8* %t1064, i64 24
  %t1066 = bitcast i8* %t1065 to { %EnumVariant*, i64 }**
  %t1067 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %t1066
  %t1068 = icmp eq i32 %t1061, 11
  %t1069 = select i1 %t1068, { %EnumVariant*, i64 }* %t1067, { %EnumVariant*, i64 }* null
  %t1070 = call { %Diagnostic*, i64 }* @check_enum_variants({ %EnumVariant*, i64 }* %t1069)
  %t1071 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1060, i32 0, i32 0
  %t1072 = load %Diagnostic*, %Diagnostic** %t1071
  %t1073 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1060, i32 0, i32 1
  %t1074 = load i64, i64* %t1073
  %t1075 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1070, i32 0, i32 0
  %t1076 = load %Diagnostic*, %Diagnostic** %t1075
  %t1077 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1070, i32 0, i32 1
  %t1078 = load i64, i64* %t1077
  %t1079 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t1080 = ptrtoint %Diagnostic* %t1079 to i64
  %t1081 = add i64 %t1074, %t1078
  %t1082 = mul i64 %t1080, %t1081
  %t1083 = call noalias i8* @malloc(i64 %t1082)
  %t1084 = bitcast i8* %t1083 to %Diagnostic*
  %t1085 = bitcast %Diagnostic* %t1084 to i8*
  %t1086 = mul i64 %t1080, %t1074
  %t1087 = bitcast %Diagnostic* %t1072 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1085, i8* %t1087, i64 %t1086)
  %t1088 = mul i64 %t1080, %t1078
  %t1089 = bitcast %Diagnostic* %t1076 to i8*
  %t1090 = getelementptr %Diagnostic, %Diagnostic* %t1084, i64 %t1074
  %t1091 = bitcast %Diagnostic* %t1090 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1091, i8* %t1089, i64 %t1088)
  %t1092 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1093 = ptrtoint { %Diagnostic*, i64 }* %t1092 to i64
  %t1094 = call i8* @malloc(i64 %t1093)
  %t1095 = bitcast i8* %t1094 to { %Diagnostic*, i64 }*
  %t1096 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1095, i32 0, i32 0
  store %Diagnostic* %t1084, %Diagnostic** %t1096
  %t1097 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1095, i32 0, i32 1
  store i64 %t1081, i64* %t1097
  store { %Diagnostic*, i64 }* %t1095, { %Diagnostic*, i64 }** %l8
  %t1098 = load %ScopeResult, %ScopeResult* %l7
  %t1099 = extractvalue %ScopeResult %t1098, 0
  %t1100 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t1099, 0
  %t1101 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l8
  %t1102 = insertvalue %ScopeResult %t1100, { %Diagnostic*, i64 }* %t1101, 1
  ret %ScopeResult %t1102
merge13:
  %t1103 = extractvalue %Statement %statement, 0
  %t1104 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1105 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1106 = icmp eq i32 %t1103, 0
  %t1107 = select i1 %t1106, i8* %t1105, i8* %t1104
  %t1108 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1109 = icmp eq i32 %t1103, 1
  %t1110 = select i1 %t1109, i8* %t1108, i8* %t1107
  %t1111 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1112 = icmp eq i32 %t1103, 2
  %t1113 = select i1 %t1112, i8* %t1111, i8* %t1110
  %t1114 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1115 = icmp eq i32 %t1103, 3
  %t1116 = select i1 %t1115, i8* %t1114, i8* %t1113
  %t1117 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1118 = icmp eq i32 %t1103, 4
  %t1119 = select i1 %t1118, i8* %t1117, i8* %t1116
  %t1120 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1121 = icmp eq i32 %t1103, 5
  %t1122 = select i1 %t1121, i8* %t1120, i8* %t1119
  %t1123 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1124 = icmp eq i32 %t1103, 6
  %t1125 = select i1 %t1124, i8* %t1123, i8* %t1122
  %t1126 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1127 = icmp eq i32 %t1103, 7
  %t1128 = select i1 %t1127, i8* %t1126, i8* %t1125
  %t1129 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1130 = icmp eq i32 %t1103, 8
  %t1131 = select i1 %t1130, i8* %t1129, i8* %t1128
  %t1132 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1133 = icmp eq i32 %t1103, 9
  %t1134 = select i1 %t1133, i8* %t1132, i8* %t1131
  %t1135 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1136 = icmp eq i32 %t1103, 10
  %t1137 = select i1 %t1136, i8* %t1135, i8* %t1134
  %t1138 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1139 = icmp eq i32 %t1103, 11
  %t1140 = select i1 %t1139, i8* %t1138, i8* %t1137
  %t1141 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1142 = icmp eq i32 %t1103, 12
  %t1143 = select i1 %t1142, i8* %t1141, i8* %t1140
  %t1144 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1145 = icmp eq i32 %t1103, 13
  %t1146 = select i1 %t1145, i8* %t1144, i8* %t1143
  %t1147 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1148 = icmp eq i32 %t1103, 14
  %t1149 = select i1 %t1148, i8* %t1147, i8* %t1146
  %t1150 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1151 = icmp eq i32 %t1103, 15
  %t1152 = select i1 %t1151, i8* %t1150, i8* %t1149
  %t1153 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1154 = icmp eq i32 %t1103, 16
  %t1155 = select i1 %t1154, i8* %t1153, i8* %t1152
  %t1156 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1157 = icmp eq i32 %t1103, 17
  %t1158 = select i1 %t1157, i8* %t1156, i8* %t1155
  %t1159 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1160 = icmp eq i32 %t1103, 18
  %t1161 = select i1 %t1160, i8* %t1159, i8* %t1158
  %t1162 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1163 = icmp eq i32 %t1103, 19
  %t1164 = select i1 %t1163, i8* %t1162, i8* %t1161
  %t1165 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1166 = icmp eq i32 %t1103, 20
  %t1167 = select i1 %t1166, i8* %t1165, i8* %t1164
  %t1168 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1169 = icmp eq i32 %t1103, 21
  %t1170 = select i1 %t1169, i8* %t1168, i8* %t1167
  %t1171 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1172 = icmp eq i32 %t1103, 22
  %t1173 = select i1 %t1172, i8* %t1171, i8* %t1170
  %s1174 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h666604742, i32 0, i32 0
  %t1175 = call i1 @strings_equal(i8* %t1173, i8* %s1174)
  br i1 %t1175, label %then14, label %merge15
then14:
  %t1176 = extractvalue %Statement %statement, 0
  %t1177 = alloca %Statement
  store %Statement %statement, %Statement* %t1177
  %t1178 = getelementptr inbounds %Statement, %Statement* %t1177, i32 0, i32 1
  %t1179 = bitcast [48 x i8]* %t1178 to i8*
  %t1180 = bitcast i8* %t1179 to i8**
  %t1181 = load i8*, i8** %t1180
  %t1182 = icmp eq i32 %t1176, 2
  %t1183 = select i1 %t1182, i8* %t1181, i8* null
  %t1184 = getelementptr inbounds %Statement, %Statement* %t1177, i32 0, i32 1
  %t1185 = bitcast [48 x i8]* %t1184 to i8*
  %t1186 = bitcast i8* %t1185 to i8**
  %t1187 = load i8*, i8** %t1186
  %t1188 = icmp eq i32 %t1176, 3
  %t1189 = select i1 %t1188, i8* %t1187, i8* %t1183
  %t1190 = getelementptr inbounds %Statement, %Statement* %t1177, i32 0, i32 1
  %t1191 = bitcast [56 x i8]* %t1190 to i8*
  %t1192 = bitcast i8* %t1191 to i8**
  %t1193 = load i8*, i8** %t1192
  %t1194 = icmp eq i32 %t1176, 6
  %t1195 = select i1 %t1194, i8* %t1193, i8* %t1189
  %t1196 = getelementptr inbounds %Statement, %Statement* %t1177, i32 0, i32 1
  %t1197 = bitcast [56 x i8]* %t1196 to i8*
  %t1198 = bitcast i8* %t1197 to i8**
  %t1199 = load i8*, i8** %t1198
  %t1200 = icmp eq i32 %t1176, 8
  %t1201 = select i1 %t1200, i8* %t1199, i8* %t1195
  %t1202 = getelementptr inbounds %Statement, %Statement* %t1177, i32 0, i32 1
  %t1203 = bitcast [40 x i8]* %t1202 to i8*
  %t1204 = bitcast i8* %t1203 to i8**
  %t1205 = load i8*, i8** %t1204
  %t1206 = icmp eq i32 %t1176, 9
  %t1207 = select i1 %t1206, i8* %t1205, i8* %t1201
  %t1208 = getelementptr inbounds %Statement, %Statement* %t1177, i32 0, i32 1
  %t1209 = bitcast [40 x i8]* %t1208 to i8*
  %t1210 = bitcast i8* %t1209 to i8**
  %t1211 = load i8*, i8** %t1210
  %t1212 = icmp eq i32 %t1176, 10
  %t1213 = select i1 %t1212, i8* %t1211, i8* %t1207
  %t1214 = getelementptr inbounds %Statement, %Statement* %t1177, i32 0, i32 1
  %t1215 = bitcast [40 x i8]* %t1214 to i8*
  %t1216 = bitcast i8* %t1215 to i8**
  %t1217 = load i8*, i8** %t1216
  %t1218 = icmp eq i32 %t1176, 11
  %t1219 = select i1 %t1218, i8* %t1217, i8* %t1213
  %s1220 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1313193687, i32 0, i32 0
  %t1221 = extractvalue %Statement %statement, 0
  %t1222 = alloca %Statement
  store %Statement %statement, %Statement* %t1222
  %t1223 = getelementptr inbounds %Statement, %Statement* %t1222, i32 0, i32 1
  %t1224 = bitcast [48 x i8]* %t1223 to i8*
  %t1225 = getelementptr inbounds i8, i8* %t1224, i64 8
  %t1226 = bitcast i8* %t1225 to %SourceSpan**
  %t1227 = load %SourceSpan*, %SourceSpan** %t1226
  %t1228 = icmp eq i32 %t1221, 3
  %t1229 = select i1 %t1228, %SourceSpan* %t1227, %SourceSpan* null
  %t1230 = getelementptr inbounds %Statement, %Statement* %t1222, i32 0, i32 1
  %t1231 = bitcast [56 x i8]* %t1230 to i8*
  %t1232 = getelementptr inbounds i8, i8* %t1231, i64 8
  %t1233 = bitcast i8* %t1232 to %SourceSpan**
  %t1234 = load %SourceSpan*, %SourceSpan** %t1233
  %t1235 = icmp eq i32 %t1221, 6
  %t1236 = select i1 %t1235, %SourceSpan* %t1234, %SourceSpan* %t1229
  %t1237 = getelementptr inbounds %Statement, %Statement* %t1222, i32 0, i32 1
  %t1238 = bitcast [56 x i8]* %t1237 to i8*
  %t1239 = getelementptr inbounds i8, i8* %t1238, i64 8
  %t1240 = bitcast i8* %t1239 to %SourceSpan**
  %t1241 = load %SourceSpan*, %SourceSpan** %t1240
  %t1242 = icmp eq i32 %t1221, 8
  %t1243 = select i1 %t1242, %SourceSpan* %t1241, %SourceSpan* %t1236
  %t1244 = getelementptr inbounds %Statement, %Statement* %t1222, i32 0, i32 1
  %t1245 = bitcast [40 x i8]* %t1244 to i8*
  %t1246 = getelementptr inbounds i8, i8* %t1245, i64 8
  %t1247 = bitcast i8* %t1246 to %SourceSpan**
  %t1248 = load %SourceSpan*, %SourceSpan** %t1247
  %t1249 = icmp eq i32 %t1221, 9
  %t1250 = select i1 %t1249, %SourceSpan* %t1248, %SourceSpan* %t1243
  %t1251 = getelementptr inbounds %Statement, %Statement* %t1222, i32 0, i32 1
  %t1252 = bitcast [40 x i8]* %t1251 to i8*
  %t1253 = getelementptr inbounds i8, i8* %t1252, i64 8
  %t1254 = bitcast i8* %t1253 to %SourceSpan**
  %t1255 = load %SourceSpan*, %SourceSpan** %t1254
  %t1256 = icmp eq i32 %t1221, 10
  %t1257 = select i1 %t1256, %SourceSpan* %t1255, %SourceSpan* %t1250
  %t1258 = getelementptr inbounds %Statement, %Statement* %t1222, i32 0, i32 1
  %t1259 = bitcast [40 x i8]* %t1258 to i8*
  %t1260 = getelementptr inbounds i8, i8* %t1259, i64 8
  %t1261 = bitcast i8* %t1260 to %SourceSpan**
  %t1262 = load %SourceSpan*, %SourceSpan** %t1261
  %t1263 = icmp eq i32 %t1221, 11
  %t1264 = select i1 %t1263, %SourceSpan* %t1262, %SourceSpan* %t1257
  %t1265 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1219, i8* %s1220, %SourceSpan* %t1264)
  store %ScopeResult %t1265, %ScopeResult* %l9
  %t1266 = load %ScopeResult, %ScopeResult* %l9
  %t1267 = extractvalue %ScopeResult %t1266, 1
  store { %Diagnostic*, i64 }* %t1267, { %Diagnostic*, i64 }** %l10
  %t1268 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l10
  %t1269 = extractvalue %Statement %statement, 0
  %t1270 = alloca %Statement
  store %Statement %statement, %Statement* %t1270
  %t1271 = getelementptr inbounds %Statement, %Statement* %t1270, i32 0, i32 1
  %t1272 = bitcast [56 x i8]* %t1271 to i8*
  %t1273 = getelementptr inbounds i8, i8* %t1272, i64 16
  %t1274 = bitcast i8* %t1273 to { %TypeParameter*, i64 }**
  %t1275 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1274
  %t1276 = icmp eq i32 %t1269, 8
  %t1277 = select i1 %t1276, { %TypeParameter*, i64 }* %t1275, { %TypeParameter*, i64 }* null
  %t1278 = getelementptr inbounds %Statement, %Statement* %t1270, i32 0, i32 1
  %t1279 = bitcast [40 x i8]* %t1278 to i8*
  %t1280 = getelementptr inbounds i8, i8* %t1279, i64 16
  %t1281 = bitcast i8* %t1280 to { %TypeParameter*, i64 }**
  %t1282 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1281
  %t1283 = icmp eq i32 %t1269, 9
  %t1284 = select i1 %t1283, { %TypeParameter*, i64 }* %t1282, { %TypeParameter*, i64 }* %t1277
  %t1285 = getelementptr inbounds %Statement, %Statement* %t1270, i32 0, i32 1
  %t1286 = bitcast [40 x i8]* %t1285 to i8*
  %t1287 = getelementptr inbounds i8, i8* %t1286, i64 16
  %t1288 = bitcast i8* %t1287 to { %TypeParameter*, i64 }**
  %t1289 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1288
  %t1290 = icmp eq i32 %t1269, 10
  %t1291 = select i1 %t1290, { %TypeParameter*, i64 }* %t1289, { %TypeParameter*, i64 }* %t1284
  %t1292 = getelementptr inbounds %Statement, %Statement* %t1270, i32 0, i32 1
  %t1293 = bitcast [40 x i8]* %t1292 to i8*
  %t1294 = getelementptr inbounds i8, i8* %t1293, i64 16
  %t1295 = bitcast i8* %t1294 to { %TypeParameter*, i64 }**
  %t1296 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t1295
  %t1297 = icmp eq i32 %t1269, 11
  %t1298 = select i1 %t1297, { %TypeParameter*, i64 }* %t1296, { %TypeParameter*, i64 }* %t1291
  %t1299 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t1298)
  %t1300 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1268, i32 0, i32 0
  %t1301 = load %Diagnostic*, %Diagnostic** %t1300
  %t1302 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1268, i32 0, i32 1
  %t1303 = load i64, i64* %t1302
  %t1304 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1299, i32 0, i32 0
  %t1305 = load %Diagnostic*, %Diagnostic** %t1304
  %t1306 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1299, i32 0, i32 1
  %t1307 = load i64, i64* %t1306
  %t1308 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t1309 = ptrtoint %Diagnostic* %t1308 to i64
  %t1310 = add i64 %t1303, %t1307
  %t1311 = mul i64 %t1309, %t1310
  %t1312 = call noalias i8* @malloc(i64 %t1311)
  %t1313 = bitcast i8* %t1312 to %Diagnostic*
  %t1314 = bitcast %Diagnostic* %t1313 to i8*
  %t1315 = mul i64 %t1309, %t1303
  %t1316 = bitcast %Diagnostic* %t1301 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1314, i8* %t1316, i64 %t1315)
  %t1317 = mul i64 %t1309, %t1307
  %t1318 = bitcast %Diagnostic* %t1305 to i8*
  %t1319 = getelementptr %Diagnostic, %Diagnostic* %t1313, i64 %t1303
  %t1320 = bitcast %Diagnostic* %t1319 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1320, i8* %t1318, i64 %t1317)
  %t1321 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1322 = ptrtoint { %Diagnostic*, i64 }* %t1321 to i64
  %t1323 = call i8* @malloc(i64 %t1322)
  %t1324 = bitcast i8* %t1323 to { %Diagnostic*, i64 }*
  %t1325 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1324, i32 0, i32 0
  store %Diagnostic* %t1313, %Diagnostic** %t1325
  %t1326 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1324, i32 0, i32 1
  store i64 %t1310, i64* %t1326
  store { %Diagnostic*, i64 }* %t1324, { %Diagnostic*, i64 }** %l10
  %t1327 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l10
  %t1328 = extractvalue %Statement %statement, 0
  %t1329 = alloca %Statement
  store %Statement %statement, %Statement* %t1329
  %t1330 = getelementptr inbounds %Statement, %Statement* %t1329, i32 0, i32 1
  %t1331 = bitcast [40 x i8]* %t1330 to i8*
  %t1332 = getelementptr inbounds i8, i8* %t1331, i64 24
  %t1333 = bitcast i8* %t1332 to { %FunctionSignature*, i64 }**
  %t1334 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %t1333
  %t1335 = icmp eq i32 %t1328, 10
  %t1336 = select i1 %t1335, { %FunctionSignature*, i64 }* %t1334, { %FunctionSignature*, i64 }* null
  %t1337 = call { %Diagnostic*, i64 }* @check_interface_members({ %FunctionSignature*, i64 }* %t1336)
  %t1338 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1327, i32 0, i32 0
  %t1339 = load %Diagnostic*, %Diagnostic** %t1338
  %t1340 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1327, i32 0, i32 1
  %t1341 = load i64, i64* %t1340
  %t1342 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1337, i32 0, i32 0
  %t1343 = load %Diagnostic*, %Diagnostic** %t1342
  %t1344 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1337, i32 0, i32 1
  %t1345 = load i64, i64* %t1344
  %t1346 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t1347 = ptrtoint %Diagnostic* %t1346 to i64
  %t1348 = add i64 %t1341, %t1345
  %t1349 = mul i64 %t1347, %t1348
  %t1350 = call noalias i8* @malloc(i64 %t1349)
  %t1351 = bitcast i8* %t1350 to %Diagnostic*
  %t1352 = bitcast %Diagnostic* %t1351 to i8*
  %t1353 = mul i64 %t1347, %t1341
  %t1354 = bitcast %Diagnostic* %t1339 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1352, i8* %t1354, i64 %t1353)
  %t1355 = mul i64 %t1347, %t1345
  %t1356 = bitcast %Diagnostic* %t1343 to i8*
  %t1357 = getelementptr %Diagnostic, %Diagnostic* %t1351, i64 %t1341
  %t1358 = bitcast %Diagnostic* %t1357 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1358, i8* %t1356, i64 %t1355)
  %t1359 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1360 = ptrtoint { %Diagnostic*, i64 }* %t1359 to i64
  %t1361 = call i8* @malloc(i64 %t1360)
  %t1362 = bitcast i8* %t1361 to { %Diagnostic*, i64 }*
  %t1363 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1362, i32 0, i32 0
  store %Diagnostic* %t1351, %Diagnostic** %t1363
  %t1364 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1362, i32 0, i32 1
  store i64 %t1348, i64* %t1364
  store { %Diagnostic*, i64 }* %t1362, { %Diagnostic*, i64 }** %l10
  %t1365 = load %ScopeResult, %ScopeResult* %l9
  %t1366 = extractvalue %ScopeResult %t1365, 0
  %t1367 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t1366, 0
  %t1368 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l10
  %t1369 = insertvalue %ScopeResult %t1367, { %Diagnostic*, i64 }* %t1368, 1
  ret %ScopeResult %t1369
merge15:
  %t1370 = extractvalue %Statement %statement, 0
  %t1371 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1372 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1373 = icmp eq i32 %t1370, 0
  %t1374 = select i1 %t1373, i8* %t1372, i8* %t1371
  %t1375 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1376 = icmp eq i32 %t1370, 1
  %t1377 = select i1 %t1376, i8* %t1375, i8* %t1374
  %t1378 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1379 = icmp eq i32 %t1370, 2
  %t1380 = select i1 %t1379, i8* %t1378, i8* %t1377
  %t1381 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1382 = icmp eq i32 %t1370, 3
  %t1383 = select i1 %t1382, i8* %t1381, i8* %t1380
  %t1384 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1385 = icmp eq i32 %t1370, 4
  %t1386 = select i1 %t1385, i8* %t1384, i8* %t1383
  %t1387 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1388 = icmp eq i32 %t1370, 5
  %t1389 = select i1 %t1388, i8* %t1387, i8* %t1386
  %t1390 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1391 = icmp eq i32 %t1370, 6
  %t1392 = select i1 %t1391, i8* %t1390, i8* %t1389
  %t1393 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1394 = icmp eq i32 %t1370, 7
  %t1395 = select i1 %t1394, i8* %t1393, i8* %t1392
  %t1396 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1397 = icmp eq i32 %t1370, 8
  %t1398 = select i1 %t1397, i8* %t1396, i8* %t1395
  %t1399 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1400 = icmp eq i32 %t1370, 9
  %t1401 = select i1 %t1400, i8* %t1399, i8* %t1398
  %t1402 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1403 = icmp eq i32 %t1370, 10
  %t1404 = select i1 %t1403, i8* %t1402, i8* %t1401
  %t1405 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1406 = icmp eq i32 %t1370, 11
  %t1407 = select i1 %t1406, i8* %t1405, i8* %t1404
  %t1408 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1409 = icmp eq i32 %t1370, 12
  %t1410 = select i1 %t1409, i8* %t1408, i8* %t1407
  %t1411 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1412 = icmp eq i32 %t1370, 13
  %t1413 = select i1 %t1412, i8* %t1411, i8* %t1410
  %t1414 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1415 = icmp eq i32 %t1370, 14
  %t1416 = select i1 %t1415, i8* %t1414, i8* %t1413
  %t1417 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1418 = icmp eq i32 %t1370, 15
  %t1419 = select i1 %t1418, i8* %t1417, i8* %t1416
  %t1420 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1421 = icmp eq i32 %t1370, 16
  %t1422 = select i1 %t1421, i8* %t1420, i8* %t1419
  %t1423 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1424 = icmp eq i32 %t1370, 17
  %t1425 = select i1 %t1424, i8* %t1423, i8* %t1422
  %t1426 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1427 = icmp eq i32 %t1370, 18
  %t1428 = select i1 %t1427, i8* %t1426, i8* %t1425
  %t1429 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1430 = icmp eq i32 %t1370, 19
  %t1431 = select i1 %t1430, i8* %t1429, i8* %t1428
  %t1432 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1433 = icmp eq i32 %t1370, 20
  %t1434 = select i1 %t1433, i8* %t1432, i8* %t1431
  %t1435 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1436 = icmp eq i32 %t1370, 21
  %t1437 = select i1 %t1436, i8* %t1435, i8* %t1434
  %t1438 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1439 = icmp eq i32 %t1370, 22
  %t1440 = select i1 %t1439, i8* %t1438, i8* %t1437
  %s1441 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h2043328844, i32 0, i32 0
  %t1442 = call i1 @strings_equal(i8* %t1440, i8* %s1441)
  br i1 %t1442, label %then16, label %merge17
then16:
  %t1443 = extractvalue %Statement %statement, 0
  %t1444 = alloca %Statement
  store %Statement %statement, %Statement* %t1444
  %t1445 = getelementptr inbounds %Statement, %Statement* %t1444, i32 0, i32 1
  %t1446 = bitcast [48 x i8]* %t1445 to i8*
  %t1447 = bitcast i8* %t1446 to i8**
  %t1448 = load i8*, i8** %t1447
  %t1449 = icmp eq i32 %t1443, 2
  %t1450 = select i1 %t1449, i8* %t1448, i8* null
  %t1451 = getelementptr inbounds %Statement, %Statement* %t1444, i32 0, i32 1
  %t1452 = bitcast [48 x i8]* %t1451 to i8*
  %t1453 = bitcast i8* %t1452 to i8**
  %t1454 = load i8*, i8** %t1453
  %t1455 = icmp eq i32 %t1443, 3
  %t1456 = select i1 %t1455, i8* %t1454, i8* %t1450
  %t1457 = getelementptr inbounds %Statement, %Statement* %t1444, i32 0, i32 1
  %t1458 = bitcast [56 x i8]* %t1457 to i8*
  %t1459 = bitcast i8* %t1458 to i8**
  %t1460 = load i8*, i8** %t1459
  %t1461 = icmp eq i32 %t1443, 6
  %t1462 = select i1 %t1461, i8* %t1460, i8* %t1456
  %t1463 = getelementptr inbounds %Statement, %Statement* %t1444, i32 0, i32 1
  %t1464 = bitcast [56 x i8]* %t1463 to i8*
  %t1465 = bitcast i8* %t1464 to i8**
  %t1466 = load i8*, i8** %t1465
  %t1467 = icmp eq i32 %t1443, 8
  %t1468 = select i1 %t1467, i8* %t1466, i8* %t1462
  %t1469 = getelementptr inbounds %Statement, %Statement* %t1444, i32 0, i32 1
  %t1470 = bitcast [40 x i8]* %t1469 to i8*
  %t1471 = bitcast i8* %t1470 to i8**
  %t1472 = load i8*, i8** %t1471
  %t1473 = icmp eq i32 %t1443, 9
  %t1474 = select i1 %t1473, i8* %t1472, i8* %t1468
  %t1475 = getelementptr inbounds %Statement, %Statement* %t1444, i32 0, i32 1
  %t1476 = bitcast [40 x i8]* %t1475 to i8*
  %t1477 = bitcast i8* %t1476 to i8**
  %t1478 = load i8*, i8** %t1477
  %t1479 = icmp eq i32 %t1443, 10
  %t1480 = select i1 %t1479, i8* %t1478, i8* %t1474
  %t1481 = getelementptr inbounds %Statement, %Statement* %t1444, i32 0, i32 1
  %t1482 = bitcast [40 x i8]* %t1481 to i8*
  %t1483 = bitcast i8* %t1482 to i8**
  %t1484 = load i8*, i8** %t1483
  %t1485 = icmp eq i32 %t1443, 11
  %t1486 = select i1 %t1485, i8* %t1484, i8* %t1480
  %s1487 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h238194529, i32 0, i32 0
  %t1488 = extractvalue %Statement %statement, 0
  %t1489 = alloca %Statement
  store %Statement %statement, %Statement* %t1489
  %t1490 = getelementptr inbounds %Statement, %Statement* %t1489, i32 0, i32 1
  %t1491 = bitcast [48 x i8]* %t1490 to i8*
  %t1492 = getelementptr inbounds i8, i8* %t1491, i64 8
  %t1493 = bitcast i8* %t1492 to %SourceSpan**
  %t1494 = load %SourceSpan*, %SourceSpan** %t1493
  %t1495 = icmp eq i32 %t1488, 3
  %t1496 = select i1 %t1495, %SourceSpan* %t1494, %SourceSpan* null
  %t1497 = getelementptr inbounds %Statement, %Statement* %t1489, i32 0, i32 1
  %t1498 = bitcast [56 x i8]* %t1497 to i8*
  %t1499 = getelementptr inbounds i8, i8* %t1498, i64 8
  %t1500 = bitcast i8* %t1499 to %SourceSpan**
  %t1501 = load %SourceSpan*, %SourceSpan** %t1500
  %t1502 = icmp eq i32 %t1488, 6
  %t1503 = select i1 %t1502, %SourceSpan* %t1501, %SourceSpan* %t1496
  %t1504 = getelementptr inbounds %Statement, %Statement* %t1489, i32 0, i32 1
  %t1505 = bitcast [56 x i8]* %t1504 to i8*
  %t1506 = getelementptr inbounds i8, i8* %t1505, i64 8
  %t1507 = bitcast i8* %t1506 to %SourceSpan**
  %t1508 = load %SourceSpan*, %SourceSpan** %t1507
  %t1509 = icmp eq i32 %t1488, 8
  %t1510 = select i1 %t1509, %SourceSpan* %t1508, %SourceSpan* %t1503
  %t1511 = getelementptr inbounds %Statement, %Statement* %t1489, i32 0, i32 1
  %t1512 = bitcast [40 x i8]* %t1511 to i8*
  %t1513 = getelementptr inbounds i8, i8* %t1512, i64 8
  %t1514 = bitcast i8* %t1513 to %SourceSpan**
  %t1515 = load %SourceSpan*, %SourceSpan** %t1514
  %t1516 = icmp eq i32 %t1488, 9
  %t1517 = select i1 %t1516, %SourceSpan* %t1515, %SourceSpan* %t1510
  %t1518 = getelementptr inbounds %Statement, %Statement* %t1489, i32 0, i32 1
  %t1519 = bitcast [40 x i8]* %t1518 to i8*
  %t1520 = getelementptr inbounds i8, i8* %t1519, i64 8
  %t1521 = bitcast i8* %t1520 to %SourceSpan**
  %t1522 = load %SourceSpan*, %SourceSpan** %t1521
  %t1523 = icmp eq i32 %t1488, 10
  %t1524 = select i1 %t1523, %SourceSpan* %t1522, %SourceSpan* %t1517
  %t1525 = getelementptr inbounds %Statement, %Statement* %t1489, i32 0, i32 1
  %t1526 = bitcast [40 x i8]* %t1525 to i8*
  %t1527 = getelementptr inbounds i8, i8* %t1526, i64 8
  %t1528 = bitcast i8* %t1527 to %SourceSpan**
  %t1529 = load %SourceSpan*, %SourceSpan** %t1528
  %t1530 = icmp eq i32 %t1488, 11
  %t1531 = select i1 %t1530, %SourceSpan* %t1529, %SourceSpan* %t1524
  %t1532 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1486, i8* %s1487, %SourceSpan* %t1531)
  store %ScopeResult %t1532, %ScopeResult* %l11
  %t1533 = load %ScopeResult, %ScopeResult* %l11
  %t1534 = extractvalue %ScopeResult %t1533, 1
  %t1535 = extractvalue %Statement %statement, 0
  %t1536 = alloca %Statement
  store %Statement %statement, %Statement* %t1536
  %t1537 = getelementptr inbounds %Statement, %Statement* %t1536, i32 0, i32 1
  %t1538 = bitcast [48 x i8]* %t1537 to i8*
  %t1539 = getelementptr inbounds i8, i8* %t1538, i64 24
  %t1540 = bitcast i8* %t1539 to { %ModelProperty*, i64 }**
  %t1541 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %t1540
  %t1542 = icmp eq i32 %t1535, 3
  %t1543 = select i1 %t1542, { %ModelProperty*, i64 }* %t1541, { %ModelProperty*, i64 }* null
  %t1544 = call { %Diagnostic*, i64 }* @check_model_properties({ %ModelProperty*, i64 }* %t1543)
  %t1545 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1534, i32 0, i32 0
  %t1546 = load %Diagnostic*, %Diagnostic** %t1545
  %t1547 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1534, i32 0, i32 1
  %t1548 = load i64, i64* %t1547
  %t1549 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1544, i32 0, i32 0
  %t1550 = load %Diagnostic*, %Diagnostic** %t1549
  %t1551 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1544, i32 0, i32 1
  %t1552 = load i64, i64* %t1551
  %t1553 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t1554 = ptrtoint %Diagnostic* %t1553 to i64
  %t1555 = add i64 %t1548, %t1552
  %t1556 = mul i64 %t1554, %t1555
  %t1557 = call noalias i8* @malloc(i64 %t1556)
  %t1558 = bitcast i8* %t1557 to %Diagnostic*
  %t1559 = bitcast %Diagnostic* %t1558 to i8*
  %t1560 = mul i64 %t1554, %t1548
  %t1561 = bitcast %Diagnostic* %t1546 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1559, i8* %t1561, i64 %t1560)
  %t1562 = mul i64 %t1554, %t1552
  %t1563 = bitcast %Diagnostic* %t1550 to i8*
  %t1564 = getelementptr %Diagnostic, %Diagnostic* %t1558, i64 %t1548
  %t1565 = bitcast %Diagnostic* %t1564 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1565, i8* %t1563, i64 %t1562)
  %t1566 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1567 = ptrtoint { %Diagnostic*, i64 }* %t1566 to i64
  %t1568 = call i8* @malloc(i64 %t1567)
  %t1569 = bitcast i8* %t1568 to { %Diagnostic*, i64 }*
  %t1570 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1569, i32 0, i32 0
  store %Diagnostic* %t1558, %Diagnostic** %t1570
  %t1571 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1569, i32 0, i32 1
  store i64 %t1555, i64* %t1571
  store { %Diagnostic*, i64 }* %t1569, { %Diagnostic*, i64 }** %l12
  %t1572 = load %ScopeResult, %ScopeResult* %l11
  %t1573 = extractvalue %ScopeResult %t1572, 0
  %t1574 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t1573, 0
  %t1575 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l12
  %t1576 = insertvalue %ScopeResult %t1574, { %Diagnostic*, i64 }* %t1575, 1
  ret %ScopeResult %t1576
merge17:
  %t1577 = extractvalue %Statement %statement, 0
  %t1578 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1579 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1580 = icmp eq i32 %t1577, 0
  %t1581 = select i1 %t1580, i8* %t1579, i8* %t1578
  %t1582 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1583 = icmp eq i32 %t1577, 1
  %t1584 = select i1 %t1583, i8* %t1582, i8* %t1581
  %t1585 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1586 = icmp eq i32 %t1577, 2
  %t1587 = select i1 %t1586, i8* %t1585, i8* %t1584
  %t1588 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1589 = icmp eq i32 %t1577, 3
  %t1590 = select i1 %t1589, i8* %t1588, i8* %t1587
  %t1591 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1592 = icmp eq i32 %t1577, 4
  %t1593 = select i1 %t1592, i8* %t1591, i8* %t1590
  %t1594 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1595 = icmp eq i32 %t1577, 5
  %t1596 = select i1 %t1595, i8* %t1594, i8* %t1593
  %t1597 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1598 = icmp eq i32 %t1577, 6
  %t1599 = select i1 %t1598, i8* %t1597, i8* %t1596
  %t1600 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1601 = icmp eq i32 %t1577, 7
  %t1602 = select i1 %t1601, i8* %t1600, i8* %t1599
  %t1603 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1604 = icmp eq i32 %t1577, 8
  %t1605 = select i1 %t1604, i8* %t1603, i8* %t1602
  %t1606 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1607 = icmp eq i32 %t1577, 9
  %t1608 = select i1 %t1607, i8* %t1606, i8* %t1605
  %t1609 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1610 = icmp eq i32 %t1577, 10
  %t1611 = select i1 %t1610, i8* %t1609, i8* %t1608
  %t1612 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1613 = icmp eq i32 %t1577, 11
  %t1614 = select i1 %t1613, i8* %t1612, i8* %t1611
  %t1615 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1616 = icmp eq i32 %t1577, 12
  %t1617 = select i1 %t1616, i8* %t1615, i8* %t1614
  %t1618 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1619 = icmp eq i32 %t1577, 13
  %t1620 = select i1 %t1619, i8* %t1618, i8* %t1617
  %t1621 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1622 = icmp eq i32 %t1577, 14
  %t1623 = select i1 %t1622, i8* %t1621, i8* %t1620
  %t1624 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1625 = icmp eq i32 %t1577, 15
  %t1626 = select i1 %t1625, i8* %t1624, i8* %t1623
  %t1627 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1628 = icmp eq i32 %t1577, 16
  %t1629 = select i1 %t1628, i8* %t1627, i8* %t1626
  %t1630 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1631 = icmp eq i32 %t1577, 17
  %t1632 = select i1 %t1631, i8* %t1630, i8* %t1629
  %t1633 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1634 = icmp eq i32 %t1577, 18
  %t1635 = select i1 %t1634, i8* %t1633, i8* %t1632
  %t1636 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1637 = icmp eq i32 %t1577, 19
  %t1638 = select i1 %t1637, i8* %t1636, i8* %t1635
  %t1639 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1640 = icmp eq i32 %t1577, 20
  %t1641 = select i1 %t1640, i8* %t1639, i8* %t1638
  %t1642 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1643 = icmp eq i32 %t1577, 21
  %t1644 = select i1 %t1643, i8* %t1642, i8* %t1641
  %t1645 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1646 = icmp eq i32 %t1577, 22
  %t1647 = select i1 %t1646, i8* %t1645, i8* %t1644
  %s1648 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h479148896, i32 0, i32 0
  %t1649 = call i1 @strings_equal(i8* %t1647, i8* %s1648)
  br i1 %t1649, label %then18, label %merge19
then18:
  %t1650 = extractvalue %Statement %statement, 0
  %t1651 = alloca %Statement
  store %Statement %statement, %Statement* %t1651
  %t1652 = getelementptr inbounds %Statement, %Statement* %t1651, i32 0, i32 1
  %t1653 = bitcast [88 x i8]* %t1652 to i8*
  %t1654 = bitcast i8* %t1653 to %FunctionSignature*
  %t1655 = load %FunctionSignature, %FunctionSignature* %t1654
  %t1656 = icmp eq i32 %t1650, 4
  %t1657 = select i1 %t1656, %FunctionSignature %t1655, %FunctionSignature zeroinitializer
  %t1658 = getelementptr inbounds %Statement, %Statement* %t1651, i32 0, i32 1
  %t1659 = bitcast [88 x i8]* %t1658 to i8*
  %t1660 = bitcast i8* %t1659 to %FunctionSignature*
  %t1661 = load %FunctionSignature, %FunctionSignature* %t1660
  %t1662 = icmp eq i32 %t1650, 5
  %t1663 = select i1 %t1662, %FunctionSignature %t1661, %FunctionSignature %t1657
  %t1664 = getelementptr inbounds %Statement, %Statement* %t1651, i32 0, i32 1
  %t1665 = bitcast [88 x i8]* %t1664 to i8*
  %t1666 = bitcast i8* %t1665 to %FunctionSignature*
  %t1667 = load %FunctionSignature, %FunctionSignature* %t1666
  %t1668 = icmp eq i32 %t1650, 7
  %t1669 = select i1 %t1668, %FunctionSignature %t1667, %FunctionSignature %t1663
  %t1670 = extractvalue %FunctionSignature %t1669, 0
  %s1671 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h2003786807, i32 0, i32 0
  %t1672 = extractvalue %Statement %statement, 0
  %t1673 = alloca %Statement
  store %Statement %statement, %Statement* %t1673
  %t1674 = getelementptr inbounds %Statement, %Statement* %t1673, i32 0, i32 1
  %t1675 = bitcast [88 x i8]* %t1674 to i8*
  %t1676 = bitcast i8* %t1675 to %FunctionSignature*
  %t1677 = load %FunctionSignature, %FunctionSignature* %t1676
  %t1678 = icmp eq i32 %t1672, 4
  %t1679 = select i1 %t1678, %FunctionSignature %t1677, %FunctionSignature zeroinitializer
  %t1680 = getelementptr inbounds %Statement, %Statement* %t1673, i32 0, i32 1
  %t1681 = bitcast [88 x i8]* %t1680 to i8*
  %t1682 = bitcast i8* %t1681 to %FunctionSignature*
  %t1683 = load %FunctionSignature, %FunctionSignature* %t1682
  %t1684 = icmp eq i32 %t1672, 5
  %t1685 = select i1 %t1684, %FunctionSignature %t1683, %FunctionSignature %t1679
  %t1686 = getelementptr inbounds %Statement, %Statement* %t1673, i32 0, i32 1
  %t1687 = bitcast [88 x i8]* %t1686 to i8*
  %t1688 = bitcast i8* %t1687 to %FunctionSignature*
  %t1689 = load %FunctionSignature, %FunctionSignature* %t1688
  %t1690 = icmp eq i32 %t1672, 7
  %t1691 = select i1 %t1690, %FunctionSignature %t1689, %FunctionSignature %t1685
  %t1692 = extractvalue %FunctionSignature %t1691, 6
  %t1693 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1670, i8* %s1671, %SourceSpan* %t1692)
  store %ScopeResult %t1693, %ScopeResult* %l13
  %t1694 = load %ScopeResult, %ScopeResult* %l13
  %t1695 = extractvalue %ScopeResult %t1694, 1
  store { %Diagnostic*, i64 }* %t1695, { %Diagnostic*, i64 }** %l14
  %t1696 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l14
  %t1697 = extractvalue %Statement %statement, 0
  %t1698 = alloca %Statement
  store %Statement %statement, %Statement* %t1698
  %t1699 = getelementptr inbounds %Statement, %Statement* %t1698, i32 0, i32 1
  %t1700 = bitcast [88 x i8]* %t1699 to i8*
  %t1701 = bitcast i8* %t1700 to %FunctionSignature*
  %t1702 = load %FunctionSignature, %FunctionSignature* %t1701
  %t1703 = icmp eq i32 %t1697, 4
  %t1704 = select i1 %t1703, %FunctionSignature %t1702, %FunctionSignature zeroinitializer
  %t1705 = getelementptr inbounds %Statement, %Statement* %t1698, i32 0, i32 1
  %t1706 = bitcast [88 x i8]* %t1705 to i8*
  %t1707 = bitcast i8* %t1706 to %FunctionSignature*
  %t1708 = load %FunctionSignature, %FunctionSignature* %t1707
  %t1709 = icmp eq i32 %t1697, 5
  %t1710 = select i1 %t1709, %FunctionSignature %t1708, %FunctionSignature %t1704
  %t1711 = getelementptr inbounds %Statement, %Statement* %t1698, i32 0, i32 1
  %t1712 = bitcast [88 x i8]* %t1711 to i8*
  %t1713 = bitcast i8* %t1712 to %FunctionSignature*
  %t1714 = load %FunctionSignature, %FunctionSignature* %t1713
  %t1715 = icmp eq i32 %t1697, 7
  %t1716 = select i1 %t1715, %FunctionSignature %t1714, %FunctionSignature %t1710
  %t1717 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t1716)
  %t1718 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1696, i32 0, i32 0
  %t1719 = load %Diagnostic*, %Diagnostic** %t1718
  %t1720 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1696, i32 0, i32 1
  %t1721 = load i64, i64* %t1720
  %t1722 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1717, i32 0, i32 0
  %t1723 = load %Diagnostic*, %Diagnostic** %t1722
  %t1724 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1717, i32 0, i32 1
  %t1725 = load i64, i64* %t1724
  %t1726 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t1727 = ptrtoint %Diagnostic* %t1726 to i64
  %t1728 = add i64 %t1721, %t1725
  %t1729 = mul i64 %t1727, %t1728
  %t1730 = call noalias i8* @malloc(i64 %t1729)
  %t1731 = bitcast i8* %t1730 to %Diagnostic*
  %t1732 = bitcast %Diagnostic* %t1731 to i8*
  %t1733 = mul i64 %t1727, %t1721
  %t1734 = bitcast %Diagnostic* %t1719 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1732, i8* %t1734, i64 %t1733)
  %t1735 = mul i64 %t1727, %t1725
  %t1736 = bitcast %Diagnostic* %t1723 to i8*
  %t1737 = getelementptr %Diagnostic, %Diagnostic* %t1731, i64 %t1721
  %t1738 = bitcast %Diagnostic* %t1737 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1738, i8* %t1736, i64 %t1735)
  %t1739 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1740 = ptrtoint { %Diagnostic*, i64 }* %t1739 to i64
  %t1741 = call i8* @malloc(i64 %t1740)
  %t1742 = bitcast i8* %t1741 to { %Diagnostic*, i64 }*
  %t1743 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1742, i32 0, i32 0
  store %Diagnostic* %t1731, %Diagnostic** %t1743
  %t1744 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1742, i32 0, i32 1
  store i64 %t1728, i64* %t1744
  store { %Diagnostic*, i64 }* %t1742, { %Diagnostic*, i64 }** %l14
  %t1745 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l14
  %t1746 = extractvalue %Statement %statement, 0
  %t1747 = alloca %Statement
  store %Statement %statement, %Statement* %t1747
  %t1748 = getelementptr inbounds %Statement, %Statement* %t1747, i32 0, i32 1
  %t1749 = bitcast [88 x i8]* %t1748 to i8*
  %t1750 = bitcast i8* %t1749 to %FunctionSignature*
  %t1751 = load %FunctionSignature, %FunctionSignature* %t1750
  %t1752 = icmp eq i32 %t1746, 4
  %t1753 = select i1 %t1752, %FunctionSignature %t1751, %FunctionSignature zeroinitializer
  %t1754 = getelementptr inbounds %Statement, %Statement* %t1747, i32 0, i32 1
  %t1755 = bitcast [88 x i8]* %t1754 to i8*
  %t1756 = bitcast i8* %t1755 to %FunctionSignature*
  %t1757 = load %FunctionSignature, %FunctionSignature* %t1756
  %t1758 = icmp eq i32 %t1746, 5
  %t1759 = select i1 %t1758, %FunctionSignature %t1757, %FunctionSignature %t1753
  %t1760 = getelementptr inbounds %Statement, %Statement* %t1747, i32 0, i32 1
  %t1761 = bitcast [88 x i8]* %t1760 to i8*
  %t1762 = bitcast i8* %t1761 to %FunctionSignature*
  %t1763 = load %FunctionSignature, %FunctionSignature* %t1762
  %t1764 = icmp eq i32 %t1746, 7
  %t1765 = select i1 %t1764, %FunctionSignature %t1763, %FunctionSignature %t1759
  %t1766 = extractvalue %Statement %statement, 0
  %t1767 = alloca %Statement
  store %Statement %statement, %Statement* %t1767
  %t1768 = getelementptr inbounds %Statement, %Statement* %t1767, i32 0, i32 1
  %t1769 = bitcast [88 x i8]* %t1768 to i8*
  %t1770 = getelementptr inbounds i8, i8* %t1769, i64 56
  %t1771 = bitcast i8* %t1770 to %Block*
  %t1772 = load %Block, %Block* %t1771
  %t1773 = icmp eq i32 %t1766, 4
  %t1774 = select i1 %t1773, %Block %t1772, %Block zeroinitializer
  %t1775 = getelementptr inbounds %Statement, %Statement* %t1767, i32 0, i32 1
  %t1776 = bitcast [88 x i8]* %t1775 to i8*
  %t1777 = getelementptr inbounds i8, i8* %t1776, i64 56
  %t1778 = bitcast i8* %t1777 to %Block*
  %t1779 = load %Block, %Block* %t1778
  %t1780 = icmp eq i32 %t1766, 5
  %t1781 = select i1 %t1780, %Block %t1779, %Block %t1774
  %t1782 = getelementptr inbounds %Statement, %Statement* %t1767, i32 0, i32 1
  %t1783 = bitcast [56 x i8]* %t1782 to i8*
  %t1784 = getelementptr inbounds i8, i8* %t1783, i64 16
  %t1785 = bitcast i8* %t1784 to %Block*
  %t1786 = load %Block, %Block* %t1785
  %t1787 = icmp eq i32 %t1766, 6
  %t1788 = select i1 %t1787, %Block %t1786, %Block %t1781
  %t1789 = getelementptr inbounds %Statement, %Statement* %t1767, i32 0, i32 1
  %t1790 = bitcast [88 x i8]* %t1789 to i8*
  %t1791 = getelementptr inbounds i8, i8* %t1790, i64 56
  %t1792 = bitcast i8* %t1791 to %Block*
  %t1793 = load %Block, %Block* %t1792
  %t1794 = icmp eq i32 %t1766, 7
  %t1795 = select i1 %t1794, %Block %t1793, %Block %t1788
  %t1796 = getelementptr inbounds %Statement, %Statement* %t1767, i32 0, i32 1
  %t1797 = bitcast [120 x i8]* %t1796 to i8*
  %t1798 = getelementptr inbounds i8, i8* %t1797, i64 88
  %t1799 = bitcast i8* %t1798 to %Block*
  %t1800 = load %Block, %Block* %t1799
  %t1801 = icmp eq i32 %t1766, 12
  %t1802 = select i1 %t1801, %Block %t1800, %Block %t1795
  %t1803 = getelementptr inbounds %Statement, %Statement* %t1767, i32 0, i32 1
  %t1804 = bitcast [40 x i8]* %t1803 to i8*
  %t1805 = getelementptr inbounds i8, i8* %t1804, i64 8
  %t1806 = bitcast i8* %t1805 to %Block*
  %t1807 = load %Block, %Block* %t1806
  %t1808 = icmp eq i32 %t1766, 13
  %t1809 = select i1 %t1808, %Block %t1807, %Block %t1802
  %t1810 = getelementptr inbounds %Statement, %Statement* %t1767, i32 0, i32 1
  %t1811 = bitcast [136 x i8]* %t1810 to i8*
  %t1812 = getelementptr inbounds i8, i8* %t1811, i64 104
  %t1813 = bitcast i8* %t1812 to %Block*
  %t1814 = load %Block, %Block* %t1813
  %t1815 = icmp eq i32 %t1766, 14
  %t1816 = select i1 %t1815, %Block %t1814, %Block %t1809
  %t1817 = getelementptr inbounds %Statement, %Statement* %t1767, i32 0, i32 1
  %t1818 = bitcast [32 x i8]* %t1817 to i8*
  %t1819 = bitcast i8* %t1818 to %Block*
  %t1820 = load %Block, %Block* %t1819
  %t1821 = icmp eq i32 %t1766, 15
  %t1822 = select i1 %t1821, %Block %t1820, %Block %t1816
  %t1823 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t1765, %Block %t1822, { %Statement*, i64 }* %interfaces)
  %t1824 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1745, i32 0, i32 0
  %t1825 = load %Diagnostic*, %Diagnostic** %t1824
  %t1826 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1745, i32 0, i32 1
  %t1827 = load i64, i64* %t1826
  %t1828 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1823, i32 0, i32 0
  %t1829 = load %Diagnostic*, %Diagnostic** %t1828
  %t1830 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1823, i32 0, i32 1
  %t1831 = load i64, i64* %t1830
  %t1832 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t1833 = ptrtoint %Diagnostic* %t1832 to i64
  %t1834 = add i64 %t1827, %t1831
  %t1835 = mul i64 %t1833, %t1834
  %t1836 = call noalias i8* @malloc(i64 %t1835)
  %t1837 = bitcast i8* %t1836 to %Diagnostic*
  %t1838 = bitcast %Diagnostic* %t1837 to i8*
  %t1839 = mul i64 %t1833, %t1827
  %t1840 = bitcast %Diagnostic* %t1825 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1838, i8* %t1840, i64 %t1839)
  %t1841 = mul i64 %t1833, %t1831
  %t1842 = bitcast %Diagnostic* %t1829 to i8*
  %t1843 = getelementptr %Diagnostic, %Diagnostic* %t1837, i64 %t1827
  %t1844 = bitcast %Diagnostic* %t1843 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t1844, i8* %t1842, i64 %t1841)
  %t1845 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t1846 = ptrtoint { %Diagnostic*, i64 }* %t1845 to i64
  %t1847 = call i8* @malloc(i64 %t1846)
  %t1848 = bitcast i8* %t1847 to { %Diagnostic*, i64 }*
  %t1849 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1848, i32 0, i32 0
  store %Diagnostic* %t1837, %Diagnostic** %t1849
  %t1850 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1848, i32 0, i32 1
  store i64 %t1834, i64* %t1850
  store { %Diagnostic*, i64 }* %t1848, { %Diagnostic*, i64 }** %l14
  %t1851 = load %ScopeResult, %ScopeResult* %l13
  %t1852 = extractvalue %ScopeResult %t1851, 0
  %t1853 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t1852, 0
  %t1854 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l14
  %t1855 = insertvalue %ScopeResult %t1853, { %Diagnostic*, i64 }* %t1854, 1
  ret %ScopeResult %t1855
merge19:
  %t1856 = extractvalue %Statement %statement, 0
  %t1857 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1858 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1859 = icmp eq i32 %t1856, 0
  %t1860 = select i1 %t1859, i8* %t1858, i8* %t1857
  %t1861 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1862 = icmp eq i32 %t1856, 1
  %t1863 = select i1 %t1862, i8* %t1861, i8* %t1860
  %t1864 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1865 = icmp eq i32 %t1856, 2
  %t1866 = select i1 %t1865, i8* %t1864, i8* %t1863
  %t1867 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1868 = icmp eq i32 %t1856, 3
  %t1869 = select i1 %t1868, i8* %t1867, i8* %t1866
  %t1870 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1871 = icmp eq i32 %t1856, 4
  %t1872 = select i1 %t1871, i8* %t1870, i8* %t1869
  %t1873 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1874 = icmp eq i32 %t1856, 5
  %t1875 = select i1 %t1874, i8* %t1873, i8* %t1872
  %t1876 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1877 = icmp eq i32 %t1856, 6
  %t1878 = select i1 %t1877, i8* %t1876, i8* %t1875
  %t1879 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1880 = icmp eq i32 %t1856, 7
  %t1881 = select i1 %t1880, i8* %t1879, i8* %t1878
  %t1882 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1883 = icmp eq i32 %t1856, 8
  %t1884 = select i1 %t1883, i8* %t1882, i8* %t1881
  %t1885 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1886 = icmp eq i32 %t1856, 9
  %t1887 = select i1 %t1886, i8* %t1885, i8* %t1884
  %t1888 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1889 = icmp eq i32 %t1856, 10
  %t1890 = select i1 %t1889, i8* %t1888, i8* %t1887
  %t1891 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1892 = icmp eq i32 %t1856, 11
  %t1893 = select i1 %t1892, i8* %t1891, i8* %t1890
  %t1894 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1895 = icmp eq i32 %t1856, 12
  %t1896 = select i1 %t1895, i8* %t1894, i8* %t1893
  %t1897 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1898 = icmp eq i32 %t1856, 13
  %t1899 = select i1 %t1898, i8* %t1897, i8* %t1896
  %t1900 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1901 = icmp eq i32 %t1856, 14
  %t1902 = select i1 %t1901, i8* %t1900, i8* %t1899
  %t1903 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1904 = icmp eq i32 %t1856, 15
  %t1905 = select i1 %t1904, i8* %t1903, i8* %t1902
  %t1906 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1907 = icmp eq i32 %t1856, 16
  %t1908 = select i1 %t1907, i8* %t1906, i8* %t1905
  %t1909 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1910 = icmp eq i32 %t1856, 17
  %t1911 = select i1 %t1910, i8* %t1909, i8* %t1908
  %t1912 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1913 = icmp eq i32 %t1856, 18
  %t1914 = select i1 %t1913, i8* %t1912, i8* %t1911
  %t1915 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1916 = icmp eq i32 %t1856, 19
  %t1917 = select i1 %t1916, i8* %t1915, i8* %t1914
  %t1918 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1919 = icmp eq i32 %t1856, 20
  %t1920 = select i1 %t1919, i8* %t1918, i8* %t1917
  %t1921 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1922 = icmp eq i32 %t1856, 21
  %t1923 = select i1 %t1922, i8* %t1921, i8* %t1920
  %t1924 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1925 = icmp eq i32 %t1856, 22
  %t1926 = select i1 %t1925, i8* %t1924, i8* %t1923
  %s1927 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h571715647, i32 0, i32 0
  %t1928 = call i1 @strings_equal(i8* %t1926, i8* %s1927)
  br i1 %t1928, label %then20, label %merge21
then20:
  %t1929 = extractvalue %Statement %statement, 0
  %t1930 = alloca %Statement
  store %Statement %statement, %Statement* %t1930
  %t1931 = getelementptr inbounds %Statement, %Statement* %t1930, i32 0, i32 1
  %t1932 = bitcast [88 x i8]* %t1931 to i8*
  %t1933 = bitcast i8* %t1932 to %FunctionSignature*
  %t1934 = load %FunctionSignature, %FunctionSignature* %t1933
  %t1935 = icmp eq i32 %t1929, 4
  %t1936 = select i1 %t1935, %FunctionSignature %t1934, %FunctionSignature zeroinitializer
  %t1937 = getelementptr inbounds %Statement, %Statement* %t1930, i32 0, i32 1
  %t1938 = bitcast [88 x i8]* %t1937 to i8*
  %t1939 = bitcast i8* %t1938 to %FunctionSignature*
  %t1940 = load %FunctionSignature, %FunctionSignature* %t1939
  %t1941 = icmp eq i32 %t1929, 5
  %t1942 = select i1 %t1941, %FunctionSignature %t1940, %FunctionSignature %t1936
  %t1943 = getelementptr inbounds %Statement, %Statement* %t1930, i32 0, i32 1
  %t1944 = bitcast [88 x i8]* %t1943 to i8*
  %t1945 = bitcast i8* %t1944 to %FunctionSignature*
  %t1946 = load %FunctionSignature, %FunctionSignature* %t1945
  %t1947 = icmp eq i32 %t1929, 7
  %t1948 = select i1 %t1947, %FunctionSignature %t1946, %FunctionSignature %t1942
  %t1949 = extractvalue %FunctionSignature %t1948, 0
  %s1950 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275832617, i32 0, i32 0
  %t1951 = extractvalue %Statement %statement, 0
  %t1952 = alloca %Statement
  store %Statement %statement, %Statement* %t1952
  %t1953 = getelementptr inbounds %Statement, %Statement* %t1952, i32 0, i32 1
  %t1954 = bitcast [88 x i8]* %t1953 to i8*
  %t1955 = bitcast i8* %t1954 to %FunctionSignature*
  %t1956 = load %FunctionSignature, %FunctionSignature* %t1955
  %t1957 = icmp eq i32 %t1951, 4
  %t1958 = select i1 %t1957, %FunctionSignature %t1956, %FunctionSignature zeroinitializer
  %t1959 = getelementptr inbounds %Statement, %Statement* %t1952, i32 0, i32 1
  %t1960 = bitcast [88 x i8]* %t1959 to i8*
  %t1961 = bitcast i8* %t1960 to %FunctionSignature*
  %t1962 = load %FunctionSignature, %FunctionSignature* %t1961
  %t1963 = icmp eq i32 %t1951, 5
  %t1964 = select i1 %t1963, %FunctionSignature %t1962, %FunctionSignature %t1958
  %t1965 = getelementptr inbounds %Statement, %Statement* %t1952, i32 0, i32 1
  %t1966 = bitcast [88 x i8]* %t1965 to i8*
  %t1967 = bitcast i8* %t1966 to %FunctionSignature*
  %t1968 = load %FunctionSignature, %FunctionSignature* %t1967
  %t1969 = icmp eq i32 %t1951, 7
  %t1970 = select i1 %t1969, %FunctionSignature %t1968, %FunctionSignature %t1964
  %t1971 = extractvalue %FunctionSignature %t1970, 6
  %t1972 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t1949, i8* %s1950, %SourceSpan* %t1971)
  store %ScopeResult %t1972, %ScopeResult* %l15
  %t1973 = load %ScopeResult, %ScopeResult* %l15
  %t1974 = extractvalue %ScopeResult %t1973, 1
  store { %Diagnostic*, i64 }* %t1974, { %Diagnostic*, i64 }** %l16
  %t1975 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l16
  %t1976 = extractvalue %Statement %statement, 0
  %t1977 = alloca %Statement
  store %Statement %statement, %Statement* %t1977
  %t1978 = getelementptr inbounds %Statement, %Statement* %t1977, i32 0, i32 1
  %t1979 = bitcast [88 x i8]* %t1978 to i8*
  %t1980 = bitcast i8* %t1979 to %FunctionSignature*
  %t1981 = load %FunctionSignature, %FunctionSignature* %t1980
  %t1982 = icmp eq i32 %t1976, 4
  %t1983 = select i1 %t1982, %FunctionSignature %t1981, %FunctionSignature zeroinitializer
  %t1984 = getelementptr inbounds %Statement, %Statement* %t1977, i32 0, i32 1
  %t1985 = bitcast [88 x i8]* %t1984 to i8*
  %t1986 = bitcast i8* %t1985 to %FunctionSignature*
  %t1987 = load %FunctionSignature, %FunctionSignature* %t1986
  %t1988 = icmp eq i32 %t1976, 5
  %t1989 = select i1 %t1988, %FunctionSignature %t1987, %FunctionSignature %t1983
  %t1990 = getelementptr inbounds %Statement, %Statement* %t1977, i32 0, i32 1
  %t1991 = bitcast [88 x i8]* %t1990 to i8*
  %t1992 = bitcast i8* %t1991 to %FunctionSignature*
  %t1993 = load %FunctionSignature, %FunctionSignature* %t1992
  %t1994 = icmp eq i32 %t1976, 7
  %t1995 = select i1 %t1994, %FunctionSignature %t1993, %FunctionSignature %t1989
  %t1996 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t1995)
  %t1997 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1975, i32 0, i32 0
  %t1998 = load %Diagnostic*, %Diagnostic** %t1997
  %t1999 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1975, i32 0, i32 1
  %t2000 = load i64, i64* %t1999
  %t2001 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1996, i32 0, i32 0
  %t2002 = load %Diagnostic*, %Diagnostic** %t2001
  %t2003 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t1996, i32 0, i32 1
  %t2004 = load i64, i64* %t2003
  %t2005 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t2006 = ptrtoint %Diagnostic* %t2005 to i64
  %t2007 = add i64 %t2000, %t2004
  %t2008 = mul i64 %t2006, %t2007
  %t2009 = call noalias i8* @malloc(i64 %t2008)
  %t2010 = bitcast i8* %t2009 to %Diagnostic*
  %t2011 = bitcast %Diagnostic* %t2010 to i8*
  %t2012 = mul i64 %t2006, %t2000
  %t2013 = bitcast %Diagnostic* %t1998 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2011, i8* %t2013, i64 %t2012)
  %t2014 = mul i64 %t2006, %t2004
  %t2015 = bitcast %Diagnostic* %t2002 to i8*
  %t2016 = getelementptr %Diagnostic, %Diagnostic* %t2010, i64 %t2000
  %t2017 = bitcast %Diagnostic* %t2016 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2017, i8* %t2015, i64 %t2014)
  %t2018 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t2019 = ptrtoint { %Diagnostic*, i64 }* %t2018 to i64
  %t2020 = call i8* @malloc(i64 %t2019)
  %t2021 = bitcast i8* %t2020 to { %Diagnostic*, i64 }*
  %t2022 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2021, i32 0, i32 0
  store %Diagnostic* %t2010, %Diagnostic** %t2022
  %t2023 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2021, i32 0, i32 1
  store i64 %t2007, i64* %t2023
  store { %Diagnostic*, i64 }* %t2021, { %Diagnostic*, i64 }** %l16
  %t2024 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l16
  %t2025 = extractvalue %Statement %statement, 0
  %t2026 = alloca %Statement
  store %Statement %statement, %Statement* %t2026
  %t2027 = getelementptr inbounds %Statement, %Statement* %t2026, i32 0, i32 1
  %t2028 = bitcast [88 x i8]* %t2027 to i8*
  %t2029 = bitcast i8* %t2028 to %FunctionSignature*
  %t2030 = load %FunctionSignature, %FunctionSignature* %t2029
  %t2031 = icmp eq i32 %t2025, 4
  %t2032 = select i1 %t2031, %FunctionSignature %t2030, %FunctionSignature zeroinitializer
  %t2033 = getelementptr inbounds %Statement, %Statement* %t2026, i32 0, i32 1
  %t2034 = bitcast [88 x i8]* %t2033 to i8*
  %t2035 = bitcast i8* %t2034 to %FunctionSignature*
  %t2036 = load %FunctionSignature, %FunctionSignature* %t2035
  %t2037 = icmp eq i32 %t2025, 5
  %t2038 = select i1 %t2037, %FunctionSignature %t2036, %FunctionSignature %t2032
  %t2039 = getelementptr inbounds %Statement, %Statement* %t2026, i32 0, i32 1
  %t2040 = bitcast [88 x i8]* %t2039 to i8*
  %t2041 = bitcast i8* %t2040 to %FunctionSignature*
  %t2042 = load %FunctionSignature, %FunctionSignature* %t2041
  %t2043 = icmp eq i32 %t2025, 7
  %t2044 = select i1 %t2043, %FunctionSignature %t2042, %FunctionSignature %t2038
  %t2045 = extractvalue %Statement %statement, 0
  %t2046 = alloca %Statement
  store %Statement %statement, %Statement* %t2046
  %t2047 = getelementptr inbounds %Statement, %Statement* %t2046, i32 0, i32 1
  %t2048 = bitcast [88 x i8]* %t2047 to i8*
  %t2049 = getelementptr inbounds i8, i8* %t2048, i64 56
  %t2050 = bitcast i8* %t2049 to %Block*
  %t2051 = load %Block, %Block* %t2050
  %t2052 = icmp eq i32 %t2045, 4
  %t2053 = select i1 %t2052, %Block %t2051, %Block zeroinitializer
  %t2054 = getelementptr inbounds %Statement, %Statement* %t2046, i32 0, i32 1
  %t2055 = bitcast [88 x i8]* %t2054 to i8*
  %t2056 = getelementptr inbounds i8, i8* %t2055, i64 56
  %t2057 = bitcast i8* %t2056 to %Block*
  %t2058 = load %Block, %Block* %t2057
  %t2059 = icmp eq i32 %t2045, 5
  %t2060 = select i1 %t2059, %Block %t2058, %Block %t2053
  %t2061 = getelementptr inbounds %Statement, %Statement* %t2046, i32 0, i32 1
  %t2062 = bitcast [56 x i8]* %t2061 to i8*
  %t2063 = getelementptr inbounds i8, i8* %t2062, i64 16
  %t2064 = bitcast i8* %t2063 to %Block*
  %t2065 = load %Block, %Block* %t2064
  %t2066 = icmp eq i32 %t2045, 6
  %t2067 = select i1 %t2066, %Block %t2065, %Block %t2060
  %t2068 = getelementptr inbounds %Statement, %Statement* %t2046, i32 0, i32 1
  %t2069 = bitcast [88 x i8]* %t2068 to i8*
  %t2070 = getelementptr inbounds i8, i8* %t2069, i64 56
  %t2071 = bitcast i8* %t2070 to %Block*
  %t2072 = load %Block, %Block* %t2071
  %t2073 = icmp eq i32 %t2045, 7
  %t2074 = select i1 %t2073, %Block %t2072, %Block %t2067
  %t2075 = getelementptr inbounds %Statement, %Statement* %t2046, i32 0, i32 1
  %t2076 = bitcast [120 x i8]* %t2075 to i8*
  %t2077 = getelementptr inbounds i8, i8* %t2076, i64 88
  %t2078 = bitcast i8* %t2077 to %Block*
  %t2079 = load %Block, %Block* %t2078
  %t2080 = icmp eq i32 %t2045, 12
  %t2081 = select i1 %t2080, %Block %t2079, %Block %t2074
  %t2082 = getelementptr inbounds %Statement, %Statement* %t2046, i32 0, i32 1
  %t2083 = bitcast [40 x i8]* %t2082 to i8*
  %t2084 = getelementptr inbounds i8, i8* %t2083, i64 8
  %t2085 = bitcast i8* %t2084 to %Block*
  %t2086 = load %Block, %Block* %t2085
  %t2087 = icmp eq i32 %t2045, 13
  %t2088 = select i1 %t2087, %Block %t2086, %Block %t2081
  %t2089 = getelementptr inbounds %Statement, %Statement* %t2046, i32 0, i32 1
  %t2090 = bitcast [136 x i8]* %t2089 to i8*
  %t2091 = getelementptr inbounds i8, i8* %t2090, i64 104
  %t2092 = bitcast i8* %t2091 to %Block*
  %t2093 = load %Block, %Block* %t2092
  %t2094 = icmp eq i32 %t2045, 14
  %t2095 = select i1 %t2094, %Block %t2093, %Block %t2088
  %t2096 = getelementptr inbounds %Statement, %Statement* %t2046, i32 0, i32 1
  %t2097 = bitcast [32 x i8]* %t2096 to i8*
  %t2098 = bitcast i8* %t2097 to %Block*
  %t2099 = load %Block, %Block* %t2098
  %t2100 = icmp eq i32 %t2045, 15
  %t2101 = select i1 %t2100, %Block %t2099, %Block %t2095
  %t2102 = call { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %t2044, %Block %t2101, { %Statement*, i64 }* %interfaces)
  %t2103 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2024, i32 0, i32 0
  %t2104 = load %Diagnostic*, %Diagnostic** %t2103
  %t2105 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2024, i32 0, i32 1
  %t2106 = load i64, i64* %t2105
  %t2107 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2102, i32 0, i32 0
  %t2108 = load %Diagnostic*, %Diagnostic** %t2107
  %t2109 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2102, i32 0, i32 1
  %t2110 = load i64, i64* %t2109
  %t2111 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t2112 = ptrtoint %Diagnostic* %t2111 to i64
  %t2113 = add i64 %t2106, %t2110
  %t2114 = mul i64 %t2112, %t2113
  %t2115 = call noalias i8* @malloc(i64 %t2114)
  %t2116 = bitcast i8* %t2115 to %Diagnostic*
  %t2117 = bitcast %Diagnostic* %t2116 to i8*
  %t2118 = mul i64 %t2112, %t2106
  %t2119 = bitcast %Diagnostic* %t2104 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2117, i8* %t2119, i64 %t2118)
  %t2120 = mul i64 %t2112, %t2110
  %t2121 = bitcast %Diagnostic* %t2108 to i8*
  %t2122 = getelementptr %Diagnostic, %Diagnostic* %t2116, i64 %t2106
  %t2123 = bitcast %Diagnostic* %t2122 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2123, i8* %t2121, i64 %t2120)
  %t2124 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t2125 = ptrtoint { %Diagnostic*, i64 }* %t2124 to i64
  %t2126 = call i8* @malloc(i64 %t2125)
  %t2127 = bitcast i8* %t2126 to { %Diagnostic*, i64 }*
  %t2128 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2127, i32 0, i32 0
  store %Diagnostic* %t2116, %Diagnostic** %t2128
  %t2129 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2127, i32 0, i32 1
  store i64 %t2113, i64* %t2129
  store { %Diagnostic*, i64 }* %t2127, { %Diagnostic*, i64 }** %l16
  %t2130 = load %ScopeResult, %ScopeResult* %l15
  %t2131 = extractvalue %ScopeResult %t2130, 0
  %t2132 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t2131, 0
  %t2133 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l16
  %t2134 = insertvalue %ScopeResult %t2132, { %Diagnostic*, i64 }* %t2133, 1
  ret %ScopeResult %t2134
merge21:
  %t2135 = extractvalue %Statement %statement, 0
  %t2136 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2137 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2138 = icmp eq i32 %t2135, 0
  %t2139 = select i1 %t2138, i8* %t2137, i8* %t2136
  %t2140 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2141 = icmp eq i32 %t2135, 1
  %t2142 = select i1 %t2141, i8* %t2140, i8* %t2139
  %t2143 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2144 = icmp eq i32 %t2135, 2
  %t2145 = select i1 %t2144, i8* %t2143, i8* %t2142
  %t2146 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2147 = icmp eq i32 %t2135, 3
  %t2148 = select i1 %t2147, i8* %t2146, i8* %t2145
  %t2149 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2150 = icmp eq i32 %t2135, 4
  %t2151 = select i1 %t2150, i8* %t2149, i8* %t2148
  %t2152 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2153 = icmp eq i32 %t2135, 5
  %t2154 = select i1 %t2153, i8* %t2152, i8* %t2151
  %t2155 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2156 = icmp eq i32 %t2135, 6
  %t2157 = select i1 %t2156, i8* %t2155, i8* %t2154
  %t2158 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2159 = icmp eq i32 %t2135, 7
  %t2160 = select i1 %t2159, i8* %t2158, i8* %t2157
  %t2161 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2162 = icmp eq i32 %t2135, 8
  %t2163 = select i1 %t2162, i8* %t2161, i8* %t2160
  %t2164 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2165 = icmp eq i32 %t2135, 9
  %t2166 = select i1 %t2165, i8* %t2164, i8* %t2163
  %t2167 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2168 = icmp eq i32 %t2135, 10
  %t2169 = select i1 %t2168, i8* %t2167, i8* %t2166
  %t2170 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2171 = icmp eq i32 %t2135, 11
  %t2172 = select i1 %t2171, i8* %t2170, i8* %t2169
  %t2173 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2174 = icmp eq i32 %t2135, 12
  %t2175 = select i1 %t2174, i8* %t2173, i8* %t2172
  %t2176 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2177 = icmp eq i32 %t2135, 13
  %t2178 = select i1 %t2177, i8* %t2176, i8* %t2175
  %t2179 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2180 = icmp eq i32 %t2135, 14
  %t2181 = select i1 %t2180, i8* %t2179, i8* %t2178
  %t2182 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2183 = icmp eq i32 %t2135, 15
  %t2184 = select i1 %t2183, i8* %t2182, i8* %t2181
  %t2185 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2186 = icmp eq i32 %t2135, 16
  %t2187 = select i1 %t2186, i8* %t2185, i8* %t2184
  %t2188 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2189 = icmp eq i32 %t2135, 17
  %t2190 = select i1 %t2189, i8* %t2188, i8* %t2187
  %t2191 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2192 = icmp eq i32 %t2135, 18
  %t2193 = select i1 %t2192, i8* %t2191, i8* %t2190
  %t2194 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2195 = icmp eq i32 %t2135, 19
  %t2196 = select i1 %t2195, i8* %t2194, i8* %t2193
  %t2197 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2198 = icmp eq i32 %t2135, 20
  %t2199 = select i1 %t2198, i8* %t2197, i8* %t2196
  %t2200 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2201 = icmp eq i32 %t2135, 21
  %t2202 = select i1 %t2201, i8* %t2200, i8* %t2199
  %t2203 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2204 = icmp eq i32 %t2135, 22
  %t2205 = select i1 %t2204, i8* %t2203, i8* %t2202
  %s2206 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h889179835, i32 0, i32 0
  %t2207 = call i1 @strings_equal(i8* %t2205, i8* %s2206)
  br i1 %t2207, label %then22, label %merge23
then22:
  %t2208 = extractvalue %Statement %statement, 0
  %t2209 = alloca %Statement
  store %Statement %statement, %Statement* %t2209
  %t2210 = getelementptr inbounds %Statement, %Statement* %t2209, i32 0, i32 1
  %t2211 = bitcast [48 x i8]* %t2210 to i8*
  %t2212 = bitcast i8* %t2211 to i8**
  %t2213 = load i8*, i8** %t2212
  %t2214 = icmp eq i32 %t2208, 2
  %t2215 = select i1 %t2214, i8* %t2213, i8* null
  %t2216 = getelementptr inbounds %Statement, %Statement* %t2209, i32 0, i32 1
  %t2217 = bitcast [48 x i8]* %t2216 to i8*
  %t2218 = bitcast i8* %t2217 to i8**
  %t2219 = load i8*, i8** %t2218
  %t2220 = icmp eq i32 %t2208, 3
  %t2221 = select i1 %t2220, i8* %t2219, i8* %t2215
  %t2222 = getelementptr inbounds %Statement, %Statement* %t2209, i32 0, i32 1
  %t2223 = bitcast [56 x i8]* %t2222 to i8*
  %t2224 = bitcast i8* %t2223 to i8**
  %t2225 = load i8*, i8** %t2224
  %t2226 = icmp eq i32 %t2208, 6
  %t2227 = select i1 %t2226, i8* %t2225, i8* %t2221
  %t2228 = getelementptr inbounds %Statement, %Statement* %t2209, i32 0, i32 1
  %t2229 = bitcast [56 x i8]* %t2228 to i8*
  %t2230 = bitcast i8* %t2229 to i8**
  %t2231 = load i8*, i8** %t2230
  %t2232 = icmp eq i32 %t2208, 8
  %t2233 = select i1 %t2232, i8* %t2231, i8* %t2227
  %t2234 = getelementptr inbounds %Statement, %Statement* %t2209, i32 0, i32 1
  %t2235 = bitcast [40 x i8]* %t2234 to i8*
  %t2236 = bitcast i8* %t2235 to i8**
  %t2237 = load i8*, i8** %t2236
  %t2238 = icmp eq i32 %t2208, 9
  %t2239 = select i1 %t2238, i8* %t2237, i8* %t2233
  %t2240 = getelementptr inbounds %Statement, %Statement* %t2209, i32 0, i32 1
  %t2241 = bitcast [40 x i8]* %t2240 to i8*
  %t2242 = bitcast i8* %t2241 to i8**
  %t2243 = load i8*, i8** %t2242
  %t2244 = icmp eq i32 %t2208, 10
  %t2245 = select i1 %t2244, i8* %t2243, i8* %t2239
  %t2246 = getelementptr inbounds %Statement, %Statement* %t2209, i32 0, i32 1
  %t2247 = bitcast [40 x i8]* %t2246 to i8*
  %t2248 = bitcast i8* %t2247 to i8**
  %t2249 = load i8*, i8** %t2248
  %t2250 = icmp eq i32 %t2208, 11
  %t2251 = select i1 %t2250, i8* %t2249, i8* %t2245
  %s2252 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275477867, i32 0, i32 0
  %t2253 = extractvalue %Statement %statement, 0
  %t2254 = alloca %Statement
  store %Statement %statement, %Statement* %t2254
  %t2255 = getelementptr inbounds %Statement, %Statement* %t2254, i32 0, i32 1
  %t2256 = bitcast [48 x i8]* %t2255 to i8*
  %t2257 = getelementptr inbounds i8, i8* %t2256, i64 8
  %t2258 = bitcast i8* %t2257 to %SourceSpan**
  %t2259 = load %SourceSpan*, %SourceSpan** %t2258
  %t2260 = icmp eq i32 %t2253, 3
  %t2261 = select i1 %t2260, %SourceSpan* %t2259, %SourceSpan* null
  %t2262 = getelementptr inbounds %Statement, %Statement* %t2254, i32 0, i32 1
  %t2263 = bitcast [56 x i8]* %t2262 to i8*
  %t2264 = getelementptr inbounds i8, i8* %t2263, i64 8
  %t2265 = bitcast i8* %t2264 to %SourceSpan**
  %t2266 = load %SourceSpan*, %SourceSpan** %t2265
  %t2267 = icmp eq i32 %t2253, 6
  %t2268 = select i1 %t2267, %SourceSpan* %t2266, %SourceSpan* %t2261
  %t2269 = getelementptr inbounds %Statement, %Statement* %t2254, i32 0, i32 1
  %t2270 = bitcast [56 x i8]* %t2269 to i8*
  %t2271 = getelementptr inbounds i8, i8* %t2270, i64 8
  %t2272 = bitcast i8* %t2271 to %SourceSpan**
  %t2273 = load %SourceSpan*, %SourceSpan** %t2272
  %t2274 = icmp eq i32 %t2253, 8
  %t2275 = select i1 %t2274, %SourceSpan* %t2273, %SourceSpan* %t2268
  %t2276 = getelementptr inbounds %Statement, %Statement* %t2254, i32 0, i32 1
  %t2277 = bitcast [40 x i8]* %t2276 to i8*
  %t2278 = getelementptr inbounds i8, i8* %t2277, i64 8
  %t2279 = bitcast i8* %t2278 to %SourceSpan**
  %t2280 = load %SourceSpan*, %SourceSpan** %t2279
  %t2281 = icmp eq i32 %t2253, 9
  %t2282 = select i1 %t2281, %SourceSpan* %t2280, %SourceSpan* %t2275
  %t2283 = getelementptr inbounds %Statement, %Statement* %t2254, i32 0, i32 1
  %t2284 = bitcast [40 x i8]* %t2283 to i8*
  %t2285 = getelementptr inbounds i8, i8* %t2284, i64 8
  %t2286 = bitcast i8* %t2285 to %SourceSpan**
  %t2287 = load %SourceSpan*, %SourceSpan** %t2286
  %t2288 = icmp eq i32 %t2253, 10
  %t2289 = select i1 %t2288, %SourceSpan* %t2287, %SourceSpan* %t2282
  %t2290 = getelementptr inbounds %Statement, %Statement* %t2254, i32 0, i32 1
  %t2291 = bitcast [40 x i8]* %t2290 to i8*
  %t2292 = getelementptr inbounds i8, i8* %t2291, i64 8
  %t2293 = bitcast i8* %t2292 to %SourceSpan**
  %t2294 = load %SourceSpan*, %SourceSpan** %t2293
  %t2295 = icmp eq i32 %t2253, 11
  %t2296 = select i1 %t2295, %SourceSpan* %t2294, %SourceSpan* %t2289
  %t2297 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t2251, i8* %s2252, %SourceSpan* %t2296)
  store %ScopeResult %t2297, %ScopeResult* %l17
  %t2298 = load %ScopeResult, %ScopeResult* %l17
  %t2299 = extractvalue %ScopeResult %t2298, 1
  %t2300 = extractvalue %Statement %statement, 0
  %t2301 = alloca %Statement
  store %Statement %statement, %Statement* %t2301
  %t2302 = getelementptr inbounds %Statement, %Statement* %t2301, i32 0, i32 1
  %t2303 = bitcast [88 x i8]* %t2302 to i8*
  %t2304 = getelementptr inbounds i8, i8* %t2303, i64 56
  %t2305 = bitcast i8* %t2304 to %Block*
  %t2306 = load %Block, %Block* %t2305
  %t2307 = icmp eq i32 %t2300, 4
  %t2308 = select i1 %t2307, %Block %t2306, %Block zeroinitializer
  %t2309 = getelementptr inbounds %Statement, %Statement* %t2301, i32 0, i32 1
  %t2310 = bitcast [88 x i8]* %t2309 to i8*
  %t2311 = getelementptr inbounds i8, i8* %t2310, i64 56
  %t2312 = bitcast i8* %t2311 to %Block*
  %t2313 = load %Block, %Block* %t2312
  %t2314 = icmp eq i32 %t2300, 5
  %t2315 = select i1 %t2314, %Block %t2313, %Block %t2308
  %t2316 = getelementptr inbounds %Statement, %Statement* %t2301, i32 0, i32 1
  %t2317 = bitcast [56 x i8]* %t2316 to i8*
  %t2318 = getelementptr inbounds i8, i8* %t2317, i64 16
  %t2319 = bitcast i8* %t2318 to %Block*
  %t2320 = load %Block, %Block* %t2319
  %t2321 = icmp eq i32 %t2300, 6
  %t2322 = select i1 %t2321, %Block %t2320, %Block %t2315
  %t2323 = getelementptr inbounds %Statement, %Statement* %t2301, i32 0, i32 1
  %t2324 = bitcast [88 x i8]* %t2323 to i8*
  %t2325 = getelementptr inbounds i8, i8* %t2324, i64 56
  %t2326 = bitcast i8* %t2325 to %Block*
  %t2327 = load %Block, %Block* %t2326
  %t2328 = icmp eq i32 %t2300, 7
  %t2329 = select i1 %t2328, %Block %t2327, %Block %t2322
  %t2330 = getelementptr inbounds %Statement, %Statement* %t2301, i32 0, i32 1
  %t2331 = bitcast [120 x i8]* %t2330 to i8*
  %t2332 = getelementptr inbounds i8, i8* %t2331, i64 88
  %t2333 = bitcast i8* %t2332 to %Block*
  %t2334 = load %Block, %Block* %t2333
  %t2335 = icmp eq i32 %t2300, 12
  %t2336 = select i1 %t2335, %Block %t2334, %Block %t2329
  %t2337 = getelementptr inbounds %Statement, %Statement* %t2301, i32 0, i32 1
  %t2338 = bitcast [40 x i8]* %t2337 to i8*
  %t2339 = getelementptr inbounds i8, i8* %t2338, i64 8
  %t2340 = bitcast i8* %t2339 to %Block*
  %t2341 = load %Block, %Block* %t2340
  %t2342 = icmp eq i32 %t2300, 13
  %t2343 = select i1 %t2342, %Block %t2341, %Block %t2336
  %t2344 = getelementptr inbounds %Statement, %Statement* %t2301, i32 0, i32 1
  %t2345 = bitcast [136 x i8]* %t2344 to i8*
  %t2346 = getelementptr inbounds i8, i8* %t2345, i64 104
  %t2347 = bitcast i8* %t2346 to %Block*
  %t2348 = load %Block, %Block* %t2347
  %t2349 = icmp eq i32 %t2300, 14
  %t2350 = select i1 %t2349, %Block %t2348, %Block %t2343
  %t2351 = getelementptr inbounds %Statement, %Statement* %t2301, i32 0, i32 1
  %t2352 = bitcast [32 x i8]* %t2351 to i8*
  %t2353 = bitcast i8* %t2352 to %Block*
  %t2354 = load %Block, %Block* %t2353
  %t2355 = icmp eq i32 %t2300, 15
  %t2356 = select i1 %t2355, %Block %t2354, %Block %t2350
  %t2357 = getelementptr [0 x %SymbolEntry], [0 x %SymbolEntry]* null, i32 1
  %t2358 = ptrtoint [0 x %SymbolEntry]* %t2357 to i64
  %t2359 = icmp eq i64 %t2358, 0
  %t2360 = select i1 %t2359, i64 1, i64 %t2358
  %t2361 = call i8* @malloc(i64 %t2360)
  %t2362 = bitcast i8* %t2361 to %SymbolEntry*
  %t2363 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* null, i32 1
  %t2364 = ptrtoint { %SymbolEntry*, i64 }* %t2363 to i64
  %t2365 = call i8* @malloc(i64 %t2364)
  %t2366 = bitcast i8* %t2365 to { %SymbolEntry*, i64 }*
  %t2367 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t2366, i32 0, i32 0
  store %SymbolEntry* %t2362, %SymbolEntry** %t2367
  %t2368 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t2366, i32 0, i32 1
  store i64 0, i64* %t2368
  %t2369 = call { %Diagnostic*, i64 }* @check_block(%Block %t2356, { %SymbolEntry*, i64 }* %t2366, { %Statement*, i64 }* %interfaces)
  %t2370 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2299, i32 0, i32 0
  %t2371 = load %Diagnostic*, %Diagnostic** %t2370
  %t2372 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2299, i32 0, i32 1
  %t2373 = load i64, i64* %t2372
  %t2374 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2369, i32 0, i32 0
  %t2375 = load %Diagnostic*, %Diagnostic** %t2374
  %t2376 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2369, i32 0, i32 1
  %t2377 = load i64, i64* %t2376
  %t2378 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t2379 = ptrtoint %Diagnostic* %t2378 to i64
  %t2380 = add i64 %t2373, %t2377
  %t2381 = mul i64 %t2379, %t2380
  %t2382 = call noalias i8* @malloc(i64 %t2381)
  %t2383 = bitcast i8* %t2382 to %Diagnostic*
  %t2384 = bitcast %Diagnostic* %t2383 to i8*
  %t2385 = mul i64 %t2379, %t2373
  %t2386 = bitcast %Diagnostic* %t2371 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2384, i8* %t2386, i64 %t2385)
  %t2387 = mul i64 %t2379, %t2377
  %t2388 = bitcast %Diagnostic* %t2375 to i8*
  %t2389 = getelementptr %Diagnostic, %Diagnostic* %t2383, i64 %t2373
  %t2390 = bitcast %Diagnostic* %t2389 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2390, i8* %t2388, i64 %t2387)
  %t2391 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t2392 = ptrtoint { %Diagnostic*, i64 }* %t2391 to i64
  %t2393 = call i8* @malloc(i64 %t2392)
  %t2394 = bitcast i8* %t2393 to { %Diagnostic*, i64 }*
  %t2395 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2394, i32 0, i32 0
  store %Diagnostic* %t2383, %Diagnostic** %t2395
  %t2396 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2394, i32 0, i32 1
  store i64 %t2380, i64* %t2396
  store { %Diagnostic*, i64 }* %t2394, { %Diagnostic*, i64 }** %l18
  %t2397 = load %ScopeResult, %ScopeResult* %l17
  %t2398 = extractvalue %ScopeResult %t2397, 0
  %t2399 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t2398, 0
  %t2400 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l18
  %t2401 = insertvalue %ScopeResult %t2399, { %Diagnostic*, i64 }* %t2400, 1
  ret %ScopeResult %t2401
merge23:
  %t2402 = extractvalue %Statement %statement, 0
  %t2403 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2404 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2405 = icmp eq i32 %t2402, 0
  %t2406 = select i1 %t2405, i8* %t2404, i8* %t2403
  %t2407 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2408 = icmp eq i32 %t2402, 1
  %t2409 = select i1 %t2408, i8* %t2407, i8* %t2406
  %t2410 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2411 = icmp eq i32 %t2402, 2
  %t2412 = select i1 %t2411, i8* %t2410, i8* %t2409
  %t2413 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2414 = icmp eq i32 %t2402, 3
  %t2415 = select i1 %t2414, i8* %t2413, i8* %t2412
  %t2416 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2417 = icmp eq i32 %t2402, 4
  %t2418 = select i1 %t2417, i8* %t2416, i8* %t2415
  %t2419 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2420 = icmp eq i32 %t2402, 5
  %t2421 = select i1 %t2420, i8* %t2419, i8* %t2418
  %t2422 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2423 = icmp eq i32 %t2402, 6
  %t2424 = select i1 %t2423, i8* %t2422, i8* %t2421
  %t2425 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2426 = icmp eq i32 %t2402, 7
  %t2427 = select i1 %t2426, i8* %t2425, i8* %t2424
  %t2428 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2429 = icmp eq i32 %t2402, 8
  %t2430 = select i1 %t2429, i8* %t2428, i8* %t2427
  %t2431 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2432 = icmp eq i32 %t2402, 9
  %t2433 = select i1 %t2432, i8* %t2431, i8* %t2430
  %t2434 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2435 = icmp eq i32 %t2402, 10
  %t2436 = select i1 %t2435, i8* %t2434, i8* %t2433
  %t2437 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2438 = icmp eq i32 %t2402, 11
  %t2439 = select i1 %t2438, i8* %t2437, i8* %t2436
  %t2440 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2441 = icmp eq i32 %t2402, 12
  %t2442 = select i1 %t2441, i8* %t2440, i8* %t2439
  %t2443 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2444 = icmp eq i32 %t2402, 13
  %t2445 = select i1 %t2444, i8* %t2443, i8* %t2442
  %t2446 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2447 = icmp eq i32 %t2402, 14
  %t2448 = select i1 %t2447, i8* %t2446, i8* %t2445
  %t2449 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2450 = icmp eq i32 %t2402, 15
  %t2451 = select i1 %t2450, i8* %t2449, i8* %t2448
  %t2452 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2453 = icmp eq i32 %t2402, 16
  %t2454 = select i1 %t2453, i8* %t2452, i8* %t2451
  %t2455 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2456 = icmp eq i32 %t2402, 17
  %t2457 = select i1 %t2456, i8* %t2455, i8* %t2454
  %t2458 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2459 = icmp eq i32 %t2402, 18
  %t2460 = select i1 %t2459, i8* %t2458, i8* %t2457
  %t2461 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2462 = icmp eq i32 %t2402, 19
  %t2463 = select i1 %t2462, i8* %t2461, i8* %t2460
  %t2464 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2465 = icmp eq i32 %t2402, 20
  %t2466 = select i1 %t2465, i8* %t2464, i8* %t2463
  %t2467 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2468 = icmp eq i32 %t2402, 21
  %t2469 = select i1 %t2468, i8* %t2467, i8* %t2466
  %t2470 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2471 = icmp eq i32 %t2402, 22
  %t2472 = select i1 %t2471, i8* %t2470, i8* %t2469
  %s2473 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1925822000, i32 0, i32 0
  %t2474 = call i1 @strings_equal(i8* %t2472, i8* %s2473)
  br i1 %t2474, label %then24, label %merge25
then24:
  %t2475 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %bindings, 0
  %t2476 = extractvalue %Statement %statement, 0
  %t2477 = alloca %Statement
  store %Statement %statement, %Statement* %t2477
  %t2478 = getelementptr inbounds %Statement, %Statement* %t2477, i32 0, i32 1
  %t2479 = bitcast [88 x i8]* %t2478 to i8*
  %t2480 = getelementptr inbounds i8, i8* %t2479, i64 56
  %t2481 = bitcast i8* %t2480 to %Block*
  %t2482 = load %Block, %Block* %t2481
  %t2483 = icmp eq i32 %t2476, 4
  %t2484 = select i1 %t2483, %Block %t2482, %Block zeroinitializer
  %t2485 = getelementptr inbounds %Statement, %Statement* %t2477, i32 0, i32 1
  %t2486 = bitcast [88 x i8]* %t2485 to i8*
  %t2487 = getelementptr inbounds i8, i8* %t2486, i64 56
  %t2488 = bitcast i8* %t2487 to %Block*
  %t2489 = load %Block, %Block* %t2488
  %t2490 = icmp eq i32 %t2476, 5
  %t2491 = select i1 %t2490, %Block %t2489, %Block %t2484
  %t2492 = getelementptr inbounds %Statement, %Statement* %t2477, i32 0, i32 1
  %t2493 = bitcast [56 x i8]* %t2492 to i8*
  %t2494 = getelementptr inbounds i8, i8* %t2493, i64 16
  %t2495 = bitcast i8* %t2494 to %Block*
  %t2496 = load %Block, %Block* %t2495
  %t2497 = icmp eq i32 %t2476, 6
  %t2498 = select i1 %t2497, %Block %t2496, %Block %t2491
  %t2499 = getelementptr inbounds %Statement, %Statement* %t2477, i32 0, i32 1
  %t2500 = bitcast [88 x i8]* %t2499 to i8*
  %t2501 = getelementptr inbounds i8, i8* %t2500, i64 56
  %t2502 = bitcast i8* %t2501 to %Block*
  %t2503 = load %Block, %Block* %t2502
  %t2504 = icmp eq i32 %t2476, 7
  %t2505 = select i1 %t2504, %Block %t2503, %Block %t2498
  %t2506 = getelementptr inbounds %Statement, %Statement* %t2477, i32 0, i32 1
  %t2507 = bitcast [120 x i8]* %t2506 to i8*
  %t2508 = getelementptr inbounds i8, i8* %t2507, i64 88
  %t2509 = bitcast i8* %t2508 to %Block*
  %t2510 = load %Block, %Block* %t2509
  %t2511 = icmp eq i32 %t2476, 12
  %t2512 = select i1 %t2511, %Block %t2510, %Block %t2505
  %t2513 = getelementptr inbounds %Statement, %Statement* %t2477, i32 0, i32 1
  %t2514 = bitcast [40 x i8]* %t2513 to i8*
  %t2515 = getelementptr inbounds i8, i8* %t2514, i64 8
  %t2516 = bitcast i8* %t2515 to %Block*
  %t2517 = load %Block, %Block* %t2516
  %t2518 = icmp eq i32 %t2476, 13
  %t2519 = select i1 %t2518, %Block %t2517, %Block %t2512
  %t2520 = getelementptr inbounds %Statement, %Statement* %t2477, i32 0, i32 1
  %t2521 = bitcast [136 x i8]* %t2520 to i8*
  %t2522 = getelementptr inbounds i8, i8* %t2521, i64 104
  %t2523 = bitcast i8* %t2522 to %Block*
  %t2524 = load %Block, %Block* %t2523
  %t2525 = icmp eq i32 %t2476, 14
  %t2526 = select i1 %t2525, %Block %t2524, %Block %t2519
  %t2527 = getelementptr inbounds %Statement, %Statement* %t2477, i32 0, i32 1
  %t2528 = bitcast [32 x i8]* %t2527 to i8*
  %t2529 = bitcast i8* %t2528 to %Block*
  %t2530 = load %Block, %Block* %t2529
  %t2531 = icmp eq i32 %t2476, 15
  %t2532 = select i1 %t2531, %Block %t2530, %Block %t2526
  %t2533 = call { %Diagnostic*, i64 }* @check_block(%Block %t2532, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2534 = insertvalue %ScopeResult %t2475, { %Diagnostic*, i64 }* %t2533, 1
  ret %ScopeResult %t2534
merge25:
  %t2535 = extractvalue %Statement %statement, 0
  %t2536 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2537 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2538 = icmp eq i32 %t2535, 0
  %t2539 = select i1 %t2538, i8* %t2537, i8* %t2536
  %t2540 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2541 = icmp eq i32 %t2535, 1
  %t2542 = select i1 %t2541, i8* %t2540, i8* %t2539
  %t2543 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2544 = icmp eq i32 %t2535, 2
  %t2545 = select i1 %t2544, i8* %t2543, i8* %t2542
  %t2546 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2547 = icmp eq i32 %t2535, 3
  %t2548 = select i1 %t2547, i8* %t2546, i8* %t2545
  %t2549 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2550 = icmp eq i32 %t2535, 4
  %t2551 = select i1 %t2550, i8* %t2549, i8* %t2548
  %t2552 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2553 = icmp eq i32 %t2535, 5
  %t2554 = select i1 %t2553, i8* %t2552, i8* %t2551
  %t2555 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2556 = icmp eq i32 %t2535, 6
  %t2557 = select i1 %t2556, i8* %t2555, i8* %t2554
  %t2558 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2559 = icmp eq i32 %t2535, 7
  %t2560 = select i1 %t2559, i8* %t2558, i8* %t2557
  %t2561 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2562 = icmp eq i32 %t2535, 8
  %t2563 = select i1 %t2562, i8* %t2561, i8* %t2560
  %t2564 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2565 = icmp eq i32 %t2535, 9
  %t2566 = select i1 %t2565, i8* %t2564, i8* %t2563
  %t2567 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2568 = icmp eq i32 %t2535, 10
  %t2569 = select i1 %t2568, i8* %t2567, i8* %t2566
  %t2570 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2571 = icmp eq i32 %t2535, 11
  %t2572 = select i1 %t2571, i8* %t2570, i8* %t2569
  %t2573 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2574 = icmp eq i32 %t2535, 12
  %t2575 = select i1 %t2574, i8* %t2573, i8* %t2572
  %t2576 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2577 = icmp eq i32 %t2535, 13
  %t2578 = select i1 %t2577, i8* %t2576, i8* %t2575
  %t2579 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2580 = icmp eq i32 %t2535, 14
  %t2581 = select i1 %t2580, i8* %t2579, i8* %t2578
  %t2582 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2583 = icmp eq i32 %t2535, 15
  %t2584 = select i1 %t2583, i8* %t2582, i8* %t2581
  %t2585 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2586 = icmp eq i32 %t2535, 16
  %t2587 = select i1 %t2586, i8* %t2585, i8* %t2584
  %t2588 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2589 = icmp eq i32 %t2535, 17
  %t2590 = select i1 %t2589, i8* %t2588, i8* %t2587
  %t2591 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2592 = icmp eq i32 %t2535, 18
  %t2593 = select i1 %t2592, i8* %t2591, i8* %t2590
  %t2594 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2595 = icmp eq i32 %t2535, 19
  %t2596 = select i1 %t2595, i8* %t2594, i8* %t2593
  %t2597 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2598 = icmp eq i32 %t2535, 20
  %t2599 = select i1 %t2598, i8* %t2597, i8* %t2596
  %t2600 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2601 = icmp eq i32 %t2535, 21
  %t2602 = select i1 %t2601, i8* %t2600, i8* %t2599
  %t2603 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2604 = icmp eq i32 %t2535, 22
  %t2605 = select i1 %t2604, i8* %t2603, i8* %t2602
  %s2606 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h84042670, i32 0, i32 0
  %t2607 = call i1 @strings_equal(i8* %t2605, i8* %s2606)
  br i1 %t2607, label %then26, label %merge27
then26:
  %t2608 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %bindings, 0
  %t2609 = extractvalue %Statement %statement, 0
  %t2610 = alloca %Statement
  store %Statement %statement, %Statement* %t2610
  %t2611 = getelementptr inbounds %Statement, %Statement* %t2610, i32 0, i32 1
  %t2612 = bitcast [88 x i8]* %t2611 to i8*
  %t2613 = getelementptr inbounds i8, i8* %t2612, i64 56
  %t2614 = bitcast i8* %t2613 to %Block*
  %t2615 = load %Block, %Block* %t2614
  %t2616 = icmp eq i32 %t2609, 4
  %t2617 = select i1 %t2616, %Block %t2615, %Block zeroinitializer
  %t2618 = getelementptr inbounds %Statement, %Statement* %t2610, i32 0, i32 1
  %t2619 = bitcast [88 x i8]* %t2618 to i8*
  %t2620 = getelementptr inbounds i8, i8* %t2619, i64 56
  %t2621 = bitcast i8* %t2620 to %Block*
  %t2622 = load %Block, %Block* %t2621
  %t2623 = icmp eq i32 %t2609, 5
  %t2624 = select i1 %t2623, %Block %t2622, %Block %t2617
  %t2625 = getelementptr inbounds %Statement, %Statement* %t2610, i32 0, i32 1
  %t2626 = bitcast [56 x i8]* %t2625 to i8*
  %t2627 = getelementptr inbounds i8, i8* %t2626, i64 16
  %t2628 = bitcast i8* %t2627 to %Block*
  %t2629 = load %Block, %Block* %t2628
  %t2630 = icmp eq i32 %t2609, 6
  %t2631 = select i1 %t2630, %Block %t2629, %Block %t2624
  %t2632 = getelementptr inbounds %Statement, %Statement* %t2610, i32 0, i32 1
  %t2633 = bitcast [88 x i8]* %t2632 to i8*
  %t2634 = getelementptr inbounds i8, i8* %t2633, i64 56
  %t2635 = bitcast i8* %t2634 to %Block*
  %t2636 = load %Block, %Block* %t2635
  %t2637 = icmp eq i32 %t2609, 7
  %t2638 = select i1 %t2637, %Block %t2636, %Block %t2631
  %t2639 = getelementptr inbounds %Statement, %Statement* %t2610, i32 0, i32 1
  %t2640 = bitcast [120 x i8]* %t2639 to i8*
  %t2641 = getelementptr inbounds i8, i8* %t2640, i64 88
  %t2642 = bitcast i8* %t2641 to %Block*
  %t2643 = load %Block, %Block* %t2642
  %t2644 = icmp eq i32 %t2609, 12
  %t2645 = select i1 %t2644, %Block %t2643, %Block %t2638
  %t2646 = getelementptr inbounds %Statement, %Statement* %t2610, i32 0, i32 1
  %t2647 = bitcast [40 x i8]* %t2646 to i8*
  %t2648 = getelementptr inbounds i8, i8* %t2647, i64 8
  %t2649 = bitcast i8* %t2648 to %Block*
  %t2650 = load %Block, %Block* %t2649
  %t2651 = icmp eq i32 %t2609, 13
  %t2652 = select i1 %t2651, %Block %t2650, %Block %t2645
  %t2653 = getelementptr inbounds %Statement, %Statement* %t2610, i32 0, i32 1
  %t2654 = bitcast [136 x i8]* %t2653 to i8*
  %t2655 = getelementptr inbounds i8, i8* %t2654, i64 104
  %t2656 = bitcast i8* %t2655 to %Block*
  %t2657 = load %Block, %Block* %t2656
  %t2658 = icmp eq i32 %t2609, 14
  %t2659 = select i1 %t2658, %Block %t2657, %Block %t2652
  %t2660 = getelementptr inbounds %Statement, %Statement* %t2610, i32 0, i32 1
  %t2661 = bitcast [32 x i8]* %t2660 to i8*
  %t2662 = bitcast i8* %t2661 to %Block*
  %t2663 = load %Block, %Block* %t2662
  %t2664 = icmp eq i32 %t2609, 15
  %t2665 = select i1 %t2664, %Block %t2663, %Block %t2659
  %t2666 = call { %Diagnostic*, i64 }* @check_block(%Block %t2665, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2667 = insertvalue %ScopeResult %t2608, { %Diagnostic*, i64 }* %t2666, 1
  ret %ScopeResult %t2667
merge27:
  %t2668 = extractvalue %Statement %statement, 0
  %t2669 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2670 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2671 = icmp eq i32 %t2668, 0
  %t2672 = select i1 %t2671, i8* %t2670, i8* %t2669
  %t2673 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2674 = icmp eq i32 %t2668, 1
  %t2675 = select i1 %t2674, i8* %t2673, i8* %t2672
  %t2676 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2677 = icmp eq i32 %t2668, 2
  %t2678 = select i1 %t2677, i8* %t2676, i8* %t2675
  %t2679 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2680 = icmp eq i32 %t2668, 3
  %t2681 = select i1 %t2680, i8* %t2679, i8* %t2678
  %t2682 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2683 = icmp eq i32 %t2668, 4
  %t2684 = select i1 %t2683, i8* %t2682, i8* %t2681
  %t2685 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2686 = icmp eq i32 %t2668, 5
  %t2687 = select i1 %t2686, i8* %t2685, i8* %t2684
  %t2688 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2689 = icmp eq i32 %t2668, 6
  %t2690 = select i1 %t2689, i8* %t2688, i8* %t2687
  %t2691 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2692 = icmp eq i32 %t2668, 7
  %t2693 = select i1 %t2692, i8* %t2691, i8* %t2690
  %t2694 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2695 = icmp eq i32 %t2668, 8
  %t2696 = select i1 %t2695, i8* %t2694, i8* %t2693
  %t2697 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2698 = icmp eq i32 %t2668, 9
  %t2699 = select i1 %t2698, i8* %t2697, i8* %t2696
  %t2700 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2701 = icmp eq i32 %t2668, 10
  %t2702 = select i1 %t2701, i8* %t2700, i8* %t2699
  %t2703 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2704 = icmp eq i32 %t2668, 11
  %t2705 = select i1 %t2704, i8* %t2703, i8* %t2702
  %t2706 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2707 = icmp eq i32 %t2668, 12
  %t2708 = select i1 %t2707, i8* %t2706, i8* %t2705
  %t2709 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2710 = icmp eq i32 %t2668, 13
  %t2711 = select i1 %t2710, i8* %t2709, i8* %t2708
  %t2712 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2713 = icmp eq i32 %t2668, 14
  %t2714 = select i1 %t2713, i8* %t2712, i8* %t2711
  %t2715 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2716 = icmp eq i32 %t2668, 15
  %t2717 = select i1 %t2716, i8* %t2715, i8* %t2714
  %t2718 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2719 = icmp eq i32 %t2668, 16
  %t2720 = select i1 %t2719, i8* %t2718, i8* %t2717
  %t2721 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2722 = icmp eq i32 %t2668, 17
  %t2723 = select i1 %t2722, i8* %t2721, i8* %t2720
  %t2724 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2725 = icmp eq i32 %t2668, 18
  %t2726 = select i1 %t2725, i8* %t2724, i8* %t2723
  %t2727 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2728 = icmp eq i32 %t2668, 19
  %t2729 = select i1 %t2728, i8* %t2727, i8* %t2726
  %t2730 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2731 = icmp eq i32 %t2668, 20
  %t2732 = select i1 %t2731, i8* %t2730, i8* %t2729
  %t2733 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2734 = icmp eq i32 %t2668, 21
  %t2735 = select i1 %t2734, i8* %t2733, i8* %t2732
  %t2736 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2737 = icmp eq i32 %t2668, 22
  %t2738 = select i1 %t2737, i8* %t2736, i8* %t2735
  %s2739 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h196308685, i32 0, i32 0
  %t2740 = call i1 @strings_equal(i8* %t2738, i8* %s2739)
  br i1 %t2740, label %then28, label %merge29
then28:
  %t2741 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t2742 = ptrtoint [0 x %Diagnostic]* %t2741 to i64
  %t2743 = icmp eq i64 %t2742, 0
  %t2744 = select i1 %t2743, i64 1, i64 %t2742
  %t2745 = call i8* @malloc(i64 %t2744)
  %t2746 = bitcast i8* %t2745 to %Diagnostic*
  %t2747 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t2748 = ptrtoint { %Diagnostic*, i64 }* %t2747 to i64
  %t2749 = call i8* @malloc(i64 %t2748)
  %t2750 = bitcast i8* %t2749 to { %Diagnostic*, i64 }*
  %t2751 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2750, i32 0, i32 0
  store %Diagnostic* %t2746, %Diagnostic** %t2751
  %t2752 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2750, i32 0, i32 1
  store i64 0, i64* %t2752
  store { %Diagnostic*, i64 }* %t2750, { %Diagnostic*, i64 }** %l19
  %t2753 = sitofp i64 0 to double
  store double %t2753, double* %l20
  %t2754 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2755 = load double, double* %l20
  br label %loop.header30
loop.header30:
  %t2826 = phi { %Diagnostic*, i64 }* [ %t2754, %then28 ], [ %t2824, %loop.latch32 ]
  %t2827 = phi double [ %t2755, %then28 ], [ %t2825, %loop.latch32 ]
  store { %Diagnostic*, i64 }* %t2826, { %Diagnostic*, i64 }** %l19
  store double %t2827, double* %l20
  br label %loop.body31
loop.body31:
  %t2756 = load double, double* %l20
  %t2757 = extractvalue %Statement %statement, 0
  %t2758 = alloca %Statement
  store %Statement %statement, %Statement* %t2758
  %t2759 = getelementptr inbounds %Statement, %Statement* %t2758, i32 0, i32 1
  %t2760 = bitcast [64 x i8]* %t2759 to i8*
  %t2761 = getelementptr inbounds i8, i8* %t2760, i64 48
  %t2762 = bitcast i8* %t2761 to { %MatchCase*, i64 }**
  %t2763 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %t2762
  %t2764 = icmp eq i32 %t2757, 18
  %t2765 = select i1 %t2764, { %MatchCase*, i64 }* %t2763, { %MatchCase*, i64 }* null
  %t2766 = load { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t2765
  %t2767 = extractvalue { %MatchCase*, i64 } %t2766, 1
  %t2768 = sitofp i64 %t2767 to double
  %t2769 = fcmp oge double %t2756, %t2768
  %t2770 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2771 = load double, double* %l20
  br i1 %t2769, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t2772 = extractvalue %Statement %statement, 0
  %t2773 = alloca %Statement
  store %Statement %statement, %Statement* %t2773
  %t2774 = getelementptr inbounds %Statement, %Statement* %t2773, i32 0, i32 1
  %t2775 = bitcast [64 x i8]* %t2774 to i8*
  %t2776 = getelementptr inbounds i8, i8* %t2775, i64 48
  %t2777 = bitcast i8* %t2776 to { %MatchCase*, i64 }**
  %t2778 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %t2777
  %t2779 = icmp eq i32 %t2772, 18
  %t2780 = select i1 %t2779, { %MatchCase*, i64 }* %t2778, { %MatchCase*, i64 }* null
  %t2781 = load double, double* %l20
  %t2782 = call double @llvm.round.f64(double %t2781)
  %t2783 = fptosi double %t2782 to i64
  %t2784 = load { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t2780
  %t2785 = extractvalue { %MatchCase*, i64 } %t2784, 0
  %t2786 = extractvalue { %MatchCase*, i64 } %t2784, 1
  %t2787 = icmp uge i64 %t2783, %t2786
  ; bounds check: %t2787 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t2783, i64 %t2786)
  %t2788 = getelementptr %MatchCase, %MatchCase* %t2785, i64 %t2783
  %t2789 = load %MatchCase, %MatchCase* %t2788
  store %MatchCase %t2789, %MatchCase* %l21
  %t2790 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2791 = load %MatchCase, %MatchCase* %l21
  %t2792 = extractvalue %MatchCase %t2791, 2
  %t2793 = call { %Diagnostic*, i64 }* @check_block(%Block %t2792, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2794 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2790, i32 0, i32 0
  %t2795 = load %Diagnostic*, %Diagnostic** %t2794
  %t2796 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2790, i32 0, i32 1
  %t2797 = load i64, i64* %t2796
  %t2798 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2793, i32 0, i32 0
  %t2799 = load %Diagnostic*, %Diagnostic** %t2798
  %t2800 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2793, i32 0, i32 1
  %t2801 = load i64, i64* %t2800
  %t2802 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t2803 = ptrtoint %Diagnostic* %t2802 to i64
  %t2804 = add i64 %t2797, %t2801
  %t2805 = mul i64 %t2803, %t2804
  %t2806 = call noalias i8* @malloc(i64 %t2805)
  %t2807 = bitcast i8* %t2806 to %Diagnostic*
  %t2808 = bitcast %Diagnostic* %t2807 to i8*
  %t2809 = mul i64 %t2803, %t2797
  %t2810 = bitcast %Diagnostic* %t2795 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2808, i8* %t2810, i64 %t2809)
  %t2811 = mul i64 %t2803, %t2801
  %t2812 = bitcast %Diagnostic* %t2799 to i8*
  %t2813 = getelementptr %Diagnostic, %Diagnostic* %t2807, i64 %t2797
  %t2814 = bitcast %Diagnostic* %t2813 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2814, i8* %t2812, i64 %t2811)
  %t2815 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t2816 = ptrtoint { %Diagnostic*, i64 }* %t2815 to i64
  %t2817 = call i8* @malloc(i64 %t2816)
  %t2818 = bitcast i8* %t2817 to { %Diagnostic*, i64 }*
  %t2819 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2818, i32 0, i32 0
  store %Diagnostic* %t2807, %Diagnostic** %t2819
  %t2820 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2818, i32 0, i32 1
  store i64 %t2804, i64* %t2820
  store { %Diagnostic*, i64 }* %t2818, { %Diagnostic*, i64 }** %l19
  %t2821 = load double, double* %l20
  %t2822 = sitofp i64 1 to double
  %t2823 = fadd double %t2821, %t2822
  store double %t2823, double* %l20
  br label %loop.latch32
loop.latch32:
  %t2824 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2825 = load double, double* %l20
  br label %loop.header30
afterloop33:
  %t2828 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2829 = load double, double* %l20
  %t2830 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %bindings, 0
  %t2831 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l19
  %t2832 = insertvalue %ScopeResult %t2830, { %Diagnostic*, i64 }* %t2831, 1
  ret %ScopeResult %t2832
merge29:
  %t2833 = extractvalue %Statement %statement, 0
  %t2834 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2835 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2836 = icmp eq i32 %t2833, 0
  %t2837 = select i1 %t2836, i8* %t2835, i8* %t2834
  %t2838 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2839 = icmp eq i32 %t2833, 1
  %t2840 = select i1 %t2839, i8* %t2838, i8* %t2837
  %t2841 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2842 = icmp eq i32 %t2833, 2
  %t2843 = select i1 %t2842, i8* %t2841, i8* %t2840
  %t2844 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2845 = icmp eq i32 %t2833, 3
  %t2846 = select i1 %t2845, i8* %t2844, i8* %t2843
  %t2847 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2848 = icmp eq i32 %t2833, 4
  %t2849 = select i1 %t2848, i8* %t2847, i8* %t2846
  %t2850 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2851 = icmp eq i32 %t2833, 5
  %t2852 = select i1 %t2851, i8* %t2850, i8* %t2849
  %t2853 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2854 = icmp eq i32 %t2833, 6
  %t2855 = select i1 %t2854, i8* %t2853, i8* %t2852
  %t2856 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2857 = icmp eq i32 %t2833, 7
  %t2858 = select i1 %t2857, i8* %t2856, i8* %t2855
  %t2859 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2860 = icmp eq i32 %t2833, 8
  %t2861 = select i1 %t2860, i8* %t2859, i8* %t2858
  %t2862 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2863 = icmp eq i32 %t2833, 9
  %t2864 = select i1 %t2863, i8* %t2862, i8* %t2861
  %t2865 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2866 = icmp eq i32 %t2833, 10
  %t2867 = select i1 %t2866, i8* %t2865, i8* %t2864
  %t2868 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2869 = icmp eq i32 %t2833, 11
  %t2870 = select i1 %t2869, i8* %t2868, i8* %t2867
  %t2871 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2872 = icmp eq i32 %t2833, 12
  %t2873 = select i1 %t2872, i8* %t2871, i8* %t2870
  %t2874 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2875 = icmp eq i32 %t2833, 13
  %t2876 = select i1 %t2875, i8* %t2874, i8* %t2873
  %t2877 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2878 = icmp eq i32 %t2833, 14
  %t2879 = select i1 %t2878, i8* %t2877, i8* %t2876
  %t2880 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2881 = icmp eq i32 %t2833, 15
  %t2882 = select i1 %t2881, i8* %t2880, i8* %t2879
  %t2883 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2884 = icmp eq i32 %t2833, 16
  %t2885 = select i1 %t2884, i8* %t2883, i8* %t2882
  %t2886 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2887 = icmp eq i32 %t2833, 17
  %t2888 = select i1 %t2887, i8* %t2886, i8* %t2885
  %t2889 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2890 = icmp eq i32 %t2833, 18
  %t2891 = select i1 %t2890, i8* %t2889, i8* %t2888
  %t2892 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2893 = icmp eq i32 %t2833, 19
  %t2894 = select i1 %t2893, i8* %t2892, i8* %t2891
  %t2895 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2896 = icmp eq i32 %t2833, 20
  %t2897 = select i1 %t2896, i8* %t2895, i8* %t2894
  %t2898 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2899 = icmp eq i32 %t2833, 21
  %t2900 = select i1 %t2899, i8* %t2898, i8* %t2897
  %t2901 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2902 = icmp eq i32 %t2833, 22
  %t2903 = select i1 %t2902, i8* %t2901, i8* %t2900
  %s2904 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1566780570, i32 0, i32 0
  %t2905 = call i1 @strings_equal(i8* %t2903, i8* %s2904)
  br i1 %t2905, label %then36, label %merge37
then36:
  %t2906 = extractvalue %Statement %statement, 0
  %t2907 = alloca %Statement
  store %Statement %statement, %Statement* %t2907
  %t2908 = getelementptr inbounds %Statement, %Statement* %t2907, i32 0, i32 1
  %t2909 = bitcast [88 x i8]* %t2908 to i8*
  %t2910 = getelementptr inbounds i8, i8* %t2909, i64 48
  %t2911 = bitcast i8* %t2910 to %Block*
  %t2912 = load %Block, %Block* %t2911
  %t2913 = icmp eq i32 %t2906, 19
  %t2914 = select i1 %t2913, %Block %t2912, %Block zeroinitializer
  %t2915 = call { %Diagnostic*, i64 }* @check_block(%Block %t2914, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t2915, { %Diagnostic*, i64 }** %l22
  %t2916 = extractvalue %Statement %statement, 0
  %t2917 = alloca %Statement
  store %Statement %statement, %Statement* %t2917
  %t2918 = getelementptr inbounds %Statement, %Statement* %t2917, i32 0, i32 1
  %t2919 = bitcast [88 x i8]* %t2918 to i8*
  %t2920 = getelementptr inbounds i8, i8* %t2919, i64 72
  %t2921 = bitcast i8* %t2920 to %ElseBranch**
  %t2922 = load %ElseBranch*, %ElseBranch** %t2921
  %t2923 = icmp eq i32 %t2916, 19
  %t2924 = select i1 %t2923, %ElseBranch* %t2922, %ElseBranch* null
  %t2925 = icmp ne %ElseBranch* %t2924, null
  %t2926 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br i1 %t2925, label %then38, label %merge39
then38:
  %t2927 = extractvalue %Statement %statement, 0
  %t2928 = alloca %Statement
  store %Statement %statement, %Statement* %t2928
  %t2929 = getelementptr inbounds %Statement, %Statement* %t2928, i32 0, i32 1
  %t2930 = bitcast [88 x i8]* %t2929 to i8*
  %t2931 = getelementptr inbounds i8, i8* %t2930, i64 72
  %t2932 = bitcast i8* %t2931 to %ElseBranch**
  %t2933 = load %ElseBranch*, %ElseBranch** %t2932
  %t2934 = icmp eq i32 %t2927, 19
  %t2935 = select i1 %t2934, %ElseBranch* %t2933, %ElseBranch* null
  store %ElseBranch* %t2935, %ElseBranch** %l23
  %t2936 = load %ElseBranch*, %ElseBranch** %l23
  %t2937 = getelementptr %ElseBranch, %ElseBranch* %t2936, i32 0, i32 1
  %t2938 = load %Block*, %Block** %t2937
  %t2939 = icmp ne %Block* %t2938, null
  %t2940 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2941 = load %ElseBranch*, %ElseBranch** %l23
  br i1 %t2939, label %then40, label %merge41
then40:
  %t2942 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2943 = load %ElseBranch*, %ElseBranch** %l23
  %t2944 = getelementptr %ElseBranch, %ElseBranch* %t2943, i32 0, i32 1
  %t2945 = load %Block*, %Block** %t2944
  %t2946 = load %Block, %Block* %t2945
  %t2947 = call { %Diagnostic*, i64 }* @check_block(%Block %t2946, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t2948 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2942, i32 0, i32 0
  %t2949 = load %Diagnostic*, %Diagnostic** %t2948
  %t2950 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2942, i32 0, i32 1
  %t2951 = load i64, i64* %t2950
  %t2952 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2947, i32 0, i32 0
  %t2953 = load %Diagnostic*, %Diagnostic** %t2952
  %t2954 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2947, i32 0, i32 1
  %t2955 = load i64, i64* %t2954
  %t2956 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t2957 = ptrtoint %Diagnostic* %t2956 to i64
  %t2958 = add i64 %t2951, %t2955
  %t2959 = mul i64 %t2957, %t2958
  %t2960 = call noalias i8* @malloc(i64 %t2959)
  %t2961 = bitcast i8* %t2960 to %Diagnostic*
  %t2962 = bitcast %Diagnostic* %t2961 to i8*
  %t2963 = mul i64 %t2957, %t2951
  %t2964 = bitcast %Diagnostic* %t2949 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2962, i8* %t2964, i64 %t2963)
  %t2965 = mul i64 %t2957, %t2955
  %t2966 = bitcast %Diagnostic* %t2953 to i8*
  %t2967 = getelementptr %Diagnostic, %Diagnostic* %t2961, i64 %t2951
  %t2968 = bitcast %Diagnostic* %t2967 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t2968, i8* %t2966, i64 %t2965)
  %t2969 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t2970 = ptrtoint { %Diagnostic*, i64 }* %t2969 to i64
  %t2971 = call i8* @malloc(i64 %t2970)
  %t2972 = bitcast i8* %t2971 to { %Diagnostic*, i64 }*
  %t2973 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2972, i32 0, i32 0
  store %Diagnostic* %t2961, %Diagnostic** %t2973
  %t2974 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2972, i32 0, i32 1
  store i64 %t2958, i64* %t2974
  store { %Diagnostic*, i64 }* %t2972, { %Diagnostic*, i64 }** %l22
  %t2975 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br label %merge41
merge41:
  %t2976 = phi { %Diagnostic*, i64 }* [ %t2975, %then40 ], [ %t2940, %then38 ]
  store { %Diagnostic*, i64 }* %t2976, { %Diagnostic*, i64 }** %l22
  %t2977 = load %ElseBranch*, %ElseBranch** %l23
  %t2978 = getelementptr %ElseBranch, %ElseBranch* %t2977, i32 0, i32 0
  %t2979 = load %Statement*, %Statement** %t2978
  %t2980 = icmp ne %Statement* %t2979, null
  %t2981 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2982 = load %ElseBranch*, %ElseBranch** %l23
  br i1 %t2980, label %then42, label %merge43
then42:
  %t2983 = load %ElseBranch*, %ElseBranch** %l23
  %t2984 = getelementptr %ElseBranch, %ElseBranch* %t2983, i32 0, i32 0
  %t2985 = load %Statement*, %Statement** %t2984
  %t2986 = load %Statement, %Statement* %t2985
  %t2987 = call %ScopeResult @check_statement(%Statement %t2986, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  store %ScopeResult %t2987, %ScopeResult* %l24
  %t2988 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t2989 = load %ScopeResult, %ScopeResult* %l24
  %t2990 = extractvalue %ScopeResult %t2989, 1
  %t2991 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2988, i32 0, i32 0
  %t2992 = load %Diagnostic*, %Diagnostic** %t2991
  %t2993 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2988, i32 0, i32 1
  %t2994 = load i64, i64* %t2993
  %t2995 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2990, i32 0, i32 0
  %t2996 = load %Diagnostic*, %Diagnostic** %t2995
  %t2997 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t2990, i32 0, i32 1
  %t2998 = load i64, i64* %t2997
  %t2999 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t3000 = ptrtoint %Diagnostic* %t2999 to i64
  %t3001 = add i64 %t2994, %t2998
  %t3002 = mul i64 %t3000, %t3001
  %t3003 = call noalias i8* @malloc(i64 %t3002)
  %t3004 = bitcast i8* %t3003 to %Diagnostic*
  %t3005 = bitcast %Diagnostic* %t3004 to i8*
  %t3006 = mul i64 %t3000, %t2994
  %t3007 = bitcast %Diagnostic* %t2992 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t3005, i8* %t3007, i64 %t3006)
  %t3008 = mul i64 %t3000, %t2998
  %t3009 = bitcast %Diagnostic* %t2996 to i8*
  %t3010 = getelementptr %Diagnostic, %Diagnostic* %t3004, i64 %t2994
  %t3011 = bitcast %Diagnostic* %t3010 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t3011, i8* %t3009, i64 %t3008)
  %t3012 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t3013 = ptrtoint { %Diagnostic*, i64 }* %t3012 to i64
  %t3014 = call i8* @malloc(i64 %t3013)
  %t3015 = bitcast i8* %t3014 to { %Diagnostic*, i64 }*
  %t3016 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3015, i32 0, i32 0
  store %Diagnostic* %t3004, %Diagnostic** %t3016
  %t3017 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3015, i32 0, i32 1
  store i64 %t3001, i64* %t3017
  store { %Diagnostic*, i64 }* %t3015, { %Diagnostic*, i64 }** %l22
  %t3018 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br label %merge43
merge43:
  %t3019 = phi { %Diagnostic*, i64 }* [ %t3018, %then42 ], [ %t2981, %merge41 ]
  store { %Diagnostic*, i64 }* %t3019, { %Diagnostic*, i64 }** %l22
  %t3020 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t3021 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  br label %merge39
merge39:
  %t3022 = phi { %Diagnostic*, i64 }* [ %t3020, %merge43 ], [ %t2926, %then36 ]
  %t3023 = phi { %Diagnostic*, i64 }* [ %t3021, %merge43 ], [ %t2926, %then36 ]
  store { %Diagnostic*, i64 }* %t3022, { %Diagnostic*, i64 }** %l22
  store { %Diagnostic*, i64 }* %t3023, { %Diagnostic*, i64 }** %l22
  %t3024 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %bindings, 0
  %t3025 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l22
  %t3026 = insertvalue %ScopeResult %t3024, { %Diagnostic*, i64 }* %t3025, 1
  ret %ScopeResult %t3026
merge37:
  %t3027 = extractvalue %Statement %statement, 0
  %t3028 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t3029 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t3030 = icmp eq i32 %t3027, 0
  %t3031 = select i1 %t3030, i8* %t3029, i8* %t3028
  %t3032 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t3033 = icmp eq i32 %t3027, 1
  %t3034 = select i1 %t3033, i8* %t3032, i8* %t3031
  %t3035 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t3036 = icmp eq i32 %t3027, 2
  %t3037 = select i1 %t3036, i8* %t3035, i8* %t3034
  %t3038 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t3039 = icmp eq i32 %t3027, 3
  %t3040 = select i1 %t3039, i8* %t3038, i8* %t3037
  %t3041 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t3042 = icmp eq i32 %t3027, 4
  %t3043 = select i1 %t3042, i8* %t3041, i8* %t3040
  %t3044 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t3045 = icmp eq i32 %t3027, 5
  %t3046 = select i1 %t3045, i8* %t3044, i8* %t3043
  %t3047 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t3048 = icmp eq i32 %t3027, 6
  %t3049 = select i1 %t3048, i8* %t3047, i8* %t3046
  %t3050 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t3051 = icmp eq i32 %t3027, 7
  %t3052 = select i1 %t3051, i8* %t3050, i8* %t3049
  %t3053 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t3054 = icmp eq i32 %t3027, 8
  %t3055 = select i1 %t3054, i8* %t3053, i8* %t3052
  %t3056 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t3057 = icmp eq i32 %t3027, 9
  %t3058 = select i1 %t3057, i8* %t3056, i8* %t3055
  %t3059 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t3060 = icmp eq i32 %t3027, 10
  %t3061 = select i1 %t3060, i8* %t3059, i8* %t3058
  %t3062 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t3063 = icmp eq i32 %t3027, 11
  %t3064 = select i1 %t3063, i8* %t3062, i8* %t3061
  %t3065 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t3066 = icmp eq i32 %t3027, 12
  %t3067 = select i1 %t3066, i8* %t3065, i8* %t3064
  %t3068 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t3069 = icmp eq i32 %t3027, 13
  %t3070 = select i1 %t3069, i8* %t3068, i8* %t3067
  %t3071 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t3072 = icmp eq i32 %t3027, 14
  %t3073 = select i1 %t3072, i8* %t3071, i8* %t3070
  %t3074 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t3075 = icmp eq i32 %t3027, 15
  %t3076 = select i1 %t3075, i8* %t3074, i8* %t3073
  %t3077 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t3078 = icmp eq i32 %t3027, 16
  %t3079 = select i1 %t3078, i8* %t3077, i8* %t3076
  %t3080 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t3081 = icmp eq i32 %t3027, 17
  %t3082 = select i1 %t3081, i8* %t3080, i8* %t3079
  %t3083 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t3084 = icmp eq i32 %t3027, 18
  %t3085 = select i1 %t3084, i8* %t3083, i8* %t3082
  %t3086 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t3087 = icmp eq i32 %t3027, 19
  %t3088 = select i1 %t3087, i8* %t3086, i8* %t3085
  %t3089 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t3090 = icmp eq i32 %t3027, 20
  %t3091 = select i1 %t3090, i8* %t3089, i8* %t3088
  %t3092 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t3093 = icmp eq i32 %t3027, 21
  %t3094 = select i1 %t3093, i8* %t3092, i8* %t3091
  %t3095 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t3096 = icmp eq i32 %t3027, 22
  %t3097 = select i1 %t3096, i8* %t3095, i8* %t3094
  %s3098 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1067284810, i32 0, i32 0
  %t3099 = call i1 @strings_equal(i8* %t3097, i8* %s3098)
  br i1 %t3099, label %then44, label %merge45
then44:
  %t3100 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %bindings, 0
  %t3101 = extractvalue %Statement %statement, 0
  %t3102 = alloca %Statement
  store %Statement %statement, %Statement* %t3102
  %t3103 = getelementptr inbounds %Statement, %Statement* %t3102, i32 0, i32 1
  %t3104 = bitcast [88 x i8]* %t3103 to i8*
  %t3105 = getelementptr inbounds i8, i8* %t3104, i64 56
  %t3106 = bitcast i8* %t3105 to %Block*
  %t3107 = load %Block, %Block* %t3106
  %t3108 = icmp eq i32 %t3101, 4
  %t3109 = select i1 %t3108, %Block %t3107, %Block zeroinitializer
  %t3110 = getelementptr inbounds %Statement, %Statement* %t3102, i32 0, i32 1
  %t3111 = bitcast [88 x i8]* %t3110 to i8*
  %t3112 = getelementptr inbounds i8, i8* %t3111, i64 56
  %t3113 = bitcast i8* %t3112 to %Block*
  %t3114 = load %Block, %Block* %t3113
  %t3115 = icmp eq i32 %t3101, 5
  %t3116 = select i1 %t3115, %Block %t3114, %Block %t3109
  %t3117 = getelementptr inbounds %Statement, %Statement* %t3102, i32 0, i32 1
  %t3118 = bitcast [56 x i8]* %t3117 to i8*
  %t3119 = getelementptr inbounds i8, i8* %t3118, i64 16
  %t3120 = bitcast i8* %t3119 to %Block*
  %t3121 = load %Block, %Block* %t3120
  %t3122 = icmp eq i32 %t3101, 6
  %t3123 = select i1 %t3122, %Block %t3121, %Block %t3116
  %t3124 = getelementptr inbounds %Statement, %Statement* %t3102, i32 0, i32 1
  %t3125 = bitcast [88 x i8]* %t3124 to i8*
  %t3126 = getelementptr inbounds i8, i8* %t3125, i64 56
  %t3127 = bitcast i8* %t3126 to %Block*
  %t3128 = load %Block, %Block* %t3127
  %t3129 = icmp eq i32 %t3101, 7
  %t3130 = select i1 %t3129, %Block %t3128, %Block %t3123
  %t3131 = getelementptr inbounds %Statement, %Statement* %t3102, i32 0, i32 1
  %t3132 = bitcast [120 x i8]* %t3131 to i8*
  %t3133 = getelementptr inbounds i8, i8* %t3132, i64 88
  %t3134 = bitcast i8* %t3133 to %Block*
  %t3135 = load %Block, %Block* %t3134
  %t3136 = icmp eq i32 %t3101, 12
  %t3137 = select i1 %t3136, %Block %t3135, %Block %t3130
  %t3138 = getelementptr inbounds %Statement, %Statement* %t3102, i32 0, i32 1
  %t3139 = bitcast [40 x i8]* %t3138 to i8*
  %t3140 = getelementptr inbounds i8, i8* %t3139, i64 8
  %t3141 = bitcast i8* %t3140 to %Block*
  %t3142 = load %Block, %Block* %t3141
  %t3143 = icmp eq i32 %t3101, 13
  %t3144 = select i1 %t3143, %Block %t3142, %Block %t3137
  %t3145 = getelementptr inbounds %Statement, %Statement* %t3102, i32 0, i32 1
  %t3146 = bitcast [136 x i8]* %t3145 to i8*
  %t3147 = getelementptr inbounds i8, i8* %t3146, i64 104
  %t3148 = bitcast i8* %t3147 to %Block*
  %t3149 = load %Block, %Block* %t3148
  %t3150 = icmp eq i32 %t3101, 14
  %t3151 = select i1 %t3150, %Block %t3149, %Block %t3144
  %t3152 = getelementptr inbounds %Statement, %Statement* %t3102, i32 0, i32 1
  %t3153 = bitcast [32 x i8]* %t3152 to i8*
  %t3154 = bitcast i8* %t3153 to %Block*
  %t3155 = load %Block, %Block* %t3154
  %t3156 = icmp eq i32 %t3101, 15
  %t3157 = select i1 %t3156, %Block %t3155, %Block %t3151
  %t3158 = call { %Diagnostic*, i64 }* @check_block(%Block %t3157, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces)
  %t3159 = insertvalue %ScopeResult %t3100, { %Diagnostic*, i64 }* %t3158, 1
  ret %ScopeResult %t3159
merge45:
  %t3160 = extractvalue %Statement %statement, 0
  %t3161 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t3162 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t3163 = icmp eq i32 %t3160, 0
  %t3164 = select i1 %t3163, i8* %t3162, i8* %t3161
  %t3165 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t3166 = icmp eq i32 %t3160, 1
  %t3167 = select i1 %t3166, i8* %t3165, i8* %t3164
  %t3168 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t3169 = icmp eq i32 %t3160, 2
  %t3170 = select i1 %t3169, i8* %t3168, i8* %t3167
  %t3171 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t3172 = icmp eq i32 %t3160, 3
  %t3173 = select i1 %t3172, i8* %t3171, i8* %t3170
  %t3174 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t3175 = icmp eq i32 %t3160, 4
  %t3176 = select i1 %t3175, i8* %t3174, i8* %t3173
  %t3177 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t3178 = icmp eq i32 %t3160, 5
  %t3179 = select i1 %t3178, i8* %t3177, i8* %t3176
  %t3180 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t3181 = icmp eq i32 %t3160, 6
  %t3182 = select i1 %t3181, i8* %t3180, i8* %t3179
  %t3183 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t3184 = icmp eq i32 %t3160, 7
  %t3185 = select i1 %t3184, i8* %t3183, i8* %t3182
  %t3186 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t3187 = icmp eq i32 %t3160, 8
  %t3188 = select i1 %t3187, i8* %t3186, i8* %t3185
  %t3189 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t3190 = icmp eq i32 %t3160, 9
  %t3191 = select i1 %t3190, i8* %t3189, i8* %t3188
  %t3192 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t3193 = icmp eq i32 %t3160, 10
  %t3194 = select i1 %t3193, i8* %t3192, i8* %t3191
  %t3195 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t3196 = icmp eq i32 %t3160, 11
  %t3197 = select i1 %t3196, i8* %t3195, i8* %t3194
  %t3198 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t3199 = icmp eq i32 %t3160, 12
  %t3200 = select i1 %t3199, i8* %t3198, i8* %t3197
  %t3201 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t3202 = icmp eq i32 %t3160, 13
  %t3203 = select i1 %t3202, i8* %t3201, i8* %t3200
  %t3204 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t3205 = icmp eq i32 %t3160, 14
  %t3206 = select i1 %t3205, i8* %t3204, i8* %t3203
  %t3207 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t3208 = icmp eq i32 %t3160, 15
  %t3209 = select i1 %t3208, i8* %t3207, i8* %t3206
  %t3210 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t3211 = icmp eq i32 %t3160, 16
  %t3212 = select i1 %t3211, i8* %t3210, i8* %t3209
  %t3213 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t3214 = icmp eq i32 %t3160, 17
  %t3215 = select i1 %t3214, i8* %t3213, i8* %t3212
  %t3216 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t3217 = icmp eq i32 %t3160, 18
  %t3218 = select i1 %t3217, i8* %t3216, i8* %t3215
  %t3219 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t3220 = icmp eq i32 %t3160, 19
  %t3221 = select i1 %t3220, i8* %t3219, i8* %t3218
  %t3222 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t3223 = icmp eq i32 %t3160, 20
  %t3224 = select i1 %t3223, i8* %t3222, i8* %t3221
  %t3225 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t3226 = icmp eq i32 %t3160, 21
  %t3227 = select i1 %t3226, i8* %t3225, i8* %t3224
  %t3228 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t3229 = icmp eq i32 %t3160, 22
  %t3230 = select i1 %t3229, i8* %t3228, i8* %t3227
  %s3231 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1496093543, i32 0, i32 0
  %t3232 = call i1 @strings_equal(i8* %t3230, i8* %s3231)
  br i1 %t3232, label %then46, label %merge47
then46:
  %t3233 = extractvalue %Statement %statement, 0
  %t3234 = alloca %Statement
  store %Statement %statement, %Statement* %t3234
  %t3235 = getelementptr inbounds %Statement, %Statement* %t3234, i32 0, i32 1
  %t3236 = bitcast [48 x i8]* %t3235 to i8*
  %t3237 = bitcast i8* %t3236 to i8**
  %t3238 = load i8*, i8** %t3237
  %t3239 = icmp eq i32 %t3233, 2
  %t3240 = select i1 %t3239, i8* %t3238, i8* null
  %t3241 = getelementptr inbounds %Statement, %Statement* %t3234, i32 0, i32 1
  %t3242 = bitcast [48 x i8]* %t3241 to i8*
  %t3243 = bitcast i8* %t3242 to i8**
  %t3244 = load i8*, i8** %t3243
  %t3245 = icmp eq i32 %t3233, 3
  %t3246 = select i1 %t3245, i8* %t3244, i8* %t3240
  %t3247 = getelementptr inbounds %Statement, %Statement* %t3234, i32 0, i32 1
  %t3248 = bitcast [56 x i8]* %t3247 to i8*
  %t3249 = bitcast i8* %t3248 to i8**
  %t3250 = load i8*, i8** %t3249
  %t3251 = icmp eq i32 %t3233, 6
  %t3252 = select i1 %t3251, i8* %t3250, i8* %t3246
  %t3253 = getelementptr inbounds %Statement, %Statement* %t3234, i32 0, i32 1
  %t3254 = bitcast [56 x i8]* %t3253 to i8*
  %t3255 = bitcast i8* %t3254 to i8**
  %t3256 = load i8*, i8** %t3255
  %t3257 = icmp eq i32 %t3233, 8
  %t3258 = select i1 %t3257, i8* %t3256, i8* %t3252
  %t3259 = getelementptr inbounds %Statement, %Statement* %t3234, i32 0, i32 1
  %t3260 = bitcast [40 x i8]* %t3259 to i8*
  %t3261 = bitcast i8* %t3260 to i8**
  %t3262 = load i8*, i8** %t3261
  %t3263 = icmp eq i32 %t3233, 9
  %t3264 = select i1 %t3263, i8* %t3262, i8* %t3258
  %t3265 = getelementptr inbounds %Statement, %Statement* %t3234, i32 0, i32 1
  %t3266 = bitcast [40 x i8]* %t3265 to i8*
  %t3267 = bitcast i8* %t3266 to i8**
  %t3268 = load i8*, i8** %t3267
  %t3269 = icmp eq i32 %t3233, 10
  %t3270 = select i1 %t3269, i8* %t3268, i8* %t3264
  %t3271 = getelementptr inbounds %Statement, %Statement* %t3234, i32 0, i32 1
  %t3272 = bitcast [40 x i8]* %t3271 to i8*
  %t3273 = bitcast i8* %t3272 to i8**
  %t3274 = load i8*, i8** %t3273
  %t3275 = icmp eq i32 %t3233, 11
  %t3276 = select i1 %t3275, i8* %t3274, i8* %t3270
  %s3277 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h276192845, i32 0, i32 0
  %t3278 = extractvalue %Statement %statement, 0
  %t3279 = alloca %Statement
  store %Statement %statement, %Statement* %t3279
  %t3280 = getelementptr inbounds %Statement, %Statement* %t3279, i32 0, i32 1
  %t3281 = bitcast [48 x i8]* %t3280 to i8*
  %t3282 = getelementptr inbounds i8, i8* %t3281, i64 8
  %t3283 = bitcast i8* %t3282 to %SourceSpan**
  %t3284 = load %SourceSpan*, %SourceSpan** %t3283
  %t3285 = icmp eq i32 %t3278, 3
  %t3286 = select i1 %t3285, %SourceSpan* %t3284, %SourceSpan* null
  %t3287 = getelementptr inbounds %Statement, %Statement* %t3279, i32 0, i32 1
  %t3288 = bitcast [56 x i8]* %t3287 to i8*
  %t3289 = getelementptr inbounds i8, i8* %t3288, i64 8
  %t3290 = bitcast i8* %t3289 to %SourceSpan**
  %t3291 = load %SourceSpan*, %SourceSpan** %t3290
  %t3292 = icmp eq i32 %t3278, 6
  %t3293 = select i1 %t3292, %SourceSpan* %t3291, %SourceSpan* %t3286
  %t3294 = getelementptr inbounds %Statement, %Statement* %t3279, i32 0, i32 1
  %t3295 = bitcast [56 x i8]* %t3294 to i8*
  %t3296 = getelementptr inbounds i8, i8* %t3295, i64 8
  %t3297 = bitcast i8* %t3296 to %SourceSpan**
  %t3298 = load %SourceSpan*, %SourceSpan** %t3297
  %t3299 = icmp eq i32 %t3278, 8
  %t3300 = select i1 %t3299, %SourceSpan* %t3298, %SourceSpan* %t3293
  %t3301 = getelementptr inbounds %Statement, %Statement* %t3279, i32 0, i32 1
  %t3302 = bitcast [40 x i8]* %t3301 to i8*
  %t3303 = getelementptr inbounds i8, i8* %t3302, i64 8
  %t3304 = bitcast i8* %t3303 to %SourceSpan**
  %t3305 = load %SourceSpan*, %SourceSpan** %t3304
  %t3306 = icmp eq i32 %t3278, 9
  %t3307 = select i1 %t3306, %SourceSpan* %t3305, %SourceSpan* %t3300
  %t3308 = getelementptr inbounds %Statement, %Statement* %t3279, i32 0, i32 1
  %t3309 = bitcast [40 x i8]* %t3308 to i8*
  %t3310 = getelementptr inbounds i8, i8* %t3309, i64 8
  %t3311 = bitcast i8* %t3310 to %SourceSpan**
  %t3312 = load %SourceSpan*, %SourceSpan** %t3311
  %t3313 = icmp eq i32 %t3278, 10
  %t3314 = select i1 %t3313, %SourceSpan* %t3312, %SourceSpan* %t3307
  %t3315 = getelementptr inbounds %Statement, %Statement* %t3279, i32 0, i32 1
  %t3316 = bitcast [40 x i8]* %t3315 to i8*
  %t3317 = getelementptr inbounds i8, i8* %t3316, i64 8
  %t3318 = bitcast i8* %t3317 to %SourceSpan**
  %t3319 = load %SourceSpan*, %SourceSpan** %t3318
  %t3320 = icmp eq i32 %t3278, 11
  %t3321 = select i1 %t3320, %SourceSpan* %t3319, %SourceSpan* %t3314
  %t3322 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %t3276, i8* %s3277, %SourceSpan* %t3321)
  store %ScopeResult %t3322, %ScopeResult* %l25
  %t3323 = load %ScopeResult, %ScopeResult* %l25
  %t3324 = extractvalue %ScopeResult %t3323, 1
  %t3325 = extractvalue %Statement %statement, 0
  %t3326 = alloca %Statement
  store %Statement %statement, %Statement* %t3326
  %t3327 = getelementptr inbounds %Statement, %Statement* %t3326, i32 0, i32 1
  %t3328 = bitcast [56 x i8]* %t3327 to i8*
  %t3329 = getelementptr inbounds i8, i8* %t3328, i64 16
  %t3330 = bitcast i8* %t3329 to { %TypeParameter*, i64 }**
  %t3331 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t3330
  %t3332 = icmp eq i32 %t3325, 8
  %t3333 = select i1 %t3332, { %TypeParameter*, i64 }* %t3331, { %TypeParameter*, i64 }* null
  %t3334 = getelementptr inbounds %Statement, %Statement* %t3326, i32 0, i32 1
  %t3335 = bitcast [40 x i8]* %t3334 to i8*
  %t3336 = getelementptr inbounds i8, i8* %t3335, i64 16
  %t3337 = bitcast i8* %t3336 to { %TypeParameter*, i64 }**
  %t3338 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t3337
  %t3339 = icmp eq i32 %t3325, 9
  %t3340 = select i1 %t3339, { %TypeParameter*, i64 }* %t3338, { %TypeParameter*, i64 }* %t3333
  %t3341 = getelementptr inbounds %Statement, %Statement* %t3326, i32 0, i32 1
  %t3342 = bitcast [40 x i8]* %t3341 to i8*
  %t3343 = getelementptr inbounds i8, i8* %t3342, i64 16
  %t3344 = bitcast i8* %t3343 to { %TypeParameter*, i64 }**
  %t3345 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t3344
  %t3346 = icmp eq i32 %t3325, 10
  %t3347 = select i1 %t3346, { %TypeParameter*, i64 }* %t3345, { %TypeParameter*, i64 }* %t3340
  %t3348 = getelementptr inbounds %Statement, %Statement* %t3326, i32 0, i32 1
  %t3349 = bitcast [40 x i8]* %t3348 to i8*
  %t3350 = getelementptr inbounds i8, i8* %t3349, i64 16
  %t3351 = bitcast i8* %t3350 to { %TypeParameter*, i64 }**
  %t3352 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %t3351
  %t3353 = icmp eq i32 %t3325, 11
  %t3354 = select i1 %t3353, { %TypeParameter*, i64 }* %t3352, { %TypeParameter*, i64 }* %t3347
  %t3355 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %t3354)
  %t3356 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3324, i32 0, i32 0
  %t3357 = load %Diagnostic*, %Diagnostic** %t3356
  %t3358 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3324, i32 0, i32 1
  %t3359 = load i64, i64* %t3358
  %t3360 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3355, i32 0, i32 0
  %t3361 = load %Diagnostic*, %Diagnostic** %t3360
  %t3362 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3355, i32 0, i32 1
  %t3363 = load i64, i64* %t3362
  %t3364 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t3365 = ptrtoint %Diagnostic* %t3364 to i64
  %t3366 = add i64 %t3359, %t3363
  %t3367 = mul i64 %t3365, %t3366
  %t3368 = call noalias i8* @malloc(i64 %t3367)
  %t3369 = bitcast i8* %t3368 to %Diagnostic*
  %t3370 = bitcast %Diagnostic* %t3369 to i8*
  %t3371 = mul i64 %t3365, %t3359
  %t3372 = bitcast %Diagnostic* %t3357 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t3370, i8* %t3372, i64 %t3371)
  %t3373 = mul i64 %t3365, %t3363
  %t3374 = bitcast %Diagnostic* %t3361 to i8*
  %t3375 = getelementptr %Diagnostic, %Diagnostic* %t3369, i64 %t3359
  %t3376 = bitcast %Diagnostic* %t3375 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t3376, i8* %t3374, i64 %t3373)
  %t3377 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t3378 = ptrtoint { %Diagnostic*, i64 }* %t3377 to i64
  %t3379 = call i8* @malloc(i64 %t3378)
  %t3380 = bitcast i8* %t3379 to { %Diagnostic*, i64 }*
  %t3381 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3380, i32 0, i32 0
  store %Diagnostic* %t3369, %Diagnostic** %t3381
  %t3382 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3380, i32 0, i32 1
  store i64 %t3366, i64* %t3382
  store { %Diagnostic*, i64 }* %t3380, { %Diagnostic*, i64 }** %l26
  %t3383 = load %ScopeResult, %ScopeResult* %l25
  %t3384 = extractvalue %ScopeResult %t3383, 0
  %t3385 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t3384, 0
  %t3386 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l26
  %t3387 = insertvalue %ScopeResult %t3385, { %Diagnostic*, i64 }* %t3386, 1
  ret %ScopeResult %t3387
merge47:
  %t3388 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %bindings, 0
  %t3389 = getelementptr [0 x %Diagnostic], [0 x %Diagnostic]* null, i32 1
  %t3390 = ptrtoint [0 x %Diagnostic]* %t3389 to i64
  %t3391 = icmp eq i64 %t3390, 0
  %t3392 = select i1 %t3391, i64 1, i64 %t3390
  %t3393 = call i8* @malloc(i64 %t3392)
  %t3394 = bitcast i8* %t3393 to %Diagnostic*
  %t3395 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t3396 = ptrtoint { %Diagnostic*, i64 }* %t3395 to i64
  %t3397 = call i8* @malloc(i64 %t3396)
  %t3398 = bitcast i8* %t3397 to { %Diagnostic*, i64 }*
  %t3399 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3398, i32 0, i32 0
  store %Diagnostic* %t3394, %Diagnostic** %t3399
  %t3400 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t3398, i32 0, i32 1
  store i64 0, i64* %t3400
  %t3401 = insertvalue %ScopeResult %t3388, { %Diagnostic*, i64 }* %t3398, 1
  ret %ScopeResult %t3401
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
  %s37 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1747065903, i32 0, i32 0
  %t38 = load %Parameter, %Parameter* %l3
  %t39 = extractvalue %Parameter %t38, 4
  %t40 = call %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %t34, i8* %t36, i8* %s37, %SourceSpan* %t39)
  store %ScopeResult %t40, %ScopeResult* %l4
  %t41 = load %ScopeResult, %ScopeResult* %l4
  %t42 = extractvalue %ScopeResult %t41, 0
  store { %SymbolEntry*, i64 }* %t42, { %SymbolEntry*, i64 }** %l0
  %t43 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t44 = load %ScopeResult, %ScopeResult* %l4
  %t45 = extractvalue %ScopeResult %t44, 1
  %t46 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t43, i32 0, i32 0
  %t47 = load %Diagnostic*, %Diagnostic** %t46
  %t48 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t43, i32 0, i32 1
  %t49 = load i64, i64* %t48
  %t50 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t45, i32 0, i32 0
  %t51 = load %Diagnostic*, %Diagnostic** %t50
  %t52 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t45, i32 0, i32 1
  %t53 = load i64, i64* %t52
  %t54 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t55 = ptrtoint %Diagnostic* %t54 to i64
  %t56 = add i64 %t49, %t53
  %t57 = mul i64 %t55, %t56
  %t58 = call noalias i8* @malloc(i64 %t57)
  %t59 = bitcast i8* %t58 to %Diagnostic*
  %t60 = bitcast %Diagnostic* %t59 to i8*
  %t61 = mul i64 %t55, %t49
  %t62 = bitcast %Diagnostic* %t47 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t60, i8* %t62, i64 %t61)
  %t63 = mul i64 %t55, %t53
  %t64 = bitcast %Diagnostic* %t51 to i8*
  %t65 = getelementptr %Diagnostic, %Diagnostic* %t59, i64 %t49
  %t66 = bitcast %Diagnostic* %t65 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t66, i8* %t64, i64 %t63)
  %t67 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t68 = ptrtoint { %Diagnostic*, i64 }* %t67 to i64
  %t69 = call i8* @malloc(i64 %t68)
  %t70 = bitcast i8* %t69 to { %Diagnostic*, i64 }*
  %t71 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t70, i32 0, i32 0
  store %Diagnostic* %t59, %Diagnostic** %t71
  %t72 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t70, i32 0, i32 1
  store i64 %t56, i64* %t72
  store { %Diagnostic*, i64 }* %t70, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t73 = load i64, i64* %l2
  %t74 = add i64 %t73, 1
  store i64 %t74, i64* %l2
  br label %for0
afterfor3:
  %t75 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t76 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t77 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t78 = insertvalue %ScopeResult undef, { %SymbolEntry*, i64 }* %t77, 0
  %t79 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t80 = insertvalue %ScopeResult %t78, { %Diagnostic*, i64 }* %t79, 1
  ret %ScopeResult %t80
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
  %s44 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h766506979, i32 0, i32 0
  %t45 = load i8*, i8** %l4
  %t46 = load %FieldDeclaration, %FieldDeclaration* %l3
  %t47 = extractvalue %FieldDeclaration %t46, 3
  %t48 = call %Token* @token_from_name(i8* %t45, %SourceSpan* %t47)
  %t49 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t43, i8* %s44, %Token* %t48)
  %t50 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 1
  %t51 = ptrtoint [1 x %Diagnostic]* %t50 to i64
  %t52 = icmp eq i64 %t51, 0
  %t53 = select i1 %t52, i64 1, i64 %t51
  %t54 = call i8* @malloc(i64 %t53)
  %t55 = bitcast i8* %t54 to %Diagnostic*
  %t56 = getelementptr %Diagnostic, %Diagnostic* %t55, i64 0
  store %Diagnostic %t49, %Diagnostic* %t56
  %t57 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t58 = ptrtoint { %Diagnostic*, i64 }* %t57 to i64
  %t59 = call i8* @malloc(i64 %t58)
  %t60 = bitcast i8* %t59 to { %Diagnostic*, i64 }*
  %t61 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t60, i32 0, i32 0
  store %Diagnostic* %t55, %Diagnostic** %t61
  %t62 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t60, i32 0, i32 1
  store i64 1, i64* %t62
  %t63 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t42, i32 0, i32 0
  %t64 = load %Diagnostic*, %Diagnostic** %t63
  %t65 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t42, i32 0, i32 1
  %t66 = load i64, i64* %t65
  %t67 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t60, i32 0, i32 0
  %t68 = load %Diagnostic*, %Diagnostic** %t67
  %t69 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t60, i32 0, i32 1
  %t70 = load i64, i64* %t69
  %t71 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t72 = ptrtoint %Diagnostic* %t71 to i64
  %t73 = add i64 %t66, %t70
  %t74 = mul i64 %t72, %t73
  %t75 = call noalias i8* @malloc(i64 %t74)
  %t76 = bitcast i8* %t75 to %Diagnostic*
  %t77 = bitcast %Diagnostic* %t76 to i8*
  %t78 = mul i64 %t72, %t66
  %t79 = bitcast %Diagnostic* %t64 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t77, i8* %t79, i64 %t78)
  %t80 = mul i64 %t72, %t70
  %t81 = bitcast %Diagnostic* %t68 to i8*
  %t82 = getelementptr %Diagnostic, %Diagnostic* %t76, i64 %t66
  %t83 = bitcast %Diagnostic* %t82 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t83, i8* %t81, i64 %t80)
  %t84 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t85 = ptrtoint { %Diagnostic*, i64 }* %t84 to i64
  %t86 = call i8* @malloc(i64 %t85)
  %t87 = bitcast i8* %t86 to { %Diagnostic*, i64 }*
  %t88 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t87, i32 0, i32 0
  store %Diagnostic* %t76, %Diagnostic** %t88
  %t89 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t87, i32 0, i32 1
  store i64 %t73, i64* %t89
  store { %Diagnostic*, i64 }* %t87, { %Diagnostic*, i64 }** %l1
  %t90 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t92 = load i8*, i8** %l4
  %t93 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t94 = ptrtoint [1 x i8*]* %t93 to i64
  %t95 = icmp eq i64 %t94, 0
  %t96 = select i1 %t95, i64 1, i64 %t94
  %t97 = call i8* @malloc(i64 %t96)
  %t98 = bitcast i8* %t97 to i8**
  %t99 = getelementptr i8*, i8** %t98, i64 0
  store i8* %t92, i8** %t99
  %t100 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t101 = ptrtoint { i8**, i64 }* %t100 to i64
  %t102 = call i8* @malloc(i64 %t101)
  %t103 = bitcast i8* %t102 to { i8**, i64 }*
  %t104 = getelementptr { i8**, i64 }, { i8**, i64 }* %t103, i32 0, i32 0
  store i8** %t98, i8*** %t104
  %t105 = getelementptr { i8**, i64 }, { i8**, i64 }* %t103, i32 0, i32 1
  store i64 1, i64* %t105
  %t106 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t91, { i8**, i64 }* %t103)
  store { i8**, i64 }* %t106, { i8**, i64 }** %l0
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t108 = phi { %Diagnostic*, i64 }* [ %t90, %then4 ], [ %t39, %else5 ]
  %t109 = phi { i8**, i64 }* [ %t38, %then4 ], [ %t107, %else5 ]
  store { %Diagnostic*, i64 }* %t108, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t109, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t110 = load i64, i64* %l2
  %t111 = add i64 %t110, 1
  store i64 %t111, i64* %l2
  br label %for0
afterfor3:
  %t112 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t114 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t114
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
  %s169 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t170 = call i8* @join_with_separator({ i8**, i64 }* %t168, i8* %s169)
  %t171 = call i8* @sailfin_runtime_string_concat(i8* %t167, i8* %t170)
  %t172 = add i64 0, 2
  %t173 = call i8* @malloc(i64 %t172)
  store i8 62, i8* %t173
  %t174 = getelementptr i8, i8* %t173, i64 1
  store i8 0, i8* %t174
  call void @sailfin_runtime_mark_persistent(i8* %t173)
  %t175 = call i8* @sailfin_runtime_string_concat(i8* %t171, i8* %t173)
  call void @sailfin_runtime_mark_persistent(i8* %t175)
  ret i8* %t175
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
  call void @sailfin_runtime_mark_persistent(i8* %s3)
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
  %t37 = phi i8* [ %t11, %merge1 ], [ %t35, %loop.latch4 ]
  %t38 = phi double [ %t12, %merge1 ], [ %t36, %loop.latch4 ]
  store i8* %t37, i8** %l0
  store double %t38, double* %l1
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
  %t23 = call double @llvm.round.f64(double %t22)
  %t24 = fptosi double %t23 to i64
  %t25 = load { i8**, i64 }, { i8**, i64 }* %items
  %t26 = extractvalue { i8**, i64 } %t25, 0
  %t27 = extractvalue { i8**, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t24, i64 %t27)
  %t29 = getelementptr i8*, i8** %t26, i64 %t24
  %t30 = load i8*, i8** %t29
  %t31 = call i8* @sailfin_runtime_string_concat(i8* %t21, i8* %t30)
  store i8* %t31, i8** %l0
  %t32 = load double, double* %l1
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l1
  br label %loop.latch4
loop.latch4:
  %t35 = load i8*, i8** %l0
  %t36 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t39 = load i8*, i8** %l0
  %t40 = load double, double* %l1
  %t41 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t41)
  ret i8* %t41
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
  %t173 = phi double [ %t17, %block.entry ], [ %t169, %loop.latch2 ]
  %t174 = phi i8* [ %t16, %block.entry ], [ %t170, %loop.latch2 ]
  %t175 = phi { i8**, i64 }* [ %t15, %block.entry ], [ %t171, %loop.latch2 ]
  %t176 = phi double [ %t18, %block.entry ], [ %t172, %loop.latch2 ]
  store double %t173, double* %l2
  store i8* %t174, i8** %l1
  store { i8**, i64 }* %t175, { i8**, i64 }** %l0
  store double %t176, double* %l3
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
  %t28 = call double @llvm.round.f64(double %t27)
  %t29 = fptosi double %t28 to i64
  %t30 = getelementptr i8, i8* %block, i64 %t29
  %t31 = load i8, i8* %t30
  store i8 %t31, i8* %l4
  %t32 = load i8, i8* %l4
  %t33 = icmp eq i8 %t32, 60
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load i8*, i8** %l1
  %t36 = load double, double* %l2
  %t37 = load double, double* %l3
  %t38 = load i8, i8* %l4
  br i1 %t33, label %then6, label %else7
then6:
  %t39 = load double, double* %l2
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l2
  %t42 = load i8*, i8** %l1
  %t43 = load i8, i8* %l4
  %t44 = add i64 0, 2
  %t45 = call i8* @malloc(i64 %t44)
  store i8 %t43, i8* %t45
  %t46 = getelementptr i8, i8* %t45, i64 1
  store i8 0, i8* %t46
  call void @sailfin_runtime_mark_persistent(i8* %t45)
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %t42, i8* %t45)
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
  %t72 = add i64 0, 2
  %t73 = call i8* @malloc(i64 %t72)
  store i8 %t71, i8* %t73
  %t74 = getelementptr i8, i8* %t73, i64 1
  store i8 0, i8* %t74
  call void @sailfin_runtime_mark_persistent(i8* %t73)
  %t75 = call i8* @sailfin_runtime_string_concat(i8* %t70, i8* %t73)
  store i8* %t75, i8** %l1
  %t76 = load double, double* %l2
  %t77 = load i8*, i8** %l1
  br label %merge11
else10:
  %t78 = load i8, i8* %l4
  %t79 = icmp eq i8 %t78, 44
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t81 = load i8*, i8** %l1
  %t82 = load double, double* %l2
  %t83 = load double, double* %l3
  %t84 = load i8, i8* %l4
  br i1 %t79, label %then14, label %else15
then14:
  %t85 = load double, double* %l2
  %t86 = sitofp i64 0 to double
  %t87 = fcmp oeq double %t85, %t86
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t89 = load i8*, i8** %l1
  %t90 = load double, double* %l2
  %t91 = load double, double* %l3
  %t92 = load i8, i8* %l4
  br i1 %t87, label %then17, label %merge18
then17:
  %t93 = load i8*, i8** %l1
  %t94 = call i8* @trim_text(i8* %t93)
  store i8* %t94, i8** %l5
  %t95 = load i8*, i8** %l5
  %t96 = call i64 @sailfin_runtime_string_length(i8* %t95)
  %t97 = icmp sgt i64 %t96, 0
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t99 = load i8*, i8** %l1
  %t100 = load double, double* %l2
  %t101 = load double, double* %l3
  %t102 = load i8, i8* %l4
  %t103 = load i8*, i8** %l5
  br i1 %t97, label %then19, label %merge20
then19:
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t105 = load i8*, i8** %l5
  %t106 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t107 = ptrtoint [1 x i8*]* %t106 to i64
  %t108 = icmp eq i64 %t107, 0
  %t109 = select i1 %t108, i64 1, i64 %t107
  %t110 = call i8* @malloc(i64 %t109)
  %t111 = bitcast i8* %t110 to i8**
  %t112 = getelementptr i8*, i8** %t111, i64 0
  store i8* %t105, i8** %t112
  %t113 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t114 = ptrtoint { i8**, i64 }* %t113 to i64
  %t115 = call i8* @malloc(i64 %t114)
  %t116 = bitcast i8* %t115 to { i8**, i64 }*
  %t117 = getelementptr { i8**, i64 }, { i8**, i64 }* %t116, i32 0, i32 0
  store i8** %t111, i8*** %t117
  %t118 = getelementptr { i8**, i64 }, { i8**, i64 }* %t116, i32 0, i32 1
  store i64 1, i64* %t118
  %t119 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t104, { i8**, i64 }* %t116)
  store { i8**, i64 }* %t119, { i8**, i64 }** %l0
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge20
merge20:
  %t121 = phi { i8**, i64 }* [ %t120, %then19 ], [ %t98, %then17 ]
  store { i8**, i64 }* %t121, { i8**, i64 }** %l0
  %s122 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s122, i8** %l1
  %t123 = load double, double* %l3
  %t124 = sitofp i64 1 to double
  %t125 = fadd double %t123, %t124
  store double %t125, double* %l3
  br label %loop.latch2
merge18:
  %t126 = load i8*, i8** %l1
  %t127 = load i8, i8* %l4
  %t128 = add i64 0, 2
  %t129 = call i8* @malloc(i64 %t128)
  store i8 %t127, i8* %t129
  %t130 = getelementptr i8, i8* %t129, i64 1
  store i8 0, i8* %t130
  call void @sailfin_runtime_mark_persistent(i8* %t129)
  %t131 = call i8* @sailfin_runtime_string_concat(i8* %t126, i8* %t129)
  store i8* %t131, i8** %l1
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t133 = load i8*, i8** %l1
  %t134 = load double, double* %l3
  %t135 = load i8*, i8** %l1
  br label %merge16
else15:
  %t136 = load i8*, i8** %l1
  %t137 = load i8, i8* %l4
  %t138 = add i64 0, 2
  %t139 = call i8* @malloc(i64 %t138)
  store i8 %t137, i8* %t139
  %t140 = getelementptr i8, i8* %t139, i64 1
  store i8 0, i8* %t140
  call void @sailfin_runtime_mark_persistent(i8* %t139)
  %t141 = call i8* @sailfin_runtime_string_concat(i8* %t136, i8* %t139)
  store i8* %t141, i8** %l1
  %t142 = load i8*, i8** %l1
  br label %merge16
merge16:
  %t143 = phi { i8**, i64 }* [ %t132, %merge18 ], [ %t80, %else15 ]
  %t144 = phi i8* [ %t133, %merge18 ], [ %t142, %else15 ]
  %t145 = phi double [ %t134, %merge18 ], [ %t83, %else15 ]
  store { i8**, i64 }* %t143, { i8**, i64 }** %l0
  store i8* %t144, i8** %l1
  store double %t145, double* %l3
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t147 = load i8*, i8** %l1
  %t148 = load double, double* %l3
  %t149 = load i8*, i8** %l1
  %t150 = load i8*, i8** %l1
  br label %merge11
merge11:
  %t151 = phi double [ %t76, %merge13 ], [ %t54, %merge16 ]
  %t152 = phi i8* [ %t77, %merge13 ], [ %t147, %merge16 ]
  %t153 = phi { i8**, i64 }* [ %t52, %merge13 ], [ %t146, %merge16 ]
  %t154 = phi double [ %t55, %merge13 ], [ %t148, %merge16 ]
  store double %t151, double* %l2
  store i8* %t152, i8** %l1
  store { i8**, i64 }* %t153, { i8**, i64 }** %l0
  store double %t154, double* %l3
  %t155 = load double, double* %l2
  %t156 = load i8*, i8** %l1
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t158 = load i8*, i8** %l1
  %t159 = load double, double* %l3
  %t160 = load i8*, i8** %l1
  %t161 = load i8*, i8** %l1
  br label %merge8
merge8:
  %t162 = phi double [ %t48, %then6 ], [ %t155, %merge11 ]
  %t163 = phi i8* [ %t49, %then6 ], [ %t156, %merge11 ]
  %t164 = phi { i8**, i64 }* [ %t34, %then6 ], [ %t157, %merge11 ]
  %t165 = phi double [ %t37, %then6 ], [ %t159, %merge11 ]
  store double %t162, double* %l2
  store i8* %t163, i8** %l1
  store { i8**, i64 }* %t164, { i8**, i64 }** %l0
  store double %t165, double* %l3
  %t166 = load double, double* %l3
  %t167 = sitofp i64 1 to double
  %t168 = fadd double %t166, %t167
  store double %t168, double* %l3
  br label %loop.latch2
loop.latch2:
  %t169 = load double, double* %l2
  %t170 = load i8*, i8** %l1
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t172 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t177 = load double, double* %l2
  %t178 = load i8*, i8** %l1
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t180 = load double, double* %l3
  %t181 = load i8*, i8** %l1
  %t182 = call i8* @trim_text(i8* %t181)
  store i8* %t182, i8** %l6
  %t183 = load i8*, i8** %l6
  %t184 = call i64 @sailfin_runtime_string_length(i8* %t183)
  %t185 = icmp sgt i64 %t184, 0
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t187 = load i8*, i8** %l1
  %t188 = load double, double* %l2
  %t189 = load double, double* %l3
  %t190 = load i8*, i8** %l6
  br i1 %t185, label %then21, label %merge22
then21:
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t192 = load i8*, i8** %l6
  %t193 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t194 = ptrtoint [1 x i8*]* %t193 to i64
  %t195 = icmp eq i64 %t194, 0
  %t196 = select i1 %t195, i64 1, i64 %t194
  %t197 = call i8* @malloc(i64 %t196)
  %t198 = bitcast i8* %t197 to i8**
  %t199 = getelementptr i8*, i8** %t198, i64 0
  store i8* %t192, i8** %t199
  %t200 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t201 = ptrtoint { i8**, i64 }* %t200 to i64
  %t202 = call i8* @malloc(i64 %t201)
  %t203 = bitcast i8* %t202 to { i8**, i64 }*
  %t204 = getelementptr { i8**, i64 }, { i8**, i64 }* %t203, i32 0, i32 0
  store i8** %t198, i8*** %t204
  %t205 = getelementptr { i8**, i64 }, { i8**, i64 }* %t203, i32 0, i32 1
  store i64 1, i64* %t205
  %t206 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t191, { i8**, i64 }* %t203)
  store { i8**, i64 }* %t206, { i8**, i64 }** %l0
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge22
merge22:
  %t208 = phi { i8**, i64 }* [ %t207, %then21 ], [ %t186, %afterloop3 ]
  store { i8**, i64 }* %t208, { i8**, i64 }** %l0
  %t209 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t209
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
  %s23 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s23)
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
  %t39 = call double @llvm.round.f64(double %t38)
  %t40 = fptosi double %t39 to i64
  %t41 = getelementptr i8, i8* %value, i64 %t40
  %t42 = load i8, i8* %t41
  %t43 = add i64 0, 2
  %t44 = call i8* @malloc(i64 %t43)
  store i8 %t42, i8* %t44
  %t45 = getelementptr i8, i8* %t44, i64 1
  store i8 0, i8* %t45
  call void @sailfin_runtime_mark_persistent(i8* %t44)
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t37, i8* %t44)
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
  call void @sailfin_runtime_mark_persistent(i8* %t56)
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
  %s76 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1045703541, i32 0, i32 0
  %t77 = load i8*, i8** %l4
  %t78 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t79 = extractvalue %MethodDeclaration %t78, 0
  %t80 = extractvalue %FunctionSignature %t79, 6
  %t81 = call %Token* @token_from_name(i8* %t77, %SourceSpan* %t80)
  %t82 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t75, i8* %s76, %Token* %t81)
  %t83 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 1
  %t84 = ptrtoint [1 x %Diagnostic]* %t83 to i64
  %t85 = icmp eq i64 %t84, 0
  %t86 = select i1 %t85, i64 1, i64 %t84
  %t87 = call i8* @malloc(i64 %t86)
  %t88 = bitcast i8* %t87 to %Diagnostic*
  %t89 = getelementptr %Diagnostic, %Diagnostic* %t88, i64 0
  store %Diagnostic %t82, %Diagnostic* %t89
  %t90 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t91 = ptrtoint { %Diagnostic*, i64 }* %t90 to i64
  %t92 = call i8* @malloc(i64 %t91)
  %t93 = bitcast i8* %t92 to { %Diagnostic*, i64 }*
  %t94 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t93, i32 0, i32 0
  store %Diagnostic* %t88, %Diagnostic** %t94
  %t95 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t93, i32 0, i32 1
  store i64 1, i64* %t95
  %t96 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t74, i32 0, i32 0
  %t97 = load %Diagnostic*, %Diagnostic** %t96
  %t98 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t74, i32 0, i32 1
  %t99 = load i64, i64* %t98
  %t100 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t93, i32 0, i32 0
  %t101 = load %Diagnostic*, %Diagnostic** %t100
  %t102 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t93, i32 0, i32 1
  %t103 = load i64, i64* %t102
  %t104 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t105 = ptrtoint %Diagnostic* %t104 to i64
  %t106 = add i64 %t99, %t103
  %t107 = mul i64 %t105, %t106
  %t108 = call noalias i8* @malloc(i64 %t107)
  %t109 = bitcast i8* %t108 to %Diagnostic*
  %t110 = bitcast %Diagnostic* %t109 to i8*
  %t111 = mul i64 %t105, %t99
  %t112 = bitcast %Diagnostic* %t97 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t110, i8* %t112, i64 %t111)
  %t113 = mul i64 %t105, %t103
  %t114 = bitcast %Diagnostic* %t101 to i8*
  %t115 = getelementptr %Diagnostic, %Diagnostic* %t109, i64 %t99
  %t116 = bitcast %Diagnostic* %t115 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t116, i8* %t114, i64 %t113)
  %t117 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t118 = ptrtoint { %Diagnostic*, i64 }* %t117 to i64
  %t119 = call i8* @malloc(i64 %t118)
  %t120 = bitcast i8* %t119 to { %Diagnostic*, i64 }*
  %t121 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t120, i32 0, i32 0
  store %Diagnostic* %t109, %Diagnostic** %t121
  %t122 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t120, i32 0, i32 1
  store i64 %t106, i64* %t122
  store { %Diagnostic*, i64 }* %t120, { %Diagnostic*, i64 }** %l1
  %t123 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t125 = load i8*, i8** %l4
  %t126 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t127 = ptrtoint [1 x i8*]* %t126 to i64
  %t128 = icmp eq i64 %t127, 0
  %t129 = select i1 %t128, i64 1, i64 %t127
  %t130 = call i8* @malloc(i64 %t129)
  %t131 = bitcast i8* %t130 to i8**
  %t132 = getelementptr i8*, i8** %t131, i64 0
  store i8* %t125, i8** %t132
  %t133 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t134 = ptrtoint { i8**, i64 }* %t133 to i64
  %t135 = call i8* @malloc(i64 %t134)
  %t136 = bitcast i8* %t135 to { i8**, i64 }*
  %t137 = getelementptr { i8**, i64 }, { i8**, i64 }* %t136, i32 0, i32 0
  store i8** %t131, i8*** %t137
  %t138 = getelementptr { i8**, i64 }, { i8**, i64 }* %t136, i32 0, i32 1
  store i64 1, i64* %t138
  %t139 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t124, { i8**, i64 }* %t136)
  store { i8**, i64 }* %t139, { i8**, i64 }** %l0
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t141 = phi { %Diagnostic*, i64 }* [ %t123, %then4 ], [ %t71, %else5 ]
  %t142 = phi { i8**, i64 }* [ %t70, %then4 ], [ %t140, %else5 ]
  store { %Diagnostic*, i64 }* %t141, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t142, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t143 = load i64, i64* %l2
  %t144 = add i64 %t143, 1
  store i64 %t144, i64* %l2
  br label %for0
afterfor3:
  %t145 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t147 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t147
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
  %t50 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 1
  %t51 = ptrtoint [1 x %Diagnostic]* %t50 to i64
  %t52 = icmp eq i64 %t51, 0
  %t53 = select i1 %t52, i64 1, i64 %t51
  %t54 = call i8* @malloc(i64 %t53)
  %t55 = bitcast i8* %t54 to %Diagnostic*
  %t56 = getelementptr %Diagnostic, %Diagnostic* %t55, i64 0
  store %Diagnostic %t49, %Diagnostic* %t56
  %t57 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t58 = ptrtoint { %Diagnostic*, i64 }* %t57 to i64
  %t59 = call i8* @malloc(i64 %t58)
  %t60 = bitcast i8* %t59 to { %Diagnostic*, i64 }*
  %t61 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t60, i32 0, i32 0
  store %Diagnostic* %t55, %Diagnostic** %t61
  %t62 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t60, i32 0, i32 1
  store i64 1, i64* %t62
  %t63 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t42, i32 0, i32 0
  %t64 = load %Diagnostic*, %Diagnostic** %t63
  %t65 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t42, i32 0, i32 1
  %t66 = load i64, i64* %t65
  %t67 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t60, i32 0, i32 0
  %t68 = load %Diagnostic*, %Diagnostic** %t67
  %t69 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t60, i32 0, i32 1
  %t70 = load i64, i64* %t69
  %t71 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t72 = ptrtoint %Diagnostic* %t71 to i64
  %t73 = add i64 %t66, %t70
  %t74 = mul i64 %t72, %t73
  %t75 = call noalias i8* @malloc(i64 %t74)
  %t76 = bitcast i8* %t75 to %Diagnostic*
  %t77 = bitcast %Diagnostic* %t76 to i8*
  %t78 = mul i64 %t72, %t66
  %t79 = bitcast %Diagnostic* %t64 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t77, i8* %t79, i64 %t78)
  %t80 = mul i64 %t72, %t70
  %t81 = bitcast %Diagnostic* %t68 to i8*
  %t82 = getelementptr %Diagnostic, %Diagnostic* %t76, i64 %t66
  %t83 = bitcast %Diagnostic* %t82 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t83, i8* %t81, i64 %t80)
  %t84 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t85 = ptrtoint { %Diagnostic*, i64 }* %t84 to i64
  %t86 = call i8* @malloc(i64 %t85)
  %t87 = bitcast i8* %t86 to { %Diagnostic*, i64 }*
  %t88 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t87, i32 0, i32 0
  store %Diagnostic* %t76, %Diagnostic** %t88
  %t89 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t87, i32 0, i32 1
  store i64 %t73, i64* %t89
  store { %Diagnostic*, i64 }* %t87, { %Diagnostic*, i64 }** %l1
  %t90 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t92 = load i8*, i8** %l4
  %t93 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t94 = ptrtoint [1 x i8*]* %t93 to i64
  %t95 = icmp eq i64 %t94, 0
  %t96 = select i1 %t95, i64 1, i64 %t94
  %t97 = call i8* @malloc(i64 %t96)
  %t98 = bitcast i8* %t97 to i8**
  %t99 = getelementptr i8*, i8** %t98, i64 0
  store i8* %t92, i8** %t99
  %t100 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t101 = ptrtoint { i8**, i64 }* %t100 to i64
  %t102 = call i8* @malloc(i64 %t101)
  %t103 = bitcast i8* %t102 to { i8**, i64 }*
  %t104 = getelementptr { i8**, i64 }, { i8**, i64 }* %t103, i32 0, i32 0
  store i8** %t98, i8*** %t104
  %t105 = getelementptr { i8**, i64 }, { i8**, i64 }* %t103, i32 0, i32 1
  store i64 1, i64* %t105
  %t106 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t91, { i8**, i64 }* %t103)
  store { i8**, i64 }* %t106, { i8**, i64 }** %l0
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t108 = phi { %Diagnostic*, i64 }* [ %t90, %then4 ], [ %t39, %else5 ]
  %t109 = phi { i8**, i64 }* [ %t38, %then4 ], [ %t107, %else5 ]
  store { %Diagnostic*, i64 }* %t108, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t109, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t110 = load i64, i64* %l2
  %t111 = add i64 %t110, 1
  store i64 %t111, i64* %l2
  br label %for0
afterfor3:
  %t112 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t114 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t114
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
  %s74 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h994638848, i32 0, i32 0
  %t75 = load i8*, i8** %l4
  %t76 = load %FunctionSignature, %FunctionSignature* %l3
  %t77 = extractvalue %FunctionSignature %t76, 6
  %t78 = call %Token* @token_from_name(i8* %t75, %SourceSpan* %t77)
  %t79 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t73, i8* %s74, %Token* %t78)
  %t80 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 1
  %t81 = ptrtoint [1 x %Diagnostic]* %t80 to i64
  %t82 = icmp eq i64 %t81, 0
  %t83 = select i1 %t82, i64 1, i64 %t81
  %t84 = call i8* @malloc(i64 %t83)
  %t85 = bitcast i8* %t84 to %Diagnostic*
  %t86 = getelementptr %Diagnostic, %Diagnostic* %t85, i64 0
  store %Diagnostic %t79, %Diagnostic* %t86
  %t87 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t88 = ptrtoint { %Diagnostic*, i64 }* %t87 to i64
  %t89 = call i8* @malloc(i64 %t88)
  %t90 = bitcast i8* %t89 to { %Diagnostic*, i64 }*
  %t91 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t90, i32 0, i32 0
  store %Diagnostic* %t85, %Diagnostic** %t91
  %t92 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t90, i32 0, i32 1
  store i64 1, i64* %t92
  %t93 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t72, i32 0, i32 0
  %t94 = load %Diagnostic*, %Diagnostic** %t93
  %t95 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t72, i32 0, i32 1
  %t96 = load i64, i64* %t95
  %t97 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t90, i32 0, i32 0
  %t98 = load %Diagnostic*, %Diagnostic** %t97
  %t99 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t90, i32 0, i32 1
  %t100 = load i64, i64* %t99
  %t101 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t102 = ptrtoint %Diagnostic* %t101 to i64
  %t103 = add i64 %t96, %t100
  %t104 = mul i64 %t102, %t103
  %t105 = call noalias i8* @malloc(i64 %t104)
  %t106 = bitcast i8* %t105 to %Diagnostic*
  %t107 = bitcast %Diagnostic* %t106 to i8*
  %t108 = mul i64 %t102, %t96
  %t109 = bitcast %Diagnostic* %t94 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t107, i8* %t109, i64 %t108)
  %t110 = mul i64 %t102, %t100
  %t111 = bitcast %Diagnostic* %t98 to i8*
  %t112 = getelementptr %Diagnostic, %Diagnostic* %t106, i64 %t96
  %t113 = bitcast %Diagnostic* %t112 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t113, i8* %t111, i64 %t110)
  %t114 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t115 = ptrtoint { %Diagnostic*, i64 }* %t114 to i64
  %t116 = call i8* @malloc(i64 %t115)
  %t117 = bitcast i8* %t116 to { %Diagnostic*, i64 }*
  %t118 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t117, i32 0, i32 0
  store %Diagnostic* %t106, %Diagnostic** %t118
  %t119 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t117, i32 0, i32 1
  store i64 %t103, i64* %t119
  store { %Diagnostic*, i64 }* %t117, { %Diagnostic*, i64 }** %l1
  %t120 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t122 = load i8*, i8** %l4
  %t123 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t124 = ptrtoint [1 x i8*]* %t123 to i64
  %t125 = icmp eq i64 %t124, 0
  %t126 = select i1 %t125, i64 1, i64 %t124
  %t127 = call i8* @malloc(i64 %t126)
  %t128 = bitcast i8* %t127 to i8**
  %t129 = getelementptr i8*, i8** %t128, i64 0
  store i8* %t122, i8** %t129
  %t130 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t131 = ptrtoint { i8**, i64 }* %t130 to i64
  %t132 = call i8* @malloc(i64 %t131)
  %t133 = bitcast i8* %t132 to { i8**, i64 }*
  %t134 = getelementptr { i8**, i64 }, { i8**, i64 }* %t133, i32 0, i32 0
  store i8** %t128, i8*** %t134
  %t135 = getelementptr { i8**, i64 }, { i8**, i64 }* %t133, i32 0, i32 1
  store i64 1, i64* %t135
  %t136 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t121, { i8**, i64 }* %t133)
  store { i8**, i64 }* %t136, { i8**, i64 }** %l0
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t138 = phi { %Diagnostic*, i64 }* [ %t120, %then4 ], [ %t69, %else5 ]
  %t139 = phi { i8**, i64 }* [ %t68, %then4 ], [ %t137, %else5 ]
  store { %Diagnostic*, i64 }* %t138, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t139, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t140 = load i64, i64* %l2
  %t141 = add i64 %t140, 1
  store i64 %t141, i64* %l2
  br label %for0
afterfor3:
  %t142 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t144 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t144
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
  %t50 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 1
  %t51 = ptrtoint [1 x %Diagnostic]* %t50 to i64
  %t52 = icmp eq i64 %t51, 0
  %t53 = select i1 %t52, i64 1, i64 %t51
  %t54 = call i8* @malloc(i64 %t53)
  %t55 = bitcast i8* %t54 to %Diagnostic*
  %t56 = getelementptr %Diagnostic, %Diagnostic* %t55, i64 0
  store %Diagnostic %t49, %Diagnostic* %t56
  %t57 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t58 = ptrtoint { %Diagnostic*, i64 }* %t57 to i64
  %t59 = call i8* @malloc(i64 %t58)
  %t60 = bitcast i8* %t59 to { %Diagnostic*, i64 }*
  %t61 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t60, i32 0, i32 0
  store %Diagnostic* %t55, %Diagnostic** %t61
  %t62 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t60, i32 0, i32 1
  store i64 1, i64* %t62
  %t63 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t42, i32 0, i32 0
  %t64 = load %Diagnostic*, %Diagnostic** %t63
  %t65 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t42, i32 0, i32 1
  %t66 = load i64, i64* %t65
  %t67 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t60, i32 0, i32 0
  %t68 = load %Diagnostic*, %Diagnostic** %t67
  %t69 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t60, i32 0, i32 1
  %t70 = load i64, i64* %t69
  %t71 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t72 = ptrtoint %Diagnostic* %t71 to i64
  %t73 = add i64 %t66, %t70
  %t74 = mul i64 %t72, %t73
  %t75 = call noalias i8* @malloc(i64 %t74)
  %t76 = bitcast i8* %t75 to %Diagnostic*
  %t77 = bitcast %Diagnostic* %t76 to i8*
  %t78 = mul i64 %t72, %t66
  %t79 = bitcast %Diagnostic* %t64 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t77, i8* %t79, i64 %t78)
  %t80 = mul i64 %t72, %t70
  %t81 = bitcast %Diagnostic* %t68 to i8*
  %t82 = getelementptr %Diagnostic, %Diagnostic* %t76, i64 %t66
  %t83 = bitcast %Diagnostic* %t82 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t83, i8* %t81, i64 %t80)
  %t84 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t85 = ptrtoint { %Diagnostic*, i64 }* %t84 to i64
  %t86 = call i8* @malloc(i64 %t85)
  %t87 = bitcast i8* %t86 to { %Diagnostic*, i64 }*
  %t88 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t87, i32 0, i32 0
  store %Diagnostic* %t76, %Diagnostic** %t88
  %t89 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t87, i32 0, i32 1
  store i64 %t73, i64* %t89
  store { %Diagnostic*, i64 }* %t87, { %Diagnostic*, i64 }** %l1
  %t90 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t92 = load i8*, i8** %l4
  %t93 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t94 = ptrtoint [1 x i8*]* %t93 to i64
  %t95 = icmp eq i64 %t94, 0
  %t96 = select i1 %t95, i64 1, i64 %t94
  %t97 = call i8* @malloc(i64 %t96)
  %t98 = bitcast i8* %t97 to i8**
  %t99 = getelementptr i8*, i8** %t98, i64 0
  store i8* %t92, i8** %t99
  %t100 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t101 = ptrtoint { i8**, i64 }* %t100 to i64
  %t102 = call i8* @malloc(i64 %t101)
  %t103 = bitcast i8* %t102 to { i8**, i64 }*
  %t104 = getelementptr { i8**, i64 }, { i8**, i64 }* %t103, i32 0, i32 0
  store i8** %t98, i8*** %t104
  %t105 = getelementptr { i8**, i64 }, { i8**, i64 }* %t103, i32 0, i32 1
  store i64 1, i64* %t105
  %t106 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t91, { i8**, i64 }* %t103)
  store { i8**, i64 }* %t106, { i8**, i64 }** %l0
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t108 = phi { %Diagnostic*, i64 }* [ %t90, %then4 ], [ %t39, %else5 ]
  %t109 = phi { i8**, i64 }* [ %t38, %then4 ], [ %t107, %else5 ]
  store { %Diagnostic*, i64 }* %t108, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t109, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t110 = load i64, i64* %l2
  %t111 = add i64 %t110, 1
  store i64 %t111, i64* %l2
  br label %for0
afterfor3:
  %t112 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t114 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t114
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
  %s44 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h513489323, i32 0, i32 0
  %t45 = load i8*, i8** %l4
  %t46 = load %TypeParameter, %TypeParameter* %l3
  %t47 = extractvalue %TypeParameter %t46, 2
  %t48 = call %Token* @token_from_name(i8* %t45, %SourceSpan* %t47)
  %t49 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %t43, i8* %s44, %Token* %t48)
  %t50 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 1
  %t51 = ptrtoint [1 x %Diagnostic]* %t50 to i64
  %t52 = icmp eq i64 %t51, 0
  %t53 = select i1 %t52, i64 1, i64 %t51
  %t54 = call i8* @malloc(i64 %t53)
  %t55 = bitcast i8* %t54 to %Diagnostic*
  %t56 = getelementptr %Diagnostic, %Diagnostic* %t55, i64 0
  store %Diagnostic %t49, %Diagnostic* %t56
  %t57 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t58 = ptrtoint { %Diagnostic*, i64 }* %t57 to i64
  %t59 = call i8* @malloc(i64 %t58)
  %t60 = bitcast i8* %t59 to { %Diagnostic*, i64 }*
  %t61 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t60, i32 0, i32 0
  store %Diagnostic* %t55, %Diagnostic** %t61
  %t62 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t60, i32 0, i32 1
  store i64 1, i64* %t62
  %t63 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t42, i32 0, i32 0
  %t64 = load %Diagnostic*, %Diagnostic** %t63
  %t65 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t42, i32 0, i32 1
  %t66 = load i64, i64* %t65
  %t67 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t60, i32 0, i32 0
  %t68 = load %Diagnostic*, %Diagnostic** %t67
  %t69 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t60, i32 0, i32 1
  %t70 = load i64, i64* %t69
  %t71 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* null, i32 0, i32 1
  %t72 = ptrtoint %Diagnostic* %t71 to i64
  %t73 = add i64 %t66, %t70
  %t74 = mul i64 %t72, %t73
  %t75 = call noalias i8* @malloc(i64 %t74)
  %t76 = bitcast i8* %t75 to %Diagnostic*
  %t77 = bitcast %Diagnostic* %t76 to i8*
  %t78 = mul i64 %t72, %t66
  %t79 = bitcast %Diagnostic* %t64 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t77, i8* %t79, i64 %t78)
  %t80 = mul i64 %t72, %t70
  %t81 = bitcast %Diagnostic* %t68 to i8*
  %t82 = getelementptr %Diagnostic, %Diagnostic* %t76, i64 %t66
  %t83 = bitcast %Diagnostic* %t82 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t83, i8* %t81, i64 %t80)
  %t84 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* null, i32 1
  %t85 = ptrtoint { %Diagnostic*, i64 }* %t84 to i64
  %t86 = call i8* @malloc(i64 %t85)
  %t87 = bitcast i8* %t86 to { %Diagnostic*, i64 }*
  %t88 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t87, i32 0, i32 0
  store %Diagnostic* %t76, %Diagnostic** %t88
  %t89 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t87, i32 0, i32 1
  store i64 %t73, i64* %t89
  store { %Diagnostic*, i64 }* %t87, { %Diagnostic*, i64 }** %l1
  %t90 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  br label %merge6
else5:
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t92 = load i8*, i8** %l4
  %t93 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t94 = ptrtoint [1 x i8*]* %t93 to i64
  %t95 = icmp eq i64 %t94, 0
  %t96 = select i1 %t95, i64 1, i64 %t94
  %t97 = call i8* @malloc(i64 %t96)
  %t98 = bitcast i8* %t97 to i8**
  %t99 = getelementptr i8*, i8** %t98, i64 0
  store i8* %t92, i8** %t99
  %t100 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t101 = ptrtoint { i8**, i64 }* %t100 to i64
  %t102 = call i8* @malloc(i64 %t101)
  %t103 = bitcast i8* %t102 to { i8**, i64 }*
  %t104 = getelementptr { i8**, i64 }, { i8**, i64 }* %t103, i32 0, i32 0
  store i8** %t98, i8*** %t104
  %t105 = getelementptr { i8**, i64 }, { i8**, i64 }* %t103, i32 0, i32 1
  store i64 1, i64* %t105
  %t106 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t91, { i8**, i64 }* %t103)
  store { i8**, i64 }* %t106, { i8**, i64 }** %l0
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t108 = phi { %Diagnostic*, i64 }* [ %t90, %then4 ], [ %t39, %else5 ]
  %t109 = phi { i8**, i64 }* [ %t38, %then4 ], [ %t107, %else5 ]
  store { %Diagnostic*, i64 }* %t108, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t109, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t110 = load i64, i64* %l2
  %t111 = add i64 %t110, 1
  store i64 %t111, i64* %l2
  br label %for0
afterfor3:
  %t112 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t114 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t114
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
  %t135 = phi { %Diagnostic*, i64 }* [ %t15, %block.entry ], [ %t133, %loop.latch2 ]
  %t136 = phi double [ %t16, %block.entry ], [ %t134, %loop.latch2 ]
  store { %Diagnostic*, i64 }* %t135, { %Diagnostic*, i64 }** %l1
  store double %t136, double* %l2
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
  %t126 = phi { %Diagnostic*, i64 }* [ %t38, %merge5 ], [ %t124, %loop.latch8 ]
  %t127 = phi double [ %t41, %merge5 ], [ %t125, %loop.latch8 ]
  store { %Diagnostic*, i64 }* %t126, { %Diagnostic*, i64 }** %l1
  store double %t127, double* %l4
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
  %s70 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h902271367, i32 0, i32 0
  %t71 = insertvalue %Diagnostic undef, i8* %s70, 0
  %t72 = load %EffectViolation, %EffectViolation* %l3
  %t73 = extractvalue %EffectViolation %t72, 0
  %t74 = load i8*, i8** %l5
  %t75 = load %EffectRequirement*, %EffectRequirement** %l6
  %t76 = call i8* @format_effect_message(i8* %t73, i8* %t74, %EffectRequirement* %t75)
  %t77 = insertvalue %Diagnostic %t71, i8* %t76, 1
  %t78 = load %EffectRequirement*, %EffectRequirement** %l6
  %t79 = call %Token* @requirement_primary_token(%EffectRequirement* %t78)
  %t80 = insertvalue %Diagnostic %t77, %Token* %t79, 2
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
  %t94 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t69, i32 0, i32 0
  %t95 = load %Diagnostic*, %Diagnostic** %t94
  %t96 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t69, i32 0, i32 1
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
  %t121 = load double, double* %l4
  %t122 = sitofp i64 1 to double
  %t123 = fadd double %t121, %t122
  store double %t123, double* %l4
  br label %loop.latch8
loop.latch8:
  %t124 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t125 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t128 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t129 = load double, double* %l4
  %t130 = load double, double* %l2
  %t131 = sitofp i64 1 to double
  %t132 = fadd double %t130, %t131
  store double %t132, double* %l2
  br label %loop.latch2
loop.latch2:
  %t133 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t134 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t137 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t138 = load double, double* %l2
  %t139 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t139
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
  %s0 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1863181231, i32 0, i32 0
  %t1 = call i8* @sailfin_runtime_string_concat(i8* %routine_name, i8* %s0)
  %t2 = call i8* @sailfin_runtime_string_concat(i8* %t1, i8* %effect)
  %t3 = add i64 0, 2
  %t4 = call i8* @malloc(i64 %t3)
  store i8 39, i8* %t4
  %t5 = getelementptr i8, i8* %t4, i64 1
  store i8 0, i8* %t5
  call void @sailfin_runtime_mark_persistent(i8* %t4)
  %t6 = call i8* @sailfin_runtime_string_concat(i8* %t2, i8* %t4)
  store i8* %t6, i8** %l0
  %t7 = icmp ne %EffectRequirement* %requirement, null
  %t8 = load i8*, i8** %l0
  br i1 %t7, label %then0, label %merge1
then0:
  %t9 = load i8*, i8** %l0
  %s10 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h980936743, i32 0, i32 0
  %t11 = call i8* @sailfin_runtime_string_concat(i8* %t9, i8* %s10)
  %t12 = getelementptr %EffectRequirement, %EffectRequirement* %requirement, i32 0, i32 2
  %t13 = load i8*, i8** %t12
  %t14 = call i8* @sailfin_runtime_string_concat(i8* %t11, i8* %t13)
  store i8* %t14, i8** %l0
  %t15 = load i8*, i8** %l0
  br label %merge1
merge1:
  %t16 = phi i8* [ %t15, %then0 ], [ %t8, %block.entry ]
  store i8* %t16, i8** %l0
  %t17 = load i8*, i8** %l0
  %s18 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1876709041, i32 0, i32 0
  %t19 = call i8* @sailfin_runtime_string_concat(i8* %t17, i8* %s18)
  %t20 = call i8* @sailfin_runtime_string_concat(i8* %t19, i8* %effect)
  %s21 = getelementptr inbounds [61 x i8], [61 x i8]* @.str.len60.h1899438158, i32 0, i32 0
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %t20, i8* %s21)
  store i8* %t22, i8** %l0
  %t23 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t23)
  ret i8* %t23
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
  %t10 = add i64 0, 2
  %t11 = call i8* @malloc(i64 %t10)
  store i8 96, i8* %t11
  %t12 = getelementptr i8, i8* %t11, i64 1
  store i8 0, i8* %t12
  call void @sailfin_runtime_mark_persistent(i8* %t11)
  %t13 = call i8* @sailfin_runtime_string_concat(i8* %t9, i8* %t11)
  %t14 = insertvalue %Diagnostic %t1, i8* %t13, 1
  %t15 = bitcast i8* null to %Token*
  %t16 = insertvalue %Diagnostic %t14, %Token* %t15, 2
  ret %Diagnostic %t16
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
@.str.len15.h579804543 = private unnamed_addr constant [16 x i8] c"EnumDeclaration\00"
@.enum.Statement.ToolDeclaration.variant = private unnamed_addr constant [16 x i8] c"ToolDeclaration\00"
@.enum.Statement.ReturnStatement.variant = private unnamed_addr constant [16 x i8] c"ReturnStatement\00"
@.enum.Statement.PipelineDeclaration.variant = private unnamed_addr constant [20 x i8] c"PipelineDeclaration\00"
@.enum.Statement.TestDeclaration.variant = private unnamed_addr constant [16 x i8] c"TestDeclaration\00"
@.str.len4.h275477867 = private unnamed_addr constant [5 x i8] c"test\00"
@.str.len19.h486335986 = private unnamed_addr constant [20 x i8] c"FunctionDeclaration\00"
@.str.len16.h994638848 = private unnamed_addr constant [17 x i8] c"interface member\00"
@.enum.Statement.VariableDeclaration.variant = private unnamed_addr constant [20 x i8] c"VariableDeclaration\00"
@.str.len4.h276192845 = private unnamed_addr constant [5 x i8] c"type\00"
@.str.len14.h196308685 = private unnamed_addr constant [15 x i8] c"MatchStatement\00"
@.enum.Statement.ImportDeclaration.variant = private unnamed_addr constant [18 x i8] c"ImportDeclaration\00"
@.str.len6.h789690461 = private unnamed_addr constant [7 x i8] c"struct\00"
@.str.len11.h1566780570 = private unnamed_addr constant [12 x i8] c"IfStatement\00"
@.str.len12.h328844387 = private unnamed_addr constant [13 x i8] c"enum variant\00"
@.str.len19.h479148896 = private unnamed_addr constant [20 x i8] c"PipelineDeclaration\00"
@.enum.Statement.MatchStatement.variant = private unnamed_addr constant [15 x i8] c"MatchStatement\00"
@.enum.Statement.EnumDeclaration.variant = private unnamed_addr constant [16 x i8] c"EnumDeclaration\00"
@.str.len4.h275832617 = private unnamed_addr constant [5 x i8] c"tool\00"
@.str.len14.h812083909 = private unnamed_addr constant [15 x i8] c"model property\00"
@.str.len8.h1603982015 = private unnamed_addr constant [9 x i8] c"function\00"
@.enum.Statement.BreakStatement.variant = private unnamed_addr constant [15 x i8] c"BreakStatement\00"
@.enum.Statement.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.str.len9.h1313193687 = private unnamed_addr constant [10 x i8] c"interface\00"
@.enum.Statement.ContinueStatement.variant = private unnamed_addr constant [18 x i8] c"ContinueStatement\00"
@.enum.Statement.TypeAliasDeclaration.variant = private unnamed_addr constant [21 x i8] c"TypeAliasDeclaration\00"
@.str.len20.h666604742 = private unnamed_addr constant [21 x i8] c"InterfaceDeclaration\00"
@.str.len12.h766506979 = private unnamed_addr constant [13 x i8] c"struct field\00"
@.str.len8.h1925814595 = private unnamed_addr constant [9 x i8] c"variable\00"
@.enum.Statement.IfStatement.variant = private unnamed_addr constant [12 x i8] c"IfStatement\00"
@.enum.Statement.ExportDeclaration.variant = private unnamed_addr constant [18 x i8] c"ExportDeclaration\00"
@.str.len5.h238194529 = private unnamed_addr constant [6 x i8] c"model\00"
@.str.len15.h571715647 = private unnamed_addr constant [16 x i8] c"ToolDeclaration\00"
@.str.len16.h2043328844 = private unnamed_addr constant [17 x i8] c"ModelDeclaration\00"
@.str.len8.h2003786807 = private unnamed_addr constant [9 x i8] c"pipeline\00"
@.str.len14.h513489323 = private unnamed_addr constant [15 x i8] c"type parameter\00"
@.str.len19.h1204027478 = private unnamed_addr constant [20 x i8] c"VariableDeclaration\00"
@.enum.Statement.Unknown.variant = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.str.len9.h1747065903 = private unnamed_addr constant [10 x i8] c"parameter\00"
@.enum.Statement.ForStatement.variant = private unnamed_addr constant [13 x i8] c"ForStatement\00"
@.enum.Statement.InterfaceDeclaration.variant = private unnamed_addr constant [21 x i8] c"InterfaceDeclaration\00"
@.enum.Statement.ModelDeclaration.variant = private unnamed_addr constant [17 x i8] c"ModelDeclaration\00"
@.str.len12.h84042670 = private unnamed_addr constant [13 x i8] c"ForStatement\00"
@.enum.Statement.StructDeclaration.variant = private unnamed_addr constant [18 x i8] c"StructDeclaration\00"
@.str.len13.h1925822000 = private unnamed_addr constant [14 x i8] c"WithStatement\00"
@.enum.Statement.LoopStatement.variant = private unnamed_addr constant [14 x i8] c"LoopStatement\00"
@.enum.Statement.FunctionDeclaration.variant = private unnamed_addr constant [20 x i8] c"FunctionDeclaration\00"
@.str.len20.h1496093543 = private unnamed_addr constant [21 x i8] c"TypeAliasDeclaration\00"
@.str.len14.h980936743 = private unnamed_addr constant [15 x i8] c"; required by \00"
@.enum.Statement.WithStatement.variant = private unnamed_addr constant [14 x i8] c"WithStatement\00"
@.enum.Statement.PromptStatement.variant = private unnamed_addr constant [16 x i8] c"PromptStatement\00"
@.str.len15.h1067284810 = private unnamed_addr constant [16 x i8] c"PromptStatement\00"
@.str.len4.h258014432 = private unnamed_addr constant [5 x i8] c"enum\00"
@.str.len15.h889179835 = private unnamed_addr constant [16 x i8] c"TestDeclaration\00"
@.str.len15.h902271367 = private unnamed_addr constant [16 x i8] c"effects.missing\00"
@.str.len6.h1045703541 = private unnamed_addr constant [7 x i8] c"method\00"
@.enum.Statement.ExpressionStatement.variant = private unnamed_addr constant [20 x i8] c"ExpressionStatement\00"
@.str.len17.h1842783069 = private unnamed_addr constant [18 x i8] c"StructDeclaration\00"