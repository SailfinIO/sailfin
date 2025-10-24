; ModuleID = 'sailfin'
source_filename = "sailfin"

%EffectRequirement = type { i8*, %Token*, i8* }
%EffectViolation = type { i8*, { i8**, i64 }*, { %EffectRequirement**, i64 }* }
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
%DecoratorArgumentInfo = type { i8*, %LiteralValue }
%DecoratorInfo = type { i8*, { %DecoratorArgumentInfo**, i64 }* }

%Expression = type { i32, [24 x i8] }
%Statement = type { i32, [56 x i8] }
%TokenKind = type { i32, [8 x i8] }
%LiteralValue = type { i32, [8 x i8] }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)

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
@.str.len19.h486335986 = private unnamed_addr constant [20 x i8] c"FunctionDeclaration\00"
@.str.len19.h479148896 = private unnamed_addr constant [20 x i8] c"PipelineDeclaration\00"
@.str.len9.h1700456022 = private unnamed_addr constant [10 x i8] c"pipeline \00"
@.str.len15.h571715647 = private unnamed_addr constant [16 x i8] c"ToolDeclaration\00"
@.str.len5.h512542702 = private unnamed_addr constant [6 x i8] c"tool \00"
@.str.len15.h889179835 = private unnamed_addr constant [16 x i8] c"TestDeclaration\00"
@.str.len5.h500835952 = private unnamed_addr constant [6 x i8] c"test \00"
@.str.len17.h1842783069 = private unnamed_addr constant [18 x i8] c"StructDeclaration\00"
@.str.len5.h515589823 = private unnamed_addr constant [6 x i8] c"trace\00"
@.str.len12.h1147459442 = private unnamed_addr constant [13 x i8] c"logExecution\00"
@.str.len12.h1170311443 = private unnamed_addr constant [13 x i8] c"logexecution\00"
@.str.len2.h193495007 = private unnamed_addr constant [3 x i8] c"io\00"
@.str.len15.h1067284810 = private unnamed_addr constant [16 x i8] c"PromptStatement\00"
@.str.len5.h238194529 = private unnamed_addr constant [6 x i8] c"model\00"
@.str.len8.h196867800 = private unnamed_addr constant [9 x i8] c"prompt \22\00"
@.str.len13.h1925822000 = private unnamed_addr constant [14 x i8] c"WithStatement\00"
@.str.len12.h84042670 = private unnamed_addr constant [13 x i8] c"ForStatement\00"
@.str.len13.h1678412334 = private unnamed_addr constant [14 x i8] c"LoopStatement\00"
@.str.len14.h196308685 = private unnamed_addr constant [15 x i8] c"MatchStatement\00"
@.str.len11.h1566780570 = private unnamed_addr constant [12 x i8] c"IfStatement\00"
@.str.len15.h1613933868 = private unnamed_addr constant [16 x i8] c"ReturnStatement\00"
@.str.len19.h868168677 = private unnamed_addr constant [20 x i8] c"ExpressionStatement\00"
@.str.len19.h1204027478 = private unnamed_addr constant [20 x i8] c"VariableDeclaration\00"
@.str.len16.h2043328844 = private unnamed_addr constant [17 x i8] c"ModelDeclaration\00"
@.str.len7.h48777630 = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.enum.Expression.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.enum.Expression.Identifier.variant = private unnamed_addr constant [11 x i8] c"Identifier\00"
@.enum.Expression.NumberLiteral.variant = private unnamed_addr constant [14 x i8] c"NumberLiteral\00"
@.enum.Expression.StringLiteral.variant = private unnamed_addr constant [14 x i8] c"StringLiteral\00"
@.enum.Expression.BooleanLiteral.variant = private unnamed_addr constant [15 x i8] c"BooleanLiteral\00"
@.enum.Expression.NullLiteral.variant = private unnamed_addr constant [12 x i8] c"NullLiteral\00"
@.enum.Expression.Unary.variant = private unnamed_addr constant [6 x i8] c"Unary\00"
@.enum.Expression.Binary.variant = private unnamed_addr constant [7 x i8] c"Binary\00"
@.enum.Expression.Member.variant = private unnamed_addr constant [7 x i8] c"Member\00"
@.enum.Expression.Call.variant = private unnamed_addr constant [5 x i8] c"Call\00"
@.enum.Expression.Index.variant = private unnamed_addr constant [6 x i8] c"Index\00"
@.enum.Expression.Array.variant = private unnamed_addr constant [6 x i8] c"Array\00"
@.enum.Expression.Object.variant = private unnamed_addr constant [7 x i8] c"Object\00"
@.enum.Expression.Struct.variant = private unnamed_addr constant [7 x i8] c"Struct\00"
@.enum.Expression.Lambda.variant = private unnamed_addr constant [7 x i8] c"Lambda\00"
@.enum.Expression.Range.variant = private unnamed_addr constant [6 x i8] c"Range\00"
@.enum.Expression.Raw.variant = private unnamed_addr constant [4 x i8] c"Raw\00"
@.str.len4.h217216103 = private unnamed_addr constant [5 x i8] c"Call\00"
@.str.len6.h512390329 = private unnamed_addr constant [7 x i8] c"Member\00"
@.str.len5.h1445149598 = private unnamed_addr constant [6 x i8] c"Unary\00"
@.str.len6.h1496334143 = private unnamed_addr constant [7 x i8] c"Binary\00"
@.str.len5.h667777838 = private unnamed_addr constant [6 x i8] c"Array\00"
@.str.len6.h826984377 = private unnamed_addr constant [7 x i8] c"Object\00"
@.str.len6.h264904746 = private unnamed_addr constant [7 x i8] c"Struct\00"
@.str.len6.h1211862785 = private unnamed_addr constant [7 x i8] c"Lambda\00"
@.str.len5.h975618503 = private unnamed_addr constant [6 x i8] c"Index\00"
@.str.len5.h1312780988 = private unnamed_addr constant [6 x i8] c"Range\00"
@.str.len3.h2089530004 = private unnamed_addr constant [4 x i8] c"Raw\00"
@.str.len2.h193491872 = private unnamed_addr constant [3 x i8] c"fs\00"
@.str.len23.h509166939 = private unnamed_addr constant [24 x i8] c"filesystem helper usage\00"
@.str.len5.h359348221 = private unnamed_addr constant [6 x i8] c"print\00"
@.str.len18.h166827074 = private unnamed_addr constant [19 x i8] c"print helper usage\00"
@.str.len7.h1121316919 = private unnamed_addr constant [8 x i8] c"console\00"
@.str.len20.h1840566713 = private unnamed_addr constant [21 x i8] c"console helper usage\00"
@.str.len4.h261786827 = private unnamed_addr constant [5 x i8] c"http\00"
@.str.len3.h2090540497 = private unnamed_addr constant [4 x i8] c"net\00"
@.str.len17.h959371065 = private unnamed_addr constant [18 x i8] c"http helper usage\00"
@.str.len9.h6052019 = private unnamed_addr constant [10 x i8] c"websocket\00"
@.str.len22.h857956175 = private unnamed_addr constant [23 x i8] c"websocket helper usage\00"
@.str.len5.h474104665 = private unnamed_addr constant [6 x i8] c"spawn\00"
@.str.len10.h1970595328 = private unnamed_addr constant [11 x i8] c"spawn call\00"
@.str.len5.h461669077 = private unnamed_addr constant [6 x i8] c"serve\00"
@.str.len10.h1681046972 = private unnamed_addr constant [11 x i8] c"serve call\00"
@.str.len5.h469485193 = private unnamed_addr constant [6 x i8] c"sleep\00"
@.str.len5.h1991159579 = private unnamed_addr constant [6 x i8] c"clock\00"
@.str.len10.h881761880 = private unnamed_addr constant [11 x i8] c"sleep call\00"
@.str.len6.h1128151960 = private unnamed_addr constant [7 x i8] c"prompt\00"
@.str.len12.h10983220 = private unnamed_addr constant [13 x i8] c"prompt block\00"
@.enum.TokenKind.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.enum.TokenKind.Identifier.variant = private unnamed_addr constant [11 x i8] c"Identifier\00"
@.enum.TokenKind.NumberLiteral.variant = private unnamed_addr constant [14 x i8] c"NumberLiteral\00"
@.enum.TokenKind.StringLiteral.variant = private unnamed_addr constant [14 x i8] c"StringLiteral\00"
@.enum.TokenKind.BooleanLiteral.variant = private unnamed_addr constant [15 x i8] c"BooleanLiteral\00"
@.enum.TokenKind.Symbol.variant = private unnamed_addr constant [7 x i8] c"Symbol\00"
@.enum.TokenKind.Whitespace.variant = private unnamed_addr constant [11 x i8] c"Whitespace\00"
@.enum.TokenKind.Comment.variant = private unnamed_addr constant [8 x i8] c"Comment\00"
@.enum.TokenKind.EndOfFile.variant = private unnamed_addr constant [10 x i8] c"EndOfFile\00"
@.str.len10.h1576352120 = private unnamed_addr constant [11 x i8] c"Identifier\00"
@.str.len13.h590768815 = private unnamed_addr constant [14 x i8] c"StringLiteral\00"
@.str.len7.h721793546 = private unnamed_addr constant [8 x i8] c"prompt \00"
@.str.len10.h715288307 = private unnamed_addr constant [11 x i8] c"Whitespace\00"
@.str.len7.h936649884 = private unnamed_addr constant [8 x i8] c"Comment\00"
@.str.len6.h453982107 = private unnamed_addr constant [7 x i8] c"Symbol\00"

define { %EffectViolation*, i64 }* @validate_effects(%Program %program) {
entry:
  %l0 = alloca { %EffectViolation*, i64 }*
  %l1 = alloca double
  %l2 = alloca %Statement*
  %t0 = alloca [0 x %EffectViolation]
  %t1 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t0, i32 0, i32 0
  %t2 = alloca { %EffectViolation*, i64 }
  %t3 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t2, i32 0, i32 0
  store %EffectViolation* %t1, %EffectViolation** %t3
  %t4 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %EffectViolation*, i64 }* %t2, { %EffectViolation*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t35 = phi { %EffectViolation*, i64 }* [ %t6, %entry ], [ %t33, %loop.latch2 ]
  %t36 = phi double [ %t7, %entry ], [ %t34, %loop.latch2 ]
  store { %EffectViolation*, i64 }* %t35, { %EffectViolation*, i64 }** %l0
  store double %t36, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %Program %program, 0
  %t10 = load { %Statement**, i64 }, { %Statement**, i64 }* %t9
  %t11 = extractvalue { %Statement**, i64 } %t10, 1
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t8, %t12
  %t14 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t15 = load double, double* %l1
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t16 = extractvalue %Program %program, 0
  %t17 = load double, double* %l1
  %t18 = fptosi double %t17 to i64
  %t19 = load { %Statement**, i64 }, { %Statement**, i64 }* %t16
  %t20 = extractvalue { %Statement**, i64 } %t19, 0
  %t21 = extractvalue { %Statement**, i64 } %t19, 1
  %t22 = icmp uge i64 %t18, %t21
  ; bounds check: %t22 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t18, i64 %t21)
  %t23 = getelementptr %Statement*, %Statement** %t20, i64 %t18
  %t24 = load %Statement*, %Statement** %t23
  store %Statement* %t24, %Statement** %l2
  %t25 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t26 = load %Statement*, %Statement** %l2
  %t27 = load %Statement, %Statement* %t26
  %t28 = call { %EffectViolation*, i64 }* @analyze_statement(%Statement %t27)
  %t29 = call { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }* %t25, { %EffectViolation*, i64 }* %t28)
  store { %EffectViolation*, i64 }* %t29, { %EffectViolation*, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch2
loop.latch2:
  %t33 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t34 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t37 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t38 = load double, double* %l1
  %t39 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  ret { %EffectViolation*, i64 }* %t39
}

define { %EffectViolation*, i64 }* @analyze_statement(%Statement %statement) {
entry:
  %l0 = alloca %FunctionSignature
  %l1 = alloca i8*
  %l2 = alloca %FunctionSignature
  %l3 = alloca i8*
  %l4 = alloca %FunctionSignature
  %l5 = alloca i8*
  %l6 = alloca { %EffectViolation*, i64 }*
  %l7 = alloca double
  %l8 = alloca %MethodDeclaration*
  %l9 = alloca i8
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
  %t93 = extractvalue %Statement %statement, 0
  %t94 = alloca %Statement
  store %Statement %statement, %Statement* %t94
  %t95 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t96 = bitcast [24 x i8]* %t95 to i8*
  %t97 = getelementptr inbounds i8, i8* %t96, i64 8
  %t98 = bitcast i8* %t97 to %Block*
  %t99 = load %Block, %Block* %t98
  %t100 = icmp eq i32 %t93, 4
  %t101 = select i1 %t100, %Block %t99, %Block zeroinitializer
  %t102 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t103 = bitcast [24 x i8]* %t102 to i8*
  %t104 = getelementptr inbounds i8, i8* %t103, i64 8
  %t105 = bitcast i8* %t104 to %Block*
  %t106 = load %Block, %Block* %t105
  %t107 = icmp eq i32 %t93, 5
  %t108 = select i1 %t107, %Block %t106, %Block %t101
  %t109 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t110 = bitcast [40 x i8]* %t109 to i8*
  %t111 = getelementptr inbounds i8, i8* %t110, i64 16
  %t112 = bitcast i8* %t111 to %Block*
  %t113 = load %Block, %Block* %t112
  %t114 = icmp eq i32 %t93, 6
  %t115 = select i1 %t114, %Block %t113, %Block %t108
  %t116 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t117 = bitcast [24 x i8]* %t116 to i8*
  %t118 = getelementptr inbounds i8, i8* %t117, i64 8
  %t119 = bitcast i8* %t118 to %Block*
  %t120 = load %Block, %Block* %t119
  %t121 = icmp eq i32 %t93, 7
  %t122 = select i1 %t121, %Block %t120, %Block %t115
  %t123 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t124 = bitcast [40 x i8]* %t123 to i8*
  %t125 = getelementptr inbounds i8, i8* %t124, i64 24
  %t126 = bitcast i8* %t125 to %Block*
  %t127 = load %Block, %Block* %t126
  %t128 = icmp eq i32 %t93, 12
  %t129 = select i1 %t128, %Block %t127, %Block %t122
  %t130 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t131 = bitcast [24 x i8]* %t130 to i8*
  %t132 = getelementptr inbounds i8, i8* %t131, i64 8
  %t133 = bitcast i8* %t132 to %Block*
  %t134 = load %Block, %Block* %t133
  %t135 = icmp eq i32 %t93, 13
  %t136 = select i1 %t135, %Block %t134, %Block %t129
  %t137 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t138 = bitcast [24 x i8]* %t137 to i8*
  %t139 = getelementptr inbounds i8, i8* %t138, i64 8
  %t140 = bitcast i8* %t139 to %Block*
  %t141 = load %Block, %Block* %t140
  %t142 = icmp eq i32 %t93, 14
  %t143 = select i1 %t142, %Block %t141, %Block %t136
  %t144 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t145 = bitcast [16 x i8]* %t144 to i8*
  %t146 = bitcast i8* %t145 to %Block*
  %t147 = load %Block, %Block* %t146
  %t148 = icmp eq i32 %t93, 15
  %t149 = select i1 %t148, %Block %t147, %Block %t143
  %t150 = extractvalue %Statement %statement, 0
  %t151 = alloca %Statement
  store %Statement %statement, %Statement* %t151
  %t152 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t153 = bitcast [48 x i8]* %t152 to i8*
  %t154 = getelementptr inbounds i8, i8* %t153, i64 40
  %t155 = bitcast i8* %t154 to { %Decorator**, i64 }**
  %t156 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t155
  %t157 = icmp eq i32 %t150, 3
  %t158 = select i1 %t157, { %Decorator**, i64 }* %t156, { %Decorator**, i64 }* null
  %t159 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t160 = bitcast [24 x i8]* %t159 to i8*
  %t161 = getelementptr inbounds i8, i8* %t160, i64 16
  %t162 = bitcast i8* %t161 to { %Decorator**, i64 }**
  %t163 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t162
  %t164 = icmp eq i32 %t150, 4
  %t165 = select i1 %t164, { %Decorator**, i64 }* %t163, { %Decorator**, i64 }* %t158
  %t166 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t167 = bitcast [24 x i8]* %t166 to i8*
  %t168 = getelementptr inbounds i8, i8* %t167, i64 16
  %t169 = bitcast i8* %t168 to { %Decorator**, i64 }**
  %t170 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t169
  %t171 = icmp eq i32 %t150, 5
  %t172 = select i1 %t171, { %Decorator**, i64 }* %t170, { %Decorator**, i64 }* %t165
  %t173 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t174 = bitcast [40 x i8]* %t173 to i8*
  %t175 = getelementptr inbounds i8, i8* %t174, i64 32
  %t176 = bitcast i8* %t175 to { %Decorator**, i64 }**
  %t177 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t176
  %t178 = icmp eq i32 %t150, 6
  %t179 = select i1 %t178, { %Decorator**, i64 }* %t177, { %Decorator**, i64 }* %t172
  %t180 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t181 = bitcast [24 x i8]* %t180 to i8*
  %t182 = getelementptr inbounds i8, i8* %t181, i64 16
  %t183 = bitcast i8* %t182 to { %Decorator**, i64 }**
  %t184 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t183
  %t185 = icmp eq i32 %t150, 7
  %t186 = select i1 %t185, { %Decorator**, i64 }* %t184, { %Decorator**, i64 }* %t179
  %t187 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t188 = bitcast [56 x i8]* %t187 to i8*
  %t189 = getelementptr inbounds i8, i8* %t188, i64 48
  %t190 = bitcast i8* %t189 to { %Decorator**, i64 }**
  %t191 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t190
  %t192 = icmp eq i32 %t150, 8
  %t193 = select i1 %t192, { %Decorator**, i64 }* %t191, { %Decorator**, i64 }* %t186
  %t194 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t195 = bitcast [40 x i8]* %t194 to i8*
  %t196 = getelementptr inbounds i8, i8* %t195, i64 32
  %t197 = bitcast i8* %t196 to { %Decorator**, i64 }**
  %t198 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t197
  %t199 = icmp eq i32 %t150, 9
  %t200 = select i1 %t199, { %Decorator**, i64 }* %t198, { %Decorator**, i64 }* %t193
  %t201 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t202 = bitcast [40 x i8]* %t201 to i8*
  %t203 = getelementptr inbounds i8, i8* %t202, i64 32
  %t204 = bitcast i8* %t203 to { %Decorator**, i64 }**
  %t205 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t204
  %t206 = icmp eq i32 %t150, 10
  %t207 = select i1 %t206, { %Decorator**, i64 }* %t205, { %Decorator**, i64 }* %t200
  %t208 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t209 = bitcast [40 x i8]* %t208 to i8*
  %t210 = getelementptr inbounds i8, i8* %t209, i64 32
  %t211 = bitcast i8* %t210 to { %Decorator**, i64 }**
  %t212 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t211
  %t213 = icmp eq i32 %t150, 11
  %t214 = select i1 %t213, { %Decorator**, i64 }* %t212, { %Decorator**, i64 }* %t207
  %t215 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t216 = bitcast [40 x i8]* %t215 to i8*
  %t217 = getelementptr inbounds i8, i8* %t216, i64 32
  %t218 = bitcast i8* %t217 to { %Decorator**, i64 }**
  %t219 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t218
  %t220 = icmp eq i32 %t150, 12
  %t221 = select i1 %t220, { %Decorator**, i64 }* %t219, { %Decorator**, i64 }* %t214
  %t222 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t223 = bitcast [24 x i8]* %t222 to i8*
  %t224 = getelementptr inbounds i8, i8* %t223, i64 16
  %t225 = bitcast i8* %t224 to { %Decorator**, i64 }**
  %t226 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t225
  %t227 = icmp eq i32 %t150, 13
  %t228 = select i1 %t227, { %Decorator**, i64 }* %t226, { %Decorator**, i64 }* %t221
  %t229 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t230 = bitcast [24 x i8]* %t229 to i8*
  %t231 = getelementptr inbounds i8, i8* %t230, i64 16
  %t232 = bitcast i8* %t231 to { %Decorator**, i64 }**
  %t233 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t232
  %t234 = icmp eq i32 %t150, 14
  %t235 = select i1 %t234, { %Decorator**, i64 }* %t233, { %Decorator**, i64 }* %t228
  %t236 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t237 = bitcast [16 x i8]* %t236 to i8*
  %t238 = getelementptr inbounds i8, i8* %t237, i64 8
  %t239 = bitcast i8* %t238 to { %Decorator**, i64 }**
  %t240 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t239
  %t241 = icmp eq i32 %t150, 15
  %t242 = select i1 %t241, { %Decorator**, i64 }* %t240, { %Decorator**, i64 }* %t235
  %t243 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t244 = bitcast [24 x i8]* %t243 to i8*
  %t245 = getelementptr inbounds i8, i8* %t244, i64 16
  %t246 = bitcast i8* %t245 to { %Decorator**, i64 }**
  %t247 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t246
  %t248 = icmp eq i32 %t150, 18
  %t249 = select i1 %t248, { %Decorator**, i64 }* %t247, { %Decorator**, i64 }* %t242
  %t250 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t251 = bitcast [32 x i8]* %t250 to i8*
  %t252 = getelementptr inbounds i8, i8* %t251, i64 24
  %t253 = bitcast i8* %t252 to { %Decorator**, i64 }**
  %t254 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t253
  %t255 = icmp eq i32 %t150, 19
  %t256 = select i1 %t255, { %Decorator**, i64 }* %t254, { %Decorator**, i64 }* %t249
  %t257 = extractvalue %Statement %statement, 0
  %t258 = alloca %Statement
  store %Statement %statement, %Statement* %t258
  %t259 = getelementptr inbounds %Statement, %Statement* %t258, i32 0, i32 1
  %t260 = bitcast [24 x i8]* %t259 to i8*
  %t261 = bitcast i8* %t260 to %FunctionSignature*
  %t262 = load %FunctionSignature, %FunctionSignature* %t261
  %t263 = icmp eq i32 %t257, 4
  %t264 = select i1 %t263, %FunctionSignature %t262, %FunctionSignature zeroinitializer
  %t265 = getelementptr inbounds %Statement, %Statement* %t258, i32 0, i32 1
  %t266 = bitcast [24 x i8]* %t265 to i8*
  %t267 = bitcast i8* %t266 to %FunctionSignature*
  %t268 = load %FunctionSignature, %FunctionSignature* %t267
  %t269 = icmp eq i32 %t257, 5
  %t270 = select i1 %t269, %FunctionSignature %t268, %FunctionSignature %t264
  %t271 = getelementptr inbounds %Statement, %Statement* %t258, i32 0, i32 1
  %t272 = bitcast [24 x i8]* %t271 to i8*
  %t273 = bitcast i8* %t272 to %FunctionSignature*
  %t274 = load %FunctionSignature, %FunctionSignature* %t273
  %t275 = icmp eq i32 %t257, 7
  %t276 = select i1 %t275, %FunctionSignature %t274, %FunctionSignature %t270
  %t277 = extractvalue %FunctionSignature %t276, 0
  %t278 = bitcast { %Decorator**, i64 }* %t256 to { %Decorator*, i64 }*
  %t279 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t92, %Block %t149, { %Decorator*, i64 }* %t278, i8* %t277)
  ret { %EffectViolation*, i64 }* %t279
merge1:
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
  %s351 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h479148896, i32 0, i32 0
  %t352 = icmp eq i8* %t350, %s351
  br i1 %t352, label %then2, label %merge3
then2:
  %t353 = extractvalue %Statement %statement, 0
  %t354 = alloca %Statement
  store %Statement %statement, %Statement* %t354
  %t355 = getelementptr inbounds %Statement, %Statement* %t354, i32 0, i32 1
  %t356 = bitcast [24 x i8]* %t355 to i8*
  %t357 = bitcast i8* %t356 to %FunctionSignature*
  %t358 = load %FunctionSignature, %FunctionSignature* %t357
  %t359 = icmp eq i32 %t353, 4
  %t360 = select i1 %t359, %FunctionSignature %t358, %FunctionSignature zeroinitializer
  %t361 = getelementptr inbounds %Statement, %Statement* %t354, i32 0, i32 1
  %t362 = bitcast [24 x i8]* %t361 to i8*
  %t363 = bitcast i8* %t362 to %FunctionSignature*
  %t364 = load %FunctionSignature, %FunctionSignature* %t363
  %t365 = icmp eq i32 %t353, 5
  %t366 = select i1 %t365, %FunctionSignature %t364, %FunctionSignature %t360
  %t367 = getelementptr inbounds %Statement, %Statement* %t354, i32 0, i32 1
  %t368 = bitcast [24 x i8]* %t367 to i8*
  %t369 = bitcast i8* %t368 to %FunctionSignature*
  %t370 = load %FunctionSignature, %FunctionSignature* %t369
  %t371 = icmp eq i32 %t353, 7
  %t372 = select i1 %t371, %FunctionSignature %t370, %FunctionSignature %t366
  store %FunctionSignature %t372, %FunctionSignature* %l0
  %s373 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1700456022, i32 0, i32 0
  %t374 = load %FunctionSignature, %FunctionSignature* %l0
  %t375 = extractvalue %FunctionSignature %t374, 0
  %t376 = call i8* @sailfin_runtime_string_concat(i8* %s373, i8* %t375)
  store i8* %t376, i8** %l1
  %t377 = load %FunctionSignature, %FunctionSignature* %l0
  %t378 = extractvalue %Statement %statement, 0
  %t379 = alloca %Statement
  store %Statement %statement, %Statement* %t379
  %t380 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t381 = bitcast [24 x i8]* %t380 to i8*
  %t382 = getelementptr inbounds i8, i8* %t381, i64 8
  %t383 = bitcast i8* %t382 to %Block*
  %t384 = load %Block, %Block* %t383
  %t385 = icmp eq i32 %t378, 4
  %t386 = select i1 %t385, %Block %t384, %Block zeroinitializer
  %t387 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t388 = bitcast [24 x i8]* %t387 to i8*
  %t389 = getelementptr inbounds i8, i8* %t388, i64 8
  %t390 = bitcast i8* %t389 to %Block*
  %t391 = load %Block, %Block* %t390
  %t392 = icmp eq i32 %t378, 5
  %t393 = select i1 %t392, %Block %t391, %Block %t386
  %t394 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t395 = bitcast [40 x i8]* %t394 to i8*
  %t396 = getelementptr inbounds i8, i8* %t395, i64 16
  %t397 = bitcast i8* %t396 to %Block*
  %t398 = load %Block, %Block* %t397
  %t399 = icmp eq i32 %t378, 6
  %t400 = select i1 %t399, %Block %t398, %Block %t393
  %t401 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t402 = bitcast [24 x i8]* %t401 to i8*
  %t403 = getelementptr inbounds i8, i8* %t402, i64 8
  %t404 = bitcast i8* %t403 to %Block*
  %t405 = load %Block, %Block* %t404
  %t406 = icmp eq i32 %t378, 7
  %t407 = select i1 %t406, %Block %t405, %Block %t400
  %t408 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t409 = bitcast [40 x i8]* %t408 to i8*
  %t410 = getelementptr inbounds i8, i8* %t409, i64 24
  %t411 = bitcast i8* %t410 to %Block*
  %t412 = load %Block, %Block* %t411
  %t413 = icmp eq i32 %t378, 12
  %t414 = select i1 %t413, %Block %t412, %Block %t407
  %t415 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t416 = bitcast [24 x i8]* %t415 to i8*
  %t417 = getelementptr inbounds i8, i8* %t416, i64 8
  %t418 = bitcast i8* %t417 to %Block*
  %t419 = load %Block, %Block* %t418
  %t420 = icmp eq i32 %t378, 13
  %t421 = select i1 %t420, %Block %t419, %Block %t414
  %t422 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t423 = bitcast [24 x i8]* %t422 to i8*
  %t424 = getelementptr inbounds i8, i8* %t423, i64 8
  %t425 = bitcast i8* %t424 to %Block*
  %t426 = load %Block, %Block* %t425
  %t427 = icmp eq i32 %t378, 14
  %t428 = select i1 %t427, %Block %t426, %Block %t421
  %t429 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t430 = bitcast [16 x i8]* %t429 to i8*
  %t431 = bitcast i8* %t430 to %Block*
  %t432 = load %Block, %Block* %t431
  %t433 = icmp eq i32 %t378, 15
  %t434 = select i1 %t433, %Block %t432, %Block %t428
  %t435 = extractvalue %Statement %statement, 0
  %t436 = alloca %Statement
  store %Statement %statement, %Statement* %t436
  %t437 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t438 = bitcast [48 x i8]* %t437 to i8*
  %t439 = getelementptr inbounds i8, i8* %t438, i64 40
  %t440 = bitcast i8* %t439 to { %Decorator**, i64 }**
  %t441 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t440
  %t442 = icmp eq i32 %t435, 3
  %t443 = select i1 %t442, { %Decorator**, i64 }* %t441, { %Decorator**, i64 }* null
  %t444 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t445 = bitcast [24 x i8]* %t444 to i8*
  %t446 = getelementptr inbounds i8, i8* %t445, i64 16
  %t447 = bitcast i8* %t446 to { %Decorator**, i64 }**
  %t448 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t447
  %t449 = icmp eq i32 %t435, 4
  %t450 = select i1 %t449, { %Decorator**, i64 }* %t448, { %Decorator**, i64 }* %t443
  %t451 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t452 = bitcast [24 x i8]* %t451 to i8*
  %t453 = getelementptr inbounds i8, i8* %t452, i64 16
  %t454 = bitcast i8* %t453 to { %Decorator**, i64 }**
  %t455 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t454
  %t456 = icmp eq i32 %t435, 5
  %t457 = select i1 %t456, { %Decorator**, i64 }* %t455, { %Decorator**, i64 }* %t450
  %t458 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t459 = bitcast [40 x i8]* %t458 to i8*
  %t460 = getelementptr inbounds i8, i8* %t459, i64 32
  %t461 = bitcast i8* %t460 to { %Decorator**, i64 }**
  %t462 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t461
  %t463 = icmp eq i32 %t435, 6
  %t464 = select i1 %t463, { %Decorator**, i64 }* %t462, { %Decorator**, i64 }* %t457
  %t465 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t466 = bitcast [24 x i8]* %t465 to i8*
  %t467 = getelementptr inbounds i8, i8* %t466, i64 16
  %t468 = bitcast i8* %t467 to { %Decorator**, i64 }**
  %t469 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t468
  %t470 = icmp eq i32 %t435, 7
  %t471 = select i1 %t470, { %Decorator**, i64 }* %t469, { %Decorator**, i64 }* %t464
  %t472 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t473 = bitcast [56 x i8]* %t472 to i8*
  %t474 = getelementptr inbounds i8, i8* %t473, i64 48
  %t475 = bitcast i8* %t474 to { %Decorator**, i64 }**
  %t476 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t475
  %t477 = icmp eq i32 %t435, 8
  %t478 = select i1 %t477, { %Decorator**, i64 }* %t476, { %Decorator**, i64 }* %t471
  %t479 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t480 = bitcast [40 x i8]* %t479 to i8*
  %t481 = getelementptr inbounds i8, i8* %t480, i64 32
  %t482 = bitcast i8* %t481 to { %Decorator**, i64 }**
  %t483 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t482
  %t484 = icmp eq i32 %t435, 9
  %t485 = select i1 %t484, { %Decorator**, i64 }* %t483, { %Decorator**, i64 }* %t478
  %t486 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t487 = bitcast [40 x i8]* %t486 to i8*
  %t488 = getelementptr inbounds i8, i8* %t487, i64 32
  %t489 = bitcast i8* %t488 to { %Decorator**, i64 }**
  %t490 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t489
  %t491 = icmp eq i32 %t435, 10
  %t492 = select i1 %t491, { %Decorator**, i64 }* %t490, { %Decorator**, i64 }* %t485
  %t493 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t494 = bitcast [40 x i8]* %t493 to i8*
  %t495 = getelementptr inbounds i8, i8* %t494, i64 32
  %t496 = bitcast i8* %t495 to { %Decorator**, i64 }**
  %t497 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t496
  %t498 = icmp eq i32 %t435, 11
  %t499 = select i1 %t498, { %Decorator**, i64 }* %t497, { %Decorator**, i64 }* %t492
  %t500 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t501 = bitcast [40 x i8]* %t500 to i8*
  %t502 = getelementptr inbounds i8, i8* %t501, i64 32
  %t503 = bitcast i8* %t502 to { %Decorator**, i64 }**
  %t504 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t503
  %t505 = icmp eq i32 %t435, 12
  %t506 = select i1 %t505, { %Decorator**, i64 }* %t504, { %Decorator**, i64 }* %t499
  %t507 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t508 = bitcast [24 x i8]* %t507 to i8*
  %t509 = getelementptr inbounds i8, i8* %t508, i64 16
  %t510 = bitcast i8* %t509 to { %Decorator**, i64 }**
  %t511 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t510
  %t512 = icmp eq i32 %t435, 13
  %t513 = select i1 %t512, { %Decorator**, i64 }* %t511, { %Decorator**, i64 }* %t506
  %t514 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t515 = bitcast [24 x i8]* %t514 to i8*
  %t516 = getelementptr inbounds i8, i8* %t515, i64 16
  %t517 = bitcast i8* %t516 to { %Decorator**, i64 }**
  %t518 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t517
  %t519 = icmp eq i32 %t435, 14
  %t520 = select i1 %t519, { %Decorator**, i64 }* %t518, { %Decorator**, i64 }* %t513
  %t521 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t522 = bitcast [16 x i8]* %t521 to i8*
  %t523 = getelementptr inbounds i8, i8* %t522, i64 8
  %t524 = bitcast i8* %t523 to { %Decorator**, i64 }**
  %t525 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t524
  %t526 = icmp eq i32 %t435, 15
  %t527 = select i1 %t526, { %Decorator**, i64 }* %t525, { %Decorator**, i64 }* %t520
  %t528 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t529 = bitcast [24 x i8]* %t528 to i8*
  %t530 = getelementptr inbounds i8, i8* %t529, i64 16
  %t531 = bitcast i8* %t530 to { %Decorator**, i64 }**
  %t532 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t531
  %t533 = icmp eq i32 %t435, 18
  %t534 = select i1 %t533, { %Decorator**, i64 }* %t532, { %Decorator**, i64 }* %t527
  %t535 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t536 = bitcast [32 x i8]* %t535 to i8*
  %t537 = getelementptr inbounds i8, i8* %t536, i64 24
  %t538 = bitcast i8* %t537 to { %Decorator**, i64 }**
  %t539 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t538
  %t540 = icmp eq i32 %t435, 19
  %t541 = select i1 %t540, { %Decorator**, i64 }* %t539, { %Decorator**, i64 }* %t534
  %t542 = load i8*, i8** %l1
  %t543 = bitcast { %Decorator**, i64 }* %t541 to { %Decorator*, i64 }*
  %t544 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t377, %Block %t434, { %Decorator*, i64 }* %t543, i8* %t542)
  ret { %EffectViolation*, i64 }* %t544
merge3:
  %t545 = extractvalue %Statement %statement, 0
  %t546 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t547 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t548 = icmp eq i32 %t545, 0
  %t549 = select i1 %t548, i8* %t547, i8* %t546
  %t550 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t551 = icmp eq i32 %t545, 1
  %t552 = select i1 %t551, i8* %t550, i8* %t549
  %t553 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t554 = icmp eq i32 %t545, 2
  %t555 = select i1 %t554, i8* %t553, i8* %t552
  %t556 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t557 = icmp eq i32 %t545, 3
  %t558 = select i1 %t557, i8* %t556, i8* %t555
  %t559 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t560 = icmp eq i32 %t545, 4
  %t561 = select i1 %t560, i8* %t559, i8* %t558
  %t562 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t563 = icmp eq i32 %t545, 5
  %t564 = select i1 %t563, i8* %t562, i8* %t561
  %t565 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t566 = icmp eq i32 %t545, 6
  %t567 = select i1 %t566, i8* %t565, i8* %t564
  %t568 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t569 = icmp eq i32 %t545, 7
  %t570 = select i1 %t569, i8* %t568, i8* %t567
  %t571 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t572 = icmp eq i32 %t545, 8
  %t573 = select i1 %t572, i8* %t571, i8* %t570
  %t574 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t575 = icmp eq i32 %t545, 9
  %t576 = select i1 %t575, i8* %t574, i8* %t573
  %t577 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t578 = icmp eq i32 %t545, 10
  %t579 = select i1 %t578, i8* %t577, i8* %t576
  %t580 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t581 = icmp eq i32 %t545, 11
  %t582 = select i1 %t581, i8* %t580, i8* %t579
  %t583 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t584 = icmp eq i32 %t545, 12
  %t585 = select i1 %t584, i8* %t583, i8* %t582
  %t586 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t587 = icmp eq i32 %t545, 13
  %t588 = select i1 %t587, i8* %t586, i8* %t585
  %t589 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t590 = icmp eq i32 %t545, 14
  %t591 = select i1 %t590, i8* %t589, i8* %t588
  %t592 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t593 = icmp eq i32 %t545, 15
  %t594 = select i1 %t593, i8* %t592, i8* %t591
  %t595 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t596 = icmp eq i32 %t545, 16
  %t597 = select i1 %t596, i8* %t595, i8* %t594
  %t598 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t599 = icmp eq i32 %t545, 17
  %t600 = select i1 %t599, i8* %t598, i8* %t597
  %t601 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t602 = icmp eq i32 %t545, 18
  %t603 = select i1 %t602, i8* %t601, i8* %t600
  %t604 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t605 = icmp eq i32 %t545, 19
  %t606 = select i1 %t605, i8* %t604, i8* %t603
  %t607 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t608 = icmp eq i32 %t545, 20
  %t609 = select i1 %t608, i8* %t607, i8* %t606
  %t610 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t611 = icmp eq i32 %t545, 21
  %t612 = select i1 %t611, i8* %t610, i8* %t609
  %t613 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t614 = icmp eq i32 %t545, 22
  %t615 = select i1 %t614, i8* %t613, i8* %t612
  %s616 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h571715647, i32 0, i32 0
  %t617 = icmp eq i8* %t615, %s616
  br i1 %t617, label %then4, label %merge5
