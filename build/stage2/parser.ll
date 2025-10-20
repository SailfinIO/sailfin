; ModuleID = 'sailfin'
source_filename = "sailfin"

%Parser = type { { %Token**, i64 }*, double }
%StatementParseResult = type { %Parser, %Statement }
%ParameterParseResult = type { %Parser, %Parameter }
%ParameterListParseResult = type { %Parser, { %Parameter**, i64 }* }
%StructFieldParseResult = type { %Parser, %FieldDeclaration*, i1 }
%ModelPropertyParseResult = type { %Parser, %ModelProperty*, i1 }
%MethodParseResult = type { %Parser, %MethodDeclaration*, i1 }
%InterfaceMemberParseResult = type { %Parser, %FunctionSignature*, i1 }
%SpecifierListParseResult = type { %Parser, { %NamedSpecifier**, i64 }* }
%NamedSpecifier = type { i8*, i8* }
%EnumVariantParseResult = type { %Parser, %EnumVariant*, i1 }
%TypeParameterParseResult = type { %Parser, { %TypeParameter**, i64 }* }
%ImplementsParseResult = type { %Parser, { %TypeAnnotation**, i64 }*, i1 }
%DecoratorParseResult = type { %Parser, { %Decorator**, i64 }* }
%BlockStatementParseResult = type { %Parser, %Statement*, i1 }
%ParenthesizedParseResult = type { %Parser, { %Token**, i64 }*, i1 }
%MatchCasesParseResult = type { %Parser, { %MatchCase**, i64 }*, i1 }
%MatchCaseParseResult = type { %Parser, %MatchCase*, i1 }
%MatchCaseTokenSplit = type { { %Token**, i64 }*, { %Token**, i64 }*, i1 }
%ExpressionTokens = type { { %Token**, i64 }*, double }
%ExpressionParseResult = type { %ExpressionTokens, %Expression, i1 }
%LambdaParameterParseResult = type { %ExpressionTokens, %Parameter, i1 }
%LambdaParameterListParseResult = type { %ExpressionTokens, { %Parameter**, i64 }*, i1 }
%ExpressionCollectResult = type { %ExpressionTokens, { %Token**, i64 }*, i1 }
%ExpressionBlockParseResult = type { %ExpressionTokens, { %Token**, i64 }*, i1 }
%CallArgumentsParseResult = type { %ExpressionTokens, { %Expression**, i64 }*, i1 }
%ArrayLiteralParseResult = type { %ExpressionTokens, { %Expression**, i64 }*, i1 }
%ObjectLiteralParseResult = type { %ExpressionTokens, { %ObjectField**, i64 }*, i1 }
%StructTypeNameResult = type { { i8**, i64 }*, i1 }
%CaptureResult = type { %Parser, { %Token**, i64 }* }
%EffectParseResult = type { %Parser, { i8**, i64 }* }
%BlockParseResult = type { %Parser, %Block }
%PatternCaptureResult = type { %Parser, { %Token**, i64 }*, i1 }
%LexerState = type { i8*, double, double, double }
%Token = type { %TokenKind, i8*, double, double }
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
%DecoratorArgumentInfo = type { i8*, %LiteralValue }
%DecoratorInfo = type { i8*, { %DecoratorArgumentInfo**, i64 }* }

%TokenKind = type { i32, [8 x i8] }
%Expression = type { i32, [24 x i8] }
%Statement = type { i32, [56 x i8] }
%LiteralValue = type { i32, [8 x i8] }

declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare double @char_code(i8*)
declare i1 @sailfin_runtime_is_decimal_digit(i8)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)

declare noalias i8* @malloc(i64)

@.str.3 = private unnamed_addr constant [7 x i8] c"import\00"
@.str.16 = private unnamed_addr constant [5 x i8] c"from\00"
@.str.13 = private unnamed_addr constant [4 x i8] c"let\00"
@.str.4 = private unnamed_addr constant [5 x i8] c"type\00"
@.str.46 = private unnamed_addr constant [3 x i8] c"fn\00"
@.enum.TokenKind.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.enum.TokenKind.Identifier.variant = private unnamed_addr constant [11 x i8] c"Identifier\00"
@.enum.TokenKind.NumberLiteral.variant = private unnamed_addr constant [14 x i8] c"NumberLiteral\00"
@.enum.TokenKind.StringLiteral.variant = private unnamed_addr constant [14 x i8] c"StringLiteral\00"
@.enum.TokenKind.BooleanLiteral.variant = private unnamed_addr constant [15 x i8] c"BooleanLiteral\00"
@.enum.TokenKind.Symbol.variant = private unnamed_addr constant [7 x i8] c"Symbol\00"
@.enum.TokenKind.Whitespace.variant = private unnamed_addr constant [11 x i8] c"Whitespace\00"
@.enum.TokenKind.Comment.variant = private unnamed_addr constant [8 x i8] c"Comment\00"
@.enum.TokenKind.EndOfFile.variant = private unnamed_addr constant [10 x i8] c"EndOfFile\00"
@.str.103 = private unnamed_addr constant [7 x i8] c"Symbol\00"
@.str.44 = private unnamed_addr constant [3 x i8] c"fn\00"
@.str.42 = private unnamed_addr constant [3 x i8] c"fn\00"
@.str.14 = private unnamed_addr constant [4 x i8] c"for\00"
@.str.22 = private unnamed_addr constant [1 x i8] c"\00"
@.str.23 = private unnamed_addr constant [7 x i8] c"return\00"
@.str.20 = private unnamed_addr constant [3 x i8] c"if\00"
@.str.179 = private unnamed_addr constant [1 x i8] c"\00"
@.str.0 = private unnamed_addr constant [1 x i8] c"\00"
@.str.5 = private unnamed_addr constant [1 x i8] c"\00"

define %Program @parse_program(i8* %source) {
entry:
  %l0 = alloca double
  %t0 = call double @lex(i8* %source)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = call %Program @parse_tokens({ %Token*, i64 }* null)
  ret %Program %t2
}

define %Program @parse_tokens({ %Token*, i64 }* %tokens) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca { %Statement*, i64 }*
  %l2 = alloca %Token
  %l3 = alloca %StatementParseResult
  %t0 = bitcast { %Token*, i64 }* %tokens to { %Token**, i64 }*
  %t1 = insertvalue %Parser undef, { %Token**, i64 }* %t0, 0
  %t2 = sitofp i64 0 to double
  %t3 = insertvalue %Parser %t1, double %t2, 1
  store %Parser %t3, %Parser* %l0
  %t4 = alloca [0 x %Statement]
  %t5 = getelementptr [0 x %Statement], [0 x %Statement]* %t4, i32 0, i32 0
  %t6 = alloca { %Statement*, i64 }
  %t7 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t6, i32 0, i32 0
  store %Statement* %t5, %Statement** %t7
  %t8 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { %Statement*, i64 }* %t6, { %Statement*, i64 }** %l1
  %t9 = load %Parser, %Parser* %l0
  %t10 = call %Parser @skip_trivia(%Parser %t9)
  store %Parser %t10, %Parser* %l0
  %t11 = load %Parser, %Parser* %l0
  %t12 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t60 = phi %Parser [ %t11, %entry ], [ %t58, %loop.latch2 ]
  %t61 = phi { %Statement*, i64 }* [ %t12, %entry ], [ %t59, %loop.latch2 ]
  store %Parser %t60, %Parser* %l0
  store { %Statement*, i64 }* %t61, { %Statement*, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t13 = load %Parser, %Parser* %l0
  %t14 = call %Token @parser_peek_raw(%Parser %t13)
  store %Token %t14, %Token* %l2
  %t15 = load %Token, %Token* %l2
  %t16 = extractvalue %Token %t15, 0
  %t17 = extractvalue %TokenKind %t16, 0
  %t18 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t19 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t20 = icmp eq i32 %t17, 0
  %t21 = select i1 %t20, i8* %t19, i8* %t18
  %t22 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t23 = icmp eq i32 %t17, 1
  %t24 = select i1 %t23, i8* %t22, i8* %t21
  %t25 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t17, 2
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t17, 3
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %t31 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t32 = icmp eq i32 %t17, 4
  %t33 = select i1 %t32, i8* %t31, i8* %t30
  %t34 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t17, 5
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %t37 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t17, 6
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %t40 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t41 = icmp eq i32 %t17, 7
  %t42 = select i1 %t41, i8* %t40, i8* %t39
  %s43 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.43, i32 0, i32 0
  %t44 = icmp eq i8* %t42, %s43
  %t45 = load %Parser, %Parser* %l0
  %t46 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  %t47 = load %Token, %Token* %l2
  br i1 %t44, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t48 = load %Parser, %Parser* %l0
  %t49 = call %StatementParseResult @parse_statement(%Parser %t48)
  store %StatementParseResult %t49, %StatementParseResult* %l3
  %t50 = load %StatementParseResult, %StatementParseResult* %l3
  %t51 = extractvalue %StatementParseResult %t50, 0
  store %Parser %t51, %Parser* %l0
  %t52 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  %t53 = load %StatementParseResult, %StatementParseResult* %l3
  %t54 = extractvalue %StatementParseResult %t53, 1
  %t55 = call { %Statement*, i64 }* @append_statement({ %Statement*, i64 }* %t52, %Statement %t54)
  store { %Statement*, i64 }* %t55, { %Statement*, i64 }** %l1
  %t56 = load %Parser, %Parser* %l0
  %t57 = call %Parser @skip_trivia(%Parser %t56)
  store %Parser %t57, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t58 = load %Parser, %Parser* %l0
  %t59 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t62 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  %t63 = bitcast { %Statement*, i64 }* %t62 to { %Statement**, i64 }*
  %t64 = insertvalue %Program undef, { %Statement**, i64 }* %t63, 0
  ret %Program %t64
}

define %StatementParseResult @parse_statement(%Parser %initial_parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %DecoratorParseResult
  %l3 = alloca { %Decorator**, i64 }*
  %l4 = alloca %Token
  %l5 = alloca double
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Parser @skip_trivia(%Parser %t1)
  store %Parser %t2, %Parser* %l0
  %t3 = load %Parser, %Parser* %l0
  %t4 = call %DecoratorParseResult @parse_decorators(%Parser %t3)
  store %DecoratorParseResult %t4, %DecoratorParseResult* %l2
  %t5 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t6 = extractvalue %DecoratorParseResult %t5, 0
  store %Parser %t6, %Parser* %l0
  %t7 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t8 = extractvalue %DecoratorParseResult %t7, 1
  store { %Decorator**, i64 }* %t8, { %Decorator**, i64 }** %l3
  %t9 = load %Parser, %Parser* %l0
  %t10 = call %Parser @skip_trivia(%Parser %t9)
  store %Parser %t10, %Parser* %l0
  %t11 = load %Parser, %Parser* %l0
  %t12 = call %Token @parser_peek_raw(%Parser %t11)
  store %Token %t12, %Token* %l4
  %t13 = load %Token, %Token* %l4
  %s14 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.14, i32 0, i32 0
  %t15 = call i1 @identifier_matches(%Token %t13, i8* %s14)
  %t16 = load %Parser, %Parser* %l0
  %t17 = load %Parser, %Parser* %l1
  %t18 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t19 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t20 = load %Token, %Token* %l4
  br i1 %t15, label %then0, label %merge1
then0:
  %t21 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t22 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t21
  %t23 = extractvalue { %Decorator**, i64 } %t22, 1
  %t24 = icmp sgt i64 %t23, 0
  %t25 = load %Parser, %Parser* %l0
  %t26 = load %Parser, %Parser* %l1
  %t27 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t28 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t29 = load %Token, %Token* %l4
  br i1 %t24, label %then2, label %merge3
then2:
  %t30 = load %Parser, %Parser* %l1
  %t31 = call %StatementParseResult @parse_unknown(%Parser %t30)
  ret %StatementParseResult %t31
merge3:
  %t32 = load %Parser, %Parser* %l0
  %t33 = call %StatementParseResult @parse_import(%Parser %t32)
  ret %StatementParseResult %t33
merge1:
  %t34 = load %Token, %Token* %l4
  %s35 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.35, i32 0, i32 0
  %t36 = call i1 @identifier_matches(%Token %t34, i8* %s35)
  %t37 = load %Parser, %Parser* %l0
  %t38 = load %Parser, %Parser* %l1
  %t39 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t40 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t41 = load %Token, %Token* %l4
  br i1 %t36, label %then4, label %merge5
then4:
  %t42 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t43 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t42
  %t44 = extractvalue { %Decorator**, i64 } %t43, 1
  %t45 = icmp sgt i64 %t44, 0
  %t46 = load %Parser, %Parser* %l0
  %t47 = load %Parser, %Parser* %l1
  %t48 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t49 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t50 = load %Token, %Token* %l4
  br i1 %t45, label %then6, label %merge7
then6:
  %t51 = load %Parser, %Parser* %l1
  %t52 = call %StatementParseResult @parse_unknown(%Parser %t51)
  ret %StatementParseResult %t52
merge7:
  %t53 = load %Parser, %Parser* %l0
  %t54 = call %StatementParseResult @parse_variable(%Parser %t53)
  ret %StatementParseResult %t54
merge5:
  %t55 = load %Token, %Token* %l4
  %s56 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.56, i32 0, i32 0
  %t57 = call i1 @identifier_matches(%Token %t55, i8* %s56)
  %t58 = load %Parser, %Parser* %l0
  %t59 = load %Parser, %Parser* %l1
  %t60 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t61 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t62 = load %Token, %Token* %l4
  br i1 %t57, label %then8, label %merge9
then8:
  %t63 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t64 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t63
  %t65 = extractvalue { %Decorator**, i64 } %t64, 1
  %t66 = icmp sgt i64 %t65, 0
  %t67 = load %Parser, %Parser* %l0
  %t68 = load %Parser, %Parser* %l1
  %t69 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t70 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t71 = load %Token, %Token* %l4
  br i1 %t66, label %then10, label %merge11
then10:
  %t72 = load %Parser, %Parser* %l1
  %t73 = call %StatementParseResult @parse_unknown(%Parser %t72)
  ret %StatementParseResult %t73
merge11:
  %t74 = load %Parser, %Parser* %l0
  %t75 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t76 = bitcast { %Decorator**, i64 }* %t75 to { %Decorator*, i64 }*
  %t77 = call %StatementParseResult @parse_model(%Parser %t74, { %Decorator*, i64 }* %t76)
  ret %StatementParseResult %t77
merge9:
  %t78 = load %Token, %Token* %l4
  %s79 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.79, i32 0, i32 0
  %t80 = call i1 @identifier_matches(%Token %t78, i8* %s79)
  %t81 = load %Parser, %Parser* %l0
  %t82 = load %Parser, %Parser* %l1
  %t83 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t84 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t85 = load %Token, %Token* %l4
  br i1 %t80, label %then12, label %merge13
then12:
  %t86 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t87 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t86
  %t88 = extractvalue { %Decorator**, i64 } %t87, 1
  %t89 = icmp sgt i64 %t88, 0
  %t90 = load %Parser, %Parser* %l0
  %t91 = load %Parser, %Parser* %l1
  %t92 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t93 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t94 = load %Token, %Token* %l4
  br i1 %t89, label %then14, label %merge15
then14:
  %t95 = load %Parser, %Parser* %l1
  %t96 = call %StatementParseResult @parse_unknown(%Parser %t95)
  ret %StatementParseResult %t96
merge15:
  %t97 = load %Parser, %Parser* %l0
  %t98 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t99 = bitcast { %Decorator**, i64 }* %t98 to { %Decorator*, i64 }*
  %t100 = call %StatementParseResult @parse_pipeline(%Parser %t97, { %Decorator*, i64 }* %t99)
  ret %StatementParseResult %t100
merge13:
  %t101 = load %Token, %Token* %l4
  %s102 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.102, i32 0, i32 0
  %t103 = call i1 @identifier_matches(%Token %t101, i8* %s102)
  %t104 = load %Parser, %Parser* %l0
  %t105 = load %Parser, %Parser* %l1
  %t106 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t107 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t108 = load %Token, %Token* %l4
  br i1 %t103, label %then16, label %merge17
then16:
  %t109 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t110 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t109
  %t111 = extractvalue { %Decorator**, i64 } %t110, 1
  %t112 = icmp sgt i64 %t111, 0
  %t113 = load %Parser, %Parser* %l0
  %t114 = load %Parser, %Parser* %l1
  %t115 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t116 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t117 = load %Token, %Token* %l4
  br i1 %t112, label %then18, label %merge19
then18:
  %t118 = load %Parser, %Parser* %l1
  %t119 = call %StatementParseResult @parse_unknown(%Parser %t118)
  ret %StatementParseResult %t119
merge19:
  %t120 = load %Parser, %Parser* %l0
  %t121 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t122 = bitcast { %Decorator**, i64 }* %t121 to { %Decorator*, i64 }*
  %t123 = call %StatementParseResult @parse_tool(%Parser %t120, { %Decorator*, i64 }* %t122)
  ret %StatementParseResult %t123
merge17:
  %t124 = load %Token, %Token* %l4
  %s125 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.125, i32 0, i32 0
  %t126 = call i1 @identifier_matches(%Token %t124, i8* %s125)
  %t127 = load %Parser, %Parser* %l0
  %t128 = load %Parser, %Parser* %l1
  %t129 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t130 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t131 = load %Token, %Token* %l4
  br i1 %t126, label %then20, label %merge21
then20:
  %t132 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t133 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t132
  %t134 = extractvalue { %Decorator**, i64 } %t133, 1
  %t135 = icmp sgt i64 %t134, 0
  %t136 = load %Parser, %Parser* %l0
  %t137 = load %Parser, %Parser* %l1
  %t138 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t139 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t140 = load %Token, %Token* %l4
  br i1 %t135, label %then22, label %merge23
then22:
  %t141 = load %Parser, %Parser* %l1
  %t142 = call %StatementParseResult @parse_unknown(%Parser %t141)
  ret %StatementParseResult %t142
merge23:
  %t143 = load %Parser, %Parser* %l0
  %t144 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t145 = bitcast { %Decorator**, i64 }* %t144 to { %Decorator*, i64 }*
  %t146 = call %StatementParseResult @parse_test(%Parser %t143, { %Decorator*, i64 }* %t145)
  ret %StatementParseResult %t146
merge21:
  %t147 = load %Token, %Token* %l4
  %s148 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.148, i32 0, i32 0
  %t149 = call i1 @identifier_matches(%Token %t147, i8* %s148)
  %t150 = load %Parser, %Parser* %l0
  %t151 = load %Parser, %Parser* %l1
  %t152 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t153 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t154 = load %Token, %Token* %l4
  br i1 %t149, label %then24, label %merge25
then24:
  %t155 = load %Parser, %Parser* %l0
  %t156 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t157 = bitcast { %Decorator**, i64 }* %t156 to { %Decorator*, i64 }*
  %t158 = call %StatementParseResult @parse_function(%Parser %t155, i1 0, { %Decorator*, i64 }* %t157)
  ret %StatementParseResult %t158
merge25:
  %t159 = load %Token, %Token* %l4
  %s160 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.160, i32 0, i32 0
  %t161 = call i1 @identifier_matches(%Token %t159, i8* %s160)
  %t162 = load %Parser, %Parser* %l0
  %t163 = load %Parser, %Parser* %l1
  %t164 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t165 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t166 = load %Token, %Token* %l4
  br i1 %t161, label %then26, label %merge27
then26:
  %t167 = load %Token, %Token* %l4
  %s168 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.168, i32 0, i32 0
  %t169 = call i1 @identifier_matches(%Token %t167, i8* %s168)
  %t170 = load %Parser, %Parser* %l0
  %t171 = load %Parser, %Parser* %l1
  %t172 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t173 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t174 = load %Token, %Token* %l4
  br i1 %t169, label %then28, label %merge29
then28:
  br label %merge29
merge29:
  %t175 = load %Token, %Token* %l4
  %s176 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.176, i32 0, i32 0
  %t177 = call i1 @identifier_matches(%Token %t175, i8* %s176)
  %t178 = load %Parser, %Parser* %l0
  %t179 = load %Parser, %Parser* %l1
  %t180 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t181 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t182 = load %Token, %Token* %l4
  br i1 %t177, label %then30, label %merge31
then30:
  %t183 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t184 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t183
  %t185 = extractvalue { %Decorator**, i64 } %t184, 1
  %t186 = icmp sgt i64 %t185, 0
  %t187 = load %Parser, %Parser* %l0
  %t188 = load %Parser, %Parser* %l1
  %t189 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t190 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t191 = load %Token, %Token* %l4
  br i1 %t186, label %then32, label %merge33
then32:
  %t192 = load %Parser, %Parser* %l1
  %t193 = insertvalue %BlockStatementParseResult undef, %Parser %t192, 0
  %t194 = bitcast i8* null to %Statement*
  %t195 = insertvalue %BlockStatementParseResult %t193, %Statement* %t194, 1
  %t196 = insertvalue %BlockStatementParseResult %t195, i1 0, 2
  ret %StatementParseResult zeroinitializer
merge33:
  ret %StatementParseResult zeroinitializer
merge31:
  %t197 = load %Token, %Token* %l4
  %s198 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.198, i32 0, i32 0
  %t199 = call i1 @identifier_matches(%Token %t197, i8* %s198)
  %t200 = load %Parser, %Parser* %l0
  %t201 = load %Parser, %Parser* %l1
  %t202 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t203 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t204 = load %Token, %Token* %l4
  br i1 %t199, label %then34, label %merge35
then34:
  %t205 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t206 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t205
  %t207 = extractvalue { %Decorator**, i64 } %t206, 1
  %t208 = icmp sgt i64 %t207, 0
  %t209 = load %Parser, %Parser* %l0
  %t210 = load %Parser, %Parser* %l1
  %t211 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t212 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t213 = load %Token, %Token* %l4
  br i1 %t208, label %then36, label %merge37
then36:
  %t214 = load %Parser, %Parser* %l1
  %t215 = insertvalue %BlockStatementParseResult undef, %Parser %t214, 0
  %t216 = bitcast i8* null to %Statement*
  %t217 = insertvalue %BlockStatementParseResult %t215, %Statement* %t216, 1
  %t218 = insertvalue %BlockStatementParseResult %t217, i1 0, 2
  ret %StatementParseResult zeroinitializer
merge37:
  ret %StatementParseResult zeroinitializer
merge35:
  store double 0.0, double* %l5
  %t219 = load double, double* %l5
  %s220 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.220, i32 0, i32 0
  %t221 = call i1 @identifier_matches(%Token zeroinitializer, i8* %s220)
  %t222 = load %Parser, %Parser* %l0
  %t223 = load %Parser, %Parser* %l1
  %t224 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t225 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t226 = load %Token, %Token* %l4
  %t227 = load double, double* %l5
  br i1 %t221, label %then38, label %merge39
then38:
  %t228 = load %Parser, %Parser* %l0
  %t229 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t230 = bitcast { %Decorator**, i64 }* %t229 to { %Decorator*, i64 }*
  %t231 = call %StatementParseResult @parse_function(%Parser %t228, i1 1, { %Decorator*, i64 }* %t230)
  ret %StatementParseResult %t231
merge39:
  br label %merge27
merge27:
  %t232 = load %Token, %Token* %l4
  %s233 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.233, i32 0, i32 0
  %t234 = call i1 @identifier_matches(%Token %t232, i8* %s233)
  %t235 = load %Parser, %Parser* %l0
  %t236 = load %Parser, %Parser* %l1
  %t237 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t238 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t239 = load %Token, %Token* %l4
  br i1 %t234, label %then40, label %merge41
then40:
  %t240 = load %Parser, %Parser* %l0
  %t241 = call %StatementParseResult @parse_import(%Parser %t240)
  ret %StatementParseResult %t241
merge41:
  %t242 = load %Token, %Token* %l4
  %s243 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.243, i32 0, i32 0
  %t244 = call i1 @identifier_matches(%Token %t242, i8* %s243)
  %t245 = load %Parser, %Parser* %l0
  %t246 = load %Parser, %Parser* %l1
  %t247 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t248 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t249 = load %Token, %Token* %l4
  br i1 %t244, label %then42, label %merge43
then42:
  %t250 = load %Parser, %Parser* %l0
  %t251 = call %StatementParseResult @parse_export(%Parser %t250)
  ret %StatementParseResult %t251
merge43:
  %t252 = load %Token, %Token* %l4
  %s253 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.253, i32 0, i32 0
  %t254 = call i1 @identifier_matches(%Token %t252, i8* %s253)
  %t255 = load %Parser, %Parser* %l0
  %t256 = load %Parser, %Parser* %l1
  %t257 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t258 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t259 = load %Token, %Token* %l4
  br i1 %t254, label %then44, label %merge45
then44:
  %t260 = load %Parser, %Parser* %l0
  %t261 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t262 = bitcast { %Decorator**, i64 }* %t261 to { %Decorator*, i64 }*
  %t263 = call %StatementParseResult @parse_struct(%Parser %t260, { %Decorator*, i64 }* %t262)
  ret %StatementParseResult %t263
merge45:
  %t264 = load %Token, %Token* %l4
  %s265 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.265, i32 0, i32 0
  %t266 = call i1 @identifier_matches(%Token %t264, i8* %s265)
  %t267 = load %Parser, %Parser* %l0
  %t268 = load %Parser, %Parser* %l1
  %t269 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t270 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t271 = load %Token, %Token* %l4
  br i1 %t266, label %then46, label %merge47
then46:
  %t272 = load %Parser, %Parser* %l0
  %t273 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t274 = bitcast { %Decorator**, i64 }* %t273 to { %Decorator*, i64 }*
  %t275 = call %StatementParseResult @parse_type_alias(%Parser %t272, { %Decorator*, i64 }* %t274)
  ret %StatementParseResult %t275
merge47:
  %t276 = load %Token, %Token* %l4
  %s277 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.277, i32 0, i32 0
  %t278 = call i1 @identifier_matches(%Token %t276, i8* %s277)
  %t279 = load %Parser, %Parser* %l0
  %t280 = load %Parser, %Parser* %l1
  %t281 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t282 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t283 = load %Token, %Token* %l4
  br i1 %t278, label %then48, label %merge49
then48:
  %t284 = load %Parser, %Parser* %l0
  %t285 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t286 = bitcast { %Decorator**, i64 }* %t285 to { %Decorator*, i64 }*
  %t287 = call %StatementParseResult @parse_interface(%Parser %t284, { %Decorator*, i64 }* %t286)
  ret %StatementParseResult %t287
merge49:
  %t288 = load %Token, %Token* %l4
  %s289 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.289, i32 0, i32 0
  %t290 = call i1 @identifier_matches(%Token %t288, i8* %s289)
  %t291 = load %Parser, %Parser* %l0
  %t292 = load %Parser, %Parser* %l1
  %t293 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t294 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t295 = load %Token, %Token* %l4
  br i1 %t290, label %then50, label %merge51
then50:
  %t296 = load %Parser, %Parser* %l0
  %t297 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t298 = bitcast { %Decorator**, i64 }* %t297 to { %Decorator*, i64 }*
  %t299 = call %StatementParseResult @parse_enum(%Parser %t296, { %Decorator*, i64 }* %t298)
  ret %StatementParseResult %t299
merge51:
  %t300 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t301 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t300
  %t302 = extractvalue { %Decorator**, i64 } %t301, 1
  %t303 = icmp sgt i64 %t302, 0
  %t304 = load %Parser, %Parser* %l0
  %t305 = load %Parser, %Parser* %l1
  %t306 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t307 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t308 = load %Token, %Token* %l4
  br i1 %t303, label %then52, label %merge53
then52:
  %t309 = load %Parser, %Parser* %l1
  %t310 = call %StatementParseResult @parse_unknown(%Parser %t309)
  ret %StatementParseResult %t310
merge53:
  %t311 = load %Parser, %Parser* %l0
  %t312 = call %StatementParseResult @parse_unknown(%Parser %t311)
  ret %StatementParseResult %t312
}

define %StatementParseResult @parse_import(%Parser %initial_parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %SpecifierListParseResult
  %l2 = alloca { %ImportSpecifier*, i64 }*
  %l3 = alloca %CaptureResult
  %l4 = alloca i8*
  %l5 = alloca %Statement
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  %t1 = call %Parser @skip_trivia(%Parser %t0)
  store %Parser %t1, %Parser* %l0
  %t2 = load %Parser, %Parser* %l0
  %s3 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.3, i32 0, i32 0
  %t4 = call %Parser @consume_keyword(%Parser %t2, i8* %s3)
  store %Parser %t4, %Parser* %l0
  %t5 = load %Parser, %Parser* %l0
  %t6 = call %SpecifierListParseResult @parse_specifier_list(%Parser %t5)
  store %SpecifierListParseResult %t6, %SpecifierListParseResult* %l1
  %t7 = load %SpecifierListParseResult, %SpecifierListParseResult* %l1
  %t8 = extractvalue %SpecifierListParseResult %t7, 0
  store %Parser %t8, %Parser* %l0
  %t9 = load %SpecifierListParseResult, %SpecifierListParseResult* %l1
  %t10 = extractvalue %SpecifierListParseResult %t9, 1
  %t11 = bitcast { %NamedSpecifier**, i64 }* %t10 to { %NamedSpecifier*, i64 }*
  %t12 = call { %ImportSpecifier*, i64 }* @build_import_specifiers({ %NamedSpecifier*, i64 }* %t11)
  store { %ImportSpecifier*, i64 }* %t12, { %ImportSpecifier*, i64 }** %l2
  %t13 = load %Parser, %Parser* %l0
  %t14 = call %Parser @skip_trivia(%Parser %t13)
  store %Parser %t14, %Parser* %l0
  %t15 = load %Parser, %Parser* %l0
  %s16 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.16, i32 0, i32 0
  %t17 = call %Parser @consume_keyword(%Parser %t15, i8* %s16)
  store %Parser %t17, %Parser* %l0
  %t18 = load %Parser, %Parser* %l0
  %t19 = call %Parser @skip_trivia(%Parser %t18)
  store %Parser %t19, %Parser* %l0
  %t20 = load %Parser, %Parser* %l0
  %t21 = alloca [1 x i8]
  %t22 = getelementptr [1 x i8], [1 x i8]* %t21, i32 0, i32 0
  %t23 = getelementptr i8, i8* %t22, i64 0
  store i8 59, i8* %t23
  %t24 = alloca { i8*, i64 }
  %t25 = getelementptr { i8*, i64 }, { i8*, i64 }* %t24, i32 0, i32 0
  store i8* %t22, i8** %t25
  %t26 = getelementptr { i8*, i64 }, { i8*, i64 }* %t24, i32 0, i32 1
  store i64 1, i64* %t26
  %t27 = bitcast { i8*, i64 }* %t24 to { i8**, i64 }*
  %t28 = call %CaptureResult @collect_until(%Parser %t20, { i8**, i64 }* %t27)
  store %CaptureResult %t28, %CaptureResult* %l3
  %t29 = load %CaptureResult, %CaptureResult* %l3
  %t30 = extractvalue %CaptureResult %t29, 0
  store %Parser %t30, %Parser* %l0
  %t31 = load %CaptureResult, %CaptureResult* %l3
  %t32 = extractvalue %CaptureResult %t31, 1
  %t33 = bitcast { %Token**, i64 }* %t32 to { %Token*, i64 }*
  %t34 = call i8* @tokens_to_text({ %Token*, i64 }* %t33)
  %t35 = call i8* @trim_text(i8* %t34)
  store i8* %t35, i8** %l4
  %t36 = load i8*, i8** %l4
  %t37 = call i8* @strip_surrounding_quotes(i8* %t36)
  store i8* %t37, i8** %l4
  %t38 = load %Parser, %Parser* %l0
  %t39 = call %Parser @skip_trivia(%Parser %t38)
  store %Parser %t39, %Parser* %l0
  %t41 = load %Parser, %Parser* %l0
  %t42 = call %Token @parser_peek_raw(%Parser %t41)
  %t43 = extractvalue %Token %t42, 0
  %t44 = extractvalue %TokenKind %t43, 0
  %t45 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t46 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t47 = icmp eq i32 %t44, 0
  %t48 = select i1 %t47, i8* %t46, i8* %t45
  %t49 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t50 = icmp eq i32 %t44, 1
  %t51 = select i1 %t50, i8* %t49, i8* %t48
  %t52 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t53 = icmp eq i32 %t44, 2
  %t54 = select i1 %t53, i8* %t52, i8* %t51
  %t55 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t44, 3
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t44, 4
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t44, 5
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t44, 6
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t44, 7
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %s70 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.70, i32 0, i32 0
  %t71 = icmp eq i8* %t69, %s70
  br label %logical_and_entry_40

logical_and_entry_40:
  br i1 %t71, label %logical_and_right_40, label %logical_and_merge_40

logical_and_right_40:
  %t72 = load %Parser, %Parser* %l0
  %t73 = call %Token @parser_peek_raw(%Parser %t72)
  %t74 = extractvalue %Token %t73, 0
  %t75 = extractvalue %TokenKind %t74, 0
  %t76 = alloca %Statement
  %t77 = getelementptr inbounds %Statement, %Statement* %t76, i32 0, i32 0
  store i32 0, i32* %t77
  %t78 = load { %ImportSpecifier*, i64 }*, { %ImportSpecifier*, i64 }** %l2
  %t79 = bitcast { %ImportSpecifier*, i64 }* %t78 to { %ImportSpecifier**, i64 }*
  %t80 = getelementptr inbounds %Statement, %Statement* %t76, i32 0, i32 1
  %t81 = bitcast [16 x i8]* %t80 to i8*
  %t82 = bitcast i8* %t81 to { %ImportSpecifier**, i64 }**
  store { %ImportSpecifier**, i64 }* %t79, { %ImportSpecifier**, i64 }** %t82
  %t83 = load i8*, i8** %l4
  %t84 = getelementptr inbounds %Statement, %Statement* %t76, i32 0, i32 1
  %t85 = bitcast [16 x i8]* %t84 to i8*
  %t86 = getelementptr inbounds i8, i8* %t85, i64 8
  %t87 = bitcast i8* %t86 to i8**
  store i8* %t83, i8** %t87
  %t88 = load %Statement, %Statement* %t76
  store %Statement %t88, %Statement* %l5
  %t89 = load %Parser, %Parser* %l0
  %t90 = insertvalue %StatementParseResult undef, %Parser %t89, 0
  %t91 = load %Statement, %Statement* %l5
  %t92 = insertvalue %StatementParseResult %t90, %Statement %t91, 1
  ret %StatementParseResult %t92
}

define %StatementParseResult @parse_export(%Parser %initial_parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %SpecifierListParseResult
  %l2 = alloca { %ExportSpecifier*, i64 }*
  %l3 = alloca %CaptureResult
  %l4 = alloca i8*
  %l5 = alloca %Statement
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  %t1 = call %Parser @skip_trivia(%Parser %t0)
  store %Parser %t1, %Parser* %l0
  %t2 = load %Parser, %Parser* %l0
  %s3 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.3, i32 0, i32 0
  %t4 = call %Parser @consume_keyword(%Parser %t2, i8* %s3)
  store %Parser %t4, %Parser* %l0
  %t5 = load %Parser, %Parser* %l0
  %t6 = call %SpecifierListParseResult @parse_specifier_list(%Parser %t5)
  store %SpecifierListParseResult %t6, %SpecifierListParseResult* %l1
  %t7 = load %SpecifierListParseResult, %SpecifierListParseResult* %l1
  %t8 = extractvalue %SpecifierListParseResult %t7, 0
  store %Parser %t8, %Parser* %l0
  %t9 = load %SpecifierListParseResult, %SpecifierListParseResult* %l1
  %t10 = extractvalue %SpecifierListParseResult %t9, 1
  %t11 = bitcast { %NamedSpecifier**, i64 }* %t10 to { %NamedSpecifier*, i64 }*
  %t12 = call { %ExportSpecifier*, i64 }* @build_export_specifiers({ %NamedSpecifier*, i64 }* %t11)
  store { %ExportSpecifier*, i64 }* %t12, { %ExportSpecifier*, i64 }** %l2
  %t13 = load %Parser, %Parser* %l0
  %t14 = call %Parser @skip_trivia(%Parser %t13)
  store %Parser %t14, %Parser* %l0
  %t15 = load %Parser, %Parser* %l0
  %s16 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.16, i32 0, i32 0
  %t17 = call %Parser @consume_keyword(%Parser %t15, i8* %s16)
  store %Parser %t17, %Parser* %l0
  %t18 = load %Parser, %Parser* %l0
  %t19 = call %Parser @skip_trivia(%Parser %t18)
  store %Parser %t19, %Parser* %l0
  %t20 = load %Parser, %Parser* %l0
  %t21 = alloca [1 x i8]
  %t22 = getelementptr [1 x i8], [1 x i8]* %t21, i32 0, i32 0
  %t23 = getelementptr i8, i8* %t22, i64 0
  store i8 59, i8* %t23
  %t24 = alloca { i8*, i64 }
  %t25 = getelementptr { i8*, i64 }, { i8*, i64 }* %t24, i32 0, i32 0
  store i8* %t22, i8** %t25
  %t26 = getelementptr { i8*, i64 }, { i8*, i64 }* %t24, i32 0, i32 1
  store i64 1, i64* %t26
  %t27 = bitcast { i8*, i64 }* %t24 to { i8**, i64 }*
  %t28 = call %CaptureResult @collect_until(%Parser %t20, { i8**, i64 }* %t27)
  store %CaptureResult %t28, %CaptureResult* %l3
  %t29 = load %CaptureResult, %CaptureResult* %l3
  %t30 = extractvalue %CaptureResult %t29, 0
  store %Parser %t30, %Parser* %l0
  %t31 = load %CaptureResult, %CaptureResult* %l3
  %t32 = extractvalue %CaptureResult %t31, 1
  %t33 = bitcast { %Token**, i64 }* %t32 to { %Token*, i64 }*
  %t34 = call i8* @tokens_to_text({ %Token*, i64 }* %t33)
  %t35 = call i8* @trim_text(i8* %t34)
  store i8* %t35, i8** %l4
  %t36 = load i8*, i8** %l4
  %t37 = call i8* @strip_surrounding_quotes(i8* %t36)
  store i8* %t37, i8** %l4
  %t38 = load %Parser, %Parser* %l0
  %t39 = call %Parser @skip_trivia(%Parser %t38)
  store %Parser %t39, %Parser* %l0
  %t41 = load %Parser, %Parser* %l0
  %t42 = call %Token @parser_peek_raw(%Parser %t41)
  %t43 = extractvalue %Token %t42, 0
  %t44 = extractvalue %TokenKind %t43, 0
  %t45 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t46 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t47 = icmp eq i32 %t44, 0
  %t48 = select i1 %t47, i8* %t46, i8* %t45
  %t49 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t50 = icmp eq i32 %t44, 1
  %t51 = select i1 %t50, i8* %t49, i8* %t48
  %t52 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t53 = icmp eq i32 %t44, 2
  %t54 = select i1 %t53, i8* %t52, i8* %t51
  %t55 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t44, 3
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t44, 4
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t44, 5
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t44, 6
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t44, 7
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %s70 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.70, i32 0, i32 0
  %t71 = icmp eq i8* %t69, %s70
  br label %logical_and_entry_40

logical_and_entry_40:
  br i1 %t71, label %logical_and_right_40, label %logical_and_merge_40

logical_and_right_40:
  %t72 = load %Parser, %Parser* %l0
  %t73 = call %Token @parser_peek_raw(%Parser %t72)
  %t74 = extractvalue %Token %t73, 0
  %t75 = extractvalue %TokenKind %t74, 0
  %t76 = alloca %Statement
  %t77 = getelementptr inbounds %Statement, %Statement* %t76, i32 0, i32 0
  store i32 1, i32* %t77
  %t78 = load { %ExportSpecifier*, i64 }*, { %ExportSpecifier*, i64 }** %l2
  %t79 = bitcast { %ExportSpecifier*, i64 }* %t78 to { %ExportSpecifier**, i64 }*
  %t80 = getelementptr inbounds %Statement, %Statement* %t76, i32 0, i32 1
  %t81 = bitcast [16 x i8]* %t80 to i8*
  %t82 = bitcast i8* %t81 to { %ExportSpecifier**, i64 }**
  store { %ExportSpecifier**, i64 }* %t79, { %ExportSpecifier**, i64 }** %t82
  %t83 = load i8*, i8** %l4
  %t84 = getelementptr inbounds %Statement, %Statement* %t76, i32 0, i32 1
  %t85 = bitcast [16 x i8]* %t84 to i8*
  %t86 = getelementptr inbounds i8, i8* %t85, i64 8
  %t87 = bitcast i8* %t86 to i8**
  store i8* %t83, i8** %t87
  %t88 = load %Statement, %Statement* %t76
  store %Statement %t88, %Statement* %l5
  %t89 = load %Parser, %Parser* %l0
  %t90 = insertvalue %StatementParseResult undef, %Parser %t89, 0
  %t91 = load %Statement, %Statement* %l5
  %t92 = insertvalue %StatementParseResult %t90, %Statement %t91, 1
  ret %StatementParseResult %t92
}

define %StatementParseResult @parse_variable(%Parser %initial_parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca { %Token*, i64 }*
  %l2 = alloca %Token
  %l3 = alloca i1
  %l4 = alloca %Token
  %l5 = alloca %Token
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca %Token
  %l9 = alloca i8*
  %l10 = alloca i8*
  %l11 = alloca %Token
  %l12 = alloca %Token
  %l13 = alloca double
  %l14 = alloca %Statement
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  %t1 = call %Parser @skip_trivia(%Parser %t0)
  store %Parser %t1, %Parser* %l0
  %t2 = alloca [0 x %Token]
  %t3 = getelementptr [0 x %Token], [0 x %Token]* %t2, i32 0, i32 0
  %t4 = alloca { %Token*, i64 }
  %t5 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t4, i32 0, i32 0
  store %Token* %t3, %Token** %t5
  %t6 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  store { %Token*, i64 }* %t4, { %Token*, i64 }** %l1
  %t7 = load %Parser, %Parser* %l0
  %t8 = call %Token @parser_peek_raw(%Parser %t7)
  store %Token %t8, %Token* %l2
  %t9 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t10 = load %Token, %Token* %l2
  %t11 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t9, %Token %t10)
  store { %Token*, i64 }* %t11, { %Token*, i64 }** %l1
  %t12 = load %Parser, %Parser* %l0
  %s13 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.13, i32 0, i32 0
  %t14 = call %Parser @consume_keyword(%Parser %t12, i8* %s13)
  store %Parser %t14, %Parser* %l0
  store i1 0, i1* %l3
  %t15 = load %Parser, %Parser* %l0
  %t16 = call %Parser @skip_trivia(%Parser %t15)
  store %Parser %t16, %Parser* %l0
  %t17 = load %Parser, %Parser* %l0
  %t18 = call %Token @parser_peek_raw(%Parser %t17)
  store %Token %t18, %Token* %l4
  %t19 = load %Token, %Token* %l4
  %s20 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.20, i32 0, i32 0
  %t21 = call i1 @identifier_matches(%Token %t19, i8* %s20)
  %t22 = load %Parser, %Parser* %l0
  %t23 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t24 = load %Token, %Token* %l2
  %t25 = load i1, i1* %l3
  %t26 = load %Token, %Token* %l4
  br i1 %t21, label %then0, label %merge1
then0:
  %t27 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t28 = load %Token, %Token* %l4
  %t29 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t27, %Token %t28)
  store { %Token*, i64 }* %t29, { %Token*, i64 }** %l1
  %t30 = load %Parser, %Parser* %l0
  %s31 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.31, i32 0, i32 0
  %t32 = call %Parser @consume_keyword(%Parser %t30, i8* %s31)
  store %Parser %t32, %Parser* %l0
  store i1 1, i1* %l3
  br label %merge1
merge1:
  %t33 = phi { %Token*, i64 }* [ %t29, %then0 ], [ %t23, %entry ]
  %t34 = phi %Parser [ %t32, %then0 ], [ %t22, %entry ]
  %t35 = phi i1 [ 1, %then0 ], [ %t25, %entry ]
  store { %Token*, i64 }* %t33, { %Token*, i64 }** %l1
  store %Parser %t34, %Parser* %l0
  store i1 %t35, i1* %l3
  %t36 = load %Parser, %Parser* %l0
  %t37 = call %Parser @skip_trivia(%Parser %t36)
  store %Parser %t37, %Parser* %l0
  %t38 = load %Parser, %Parser* %l0
  %t39 = call %Token @parser_peek_raw(%Parser %t38)
  store %Token %t39, %Token* %l5
  %t40 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t41 = load %Token, %Token* %l5
  %t42 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t40, %Token %t41)
  store { %Token*, i64 }* %t42, { %Token*, i64 }** %l1
  %t43 = load %Token, %Token* %l5
  %t44 = call i8* @identifier_text(%Token %t43)
  store i8* %t44, i8** %l6
  %t45 = load %Parser, %Parser* %l0
  %t46 = call %Parser @parser_advance_raw(%Parser %t45)
  store %Parser %t46, %Parser* %l0
  store i8* null, i8** %l7
  %t47 = load %Parser, %Parser* %l0
  %t48 = call %Parser @skip_trivia(%Parser %t47)
  store %Parser %t48, %Parser* %l0
  %t49 = load %Parser, %Parser* %l0
  %t50 = call %Token @parser_peek_raw(%Parser %t49)
  store %Token %t50, %Token* %l8
  %t53 = load %Token, %Token* %l8
  %t54 = extractvalue %Token %t53, 0
  %t55 = extractvalue %TokenKind %t54, 0
  %t56 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t57 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t58 = icmp eq i32 %t55, 0
  %t59 = select i1 %t58, i8* %t57, i8* %t56
  %t60 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t61 = icmp eq i32 %t55, 1
  %t62 = select i1 %t61, i8* %t60, i8* %t59
  %t63 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t55, 2
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t55, 3
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t55, 4
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t55, 5
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t55, 6
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t55, 7
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %s81 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.81, i32 0, i32 0
  %t82 = icmp eq i8* %t80, %s81
  br label %logical_and_entry_52

logical_and_entry_52:
  br i1 %t82, label %logical_and_right_52, label %logical_and_merge_52

logical_and_right_52:
  %t83 = load %Token, %Token* %l8
  %t84 = extractvalue %Token %t83, 0
  %t85 = extractvalue %TokenKind %t84, 0
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  %t86 = load %Parser, %Parser* %l0
  %t87 = call %Parser @skip_trivia(%Parser %t86)
  store %Parser %t87, %Parser* %l0
  %t88 = load %Parser, %Parser* %l0
  %t89 = call %Token @parser_peek_raw(%Parser %t88)
  store %Token %t89, %Token* %l11
  %t91 = load %Token, %Token* %l11
  %t92 = extractvalue %Token %t91, 0
  %t93 = extractvalue %TokenKind %t92, 0
  %t94 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t95 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t93, 0
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %t98 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t93, 1
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t93, 2
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t93, 3
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t93, 4
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t93, 5
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t93, 6
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %t116 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t93, 7
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %s119 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.119, i32 0, i32 0
  %t120 = icmp eq i8* %t118, %s119
  br label %logical_and_entry_90

logical_and_entry_90:
  br i1 %t120, label %logical_and_right_90, label %logical_and_merge_90

logical_and_right_90:
  %t121 = load %Token, %Token* %l11
  %t122 = extractvalue %Token %t121, 0
  %t123 = extractvalue %TokenKind %t122, 0
  %t124 = load %Parser, %Parser* %l0
  %t125 = call %Parser @skip_trivia(%Parser %t124)
  store %Parser %t125, %Parser* %l0
  %t126 = load %Parser, %Parser* %l0
  %t127 = call %Token @parser_peek_raw(%Parser %t126)
  store %Token %t127, %Token* %l12
  %t129 = load %Token, %Token* %l12
  %t130 = extractvalue %Token %t129, 0
  %t131 = extractvalue %TokenKind %t130, 0
  %t132 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t133 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t134 = icmp eq i32 %t131, 0
  %t135 = select i1 %t134, i8* %t133, i8* %t132
  %t136 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t131, 1
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t131, 2
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t131, 3
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t131, 4
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t131, 5
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t131, 6
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t131, 7
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %s157 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.157, i32 0, i32 0
  %t158 = icmp eq i8* %t156, %s157
  br label %logical_and_entry_128

logical_and_entry_128:
  br i1 %t158, label %logical_and_right_128, label %logical_and_merge_128

logical_and_right_128:
  %t159 = load %Token, %Token* %l12
  %t160 = extractvalue %Token %t159, 0
  %t161 = extractvalue %TokenKind %t160, 0
  %t162 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t163 = call double @source_span_from_tokens({ %Token*, i64 }* %t162)
  store double %t163, double* %l13
  %t164 = alloca %Statement
  %t165 = getelementptr inbounds %Statement, %Statement* %t164, i32 0, i32 0
  store i32 2, i32* %t165
  %t166 = load i8*, i8** %l6
  %t167 = getelementptr inbounds %Statement, %Statement* %t164, i32 0, i32 1
  %t168 = bitcast [48 x i8]* %t167 to i8*
  %t169 = bitcast i8* %t168 to i8**
  store i8* %t166, i8** %t169
  %t170 = load i1, i1* %l3
  %t171 = getelementptr inbounds %Statement, %Statement* %t164, i32 0, i32 1
  %t172 = bitcast [48 x i8]* %t171 to i8*
  %t173 = getelementptr inbounds i8, i8* %t172, i64 8
  %t174 = bitcast i8* %t173 to i1*
  store i1 %t170, i1* %t174
  %t175 = load i8*, i8** %l7
  %t176 = bitcast i8* %t175 to %TypeAnnotation*
  %t177 = getelementptr inbounds %Statement, %Statement* %t164, i32 0, i32 1
  %t178 = bitcast [48 x i8]* %t177 to i8*
  %t179 = getelementptr inbounds i8, i8* %t178, i64 16
  %t180 = bitcast i8* %t179 to %TypeAnnotation**
  store %TypeAnnotation* %t176, %TypeAnnotation** %t180
  %t181 = load i8*, i8** %l9
  %t182 = bitcast i8* %t181 to %Expression*
  %t183 = getelementptr inbounds %Statement, %Statement* %t164, i32 0, i32 1
  %t184 = bitcast [48 x i8]* %t183 to i8*
  %t185 = getelementptr inbounds i8, i8* %t184, i64 24
  %t186 = bitcast i8* %t185 to %Expression**
  store %Expression* %t182, %Expression** %t186
  %t187 = load double, double* %l13
  %t188 = call noalias i8* @malloc(i64 8)
  %t189 = bitcast i8* %t188 to double*
  store double %t187, double* %t189
  %t190 = bitcast i8* %t188 to %SourceSpan*
  %t191 = getelementptr inbounds %Statement, %Statement* %t164, i32 0, i32 1
  %t192 = bitcast [48 x i8]* %t191 to i8*
  %t193 = getelementptr inbounds i8, i8* %t192, i64 32
  %t194 = bitcast i8* %t193 to %SourceSpan**
  store %SourceSpan* %t190, %SourceSpan** %t194
  %t195 = load i8*, i8** %l10
  %t196 = bitcast i8* %t195 to %SourceSpan*
  %t197 = getelementptr inbounds %Statement, %Statement* %t164, i32 0, i32 1
  %t198 = bitcast [48 x i8]* %t197 to i8*
  %t199 = getelementptr inbounds i8, i8* %t198, i64 40
  %t200 = bitcast i8* %t199 to %SourceSpan**
  store %SourceSpan* %t196, %SourceSpan** %t200
  %t201 = load %Statement, %Statement* %t164
  store %Statement %t201, %Statement* %l14
  %t202 = load %Parser, %Parser* %l0
  %t203 = insertvalue %StatementParseResult undef, %Parser %t202, 0
  %t204 = load %Statement, %Statement* %l14
  %t205 = insertvalue %StatementParseResult %t203, %Statement %t204, 1
  ret %StatementParseResult %t205
}

define %SpecifierListParseResult @parse_specifier_list(%Parser %initial_parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca { %NamedSpecifier*, i64 }*
  %l2 = alloca %Token
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca %Token
  %l6 = alloca %Token
  %l7 = alloca %Token
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  %t1 = call %Parser @skip_trivia(%Parser %t0)
  store %Parser %t1, %Parser* %l0
  %t2 = load %Parser, %Parser* %l0
  %t3 = alloca [2 x i8], align 1
  %t4 = getelementptr [2 x i8], [2 x i8]* %t3, i32 0, i32 0
  store i8 123, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t3, i32 0, i32 1
  store i8 0, i8* %t5
  %t6 = getelementptr [2 x i8], [2 x i8]* %t3, i32 0, i32 0
  %t7 = call %Parser @consume_symbol(%Parser %t2, i8* %t6)
  store %Parser %t7, %Parser* %l0
  %t8 = alloca [0 x %NamedSpecifier]
  %t9 = getelementptr [0 x %NamedSpecifier], [0 x %NamedSpecifier]* %t8, i32 0, i32 0
  %t10 = alloca { %NamedSpecifier*, i64 }
  %t11 = getelementptr { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %t10, i32 0, i32 0
  store %NamedSpecifier* %t9, %NamedSpecifier** %t11
  %t12 = getelementptr { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { %NamedSpecifier*, i64 }* %t10, { %NamedSpecifier*, i64 }** %l1
  %t13 = load %Parser, %Parser* %l0
  %t14 = call %Parser @skip_trivia(%Parser %t13)
  store %Parser %t14, %Parser* %l0
  %t15 = load %Parser, %Parser* %l0
  %t16 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t214 = phi %Parser [ %t15, %entry ], [ %t212, %loop.latch2 ]
  %t215 = phi { %NamedSpecifier*, i64 }* [ %t16, %entry ], [ %t213, %loop.latch2 ]
  store %Parser %t214, %Parser* %l0
  store { %NamedSpecifier*, i64 }* %t215, { %NamedSpecifier*, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t17 = load %Parser, %Parser* %l0
  %t18 = call %Token @parser_peek_raw(%Parser %t17)
  store %Token %t18, %Token* %l2
  %t20 = load %Token, %Token* %l2
  %t21 = extractvalue %Token %t20, 0
  %t22 = extractvalue %TokenKind %t21, 0
  %t23 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t24 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t22, 0
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %t27 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t28 = icmp eq i32 %t22, 1
  %t29 = select i1 %t28, i8* %t27, i8* %t26
  %t30 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t31 = icmp eq i32 %t22, 2
  %t32 = select i1 %t31, i8* %t30, i8* %t29
  %t33 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t34 = icmp eq i32 %t22, 3
  %t35 = select i1 %t34, i8* %t33, i8* %t32
  %t36 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t37 = icmp eq i32 %t22, 4
  %t38 = select i1 %t37, i8* %t36, i8* %t35
  %t39 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t40 = icmp eq i32 %t22, 5
  %t41 = select i1 %t40, i8* %t39, i8* %t38
  %t42 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t43 = icmp eq i32 %t22, 6
  %t44 = select i1 %t43, i8* %t42, i8* %t41
  %t45 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t46 = icmp eq i32 %t22, 7
  %t47 = select i1 %t46, i8* %t45, i8* %t44
  %s48 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.48, i32 0, i32 0
  %t49 = icmp eq i8* %t47, %s48
  br label %logical_and_entry_19

logical_and_entry_19:
  br i1 %t49, label %logical_and_right_19, label %logical_and_merge_19

logical_and_right_19:
  %t50 = load %Token, %Token* %l2
  %t51 = extractvalue %Token %t50, 0
  %t52 = extractvalue %TokenKind %t51, 0
  %t53 = load %Token, %Token* %l2
  %t54 = extractvalue %Token %t53, 0
  %t55 = extractvalue %TokenKind %t54, 0
  %t56 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t57 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t58 = icmp eq i32 %t55, 0
  %t59 = select i1 %t58, i8* %t57, i8* %t56
  %t60 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t61 = icmp eq i32 %t55, 1
  %t62 = select i1 %t61, i8* %t60, i8* %t59
  %t63 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t55, 2
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t55, 3
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t55, 4
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t55, 5
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t55, 6
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t55, 7
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %s81 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.81, i32 0, i32 0
  %t82 = icmp ne i8* %t80, %s81
  %t83 = load %Parser, %Parser* %l0
  %t84 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l1
  %t85 = load %Token, %Token* %l2
  br i1 %t82, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t86 = load %Token, %Token* %l2
  %t87 = call i8* @identifier_text(%Token %t86)
  store i8* %t87, i8** %l3
  %t88 = load %Parser, %Parser* %l0
  %t89 = call %Parser @parser_advance_raw(%Parser %t88)
  store %Parser %t89, %Parser* %l0
  %t90 = load %Parser, %Parser* %l0
  %t91 = call %Parser @skip_trivia(%Parser %t90)
  store %Parser %t91, %Parser* %l0
  store i8* null, i8** %l4
  %t92 = load %Parser, %Parser* %l0
  %t93 = call %Token @parser_peek_raw(%Parser %t92)
  store %Token %t93, %Token* %l5
  %t94 = load %Token, %Token* %l5
  %s95 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.95, i32 0, i32 0
  %t96 = call i1 @identifier_matches(%Token %t94, i8* %s95)
  %t97 = load %Parser, %Parser* %l0
  %t98 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l1
  %t99 = load %Token, %Token* %l2
  %t100 = load i8*, i8** %l3
  %t101 = load i8*, i8** %l4
  %t102 = load %Token, %Token* %l5
  br i1 %t96, label %then6, label %merge7
then6:
  %t103 = load %Parser, %Parser* %l0
  %s104 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.104, i32 0, i32 0
  %t105 = call %Parser @consume_keyword(%Parser %t103, i8* %s104)
  store %Parser %t105, %Parser* %l0
  %t106 = load %Parser, %Parser* %l0
  %t107 = call %Parser @skip_trivia(%Parser %t106)
  store %Parser %t107, %Parser* %l0
  %t108 = load %Parser, %Parser* %l0
  %t109 = call %Token @parser_peek_raw(%Parser %t108)
  store %Token %t109, %Token* %l6
  %t110 = load %Token, %Token* %l6
  %t111 = extractvalue %Token %t110, 0
  %t112 = extractvalue %TokenKind %t111, 0
  %t113 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t114 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t112, 0
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %t117 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t118 = icmp eq i32 %t112, 1
  %t119 = select i1 %t118, i8* %t117, i8* %t116
  %t120 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t112, 2
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %t123 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t124 = icmp eq i32 %t112, 3
  %t125 = select i1 %t124, i8* %t123, i8* %t122
  %t126 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t127 = icmp eq i32 %t112, 4
  %t128 = select i1 %t127, i8* %t126, i8* %t125
  %t129 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t130 = icmp eq i32 %t112, 5
  %t131 = select i1 %t130, i8* %t129, i8* %t128
  %t132 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t112, 6
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t112, 7
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %s138 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.138, i32 0, i32 0
  %t139 = icmp eq i8* %t137, %s138
  %t140 = load %Parser, %Parser* %l0
  %t141 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l1
  %t142 = load %Token, %Token* %l2
  %t143 = load i8*, i8** %l3
  %t144 = load i8*, i8** %l4
  %t145 = load %Token, %Token* %l5
  %t146 = load %Token, %Token* %l6
  br i1 %t139, label %then8, label %merge9
then8:
  %t147 = load %Token, %Token* %l6
  %t148 = call i8* @identifier_text(%Token %t147)
  store i8* %t148, i8** %l4
  %t149 = load %Parser, %Parser* %l0
  %t150 = call %Parser @parser_advance_raw(%Parser %t149)
  store %Parser %t150, %Parser* %l0
  %t151 = load %Parser, %Parser* %l0
  %t152 = call %Parser @skip_trivia(%Parser %t151)
  store %Parser %t152, %Parser* %l0
  br label %merge9
merge9:
  %t153 = phi i8* [ %t148, %then8 ], [ %t144, %then6 ]
  %t154 = phi %Parser [ %t150, %then8 ], [ %t140, %then6 ]
  %t155 = phi %Parser [ %t152, %then8 ], [ %t140, %then6 ]
  store i8* %t153, i8** %l4
  store %Parser %t154, %Parser* %l0
  store %Parser %t155, %Parser* %l0
  br label %merge7
merge7:
  %t156 = phi %Parser [ %t105, %then6 ], [ %t97, %loop.body1 ]
  %t157 = phi %Parser [ %t107, %then6 ], [ %t97, %loop.body1 ]
  %t158 = phi i8* [ %t148, %then6 ], [ %t101, %loop.body1 ]
  %t159 = phi %Parser [ %t150, %then6 ], [ %t97, %loop.body1 ]
  %t160 = phi %Parser [ %t152, %then6 ], [ %t97, %loop.body1 ]
  store %Parser %t156, %Parser* %l0
  store %Parser %t157, %Parser* %l0
  store i8* %t158, i8** %l4
  store %Parser %t159, %Parser* %l0
  store %Parser %t160, %Parser* %l0
  %t161 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l1
  %t162 = load i8*, i8** %l3
  %t163 = insertvalue %NamedSpecifier undef, i8* %t162, 0
  %t164 = load i8*, i8** %l4
  %t165 = insertvalue %NamedSpecifier %t163, i8* %t164, 1
  %t166 = alloca [1 x %NamedSpecifier]
  %t167 = getelementptr [1 x %NamedSpecifier], [1 x %NamedSpecifier]* %t166, i32 0, i32 0
  %t168 = getelementptr %NamedSpecifier, %NamedSpecifier* %t167, i64 0
  store %NamedSpecifier %t165, %NamedSpecifier* %t168
  %t169 = alloca { %NamedSpecifier*, i64 }
  %t170 = getelementptr { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %t169, i32 0, i32 0
  store %NamedSpecifier* %t167, %NamedSpecifier** %t170
  %t171 = getelementptr { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %t169, i32 0, i32 1
  store i64 1, i64* %t171
  %t172 = bitcast { %NamedSpecifier*, i64 }* %t161 to { i8**, i64 }*
  %t173 = bitcast { %NamedSpecifier*, i64 }* %t169 to { i8**, i64 }*
  %t174 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t172, { i8**, i64 }* %t173)
  %t175 = bitcast { i8**, i64 }* %t174 to { %NamedSpecifier*, i64 }*
  store { %NamedSpecifier*, i64 }* %t175, { %NamedSpecifier*, i64 }** %l1
  %t176 = load %Parser, %Parser* %l0
  %t177 = call %Token @parser_peek_raw(%Parser %t176)
  store %Token %t177, %Token* %l7
  %t179 = load %Token, %Token* %l7
  %t180 = extractvalue %Token %t179, 0
  %t181 = extractvalue %TokenKind %t180, 0
  %t182 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t183 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t184 = icmp eq i32 %t181, 0
  %t185 = select i1 %t184, i8* %t183, i8* %t182
  %t186 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t187 = icmp eq i32 %t181, 1
  %t188 = select i1 %t187, i8* %t186, i8* %t185
  %t189 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t190 = icmp eq i32 %t181, 2
  %t191 = select i1 %t190, i8* %t189, i8* %t188
  %t192 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t193 = icmp eq i32 %t181, 3
  %t194 = select i1 %t193, i8* %t192, i8* %t191
  %t195 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t196 = icmp eq i32 %t181, 4
  %t197 = select i1 %t196, i8* %t195, i8* %t194
  %t198 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t199 = icmp eq i32 %t181, 5
  %t200 = select i1 %t199, i8* %t198, i8* %t197
  %t201 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t202 = icmp eq i32 %t181, 6
  %t203 = select i1 %t202, i8* %t201, i8* %t200
  %t204 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t205 = icmp eq i32 %t181, 7
  %t206 = select i1 %t205, i8* %t204, i8* %t203
  %s207 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.207, i32 0, i32 0
  %t208 = icmp eq i8* %t206, %s207
  br label %logical_and_entry_178

logical_and_entry_178:
  br i1 %t208, label %logical_and_right_178, label %logical_and_merge_178

logical_and_right_178:
  %t209 = load %Token, %Token* %l7
  %t210 = extractvalue %Token %t209, 0
  %t211 = extractvalue %TokenKind %t210, 0
  br label %loop.latch2
loop.latch2:
  %t212 = load %Parser, %Parser* %l0
  %t213 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t216 = load %Parser, %Parser* %l0
  %t217 = call %Parser @skip_trivia(%Parser %t216)
  store %Parser %t217, %Parser* %l0
  %t219 = load %Parser, %Parser* %l0
  %t220 = call %Token @parser_peek_raw(%Parser %t219)
  %t221 = extractvalue %Token %t220, 0
  %t222 = extractvalue %TokenKind %t221, 0
  %t223 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t224 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t225 = icmp eq i32 %t222, 0
  %t226 = select i1 %t225, i8* %t224, i8* %t223
  %t227 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t228 = icmp eq i32 %t222, 1
  %t229 = select i1 %t228, i8* %t227, i8* %t226
  %t230 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t231 = icmp eq i32 %t222, 2
  %t232 = select i1 %t231, i8* %t230, i8* %t229
  %t233 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t234 = icmp eq i32 %t222, 3
  %t235 = select i1 %t234, i8* %t233, i8* %t232
  %t236 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t237 = icmp eq i32 %t222, 4
  %t238 = select i1 %t237, i8* %t236, i8* %t235
  %t239 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t240 = icmp eq i32 %t222, 5
  %t241 = select i1 %t240, i8* %t239, i8* %t238
  %t242 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t243 = icmp eq i32 %t222, 6
  %t244 = select i1 %t243, i8* %t242, i8* %t241
  %t245 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t246 = icmp eq i32 %t222, 7
  %t247 = select i1 %t246, i8* %t245, i8* %t244
  %s248 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.248, i32 0, i32 0
  %t249 = icmp eq i8* %t247, %s248
  br label %logical_and_entry_218

logical_and_entry_218:
  br i1 %t249, label %logical_and_right_218, label %logical_and_merge_218

logical_and_right_218:
  %t250 = load %Parser, %Parser* %l0
  %t251 = call %Token @parser_peek_raw(%Parser %t250)
  %t252 = extractvalue %Token %t251, 0
  %t253 = extractvalue %TokenKind %t252, 0
  %t254 = load %Parser, %Parser* %l0
  %t255 = insertvalue %SpecifierListParseResult undef, %Parser %t254, 0
  %t256 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l1
  %t257 = bitcast { %NamedSpecifier*, i64 }* %t256 to { %NamedSpecifier**, i64 }*
  %t258 = insertvalue %SpecifierListParseResult %t255, { %NamedSpecifier**, i64 }* %t257, 1
  ret %SpecifierListParseResult %t258
}

define { %ImportSpecifier*, i64 }* @build_import_specifiers({ %NamedSpecifier*, i64 }* %values) {
entry:
  %l0 = alloca { %ImportSpecifier*, i64 }*
  %l1 = alloca double
  %l2 = alloca %NamedSpecifier
  %t0 = alloca [0 x %ImportSpecifier]
  %t1 = getelementptr [0 x %ImportSpecifier], [0 x %ImportSpecifier]* %t0, i32 0, i32 0
  %t2 = alloca { %ImportSpecifier*, i64 }
  %t3 = getelementptr { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %t2, i32 0, i32 0
  store %ImportSpecifier* %t1, %ImportSpecifier** %t3
  %t4 = getelementptr { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %ImportSpecifier*, i64 }* %t2, { %ImportSpecifier*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %ImportSpecifier*, i64 }*, { %ImportSpecifier*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t45 = phi { %ImportSpecifier*, i64 }* [ %t6, %entry ], [ %t43, %loop.latch2 ]
  %t46 = phi double [ %t7, %entry ], [ %t44, %loop.latch2 ]
  store { %ImportSpecifier*, i64 }* %t45, { %ImportSpecifier*, i64 }** %l0
  store double %t46, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %values
  %t10 = extractvalue { %NamedSpecifier*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %ImportSpecifier*, i64 }*, { %ImportSpecifier*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = fptosi double %t15 to i64
  %t17 = load { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %values
  %t18 = extractvalue { %NamedSpecifier*, i64 } %t17, 0
  %t19 = extractvalue { %NamedSpecifier*, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr %NamedSpecifier, %NamedSpecifier* %t18, i64 %t16
  %t22 = load %NamedSpecifier, %NamedSpecifier* %t21
  store %NamedSpecifier %t22, %NamedSpecifier* %l2
  %t23 = load { %ImportSpecifier*, i64 }*, { %ImportSpecifier*, i64 }** %l0
  %t24 = load %NamedSpecifier, %NamedSpecifier* %l2
  %t25 = extractvalue %NamedSpecifier %t24, 0
  %t26 = insertvalue %ImportSpecifier undef, i8* %t25, 0
  %t27 = load %NamedSpecifier, %NamedSpecifier* %l2
  %t28 = extractvalue %NamedSpecifier %t27, 1
  %t29 = insertvalue %ImportSpecifier %t26, i8* %t28, 1
  %t30 = alloca [1 x %ImportSpecifier]
  %t31 = getelementptr [1 x %ImportSpecifier], [1 x %ImportSpecifier]* %t30, i32 0, i32 0
  %t32 = getelementptr %ImportSpecifier, %ImportSpecifier* %t31, i64 0
  store %ImportSpecifier %t29, %ImportSpecifier* %t32
  %t33 = alloca { %ImportSpecifier*, i64 }
  %t34 = getelementptr { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %t33, i32 0, i32 0
  store %ImportSpecifier* %t31, %ImportSpecifier** %t34
  %t35 = getelementptr { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %t33, i32 0, i32 1
  store i64 1, i64* %t35
  %t36 = bitcast { %ImportSpecifier*, i64 }* %t23 to { i8**, i64 }*
  %t37 = bitcast { %ImportSpecifier*, i64 }* %t33 to { i8**, i64 }*
  %t38 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t36, { i8**, i64 }* %t37)
  %t39 = bitcast { i8**, i64 }* %t38 to { %ImportSpecifier*, i64 }*
  store { %ImportSpecifier*, i64 }* %t39, { %ImportSpecifier*, i64 }** %l0
  %t40 = load double, double* %l1
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l1
  br label %loop.latch2
loop.latch2:
  %t43 = load { %ImportSpecifier*, i64 }*, { %ImportSpecifier*, i64 }** %l0
  %t44 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t47 = load { %ImportSpecifier*, i64 }*, { %ImportSpecifier*, i64 }** %l0
  ret { %ImportSpecifier*, i64 }* %t47
}

define { %ExportSpecifier*, i64 }* @build_export_specifiers({ %NamedSpecifier*, i64 }* %values) {
entry:
  %l0 = alloca { %ExportSpecifier*, i64 }*
  %l1 = alloca double
  %l2 = alloca %NamedSpecifier
  %t0 = alloca [0 x %ExportSpecifier]
  %t1 = getelementptr [0 x %ExportSpecifier], [0 x %ExportSpecifier]* %t0, i32 0, i32 0
  %t2 = alloca { %ExportSpecifier*, i64 }
  %t3 = getelementptr { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %t2, i32 0, i32 0
  store %ExportSpecifier* %t1, %ExportSpecifier** %t3
  %t4 = getelementptr { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %ExportSpecifier*, i64 }* %t2, { %ExportSpecifier*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %ExportSpecifier*, i64 }*, { %ExportSpecifier*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t45 = phi { %ExportSpecifier*, i64 }* [ %t6, %entry ], [ %t43, %loop.latch2 ]
  %t46 = phi double [ %t7, %entry ], [ %t44, %loop.latch2 ]
  store { %ExportSpecifier*, i64 }* %t45, { %ExportSpecifier*, i64 }** %l0
  store double %t46, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %values
  %t10 = extractvalue { %NamedSpecifier*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %ExportSpecifier*, i64 }*, { %ExportSpecifier*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = fptosi double %t15 to i64
  %t17 = load { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %values
  %t18 = extractvalue { %NamedSpecifier*, i64 } %t17, 0
  %t19 = extractvalue { %NamedSpecifier*, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr %NamedSpecifier, %NamedSpecifier* %t18, i64 %t16
  %t22 = load %NamedSpecifier, %NamedSpecifier* %t21
  store %NamedSpecifier %t22, %NamedSpecifier* %l2
  %t23 = load { %ExportSpecifier*, i64 }*, { %ExportSpecifier*, i64 }** %l0
  %t24 = load %NamedSpecifier, %NamedSpecifier* %l2
  %t25 = extractvalue %NamedSpecifier %t24, 0
  %t26 = insertvalue %ExportSpecifier undef, i8* %t25, 0
  %t27 = load %NamedSpecifier, %NamedSpecifier* %l2
  %t28 = extractvalue %NamedSpecifier %t27, 1
  %t29 = insertvalue %ExportSpecifier %t26, i8* %t28, 1
  %t30 = alloca [1 x %ExportSpecifier]
  %t31 = getelementptr [1 x %ExportSpecifier], [1 x %ExportSpecifier]* %t30, i32 0, i32 0
  %t32 = getelementptr %ExportSpecifier, %ExportSpecifier* %t31, i64 0
  store %ExportSpecifier %t29, %ExportSpecifier* %t32
  %t33 = alloca { %ExportSpecifier*, i64 }
  %t34 = getelementptr { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %t33, i32 0, i32 0
  store %ExportSpecifier* %t31, %ExportSpecifier** %t34
  %t35 = getelementptr { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %t33, i32 0, i32 1
  store i64 1, i64* %t35
  %t36 = bitcast { %ExportSpecifier*, i64 }* %t23 to { i8**, i64 }*
  %t37 = bitcast { %ExportSpecifier*, i64 }* %t33 to { i8**, i64 }*
  %t38 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t36, { i8**, i64 }* %t37)
  %t39 = bitcast { i8**, i64 }* %t38 to { %ExportSpecifier*, i64 }*
  store { %ExportSpecifier*, i64 }* %t39, { %ExportSpecifier*, i64 }** %l0
  %t40 = load double, double* %l1
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l1
  br label %loop.latch2
loop.latch2:
  %t43 = load { %ExportSpecifier*, i64 }*, { %ExportSpecifier*, i64 }** %l0
  %t44 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t47 = load { %ExportSpecifier*, i64 }*, { %ExportSpecifier*, i64 }** %l0
  ret { %ExportSpecifier*, i64 }* %t47
}

define %StatementParseResult @parse_struct(%Parser %initial_parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca %TypeParameterParseResult
  %l5 = alloca { %TypeParameter**, i64 }*
  %l6 = alloca %ImplementsParseResult
  %l7 = alloca { %TypeAnnotation**, i64 }*
  %l8 = alloca { %FieldDeclaration*, i64 }*
  %l9 = alloca { %MethodDeclaration*, i64 }*
  %l10 = alloca %Parser
  %l11 = alloca %DecoratorParseResult
  %l12 = alloca { %Decorator**, i64 }*
  %l13 = alloca %Token
  %l14 = alloca %StructFieldParseResult
  %l15 = alloca %MethodParseResult
  %l16 = alloca %Statement
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  %t1 = call %Parser @skip_trivia(%Parser %t0)
  store %Parser %t1, %Parser* %l0
  %t2 = load %Parser, %Parser* %l0
  %s3 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.3, i32 0, i32 0
  %t4 = call %Parser @consume_keyword(%Parser %t2, i8* %s3)
  store %Parser %t4, %Parser* %l0
  %t5 = load %Parser, %Parser* %l0
  %t6 = call %Parser @skip_trivia(%Parser %t5)
  store %Parser %t6, %Parser* %l0
  %t7 = load %Parser, %Parser* %l0
  %t8 = call %Token @parser_peek_raw(%Parser %t7)
  store %Token %t8, %Token* %l1
  %t9 = load %Token, %Token* %l1
  %t10 = call i8* @identifier_text(%Token %t9)
  store i8* %t10, i8** %l2
  %t11 = load %Token, %Token* %l1
  %t12 = alloca [1 x %Token]
  %t13 = getelementptr [1 x %Token], [1 x %Token]* %t12, i32 0, i32 0
  %t14 = getelementptr %Token, %Token* %t13, i64 0
  store %Token %t11, %Token* %t14
  %t15 = alloca { %Token*, i64 }
  %t16 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t15, i32 0, i32 0
  store %Token* %t13, %Token** %t16
  %t17 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t15, i32 0, i32 1
  store i64 1, i64* %t17
  %t18 = call double @source_span_from_tokens({ %Token*, i64 }* %t15)
  store double %t18, double* %l3
  %t19 = load %Parser, %Parser* %l0
  %t20 = call %Parser @parser_advance_raw(%Parser %t19)
  store %Parser %t20, %Parser* %l0
  %t21 = load %Parser, %Parser* %l0
  %t22 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %t21)
  store %TypeParameterParseResult %t22, %TypeParameterParseResult* %l4
  %t23 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t24 = extractvalue %TypeParameterParseResult %t23, 0
  store %Parser %t24, %Parser* %l0
  %t25 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t26 = extractvalue %TypeParameterParseResult %t25, 1
  store { %TypeParameter**, i64 }* %t26, { %TypeParameter**, i64 }** %l5
  %t27 = load %Parser, %Parser* %l0
  %t28 = call %ImplementsParseResult @parse_implements_clause(%Parser %t27)
  store %ImplementsParseResult %t28, %ImplementsParseResult* %l6
  %t29 = load %ImplementsParseResult, %ImplementsParseResult* %l6
  %t30 = extractvalue %ImplementsParseResult %t29, 0
  store %Parser %t30, %Parser* %l0
  %t31 = load %ImplementsParseResult, %ImplementsParseResult* %l6
  %t32 = extractvalue %ImplementsParseResult %t31, 1
  store { %TypeAnnotation**, i64 }* %t32, { %TypeAnnotation**, i64 }** %l7
  %t33 = load %Parser, %Parser* %l0
  %t34 = call %Parser @skip_trivia(%Parser %t33)
  store %Parser %t34, %Parser* %l0
  %t35 = load %Parser, %Parser* %l0
  %t36 = alloca [2 x i8], align 1
  %t37 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 0
  store i8 123, i8* %t37
  %t38 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 1
  store i8 0, i8* %t38
  %t39 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 0
  %t40 = call %Parser @advance_to_symbol(%Parser %t35, i8* %t39)
  store %Parser %t40, %Parser* %l0
  %t41 = load %Parser, %Parser* %l0
  %t42 = alloca [2 x i8], align 1
  %t43 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  store i8 123, i8* %t43
  %t44 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 1
  store i8 0, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  %t46 = call %Parser @consume_symbol(%Parser %t41, i8* %t45)
  store %Parser %t46, %Parser* %l0
  %t47 = alloca [0 x %FieldDeclaration]
  %t48 = getelementptr [0 x %FieldDeclaration], [0 x %FieldDeclaration]* %t47, i32 0, i32 0
  %t49 = alloca { %FieldDeclaration*, i64 }
  %t50 = getelementptr { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %t49, i32 0, i32 0
  store %FieldDeclaration* %t48, %FieldDeclaration** %t50
  %t51 = getelementptr { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %t49, i32 0, i32 1
  store i64 0, i64* %t51
  store { %FieldDeclaration*, i64 }* %t49, { %FieldDeclaration*, i64 }** %l8
  %t52 = alloca [0 x %MethodDeclaration]
  %t53 = getelementptr [0 x %MethodDeclaration], [0 x %MethodDeclaration]* %t52, i32 0, i32 0
  %t54 = alloca { %MethodDeclaration*, i64 }
  %t55 = getelementptr { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t54, i32 0, i32 0
  store %MethodDeclaration* %t53, %MethodDeclaration** %t55
  %t56 = getelementptr { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t54, i32 0, i32 1
  store i64 0, i64* %t56
  store { %MethodDeclaration*, i64 }* %t54, { %MethodDeclaration*, i64 }** %l9
  %t57 = load %Parser, %Parser* %l0
  %t58 = load %Token, %Token* %l1
  %t59 = load i8*, i8** %l2
  %t60 = load double, double* %l3
  %t61 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t62 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l5
  %t63 = load %ImplementsParseResult, %ImplementsParseResult* %l6
  %t64 = load { %TypeAnnotation**, i64 }*, { %TypeAnnotation**, i64 }** %l7
  %t65 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l8
  %t66 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %l9
  br label %loop.header0
loop.header0:
  %t218 = phi %Parser [ %t57, %entry ], [ %t217, %loop.latch2 ]
  store %Parser %t218, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t67 = load %Parser, %Parser* %l0
  %t68 = call %Parser @skip_trivia(%Parser %t67)
  store %Parser %t68, %Parser* %l0
  %t69 = load %Parser, %Parser* %l0
  store %Parser %t69, %Parser* %l10
  %t70 = load %Parser, %Parser* %l0
  %t71 = call %DecoratorParseResult @parse_decorators(%Parser %t70)
  store %DecoratorParseResult %t71, %DecoratorParseResult* %l11
  %t72 = load %DecoratorParseResult, %DecoratorParseResult* %l11
  %t73 = extractvalue %DecoratorParseResult %t72, 0
  store %Parser %t73, %Parser* %l0
  %t74 = load %DecoratorParseResult, %DecoratorParseResult* %l11
  %t75 = extractvalue %DecoratorParseResult %t74, 1
  store { %Decorator**, i64 }* %t75, { %Decorator**, i64 }** %l12
  %t76 = load %Parser, %Parser* %l0
  %t77 = call %Parser @skip_trivia(%Parser %t76)
  store %Parser %t77, %Parser* %l0
  %t78 = load %Parser, %Parser* %l0
  %t79 = call %Token @parser_peek_raw(%Parser %t78)
  store %Token %t79, %Token* %l13
  %t81 = load %Token, %Token* %l13
  %t82 = extractvalue %Token %t81, 0
  %t83 = extractvalue %TokenKind %t82, 0
  %t84 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t85 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t83, 0
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t83, 1
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t83, 2
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t83, 3
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t83, 4
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %t100 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t83, 5
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %t103 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t104 = icmp eq i32 %t83, 6
  %t105 = select i1 %t104, i8* %t103, i8* %t102
  %t106 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t107 = icmp eq i32 %t83, 7
  %t108 = select i1 %t107, i8* %t106, i8* %t105
  %s109 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.109, i32 0, i32 0
  %t110 = icmp eq i8* %t108, %s109
  br label %logical_and_entry_80

logical_and_entry_80:
  br i1 %t110, label %logical_and_right_80, label %logical_and_merge_80

logical_and_right_80:
  %t111 = load %Token, %Token* %l13
  %t112 = extractvalue %Token %t111, 0
  %t113 = extractvalue %TokenKind %t112, 0
  %t114 = load %Token, %Token* %l13
  %t115 = extractvalue %Token %t114, 0
  %t116 = extractvalue %TokenKind %t115, 0
  %t117 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t118 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t119 = icmp eq i32 %t116, 0
  %t120 = select i1 %t119, i8* %t118, i8* %t117
  %t121 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t122 = icmp eq i32 %t116, 1
  %t123 = select i1 %t122, i8* %t121, i8* %t120
  %t124 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t125 = icmp eq i32 %t116, 2
  %t126 = select i1 %t125, i8* %t124, i8* %t123
  %t127 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t128 = icmp eq i32 %t116, 3
  %t129 = select i1 %t128, i8* %t127, i8* %t126
  %t130 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t131 = icmp eq i32 %t116, 4
  %t132 = select i1 %t131, i8* %t130, i8* %t129
  %t133 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t134 = icmp eq i32 %t116, 5
  %t135 = select i1 %t134, i8* %t133, i8* %t132
  %t136 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t116, 6
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t116, 7
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %s142 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.142, i32 0, i32 0
  %t143 = icmp eq i8* %t141, %s142
  %t144 = load %Parser, %Parser* %l0
  %t145 = load %Token, %Token* %l1
  %t146 = load i8*, i8** %l2
  %t147 = load double, double* %l3
  %t148 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t149 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l5
  %t150 = load %ImplementsParseResult, %ImplementsParseResult* %l6
  %t151 = load { %TypeAnnotation**, i64 }*, { %TypeAnnotation**, i64 }** %l7
  %t152 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l8
  %t153 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %l9
  %t154 = load %Parser, %Parser* %l10
  %t155 = load %DecoratorParseResult, %DecoratorParseResult* %l11
  %t156 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l12
  %t157 = load %Token, %Token* %l13
  br i1 %t143, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t158 = load %Parser, %Parser* %l0
  %t159 = call %StructFieldParseResult @parse_struct_field(%Parser %t158)
  store %StructFieldParseResult %t159, %StructFieldParseResult* %l14
  %t161 = load %StructFieldParseResult, %StructFieldParseResult* %l14
  %t162 = extractvalue %StructFieldParseResult %t161, 2
  br label %logical_and_entry_160

logical_and_entry_160:
  br i1 %t162, label %logical_and_right_160, label %logical_and_merge_160

logical_and_right_160:
  %t163 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l12
  %t164 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t163
  %t165 = extractvalue { %Decorator**, i64 } %t164, 1
  %t166 = icmp eq i64 %t165, 0
  br label %logical_and_right_end_160

logical_and_right_end_160:
  br label %logical_and_merge_160

logical_and_merge_160:
  %t167 = phi i1 [ false, %logical_and_entry_160 ], [ %t166, %logical_and_right_end_160 ]
  %t168 = load %Parser, %Parser* %l0
  %t169 = load %Token, %Token* %l1
  %t170 = load i8*, i8** %l2
  %t171 = load double, double* %l3
  %t172 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t173 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l5
  %t174 = load %ImplementsParseResult, %ImplementsParseResult* %l6
  %t175 = load { %TypeAnnotation**, i64 }*, { %TypeAnnotation**, i64 }** %l7
  %t176 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l8
  %t177 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %l9
  %t178 = load %Parser, %Parser* %l10
  %t179 = load %DecoratorParseResult, %DecoratorParseResult* %l11
  %t180 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l12
  %t181 = load %Token, %Token* %l13
  %t182 = load %StructFieldParseResult, %StructFieldParseResult* %l14
  br i1 %t167, label %then6, label %merge7
then6:
  %t183 = load %StructFieldParseResult, %StructFieldParseResult* %l14
  %t184 = extractvalue %StructFieldParseResult %t183, 1
  %t185 = bitcast i8* null to %FieldDeclaration*
  %t186 = load %StructFieldParseResult, %StructFieldParseResult* %l14
  %t187 = extractvalue %StructFieldParseResult %t186, 0
  store %Parser %t187, %Parser* %l0
  br label %loop.latch2
merge7:
  %t188 = load %Parser, %Parser* %l0
  %t189 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l12
  %t190 = bitcast { %Decorator**, i64 }* %t189 to { %Decorator*, i64 }*
  %t191 = call %MethodParseResult @parse_struct_method(%Parser %t188, { %Decorator*, i64 }* %t190)
  store %MethodParseResult %t191, %MethodParseResult* %l15
  %t192 = load %MethodParseResult, %MethodParseResult* %l15
  %t193 = extractvalue %MethodParseResult %t192, 2
  %t194 = load %Parser, %Parser* %l0
  %t195 = load %Token, %Token* %l1
  %t196 = load i8*, i8** %l2
  %t197 = load double, double* %l3
  %t198 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t199 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l5
  %t200 = load %ImplementsParseResult, %ImplementsParseResult* %l6
  %t201 = load { %TypeAnnotation**, i64 }*, { %TypeAnnotation**, i64 }** %l7
  %t202 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l8
  %t203 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %l9
  %t204 = load %Parser, %Parser* %l10
  %t205 = load %DecoratorParseResult, %DecoratorParseResult* %l11
  %t206 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l12
  %t207 = load %Token, %Token* %l13
  %t208 = load %StructFieldParseResult, %StructFieldParseResult* %l14
  %t209 = load %MethodParseResult, %MethodParseResult* %l15
  br i1 %t193, label %then8, label %merge9
then8:
  %t210 = load %MethodParseResult, %MethodParseResult* %l15
  %t211 = extractvalue %MethodParseResult %t210, 1
  %t212 = bitcast i8* null to %MethodDeclaration*
  %t213 = load %MethodParseResult, %MethodParseResult* %l15
  %t214 = extractvalue %MethodParseResult %t213, 0
  store %Parser %t214, %Parser* %l0
  br label %loop.latch2
merge9:
  %t215 = load %Parser, %Parser* %l10
  %t216 = call %Parser @skip_struct_member(%Parser %t215)
  store %Parser %t216, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t217 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t219 = alloca %Statement
  %t220 = getelementptr inbounds %Statement, %Statement* %t219, i32 0, i32 0
  store i32 8, i32* %t220
  %t221 = load i8*, i8** %l2
  %t222 = getelementptr inbounds %Statement, %Statement* %t219, i32 0, i32 1
  %t223 = bitcast [56 x i8]* %t222 to i8*
  %t224 = bitcast i8* %t223 to i8**
  store i8* %t221, i8** %t224
  %t225 = load double, double* %l3
  %t226 = call noalias i8* @malloc(i64 8)
  %t227 = bitcast i8* %t226 to double*
  store double %t225, double* %t227
  %t228 = bitcast i8* %t226 to %SourceSpan*
  %t229 = getelementptr inbounds %Statement, %Statement* %t219, i32 0, i32 1
  %t230 = bitcast [56 x i8]* %t229 to i8*
  %t231 = getelementptr inbounds i8, i8* %t230, i64 8
  %t232 = bitcast i8* %t231 to %SourceSpan**
  store %SourceSpan* %t228, %SourceSpan** %t232
  %t233 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l5
  %t234 = getelementptr inbounds %Statement, %Statement* %t219, i32 0, i32 1
  %t235 = bitcast [56 x i8]* %t234 to i8*
  %t236 = getelementptr inbounds i8, i8* %t235, i64 16
  %t237 = bitcast i8* %t236 to { %TypeParameter**, i64 }**
  store { %TypeParameter**, i64 }* %t233, { %TypeParameter**, i64 }** %t237
  %t238 = load { %TypeAnnotation**, i64 }*, { %TypeAnnotation**, i64 }** %l7
  %t239 = getelementptr inbounds %Statement, %Statement* %t219, i32 0, i32 1
  %t240 = bitcast [56 x i8]* %t239 to i8*
  %t241 = getelementptr inbounds i8, i8* %t240, i64 24
  %t242 = bitcast i8* %t241 to { %TypeAnnotation**, i64 }**
  store { %TypeAnnotation**, i64 }* %t238, { %TypeAnnotation**, i64 }** %t242
  %t243 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l8
  %t244 = bitcast { %FieldDeclaration*, i64 }* %t243 to { %FieldDeclaration**, i64 }*
  %t245 = getelementptr inbounds %Statement, %Statement* %t219, i32 0, i32 1
  %t246 = bitcast [56 x i8]* %t245 to i8*
  %t247 = getelementptr inbounds i8, i8* %t246, i64 32
  %t248 = bitcast i8* %t247 to { %FieldDeclaration**, i64 }**
  store { %FieldDeclaration**, i64 }* %t244, { %FieldDeclaration**, i64 }** %t248
  %t249 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %l9
  %t250 = bitcast { %MethodDeclaration*, i64 }* %t249 to { %MethodDeclaration**, i64 }*
  %t251 = getelementptr inbounds %Statement, %Statement* %t219, i32 0, i32 1
  %t252 = bitcast [56 x i8]* %t251 to i8*
  %t253 = getelementptr inbounds i8, i8* %t252, i64 40
  %t254 = bitcast i8* %t253 to { %MethodDeclaration**, i64 }**
  store { %MethodDeclaration**, i64 }* %t250, { %MethodDeclaration**, i64 }** %t254
  %t255 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t256 = getelementptr inbounds %Statement, %Statement* %t219, i32 0, i32 1
  %t257 = bitcast [56 x i8]* %t256 to i8*
  %t258 = getelementptr inbounds i8, i8* %t257, i64 48
  %t259 = bitcast i8* %t258 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t255, { %Decorator**, i64 }** %t259
  %t260 = load %Statement, %Statement* %t219
  store %Statement %t260, %Statement* %l16
  %t261 = load %Parser, %Parser* %l0
  %t262 = insertvalue %StatementParseResult undef, %Parser %t261, 0
  %t263 = load %Statement, %Statement* %l16
  %t264 = insertvalue %StatementParseResult %t262, %Statement %t263, 1
  ret %StatementParseResult %t264
}

define %StatementParseResult @parse_type_alias(%Parser %initial_parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %Token
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca %TypeParameterParseResult
  %l6 = alloca { %TypeParameter**, i64 }*
  %l7 = alloca %Token
  %l8 = alloca %CaptureResult
  %l9 = alloca i8*
  %l10 = alloca %TypeAnnotation
  %l11 = alloca %Statement
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Parser @skip_trivia(%Parser %t1)
  store %Parser %t2, %Parser* %l0
  %t3 = load %Parser, %Parser* %l0
  %s4 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.4, i32 0, i32 0
  %t5 = call %Parser @consume_keyword(%Parser %t3, i8* %s4)
  store %Parser %t5, %Parser* %l0
  %t6 = load %Parser, %Parser* %l0
  %t7 = call %Parser @skip_trivia(%Parser %t6)
  store %Parser %t7, %Parser* %l0
  %t8 = load %Parser, %Parser* %l0
  %t9 = call %Token @parser_peek_raw(%Parser %t8)
  store %Token %t9, %Token* %l2
  %t10 = load %Token, %Token* %l2
  %t11 = extractvalue %Token %t10, 0
  %t12 = extractvalue %TokenKind %t11, 0
  %t13 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t14 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t15 = icmp eq i32 %t12, 0
  %t16 = select i1 %t15, i8* %t14, i8* %t13
  %t17 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t12, 1
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t12, 2
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t12, 3
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t12, 4
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t12, 5
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t12, 6
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t12, 7
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %s38 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.38, i32 0, i32 0
  %t39 = icmp ne i8* %t37, %s38
  %t40 = load %Parser, %Parser* %l0
  %t41 = load %Parser, %Parser* %l1
  %t42 = load %Token, %Token* %l2
  br i1 %t39, label %then0, label %merge1
then0:
  %t43 = load %Parser, %Parser* %l1
  %t44 = call %StatementParseResult @parse_unknown(%Parser %t43)
  ret %StatementParseResult %t44
merge1:
  %t45 = load %Token, %Token* %l2
  %t46 = call i8* @identifier_text(%Token %t45)
  store i8* %t46, i8** %l3
  %t47 = load %Token, %Token* %l2
  %t48 = alloca [1 x %Token]
  %t49 = getelementptr [1 x %Token], [1 x %Token]* %t48, i32 0, i32 0
  %t50 = getelementptr %Token, %Token* %t49, i64 0
  store %Token %t47, %Token* %t50
  %t51 = alloca { %Token*, i64 }
  %t52 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t51, i32 0, i32 0
  store %Token* %t49, %Token** %t52
  %t53 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t51, i32 0, i32 1
  store i64 1, i64* %t53
  %t54 = call double @source_span_from_tokens({ %Token*, i64 }* %t51)
  store double %t54, double* %l4
  %t55 = load %Parser, %Parser* %l0
  %t56 = call %Parser @parser_advance_raw(%Parser %t55)
  store %Parser %t56, %Parser* %l0
  %t57 = load %Parser, %Parser* %l0
  %t58 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %t57)
  store %TypeParameterParseResult %t58, %TypeParameterParseResult* %l5
  %t59 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t60 = extractvalue %TypeParameterParseResult %t59, 0
  store %Parser %t60, %Parser* %l0
  %t61 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t62 = extractvalue %TypeParameterParseResult %t61, 1
  store { %TypeParameter**, i64 }* %t62, { %TypeParameter**, i64 }** %l6
  %t63 = load %Parser, %Parser* %l0
  %t64 = call %Parser @skip_trivia(%Parser %t63)
  store %Parser %t64, %Parser* %l0
  %t65 = load %Parser, %Parser* %l0
  %t66 = call %Token @parser_peek_raw(%Parser %t65)
  store %Token %t66, %Token* %l7
  %t68 = load %Token, %Token* %l7
  %t69 = extractvalue %Token %t68, 0
  %t70 = extractvalue %TokenKind %t69, 0
  %t71 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t72 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t70, 0
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t70, 1
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t70, 2
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %t81 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t70, 3
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t70, 4
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %t87 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t88 = icmp eq i32 %t70, 5
  %t89 = select i1 %t88, i8* %t87, i8* %t86
  %t90 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t91 = icmp eq i32 %t70, 6
  %t92 = select i1 %t91, i8* %t90, i8* %t89
  %t93 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t70, 7
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %s96 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.96, i32 0, i32 0
  %t97 = icmp ne i8* %t95, %s96
  br label %logical_or_entry_67

logical_or_entry_67:
  br i1 %t97, label %logical_or_merge_67, label %logical_or_right_67

logical_or_right_67:
  %t98 = load %Token, %Token* %l7
  %t99 = extractvalue %Token %t98, 0
  %t100 = extractvalue %TokenKind %t99, 0
  %t101 = load %Parser, %Parser* %l0
  %t102 = call %Parser @parser_advance_raw(%Parser %t101)
  store %Parser %t102, %Parser* %l0
  %t103 = load %Parser, %Parser* %l0
  %t104 = call %Parser @skip_trivia(%Parser %t103)
  %t105 = alloca [1 x i8]
  %t106 = getelementptr [1 x i8], [1 x i8]* %t105, i32 0, i32 0
  %t107 = getelementptr i8, i8* %t106, i64 0
  store i8 59, i8* %t107
  %t108 = alloca { i8*, i64 }
  %t109 = getelementptr { i8*, i64 }, { i8*, i64 }* %t108, i32 0, i32 0
  store i8* %t106, i8** %t109
  %t110 = getelementptr { i8*, i64 }, { i8*, i64 }* %t108, i32 0, i32 1
  store i64 1, i64* %t110
  %t111 = bitcast { i8*, i64 }* %t108 to { i8**, i64 }*
  %t112 = call %CaptureResult @collect_until(%Parser %t104, { i8**, i64 }* %t111)
  store %CaptureResult %t112, %CaptureResult* %l8
  %t113 = load %CaptureResult, %CaptureResult* %l8
  %t114 = extractvalue %CaptureResult %t113, 0
  store %Parser %t114, %Parser* %l0
  %t115 = load %CaptureResult, %CaptureResult* %l8
  %t116 = extractvalue %CaptureResult %t115, 1
  %t117 = bitcast { %Token**, i64 }* %t116 to { %Token*, i64 }*
  %t118 = call i8* @tokens_to_text({ %Token*, i64 }* %t117)
  %t119 = call i8* @trim_text(i8* %t118)
  store i8* %t119, i8** %l9
  %t120 = load i8*, i8** %l9
  %t121 = call i64 @sailfin_runtime_string_length(i8* %t120)
  %t122 = icmp eq i64 %t121, 0
  %t123 = load %Parser, %Parser* %l0
  %t124 = load %Parser, %Parser* %l1
  %t125 = load %Token, %Token* %l2
  %t126 = load i8*, i8** %l3
  %t127 = load double, double* %l4
  %t128 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t129 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l6
  %t130 = load %Token, %Token* %l7
  %t131 = load %CaptureResult, %CaptureResult* %l8
  %t132 = load i8*, i8** %l9
  br i1 %t122, label %then2, label %merge3
then2:
  %t133 = load %Parser, %Parser* %l1
  %t134 = call %StatementParseResult @parse_unknown(%Parser %t133)
  ret %StatementParseResult %t134
merge3:
  %t135 = load i8*, i8** %l9
  %t136 = insertvalue %TypeAnnotation undef, i8* %t135, 0
  store %TypeAnnotation %t136, %TypeAnnotation* %l10
  %t137 = load %Parser, %Parser* %l0
  %t138 = call %Parser @skip_trivia(%Parser %t137)
  store %Parser %t138, %Parser* %l0
  %t140 = load %Parser, %Parser* %l0
  %t141 = call %Token @parser_peek_raw(%Parser %t140)
  %t142 = extractvalue %Token %t141, 0
  %t143 = extractvalue %TokenKind %t142, 0
  %t144 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t145 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t143, 0
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t143, 1
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t143, 2
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t143, 3
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t143, 4
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %t160 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t161 = icmp eq i32 %t143, 5
  %t162 = select i1 %t161, i8* %t160, i8* %t159
  %t163 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t164 = icmp eq i32 %t143, 6
  %t165 = select i1 %t164, i8* %t163, i8* %t162
  %t166 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t167 = icmp eq i32 %t143, 7
  %t168 = select i1 %t167, i8* %t166, i8* %t165
  %s169 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.169, i32 0, i32 0
  %t170 = icmp eq i8* %t168, %s169
  br label %logical_and_entry_139

logical_and_entry_139:
  br i1 %t170, label %logical_and_right_139, label %logical_and_merge_139

logical_and_right_139:
  %t171 = load %Parser, %Parser* %l0
  %t172 = call %Token @parser_peek_raw(%Parser %t171)
  %t173 = extractvalue %Token %t172, 0
  %t174 = extractvalue %TokenKind %t173, 0
  %t175 = alloca %Statement
  %t176 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 0
  store i32 9, i32* %t176
  %t177 = load i8*, i8** %l3
  %t178 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t179 = bitcast [40 x i8]* %t178 to i8*
  %t180 = bitcast i8* %t179 to i8**
  store i8* %t177, i8** %t180
  %t181 = load double, double* %l4
  %t182 = call noalias i8* @malloc(i64 8)
  %t183 = bitcast i8* %t182 to double*
  store double %t181, double* %t183
  %t184 = bitcast i8* %t182 to %SourceSpan*
  %t185 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t186 = bitcast [40 x i8]* %t185 to i8*
  %t187 = getelementptr inbounds i8, i8* %t186, i64 8
  %t188 = bitcast i8* %t187 to %SourceSpan**
  store %SourceSpan* %t184, %SourceSpan** %t188
  %t189 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l6
  %t190 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t191 = bitcast [40 x i8]* %t190 to i8*
  %t192 = getelementptr inbounds i8, i8* %t191, i64 16
  %t193 = bitcast i8* %t192 to { %TypeParameter**, i64 }**
  store { %TypeParameter**, i64 }* %t189, { %TypeParameter**, i64 }** %t193
  %t194 = load %TypeAnnotation, %TypeAnnotation* %l10
  %t195 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t196 = bitcast [40 x i8]* %t195 to i8*
  %t197 = getelementptr inbounds i8, i8* %t196, i64 24
  %t198 = bitcast i8* %t197 to %TypeAnnotation*
  store %TypeAnnotation %t194, %TypeAnnotation* %t198
  %t199 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t200 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t201 = bitcast [40 x i8]* %t200 to i8*
  %t202 = getelementptr inbounds i8, i8* %t201, i64 32
  %t203 = bitcast i8* %t202 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t199, { %Decorator**, i64 }** %t203
  %t204 = load %Statement, %Statement* %t175
  store %Statement %t204, %Statement* %l11
  %t205 = load %Parser, %Parser* %l0
  %t206 = insertvalue %StatementParseResult undef, %Parser %t205, 0
  %t207 = load %Statement, %Statement* %l11
  %t208 = insertvalue %StatementParseResult %t206, %Statement %t207, 1
  ret %StatementParseResult %t208
}

define %StatementParseResult @parse_interface(%Parser %initial_parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %Token
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca %TypeParameterParseResult
  %l6 = alloca { %TypeParameter**, i64 }*
  %l7 = alloca { %FunctionSignature*, i64 }*
  %l8 = alloca %Token
  %l9 = alloca %Parser
  %l10 = alloca %DecoratorParseResult
  %l11 = alloca { %Decorator**, i64 }*
  %l12 = alloca %InterfaceMemberParseResult
  %l13 = alloca %Statement
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Parser @skip_trivia(%Parser %t1)
  store %Parser %t2, %Parser* %l0
  %t3 = load %Parser, %Parser* %l0
  %s4 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.4, i32 0, i32 0
  %t5 = call %Parser @consume_keyword(%Parser %t3, i8* %s4)
  store %Parser %t5, %Parser* %l0
  %t6 = load %Parser, %Parser* %l0
  %t7 = call %Parser @skip_trivia(%Parser %t6)
  store %Parser %t7, %Parser* %l0
  %t8 = load %Parser, %Parser* %l0
  %t9 = call %Token @parser_peek_raw(%Parser %t8)
  store %Token %t9, %Token* %l2
  %t10 = load %Token, %Token* %l2
  %t11 = extractvalue %Token %t10, 0
  %t12 = extractvalue %TokenKind %t11, 0
  %t13 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t14 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t15 = icmp eq i32 %t12, 0
  %t16 = select i1 %t15, i8* %t14, i8* %t13
  %t17 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t12, 1
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t12, 2
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t12, 3
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t12, 4
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t12, 5
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t12, 6
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t12, 7
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %s38 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.38, i32 0, i32 0
  %t39 = icmp ne i8* %t37, %s38
  %t40 = load %Parser, %Parser* %l0
  %t41 = load %Parser, %Parser* %l1
  %t42 = load %Token, %Token* %l2
  br i1 %t39, label %then0, label %merge1
then0:
  %t43 = load %Parser, %Parser* %l1
  %t44 = call %StatementParseResult @parse_unknown(%Parser %t43)
  ret %StatementParseResult %t44
merge1:
  %t45 = load %Token, %Token* %l2
  %t46 = call i8* @identifier_text(%Token %t45)
  store i8* %t46, i8** %l3
  %t47 = load %Token, %Token* %l2
  %t48 = alloca [1 x %Token]
  %t49 = getelementptr [1 x %Token], [1 x %Token]* %t48, i32 0, i32 0
  %t50 = getelementptr %Token, %Token* %t49, i64 0
  store %Token %t47, %Token* %t50
  %t51 = alloca { %Token*, i64 }
  %t52 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t51, i32 0, i32 0
  store %Token* %t49, %Token** %t52
  %t53 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t51, i32 0, i32 1
  store i64 1, i64* %t53
  %t54 = call double @source_span_from_tokens({ %Token*, i64 }* %t51)
  store double %t54, double* %l4
  %t55 = load %Parser, %Parser* %l0
  %t56 = call %Parser @parser_advance_raw(%Parser %t55)
  store %Parser %t56, %Parser* %l0
  %t57 = load %Parser, %Parser* %l0
  %t58 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %t57)
  store %TypeParameterParseResult %t58, %TypeParameterParseResult* %l5
  %t59 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t60 = extractvalue %TypeParameterParseResult %t59, 0
  store %Parser %t60, %Parser* %l0
  %t61 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t62 = extractvalue %TypeParameterParseResult %t61, 1
  store { %TypeParameter**, i64 }* %t62, { %TypeParameter**, i64 }** %l6
  %t63 = load %Parser, %Parser* %l0
  %t64 = call %Parser @skip_trivia(%Parser %t63)
  store %Parser %t64, %Parser* %l0
  %t65 = load %Parser, %Parser* %l0
  %t66 = alloca [2 x i8], align 1
  %t67 = getelementptr [2 x i8], [2 x i8]* %t66, i32 0, i32 0
  store i8 123, i8* %t67
  %t68 = getelementptr [2 x i8], [2 x i8]* %t66, i32 0, i32 1
  store i8 0, i8* %t68
  %t69 = getelementptr [2 x i8], [2 x i8]* %t66, i32 0, i32 0
  %t70 = call %Parser @advance_to_symbol(%Parser %t65, i8* %t69)
  store %Parser %t70, %Parser* %l0
  %t71 = load %Parser, %Parser* %l0
  %t72 = alloca [2 x i8], align 1
  %t73 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 0
  store i8 123, i8* %t73
  %t74 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 1
  store i8 0, i8* %t74
  %t75 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 0
  %t76 = call %Parser @consume_symbol(%Parser %t71, i8* %t75)
  store %Parser %t76, %Parser* %l0
  %t77 = alloca [0 x %FunctionSignature]
  %t78 = getelementptr [0 x %FunctionSignature], [0 x %FunctionSignature]* %t77, i32 0, i32 0
  %t79 = alloca { %FunctionSignature*, i64 }
  %t80 = getelementptr { %FunctionSignature*, i64 }, { %FunctionSignature*, i64 }* %t79, i32 0, i32 0
  store %FunctionSignature* %t78, %FunctionSignature** %t80
  %t81 = getelementptr { %FunctionSignature*, i64 }, { %FunctionSignature*, i64 }* %t79, i32 0, i32 1
  store i64 0, i64* %t81
  store { %FunctionSignature*, i64 }* %t79, { %FunctionSignature*, i64 }** %l7
  %t82 = load %Parser, %Parser* %l0
  %t83 = load %Parser, %Parser* %l1
  %t84 = load %Token, %Token* %l2
  %t85 = load i8*, i8** %l3
  %t86 = load double, double* %l4
  %t87 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t88 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l6
  %t89 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %l7
  br label %loop.header2
loop.header2:
  %t203 = phi %Parser [ %t82, %entry ], [ %t202, %loop.latch4 ]
  store %Parser %t203, %Parser* %l0
  br label %loop.body3
loop.body3:
  %t90 = load %Parser, %Parser* %l0
  %t91 = call %Parser @skip_trivia(%Parser %t90)
  store %Parser %t91, %Parser* %l0
  %t92 = load %Parser, %Parser* %l0
  %t93 = call %Token @parser_peek_raw(%Parser %t92)
  store %Token %t93, %Token* %l8
  %t95 = load %Token, %Token* %l8
  %t96 = extractvalue %Token %t95, 0
  %t97 = extractvalue %TokenKind %t96, 0
  %t98 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t99 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t97, 0
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t97, 1
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t106 = icmp eq i32 %t97, 2
  %t107 = select i1 %t106, i8* %t105, i8* %t104
  %t108 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t97, 3
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t112 = icmp eq i32 %t97, 4
  %t113 = select i1 %t112, i8* %t111, i8* %t110
  %t114 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t97, 5
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %t117 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t118 = icmp eq i32 %t97, 6
  %t119 = select i1 %t118, i8* %t117, i8* %t116
  %t120 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t97, 7
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %s123 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.123, i32 0, i32 0
  %t124 = icmp eq i8* %t122, %s123
  br label %logical_and_entry_94

logical_and_entry_94:
  br i1 %t124, label %logical_and_right_94, label %logical_and_merge_94

logical_and_right_94:
  %t125 = load %Token, %Token* %l8
  %t126 = extractvalue %Token %t125, 0
  %t127 = extractvalue %TokenKind %t126, 0
  %t128 = load %Token, %Token* %l8
  %t129 = extractvalue %Token %t128, 0
  %t130 = extractvalue %TokenKind %t129, 0
  %t131 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t132 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t130, 0
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t130, 1
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t130, 2
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t130, 3
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t130, 4
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t130, 5
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t130, 6
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t130, 7
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %s156 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.156, i32 0, i32 0
  %t157 = icmp eq i8* %t155, %s156
  %t158 = load %Parser, %Parser* %l0
  %t159 = load %Parser, %Parser* %l1
  %t160 = load %Token, %Token* %l2
  %t161 = load i8*, i8** %l3
  %t162 = load double, double* %l4
  %t163 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t164 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l6
  %t165 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %l7
  %t166 = load %Token, %Token* %l8
  br i1 %t157, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t167 = load %Parser, %Parser* %l0
  store %Parser %t167, %Parser* %l9
  %t168 = load %Parser, %Parser* %l0
  %t169 = call %DecoratorParseResult @parse_decorators(%Parser %t168)
  store %DecoratorParseResult %t169, %DecoratorParseResult* %l10
  %t170 = load %DecoratorParseResult, %DecoratorParseResult* %l10
  %t171 = extractvalue %DecoratorParseResult %t170, 0
  store %Parser %t171, %Parser* %l0
  %t172 = load %DecoratorParseResult, %DecoratorParseResult* %l10
  %t173 = extractvalue %DecoratorParseResult %t172, 1
  store { %Decorator**, i64 }* %t173, { %Decorator**, i64 }** %l11
  %t174 = load %Parser, %Parser* %l0
  %t175 = call %Parser @skip_trivia(%Parser %t174)
  store %Parser %t175, %Parser* %l0
  %t176 = load %Parser, %Parser* %l0
  %t177 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l11
  %t178 = bitcast { %Decorator**, i64 }* %t177 to { %Decorator*, i64 }*
  %t179 = call %InterfaceMemberParseResult @parse_interface_member(%Parser %t176, { %Decorator*, i64 }* %t178)
  store %InterfaceMemberParseResult %t179, %InterfaceMemberParseResult* %l12
  %t180 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l12
  %t181 = extractvalue %InterfaceMemberParseResult %t180, 2
  %t182 = load %Parser, %Parser* %l0
  %t183 = load %Parser, %Parser* %l1
  %t184 = load %Token, %Token* %l2
  %t185 = load i8*, i8** %l3
  %t186 = load double, double* %l4
  %t187 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t188 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l6
  %t189 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %l7
  %t190 = load %Token, %Token* %l8
  %t191 = load %Parser, %Parser* %l9
  %t192 = load %DecoratorParseResult, %DecoratorParseResult* %l10
  %t193 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l11
  %t194 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l12
  br i1 %t181, label %then8, label %merge9
then8:
  %t195 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l12
  %t196 = extractvalue %InterfaceMemberParseResult %t195, 0
  store %Parser %t196, %Parser* %l0
  %t197 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l12
  %t198 = extractvalue %InterfaceMemberParseResult %t197, 1
  %t199 = bitcast i8* null to %FunctionSignature*
  br label %loop.latch4
merge9:
  %t200 = load %Parser, %Parser* %l9
  %t201 = call %Parser @skip_struct_member(%Parser %t200)
  store %Parser %t201, %Parser* %l0
  br label %loop.latch4
loop.latch4:
  %t202 = load %Parser, %Parser* %l0
  br label %loop.header2
afterloop5:
  %t204 = alloca %Statement
  %t205 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 0
  store i32 10, i32* %t205
  %t206 = load i8*, i8** %l3
  %t207 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 1
  %t208 = bitcast [40 x i8]* %t207 to i8*
  %t209 = bitcast i8* %t208 to i8**
  store i8* %t206, i8** %t209
  %t210 = load double, double* %l4
  %t211 = call noalias i8* @malloc(i64 8)
  %t212 = bitcast i8* %t211 to double*
  store double %t210, double* %t212
  %t213 = bitcast i8* %t211 to %SourceSpan*
  %t214 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 1
  %t215 = bitcast [40 x i8]* %t214 to i8*
  %t216 = getelementptr inbounds i8, i8* %t215, i64 8
  %t217 = bitcast i8* %t216 to %SourceSpan**
  store %SourceSpan* %t213, %SourceSpan** %t217
  %t218 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l6
  %t219 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 1
  %t220 = bitcast [40 x i8]* %t219 to i8*
  %t221 = getelementptr inbounds i8, i8* %t220, i64 16
  %t222 = bitcast i8* %t221 to { %TypeParameter**, i64 }**
  store { %TypeParameter**, i64 }* %t218, { %TypeParameter**, i64 }** %t222
  %t223 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %l7
  %t224 = bitcast { %FunctionSignature*, i64 }* %t223 to { %FunctionSignature**, i64 }*
  %t225 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 1
  %t226 = bitcast [40 x i8]* %t225 to i8*
  %t227 = getelementptr inbounds i8, i8* %t226, i64 24
  %t228 = bitcast i8* %t227 to { %FunctionSignature**, i64 }**
  store { %FunctionSignature**, i64 }* %t224, { %FunctionSignature**, i64 }** %t228
  %t229 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t230 = getelementptr inbounds %Statement, %Statement* %t204, i32 0, i32 1
  %t231 = bitcast [40 x i8]* %t230 to i8*
  %t232 = getelementptr inbounds i8, i8* %t231, i64 32
  %t233 = bitcast i8* %t232 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t229, { %Decorator**, i64 }** %t233
  %t234 = load %Statement, %Statement* %t204
  store %Statement %t234, %Statement* %l13
  %t235 = load %Parser, %Parser* %l0
  %t236 = insertvalue %StatementParseResult undef, %Parser %t235, 0
  %t237 = load %Statement, %Statement* %l13
  %t238 = insertvalue %StatementParseResult %t236, %Statement %t237, 1
  ret %StatementParseResult %t238
}

define %StatementParseResult @parse_enum(%Parser %initial_parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %Token
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca %TypeParameterParseResult
  %l6 = alloca { %TypeParameter**, i64 }*
  %l7 = alloca { %EnumVariant*, i64 }*
  %l8 = alloca %Token
  %l9 = alloca %EnumVariantParseResult
  %l10 = alloca %Statement
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Parser @skip_trivia(%Parser %t1)
  store %Parser %t2, %Parser* %l0
  %t3 = load %Parser, %Parser* %l0
  %s4 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.4, i32 0, i32 0
  %t5 = call %Parser @consume_keyword(%Parser %t3, i8* %s4)
  store %Parser %t5, %Parser* %l0
  %t6 = load %Parser, %Parser* %l0
  %t7 = call %Parser @skip_trivia(%Parser %t6)
  store %Parser %t7, %Parser* %l0
  %t8 = load %Parser, %Parser* %l0
  %t9 = call %Token @parser_peek_raw(%Parser %t8)
  store %Token %t9, %Token* %l2
  %t10 = load %Token, %Token* %l2
  %t11 = extractvalue %Token %t10, 0
  %t12 = extractvalue %TokenKind %t11, 0
  %t13 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t14 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t15 = icmp eq i32 %t12, 0
  %t16 = select i1 %t15, i8* %t14, i8* %t13
  %t17 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t12, 1
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t12, 2
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t12, 3
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t12, 4
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t12, 5
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t12, 6
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t12, 7
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %s38 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.38, i32 0, i32 0
  %t39 = icmp ne i8* %t37, %s38
  %t40 = load %Parser, %Parser* %l0
  %t41 = load %Parser, %Parser* %l1
  %t42 = load %Token, %Token* %l2
  br i1 %t39, label %then0, label %merge1
then0:
  %t43 = load %Parser, %Parser* %l1
  %t44 = call %StatementParseResult @parse_unknown(%Parser %t43)
  ret %StatementParseResult %t44
merge1:
  %t45 = load %Token, %Token* %l2
  %t46 = call i8* @identifier_text(%Token %t45)
  store i8* %t46, i8** %l3
  %t47 = load %Token, %Token* %l2
  %t48 = alloca [1 x %Token]
  %t49 = getelementptr [1 x %Token], [1 x %Token]* %t48, i32 0, i32 0
  %t50 = getelementptr %Token, %Token* %t49, i64 0
  store %Token %t47, %Token* %t50
  %t51 = alloca { %Token*, i64 }
  %t52 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t51, i32 0, i32 0
  store %Token* %t49, %Token** %t52
  %t53 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t51, i32 0, i32 1
  store i64 1, i64* %t53
  %t54 = call double @source_span_from_tokens({ %Token*, i64 }* %t51)
  store double %t54, double* %l4
  %t55 = load %Parser, %Parser* %l0
  %t56 = call %Parser @parser_advance_raw(%Parser %t55)
  store %Parser %t56, %Parser* %l0
  %t57 = load %Parser, %Parser* %l0
  %t58 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %t57)
  store %TypeParameterParseResult %t58, %TypeParameterParseResult* %l5
  %t59 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t60 = extractvalue %TypeParameterParseResult %t59, 0
  store %Parser %t60, %Parser* %l0
  %t61 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t62 = extractvalue %TypeParameterParseResult %t61, 1
  store { %TypeParameter**, i64 }* %t62, { %TypeParameter**, i64 }** %l6
  %t63 = load %Parser, %Parser* %l0
  %t64 = call %Parser @skip_trivia(%Parser %t63)
  store %Parser %t64, %Parser* %l0
  %t65 = load %Parser, %Parser* %l0
  %t66 = alloca [2 x i8], align 1
  %t67 = getelementptr [2 x i8], [2 x i8]* %t66, i32 0, i32 0
  store i8 123, i8* %t67
  %t68 = getelementptr [2 x i8], [2 x i8]* %t66, i32 0, i32 1
  store i8 0, i8* %t68
  %t69 = getelementptr [2 x i8], [2 x i8]* %t66, i32 0, i32 0
  %t70 = call %Parser @advance_to_symbol(%Parser %t65, i8* %t69)
  store %Parser %t70, %Parser* %l0
  %t71 = load %Parser, %Parser* %l0
  %t72 = alloca [2 x i8], align 1
  %t73 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 0
  store i8 123, i8* %t73
  %t74 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 1
  store i8 0, i8* %t74
  %t75 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 0
  %t76 = call %Parser @consume_symbol(%Parser %t71, i8* %t75)
  store %Parser %t76, %Parser* %l0
  %t77 = alloca [0 x %EnumVariant]
  %t78 = getelementptr [0 x %EnumVariant], [0 x %EnumVariant]* %t77, i32 0, i32 0
  %t79 = alloca { %EnumVariant*, i64 }
  %t80 = getelementptr { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %t79, i32 0, i32 0
  store %EnumVariant* %t78, %EnumVariant** %t80
  %t81 = getelementptr { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %t79, i32 0, i32 1
  store i64 0, i64* %t81
  store { %EnumVariant*, i64 }* %t79, { %EnumVariant*, i64 }** %l7
  %t82 = load %Parser, %Parser* %l0
  %t83 = load %Parser, %Parser* %l1
  %t84 = load %Token, %Token* %l2
  %t85 = load i8*, i8** %l3
  %t86 = load double, double* %l4
  %t87 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t88 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l6
  %t89 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %l7
  br label %loop.header2
loop.header2:
  %t191 = phi %Parser [ %t82, %entry ], [ %t190, %loop.latch4 ]
  store %Parser %t191, %Parser* %l0
  br label %loop.body3
loop.body3:
  %t90 = load %Parser, %Parser* %l0
  %t91 = call %Parser @skip_trivia(%Parser %t90)
  store %Parser %t91, %Parser* %l0
  %t92 = load %Parser, %Parser* %l0
  %t93 = call %Token @parser_peek_raw(%Parser %t92)
  store %Token %t93, %Token* %l8
  %t95 = load %Token, %Token* %l8
  %t96 = extractvalue %Token %t95, 0
  %t97 = extractvalue %TokenKind %t96, 0
  %t98 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t99 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t97, 0
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t97, 1
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t106 = icmp eq i32 %t97, 2
  %t107 = select i1 %t106, i8* %t105, i8* %t104
  %t108 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t97, 3
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t112 = icmp eq i32 %t97, 4
  %t113 = select i1 %t112, i8* %t111, i8* %t110
  %t114 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t97, 5
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %t117 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t118 = icmp eq i32 %t97, 6
  %t119 = select i1 %t118, i8* %t117, i8* %t116
  %t120 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t97, 7
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %s123 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.123, i32 0, i32 0
  %t124 = icmp eq i8* %t122, %s123
  br label %logical_and_entry_94

logical_and_entry_94:
  br i1 %t124, label %logical_and_right_94, label %logical_and_merge_94

logical_and_right_94:
  %t125 = load %Token, %Token* %l8
  %t126 = extractvalue %Token %t125, 0
  %t127 = extractvalue %TokenKind %t126, 0
  %t128 = load %Token, %Token* %l8
  %t129 = extractvalue %Token %t128, 0
  %t130 = extractvalue %TokenKind %t129, 0
  %t131 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t132 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t130, 0
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t130, 1
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t130, 2
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t130, 3
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t130, 4
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t130, 5
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t130, 6
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t130, 7
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %s156 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.156, i32 0, i32 0
  %t157 = icmp eq i8* %t155, %s156
  %t158 = load %Parser, %Parser* %l0
  %t159 = load %Parser, %Parser* %l1
  %t160 = load %Token, %Token* %l2
  %t161 = load i8*, i8** %l3
  %t162 = load double, double* %l4
  %t163 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t164 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l6
  %t165 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %l7
  %t166 = load %Token, %Token* %l8
  br i1 %t157, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t167 = load %Parser, %Parser* %l0
  %t168 = call %EnumVariantParseResult @parse_enum_variant(%Parser %t167)
  store %EnumVariantParseResult %t168, %EnumVariantParseResult* %l9
  %t169 = load %EnumVariantParseResult, %EnumVariantParseResult* %l9
  %t170 = extractvalue %EnumVariantParseResult %t169, 2
  %t171 = load %Parser, %Parser* %l0
  %t172 = load %Parser, %Parser* %l1
  %t173 = load %Token, %Token* %l2
  %t174 = load i8*, i8** %l3
  %t175 = load double, double* %l4
  %t176 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t177 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l6
  %t178 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %l7
  %t179 = load %Token, %Token* %l8
  %t180 = load %EnumVariantParseResult, %EnumVariantParseResult* %l9
  br i1 %t170, label %then8, label %merge9
then8:
  %t181 = load %EnumVariantParseResult, %EnumVariantParseResult* %l9
  %t182 = extractvalue %EnumVariantParseResult %t181, 0
  store %Parser %t182, %Parser* %l0
  %t183 = load %EnumVariantParseResult, %EnumVariantParseResult* %l9
  %t184 = extractvalue %EnumVariantParseResult %t183, 1
  %t185 = bitcast i8* null to %EnumVariant*
  %t186 = load %Parser, %Parser* %l0
  %t187 = call %Parser @skip_trailing_comma(%Parser %t186)
  store %Parser %t187, %Parser* %l0
  br label %loop.latch4
merge9:
  %t188 = load %Parser, %Parser* %l0
  %t189 = call %Parser @skip_struct_member(%Parser %t188)
  store %Parser %t189, %Parser* %l0
  br label %loop.latch4
loop.latch4:
  %t190 = load %Parser, %Parser* %l0
  br label %loop.header2
afterloop5:
  %t192 = alloca %Statement
  %t193 = getelementptr inbounds %Statement, %Statement* %t192, i32 0, i32 0
  store i32 11, i32* %t193
  %t194 = load i8*, i8** %l3
  %t195 = getelementptr inbounds %Statement, %Statement* %t192, i32 0, i32 1
  %t196 = bitcast [40 x i8]* %t195 to i8*
  %t197 = bitcast i8* %t196 to i8**
  store i8* %t194, i8** %t197
  %t198 = load double, double* %l4
  %t199 = call noalias i8* @malloc(i64 8)
  %t200 = bitcast i8* %t199 to double*
  store double %t198, double* %t200
  %t201 = bitcast i8* %t199 to %SourceSpan*
  %t202 = getelementptr inbounds %Statement, %Statement* %t192, i32 0, i32 1
  %t203 = bitcast [40 x i8]* %t202 to i8*
  %t204 = getelementptr inbounds i8, i8* %t203, i64 8
  %t205 = bitcast i8* %t204 to %SourceSpan**
  store %SourceSpan* %t201, %SourceSpan** %t205
  %t206 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l6
  %t207 = getelementptr inbounds %Statement, %Statement* %t192, i32 0, i32 1
  %t208 = bitcast [40 x i8]* %t207 to i8*
  %t209 = getelementptr inbounds i8, i8* %t208, i64 16
  %t210 = bitcast i8* %t209 to { %TypeParameter**, i64 }**
  store { %TypeParameter**, i64 }* %t206, { %TypeParameter**, i64 }** %t210
  %t211 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %l7
  %t212 = bitcast { %EnumVariant*, i64 }* %t211 to { %EnumVariant**, i64 }*
  %t213 = getelementptr inbounds %Statement, %Statement* %t192, i32 0, i32 1
  %t214 = bitcast [40 x i8]* %t213 to i8*
  %t215 = getelementptr inbounds i8, i8* %t214, i64 24
  %t216 = bitcast i8* %t215 to { %EnumVariant**, i64 }**
  store { %EnumVariant**, i64 }* %t212, { %EnumVariant**, i64 }** %t216
  %t217 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t218 = getelementptr inbounds %Statement, %Statement* %t192, i32 0, i32 1
  %t219 = bitcast [40 x i8]* %t218 to i8*
  %t220 = getelementptr inbounds i8, i8* %t219, i64 32
  %t221 = bitcast i8* %t220 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t217, { %Decorator**, i64 }** %t221
  %t222 = load %Statement, %Statement* %t192
  store %Statement %t222, %Statement* %l10
  %t223 = load %Parser, %Parser* %l0
  %t224 = insertvalue %StatementParseResult undef, %Parser %t223, 0
  %t225 = load %Statement, %Statement* %l10
  %t226 = insertvalue %StatementParseResult %t224, %Statement %t225, 1
  ret %StatementParseResult %t226
}

define %InterfaceMemberParseResult @parse_interface_member(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca i1
  %l3 = alloca %Token
  %l4 = alloca %Parser
  %l5 = alloca %Token
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca %TypeParameterParseResult
  %l9 = alloca { %TypeParameter**, i64 }*
  %l10 = alloca %ParameterListParseResult
  %l11 = alloca { %Parameter**, i64 }*
  %l12 = alloca i8*
  %l13 = alloca %Token
  %l14 = alloca %EffectParseResult
  %l15 = alloca { i8**, i64 }*
  %l16 = alloca double
  %l17 = alloca double
  %l18 = alloca %Token
  %l19 = alloca %FunctionSignature
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  store i1 0, i1* %l2
  %t1 = load %Parser, %Parser* %l1
  %t2 = call %Token @parser_peek_raw(%Parser %t1)
  store %Token %t2, %Token* %l3
  %t3 = load %Token, %Token* %l3
  %s4 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.4, i32 0, i32 0
  %t5 = call i1 @identifier_matches(%Token %t3, i8* %s4)
  %t6 = load %Parser, %Parser* %l0
  %t7 = load %Parser, %Parser* %l1
  %t8 = load i1, i1* %l2
  %t9 = load %Token, %Token* %l3
  br i1 %t5, label %then0, label %merge1
then0:
  %t10 = load %Parser, %Parser* %l1
  %t11 = call %Parser @parser_advance_raw(%Parser %t10)
  %t12 = call %Parser @skip_trivia(%Parser %t11)
  store %Parser %t12, %Parser* %l4
  %t13 = load %Parser, %Parser* %l4
  %t14 = call %Token @parser_peek_raw(%Parser %t13)
  %s15 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.15, i32 0, i32 0
  %t16 = call i1 @identifier_matches(%Token %t14, i8* %s15)
  %t17 = load %Parser, %Parser* %l0
  %t18 = load %Parser, %Parser* %l1
  %t19 = load i1, i1* %l2
  %t20 = load %Token, %Token* %l3
  %t21 = load %Parser, %Parser* %l4
  br i1 %t16, label %then2, label %merge3
then2:
  %t22 = load %Parser, %Parser* %l1
  %s23 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.23, i32 0, i32 0
  %t24 = call %Parser @consume_keyword(%Parser %t22, i8* %s23)
  store %Parser %t24, %Parser* %l1
  store i1 1, i1* %l2
  br label %merge3
merge3:
  %t25 = phi %Parser [ %t24, %then2 ], [ %t18, %then0 ]
  %t26 = phi i1 [ 1, %then2 ], [ %t19, %then0 ]
  store %Parser %t25, %Parser* %l1
  store i1 %t26, i1* %l2
  br label %merge1
merge1:
  %t27 = phi %Parser [ %t24, %then0 ], [ %t7, %entry ]
  %t28 = phi i1 [ 1, %then0 ], [ %t8, %entry ]
  store %Parser %t27, %Parser* %l1
  store i1 %t28, i1* %l2
  %t29 = load %Parser, %Parser* %l1
  %t30 = call %Parser @skip_trivia(%Parser %t29)
  store %Parser %t30, %Parser* %l1
  %t31 = load %Parser, %Parser* %l1
  %t32 = call %Token @parser_peek_raw(%Parser %t31)
  %s33 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.33, i32 0, i32 0
  %t34 = call i1 @identifier_matches(%Token %t32, i8* %s33)
  %t35 = xor i1 %t34, 1
  %t36 = load %Parser, %Parser* %l0
  %t37 = load %Parser, %Parser* %l1
  %t38 = load i1, i1* %l2
  %t39 = load %Token, %Token* %l3
  br i1 %t35, label %then4, label %merge5
then4:
  %t40 = load %Parser, %Parser* %l0
  %t41 = insertvalue %InterfaceMemberParseResult undef, %Parser %t40, 0
  %t42 = bitcast i8* null to %FunctionSignature*
  %t43 = insertvalue %InterfaceMemberParseResult %t41, %FunctionSignature* %t42, 1
  %t44 = insertvalue %InterfaceMemberParseResult %t43, i1 0, 2
  ret %InterfaceMemberParseResult %t44
merge5:
  %t45 = load %Parser, %Parser* %l1
  %s46 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.46, i32 0, i32 0
  %t47 = call %Parser @consume_keyword(%Parser %t45, i8* %s46)
  store %Parser %t47, %Parser* %l1
  %t48 = load %Parser, %Parser* %l1
  %t49 = call %Parser @skip_trivia(%Parser %t48)
  store %Parser %t49, %Parser* %l1
  %t50 = load %Parser, %Parser* %l1
  %t51 = call %Token @parser_peek_raw(%Parser %t50)
  store %Token %t51, %Token* %l5
  %t52 = load %Token, %Token* %l5
  %t53 = extractvalue %Token %t52, 0
  %t54 = extractvalue %TokenKind %t53, 0
  %t55 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t56 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t57 = icmp eq i32 %t54, 0
  %t58 = select i1 %t57, i8* %t56, i8* %t55
  %t59 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t60 = icmp eq i32 %t54, 1
  %t61 = select i1 %t60, i8* %t59, i8* %t58
  %t62 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t54, 2
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t54, 3
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t54, 4
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t54, 5
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t75 = icmp eq i32 %t54, 6
  %t76 = select i1 %t75, i8* %t74, i8* %t73
  %t77 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t78 = icmp eq i32 %t54, 7
  %t79 = select i1 %t78, i8* %t77, i8* %t76
  %s80 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.80, i32 0, i32 0
  %t81 = icmp ne i8* %t79, %s80
  %t82 = load %Parser, %Parser* %l0
  %t83 = load %Parser, %Parser* %l1
  %t84 = load i1, i1* %l2
  %t85 = load %Token, %Token* %l3
  %t86 = load %Token, %Token* %l5
  br i1 %t81, label %then6, label %merge7
then6:
  %t87 = load %Parser, %Parser* %l0
  %t88 = insertvalue %InterfaceMemberParseResult undef, %Parser %t87, 0
  %t89 = bitcast i8* null to %FunctionSignature*
  %t90 = insertvalue %InterfaceMemberParseResult %t88, %FunctionSignature* %t89, 1
  %t91 = insertvalue %InterfaceMemberParseResult %t90, i1 0, 2
  ret %InterfaceMemberParseResult %t91
merge7:
  %t92 = load %Token, %Token* %l5
  %t93 = call i8* @identifier_text(%Token %t92)
  store i8* %t93, i8** %l6
  %t94 = load %Token, %Token* %l5
  %t95 = alloca [1 x %Token]
  %t96 = getelementptr [1 x %Token], [1 x %Token]* %t95, i32 0, i32 0
  %t97 = getelementptr %Token, %Token* %t96, i64 0
  store %Token %t94, %Token* %t97
  %t98 = alloca { %Token*, i64 }
  %t99 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t98, i32 0, i32 0
  store %Token* %t96, %Token** %t99
  %t100 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t98, i32 0, i32 1
  store i64 1, i64* %t100
  %t101 = call double @source_span_from_tokens({ %Token*, i64 }* %t98)
  store double %t101, double* %l7
  %t102 = load %Parser, %Parser* %l1
  %t103 = call %Parser @parser_advance_raw(%Parser %t102)
  store %Parser %t103, %Parser* %l1
  %t104 = load %Parser, %Parser* %l1
  %t105 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %t104)
  store %TypeParameterParseResult %t105, %TypeParameterParseResult* %l8
  %t106 = load %TypeParameterParseResult, %TypeParameterParseResult* %l8
  %t107 = extractvalue %TypeParameterParseResult %t106, 0
  store %Parser %t107, %Parser* %l1
  %t108 = load %TypeParameterParseResult, %TypeParameterParseResult* %l8
  %t109 = extractvalue %TypeParameterParseResult %t108, 1
  store { %TypeParameter**, i64 }* %t109, { %TypeParameter**, i64 }** %l9
  %t110 = load %Parser, %Parser* %l1
  %t111 = call %Parser @skip_trivia(%Parser %t110)
  store %Parser %t111, %Parser* %l1
  %t112 = load %Parser, %Parser* %l1
  %t113 = alloca [2 x i8], align 1
  %t114 = getelementptr [2 x i8], [2 x i8]* %t113, i32 0, i32 0
  store i8 40, i8* %t114
  %t115 = getelementptr [2 x i8], [2 x i8]* %t113, i32 0, i32 1
  store i8 0, i8* %t115
  %t116 = getelementptr [2 x i8], [2 x i8]* %t113, i32 0, i32 0
  %t117 = call %Parser @consume_symbol(%Parser %t112, i8* %t116)
  store %Parser %t117, %Parser* %l1
  %t118 = load %Parser, %Parser* %l1
  %t119 = call %ParameterListParseResult @parse_parameter_list(%Parser %t118)
  store %ParameterListParseResult %t119, %ParameterListParseResult* %l10
  %t120 = load %ParameterListParseResult, %ParameterListParseResult* %l10
  %t121 = extractvalue %ParameterListParseResult %t120, 0
  store %Parser %t121, %Parser* %l1
  %t122 = load %ParameterListParseResult, %ParameterListParseResult* %l10
  %t123 = extractvalue %ParameterListParseResult %t122, 1
  store { %Parameter**, i64 }* %t123, { %Parameter**, i64 }** %l11
  %t124 = load %Parser, %Parser* %l1
  %t125 = call %Parser @skip_trivia(%Parser %t124)
  store %Parser %t125, %Parser* %l1
  store i8* null, i8** %l12
  %t126 = load %Parser, %Parser* %l1
  %t127 = call %Token @parser_peek_raw(%Parser %t126)
  store %Token %t127, %Token* %l13
  %t130 = load %Token, %Token* %l13
  %t131 = extractvalue %Token %t130, 0
  %t132 = extractvalue %TokenKind %t131, 0
  %t133 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t134 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t132, 0
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t132, 1
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t132, 2
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t132, 3
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t132, 4
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t132, 5
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t132, 6
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t132, 7
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %s158 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.158, i32 0, i32 0
  %t159 = icmp eq i8* %t157, %s158
  br label %logical_and_entry_129

logical_and_entry_129:
  br i1 %t159, label %logical_and_right_129, label %logical_and_merge_129

logical_and_right_129:
  %t160 = load %Token, %Token* %l13
  %t161 = extractvalue %Token %t160, 0
  %t162 = extractvalue %TokenKind %t161, 0
  %t163 = load %Parser, %Parser* %l1
  %t164 = call %EffectParseResult @parse_effect_list(%Parser %t163)
  store %EffectParseResult %t164, %EffectParseResult* %l14
  %t165 = load %EffectParseResult, %EffectParseResult* %l14
  %t166 = extractvalue %EffectParseResult %t165, 0
  store %Parser %t166, %Parser* %l1
  %t167 = load %EffectParseResult, %EffectParseResult* %l14
  %t168 = extractvalue %EffectParseResult %t167, 1
  store { i8**, i64 }* %t168, { i8**, i64 }** %l15
  %t169 = call double @evaluate_decorators({ %Decorator*, i64 }* %decorators)
  store double %t169, double* %l16
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t171 = load double, double* %l16
  %t172 = call double @infer_effects({ i8**, i64 }* %t170, double %t171)
  store double %t172, double* %l17
  %t173 = load %Parser, %Parser* %l1
  %t174 = call %Parser @skip_trivia(%Parser %t173)
  store %Parser %t174, %Parser* %l1
  %t175 = load %Parser, %Parser* %l1
  %t176 = extractvalue %Parser %t175, 1
  %t177 = load %Parser, %Parser* %l1
  %t178 = extractvalue %Parser %t177, 0
  %t179 = load { %Token**, i64 }, { %Token**, i64 }* %t178
  %t180 = extractvalue { %Token**, i64 } %t179, 1
  %t181 = sitofp i64 %t180 to double
  %t182 = fcmp olt double %t176, %t181
  %t183 = load %Parser, %Parser* %l0
  %t184 = load %Parser, %Parser* %l1
  %t185 = load i1, i1* %l2
  %t186 = load %Token, %Token* %l3
  %t187 = load %Token, %Token* %l5
  %t188 = load i8*, i8** %l6
  %t189 = load double, double* %l7
  %t190 = load %TypeParameterParseResult, %TypeParameterParseResult* %l8
  %t191 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l9
  %t192 = load %ParameterListParseResult, %ParameterListParseResult* %l10
  %t193 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %l11
  %t194 = load i8*, i8** %l12
  %t195 = load %Token, %Token* %l13
  %t196 = load %EffectParseResult, %EffectParseResult* %l14
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t198 = load double, double* %l16
  %t199 = load double, double* %l17
  br i1 %t182, label %then8, label %merge9
then8:
  %t200 = load %Parser, %Parser* %l1
  %t201 = call %Token @parser_peek_raw(%Parser %t200)
  store %Token %t201, %Token* %l18
  %t203 = load %Token, %Token* %l18
  %t204 = extractvalue %Token %t203, 0
  %t205 = extractvalue %TokenKind %t204, 0
  %t206 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t207 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t208 = icmp eq i32 %t205, 0
  %t209 = select i1 %t208, i8* %t207, i8* %t206
  %t210 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t211 = icmp eq i32 %t205, 1
  %t212 = select i1 %t211, i8* %t210, i8* %t209
  %t213 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t214 = icmp eq i32 %t205, 2
  %t215 = select i1 %t214, i8* %t213, i8* %t212
  %t216 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t217 = icmp eq i32 %t205, 3
  %t218 = select i1 %t217, i8* %t216, i8* %t215
  %t219 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t220 = icmp eq i32 %t205, 4
  %t221 = select i1 %t220, i8* %t219, i8* %t218
  %t222 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t223 = icmp eq i32 %t205, 5
  %t224 = select i1 %t223, i8* %t222, i8* %t221
  %t225 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t226 = icmp eq i32 %t205, 6
  %t227 = select i1 %t226, i8* %t225, i8* %t224
  %t228 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t229 = icmp eq i32 %t205, 7
  %t230 = select i1 %t229, i8* %t228, i8* %t227
  %s231 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.231, i32 0, i32 0
  %t232 = icmp eq i8* %t230, %s231
  br label %logical_and_entry_202

logical_and_entry_202:
  br i1 %t232, label %logical_and_right_202, label %logical_and_merge_202

logical_and_right_202:
  %t233 = load %Token, %Token* %l18
  %t234 = extractvalue %Token %t233, 0
  %t235 = extractvalue %TokenKind %t234, 0
  br label %merge9
merge9:
  %t236 = load i8*, i8** %l6
  %t237 = insertvalue %FunctionSignature undef, i8* %t236, 0
  %t238 = load i1, i1* %l2
  %t239 = insertvalue %FunctionSignature %t237, i1 %t238, 1
  %t240 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %l11
  %t241 = insertvalue %FunctionSignature %t239, { %Parameter**, i64 }* %t240, 2
  %t242 = load i8*, i8** %l12
  %t243 = bitcast i8* %t242 to %TypeAnnotation*
  %t244 = insertvalue %FunctionSignature %t241, %TypeAnnotation* %t243, 3
  %t245 = load double, double* %l17
  %t246 = insertvalue %FunctionSignature %t244, { i8**, i64 }* null, 4
  %t247 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l9
  %t248 = insertvalue %FunctionSignature %t246, { %TypeParameter**, i64 }* %t247, 5
  %t249 = load double, double* %l7
  %t250 = insertvalue %FunctionSignature %t248, %SourceSpan* null, 6
  store %FunctionSignature %t250, %FunctionSignature* %l19
  %t251 = load %Parser, %Parser* %l1
  %t252 = insertvalue %InterfaceMemberParseResult undef, %Parser %t251, 0
  %t253 = load %FunctionSignature, %FunctionSignature* %l19
  %t254 = insertvalue %InterfaceMemberParseResult %t252, %FunctionSignature* null, 1
  %t255 = insertvalue %InterfaceMemberParseResult %t254, i1 1, 2
  ret %InterfaceMemberParseResult %t255
}

define %EnumVariantParseResult @parse_enum_variant(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %Token
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca { %FieldDeclaration*, i64 }*
  %l6 = alloca %Token
  %l7 = alloca %Token
  %l8 = alloca %EnumVariant
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call %Token @parser_peek_raw(%Parser %t1)
  store %Token %t2, %Token* %l2
  %t3 = load %Token, %Token* %l2
  %t4 = extractvalue %Token %t3, 0
  %t5 = extractvalue %TokenKind %t4, 0
  %t6 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t7 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t8 = icmp eq i32 %t5, 0
  %t9 = select i1 %t8, i8* %t7, i8* %t6
  %t10 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t11 = icmp eq i32 %t5, 1
  %t12 = select i1 %t11, i8* %t10, i8* %t9
  %t13 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t14 = icmp eq i32 %t5, 2
  %t15 = select i1 %t14, i8* %t13, i8* %t12
  %t16 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t17 = icmp eq i32 %t5, 3
  %t18 = select i1 %t17, i8* %t16, i8* %t15
  %t19 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t20 = icmp eq i32 %t5, 4
  %t21 = select i1 %t20, i8* %t19, i8* %t18
  %t22 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t23 = icmp eq i32 %t5, 5
  %t24 = select i1 %t23, i8* %t22, i8* %t21
  %t25 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t5, 6
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t5, 7
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %s31 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.31, i32 0, i32 0
  %t32 = icmp ne i8* %t30, %s31
  %t33 = load %Parser, %Parser* %l0
  %t34 = load %Parser, %Parser* %l1
  %t35 = load %Token, %Token* %l2
  br i1 %t32, label %then0, label %merge1
then0:
  %t36 = load %Parser, %Parser* %l0
  %t37 = insertvalue %EnumVariantParseResult undef, %Parser %t36, 0
  %t38 = bitcast i8* null to %EnumVariant*
  %t39 = insertvalue %EnumVariantParseResult %t37, %EnumVariant* %t38, 1
  %t40 = insertvalue %EnumVariantParseResult %t39, i1 0, 2
  ret %EnumVariantParseResult %t40
merge1:
  %t41 = load %Token, %Token* %l2
  %t42 = call i8* @identifier_text(%Token %t41)
  store i8* %t42, i8** %l3
  %t43 = load %Token, %Token* %l2
  %t44 = alloca [1 x %Token]
  %t45 = getelementptr [1 x %Token], [1 x %Token]* %t44, i32 0, i32 0
  %t46 = getelementptr %Token, %Token* %t45, i64 0
  store %Token %t43, %Token* %t46
  %t47 = alloca { %Token*, i64 }
  %t48 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t47, i32 0, i32 0
  store %Token* %t45, %Token** %t48
  %t49 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t47, i32 0, i32 1
  store i64 1, i64* %t49
  %t50 = call double @source_span_from_tokens({ %Token*, i64 }* %t47)
  store double %t50, double* %l4
  %t51 = load %Parser, %Parser* %l1
  %t52 = call %Parser @parser_advance_raw(%Parser %t51)
  store %Parser %t52, %Parser* %l1
  %t53 = alloca [0 x %FieldDeclaration]
  %t54 = getelementptr [0 x %FieldDeclaration], [0 x %FieldDeclaration]* %t53, i32 0, i32 0
  %t55 = alloca { %FieldDeclaration*, i64 }
  %t56 = getelementptr { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %t55, i32 0, i32 0
  store %FieldDeclaration* %t54, %FieldDeclaration** %t56
  %t57 = getelementptr { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %t55, i32 0, i32 1
  store i64 0, i64* %t57
  store { %FieldDeclaration*, i64 }* %t55, { %FieldDeclaration*, i64 }** %l5
  %t58 = load %Parser, %Parser* %l1
  %t59 = call %Parser @skip_trivia(%Parser %t58)
  store %Parser %t59, %Parser* %l1
  %t60 = load %Parser, %Parser* %l1
  %t61 = call %Token @parser_peek_raw(%Parser %t60)
  store %Token %t61, %Token* %l6
  %t63 = load %Token, %Token* %l6
  %t64 = extractvalue %Token %t63, 0
  %t65 = extractvalue %TokenKind %t64, 0
  %t66 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t67 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t65, 0
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t65, 1
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t65, 2
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %t76 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t65, 3
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %t79 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t65, 4
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t65, 5
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %t85 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t65, 6
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t65, 7
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %s91 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.91, i32 0, i32 0
  %t92 = icmp eq i8* %t90, %s91
  br label %logical_and_entry_62

logical_and_entry_62:
  br i1 %t92, label %logical_and_right_62, label %logical_and_merge_62

logical_and_right_62:
  %t93 = load %Token, %Token* %l6
  %t94 = extractvalue %Token %t93, 0
  %t95 = extractvalue %TokenKind %t94, 0
  %t96 = load %Parser, %Parser* %l1
  %t97 = call %Parser @skip_trivia(%Parser %t96)
  store %Parser %t97, %Parser* %l1
  %t98 = load %Parser, %Parser* %l1
  %t99 = call %Token @parser_peek_raw(%Parser %t98)
  store %Token %t99, %Token* %l7
  %t101 = load %Token, %Token* %l7
  %t102 = extractvalue %Token %t101, 0
  %t103 = extractvalue %TokenKind %t102, 0
  %t104 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t105 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t106 = icmp eq i32 %t103, 0
  %t107 = select i1 %t106, i8* %t105, i8* %t104
  %t108 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t103, 1
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t112 = icmp eq i32 %t103, 2
  %t113 = select i1 %t112, i8* %t111, i8* %t110
  %t114 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t103, 3
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %t117 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t118 = icmp eq i32 %t103, 4
  %t119 = select i1 %t118, i8* %t117, i8* %t116
  %t120 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t103, 5
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %t123 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t124 = icmp eq i32 %t103, 6
  %t125 = select i1 %t124, i8* %t123, i8* %t122
  %t126 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t127 = icmp eq i32 %t103, 7
  %t128 = select i1 %t127, i8* %t126, i8* %t125
  %s129 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.129, i32 0, i32 0
  %t130 = icmp eq i8* %t128, %s129
  br label %logical_and_entry_100

logical_and_entry_100:
  br i1 %t130, label %logical_and_right_100, label %logical_and_merge_100

logical_and_right_100:
  %t131 = load %Token, %Token* %l7
  %t132 = extractvalue %Token %t131, 0
  %t133 = extractvalue %TokenKind %t132, 0
  %t134 = load i8*, i8** %l3
  %t135 = insertvalue %EnumVariant undef, i8* %t134, 0
  %t136 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l5
  %t137 = bitcast { %FieldDeclaration*, i64 }* %t136 to { %FieldDeclaration**, i64 }*
  %t138 = insertvalue %EnumVariant %t135, { %FieldDeclaration**, i64 }* %t137, 1
  %t139 = load double, double* %l4
  %t140 = insertvalue %EnumVariant %t138, %SourceSpan* null, 2
  store %EnumVariant %t140, %EnumVariant* %l8
  %t141 = load %Parser, %Parser* %l1
  %t142 = insertvalue %EnumVariantParseResult undef, %Parser %t141, 0
  %t143 = load %EnumVariant, %EnumVariant* %l8
  %t144 = insertvalue %EnumVariantParseResult %t142, %EnumVariant* null, 1
  %t145 = insertvalue %EnumVariantParseResult %t144, i1 1, 2
  ret %EnumVariantParseResult %t145
}

define %StructFieldParseResult @parse_enum_variant_field(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca i1
  %l2 = alloca %Token
  %l3 = alloca %Token
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca %Token
  %l7 = alloca i1
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca %Token
  %l13 = alloca %FieldDeclaration
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  store i1 0, i1* %l1
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Token @parser_peek_raw(%Parser %t1)
  store %Token %t2, %Token* %l2
  %t3 = load %Token, %Token* %l2
  store %Token %t3, %Token* %l3
  %t4 = load %Token, %Token* %l3
  %s5 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.5, i32 0, i32 0
  %t6 = call i1 @identifier_matches(%Token %t4, i8* %s5)
  %t7 = load %Parser, %Parser* %l0
  %t8 = load i1, i1* %l1
  %t9 = load %Token, %Token* %l2
  %t10 = load %Token, %Token* %l3
  br i1 %t6, label %then0, label %merge1
then0:
  %t11 = load %Parser, %Parser* %l0
  %t12 = call %Parser @parser_advance_raw(%Parser %t11)
  store %Parser %t12, %Parser* %l0
  store i1 1, i1* %l1
  %t13 = load %Parser, %Parser* %l0
  %t14 = call %Parser @skip_trivia(%Parser %t13)
  store %Parser %t14, %Parser* %l0
  %t15 = load %Parser, %Parser* %l0
  %t16 = call %Token @parser_peek_raw(%Parser %t15)
  store %Token %t16, %Token* %l3
  br label %merge1
merge1:
  %t17 = phi %Parser [ %t12, %then0 ], [ %t7, %entry ]
  %t18 = phi i1 [ 1, %then0 ], [ %t8, %entry ]
  %t19 = phi %Parser [ %t14, %then0 ], [ %t7, %entry ]
  %t20 = phi %Token [ %t16, %then0 ], [ %t10, %entry ]
  store %Parser %t17, %Parser* %l0
  store i1 %t18, i1* %l1
  store %Parser %t19, %Parser* %l0
  store %Token %t20, %Token* %l3
  %t21 = load %Token, %Token* %l3
  %t22 = extractvalue %Token %t21, 0
  %t23 = extractvalue %TokenKind %t22, 0
  %t24 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t25 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t23, 0
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t23, 1
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %t31 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t32 = icmp eq i32 %t23, 2
  %t33 = select i1 %t32, i8* %t31, i8* %t30
  %t34 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t23, 3
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %t37 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t23, 4
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %t40 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t41 = icmp eq i32 %t23, 5
  %t42 = select i1 %t41, i8* %t40, i8* %t39
  %t43 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t44 = icmp eq i32 %t23, 6
  %t45 = select i1 %t44, i8* %t43, i8* %t42
  %t46 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t47 = icmp eq i32 %t23, 7
  %t48 = select i1 %t47, i8* %t46, i8* %t45
  %s49 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.49, i32 0, i32 0
  %t50 = icmp ne i8* %t48, %s49
  %t51 = load %Parser, %Parser* %l0
  %t52 = load i1, i1* %l1
  %t53 = load %Token, %Token* %l2
  %t54 = load %Token, %Token* %l3
  br i1 %t50, label %then2, label %merge3
then2:
  %t55 = insertvalue %StructFieldParseResult undef, %Parser %parser, 0
  %t56 = bitcast i8* null to %FieldDeclaration*
  %t57 = insertvalue %StructFieldParseResult %t55, %FieldDeclaration* %t56, 1
  %t58 = insertvalue %StructFieldParseResult %t57, i1 0, 2
  ret %StructFieldParseResult %t58
merge3:
  %t59 = load %Token, %Token* %l3
  %t60 = call i8* @identifier_text(%Token %t59)
  store i8* %t60, i8** %l4
  %t61 = load %Token, %Token* %l3
  %t62 = alloca [1 x %Token]
  %t63 = getelementptr [1 x %Token], [1 x %Token]* %t62, i32 0, i32 0
  %t64 = getelementptr %Token, %Token* %t63, i64 0
  store %Token %t61, %Token* %t64
  %t65 = alloca { %Token*, i64 }
  %t66 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t65, i32 0, i32 0
  store %Token* %t63, %Token** %t66
  %t67 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t65, i32 0, i32 1
  store i64 1, i64* %t67
  %t68 = call double @source_span_from_tokens({ %Token*, i64 }* %t65)
  store double %t68, double* %l5
  %t69 = load %Parser, %Parser* %l0
  %t70 = call %Parser @parser_advance_raw(%Parser %t69)
  store %Parser %t70, %Parser* %l0
  %t71 = load %Parser, %Parser* %l0
  %t72 = call %Parser @skip_trivia(%Parser %t71)
  store %Parser %t72, %Parser* %l0
  %t73 = load %Parser, %Parser* %l0
  %t74 = call %Token @parser_peek_raw(%Parser %t73)
  store %Token %t74, %Token* %l6
  %t75 = load %Token, %Token* %l6
  %t76 = extractvalue %Token %t75, 0
  %t77 = extractvalue %TokenKind %t76, 0
  %t78 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t79 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t77, 0
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t77, 1
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %t85 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t77, 2
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t77, 3
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t77, 4
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t77, 5
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t77, 6
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %t100 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t77, 7
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %s103 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.103, i32 0, i32 0
  %t104 = icmp eq i8* %t102, %s103
  store i1 %t104, i1* %l7
  %t105 = load i1, i1* %l7
  %t106 = xor i1 %t105, 1
  %t107 = load %Parser, %Parser* %l0
  %t108 = load i1, i1* %l1
  %t109 = load %Token, %Token* %l2
  %t110 = load %Token, %Token* %l3
  %t111 = load i8*, i8** %l4
  %t112 = load double, double* %l5
  %t113 = load %Token, %Token* %l6
  %t114 = load i1, i1* %l7
  br i1 %t106, label %then4, label %merge5
then4:
  %t115 = insertvalue %StructFieldParseResult undef, %Parser %parser, 0
  %t116 = bitcast i8* null to %FieldDeclaration*
  %t117 = insertvalue %StructFieldParseResult %t115, %FieldDeclaration* %t116, 1
  %t118 = insertvalue %StructFieldParseResult %t117, i1 0, 2
  ret %StructFieldParseResult %t118
merge5:
  %t119 = load %Parser, %Parser* %l0
  %t120 = call %Parser @parser_advance_raw(%Parser %t119)
  store %Parser %t120, %Parser* %l0
  %t121 = load %Parser, %Parser* %l0
  %t122 = call %Parser @skip_trivia(%Parser %t121)
  store double 0.0, double* %l8
  %t123 = load double, double* %l8
  %t124 = load double, double* %l8
  store double 0.0, double* %l9
  %t125 = load %Parser, %Parser* %l0
  %t126 = load i1, i1* %l1
  %t127 = load %Token, %Token* %l2
  %t128 = load %Token, %Token* %l3
  %t129 = load i8*, i8** %l4
  %t130 = load double, double* %l5
  %t131 = load %Token, %Token* %l6
  %t132 = load i1, i1* %l7
  %t133 = load double, double* %l8
  %t134 = load double, double* %l9
  br label %loop.header6
loop.header6:
  %t144 = phi double [ %t134, %entry ], [ %t143, %loop.latch8 ]
  store double %t144, double* %l9
  br label %loop.body7
loop.body7:
  %t135 = load double, double* %l9
  %t136 = load double, double* %l9
  %t137 = load double, double* %l9
  store double 0.0, double* %l10
  %t138 = load double, double* %l10
  %t139 = load double, double* %l9
  %t140 = load double, double* %l9
  store double 0.0, double* %l11
  %t141 = load double, double* %l11
  %t142 = call i8* @trim_text(i8* null)
  store double 0.0, double* %l9
  br label %loop.latch8
loop.latch8:
  %t143 = load double, double* %l9
  br label %loop.header6
afterloop9:
  %t145 = load double, double* %l9
  %t146 = load %Parser, %Parser* %l0
  %t147 = call %Parser @skip_trivia(%Parser %t146)
  store %Parser %t147, %Parser* %l0
  %t148 = load %Parser, %Parser* %l0
  %t149 = call %Token @parser_peek_raw(%Parser %t148)
  store %Token %t149, %Token* %l12
  %t150 = load %Token, %Token* %l12
  %t151 = extractvalue %Token %t150, 0
  %t152 = extractvalue %TokenKind %t151, 0
  %t153 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t154 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t152, 0
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t152, 1
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %t160 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t161 = icmp eq i32 %t152, 2
  %t162 = select i1 %t161, i8* %t160, i8* %t159
  %t163 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t164 = icmp eq i32 %t152, 3
  %t165 = select i1 %t164, i8* %t163, i8* %t162
  %t166 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t167 = icmp eq i32 %t152, 4
  %t168 = select i1 %t167, i8* %t166, i8* %t165
  %t169 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t170 = icmp eq i32 %t152, 5
  %t171 = select i1 %t170, i8* %t169, i8* %t168
  %t172 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t173 = icmp eq i32 %t152, 6
  %t174 = select i1 %t173, i8* %t172, i8* %t171
  %t175 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t176 = icmp eq i32 %t152, 7
  %t177 = select i1 %t176, i8* %t175, i8* %t174
  %s178 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.178, i32 0, i32 0
  %t179 = icmp eq i8* %t177, %s178
  %t180 = load %Parser, %Parser* %l0
  %t181 = load i1, i1* %l1
  %t182 = load %Token, %Token* %l2
  %t183 = load %Token, %Token* %l3
  %t184 = load i8*, i8** %l4
  %t185 = load double, double* %l5
  %t186 = load %Token, %Token* %l6
  %t187 = load i1, i1* %l7
  %t188 = load double, double* %l8
  %t189 = load double, double* %l9
  %t190 = load %Token, %Token* %l12
  br i1 %t179, label %then10, label %merge11
then10:
  %t191 = load %Token, %Token* %l12
  %t192 = extractvalue %Token %t191, 0
  %t193 = extractvalue %TokenKind %t192, 0
  br label %merge11
merge11:
  %t194 = load i8*, i8** %l4
  %t195 = insertvalue %FieldDeclaration undef, i8* %t194, 0
  %t196 = load double, double* %l9
  %t197 = insertvalue %TypeAnnotation undef, i8* null, 0
  %t198 = insertvalue %FieldDeclaration %t195, %TypeAnnotation %t197, 1
  %t199 = load i1, i1* %l1
  %t200 = insertvalue %FieldDeclaration %t198, i1 %t199, 2
  %t201 = load double, double* %l5
  %t202 = insertvalue %FieldDeclaration %t200, %SourceSpan* null, 3
  store %FieldDeclaration %t202, %FieldDeclaration* %l13
  %t203 = load %Parser, %Parser* %l0
  %t204 = insertvalue %StructFieldParseResult undef, %Parser %t203, 0
  %t205 = load %FieldDeclaration, %FieldDeclaration* %l13
  %t206 = insertvalue %StructFieldParseResult %t204, %FieldDeclaration* null, 1
  %t207 = insertvalue %StructFieldParseResult %t206, i1 1, 2
  ret %StructFieldParseResult %t207
}

define %Parser @skip_trailing_comma(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Token @parser_peek_raw(%Parser %t1)
  store %Token %t2, %Token* %l1
  %t4 = load %Token, %Token* %l1
  %t5 = extractvalue %Token %t4, 0
  %t6 = extractvalue %TokenKind %t5, 0
  %t7 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t8 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t9 = icmp eq i32 %t6, 0
  %t10 = select i1 %t9, i8* %t8, i8* %t7
  %t11 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t12 = icmp eq i32 %t6, 1
  %t13 = select i1 %t12, i8* %t11, i8* %t10
  %t14 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t15 = icmp eq i32 %t6, 2
  %t16 = select i1 %t15, i8* %t14, i8* %t13
  %t17 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t6, 3
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t6, 4
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t6, 5
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t6, 6
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t6, 7
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %s32 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.32, i32 0, i32 0
  %t33 = icmp eq i8* %t31, %s32
  br label %logical_and_entry_3

logical_and_entry_3:
  br i1 %t33, label %logical_and_right_3, label %logical_and_merge_3

logical_and_right_3:
  %t34 = load %Token, %Token* %l1
  %t35 = extractvalue %Token %t34, 0
  %t36 = extractvalue %TokenKind %t35, 0
  %t37 = load %Parser, %Parser* %l0
  ret %Parser %t37
}

define %StatementParseResult @parse_model(%Parser %initial_parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %Token
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca %CaptureResult
  %l6 = alloca i8*
  %l7 = alloca %TypeAnnotation
  %l8 = alloca %EffectParseResult
  %l9 = alloca { i8**, i64 }*
  %l10 = alloca { %ModelProperty*, i64 }*
  %l11 = alloca %Token
  %l12 = alloca %Parser
  %l13 = alloca %ModelPropertyParseResult
  %l14 = alloca %Token
  %l15 = alloca %Statement
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Parser @skip_trivia(%Parser %t1)
  store %Parser %t2, %Parser* %l0
  %t3 = load %Parser, %Parser* %l0
  %s4 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.4, i32 0, i32 0
  %t5 = call %Parser @consume_keyword(%Parser %t3, i8* %s4)
  store %Parser %t5, %Parser* %l0
  %t6 = load %Parser, %Parser* %l0
  %t7 = call %Parser @skip_trivia(%Parser %t6)
  store %Parser %t7, %Parser* %l0
  %t8 = load %Parser, %Parser* %l0
  %t9 = call %Token @parser_peek_raw(%Parser %t8)
  store %Token %t9, %Token* %l2
  %t10 = load %Token, %Token* %l2
  %t11 = call i8* @identifier_text(%Token %t10)
  store i8* %t11, i8** %l3
  %t12 = load %Token, %Token* %l2
  %t13 = alloca [1 x %Token]
  %t14 = getelementptr [1 x %Token], [1 x %Token]* %t13, i32 0, i32 0
  %t15 = getelementptr %Token, %Token* %t14, i64 0
  store %Token %t12, %Token* %t15
  %t16 = alloca { %Token*, i64 }
  %t17 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t16, i32 0, i32 0
  store %Token* %t14, %Token** %t17
  %t18 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t16, i32 0, i32 1
  store i64 1, i64* %t18
  %t19 = call double @source_span_from_tokens({ %Token*, i64 }* %t16)
  store double %t19, double* %l4
  %t20 = load %Parser, %Parser* %l0
  %t21 = call %Parser @parser_advance_raw(%Parser %t20)
  store %Parser %t21, %Parser* %l0
  %t22 = load %Parser, %Parser* %l0
  %t23 = call %Parser @skip_trivia(%Parser %t22)
  store %Parser %t23, %Parser* %l0
  %t24 = load %Parser, %Parser* %l0
  %t25 = alloca [2 x i8], align 1
  %t26 = getelementptr [2 x i8], [2 x i8]* %t25, i32 0, i32 0
  store i8 58, i8* %t26
  %t27 = getelementptr [2 x i8], [2 x i8]* %t25, i32 0, i32 1
  store i8 0, i8* %t27
  %t28 = getelementptr [2 x i8], [2 x i8]* %t25, i32 0, i32 0
  %t29 = call %Parser @advance_to_symbol(%Parser %t24, i8* %t28)
  store %Parser %t29, %Parser* %l0
  %t30 = load %Parser, %Parser* %l0
  %t31 = alloca [2 x i8], align 1
  %t32 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 0
  store i8 58, i8* %t32
  %t33 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 1
  store i8 0, i8* %t33
  %t34 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 0
  %t35 = call %Parser @consume_symbol(%Parser %t30, i8* %t34)
  store %Parser %t35, %Parser* %l0
  %t36 = load %Parser, %Parser* %l0
  %t37 = call %Parser @skip_trivia(%Parser %t36)
  %t38 = alloca [2 x i8]
  %t39 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 0
  %t40 = getelementptr i8, i8* %t39, i64 0
  store i8 33, i8* %t40
  %t41 = getelementptr i8, i8* %t39, i64 1
  store i8 123, i8* %t41
  %t42 = alloca { i8*, i64 }
  %t43 = getelementptr { i8*, i64 }, { i8*, i64 }* %t42, i32 0, i32 0
  store i8* %t39, i8** %t43
  %t44 = getelementptr { i8*, i64 }, { i8*, i64 }* %t42, i32 0, i32 1
  store i64 2, i64* %t44
  %t45 = bitcast { i8*, i64 }* %t42 to { i8**, i64 }*
  %t46 = call %CaptureResult @collect_until(%Parser %t37, { i8**, i64 }* %t45)
  store %CaptureResult %t46, %CaptureResult* %l5
  %t47 = load %CaptureResult, %CaptureResult* %l5
  %t48 = extractvalue %CaptureResult %t47, 0
  store %Parser %t48, %Parser* %l0
  %t49 = load %CaptureResult, %CaptureResult* %l5
  %t50 = extractvalue %CaptureResult %t49, 1
  %t51 = bitcast { %Token**, i64 }* %t50 to { %Token*, i64 }*
  %t52 = call i8* @tokens_to_text({ %Token*, i64 }* %t51)
  %t53 = call i8* @trim_text(i8* %t52)
  store i8* %t53, i8** %l6
  %t54 = load i8*, i8** %l6
  %t55 = call i64 @sailfin_runtime_string_length(i8* %t54)
  %t56 = icmp eq i64 %t55, 0
  %t57 = load %Parser, %Parser* %l0
  %t58 = load %Parser, %Parser* %l1
  %t59 = load %Token, %Token* %l2
  %t60 = load i8*, i8** %l3
  %t61 = load double, double* %l4
  %t62 = load %CaptureResult, %CaptureResult* %l5
  %t63 = load i8*, i8** %l6
  br i1 %t56, label %then0, label %merge1
then0:
  %t64 = load %Parser, %Parser* %l1
  %t65 = call %StatementParseResult @parse_unknown(%Parser %t64)
  ret %StatementParseResult %t65
merge1:
  %t66 = load i8*, i8** %l6
  %t67 = insertvalue %TypeAnnotation undef, i8* %t66, 0
  store %TypeAnnotation %t67, %TypeAnnotation* %l7
  %t68 = load %Parser, %Parser* %l0
  %t69 = call %EffectParseResult @parse_effect_list(%Parser %t68)
  store %EffectParseResult %t69, %EffectParseResult* %l8
  %t70 = load %EffectParseResult, %EffectParseResult* %l8
  %t71 = extractvalue %EffectParseResult %t70, 0
  store %Parser %t71, %Parser* %l0
  %t72 = load %EffectParseResult, %EffectParseResult* %l8
  %t73 = extractvalue %EffectParseResult %t72, 1
  store { i8**, i64 }* %t73, { i8**, i64 }** %l9
  %t74 = load %Parser, %Parser* %l0
  %t75 = call %Parser @skip_trivia(%Parser %t74)
  store %Parser %t75, %Parser* %l0
  %t76 = load %Parser, %Parser* %l0
  %t77 = alloca [2 x i8], align 1
  %t78 = getelementptr [2 x i8], [2 x i8]* %t77, i32 0, i32 0
  store i8 123, i8* %t78
  %t79 = getelementptr [2 x i8], [2 x i8]* %t77, i32 0, i32 1
  store i8 0, i8* %t79
  %t80 = getelementptr [2 x i8], [2 x i8]* %t77, i32 0, i32 0
  %t81 = call %Parser @advance_to_symbol(%Parser %t76, i8* %t80)
  store %Parser %t81, %Parser* %l0
  %t82 = load %Parser, %Parser* %l0
  %t83 = alloca [2 x i8], align 1
  %t84 = getelementptr [2 x i8], [2 x i8]* %t83, i32 0, i32 0
  store i8 123, i8* %t84
  %t85 = getelementptr [2 x i8], [2 x i8]* %t83, i32 0, i32 1
  store i8 0, i8* %t85
  %t86 = getelementptr [2 x i8], [2 x i8]* %t83, i32 0, i32 0
  %t87 = call %Parser @consume_symbol(%Parser %t82, i8* %t86)
  store %Parser %t87, %Parser* %l0
  %t88 = alloca [0 x %ModelProperty]
  %t89 = getelementptr [0 x %ModelProperty], [0 x %ModelProperty]* %t88, i32 0, i32 0
  %t90 = alloca { %ModelProperty*, i64 }
  %t91 = getelementptr { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %t90, i32 0, i32 0
  store %ModelProperty* %t89, %ModelProperty** %t91
  %t92 = getelementptr { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %t90, i32 0, i32 1
  store i64 0, i64* %t92
  store { %ModelProperty*, i64 }* %t90, { %ModelProperty*, i64 }** %l10
  %t93 = load %Parser, %Parser* %l0
  %t94 = load %Parser, %Parser* %l1
  %t95 = load %Token, %Token* %l2
  %t96 = load i8*, i8** %l3
  %t97 = load double, double* %l4
  %t98 = load %CaptureResult, %CaptureResult* %l5
  %t99 = load i8*, i8** %l6
  %t100 = load %TypeAnnotation, %TypeAnnotation* %l7
  %t101 = load %EffectParseResult, %EffectParseResult* %l8
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t103 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %l10
  br label %loop.header2
loop.header2:
  %t279 = phi %Parser [ %t93, %entry ], [ %t278, %loop.latch4 ]
  store %Parser %t279, %Parser* %l0
  br label %loop.body3
loop.body3:
  %t104 = load %Parser, %Parser* %l0
  %t105 = call %Parser @skip_trivia(%Parser %t104)
  store %Parser %t105, %Parser* %l0
  %t106 = load %Parser, %Parser* %l0
  %t107 = call %Token @parser_peek_raw(%Parser %t106)
  store %Token %t107, %Token* %l11
  %t109 = load %Token, %Token* %l11
  %t110 = extractvalue %Token %t109, 0
  %t111 = extractvalue %TokenKind %t110, 0
  %t112 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t113 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t111, 0
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %t116 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t111, 1
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %t119 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t111, 2
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %t122 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t123 = icmp eq i32 %t111, 3
  %t124 = select i1 %t123, i8* %t122, i8* %t121
  %t125 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t126 = icmp eq i32 %t111, 4
  %t127 = select i1 %t126, i8* %t125, i8* %t124
  %t128 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t129 = icmp eq i32 %t111, 5
  %t130 = select i1 %t129, i8* %t128, i8* %t127
  %t131 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t132 = icmp eq i32 %t111, 6
  %t133 = select i1 %t132, i8* %t131, i8* %t130
  %t134 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t111, 7
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %s137 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.137, i32 0, i32 0
  %t138 = icmp eq i8* %t136, %s137
  br label %logical_and_entry_108

logical_and_entry_108:
  br i1 %t138, label %logical_and_right_108, label %logical_and_merge_108

logical_and_right_108:
  %t139 = load %Token, %Token* %l11
  %t140 = extractvalue %Token %t139, 0
  %t141 = extractvalue %TokenKind %t140, 0
  %t142 = load %Token, %Token* %l11
  %t143 = extractvalue %Token %t142, 0
  %t144 = extractvalue %TokenKind %t143, 0
  %t145 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t146 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t144, 0
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t144, 1
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t144, 2
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t144, 3
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t144, 4
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t144, 5
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t144, 6
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t144, 7
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %s170 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.170, i32 0, i32 0
  %t171 = icmp eq i8* %t169, %s170
  %t172 = load %Parser, %Parser* %l0
  %t173 = load %Parser, %Parser* %l1
  %t174 = load %Token, %Token* %l2
  %t175 = load i8*, i8** %l3
  %t176 = load double, double* %l4
  %t177 = load %CaptureResult, %CaptureResult* %l5
  %t178 = load i8*, i8** %l6
  %t179 = load %TypeAnnotation, %TypeAnnotation* %l7
  %t180 = load %EffectParseResult, %EffectParseResult* %l8
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t182 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %l10
  %t183 = load %Token, %Token* %l11
  br i1 %t171, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t184 = load %Parser, %Parser* %l0
  store %Parser %t184, %Parser* %l12
  %t185 = load %Parser, %Parser* %l0
  %t186 = call %ModelPropertyParseResult @parse_model_property(%Parser %t185)
  store %ModelPropertyParseResult %t186, %ModelPropertyParseResult* %l13
  %t188 = load %ModelPropertyParseResult, %ModelPropertyParseResult* %l13
  %t189 = extractvalue %ModelPropertyParseResult %t188, 2
  br label %logical_and_entry_187

logical_and_entry_187:
  br i1 %t189, label %logical_and_right_187, label %logical_and_merge_187

logical_and_right_187:
  %t190 = load %ModelPropertyParseResult, %ModelPropertyParseResult* %l13
  %t191 = extractvalue %ModelPropertyParseResult %t190, 1
  %t192 = bitcast i8* null to %ModelProperty*
  %t193 = load %Parser, %Parser* %l12
  %t194 = call %Parser @skip_struct_member(%Parser %t193)
  store %Parser %t194, %Parser* %l0
  %t195 = load %Parser, %Parser* %l0
  %t196 = call %Parser @skip_trivia(%Parser %t195)
  store %Parser %t196, %Parser* %l0
  %t197 = load %Parser, %Parser* %l0
  %t198 = call %Token @parser_peek_raw(%Parser %t197)
  store %Token %t198, %Token* %l14
  %t200 = load %Token, %Token* %l14
  %t201 = extractvalue %Token %t200, 0
  %t202 = extractvalue %TokenKind %t201, 0
  %t203 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t204 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t205 = icmp eq i32 %t202, 0
  %t206 = select i1 %t205, i8* %t204, i8* %t203
  %t207 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t208 = icmp eq i32 %t202, 1
  %t209 = select i1 %t208, i8* %t207, i8* %t206
  %t210 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t211 = icmp eq i32 %t202, 2
  %t212 = select i1 %t211, i8* %t210, i8* %t209
  %t213 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t214 = icmp eq i32 %t202, 3
  %t215 = select i1 %t214, i8* %t213, i8* %t212
  %t216 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t217 = icmp eq i32 %t202, 4
  %t218 = select i1 %t217, i8* %t216, i8* %t215
  %t219 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t220 = icmp eq i32 %t202, 5
  %t221 = select i1 %t220, i8* %t219, i8* %t218
  %t222 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t223 = icmp eq i32 %t202, 6
  %t224 = select i1 %t223, i8* %t222, i8* %t221
  %t225 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t226 = icmp eq i32 %t202, 7
  %t227 = select i1 %t226, i8* %t225, i8* %t224
  %s228 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.228, i32 0, i32 0
  %t229 = icmp eq i8* %t227, %s228
  br label %logical_and_entry_199

logical_and_entry_199:
  br i1 %t229, label %logical_and_right_199, label %logical_and_merge_199

logical_and_right_199:
  %t230 = load %Token, %Token* %l14
  %t231 = extractvalue %Token %t230, 0
  %t232 = extractvalue %TokenKind %t231, 0
  %t233 = load %Token, %Token* %l14
  %t234 = extractvalue %Token %t233, 0
  %t235 = extractvalue %TokenKind %t234, 0
  %t236 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t237 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t238 = icmp eq i32 %t235, 0
  %t239 = select i1 %t238, i8* %t237, i8* %t236
  %t240 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t241 = icmp eq i32 %t235, 1
  %t242 = select i1 %t241, i8* %t240, i8* %t239
  %t243 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t244 = icmp eq i32 %t235, 2
  %t245 = select i1 %t244, i8* %t243, i8* %t242
  %t246 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t247 = icmp eq i32 %t235, 3
  %t248 = select i1 %t247, i8* %t246, i8* %t245
  %t249 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t250 = icmp eq i32 %t235, 4
  %t251 = select i1 %t250, i8* %t249, i8* %t248
  %t252 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t253 = icmp eq i32 %t235, 5
  %t254 = select i1 %t253, i8* %t252, i8* %t251
  %t255 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t256 = icmp eq i32 %t235, 6
  %t257 = select i1 %t256, i8* %t255, i8* %t254
  %t258 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t259 = icmp eq i32 %t235, 7
  %t260 = select i1 %t259, i8* %t258, i8* %t257
  %s261 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.261, i32 0, i32 0
  %t262 = icmp eq i8* %t260, %s261
  %t263 = load %Parser, %Parser* %l0
  %t264 = load %Parser, %Parser* %l1
  %t265 = load %Token, %Token* %l2
  %t266 = load i8*, i8** %l3
  %t267 = load double, double* %l4
  %t268 = load %CaptureResult, %CaptureResult* %l5
  %t269 = load i8*, i8** %l6
  %t270 = load %TypeAnnotation, %TypeAnnotation* %l7
  %t271 = load %EffectParseResult, %EffectParseResult* %l8
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t273 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %l10
  %t274 = load %Token, %Token* %l11
  %t275 = load %Parser, %Parser* %l12
  %t276 = load %ModelPropertyParseResult, %ModelPropertyParseResult* %l13
  %t277 = load %Token, %Token* %l14
  br i1 %t262, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  br label %loop.latch4
loop.latch4:
  %t278 = load %Parser, %Parser* %l0
  br label %loop.header2
afterloop5:
  %t280 = alloca %Statement
  %t281 = getelementptr inbounds %Statement, %Statement* %t280, i32 0, i32 0
  store i32 3, i32* %t281
  %t282 = load i8*, i8** %l3
  %t283 = getelementptr inbounds %Statement, %Statement* %t280, i32 0, i32 1
  %t284 = bitcast [48 x i8]* %t283 to i8*
  %t285 = bitcast i8* %t284 to i8**
  store i8* %t282, i8** %t285
  %t286 = load double, double* %l4
  %t287 = call noalias i8* @malloc(i64 8)
  %t288 = bitcast i8* %t287 to double*
  store double %t286, double* %t288
  %t289 = bitcast i8* %t287 to %SourceSpan*
  %t290 = getelementptr inbounds %Statement, %Statement* %t280, i32 0, i32 1
  %t291 = bitcast [48 x i8]* %t290 to i8*
  %t292 = getelementptr inbounds i8, i8* %t291, i64 8
  %t293 = bitcast i8* %t292 to %SourceSpan**
  store %SourceSpan* %t289, %SourceSpan** %t293
  %t294 = load %TypeAnnotation, %TypeAnnotation* %l7
  %t295 = getelementptr inbounds %Statement, %Statement* %t280, i32 0, i32 1
  %t296 = bitcast [48 x i8]* %t295 to i8*
  %t297 = getelementptr inbounds i8, i8* %t296, i64 16
  %t298 = bitcast i8* %t297 to %TypeAnnotation*
  store %TypeAnnotation %t294, %TypeAnnotation* %t298
  %t299 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %l10
  %t300 = bitcast { %ModelProperty*, i64 }* %t299 to { %ModelProperty**, i64 }*
  %t301 = getelementptr inbounds %Statement, %Statement* %t280, i32 0, i32 1
  %t302 = bitcast [48 x i8]* %t301 to i8*
  %t303 = getelementptr inbounds i8, i8* %t302, i64 24
  %t304 = bitcast i8* %t303 to { %ModelProperty**, i64 }**
  store { %ModelProperty**, i64 }* %t300, { %ModelProperty**, i64 }** %t304
  %t305 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t306 = getelementptr inbounds %Statement, %Statement* %t280, i32 0, i32 1
  %t307 = bitcast [48 x i8]* %t306 to i8*
  %t308 = getelementptr inbounds i8, i8* %t307, i64 32
  %t309 = bitcast i8* %t308 to { i8**, i64 }**
  store { i8**, i64 }* %t305, { i8**, i64 }** %t309
  %t310 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t311 = getelementptr inbounds %Statement, %Statement* %t280, i32 0, i32 1
  %t312 = bitcast [48 x i8]* %t311 to i8*
  %t313 = getelementptr inbounds i8, i8* %t312, i64 40
  %t314 = bitcast i8* %t313 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t310, { %Decorator**, i64 }** %t314
  %t315 = load %Statement, %Statement* %t280
  store %Statement %t315, %Statement* %l15
  %t316 = load %Parser, %Parser* %l0
  %t317 = insertvalue %StatementParseResult undef, %Parser %t316, 0
  %t318 = load %Statement, %Statement* %l15
  %t319 = insertvalue %StatementParseResult %t317, %Statement %t318, 1
  ret %StatementParseResult %t319
}

define %StatementParseResult @parse_pipeline(%Parser %initial_parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca %TypeParameterParseResult
  %l5 = alloca { %TypeParameter**, i64 }*
  %l6 = alloca %ParameterListParseResult
  %l7 = alloca { %Parameter**, i64 }*
  %l8 = alloca i8*
  %l9 = alloca %Token
  %l10 = alloca %EffectParseResult
  %l11 = alloca { i8**, i64 }*
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca %BlockParseResult
  %l15 = alloca %Block
  %l16 = alloca %FunctionSignature
  %l17 = alloca %Statement
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  %t1 = call %Parser @skip_trivia(%Parser %t0)
  store %Parser %t1, %Parser* %l0
  %t2 = load %Parser, %Parser* %l0
  %s3 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.3, i32 0, i32 0
  %t4 = call %Parser @consume_keyword(%Parser %t2, i8* %s3)
  store %Parser %t4, %Parser* %l0
  %t5 = load %Parser, %Parser* %l0
  %t6 = call %Parser @skip_trivia(%Parser %t5)
  store %Parser %t6, %Parser* %l0
  %t7 = load %Parser, %Parser* %l0
  %t8 = call %Token @parser_peek_raw(%Parser %t7)
  store %Token %t8, %Token* %l1
  %t9 = load %Token, %Token* %l1
  %t10 = call i8* @identifier_text(%Token %t9)
  store i8* %t10, i8** %l2
  %t11 = load %Token, %Token* %l1
  %t12 = alloca [1 x %Token]
  %t13 = getelementptr [1 x %Token], [1 x %Token]* %t12, i32 0, i32 0
  %t14 = getelementptr %Token, %Token* %t13, i64 0
  store %Token %t11, %Token* %t14
  %t15 = alloca { %Token*, i64 }
  %t16 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t15, i32 0, i32 0
  store %Token* %t13, %Token** %t16
  %t17 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t15, i32 0, i32 1
  store i64 1, i64* %t17
  %t18 = call double @source_span_from_tokens({ %Token*, i64 }* %t15)
  store double %t18, double* %l3
  %t19 = load %Parser, %Parser* %l0
  %t20 = call %Parser @parser_advance_raw(%Parser %t19)
  store %Parser %t20, %Parser* %l0
  %t21 = load %Parser, %Parser* %l0
  %t22 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %t21)
  store %TypeParameterParseResult %t22, %TypeParameterParseResult* %l4
  %t23 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t24 = extractvalue %TypeParameterParseResult %t23, 0
  store %Parser %t24, %Parser* %l0
  %t25 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t26 = extractvalue %TypeParameterParseResult %t25, 1
  store { %TypeParameter**, i64 }* %t26, { %TypeParameter**, i64 }** %l5
  %t27 = load %Parser, %Parser* %l0
  %t28 = call %Parser @skip_trivia(%Parser %t27)
  store %Parser %t28, %Parser* %l0
  %t29 = load %Parser, %Parser* %l0
  %t30 = alloca [2 x i8], align 1
  %t31 = getelementptr [2 x i8], [2 x i8]* %t30, i32 0, i32 0
  store i8 40, i8* %t31
  %t32 = getelementptr [2 x i8], [2 x i8]* %t30, i32 0, i32 1
  store i8 0, i8* %t32
  %t33 = getelementptr [2 x i8], [2 x i8]* %t30, i32 0, i32 0
  %t34 = call %Parser @consume_symbol(%Parser %t29, i8* %t33)
  store %Parser %t34, %Parser* %l0
  %t35 = load %Parser, %Parser* %l0
  %t36 = call %ParameterListParseResult @parse_parameter_list(%Parser %t35)
  store %ParameterListParseResult %t36, %ParameterListParseResult* %l6
  %t37 = load %ParameterListParseResult, %ParameterListParseResult* %l6
  %t38 = extractvalue %ParameterListParseResult %t37, 0
  store %Parser %t38, %Parser* %l0
  %t39 = load %ParameterListParseResult, %ParameterListParseResult* %l6
  %t40 = extractvalue %ParameterListParseResult %t39, 1
  store { %Parameter**, i64 }* %t40, { %Parameter**, i64 }** %l7
  %t41 = load %Parser, %Parser* %l0
  %t42 = call %Parser @skip_trivia(%Parser %t41)
  store %Parser %t42, %Parser* %l0
  store i8* null, i8** %l8
  %t43 = load %Parser, %Parser* %l0
  %t44 = call %Token @parser_peek_raw(%Parser %t43)
  store %Token %t44, %Token* %l9
  %t47 = load %Token, %Token* %l9
  %t48 = extractvalue %Token %t47, 0
  %t49 = extractvalue %TokenKind %t48, 0
  %t50 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t51 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t52 = icmp eq i32 %t49, 0
  %t53 = select i1 %t52, i8* %t51, i8* %t50
  %t54 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t55 = icmp eq i32 %t49, 1
  %t56 = select i1 %t55, i8* %t54, i8* %t53
  %t57 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t58 = icmp eq i32 %t49, 2
  %t59 = select i1 %t58, i8* %t57, i8* %t56
  %t60 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t61 = icmp eq i32 %t49, 3
  %t62 = select i1 %t61, i8* %t60, i8* %t59
  %t63 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t49, 4
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t49, 5
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t49, 6
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t49, 7
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %s75 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.75, i32 0, i32 0
  %t76 = icmp eq i8* %t74, %s75
  br label %logical_and_entry_46

logical_and_entry_46:
  br i1 %t76, label %logical_and_right_46, label %logical_and_merge_46

logical_and_right_46:
  %t77 = load %Token, %Token* %l9
  %t78 = extractvalue %Token %t77, 0
  %t79 = extractvalue %TokenKind %t78, 0
  %t80 = load %Parser, %Parser* %l0
  %t81 = call %EffectParseResult @parse_effect_list(%Parser %t80)
  store %EffectParseResult %t81, %EffectParseResult* %l10
  %t82 = load %EffectParseResult, %EffectParseResult* %l10
  %t83 = extractvalue %EffectParseResult %t82, 0
  store %Parser %t83, %Parser* %l0
  %t84 = load %EffectParseResult, %EffectParseResult* %l10
  %t85 = extractvalue %EffectParseResult %t84, 1
  store { i8**, i64 }* %t85, { i8**, i64 }** %l11
  %t86 = call double @evaluate_decorators({ %Decorator*, i64 }* %decorators)
  store double %t86, double* %l12
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t88 = load double, double* %l12
  %t89 = call double @infer_effects({ i8**, i64 }* %t87, double %t88)
  store double %t89, double* %l13
  %t90 = load %Parser, %Parser* %l0
  %t91 = call %BlockParseResult @parse_block(%Parser %t90)
  store %BlockParseResult %t91, %BlockParseResult* %l14
  %t92 = load %BlockParseResult, %BlockParseResult* %l14
  %t93 = extractvalue %BlockParseResult %t92, 0
  store %Parser %t93, %Parser* %l0
  %t94 = load %BlockParseResult, %BlockParseResult* %l14
  %t95 = extractvalue %BlockParseResult %t94, 1
  store %Block %t95, %Block* %l15
  %t96 = load i8*, i8** %l2
  %t97 = insertvalue %FunctionSignature undef, i8* %t96, 0
  %t98 = insertvalue %FunctionSignature %t97, i1 0, 1
  %t99 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %l7
  %t100 = insertvalue %FunctionSignature %t98, { %Parameter**, i64 }* %t99, 2
  %t101 = load i8*, i8** %l8
  %t102 = bitcast i8* %t101 to %TypeAnnotation*
  %t103 = insertvalue %FunctionSignature %t100, %TypeAnnotation* %t102, 3
  %t104 = load double, double* %l13
  %t105 = insertvalue %FunctionSignature %t103, { i8**, i64 }* null, 4
  %t106 = alloca [0 x %TypeParameter*]
  %t107 = getelementptr [0 x %TypeParameter*], [0 x %TypeParameter*]* %t106, i32 0, i32 0
  %t108 = alloca { %TypeParameter**, i64 }
  %t109 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t108, i32 0, i32 0
  store %TypeParameter** %t107, %TypeParameter*** %t109
  %t110 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t108, i32 0, i32 1
  store i64 0, i64* %t110
  %t111 = insertvalue %FunctionSignature %t105, { %TypeParameter**, i64 }* %t108, 5
  %t112 = load double, double* %l3
  %t113 = insertvalue %FunctionSignature %t111, %SourceSpan* null, 6
  store %FunctionSignature %t113, %FunctionSignature* %l16
  %t114 = alloca %Statement
  %t115 = getelementptr inbounds %Statement, %Statement* %t114, i32 0, i32 0
  store i32 4, i32* %t115
  %t116 = load %FunctionSignature, %FunctionSignature* %l16
  %t117 = getelementptr inbounds %Statement, %Statement* %t114, i32 0, i32 1
  %t118 = bitcast [24 x i8]* %t117 to i8*
  %t119 = bitcast i8* %t118 to %FunctionSignature*
  store %FunctionSignature %t116, %FunctionSignature* %t119
  %t120 = load %Block, %Block* %l15
  %t121 = getelementptr inbounds %Statement, %Statement* %t114, i32 0, i32 1
  %t122 = bitcast [24 x i8]* %t121 to i8*
  %t123 = getelementptr inbounds i8, i8* %t122, i64 8
  %t124 = bitcast i8* %t123 to %Block*
  store %Block %t120, %Block* %t124
  %t125 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t126 = getelementptr inbounds %Statement, %Statement* %t114, i32 0, i32 1
  %t127 = bitcast [24 x i8]* %t126 to i8*
  %t128 = getelementptr inbounds i8, i8* %t127, i64 16
  %t129 = bitcast i8* %t128 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t125, { %Decorator**, i64 }** %t129
  %t130 = load %Statement, %Statement* %t114
  store %Statement %t130, %Statement* %l17
  %t131 = load %Parser, %Parser* %l0
  %t132 = insertvalue %StatementParseResult undef, %Parser %t131, 0
  %t133 = load %Statement, %Statement* %l17
  %t134 = insertvalue %StatementParseResult %t132, %Statement %t133, 1
  ret %StatementParseResult %t134
}

define %StatementParseResult @parse_tool(%Parser %initial_parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca %ParameterListParseResult
  %l5 = alloca { %Parameter**, i64 }*
  %l6 = alloca i8*
  %l7 = alloca %Token
  %l8 = alloca %EffectParseResult
  %l9 = alloca { i8**, i64 }*
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca %BlockParseResult
  %l13 = alloca %Block
  %l14 = alloca %FunctionSignature
  %l15 = alloca %Statement
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  %t1 = call %Parser @skip_trivia(%Parser %t0)
  store %Parser %t1, %Parser* %l0
  %t2 = load %Parser, %Parser* %l0
  %s3 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.3, i32 0, i32 0
  %t4 = call %Parser @consume_keyword(%Parser %t2, i8* %s3)
  store %Parser %t4, %Parser* %l0
  %t5 = load %Parser, %Parser* %l0
  %t6 = call %Parser @skip_trivia(%Parser %t5)
  store %Parser %t6, %Parser* %l0
  %t7 = load %Parser, %Parser* %l0
  %t8 = call %Token @parser_peek_raw(%Parser %t7)
  store %Token %t8, %Token* %l1
  %t9 = load %Token, %Token* %l1
  %t10 = call i8* @identifier_text(%Token %t9)
  store i8* %t10, i8** %l2
  %t11 = load %Token, %Token* %l1
  %t12 = alloca [1 x %Token]
  %t13 = getelementptr [1 x %Token], [1 x %Token]* %t12, i32 0, i32 0
  %t14 = getelementptr %Token, %Token* %t13, i64 0
  store %Token %t11, %Token* %t14
  %t15 = alloca { %Token*, i64 }
  %t16 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t15, i32 0, i32 0
  store %Token* %t13, %Token** %t16
  %t17 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t15, i32 0, i32 1
  store i64 1, i64* %t17
  %t18 = call double @source_span_from_tokens({ %Token*, i64 }* %t15)
  store double %t18, double* %l3
  %t19 = load %Parser, %Parser* %l0
  %t20 = call %Parser @parser_advance_raw(%Parser %t19)
  store %Parser %t20, %Parser* %l0
  %t21 = load %Parser, %Parser* %l0
  %t22 = call %Parser @skip_trivia(%Parser %t21)
  store %Parser %t22, %Parser* %l0
  %t23 = load %Parser, %Parser* %l0
  %t24 = alloca [2 x i8], align 1
  %t25 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 0
  store i8 40, i8* %t25
  %t26 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 1
  store i8 0, i8* %t26
  %t27 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 0
  %t28 = call %Parser @consume_symbol(%Parser %t23, i8* %t27)
  store %Parser %t28, %Parser* %l0
  %t29 = load %Parser, %Parser* %l0
  %t30 = call %ParameterListParseResult @parse_parameter_list(%Parser %t29)
  store %ParameterListParseResult %t30, %ParameterListParseResult* %l4
  %t31 = load %ParameterListParseResult, %ParameterListParseResult* %l4
  %t32 = extractvalue %ParameterListParseResult %t31, 0
  store %Parser %t32, %Parser* %l0
  %t33 = load %ParameterListParseResult, %ParameterListParseResult* %l4
  %t34 = extractvalue %ParameterListParseResult %t33, 1
  store { %Parameter**, i64 }* %t34, { %Parameter**, i64 }** %l5
  %t35 = load %Parser, %Parser* %l0
  %t36 = call %Parser @skip_trivia(%Parser %t35)
  store %Parser %t36, %Parser* %l0
  store i8* null, i8** %l6
  %t37 = load %Parser, %Parser* %l0
  %t38 = call %Token @parser_peek_raw(%Parser %t37)
  store %Token %t38, %Token* %l7
  %t41 = load %Token, %Token* %l7
  %t42 = extractvalue %Token %t41, 0
  %t43 = extractvalue %TokenKind %t42, 0
  %t44 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t45 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t46 = icmp eq i32 %t43, 0
  %t47 = select i1 %t46, i8* %t45, i8* %t44
  %t48 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t49 = icmp eq i32 %t43, 1
  %t50 = select i1 %t49, i8* %t48, i8* %t47
  %t51 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t52 = icmp eq i32 %t43, 2
  %t53 = select i1 %t52, i8* %t51, i8* %t50
  %t54 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t55 = icmp eq i32 %t43, 3
  %t56 = select i1 %t55, i8* %t54, i8* %t53
  %t57 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t58 = icmp eq i32 %t43, 4
  %t59 = select i1 %t58, i8* %t57, i8* %t56
  %t60 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t61 = icmp eq i32 %t43, 5
  %t62 = select i1 %t61, i8* %t60, i8* %t59
  %t63 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t43, 6
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t43, 7
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %s69 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.69, i32 0, i32 0
  %t70 = icmp eq i8* %t68, %s69
  br label %logical_and_entry_40

logical_and_entry_40:
  br i1 %t70, label %logical_and_right_40, label %logical_and_merge_40

logical_and_right_40:
  %t71 = load %Token, %Token* %l7
  %t72 = extractvalue %Token %t71, 0
  %t73 = extractvalue %TokenKind %t72, 0
  %t74 = load %Parser, %Parser* %l0
  %t75 = call %EffectParseResult @parse_effect_list(%Parser %t74)
  store %EffectParseResult %t75, %EffectParseResult* %l8
  %t76 = load %EffectParseResult, %EffectParseResult* %l8
  %t77 = extractvalue %EffectParseResult %t76, 0
  store %Parser %t77, %Parser* %l0
  %t78 = load %EffectParseResult, %EffectParseResult* %l8
  %t79 = extractvalue %EffectParseResult %t78, 1
  store { i8**, i64 }* %t79, { i8**, i64 }** %l9
  %t80 = call double @evaluate_decorators({ %Decorator*, i64 }* %decorators)
  store double %t80, double* %l10
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t82 = load double, double* %l10
  %t83 = call double @infer_effects({ i8**, i64 }* %t81, double %t82)
  store double %t83, double* %l11
  %t84 = load %Parser, %Parser* %l0
  %t85 = call %BlockParseResult @parse_block(%Parser %t84)
  store %BlockParseResult %t85, %BlockParseResult* %l12
  %t86 = load %BlockParseResult, %BlockParseResult* %l12
  %t87 = extractvalue %BlockParseResult %t86, 0
  store %Parser %t87, %Parser* %l0
  %t88 = load %BlockParseResult, %BlockParseResult* %l12
  %t89 = extractvalue %BlockParseResult %t88, 1
  store %Block %t89, %Block* %l13
  %t90 = load i8*, i8** %l2
  %t91 = insertvalue %FunctionSignature undef, i8* %t90, 0
  %t92 = insertvalue %FunctionSignature %t91, i1 0, 1
  %t93 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %l5
  %t94 = insertvalue %FunctionSignature %t92, { %Parameter**, i64 }* %t93, 2
  %t95 = load i8*, i8** %l6
  %t96 = bitcast i8* %t95 to %TypeAnnotation*
  %t97 = insertvalue %FunctionSignature %t94, %TypeAnnotation* %t96, 3
  %t98 = load double, double* %l11
  %t99 = insertvalue %FunctionSignature %t97, { i8**, i64 }* null, 4
  %t100 = alloca [0 x %TypeParameter*]
  %t101 = getelementptr [0 x %TypeParameter*], [0 x %TypeParameter*]* %t100, i32 0, i32 0
  %t102 = alloca { %TypeParameter**, i64 }
  %t103 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t102, i32 0, i32 0
  store %TypeParameter** %t101, %TypeParameter*** %t103
  %t104 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t102, i32 0, i32 1
  store i64 0, i64* %t104
  %t105 = insertvalue %FunctionSignature %t99, { %TypeParameter**, i64 }* %t102, 5
  %t106 = insertvalue %FunctionSignature %t105, %SourceSpan* null, 6
  store %FunctionSignature %t106, %FunctionSignature* %l14
  %t107 = alloca %Statement
  %t108 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 0
  store i32 5, i32* %t108
  %t109 = load %FunctionSignature, %FunctionSignature* %l14
  %t110 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t111 = bitcast [24 x i8]* %t110 to i8*
  %t112 = bitcast i8* %t111 to %FunctionSignature*
  store %FunctionSignature %t109, %FunctionSignature* %t112
  %t113 = load %Block, %Block* %l13
  %t114 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t115 = bitcast [24 x i8]* %t114 to i8*
  %t116 = getelementptr inbounds i8, i8* %t115, i64 8
  %t117 = bitcast i8* %t116 to %Block*
  store %Block %t113, %Block* %t117
  %t118 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t119 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t120 = bitcast [24 x i8]* %t119 to i8*
  %t121 = getelementptr inbounds i8, i8* %t120, i64 16
  %t122 = bitcast i8* %t121 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t118, { %Decorator**, i64 }** %t122
  %t123 = load %Statement, %Statement* %t107
  store %Statement %t123, %Statement* %l15
  %t124 = load %Parser, %Parser* %l0
  %t125 = insertvalue %StatementParseResult undef, %Parser %t124, 0
  %t126 = load %Statement, %Statement* %l15
  %t127 = insertvalue %StatementParseResult %t125, %Statement %t126, 1
  ret %StatementParseResult %t127
}

define %StatementParseResult @parse_test(%Parser %initial_parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %CaptureResult
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca %EffectParseResult
  %l7 = alloca { i8**, i64 }*
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca %BlockParseResult
  %l11 = alloca %Block
  %l12 = alloca %Statement
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Parser @skip_trivia(%Parser %t1)
  store %Parser %t2, %Parser* %l0
  %t3 = load %Parser, %Parser* %l0
  %s4 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.4, i32 0, i32 0
  %t5 = call %Parser @consume_keyword(%Parser %t3, i8* %s4)
  store %Parser %t5, %Parser* %l0
  %t6 = load %Parser, %Parser* %l0
  %t7 = call %Parser @skip_trivia(%Parser %t6)
  %t8 = alloca [2 x i8]
  %t9 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  %t10 = getelementptr i8, i8* %t9, i64 0
  store i8 33, i8* %t10
  %t11 = getelementptr i8, i8* %t9, i64 1
  store i8 123, i8* %t11
  %t12 = alloca { i8*, i64 }
  %t13 = getelementptr { i8*, i64 }, { i8*, i64 }* %t12, i32 0, i32 0
  store i8* %t9, i8** %t13
  %t14 = getelementptr { i8*, i64 }, { i8*, i64 }* %t12, i32 0, i32 1
  store i64 2, i64* %t14
  %t15 = bitcast { i8*, i64 }* %t12 to { i8**, i64 }*
  %t16 = call %CaptureResult @collect_until(%Parser %t7, { i8**, i64 }* %t15)
  store %CaptureResult %t16, %CaptureResult* %l2
  %t17 = load %CaptureResult, %CaptureResult* %l2
  %t18 = extractvalue %CaptureResult %t17, 0
  store %Parser %t18, %Parser* %l0
  %t19 = load %CaptureResult, %CaptureResult* %l2
  %t20 = extractvalue %CaptureResult %t19, 1
  %t21 = bitcast { %Token**, i64 }* %t20 to { %Token*, i64 }*
  %t22 = call i8* @tokens_to_text({ %Token*, i64 }* %t21)
  %t23 = call i8* @trim_text(i8* %t22)
  store i8* %t23, i8** %l3
  %t24 = load i8*, i8** %l3
  %t25 = call i64 @sailfin_runtime_string_length(i8* %t24)
  %t26 = icmp eq i64 %t25, 0
  %t27 = load %Parser, %Parser* %l0
  %t28 = load %Parser, %Parser* %l1
  %t29 = load %CaptureResult, %CaptureResult* %l2
  %t30 = load i8*, i8** %l3
  br i1 %t26, label %then0, label %merge1
then0:
  %t31 = load %Parser, %Parser* %l1
  %t32 = call %StatementParseResult @parse_unknown(%Parser %t31)
  ret %StatementParseResult %t32
merge1:
  %t33 = load %CaptureResult, %CaptureResult* %l2
  %t34 = extractvalue %CaptureResult %t33, 1
  %t35 = bitcast { %Token**, i64 }* %t34 to { %Token*, i64 }*
  %t36 = call double @source_span_from_tokens({ %Token*, i64 }* %t35)
  store double %t36, double* %l4
  %t37 = load i8*, i8** %l3
  %t38 = call i8* @normalize_test_name(i8* %t37)
  store i8* %t38, i8** %l5
  %t39 = load %Parser, %Parser* %l0
  %t40 = call %EffectParseResult @parse_effect_list(%Parser %t39)
  store %EffectParseResult %t40, %EffectParseResult* %l6
  %t41 = load %EffectParseResult, %EffectParseResult* %l6
  %t42 = extractvalue %EffectParseResult %t41, 0
  store %Parser %t42, %Parser* %l0
  %t43 = load %EffectParseResult, %EffectParseResult* %l6
  %t44 = extractvalue %EffectParseResult %t43, 1
  store { i8**, i64 }* %t44, { i8**, i64 }** %l7
  %t45 = call double @evaluate_decorators({ %Decorator*, i64 }* %decorators)
  store double %t45, double* %l8
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t47 = load double, double* %l8
  %t48 = call double @infer_effects({ i8**, i64 }* %t46, double %t47)
  store double %t48, double* %l9
  %t49 = load %Parser, %Parser* %l0
  %t50 = call %BlockParseResult @parse_block(%Parser %t49)
  store %BlockParseResult %t50, %BlockParseResult* %l10
  %t51 = load %BlockParseResult, %BlockParseResult* %l10
  %t52 = extractvalue %BlockParseResult %t51, 0
  store %Parser %t52, %Parser* %l0
  %t53 = load %BlockParseResult, %BlockParseResult* %l10
  %t54 = extractvalue %BlockParseResult %t53, 1
  store %Block %t54, %Block* %l11
  %t55 = alloca %Statement
  %t56 = getelementptr inbounds %Statement, %Statement* %t55, i32 0, i32 0
  store i32 6, i32* %t56
  %t57 = load i8*, i8** %l5
  %t58 = getelementptr inbounds %Statement, %Statement* %t55, i32 0, i32 1
  %t59 = bitcast [40 x i8]* %t58 to i8*
  %t60 = bitcast i8* %t59 to i8**
  store i8* %t57, i8** %t60
  %t61 = load double, double* %l4
  %t62 = call noalias i8* @malloc(i64 8)
  %t63 = bitcast i8* %t62 to double*
  store double %t61, double* %t63
  %t64 = bitcast i8* %t62 to %SourceSpan*
  %t65 = getelementptr inbounds %Statement, %Statement* %t55, i32 0, i32 1
  %t66 = bitcast [40 x i8]* %t65 to i8*
  %t67 = getelementptr inbounds i8, i8* %t66, i64 8
  %t68 = bitcast i8* %t67 to %SourceSpan**
  store %SourceSpan* %t64, %SourceSpan** %t68
  %t69 = load %Block, %Block* %l11
  %t70 = getelementptr inbounds %Statement, %Statement* %t55, i32 0, i32 1
  %t71 = bitcast [40 x i8]* %t70 to i8*
  %t72 = getelementptr inbounds i8, i8* %t71, i64 16
  %t73 = bitcast i8* %t72 to %Block*
  store %Block %t69, %Block* %t73
  %t74 = load double, double* %l9
  %t75 = call noalias i8* @malloc(i64 8)
  %t76 = bitcast i8* %t75 to double*
  store double %t74, double* %t76
  %t77 = bitcast i8* %t75 to { i8**, i64 }*
  %t78 = getelementptr inbounds %Statement, %Statement* %t55, i32 0, i32 1
  %t79 = bitcast [40 x i8]* %t78 to i8*
  %t80 = getelementptr inbounds i8, i8* %t79, i64 24
  %t81 = bitcast i8* %t80 to { i8**, i64 }**
  store { i8**, i64 }* %t77, { i8**, i64 }** %t81
  %t82 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t83 = getelementptr inbounds %Statement, %Statement* %t55, i32 0, i32 1
  %t84 = bitcast [40 x i8]* %t83 to i8*
  %t85 = getelementptr inbounds i8, i8* %t84, i64 32
  %t86 = bitcast i8* %t85 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t82, { %Decorator**, i64 }** %t86
  %t87 = load %Statement, %Statement* %t55
  store %Statement %t87, %Statement* %l12
  %t88 = load %Parser, %Parser* %l0
  %t89 = insertvalue %StatementParseResult undef, %Parser %t88, 0
  %t90 = load %Statement, %Statement* %l12
  %t91 = insertvalue %StatementParseResult %t89, %Statement %t90, 1
  ret %StatementParseResult %t91
}

define %StatementParseResult @parse_function(%Parser %initial_parser, i1 %starts_with_async, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca i1
  %l2 = alloca %Token
  %l3 = alloca %Parser
  %l4 = alloca %Token
  %l5 = alloca %Token
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca %TypeParameterParseResult
  %l9 = alloca { %TypeParameter**, i64 }*
  %l10 = alloca %ParameterListParseResult
  %l11 = alloca { %Parameter**, i64 }*
  %l12 = alloca i8*
  %l13 = alloca %Token
  %l14 = alloca %EffectParseResult
  %l15 = alloca { i8**, i64 }*
  %l16 = alloca double
  %l17 = alloca double
  %l18 = alloca %BlockParseResult
  %l19 = alloca %Block
  %l20 = alloca %FunctionSignature
  %l21 = alloca %Statement
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  %t1 = call %Parser @skip_trivia(%Parser %t0)
  store %Parser %t1, %Parser* %l0
  store i1 0, i1* %l1
  %t2 = load %Parser, %Parser* %l0
  %t3 = load i1, i1* %l1
  br i1 %starts_with_async, label %then0, label %else1
then0:
  %t4 = load %Parser, %Parser* %l0
  %s5 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.5, i32 0, i32 0
  %t6 = call %Parser @consume_keyword(%Parser %t4, i8* %s5)
  store %Parser %t6, %Parser* %l0
  store i1 1, i1* %l1
  br label %merge2
else1:
  %t7 = load %Parser, %Parser* %l0
  %t8 = call %Token @parser_peek_raw(%Parser %t7)
  store %Token %t8, %Token* %l2
  %t9 = load %Token, %Token* %l2
  %s10 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.10, i32 0, i32 0
  %t11 = call i1 @identifier_matches(%Token %t9, i8* %s10)
  %t12 = load %Parser, %Parser* %l0
  %t13 = load i1, i1* %l1
  %t14 = load %Token, %Token* %l2
  br i1 %t11, label %then3, label %merge4
then3:
  %t15 = load %Parser, %Parser* %l0
  %t16 = call %Parser @parser_advance_raw(%Parser %t15)
  %t17 = call %Parser @skip_trivia(%Parser %t16)
  store %Parser %t17, %Parser* %l3
  %t18 = load %Parser, %Parser* %l3
  %t19 = call %Token @parser_peek_raw(%Parser %t18)
  store %Token %t19, %Token* %l4
  %t20 = load %Token, %Token* %l4
  %s21 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.21, i32 0, i32 0
  %t22 = call i1 @identifier_matches(%Token %t20, i8* %s21)
  %t23 = load %Parser, %Parser* %l0
  %t24 = load i1, i1* %l1
  %t25 = load %Token, %Token* %l2
  %t26 = load %Parser, %Parser* %l3
  %t27 = load %Token, %Token* %l4
  br i1 %t22, label %then5, label %merge6
then5:
  %t28 = load %Parser, %Parser* %l0
  %s29 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.29, i32 0, i32 0
  %t30 = call %Parser @consume_keyword(%Parser %t28, i8* %s29)
  store %Parser %t30, %Parser* %l0
  %t31 = load %Parser, %Parser* %l0
  %t32 = call %Parser @skip_trivia(%Parser %t31)
  store %Parser %t32, %Parser* %l0
  store i1 1, i1* %l1
  br label %merge6
merge6:
  %t33 = phi %Parser [ %t30, %then5 ], [ %t23, %then3 ]
  %t34 = phi %Parser [ %t32, %then5 ], [ %t23, %then3 ]
  %t35 = phi i1 [ 1, %then5 ], [ %t24, %then3 ]
  store %Parser %t33, %Parser* %l0
  store %Parser %t34, %Parser* %l0
  store i1 %t35, i1* %l1
  br label %merge4
merge4:
  %t36 = phi %Parser [ %t30, %then3 ], [ %t12, %else1 ]
  %t37 = phi %Parser [ %t32, %then3 ], [ %t12, %else1 ]
  %t38 = phi i1 [ 1, %then3 ], [ %t13, %else1 ]
  store %Parser %t36, %Parser* %l0
  store %Parser %t37, %Parser* %l0
  store i1 %t38, i1* %l1
  br label %merge2
merge2:
  %t39 = phi %Parser [ %t6, %then0 ], [ %t30, %else1 ]
  %t40 = phi i1 [ 1, %then0 ], [ 1, %else1 ]
  store %Parser %t39, %Parser* %l0
  store i1 %t40, i1* %l1
  %t41 = load %Parser, %Parser* %l0
  %t42 = call %Parser @skip_trivia(%Parser %t41)
  store %Parser %t42, %Parser* %l0
  %t43 = load %Parser, %Parser* %l0
  %s44 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.44, i32 0, i32 0
  %t45 = call %Parser @consume_keyword(%Parser %t43, i8* %s44)
  store %Parser %t45, %Parser* %l0
  %t46 = load %Parser, %Parser* %l0
  %t47 = call %Parser @skip_trivia(%Parser %t46)
  store %Parser %t47, %Parser* %l0
  %t48 = load %Parser, %Parser* %l0
  %t49 = call %Token @parser_peek_raw(%Parser %t48)
  store %Token %t49, %Token* %l5
  %t50 = load %Token, %Token* %l5
  %t51 = call i8* @identifier_text(%Token %t50)
  store i8* %t51, i8** %l6
  %t52 = load %Token, %Token* %l5
  %t53 = alloca [1 x %Token]
  %t54 = getelementptr [1 x %Token], [1 x %Token]* %t53, i32 0, i32 0
  %t55 = getelementptr %Token, %Token* %t54, i64 0
  store %Token %t52, %Token* %t55
  %t56 = alloca { %Token*, i64 }
  %t57 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t56, i32 0, i32 0
  store %Token* %t54, %Token** %t57
  %t58 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t56, i32 0, i32 1
  store i64 1, i64* %t58
  %t59 = call double @source_span_from_tokens({ %Token*, i64 }* %t56)
  store double %t59, double* %l7
  %t60 = load %Parser, %Parser* %l0
  %t61 = call %Parser @parser_advance_raw(%Parser %t60)
  store %Parser %t61, %Parser* %l0
  %t62 = load %Parser, %Parser* %l0
  %t63 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %t62)
  store %TypeParameterParseResult %t63, %TypeParameterParseResult* %l8
  %t64 = load %TypeParameterParseResult, %TypeParameterParseResult* %l8
  %t65 = extractvalue %TypeParameterParseResult %t64, 0
  store %Parser %t65, %Parser* %l0
  %t66 = load %TypeParameterParseResult, %TypeParameterParseResult* %l8
  %t67 = extractvalue %TypeParameterParseResult %t66, 1
  store { %TypeParameter**, i64 }* %t67, { %TypeParameter**, i64 }** %l9
  %t68 = load %Parser, %Parser* %l0
  %t69 = call %Parser @skip_trivia(%Parser %t68)
  store %Parser %t69, %Parser* %l0
  %t70 = load %Parser, %Parser* %l0
  %t71 = alloca [2 x i8], align 1
  %t72 = getelementptr [2 x i8], [2 x i8]* %t71, i32 0, i32 0
  store i8 40, i8* %t72
  %t73 = getelementptr [2 x i8], [2 x i8]* %t71, i32 0, i32 1
  store i8 0, i8* %t73
  %t74 = getelementptr [2 x i8], [2 x i8]* %t71, i32 0, i32 0
  %t75 = call %Parser @consume_symbol(%Parser %t70, i8* %t74)
  store %Parser %t75, %Parser* %l0
  %t76 = load %Parser, %Parser* %l0
  %t77 = call %ParameterListParseResult @parse_parameter_list(%Parser %t76)
  store %ParameterListParseResult %t77, %ParameterListParseResult* %l10
  %t78 = load %ParameterListParseResult, %ParameterListParseResult* %l10
  %t79 = extractvalue %ParameterListParseResult %t78, 0
  store %Parser %t79, %Parser* %l0
  %t80 = load %ParameterListParseResult, %ParameterListParseResult* %l10
  %t81 = extractvalue %ParameterListParseResult %t80, 1
  store { %Parameter**, i64 }* %t81, { %Parameter**, i64 }** %l11
  %t82 = load %Parser, %Parser* %l0
  %t83 = call %Parser @skip_trivia(%Parser %t82)
  store %Parser %t83, %Parser* %l0
  store i8* null, i8** %l12
  %t84 = load %Parser, %Parser* %l0
  %t85 = call %Token @parser_peek_raw(%Parser %t84)
  store %Token %t85, %Token* %l13
  %t88 = load %Token, %Token* %l13
  %t89 = extractvalue %Token %t88, 0
  %t90 = extractvalue %TokenKind %t89, 0
  %t91 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t92 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t93 = icmp eq i32 %t90, 0
  %t94 = select i1 %t93, i8* %t92, i8* %t91
  %t95 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t90, 1
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %t98 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t90, 2
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t90, 3
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t90, 4
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t90, 5
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t90, 6
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t90, 7
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %s116 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.116, i32 0, i32 0
  %t117 = icmp eq i8* %t115, %s116
  br label %logical_and_entry_87

logical_and_entry_87:
  br i1 %t117, label %logical_and_right_87, label %logical_and_merge_87

logical_and_right_87:
  %t118 = load %Token, %Token* %l13
  %t119 = extractvalue %Token %t118, 0
  %t120 = extractvalue %TokenKind %t119, 0
  %t121 = load %Parser, %Parser* %l0
  %t122 = call %EffectParseResult @parse_effect_list(%Parser %t121)
  store %EffectParseResult %t122, %EffectParseResult* %l14
  %t123 = load %EffectParseResult, %EffectParseResult* %l14
  %t124 = extractvalue %EffectParseResult %t123, 0
  store %Parser %t124, %Parser* %l0
  %t125 = load %EffectParseResult, %EffectParseResult* %l14
  %t126 = extractvalue %EffectParseResult %t125, 1
  store { i8**, i64 }* %t126, { i8**, i64 }** %l15
  %t127 = call double @evaluate_decorators({ %Decorator*, i64 }* %decorators)
  store double %t127, double* %l16
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t129 = load double, double* %l16
  %t130 = call double @infer_effects({ i8**, i64 }* %t128, double %t129)
  store double %t130, double* %l17
  %t131 = load %Parser, %Parser* %l0
  %t132 = call %BlockParseResult @parse_block(%Parser %t131)
  store %BlockParseResult %t132, %BlockParseResult* %l18
  %t133 = load %BlockParseResult, %BlockParseResult* %l18
  %t134 = extractvalue %BlockParseResult %t133, 0
  store %Parser %t134, %Parser* %l0
  %t135 = load %BlockParseResult, %BlockParseResult* %l18
  %t136 = extractvalue %BlockParseResult %t135, 1
  store %Block %t136, %Block* %l19
  %t137 = load i8*, i8** %l6
  %t138 = insertvalue %FunctionSignature undef, i8* %t137, 0
  %t139 = load i1, i1* %l1
  %t140 = insertvalue %FunctionSignature %t138, i1 %t139, 1
  %t141 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %l11
  %t142 = insertvalue %FunctionSignature %t140, { %Parameter**, i64 }* %t141, 2
  %t143 = load i8*, i8** %l12
  %t144 = bitcast i8* %t143 to %TypeAnnotation*
  %t145 = insertvalue %FunctionSignature %t142, %TypeAnnotation* %t144, 3
  %t146 = load double, double* %l17
  %t147 = insertvalue %FunctionSignature %t145, { i8**, i64 }* null, 4
  %t148 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l9
  %t149 = insertvalue %FunctionSignature %t147, { %TypeParameter**, i64 }* %t148, 5
  %t150 = load double, double* %l7
  %t151 = insertvalue %FunctionSignature %t149, %SourceSpan* null, 6
  store %FunctionSignature %t151, %FunctionSignature* %l20
  %t152 = alloca %Statement
  %t153 = getelementptr inbounds %Statement, %Statement* %t152, i32 0, i32 0
  store i32 7, i32* %t153
  %t154 = load %FunctionSignature, %FunctionSignature* %l20
  %t155 = getelementptr inbounds %Statement, %Statement* %t152, i32 0, i32 1
  %t156 = bitcast [24 x i8]* %t155 to i8*
  %t157 = bitcast i8* %t156 to %FunctionSignature*
  store %FunctionSignature %t154, %FunctionSignature* %t157
  %t158 = load %Block, %Block* %l19
  %t159 = getelementptr inbounds %Statement, %Statement* %t152, i32 0, i32 1
  %t160 = bitcast [24 x i8]* %t159 to i8*
  %t161 = getelementptr inbounds i8, i8* %t160, i64 8
  %t162 = bitcast i8* %t161 to %Block*
  store %Block %t158, %Block* %t162
  %t163 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t164 = getelementptr inbounds %Statement, %Statement* %t152, i32 0, i32 1
  %t165 = bitcast [24 x i8]* %t164 to i8*
  %t166 = getelementptr inbounds i8, i8* %t165, i64 16
  %t167 = bitcast i8* %t166 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t163, { %Decorator**, i64 }** %t167
  %t168 = load %Statement, %Statement* %t152
  store %Statement %t168, %Statement* %l21
  %t169 = load %Parser, %Parser* %l0
  %t170 = insertvalue %StatementParseResult undef, %Parser %t169, 0
  %t171 = load %Statement, %Statement* %l21
  %t172 = insertvalue %StatementParseResult %t170, %Statement %t171, 1
  ret %StatementParseResult %t172
}

define %ParameterListParseResult @parse_parameter_list(%Parser %initial_parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca { %Parameter*, i64 }*
  %l2 = alloca %Token
  %l3 = alloca %ParameterParseResult
  %l4 = alloca %Token
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  %t1 = call %Parser @skip_trivia(%Parser %t0)
  store %Parser %t1, %Parser* %l0
  %t2 = alloca [0 x %Parameter]
  %t3 = getelementptr [0 x %Parameter], [0 x %Parameter]* %t2, i32 0, i32 0
  %t4 = alloca { %Parameter*, i64 }
  %t5 = getelementptr { %Parameter*, i64 }, { %Parameter*, i64 }* %t4, i32 0, i32 0
  store %Parameter* %t3, %Parameter** %t5
  %t6 = getelementptr { %Parameter*, i64 }, { %Parameter*, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  store { %Parameter*, i64 }* %t4, { %Parameter*, i64 }** %l1
  %t7 = load %Parser, %Parser* %l0
  %t8 = call %Token @parser_peek_raw(%Parser %t7)
  store %Token %t8, %Token* %l2
  %t10 = load %Token, %Token* %l2
  %t11 = extractvalue %Token %t10, 0
  %t12 = extractvalue %TokenKind %t11, 0
  %t13 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t14 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t15 = icmp eq i32 %t12, 0
  %t16 = select i1 %t15, i8* %t14, i8* %t13
  %t17 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t12, 1
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t12, 2
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t12, 3
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t12, 4
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t12, 5
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t12, 6
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t12, 7
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %s38 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.38, i32 0, i32 0
  %t39 = icmp eq i8* %t37, %s38
  br label %logical_and_entry_9

logical_and_entry_9:
  br i1 %t39, label %logical_and_right_9, label %logical_and_merge_9

logical_and_right_9:
  %t40 = load %Token, %Token* %l2
  %t41 = extractvalue %Token %t40, 0
  %t42 = extractvalue %TokenKind %t41, 0
  %t43 = load %Parser, %Parser* %l0
  %t44 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t45 = load %Token, %Token* %l2
  br label %loop.header0
loop.header0:
  %t163 = phi %Parser [ %t43, %entry ], [ %t161, %loop.latch2 ]
  %t164 = phi { %Parameter*, i64 }* [ %t44, %entry ], [ %t162, %loop.latch2 ]
  store %Parser %t163, %Parser* %l0
  store { %Parameter*, i64 }* %t164, { %Parameter*, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t46 = load %Parser, %Parser* %l0
  %t47 = call %ParameterParseResult @parse_single_parameter(%Parser %t46)
  store %ParameterParseResult %t47, %ParameterParseResult* %l3
  %t48 = load %ParameterParseResult, %ParameterParseResult* %l3
  %t49 = extractvalue %ParameterParseResult %t48, 0
  store %Parser %t49, %Parser* %l0
  %t50 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t51 = load %ParameterParseResult, %ParameterParseResult* %l3
  %t52 = extractvalue %ParameterParseResult %t51, 1
  %t53 = call { %Parameter*, i64 }* @append_parameter({ %Parameter*, i64 }* %t50, %Parameter %t52)
  store { %Parameter*, i64 }* %t53, { %Parameter*, i64 }** %l1
  %t54 = load %Parser, %Parser* %l0
  %t55 = call %Parser @skip_trivia(%Parser %t54)
  store %Parser %t55, %Parser* %l0
  %t56 = load %Parser, %Parser* %l0
  %t57 = call %Token @parser_peek_raw(%Parser %t56)
  store %Token %t57, %Token* %l4
  %t59 = load %Token, %Token* %l4
  %t60 = extractvalue %Token %t59, 0
  %t61 = extractvalue %TokenKind %t60, 0
  %t62 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t63 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t61, 0
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t61, 1
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t61, 2
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t61, 3
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t61, 4
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t61, 5
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %t81 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t61, 6
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t61, 7
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %s87 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.87, i32 0, i32 0
  %t88 = icmp eq i8* %t86, %s87
  br label %logical_and_entry_58

logical_and_entry_58:
  br i1 %t88, label %logical_and_right_58, label %logical_and_merge_58

logical_and_right_58:
  %t89 = load %Token, %Token* %l4
  %t90 = extractvalue %Token %t89, 0
  %t91 = extractvalue %TokenKind %t90, 0
  %t93 = load %Token, %Token* %l4
  %t94 = extractvalue %Token %t93, 0
  %t95 = extractvalue %TokenKind %t94, 0
  %t96 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t97 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t95, 0
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %t100 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t95, 1
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %t103 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t104 = icmp eq i32 %t95, 2
  %t105 = select i1 %t104, i8* %t103, i8* %t102
  %t106 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t107 = icmp eq i32 %t95, 3
  %t108 = select i1 %t107, i8* %t106, i8* %t105
  %t109 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t110 = icmp eq i32 %t95, 4
  %t111 = select i1 %t110, i8* %t109, i8* %t108
  %t112 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t113 = icmp eq i32 %t95, 5
  %t114 = select i1 %t113, i8* %t112, i8* %t111
  %t115 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t116 = icmp eq i32 %t95, 6
  %t117 = select i1 %t116, i8* %t115, i8* %t114
  %t118 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t119 = icmp eq i32 %t95, 7
  %t120 = select i1 %t119, i8* %t118, i8* %t117
  %s121 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.121, i32 0, i32 0
  %t122 = icmp eq i8* %t120, %s121
  br label %logical_and_entry_92

logical_and_entry_92:
  br i1 %t122, label %logical_and_right_92, label %logical_and_merge_92

logical_and_right_92:
  %t123 = load %Token, %Token* %l4
  %t124 = extractvalue %Token %t123, 0
  %t125 = extractvalue %TokenKind %t124, 0
  %t126 = load %Token, %Token* %l4
  %t127 = extractvalue %Token %t126, 0
  %t128 = extractvalue %TokenKind %t127, 0
  %t129 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t130 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t131 = icmp eq i32 %t128, 0
  %t132 = select i1 %t131, i8* %t130, i8* %t129
  %t133 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t134 = icmp eq i32 %t128, 1
  %t135 = select i1 %t134, i8* %t133, i8* %t132
  %t136 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t128, 2
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t128, 3
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t128, 4
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t128, 5
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t128, 6
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t128, 7
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %s154 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.154, i32 0, i32 0
  %t155 = icmp eq i8* %t153, %s154
  %t156 = load %Parser, %Parser* %l0
  %t157 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t158 = load %Token, %Token* %l2
  %t159 = load %ParameterParseResult, %ParameterParseResult* %l3
  %t160 = load %Token, %Token* %l4
  br i1 %t155, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  br label %loop.latch2
loop.latch2:
  %t161 = load %Parser, %Parser* %l0
  %t162 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t165 = load %Parser, %Parser* %l0
  %t166 = insertvalue %ParameterListParseResult undef, %Parser %t165, 0
  %t167 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t168 = bitcast { %Parameter*, i64 }* %t167 to { %Parameter**, i64 }*
  %t169 = insertvalue %ParameterListParseResult %t166, { %Parameter**, i64 }* %t168, 1
  ret %ParameterListParseResult %t169
}

define %StructFieldParseResult @parse_struct_field(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca i1
  %l2 = alloca %Token
  %l3 = alloca %Token
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca %Token
  %l7 = alloca i1
  %l8 = alloca %CaptureResult
  %l9 = alloca i8*
  %l10 = alloca %Token
  %l11 = alloca %FieldDeclaration
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  store i1 0, i1* %l1
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Token @parser_peek_raw(%Parser %t1)
  store %Token %t2, %Token* %l2
  %t3 = load %Token, %Token* %l2
  store %Token %t3, %Token* %l3
  %t4 = load %Token, %Token* %l3
  %s5 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.5, i32 0, i32 0
  %t6 = call i1 @identifier_matches(%Token %t4, i8* %s5)
  %t7 = load %Parser, %Parser* %l0
  %t8 = load i1, i1* %l1
  %t9 = load %Token, %Token* %l2
  %t10 = load %Token, %Token* %l3
  br i1 %t6, label %then0, label %merge1
then0:
  %t11 = load %Parser, %Parser* %l0
  %t12 = call %Parser @parser_advance_raw(%Parser %t11)
  store %Parser %t12, %Parser* %l0
  store i1 1, i1* %l1
  %t13 = load %Parser, %Parser* %l0
  %t14 = call %Parser @skip_trivia(%Parser %t13)
  store %Parser %t14, %Parser* %l0
  %t15 = load %Parser, %Parser* %l0
  %t16 = call %Token @parser_peek_raw(%Parser %t15)
  store %Token %t16, %Token* %l3
  br label %merge1
merge1:
  %t17 = phi %Parser [ %t12, %then0 ], [ %t7, %entry ]
  %t18 = phi i1 [ 1, %then0 ], [ %t8, %entry ]
  %t19 = phi %Parser [ %t14, %then0 ], [ %t7, %entry ]
  %t20 = phi %Token [ %t16, %then0 ], [ %t10, %entry ]
  store %Parser %t17, %Parser* %l0
  store i1 %t18, i1* %l1
  store %Parser %t19, %Parser* %l0
  store %Token %t20, %Token* %l3
  %t21 = load %Token, %Token* %l3
  %t22 = extractvalue %Token %t21, 0
  %t23 = extractvalue %TokenKind %t22, 0
  %t24 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t25 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t23, 0
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t23, 1
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %t31 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t32 = icmp eq i32 %t23, 2
  %t33 = select i1 %t32, i8* %t31, i8* %t30
  %t34 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t23, 3
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %t37 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t23, 4
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %t40 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t41 = icmp eq i32 %t23, 5
  %t42 = select i1 %t41, i8* %t40, i8* %t39
  %t43 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t44 = icmp eq i32 %t23, 6
  %t45 = select i1 %t44, i8* %t43, i8* %t42
  %t46 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t47 = icmp eq i32 %t23, 7
  %t48 = select i1 %t47, i8* %t46, i8* %t45
  %s49 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.49, i32 0, i32 0
  %t50 = icmp ne i8* %t48, %s49
  %t51 = load %Parser, %Parser* %l0
  %t52 = load i1, i1* %l1
  %t53 = load %Token, %Token* %l2
  %t54 = load %Token, %Token* %l3
  br i1 %t50, label %then2, label %merge3
then2:
  %t55 = insertvalue %StructFieldParseResult undef, %Parser %parser, 0
  %t56 = bitcast i8* null to %FieldDeclaration*
  %t57 = insertvalue %StructFieldParseResult %t55, %FieldDeclaration* %t56, 1
  %t58 = insertvalue %StructFieldParseResult %t57, i1 0, 2
  ret %StructFieldParseResult %t58
merge3:
  %t59 = load %Token, %Token* %l3
  %t60 = call i8* @identifier_text(%Token %t59)
  store i8* %t60, i8** %l4
  %t61 = load %Token, %Token* %l3
  %t62 = alloca [1 x %Token]
  %t63 = getelementptr [1 x %Token], [1 x %Token]* %t62, i32 0, i32 0
  %t64 = getelementptr %Token, %Token* %t63, i64 0
  store %Token %t61, %Token* %t64
  %t65 = alloca { %Token*, i64 }
  %t66 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t65, i32 0, i32 0
  store %Token* %t63, %Token** %t66
  %t67 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t65, i32 0, i32 1
  store i64 1, i64* %t67
  %t68 = call double @source_span_from_tokens({ %Token*, i64 }* %t65)
  store double %t68, double* %l5
  %t69 = load %Parser, %Parser* %l0
  %t70 = call %Parser @parser_advance_raw(%Parser %t69)
  store %Parser %t70, %Parser* %l0
  %t71 = load %Parser, %Parser* %l0
  %t72 = call %Parser @skip_trivia(%Parser %t71)
  store %Parser %t72, %Parser* %l0
  %t73 = load %Parser, %Parser* %l0
  %t74 = call %Token @parser_peek_raw(%Parser %t73)
  store %Token %t74, %Token* %l6
  %t75 = load %Token, %Token* %l6
  %t76 = extractvalue %Token %t75, 0
  %t77 = extractvalue %TokenKind %t76, 0
  %t78 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t79 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t77, 0
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t77, 1
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %t85 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t77, 2
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t77, 3
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t77, 4
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t77, 5
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t77, 6
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %t100 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t77, 7
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %s103 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.103, i32 0, i32 0
  %t104 = icmp eq i8* %t102, %s103
  store i1 %t104, i1* %l7
  %t105 = load i1, i1* %l7
  %t106 = xor i1 %t105, 1
  %t107 = load %Parser, %Parser* %l0
  %t108 = load i1, i1* %l1
  %t109 = load %Token, %Token* %l2
  %t110 = load %Token, %Token* %l3
  %t111 = load i8*, i8** %l4
  %t112 = load double, double* %l5
  %t113 = load %Token, %Token* %l6
  %t114 = load i1, i1* %l7
  br i1 %t106, label %then4, label %merge5
then4:
  %t115 = insertvalue %StructFieldParseResult undef, %Parser %parser, 0
  %t116 = bitcast i8* null to %FieldDeclaration*
  %t117 = insertvalue %StructFieldParseResult %t115, %FieldDeclaration* %t116, 1
  %t118 = insertvalue %StructFieldParseResult %t117, i1 0, 2
  ret %StructFieldParseResult %t118
merge5:
  %t119 = load %Parser, %Parser* %l0
  %t120 = call %Parser @parser_advance_raw(%Parser %t119)
  store %Parser %t120, %Parser* %l0
  %t121 = load %Parser, %Parser* %l0
  %t122 = call %Parser @skip_trivia(%Parser %t121)
  %t123 = alloca [1 x i8]
  %t124 = getelementptr [1 x i8], [1 x i8]* %t123, i32 0, i32 0
  %t125 = getelementptr i8, i8* %t124, i64 0
  store i8 59, i8* %t125
  %t126 = alloca { i8*, i64 }
  %t127 = getelementptr { i8*, i64 }, { i8*, i64 }* %t126, i32 0, i32 0
  store i8* %t124, i8** %t127
  %t128 = getelementptr { i8*, i64 }, { i8*, i64 }* %t126, i32 0, i32 1
  store i64 1, i64* %t128
  %t129 = bitcast { i8*, i64 }* %t126 to { i8**, i64 }*
  %t130 = call %CaptureResult @collect_until(%Parser %t122, { i8**, i64 }* %t129)
  store %CaptureResult %t130, %CaptureResult* %l8
  %t131 = load %CaptureResult, %CaptureResult* %l8
  %t132 = extractvalue %CaptureResult %t131, 0
  store %Parser %t132, %Parser* %l0
  %t133 = load %CaptureResult, %CaptureResult* %l8
  %t134 = extractvalue %CaptureResult %t133, 1
  %t135 = bitcast { %Token**, i64 }* %t134 to { %Token*, i64 }*
  %t136 = call i8* @tokens_to_text({ %Token*, i64 }* %t135)
  %t137 = call i8* @trim_text(i8* %t136)
  store i8* %t137, i8** %l9
  %t138 = load i8*, i8** %l9
  %t139 = call i64 @sailfin_runtime_string_length(i8* %t138)
  %t140 = icmp eq i64 %t139, 0
  %t141 = load %Parser, %Parser* %l0
  %t142 = load i1, i1* %l1
  %t143 = load %Token, %Token* %l2
  %t144 = load %Token, %Token* %l3
  %t145 = load i8*, i8** %l4
  %t146 = load double, double* %l5
  %t147 = load %Token, %Token* %l6
  %t148 = load i1, i1* %l7
  %t149 = load %CaptureResult, %CaptureResult* %l8
  %t150 = load i8*, i8** %l9
  br i1 %t140, label %then6, label %merge7
then6:
  %t151 = insertvalue %StructFieldParseResult undef, %Parser %parser, 0
  %t152 = bitcast i8* null to %FieldDeclaration*
  %t153 = insertvalue %StructFieldParseResult %t151, %FieldDeclaration* %t152, 1
  %t154 = insertvalue %StructFieldParseResult %t153, i1 0, 2
  ret %StructFieldParseResult %t154
merge7:
  %t155 = load %Parser, %Parser* %l0
  %t156 = call %Parser @skip_trivia(%Parser %t155)
  store %Parser %t156, %Parser* %l0
  %t157 = load %Parser, %Parser* %l0
  %t158 = call %Token @parser_peek_raw(%Parser %t157)
  store %Token %t158, %Token* %l10
  %t160 = load %Token, %Token* %l10
  %t161 = extractvalue %Token %t160, 0
  %t162 = extractvalue %TokenKind %t161, 0
  %t163 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t164 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t162, 0
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t162, 1
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t162, 2
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t162, 3
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %t176 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t177 = icmp eq i32 %t162, 4
  %t178 = select i1 %t177, i8* %t176, i8* %t175
  %t179 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t162, 5
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t162, 6
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t162, 7
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %s188 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.188, i32 0, i32 0
  %t189 = icmp ne i8* %t187, %s188
  br label %logical_or_entry_159

logical_or_entry_159:
  br i1 %t189, label %logical_or_merge_159, label %logical_or_right_159

logical_or_right_159:
  %t190 = load %Token, %Token* %l10
  %t191 = extractvalue %Token %t190, 0
  %t192 = extractvalue %TokenKind %t191, 0
  %t193 = load %Parser, %Parser* %l0
  %t194 = call %Parser @parser_advance_raw(%Parser %t193)
  store %Parser %t194, %Parser* %l0
  %t195 = load i8*, i8** %l4
  %t196 = insertvalue %FieldDeclaration undef, i8* %t195, 0
  %t197 = load i8*, i8** %l9
  %t198 = insertvalue %TypeAnnotation undef, i8* %t197, 0
  %t199 = insertvalue %FieldDeclaration %t196, %TypeAnnotation %t198, 1
  %t200 = load i1, i1* %l1
  %t201 = insertvalue %FieldDeclaration %t199, i1 %t200, 2
  %t202 = load double, double* %l5
  %t203 = insertvalue %FieldDeclaration %t201, %SourceSpan* null, 3
  store %FieldDeclaration %t203, %FieldDeclaration* %l11
  %t204 = load %Parser, %Parser* %l0
  %t205 = insertvalue %StructFieldParseResult undef, %Parser %t204, 0
  %t206 = load %FieldDeclaration, %FieldDeclaration* %l11
  %t207 = insertvalue %StructFieldParseResult %t205, %FieldDeclaration* null, 1
  %t208 = insertvalue %StructFieldParseResult %t207, i1 1, 2
  ret %StructFieldParseResult %t208
}

define %ModelPropertyParseResult @parse_model_property(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  %l2 = alloca i8*
  %l3 = alloca %Token
  %l4 = alloca %CaptureResult
  %l5 = alloca %Expression
  %l6 = alloca %Token
  %l7 = alloca %ModelProperty
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Token @parser_peek_raw(%Parser %t1)
  store %Token %t2, %Token* %l1
  %t3 = load %Token, %Token* %l1
  %t4 = extractvalue %Token %t3, 0
  %t5 = extractvalue %TokenKind %t4, 0
  %t6 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t7 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t8 = icmp eq i32 %t5, 0
  %t9 = select i1 %t8, i8* %t7, i8* %t6
  %t10 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t11 = icmp eq i32 %t5, 1
  %t12 = select i1 %t11, i8* %t10, i8* %t9
  %t13 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t14 = icmp eq i32 %t5, 2
  %t15 = select i1 %t14, i8* %t13, i8* %t12
  %t16 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t17 = icmp eq i32 %t5, 3
  %t18 = select i1 %t17, i8* %t16, i8* %t15
  %t19 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t20 = icmp eq i32 %t5, 4
  %t21 = select i1 %t20, i8* %t19, i8* %t18
  %t22 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t23 = icmp eq i32 %t5, 5
  %t24 = select i1 %t23, i8* %t22, i8* %t21
  %t25 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t5, 6
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t5, 7
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %s31 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.31, i32 0, i32 0
  %t32 = icmp ne i8* %t30, %s31
  %t33 = load %Parser, %Parser* %l0
  %t34 = load %Token, %Token* %l1
  br i1 %t32, label %then0, label %merge1
then0:
  %t35 = insertvalue %ModelPropertyParseResult undef, %Parser %parser, 0
  %t36 = bitcast i8* null to %ModelProperty*
  %t37 = insertvalue %ModelPropertyParseResult %t35, %ModelProperty* %t36, 1
  %t38 = insertvalue %ModelPropertyParseResult %t37, i1 0, 2
  ret %ModelPropertyParseResult %t38
merge1:
  %t39 = load %Token, %Token* %l1
  %t40 = call i8* @identifier_text(%Token %t39)
  store i8* %t40, i8** %l2
  %t41 = load %Parser, %Parser* %l0
  %t42 = call %Parser @parser_advance_raw(%Parser %t41)
  store %Parser %t42, %Parser* %l0
  %t43 = load %Parser, %Parser* %l0
  %t44 = call %Parser @skip_trivia(%Parser %t43)
  store %Parser %t44, %Parser* %l0
  %t45 = load %Parser, %Parser* %l0
  %t46 = call %Token @parser_peek_raw(%Parser %t45)
  store %Token %t46, %Token* %l3
  %t48 = load %Token, %Token* %l3
  %t49 = extractvalue %Token %t48, 0
  %t50 = extractvalue %TokenKind %t49, 0
  %t51 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t52 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t53 = icmp eq i32 %t50, 0
  %t54 = select i1 %t53, i8* %t52, i8* %t51
  %t55 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t50, 1
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t50, 2
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t50, 3
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t50, 4
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t50, 5
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t50, 6
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t50, 7
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %s76 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.76, i32 0, i32 0
  %t77 = icmp ne i8* %t75, %s76
  br label %logical_or_entry_47

logical_or_entry_47:
  br i1 %t77, label %logical_or_merge_47, label %logical_or_right_47

logical_or_right_47:
  %t78 = load %Token, %Token* %l3
  %t79 = extractvalue %Token %t78, 0
  %t80 = extractvalue %TokenKind %t79, 0
  %t81 = load %Parser, %Parser* %l0
  %t82 = call %Parser @parser_advance_raw(%Parser %t81)
  store %Parser %t82, %Parser* %l0
  %t83 = load %Parser, %Parser* %l0
  %t84 = call %Parser @skip_trivia(%Parser %t83)
  %t85 = alloca [1 x i8]
  %t86 = getelementptr [1 x i8], [1 x i8]* %t85, i32 0, i32 0
  %t87 = getelementptr i8, i8* %t86, i64 0
  store i8 59, i8* %t87
  %t88 = alloca { i8*, i64 }
  %t89 = getelementptr { i8*, i64 }, { i8*, i64 }* %t88, i32 0, i32 0
  store i8* %t86, i8** %t89
  %t90 = getelementptr { i8*, i64 }, { i8*, i64 }* %t88, i32 0, i32 1
  store i64 1, i64* %t90
  %t91 = bitcast { i8*, i64 }* %t88 to { i8**, i64 }*
  %t92 = call %CaptureResult @collect_until(%Parser %t84, { i8**, i64 }* %t91)
  store %CaptureResult %t92, %CaptureResult* %l4
  %t93 = load %CaptureResult, %CaptureResult* %l4
  %t94 = extractvalue %CaptureResult %t93, 0
  store %Parser %t94, %Parser* %l0
  %t95 = load %CaptureResult, %CaptureResult* %l4
  %t96 = extractvalue %CaptureResult %t95, 1
  %t97 = bitcast { %Token**, i64 }* %t96 to { %Token*, i64 }*
  %t98 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t97)
  store %Expression %t98, %Expression* %l5
  %t99 = load %Parser, %Parser* %l0
  %t100 = call %Parser @skip_trivia(%Parser %t99)
  store %Parser %t100, %Parser* %l0
  %t101 = load %Parser, %Parser* %l0
  %t102 = call %Token @parser_peek_raw(%Parser %t101)
  store %Token %t102, %Token* %l6
  %t104 = load %Token, %Token* %l6
  %t105 = extractvalue %Token %t104, 0
  %t106 = extractvalue %TokenKind %t105, 0
  %t107 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t108 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t106, 0
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t112 = icmp eq i32 %t106, 1
  %t113 = select i1 %t112, i8* %t111, i8* %t110
  %t114 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t106, 2
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %t117 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t118 = icmp eq i32 %t106, 3
  %t119 = select i1 %t118, i8* %t117, i8* %t116
  %t120 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t106, 4
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %t123 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t124 = icmp eq i32 %t106, 5
  %t125 = select i1 %t124, i8* %t123, i8* %t122
  %t126 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t127 = icmp eq i32 %t106, 6
  %t128 = select i1 %t127, i8* %t126, i8* %t125
  %t129 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t130 = icmp eq i32 %t106, 7
  %t131 = select i1 %t130, i8* %t129, i8* %t128
  %s132 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.132, i32 0, i32 0
  %t133 = icmp ne i8* %t131, %s132
  br label %logical_or_entry_103

logical_or_entry_103:
  br i1 %t133, label %logical_or_merge_103, label %logical_or_right_103

logical_or_right_103:
  %t134 = load %Token, %Token* %l6
  %t135 = extractvalue %Token %t134, 0
  %t136 = extractvalue %TokenKind %t135, 0
  %t137 = load %Parser, %Parser* %l0
  %t138 = call %Parser @parser_advance_raw(%Parser %t137)
  store %Parser %t138, %Parser* %l0
  %t139 = load i8*, i8** %l2
  %t140 = insertvalue %ModelProperty undef, i8* %t139, 0
  %t141 = load %Expression, %Expression* %l5
  %t142 = insertvalue %ModelProperty %t140, %Expression %t141, 1
  %t143 = load %Token, %Token* %l1
  %t144 = alloca [1 x %Token]
  %t145 = getelementptr [1 x %Token], [1 x %Token]* %t144, i32 0, i32 0
  %t146 = getelementptr %Token, %Token* %t145, i64 0
  store %Token %t143, %Token* %t146
  %t147 = alloca { %Token*, i64 }
  %t148 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t147, i32 0, i32 0
  store %Token* %t145, %Token** %t148
  %t149 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t147, i32 0, i32 1
  store i64 1, i64* %t149
  %t150 = call double @source_span_from_tokens({ %Token*, i64 }* %t147)
  %t151 = insertvalue %ModelProperty %t142, %SourceSpan* null, 2
  store %ModelProperty %t151, %ModelProperty* %l7
  %t152 = load %Parser, %Parser* %l0
  %t153 = insertvalue %ModelPropertyParseResult undef, %Parser %t152, 0
  %t154 = load %ModelProperty, %ModelProperty* %l7
  %t155 = insertvalue %ModelPropertyParseResult %t153, %ModelProperty* null, 1
  %t156 = insertvalue %ModelPropertyParseResult %t155, i1 1, 2
  ret %ModelPropertyParseResult %t156
}

define %MethodParseResult @parse_struct_method(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca i1
  %l2 = alloca %Token
  %l3 = alloca %Parser
  %l4 = alloca %Token
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca %TypeParameterParseResult
  %l8 = alloca { %TypeParameter**, i64 }*
  %l9 = alloca %ParameterListParseResult
  %l10 = alloca { %Parameter**, i64 }*
  %l11 = alloca i8*
  %l12 = alloca %Token
  %l13 = alloca %EffectParseResult
  %l14 = alloca { i8**, i64 }*
  %l15 = alloca double
  %l16 = alloca double
  %l17 = alloca %BlockParseResult
  %l18 = alloca %Block
  %l19 = alloca %FunctionSignature
  %l20 = alloca %MethodDeclaration
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  store i1 0, i1* %l1
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Token @parser_peek_raw(%Parser %t1)
  store %Token %t2, %Token* %l2
  %t3 = load %Token, %Token* %l2
  %s4 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.4, i32 0, i32 0
  %t5 = call i1 @identifier_matches(%Token %t3, i8* %s4)
  %t6 = load %Parser, %Parser* %l0
  %t7 = load i1, i1* %l1
  %t8 = load %Token, %Token* %l2
  br i1 %t5, label %then0, label %merge1
then0:
  %t9 = load %Parser, %Parser* %l0
  %t10 = call %Parser @parser_advance_raw(%Parser %t9)
  %t11 = call %Parser @skip_trivia(%Parser %t10)
  store %Parser %t11, %Parser* %l3
  %t12 = load %Parser, %Parser* %l3
  %t13 = call %Token @parser_peek_raw(%Parser %t12)
  %s14 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.14, i32 0, i32 0
  %t15 = call i1 @identifier_matches(%Token %t13, i8* %s14)
  %t16 = load %Parser, %Parser* %l0
  %t17 = load i1, i1* %l1
  %t18 = load %Token, %Token* %l2
  %t19 = load %Parser, %Parser* %l3
  br i1 %t15, label %then2, label %merge3
then2:
  %t20 = load %Parser, %Parser* %l0
  %s21 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.21, i32 0, i32 0
  %t22 = call %Parser @consume_keyword(%Parser %t20, i8* %s21)
  store %Parser %t22, %Parser* %l0
  store i1 1, i1* %l1
  br label %merge3
merge3:
  %t23 = phi %Parser [ %t22, %then2 ], [ %t16, %then0 ]
  %t24 = phi i1 [ 1, %then2 ], [ %t17, %then0 ]
  store %Parser %t23, %Parser* %l0
  store i1 %t24, i1* %l1
  br label %merge1
merge1:
  %t25 = phi %Parser [ %t22, %then0 ], [ %t6, %entry ]
  %t26 = phi i1 [ 1, %then0 ], [ %t7, %entry ]
  store %Parser %t25, %Parser* %l0
  store i1 %t26, i1* %l1
  %t27 = load %Parser, %Parser* %l0
  %t28 = call %Parser @skip_trivia(%Parser %t27)
  store %Parser %t28, %Parser* %l0
  %t29 = load %Parser, %Parser* %l0
  %t30 = call %Token @parser_peek_raw(%Parser %t29)
  %s31 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.31, i32 0, i32 0
  %t32 = call i1 @identifier_matches(%Token %t30, i8* %s31)
  %t33 = xor i1 %t32, 1
  %t34 = load %Parser, %Parser* %l0
  %t35 = load i1, i1* %l1
  %t36 = load %Token, %Token* %l2
  br i1 %t33, label %then4, label %merge5
then4:
  %t37 = insertvalue %MethodParseResult undef, %Parser %parser, 0
  %t38 = bitcast i8* null to %MethodDeclaration*
  %t39 = insertvalue %MethodParseResult %t37, %MethodDeclaration* %t38, 1
  %t40 = insertvalue %MethodParseResult %t39, i1 0, 2
  ret %MethodParseResult %t40
merge5:
  %t41 = load %Parser, %Parser* %l0
  %s42 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.42, i32 0, i32 0
  %t43 = call %Parser @consume_keyword(%Parser %t41, i8* %s42)
  store %Parser %t43, %Parser* %l0
  %t44 = load %Parser, %Parser* %l0
  %t45 = call %Parser @skip_trivia(%Parser %t44)
  store %Parser %t45, %Parser* %l0
  %t46 = load %Parser, %Parser* %l0
  %t47 = call %Token @parser_peek_raw(%Parser %t46)
  store %Token %t47, %Token* %l4
  %t48 = load %Token, %Token* %l4
  %t49 = extractvalue %Token %t48, 0
  %t50 = extractvalue %TokenKind %t49, 0
  %t51 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t52 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t53 = icmp eq i32 %t50, 0
  %t54 = select i1 %t53, i8* %t52, i8* %t51
  %t55 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t50, 1
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t50, 2
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t50, 3
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t50, 4
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t50, 5
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t50, 6
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t50, 7
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %s76 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.76, i32 0, i32 0
  %t77 = icmp ne i8* %t75, %s76
  %t78 = load %Parser, %Parser* %l0
  %t79 = load i1, i1* %l1
  %t80 = load %Token, %Token* %l2
  %t81 = load %Token, %Token* %l4
  br i1 %t77, label %then6, label %merge7
then6:
  %t82 = insertvalue %MethodParseResult undef, %Parser %parser, 0
  %t83 = bitcast i8* null to %MethodDeclaration*
  %t84 = insertvalue %MethodParseResult %t82, %MethodDeclaration* %t83, 1
  %t85 = insertvalue %MethodParseResult %t84, i1 0, 2
  ret %MethodParseResult %t85
merge7:
  %t86 = load %Token, %Token* %l4
  %t87 = call i8* @identifier_text(%Token %t86)
  store i8* %t87, i8** %l5
  %t88 = load %Token, %Token* %l4
  %t89 = alloca [1 x %Token]
  %t90 = getelementptr [1 x %Token], [1 x %Token]* %t89, i32 0, i32 0
  %t91 = getelementptr %Token, %Token* %t90, i64 0
  store %Token %t88, %Token* %t91
  %t92 = alloca { %Token*, i64 }
  %t93 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t92, i32 0, i32 0
  store %Token* %t90, %Token** %t93
  %t94 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t92, i32 0, i32 1
  store i64 1, i64* %t94
  %t95 = call double @source_span_from_tokens({ %Token*, i64 }* %t92)
  store double %t95, double* %l6
  %t96 = load %Parser, %Parser* %l0
  %t97 = call %Parser @parser_advance_raw(%Parser %t96)
  store %Parser %t97, %Parser* %l0
  %t98 = load %Parser, %Parser* %l0
  %t99 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %t98)
  store %TypeParameterParseResult %t99, %TypeParameterParseResult* %l7
  %t100 = load %TypeParameterParseResult, %TypeParameterParseResult* %l7
  %t101 = extractvalue %TypeParameterParseResult %t100, 0
  store %Parser %t101, %Parser* %l0
  %t102 = load %TypeParameterParseResult, %TypeParameterParseResult* %l7
  %t103 = extractvalue %TypeParameterParseResult %t102, 1
  store { %TypeParameter**, i64 }* %t103, { %TypeParameter**, i64 }** %l8
  %t104 = load %Parser, %Parser* %l0
  %t105 = call %Parser @skip_trivia(%Parser %t104)
  store %Parser %t105, %Parser* %l0
  %t106 = load %Parser, %Parser* %l0
  %t107 = alloca [2 x i8], align 1
  %t108 = getelementptr [2 x i8], [2 x i8]* %t107, i32 0, i32 0
  store i8 40, i8* %t108
  %t109 = getelementptr [2 x i8], [2 x i8]* %t107, i32 0, i32 1
  store i8 0, i8* %t109
  %t110 = getelementptr [2 x i8], [2 x i8]* %t107, i32 0, i32 0
  %t111 = call %Parser @consume_symbol(%Parser %t106, i8* %t110)
  store %Parser %t111, %Parser* %l0
  %t112 = load %Parser, %Parser* %l0
  %t113 = call %ParameterListParseResult @parse_parameter_list(%Parser %t112)
  store %ParameterListParseResult %t113, %ParameterListParseResult* %l9
  %t114 = load %ParameterListParseResult, %ParameterListParseResult* %l9
  %t115 = extractvalue %ParameterListParseResult %t114, 0
  store %Parser %t115, %Parser* %l0
  %t116 = load %ParameterListParseResult, %ParameterListParseResult* %l9
  %t117 = extractvalue %ParameterListParseResult %t116, 1
  store { %Parameter**, i64 }* %t117, { %Parameter**, i64 }** %l10
  %t118 = load %Parser, %Parser* %l0
  %t119 = call %Parser @skip_trivia(%Parser %t118)
  store %Parser %t119, %Parser* %l0
  store i8* null, i8** %l11
  %t120 = load %Parser, %Parser* %l0
  %t121 = call %Token @parser_peek_raw(%Parser %t120)
  store %Token %t121, %Token* %l12
  %t124 = load %Token, %Token* %l12
  %t125 = extractvalue %Token %t124, 0
  %t126 = extractvalue %TokenKind %t125, 0
  %t127 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t128 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t129 = icmp eq i32 %t126, 0
  %t130 = select i1 %t129, i8* %t128, i8* %t127
  %t131 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t132 = icmp eq i32 %t126, 1
  %t133 = select i1 %t132, i8* %t131, i8* %t130
  %t134 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t126, 2
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t126, 3
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t126, 4
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t126, 5
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t126, 6
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t126, 7
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %s152 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.152, i32 0, i32 0
  %t153 = icmp eq i8* %t151, %s152
  br label %logical_and_entry_123

logical_and_entry_123:
  br i1 %t153, label %logical_and_right_123, label %logical_and_merge_123

logical_and_right_123:
  %t154 = load %Token, %Token* %l12
  %t155 = extractvalue %Token %t154, 0
  %t156 = extractvalue %TokenKind %t155, 0
  %t157 = load %Parser, %Parser* %l0
  %t158 = call %EffectParseResult @parse_effect_list(%Parser %t157)
  store %EffectParseResult %t158, %EffectParseResult* %l13
  %t159 = load %EffectParseResult, %EffectParseResult* %l13
  %t160 = extractvalue %EffectParseResult %t159, 0
  store %Parser %t160, %Parser* %l0
  %t161 = load %EffectParseResult, %EffectParseResult* %l13
  %t162 = extractvalue %EffectParseResult %t161, 1
  store { i8**, i64 }* %t162, { i8**, i64 }** %l14
  %t163 = call double @evaluate_decorators({ %Decorator*, i64 }* %decorators)
  store double %t163, double* %l15
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t165 = load double, double* %l15
  %t166 = call double @infer_effects({ i8**, i64 }* %t164, double %t165)
  store double %t166, double* %l16
  %t167 = load %Parser, %Parser* %l0
  %t168 = call %BlockParseResult @parse_block(%Parser %t167)
  store %BlockParseResult %t168, %BlockParseResult* %l17
  %t169 = load %BlockParseResult, %BlockParseResult* %l17
  %t170 = extractvalue %BlockParseResult %t169, 0
  store %Parser %t170, %Parser* %l0
  %t171 = load %BlockParseResult, %BlockParseResult* %l17
  %t172 = extractvalue %BlockParseResult %t171, 1
  store %Block %t172, %Block* %l18
  %t173 = load i8*, i8** %l5
  %t174 = insertvalue %FunctionSignature undef, i8* %t173, 0
  %t175 = load i1, i1* %l1
  %t176 = insertvalue %FunctionSignature %t174, i1 %t175, 1
  %t177 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %l10
  %t178 = insertvalue %FunctionSignature %t176, { %Parameter**, i64 }* %t177, 2
  %t179 = load i8*, i8** %l11
  %t180 = bitcast i8* %t179 to %TypeAnnotation*
  %t181 = insertvalue %FunctionSignature %t178, %TypeAnnotation* %t180, 3
  %t182 = load double, double* %l16
  %t183 = insertvalue %FunctionSignature %t181, { i8**, i64 }* null, 4
  %t184 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l8
  %t185 = insertvalue %FunctionSignature %t183, { %TypeParameter**, i64 }* %t184, 5
  %t186 = load double, double* %l6
  %t187 = insertvalue %FunctionSignature %t185, %SourceSpan* null, 6
  store %FunctionSignature %t187, %FunctionSignature* %l19
  %t188 = load %FunctionSignature, %FunctionSignature* %l19
  %t189 = insertvalue %MethodDeclaration undef, %FunctionSignature %t188, 0
  %t190 = load %Block, %Block* %l18
  %t191 = insertvalue %MethodDeclaration %t189, %Block %t190, 1
  %t192 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t193 = insertvalue %MethodDeclaration %t191, { %Decorator**, i64 }* %t192, 2
  store %MethodDeclaration %t193, %MethodDeclaration* %l20
  %t194 = load %Parser, %Parser* %l0
  %t195 = insertvalue %MethodParseResult undef, %Parser %t194, 0
  %t196 = load %MethodDeclaration, %MethodDeclaration* %l20
  %t197 = insertvalue %MethodParseResult %t195, %MethodDeclaration* null, 1
  %t198 = insertvalue %MethodParseResult %t197, i1 1, 2
  ret %MethodParseResult %t198
}

define %DecoratorParseResult @parse_decorators(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca { %Decorator*, i64 }*
  %l2 = alloca %Token
  %l3 = alloca %Parser
  %l4 = alloca %Token
  %l5 = alloca i8*
  %l6 = alloca { %DecoratorArgument*, i64 }*
  %l7 = alloca %Token
  store %Parser %parser, %Parser* %l0
  %t0 = alloca [0 x %Decorator]
  %t1 = getelementptr [0 x %Decorator], [0 x %Decorator]* %t0, i32 0, i32 0
  %t2 = alloca { %Decorator*, i64 }
  %t3 = getelementptr { %Decorator*, i64 }, { %Decorator*, i64 }* %t2, i32 0, i32 0
  store %Decorator* %t1, %Decorator** %t3
  %t4 = getelementptr { %Decorator*, i64 }, { %Decorator*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Decorator*, i64 }* %t2, { %Decorator*, i64 }** %l1
  %t5 = load %Parser, %Parser* %l0
  %t6 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t144 = phi %Parser [ %t5, %entry ], [ %t142, %loop.latch2 ]
  %t145 = phi { %Decorator*, i64 }* [ %t6, %entry ], [ %t143, %loop.latch2 ]
  store %Parser %t144, %Parser* %l0
  store { %Decorator*, i64 }* %t145, { %Decorator*, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t7 = load %Parser, %Parser* %l0
  %t8 = call %Parser @skip_trivia(%Parser %t7)
  store %Parser %t8, %Parser* %l0
  %t9 = load %Parser, %Parser* %l0
  %t10 = call %Token @parser_peek_raw(%Parser %t9)
  store %Token %t10, %Token* %l2
  %t12 = load %Token, %Token* %l2
  %t13 = extractvalue %Token %t12, 0
  %t14 = extractvalue %TokenKind %t13, 0
  %t15 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t16 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t17 = icmp eq i32 %t14, 0
  %t18 = select i1 %t17, i8* %t16, i8* %t15
  %t19 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t20 = icmp eq i32 %t14, 1
  %t21 = select i1 %t20, i8* %t19, i8* %t18
  %t22 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t23 = icmp eq i32 %t14, 2
  %t24 = select i1 %t23, i8* %t22, i8* %t21
  %t25 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t14, 3
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t14, 4
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %t31 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t32 = icmp eq i32 %t14, 5
  %t33 = select i1 %t32, i8* %t31, i8* %t30
  %t34 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t14, 6
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %t37 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t14, 7
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %s40 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.40, i32 0, i32 0
  %t41 = icmp ne i8* %t39, %s40
  br label %logical_or_entry_11

logical_or_entry_11:
  br i1 %t41, label %logical_or_merge_11, label %logical_or_right_11

logical_or_right_11:
  %t42 = load %Token, %Token* %l2
  %t43 = extractvalue %Token %t42, 0
  %t44 = extractvalue %TokenKind %t43, 0
  %t45 = load %Parser, %Parser* %l0
  store %Parser %t45, %Parser* %l3
  %t46 = load %Parser, %Parser* %l0
  %t47 = call %Parser @parser_advance_raw(%Parser %t46)
  store %Parser %t47, %Parser* %l0
  %t48 = load %Parser, %Parser* %l0
  %t49 = call %Parser @skip_trivia(%Parser %t48)
  store %Parser %t49, %Parser* %l0
  %t50 = load %Parser, %Parser* %l0
  %t51 = call %Token @parser_peek_raw(%Parser %t50)
  store %Token %t51, %Token* %l4
  %t52 = load %Token, %Token* %l4
  %t53 = extractvalue %Token %t52, 0
  %t54 = extractvalue %TokenKind %t53, 0
  %t55 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t56 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t57 = icmp eq i32 %t54, 0
  %t58 = select i1 %t57, i8* %t56, i8* %t55
  %t59 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t60 = icmp eq i32 %t54, 1
  %t61 = select i1 %t60, i8* %t59, i8* %t58
  %t62 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t54, 2
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t54, 3
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t54, 4
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t54, 5
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t75 = icmp eq i32 %t54, 6
  %t76 = select i1 %t75, i8* %t74, i8* %t73
  %t77 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t78 = icmp eq i32 %t54, 7
  %t79 = select i1 %t78, i8* %t77, i8* %t76
  %s80 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.80, i32 0, i32 0
  %t81 = icmp ne i8* %t79, %s80
  %t82 = load %Parser, %Parser* %l0
  %t83 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l1
  %t84 = load %Token, %Token* %l2
  %t85 = load %Parser, %Parser* %l3
  %t86 = load %Token, %Token* %l4
  br i1 %t81, label %then4, label %merge5
then4:
  %t87 = load %Parser, %Parser* %l3
  store %Parser %t87, %Parser* %l0
  br label %afterloop3
merge5:
  %t88 = load %Token, %Token* %l4
  %t89 = call i8* @identifier_text(%Token %t88)
  store i8* %t89, i8** %l5
  %t90 = load %Parser, %Parser* %l0
  %t91 = call %Parser @parser_advance_raw(%Parser %t90)
  store %Parser %t91, %Parser* %l0
  %t92 = load %Parser, %Parser* %l0
  %t93 = call %Parser @skip_trivia(%Parser %t92)
  store %Parser %t93, %Parser* %l0
  %t94 = alloca [0 x %DecoratorArgument]
  %t95 = getelementptr [0 x %DecoratorArgument], [0 x %DecoratorArgument]* %t94, i32 0, i32 0
  %t96 = alloca { %DecoratorArgument*, i64 }
  %t97 = getelementptr { %DecoratorArgument*, i64 }, { %DecoratorArgument*, i64 }* %t96, i32 0, i32 0
  store %DecoratorArgument* %t95, %DecoratorArgument** %t97
  %t98 = getelementptr { %DecoratorArgument*, i64 }, { %DecoratorArgument*, i64 }* %t96, i32 0, i32 1
  store i64 0, i64* %t98
  store { %DecoratorArgument*, i64 }* %t96, { %DecoratorArgument*, i64 }** %l6
  %t99 = load %Parser, %Parser* %l0
  %t100 = call %Token @parser_peek_raw(%Parser %t99)
  store %Token %t100, %Token* %l7
  %t102 = load %Token, %Token* %l7
  %t103 = extractvalue %Token %t102, 0
  %t104 = extractvalue %TokenKind %t103, 0
  %t105 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t106 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t107 = icmp eq i32 %t104, 0
  %t108 = select i1 %t107, i8* %t106, i8* %t105
  %t109 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t110 = icmp eq i32 %t104, 1
  %t111 = select i1 %t110, i8* %t109, i8* %t108
  %t112 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t113 = icmp eq i32 %t104, 2
  %t114 = select i1 %t113, i8* %t112, i8* %t111
  %t115 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t116 = icmp eq i32 %t104, 3
  %t117 = select i1 %t116, i8* %t115, i8* %t114
  %t118 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t119 = icmp eq i32 %t104, 4
  %t120 = select i1 %t119, i8* %t118, i8* %t117
  %t121 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t122 = icmp eq i32 %t104, 5
  %t123 = select i1 %t122, i8* %t121, i8* %t120
  %t124 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t125 = icmp eq i32 %t104, 6
  %t126 = select i1 %t125, i8* %t124, i8* %t123
  %t127 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t128 = icmp eq i32 %t104, 7
  %t129 = select i1 %t128, i8* %t127, i8* %t126
  %s130 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.130, i32 0, i32 0
  %t131 = icmp eq i8* %t129, %s130
  br label %logical_and_entry_101

logical_and_entry_101:
  br i1 %t131, label %logical_and_right_101, label %logical_and_merge_101

logical_and_right_101:
  %t132 = load %Token, %Token* %l7
  %t133 = extractvalue %Token %t132, 0
  %t134 = extractvalue %TokenKind %t133, 0
  %t135 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l1
  %t136 = load i8*, i8** %l5
  %t137 = insertvalue %Decorator undef, i8* %t136, 0
  %t138 = load { %DecoratorArgument*, i64 }*, { %DecoratorArgument*, i64 }** %l6
  %t139 = bitcast { %DecoratorArgument*, i64 }* %t138 to { %DecoratorArgument**, i64 }*
  %t140 = insertvalue %Decorator %t137, { %DecoratorArgument**, i64 }* %t139, 1
  %t141 = call { %Decorator*, i64 }* @append_decorator({ %Decorator*, i64 }* %t135, %Decorator %t140)
  store { %Decorator*, i64 }* %t141, { %Decorator*, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t142 = load %Parser, %Parser* %l0
  %t143 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t146 = load %Parser, %Parser* %l0
  %t147 = insertvalue %DecoratorParseResult undef, %Parser %t146, 0
  %t148 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l1
  %t149 = bitcast { %Decorator*, i64 }* %t148 to { %Decorator**, i64 }*
  %t150 = insertvalue %DecoratorParseResult %t147, { %Decorator**, i64 }* %t149, 1
  ret %DecoratorParseResult %t150
}

define %TypeParameterParseResult @parse_type_parameter_clause(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  %l2 = alloca { %Token*, i64 }*
  %l3 = alloca double
  %l4 = alloca %Token
  %l5 = alloca double
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca { %TypeParameter*, i64 }*
  %l8 = alloca double
  %l9 = alloca { %Token*, i64 }*
  %l10 = alloca double
  %l11 = alloca { %Token*, i64 }*
  %l12 = alloca { %Token*, i64 }*
  %l13 = alloca i8*
  %l14 = alloca i8*
  %l15 = alloca i8*
  %l16 = alloca double
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Token @parser_peek_raw(%Parser %t1)
  store %Token %t2, %Token* %l1
  %t4 = load %Token, %Token* %l1
  %t5 = extractvalue %Token %t4, 0
  %t6 = extractvalue %TokenKind %t5, 0
  %t7 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t8 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t9 = icmp eq i32 %t6, 0
  %t10 = select i1 %t9, i8* %t8, i8* %t7
  %t11 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t12 = icmp eq i32 %t6, 1
  %t13 = select i1 %t12, i8* %t11, i8* %t10
  %t14 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t15 = icmp eq i32 %t6, 2
  %t16 = select i1 %t15, i8* %t14, i8* %t13
  %t17 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t6, 3
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t6, 4
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t6, 5
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t6, 6
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t6, 7
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %s32 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.32, i32 0, i32 0
  %t33 = icmp ne i8* %t31, %s32
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t33, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %t34 = load %Token, %Token* %l1
  %t35 = extractvalue %Token %t34, 0
  %t36 = extractvalue %TokenKind %t35, 0
  %t37 = load %Parser, %Parser* %l0
  %t38 = call %Parser @parser_advance_raw(%Parser %t37)
  store %Parser %t38, %Parser* %l0
  %t39 = alloca [0 x %Token]
  %t40 = getelementptr [0 x %Token], [0 x %Token]* %t39, i32 0, i32 0
  %t41 = alloca { %Token*, i64 }
  %t42 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t41, i32 0, i32 0
  store %Token* %t40, %Token** %t42
  %t43 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t41, i32 0, i32 1
  store i64 0, i64* %t43
  store { %Token*, i64 }* %t41, { %Token*, i64 }** %l2
  %t44 = sitofp i64 1 to double
  store double %t44, double* %l3
  %t45 = load %Parser, %Parser* %l0
  %t46 = load %Token, %Token* %l1
  %t47 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t48 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t132 = phi { %Token*, i64 }* [ %t47, %entry ], [ %t130, %loop.latch2 ]
  %t133 = phi %Parser [ %t45, %entry ], [ %t131, %loop.latch2 ]
  store { %Token*, i64 }* %t132, { %Token*, i64 }** %l2
  store %Parser %t133, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t49 = load %Parser, %Parser* %l0
  %t50 = call %Token @parser_peek_raw(%Parser %t49)
  store %Token %t50, %Token* %l4
  %t51 = load %Token, %Token* %l4
  %t52 = extractvalue %Token %t51, 0
  %t53 = extractvalue %TokenKind %t52, 0
  %t54 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t55 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t53, 0
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t53, 1
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t53, 2
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t53, 3
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t53, 4
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t53, 5
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t53, 6
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %t76 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t53, 7
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %s79 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.79, i32 0, i32 0
  %t80 = icmp eq i8* %t78, %s79
  %t81 = load %Parser, %Parser* %l0
  %t82 = load %Token, %Token* %l1
  %t83 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t84 = load double, double* %l3
  %t85 = load %Token, %Token* %l4
  br i1 %t80, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t86 = load %Token, %Token* %l4
  %t87 = extractvalue %Token %t86, 0
  %t88 = extractvalue %TokenKind %t87, 0
  %t89 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t90 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t91 = icmp eq i32 %t88, 0
  %t92 = select i1 %t91, i8* %t90, i8* %t89
  %t93 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t88, 1
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %t96 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t97 = icmp eq i32 %t88, 2
  %t98 = select i1 %t97, i8* %t96, i8* %t95
  %t99 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t88, 3
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t88, 4
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t106 = icmp eq i32 %t88, 5
  %t107 = select i1 %t106, i8* %t105, i8* %t104
  %t108 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t88, 6
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t112 = icmp eq i32 %t88, 7
  %t113 = select i1 %t112, i8* %t111, i8* %t110
  %s114 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.114, i32 0, i32 0
  %t115 = icmp eq i8* %t113, %s114
  %t116 = load %Parser, %Parser* %l0
  %t117 = load %Token, %Token* %l1
  %t118 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t119 = load double, double* %l3
  %t120 = load %Token, %Token* %l4
  br i1 %t115, label %then6, label %merge7
then6:
  %t121 = load %Token, %Token* %l4
  %t122 = extractvalue %Token %t121, 0
  %t123 = extractvalue %TokenKind %t122, 0
  store double 0.0, double* %l5
  %t124 = load double, double* %l5
  br label %merge7
merge7:
  %t125 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t126 = load %Token, %Token* %l4
  %t127 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t125, %Token %t126)
  store { %Token*, i64 }* %t127, { %Token*, i64 }** %l2
  %t128 = load %Parser, %Parser* %l0
  %t129 = call %Parser @parser_advance_raw(%Parser %t128)
  store %Parser %t129, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t130 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t131 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t134 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t135 = call { i8**, i64 }* @split_token_slices_by_comma({ %Token*, i64 }* %t134)
  store { i8**, i64 }* %t135, { i8**, i64 }** %l6
  %t136 = alloca [0 x %TypeParameter]
  %t137 = getelementptr [0 x %TypeParameter], [0 x %TypeParameter]* %t136, i32 0, i32 0
  %t138 = alloca { %TypeParameter*, i64 }
  %t139 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %t138, i32 0, i32 0
  store %TypeParameter* %t137, %TypeParameter** %t139
  %t140 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %t138, i32 0, i32 1
  store i64 0, i64* %t140
  store { %TypeParameter*, i64 }* %t138, { %TypeParameter*, i64 }** %l7
  %t141 = sitofp i64 0 to double
  store double %t141, double* %l8
  %t142 = load %Parser, %Parser* %l0
  %t143 = load %Token, %Token* %l1
  %t144 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t145 = load double, double* %l3
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t147 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l7
  %t148 = load double, double* %l8
  br label %loop.header8
loop.header8:
  %t290 = phi { %TypeParameter*, i64 }* [ %t147, %entry ], [ %t288, %loop.latch10 ]
  %t291 = phi double [ %t148, %entry ], [ %t289, %loop.latch10 ]
  store { %TypeParameter*, i64 }* %t290, { %TypeParameter*, i64 }** %l7
  store double %t291, double* %l8
  br label %loop.body9
loop.body9:
  %t149 = load double, double* %l8
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t151 = load { i8**, i64 }, { i8**, i64 }* %t150
  %t152 = extractvalue { i8**, i64 } %t151, 1
  %t153 = sitofp i64 %t152 to double
  %t154 = fcmp oge double %t149, %t153
  %t155 = load %Parser, %Parser* %l0
  %t156 = load %Token, %Token* %l1
  %t157 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t158 = load double, double* %l3
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t160 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l7
  %t161 = load double, double* %l8
  br i1 %t154, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t163 = load double, double* %l8
  %t164 = fptosi double %t163 to i64
  %t165 = load { i8**, i64 }, { i8**, i64 }* %t162
  %t166 = extractvalue { i8**, i64 } %t165, 0
  %t167 = extractvalue { i8**, i64 } %t165, 1
  %t168 = icmp uge i64 %t164, %t167
  ; bounds check: %t168 (if true, out of bounds)
  %t169 = getelementptr i8*, i8** %t166, i64 %t164
  %t170 = load i8*, i8** %t169
  %t171 = bitcast i8* %t170 to { %Token*, i64 }*
  %t172 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t171)
  store { %Token*, i64 }* %t172, { %Token*, i64 }** %l9
  %t173 = load { %Token*, i64 }*, { %Token*, i64 }** %l9
  %t174 = load { %Token*, i64 }, { %Token*, i64 }* %t173
  %t175 = extractvalue { %Token*, i64 } %t174, 1
  %t176 = icmp sgt i64 %t175, 0
  %t177 = load %Parser, %Parser* %l0
  %t178 = load %Token, %Token* %l1
  %t179 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t180 = load double, double* %l3
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t182 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l7
  %t183 = load double, double* %l8
  %t184 = load { %Token*, i64 }*, { %Token*, i64 }** %l9
  br i1 %t176, label %then14, label %merge15
then14:
  %t185 = load { %Token*, i64 }*, { %Token*, i64 }** %l9
  %t186 = alloca [2 x i8], align 1
  %t187 = getelementptr [2 x i8], [2 x i8]* %t186, i32 0, i32 0
  store i8 58, i8* %t187
  %t188 = getelementptr [2 x i8], [2 x i8]* %t186, i32 0, i32 1
  store i8 0, i8* %t188
  %t189 = getelementptr [2 x i8], [2 x i8]* %t186, i32 0, i32 0
  %t190 = call double @find_top_level_symbol({ %Token*, i64 }* %t185, i8* %t189)
  store double %t190, double* %l10
  %t191 = load { %Token*, i64 }*, { %Token*, i64 }** %l9
  store { %Token*, i64 }* %t191, { %Token*, i64 }** %l11
  %t192 = alloca [0 x %Token]
  %t193 = getelementptr [0 x %Token], [0 x %Token]* %t192, i32 0, i32 0
  %t194 = alloca { %Token*, i64 }
  %t195 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t194, i32 0, i32 0
  store %Token* %t193, %Token** %t195
  %t196 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t194, i32 0, i32 1
  store i64 0, i64* %t196
  store { %Token*, i64 }* %t194, { %Token*, i64 }** %l12
  %t197 = load double, double* %l10
  %t198 = sitofp i64 -1 to double
  %t199 = fcmp une double %t197, %t198
  %t200 = load %Parser, %Parser* %l0
  %t201 = load %Token, %Token* %l1
  %t202 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t203 = load double, double* %l3
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t205 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l7
  %t206 = load double, double* %l8
  %t207 = load { %Token*, i64 }*, { %Token*, i64 }** %l9
  %t208 = load double, double* %l10
  %t209 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t210 = load { %Token*, i64 }*, { %Token*, i64 }** %l12
  br i1 %t199, label %then16, label %merge17
then16:
  %t211 = load { %Token*, i64 }*, { %Token*, i64 }** %l9
  %t212 = load double, double* %l10
  %t213 = sitofp i64 0 to double
  %t214 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t211, double %t213, double %t212)
  store { %Token*, i64 }* %t214, { %Token*, i64 }** %l11
  %t215 = load { %Token*, i64 }*, { %Token*, i64 }** %l9
  %t216 = load double, double* %l10
  %t217 = sitofp i64 1 to double
  %t218 = fadd double %t216, %t217
  %t219 = load { %Token*, i64 }*, { %Token*, i64 }** %l9
  %t220 = load { %Token*, i64 }, { %Token*, i64 }* %t219
  %t221 = extractvalue { %Token*, i64 } %t220, 1
  %t222 = sitofp i64 %t221 to double
  %t223 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t215, double %t218, double %t222)
  store { %Token*, i64 }* %t223, { %Token*, i64 }** %l12
  br label %merge17
merge17:
  %t224 = phi { %Token*, i64 }* [ %t214, %then16 ], [ %t209, %then14 ]
  %t225 = phi { %Token*, i64 }* [ %t223, %then16 ], [ %t210, %then14 ]
  store { %Token*, i64 }* %t224, { %Token*, i64 }** %l11
  store { %Token*, i64 }* %t225, { %Token*, i64 }** %l12
  %t226 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t227 = call i8* @tokens_to_text({ %Token*, i64 }* %t226)
  %t228 = call i8* @trim_text(i8* %t227)
  store i8* %t228, i8** %l13
  %t229 = load i8*, i8** %l13
  %t230 = call i64 @sailfin_runtime_string_length(i8* %t229)
  %t231 = icmp sgt i64 %t230, 0
  %t232 = load %Parser, %Parser* %l0
  %t233 = load %Token, %Token* %l1
  %t234 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t235 = load double, double* %l3
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t237 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l7
  %t238 = load double, double* %l8
  %t239 = load { %Token*, i64 }*, { %Token*, i64 }** %l9
  %t240 = load double, double* %l10
  %t241 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t242 = load { %Token*, i64 }*, { %Token*, i64 }** %l12
  %t243 = load i8*, i8** %l13
  br i1 %t231, label %then18, label %merge19
then18:
  store i8* null, i8** %l14
  %t244 = load { %Token*, i64 }*, { %Token*, i64 }** %l12
  %t245 = call i8* @tokens_to_text({ %Token*, i64 }* %t244)
  %t246 = call i8* @trim_text(i8* %t245)
  store i8* %t246, i8** %l15
  %t248 = load { %Token*, i64 }*, { %Token*, i64 }** %l12
  %t249 = load { %Token*, i64 }, { %Token*, i64 }* %t248
  %t250 = extractvalue { %Token*, i64 } %t249, 1
  %t251 = icmp sgt i64 %t250, 0
  br label %logical_and_entry_247

logical_and_entry_247:
  br i1 %t251, label %logical_and_right_247, label %logical_and_merge_247

logical_and_right_247:
  %t252 = load i8*, i8** %l15
  %t253 = call i64 @sailfin_runtime_string_length(i8* %t252)
  %t254 = icmp sgt i64 %t253, 0
  br label %logical_and_right_end_247

logical_and_right_end_247:
  br label %logical_and_merge_247

logical_and_merge_247:
  %t255 = phi i1 [ false, %logical_and_entry_247 ], [ %t254, %logical_and_right_end_247 ]
  %t256 = load %Parser, %Parser* %l0
  %t257 = load %Token, %Token* %l1
  %t258 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t259 = load double, double* %l3
  %t260 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t261 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l7
  %t262 = load double, double* %l8
  %t263 = load { %Token*, i64 }*, { %Token*, i64 }** %l9
  %t264 = load double, double* %l10
  %t265 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t266 = load { %Token*, i64 }*, { %Token*, i64 }** %l12
  %t267 = load i8*, i8** %l13
  %t268 = load i8*, i8** %l14
  %t269 = load i8*, i8** %l15
  br i1 %t255, label %then20, label %merge21
then20:
  %t270 = load i8*, i8** %l15
  %t271 = insertvalue %TypeAnnotation undef, i8* %t270, 0
  store i8* null, i8** %l14
  br label %merge21
merge21:
  %t272 = phi i8* [ null, %then20 ], [ %t268, %then18 ]
  store i8* %t272, i8** %l14
  %t273 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t274 = call double @source_span_from_tokens({ %Token*, i64 }* %t273)
  store double %t274, double* %l16
  %t275 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l7
  %t276 = load i8*, i8** %l13
  %t277 = insertvalue %TypeParameter undef, i8* %t276, 0
  %t278 = load i8*, i8** %l14
  %t279 = bitcast i8* %t278 to %TypeAnnotation*
  %t280 = insertvalue %TypeParameter %t277, %TypeAnnotation* %t279, 1
  %t281 = load double, double* %l16
  %t282 = insertvalue %TypeParameter %t280, %SourceSpan* null, 2
  br label %merge19
merge19:
  %t283 = phi { %TypeParameter*, i64 }* [ null, %then18 ], [ %t237, %then14 ]
  store { %TypeParameter*, i64 }* %t283, { %TypeParameter*, i64 }** %l7
  br label %merge15
merge15:
  %t284 = phi { %TypeParameter*, i64 }* [ null, %then14 ], [ %t182, %loop.body9 ]
  store { %TypeParameter*, i64 }* %t284, { %TypeParameter*, i64 }** %l7
  %t285 = load double, double* %l8
  %t286 = sitofp i64 1 to double
  %t287 = fadd double %t285, %t286
  store double %t287, double* %l8
  br label %loop.latch10
loop.latch10:
  %t288 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l7
  %t289 = load double, double* %l8
  br label %loop.header8
afterloop11:
  %t292 = load %Parser, %Parser* %l0
  %t293 = insertvalue %TypeParameterParseResult undef, %Parser %t292, 0
  %t294 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l7
  %t295 = bitcast { %TypeParameter*, i64 }* %t294 to { %TypeParameter**, i64 }*
  %t296 = insertvalue %TypeParameterParseResult %t293, { %TypeParameter**, i64 }* %t295, 1
  ret %TypeParameterParseResult %t296
}

define %ImplementsParseResult @parse_implements_clause(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %CaptureResult
  %l2 = alloca { %TypeAnnotation*, i64 }*
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca i8*
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Token @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(%Token %t2, i8* %s3)
  %t5 = xor i1 %t4, 1
  %t6 = load %Parser, %Parser* %l0
  br i1 %t5, label %then0, label %merge1
then0:
  %t7 = insertvalue %ImplementsParseResult undef, %Parser %parser, 0
  %t8 = alloca [0 x %TypeAnnotation*]
  %t9 = getelementptr [0 x %TypeAnnotation*], [0 x %TypeAnnotation*]* %t8, i32 0, i32 0
  %t10 = alloca { %TypeAnnotation**, i64 }
  %t11 = getelementptr { %TypeAnnotation**, i64 }, { %TypeAnnotation**, i64 }* %t10, i32 0, i32 0
  store %TypeAnnotation** %t9, %TypeAnnotation*** %t11
  %t12 = getelementptr { %TypeAnnotation**, i64 }, { %TypeAnnotation**, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  %t13 = insertvalue %ImplementsParseResult %t7, { %TypeAnnotation**, i64 }* %t10, 1
  %t14 = insertvalue %ImplementsParseResult %t13, i1 0, 2
  ret %ImplementsParseResult %t14
merge1:
  %t15 = load %Parser, %Parser* %l0
  %s16 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.16, i32 0, i32 0
  %t17 = call %Parser @consume_keyword(%Parser %t15, i8* %s16)
  store %Parser %t17, %Parser* %l0
  %t18 = load %Parser, %Parser* %l0
  %t19 = call %Parser @skip_trivia(%Parser %t18)
  store %Parser %t19, %Parser* %l0
  %t20 = load %Parser, %Parser* %l0
  %t21 = alloca [1 x i8]
  %t22 = getelementptr [1 x i8], [1 x i8]* %t21, i32 0, i32 0
  %t23 = getelementptr i8, i8* %t22, i64 0
  store i8 123, i8* %t23
  %t24 = alloca { i8*, i64 }
  %t25 = getelementptr { i8*, i64 }, { i8*, i64 }* %t24, i32 0, i32 0
  store i8* %t22, i8** %t25
  %t26 = getelementptr { i8*, i64 }, { i8*, i64 }* %t24, i32 0, i32 1
  store i64 1, i64* %t26
  %t27 = bitcast { i8*, i64 }* %t24 to { i8**, i64 }*
  %t28 = call %CaptureResult @collect_until(%Parser %t20, { i8**, i64 }* %t27)
  store %CaptureResult %t28, %CaptureResult* %l1
  %t29 = load %CaptureResult, %CaptureResult* %l1
  %t30 = extractvalue %CaptureResult %t29, 0
  store %Parser %t30, %Parser* %l0
  %t31 = alloca [0 x %TypeAnnotation]
  %t32 = getelementptr [0 x %TypeAnnotation], [0 x %TypeAnnotation]* %t31, i32 0, i32 0
  %t33 = alloca { %TypeAnnotation*, i64 }
  %t34 = getelementptr { %TypeAnnotation*, i64 }, { %TypeAnnotation*, i64 }* %t33, i32 0, i32 0
  store %TypeAnnotation* %t32, %TypeAnnotation** %t34
  %t35 = getelementptr { %TypeAnnotation*, i64 }, { %TypeAnnotation*, i64 }* %t33, i32 0, i32 1
  store i64 0, i64* %t35
  store { %TypeAnnotation*, i64 }* %t33, { %TypeAnnotation*, i64 }** %l2
  %t36 = load %CaptureResult, %CaptureResult* %l1
  %t37 = extractvalue %CaptureResult %t36, 1
  %t38 = bitcast { %Token**, i64 }* %t37 to { %Token*, i64 }*
  %t39 = call { i8**, i64 }* @split_tokens_by_comma({ %Token*, i64 }* %t38)
  store { i8**, i64 }* %t39, { i8**, i64 }** %l3
  %t40 = sitofp i64 0 to double
  store double %t40, double* %l4
  %t41 = load %Parser, %Parser* %l0
  %t42 = load %CaptureResult, %CaptureResult* %l1
  %t43 = load { %TypeAnnotation*, i64 }*, { %TypeAnnotation*, i64 }** %l2
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t45 = load double, double* %l4
  br label %loop.header2
loop.header2:
  %t86 = phi { %TypeAnnotation*, i64 }* [ %t43, %entry ], [ %t84, %loop.latch4 ]
  %t87 = phi double [ %t45, %entry ], [ %t85, %loop.latch4 ]
  store { %TypeAnnotation*, i64 }* %t86, { %TypeAnnotation*, i64 }** %l2
  store double %t87, double* %l4
  br label %loop.body3
loop.body3:
  %t46 = load double, double* %l4
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t48 = load { i8**, i64 }, { i8**, i64 }* %t47
  %t49 = extractvalue { i8**, i64 } %t48, 1
  %t50 = sitofp i64 %t49 to double
  %t51 = fcmp oge double %t46, %t50
  %t52 = load %Parser, %Parser* %l0
  %t53 = load %CaptureResult, %CaptureResult* %l1
  %t54 = load { %TypeAnnotation*, i64 }*, { %TypeAnnotation*, i64 }** %l2
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t56 = load double, double* %l4
  br i1 %t51, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t58 = load double, double* %l4
  %t59 = fptosi double %t58 to i64
  %t60 = load { i8**, i64 }, { i8**, i64 }* %t57
  %t61 = extractvalue { i8**, i64 } %t60, 0
  %t62 = extractvalue { i8**, i64 } %t60, 1
  %t63 = icmp uge i64 %t59, %t62
  ; bounds check: %t63 (if true, out of bounds)
  %t64 = getelementptr i8*, i8** %t61, i64 %t59
  %t65 = load i8*, i8** %t64
  %t66 = call i8* @trim_text(i8* %t65)
  store i8* %t66, i8** %l5
  %t67 = load i8*, i8** %l5
  %t68 = call i64 @sailfin_runtime_string_length(i8* %t67)
  %t69 = icmp sgt i64 %t68, 0
  %t70 = load %Parser, %Parser* %l0
  %t71 = load %CaptureResult, %CaptureResult* %l1
  %t72 = load { %TypeAnnotation*, i64 }*, { %TypeAnnotation*, i64 }** %l2
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t74 = load double, double* %l4
  %t75 = load i8*, i8** %l5
  br i1 %t69, label %then8, label %merge9
then8:
  %t76 = load { %TypeAnnotation*, i64 }*, { %TypeAnnotation*, i64 }** %l2
  %t77 = load i8*, i8** %l5
  %t78 = insertvalue %TypeAnnotation undef, i8* %t77, 0
  %t79 = call { %TypeAnnotation*, i64 }* @append_type_annotation({ %TypeAnnotation*, i64 }* %t76, %TypeAnnotation %t78)
  store { %TypeAnnotation*, i64 }* %t79, { %TypeAnnotation*, i64 }** %l2
  br label %merge9
merge9:
  %t80 = phi { %TypeAnnotation*, i64 }* [ %t79, %then8 ], [ %t72, %loop.body3 ]
  store { %TypeAnnotation*, i64 }* %t80, { %TypeAnnotation*, i64 }** %l2
  %t81 = load double, double* %l4
  %t82 = sitofp i64 1 to double
  %t83 = fadd double %t81, %t82
  store double %t83, double* %l4
  br label %loop.latch4
loop.latch4:
  %t84 = load { %TypeAnnotation*, i64 }*, { %TypeAnnotation*, i64 }** %l2
  %t85 = load double, double* %l4
  br label %loop.header2
afterloop5:
  %t88 = load %Parser, %Parser* %l0
  %t89 = insertvalue %ImplementsParseResult undef, %Parser %t88, 0
  %t90 = load { %TypeAnnotation*, i64 }*, { %TypeAnnotation*, i64 }** %l2
  %t91 = bitcast { %TypeAnnotation*, i64 }* %t90 to { %TypeAnnotation**, i64 }*
  %t92 = insertvalue %ImplementsParseResult %t89, { %TypeAnnotation**, i64 }* %t91, 1
  %t93 = insertvalue %ImplementsParseResult %t92, i1 1, 2
  ret %ImplementsParseResult %t93
}

define %ParameterParseResult @parse_single_parameter(%Parser %initial_parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca { %Token**, i64 }*
  %l2 = alloca double
  %l3 = alloca i1
  %l4 = alloca %Token
  %l5 = alloca %Token
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca %Token
  %l9 = alloca i8*
  %l10 = alloca %Token
  %l11 = alloca double
  %l12 = alloca { %Token*, i64 }*
  %l13 = alloca double
  %l14 = alloca %Parameter
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  %t1 = call %Parser @skip_trivia(%Parser %t0)
  store %Parser %t1, %Parser* %l0
  %t2 = load %Parser, %Parser* %l0
  %t3 = extractvalue %Parser %t2, 0
  store { %Token**, i64 }* %t3, { %Token**, i64 }** %l1
  %t4 = load %Parser, %Parser* %l0
  %t5 = extractvalue %Parser %t4, 1
  store double %t5, double* %l2
  store i1 0, i1* %l3
  %t6 = load %Parser, %Parser* %l0
  %t7 = call %Token @parser_peek_raw(%Parser %t6)
  store %Token %t7, %Token* %l4
  %t8 = load %Token, %Token* %l4
  %s9 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.9, i32 0, i32 0
  %t10 = call i1 @identifier_matches(%Token %t8, i8* %s9)
  %t11 = load %Parser, %Parser* %l0
  %t12 = load { %Token**, i64 }*, { %Token**, i64 }** %l1
  %t13 = load double, double* %l2
  %t14 = load i1, i1* %l3
  %t15 = load %Token, %Token* %l4
  br i1 %t10, label %then0, label %merge1
then0:
  %t16 = load %Parser, %Parser* %l0
  %t17 = call %Parser @parser_advance_raw(%Parser %t16)
  store %Parser %t17, %Parser* %l0
  store i1 1, i1* %l3
  br label %merge1
merge1:
  %t18 = phi %Parser [ %t17, %then0 ], [ %t11, %entry ]
  %t19 = phi i1 [ 1, %then0 ], [ %t14, %entry ]
  store %Parser %t18, %Parser* %l0
  store i1 %t19, i1* %l3
  %t20 = load %Parser, %Parser* %l0
  %t21 = call %Parser @skip_trivia(%Parser %t20)
  store %Parser %t21, %Parser* %l0
  %t22 = load %Parser, %Parser* %l0
  %t23 = call %Token @parser_peek_raw(%Parser %t22)
  store %Token %t23, %Token* %l5
  %t24 = load %Token, %Token* %l5
  %t25 = call i8* @identifier_text(%Token %t24)
  store i8* %t25, i8** %l6
  %t26 = load %Parser, %Parser* %l0
  %t27 = call %Parser @parser_advance_raw(%Parser %t26)
  store %Parser %t27, %Parser* %l0
  store i8* null, i8** %l7
  %t28 = load %Parser, %Parser* %l0
  %t29 = call %Parser @skip_trivia(%Parser %t28)
  store %Parser %t29, %Parser* %l0
  %t30 = load %Parser, %Parser* %l0
  %t31 = call %Token @parser_peek_raw(%Parser %t30)
  store %Token %t31, %Token* %l8
  %t34 = load %Token, %Token* %l8
  %t35 = extractvalue %Token %t34, 0
  %t36 = extractvalue %TokenKind %t35, 0
  %t37 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t38 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t36, 0
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t36, 1
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t36, 2
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t36, 3
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %t50 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t36, 4
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %t53 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t54 = icmp eq i32 %t36, 5
  %t55 = select i1 %t54, i8* %t53, i8* %t52
  %t56 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t57 = icmp eq i32 %t36, 6
  %t58 = select i1 %t57, i8* %t56, i8* %t55
  %t59 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t60 = icmp eq i32 %t36, 7
  %t61 = select i1 %t60, i8* %t59, i8* %t58
  %s62 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.62, i32 0, i32 0
  %t63 = icmp eq i8* %t61, %s62
  br label %logical_and_entry_33

logical_and_entry_33:
  br i1 %t63, label %logical_and_right_33, label %logical_and_merge_33

logical_and_right_33:
  %t64 = load %Token, %Token* %l8
  %t65 = extractvalue %Token %t64, 0
  %t66 = extractvalue %TokenKind %t65, 0
  store i8* null, i8** %l9
  %t67 = load %Parser, %Parser* %l0
  %t68 = call %Parser @skip_trivia(%Parser %t67)
  store %Parser %t68, %Parser* %l0
  %t69 = load %Parser, %Parser* %l0
  %t70 = call %Token @parser_peek_raw(%Parser %t69)
  store %Token %t70, %Token* %l10
  %t72 = load %Token, %Token* %l10
  %t73 = extractvalue %Token %t72, 0
  %t74 = extractvalue %TokenKind %t73, 0
  %t75 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t76 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t74, 0
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %t79 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t74, 1
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t74, 2
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %t85 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t74, 3
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t74, 4
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t74, 5
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t74, 6
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t74, 7
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %s100 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.100, i32 0, i32 0
  %t101 = icmp eq i8* %t99, %s100
  br label %logical_and_entry_71

logical_and_entry_71:
  br i1 %t101, label %logical_and_right_71, label %logical_and_merge_71

logical_and_right_71:
  %t102 = load %Token, %Token* %l10
  %t103 = extractvalue %Token %t102, 0
  %t104 = extractvalue %TokenKind %t103, 0
  %t105 = load %Parser, %Parser* %l0
  %t106 = extractvalue %Parser %t105, 1
  store double %t106, double* %l11
  %t107 = load { %Token**, i64 }*, { %Token**, i64 }** %l1
  %t108 = load double, double* %l2
  %t109 = load double, double* %l11
  %t110 = bitcast { %Token**, i64 }* %t107 to { %Token*, i64 }*
  %t111 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t110, double %t108, double %t109)
  store { %Token*, i64 }* %t111, { %Token*, i64 }** %l12
  %t112 = load { %Token*, i64 }*, { %Token*, i64 }** %l12
  %t113 = call double @source_span_from_tokens({ %Token*, i64 }* %t112)
  store double %t113, double* %l13
  %t114 = load i8*, i8** %l6
  %t115 = insertvalue %Parameter undef, i8* %t114, 0
  %t116 = load i8*, i8** %l7
  %t117 = bitcast i8* %t116 to %TypeAnnotation*
  %t118 = insertvalue %Parameter %t115, %TypeAnnotation* %t117, 1
  %t119 = load i8*, i8** %l9
  %t120 = bitcast i8* %t119 to %Expression*
  %t121 = insertvalue %Parameter %t118, %Expression* %t120, 2
  %t122 = load i1, i1* %l3
  %t123 = insertvalue %Parameter %t121, i1 %t122, 3
  %t124 = load double, double* %l13
  %t125 = insertvalue %Parameter %t123, %SourceSpan* null, 4
  store %Parameter %t125, %Parameter* %l14
  %t126 = load %Parser, %Parser* %l0
  %t127 = insertvalue %ParameterParseResult undef, %Parser %t126, 0
  %t128 = load %Parameter, %Parameter* %l14
  %t129 = insertvalue %ParameterParseResult %t127, %Parameter %t128, 1
  ret %ParameterParseResult %t129
}

define %EffectParseResult @parse_effect_list(%Parser %initial_parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca %Token
  %l4 = alloca i8*
  %l5 = alloca %Token
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  %t1 = call %Parser @skip_trivia(%Parser %t0)
  store %Parser %t1, %Parser* %l0
  %t2 = load %Parser, %Parser* %l0
  %t3 = call %Token @parser_peek_raw(%Parser %t2)
  store %Token %t3, %Token* %l1
  %t5 = load %Token, %Token* %l1
  %t6 = extractvalue %Token %t5, 0
  %t7 = extractvalue %TokenKind %t6, 0
  %t8 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t9 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t10 = icmp eq i32 %t7, 0
  %t11 = select i1 %t10, i8* %t9, i8* %t8
  %t12 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t13 = icmp eq i32 %t7, 1
  %t14 = select i1 %t13, i8* %t12, i8* %t11
  %t15 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t16 = icmp eq i32 %t7, 2
  %t17 = select i1 %t16, i8* %t15, i8* %t14
  %t18 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t19 = icmp eq i32 %t7, 3
  %t20 = select i1 %t19, i8* %t18, i8* %t17
  %t21 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t22 = icmp eq i32 %t7, 4
  %t23 = select i1 %t22, i8* %t21, i8* %t20
  %t24 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t7, 5
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %t27 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t28 = icmp eq i32 %t7, 6
  %t29 = select i1 %t28, i8* %t27, i8* %t26
  %t30 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t31 = icmp eq i32 %t7, 7
  %t32 = select i1 %t31, i8* %t30, i8* %t29
  %s33 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.33, i32 0, i32 0
  %t34 = icmp ne i8* %t32, %s33
  br label %logical_or_entry_4

logical_or_entry_4:
  br i1 %t34, label %logical_or_merge_4, label %logical_or_right_4

logical_or_right_4:
  %t35 = load %Token, %Token* %l1
  %t36 = extractvalue %Token %t35, 0
  %t37 = extractvalue %TokenKind %t36, 0
  %t38 = load %Parser, %Parser* %l0
  %t39 = call %Parser @parser_advance_raw(%Parser %t38)
  store %Parser %t39, %Parser* %l0
  %t40 = load %Parser, %Parser* %l0
  %t41 = call %Parser @skip_trivia(%Parser %t40)
  store %Parser %t41, %Parser* %l0
  %t42 = load %Parser, %Parser* %l0
  %t43 = alloca [2 x i8], align 1
  %t44 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  store i8 91, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 1
  store i8 0, i8* %t45
  %t46 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  %t47 = call %Parser @consume_symbol(%Parser %t42, i8* %t46)
  store %Parser %t47, %Parser* %l0
  %t48 = alloca [0 x i8*]
  %t49 = getelementptr [0 x i8*], [0 x i8*]* %t48, i32 0, i32 0
  %t50 = alloca { i8**, i64 }
  %t51 = getelementptr { i8**, i64 }, { i8**, i64 }* %t50, i32 0, i32 0
  store i8** %t49, i8*** %t51
  %t52 = getelementptr { i8**, i64 }, { i8**, i64 }* %t50, i32 0, i32 1
  store i64 0, i64* %t52
  store { i8**, i64 }* %t50, { i8**, i64 }** %l2
  %t53 = load %Parser, %Parser* %l0
  %t54 = call %Parser @skip_trivia(%Parser %t53)
  store %Parser %t54, %Parser* %l0
  %t55 = load %Parser, %Parser* %l0
  %t56 = load %Token, %Token* %l1
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %loop.header0
loop.header0:
  %t179 = phi { i8**, i64 }* [ %t57, %entry ], [ %t177, %loop.latch2 ]
  %t180 = phi %Parser [ %t55, %entry ], [ %t178, %loop.latch2 ]
  store { i8**, i64 }* %t179, { i8**, i64 }** %l2
  store %Parser %t180, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t58 = load %Parser, %Parser* %l0
  %t59 = call %Token @parser_peek_raw(%Parser %t58)
  store %Token %t59, %Token* %l3
  %t61 = load %Token, %Token* %l3
  %t62 = extractvalue %Token %t61, 0
  %t63 = extractvalue %TokenKind %t62, 0
  %t64 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t65 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t63, 0
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t63, 1
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t63, 2
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t75 = icmp eq i32 %t63, 3
  %t76 = select i1 %t75, i8* %t74, i8* %t73
  %t77 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t78 = icmp eq i32 %t63, 4
  %t79 = select i1 %t78, i8* %t77, i8* %t76
  %t80 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t81 = icmp eq i32 %t63, 5
  %t82 = select i1 %t81, i8* %t80, i8* %t79
  %t83 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t84 = icmp eq i32 %t63, 6
  %t85 = select i1 %t84, i8* %t83, i8* %t82
  %t86 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t87 = icmp eq i32 %t63, 7
  %t88 = select i1 %t87, i8* %t86, i8* %t85
  %s89 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.89, i32 0, i32 0
  %t90 = icmp eq i8* %t88, %s89
  br label %logical_and_entry_60

logical_and_entry_60:
  br i1 %t90, label %logical_and_right_60, label %logical_and_merge_60

logical_and_right_60:
  %t91 = load %Token, %Token* %l3
  %t92 = extractvalue %Token %t91, 0
  %t93 = extractvalue %TokenKind %t92, 0
  %t94 = load %Token, %Token* %l3
  %t95 = extractvalue %Token %t94, 0
  %t96 = extractvalue %TokenKind %t95, 0
  %t97 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t98 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t96, 0
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t96, 1
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t96, 2
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t96, 3
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t96, 4
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t96, 5
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %t116 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t96, 6
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %t119 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t96, 7
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %s122 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.122, i32 0, i32 0
  %t123 = icmp eq i8* %t121, %s122
  %t124 = load %Parser, %Parser* %l0
  %t125 = load %Token, %Token* %l1
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t127 = load %Token, %Token* %l3
  br i1 %t123, label %then4, label %merge5
then4:
  %t128 = load %Token, %Token* %l3
  %t129 = call i8* @identifier_text(%Token %t128)
  store i8* %t129, i8** %l4
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t131 = load i8*, i8** %l4
  %t132 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t130, i8* %t131)
  store { i8**, i64 }* %t132, { i8**, i64 }** %l2
  %t133 = load %Parser, %Parser* %l0
  %t134 = call %Parser @parser_advance_raw(%Parser %t133)
  store %Parser %t134, %Parser* %l0
  %t135 = load %Parser, %Parser* %l0
  %t136 = call %Parser @skip_trivia(%Parser %t135)
  store %Parser %t136, %Parser* %l0
  %t137 = load %Parser, %Parser* %l0
  %t138 = call %Token @parser_peek_raw(%Parser %t137)
  store %Token %t138, %Token* %l5
  %t140 = load %Token, %Token* %l5
  %t141 = extractvalue %Token %t140, 0
  %t142 = extractvalue %TokenKind %t141, 0
  %t143 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t144 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t142, 0
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t142, 1
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t142, 2
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t142, 3
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t142, 4
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t142, 5
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %t162 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t142, 6
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t142, 7
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %s168 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.168, i32 0, i32 0
  %t169 = icmp eq i8* %t167, %s168
  br label %logical_and_entry_139

logical_and_entry_139:
  br i1 %t169, label %logical_and_right_139, label %logical_and_merge_139

logical_and_right_139:
  %t170 = load %Token, %Token* %l5
  %t171 = extractvalue %Token %t170, 0
  %t172 = extractvalue %TokenKind %t171, 0
  br label %loop.latch2
merge5:
  %t173 = load %Parser, %Parser* %l0
  %t174 = call %Parser @parser_advance_raw(%Parser %t173)
  store %Parser %t174, %Parser* %l0
  %t175 = load %Parser, %Parser* %l0
  %t176 = call %Parser @skip_trivia(%Parser %t175)
  store %Parser %t176, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t178 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t181 = load %Parser, %Parser* %l0
  %t182 = insertvalue %EffectParseResult undef, %Parser %t181, 0
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t184 = insertvalue %EffectParseResult %t182, { i8**, i64 }* %t183, 1
  ret %EffectParseResult %t184
}

define %BlockParseResult @parse_block(%Parser %initial_parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  %l2 = alloca double
  %l3 = alloca %Parser
  %l4 = alloca double
  %l5 = alloca { %Statement*, i64 }*
  %l6 = alloca %Token
  %l7 = alloca %BlockStatementParseResult
  %l8 = alloca double
  %l9 = alloca %StatementParseResult
  %l10 = alloca double
  %l11 = alloca { %Token*, i64 }*
  %l12 = alloca i8*
  %l13 = alloca %Block
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  %t1 = call %Parser @skip_trivia(%Parser %t0)
  store %Parser %t1, %Parser* %l0
  %t2 = load %Parser, %Parser* %l0
  %t3 = call %Token @parser_peek_raw(%Parser %t2)
  store %Token %t3, %Token* %l1
  %t5 = load %Token, %Token* %l1
  %t6 = extractvalue %Token %t5, 0
  %t7 = extractvalue %TokenKind %t6, 0
  %t8 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t9 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t10 = icmp eq i32 %t7, 0
  %t11 = select i1 %t10, i8* %t9, i8* %t8
  %t12 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t13 = icmp eq i32 %t7, 1
  %t14 = select i1 %t13, i8* %t12, i8* %t11
  %t15 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t16 = icmp eq i32 %t7, 2
  %t17 = select i1 %t16, i8* %t15, i8* %t14
  %t18 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t19 = icmp eq i32 %t7, 3
  %t20 = select i1 %t19, i8* %t18, i8* %t17
  %t21 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t22 = icmp eq i32 %t7, 4
  %t23 = select i1 %t22, i8* %t21, i8* %t20
  %t24 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t7, 5
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %t27 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t28 = icmp eq i32 %t7, 6
  %t29 = select i1 %t28, i8* %t27, i8* %t26
  %t30 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t31 = icmp eq i32 %t7, 7
  %t32 = select i1 %t31, i8* %t30, i8* %t29
  %s33 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.33, i32 0, i32 0
  %t34 = icmp ne i8* %t32, %s33
  br label %logical_or_entry_4

logical_or_entry_4:
  br i1 %t34, label %logical_or_merge_4, label %logical_or_right_4

logical_or_right_4:
  %t35 = load %Token, %Token* %l1
  %t36 = extractvalue %Token %t35, 0
  %t37 = extractvalue %TokenKind %t36, 0
  %t38 = load %Parser, %Parser* %l0
  %t39 = extractvalue %Parser %t38, 1
  store double %t39, double* %l2
  %t40 = load %Parser, %Parser* %l0
  %t41 = call %Parser @parser_advance_raw(%Parser %t40)
  store %Parser %t41, %Parser* %l3
  %t42 = load double, double* %l2
  store double %t42, double* %l4
  %t43 = alloca [0 x %Statement]
  %t44 = getelementptr [0 x %Statement], [0 x %Statement]* %t43, i32 0, i32 0
  %t45 = alloca { %Statement*, i64 }
  %t46 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t45, i32 0, i32 0
  store %Statement* %t44, %Statement** %t46
  %t47 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t45, i32 0, i32 1
  store i64 0, i64* %t47
  store { %Statement*, i64 }* %t45, { %Statement*, i64 }** %l5
  %t48 = load %Parser, %Parser* %l0
  %t49 = load %Token, %Token* %l1
  %t50 = load double, double* %l2
  %t51 = load %Parser, %Parser* %l3
  %t52 = load double, double* %l4
  %t53 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  br label %loop.header0
loop.header0:
  %t261 = phi %Parser [ %t51, %entry ], [ %t259, %loop.latch2 ]
  %t262 = phi { %Statement*, i64 }* [ %t53, %entry ], [ %t260, %loop.latch2 ]
  store %Parser %t261, %Parser* %l3
  store { %Statement*, i64 }* %t262, { %Statement*, i64 }** %l5
  br label %loop.body1
loop.body1:
  %t54 = load %Parser, %Parser* %l3
  %t55 = call %Parser @skip_trivia(%Parser %t54)
  store %Parser %t55, %Parser* %l3
  %t56 = load %Parser, %Parser* %l3
  %t57 = call %Token @parser_peek_raw(%Parser %t56)
  store %Token %t57, %Token* %l6
  %t59 = load %Token, %Token* %l6
  %t60 = extractvalue %Token %t59, 0
  %t61 = extractvalue %TokenKind %t60, 0
  %t62 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t63 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t61, 0
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t61, 1
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t61, 2
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t61, 3
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t61, 4
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t61, 5
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %t81 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t61, 6
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t61, 7
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %s87 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.87, i32 0, i32 0
  %t88 = icmp eq i8* %t86, %s87
  br label %logical_and_entry_58

logical_and_entry_58:
  br i1 %t88, label %logical_and_right_58, label %logical_and_merge_58

logical_and_right_58:
  %t89 = load %Token, %Token* %l6
  %t90 = extractvalue %Token %t89, 0
  %t91 = extractvalue %TokenKind %t90, 0
  %t92 = load %Token, %Token* %l6
  %t93 = extractvalue %Token %t92, 0
  %t94 = extractvalue %TokenKind %t93, 0
  %t95 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t96 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t97 = icmp eq i32 %t94, 0
  %t98 = select i1 %t97, i8* %t96, i8* %t95
  %t99 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t94, 1
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t94, 2
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t106 = icmp eq i32 %t94, 3
  %t107 = select i1 %t106, i8* %t105, i8* %t104
  %t108 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t94, 4
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t112 = icmp eq i32 %t94, 5
  %t113 = select i1 %t112, i8* %t111, i8* %t110
  %t114 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t94, 6
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %t117 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t118 = icmp eq i32 %t94, 7
  %t119 = select i1 %t118, i8* %t117, i8* %t116
  %s120 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.120, i32 0, i32 0
  %t121 = icmp eq i8* %t119, %s120
  %t122 = load %Parser, %Parser* %l0
  %t123 = load %Token, %Token* %l1
  %t124 = load double, double* %l2
  %t125 = load %Parser, %Parser* %l3
  %t126 = load double, double* %l4
  %t127 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t128 = load %Token, %Token* %l6
  br i1 %t121, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t129 = load %Parser, %Parser* %l3
  %t130 = call %BlockStatementParseResult @parse_block_statement(%Parser %t129)
  store %BlockStatementParseResult %t130, %BlockStatementParseResult* %l7
  %t131 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  %t132 = extractvalue %BlockStatementParseResult %t131, 2
  %t133 = load %Parser, %Parser* %l0
  %t134 = load %Token, %Token* %l1
  %t135 = load double, double* %l2
  %t136 = load %Parser, %Parser* %l3
  %t137 = load double, double* %l4
  %t138 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t139 = load %Token, %Token* %l6
  %t140 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  br i1 %t132, label %then6, label %merge7
then6:
  %t141 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  %t142 = extractvalue %BlockStatementParseResult %t141, 0
  store %Parser %t142, %Parser* %l3
  %t143 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  %t144 = extractvalue %BlockStatementParseResult %t143, 1
  %t145 = bitcast i8* null to %Statement*
  br label %loop.latch2
merge7:
  %t146 = load %Parser, %Parser* %l3
  %t147 = extractvalue %Parser %t146, 1
  store double %t147, double* %l8
  %t148 = load %Parser, %Parser* %l3
  %t149 = call %StatementParseResult @parse_unknown(%Parser %t148)
  store %StatementParseResult %t149, %StatementParseResult* %l9
  %t150 = load %StatementParseResult, %StatementParseResult* %l9
  %t151 = extractvalue %StatementParseResult %t150, 0
  store %Parser %t151, %Parser* %l3
  %t152 = load %StatementParseResult, %StatementParseResult* %l9
  %t153 = extractvalue %StatementParseResult %t152, 1
  %t154 = extractvalue %Statement %t153, 0
  %t155 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t156 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t154, 0
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t154, 1
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %t162 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t154, 2
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t154, 3
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %t168 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t169 = icmp eq i32 %t154, 4
  %t170 = select i1 %t169, i8* %t168, i8* %t167
  %t171 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t172 = icmp eq i32 %t154, 5
  %t173 = select i1 %t172, i8* %t171, i8* %t170
  %t174 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t175 = icmp eq i32 %t154, 6
  %t176 = select i1 %t175, i8* %t174, i8* %t173
  %t177 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t178 = icmp eq i32 %t154, 7
  %t179 = select i1 %t178, i8* %t177, i8* %t176
  %t180 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t181 = icmp eq i32 %t154, 8
  %t182 = select i1 %t181, i8* %t180, i8* %t179
  %t183 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t184 = icmp eq i32 %t154, 9
  %t185 = select i1 %t184, i8* %t183, i8* %t182
  %t186 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t187 = icmp eq i32 %t154, 10
  %t188 = select i1 %t187, i8* %t186, i8* %t185
  %t189 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t190 = icmp eq i32 %t154, 11
  %t191 = select i1 %t190, i8* %t189, i8* %t188
  %t192 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t193 = icmp eq i32 %t154, 12
  %t194 = select i1 %t193, i8* %t192, i8* %t191
  %t195 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t196 = icmp eq i32 %t154, 13
  %t197 = select i1 %t196, i8* %t195, i8* %t194
  %t198 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t199 = icmp eq i32 %t154, 14
  %t200 = select i1 %t199, i8* %t198, i8* %t197
  %t201 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t202 = icmp eq i32 %t154, 15
  %t203 = select i1 %t202, i8* %t201, i8* %t200
  %t204 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t205 = icmp eq i32 %t154, 16
  %t206 = select i1 %t205, i8* %t204, i8* %t203
  %t207 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t208 = icmp eq i32 %t154, 17
  %t209 = select i1 %t208, i8* %t207, i8* %t206
  %t210 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t211 = icmp eq i32 %t154, 18
  %t212 = select i1 %t211, i8* %t210, i8* %t209
  %t213 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t214 = icmp eq i32 %t154, 19
  %t215 = select i1 %t214, i8* %t213, i8* %t212
  %t216 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t217 = icmp eq i32 %t154, 20
  %t218 = select i1 %t217, i8* %t216, i8* %t215
  %t219 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t220 = icmp eq i32 %t154, 21
  %t221 = select i1 %t220, i8* %t219, i8* %t218
  %t222 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t223 = icmp eq i32 %t154, 22
  %t224 = select i1 %t223, i8* %t222, i8* %t221
  %s225 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.225, i32 0, i32 0
  %t226 = icmp eq i8* %t224, %s225
  %t227 = load %Parser, %Parser* %l0
  %t228 = load %Token, %Token* %l1
  %t229 = load double, double* %l2
  %t230 = load %Parser, %Parser* %l3
  %t231 = load double, double* %l4
  %t232 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t233 = load %Token, %Token* %l6
  %t234 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  %t235 = load double, double* %l8
  %t236 = load %StatementParseResult, %StatementParseResult* %l9
  br i1 %t226, label %then8, label %merge9
then8:
  %t237 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t238 = load %StatementParseResult, %StatementParseResult* %l9
  %t239 = extractvalue %StatementParseResult %t238, 1
  %t240 = call { %Statement*, i64 }* @append_statement({ %Statement*, i64 }* %t237, %Statement %t239)
  store { %Statement*, i64 }* %t240, { %Statement*, i64 }** %l5
  br label %merge9
merge9:
  %t241 = phi { %Statement*, i64 }* [ %t240, %then8 ], [ %t232, %loop.body1 ]
  store { %Statement*, i64 }* %t241, { %Statement*, i64 }** %l5
  %t242 = load %Parser, %Parser* %l3
  %t243 = extractvalue %Parser %t242, 1
  %t244 = load double, double* %l8
  %t245 = fcmp ole double %t243, %t244
  %t246 = load %Parser, %Parser* %l0
  %t247 = load %Token, %Token* %l1
  %t248 = load double, double* %l2
  %t249 = load %Parser, %Parser* %l3
  %t250 = load double, double* %l4
  %t251 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t252 = load %Token, %Token* %l6
  %t253 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  %t254 = load double, double* %l8
  %t255 = load %StatementParseResult, %StatementParseResult* %l9
  br i1 %t245, label %then10, label %merge11
then10:
  %t256 = load %Parser, %Parser* %l3
  %t257 = call %Parser @parser_advance_raw(%Parser %t256)
  store %Parser %t257, %Parser* %l3
  br label %merge11
merge11:
  %t258 = phi %Parser [ %t257, %then10 ], [ %t249, %loop.body1 ]
  store %Parser %t258, %Parser* %l3
  br label %loop.latch2
loop.latch2:
  %t259 = load %Parser, %Parser* %l3
  %t260 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  br label %loop.header0
afterloop3:
  %t263 = load %Parser, %Parser* %l3
  %t264 = extractvalue %Parser %t263, 1
  store double %t264, double* %l10
  %t265 = load double, double* %l4
  %t266 = load double, double* %l2
  %t267 = fcmp ogt double %t265, %t266
  %t268 = load %Parser, %Parser* %l0
  %t269 = load %Token, %Token* %l1
  %t270 = load double, double* %l2
  %t271 = load %Parser, %Parser* %l3
  %t272 = load double, double* %l4
  %t273 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t274 = load double, double* %l10
  br i1 %t267, label %then12, label %merge13
then12:
  %t275 = load double, double* %l4
  store double %t275, double* %l10
  br label %merge13
merge13:
  %t276 = phi double [ %t275, %then12 ], [ %t274, %entry ]
  store double %t276, double* %l10
  %t277 = load %Parser, %Parser* %l0
  %t278 = extractvalue %Parser %t277, 0
  %t279 = load double, double* %l2
  %t280 = load double, double* %l10
  %t281 = bitcast { %Token**, i64 }* %t278 to { %Token*, i64 }*
  %t282 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t281, double %t279, double %t280)
  store { %Token*, i64 }* %t282, { %Token*, i64 }** %l11
  %t283 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t284 = call { %Token*, i64 }* @trim_block_tokens({ %Token*, i64 }* %t283)
  store { %Token*, i64 }* %t284, { %Token*, i64 }** %l11
  %t285 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t286 = call i8* @tokens_to_text({ %Token*, i64 }* %t285)
  store i8* %t286, i8** %l12
  %t287 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t288 = bitcast { %Token*, i64 }* %t287 to { %Token**, i64 }*
  %t289 = insertvalue %Block undef, { %Token**, i64 }* %t288, 0
  %t290 = load i8*, i8** %l12
  %t291 = insertvalue %Block %t289, i8* %t290, 1
  %t292 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t293 = bitcast { %Statement*, i64 }* %t292 to { %Statement**, i64 }*
  %t294 = insertvalue %Block %t291, { %Statement**, i64 }* %t293, 2
  store %Block %t294, %Block* %l13
  %t295 = load %Parser, %Parser* %l3
  %t296 = call %Parser @skip_trivia(%Parser %t295)
  %t297 = insertvalue %BlockParseResult undef, %Parser %t296, 0
  %t298 = load %Block, %Block* %l13
  %t299 = insertvalue %BlockParseResult %t297, %Block %t298, 1
  ret %BlockParseResult %t299
}

define %BlockStatementParseResult @parse_block_statement(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %DecoratorParseResult
  %l2 = alloca %Parser
  %l3 = alloca { %Decorator**, i64 }*
  %l4 = alloca %Parser
  %l5 = alloca %Token
  %l6 = alloca %BlockStatementParseResult
  store %Parser %parser, %Parser* %l0
  %t0 = call %DecoratorParseResult @parse_decorators(%Parser %parser)
  store %DecoratorParseResult %t0, %DecoratorParseResult* %l1
  %t1 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t2 = extractvalue %DecoratorParseResult %t1, 0
  store %Parser %t2, %Parser* %l2
  %t3 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t4 = extractvalue %DecoratorParseResult %t3, 1
  store { %Decorator**, i64 }* %t4, { %Decorator**, i64 }** %l3
  %t5 = load %Parser, %Parser* %l2
  %t6 = call %Parser @skip_trivia(%Parser %t5)
  store %Parser %t6, %Parser* %l4
  %t7 = load %Parser, %Parser* %l4
  %t8 = call %Token @parser_peek_raw(%Parser %t7)
  store %Token %t8, %Token* %l5
  %t9 = load %Token, %Token* %l5
  %s10 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.10, i32 0, i32 0
  %t11 = call i1 @identifier_matches(%Token %t9, i8* %s10)
  %t12 = load %Parser, %Parser* %l0
  %t13 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t14 = load %Parser, %Parser* %l2
  %t15 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t16 = load %Parser, %Parser* %l4
  %t17 = load %Token, %Token* %l5
  br i1 %t11, label %then0, label %merge1
then0:
  %t18 = load %Parser, %Parser* %l4
  %t19 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t20 = bitcast { %Decorator**, i64 }* %t19 to { %Decorator*, i64 }*
  %t21 = call %BlockStatementParseResult @parse_for_statement(%Parser %t18, { %Decorator*, i64 }* %t20)
  ret %BlockStatementParseResult %t21
merge1:
  %t22 = load %Token, %Token* %l5
  %s23 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.23, i32 0, i32 0
  %t24 = call i1 @identifier_matches(%Token %t22, i8* %s23)
  %t25 = load %Parser, %Parser* %l0
  %t26 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t27 = load %Parser, %Parser* %l2
  %t28 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t29 = load %Parser, %Parser* %l4
  %t30 = load %Token, %Token* %l5
  br i1 %t24, label %then2, label %merge3
then2:
  %t31 = load %Parser, %Parser* %l4
  %t32 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t33 = bitcast { %Decorator**, i64 }* %t32 to { %Decorator*, i64 }*
  %t34 = call %BlockStatementParseResult @parse_loop_statement(%Parser %t31, { %Decorator*, i64 }* %t33)
  ret %BlockStatementParseResult %t34
merge3:
  %t35 = load %Token, %Token* %l5
  %s36 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.36, i32 0, i32 0
  %t37 = call i1 @identifier_matches(%Token %t35, i8* %s36)
  %t38 = load %Parser, %Parser* %l0
  %t39 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t40 = load %Parser, %Parser* %l2
  %t41 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t42 = load %Parser, %Parser* %l4
  %t43 = load %Token, %Token* %l5
  br i1 %t37, label %then4, label %merge5
then4:
  %t44 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t45 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t44
  %t46 = extractvalue { %Decorator**, i64 } %t45, 1
  %t47 = icmp sgt i64 %t46, 0
  %t48 = load %Parser, %Parser* %l0
  %t49 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t50 = load %Parser, %Parser* %l2
  %t51 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t52 = load %Parser, %Parser* %l4
  %t53 = load %Token, %Token* %l5
  br i1 %t47, label %then6, label %merge7
then6:
  %t54 = load %Parser, %Parser* %l0
  %t55 = insertvalue %BlockStatementParseResult undef, %Parser %t54, 0
  %t56 = bitcast i8* null to %Statement*
  %t57 = insertvalue %BlockStatementParseResult %t55, %Statement* %t56, 1
  %t58 = insertvalue %BlockStatementParseResult %t57, i1 0, 2
  ret %BlockStatementParseResult %t58
merge7:
  %t59 = load %Parser, %Parser* %l4
  %t60 = call %BlockStatementParseResult @parse_break_statement(%Parser %t59)
  ret %BlockStatementParseResult %t60
merge5:
  %t61 = load %Token, %Token* %l5
  %s62 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.62, i32 0, i32 0
  %t63 = call i1 @identifier_matches(%Token %t61, i8* %s62)
  %t64 = load %Parser, %Parser* %l0
  %t65 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t66 = load %Parser, %Parser* %l2
  %t67 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t68 = load %Parser, %Parser* %l4
  %t69 = load %Token, %Token* %l5
  br i1 %t63, label %then8, label %merge9
then8:
  %t70 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t71 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t70
  %t72 = extractvalue { %Decorator**, i64 } %t71, 1
  %t73 = icmp sgt i64 %t72, 0
  %t74 = load %Parser, %Parser* %l0
  %t75 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t76 = load %Parser, %Parser* %l2
  %t77 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t78 = load %Parser, %Parser* %l4
  %t79 = load %Token, %Token* %l5
  br i1 %t73, label %then10, label %merge11
then10:
  %t80 = load %Parser, %Parser* %l0
  %t81 = insertvalue %BlockStatementParseResult undef, %Parser %t80, 0
  %t82 = bitcast i8* null to %Statement*
  %t83 = insertvalue %BlockStatementParseResult %t81, %Statement* %t82, 1
  %t84 = insertvalue %BlockStatementParseResult %t83, i1 0, 2
  ret %BlockStatementParseResult %t84
merge11:
  %t85 = load %Parser, %Parser* %l4
  %t86 = call %BlockStatementParseResult @parse_continue_statement(%Parser %t85)
  ret %BlockStatementParseResult %t86
merge9:
  %t87 = load %Token, %Token* %l5
  %s88 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.88, i32 0, i32 0
  %t89 = call i1 @identifier_matches(%Token %t87, i8* %s88)
  %t90 = load %Parser, %Parser* %l0
  %t91 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t92 = load %Parser, %Parser* %l2
  %t93 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t94 = load %Parser, %Parser* %l4
  %t95 = load %Token, %Token* %l5
  br i1 %t89, label %then12, label %merge13
then12:
  %t96 = load %Parser, %Parser* %l4
  %t97 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t98 = bitcast { %Decorator**, i64 }* %t97 to { %Decorator*, i64 }*
  %t99 = call %BlockStatementParseResult @parse_if_statement(%Parser %t96, { %Decorator*, i64 }* %t98)
  ret %BlockStatementParseResult %t99
merge13:
  %t100 = load %Token, %Token* %l5
  %s101 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.101, i32 0, i32 0
  %t102 = call i1 @identifier_matches(%Token %t100, i8* %s101)
  %t103 = load %Parser, %Parser* %l0
  %t104 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t105 = load %Parser, %Parser* %l2
  %t106 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t107 = load %Parser, %Parser* %l4
  %t108 = load %Token, %Token* %l5
  br i1 %t102, label %then14, label %merge15
then14:
  %t109 = load %Parser, %Parser* %l4
  %t110 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t111 = bitcast { %Decorator**, i64 }* %t110 to { %Decorator*, i64 }*
  %t112 = call %BlockStatementParseResult @parse_match_statement(%Parser %t109, { %Decorator*, i64 }* %t111)
  ret %BlockStatementParseResult %t112
merge15:
  %t113 = load %Token, %Token* %l5
  %s114 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.114, i32 0, i32 0
  %t115 = call i1 @identifier_matches(%Token %t113, i8* %s114)
  %t116 = load %Parser, %Parser* %l0
  %t117 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t118 = load %Parser, %Parser* %l2
  %t119 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t120 = load %Parser, %Parser* %l4
  %t121 = load %Token, %Token* %l5
  br i1 %t115, label %then16, label %merge17
then16:
  %t122 = load %Parser, %Parser* %l4
  %t123 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t124 = bitcast { %Decorator**, i64 }* %t123 to { %Decorator*, i64 }*
  %t125 = call %BlockStatementParseResult @parse_prompt_statement(%Parser %t122, { %Decorator*, i64 }* %t124)
  ret %BlockStatementParseResult %t125
merge17:
  %t126 = load %Token, %Token* %l5
  %s127 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.127, i32 0, i32 0
  %t128 = call i1 @identifier_matches(%Token %t126, i8* %s127)
  %t129 = load %Parser, %Parser* %l0
  %t130 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t131 = load %Parser, %Parser* %l2
  %t132 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t133 = load %Parser, %Parser* %l4
  %t134 = load %Token, %Token* %l5
  br i1 %t128, label %then18, label %merge19
then18:
  %t135 = load %Parser, %Parser* %l4
  %t136 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t137 = bitcast { %Decorator**, i64 }* %t136 to { %Decorator*, i64 }*
  %t138 = call %BlockStatementParseResult @parse_with_statement(%Parser %t135, { %Decorator*, i64 }* %t137)
  ret %BlockStatementParseResult %t138
merge19:
  %t139 = load %Token, %Token* %l5
  %s140 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.140, i32 0, i32 0
  %t141 = call i1 @identifier_matches(%Token %t139, i8* %s140)
  %t142 = load %Parser, %Parser* %l0
  %t143 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t144 = load %Parser, %Parser* %l2
  %t145 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t146 = load %Parser, %Parser* %l4
  %t147 = load %Token, %Token* %l5
  br i1 %t141, label %then20, label %merge21
then20:
  %t148 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t149 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t148
  %t150 = extractvalue { %Decorator**, i64 } %t149, 1
  %t151 = icmp sgt i64 %t150, 0
  %t152 = load %Parser, %Parser* %l0
  %t153 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t154 = load %Parser, %Parser* %l2
  %t155 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t156 = load %Parser, %Parser* %l4
  %t157 = load %Token, %Token* %l5
  br i1 %t151, label %then22, label %merge23
then22:
  %t158 = load %Parser, %Parser* %l0
  %t159 = insertvalue %BlockStatementParseResult undef, %Parser %t158, 0
  %t160 = bitcast i8* null to %Statement*
  %t161 = insertvalue %BlockStatementParseResult %t159, %Statement* %t160, 1
  %t162 = insertvalue %BlockStatementParseResult %t161, i1 0, 2
  ret %BlockStatementParseResult %t162
merge23:
  %t163 = load %Parser, %Parser* %l4
  %t164 = call %BlockStatementParseResult @parse_return_statement(%Parser %t163)
  ret %BlockStatementParseResult %t164
merge21:
  %t165 = load %Parser, %Parser* %l4
  %t166 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t167 = bitcast { %Decorator**, i64 }* %t166 to { %Decorator*, i64 }*
  %t168 = call %BlockStatementParseResult @parse_expression_statement(%Parser %t165, { %Decorator*, i64 }* %t167)
  store %BlockStatementParseResult %t168, %BlockStatementParseResult* %l6
  %t169 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t170 = extractvalue %BlockStatementParseResult %t169, 2
  %t171 = load %Parser, %Parser* %l0
  %t172 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t173 = load %Parser, %Parser* %l2
  %t174 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t175 = load %Parser, %Parser* %l4
  %t176 = load %Token, %Token* %l5
  %t177 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  br i1 %t170, label %then24, label %merge25
then24:
  %t178 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  ret %BlockStatementParseResult %t178
merge25:
  %t179 = load %Parser, %Parser* %l0
  %t180 = insertvalue %BlockStatementParseResult undef, %Parser %t179, 0
  %t181 = bitcast i8* null to %Statement*
  %t182 = insertvalue %BlockStatementParseResult %t180, %Statement* %t181, 1
  %t183 = insertvalue %BlockStatementParseResult %t182, i1 0, 2
  ret %BlockStatementParseResult %t183
}

define %BlockStatementParseResult @parse_for_statement(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %CaptureResult
  %l3 = alloca { %Token*, i64 }*
  %l4 = alloca double
  %l5 = alloca { %Token*, i64 }*
  %l6 = alloca { %Token*, i64 }*
  %l7 = alloca %Expression
  %l8 = alloca %Expression
  %l9 = alloca %ForClause
  %l10 = alloca %BlockParseResult
  %l11 = alloca %Block
  %l12 = alloca %Token
  %l13 = alloca %Statement
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call %Token @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(%Token %t2, i8* %s3)
  %t5 = xor i1 %t4, 1
  %t6 = load %Parser, %Parser* %l0
  %t7 = load %Parser, %Parser* %l1
  br i1 %t5, label %then0, label %merge1
then0:
  %t8 = load %Parser, %Parser* %l0
  %t9 = insertvalue %BlockStatementParseResult undef, %Parser %t8, 0
  %t10 = bitcast i8* null to %Statement*
  %t11 = insertvalue %BlockStatementParseResult %t9, %Statement* %t10, 1
  %t12 = insertvalue %BlockStatementParseResult %t11, i1 0, 2
  ret %BlockStatementParseResult %t12
merge1:
  %t13 = load %Parser, %Parser* %l1
  %s14 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.14, i32 0, i32 0
  %t15 = call %Parser @consume_keyword(%Parser %t13, i8* %s14)
  store %Parser %t15, %Parser* %l1
  %t16 = load %Parser, %Parser* %l1
  %t17 = call %Parser @skip_trivia(%Parser %t16)
  %t18 = alloca [1 x i8]
  %t19 = getelementptr [1 x i8], [1 x i8]* %t18, i32 0, i32 0
  %t20 = getelementptr i8, i8* %t19, i64 0
  store i8 123, i8* %t20
  %t21 = alloca { i8*, i64 }
  %t22 = getelementptr { i8*, i64 }, { i8*, i64 }* %t21, i32 0, i32 0
  store i8* %t19, i8** %t22
  %t23 = getelementptr { i8*, i64 }, { i8*, i64 }* %t21, i32 0, i32 1
  store i64 1, i64* %t23
  %t24 = bitcast { i8*, i64 }* %t21 to { i8**, i64 }*
  %t25 = call %CaptureResult @collect_until(%Parser %t17, { i8**, i64 }* %t24)
  store %CaptureResult %t25, %CaptureResult* %l2
  %t26 = load %CaptureResult, %CaptureResult* %l2
  %t27 = extractvalue %CaptureResult %t26, 0
  store %Parser %t27, %Parser* %l1
  %t28 = load %CaptureResult, %CaptureResult* %l2
  %t29 = extractvalue %CaptureResult %t28, 1
  %t30 = bitcast { %Token**, i64 }* %t29 to { %Token*, i64 }*
  %t31 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t30)
  store { %Token*, i64 }* %t31, { %Token*, i64 }** %l3
  %t32 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t33 = load { %Token*, i64 }, { %Token*, i64 }* %t32
  %t34 = extractvalue { %Token*, i64 } %t33, 1
  %t35 = icmp eq i64 %t34, 0
  %t36 = load %Parser, %Parser* %l0
  %t37 = load %Parser, %Parser* %l1
  %t38 = load %CaptureResult, %CaptureResult* %l2
  %t39 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  br i1 %t35, label %then2, label %merge3
then2:
  %t40 = load %Parser, %Parser* %l0
  %t41 = insertvalue %BlockStatementParseResult undef, %Parser %t40, 0
  %t42 = bitcast i8* null to %Statement*
  %t43 = insertvalue %BlockStatementParseResult %t41, %Statement* %t42, 1
  %t44 = insertvalue %BlockStatementParseResult %t43, i1 0, 2
  ret %BlockStatementParseResult %t44
merge3:
  %t45 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %s46 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.46, i32 0, i32 0
  %t47 = call double @find_top_level_identifier({ %Token*, i64 }* %t45, i8* %s46)
  store double %t47, double* %l4
  %t48 = load double, double* %l4
  %t49 = sitofp i64 -1 to double
  %t50 = fcmp oeq double %t48, %t49
  %t51 = load %Parser, %Parser* %l0
  %t52 = load %Parser, %Parser* %l1
  %t53 = load %CaptureResult, %CaptureResult* %l2
  %t54 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t55 = load double, double* %l4
  br i1 %t50, label %then4, label %merge5
then4:
  %t56 = load %Parser, %Parser* %l0
  %t57 = insertvalue %BlockStatementParseResult undef, %Parser %t56, 0
  %t58 = bitcast i8* null to %Statement*
  %t59 = insertvalue %BlockStatementParseResult %t57, %Statement* %t58, 1
  %t60 = insertvalue %BlockStatementParseResult %t59, i1 0, 2
  ret %BlockStatementParseResult %t60
merge5:
  %t61 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t62 = load double, double* %l4
  %t63 = sitofp i64 0 to double
  %t64 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t61, double %t63, double %t62)
  %t65 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t64)
  store { %Token*, i64 }* %t65, { %Token*, i64 }** %l5
  %t66 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t67 = load double, double* %l4
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %t67, %t68
  %t70 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t71 = load { %Token*, i64 }, { %Token*, i64 }* %t70
  %t72 = extractvalue { %Token*, i64 } %t71, 1
  %t73 = sitofp i64 %t72 to double
  %t74 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t66, double %t69, double %t73)
  %t75 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t74)
  store { %Token*, i64 }* %t75, { %Token*, i64 }** %l6
  %t77 = load { %Token*, i64 }*, { %Token*, i64 }** %l5
  %t78 = load { %Token*, i64 }, { %Token*, i64 }* %t77
  %t79 = extractvalue { %Token*, i64 } %t78, 1
  %t80 = icmp eq i64 %t79, 0
  br label %logical_or_entry_76

logical_or_entry_76:
  br i1 %t80, label %logical_or_merge_76, label %logical_or_right_76

logical_or_right_76:
  %t81 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  %t82 = load { %Token*, i64 }, { %Token*, i64 }* %t81
  %t83 = extractvalue { %Token*, i64 } %t82, 1
  %t84 = icmp eq i64 %t83, 0
  br label %logical_or_right_end_76

logical_or_right_end_76:
  br label %logical_or_merge_76

logical_or_merge_76:
  %t85 = phi i1 [ true, %logical_or_entry_76 ], [ %t84, %logical_or_right_end_76 ]
  %t86 = load %Parser, %Parser* %l0
  %t87 = load %Parser, %Parser* %l1
  %t88 = load %CaptureResult, %CaptureResult* %l2
  %t89 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t90 = load double, double* %l4
  %t91 = load { %Token*, i64 }*, { %Token*, i64 }** %l5
  %t92 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  br i1 %t85, label %then6, label %merge7
then6:
  %t93 = load %Parser, %Parser* %l0
  %t94 = insertvalue %BlockStatementParseResult undef, %Parser %t93, 0
  %t95 = bitcast i8* null to %Statement*
  %t96 = insertvalue %BlockStatementParseResult %t94, %Statement* %t95, 1
  %t97 = insertvalue %BlockStatementParseResult %t96, i1 0, 2
  ret %BlockStatementParseResult %t97
merge7:
  %t98 = load { %Token*, i64 }*, { %Token*, i64 }** %l5
  %t99 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t98)
  store %Expression %t99, %Expression* %l7
  %t100 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  %t101 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t100)
  store %Expression %t101, %Expression* %l8
  %t102 = load %Expression, %Expression* %l7
  %t103 = insertvalue %ForClause undef, %Expression %t102, 0
  %t104 = load %Expression, %Expression* %l8
  %t105 = insertvalue %ForClause %t103, %Expression %t104, 1
  %t106 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t107 = bitcast { %Token*, i64 }* %t106 to { %Token**, i64 }*
  %t108 = insertvalue %ForClause %t105, { %Token**, i64 }* %t107, 2
  store %ForClause %t108, %ForClause* %l9
  %t109 = load %Parser, %Parser* %l1
  %t110 = call %BlockParseResult @parse_block(%Parser %t109)
  store %BlockParseResult %t110, %BlockParseResult* %l10
  %t111 = load %BlockParseResult, %BlockParseResult* %l10
  %t112 = extractvalue %BlockParseResult %t111, 1
  %t113 = extractvalue %Block %t112, 0
  %t114 = load { %Token**, i64 }, { %Token**, i64 }* %t113
  %t115 = extractvalue { %Token**, i64 } %t114, 1
  %t116 = icmp eq i64 %t115, 0
  %t117 = load %Parser, %Parser* %l0
  %t118 = load %Parser, %Parser* %l1
  %t119 = load %CaptureResult, %CaptureResult* %l2
  %t120 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t121 = load double, double* %l4
  %t122 = load { %Token*, i64 }*, { %Token*, i64 }** %l5
  %t123 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  %t124 = load %Expression, %Expression* %l7
  %t125 = load %Expression, %Expression* %l8
  %t126 = load %ForClause, %ForClause* %l9
  %t127 = load %BlockParseResult, %BlockParseResult* %l10
  br i1 %t116, label %then8, label %merge9
then8:
  %t128 = load %Parser, %Parser* %l0
  %t129 = insertvalue %BlockStatementParseResult undef, %Parser %t128, 0
  %t130 = bitcast i8* null to %Statement*
  %t131 = insertvalue %BlockStatementParseResult %t129, %Statement* %t130, 1
  %t132 = insertvalue %BlockStatementParseResult %t131, i1 0, 2
  ret %BlockStatementParseResult %t132
merge9:
  %t133 = load %BlockParseResult, %BlockParseResult* %l10
  %t134 = extractvalue %BlockParseResult %t133, 0
  store %Parser %t134, %Parser* %l1
  %t135 = load %BlockParseResult, %BlockParseResult* %l10
  %t136 = extractvalue %BlockParseResult %t135, 1
  store %Block %t136, %Block* %l11
  %t137 = load %Parser, %Parser* %l1
  %t138 = call %Parser @skip_trivia(%Parser %t137)
  store %Parser %t138, %Parser* %l1
  %t139 = load %Parser, %Parser* %l1
  %t140 = call %Token @parser_peek_raw(%Parser %t139)
  store %Token %t140, %Token* %l12
  %t142 = load %Token, %Token* %l12
  %t143 = extractvalue %Token %t142, 0
  %t144 = extractvalue %TokenKind %t143, 0
  %t145 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t146 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t144, 0
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t144, 1
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t144, 2
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t144, 3
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t144, 4
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t144, 5
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t144, 6
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t144, 7
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %s170 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.170, i32 0, i32 0
  %t171 = icmp eq i8* %t169, %s170
  br label %logical_and_entry_141

logical_and_entry_141:
  br i1 %t171, label %logical_and_right_141, label %logical_and_merge_141

logical_and_right_141:
  %t172 = load %Token, %Token* %l12
  %t173 = extractvalue %Token %t172, 0
  %t174 = extractvalue %TokenKind %t173, 0
  %t175 = alloca %Statement
  %t176 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 0
  store i32 14, i32* %t176
  %t177 = load %ForClause, %ForClause* %l9
  %t178 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t179 = bitcast [24 x i8]* %t178 to i8*
  %t180 = bitcast i8* %t179 to %ForClause*
  store %ForClause %t177, %ForClause* %t180
  %t181 = load %Block, %Block* %l11
  %t182 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t183 = bitcast [24 x i8]* %t182 to i8*
  %t184 = getelementptr inbounds i8, i8* %t183, i64 8
  %t185 = bitcast i8* %t184 to %Block*
  store %Block %t181, %Block* %t185
  %t186 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t187 = getelementptr inbounds %Statement, %Statement* %t175, i32 0, i32 1
  %t188 = bitcast [24 x i8]* %t187 to i8*
  %t189 = getelementptr inbounds i8, i8* %t188, i64 16
  %t190 = bitcast i8* %t189 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t186, { %Decorator**, i64 }** %t190
  %t191 = load %Statement, %Statement* %t175
  store %Statement %t191, %Statement* %l13
  %t192 = load %Parser, %Parser* %l1
  %t193 = insertvalue %BlockStatementParseResult undef, %Parser %t192, 0
  %t194 = load %Statement, %Statement* %l13
  %t195 = insertvalue %BlockStatementParseResult %t193, %Statement* null, 1
  %t196 = insertvalue %BlockStatementParseResult %t195, i1 1, 2
  ret %BlockStatementParseResult %t196
}

define %BlockStatementParseResult @parse_loop_statement(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %BlockParseResult
  %l3 = alloca %Token
  %l4 = alloca %Statement
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call %Token @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(%Token %t2, i8* %s3)
  %t5 = xor i1 %t4, 1
  %t6 = load %Parser, %Parser* %l0
  %t7 = load %Parser, %Parser* %l1
  br i1 %t5, label %then0, label %merge1
then0:
  %t8 = load %Parser, %Parser* %l0
  %t9 = insertvalue %BlockStatementParseResult undef, %Parser %t8, 0
  %t10 = bitcast i8* null to %Statement*
  %t11 = insertvalue %BlockStatementParseResult %t9, %Statement* %t10, 1
  %t12 = insertvalue %BlockStatementParseResult %t11, i1 0, 2
  ret %BlockStatementParseResult %t12
merge1:
  %t13 = load %Parser, %Parser* %l1
  %s14 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.14, i32 0, i32 0
  %t15 = call %Parser @consume_keyword(%Parser %t13, i8* %s14)
  store %Parser %t15, %Parser* %l1
  %t16 = load %Parser, %Parser* %l1
  %t17 = call %BlockParseResult @parse_block(%Parser %t16)
  store %BlockParseResult %t17, %BlockParseResult* %l2
  %t18 = load %BlockParseResult, %BlockParseResult* %l2
  %t19 = extractvalue %BlockParseResult %t18, 1
  %t20 = extractvalue %Block %t19, 0
  %t21 = load { %Token**, i64 }, { %Token**, i64 }* %t20
  %t22 = extractvalue { %Token**, i64 } %t21, 1
  %t23 = icmp eq i64 %t22, 0
  %t24 = load %Parser, %Parser* %l0
  %t25 = load %Parser, %Parser* %l1
  %t26 = load %BlockParseResult, %BlockParseResult* %l2
  br i1 %t23, label %then2, label %merge3
then2:
  %t27 = load %Parser, %Parser* %l0
  %t28 = insertvalue %BlockStatementParseResult undef, %Parser %t27, 0
  %t29 = bitcast i8* null to %Statement*
  %t30 = insertvalue %BlockStatementParseResult %t28, %Statement* %t29, 1
  %t31 = insertvalue %BlockStatementParseResult %t30, i1 0, 2
  ret %BlockStatementParseResult %t31
merge3:
  %t32 = load %BlockParseResult, %BlockParseResult* %l2
  %t33 = extractvalue %BlockParseResult %t32, 0
  store %Parser %t33, %Parser* %l1
  %t34 = load %Parser, %Parser* %l1
  %t35 = call %Parser @skip_trivia(%Parser %t34)
  store %Parser %t35, %Parser* %l1
  %t36 = load %Parser, %Parser* %l1
  %t37 = call %Token @parser_peek_raw(%Parser %t36)
  store %Token %t37, %Token* %l3
  %t39 = load %Token, %Token* %l3
  %t40 = extractvalue %Token %t39, 0
  %t41 = extractvalue %TokenKind %t40, 0
  %t42 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t43 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t44 = icmp eq i32 %t41, 0
  %t45 = select i1 %t44, i8* %t43, i8* %t42
  %t46 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t47 = icmp eq i32 %t41, 1
  %t48 = select i1 %t47, i8* %t46, i8* %t45
  %t49 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t50 = icmp eq i32 %t41, 2
  %t51 = select i1 %t50, i8* %t49, i8* %t48
  %t52 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t53 = icmp eq i32 %t41, 3
  %t54 = select i1 %t53, i8* %t52, i8* %t51
  %t55 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t41, 4
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t41, 5
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t41, 6
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t41, 7
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %s67 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.67, i32 0, i32 0
  %t68 = icmp eq i8* %t66, %s67
  br label %logical_and_entry_38

logical_and_entry_38:
  br i1 %t68, label %logical_and_right_38, label %logical_and_merge_38

logical_and_right_38:
  %t69 = load %Token, %Token* %l3
  %t70 = extractvalue %Token %t69, 0
  %t71 = extractvalue %TokenKind %t70, 0
  %t72 = alloca %Statement
  %t73 = getelementptr inbounds %Statement, %Statement* %t72, i32 0, i32 0
  store i32 15, i32* %t73
  %t74 = load %BlockParseResult, %BlockParseResult* %l2
  %t75 = extractvalue %BlockParseResult %t74, 1
  %t76 = getelementptr inbounds %Statement, %Statement* %t72, i32 0, i32 1
  %t77 = bitcast [16 x i8]* %t76 to i8*
  %t78 = bitcast i8* %t77 to %Block*
  store %Block %t75, %Block* %t78
  %t79 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t80 = getelementptr inbounds %Statement, %Statement* %t72, i32 0, i32 1
  %t81 = bitcast [16 x i8]* %t80 to i8*
  %t82 = getelementptr inbounds i8, i8* %t81, i64 8
  %t83 = bitcast i8* %t82 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t79, { %Decorator**, i64 }** %t83
  %t84 = load %Statement, %Statement* %t72
  store %Statement %t84, %Statement* %l4
  %t85 = load %Parser, %Parser* %l1
  %t86 = insertvalue %BlockStatementParseResult undef, %Parser %t85, 0
  %t87 = load %Statement, %Statement* %l4
  %t88 = insertvalue %BlockStatementParseResult %t86, %Statement* null, 1
  %t89 = insertvalue %BlockStatementParseResult %t88, i1 1, 2
  ret %BlockStatementParseResult %t89
}

define %BlockStatementParseResult @parse_break_statement(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %Token
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call %Token @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(%Token %t2, i8* %s3)
  %t5 = xor i1 %t4, 1
  %t6 = load %Parser, %Parser* %l0
  %t7 = load %Parser, %Parser* %l1
  br i1 %t5, label %then0, label %merge1
then0:
  %t8 = load %Parser, %Parser* %l0
  %t9 = insertvalue %BlockStatementParseResult undef, %Parser %t8, 0
  %t10 = bitcast i8* null to %Statement*
  %t11 = insertvalue %BlockStatementParseResult %t9, %Statement* %t10, 1
  %t12 = insertvalue %BlockStatementParseResult %t11, i1 0, 2
  ret %BlockStatementParseResult %t12
merge1:
  %t13 = load %Parser, %Parser* %l1
  %s14 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.14, i32 0, i32 0
  %t15 = call %Parser @consume_keyword(%Parser %t13, i8* %s14)
  store %Parser %t15, %Parser* %l1
  %t16 = load %Parser, %Parser* %l1
  %t17 = call %Parser @skip_trivia(%Parser %t16)
  store %Parser %t17, %Parser* %l1
  %t18 = load %Parser, %Parser* %l1
  %t19 = call %Token @parser_peek_raw(%Parser %t18)
  store %Token %t19, %Token* %l2
  %t21 = load %Token, %Token* %l2
  %t22 = extractvalue %Token %t21, 0
  %t23 = extractvalue %TokenKind %t22, 0
  %t24 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t25 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t23, 0
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t23, 1
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %t31 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t32 = icmp eq i32 %t23, 2
  %t33 = select i1 %t32, i8* %t31, i8* %t30
  %t34 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t23, 3
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %t37 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t23, 4
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %t40 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t41 = icmp eq i32 %t23, 5
  %t42 = select i1 %t41, i8* %t40, i8* %t39
  %t43 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t44 = icmp eq i32 %t23, 6
  %t45 = select i1 %t44, i8* %t43, i8* %t42
  %t46 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t47 = icmp eq i32 %t23, 7
  %t48 = select i1 %t47, i8* %t46, i8* %t45
  %s49 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.49, i32 0, i32 0
  %t50 = icmp eq i8* %t48, %s49
  br label %logical_and_entry_20

logical_and_entry_20:
  br i1 %t50, label %logical_and_right_20, label %logical_and_merge_20

logical_and_right_20:
  %t51 = load %Token, %Token* %l2
  %t52 = extractvalue %Token %t51, 0
  %t53 = extractvalue %TokenKind %t52, 0
  %t54 = load %Parser, %Parser* %l1
  %t55 = insertvalue %BlockStatementParseResult undef, %Parser %t54, 0
  %t56 = insertvalue %Statement undef, i32 16, 0
  %t57 = insertvalue %BlockStatementParseResult %t55, %Statement* null, 1
  %t58 = insertvalue %BlockStatementParseResult %t57, i1 1, 2
  ret %BlockStatementParseResult %t58
}

define %BlockStatementParseResult @parse_continue_statement(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %Token
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call %Token @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(%Token %t2, i8* %s3)
  %t5 = xor i1 %t4, 1
  %t6 = load %Parser, %Parser* %l0
  %t7 = load %Parser, %Parser* %l1
  br i1 %t5, label %then0, label %merge1
then0:
  %t8 = load %Parser, %Parser* %l0
  %t9 = insertvalue %BlockStatementParseResult undef, %Parser %t8, 0
  %t10 = bitcast i8* null to %Statement*
  %t11 = insertvalue %BlockStatementParseResult %t9, %Statement* %t10, 1
  %t12 = insertvalue %BlockStatementParseResult %t11, i1 0, 2
  ret %BlockStatementParseResult %t12
merge1:
  %t13 = load %Parser, %Parser* %l1
  %s14 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.14, i32 0, i32 0
  %t15 = call %Parser @consume_keyword(%Parser %t13, i8* %s14)
  store %Parser %t15, %Parser* %l1
  %t16 = load %Parser, %Parser* %l1
  %t17 = call %Parser @skip_trivia(%Parser %t16)
  store %Parser %t17, %Parser* %l1
  %t18 = load %Parser, %Parser* %l1
  %t19 = call %Token @parser_peek_raw(%Parser %t18)
  store %Token %t19, %Token* %l2
  %t21 = load %Token, %Token* %l2
  %t22 = extractvalue %Token %t21, 0
  %t23 = extractvalue %TokenKind %t22, 0
  %t24 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t25 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t23, 0
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t23, 1
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %t31 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t32 = icmp eq i32 %t23, 2
  %t33 = select i1 %t32, i8* %t31, i8* %t30
  %t34 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t23, 3
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %t37 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t23, 4
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %t40 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t41 = icmp eq i32 %t23, 5
  %t42 = select i1 %t41, i8* %t40, i8* %t39
  %t43 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t44 = icmp eq i32 %t23, 6
  %t45 = select i1 %t44, i8* %t43, i8* %t42
  %t46 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t47 = icmp eq i32 %t23, 7
  %t48 = select i1 %t47, i8* %t46, i8* %t45
  %s49 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.49, i32 0, i32 0
  %t50 = icmp eq i8* %t48, %s49
  br label %logical_and_entry_20

logical_and_entry_20:
  br i1 %t50, label %logical_and_right_20, label %logical_and_merge_20

logical_and_right_20:
  %t51 = load %Token, %Token* %l2
  %t52 = extractvalue %Token %t51, 0
  %t53 = extractvalue %TokenKind %t52, 0
  %t54 = load %Parser, %Parser* %l1
  %t55 = insertvalue %BlockStatementParseResult undef, %Parser %t54, 0
  %t56 = insertvalue %Statement undef, i32 17, 0
  %t57 = insertvalue %BlockStatementParseResult %t55, %Statement* null, 1
  %t58 = insertvalue %BlockStatementParseResult %t57, i1 1, 2
  ret %BlockStatementParseResult %t58
}

define %BlockStatementParseResult @parse_if_statement(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %CaptureResult
  %l3 = alloca { %Token*, i64 }*
  %l4 = alloca %Expression
  %l5 = alloca %BlockParseResult
  %l6 = alloca %Block
  %l7 = alloca i8*
  %l8 = alloca %Token
  %l9 = alloca %BlockStatementParseResult
  %l10 = alloca %BlockParseResult
  %l11 = alloca %Token
  %l12 = alloca %Statement
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call %Token @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(%Token %t2, i8* %s3)
  %t5 = xor i1 %t4, 1
  %t6 = load %Parser, %Parser* %l0
  %t7 = load %Parser, %Parser* %l1
  br i1 %t5, label %then0, label %merge1
then0:
  %t8 = load %Parser, %Parser* %l0
  %t9 = insertvalue %BlockStatementParseResult undef, %Parser %t8, 0
  %t10 = bitcast i8* null to %Statement*
  %t11 = insertvalue %BlockStatementParseResult %t9, %Statement* %t10, 1
  %t12 = insertvalue %BlockStatementParseResult %t11, i1 0, 2
  ret %BlockStatementParseResult %t12
merge1:
  %t13 = load %Parser, %Parser* %l1
  %s14 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.14, i32 0, i32 0
  %t15 = call %Parser @consume_keyword(%Parser %t13, i8* %s14)
  store %Parser %t15, %Parser* %l1
  %t16 = load %Parser, %Parser* %l1
  %t17 = call %Parser @skip_trivia(%Parser %t16)
  %t18 = alloca [1 x i8]
  %t19 = getelementptr [1 x i8], [1 x i8]* %t18, i32 0, i32 0
  %t20 = getelementptr i8, i8* %t19, i64 0
  store i8 123, i8* %t20
  %t21 = alloca { i8*, i64 }
  %t22 = getelementptr { i8*, i64 }, { i8*, i64 }* %t21, i32 0, i32 0
  store i8* %t19, i8** %t22
  %t23 = getelementptr { i8*, i64 }, { i8*, i64 }* %t21, i32 0, i32 1
  store i64 1, i64* %t23
  %t24 = bitcast { i8*, i64 }* %t21 to { i8**, i64 }*
  %t25 = call %CaptureResult @collect_until(%Parser %t17, { i8**, i64 }* %t24)
  store %CaptureResult %t25, %CaptureResult* %l2
  %t26 = load %CaptureResult, %CaptureResult* %l2
  %t27 = extractvalue %CaptureResult %t26, 0
  store %Parser %t27, %Parser* %l1
  %t28 = load %CaptureResult, %CaptureResult* %l2
  %t29 = extractvalue %CaptureResult %t28, 1
  %t30 = bitcast { %Token**, i64 }* %t29 to { %Token*, i64 }*
  %t31 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t30)
  store { %Token*, i64 }* %t31, { %Token*, i64 }** %l3
  %t32 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t33 = load { %Token*, i64 }, { %Token*, i64 }* %t32
  %t34 = extractvalue { %Token*, i64 } %t33, 1
  %t35 = icmp eq i64 %t34, 0
  %t36 = load %Parser, %Parser* %l0
  %t37 = load %Parser, %Parser* %l1
  %t38 = load %CaptureResult, %CaptureResult* %l2
  %t39 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  br i1 %t35, label %then2, label %merge3
then2:
  %t40 = load %Parser, %Parser* %l0
  %t41 = insertvalue %BlockStatementParseResult undef, %Parser %t40, 0
  %t42 = bitcast i8* null to %Statement*
  %t43 = insertvalue %BlockStatementParseResult %t41, %Statement* %t42, 1
  %t44 = insertvalue %BlockStatementParseResult %t43, i1 0, 2
  ret %BlockStatementParseResult %t44
merge3:
  %t45 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t46 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t45)
  store %Expression %t46, %Expression* %l4
  %t47 = load %Parser, %Parser* %l1
  %t48 = call %BlockParseResult @parse_block(%Parser %t47)
  store %BlockParseResult %t48, %BlockParseResult* %l5
  %t49 = load %BlockParseResult, %BlockParseResult* %l5
  %t50 = extractvalue %BlockParseResult %t49, 1
  %t51 = extractvalue %Block %t50, 0
  %t52 = load { %Token**, i64 }, { %Token**, i64 }* %t51
  %t53 = extractvalue { %Token**, i64 } %t52, 1
  %t54 = icmp eq i64 %t53, 0
  %t55 = load %Parser, %Parser* %l0
  %t56 = load %Parser, %Parser* %l1
  %t57 = load %CaptureResult, %CaptureResult* %l2
  %t58 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t59 = load %Expression, %Expression* %l4
  %t60 = load %BlockParseResult, %BlockParseResult* %l5
  br i1 %t54, label %then4, label %merge5
then4:
  %t61 = load %Parser, %Parser* %l0
  %t62 = insertvalue %BlockStatementParseResult undef, %Parser %t61, 0
  %t63 = bitcast i8* null to %Statement*
  %t64 = insertvalue %BlockStatementParseResult %t62, %Statement* %t63, 1
  %t65 = insertvalue %BlockStatementParseResult %t64, i1 0, 2
  ret %BlockStatementParseResult %t65
merge5:
  %t66 = load %BlockParseResult, %BlockParseResult* %l5
  %t67 = extractvalue %BlockParseResult %t66, 0
  store %Parser %t67, %Parser* %l1
  %t68 = load %BlockParseResult, %BlockParseResult* %l5
  %t69 = extractvalue %BlockParseResult %t68, 1
  store %Block %t69, %Block* %l6
  %t70 = load %Parser, %Parser* %l1
  %t71 = call %Parser @skip_trivia(%Parser %t70)
  store %Parser %t71, %Parser* %l1
  store i8* null, i8** %l7
  %t72 = load %Parser, %Parser* %l1
  %t73 = call %Token @parser_peek_raw(%Parser %t72)
  %s74 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.74, i32 0, i32 0
  %t75 = call i1 @identifier_matches(%Token %t73, i8* %s74)
  %t76 = load %Parser, %Parser* %l0
  %t77 = load %Parser, %Parser* %l1
  %t78 = load %CaptureResult, %CaptureResult* %l2
  %t79 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t80 = load %Expression, %Expression* %l4
  %t81 = load %BlockParseResult, %BlockParseResult* %l5
  %t82 = load %Block, %Block* %l6
  %t83 = load i8*, i8** %l7
  br i1 %t75, label %then6, label %merge7
then6:
  %t84 = load %Parser, %Parser* %l1
  %s85 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.85, i32 0, i32 0
  %t86 = call %Parser @consume_keyword(%Parser %t84, i8* %s85)
  store %Parser %t86, %Parser* %l1
  %t87 = load %Parser, %Parser* %l1
  %t88 = call %Parser @skip_trivia(%Parser %t87)
  store %Parser %t88, %Parser* %l1
  %t89 = load %Parser, %Parser* %l1
  %t90 = call %Token @parser_peek_raw(%Parser %t89)
  store %Token %t90, %Token* %l8
  %t91 = load %Token, %Token* %l8
  %s92 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.92, i32 0, i32 0
  %t93 = call i1 @identifier_matches(%Token %t91, i8* %s92)
  %t94 = load %Parser, %Parser* %l0
  %t95 = load %Parser, %Parser* %l1
  %t96 = load %CaptureResult, %CaptureResult* %l2
  %t97 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t98 = load %Expression, %Expression* %l4
  %t99 = load %BlockParseResult, %BlockParseResult* %l5
  %t100 = load %Block, %Block* %l6
  %t101 = load i8*, i8** %l7
  %t102 = load %Token, %Token* %l8
  br i1 %t93, label %then8, label %else9
then8:
  %t103 = load %Parser, %Parser* %l1
  %t104 = alloca [0 x double]
  %t105 = getelementptr [0 x double], [0 x double]* %t104, i32 0, i32 0
  %t106 = alloca { double*, i64 }
  %t107 = getelementptr { double*, i64 }, { double*, i64 }* %t106, i32 0, i32 0
  store double* %t105, double** %t107
  %t108 = getelementptr { double*, i64 }, { double*, i64 }* %t106, i32 0, i32 1
  store i64 0, i64* %t108
  %t109 = bitcast { double*, i64 }* %t106 to { %Decorator*, i64 }*
  %t110 = call %BlockStatementParseResult @parse_if_statement(%Parser %t103, { %Decorator*, i64 }* %t109)
  store %BlockStatementParseResult %t110, %BlockStatementParseResult* %l9
  %t111 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  %t112 = extractvalue %BlockStatementParseResult %t111, 2
  %t113 = xor i1 %t112, 1
  %t114 = load %Parser, %Parser* %l0
  %t115 = load %Parser, %Parser* %l1
  %t116 = load %CaptureResult, %CaptureResult* %l2
  %t117 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t118 = load %Expression, %Expression* %l4
  %t119 = load %BlockParseResult, %BlockParseResult* %l5
  %t120 = load %Block, %Block* %l6
  %t121 = load i8*, i8** %l7
  %t122 = load %Token, %Token* %l8
  %t123 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  br i1 %t113, label %then11, label %merge12
then11:
  %t124 = load %Parser, %Parser* %l0
  %t125 = insertvalue %BlockStatementParseResult undef, %Parser %t124, 0
  %t126 = bitcast i8* null to %Statement*
  %t127 = insertvalue %BlockStatementParseResult %t125, %Statement* %t126, 1
  %t128 = insertvalue %BlockStatementParseResult %t127, i1 0, 2
  ret %BlockStatementParseResult %t128
merge12:
  %t129 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  %t130 = extractvalue %BlockStatementParseResult %t129, 1
  %t131 = bitcast i8* null to %Statement*
  %t132 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  %t133 = extractvalue %BlockStatementParseResult %t132, 0
  store %Parser %t133, %Parser* %l1
  %t134 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  %t135 = extractvalue %BlockStatementParseResult %t134, 1
  %t136 = insertvalue %ElseBranch undef, %Statement* %t135, 0
  %t137 = bitcast i8* null to %Block*
  %t138 = insertvalue %ElseBranch %t136, %Block* %t137, 1
  store i8* null, i8** %l7
  br label %merge10
else9:
  %t139 = load %Parser, %Parser* %l1
  %t140 = call %BlockParseResult @parse_block(%Parser %t139)
  store %BlockParseResult %t140, %BlockParseResult* %l10
  %t141 = load %BlockParseResult, %BlockParseResult* %l10
  %t142 = extractvalue %BlockParseResult %t141, 1
  %t143 = extractvalue %Block %t142, 0
  %t144 = load { %Token**, i64 }, { %Token**, i64 }* %t143
  %t145 = extractvalue { %Token**, i64 } %t144, 1
  %t146 = icmp eq i64 %t145, 0
  %t147 = load %Parser, %Parser* %l0
  %t148 = load %Parser, %Parser* %l1
  %t149 = load %CaptureResult, %CaptureResult* %l2
  %t150 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t151 = load %Expression, %Expression* %l4
  %t152 = load %BlockParseResult, %BlockParseResult* %l5
  %t153 = load %Block, %Block* %l6
  %t154 = load i8*, i8** %l7
  %t155 = load %Token, %Token* %l8
  %t156 = load %BlockParseResult, %BlockParseResult* %l10
  br i1 %t146, label %then13, label %merge14
then13:
  %t157 = load %Parser, %Parser* %l0
  %t158 = insertvalue %BlockStatementParseResult undef, %Parser %t157, 0
  %t159 = bitcast i8* null to %Statement*
  %t160 = insertvalue %BlockStatementParseResult %t158, %Statement* %t159, 1
  %t161 = insertvalue %BlockStatementParseResult %t160, i1 0, 2
  ret %BlockStatementParseResult %t161
merge14:
  %t162 = load %BlockParseResult, %BlockParseResult* %l10
  %t163 = extractvalue %BlockParseResult %t162, 0
  store %Parser %t163, %Parser* %l1
  %t164 = bitcast i8* null to %Statement*
  %t165 = insertvalue %ElseBranch undef, %Statement* %t164, 0
  %t166 = load %BlockParseResult, %BlockParseResult* %l10
  %t167 = extractvalue %BlockParseResult %t166, 1
  %t168 = insertvalue %ElseBranch %t165, %Block* null, 1
  store i8* null, i8** %l7
  br label %merge10
merge10:
  %t169 = phi %Parser [ %t133, %then8 ], [ %t163, %else9 ]
  %t170 = phi i8* [ null, %then8 ], [ null, %else9 ]
  store %Parser %t169, %Parser* %l1
  store i8* %t170, i8** %l7
  %t171 = load %Parser, %Parser* %l1
  %t172 = call %Parser @skip_trivia(%Parser %t171)
  store %Parser %t172, %Parser* %l1
  %t173 = load %Parser, %Parser* %l1
  %t174 = call %Token @parser_peek_raw(%Parser %t173)
  store %Token %t174, %Token* %l11
  %t176 = load %Token, %Token* %l11
  %t177 = extractvalue %Token %t176, 0
  %t178 = extractvalue %TokenKind %t177, 0
  %t179 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t180 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t181 = icmp eq i32 %t178, 0
  %t182 = select i1 %t181, i8* %t180, i8* %t179
  %t183 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t184 = icmp eq i32 %t178, 1
  %t185 = select i1 %t184, i8* %t183, i8* %t182
  %t186 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t187 = icmp eq i32 %t178, 2
  %t188 = select i1 %t187, i8* %t186, i8* %t185
  %t189 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t190 = icmp eq i32 %t178, 3
  %t191 = select i1 %t190, i8* %t189, i8* %t188
  %t192 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t193 = icmp eq i32 %t178, 4
  %t194 = select i1 %t193, i8* %t192, i8* %t191
  %t195 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t196 = icmp eq i32 %t178, 5
  %t197 = select i1 %t196, i8* %t195, i8* %t194
  %t198 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t199 = icmp eq i32 %t178, 6
  %t200 = select i1 %t199, i8* %t198, i8* %t197
  %t201 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t202 = icmp eq i32 %t178, 7
  %t203 = select i1 %t202, i8* %t201, i8* %t200
  %s204 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.204, i32 0, i32 0
  %t205 = icmp eq i8* %t203, %s204
  br label %logical_and_entry_175

logical_and_entry_175:
  br i1 %t205, label %logical_and_right_175, label %logical_and_merge_175

logical_and_right_175:
  %t206 = load %Token, %Token* %l11
  %t207 = extractvalue %Token %t206, 0
  %t208 = extractvalue %TokenKind %t207, 0
  br label %merge7
merge7:
  %t209 = phi %Parser [ %t86, %then6 ], [ %t77, %entry ]
  %t210 = phi %Parser [ %t88, %then6 ], [ %t77, %entry ]
  %t211 = phi %Parser [ %t133, %then6 ], [ %t77, %entry ]
  %t212 = phi i8* [ null, %then6 ], [ %t83, %entry ]
  %t213 = phi %Parser [ %t163, %then6 ], [ %t77, %entry ]
  %t214 = phi i8* [ null, %then6 ], [ %t83, %entry ]
  %t215 = phi %Parser [ %t172, %then6 ], [ %t77, %entry ]
  store %Parser %t209, %Parser* %l1
  store %Parser %t210, %Parser* %l1
  store %Parser %t211, %Parser* %l1
  store i8* %t212, i8** %l7
  store %Parser %t213, %Parser* %l1
  store i8* %t214, i8** %l7
  store %Parser %t215, %Parser* %l1
  %t216 = alloca %Statement
  %t217 = getelementptr inbounds %Statement, %Statement* %t216, i32 0, i32 0
  store i32 19, i32* %t217
  %t218 = load %Expression, %Expression* %l4
  %t219 = getelementptr inbounds %Statement, %Statement* %t216, i32 0, i32 1
  %t220 = bitcast [32 x i8]* %t219 to i8*
  %t221 = bitcast i8* %t220 to %Expression*
  store %Expression %t218, %Expression* %t221
  %t222 = load %Block, %Block* %l6
  %t223 = getelementptr inbounds %Statement, %Statement* %t216, i32 0, i32 1
  %t224 = bitcast [32 x i8]* %t223 to i8*
  %t225 = getelementptr inbounds i8, i8* %t224, i64 8
  %t226 = bitcast i8* %t225 to %Block*
  store %Block %t222, %Block* %t226
  %t227 = load i8*, i8** %l7
  %t228 = bitcast i8* %t227 to %ElseBranch*
  %t229 = getelementptr inbounds %Statement, %Statement* %t216, i32 0, i32 1
  %t230 = bitcast [32 x i8]* %t229 to i8*
  %t231 = getelementptr inbounds i8, i8* %t230, i64 16
  %t232 = bitcast i8* %t231 to %ElseBranch**
  store %ElseBranch* %t228, %ElseBranch** %t232
  %t233 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t234 = getelementptr inbounds %Statement, %Statement* %t216, i32 0, i32 1
  %t235 = bitcast [32 x i8]* %t234 to i8*
  %t236 = getelementptr inbounds i8, i8* %t235, i64 24
  %t237 = bitcast i8* %t236 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t233, { %Decorator**, i64 }** %t237
  %t238 = load %Statement, %Statement* %t216
  store %Statement %t238, %Statement* %l12
  %t239 = load %Parser, %Parser* %l1
  %t240 = insertvalue %BlockStatementParseResult undef, %Parser %t239, 0
  %t241 = load %Statement, %Statement* %l12
  %t242 = insertvalue %BlockStatementParseResult %t240, %Statement* null, 1
  %t243 = insertvalue %BlockStatementParseResult %t242, i1 1, 2
  ret %BlockStatementParseResult %t243
}

define %BlockStatementParseResult @parse_match_statement(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %CaptureResult
  %l3 = alloca { %Token*, i64 }*
  %l4 = alloca %Expression
  %l5 = alloca %MatchCasesParseResult
  %l6 = alloca %Token
  %l7 = alloca %Statement
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call %Token @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(%Token %t2, i8* %s3)
  %t5 = xor i1 %t4, 1
  %t6 = load %Parser, %Parser* %l0
  %t7 = load %Parser, %Parser* %l1
  br i1 %t5, label %then0, label %merge1
then0:
  %t8 = load %Parser, %Parser* %l0
  %t9 = insertvalue %BlockStatementParseResult undef, %Parser %t8, 0
  %t10 = bitcast i8* null to %Statement*
  %t11 = insertvalue %BlockStatementParseResult %t9, %Statement* %t10, 1
  %t12 = insertvalue %BlockStatementParseResult %t11, i1 0, 2
  ret %BlockStatementParseResult %t12
merge1:
  %t13 = load %Parser, %Parser* %l1
  %s14 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.14, i32 0, i32 0
  %t15 = call %Parser @consume_keyword(%Parser %t13, i8* %s14)
  store %Parser %t15, %Parser* %l1
  %t16 = load %Parser, %Parser* %l1
  %t17 = call %Parser @skip_trivia(%Parser %t16)
  %t18 = alloca [1 x i8]
  %t19 = getelementptr [1 x i8], [1 x i8]* %t18, i32 0, i32 0
  %t20 = getelementptr i8, i8* %t19, i64 0
  store i8 123, i8* %t20
  %t21 = alloca { i8*, i64 }
  %t22 = getelementptr { i8*, i64 }, { i8*, i64 }* %t21, i32 0, i32 0
  store i8* %t19, i8** %t22
  %t23 = getelementptr { i8*, i64 }, { i8*, i64 }* %t21, i32 0, i32 1
  store i64 1, i64* %t23
  %t24 = bitcast { i8*, i64 }* %t21 to { i8**, i64 }*
  %t25 = call %CaptureResult @collect_until(%Parser %t17, { i8**, i64 }* %t24)
  store %CaptureResult %t25, %CaptureResult* %l2
  %t26 = load %CaptureResult, %CaptureResult* %l2
  %t27 = extractvalue %CaptureResult %t26, 0
  store %Parser %t27, %Parser* %l1
  %t28 = load %CaptureResult, %CaptureResult* %l2
  %t29 = extractvalue %CaptureResult %t28, 1
  %t30 = bitcast { %Token**, i64 }* %t29 to { %Token*, i64 }*
  %t31 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t30)
  store { %Token*, i64 }* %t31, { %Token*, i64 }** %l3
  %t32 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t33 = load { %Token*, i64 }, { %Token*, i64 }* %t32
  %t34 = extractvalue { %Token*, i64 } %t33, 1
  %t35 = icmp eq i64 %t34, 0
  %t36 = load %Parser, %Parser* %l0
  %t37 = load %Parser, %Parser* %l1
  %t38 = load %CaptureResult, %CaptureResult* %l2
  %t39 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  br i1 %t35, label %then2, label %merge3
then2:
  %t40 = load %Parser, %Parser* %l0
  %t41 = insertvalue %BlockStatementParseResult undef, %Parser %t40, 0
  %t42 = bitcast i8* null to %Statement*
  %t43 = insertvalue %BlockStatementParseResult %t41, %Statement* %t42, 1
  %t44 = insertvalue %BlockStatementParseResult %t43, i1 0, 2
  ret %BlockStatementParseResult %t44
merge3:
  %t45 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t46 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t45)
  store %Expression %t46, %Expression* %l4
  %t47 = load %Parser, %Parser* %l1
  %t48 = call %MatchCasesParseResult @parse_match_cases(%Parser %t47)
  store %MatchCasesParseResult %t48, %MatchCasesParseResult* %l5
  %t49 = load %MatchCasesParseResult, %MatchCasesParseResult* %l5
  %t50 = extractvalue %MatchCasesParseResult %t49, 2
  %t51 = xor i1 %t50, 1
  %t52 = load %Parser, %Parser* %l0
  %t53 = load %Parser, %Parser* %l1
  %t54 = load %CaptureResult, %CaptureResult* %l2
  %t55 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t56 = load %Expression, %Expression* %l4
  %t57 = load %MatchCasesParseResult, %MatchCasesParseResult* %l5
  br i1 %t51, label %then4, label %merge5
then4:
  %t58 = load %Parser, %Parser* %l0
  %t59 = insertvalue %BlockStatementParseResult undef, %Parser %t58, 0
  %t60 = bitcast i8* null to %Statement*
  %t61 = insertvalue %BlockStatementParseResult %t59, %Statement* %t60, 1
  %t62 = insertvalue %BlockStatementParseResult %t61, i1 0, 2
  ret %BlockStatementParseResult %t62
merge5:
  %t63 = load %MatchCasesParseResult, %MatchCasesParseResult* %l5
  %t64 = extractvalue %MatchCasesParseResult %t63, 0
  store %Parser %t64, %Parser* %l1
  %t65 = load %Parser, %Parser* %l1
  %t66 = call %Parser @skip_trivia(%Parser %t65)
  store %Parser %t66, %Parser* %l1
  %t67 = load %Parser, %Parser* %l1
  %t68 = extractvalue %Parser %t67, 1
  %t69 = load %Parser, %Parser* %l1
  %t70 = extractvalue %Parser %t69, 0
  %t71 = load { %Token**, i64 }, { %Token**, i64 }* %t70
  %t72 = extractvalue { %Token**, i64 } %t71, 1
  %t73 = sitofp i64 %t72 to double
  %t74 = fcmp olt double %t68, %t73
  %t75 = load %Parser, %Parser* %l0
  %t76 = load %Parser, %Parser* %l1
  %t77 = load %CaptureResult, %CaptureResult* %l2
  %t78 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t79 = load %Expression, %Expression* %l4
  %t80 = load %MatchCasesParseResult, %MatchCasesParseResult* %l5
  br i1 %t74, label %then6, label %merge7
then6:
  %t81 = load %Parser, %Parser* %l1
  %t82 = call %Token @parser_peek_raw(%Parser %t81)
  store %Token %t82, %Token* %l6
  %t84 = load %Token, %Token* %l6
  %t85 = extractvalue %Token %t84, 0
  %t86 = extractvalue %TokenKind %t85, 0
  %t87 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t88 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t86, 0
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t86, 1
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t86, 2
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t86, 3
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %t100 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t86, 4
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %t103 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t104 = icmp eq i32 %t86, 5
  %t105 = select i1 %t104, i8* %t103, i8* %t102
  %t106 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t107 = icmp eq i32 %t86, 6
  %t108 = select i1 %t107, i8* %t106, i8* %t105
  %t109 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t110 = icmp eq i32 %t86, 7
  %t111 = select i1 %t110, i8* %t109, i8* %t108
  %s112 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.112, i32 0, i32 0
  %t113 = icmp eq i8* %t111, %s112
  br label %logical_and_entry_83

logical_and_entry_83:
  br i1 %t113, label %logical_and_right_83, label %logical_and_merge_83

logical_and_right_83:
  %t114 = load %Token, %Token* %l6
  %t115 = extractvalue %Token %t114, 0
  %t116 = extractvalue %TokenKind %t115, 0
  br label %merge7
merge7:
  %t117 = alloca %Statement
  %t118 = getelementptr inbounds %Statement, %Statement* %t117, i32 0, i32 0
  store i32 18, i32* %t118
  %t119 = load %Expression, %Expression* %l4
  %t120 = getelementptr inbounds %Statement, %Statement* %t117, i32 0, i32 1
  %t121 = bitcast [24 x i8]* %t120 to i8*
  %t122 = bitcast i8* %t121 to %Expression*
  store %Expression %t119, %Expression* %t122
  %t123 = load %MatchCasesParseResult, %MatchCasesParseResult* %l5
  %t124 = extractvalue %MatchCasesParseResult %t123, 1
  %t125 = getelementptr inbounds %Statement, %Statement* %t117, i32 0, i32 1
  %t126 = bitcast [24 x i8]* %t125 to i8*
  %t127 = getelementptr inbounds i8, i8* %t126, i64 8
  %t128 = bitcast i8* %t127 to { %MatchCase**, i64 }**
  store { %MatchCase**, i64 }* %t124, { %MatchCase**, i64 }** %t128
  %t129 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t130 = getelementptr inbounds %Statement, %Statement* %t117, i32 0, i32 1
  %t131 = bitcast [24 x i8]* %t130 to i8*
  %t132 = getelementptr inbounds i8, i8* %t131, i64 16
  %t133 = bitcast i8* %t132 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t129, { %Decorator**, i64 }** %t133
  %t134 = load %Statement, %Statement* %t117
  store %Statement %t134, %Statement* %l7
  %t135 = load %Parser, %Parser* %l1
  %t136 = insertvalue %BlockStatementParseResult undef, %Parser %t135, 0
  %t137 = load %Statement, %Statement* %l7
  %t138 = insertvalue %BlockStatementParseResult %t136, %Statement* null, 1
  %t139 = insertvalue %BlockStatementParseResult %t138, i1 1, 2
  ret %BlockStatementParseResult %t139
}

define %MatchCasesParseResult @parse_match_cases(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  %l2 = alloca { %MatchCase*, i64 }*
  %l3 = alloca %Token
  %l4 = alloca %MatchCaseParseResult
  %l5 = alloca %Token
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %t2 = alloca [2 x i8], align 1
  %t3 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  store i8 123, i8* %t3
  %t4 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 1
  store i8 0, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  %t6 = call %Parser @advance_to_symbol(%Parser %t1, i8* %t5)
  store %Parser %t6, %Parser* %l0
  %t7 = load %Parser, %Parser* %l0
  %t8 = call %Token @parser_peek_raw(%Parser %t7)
  store %Token %t8, %Token* %l1
  %t10 = load %Token, %Token* %l1
  %t11 = extractvalue %Token %t10, 0
  %t12 = extractvalue %TokenKind %t11, 0
  %t13 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t14 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t15 = icmp eq i32 %t12, 0
  %t16 = select i1 %t15, i8* %t14, i8* %t13
  %t17 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t12, 1
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t12, 2
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t12, 3
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t12, 4
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t12, 5
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t12, 6
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t12, 7
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %s38 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.38, i32 0, i32 0
  %t39 = icmp ne i8* %t37, %s38
  br label %logical_or_entry_9

logical_or_entry_9:
  br i1 %t39, label %logical_or_merge_9, label %logical_or_right_9

logical_or_right_9:
  %t40 = load %Token, %Token* %l1
  %t41 = extractvalue %Token %t40, 0
  %t42 = extractvalue %TokenKind %t41, 0
  %t43 = load %Parser, %Parser* %l0
  %t44 = call %Parser @parser_advance_raw(%Parser %t43)
  store %Parser %t44, %Parser* %l0
  %t45 = alloca [0 x %MatchCase]
  %t46 = getelementptr [0 x %MatchCase], [0 x %MatchCase]* %t45, i32 0, i32 0
  %t47 = alloca { %MatchCase*, i64 }
  %t48 = getelementptr { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t47, i32 0, i32 0
  store %MatchCase* %t46, %MatchCase** %t48
  %t49 = getelementptr { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t47, i32 0, i32 1
  store i64 0, i64* %t49
  store { %MatchCase*, i64 }* %t47, { %MatchCase*, i64 }** %l2
  %t50 = load %Parser, %Parser* %l0
  %t51 = load %Token, %Token* %l1
  %t52 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %l2
  br label %loop.header0
loop.header0:
  %t188 = phi %Parser [ %t50, %entry ], [ %t186, %loop.latch2 ]
  %t189 = phi { %MatchCase*, i64 }* [ %t52, %entry ], [ %t187, %loop.latch2 ]
  store %Parser %t188, %Parser* %l0
  store { %MatchCase*, i64 }* %t189, { %MatchCase*, i64 }** %l2
  br label %loop.body1
loop.body1:
  %t53 = load %Parser, %Parser* %l0
  %t54 = call %Parser @skip_trivia(%Parser %t53)
  store %Parser %t54, %Parser* %l0
  %t55 = load %Parser, %Parser* %l0
  %t56 = call %Token @parser_peek_raw(%Parser %t55)
  store %Token %t56, %Token* %l3
  %t58 = load %Token, %Token* %l3
  %t59 = extractvalue %Token %t58, 0
  %t60 = extractvalue %TokenKind %t59, 0
  %t61 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t62 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t60, 0
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t60, 1
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t60, 2
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t60, 3
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t75 = icmp eq i32 %t60, 4
  %t76 = select i1 %t75, i8* %t74, i8* %t73
  %t77 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t78 = icmp eq i32 %t60, 5
  %t79 = select i1 %t78, i8* %t77, i8* %t76
  %t80 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t81 = icmp eq i32 %t60, 6
  %t82 = select i1 %t81, i8* %t80, i8* %t79
  %t83 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t84 = icmp eq i32 %t60, 7
  %t85 = select i1 %t84, i8* %t83, i8* %t82
  %s86 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.86, i32 0, i32 0
  %t87 = icmp eq i8* %t85, %s86
  br label %logical_and_entry_57

logical_and_entry_57:
  br i1 %t87, label %logical_and_right_57, label %logical_and_merge_57

logical_and_right_57:
  %t88 = load %Token, %Token* %l3
  %t89 = extractvalue %Token %t88, 0
  %t90 = extractvalue %TokenKind %t89, 0
  %t91 = load %Token, %Token* %l3
  %t92 = extractvalue %Token %t91, 0
  %t93 = extractvalue %TokenKind %t92, 0
  %t94 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t95 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t93, 0
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %t98 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t93, 1
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t93, 2
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t93, 3
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t93, 4
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t93, 5
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t93, 6
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %t116 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t93, 7
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %s119 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.119, i32 0, i32 0
  %t120 = icmp eq i8* %t118, %s119
  %t121 = load %Parser, %Parser* %l0
  %t122 = load %Token, %Token* %l1
  %t123 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %l2
  %t124 = load %Token, %Token* %l3
  br i1 %t120, label %then4, label %merge5
then4:
  %t125 = insertvalue %MatchCasesParseResult undef, %Parser %parser, 0
  %t126 = alloca [0 x %MatchCase*]
  %t127 = getelementptr [0 x %MatchCase*], [0 x %MatchCase*]* %t126, i32 0, i32 0
  %t128 = alloca { %MatchCase**, i64 }
  %t129 = getelementptr { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t128, i32 0, i32 0
  store %MatchCase** %t127, %MatchCase*** %t129
  %t130 = getelementptr { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t128, i32 0, i32 1
  store i64 0, i64* %t130
  %t131 = insertvalue %MatchCasesParseResult %t125, { %MatchCase**, i64 }* %t128, 1
  %t132 = insertvalue %MatchCasesParseResult %t131, i1 0, 2
  ret %MatchCasesParseResult %t132
merge5:
  %t133 = load %Parser, %Parser* %l0
  %t134 = call %MatchCaseParseResult @parse_match_case(%Parser %t133)
  store %MatchCaseParseResult %t134, %MatchCaseParseResult* %l4
  %t136 = load %MatchCaseParseResult, %MatchCaseParseResult* %l4
  %t137 = extractvalue %MatchCaseParseResult %t136, 2
  br label %logical_or_entry_135

logical_or_entry_135:
  br i1 %t137, label %logical_or_merge_135, label %logical_or_right_135

logical_or_right_135:
  %t138 = load %MatchCaseParseResult, %MatchCaseParseResult* %l4
  %t139 = extractvalue %MatchCaseParseResult %t138, 1
  %t140 = bitcast i8* null to %MatchCase*
  %t141 = load %MatchCaseParseResult, %MatchCaseParseResult* %l4
  %t142 = extractvalue %MatchCaseParseResult %t141, 0
  store %Parser %t142, %Parser* %l0
  %t143 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %l2
  %t144 = load %MatchCaseParseResult, %MatchCaseParseResult* %l4
  %t145 = extractvalue %MatchCaseParseResult %t144, 1
  %t146 = load %MatchCase, %MatchCase* %t145
  %t147 = call { %MatchCase*, i64 }* @append_match_case({ %MatchCase*, i64 }* %t143, %MatchCase %t146)
  store { %MatchCase*, i64 }* %t147, { %MatchCase*, i64 }** %l2
  %t148 = load %Parser, %Parser* %l0
  %t149 = call %Parser @skip_trivia(%Parser %t148)
  store %Parser %t149, %Parser* %l0
  %t150 = load %Parser, %Parser* %l0
  %t151 = call %Token @parser_peek_raw(%Parser %t150)
  store %Token %t151, %Token* %l5
  %t153 = load %Token, %Token* %l5
  %t154 = extractvalue %Token %t153, 0
  %t155 = extractvalue %TokenKind %t154, 0
  %t156 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t157 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t155, 0
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %t160 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t161 = icmp eq i32 %t155, 1
  %t162 = select i1 %t161, i8* %t160, i8* %t159
  %t163 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t164 = icmp eq i32 %t155, 2
  %t165 = select i1 %t164, i8* %t163, i8* %t162
  %t166 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t167 = icmp eq i32 %t155, 3
  %t168 = select i1 %t167, i8* %t166, i8* %t165
  %t169 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t170 = icmp eq i32 %t155, 4
  %t171 = select i1 %t170, i8* %t169, i8* %t168
  %t172 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t173 = icmp eq i32 %t155, 5
  %t174 = select i1 %t173, i8* %t172, i8* %t171
  %t175 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t176 = icmp eq i32 %t155, 6
  %t177 = select i1 %t176, i8* %t175, i8* %t174
  %t178 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t179 = icmp eq i32 %t155, 7
  %t180 = select i1 %t179, i8* %t178, i8* %t177
  %s181 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.181, i32 0, i32 0
  %t182 = icmp eq i8* %t180, %s181
  br label %logical_and_entry_152

logical_and_entry_152:
  br i1 %t182, label %logical_and_right_152, label %logical_and_merge_152

logical_and_right_152:
  %t183 = load %Token, %Token* %l5
  %t184 = extractvalue %Token %t183, 0
  %t185 = extractvalue %TokenKind %t184, 0
  br label %loop.latch2
loop.latch2:
  %t186 = load %Parser, %Parser* %l0
  %t187 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %l2
  br label %loop.header0
afterloop3:
  %t190 = load %Parser, %Parser* %l0
  %t191 = insertvalue %MatchCasesParseResult undef, %Parser %t190, 0
  %t192 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %l2
  %t193 = bitcast { %MatchCase*, i64 }* %t192 to { %MatchCase**, i64 }*
  %t194 = insertvalue %MatchCasesParseResult %t191, { %MatchCase**, i64 }* %t193, 1
  %t195 = insertvalue %MatchCasesParseResult %t194, i1 1, 2
  ret %MatchCasesParseResult %t195
}

define %MatchCaseParseResult @parse_match_case(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %PatternCaptureResult
  %l3 = alloca %MatchCaseTokenSplit
  %l4 = alloca %Expression
  %l5 = alloca i8*
  %l6 = alloca %Token
  %l7 = alloca i8*
  %l8 = alloca %MatchCase
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call %Token @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(%Token %t2, i8* %s3)
  %t5 = load %Parser, %Parser* %l0
  %t6 = load %Parser, %Parser* %l1
  br i1 %t4, label %then0, label %merge1
then0:
  %t7 = load %Parser, %Parser* %l1
  %s8 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.8, i32 0, i32 0
  %t9 = call %Parser @consume_keyword(%Parser %t7, i8* %s8)
  store %Parser %t9, %Parser* %l1
  %t10 = load %Parser, %Parser* %l1
  %t11 = call %Parser @skip_trivia(%Parser %t10)
  store %Parser %t11, %Parser* %l1
  br label %merge1
merge1:
  %t12 = phi %Parser [ %t9, %then0 ], [ %t6, %entry ]
  %t13 = phi %Parser [ %t11, %then0 ], [ %t6, %entry ]
  store %Parser %t12, %Parser* %l1
  store %Parser %t13, %Parser* %l1
  %t14 = load %Parser, %Parser* %l1
  %t15 = call %PatternCaptureResult @collect_pattern_until_arrow(%Parser %t14)
  store %PatternCaptureResult %t15, %PatternCaptureResult* %l2
  %t16 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t17 = extractvalue %PatternCaptureResult %t16, 2
  %t18 = xor i1 %t17, 1
  %t19 = load %Parser, %Parser* %l0
  %t20 = load %Parser, %Parser* %l1
  %t21 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  br i1 %t18, label %then2, label %merge3
then2:
  %t22 = load %Parser, %Parser* %l0
  %t23 = insertvalue %MatchCaseParseResult undef, %Parser %t22, 0
  %t24 = bitcast i8* null to %MatchCase*
  %t25 = insertvalue %MatchCaseParseResult %t23, %MatchCase* %t24, 1
  %t26 = insertvalue %MatchCaseParseResult %t25, i1 0, 2
  ret %MatchCaseParseResult %t26
merge3:
  %t27 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t28 = extractvalue %PatternCaptureResult %t27, 0
  store %Parser %t28, %Parser* %l1
  %t29 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t30 = extractvalue %PatternCaptureResult %t29, 1
  %t31 = bitcast { %Token**, i64 }* %t30 to { %Token*, i64 }*
  %t32 = call %MatchCaseTokenSplit @split_match_case_tokens({ %Token*, i64 }* %t31)
  store %MatchCaseTokenSplit %t32, %MatchCaseTokenSplit* %l3
  %t33 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t34 = extractvalue %MatchCaseTokenSplit %t33, 0
  %t35 = load { %Token**, i64 }, { %Token**, i64 }* %t34
  %t36 = extractvalue { %Token**, i64 } %t35, 1
  %t37 = icmp eq i64 %t36, 0
  %t38 = load %Parser, %Parser* %l0
  %t39 = load %Parser, %Parser* %l1
  %t40 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t41 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  br i1 %t37, label %then4, label %merge5
then4:
  %t42 = load %Parser, %Parser* %l0
  %t43 = insertvalue %MatchCaseParseResult undef, %Parser %t42, 0
  %t44 = bitcast i8* null to %MatchCase*
  %t45 = insertvalue %MatchCaseParseResult %t43, %MatchCase* %t44, 1
  %t46 = insertvalue %MatchCaseParseResult %t45, i1 0, 2
  ret %MatchCaseParseResult %t46
merge5:
  %t47 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t48 = extractvalue %MatchCaseTokenSplit %t47, 0
  %t49 = bitcast { %Token**, i64 }* %t48 to { %Token*, i64 }*
  %t50 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t49)
  store %Expression %t50, %Expression* %l4
  store i8* null, i8** %l5
  %t51 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t52 = extractvalue %MatchCaseTokenSplit %t51, 2
  %t53 = load %Parser, %Parser* %l0
  %t54 = load %Parser, %Parser* %l1
  %t55 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t56 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t57 = load %Expression, %Expression* %l4
  %t58 = load i8*, i8** %l5
  br i1 %t52, label %then6, label %merge7
then6:
  %t59 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t60 = extractvalue %MatchCaseTokenSplit %t59, 1
  %t61 = load { %Token**, i64 }, { %Token**, i64 }* %t60
  %t62 = extractvalue { %Token**, i64 } %t61, 1
  %t63 = icmp eq i64 %t62, 0
  %t64 = load %Parser, %Parser* %l0
  %t65 = load %Parser, %Parser* %l1
  %t66 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t67 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t68 = load %Expression, %Expression* %l4
  %t69 = load i8*, i8** %l5
  br i1 %t63, label %then8, label %merge9
then8:
  %t70 = load %Parser, %Parser* %l0
  %t71 = insertvalue %MatchCaseParseResult undef, %Parser %t70, 0
  %t72 = bitcast i8* null to %MatchCase*
  %t73 = insertvalue %MatchCaseParseResult %t71, %MatchCase* %t72, 1
  %t74 = insertvalue %MatchCaseParseResult %t73, i1 0, 2
  ret %MatchCaseParseResult %t74
merge9:
  %t75 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t76 = extractvalue %MatchCaseTokenSplit %t75, 1
  %t77 = bitcast { %Token**, i64 }* %t76 to { %Token*, i64 }*
  %t78 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t77)
  store i8* null, i8** %l5
  br label %merge7
merge7:
  %t79 = phi i8* [ null, %then6 ], [ %t58, %entry ]
  store i8* %t79, i8** %l5
  %t80 = load %Parser, %Parser* %l1
  %t81 = call %Parser @skip_trivia(%Parser %t80)
  store %Parser %t81, %Parser* %l1
  %t82 = load %Parser, %Parser* %l1
  %t83 = call %Token @parser_peek_raw(%Parser %t82)
  store %Token %t83, %Token* %l6
  store i8* null, i8** %l7
  %t85 = load %Token, %Token* %l6
  %t86 = extractvalue %Token %t85, 0
  %t87 = extractvalue %TokenKind %t86, 0
  %t88 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t89 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t90 = icmp eq i32 %t87, 0
  %t91 = select i1 %t90, i8* %t89, i8* %t88
  %t92 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t93 = icmp eq i32 %t87, 1
  %t94 = select i1 %t93, i8* %t92, i8* %t91
  %t95 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t87, 2
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %t98 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t87, 3
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t87, 4
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t87, 5
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t87, 6
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t87, 7
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %s113 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.113, i32 0, i32 0
  %t114 = icmp eq i8* %t112, %s113
  br label %logical_and_entry_84

logical_and_entry_84:
  br i1 %t114, label %logical_and_right_84, label %logical_and_merge_84

logical_and_right_84:
  %t115 = load %Token, %Token* %l6
  %t116 = extractvalue %Token %t115, 0
  %t117 = extractvalue %TokenKind %t116, 0
  %t118 = load i8*, i8** %l7
  %t119 = icmp eq i8* %t118, null
  %t120 = load %Parser, %Parser* %l0
  %t121 = load %Parser, %Parser* %l1
  %t122 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t123 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t124 = load %Expression, %Expression* %l4
  %t125 = load i8*, i8** %l5
  %t126 = load %Token, %Token* %l6
  %t127 = load i8*, i8** %l7
  br i1 %t119, label %then10, label %merge11
then10:
  %t128 = load %Parser, %Parser* %l0
  %t129 = insertvalue %MatchCaseParseResult undef, %Parser %t128, 0
  %t130 = bitcast i8* null to %MatchCase*
  %t131 = insertvalue %MatchCaseParseResult %t129, %MatchCase* %t130, 1
  %t132 = insertvalue %MatchCaseParseResult %t131, i1 0, 2
  ret %MatchCaseParseResult %t132
merge11:
  %t133 = load %Expression, %Expression* %l4
  %t134 = insertvalue %MatchCase undef, %Expression %t133, 0
  %t135 = load i8*, i8** %l5
  %t136 = bitcast i8* %t135 to %Expression*
  %t137 = insertvalue %MatchCase %t134, %Expression* %t136, 1
  %t138 = load i8*, i8** %l7
  %t139 = insertvalue %MatchCase %t137, %Block zeroinitializer, 2
  store %MatchCase %t139, %MatchCase* %l8
  %t140 = load %Parser, %Parser* %l1
  %t141 = insertvalue %MatchCaseParseResult undef, %Parser %t140, 0
  %t142 = load %MatchCase, %MatchCase* %l8
  %t143 = insertvalue %MatchCaseParseResult %t141, %MatchCase* null, 1
  %t144 = insertvalue %MatchCaseParseResult %t143, i1 1, 2
  ret %MatchCaseParseResult %t144
}

define %BlockStatementParseResult @parse_prompt_statement(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %Token
  %l3 = alloca %Token
  %l4 = alloca i8*
  %l5 = alloca %BlockParseResult
  %l6 = alloca %Block
  %l7 = alloca %Statement
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call %Token @parser_peek_raw(%Parser %t1)
  store %Token %t2, %Token* %l2
  %t3 = load %Token, %Token* %l2
  %s4 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.4, i32 0, i32 0
  %t5 = call i1 @identifier_matches(%Token %t3, i8* %s4)
  %t6 = xor i1 %t5, 1
  %t7 = load %Parser, %Parser* %l0
  %t8 = load %Parser, %Parser* %l1
  %t9 = load %Token, %Token* %l2
  br i1 %t6, label %then0, label %merge1
then0:
  %t10 = load %Parser, %Parser* %l0
  %t11 = insertvalue %BlockStatementParseResult undef, %Parser %t10, 0
  %t12 = bitcast i8* null to %Statement*
  %t13 = insertvalue %BlockStatementParseResult %t11, %Statement* %t12, 1
  %t14 = insertvalue %BlockStatementParseResult %t13, i1 0, 2
  ret %BlockStatementParseResult %t14
merge1:
  %t15 = load %Parser, %Parser* %l1
  %s16 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.16, i32 0, i32 0
  %t17 = call %Parser @consume_keyword(%Parser %t15, i8* %s16)
  store %Parser %t17, %Parser* %l1
  %t18 = load %Parser, %Parser* %l1
  %t19 = call %Parser @skip_trivia(%Parser %t18)
  store %Parser %t19, %Parser* %l1
  %t20 = load %Parser, %Parser* %l1
  %t21 = call %Token @parser_peek_raw(%Parser %t20)
  store %Token %t21, %Token* %l3
  %s22 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.22, i32 0, i32 0
  store i8* %s22, i8** %l4
  %t23 = load %Token, %Token* %l3
  %t24 = extractvalue %Token %t23, 0
  %t25 = extractvalue %TokenKind %t24, 0
  %t26 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t27 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t28 = icmp eq i32 %t25, 0
  %t29 = select i1 %t28, i8* %t27, i8* %t26
  %t30 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t31 = icmp eq i32 %t25, 1
  %t32 = select i1 %t31, i8* %t30, i8* %t29
  %t33 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t34 = icmp eq i32 %t25, 2
  %t35 = select i1 %t34, i8* %t33, i8* %t32
  %t36 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t37 = icmp eq i32 %t25, 3
  %t38 = select i1 %t37, i8* %t36, i8* %t35
  %t39 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t40 = icmp eq i32 %t25, 4
  %t41 = select i1 %t40, i8* %t39, i8* %t38
  %t42 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t43 = icmp eq i32 %t25, 5
  %t44 = select i1 %t43, i8* %t42, i8* %t41
  %t45 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t46 = icmp eq i32 %t25, 6
  %t47 = select i1 %t46, i8* %t45, i8* %t44
  %t48 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t49 = icmp eq i32 %t25, 7
  %t50 = select i1 %t49, i8* %t48, i8* %t47
  %s51 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.51, i32 0, i32 0
  %t52 = icmp eq i8* %t50, %s51
  %t53 = load %Parser, %Parser* %l0
  %t54 = load %Parser, %Parser* %l1
  %t55 = load %Token, %Token* %l2
  %t56 = load %Token, %Token* %l3
  %t57 = load i8*, i8** %l4
  br i1 %t52, label %then2, label %else3
then2:
  %t58 = load %Token, %Token* %l3
  %t59 = call i8* @identifier_text(%Token %t58)
  store i8* %t59, i8** %l4
  %t60 = load %Parser, %Parser* %l1
  %t61 = call %Parser @parser_advance_raw(%Parser %t60)
  store %Parser %t61, %Parser* %l1
  br label %merge4
else3:
  %t62 = load %Token, %Token* %l3
  %t63 = extractvalue %Token %t62, 0
  %t64 = extractvalue %TokenKind %t63, 0
  %t65 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t66 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t64, 0
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t64, 1
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t64, 2
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t64, 3
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t64, 4
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %t81 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t64, 5
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t64, 6
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %t87 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t88 = icmp eq i32 %t64, 7
  %t89 = select i1 %t88, i8* %t87, i8* %t86
  %s90 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.90, i32 0, i32 0
  %t91 = icmp eq i8* %t89, %s90
  %t92 = load %Parser, %Parser* %l0
  %t93 = load %Parser, %Parser* %l1
  %t94 = load %Token, %Token* %l2
  %t95 = load %Token, %Token* %l3
  %t96 = load i8*, i8** %l4
  br i1 %t91, label %then5, label %else6
then5:
  %t97 = load %Token, %Token* %l3
  %t98 = call i8* @string_literal_value(%Token %t97)
  store i8* %t98, i8** %l4
  %t99 = load %Parser, %Parser* %l1
  %t100 = call %Parser @parser_advance_raw(%Parser %t99)
  store %Parser %t100, %Parser* %l1
  br label %merge7
else6:
  %t101 = load %Parser, %Parser* %l0
  %t102 = insertvalue %BlockStatementParseResult undef, %Parser %t101, 0
  %t103 = bitcast i8* null to %Statement*
  %t104 = insertvalue %BlockStatementParseResult %t102, %Statement* %t103, 1
  %t105 = insertvalue %BlockStatementParseResult %t104, i1 0, 2
  ret %BlockStatementParseResult %t105
merge7:
  br label %merge4
merge4:
  %t106 = phi i8* [ %t59, %then2 ], [ %t98, %else3 ]
  %t107 = phi %Parser [ %t61, %then2 ], [ %t100, %else3 ]
  store i8* %t106, i8** %l4
  store %Parser %t107, %Parser* %l1
  %t108 = load %Parser, %Parser* %l1
  %t109 = call %BlockParseResult @parse_block(%Parser %t108)
  store %BlockParseResult %t109, %BlockParseResult* %l5
  %t110 = load %BlockParseResult, %BlockParseResult* %l5
  %t111 = extractvalue %BlockParseResult %t110, 1
  %t112 = extractvalue %Block %t111, 0
  %t113 = load { %Token**, i64 }, { %Token**, i64 }* %t112
  %t114 = extractvalue { %Token**, i64 } %t113, 1
  %t115 = icmp eq i64 %t114, 0
  %t116 = load %Parser, %Parser* %l0
  %t117 = load %Parser, %Parser* %l1
  %t118 = load %Token, %Token* %l2
  %t119 = load %Token, %Token* %l3
  %t120 = load i8*, i8** %l4
  %t121 = load %BlockParseResult, %BlockParseResult* %l5
  br i1 %t115, label %then8, label %merge9
then8:
  %t122 = load %Parser, %Parser* %l0
  %t123 = insertvalue %BlockStatementParseResult undef, %Parser %t122, 0
  %t124 = bitcast i8* null to %Statement*
  %t125 = insertvalue %BlockStatementParseResult %t123, %Statement* %t124, 1
  %t126 = insertvalue %BlockStatementParseResult %t125, i1 0, 2
  ret %BlockStatementParseResult %t126
merge9:
  %t127 = load %BlockParseResult, %BlockParseResult* %l5
  %t128 = extractvalue %BlockParseResult %t127, 0
  store %Parser %t128, %Parser* %l1
  %t129 = load %BlockParseResult, %BlockParseResult* %l5
  %t130 = extractvalue %BlockParseResult %t129, 1
  store %Block %t130, %Block* %l6
  %t131 = load %Parser, %Parser* %l1
  %t132 = call %Parser @skip_trivia(%Parser %t131)
  store %Parser %t132, %Parser* %l1
  %t134 = load %Parser, %Parser* %l1
  %t135 = call %Token @parser_peek_raw(%Parser %t134)
  %t136 = extractvalue %Token %t135, 0
  %t137 = extractvalue %TokenKind %t136, 0
  %t138 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t139 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t137, 0
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t137, 1
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t137, 2
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t137, 3
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t137, 4
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t137, 5
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t137, 6
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %t160 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t161 = icmp eq i32 %t137, 7
  %t162 = select i1 %t161, i8* %t160, i8* %t159
  %s163 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.163, i32 0, i32 0
  %t164 = icmp eq i8* %t162, %s163
  br label %logical_and_entry_133

logical_and_entry_133:
  br i1 %t164, label %logical_and_right_133, label %logical_and_merge_133

logical_and_right_133:
  %t165 = load %Parser, %Parser* %l1
  %t166 = call %Token @parser_peek_raw(%Parser %t165)
  %t167 = extractvalue %Token %t166, 0
  %t168 = extractvalue %TokenKind %t167, 0
  %t169 = alloca %Statement
  %t170 = getelementptr inbounds %Statement, %Statement* %t169, i32 0, i32 0
  store i32 12, i32* %t170
  %t171 = load i8*, i8** %l4
  %t172 = getelementptr inbounds %Statement, %Statement* %t169, i32 0, i32 1
  %t173 = bitcast [40 x i8]* %t172 to i8*
  %t174 = bitcast i8* %t173 to i8**
  store i8* %t171, i8** %t174
  %t175 = load %Token, %Token* %l2
  %t176 = getelementptr inbounds %Statement, %Statement* %t169, i32 0, i32 1
  %t177 = bitcast [40 x i8]* %t176 to i8*
  %t178 = getelementptr inbounds i8, i8* %t177, i64 8
  %t179 = bitcast i8* %t178 to %Token*
  store %Token %t175, %Token* %t179
  %t180 = load %Token, %Token* %l3
  %t181 = getelementptr inbounds %Statement, %Statement* %t169, i32 0, i32 1
  %t182 = bitcast [40 x i8]* %t181 to i8*
  %t183 = getelementptr inbounds i8, i8* %t182, i64 16
  %t184 = bitcast i8* %t183 to %Token*
  store %Token %t180, %Token* %t184
  %t185 = load %Block, %Block* %l6
  %t186 = getelementptr inbounds %Statement, %Statement* %t169, i32 0, i32 1
  %t187 = bitcast [40 x i8]* %t186 to i8*
  %t188 = getelementptr inbounds i8, i8* %t187, i64 24
  %t189 = bitcast i8* %t188 to %Block*
  store %Block %t185, %Block* %t189
  %t190 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t191 = getelementptr inbounds %Statement, %Statement* %t169, i32 0, i32 1
  %t192 = bitcast [40 x i8]* %t191 to i8*
  %t193 = getelementptr inbounds i8, i8* %t192, i64 32
  %t194 = bitcast i8* %t193 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t190, { %Decorator**, i64 }** %t194
  %t195 = load %Statement, %Statement* %t169
  store %Statement %t195, %Statement* %l7
  %t196 = load %Parser, %Parser* %l1
  %t197 = insertvalue %BlockStatementParseResult undef, %Parser %t196, 0
  %t198 = load %Statement, %Statement* %l7
  %t199 = insertvalue %BlockStatementParseResult %t197, %Statement* null, 1
  %t200 = insertvalue %BlockStatementParseResult %t199, i1 1, 2
  ret %BlockStatementParseResult %t200
}

define %BlockStatementParseResult @parse_with_statement(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %CaptureResult
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca { %WithClause*, i64 }*
  %l5 = alloca double
  %l6 = alloca { %Token*, i64 }*
  %l7 = alloca %Expression
  %l8 = alloca %BlockParseResult
  %l9 = alloca %Block
  %l10 = alloca %Statement
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call %Token @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(%Token %t2, i8* %s3)
  %t5 = xor i1 %t4, 1
  %t6 = load %Parser, %Parser* %l0
  %t7 = load %Parser, %Parser* %l1
  br i1 %t5, label %then0, label %merge1
then0:
  %t8 = load %Parser, %Parser* %l0
  %t9 = insertvalue %BlockStatementParseResult undef, %Parser %t8, 0
  %t10 = bitcast i8* null to %Statement*
  %t11 = insertvalue %BlockStatementParseResult %t9, %Statement* %t10, 1
  %t12 = insertvalue %BlockStatementParseResult %t11, i1 0, 2
  ret %BlockStatementParseResult %t12
merge1:
  %t13 = load %Parser, %Parser* %l1
  %s14 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.14, i32 0, i32 0
  %t15 = call %Parser @consume_keyword(%Parser %t13, i8* %s14)
  store %Parser %t15, %Parser* %l1
  %t16 = load %Parser, %Parser* %l1
  %t17 = call %Parser @skip_trivia(%Parser %t16)
  %t18 = alloca [1 x i8]
  %t19 = getelementptr [1 x i8], [1 x i8]* %t18, i32 0, i32 0
  %t20 = getelementptr i8, i8* %t19, i64 0
  store i8 123, i8* %t20
  %t21 = alloca { i8*, i64 }
  %t22 = getelementptr { i8*, i64 }, { i8*, i64 }* %t21, i32 0, i32 0
  store i8* %t19, i8** %t22
  %t23 = getelementptr { i8*, i64 }, { i8*, i64 }* %t21, i32 0, i32 1
  store i64 1, i64* %t23
  %t24 = bitcast { i8*, i64 }* %t21 to { i8**, i64 }*
  %t25 = call %CaptureResult @collect_until(%Parser %t17, { i8**, i64 }* %t24)
  store %CaptureResult %t25, %CaptureResult* %l2
  %t26 = load %CaptureResult, %CaptureResult* %l2
  %t27 = extractvalue %CaptureResult %t26, 0
  store %Parser %t27, %Parser* %l1
  %t28 = load %CaptureResult, %CaptureResult* %l2
  %t29 = extractvalue %CaptureResult %t28, 1
  %t30 = bitcast { %Token**, i64 }* %t29 to { %Token*, i64 }*
  %t31 = call { i8**, i64 }* @split_token_slices_by_comma({ %Token*, i64 }* %t30)
  store { i8**, i64 }* %t31, { i8**, i64 }** %l3
  %t32 = alloca [0 x %WithClause]
  %t33 = getelementptr [0 x %WithClause], [0 x %WithClause]* %t32, i32 0, i32 0
  %t34 = alloca { %WithClause*, i64 }
  %t35 = getelementptr { %WithClause*, i64 }, { %WithClause*, i64 }* %t34, i32 0, i32 0
  store %WithClause* %t33, %WithClause** %t35
  %t36 = getelementptr { %WithClause*, i64 }, { %WithClause*, i64 }* %t34, i32 0, i32 1
  store i64 0, i64* %t36
  store { %WithClause*, i64 }* %t34, { %WithClause*, i64 }** %l4
  %t37 = sitofp i64 0 to double
  store double %t37, double* %l5
  %t38 = load %Parser, %Parser* %l0
  %t39 = load %Parser, %Parser* %l1
  %t40 = load %CaptureResult, %CaptureResult* %l2
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t42 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %l4
  %t43 = load double, double* %l5
  br label %loop.header2
loop.header2:
  %t90 = phi { %WithClause*, i64 }* [ %t42, %entry ], [ %t88, %loop.latch4 ]
  %t91 = phi double [ %t43, %entry ], [ %t89, %loop.latch4 ]
  store { %WithClause*, i64 }* %t90, { %WithClause*, i64 }** %l4
  store double %t91, double* %l5
  br label %loop.body3
loop.body3:
  %t44 = load double, double* %l5
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t46 = load { i8**, i64 }, { i8**, i64 }* %t45
  %t47 = extractvalue { i8**, i64 } %t46, 1
  %t48 = sitofp i64 %t47 to double
  %t49 = fcmp oge double %t44, %t48
  %t50 = load %Parser, %Parser* %l0
  %t51 = load %Parser, %Parser* %l1
  %t52 = load %CaptureResult, %CaptureResult* %l2
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t54 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %l4
  %t55 = load double, double* %l5
  br i1 %t49, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t57 = load double, double* %l5
  %t58 = fptosi double %t57 to i64
  %t59 = load { i8**, i64 }, { i8**, i64 }* %t56
  %t60 = extractvalue { i8**, i64 } %t59, 0
  %t61 = extractvalue { i8**, i64 } %t59, 1
  %t62 = icmp uge i64 %t58, %t61
  ; bounds check: %t62 (if true, out of bounds)
  %t63 = getelementptr i8*, i8** %t60, i64 %t58
  %t64 = load i8*, i8** %t63
  %t65 = bitcast i8* %t64 to { %Token*, i64 }*
  %t66 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t65)
  store { %Token*, i64 }* %t66, { %Token*, i64 }** %l6
  %t67 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  %t68 = load { %Token*, i64 }, { %Token*, i64 }* %t67
  %t69 = extractvalue { %Token*, i64 } %t68, 1
  %t70 = icmp sgt i64 %t69, 0
  %t71 = load %Parser, %Parser* %l0
  %t72 = load %Parser, %Parser* %l1
  %t73 = load %CaptureResult, %CaptureResult* %l2
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t75 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %l4
  %t76 = load double, double* %l5
  %t77 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  br i1 %t70, label %then8, label %merge9
then8:
  %t78 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  %t79 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t78)
  store %Expression %t79, %Expression* %l7
  %t80 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %l4
  %t81 = load %Expression, %Expression* %l7
  %t82 = insertvalue %WithClause undef, %Expression %t81, 0
  %t83 = call { %WithClause*, i64 }* @append_with_clause({ %WithClause*, i64 }* %t80, %WithClause %t82)
  store { %WithClause*, i64 }* %t83, { %WithClause*, i64 }** %l4
  br label %merge9
merge9:
  %t84 = phi { %WithClause*, i64 }* [ %t83, %then8 ], [ %t75, %loop.body3 ]
  store { %WithClause*, i64 }* %t84, { %WithClause*, i64 }** %l4
  %t85 = load double, double* %l5
  %t86 = sitofp i64 1 to double
  %t87 = fadd double %t85, %t86
  store double %t87, double* %l5
  br label %loop.latch4
loop.latch4:
  %t88 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %l4
  %t89 = load double, double* %l5
  br label %loop.header2
afterloop5:
  %t92 = load %Parser, %Parser* %l1
  %t93 = call %BlockParseResult @parse_block(%Parser %t92)
  store %BlockParseResult %t93, %BlockParseResult* %l8
  %t94 = load %BlockParseResult, %BlockParseResult* %l8
  %t95 = extractvalue %BlockParseResult %t94, 1
  %t96 = extractvalue %Block %t95, 0
  %t97 = load { %Token**, i64 }, { %Token**, i64 }* %t96
  %t98 = extractvalue { %Token**, i64 } %t97, 1
  %t99 = icmp eq i64 %t98, 0
  %t100 = load %Parser, %Parser* %l0
  %t101 = load %Parser, %Parser* %l1
  %t102 = load %CaptureResult, %CaptureResult* %l2
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t104 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %l4
  %t105 = load double, double* %l5
  %t106 = load %BlockParseResult, %BlockParseResult* %l8
  br i1 %t99, label %then10, label %merge11
then10:
  %t107 = load %Parser, %Parser* %l0
  %t108 = insertvalue %BlockStatementParseResult undef, %Parser %t107, 0
  %t109 = bitcast i8* null to %Statement*
  %t110 = insertvalue %BlockStatementParseResult %t108, %Statement* %t109, 1
  %t111 = insertvalue %BlockStatementParseResult %t110, i1 0, 2
  ret %BlockStatementParseResult %t111
merge11:
  %t112 = load %BlockParseResult, %BlockParseResult* %l8
  %t113 = extractvalue %BlockParseResult %t112, 0
  store %Parser %t113, %Parser* %l1
  %t114 = load %BlockParseResult, %BlockParseResult* %l8
  %t115 = extractvalue %BlockParseResult %t114, 1
  store %Block %t115, %Block* %l9
  %t116 = load %Parser, %Parser* %l1
  %t117 = call %Parser @skip_trivia(%Parser %t116)
  store %Parser %t117, %Parser* %l1
  %t119 = load %Parser, %Parser* %l1
  %t120 = call %Token @parser_peek_raw(%Parser %t119)
  %t121 = extractvalue %Token %t120, 0
  %t122 = extractvalue %TokenKind %t121, 0
  %t123 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t124 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t125 = icmp eq i32 %t122, 0
  %t126 = select i1 %t125, i8* %t124, i8* %t123
  %t127 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t128 = icmp eq i32 %t122, 1
  %t129 = select i1 %t128, i8* %t127, i8* %t126
  %t130 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t131 = icmp eq i32 %t122, 2
  %t132 = select i1 %t131, i8* %t130, i8* %t129
  %t133 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t134 = icmp eq i32 %t122, 3
  %t135 = select i1 %t134, i8* %t133, i8* %t132
  %t136 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t122, 4
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t122, 5
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t122, 6
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t122, 7
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %s148 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.148, i32 0, i32 0
  %t149 = icmp eq i8* %t147, %s148
  br label %logical_and_entry_118

logical_and_entry_118:
  br i1 %t149, label %logical_and_right_118, label %logical_and_merge_118

logical_and_right_118:
  %t150 = load %Parser, %Parser* %l1
  %t151 = call %Token @parser_peek_raw(%Parser %t150)
  %t152 = extractvalue %Token %t151, 0
  %t153 = extractvalue %TokenKind %t152, 0
  %t154 = alloca %Statement
  %t155 = getelementptr inbounds %Statement, %Statement* %t154, i32 0, i32 0
  store i32 13, i32* %t155
  %t156 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %l4
  %t157 = bitcast { %WithClause*, i64 }* %t156 to { %WithClause**, i64 }*
  %t158 = getelementptr inbounds %Statement, %Statement* %t154, i32 0, i32 1
  %t159 = bitcast [24 x i8]* %t158 to i8*
  %t160 = bitcast i8* %t159 to { %WithClause**, i64 }**
  store { %WithClause**, i64 }* %t157, { %WithClause**, i64 }** %t160
  %t161 = load %Block, %Block* %l9
  %t162 = getelementptr inbounds %Statement, %Statement* %t154, i32 0, i32 1
  %t163 = bitcast [24 x i8]* %t162 to i8*
  %t164 = getelementptr inbounds i8, i8* %t163, i64 8
  %t165 = bitcast i8* %t164 to %Block*
  store %Block %t161, %Block* %t165
  %t166 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t167 = getelementptr inbounds %Statement, %Statement* %t154, i32 0, i32 1
  %t168 = bitcast [24 x i8]* %t167 to i8*
  %t169 = getelementptr inbounds i8, i8* %t168, i64 16
  %t170 = bitcast i8* %t169 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t166, { %Decorator**, i64 }** %t170
  %t171 = load %Statement, %Statement* %t154
  store %Statement %t171, %Statement* %l10
  %t172 = load %Parser, %Parser* %l1
  %t173 = insertvalue %BlockStatementParseResult undef, %Parser %t172, 0
  %t174 = load %Statement, %Statement* %l10
  %t175 = insertvalue %BlockStatementParseResult %t173, %Statement* null, 1
  %t176 = insertvalue %BlockStatementParseResult %t175, i1 1, 2
  ret %BlockStatementParseResult %t176
}

define %BlockStatementParseResult @parse_return_statement(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca { %Token*, i64 }*
  %l3 = alloca %CaptureResult
  %l4 = alloca { %Token*, i64 }*
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca %Token
  %l8 = alloca double
  %l9 = alloca %Statement
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call %Token @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(%Token %t2, i8* %s3)
  %t5 = xor i1 %t4, 1
  %t6 = load %Parser, %Parser* %l0
  %t7 = load %Parser, %Parser* %l1
  br i1 %t5, label %then0, label %merge1
then0:
  %t8 = load %Parser, %Parser* %l0
  %t9 = insertvalue %BlockStatementParseResult undef, %Parser %t8, 0
  %t10 = bitcast i8* null to %Statement*
  %t11 = insertvalue %BlockStatementParseResult %t9, %Statement* %t10, 1
  %t12 = insertvalue %BlockStatementParseResult %t11, i1 0, 2
  ret %BlockStatementParseResult %t12
merge1:
  %t13 = alloca [0 x %Token]
  %t14 = getelementptr [0 x %Token], [0 x %Token]* %t13, i32 0, i32 0
  %t15 = alloca { %Token*, i64 }
  %t16 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t15, i32 0, i32 0
  store %Token* %t14, %Token** %t16
  %t17 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t15, i32 0, i32 1
  store i64 0, i64* %t17
  store { %Token*, i64 }* %t15, { %Token*, i64 }** %l2
  %t18 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t19 = load %Parser, %Parser* %l1
  %t20 = call %Token @parser_peek_raw(%Parser %t19)
  %t21 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t18, %Token %t20)
  store { %Token*, i64 }* %t21, { %Token*, i64 }** %l2
  %t22 = load %Parser, %Parser* %l1
  %s23 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.23, i32 0, i32 0
  %t24 = call %Parser @consume_keyword(%Parser %t22, i8* %s23)
  store %Parser %t24, %Parser* %l1
  %t25 = load %Parser, %Parser* %l1
  %t26 = call %Parser @skip_trivia(%Parser %t25)
  %t27 = alloca [2 x i8]
  %t28 = getelementptr [2 x i8], [2 x i8]* %t27, i32 0, i32 0
  %t29 = getelementptr i8, i8* %t28, i64 0
  store i8 59, i8* %t29
  %t30 = getelementptr i8, i8* %t28, i64 1
  store i8 125, i8* %t30
  %t31 = alloca { i8*, i64 }
  %t32 = getelementptr { i8*, i64 }, { i8*, i64 }* %t31, i32 0, i32 0
  store i8* %t28, i8** %t32
  %t33 = getelementptr { i8*, i64 }, { i8*, i64 }* %t31, i32 0, i32 1
  store i64 2, i64* %t33
  %t34 = bitcast { i8*, i64 }* %t31 to { i8**, i64 }*
  %t35 = call %CaptureResult @collect_until(%Parser %t26, { i8**, i64 }* %t34)
  store %CaptureResult %t35, %CaptureResult* %l3
  %t36 = load %CaptureResult, %CaptureResult* %l3
  %t37 = extractvalue %CaptureResult %t36, 0
  store %Parser %t37, %Parser* %l1
  %t38 = load %CaptureResult, %CaptureResult* %l3
  %t39 = extractvalue %CaptureResult %t38, 1
  %t40 = bitcast { %Token**, i64 }* %t39 to { %Token*, i64 }*
  %t41 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t40)
  store { %Token*, i64 }* %t41, { %Token*, i64 }** %l4
  store i8* null, i8** %l5
  %t42 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t43 = load { %Token*, i64 }, { %Token*, i64 }* %t42
  %t44 = extractvalue { %Token*, i64 } %t43, 1
  %t45 = icmp sgt i64 %t44, 0
  %t46 = load %Parser, %Parser* %l0
  %t47 = load %Parser, %Parser* %l1
  %t48 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t49 = load %CaptureResult, %CaptureResult* %l3
  %t50 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t51 = load i8*, i8** %l5
  br i1 %t45, label %then2, label %merge3
then2:
  %t52 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t53 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t52)
  store i8* null, i8** %l5
  br label %merge3
merge3:
  %t54 = phi i8* [ null, %then2 ], [ %t51, %entry ]
  store i8* %t54, i8** %l5
  %t55 = sitofp i64 0 to double
  store double %t55, double* %l6
  %t56 = load %Parser, %Parser* %l0
  %t57 = load %Parser, %Parser* %l1
  %t58 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t59 = load %CaptureResult, %CaptureResult* %l3
  %t60 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t61 = load i8*, i8** %l5
  %t62 = load double, double* %l6
  br label %loop.header4
loop.header4:
  %t95 = phi { %Token*, i64 }* [ %t58, %entry ], [ %t93, %loop.latch6 ]
  %t96 = phi double [ %t62, %entry ], [ %t94, %loop.latch6 ]
  store { %Token*, i64 }* %t95, { %Token*, i64 }** %l2
  store double %t96, double* %l6
  br label %loop.body5
loop.body5:
  %t63 = load double, double* %l6
  %t64 = load %CaptureResult, %CaptureResult* %l3
  %t65 = extractvalue %CaptureResult %t64, 1
  %t66 = load { %Token**, i64 }, { %Token**, i64 }* %t65
  %t67 = extractvalue { %Token**, i64 } %t66, 1
  %t68 = sitofp i64 %t67 to double
  %t69 = fcmp oge double %t63, %t68
  %t70 = load %Parser, %Parser* %l0
  %t71 = load %Parser, %Parser* %l1
  %t72 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t73 = load %CaptureResult, %CaptureResult* %l3
  %t74 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t75 = load i8*, i8** %l5
  %t76 = load double, double* %l6
  br i1 %t69, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t77 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t78 = load %CaptureResult, %CaptureResult* %l3
  %t79 = extractvalue %CaptureResult %t78, 1
  %t80 = load double, double* %l6
  %t81 = fptosi double %t80 to i64
  %t82 = load { %Token**, i64 }, { %Token**, i64 }* %t79
  %t83 = extractvalue { %Token**, i64 } %t82, 0
  %t84 = extractvalue { %Token**, i64 } %t82, 1
  %t85 = icmp uge i64 %t81, %t84
  ; bounds check: %t85 (if true, out of bounds)
  %t86 = getelementptr %Token*, %Token** %t83, i64 %t81
  %t87 = load %Token*, %Token** %t86
  %t88 = load %Token, %Token* %t87
  %t89 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t77, %Token %t88)
  store { %Token*, i64 }* %t89, { %Token*, i64 }** %l2
  %t90 = load double, double* %l6
  %t91 = sitofp i64 1 to double
  %t92 = fadd double %t90, %t91
  store double %t92, double* %l6
  br label %loop.latch6
loop.latch6:
  %t93 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t94 = load double, double* %l6
  br label %loop.header4
afterloop7:
  %t97 = load %Parser, %Parser* %l1
  %t98 = call %Parser @skip_trivia(%Parser %t97)
  store %Parser %t98, %Parser* %l1
  %t99 = load %Parser, %Parser* %l1
  %t100 = call %Token @parser_peek_raw(%Parser %t99)
  store %Token %t100, %Token* %l7
  %t102 = load %Token, %Token* %l7
  %t103 = extractvalue %Token %t102, 0
  %t104 = extractvalue %TokenKind %t103, 0
  %t105 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t106 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t107 = icmp eq i32 %t104, 0
  %t108 = select i1 %t107, i8* %t106, i8* %t105
  %t109 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t110 = icmp eq i32 %t104, 1
  %t111 = select i1 %t110, i8* %t109, i8* %t108
  %t112 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t113 = icmp eq i32 %t104, 2
  %t114 = select i1 %t113, i8* %t112, i8* %t111
  %t115 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t116 = icmp eq i32 %t104, 3
  %t117 = select i1 %t116, i8* %t115, i8* %t114
  %t118 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t119 = icmp eq i32 %t104, 4
  %t120 = select i1 %t119, i8* %t118, i8* %t117
  %t121 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t122 = icmp eq i32 %t104, 5
  %t123 = select i1 %t122, i8* %t121, i8* %t120
  %t124 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t125 = icmp eq i32 %t104, 6
  %t126 = select i1 %t125, i8* %t124, i8* %t123
  %t127 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t128 = icmp eq i32 %t104, 7
  %t129 = select i1 %t128, i8* %t127, i8* %t126
  %s130 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.130, i32 0, i32 0
  %t131 = icmp eq i8* %t129, %s130
  br label %logical_and_entry_101

logical_and_entry_101:
  br i1 %t131, label %logical_and_right_101, label %logical_and_merge_101

logical_and_right_101:
  %t132 = load %Token, %Token* %l7
  %t133 = extractvalue %Token %t132, 0
  %t134 = extractvalue %TokenKind %t133, 0
  %t135 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t136 = call double @source_span_from_tokens({ %Token*, i64 }* %t135)
  store double %t136, double* %l8
  %t137 = alloca %Statement
  %t138 = getelementptr inbounds %Statement, %Statement* %t137, i32 0, i32 0
  store i32 20, i32* %t138
  %t139 = load i8*, i8** %l5
  %t140 = bitcast i8* %t139 to %Expression*
  %t141 = getelementptr inbounds %Statement, %Statement* %t137, i32 0, i32 1
  %t142 = bitcast [16 x i8]* %t141 to i8*
  %t143 = bitcast i8* %t142 to %Expression**
  store %Expression* %t140, %Expression** %t143
  %t144 = load double, double* %l8
  %t145 = call noalias i8* @malloc(i64 8)
  %t146 = bitcast i8* %t145 to double*
  store double %t144, double* %t146
  %t147 = bitcast i8* %t145 to %SourceSpan*
  %t148 = getelementptr inbounds %Statement, %Statement* %t137, i32 0, i32 1
  %t149 = bitcast [16 x i8]* %t148 to i8*
  %t150 = getelementptr inbounds i8, i8* %t149, i64 8
  %t151 = bitcast i8* %t150 to %SourceSpan**
  store %SourceSpan* %t147, %SourceSpan** %t151
  %t152 = load %Statement, %Statement* %t137
  store %Statement %t152, %Statement* %l9
  %t153 = load %Parser, %Parser* %l1
  %t154 = insertvalue %BlockStatementParseResult undef, %Parser %t153, 0
  %t155 = load %Statement, %Statement* %l9
  %t156 = insertvalue %BlockStatementParseResult %t154, %Statement* null, 1
  %t157 = insertvalue %BlockStatementParseResult %t156, i1 1, 2
  ret %BlockStatementParseResult %t157
}

define %BlockStatementParseResult @parse_expression_statement(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  %l2 = alloca double
  %l3 = alloca %CaptureResult
  %l4 = alloca { %Token*, i64 }*
  %l5 = alloca double
  %l6 = alloca { %Token*, i64 }*
  %l7 = alloca %Token
  %l8 = alloca %Expression
  %l9 = alloca double
  %l10 = alloca %Statement
  %t0 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %decorators
  %t1 = extractvalue { %Decorator*, i64 } %t0, 1
  %t2 = icmp sgt i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = insertvalue %BlockStatementParseResult undef, %Parser %parser, 0
  %t4 = bitcast i8* null to %Statement*
  %t5 = insertvalue %BlockStatementParseResult %t3, %Statement* %t4, 1
  %t6 = insertvalue %BlockStatementParseResult %t5, i1 0, 2
  ret %BlockStatementParseResult %t6
merge1:
  %t7 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t7, %Parser* %l0
  %t8 = load %Parser, %Parser* %l0
  %t9 = call %Token @parser_peek_raw(%Parser %t8)
  store %Token %t9, %Token* %l1
  %t10 = load %Token, %Token* %l1
  %t11 = extractvalue %Token %t10, 0
  %t12 = extractvalue %TokenKind %t11, 0
  %t13 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t14 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t15 = icmp eq i32 %t12, 0
  %t16 = select i1 %t15, i8* %t14, i8* %t13
  %t17 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t12, 1
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t12, 2
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t12, 3
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t12, 4
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t12, 5
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t12, 6
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t12, 7
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %s38 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.38, i32 0, i32 0
  %t39 = icmp eq i8* %t37, %s38
  %t40 = load %Parser, %Parser* %l0
  %t41 = load %Token, %Token* %l1
  br i1 %t39, label %then2, label %merge3
then2:
  %t42 = insertvalue %BlockStatementParseResult undef, %Parser %parser, 0
  %t43 = bitcast i8* null to %Statement*
  %t44 = insertvalue %BlockStatementParseResult %t42, %Statement* %t43, 1
  %t45 = insertvalue %BlockStatementParseResult %t44, i1 0, 2
  ret %BlockStatementParseResult %t45
merge3:
  %t46 = load %Token, %Token* %l1
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
  %s74 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.74, i32 0, i32 0
  %t75 = icmp eq i8* %t73, %s74
  %t76 = load %Parser, %Parser* %l0
  %t77 = load %Token, %Token* %l1
  br i1 %t75, label %then4, label %merge5
then4:
  %t78 = load %Token, %Token* %l1
  %t79 = extractvalue %Token %t78, 0
  %t80 = extractvalue %TokenKind %t79, 0
  store double 0.0, double* %l2
  %t82 = load double, double* %l2
  br label %merge5
merge5:
  %t83 = load %Parser, %Parser* %l0
  %t84 = alloca [1 x i8]
  %t85 = getelementptr [1 x i8], [1 x i8]* %t84, i32 0, i32 0
  %t86 = getelementptr i8, i8* %t85, i64 0
  store i8 59, i8* %t86
  %t87 = alloca { i8*, i64 }
  %t88 = getelementptr { i8*, i64 }, { i8*, i64 }* %t87, i32 0, i32 0
  store i8* %t85, i8** %t88
  %t89 = getelementptr { i8*, i64 }, { i8*, i64 }* %t87, i32 0, i32 1
  store i64 1, i64* %t89
  %t90 = bitcast { i8*, i64 }* %t87 to { i8**, i64 }*
  %t91 = call %CaptureResult @collect_until(%Parser %t83, { i8**, i64 }* %t90)
  store %CaptureResult %t91, %CaptureResult* %l3
  %t92 = load %CaptureResult, %CaptureResult* %l3
  %t93 = extractvalue %CaptureResult %t92, 1
  %t94 = load { %Token**, i64 }, { %Token**, i64 }* %t93
  %t95 = extractvalue { %Token**, i64 } %t94, 1
  %t96 = icmp eq i64 %t95, 0
  %t97 = load %Parser, %Parser* %l0
  %t98 = load %Token, %Token* %l1
  %t99 = load %CaptureResult, %CaptureResult* %l3
  br i1 %t96, label %then6, label %merge7
then6:
  %t100 = insertvalue %BlockStatementParseResult undef, %Parser %parser, 0
  %t101 = bitcast i8* null to %Statement*
  %t102 = insertvalue %BlockStatementParseResult %t100, %Statement* %t101, 1
  %t103 = insertvalue %BlockStatementParseResult %t102, i1 0, 2
  ret %BlockStatementParseResult %t103
merge7:
  %t104 = alloca [0 x %Token]
  %t105 = getelementptr [0 x %Token], [0 x %Token]* %t104, i32 0, i32 0
  %t106 = alloca { %Token*, i64 }
  %t107 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t106, i32 0, i32 0
  store %Token* %t105, %Token** %t107
  %t108 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t106, i32 0, i32 1
  store i64 0, i64* %t108
  store { %Token*, i64 }* %t106, { %Token*, i64 }** %l4
  %t109 = sitofp i64 0 to double
  store double %t109, double* %l5
  %t110 = load %Parser, %Parser* %l0
  %t111 = load %Token, %Token* %l1
  %t112 = load %CaptureResult, %CaptureResult* %l3
  %t113 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t114 = load double, double* %l5
  br label %loop.header8
loop.header8:
  %t145 = phi { %Token*, i64 }* [ %t113, %entry ], [ %t143, %loop.latch10 ]
  %t146 = phi double [ %t114, %entry ], [ %t144, %loop.latch10 ]
  store { %Token*, i64 }* %t145, { %Token*, i64 }** %l4
  store double %t146, double* %l5
  br label %loop.body9
loop.body9:
  %t115 = load double, double* %l5
  %t116 = load %CaptureResult, %CaptureResult* %l3
  %t117 = extractvalue %CaptureResult %t116, 1
  %t118 = load { %Token**, i64 }, { %Token**, i64 }* %t117
  %t119 = extractvalue { %Token**, i64 } %t118, 1
  %t120 = sitofp i64 %t119 to double
  %t121 = fcmp oge double %t115, %t120
  %t122 = load %Parser, %Parser* %l0
  %t123 = load %Token, %Token* %l1
  %t124 = load %CaptureResult, %CaptureResult* %l3
  %t125 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t126 = load double, double* %l5
  br i1 %t121, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t127 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t128 = load %CaptureResult, %CaptureResult* %l3
  %t129 = extractvalue %CaptureResult %t128, 1
  %t130 = load double, double* %l5
  %t131 = fptosi double %t130 to i64
  %t132 = load { %Token**, i64 }, { %Token**, i64 }* %t129
  %t133 = extractvalue { %Token**, i64 } %t132, 0
  %t134 = extractvalue { %Token**, i64 } %t132, 1
  %t135 = icmp uge i64 %t131, %t134
  ; bounds check: %t135 (if true, out of bounds)
  %t136 = getelementptr %Token*, %Token** %t133, i64 %t131
  %t137 = load %Token*, %Token** %t136
  %t138 = load %Token, %Token* %t137
  %t139 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t127, %Token %t138)
  store { %Token*, i64 }* %t139, { %Token*, i64 }** %l4
  %t140 = load double, double* %l5
  %t141 = sitofp i64 1 to double
  %t142 = fadd double %t140, %t141
  store double %t142, double* %l5
  br label %loop.latch10
loop.latch10:
  %t143 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t144 = load double, double* %l5
  br label %loop.header8
afterloop11:
  %t147 = load %CaptureResult, %CaptureResult* %l3
  %t148 = extractvalue %CaptureResult %t147, 1
  %t149 = bitcast { %Token**, i64 }* %t148 to { %Token*, i64 }*
  %t150 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t149)
  store { %Token*, i64 }* %t150, { %Token*, i64 }** %l6
  %t151 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  %t152 = load { %Token*, i64 }, { %Token*, i64 }* %t151
  %t153 = extractvalue { %Token*, i64 } %t152, 1
  %t154 = icmp eq i64 %t153, 0
  %t155 = load %Parser, %Parser* %l0
  %t156 = load %Token, %Token* %l1
  %t157 = load %CaptureResult, %CaptureResult* %l3
  %t158 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t159 = load double, double* %l5
  %t160 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  br i1 %t154, label %then14, label %merge15
then14:
  %t161 = insertvalue %BlockStatementParseResult undef, %Parser %parser, 0
  %t162 = bitcast i8* null to %Statement*
  %t163 = insertvalue %BlockStatementParseResult %t161, %Statement* %t162, 1
  %t164 = insertvalue %BlockStatementParseResult %t163, i1 0, 2
  ret %BlockStatementParseResult %t164
merge15:
  %t165 = load %CaptureResult, %CaptureResult* %l3
  %t166 = extractvalue %CaptureResult %t165, 0
  store %Parser %t166, %Parser* %l0
  %t167 = load %Parser, %Parser* %l0
  %t168 = call %Parser @skip_trivia(%Parser %t167)
  store %Parser %t168, %Parser* %l0
  %t169 = load %Parser, %Parser* %l0
  %t170 = call %Token @parser_peek_raw(%Parser %t169)
  store %Token %t170, %Token* %l7
  %t172 = load %Token, %Token* %l7
  %t173 = extractvalue %Token %t172, 0
  %t174 = extractvalue %TokenKind %t173, 0
  %t175 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t176 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t177 = icmp eq i32 %t174, 0
  %t178 = select i1 %t177, i8* %t176, i8* %t175
  %t179 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t174, 1
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t174, 2
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t174, 3
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %t188 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t174, 4
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %t191 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t192 = icmp eq i32 %t174, 5
  %t193 = select i1 %t192, i8* %t191, i8* %t190
  %t194 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t195 = icmp eq i32 %t174, 6
  %t196 = select i1 %t195, i8* %t194, i8* %t193
  %t197 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t198 = icmp eq i32 %t174, 7
  %t199 = select i1 %t198, i8* %t197, i8* %t196
  %s200 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.200, i32 0, i32 0
  %t201 = icmp ne i8* %t199, %s200
  br label %logical_or_entry_171

logical_or_entry_171:
  br i1 %t201, label %logical_or_merge_171, label %logical_or_right_171

logical_or_right_171:
  %t202 = load %Token, %Token* %l7
  %t203 = extractvalue %Token %t202, 0
  %t204 = extractvalue %TokenKind %t203, 0
  %t205 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t206 = load %Token, %Token* %l7
  %t207 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t205, %Token %t206)
  store { %Token*, i64 }* %t207, { %Token*, i64 }** %l4
  %t208 = load %Parser, %Parser* %l0
  %t209 = call %Parser @parser_advance_raw(%Parser %t208)
  store %Parser %t209, %Parser* %l0
  %t210 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  %t211 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t210)
  store %Expression %t211, %Expression* %l8
  %t212 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t213 = call double @source_span_from_tokens({ %Token*, i64 }* %t212)
  store double %t213, double* %l9
  %t214 = alloca %Statement
  %t215 = getelementptr inbounds %Statement, %Statement* %t214, i32 0, i32 0
  store i32 21, i32* %t215
  %t216 = load %Expression, %Expression* %l8
  %t217 = getelementptr inbounds %Statement, %Statement* %t214, i32 0, i32 1
  %t218 = bitcast [16 x i8]* %t217 to i8*
  %t219 = bitcast i8* %t218 to %Expression*
  store %Expression %t216, %Expression* %t219
  %t220 = load double, double* %l9
  %t221 = call noalias i8* @malloc(i64 8)
  %t222 = bitcast i8* %t221 to double*
  store double %t220, double* %t222
  %t223 = bitcast i8* %t221 to %SourceSpan*
  %t224 = getelementptr inbounds %Statement, %Statement* %t214, i32 0, i32 1
  %t225 = bitcast [16 x i8]* %t224 to i8*
  %t226 = getelementptr inbounds i8, i8* %t225, i64 8
  %t227 = bitcast i8* %t226 to %SourceSpan**
  store %SourceSpan* %t223, %SourceSpan** %t227
  %t228 = load %Statement, %Statement* %t214
  store %Statement %t228, %Statement* %l10
  %t229 = load %Parser, %Parser* %l0
  %t230 = insertvalue %BlockStatementParseResult undef, %Parser %t229, 0
  %t231 = load %Statement, %Statement* %l10
  %t232 = insertvalue %BlockStatementParseResult %t230, %Statement* null, 1
  %t233 = insertvalue %BlockStatementParseResult %t232, i1 1, 2
  ret %BlockStatementParseResult %t233
}

define %StatementParseResult @parse_unknown(%Parser %initial_parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca { %Token*, i64 }*
  %l2 = alloca %Parser
  %l3 = alloca double
  %l4 = alloca %Token
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca %Statement
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  %t1 = call %Parser @skip_trivia(%Parser %t0)
  store %Parser %t1, %Parser* %l0
  %t2 = alloca [0 x %Token]
  %t3 = getelementptr [0 x %Token], [0 x %Token]* %t2, i32 0, i32 0
  %t4 = alloca { %Token*, i64 }
  %t5 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t4, i32 0, i32 0
  store %Token* %t3, %Token** %t5
  %t6 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  store { %Token*, i64 }* %t4, { %Token*, i64 }** %l1
  %t7 = load %Parser, %Parser* %l0
  store %Parser %t7, %Parser* %l2
  %t8 = sitofp i64 0 to double
  store double %t8, double* %l3
  %t9 = load %Parser, %Parser* %l0
  %t10 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t11 = load %Parser, %Parser* %l2
  %t12 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t98 = phi { %Token*, i64 }* [ %t10, %entry ], [ %t96, %loop.latch2 ]
  %t99 = phi %Parser [ %t11, %entry ], [ %t97, %loop.latch2 ]
  store { %Token*, i64 }* %t98, { %Token*, i64 }** %l1
  store %Parser %t99, %Parser* %l2
  br label %loop.body1
loop.body1:
  %t13 = load %Parser, %Parser* %l2
  %t14 = call %Token @parser_peek_raw(%Parser %t13)
  store %Token %t14, %Token* %l4
  %t15 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t16 = load %Token, %Token* %l4
  %t17 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t15, %Token %t16)
  store { %Token*, i64 }* %t17, { %Token*, i64 }** %l1
  %t18 = load %Token, %Token* %l4
  %t19 = extractvalue %Token %t18, 0
  %t20 = extractvalue %TokenKind %t19, 0
  %t21 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t22 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t23 = icmp eq i32 %t20, 0
  %t24 = select i1 %t23, i8* %t22, i8* %t21
  %t25 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t20, 1
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t20, 2
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %t31 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t32 = icmp eq i32 %t20, 3
  %t33 = select i1 %t32, i8* %t31, i8* %t30
  %t34 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t20, 4
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %t37 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t20, 5
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %t40 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t41 = icmp eq i32 %t20, 6
  %t42 = select i1 %t41, i8* %t40, i8* %t39
  %t43 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t44 = icmp eq i32 %t20, 7
  %t45 = select i1 %t44, i8* %t43, i8* %t42
  %s46 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.46, i32 0, i32 0
  %t47 = icmp eq i8* %t45, %s46
  %t48 = load %Parser, %Parser* %l0
  %t49 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t50 = load %Parser, %Parser* %l2
  %t51 = load double, double* %l3
  %t52 = load %Token, %Token* %l4
  br i1 %t47, label %then4, label %merge5
then4:
  %t53 = load %Token, %Token* %l4
  %t54 = extractvalue %Token %t53, 0
  %t55 = extractvalue %TokenKind %t54, 0
  store double 0.0, double* %l5
  %t56 = load double, double* %l5
  br label %merge5
merge5:
  %t57 = load %Token, %Token* %l4
  %t58 = extractvalue %Token %t57, 0
  %t59 = extractvalue %TokenKind %t58, 0
  %t60 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t61 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t59, 0
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t59, 1
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t59, 2
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t59, 3
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t59, 4
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %t76 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t59, 5
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %t79 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t59, 6
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t59, 7
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %s85 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.85, i32 0, i32 0
  %t86 = icmp eq i8* %t84, %s85
  %t87 = load %Parser, %Parser* %l0
  %t88 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t89 = load %Parser, %Parser* %l2
  %t90 = load double, double* %l3
  %t91 = load %Token, %Token* %l4
  br i1 %t86, label %then6, label %merge7
then6:
  %t92 = load %Parser, %Parser* %l2
  %t93 = call %Parser @parser_advance_raw(%Parser %t92)
  store %Parser %t93, %Parser* %l2
  br label %afterloop3
merge7:
  %t94 = load %Parser, %Parser* %l2
  %t95 = call %Parser @parser_advance_raw(%Parser %t94)
  store %Parser %t95, %Parser* %l2
  br label %loop.latch2
loop.latch2:
  %t96 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t97 = load %Parser, %Parser* %l2
  br label %loop.header0
afterloop3:
  %t100 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t101 = call i8* @tokens_to_text({ %Token*, i64 }* %t100)
  store i8* %t101, i8** %l6
  %t102 = alloca %Statement
  %t103 = getelementptr inbounds %Statement, %Statement* %t102, i32 0, i32 0
  store i32 22, i32* %t103
  %t104 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t105 = bitcast { %Token*, i64 }* %t104 to { %Token**, i64 }*
  %t106 = getelementptr inbounds %Statement, %Statement* %t102, i32 0, i32 1
  %t107 = bitcast [16 x i8]* %t106 to i8*
  %t108 = bitcast i8* %t107 to { %Token**, i64 }**
  store { %Token**, i64 }* %t105, { %Token**, i64 }** %t108
  %t109 = load i8*, i8** %l6
  %t110 = getelementptr inbounds %Statement, %Statement* %t102, i32 0, i32 1
  %t111 = bitcast [16 x i8]* %t110 to i8*
  %t112 = getelementptr inbounds i8, i8* %t111, i64 8
  %t113 = bitcast i8* %t112 to i8**
  store i8* %t109, i8** %t113
  %t114 = load %Statement, %Statement* %t102
  store %Statement %t114, %Statement* %l7
  %t115 = load %Parser, %Parser* %l2
  %t116 = call %Parser @skip_trivia(%Parser %t115)
  store %Parser %t116, %Parser* %l0
  %t117 = load %Parser, %Parser* %l0
  %t118 = insertvalue %StatementParseResult undef, %Parser %t117, 0
  %t119 = load %Statement, %Statement* %l7
  %t120 = insertvalue %StatementParseResult %t118, %Statement %t119, 1
  ret %StatementParseResult %t120
}

define i1 @identifier_matches(%Token %token, i8* %expected) {
entry:
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
  %s27 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.27, i32 0, i32 0
  %t28 = icmp ne i8* %t26, %s27
  br i1 %t28, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t29 = extractvalue %Token %token, 0
  %t30 = extractvalue %TokenKind %t29, 0
  %t31 = extractvalue %Token %token, 1
  %t32 = icmp eq i8* %t31, %expected
  ret i1 %t32
}

define i8* @identifier_text(%Token %token) {
entry:
  %l0 = alloca double
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
  %s27 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.27, i32 0, i32 0
  %t28 = icmp eq i8* %t26, %s27
  br i1 %t28, label %then0, label %merge1
then0:
  %t29 = extractvalue %Token %token, 0
  %t30 = extractvalue %TokenKind %t29, 0
  store double 0.0, double* %l0
  %t31 = load double, double* %l0
  br label %merge1
merge1:
  %t32 = extractvalue %Token %token, 1
  ret i8* %t32
}

define i8* @string_literal_value(%Token %token) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
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
  %s27 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.27, i32 0, i32 0
  %t28 = icmp eq i8* %t26, %s27
  br i1 %t28, label %then0, label %merge1
then0:
  %t29 = extractvalue %Token %token, 0
  %t30 = extractvalue %TokenKind %t29, 0
  store double 0.0, double* %l0
  %t31 = load double, double* %l0
  br label %merge1
merge1:
  %t32 = extractvalue %Token %token, 1
  store i8* %t32, i8** %l1
  %t33 = load i8*, i8** %l1
  %t34 = call i8* @strip_surrounding_quotes(i8* %t33)
  ret i8* %t34
}

define %Parser @skip_trivia(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token*
  store %Parser %parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  br label %loop.header0
loop.header0:
  %t29 = phi %Parser [ %t0, %entry ], [ %t28, %loop.latch2 ]
  store %Parser %t29, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t1 = load %Parser, %Parser* %l0
  %t2 = extractvalue %Parser %t1, 1
  %t3 = load %Parser, %Parser* %l0
  %t4 = extractvalue %Parser %t3, 0
  %t5 = load { %Token**, i64 }, { %Token**, i64 }* %t4
  %t6 = extractvalue { %Token**, i64 } %t5, 1
  %t7 = sitofp i64 %t6 to double
  %t8 = fcmp oge double %t2, %t7
  %t9 = load %Parser, %Parser* %l0
  br i1 %t8, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load %Parser, %Parser* %l0
  %t11 = extractvalue %Parser %t10, 0
  %t12 = load %Parser, %Parser* %l0
  %t13 = extractvalue %Parser %t12, 1
  %t14 = fptosi double %t13 to i64
  %t15 = load { %Token**, i64 }, { %Token**, i64 }* %t11
  %t16 = extractvalue { %Token**, i64 } %t15, 0
  %t17 = extractvalue { %Token**, i64 } %t15, 1
  %t18 = icmp uge i64 %t14, %t17
  ; bounds check: %t18 (if true, out of bounds)
  %t19 = getelementptr %Token*, %Token** %t16, i64 %t14
  %t20 = load %Token*, %Token** %t19
  store %Token* %t20, %Token** %l1
  %t21 = load %Token*, %Token** %l1
  %t22 = load %Token, %Token* %t21
  %t23 = call i1 @is_trivia_token(%Token %t22)
  %t24 = load %Parser, %Parser* %l0
  %t25 = load %Token*, %Token** %l1
  br i1 %t23, label %then6, label %merge7
then6:
  %t26 = load %Parser, %Parser* %l0
  %t27 = call %Parser @parser_advance_raw(%Parser %t26)
  store %Parser %t27, %Parser* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t28 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t30 = load %Parser, %Parser* %l0
  ret %Parser %t30
}

define %Token @parser_peek_raw(%Parser %parser) {
entry:
  %t0 = extractvalue %Parser %parser, 1
  %t1 = extractvalue %Parser %parser, 0
  %t2 = load { %Token**, i64 }, { %Token**, i64 }* %t1
  %t3 = extractvalue { %Token**, i64 } %t2, 1
  %t4 = sitofp i64 %t3 to double
  %t5 = fcmp oge double %t0, %t4
  br i1 %t5, label %then0, label %merge1
then0:
  ret %Token zeroinitializer
merge1:
  %t6 = extractvalue %Parser %parser, 0
  %t7 = extractvalue %Parser %parser, 1
  %t8 = fptosi double %t7 to i64
  %t9 = load { %Token**, i64 }, { %Token**, i64 }* %t6
  %t10 = extractvalue { %Token**, i64 } %t9, 0
  %t11 = extractvalue { %Token**, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  %t13 = getelementptr %Token*, %Token** %t10, i64 %t8
  %t14 = load %Token*, %Token** %t13
  %t15 = load %Token, %Token* %t14
  ret %Token %t15
}

define %Parser @parser_advance_raw(%Parser %parser) {
entry:
  %t0 = extractvalue %Parser %parser, 1
  %t1 = sitofp i64 1 to double
  %t2 = fadd double %t0, %t1
  %t3 = extractvalue %Parser %parser, 0
  %t4 = load { %Token**, i64 }, { %Token**, i64 }* %t3
  %t5 = extractvalue { %Token**, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp ogt double %t2, %t6
  br i1 %t7, label %then0, label %merge1
then0:
  ret %Parser %parser
merge1:
  ret %Parser zeroinitializer
}

define %Parser @consume_keyword(%Parser %initial_parser, i8* %keyword) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  %t1 = call %Parser @skip_trivia(%Parser %t0)
  store %Parser %t1, %Parser* %l0
  %t2 = load %Parser, %Parser* %l0
  %t3 = call %Token @parser_peek_raw(%Parser %t2)
  store %Token %t3, %Token* %l1
  %t4 = load %Token, %Token* %l1
  %t5 = call i1 @identifier_matches(%Token %t4, i8* %keyword)
  %t6 = load %Parser, %Parser* %l0
  %t7 = load %Token, %Token* %l1
  br i1 %t5, label %then0, label %merge1
then0:
  %t8 = load %Parser, %Parser* %l0
  %t9 = call %Parser @parser_advance_raw(%Parser %t8)
  ret %Parser %t9
merge1:
  %t10 = load %Parser, %Parser* %l0
  ret %Parser %t10
}

define %Parser @consume_symbol(%Parser %initial_parser, i8* %symbol) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  %t1 = call %Parser @skip_trivia(%Parser %t0)
  store %Parser %t1, %Parser* %l0
  %t2 = load %Parser, %Parser* %l0
  %t3 = call %Token @parser_peek_raw(%Parser %t2)
  store %Token %t3, %Token* %l1
  %t5 = load %Token, %Token* %l1
  %t6 = extractvalue %Token %t5, 0
  %t7 = extractvalue %TokenKind %t6, 0
  %t8 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t9 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t10 = icmp eq i32 %t7, 0
  %t11 = select i1 %t10, i8* %t9, i8* %t8
  %t12 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t13 = icmp eq i32 %t7, 1
  %t14 = select i1 %t13, i8* %t12, i8* %t11
  %t15 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t16 = icmp eq i32 %t7, 2
  %t17 = select i1 %t16, i8* %t15, i8* %t14
  %t18 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t19 = icmp eq i32 %t7, 3
  %t20 = select i1 %t19, i8* %t18, i8* %t17
  %t21 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t22 = icmp eq i32 %t7, 4
  %t23 = select i1 %t22, i8* %t21, i8* %t20
  %t24 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t7, 5
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %t27 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t28 = icmp eq i32 %t7, 6
  %t29 = select i1 %t28, i8* %t27, i8* %t26
  %t30 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t31 = icmp eq i32 %t7, 7
  %t32 = select i1 %t31, i8* %t30, i8* %t29
  %s33 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.33, i32 0, i32 0
  %t34 = icmp eq i8* %t32, %s33
  br label %logical_and_entry_4

logical_and_entry_4:
  br i1 %t34, label %logical_and_right_4, label %logical_and_merge_4

logical_and_right_4:
  %t35 = load %Token, %Token* %l1
  %t36 = extractvalue %Token %t35, 0
  %t37 = extractvalue %TokenKind %t36, 0
  %t38 = load %Parser, %Parser* %l0
  ret %Parser %t38
}

define %CaptureResult @collect_until(%Parser %parser, { i8**, i64 }* %terminators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca { %Token*, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca %Token
  %l6 = alloca i1
  %l7 = alloca double
  %l8 = alloca %Parser
  store %Parser %parser, %Parser* %l0
  %t0 = alloca [0 x %Token]
  %t1 = getelementptr [0 x %Token], [0 x %Token]* %t0, i32 0, i32 0
  %t2 = alloca { %Token*, i64 }
  %t3 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t2, i32 0, i32 0
  store %Token* %t1, %Token** %t3
  %t4 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Token*, i64 }* %t2, { %Token*, i64 }** %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l3
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l4
  %t8 = load %Parser, %Parser* %l0
  %t9 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t10 = load double, double* %l2
  %t11 = load double, double* %l3
  %t12 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t134 = phi { %Token*, i64 }* [ %t9, %entry ], [ %t132, %loop.latch2 ]
  %t135 = phi %Parser [ %t8, %entry ], [ %t133, %loop.latch2 ]
  store { %Token*, i64 }* %t134, { %Token*, i64 }** %l1
  store %Parser %t135, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t13 = load %Parser, %Parser* %l0
  %t14 = call %Token @parser_peek_raw(%Parser %t13)
  store %Token %t14, %Token* %l5
  %t15 = load %Token, %Token* %l5
  %t16 = extractvalue %Token %t15, 0
  %t17 = extractvalue %TokenKind %t16, 0
  %t18 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t19 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t20 = icmp eq i32 %t17, 0
  %t21 = select i1 %t20, i8* %t19, i8* %t18
  %t22 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t23 = icmp eq i32 %t17, 1
  %t24 = select i1 %t23, i8* %t22, i8* %t21
  %t25 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t17, 2
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t17, 3
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %t31 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t32 = icmp eq i32 %t17, 4
  %t33 = select i1 %t32, i8* %t31, i8* %t30
  %t34 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t17, 5
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %t37 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t17, 6
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %t40 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t41 = icmp eq i32 %t17, 7
  %t42 = select i1 %t41, i8* %t40, i8* %t39
  %s43 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.43, i32 0, i32 0
  %t44 = icmp eq i8* %t42, %s43
  %t45 = load %Parser, %Parser* %l0
  %t46 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t47 = load double, double* %l2
  %t48 = load double, double* %l3
  %t49 = load double, double* %l4
  %t50 = load %Token, %Token* %l5
  br i1 %t44, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t52 = load double, double* %l2
  %t53 = sitofp i64 0 to double
  %t54 = fcmp oeq double %t52, %t53
  br label %logical_and_entry_51

logical_and_entry_51:
  br i1 %t54, label %logical_and_right_51, label %logical_and_merge_51

logical_and_right_51:
  %t56 = load double, double* %l3
  %t57 = sitofp i64 0 to double
  %t58 = fcmp oeq double %t56, %t57
  br label %logical_and_entry_55

logical_and_entry_55:
  br i1 %t58, label %logical_and_right_55, label %logical_and_merge_55

logical_and_right_55:
  %t59 = load double, double* %l4
  %t60 = sitofp i64 0 to double
  %t61 = fcmp oeq double %t59, %t60
  br label %logical_and_right_end_55

logical_and_right_end_55:
  br label %logical_and_merge_55

logical_and_merge_55:
  %t62 = phi i1 [ false, %logical_and_entry_55 ], [ %t61, %logical_and_right_end_55 ]
  br label %logical_and_right_end_51

logical_and_right_end_51:
  br label %logical_and_merge_51

logical_and_merge_51:
  %t63 = phi i1 [ false, %logical_and_entry_51 ], [ %t62, %logical_and_right_end_51 ]
  store i1 %t63, i1* %l6
  %t64 = load i1, i1* %l6
  %t65 = load %Parser, %Parser* %l0
  %t66 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t67 = load double, double* %l2
  %t68 = load double, double* %l3
  %t69 = load double, double* %l4
  %t70 = load %Token, %Token* %l5
  %t71 = load i1, i1* %l6
  br i1 %t64, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t72 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t73 = load %Token, %Token* %l5
  %t74 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t72, %Token %t73)
  store { %Token*, i64 }* %t74, { %Token*, i64 }** %l1
  %t75 = load %Token, %Token* %l5
  %t76 = extractvalue %Token %t75, 0
  %t77 = extractvalue %TokenKind %t76, 0
  %t78 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t79 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t77, 0
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t77, 1
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %t85 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t77, 2
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t77, 3
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t77, 4
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t77, 5
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t77, 6
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %t100 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t77, 7
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %s103 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.103, i32 0, i32 0
  %t104 = icmp eq i8* %t102, %s103
  %t105 = load %Parser, %Parser* %l0
  %t106 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t107 = load double, double* %l2
  %t108 = load double, double* %l3
  %t109 = load double, double* %l4
  %t110 = load %Token, %Token* %l5
  %t111 = load i1, i1* %l6
  br i1 %t104, label %then8, label %merge9
then8:
  %t112 = load %Token, %Token* %l5
  %t113 = extractvalue %Token %t112, 0
  %t114 = extractvalue %TokenKind %t113, 0
  store double 0.0, double* %l7
  %t115 = load double, double* %l7
  br label %merge9
merge9:
  %t116 = load %Parser, %Parser* %l0
  %t117 = call %Parser @parser_advance_raw(%Parser %t116)
  store %Parser %t117, %Parser* %l8
  %t118 = load %Parser, %Parser* %l8
  %t119 = extractvalue %Parser %t118, 1
  %t120 = load %Parser, %Parser* %l0
  %t121 = extractvalue %Parser %t120, 1
  %t122 = fcmp oeq double %t119, %t121
  %t123 = load %Parser, %Parser* %l0
  %t124 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t125 = load double, double* %l2
  %t126 = load double, double* %l3
  %t127 = load double, double* %l4
  %t128 = load %Token, %Token* %l5
  %t129 = load i1, i1* %l6
  %t130 = load %Parser, %Parser* %l8
  br i1 %t122, label %then10, label %merge11
then10:
  br label %afterloop3
merge11:
  %t131 = load %Parser, %Parser* %l8
  store %Parser %t131, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t132 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t133 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t136 = load %Parser, %Parser* %l0
  %t137 = insertvalue %CaptureResult undef, %Parser %t136, 0
  %t138 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t139 = bitcast { %Token*, i64 }* %t138 to { %Token**, i64 }*
  %t140 = insertvalue %CaptureResult %t137, { %Token**, i64 }* %t139, 1
  ret %CaptureResult %t140
}

define %ParenthesizedParseResult @collect_parenthesized(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  %l2 = alloca { %Token*, i64 }*
  %l3 = alloca double
  %l4 = alloca %Token
  %l5 = alloca double
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Token @parser_peek_raw(%Parser %t1)
  store %Token %t2, %Token* %l1
  %t4 = load %Token, %Token* %l1
  %t5 = extractvalue %Token %t4, 0
  %t6 = extractvalue %TokenKind %t5, 0
  %t7 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t8 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t9 = icmp eq i32 %t6, 0
  %t10 = select i1 %t9, i8* %t8, i8* %t7
  %t11 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t12 = icmp eq i32 %t6, 1
  %t13 = select i1 %t12, i8* %t11, i8* %t10
  %t14 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t15 = icmp eq i32 %t6, 2
  %t16 = select i1 %t15, i8* %t14, i8* %t13
  %t17 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t6, 3
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t6, 4
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t6, 5
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t6, 6
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t6, 7
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %s32 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.32, i32 0, i32 0
  %t33 = icmp ne i8* %t31, %s32
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t33, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %t34 = load %Token, %Token* %l1
  %t35 = extractvalue %Token %t34, 0
  %t36 = extractvalue %TokenKind %t35, 0
  %t37 = load %Parser, %Parser* %l0
  %t38 = call %Parser @parser_advance_raw(%Parser %t37)
  store %Parser %t38, %Parser* %l0
  %t39 = alloca [0 x %Token]
  %t40 = getelementptr [0 x %Token], [0 x %Token]* %t39, i32 0, i32 0
  %t41 = alloca { %Token*, i64 }
  %t42 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t41, i32 0, i32 0
  store %Token* %t40, %Token** %t42
  %t43 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t41, i32 0, i32 1
  store i64 0, i64* %t43
  store { %Token*, i64 }* %t41, { %Token*, i64 }** %l2
  %t44 = sitofp i64 1 to double
  store double %t44, double* %l3
  %t45 = load %Parser, %Parser* %l0
  %t46 = load %Token, %Token* %l1
  %t47 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t48 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t140 = phi { %Token*, i64 }* [ %t47, %entry ], [ %t138, %loop.latch2 ]
  %t141 = phi %Parser [ %t45, %entry ], [ %t139, %loop.latch2 ]
  store { %Token*, i64 }* %t140, { %Token*, i64 }** %l2
  store %Parser %t141, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t49 = load %Parser, %Parser* %l0
  %t50 = call %Token @parser_peek_raw(%Parser %t49)
  store %Token %t50, %Token* %l4
  %t51 = load %Token, %Token* %l4
  %t52 = extractvalue %Token %t51, 0
  %t53 = extractvalue %TokenKind %t52, 0
  %t54 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t55 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t53, 0
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t53, 1
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t53, 2
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t53, 3
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t53, 4
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t53, 5
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t53, 6
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %t76 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t53, 7
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %s79 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.79, i32 0, i32 0
  %t80 = icmp eq i8* %t78, %s79
  %t81 = load %Parser, %Parser* %l0
  %t82 = load %Token, %Token* %l1
  %t83 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t84 = load double, double* %l3
  %t85 = load %Token, %Token* %l4
  br i1 %t80, label %then4, label %merge5
then4:
  %t86 = insertvalue %ParenthesizedParseResult undef, %Parser %parser, 0
  %t87 = alloca [0 x %Token*]
  %t88 = getelementptr [0 x %Token*], [0 x %Token*]* %t87, i32 0, i32 0
  %t89 = alloca { %Token**, i64 }
  %t90 = getelementptr { %Token**, i64 }, { %Token**, i64 }* %t89, i32 0, i32 0
  store %Token** %t88, %Token*** %t90
  %t91 = getelementptr { %Token**, i64 }, { %Token**, i64 }* %t89, i32 0, i32 1
  store i64 0, i64* %t91
  %t92 = insertvalue %ParenthesizedParseResult %t86, { %Token**, i64 }* %t89, 1
  %t93 = insertvalue %ParenthesizedParseResult %t92, i1 0, 2
  ret %ParenthesizedParseResult %t93
merge5:
  %t94 = load %Token, %Token* %l4
  %t95 = extractvalue %Token %t94, 0
  %t96 = extractvalue %TokenKind %t95, 0
  %t97 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t98 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t96, 0
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t96, 1
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t96, 2
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t96, 3
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t96, 4
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t96, 5
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %t116 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t96, 6
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %t119 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t96, 7
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %s122 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.122, i32 0, i32 0
  %t123 = icmp eq i8* %t121, %s122
  %t124 = load %Parser, %Parser* %l0
  %t125 = load %Token, %Token* %l1
  %t126 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t127 = load double, double* %l3
  %t128 = load %Token, %Token* %l4
  br i1 %t123, label %then6, label %merge7
then6:
  %t129 = load %Token, %Token* %l4
  %t130 = extractvalue %Token %t129, 0
  %t131 = extractvalue %TokenKind %t130, 0
  store double 0.0, double* %l5
  %t132 = load double, double* %l5
  br label %merge7
merge7:
  %t133 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t134 = load %Token, %Token* %l4
  %t135 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t133, %Token %t134)
  store { %Token*, i64 }* %t135, { %Token*, i64 }** %l2
  %t136 = load %Parser, %Parser* %l0
  %t137 = call %Parser @parser_advance_raw(%Parser %t136)
  store %Parser %t137, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t138 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t139 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t142 = load %Parser, %Parser* %l0
  %t143 = insertvalue %ParenthesizedParseResult undef, %Parser %t142, 0
  %t144 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t145 = bitcast { %Token*, i64 }* %t144 to { %Token**, i64 }*
  %t146 = insertvalue %ParenthesizedParseResult %t143, { %Token**, i64 }* %t145, 1
  %t147 = insertvalue %ParenthesizedParseResult %t146, i1 1, 2
  ret %ParenthesizedParseResult %t147
}

define %PatternCaptureResult @collect_pattern_until_arrow(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca { %Token*, i64 }*
  %l2 = alloca %Token
  %l3 = alloca double
  %l4 = alloca %Parser
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = alloca [0 x %Token]
  %t2 = getelementptr [0 x %Token], [0 x %Token]* %t1, i32 0, i32 0
  %t3 = alloca { %Token*, i64 }
  %t4 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t3, i32 0, i32 0
  store %Token* %t2, %Token** %t4
  %t5 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { %Token*, i64 }* %t3, { %Token*, i64 }** %l1
  %t6 = load %Parser, %Parser* %l0
  %t7 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t115 = phi { %Token*, i64 }* [ %t7, %entry ], [ %t113, %loop.latch2 ]
  %t116 = phi %Parser [ %t6, %entry ], [ %t114, %loop.latch2 ]
  store { %Token*, i64 }* %t115, { %Token*, i64 }** %l1
  store %Parser %t116, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t8 = load %Parser, %Parser* %l0
  %t9 = call %Token @parser_peek_raw(%Parser %t8)
  store %Token %t9, %Token* %l2
  %t10 = load %Token, %Token* %l2
  %t11 = extractvalue %Token %t10, 0
  %t12 = extractvalue %TokenKind %t11, 0
  %t13 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t14 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t15 = icmp eq i32 %t12, 0
  %t16 = select i1 %t15, i8* %t14, i8* %t13
  %t17 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t12, 1
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t12, 2
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t12, 3
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t12, 4
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t12, 5
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t12, 6
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t12, 7
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %s38 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.38, i32 0, i32 0
  %t39 = icmp eq i8* %t37, %s38
  %t40 = load %Parser, %Parser* %l0
  %t41 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t42 = load %Token, %Token* %l2
  br i1 %t39, label %then4, label %merge5
then4:
  %t43 = insertvalue %PatternCaptureResult undef, %Parser %parser, 0
  %t44 = alloca [0 x %Token*]
  %t45 = getelementptr [0 x %Token*], [0 x %Token*]* %t44, i32 0, i32 0
  %t46 = alloca { %Token**, i64 }
  %t47 = getelementptr { %Token**, i64 }, { %Token**, i64 }* %t46, i32 0, i32 0
  store %Token** %t45, %Token*** %t47
  %t48 = getelementptr { %Token**, i64 }, { %Token**, i64 }* %t46, i32 0, i32 1
  store i64 0, i64* %t48
  %t49 = insertvalue %PatternCaptureResult %t43, { %Token**, i64 }* %t46, 1
  %t50 = insertvalue %PatternCaptureResult %t49, i1 0, 2
  ret %PatternCaptureResult %t50
merge5:
  %t51 = load %Token, %Token* %l2
  %t52 = extractvalue %Token %t51, 0
  %t53 = extractvalue %TokenKind %t52, 0
  %t54 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t55 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t53, 0
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t53, 1
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t53, 2
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t53, 3
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t53, 4
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t53, 5
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t53, 6
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %t76 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t53, 7
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %s79 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.79, i32 0, i32 0
  %t80 = icmp eq i8* %t78, %s79
  %t81 = load %Parser, %Parser* %l0
  %t82 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t83 = load %Token, %Token* %l2
  br i1 %t80, label %then6, label %merge7
then6:
  %t84 = load %Token, %Token* %l2
  %t85 = extractvalue %Token %t84, 0
  %t86 = extractvalue %TokenKind %t85, 0
  store double 0.0, double* %l3
  %t88 = load double, double* %l3
  %s89 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.89, i32 0, i32 0
  br label %merge7
merge7:
  %t90 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t91 = load %Token, %Token* %l2
  %t92 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t90, %Token %t91)
  store { %Token*, i64 }* %t92, { %Token*, i64 }** %l1
  %t93 = load %Parser, %Parser* %l0
  %t94 = call %Parser @parser_advance_raw(%Parser %t93)
  store %Parser %t94, %Parser* %l4
  %t95 = load %Parser, %Parser* %l4
  %t96 = extractvalue %Parser %t95, 1
  %t97 = load %Parser, %Parser* %l0
  %t98 = extractvalue %Parser %t97, 1
  %t99 = fcmp oeq double %t96, %t98
  %t100 = load %Parser, %Parser* %l0
  %t101 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t102 = load %Token, %Token* %l2
  %t103 = load %Parser, %Parser* %l4
  br i1 %t99, label %then8, label %merge9
then8:
  %t104 = insertvalue %PatternCaptureResult undef, %Parser %parser, 0
  %t105 = alloca [0 x %Token*]
  %t106 = getelementptr [0 x %Token*], [0 x %Token*]* %t105, i32 0, i32 0
  %t107 = alloca { %Token**, i64 }
  %t108 = getelementptr { %Token**, i64 }, { %Token**, i64 }* %t107, i32 0, i32 0
  store %Token** %t106, %Token*** %t108
  %t109 = getelementptr { %Token**, i64 }, { %Token**, i64 }* %t107, i32 0, i32 1
  store i64 0, i64* %t109
  %t110 = insertvalue %PatternCaptureResult %t104, { %Token**, i64 }* %t107, 1
  %t111 = insertvalue %PatternCaptureResult %t110, i1 0, 2
  ret %PatternCaptureResult %t111
merge9:
  %t112 = load %Parser, %Parser* %l4
  store %Parser %t112, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t113 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t114 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t117 = load %Parser, %Parser* %l0
  %t118 = insertvalue %PatternCaptureResult undef, %Parser %t117, 0
  %t119 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t120 = bitcast { %Token*, i64 }* %t119 to { %Token**, i64 }*
  %t121 = insertvalue %PatternCaptureResult %t118, { %Token**, i64 }* %t120, 1
  %t122 = insertvalue %PatternCaptureResult %t121, i1 1, 2
  ret %PatternCaptureResult %t122
}

define %MatchCaseTokenSplit @split_match_case_tokens({ %Token*, i64 }* %tokens) {
entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca double
  %l2 = alloca { %Token*, i64 }*
  %l3 = alloca { %Token*, i64 }*
  %t0 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %tokens)
  store { %Token*, i64 }* %t0, { %Token*, i64 }** %l0
  %t1 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t2 = load { %Token*, i64 }, { %Token*, i64 }* %t1
  %t3 = extractvalue { %Token*, i64 } %t2, 1
  %t4 = icmp eq i64 %t3, 0
  %t5 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  br i1 %t4, label %then0, label %merge1
then0:
  %t6 = alloca [0 x %Token*]
  %t7 = getelementptr [0 x %Token*], [0 x %Token*]* %t6, i32 0, i32 0
  %t8 = alloca { %Token**, i64 }
  %t9 = getelementptr { %Token**, i64 }, { %Token**, i64 }* %t8, i32 0, i32 0
  store %Token** %t7, %Token*** %t9
  %t10 = getelementptr { %Token**, i64 }, { %Token**, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
  %t11 = insertvalue %MatchCaseTokenSplit undef, { %Token**, i64 }* %t8, 0
  %t12 = alloca [0 x %Token*]
  %t13 = getelementptr [0 x %Token*], [0 x %Token*]* %t12, i32 0, i32 0
  %t14 = alloca { %Token**, i64 }
  %t15 = getelementptr { %Token**, i64 }, { %Token**, i64 }* %t14, i32 0, i32 0
  store %Token** %t13, %Token*** %t15
  %t16 = getelementptr { %Token**, i64 }, { %Token**, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  %t17 = insertvalue %MatchCaseTokenSplit %t11, { %Token**, i64 }* %t14, 1
  %t18 = insertvalue %MatchCaseTokenSplit %t17, i1 0, 2
  ret %MatchCaseTokenSplit %t18
merge1:
  %t19 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %s20 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.20, i32 0, i32 0
  %t21 = call double @find_top_level_identifier({ %Token*, i64 }* %t19, i8* %s20)
  store double %t21, double* %l1
  %t22 = load double, double* %l1
  %t23 = sitofp i64 -1 to double
  %t24 = fcmp oeq double %t22, %t23
  %t25 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t26 = load double, double* %l1
  br i1 %t24, label %then2, label %merge3
then2:
  %t27 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t28 = bitcast { %Token*, i64 }* %t27 to { %Token**, i64 }*
  %t29 = insertvalue %MatchCaseTokenSplit undef, { %Token**, i64 }* %t28, 0
  %t30 = alloca [0 x %Token*]
  %t31 = getelementptr [0 x %Token*], [0 x %Token*]* %t30, i32 0, i32 0
  %t32 = alloca { %Token**, i64 }
  %t33 = getelementptr { %Token**, i64 }, { %Token**, i64 }* %t32, i32 0, i32 0
  store %Token** %t31, %Token*** %t33
  %t34 = getelementptr { %Token**, i64 }, { %Token**, i64 }* %t32, i32 0, i32 1
  store i64 0, i64* %t34
  %t35 = insertvalue %MatchCaseTokenSplit %t29, { %Token**, i64 }* %t32, 1
  %t36 = insertvalue %MatchCaseTokenSplit %t35, i1 0, 2
  ret %MatchCaseTokenSplit %t36
merge3:
  %t37 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t38 = load double, double* %l1
  %t39 = sitofp i64 0 to double
  %t40 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t37, double %t39, double %t38)
  %t41 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t40)
  store { %Token*, i64 }* %t41, { %Token*, i64 }** %l2
  %t42 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t43 = load double, double* %l1
  %t44 = sitofp i64 1 to double
  %t45 = fadd double %t43, %t44
  %t46 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t47 = load { %Token*, i64 }, { %Token*, i64 }* %t46
  %t48 = extractvalue { %Token*, i64 } %t47, 1
  %t49 = sitofp i64 %t48 to double
  %t50 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t42, double %t45, double %t49)
  %t51 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t50)
  store { %Token*, i64 }* %t51, { %Token*, i64 }** %l3
  %t52 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t53 = bitcast { %Token*, i64 }* %t52 to { %Token**, i64 }*
  %t54 = insertvalue %MatchCaseTokenSplit undef, { %Token**, i64 }* %t53, 0
  %t55 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t56 = bitcast { %Token*, i64 }* %t55 to { %Token**, i64 }*
  %t57 = insertvalue %MatchCaseTokenSplit %t54, { %Token**, i64 }* %t56, 1
  %t58 = insertvalue %MatchCaseTokenSplit %t57, i1 1, 2
  ret %MatchCaseTokenSplit %t58
}

define %Expression @normalize_expression({ %Token*, i64 }* %tokens, %Expression %expr) {
entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca %Token
  %l2 = alloca i8*
  %t0 = extractvalue %Expression %expr, 0
  %t1 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t2 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t3 = icmp eq i32 %t0, 0
  %t4 = select i1 %t3, i8* %t2, i8* %t1
  %t5 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t6 = icmp eq i32 %t0, 1
  %t7 = select i1 %t6, i8* %t5, i8* %t4
  %t8 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t9 = icmp eq i32 %t0, 2
  %t10 = select i1 %t9, i8* %t8, i8* %t7
  %t11 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t12 = icmp eq i32 %t0, 3
  %t13 = select i1 %t12, i8* %t11, i8* %t10
  %t14 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t15 = icmp eq i32 %t0, 4
  %t16 = select i1 %t15, i8* %t14, i8* %t13
  %t17 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t0, 5
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t0, 6
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t0, 7
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t0, 8
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t0, 9
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t0, 10
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t0, 11
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t0, 12
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t0, 13
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t0, 14
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t0, 15
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %s50 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.50, i32 0, i32 0
  %t51 = icmp eq i8* %t49, %s50
  br i1 %t51, label %then0, label %merge1
then0:
  %t52 = call { %Token*, i64 }* @filter_trivia({ %Token*, i64 }* %tokens)
  store { %Token*, i64 }* %t52, { %Token*, i64 }** %l0
  %t53 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t54 = load { %Token*, i64 }, { %Token*, i64 }* %t53
  %t55 = extractvalue { %Token*, i64 } %t54, 1
  %t56 = icmp eq i64 %t55, 1
  %t57 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  br i1 %t56, label %then2, label %merge3
then2:
  %t58 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t59 = load { %Token*, i64 }, { %Token*, i64 }* %t58
  %t60 = extractvalue { %Token*, i64 } %t59, 0
  %t61 = extractvalue { %Token*, i64 } %t59, 1
  %t62 = icmp uge i64 0, %t61
  ; bounds check: %t62 (if true, out of bounds)
  %t63 = getelementptr %Token, %Token* %t60, i64 0
  %t64 = load %Token, %Token* %t63
  store %Token %t64, %Token* %l1
  %t65 = load %Token, %Token* %l1
  %t66 = extractvalue %Token %t65, 0
  %t67 = extractvalue %TokenKind %t66, 0
  %t68 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t69 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t67, 0
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t67, 1
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t67, 2
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t67, 3
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %t81 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t67, 4
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t67, 5
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %t87 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t88 = icmp eq i32 %t67, 6
  %t89 = select i1 %t88, i8* %t87, i8* %t86
  %t90 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t91 = icmp eq i32 %t67, 7
  %t92 = select i1 %t91, i8* %t90, i8* %t89
  %s93 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.93, i32 0, i32 0
  %t94 = icmp eq i8* %t92, %s93
  %t95 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t96 = load %Token, %Token* %l1
  br i1 %t94, label %then4, label %merge5
then4:
  %t97 = alloca %Expression
  %t98 = getelementptr inbounds %Expression, %Expression* %t97, i32 0, i32 0
  store i32 2, i32* %t98
  %t99 = load %Token, %Token* %l1
  %t100 = extractvalue %Token %t99, 0
  %t101 = extractvalue %TokenKind %t100, 0
  %t102 = alloca %TokenKind
  store %TokenKind %t100, %TokenKind* %t102
  %t103 = getelementptr inbounds %TokenKind, %TokenKind* %t102, i32 0, i32 1
  %t104 = bitcast [8 x i8]* %t103 to i8*
  %t105 = bitcast i8* %t104 to i8**
  %t106 = load i8*, i8** %t105
  %t107 = icmp eq i32 %t101, 0
  %t108 = select i1 %t107, i8* %t106, i8* null
  %t109 = getelementptr inbounds %TokenKind, %TokenKind* %t102, i32 0, i32 1
  %t110 = bitcast [8 x i8]* %t109 to i8*
  %t111 = bitcast i8* %t110 to i8**
  %t112 = load i8*, i8** %t111
  %t113 = icmp eq i32 %t101, 1
  %t114 = select i1 %t113, i8* %t112, i8* %t108
  %t115 = getelementptr inbounds %TokenKind, %TokenKind* %t102, i32 0, i32 1
  %t116 = bitcast [8 x i8]* %t115 to i8*
  %t117 = bitcast i8* %t116 to i8**
  %t118 = load i8*, i8** %t117
  %t119 = icmp eq i32 %t101, 2
  %t120 = select i1 %t119, i8* %t118, i8* %t114
  %t121 = getelementptr inbounds %TokenKind, %TokenKind* %t102, i32 0, i32 1
  %t122 = bitcast [8 x i8]* %t121 to i8*
  %t123 = bitcast i8* %t122 to i8**
  %t124 = load i8*, i8** %t123
  %t125 = icmp eq i32 %t101, 4
  %t126 = select i1 %t125, i8* %t124, i8* %t120
  %t127 = getelementptr inbounds %Expression, %Expression* %t97, i32 0, i32 1
  %t128 = bitcast [8 x i8]* %t127 to i8*
  %t129 = bitcast i8* %t128 to i8**
  store i8* %t126, i8** %t129
  %t130 = load %Expression, %Expression* %t97
  ret %Expression %t130
merge5:
  %t131 = load %Token, %Token* %l1
  %t132 = extractvalue %Token %t131, 0
  %t133 = extractvalue %TokenKind %t132, 0
  %t134 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t135 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t133, 0
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t133, 1
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t133, 2
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t133, 3
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t133, 4
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t133, 5
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t133, 6
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t133, 7
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %s159 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.159, i32 0, i32 0
  %t160 = icmp eq i8* %t158, %s159
  %t161 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t162 = load %Token, %Token* %l1
  br i1 %t160, label %then6, label %merge7
then6:
  %t163 = alloca %Expression
  %t164 = getelementptr inbounds %Expression, %Expression* %t163, i32 0, i32 0
  store i32 3, i32* %t164
  %t165 = load %Token, %Token* %l1
  %t166 = extractvalue %Token %t165, 0
  %t167 = extractvalue %TokenKind %t166, 0
  %t168 = alloca %TokenKind
  store %TokenKind %t166, %TokenKind* %t168
  %t169 = getelementptr inbounds %TokenKind, %TokenKind* %t168, i32 0, i32 1
  %t170 = bitcast [1 x i8]* %t169 to i8*
  %t171 = bitcast i8* %t170 to i1*
  %t172 = load i1, i1* %t171
  %t173 = icmp eq i32 %t167, 3
  %t174 = select i1 %t173, i1 %t172, i1 false
  %t175 = getelementptr inbounds %Expression, %Expression* %t163, i32 0, i32 1
  %t176 = bitcast [1 x i8]* %t175 to i8*
  %t177 = bitcast i8* %t176 to i1*
  store i1 %t174, i1* %t177
  %t178 = load %Expression, %Expression* %t163
  ret %Expression %t178
merge7:
  %t179 = load %Token, %Token* %l1
  %t180 = extractvalue %Token %t179, 0
  %t181 = extractvalue %TokenKind %t180, 0
  %t182 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t183 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t184 = icmp eq i32 %t181, 0
  %t185 = select i1 %t184, i8* %t183, i8* %t182
  %t186 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t187 = icmp eq i32 %t181, 1
  %t188 = select i1 %t187, i8* %t186, i8* %t185
  %t189 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t190 = icmp eq i32 %t181, 2
  %t191 = select i1 %t190, i8* %t189, i8* %t188
  %t192 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t193 = icmp eq i32 %t181, 3
  %t194 = select i1 %t193, i8* %t192, i8* %t191
  %t195 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t196 = icmp eq i32 %t181, 4
  %t197 = select i1 %t196, i8* %t195, i8* %t194
  %t198 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t199 = icmp eq i32 %t181, 5
  %t200 = select i1 %t199, i8* %t198, i8* %t197
  %t201 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t202 = icmp eq i32 %t181, 6
  %t203 = select i1 %t202, i8* %t201, i8* %t200
  %t204 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t205 = icmp eq i32 %t181, 7
  %t206 = select i1 %t205, i8* %t204, i8* %t203
  %s207 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.207, i32 0, i32 0
  %t208 = icmp eq i8* %t206, %s207
  %t209 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t210 = load %Token, %Token* %l1
  br i1 %t208, label %then8, label %merge9
then8:
  %t211 = alloca %Expression
  %t212 = getelementptr inbounds %Expression, %Expression* %t211, i32 0, i32 0
  store i32 1, i32* %t212
  %t213 = load %Token, %Token* %l1
  %t214 = extractvalue %Token %t213, 0
  %t215 = extractvalue %TokenKind %t214, 0
  %t216 = alloca %TokenKind
  store %TokenKind %t214, %TokenKind* %t216
  %t217 = getelementptr inbounds %TokenKind, %TokenKind* %t216, i32 0, i32 1
  %t218 = bitcast [8 x i8]* %t217 to i8*
  %t219 = bitcast i8* %t218 to i8**
  %t220 = load i8*, i8** %t219
  %t221 = icmp eq i32 %t215, 0
  %t222 = select i1 %t221, i8* %t220, i8* null
  %t223 = getelementptr inbounds %TokenKind, %TokenKind* %t216, i32 0, i32 1
  %t224 = bitcast [8 x i8]* %t223 to i8*
  %t225 = bitcast i8* %t224 to i8**
  %t226 = load i8*, i8** %t225
  %t227 = icmp eq i32 %t215, 1
  %t228 = select i1 %t227, i8* %t226, i8* %t222
  %t229 = getelementptr inbounds %TokenKind, %TokenKind* %t216, i32 0, i32 1
  %t230 = bitcast [8 x i8]* %t229 to i8*
  %t231 = bitcast i8* %t230 to i8**
  %t232 = load i8*, i8** %t231
  %t233 = icmp eq i32 %t215, 2
  %t234 = select i1 %t233, i8* %t232, i8* %t228
  %t235 = getelementptr inbounds %TokenKind, %TokenKind* %t216, i32 0, i32 1
  %t236 = bitcast [8 x i8]* %t235 to i8*
  %t237 = bitcast i8* %t236 to i8**
  %t238 = load i8*, i8** %t237
  %t239 = icmp eq i32 %t215, 4
  %t240 = select i1 %t239, i8* %t238, i8* %t234
  %t241 = getelementptr inbounds %Expression, %Expression* %t211, i32 0, i32 1
  %t242 = bitcast [8 x i8]* %t241 to i8*
  %t243 = bitcast i8* %t242 to i8**
  store i8* %t240, i8** %t243
  %t244 = load %Expression, %Expression* %t211
  ret %Expression %t244
merge9:
  br label %merge3
merge3:
  %t245 = extractvalue %Expression %expr, 0
  %t246 = alloca %Expression
  store %Expression %expr, %Expression* %t246
  %t247 = getelementptr inbounds %Expression, %Expression* %t246, i32 0, i32 1
  %t248 = bitcast [8 x i8]* %t247 to i8*
  %t249 = bitcast i8* %t248 to i8**
  %t250 = load i8*, i8** %t249
  %t251 = icmp eq i32 %t245, 15
  %t252 = select i1 %t251, i8* %t250, i8* null
  %t253 = call i8* @trim_text(i8* %t252)
  store i8* %t253, i8** %l2
  %t255 = load i8*, i8** %l2
  %t256 = call i64 @sailfin_runtime_string_length(i8* %t255)
  %t257 = icmp sge i64 %t256, 2
  br label %logical_and_entry_254

logical_and_entry_254:
  br i1 %t257, label %logical_and_right_254, label %logical_and_merge_254

logical_and_right_254:
  %t259 = load i8*, i8** %l2
  %t260 = call double @char_at(i8* %t259, i64 0)
  %t261 = load i8*, i8** %l2
  %s262 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.262, i32 0, i32 0
  %t263 = icmp eq i8* %t261, %s262
  %t264 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t265 = load i8*, i8** %l2
  br i1 %t263, label %then10, label %merge11
then10:
  %t266 = alloca %Expression
  %t267 = getelementptr inbounds %Expression, %Expression* %t266, i32 0, i32 0
  store i32 3, i32* %t267
  %t268 = getelementptr inbounds %Expression, %Expression* %t266, i32 0, i32 1
  %t269 = bitcast [1 x i8]* %t268 to i8*
  %t270 = bitcast i8* %t269 to i1*
  store i1 1, i1* %t270
  %t271 = load %Expression, %Expression* %t266
  ret %Expression %t271
merge11:
  %t272 = load i8*, i8** %l2
  %s273 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.273, i32 0, i32 0
  %t274 = icmp eq i8* %t272, %s273
  %t275 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t276 = load i8*, i8** %l2
  br i1 %t274, label %then12, label %merge13
then12:
  %t277 = alloca %Expression
  %t278 = getelementptr inbounds %Expression, %Expression* %t277, i32 0, i32 0
  store i32 3, i32* %t278
  %t279 = getelementptr inbounds %Expression, %Expression* %t277, i32 0, i32 1
  %t280 = bitcast [1 x i8]* %t279 to i8*
  %t281 = bitcast i8* %t280 to i1*
  store i1 0, i1* %t281
  %t282 = load %Expression, %Expression* %t277
  ret %Expression %t282
merge13:
  %t283 = load i8*, i8** %l2
  %t284 = call i1 @looks_like_number(i8* %t283)
  %t285 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t286 = load i8*, i8** %l2
  br i1 %t284, label %then14, label %merge15
then14:
  %t287 = alloca %Expression
  %t288 = getelementptr inbounds %Expression, %Expression* %t287, i32 0, i32 0
  store i32 1, i32* %t288
  %t289 = load i8*, i8** %l2
  %t290 = getelementptr inbounds %Expression, %Expression* %t287, i32 0, i32 1
  %t291 = bitcast [8 x i8]* %t290 to i8*
  %t292 = bitcast i8* %t291 to i8**
  store i8* %t289, i8** %t292
  %t293 = load %Expression, %Expression* %t287
  ret %Expression %t293
merge15:
  br label %merge1
merge1:
  ret %Expression %expr
}

define i1 @looks_like_number(i8* %text) {
entry:
  %l0 = alloca i1
  %l1 = alloca double
  %l2 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  store i1 0, i1* %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  %t3 = call double @char_at(i8* %text, i64 0)
  %t4 = load i1, i1* %l0
  %t5 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t25 = phi double [ %t5, %entry ], [ %t24, %loop.latch4 ]
  store double %t25, double* %l1
  br label %loop.body3
loop.body3:
  %t6 = load double, double* %l1
  %t7 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t6, %t8
  %t10 = load i1, i1* %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t12 = load double, double* %l1
  %t13 = call double @char_at(i8* %text, double %t12)
  store double %t13, double* %l2
  %t14 = load double, double* %l2
  %t15 = load double, double* %l2
  %t16 = call i1 @sailfin_runtime_is_decimal_digit(i8* null)
  %t17 = xor i1 %t16, 1
  %t18 = load i1, i1* %l0
  %t19 = load double, double* %l1
  %t20 = load double, double* %l2
  br i1 %t17, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t21 = load double, double* %l1
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  store double %t23, double* %l1
  br label %loop.latch4
loop.latch4:
  %t24 = load double, double* %l1
  br label %loop.header2
afterloop5:
  ret i1 1
}

define i1 @is_decimal_digit(i8* %ch) {
entry:
  %t1 = load i8, i8* %ch
  %t2 = icmp eq i8 %t1, 48
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t2, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t4 = load i8, i8* %ch
  %t5 = icmp eq i8 %t4, 49
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t5, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %t7 = load i8, i8* %ch
  %t8 = icmp eq i8 %t7, 50
  br label %logical_or_entry_6

logical_or_entry_6:
  br i1 %t8, label %logical_or_merge_6, label %logical_or_right_6

logical_or_right_6:
  %t10 = load i8, i8* %ch
  %t11 = icmp eq i8 %t10, 51
  br label %logical_or_entry_9

logical_or_entry_9:
  br i1 %t11, label %logical_or_merge_9, label %logical_or_right_9

logical_or_right_9:
  %t13 = load i8, i8* %ch
  %t14 = icmp eq i8 %t13, 52
  br label %logical_or_entry_12

logical_or_entry_12:
  br i1 %t14, label %logical_or_merge_12, label %logical_or_right_12

logical_or_right_12:
  %t16 = load i8, i8* %ch
  %t17 = icmp eq i8 %t16, 53
  br label %logical_or_entry_15

logical_or_entry_15:
  br i1 %t17, label %logical_or_merge_15, label %logical_or_right_15

logical_or_right_15:
  %t19 = load i8, i8* %ch
  %t20 = icmp eq i8 %t19, 54
  br label %logical_or_entry_18

logical_or_entry_18:
  br i1 %t20, label %logical_or_merge_18, label %logical_or_right_18

logical_or_right_18:
  %t22 = load i8, i8* %ch
  %t23 = icmp eq i8 %t22, 55
  br label %logical_or_entry_21

logical_or_entry_21:
  br i1 %t23, label %logical_or_merge_21, label %logical_or_right_21

logical_or_right_21:
  %t25 = load i8, i8* %ch
  %t26 = icmp eq i8 %t25, 56
  br label %logical_or_entry_24

logical_or_entry_24:
  br i1 %t26, label %logical_or_merge_24, label %logical_or_right_24

logical_or_right_24:
  %t27 = load i8, i8* %ch
  %t28 = icmp eq i8 %t27, 57
  br label %logical_or_right_end_24

logical_or_right_end_24:
  br label %logical_or_merge_24

logical_or_merge_24:
  %t29 = phi i1 [ true, %logical_or_entry_24 ], [ %t28, %logical_or_right_end_24 ]
  br label %logical_or_right_end_21

logical_or_right_end_21:
  br label %logical_or_merge_21

logical_or_merge_21:
  %t30 = phi i1 [ true, %logical_or_entry_21 ], [ %t29, %logical_or_right_end_21 ]
  br label %logical_or_right_end_18

logical_or_right_end_18:
  br label %logical_or_merge_18

logical_or_merge_18:
  %t31 = phi i1 [ true, %logical_or_entry_18 ], [ %t30, %logical_or_right_end_18 ]
  br label %logical_or_right_end_15

logical_or_right_end_15:
  br label %logical_or_merge_15

logical_or_merge_15:
  %t32 = phi i1 [ true, %logical_or_entry_15 ], [ %t31, %logical_or_right_end_15 ]
  br label %logical_or_right_end_12

logical_or_right_end_12:
  br label %logical_or_merge_12

logical_or_merge_12:
  %t33 = phi i1 [ true, %logical_or_entry_12 ], [ %t32, %logical_or_right_end_12 ]
  br label %logical_or_right_end_9

logical_or_right_end_9:
  br label %logical_or_merge_9

logical_or_merge_9:
  %t34 = phi i1 [ true, %logical_or_entry_9 ], [ %t33, %logical_or_right_end_9 ]
  br label %logical_or_right_end_6

logical_or_right_end_6:
  br label %logical_or_merge_6

logical_or_merge_6:
  %t35 = phi i1 [ true, %logical_or_entry_6 ], [ %t34, %logical_or_right_end_6 ]
  br label %logical_or_right_end_3

logical_or_right_end_3:
  br label %logical_or_merge_3

logical_or_merge_3:
  %t36 = phi i1 [ true, %logical_or_entry_3 ], [ %t35, %logical_or_right_end_3 ]
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t37 = phi i1 [ true, %logical_or_entry_0 ], [ %t36, %logical_or_right_end_0 ]
  ret i1 %t37
}

define { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %tokens) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca %Token
  %l3 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t2 = extractvalue { %Token*, i64 } %t1, 1
  %t3 = sitofp i64 %t2 to double
  store double %t3, double* %l1
  %t4 = load double, double* %l0
  %t5 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t28 = phi double [ %t4, %entry ], [ %t27, %loop.latch2 ]
  store double %t28, double* %l0
  br label %loop.body1
loop.body1:
  %t6 = load double, double* %l0
  %t7 = load double, double* %l1
  %t8 = fcmp oge double %t6, %t7
  %t9 = load double, double* %l0
  %t10 = load double, double* %l1
  br i1 %t8, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t11 = load double, double* %l0
  %t12 = fptosi double %t11 to i64
  %t13 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t14 = extractvalue { %Token*, i64 } %t13, 0
  %t15 = extractvalue { %Token*, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  %t17 = getelementptr %Token, %Token* %t14, i64 %t12
  %t18 = load %Token, %Token* %t17
  store %Token %t18, %Token* %l2
  %t19 = load %Token, %Token* %l2
  %t20 = call i1 @is_trivia_token(%Token %t19)
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  %t23 = load %Token, %Token* %l2
  br i1 %t20, label %then6, label %merge7
then6:
  %t24 = load double, double* %l0
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t27 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t29 = load double, double* %l0
  %t30 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t45 = phi double [ %t30, %entry ], [ %t44, %loop.latch10 ]
  store double %t45, double* %l1
  br label %loop.body9
loop.body9:
  %t31 = load double, double* %l1
  %t32 = load double, double* %l0
  %t33 = fcmp ole double %t31, %t32
  %t34 = load double, double* %l0
  %t35 = load double, double* %l1
  br i1 %t33, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store double 0.0, double* %l3
  %t36 = load double, double* %l3
  %t37 = call i1 @is_trivia_token(%Token zeroinitializer)
  %t38 = load double, double* %l0
  %t39 = load double, double* %l1
  %t40 = load double, double* %l3
  br i1 %t37, label %then14, label %merge15
then14:
  %t41 = load double, double* %l1
  %t42 = sitofp i64 1 to double
  %t43 = fsub double %t41, %t42
  store double %t43, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t44 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t46 = load double, double* %l0
  %t47 = load double, double* %l1
  %t48 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %tokens, double %t46, double %t47)
  ret { %Token*, i64 }* %t48
}

define { %Token*, i64 }* @token_slice({ %Token*, i64 }* %tokens, double %start, double %end) {
entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca double
  %t0 = alloca [0 x %Token]
  %t1 = getelementptr [0 x %Token], [0 x %Token]* %t0, i32 0, i32 0
  %t2 = alloca { %Token*, i64 }
  %t3 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t2, i32 0, i32 0
  store %Token* %t1, %Token** %t3
  %t4 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Token*, i64 }* %t2, { %Token*, i64 }** %l0
  store double %start, double* %l1
  %t5 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t6 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t26 = phi { %Token*, i64 }* [ %t5, %entry ], [ %t24, %loop.latch2 ]
  %t27 = phi double [ %t6, %entry ], [ %t25, %loop.latch2 ]
  store { %Token*, i64 }* %t26, { %Token*, i64 }** %l0
  store double %t27, double* %l1
  br label %loop.body1
loop.body1:
  %t7 = load double, double* %l1
  %t8 = fcmp oge double %t7, %end
  %t9 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t10 = load double, double* %l1
  br i1 %t8, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t11 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t12 = load double, double* %l1
  %t13 = fptosi double %t12 to i64
  %t14 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t15 = extractvalue { %Token*, i64 } %t14, 0
  %t16 = extractvalue { %Token*, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  %t18 = getelementptr %Token, %Token* %t15, i64 %t13
  %t19 = load %Token, %Token* %t18
  %t20 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t11, %Token %t19)
  store { %Token*, i64 }* %t20, { %Token*, i64 }** %l0
  %t21 = load double, double* %l1
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  store double %t23, double* %l1
  br label %loop.latch2
loop.latch2:
  %t24 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t25 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t28 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  ret { %Token*, i64 }* %t28
}

define { %Token*, i64 }* @trim_block_tokens({ %Token*, i64 }* %tokens) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca %Token
  %l4 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t3 = extractvalue { %Token*, i64 } %t2, 1
  %t4 = sitofp i64 %t3 to double
  store double %t4, double* %l2
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  %t7 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t66 = phi double [ %t6, %entry ], [ %t65, %loop.latch2 ]
  store double %t66, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t10 = extractvalue { %Token*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load double, double* %l0
  %t14 = load double, double* %l1
  %t15 = load double, double* %l2
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t16 = load double, double* %l1
  %t17 = fptosi double %t16 to i64
  %t18 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t19 = extractvalue { %Token*, i64 } %t18, 0
  %t20 = extractvalue { %Token*, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  %t22 = getelementptr %Token, %Token* %t19, i64 %t17
  %t23 = load %Token, %Token* %t22
  store %Token %t23, %Token* %l3
  %t24 = load %Token, %Token* %l3
  %t25 = extractvalue %Token %t24, 0
  %t26 = extractvalue %TokenKind %t25, 0
  %t27 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t28 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t26, 0
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %t31 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t32 = icmp eq i32 %t26, 1
  %t33 = select i1 %t32, i8* %t31, i8* %t30
  %t34 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t26, 2
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %t37 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t26, 3
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %t40 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t41 = icmp eq i32 %t26, 4
  %t42 = select i1 %t41, i8* %t40, i8* %t39
  %t43 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t44 = icmp eq i32 %t26, 5
  %t45 = select i1 %t44, i8* %t43, i8* %t42
  %t46 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t47 = icmp eq i32 %t26, 6
  %t48 = select i1 %t47, i8* %t46, i8* %t45
  %t49 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t50 = icmp eq i32 %t26, 7
  %t51 = select i1 %t50, i8* %t49, i8* %t48
  %s52 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.52, i32 0, i32 0
  %t53 = icmp eq i8* %t51, %s52
  %t54 = load double, double* %l0
  %t55 = load double, double* %l1
  %t56 = load double, double* %l2
  %t57 = load %Token, %Token* %l3
  br i1 %t53, label %then6, label %merge7
then6:
  %t58 = load %Token, %Token* %l3
  %t59 = extractvalue %Token %t58, 0
  %t60 = extractvalue %TokenKind %t59, 0
  store double 0.0, double* %l4
  %t61 = load double, double* %l4
  br label %merge7
merge7:
  %t62 = load double, double* %l1
  %t63 = sitofp i64 1 to double
  %t64 = fadd double %t62, %t63
  store double %t64, double* %l1
  br label %loop.latch2
loop.latch2:
  %t65 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t67 = load double, double* %l2
  %t68 = sitofp i64 0 to double
  %t69 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %tokens, double %t68, double %t67)
  ret { %Token*, i64 }* %t69
}

define double @find_top_level_colon({ %Token*, i64 }* %tokens) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca %Token
  %l6 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l2
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l3
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l4
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  %t7 = load double, double* %l2
  %t8 = load double, double* %l3
  %t9 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t72 = phi double [ %t9, %entry ], [ %t71, %loop.latch2 ]
  store double %t72, double* %l4
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l4
  %t11 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t12 = extractvalue { %Token*, i64 } %t11, 1
  %t13 = sitofp i64 %t12 to double
  %t14 = fcmp oge double %t10, %t13
  %t15 = load double, double* %l0
  %t16 = load double, double* %l1
  %t17 = load double, double* %l2
  %t18 = load double, double* %l3
  %t19 = load double, double* %l4
  br i1 %t14, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t20 = load double, double* %l4
  %t21 = fptosi double %t20 to i64
  %t22 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t23 = extractvalue { %Token*, i64 } %t22, 0
  %t24 = extractvalue { %Token*, i64 } %t22, 1
  %t25 = icmp uge i64 %t21, %t24
  ; bounds check: %t25 (if true, out of bounds)
  %t26 = getelementptr %Token, %Token* %t23, i64 %t21
  %t27 = load %Token, %Token* %t26
  store %Token %t27, %Token* %l5
  %t28 = load %Token, %Token* %l5
  %t29 = extractvalue %Token %t28, 0
  %t30 = extractvalue %TokenKind %t29, 0
  %t31 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t32 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t30, 0
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t30, 1
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t30, 2
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t30, 3
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t30, 4
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t30, 5
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %t50 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t30, 6
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %t53 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t54 = icmp eq i32 %t30, 7
  %t55 = select i1 %t54, i8* %t53, i8* %t52
  %s56 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  %t57 = icmp eq i8* %t55, %s56
  %t58 = load double, double* %l0
  %t59 = load double, double* %l1
  %t60 = load double, double* %l2
  %t61 = load double, double* %l3
  %t62 = load double, double* %l4
  %t63 = load %Token, %Token* %l5
  br i1 %t57, label %then6, label %merge7
then6:
  %t64 = load %Token, %Token* %l5
  %t65 = extractvalue %Token %t64, 0
  %t66 = extractvalue %TokenKind %t65, 0
  store double 0.0, double* %l6
  %t67 = load double, double* %l6
  br label %merge7
merge7:
  %t68 = load double, double* %l4
  %t69 = sitofp i64 1 to double
  %t70 = fadd double %t68, %t69
  store double %t70, double* %l4
  br label %loop.latch2
loop.latch2:
  %t71 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t73 = sitofp i64 -1 to double
  ret double %t73
}

define %Expression @expression_from_tokens({ %Token*, i64 }* %tokens) {
entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca double
  %l2 = alloca %ExpressionTokens
  %l3 = alloca %ExpressionParseResult
  %t0 = call { %Token*, i64 }* @filter_trivia({ %Token*, i64 }* %tokens)
  store { %Token*, i64 }* %t0, { %Token*, i64 }** %l0
  %t1 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t2 = load { %Token*, i64 }, { %Token*, i64 }* %t1
  %t3 = extractvalue { %Token*, i64 } %t2, 1
  %t4 = icmp eq i64 %t3, 0
  %t5 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  br i1 %t4, label %then0, label %merge1
then0:
  %t6 = alloca %Expression
  %t7 = getelementptr inbounds %Expression, %Expression* %t6, i32 0, i32 0
  store i32 15, i32* %t7
  %s8 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.8, i32 0, i32 0
  %t9 = getelementptr inbounds %Expression, %Expression* %t6, i32 0, i32 1
  %t10 = bitcast [8 x i8]* %t9 to i8*
  %t11 = bitcast i8* %t10 to i8**
  store i8* %s8, i8** %t11
  %t12 = load %Expression, %Expression* %t6
  ret %Expression %t12
merge1:
  %t13 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t14 = load { %Token*, i64 }, { %Token*, i64 }* %t13
  %t15 = extractvalue { %Token*, i64 } %t14, 1
  %t16 = icmp eq i64 %t15, 1
  %t17 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  br i1 %t16, label %then2, label %merge3
then2:
  %t18 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t19 = load { %Token*, i64 }, { %Token*, i64 }* %t18
  %t20 = extractvalue { %Token*, i64 } %t19, 0
  %t21 = extractvalue { %Token*, i64 } %t19, 1
  %t22 = icmp uge i64 0, %t21
  ; bounds check: %t22 (if true, out of bounds)
  %t23 = getelementptr %Token, %Token* %t20, i64 0
  %t24 = load %Token, %Token* %t23
  %t25 = call double @expression_from_single_token(%Token %t24)
  store double %t25, double* %l1
  %t26 = load double, double* %l1
  br label %merge3
merge3:
  %t27 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t28 = bitcast { %Token*, i64 }* %t27 to { %Token**, i64 }*
  %t29 = insertvalue %ExpressionTokens undef, { %Token**, i64 }* %t28, 0
  %t30 = sitofp i64 0 to double
  %t31 = insertvalue %ExpressionTokens %t29, double %t30, 1
  store %ExpressionTokens %t31, %ExpressionTokens* %l2
  %t32 = load %ExpressionTokens, %ExpressionTokens* %l2
  %t33 = sitofp i64 0 to double
  %t34 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %t32, double %t33)
  store %ExpressionParseResult %t34, %ExpressionParseResult* %l3
  %t35 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  %t36 = extractvalue %ExpressionParseResult %t35, 2
  %t37 = xor i1 %t36, 1
  %t38 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t39 = load %ExpressionTokens, %ExpressionTokens* %l2
  %t40 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  br i1 %t37, label %then4, label %merge5
then4:
  %t41 = alloca %Expression
  %t42 = getelementptr inbounds %Expression, %Expression* %t41, i32 0, i32 0
  store i32 15, i32* %t42
  %t43 = call i8* @tokens_to_text({ %Token*, i64 }* %tokens)
  %t44 = call i8* @trim_text(i8* %t43)
  %t45 = getelementptr inbounds %Expression, %Expression* %t41, i32 0, i32 1
  %t46 = bitcast [8 x i8]* %t45 to i8*
  %t47 = bitcast i8* %t46 to i8**
  store i8* %t44, i8** %t47
  %t48 = load %Expression, %Expression* %t41
  ret %Expression %t48
merge5:
  %t49 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  %t50 = extractvalue %ExpressionParseResult %t49, 0
  %t51 = extractvalue %ExpressionTokens %t50, 1
  %t52 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  %t53 = extractvalue %ExpressionParseResult %t52, 0
  %t54 = extractvalue %ExpressionTokens %t53, 0
  %t55 = load { %Token**, i64 }, { %Token**, i64 }* %t54
  %t56 = extractvalue { %Token**, i64 } %t55, 1
  %t57 = sitofp i64 %t56 to double
  %t58 = fcmp une double %t51, %t57
  %t59 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t60 = load %ExpressionTokens, %ExpressionTokens* %l2
  %t61 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  br i1 %t58, label %then6, label %merge7
then6:
  %t62 = alloca %Expression
  %t63 = getelementptr inbounds %Expression, %Expression* %t62, i32 0, i32 0
  store i32 15, i32* %t63
  %t64 = call i8* @tokens_to_text({ %Token*, i64 }* %tokens)
  %t65 = call i8* @trim_text(i8* %t64)
  %t66 = getelementptr inbounds %Expression, %Expression* %t62, i32 0, i32 1
  %t67 = bitcast [8 x i8]* %t66 to i8*
  %t68 = bitcast i8* %t67 to i8**
  store i8* %t65, i8** %t68
  %t69 = load %Expression, %Expression* %t62
  ret %Expression %t69
merge7:
  %t70 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  %t71 = extractvalue %ExpressionParseResult %t70, 1
  ret %Expression %t71
}

define %ExpressionCollectResult @expression_tokens_collect_until(%ExpressionTokens %state, { i8**, i64 }* %terminators) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca { %Token*, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca %Token
  %l7 = alloca i1
  %l8 = alloca double
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  %t0 = alloca [0 x %Token]
  %t1 = getelementptr [0 x %Token], [0 x %Token]* %t0, i32 0, i32 0
  %t2 = alloca { %Token*, i64 }
  %t3 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t2, i32 0, i32 0
  store %Token* %t1, %Token** %t3
  %t4 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Token*, i64 }* %t2, { %Token*, i64 }** %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l3
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l4
  %t8 = sitofp i64 0 to double
  store double %t8, double* %l5
  %t9 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t10 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t11 = load double, double* %l2
  %t12 = load double, double* %l3
  %t13 = load double, double* %l4
  %t14 = load double, double* %l5
  br label %loop.header0
loop.header0:
  %t134 = phi { %Token*, i64 }* [ %t10, %entry ], [ %t132, %loop.latch2 ]
  %t135 = phi %ExpressionTokens [ %t9, %entry ], [ %t133, %loop.latch2 ]
  store { %Token*, i64 }* %t134, { %Token*, i64 }** %l1
  store %ExpressionTokens %t135, %ExpressionTokens* %l0
  br label %loop.body1
loop.body1:
  %t15 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t16 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t15)
  %t17 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t18 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t19 = load double, double* %l2
  %t20 = load double, double* %l3
  %t21 = load double, double* %l4
  %t22 = load double, double* %l5
  br i1 %t16, label %then4, label %merge5
then4:
  %t23 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t24 = insertvalue %ExpressionCollectResult undef, %ExpressionTokens %t23, 0
  %t25 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t26 = bitcast { %Token*, i64 }* %t25 to { %Token**, i64 }*
  %t27 = insertvalue %ExpressionCollectResult %t24, { %Token**, i64 }* %t26, 1
  %t28 = insertvalue %ExpressionCollectResult %t27, i1 0, 2
  ret %ExpressionCollectResult %t28
merge5:
  %t29 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t30 = call %Token @expression_tokens_peek(%ExpressionTokens %t29)
  store %Token %t30, %Token* %l6
  %t32 = load double, double* %l2
  %t33 = sitofp i64 0 to double
  %t34 = fcmp oeq double %t32, %t33
  br label %logical_and_entry_31

logical_and_entry_31:
  br i1 %t34, label %logical_and_right_31, label %logical_and_merge_31

logical_and_right_31:
  %t36 = load double, double* %l3
  %t37 = sitofp i64 0 to double
  %t38 = fcmp oeq double %t36, %t37
  br label %logical_and_entry_35

logical_and_entry_35:
  br i1 %t38, label %logical_and_right_35, label %logical_and_merge_35

logical_and_right_35:
  %t40 = load double, double* %l4
  %t41 = sitofp i64 0 to double
  %t42 = fcmp oeq double %t40, %t41
  br label %logical_and_entry_39

logical_and_entry_39:
  br i1 %t42, label %logical_and_right_39, label %logical_and_merge_39

logical_and_right_39:
  %t43 = load double, double* %l5
  %t44 = sitofp i64 0 to double
  %t45 = fcmp oeq double %t43, %t44
  br label %logical_and_right_end_39

logical_and_right_end_39:
  br label %logical_and_merge_39

logical_and_merge_39:
  %t46 = phi i1 [ false, %logical_and_entry_39 ], [ %t45, %logical_and_right_end_39 ]
  br label %logical_and_right_end_35

logical_and_right_end_35:
  br label %logical_and_merge_35

logical_and_merge_35:
  %t47 = phi i1 [ false, %logical_and_entry_35 ], [ %t46, %logical_and_right_end_35 ]
  br label %logical_and_right_end_31

logical_and_right_end_31:
  br label %logical_and_merge_31

logical_and_merge_31:
  %t48 = phi i1 [ false, %logical_and_entry_31 ], [ %t47, %logical_and_right_end_31 ]
  store i1 %t48, i1* %l7
  %t50 = load i1, i1* %l7
  br label %logical_and_entry_49

logical_and_entry_49:
  br i1 %t50, label %logical_and_right_49, label %logical_and_merge_49

logical_and_right_49:
  %t52 = load %Token, %Token* %l6
  %t53 = extractvalue %Token %t52, 0
  %t54 = extractvalue %TokenKind %t53, 0
  %t55 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t56 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t57 = icmp eq i32 %t54, 0
  %t58 = select i1 %t57, i8* %t56, i8* %t55
  %t59 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t60 = icmp eq i32 %t54, 1
  %t61 = select i1 %t60, i8* %t59, i8* %t58
  %t62 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t54, 2
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t54, 3
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t54, 4
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t54, 5
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t75 = icmp eq i32 %t54, 6
  %t76 = select i1 %t75, i8* %t74, i8* %t73
  %t77 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t78 = icmp eq i32 %t54, 7
  %t79 = select i1 %t78, i8* %t77, i8* %t76
  %s80 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.80, i32 0, i32 0
  %t81 = icmp eq i8* %t79, %s80
  br label %logical_and_entry_51

logical_and_entry_51:
  br i1 %t81, label %logical_and_right_51, label %logical_and_merge_51

logical_and_right_51:
  %t82 = load %Token, %Token* %l6
  %t83 = extractvalue %Token %t82, 0
  %t84 = extractvalue %TokenKind %t83, 0
  %t85 = load %Token, %Token* %l6
  %t86 = extractvalue %Token %t85, 0
  %t87 = extractvalue %TokenKind %t86, 0
  %t88 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t89 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t90 = icmp eq i32 %t87, 0
  %t91 = select i1 %t90, i8* %t89, i8* %t88
  %t92 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t93 = icmp eq i32 %t87, 1
  %t94 = select i1 %t93, i8* %t92, i8* %t91
  %t95 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t87, 2
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %t98 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t87, 3
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t87, 4
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t87, 5
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t87, 6
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t87, 7
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %s113 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.113, i32 0, i32 0
  %t114 = icmp eq i8* %t112, %s113
  %t115 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t116 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t117 = load double, double* %l2
  %t118 = load double, double* %l3
  %t119 = load double, double* %l4
  %t120 = load double, double* %l5
  %t121 = load %Token, %Token* %l6
  %t122 = load i1, i1* %l7
  br i1 %t114, label %then6, label %merge7
then6:
  %t123 = load %Token, %Token* %l6
  %t124 = extractvalue %Token %t123, 0
  %t125 = extractvalue %TokenKind %t124, 0
  store double 0.0, double* %l8
  %t126 = load double, double* %l8
  br label %merge7
merge7:
  %t127 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t128 = load %Token, %Token* %l6
  %t129 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t127, %Token %t128)
  store { %Token*, i64 }* %t129, { %Token*, i64 }** %l1
  %t130 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t131 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t130)
  store %ExpressionTokens %t131, %ExpressionTokens* %l0
  br label %loop.latch2
loop.latch2:
  %t132 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t133 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header0
afterloop3:
  %t136 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t137 = insertvalue %ExpressionCollectResult undef, %ExpressionTokens %t136, 0
  %t138 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t139 = bitcast { %Token*, i64 }* %t138 to { %Token**, i64 }*
  %t140 = insertvalue %ExpressionCollectResult %t137, { %Token**, i64 }* %t139, 1
  %t141 = insertvalue %ExpressionCollectResult %t140, i1 1, 2
  ret %ExpressionCollectResult %t141
}

define %ExpressionBlockParseResult @collect_expression_block(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca %Token
  %l2 = alloca { %Token*, i64 }*
  %l3 = alloca double
  %l4 = alloca %Token
  %l5 = alloca double
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  %t0 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t1 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t0)
  %t2 = load %ExpressionTokens, %ExpressionTokens* %l0
  br i1 %t1, label %then0, label %merge1
then0:
  %t3 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t4 = insertvalue %ExpressionBlockParseResult undef, %ExpressionTokens %t3, 0
  %t5 = alloca [0 x %Token*]
  %t6 = getelementptr [0 x %Token*], [0 x %Token*]* %t5, i32 0, i32 0
  %t7 = alloca { %Token**, i64 }
  %t8 = getelementptr { %Token**, i64 }, { %Token**, i64 }* %t7, i32 0, i32 0
  store %Token** %t6, %Token*** %t8
  %t9 = getelementptr { %Token**, i64 }, { %Token**, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  %t10 = insertvalue %ExpressionBlockParseResult %t4, { %Token**, i64 }* %t7, 1
  %t11 = insertvalue %ExpressionBlockParseResult %t10, i1 0, 2
  ret %ExpressionBlockParseResult %t11
merge1:
  %t12 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t13 = call %Token @expression_tokens_peek(%ExpressionTokens %t12)
  store %Token %t13, %Token* %l1
  %t15 = load %Token, %Token* %l1
  %t16 = extractvalue %Token %t15, 0
  %t17 = extractvalue %TokenKind %t16, 0
  %t18 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t19 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t20 = icmp eq i32 %t17, 0
  %t21 = select i1 %t20, i8* %t19, i8* %t18
  %t22 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t23 = icmp eq i32 %t17, 1
  %t24 = select i1 %t23, i8* %t22, i8* %t21
  %t25 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t17, 2
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t17, 3
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %t31 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t32 = icmp eq i32 %t17, 4
  %t33 = select i1 %t32, i8* %t31, i8* %t30
  %t34 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t17, 5
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %t37 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t17, 6
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %t40 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t41 = icmp eq i32 %t17, 7
  %t42 = select i1 %t41, i8* %t40, i8* %t39
  %s43 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.43, i32 0, i32 0
  %t44 = icmp ne i8* %t42, %s43
  br label %logical_or_entry_14

logical_or_entry_14:
  br i1 %t44, label %logical_or_merge_14, label %logical_or_right_14

logical_or_right_14:
  %t45 = load %Token, %Token* %l1
  %t46 = extractvalue %Token %t45, 0
  %t47 = extractvalue %TokenKind %t46, 0
  %t48 = alloca [0 x %Token]
  %t49 = getelementptr [0 x %Token], [0 x %Token]* %t48, i32 0, i32 0
  %t50 = alloca { %Token*, i64 }
  %t51 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t50, i32 0, i32 0
  store %Token* %t49, %Token** %t51
  %t52 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t50, i32 0, i32 1
  store i64 0, i64* %t52
  store { %Token*, i64 }* %t50, { %Token*, i64 }** %l2
  %t53 = sitofp i64 0 to double
  store double %t53, double* %l3
  %t54 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t55 = load %Token, %Token* %l1
  %t56 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t57 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t118 = phi { %Token*, i64 }* [ %t56, %entry ], [ %t116, %loop.latch4 ]
  %t119 = phi %ExpressionTokens [ %t54, %entry ], [ %t117, %loop.latch4 ]
  store { %Token*, i64 }* %t118, { %Token*, i64 }** %l2
  store %ExpressionTokens %t119, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t58 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t59 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t58)
  %t60 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t61 = load %Token, %Token* %l1
  %t62 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t63 = load double, double* %l3
  br i1 %t59, label %then6, label %merge7
then6:
  %t64 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t65 = insertvalue %ExpressionBlockParseResult undef, %ExpressionTokens %t64, 0
  %t66 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t67 = bitcast { %Token*, i64 }* %t66 to { %Token**, i64 }*
  %t68 = insertvalue %ExpressionBlockParseResult %t65, { %Token**, i64 }* %t67, 1
  %t69 = insertvalue %ExpressionBlockParseResult %t68, i1 0, 2
  ret %ExpressionBlockParseResult %t69
merge7:
  %t70 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t71 = call %Token @expression_tokens_peek(%ExpressionTokens %t70)
  store %Token %t71, %Token* %l4
  %t72 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t73 = load %Token, %Token* %l4
  %t74 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t72, %Token %t73)
  store { %Token*, i64 }* %t74, { %Token*, i64 }** %l2
  %t75 = load %Token, %Token* %l4
  %t76 = extractvalue %Token %t75, 0
  %t77 = extractvalue %TokenKind %t76, 0
  %t78 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t79 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t77, 0
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t77, 1
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %t85 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t77, 2
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t77, 3
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t77, 4
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t77, 5
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t77, 6
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %t100 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t77, 7
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %s103 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.103, i32 0, i32 0
  %t104 = icmp eq i8* %t102, %s103
  %t105 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t106 = load %Token, %Token* %l1
  %t107 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t108 = load double, double* %l3
  %t109 = load %Token, %Token* %l4
  br i1 %t104, label %then8, label %merge9
then8:
  %t110 = load %Token, %Token* %l4
  %t111 = extractvalue %Token %t110, 0
  %t112 = extractvalue %TokenKind %t111, 0
  store double 0.0, double* %l5
  %t113 = load double, double* %l5
  br label %merge9
merge9:
  %t114 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t115 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t114)
  store %ExpressionTokens %t115, %ExpressionTokens* %l0
  br label %loop.latch4
loop.latch4:
  %t116 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t117 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t120 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t121 = insertvalue %ExpressionBlockParseResult undef, %ExpressionTokens %t120, 0
  %t122 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t123 = bitcast { %Token*, i64 }* %t122 to { %Token**, i64 }*
  %t124 = insertvalue %ExpressionBlockParseResult %t121, { %Token**, i64 }* %t123, 1
  %t125 = insertvalue %ExpressionBlockParseResult %t124, i1 1, 2
  ret %ExpressionBlockParseResult %t125
}

define %LambdaParameterParseResult @parse_lambda_parameter(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca %Token
  %l4 = alloca %Token
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca %Token
  %l8 = alloca i8*
  %l9 = alloca %Token
  %l10 = alloca { %Token*, i64 }*
  %l11 = alloca double
  %l12 = alloca %Parameter
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  %t0 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t1 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t0)
  %t2 = load %ExpressionTokens, %ExpressionTokens* %l0
  br i1 %t1, label %then0, label %merge1
then0:
  %t3 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t4 = insertvalue %LambdaParameterParseResult undef, %ExpressionTokens %t3, 0
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.5, i32 0, i32 0
  %t6 = insertvalue %Parameter undef, i8* %s5, 0
  %t7 = bitcast i8* null to %TypeAnnotation*
  %t8 = insertvalue %Parameter %t6, %TypeAnnotation* %t7, 1
  %t9 = bitcast i8* null to %Expression*
  %t10 = insertvalue %Parameter %t8, %Expression* %t9, 2
  %t11 = insertvalue %Parameter %t10, i1 0, 3
  %t12 = bitcast i8* null to %SourceSpan*
  %t13 = insertvalue %Parameter %t11, %SourceSpan* %t12, 4
  %t14 = insertvalue %LambdaParameterParseResult %t4, %Parameter %t13, 1
  %t15 = insertvalue %LambdaParameterParseResult %t14, i1 0, 2
  ret %LambdaParameterParseResult %t15
merge1:
  %t16 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t17 = extractvalue %ExpressionTokens %t16, 1
  store double %t17, double* %l1
  store i1 0, i1* %l2
  %t18 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t19 = call %Token @expression_tokens_peek(%ExpressionTokens %t18)
  store %Token %t19, %Token* %l3
  %t21 = load %Token, %Token* %l3
  %t22 = extractvalue %Token %t21, 0
  %t23 = extractvalue %TokenKind %t22, 0
  %t24 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t25 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t23, 0
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t23, 1
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %t31 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t32 = icmp eq i32 %t23, 2
  %t33 = select i1 %t32, i8* %t31, i8* %t30
  %t34 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t23, 3
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %t37 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t23, 4
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %t40 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t41 = icmp eq i32 %t23, 5
  %t42 = select i1 %t41, i8* %t40, i8* %t39
  %t43 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t44 = icmp eq i32 %t23, 6
  %t45 = select i1 %t44, i8* %t43, i8* %t42
  %t46 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t47 = icmp eq i32 %t23, 7
  %t48 = select i1 %t47, i8* %t46, i8* %t45
  %s49 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.49, i32 0, i32 0
  %t50 = icmp eq i8* %t48, %s49
  br label %logical_and_entry_20

logical_and_entry_20:
  br i1 %t50, label %logical_and_right_20, label %logical_and_merge_20

logical_and_right_20:
  %t51 = load %Token, %Token* %l3
  %s52 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.52, i32 0, i32 0
  %t53 = call i1 @identifier_matches(%Token %t51, i8* %s52)
  br label %logical_and_right_end_20

logical_and_right_end_20:
  br label %logical_and_merge_20

logical_and_merge_20:
  %t54 = phi i1 [ false, %logical_and_entry_20 ], [ %t53, %logical_and_right_end_20 ]
  %t55 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t56 = load double, double* %l1
  %t57 = load i1, i1* %l2
  %t58 = load %Token, %Token* %l3
  br i1 %t54, label %then2, label %merge3
then2:
  store i1 1, i1* %l2
  %t59 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t60 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t59)
  store %ExpressionTokens %t60, %ExpressionTokens* %l0
  %t61 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t62 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t61)
  %t63 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t64 = load double, double* %l1
  %t65 = load i1, i1* %l2
  %t66 = load %Token, %Token* %l3
  br i1 %t62, label %then4, label %merge5
then4:
  %t67 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t68 = insertvalue %LambdaParameterParseResult undef, %ExpressionTokens %t67, 0
  %s69 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.69, i32 0, i32 0
  %t70 = insertvalue %Parameter undef, i8* %s69, 0
  %t71 = bitcast i8* null to %TypeAnnotation*
  %t72 = insertvalue %Parameter %t70, %TypeAnnotation* %t71, 1
  %t73 = bitcast i8* null to %Expression*
  %t74 = insertvalue %Parameter %t72, %Expression* %t73, 2
  %t75 = insertvalue %Parameter %t74, i1 0, 3
  %t76 = bitcast i8* null to %SourceSpan*
  %t77 = insertvalue %Parameter %t75, %SourceSpan* %t76, 4
  %t78 = insertvalue %LambdaParameterParseResult %t68, %Parameter %t77, 1
  %t79 = insertvalue %LambdaParameterParseResult %t78, i1 0, 2
  ret %LambdaParameterParseResult %t79
merge5:
  br label %merge3
merge3:
  %t80 = phi i1 [ 1, %then2 ], [ %t57, %entry ]
  %t81 = phi %ExpressionTokens [ %t60, %then2 ], [ %t55, %entry ]
  store i1 %t80, i1* %l2
  store %ExpressionTokens %t81, %ExpressionTokens* %l0
  %t82 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t83 = call %Token @expression_tokens_peek(%ExpressionTokens %t82)
  store %Token %t83, %Token* %l4
  %t84 = load %Token, %Token* %l4
  %t85 = extractvalue %Token %t84, 0
  %t86 = extractvalue %TokenKind %t85, 0
  %t87 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t88 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t86, 0
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t86, 1
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t86, 2
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t86, 3
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %t100 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t86, 4
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %t103 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t104 = icmp eq i32 %t86, 5
  %t105 = select i1 %t104, i8* %t103, i8* %t102
  %t106 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t107 = icmp eq i32 %t86, 6
  %t108 = select i1 %t107, i8* %t106, i8* %t105
  %t109 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t110 = icmp eq i32 %t86, 7
  %t111 = select i1 %t110, i8* %t109, i8* %t108
  %s112 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.112, i32 0, i32 0
  %t113 = icmp ne i8* %t111, %s112
  %t114 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t115 = load double, double* %l1
  %t116 = load i1, i1* %l2
  %t117 = load %Token, %Token* %l3
  %t118 = load %Token, %Token* %l4
  br i1 %t113, label %then6, label %merge7
then6:
  %t119 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t120 = insertvalue %LambdaParameterParseResult undef, %ExpressionTokens %t119, 0
  %s121 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.121, i32 0, i32 0
  %t122 = insertvalue %Parameter undef, i8* %s121, 0
  %t123 = bitcast i8* null to %TypeAnnotation*
  %t124 = insertvalue %Parameter %t122, %TypeAnnotation* %t123, 1
  %t125 = bitcast i8* null to %Expression*
  %t126 = insertvalue %Parameter %t124, %Expression* %t125, 2
  %t127 = insertvalue %Parameter %t126, i1 0, 3
  %t128 = bitcast i8* null to %SourceSpan*
  %t129 = insertvalue %Parameter %t127, %SourceSpan* %t128, 4
  %t130 = insertvalue %LambdaParameterParseResult %t120, %Parameter %t129, 1
  %t131 = insertvalue %LambdaParameterParseResult %t130, i1 0, 2
  ret %LambdaParameterParseResult %t131
merge7:
  %t132 = load %Token, %Token* %l4
  %t133 = call i8* @identifier_text(%Token %t132)
  store i8* %t133, i8** %l5
  %t134 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t135 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t134)
  store %ExpressionTokens %t135, %ExpressionTokens* %l0
  store i8* null, i8** %l6
  %t136 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t137 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t136)
  %t138 = xor i1 %t137, 1
  %t139 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t140 = load double, double* %l1
  %t141 = load i1, i1* %l2
  %t142 = load %Token, %Token* %l3
  %t143 = load %Token, %Token* %l4
  %t144 = load i8*, i8** %l5
  %t145 = load i8*, i8** %l6
  br i1 %t138, label %then8, label %merge9
then8:
  %t146 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t147 = call %Token @expression_tokens_peek(%ExpressionTokens %t146)
  store %Token %t147, %Token* %l7
  %t150 = load %Token, %Token* %l7
  %t151 = extractvalue %Token %t150, 0
  %t152 = extractvalue %TokenKind %t151, 0
  %t153 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t154 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t152, 0
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t152, 1
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %t160 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t161 = icmp eq i32 %t152, 2
  %t162 = select i1 %t161, i8* %t160, i8* %t159
  %t163 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t164 = icmp eq i32 %t152, 3
  %t165 = select i1 %t164, i8* %t163, i8* %t162
  %t166 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t167 = icmp eq i32 %t152, 4
  %t168 = select i1 %t167, i8* %t166, i8* %t165
  %t169 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t170 = icmp eq i32 %t152, 5
  %t171 = select i1 %t170, i8* %t169, i8* %t168
  %t172 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t173 = icmp eq i32 %t152, 6
  %t174 = select i1 %t173, i8* %t172, i8* %t171
  %t175 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t176 = icmp eq i32 %t152, 7
  %t177 = select i1 %t176, i8* %t175, i8* %t174
  %s178 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.178, i32 0, i32 0
  %t179 = icmp eq i8* %t177, %s178
  br label %logical_and_entry_149

logical_and_entry_149:
  br i1 %t179, label %logical_and_right_149, label %logical_and_merge_149

logical_and_right_149:
  %t180 = load %Token, %Token* %l7
  %t181 = extractvalue %Token %t180, 0
  %t182 = extractvalue %TokenKind %t181, 0
  br label %merge9
merge9:
  store i8* null, i8** %l8
  %t183 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t184 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t183)
  %t185 = xor i1 %t184, 1
  %t186 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t187 = load double, double* %l1
  %t188 = load i1, i1* %l2
  %t189 = load %Token, %Token* %l3
  %t190 = load %Token, %Token* %l4
  %t191 = load i8*, i8** %l5
  %t192 = load i8*, i8** %l6
  %t193 = load i8*, i8** %l8
  br i1 %t185, label %then10, label %merge11
then10:
  %t194 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t195 = call %Token @expression_tokens_peek(%ExpressionTokens %t194)
  store %Token %t195, %Token* %l9
  %t197 = load %Token, %Token* %l9
  %t198 = extractvalue %Token %t197, 0
  %t199 = extractvalue %TokenKind %t198, 0
  %t200 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t201 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t202 = icmp eq i32 %t199, 0
  %t203 = select i1 %t202, i8* %t201, i8* %t200
  %t204 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t205 = icmp eq i32 %t199, 1
  %t206 = select i1 %t205, i8* %t204, i8* %t203
  %t207 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t208 = icmp eq i32 %t199, 2
  %t209 = select i1 %t208, i8* %t207, i8* %t206
  %t210 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t211 = icmp eq i32 %t199, 3
  %t212 = select i1 %t211, i8* %t210, i8* %t209
  %t213 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t214 = icmp eq i32 %t199, 4
  %t215 = select i1 %t214, i8* %t213, i8* %t212
  %t216 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t217 = icmp eq i32 %t199, 5
  %t218 = select i1 %t217, i8* %t216, i8* %t215
  %t219 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t220 = icmp eq i32 %t199, 6
  %t221 = select i1 %t220, i8* %t219, i8* %t218
  %t222 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t223 = icmp eq i32 %t199, 7
  %t224 = select i1 %t223, i8* %t222, i8* %t221
  %s225 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.225, i32 0, i32 0
  %t226 = icmp eq i8* %t224, %s225
  br label %logical_and_entry_196

logical_and_entry_196:
  br i1 %t226, label %logical_and_right_196, label %logical_and_merge_196

logical_and_right_196:
  %t227 = load %Token, %Token* %l9
  %t228 = extractvalue %Token %t227, 0
  %t229 = extractvalue %TokenKind %t228, 0
  br label %merge11
merge11:
  %t230 = extractvalue %ExpressionTokens %state, 0
  %t231 = load double, double* %l1
  %t232 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t233 = extractvalue %ExpressionTokens %t232, 1
  %t234 = bitcast { %Token**, i64 }* %t230 to { %Token*, i64 }*
  %t235 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t234, double %t231, double %t233)
  store { %Token*, i64 }* %t235, { %Token*, i64 }** %l10
  %t236 = load { %Token*, i64 }*, { %Token*, i64 }** %l10
  %t237 = call double @source_span_from_tokens({ %Token*, i64 }* %t236)
  store double %t237, double* %l11
  %t238 = load i8*, i8** %l5
  %t239 = insertvalue %Parameter undef, i8* %t238, 0
  %t240 = load i8*, i8** %l6
  %t241 = bitcast i8* %t240 to %TypeAnnotation*
  %t242 = insertvalue %Parameter %t239, %TypeAnnotation* %t241, 1
  %t243 = load i8*, i8** %l8
  %t244 = bitcast i8* %t243 to %Expression*
  %t245 = insertvalue %Parameter %t242, %Expression* %t244, 2
  %t246 = load i1, i1* %l2
  %t247 = insertvalue %Parameter %t245, i1 %t246, 3
  %t248 = load double, double* %l11
  %t249 = insertvalue %Parameter %t247, %SourceSpan* null, 4
  store %Parameter %t249, %Parameter* %l12
  %t250 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t251 = insertvalue %LambdaParameterParseResult undef, %ExpressionTokens %t250, 0
  %t252 = load %Parameter, %Parameter* %l12
  %t253 = insertvalue %LambdaParameterParseResult %t251, %Parameter %t252, 1
  %t254 = insertvalue %LambdaParameterParseResult %t253, i1 1, 2
  ret %LambdaParameterParseResult %t254
}

define %LambdaParameterListParseResult @parse_lambda_parameter_list(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca { %Parameter*, i64 }*
  %l2 = alloca %Token
  %l3 = alloca %LambdaParameterParseResult
  %l4 = alloca %Token
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  %t0 = alloca [0 x %Parameter]
  %t1 = getelementptr [0 x %Parameter], [0 x %Parameter]* %t0, i32 0, i32 0
  %t2 = alloca { %Parameter*, i64 }
  %t3 = getelementptr { %Parameter*, i64 }, { %Parameter*, i64 }* %t2, i32 0, i32 0
  store %Parameter* %t1, %Parameter** %t3
  %t4 = getelementptr { %Parameter*, i64 }, { %Parameter*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Parameter*, i64 }* %t2, { %Parameter*, i64 }** %l1
  %t5 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t6 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t5)
  %t7 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t8 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  br i1 %t6, label %then0, label %merge1
then0:
  %t9 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t10 = insertvalue %LambdaParameterListParseResult undef, %ExpressionTokens %t9, 0
  %t11 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t12 = bitcast { %Parameter*, i64 }* %t11 to { %Parameter**, i64 }*
  %t13 = insertvalue %LambdaParameterListParseResult %t10, { %Parameter**, i64 }* %t12, 1
  %t14 = insertvalue %LambdaParameterListParseResult %t13, i1 0, 2
  ret %LambdaParameterListParseResult %t14
merge1:
  %t15 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t16 = call %Token @expression_tokens_peek(%ExpressionTokens %t15)
  store %Token %t16, %Token* %l2
  %t18 = load %Token, %Token* %l2
  %t19 = extractvalue %Token %t18, 0
  %t20 = extractvalue %TokenKind %t19, 0
  %t21 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t22 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t23 = icmp eq i32 %t20, 0
  %t24 = select i1 %t23, i8* %t22, i8* %t21
  %t25 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t20, 1
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t20, 2
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %t31 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t32 = icmp eq i32 %t20, 3
  %t33 = select i1 %t32, i8* %t31, i8* %t30
  %t34 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t20, 4
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %t37 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t20, 5
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %t40 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t41 = icmp eq i32 %t20, 6
  %t42 = select i1 %t41, i8* %t40, i8* %t39
  %t43 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t44 = icmp eq i32 %t20, 7
  %t45 = select i1 %t44, i8* %t43, i8* %t42
  %s46 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.46, i32 0, i32 0
  %t47 = icmp eq i8* %t45, %s46
  br label %logical_and_entry_17

logical_and_entry_17:
  br i1 %t47, label %logical_and_right_17, label %logical_and_merge_17

logical_and_right_17:
  %t48 = load %Token, %Token* %l2
  %t49 = extractvalue %Token %t48, 0
  %t50 = extractvalue %TokenKind %t49, 0
  %t51 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t52 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t53 = load %Token, %Token* %l2
  br label %loop.header2
loop.header2:
  %t138 = phi { %Parameter*, i64 }* [ %t52, %entry ], [ %t136, %loop.latch4 ]
  %t139 = phi %ExpressionTokens [ %t51, %entry ], [ %t137, %loop.latch4 ]
  store { %Parameter*, i64 }* %t138, { %Parameter*, i64 }** %l1
  store %ExpressionTokens %t139, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t54 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t55 = call %LambdaParameterParseResult @parse_lambda_parameter(%ExpressionTokens %t54)
  store %LambdaParameterParseResult %t55, %LambdaParameterParseResult* %l3
  %t56 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  %t57 = extractvalue %LambdaParameterParseResult %t56, 2
  %t58 = xor i1 %t57, 1
  %t59 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t60 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t61 = load %Token, %Token* %l2
  %t62 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  br i1 %t58, label %then6, label %merge7
then6:
  %t63 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t64 = insertvalue %LambdaParameterListParseResult undef, %ExpressionTokens %t63, 0
  %t65 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t66 = bitcast { %Parameter*, i64 }* %t65 to { %Parameter**, i64 }*
  %t67 = insertvalue %LambdaParameterListParseResult %t64, { %Parameter**, i64 }* %t66, 1
  %t68 = insertvalue %LambdaParameterListParseResult %t67, i1 0, 2
  ret %LambdaParameterListParseResult %t68
merge7:
  %t69 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t70 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  %t71 = extractvalue %LambdaParameterParseResult %t70, 1
  %t72 = call { %Parameter*, i64 }* @append_parameter({ %Parameter*, i64 }* %t69, %Parameter %t71)
  store { %Parameter*, i64 }* %t72, { %Parameter*, i64 }** %l1
  %t73 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  %t74 = extractvalue %LambdaParameterParseResult %t73, 0
  store %ExpressionTokens %t74, %ExpressionTokens* %l0
  %t75 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t76 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t75)
  %t77 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t78 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t79 = load %Token, %Token* %l2
  %t80 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  br i1 %t76, label %then8, label %merge9
then8:
  %t81 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t82 = insertvalue %LambdaParameterListParseResult undef, %ExpressionTokens %t81, 0
  %t83 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t84 = bitcast { %Parameter*, i64 }* %t83 to { %Parameter**, i64 }*
  %t85 = insertvalue %LambdaParameterListParseResult %t82, { %Parameter**, i64 }* %t84, 1
  %t86 = insertvalue %LambdaParameterListParseResult %t85, i1 0, 2
  ret %LambdaParameterListParseResult %t86
merge9:
  %t87 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t88 = call %Token @expression_tokens_peek(%ExpressionTokens %t87)
  store %Token %t88, %Token* %l4
  %t89 = load %Token, %Token* %l4
  %t90 = extractvalue %Token %t89, 0
  %t91 = extractvalue %TokenKind %t90, 0
  %t92 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t93 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t91, 0
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %t96 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t97 = icmp eq i32 %t91, 1
  %t98 = select i1 %t97, i8* %t96, i8* %t95
  %t99 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t91, 2
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t91, 3
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t106 = icmp eq i32 %t91, 4
  %t107 = select i1 %t106, i8* %t105, i8* %t104
  %t108 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t91, 5
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t112 = icmp eq i32 %t91, 6
  %t113 = select i1 %t112, i8* %t111, i8* %t110
  %t114 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t91, 7
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %s117 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.117, i32 0, i32 0
  %t118 = icmp eq i8* %t116, %s117
  %t119 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t120 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t121 = load %Token, %Token* %l2
  %t122 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  %t123 = load %Token, %Token* %l4
  br i1 %t118, label %then10, label %merge11
then10:
  %t124 = load %Token, %Token* %l4
  %t125 = extractvalue %Token %t124, 0
  %t126 = extractvalue %TokenKind %t125, 0
  %t127 = load %Token, %Token* %l4
  %t128 = extractvalue %Token %t127, 0
  %t129 = extractvalue %TokenKind %t128, 0
  br label %merge11
merge11:
  %t130 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t131 = insertvalue %LambdaParameterListParseResult undef, %ExpressionTokens %t130, 0
  %t132 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t133 = bitcast { %Parameter*, i64 }* %t132 to { %Parameter**, i64 }*
  %t134 = insertvalue %LambdaParameterListParseResult %t131, { %Parameter**, i64 }* %t133, 1
  %t135 = insertvalue %LambdaParameterListParseResult %t134, i1 0, 2
  ret %LambdaParameterListParseResult %t135
loop.latch4:
  %t136 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t137 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t140 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t141 = insertvalue %LambdaParameterListParseResult undef, %ExpressionTokens %t140, 0
  %t142 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t143 = bitcast { %Parameter*, i64 }* %t142 to { %Parameter**, i64 }*
  %t144 = insertvalue %LambdaParameterListParseResult %t141, { %Parameter**, i64 }* %t143, 1
  %t145 = insertvalue %LambdaParameterListParseResult %t144, i1 1, 2
  ret %LambdaParameterListParseResult %t145
}

define %ExpressionParseResult @parse_lambda_expression(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca %Token
  %l2 = alloca %Token
  %l3 = alloca %LambdaParameterListParseResult
  %l4 = alloca { %Parameter**, i64 }*
  %l5 = alloca i8*
  %l6 = alloca %Token
  %l7 = alloca %ExpressionBlockParseResult
  %l8 = alloca { %Token**, i64 }*
  %l9 = alloca %Parser
  %l10 = alloca %BlockParseResult
  %l11 = alloca %Block
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  %t0 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t1 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t0)
  %t2 = load %ExpressionTokens, %ExpressionTokens* %l0
  br i1 %t1, label %then0, label %merge1
then0:
  %t3 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t3
merge1:
  %t4 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t5 = call %Token @expression_tokens_peek(%ExpressionTokens %t4)
  store %Token %t5, %Token* %l1
  %t7 = load %Token, %Token* %l1
  %t8 = extractvalue %Token %t7, 0
  %t9 = extractvalue %TokenKind %t8, 0
  %t10 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t11 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t12 = icmp eq i32 %t9, 0
  %t13 = select i1 %t12, i8* %t11, i8* %t10
  %t14 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t15 = icmp eq i32 %t9, 1
  %t16 = select i1 %t15, i8* %t14, i8* %t13
  %t17 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t9, 2
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t9, 3
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t9, 4
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t9, 5
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t9, 6
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t9, 7
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %s35 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.35, i32 0, i32 0
  %t36 = icmp ne i8* %t34, %s35
  br label %logical_or_entry_6

logical_or_entry_6:
  br i1 %t36, label %logical_or_merge_6, label %logical_or_right_6

logical_or_right_6:
  %t37 = load %Token, %Token* %l1
  %s38 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.38, i32 0, i32 0
  %t39 = call i1 @identifier_matches(%Token %t37, i8* %s38)
  %t40 = xor i1 %t39, 1
  br label %logical_or_right_end_6

logical_or_right_end_6:
  br label %logical_or_merge_6

logical_or_merge_6:
  %t41 = phi i1 [ true, %logical_or_entry_6 ], [ %t40, %logical_or_right_end_6 ]
  %t42 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t43 = load %Token, %Token* %l1
  br i1 %t41, label %then2, label %merge3
then2:
  %t44 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t44
merge3:
  %t45 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t46 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t45)
  store %ExpressionTokens %t46, %ExpressionTokens* %l0
  %t47 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t48 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t47)
  %t49 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t50 = load %Token, %Token* %l1
  br i1 %t48, label %then4, label %merge5
then4:
  %t51 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t51
merge5:
  %t52 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t53 = call %Token @expression_tokens_peek(%ExpressionTokens %t52)
  store %Token %t53, %Token* %l2
  %t55 = load %Token, %Token* %l2
  %t56 = extractvalue %Token %t55, 0
  %t57 = extractvalue %TokenKind %t56, 0
  %t58 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t59 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t60 = icmp eq i32 %t57, 0
  %t61 = select i1 %t60, i8* %t59, i8* %t58
  %t62 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t57, 1
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t57, 2
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t57, 3
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t57, 4
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t75 = icmp eq i32 %t57, 5
  %t76 = select i1 %t75, i8* %t74, i8* %t73
  %t77 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t78 = icmp eq i32 %t57, 6
  %t79 = select i1 %t78, i8* %t77, i8* %t76
  %t80 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t81 = icmp eq i32 %t57, 7
  %t82 = select i1 %t81, i8* %t80, i8* %t79
  %s83 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.83, i32 0, i32 0
  %t84 = icmp ne i8* %t82, %s83
  br label %logical_or_entry_54

logical_or_entry_54:
  br i1 %t84, label %logical_or_merge_54, label %logical_or_right_54

logical_or_right_54:
  %t85 = load %Token, %Token* %l2
  %t86 = extractvalue %Token %t85, 0
  %t87 = extractvalue %TokenKind %t86, 0
  %t88 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t89 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t88)
  store %ExpressionTokens %t89, %ExpressionTokens* %l0
  %t90 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t91 = call %LambdaParameterListParseResult @parse_lambda_parameter_list(%ExpressionTokens %t90)
  store %LambdaParameterListParseResult %t91, %LambdaParameterListParseResult* %l3
  %t92 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t93 = extractvalue %LambdaParameterListParseResult %t92, 2
  %t94 = xor i1 %t93, 1
  %t95 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t96 = load %Token, %Token* %l1
  %t97 = load %Token, %Token* %l2
  %t98 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  br i1 %t94, label %then6, label %merge7
then6:
  %t99 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t99
merge7:
  %t100 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t101 = extractvalue %LambdaParameterListParseResult %t100, 0
  store %ExpressionTokens %t101, %ExpressionTokens* %l0
  %t102 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t103 = extractvalue %LambdaParameterListParseResult %t102, 1
  store { %Parameter**, i64 }* %t103, { %Parameter**, i64 }** %l4
  store i8* null, i8** %l5
  %t104 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t105 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t104)
  %t106 = xor i1 %t105, 1
  %t107 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t108 = load %Token, %Token* %l1
  %t109 = load %Token, %Token* %l2
  %t110 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t111 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %l4
  %t112 = load i8*, i8** %l5
  br i1 %t106, label %then8, label %merge9
then8:
  %t113 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t114 = call %Token @expression_tokens_peek(%ExpressionTokens %t113)
  store %Token %t114, %Token* %l6
  %t117 = load %Token, %Token* %l6
  %t118 = extractvalue %Token %t117, 0
  %t119 = extractvalue %TokenKind %t118, 0
  %t120 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t121 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t122 = icmp eq i32 %t119, 0
  %t123 = select i1 %t122, i8* %t121, i8* %t120
  %t124 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t125 = icmp eq i32 %t119, 1
  %t126 = select i1 %t125, i8* %t124, i8* %t123
  %t127 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t128 = icmp eq i32 %t119, 2
  %t129 = select i1 %t128, i8* %t127, i8* %t126
  %t130 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t131 = icmp eq i32 %t119, 3
  %t132 = select i1 %t131, i8* %t130, i8* %t129
  %t133 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t134 = icmp eq i32 %t119, 4
  %t135 = select i1 %t134, i8* %t133, i8* %t132
  %t136 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t119, 5
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t119, 6
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t119, 7
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %s145 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.145, i32 0, i32 0
  %t146 = icmp eq i8* %t144, %s145
  br label %logical_and_entry_116

logical_and_entry_116:
  br i1 %t146, label %logical_and_right_116, label %logical_and_merge_116

logical_and_right_116:
  %t147 = load %Token, %Token* %l6
  %t148 = extractvalue %Token %t147, 0
  %t149 = extractvalue %TokenKind %t148, 0
  br label %merge9
merge9:
  %t150 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t151 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t150)
  %t152 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t153 = load %Token, %Token* %l1
  %t154 = load %Token, %Token* %l2
  %t155 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t156 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %l4
  %t157 = load i8*, i8** %l5
  br i1 %t151, label %then10, label %merge11
then10:
  %t158 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t158
merge11:
  %t159 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t160 = call %ExpressionBlockParseResult @collect_expression_block(%ExpressionTokens %t159)
  store %ExpressionBlockParseResult %t160, %ExpressionBlockParseResult* %l7
  %t161 = load %ExpressionBlockParseResult, %ExpressionBlockParseResult* %l7
  %t162 = extractvalue %ExpressionBlockParseResult %t161, 2
  %t163 = xor i1 %t162, 1
  %t164 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t165 = load %Token, %Token* %l1
  %t166 = load %Token, %Token* %l2
  %t167 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t168 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %l4
  %t169 = load i8*, i8** %l5
  %t170 = load %ExpressionBlockParseResult, %ExpressionBlockParseResult* %l7
  br i1 %t163, label %then12, label %merge13
then12:
  %t171 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t171
merge13:
  %t172 = load %ExpressionBlockParseResult, %ExpressionBlockParseResult* %l7
  %t173 = extractvalue %ExpressionBlockParseResult %t172, 0
  store %ExpressionTokens %t173, %ExpressionTokens* %l0
  %t174 = load %ExpressionBlockParseResult, %ExpressionBlockParseResult* %l7
  %t175 = extractvalue %ExpressionBlockParseResult %t174, 1
  store { %Token**, i64 }* %t175, { %Token**, i64 }** %l8
  %t176 = load { %Token**, i64 }*, { %Token**, i64 }** %l8
  %t177 = insertvalue %TokenKind undef, i32 7, 0
  %t178 = insertvalue %Token undef, %TokenKind %t177, 0
  %s179 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.179, i32 0, i32 0
  %t180 = insertvalue %Token %t178, i8* %s179, 1
  %t181 = sitofp i64 0 to double
  %t182 = insertvalue %Token %t180, double %t181, 2
  %t183 = sitofp i64 0 to double
  %t184 = insertvalue %Token %t182, double %t183, 3
  %t185 = bitcast { %Token**, i64 }* %t176 to { %Token*, i64 }*
  %t186 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t185, %Token %t184)
  %t187 = bitcast { %Token*, i64 }* %t186 to { %Token**, i64 }*
  store { %Token**, i64 }* %t187, { %Token**, i64 }** %l8
  %t188 = load { %Token**, i64 }*, { %Token**, i64 }** %l8
  %t189 = insertvalue %Parser undef, { %Token**, i64 }* %t188, 0
  %t190 = sitofp i64 0 to double
  %t191 = insertvalue %Parser %t189, double %t190, 1
  store %Parser %t191, %Parser* %l9
  %t192 = load %Parser, %Parser* %l9
  %t193 = call %BlockParseResult @parse_block(%Parser %t192)
  store %BlockParseResult %t193, %BlockParseResult* %l10
  %t194 = load %BlockParseResult, %BlockParseResult* %l10
  %t195 = extractvalue %BlockParseResult %t194, 1
  store %Block %t195, %Block* %l11
  %t196 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t197 = insertvalue %ExpressionParseResult undef, %ExpressionTokens %t196, 0
  %t198 = alloca %Expression
  %t199 = getelementptr inbounds %Expression, %Expression* %t198, i32 0, i32 0
  store i32 13, i32* %t199
  %t200 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %l4
  %t201 = getelementptr inbounds %Expression, %Expression* %t198, i32 0, i32 1
  %t202 = bitcast [24 x i8]* %t201 to i8*
  %t203 = bitcast i8* %t202 to { %Parameter**, i64 }**
  store { %Parameter**, i64 }* %t200, { %Parameter**, i64 }** %t203
  %t204 = load %Block, %Block* %l11
  %t205 = getelementptr inbounds %Expression, %Expression* %t198, i32 0, i32 1
  %t206 = bitcast [24 x i8]* %t205 to i8*
  %t207 = getelementptr inbounds i8, i8* %t206, i64 8
  %t208 = bitcast i8* %t207 to %Block*
  store %Block %t204, %Block* %t208
  %t209 = load i8*, i8** %l5
  %t210 = bitcast i8* %t209 to %TypeAnnotation*
  %t211 = getelementptr inbounds %Expression, %Expression* %t198, i32 0, i32 1
  %t212 = bitcast [24 x i8]* %t211 to i8*
  %t213 = getelementptr inbounds i8, i8* %t212, i64 16
  %t214 = bitcast i8* %t213 to %TypeAnnotation**
  store %TypeAnnotation* %t210, %TypeAnnotation** %t214
  %t215 = load %Expression, %Expression* %t198
  %t216 = insertvalue %ExpressionParseResult %t197, %Expression %t215, 1
  %t217 = insertvalue %ExpressionParseResult %t216, i1 1, 2
  ret %ExpressionParseResult %t217
}

define %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %state, double %min_precedence) {
entry:
  %l0 = alloca %ExpressionParseResult
  %l1 = alloca %ExpressionTokens
  %l2 = alloca %Expression
  %l3 = alloca %Token
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca %ExpressionParseResult
  %t0 = call %ExpressionParseResult @parse_prefix_expression(%ExpressionTokens %state)
  store %ExpressionParseResult %t0, %ExpressionParseResult* %l0
  %t1 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t2 = extractvalue %ExpressionParseResult %t1, 2
  %t3 = xor i1 %t2, 1
  %t4 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  ret %ExpressionParseResult %t5
merge1:
  %t6 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t7 = extractvalue %ExpressionParseResult %t6, 0
  store %ExpressionTokens %t7, %ExpressionTokens* %l1
  %t8 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t9 = extractvalue %ExpressionParseResult %t8, 1
  store %Expression %t9, %Expression* %l2
  %t10 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t11 = load %ExpressionTokens, %ExpressionTokens* %l1
  %t12 = load %Expression, %Expression* %l2
  br label %loop.header2
loop.header2:
  %t99 = phi %ExpressionTokens [ %t11, %entry ], [ %t98, %loop.latch4 ]
  store %ExpressionTokens %t99, %ExpressionTokens* %l1
  br label %loop.body3
loop.body3:
  %t13 = load %ExpressionTokens, %ExpressionTokens* %l1
  %t14 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t13)
  %t15 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t16 = load %ExpressionTokens, %ExpressionTokens* %l1
  %t17 = load %Expression, %Expression* %l2
  br i1 %t14, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t18 = load %ExpressionTokens, %ExpressionTokens* %l1
  %t19 = call %Token @expression_tokens_peek(%ExpressionTokens %t18)
  store %Token %t19, %Token* %l3
  %t20 = load %Token, %Token* %l3
  %t21 = extractvalue %Token %t20, 0
  %t22 = extractvalue %TokenKind %t21, 0
  %t23 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t24 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t22, 0
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %t27 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t28 = icmp eq i32 %t22, 1
  %t29 = select i1 %t28, i8* %t27, i8* %t26
  %t30 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t31 = icmp eq i32 %t22, 2
  %t32 = select i1 %t31, i8* %t30, i8* %t29
  %t33 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t34 = icmp eq i32 %t22, 3
  %t35 = select i1 %t34, i8* %t33, i8* %t32
  %t36 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t37 = icmp eq i32 %t22, 4
  %t38 = select i1 %t37, i8* %t36, i8* %t35
  %t39 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t40 = icmp eq i32 %t22, 5
  %t41 = select i1 %t40, i8* %t39, i8* %t38
  %t42 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t43 = icmp eq i32 %t22, 6
  %t44 = select i1 %t43, i8* %t42, i8* %t41
  %t45 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t46 = icmp eq i32 %t22, 7
  %t47 = select i1 %t46, i8* %t45, i8* %t44
  %s48 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.48, i32 0, i32 0
  %t49 = icmp ne i8* %t47, %s48
  %t50 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t51 = load %ExpressionTokens, %ExpressionTokens* %l1
  %t52 = load %Expression, %Expression* %l2
  %t53 = load %Token, %Token* %l3
  br i1 %t49, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t54 = load %Token, %Token* %l3
  %t55 = extractvalue %Token %t54, 0
  %t56 = extractvalue %TokenKind %t55, 0
  store double 0.0, double* %l4
  %t57 = load double, double* %l4
  %t58 = call double @binary_precedence(i8* null)
  store double %t58, double* %l5
  %t59 = load double, double* %l5
  %t60 = sitofp i64 -1 to double
  %t61 = fcmp oeq double %t59, %t60
  %t62 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t63 = load %ExpressionTokens, %ExpressionTokens* %l1
  %t64 = load %Expression, %Expression* %l2
  %t65 = load %Token, %Token* %l3
  %t66 = load double, double* %l4
  %t67 = load double, double* %l5
  br i1 %t61, label %then10, label %merge11
then10:
  br label %afterloop5
merge11:
  %t68 = load double, double* %l5
  %t69 = fcmp olt double %t68, %min_precedence
  %t70 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t71 = load %ExpressionTokens, %ExpressionTokens* %l1
  %t72 = load %Expression, %Expression* %l2
  %t73 = load %Token, %Token* %l3
  %t74 = load double, double* %l4
  %t75 = load double, double* %l5
  br i1 %t69, label %then12, label %merge13
then12:
  br label %afterloop5
merge13:
  %t76 = load %ExpressionTokens, %ExpressionTokens* %l1
  %t77 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t76)
  store %ExpressionTokens %t77, %ExpressionTokens* %l1
  %t78 = load %ExpressionTokens, %ExpressionTokens* %l1
  %t79 = load double, double* %l5
  %t80 = sitofp i64 1 to double
  %t81 = fadd double %t79, %t80
  %t82 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %t78, double %t81)
  store %ExpressionParseResult %t82, %ExpressionParseResult* %l6
  %t83 = load %ExpressionParseResult, %ExpressionParseResult* %l6
  %t84 = extractvalue %ExpressionParseResult %t83, 2
  %t85 = xor i1 %t84, 1
  %t86 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t87 = load %ExpressionTokens, %ExpressionTokens* %l1
  %t88 = load %Expression, %Expression* %l2
  %t89 = load %Token, %Token* %l3
  %t90 = load double, double* %l4
  %t91 = load double, double* %l5
  %t92 = load %ExpressionParseResult, %ExpressionParseResult* %l6
  br i1 %t85, label %then14, label %merge15
then14:
  %t93 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t93
merge15:
  %t94 = load %ExpressionParseResult, %ExpressionParseResult* %l6
  %t95 = extractvalue %ExpressionParseResult %t94, 0
  store %ExpressionTokens %t95, %ExpressionTokens* %l1
  %t96 = load double, double* %l4
  %s97 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.97, i32 0, i32 0
  br label %loop.latch4
loop.latch4:
  %t98 = load %ExpressionTokens, %ExpressionTokens* %l1
  br label %loop.header2
afterloop5:
  %t100 = load %ExpressionTokens, %ExpressionTokens* %l1
  %t101 = insertvalue %ExpressionParseResult undef, %ExpressionTokens %t100, 0
  %t102 = load %Expression, %Expression* %l2
  %t103 = insertvalue %ExpressionParseResult %t101, %Expression %t102, 1
  %t104 = insertvalue %ExpressionParseResult %t103, i1 1, 2
  ret %ExpressionParseResult %t104
}

define %ExpressionParseResult @parse_prefix_expression(%ExpressionTokens %state) {
entry:
  %l0 = alloca %Token
  %l1 = alloca double
  %l2 = alloca %ExpressionParseResult
  %l3 = alloca %ExpressionParseResult
  %t0 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %state)
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t1
merge1:
  %t2 = call %Token @expression_tokens_peek(%ExpressionTokens %state)
  store %Token %t2, %Token* %l0
  %t3 = load %Token, %Token* %l0
  %t4 = extractvalue %Token %t3, 0
  %t5 = extractvalue %TokenKind %t4, 0
  %t6 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t7 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t8 = icmp eq i32 %t5, 0
  %t9 = select i1 %t8, i8* %t7, i8* %t6
  %t10 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t11 = icmp eq i32 %t5, 1
  %t12 = select i1 %t11, i8* %t10, i8* %t9
  %t13 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t14 = icmp eq i32 %t5, 2
  %t15 = select i1 %t14, i8* %t13, i8* %t12
  %t16 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t17 = icmp eq i32 %t5, 3
  %t18 = select i1 %t17, i8* %t16, i8* %t15
  %t19 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t20 = icmp eq i32 %t5, 4
  %t21 = select i1 %t20, i8* %t19, i8* %t18
  %t22 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t23 = icmp eq i32 %t5, 5
  %t24 = select i1 %t23, i8* %t22, i8* %t21
  %t25 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t5, 6
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t5, 7
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %s31 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.31, i32 0, i32 0
  %t32 = icmp eq i8* %t30, %s31
  %t33 = load %Token, %Token* %l0
  br i1 %t32, label %then2, label %merge3
then2:
  %t34 = load %Token, %Token* %l0
  %t35 = extractvalue %Token %t34, 0
  %t36 = extractvalue %TokenKind %t35, 0
  store double 0.0, double* %l1
  %t38 = load double, double* %l1
  br label %merge3
merge3:
  %t40 = load %Token, %Token* %l0
  %t41 = extractvalue %Token %t40, 0
  %t42 = extractvalue %TokenKind %t41, 0
  %t43 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t44 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t42, 0
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t42, 1
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %t50 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t42, 2
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %t53 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t54 = icmp eq i32 %t42, 3
  %t55 = select i1 %t54, i8* %t53, i8* %t52
  %t56 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t57 = icmp eq i32 %t42, 4
  %t58 = select i1 %t57, i8* %t56, i8* %t55
  %t59 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t60 = icmp eq i32 %t42, 5
  %t61 = select i1 %t60, i8* %t59, i8* %t58
  %t62 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t42, 6
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t42, 7
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %s68 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.68, i32 0, i32 0
  %t69 = icmp eq i8* %t67, %s68
  br label %logical_and_entry_39

logical_and_entry_39:
  br i1 %t69, label %logical_and_right_39, label %logical_and_merge_39

logical_and_right_39:
  %t70 = load %Token, %Token* %l0
  %s71 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.71, i32 0, i32 0
  %t72 = call i1 @identifier_matches(%Token %t70, i8* %s71)
  br label %logical_and_right_end_39

logical_and_right_end_39:
  br label %logical_and_merge_39

logical_and_merge_39:
  %t73 = phi i1 [ false, %logical_and_entry_39 ], [ %t72, %logical_and_right_end_39 ]
  %t74 = load %Token, %Token* %l0
  br i1 %t73, label %then4, label %merge5
then4:
  %t75 = call %ExpressionParseResult @parse_lambda_expression(%ExpressionTokens %state)
  store %ExpressionParseResult %t75, %ExpressionParseResult* %l2
  %t76 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t77 = extractvalue %ExpressionParseResult %t76, 2
  %t78 = load %Token, %Token* %l0
  %t79 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  br i1 %t77, label %then6, label %merge7
then6:
  %t80 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  ret %ExpressionParseResult %t80
merge7:
  br label %merge5
merge5:
  %t81 = call %ExpressionParseResult @parse_primary_expression(%ExpressionTokens %state)
  store %ExpressionParseResult %t81, %ExpressionParseResult* %l3
  %t82 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  %t83 = extractvalue %ExpressionParseResult %t82, 2
  %t84 = xor i1 %t83, 1
  %t85 = load %Token, %Token* %l0
  %t86 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  br i1 %t84, label %then8, label %merge9
then8:
  %t87 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  ret %ExpressionParseResult %t87
merge9:
  %t88 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  %t89 = extractvalue %ExpressionParseResult %t88, 0
  %t90 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  %t91 = extractvalue %ExpressionParseResult %t90, 1
  %t92 = call %ExpressionParseResult @parse_postfix_chain(%ExpressionTokens %t89, %Expression %t91)
  ret %ExpressionParseResult %t92
}

define %ExpressionParseResult @parse_primary_expression(%ExpressionTokens %state) {
entry:
  %l0 = alloca %Token
  %l1 = alloca i8*
  %t0 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %state)
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t1
merge1:
  %t2 = call %Token @expression_tokens_peek(%ExpressionTokens %state)
  store %Token %t2, %Token* %l0
  %t3 = load %Token, %Token* %l0
  %t4 = extractvalue %Token %t3, 0
  %t5 = extractvalue %TokenKind %t4, 0
  %t6 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t7 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t8 = icmp eq i32 %t5, 0
  %t9 = select i1 %t8, i8* %t7, i8* %t6
  %t10 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t11 = icmp eq i32 %t5, 1
  %t12 = select i1 %t11, i8* %t10, i8* %t9
  %t13 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t14 = icmp eq i32 %t5, 2
  %t15 = select i1 %t14, i8* %t13, i8* %t12
  %t16 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t17 = icmp eq i32 %t5, 3
  %t18 = select i1 %t17, i8* %t16, i8* %t15
  %t19 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t20 = icmp eq i32 %t5, 4
  %t21 = select i1 %t20, i8* %t19, i8* %t18
  %t22 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t23 = icmp eq i32 %t5, 5
  %t24 = select i1 %t23, i8* %t22, i8* %t21
  %t25 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t5, 6
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t5, 7
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %s31 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.31, i32 0, i32 0
  %t32 = icmp eq i8* %t30, %s31
  %t33 = load %Token, %Token* %l0
  br i1 %t32, label %then2, label %merge3
then2:
  %t34 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %state)
  %t35 = insertvalue %ExpressionParseResult undef, %ExpressionTokens %t34, 0
  %t36 = alloca %Expression
  %t37 = getelementptr inbounds %Expression, %Expression* %t36, i32 0, i32 0
  store i32 1, i32* %t37
  %t38 = load %Token, %Token* %l0
  %t39 = extractvalue %Token %t38, 0
  %t40 = extractvalue %TokenKind %t39, 0
  %t41 = alloca %TokenKind
  store %TokenKind %t39, %TokenKind* %t41
  %t42 = getelementptr inbounds %TokenKind, %TokenKind* %t41, i32 0, i32 1
  %t43 = bitcast [8 x i8]* %t42 to i8*
  %t44 = bitcast i8* %t43 to i8**
  %t45 = load i8*, i8** %t44
  %t46 = icmp eq i32 %t40, 0
  %t47 = select i1 %t46, i8* %t45, i8* null
  %t48 = getelementptr inbounds %TokenKind, %TokenKind* %t41, i32 0, i32 1
  %t49 = bitcast [8 x i8]* %t48 to i8*
  %t50 = bitcast i8* %t49 to i8**
  %t51 = load i8*, i8** %t50
  %t52 = icmp eq i32 %t40, 1
  %t53 = select i1 %t52, i8* %t51, i8* %t47
  %t54 = getelementptr inbounds %TokenKind, %TokenKind* %t41, i32 0, i32 1
  %t55 = bitcast [8 x i8]* %t54 to i8*
  %t56 = bitcast i8* %t55 to i8**
  %t57 = load i8*, i8** %t56
  %t58 = icmp eq i32 %t40, 2
  %t59 = select i1 %t58, i8* %t57, i8* %t53
  %t60 = getelementptr inbounds %TokenKind, %TokenKind* %t41, i32 0, i32 1
  %t61 = bitcast [8 x i8]* %t60 to i8*
  %t62 = bitcast i8* %t61 to i8**
  %t63 = load i8*, i8** %t62
  %t64 = icmp eq i32 %t40, 4
  %t65 = select i1 %t64, i8* %t63, i8* %t59
  %t66 = getelementptr inbounds %Expression, %Expression* %t36, i32 0, i32 1
  %t67 = bitcast [8 x i8]* %t66 to i8*
  %t68 = bitcast i8* %t67 to i8**
  store i8* %t65, i8** %t68
  %t69 = load %Expression, %Expression* %t36
  %t70 = insertvalue %ExpressionParseResult %t35, %Expression %t69, 1
  %t71 = insertvalue %ExpressionParseResult %t70, i1 1, 2
  ret %ExpressionParseResult %t71
merge3:
  %t72 = load %Token, %Token* %l0
  %t73 = extractvalue %Token %t72, 0
  %t74 = extractvalue %TokenKind %t73, 0
  %t75 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t76 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t74, 0
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %t79 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t74, 1
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t74, 2
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %t85 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t74, 3
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t74, 4
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t74, 5
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t74, 6
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t74, 7
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %s100 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.100, i32 0, i32 0
  %t101 = icmp eq i8* %t99, %s100
  %t102 = load %Token, %Token* %l0
  br i1 %t101, label %then4, label %merge5
then4:
  %t103 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %state)
  %t104 = insertvalue %ExpressionParseResult undef, %ExpressionTokens %t103, 0
  %t105 = alloca %Expression
  %t106 = getelementptr inbounds %Expression, %Expression* %t105, i32 0, i32 0
  store i32 3, i32* %t106
  %t107 = load %Token, %Token* %l0
  %t108 = extractvalue %Token %t107, 0
  %t109 = extractvalue %TokenKind %t108, 0
  %t110 = alloca %TokenKind
  store %TokenKind %t108, %TokenKind* %t110
  %t111 = getelementptr inbounds %TokenKind, %TokenKind* %t110, i32 0, i32 1
  %t112 = bitcast [1 x i8]* %t111 to i8*
  %t113 = bitcast i8* %t112 to i1*
  %t114 = load i1, i1* %t113
  %t115 = icmp eq i32 %t109, 3
  %t116 = select i1 %t115, i1 %t114, i1 false
  %t117 = getelementptr inbounds %Expression, %Expression* %t105, i32 0, i32 1
  %t118 = bitcast [1 x i8]* %t117 to i8*
  %t119 = bitcast i8* %t118 to i1*
  store i1 %t116, i1* %t119
  %t120 = load %Expression, %Expression* %t105
  %t121 = insertvalue %ExpressionParseResult %t104, %Expression %t120, 1
  %t122 = insertvalue %ExpressionParseResult %t121, i1 1, 2
  ret %ExpressionParseResult %t122
merge5:
  %t123 = load %Token, %Token* %l0
  %t124 = extractvalue %Token %t123, 0
  %t125 = extractvalue %TokenKind %t124, 0
  %t126 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t127 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t128 = icmp eq i32 %t125, 0
  %t129 = select i1 %t128, i8* %t127, i8* %t126
  %t130 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t131 = icmp eq i32 %t125, 1
  %t132 = select i1 %t131, i8* %t130, i8* %t129
  %t133 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t134 = icmp eq i32 %t125, 2
  %t135 = select i1 %t134, i8* %t133, i8* %t132
  %t136 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t125, 3
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t125, 4
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t125, 5
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t125, 6
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t125, 7
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %s151 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.151, i32 0, i32 0
  %t152 = icmp eq i8* %t150, %s151
  %t153 = load %Token, %Token* %l0
  br i1 %t152, label %then6, label %merge7
then6:
  %t154 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %state)
  %t155 = insertvalue %ExpressionParseResult undef, %ExpressionTokens %t154, 0
  %t156 = alloca %Expression
  %t157 = getelementptr inbounds %Expression, %Expression* %t156, i32 0, i32 0
  store i32 2, i32* %t157
  %t158 = load %Token, %Token* %l0
  %t159 = extractvalue %Token %t158, 0
  %t160 = extractvalue %TokenKind %t159, 0
  %t161 = alloca %TokenKind
  store %TokenKind %t159, %TokenKind* %t161
  %t162 = getelementptr inbounds %TokenKind, %TokenKind* %t161, i32 0, i32 1
  %t163 = bitcast [8 x i8]* %t162 to i8*
  %t164 = bitcast i8* %t163 to i8**
  %t165 = load i8*, i8** %t164
  %t166 = icmp eq i32 %t160, 0
  %t167 = select i1 %t166, i8* %t165, i8* null
  %t168 = getelementptr inbounds %TokenKind, %TokenKind* %t161, i32 0, i32 1
  %t169 = bitcast [8 x i8]* %t168 to i8*
  %t170 = bitcast i8* %t169 to i8**
  %t171 = load i8*, i8** %t170
  %t172 = icmp eq i32 %t160, 1
  %t173 = select i1 %t172, i8* %t171, i8* %t167
  %t174 = getelementptr inbounds %TokenKind, %TokenKind* %t161, i32 0, i32 1
  %t175 = bitcast [8 x i8]* %t174 to i8*
  %t176 = bitcast i8* %t175 to i8**
  %t177 = load i8*, i8** %t176
  %t178 = icmp eq i32 %t160, 2
  %t179 = select i1 %t178, i8* %t177, i8* %t173
  %t180 = getelementptr inbounds %TokenKind, %TokenKind* %t161, i32 0, i32 1
  %t181 = bitcast [8 x i8]* %t180 to i8*
  %t182 = bitcast i8* %t181 to i8**
  %t183 = load i8*, i8** %t182
  %t184 = icmp eq i32 %t160, 4
  %t185 = select i1 %t184, i8* %t183, i8* %t179
  %t186 = getelementptr inbounds %Expression, %Expression* %t156, i32 0, i32 1
  %t187 = bitcast [8 x i8]* %t186 to i8*
  %t188 = bitcast i8* %t187 to i8**
  store i8* %t185, i8** %t188
  %t189 = load %Expression, %Expression* %t156
  %t190 = insertvalue %ExpressionParseResult %t155, %Expression %t189, 1
  %t191 = insertvalue %ExpressionParseResult %t190, i1 1, 2
  ret %ExpressionParseResult %t191
merge7:
  %t192 = load %Token, %Token* %l0
  %t193 = extractvalue %Token %t192, 0
  %t194 = extractvalue %TokenKind %t193, 0
  %t195 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t196 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t197 = icmp eq i32 %t194, 0
  %t198 = select i1 %t197, i8* %t196, i8* %t195
  %t199 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t200 = icmp eq i32 %t194, 1
  %t201 = select i1 %t200, i8* %t199, i8* %t198
  %t202 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t203 = icmp eq i32 %t194, 2
  %t204 = select i1 %t203, i8* %t202, i8* %t201
  %t205 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t206 = icmp eq i32 %t194, 3
  %t207 = select i1 %t206, i8* %t205, i8* %t204
  %t208 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t209 = icmp eq i32 %t194, 4
  %t210 = select i1 %t209, i8* %t208, i8* %t207
  %t211 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t212 = icmp eq i32 %t194, 5
  %t213 = select i1 %t212, i8* %t211, i8* %t210
  %t214 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t215 = icmp eq i32 %t194, 6
  %t216 = select i1 %t215, i8* %t214, i8* %t213
  %t217 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t218 = icmp eq i32 %t194, 7
  %t219 = select i1 %t218, i8* %t217, i8* %t216
  %s220 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.220, i32 0, i32 0
  %t221 = icmp eq i8* %t219, %s220
  %t222 = load %Token, %Token* %l0
  br i1 %t221, label %then8, label %merge9
then8:
  %t223 = load %Token, %Token* %l0
  %t224 = call i8* @identifier_text(%Token %t223)
  store i8* %t224, i8** %l1
  %t225 = load i8*, i8** %l1
  %s226 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.226, i32 0, i32 0
  %t227 = icmp eq i8* %t225, %s226
  %t228 = load %Token, %Token* %l0
  %t229 = load i8*, i8** %l1
  br i1 %t227, label %then10, label %merge11
then10:
  %t230 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %state)
  %t231 = insertvalue %ExpressionParseResult undef, %ExpressionTokens %t230, 0
  %t232 = alloca %Expression
  %t233 = getelementptr inbounds %Expression, %Expression* %t232, i32 0, i32 0
  store i32 3, i32* %t233
  %t234 = getelementptr inbounds %Expression, %Expression* %t232, i32 0, i32 1
  %t235 = bitcast [1 x i8]* %t234 to i8*
  %t236 = bitcast i8* %t235 to i1*
  store i1 1, i1* %t236
  %t237 = load %Expression, %Expression* %t232
  %t238 = insertvalue %ExpressionParseResult %t231, %Expression %t237, 1
  %t239 = insertvalue %ExpressionParseResult %t238, i1 1, 2
  ret %ExpressionParseResult %t239
merge11:
  %t240 = load i8*, i8** %l1
  %s241 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.241, i32 0, i32 0
  %t242 = icmp eq i8* %t240, %s241
  %t243 = load %Token, %Token* %l0
  %t244 = load i8*, i8** %l1
  br i1 %t242, label %then12, label %merge13
then12:
  %t245 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %state)
  %t246 = insertvalue %ExpressionParseResult undef, %ExpressionTokens %t245, 0
  %t247 = alloca %Expression
  %t248 = getelementptr inbounds %Expression, %Expression* %t247, i32 0, i32 0
  store i32 3, i32* %t248
  %t249 = getelementptr inbounds %Expression, %Expression* %t247, i32 0, i32 1
  %t250 = bitcast [1 x i8]* %t249 to i8*
  %t251 = bitcast i8* %t250 to i1*
  store i1 0, i1* %t251
  %t252 = load %Expression, %Expression* %t247
  %t253 = insertvalue %ExpressionParseResult %t246, %Expression %t252, 1
  %t254 = insertvalue %ExpressionParseResult %t253, i1 1, 2
  ret %ExpressionParseResult %t254
merge13:
  %t255 = load i8*, i8** %l1
  %s256 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.256, i32 0, i32 0
  %t257 = icmp eq i8* %t255, %s256
  %t258 = load %Token, %Token* %l0
  %t259 = load i8*, i8** %l1
  br i1 %t257, label %then14, label %merge15
then14:
  %t260 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %state)
  %t261 = insertvalue %ExpressionParseResult undef, %ExpressionTokens %t260, 0
  %t262 = insertvalue %Expression undef, i32 4, 0
  %t263 = insertvalue %ExpressionParseResult %t261, %Expression %t262, 1
  %t264 = insertvalue %ExpressionParseResult %t263, i1 1, 2
  ret %ExpressionParseResult %t264
merge15:
  %t265 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %state)
  %t266 = insertvalue %ExpressionParseResult undef, %ExpressionTokens %t265, 0
  %t267 = alloca %Expression
  %t268 = getelementptr inbounds %Expression, %Expression* %t267, i32 0, i32 0
  store i32 0, i32* %t268
  %t269 = load i8*, i8** %l1
  %t270 = getelementptr inbounds %Expression, %Expression* %t267, i32 0, i32 1
  %t271 = bitcast [8 x i8]* %t270 to i8*
  %t272 = bitcast i8* %t271 to i8**
  store i8* %t269, i8** %t272
  %t273 = load %Expression, %Expression* %t267
  %t274 = insertvalue %ExpressionParseResult %t266, %Expression %t273, 1
  %t275 = insertvalue %ExpressionParseResult %t274, i1 1, 2
  ret %ExpressionParseResult %t275
merge9:
  %t277 = load %Token, %Token* %l0
  %t278 = extractvalue %Token %t277, 0
  %t279 = extractvalue %TokenKind %t278, 0
  %t280 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t281 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t282 = icmp eq i32 %t279, 0
  %t283 = select i1 %t282, i8* %t281, i8* %t280
  %t284 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t285 = icmp eq i32 %t279, 1
  %t286 = select i1 %t285, i8* %t284, i8* %t283
  %t287 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t288 = icmp eq i32 %t279, 2
  %t289 = select i1 %t288, i8* %t287, i8* %t286
  %t290 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t291 = icmp eq i32 %t279, 3
  %t292 = select i1 %t291, i8* %t290, i8* %t289
  %t293 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t294 = icmp eq i32 %t279, 4
  %t295 = select i1 %t294, i8* %t293, i8* %t292
  %t296 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t297 = icmp eq i32 %t279, 5
  %t298 = select i1 %t297, i8* %t296, i8* %t295
  %t299 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t300 = icmp eq i32 %t279, 6
  %t301 = select i1 %t300, i8* %t299, i8* %t298
  %t302 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t303 = icmp eq i32 %t279, 7
  %t304 = select i1 %t303, i8* %t302, i8* %t301
  %s305 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.305, i32 0, i32 0
  %t306 = icmp eq i8* %t304, %s305
  br label %logical_and_entry_276

logical_and_entry_276:
  br i1 %t306, label %logical_and_right_276, label %logical_and_merge_276

logical_and_right_276:
  %t307 = load %Token, %Token* %l0
  %t308 = extractvalue %Token %t307, 0
  %t309 = extractvalue %TokenKind %t308, 0
  %t311 = load %Token, %Token* %l0
  %t312 = extractvalue %Token %t311, 0
  %t313 = extractvalue %TokenKind %t312, 0
  %t314 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t315 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t316 = icmp eq i32 %t313, 0
  %t317 = select i1 %t316, i8* %t315, i8* %t314
  %t318 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t319 = icmp eq i32 %t313, 1
  %t320 = select i1 %t319, i8* %t318, i8* %t317
  %t321 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t322 = icmp eq i32 %t313, 2
  %t323 = select i1 %t322, i8* %t321, i8* %t320
  %t324 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t325 = icmp eq i32 %t313, 3
  %t326 = select i1 %t325, i8* %t324, i8* %t323
  %t327 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t328 = icmp eq i32 %t313, 4
  %t329 = select i1 %t328, i8* %t327, i8* %t326
  %t330 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t331 = icmp eq i32 %t313, 5
  %t332 = select i1 %t331, i8* %t330, i8* %t329
  %t333 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t334 = icmp eq i32 %t313, 6
  %t335 = select i1 %t334, i8* %t333, i8* %t332
  %t336 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t337 = icmp eq i32 %t313, 7
  %t338 = select i1 %t337, i8* %t336, i8* %t335
  %s339 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.339, i32 0, i32 0
  %t340 = icmp eq i8* %t338, %s339
  br label %logical_and_entry_310

logical_and_entry_310:
  br i1 %t340, label %logical_and_right_310, label %logical_and_merge_310

logical_and_right_310:
  %t341 = load %Token, %Token* %l0
  %t342 = extractvalue %Token %t341, 0
  %t343 = extractvalue %TokenKind %t342, 0
  %t345 = load %Token, %Token* %l0
  %t346 = extractvalue %Token %t345, 0
  %t347 = extractvalue %TokenKind %t346, 0
  %t348 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t349 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t350 = icmp eq i32 %t347, 0
  %t351 = select i1 %t350, i8* %t349, i8* %t348
  %t352 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t353 = icmp eq i32 %t347, 1
  %t354 = select i1 %t353, i8* %t352, i8* %t351
  %t355 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t356 = icmp eq i32 %t347, 2
  %t357 = select i1 %t356, i8* %t355, i8* %t354
  %t358 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t359 = icmp eq i32 %t347, 3
  %t360 = select i1 %t359, i8* %t358, i8* %t357
  %t361 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t362 = icmp eq i32 %t347, 4
  %t363 = select i1 %t362, i8* %t361, i8* %t360
  %t364 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t365 = icmp eq i32 %t347, 5
  %t366 = select i1 %t365, i8* %t364, i8* %t363
  %t367 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t368 = icmp eq i32 %t347, 6
  %t369 = select i1 %t368, i8* %t367, i8* %t366
  %t370 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t371 = icmp eq i32 %t347, 7
  %t372 = select i1 %t371, i8* %t370, i8* %t369
  %s373 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.373, i32 0, i32 0
  %t374 = icmp eq i8* %t372, %s373
  br label %logical_and_entry_344

logical_and_entry_344:
  br i1 %t374, label %logical_and_right_344, label %logical_and_merge_344

logical_and_right_344:
  %t375 = load %Token, %Token* %l0
  %t376 = extractvalue %Token %t375, 0
  %t377 = extractvalue %TokenKind %t376, 0
  %t378 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t378
}

define %ExpressionParseResult @parse_postfix_chain(%ExpressionTokens %state, %Expression %expression) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca %Expression
  %l2 = alloca %Token
  %l3 = alloca double
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  store %Expression %expression, %Expression* %l1
  %t0 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t1 = load %Expression, %Expression* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t2 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t3 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t2)
  %t4 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t5 = load %Expression, %Expression* %l1
  br i1 %t3, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t6 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t7 = call %Token @expression_tokens_peek(%ExpressionTokens %t6)
  store %Token %t7, %Token* %l2
  %t8 = load %Token, %Token* %l2
  %t9 = extractvalue %Token %t8, 0
  %t10 = extractvalue %TokenKind %t9, 0
  %t11 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t12 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t13 = icmp eq i32 %t10, 0
  %t14 = select i1 %t13, i8* %t12, i8* %t11
  %t15 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t16 = icmp eq i32 %t10, 1
  %t17 = select i1 %t16, i8* %t15, i8* %t14
  %t18 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t19 = icmp eq i32 %t10, 2
  %t20 = select i1 %t19, i8* %t18, i8* %t17
  %t21 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t22 = icmp eq i32 %t10, 3
  %t23 = select i1 %t22, i8* %t21, i8* %t20
  %t24 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t10, 4
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %t27 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t28 = icmp eq i32 %t10, 5
  %t29 = select i1 %t28, i8* %t27, i8* %t26
  %t30 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t31 = icmp eq i32 %t10, 6
  %t32 = select i1 %t31, i8* %t30, i8* %t29
  %t33 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t34 = icmp eq i32 %t10, 7
  %t35 = select i1 %t34, i8* %t33, i8* %t32
  %s36 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.36, i32 0, i32 0
  %t37 = icmp ne i8* %t35, %s36
  %t38 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t39 = load %Expression, %Expression* %l1
  %t40 = load %Token, %Token* %l2
  br i1 %t37, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t41 = load %Token, %Token* %l2
  %t42 = extractvalue %Token %t41, 0
  %t43 = extractvalue %TokenKind %t42, 0
  store double 0.0, double* %l3
  %t44 = load double, double* %l3
  %t45 = load double, double* %l3
  %t46 = load double, double* %l3
  %t47 = load double, double* %l3
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t48 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t49 = insertvalue %ExpressionParseResult undef, %ExpressionTokens %t48, 0
  %t50 = load %Expression, %Expression* %l1
  %t51 = insertvalue %ExpressionParseResult %t49, %Expression %t50, 1
  %t52 = insertvalue %ExpressionParseResult %t51, i1 1, 2
  ret %ExpressionParseResult %t52
}

define %CallArgumentsParseResult @parse_call_arguments(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca { %Expression*, i64 }*
  %l2 = alloca %ExpressionParseResult
  %l3 = alloca %Token
  %t0 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %state)
  store %ExpressionTokens %t0, %ExpressionTokens* %l0
  %t1 = alloca [0 x %Expression]
  %t2 = getelementptr [0 x %Expression], [0 x %Expression]* %t1, i32 0, i32 0
  %t3 = alloca { %Expression*, i64 }
  %t4 = getelementptr { %Expression*, i64 }, { %Expression*, i64 }* %t3, i32 0, i32 0
  store %Expression* %t2, %Expression** %t4
  %t5 = getelementptr { %Expression*, i64 }, { %Expression*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { %Expression*, i64 }* %t3, { %Expression*, i64 }** %l1
  %t6 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t7 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t6)
  %t8 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t9 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  br i1 %t7, label %then0, label %merge1
then0:
  %t10 = insertvalue %CallArgumentsParseResult undef, %ExpressionTokens %state, 0
  %t11 = alloca [0 x %Expression*]
  %t12 = getelementptr [0 x %Expression*], [0 x %Expression*]* %t11, i32 0, i32 0
  %t13 = alloca { %Expression**, i64 }
  %t14 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t13, i32 0, i32 0
  store %Expression** %t12, %Expression*** %t14
  %t15 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  %t16 = insertvalue %CallArgumentsParseResult %t10, { %Expression**, i64 }* %t13, 1
  %t17 = insertvalue %CallArgumentsParseResult %t16, i1 0, 2
  ret %CallArgumentsParseResult %t17
merge1:
  %t19 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t20 = call %Token @expression_tokens_peek(%ExpressionTokens %t19)
  %t21 = extractvalue %Token %t20, 0
  %t22 = extractvalue %TokenKind %t21, 0
  %t23 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t24 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t22, 0
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %t27 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t28 = icmp eq i32 %t22, 1
  %t29 = select i1 %t28, i8* %t27, i8* %t26
  %t30 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t31 = icmp eq i32 %t22, 2
  %t32 = select i1 %t31, i8* %t30, i8* %t29
  %t33 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t34 = icmp eq i32 %t22, 3
  %t35 = select i1 %t34, i8* %t33, i8* %t32
  %t36 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t37 = icmp eq i32 %t22, 4
  %t38 = select i1 %t37, i8* %t36, i8* %t35
  %t39 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t40 = icmp eq i32 %t22, 5
  %t41 = select i1 %t40, i8* %t39, i8* %t38
  %t42 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t43 = icmp eq i32 %t22, 6
  %t44 = select i1 %t43, i8* %t42, i8* %t41
  %t45 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t46 = icmp eq i32 %t22, 7
  %t47 = select i1 %t46, i8* %t45, i8* %t44
  %s48 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.48, i32 0, i32 0
  %t49 = icmp eq i8* %t47, %s48
  br label %logical_and_entry_18

logical_and_entry_18:
  br i1 %t49, label %logical_and_right_18, label %logical_and_merge_18

logical_and_right_18:
  %t50 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t51 = call %Token @expression_tokens_peek(%ExpressionTokens %t50)
  %t52 = extractvalue %Token %t51, 0
  %t53 = extractvalue %TokenKind %t52, 0
  %t54 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t55 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  br label %loop.header2
loop.header2:
  %t172 = phi { %Expression*, i64 }* [ %t55, %entry ], [ %t170, %loop.latch4 ]
  %t173 = phi %ExpressionTokens [ %t54, %entry ], [ %t171, %loop.latch4 ]
  store { %Expression*, i64 }* %t172, { %Expression*, i64 }** %l1
  store %ExpressionTokens %t173, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t56 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t57 = sitofp i64 0 to double
  %t58 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %t56, double %t57)
  store %ExpressionParseResult %t58, %ExpressionParseResult* %l2
  %t59 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t60 = extractvalue %ExpressionParseResult %t59, 2
  %t61 = xor i1 %t60, 1
  %t62 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t63 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t64 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  br i1 %t61, label %then6, label %merge7
then6:
  %t65 = insertvalue %CallArgumentsParseResult undef, %ExpressionTokens %state, 0
  %t66 = alloca [0 x %Expression*]
  %t67 = getelementptr [0 x %Expression*], [0 x %Expression*]* %t66, i32 0, i32 0
  %t68 = alloca { %Expression**, i64 }
  %t69 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t68, i32 0, i32 0
  store %Expression** %t67, %Expression*** %t69
  %t70 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t68, i32 0, i32 1
  store i64 0, i64* %t70
  %t71 = insertvalue %CallArgumentsParseResult %t65, { %Expression**, i64 }* %t68, 1
  %t72 = insertvalue %CallArgumentsParseResult %t71, i1 0, 2
  ret %CallArgumentsParseResult %t72
merge7:
  %t73 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t74 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t75 = extractvalue %ExpressionParseResult %t74, 1
  %t76 = call { %Expression*, i64 }* @append_expression({ %Expression*, i64 }* %t73, %Expression %t75)
  store { %Expression*, i64 }* %t76, { %Expression*, i64 }** %l1
  %t77 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t78 = extractvalue %ExpressionParseResult %t77, 0
  store %ExpressionTokens %t78, %ExpressionTokens* %l0
  %t79 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t80 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t79)
  %t81 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t82 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t83 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  br i1 %t80, label %then8, label %merge9
then8:
  %t84 = insertvalue %CallArgumentsParseResult undef, %ExpressionTokens %state, 0
  %t85 = alloca [0 x %Expression*]
  %t86 = getelementptr [0 x %Expression*], [0 x %Expression*]* %t85, i32 0, i32 0
  %t87 = alloca { %Expression**, i64 }
  %t88 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t87, i32 0, i32 0
  store %Expression** %t86, %Expression*** %t88
  %t89 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t87, i32 0, i32 1
  store i64 0, i64* %t89
  %t90 = insertvalue %CallArgumentsParseResult %t84, { %Expression**, i64 }* %t87, 1
  %t91 = insertvalue %CallArgumentsParseResult %t90, i1 0, 2
  ret %CallArgumentsParseResult %t91
merge9:
  %t92 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t93 = call %Token @expression_tokens_peek(%ExpressionTokens %t92)
  store %Token %t93, %Token* %l3
  %t95 = load %Token, %Token* %l3
  %t96 = extractvalue %Token %t95, 0
  %t97 = extractvalue %TokenKind %t96, 0
  %t98 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t99 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t97, 0
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t97, 1
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t106 = icmp eq i32 %t97, 2
  %t107 = select i1 %t106, i8* %t105, i8* %t104
  %t108 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t97, 3
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t112 = icmp eq i32 %t97, 4
  %t113 = select i1 %t112, i8* %t111, i8* %t110
  %t114 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t97, 5
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %t117 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t118 = icmp eq i32 %t97, 6
  %t119 = select i1 %t118, i8* %t117, i8* %t116
  %t120 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t97, 7
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %s123 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.123, i32 0, i32 0
  %t124 = icmp eq i8* %t122, %s123
  br label %logical_and_entry_94

logical_and_entry_94:
  br i1 %t124, label %logical_and_right_94, label %logical_and_merge_94

logical_and_right_94:
  %t125 = load %Token, %Token* %l3
  %t126 = extractvalue %Token %t125, 0
  %t127 = extractvalue %TokenKind %t126, 0
  %t129 = load %Token, %Token* %l3
  %t130 = extractvalue %Token %t129, 0
  %t131 = extractvalue %TokenKind %t130, 0
  %t132 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t133 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t134 = icmp eq i32 %t131, 0
  %t135 = select i1 %t134, i8* %t133, i8* %t132
  %t136 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t131, 1
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t131, 2
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t131, 3
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t131, 4
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t131, 5
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t131, 6
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t131, 7
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %s157 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.157, i32 0, i32 0
  %t158 = icmp eq i8* %t156, %s157
  br label %logical_and_entry_128

logical_and_entry_128:
  br i1 %t158, label %logical_and_right_128, label %logical_and_merge_128

logical_and_right_128:
  %t159 = load %Token, %Token* %l3
  %t160 = extractvalue %Token %t159, 0
  %t161 = extractvalue %TokenKind %t160, 0
  %t162 = insertvalue %CallArgumentsParseResult undef, %ExpressionTokens %state, 0
  %t163 = alloca [0 x %Expression*]
  %t164 = getelementptr [0 x %Expression*], [0 x %Expression*]* %t163, i32 0, i32 0
  %t165 = alloca { %Expression**, i64 }
  %t166 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t165, i32 0, i32 0
  store %Expression** %t164, %Expression*** %t166
  %t167 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t165, i32 0, i32 1
  store i64 0, i64* %t167
  %t168 = insertvalue %CallArgumentsParseResult %t162, { %Expression**, i64 }* %t165, 1
  %t169 = insertvalue %CallArgumentsParseResult %t168, i1 0, 2
  ret %CallArgumentsParseResult %t169
loop.latch4:
  %t170 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t171 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t174 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t175 = insertvalue %CallArgumentsParseResult undef, %ExpressionTokens %t174, 0
  %t176 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t177 = bitcast { %Expression*, i64 }* %t176 to { %Expression**, i64 }*
  %t178 = insertvalue %CallArgumentsParseResult %t175, { %Expression**, i64 }* %t177, 1
  %t179 = insertvalue %CallArgumentsParseResult %t178, i1 1, 2
  ret %CallArgumentsParseResult %t179
}

define %ArrayLiteralParseResult @parse_array_literal(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca { %Expression*, i64 }*
  %l2 = alloca %ExpressionParseResult
  %l3 = alloca %Token
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  %t0 = alloca [0 x %Expression]
  %t1 = getelementptr [0 x %Expression], [0 x %Expression]* %t0, i32 0, i32 0
  %t2 = alloca { %Expression*, i64 }
  %t3 = getelementptr { %Expression*, i64 }, { %Expression*, i64 }* %t2, i32 0, i32 0
  store %Expression* %t1, %Expression** %t3
  %t4 = getelementptr { %Expression*, i64 }, { %Expression*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Expression*, i64 }* %t2, { %Expression*, i64 }** %l1
  %t5 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t6 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t5)
  %t7 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t8 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  br i1 %t6, label %then0, label %merge1
then0:
  %t9 = insertvalue %ArrayLiteralParseResult undef, %ExpressionTokens %state, 0
  %t10 = alloca [0 x %Expression*]
  %t11 = getelementptr [0 x %Expression*], [0 x %Expression*]* %t10, i32 0, i32 0
  %t12 = alloca { %Expression**, i64 }
  %t13 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t12, i32 0, i32 0
  store %Expression** %t11, %Expression*** %t13
  %t14 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  %t15 = insertvalue %ArrayLiteralParseResult %t9, { %Expression**, i64 }* %t12, 1
  %t16 = insertvalue %ArrayLiteralParseResult %t15, i1 0, 2
  ret %ArrayLiteralParseResult %t16
merge1:
  %t18 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t19 = call %Token @expression_tokens_peek(%ExpressionTokens %t18)
  %t20 = extractvalue %Token %t19, 0
  %t21 = extractvalue %TokenKind %t20, 0
  %t22 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t23 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t21, 0
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t21, 1
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t21, 2
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t21, 3
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t21, 4
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t21, 5
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t21, 6
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t21, 7
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %s47 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.47, i32 0, i32 0
  %t48 = icmp eq i8* %t46, %s47
  br label %logical_and_entry_17

logical_and_entry_17:
  br i1 %t48, label %logical_and_right_17, label %logical_and_merge_17

logical_and_right_17:
  %t49 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t50 = call %Token @expression_tokens_peek(%ExpressionTokens %t49)
  %t51 = extractvalue %Token %t50, 0
  %t52 = extractvalue %TokenKind %t51, 0
  %t53 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t54 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  br label %loop.header2
loop.header2:
  %t171 = phi { %Expression*, i64 }* [ %t54, %entry ], [ %t169, %loop.latch4 ]
  %t172 = phi %ExpressionTokens [ %t53, %entry ], [ %t170, %loop.latch4 ]
  store { %Expression*, i64 }* %t171, { %Expression*, i64 }** %l1
  store %ExpressionTokens %t172, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t55 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t56 = sitofp i64 0 to double
  %t57 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %t55, double %t56)
  store %ExpressionParseResult %t57, %ExpressionParseResult* %l2
  %t58 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t59 = extractvalue %ExpressionParseResult %t58, 2
  %t60 = xor i1 %t59, 1
  %t61 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t62 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t63 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  br i1 %t60, label %then6, label %merge7
then6:
  %t64 = insertvalue %ArrayLiteralParseResult undef, %ExpressionTokens %state, 0
  %t65 = alloca [0 x %Expression*]
  %t66 = getelementptr [0 x %Expression*], [0 x %Expression*]* %t65, i32 0, i32 0
  %t67 = alloca { %Expression**, i64 }
  %t68 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t67, i32 0, i32 0
  store %Expression** %t66, %Expression*** %t68
  %t69 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t67, i32 0, i32 1
  store i64 0, i64* %t69
  %t70 = insertvalue %ArrayLiteralParseResult %t64, { %Expression**, i64 }* %t67, 1
  %t71 = insertvalue %ArrayLiteralParseResult %t70, i1 0, 2
  ret %ArrayLiteralParseResult %t71
merge7:
  %t72 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t73 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t74 = extractvalue %ExpressionParseResult %t73, 1
  %t75 = call { %Expression*, i64 }* @append_expression({ %Expression*, i64 }* %t72, %Expression %t74)
  store { %Expression*, i64 }* %t75, { %Expression*, i64 }** %l1
  %t76 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t77 = extractvalue %ExpressionParseResult %t76, 0
  store %ExpressionTokens %t77, %ExpressionTokens* %l0
  %t78 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t79 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t78)
  %t80 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t81 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t82 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  br i1 %t79, label %then8, label %merge9
then8:
  %t83 = insertvalue %ArrayLiteralParseResult undef, %ExpressionTokens %state, 0
  %t84 = alloca [0 x %Expression*]
  %t85 = getelementptr [0 x %Expression*], [0 x %Expression*]* %t84, i32 0, i32 0
  %t86 = alloca { %Expression**, i64 }
  %t87 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t86, i32 0, i32 0
  store %Expression** %t85, %Expression*** %t87
  %t88 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t86, i32 0, i32 1
  store i64 0, i64* %t88
  %t89 = insertvalue %ArrayLiteralParseResult %t83, { %Expression**, i64 }* %t86, 1
  %t90 = insertvalue %ArrayLiteralParseResult %t89, i1 0, 2
  ret %ArrayLiteralParseResult %t90
merge9:
  %t91 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t92 = call %Token @expression_tokens_peek(%ExpressionTokens %t91)
  store %Token %t92, %Token* %l3
  %t94 = load %Token, %Token* %l3
  %t95 = extractvalue %Token %t94, 0
  %t96 = extractvalue %TokenKind %t95, 0
  %t97 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t98 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t96, 0
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t96, 1
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t96, 2
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t96, 3
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t96, 4
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t96, 5
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %t116 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t96, 6
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %t119 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t96, 7
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %s122 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.122, i32 0, i32 0
  %t123 = icmp eq i8* %t121, %s122
  br label %logical_and_entry_93

logical_and_entry_93:
  br i1 %t123, label %logical_and_right_93, label %logical_and_merge_93

logical_and_right_93:
  %t124 = load %Token, %Token* %l3
  %t125 = extractvalue %Token %t124, 0
  %t126 = extractvalue %TokenKind %t125, 0
  %t128 = load %Token, %Token* %l3
  %t129 = extractvalue %Token %t128, 0
  %t130 = extractvalue %TokenKind %t129, 0
  %t131 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t132 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t130, 0
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t130, 1
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t130, 2
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t130, 3
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t130, 4
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t130, 5
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t130, 6
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t130, 7
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %s156 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.156, i32 0, i32 0
  %t157 = icmp eq i8* %t155, %s156
  br label %logical_and_entry_127

logical_and_entry_127:
  br i1 %t157, label %logical_and_right_127, label %logical_and_merge_127

logical_and_right_127:
  %t158 = load %Token, %Token* %l3
  %t159 = extractvalue %Token %t158, 0
  %t160 = extractvalue %TokenKind %t159, 0
  %t161 = insertvalue %ArrayLiteralParseResult undef, %ExpressionTokens %state, 0
  %t162 = alloca [0 x %Expression*]
  %t163 = getelementptr [0 x %Expression*], [0 x %Expression*]* %t162, i32 0, i32 0
  %t164 = alloca { %Expression**, i64 }
  %t165 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t164, i32 0, i32 0
  store %Expression** %t163, %Expression*** %t165
  %t166 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t164, i32 0, i32 1
  store i64 0, i64* %t166
  %t167 = insertvalue %ArrayLiteralParseResult %t161, { %Expression**, i64 }* %t164, 1
  %t168 = insertvalue %ArrayLiteralParseResult %t167, i1 0, 2
  ret %ArrayLiteralParseResult %t168
loop.latch4:
  %t169 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t170 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t173 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t174 = insertvalue %ArrayLiteralParseResult undef, %ExpressionTokens %t173, 0
  %t175 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t176 = bitcast { %Expression*, i64 }* %t175 to { %Expression**, i64 }*
  %t177 = insertvalue %ArrayLiteralParseResult %t174, { %Expression**, i64 }* %t176, 1
  %t178 = insertvalue %ArrayLiteralParseResult %t177, i1 1, 2
  ret %ArrayLiteralParseResult %t178
}

define %ObjectLiteralParseResult @parse_object_literal(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca { %ObjectField*, i64 }*
  %l2 = alloca %Token
  %l3 = alloca i8*
  %l4 = alloca %Token
  %l5 = alloca %ExpressionParseResult
  %l6 = alloca %Token
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  %t0 = alloca [0 x %ObjectField]
  %t1 = getelementptr [0 x %ObjectField], [0 x %ObjectField]* %t0, i32 0, i32 0
  %t2 = alloca { %ObjectField*, i64 }
  %t3 = getelementptr { %ObjectField*, i64 }, { %ObjectField*, i64 }* %t2, i32 0, i32 0
  store %ObjectField* %t1, %ObjectField** %t3
  %t4 = getelementptr { %ObjectField*, i64 }, { %ObjectField*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %ObjectField*, i64 }* %t2, { %ObjectField*, i64 }** %l1
  %t5 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t6 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t5)
  %t7 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t8 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  br i1 %t6, label %then0, label %merge1
then0:
  %t9 = insertvalue %ObjectLiteralParseResult undef, %ExpressionTokens %state, 0
  %t10 = alloca [0 x %ObjectField*]
  %t11 = getelementptr [0 x %ObjectField*], [0 x %ObjectField*]* %t10, i32 0, i32 0
  %t12 = alloca { %ObjectField**, i64 }
  %t13 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t12, i32 0, i32 0
  store %ObjectField** %t11, %ObjectField*** %t13
  %t14 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  %t15 = insertvalue %ObjectLiteralParseResult %t9, { %ObjectField**, i64 }* %t12, 1
  %t16 = insertvalue %ObjectLiteralParseResult %t15, i1 0, 2
  ret %ObjectLiteralParseResult %t16
merge1:
  %t18 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t19 = call %Token @expression_tokens_peek(%ExpressionTokens %t18)
  %t20 = extractvalue %Token %t19, 0
  %t21 = extractvalue %TokenKind %t20, 0
  %t22 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t23 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t21, 0
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t21, 1
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t21, 2
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t21, 3
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t21, 4
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t21, 5
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t21, 6
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t21, 7
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %s47 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.47, i32 0, i32 0
  %t48 = icmp eq i8* %t46, %s47
  br label %logical_and_entry_17

logical_and_entry_17:
  br i1 %t48, label %logical_and_right_17, label %logical_and_merge_17

logical_and_right_17:
  %t49 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t50 = call %Token @expression_tokens_peek(%ExpressionTokens %t49)
  %t51 = extractvalue %Token %t50, 0
  %t52 = extractvalue %TokenKind %t51, 0
  %t53 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t54 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  br label %loop.header2
loop.header2:
  %t291 = phi %ExpressionTokens [ %t53, %entry ], [ %t289, %loop.latch4 ]
  %t292 = phi { %ObjectField*, i64 }* [ %t54, %entry ], [ %t290, %loop.latch4 ]
  store %ExpressionTokens %t291, %ExpressionTokens* %l0
  store { %ObjectField*, i64 }* %t292, { %ObjectField*, i64 }** %l1
  br label %loop.body3
loop.body3:
  %t55 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t56 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t55)
  %t57 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t58 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  br i1 %t56, label %then6, label %merge7
then6:
  %t59 = insertvalue %ObjectLiteralParseResult undef, %ExpressionTokens %state, 0
  %t60 = alloca [0 x %ObjectField*]
  %t61 = getelementptr [0 x %ObjectField*], [0 x %ObjectField*]* %t60, i32 0, i32 0
  %t62 = alloca { %ObjectField**, i64 }
  %t63 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t62, i32 0, i32 0
  store %ObjectField** %t61, %ObjectField*** %t63
  %t64 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t62, i32 0, i32 1
  store i64 0, i64* %t64
  %t65 = insertvalue %ObjectLiteralParseResult %t59, { %ObjectField**, i64 }* %t62, 1
  %t66 = insertvalue %ObjectLiteralParseResult %t65, i1 0, 2
  ret %ObjectLiteralParseResult %t66
merge7:
  %t67 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t68 = call %Token @expression_tokens_peek(%ExpressionTokens %t67)
  store %Token %t68, %Token* %l2
  %t69 = load %Token, %Token* %l2
  %t70 = extractvalue %Token %t69, 0
  %t71 = extractvalue %TokenKind %t70, 0
  %t72 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t73 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t71, 0
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %t76 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t71, 1
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %t79 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t71, 2
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t71, 3
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %t85 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t71, 4
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t71, 5
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t71, 6
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t71, 7
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %s97 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.97, i32 0, i32 0
  %t98 = icmp ne i8* %t96, %s97
  %t99 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t100 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  %t101 = load %Token, %Token* %l2
  br i1 %t98, label %then8, label %merge9
then8:
  %t102 = insertvalue %ObjectLiteralParseResult undef, %ExpressionTokens %state, 0
  %t103 = alloca [0 x %ObjectField*]
  %t104 = getelementptr [0 x %ObjectField*], [0 x %ObjectField*]* %t103, i32 0, i32 0
  %t105 = alloca { %ObjectField**, i64 }
  %t106 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t105, i32 0, i32 0
  store %ObjectField** %t104, %ObjectField*** %t106
  %t107 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t105, i32 0, i32 1
  store i64 0, i64* %t107
  %t108 = insertvalue %ObjectLiteralParseResult %t102, { %ObjectField**, i64 }* %t105, 1
  %t109 = insertvalue %ObjectLiteralParseResult %t108, i1 0, 2
  ret %ObjectLiteralParseResult %t109
merge9:
  %t110 = load %Token, %Token* %l2
  %t111 = call i8* @identifier_text(%Token %t110)
  store i8* %t111, i8** %l3
  %t112 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t113 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t112)
  store %ExpressionTokens %t113, %ExpressionTokens* %l0
  %t114 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t115 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t114)
  %t116 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t117 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  %t118 = load %Token, %Token* %l2
  %t119 = load i8*, i8** %l3
  br i1 %t115, label %then10, label %merge11
then10:
  %t120 = insertvalue %ObjectLiteralParseResult undef, %ExpressionTokens %state, 0
  %t121 = alloca [0 x %ObjectField*]
  %t122 = getelementptr [0 x %ObjectField*], [0 x %ObjectField*]* %t121, i32 0, i32 0
  %t123 = alloca { %ObjectField**, i64 }
  %t124 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t123, i32 0, i32 0
  store %ObjectField** %t122, %ObjectField*** %t124
  %t125 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t123, i32 0, i32 1
  store i64 0, i64* %t125
  %t126 = insertvalue %ObjectLiteralParseResult %t120, { %ObjectField**, i64 }* %t123, 1
  %t127 = insertvalue %ObjectLiteralParseResult %t126, i1 0, 2
  ret %ObjectLiteralParseResult %t127
merge11:
  %t128 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t129 = call %Token @expression_tokens_peek(%ExpressionTokens %t128)
  store %Token %t129, %Token* %l4
  %t131 = load %Token, %Token* %l4
  %t132 = extractvalue %Token %t131, 0
  %t133 = extractvalue %TokenKind %t132, 0
  %t134 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t135 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t133, 0
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t133, 1
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t133, 2
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t133, 3
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t133, 4
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t133, 5
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t133, 6
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t133, 7
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %s159 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.159, i32 0, i32 0
  %t160 = icmp ne i8* %t158, %s159
  br label %logical_or_entry_130

logical_or_entry_130:
  br i1 %t160, label %logical_or_merge_130, label %logical_or_right_130

logical_or_right_130:
  %t161 = load %Token, %Token* %l4
  %t162 = extractvalue %Token %t161, 0
  %t163 = extractvalue %TokenKind %t162, 0
  %t164 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t165 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t164)
  store %ExpressionTokens %t165, %ExpressionTokens* %l0
  %t166 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t167 = sitofp i64 0 to double
  %t168 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %t166, double %t167)
  store %ExpressionParseResult %t168, %ExpressionParseResult* %l5
  %t169 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  %t170 = extractvalue %ExpressionParseResult %t169, 2
  %t171 = xor i1 %t170, 1
  %t172 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t173 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  %t174 = load %Token, %Token* %l2
  %t175 = load i8*, i8** %l3
  %t176 = load %Token, %Token* %l4
  %t177 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  br i1 %t171, label %then12, label %merge13
then12:
  %t178 = insertvalue %ObjectLiteralParseResult undef, %ExpressionTokens %state, 0
  %t179 = alloca [0 x %ObjectField*]
  %t180 = getelementptr [0 x %ObjectField*], [0 x %ObjectField*]* %t179, i32 0, i32 0
  %t181 = alloca { %ObjectField**, i64 }
  %t182 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t181, i32 0, i32 0
  store %ObjectField** %t180, %ObjectField*** %t182
  %t183 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t181, i32 0, i32 1
  store i64 0, i64* %t183
  %t184 = insertvalue %ObjectLiteralParseResult %t178, { %ObjectField**, i64 }* %t181, 1
  %t185 = insertvalue %ObjectLiteralParseResult %t184, i1 0, 2
  ret %ObjectLiteralParseResult %t185
merge13:
  %t186 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  %t187 = extractvalue %ExpressionParseResult %t186, 0
  store %ExpressionTokens %t187, %ExpressionTokens* %l0
  %t188 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  %t189 = load i8*, i8** %l3
  %t190 = insertvalue %ObjectField undef, i8* %t189, 0
  %t191 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  %t192 = extractvalue %ExpressionParseResult %t191, 1
  %t193 = insertvalue %ObjectField %t190, %Expression %t192, 1
  %t194 = call { %ObjectField*, i64 }* @append_object_field({ %ObjectField*, i64 }* %t188, %ObjectField %t193)
  store { %ObjectField*, i64 }* %t194, { %ObjectField*, i64 }** %l1
  %t195 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t196 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t195)
  %t197 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t198 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  %t199 = load %Token, %Token* %l2
  %t200 = load i8*, i8** %l3
  %t201 = load %Token, %Token* %l4
  %t202 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  br i1 %t196, label %then14, label %merge15
then14:
  %t203 = insertvalue %ObjectLiteralParseResult undef, %ExpressionTokens %state, 0
  %t204 = alloca [0 x %ObjectField*]
  %t205 = getelementptr [0 x %ObjectField*], [0 x %ObjectField*]* %t204, i32 0, i32 0
  %t206 = alloca { %ObjectField**, i64 }
  %t207 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t206, i32 0, i32 0
  store %ObjectField** %t205, %ObjectField*** %t207
  %t208 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t206, i32 0, i32 1
  store i64 0, i64* %t208
  %t209 = insertvalue %ObjectLiteralParseResult %t203, { %ObjectField**, i64 }* %t206, 1
  %t210 = insertvalue %ObjectLiteralParseResult %t209, i1 0, 2
  ret %ObjectLiteralParseResult %t210
merge15:
  %t211 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t212 = call %Token @expression_tokens_peek(%ExpressionTokens %t211)
  store %Token %t212, %Token* %l6
  %t214 = load %Token, %Token* %l6
  %t215 = extractvalue %Token %t214, 0
  %t216 = extractvalue %TokenKind %t215, 0
  %t217 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t218 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t219 = icmp eq i32 %t216, 0
  %t220 = select i1 %t219, i8* %t218, i8* %t217
  %t221 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t222 = icmp eq i32 %t216, 1
  %t223 = select i1 %t222, i8* %t221, i8* %t220
  %t224 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t225 = icmp eq i32 %t216, 2
  %t226 = select i1 %t225, i8* %t224, i8* %t223
  %t227 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t228 = icmp eq i32 %t216, 3
  %t229 = select i1 %t228, i8* %t227, i8* %t226
  %t230 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t231 = icmp eq i32 %t216, 4
  %t232 = select i1 %t231, i8* %t230, i8* %t229
  %t233 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t234 = icmp eq i32 %t216, 5
  %t235 = select i1 %t234, i8* %t233, i8* %t232
  %t236 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t237 = icmp eq i32 %t216, 6
  %t238 = select i1 %t237, i8* %t236, i8* %t235
  %t239 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t240 = icmp eq i32 %t216, 7
  %t241 = select i1 %t240, i8* %t239, i8* %t238
  %s242 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.242, i32 0, i32 0
  %t243 = icmp eq i8* %t241, %s242
  br label %logical_and_entry_213

logical_and_entry_213:
  br i1 %t243, label %logical_and_right_213, label %logical_and_merge_213

logical_and_right_213:
  %t244 = load %Token, %Token* %l6
  %t245 = extractvalue %Token %t244, 0
  %t246 = extractvalue %TokenKind %t245, 0
  %t248 = load %Token, %Token* %l6
  %t249 = extractvalue %Token %t248, 0
  %t250 = extractvalue %TokenKind %t249, 0
  %t251 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t252 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t253 = icmp eq i32 %t250, 0
  %t254 = select i1 %t253, i8* %t252, i8* %t251
  %t255 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t256 = icmp eq i32 %t250, 1
  %t257 = select i1 %t256, i8* %t255, i8* %t254
  %t258 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t259 = icmp eq i32 %t250, 2
  %t260 = select i1 %t259, i8* %t258, i8* %t257
  %t261 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t262 = icmp eq i32 %t250, 3
  %t263 = select i1 %t262, i8* %t261, i8* %t260
  %t264 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t265 = icmp eq i32 %t250, 4
  %t266 = select i1 %t265, i8* %t264, i8* %t263
  %t267 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t268 = icmp eq i32 %t250, 5
  %t269 = select i1 %t268, i8* %t267, i8* %t266
  %t270 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t271 = icmp eq i32 %t250, 6
  %t272 = select i1 %t271, i8* %t270, i8* %t269
  %t273 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t274 = icmp eq i32 %t250, 7
  %t275 = select i1 %t274, i8* %t273, i8* %t272
  %s276 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.276, i32 0, i32 0
  %t277 = icmp eq i8* %t275, %s276
  br label %logical_and_entry_247

logical_and_entry_247:
  br i1 %t277, label %logical_and_right_247, label %logical_and_merge_247

logical_and_right_247:
  %t278 = load %Token, %Token* %l6
  %t279 = extractvalue %Token %t278, 0
  %t280 = extractvalue %TokenKind %t279, 0
  %t281 = insertvalue %ObjectLiteralParseResult undef, %ExpressionTokens %state, 0
  %t282 = alloca [0 x %ObjectField*]
  %t283 = getelementptr [0 x %ObjectField*], [0 x %ObjectField*]* %t282, i32 0, i32 0
  %t284 = alloca { %ObjectField**, i64 }
  %t285 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t284, i32 0, i32 0
  store %ObjectField** %t283, %ObjectField*** %t285
  %t286 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t284, i32 0, i32 1
  store i64 0, i64* %t286
  %t287 = insertvalue %ObjectLiteralParseResult %t281, { %ObjectField**, i64 }* %t284, 1
  %t288 = insertvalue %ObjectLiteralParseResult %t287, i1 0, 2
  ret %ObjectLiteralParseResult %t288
loop.latch4:
  %t289 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t290 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  br label %loop.header2
afterloop5:
  %t293 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t294 = insertvalue %ObjectLiteralParseResult undef, %ExpressionTokens %t293, 0
  %t295 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  %t296 = bitcast { %ObjectField*, i64 }* %t295 to { %ObjectField**, i64 }*
  %t297 = insertvalue %ObjectLiteralParseResult %t294, { %ObjectField**, i64 }* %t296, 1
  %t298 = insertvalue %ObjectLiteralParseResult %t297, i1 1, 2
  ret %ObjectLiteralParseResult %t298
}

define %ExpressionParseResult @parse_struct_literal(%ExpressionTokens %state, %Expression %target) {
entry:
  %l0 = alloca %StructTypeNameResult
  %l1 = alloca %ObjectLiteralParseResult
  %t0 = call %StructTypeNameResult @collect_struct_type_name(%Expression %target)
  store %StructTypeNameResult %t0, %StructTypeNameResult* %l0
  %t1 = load %StructTypeNameResult, %StructTypeNameResult* %l0
  %t2 = extractvalue %StructTypeNameResult %t1, 1
  %t3 = xor i1 %t2, 1
  %t4 = load %StructTypeNameResult, %StructTypeNameResult* %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t5
merge1:
  %t6 = call %ObjectLiteralParseResult @parse_object_literal(%ExpressionTokens %state)
  store %ObjectLiteralParseResult %t6, %ObjectLiteralParseResult* %l1
  %t7 = load %ObjectLiteralParseResult, %ObjectLiteralParseResult* %l1
  %t8 = extractvalue %ObjectLiteralParseResult %t7, 2
  %t9 = xor i1 %t8, 1
  %t10 = load %StructTypeNameResult, %StructTypeNameResult* %l0
  %t11 = load %ObjectLiteralParseResult, %ObjectLiteralParseResult* %l1
  br i1 %t9, label %then2, label %merge3
then2:
  %t12 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t12
merge3:
  %t13 = load %ObjectLiteralParseResult, %ObjectLiteralParseResult* %l1
  %t14 = extractvalue %ObjectLiteralParseResult %t13, 0
  %t15 = insertvalue %ExpressionParseResult undef, %ExpressionTokens %t14, 0
  %t16 = alloca %Expression
  %t17 = getelementptr inbounds %Expression, %Expression* %t16, i32 0, i32 0
  store i32 12, i32* %t17
  %t18 = load %StructTypeNameResult, %StructTypeNameResult* %l0
  %t19 = extractvalue %StructTypeNameResult %t18, 0
  %t20 = getelementptr inbounds %Expression, %Expression* %t16, i32 0, i32 1
  %t21 = bitcast [16 x i8]* %t20 to i8*
  %t22 = bitcast i8* %t21 to { i8**, i64 }**
  store { i8**, i64 }* %t19, { i8**, i64 }** %t22
  %t23 = load %ObjectLiteralParseResult, %ObjectLiteralParseResult* %l1
  %t24 = extractvalue %ObjectLiteralParseResult %t23, 1
  %t25 = getelementptr inbounds %Expression, %Expression* %t16, i32 0, i32 1
  %t26 = bitcast [16 x i8]* %t25 to i8*
  %t27 = getelementptr inbounds i8, i8* %t26, i64 8
  %t28 = bitcast i8* %t27 to { %ObjectField**, i64 }**
  store { %ObjectField**, i64 }* %t24, { %ObjectField**, i64 }** %t28
  %t29 = load %Expression, %Expression* %t16
  %t30 = insertvalue %ExpressionParseResult %t15, %Expression %t29, 1
  %t31 = insertvalue %ExpressionParseResult %t30, i1 1, 2
  ret %ExpressionParseResult %t31
}

define %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state) {
entry:
  %t0 = insertvalue %ExpressionParseResult undef, %ExpressionTokens %state, 0
  %t1 = alloca %Expression
  %t2 = getelementptr inbounds %Expression, %Expression* %t1, i32 0, i32 0
  store i32 15, i32* %t2
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  %t4 = getelementptr inbounds %Expression, %Expression* %t1, i32 0, i32 1
  %t5 = bitcast [8 x i8]* %t4 to i8*
  %t6 = bitcast i8* %t5 to i8**
  store i8* %s3, i8** %t6
  %t7 = load %Expression, %Expression* %t1
  %t8 = insertvalue %ExpressionParseResult %t0, %Expression %t7, 1
  %t9 = insertvalue %ExpressionParseResult %t8, i1 0, 2
  ret %ExpressionParseResult %t9
}

define i1 @expression_tokens_is_at_end(%ExpressionTokens %state) {
entry:
  %t0 = extractvalue %ExpressionTokens %state, 1
  %t1 = extractvalue %ExpressionTokens %state, 0
  %t2 = load { %Token**, i64 }, { %Token**, i64 }* %t1
  %t3 = extractvalue { %Token**, i64 } %t2, 1
  %t4 = sitofp i64 %t3 to double
  %t5 = fcmp oge double %t0, %t4
  ret i1 %t5
}

define %Token @expression_tokens_peek(%ExpressionTokens %state) {
entry:
  %t0 = extractvalue %ExpressionTokens %state, 0
  %t1 = extractvalue %ExpressionTokens %state, 1
  %t2 = fptosi double %t1 to i64
  %t3 = load { %Token**, i64 }, { %Token**, i64 }* %t0
  %t4 = extractvalue { %Token**, i64 } %t3, 0
  %t5 = extractvalue { %Token**, i64 } %t3, 1
  %t6 = icmp uge i64 %t2, %t5
  ; bounds check: %t6 (if true, out of bounds)
  %t7 = getelementptr %Token*, %Token** %t4, i64 %t2
  %t8 = load %Token*, %Token** %t7
  %t9 = load %Token, %Token* %t8
  ret %Token %t9
}

define %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %state) {
entry:
  %t0 = extractvalue %ExpressionTokens %state, 1
  %t1 = extractvalue %ExpressionTokens %state, 0
  %t2 = load { %Token**, i64 }, { %Token**, i64 }* %t1
  %t3 = extractvalue { %Token**, i64 } %t2, 1
  %t4 = sitofp i64 %t3 to double
  %t5 = fcmp oge double %t0, %t4
  br i1 %t5, label %then0, label %merge1
then0:
  ret %ExpressionTokens %state
merge1:
  ret %ExpressionTokens zeroinitializer
}

define i1 @expression_is_struct_target(%Expression %expression) {
entry:
  %t0 = extractvalue %Expression %expression, 0
  %t1 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t2 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t3 = icmp eq i32 %t0, 0
  %t4 = select i1 %t3, i8* %t2, i8* %t1
  %t5 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t6 = icmp eq i32 %t0, 1
  %t7 = select i1 %t6, i8* %t5, i8* %t4
  %t8 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t9 = icmp eq i32 %t0, 2
  %t10 = select i1 %t9, i8* %t8, i8* %t7
  %t11 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t12 = icmp eq i32 %t0, 3
  %t13 = select i1 %t12, i8* %t11, i8* %t10
  %t14 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t15 = icmp eq i32 %t0, 4
  %t16 = select i1 %t15, i8* %t14, i8* %t13
  %t17 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t0, 5
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t0, 6
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t0, 7
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t0, 8
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t0, 9
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t0, 10
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t0, 11
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t0, 12
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t0, 13
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t0, 14
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t0, 15
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %s50 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.50, i32 0, i32 0
  %t51 = icmp eq i8* %t49, %s50
  br i1 %t51, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t52 = extractvalue %Expression %expression, 0
  %t53 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t54 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t55 = icmp eq i32 %t52, 0
  %t56 = select i1 %t55, i8* %t54, i8* %t53
  %t57 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t58 = icmp eq i32 %t52, 1
  %t59 = select i1 %t58, i8* %t57, i8* %t56
  %t60 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t61 = icmp eq i32 %t52, 2
  %t62 = select i1 %t61, i8* %t60, i8* %t59
  %t63 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t52, 3
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t52, 4
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t52, 5
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t52, 6
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t52, 7
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t52, 8
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %t81 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t52, 9
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t52, 10
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %t87 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t88 = icmp eq i32 %t52, 11
  %t89 = select i1 %t88, i8* %t87, i8* %t86
  %t90 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t91 = icmp eq i32 %t52, 12
  %t92 = select i1 %t91, i8* %t90, i8* %t89
  %t93 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t52, 13
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %t96 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t97 = icmp eq i32 %t52, 14
  %t98 = select i1 %t97, i8* %t96, i8* %t95
  %t99 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t52, 15
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %s102 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.102, i32 0, i32 0
  %t103 = icmp eq i8* %t101, %s102
  br i1 %t103, label %then2, label %merge3
then2:
  %t104 = extractvalue %Expression %expression, 0
  %t105 = alloca %Expression
  store %Expression %expression, %Expression* %t105
  %t106 = getelementptr inbounds %Expression, %Expression* %t105, i32 0, i32 1
  %t107 = bitcast [16 x i8]* %t106 to i8*
  %t108 = bitcast i8* %t107 to %Expression*
  %t109 = load %Expression, %Expression* %t108
  %t110 = icmp eq i32 %t104, 7
  %t111 = select i1 %t110, %Expression %t109, %Expression zeroinitializer
  %t112 = call i1 @expression_is_struct_target(%Expression %t111)
  ret i1 %t112
merge3:
  ret i1 0
}

define %StructTypeNameResult @collect_struct_type_name(%Expression %expression) {
entry:
  %l0 = alloca %StructTypeNameResult
  %t0 = extractvalue %Expression %expression, 0
  %t1 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t2 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t3 = icmp eq i32 %t0, 0
  %t4 = select i1 %t3, i8* %t2, i8* %t1
  %t5 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t6 = icmp eq i32 %t0, 1
  %t7 = select i1 %t6, i8* %t5, i8* %t4
  %t8 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t9 = icmp eq i32 %t0, 2
  %t10 = select i1 %t9, i8* %t8, i8* %t7
  %t11 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t12 = icmp eq i32 %t0, 3
  %t13 = select i1 %t12, i8* %t11, i8* %t10
  %t14 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t15 = icmp eq i32 %t0, 4
  %t16 = select i1 %t15, i8* %t14, i8* %t13
  %t17 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t0, 5
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t0, 6
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t0, 7
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t0, 8
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t0, 9
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t0, 10
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t0, 11
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t0, 12
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t0, 13
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t0, 14
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t0, 15
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %s50 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.50, i32 0, i32 0
  %t51 = icmp eq i8* %t49, %s50
  br i1 %t51, label %then0, label %merge1
then0:
  %t52 = extractvalue %Expression %expression, 0
  %t53 = alloca %Expression
  store %Expression %expression, %Expression* %t53
  %t54 = getelementptr inbounds %Expression, %Expression* %t53, i32 0, i32 1
  %t55 = bitcast [8 x i8]* %t54 to i8*
  %t56 = bitcast i8* %t55 to i8**
  %t57 = load i8*, i8** %t56
  %t58 = icmp eq i32 %t52, 0
  %t59 = select i1 %t58, i8* %t57, i8* null
  %t60 = alloca [1 x i8*]
  %t61 = getelementptr [1 x i8*], [1 x i8*]* %t60, i32 0, i32 0
  %t62 = getelementptr i8*, i8** %t61, i64 0
  store i8* %t59, i8** %t62
  %t63 = alloca { i8**, i64 }
  %t64 = getelementptr { i8**, i64 }, { i8**, i64 }* %t63, i32 0, i32 0
  store i8** %t61, i8*** %t64
  %t65 = getelementptr { i8**, i64 }, { i8**, i64 }* %t63, i32 0, i32 1
  store i64 1, i64* %t65
  %t66 = insertvalue %StructTypeNameResult undef, { i8**, i64 }* %t63, 0
  %t67 = insertvalue %StructTypeNameResult %t66, i1 1, 1
  ret %StructTypeNameResult %t67
merge1:
  %t68 = extractvalue %Expression %expression, 0
  %t69 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t70 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t68, 0
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t68, 1
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %t76 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t68, 2
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %t79 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t68, 3
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t68, 4
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %t85 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t68, 5
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t68, 6
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t68, 7
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t68, 8
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t68, 9
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %t100 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t68, 10
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %t103 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t104 = icmp eq i32 %t68, 11
  %t105 = select i1 %t104, i8* %t103, i8* %t102
  %t106 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t107 = icmp eq i32 %t68, 12
  %t108 = select i1 %t107, i8* %t106, i8* %t105
  %t109 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t110 = icmp eq i32 %t68, 13
  %t111 = select i1 %t110, i8* %t109, i8* %t108
  %t112 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t113 = icmp eq i32 %t68, 14
  %t114 = select i1 %t113, i8* %t112, i8* %t111
  %t115 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t116 = icmp eq i32 %t68, 15
  %t117 = select i1 %t116, i8* %t115, i8* %t114
  %s118 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.118, i32 0, i32 0
  %t119 = icmp eq i8* %t117, %s118
  br i1 %t119, label %then2, label %merge3
then2:
  %t120 = extractvalue %Expression %expression, 0
  %t121 = alloca %Expression
  store %Expression %expression, %Expression* %t121
  %t122 = getelementptr inbounds %Expression, %Expression* %t121, i32 0, i32 1
  %t123 = bitcast [16 x i8]* %t122 to i8*
  %t124 = bitcast i8* %t123 to %Expression*
  %t125 = load %Expression, %Expression* %t124
  %t126 = icmp eq i32 %t120, 7
  %t127 = select i1 %t126, %Expression %t125, %Expression zeroinitializer
  %t128 = call %StructTypeNameResult @collect_struct_type_name(%Expression %t127)
  store %StructTypeNameResult %t128, %StructTypeNameResult* %l0
  %t129 = load %StructTypeNameResult, %StructTypeNameResult* %l0
  %t130 = extractvalue %StructTypeNameResult %t129, 1
  %t131 = xor i1 %t130, 1
  %t132 = load %StructTypeNameResult, %StructTypeNameResult* %l0
  br i1 %t131, label %then4, label %merge5
then4:
  %t133 = alloca [0 x i8*]
  %t134 = getelementptr [0 x i8*], [0 x i8*]* %t133, i32 0, i32 0
  %t135 = alloca { i8**, i64 }
  %t136 = getelementptr { i8**, i64 }, { i8**, i64 }* %t135, i32 0, i32 0
  store i8** %t134, i8*** %t136
  %t137 = getelementptr { i8**, i64 }, { i8**, i64 }* %t135, i32 0, i32 1
  store i64 0, i64* %t137
  %t138 = insertvalue %StructTypeNameResult undef, { i8**, i64 }* %t135, 0
  %t139 = insertvalue %StructTypeNameResult %t138, i1 0, 1
  ret %StructTypeNameResult %t139
merge5:
  %t140 = load %StructTypeNameResult, %StructTypeNameResult* %l0
  %t141 = extractvalue %StructTypeNameResult %t140, 0
  %t142 = extractvalue %Expression %expression, 0
  %t143 = alloca %Expression
  store %Expression %expression, %Expression* %t143
  %t144 = getelementptr inbounds %Expression, %Expression* %t143, i32 0, i32 1
  %t145 = bitcast [16 x i8]* %t144 to i8*
  %t146 = getelementptr inbounds i8, i8* %t145, i64 8
  %t147 = bitcast i8* %t146 to i8**
  %t148 = load i8*, i8** %t147
  %t149 = icmp eq i32 %t142, 7
  %t150 = select i1 %t149, i8* %t148, i8* null
  %t151 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t141, i8* %t150)
  %t152 = insertvalue %StructTypeNameResult undef, { i8**, i64 }* %t151, 0
  %t153 = insertvalue %StructTypeNameResult %t152, i1 1, 1
  ret %StructTypeNameResult %t153
merge3:
  %t154 = alloca [0 x i8*]
  %t155 = getelementptr [0 x i8*], [0 x i8*]* %t154, i32 0, i32 0
  %t156 = alloca { i8**, i64 }
  %t157 = getelementptr { i8**, i64 }, { i8**, i64 }* %t156, i32 0, i32 0
  store i8** %t155, i8*** %t157
  %t158 = getelementptr { i8**, i64 }, { i8**, i64 }* %t156, i32 0, i32 1
  store i64 0, i64* %t158
  %t159 = insertvalue %StructTypeNameResult undef, { i8**, i64 }* %t156, 0
  %t160 = insertvalue %StructTypeNameResult %t159, i1 0, 1
  ret %StructTypeNameResult %t160
}

define double @binary_precedence(i8* %op) {
entry:
  %s0 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.0, i32 0, i32 0
  %t1 = icmp eq i8* %op, %s0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = sitofp i64 0 to double
  ret double %t2
merge1:
  %s3 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.3, i32 0, i32 0
  %t4 = icmp eq i8* %op, %s3
  br i1 %t4, label %then2, label %merge3
then2:
  %t5 = sitofp i64 1 to double
  ret double %t5
merge3:
  %s6 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.6, i32 0, i32 0
  %t7 = icmp eq i8* %op, %s6
  br i1 %t7, label %then4, label %merge5
then4:
  %t8 = sitofp i64 2 to double
  ret double %t8
merge5:
  %s10 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.10, i32 0, i32 0
  %t11 = icmp eq i8* %op, %s10
  br label %logical_or_entry_9

logical_or_entry_9:
  br i1 %t11, label %logical_or_merge_9, label %logical_or_right_9

logical_or_right_9:
  %s12 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.12, i32 0, i32 0
  %t13 = icmp eq i8* %op, %s12
  br label %logical_or_right_end_9

logical_or_right_end_9:
  br label %logical_or_merge_9

logical_or_merge_9:
  %t14 = phi i1 [ true, %logical_or_entry_9 ], [ %t13, %logical_or_right_end_9 ]
  br i1 %t14, label %then6, label %merge7
then6:
  %t15 = sitofp i64 3 to double
  ret double %t15
merge7:
  %t17 = load i8, i8* %op
  %t18 = icmp eq i8 %t17, 60
  br label %logical_or_entry_16

logical_or_entry_16:
  br i1 %t18, label %logical_or_merge_16, label %logical_or_right_16

logical_or_right_16:
  %s20 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.20, i32 0, i32 0
  %t21 = icmp eq i8* %op, %s20
  br label %logical_or_entry_19

logical_or_entry_19:
  br i1 %t21, label %logical_or_merge_19, label %logical_or_right_19

logical_or_right_19:
  %t23 = load i8, i8* %op
  %t24 = icmp eq i8 %t23, 62
  br label %logical_or_entry_22

logical_or_entry_22:
  br i1 %t24, label %logical_or_merge_22, label %logical_or_right_22

logical_or_right_22:
  %s25 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.25, i32 0, i32 0
  %t26 = icmp eq i8* %op, %s25
  br label %logical_or_right_end_22

logical_or_right_end_22:
  br label %logical_or_merge_22

logical_or_merge_22:
  %t27 = phi i1 [ true, %logical_or_entry_22 ], [ %t26, %logical_or_right_end_22 ]
  br label %logical_or_right_end_19

logical_or_right_end_19:
  br label %logical_or_merge_19

logical_or_merge_19:
  %t28 = phi i1 [ true, %logical_or_entry_19 ], [ %t27, %logical_or_right_end_19 ]
  br label %logical_or_right_end_16

logical_or_right_end_16:
  br label %logical_or_merge_16

logical_or_merge_16:
  %t29 = phi i1 [ true, %logical_or_entry_16 ], [ %t28, %logical_or_right_end_16 ]
  br i1 %t29, label %then8, label %merge9
then8:
  %t30 = sitofp i64 4 to double
  ret double %t30
merge9:
  %t32 = load i8, i8* %op
  %t33 = icmp eq i8 %t32, 43
  br label %logical_or_entry_31

logical_or_entry_31:
  br i1 %t33, label %logical_or_merge_31, label %logical_or_right_31

logical_or_right_31:
  %t34 = load i8, i8* %op
  %t35 = icmp eq i8 %t34, 45
  br label %logical_or_right_end_31

logical_or_right_end_31:
  br label %logical_or_merge_31

logical_or_merge_31:
  %t36 = phi i1 [ true, %logical_or_entry_31 ], [ %t35, %logical_or_right_end_31 ]
  br i1 %t36, label %then10, label %merge11
then10:
  %t37 = sitofp i64 5 to double
  ret double %t37
merge11:
  %t39 = load i8, i8* %op
  %t40 = icmp eq i8 %t39, 42
  br label %logical_or_entry_38

logical_or_entry_38:
  br i1 %t40, label %logical_or_merge_38, label %logical_or_right_38

logical_or_right_38:
  %t42 = load i8, i8* %op
  %t43 = icmp eq i8 %t42, 47
  br label %logical_or_entry_41

logical_or_entry_41:
  br i1 %t43, label %logical_or_merge_41, label %logical_or_right_41

logical_or_right_41:
  %t44 = load i8, i8* %op
  %t45 = icmp eq i8 %t44, 37
  br label %logical_or_right_end_41

logical_or_right_end_41:
  br label %logical_or_merge_41

logical_or_merge_41:
  %t46 = phi i1 [ true, %logical_or_entry_41 ], [ %t45, %logical_or_right_end_41 ]
  br label %logical_or_right_end_38

logical_or_right_end_38:
  br label %logical_or_merge_38

logical_or_merge_38:
  %t47 = phi i1 [ true, %logical_or_entry_38 ], [ %t46, %logical_or_right_end_38 ]
  br i1 %t47, label %then12, label %merge13
then12:
  %t48 = sitofp i64 6 to double
  ret double %t48
merge13:
  %t49 = sitofp i64 -1 to double
  ret double %t49
}

define double @unary_precedence() {
entry:
  %t0 = sitofp i64 7 to double
  ret double %t0
}

define { %Token*, i64 }* @filter_trivia({ %Token*, i64 }* %tokens) {
entry:
  %l0 = alloca double
  %l1 = alloca { %Token*, i64 }*
  %l2 = alloca %Token
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = alloca [0 x %Token]
  %t2 = getelementptr [0 x %Token], [0 x %Token]* %t1, i32 0, i32 0
  %t3 = alloca { %Token*, i64 }
  %t4 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t3, i32 0, i32 0
  store %Token* %t2, %Token** %t4
  %t5 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { %Token*, i64 }* %t3, { %Token*, i64 }** %l1
  %t6 = load double, double* %l0
  %t7 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t129 = phi { %Token*, i64 }* [ %t7, %entry ], [ %t127, %loop.latch2 ]
  %t130 = phi double [ %t6, %entry ], [ %t128, %loop.latch2 ]
  store { %Token*, i64 }* %t129, { %Token*, i64 }** %l1
  store double %t130, double* %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l0
  %t9 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t10 = extractvalue { %Token*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load double, double* %l0
  %t14 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l0
  %t16 = fptosi double %t15 to i64
  %t17 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t18 = extractvalue { %Token*, i64 } %t17, 0
  %t19 = extractvalue { %Token*, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr %Token, %Token* %t18, i64 %t16
  %t22 = load %Token, %Token* %t21
  store %Token %t22, %Token* %l2
  %t24 = load %Token, %Token* %l2
  %t25 = extractvalue %Token %t24, 0
  %t26 = extractvalue %TokenKind %t25, 0
  %t27 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t28 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t26, 0
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %t31 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t32 = icmp eq i32 %t26, 1
  %t33 = select i1 %t32, i8* %t31, i8* %t30
  %t34 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t26, 2
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %t37 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t26, 3
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %t40 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t41 = icmp eq i32 %t26, 4
  %t42 = select i1 %t41, i8* %t40, i8* %t39
  %t43 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t44 = icmp eq i32 %t26, 5
  %t45 = select i1 %t44, i8* %t43, i8* %t42
  %t46 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t47 = icmp eq i32 %t26, 6
  %t48 = select i1 %t47, i8* %t46, i8* %t45
  %t49 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t50 = icmp eq i32 %t26, 7
  %t51 = select i1 %t50, i8* %t49, i8* %t48
  %s52 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.52, i32 0, i32 0
  %t53 = icmp ne i8* %t51, %s52
  br label %logical_and_entry_23

logical_and_entry_23:
  br i1 %t53, label %logical_and_right_23, label %logical_and_merge_23

logical_and_right_23:
  %t55 = load %Token, %Token* %l2
  %t56 = extractvalue %Token %t55, 0
  %t57 = extractvalue %TokenKind %t56, 0
  %t58 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t59 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t60 = icmp eq i32 %t57, 0
  %t61 = select i1 %t60, i8* %t59, i8* %t58
  %t62 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t57, 1
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t57, 2
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t57, 3
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t57, 4
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t75 = icmp eq i32 %t57, 5
  %t76 = select i1 %t75, i8* %t74, i8* %t73
  %t77 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t78 = icmp eq i32 %t57, 6
  %t79 = select i1 %t78, i8* %t77, i8* %t76
  %t80 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t81 = icmp eq i32 %t57, 7
  %t82 = select i1 %t81, i8* %t80, i8* %t79
  %s83 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.83, i32 0, i32 0
  %t84 = icmp ne i8* %t82, %s83
  br label %logical_and_entry_54

logical_and_entry_54:
  br i1 %t84, label %logical_and_right_54, label %logical_and_merge_54

logical_and_right_54:
  %t85 = load %Token, %Token* %l2
  %t86 = extractvalue %Token %t85, 0
  %t87 = extractvalue %TokenKind %t86, 0
  %t88 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t89 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t90 = icmp eq i32 %t87, 0
  %t91 = select i1 %t90, i8* %t89, i8* %t88
  %t92 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t93 = icmp eq i32 %t87, 1
  %t94 = select i1 %t93, i8* %t92, i8* %t91
  %t95 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t87, 2
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %t98 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t87, 3
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t87, 4
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t87, 5
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t87, 6
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t87, 7
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %s113 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.113, i32 0, i32 0
  %t114 = icmp ne i8* %t112, %s113
  br label %logical_and_right_end_54

logical_and_right_end_54:
  br label %logical_and_merge_54

logical_and_merge_54:
  %t115 = phi i1 [ false, %logical_and_entry_54 ], [ %t114, %logical_and_right_end_54 ]
  br label %logical_and_right_end_23

logical_and_right_end_23:
  br label %logical_and_merge_23

logical_and_merge_23:
  %t116 = phi i1 [ false, %logical_and_entry_23 ], [ %t115, %logical_and_right_end_23 ]
  %t117 = load double, double* %l0
  %t118 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t119 = load %Token, %Token* %l2
  br i1 %t116, label %then6, label %merge7
then6:
  %t120 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t121 = load %Token, %Token* %l2
  %t122 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t120, %Token %t121)
  store { %Token*, i64 }* %t122, { %Token*, i64 }** %l1
  br label %merge7
merge7:
  %t123 = phi { %Token*, i64 }* [ %t122, %then6 ], [ %t118, %loop.body1 ]
  store { %Token*, i64 }* %t123, { %Token*, i64 }** %l1
  %t124 = load double, double* %l0
  %t125 = sitofp i64 1 to double
  %t126 = fadd double %t124, %t125
  store double %t126, double* %l0
  br label %loop.latch2
loop.latch2:
  %t127 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t128 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t131 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  ret { %Token*, i64 }* %t131
}

define i8* @tokens_to_text({ %Token*, i64 }* %tokens) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t27 = phi i8* [ %t2, %entry ], [ %t25, %loop.latch2 ]
  %t28 = phi double [ %t3, %entry ], [ %t26, %loop.latch2 ]
  store i8* %t27, i8** %l0
  store double %t28, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t6 = extractvalue { %Token*, i64 } %t5, 1
  %t7 = sitofp i64 %t6 to double
  %t8 = fcmp oge double %t4, %t7
  %t9 = load i8*, i8** %l0
  %t10 = load double, double* %l1
  br i1 %t8, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  %t13 = fptosi double %t12 to i64
  %t14 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t15 = extractvalue { %Token*, i64 } %t14, 0
  %t16 = extractvalue { %Token*, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  %t18 = getelementptr %Token, %Token* %t15, i64 %t13
  %t19 = load %Token, %Token* %t18
  %t20 = extractvalue %Token %t19, 1
  %t21 = add i8* %t11, %t20
  store i8* %t21, i8** %l0
  %t22 = load double, double* %l1
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l1
  br label %loop.latch2
loop.latch2:
  %t25 = load i8*, i8** %l0
  %t26 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t29 = load i8*, i8** %l0
  ret i8* %t29
}

define i8* @trim_text(i8* %value) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
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
  %t11 = call double @char_at(i8* %value, double %t10)
  store double %t11, double* %l2
  %t12 = load double, double* %l2
  %t13 = call i1 @is_trim_whitespace(i8* null)
  %t14 = load double, double* %l0
  %t15 = load double, double* %l1
  %t16 = load double, double* %l2
  br i1 %t13, label %then6, label %merge7
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
  %t42 = phi double [ %t23, %entry ], [ %t41, %loop.latch10 ]
  store double %t42, double* %l1
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
  %t29 = load double, double* %l1
  %t30 = sitofp i64 1 to double
  %t31 = fsub double %t29, %t30
  %t32 = call double @char_at(i8* %value, double %t31)
  store double %t32, double* %l3
  %t33 = load double, double* %l3
  %t34 = call i1 @is_trim_whitespace(i8* null)
  %t35 = load double, double* %l0
  %t36 = load double, double* %l1
  %t37 = load double, double* %l3
  br i1 %t34, label %then14, label %merge15
then14:
  %t38 = load double, double* %l1
  %t39 = sitofp i64 1 to double
  %t40 = fsub double %t38, %t39
  store double %t40, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t41 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t43 = load double, double* %l0
  %t44 = load double, double* %l1
  %t45 = fptosi double %t43 to i64
  %t46 = fptosi double %t44 to i64
  %t47 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t45, i64 %t46)
  ret i8* %t47
}

define i1 @is_trim_whitespace(i8* %ch) {
entry:
  %l0 = alloca double
  %t0 = call double @char_code(i8* %ch)
  store double %t0, double* %l0
  %t2 = load double, double* %l0
  %t3 = sitofp i64 32 to double
  %t4 = fcmp oeq double %t2, %t3
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t4, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %t6 = load double, double* %l0
  %t7 = sitofp i64 10 to double
  %t8 = fcmp oeq double %t6, %t7
  br label %logical_or_entry_5

logical_or_entry_5:
  br i1 %t8, label %logical_or_merge_5, label %logical_or_right_5

logical_or_right_5:
  %t10 = load double, double* %l0
  %t11 = sitofp i64 9 to double
  %t12 = fcmp oeq double %t10, %t11
  br label %logical_or_entry_9

logical_or_entry_9:
  br i1 %t12, label %logical_or_merge_9, label %logical_or_right_9

logical_or_right_9:
  %t13 = load double, double* %l0
  %t14 = sitofp i64 13 to double
  %t15 = fcmp oeq double %t13, %t14
  br label %logical_or_right_end_9

logical_or_right_end_9:
  br label %logical_or_merge_9

logical_or_merge_9:
  %t16 = phi i1 [ true, %logical_or_entry_9 ], [ %t15, %logical_or_right_end_9 ]
  br label %logical_or_right_end_5

logical_or_right_end_5:
  br label %logical_or_merge_5

logical_or_merge_5:
  %t17 = phi i1 [ true, %logical_or_entry_5 ], [ %t16, %logical_or_right_end_5 ]
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t18 = phi i1 [ true, %logical_or_entry_1 ], [ %t17, %logical_or_right_end_1 ]
  ret i1 %t18
}

define i1 @string_array_contains({ i8**, i64 }* %values, i8* %target) {
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
  %t3 = load { i8**, i64 }, { i8**, i64 }* %values
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
  %t10 = load { i8**, i64 }, { i8**, i64 }* %values
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  %t16 = icmp eq i8* %t15, %target
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
  ret i1 0
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
  %s28 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.28, i32 0, i32 0
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
  %s57 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.57, i32 0, i32 0
  %t58 = icmp eq i8* %t56, %s57
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t59 = phi i1 [ true, %logical_or_entry_0 ], [ %t58, %logical_or_right_end_0 ]
  br i1 %t59, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t60 = extractvalue %Token %token, 0
  %t61 = extractvalue %TokenKind %t60, 0
  %t62 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t63 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t61, 0
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t61, 1
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t61, 2
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t61, 3
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t61, 4
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t61, 5
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %t81 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t61, 6
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t61, 7
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %s87 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.87, i32 0, i32 0
  %t88 = icmp eq i8* %t86, %s87
  br i1 %t88, label %then2, label %merge3
then2:
  %t89 = extractvalue %Token %token, 1
  %t90 = call i1 @is_whitespace_lexeme(i8* %t89)
  br i1 %t90, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  br label %merge3
merge3:
  ret i1 0
}

define i1 @is_whitespace_lexeme(i8* %text) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l0
  %t3 = load double, double* %l0
  br label %loop.header2
loop.header2:
  %t20 = phi double [ %t3, %entry ], [ %t19, %loop.latch4 ]
  store double %t20, double* %l0
  br label %loop.body3
loop.body3:
  %t4 = load double, double* %l0
  %t5 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t4, %t6
  %t8 = load double, double* %l0
  br i1 %t7, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t9 = load double, double* %l0
  %t10 = call double @char_at(i8* %text, double %t9)
  store double %t10, double* %l1
  %t11 = load double, double* %l1
  %t12 = call i1 @is_trim_whitespace(i8* null)
  %t13 = xor i1 %t12, 1
  %t14 = load double, double* %l0
  %t15 = load double, double* %l1
  br i1 %t13, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t16 = load double, double* %l0
  %t17 = sitofp i64 1 to double
  %t18 = fadd double %t16, %t17
  store double %t18, double* %l0
  br label %loop.latch4
loop.latch4:
  %t19 = load double, double* %l0
  br label %loop.header2
afterloop5:
  ret i1 1
}

define %Parser @advance_to_symbol(%Parser %parser, i8* %symbol) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  %l2 = alloca %Parser
  store %Parser %parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  br label %loop.header0
loop.header0:
  %t85 = phi %Parser [ %t0, %entry ], [ %t84, %loop.latch2 ]
  store %Parser %t85, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Parser @skip_trivia(%Parser %t1)
  store %Parser %t2, %Parser* %l0
  %t3 = load %Parser, %Parser* %l0
  %t4 = call %Token @parser_peek_raw(%Parser %t3)
  store %Token %t4, %Token* %l1
  %t6 = load %Token, %Token* %l1
  %t7 = extractvalue %Token %t6, 0
  %t8 = extractvalue %TokenKind %t7, 0
  %t9 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t10 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t11 = icmp eq i32 %t8, 0
  %t12 = select i1 %t11, i8* %t10, i8* %t9
  %t13 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t14 = icmp eq i32 %t8, 1
  %t15 = select i1 %t14, i8* %t13, i8* %t12
  %t16 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t17 = icmp eq i32 %t8, 2
  %t18 = select i1 %t17, i8* %t16, i8* %t15
  %t19 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t20 = icmp eq i32 %t8, 3
  %t21 = select i1 %t20, i8* %t19, i8* %t18
  %t22 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t23 = icmp eq i32 %t8, 4
  %t24 = select i1 %t23, i8* %t22, i8* %t21
  %t25 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t8, 5
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t8, 6
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %t31 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t32 = icmp eq i32 %t8, 7
  %t33 = select i1 %t32, i8* %t31, i8* %t30
  %s34 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.34, i32 0, i32 0
  %t35 = icmp eq i8* %t33, %s34
  br label %logical_and_entry_5

logical_and_entry_5:
  br i1 %t35, label %logical_and_right_5, label %logical_and_merge_5

logical_and_right_5:
  %t36 = load %Token, %Token* %l1
  %t37 = extractvalue %Token %t36, 0
  %t38 = extractvalue %TokenKind %t37, 0
  %t39 = load %Token, %Token* %l1
  %t40 = extractvalue %Token %t39, 0
  %t41 = extractvalue %TokenKind %t40, 0
  %t42 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t43 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t44 = icmp eq i32 %t41, 0
  %t45 = select i1 %t44, i8* %t43, i8* %t42
  %t46 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t47 = icmp eq i32 %t41, 1
  %t48 = select i1 %t47, i8* %t46, i8* %t45
  %t49 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t50 = icmp eq i32 %t41, 2
  %t51 = select i1 %t50, i8* %t49, i8* %t48
  %t52 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t53 = icmp eq i32 %t41, 3
  %t54 = select i1 %t53, i8* %t52, i8* %t51
  %t55 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t41, 4
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t41, 5
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t41, 6
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t41, 7
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %s67 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.67, i32 0, i32 0
  %t68 = icmp eq i8* %t66, %s67
  %t69 = load %Parser, %Parser* %l0
  %t70 = load %Token, %Token* %l1
  br i1 %t68, label %then4, label %merge5
then4:
  %t71 = load %Parser, %Parser* %l0
  ret %Parser %t71
merge5:
  %t72 = load %Parser, %Parser* %l0
  %t73 = call %Parser @parser_advance_raw(%Parser %t72)
  store %Parser %t73, %Parser* %l2
  %t74 = load %Parser, %Parser* %l2
  %t75 = extractvalue %Parser %t74, 1
  %t76 = load %Parser, %Parser* %l0
  %t77 = extractvalue %Parser %t76, 1
  %t78 = fcmp oeq double %t75, %t77
  %t79 = load %Parser, %Parser* %l0
  %t80 = load %Token, %Token* %l1
  %t81 = load %Parser, %Parser* %l2
  br i1 %t78, label %then6, label %merge7
then6:
  %t82 = load %Parser, %Parser* %l0
  ret %Parser %t82
merge7:
  %t83 = load %Parser, %Parser* %l2
  store %Parser %t83, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t84 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  ret %Parser zeroinitializer
}

define %Parser @skip_struct_member(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %Token
  %l3 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  br label %loop.header0
loop.header0:
  %t87 = phi %Parser [ %t0, %entry ], [ %t86, %loop.latch2 ]
  store %Parser %t87, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Parser @parser_advance_raw(%Parser %t1)
  store %Parser %t2, %Parser* %l1
  %t3 = load %Parser, %Parser* %l1
  %t4 = extractvalue %Parser %t3, 1
  %t5 = load %Parser, %Parser* %l0
  %t6 = extractvalue %Parser %t5, 1
  %t7 = fcmp oeq double %t4, %t6
  %t8 = load %Parser, %Parser* %l0
  %t9 = load %Parser, %Parser* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  %t10 = load %Parser, %Parser* %l0
  ret %Parser %t10
merge5:
  %t11 = load %Parser, %Parser* %l1
  store %Parser %t11, %Parser* %l0
  %t12 = load %Parser, %Parser* %l0
  %t13 = call %Token @parser_peek_raw(%Parser %t12)
  store %Token %t13, %Token* %l2
  %t14 = load %Token, %Token* %l2
  %t15 = extractvalue %Token %t14, 0
  %t16 = extractvalue %TokenKind %t15, 0
  %t17 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t18 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t19 = icmp eq i32 %t16, 0
  %t20 = select i1 %t19, i8* %t18, i8* %t17
  %t21 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t22 = icmp eq i32 %t16, 1
  %t23 = select i1 %t22, i8* %t21, i8* %t20
  %t24 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t16, 2
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %t27 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t28 = icmp eq i32 %t16, 3
  %t29 = select i1 %t28, i8* %t27, i8* %t26
  %t30 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t31 = icmp eq i32 %t16, 4
  %t32 = select i1 %t31, i8* %t30, i8* %t29
  %t33 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t34 = icmp eq i32 %t16, 5
  %t35 = select i1 %t34, i8* %t33, i8* %t32
  %t36 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t37 = icmp eq i32 %t16, 6
  %t38 = select i1 %t37, i8* %t36, i8* %t35
  %t39 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t40 = icmp eq i32 %t16, 7
  %t41 = select i1 %t40, i8* %t39, i8* %t38
  %s42 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.42, i32 0, i32 0
  %t43 = icmp eq i8* %t41, %s42
  %t44 = load %Parser, %Parser* %l0
  %t45 = load %Parser, %Parser* %l1
  %t46 = load %Token, %Token* %l2
  br i1 %t43, label %then6, label %merge7
then6:
  %t47 = load %Parser, %Parser* %l0
  ret %Parser %t47
merge7:
  %t48 = load %Token, %Token* %l2
  %t49 = extractvalue %Token %t48, 0
  %t50 = extractvalue %TokenKind %t49, 0
  %t51 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t52 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t53 = icmp eq i32 %t50, 0
  %t54 = select i1 %t53, i8* %t52, i8* %t51
  %t55 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t50, 1
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t50, 2
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t50, 3
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t50, 4
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t50, 5
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t50, 6
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t50, 7
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %s76 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.76, i32 0, i32 0
  %t77 = icmp eq i8* %t75, %s76
  %t78 = load %Parser, %Parser* %l0
  %t79 = load %Parser, %Parser* %l1
  %t80 = load %Token, %Token* %l2
  br i1 %t77, label %then8, label %merge9
then8:
  %t81 = load %Token, %Token* %l2
  %t82 = extractvalue %Token %t81, 0
  %t83 = extractvalue %TokenKind %t82, 0
  store double 0.0, double* %l3
  %t84 = load double, double* %l3
  %t85 = load double, double* %l3
  br label %merge9
merge9:
  br label %loop.latch2
loop.latch2:
  %t86 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  ret %Parser zeroinitializer
}

define %Parser @skip_enum_variant_entry(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %Token
  %l3 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  br label %loop.header0
loop.header0:
  %t87 = phi %Parser [ %t0, %entry ], [ %t86, %loop.latch2 ]
  store %Parser %t87, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Parser @parser_advance_raw(%Parser %t1)
  store %Parser %t2, %Parser* %l1
  %t3 = load %Parser, %Parser* %l1
  %t4 = extractvalue %Parser %t3, 1
  %t5 = load %Parser, %Parser* %l0
  %t6 = extractvalue %Parser %t5, 1
  %t7 = fcmp oeq double %t4, %t6
  %t8 = load %Parser, %Parser* %l0
  %t9 = load %Parser, %Parser* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  %t10 = load %Parser, %Parser* %l0
  ret %Parser %t10
merge5:
  %t11 = load %Parser, %Parser* %l1
  store %Parser %t11, %Parser* %l0
  %t12 = load %Parser, %Parser* %l0
  %t13 = call %Token @parser_peek_raw(%Parser %t12)
  store %Token %t13, %Token* %l2
  %t14 = load %Token, %Token* %l2
  %t15 = extractvalue %Token %t14, 0
  %t16 = extractvalue %TokenKind %t15, 0
  %t17 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t18 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t19 = icmp eq i32 %t16, 0
  %t20 = select i1 %t19, i8* %t18, i8* %t17
  %t21 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t22 = icmp eq i32 %t16, 1
  %t23 = select i1 %t22, i8* %t21, i8* %t20
  %t24 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t16, 2
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %t27 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t28 = icmp eq i32 %t16, 3
  %t29 = select i1 %t28, i8* %t27, i8* %t26
  %t30 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t31 = icmp eq i32 %t16, 4
  %t32 = select i1 %t31, i8* %t30, i8* %t29
  %t33 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t34 = icmp eq i32 %t16, 5
  %t35 = select i1 %t34, i8* %t33, i8* %t32
  %t36 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t37 = icmp eq i32 %t16, 6
  %t38 = select i1 %t37, i8* %t36, i8* %t35
  %t39 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t40 = icmp eq i32 %t16, 7
  %t41 = select i1 %t40, i8* %t39, i8* %t38
  %s42 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.42, i32 0, i32 0
  %t43 = icmp eq i8* %t41, %s42
  %t44 = load %Parser, %Parser* %l0
  %t45 = load %Parser, %Parser* %l1
  %t46 = load %Token, %Token* %l2
  br i1 %t43, label %then6, label %merge7
then6:
  %t47 = load %Parser, %Parser* %l0
  ret %Parser %t47
merge7:
  %t48 = load %Token, %Token* %l2
  %t49 = extractvalue %Token %t48, 0
  %t50 = extractvalue %TokenKind %t49, 0
  %t51 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t52 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t53 = icmp eq i32 %t50, 0
  %t54 = select i1 %t53, i8* %t52, i8* %t51
  %t55 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t50, 1
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t50, 2
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t50, 3
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t50, 4
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t50, 5
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t50, 6
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t50, 7
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %s76 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.76, i32 0, i32 0
  %t77 = icmp eq i8* %t75, %s76
  %t78 = load %Parser, %Parser* %l0
  %t79 = load %Parser, %Parser* %l1
  %t80 = load %Token, %Token* %l2
  br i1 %t77, label %then8, label %merge9
then8:
  %t81 = load %Token, %Token* %l2
  %t82 = extractvalue %Token %t81, 0
  %t83 = extractvalue %TokenKind %t82, 0
  store double 0.0, double* %l3
  %t84 = load double, double* %l3
  %t85 = load double, double* %l3
  br label %merge9
merge9:
  br label %loop.latch2
loop.latch2:
  %t86 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  ret %Parser zeroinitializer
}

define i8* @strip_surrounding_quotes(i8* %text) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = icmp slt i64 %t0, 2
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* %text
merge1:
  %t2 = call double @char_at(i8* %text, i64 0)
  %t3 = call double @char_code(i8* null)
  store double %t3, double* %l0
  %t4 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t5 = sub i64 %t4, 1
  %t6 = call double @char_at(i8* %text, i64 %t5)
  %t7 = call double @char_code(i8* null)
  store double %t7, double* %l1
  %t9 = load double, double* %l0
  %t10 = sitofp i64 34 to double
  %t11 = fcmp oeq double %t9, %t10
  br label %logical_and_entry_8

logical_and_entry_8:
  br i1 %t11, label %logical_and_right_8, label %logical_and_merge_8

logical_and_right_8:
  %t12 = load double, double* %l1
  %t13 = sitofp i64 34 to double
  %t14 = fcmp oeq double %t12, %t13
  br label %logical_and_right_end_8

logical_and_right_end_8:
  br label %logical_and_merge_8

logical_and_merge_8:
  %t15 = phi i1 [ false, %logical_and_entry_8 ], [ %t14, %logical_and_right_end_8 ]
  %t16 = load double, double* %l0
  %t17 = load double, double* %l1
  br i1 %t15, label %then2, label %merge3
then2:
  %t18 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t19 = sub i64 %t18, 1
  %t20 = call i8* @sailfin_runtime_substring(i8* %text, i64 1, i64 %t19)
  ret i8* %t20
merge3:
  ret i8* %text
}

define i8* @normalize_test_name(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp sge i64 %t2, 2
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %t6 = call double @char_at(i8* %t5, i64 0)
  %t7 = call double @char_code(i8* null)
  store double %t7, double* %l1
  %t8 = load i8*, i8** %l0
  %t9 = load i8*, i8** %l0
  %t10 = call i64 @sailfin_runtime_string_length(i8* %t9)
  %t11 = sub i64 %t10, 1
  %t12 = call double @char_at(i8* %t8, i64 %t11)
  %t13 = call double @char_code(i8* null)
  store double %t13, double* %l2
  %t15 = load double, double* %l1
  %t16 = sitofp i64 34 to double
  %t17 = fcmp oeq double %t15, %t16
  br label %logical_and_entry_14

logical_and_entry_14:
  br i1 %t17, label %logical_and_right_14, label %logical_and_merge_14

logical_and_right_14:
  %t18 = load double, double* %l2
  %t19 = sitofp i64 34 to double
  %t20 = fcmp oeq double %t18, %t19
  br label %logical_and_right_end_14

logical_and_right_end_14:
  br label %logical_and_merge_14

logical_and_merge_14:
  %t21 = phi i1 [ false, %logical_and_entry_14 ], [ %t20, %logical_and_right_end_14 ]
  %t22 = load i8*, i8** %l0
  %t23 = load double, double* %l1
  %t24 = load double, double* %l2
  br i1 %t21, label %then2, label %merge3
then2:
  %t25 = load i8*, i8** %l0
  %t26 = call i8* @strip_surrounding_quotes(i8* %t25)
  ret i8* %t26
merge3:
  br label %merge1
merge1:
  %t27 = load i8*, i8** %l0
  ret i8* %t27
}

define { i8**, i64 }* @split_tokens_by_comma({ %Token*, i64 }* %tokens) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca %Token
  %l8 = alloca double
  %l9 = alloca i8*
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
  %t8 = sitofp i64 0 to double
  store double %t8, double* %l4
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l5
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l6
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load i8*, i8** %l1
  %t13 = load double, double* %l2
  %t14 = load double, double* %l3
  %t15 = load double, double* %l4
  %t16 = load double, double* %l5
  %t17 = load double, double* %l6
  br label %loop.header0
loop.header0:
  %t91 = phi i8* [ %t12, %entry ], [ %t89, %loop.latch2 ]
  %t92 = phi double [ %t17, %entry ], [ %t90, %loop.latch2 ]
  store i8* %t91, i8** %l1
  store double %t92, double* %l6
  br label %loop.body1
loop.body1:
  %t18 = load double, double* %l6
  %t19 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t20 = extractvalue { %Token*, i64 } %t19, 1
  %t21 = sitofp i64 %t20 to double
  %t22 = fcmp oge double %t18, %t21
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load i8*, i8** %l1
  %t25 = load double, double* %l2
  %t26 = load double, double* %l3
  %t27 = load double, double* %l4
  %t28 = load double, double* %l5
  %t29 = load double, double* %l6
  br i1 %t22, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t30 = load double, double* %l6
  %t31 = fptosi double %t30 to i64
  %t32 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t33 = extractvalue { %Token*, i64 } %t32, 0
  %t34 = extractvalue { %Token*, i64 } %t32, 1
  %t35 = icmp uge i64 %t31, %t34
  ; bounds check: %t35 (if true, out of bounds)
  %t36 = getelementptr %Token, %Token* %t33, i64 %t31
  %t37 = load %Token, %Token* %t36
  store %Token %t37, %Token* %l7
  %t38 = load %Token, %Token* %l7
  %t39 = extractvalue %Token %t38, 0
  %t40 = extractvalue %TokenKind %t39, 0
  %t41 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t42 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t43 = icmp eq i32 %t40, 0
  %t44 = select i1 %t43, i8* %t42, i8* %t41
  %t45 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t46 = icmp eq i32 %t40, 1
  %t47 = select i1 %t46, i8* %t45, i8* %t44
  %t48 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t49 = icmp eq i32 %t40, 2
  %t50 = select i1 %t49, i8* %t48, i8* %t47
  %t51 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t52 = icmp eq i32 %t40, 3
  %t53 = select i1 %t52, i8* %t51, i8* %t50
  %t54 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t55 = icmp eq i32 %t40, 4
  %t56 = select i1 %t55, i8* %t54, i8* %t53
  %t57 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t58 = icmp eq i32 %t40, 5
  %t59 = select i1 %t58, i8* %t57, i8* %t56
  %t60 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t61 = icmp eq i32 %t40, 6
  %t62 = select i1 %t61, i8* %t60, i8* %t59
  %t63 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t40, 7
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %s66 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.66, i32 0, i32 0
  %t67 = icmp eq i8* %t65, %s66
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = load i8*, i8** %l1
  %t70 = load double, double* %l2
  %t71 = load double, double* %l3
  %t72 = load double, double* %l4
  %t73 = load double, double* %l5
  %t74 = load double, double* %l6
  %t75 = load %Token, %Token* %l7
  br i1 %t67, label %then6, label %merge7
then6:
  %t76 = load %Token, %Token* %l7
  %t77 = extractvalue %Token %t76, 0
  %t78 = extractvalue %TokenKind %t77, 0
  store double 0.0, double* %l8
  %t79 = load double, double* %l8
  %t81 = load double, double* %l8
  br label %merge7
merge7:
  %t82 = load i8*, i8** %l1
  %t83 = load %Token, %Token* %l7
  %t84 = extractvalue %Token %t83, 1
  %t85 = add i8* %t82, %t84
  store i8* %t85, i8** %l1
  %t86 = load double, double* %l6
  %t87 = sitofp i64 1 to double
  %t88 = fadd double %t86, %t87
  store double %t88, double* %l6
  br label %loop.latch2
loop.latch2:
  %t89 = load i8*, i8** %l1
  %t90 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t93 = load i8*, i8** %l1
  %t94 = call i8* @trim_text(i8* %t93)
  store i8* %t94, i8** %l9
  %t95 = load i8*, i8** %l9
  %t96 = call i64 @sailfin_runtime_string_length(i8* %t95)
  %t97 = icmp sgt i64 %t96, 0
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t99 = load i8*, i8** %l1
  %t100 = load double, double* %l2
  %t101 = load double, double* %l3
  %t102 = load double, double* %l4
  %t103 = load double, double* %l5
  %t104 = load double, double* %l6
  %t105 = load i8*, i8** %l9
  br i1 %t97, label %then8, label %merge9
then8:
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t107 = load i8*, i8** %l9
  %t108 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t106, i8* %t107)
  store { i8**, i64 }* %t108, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t109 = phi { i8**, i64 }* [ %t108, %then8 ], [ %t98, %entry ]
  store { i8**, i64 }* %t109, { i8**, i64 }** %l0
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t110
}

define { i8**, i64 }* @split_token_slices_by_comma({ %Token*, i64 }* %tokens) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Token*, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca %Token
  %l8 = alloca double
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = alloca [0 x %Token]
  %t6 = getelementptr [0 x %Token], [0 x %Token]* %t5, i32 0, i32 0
  %t7 = alloca { %Token*, i64 }
  %t8 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t7, i32 0, i32 0
  store %Token* %t6, %Token** %t8
  %t9 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %Token*, i64 }* %t7, { %Token*, i64 }** %l1
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l2
  %t11 = sitofp i64 0 to double
  store double %t11, double* %l3
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l4
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l5
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l6
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t17 = load double, double* %l2
  %t18 = load double, double* %l3
  %t19 = load double, double* %l4
  %t20 = load double, double* %l5
  %t21 = load double, double* %l6
  br label %loop.header0
loop.header0:
  %t94 = phi { %Token*, i64 }* [ %t16, %entry ], [ %t92, %loop.latch2 ]
  %t95 = phi double [ %t21, %entry ], [ %t93, %loop.latch2 ]
  store { %Token*, i64 }* %t94, { %Token*, i64 }** %l1
  store double %t95, double* %l6
  br label %loop.body1
loop.body1:
  %t22 = load double, double* %l6
  %t23 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t24 = extractvalue { %Token*, i64 } %t23, 1
  %t25 = sitofp i64 %t24 to double
  %t26 = fcmp oge double %t22, %t25
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t29 = load double, double* %l2
  %t30 = load double, double* %l3
  %t31 = load double, double* %l4
  %t32 = load double, double* %l5
  %t33 = load double, double* %l6
  br i1 %t26, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t34 = load double, double* %l6
  %t35 = fptosi double %t34 to i64
  %t36 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t37 = extractvalue { %Token*, i64 } %t36, 0
  %t38 = extractvalue { %Token*, i64 } %t36, 1
  %t39 = icmp uge i64 %t35, %t38
  ; bounds check: %t39 (if true, out of bounds)
  %t40 = getelementptr %Token, %Token* %t37, i64 %t35
  %t41 = load %Token, %Token* %t40
  store %Token %t41, %Token* %l7
  %t42 = load %Token, %Token* %l7
  %t43 = extractvalue %Token %t42, 0
  %t44 = extractvalue %TokenKind %t43, 0
  %t45 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t46 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t47 = icmp eq i32 %t44, 0
  %t48 = select i1 %t47, i8* %t46, i8* %t45
  %t49 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t50 = icmp eq i32 %t44, 1
  %t51 = select i1 %t50, i8* %t49, i8* %t48
  %t52 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t53 = icmp eq i32 %t44, 2
  %t54 = select i1 %t53, i8* %t52, i8* %t51
  %t55 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t44, 3
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t44, 4
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t44, 5
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t44, 6
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t44, 7
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %s70 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.70, i32 0, i32 0
  %t71 = icmp eq i8* %t69, %s70
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t73 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t74 = load double, double* %l2
  %t75 = load double, double* %l3
  %t76 = load double, double* %l4
  %t77 = load double, double* %l5
  %t78 = load double, double* %l6
  %t79 = load %Token, %Token* %l7
  br i1 %t71, label %then6, label %merge7
then6:
  %t80 = load %Token, %Token* %l7
  %t81 = extractvalue %Token %t80, 0
  %t82 = extractvalue %TokenKind %t81, 0
  store double 0.0, double* %l8
  %t83 = load double, double* %l8
  %t85 = load double, double* %l8
  br label %merge7
merge7:
  %t86 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t87 = load %Token, %Token* %l7
  %t88 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t86, %Token %t87)
  store { %Token*, i64 }* %t88, { %Token*, i64 }** %l1
  %t89 = load double, double* %l6
  %t90 = sitofp i64 1 to double
  %t91 = fadd double %t89, %t90
  store double %t91, double* %l6
  br label %loop.latch2
loop.latch2:
  %t92 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t93 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t96 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t97 = load { %Token*, i64 }, { %Token*, i64 }* %t96
  %t98 = extractvalue { %Token*, i64 } %t97, 1
  %t99 = icmp sgt i64 %t98, 0
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t101 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t102 = load double, double* %l2
  %t103 = load double, double* %l3
  %t104 = load double, double* %l4
  %t105 = load double, double* %l5
  %t106 = load double, double* %l6
  br i1 %t99, label %then8, label %merge9
then8:
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t108 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t109 = call { i8**, i64 }* @append_token_array({ i8**, i64 }* %t107, { %Token*, i64 }* %t108)
  store { i8**, i64 }* %t109, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t110 = phi { i8**, i64 }* [ %t109, %then8 ], [ %t100, %entry ]
  store { i8**, i64 }* %t110, { i8**, i64 }** %l0
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t111
}

define double @find_top_level_symbol({ %Token*, i64 }* %tokens, i8* %symbol) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca %Token
  %l6 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l2
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l3
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l4
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  %t7 = load double, double* %l2
  %t8 = load double, double* %l3
  %t9 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t74 = phi double [ %t9, %entry ], [ %t73, %loop.latch2 ]
  store double %t74, double* %l4
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l4
  %t11 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t12 = extractvalue { %Token*, i64 } %t11, 1
  %t13 = sitofp i64 %t12 to double
  %t14 = fcmp oge double %t10, %t13
  %t15 = load double, double* %l0
  %t16 = load double, double* %l1
  %t17 = load double, double* %l2
  %t18 = load double, double* %l3
  %t19 = load double, double* %l4
  br i1 %t14, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t20 = load double, double* %l4
  %t21 = fptosi double %t20 to i64
  %t22 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t23 = extractvalue { %Token*, i64 } %t22, 0
  %t24 = extractvalue { %Token*, i64 } %t22, 1
  %t25 = icmp uge i64 %t21, %t24
  ; bounds check: %t25 (if true, out of bounds)
  %t26 = getelementptr %Token, %Token* %t23, i64 %t21
  %t27 = load %Token, %Token* %t26
  store %Token %t27, %Token* %l5
  %t28 = load %Token, %Token* %l5
  %t29 = extractvalue %Token %t28, 0
  %t30 = extractvalue %TokenKind %t29, 0
  %t31 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t32 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t30, 0
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t30, 1
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t30, 2
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t30, 3
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t30, 4
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t30, 5
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %t50 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t30, 6
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %t53 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t54 = icmp eq i32 %t30, 7
  %t55 = select i1 %t54, i8* %t53, i8* %t52
  %s56 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  %t57 = icmp eq i8* %t55, %s56
  %t58 = load double, double* %l0
  %t59 = load double, double* %l1
  %t60 = load double, double* %l2
  %t61 = load double, double* %l3
  %t62 = load double, double* %l4
  %t63 = load %Token, %Token* %l5
  br i1 %t57, label %then6, label %merge7
then6:
  %t64 = load %Token, %Token* %l5
  %t65 = extractvalue %Token %t64, 0
  %t66 = extractvalue %TokenKind %t65, 0
  store double 0.0, double* %l6
  %t67 = load double, double* %l6
  %t69 = load double, double* %l6
  br label %merge7
merge7:
  %t70 = load double, double* %l4
  %t71 = sitofp i64 1 to double
  %t72 = fadd double %t70, %t71
  store double %t72, double* %l4
  br label %loop.latch2
loop.latch2:
  %t73 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t75 = sitofp i64 -1 to double
  ret double %t75
}

define double @find_top_level_identifier({ %Token*, i64 }* %tokens, i8* %keyword) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca %Token
  %l6 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l2
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l3
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l4
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  %t7 = load double, double* %l2
  %t8 = load double, double* %l3
  %t9 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t141 = phi double [ %t9, %entry ], [ %t140, %loop.latch2 ]
  store double %t141, double* %l4
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l4
  %t11 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t12 = extractvalue { %Token*, i64 } %t11, 1
  %t13 = sitofp i64 %t12 to double
  %t14 = fcmp oge double %t10, %t13
  %t15 = load double, double* %l0
  %t16 = load double, double* %l1
  %t17 = load double, double* %l2
  %t18 = load double, double* %l3
  %t19 = load double, double* %l4
  br i1 %t14, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t20 = load double, double* %l4
  %t21 = fptosi double %t20 to i64
  %t22 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t23 = extractvalue { %Token*, i64 } %t22, 0
  %t24 = extractvalue { %Token*, i64 } %t22, 1
  %t25 = icmp uge i64 %t21, %t24
  ; bounds check: %t25 (if true, out of bounds)
  %t26 = getelementptr %Token, %Token* %t23, i64 %t21
  %t27 = load %Token, %Token* %t26
  store %Token %t27, %Token* %l5
  %t28 = load %Token, %Token* %l5
  %t29 = extractvalue %Token %t28, 0
  %t30 = extractvalue %TokenKind %t29, 0
  %t31 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t32 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t30, 0
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t30, 1
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t30, 2
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t30, 3
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t30, 4
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t30, 5
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %t50 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t30, 6
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %t53 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t54 = icmp eq i32 %t30, 7
  %t55 = select i1 %t54, i8* %t53, i8* %t52
  %s56 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  %t57 = icmp eq i8* %t55, %s56
  %t58 = load double, double* %l0
  %t59 = load double, double* %l1
  %t60 = load double, double* %l2
  %t61 = load double, double* %l3
  %t62 = load double, double* %l4
  %t63 = load %Token, %Token* %l5
  br i1 %t57, label %then6, label %merge7
then6:
  %t64 = load %Token, %Token* %l5
  %t65 = extractvalue %Token %t64, 0
  %t66 = extractvalue %TokenKind %t65, 0
  store double 0.0, double* %l6
  %t67 = load double, double* %l6
  br label %merge7
merge7:
  %t68 = load %Token, %Token* %l5
  %t69 = extractvalue %Token %t68, 0
  %t70 = extractvalue %TokenKind %t69, 0
  %t71 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t72 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t70, 0
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t70, 1
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t70, 2
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %t81 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t70, 3
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t70, 4
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %t87 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t88 = icmp eq i32 %t70, 5
  %t89 = select i1 %t88, i8* %t87, i8* %t86
  %t90 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t91 = icmp eq i32 %t70, 6
  %t92 = select i1 %t91, i8* %t90, i8* %t89
  %t93 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t70, 7
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %s96 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.96, i32 0, i32 0
  %t97 = icmp eq i8* %t95, %s96
  %t98 = load double, double* %l0
  %t99 = load double, double* %l1
  %t100 = load double, double* %l2
  %t101 = load double, double* %l3
  %t102 = load double, double* %l4
  %t103 = load %Token, %Token* %l5
  br i1 %t97, label %then8, label %merge9
then8:
  %t104 = load %Token, %Token* %l5
  %t105 = call i1 @identifier_matches(%Token %t104, i8* %keyword)
  %t106 = load double, double* %l0
  %t107 = load double, double* %l1
  %t108 = load double, double* %l2
  %t109 = load double, double* %l3
  %t110 = load double, double* %l4
  %t111 = load %Token, %Token* %l5
  br i1 %t105, label %then10, label %merge11
then10:
  %t113 = load double, double* %l0
  %t114 = sitofp i64 0 to double
  %t115 = fcmp oeq double %t113, %t114
  br label %logical_and_entry_112

logical_and_entry_112:
  br i1 %t115, label %logical_and_right_112, label %logical_and_merge_112

logical_and_right_112:
  %t117 = load double, double* %l1
  %t118 = sitofp i64 0 to double
  %t119 = fcmp oeq double %t117, %t118
  br label %logical_and_entry_116

logical_and_entry_116:
  br i1 %t119, label %logical_and_right_116, label %logical_and_merge_116

logical_and_right_116:
  %t121 = load double, double* %l2
  %t122 = sitofp i64 0 to double
  %t123 = fcmp oeq double %t121, %t122
  br label %logical_and_entry_120

logical_and_entry_120:
  br i1 %t123, label %logical_and_right_120, label %logical_and_merge_120

logical_and_right_120:
  %t124 = load double, double* %l3
  %t125 = sitofp i64 0 to double
  %t126 = fcmp oeq double %t124, %t125
  br label %logical_and_right_end_120

logical_and_right_end_120:
  br label %logical_and_merge_120

logical_and_merge_120:
  %t127 = phi i1 [ false, %logical_and_entry_120 ], [ %t126, %logical_and_right_end_120 ]
  br label %logical_and_right_end_116

logical_and_right_end_116:
  br label %logical_and_merge_116

logical_and_merge_116:
  %t128 = phi i1 [ false, %logical_and_entry_116 ], [ %t127, %logical_and_right_end_116 ]
  br label %logical_and_right_end_112

logical_and_right_end_112:
  br label %logical_and_merge_112

logical_and_merge_112:
  %t129 = phi i1 [ false, %logical_and_entry_112 ], [ %t128, %logical_and_right_end_112 ]
  %t130 = load double, double* %l0
  %t131 = load double, double* %l1
  %t132 = load double, double* %l2
  %t133 = load double, double* %l3
  %t134 = load double, double* %l4
  %t135 = load %Token, %Token* %l5
  br i1 %t129, label %then12, label %merge13
then12:
  %t136 = load double, double* %l4
  ret double %t136
merge13:
  br label %merge11
merge11:
  br label %merge9
merge9:
  %t137 = load double, double* %l4
  %t138 = sitofp i64 1 to double
  %t139 = fadd double %t137, %t138
  store double %t139, double* %l4
  br label %loop.latch2
loop.latch2:
  %t140 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t142 = sitofp i64 -1 to double
  ret double %t142
}

define { %Statement*, i64 }* @append_statement({ %Statement*, i64 }* %statements, %Statement %statement) {
entry:
  %t0 = alloca [1 x %Statement]
  %t1 = getelementptr [1 x %Statement], [1 x %Statement]* %t0, i32 0, i32 0
  %t2 = getelementptr %Statement, %Statement* %t1, i64 0
  store %Statement %statement, %Statement* %t2
  %t3 = alloca { %Statement*, i64 }
  %t4 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t3, i32 0, i32 0
  store %Statement* %t1, %Statement** %t4
  %t5 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %Statement*, i64 }* %statements to { i8**, i64 }*
  %t7 = bitcast { %Statement*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %Statement*, i64 }*
  ret { %Statement*, i64 }* %t9
}

define { i8**, i64 }* @append_string({ i8**, i64 }* %values, i8* %value) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %value, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %values, { i8**, i64 }* %t3)
  ret { i8**, i64 }* %t6
}

define { %Parameter*, i64 }* @append_parameter({ %Parameter*, i64 }* %parameters, %Parameter %parameter) {
entry:
  %t0 = alloca [1 x %Parameter]
  %t1 = getelementptr [1 x %Parameter], [1 x %Parameter]* %t0, i32 0, i32 0
  %t2 = getelementptr %Parameter, %Parameter* %t1, i64 0
  store %Parameter %parameter, %Parameter* %t2
  %t3 = alloca { %Parameter*, i64 }
  %t4 = getelementptr { %Parameter*, i64 }, { %Parameter*, i64 }* %t3, i32 0, i32 0
  store %Parameter* %t1, %Parameter** %t4
  %t5 = getelementptr { %Parameter*, i64 }, { %Parameter*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %Parameter*, i64 }* %parameters to { i8**, i64 }*
  %t7 = bitcast { %Parameter*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %Parameter*, i64 }*
  ret { %Parameter*, i64 }* %t9
}

define { %ModelProperty*, i64 }* @append_model_property({ %ModelProperty*, i64 }* %properties, %ModelProperty %property) {
entry:
  %t0 = alloca [1 x %ModelProperty]
  %t1 = getelementptr [1 x %ModelProperty], [1 x %ModelProperty]* %t0, i32 0, i32 0
  %t2 = getelementptr %ModelProperty, %ModelProperty* %t1, i64 0
  store %ModelProperty %property, %ModelProperty* %t2
  %t3 = alloca { %ModelProperty*, i64 }
  %t4 = getelementptr { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %t3, i32 0, i32 0
  store %ModelProperty* %t1, %ModelProperty** %t4
  %t5 = getelementptr { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %ModelProperty*, i64 }* %properties to { i8**, i64 }*
  %t7 = bitcast { %ModelProperty*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %ModelProperty*, i64 }*
  ret { %ModelProperty*, i64 }* %t9
}

define { %FieldDeclaration*, i64 }* @append_field({ %FieldDeclaration*, i64 }* %fields, %FieldDeclaration %field) {
entry:
  %t0 = alloca [1 x %FieldDeclaration]
  %t1 = getelementptr [1 x %FieldDeclaration], [1 x %FieldDeclaration]* %t0, i32 0, i32 0
  %t2 = getelementptr %FieldDeclaration, %FieldDeclaration* %t1, i64 0
  store %FieldDeclaration %field, %FieldDeclaration* %t2
  %t3 = alloca { %FieldDeclaration*, i64 }
  %t4 = getelementptr { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %t3, i32 0, i32 0
  store %FieldDeclaration* %t1, %FieldDeclaration** %t4
  %t5 = getelementptr { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %FieldDeclaration*, i64 }* %fields to { i8**, i64 }*
  %t7 = bitcast { %FieldDeclaration*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %FieldDeclaration*, i64 }*
  ret { %FieldDeclaration*, i64 }* %t9
}

define { %MethodDeclaration*, i64 }* @append_method({ %MethodDeclaration*, i64 }* %methods, %MethodDeclaration %method) {
entry:
  %t0 = alloca [1 x %MethodDeclaration]
  %t1 = getelementptr [1 x %MethodDeclaration], [1 x %MethodDeclaration]* %t0, i32 0, i32 0
  %t2 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1, i64 0
  store %MethodDeclaration %method, %MethodDeclaration* %t2
  %t3 = alloca { %MethodDeclaration*, i64 }
  %t4 = getelementptr { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t3, i32 0, i32 0
  store %MethodDeclaration* %t1, %MethodDeclaration** %t4
  %t5 = getelementptr { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %MethodDeclaration*, i64 }* %methods to { i8**, i64 }*
  %t7 = bitcast { %MethodDeclaration*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %MethodDeclaration*, i64 }*
  ret { %MethodDeclaration*, i64 }* %t9
}

define { %FunctionSignature*, i64 }* @append_signature({ %FunctionSignature*, i64 }* %signatures, %FunctionSignature %signature) {
entry:
  %t0 = alloca [1 x %FunctionSignature]
  %t1 = getelementptr [1 x %FunctionSignature], [1 x %FunctionSignature]* %t0, i32 0, i32 0
  %t2 = getelementptr %FunctionSignature, %FunctionSignature* %t1, i64 0
  store %FunctionSignature %signature, %FunctionSignature* %t2
  %t3 = alloca { %FunctionSignature*, i64 }
  %t4 = getelementptr { %FunctionSignature*, i64 }, { %FunctionSignature*, i64 }* %t3, i32 0, i32 0
  store %FunctionSignature* %t1, %FunctionSignature** %t4
  %t5 = getelementptr { %FunctionSignature*, i64 }, { %FunctionSignature*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %FunctionSignature*, i64 }* %signatures to { i8**, i64 }*
  %t7 = bitcast { %FunctionSignature*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %FunctionSignature*, i64 }*
  ret { %FunctionSignature*, i64 }* %t9
}

define { %EnumVariant*, i64 }* @append_enum_variant({ %EnumVariant*, i64 }* %variants, %EnumVariant %variant) {
entry:
  %t0 = alloca [1 x %EnumVariant]
  %t1 = getelementptr [1 x %EnumVariant], [1 x %EnumVariant]* %t0, i32 0, i32 0
  %t2 = getelementptr %EnumVariant, %EnumVariant* %t1, i64 0
  store %EnumVariant %variant, %EnumVariant* %t2
  %t3 = alloca { %EnumVariant*, i64 }
  %t4 = getelementptr { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %t3, i32 0, i32 0
  store %EnumVariant* %t1, %EnumVariant** %t4
  %t5 = getelementptr { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %EnumVariant*, i64 }* %variants to { i8**, i64 }*
  %t7 = bitcast { %EnumVariant*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %EnumVariant*, i64 }*
  ret { %EnumVariant*, i64 }* %t9
}

define { %TypeAnnotation*, i64 }* @append_type_annotation({ %TypeAnnotation*, i64 }* %types, %TypeAnnotation %item) {
entry:
  %t0 = alloca [1 x %TypeAnnotation]
  %t1 = getelementptr [1 x %TypeAnnotation], [1 x %TypeAnnotation]* %t0, i32 0, i32 0
  %t2 = getelementptr %TypeAnnotation, %TypeAnnotation* %t1, i64 0
  store %TypeAnnotation %item, %TypeAnnotation* %t2
  %t3 = alloca { %TypeAnnotation*, i64 }
  %t4 = getelementptr { %TypeAnnotation*, i64 }, { %TypeAnnotation*, i64 }* %t3, i32 0, i32 0
  store %TypeAnnotation* %t1, %TypeAnnotation** %t4
  %t5 = getelementptr { %TypeAnnotation*, i64 }, { %TypeAnnotation*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %TypeAnnotation*, i64 }* %types to { i8**, i64 }*
  %t7 = bitcast { %TypeAnnotation*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %TypeAnnotation*, i64 }*
  ret { %TypeAnnotation*, i64 }* %t9
}

define { %TypeParameter*, i64 }* @append_type_parameter({ %TypeParameter*, i64 }* %parameters, %TypeParameter %parameter) {
entry:
  %t0 = alloca [1 x %TypeParameter]
  %t1 = getelementptr [1 x %TypeParameter], [1 x %TypeParameter]* %t0, i32 0, i32 0
  %t2 = getelementptr %TypeParameter, %TypeParameter* %t1, i64 0
  store %TypeParameter %parameter, %TypeParameter* %t2
  %t3 = alloca { %TypeParameter*, i64 }
  %t4 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %t3, i32 0, i32 0
  store %TypeParameter* %t1, %TypeParameter** %t4
  %t5 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %TypeParameter*, i64 }* %parameters to { i8**, i64 }*
  %t7 = bitcast { %TypeParameter*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %TypeParameter*, i64 }*
  ret { %TypeParameter*, i64 }* %t9
}

define { %Decorator*, i64 }* @append_decorator({ %Decorator*, i64 }* %decorators, %Decorator %decorator) {
entry:
  %t0 = alloca [1 x %Decorator]
  %t1 = getelementptr [1 x %Decorator], [1 x %Decorator]* %t0, i32 0, i32 0
  %t2 = getelementptr %Decorator, %Decorator* %t1, i64 0
  store %Decorator %decorator, %Decorator* %t2
  %t3 = alloca { %Decorator*, i64 }
  %t4 = getelementptr { %Decorator*, i64 }, { %Decorator*, i64 }* %t3, i32 0, i32 0
  store %Decorator* %t1, %Decorator** %t4
  %t5 = getelementptr { %Decorator*, i64 }, { %Decorator*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %Decorator*, i64 }* %decorators to { i8**, i64 }*
  %t7 = bitcast { %Decorator*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %Decorator*, i64 }*
  ret { %Decorator*, i64 }* %t9
}

define { %DecoratorArgument*, i64 }* @append_decorator_argument({ %DecoratorArgument*, i64 }* %arguments, %DecoratorArgument %argument) {
entry:
  %t0 = alloca [1 x %DecoratorArgument]
  %t1 = getelementptr [1 x %DecoratorArgument], [1 x %DecoratorArgument]* %t0, i32 0, i32 0
  %t2 = getelementptr %DecoratorArgument, %DecoratorArgument* %t1, i64 0
  store %DecoratorArgument %argument, %DecoratorArgument* %t2
  %t3 = alloca { %DecoratorArgument*, i64 }
  %t4 = getelementptr { %DecoratorArgument*, i64 }, { %DecoratorArgument*, i64 }* %t3, i32 0, i32 0
  store %DecoratorArgument* %t1, %DecoratorArgument** %t4
  %t5 = getelementptr { %DecoratorArgument*, i64 }, { %DecoratorArgument*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %DecoratorArgument*, i64 }* %arguments to { i8**, i64 }*
  %t7 = bitcast { %DecoratorArgument*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %DecoratorArgument*, i64 }*
  ret { %DecoratorArgument*, i64 }* %t9
}

define { %WithClause*, i64 }* @append_with_clause({ %WithClause*, i64 }* %clauses, %WithClause %clause) {
entry:
  %t0 = alloca [1 x %WithClause]
  %t1 = getelementptr [1 x %WithClause], [1 x %WithClause]* %t0, i32 0, i32 0
  %t2 = getelementptr %WithClause, %WithClause* %t1, i64 0
  store %WithClause %clause, %WithClause* %t2
  %t3 = alloca { %WithClause*, i64 }
  %t4 = getelementptr { %WithClause*, i64 }, { %WithClause*, i64 }* %t3, i32 0, i32 0
  store %WithClause* %t1, %WithClause** %t4
  %t5 = getelementptr { %WithClause*, i64 }, { %WithClause*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %WithClause*, i64 }* %clauses to { i8**, i64 }*
  %t7 = bitcast { %WithClause*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %WithClause*, i64 }*
  ret { %WithClause*, i64 }* %t9
}

define { %MatchCase*, i64 }* @append_match_case({ %MatchCase*, i64 }* %cases, %MatchCase %case) {
entry:
  %t0 = alloca [1 x %MatchCase]
  %t1 = getelementptr [1 x %MatchCase], [1 x %MatchCase]* %t0, i32 0, i32 0
  %t2 = getelementptr %MatchCase, %MatchCase* %t1, i64 0
  store %MatchCase %case, %MatchCase* %t2
  %t3 = alloca { %MatchCase*, i64 }
  %t4 = getelementptr { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t3, i32 0, i32 0
  store %MatchCase* %t1, %MatchCase** %t4
  %t5 = getelementptr { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %MatchCase*, i64 }* %cases to { i8**, i64 }*
  %t7 = bitcast { %MatchCase*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %MatchCase*, i64 }*
  ret { %MatchCase*, i64 }* %t9
}

define { %Expression*, i64 }* @append_expression({ %Expression*, i64 }* %expressions, %Expression %expression) {
entry:
  %t0 = alloca [1 x %Expression]
  %t1 = getelementptr [1 x %Expression], [1 x %Expression]* %t0, i32 0, i32 0
  %t2 = getelementptr %Expression, %Expression* %t1, i64 0
  store %Expression %expression, %Expression* %t2
  %t3 = alloca { %Expression*, i64 }
  %t4 = getelementptr { %Expression*, i64 }, { %Expression*, i64 }* %t3, i32 0, i32 0
  store %Expression* %t1, %Expression** %t4
  %t5 = getelementptr { %Expression*, i64 }, { %Expression*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %Expression*, i64 }* %expressions to { i8**, i64 }*
  %t7 = bitcast { %Expression*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %Expression*, i64 }*
  ret { %Expression*, i64 }* %t9
}

define { %ObjectField*, i64 }* @append_object_field({ %ObjectField*, i64 }* %fields, %ObjectField %field) {
entry:
  %t0 = alloca [1 x %ObjectField]
  %t1 = getelementptr [1 x %ObjectField], [1 x %ObjectField]* %t0, i32 0, i32 0
  %t2 = getelementptr %ObjectField, %ObjectField* %t1, i64 0
  store %ObjectField %field, %ObjectField* %t2
  %t3 = alloca { %ObjectField*, i64 }
  %t4 = getelementptr { %ObjectField*, i64 }, { %ObjectField*, i64 }* %t3, i32 0, i32 0
  store %ObjectField* %t1, %ObjectField** %t4
  %t5 = getelementptr { %ObjectField*, i64 }, { %ObjectField*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %ObjectField*, i64 }* %fields to { i8**, i64 }*
  %t7 = bitcast { %ObjectField*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %ObjectField*, i64 }*
  ret { %ObjectField*, i64 }* %t9
}

define { %Token*, i64 }* @append_token({ %Token*, i64 }* %tokens, %Token %token) {
entry:
  %t0 = alloca [1 x %Token]
  %t1 = getelementptr [1 x %Token], [1 x %Token]* %t0, i32 0, i32 0
  %t2 = getelementptr %Token, %Token* %t1, i64 0
  store %Token %token, %Token* %t2
  %t3 = alloca { %Token*, i64 }
  %t4 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t3, i32 0, i32 0
  store %Token* %t1, %Token** %t4
  %t5 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %Token*, i64 }* %tokens to { i8**, i64 }*
  %t7 = bitcast { %Token*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %Token*, i64 }*
  ret { %Token*, i64 }* %t9
}

define { i8**, i64 }* @append_token_array({ i8**, i64 }* %collection, { %Token*, i64 }* %tokens) {
entry:
  %t0 = alloca [1 x { %Token*, i64 }*]
  %t1 = getelementptr [1 x { %Token*, i64 }*], [1 x { %Token*, i64 }*]* %t0, i32 0, i32 0
  %t2 = getelementptr { %Token*, i64 }*, { %Token*, i64 }** %t1, i64 0
  store { %Token*, i64 }* %tokens, { %Token*, i64 }** %t2
  %t3 = alloca { { %Token*, i64 }**, i64 }
  %t4 = getelementptr { { %Token*, i64 }**, i64 }, { { %Token*, i64 }**, i64 }* %t3, i32 0, i32 0
  store { %Token*, i64 }** %t1, { %Token*, i64 }*** %t4
  %t5 = getelementptr { { %Token*, i64 }**, i64 }, { { %Token*, i64 }**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { { %Token*, i64 }**, i64 }* %t3 to { i8**, i64 }*
  %t7 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6)
  ret { i8**, i64 }* %t7
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