then4:
  %t618 = extractvalue %Statement %statement, 0
  %t619 = alloca %Statement
  store %Statement %statement, %Statement* %t619
  %t620 = getelementptr inbounds %Statement, %Statement* %t619, i32 0, i32 1
  %t621 = bitcast [24 x i8]* %t620 to i8*
  %t622 = bitcast i8* %t621 to %FunctionSignature*
  %t623 = load %FunctionSignature, %FunctionSignature* %t622
  %t624 = icmp eq i32 %t618, 4
  %t625 = select i1 %t624, %FunctionSignature %t623, %FunctionSignature zeroinitializer
  %t626 = getelementptr inbounds %Statement, %Statement* %t619, i32 0, i32 1
  %t627 = bitcast [24 x i8]* %t626 to i8*
  %t628 = bitcast i8* %t627 to %FunctionSignature*
  %t629 = load %FunctionSignature, %FunctionSignature* %t628
  %t630 = icmp eq i32 %t618, 5
  %t631 = select i1 %t630, %FunctionSignature %t629, %FunctionSignature %t625
  %t632 = getelementptr inbounds %Statement, %Statement* %t619, i32 0, i32 1
  %t633 = bitcast [24 x i8]* %t632 to i8*
  %t634 = bitcast i8* %t633 to %FunctionSignature*
  %t635 = load %FunctionSignature, %FunctionSignature* %t634
  %t636 = icmp eq i32 %t618, 7
  %t637 = select i1 %t636, %FunctionSignature %t635, %FunctionSignature %t631
  store %FunctionSignature %t637, %FunctionSignature* %l2
  %s638 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h512542702, i32 0, i32 0
  %t639 = load %FunctionSignature, %FunctionSignature* %l2
  %t640 = extractvalue %FunctionSignature %t639, 0
  %t641 = call i8* @sailfin_runtime_string_concat(i8* %s638, i8* %t640)
  store i8* %t641, i8** %l3
  %t642 = load %FunctionSignature, %FunctionSignature* %l2
  %t643 = extractvalue %Statement %statement, 0
  %t644 = alloca %Statement
  store %Statement %statement, %Statement* %t644
  %t645 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t646 = bitcast [24 x i8]* %t645 to i8*
  %t647 = getelementptr inbounds i8, i8* %t646, i64 8
  %t648 = bitcast i8* %t647 to %Block*
  %t649 = load %Block, %Block* %t648
  %t650 = icmp eq i32 %t643, 4
  %t651 = select i1 %t650, %Block %t649, %Block zeroinitializer
  %t652 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t653 = bitcast [24 x i8]* %t652 to i8*
  %t654 = getelementptr inbounds i8, i8* %t653, i64 8
  %t655 = bitcast i8* %t654 to %Block*
  %t656 = load %Block, %Block* %t655
  %t657 = icmp eq i32 %t643, 5
  %t658 = select i1 %t657, %Block %t656, %Block %t651
  %t659 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t660 = bitcast [40 x i8]* %t659 to i8*
  %t661 = getelementptr inbounds i8, i8* %t660, i64 16
  %t662 = bitcast i8* %t661 to %Block*
  %t663 = load %Block, %Block* %t662
  %t664 = icmp eq i32 %t643, 6
  %t665 = select i1 %t664, %Block %t663, %Block %t658
  %t666 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t667 = bitcast [24 x i8]* %t666 to i8*
  %t668 = getelementptr inbounds i8, i8* %t667, i64 8
  %t669 = bitcast i8* %t668 to %Block*
  %t670 = load %Block, %Block* %t669
  %t671 = icmp eq i32 %t643, 7
  %t672 = select i1 %t671, %Block %t670, %Block %t665
  %t673 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t674 = bitcast [40 x i8]* %t673 to i8*
  %t675 = getelementptr inbounds i8, i8* %t674, i64 24
  %t676 = bitcast i8* %t675 to %Block*
  %t677 = load %Block, %Block* %t676
  %t678 = icmp eq i32 %t643, 12
  %t679 = select i1 %t678, %Block %t677, %Block %t672
  %t680 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t681 = bitcast [24 x i8]* %t680 to i8*
  %t682 = getelementptr inbounds i8, i8* %t681, i64 8
  %t683 = bitcast i8* %t682 to %Block*
  %t684 = load %Block, %Block* %t683
  %t685 = icmp eq i32 %t643, 13
  %t686 = select i1 %t685, %Block %t684, %Block %t679
  %t687 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t688 = bitcast [24 x i8]* %t687 to i8*
  %t689 = getelementptr inbounds i8, i8* %t688, i64 8
  %t690 = bitcast i8* %t689 to %Block*
  %t691 = load %Block, %Block* %t690
  %t692 = icmp eq i32 %t643, 14
  %t693 = select i1 %t692, %Block %t691, %Block %t686
  %t694 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t695 = bitcast [16 x i8]* %t694 to i8*
  %t696 = bitcast i8* %t695 to %Block*
  %t697 = load %Block, %Block* %t696
  %t698 = icmp eq i32 %t643, 15
  %t699 = select i1 %t698, %Block %t697, %Block %t693
  %t700 = extractvalue %Statement %statement, 0
  %t701 = alloca %Statement
  store %Statement %statement, %Statement* %t701
  %t702 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t703 = bitcast [48 x i8]* %t702 to i8*
  %t704 = getelementptr inbounds i8, i8* %t703, i64 40
  %t705 = bitcast i8* %t704 to { %Decorator**, i64 }**
  %t706 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t705
  %t707 = icmp eq i32 %t700, 3
  %t708 = select i1 %t707, { %Decorator**, i64 }* %t706, { %Decorator**, i64 }* null
  %t709 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t710 = bitcast [24 x i8]* %t709 to i8*
  %t711 = getelementptr inbounds i8, i8* %t710, i64 16
  %t712 = bitcast i8* %t711 to { %Decorator**, i64 }**
  %t713 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t712
  %t714 = icmp eq i32 %t700, 4
  %t715 = select i1 %t714, { %Decorator**, i64 }* %t713, { %Decorator**, i64 }* %t708
  %t716 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t717 = bitcast [24 x i8]* %t716 to i8*
  %t718 = getelementptr inbounds i8, i8* %t717, i64 16
  %t719 = bitcast i8* %t718 to { %Decorator**, i64 }**
  %t720 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t719
  %t721 = icmp eq i32 %t700, 5
  %t722 = select i1 %t721, { %Decorator**, i64 }* %t720, { %Decorator**, i64 }* %t715
  %t723 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t724 = bitcast [40 x i8]* %t723 to i8*
  %t725 = getelementptr inbounds i8, i8* %t724, i64 32
  %t726 = bitcast i8* %t725 to { %Decorator**, i64 }**
  %t727 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t726
  %t728 = icmp eq i32 %t700, 6
  %t729 = select i1 %t728, { %Decorator**, i64 }* %t727, { %Decorator**, i64 }* %t722
  %t730 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t731 = bitcast [24 x i8]* %t730 to i8*
  %t732 = getelementptr inbounds i8, i8* %t731, i64 16
  %t733 = bitcast i8* %t732 to { %Decorator**, i64 }**
  %t734 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t733
  %t735 = icmp eq i32 %t700, 7
  %t736 = select i1 %t735, { %Decorator**, i64 }* %t734, { %Decorator**, i64 }* %t729
  %t737 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t738 = bitcast [56 x i8]* %t737 to i8*
  %t739 = getelementptr inbounds i8, i8* %t738, i64 48
  %t740 = bitcast i8* %t739 to { %Decorator**, i64 }**
  %t741 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t740
  %t742 = icmp eq i32 %t700, 8
  %t743 = select i1 %t742, { %Decorator**, i64 }* %t741, { %Decorator**, i64 }* %t736
  %t744 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t745 = bitcast [40 x i8]* %t744 to i8*
  %t746 = getelementptr inbounds i8, i8* %t745, i64 32
  %t747 = bitcast i8* %t746 to { %Decorator**, i64 }**
  %t748 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t747
  %t749 = icmp eq i32 %t700, 9
  %t750 = select i1 %t749, { %Decorator**, i64 }* %t748, { %Decorator**, i64 }* %t743
  %t751 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t752 = bitcast [40 x i8]* %t751 to i8*
  %t753 = getelementptr inbounds i8, i8* %t752, i64 32
  %t754 = bitcast i8* %t753 to { %Decorator**, i64 }**
  %t755 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t754
  %t756 = icmp eq i32 %t700, 10
  %t757 = select i1 %t756, { %Decorator**, i64 }* %t755, { %Decorator**, i64 }* %t750
  %t758 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t759 = bitcast [40 x i8]* %t758 to i8*
  %t760 = getelementptr inbounds i8, i8* %t759, i64 32
  %t761 = bitcast i8* %t760 to { %Decorator**, i64 }**
  %t762 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t761
  %t763 = icmp eq i32 %t700, 11
  %t764 = select i1 %t763, { %Decorator**, i64 }* %t762, { %Decorator**, i64 }* %t757
  %t765 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t766 = bitcast [40 x i8]* %t765 to i8*
  %t767 = getelementptr inbounds i8, i8* %t766, i64 32
  %t768 = bitcast i8* %t767 to { %Decorator**, i64 }**
  %t769 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t768
  %t770 = icmp eq i32 %t700, 12
  %t771 = select i1 %t770, { %Decorator**, i64 }* %t769, { %Decorator**, i64 }* %t764
  %t772 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t773 = bitcast [24 x i8]* %t772 to i8*
  %t774 = getelementptr inbounds i8, i8* %t773, i64 16
  %t775 = bitcast i8* %t774 to { %Decorator**, i64 }**
  %t776 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t775
  %t777 = icmp eq i32 %t700, 13
  %t778 = select i1 %t777, { %Decorator**, i64 }* %t776, { %Decorator**, i64 }* %t771
  %t779 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t780 = bitcast [24 x i8]* %t779 to i8*
  %t781 = getelementptr inbounds i8, i8* %t780, i64 16
  %t782 = bitcast i8* %t781 to { %Decorator**, i64 }**
  %t783 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t782
  %t784 = icmp eq i32 %t700, 14
  %t785 = select i1 %t784, { %Decorator**, i64 }* %t783, { %Decorator**, i64 }* %t778
  %t786 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t787 = bitcast [16 x i8]* %t786 to i8*
  %t788 = getelementptr inbounds i8, i8* %t787, i64 8
  %t789 = bitcast i8* %t788 to { %Decorator**, i64 }**
  %t790 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t789
  %t791 = icmp eq i32 %t700, 15
  %t792 = select i1 %t791, { %Decorator**, i64 }* %t790, { %Decorator**, i64 }* %t785
  %t793 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t794 = bitcast [24 x i8]* %t793 to i8*
  %t795 = getelementptr inbounds i8, i8* %t794, i64 16
  %t796 = bitcast i8* %t795 to { %Decorator**, i64 }**
  %t797 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t796
  %t798 = icmp eq i32 %t700, 18
  %t799 = select i1 %t798, { %Decorator**, i64 }* %t797, { %Decorator**, i64 }* %t792
  %t800 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t801 = bitcast [32 x i8]* %t800 to i8*
  %t802 = getelementptr inbounds i8, i8* %t801, i64 24
  %t803 = bitcast i8* %t802 to { %Decorator**, i64 }**
  %t804 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t803
  %t805 = icmp eq i32 %t700, 19
  %t806 = select i1 %t805, { %Decorator**, i64 }* %t804, { %Decorator**, i64 }* %t799
  %t807 = load i8*, i8** %l3
  %t808 = bitcast { %Decorator**, i64 }* %t806 to { %Decorator*, i64 }*
  %t809 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t642, %Block %t699, { %Decorator*, i64 }* %t808, i8* %t807)
  ret { %EffectViolation*, i64 }* %t809
merge5:
  %t810 = extractvalue %Statement %statement, 0
  %t811 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t812 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t813 = icmp eq i32 %t810, 0
  %t814 = select i1 %t813, i8* %t812, i8* %t811
  %t815 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t816 = icmp eq i32 %t810, 1
  %t817 = select i1 %t816, i8* %t815, i8* %t814
  %t818 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t819 = icmp eq i32 %t810, 2
  %t820 = select i1 %t819, i8* %t818, i8* %t817
  %t821 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t822 = icmp eq i32 %t810, 3
  %t823 = select i1 %t822, i8* %t821, i8* %t820
  %t824 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t825 = icmp eq i32 %t810, 4
  %t826 = select i1 %t825, i8* %t824, i8* %t823
  %t827 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t828 = icmp eq i32 %t810, 5
  %t829 = select i1 %t828, i8* %t827, i8* %t826
  %t830 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t831 = icmp eq i32 %t810, 6
  %t832 = select i1 %t831, i8* %t830, i8* %t829
  %t833 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t834 = icmp eq i32 %t810, 7
  %t835 = select i1 %t834, i8* %t833, i8* %t832
  %t836 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t837 = icmp eq i32 %t810, 8
  %t838 = select i1 %t837, i8* %t836, i8* %t835
  %t839 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t840 = icmp eq i32 %t810, 9
  %t841 = select i1 %t840, i8* %t839, i8* %t838
  %t842 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t843 = icmp eq i32 %t810, 10
  %t844 = select i1 %t843, i8* %t842, i8* %t841
  %t845 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t846 = icmp eq i32 %t810, 11
  %t847 = select i1 %t846, i8* %t845, i8* %t844
  %t848 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t849 = icmp eq i32 %t810, 12
  %t850 = select i1 %t849, i8* %t848, i8* %t847
  %t851 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t852 = icmp eq i32 %t810, 13
  %t853 = select i1 %t852, i8* %t851, i8* %t850
  %t854 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t855 = icmp eq i32 %t810, 14
  %t856 = select i1 %t855, i8* %t854, i8* %t853
  %t857 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t858 = icmp eq i32 %t810, 15
  %t859 = select i1 %t858, i8* %t857, i8* %t856
  %t860 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t861 = icmp eq i32 %t810, 16
  %t862 = select i1 %t861, i8* %t860, i8* %t859
  %t863 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t864 = icmp eq i32 %t810, 17
  %t865 = select i1 %t864, i8* %t863, i8* %t862
  %t866 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t867 = icmp eq i32 %t810, 18
  %t868 = select i1 %t867, i8* %t866, i8* %t865
  %t869 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t870 = icmp eq i32 %t810, 19
  %t871 = select i1 %t870, i8* %t869, i8* %t868
  %t872 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t873 = icmp eq i32 %t810, 20
  %t874 = select i1 %t873, i8* %t872, i8* %t871
  %t875 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t876 = icmp eq i32 %t810, 21
  %t877 = select i1 %t876, i8* %t875, i8* %t874
  %t878 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t879 = icmp eq i32 %t810, 22
  %t880 = select i1 %t879, i8* %t878, i8* %t877
  %s881 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h889179835, i32 0, i32 0
  %t882 = icmp eq i8* %t880, %s881
  br i1 %t882, label %then6, label %merge7
then6:
  %t883 = extractvalue %Statement %statement, 0
  %t884 = alloca %Statement
  store %Statement %statement, %Statement* %t884
  %t885 = getelementptr inbounds %Statement, %Statement* %t884, i32 0, i32 1
  %t886 = bitcast [48 x i8]* %t885 to i8*
  %t887 = bitcast i8* %t886 to i8**
  %t888 = load i8*, i8** %t887
  %t889 = icmp eq i32 %t883, 2
  %t890 = select i1 %t889, i8* %t888, i8* null
  %t891 = getelementptr inbounds %Statement, %Statement* %t884, i32 0, i32 1
  %t892 = bitcast [48 x i8]* %t891 to i8*
  %t893 = bitcast i8* %t892 to i8**
  %t894 = load i8*, i8** %t893
  %t895 = icmp eq i32 %t883, 3
  %t896 = select i1 %t895, i8* %t894, i8* %t890
  %t897 = getelementptr inbounds %Statement, %Statement* %t884, i32 0, i32 1
  %t898 = bitcast [40 x i8]* %t897 to i8*
  %t899 = bitcast i8* %t898 to i8**
  %t900 = load i8*, i8** %t899
  %t901 = icmp eq i32 %t883, 6
  %t902 = select i1 %t901, i8* %t900, i8* %t896
  %t903 = getelementptr inbounds %Statement, %Statement* %t884, i32 0, i32 1
  %t904 = bitcast [56 x i8]* %t903 to i8*
  %t905 = bitcast i8* %t904 to i8**
  %t906 = load i8*, i8** %t905
  %t907 = icmp eq i32 %t883, 8
  %t908 = select i1 %t907, i8* %t906, i8* %t902
  %t909 = getelementptr inbounds %Statement, %Statement* %t884, i32 0, i32 1
  %t910 = bitcast [40 x i8]* %t909 to i8*
  %t911 = bitcast i8* %t910 to i8**
  %t912 = load i8*, i8** %t911
  %t913 = icmp eq i32 %t883, 9
  %t914 = select i1 %t913, i8* %t912, i8* %t908
  %t915 = getelementptr inbounds %Statement, %Statement* %t884, i32 0, i32 1
  %t916 = bitcast [40 x i8]* %t915 to i8*
  %t917 = bitcast i8* %t916 to i8**
  %t918 = load i8*, i8** %t917
  %t919 = icmp eq i32 %t883, 10
  %t920 = select i1 %t919, i8* %t918, i8* %t914
  %t921 = getelementptr inbounds %Statement, %Statement* %t884, i32 0, i32 1
  %t922 = bitcast [40 x i8]* %t921 to i8*
  %t923 = bitcast i8* %t922 to i8**
  %t924 = load i8*, i8** %t923
  %t925 = icmp eq i32 %t883, 11
  %t926 = select i1 %t925, i8* %t924, i8* %t920
  %t927 = insertvalue %FunctionSignature undef, i8* %t926, 0
  %t928 = insertvalue %FunctionSignature %t927, i1 0, 1
  %t929 = alloca [0 x %Parameter*]
  %t930 = getelementptr [0 x %Parameter*], [0 x %Parameter*]* %t929, i32 0, i32 0
  %t931 = alloca { %Parameter**, i64 }
  %t932 = getelementptr { %Parameter**, i64 }, { %Parameter**, i64 }* %t931, i32 0, i32 0
  store %Parameter** %t930, %Parameter*** %t932
  %t933 = getelementptr { %Parameter**, i64 }, { %Parameter**, i64 }* %t931, i32 0, i32 1
  store i64 0, i64* %t933
  %t934 = insertvalue %FunctionSignature %t928, { %Parameter**, i64 }* %t931, 2
  %t935 = bitcast i8* null to %TypeAnnotation*
  %t936 = insertvalue %FunctionSignature %t934, %TypeAnnotation* %t935, 3
  %t937 = extractvalue %Statement %statement, 0
  %t938 = alloca %Statement
  store %Statement %statement, %Statement* %t938
  %t939 = getelementptr inbounds %Statement, %Statement* %t938, i32 0, i32 1
  %t940 = bitcast [48 x i8]* %t939 to i8*
  %t941 = getelementptr inbounds i8, i8* %t940, i64 32
  %t942 = bitcast i8* %t941 to { i8**, i64 }**
  %t943 = load { i8**, i64 }*, { i8**, i64 }** %t942
  %t944 = icmp eq i32 %t937, 3
  %t945 = select i1 %t944, { i8**, i64 }* %t943, { i8**, i64 }* null
  %t946 = getelementptr inbounds %Statement, %Statement* %t938, i32 0, i32 1
  %t947 = bitcast [40 x i8]* %t946 to i8*
  %t948 = getelementptr inbounds i8, i8* %t947, i64 24
  %t949 = bitcast i8* %t948 to { i8**, i64 }**
  %t950 = load { i8**, i64 }*, { i8**, i64 }** %t949
  %t951 = icmp eq i32 %t937, 6
  %t952 = select i1 %t951, { i8**, i64 }* %t950, { i8**, i64 }* %t945
  %t953 = insertvalue %FunctionSignature %t936, { i8**, i64 }* %t952, 4
  %t954 = alloca [0 x %TypeParameter*]
  %t955 = getelementptr [0 x %TypeParameter*], [0 x %TypeParameter*]* %t954, i32 0, i32 0
  %t956 = alloca { %TypeParameter**, i64 }
  %t957 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t956, i32 0, i32 0
  store %TypeParameter** %t955, %TypeParameter*** %t957
  %t958 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t956, i32 0, i32 1
  store i64 0, i64* %t958
  %t959 = insertvalue %FunctionSignature %t953, { %TypeParameter**, i64 }* %t956, 5
  %t960 = bitcast i8* null to %SourceSpan*
  %t961 = insertvalue %FunctionSignature %t959, %SourceSpan* %t960, 6
  store %FunctionSignature %t961, %FunctionSignature* %l4
  %s962 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h500835952, i32 0, i32 0
  %t963 = extractvalue %Statement %statement, 0
  %t964 = alloca %Statement
  store %Statement %statement, %Statement* %t964
  %t965 = getelementptr inbounds %Statement, %Statement* %t964, i32 0, i32 1
  %t966 = bitcast [48 x i8]* %t965 to i8*
  %t967 = bitcast i8* %t966 to i8**
  %t968 = load i8*, i8** %t967
  %t969 = icmp eq i32 %t963, 2
  %t970 = select i1 %t969, i8* %t968, i8* null
  %t971 = getelementptr inbounds %Statement, %Statement* %t964, i32 0, i32 1
  %t972 = bitcast [48 x i8]* %t971 to i8*
  %t973 = bitcast i8* %t972 to i8**
  %t974 = load i8*, i8** %t973
  %t975 = icmp eq i32 %t963, 3
  %t976 = select i1 %t975, i8* %t974, i8* %t970
  %t977 = getelementptr inbounds %Statement, %Statement* %t964, i32 0, i32 1
  %t978 = bitcast [40 x i8]* %t977 to i8*
  %t979 = bitcast i8* %t978 to i8**
  %t980 = load i8*, i8** %t979
  %t981 = icmp eq i32 %t963, 6
  %t982 = select i1 %t981, i8* %t980, i8* %t976
  %t983 = getelementptr inbounds %Statement, %Statement* %t964, i32 0, i32 1
  %t984 = bitcast [56 x i8]* %t983 to i8*
  %t985 = bitcast i8* %t984 to i8**
  %t986 = load i8*, i8** %t985
  %t987 = icmp eq i32 %t963, 8
  %t988 = select i1 %t987, i8* %t986, i8* %t982
  %t989 = getelementptr inbounds %Statement, %Statement* %t964, i32 0, i32 1
  %t990 = bitcast [40 x i8]* %t989 to i8*
  %t991 = bitcast i8* %t990 to i8**
  %t992 = load i8*, i8** %t991
  %t993 = icmp eq i32 %t963, 9
  %t994 = select i1 %t993, i8* %t992, i8* %t988
  %t995 = getelementptr inbounds %Statement, %Statement* %t964, i32 0, i32 1
  %t996 = bitcast [40 x i8]* %t995 to i8*
  %t997 = bitcast i8* %t996 to i8**
  %t998 = load i8*, i8** %t997
  %t999 = icmp eq i32 %t963, 10
  %t1000 = select i1 %t999, i8* %t998, i8* %t994
  %t1001 = getelementptr inbounds %Statement, %Statement* %t964, i32 0, i32 1
  %t1002 = bitcast [40 x i8]* %t1001 to i8*
  %t1003 = bitcast i8* %t1002 to i8**
  %t1004 = load i8*, i8** %t1003
  %t1005 = icmp eq i32 %t963, 11
  %t1006 = select i1 %t1005, i8* %t1004, i8* %t1000
  %t1007 = call i8* @sailfin_runtime_string_concat(i8* %s962, i8* %t1006)
  store i8* %t1007, i8** %l5
  %t1008 = load %FunctionSignature, %FunctionSignature* %l4
  %t1009 = extractvalue %Statement %statement, 0
  %t1010 = alloca %Statement
  store %Statement %statement, %Statement* %t1010
  %t1011 = getelementptr inbounds %Statement, %Statement* %t1010, i32 0, i32 1
  %t1012 = bitcast [24 x i8]* %t1011 to i8*
  %t1013 = getelementptr inbounds i8, i8* %t1012, i64 8
  %t1014 = bitcast i8* %t1013 to %Block*
  %t1015 = load %Block, %Block* %t1014
  %t1016 = icmp eq i32 %t1009, 4
  %t1017 = select i1 %t1016, %Block %t1015, %Block zeroinitializer
  %t1018 = getelementptr inbounds %Statement, %Statement* %t1010, i32 0, i32 1
  %t1019 = bitcast [24 x i8]* %t1018 to i8*
  %t1020 = getelementptr inbounds i8, i8* %t1019, i64 8
  %t1021 = bitcast i8* %t1020 to %Block*
  %t1022 = load %Block, %Block* %t1021
  %t1023 = icmp eq i32 %t1009, 5
  %t1024 = select i1 %t1023, %Block %t1022, %Block %t1017
  %t1025 = getelementptr inbounds %Statement, %Statement* %t1010, i32 0, i32 1
  %t1026 = bitcast [40 x i8]* %t1025 to i8*
  %t1027 = getelementptr inbounds i8, i8* %t1026, i64 16
  %t1028 = bitcast i8* %t1027 to %Block*
  %t1029 = load %Block, %Block* %t1028
  %t1030 = icmp eq i32 %t1009, 6
  %t1031 = select i1 %t1030, %Block %t1029, %Block %t1024
  %t1032 = getelementptr inbounds %Statement, %Statement* %t1010, i32 0, i32 1
  %t1033 = bitcast [24 x i8]* %t1032 to i8*
  %t1034 = getelementptr inbounds i8, i8* %t1033, i64 8
  %t1035 = bitcast i8* %t1034 to %Block*
  %t1036 = load %Block, %Block* %t1035
  %t1037 = icmp eq i32 %t1009, 7
  %t1038 = select i1 %t1037, %Block %t1036, %Block %t1031
  %t1039 = getelementptr inbounds %Statement, %Statement* %t1010, i32 0, i32 1
  %t1040 = bitcast [40 x i8]* %t1039 to i8*
  %t1041 = getelementptr inbounds i8, i8* %t1040, i64 24
  %t1042 = bitcast i8* %t1041 to %Block*
  %t1043 = load %Block, %Block* %t1042
  %t1044 = icmp eq i32 %t1009, 12
  %t1045 = select i1 %t1044, %Block %t1043, %Block %t1038
  %t1046 = getelementptr inbounds %Statement, %Statement* %t1010, i32 0, i32 1
  %t1047 = bitcast [24 x i8]* %t1046 to i8*
  %t1048 = getelementptr inbounds i8, i8* %t1047, i64 8
  %t1049 = bitcast i8* %t1048 to %Block*
  %t1050 = load %Block, %Block* %t1049
  %t1051 = icmp eq i32 %t1009, 13
  %t1052 = select i1 %t1051, %Block %t1050, %Block %t1045
  %t1053 = getelementptr inbounds %Statement, %Statement* %t1010, i32 0, i32 1
  %t1054 = bitcast [24 x i8]* %t1053 to i8*
  %t1055 = getelementptr inbounds i8, i8* %t1054, i64 8
  %t1056 = bitcast i8* %t1055 to %Block*
  %t1057 = load %Block, %Block* %t1056
  %t1058 = icmp eq i32 %t1009, 14
  %t1059 = select i1 %t1058, %Block %t1057, %Block %t1052
  %t1060 = getelementptr inbounds %Statement, %Statement* %t1010, i32 0, i32 1
  %t1061 = bitcast [16 x i8]* %t1060 to i8*
  %t1062 = bitcast i8* %t1061 to %Block*
  %t1063 = load %Block, %Block* %t1062
  %t1064 = icmp eq i32 %t1009, 15
  %t1065 = select i1 %t1064, %Block %t1063, %Block %t1059
  %t1066 = extractvalue %Statement %statement, 0
  %t1067 = alloca %Statement
  store %Statement %statement, %Statement* %t1067
  %t1068 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1069 = bitcast [48 x i8]* %t1068 to i8*
  %t1070 = getelementptr inbounds i8, i8* %t1069, i64 40
  %t1071 = bitcast i8* %t1070 to { %Decorator**, i64 }**
  %t1072 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1071
  %t1073 = icmp eq i32 %t1066, 3
  %t1074 = select i1 %t1073, { %Decorator**, i64 }* %t1072, { %Decorator**, i64 }* null
  %t1075 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1076 = bitcast [24 x i8]* %t1075 to i8*
  %t1077 = getelementptr inbounds i8, i8* %t1076, i64 16
  %t1078 = bitcast i8* %t1077 to { %Decorator**, i64 }**
  %t1079 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1078
  %t1080 = icmp eq i32 %t1066, 4
  %t1081 = select i1 %t1080, { %Decorator**, i64 }* %t1079, { %Decorator**, i64 }* %t1074
  %t1082 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1083 = bitcast [24 x i8]* %t1082 to i8*
  %t1084 = getelementptr inbounds i8, i8* %t1083, i64 16
  %t1085 = bitcast i8* %t1084 to { %Decorator**, i64 }**
  %t1086 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1085
  %t1087 = icmp eq i32 %t1066, 5
  %t1088 = select i1 %t1087, { %Decorator**, i64 }* %t1086, { %Decorator**, i64 }* %t1081
  %t1089 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1090 = bitcast [40 x i8]* %t1089 to i8*
  %t1091 = getelementptr inbounds i8, i8* %t1090, i64 32
  %t1092 = bitcast i8* %t1091 to { %Decorator**, i64 }**
  %t1093 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1092
  %t1094 = icmp eq i32 %t1066, 6
  %t1095 = select i1 %t1094, { %Decorator**, i64 }* %t1093, { %Decorator**, i64 }* %t1088
  %t1096 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1097 = bitcast [24 x i8]* %t1096 to i8*
  %t1098 = getelementptr inbounds i8, i8* %t1097, i64 16
  %t1099 = bitcast i8* %t1098 to { %Decorator**, i64 }**
  %t1100 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1099
  %t1101 = icmp eq i32 %t1066, 7
  %t1102 = select i1 %t1101, { %Decorator**, i64 }* %t1100, { %Decorator**, i64 }* %t1095
  %t1103 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1104 = bitcast [56 x i8]* %t1103 to i8*
  %t1105 = getelementptr inbounds i8, i8* %t1104, i64 48
  %t1106 = bitcast i8* %t1105 to { %Decorator**, i64 }**
  %t1107 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1106
  %t1108 = icmp eq i32 %t1066, 8
  %t1109 = select i1 %t1108, { %Decorator**, i64 }* %t1107, { %Decorator**, i64 }* %t1102
  %t1110 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1111 = bitcast [40 x i8]* %t1110 to i8*
  %t1112 = getelementptr inbounds i8, i8* %t1111, i64 32
  %t1113 = bitcast i8* %t1112 to { %Decorator**, i64 }**
  %t1114 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1113
  %t1115 = icmp eq i32 %t1066, 9
  %t1116 = select i1 %t1115, { %Decorator**, i64 }* %t1114, { %Decorator**, i64 }* %t1109
  %t1117 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1118 = bitcast [40 x i8]* %t1117 to i8*
  %t1119 = getelementptr inbounds i8, i8* %t1118, i64 32
  %t1120 = bitcast i8* %t1119 to { %Decorator**, i64 }**
  %t1121 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1120
  %t1122 = icmp eq i32 %t1066, 10
  %t1123 = select i1 %t1122, { %Decorator**, i64 }* %t1121, { %Decorator**, i64 }* %t1116
  %t1124 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1125 = bitcast [40 x i8]* %t1124 to i8*
  %t1126 = getelementptr inbounds i8, i8* %t1125, i64 32
  %t1127 = bitcast i8* %t1126 to { %Decorator**, i64 }**
  %t1128 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1127
  %t1129 = icmp eq i32 %t1066, 11
  %t1130 = select i1 %t1129, { %Decorator**, i64 }* %t1128, { %Decorator**, i64 }* %t1123
  %t1131 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1132 = bitcast [40 x i8]* %t1131 to i8*
  %t1133 = getelementptr inbounds i8, i8* %t1132, i64 32
  %t1134 = bitcast i8* %t1133 to { %Decorator**, i64 }**
  %t1135 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1134
  %t1136 = icmp eq i32 %t1066, 12
  %t1137 = select i1 %t1136, { %Decorator**, i64 }* %t1135, { %Decorator**, i64 }* %t1130
  %t1138 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1139 = bitcast [24 x i8]* %t1138 to i8*
  %t1140 = getelementptr inbounds i8, i8* %t1139, i64 16
  %t1141 = bitcast i8* %t1140 to { %Decorator**, i64 }**
  %t1142 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1141
  %t1143 = icmp eq i32 %t1066, 13
  %t1144 = select i1 %t1143, { %Decorator**, i64 }* %t1142, { %Decorator**, i64 }* %t1137
  %t1145 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1146 = bitcast [24 x i8]* %t1145 to i8*
  %t1147 = getelementptr inbounds i8, i8* %t1146, i64 16
  %t1148 = bitcast i8* %t1147 to { %Decorator**, i64 }**
  %t1149 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1148
  %t1150 = icmp eq i32 %t1066, 14
  %t1151 = select i1 %t1150, { %Decorator**, i64 }* %t1149, { %Decorator**, i64 }* %t1144
  %t1152 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1153 = bitcast [16 x i8]* %t1152 to i8*
  %t1154 = getelementptr inbounds i8, i8* %t1153, i64 8
  %t1155 = bitcast i8* %t1154 to { %Decorator**, i64 }**
  %t1156 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1155
  %t1157 = icmp eq i32 %t1066, 15
  %t1158 = select i1 %t1157, { %Decorator**, i64 }* %t1156, { %Decorator**, i64 }* %t1151
  %t1159 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1160 = bitcast [24 x i8]* %t1159 to i8*
  %t1161 = getelementptr inbounds i8, i8* %t1160, i64 16
  %t1162 = bitcast i8* %t1161 to { %Decorator**, i64 }**
  %t1163 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1162
  %t1164 = icmp eq i32 %t1066, 18
  %t1165 = select i1 %t1164, { %Decorator**, i64 }* %t1163, { %Decorator**, i64 }* %t1158
  %t1166 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1167 = bitcast [32 x i8]* %t1166 to i8*
  %t1168 = getelementptr inbounds i8, i8* %t1167, i64 24
  %t1169 = bitcast i8* %t1168 to { %Decorator**, i64 }**
  %t1170 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1169
  %t1171 = icmp eq i32 %t1066, 19
  %t1172 = select i1 %t1171, { %Decorator**, i64 }* %t1170, { %Decorator**, i64 }* %t1165
  %t1173 = load i8*, i8** %l5
  %t1174 = bitcast { %Decorator**, i64 }* %t1172 to { %Decorator*, i64 }*
  %t1175 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t1008, %Block %t1065, { %Decorator*, i64 }* %t1174, i8* %t1173)
  ret { %EffectViolation*, i64 }* %t1175
merge7:
  %t1176 = extractvalue %Statement %statement, 0
  %t1177 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1178 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1179 = icmp eq i32 %t1176, 0
  %t1180 = select i1 %t1179, i8* %t1178, i8* %t1177
  %t1181 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1182 = icmp eq i32 %t1176, 1
  %t1183 = select i1 %t1182, i8* %t1181, i8* %t1180
  %t1184 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1185 = icmp eq i32 %t1176, 2
  %t1186 = select i1 %t1185, i8* %t1184, i8* %t1183
  %t1187 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1188 = icmp eq i32 %t1176, 3
  %t1189 = select i1 %t1188, i8* %t1187, i8* %t1186
  %t1190 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1191 = icmp eq i32 %t1176, 4
  %t1192 = select i1 %t1191, i8* %t1190, i8* %t1189
  %t1193 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1194 = icmp eq i32 %t1176, 5
  %t1195 = select i1 %t1194, i8* %t1193, i8* %t1192
  %t1196 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1197 = icmp eq i32 %t1176, 6
  %t1198 = select i1 %t1197, i8* %t1196, i8* %t1195
  %t1199 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1200 = icmp eq i32 %t1176, 7
  %t1201 = select i1 %t1200, i8* %t1199, i8* %t1198
  %t1202 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1203 = icmp eq i32 %t1176, 8
  %t1204 = select i1 %t1203, i8* %t1202, i8* %t1201
  %t1205 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1206 = icmp eq i32 %t1176, 9
  %t1207 = select i1 %t1206, i8* %t1205, i8* %t1204
  %t1208 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1209 = icmp eq i32 %t1176, 10
  %t1210 = select i1 %t1209, i8* %t1208, i8* %t1207
  %t1211 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1212 = icmp eq i32 %t1176, 11
  %t1213 = select i1 %t1212, i8* %t1211, i8* %t1210
  %t1214 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1215 = icmp eq i32 %t1176, 12
  %t1216 = select i1 %t1215, i8* %t1214, i8* %t1213
  %t1217 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1218 = icmp eq i32 %t1176, 13
  %t1219 = select i1 %t1218, i8* %t1217, i8* %t1216
  %t1220 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1221 = icmp eq i32 %t1176, 14
  %t1222 = select i1 %t1221, i8* %t1220, i8* %t1219
  %t1223 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1224 = icmp eq i32 %t1176, 15
  %t1225 = select i1 %t1224, i8* %t1223, i8* %t1222
  %t1226 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1227 = icmp eq i32 %t1176, 16
  %t1228 = select i1 %t1227, i8* %t1226, i8* %t1225
  %t1229 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1230 = icmp eq i32 %t1176, 17
  %t1231 = select i1 %t1230, i8* %t1229, i8* %t1228
  %t1232 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1233 = icmp eq i32 %t1176, 18
  %t1234 = select i1 %t1233, i8* %t1232, i8* %t1231
  %t1235 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1236 = icmp eq i32 %t1176, 19
  %t1237 = select i1 %t1236, i8* %t1235, i8* %t1234
  %t1238 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1239 = icmp eq i32 %t1176, 20
  %t1240 = select i1 %t1239, i8* %t1238, i8* %t1237
  %t1241 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1242 = icmp eq i32 %t1176, 21
  %t1243 = select i1 %t1242, i8* %t1241, i8* %t1240
  %t1244 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1245 = icmp eq i32 %t1176, 22
  %t1246 = select i1 %t1245, i8* %t1244, i8* %t1243
  %s1247 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1842783069, i32 0, i32 0
  %t1248 = icmp eq i8* %t1246, %s1247
  br i1 %t1248, label %then8, label %merge9
then8:
  %t1249 = alloca [0 x %EffectViolation]
  %t1250 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t1249, i32 0, i32 0
  %t1251 = alloca { %EffectViolation*, i64 }
  %t1252 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1251, i32 0, i32 0
  store %EffectViolation* %t1250, %EffectViolation** %t1252
  %t1253 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1251, i32 0, i32 1
  store i64 0, i64* %t1253
  store { %EffectViolation*, i64 }* %t1251, { %EffectViolation*, i64 }** %l6
  %t1254 = sitofp i64 0 to double
  store double %t1254, double* %l7
  %t1255 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1256 = load double, double* %l7
  br label %loop.header10
loop.header10:
  %t1365 = phi { %EffectViolation*, i64 }* [ %t1255, %then8 ], [ %t1363, %loop.latch12 ]
  %t1366 = phi double [ %t1256, %then8 ], [ %t1364, %loop.latch12 ]
  store { %EffectViolation*, i64 }* %t1365, { %EffectViolation*, i64 }** %l6
  store double %t1366, double* %l7
  br label %loop.body11
loop.body11:
  %t1257 = load double, double* %l7
  %t1258 = extractvalue %Statement %statement, 0
  %t1259 = alloca %Statement
  store %Statement %statement, %Statement* %t1259
  %t1260 = getelementptr inbounds %Statement, %Statement* %t1259, i32 0, i32 1
  %t1261 = bitcast [56 x i8]* %t1260 to i8*
  %t1262 = getelementptr inbounds i8, i8* %t1261, i64 40
  %t1263 = bitcast i8* %t1262 to { %MethodDeclaration**, i64 }**
  %t1264 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1263
  %t1265 = icmp eq i32 %t1258, 8
  %t1266 = select i1 %t1265, { %MethodDeclaration**, i64 }* %t1264, { %MethodDeclaration**, i64 }* null
  %t1267 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1266
  %t1268 = extractvalue { %MethodDeclaration**, i64 } %t1267, 1
  %t1269 = sitofp i64 %t1268 to double
  %t1270 = fcmp oge double %t1257, %t1269
  %t1271 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1272 = load double, double* %l7
  br i1 %t1270, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t1273 = extractvalue %Statement %statement, 0
  %t1274 = alloca %Statement
  store %Statement %statement, %Statement* %t1274
  %t1275 = getelementptr inbounds %Statement, %Statement* %t1274, i32 0, i32 1
  %t1276 = bitcast [56 x i8]* %t1275 to i8*
  %t1277 = getelementptr inbounds i8, i8* %t1276, i64 40
  %t1278 = bitcast i8* %t1277 to { %MethodDeclaration**, i64 }**
  %t1279 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1278
  %t1280 = icmp eq i32 %t1273, 8
  %t1281 = select i1 %t1280, { %MethodDeclaration**, i64 }* %t1279, { %MethodDeclaration**, i64 }* null
  %t1282 = load double, double* %l7
  %t1283 = fptosi double %t1282 to i64
  %t1284 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1281
  %t1285 = extractvalue { %MethodDeclaration**, i64 } %t1284, 0
  %t1286 = extractvalue { %MethodDeclaration**, i64 } %t1284, 1
  %t1287 = icmp uge i64 %t1283, %t1286
  ; bounds check: %t1287 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1283, i64 %t1286)
  %t1288 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t1285, i64 %t1283
  %t1289 = load %MethodDeclaration*, %MethodDeclaration** %t1288
  store %MethodDeclaration* %t1289, %MethodDeclaration** %l8
  %t1290 = extractvalue %Statement %statement, 0
  %t1291 = alloca %Statement
  store %Statement %statement, %Statement* %t1291
  %t1292 = getelementptr inbounds %Statement, %Statement* %t1291, i32 0, i32 1
  %t1293 = bitcast [48 x i8]* %t1292 to i8*
  %t1294 = bitcast i8* %t1293 to i8**
  %t1295 = load i8*, i8** %t1294
  %t1296 = icmp eq i32 %t1290, 2
  %t1297 = select i1 %t1296, i8* %t1295, i8* null
  %t1298 = getelementptr inbounds %Statement, %Statement* %t1291, i32 0, i32 1
  %t1299 = bitcast [48 x i8]* %t1298 to i8*
  %t1300 = bitcast i8* %t1299 to i8**
  %t1301 = load i8*, i8** %t1300
  %t1302 = icmp eq i32 %t1290, 3
  %t1303 = select i1 %t1302, i8* %t1301, i8* %t1297
  %t1304 = getelementptr inbounds %Statement, %Statement* %t1291, i32 0, i32 1
  %t1305 = bitcast [40 x i8]* %t1304 to i8*
  %t1306 = bitcast i8* %t1305 to i8**
  %t1307 = load i8*, i8** %t1306
  %t1308 = icmp eq i32 %t1290, 6
  %t1309 = select i1 %t1308, i8* %t1307, i8* %t1303
  %t1310 = getelementptr inbounds %Statement, %Statement* %t1291, i32 0, i32 1
  %t1311 = bitcast [56 x i8]* %t1310 to i8*
  %t1312 = bitcast i8* %t1311 to i8**
  %t1313 = load i8*, i8** %t1312
  %t1314 = icmp eq i32 %t1290, 8
  %t1315 = select i1 %t1314, i8* %t1313, i8* %t1309
  %t1316 = getelementptr inbounds %Statement, %Statement* %t1291, i32 0, i32 1
  %t1317 = bitcast [40 x i8]* %t1316 to i8*
  %t1318 = bitcast i8* %t1317 to i8**
  %t1319 = load i8*, i8** %t1318
  %t1320 = icmp eq i32 %t1290, 9
  %t1321 = select i1 %t1320, i8* %t1319, i8* %t1315
  %t1322 = getelementptr inbounds %Statement, %Statement* %t1291, i32 0, i32 1
  %t1323 = bitcast [40 x i8]* %t1322 to i8*
  %t1324 = bitcast i8* %t1323 to i8**
  %t1325 = load i8*, i8** %t1324
  %t1326 = icmp eq i32 %t1290, 10
  %t1327 = select i1 %t1326, i8* %t1325, i8* %t1321
  %t1328 = getelementptr inbounds %Statement, %Statement* %t1291, i32 0, i32 1
  %t1329 = bitcast [40 x i8]* %t1328 to i8*
  %t1330 = bitcast i8* %t1329 to i8**
  %t1331 = load i8*, i8** %t1330
  %t1332 = icmp eq i32 %t1290, 11
  %t1333 = select i1 %t1332, i8* %t1331, i8* %t1327
  %t1334 = load i8, i8* %t1333
  %t1335 = add i8 %t1334, 46
  %t1336 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1337 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1336, i32 0, i32 0
  %t1338 = load %FunctionSignature, %FunctionSignature* %t1337
  %t1339 = extractvalue %FunctionSignature %t1338, 0
  %t1340 = load i8, i8* %t1339
  %t1341 = add i8 %t1335, %t1340
  store i8 %t1341, i8* %l9
  %t1342 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1343 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1344 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1343, i32 0, i32 0
  %t1345 = load %FunctionSignature, %FunctionSignature* %t1344
  %t1346 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1347 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1346, i32 0, i32 1
  %t1348 = load %Block, %Block* %t1347
  %t1349 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1350 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1349, i32 0, i32 2
  %t1351 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1350
  %t1352 = load i8, i8* %l9
  %t1353 = bitcast { %Decorator**, i64 }* %t1351 to { %Decorator*, i64 }*
  %t1354 = alloca [2 x i8], align 1
  %t1355 = getelementptr [2 x i8], [2 x i8]* %t1354, i32 0, i32 0
  store i8 %t1352, i8* %t1355
  %t1356 = getelementptr [2 x i8], [2 x i8]* %t1354, i32 0, i32 1
  store i8 0, i8* %t1356
  %t1357 = getelementptr [2 x i8], [2 x i8]* %t1354, i32 0, i32 0
  %t1358 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t1345, %Block %t1348, { %Decorator*, i64 }* %t1353, i8* %t1357)
  %t1359 = call { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }* %t1342, { %EffectViolation*, i64 }* %t1358)
  store { %EffectViolation*, i64 }* %t1359, { %EffectViolation*, i64 }** %l6
  %t1360 = load double, double* %l7
  %t1361 = sitofp i64 1 to double
  %t1362 = fadd double %t1360, %t1361
  store double %t1362, double* %l7
  br label %loop.latch12
loop.latch12:
  %t1363 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1364 = load double, double* %l7
  br label %loop.header10
afterloop13:
  %t1367 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1368 = load double, double* %l7
  %t1369 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  ret { %EffectViolation*, i64 }* %t1369
merge9:
  %t1370 = alloca [0 x %EffectViolation]
  %t1371 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t1370, i32 0, i32 0
  %t1372 = alloca { %EffectViolation*, i64 }
  %t1373 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1372, i32 0, i32 0
  store %EffectViolation* %t1371, %EffectViolation** %t1373
  %t1374 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1372, i32 0, i32 1
  store i64 0, i64* %t1374
  ret { %EffectViolation*, i64 }* %t1372
}

define { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %signature, %Block %body, { %Decorator*, i64 }* %decorators, i8* %name) {
entry:
  %l0 = alloca { %DecoratorInfo*, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca i1
  %l4 = alloca double
  %l5 = alloca %DecoratorInfo
  %l6 = alloca { %EffectRequirement*, i64 }*
  %l7 = alloca { i8**, i64 }*
  %l8 = alloca { %EffectRequirement*, i64 }*
  %l9 = alloca double
  %l10 = alloca %EffectRequirement
  %l11 = alloca i8*
  %l12 = alloca { %EffectViolation*, i64 }*
  %t0 = call { %DecoratorInfo*, i64 }* @evaluate_decorators({ %Decorator*, i64 }* %decorators)
  store { %DecoratorInfo*, i64 }* %t0, { %DecoratorInfo*, i64 }** %l0
  %t1 = alloca [0 x i8*]
  %t2 = getelementptr [0 x i8*], [0 x i8*]* %t1, i32 0, i32 0
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t2, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t35 = phi { i8**, i64 }* [ %t8, %entry ], [ %t33, %loop.latch2 ]
  %t36 = phi double [ %t9, %entry ], [ %t34, %loop.latch2 ]
  store { i8**, i64 }* %t35, { i8**, i64 }** %l1
  store double %t36, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = extractvalue %FunctionSignature %signature, 4
  %t12 = load { i8**, i64 }, { i8**, i64 }* %t11
  %t13 = extractvalue { i8**, i64 } %t12, 1
  %t14 = sitofp i64 %t13 to double
  %t15 = fcmp oge double %t10, %t14
  %t16 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t18 = load double, double* %l2
  br i1 %t15, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t20 = extractvalue %FunctionSignature %signature, 4
  %t21 = load double, double* %l2
  %t22 = fptosi double %t21 to i64
  %t23 = load { i8**, i64 }, { i8**, i64 }* %t20
  %t24 = extractvalue { i8**, i64 } %t23, 0
  %t25 = extractvalue { i8**, i64 } %t23, 1
  %t26 = icmp uge i64 %t22, %t25
  ; bounds check: %t26 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t22, i64 %t25)
  %t27 = getelementptr i8*, i8** %t24, i64 %t22
  %t28 = load i8*, i8** %t27
  %t29 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t19, i8* %t28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l1
  %t30 = load double, double* %l2
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l2
  br label %loop.latch2
loop.latch2:
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t34 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t38 = load double, double* %l2
  store i1 0, i1* %l3
  %t39 = sitofp i64 0 to double
  store double %t39, double* %l4
  %t40 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t42 = load double, double* %l2
  %t43 = load i1, i1* %l3
  %t44 = load double, double* %l4
  br label %loop.header6
loop.header6:
  %t92 = phi i1 [ %t43, %afterloop3 ], [ %t90, %loop.latch8 ]
  %t93 = phi double [ %t44, %afterloop3 ], [ %t91, %loop.latch8 ]
  store i1 %t92, i1* %l3
  store double %t93, double* %l4
  br label %loop.body7
loop.body7:
  %t45 = load double, double* %l4
  %t46 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t47 = load { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t46
  %t48 = extractvalue { %DecoratorInfo*, i64 } %t47, 1
  %t49 = sitofp i64 %t48 to double
  %t50 = fcmp oge double %t45, %t49
  %t51 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t53 = load double, double* %l2
  %t54 = load i1, i1* %l3
  %t55 = load double, double* %l4
  br i1 %t50, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t56 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t57 = load double, double* %l4
  %t58 = fptosi double %t57 to i64
  %t59 = load { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t56
  %t60 = extractvalue { %DecoratorInfo*, i64 } %t59, 0
  %t61 = extractvalue { %DecoratorInfo*, i64 } %t59, 1
  %t62 = icmp uge i64 %t58, %t61
  ; bounds check: %t62 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t58, i64 %t61)
  %t63 = getelementptr %DecoratorInfo, %DecoratorInfo* %t60, i64 %t58
  %t64 = load %DecoratorInfo, %DecoratorInfo* %t63
  store %DecoratorInfo %t64, %DecoratorInfo* %l5
  %t66 = load %DecoratorInfo, %DecoratorInfo* %l5
  %t67 = extractvalue %DecoratorInfo %t66, 0
  %s68 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h515589823, i32 0, i32 0
  %t69 = icmp eq i8* %t67, %s68
  br label %logical_or_entry_65

logical_or_entry_65:
  br i1 %t69, label %logical_or_merge_65, label %logical_or_right_65

logical_or_right_65:
  %t71 = load %DecoratorInfo, %DecoratorInfo* %l5
  %t72 = extractvalue %DecoratorInfo %t71, 0
  %s73 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h1147459442, i32 0, i32 0
  %t74 = icmp eq i8* %t72, %s73
  br label %logical_or_entry_70

logical_or_entry_70:
  br i1 %t74, label %logical_or_merge_70, label %logical_or_right_70

logical_or_right_70:
  %t75 = load %DecoratorInfo, %DecoratorInfo* %l5
  %t76 = extractvalue %DecoratorInfo %t75, 0
  %s77 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h1170311443, i32 0, i32 0
  %t78 = icmp eq i8* %t76, %s77
  br label %logical_or_right_end_70

logical_or_right_end_70:
  br label %logical_or_merge_70

logical_or_merge_70:
  %t79 = phi i1 [ true, %logical_or_entry_70 ], [ %t78, %logical_or_right_end_70 ]
  br label %logical_or_right_end_65

logical_or_right_end_65:
  br label %logical_or_merge_65

logical_or_merge_65:
  %t80 = phi i1 [ true, %logical_or_entry_65 ], [ %t79, %logical_or_right_end_65 ]
  %t81 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t83 = load double, double* %l2
  %t84 = load i1, i1* %l3
  %t85 = load double, double* %l4
  %t86 = load %DecoratorInfo, %DecoratorInfo* %l5
  br i1 %t80, label %then12, label %merge13
then12:
  store i1 1, i1* %l3
  br label %afterloop9
merge13:
  %t87 = load double, double* %l4
  %t88 = sitofp i64 1 to double
  %t89 = fadd double %t87, %t88
  store double %t89, double* %l4
  br label %loop.latch8
loop.latch8:
  %t90 = load i1, i1* %l3
  %t91 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t94 = load i1, i1* %l3
  %t95 = load double, double* %l4
  %t96 = load i1, i1* %l3
  %t97 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t99 = load double, double* %l2
  %t100 = load i1, i1* %l3
  %t101 = load double, double* %l4
  br i1 %t96, label %then14, label %merge15
then14:
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s103 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193495007, i32 0, i32 0
  %t104 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t102, i8* %s103)
  store { i8**, i64 }* %t104, { i8**, i64 }** %l1
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge15
merge15:
  %t106 = phi { i8**, i64 }* [ %t105, %then14 ], [ %t98, %afterloop9 ]
  store { i8**, i64 }* %t106, { i8**, i64 }** %l1
  %t107 = call { %EffectRequirement*, i64 }* @required_effects(%Block %body)
  store { %EffectRequirement*, i64 }* %t107, { %EffectRequirement*, i64 }** %l6
  %t108 = alloca [0 x i8*]
  %t109 = getelementptr [0 x i8*], [0 x i8*]* %t108, i32 0, i32 0
  %t110 = alloca { i8**, i64 }
  %t111 = getelementptr { i8**, i64 }, { i8**, i64 }* %t110, i32 0, i32 0
  store i8** %t109, i8*** %t111
  %t112 = getelementptr { i8**, i64 }, { i8**, i64 }* %t110, i32 0, i32 1
  store i64 0, i64* %t112
  store { i8**, i64 }* %t110, { i8**, i64 }** %l7
  %t113 = alloca [0 x %EffectRequirement]
  %t114 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t113, i32 0, i32 0
  %t115 = alloca { %EffectRequirement*, i64 }
  %t116 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t115, i32 0, i32 0
  store %EffectRequirement* %t114, %EffectRequirement** %t116
  %t117 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t115, i32 0, i32 1
  store i64 0, i64* %t117
  store { %EffectRequirement*, i64 }* %t115, { %EffectRequirement*, i64 }** %l8
  %t118 = sitofp i64 0 to double
  store double %t118, double* %l9
  %t119 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t121 = load double, double* %l2
  %t122 = load i1, i1* %l3
  %t123 = load double, double* %l4
  %t124 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t126 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t127 = load double, double* %l9
  br label %loop.header16
loop.header16:
  %t220 = phi double [ %t127, %merge15 ], [ %t217, %loop.latch18 ]
  %t221 = phi { i8**, i64 }* [ %t125, %merge15 ], [ %t218, %loop.latch18 ]
  %t222 = phi { %EffectRequirement*, i64 }* [ %t126, %merge15 ], [ %t219, %loop.latch18 ]
  store double %t220, double* %l9
  store { i8**, i64 }* %t221, { i8**, i64 }** %l7
  store { %EffectRequirement*, i64 }* %t222, { %EffectRequirement*, i64 }** %l8
  br label %loop.body17
loop.body17:
  %t128 = load double, double* %l9
  %t129 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t130 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t129
  %t131 = extractvalue { %EffectRequirement*, i64 } %t130, 1
  %t132 = sitofp i64 %t131 to double
  %t133 = fcmp oge double %t128, %t132
  %t134 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t136 = load double, double* %l2
  %t137 = load i1, i1* %l3
  %t138 = load double, double* %l4
  %t139 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t141 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t142 = load double, double* %l9
  br i1 %t133, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t143 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t144 = load double, double* %l9
  %t145 = fptosi double %t144 to i64
  %t146 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t143
  %t147 = extractvalue { %EffectRequirement*, i64 } %t146, 0
  %t148 = extractvalue { %EffectRequirement*, i64 } %t146, 1
  %t149 = icmp uge i64 %t145, %t148
  ; bounds check: %t149 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t145, i64 %t148)
  %t150 = getelementptr %EffectRequirement, %EffectRequirement* %t147, i64 %t145
  %t151 = load %EffectRequirement, %EffectRequirement* %t150
  store %EffectRequirement %t151, %EffectRequirement* %l10
  %t152 = load %EffectRequirement, %EffectRequirement* %l10
  %t153 = extractvalue %EffectRequirement %t152, 0
  store i8* %t153, i8** %l11
  %t155 = load i8*, i8** %l11
  %s156 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193495007, i32 0, i32 0
  %t157 = icmp eq i8* %t155, %s156
  br label %logical_and_entry_154

logical_and_entry_154:
  br i1 %t157, label %logical_and_right_154, label %logical_and_merge_154

logical_and_right_154:
  %t158 = load i1, i1* %l3
  br label %logical_and_right_end_154

logical_and_right_end_154:
  br label %logical_and_merge_154

logical_and_merge_154:
  %t159 = phi i1 [ false, %logical_and_entry_154 ], [ %t158, %logical_and_right_end_154 ]
  %t160 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t162 = load double, double* %l2
  %t163 = load i1, i1* %l3
  %t164 = load double, double* %l4
  %t165 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t167 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t168 = load double, double* %l9
  %t169 = load %EffectRequirement, %EffectRequirement* %l10
  %t170 = load i8*, i8** %l11
  br i1 %t159, label %then22, label %merge23
then22:
  %t171 = load double, double* %l9
  %t172 = sitofp i64 1 to double
  %t173 = fadd double %t171, %t172
  store double %t173, double* %l9
  br label %loop.latch18
merge23:
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t175 = load i8*, i8** %l11
  %t176 = call i1 @contains_effect({ i8**, i64 }* %t174, i8* %t175)
  %t177 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t179 = load double, double* %l2
  %t180 = load i1, i1* %l3
  %t181 = load double, double* %l4
  %t182 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t184 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t185 = load double, double* %l9
  %t186 = load %EffectRequirement, %EffectRequirement* %l10
  %t187 = load i8*, i8** %l11
  br i1 %t176, label %then24, label %merge25
then24:
  %t188 = load double, double* %l9
  %t189 = sitofp i64 1 to double
  %t190 = fadd double %t188, %t189
  store double %t190, double* %l9
  br label %loop.latch18
merge25:
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t192 = load i8*, i8** %l11
  %t193 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t191, i8* %t192)
  store { i8**, i64 }* %t193, { i8**, i64 }** %l7
  %t194 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t195 = load i8*, i8** %l11
  %t196 = call i1 @contains_requirement_for_effect({ %EffectRequirement*, i64 }* %t194, i8* %t195)
  %t197 = xor i1 %t196, 1
  %t198 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t199 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t200 = load double, double* %l2
  %t201 = load i1, i1* %l3
  %t202 = load double, double* %l4
  %t203 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t205 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t206 = load double, double* %l9
  %t207 = load %EffectRequirement, %EffectRequirement* %l10
  %t208 = load i8*, i8** %l11
  br i1 %t197, label %then26, label %merge27
then26:
  %t209 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t210 = load %EffectRequirement, %EffectRequirement* %l10
  %t211 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t209, %EffectRequirement %t210)
  store { %EffectRequirement*, i64 }* %t211, { %EffectRequirement*, i64 }** %l8
  %t212 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  br label %merge27
merge27:
  %t213 = phi { %EffectRequirement*, i64 }* [ %t212, %then26 ], [ %t205, %merge25 ]
  store { %EffectRequirement*, i64 }* %t213, { %EffectRequirement*, i64 }** %l8
  %t214 = load double, double* %l9
  %t215 = sitofp i64 1 to double
  %t216 = fadd double %t214, %t215
  store double %t216, double* %l9
  br label %loop.latch18
loop.latch18:
  %t217 = load double, double* %l9
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t219 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  br label %loop.header16
afterloop19:
  %t223 = load double, double* %l9
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t225 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t227 = load { i8**, i64 }, { i8**, i64 }* %t226
  %t228 = extractvalue { i8**, i64 } %t227, 1
  %t229 = icmp eq i64 %t228, 0
  %t230 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t232 = load double, double* %l2
  %t233 = load i1, i1* %l3
  %t234 = load double, double* %l4
  %t235 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t237 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t238 = load double, double* %l9
  br i1 %t229, label %then28, label %merge29
then28:
  %t239 = alloca [0 x %EffectViolation]
  %t240 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t239, i32 0, i32 0
  %t241 = alloca { %EffectViolation*, i64 }
  %t242 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t241, i32 0, i32 0
  store %EffectViolation* %t240, %EffectViolation** %t242
  %t243 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t241, i32 0, i32 1
  store i64 0, i64* %t243
  ret { %EffectViolation*, i64 }* %t241
merge29:
  %t244 = alloca [0 x %EffectViolation]
  %t245 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t244, i32 0, i32 0
  %t246 = alloca { %EffectViolation*, i64 }
  %t247 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t246, i32 0, i32 0
  store %EffectViolation* %t245, %EffectViolation** %t247
  %t248 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t246, i32 0, i32 1
  store i64 0, i64* %t248
  store { %EffectViolation*, i64 }* %t246, { %EffectViolation*, i64 }** %l12
  %t249 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l12
  %t250 = insertvalue %EffectViolation undef, i8* %name, 0
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t252 = insertvalue %EffectViolation %t250, { i8**, i64 }* %t251, 1
  %t253 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t254 = bitcast { %EffectRequirement*, i64 }* %t253 to { %EffectRequirement**, i64 }*
  %t255 = insertvalue %EffectViolation %t252, { %EffectRequirement**, i64 }* %t254, 2
  %t256 = call { %EffectViolation*, i64 }* @append_violation({ %EffectViolation*, i64 }* %t249, %EffectViolation %t255)
  store { %EffectViolation*, i64 }* %t256, { %EffectViolation*, i64 }** %l12
  %t257 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l12
  ret { %EffectViolation*, i64 }* %t257
}

define { %EffectRequirement*, i64 }* @required_effects(%Block %body) {
entry:
  %t0 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %body)
  ret { %EffectRequirement*, i64 }* %t0
}

define { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %block) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %l1 = alloca double
  %t0 = extractvalue %Block %block, 0
  %t1 = bitcast { %Token**, i64 }* %t0 to { %Token*, i64 }*
  %t2 = call { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* %t1)
  store { %EffectRequirement*, i64 }* %t2, { %EffectRequirement*, i64 }** %l0
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l1
  %t4 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t5 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t32 = phi { %EffectRequirement*, i64 }* [ %t4, %entry ], [ %t30, %loop.latch2 ]
  %t33 = phi double [ %t5, %entry ], [ %t31, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t32, { %EffectRequirement*, i64 }** %l0
  store double %t33, double* %l1
  br label %loop.body1
loop.body1:
  %t6 = load double, double* %l1
  %t7 = extractvalue %Block %block, 2
  %t8 = load { %Statement**, i64 }, { %Statement**, i64 }* %t7
  %t9 = extractvalue { %Statement**, i64 } %t8, 1
  %t10 = sitofp i64 %t9 to double
  %t11 = fcmp oge double %t6, %t10
  %t12 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t13 = load double, double* %l1
  br i1 %t11, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t14 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t15 = extractvalue %Block %block, 2
  %t16 = load double, double* %l1
  %t17 = fptosi double %t16 to i64
  %t18 = load { %Statement**, i64 }, { %Statement**, i64 }* %t15
  %t19 = extractvalue { %Statement**, i64 } %t18, 0
  %t20 = extractvalue { %Statement**, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t17, i64 %t20)
  %t22 = getelementptr %Statement*, %Statement** %t19, i64 %t17
  %t23 = load %Statement*, %Statement** %t22
  %t24 = load %Statement, %Statement* %t23
  %t25 = call { %EffectRequirement*, i64 }* @collect_effects_from_statement(%Statement %t24)
  %t26 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t14, { %EffectRequirement*, i64 }* %t25)
  store { %EffectRequirement*, i64 }* %t26, { %EffectRequirement*, i64 }** %l0
  %t27 = load double, double* %l1
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l1
  br label %loop.latch2
loop.latch2:
  %t30 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t31 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t34 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t35 = load double, double* %l1
  %t36 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t36
}

define { %EffectRequirement*, i64 }* @collect_effects_from_optional_block(%Block* %block) {
entry:
  %t0 = icmp eq %Block* %block, null
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = alloca [0 x %EffectRequirement]
  %t2 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1, i32 0, i32 0
  %t3 = alloca { %EffectRequirement*, i64 }
  %t4 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t3, i32 0, i32 0
  store %EffectRequirement* %t2, %EffectRequirement** %t4
  %t5 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  ret { %EffectRequirement*, i64 }* %t3
merge1:
  %t6 = load %Block, %Block* %block
  %t7 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t6)
  ret { %EffectRequirement*, i64 }* %t7
}

define { %EffectRequirement*, i64 }* @collect_effects_from_optional_statement(%Statement* %statement) {
entry:
  %t0 = icmp eq %Statement* %statement, null
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = alloca [0 x %EffectRequirement]
  %t2 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1, i32 0, i32 0
  %t3 = alloca { %EffectRequirement*, i64 }
  %t4 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t3, i32 0, i32 0
  store %EffectRequirement* %t2, %EffectRequirement** %t4
  %t5 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  ret { %EffectRequirement*, i64 }* %t3
merge1:
  %t6 = load %Statement, %Statement* %statement
  %t7 = call { %EffectRequirement*, i64 }* @collect_effects_from_statement(%Statement %t6)
  ret { %EffectRequirement*, i64 }* %t7
}

define { %EffectRequirement*, i64 }* @collect_effects_from_statement(%Statement %statement) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %l1 = alloca { %EffectRequirement*, i64 }*
  %l2 = alloca double
  %l3 = alloca %WithClause*
  %l4 = alloca { %EffectRequirement*, i64 }*
  %l5 = alloca { %EffectRequirement*, i64 }*
  %l6 = alloca double
  %l7 = alloca { %EffectRequirement*, i64 }*
  %l8 = alloca %ElseBranch*
  %l9 = alloca { %EffectRequirement*, i64 }*
  %l10 = alloca double
  %l11 = alloca { %EffectRequirement*, i64 }*
  %l12 = alloca double
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
  %s71 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1067284810, i32 0, i32 0
  %t72 = icmp eq i8* %t70, %s71
  br i1 %t72, label %then0, label %merge1
then0:
  %t73 = extractvalue %Statement %statement, 0
  %t74 = alloca %Statement
  store %Statement %statement, %Statement* %t74
  %t75 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t76 = bitcast [24 x i8]* %t75 to i8*
  %t77 = getelementptr inbounds i8, i8* %t76, i64 8
  %t78 = bitcast i8* %t77 to %Block*
  %t79 = load %Block, %Block* %t78
  %t80 = icmp eq i32 %t73, 4
  %t81 = select i1 %t80, %Block %t79, %Block zeroinitializer
  %t82 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t83 = bitcast [24 x i8]* %t82 to i8*
  %t84 = getelementptr inbounds i8, i8* %t83, i64 8
  %t85 = bitcast i8* %t84 to %Block*
  %t86 = load %Block, %Block* %t85
  %t87 = icmp eq i32 %t73, 5
  %t88 = select i1 %t87, %Block %t86, %Block %t81
  %t89 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t90 = bitcast [40 x i8]* %t89 to i8*
  %t91 = getelementptr inbounds i8, i8* %t90, i64 16
  %t92 = bitcast i8* %t91 to %Block*
  %t93 = load %Block, %Block* %t92
  %t94 = icmp eq i32 %t73, 6
  %t95 = select i1 %t94, %Block %t93, %Block %t88
  %t96 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t97 = bitcast [24 x i8]* %t96 to i8*
  %t98 = getelementptr inbounds i8, i8* %t97, i64 8
  %t99 = bitcast i8* %t98 to %Block*
  %t100 = load %Block, %Block* %t99
  %t101 = icmp eq i32 %t73, 7
  %t102 = select i1 %t101, %Block %t100, %Block %t95
  %t103 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t104 = bitcast [40 x i8]* %t103 to i8*
  %t105 = getelementptr inbounds i8, i8* %t104, i64 24
  %t106 = bitcast i8* %t105 to %Block*
  %t107 = load %Block, %Block* %t106
  %t108 = icmp eq i32 %t73, 12
  %t109 = select i1 %t108, %Block %t107, %Block %t102
  %t110 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t111 = bitcast [24 x i8]* %t110 to i8*
  %t112 = getelementptr inbounds i8, i8* %t111, i64 8
  %t113 = bitcast i8* %t112 to %Block*
  %t114 = load %Block, %Block* %t113
  %t115 = icmp eq i32 %t73, 13
  %t116 = select i1 %t115, %Block %t114, %Block %t109
  %t117 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t118 = bitcast [24 x i8]* %t117 to i8*
  %t119 = getelementptr inbounds i8, i8* %t118, i64 8
  %t120 = bitcast i8* %t119 to %Block*
  %t121 = load %Block, %Block* %t120
  %t122 = icmp eq i32 %t73, 14
  %t123 = select i1 %t122, %Block %t121, %Block %t116
  %t124 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t125 = bitcast [16 x i8]* %t124 to i8*
  %t126 = bitcast i8* %t125 to %Block*
  %t127 = load %Block, %Block* %t126
  %t128 = icmp eq i32 %t73, 15
  %t129 = select i1 %t128, %Block %t127, %Block %t123
  %t130 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t129)
  store { %EffectRequirement*, i64 }* %t130, { %EffectRequirement*, i64 }** %l0
  %t131 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s132 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h238194529, i32 0, i32 0
  %t133 = insertvalue %EffectRequirement undef, i8* %s132, 0
  %t134 = extractvalue %Statement %statement, 0
  %t135 = alloca %Statement
  store %Statement %statement, %Statement* %t135
  %t136 = getelementptr inbounds %Statement, %Statement* %t135, i32 0, i32 1
  %t137 = bitcast [40 x i8]* %t136 to i8*
  %t138 = getelementptr inbounds i8, i8* %t137, i64 8
  %t139 = bitcast i8* %t138 to %Token*
  %t140 = load %Token, %Token* %t139
  %t141 = icmp eq i32 %t134, 12
  %t142 = select i1 %t141, %Token %t140, %Token zeroinitializer
  %t143 = alloca %Token
  store %Token %t142, %Token* %t143
  %t144 = insertvalue %EffectRequirement %t133, %Token* %t143, 1
  %s145 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h196867800, i32 0, i32 0
  %t146 = extractvalue %Statement %statement, 0
  %t147 = alloca %Statement
  store %Statement %statement, %Statement* %t147
  %t148 = getelementptr inbounds %Statement, %Statement* %t147, i32 0, i32 1
  %t149 = bitcast [40 x i8]* %t148 to i8*
  %t150 = bitcast i8* %t149 to i8**
  %t151 = load i8*, i8** %t150
  %t152 = icmp eq i32 %t146, 12
  %t153 = select i1 %t152, i8* %t151, i8* null
  %t154 = call i8* @sailfin_runtime_string_concat(i8* %s145, i8* %t153)
  %t155 = load i8, i8* %t154
  %t156 = add i8 %t155, 34
  %t157 = alloca [2 x i8], align 1
  %t158 = getelementptr [2 x i8], [2 x i8]* %t157, i32 0, i32 0
  store i8 %t156, i8* %t158
  %t159 = getelementptr [2 x i8], [2 x i8]* %t157, i32 0, i32 1
  store i8 0, i8* %t159
  %t160 = getelementptr [2 x i8], [2 x i8]* %t157, i32 0, i32 0
  %t161 = insertvalue %EffectRequirement %t144, i8* %t160, 2
  %t162 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t131, %EffectRequirement %t161)
  store { %EffectRequirement*, i64 }* %t162, { %EffectRequirement*, i64 }** %l0
  %t163 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t163
merge1:
  %t164 = extractvalue %Statement %statement, 0
  %t165 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t166 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t167 = icmp eq i32 %t164, 0
  %t168 = select i1 %t167, i8* %t166, i8* %t165
  %t169 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t170 = icmp eq i32 %t164, 1
  %t171 = select i1 %t170, i8* %t169, i8* %t168
  %t172 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t173 = icmp eq i32 %t164, 2
  %t174 = select i1 %t173, i8* %t172, i8* %t171
  %t175 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t176 = icmp eq i32 %t164, 3
  %t177 = select i1 %t176, i8* %t175, i8* %t174
  %t178 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t179 = icmp eq i32 %t164, 4
  %t180 = select i1 %t179, i8* %t178, i8* %t177
  %t181 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t182 = icmp eq i32 %t164, 5
  %t183 = select i1 %t182, i8* %t181, i8* %t180
  %t184 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t185 = icmp eq i32 %t164, 6
  %t186 = select i1 %t185, i8* %t184, i8* %t183
  %t187 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t188 = icmp eq i32 %t164, 7
  %t189 = select i1 %t188, i8* %t187, i8* %t186
  %t190 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t191 = icmp eq i32 %t164, 8
  %t192 = select i1 %t191, i8* %t190, i8* %t189
  %t193 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t194 = icmp eq i32 %t164, 9
  %t195 = select i1 %t194, i8* %t193, i8* %t192
  %t196 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t197 = icmp eq i32 %t164, 10
  %t198 = select i1 %t197, i8* %t196, i8* %t195
  %t199 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t200 = icmp eq i32 %t164, 11
  %t201 = select i1 %t200, i8* %t199, i8* %t198
  %t202 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t203 = icmp eq i32 %t164, 12
  %t204 = select i1 %t203, i8* %t202, i8* %t201
  %t205 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t206 = icmp eq i32 %t164, 13
  %t207 = select i1 %t206, i8* %t205, i8* %t204
  %t208 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t209 = icmp eq i32 %t164, 14
  %t210 = select i1 %t209, i8* %t208, i8* %t207
  %t211 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t212 = icmp eq i32 %t164, 15
  %t213 = select i1 %t212, i8* %t211, i8* %t210
  %t214 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t215 = icmp eq i32 %t164, 16
  %t216 = select i1 %t215, i8* %t214, i8* %t213
  %t217 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t218 = icmp eq i32 %t164, 17
  %t219 = select i1 %t218, i8* %t217, i8* %t216
  %t220 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t221 = icmp eq i32 %t164, 18
  %t222 = select i1 %t221, i8* %t220, i8* %t219
  %t223 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t224 = icmp eq i32 %t164, 19
  %t225 = select i1 %t224, i8* %t223, i8* %t222
  %t226 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t227 = icmp eq i32 %t164, 20
  %t228 = select i1 %t227, i8* %t226, i8* %t225
  %t229 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t230 = icmp eq i32 %t164, 21
  %t231 = select i1 %t230, i8* %t229, i8* %t228
  %t232 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t233 = icmp eq i32 %t164, 22
  %t234 = select i1 %t233, i8* %t232, i8* %t231
  %s235 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1925822000, i32 0, i32 0
  %t236 = icmp eq i8* %t234, %s235
  br i1 %t236, label %then2, label %merge3
then2:
  %t237 = extractvalue %Statement %statement, 0
  %t238 = alloca %Statement
  store %Statement %statement, %Statement* %t238
  %t239 = getelementptr inbounds %Statement, %Statement* %t238, i32 0, i32 1
  %t240 = bitcast [24 x i8]* %t239 to i8*
  %t241 = getelementptr inbounds i8, i8* %t240, i64 8
  %t242 = bitcast i8* %t241 to %Block*
  %t243 = load %Block, %Block* %t242
  %t244 = icmp eq i32 %t237, 4
  %t245 = select i1 %t244, %Block %t243, %Block zeroinitializer
  %t246 = getelementptr inbounds %Statement, %Statement* %t238, i32 0, i32 1
  %t247 = bitcast [24 x i8]* %t246 to i8*
  %t248 = getelementptr inbounds i8, i8* %t247, i64 8
  %t249 = bitcast i8* %t248 to %Block*
  %t250 = load %Block, %Block* %t249
  %t251 = icmp eq i32 %t237, 5
  %t252 = select i1 %t251, %Block %t250, %Block %t245
  %t253 = getelementptr inbounds %Statement, %Statement* %t238, i32 0, i32 1
  %t254 = bitcast [40 x i8]* %t253 to i8*
  %t255 = getelementptr inbounds i8, i8* %t254, i64 16
  %t256 = bitcast i8* %t255 to %Block*
  %t257 = load %Block, %Block* %t256
  %t258 = icmp eq i32 %t237, 6
  %t259 = select i1 %t258, %Block %t257, %Block %t252
  %t260 = getelementptr inbounds %Statement, %Statement* %t238, i32 0, i32 1
  %t261 = bitcast [24 x i8]* %t260 to i8*
  %t262 = getelementptr inbounds i8, i8* %t261, i64 8
  %t263 = bitcast i8* %t262 to %Block*
  %t264 = load %Block, %Block* %t263
  %t265 = icmp eq i32 %t237, 7
  %t266 = select i1 %t265, %Block %t264, %Block %t259
  %t267 = getelementptr inbounds %Statement, %Statement* %t238, i32 0, i32 1
  %t268 = bitcast [40 x i8]* %t267 to i8*
  %t269 = getelementptr inbounds i8, i8* %t268, i64 24
  %t270 = bitcast i8* %t269 to %Block*
  %t271 = load %Block, %Block* %t270
  %t272 = icmp eq i32 %t237, 12
  %t273 = select i1 %t272, %Block %t271, %Block %t266
  %t274 = getelementptr inbounds %Statement, %Statement* %t238, i32 0, i32 1
  %t275 = bitcast [24 x i8]* %t274 to i8*
  %t276 = getelementptr inbounds i8, i8* %t275, i64 8
  %t277 = bitcast i8* %t276 to %Block*
  %t278 = load %Block, %Block* %t277
  %t279 = icmp eq i32 %t237, 13
  %t280 = select i1 %t279, %Block %t278, %Block %t273
  %t281 = getelementptr inbounds %Statement, %Statement* %t238, i32 0, i32 1
  %t282 = bitcast [24 x i8]* %t281 to i8*
  %t283 = getelementptr inbounds i8, i8* %t282, i64 8
  %t284 = bitcast i8* %t283 to %Block*
  %t285 = load %Block, %Block* %t284
  %t286 = icmp eq i32 %t237, 14
  %t287 = select i1 %t286, %Block %t285, %Block %t280
  %t288 = getelementptr inbounds %Statement, %Statement* %t238, i32 0, i32 1
  %t289 = bitcast [16 x i8]* %t288 to i8*
  %t290 = bitcast i8* %t289 to %Block*
  %t291 = load %Block, %Block* %t290
  %t292 = icmp eq i32 %t237, 15
  %t293 = select i1 %t292, %Block %t291, %Block %t287
  %t294 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t293)
  store { %EffectRequirement*, i64 }* %t294, { %EffectRequirement*, i64 }** %l1
  %t295 = sitofp i64 0 to double
  store double %t295, double* %l2
  %t296 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t297 = load double, double* %l2
  br label %loop.header4
loop.header4:
  %t341 = phi { %EffectRequirement*, i64 }* [ %t296, %then2 ], [ %t339, %loop.latch6 ]
  %t342 = phi double [ %t297, %then2 ], [ %t340, %loop.latch6 ]
  store { %EffectRequirement*, i64 }* %t341, { %EffectRequirement*, i64 }** %l1
  store double %t342, double* %l2
  br label %loop.body5
loop.body5:
  %t298 = load double, double* %l2
  %t299 = extractvalue %Statement %statement, 0
  %t300 = alloca %Statement
  store %Statement %statement, %Statement* %t300
  %t301 = getelementptr inbounds %Statement, %Statement* %t300, i32 0, i32 1
  %t302 = bitcast [24 x i8]* %t301 to i8*
  %t303 = bitcast i8* %t302 to { %WithClause**, i64 }**
  %t304 = load { %WithClause**, i64 }*, { %WithClause**, i64 }** %t303
  %t305 = icmp eq i32 %t299, 13
  %t306 = select i1 %t305, { %WithClause**, i64 }* %t304, { %WithClause**, i64 }* null
  %t307 = load { %WithClause**, i64 }, { %WithClause**, i64 }* %t306
  %t308 = extractvalue { %WithClause**, i64 } %t307, 1
  %t309 = sitofp i64 %t308 to double
  %t310 = fcmp oge double %t298, %t309
  %t311 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t312 = load double, double* %l2
  br i1 %t310, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t313 = extractvalue %Statement %statement, 0
  %t314 = alloca %Statement
  store %Statement %statement, %Statement* %t314
  %t315 = getelementptr inbounds %Statement, %Statement* %t314, i32 0, i32 1
  %t316 = bitcast [24 x i8]* %t315 to i8*
  %t317 = bitcast i8* %t316 to { %WithClause**, i64 }**
  %t318 = load { %WithClause**, i64 }*, { %WithClause**, i64 }** %t317
  %t319 = icmp eq i32 %t313, 13
  %t320 = select i1 %t319, { %WithClause**, i64 }* %t318, { %WithClause**, i64 }* null
  %t321 = load double, double* %l2
  %t322 = fptosi double %t321 to i64
  %t323 = load { %WithClause**, i64 }, { %WithClause**, i64 }* %t320
  %t324 = extractvalue { %WithClause**, i64 } %t323, 0
  %t325 = extractvalue { %WithClause**, i64 } %t323, 1
  %t326 = icmp uge i64 %t322, %t325
  ; bounds check: %t326 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t322, i64 %t325)
  %t327 = getelementptr %WithClause*, %WithClause** %t324, i64 %t322
  %t328 = load %WithClause*, %WithClause** %t327
  store %WithClause* %t328, %WithClause** %l3
  %t329 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t330 = load %WithClause*, %WithClause** %l3
  %t331 = getelementptr %WithClause, %WithClause* %t330, i32 0, i32 0
  %t332 = load %Expression, %Expression* %t331
  %t333 = alloca %Expression
  store %Expression %t332, %Expression* %t333
  %t334 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t333)
  %t335 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t329, { %EffectRequirement*, i64 }* %t334)
  store { %EffectRequirement*, i64 }* %t335, { %EffectRequirement*, i64 }** %l1
  %t336 = load double, double* %l2
  %t337 = sitofp i64 1 to double
  %t338 = fadd double %t336, %t337
  store double %t338, double* %l2
  br label %loop.latch6
loop.latch6:
  %t339 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t340 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t343 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t344 = load double, double* %l2
  %t345 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t345
merge3:
  %t346 = extractvalue %Statement %statement, 0
  %t347 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t348 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t349 = icmp eq i32 %t346, 0
  %t350 = select i1 %t349, i8* %t348, i8* %t347
  %t351 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t352 = icmp eq i32 %t346, 1
  %t353 = select i1 %t352, i8* %t351, i8* %t350
  %t354 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t355 = icmp eq i32 %t346, 2
  %t356 = select i1 %t355, i8* %t354, i8* %t353
  %t357 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t358 = icmp eq i32 %t346, 3
  %t359 = select i1 %t358, i8* %t357, i8* %t356
  %t360 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t361 = icmp eq i32 %t346, 4
  %t362 = select i1 %t361, i8* %t360, i8* %t359
  %t363 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t364 = icmp eq i32 %t346, 5
  %t365 = select i1 %t364, i8* %t363, i8* %t362
  %t366 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t367 = icmp eq i32 %t346, 6
  %t368 = select i1 %t367, i8* %t366, i8* %t365
  %t369 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t370 = icmp eq i32 %t346, 7
  %t371 = select i1 %t370, i8* %t369, i8* %t368
  %t372 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t373 = icmp eq i32 %t346, 8
  %t374 = select i1 %t373, i8* %t372, i8* %t371
  %t375 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t376 = icmp eq i32 %t346, 9
  %t377 = select i1 %t376, i8* %t375, i8* %t374
  %t378 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t379 = icmp eq i32 %t346, 10
  %t380 = select i1 %t379, i8* %t378, i8* %t377
  %t381 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t382 = icmp eq i32 %t346, 11
  %t383 = select i1 %t382, i8* %t381, i8* %t380
  %t384 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t385 = icmp eq i32 %t346, 12
  %t386 = select i1 %t385, i8* %t384, i8* %t383
  %t387 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t388 = icmp eq i32 %t346, 13
  %t389 = select i1 %t388, i8* %t387, i8* %t386
  %t390 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t391 = icmp eq i32 %t346, 14
  %t392 = select i1 %t391, i8* %t390, i8* %t389
  %t393 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t394 = icmp eq i32 %t346, 15
  %t395 = select i1 %t394, i8* %t393, i8* %t392
  %t396 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t397 = icmp eq i32 %t346, 16
  %t398 = select i1 %t397, i8* %t396, i8* %t395
  %t399 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t400 = icmp eq i32 %t346, 17
  %t401 = select i1 %t400, i8* %t399, i8* %t398
  %t402 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t403 = icmp eq i32 %t346, 18
  %t404 = select i1 %t403, i8* %t402, i8* %t401
  %t405 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t406 = icmp eq i32 %t346, 19
  %t407 = select i1 %t406, i8* %t405, i8* %t404
  %t408 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t409 = icmp eq i32 %t346, 20
  %t410 = select i1 %t409, i8* %t408, i8* %t407
  %t411 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t412 = icmp eq i32 %t346, 21
  %t413 = select i1 %t412, i8* %t411, i8* %t410
  %t414 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t415 = icmp eq i32 %t346, 22
  %t416 = select i1 %t415, i8* %t414, i8* %t413
  %s417 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h84042670, i32 0, i32 0
  %t418 = icmp eq i8* %t416, %s417
  br i1 %t418, label %then10, label %merge11
then10:
  %t419 = extractvalue %Statement %statement, 0
  %t420 = alloca %Statement
  store %Statement %statement, %Statement* %t420
  %t421 = getelementptr inbounds %Statement, %Statement* %t420, i32 0, i32 1
  %t422 = bitcast [24 x i8]* %t421 to i8*
  %t423 = getelementptr inbounds i8, i8* %t422, i64 8
  %t424 = bitcast i8* %t423 to %Block*
  %t425 = load %Block, %Block* %t424
  %t426 = icmp eq i32 %t419, 4
  %t427 = select i1 %t426, %Block %t425, %Block zeroinitializer
  %t428 = getelementptr inbounds %Statement, %Statement* %t420, i32 0, i32 1
  %t429 = bitcast [24 x i8]* %t428 to i8*
  %t430 = getelementptr inbounds i8, i8* %t429, i64 8
  %t431 = bitcast i8* %t430 to %Block*
  %t432 = load %Block, %Block* %t431
  %t433 = icmp eq i32 %t419, 5
  %t434 = select i1 %t433, %Block %t432, %Block %t427
  %t435 = getelementptr inbounds %Statement, %Statement* %t420, i32 0, i32 1
  %t436 = bitcast [40 x i8]* %t435 to i8*
  %t437 = getelementptr inbounds i8, i8* %t436, i64 16
  %t438 = bitcast i8* %t437 to %Block*
  %t439 = load %Block, %Block* %t438
  %t440 = icmp eq i32 %t419, 6
  %t441 = select i1 %t440, %Block %t439, %Block %t434
  %t442 = getelementptr inbounds %Statement, %Statement* %t420, i32 0, i32 1
  %t443 = bitcast [24 x i8]* %t442 to i8*
  %t444 = getelementptr inbounds i8, i8* %t443, i64 8
  %t445 = bitcast i8* %t444 to %Block*
  %t446 = load %Block, %Block* %t445
  %t447 = icmp eq i32 %t419, 7
  %t448 = select i1 %t447, %Block %t446, %Block %t441
  %t449 = getelementptr inbounds %Statement, %Statement* %t420, i32 0, i32 1
  %t450 = bitcast [40 x i8]* %t449 to i8*
  %t451 = getelementptr inbounds i8, i8* %t450, i64 24
  %t452 = bitcast i8* %t451 to %Block*
  %t453 = load %Block, %Block* %t452
  %t454 = icmp eq i32 %t419, 12
  %t455 = select i1 %t454, %Block %t453, %Block %t448
  %t456 = getelementptr inbounds %Statement, %Statement* %t420, i32 0, i32 1
  %t457 = bitcast [24 x i8]* %t456 to i8*
  %t458 = getelementptr inbounds i8, i8* %t457, i64 8
  %t459 = bitcast i8* %t458 to %Block*
  %t460 = load %Block, %Block* %t459
  %t461 = icmp eq i32 %t419, 13
  %t462 = select i1 %t461, %Block %t460, %Block %t455
  %t463 = getelementptr inbounds %Statement, %Statement* %t420, i32 0, i32 1
  %t464 = bitcast [24 x i8]* %t463 to i8*
  %t465 = getelementptr inbounds i8, i8* %t464, i64 8
  %t466 = bitcast i8* %t465 to %Block*
  %t467 = load %Block, %Block* %t466
  %t468 = icmp eq i32 %t419, 14
  %t469 = select i1 %t468, %Block %t467, %Block %t462
  %t470 = getelementptr inbounds %Statement, %Statement* %t420, i32 0, i32 1
  %t471 = bitcast [16 x i8]* %t470 to i8*
  %t472 = bitcast i8* %t471 to %Block*
  %t473 = load %Block, %Block* %t472
  %t474 = icmp eq i32 %t419, 15
  %t475 = select i1 %t474, %Block %t473, %Block %t469
  %t476 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t475)
  store { %EffectRequirement*, i64 }* %t476, { %EffectRequirement*, i64 }** %l4
  %t477 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  %t478 = extractvalue %Statement %statement, 0
  %t479 = alloca %Statement
  store %Statement %statement, %Statement* %t479
  %t480 = getelementptr inbounds %Statement, %Statement* %t479, i32 0, i32 1
  %t481 = bitcast [24 x i8]* %t480 to i8*
  %t482 = bitcast i8* %t481 to %ForClause*
  %t483 = load %ForClause, %ForClause* %t482
  %t484 = icmp eq i32 %t478, 14
  %t485 = select i1 %t484, %ForClause %t483, %ForClause zeroinitializer
  %t486 = extractvalue %ForClause %t485, 0
  %t487 = alloca %Expression
  store %Expression %t486, %Expression* %t487
  %t488 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t487)
  %t489 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t477, { %EffectRequirement*, i64 }* %t488)
  store { %EffectRequirement*, i64 }* %t489, { %EffectRequirement*, i64 }** %l4
  %t490 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  %t491 = extractvalue %Statement %statement, 0
  %t492 = alloca %Statement
  store %Statement %statement, %Statement* %t492
  %t493 = getelementptr inbounds %Statement, %Statement* %t492, i32 0, i32 1
  %t494 = bitcast [24 x i8]* %t493 to i8*
  %t495 = bitcast i8* %t494 to %ForClause*
  %t496 = load %ForClause, %ForClause* %t495
  %t497 = icmp eq i32 %t491, 14
  %t498 = select i1 %t497, %ForClause %t496, %ForClause zeroinitializer
  %t499 = extractvalue %ForClause %t498, 1
  %t500 = alloca %Expression
  store %Expression %t499, %Expression* %t500
  %t501 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t500)
  %t502 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t490, { %EffectRequirement*, i64 }* %t501)
  store { %EffectRequirement*, i64 }* %t502, { %EffectRequirement*, i64 }** %l4
  %t503 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  ret { %EffectRequirement*, i64 }* %t503
merge11:
  %t504 = extractvalue %Statement %statement, 0
  %t505 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t506 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t507 = icmp eq i32 %t504, 0
  %t508 = select i1 %t507, i8* %t506, i8* %t505
  %t509 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t510 = icmp eq i32 %t504, 1
  %t511 = select i1 %t510, i8* %t509, i8* %t508
  %t512 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t513 = icmp eq i32 %t504, 2
  %t514 = select i1 %t513, i8* %t512, i8* %t511
  %t515 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t516 = icmp eq i32 %t504, 3
  %t517 = select i1 %t516, i8* %t515, i8* %t514
  %t518 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t519 = icmp eq i32 %t504, 4
  %t520 = select i1 %t519, i8* %t518, i8* %t517
  %t521 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t522 = icmp eq i32 %t504, 5
  %t523 = select i1 %t522, i8* %t521, i8* %t520
  %t524 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t525 = icmp eq i32 %t504, 6
  %t526 = select i1 %t525, i8* %t524, i8* %t523
  %t527 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t528 = icmp eq i32 %t504, 7
  %t529 = select i1 %t528, i8* %t527, i8* %t526
  %t530 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t531 = icmp eq i32 %t504, 8
  %t532 = select i1 %t531, i8* %t530, i8* %t529
  %t533 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t534 = icmp eq i32 %t504, 9
  %t535 = select i1 %t534, i8* %t533, i8* %t532
  %t536 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t537 = icmp eq i32 %t504, 10
  %t538 = select i1 %t537, i8* %t536, i8* %t535
  %t539 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t540 = icmp eq i32 %t504, 11
  %t541 = select i1 %t540, i8* %t539, i8* %t538
  %t542 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t543 = icmp eq i32 %t504, 12
  %t544 = select i1 %t543, i8* %t542, i8* %t541
  %t545 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t546 = icmp eq i32 %t504, 13
  %t547 = select i1 %t546, i8* %t545, i8* %t544
  %t548 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t549 = icmp eq i32 %t504, 14
  %t550 = select i1 %t549, i8* %t548, i8* %t547
  %t551 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t552 = icmp eq i32 %t504, 15
  %t553 = select i1 %t552, i8* %t551, i8* %t550
  %t554 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t555 = icmp eq i32 %t504, 16
  %t556 = select i1 %t555, i8* %t554, i8* %t553
  %t557 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t558 = icmp eq i32 %t504, 17
  %t559 = select i1 %t558, i8* %t557, i8* %t556
  %t560 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t561 = icmp eq i32 %t504, 18
  %t562 = select i1 %t561, i8* %t560, i8* %t559
  %t563 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t564 = icmp eq i32 %t504, 19
  %t565 = select i1 %t564, i8* %t563, i8* %t562
  %t566 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t567 = icmp eq i32 %t504, 20
  %t568 = select i1 %t567, i8* %t566, i8* %t565
  %t569 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t570 = icmp eq i32 %t504, 21
  %t571 = select i1 %t570, i8* %t569, i8* %t568
  %t572 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t573 = icmp eq i32 %t504, 22
  %t574 = select i1 %t573, i8* %t572, i8* %t571
  %s575 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1678412334, i32 0, i32 0
  %t576 = icmp eq i8* %t574, %s575
  br i1 %t576, label %then12, label %merge13
then12:
  %t577 = extractvalue %Statement %statement, 0
  %t578 = alloca %Statement
  store %Statement %statement, %Statement* %t578
  %t579 = getelementptr inbounds %Statement, %Statement* %t578, i32 0, i32 1
  %t580 = bitcast [24 x i8]* %t579 to i8*
  %t581 = getelementptr inbounds i8, i8* %t580, i64 8
  %t582 = bitcast i8* %t581 to %Block*
  %t583 = load %Block, %Block* %t582
  %t584 = icmp eq i32 %t577, 4
  %t585 = select i1 %t584, %Block %t583, %Block zeroinitializer
  %t586 = getelementptr inbounds %Statement, %Statement* %t578, i32 0, i32 1
  %t587 = bitcast [24 x i8]* %t586 to i8*
  %t588 = getelementptr inbounds i8, i8* %t587, i64 8
  %t589 = bitcast i8* %t588 to %Block*
  %t590 = load %Block, %Block* %t589
  %t591 = icmp eq i32 %t577, 5
  %t592 = select i1 %t591, %Block %t590, %Block %t585
  %t593 = getelementptr inbounds %Statement, %Statement* %t578, i32 0, i32 1
  %t594 = bitcast [40 x i8]* %t593 to i8*
  %t595 = getelementptr inbounds i8, i8* %t594, i64 16
  %t596 = bitcast i8* %t595 to %Block*
  %t597 = load %Block, %Block* %t596
  %t598 = icmp eq i32 %t577, 6
  %t599 = select i1 %t598, %Block %t597, %Block %t592
  %t600 = getelementptr inbounds %Statement, %Statement* %t578, i32 0, i32 1
  %t601 = bitcast [24 x i8]* %t600 to i8*
  %t602 = getelementptr inbounds i8, i8* %t601, i64 8
  %t603 = bitcast i8* %t602 to %Block*
  %t604 = load %Block, %Block* %t603
  %t605 = icmp eq i32 %t577, 7
  %t606 = select i1 %t605, %Block %t604, %Block %t599
  %t607 = getelementptr inbounds %Statement, %Statement* %t578, i32 0, i32 1
  %t608 = bitcast [40 x i8]* %t607 to i8*
  %t609 = getelementptr inbounds i8, i8* %t608, i64 24
  %t610 = bitcast i8* %t609 to %Block*
  %t611 = load %Block, %Block* %t610
  %t612 = icmp eq i32 %t577, 12
  %t613 = select i1 %t612, %Block %t611, %Block %t606
  %t614 = getelementptr inbounds %Statement, %Statement* %t578, i32 0, i32 1
  %t615 = bitcast [24 x i8]* %t614 to i8*
  %t616 = getelementptr inbounds i8, i8* %t615, i64 8
  %t617 = bitcast i8* %t616 to %Block*
  %t618 = load %Block, %Block* %t617
  %t619 = icmp eq i32 %t577, 13
  %t620 = select i1 %t619, %Block %t618, %Block %t613
  %t621 = getelementptr inbounds %Statement, %Statement* %t578, i32 0, i32 1
  %t622 = bitcast [24 x i8]* %t621 to i8*
  %t623 = getelementptr inbounds i8, i8* %t622, i64 8
  %t624 = bitcast i8* %t623 to %Block*
  %t625 = load %Block, %Block* %t624
  %t626 = icmp eq i32 %t577, 14
  %t627 = select i1 %t626, %Block %t625, %Block %t620
  %t628 = getelementptr inbounds %Statement, %Statement* %t578, i32 0, i32 1
  %t629 = bitcast [16 x i8]* %t628 to i8*
  %t630 = bitcast i8* %t629 to %Block*
  %t631 = load %Block, %Block* %t630
  %t632 = icmp eq i32 %t577, 15
  %t633 = select i1 %t632, %Block %t631, %Block %t627
  %t634 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t633)
  ret { %EffectRequirement*, i64 }* %t634
merge13:
  %t635 = extractvalue %Statement %statement, 0
  %t636 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t637 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t638 = icmp eq i32 %t635, 0
  %t639 = select i1 %t638, i8* %t637, i8* %t636
  %t640 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t641 = icmp eq i32 %t635, 1
  %t642 = select i1 %t641, i8* %t640, i8* %t639
  %t643 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t644 = icmp eq i32 %t635, 2
  %t645 = select i1 %t644, i8* %t643, i8* %t642
  %t646 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t647 = icmp eq i32 %t635, 3
  %t648 = select i1 %t647, i8* %t646, i8* %t645
  %t649 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t650 = icmp eq i32 %t635, 4
  %t651 = select i1 %t650, i8* %t649, i8* %t648
  %t652 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t653 = icmp eq i32 %t635, 5
  %t654 = select i1 %t653, i8* %t652, i8* %t651
  %t655 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t656 = icmp eq i32 %t635, 6
  %t657 = select i1 %t656, i8* %t655, i8* %t654
  %t658 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t659 = icmp eq i32 %t635, 7
  %t660 = select i1 %t659, i8* %t658, i8* %t657
  %t661 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t662 = icmp eq i32 %t635, 8
  %t663 = select i1 %t662, i8* %t661, i8* %t660
  %t664 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t665 = icmp eq i32 %t635, 9
  %t666 = select i1 %t665, i8* %t664, i8* %t663
  %t667 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t668 = icmp eq i32 %t635, 10
  %t669 = select i1 %t668, i8* %t667, i8* %t666
  %t670 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t671 = icmp eq i32 %t635, 11
  %t672 = select i1 %t671, i8* %t670, i8* %t669
  %t673 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t674 = icmp eq i32 %t635, 12
  %t675 = select i1 %t674, i8* %t673, i8* %t672
  %t676 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t677 = icmp eq i32 %t635, 13
  %t678 = select i1 %t677, i8* %t676, i8* %t675
  %t679 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t680 = icmp eq i32 %t635, 14
  %t681 = select i1 %t680, i8* %t679, i8* %t678
  %t682 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t683 = icmp eq i32 %t635, 15
  %t684 = select i1 %t683, i8* %t682, i8* %t681
  %t685 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t686 = icmp eq i32 %t635, 16
  %t687 = select i1 %t686, i8* %t685, i8* %t684
  %t688 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t689 = icmp eq i32 %t635, 17
  %t690 = select i1 %t689, i8* %t688, i8* %t687
  %t691 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t692 = icmp eq i32 %t635, 18
  %t693 = select i1 %t692, i8* %t691, i8* %t690
  %t694 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t695 = icmp eq i32 %t635, 19
  %t696 = select i1 %t695, i8* %t694, i8* %t693
  %t697 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t698 = icmp eq i32 %t635, 20
  %t699 = select i1 %t698, i8* %t697, i8* %t696
  %t700 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t701 = icmp eq i32 %t635, 21
  %t702 = select i1 %t701, i8* %t700, i8* %t699
  %t703 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t704 = icmp eq i32 %t635, 22
  %t705 = select i1 %t704, i8* %t703, i8* %t702
  %s706 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h196308685, i32 0, i32 0
  %t707 = icmp eq i8* %t705, %s706
  br i1 %t707, label %then14, label %merge15
then14:
  %t708 = extractvalue %Statement %statement, 0
  %t709 = alloca %Statement
  store %Statement %statement, %Statement* %t709
  %t710 = getelementptr inbounds %Statement, %Statement* %t709, i32 0, i32 1
  %t711 = bitcast [16 x i8]* %t710 to i8*
  %t712 = bitcast i8* %t711 to %Expression**
  %t713 = load %Expression*, %Expression** %t712
  %t714 = icmp eq i32 %t708, 20
  %t715 = select i1 %t714, %Expression* %t713, %Expression* null
  %t716 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t715)
  store { %EffectRequirement*, i64 }* %t716, { %EffectRequirement*, i64 }** %l5
  %t717 = sitofp i64 0 to double
  store double %t717, double* %l6
  %t718 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t719 = load double, double* %l6
  br label %loop.header16
loop.header16:
  %t762 = phi { %EffectRequirement*, i64 }* [ %t718, %then14 ], [ %t760, %loop.latch18 ]
  %t763 = phi double [ %t719, %then14 ], [ %t761, %loop.latch18 ]
  store { %EffectRequirement*, i64 }* %t762, { %EffectRequirement*, i64 }** %l5
  store double %t763, double* %l6
  br label %loop.body17
loop.body17:
  %t720 = load double, double* %l6
  %t721 = extractvalue %Statement %statement, 0
  %t722 = alloca %Statement
  store %Statement %statement, %Statement* %t722
  %t723 = getelementptr inbounds %Statement, %Statement* %t722, i32 0, i32 1
  %t724 = bitcast [24 x i8]* %t723 to i8*
  %t725 = getelementptr inbounds i8, i8* %t724, i64 8
  %t726 = bitcast i8* %t725 to { %MatchCase**, i64 }**
  %t727 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t726
  %t728 = icmp eq i32 %t721, 18
  %t729 = select i1 %t728, { %MatchCase**, i64 }* %t727, { %MatchCase**, i64 }* null
  %t730 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t729
  %t731 = extractvalue { %MatchCase**, i64 } %t730, 1
  %t732 = sitofp i64 %t731 to double
  %t733 = fcmp oge double %t720, %t732
  %t734 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t735 = load double, double* %l6
  br i1 %t733, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t736 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t737 = extractvalue %Statement %statement, 0
  %t738 = alloca %Statement
  store %Statement %statement, %Statement* %t738
  %t739 = getelementptr inbounds %Statement, %Statement* %t738, i32 0, i32 1
  %t740 = bitcast [24 x i8]* %t739 to i8*
  %t741 = getelementptr inbounds i8, i8* %t740, i64 8
  %t742 = bitcast i8* %t741 to { %MatchCase**, i64 }**
  %t743 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t742
  %t744 = icmp eq i32 %t737, 18
  %t745 = select i1 %t744, { %MatchCase**, i64 }* %t743, { %MatchCase**, i64 }* null
  %t746 = load double, double* %l6
  %t747 = fptosi double %t746 to i64
  %t748 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t745
  %t749 = extractvalue { %MatchCase**, i64 } %t748, 0
  %t750 = extractvalue { %MatchCase**, i64 } %t748, 1
  %t751 = icmp uge i64 %t747, %t750
  ; bounds check: %t751 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t747, i64 %t750)
  %t752 = getelementptr %MatchCase*, %MatchCase** %t749, i64 %t747
  %t753 = load %MatchCase*, %MatchCase** %t752
  %t754 = load %MatchCase, %MatchCase* %t753
  %t755 = call { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase %t754)
  %t756 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t736, { %EffectRequirement*, i64 }* %t755)
  store { %EffectRequirement*, i64 }* %t756, { %EffectRequirement*, i64 }** %l5
  %t757 = load double, double* %l6
  %t758 = sitofp i64 1 to double
  %t759 = fadd double %t757, %t758
  store double %t759, double* %l6
  br label %loop.latch18
loop.latch18:
  %t760 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t761 = load double, double* %l6
  br label %loop.header16
afterloop19:
  %t764 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t765 = load double, double* %l6
  %t766 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  ret { %EffectRequirement*, i64 }* %t766
merge15:
  %t767 = extractvalue %Statement %statement, 0
  %t768 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t769 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t770 = icmp eq i32 %t767, 0
  %t771 = select i1 %t770, i8* %t769, i8* %t768
  %t772 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t773 = icmp eq i32 %t767, 1
  %t774 = select i1 %t773, i8* %t772, i8* %t771
  %t775 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t776 = icmp eq i32 %t767, 2
  %t777 = select i1 %t776, i8* %t775, i8* %t774
  %t778 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t779 = icmp eq i32 %t767, 3
  %t780 = select i1 %t779, i8* %t778, i8* %t777
  %t781 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t782 = icmp eq i32 %t767, 4
  %t783 = select i1 %t782, i8* %t781, i8* %t780
  %t784 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t785 = icmp eq i32 %t767, 5
  %t786 = select i1 %t785, i8* %t784, i8* %t783
  %t787 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t788 = icmp eq i32 %t767, 6
  %t789 = select i1 %t788, i8* %t787, i8* %t786
  %t790 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t791 = icmp eq i32 %t767, 7
  %t792 = select i1 %t791, i8* %t790, i8* %t789
  %t793 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t794 = icmp eq i32 %t767, 8
  %t795 = select i1 %t794, i8* %t793, i8* %t792
  %t796 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t797 = icmp eq i32 %t767, 9
  %t798 = select i1 %t797, i8* %t796, i8* %t795
  %t799 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t800 = icmp eq i32 %t767, 10
  %t801 = select i1 %t800, i8* %t799, i8* %t798
  %t802 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t803 = icmp eq i32 %t767, 11
  %t804 = select i1 %t803, i8* %t802, i8* %t801
  %t805 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t806 = icmp eq i32 %t767, 12
  %t807 = select i1 %t806, i8* %t805, i8* %t804
  %t808 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t809 = icmp eq i32 %t767, 13
  %t810 = select i1 %t809, i8* %t808, i8* %t807
  %t811 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t812 = icmp eq i32 %t767, 14
  %t813 = select i1 %t812, i8* %t811, i8* %t810
  %t814 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t815 = icmp eq i32 %t767, 15
  %t816 = select i1 %t815, i8* %t814, i8* %t813
  %t817 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t818 = icmp eq i32 %t767, 16
  %t819 = select i1 %t818, i8* %t817, i8* %t816
  %t820 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t821 = icmp eq i32 %t767, 17
  %t822 = select i1 %t821, i8* %t820, i8* %t819
  %t823 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t824 = icmp eq i32 %t767, 18
  %t825 = select i1 %t824, i8* %t823, i8* %t822
  %t826 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t827 = icmp eq i32 %t767, 19
  %t828 = select i1 %t827, i8* %t826, i8* %t825
  %t829 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t830 = icmp eq i32 %t767, 20
  %t831 = select i1 %t830, i8* %t829, i8* %t828
  %t832 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t833 = icmp eq i32 %t767, 21
  %t834 = select i1 %t833, i8* %t832, i8* %t831
  %t835 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t836 = icmp eq i32 %t767, 22
  %t837 = select i1 %t836, i8* %t835, i8* %t834
  %s838 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1566780570, i32 0, i32 0
  %t839 = icmp eq i8* %t837, %s838
  br i1 %t839, label %then22, label %merge23
then22:
  %t840 = extractvalue %Statement %statement, 0
  %t841 = alloca %Statement
  store %Statement %statement, %Statement* %t841
  %t842 = getelementptr inbounds %Statement, %Statement* %t841, i32 0, i32 1
  %t843 = bitcast [32 x i8]* %t842 to i8*
  %t844 = bitcast i8* %t843 to %Expression*
  %t845 = load %Expression, %Expression* %t844
  %t846 = icmp eq i32 %t840, 19
  %t847 = select i1 %t846, %Expression %t845, %Expression zeroinitializer
  %t848 = alloca %Expression
  store %Expression %t847, %Expression* %t848
  %t849 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t848)
  store { %EffectRequirement*, i64 }* %t849, { %EffectRequirement*, i64 }** %l7
  %t850 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t851 = extractvalue %Statement %statement, 0
  %t852 = alloca %Statement
  store %Statement %statement, %Statement* %t852
  %t853 = getelementptr inbounds %Statement, %Statement* %t852, i32 0, i32 1
  %t854 = bitcast [32 x i8]* %t853 to i8*
  %t855 = getelementptr inbounds i8, i8* %t854, i64 8
  %t856 = bitcast i8* %t855 to %Block*
  %t857 = load %Block, %Block* %t856
  %t858 = icmp eq i32 %t851, 19
  %t859 = select i1 %t858, %Block %t857, %Block zeroinitializer
  %t860 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t859)
  %t861 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t850, { %EffectRequirement*, i64 }* %t860)
  store { %EffectRequirement*, i64 }* %t861, { %EffectRequirement*, i64 }** %l7
  %t862 = extractvalue %Statement %statement, 0
  %t863 = alloca %Statement
  store %Statement %statement, %Statement* %t863
  %t864 = getelementptr inbounds %Statement, %Statement* %t863, i32 0, i32 1
  %t865 = bitcast [32 x i8]* %t864 to i8*
  %t866 = getelementptr inbounds i8, i8* %t865, i64 16
  %t867 = bitcast i8* %t866 to %ElseBranch**
  %t868 = load %ElseBranch*, %ElseBranch** %t867
  %t869 = icmp eq i32 %t862, 19
  %t870 = select i1 %t869, %ElseBranch* %t868, %ElseBranch* null
  store %ElseBranch* %t870, %ElseBranch** %l8
  %t871 = load %ElseBranch*, %ElseBranch** %l8
  %t872 = icmp eq %ElseBranch* %t871, null
  %t873 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t874 = load %ElseBranch*, %ElseBranch** %l8
  br i1 %t872, label %then24, label %merge25
then24:
  %t875 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t875
merge25:
  %t876 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t877 = load %ElseBranch*, %ElseBranch** %l8
  %t878 = load %ElseBranch, %ElseBranch* %t877
  %t879 = call { %EffectRequirement*, i64 }* @collect_effects_from_else_branch(%ElseBranch %t878)
  %t880 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t876, { %EffectRequirement*, i64 }* %t879)
  store { %EffectRequirement*, i64 }* %t880, { %EffectRequirement*, i64 }** %l7
  %t881 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t881
merge23:
  %t882 = extractvalue %Statement %statement, 0
  %t883 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t884 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t885 = icmp eq i32 %t882, 0
  %t886 = select i1 %t885, i8* %t884, i8* %t883
  %t887 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t888 = icmp eq i32 %t882, 1
  %t889 = select i1 %t888, i8* %t887, i8* %t886
  %t890 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t891 = icmp eq i32 %t882, 2
  %t892 = select i1 %t891, i8* %t890, i8* %t889
  %t893 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t894 = icmp eq i32 %t882, 3
  %t895 = select i1 %t894, i8* %t893, i8* %t892
  %t896 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t897 = icmp eq i32 %t882, 4
  %t898 = select i1 %t897, i8* %t896, i8* %t895
  %t899 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t900 = icmp eq i32 %t882, 5
  %t901 = select i1 %t900, i8* %t899, i8* %t898
  %t902 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t903 = icmp eq i32 %t882, 6
  %t904 = select i1 %t903, i8* %t902, i8* %t901
  %t905 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t906 = icmp eq i32 %t882, 7
  %t907 = select i1 %t906, i8* %t905, i8* %t904
  %t908 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t909 = icmp eq i32 %t882, 8
  %t910 = select i1 %t909, i8* %t908, i8* %t907
  %t911 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t912 = icmp eq i32 %t882, 9
  %t913 = select i1 %t912, i8* %t911, i8* %t910
  %t914 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t915 = icmp eq i32 %t882, 10
  %t916 = select i1 %t915, i8* %t914, i8* %t913
  %t917 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t918 = icmp eq i32 %t882, 11
  %t919 = select i1 %t918, i8* %t917, i8* %t916
  %t920 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t921 = icmp eq i32 %t882, 12
  %t922 = select i1 %t921, i8* %t920, i8* %t919
  %t923 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t924 = icmp eq i32 %t882, 13
  %t925 = select i1 %t924, i8* %t923, i8* %t922
  %t926 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t927 = icmp eq i32 %t882, 14
  %t928 = select i1 %t927, i8* %t926, i8* %t925
  %t929 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t930 = icmp eq i32 %t882, 15
  %t931 = select i1 %t930, i8* %t929, i8* %t928
  %t932 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t933 = icmp eq i32 %t882, 16
  %t934 = select i1 %t933, i8* %t932, i8* %t931
  %t935 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t936 = icmp eq i32 %t882, 17
  %t937 = select i1 %t936, i8* %t935, i8* %t934
  %t938 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t939 = icmp eq i32 %t882, 18
  %t940 = select i1 %t939, i8* %t938, i8* %t937
  %t941 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t942 = icmp eq i32 %t882, 19
  %t943 = select i1 %t942, i8* %t941, i8* %t940
  %t944 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t945 = icmp eq i32 %t882, 20
  %t946 = select i1 %t945, i8* %t944, i8* %t943
  %t947 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t948 = icmp eq i32 %t882, 21
  %t949 = select i1 %t948, i8* %t947, i8* %t946
  %t950 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t951 = icmp eq i32 %t882, 22
  %t952 = select i1 %t951, i8* %t950, i8* %t949
  %s953 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1613933868, i32 0, i32 0
  %t954 = icmp eq i8* %t952, %s953
  br i1 %t954, label %then26, label %merge27
then26:
  %t955 = extractvalue %Statement %statement, 0
  %t956 = alloca %Statement
  store %Statement %statement, %Statement* %t956
  %t957 = getelementptr inbounds %Statement, %Statement* %t956, i32 0, i32 1
  %t958 = bitcast [16 x i8]* %t957 to i8*
  %t959 = bitcast i8* %t958 to %Expression**
  %t960 = load %Expression*, %Expression** %t959
  %t961 = icmp eq i32 %t955, 20
  %t962 = select i1 %t961, %Expression* %t960, %Expression* null
  %t963 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t962)
  ret { %EffectRequirement*, i64 }* %t963
merge27:
  %t964 = extractvalue %Statement %statement, 0
  %t965 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t966 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t967 = icmp eq i32 %t964, 0
  %t968 = select i1 %t967, i8* %t966, i8* %t965
  %t969 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t970 = icmp eq i32 %t964, 1
  %t971 = select i1 %t970, i8* %t969, i8* %t968
  %t972 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t973 = icmp eq i32 %t964, 2
  %t974 = select i1 %t973, i8* %t972, i8* %t971
  %t975 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t976 = icmp eq i32 %t964, 3
  %t977 = select i1 %t976, i8* %t975, i8* %t974
  %t978 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t979 = icmp eq i32 %t964, 4
  %t980 = select i1 %t979, i8* %t978, i8* %t977
  %t981 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t982 = icmp eq i32 %t964, 5
  %t983 = select i1 %t982, i8* %t981, i8* %t980
  %t984 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t985 = icmp eq i32 %t964, 6
  %t986 = select i1 %t985, i8* %t984, i8* %t983
  %t987 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t988 = icmp eq i32 %t964, 7
  %t989 = select i1 %t988, i8* %t987, i8* %t986
  %t990 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t991 = icmp eq i32 %t964, 8
  %t992 = select i1 %t991, i8* %t990, i8* %t989
  %t993 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t994 = icmp eq i32 %t964, 9
  %t995 = select i1 %t994, i8* %t993, i8* %t992
  %t996 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t997 = icmp eq i32 %t964, 10
  %t998 = select i1 %t997, i8* %t996, i8* %t995
  %t999 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1000 = icmp eq i32 %t964, 11
  %t1001 = select i1 %t1000, i8* %t999, i8* %t998
  %t1002 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1003 = icmp eq i32 %t964, 12
  %t1004 = select i1 %t1003, i8* %t1002, i8* %t1001
  %t1005 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1006 = icmp eq i32 %t964, 13
  %t1007 = select i1 %t1006, i8* %t1005, i8* %t1004
  %t1008 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1009 = icmp eq i32 %t964, 14
  %t1010 = select i1 %t1009, i8* %t1008, i8* %t1007
  %t1011 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1012 = icmp eq i32 %t964, 15
  %t1013 = select i1 %t1012, i8* %t1011, i8* %t1010
  %t1014 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1015 = icmp eq i32 %t964, 16
  %t1016 = select i1 %t1015, i8* %t1014, i8* %t1013
  %t1017 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1018 = icmp eq i32 %t964, 17
  %t1019 = select i1 %t1018, i8* %t1017, i8* %t1016
  %t1020 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1021 = icmp eq i32 %t964, 18
  %t1022 = select i1 %t1021, i8* %t1020, i8* %t1019
  %t1023 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1024 = icmp eq i32 %t964, 19
  %t1025 = select i1 %t1024, i8* %t1023, i8* %t1022
  %t1026 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1027 = icmp eq i32 %t964, 20
  %t1028 = select i1 %t1027, i8* %t1026, i8* %t1025
  %t1029 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1030 = icmp eq i32 %t964, 21
  %t1031 = select i1 %t1030, i8* %t1029, i8* %t1028
  %t1032 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1033 = icmp eq i32 %t964, 22
  %t1034 = select i1 %t1033, i8* %t1032, i8* %t1031
  %s1035 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h868168677, i32 0, i32 0
  %t1036 = icmp eq i8* %t1034, %s1035
  br i1 %t1036, label %then28, label %merge29
then28:
  %t1037 = extractvalue %Statement %statement, 0
  %t1038 = alloca %Statement
  store %Statement %statement, %Statement* %t1038
  %t1039 = getelementptr inbounds %Statement, %Statement* %t1038, i32 0, i32 1
  %t1040 = bitcast [16 x i8]* %t1039 to i8*
  %t1041 = bitcast i8* %t1040 to %Expression**
  %t1042 = load %Expression*, %Expression** %t1041
  %t1043 = icmp eq i32 %t1037, 20
  %t1044 = select i1 %t1043, %Expression* %t1042, %Expression* null
  %t1045 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1044)
  ret { %EffectRequirement*, i64 }* %t1045
merge29:
  %t1046 = extractvalue %Statement %statement, 0
  %t1047 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1048 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1049 = icmp eq i32 %t1046, 0
  %t1050 = select i1 %t1049, i8* %t1048, i8* %t1047
  %t1051 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1052 = icmp eq i32 %t1046, 1
  %t1053 = select i1 %t1052, i8* %t1051, i8* %t1050
  %t1054 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1055 = icmp eq i32 %t1046, 2
  %t1056 = select i1 %t1055, i8* %t1054, i8* %t1053
  %t1057 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1058 = icmp eq i32 %t1046, 3
  %t1059 = select i1 %t1058, i8* %t1057, i8* %t1056
  %t1060 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1061 = icmp eq i32 %t1046, 4
  %t1062 = select i1 %t1061, i8* %t1060, i8* %t1059
  %t1063 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1064 = icmp eq i32 %t1046, 5
  %t1065 = select i1 %t1064, i8* %t1063, i8* %t1062
  %t1066 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1067 = icmp eq i32 %t1046, 6
  %t1068 = select i1 %t1067, i8* %t1066, i8* %t1065
  %t1069 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1070 = icmp eq i32 %t1046, 7
  %t1071 = select i1 %t1070, i8* %t1069, i8* %t1068
  %t1072 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1073 = icmp eq i32 %t1046, 8
  %t1074 = select i1 %t1073, i8* %t1072, i8* %t1071
  %t1075 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1076 = icmp eq i32 %t1046, 9
  %t1077 = select i1 %t1076, i8* %t1075, i8* %t1074
  %t1078 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1079 = icmp eq i32 %t1046, 10
  %t1080 = select i1 %t1079, i8* %t1078, i8* %t1077
  %t1081 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1082 = icmp eq i32 %t1046, 11
  %t1083 = select i1 %t1082, i8* %t1081, i8* %t1080
  %t1084 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1085 = icmp eq i32 %t1046, 12
  %t1086 = select i1 %t1085, i8* %t1084, i8* %t1083
  %t1087 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1088 = icmp eq i32 %t1046, 13
  %t1089 = select i1 %t1088, i8* %t1087, i8* %t1086
  %t1090 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1091 = icmp eq i32 %t1046, 14
  %t1092 = select i1 %t1091, i8* %t1090, i8* %t1089
  %t1093 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1094 = icmp eq i32 %t1046, 15
  %t1095 = select i1 %t1094, i8* %t1093, i8* %t1092
  %t1096 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1097 = icmp eq i32 %t1046, 16
  %t1098 = select i1 %t1097, i8* %t1096, i8* %t1095
  %t1099 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1100 = icmp eq i32 %t1046, 17
  %t1101 = select i1 %t1100, i8* %t1099, i8* %t1098
  %t1102 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1103 = icmp eq i32 %t1046, 18
  %t1104 = select i1 %t1103, i8* %t1102, i8* %t1101
  %t1105 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1106 = icmp eq i32 %t1046, 19
  %t1107 = select i1 %t1106, i8* %t1105, i8* %t1104
  %t1108 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1109 = icmp eq i32 %t1046, 20
  %t1110 = select i1 %t1109, i8* %t1108, i8* %t1107
  %t1111 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1112 = icmp eq i32 %t1046, 21
  %t1113 = select i1 %t1112, i8* %t1111, i8* %t1110
  %t1114 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1115 = icmp eq i32 %t1046, 22
  %t1116 = select i1 %t1115, i8* %t1114, i8* %t1113
  %s1117 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1204027478, i32 0, i32 0
  %t1118 = icmp eq i8* %t1116, %s1117
  br i1 %t1118, label %then30, label %merge31
then30:
  %t1119 = extractvalue %Statement %statement, 0
  %t1120 = alloca %Statement
  store %Statement %statement, %Statement* %t1120
  %t1121 = getelementptr inbounds %Statement, %Statement* %t1120, i32 0, i32 1
  %t1122 = bitcast [48 x i8]* %t1121 to i8*
  %t1123 = getelementptr inbounds i8, i8* %t1122, i64 24
  %t1124 = bitcast i8* %t1123 to %Expression**
  %t1125 = load %Expression*, %Expression** %t1124
  %t1126 = icmp eq i32 %t1119, 2
  %t1127 = select i1 %t1126, %Expression* %t1125, %Expression* null
  %t1128 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1127)
  ret { %EffectRequirement*, i64 }* %t1128
merge31:
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
  %t1191 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1192 = icmp eq i32 %t1129, 20
  %t1193 = select i1 %t1192, i8* %t1191, i8* %t1190
  %t1194 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1195 = icmp eq i32 %t1129, 21
  %t1196 = select i1 %t1195, i8* %t1194, i8* %t1193
  %t1197 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1198 = icmp eq i32 %t1129, 22
  %t1199 = select i1 %t1198, i8* %t1197, i8* %t1196
  %s1200 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h486335986, i32 0, i32 0
  %t1201 = icmp eq i8* %t1199, %s1200
  br i1 %t1201, label %then32, label %merge33
then32:
  %t1202 = extractvalue %Statement %statement, 0
  %t1203 = alloca %Statement
  store %Statement %statement, %Statement* %t1203
  %t1204 = getelementptr inbounds %Statement, %Statement* %t1203, i32 0, i32 1
  %t1205 = bitcast [24 x i8]* %t1204 to i8*
  %t1206 = getelementptr inbounds i8, i8* %t1205, i64 8
  %t1207 = bitcast i8* %t1206 to %Block*
  %t1208 = load %Block, %Block* %t1207
  %t1209 = icmp eq i32 %t1202, 4
  %t1210 = select i1 %t1209, %Block %t1208, %Block zeroinitializer
  %t1211 = getelementptr inbounds %Statement, %Statement* %t1203, i32 0, i32 1
  %t1212 = bitcast [24 x i8]* %t1211 to i8*
  %t1213 = getelementptr inbounds i8, i8* %t1212, i64 8
  %t1214 = bitcast i8* %t1213 to %Block*
  %t1215 = load %Block, %Block* %t1214
  %t1216 = icmp eq i32 %t1202, 5
  %t1217 = select i1 %t1216, %Block %t1215, %Block %t1210
  %t1218 = getelementptr inbounds %Statement, %Statement* %t1203, i32 0, i32 1
  %t1219 = bitcast [40 x i8]* %t1218 to i8*
  %t1220 = getelementptr inbounds i8, i8* %t1219, i64 16
  %t1221 = bitcast i8* %t1220 to %Block*
  %t1222 = load %Block, %Block* %t1221
  %t1223 = icmp eq i32 %t1202, 6
  %t1224 = select i1 %t1223, %Block %t1222, %Block %t1217
  %t1225 = getelementptr inbounds %Statement, %Statement* %t1203, i32 0, i32 1
  %t1226 = bitcast [24 x i8]* %t1225 to i8*
  %t1227 = getelementptr inbounds i8, i8* %t1226, i64 8
  %t1228 = bitcast i8* %t1227 to %Block*
  %t1229 = load %Block, %Block* %t1228
  %t1230 = icmp eq i32 %t1202, 7
  %t1231 = select i1 %t1230, %Block %t1229, %Block %t1224
  %t1232 = getelementptr inbounds %Statement, %Statement* %t1203, i32 0, i32 1
  %t1233 = bitcast [40 x i8]* %t1232 to i8*
  %t1234 = getelementptr inbounds i8, i8* %t1233, i64 24
  %t1235 = bitcast i8* %t1234 to %Block*
  %t1236 = load %Block, %Block* %t1235
  %t1237 = icmp eq i32 %t1202, 12
  %t1238 = select i1 %t1237, %Block %t1236, %Block %t1231
  %t1239 = getelementptr inbounds %Statement, %Statement* %t1203, i32 0, i32 1
  %t1240 = bitcast [24 x i8]* %t1239 to i8*
  %t1241 = getelementptr inbounds i8, i8* %t1240, i64 8
  %t1242 = bitcast i8* %t1241 to %Block*
  %t1243 = load %Block, %Block* %t1242
  %t1244 = icmp eq i32 %t1202, 13
  %t1245 = select i1 %t1244, %Block %t1243, %Block %t1238
  %t1246 = getelementptr inbounds %Statement, %Statement* %t1203, i32 0, i32 1
  %t1247 = bitcast [24 x i8]* %t1246 to i8*
  %t1248 = getelementptr inbounds i8, i8* %t1247, i64 8
  %t1249 = bitcast i8* %t1248 to %Block*
  %t1250 = load %Block, %Block* %t1249
  %t1251 = icmp eq i32 %t1202, 14
  %t1252 = select i1 %t1251, %Block %t1250, %Block %t1245
  %t1253 = getelementptr inbounds %Statement, %Statement* %t1203, i32 0, i32 1
  %t1254 = bitcast [16 x i8]* %t1253 to i8*
  %t1255 = bitcast i8* %t1254 to %Block*
  %t1256 = load %Block, %Block* %t1255
  %t1257 = icmp eq i32 %t1202, 15
  %t1258 = select i1 %t1257, %Block %t1256, %Block %t1252
  %t1259 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1258)
  ret { %EffectRequirement*, i64 }* %t1259
merge33:
  %t1260 = extractvalue %Statement %statement, 0
  %t1261 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1262 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1263 = icmp eq i32 %t1260, 0
  %t1264 = select i1 %t1263, i8* %t1262, i8* %t1261
  %t1265 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1266 = icmp eq i32 %t1260, 1
  %t1267 = select i1 %t1266, i8* %t1265, i8* %t1264
  %t1268 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1269 = icmp eq i32 %t1260, 2
  %t1270 = select i1 %t1269, i8* %t1268, i8* %t1267
  %t1271 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1272 = icmp eq i32 %t1260, 3
  %t1273 = select i1 %t1272, i8* %t1271, i8* %t1270
  %t1274 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1275 = icmp eq i32 %t1260, 4
  %t1276 = select i1 %t1275, i8* %t1274, i8* %t1273
  %t1277 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1278 = icmp eq i32 %t1260, 5
  %t1279 = select i1 %t1278, i8* %t1277, i8* %t1276
  %t1280 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1281 = icmp eq i32 %t1260, 6
  %t1282 = select i1 %t1281, i8* %t1280, i8* %t1279
  %t1283 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1284 = icmp eq i32 %t1260, 7
  %t1285 = select i1 %t1284, i8* %t1283, i8* %t1282
  %t1286 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1287 = icmp eq i32 %t1260, 8
  %t1288 = select i1 %t1287, i8* %t1286, i8* %t1285
  %t1289 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1290 = icmp eq i32 %t1260, 9
  %t1291 = select i1 %t1290, i8* %t1289, i8* %t1288
  %t1292 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1293 = icmp eq i32 %t1260, 10
  %t1294 = select i1 %t1293, i8* %t1292, i8* %t1291
  %t1295 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1296 = icmp eq i32 %t1260, 11
  %t1297 = select i1 %t1296, i8* %t1295, i8* %t1294
  %t1298 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1299 = icmp eq i32 %t1260, 12
  %t1300 = select i1 %t1299, i8* %t1298, i8* %t1297
  %t1301 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1302 = icmp eq i32 %t1260, 13
  %t1303 = select i1 %t1302, i8* %t1301, i8* %t1300
  %t1304 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1305 = icmp eq i32 %t1260, 14
  %t1306 = select i1 %t1305, i8* %t1304, i8* %t1303
  %t1307 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1308 = icmp eq i32 %t1260, 15
  %t1309 = select i1 %t1308, i8* %t1307, i8* %t1306
  %t1310 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1311 = icmp eq i32 %t1260, 16
  %t1312 = select i1 %t1311, i8* %t1310, i8* %t1309
  %t1313 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1314 = icmp eq i32 %t1260, 17
  %t1315 = select i1 %t1314, i8* %t1313, i8* %t1312
  %t1316 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1317 = icmp eq i32 %t1260, 18
  %t1318 = select i1 %t1317, i8* %t1316, i8* %t1315
  %t1319 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1320 = icmp eq i32 %t1260, 19
  %t1321 = select i1 %t1320, i8* %t1319, i8* %t1318
  %t1322 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1323 = icmp eq i32 %t1260, 20
  %t1324 = select i1 %t1323, i8* %t1322, i8* %t1321
  %t1325 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1326 = icmp eq i32 %t1260, 21
  %t1327 = select i1 %t1326, i8* %t1325, i8* %t1324
  %t1328 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1329 = icmp eq i32 %t1260, 22
  %t1330 = select i1 %t1329, i8* %t1328, i8* %t1327
  %s1331 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h479148896, i32 0, i32 0
  %t1332 = icmp eq i8* %t1330, %s1331
  br i1 %t1332, label %then34, label %merge35
then34:
  %t1333 = extractvalue %Statement %statement, 0
  %t1334 = alloca %Statement
  store %Statement %statement, %Statement* %t1334
  %t1335 = getelementptr inbounds %Statement, %Statement* %t1334, i32 0, i32 1
  %t1336 = bitcast [24 x i8]* %t1335 to i8*
  %t1337 = getelementptr inbounds i8, i8* %t1336, i64 8
  %t1338 = bitcast i8* %t1337 to %Block*
  %t1339 = load %Block, %Block* %t1338
  %t1340 = icmp eq i32 %t1333, 4
  %t1341 = select i1 %t1340, %Block %t1339, %Block zeroinitializer
  %t1342 = getelementptr inbounds %Statement, %Statement* %t1334, i32 0, i32 1
  %t1343 = bitcast [24 x i8]* %t1342 to i8*
  %t1344 = getelementptr inbounds i8, i8* %t1343, i64 8
  %t1345 = bitcast i8* %t1344 to %Block*
  %t1346 = load %Block, %Block* %t1345
  %t1347 = icmp eq i32 %t1333, 5
  %t1348 = select i1 %t1347, %Block %t1346, %Block %t1341
  %t1349 = getelementptr inbounds %Statement, %Statement* %t1334, i32 0, i32 1
  %t1350 = bitcast [40 x i8]* %t1349 to i8*
  %t1351 = getelementptr inbounds i8, i8* %t1350, i64 16
  %t1352 = bitcast i8* %t1351 to %Block*
  %t1353 = load %Block, %Block* %t1352
  %t1354 = icmp eq i32 %t1333, 6
  %t1355 = select i1 %t1354, %Block %t1353, %Block %t1348
  %t1356 = getelementptr inbounds %Statement, %Statement* %t1334, i32 0, i32 1
  %t1357 = bitcast [24 x i8]* %t1356 to i8*
  %t1358 = getelementptr inbounds i8, i8* %t1357, i64 8
  %t1359 = bitcast i8* %t1358 to %Block*
  %t1360 = load %Block, %Block* %t1359
  %t1361 = icmp eq i32 %t1333, 7
  %t1362 = select i1 %t1361, %Block %t1360, %Block %t1355
  %t1363 = getelementptr inbounds %Statement, %Statement* %t1334, i32 0, i32 1
  %t1364 = bitcast [40 x i8]* %t1363 to i8*
  %t1365 = getelementptr inbounds i8, i8* %t1364, i64 24
  %t1366 = bitcast i8* %t1365 to %Block*
  %t1367 = load %Block, %Block* %t1366
  %t1368 = icmp eq i32 %t1333, 12
  %t1369 = select i1 %t1368, %Block %t1367, %Block %t1362
  %t1370 = getelementptr inbounds %Statement, %Statement* %t1334, i32 0, i32 1
  %t1371 = bitcast [24 x i8]* %t1370 to i8*
  %t1372 = getelementptr inbounds i8, i8* %t1371, i64 8
  %t1373 = bitcast i8* %t1372 to %Block*
  %t1374 = load %Block, %Block* %t1373
  %t1375 = icmp eq i32 %t1333, 13
  %t1376 = select i1 %t1375, %Block %t1374, %Block %t1369
  %t1377 = getelementptr inbounds %Statement, %Statement* %t1334, i32 0, i32 1
  %t1378 = bitcast [24 x i8]* %t1377 to i8*
  %t1379 = getelementptr inbounds i8, i8* %t1378, i64 8
  %t1380 = bitcast i8* %t1379 to %Block*
  %t1381 = load %Block, %Block* %t1380
  %t1382 = icmp eq i32 %t1333, 14
  %t1383 = select i1 %t1382, %Block %t1381, %Block %t1376
  %t1384 = getelementptr inbounds %Statement, %Statement* %t1334, i32 0, i32 1
  %t1385 = bitcast [16 x i8]* %t1384 to i8*
  %t1386 = bitcast i8* %t1385 to %Block*
  %t1387 = load %Block, %Block* %t1386
  %t1388 = icmp eq i32 %t1333, 15
  %t1389 = select i1 %t1388, %Block %t1387, %Block %t1383
  %t1390 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1389)
  ret { %EffectRequirement*, i64 }* %t1390
merge35:
  %t1391 = extractvalue %Statement %statement, 0
  %t1392 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1393 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1394 = icmp eq i32 %t1391, 0
  %t1395 = select i1 %t1394, i8* %t1393, i8* %t1392
  %t1396 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1397 = icmp eq i32 %t1391, 1
  %t1398 = select i1 %t1397, i8* %t1396, i8* %t1395
  %t1399 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1400 = icmp eq i32 %t1391, 2
  %t1401 = select i1 %t1400, i8* %t1399, i8* %t1398
  %t1402 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1403 = icmp eq i32 %t1391, 3
  %t1404 = select i1 %t1403, i8* %t1402, i8* %t1401
  %t1405 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1406 = icmp eq i32 %t1391, 4
  %t1407 = select i1 %t1406, i8* %t1405, i8* %t1404
  %t1408 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1409 = icmp eq i32 %t1391, 5
  %t1410 = select i1 %t1409, i8* %t1408, i8* %t1407
  %t1411 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1412 = icmp eq i32 %t1391, 6
  %t1413 = select i1 %t1412, i8* %t1411, i8* %t1410
  %t1414 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1415 = icmp eq i32 %t1391, 7
  %t1416 = select i1 %t1415, i8* %t1414, i8* %t1413
  %t1417 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1418 = icmp eq i32 %t1391, 8
  %t1419 = select i1 %t1418, i8* %t1417, i8* %t1416
  %t1420 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1421 = icmp eq i32 %t1391, 9
  %t1422 = select i1 %t1421, i8* %t1420, i8* %t1419
  %t1423 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1424 = icmp eq i32 %t1391, 10
  %t1425 = select i1 %t1424, i8* %t1423, i8* %t1422
  %t1426 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1427 = icmp eq i32 %t1391, 11
  %t1428 = select i1 %t1427, i8* %t1426, i8* %t1425
  %t1429 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1430 = icmp eq i32 %t1391, 12
  %t1431 = select i1 %t1430, i8* %t1429, i8* %t1428
  %t1432 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1433 = icmp eq i32 %t1391, 13
  %t1434 = select i1 %t1433, i8* %t1432, i8* %t1431
  %t1435 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1436 = icmp eq i32 %t1391, 14
  %t1437 = select i1 %t1436, i8* %t1435, i8* %t1434
  %t1438 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1439 = icmp eq i32 %t1391, 15
  %t1440 = select i1 %t1439, i8* %t1438, i8* %t1437
  %t1441 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1442 = icmp eq i32 %t1391, 16
  %t1443 = select i1 %t1442, i8* %t1441, i8* %t1440
  %t1444 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1445 = icmp eq i32 %t1391, 17
  %t1446 = select i1 %t1445, i8* %t1444, i8* %t1443
  %t1447 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1448 = icmp eq i32 %t1391, 18
  %t1449 = select i1 %t1448, i8* %t1447, i8* %t1446
  %t1450 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1451 = icmp eq i32 %t1391, 19
  %t1452 = select i1 %t1451, i8* %t1450, i8* %t1449
  %t1453 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1454 = icmp eq i32 %t1391, 20
  %t1455 = select i1 %t1454, i8* %t1453, i8* %t1452
  %t1456 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1457 = icmp eq i32 %t1391, 21
  %t1458 = select i1 %t1457, i8* %t1456, i8* %t1455
  %t1459 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1460 = icmp eq i32 %t1391, 22
  %t1461 = select i1 %t1460, i8* %t1459, i8* %t1458
  %s1462 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h571715647, i32 0, i32 0
  %t1463 = icmp eq i8* %t1461, %s1462
  br i1 %t1463, label %then36, label %merge37
then36:
  %t1464 = extractvalue %Statement %statement, 0
  %t1465 = alloca %Statement
  store %Statement %statement, %Statement* %t1465
  %t1466 = getelementptr inbounds %Statement, %Statement* %t1465, i32 0, i32 1
  %t1467 = bitcast [24 x i8]* %t1466 to i8*
  %t1468 = getelementptr inbounds i8, i8* %t1467, i64 8
  %t1469 = bitcast i8* %t1468 to %Block*
  %t1470 = load %Block, %Block* %t1469
  %t1471 = icmp eq i32 %t1464, 4
  %t1472 = select i1 %t1471, %Block %t1470, %Block zeroinitializer
  %t1473 = getelementptr inbounds %Statement, %Statement* %t1465, i32 0, i32 1
  %t1474 = bitcast [24 x i8]* %t1473 to i8*
  %t1475 = getelementptr inbounds i8, i8* %t1474, i64 8
  %t1476 = bitcast i8* %t1475 to %Block*
  %t1477 = load %Block, %Block* %t1476
  %t1478 = icmp eq i32 %t1464, 5
  %t1479 = select i1 %t1478, %Block %t1477, %Block %t1472
  %t1480 = getelementptr inbounds %Statement, %Statement* %t1465, i32 0, i32 1
  %t1481 = bitcast [40 x i8]* %t1480 to i8*
  %t1482 = getelementptr inbounds i8, i8* %t1481, i64 16
  %t1483 = bitcast i8* %t1482 to %Block*
  %t1484 = load %Block, %Block* %t1483
  %t1485 = icmp eq i32 %t1464, 6
  %t1486 = select i1 %t1485, %Block %t1484, %Block %t1479
  %t1487 = getelementptr inbounds %Statement, %Statement* %t1465, i32 0, i32 1
  %t1488 = bitcast [24 x i8]* %t1487 to i8*
  %t1489 = getelementptr inbounds i8, i8* %t1488, i64 8
  %t1490 = bitcast i8* %t1489 to %Block*
  %t1491 = load %Block, %Block* %t1490
  %t1492 = icmp eq i32 %t1464, 7
  %t1493 = select i1 %t1492, %Block %t1491, %Block %t1486
  %t1494 = getelementptr inbounds %Statement, %Statement* %t1465, i32 0, i32 1
  %t1495 = bitcast [40 x i8]* %t1494 to i8*
  %t1496 = getelementptr inbounds i8, i8* %t1495, i64 24
  %t1497 = bitcast i8* %t1496 to %Block*
  %t1498 = load %Block, %Block* %t1497
  %t1499 = icmp eq i32 %t1464, 12
  %t1500 = select i1 %t1499, %Block %t1498, %Block %t1493
  %t1501 = getelementptr inbounds %Statement, %Statement* %t1465, i32 0, i32 1
  %t1502 = bitcast [24 x i8]* %t1501 to i8*
  %t1503 = getelementptr inbounds i8, i8* %t1502, i64 8
  %t1504 = bitcast i8* %t1503 to %Block*
  %t1505 = load %Block, %Block* %t1504
  %t1506 = icmp eq i32 %t1464, 13
  %t1507 = select i1 %t1506, %Block %t1505, %Block %t1500
  %t1508 = getelementptr inbounds %Statement, %Statement* %t1465, i32 0, i32 1
  %t1509 = bitcast [24 x i8]* %t1508 to i8*
  %t1510 = getelementptr inbounds i8, i8* %t1509, i64 8
  %t1511 = bitcast i8* %t1510 to %Block*
  %t1512 = load %Block, %Block* %t1511
  %t1513 = icmp eq i32 %t1464, 14
  %t1514 = select i1 %t1513, %Block %t1512, %Block %t1507
  %t1515 = getelementptr inbounds %Statement, %Statement* %t1465, i32 0, i32 1
  %t1516 = bitcast [16 x i8]* %t1515 to i8*
  %t1517 = bitcast i8* %t1516 to %Block*
  %t1518 = load %Block, %Block* %t1517
  %t1519 = icmp eq i32 %t1464, 15
  %t1520 = select i1 %t1519, %Block %t1518, %Block %t1514
  %t1521 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1520)
  ret { %EffectRequirement*, i64 }* %t1521
merge37:
  %t1522 = extractvalue %Statement %statement, 0
  %t1523 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1524 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1525 = icmp eq i32 %t1522, 0
  %t1526 = select i1 %t1525, i8* %t1524, i8* %t1523
  %t1527 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1528 = icmp eq i32 %t1522, 1
  %t1529 = select i1 %t1528, i8* %t1527, i8* %t1526
  %t1530 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1531 = icmp eq i32 %t1522, 2
  %t1532 = select i1 %t1531, i8* %t1530, i8* %t1529
  %t1533 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1534 = icmp eq i32 %t1522, 3
  %t1535 = select i1 %t1534, i8* %t1533, i8* %t1532
  %t1536 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1537 = icmp eq i32 %t1522, 4
  %t1538 = select i1 %t1537, i8* %t1536, i8* %t1535
  %t1539 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1540 = icmp eq i32 %t1522, 5
  %t1541 = select i1 %t1540, i8* %t1539, i8* %t1538
  %t1542 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1543 = icmp eq i32 %t1522, 6
  %t1544 = select i1 %t1543, i8* %t1542, i8* %t1541
  %t1545 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1546 = icmp eq i32 %t1522, 7
  %t1547 = select i1 %t1546, i8* %t1545, i8* %t1544
  %t1548 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1549 = icmp eq i32 %t1522, 8
  %t1550 = select i1 %t1549, i8* %t1548, i8* %t1547
  %t1551 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1552 = icmp eq i32 %t1522, 9
  %t1553 = select i1 %t1552, i8* %t1551, i8* %t1550
  %t1554 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1555 = icmp eq i32 %t1522, 10
  %t1556 = select i1 %t1555, i8* %t1554, i8* %t1553
  %t1557 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1558 = icmp eq i32 %t1522, 11
  %t1559 = select i1 %t1558, i8* %t1557, i8* %t1556
  %t1560 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1561 = icmp eq i32 %t1522, 12
  %t1562 = select i1 %t1561, i8* %t1560, i8* %t1559
  %t1563 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1564 = icmp eq i32 %t1522, 13
  %t1565 = select i1 %t1564, i8* %t1563, i8* %t1562
  %t1566 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1567 = icmp eq i32 %t1522, 14
  %t1568 = select i1 %t1567, i8* %t1566, i8* %t1565
  %t1569 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1570 = icmp eq i32 %t1522, 15
  %t1571 = select i1 %t1570, i8* %t1569, i8* %t1568
  %t1572 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1573 = icmp eq i32 %t1522, 16
  %t1574 = select i1 %t1573, i8* %t1572, i8* %t1571
  %t1575 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1576 = icmp eq i32 %t1522, 17
  %t1577 = select i1 %t1576, i8* %t1575, i8* %t1574
  %t1578 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1579 = icmp eq i32 %t1522, 18
  %t1580 = select i1 %t1579, i8* %t1578, i8* %t1577
  %t1581 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1582 = icmp eq i32 %t1522, 19
  %t1583 = select i1 %t1582, i8* %t1581, i8* %t1580
  %t1584 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1585 = icmp eq i32 %t1522, 20
  %t1586 = select i1 %t1585, i8* %t1584, i8* %t1583
  %t1587 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1588 = icmp eq i32 %t1522, 21
  %t1589 = select i1 %t1588, i8* %t1587, i8* %t1586
  %t1590 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1591 = icmp eq i32 %t1522, 22
  %t1592 = select i1 %t1591, i8* %t1590, i8* %t1589
  %s1593 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h889179835, i32 0, i32 0
  %t1594 = icmp eq i8* %t1592, %s1593
  br i1 %t1594, label %then38, label %merge39
then38:
  %t1595 = extractvalue %Statement %statement, 0
  %t1596 = alloca %Statement
  store %Statement %statement, %Statement* %t1596
  %t1597 = getelementptr inbounds %Statement, %Statement* %t1596, i32 0, i32 1
  %t1598 = bitcast [24 x i8]* %t1597 to i8*
  %t1599 = getelementptr inbounds i8, i8* %t1598, i64 8
  %t1600 = bitcast i8* %t1599 to %Block*
  %t1601 = load %Block, %Block* %t1600
  %t1602 = icmp eq i32 %t1595, 4
  %t1603 = select i1 %t1602, %Block %t1601, %Block zeroinitializer
  %t1604 = getelementptr inbounds %Statement, %Statement* %t1596, i32 0, i32 1
  %t1605 = bitcast [24 x i8]* %t1604 to i8*
  %t1606 = getelementptr inbounds i8, i8* %t1605, i64 8
  %t1607 = bitcast i8* %t1606 to %Block*
  %t1608 = load %Block, %Block* %t1607
  %t1609 = icmp eq i32 %t1595, 5
  %t1610 = select i1 %t1609, %Block %t1608, %Block %t1603
  %t1611 = getelementptr inbounds %Statement, %Statement* %t1596, i32 0, i32 1
  %t1612 = bitcast [40 x i8]* %t1611 to i8*
  %t1613 = getelementptr inbounds i8, i8* %t1612, i64 16
  %t1614 = bitcast i8* %t1613 to %Block*
  %t1615 = load %Block, %Block* %t1614
  %t1616 = icmp eq i32 %t1595, 6
  %t1617 = select i1 %t1616, %Block %t1615, %Block %t1610
  %t1618 = getelementptr inbounds %Statement, %Statement* %t1596, i32 0, i32 1
  %t1619 = bitcast [24 x i8]* %t1618 to i8*
  %t1620 = getelementptr inbounds i8, i8* %t1619, i64 8
  %t1621 = bitcast i8* %t1620 to %Block*
  %t1622 = load %Block, %Block* %t1621
  %t1623 = icmp eq i32 %t1595, 7
  %t1624 = select i1 %t1623, %Block %t1622, %Block %t1617
  %t1625 = getelementptr inbounds %Statement, %Statement* %t1596, i32 0, i32 1
  %t1626 = bitcast [40 x i8]* %t1625 to i8*
  %t1627 = getelementptr inbounds i8, i8* %t1626, i64 24
  %t1628 = bitcast i8* %t1627 to %Block*
  %t1629 = load %Block, %Block* %t1628
  %t1630 = icmp eq i32 %t1595, 12
  %t1631 = select i1 %t1630, %Block %t1629, %Block %t1624
  %t1632 = getelementptr inbounds %Statement, %Statement* %t1596, i32 0, i32 1
  %t1633 = bitcast [24 x i8]* %t1632 to i8*
  %t1634 = getelementptr inbounds i8, i8* %t1633, i64 8
  %t1635 = bitcast i8* %t1634 to %Block*
  %t1636 = load %Block, %Block* %t1635
  %t1637 = icmp eq i32 %t1595, 13
  %t1638 = select i1 %t1637, %Block %t1636, %Block %t1631
  %t1639 = getelementptr inbounds %Statement, %Statement* %t1596, i32 0, i32 1
  %t1640 = bitcast [24 x i8]* %t1639 to i8*
  %t1641 = getelementptr inbounds i8, i8* %t1640, i64 8
  %t1642 = bitcast i8* %t1641 to %Block*
  %t1643 = load %Block, %Block* %t1642
  %t1644 = icmp eq i32 %t1595, 14
  %t1645 = select i1 %t1644, %Block %t1643, %Block %t1638
  %t1646 = getelementptr inbounds %Statement, %Statement* %t1596, i32 0, i32 1
  %t1647 = bitcast [16 x i8]* %t1646 to i8*
  %t1648 = bitcast i8* %t1647 to %Block*
  %t1649 = load %Block, %Block* %t1648
  %t1650 = icmp eq i32 %t1595, 15
  %t1651 = select i1 %t1650, %Block %t1649, %Block %t1645
  %t1652 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1651)
  ret { %EffectRequirement*, i64 }* %t1652
merge39:
  %t1653 = extractvalue %Statement %statement, 0
  %t1654 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1655 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1656 = icmp eq i32 %t1653, 0
  %t1657 = select i1 %t1656, i8* %t1655, i8* %t1654
  %t1658 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1659 = icmp eq i32 %t1653, 1
  %t1660 = select i1 %t1659, i8* %t1658, i8* %t1657
  %t1661 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1662 = icmp eq i32 %t1653, 2
  %t1663 = select i1 %t1662, i8* %t1661, i8* %t1660
  %t1664 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1665 = icmp eq i32 %t1653, 3
  %t1666 = select i1 %t1665, i8* %t1664, i8* %t1663
  %t1667 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1668 = icmp eq i32 %t1653, 4
  %t1669 = select i1 %t1668, i8* %t1667, i8* %t1666
  %t1670 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1671 = icmp eq i32 %t1653, 5
  %t1672 = select i1 %t1671, i8* %t1670, i8* %t1669
  %t1673 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1674 = icmp eq i32 %t1653, 6
  %t1675 = select i1 %t1674, i8* %t1673, i8* %t1672
  %t1676 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1677 = icmp eq i32 %t1653, 7
  %t1678 = select i1 %t1677, i8* %t1676, i8* %t1675
  %t1679 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1680 = icmp eq i32 %t1653, 8
  %t1681 = select i1 %t1680, i8* %t1679, i8* %t1678
  %t1682 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1683 = icmp eq i32 %t1653, 9
  %t1684 = select i1 %t1683, i8* %t1682, i8* %t1681
  %t1685 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1686 = icmp eq i32 %t1653, 10
  %t1687 = select i1 %t1686, i8* %t1685, i8* %t1684
  %t1688 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1689 = icmp eq i32 %t1653, 11
  %t1690 = select i1 %t1689, i8* %t1688, i8* %t1687
  %t1691 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1692 = icmp eq i32 %t1653, 12
  %t1693 = select i1 %t1692, i8* %t1691, i8* %t1690
  %t1694 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1695 = icmp eq i32 %t1653, 13
  %t1696 = select i1 %t1695, i8* %t1694, i8* %t1693
  %t1697 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1698 = icmp eq i32 %t1653, 14
  %t1699 = select i1 %t1698, i8* %t1697, i8* %t1696
  %t1700 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1701 = icmp eq i32 %t1653, 15
  %t1702 = select i1 %t1701, i8* %t1700, i8* %t1699
  %t1703 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1704 = icmp eq i32 %t1653, 16
  %t1705 = select i1 %t1704, i8* %t1703, i8* %t1702
  %t1706 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1707 = icmp eq i32 %t1653, 17
  %t1708 = select i1 %t1707, i8* %t1706, i8* %t1705
  %t1709 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1710 = icmp eq i32 %t1653, 18
  %t1711 = select i1 %t1710, i8* %t1709, i8* %t1708
  %t1712 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1713 = icmp eq i32 %t1653, 19
  %t1714 = select i1 %t1713, i8* %t1712, i8* %t1711
  %t1715 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1716 = icmp eq i32 %t1653, 20
  %t1717 = select i1 %t1716, i8* %t1715, i8* %t1714
  %t1718 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1719 = icmp eq i32 %t1653, 21
  %t1720 = select i1 %t1719, i8* %t1718, i8* %t1717
  %t1721 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1722 = icmp eq i32 %t1653, 22
  %t1723 = select i1 %t1722, i8* %t1721, i8* %t1720
  %s1724 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1842783069, i32 0, i32 0
  %t1725 = icmp eq i8* %t1723, %s1724
  br i1 %t1725, label %then40, label %merge41
then40:
  %t1726 = alloca [0 x %EffectRequirement]
  %t1727 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1726, i32 0, i32 0
  %t1728 = alloca { %EffectRequirement*, i64 }
  %t1729 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1728, i32 0, i32 0
  store %EffectRequirement* %t1727, %EffectRequirement** %t1729
  %t1730 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1728, i32 0, i32 1
  store i64 0, i64* %t1730
  store { %EffectRequirement*, i64 }* %t1728, { %EffectRequirement*, i64 }** %l9
  %t1731 = sitofp i64 0 to double
  store double %t1731, double* %l10
  %t1732 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1733 = load double, double* %l10
  br label %loop.header42
loop.header42:
  %t1777 = phi { %EffectRequirement*, i64 }* [ %t1732, %then40 ], [ %t1775, %loop.latch44 ]
  %t1778 = phi double [ %t1733, %then40 ], [ %t1776, %loop.latch44 ]
  store { %EffectRequirement*, i64 }* %t1777, { %EffectRequirement*, i64 }** %l9
  store double %t1778, double* %l10
  br label %loop.body43
loop.body43:
  %t1734 = load double, double* %l10
  %t1735 = extractvalue %Statement %statement, 0
  %t1736 = alloca %Statement
  store %Statement %statement, %Statement* %t1736
  %t1737 = getelementptr inbounds %Statement, %Statement* %t1736, i32 0, i32 1
  %t1738 = bitcast [56 x i8]* %t1737 to i8*
  %t1739 = getelementptr inbounds i8, i8* %t1738, i64 40
  %t1740 = bitcast i8* %t1739 to { %MethodDeclaration**, i64 }**
  %t1741 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1740
  %t1742 = icmp eq i32 %t1735, 8
  %t1743 = select i1 %t1742, { %MethodDeclaration**, i64 }* %t1741, { %MethodDeclaration**, i64 }* null
  %t1744 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1743
  %t1745 = extractvalue { %MethodDeclaration**, i64 } %t1744, 1
  %t1746 = sitofp i64 %t1745 to double
  %t1747 = fcmp oge double %t1734, %t1746
  %t1748 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1749 = load double, double* %l10
  br i1 %t1747, label %then46, label %merge47
then46:
  br label %afterloop45
merge47:
  %t1750 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1751 = extractvalue %Statement %statement, 0
  %t1752 = alloca %Statement
  store %Statement %statement, %Statement* %t1752
  %t1753 = getelementptr inbounds %Statement, %Statement* %t1752, i32 0, i32 1
  %t1754 = bitcast [56 x i8]* %t1753 to i8*
  %t1755 = getelementptr inbounds i8, i8* %t1754, i64 40
  %t1756 = bitcast i8* %t1755 to { %MethodDeclaration**, i64 }**
  %t1757 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1756
  %t1758 = icmp eq i32 %t1751, 8
  %t1759 = select i1 %t1758, { %MethodDeclaration**, i64 }* %t1757, { %MethodDeclaration**, i64 }* null
  %t1760 = load double, double* %l10
  %t1761 = fptosi double %t1760 to i64
  %t1762 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1759
  %t1763 = extractvalue { %MethodDeclaration**, i64 } %t1762, 0
  %t1764 = extractvalue { %MethodDeclaration**, i64 } %t1762, 1
  %t1765 = icmp uge i64 %t1761, %t1764
  ; bounds check: %t1765 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1761, i64 %t1764)
  %t1766 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t1763, i64 %t1761
  %t1767 = load %MethodDeclaration*, %MethodDeclaration** %t1766
  %t1768 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1767, i32 0, i32 1
  %t1769 = load %Block, %Block* %t1768
  %t1770 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1769)
  %t1771 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1750, { %EffectRequirement*, i64 }* %t1770)
  store { %EffectRequirement*, i64 }* %t1771, { %EffectRequirement*, i64 }** %l9
  %t1772 = load double, double* %l10
  %t1773 = sitofp i64 1 to double
  %t1774 = fadd double %t1772, %t1773
  store double %t1774, double* %l10
  br label %loop.latch44
loop.latch44:
  %t1775 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1776 = load double, double* %l10
  br label %loop.header42
afterloop45:
  %t1779 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1780 = load double, double* %l10
  %t1781 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  ret { %EffectRequirement*, i64 }* %t1781
merge41:
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
  %s1853 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h2043328844, i32 0, i32 0
  %t1854 = icmp eq i8* %t1852, %s1853
  br i1 %t1854, label %then48, label %merge49
then48:
  %t1855 = alloca [0 x %EffectRequirement]
  %t1856 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1855, i32 0, i32 0
  %t1857 = alloca { %EffectRequirement*, i64 }
  %t1858 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1857, i32 0, i32 0
  store %EffectRequirement* %t1856, %EffectRequirement** %t1858
  %t1859 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1857, i32 0, i32 1
  store i64 0, i64* %t1859
  store { %EffectRequirement*, i64 }* %t1857, { %EffectRequirement*, i64 }** %l11
  %t1860 = sitofp i64 0 to double
  store double %t1860, double* %l12
  %t1861 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1862 = load double, double* %l12
  br label %loop.header50
loop.header50:
  %t1907 = phi { %EffectRequirement*, i64 }* [ %t1861, %then48 ], [ %t1905, %loop.latch52 ]
  %t1908 = phi double [ %t1862, %then48 ], [ %t1906, %loop.latch52 ]
  store { %EffectRequirement*, i64 }* %t1907, { %EffectRequirement*, i64 }** %l11
  store double %t1908, double* %l12
  br label %loop.body51
loop.body51:
  %t1863 = load double, double* %l12
  %t1864 = extractvalue %Statement %statement, 0
  %t1865 = alloca %Statement
  store %Statement %statement, %Statement* %t1865
  %t1866 = getelementptr inbounds %Statement, %Statement* %t1865, i32 0, i32 1
  %t1867 = bitcast [48 x i8]* %t1866 to i8*
  %t1868 = getelementptr inbounds i8, i8* %t1867, i64 24
  %t1869 = bitcast i8* %t1868 to { %ModelProperty**, i64 }**
  %t1870 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1869
  %t1871 = icmp eq i32 %t1864, 3
  %t1872 = select i1 %t1871, { %ModelProperty**, i64 }* %t1870, { %ModelProperty**, i64 }* null
  %t1873 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t1872
  %t1874 = extractvalue { %ModelProperty**, i64 } %t1873, 1
  %t1875 = sitofp i64 %t1874 to double
  %t1876 = fcmp oge double %t1863, %t1875
  %t1877 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1878 = load double, double* %l12
  br i1 %t1876, label %then54, label %merge55
then54:
  br label %afterloop53
merge55:
  %t1879 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1880 = extractvalue %Statement %statement, 0
  %t1881 = alloca %Statement
  store %Statement %statement, %Statement* %t1881
  %t1882 = getelementptr inbounds %Statement, %Statement* %t1881, i32 0, i32 1
  %t1883 = bitcast [48 x i8]* %t1882 to i8*
  %t1884 = getelementptr inbounds i8, i8* %t1883, i64 24
  %t1885 = bitcast i8* %t1884 to { %ModelProperty**, i64 }**
  %t1886 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1885
  %t1887 = icmp eq i32 %t1880, 3
  %t1888 = select i1 %t1887, { %ModelProperty**, i64 }* %t1886, { %ModelProperty**, i64 }* null
  %t1889 = load double, double* %l12
  %t1890 = fptosi double %t1889 to i64
  %t1891 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t1888
  %t1892 = extractvalue { %ModelProperty**, i64 } %t1891, 0
  %t1893 = extractvalue { %ModelProperty**, i64 } %t1891, 1
  %t1894 = icmp uge i64 %t1890, %t1893
  ; bounds check: %t1894 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1890, i64 %t1893)
  %t1895 = getelementptr %ModelProperty*, %ModelProperty** %t1892, i64 %t1890
  %t1896 = load %ModelProperty*, %ModelProperty** %t1895
  %t1897 = getelementptr %ModelProperty, %ModelProperty* %t1896, i32 0, i32 1
  %t1898 = load %Expression, %Expression* %t1897
  %t1899 = alloca %Expression
  store %Expression %t1898, %Expression* %t1899
  %t1900 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1899)
  %t1901 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1879, { %EffectRequirement*, i64 }* %t1900)
  store { %EffectRequirement*, i64 }* %t1901, { %EffectRequirement*, i64 }** %l11
  %t1902 = load double, double* %l12
  %t1903 = sitofp i64 1 to double
  %t1904 = fadd double %t1902, %t1903
  store double %t1904, double* %l12
  br label %loop.latch52
loop.latch52:
  %t1905 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1906 = load double, double* %l12
  br label %loop.header50
afterloop53:
  %t1909 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1910 = load double, double* %l12
  %t1911 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  ret { %EffectRequirement*, i64 }* %t1911
merge49:
  %t1912 = extractvalue %Statement %statement, 0
  %t1913 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1914 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1915 = icmp eq i32 %t1912, 0
  %t1916 = select i1 %t1915, i8* %t1914, i8* %t1913
  %t1917 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1918 = icmp eq i32 %t1912, 1
  %t1919 = select i1 %t1918, i8* %t1917, i8* %t1916
  %t1920 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1921 = icmp eq i32 %t1912, 2
  %t1922 = select i1 %t1921, i8* %t1920, i8* %t1919
  %t1923 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1924 = icmp eq i32 %t1912, 3
  %t1925 = select i1 %t1924, i8* %t1923, i8* %t1922
  %t1926 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1927 = icmp eq i32 %t1912, 4
  %t1928 = select i1 %t1927, i8* %t1926, i8* %t1925
  %t1929 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1930 = icmp eq i32 %t1912, 5
  %t1931 = select i1 %t1930, i8* %t1929, i8* %t1928
  %t1932 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1933 = icmp eq i32 %t1912, 6
  %t1934 = select i1 %t1933, i8* %t1932, i8* %t1931
  %t1935 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1936 = icmp eq i32 %t1912, 7
  %t1937 = select i1 %t1936, i8* %t1935, i8* %t1934
  %t1938 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1939 = icmp eq i32 %t1912, 8
  %t1940 = select i1 %t1939, i8* %t1938, i8* %t1937
  %t1941 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1942 = icmp eq i32 %t1912, 9
  %t1943 = select i1 %t1942, i8* %t1941, i8* %t1940
  %t1944 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1945 = icmp eq i32 %t1912, 10
  %t1946 = select i1 %t1945, i8* %t1944, i8* %t1943
  %t1947 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1948 = icmp eq i32 %t1912, 11
  %t1949 = select i1 %t1948, i8* %t1947, i8* %t1946
  %t1950 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1951 = icmp eq i32 %t1912, 12
  %t1952 = select i1 %t1951, i8* %t1950, i8* %t1949
  %t1953 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1954 = icmp eq i32 %t1912, 13
  %t1955 = select i1 %t1954, i8* %t1953, i8* %t1952
  %t1956 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1957 = icmp eq i32 %t1912, 14
  %t1958 = select i1 %t1957, i8* %t1956, i8* %t1955
  %t1959 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1960 = icmp eq i32 %t1912, 15
  %t1961 = select i1 %t1960, i8* %t1959, i8* %t1958
  %t1962 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1963 = icmp eq i32 %t1912, 16
  %t1964 = select i1 %t1963, i8* %t1962, i8* %t1961
  %t1965 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1966 = icmp eq i32 %t1912, 17
  %t1967 = select i1 %t1966, i8* %t1965, i8* %t1964
  %t1968 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1969 = icmp eq i32 %t1912, 18
  %t1970 = select i1 %t1969, i8* %t1968, i8* %t1967
  %t1971 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1972 = icmp eq i32 %t1912, 19
  %t1973 = select i1 %t1972, i8* %t1971, i8* %t1970
  %t1974 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1975 = icmp eq i32 %t1912, 20
  %t1976 = select i1 %t1975, i8* %t1974, i8* %t1973
  %t1977 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1978 = icmp eq i32 %t1912, 21
  %t1979 = select i1 %t1978, i8* %t1977, i8* %t1976
  %t1980 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1981 = icmp eq i32 %t1912, 22
  %t1982 = select i1 %t1981, i8* %t1980, i8* %t1979
  %s1983 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h48777630, i32 0, i32 0
  %t1984 = icmp eq i8* %t1982, %s1983
  br i1 %t1984, label %then56, label %merge57
then56:
  %t1985 = extractvalue %Statement %statement, 0
  %t1986 = alloca %Statement
  store %Statement %statement, %Statement* %t1986
  %t1987 = getelementptr inbounds %Statement, %Statement* %t1986, i32 0, i32 1
  %t1988 = bitcast [16 x i8]* %t1987 to i8*
  %t1989 = bitcast i8* %t1988 to { %Token**, i64 }**
  %t1990 = load { %Token**, i64 }*, { %Token**, i64 }** %t1989
  %t1991 = icmp eq i32 %t1985, 22
  %t1992 = select i1 %t1991, { %Token**, i64 }* %t1990, { %Token**, i64 }* null
  %t1993 = bitcast { %Token**, i64 }* %t1992 to { %Token*, i64 }*
  %t1994 = call { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* %t1993)
  ret { %EffectRequirement*, i64 }* %t1994
merge57:
  %t1995 = alloca [0 x %EffectRequirement]
  %t1996 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1995, i32 0, i32 0
  %t1997 = alloca { %EffectRequirement*, i64 }
  %t1998 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1997, i32 0, i32 0
  store %EffectRequirement* %t1996, %EffectRequirement** %t1998
  %t1999 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1997, i32 0, i32 1
  store i64 0, i64* %t1999
  ret { %EffectRequirement*, i64 }* %t1997
}

define { %EffectRequirement*, i64 }* @collect_effects_from_else_branch(%ElseBranch %branch) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %t0 = alloca [0 x %EffectRequirement]
  %t1 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t0, i32 0, i32 0
  %t2 = alloca { %EffectRequirement*, i64 }
  %t3 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t2, i32 0, i32 0
  store %EffectRequirement* %t1, %EffectRequirement** %t3
  %t4 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %EffectRequirement*, i64 }* %t2, { %EffectRequirement*, i64 }** %l0
  %t5 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t6 = extractvalue %ElseBranch %branch, 1
  %t7 = call { %EffectRequirement*, i64 }* @collect_effects_from_optional_block(%Block* %t6)
  %t8 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t5, { %EffectRequirement*, i64 }* %t7)
  store { %EffectRequirement*, i64 }* %t8, { %EffectRequirement*, i64 }** %l0
  %t9 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t10 = extractvalue %ElseBranch %branch, 0
  %t11 = call { %EffectRequirement*, i64 }* @collect_effects_from_optional_statement(%Statement* %t10)
  %t12 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t9, { %EffectRequirement*, i64 }* %t11)
  store { %EffectRequirement*, i64 }* %t12, { %EffectRequirement*, i64 }** %l0
  %t13 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t13
}

define { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase %case) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %t0 = extractvalue %MatchCase %case, 0
  %t1 = alloca %Expression
  store %Expression %t0, %Expression* %t1
  %t2 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1)
  store { %EffectRequirement*, i64 }* %t2, { %EffectRequirement*, i64 }** %l0
  %t3 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t4 = extractvalue %MatchCase %case, 1
  %t5 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t4)
  %t6 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t3, { %EffectRequirement*, i64 }* %t5)
  store { %EffectRequirement*, i64 }* %t6, { %EffectRequirement*, i64 }** %l0
  %t7 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t8 = extractvalue %MatchCase %case, 2
  %t9 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t8)
  %t10 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t7, { %EffectRequirement*, i64 }* %t9)
  store { %EffectRequirement*, i64 }* %t10, { %EffectRequirement*, i64 }** %l0
  %t11 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t11
}

define { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %expression) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %l1 = alloca double
  %l2 = alloca { %EffectRequirement*, i64 }*
  %l3 = alloca { %EffectRequirement*, i64 }*
  %l4 = alloca double
  %l5 = alloca { %EffectRequirement*, i64 }*
  %l6 = alloca double
  %l7 = alloca { %EffectRequirement*, i64 }*
  %l8 = alloca double
  %l9 = alloca { %EffectRequirement*, i64 }*
  %l10 = alloca { %EffectRequirement*, i64 }*
  %t0 = icmp eq %Expression* %expression, null
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = alloca [0 x %EffectRequirement]
  %t2 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1, i32 0, i32 0
  %t3 = alloca { %EffectRequirement*, i64 }
  %t4 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t3, i32 0, i32 0
  store %EffectRequirement* %t2, %EffectRequirement** %t4
  %t5 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  ret { %EffectRequirement*, i64 }* %t3
merge1:
  %t6 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t7 = load i32, i32* %t6
  %t8 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t9 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t10 = icmp eq i32 %t7, 0
  %t11 = select i1 %t10, i8* %t9, i8* %t8
  %t12 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t13 = icmp eq i32 %t7, 1
  %t14 = select i1 %t13, i8* %t12, i8* %t11
  %t15 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t16 = icmp eq i32 %t7, 2
  %t17 = select i1 %t16, i8* %t15, i8* %t14
  %t18 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t19 = icmp eq i32 %t7, 3
  %t20 = select i1 %t19, i8* %t18, i8* %t17
  %t21 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t22 = icmp eq i32 %t7, 4
  %t23 = select i1 %t22, i8* %t21, i8* %t20
  %t24 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t7, 5
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %t27 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t28 = icmp eq i32 %t7, 6
  %t29 = select i1 %t28, i8* %t27, i8* %t26
  %t30 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t31 = icmp eq i32 %t7, 7
  %t32 = select i1 %t31, i8* %t30, i8* %t29
  %t33 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t34 = icmp eq i32 %t7, 8
  %t35 = select i1 %t34, i8* %t33, i8* %t32
  %t36 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t37 = icmp eq i32 %t7, 9
  %t38 = select i1 %t37, i8* %t36, i8* %t35
  %t39 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t40 = icmp eq i32 %t7, 10
  %t41 = select i1 %t40, i8* %t39, i8* %t38
  %t42 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t43 = icmp eq i32 %t7, 11
  %t44 = select i1 %t43, i8* %t42, i8* %t41
  %t45 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t46 = icmp eq i32 %t7, 12
  %t47 = select i1 %t46, i8* %t45, i8* %t44
  %t48 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t49 = icmp eq i32 %t7, 13
  %t50 = select i1 %t49, i8* %t48, i8* %t47
  %t51 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t52 = icmp eq i32 %t7, 14
  %t53 = select i1 %t52, i8* %t51, i8* %t50
  %t54 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t55 = icmp eq i32 %t7, 15
  %t56 = select i1 %t55, i8* %t54, i8* %t53
  %s57 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h217216103, i32 0, i32 0
  %t58 = icmp eq i8* %t56, %s57
  br i1 %t58, label %then2, label %merge3
then2:
  %t59 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t60 = load i32, i32* %t59
  %t61 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t62 = bitcast [16 x i8]* %t61 to i8*
  %t63 = bitcast i8* %t62 to %Expression**
  %t64 = load %Expression*, %Expression** %t63
  %t65 = icmp eq i32 %t60, 8
  %t66 = select i1 %t65, %Expression* %t64, %Expression* null
  %t67 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t66)
  store { %EffectRequirement*, i64 }* %t67, { %EffectRequirement*, i64 }** %l0
  %t68 = sitofp i64 0 to double
  store double %t68, double* %l1
  %t69 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t70 = load double, double* %l1
  br label %loop.header4
loop.header4:
  %t112 = phi { %EffectRequirement*, i64 }* [ %t69, %then2 ], [ %t110, %loop.latch6 ]
  %t113 = phi double [ %t70, %then2 ], [ %t111, %loop.latch6 ]
  store { %EffectRequirement*, i64 }* %t112, { %EffectRequirement*, i64 }** %l0
  store double %t113, double* %l1
  br label %loop.body5
loop.body5:
  %t71 = load double, double* %l1
  %t72 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t73 = load i32, i32* %t72
  %t74 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t75 = bitcast [16 x i8]* %t74 to i8*
  %t76 = getelementptr inbounds i8, i8* %t75, i64 8
  %t77 = bitcast i8* %t76 to { %Expression**, i64 }**
  %t78 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t77
  %t79 = icmp eq i32 %t73, 8
  %t80 = select i1 %t79, { %Expression**, i64 }* %t78, { %Expression**, i64 }* null
  %t81 = load { %Expression**, i64 }, { %Expression**, i64 }* %t80
  %t82 = extractvalue { %Expression**, i64 } %t81, 1
  %t83 = sitofp i64 %t82 to double
  %t84 = fcmp oge double %t71, %t83
  %t85 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t86 = load double, double* %l1
  br i1 %t84, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t87 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t88 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t89 = load i32, i32* %t88
  %t90 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t91 = bitcast [16 x i8]* %t90 to i8*
  %t92 = getelementptr inbounds i8, i8* %t91, i64 8
  %t93 = bitcast i8* %t92 to { %Expression**, i64 }**
  %t94 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t93
  %t95 = icmp eq i32 %t89, 8
  %t96 = select i1 %t95, { %Expression**, i64 }* %t94, { %Expression**, i64 }* null
  %t97 = load double, double* %l1
  %t98 = fptosi double %t97 to i64
  %t99 = load { %Expression**, i64 }, { %Expression**, i64 }* %t96
  %t100 = extractvalue { %Expression**, i64 } %t99, 0
  %t101 = extractvalue { %Expression**, i64 } %t99, 1
  %t102 = icmp uge i64 %t98, %t101
  ; bounds check: %t102 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t98, i64 %t101)
  %t103 = getelementptr %Expression*, %Expression** %t100, i64 %t98
  %t104 = load %Expression*, %Expression** %t103
  %t105 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t104)
  %t106 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t87, { %EffectRequirement*, i64 }* %t105)
  store { %EffectRequirement*, i64 }* %t106, { %EffectRequirement*, i64 }** %l0
  %t107 = load double, double* %l1
  %t108 = sitofp i64 1 to double
  %t109 = fadd double %t107, %t108
  store double %t109, double* %l1
  br label %loop.latch6
loop.latch6:
  %t110 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t111 = load double, double* %l1
  br label %loop.header4
afterloop7:
  %t114 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t115 = load double, double* %l1
  %t116 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t116
merge3:
  %t117 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t118 = load i32, i32* %t117
  %t119 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t120 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t118, 0
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %t123 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t124 = icmp eq i32 %t118, 1
  %t125 = select i1 %t124, i8* %t123, i8* %t122
  %t126 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t127 = icmp eq i32 %t118, 2
  %t128 = select i1 %t127, i8* %t126, i8* %t125
  %t129 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t130 = icmp eq i32 %t118, 3
  %t131 = select i1 %t130, i8* %t129, i8* %t128
  %t132 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t118, 4
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t118, 5
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t118, 6
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t118, 7
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t118, 8
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t118, 9
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t118, 10
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t118, 11
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t118, 12
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t118, 13
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %t162 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t118, 14
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t118, 15
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %s168 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h512390329, i32 0, i32 0
  %t169 = icmp eq i8* %t167, %s168
  br i1 %t169, label %then10, label %merge11
then10:
  %t170 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t171 = load i32, i32* %t170
  %t172 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t173 = bitcast [16 x i8]* %t172 to i8*
  %t174 = bitcast i8* %t173 to %Expression**
  %t175 = load %Expression*, %Expression** %t174
  %t176 = icmp eq i32 %t171, 7
  %t177 = select i1 %t176, %Expression* %t175, %Expression* null
  %t178 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t177)
  ret { %EffectRequirement*, i64 }* %t178
merge11:
  %t179 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t180 = load i32, i32* %t179
  %t181 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t182 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t180, 0
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t180, 1
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %t188 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t180, 2
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %t191 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t192 = icmp eq i32 %t180, 3
  %t193 = select i1 %t192, i8* %t191, i8* %t190
  %t194 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t195 = icmp eq i32 %t180, 4
  %t196 = select i1 %t195, i8* %t194, i8* %t193
  %t197 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t198 = icmp eq i32 %t180, 5
  %t199 = select i1 %t198, i8* %t197, i8* %t196
  %t200 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t201 = icmp eq i32 %t180, 6
  %t202 = select i1 %t201, i8* %t200, i8* %t199
  %t203 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t204 = icmp eq i32 %t180, 7
  %t205 = select i1 %t204, i8* %t203, i8* %t202
  %t206 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t207 = icmp eq i32 %t180, 8
  %t208 = select i1 %t207, i8* %t206, i8* %t205
  %t209 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t210 = icmp eq i32 %t180, 9
  %t211 = select i1 %t210, i8* %t209, i8* %t208
  %t212 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t213 = icmp eq i32 %t180, 10
  %t214 = select i1 %t213, i8* %t212, i8* %t211
  %t215 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t216 = icmp eq i32 %t180, 11
  %t217 = select i1 %t216, i8* %t215, i8* %t214
  %t218 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t219 = icmp eq i32 %t180, 12
  %t220 = select i1 %t219, i8* %t218, i8* %t217
  %t221 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t222 = icmp eq i32 %t180, 13
  %t223 = select i1 %t222, i8* %t221, i8* %t220
  %t224 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t225 = icmp eq i32 %t180, 14
  %t226 = select i1 %t225, i8* %t224, i8* %t223
  %t227 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t228 = icmp eq i32 %t180, 15
  %t229 = select i1 %t228, i8* %t227, i8* %t226
  %s230 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1445149598, i32 0, i32 0
  %t231 = icmp eq i8* %t229, %s230
  br i1 %t231, label %then12, label %merge13
then12:
  %t232 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t233 = load i32, i32* %t232
  %t234 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t235 = bitcast [16 x i8]* %t234 to i8*
  %t236 = getelementptr inbounds i8, i8* %t235, i64 8
  %t237 = bitcast i8* %t236 to %Expression**
  %t238 = load %Expression*, %Expression** %t237
  %t239 = icmp eq i32 %t233, 5
  %t240 = select i1 %t239, %Expression* %t238, %Expression* null
  %t241 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t240)
  ret { %EffectRequirement*, i64 }* %t241
merge13:
  %t242 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t243 = load i32, i32* %t242
  %t244 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t245 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t246 = icmp eq i32 %t243, 0
  %t247 = select i1 %t246, i8* %t245, i8* %t244
  %t248 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t249 = icmp eq i32 %t243, 1
  %t250 = select i1 %t249, i8* %t248, i8* %t247
  %t251 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t252 = icmp eq i32 %t243, 2
  %t253 = select i1 %t252, i8* %t251, i8* %t250
  %t254 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t255 = icmp eq i32 %t243, 3
  %t256 = select i1 %t255, i8* %t254, i8* %t253
  %t257 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t258 = icmp eq i32 %t243, 4
  %t259 = select i1 %t258, i8* %t257, i8* %t256
  %t260 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t261 = icmp eq i32 %t243, 5
  %t262 = select i1 %t261, i8* %t260, i8* %t259
  %t263 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t264 = icmp eq i32 %t243, 6
  %t265 = select i1 %t264, i8* %t263, i8* %t262
  %t266 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t267 = icmp eq i32 %t243, 7
  %t268 = select i1 %t267, i8* %t266, i8* %t265
  %t269 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t270 = icmp eq i32 %t243, 8
  %t271 = select i1 %t270, i8* %t269, i8* %t268
  %t272 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t273 = icmp eq i32 %t243, 9
  %t274 = select i1 %t273, i8* %t272, i8* %t271
  %t275 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t276 = icmp eq i32 %t243, 10
  %t277 = select i1 %t276, i8* %t275, i8* %t274
  %t278 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t279 = icmp eq i32 %t243, 11
  %t280 = select i1 %t279, i8* %t278, i8* %t277
  %t281 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t282 = icmp eq i32 %t243, 12
  %t283 = select i1 %t282, i8* %t281, i8* %t280
  %t284 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t285 = icmp eq i32 %t243, 13
  %t286 = select i1 %t285, i8* %t284, i8* %t283
  %t287 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t288 = icmp eq i32 %t243, 14
  %t289 = select i1 %t288, i8* %t287, i8* %t286
  %t290 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t291 = icmp eq i32 %t243, 15
  %t292 = select i1 %t291, i8* %t290, i8* %t289
  %s293 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1496334143, i32 0, i32 0
  %t294 = icmp eq i8* %t292, %s293
  br i1 %t294, label %then14, label %merge15
then14:
  %t295 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t296 = load i32, i32* %t295
  %t297 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t298 = bitcast [24 x i8]* %t297 to i8*
  %t299 = getelementptr inbounds i8, i8* %t298, i64 8
  %t300 = bitcast i8* %t299 to %Expression**
  %t301 = load %Expression*, %Expression** %t300
  %t302 = icmp eq i32 %t296, 6
  %t303 = select i1 %t302, %Expression* %t301, %Expression* null
  %t304 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t303)
  store { %EffectRequirement*, i64 }* %t304, { %EffectRequirement*, i64 }** %l2
  %t305 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l2
  %t306 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t307 = load i32, i32* %t306
  %t308 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t309 = bitcast [24 x i8]* %t308 to i8*
  %t310 = getelementptr inbounds i8, i8* %t309, i64 16
  %t311 = bitcast i8* %t310 to %Expression**
  %t312 = load %Expression*, %Expression** %t311
  %t313 = icmp eq i32 %t307, 6
  %t314 = select i1 %t313, %Expression* %t312, %Expression* null
  %t315 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t314)
  %t316 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t305, { %EffectRequirement*, i64 }* %t315)
  store { %EffectRequirement*, i64 }* %t316, { %EffectRequirement*, i64 }** %l2
  %t317 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l2
  ret { %EffectRequirement*, i64 }* %t317
merge15:
  %t318 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t319 = load i32, i32* %t318
  %t320 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t321 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t322 = icmp eq i32 %t319, 0
  %t323 = select i1 %t322, i8* %t321, i8* %t320
  %t324 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t325 = icmp eq i32 %t319, 1
  %t326 = select i1 %t325, i8* %t324, i8* %t323
  %t327 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t328 = icmp eq i32 %t319, 2
  %t329 = select i1 %t328, i8* %t327, i8* %t326
  %t330 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t331 = icmp eq i32 %t319, 3
  %t332 = select i1 %t331, i8* %t330, i8* %t329
  %t333 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t334 = icmp eq i32 %t319, 4
  %t335 = select i1 %t334, i8* %t333, i8* %t332
  %t336 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t337 = icmp eq i32 %t319, 5
  %t338 = select i1 %t337, i8* %t336, i8* %t335
  %t339 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t340 = icmp eq i32 %t319, 6
  %t341 = select i1 %t340, i8* %t339, i8* %t338
  %t342 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t343 = icmp eq i32 %t319, 7
  %t344 = select i1 %t343, i8* %t342, i8* %t341
  %t345 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t346 = icmp eq i32 %t319, 8
  %t347 = select i1 %t346, i8* %t345, i8* %t344
  %t348 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t349 = icmp eq i32 %t319, 9
  %t350 = select i1 %t349, i8* %t348, i8* %t347
  %t351 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t352 = icmp eq i32 %t319, 10
  %t353 = select i1 %t352, i8* %t351, i8* %t350
  %t354 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t355 = icmp eq i32 %t319, 11
  %t356 = select i1 %t355, i8* %t354, i8* %t353
  %t357 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t358 = icmp eq i32 %t319, 12
  %t359 = select i1 %t358, i8* %t357, i8* %t356
  %t360 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t361 = icmp eq i32 %t319, 13
  %t362 = select i1 %t361, i8* %t360, i8* %t359
  %t363 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t364 = icmp eq i32 %t319, 14
  %t365 = select i1 %t364, i8* %t363, i8* %t362
  %t366 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t367 = icmp eq i32 %t319, 15
  %t368 = select i1 %t367, i8* %t366, i8* %t365
  %s369 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h667777838, i32 0, i32 0
  %t370 = icmp eq i8* %t368, %s369
  br i1 %t370, label %then16, label %merge17
then16:
  %t371 = alloca [0 x %EffectRequirement]
  %t372 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t371, i32 0, i32 0
  %t373 = alloca { %EffectRequirement*, i64 }
  %t374 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t373, i32 0, i32 0
  store %EffectRequirement* %t372, %EffectRequirement** %t374
  %t375 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t373, i32 0, i32 1
  store i64 0, i64* %t375
  store { %EffectRequirement*, i64 }* %t373, { %EffectRequirement*, i64 }** %l3
  %t376 = sitofp i64 0 to double
  store double %t376, double* %l4
  %t377 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t378 = load double, double* %l4
  br label %loop.header18
loop.header18:
  %t418 = phi { %EffectRequirement*, i64 }* [ %t377, %then16 ], [ %t416, %loop.latch20 ]
  %t419 = phi double [ %t378, %then16 ], [ %t417, %loop.latch20 ]
  store { %EffectRequirement*, i64 }* %t418, { %EffectRequirement*, i64 }** %l3
  store double %t419, double* %l4
  br label %loop.body19
loop.body19:
  %t379 = load double, double* %l4
  %t380 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t381 = load i32, i32* %t380
  %t382 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t383 = bitcast [8 x i8]* %t382 to i8*
  %t384 = bitcast i8* %t383 to { %Expression**, i64 }**
  %t385 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t384
  %t386 = icmp eq i32 %t381, 10
  %t387 = select i1 %t386, { %Expression**, i64 }* %t385, { %Expression**, i64 }* null
  %t388 = load { %Expression**, i64 }, { %Expression**, i64 }* %t387
  %t389 = extractvalue { %Expression**, i64 } %t388, 1
  %t390 = sitofp i64 %t389 to double
  %t391 = fcmp oge double %t379, %t390
  %t392 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t393 = load double, double* %l4
  br i1 %t391, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t394 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t395 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t396 = load i32, i32* %t395
  %t397 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t398 = bitcast [8 x i8]* %t397 to i8*
  %t399 = bitcast i8* %t398 to { %Expression**, i64 }**
  %t400 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t399
  %t401 = icmp eq i32 %t396, 10
  %t402 = select i1 %t401, { %Expression**, i64 }* %t400, { %Expression**, i64 }* null
  %t403 = load double, double* %l4
  %t404 = fptosi double %t403 to i64
  %t405 = load { %Expression**, i64 }, { %Expression**, i64 }* %t402
  %t406 = extractvalue { %Expression**, i64 } %t405, 0
  %t407 = extractvalue { %Expression**, i64 } %t405, 1
  %t408 = icmp uge i64 %t404, %t407
  ; bounds check: %t408 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t404, i64 %t407)
  %t409 = getelementptr %Expression*, %Expression** %t406, i64 %t404
  %t410 = load %Expression*, %Expression** %t409
  %t411 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t410)
  %t412 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t394, { %EffectRequirement*, i64 }* %t411)
  store { %EffectRequirement*, i64 }* %t412, { %EffectRequirement*, i64 }** %l3
  %t413 = load double, double* %l4
  %t414 = sitofp i64 1 to double
  %t415 = fadd double %t413, %t414
  store double %t415, double* %l4
  br label %loop.latch20
loop.latch20:
  %t416 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t417 = load double, double* %l4
  br label %loop.header18
afterloop21:
  %t420 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t421 = load double, double* %l4
  %t422 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  ret { %EffectRequirement*, i64 }* %t422
merge17:
  %t423 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t424 = load i32, i32* %t423
  %t425 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t426 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t427 = icmp eq i32 %t424, 0
  %t428 = select i1 %t427, i8* %t426, i8* %t425
  %t429 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t430 = icmp eq i32 %t424, 1
  %t431 = select i1 %t430, i8* %t429, i8* %t428
  %t432 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t433 = icmp eq i32 %t424, 2
  %t434 = select i1 %t433, i8* %t432, i8* %t431
  %t435 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t436 = icmp eq i32 %t424, 3
  %t437 = select i1 %t436, i8* %t435, i8* %t434
  %t438 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t439 = icmp eq i32 %t424, 4
  %t440 = select i1 %t439, i8* %t438, i8* %t437
  %t441 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t442 = icmp eq i32 %t424, 5
  %t443 = select i1 %t442, i8* %t441, i8* %t440
  %t444 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t445 = icmp eq i32 %t424, 6
  %t446 = select i1 %t445, i8* %t444, i8* %t443
  %t447 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t448 = icmp eq i32 %t424, 7
  %t449 = select i1 %t448, i8* %t447, i8* %t446
  %t450 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t451 = icmp eq i32 %t424, 8
  %t452 = select i1 %t451, i8* %t450, i8* %t449
  %t453 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t454 = icmp eq i32 %t424, 9
  %t455 = select i1 %t454, i8* %t453, i8* %t452
  %t456 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t457 = icmp eq i32 %t424, 10
  %t458 = select i1 %t457, i8* %t456, i8* %t455
  %t459 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t460 = icmp eq i32 %t424, 11
  %t461 = select i1 %t460, i8* %t459, i8* %t458
  %t462 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t463 = icmp eq i32 %t424, 12
  %t464 = select i1 %t463, i8* %t462, i8* %t461
  %t465 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t466 = icmp eq i32 %t424, 13
  %t467 = select i1 %t466, i8* %t465, i8* %t464
  %t468 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t469 = icmp eq i32 %t424, 14
  %t470 = select i1 %t469, i8* %t468, i8* %t467
  %t471 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t472 = icmp eq i32 %t424, 15
  %t473 = select i1 %t472, i8* %t471, i8* %t470
  %s474 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h826984377, i32 0, i32 0
  %t475 = icmp eq i8* %t473, %s474
  br i1 %t475, label %then24, label %merge25
then24:
  %t476 = alloca [0 x %EffectRequirement]
  %t477 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t476, i32 0, i32 0
  %t478 = alloca { %EffectRequirement*, i64 }
  %t479 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t478, i32 0, i32 0
  store %EffectRequirement* %t477, %EffectRequirement** %t479
  %t480 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t478, i32 0, i32 1
  store i64 0, i64* %t480
  store { %EffectRequirement*, i64 }* %t478, { %EffectRequirement*, i64 }** %l5
  %t481 = sitofp i64 0 to double
  store double %t481, double* %l6
  %t482 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t483 = load double, double* %l6
  br label %loop.header26
loop.header26:
  %t540 = phi { %EffectRequirement*, i64 }* [ %t482, %then24 ], [ %t538, %loop.latch28 ]
  %t541 = phi double [ %t483, %then24 ], [ %t539, %loop.latch28 ]
  store { %EffectRequirement*, i64 }* %t540, { %EffectRequirement*, i64 }** %l5
  store double %t541, double* %l6
  br label %loop.body27
loop.body27:
  %t484 = load double, double* %l6
  %t485 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t486 = load i32, i32* %t485
  %t487 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t488 = bitcast [8 x i8]* %t487 to i8*
  %t489 = bitcast i8* %t488 to { %ObjectField**, i64 }**
  %t490 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t489
  %t491 = icmp eq i32 %t486, 11
  %t492 = select i1 %t491, { %ObjectField**, i64 }* %t490, { %ObjectField**, i64 }* null
  %t493 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t494 = bitcast [16 x i8]* %t493 to i8*
  %t495 = getelementptr inbounds i8, i8* %t494, i64 8
  %t496 = bitcast i8* %t495 to { %ObjectField**, i64 }**
  %t497 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t496
  %t498 = icmp eq i32 %t486, 12
  %t499 = select i1 %t498, { %ObjectField**, i64 }* %t497, { %ObjectField**, i64 }* %t492
  %t500 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t499
  %t501 = extractvalue { %ObjectField**, i64 } %t500, 1
  %t502 = sitofp i64 %t501 to double
  %t503 = fcmp oge double %t484, %t502
  %t504 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t505 = load double, double* %l6
  br i1 %t503, label %then30, label %merge31
then30:
  br label %afterloop29
merge31:
  %t506 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t507 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t508 = load i32, i32* %t507
  %t509 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t510 = bitcast [8 x i8]* %t509 to i8*
  %t511 = bitcast i8* %t510 to { %ObjectField**, i64 }**
  %t512 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t511
  %t513 = icmp eq i32 %t508, 11
  %t514 = select i1 %t513, { %ObjectField**, i64 }* %t512, { %ObjectField**, i64 }* null
  %t515 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t516 = bitcast [16 x i8]* %t515 to i8*
  %t517 = getelementptr inbounds i8, i8* %t516, i64 8
  %t518 = bitcast i8* %t517 to { %ObjectField**, i64 }**
  %t519 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t518
  %t520 = icmp eq i32 %t508, 12
  %t521 = select i1 %t520, { %ObjectField**, i64 }* %t519, { %ObjectField**, i64 }* %t514
  %t522 = load double, double* %l6
  %t523 = fptosi double %t522 to i64
  %t524 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t521
  %t525 = extractvalue { %ObjectField**, i64 } %t524, 0
  %t526 = extractvalue { %ObjectField**, i64 } %t524, 1
  %t527 = icmp uge i64 %t523, %t526
  ; bounds check: %t527 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t523, i64 %t526)
  %t528 = getelementptr %ObjectField*, %ObjectField** %t525, i64 %t523
  %t529 = load %ObjectField*, %ObjectField** %t528
  %t530 = getelementptr %ObjectField, %ObjectField* %t529, i32 0, i32 1
  %t531 = load %Expression, %Expression* %t530
  %t532 = alloca %Expression
  store %Expression %t531, %Expression* %t532
  %t533 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t532)
  %t534 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t506, { %EffectRequirement*, i64 }* %t533)
  store { %EffectRequirement*, i64 }* %t534, { %EffectRequirement*, i64 }** %l5
  %t535 = load double, double* %l6
  %t536 = sitofp i64 1 to double
  %t537 = fadd double %t535, %t536
  store double %t537, double* %l6
  br label %loop.latch28
loop.latch28:
  %t538 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t539 = load double, double* %l6
  br label %loop.header26
afterloop29:
  %t542 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t543 = load double, double* %l6
  %t544 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  ret { %EffectRequirement*, i64 }* %t544
merge25:
  %t545 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t546 = load i32, i32* %t545
  %t547 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t548 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t549 = icmp eq i32 %t546, 0
  %t550 = select i1 %t549, i8* %t548, i8* %t547
  %t551 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t552 = icmp eq i32 %t546, 1
  %t553 = select i1 %t552, i8* %t551, i8* %t550
  %t554 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t555 = icmp eq i32 %t546, 2
  %t556 = select i1 %t555, i8* %t554, i8* %t553
  %t557 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t558 = icmp eq i32 %t546, 3
  %t559 = select i1 %t558, i8* %t557, i8* %t556
  %t560 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t561 = icmp eq i32 %t546, 4
  %t562 = select i1 %t561, i8* %t560, i8* %t559
  %t563 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t564 = icmp eq i32 %t546, 5
  %t565 = select i1 %t564, i8* %t563, i8* %t562
  %t566 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t567 = icmp eq i32 %t546, 6
  %t568 = select i1 %t567, i8* %t566, i8* %t565
  %t569 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t570 = icmp eq i32 %t546, 7
  %t571 = select i1 %t570, i8* %t569, i8* %t568
  %t572 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t573 = icmp eq i32 %t546, 8
  %t574 = select i1 %t573, i8* %t572, i8* %t571
  %t575 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t576 = icmp eq i32 %t546, 9
  %t577 = select i1 %t576, i8* %t575, i8* %t574
  %t578 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t579 = icmp eq i32 %t546, 10
  %t580 = select i1 %t579, i8* %t578, i8* %t577
  %t581 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t582 = icmp eq i32 %t546, 11
  %t583 = select i1 %t582, i8* %t581, i8* %t580
  %t584 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t585 = icmp eq i32 %t546, 12
  %t586 = select i1 %t585, i8* %t584, i8* %t583
  %t587 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t588 = icmp eq i32 %t546, 13
  %t589 = select i1 %t588, i8* %t587, i8* %t586
  %t590 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t591 = icmp eq i32 %t546, 14
  %t592 = select i1 %t591, i8* %t590, i8* %t589
  %t593 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t594 = icmp eq i32 %t546, 15
  %t595 = select i1 %t594, i8* %t593, i8* %t592
  %s596 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h264904746, i32 0, i32 0
  %t597 = icmp eq i8* %t595, %s596
  br i1 %t597, label %then32, label %merge33
then32:
  %t598 = alloca [0 x %EffectRequirement]
  %t599 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t598, i32 0, i32 0
  %t600 = alloca { %EffectRequirement*, i64 }
  %t601 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t600, i32 0, i32 0
  store %EffectRequirement* %t599, %EffectRequirement** %t601
  %t602 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t600, i32 0, i32 1
  store i64 0, i64* %t602
  store { %EffectRequirement*, i64 }* %t600, { %EffectRequirement*, i64 }** %l7
  %t603 = sitofp i64 0 to double
  store double %t603, double* %l8
  %t604 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t605 = load double, double* %l8
  br label %loop.header34
loop.header34:
  %t662 = phi { %EffectRequirement*, i64 }* [ %t604, %then32 ], [ %t660, %loop.latch36 ]
  %t663 = phi double [ %t605, %then32 ], [ %t661, %loop.latch36 ]
  store { %EffectRequirement*, i64 }* %t662, { %EffectRequirement*, i64 }** %l7
  store double %t663, double* %l8
  br label %loop.body35
loop.body35:
  %t606 = load double, double* %l8
  %t607 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t608 = load i32, i32* %t607
  %t609 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t610 = bitcast [8 x i8]* %t609 to i8*
  %t611 = bitcast i8* %t610 to { %ObjectField**, i64 }**
  %t612 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t611
  %t613 = icmp eq i32 %t608, 11
  %t614 = select i1 %t613, { %ObjectField**, i64 }* %t612, { %ObjectField**, i64 }* null
  %t615 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t616 = bitcast [16 x i8]* %t615 to i8*
  %t617 = getelementptr inbounds i8, i8* %t616, i64 8
  %t618 = bitcast i8* %t617 to { %ObjectField**, i64 }**
  %t619 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t618
  %t620 = icmp eq i32 %t608, 12
  %t621 = select i1 %t620, { %ObjectField**, i64 }* %t619, { %ObjectField**, i64 }* %t614
  %t622 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t621
  %t623 = extractvalue { %ObjectField**, i64 } %t622, 1
  %t624 = sitofp i64 %t623 to double
  %t625 = fcmp oge double %t606, %t624
  %t626 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t627 = load double, double* %l8
  br i1 %t625, label %then38, label %merge39
then38:
  br label %afterloop37
merge39:
  %t628 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t629 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t630 = load i32, i32* %t629
  %t631 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t632 = bitcast [8 x i8]* %t631 to i8*
  %t633 = bitcast i8* %t632 to { %ObjectField**, i64 }**
  %t634 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t633
  %t635 = icmp eq i32 %t630, 11
  %t636 = select i1 %t635, { %ObjectField**, i64 }* %t634, { %ObjectField**, i64 }* null
  %t637 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t638 = bitcast [16 x i8]* %t637 to i8*
  %t639 = getelementptr inbounds i8, i8* %t638, i64 8
  %t640 = bitcast i8* %t639 to { %ObjectField**, i64 }**
  %t641 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t640
  %t642 = icmp eq i32 %t630, 12
  %t643 = select i1 %t642, { %ObjectField**, i64 }* %t641, { %ObjectField**, i64 }* %t636
  %t644 = load double, double* %l8
  %t645 = fptosi double %t644 to i64
  %t646 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t643
  %t647 = extractvalue { %ObjectField**, i64 } %t646, 0
  %t648 = extractvalue { %ObjectField**, i64 } %t646, 1
  %t649 = icmp uge i64 %t645, %t648
  ; bounds check: %t649 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t645, i64 %t648)
  %t650 = getelementptr %ObjectField*, %ObjectField** %t647, i64 %t645
  %t651 = load %ObjectField*, %ObjectField** %t650
  %t652 = getelementptr %ObjectField, %ObjectField* %t651, i32 0, i32 1
  %t653 = load %Expression, %Expression* %t652
  %t654 = alloca %Expression
  store %Expression %t653, %Expression* %t654
  %t655 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t654)
  %t656 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t628, { %EffectRequirement*, i64 }* %t655)
  store { %EffectRequirement*, i64 }* %t656, { %EffectRequirement*, i64 }** %l7
  %t657 = load double, double* %l8
  %t658 = sitofp i64 1 to double
  %t659 = fadd double %t657, %t658
  store double %t659, double* %l8
  br label %loop.latch36
loop.latch36:
  %t660 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t661 = load double, double* %l8
  br label %loop.header34
afterloop37:
  %t664 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t665 = load double, double* %l8
  %t666 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t666
merge33:
  %t667 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t668 = load i32, i32* %t667
  %t669 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t670 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t671 = icmp eq i32 %t668, 0
  %t672 = select i1 %t671, i8* %t670, i8* %t669
  %t673 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t674 = icmp eq i32 %t668, 1
  %t675 = select i1 %t674, i8* %t673, i8* %t672
  %t676 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t677 = icmp eq i32 %t668, 2
  %t678 = select i1 %t677, i8* %t676, i8* %t675
  %t679 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t680 = icmp eq i32 %t668, 3
  %t681 = select i1 %t680, i8* %t679, i8* %t678
  %t682 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t683 = icmp eq i32 %t668, 4
  %t684 = select i1 %t683, i8* %t682, i8* %t681
  %t685 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t686 = icmp eq i32 %t668, 5
  %t687 = select i1 %t686, i8* %t685, i8* %t684
  %t688 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t689 = icmp eq i32 %t668, 6
  %t690 = select i1 %t689, i8* %t688, i8* %t687
  %t691 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t692 = icmp eq i32 %t668, 7
  %t693 = select i1 %t692, i8* %t691, i8* %t690
  %t694 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t695 = icmp eq i32 %t668, 8
  %t696 = select i1 %t695, i8* %t694, i8* %t693
  %t697 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t698 = icmp eq i32 %t668, 9
  %t699 = select i1 %t698, i8* %t697, i8* %t696
  %t700 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t701 = icmp eq i32 %t668, 10
  %t702 = select i1 %t701, i8* %t700, i8* %t699
  %t703 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t704 = icmp eq i32 %t668, 11
  %t705 = select i1 %t704, i8* %t703, i8* %t702
  %t706 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t707 = icmp eq i32 %t668, 12
  %t708 = select i1 %t707, i8* %t706, i8* %t705
  %t709 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t710 = icmp eq i32 %t668, 13
  %t711 = select i1 %t710, i8* %t709, i8* %t708
  %t712 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t713 = icmp eq i32 %t668, 14
  %t714 = select i1 %t713, i8* %t712, i8* %t711
  %t715 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t716 = icmp eq i32 %t668, 15
  %t717 = select i1 %t716, i8* %t715, i8* %t714
  %s718 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1211862785, i32 0, i32 0
  %t719 = icmp eq i8* %t717, %s718
  br i1 %t719, label %then40, label %merge41
then40:
  %t720 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t721 = load i32, i32* %t720
  %t722 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t723 = bitcast [24 x i8]* %t722 to i8*
  %t724 = getelementptr inbounds i8, i8* %t723, i64 8
  %t725 = bitcast i8* %t724 to %Block*
  %t726 = load %Block, %Block* %t725
  %t727 = icmp eq i32 %t721, 13
  %t728 = select i1 %t727, %Block %t726, %Block zeroinitializer
  %t729 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t728)
  ret { %EffectRequirement*, i64 }* %t729
merge41:
  %t730 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t731 = load i32, i32* %t730
  %t732 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t733 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t734 = icmp eq i32 %t731, 0
  %t735 = select i1 %t734, i8* %t733, i8* %t732
  %t736 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t737 = icmp eq i32 %t731, 1
  %t738 = select i1 %t737, i8* %t736, i8* %t735
  %t739 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t740 = icmp eq i32 %t731, 2
  %t741 = select i1 %t740, i8* %t739, i8* %t738
  %t742 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t743 = icmp eq i32 %t731, 3
  %t744 = select i1 %t743, i8* %t742, i8* %t741
  %t745 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t746 = icmp eq i32 %t731, 4
  %t747 = select i1 %t746, i8* %t745, i8* %t744
  %t748 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t749 = icmp eq i32 %t731, 5
  %t750 = select i1 %t749, i8* %t748, i8* %t747
  %t751 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t752 = icmp eq i32 %t731, 6
  %t753 = select i1 %t752, i8* %t751, i8* %t750
  %t754 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t755 = icmp eq i32 %t731, 7
  %t756 = select i1 %t755, i8* %t754, i8* %t753
  %t757 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t758 = icmp eq i32 %t731, 8
  %t759 = select i1 %t758, i8* %t757, i8* %t756
  %t760 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t761 = icmp eq i32 %t731, 9
  %t762 = select i1 %t761, i8* %t760, i8* %t759
  %t763 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t764 = icmp eq i32 %t731, 10
  %t765 = select i1 %t764, i8* %t763, i8* %t762
  %t766 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t767 = icmp eq i32 %t731, 11
  %t768 = select i1 %t767, i8* %t766, i8* %t765
  %t769 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t770 = icmp eq i32 %t731, 12
  %t771 = select i1 %t770, i8* %t769, i8* %t768
  %t772 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t773 = icmp eq i32 %t731, 13
  %t774 = select i1 %t773, i8* %t772, i8* %t771
  %t775 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t776 = icmp eq i32 %t731, 14
  %t777 = select i1 %t776, i8* %t775, i8* %t774
  %t778 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t779 = icmp eq i32 %t731, 15
  %t780 = select i1 %t779, i8* %t778, i8* %t777
  %s781 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h975618503, i32 0, i32 0
  %t782 = icmp eq i8* %t780, %s781
  br i1 %t782, label %then42, label %merge43
then42:
  %t783 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t784 = load i32, i32* %t783
  %t785 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t786 = bitcast [16 x i8]* %t785 to i8*
  %t787 = bitcast i8* %t786 to %Expression**
  %t788 = load %Expression*, %Expression** %t787
  %t789 = icmp eq i32 %t784, 9
  %t790 = select i1 %t789, %Expression* %t788, %Expression* null
  %t791 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t790)
  store { %EffectRequirement*, i64 }* %t791, { %EffectRequirement*, i64 }** %l9
  %t792 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t793 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t794 = load i32, i32* %t793
  %t795 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t796 = bitcast [16 x i8]* %t795 to i8*
  %t797 = getelementptr inbounds i8, i8* %t796, i64 8
  %t798 = bitcast i8* %t797 to %Expression**
  %t799 = load %Expression*, %Expression** %t798
  %t800 = icmp eq i32 %t794, 9
  %t801 = select i1 %t800, %Expression* %t799, %Expression* null
  %t802 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t801)
  %t803 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t792, { %EffectRequirement*, i64 }* %t802)
  store { %EffectRequirement*, i64 }* %t803, { %EffectRequirement*, i64 }** %l9
  %t804 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  ret { %EffectRequirement*, i64 }* %t804
merge43:
  %t805 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t806 = load i32, i32* %t805
  %t807 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t808 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t809 = icmp eq i32 %t806, 0
  %t810 = select i1 %t809, i8* %t808, i8* %t807
  %t811 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t812 = icmp eq i32 %t806, 1
  %t813 = select i1 %t812, i8* %t811, i8* %t810
  %t814 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t815 = icmp eq i32 %t806, 2
  %t816 = select i1 %t815, i8* %t814, i8* %t813
  %t817 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t818 = icmp eq i32 %t806, 3
  %t819 = select i1 %t818, i8* %t817, i8* %t816
  %t820 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t821 = icmp eq i32 %t806, 4
  %t822 = select i1 %t821, i8* %t820, i8* %t819
  %t823 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t824 = icmp eq i32 %t806, 5
  %t825 = select i1 %t824, i8* %t823, i8* %t822
  %t826 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t827 = icmp eq i32 %t806, 6
  %t828 = select i1 %t827, i8* %t826, i8* %t825
  %t829 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t830 = icmp eq i32 %t806, 7
  %t831 = select i1 %t830, i8* %t829, i8* %t828
  %t832 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t833 = icmp eq i32 %t806, 8
  %t834 = select i1 %t833, i8* %t832, i8* %t831
  %t835 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t836 = icmp eq i32 %t806, 9
  %t837 = select i1 %t836, i8* %t835, i8* %t834
  %t838 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t839 = icmp eq i32 %t806, 10
  %t840 = select i1 %t839, i8* %t838, i8* %t837
  %t841 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t842 = icmp eq i32 %t806, 11
  %t843 = select i1 %t842, i8* %t841, i8* %t840
  %t844 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t845 = icmp eq i32 %t806, 12
  %t846 = select i1 %t845, i8* %t844, i8* %t843
  %t847 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t848 = icmp eq i32 %t806, 13
  %t849 = select i1 %t848, i8* %t847, i8* %t846
  %t850 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t851 = icmp eq i32 %t806, 14
  %t852 = select i1 %t851, i8* %t850, i8* %t849
  %t853 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t854 = icmp eq i32 %t806, 15
  %t855 = select i1 %t854, i8* %t853, i8* %t852
  %s856 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1312780988, i32 0, i32 0
  %t857 = icmp eq i8* %t855, %s856
  br i1 %t857, label %then44, label %merge45
then44:
  %t858 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t859 = load i32, i32* %t858
  %t860 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t861 = bitcast [16 x i8]* %t860 to i8*
  %t862 = bitcast i8* %t861 to %Expression**
  %t863 = load %Expression*, %Expression** %t862
  %t864 = icmp eq i32 %t859, 14
  %t865 = select i1 %t864, %Expression* %t863, %Expression* null
  %t866 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t865)
  store { %EffectRequirement*, i64 }* %t866, { %EffectRequirement*, i64 }** %l10
  %t867 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t868 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t869 = load i32, i32* %t868
  %t870 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t871 = bitcast [16 x i8]* %t870 to i8*
  %t872 = getelementptr inbounds i8, i8* %t871, i64 8
  %t873 = bitcast i8* %t872 to %Expression**
  %t874 = load %Expression*, %Expression** %t873
  %t875 = icmp eq i32 %t869, 14
  %t876 = select i1 %t875, %Expression* %t874, %Expression* null
  %t877 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t876)
  %t878 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t867, { %EffectRequirement*, i64 }* %t877)
  store { %EffectRequirement*, i64 }* %t878, { %EffectRequirement*, i64 }** %l10
  %t879 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  ret { %EffectRequirement*, i64 }* %t879
merge45:
  %t880 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t881 = load i32, i32* %t880
  %t882 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t883 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t884 = icmp eq i32 %t881, 0
  %t885 = select i1 %t884, i8* %t883, i8* %t882
  %t886 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t887 = icmp eq i32 %t881, 1
  %t888 = select i1 %t887, i8* %t886, i8* %t885
  %t889 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t890 = icmp eq i32 %t881, 2
  %t891 = select i1 %t890, i8* %t889, i8* %t888
  %t892 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t893 = icmp eq i32 %t881, 3
  %t894 = select i1 %t893, i8* %t892, i8* %t891
  %t895 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t896 = icmp eq i32 %t881, 4
  %t897 = select i1 %t896, i8* %t895, i8* %t894
  %t898 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t899 = icmp eq i32 %t881, 5
  %t900 = select i1 %t899, i8* %t898, i8* %t897
  %t901 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t902 = icmp eq i32 %t881, 6
  %t903 = select i1 %t902, i8* %t901, i8* %t900
  %t904 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t905 = icmp eq i32 %t881, 7
  %t906 = select i1 %t905, i8* %t904, i8* %t903
  %t907 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t908 = icmp eq i32 %t881, 8
  %t909 = select i1 %t908, i8* %t907, i8* %t906
  %t910 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t911 = icmp eq i32 %t881, 9
  %t912 = select i1 %t911, i8* %t910, i8* %t909
  %t913 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t914 = icmp eq i32 %t881, 10
  %t915 = select i1 %t914, i8* %t913, i8* %t912
  %t916 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t917 = icmp eq i32 %t881, 11
  %t918 = select i1 %t917, i8* %t916, i8* %t915
  %t919 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t920 = icmp eq i32 %t881, 12
  %t921 = select i1 %t920, i8* %t919, i8* %t918
  %t922 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t923 = icmp eq i32 %t881, 13
  %t924 = select i1 %t923, i8* %t922, i8* %t921
  %t925 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t926 = icmp eq i32 %t881, 14
  %t927 = select i1 %t926, i8* %t925, i8* %t924
  %t928 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t929 = icmp eq i32 %t881, 15
  %t930 = select i1 %t929, i8* %t928, i8* %t927
  %s931 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089530004, i32 0, i32 0
  %t932 = icmp eq i8* %t930, %s931
  br i1 %t932, label %then46, label %merge47
then46:
  %t933 = alloca [0 x %EffectRequirement]
  %t934 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t933, i32 0, i32 0
  %t935 = alloca { %EffectRequirement*, i64 }
  %t936 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t935, i32 0, i32 0
  store %EffectRequirement* %t934, %EffectRequirement** %t936
  %t937 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t935, i32 0, i32 1
  store i64 0, i64* %t937
  ret { %EffectRequirement*, i64 }* %t935
merge47:
  %t938 = alloca [0 x %EffectRequirement]
  %t939 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t938, i32 0, i32 0
  %t940 = alloca { %EffectRequirement*, i64 }
  %t941 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t940, i32 0, i32 0
  store %EffectRequirement* %t939, %EffectRequirement** %t941
  %t942 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t940, i32 0, i32 1
  store i64 0, i64* %t942
  ret { %EffectRequirement*, i64 }* %t940
}

define { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* %tokens) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %t0 = alloca [0 x %EffectRequirement]
  %t1 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t0, i32 0, i32 0
  %t2 = alloca { %EffectRequirement*, i64 }
  %t3 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t2, i32 0, i32 0
  store %EffectRequirement* %t1, %EffectRequirement** %t3
  %t4 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %EffectRequirement*, i64 }* %t2, { %EffectRequirement*, i64 }** %l0
  %t5 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t6 = call { %EffectRequirement*, i64 }* @append_prompt_effect({ %EffectRequirement*, i64 }* %t5, { %Token*, i64 }* %tokens)
  store { %EffectRequirement*, i64 }* %t6, { %EffectRequirement*, i64 }** %l0
  %t7 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s8 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193491872, i32 0, i32 0
  %s9 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193495007, i32 0, i32 0
  %s10 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.len23.h509166939, i32 0, i32 0
  %t11 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t7, { %Token*, i64 }* %tokens, i8* %s8, i8* %s9, i8* %s10)
  store { %EffectRequirement*, i64 }* %t11, { %EffectRequirement*, i64 }** %l0
  %t12 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s13 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h359348221, i32 0, i32 0
  %s14 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193495007, i32 0, i32 0
  %s15 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.len18.h166827074, i32 0, i32 0
  %t16 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t12, { %Token*, i64 }* %tokens, i8* %s13, i8* %s14, i8* %s15)
  store { %EffectRequirement*, i64 }* %t16, { %EffectRequirement*, i64 }** %l0
  %t17 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s18 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h1121316919, i32 0, i32 0
  %s19 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193495007, i32 0, i32 0
  %s20 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1840566713, i32 0, i32 0
  %t21 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t17, { %Token*, i64 }* %tokens, i8* %s18, i8* %s19, i8* %s20)
  store { %EffectRequirement*, i64 }* %t21, { %EffectRequirement*, i64 }** %l0
  %t22 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s23 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h261786827, i32 0, i32 0
  %s24 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090540497, i32 0, i32 0
  %s25 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h959371065, i32 0, i32 0
  %t26 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t22, { %Token*, i64 }* %tokens, i8* %s23, i8* %s24, i8* %s25)
  store { %EffectRequirement*, i64 }* %t26, { %EffectRequirement*, i64 }** %l0
  %t27 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s28 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h6052019, i32 0, i32 0
  %s29 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090540497, i32 0, i32 0
  %s30 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h857956175, i32 0, i32 0
  %t31 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t27, { %Token*, i64 }* %tokens, i8* %s28, i8* %s29, i8* %s30)
  store { %EffectRequirement*, i64 }* %t31, { %EffectRequirement*, i64 }** %l0
  %t32 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s33 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h474104665, i32 0, i32 0
  %s34 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193495007, i32 0, i32 0
  %s35 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1970595328, i32 0, i32 0
  %t36 = call { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %t32, { %Token*, i64 }* %tokens, i8* %s33, i8* %s34, i8* %s35)
  store { %EffectRequirement*, i64 }* %t36, { %EffectRequirement*, i64 }** %l0
  %t37 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s38 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h461669077, i32 0, i32 0
  %s39 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090540497, i32 0, i32 0
  %s40 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1681046972, i32 0, i32 0
  %t41 = call { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %t37, { %Token*, i64 }* %tokens, i8* %s38, i8* %s39, i8* %s40)
  store { %EffectRequirement*, i64 }* %t41, { %EffectRequirement*, i64 }** %l0
  %t42 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s43 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h469485193, i32 0, i32 0
  %s44 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1991159579, i32 0, i32 0
  %s45 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h881761880, i32 0, i32 0
  %t46 = call { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %t42, { %Token*, i64 }* %tokens, i8* %s43, i8* %s44, i8* %s45)
  store { %EffectRequirement*, i64 }* %t46, { %EffectRequirement*, i64 }** %l0
  %t47 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t47
}

define { %EffectRequirement*, i64 }* @append_prompt_effect({ %EffectRequirement*, i64 }* %requirements, { %Token*, i64 }* %tokens) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %l1 = alloca double
  %l2 = alloca %Token
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca %Token
  %l6 = alloca double
  store { %EffectRequirement*, i64 }* %requirements, { %EffectRequirement*, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t190 = phi { %EffectRequirement*, i64 }* [ %t1, %entry ], [ %t188, %loop.latch2 ]
  %t191 = phi double [ %t2, %entry ], [ %t189, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t190, { %EffectRequirement*, i64 }** %l0
  store double %t191, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t5 = extractvalue { %Token*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l1
  %t11 = fptosi double %t10 to i64
  %t12 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t13 = extractvalue { %Token*, i64 } %t12, 0
  %t14 = extractvalue { %Token*, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t11, i64 %t14)
  %t16 = getelementptr %Token, %Token* %t13, i64 %t11
  %t17 = load %Token, %Token* %t16
  store %Token %t17, %Token* %l2
  %t18 = load %Token, %Token* %l2
  %s19 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1128151960, i32 0, i32 0
  %t20 = call i1 @is_identifier_token(%Token %t18, i8* %s19)
  %t21 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t22 = load double, double* %l1
  %t23 = load %Token, %Token* %l2
  br i1 %t20, label %then6, label %merge7
then6:
  %t24 = load double, double* %l1
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  %t27 = call double @next_non_trivia({ %Token*, i64 }* %tokens, double %t26)
  store double %t27, double* %l3
  %s28 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h10983220, i32 0, i32 0
  store i8* %s28, i8** %l4
  %t29 = load double, double* %l3
  %t30 = sitofp i64 -1 to double
  %t31 = fcmp une double %t29, %t30
  %t32 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t33 = load double, double* %l1
  %t34 = load %Token, %Token* %l2
  %t35 = load double, double* %l3
  %t36 = load i8*, i8** %l4
  br i1 %t31, label %then8, label %merge9
then8:
  %t37 = load double, double* %l3
  %t38 = fptosi double %t37 to i64
  %t39 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t40 = extractvalue { %Token*, i64 } %t39, 0
  %t41 = extractvalue { %Token*, i64 } %t39, 1
  %t42 = icmp uge i64 %t38, %t41
  ; bounds check: %t42 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t38, i64 %t41)
  %t43 = getelementptr %Token, %Token* %t40, i64 %t38
  %t44 = load %Token, %Token* %t43
  store %Token %t44, %Token* %l5
  %t46 = load %Token, %Token* %l5
  %t47 = extractvalue %Token %t46, 0
  %t48 = extractvalue %TokenKind %t47, 0
  %t49 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t50 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t48, 0
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %t53 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t54 = icmp eq i32 %t48, 1
  %t55 = select i1 %t54, i8* %t53, i8* %t52
  %t56 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t57 = icmp eq i32 %t48, 2
  %t58 = select i1 %t57, i8* %t56, i8* %t55
  %t59 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t60 = icmp eq i32 %t48, 3
  %t61 = select i1 %t60, i8* %t59, i8* %t58
  %t62 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t48, 4
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t48, 5
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t48, 6
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t48, 7
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %s74 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1576352120, i32 0, i32 0
  %t75 = icmp eq i8* %t73, %s74
  br label %logical_or_entry_45

logical_or_entry_45:
  br i1 %t75, label %logical_or_merge_45, label %logical_or_right_45

logical_or_right_45:
  %t76 = load %Token, %Token* %l5
  %t77 = extractvalue %Token %t76, 0
  %t78 = extractvalue %TokenKind %t77, 0
  %t79 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t80 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t81 = icmp eq i32 %t78, 0
  %t82 = select i1 %t81, i8* %t80, i8* %t79
  %t83 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t84 = icmp eq i32 %t78, 1
  %t85 = select i1 %t84, i8* %t83, i8* %t82
  %t86 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t87 = icmp eq i32 %t78, 2
  %t88 = select i1 %t87, i8* %t86, i8* %t85
  %t89 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t90 = icmp eq i32 %t78, 3
  %t91 = select i1 %t90, i8* %t89, i8* %t88
  %t92 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t93 = icmp eq i32 %t78, 4
  %t94 = select i1 %t93, i8* %t92, i8* %t91
  %t95 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t78, 5
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %t98 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t78, 6
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t78, 7
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %s104 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h590768815, i32 0, i32 0
  %t105 = icmp eq i8* %t103, %s104
  br label %logical_or_right_end_45

logical_or_right_end_45:
  br label %logical_or_merge_45

logical_or_merge_45:
  %t106 = phi i1 [ true, %logical_or_entry_45 ], [ %t105, %logical_or_right_end_45 ]
  %t107 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t108 = load double, double* %l1
  %t109 = load %Token, %Token* %l2
  %t110 = load double, double* %l3
  %t111 = load i8*, i8** %l4
  %t112 = load %Token, %Token* %l5
  br i1 %t106, label %then10, label %merge11
then10:
  %s113 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h721793546, i32 0, i32 0
  %t114 = load %Token, %Token* %l5
  %t115 = extractvalue %Token %t114, 1
  %t116 = call i8* @sailfin_runtime_string_concat(i8* %s113, i8* %t115)
  store i8* %t116, i8** %l4
  %t117 = load double, double* %l3
  %t118 = sitofp i64 1 to double
  %t119 = fadd double %t117, %t118
  %t120 = call double @next_non_trivia({ %Token*, i64 }* %tokens, double %t119)
  store double %t120, double* %l6
  %t122 = load double, double* %l6
  %t123 = sitofp i64 -1 to double
  %t124 = fcmp une double %t122, %t123
  br label %logical_and_entry_121

logical_and_entry_121:
  br i1 %t124, label %logical_and_right_121, label %logical_and_merge_121

logical_and_right_121:
  %t125 = load double, double* %l6
  %t126 = fptosi double %t125 to i64
  %t127 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t128 = extractvalue { %Token*, i64 } %t127, 0
  %t129 = extractvalue { %Token*, i64 } %t127, 1
  %t130 = icmp uge i64 %t126, %t129
  ; bounds check: %t130 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t126, i64 %t129)
  %t131 = getelementptr %Token, %Token* %t128, i64 %t126
  %t132 = load %Token, %Token* %t131
  %t133 = alloca [2 x i8], align 1
  %t134 = getelementptr [2 x i8], [2 x i8]* %t133, i32 0, i32 0
  store i8 123, i8* %t134
  %t135 = getelementptr [2 x i8], [2 x i8]* %t133, i32 0, i32 1
  store i8 0, i8* %t135
  %t136 = getelementptr [2 x i8], [2 x i8]* %t133, i32 0, i32 0
  %t137 = call i1 @is_symbol_token(%Token %t132, i8* %t136)
  br label %logical_and_right_end_121

logical_and_right_end_121:
  br label %logical_and_merge_121

logical_and_merge_121:
  %t138 = phi i1 [ false, %logical_and_entry_121 ], [ %t137, %logical_and_right_end_121 ]
  %t139 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t140 = load double, double* %l1
  %t141 = load %Token, %Token* %l2
  %t142 = load double, double* %l3
  %t143 = load i8*, i8** %l4
  %t144 = load %Token, %Token* %l5
  %t145 = load double, double* %l6
  br i1 %t138, label %then12, label %merge13
then12:
  %t146 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s147 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h238194529, i32 0, i32 0
  %t148 = insertvalue %EffectRequirement undef, i8* %s147, 0
  %t149 = load %Token, %Token* %l2
  %t150 = alloca %Token
  store %Token %t149, %Token* %t150
  %t151 = insertvalue %EffectRequirement %t148, %Token* %t150, 1
  %t152 = load i8*, i8** %l4
  %t153 = insertvalue %EffectRequirement %t151, i8* %t152, 2
  %t154 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t146, %EffectRequirement %t153)
  store { %EffectRequirement*, i64 }* %t154, { %EffectRequirement*, i64 }** %l0
  %t155 = load double, double* %l1
  %t156 = sitofp i64 1 to double
  %t157 = fadd double %t155, %t156
  store double %t157, double* %l1
  br label %loop.latch2
merge13:
  %t158 = load i8*, i8** %l4
  %t159 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t160 = load double, double* %l1
  br label %merge11
merge11:
  %t161 = phi i8* [ %t158, %merge13 ], [ %t111, %logical_or_merge_45 ]
  %t162 = phi { %EffectRequirement*, i64 }* [ %t159, %merge13 ], [ %t107, %logical_or_merge_45 ]
  %t163 = phi double [ %t160, %merge13 ], [ %t108, %logical_or_merge_45 ]
  store i8* %t161, i8** %l4
  store { %EffectRequirement*, i64 }* %t162, { %EffectRequirement*, i64 }** %l0
  store double %t163, double* %l1
  %t164 = load i8*, i8** %l4
  %t165 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t166 = load double, double* %l1
  br label %merge9
merge9:
  %t167 = phi i8* [ %t164, %merge11 ], [ %t36, %then6 ]
  %t168 = phi { %EffectRequirement*, i64 }* [ %t165, %merge11 ], [ %t32, %then6 ]
  %t169 = phi double [ %t166, %merge11 ], [ %t33, %then6 ]
  store i8* %t167, i8** %l4
  store { %EffectRequirement*, i64 }* %t168, { %EffectRequirement*, i64 }** %l0
  store double %t169, double* %l1
  %t170 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s171 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h238194529, i32 0, i32 0
  %t172 = insertvalue %EffectRequirement undef, i8* %s171, 0
  %t173 = load %Token, %Token* %l2
  %t174 = alloca %Token
  store %Token %t173, %Token* %t174
  %t175 = insertvalue %EffectRequirement %t172, %Token* %t174, 1
  %t176 = load i8*, i8** %l4
  %t177 = insertvalue %EffectRequirement %t175, i8* %t176, 2
  %t178 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t170, %EffectRequirement %t177)
  store { %EffectRequirement*, i64 }* %t178, { %EffectRequirement*, i64 }** %l0
  %t179 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t180 = load double, double* %l1
  %t181 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  br label %merge7
merge7:
  %t182 = phi { %EffectRequirement*, i64 }* [ %t179, %merge9 ], [ %t21, %merge5 ]
  %t183 = phi double [ %t180, %merge9 ], [ %t22, %merge5 ]
  %t184 = phi { %EffectRequirement*, i64 }* [ %t181, %merge9 ], [ %t21, %merge5 ]
  store { %EffectRequirement*, i64 }* %t182, { %EffectRequirement*, i64 }** %l0
  store double %t183, double* %l1
  store { %EffectRequirement*, i64 }* %t184, { %EffectRequirement*, i64 }** %l0
  %t185 = load double, double* %l1
  %t186 = sitofp i64 1 to double
  %t187 = fadd double %t185, %t186
  store double %t187, double* %l1
  br label %loop.latch2
loop.latch2:
  %t188 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t189 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t192 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t193 = load double, double* %l1
  %t194 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t194
}

define { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %requirements, { %Token*, i64 }* %tokens, i8* %identifier, i8* %effect, i8* %description) {
entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca { %EffectRequirement*, i64 }*
  %l2 = alloca double
  %t0 = alloca [2 x i8], align 1
  %t1 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  store i8 46, i8* %t1
  %t2 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 1
  store i8 0, i8* %t2
  %t3 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  %t4 = call { %Token*, i64 }* @find_identifier_followed_by_symbol({ %Token*, i64 }* %tokens, i8* %identifier, i8* %t3)
  store { %Token*, i64 }* %t4, { %Token*, i64 }** %l0
  store { %EffectRequirement*, i64 }* %requirements, { %EffectRequirement*, i64 }** %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t7 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t8 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t38 = phi { %EffectRequirement*, i64 }* [ %t7, %entry ], [ %t36, %loop.latch2 ]
  %t39 = phi double [ %t8, %entry ], [ %t37, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t38, { %EffectRequirement*, i64 }** %l1
  store double %t39, double* %l2
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l2
  %t10 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t11 = load { %Token*, i64 }, { %Token*, i64 }* %t10
  %t12 = extractvalue { %Token*, i64 } %t11, 1
  %t13 = sitofp i64 %t12 to double
  %t14 = fcmp oge double %t9, %t13
  %t15 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t16 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t17 = load double, double* %l2
  br i1 %t14, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t18 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t19 = insertvalue %EffectRequirement undef, i8* %effect, 0
  %t20 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t21 = load double, double* %l2
  %t22 = fptosi double %t21 to i64
  %t23 = load { %Token*, i64 }, { %Token*, i64 }* %t20
  %t24 = extractvalue { %Token*, i64 } %t23, 0
  %t25 = extractvalue { %Token*, i64 } %t23, 1
  %t26 = icmp uge i64 %t22, %t25
  ; bounds check: %t26 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t22, i64 %t25)
  %t27 = getelementptr %Token, %Token* %t24, i64 %t22
  %t28 = load %Token, %Token* %t27
  %t29 = alloca %Token
  store %Token %t28, %Token* %t29
  %t30 = insertvalue %EffectRequirement %t19, %Token* %t29, 1
  %t31 = insertvalue %EffectRequirement %t30, i8* %description, 2
  %t32 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t18, %EffectRequirement %t31)
  store { %EffectRequirement*, i64 }* %t32, { %EffectRequirement*, i64 }** %l1
  %t33 = load double, double* %l2
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l2
  br label %loop.latch2
loop.latch2:
  %t36 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t37 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t40 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t41 = load double, double* %l2
  %t42 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t42
}

define { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %requirements, { %Token*, i64 }* %tokens, i8* %identifier, i8* %effect, i8* %description) {
entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca { %EffectRequirement*, i64 }*
  %l2 = alloca double
  %t0 = call { %Token*, i64 }* @find_identifier_call({ %Token*, i64 }* %tokens, i8* %identifier)
  store { %Token*, i64 }* %t0, { %Token*, i64 }** %l0
  store { %EffectRequirement*, i64 }* %requirements, { %EffectRequirement*, i64 }** %l1
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l2
  %t2 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t3 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t4 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t34 = phi { %EffectRequirement*, i64 }* [ %t3, %entry ], [ %t32, %loop.latch2 ]
  %t35 = phi double [ %t4, %entry ], [ %t33, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t34, { %EffectRequirement*, i64 }** %l1
  store double %t35, double* %l2
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l2
  %t6 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t7 = load { %Token*, i64 }, { %Token*, i64 }* %t6
  %t8 = extractvalue { %Token*, i64 } %t7, 1
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t5, %t9
  %t11 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t12 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t13 = load double, double* %l2
  br i1 %t10, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t14 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t15 = insertvalue %EffectRequirement undef, i8* %effect, 0
  %t16 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t17 = load double, double* %l2
  %t18 = fptosi double %t17 to i64
  %t19 = load { %Token*, i64 }, { %Token*, i64 }* %t16
  %t20 = extractvalue { %Token*, i64 } %t19, 0
  %t21 = extractvalue { %Token*, i64 } %t19, 1
  %t22 = icmp uge i64 %t18, %t21
  ; bounds check: %t22 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t18, i64 %t21)
  %t23 = getelementptr %Token, %Token* %t20, i64 %t18
  %t24 = load %Token, %Token* %t23
  %t25 = alloca %Token
  store %Token %t24, %Token* %t25
  %t26 = insertvalue %EffectRequirement %t15, %Token* %t25, 1
  %t27 = insertvalue %EffectRequirement %t26, i8* %description, 2
  %t28 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t14, %EffectRequirement %t27)
  store { %EffectRequirement*, i64 }* %t28, { %EffectRequirement*, i64 }** %l1
  %t29 = load double, double* %l2
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l2
  br label %loop.latch2
loop.latch2:
  %t32 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t33 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t36 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t37 = load double, double* %l2
  %t38 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t38
}

define { %Token*, i64 }* @find_identifier_followed_by_symbol({ %Token*, i64 }* %tokens, i8* %name, i8* %symbol) {
entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %t0 = alloca [0 x %Token]
  %t1 = getelementptr [0 x %Token], [0 x %Token]* %t0, i32 0, i32 0
  %t2 = alloca { %Token*, i64 }
  %t3 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t2, i32 0, i32 0
  store %Token* %t1, %Token** %t3
  %t4 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Token*, i64 }* %t2, { %Token*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t76 = phi { %Token*, i64 }* [ %t6, %entry ], [ %t74, %loop.latch2 ]
  %t77 = phi double [ %t7, %entry ], [ %t75, %loop.latch2 ]
  store { %Token*, i64 }* %t76, { %Token*, i64 }** %l0
  store double %t77, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t10 = extractvalue { %Token*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = fptosi double %t15 to i64
  %t17 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t18 = extractvalue { %Token*, i64 } %t17, 0
  %t19 = extractvalue { %Token*, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t16, i64 %t19)
  %t21 = getelementptr %Token, %Token* %t18, i64 %t16
  %t22 = load %Token, %Token* %t21
  %t23 = call i1 @is_identifier_token(%Token %t22, i8* %name)
  %t24 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t25 = load double, double* %l1
  br i1 %t23, label %then6, label %merge7
then6:
  %t26 = load double, double* %l1
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  %t29 = call double @next_non_trivia({ %Token*, i64 }* %tokens, double %t28)
  store double %t29, double* %l2
  %t31 = load double, double* %l2
  %t32 = sitofp i64 -1 to double
  %t33 = fcmp une double %t31, %t32
  br label %logical_and_entry_30

logical_and_entry_30:
  br i1 %t33, label %logical_and_right_30, label %logical_and_merge_30

logical_and_right_30:
  %t34 = load double, double* %l2
  %t35 = fptosi double %t34 to i64
  %t36 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t37 = extractvalue { %Token*, i64 } %t36, 0
  %t38 = extractvalue { %Token*, i64 } %t36, 1
  %t39 = icmp uge i64 %t35, %t38
  ; bounds check: %t39 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t35, i64 %t38)
  %t40 = getelementptr %Token, %Token* %t37, i64 %t35
  %t41 = load %Token, %Token* %t40
  %t42 = call i1 @is_symbol_token(%Token %t41, i8* %symbol)
  br label %logical_and_right_end_30

logical_and_right_end_30:
  br label %logical_and_merge_30

logical_and_merge_30:
  %t43 = phi i1 [ false, %logical_and_entry_30 ], [ %t42, %logical_and_right_end_30 ]
  %t44 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t45 = load double, double* %l1
  %t46 = load double, double* %l2
  br i1 %t43, label %then8, label %merge9
then8:
  %t47 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t48 = load double, double* %l1
  %t49 = fptosi double %t48 to i64
  %t50 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t51 = extractvalue { %Token*, i64 } %t50, 0
  %t52 = extractvalue { %Token*, i64 } %t50, 1
  %t53 = icmp uge i64 %t49, %t52
  ; bounds check: %t53 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t49, i64 %t52)
  %t54 = getelementptr %Token, %Token* %t51, i64 %t49
  %t55 = load %Token, %Token* %t54
  %t56 = call noalias i8* @malloc(i64 32)
  %t57 = bitcast i8* %t56 to %Token*
  store %Token %t55, %Token* %t57
  %t58 = alloca [1 x i8*]
  %t59 = getelementptr [1 x i8*], [1 x i8*]* %t58, i32 0, i32 0
  %t60 = getelementptr i8*, i8** %t59, i64 0
  store i8* %t56, i8** %t60
  %t61 = alloca { i8**, i64 }
  %t62 = getelementptr { i8**, i64 }, { i8**, i64 }* %t61, i32 0, i32 0
  store i8** %t59, i8*** %t62
  %t63 = getelementptr { i8**, i64 }, { i8**, i64 }* %t61, i32 0, i32 1
  store i64 1, i64* %t63
  %t64 = bitcast { %Token*, i64 }* %t47 to { i8**, i64 }*
  %t65 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t64, { i8**, i64 }* %t61)
  %t66 = bitcast { i8**, i64 }* %t65 to { %Token*, i64 }*
  store { %Token*, i64 }* %t66, { %Token*, i64 }** %l0
  %t67 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  br label %merge9
merge9:
  %t68 = phi { %Token*, i64 }* [ %t67, %then8 ], [ %t44, %logical_and_merge_30 ]
  store { %Token*, i64 }* %t68, { %Token*, i64 }** %l0
  %t69 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  br label %merge7
merge7:
  %t70 = phi { %Token*, i64 }* [ %t69, %merge9 ], [ %t24, %merge5 ]
  store { %Token*, i64 }* %t70, { %Token*, i64 }** %l0
  %t71 = load double, double* %l1
  %t72 = sitofp i64 1 to double
  %t73 = fadd double %t71, %t72
  store double %t73, double* %l1
  br label %loop.latch2
loop.latch2:
  %t74 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t75 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t78 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t79 = load double, double* %l1
  %t80 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  ret { %Token*, i64 }* %t80
}

define { %Token*, i64 }* @find_identifier_call({ %Token*, i64 }* %tokens, i8* %name) {
entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %t0 = alloca [0 x %Token]
  %t1 = getelementptr [0 x %Token], [0 x %Token]* %t0, i32 0, i32 0
  %t2 = alloca { %Token*, i64 }
  %t3 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t2, i32 0, i32 0
  store %Token* %t1, %Token** %t3
  %t4 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Token*, i64 }* %t2, { %Token*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t80 = phi { %Token*, i64 }* [ %t6, %entry ], [ %t78, %loop.latch2 ]
  %t81 = phi double [ %t7, %entry ], [ %t79, %loop.latch2 ]
  store { %Token*, i64 }* %t80, { %Token*, i64 }** %l0
  store double %t81, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t10 = extractvalue { %Token*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = fptosi double %t15 to i64
  %t17 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t18 = extractvalue { %Token*, i64 } %t17, 0
  %t19 = extractvalue { %Token*, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t16, i64 %t19)
  %t21 = getelementptr %Token, %Token* %t18, i64 %t16
  %t22 = load %Token, %Token* %t21
  %t23 = call i1 @is_identifier_token(%Token %t22, i8* %name)
  %t24 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t25 = load double, double* %l1
  br i1 %t23, label %then6, label %merge7
then6:
  %t26 = load double, double* %l1
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  %t29 = call double @next_non_trivia({ %Token*, i64 }* %tokens, double %t28)
  store double %t29, double* %l2
  %t31 = load double, double* %l2
  %t32 = sitofp i64 -1 to double
  %t33 = fcmp une double %t31, %t32
  br label %logical_and_entry_30

logical_and_entry_30:
  br i1 %t33, label %logical_and_right_30, label %logical_and_merge_30

logical_and_right_30:
  %t34 = load double, double* %l2
  %t35 = fptosi double %t34 to i64
  %t36 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t37 = extractvalue { %Token*, i64 } %t36, 0
  %t38 = extractvalue { %Token*, i64 } %t36, 1
  %t39 = icmp uge i64 %t35, %t38
  ; bounds check: %t39 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t35, i64 %t38)
  %t40 = getelementptr %Token, %Token* %t37, i64 %t35
  %t41 = load %Token, %Token* %t40
  %t42 = alloca [2 x i8], align 1
  %t43 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  store i8 40, i8* %t43
  %t44 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 1
  store i8 0, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  %t46 = call i1 @is_symbol_token(%Token %t41, i8* %t45)
  br label %logical_and_right_end_30

logical_and_right_end_30:
  br label %logical_and_merge_30

logical_and_merge_30:
  %t47 = phi i1 [ false, %logical_and_entry_30 ], [ %t46, %logical_and_right_end_30 ]
  %t48 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t49 = load double, double* %l1
  %t50 = load double, double* %l2
  br i1 %t47, label %then8, label %merge9
then8:
  %t51 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t52 = load double, double* %l1
  %t53 = fptosi double %t52 to i64
  %t54 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t55 = extractvalue { %Token*, i64 } %t54, 0
  %t56 = extractvalue { %Token*, i64 } %t54, 1
  %t57 = icmp uge i64 %t53, %t56
  ; bounds check: %t57 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t53, i64 %t56)
  %t58 = getelementptr %Token, %Token* %t55, i64 %t53
  %t59 = load %Token, %Token* %t58
  %t60 = call noalias i8* @malloc(i64 32)
  %t61 = bitcast i8* %t60 to %Token*
  store %Token %t59, %Token* %t61
  %t62 = alloca [1 x i8*]
  %t63 = getelementptr [1 x i8*], [1 x i8*]* %t62, i32 0, i32 0
  %t64 = getelementptr i8*, i8** %t63, i64 0
  store i8* %t60, i8** %t64
  %t65 = alloca { i8**, i64 }
  %t66 = getelementptr { i8**, i64 }, { i8**, i64 }* %t65, i32 0, i32 0
  store i8** %t63, i8*** %t66
  %t67 = getelementptr { i8**, i64 }, { i8**, i64 }* %t65, i32 0, i32 1
  store i64 1, i64* %t67
  %t68 = bitcast { %Token*, i64 }* %t51 to { i8**, i64 }*
  %t69 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t68, { i8**, i64 }* %t65)
  %t70 = bitcast { i8**, i64 }* %t69 to { %Token*, i64 }*
  store { %Token*, i64 }* %t70, { %Token*, i64 }** %l0
  %t71 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  br label %merge9
merge9:
  %t72 = phi { %Token*, i64 }* [ %t71, %then8 ], [ %t48, %logical_and_merge_30 ]
  store { %Token*, i64 }* %t72, { %Token*, i64 }** %l0
  %t73 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  br label %merge7
merge7:
  %t74 = phi { %Token*, i64 }* [ %t73, %merge9 ], [ %t24, %merge5 ]
  store { %Token*, i64 }* %t74, { %Token*, i64 }** %l0
  %t75 = load double, double* %l1
  %t76 = sitofp i64 1 to double
  %t77 = fadd double %t75, %t76
  store double %t77, double* %l1
  br label %loop.latch2
loop.latch2:
  %t78 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t79 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t82 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t83 = load double, double* %l1
  %t84 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  ret { %Token*, i64 }* %t84
}

define double @next_non_trivia({ %Token*, i64 }* %tokens, double %start) {
entry:
  %l0 = alloca double
  %l1 = alloca %Token
  store double %start, double* %l0
  %t0 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t25 = phi double [ %t0, %entry ], [ %t24, %loop.latch2 ]
  store double %t25, double* %l0
  br label %loop.body1
loop.body1:
  %t1 = load double, double* %l0
  %t2 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t3 = extractvalue { %Token*, i64 } %t2, 1
  %t4 = sitofp i64 %t3 to double
  %t5 = fcmp oge double %t1, %t4
  %t6 = load double, double* %l0
  br i1 %t5, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t7 = load double, double* %l0
  %t8 = fptosi double %t7 to i64
  %t9 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t10 = extractvalue { %Token*, i64 } %t9, 0
  %t11 = extractvalue { %Token*, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t8, i64 %t11)
  %t13 = getelementptr %Token, %Token* %t10, i64 %t8
  %t14 = load %Token, %Token* %t13
  store %Token %t14, %Token* %l1
  %t15 = load %Token, %Token* %l1
  %t16 = call i1 @is_trivia_token(%Token %t15)
  %t17 = xor i1 %t16, 1
  %t18 = load double, double* %l0
  %t19 = load %Token, %Token* %l1
  br i1 %t17, label %then6, label %merge7
then6:
  %t20 = load double, double* %l0
  ret double %t20
merge7:
  %t21 = load double, double* %l0
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  store double %t23, double* %l0
  br label %loop.latch2
loop.latch2:
  %t24 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t26 = load double, double* %l0
  %t27 = sitofp i64 -1 to double
  ret double %t27
}

define i1 @is_trivia_token(%Token %token) {
entry:
  %t1 = extractvalue %Token %token, 0
  %t2 = extractvalue %TokenKind %t1, 0
  %t3 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t4 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t5 = icmp eq i32 %t2, 0
  %t6 = select i1 %t5, i8* %t4, i8* %t3
  %t7 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t8 = icmp eq i32 %t2, 1
  %t9 = select i1 %t8, i8* %t7, i8* %t6
  %t10 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t11 = icmp eq i32 %t2, 2
  %t12 = select i1 %t11, i8* %t10, i8* %t9
  %t13 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t14 = icmp eq i32 %t2, 3
  %t15 = select i1 %t14, i8* %t13, i8* %t12
  %t16 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t17 = icmp eq i32 %t2, 4
  %t18 = select i1 %t17, i8* %t16, i8* %t15
  %t19 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t20 = icmp eq i32 %t2, 5
  %t21 = select i1 %t20, i8* %t19, i8* %t18
  %t22 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t23 = icmp eq i32 %t2, 6
  %t24 = select i1 %t23, i8* %t22, i8* %t21
  %t25 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t2, 7
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %s28 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h715288307, i32 0, i32 0
  %t29 = icmp eq i8* %t27, %s28
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t29, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t30 = extractvalue %Token %token, 0
  %t31 = extractvalue %TokenKind %t30, 0
  %t32 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t33 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t34 = icmp eq i32 %t31, 0
  %t35 = select i1 %t34, i8* %t33, i8* %t32
  %t36 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t37 = icmp eq i32 %t31, 1
  %t38 = select i1 %t37, i8* %t36, i8* %t35
  %t39 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t40 = icmp eq i32 %t31, 2
  %t41 = select i1 %t40, i8* %t39, i8* %t38
  %t42 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t43 = icmp eq i32 %t31, 3
  %t44 = select i1 %t43, i8* %t42, i8* %t41
  %t45 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t46 = icmp eq i32 %t31, 4
  %t47 = select i1 %t46, i8* %t45, i8* %t44
  %t48 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t49 = icmp eq i32 %t31, 5
  %t50 = select i1 %t49, i8* %t48, i8* %t47
  %t51 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t52 = icmp eq i32 %t31, 6
  %t53 = select i1 %t52, i8* %t51, i8* %t50
  %t54 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t55 = icmp eq i32 %t31, 7
  %t56 = select i1 %t55, i8* %t54, i8* %t53
  %s57 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h936649884, i32 0, i32 0
  %t58 = icmp eq i8* %t56, %s57
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t59 = phi i1 [ true, %logical_or_entry_0 ], [ %t58, %logical_or_right_end_0 ]
  ret i1 %t59
}

define i1 @is_identifier_token(%Token %token, i8* %expected) {
entry:
  %l0 = alloca i8*
  %t0 = extractvalue %Token %token, 0
  %t1 = extractvalue %TokenKind %t0, 0
  %t2 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t3 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t4 = icmp eq i32 %t1, 0
  %t5 = select i1 %t4, i8* %t3, i8* %t2
  %t6 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t7 = icmp eq i32 %t1, 1
  %t8 = select i1 %t7, i8* %t6, i8* %t5
  %t9 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t10 = icmp eq i32 %t1, 2
  %t11 = select i1 %t10, i8* %t9, i8* %t8
  %t12 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t13 = icmp eq i32 %t1, 3
  %t14 = select i1 %t13, i8* %t12, i8* %t11
  %t15 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t16 = icmp eq i32 %t1, 4
  %t17 = select i1 %t16, i8* %t15, i8* %t14
  %t18 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t19 = icmp eq i32 %t1, 5
  %t20 = select i1 %t19, i8* %t18, i8* %t17
  %t21 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t22 = icmp eq i32 %t1, 6
  %t23 = select i1 %t22, i8* %t21, i8* %t20
  %t24 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t1, 7
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %s27 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1576352120, i32 0, i32 0
  %t28 = icmp eq i8* %t26, %s27
  br i1 %t28, label %then0, label %merge1
then0:
  %t29 = extractvalue %Token %token, 0
  %t30 = extractvalue %TokenKind %t29, 0
  %t31 = alloca %TokenKind
  store %TokenKind %t29, %TokenKind* %t31
  %t32 = getelementptr inbounds %TokenKind, %TokenKind* %t31, i32 0, i32 1
  %t33 = bitcast [8 x i8]* %t32 to i8*
  %t34 = bitcast i8* %t33 to i8**
  %t35 = load i8*, i8** %t34
  %t36 = icmp eq i32 %t30, 0
  %t37 = select i1 %t36, i8* %t35, i8* null
  %t38 = getelementptr inbounds %TokenKind, %TokenKind* %t31, i32 0, i32 1
  %t39 = bitcast [8 x i8]* %t38 to i8*
  %t40 = bitcast i8* %t39 to i8**
  %t41 = load i8*, i8** %t40
  %t42 = icmp eq i32 %t30, 1
  %t43 = select i1 %t42, i8* %t41, i8* %t37
  %t44 = getelementptr inbounds %TokenKind, %TokenKind* %t31, i32 0, i32 1
  %t45 = bitcast [8 x i8]* %t44 to i8*
  %t46 = bitcast i8* %t45 to i8**
  %t47 = load i8*, i8** %t46
  %t48 = icmp eq i32 %t30, 2
  %t49 = select i1 %t48, i8* %t47, i8* %t43
  %t50 = getelementptr inbounds %TokenKind, %TokenKind* %t31, i32 0, i32 1
  %t51 = bitcast [8 x i8]* %t50 to i8*
  %t52 = bitcast i8* %t51 to i8**
  %t53 = load i8*, i8** %t52
  %t54 = icmp eq i32 %t30, 3
  %t55 = select i1 %t54, i8* %t53, i8* %t49
  %t56 = getelementptr inbounds %TokenKind, %TokenKind* %t31, i32 0, i32 1
  %t57 = bitcast [8 x i8]* %t56 to i8*
  %t58 = bitcast i8* %t57 to i8**
  %t59 = load i8*, i8** %t58
  %t60 = icmp eq i32 %t30, 4
  %t61 = select i1 %t60, i8* %t59, i8* %t55
  store i8* %t61, i8** %l0
  %t62 = load i8*, i8** %l0
  %t63 = call i64 @sailfin_runtime_string_length(i8* %t62)
  %t64 = icmp sgt i64 %t63, 0
  %t65 = load i8*, i8** %l0
  br i1 %t64, label %then2, label %merge3
then2:
  %t66 = load i8*, i8** %l0
  %t67 = icmp eq i8* %t66, %expected
  ret i1 %t67
merge3:
  br label %merge1
merge1:
  %t68 = extractvalue %Token %token, 1
  %t69 = icmp eq i8* %t68, %expected
  ret i1 %t69
}

define i1 @is_symbol_token(%Token %token, i8* %expected) {
entry:
  %l0 = alloca i8*
  %t0 = extractvalue %Token %token, 0
  %t1 = extractvalue %TokenKind %t0, 0
  %t2 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t3 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t4 = icmp eq i32 %t1, 0
  %t5 = select i1 %t4, i8* %t3, i8* %t2
  %t6 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t7 = icmp eq i32 %t1, 1
  %t8 = select i1 %t7, i8* %t6, i8* %t5
  %t9 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t10 = icmp eq i32 %t1, 2
  %t11 = select i1 %t10, i8* %t9, i8* %t8
  %t12 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t13 = icmp eq i32 %t1, 3
  %t14 = select i1 %t13, i8* %t12, i8* %t11
  %t15 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t16 = icmp eq i32 %t1, 4
  %t17 = select i1 %t16, i8* %t15, i8* %t14
  %t18 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t19 = icmp eq i32 %t1, 5
  %t20 = select i1 %t19, i8* %t18, i8* %t17
  %t21 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t22 = icmp eq i32 %t1, 6
  %t23 = select i1 %t22, i8* %t21, i8* %t20
  %t24 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t1, 7
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %s27 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h453982107, i32 0, i32 0
  %t28 = icmp eq i8* %t26, %s27
  br i1 %t28, label %then0, label %merge1
then0:
  %t29 = extractvalue %Token %token, 0
  %t30 = extractvalue %TokenKind %t29, 0
  %t31 = alloca %TokenKind
  store %TokenKind %t29, %TokenKind* %t31
  %t32 = getelementptr inbounds %TokenKind, %TokenKind* %t31, i32 0, i32 1
  %t33 = bitcast [8 x i8]* %t32 to i8*
  %t34 = bitcast i8* %t33 to i8**
  %t35 = load i8*, i8** %t34
  %t36 = icmp eq i32 %t30, 0
  %t37 = select i1 %t36, i8* %t35, i8* null
  %t38 = getelementptr inbounds %TokenKind, %TokenKind* %t31, i32 0, i32 1
  %t39 = bitcast [8 x i8]* %t38 to i8*
  %t40 = bitcast i8* %t39 to i8**
  %t41 = load i8*, i8** %t40
  %t42 = icmp eq i32 %t30, 1
  %t43 = select i1 %t42, i8* %t41, i8* %t37
  %t44 = getelementptr inbounds %TokenKind, %TokenKind* %t31, i32 0, i32 1
  %t45 = bitcast [8 x i8]* %t44 to i8*
  %t46 = bitcast i8* %t45 to i8**
  %t47 = load i8*, i8** %t46
  %t48 = icmp eq i32 %t30, 2
  %t49 = select i1 %t48, i8* %t47, i8* %t43
  %t50 = getelementptr inbounds %TokenKind, %TokenKind* %t31, i32 0, i32 1
  %t51 = bitcast [8 x i8]* %t50 to i8*
  %t52 = bitcast i8* %t51 to i8**
  %t53 = load i8*, i8** %t52
  %t54 = icmp eq i32 %t30, 3
  %t55 = select i1 %t54, i8* %t53, i8* %t49
  %t56 = getelementptr inbounds %TokenKind, %TokenKind* %t31, i32 0, i32 1
  %t57 = bitcast [8 x i8]* %t56 to i8*
  %t58 = bitcast i8* %t57 to i8**
  %t59 = load i8*, i8** %t58
  %t60 = icmp eq i32 %t30, 4
  %t61 = select i1 %t60, i8* %t59, i8* %t55
  store i8* %t61, i8** %l0
  %t62 = load i8*, i8** %l0
  %t63 = call i64 @sailfin_runtime_string_length(i8* %t62)
  %t64 = icmp sgt i64 %t63, 0
  %t65 = load i8*, i8** %l0
  br i1 %t64, label %then2, label %merge3
then2:
  %t66 = load i8*, i8** %l0
  %t67 = icmp eq i8* %t66, %expected
  ret i1 %t67
merge3:
  br label %merge1
merge1:
  %t68 = extractvalue %Token %token, 1
  %t69 = icmp eq i8* %t68, %expected
  ret i1 %t69
}

define { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }* %violations, { %EffectViolation*, i64 }* %new_violations) {
entry:
  %l0 = alloca { %EffectViolation*, i64 }*
  %l1 = alloca double
  store { %EffectViolation*, i64 }* %violations, { %EffectViolation*, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t35 = phi { %EffectViolation*, i64 }* [ %t1, %entry ], [ %t33, %loop.latch2 ]
  %t36 = phi double [ %t2, %entry ], [ %t34, %loop.latch2 ]
  store { %EffectViolation*, i64 }* %t35, { %EffectViolation*, i64 }** %l0
  store double %t36, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %new_violations
  %t5 = extractvalue { %EffectViolation*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t11 = load double, double* %l1
  %t12 = fptosi double %t11 to i64
  %t13 = load { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %new_violations
  %t14 = extractvalue { %EffectViolation*, i64 } %t13, 0
  %t15 = extractvalue { %EffectViolation*, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t12, i64 %t15)
  %t17 = getelementptr %EffectViolation, %EffectViolation* %t14, i64 %t12
  %t18 = load %EffectViolation, %EffectViolation* %t17
  %t19 = call noalias i8* @malloc(i64 24)
  %t20 = bitcast i8* %t19 to %EffectViolation*
  store %EffectViolation %t18, %EffectViolation* %t20
  %t21 = alloca [1 x i8*]
  %t22 = getelementptr [1 x i8*], [1 x i8*]* %t21, i32 0, i32 0
  %t23 = getelementptr i8*, i8** %t22, i64 0
  store i8* %t19, i8** %t23
  %t24 = alloca { i8**, i64 }
  %t25 = getelementptr { i8**, i64 }, { i8**, i64 }* %t24, i32 0, i32 0
  store i8** %t22, i8*** %t25
  %t26 = getelementptr { i8**, i64 }, { i8**, i64 }* %t24, i32 0, i32 1
  store i64 1, i64* %t26
  %t27 = bitcast { %EffectViolation*, i64 }* %t10 to { i8**, i64 }*
  %t28 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t27, { i8**, i64 }* %t24)
  %t29 = bitcast { i8**, i64 }* %t28 to { %EffectViolation*, i64 }*
  store { %EffectViolation*, i64 }* %t29, { %EffectViolation*, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch2
loop.latch2:
  %t33 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t34 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t37 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t38 = load double, double* %l1
  %t39 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  ret { %EffectViolation*, i64 }* %t39
}

define { %EffectViolation*, i64 }* @append_violation({ %EffectViolation*, i64 }* %collection, %EffectViolation %item) {
entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %EffectViolation*
  store %EffectViolation %item, %EffectViolation* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %EffectViolation*, i64 }* %collection to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %EffectViolation*, i64 }*
  ret { %EffectViolation*, i64 }* %t10
}

define { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %effects, i8* %effect) {
entry:
  %t0 = call i1 @contains_effect({ i8**, i64 }* %effects, i8* %effect)
  br i1 %t0, label %then0, label %merge1
then0:
  ret { i8**, i64 }* %effects
merge1:
  %t1 = alloca [1 x i8*]
  %t2 = getelementptr [1 x i8*], [1 x i8*]* %t1, i32 0, i32 0
  %t3 = getelementptr i8*, i8** %t2, i64 0
  store i8* %effect, i8** %t3
  %t4 = alloca { i8**, i64 }
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t4, i32 0, i32 0
  store i8** %t2, i8*** %t5
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t4, i32 0, i32 1
  store i64 1, i64* %t6
  %t7 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %effects, { i8**, i64 }* %t4)
  ret { i8**, i64 }* %t7
}

define i1 @contains_effect({ i8**, i64 }* %effects, i8* %effect) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t22 = phi double [ %t1, %entry ], [ %t21, %loop.latch2 ]
  store double %t22, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load { i8**, i64 }, { i8**, i64 }* %effects
  %t4 = extractvalue { i8**, i64 } %t3, 1
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t2, %t5
  %t7 = load double, double* %l0
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l0
  %t9 = fptosi double %t8 to i64
  %t10 = load { i8**, i64 }, { i8**, i64 }* %effects
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t9, i64 %t12)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  %t16 = icmp eq i8* %t15, %effect
  %t17 = load double, double* %l0
  br i1 %t16, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t18 = load double, double* %l0
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l0
  br label %loop.latch2
loop.latch2:
  %t21 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t23 = load double, double* %l0
  ret i1 0
}

define { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %collection, %EffectRequirement %item) {
entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %EffectRequirement*
  store %EffectRequirement %item, %EffectRequirement* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %EffectRequirement*, i64 }* %collection to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %EffectRequirement*, i64 }*
  ret { %EffectRequirement*, i64 }* %t10
}

define { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %base, { %EffectRequirement*, i64 }* %additions) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %l1 = alloca double
  store { %EffectRequirement*, i64 }* %base, { %EffectRequirement*, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t35 = phi { %EffectRequirement*, i64 }* [ %t1, %entry ], [ %t33, %loop.latch2 ]
  %t36 = phi double [ %t2, %entry ], [ %t34, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t35, { %EffectRequirement*, i64 }** %l0
  store double %t36, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %additions
  %t5 = extractvalue { %EffectRequirement*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t11 = load double, double* %l1
  %t12 = fptosi double %t11 to i64
  %t13 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %additions
  %t14 = extractvalue { %EffectRequirement*, i64 } %t13, 0
  %t15 = extractvalue { %EffectRequirement*, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t12, i64 %t15)
  %t17 = getelementptr %EffectRequirement, %EffectRequirement* %t14, i64 %t12
  %t18 = load %EffectRequirement, %EffectRequirement* %t17
  %t19 = call noalias i8* @malloc(i64 24)
  %t20 = bitcast i8* %t19 to %EffectRequirement*
  store %EffectRequirement %t18, %EffectRequirement* %t20
  %t21 = alloca [1 x i8*]
  %t22 = getelementptr [1 x i8*], [1 x i8*]* %t21, i32 0, i32 0
  %t23 = getelementptr i8*, i8** %t22, i64 0
  store i8* %t19, i8** %t23
  %t24 = alloca { i8**, i64 }
  %t25 = getelementptr { i8**, i64 }, { i8**, i64 }* %t24, i32 0, i32 0
  store i8** %t22, i8*** %t25
  %t26 = getelementptr { i8**, i64 }, { i8**, i64 }* %t24, i32 0, i32 1
  store i64 1, i64* %t26
  %t27 = bitcast { %EffectRequirement*, i64 }* %t10 to { i8**, i64 }*
  %t28 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t27, { i8**, i64 }* %t24)
  %t29 = bitcast { i8**, i64 }* %t28 to { %EffectRequirement*, i64 }*
  store { %EffectRequirement*, i64 }* %t29, { %EffectRequirement*, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch2
loop.latch2:
  %t33 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t34 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t37 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t38 = load double, double* %l1
  %t39 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t39
}

define i1 @contains_requirement_for_effect({ %EffectRequirement*, i64 }* %requirements, i8* %effect) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t23 = phi double [ %t1, %entry ], [ %t22, %loop.latch2 ]
  store double %t23, double* %l0
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
  call void @sailfin_runtime_bounds_check(i64 %t9, i64 %t12)
  %t14 = getelementptr %EffectRequirement, %EffectRequirement* %t11, i64 %t9
  %t15 = load %EffectRequirement, %EffectRequirement* %t14
  %t16 = extractvalue %EffectRequirement %t15, 0
  %t17 = icmp eq i8* %t16, %effect
  %t18 = load double, double* %l0
  br i1 %t17, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t19 = load double, double* %l0
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l0
  br label %loop.latch2
loop.latch2:
  %t22 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t24 = load double, double* %l0
  ret i1 0
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
