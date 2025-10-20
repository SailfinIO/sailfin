; ModuleID = 'sailfin'
source_filename = "sailfin"

%Parser = type { { %Token**, i64 }*, double }
%StatementParseResult = type { %Parser*, %Statement* }
%ParameterParseResult = type { %Parser*, %Parameter* }
%ParameterListParseResult = type { %Parser*, { %Parameter**, i64 }* }
%StructFieldParseResult = type { %Parser*, %FieldDeclaration*, i1 }
%ModelPropertyParseResult = type { %Parser*, %ModelProperty*, i1 }
%MethodParseResult = type { %Parser*, %MethodDeclaration*, i1 }
%InterfaceMemberParseResult = type { %Parser*, %FunctionSignature*, i1 }
%SpecifierListParseResult = type { %Parser*, { %NamedSpecifier**, i64 }* }
%NamedSpecifier = type { i8*, i8* }
%EnumVariantParseResult = type { %Parser*, %EnumVariant*, i1 }
%TypeParameterParseResult = type { %Parser*, { %TypeParameter**, i64 }* }
%ImplementsParseResult = type { %Parser*, { %TypeAnnotation**, i64 }*, i1 }
%DecoratorParseResult = type { %Parser*, { %Decorator**, i64 }* }
%BlockStatementParseResult = type { %Parser*, %Statement*, i1 }
%ParenthesizedParseResult = type { %Parser*, { %Token**, i64 }*, i1 }
%MatchCasesParseResult = type { %Parser*, { %MatchCase**, i64 }*, i1 }
%MatchCaseParseResult = type { %Parser*, %MatchCase*, i1 }
%MatchCaseTokenSplit = type { { %Token**, i64 }*, { %Token**, i64 }*, i1 }
%ExpressionTokens = type { { %Token**, i64 }*, double }
%ExpressionParseResult = type { %ExpressionTokens*, %Expression*, i1 }
%LambdaParameterParseResult = type { %ExpressionTokens*, %Parameter*, i1 }
%LambdaParameterListParseResult = type { %ExpressionTokens*, { %Parameter**, i64 }*, i1 }
%ExpressionCollectResult = type { %ExpressionTokens*, { %Token**, i64 }*, i1 }
%ExpressionBlockParseResult = type { %ExpressionTokens*, { %Token**, i64 }*, i1 }
%CallArgumentsParseResult = type { %ExpressionTokens*, { %Expression**, i64 }*, i1 }
%ArrayLiteralParseResult = type { %ExpressionTokens*, { %Expression**, i64 }*, i1 }
%ObjectLiteralParseResult = type { %ExpressionTokens*, { %ObjectField**, i64 }*, i1 }
%StructTypeNameResult = type { { i8**, i64 }*, i1 }
%CaptureResult = type { %Parser*, { %Token**, i64 }* }
%EffectParseResult = type { %Parser*, { i8**, i64 }* }
%BlockParseResult = type { %Parser*, %Block* }
%PatternCaptureResult = type { %Parser*, { %Token**, i64 }*, i1 }
%LexerState = type { i8*, double, double, double }
%Token = type { %TokenKind*, i8*, double, double }
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
%DecoratorArgumentInfo = type { i8*, %LiteralValue* }
%DecoratorInfo = type { i8*, { %DecoratorArgumentInfo**, i64 }* }

%TokenKind = type { i32, [8 x i8] }
%Expression = type { i32, [24 x i8] }
%Statement = type { i32, [56 x i8] }
%LiteralValue = type { i32, [8 x i8] }

declare i8* @sailfin_runtime_substring(i8*, i64, i64)
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
@.str.105 = private unnamed_addr constant [7 x i8] c"Symbol\00"
@.str.44 = private unnamed_addr constant [3 x i8] c"fn\00"
@.str.42 = private unnamed_addr constant [3 x i8] c"fn\00"
@.str.14 = private unnamed_addr constant [4 x i8] c"for\00"
@.str.22 = private unnamed_addr constant [1 x i8] c"\00"
@.str.23 = private unnamed_addr constant [7 x i8] c"return\00"
@.str.20 = private unnamed_addr constant [3 x i8] c"if\00"
@.str.184 = private unnamed_addr constant [1 x i8] c"\00"
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
  %t61 = phi %Parser [ %t11, %entry ], [ %t59, %loop.latch2 ]
  %t62 = phi { %Statement*, i64 }* [ %t12, %entry ], [ %t60, %loop.latch2 ]
  store %Parser %t61, %Parser* %l0
  store { %Statement*, i64 }* %t62, { %Statement*, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t13 = load %Parser, %Parser* %l0
  %t14 = call %Token @parser_peek_raw(%Parser %t13)
  store %Token %t14, %Token* %l2
  %t15 = load %Token, %Token* %l2
  %t16 = extractvalue %Token %t15, 0
  %t17 = getelementptr inbounds %TokenKind, %TokenKind* %t16, i32 0, i32 0
  %t18 = load i32, i32* %t17
  %t19 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t20 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t18, 0
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t18, 1
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t18, 2
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t18, 3
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t18, 4
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t18, 5
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t18, 6
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t18, 7
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %s44 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.44, i32 0, i32 0
  %t45 = icmp eq i8* %t43, %s44
  %t46 = load %Parser, %Parser* %l0
  %t47 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  %t48 = load %Token, %Token* %l2
  br i1 %t45, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t49 = load %Parser, %Parser* %l0
  %t50 = call %StatementParseResult @parse_statement(%Parser %t49)
  store %StatementParseResult %t50, %StatementParseResult* %l3
  %t51 = load %StatementParseResult, %StatementParseResult* %l3
  %t52 = extractvalue %StatementParseResult %t51, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t53 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  %t54 = load %StatementParseResult, %StatementParseResult* %l3
  %t55 = extractvalue %StatementParseResult %t54, 1
  %t56 = call { %Statement*, i64 }* @append_statement({ %Statement*, i64 }* %t53, %Statement zeroinitializer)
  store { %Statement*, i64 }* %t56, { %Statement*, i64 }** %l1
  %t57 = load %Parser, %Parser* %l0
  %t58 = call %Parser @skip_trivia(%Parser %t57)
  store %Parser %t58, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t59 = load %Parser, %Parser* %l0
  %t60 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t63 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  %t64 = bitcast { %Statement*, i64 }* %t63 to { %Statement**, i64 }*
  %t65 = insertvalue %Program undef, { %Statement**, i64 }* %t64, 0
  ret %Program %t65
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
  store %Parser zeroinitializer, %Parser* %l0
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
  %t193 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
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
  %t215 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
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
  store %Parser zeroinitializer, %Parser* %l0
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
  store %Parser zeroinitializer, %Parser* %l0
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
  %t44 = getelementptr inbounds %TokenKind, %TokenKind* %t43, i32 0, i32 0
  %t45 = load i32, i32* %t44
  %t46 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t47 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t45, 0
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %t50 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t45, 1
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %t53 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t54 = icmp eq i32 %t45, 2
  %t55 = select i1 %t54, i8* %t53, i8* %t52
  %t56 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t57 = icmp eq i32 %t45, 3
  %t58 = select i1 %t57, i8* %t56, i8* %t55
  %t59 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t60 = icmp eq i32 %t45, 4
  %t61 = select i1 %t60, i8* %t59, i8* %t58
  %t62 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t45, 5
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t45, 6
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t45, 7
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %s71 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.71, i32 0, i32 0
  %t72 = icmp eq i8* %t70, %s71
  br label %logical_and_entry_40

logical_and_entry_40:
  br i1 %t72, label %logical_and_right_40, label %logical_and_merge_40

logical_and_right_40:
  %t73 = load %Parser, %Parser* %l0
  %t74 = call %Token @parser_peek_raw(%Parser %t73)
  %t75 = extractvalue %Token %t74, 0
  %t76 = getelementptr inbounds %TokenKind, %TokenKind* %t75, i32 0, i32 0
  %t77 = load i32, i32* %t76
  %t78 = alloca %Statement
  %t79 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 0
  store i32 0, i32* %t79
  %t80 = load { %ImportSpecifier*, i64 }*, { %ImportSpecifier*, i64 }** %l2
  %t81 = bitcast { %ImportSpecifier*, i64 }* %t80 to { %ImportSpecifier**, i64 }*
  %t82 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t83 = bitcast [16 x i8]* %t82 to i8*
  %t84 = bitcast i8* %t83 to { %ImportSpecifier**, i64 }**
  store { %ImportSpecifier**, i64 }* %t81, { %ImportSpecifier**, i64 }** %t84
  %t85 = load i8*, i8** %l4
  %t86 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 8
  %t89 = bitcast i8* %t88 to i8**
  store i8* %t85, i8** %t89
  %t90 = load %Statement, %Statement* %t78
  store %Statement %t90, %Statement* %l5
  %t91 = load %Parser, %Parser* %l0
  %t92 = insertvalue %StatementParseResult undef, %Parser* null, 0
  %t93 = load %Statement, %Statement* %l5
  %t94 = insertvalue %StatementParseResult %t92, %Statement* null, 1
  ret %StatementParseResult %t94
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
  store %Parser zeroinitializer, %Parser* %l0
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
  store %Parser zeroinitializer, %Parser* %l0
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
  %t44 = getelementptr inbounds %TokenKind, %TokenKind* %t43, i32 0, i32 0
  %t45 = load i32, i32* %t44
  %t46 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t47 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t45, 0
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %t50 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t45, 1
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %t53 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t54 = icmp eq i32 %t45, 2
  %t55 = select i1 %t54, i8* %t53, i8* %t52
  %t56 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t57 = icmp eq i32 %t45, 3
  %t58 = select i1 %t57, i8* %t56, i8* %t55
  %t59 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t60 = icmp eq i32 %t45, 4
  %t61 = select i1 %t60, i8* %t59, i8* %t58
  %t62 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t45, 5
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t45, 6
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t45, 7
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %s71 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.71, i32 0, i32 0
  %t72 = icmp eq i8* %t70, %s71
  br label %logical_and_entry_40

logical_and_entry_40:
  br i1 %t72, label %logical_and_right_40, label %logical_and_merge_40

logical_and_right_40:
  %t73 = load %Parser, %Parser* %l0
  %t74 = call %Token @parser_peek_raw(%Parser %t73)
  %t75 = extractvalue %Token %t74, 0
  %t76 = getelementptr inbounds %TokenKind, %TokenKind* %t75, i32 0, i32 0
  %t77 = load i32, i32* %t76
  %t78 = alloca %Statement
  %t79 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 0
  store i32 1, i32* %t79
  %t80 = load { %ExportSpecifier*, i64 }*, { %ExportSpecifier*, i64 }** %l2
  %t81 = bitcast { %ExportSpecifier*, i64 }* %t80 to { %ExportSpecifier**, i64 }*
  %t82 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t83 = bitcast [16 x i8]* %t82 to i8*
  %t84 = bitcast i8* %t83 to { %ExportSpecifier**, i64 }**
  store { %ExportSpecifier**, i64 }* %t81, { %ExportSpecifier**, i64 }** %t84
  %t85 = load i8*, i8** %l4
  %t86 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t87 = bitcast [16 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 8
  %t89 = bitcast i8* %t88 to i8**
  store i8* %t85, i8** %t89
  %t90 = load %Statement, %Statement* %t78
  store %Statement %t90, %Statement* %l5
  %t91 = load %Parser, %Parser* %l0
  %t92 = insertvalue %StatementParseResult undef, %Parser* null, 0
  %t93 = load %Statement, %Statement* %l5
  %t94 = insertvalue %StatementParseResult %t92, %Statement* null, 1
  ret %StatementParseResult %t94
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
  %t55 = getelementptr inbounds %TokenKind, %TokenKind* %t54, i32 0, i32 0
  %t56 = load i32, i32* %t55
  %t57 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t58 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t56, 0
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t56, 1
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t56, 2
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t56, 3
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t56, 4
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t56, 5
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %t76 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t56, 6
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %t79 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t56, 7
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %s82 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.82, i32 0, i32 0
  %t83 = icmp eq i8* %t81, %s82
  br label %logical_and_entry_52

logical_and_entry_52:
  br i1 %t83, label %logical_and_right_52, label %logical_and_merge_52

logical_and_right_52:
  %t84 = load %Token, %Token* %l8
  %t85 = extractvalue %Token %t84, 0
  %t86 = getelementptr inbounds %TokenKind, %TokenKind* %t85, i32 0, i32 0
  %t87 = load i32, i32* %t86
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  %t88 = load %Parser, %Parser* %l0
  %t89 = call %Parser @skip_trivia(%Parser %t88)
  store %Parser %t89, %Parser* %l0
  %t90 = load %Parser, %Parser* %l0
  %t91 = call %Token @parser_peek_raw(%Parser %t90)
  store %Token %t91, %Token* %l11
  %t93 = load %Token, %Token* %l11
  %t94 = extractvalue %Token %t93, 0
  %t95 = getelementptr inbounds %TokenKind, %TokenKind* %t94, i32 0, i32 0
  %t96 = load i32, i32* %t95
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
  br label %logical_and_entry_92

logical_and_entry_92:
  br i1 %t123, label %logical_and_right_92, label %logical_and_merge_92

logical_and_right_92:
  %t124 = load %Token, %Token* %l11
  %t125 = extractvalue %Token %t124, 0
  %t126 = getelementptr inbounds %TokenKind, %TokenKind* %t125, i32 0, i32 0
  %t127 = load i32, i32* %t126
  %t128 = load %Parser, %Parser* %l0
  %t129 = call %Parser @skip_trivia(%Parser %t128)
  store %Parser %t129, %Parser* %l0
  %t130 = load %Parser, %Parser* %l0
  %t131 = call %Token @parser_peek_raw(%Parser %t130)
  store %Token %t131, %Token* %l12
  %t133 = load %Token, %Token* %l12
  %t134 = extractvalue %Token %t133, 0
  %t135 = getelementptr inbounds %TokenKind, %TokenKind* %t134, i32 0, i32 0
  %t136 = load i32, i32* %t135
  %t137 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t138 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t136, 0
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t136, 1
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t136, 2
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t136, 3
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t136, 4
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t136, 5
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t136, 6
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t136, 7
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %s162 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.162, i32 0, i32 0
  %t163 = icmp eq i8* %t161, %s162
  br label %logical_and_entry_132

logical_and_entry_132:
  br i1 %t163, label %logical_and_right_132, label %logical_and_merge_132

logical_and_right_132:
  %t164 = load %Token, %Token* %l12
  %t165 = extractvalue %Token %t164, 0
  %t166 = getelementptr inbounds %TokenKind, %TokenKind* %t165, i32 0, i32 0
  %t167 = load i32, i32* %t166
  %t168 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t169 = call double @source_span_from_tokens({ %Token*, i64 }* %t168)
  store double %t169, double* %l13
  %t170 = alloca %Statement
  %t171 = getelementptr inbounds %Statement, %Statement* %t170, i32 0, i32 0
  store i32 2, i32* %t171
  %t172 = load i8*, i8** %l6
  %t173 = getelementptr inbounds %Statement, %Statement* %t170, i32 0, i32 1
  %t174 = bitcast [48 x i8]* %t173 to i8*
  %t175 = bitcast i8* %t174 to i8**
  store i8* %t172, i8** %t175
  %t176 = load i1, i1* %l3
  %t177 = getelementptr inbounds %Statement, %Statement* %t170, i32 0, i32 1
  %t178 = bitcast [48 x i8]* %t177 to i8*
  %t179 = getelementptr inbounds i8, i8* %t178, i64 8
  %t180 = bitcast i8* %t179 to i1*
  store i1 %t176, i1* %t180
  %t181 = load i8*, i8** %l7
  %t182 = bitcast i8* %t181 to %TypeAnnotation*
  %t183 = getelementptr inbounds %Statement, %Statement* %t170, i32 0, i32 1
  %t184 = bitcast [48 x i8]* %t183 to i8*
  %t185 = getelementptr inbounds i8, i8* %t184, i64 16
  %t186 = bitcast i8* %t185 to %TypeAnnotation**
  store %TypeAnnotation* %t182, %TypeAnnotation** %t186
  %t187 = load i8*, i8** %l9
  %t188 = bitcast i8* %t187 to %Expression*
  %t189 = getelementptr inbounds %Statement, %Statement* %t170, i32 0, i32 1
  %t190 = bitcast [48 x i8]* %t189 to i8*
  %t191 = getelementptr inbounds i8, i8* %t190, i64 24
  %t192 = bitcast i8* %t191 to %Expression**
  store %Expression* %t188, %Expression** %t192
  %t193 = load double, double* %l13
  %t194 = call noalias i8* @malloc(i64 8)
  %t195 = bitcast i8* %t194 to double*
  store double %t193, double* %t195
  %t196 = bitcast i8* %t194 to %SourceSpan*
  %t197 = getelementptr inbounds %Statement, %Statement* %t170, i32 0, i32 1
  %t198 = bitcast [48 x i8]* %t197 to i8*
  %t199 = getelementptr inbounds i8, i8* %t198, i64 32
  %t200 = bitcast i8* %t199 to %SourceSpan**
  store %SourceSpan* %t196, %SourceSpan** %t200
  %t201 = load i8*, i8** %l10
  %t202 = bitcast i8* %t201 to %SourceSpan*
  %t203 = getelementptr inbounds %Statement, %Statement* %t170, i32 0, i32 1
  %t204 = bitcast [48 x i8]* %t203 to i8*
  %t205 = getelementptr inbounds i8, i8* %t204, i64 40
  %t206 = bitcast i8* %t205 to %SourceSpan**
  store %SourceSpan* %t202, %SourceSpan** %t206
  %t207 = load %Statement, %Statement* %t170
  store %Statement %t207, %Statement* %l14
  %t208 = load %Parser, %Parser* %l0
  %t209 = insertvalue %StatementParseResult undef, %Parser* null, 0
  %t210 = load %Statement, %Statement* %l14
  %t211 = insertvalue %StatementParseResult %t209, %Statement* null, 1
  ret %StatementParseResult %t211
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
  %t220 = phi %Parser [ %t15, %entry ], [ %t218, %loop.latch2 ]
  %t221 = phi { %NamedSpecifier*, i64 }* [ %t16, %entry ], [ %t219, %loop.latch2 ]
  store %Parser %t220, %Parser* %l0
  store { %NamedSpecifier*, i64 }* %t221, { %NamedSpecifier*, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t17 = load %Parser, %Parser* %l0
  %t18 = call %Token @parser_peek_raw(%Parser %t17)
  store %Token %t18, %Token* %l2
  %t20 = load %Token, %Token* %l2
  %t21 = extractvalue %Token %t20, 0
  %t22 = getelementptr inbounds %TokenKind, %TokenKind* %t21, i32 0, i32 0
  %t23 = load i32, i32* %t22
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
  br label %logical_and_entry_19

logical_and_entry_19:
  br i1 %t50, label %logical_and_right_19, label %logical_and_merge_19

logical_and_right_19:
  %t51 = load %Token, %Token* %l2
  %t52 = extractvalue %Token %t51, 0
  %t53 = getelementptr inbounds %TokenKind, %TokenKind* %t52, i32 0, i32 0
  %t54 = load i32, i32* %t53
  %t55 = load %Token, %Token* %l2
  %t56 = extractvalue %Token %t55, 0
  %t57 = getelementptr inbounds %TokenKind, %TokenKind* %t56, i32 0, i32 0
  %t58 = load i32, i32* %t57
  %t59 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t60 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t61 = icmp eq i32 %t58, 0
  %t62 = select i1 %t61, i8* %t60, i8* %t59
  %t63 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t58, 1
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t58, 2
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t58, 3
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t58, 4
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t58, 5
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t58, 6
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %t81 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t58, 7
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %s84 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.84, i32 0, i32 0
  %t85 = icmp ne i8* %t83, %s84
  %t86 = load %Parser, %Parser* %l0
  %t87 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l1
  %t88 = load %Token, %Token* %l2
  br i1 %t85, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t89 = load %Token, %Token* %l2
  %t90 = call i8* @identifier_text(%Token %t89)
  store i8* %t90, i8** %l3
  %t91 = load %Parser, %Parser* %l0
  %t92 = call %Parser @parser_advance_raw(%Parser %t91)
  store %Parser %t92, %Parser* %l0
  %t93 = load %Parser, %Parser* %l0
  %t94 = call %Parser @skip_trivia(%Parser %t93)
  store %Parser %t94, %Parser* %l0
  store i8* null, i8** %l4
  %t95 = load %Parser, %Parser* %l0
  %t96 = call %Token @parser_peek_raw(%Parser %t95)
  store %Token %t96, %Token* %l5
  %t97 = load %Token, %Token* %l5
  %s98 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.98, i32 0, i32 0
  %t99 = call i1 @identifier_matches(%Token %t97, i8* %s98)
  %t100 = load %Parser, %Parser* %l0
  %t101 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l1
  %t102 = load %Token, %Token* %l2
  %t103 = load i8*, i8** %l3
  %t104 = load i8*, i8** %l4
  %t105 = load %Token, %Token* %l5
  br i1 %t99, label %then6, label %merge7
then6:
  %t106 = load %Parser, %Parser* %l0
  %s107 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.107, i32 0, i32 0
  %t108 = call %Parser @consume_keyword(%Parser %t106, i8* %s107)
  store %Parser %t108, %Parser* %l0
  %t109 = load %Parser, %Parser* %l0
  %t110 = call %Parser @skip_trivia(%Parser %t109)
  store %Parser %t110, %Parser* %l0
  %t111 = load %Parser, %Parser* %l0
  %t112 = call %Token @parser_peek_raw(%Parser %t111)
  store %Token %t112, %Token* %l6
  %t113 = load %Token, %Token* %l6
  %t114 = extractvalue %Token %t113, 0
  %t115 = getelementptr inbounds %TokenKind, %TokenKind* %t114, i32 0, i32 0
  %t116 = load i32, i32* %t115
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
  %s142 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.142, i32 0, i32 0
  %t143 = icmp eq i8* %t141, %s142
  %t144 = load %Parser, %Parser* %l0
  %t145 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l1
  %t146 = load %Token, %Token* %l2
  %t147 = load i8*, i8** %l3
  %t148 = load i8*, i8** %l4
  %t149 = load %Token, %Token* %l5
  %t150 = load %Token, %Token* %l6
  br i1 %t143, label %then8, label %merge9
then8:
  %t151 = load %Token, %Token* %l6
  %t152 = call i8* @identifier_text(%Token %t151)
  store i8* %t152, i8** %l4
  %t153 = load %Parser, %Parser* %l0
  %t154 = call %Parser @parser_advance_raw(%Parser %t153)
  store %Parser %t154, %Parser* %l0
  %t155 = load %Parser, %Parser* %l0
  %t156 = call %Parser @skip_trivia(%Parser %t155)
  store %Parser %t156, %Parser* %l0
  br label %merge9
merge9:
  %t157 = phi i8* [ %t152, %then8 ], [ %t148, %then6 ]
  %t158 = phi %Parser [ %t154, %then8 ], [ %t144, %then6 ]
  %t159 = phi %Parser [ %t156, %then8 ], [ %t144, %then6 ]
  store i8* %t157, i8** %l4
  store %Parser %t158, %Parser* %l0
  store %Parser %t159, %Parser* %l0
  br label %merge7
merge7:
  %t160 = phi %Parser [ %t108, %then6 ], [ %t100, %loop.body1 ]
  %t161 = phi %Parser [ %t110, %then6 ], [ %t100, %loop.body1 ]
  %t162 = phi i8* [ %t152, %then6 ], [ %t104, %loop.body1 ]
  %t163 = phi %Parser [ %t154, %then6 ], [ %t100, %loop.body1 ]
  %t164 = phi %Parser [ %t156, %then6 ], [ %t100, %loop.body1 ]
  store %Parser %t160, %Parser* %l0
  store %Parser %t161, %Parser* %l0
  store i8* %t162, i8** %l4
  store %Parser %t163, %Parser* %l0
  store %Parser %t164, %Parser* %l0
  %t165 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l1
  %t166 = load i8*, i8** %l3
  %t167 = insertvalue %NamedSpecifier undef, i8* %t166, 0
  %t168 = load i8*, i8** %l4
  %t169 = insertvalue %NamedSpecifier %t167, i8* %t168, 1
  %t170 = alloca [1 x %NamedSpecifier]
  %t171 = getelementptr [1 x %NamedSpecifier], [1 x %NamedSpecifier]* %t170, i32 0, i32 0
  %t172 = getelementptr %NamedSpecifier, %NamedSpecifier* %t171, i64 0
  store %NamedSpecifier %t169, %NamedSpecifier* %t172
  %t173 = alloca { %NamedSpecifier*, i64 }
  %t174 = getelementptr { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %t173, i32 0, i32 0
  store %NamedSpecifier* %t171, %NamedSpecifier** %t174
  %t175 = getelementptr { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %t173, i32 0, i32 1
  store i64 1, i64* %t175
  %t176 = bitcast { %NamedSpecifier*, i64 }* %t165 to { i8**, i64 }*
  %t177 = bitcast { %NamedSpecifier*, i64 }* %t173 to { i8**, i64 }*
  %t178 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t176, { i8**, i64 }* %t177)
  %t179 = bitcast { i8**, i64 }* %t178 to { %NamedSpecifier*, i64 }*
  store { %NamedSpecifier*, i64 }* %t179, { %NamedSpecifier*, i64 }** %l1
  %t180 = load %Parser, %Parser* %l0
  %t181 = call %Token @parser_peek_raw(%Parser %t180)
  store %Token %t181, %Token* %l7
  %t183 = load %Token, %Token* %l7
  %t184 = extractvalue %Token %t183, 0
  %t185 = getelementptr inbounds %TokenKind, %TokenKind* %t184, i32 0, i32 0
  %t186 = load i32, i32* %t185
  %t187 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t188 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t186, 0
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %t191 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t192 = icmp eq i32 %t186, 1
  %t193 = select i1 %t192, i8* %t191, i8* %t190
  %t194 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t195 = icmp eq i32 %t186, 2
  %t196 = select i1 %t195, i8* %t194, i8* %t193
  %t197 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t198 = icmp eq i32 %t186, 3
  %t199 = select i1 %t198, i8* %t197, i8* %t196
  %t200 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t201 = icmp eq i32 %t186, 4
  %t202 = select i1 %t201, i8* %t200, i8* %t199
  %t203 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t204 = icmp eq i32 %t186, 5
  %t205 = select i1 %t204, i8* %t203, i8* %t202
  %t206 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t207 = icmp eq i32 %t186, 6
  %t208 = select i1 %t207, i8* %t206, i8* %t205
  %t209 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t210 = icmp eq i32 %t186, 7
  %t211 = select i1 %t210, i8* %t209, i8* %t208
  %s212 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.212, i32 0, i32 0
  %t213 = icmp eq i8* %t211, %s212
  br label %logical_and_entry_182

logical_and_entry_182:
  br i1 %t213, label %logical_and_right_182, label %logical_and_merge_182

logical_and_right_182:
  %t214 = load %Token, %Token* %l7
  %t215 = extractvalue %Token %t214, 0
  %t216 = getelementptr inbounds %TokenKind, %TokenKind* %t215, i32 0, i32 0
  %t217 = load i32, i32* %t216
  br label %loop.latch2
loop.latch2:
  %t218 = load %Parser, %Parser* %l0
  %t219 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t222 = load %Parser, %Parser* %l0
  %t223 = call %Parser @skip_trivia(%Parser %t222)
  store %Parser %t223, %Parser* %l0
  %t225 = load %Parser, %Parser* %l0
  %t226 = call %Token @parser_peek_raw(%Parser %t225)
  %t227 = extractvalue %Token %t226, 0
  %t228 = getelementptr inbounds %TokenKind, %TokenKind* %t227, i32 0, i32 0
  %t229 = load i32, i32* %t228
  %t230 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t231 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t232 = icmp eq i32 %t229, 0
  %t233 = select i1 %t232, i8* %t231, i8* %t230
  %t234 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t235 = icmp eq i32 %t229, 1
  %t236 = select i1 %t235, i8* %t234, i8* %t233
  %t237 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t238 = icmp eq i32 %t229, 2
  %t239 = select i1 %t238, i8* %t237, i8* %t236
  %t240 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t241 = icmp eq i32 %t229, 3
  %t242 = select i1 %t241, i8* %t240, i8* %t239
  %t243 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t244 = icmp eq i32 %t229, 4
  %t245 = select i1 %t244, i8* %t243, i8* %t242
  %t246 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t247 = icmp eq i32 %t229, 5
  %t248 = select i1 %t247, i8* %t246, i8* %t245
  %t249 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t250 = icmp eq i32 %t229, 6
  %t251 = select i1 %t250, i8* %t249, i8* %t248
  %t252 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t253 = icmp eq i32 %t229, 7
  %t254 = select i1 %t253, i8* %t252, i8* %t251
  %s255 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.255, i32 0, i32 0
  %t256 = icmp eq i8* %t254, %s255
  br label %logical_and_entry_224

logical_and_entry_224:
  br i1 %t256, label %logical_and_right_224, label %logical_and_merge_224

logical_and_right_224:
  %t257 = load %Parser, %Parser* %l0
  %t258 = call %Token @parser_peek_raw(%Parser %t257)
  %t259 = extractvalue %Token %t258, 0
  %t260 = getelementptr inbounds %TokenKind, %TokenKind* %t259, i32 0, i32 0
  %t261 = load i32, i32* %t260
  %t262 = load %Parser, %Parser* %l0
  %t263 = insertvalue %SpecifierListParseResult undef, %Parser* null, 0
  %t264 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l1
  %t265 = bitcast { %NamedSpecifier*, i64 }* %t264 to { %NamedSpecifier**, i64 }*
  %t266 = insertvalue %SpecifierListParseResult %t263, { %NamedSpecifier**, i64 }* %t265, 1
  ret %SpecifierListParseResult %t266
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
  store %Parser zeroinitializer, %Parser* %l0
  %t25 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t26 = extractvalue %TypeParameterParseResult %t25, 1
  store { %TypeParameter**, i64 }* %t26, { %TypeParameter**, i64 }** %l5
  %t27 = load %Parser, %Parser* %l0
  %t28 = call %ImplementsParseResult @parse_implements_clause(%Parser %t27)
  store %ImplementsParseResult %t28, %ImplementsParseResult* %l6
  %t29 = load %ImplementsParseResult, %ImplementsParseResult* %l6
  %t30 = extractvalue %ImplementsParseResult %t29, 0
  store %Parser zeroinitializer, %Parser* %l0
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
  %t221 = phi %Parser [ %t57, %entry ], [ %t220, %loop.latch2 ]
  store %Parser %t221, %Parser* %l0
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
  store %Parser zeroinitializer, %Parser* %l0
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
  %t83 = getelementptr inbounds %TokenKind, %TokenKind* %t82, i32 0, i32 0
  %t84 = load i32, i32* %t83
  %t85 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t86 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t87 = icmp eq i32 %t84, 0
  %t88 = select i1 %t87, i8* %t86, i8* %t85
  %t89 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t90 = icmp eq i32 %t84, 1
  %t91 = select i1 %t90, i8* %t89, i8* %t88
  %t92 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t93 = icmp eq i32 %t84, 2
  %t94 = select i1 %t93, i8* %t92, i8* %t91
  %t95 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t84, 3
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %t98 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t84, 4
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t84, 5
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t84, 6
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t84, 7
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %s110 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.110, i32 0, i32 0
  %t111 = icmp eq i8* %t109, %s110
  br label %logical_and_entry_80

logical_and_entry_80:
  br i1 %t111, label %logical_and_right_80, label %logical_and_merge_80

logical_and_right_80:
  %t112 = load %Token, %Token* %l13
  %t113 = extractvalue %Token %t112, 0
  %t114 = getelementptr inbounds %TokenKind, %TokenKind* %t113, i32 0, i32 0
  %t115 = load i32, i32* %t114
  %t116 = load %Token, %Token* %l13
  %t117 = extractvalue %Token %t116, 0
  %t118 = getelementptr inbounds %TokenKind, %TokenKind* %t117, i32 0, i32 0
  %t119 = load i32, i32* %t118
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
  %s145 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.145, i32 0, i32 0
  %t146 = icmp eq i8* %t144, %s145
  %t147 = load %Parser, %Parser* %l0
  %t148 = load %Token, %Token* %l1
  %t149 = load i8*, i8** %l2
  %t150 = load double, double* %l3
  %t151 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t152 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l5
  %t153 = load %ImplementsParseResult, %ImplementsParseResult* %l6
  %t154 = load { %TypeAnnotation**, i64 }*, { %TypeAnnotation**, i64 }** %l7
  %t155 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l8
  %t156 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %l9
  %t157 = load %Parser, %Parser* %l10
  %t158 = load %DecoratorParseResult, %DecoratorParseResult* %l11
  %t159 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l12
  %t160 = load %Token, %Token* %l13
  br i1 %t146, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t161 = load %Parser, %Parser* %l0
  %t162 = call %StructFieldParseResult @parse_struct_field(%Parser %t161)
  store %StructFieldParseResult %t162, %StructFieldParseResult* %l14
  %t164 = load %StructFieldParseResult, %StructFieldParseResult* %l14
  %t165 = extractvalue %StructFieldParseResult %t164, 2
  br label %logical_and_entry_163

logical_and_entry_163:
  br i1 %t165, label %logical_and_right_163, label %logical_and_merge_163

logical_and_right_163:
  %t166 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l12
  %t167 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t166
  %t168 = extractvalue { %Decorator**, i64 } %t167, 1
  %t169 = icmp eq i64 %t168, 0
  br label %logical_and_right_end_163

logical_and_right_end_163:
  br label %logical_and_merge_163

logical_and_merge_163:
  %t170 = phi i1 [ false, %logical_and_entry_163 ], [ %t169, %logical_and_right_end_163 ]
  %t171 = load %Parser, %Parser* %l0
  %t172 = load %Token, %Token* %l1
  %t173 = load i8*, i8** %l2
  %t174 = load double, double* %l3
  %t175 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t176 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l5
  %t177 = load %ImplementsParseResult, %ImplementsParseResult* %l6
  %t178 = load { %TypeAnnotation**, i64 }*, { %TypeAnnotation**, i64 }** %l7
  %t179 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l8
  %t180 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %l9
  %t181 = load %Parser, %Parser* %l10
  %t182 = load %DecoratorParseResult, %DecoratorParseResult* %l11
  %t183 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l12
  %t184 = load %Token, %Token* %l13
  %t185 = load %StructFieldParseResult, %StructFieldParseResult* %l14
  br i1 %t170, label %then6, label %merge7
then6:
  %t186 = load %StructFieldParseResult, %StructFieldParseResult* %l14
  %t187 = extractvalue %StructFieldParseResult %t186, 1
  %t188 = bitcast i8* null to %FieldDeclaration*
  %t189 = load %StructFieldParseResult, %StructFieldParseResult* %l14
  %t190 = extractvalue %StructFieldParseResult %t189, 0
  store %Parser zeroinitializer, %Parser* %l0
  br label %loop.latch2
merge7:
  %t191 = load %Parser, %Parser* %l0
  %t192 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l12
  %t193 = bitcast { %Decorator**, i64 }* %t192 to { %Decorator*, i64 }*
  %t194 = call %MethodParseResult @parse_struct_method(%Parser %t191, { %Decorator*, i64 }* %t193)
  store %MethodParseResult %t194, %MethodParseResult* %l15
  %t195 = load %MethodParseResult, %MethodParseResult* %l15
  %t196 = extractvalue %MethodParseResult %t195, 2
  %t197 = load %Parser, %Parser* %l0
  %t198 = load %Token, %Token* %l1
  %t199 = load i8*, i8** %l2
  %t200 = load double, double* %l3
  %t201 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t202 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l5
  %t203 = load %ImplementsParseResult, %ImplementsParseResult* %l6
  %t204 = load { %TypeAnnotation**, i64 }*, { %TypeAnnotation**, i64 }** %l7
  %t205 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l8
  %t206 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %l9
  %t207 = load %Parser, %Parser* %l10
  %t208 = load %DecoratorParseResult, %DecoratorParseResult* %l11
  %t209 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l12
  %t210 = load %Token, %Token* %l13
  %t211 = load %StructFieldParseResult, %StructFieldParseResult* %l14
  %t212 = load %MethodParseResult, %MethodParseResult* %l15
  br i1 %t196, label %then8, label %merge9
then8:
  %t213 = load %MethodParseResult, %MethodParseResult* %l15
  %t214 = extractvalue %MethodParseResult %t213, 1
  %t215 = bitcast i8* null to %MethodDeclaration*
  %t216 = load %MethodParseResult, %MethodParseResult* %l15
  %t217 = extractvalue %MethodParseResult %t216, 0
  store %Parser zeroinitializer, %Parser* %l0
  br label %loop.latch2
merge9:
  %t218 = load %Parser, %Parser* %l10
  %t219 = call %Parser @skip_struct_member(%Parser %t218)
  store %Parser %t219, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t220 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t222 = alloca %Statement
  %t223 = getelementptr inbounds %Statement, %Statement* %t222, i32 0, i32 0
  store i32 8, i32* %t223
  %t224 = load i8*, i8** %l2
  %t225 = getelementptr inbounds %Statement, %Statement* %t222, i32 0, i32 1
  %t226 = bitcast [56 x i8]* %t225 to i8*
  %t227 = bitcast i8* %t226 to i8**
  store i8* %t224, i8** %t227
  %t228 = load double, double* %l3
  %t229 = call noalias i8* @malloc(i64 8)
  %t230 = bitcast i8* %t229 to double*
  store double %t228, double* %t230
  %t231 = bitcast i8* %t229 to %SourceSpan*
  %t232 = getelementptr inbounds %Statement, %Statement* %t222, i32 0, i32 1
  %t233 = bitcast [56 x i8]* %t232 to i8*
  %t234 = getelementptr inbounds i8, i8* %t233, i64 8
  %t235 = bitcast i8* %t234 to %SourceSpan**
  store %SourceSpan* %t231, %SourceSpan** %t235
  %t236 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l5
  %t237 = getelementptr inbounds %Statement, %Statement* %t222, i32 0, i32 1
  %t238 = bitcast [56 x i8]* %t237 to i8*
  %t239 = getelementptr inbounds i8, i8* %t238, i64 16
  %t240 = bitcast i8* %t239 to { %TypeParameter**, i64 }**
  store { %TypeParameter**, i64 }* %t236, { %TypeParameter**, i64 }** %t240
  %t241 = load { %TypeAnnotation**, i64 }*, { %TypeAnnotation**, i64 }** %l7
  %t242 = getelementptr inbounds %Statement, %Statement* %t222, i32 0, i32 1
  %t243 = bitcast [56 x i8]* %t242 to i8*
  %t244 = getelementptr inbounds i8, i8* %t243, i64 24
  %t245 = bitcast i8* %t244 to { %TypeAnnotation**, i64 }**
  store { %TypeAnnotation**, i64 }* %t241, { %TypeAnnotation**, i64 }** %t245
  %t246 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l8
  %t247 = bitcast { %FieldDeclaration*, i64 }* %t246 to { %FieldDeclaration**, i64 }*
  %t248 = getelementptr inbounds %Statement, %Statement* %t222, i32 0, i32 1
  %t249 = bitcast [56 x i8]* %t248 to i8*
  %t250 = getelementptr inbounds i8, i8* %t249, i64 32
  %t251 = bitcast i8* %t250 to { %FieldDeclaration**, i64 }**
  store { %FieldDeclaration**, i64 }* %t247, { %FieldDeclaration**, i64 }** %t251
  %t252 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %l9
  %t253 = bitcast { %MethodDeclaration*, i64 }* %t252 to { %MethodDeclaration**, i64 }*
  %t254 = getelementptr inbounds %Statement, %Statement* %t222, i32 0, i32 1
  %t255 = bitcast [56 x i8]* %t254 to i8*
  %t256 = getelementptr inbounds i8, i8* %t255, i64 40
  %t257 = bitcast i8* %t256 to { %MethodDeclaration**, i64 }**
  store { %MethodDeclaration**, i64 }* %t253, { %MethodDeclaration**, i64 }** %t257
  %t258 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t259 = getelementptr inbounds %Statement, %Statement* %t222, i32 0, i32 1
  %t260 = bitcast [56 x i8]* %t259 to i8*
  %t261 = getelementptr inbounds i8, i8* %t260, i64 48
  %t262 = bitcast i8* %t261 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t258, { %Decorator**, i64 }** %t262
  %t263 = load %Statement, %Statement* %t222
  store %Statement %t263, %Statement* %l16
  %t264 = load %Parser, %Parser* %l0
  %t265 = insertvalue %StatementParseResult undef, %Parser* null, 0
  %t266 = load %Statement, %Statement* %l16
  %t267 = insertvalue %StatementParseResult %t265, %Statement* null, 1
  ret %StatementParseResult %t267
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
  %t12 = getelementptr inbounds %TokenKind, %TokenKind* %t11, i32 0, i32 0
  %t13 = load i32, i32* %t12
  %t14 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t15 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t16 = icmp eq i32 %t13, 0
  %t17 = select i1 %t16, i8* %t15, i8* %t14
  %t18 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t19 = icmp eq i32 %t13, 1
  %t20 = select i1 %t19, i8* %t18, i8* %t17
  %t21 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t22 = icmp eq i32 %t13, 2
  %t23 = select i1 %t22, i8* %t21, i8* %t20
  %t24 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t13, 3
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %t27 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t28 = icmp eq i32 %t13, 4
  %t29 = select i1 %t28, i8* %t27, i8* %t26
  %t30 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t31 = icmp eq i32 %t13, 5
  %t32 = select i1 %t31, i8* %t30, i8* %t29
  %t33 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t34 = icmp eq i32 %t13, 6
  %t35 = select i1 %t34, i8* %t33, i8* %t32
  %t36 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t37 = icmp eq i32 %t13, 7
  %t38 = select i1 %t37, i8* %t36, i8* %t35
  %s39 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.39, i32 0, i32 0
  %t40 = icmp ne i8* %t38, %s39
  %t41 = load %Parser, %Parser* %l0
  %t42 = load %Parser, %Parser* %l1
  %t43 = load %Token, %Token* %l2
  br i1 %t40, label %then0, label %merge1
then0:
  %t44 = load %Parser, %Parser* %l1
  %t45 = call %StatementParseResult @parse_unknown(%Parser %t44)
  ret %StatementParseResult %t45
merge1:
  %t46 = load %Token, %Token* %l2
  %t47 = call i8* @identifier_text(%Token %t46)
  store i8* %t47, i8** %l3
  %t48 = load %Token, %Token* %l2
  %t49 = alloca [1 x %Token]
  %t50 = getelementptr [1 x %Token], [1 x %Token]* %t49, i32 0, i32 0
  %t51 = getelementptr %Token, %Token* %t50, i64 0
  store %Token %t48, %Token* %t51
  %t52 = alloca { %Token*, i64 }
  %t53 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t52, i32 0, i32 0
  store %Token* %t50, %Token** %t53
  %t54 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t52, i32 0, i32 1
  store i64 1, i64* %t54
  %t55 = call double @source_span_from_tokens({ %Token*, i64 }* %t52)
  store double %t55, double* %l4
  %t56 = load %Parser, %Parser* %l0
  %t57 = call %Parser @parser_advance_raw(%Parser %t56)
  store %Parser %t57, %Parser* %l0
  %t58 = load %Parser, %Parser* %l0
  %t59 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %t58)
  store %TypeParameterParseResult %t59, %TypeParameterParseResult* %l5
  %t60 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t61 = extractvalue %TypeParameterParseResult %t60, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t62 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t63 = extractvalue %TypeParameterParseResult %t62, 1
  store { %TypeParameter**, i64 }* %t63, { %TypeParameter**, i64 }** %l6
  %t64 = load %Parser, %Parser* %l0
  %t65 = call %Parser @skip_trivia(%Parser %t64)
  store %Parser %t65, %Parser* %l0
  %t66 = load %Parser, %Parser* %l0
  %t67 = call %Token @parser_peek_raw(%Parser %t66)
  store %Token %t67, %Token* %l7
  %t69 = load %Token, %Token* %l7
  %t70 = extractvalue %Token %t69, 0
  %t71 = getelementptr inbounds %TokenKind, %TokenKind* %t70, i32 0, i32 0
  %t72 = load i32, i32* %t71
  %t73 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t74 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t75 = icmp eq i32 %t72, 0
  %t76 = select i1 %t75, i8* %t74, i8* %t73
  %t77 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t78 = icmp eq i32 %t72, 1
  %t79 = select i1 %t78, i8* %t77, i8* %t76
  %t80 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t81 = icmp eq i32 %t72, 2
  %t82 = select i1 %t81, i8* %t80, i8* %t79
  %t83 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t84 = icmp eq i32 %t72, 3
  %t85 = select i1 %t84, i8* %t83, i8* %t82
  %t86 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t87 = icmp eq i32 %t72, 4
  %t88 = select i1 %t87, i8* %t86, i8* %t85
  %t89 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t90 = icmp eq i32 %t72, 5
  %t91 = select i1 %t90, i8* %t89, i8* %t88
  %t92 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t93 = icmp eq i32 %t72, 6
  %t94 = select i1 %t93, i8* %t92, i8* %t91
  %t95 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t72, 7
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %s98 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.98, i32 0, i32 0
  %t99 = icmp ne i8* %t97, %s98
  br label %logical_or_entry_68

logical_or_entry_68:
  br i1 %t99, label %logical_or_merge_68, label %logical_or_right_68

logical_or_right_68:
  %t100 = load %Token, %Token* %l7
  %t101 = extractvalue %Token %t100, 0
  %t102 = getelementptr inbounds %TokenKind, %TokenKind* %t101, i32 0, i32 0
  %t103 = load i32, i32* %t102
  %t104 = load %Parser, %Parser* %l0
  %t105 = call %Parser @parser_advance_raw(%Parser %t104)
  store %Parser %t105, %Parser* %l0
  %t106 = load %Parser, %Parser* %l0
  %t107 = call %Parser @skip_trivia(%Parser %t106)
  %t108 = alloca [1 x i8]
  %t109 = getelementptr [1 x i8], [1 x i8]* %t108, i32 0, i32 0
  %t110 = getelementptr i8, i8* %t109, i64 0
  store i8 59, i8* %t110
  %t111 = alloca { i8*, i64 }
  %t112 = getelementptr { i8*, i64 }, { i8*, i64 }* %t111, i32 0, i32 0
  store i8* %t109, i8** %t112
  %t113 = getelementptr { i8*, i64 }, { i8*, i64 }* %t111, i32 0, i32 1
  store i64 1, i64* %t113
  %t114 = bitcast { i8*, i64 }* %t111 to { i8**, i64 }*
  %t115 = call %CaptureResult @collect_until(%Parser %t107, { i8**, i64 }* %t114)
  store %CaptureResult %t115, %CaptureResult* %l8
  %t116 = load %CaptureResult, %CaptureResult* %l8
  %t117 = extractvalue %CaptureResult %t116, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t118 = load %CaptureResult, %CaptureResult* %l8
  %t119 = extractvalue %CaptureResult %t118, 1
  %t120 = bitcast { %Token**, i64 }* %t119 to { %Token*, i64 }*
  %t121 = call i8* @tokens_to_text({ %Token*, i64 }* %t120)
  %t122 = call i8* @trim_text(i8* %t121)
  store i8* %t122, i8** %l9
  %t123 = load i8*, i8** %l9
  %t124 = call i64 @sailfin_runtime_string_length(i8* %t123)
  %t125 = icmp eq i64 %t124, 0
  %t126 = load %Parser, %Parser* %l0
  %t127 = load %Parser, %Parser* %l1
  %t128 = load %Token, %Token* %l2
  %t129 = load i8*, i8** %l3
  %t130 = load double, double* %l4
  %t131 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t132 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l6
  %t133 = load %Token, %Token* %l7
  %t134 = load %CaptureResult, %CaptureResult* %l8
  %t135 = load i8*, i8** %l9
  br i1 %t125, label %then2, label %merge3
then2:
  %t136 = load %Parser, %Parser* %l1
  %t137 = call %StatementParseResult @parse_unknown(%Parser %t136)
  ret %StatementParseResult %t137
merge3:
  %t138 = load i8*, i8** %l9
  %t139 = insertvalue %TypeAnnotation undef, i8* %t138, 0
  store %TypeAnnotation %t139, %TypeAnnotation* %l10
  %t140 = load %Parser, %Parser* %l0
  %t141 = call %Parser @skip_trivia(%Parser %t140)
  store %Parser %t141, %Parser* %l0
  %t143 = load %Parser, %Parser* %l0
  %t144 = call %Token @parser_peek_raw(%Parser %t143)
  %t145 = extractvalue %Token %t144, 0
  %t146 = getelementptr inbounds %TokenKind, %TokenKind* %t145, i32 0, i32 0
  %t147 = load i32, i32* %t146
  %t148 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t149 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t147, 0
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t147, 1
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t147, 2
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t147, 3
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t147, 4
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t147, 5
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t147, 6
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t147, 7
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %s173 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.173, i32 0, i32 0
  %t174 = icmp eq i8* %t172, %s173
  br label %logical_and_entry_142

logical_and_entry_142:
  br i1 %t174, label %logical_and_right_142, label %logical_and_merge_142

logical_and_right_142:
  %t175 = load %Parser, %Parser* %l0
  %t176 = call %Token @parser_peek_raw(%Parser %t175)
  %t177 = extractvalue %Token %t176, 0
  %t178 = getelementptr inbounds %TokenKind, %TokenKind* %t177, i32 0, i32 0
  %t179 = load i32, i32* %t178
  %t180 = alloca %Statement
  %t181 = getelementptr inbounds %Statement, %Statement* %t180, i32 0, i32 0
  store i32 9, i32* %t181
  %t182 = load i8*, i8** %l3
  %t183 = getelementptr inbounds %Statement, %Statement* %t180, i32 0, i32 1
  %t184 = bitcast [40 x i8]* %t183 to i8*
  %t185 = bitcast i8* %t184 to i8**
  store i8* %t182, i8** %t185
  %t186 = load double, double* %l4
  %t187 = call noalias i8* @malloc(i64 8)
  %t188 = bitcast i8* %t187 to double*
  store double %t186, double* %t188
  %t189 = bitcast i8* %t187 to %SourceSpan*
  %t190 = getelementptr inbounds %Statement, %Statement* %t180, i32 0, i32 1
  %t191 = bitcast [40 x i8]* %t190 to i8*
  %t192 = getelementptr inbounds i8, i8* %t191, i64 8
  %t193 = bitcast i8* %t192 to %SourceSpan**
  store %SourceSpan* %t189, %SourceSpan** %t193
  %t194 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l6
  %t195 = getelementptr inbounds %Statement, %Statement* %t180, i32 0, i32 1
  %t196 = bitcast [40 x i8]* %t195 to i8*
  %t197 = getelementptr inbounds i8, i8* %t196, i64 16
  %t198 = bitcast i8* %t197 to { %TypeParameter**, i64 }**
  store { %TypeParameter**, i64 }* %t194, { %TypeParameter**, i64 }** %t198
  %t199 = load %TypeAnnotation, %TypeAnnotation* %l10
  %t200 = call noalias i8* @malloc(i64 8)
  %t201 = bitcast i8* %t200 to %TypeAnnotation*
  store %TypeAnnotation %t199, %TypeAnnotation* %t201
  %t202 = bitcast i8* %t200 to %TypeAnnotation*
  %t203 = getelementptr inbounds %Statement, %Statement* %t180, i32 0, i32 1
  %t204 = bitcast [40 x i8]* %t203 to i8*
  %t205 = getelementptr inbounds i8, i8* %t204, i64 24
  %t206 = bitcast i8* %t205 to %TypeAnnotation**
  store %TypeAnnotation* %t202, %TypeAnnotation** %t206
  %t207 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t208 = getelementptr inbounds %Statement, %Statement* %t180, i32 0, i32 1
  %t209 = bitcast [40 x i8]* %t208 to i8*
  %t210 = getelementptr inbounds i8, i8* %t209, i64 32
  %t211 = bitcast i8* %t210 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t207, { %Decorator**, i64 }** %t211
  %t212 = load %Statement, %Statement* %t180
  store %Statement %t212, %Statement* %l11
  %t213 = load %Parser, %Parser* %l0
  %t214 = insertvalue %StatementParseResult undef, %Parser* null, 0
  %t215 = load %Statement, %Statement* %l11
  %t216 = insertvalue %StatementParseResult %t214, %Statement* null, 1
  ret %StatementParseResult %t216
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
  %t12 = getelementptr inbounds %TokenKind, %TokenKind* %t11, i32 0, i32 0
  %t13 = load i32, i32* %t12
  %t14 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t15 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t16 = icmp eq i32 %t13, 0
  %t17 = select i1 %t16, i8* %t15, i8* %t14
  %t18 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t19 = icmp eq i32 %t13, 1
  %t20 = select i1 %t19, i8* %t18, i8* %t17
  %t21 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t22 = icmp eq i32 %t13, 2
  %t23 = select i1 %t22, i8* %t21, i8* %t20
  %t24 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t13, 3
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %t27 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t28 = icmp eq i32 %t13, 4
  %t29 = select i1 %t28, i8* %t27, i8* %t26
  %t30 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t31 = icmp eq i32 %t13, 5
  %t32 = select i1 %t31, i8* %t30, i8* %t29
  %t33 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t34 = icmp eq i32 %t13, 6
  %t35 = select i1 %t34, i8* %t33, i8* %t32
  %t36 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t37 = icmp eq i32 %t13, 7
  %t38 = select i1 %t37, i8* %t36, i8* %t35
  %s39 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.39, i32 0, i32 0
  %t40 = icmp ne i8* %t38, %s39
  %t41 = load %Parser, %Parser* %l0
  %t42 = load %Parser, %Parser* %l1
  %t43 = load %Token, %Token* %l2
  br i1 %t40, label %then0, label %merge1
then0:
  %t44 = load %Parser, %Parser* %l1
  %t45 = call %StatementParseResult @parse_unknown(%Parser %t44)
  ret %StatementParseResult %t45
merge1:
  %t46 = load %Token, %Token* %l2
  %t47 = call i8* @identifier_text(%Token %t46)
  store i8* %t47, i8** %l3
  %t48 = load %Token, %Token* %l2
  %t49 = alloca [1 x %Token]
  %t50 = getelementptr [1 x %Token], [1 x %Token]* %t49, i32 0, i32 0
  %t51 = getelementptr %Token, %Token* %t50, i64 0
  store %Token %t48, %Token* %t51
  %t52 = alloca { %Token*, i64 }
  %t53 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t52, i32 0, i32 0
  store %Token* %t50, %Token** %t53
  %t54 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t52, i32 0, i32 1
  store i64 1, i64* %t54
  %t55 = call double @source_span_from_tokens({ %Token*, i64 }* %t52)
  store double %t55, double* %l4
  %t56 = load %Parser, %Parser* %l0
  %t57 = call %Parser @parser_advance_raw(%Parser %t56)
  store %Parser %t57, %Parser* %l0
  %t58 = load %Parser, %Parser* %l0
  %t59 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %t58)
  store %TypeParameterParseResult %t59, %TypeParameterParseResult* %l5
  %t60 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t61 = extractvalue %TypeParameterParseResult %t60, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t62 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t63 = extractvalue %TypeParameterParseResult %t62, 1
  store { %TypeParameter**, i64 }* %t63, { %TypeParameter**, i64 }** %l6
  %t64 = load %Parser, %Parser* %l0
  %t65 = call %Parser @skip_trivia(%Parser %t64)
  store %Parser %t65, %Parser* %l0
  %t66 = load %Parser, %Parser* %l0
  %t67 = alloca [2 x i8], align 1
  %t68 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 0
  store i8 123, i8* %t68
  %t69 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 1
  store i8 0, i8* %t69
  %t70 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 0
  %t71 = call %Parser @advance_to_symbol(%Parser %t66, i8* %t70)
  store %Parser %t71, %Parser* %l0
  %t72 = load %Parser, %Parser* %l0
  %t73 = alloca [2 x i8], align 1
  %t74 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 0
  store i8 123, i8* %t74
  %t75 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 1
  store i8 0, i8* %t75
  %t76 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 0
  %t77 = call %Parser @consume_symbol(%Parser %t72, i8* %t76)
  store %Parser %t77, %Parser* %l0
  %t78 = alloca [0 x %FunctionSignature]
  %t79 = getelementptr [0 x %FunctionSignature], [0 x %FunctionSignature]* %t78, i32 0, i32 0
  %t80 = alloca { %FunctionSignature*, i64 }
  %t81 = getelementptr { %FunctionSignature*, i64 }, { %FunctionSignature*, i64 }* %t80, i32 0, i32 0
  store %FunctionSignature* %t79, %FunctionSignature** %t81
  %t82 = getelementptr { %FunctionSignature*, i64 }, { %FunctionSignature*, i64 }* %t80, i32 0, i32 1
  store i64 0, i64* %t82
  store { %FunctionSignature*, i64 }* %t80, { %FunctionSignature*, i64 }** %l7
  %t83 = load %Parser, %Parser* %l0
  %t84 = load %Parser, %Parser* %l1
  %t85 = load %Token, %Token* %l2
  %t86 = load i8*, i8** %l3
  %t87 = load double, double* %l4
  %t88 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t89 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l6
  %t90 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %l7
  br label %loop.header2
loop.header2:
  %t207 = phi %Parser [ %t83, %entry ], [ %t206, %loop.latch4 ]
  store %Parser %t207, %Parser* %l0
  br label %loop.body3
loop.body3:
  %t91 = load %Parser, %Parser* %l0
  %t92 = call %Parser @skip_trivia(%Parser %t91)
  store %Parser %t92, %Parser* %l0
  %t93 = load %Parser, %Parser* %l0
  %t94 = call %Token @parser_peek_raw(%Parser %t93)
  store %Token %t94, %Token* %l8
  %t96 = load %Token, %Token* %l8
  %t97 = extractvalue %Token %t96, 0
  %t98 = getelementptr inbounds %TokenKind, %TokenKind* %t97, i32 0, i32 0
  %t99 = load i32, i32* %t98
  %t100 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t101 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t99, 0
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t99, 1
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t99, 2
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t99, 3
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t99, 4
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %t116 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t99, 5
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %t119 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t99, 6
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %t122 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t123 = icmp eq i32 %t99, 7
  %t124 = select i1 %t123, i8* %t122, i8* %t121
  %s125 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.125, i32 0, i32 0
  %t126 = icmp eq i8* %t124, %s125
  br label %logical_and_entry_95

logical_and_entry_95:
  br i1 %t126, label %logical_and_right_95, label %logical_and_merge_95

logical_and_right_95:
  %t127 = load %Token, %Token* %l8
  %t128 = extractvalue %Token %t127, 0
  %t129 = getelementptr inbounds %TokenKind, %TokenKind* %t128, i32 0, i32 0
  %t130 = load i32, i32* %t129
  %t131 = load %Token, %Token* %l8
  %t132 = extractvalue %Token %t131, 0
  %t133 = getelementptr inbounds %TokenKind, %TokenKind* %t132, i32 0, i32 0
  %t134 = load i32, i32* %t133
  %t135 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t136 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t134, 0
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t134, 1
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t134, 2
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t134, 3
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t134, 4
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t134, 5
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t134, 6
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t134, 7
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %s160 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.160, i32 0, i32 0
  %t161 = icmp eq i8* %t159, %s160
  %t162 = load %Parser, %Parser* %l0
  %t163 = load %Parser, %Parser* %l1
  %t164 = load %Token, %Token* %l2
  %t165 = load i8*, i8** %l3
  %t166 = load double, double* %l4
  %t167 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t168 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l6
  %t169 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %l7
  %t170 = load %Token, %Token* %l8
  br i1 %t161, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t171 = load %Parser, %Parser* %l0
  store %Parser %t171, %Parser* %l9
  %t172 = load %Parser, %Parser* %l0
  %t173 = call %DecoratorParseResult @parse_decorators(%Parser %t172)
  store %DecoratorParseResult %t173, %DecoratorParseResult* %l10
  %t174 = load %DecoratorParseResult, %DecoratorParseResult* %l10
  %t175 = extractvalue %DecoratorParseResult %t174, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t176 = load %DecoratorParseResult, %DecoratorParseResult* %l10
  %t177 = extractvalue %DecoratorParseResult %t176, 1
  store { %Decorator**, i64 }* %t177, { %Decorator**, i64 }** %l11
  %t178 = load %Parser, %Parser* %l0
  %t179 = call %Parser @skip_trivia(%Parser %t178)
  store %Parser %t179, %Parser* %l0
  %t180 = load %Parser, %Parser* %l0
  %t181 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l11
  %t182 = bitcast { %Decorator**, i64 }* %t181 to { %Decorator*, i64 }*
  %t183 = call %InterfaceMemberParseResult @parse_interface_member(%Parser %t180, { %Decorator*, i64 }* %t182)
  store %InterfaceMemberParseResult %t183, %InterfaceMemberParseResult* %l12
  %t184 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l12
  %t185 = extractvalue %InterfaceMemberParseResult %t184, 2
  %t186 = load %Parser, %Parser* %l0
  %t187 = load %Parser, %Parser* %l1
  %t188 = load %Token, %Token* %l2
  %t189 = load i8*, i8** %l3
  %t190 = load double, double* %l4
  %t191 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t192 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l6
  %t193 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %l7
  %t194 = load %Token, %Token* %l8
  %t195 = load %Parser, %Parser* %l9
  %t196 = load %DecoratorParseResult, %DecoratorParseResult* %l10
  %t197 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l11
  %t198 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l12
  br i1 %t185, label %then8, label %merge9
then8:
  %t199 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l12
  %t200 = extractvalue %InterfaceMemberParseResult %t199, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t201 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l12
  %t202 = extractvalue %InterfaceMemberParseResult %t201, 1
  %t203 = bitcast i8* null to %FunctionSignature*
  br label %loop.latch4
merge9:
  %t204 = load %Parser, %Parser* %l9
  %t205 = call %Parser @skip_struct_member(%Parser %t204)
  store %Parser %t205, %Parser* %l0
  br label %loop.latch4
loop.latch4:
  %t206 = load %Parser, %Parser* %l0
  br label %loop.header2
afterloop5:
  %t208 = alloca %Statement
  %t209 = getelementptr inbounds %Statement, %Statement* %t208, i32 0, i32 0
  store i32 10, i32* %t209
  %t210 = load i8*, i8** %l3
  %t211 = getelementptr inbounds %Statement, %Statement* %t208, i32 0, i32 1
  %t212 = bitcast [40 x i8]* %t211 to i8*
  %t213 = bitcast i8* %t212 to i8**
  store i8* %t210, i8** %t213
  %t214 = load double, double* %l4
  %t215 = call noalias i8* @malloc(i64 8)
  %t216 = bitcast i8* %t215 to double*
  store double %t214, double* %t216
  %t217 = bitcast i8* %t215 to %SourceSpan*
  %t218 = getelementptr inbounds %Statement, %Statement* %t208, i32 0, i32 1
  %t219 = bitcast [40 x i8]* %t218 to i8*
  %t220 = getelementptr inbounds i8, i8* %t219, i64 8
  %t221 = bitcast i8* %t220 to %SourceSpan**
  store %SourceSpan* %t217, %SourceSpan** %t221
  %t222 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l6
  %t223 = getelementptr inbounds %Statement, %Statement* %t208, i32 0, i32 1
  %t224 = bitcast [40 x i8]* %t223 to i8*
  %t225 = getelementptr inbounds i8, i8* %t224, i64 16
  %t226 = bitcast i8* %t225 to { %TypeParameter**, i64 }**
  store { %TypeParameter**, i64 }* %t222, { %TypeParameter**, i64 }** %t226
  %t227 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %l7
  %t228 = bitcast { %FunctionSignature*, i64 }* %t227 to { %FunctionSignature**, i64 }*
  %t229 = getelementptr inbounds %Statement, %Statement* %t208, i32 0, i32 1
  %t230 = bitcast [40 x i8]* %t229 to i8*
  %t231 = getelementptr inbounds i8, i8* %t230, i64 24
  %t232 = bitcast i8* %t231 to { %FunctionSignature**, i64 }**
  store { %FunctionSignature**, i64 }* %t228, { %FunctionSignature**, i64 }** %t232
  %t233 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t234 = getelementptr inbounds %Statement, %Statement* %t208, i32 0, i32 1
  %t235 = bitcast [40 x i8]* %t234 to i8*
  %t236 = getelementptr inbounds i8, i8* %t235, i64 32
  %t237 = bitcast i8* %t236 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t233, { %Decorator**, i64 }** %t237
  %t238 = load %Statement, %Statement* %t208
  store %Statement %t238, %Statement* %l13
  %t239 = load %Parser, %Parser* %l0
  %t240 = insertvalue %StatementParseResult undef, %Parser* null, 0
  %t241 = load %Statement, %Statement* %l13
  %t242 = insertvalue %StatementParseResult %t240, %Statement* null, 1
  ret %StatementParseResult %t242
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
  %t12 = getelementptr inbounds %TokenKind, %TokenKind* %t11, i32 0, i32 0
  %t13 = load i32, i32* %t12
  %t14 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t15 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t16 = icmp eq i32 %t13, 0
  %t17 = select i1 %t16, i8* %t15, i8* %t14
  %t18 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t19 = icmp eq i32 %t13, 1
  %t20 = select i1 %t19, i8* %t18, i8* %t17
  %t21 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t22 = icmp eq i32 %t13, 2
  %t23 = select i1 %t22, i8* %t21, i8* %t20
  %t24 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t13, 3
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %t27 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t28 = icmp eq i32 %t13, 4
  %t29 = select i1 %t28, i8* %t27, i8* %t26
  %t30 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t31 = icmp eq i32 %t13, 5
  %t32 = select i1 %t31, i8* %t30, i8* %t29
  %t33 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t34 = icmp eq i32 %t13, 6
  %t35 = select i1 %t34, i8* %t33, i8* %t32
  %t36 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t37 = icmp eq i32 %t13, 7
  %t38 = select i1 %t37, i8* %t36, i8* %t35
  %s39 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.39, i32 0, i32 0
  %t40 = icmp ne i8* %t38, %s39
  %t41 = load %Parser, %Parser* %l0
  %t42 = load %Parser, %Parser* %l1
  %t43 = load %Token, %Token* %l2
  br i1 %t40, label %then0, label %merge1
then0:
  %t44 = load %Parser, %Parser* %l1
  %t45 = call %StatementParseResult @parse_unknown(%Parser %t44)
  ret %StatementParseResult %t45
merge1:
  %t46 = load %Token, %Token* %l2
  %t47 = call i8* @identifier_text(%Token %t46)
  store i8* %t47, i8** %l3
  %t48 = load %Token, %Token* %l2
  %t49 = alloca [1 x %Token]
  %t50 = getelementptr [1 x %Token], [1 x %Token]* %t49, i32 0, i32 0
  %t51 = getelementptr %Token, %Token* %t50, i64 0
  store %Token %t48, %Token* %t51
  %t52 = alloca { %Token*, i64 }
  %t53 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t52, i32 0, i32 0
  store %Token* %t50, %Token** %t53
  %t54 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t52, i32 0, i32 1
  store i64 1, i64* %t54
  %t55 = call double @source_span_from_tokens({ %Token*, i64 }* %t52)
  store double %t55, double* %l4
  %t56 = load %Parser, %Parser* %l0
  %t57 = call %Parser @parser_advance_raw(%Parser %t56)
  store %Parser %t57, %Parser* %l0
  %t58 = load %Parser, %Parser* %l0
  %t59 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %t58)
  store %TypeParameterParseResult %t59, %TypeParameterParseResult* %l5
  %t60 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t61 = extractvalue %TypeParameterParseResult %t60, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t62 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t63 = extractvalue %TypeParameterParseResult %t62, 1
  store { %TypeParameter**, i64 }* %t63, { %TypeParameter**, i64 }** %l6
  %t64 = load %Parser, %Parser* %l0
  %t65 = call %Parser @skip_trivia(%Parser %t64)
  store %Parser %t65, %Parser* %l0
  %t66 = load %Parser, %Parser* %l0
  %t67 = alloca [2 x i8], align 1
  %t68 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 0
  store i8 123, i8* %t68
  %t69 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 1
  store i8 0, i8* %t69
  %t70 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 0
  %t71 = call %Parser @advance_to_symbol(%Parser %t66, i8* %t70)
  store %Parser %t71, %Parser* %l0
  %t72 = load %Parser, %Parser* %l0
  %t73 = alloca [2 x i8], align 1
  %t74 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 0
  store i8 123, i8* %t74
  %t75 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 1
  store i8 0, i8* %t75
  %t76 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 0
  %t77 = call %Parser @consume_symbol(%Parser %t72, i8* %t76)
  store %Parser %t77, %Parser* %l0
  %t78 = alloca [0 x %EnumVariant]
  %t79 = getelementptr [0 x %EnumVariant], [0 x %EnumVariant]* %t78, i32 0, i32 0
  %t80 = alloca { %EnumVariant*, i64 }
  %t81 = getelementptr { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %t80, i32 0, i32 0
  store %EnumVariant* %t79, %EnumVariant** %t81
  %t82 = getelementptr { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %t80, i32 0, i32 1
  store i64 0, i64* %t82
  store { %EnumVariant*, i64 }* %t80, { %EnumVariant*, i64 }** %l7
  %t83 = load %Parser, %Parser* %l0
  %t84 = load %Parser, %Parser* %l1
  %t85 = load %Token, %Token* %l2
  %t86 = load i8*, i8** %l3
  %t87 = load double, double* %l4
  %t88 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t89 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l6
  %t90 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %l7
  br label %loop.header2
loop.header2:
  %t195 = phi %Parser [ %t83, %entry ], [ %t194, %loop.latch4 ]
  store %Parser %t195, %Parser* %l0
  br label %loop.body3
loop.body3:
  %t91 = load %Parser, %Parser* %l0
  %t92 = call %Parser @skip_trivia(%Parser %t91)
  store %Parser %t92, %Parser* %l0
  %t93 = load %Parser, %Parser* %l0
  %t94 = call %Token @parser_peek_raw(%Parser %t93)
  store %Token %t94, %Token* %l8
  %t96 = load %Token, %Token* %l8
  %t97 = extractvalue %Token %t96, 0
  %t98 = getelementptr inbounds %TokenKind, %TokenKind* %t97, i32 0, i32 0
  %t99 = load i32, i32* %t98
  %t100 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t101 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t99, 0
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t99, 1
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t99, 2
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t99, 3
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t99, 4
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %t116 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t99, 5
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %t119 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t99, 6
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %t122 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t123 = icmp eq i32 %t99, 7
  %t124 = select i1 %t123, i8* %t122, i8* %t121
  %s125 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.125, i32 0, i32 0
  %t126 = icmp eq i8* %t124, %s125
  br label %logical_and_entry_95

logical_and_entry_95:
  br i1 %t126, label %logical_and_right_95, label %logical_and_merge_95

logical_and_right_95:
  %t127 = load %Token, %Token* %l8
  %t128 = extractvalue %Token %t127, 0
  %t129 = getelementptr inbounds %TokenKind, %TokenKind* %t128, i32 0, i32 0
  %t130 = load i32, i32* %t129
  %t131 = load %Token, %Token* %l8
  %t132 = extractvalue %Token %t131, 0
  %t133 = getelementptr inbounds %TokenKind, %TokenKind* %t132, i32 0, i32 0
  %t134 = load i32, i32* %t133
  %t135 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t136 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t134, 0
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t134, 1
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t134, 2
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t134, 3
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t134, 4
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t134, 5
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t134, 6
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t134, 7
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %s160 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.160, i32 0, i32 0
  %t161 = icmp eq i8* %t159, %s160
  %t162 = load %Parser, %Parser* %l0
  %t163 = load %Parser, %Parser* %l1
  %t164 = load %Token, %Token* %l2
  %t165 = load i8*, i8** %l3
  %t166 = load double, double* %l4
  %t167 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t168 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l6
  %t169 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %l7
  %t170 = load %Token, %Token* %l8
  br i1 %t161, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t171 = load %Parser, %Parser* %l0
  %t172 = call %EnumVariantParseResult @parse_enum_variant(%Parser %t171)
  store %EnumVariantParseResult %t172, %EnumVariantParseResult* %l9
  %t173 = load %EnumVariantParseResult, %EnumVariantParseResult* %l9
  %t174 = extractvalue %EnumVariantParseResult %t173, 2
  %t175 = load %Parser, %Parser* %l0
  %t176 = load %Parser, %Parser* %l1
  %t177 = load %Token, %Token* %l2
  %t178 = load i8*, i8** %l3
  %t179 = load double, double* %l4
  %t180 = load %TypeParameterParseResult, %TypeParameterParseResult* %l5
  %t181 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l6
  %t182 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %l7
  %t183 = load %Token, %Token* %l8
  %t184 = load %EnumVariantParseResult, %EnumVariantParseResult* %l9
  br i1 %t174, label %then8, label %merge9
then8:
  %t185 = load %EnumVariantParseResult, %EnumVariantParseResult* %l9
  %t186 = extractvalue %EnumVariantParseResult %t185, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t187 = load %EnumVariantParseResult, %EnumVariantParseResult* %l9
  %t188 = extractvalue %EnumVariantParseResult %t187, 1
  %t189 = bitcast i8* null to %EnumVariant*
  %t190 = load %Parser, %Parser* %l0
  %t191 = call %Parser @skip_trailing_comma(%Parser %t190)
  store %Parser %t191, %Parser* %l0
  br label %loop.latch4
merge9:
  %t192 = load %Parser, %Parser* %l0
  %t193 = call %Parser @skip_struct_member(%Parser %t192)
  store %Parser %t193, %Parser* %l0
  br label %loop.latch4
loop.latch4:
  %t194 = load %Parser, %Parser* %l0
  br label %loop.header2
afterloop5:
  %t196 = alloca %Statement
  %t197 = getelementptr inbounds %Statement, %Statement* %t196, i32 0, i32 0
  store i32 11, i32* %t197
  %t198 = load i8*, i8** %l3
  %t199 = getelementptr inbounds %Statement, %Statement* %t196, i32 0, i32 1
  %t200 = bitcast [40 x i8]* %t199 to i8*
  %t201 = bitcast i8* %t200 to i8**
  store i8* %t198, i8** %t201
  %t202 = load double, double* %l4
  %t203 = call noalias i8* @malloc(i64 8)
  %t204 = bitcast i8* %t203 to double*
  store double %t202, double* %t204
  %t205 = bitcast i8* %t203 to %SourceSpan*
  %t206 = getelementptr inbounds %Statement, %Statement* %t196, i32 0, i32 1
  %t207 = bitcast [40 x i8]* %t206 to i8*
  %t208 = getelementptr inbounds i8, i8* %t207, i64 8
  %t209 = bitcast i8* %t208 to %SourceSpan**
  store %SourceSpan* %t205, %SourceSpan** %t209
  %t210 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l6
  %t211 = getelementptr inbounds %Statement, %Statement* %t196, i32 0, i32 1
  %t212 = bitcast [40 x i8]* %t211 to i8*
  %t213 = getelementptr inbounds i8, i8* %t212, i64 16
  %t214 = bitcast i8* %t213 to { %TypeParameter**, i64 }**
  store { %TypeParameter**, i64 }* %t210, { %TypeParameter**, i64 }** %t214
  %t215 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %l7
  %t216 = bitcast { %EnumVariant*, i64 }* %t215 to { %EnumVariant**, i64 }*
  %t217 = getelementptr inbounds %Statement, %Statement* %t196, i32 0, i32 1
  %t218 = bitcast [40 x i8]* %t217 to i8*
  %t219 = getelementptr inbounds i8, i8* %t218, i64 24
  %t220 = bitcast i8* %t219 to { %EnumVariant**, i64 }**
  store { %EnumVariant**, i64 }* %t216, { %EnumVariant**, i64 }** %t220
  %t221 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t222 = getelementptr inbounds %Statement, %Statement* %t196, i32 0, i32 1
  %t223 = bitcast [40 x i8]* %t222 to i8*
  %t224 = getelementptr inbounds i8, i8* %t223, i64 32
  %t225 = bitcast i8* %t224 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t221, { %Decorator**, i64 }** %t225
  %t226 = load %Statement, %Statement* %t196
  store %Statement %t226, %Statement* %l10
  %t227 = load %Parser, %Parser* %l0
  %t228 = insertvalue %StatementParseResult undef, %Parser* null, 0
  %t229 = load %Statement, %Statement* %l10
  %t230 = insertvalue %StatementParseResult %t228, %Statement* null, 1
  ret %StatementParseResult %t230
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
  %t41 = insertvalue %InterfaceMemberParseResult undef, %Parser* null, 0
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
  %t54 = getelementptr inbounds %TokenKind, %TokenKind* %t53, i32 0, i32 0
  %t55 = load i32, i32* %t54
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
  %t84 = load %Parser, %Parser* %l1
  %t85 = load i1, i1* %l2
  %t86 = load %Token, %Token* %l3
  %t87 = load %Token, %Token* %l5
  br i1 %t82, label %then6, label %merge7
then6:
  %t88 = load %Parser, %Parser* %l0
  %t89 = insertvalue %InterfaceMemberParseResult undef, %Parser* null, 0
  %t90 = bitcast i8* null to %FunctionSignature*
  %t91 = insertvalue %InterfaceMemberParseResult %t89, %FunctionSignature* %t90, 1
  %t92 = insertvalue %InterfaceMemberParseResult %t91, i1 0, 2
  ret %InterfaceMemberParseResult %t92
merge7:
  %t93 = load %Token, %Token* %l5
  %t94 = call i8* @identifier_text(%Token %t93)
  store i8* %t94, i8** %l6
  %t95 = load %Token, %Token* %l5
  %t96 = alloca [1 x %Token]
  %t97 = getelementptr [1 x %Token], [1 x %Token]* %t96, i32 0, i32 0
  %t98 = getelementptr %Token, %Token* %t97, i64 0
  store %Token %t95, %Token* %t98
  %t99 = alloca { %Token*, i64 }
  %t100 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t99, i32 0, i32 0
  store %Token* %t97, %Token** %t100
  %t101 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t99, i32 0, i32 1
  store i64 1, i64* %t101
  %t102 = call double @source_span_from_tokens({ %Token*, i64 }* %t99)
  store double %t102, double* %l7
  %t103 = load %Parser, %Parser* %l1
  %t104 = call %Parser @parser_advance_raw(%Parser %t103)
  store %Parser %t104, %Parser* %l1
  %t105 = load %Parser, %Parser* %l1
  %t106 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %t105)
  store %TypeParameterParseResult %t106, %TypeParameterParseResult* %l8
  %t107 = load %TypeParameterParseResult, %TypeParameterParseResult* %l8
  %t108 = extractvalue %TypeParameterParseResult %t107, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t109 = load %TypeParameterParseResult, %TypeParameterParseResult* %l8
  %t110 = extractvalue %TypeParameterParseResult %t109, 1
  store { %TypeParameter**, i64 }* %t110, { %TypeParameter**, i64 }** %l9
  %t111 = load %Parser, %Parser* %l1
  %t112 = call %Parser @skip_trivia(%Parser %t111)
  store %Parser %t112, %Parser* %l1
  %t113 = load %Parser, %Parser* %l1
  %t114 = alloca [2 x i8], align 1
  %t115 = getelementptr [2 x i8], [2 x i8]* %t114, i32 0, i32 0
  store i8 40, i8* %t115
  %t116 = getelementptr [2 x i8], [2 x i8]* %t114, i32 0, i32 1
  store i8 0, i8* %t116
  %t117 = getelementptr [2 x i8], [2 x i8]* %t114, i32 0, i32 0
  %t118 = call %Parser @consume_symbol(%Parser %t113, i8* %t117)
  store %Parser %t118, %Parser* %l1
  %t119 = load %Parser, %Parser* %l1
  %t120 = call %ParameterListParseResult @parse_parameter_list(%Parser %t119)
  store %ParameterListParseResult %t120, %ParameterListParseResult* %l10
  %t121 = load %ParameterListParseResult, %ParameterListParseResult* %l10
  %t122 = extractvalue %ParameterListParseResult %t121, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t123 = load %ParameterListParseResult, %ParameterListParseResult* %l10
  %t124 = extractvalue %ParameterListParseResult %t123, 1
  store { %Parameter**, i64 }* %t124, { %Parameter**, i64 }** %l11
  %t125 = load %Parser, %Parser* %l1
  %t126 = call %Parser @skip_trivia(%Parser %t125)
  store %Parser %t126, %Parser* %l1
  store i8* null, i8** %l12
  %t127 = load %Parser, %Parser* %l1
  %t128 = call %Token @parser_peek_raw(%Parser %t127)
  store %Token %t128, %Token* %l13
  %t131 = load %Token, %Token* %l13
  %t132 = extractvalue %Token %t131, 0
  %t133 = getelementptr inbounds %TokenKind, %TokenKind* %t132, i32 0, i32 0
  %t134 = load i32, i32* %t133
  %t135 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t136 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t134, 0
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t134, 1
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t134, 2
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t134, 3
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t134, 4
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t134, 5
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t134, 6
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t134, 7
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %s160 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.160, i32 0, i32 0
  %t161 = icmp eq i8* %t159, %s160
  br label %logical_and_entry_130

logical_and_entry_130:
  br i1 %t161, label %logical_and_right_130, label %logical_and_merge_130

logical_and_right_130:
  %t162 = load %Token, %Token* %l13
  %t163 = extractvalue %Token %t162, 0
  %t164 = getelementptr inbounds %TokenKind, %TokenKind* %t163, i32 0, i32 0
  %t165 = load i32, i32* %t164
  %t166 = load %Parser, %Parser* %l1
  %t167 = call %EffectParseResult @parse_effect_list(%Parser %t166)
  store %EffectParseResult %t167, %EffectParseResult* %l14
  %t168 = load %EffectParseResult, %EffectParseResult* %l14
  %t169 = extractvalue %EffectParseResult %t168, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t170 = load %EffectParseResult, %EffectParseResult* %l14
  %t171 = extractvalue %EffectParseResult %t170, 1
  store { i8**, i64 }* %t171, { i8**, i64 }** %l15
  %t172 = call double @evaluate_decorators({ %Decorator*, i64 }* %decorators)
  store double %t172, double* %l16
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t174 = load double, double* %l16
  %t175 = call double @infer_effects({ i8**, i64 }* %t173, double %t174)
  store double %t175, double* %l17
  %t176 = load %Parser, %Parser* %l1
  %t177 = call %Parser @skip_trivia(%Parser %t176)
  store %Parser %t177, %Parser* %l1
  %t178 = load %Parser, %Parser* %l1
  %t179 = extractvalue %Parser %t178, 1
  %t180 = load %Parser, %Parser* %l1
  %t181 = extractvalue %Parser %t180, 0
  %t182 = load { %Token**, i64 }, { %Token**, i64 }* %t181
  %t183 = extractvalue { %Token**, i64 } %t182, 1
  %t184 = sitofp i64 %t183 to double
  %t185 = fcmp olt double %t179, %t184
  %t186 = load %Parser, %Parser* %l0
  %t187 = load %Parser, %Parser* %l1
  %t188 = load i1, i1* %l2
  %t189 = load %Token, %Token* %l3
  %t190 = load %Token, %Token* %l5
  %t191 = load i8*, i8** %l6
  %t192 = load double, double* %l7
  %t193 = load %TypeParameterParseResult, %TypeParameterParseResult* %l8
  %t194 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l9
  %t195 = load %ParameterListParseResult, %ParameterListParseResult* %l10
  %t196 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %l11
  %t197 = load i8*, i8** %l12
  %t198 = load %Token, %Token* %l13
  %t199 = load %EffectParseResult, %EffectParseResult* %l14
  %t200 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t201 = load double, double* %l16
  %t202 = load double, double* %l17
  br i1 %t185, label %then8, label %merge9
then8:
  %t203 = load %Parser, %Parser* %l1
  %t204 = call %Token @parser_peek_raw(%Parser %t203)
  store %Token %t204, %Token* %l18
  %t206 = load %Token, %Token* %l18
  %t207 = extractvalue %Token %t206, 0
  %t208 = getelementptr inbounds %TokenKind, %TokenKind* %t207, i32 0, i32 0
  %t209 = load i32, i32* %t208
  %t210 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t211 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t212 = icmp eq i32 %t209, 0
  %t213 = select i1 %t212, i8* %t211, i8* %t210
  %t214 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t215 = icmp eq i32 %t209, 1
  %t216 = select i1 %t215, i8* %t214, i8* %t213
  %t217 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t218 = icmp eq i32 %t209, 2
  %t219 = select i1 %t218, i8* %t217, i8* %t216
  %t220 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t221 = icmp eq i32 %t209, 3
  %t222 = select i1 %t221, i8* %t220, i8* %t219
  %t223 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t224 = icmp eq i32 %t209, 4
  %t225 = select i1 %t224, i8* %t223, i8* %t222
  %t226 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t227 = icmp eq i32 %t209, 5
  %t228 = select i1 %t227, i8* %t226, i8* %t225
  %t229 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t230 = icmp eq i32 %t209, 6
  %t231 = select i1 %t230, i8* %t229, i8* %t228
  %t232 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t233 = icmp eq i32 %t209, 7
  %t234 = select i1 %t233, i8* %t232, i8* %t231
  %s235 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.235, i32 0, i32 0
  %t236 = icmp eq i8* %t234, %s235
  br label %logical_and_entry_205

logical_and_entry_205:
  br i1 %t236, label %logical_and_right_205, label %logical_and_merge_205

logical_and_right_205:
  %t237 = load %Token, %Token* %l18
  %t238 = extractvalue %Token %t237, 0
  %t239 = getelementptr inbounds %TokenKind, %TokenKind* %t238, i32 0, i32 0
  %t240 = load i32, i32* %t239
  br label %merge9
merge9:
  %t241 = load i8*, i8** %l6
  %t242 = insertvalue %FunctionSignature undef, i8* %t241, 0
  %t243 = load i1, i1* %l2
  %t244 = insertvalue %FunctionSignature %t242, i1 %t243, 1
  %t245 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %l11
  %t246 = insertvalue %FunctionSignature %t244, { %Parameter**, i64 }* %t245, 2
  %t247 = load i8*, i8** %l12
  %t248 = bitcast i8* %t247 to %TypeAnnotation*
  %t249 = insertvalue %FunctionSignature %t246, %TypeAnnotation* %t248, 3
  %t250 = load double, double* %l17
  %t251 = insertvalue %FunctionSignature %t249, { i8**, i64 }* null, 4
  %t252 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l9
  %t253 = insertvalue %FunctionSignature %t251, { %TypeParameter**, i64 }* %t252, 5
  %t254 = load double, double* %l7
  %t255 = insertvalue %FunctionSignature %t253, %SourceSpan* null, 6
  store %FunctionSignature %t255, %FunctionSignature* %l19
  %t256 = load %Parser, %Parser* %l1
  %t257 = insertvalue %InterfaceMemberParseResult undef, %Parser* null, 0
  %t258 = load %FunctionSignature, %FunctionSignature* %l19
  %t259 = insertvalue %InterfaceMemberParseResult %t257, %FunctionSignature* null, 1
  %t260 = insertvalue %InterfaceMemberParseResult %t259, i1 1, 2
  ret %InterfaceMemberParseResult %t260
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
  %t5 = getelementptr inbounds %TokenKind, %TokenKind* %t4, i32 0, i32 0
  %t6 = load i32, i32* %t5
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
  %s32 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.32, i32 0, i32 0
  %t33 = icmp ne i8* %t31, %s32
  %t34 = load %Parser, %Parser* %l0
  %t35 = load %Parser, %Parser* %l1
  %t36 = load %Token, %Token* %l2
  br i1 %t33, label %then0, label %merge1
then0:
  %t37 = load %Parser, %Parser* %l0
  %t38 = insertvalue %EnumVariantParseResult undef, %Parser* null, 0
  %t39 = bitcast i8* null to %EnumVariant*
  %t40 = insertvalue %EnumVariantParseResult %t38, %EnumVariant* %t39, 1
  %t41 = insertvalue %EnumVariantParseResult %t40, i1 0, 2
  ret %EnumVariantParseResult %t41
merge1:
  %t42 = load %Token, %Token* %l2
  %t43 = call i8* @identifier_text(%Token %t42)
  store i8* %t43, i8** %l3
  %t44 = load %Token, %Token* %l2
  %t45 = alloca [1 x %Token]
  %t46 = getelementptr [1 x %Token], [1 x %Token]* %t45, i32 0, i32 0
  %t47 = getelementptr %Token, %Token* %t46, i64 0
  store %Token %t44, %Token* %t47
  %t48 = alloca { %Token*, i64 }
  %t49 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t48, i32 0, i32 0
  store %Token* %t46, %Token** %t49
  %t50 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t48, i32 0, i32 1
  store i64 1, i64* %t50
  %t51 = call double @source_span_from_tokens({ %Token*, i64 }* %t48)
  store double %t51, double* %l4
  %t52 = load %Parser, %Parser* %l1
  %t53 = call %Parser @parser_advance_raw(%Parser %t52)
  store %Parser %t53, %Parser* %l1
  %t54 = alloca [0 x %FieldDeclaration]
  %t55 = getelementptr [0 x %FieldDeclaration], [0 x %FieldDeclaration]* %t54, i32 0, i32 0
  %t56 = alloca { %FieldDeclaration*, i64 }
  %t57 = getelementptr { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %t56, i32 0, i32 0
  store %FieldDeclaration* %t55, %FieldDeclaration** %t57
  %t58 = getelementptr { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %t56, i32 0, i32 1
  store i64 0, i64* %t58
  store { %FieldDeclaration*, i64 }* %t56, { %FieldDeclaration*, i64 }** %l5
  %t59 = load %Parser, %Parser* %l1
  %t60 = call %Parser @skip_trivia(%Parser %t59)
  store %Parser %t60, %Parser* %l1
  %t61 = load %Parser, %Parser* %l1
  %t62 = call %Token @parser_peek_raw(%Parser %t61)
  store %Token %t62, %Token* %l6
  %t64 = load %Token, %Token* %l6
  %t65 = extractvalue %Token %t64, 0
  %t66 = getelementptr inbounds %TokenKind, %TokenKind* %t65, i32 0, i32 0
  %t67 = load i32, i32* %t66
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
  %s93 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.93, i32 0, i32 0
  %t94 = icmp eq i8* %t92, %s93
  br label %logical_and_entry_63

logical_and_entry_63:
  br i1 %t94, label %logical_and_right_63, label %logical_and_merge_63

logical_and_right_63:
  %t95 = load %Token, %Token* %l6
  %t96 = extractvalue %Token %t95, 0
  %t97 = getelementptr inbounds %TokenKind, %TokenKind* %t96, i32 0, i32 0
  %t98 = load i32, i32* %t97
  %t99 = load %Parser, %Parser* %l1
  %t100 = call %Parser @skip_trivia(%Parser %t99)
  store %Parser %t100, %Parser* %l1
  %t101 = load %Parser, %Parser* %l1
  %t102 = call %Token @parser_peek_raw(%Parser %t101)
  store %Token %t102, %Token* %l7
  %t104 = load %Token, %Token* %l7
  %t105 = extractvalue %Token %t104, 0
  %t106 = getelementptr inbounds %TokenKind, %TokenKind* %t105, i32 0, i32 0
  %t107 = load i32, i32* %t106
  %t108 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t109 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t110 = icmp eq i32 %t107, 0
  %t111 = select i1 %t110, i8* %t109, i8* %t108
  %t112 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t113 = icmp eq i32 %t107, 1
  %t114 = select i1 %t113, i8* %t112, i8* %t111
  %t115 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t116 = icmp eq i32 %t107, 2
  %t117 = select i1 %t116, i8* %t115, i8* %t114
  %t118 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t119 = icmp eq i32 %t107, 3
  %t120 = select i1 %t119, i8* %t118, i8* %t117
  %t121 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t122 = icmp eq i32 %t107, 4
  %t123 = select i1 %t122, i8* %t121, i8* %t120
  %t124 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t125 = icmp eq i32 %t107, 5
  %t126 = select i1 %t125, i8* %t124, i8* %t123
  %t127 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t128 = icmp eq i32 %t107, 6
  %t129 = select i1 %t128, i8* %t127, i8* %t126
  %t130 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t131 = icmp eq i32 %t107, 7
  %t132 = select i1 %t131, i8* %t130, i8* %t129
  %s133 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.133, i32 0, i32 0
  %t134 = icmp eq i8* %t132, %s133
  br label %logical_and_entry_103

logical_and_entry_103:
  br i1 %t134, label %logical_and_right_103, label %logical_and_merge_103

logical_and_right_103:
  %t135 = load %Token, %Token* %l7
  %t136 = extractvalue %Token %t135, 0
  %t137 = getelementptr inbounds %TokenKind, %TokenKind* %t136, i32 0, i32 0
  %t138 = load i32, i32* %t137
  %t139 = load i8*, i8** %l3
  %t140 = insertvalue %EnumVariant undef, i8* %t139, 0
  %t141 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l5
  %t142 = bitcast { %FieldDeclaration*, i64 }* %t141 to { %FieldDeclaration**, i64 }*
  %t143 = insertvalue %EnumVariant %t140, { %FieldDeclaration**, i64 }* %t142, 1
  %t144 = load double, double* %l4
  %t145 = insertvalue %EnumVariant %t143, %SourceSpan* null, 2
  store %EnumVariant %t145, %EnumVariant* %l8
  %t146 = load %Parser, %Parser* %l1
  %t147 = insertvalue %EnumVariantParseResult undef, %Parser* null, 0
  %t148 = load %EnumVariant, %EnumVariant* %l8
  %t149 = insertvalue %EnumVariantParseResult %t147, %EnumVariant* null, 1
  %t150 = insertvalue %EnumVariantParseResult %t149, i1 1, 2
  ret %EnumVariantParseResult %t150
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
  %t23 = getelementptr inbounds %TokenKind, %TokenKind* %t22, i32 0, i32 0
  %t24 = load i32, i32* %t23
  %t25 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t26 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t24, 0
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t24, 1
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t24, 2
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t24, 3
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t24, 4
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t24, 5
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t24, 6
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t24, 7
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %s50 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.50, i32 0, i32 0
  %t51 = icmp ne i8* %t49, %s50
  %t52 = load %Parser, %Parser* %l0
  %t53 = load i1, i1* %l1
  %t54 = load %Token, %Token* %l2
  %t55 = load %Token, %Token* %l3
  br i1 %t51, label %then2, label %merge3
then2:
  %t56 = insertvalue %StructFieldParseResult undef, %Parser* null, 0
  %t57 = bitcast i8* null to %FieldDeclaration*
  %t58 = insertvalue %StructFieldParseResult %t56, %FieldDeclaration* %t57, 1
  %t59 = insertvalue %StructFieldParseResult %t58, i1 0, 2
  ret %StructFieldParseResult %t59
merge3:
  %t60 = load %Token, %Token* %l3
  %t61 = call i8* @identifier_text(%Token %t60)
  store i8* %t61, i8** %l4
  %t62 = load %Token, %Token* %l3
  %t63 = alloca [1 x %Token]
  %t64 = getelementptr [1 x %Token], [1 x %Token]* %t63, i32 0, i32 0
  %t65 = getelementptr %Token, %Token* %t64, i64 0
  store %Token %t62, %Token* %t65
  %t66 = alloca { %Token*, i64 }
  %t67 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t66, i32 0, i32 0
  store %Token* %t64, %Token** %t67
  %t68 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t66, i32 0, i32 1
  store i64 1, i64* %t68
  %t69 = call double @source_span_from_tokens({ %Token*, i64 }* %t66)
  store double %t69, double* %l5
  %t70 = load %Parser, %Parser* %l0
  %t71 = call %Parser @parser_advance_raw(%Parser %t70)
  store %Parser %t71, %Parser* %l0
  %t72 = load %Parser, %Parser* %l0
  %t73 = call %Parser @skip_trivia(%Parser %t72)
  store %Parser %t73, %Parser* %l0
  %t74 = load %Parser, %Parser* %l0
  %t75 = call %Token @parser_peek_raw(%Parser %t74)
  store %Token %t75, %Token* %l6
  %t76 = load %Token, %Token* %l6
  %t77 = extractvalue %Token %t76, 0
  %t78 = getelementptr inbounds %TokenKind, %TokenKind* %t77, i32 0, i32 0
  %t79 = load i32, i32* %t78
  %t80 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t81 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t79, 0
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t79, 1
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %t87 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t88 = icmp eq i32 %t79, 2
  %t89 = select i1 %t88, i8* %t87, i8* %t86
  %t90 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t91 = icmp eq i32 %t79, 3
  %t92 = select i1 %t91, i8* %t90, i8* %t89
  %t93 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t79, 4
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %t96 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t97 = icmp eq i32 %t79, 5
  %t98 = select i1 %t97, i8* %t96, i8* %t95
  %t99 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t79, 6
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t79, 7
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %s105 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.105, i32 0, i32 0
  %t106 = icmp eq i8* %t104, %s105
  store i1 %t106, i1* %l7
  %t107 = load i1, i1* %l7
  %t108 = xor i1 %t107, 1
  %t109 = load %Parser, %Parser* %l0
  %t110 = load i1, i1* %l1
  %t111 = load %Token, %Token* %l2
  %t112 = load %Token, %Token* %l3
  %t113 = load i8*, i8** %l4
  %t114 = load double, double* %l5
  %t115 = load %Token, %Token* %l6
  %t116 = load i1, i1* %l7
  br i1 %t108, label %then4, label %merge5
then4:
  %t117 = insertvalue %StructFieldParseResult undef, %Parser* null, 0
  %t118 = bitcast i8* null to %FieldDeclaration*
  %t119 = insertvalue %StructFieldParseResult %t117, %FieldDeclaration* %t118, 1
  %t120 = insertvalue %StructFieldParseResult %t119, i1 0, 2
  ret %StructFieldParseResult %t120
merge5:
  %t121 = load %Parser, %Parser* %l0
  %t122 = call %Parser @parser_advance_raw(%Parser %t121)
  store %Parser %t122, %Parser* %l0
  %t123 = load %Parser, %Parser* %l0
  %t124 = call %Parser @skip_trivia(%Parser %t123)
  store double 0.0, double* %l8
  %t125 = load double, double* %l8
  %t126 = load double, double* %l8
  store double 0.0, double* %l9
  %t127 = load %Parser, %Parser* %l0
  %t128 = load i1, i1* %l1
  %t129 = load %Token, %Token* %l2
  %t130 = load %Token, %Token* %l3
  %t131 = load i8*, i8** %l4
  %t132 = load double, double* %l5
  %t133 = load %Token, %Token* %l6
  %t134 = load i1, i1* %l7
  %t135 = load double, double* %l8
  %t136 = load double, double* %l9
  br label %loop.header6
loop.header6:
  %t146 = phi double [ %t136, %entry ], [ %t145, %loop.latch8 ]
  store double %t146, double* %l9
  br label %loop.body7
loop.body7:
  %t137 = load double, double* %l9
  %t138 = load double, double* %l9
  %t139 = load double, double* %l9
  store double 0.0, double* %l10
  %t140 = load double, double* %l10
  %t141 = load double, double* %l9
  %t142 = load double, double* %l9
  store double 0.0, double* %l11
  %t143 = load double, double* %l11
  %t144 = call i8* @trim_text(i8* null)
  store double 0.0, double* %l9
  br label %loop.latch8
loop.latch8:
  %t145 = load double, double* %l9
  br label %loop.header6
afterloop9:
  %t147 = load double, double* %l9
  %t148 = load %Parser, %Parser* %l0
  %t149 = call %Parser @skip_trivia(%Parser %t148)
  store %Parser %t149, %Parser* %l0
  %t150 = load %Parser, %Parser* %l0
  %t151 = call %Token @parser_peek_raw(%Parser %t150)
  store %Token %t151, %Token* %l12
  %t152 = load %Token, %Token* %l12
  %t153 = extractvalue %Token %t152, 0
  %t154 = getelementptr inbounds %TokenKind, %TokenKind* %t153, i32 0, i32 0
  %t155 = load i32, i32* %t154
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
  %t183 = load %Parser, %Parser* %l0
  %t184 = load i1, i1* %l1
  %t185 = load %Token, %Token* %l2
  %t186 = load %Token, %Token* %l3
  %t187 = load i8*, i8** %l4
  %t188 = load double, double* %l5
  %t189 = load %Token, %Token* %l6
  %t190 = load i1, i1* %l7
  %t191 = load double, double* %l8
  %t192 = load double, double* %l9
  %t193 = load %Token, %Token* %l12
  br i1 %t182, label %then10, label %merge11
then10:
  %t194 = load %Token, %Token* %l12
  %t195 = extractvalue %Token %t194, 0
  %t196 = getelementptr inbounds %TokenKind, %TokenKind* %t195, i32 0, i32 0
  %t197 = load i32, i32* %t196
  br label %merge11
merge11:
  %t198 = load i8*, i8** %l4
  %t199 = insertvalue %FieldDeclaration undef, i8* %t198, 0
  %t200 = load double, double* %l9
  %t201 = insertvalue %TypeAnnotation undef, i8* null, 0
  %t202 = insertvalue %FieldDeclaration %t199, %TypeAnnotation* null, 1
  %t203 = load i1, i1* %l1
  %t204 = insertvalue %FieldDeclaration %t202, i1 %t203, 2
  %t205 = load double, double* %l5
  %t206 = insertvalue %FieldDeclaration %t204, %SourceSpan* null, 3
  store %FieldDeclaration %t206, %FieldDeclaration* %l13
  %t207 = load %Parser, %Parser* %l0
  %t208 = insertvalue %StructFieldParseResult undef, %Parser* null, 0
  %t209 = load %FieldDeclaration, %FieldDeclaration* %l13
  %t210 = insertvalue %StructFieldParseResult %t208, %FieldDeclaration* null, 1
  %t211 = insertvalue %StructFieldParseResult %t210, i1 1, 2
  ret %StructFieldParseResult %t211
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
  %t6 = getelementptr inbounds %TokenKind, %TokenKind* %t5, i32 0, i32 0
  %t7 = load i32, i32* %t6
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
  br label %logical_and_entry_3

logical_and_entry_3:
  br i1 %t34, label %logical_and_right_3, label %logical_and_merge_3

logical_and_right_3:
  %t35 = load %Token, %Token* %l1
  %t36 = extractvalue %Token %t35, 0
  %t37 = getelementptr inbounds %TokenKind, %TokenKind* %t36, i32 0, i32 0
  %t38 = load i32, i32* %t37
  %t39 = load %Parser, %Parser* %l0
  ret %Parser %t39
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
  store %Parser zeroinitializer, %Parser* %l0
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
  store %Parser zeroinitializer, %Parser* %l0
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
  %t285 = phi %Parser [ %t93, %entry ], [ %t284, %loop.latch4 ]
  store %Parser %t285, %Parser* %l0
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
  %t111 = getelementptr inbounds %TokenKind, %TokenKind* %t110, i32 0, i32 0
  %t112 = load i32, i32* %t111
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
  %s138 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.138, i32 0, i32 0
  %t139 = icmp eq i8* %t137, %s138
  br label %logical_and_entry_108

logical_and_entry_108:
  br i1 %t139, label %logical_and_right_108, label %logical_and_merge_108

logical_and_right_108:
  %t140 = load %Token, %Token* %l11
  %t141 = extractvalue %Token %t140, 0
  %t142 = getelementptr inbounds %TokenKind, %TokenKind* %t141, i32 0, i32 0
  %t143 = load i32, i32* %t142
  %t144 = load %Token, %Token* %l11
  %t145 = extractvalue %Token %t144, 0
  %t146 = getelementptr inbounds %TokenKind, %TokenKind* %t145, i32 0, i32 0
  %t147 = load i32, i32* %t146
  %t148 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t149 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t147, 0
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t147, 1
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t147, 2
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t147, 3
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t147, 4
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t147, 5
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t147, 6
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t147, 7
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %s173 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.173, i32 0, i32 0
  %t174 = icmp eq i8* %t172, %s173
  %t175 = load %Parser, %Parser* %l0
  %t176 = load %Parser, %Parser* %l1
  %t177 = load %Token, %Token* %l2
  %t178 = load i8*, i8** %l3
  %t179 = load double, double* %l4
  %t180 = load %CaptureResult, %CaptureResult* %l5
  %t181 = load i8*, i8** %l6
  %t182 = load %TypeAnnotation, %TypeAnnotation* %l7
  %t183 = load %EffectParseResult, %EffectParseResult* %l8
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t185 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %l10
  %t186 = load %Token, %Token* %l11
  br i1 %t174, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t187 = load %Parser, %Parser* %l0
  store %Parser %t187, %Parser* %l12
  %t188 = load %Parser, %Parser* %l0
  %t189 = call %ModelPropertyParseResult @parse_model_property(%Parser %t188)
  store %ModelPropertyParseResult %t189, %ModelPropertyParseResult* %l13
  %t191 = load %ModelPropertyParseResult, %ModelPropertyParseResult* %l13
  %t192 = extractvalue %ModelPropertyParseResult %t191, 2
  br label %logical_and_entry_190

logical_and_entry_190:
  br i1 %t192, label %logical_and_right_190, label %logical_and_merge_190

logical_and_right_190:
  %t193 = load %ModelPropertyParseResult, %ModelPropertyParseResult* %l13
  %t194 = extractvalue %ModelPropertyParseResult %t193, 1
  %t195 = bitcast i8* null to %ModelProperty*
  %t196 = load %Parser, %Parser* %l12
  %t197 = call %Parser @skip_struct_member(%Parser %t196)
  store %Parser %t197, %Parser* %l0
  %t198 = load %Parser, %Parser* %l0
  %t199 = call %Parser @skip_trivia(%Parser %t198)
  store %Parser %t199, %Parser* %l0
  %t200 = load %Parser, %Parser* %l0
  %t201 = call %Token @parser_peek_raw(%Parser %t200)
  store %Token %t201, %Token* %l14
  %t203 = load %Token, %Token* %l14
  %t204 = extractvalue %Token %t203, 0
  %t205 = getelementptr inbounds %TokenKind, %TokenKind* %t204, i32 0, i32 0
  %t206 = load i32, i32* %t205
  %t207 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t208 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t209 = icmp eq i32 %t206, 0
  %t210 = select i1 %t209, i8* %t208, i8* %t207
  %t211 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t212 = icmp eq i32 %t206, 1
  %t213 = select i1 %t212, i8* %t211, i8* %t210
  %t214 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t215 = icmp eq i32 %t206, 2
  %t216 = select i1 %t215, i8* %t214, i8* %t213
  %t217 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t218 = icmp eq i32 %t206, 3
  %t219 = select i1 %t218, i8* %t217, i8* %t216
  %t220 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t221 = icmp eq i32 %t206, 4
  %t222 = select i1 %t221, i8* %t220, i8* %t219
  %t223 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t224 = icmp eq i32 %t206, 5
  %t225 = select i1 %t224, i8* %t223, i8* %t222
  %t226 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t227 = icmp eq i32 %t206, 6
  %t228 = select i1 %t227, i8* %t226, i8* %t225
  %t229 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t230 = icmp eq i32 %t206, 7
  %t231 = select i1 %t230, i8* %t229, i8* %t228
  %s232 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.232, i32 0, i32 0
  %t233 = icmp eq i8* %t231, %s232
  br label %logical_and_entry_202

logical_and_entry_202:
  br i1 %t233, label %logical_and_right_202, label %logical_and_merge_202

logical_and_right_202:
  %t234 = load %Token, %Token* %l14
  %t235 = extractvalue %Token %t234, 0
  %t236 = getelementptr inbounds %TokenKind, %TokenKind* %t235, i32 0, i32 0
  %t237 = load i32, i32* %t236
  %t238 = load %Token, %Token* %l14
  %t239 = extractvalue %Token %t238, 0
  %t240 = getelementptr inbounds %TokenKind, %TokenKind* %t239, i32 0, i32 0
  %t241 = load i32, i32* %t240
  %t242 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t243 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t244 = icmp eq i32 %t241, 0
  %t245 = select i1 %t244, i8* %t243, i8* %t242
  %t246 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t247 = icmp eq i32 %t241, 1
  %t248 = select i1 %t247, i8* %t246, i8* %t245
  %t249 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t250 = icmp eq i32 %t241, 2
  %t251 = select i1 %t250, i8* %t249, i8* %t248
  %t252 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t253 = icmp eq i32 %t241, 3
  %t254 = select i1 %t253, i8* %t252, i8* %t251
  %t255 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t256 = icmp eq i32 %t241, 4
  %t257 = select i1 %t256, i8* %t255, i8* %t254
  %t258 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t259 = icmp eq i32 %t241, 5
  %t260 = select i1 %t259, i8* %t258, i8* %t257
  %t261 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t262 = icmp eq i32 %t241, 6
  %t263 = select i1 %t262, i8* %t261, i8* %t260
  %t264 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t265 = icmp eq i32 %t241, 7
  %t266 = select i1 %t265, i8* %t264, i8* %t263
  %s267 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.267, i32 0, i32 0
  %t268 = icmp eq i8* %t266, %s267
  %t269 = load %Parser, %Parser* %l0
  %t270 = load %Parser, %Parser* %l1
  %t271 = load %Token, %Token* %l2
  %t272 = load i8*, i8** %l3
  %t273 = load double, double* %l4
  %t274 = load %CaptureResult, %CaptureResult* %l5
  %t275 = load i8*, i8** %l6
  %t276 = load %TypeAnnotation, %TypeAnnotation* %l7
  %t277 = load %EffectParseResult, %EffectParseResult* %l8
  %t278 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t279 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %l10
  %t280 = load %Token, %Token* %l11
  %t281 = load %Parser, %Parser* %l12
  %t282 = load %ModelPropertyParseResult, %ModelPropertyParseResult* %l13
  %t283 = load %Token, %Token* %l14
  br i1 %t268, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  br label %loop.latch4
loop.latch4:
  %t284 = load %Parser, %Parser* %l0
  br label %loop.header2
afterloop5:
  %t286 = alloca %Statement
  %t287 = getelementptr inbounds %Statement, %Statement* %t286, i32 0, i32 0
  store i32 3, i32* %t287
  %t288 = load i8*, i8** %l3
  %t289 = getelementptr inbounds %Statement, %Statement* %t286, i32 0, i32 1
  %t290 = bitcast [48 x i8]* %t289 to i8*
  %t291 = bitcast i8* %t290 to i8**
  store i8* %t288, i8** %t291
  %t292 = load double, double* %l4
  %t293 = call noalias i8* @malloc(i64 8)
  %t294 = bitcast i8* %t293 to double*
  store double %t292, double* %t294
  %t295 = bitcast i8* %t293 to %SourceSpan*
  %t296 = getelementptr inbounds %Statement, %Statement* %t286, i32 0, i32 1
  %t297 = bitcast [48 x i8]* %t296 to i8*
  %t298 = getelementptr inbounds i8, i8* %t297, i64 8
  %t299 = bitcast i8* %t298 to %SourceSpan**
  store %SourceSpan* %t295, %SourceSpan** %t299
  %t300 = load %TypeAnnotation, %TypeAnnotation* %l7
  %t301 = call noalias i8* @malloc(i64 8)
  %t302 = bitcast i8* %t301 to %TypeAnnotation*
  store %TypeAnnotation %t300, %TypeAnnotation* %t302
  %t303 = bitcast i8* %t301 to %TypeAnnotation*
  %t304 = getelementptr inbounds %Statement, %Statement* %t286, i32 0, i32 1
  %t305 = bitcast [48 x i8]* %t304 to i8*
  %t306 = getelementptr inbounds i8, i8* %t305, i64 16
  %t307 = bitcast i8* %t306 to %TypeAnnotation**
  store %TypeAnnotation* %t303, %TypeAnnotation** %t307
  %t308 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %l10
  %t309 = bitcast { %ModelProperty*, i64 }* %t308 to { %ModelProperty**, i64 }*
  %t310 = getelementptr inbounds %Statement, %Statement* %t286, i32 0, i32 1
  %t311 = bitcast [48 x i8]* %t310 to i8*
  %t312 = getelementptr inbounds i8, i8* %t311, i64 24
  %t313 = bitcast i8* %t312 to { %ModelProperty**, i64 }**
  store { %ModelProperty**, i64 }* %t309, { %ModelProperty**, i64 }** %t313
  %t314 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t315 = getelementptr inbounds %Statement, %Statement* %t286, i32 0, i32 1
  %t316 = bitcast [48 x i8]* %t315 to i8*
  %t317 = getelementptr inbounds i8, i8* %t316, i64 32
  %t318 = bitcast i8* %t317 to { i8**, i64 }**
  store { i8**, i64 }* %t314, { i8**, i64 }** %t318
  %t319 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t320 = getelementptr inbounds %Statement, %Statement* %t286, i32 0, i32 1
  %t321 = bitcast [48 x i8]* %t320 to i8*
  %t322 = getelementptr inbounds i8, i8* %t321, i64 40
  %t323 = bitcast i8* %t322 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t319, { %Decorator**, i64 }** %t323
  %t324 = load %Statement, %Statement* %t286
  store %Statement %t324, %Statement* %l15
  %t325 = load %Parser, %Parser* %l0
  %t326 = insertvalue %StatementParseResult undef, %Parser* null, 0
  %t327 = load %Statement, %Statement* %l15
  %t328 = insertvalue %StatementParseResult %t326, %Statement* null, 1
  ret %StatementParseResult %t328
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
  %l15 = alloca %Block*
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
  store %Parser zeroinitializer, %Parser* %l0
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
  store %Parser zeroinitializer, %Parser* %l0
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
  %t49 = getelementptr inbounds %TokenKind, %TokenKind* %t48, i32 0, i32 0
  %t50 = load i32, i32* %t49
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
  br label %logical_and_entry_46

logical_and_entry_46:
  br i1 %t77, label %logical_and_right_46, label %logical_and_merge_46

logical_and_right_46:
  %t78 = load %Token, %Token* %l9
  %t79 = extractvalue %Token %t78, 0
  %t80 = getelementptr inbounds %TokenKind, %TokenKind* %t79, i32 0, i32 0
  %t81 = load i32, i32* %t80
  %t82 = load %Parser, %Parser* %l0
  %t83 = call %EffectParseResult @parse_effect_list(%Parser %t82)
  store %EffectParseResult %t83, %EffectParseResult* %l10
  %t84 = load %EffectParseResult, %EffectParseResult* %l10
  %t85 = extractvalue %EffectParseResult %t84, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t86 = load %EffectParseResult, %EffectParseResult* %l10
  %t87 = extractvalue %EffectParseResult %t86, 1
  store { i8**, i64 }* %t87, { i8**, i64 }** %l11
  %t88 = call double @evaluate_decorators({ %Decorator*, i64 }* %decorators)
  store double %t88, double* %l12
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t90 = load double, double* %l12
  %t91 = call double @infer_effects({ i8**, i64 }* %t89, double %t90)
  store double %t91, double* %l13
  %t92 = load %Parser, %Parser* %l0
  %t93 = call %BlockParseResult @parse_block(%Parser %t92)
  store %BlockParseResult %t93, %BlockParseResult* %l14
  %t94 = load %BlockParseResult, %BlockParseResult* %l14
  %t95 = extractvalue %BlockParseResult %t94, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t96 = load %BlockParseResult, %BlockParseResult* %l14
  %t97 = extractvalue %BlockParseResult %t96, 1
  store %Block* %t97, %Block** %l15
  %t98 = load i8*, i8** %l2
  %t99 = insertvalue %FunctionSignature undef, i8* %t98, 0
  %t100 = insertvalue %FunctionSignature %t99, i1 0, 1
  %t101 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %l7
  %t102 = insertvalue %FunctionSignature %t100, { %Parameter**, i64 }* %t101, 2
  %t103 = load i8*, i8** %l8
  %t104 = bitcast i8* %t103 to %TypeAnnotation*
  %t105 = insertvalue %FunctionSignature %t102, %TypeAnnotation* %t104, 3
  %t106 = load double, double* %l13
  %t107 = insertvalue %FunctionSignature %t105, { i8**, i64 }* null, 4
  %t108 = alloca [0 x %TypeParameter*]
  %t109 = getelementptr [0 x %TypeParameter*], [0 x %TypeParameter*]* %t108, i32 0, i32 0
  %t110 = alloca { %TypeParameter**, i64 }
  %t111 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t110, i32 0, i32 0
  store %TypeParameter** %t109, %TypeParameter*** %t111
  %t112 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t110, i32 0, i32 1
  store i64 0, i64* %t112
  %t113 = insertvalue %FunctionSignature %t107, { %TypeParameter**, i64 }* %t110, 5
  %t114 = load double, double* %l3
  %t115 = insertvalue %FunctionSignature %t113, %SourceSpan* null, 6
  store %FunctionSignature %t115, %FunctionSignature* %l16
  %t116 = alloca %Statement
  %t117 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 0
  store i32 4, i32* %t117
  %t118 = load %FunctionSignature, %FunctionSignature* %l16
  %t119 = call noalias i8* @malloc(i64 56)
  %t120 = bitcast i8* %t119 to %FunctionSignature*
  store %FunctionSignature %t118, %FunctionSignature* %t120
  %t121 = bitcast i8* %t119 to %FunctionSignature*
  %t122 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t123 = bitcast [24 x i8]* %t122 to i8*
  %t124 = bitcast i8* %t123 to %FunctionSignature**
  store %FunctionSignature* %t121, %FunctionSignature** %t124
  %t125 = load %Block*, %Block** %l15
  %t126 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t127 = bitcast [24 x i8]* %t126 to i8*
  %t128 = getelementptr inbounds i8, i8* %t127, i64 8
  %t129 = bitcast i8* %t128 to %Block**
  store %Block* %t125, %Block** %t129
  %t130 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t131 = getelementptr inbounds %Statement, %Statement* %t116, i32 0, i32 1
  %t132 = bitcast [24 x i8]* %t131 to i8*
  %t133 = getelementptr inbounds i8, i8* %t132, i64 16
  %t134 = bitcast i8* %t133 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t130, { %Decorator**, i64 }** %t134
  %t135 = load %Statement, %Statement* %t116
  store %Statement %t135, %Statement* %l17
  %t136 = load %Parser, %Parser* %l0
  %t137 = insertvalue %StatementParseResult undef, %Parser* null, 0
  %t138 = load %Statement, %Statement* %l17
  %t139 = insertvalue %StatementParseResult %t137, %Statement* null, 1
  ret %StatementParseResult %t139
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
  %l13 = alloca %Block*
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
  store %Parser zeroinitializer, %Parser* %l0
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
  %t43 = getelementptr inbounds %TokenKind, %TokenKind* %t42, i32 0, i32 0
  %t44 = load i32, i32* %t43
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
  %t72 = load %Token, %Token* %l7
  %t73 = extractvalue %Token %t72, 0
  %t74 = getelementptr inbounds %TokenKind, %TokenKind* %t73, i32 0, i32 0
  %t75 = load i32, i32* %t74
  %t76 = load %Parser, %Parser* %l0
  %t77 = call %EffectParseResult @parse_effect_list(%Parser %t76)
  store %EffectParseResult %t77, %EffectParseResult* %l8
  %t78 = load %EffectParseResult, %EffectParseResult* %l8
  %t79 = extractvalue %EffectParseResult %t78, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t80 = load %EffectParseResult, %EffectParseResult* %l8
  %t81 = extractvalue %EffectParseResult %t80, 1
  store { i8**, i64 }* %t81, { i8**, i64 }** %l9
  %t82 = call double @evaluate_decorators({ %Decorator*, i64 }* %decorators)
  store double %t82, double* %l10
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t84 = load double, double* %l10
  %t85 = call double @infer_effects({ i8**, i64 }* %t83, double %t84)
  store double %t85, double* %l11
  %t86 = load %Parser, %Parser* %l0
  %t87 = call %BlockParseResult @parse_block(%Parser %t86)
  store %BlockParseResult %t87, %BlockParseResult* %l12
  %t88 = load %BlockParseResult, %BlockParseResult* %l12
  %t89 = extractvalue %BlockParseResult %t88, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t90 = load %BlockParseResult, %BlockParseResult* %l12
  %t91 = extractvalue %BlockParseResult %t90, 1
  store %Block* %t91, %Block** %l13
  %t92 = load i8*, i8** %l2
  %t93 = insertvalue %FunctionSignature undef, i8* %t92, 0
  %t94 = insertvalue %FunctionSignature %t93, i1 0, 1
  %t95 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %l5
  %t96 = insertvalue %FunctionSignature %t94, { %Parameter**, i64 }* %t95, 2
  %t97 = load i8*, i8** %l6
  %t98 = bitcast i8* %t97 to %TypeAnnotation*
  %t99 = insertvalue %FunctionSignature %t96, %TypeAnnotation* %t98, 3
  %t100 = load double, double* %l11
  %t101 = insertvalue %FunctionSignature %t99, { i8**, i64 }* null, 4
  %t102 = alloca [0 x %TypeParameter*]
  %t103 = getelementptr [0 x %TypeParameter*], [0 x %TypeParameter*]* %t102, i32 0, i32 0
  %t104 = alloca { %TypeParameter**, i64 }
  %t105 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t104, i32 0, i32 0
  store %TypeParameter** %t103, %TypeParameter*** %t105
  %t106 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t104, i32 0, i32 1
  store i64 0, i64* %t106
  %t107 = insertvalue %FunctionSignature %t101, { %TypeParameter**, i64 }* %t104, 5
  %t108 = insertvalue %FunctionSignature %t107, %SourceSpan* null, 6
  store %FunctionSignature %t108, %FunctionSignature* %l14
  %t109 = alloca %Statement
  %t110 = getelementptr inbounds %Statement, %Statement* %t109, i32 0, i32 0
  store i32 5, i32* %t110
  %t111 = load %FunctionSignature, %FunctionSignature* %l14
  %t112 = call noalias i8* @malloc(i64 56)
  %t113 = bitcast i8* %t112 to %FunctionSignature*
  store %FunctionSignature %t111, %FunctionSignature* %t113
  %t114 = bitcast i8* %t112 to %FunctionSignature*
  %t115 = getelementptr inbounds %Statement, %Statement* %t109, i32 0, i32 1
  %t116 = bitcast [24 x i8]* %t115 to i8*
  %t117 = bitcast i8* %t116 to %FunctionSignature**
  store %FunctionSignature* %t114, %FunctionSignature** %t117
  %t118 = load %Block*, %Block** %l13
  %t119 = getelementptr inbounds %Statement, %Statement* %t109, i32 0, i32 1
  %t120 = bitcast [24 x i8]* %t119 to i8*
  %t121 = getelementptr inbounds i8, i8* %t120, i64 8
  %t122 = bitcast i8* %t121 to %Block**
  store %Block* %t118, %Block** %t122
  %t123 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t124 = getelementptr inbounds %Statement, %Statement* %t109, i32 0, i32 1
  %t125 = bitcast [24 x i8]* %t124 to i8*
  %t126 = getelementptr inbounds i8, i8* %t125, i64 16
  %t127 = bitcast i8* %t126 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t123, { %Decorator**, i64 }** %t127
  %t128 = load %Statement, %Statement* %t109
  store %Statement %t128, %Statement* %l15
  %t129 = load %Parser, %Parser* %l0
  %t130 = insertvalue %StatementParseResult undef, %Parser* null, 0
  %t131 = load %Statement, %Statement* %l15
  %t132 = insertvalue %StatementParseResult %t130, %Statement* null, 1
  ret %StatementParseResult %t132
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
  %l11 = alloca %Block*
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
  store %Parser zeroinitializer, %Parser* %l0
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
  store %Parser zeroinitializer, %Parser* %l0
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
  store %Parser zeroinitializer, %Parser* %l0
  %t53 = load %BlockParseResult, %BlockParseResult* %l10
  %t54 = extractvalue %BlockParseResult %t53, 1
  store %Block* %t54, %Block** %l11
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
  %t69 = load %Block*, %Block** %l11
  %t70 = getelementptr inbounds %Statement, %Statement* %t55, i32 0, i32 1
  %t71 = bitcast [40 x i8]* %t70 to i8*
  %t72 = getelementptr inbounds i8, i8* %t71, i64 16
  %t73 = bitcast i8* %t72 to %Block**
  store %Block* %t69, %Block** %t73
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
  %t89 = insertvalue %StatementParseResult undef, %Parser* null, 0
  %t90 = load %Statement, %Statement* %l12
  %t91 = insertvalue %StatementParseResult %t89, %Statement* null, 1
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
  %l19 = alloca %Block*
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
  store %Parser zeroinitializer, %Parser* %l0
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
  store %Parser zeroinitializer, %Parser* %l0
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
  %t90 = getelementptr inbounds %TokenKind, %TokenKind* %t89, i32 0, i32 0
  %t91 = load i32, i32* %t90
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
  br label %logical_and_entry_87

logical_and_entry_87:
  br i1 %t118, label %logical_and_right_87, label %logical_and_merge_87

logical_and_right_87:
  %t119 = load %Token, %Token* %l13
  %t120 = extractvalue %Token %t119, 0
  %t121 = getelementptr inbounds %TokenKind, %TokenKind* %t120, i32 0, i32 0
  %t122 = load i32, i32* %t121
  %t123 = load %Parser, %Parser* %l0
  %t124 = call %EffectParseResult @parse_effect_list(%Parser %t123)
  store %EffectParseResult %t124, %EffectParseResult* %l14
  %t125 = load %EffectParseResult, %EffectParseResult* %l14
  %t126 = extractvalue %EffectParseResult %t125, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t127 = load %EffectParseResult, %EffectParseResult* %l14
  %t128 = extractvalue %EffectParseResult %t127, 1
  store { i8**, i64 }* %t128, { i8**, i64 }** %l15
  %t129 = call double @evaluate_decorators({ %Decorator*, i64 }* %decorators)
  store double %t129, double* %l16
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t131 = load double, double* %l16
  %t132 = call double @infer_effects({ i8**, i64 }* %t130, double %t131)
  store double %t132, double* %l17
  %t133 = load %Parser, %Parser* %l0
  %t134 = call %BlockParseResult @parse_block(%Parser %t133)
  store %BlockParseResult %t134, %BlockParseResult* %l18
  %t135 = load %BlockParseResult, %BlockParseResult* %l18
  %t136 = extractvalue %BlockParseResult %t135, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t137 = load %BlockParseResult, %BlockParseResult* %l18
  %t138 = extractvalue %BlockParseResult %t137, 1
  store %Block* %t138, %Block** %l19
  %t139 = load i8*, i8** %l6
  %t140 = insertvalue %FunctionSignature undef, i8* %t139, 0
  %t141 = load i1, i1* %l1
  %t142 = insertvalue %FunctionSignature %t140, i1 %t141, 1
  %t143 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %l11
  %t144 = insertvalue %FunctionSignature %t142, { %Parameter**, i64 }* %t143, 2
  %t145 = load i8*, i8** %l12
  %t146 = bitcast i8* %t145 to %TypeAnnotation*
  %t147 = insertvalue %FunctionSignature %t144, %TypeAnnotation* %t146, 3
  %t148 = load double, double* %l17
  %t149 = insertvalue %FunctionSignature %t147, { i8**, i64 }* null, 4
  %t150 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l9
  %t151 = insertvalue %FunctionSignature %t149, { %TypeParameter**, i64 }* %t150, 5
  %t152 = load double, double* %l7
  %t153 = insertvalue %FunctionSignature %t151, %SourceSpan* null, 6
  store %FunctionSignature %t153, %FunctionSignature* %l20
  %t154 = alloca %Statement
  %t155 = getelementptr inbounds %Statement, %Statement* %t154, i32 0, i32 0
  store i32 7, i32* %t155
  %t156 = load %FunctionSignature, %FunctionSignature* %l20
  %t157 = call noalias i8* @malloc(i64 56)
  %t158 = bitcast i8* %t157 to %FunctionSignature*
  store %FunctionSignature %t156, %FunctionSignature* %t158
  %t159 = bitcast i8* %t157 to %FunctionSignature*
  %t160 = getelementptr inbounds %Statement, %Statement* %t154, i32 0, i32 1
  %t161 = bitcast [24 x i8]* %t160 to i8*
  %t162 = bitcast i8* %t161 to %FunctionSignature**
  store %FunctionSignature* %t159, %FunctionSignature** %t162
  %t163 = load %Block*, %Block** %l19
  %t164 = getelementptr inbounds %Statement, %Statement* %t154, i32 0, i32 1
  %t165 = bitcast [24 x i8]* %t164 to i8*
  %t166 = getelementptr inbounds i8, i8* %t165, i64 8
  %t167 = bitcast i8* %t166 to %Block**
  store %Block* %t163, %Block** %t167
  %t168 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t169 = getelementptr inbounds %Statement, %Statement* %t154, i32 0, i32 1
  %t170 = bitcast [24 x i8]* %t169 to i8*
  %t171 = getelementptr inbounds i8, i8* %t170, i64 16
  %t172 = bitcast i8* %t171 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t168, { %Decorator**, i64 }** %t172
  %t173 = load %Statement, %Statement* %t154
  store %Statement %t173, %Statement* %l21
  %t174 = load %Parser, %Parser* %l0
  %t175 = insertvalue %StatementParseResult undef, %Parser* null, 0
  %t176 = load %Statement, %Statement* %l21
  %t177 = insertvalue %StatementParseResult %t175, %Statement* null, 1
  ret %StatementParseResult %t177
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
  %t12 = getelementptr inbounds %TokenKind, %TokenKind* %t11, i32 0, i32 0
  %t13 = load i32, i32* %t12
  %t14 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t15 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t16 = icmp eq i32 %t13, 0
  %t17 = select i1 %t16, i8* %t15, i8* %t14
  %t18 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t19 = icmp eq i32 %t13, 1
  %t20 = select i1 %t19, i8* %t18, i8* %t17
  %t21 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t22 = icmp eq i32 %t13, 2
  %t23 = select i1 %t22, i8* %t21, i8* %t20
  %t24 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t13, 3
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %t27 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t28 = icmp eq i32 %t13, 4
  %t29 = select i1 %t28, i8* %t27, i8* %t26
  %t30 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t31 = icmp eq i32 %t13, 5
  %t32 = select i1 %t31, i8* %t30, i8* %t29
  %t33 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t34 = icmp eq i32 %t13, 6
  %t35 = select i1 %t34, i8* %t33, i8* %t32
  %t36 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t37 = icmp eq i32 %t13, 7
  %t38 = select i1 %t37, i8* %t36, i8* %t35
  %s39 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.39, i32 0, i32 0
  %t40 = icmp eq i8* %t38, %s39
  br label %logical_and_entry_9

logical_and_entry_9:
  br i1 %t40, label %logical_and_right_9, label %logical_and_merge_9

logical_and_right_9:
  %t41 = load %Token, %Token* %l2
  %t42 = extractvalue %Token %t41, 0
  %t43 = getelementptr inbounds %TokenKind, %TokenKind* %t42, i32 0, i32 0
  %t44 = load i32, i32* %t43
  %t45 = load %Parser, %Parser* %l0
  %t46 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t47 = load %Token, %Token* %l2
  br label %loop.header0
loop.header0:
  %t170 = phi %Parser [ %t45, %entry ], [ %t168, %loop.latch2 ]
  %t171 = phi { %Parameter*, i64 }* [ %t46, %entry ], [ %t169, %loop.latch2 ]
  store %Parser %t170, %Parser* %l0
  store { %Parameter*, i64 }* %t171, { %Parameter*, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t48 = load %Parser, %Parser* %l0
  %t49 = call %ParameterParseResult @parse_single_parameter(%Parser %t48)
  store %ParameterParseResult %t49, %ParameterParseResult* %l3
  %t50 = load %ParameterParseResult, %ParameterParseResult* %l3
  %t51 = extractvalue %ParameterParseResult %t50, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t52 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t53 = load %ParameterParseResult, %ParameterParseResult* %l3
  %t54 = extractvalue %ParameterParseResult %t53, 1
  %t55 = call { %Parameter*, i64 }* @append_parameter({ %Parameter*, i64 }* %t52, %Parameter zeroinitializer)
  store { %Parameter*, i64 }* %t55, { %Parameter*, i64 }** %l1
  %t56 = load %Parser, %Parser* %l0
  %t57 = call %Parser @skip_trivia(%Parser %t56)
  store %Parser %t57, %Parser* %l0
  %t58 = load %Parser, %Parser* %l0
  %t59 = call %Token @parser_peek_raw(%Parser %t58)
  store %Token %t59, %Token* %l4
  %t61 = load %Token, %Token* %l4
  %t62 = extractvalue %Token %t61, 0
  %t63 = getelementptr inbounds %TokenKind, %TokenKind* %t62, i32 0, i32 0
  %t64 = load i32, i32* %t63
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
  %s90 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.90, i32 0, i32 0
  %t91 = icmp eq i8* %t89, %s90
  br label %logical_and_entry_60

logical_and_entry_60:
  br i1 %t91, label %logical_and_right_60, label %logical_and_merge_60

logical_and_right_60:
  %t92 = load %Token, %Token* %l4
  %t93 = extractvalue %Token %t92, 0
  %t94 = getelementptr inbounds %TokenKind, %TokenKind* %t93, i32 0, i32 0
  %t95 = load i32, i32* %t94
  %t97 = load %Token, %Token* %l4
  %t98 = extractvalue %Token %t97, 0
  %t99 = getelementptr inbounds %TokenKind, %TokenKind* %t98, i32 0, i32 0
  %t100 = load i32, i32* %t99
  %t101 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t102 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t100, 0
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t106 = icmp eq i32 %t100, 1
  %t107 = select i1 %t106, i8* %t105, i8* %t104
  %t108 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t100, 2
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t112 = icmp eq i32 %t100, 3
  %t113 = select i1 %t112, i8* %t111, i8* %t110
  %t114 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t100, 4
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %t117 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t118 = icmp eq i32 %t100, 5
  %t119 = select i1 %t118, i8* %t117, i8* %t116
  %t120 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t100, 6
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %t123 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t124 = icmp eq i32 %t100, 7
  %t125 = select i1 %t124, i8* %t123, i8* %t122
  %s126 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.126, i32 0, i32 0
  %t127 = icmp eq i8* %t125, %s126
  br label %logical_and_entry_96

logical_and_entry_96:
  br i1 %t127, label %logical_and_right_96, label %logical_and_merge_96

logical_and_right_96:
  %t128 = load %Token, %Token* %l4
  %t129 = extractvalue %Token %t128, 0
  %t130 = getelementptr inbounds %TokenKind, %TokenKind* %t129, i32 0, i32 0
  %t131 = load i32, i32* %t130
  %t132 = load %Token, %Token* %l4
  %t133 = extractvalue %Token %t132, 0
  %t134 = getelementptr inbounds %TokenKind, %TokenKind* %t133, i32 0, i32 0
  %t135 = load i32, i32* %t134
  %t136 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t137 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t135, 0
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t135, 1
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t135, 2
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t135, 3
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t135, 4
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t135, 5
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t135, 6
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t135, 7
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %s161 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.161, i32 0, i32 0
  %t162 = icmp eq i8* %t160, %s161
  %t163 = load %Parser, %Parser* %l0
  %t164 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t165 = load %Token, %Token* %l2
  %t166 = load %ParameterParseResult, %ParameterParseResult* %l3
  %t167 = load %Token, %Token* %l4
  br i1 %t162, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  br label %loop.latch2
loop.latch2:
  %t168 = load %Parser, %Parser* %l0
  %t169 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t172 = load %Parser, %Parser* %l0
  %t173 = insertvalue %ParameterListParseResult undef, %Parser* null, 0
  %t174 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t175 = bitcast { %Parameter*, i64 }* %t174 to { %Parameter**, i64 }*
  %t176 = insertvalue %ParameterListParseResult %t173, { %Parameter**, i64 }* %t175, 1
  ret %ParameterListParseResult %t176
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
  %t23 = getelementptr inbounds %TokenKind, %TokenKind* %t22, i32 0, i32 0
  %t24 = load i32, i32* %t23
  %t25 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t26 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t24, 0
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t24, 1
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t24, 2
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t24, 3
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t24, 4
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t24, 5
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t24, 6
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t24, 7
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %s50 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.50, i32 0, i32 0
  %t51 = icmp ne i8* %t49, %s50
  %t52 = load %Parser, %Parser* %l0
  %t53 = load i1, i1* %l1
  %t54 = load %Token, %Token* %l2
  %t55 = load %Token, %Token* %l3
  br i1 %t51, label %then2, label %merge3
then2:
  %t56 = insertvalue %StructFieldParseResult undef, %Parser* null, 0
  %t57 = bitcast i8* null to %FieldDeclaration*
  %t58 = insertvalue %StructFieldParseResult %t56, %FieldDeclaration* %t57, 1
  %t59 = insertvalue %StructFieldParseResult %t58, i1 0, 2
  ret %StructFieldParseResult %t59
merge3:
  %t60 = load %Token, %Token* %l3
  %t61 = call i8* @identifier_text(%Token %t60)
  store i8* %t61, i8** %l4
  %t62 = load %Token, %Token* %l3
  %t63 = alloca [1 x %Token]
  %t64 = getelementptr [1 x %Token], [1 x %Token]* %t63, i32 0, i32 0
  %t65 = getelementptr %Token, %Token* %t64, i64 0
  store %Token %t62, %Token* %t65
  %t66 = alloca { %Token*, i64 }
  %t67 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t66, i32 0, i32 0
  store %Token* %t64, %Token** %t67
  %t68 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t66, i32 0, i32 1
  store i64 1, i64* %t68
  %t69 = call double @source_span_from_tokens({ %Token*, i64 }* %t66)
  store double %t69, double* %l5
  %t70 = load %Parser, %Parser* %l0
  %t71 = call %Parser @parser_advance_raw(%Parser %t70)
  store %Parser %t71, %Parser* %l0
  %t72 = load %Parser, %Parser* %l0
  %t73 = call %Parser @skip_trivia(%Parser %t72)
  store %Parser %t73, %Parser* %l0
  %t74 = load %Parser, %Parser* %l0
  %t75 = call %Token @parser_peek_raw(%Parser %t74)
  store %Token %t75, %Token* %l6
  %t76 = load %Token, %Token* %l6
  %t77 = extractvalue %Token %t76, 0
  %t78 = getelementptr inbounds %TokenKind, %TokenKind* %t77, i32 0, i32 0
  %t79 = load i32, i32* %t78
  %t80 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t81 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t79, 0
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t79, 1
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %t87 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t88 = icmp eq i32 %t79, 2
  %t89 = select i1 %t88, i8* %t87, i8* %t86
  %t90 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t91 = icmp eq i32 %t79, 3
  %t92 = select i1 %t91, i8* %t90, i8* %t89
  %t93 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t79, 4
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %t96 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t97 = icmp eq i32 %t79, 5
  %t98 = select i1 %t97, i8* %t96, i8* %t95
  %t99 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t79, 6
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t79, 7
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %s105 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.105, i32 0, i32 0
  %t106 = icmp eq i8* %t104, %s105
  store i1 %t106, i1* %l7
  %t107 = load i1, i1* %l7
  %t108 = xor i1 %t107, 1
  %t109 = load %Parser, %Parser* %l0
  %t110 = load i1, i1* %l1
  %t111 = load %Token, %Token* %l2
  %t112 = load %Token, %Token* %l3
  %t113 = load i8*, i8** %l4
  %t114 = load double, double* %l5
  %t115 = load %Token, %Token* %l6
  %t116 = load i1, i1* %l7
  br i1 %t108, label %then4, label %merge5
then4:
  %t117 = insertvalue %StructFieldParseResult undef, %Parser* null, 0
  %t118 = bitcast i8* null to %FieldDeclaration*
  %t119 = insertvalue %StructFieldParseResult %t117, %FieldDeclaration* %t118, 1
  %t120 = insertvalue %StructFieldParseResult %t119, i1 0, 2
  ret %StructFieldParseResult %t120
merge5:
  %t121 = load %Parser, %Parser* %l0
  %t122 = call %Parser @parser_advance_raw(%Parser %t121)
  store %Parser %t122, %Parser* %l0
  %t123 = load %Parser, %Parser* %l0
  %t124 = call %Parser @skip_trivia(%Parser %t123)
  %t125 = alloca [1 x i8]
  %t126 = getelementptr [1 x i8], [1 x i8]* %t125, i32 0, i32 0
  %t127 = getelementptr i8, i8* %t126, i64 0
  store i8 59, i8* %t127
  %t128 = alloca { i8*, i64 }
  %t129 = getelementptr { i8*, i64 }, { i8*, i64 }* %t128, i32 0, i32 0
  store i8* %t126, i8** %t129
  %t130 = getelementptr { i8*, i64 }, { i8*, i64 }* %t128, i32 0, i32 1
  store i64 1, i64* %t130
  %t131 = bitcast { i8*, i64 }* %t128 to { i8**, i64 }*
  %t132 = call %CaptureResult @collect_until(%Parser %t124, { i8**, i64 }* %t131)
  store %CaptureResult %t132, %CaptureResult* %l8
  %t133 = load %CaptureResult, %CaptureResult* %l8
  %t134 = extractvalue %CaptureResult %t133, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t135 = load %CaptureResult, %CaptureResult* %l8
  %t136 = extractvalue %CaptureResult %t135, 1
  %t137 = bitcast { %Token**, i64 }* %t136 to { %Token*, i64 }*
  %t138 = call i8* @tokens_to_text({ %Token*, i64 }* %t137)
  %t139 = call i8* @trim_text(i8* %t138)
  store i8* %t139, i8** %l9
  %t140 = load i8*, i8** %l9
  %t141 = call i64 @sailfin_runtime_string_length(i8* %t140)
  %t142 = icmp eq i64 %t141, 0
  %t143 = load %Parser, %Parser* %l0
  %t144 = load i1, i1* %l1
  %t145 = load %Token, %Token* %l2
  %t146 = load %Token, %Token* %l3
  %t147 = load i8*, i8** %l4
  %t148 = load double, double* %l5
  %t149 = load %Token, %Token* %l6
  %t150 = load i1, i1* %l7
  %t151 = load %CaptureResult, %CaptureResult* %l8
  %t152 = load i8*, i8** %l9
  br i1 %t142, label %then6, label %merge7
then6:
  %t153 = insertvalue %StructFieldParseResult undef, %Parser* null, 0
  %t154 = bitcast i8* null to %FieldDeclaration*
  %t155 = insertvalue %StructFieldParseResult %t153, %FieldDeclaration* %t154, 1
  %t156 = insertvalue %StructFieldParseResult %t155, i1 0, 2
  ret %StructFieldParseResult %t156
merge7:
  %t157 = load %Parser, %Parser* %l0
  %t158 = call %Parser @skip_trivia(%Parser %t157)
  store %Parser %t158, %Parser* %l0
  %t159 = load %Parser, %Parser* %l0
  %t160 = call %Token @parser_peek_raw(%Parser %t159)
  store %Token %t160, %Token* %l10
  %t162 = load %Token, %Token* %l10
  %t163 = extractvalue %Token %t162, 0
  %t164 = getelementptr inbounds %TokenKind, %TokenKind* %t163, i32 0, i32 0
  %t165 = load i32, i32* %t164
  %t166 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t167 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t165, 0
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t165, 1
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t165, 2
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %t176 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t177 = icmp eq i32 %t165, 3
  %t178 = select i1 %t177, i8* %t176, i8* %t175
  %t179 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t165, 4
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t165, 5
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t165, 6
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %t188 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t165, 7
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %s191 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.191, i32 0, i32 0
  %t192 = icmp ne i8* %t190, %s191
  br label %logical_or_entry_161

logical_or_entry_161:
  br i1 %t192, label %logical_or_merge_161, label %logical_or_right_161

logical_or_right_161:
  %t193 = load %Token, %Token* %l10
  %t194 = extractvalue %Token %t193, 0
  %t195 = getelementptr inbounds %TokenKind, %TokenKind* %t194, i32 0, i32 0
  %t196 = load i32, i32* %t195
  %t197 = load %Parser, %Parser* %l0
  %t198 = call %Parser @parser_advance_raw(%Parser %t197)
  store %Parser %t198, %Parser* %l0
  %t199 = load i8*, i8** %l4
  %t200 = insertvalue %FieldDeclaration undef, i8* %t199, 0
  %t201 = load i8*, i8** %l9
  %t202 = insertvalue %TypeAnnotation undef, i8* %t201, 0
  %t203 = insertvalue %FieldDeclaration %t200, %TypeAnnotation* null, 1
  %t204 = load i1, i1* %l1
  %t205 = insertvalue %FieldDeclaration %t203, i1 %t204, 2
  %t206 = load double, double* %l5
  %t207 = insertvalue %FieldDeclaration %t205, %SourceSpan* null, 3
  store %FieldDeclaration %t207, %FieldDeclaration* %l11
  %t208 = load %Parser, %Parser* %l0
  %t209 = insertvalue %StructFieldParseResult undef, %Parser* null, 0
  %t210 = load %FieldDeclaration, %FieldDeclaration* %l11
  %t211 = insertvalue %StructFieldParseResult %t209, %FieldDeclaration* null, 1
  %t212 = insertvalue %StructFieldParseResult %t211, i1 1, 2
  ret %StructFieldParseResult %t212
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
  %t5 = getelementptr inbounds %TokenKind, %TokenKind* %t4, i32 0, i32 0
  %t6 = load i32, i32* %t5
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
  %s32 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.32, i32 0, i32 0
  %t33 = icmp ne i8* %t31, %s32
  %t34 = load %Parser, %Parser* %l0
  %t35 = load %Token, %Token* %l1
  br i1 %t33, label %then0, label %merge1
then0:
  %t36 = insertvalue %ModelPropertyParseResult undef, %Parser* null, 0
  %t37 = bitcast i8* null to %ModelProperty*
  %t38 = insertvalue %ModelPropertyParseResult %t36, %ModelProperty* %t37, 1
  %t39 = insertvalue %ModelPropertyParseResult %t38, i1 0, 2
  ret %ModelPropertyParseResult %t39
merge1:
  %t40 = load %Token, %Token* %l1
  %t41 = call i8* @identifier_text(%Token %t40)
  store i8* %t41, i8** %l2
  %t42 = load %Parser, %Parser* %l0
  %t43 = call %Parser @parser_advance_raw(%Parser %t42)
  store %Parser %t43, %Parser* %l0
  %t44 = load %Parser, %Parser* %l0
  %t45 = call %Parser @skip_trivia(%Parser %t44)
  store %Parser %t45, %Parser* %l0
  %t46 = load %Parser, %Parser* %l0
  %t47 = call %Token @parser_peek_raw(%Parser %t46)
  store %Token %t47, %Token* %l3
  %t49 = load %Token, %Token* %l3
  %t50 = extractvalue %Token %t49, 0
  %t51 = getelementptr inbounds %TokenKind, %TokenKind* %t50, i32 0, i32 0
  %t52 = load i32, i32* %t51
  %t53 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t54 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t55 = icmp eq i32 %t52, 0
  %t56 = select i1 %t55, i8* %t54, i8* %t53
  %t57 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t58 = icmp eq i32 %t52, 1
  %t59 = select i1 %t58, i8* %t57, i8* %t56
  %t60 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t61 = icmp eq i32 %t52, 2
  %t62 = select i1 %t61, i8* %t60, i8* %t59
  %t63 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t52, 3
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t52, 4
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t52, 5
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t52, 6
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t52, 7
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %s78 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.78, i32 0, i32 0
  %t79 = icmp ne i8* %t77, %s78
  br label %logical_or_entry_48

logical_or_entry_48:
  br i1 %t79, label %logical_or_merge_48, label %logical_or_right_48

logical_or_right_48:
  %t80 = load %Token, %Token* %l3
  %t81 = extractvalue %Token %t80, 0
  %t82 = getelementptr inbounds %TokenKind, %TokenKind* %t81, i32 0, i32 0
  %t83 = load i32, i32* %t82
  %t84 = load %Parser, %Parser* %l0
  %t85 = call %Parser @parser_advance_raw(%Parser %t84)
  store %Parser %t85, %Parser* %l0
  %t86 = load %Parser, %Parser* %l0
  %t87 = call %Parser @skip_trivia(%Parser %t86)
  %t88 = alloca [1 x i8]
  %t89 = getelementptr [1 x i8], [1 x i8]* %t88, i32 0, i32 0
  %t90 = getelementptr i8, i8* %t89, i64 0
  store i8 59, i8* %t90
  %t91 = alloca { i8*, i64 }
  %t92 = getelementptr { i8*, i64 }, { i8*, i64 }* %t91, i32 0, i32 0
  store i8* %t89, i8** %t92
  %t93 = getelementptr { i8*, i64 }, { i8*, i64 }* %t91, i32 0, i32 1
  store i64 1, i64* %t93
  %t94 = bitcast { i8*, i64 }* %t91 to { i8**, i64 }*
  %t95 = call %CaptureResult @collect_until(%Parser %t87, { i8**, i64 }* %t94)
  store %CaptureResult %t95, %CaptureResult* %l4
  %t96 = load %CaptureResult, %CaptureResult* %l4
  %t97 = extractvalue %CaptureResult %t96, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t98 = load %CaptureResult, %CaptureResult* %l4
  %t99 = extractvalue %CaptureResult %t98, 1
  %t100 = bitcast { %Token**, i64 }* %t99 to { %Token*, i64 }*
  %t101 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t100)
  store %Expression %t101, %Expression* %l5
  %t102 = load %Parser, %Parser* %l0
  %t103 = call %Parser @skip_trivia(%Parser %t102)
  store %Parser %t103, %Parser* %l0
  %t104 = load %Parser, %Parser* %l0
  %t105 = call %Token @parser_peek_raw(%Parser %t104)
  store %Token %t105, %Token* %l6
  %t107 = load %Token, %Token* %l6
  %t108 = extractvalue %Token %t107, 0
  %t109 = getelementptr inbounds %TokenKind, %TokenKind* %t108, i32 0, i32 0
  %t110 = load i32, i32* %t109
  %t111 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t112 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t113 = icmp eq i32 %t110, 0
  %t114 = select i1 %t113, i8* %t112, i8* %t111
  %t115 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t116 = icmp eq i32 %t110, 1
  %t117 = select i1 %t116, i8* %t115, i8* %t114
  %t118 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t119 = icmp eq i32 %t110, 2
  %t120 = select i1 %t119, i8* %t118, i8* %t117
  %t121 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t122 = icmp eq i32 %t110, 3
  %t123 = select i1 %t122, i8* %t121, i8* %t120
  %t124 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t125 = icmp eq i32 %t110, 4
  %t126 = select i1 %t125, i8* %t124, i8* %t123
  %t127 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t128 = icmp eq i32 %t110, 5
  %t129 = select i1 %t128, i8* %t127, i8* %t126
  %t130 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t131 = icmp eq i32 %t110, 6
  %t132 = select i1 %t131, i8* %t130, i8* %t129
  %t133 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t134 = icmp eq i32 %t110, 7
  %t135 = select i1 %t134, i8* %t133, i8* %t132
  %s136 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.136, i32 0, i32 0
  %t137 = icmp ne i8* %t135, %s136
  br label %logical_or_entry_106

logical_or_entry_106:
  br i1 %t137, label %logical_or_merge_106, label %logical_or_right_106

logical_or_right_106:
  %t138 = load %Token, %Token* %l6
  %t139 = extractvalue %Token %t138, 0
  %t140 = getelementptr inbounds %TokenKind, %TokenKind* %t139, i32 0, i32 0
  %t141 = load i32, i32* %t140
  %t142 = load %Parser, %Parser* %l0
  %t143 = call %Parser @parser_advance_raw(%Parser %t142)
  store %Parser %t143, %Parser* %l0
  %t144 = load i8*, i8** %l2
  %t145 = insertvalue %ModelProperty undef, i8* %t144, 0
  %t146 = load %Expression, %Expression* %l5
  %t147 = insertvalue %ModelProperty %t145, %Expression* null, 1
  %t148 = load %Token, %Token* %l1
  %t149 = alloca [1 x %Token]
  %t150 = getelementptr [1 x %Token], [1 x %Token]* %t149, i32 0, i32 0
  %t151 = getelementptr %Token, %Token* %t150, i64 0
  store %Token %t148, %Token* %t151
  %t152 = alloca { %Token*, i64 }
  %t153 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t152, i32 0, i32 0
  store %Token* %t150, %Token** %t153
  %t154 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t152, i32 0, i32 1
  store i64 1, i64* %t154
  %t155 = call double @source_span_from_tokens({ %Token*, i64 }* %t152)
  %t156 = insertvalue %ModelProperty %t147, %SourceSpan* null, 2
  store %ModelProperty %t156, %ModelProperty* %l7
  %t157 = load %Parser, %Parser* %l0
  %t158 = insertvalue %ModelPropertyParseResult undef, %Parser* null, 0
  %t159 = load %ModelProperty, %ModelProperty* %l7
  %t160 = insertvalue %ModelPropertyParseResult %t158, %ModelProperty* null, 1
  %t161 = insertvalue %ModelPropertyParseResult %t160, i1 1, 2
  ret %ModelPropertyParseResult %t161
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
  %l18 = alloca %Block*
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
  %t37 = insertvalue %MethodParseResult undef, %Parser* null, 0
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
  %t50 = getelementptr inbounds %TokenKind, %TokenKind* %t49, i32 0, i32 0
  %t51 = load i32, i32* %t50
  %t52 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t53 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t54 = icmp eq i32 %t51, 0
  %t55 = select i1 %t54, i8* %t53, i8* %t52
  %t56 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t57 = icmp eq i32 %t51, 1
  %t58 = select i1 %t57, i8* %t56, i8* %t55
  %t59 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t60 = icmp eq i32 %t51, 2
  %t61 = select i1 %t60, i8* %t59, i8* %t58
  %t62 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t51, 3
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t51, 4
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t51, 5
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t51, 6
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t75 = icmp eq i32 %t51, 7
  %t76 = select i1 %t75, i8* %t74, i8* %t73
  %s77 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.77, i32 0, i32 0
  %t78 = icmp ne i8* %t76, %s77
  %t79 = load %Parser, %Parser* %l0
  %t80 = load i1, i1* %l1
  %t81 = load %Token, %Token* %l2
  %t82 = load %Token, %Token* %l4
  br i1 %t78, label %then6, label %merge7
then6:
  %t83 = insertvalue %MethodParseResult undef, %Parser* null, 0
  %t84 = bitcast i8* null to %MethodDeclaration*
  %t85 = insertvalue %MethodParseResult %t83, %MethodDeclaration* %t84, 1
  %t86 = insertvalue %MethodParseResult %t85, i1 0, 2
  ret %MethodParseResult %t86
merge7:
  %t87 = load %Token, %Token* %l4
  %t88 = call i8* @identifier_text(%Token %t87)
  store i8* %t88, i8** %l5
  %t89 = load %Token, %Token* %l4
  %t90 = alloca [1 x %Token]
  %t91 = getelementptr [1 x %Token], [1 x %Token]* %t90, i32 0, i32 0
  %t92 = getelementptr %Token, %Token* %t91, i64 0
  store %Token %t89, %Token* %t92
  %t93 = alloca { %Token*, i64 }
  %t94 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t93, i32 0, i32 0
  store %Token* %t91, %Token** %t94
  %t95 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t93, i32 0, i32 1
  store i64 1, i64* %t95
  %t96 = call double @source_span_from_tokens({ %Token*, i64 }* %t93)
  store double %t96, double* %l6
  %t97 = load %Parser, %Parser* %l0
  %t98 = call %Parser @parser_advance_raw(%Parser %t97)
  store %Parser %t98, %Parser* %l0
  %t99 = load %Parser, %Parser* %l0
  %t100 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %t99)
  store %TypeParameterParseResult %t100, %TypeParameterParseResult* %l7
  %t101 = load %TypeParameterParseResult, %TypeParameterParseResult* %l7
  %t102 = extractvalue %TypeParameterParseResult %t101, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t103 = load %TypeParameterParseResult, %TypeParameterParseResult* %l7
  %t104 = extractvalue %TypeParameterParseResult %t103, 1
  store { %TypeParameter**, i64 }* %t104, { %TypeParameter**, i64 }** %l8
  %t105 = load %Parser, %Parser* %l0
  %t106 = call %Parser @skip_trivia(%Parser %t105)
  store %Parser %t106, %Parser* %l0
  %t107 = load %Parser, %Parser* %l0
  %t108 = alloca [2 x i8], align 1
  %t109 = getelementptr [2 x i8], [2 x i8]* %t108, i32 0, i32 0
  store i8 40, i8* %t109
  %t110 = getelementptr [2 x i8], [2 x i8]* %t108, i32 0, i32 1
  store i8 0, i8* %t110
  %t111 = getelementptr [2 x i8], [2 x i8]* %t108, i32 0, i32 0
  %t112 = call %Parser @consume_symbol(%Parser %t107, i8* %t111)
  store %Parser %t112, %Parser* %l0
  %t113 = load %Parser, %Parser* %l0
  %t114 = call %ParameterListParseResult @parse_parameter_list(%Parser %t113)
  store %ParameterListParseResult %t114, %ParameterListParseResult* %l9
  %t115 = load %ParameterListParseResult, %ParameterListParseResult* %l9
  %t116 = extractvalue %ParameterListParseResult %t115, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t117 = load %ParameterListParseResult, %ParameterListParseResult* %l9
  %t118 = extractvalue %ParameterListParseResult %t117, 1
  store { %Parameter**, i64 }* %t118, { %Parameter**, i64 }** %l10
  %t119 = load %Parser, %Parser* %l0
  %t120 = call %Parser @skip_trivia(%Parser %t119)
  store %Parser %t120, %Parser* %l0
  store i8* null, i8** %l11
  %t121 = load %Parser, %Parser* %l0
  %t122 = call %Token @parser_peek_raw(%Parser %t121)
  store %Token %t122, %Token* %l12
  %t125 = load %Token, %Token* %l12
  %t126 = extractvalue %Token %t125, 0
  %t127 = getelementptr inbounds %TokenKind, %TokenKind* %t126, i32 0, i32 0
  %t128 = load i32, i32* %t127
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
  %s154 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.154, i32 0, i32 0
  %t155 = icmp eq i8* %t153, %s154
  br label %logical_and_entry_124

logical_and_entry_124:
  br i1 %t155, label %logical_and_right_124, label %logical_and_merge_124

logical_and_right_124:
  %t156 = load %Token, %Token* %l12
  %t157 = extractvalue %Token %t156, 0
  %t158 = getelementptr inbounds %TokenKind, %TokenKind* %t157, i32 0, i32 0
  %t159 = load i32, i32* %t158
  %t160 = load %Parser, %Parser* %l0
  %t161 = call %EffectParseResult @parse_effect_list(%Parser %t160)
  store %EffectParseResult %t161, %EffectParseResult* %l13
  %t162 = load %EffectParseResult, %EffectParseResult* %l13
  %t163 = extractvalue %EffectParseResult %t162, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t164 = load %EffectParseResult, %EffectParseResult* %l13
  %t165 = extractvalue %EffectParseResult %t164, 1
  store { i8**, i64 }* %t165, { i8**, i64 }** %l14
  %t166 = call double @evaluate_decorators({ %Decorator*, i64 }* %decorators)
  store double %t166, double* %l15
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t168 = load double, double* %l15
  %t169 = call double @infer_effects({ i8**, i64 }* %t167, double %t168)
  store double %t169, double* %l16
  %t170 = load %Parser, %Parser* %l0
  %t171 = call %BlockParseResult @parse_block(%Parser %t170)
  store %BlockParseResult %t171, %BlockParseResult* %l17
  %t172 = load %BlockParseResult, %BlockParseResult* %l17
  %t173 = extractvalue %BlockParseResult %t172, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t174 = load %BlockParseResult, %BlockParseResult* %l17
  %t175 = extractvalue %BlockParseResult %t174, 1
  store %Block* %t175, %Block** %l18
  %t176 = load i8*, i8** %l5
  %t177 = insertvalue %FunctionSignature undef, i8* %t176, 0
  %t178 = load i1, i1* %l1
  %t179 = insertvalue %FunctionSignature %t177, i1 %t178, 1
  %t180 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %l10
  %t181 = insertvalue %FunctionSignature %t179, { %Parameter**, i64 }* %t180, 2
  %t182 = load i8*, i8** %l11
  %t183 = bitcast i8* %t182 to %TypeAnnotation*
  %t184 = insertvalue %FunctionSignature %t181, %TypeAnnotation* %t183, 3
  %t185 = load double, double* %l16
  %t186 = insertvalue %FunctionSignature %t184, { i8**, i64 }* null, 4
  %t187 = load { %TypeParameter**, i64 }*, { %TypeParameter**, i64 }** %l8
  %t188 = insertvalue %FunctionSignature %t186, { %TypeParameter**, i64 }* %t187, 5
  %t189 = load double, double* %l6
  %t190 = insertvalue %FunctionSignature %t188, %SourceSpan* null, 6
  store %FunctionSignature %t190, %FunctionSignature* %l19
  %t191 = load %FunctionSignature, %FunctionSignature* %l19
  %t192 = insertvalue %MethodDeclaration undef, %FunctionSignature* null, 0
  %t193 = load %Block*, %Block** %l18
  %t194 = insertvalue %MethodDeclaration %t192, %Block* %t193, 1
  %t195 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t196 = insertvalue %MethodDeclaration %t194, { %Decorator**, i64 }* %t195, 2
  store %MethodDeclaration %t196, %MethodDeclaration* %l20
  %t197 = load %Parser, %Parser* %l0
  %t198 = insertvalue %MethodParseResult undef, %Parser* null, 0
  %t199 = load %MethodDeclaration, %MethodDeclaration* %l20
  %t200 = insertvalue %MethodParseResult %t198, %MethodDeclaration* null, 1
  %t201 = insertvalue %MethodParseResult %t200, i1 1, 2
  ret %MethodParseResult %t201
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
  %t149 = phi %Parser [ %t5, %entry ], [ %t147, %loop.latch2 ]
  %t150 = phi { %Decorator*, i64 }* [ %t6, %entry ], [ %t148, %loop.latch2 ]
  store %Parser %t149, %Parser* %l0
  store { %Decorator*, i64 }* %t150, { %Decorator*, i64 }** %l1
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
  %t14 = getelementptr inbounds %TokenKind, %TokenKind* %t13, i32 0, i32 0
  %t15 = load i32, i32* %t14
  %t16 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t17 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t15, 0
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t15, 1
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t15, 2
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t15, 3
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t15, 4
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t15, 5
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t15, 6
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t15, 7
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %s41 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.41, i32 0, i32 0
  %t42 = icmp ne i8* %t40, %s41
  br label %logical_or_entry_11

logical_or_entry_11:
  br i1 %t42, label %logical_or_merge_11, label %logical_or_right_11

logical_or_right_11:
  %t43 = load %Token, %Token* %l2
  %t44 = extractvalue %Token %t43, 0
  %t45 = getelementptr inbounds %TokenKind, %TokenKind* %t44, i32 0, i32 0
  %t46 = load i32, i32* %t45
  %t47 = load %Parser, %Parser* %l0
  store %Parser %t47, %Parser* %l3
  %t48 = load %Parser, %Parser* %l0
  %t49 = call %Parser @parser_advance_raw(%Parser %t48)
  store %Parser %t49, %Parser* %l0
  %t50 = load %Parser, %Parser* %l0
  %t51 = call %Parser @skip_trivia(%Parser %t50)
  store %Parser %t51, %Parser* %l0
  %t52 = load %Parser, %Parser* %l0
  %t53 = call %Token @parser_peek_raw(%Parser %t52)
  store %Token %t53, %Token* %l4
  %t54 = load %Token, %Token* %l4
  %t55 = extractvalue %Token %t54, 0
  %t56 = getelementptr inbounds %TokenKind, %TokenKind* %t55, i32 0, i32 0
  %t57 = load i32, i32* %t56
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
  %s83 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.83, i32 0, i32 0
  %t84 = icmp ne i8* %t82, %s83
  %t85 = load %Parser, %Parser* %l0
  %t86 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l1
  %t87 = load %Token, %Token* %l2
  %t88 = load %Parser, %Parser* %l3
  %t89 = load %Token, %Token* %l4
  br i1 %t84, label %then4, label %merge5
then4:
  %t90 = load %Parser, %Parser* %l3
  store %Parser %t90, %Parser* %l0
  br label %afterloop3
merge5:
  %t91 = load %Token, %Token* %l4
  %t92 = call i8* @identifier_text(%Token %t91)
  store i8* %t92, i8** %l5
  %t93 = load %Parser, %Parser* %l0
  %t94 = call %Parser @parser_advance_raw(%Parser %t93)
  store %Parser %t94, %Parser* %l0
  %t95 = load %Parser, %Parser* %l0
  %t96 = call %Parser @skip_trivia(%Parser %t95)
  store %Parser %t96, %Parser* %l0
  %t97 = alloca [0 x %DecoratorArgument]
  %t98 = getelementptr [0 x %DecoratorArgument], [0 x %DecoratorArgument]* %t97, i32 0, i32 0
  %t99 = alloca { %DecoratorArgument*, i64 }
  %t100 = getelementptr { %DecoratorArgument*, i64 }, { %DecoratorArgument*, i64 }* %t99, i32 0, i32 0
  store %DecoratorArgument* %t98, %DecoratorArgument** %t100
  %t101 = getelementptr { %DecoratorArgument*, i64 }, { %DecoratorArgument*, i64 }* %t99, i32 0, i32 1
  store i64 0, i64* %t101
  store { %DecoratorArgument*, i64 }* %t99, { %DecoratorArgument*, i64 }** %l6
  %t102 = load %Parser, %Parser* %l0
  %t103 = call %Token @parser_peek_raw(%Parser %t102)
  store %Token %t103, %Token* %l7
  %t105 = load %Token, %Token* %l7
  %t106 = extractvalue %Token %t105, 0
  %t107 = getelementptr inbounds %TokenKind, %TokenKind* %t106, i32 0, i32 0
  %t108 = load i32, i32* %t107
  %t109 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t110 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t108, 0
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t108, 1
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %t116 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t108, 2
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %t119 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t108, 3
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %t122 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t123 = icmp eq i32 %t108, 4
  %t124 = select i1 %t123, i8* %t122, i8* %t121
  %t125 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t126 = icmp eq i32 %t108, 5
  %t127 = select i1 %t126, i8* %t125, i8* %t124
  %t128 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t129 = icmp eq i32 %t108, 6
  %t130 = select i1 %t129, i8* %t128, i8* %t127
  %t131 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t132 = icmp eq i32 %t108, 7
  %t133 = select i1 %t132, i8* %t131, i8* %t130
  %s134 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.134, i32 0, i32 0
  %t135 = icmp eq i8* %t133, %s134
  br label %logical_and_entry_104

logical_and_entry_104:
  br i1 %t135, label %logical_and_right_104, label %logical_and_merge_104

logical_and_right_104:
  %t136 = load %Token, %Token* %l7
  %t137 = extractvalue %Token %t136, 0
  %t138 = getelementptr inbounds %TokenKind, %TokenKind* %t137, i32 0, i32 0
  %t139 = load i32, i32* %t138
  %t140 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l1
  %t141 = load i8*, i8** %l5
  %t142 = insertvalue %Decorator undef, i8* %t141, 0
  %t143 = load { %DecoratorArgument*, i64 }*, { %DecoratorArgument*, i64 }** %l6
  %t144 = bitcast { %DecoratorArgument*, i64 }* %t143 to { %DecoratorArgument**, i64 }*
  %t145 = insertvalue %Decorator %t142, { %DecoratorArgument**, i64 }* %t144, 1
  %t146 = call { %Decorator*, i64 }* @append_decorator({ %Decorator*, i64 }* %t140, %Decorator %t145)
  store { %Decorator*, i64 }* %t146, { %Decorator*, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t147 = load %Parser, %Parser* %l0
  %t148 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t151 = load %Parser, %Parser* %l0
  %t152 = insertvalue %DecoratorParseResult undef, %Parser* null, 0
  %t153 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l1
  %t154 = bitcast { %Decorator*, i64 }* %t153 to { %Decorator**, i64 }*
  %t155 = insertvalue %DecoratorParseResult %t152, { %Decorator**, i64 }* %t154, 1
  ret %DecoratorParseResult %t155
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
  %t6 = getelementptr inbounds %TokenKind, %TokenKind* %t5, i32 0, i32 0
  %t7 = load i32, i32* %t6
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
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t34, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %t35 = load %Token, %Token* %l1
  %t36 = extractvalue %Token %t35, 0
  %t37 = getelementptr inbounds %TokenKind, %TokenKind* %t36, i32 0, i32 0
  %t38 = load i32, i32* %t37
  %t39 = load %Parser, %Parser* %l0
  %t40 = call %Parser @parser_advance_raw(%Parser %t39)
  store %Parser %t40, %Parser* %l0
  %t41 = alloca [0 x %Token]
  %t42 = getelementptr [0 x %Token], [0 x %Token]* %t41, i32 0, i32 0
  %t43 = alloca { %Token*, i64 }
  %t44 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t43, i32 0, i32 0
  store %Token* %t42, %Token** %t44
  %t45 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t43, i32 0, i32 1
  store i64 0, i64* %t45
  store { %Token*, i64 }* %t43, { %Token*, i64 }** %l2
  %t46 = sitofp i64 1 to double
  store double %t46, double* %l3
  %t47 = load %Parser, %Parser* %l0
  %t48 = load %Token, %Token* %l1
  %t49 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t50 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t137 = phi { %Token*, i64 }* [ %t49, %entry ], [ %t135, %loop.latch2 ]
  %t138 = phi %Parser [ %t47, %entry ], [ %t136, %loop.latch2 ]
  store { %Token*, i64 }* %t137, { %Token*, i64 }** %l2
  store %Parser %t138, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t51 = load %Parser, %Parser* %l0
  %t52 = call %Token @parser_peek_raw(%Parser %t51)
  store %Token %t52, %Token* %l4
  %t53 = load %Token, %Token* %l4
  %t54 = extractvalue %Token %t53, 0
  %t55 = getelementptr inbounds %TokenKind, %TokenKind* %t54, i32 0, i32 0
  %t56 = load i32, i32* %t55
  %t57 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t58 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t56, 0
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t56, 1
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t56, 2
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t56, 3
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t56, 4
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t56, 5
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %t76 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t56, 6
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %t79 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t56, 7
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %s82 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.82, i32 0, i32 0
  %t83 = icmp eq i8* %t81, %s82
  %t84 = load %Parser, %Parser* %l0
  %t85 = load %Token, %Token* %l1
  %t86 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t87 = load double, double* %l3
  %t88 = load %Token, %Token* %l4
  br i1 %t83, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t89 = load %Token, %Token* %l4
  %t90 = extractvalue %Token %t89, 0
  %t91 = getelementptr inbounds %TokenKind, %TokenKind* %t90, i32 0, i32 0
  %t92 = load i32, i32* %t91
  %t93 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t94 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t92, 0
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t92, 1
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %t100 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t92, 2
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %t103 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t104 = icmp eq i32 %t92, 3
  %t105 = select i1 %t104, i8* %t103, i8* %t102
  %t106 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t107 = icmp eq i32 %t92, 4
  %t108 = select i1 %t107, i8* %t106, i8* %t105
  %t109 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t110 = icmp eq i32 %t92, 5
  %t111 = select i1 %t110, i8* %t109, i8* %t108
  %t112 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t113 = icmp eq i32 %t92, 6
  %t114 = select i1 %t113, i8* %t112, i8* %t111
  %t115 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t116 = icmp eq i32 %t92, 7
  %t117 = select i1 %t116, i8* %t115, i8* %t114
  %s118 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.118, i32 0, i32 0
  %t119 = icmp eq i8* %t117, %s118
  %t120 = load %Parser, %Parser* %l0
  %t121 = load %Token, %Token* %l1
  %t122 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t123 = load double, double* %l3
  %t124 = load %Token, %Token* %l4
  br i1 %t119, label %then6, label %merge7
then6:
  %t125 = load %Token, %Token* %l4
  %t126 = extractvalue %Token %t125, 0
  %t127 = getelementptr inbounds %TokenKind, %TokenKind* %t126, i32 0, i32 0
  %t128 = load i32, i32* %t127
  store double 0.0, double* %l5
  %t129 = load double, double* %l5
  br label %merge7
merge7:
  %t130 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t131 = load %Token, %Token* %l4
  %t132 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t130, %Token %t131)
  store { %Token*, i64 }* %t132, { %Token*, i64 }** %l2
  %t133 = load %Parser, %Parser* %l0
  %t134 = call %Parser @parser_advance_raw(%Parser %t133)
  store %Parser %t134, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t135 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t136 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t139 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t140 = call { i8**, i64 }* @split_token_slices_by_comma({ %Token*, i64 }* %t139)
  store { i8**, i64 }* %t140, { i8**, i64 }** %l6
  %t141 = alloca [0 x %TypeParameter]
  %t142 = getelementptr [0 x %TypeParameter], [0 x %TypeParameter]* %t141, i32 0, i32 0
  %t143 = alloca { %TypeParameter*, i64 }
  %t144 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %t143, i32 0, i32 0
  store %TypeParameter* %t142, %TypeParameter** %t144
  %t145 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %t143, i32 0, i32 1
  store i64 0, i64* %t145
  store { %TypeParameter*, i64 }* %t143, { %TypeParameter*, i64 }** %l7
  %t146 = sitofp i64 0 to double
  store double %t146, double* %l8
  %t147 = load %Parser, %Parser* %l0
  %t148 = load %Token, %Token* %l1
  %t149 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t150 = load double, double* %l3
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t152 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l7
  %t153 = load double, double* %l8
  br label %loop.header8
loop.header8:
  %t295 = phi { %TypeParameter*, i64 }* [ %t152, %entry ], [ %t293, %loop.latch10 ]
  %t296 = phi double [ %t153, %entry ], [ %t294, %loop.latch10 ]
  store { %TypeParameter*, i64 }* %t295, { %TypeParameter*, i64 }** %l7
  store double %t296, double* %l8
  br label %loop.body9
loop.body9:
  %t154 = load double, double* %l8
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t156 = load { i8**, i64 }, { i8**, i64 }* %t155
  %t157 = extractvalue { i8**, i64 } %t156, 1
  %t158 = sitofp i64 %t157 to double
  %t159 = fcmp oge double %t154, %t158
  %t160 = load %Parser, %Parser* %l0
  %t161 = load %Token, %Token* %l1
  %t162 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t163 = load double, double* %l3
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t165 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l7
  %t166 = load double, double* %l8
  br i1 %t159, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t168 = load double, double* %l8
  %t169 = fptosi double %t168 to i64
  %t170 = load { i8**, i64 }, { i8**, i64 }* %t167
  %t171 = extractvalue { i8**, i64 } %t170, 0
  %t172 = extractvalue { i8**, i64 } %t170, 1
  %t173 = icmp uge i64 %t169, %t172
  ; bounds check: %t173 (if true, out of bounds)
  %t174 = getelementptr i8*, i8** %t171, i64 %t169
  %t175 = load i8*, i8** %t174
  %t176 = bitcast i8* %t175 to { %Token*, i64 }*
  %t177 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t176)
  store { %Token*, i64 }* %t177, { %Token*, i64 }** %l9
  %t178 = load { %Token*, i64 }*, { %Token*, i64 }** %l9
  %t179 = load { %Token*, i64 }, { %Token*, i64 }* %t178
  %t180 = extractvalue { %Token*, i64 } %t179, 1
  %t181 = icmp sgt i64 %t180, 0
  %t182 = load %Parser, %Parser* %l0
  %t183 = load %Token, %Token* %l1
  %t184 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t185 = load double, double* %l3
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t187 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l7
  %t188 = load double, double* %l8
  %t189 = load { %Token*, i64 }*, { %Token*, i64 }** %l9
  br i1 %t181, label %then14, label %merge15
then14:
  %t190 = load { %Token*, i64 }*, { %Token*, i64 }** %l9
  %t191 = alloca [2 x i8], align 1
  %t192 = getelementptr [2 x i8], [2 x i8]* %t191, i32 0, i32 0
  store i8 58, i8* %t192
  %t193 = getelementptr [2 x i8], [2 x i8]* %t191, i32 0, i32 1
  store i8 0, i8* %t193
  %t194 = getelementptr [2 x i8], [2 x i8]* %t191, i32 0, i32 0
  %t195 = call double @find_top_level_symbol({ %Token*, i64 }* %t190, i8* %t194)
  store double %t195, double* %l10
  %t196 = load { %Token*, i64 }*, { %Token*, i64 }** %l9
  store { %Token*, i64 }* %t196, { %Token*, i64 }** %l11
  %t197 = alloca [0 x %Token]
  %t198 = getelementptr [0 x %Token], [0 x %Token]* %t197, i32 0, i32 0
  %t199 = alloca { %Token*, i64 }
  %t200 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t199, i32 0, i32 0
  store %Token* %t198, %Token** %t200
  %t201 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t199, i32 0, i32 1
  store i64 0, i64* %t201
  store { %Token*, i64 }* %t199, { %Token*, i64 }** %l12
  %t202 = load double, double* %l10
  %t203 = sitofp i64 -1 to double
  %t204 = fcmp une double %t202, %t203
  %t205 = load %Parser, %Parser* %l0
  %t206 = load %Token, %Token* %l1
  %t207 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t208 = load double, double* %l3
  %t209 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t210 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l7
  %t211 = load double, double* %l8
  %t212 = load { %Token*, i64 }*, { %Token*, i64 }** %l9
  %t213 = load double, double* %l10
  %t214 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t215 = load { %Token*, i64 }*, { %Token*, i64 }** %l12
  br i1 %t204, label %then16, label %merge17
then16:
  %t216 = load { %Token*, i64 }*, { %Token*, i64 }** %l9
  %t217 = load double, double* %l10
  %t218 = sitofp i64 0 to double
  %t219 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t216, double %t218, double %t217)
  store { %Token*, i64 }* %t219, { %Token*, i64 }** %l11
  %t220 = load { %Token*, i64 }*, { %Token*, i64 }** %l9
  %t221 = load double, double* %l10
  %t222 = sitofp i64 1 to double
  %t223 = fadd double %t221, %t222
  %t224 = load { %Token*, i64 }*, { %Token*, i64 }** %l9
  %t225 = load { %Token*, i64 }, { %Token*, i64 }* %t224
  %t226 = extractvalue { %Token*, i64 } %t225, 1
  %t227 = sitofp i64 %t226 to double
  %t228 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t220, double %t223, double %t227)
  store { %Token*, i64 }* %t228, { %Token*, i64 }** %l12
  br label %merge17
merge17:
  %t229 = phi { %Token*, i64 }* [ %t219, %then16 ], [ %t214, %then14 ]
  %t230 = phi { %Token*, i64 }* [ %t228, %then16 ], [ %t215, %then14 ]
  store { %Token*, i64 }* %t229, { %Token*, i64 }** %l11
  store { %Token*, i64 }* %t230, { %Token*, i64 }** %l12
  %t231 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t232 = call i8* @tokens_to_text({ %Token*, i64 }* %t231)
  %t233 = call i8* @trim_text(i8* %t232)
  store i8* %t233, i8** %l13
  %t234 = load i8*, i8** %l13
  %t235 = call i64 @sailfin_runtime_string_length(i8* %t234)
  %t236 = icmp sgt i64 %t235, 0
  %t237 = load %Parser, %Parser* %l0
  %t238 = load %Token, %Token* %l1
  %t239 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t240 = load double, double* %l3
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t242 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l7
  %t243 = load double, double* %l8
  %t244 = load { %Token*, i64 }*, { %Token*, i64 }** %l9
  %t245 = load double, double* %l10
  %t246 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t247 = load { %Token*, i64 }*, { %Token*, i64 }** %l12
  %t248 = load i8*, i8** %l13
  br i1 %t236, label %then18, label %merge19
then18:
  store i8* null, i8** %l14
  %t249 = load { %Token*, i64 }*, { %Token*, i64 }** %l12
  %t250 = call i8* @tokens_to_text({ %Token*, i64 }* %t249)
  %t251 = call i8* @trim_text(i8* %t250)
  store i8* %t251, i8** %l15
  %t253 = load { %Token*, i64 }*, { %Token*, i64 }** %l12
  %t254 = load { %Token*, i64 }, { %Token*, i64 }* %t253
  %t255 = extractvalue { %Token*, i64 } %t254, 1
  %t256 = icmp sgt i64 %t255, 0
  br label %logical_and_entry_252

logical_and_entry_252:
  br i1 %t256, label %logical_and_right_252, label %logical_and_merge_252

logical_and_right_252:
  %t257 = load i8*, i8** %l15
  %t258 = call i64 @sailfin_runtime_string_length(i8* %t257)
  %t259 = icmp sgt i64 %t258, 0
  br label %logical_and_right_end_252

logical_and_right_end_252:
  br label %logical_and_merge_252

logical_and_merge_252:
  %t260 = phi i1 [ false, %logical_and_entry_252 ], [ %t259, %logical_and_right_end_252 ]
  %t261 = load %Parser, %Parser* %l0
  %t262 = load %Token, %Token* %l1
  %t263 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t264 = load double, double* %l3
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t266 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l7
  %t267 = load double, double* %l8
  %t268 = load { %Token*, i64 }*, { %Token*, i64 }** %l9
  %t269 = load double, double* %l10
  %t270 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t271 = load { %Token*, i64 }*, { %Token*, i64 }** %l12
  %t272 = load i8*, i8** %l13
  %t273 = load i8*, i8** %l14
  %t274 = load i8*, i8** %l15
  br i1 %t260, label %then20, label %merge21
then20:
  %t275 = load i8*, i8** %l15
  %t276 = insertvalue %TypeAnnotation undef, i8* %t275, 0
  store i8* null, i8** %l14
  br label %merge21
merge21:
  %t277 = phi i8* [ null, %then20 ], [ %t273, %then18 ]
  store i8* %t277, i8** %l14
  %t278 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t279 = call double @source_span_from_tokens({ %Token*, i64 }* %t278)
  store double %t279, double* %l16
  %t280 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l7
  %t281 = load i8*, i8** %l13
  %t282 = insertvalue %TypeParameter undef, i8* %t281, 0
  %t283 = load i8*, i8** %l14
  %t284 = bitcast i8* %t283 to %TypeAnnotation*
  %t285 = insertvalue %TypeParameter %t282, %TypeAnnotation* %t284, 1
  %t286 = load double, double* %l16
  %t287 = insertvalue %TypeParameter %t285, %SourceSpan* null, 2
  br label %merge19
merge19:
  %t288 = phi { %TypeParameter*, i64 }* [ null, %then18 ], [ %t242, %then14 ]
  store { %TypeParameter*, i64 }* %t288, { %TypeParameter*, i64 }** %l7
  br label %merge15
merge15:
  %t289 = phi { %TypeParameter*, i64 }* [ null, %then14 ], [ %t187, %loop.body9 ]
  store { %TypeParameter*, i64 }* %t289, { %TypeParameter*, i64 }** %l7
  %t290 = load double, double* %l8
  %t291 = sitofp i64 1 to double
  %t292 = fadd double %t290, %t291
  store double %t292, double* %l8
  br label %loop.latch10
loop.latch10:
  %t293 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l7
  %t294 = load double, double* %l8
  br label %loop.header8
afterloop11:
  %t297 = load %Parser, %Parser* %l0
  %t298 = insertvalue %TypeParameterParseResult undef, %Parser* null, 0
  %t299 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l7
  %t300 = bitcast { %TypeParameter*, i64 }* %t299 to { %TypeParameter**, i64 }*
  %t301 = insertvalue %TypeParameterParseResult %t298, { %TypeParameter**, i64 }* %t300, 1
  ret %TypeParameterParseResult %t301
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
  %t7 = insertvalue %ImplementsParseResult undef, %Parser* null, 0
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
  store %Parser zeroinitializer, %Parser* %l0
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
  %t89 = insertvalue %ImplementsParseResult undef, %Parser* null, 0
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
  %t36 = getelementptr inbounds %TokenKind, %TokenKind* %t35, i32 0, i32 0
  %t37 = load i32, i32* %t36
  %t38 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t39 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t40 = icmp eq i32 %t37, 0
  %t41 = select i1 %t40, i8* %t39, i8* %t38
  %t42 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t43 = icmp eq i32 %t37, 1
  %t44 = select i1 %t43, i8* %t42, i8* %t41
  %t45 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t46 = icmp eq i32 %t37, 2
  %t47 = select i1 %t46, i8* %t45, i8* %t44
  %t48 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t49 = icmp eq i32 %t37, 3
  %t50 = select i1 %t49, i8* %t48, i8* %t47
  %t51 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t52 = icmp eq i32 %t37, 4
  %t53 = select i1 %t52, i8* %t51, i8* %t50
  %t54 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t55 = icmp eq i32 %t37, 5
  %t56 = select i1 %t55, i8* %t54, i8* %t53
  %t57 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t58 = icmp eq i32 %t37, 6
  %t59 = select i1 %t58, i8* %t57, i8* %t56
  %t60 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t61 = icmp eq i32 %t37, 7
  %t62 = select i1 %t61, i8* %t60, i8* %t59
  %s63 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.63, i32 0, i32 0
  %t64 = icmp eq i8* %t62, %s63
  br label %logical_and_entry_33

logical_and_entry_33:
  br i1 %t64, label %logical_and_right_33, label %logical_and_merge_33

logical_and_right_33:
  %t65 = load %Token, %Token* %l8
  %t66 = extractvalue %Token %t65, 0
  %t67 = getelementptr inbounds %TokenKind, %TokenKind* %t66, i32 0, i32 0
  %t68 = load i32, i32* %t67
  store i8* null, i8** %l9
  %t69 = load %Parser, %Parser* %l0
  %t70 = call %Parser @skip_trivia(%Parser %t69)
  store %Parser %t70, %Parser* %l0
  %t71 = load %Parser, %Parser* %l0
  %t72 = call %Token @parser_peek_raw(%Parser %t71)
  store %Token %t72, %Token* %l10
  %t74 = load %Token, %Token* %l10
  %t75 = extractvalue %Token %t74, 0
  %t76 = getelementptr inbounds %TokenKind, %TokenKind* %t75, i32 0, i32 0
  %t77 = load i32, i32* %t76
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
  br label %logical_and_entry_73

logical_and_entry_73:
  br i1 %t104, label %logical_and_right_73, label %logical_and_merge_73

logical_and_right_73:
  %t105 = load %Token, %Token* %l10
  %t106 = extractvalue %Token %t105, 0
  %t107 = getelementptr inbounds %TokenKind, %TokenKind* %t106, i32 0, i32 0
  %t108 = load i32, i32* %t107
  %t109 = load %Parser, %Parser* %l0
  %t110 = extractvalue %Parser %t109, 1
  store double %t110, double* %l11
  %t111 = load { %Token**, i64 }*, { %Token**, i64 }** %l1
  %t112 = load double, double* %l2
  %t113 = load double, double* %l11
  %t114 = bitcast { %Token**, i64 }* %t111 to { %Token*, i64 }*
  %t115 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t114, double %t112, double %t113)
  store { %Token*, i64 }* %t115, { %Token*, i64 }** %l12
  %t116 = load { %Token*, i64 }*, { %Token*, i64 }** %l12
  %t117 = call double @source_span_from_tokens({ %Token*, i64 }* %t116)
  store double %t117, double* %l13
  %t118 = load i8*, i8** %l6
  %t119 = insertvalue %Parameter undef, i8* %t118, 0
  %t120 = load i8*, i8** %l7
  %t121 = bitcast i8* %t120 to %TypeAnnotation*
  %t122 = insertvalue %Parameter %t119, %TypeAnnotation* %t121, 1
  %t123 = load i8*, i8** %l9
  %t124 = bitcast i8* %t123 to %Expression*
  %t125 = insertvalue %Parameter %t122, %Expression* %t124, 2
  %t126 = load i1, i1* %l3
  %t127 = insertvalue %Parameter %t125, i1 %t126, 3
  %t128 = load double, double* %l13
  %t129 = insertvalue %Parameter %t127, %SourceSpan* null, 4
  store %Parameter %t129, %Parameter* %l14
  %t130 = load %Parser, %Parser* %l0
  %t131 = insertvalue %ParameterParseResult undef, %Parser* null, 0
  %t132 = load %Parameter, %Parameter* %l14
  %t133 = insertvalue %ParameterParseResult %t131, %Parameter* null, 1
  ret %ParameterParseResult %t133
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
  %t7 = getelementptr inbounds %TokenKind, %TokenKind* %t6, i32 0, i32 0
  %t8 = load i32, i32* %t7
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
  %t35 = icmp ne i8* %t33, %s34
  br label %logical_or_entry_4

logical_or_entry_4:
  br i1 %t35, label %logical_or_merge_4, label %logical_or_right_4

logical_or_right_4:
  %t36 = load %Token, %Token* %l1
  %t37 = extractvalue %Token %t36, 0
  %t38 = getelementptr inbounds %TokenKind, %TokenKind* %t37, i32 0, i32 0
  %t39 = load i32, i32* %t38
  %t40 = load %Parser, %Parser* %l0
  %t41 = call %Parser @parser_advance_raw(%Parser %t40)
  store %Parser %t41, %Parser* %l0
  %t42 = load %Parser, %Parser* %l0
  %t43 = call %Parser @skip_trivia(%Parser %t42)
  store %Parser %t43, %Parser* %l0
  %t44 = load %Parser, %Parser* %l0
  %t45 = alloca [2 x i8], align 1
  %t46 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 0
  store i8 91, i8* %t46
  %t47 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 1
  store i8 0, i8* %t47
  %t48 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 0
  %t49 = call %Parser @consume_symbol(%Parser %t44, i8* %t48)
  store %Parser %t49, %Parser* %l0
  %t50 = alloca [0 x i8*]
  %t51 = getelementptr [0 x i8*], [0 x i8*]* %t50, i32 0, i32 0
  %t52 = alloca { i8**, i64 }
  %t53 = getelementptr { i8**, i64 }, { i8**, i64 }* %t52, i32 0, i32 0
  store i8** %t51, i8*** %t53
  %t54 = getelementptr { i8**, i64 }, { i8**, i64 }* %t52, i32 0, i32 1
  store i64 0, i64* %t54
  store { i8**, i64 }* %t52, { i8**, i64 }** %l2
  %t55 = load %Parser, %Parser* %l0
  %t56 = call %Parser @skip_trivia(%Parser %t55)
  store %Parser %t56, %Parser* %l0
  %t57 = load %Parser, %Parser* %l0
  %t58 = load %Token, %Token* %l1
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %loop.header0
loop.header0:
  %t186 = phi { i8**, i64 }* [ %t59, %entry ], [ %t184, %loop.latch2 ]
  %t187 = phi %Parser [ %t57, %entry ], [ %t185, %loop.latch2 ]
  store { i8**, i64 }* %t186, { i8**, i64 }** %l2
  store %Parser %t187, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t60 = load %Parser, %Parser* %l0
  %t61 = call %Token @parser_peek_raw(%Parser %t60)
  store %Token %t61, %Token* %l3
  %t63 = load %Token, %Token* %l3
  %t64 = extractvalue %Token %t63, 0
  %t65 = getelementptr inbounds %TokenKind, %TokenKind* %t64, i32 0, i32 0
  %t66 = load i32, i32* %t65
  %t67 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t68 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t66, 0
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t66, 1
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t75 = icmp eq i32 %t66, 2
  %t76 = select i1 %t75, i8* %t74, i8* %t73
  %t77 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t78 = icmp eq i32 %t66, 3
  %t79 = select i1 %t78, i8* %t77, i8* %t76
  %t80 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t81 = icmp eq i32 %t66, 4
  %t82 = select i1 %t81, i8* %t80, i8* %t79
  %t83 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t84 = icmp eq i32 %t66, 5
  %t85 = select i1 %t84, i8* %t83, i8* %t82
  %t86 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t87 = icmp eq i32 %t66, 6
  %t88 = select i1 %t87, i8* %t86, i8* %t85
  %t89 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t90 = icmp eq i32 %t66, 7
  %t91 = select i1 %t90, i8* %t89, i8* %t88
  %s92 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.92, i32 0, i32 0
  %t93 = icmp eq i8* %t91, %s92
  br label %logical_and_entry_62

logical_and_entry_62:
  br i1 %t93, label %logical_and_right_62, label %logical_and_merge_62

logical_and_right_62:
  %t94 = load %Token, %Token* %l3
  %t95 = extractvalue %Token %t94, 0
  %t96 = getelementptr inbounds %TokenKind, %TokenKind* %t95, i32 0, i32 0
  %t97 = load i32, i32* %t96
  %t98 = load %Token, %Token* %l3
  %t99 = extractvalue %Token %t98, 0
  %t100 = getelementptr inbounds %TokenKind, %TokenKind* %t99, i32 0, i32 0
  %t101 = load i32, i32* %t100
  %t102 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t103 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t104 = icmp eq i32 %t101, 0
  %t105 = select i1 %t104, i8* %t103, i8* %t102
  %t106 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t107 = icmp eq i32 %t101, 1
  %t108 = select i1 %t107, i8* %t106, i8* %t105
  %t109 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t110 = icmp eq i32 %t101, 2
  %t111 = select i1 %t110, i8* %t109, i8* %t108
  %t112 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t113 = icmp eq i32 %t101, 3
  %t114 = select i1 %t113, i8* %t112, i8* %t111
  %t115 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t116 = icmp eq i32 %t101, 4
  %t117 = select i1 %t116, i8* %t115, i8* %t114
  %t118 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t119 = icmp eq i32 %t101, 5
  %t120 = select i1 %t119, i8* %t118, i8* %t117
  %t121 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t122 = icmp eq i32 %t101, 6
  %t123 = select i1 %t122, i8* %t121, i8* %t120
  %t124 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t125 = icmp eq i32 %t101, 7
  %t126 = select i1 %t125, i8* %t124, i8* %t123
  %s127 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.127, i32 0, i32 0
  %t128 = icmp eq i8* %t126, %s127
  %t129 = load %Parser, %Parser* %l0
  %t130 = load %Token, %Token* %l1
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t132 = load %Token, %Token* %l3
  br i1 %t128, label %then4, label %merge5
then4:
  %t133 = load %Token, %Token* %l3
  %t134 = call i8* @identifier_text(%Token %t133)
  store i8* %t134, i8** %l4
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t136 = load i8*, i8** %l4
  %t137 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t135, i8* %t136)
  store { i8**, i64 }* %t137, { i8**, i64 }** %l2
  %t138 = load %Parser, %Parser* %l0
  %t139 = call %Parser @parser_advance_raw(%Parser %t138)
  store %Parser %t139, %Parser* %l0
  %t140 = load %Parser, %Parser* %l0
  %t141 = call %Parser @skip_trivia(%Parser %t140)
  store %Parser %t141, %Parser* %l0
  %t142 = load %Parser, %Parser* %l0
  %t143 = call %Token @parser_peek_raw(%Parser %t142)
  store %Token %t143, %Token* %l5
  %t145 = load %Token, %Token* %l5
  %t146 = extractvalue %Token %t145, 0
  %t147 = getelementptr inbounds %TokenKind, %TokenKind* %t146, i32 0, i32 0
  %t148 = load i32, i32* %t147
  %t149 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t150 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t148, 0
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t148, 1
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t148, 2
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t148, 3
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %t162 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t148, 4
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t148, 5
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %t168 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t169 = icmp eq i32 %t148, 6
  %t170 = select i1 %t169, i8* %t168, i8* %t167
  %t171 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t172 = icmp eq i32 %t148, 7
  %t173 = select i1 %t172, i8* %t171, i8* %t170
  %s174 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.174, i32 0, i32 0
  %t175 = icmp eq i8* %t173, %s174
  br label %logical_and_entry_144

logical_and_entry_144:
  br i1 %t175, label %logical_and_right_144, label %logical_and_merge_144

logical_and_right_144:
  %t176 = load %Token, %Token* %l5
  %t177 = extractvalue %Token %t176, 0
  %t178 = getelementptr inbounds %TokenKind, %TokenKind* %t177, i32 0, i32 0
  %t179 = load i32, i32* %t178
  br label %loop.latch2
merge5:
  %t180 = load %Parser, %Parser* %l0
  %t181 = call %Parser @parser_advance_raw(%Parser %t180)
  store %Parser %t181, %Parser* %l0
  %t182 = load %Parser, %Parser* %l0
  %t183 = call %Parser @skip_trivia(%Parser %t182)
  store %Parser %t183, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t185 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t188 = load %Parser, %Parser* %l0
  %t189 = insertvalue %EffectParseResult undef, %Parser* null, 0
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t191 = insertvalue %EffectParseResult %t189, { i8**, i64 }* %t190, 1
  ret %EffectParseResult %t191
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
  %t7 = getelementptr inbounds %TokenKind, %TokenKind* %t6, i32 0, i32 0
  %t8 = load i32, i32* %t7
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
  %t35 = icmp ne i8* %t33, %s34
  br label %logical_or_entry_4

logical_or_entry_4:
  br i1 %t35, label %logical_or_merge_4, label %logical_or_right_4

logical_or_right_4:
  %t36 = load %Token, %Token* %l1
  %t37 = extractvalue %Token %t36, 0
  %t38 = getelementptr inbounds %TokenKind, %TokenKind* %t37, i32 0, i32 0
  %t39 = load i32, i32* %t38
  %t40 = load %Parser, %Parser* %l0
  %t41 = extractvalue %Parser %t40, 1
  store double %t41, double* %l2
  %t42 = load %Parser, %Parser* %l0
  %t43 = call %Parser @parser_advance_raw(%Parser %t42)
  store %Parser %t43, %Parser* %l3
  %t44 = load double, double* %l2
  store double %t44, double* %l4
  %t45 = alloca [0 x %Statement]
  %t46 = getelementptr [0 x %Statement], [0 x %Statement]* %t45, i32 0, i32 0
  %t47 = alloca { %Statement*, i64 }
  %t48 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t47, i32 0, i32 0
  store %Statement* %t46, %Statement** %t48
  %t49 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t47, i32 0, i32 1
  store i64 0, i64* %t49
  store { %Statement*, i64 }* %t47, { %Statement*, i64 }** %l5
  %t50 = load %Parser, %Parser* %l0
  %t51 = load %Token, %Token* %l1
  %t52 = load double, double* %l2
  %t53 = load %Parser, %Parser* %l3
  %t54 = load double, double* %l4
  %t55 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  br label %loop.header0
loop.header0:
  %t267 = phi %Parser [ %t53, %entry ], [ %t265, %loop.latch2 ]
  %t268 = phi { %Statement*, i64 }* [ %t55, %entry ], [ %t266, %loop.latch2 ]
  store %Parser %t267, %Parser* %l3
  store { %Statement*, i64 }* %t268, { %Statement*, i64 }** %l5
  br label %loop.body1
loop.body1:
  %t56 = load %Parser, %Parser* %l3
  %t57 = call %Parser @skip_trivia(%Parser %t56)
  store %Parser %t57, %Parser* %l3
  %t58 = load %Parser, %Parser* %l3
  %t59 = call %Token @parser_peek_raw(%Parser %t58)
  store %Token %t59, %Token* %l6
  %t61 = load %Token, %Token* %l6
  %t62 = extractvalue %Token %t61, 0
  %t63 = getelementptr inbounds %TokenKind, %TokenKind* %t62, i32 0, i32 0
  %t64 = load i32, i32* %t63
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
  %s90 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.90, i32 0, i32 0
  %t91 = icmp eq i8* %t89, %s90
  br label %logical_and_entry_60

logical_and_entry_60:
  br i1 %t91, label %logical_and_right_60, label %logical_and_merge_60

logical_and_right_60:
  %t92 = load %Token, %Token* %l6
  %t93 = extractvalue %Token %t92, 0
  %t94 = getelementptr inbounds %TokenKind, %TokenKind* %t93, i32 0, i32 0
  %t95 = load i32, i32* %t94
  %t96 = load %Token, %Token* %l6
  %t97 = extractvalue %Token %t96, 0
  %t98 = getelementptr inbounds %TokenKind, %TokenKind* %t97, i32 0, i32 0
  %t99 = load i32, i32* %t98
  %t100 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t101 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t99, 0
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t99, 1
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t99, 2
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t99, 3
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t99, 4
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %t116 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t99, 5
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %t119 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t99, 6
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %t122 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t123 = icmp eq i32 %t99, 7
  %t124 = select i1 %t123, i8* %t122, i8* %t121
  %s125 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.125, i32 0, i32 0
  %t126 = icmp eq i8* %t124, %s125
  %t127 = load %Parser, %Parser* %l0
  %t128 = load %Token, %Token* %l1
  %t129 = load double, double* %l2
  %t130 = load %Parser, %Parser* %l3
  %t131 = load double, double* %l4
  %t132 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t133 = load %Token, %Token* %l6
  br i1 %t126, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t134 = load %Parser, %Parser* %l3
  %t135 = call %BlockStatementParseResult @parse_block_statement(%Parser %t134)
  store %BlockStatementParseResult %t135, %BlockStatementParseResult* %l7
  %t136 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  %t137 = extractvalue %BlockStatementParseResult %t136, 2
  %t138 = load %Parser, %Parser* %l0
  %t139 = load %Token, %Token* %l1
  %t140 = load double, double* %l2
  %t141 = load %Parser, %Parser* %l3
  %t142 = load double, double* %l4
  %t143 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t144 = load %Token, %Token* %l6
  %t145 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  br i1 %t137, label %then6, label %merge7
then6:
  %t146 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  %t147 = extractvalue %BlockStatementParseResult %t146, 0
  store %Parser zeroinitializer, %Parser* %l3
  %t148 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  %t149 = extractvalue %BlockStatementParseResult %t148, 1
  %t150 = bitcast i8* null to %Statement*
  br label %loop.latch2
merge7:
  %t151 = load %Parser, %Parser* %l3
  %t152 = extractvalue %Parser %t151, 1
  store double %t152, double* %l8
  %t153 = load %Parser, %Parser* %l3
  %t154 = call %StatementParseResult @parse_unknown(%Parser %t153)
  store %StatementParseResult %t154, %StatementParseResult* %l9
  %t155 = load %StatementParseResult, %StatementParseResult* %l9
  %t156 = extractvalue %StatementParseResult %t155, 0
  store %Parser zeroinitializer, %Parser* %l3
  %t157 = load %StatementParseResult, %StatementParseResult* %l9
  %t158 = extractvalue %StatementParseResult %t157, 1
  %t159 = getelementptr inbounds %Statement, %Statement* %t158, i32 0, i32 0
  %t160 = load i32, i32* %t159
  %t161 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t162 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t160, 0
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t160, 1
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %t168 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t169 = icmp eq i32 %t160, 2
  %t170 = select i1 %t169, i8* %t168, i8* %t167
  %t171 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t172 = icmp eq i32 %t160, 3
  %t173 = select i1 %t172, i8* %t171, i8* %t170
  %t174 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t175 = icmp eq i32 %t160, 4
  %t176 = select i1 %t175, i8* %t174, i8* %t173
  %t177 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t178 = icmp eq i32 %t160, 5
  %t179 = select i1 %t178, i8* %t177, i8* %t176
  %t180 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t181 = icmp eq i32 %t160, 6
  %t182 = select i1 %t181, i8* %t180, i8* %t179
  %t183 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t184 = icmp eq i32 %t160, 7
  %t185 = select i1 %t184, i8* %t183, i8* %t182
  %t186 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t187 = icmp eq i32 %t160, 8
  %t188 = select i1 %t187, i8* %t186, i8* %t185
  %t189 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t190 = icmp eq i32 %t160, 9
  %t191 = select i1 %t190, i8* %t189, i8* %t188
  %t192 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t193 = icmp eq i32 %t160, 10
  %t194 = select i1 %t193, i8* %t192, i8* %t191
  %t195 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t196 = icmp eq i32 %t160, 11
  %t197 = select i1 %t196, i8* %t195, i8* %t194
  %t198 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t199 = icmp eq i32 %t160, 12
  %t200 = select i1 %t199, i8* %t198, i8* %t197
  %t201 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t202 = icmp eq i32 %t160, 13
  %t203 = select i1 %t202, i8* %t201, i8* %t200
  %t204 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t205 = icmp eq i32 %t160, 14
  %t206 = select i1 %t205, i8* %t204, i8* %t203
  %t207 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t208 = icmp eq i32 %t160, 15
  %t209 = select i1 %t208, i8* %t207, i8* %t206
  %t210 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t211 = icmp eq i32 %t160, 16
  %t212 = select i1 %t211, i8* %t210, i8* %t209
  %t213 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t214 = icmp eq i32 %t160, 17
  %t215 = select i1 %t214, i8* %t213, i8* %t212
  %t216 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t217 = icmp eq i32 %t160, 18
  %t218 = select i1 %t217, i8* %t216, i8* %t215
  %t219 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t220 = icmp eq i32 %t160, 19
  %t221 = select i1 %t220, i8* %t219, i8* %t218
  %t222 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t223 = icmp eq i32 %t160, 20
  %t224 = select i1 %t223, i8* %t222, i8* %t221
  %t225 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t226 = icmp eq i32 %t160, 21
  %t227 = select i1 %t226, i8* %t225, i8* %t224
  %t228 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t229 = icmp eq i32 %t160, 22
  %t230 = select i1 %t229, i8* %t228, i8* %t227
  %s231 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.231, i32 0, i32 0
  %t232 = icmp eq i8* %t230, %s231
  %t233 = load %Parser, %Parser* %l0
  %t234 = load %Token, %Token* %l1
  %t235 = load double, double* %l2
  %t236 = load %Parser, %Parser* %l3
  %t237 = load double, double* %l4
  %t238 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t239 = load %Token, %Token* %l6
  %t240 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  %t241 = load double, double* %l8
  %t242 = load %StatementParseResult, %StatementParseResult* %l9
  br i1 %t232, label %then8, label %merge9
then8:
  %t243 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t244 = load %StatementParseResult, %StatementParseResult* %l9
  %t245 = extractvalue %StatementParseResult %t244, 1
  %t246 = call { %Statement*, i64 }* @append_statement({ %Statement*, i64 }* %t243, %Statement zeroinitializer)
  store { %Statement*, i64 }* %t246, { %Statement*, i64 }** %l5
  br label %merge9
merge9:
  %t247 = phi { %Statement*, i64 }* [ %t246, %then8 ], [ %t238, %loop.body1 ]
  store { %Statement*, i64 }* %t247, { %Statement*, i64 }** %l5
  %t248 = load %Parser, %Parser* %l3
  %t249 = extractvalue %Parser %t248, 1
  %t250 = load double, double* %l8
  %t251 = fcmp ole double %t249, %t250
  %t252 = load %Parser, %Parser* %l0
  %t253 = load %Token, %Token* %l1
  %t254 = load double, double* %l2
  %t255 = load %Parser, %Parser* %l3
  %t256 = load double, double* %l4
  %t257 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t258 = load %Token, %Token* %l6
  %t259 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  %t260 = load double, double* %l8
  %t261 = load %StatementParseResult, %StatementParseResult* %l9
  br i1 %t251, label %then10, label %merge11
then10:
  %t262 = load %Parser, %Parser* %l3
  %t263 = call %Parser @parser_advance_raw(%Parser %t262)
  store %Parser %t263, %Parser* %l3
  br label %merge11
merge11:
  %t264 = phi %Parser [ %t263, %then10 ], [ %t255, %loop.body1 ]
  store %Parser %t264, %Parser* %l3
  br label %loop.latch2
loop.latch2:
  %t265 = load %Parser, %Parser* %l3
  %t266 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  br label %loop.header0
afterloop3:
  %t269 = load %Parser, %Parser* %l3
  %t270 = extractvalue %Parser %t269, 1
  store double %t270, double* %l10
  %t271 = load double, double* %l4
  %t272 = load double, double* %l2
  %t273 = fcmp ogt double %t271, %t272
  %t274 = load %Parser, %Parser* %l0
  %t275 = load %Token, %Token* %l1
  %t276 = load double, double* %l2
  %t277 = load %Parser, %Parser* %l3
  %t278 = load double, double* %l4
  %t279 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t280 = load double, double* %l10
  br i1 %t273, label %then12, label %merge13
then12:
  %t281 = load double, double* %l4
  store double %t281, double* %l10
  br label %merge13
merge13:
  %t282 = phi double [ %t281, %then12 ], [ %t280, %entry ]
  store double %t282, double* %l10
  %t283 = load %Parser, %Parser* %l0
  %t284 = extractvalue %Parser %t283, 0
  %t285 = load double, double* %l2
  %t286 = load double, double* %l10
  %t287 = bitcast { %Token**, i64 }* %t284 to { %Token*, i64 }*
  %t288 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t287, double %t285, double %t286)
  store { %Token*, i64 }* %t288, { %Token*, i64 }** %l11
  %t289 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t290 = call { %Token*, i64 }* @trim_block_tokens({ %Token*, i64 }* %t289)
  store { %Token*, i64 }* %t290, { %Token*, i64 }** %l11
  %t291 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t292 = call i8* @tokens_to_text({ %Token*, i64 }* %t291)
  store i8* %t292, i8** %l12
  %t293 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t294 = bitcast { %Token*, i64 }* %t293 to { %Token**, i64 }*
  %t295 = insertvalue %Block undef, { %Token**, i64 }* %t294, 0
  %t296 = load i8*, i8** %l12
  %t297 = insertvalue %Block %t295, i8* %t296, 1
  %t298 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t299 = bitcast { %Statement*, i64 }* %t298 to { %Statement**, i64 }*
  %t300 = insertvalue %Block %t297, { %Statement**, i64 }* %t299, 2
  store %Block %t300, %Block* %l13
  %t301 = load %Parser, %Parser* %l3
  %t302 = call %Parser @skip_trivia(%Parser %t301)
  %t303 = insertvalue %BlockParseResult undef, %Parser* null, 0
  %t304 = load %Block, %Block* %l13
  %t305 = insertvalue %BlockParseResult %t303, %Block* null, 1
  ret %BlockParseResult %t305
}

define %BlockStatementParseResult @parse_block_statement(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %DecoratorParseResult
  %l2 = alloca %Parser*
  %l3 = alloca { %Decorator**, i64 }*
  %l4 = alloca %Parser
  %l5 = alloca %Token
  %l6 = alloca %BlockStatementParseResult
  store %Parser %parser, %Parser* %l0
  %t0 = call %DecoratorParseResult @parse_decorators(%Parser %parser)
  store %DecoratorParseResult %t0, %DecoratorParseResult* %l1
  %t1 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t2 = extractvalue %DecoratorParseResult %t1, 0
  store %Parser* %t2, %Parser** %l2
  %t3 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t4 = extractvalue %DecoratorParseResult %t3, 1
  store { %Decorator**, i64 }* %t4, { %Decorator**, i64 }** %l3
  %t5 = load %Parser*, %Parser** %l2
  %t6 = call %Parser @skip_trivia(%Parser zeroinitializer)
  store %Parser %t6, %Parser* %l4
  %t7 = load %Parser, %Parser* %l4
  %t8 = call %Token @parser_peek_raw(%Parser %t7)
  store %Token %t8, %Token* %l5
  %t9 = load %Token, %Token* %l5
  %s10 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.10, i32 0, i32 0
  %t11 = call i1 @identifier_matches(%Token %t9, i8* %s10)
  %t12 = load %Parser, %Parser* %l0
  %t13 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t14 = load %Parser*, %Parser** %l2
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
  %t27 = load %Parser*, %Parser** %l2
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
  %t40 = load %Parser*, %Parser** %l2
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
  %t50 = load %Parser*, %Parser** %l2
  %t51 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t52 = load %Parser, %Parser* %l4
  %t53 = load %Token, %Token* %l5
  br i1 %t47, label %then6, label %merge7
then6:
  %t54 = load %Parser, %Parser* %l0
  %t55 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
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
  %t66 = load %Parser*, %Parser** %l2
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
  %t76 = load %Parser*, %Parser** %l2
  %t77 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t78 = load %Parser, %Parser* %l4
  %t79 = load %Token, %Token* %l5
  br i1 %t73, label %then10, label %merge11
then10:
  %t80 = load %Parser, %Parser* %l0
  %t81 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
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
  %t92 = load %Parser*, %Parser** %l2
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
  %t105 = load %Parser*, %Parser** %l2
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
  %t118 = load %Parser*, %Parser** %l2
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
  %t131 = load %Parser*, %Parser** %l2
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
  %t144 = load %Parser*, %Parser** %l2
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
  %t154 = load %Parser*, %Parser** %l2
  %t155 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t156 = load %Parser, %Parser* %l4
  %t157 = load %Token, %Token* %l5
  br i1 %t151, label %then22, label %merge23
then22:
  %t158 = load %Parser, %Parser* %l0
  %t159 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
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
  %t173 = load %Parser*, %Parser** %l2
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
  %t180 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
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
  %l11 = alloca %Block*
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
  %t9 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
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
  store %Parser zeroinitializer, %Parser* %l1
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
  %t41 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
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
  %t57 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
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
  %t94 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
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
  %t103 = insertvalue %ForClause undef, %Expression* null, 0
  %t104 = load %Expression, %Expression* %l8
  %t105 = insertvalue %ForClause %t103, %Expression* null, 1
  %t106 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t107 = bitcast { %Token*, i64 }* %t106 to { %Token**, i64 }*
  %t108 = insertvalue %ForClause %t105, { %Token**, i64 }* %t107, 2
  store %ForClause %t108, %ForClause* %l9
  %t109 = load %Parser, %Parser* %l1
  %t110 = call %BlockParseResult @parse_block(%Parser %t109)
  store %BlockParseResult %t110, %BlockParseResult* %l10
  %t111 = load %BlockParseResult, %BlockParseResult* %l10
  %t112 = extractvalue %BlockParseResult %t111, 1
  %t113 = getelementptr %Block, %Block* %t112, i32 0, i32 0
  %t114 = load { %Token**, i64 }*, { %Token**, i64 }** %t113
  %t115 = load { %Token**, i64 }, { %Token**, i64 }* %t114
  %t116 = extractvalue { %Token**, i64 } %t115, 1
  %t117 = icmp eq i64 %t116, 0
  %t118 = load %Parser, %Parser* %l0
  %t119 = load %Parser, %Parser* %l1
  %t120 = load %CaptureResult, %CaptureResult* %l2
  %t121 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t122 = load double, double* %l4
  %t123 = load { %Token*, i64 }*, { %Token*, i64 }** %l5
  %t124 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  %t125 = load %Expression, %Expression* %l7
  %t126 = load %Expression, %Expression* %l8
  %t127 = load %ForClause, %ForClause* %l9
  %t128 = load %BlockParseResult, %BlockParseResult* %l10
  br i1 %t117, label %then8, label %merge9
then8:
  %t129 = load %Parser, %Parser* %l0
  %t130 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
  %t131 = bitcast i8* null to %Statement*
  %t132 = insertvalue %BlockStatementParseResult %t130, %Statement* %t131, 1
  %t133 = insertvalue %BlockStatementParseResult %t132, i1 0, 2
  ret %BlockStatementParseResult %t133
merge9:
  %t134 = load %BlockParseResult, %BlockParseResult* %l10
  %t135 = extractvalue %BlockParseResult %t134, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t136 = load %BlockParseResult, %BlockParseResult* %l10
  %t137 = extractvalue %BlockParseResult %t136, 1
  store %Block* %t137, %Block** %l11
  %t138 = load %Parser, %Parser* %l1
  %t139 = call %Parser @skip_trivia(%Parser %t138)
  store %Parser %t139, %Parser* %l1
  %t140 = load %Parser, %Parser* %l1
  %t141 = call %Token @parser_peek_raw(%Parser %t140)
  store %Token %t141, %Token* %l12
  %t143 = load %Token, %Token* %l12
  %t144 = extractvalue %Token %t143, 0
  %t145 = getelementptr inbounds %TokenKind, %TokenKind* %t144, i32 0, i32 0
  %t146 = load i32, i32* %t145
  %t147 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t148 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t146, 0
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t146, 1
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t146, 2
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t146, 3
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %t160 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t161 = icmp eq i32 %t146, 4
  %t162 = select i1 %t161, i8* %t160, i8* %t159
  %t163 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t164 = icmp eq i32 %t146, 5
  %t165 = select i1 %t164, i8* %t163, i8* %t162
  %t166 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t167 = icmp eq i32 %t146, 6
  %t168 = select i1 %t167, i8* %t166, i8* %t165
  %t169 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t170 = icmp eq i32 %t146, 7
  %t171 = select i1 %t170, i8* %t169, i8* %t168
  %s172 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.172, i32 0, i32 0
  %t173 = icmp eq i8* %t171, %s172
  br label %logical_and_entry_142

logical_and_entry_142:
  br i1 %t173, label %logical_and_right_142, label %logical_and_merge_142

logical_and_right_142:
  %t174 = load %Token, %Token* %l12
  %t175 = extractvalue %Token %t174, 0
  %t176 = getelementptr inbounds %TokenKind, %TokenKind* %t175, i32 0, i32 0
  %t177 = load i32, i32* %t176
  %t178 = alloca %Statement
  %t179 = getelementptr inbounds %Statement, %Statement* %t178, i32 0, i32 0
  store i32 14, i32* %t179
  %t180 = load %ForClause, %ForClause* %l9
  %t181 = call noalias i8* @malloc(i64 24)
  %t182 = bitcast i8* %t181 to %ForClause*
  store %ForClause %t180, %ForClause* %t182
  %t183 = bitcast i8* %t181 to %ForClause*
  %t184 = getelementptr inbounds %Statement, %Statement* %t178, i32 0, i32 1
  %t185 = bitcast [24 x i8]* %t184 to i8*
  %t186 = bitcast i8* %t185 to %ForClause**
  store %ForClause* %t183, %ForClause** %t186
  %t187 = load %Block*, %Block** %l11
  %t188 = getelementptr inbounds %Statement, %Statement* %t178, i32 0, i32 1
  %t189 = bitcast [24 x i8]* %t188 to i8*
  %t190 = getelementptr inbounds i8, i8* %t189, i64 8
  %t191 = bitcast i8* %t190 to %Block**
  store %Block* %t187, %Block** %t191
  %t192 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t193 = getelementptr inbounds %Statement, %Statement* %t178, i32 0, i32 1
  %t194 = bitcast [24 x i8]* %t193 to i8*
  %t195 = getelementptr inbounds i8, i8* %t194, i64 16
  %t196 = bitcast i8* %t195 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t192, { %Decorator**, i64 }** %t196
  %t197 = load %Statement, %Statement* %t178
  store %Statement %t197, %Statement* %l13
  %t198 = load %Parser, %Parser* %l1
  %t199 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
  %t200 = load %Statement, %Statement* %l13
  %t201 = insertvalue %BlockStatementParseResult %t199, %Statement* null, 1
  %t202 = insertvalue %BlockStatementParseResult %t201, i1 1, 2
  ret %BlockStatementParseResult %t202
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
  %t9 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
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
  %t20 = getelementptr %Block, %Block* %t19, i32 0, i32 0
  %t21 = load { %Token**, i64 }*, { %Token**, i64 }** %t20
  %t22 = load { %Token**, i64 }, { %Token**, i64 }* %t21
  %t23 = extractvalue { %Token**, i64 } %t22, 1
  %t24 = icmp eq i64 %t23, 0
  %t25 = load %Parser, %Parser* %l0
  %t26 = load %Parser, %Parser* %l1
  %t27 = load %BlockParseResult, %BlockParseResult* %l2
  br i1 %t24, label %then2, label %merge3
then2:
  %t28 = load %Parser, %Parser* %l0
  %t29 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
  %t30 = bitcast i8* null to %Statement*
  %t31 = insertvalue %BlockStatementParseResult %t29, %Statement* %t30, 1
  %t32 = insertvalue %BlockStatementParseResult %t31, i1 0, 2
  ret %BlockStatementParseResult %t32
merge3:
  %t33 = load %BlockParseResult, %BlockParseResult* %l2
  %t34 = extractvalue %BlockParseResult %t33, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t35 = load %Parser, %Parser* %l1
  %t36 = call %Parser @skip_trivia(%Parser %t35)
  store %Parser %t36, %Parser* %l1
  %t37 = load %Parser, %Parser* %l1
  %t38 = call %Token @parser_peek_raw(%Parser %t37)
  store %Token %t38, %Token* %l3
  %t40 = load %Token, %Token* %l3
  %t41 = extractvalue %Token %t40, 0
  %t42 = getelementptr inbounds %TokenKind, %TokenKind* %t41, i32 0, i32 0
  %t43 = load i32, i32* %t42
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
  br label %logical_and_entry_39

logical_and_entry_39:
  br i1 %t70, label %logical_and_right_39, label %logical_and_merge_39

logical_and_right_39:
  %t71 = load %Token, %Token* %l3
  %t72 = extractvalue %Token %t71, 0
  %t73 = getelementptr inbounds %TokenKind, %TokenKind* %t72, i32 0, i32 0
  %t74 = load i32, i32* %t73
  %t75 = alloca %Statement
  %t76 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 0
  store i32 15, i32* %t76
  %t77 = load %BlockParseResult, %BlockParseResult* %l2
  %t78 = extractvalue %BlockParseResult %t77, 1
  %t79 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t80 = bitcast [16 x i8]* %t79 to i8*
  %t81 = bitcast i8* %t80 to %Block**
  store %Block* %t78, %Block** %t81
  %t82 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t83 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t84 = bitcast [16 x i8]* %t83 to i8*
  %t85 = getelementptr inbounds i8, i8* %t84, i64 8
  %t86 = bitcast i8* %t85 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t82, { %Decorator**, i64 }** %t86
  %t87 = load %Statement, %Statement* %t75
  store %Statement %t87, %Statement* %l4
  %t88 = load %Parser, %Parser* %l1
  %t89 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
  %t90 = load %Statement, %Statement* %l4
  %t91 = insertvalue %BlockStatementParseResult %t89, %Statement* null, 1
  %t92 = insertvalue %BlockStatementParseResult %t91, i1 1, 2
  ret %BlockStatementParseResult %t92
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
  %t9 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
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
  %t23 = getelementptr inbounds %TokenKind, %TokenKind* %t22, i32 0, i32 0
  %t24 = load i32, i32* %t23
  %t25 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t26 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t24, 0
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t24, 1
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t24, 2
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t24, 3
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t24, 4
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t24, 5
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t24, 6
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t24, 7
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %s50 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.50, i32 0, i32 0
  %t51 = icmp eq i8* %t49, %s50
  br label %logical_and_entry_20

logical_and_entry_20:
  br i1 %t51, label %logical_and_right_20, label %logical_and_merge_20

logical_and_right_20:
  %t52 = load %Token, %Token* %l2
  %t53 = extractvalue %Token %t52, 0
  %t54 = getelementptr inbounds %TokenKind, %TokenKind* %t53, i32 0, i32 0
  %t55 = load i32, i32* %t54
  %t56 = load %Parser, %Parser* %l1
  %t57 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
  %t58 = insertvalue %Statement undef, i32 16, 0
  %t59 = insertvalue %BlockStatementParseResult %t57, %Statement* null, 1
  %t60 = insertvalue %BlockStatementParseResult %t59, i1 1, 2
  ret %BlockStatementParseResult %t60
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
  %t9 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
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
  %t23 = getelementptr inbounds %TokenKind, %TokenKind* %t22, i32 0, i32 0
  %t24 = load i32, i32* %t23
  %t25 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t26 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t24, 0
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t24, 1
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t24, 2
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t24, 3
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t24, 4
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t24, 5
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t24, 6
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t24, 7
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %s50 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.50, i32 0, i32 0
  %t51 = icmp eq i8* %t49, %s50
  br label %logical_and_entry_20

logical_and_entry_20:
  br i1 %t51, label %logical_and_right_20, label %logical_and_merge_20

logical_and_right_20:
  %t52 = load %Token, %Token* %l2
  %t53 = extractvalue %Token %t52, 0
  %t54 = getelementptr inbounds %TokenKind, %TokenKind* %t53, i32 0, i32 0
  %t55 = load i32, i32* %t54
  %t56 = load %Parser, %Parser* %l1
  %t57 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
  %t58 = insertvalue %Statement undef, i32 17, 0
  %t59 = insertvalue %BlockStatementParseResult %t57, %Statement* null, 1
  %t60 = insertvalue %BlockStatementParseResult %t59, i1 1, 2
  ret %BlockStatementParseResult %t60
}

define %BlockStatementParseResult @parse_if_statement(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %CaptureResult
  %l3 = alloca { %Token*, i64 }*
  %l4 = alloca %Expression
  %l5 = alloca %BlockParseResult
  %l6 = alloca %Block*
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
  %t9 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
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
  store %Parser zeroinitializer, %Parser* %l1
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
  %t41 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
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
  %t51 = getelementptr %Block, %Block* %t50, i32 0, i32 0
  %t52 = load { %Token**, i64 }*, { %Token**, i64 }** %t51
  %t53 = load { %Token**, i64 }, { %Token**, i64 }* %t52
  %t54 = extractvalue { %Token**, i64 } %t53, 1
  %t55 = icmp eq i64 %t54, 0
  %t56 = load %Parser, %Parser* %l0
  %t57 = load %Parser, %Parser* %l1
  %t58 = load %CaptureResult, %CaptureResult* %l2
  %t59 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t60 = load %Expression, %Expression* %l4
  %t61 = load %BlockParseResult, %BlockParseResult* %l5
  br i1 %t55, label %then4, label %merge5
then4:
  %t62 = load %Parser, %Parser* %l0
  %t63 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
  %t64 = bitcast i8* null to %Statement*
  %t65 = insertvalue %BlockStatementParseResult %t63, %Statement* %t64, 1
  %t66 = insertvalue %BlockStatementParseResult %t65, i1 0, 2
  ret %BlockStatementParseResult %t66
merge5:
  %t67 = load %BlockParseResult, %BlockParseResult* %l5
  %t68 = extractvalue %BlockParseResult %t67, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t69 = load %BlockParseResult, %BlockParseResult* %l5
  %t70 = extractvalue %BlockParseResult %t69, 1
  store %Block* %t70, %Block** %l6
  %t71 = load %Parser, %Parser* %l1
  %t72 = call %Parser @skip_trivia(%Parser %t71)
  store %Parser %t72, %Parser* %l1
  store i8* null, i8** %l7
  %t73 = load %Parser, %Parser* %l1
  %t74 = call %Token @parser_peek_raw(%Parser %t73)
  %s75 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.75, i32 0, i32 0
  %t76 = call i1 @identifier_matches(%Token %t74, i8* %s75)
  %t77 = load %Parser, %Parser* %l0
  %t78 = load %Parser, %Parser* %l1
  %t79 = load %CaptureResult, %CaptureResult* %l2
  %t80 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t81 = load %Expression, %Expression* %l4
  %t82 = load %BlockParseResult, %BlockParseResult* %l5
  %t83 = load %Block*, %Block** %l6
  %t84 = load i8*, i8** %l7
  br i1 %t76, label %then6, label %merge7
then6:
  %t85 = load %Parser, %Parser* %l1
  %s86 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.86, i32 0, i32 0
  %t87 = call %Parser @consume_keyword(%Parser %t85, i8* %s86)
  store %Parser %t87, %Parser* %l1
  %t88 = load %Parser, %Parser* %l1
  %t89 = call %Parser @skip_trivia(%Parser %t88)
  store %Parser %t89, %Parser* %l1
  %t90 = load %Parser, %Parser* %l1
  %t91 = call %Token @parser_peek_raw(%Parser %t90)
  store %Token %t91, %Token* %l8
  %t92 = load %Token, %Token* %l8
  %s93 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.93, i32 0, i32 0
  %t94 = call i1 @identifier_matches(%Token %t92, i8* %s93)
  %t95 = load %Parser, %Parser* %l0
  %t96 = load %Parser, %Parser* %l1
  %t97 = load %CaptureResult, %CaptureResult* %l2
  %t98 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t99 = load %Expression, %Expression* %l4
  %t100 = load %BlockParseResult, %BlockParseResult* %l5
  %t101 = load %Block*, %Block** %l6
  %t102 = load i8*, i8** %l7
  %t103 = load %Token, %Token* %l8
  br i1 %t94, label %then8, label %else9
then8:
  %t104 = load %Parser, %Parser* %l1
  %t105 = alloca [0 x double]
  %t106 = getelementptr [0 x double], [0 x double]* %t105, i32 0, i32 0
  %t107 = alloca { double*, i64 }
  %t108 = getelementptr { double*, i64 }, { double*, i64 }* %t107, i32 0, i32 0
  store double* %t106, double** %t108
  %t109 = getelementptr { double*, i64 }, { double*, i64 }* %t107, i32 0, i32 1
  store i64 0, i64* %t109
  %t110 = bitcast { double*, i64 }* %t107 to { %Decorator*, i64 }*
  %t111 = call %BlockStatementParseResult @parse_if_statement(%Parser %t104, { %Decorator*, i64 }* %t110)
  store %BlockStatementParseResult %t111, %BlockStatementParseResult* %l9
  %t112 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  %t113 = extractvalue %BlockStatementParseResult %t112, 2
  %t114 = xor i1 %t113, 1
  %t115 = load %Parser, %Parser* %l0
  %t116 = load %Parser, %Parser* %l1
  %t117 = load %CaptureResult, %CaptureResult* %l2
  %t118 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t119 = load %Expression, %Expression* %l4
  %t120 = load %BlockParseResult, %BlockParseResult* %l5
  %t121 = load %Block*, %Block** %l6
  %t122 = load i8*, i8** %l7
  %t123 = load %Token, %Token* %l8
  %t124 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  br i1 %t114, label %then11, label %merge12
then11:
  %t125 = load %Parser, %Parser* %l0
  %t126 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
  %t127 = bitcast i8* null to %Statement*
  %t128 = insertvalue %BlockStatementParseResult %t126, %Statement* %t127, 1
  %t129 = insertvalue %BlockStatementParseResult %t128, i1 0, 2
  ret %BlockStatementParseResult %t129
merge12:
  %t130 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  %t131 = extractvalue %BlockStatementParseResult %t130, 1
  %t132 = bitcast i8* null to %Statement*
  %t133 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  %t134 = extractvalue %BlockStatementParseResult %t133, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t135 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  %t136 = extractvalue %BlockStatementParseResult %t135, 1
  %t137 = insertvalue %ElseBranch undef, %Statement* %t136, 0
  %t138 = bitcast i8* null to %Block*
  %t139 = insertvalue %ElseBranch %t137, %Block* %t138, 1
  store i8* null, i8** %l7
  br label %merge10
else9:
  %t140 = load %Parser, %Parser* %l1
  %t141 = call %BlockParseResult @parse_block(%Parser %t140)
  store %BlockParseResult %t141, %BlockParseResult* %l10
  %t142 = load %BlockParseResult, %BlockParseResult* %l10
  %t143 = extractvalue %BlockParseResult %t142, 1
  %t144 = getelementptr %Block, %Block* %t143, i32 0, i32 0
  %t145 = load { %Token**, i64 }*, { %Token**, i64 }** %t144
  %t146 = load { %Token**, i64 }, { %Token**, i64 }* %t145
  %t147 = extractvalue { %Token**, i64 } %t146, 1
  %t148 = icmp eq i64 %t147, 0
  %t149 = load %Parser, %Parser* %l0
  %t150 = load %Parser, %Parser* %l1
  %t151 = load %CaptureResult, %CaptureResult* %l2
  %t152 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t153 = load %Expression, %Expression* %l4
  %t154 = load %BlockParseResult, %BlockParseResult* %l5
  %t155 = load %Block*, %Block** %l6
  %t156 = load i8*, i8** %l7
  %t157 = load %Token, %Token* %l8
  %t158 = load %BlockParseResult, %BlockParseResult* %l10
  br i1 %t148, label %then13, label %merge14
then13:
  %t159 = load %Parser, %Parser* %l0
  %t160 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
  %t161 = bitcast i8* null to %Statement*
  %t162 = insertvalue %BlockStatementParseResult %t160, %Statement* %t161, 1
  %t163 = insertvalue %BlockStatementParseResult %t162, i1 0, 2
  ret %BlockStatementParseResult %t163
merge14:
  %t164 = load %BlockParseResult, %BlockParseResult* %l10
  %t165 = extractvalue %BlockParseResult %t164, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t166 = bitcast i8* null to %Statement*
  %t167 = insertvalue %ElseBranch undef, %Statement* %t166, 0
  %t168 = load %BlockParseResult, %BlockParseResult* %l10
  %t169 = extractvalue %BlockParseResult %t168, 1
  %t170 = insertvalue %ElseBranch %t167, %Block* %t169, 1
  store i8* null, i8** %l7
  br label %merge10
merge10:
  %t171 = phi %Parser [ zeroinitializer, %then8 ], [ zeroinitializer, %else9 ]
  %t172 = phi i8* [ null, %then8 ], [ null, %else9 ]
  store %Parser %t171, %Parser* %l1
  store i8* %t172, i8** %l7
  %t173 = load %Parser, %Parser* %l1
  %t174 = call %Parser @skip_trivia(%Parser %t173)
  store %Parser %t174, %Parser* %l1
  %t175 = load %Parser, %Parser* %l1
  %t176 = call %Token @parser_peek_raw(%Parser %t175)
  store %Token %t176, %Token* %l11
  %t178 = load %Token, %Token* %l11
  %t179 = extractvalue %Token %t178, 0
  %t180 = getelementptr inbounds %TokenKind, %TokenKind* %t179, i32 0, i32 0
  %t181 = load i32, i32* %t180
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
  br label %logical_and_entry_177

logical_and_entry_177:
  br i1 %t208, label %logical_and_right_177, label %logical_and_merge_177

logical_and_right_177:
  %t209 = load %Token, %Token* %l11
  %t210 = extractvalue %Token %t209, 0
  %t211 = getelementptr inbounds %TokenKind, %TokenKind* %t210, i32 0, i32 0
  %t212 = load i32, i32* %t211
  br label %merge7
merge7:
  %t213 = phi %Parser [ %t87, %then6 ], [ %t78, %entry ]
  %t214 = phi %Parser [ %t89, %then6 ], [ %t78, %entry ]
  %t215 = phi %Parser [ zeroinitializer, %then6 ], [ %t78, %entry ]
  %t216 = phi i8* [ null, %then6 ], [ %t84, %entry ]
  %t217 = phi %Parser [ zeroinitializer, %then6 ], [ %t78, %entry ]
  %t218 = phi i8* [ null, %then6 ], [ %t84, %entry ]
  %t219 = phi %Parser [ %t174, %then6 ], [ %t78, %entry ]
  store %Parser %t213, %Parser* %l1
  store %Parser %t214, %Parser* %l1
  store %Parser %t215, %Parser* %l1
  store i8* %t216, i8** %l7
  store %Parser %t217, %Parser* %l1
  store i8* %t218, i8** %l7
  store %Parser %t219, %Parser* %l1
  %t220 = alloca %Statement
  %t221 = getelementptr inbounds %Statement, %Statement* %t220, i32 0, i32 0
  store i32 19, i32* %t221
  %t222 = load %Expression, %Expression* %l4
  %t223 = call noalias i8* @malloc(i64 32)
  %t224 = bitcast i8* %t223 to %Expression*
  store %Expression %t222, %Expression* %t224
  %t225 = bitcast i8* %t223 to %Expression*
  %t226 = getelementptr inbounds %Statement, %Statement* %t220, i32 0, i32 1
  %t227 = bitcast [32 x i8]* %t226 to i8*
  %t228 = bitcast i8* %t227 to %Expression**
  store %Expression* %t225, %Expression** %t228
  %t229 = load %Block*, %Block** %l6
  %t230 = getelementptr inbounds %Statement, %Statement* %t220, i32 0, i32 1
  %t231 = bitcast [32 x i8]* %t230 to i8*
  %t232 = getelementptr inbounds i8, i8* %t231, i64 8
  %t233 = bitcast i8* %t232 to %Block**
  store %Block* %t229, %Block** %t233
  %t234 = load i8*, i8** %l7
  %t235 = bitcast i8* %t234 to %ElseBranch*
  %t236 = getelementptr inbounds %Statement, %Statement* %t220, i32 0, i32 1
  %t237 = bitcast [32 x i8]* %t236 to i8*
  %t238 = getelementptr inbounds i8, i8* %t237, i64 16
  %t239 = bitcast i8* %t238 to %ElseBranch**
  store %ElseBranch* %t235, %ElseBranch** %t239
  %t240 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t241 = getelementptr inbounds %Statement, %Statement* %t220, i32 0, i32 1
  %t242 = bitcast [32 x i8]* %t241 to i8*
  %t243 = getelementptr inbounds i8, i8* %t242, i64 24
  %t244 = bitcast i8* %t243 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t240, { %Decorator**, i64 }** %t244
  %t245 = load %Statement, %Statement* %t220
  store %Statement %t245, %Statement* %l12
  %t246 = load %Parser, %Parser* %l1
  %t247 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
  %t248 = load %Statement, %Statement* %l12
  %t249 = insertvalue %BlockStatementParseResult %t247, %Statement* null, 1
  %t250 = insertvalue %BlockStatementParseResult %t249, i1 1, 2
  ret %BlockStatementParseResult %t250
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
  %t9 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
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
  store %Parser zeroinitializer, %Parser* %l1
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
  %t41 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
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
  %t59 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
  %t60 = bitcast i8* null to %Statement*
  %t61 = insertvalue %BlockStatementParseResult %t59, %Statement* %t60, 1
  %t62 = insertvalue %BlockStatementParseResult %t61, i1 0, 2
  ret %BlockStatementParseResult %t62
merge5:
  %t63 = load %MatchCasesParseResult, %MatchCasesParseResult* %l5
  %t64 = extractvalue %MatchCasesParseResult %t63, 0
  store %Parser zeroinitializer, %Parser* %l1
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
  %t86 = getelementptr inbounds %TokenKind, %TokenKind* %t85, i32 0, i32 0
  %t87 = load i32, i32* %t86
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
  br label %logical_and_entry_83

logical_and_entry_83:
  br i1 %t114, label %logical_and_right_83, label %logical_and_merge_83

logical_and_right_83:
  %t115 = load %Token, %Token* %l6
  %t116 = extractvalue %Token %t115, 0
  %t117 = getelementptr inbounds %TokenKind, %TokenKind* %t116, i32 0, i32 0
  %t118 = load i32, i32* %t117
  br label %merge7
merge7:
  %t119 = alloca %Statement
  %t120 = getelementptr inbounds %Statement, %Statement* %t119, i32 0, i32 0
  store i32 18, i32* %t120
  %t121 = load %Expression, %Expression* %l4
  %t122 = call noalias i8* @malloc(i64 32)
  %t123 = bitcast i8* %t122 to %Expression*
  store %Expression %t121, %Expression* %t123
  %t124 = bitcast i8* %t122 to %Expression*
  %t125 = getelementptr inbounds %Statement, %Statement* %t119, i32 0, i32 1
  %t126 = bitcast [24 x i8]* %t125 to i8*
  %t127 = bitcast i8* %t126 to %Expression**
  store %Expression* %t124, %Expression** %t127
  %t128 = load %MatchCasesParseResult, %MatchCasesParseResult* %l5
  %t129 = extractvalue %MatchCasesParseResult %t128, 1
  %t130 = getelementptr inbounds %Statement, %Statement* %t119, i32 0, i32 1
  %t131 = bitcast [24 x i8]* %t130 to i8*
  %t132 = getelementptr inbounds i8, i8* %t131, i64 8
  %t133 = bitcast i8* %t132 to { %MatchCase**, i64 }**
  store { %MatchCase**, i64 }* %t129, { %MatchCase**, i64 }** %t133
  %t134 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t135 = getelementptr inbounds %Statement, %Statement* %t119, i32 0, i32 1
  %t136 = bitcast [24 x i8]* %t135 to i8*
  %t137 = getelementptr inbounds i8, i8* %t136, i64 16
  %t138 = bitcast i8* %t137 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t134, { %Decorator**, i64 }** %t138
  %t139 = load %Statement, %Statement* %t119
  store %Statement %t139, %Statement* %l7
  %t140 = load %Parser, %Parser* %l1
  %t141 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
  %t142 = load %Statement, %Statement* %l7
  %t143 = insertvalue %BlockStatementParseResult %t141, %Statement* null, 1
  %t144 = insertvalue %BlockStatementParseResult %t143, i1 1, 2
  ret %BlockStatementParseResult %t144
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
  %t12 = getelementptr inbounds %TokenKind, %TokenKind* %t11, i32 0, i32 0
  %t13 = load i32, i32* %t12
  %t14 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t15 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t16 = icmp eq i32 %t13, 0
  %t17 = select i1 %t16, i8* %t15, i8* %t14
  %t18 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t19 = icmp eq i32 %t13, 1
  %t20 = select i1 %t19, i8* %t18, i8* %t17
  %t21 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t22 = icmp eq i32 %t13, 2
  %t23 = select i1 %t22, i8* %t21, i8* %t20
  %t24 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t13, 3
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %t27 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t28 = icmp eq i32 %t13, 4
  %t29 = select i1 %t28, i8* %t27, i8* %t26
  %t30 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t31 = icmp eq i32 %t13, 5
  %t32 = select i1 %t31, i8* %t30, i8* %t29
  %t33 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t34 = icmp eq i32 %t13, 6
  %t35 = select i1 %t34, i8* %t33, i8* %t32
  %t36 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t37 = icmp eq i32 %t13, 7
  %t38 = select i1 %t37, i8* %t36, i8* %t35
  %s39 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.39, i32 0, i32 0
  %t40 = icmp ne i8* %t38, %s39
  br label %logical_or_entry_9

logical_or_entry_9:
  br i1 %t40, label %logical_or_merge_9, label %logical_or_right_9

logical_or_right_9:
  %t41 = load %Token, %Token* %l1
  %t42 = extractvalue %Token %t41, 0
  %t43 = getelementptr inbounds %TokenKind, %TokenKind* %t42, i32 0, i32 0
  %t44 = load i32, i32* %t43
  %t45 = load %Parser, %Parser* %l0
  %t46 = call %Parser @parser_advance_raw(%Parser %t45)
  store %Parser %t46, %Parser* %l0
  %t47 = alloca [0 x %MatchCase]
  %t48 = getelementptr [0 x %MatchCase], [0 x %MatchCase]* %t47, i32 0, i32 0
  %t49 = alloca { %MatchCase*, i64 }
  %t50 = getelementptr { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t49, i32 0, i32 0
  store %MatchCase* %t48, %MatchCase** %t50
  %t51 = getelementptr { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t49, i32 0, i32 1
  store i64 0, i64* %t51
  store { %MatchCase*, i64 }* %t49, { %MatchCase*, i64 }** %l2
  %t52 = load %Parser, %Parser* %l0
  %t53 = load %Token, %Token* %l1
  %t54 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %l2
  br label %loop.header0
loop.header0:
  %t194 = phi %Parser [ %t52, %entry ], [ %t192, %loop.latch2 ]
  %t195 = phi { %MatchCase*, i64 }* [ %t54, %entry ], [ %t193, %loop.latch2 ]
  store %Parser %t194, %Parser* %l0
  store { %MatchCase*, i64 }* %t195, { %MatchCase*, i64 }** %l2
  br label %loop.body1
loop.body1:
  %t55 = load %Parser, %Parser* %l0
  %t56 = call %Parser @skip_trivia(%Parser %t55)
  store %Parser %t56, %Parser* %l0
  %t57 = load %Parser, %Parser* %l0
  %t58 = call %Token @parser_peek_raw(%Parser %t57)
  store %Token %t58, %Token* %l3
  %t60 = load %Token, %Token* %l3
  %t61 = extractvalue %Token %t60, 0
  %t62 = getelementptr inbounds %TokenKind, %TokenKind* %t61, i32 0, i32 0
  %t63 = load i32, i32* %t62
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
  br label %logical_and_entry_59

logical_and_entry_59:
  br i1 %t90, label %logical_and_right_59, label %logical_and_merge_59

logical_and_right_59:
  %t91 = load %Token, %Token* %l3
  %t92 = extractvalue %Token %t91, 0
  %t93 = getelementptr inbounds %TokenKind, %TokenKind* %t92, i32 0, i32 0
  %t94 = load i32, i32* %t93
  %t95 = load %Token, %Token* %l3
  %t96 = extractvalue %Token %t95, 0
  %t97 = getelementptr inbounds %TokenKind, %TokenKind* %t96, i32 0, i32 0
  %t98 = load i32, i32* %t97
  %t99 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t100 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t98, 0
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %t103 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t104 = icmp eq i32 %t98, 1
  %t105 = select i1 %t104, i8* %t103, i8* %t102
  %t106 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t107 = icmp eq i32 %t98, 2
  %t108 = select i1 %t107, i8* %t106, i8* %t105
  %t109 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t110 = icmp eq i32 %t98, 3
  %t111 = select i1 %t110, i8* %t109, i8* %t108
  %t112 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t113 = icmp eq i32 %t98, 4
  %t114 = select i1 %t113, i8* %t112, i8* %t111
  %t115 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t116 = icmp eq i32 %t98, 5
  %t117 = select i1 %t116, i8* %t115, i8* %t114
  %t118 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t119 = icmp eq i32 %t98, 6
  %t120 = select i1 %t119, i8* %t118, i8* %t117
  %t121 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t122 = icmp eq i32 %t98, 7
  %t123 = select i1 %t122, i8* %t121, i8* %t120
  %s124 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.124, i32 0, i32 0
  %t125 = icmp eq i8* %t123, %s124
  %t126 = load %Parser, %Parser* %l0
  %t127 = load %Token, %Token* %l1
  %t128 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %l2
  %t129 = load %Token, %Token* %l3
  br i1 %t125, label %then4, label %merge5
then4:
  %t130 = insertvalue %MatchCasesParseResult undef, %Parser* null, 0
  %t131 = alloca [0 x %MatchCase*]
  %t132 = getelementptr [0 x %MatchCase*], [0 x %MatchCase*]* %t131, i32 0, i32 0
  %t133 = alloca { %MatchCase**, i64 }
  %t134 = getelementptr { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t133, i32 0, i32 0
  store %MatchCase** %t132, %MatchCase*** %t134
  %t135 = getelementptr { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t133, i32 0, i32 1
  store i64 0, i64* %t135
  %t136 = insertvalue %MatchCasesParseResult %t130, { %MatchCase**, i64 }* %t133, 1
  %t137 = insertvalue %MatchCasesParseResult %t136, i1 0, 2
  ret %MatchCasesParseResult %t137
merge5:
  %t138 = load %Parser, %Parser* %l0
  %t139 = call %MatchCaseParseResult @parse_match_case(%Parser %t138)
  store %MatchCaseParseResult %t139, %MatchCaseParseResult* %l4
  %t141 = load %MatchCaseParseResult, %MatchCaseParseResult* %l4
  %t142 = extractvalue %MatchCaseParseResult %t141, 2
  br label %logical_or_entry_140

logical_or_entry_140:
  br i1 %t142, label %logical_or_merge_140, label %logical_or_right_140

logical_or_right_140:
  %t143 = load %MatchCaseParseResult, %MatchCaseParseResult* %l4
  %t144 = extractvalue %MatchCaseParseResult %t143, 1
  %t145 = bitcast i8* null to %MatchCase*
  %t146 = load %MatchCaseParseResult, %MatchCaseParseResult* %l4
  %t147 = extractvalue %MatchCaseParseResult %t146, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t148 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %l2
  %t149 = load %MatchCaseParseResult, %MatchCaseParseResult* %l4
  %t150 = extractvalue %MatchCaseParseResult %t149, 1
  %t151 = call { %MatchCase*, i64 }* @append_match_case({ %MatchCase*, i64 }* %t148, %MatchCase zeroinitializer)
  store { %MatchCase*, i64 }* %t151, { %MatchCase*, i64 }** %l2
  %t152 = load %Parser, %Parser* %l0
  %t153 = call %Parser @skip_trivia(%Parser %t152)
  store %Parser %t153, %Parser* %l0
  %t154 = load %Parser, %Parser* %l0
  %t155 = call %Token @parser_peek_raw(%Parser %t154)
  store %Token %t155, %Token* %l5
  %t157 = load %Token, %Token* %l5
  %t158 = extractvalue %Token %t157, 0
  %t159 = getelementptr inbounds %TokenKind, %TokenKind* %t158, i32 0, i32 0
  %t160 = load i32, i32* %t159
  %t161 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t162 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t160, 0
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t160, 1
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %t168 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t169 = icmp eq i32 %t160, 2
  %t170 = select i1 %t169, i8* %t168, i8* %t167
  %t171 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t172 = icmp eq i32 %t160, 3
  %t173 = select i1 %t172, i8* %t171, i8* %t170
  %t174 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t175 = icmp eq i32 %t160, 4
  %t176 = select i1 %t175, i8* %t174, i8* %t173
  %t177 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t178 = icmp eq i32 %t160, 5
  %t179 = select i1 %t178, i8* %t177, i8* %t176
  %t180 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t181 = icmp eq i32 %t160, 6
  %t182 = select i1 %t181, i8* %t180, i8* %t179
  %t183 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t184 = icmp eq i32 %t160, 7
  %t185 = select i1 %t184, i8* %t183, i8* %t182
  %s186 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.186, i32 0, i32 0
  %t187 = icmp eq i8* %t185, %s186
  br label %logical_and_entry_156

logical_and_entry_156:
  br i1 %t187, label %logical_and_right_156, label %logical_and_merge_156

logical_and_right_156:
  %t188 = load %Token, %Token* %l5
  %t189 = extractvalue %Token %t188, 0
  %t190 = getelementptr inbounds %TokenKind, %TokenKind* %t189, i32 0, i32 0
  %t191 = load i32, i32* %t190
  br label %loop.latch2
loop.latch2:
  %t192 = load %Parser, %Parser* %l0
  %t193 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %l2
  br label %loop.header0
afterloop3:
  %t196 = load %Parser, %Parser* %l0
  %t197 = insertvalue %MatchCasesParseResult undef, %Parser* null, 0
  %t198 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %l2
  %t199 = bitcast { %MatchCase*, i64 }* %t198 to { %MatchCase**, i64 }*
  %t200 = insertvalue %MatchCasesParseResult %t197, { %MatchCase**, i64 }* %t199, 1
  %t201 = insertvalue %MatchCasesParseResult %t200, i1 1, 2
  ret %MatchCasesParseResult %t201
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
  %t23 = insertvalue %MatchCaseParseResult undef, %Parser* null, 0
  %t24 = bitcast i8* null to %MatchCase*
  %t25 = insertvalue %MatchCaseParseResult %t23, %MatchCase* %t24, 1
  %t26 = insertvalue %MatchCaseParseResult %t25, i1 0, 2
  ret %MatchCaseParseResult %t26
merge3:
  %t27 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t28 = extractvalue %PatternCaptureResult %t27, 0
  store %Parser zeroinitializer, %Parser* %l1
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
  %t43 = insertvalue %MatchCaseParseResult undef, %Parser* null, 0
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
  %t71 = insertvalue %MatchCaseParseResult undef, %Parser* null, 0
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
  %t87 = getelementptr inbounds %TokenKind, %TokenKind* %t86, i32 0, i32 0
  %t88 = load i32, i32* %t87
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
  br label %logical_and_entry_84

logical_and_entry_84:
  br i1 %t115, label %logical_and_right_84, label %logical_and_merge_84

logical_and_right_84:
  %t116 = load %Token, %Token* %l6
  %t117 = extractvalue %Token %t116, 0
  %t118 = getelementptr inbounds %TokenKind, %TokenKind* %t117, i32 0, i32 0
  %t119 = load i32, i32* %t118
  %t120 = load i8*, i8** %l7
  %t121 = icmp eq i8* %t120, null
  %t122 = load %Parser, %Parser* %l0
  %t123 = load %Parser, %Parser* %l1
  %t124 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t125 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t126 = load %Expression, %Expression* %l4
  %t127 = load i8*, i8** %l5
  %t128 = load %Token, %Token* %l6
  %t129 = load i8*, i8** %l7
  br i1 %t121, label %then10, label %merge11
then10:
  %t130 = load %Parser, %Parser* %l0
  %t131 = insertvalue %MatchCaseParseResult undef, %Parser* null, 0
  %t132 = bitcast i8* null to %MatchCase*
  %t133 = insertvalue %MatchCaseParseResult %t131, %MatchCase* %t132, 1
  %t134 = insertvalue %MatchCaseParseResult %t133, i1 0, 2
  ret %MatchCaseParseResult %t134
merge11:
  %t135 = load %Expression, %Expression* %l4
  %t136 = insertvalue %MatchCase undef, %Expression* null, 0
  %t137 = load i8*, i8** %l5
  %t138 = bitcast i8* %t137 to %Expression*
  %t139 = insertvalue %MatchCase %t136, %Expression* %t138, 1
  %t140 = load i8*, i8** %l7
  %t141 = bitcast i8* %t140 to %Block*
  %t142 = insertvalue %MatchCase %t139, %Block* %t141, 2
  store %MatchCase %t142, %MatchCase* %l8
  %t143 = load %Parser, %Parser* %l1
  %t144 = insertvalue %MatchCaseParseResult undef, %Parser* null, 0
  %t145 = load %MatchCase, %MatchCase* %l8
  %t146 = insertvalue %MatchCaseParseResult %t144, %MatchCase* null, 1
  %t147 = insertvalue %MatchCaseParseResult %t146, i1 1, 2
  ret %MatchCaseParseResult %t147
}

define %BlockStatementParseResult @parse_prompt_statement(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %Token
  %l3 = alloca %Token
  %l4 = alloca i8*
  %l5 = alloca %BlockParseResult
  %l6 = alloca %Block*
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
  %t11 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
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
  %t25 = getelementptr inbounds %TokenKind, %TokenKind* %t24, i32 0, i32 0
  %t26 = load i32, i32* %t25
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
  %t53 = icmp eq i8* %t51, %s52
  %t54 = load %Parser, %Parser* %l0
  %t55 = load %Parser, %Parser* %l1
  %t56 = load %Token, %Token* %l2
  %t57 = load %Token, %Token* %l3
  %t58 = load i8*, i8** %l4
  br i1 %t53, label %then2, label %else3
then2:
  %t59 = load %Token, %Token* %l3
  %t60 = call i8* @identifier_text(%Token %t59)
  store i8* %t60, i8** %l4
  %t61 = load %Parser, %Parser* %l1
  %t62 = call %Parser @parser_advance_raw(%Parser %t61)
  store %Parser %t62, %Parser* %l1
  br label %merge4
else3:
  %t63 = load %Token, %Token* %l3
  %t64 = extractvalue %Token %t63, 0
  %t65 = getelementptr inbounds %TokenKind, %TokenKind* %t64, i32 0, i32 0
  %t66 = load i32, i32* %t65
  %t67 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t68 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t66, 0
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t66, 1
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t75 = icmp eq i32 %t66, 2
  %t76 = select i1 %t75, i8* %t74, i8* %t73
  %t77 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t78 = icmp eq i32 %t66, 3
  %t79 = select i1 %t78, i8* %t77, i8* %t76
  %t80 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t81 = icmp eq i32 %t66, 4
  %t82 = select i1 %t81, i8* %t80, i8* %t79
  %t83 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t84 = icmp eq i32 %t66, 5
  %t85 = select i1 %t84, i8* %t83, i8* %t82
  %t86 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t87 = icmp eq i32 %t66, 6
  %t88 = select i1 %t87, i8* %t86, i8* %t85
  %t89 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t90 = icmp eq i32 %t66, 7
  %t91 = select i1 %t90, i8* %t89, i8* %t88
  %s92 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.92, i32 0, i32 0
  %t93 = icmp eq i8* %t91, %s92
  %t94 = load %Parser, %Parser* %l0
  %t95 = load %Parser, %Parser* %l1
  %t96 = load %Token, %Token* %l2
  %t97 = load %Token, %Token* %l3
  %t98 = load i8*, i8** %l4
  br i1 %t93, label %then5, label %else6
then5:
  %t99 = load %Token, %Token* %l3
  %t100 = call i8* @string_literal_value(%Token %t99)
  store i8* %t100, i8** %l4
  %t101 = load %Parser, %Parser* %l1
  %t102 = call %Parser @parser_advance_raw(%Parser %t101)
  store %Parser %t102, %Parser* %l1
  br label %merge7
else6:
  %t103 = load %Parser, %Parser* %l0
  %t104 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
  %t105 = bitcast i8* null to %Statement*
  %t106 = insertvalue %BlockStatementParseResult %t104, %Statement* %t105, 1
  %t107 = insertvalue %BlockStatementParseResult %t106, i1 0, 2
  ret %BlockStatementParseResult %t107
merge7:
  br label %merge4
merge4:
  %t108 = phi i8* [ %t60, %then2 ], [ %t100, %else3 ]
  %t109 = phi %Parser [ %t62, %then2 ], [ %t102, %else3 ]
  store i8* %t108, i8** %l4
  store %Parser %t109, %Parser* %l1
  %t110 = load %Parser, %Parser* %l1
  %t111 = call %BlockParseResult @parse_block(%Parser %t110)
  store %BlockParseResult %t111, %BlockParseResult* %l5
  %t112 = load %BlockParseResult, %BlockParseResult* %l5
  %t113 = extractvalue %BlockParseResult %t112, 1
  %t114 = getelementptr %Block, %Block* %t113, i32 0, i32 0
  %t115 = load { %Token**, i64 }*, { %Token**, i64 }** %t114
  %t116 = load { %Token**, i64 }, { %Token**, i64 }* %t115
  %t117 = extractvalue { %Token**, i64 } %t116, 1
  %t118 = icmp eq i64 %t117, 0
  %t119 = load %Parser, %Parser* %l0
  %t120 = load %Parser, %Parser* %l1
  %t121 = load %Token, %Token* %l2
  %t122 = load %Token, %Token* %l3
  %t123 = load i8*, i8** %l4
  %t124 = load %BlockParseResult, %BlockParseResult* %l5
  br i1 %t118, label %then8, label %merge9
then8:
  %t125 = load %Parser, %Parser* %l0
  %t126 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
  %t127 = bitcast i8* null to %Statement*
  %t128 = insertvalue %BlockStatementParseResult %t126, %Statement* %t127, 1
  %t129 = insertvalue %BlockStatementParseResult %t128, i1 0, 2
  ret %BlockStatementParseResult %t129
merge9:
  %t130 = load %BlockParseResult, %BlockParseResult* %l5
  %t131 = extractvalue %BlockParseResult %t130, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t132 = load %BlockParseResult, %BlockParseResult* %l5
  %t133 = extractvalue %BlockParseResult %t132, 1
  store %Block* %t133, %Block** %l6
  %t134 = load %Parser, %Parser* %l1
  %t135 = call %Parser @skip_trivia(%Parser %t134)
  store %Parser %t135, %Parser* %l1
  %t137 = load %Parser, %Parser* %l1
  %t138 = call %Token @parser_peek_raw(%Parser %t137)
  %t139 = extractvalue %Token %t138, 0
  %t140 = getelementptr inbounds %TokenKind, %TokenKind* %t139, i32 0, i32 0
  %t141 = load i32, i32* %t140
  %t142 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t143 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t141, 0
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t141, 1
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t141, 2
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t141, 3
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t141, 4
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t141, 5
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t141, 6
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t141, 7
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %s167 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.167, i32 0, i32 0
  %t168 = icmp eq i8* %t166, %s167
  br label %logical_and_entry_136

logical_and_entry_136:
  br i1 %t168, label %logical_and_right_136, label %logical_and_merge_136

logical_and_right_136:
  %t169 = load %Parser, %Parser* %l1
  %t170 = call %Token @parser_peek_raw(%Parser %t169)
  %t171 = extractvalue %Token %t170, 0
  %t172 = getelementptr inbounds %TokenKind, %TokenKind* %t171, i32 0, i32 0
  %t173 = load i32, i32* %t172
  %t174 = alloca %Statement
  %t175 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 0
  store i32 12, i32* %t175
  %t176 = load i8*, i8** %l4
  %t177 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 1
  %t178 = bitcast [40 x i8]* %t177 to i8*
  %t179 = bitcast i8* %t178 to i8**
  store i8* %t176, i8** %t179
  %t180 = load %Token, %Token* %l2
  %t181 = call noalias i8* @malloc(i64 32)
  %t182 = bitcast i8* %t181 to %Token*
  store %Token %t180, %Token* %t182
  %t183 = bitcast i8* %t181 to %Token*
  %t184 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 1
  %t185 = bitcast [40 x i8]* %t184 to i8*
  %t186 = getelementptr inbounds i8, i8* %t185, i64 8
  %t187 = bitcast i8* %t186 to %Token**
  store %Token* %t183, %Token** %t187
  %t188 = load %Token, %Token* %l3
  %t189 = call noalias i8* @malloc(i64 32)
  %t190 = bitcast i8* %t189 to %Token*
  store %Token %t188, %Token* %t190
  %t191 = bitcast i8* %t189 to %Token*
  %t192 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 1
  %t193 = bitcast [40 x i8]* %t192 to i8*
  %t194 = getelementptr inbounds i8, i8* %t193, i64 16
  %t195 = bitcast i8* %t194 to %Token**
  store %Token* %t191, %Token** %t195
  %t196 = load %Block*, %Block** %l6
  %t197 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 1
  %t198 = bitcast [40 x i8]* %t197 to i8*
  %t199 = getelementptr inbounds i8, i8* %t198, i64 24
  %t200 = bitcast i8* %t199 to %Block**
  store %Block* %t196, %Block** %t200
  %t201 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t202 = getelementptr inbounds %Statement, %Statement* %t174, i32 0, i32 1
  %t203 = bitcast [40 x i8]* %t202 to i8*
  %t204 = getelementptr inbounds i8, i8* %t203, i64 32
  %t205 = bitcast i8* %t204 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t201, { %Decorator**, i64 }** %t205
  %t206 = load %Statement, %Statement* %t174
  store %Statement %t206, %Statement* %l7
  %t207 = load %Parser, %Parser* %l1
  %t208 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
  %t209 = load %Statement, %Statement* %l7
  %t210 = insertvalue %BlockStatementParseResult %t208, %Statement* null, 1
  %t211 = insertvalue %BlockStatementParseResult %t210, i1 1, 2
  ret %BlockStatementParseResult %t211
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
  %l9 = alloca %Block*
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
  %t9 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
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
  store %Parser zeroinitializer, %Parser* %l1
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
  %t82 = insertvalue %WithClause undef, %Expression* null, 0
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
  %t96 = getelementptr %Block, %Block* %t95, i32 0, i32 0
  %t97 = load { %Token**, i64 }*, { %Token**, i64 }** %t96
  %t98 = load { %Token**, i64 }, { %Token**, i64 }* %t97
  %t99 = extractvalue { %Token**, i64 } %t98, 1
  %t100 = icmp eq i64 %t99, 0
  %t101 = load %Parser, %Parser* %l0
  %t102 = load %Parser, %Parser* %l1
  %t103 = load %CaptureResult, %CaptureResult* %l2
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t105 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %l4
  %t106 = load double, double* %l5
  %t107 = load %BlockParseResult, %BlockParseResult* %l8
  br i1 %t100, label %then10, label %merge11
then10:
  %t108 = load %Parser, %Parser* %l0
  %t109 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
  %t110 = bitcast i8* null to %Statement*
  %t111 = insertvalue %BlockStatementParseResult %t109, %Statement* %t110, 1
  %t112 = insertvalue %BlockStatementParseResult %t111, i1 0, 2
  ret %BlockStatementParseResult %t112
merge11:
  %t113 = load %BlockParseResult, %BlockParseResult* %l8
  %t114 = extractvalue %BlockParseResult %t113, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t115 = load %BlockParseResult, %BlockParseResult* %l8
  %t116 = extractvalue %BlockParseResult %t115, 1
  store %Block* %t116, %Block** %l9
  %t117 = load %Parser, %Parser* %l1
  %t118 = call %Parser @skip_trivia(%Parser %t117)
  store %Parser %t118, %Parser* %l1
  %t120 = load %Parser, %Parser* %l1
  %t121 = call %Token @parser_peek_raw(%Parser %t120)
  %t122 = extractvalue %Token %t121, 0
  %t123 = getelementptr inbounds %TokenKind, %TokenKind* %t122, i32 0, i32 0
  %t124 = load i32, i32* %t123
  %t125 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t126 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t127 = icmp eq i32 %t124, 0
  %t128 = select i1 %t127, i8* %t126, i8* %t125
  %t129 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t130 = icmp eq i32 %t124, 1
  %t131 = select i1 %t130, i8* %t129, i8* %t128
  %t132 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t124, 2
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t124, 3
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t124, 4
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t124, 5
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t124, 6
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t124, 7
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %s150 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.150, i32 0, i32 0
  %t151 = icmp eq i8* %t149, %s150
  br label %logical_and_entry_119

logical_and_entry_119:
  br i1 %t151, label %logical_and_right_119, label %logical_and_merge_119

logical_and_right_119:
  %t152 = load %Parser, %Parser* %l1
  %t153 = call %Token @parser_peek_raw(%Parser %t152)
  %t154 = extractvalue %Token %t153, 0
  %t155 = getelementptr inbounds %TokenKind, %TokenKind* %t154, i32 0, i32 0
  %t156 = load i32, i32* %t155
  %t157 = alloca %Statement
  %t158 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 0
  store i32 13, i32* %t158
  %t159 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %l4
  %t160 = bitcast { %WithClause*, i64 }* %t159 to { %WithClause**, i64 }*
  %t161 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t162 = bitcast [24 x i8]* %t161 to i8*
  %t163 = bitcast i8* %t162 to { %WithClause**, i64 }**
  store { %WithClause**, i64 }* %t160, { %WithClause**, i64 }** %t163
  %t164 = load %Block*, %Block** %l9
  %t165 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t166 = bitcast [24 x i8]* %t165 to i8*
  %t167 = getelementptr inbounds i8, i8* %t166, i64 8
  %t168 = bitcast i8* %t167 to %Block**
  store %Block* %t164, %Block** %t168
  %t169 = bitcast { %Decorator*, i64 }* %decorators to { %Decorator**, i64 }*
  %t170 = getelementptr inbounds %Statement, %Statement* %t157, i32 0, i32 1
  %t171 = bitcast [24 x i8]* %t170 to i8*
  %t172 = getelementptr inbounds i8, i8* %t171, i64 16
  %t173 = bitcast i8* %t172 to { %Decorator**, i64 }**
  store { %Decorator**, i64 }* %t169, { %Decorator**, i64 }** %t173
  %t174 = load %Statement, %Statement* %t157
  store %Statement %t174, %Statement* %l10
  %t175 = load %Parser, %Parser* %l1
  %t176 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
  %t177 = load %Statement, %Statement* %l10
  %t178 = insertvalue %BlockStatementParseResult %t176, %Statement* null, 1
  %t179 = insertvalue %BlockStatementParseResult %t178, i1 1, 2
  ret %BlockStatementParseResult %t179
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
  %t9 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
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
  store %Parser zeroinitializer, %Parser* %l1
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
  %t94 = phi { %Token*, i64 }* [ %t58, %entry ], [ %t92, %loop.latch6 ]
  %t95 = phi double [ %t62, %entry ], [ %t93, %loop.latch6 ]
  store { %Token*, i64 }* %t94, { %Token*, i64 }** %l2
  store double %t95, double* %l6
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
  %t88 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t77, %Token zeroinitializer)
  store { %Token*, i64 }* %t88, { %Token*, i64 }** %l2
  %t89 = load double, double* %l6
  %t90 = sitofp i64 1 to double
  %t91 = fadd double %t89, %t90
  store double %t91, double* %l6
  br label %loop.latch6
loop.latch6:
  %t92 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t93 = load double, double* %l6
  br label %loop.header4
afterloop7:
  %t96 = load %Parser, %Parser* %l1
  %t97 = call %Parser @skip_trivia(%Parser %t96)
  store %Parser %t97, %Parser* %l1
  %t98 = load %Parser, %Parser* %l1
  %t99 = call %Token @parser_peek_raw(%Parser %t98)
  store %Token %t99, %Token* %l7
  %t101 = load %Token, %Token* %l7
  %t102 = extractvalue %Token %t101, 0
  %t103 = getelementptr inbounds %TokenKind, %TokenKind* %t102, i32 0, i32 0
  %t104 = load i32, i32* %t103
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
  br label %logical_and_entry_100

logical_and_entry_100:
  br i1 %t131, label %logical_and_right_100, label %logical_and_merge_100

logical_and_right_100:
  %t132 = load %Token, %Token* %l7
  %t133 = extractvalue %Token %t132, 0
  %t134 = getelementptr inbounds %TokenKind, %TokenKind* %t133, i32 0, i32 0
  %t135 = load i32, i32* %t134
  %t136 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t137 = call double @source_span_from_tokens({ %Token*, i64 }* %t136)
  store double %t137, double* %l8
  %t138 = alloca %Statement
  %t139 = getelementptr inbounds %Statement, %Statement* %t138, i32 0, i32 0
  store i32 20, i32* %t139
  %t140 = load i8*, i8** %l5
  %t141 = bitcast i8* %t140 to %Expression*
  %t142 = getelementptr inbounds %Statement, %Statement* %t138, i32 0, i32 1
  %t143 = bitcast [16 x i8]* %t142 to i8*
  %t144 = bitcast i8* %t143 to %Expression**
  store %Expression* %t141, %Expression** %t144
  %t145 = load double, double* %l8
  %t146 = call noalias i8* @malloc(i64 8)
  %t147 = bitcast i8* %t146 to double*
  store double %t145, double* %t147
  %t148 = bitcast i8* %t146 to %SourceSpan*
  %t149 = getelementptr inbounds %Statement, %Statement* %t138, i32 0, i32 1
  %t150 = bitcast [16 x i8]* %t149 to i8*
  %t151 = getelementptr inbounds i8, i8* %t150, i64 8
  %t152 = bitcast i8* %t151 to %SourceSpan**
  store %SourceSpan* %t148, %SourceSpan** %t152
  %t153 = load %Statement, %Statement* %t138
  store %Statement %t153, %Statement* %l9
  %t154 = load %Parser, %Parser* %l1
  %t155 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
  %t156 = load %Statement, %Statement* %l9
  %t157 = insertvalue %BlockStatementParseResult %t155, %Statement* null, 1
  %t158 = insertvalue %BlockStatementParseResult %t157, i1 1, 2
  ret %BlockStatementParseResult %t158
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
  %t3 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
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
  %t12 = getelementptr inbounds %TokenKind, %TokenKind* %t11, i32 0, i32 0
  %t13 = load i32, i32* %t12
  %t14 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t15 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t16 = icmp eq i32 %t13, 0
  %t17 = select i1 %t16, i8* %t15, i8* %t14
  %t18 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t19 = icmp eq i32 %t13, 1
  %t20 = select i1 %t19, i8* %t18, i8* %t17
  %t21 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t22 = icmp eq i32 %t13, 2
  %t23 = select i1 %t22, i8* %t21, i8* %t20
  %t24 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t13, 3
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %t27 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t28 = icmp eq i32 %t13, 4
  %t29 = select i1 %t28, i8* %t27, i8* %t26
  %t30 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t31 = icmp eq i32 %t13, 5
  %t32 = select i1 %t31, i8* %t30, i8* %t29
  %t33 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t34 = icmp eq i32 %t13, 6
  %t35 = select i1 %t34, i8* %t33, i8* %t32
  %t36 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t37 = icmp eq i32 %t13, 7
  %t38 = select i1 %t37, i8* %t36, i8* %t35
  %s39 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.39, i32 0, i32 0
  %t40 = icmp eq i8* %t38, %s39
  %t41 = load %Parser, %Parser* %l0
  %t42 = load %Token, %Token* %l1
  br i1 %t40, label %then2, label %merge3
then2:
  %t43 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
  %t44 = bitcast i8* null to %Statement*
  %t45 = insertvalue %BlockStatementParseResult %t43, %Statement* %t44, 1
  %t46 = insertvalue %BlockStatementParseResult %t45, i1 0, 2
  ret %BlockStatementParseResult %t46
merge3:
  %t47 = load %Token, %Token* %l1
  %t48 = extractvalue %Token %t47, 0
  %t49 = getelementptr inbounds %TokenKind, %TokenKind* %t48, i32 0, i32 0
  %t50 = load i32, i32* %t49
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
  %t79 = load %Token, %Token* %l1
  br i1 %t77, label %then4, label %merge5
then4:
  %t80 = load %Token, %Token* %l1
  %t81 = extractvalue %Token %t80, 0
  %t82 = getelementptr inbounds %TokenKind, %TokenKind* %t81, i32 0, i32 0
  %t83 = load i32, i32* %t82
  store double 0.0, double* %l2
  %t85 = load double, double* %l2
  br label %merge5
merge5:
  %t86 = load %Parser, %Parser* %l0
  %t87 = alloca [1 x i8]
  %t88 = getelementptr [1 x i8], [1 x i8]* %t87, i32 0, i32 0
  %t89 = getelementptr i8, i8* %t88, i64 0
  store i8 59, i8* %t89
  %t90 = alloca { i8*, i64 }
  %t91 = getelementptr { i8*, i64 }, { i8*, i64 }* %t90, i32 0, i32 0
  store i8* %t88, i8** %t91
  %t92 = getelementptr { i8*, i64 }, { i8*, i64 }* %t90, i32 0, i32 1
  store i64 1, i64* %t92
  %t93 = bitcast { i8*, i64 }* %t90 to { i8**, i64 }*
  %t94 = call %CaptureResult @collect_until(%Parser %t86, { i8**, i64 }* %t93)
  store %CaptureResult %t94, %CaptureResult* %l3
  %t95 = load %CaptureResult, %CaptureResult* %l3
  %t96 = extractvalue %CaptureResult %t95, 1
  %t97 = load { %Token**, i64 }, { %Token**, i64 }* %t96
  %t98 = extractvalue { %Token**, i64 } %t97, 1
  %t99 = icmp eq i64 %t98, 0
  %t100 = load %Parser, %Parser* %l0
  %t101 = load %Token, %Token* %l1
  %t102 = load %CaptureResult, %CaptureResult* %l3
  br i1 %t99, label %then6, label %merge7
then6:
  %t103 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
  %t104 = bitcast i8* null to %Statement*
  %t105 = insertvalue %BlockStatementParseResult %t103, %Statement* %t104, 1
  %t106 = insertvalue %BlockStatementParseResult %t105, i1 0, 2
  ret %BlockStatementParseResult %t106
merge7:
  %t107 = alloca [0 x %Token]
  %t108 = getelementptr [0 x %Token], [0 x %Token]* %t107, i32 0, i32 0
  %t109 = alloca { %Token*, i64 }
  %t110 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t109, i32 0, i32 0
  store %Token* %t108, %Token** %t110
  %t111 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t109, i32 0, i32 1
  store i64 0, i64* %t111
  store { %Token*, i64 }* %t109, { %Token*, i64 }** %l4
  %t112 = sitofp i64 0 to double
  store double %t112, double* %l5
  %t113 = load %Parser, %Parser* %l0
  %t114 = load %Token, %Token* %l1
  %t115 = load %CaptureResult, %CaptureResult* %l3
  %t116 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t117 = load double, double* %l5
  br label %loop.header8
loop.header8:
  %t147 = phi { %Token*, i64 }* [ %t116, %entry ], [ %t145, %loop.latch10 ]
  %t148 = phi double [ %t117, %entry ], [ %t146, %loop.latch10 ]
  store { %Token*, i64 }* %t147, { %Token*, i64 }** %l4
  store double %t148, double* %l5
  br label %loop.body9
loop.body9:
  %t118 = load double, double* %l5
  %t119 = load %CaptureResult, %CaptureResult* %l3
  %t120 = extractvalue %CaptureResult %t119, 1
  %t121 = load { %Token**, i64 }, { %Token**, i64 }* %t120
  %t122 = extractvalue { %Token**, i64 } %t121, 1
  %t123 = sitofp i64 %t122 to double
  %t124 = fcmp oge double %t118, %t123
  %t125 = load %Parser, %Parser* %l0
  %t126 = load %Token, %Token* %l1
  %t127 = load %CaptureResult, %CaptureResult* %l3
  %t128 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t129 = load double, double* %l5
  br i1 %t124, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t130 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t131 = load %CaptureResult, %CaptureResult* %l3
  %t132 = extractvalue %CaptureResult %t131, 1
  %t133 = load double, double* %l5
  %t134 = fptosi double %t133 to i64
  %t135 = load { %Token**, i64 }, { %Token**, i64 }* %t132
  %t136 = extractvalue { %Token**, i64 } %t135, 0
  %t137 = extractvalue { %Token**, i64 } %t135, 1
  %t138 = icmp uge i64 %t134, %t137
  ; bounds check: %t138 (if true, out of bounds)
  %t139 = getelementptr %Token*, %Token** %t136, i64 %t134
  %t140 = load %Token*, %Token** %t139
  %t141 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t130, %Token zeroinitializer)
  store { %Token*, i64 }* %t141, { %Token*, i64 }** %l4
  %t142 = load double, double* %l5
  %t143 = sitofp i64 1 to double
  %t144 = fadd double %t142, %t143
  store double %t144, double* %l5
  br label %loop.latch10
loop.latch10:
  %t145 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t146 = load double, double* %l5
  br label %loop.header8
afterloop11:
  %t149 = load %CaptureResult, %CaptureResult* %l3
  %t150 = extractvalue %CaptureResult %t149, 1
  %t151 = bitcast { %Token**, i64 }* %t150 to { %Token*, i64 }*
  %t152 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t151)
  store { %Token*, i64 }* %t152, { %Token*, i64 }** %l6
  %t153 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  %t154 = load { %Token*, i64 }, { %Token*, i64 }* %t153
  %t155 = extractvalue { %Token*, i64 } %t154, 1
  %t156 = icmp eq i64 %t155, 0
  %t157 = load %Parser, %Parser* %l0
  %t158 = load %Token, %Token* %l1
  %t159 = load %CaptureResult, %CaptureResult* %l3
  %t160 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t161 = load double, double* %l5
  %t162 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  br i1 %t156, label %then14, label %merge15
then14:
  %t163 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
  %t164 = bitcast i8* null to %Statement*
  %t165 = insertvalue %BlockStatementParseResult %t163, %Statement* %t164, 1
  %t166 = insertvalue %BlockStatementParseResult %t165, i1 0, 2
  ret %BlockStatementParseResult %t166
merge15:
  %t167 = load %CaptureResult, %CaptureResult* %l3
  %t168 = extractvalue %CaptureResult %t167, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t169 = load %Parser, %Parser* %l0
  %t170 = call %Parser @skip_trivia(%Parser %t169)
  store %Parser %t170, %Parser* %l0
  %t171 = load %Parser, %Parser* %l0
  %t172 = call %Token @parser_peek_raw(%Parser %t171)
  store %Token %t172, %Token* %l7
  %t174 = load %Token, %Token* %l7
  %t175 = extractvalue %Token %t174, 0
  %t176 = getelementptr inbounds %TokenKind, %TokenKind* %t175, i32 0, i32 0
  %t177 = load i32, i32* %t176
  %t178 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t179 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t177, 0
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t177, 1
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t177, 2
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %t188 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t177, 3
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %t191 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t192 = icmp eq i32 %t177, 4
  %t193 = select i1 %t192, i8* %t191, i8* %t190
  %t194 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t195 = icmp eq i32 %t177, 5
  %t196 = select i1 %t195, i8* %t194, i8* %t193
  %t197 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t198 = icmp eq i32 %t177, 6
  %t199 = select i1 %t198, i8* %t197, i8* %t196
  %t200 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t201 = icmp eq i32 %t177, 7
  %t202 = select i1 %t201, i8* %t200, i8* %t199
  %s203 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.203, i32 0, i32 0
  %t204 = icmp ne i8* %t202, %s203
  br label %logical_or_entry_173

logical_or_entry_173:
  br i1 %t204, label %logical_or_merge_173, label %logical_or_right_173

logical_or_right_173:
  %t205 = load %Token, %Token* %l7
  %t206 = extractvalue %Token %t205, 0
  %t207 = getelementptr inbounds %TokenKind, %TokenKind* %t206, i32 0, i32 0
  %t208 = load i32, i32* %t207
  %t209 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t210 = load %Token, %Token* %l7
  %t211 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t209, %Token %t210)
  store { %Token*, i64 }* %t211, { %Token*, i64 }** %l4
  %t212 = load %Parser, %Parser* %l0
  %t213 = call %Parser @parser_advance_raw(%Parser %t212)
  store %Parser %t213, %Parser* %l0
  %t214 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  %t215 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t214)
  store %Expression %t215, %Expression* %l8
  %t216 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t217 = call double @source_span_from_tokens({ %Token*, i64 }* %t216)
  store double %t217, double* %l9
  %t218 = alloca %Statement
  %t219 = getelementptr inbounds %Statement, %Statement* %t218, i32 0, i32 0
  store i32 21, i32* %t219
  %t220 = load %Expression, %Expression* %l8
  %t221 = call noalias i8* @malloc(i64 32)
  %t222 = bitcast i8* %t221 to %Expression*
  store %Expression %t220, %Expression* %t222
  %t223 = bitcast i8* %t221 to %Expression*
  %t224 = getelementptr inbounds %Statement, %Statement* %t218, i32 0, i32 1
  %t225 = bitcast [16 x i8]* %t224 to i8*
  %t226 = bitcast i8* %t225 to %Expression**
  store %Expression* %t223, %Expression** %t226
  %t227 = load double, double* %l9
  %t228 = call noalias i8* @malloc(i64 8)
  %t229 = bitcast i8* %t228 to double*
  store double %t227, double* %t229
  %t230 = bitcast i8* %t228 to %SourceSpan*
  %t231 = getelementptr inbounds %Statement, %Statement* %t218, i32 0, i32 1
  %t232 = bitcast [16 x i8]* %t231 to i8*
  %t233 = getelementptr inbounds i8, i8* %t232, i64 8
  %t234 = bitcast i8* %t233 to %SourceSpan**
  store %SourceSpan* %t230, %SourceSpan** %t234
  %t235 = load %Statement, %Statement* %t218
  store %Statement %t235, %Statement* %l10
  %t236 = load %Parser, %Parser* %l0
  %t237 = insertvalue %BlockStatementParseResult undef, %Parser* null, 0
  %t238 = load %Statement, %Statement* %l10
  %t239 = insertvalue %BlockStatementParseResult %t237, %Statement* null, 1
  %t240 = insertvalue %BlockStatementParseResult %t239, i1 1, 2
  ret %BlockStatementParseResult %t240
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
  %t101 = phi { %Token*, i64 }* [ %t10, %entry ], [ %t99, %loop.latch2 ]
  %t102 = phi %Parser [ %t11, %entry ], [ %t100, %loop.latch2 ]
  store { %Token*, i64 }* %t101, { %Token*, i64 }** %l1
  store %Parser %t102, %Parser* %l2
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
  %t20 = getelementptr inbounds %TokenKind, %TokenKind* %t19, i32 0, i32 0
  %t21 = load i32, i32* %t20
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
  %t49 = load %Parser, %Parser* %l0
  %t50 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t51 = load %Parser, %Parser* %l2
  %t52 = load double, double* %l3
  %t53 = load %Token, %Token* %l4
  br i1 %t48, label %then4, label %merge5
then4:
  %t54 = load %Token, %Token* %l4
  %t55 = extractvalue %Token %t54, 0
  %t56 = getelementptr inbounds %TokenKind, %TokenKind* %t55, i32 0, i32 0
  %t57 = load i32, i32* %t56
  store double 0.0, double* %l5
  %t58 = load double, double* %l5
  br label %merge5
merge5:
  %t59 = load %Token, %Token* %l4
  %t60 = extractvalue %Token %t59, 0
  %t61 = getelementptr inbounds %TokenKind, %TokenKind* %t60, i32 0, i32 0
  %t62 = load i32, i32* %t61
  %t63 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t64 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t62, 0
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t62, 1
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t62, 2
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t62, 3
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %t76 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t62, 4
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %t79 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t62, 5
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t62, 6
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %t85 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t62, 7
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %s88 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.88, i32 0, i32 0
  %t89 = icmp eq i8* %t87, %s88
  %t90 = load %Parser, %Parser* %l0
  %t91 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t92 = load %Parser, %Parser* %l2
  %t93 = load double, double* %l3
  %t94 = load %Token, %Token* %l4
  br i1 %t89, label %then6, label %merge7
then6:
  %t95 = load %Parser, %Parser* %l2
  %t96 = call %Parser @parser_advance_raw(%Parser %t95)
  store %Parser %t96, %Parser* %l2
  br label %afterloop3
merge7:
  %t97 = load %Parser, %Parser* %l2
  %t98 = call %Parser @parser_advance_raw(%Parser %t97)
  store %Parser %t98, %Parser* %l2
  br label %loop.latch2
loop.latch2:
  %t99 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t100 = load %Parser, %Parser* %l2
  br label %loop.header0
afterloop3:
  %t103 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t104 = call i8* @tokens_to_text({ %Token*, i64 }* %t103)
  store i8* %t104, i8** %l6
  %t105 = alloca %Statement
  %t106 = getelementptr inbounds %Statement, %Statement* %t105, i32 0, i32 0
  store i32 22, i32* %t106
  %t107 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t108 = bitcast { %Token*, i64 }* %t107 to { %Token**, i64 }*
  %t109 = getelementptr inbounds %Statement, %Statement* %t105, i32 0, i32 1
  %t110 = bitcast [16 x i8]* %t109 to i8*
  %t111 = bitcast i8* %t110 to { %Token**, i64 }**
  store { %Token**, i64 }* %t108, { %Token**, i64 }** %t111
  %t112 = load i8*, i8** %l6
  %t113 = getelementptr inbounds %Statement, %Statement* %t105, i32 0, i32 1
  %t114 = bitcast [16 x i8]* %t113 to i8*
  %t115 = getelementptr inbounds i8, i8* %t114, i64 8
  %t116 = bitcast i8* %t115 to i8**
  store i8* %t112, i8** %t116
  %t117 = load %Statement, %Statement* %t105
  store %Statement %t117, %Statement* %l7
  %t118 = load %Parser, %Parser* %l2
  %t119 = call %Parser @skip_trivia(%Parser %t118)
  store %Parser %t119, %Parser* %l0
  %t120 = load %Parser, %Parser* %l0
  %t121 = insertvalue %StatementParseResult undef, %Parser* null, 0
  %t122 = load %Statement, %Statement* %l7
  %t123 = insertvalue %StatementParseResult %t121, %Statement* null, 1
  ret %StatementParseResult %t123
}

define i1 @identifier_matches(%Token %token, i8* %expected) {
entry:
  %t0 = extractvalue %Token %token, 0
  %t1 = getelementptr inbounds %TokenKind, %TokenKind* %t0, i32 0, i32 0
  %t2 = load i32, i32* %t1
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
  %t29 = icmp ne i8* %t27, %s28
  br i1 %t29, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t30 = extractvalue %Token %token, 0
  %t31 = getelementptr inbounds %TokenKind, %TokenKind* %t30, i32 0, i32 0
  %t32 = load i32, i32* %t31
  %t33 = extractvalue %Token %token, 1
  %t34 = icmp eq i8* %t33, %expected
  ret i1 %t34
}

define i8* @identifier_text(%Token %token) {
entry:
  %l0 = alloca double
  %t0 = extractvalue %Token %token, 0
  %t1 = getelementptr inbounds %TokenKind, %TokenKind* %t0, i32 0, i32 0
  %t2 = load i32, i32* %t1
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
  br i1 %t29, label %then0, label %merge1
then0:
  %t30 = extractvalue %Token %token, 0
  %t31 = getelementptr inbounds %TokenKind, %TokenKind* %t30, i32 0, i32 0
  %t32 = load i32, i32* %t31
  store double 0.0, double* %l0
  %t33 = load double, double* %l0
  br label %merge1
merge1:
  %t34 = extractvalue %Token %token, 1
  ret i8* %t34
}

define i8* @string_literal_value(%Token %token) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %t0 = extractvalue %Token %token, 0
  %t1 = getelementptr inbounds %TokenKind, %TokenKind* %t0, i32 0, i32 0
  %t2 = load i32, i32* %t1
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
  %s28 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.28, i32 0, i32 0
  %t29 = icmp eq i8* %t27, %s28
  br i1 %t29, label %then0, label %merge1
then0:
  %t30 = extractvalue %Token %token, 0
  %t31 = getelementptr inbounds %TokenKind, %TokenKind* %t30, i32 0, i32 0
  %t32 = load i32, i32* %t31
  store double 0.0, double* %l0
  %t33 = load double, double* %l0
  br label %merge1
merge1:
  %t34 = extractvalue %Token %token, 1
  store i8* %t34, i8** %l1
  %t35 = load i8*, i8** %l1
  %t36 = call i8* @strip_surrounding_quotes(i8* %t35)
  ret i8* %t36
}

define %Parser @skip_trivia(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token*
  store %Parser %parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  br label %loop.header0
loop.header0:
  %t28 = phi %Parser [ %t0, %entry ], [ %t27, %loop.latch2 ]
  store %Parser %t28, %Parser* %l0
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
  %t22 = call i1 @is_trivia_token(%Token zeroinitializer)
  %t23 = load %Parser, %Parser* %l0
  %t24 = load %Token*, %Token** %l1
  br i1 %t22, label %then6, label %merge7
then6:
  %t25 = load %Parser, %Parser* %l0
  %t26 = call %Parser @parser_advance_raw(%Parser %t25)
  store %Parser %t26, %Parser* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t27 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t29 = load %Parser, %Parser* %l0
  ret %Parser %t29
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
  ret %Token zeroinitializer
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
  %t7 = getelementptr inbounds %TokenKind, %TokenKind* %t6, i32 0, i32 0
  %t8 = load i32, i32* %t7
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
  br label %logical_and_entry_4

logical_and_entry_4:
  br i1 %t35, label %logical_and_right_4, label %logical_and_merge_4

logical_and_right_4:
  %t36 = load %Token, %Token* %l1
  %t37 = extractvalue %Token %t36, 0
  %t38 = getelementptr inbounds %TokenKind, %TokenKind* %t37, i32 0, i32 0
  %t39 = load i32, i32* %t38
  %t40 = load %Parser, %Parser* %l0
  ret %Parser %t40
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
  %t137 = phi { %Token*, i64 }* [ %t9, %entry ], [ %t135, %loop.latch2 ]
  %t138 = phi %Parser [ %t8, %entry ], [ %t136, %loop.latch2 ]
  store { %Token*, i64 }* %t137, { %Token*, i64 }** %l1
  store %Parser %t138, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t13 = load %Parser, %Parser* %l0
  %t14 = call %Token @parser_peek_raw(%Parser %t13)
  store %Token %t14, %Token* %l5
  %t15 = load %Token, %Token* %l5
  %t16 = extractvalue %Token %t15, 0
  %t17 = getelementptr inbounds %TokenKind, %TokenKind* %t16, i32 0, i32 0
  %t18 = load i32, i32* %t17
  %t19 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t20 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t18, 0
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t18, 1
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t18, 2
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t18, 3
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t18, 4
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t18, 5
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t18, 6
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t18, 7
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %s44 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.44, i32 0, i32 0
  %t45 = icmp eq i8* %t43, %s44
  %t46 = load %Parser, %Parser* %l0
  %t47 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t48 = load double, double* %l2
  %t49 = load double, double* %l3
  %t50 = load double, double* %l4
  %t51 = load %Token, %Token* %l5
  br i1 %t45, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t53 = load double, double* %l2
  %t54 = sitofp i64 0 to double
  %t55 = fcmp oeq double %t53, %t54
  br label %logical_and_entry_52

logical_and_entry_52:
  br i1 %t55, label %logical_and_right_52, label %logical_and_merge_52

logical_and_right_52:
  %t57 = load double, double* %l3
  %t58 = sitofp i64 0 to double
  %t59 = fcmp oeq double %t57, %t58
  br label %logical_and_entry_56

logical_and_entry_56:
  br i1 %t59, label %logical_and_right_56, label %logical_and_merge_56

logical_and_right_56:
  %t60 = load double, double* %l4
  %t61 = sitofp i64 0 to double
  %t62 = fcmp oeq double %t60, %t61
  br label %logical_and_right_end_56

logical_and_right_end_56:
  br label %logical_and_merge_56

logical_and_merge_56:
  %t63 = phi i1 [ false, %logical_and_entry_56 ], [ %t62, %logical_and_right_end_56 ]
  br label %logical_and_right_end_52

logical_and_right_end_52:
  br label %logical_and_merge_52

logical_and_merge_52:
  %t64 = phi i1 [ false, %logical_and_entry_52 ], [ %t63, %logical_and_right_end_52 ]
  store i1 %t64, i1* %l6
  %t65 = load i1, i1* %l6
  %t66 = load %Parser, %Parser* %l0
  %t67 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t68 = load double, double* %l2
  %t69 = load double, double* %l3
  %t70 = load double, double* %l4
  %t71 = load %Token, %Token* %l5
  %t72 = load i1, i1* %l6
  br i1 %t65, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t73 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t74 = load %Token, %Token* %l5
  %t75 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t73, %Token %t74)
  store { %Token*, i64 }* %t75, { %Token*, i64 }** %l1
  %t76 = load %Token, %Token* %l5
  %t77 = extractvalue %Token %t76, 0
  %t78 = getelementptr inbounds %TokenKind, %TokenKind* %t77, i32 0, i32 0
  %t79 = load i32, i32* %t78
  %t80 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t81 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t79, 0
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t79, 1
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %t87 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t88 = icmp eq i32 %t79, 2
  %t89 = select i1 %t88, i8* %t87, i8* %t86
  %t90 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t91 = icmp eq i32 %t79, 3
  %t92 = select i1 %t91, i8* %t90, i8* %t89
  %t93 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t79, 4
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %t96 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t97 = icmp eq i32 %t79, 5
  %t98 = select i1 %t97, i8* %t96, i8* %t95
  %t99 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t79, 6
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t79, 7
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %s105 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.105, i32 0, i32 0
  %t106 = icmp eq i8* %t104, %s105
  %t107 = load %Parser, %Parser* %l0
  %t108 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t109 = load double, double* %l2
  %t110 = load double, double* %l3
  %t111 = load double, double* %l4
  %t112 = load %Token, %Token* %l5
  %t113 = load i1, i1* %l6
  br i1 %t106, label %then8, label %merge9
then8:
  %t114 = load %Token, %Token* %l5
  %t115 = extractvalue %Token %t114, 0
  %t116 = getelementptr inbounds %TokenKind, %TokenKind* %t115, i32 0, i32 0
  %t117 = load i32, i32* %t116
  store double 0.0, double* %l7
  %t118 = load double, double* %l7
  br label %merge9
merge9:
  %t119 = load %Parser, %Parser* %l0
  %t120 = call %Parser @parser_advance_raw(%Parser %t119)
  store %Parser %t120, %Parser* %l8
  %t121 = load %Parser, %Parser* %l8
  %t122 = extractvalue %Parser %t121, 1
  %t123 = load %Parser, %Parser* %l0
  %t124 = extractvalue %Parser %t123, 1
  %t125 = fcmp oeq double %t122, %t124
  %t126 = load %Parser, %Parser* %l0
  %t127 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t128 = load double, double* %l2
  %t129 = load double, double* %l3
  %t130 = load double, double* %l4
  %t131 = load %Token, %Token* %l5
  %t132 = load i1, i1* %l6
  %t133 = load %Parser, %Parser* %l8
  br i1 %t125, label %then10, label %merge11
then10:
  br label %afterloop3
merge11:
  %t134 = load %Parser, %Parser* %l8
  store %Parser %t134, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t135 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t136 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t139 = load %Parser, %Parser* %l0
  %t140 = insertvalue %CaptureResult undef, %Parser* null, 0
  %t141 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t142 = bitcast { %Token*, i64 }* %t141 to { %Token**, i64 }*
  %t143 = insertvalue %CaptureResult %t140, { %Token**, i64 }* %t142, 1
  ret %CaptureResult %t143
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
  %t6 = getelementptr inbounds %TokenKind, %TokenKind* %t5, i32 0, i32 0
  %t7 = load i32, i32* %t6
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
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t34, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %t35 = load %Token, %Token* %l1
  %t36 = extractvalue %Token %t35, 0
  %t37 = getelementptr inbounds %TokenKind, %TokenKind* %t36, i32 0, i32 0
  %t38 = load i32, i32* %t37
  %t39 = load %Parser, %Parser* %l0
  %t40 = call %Parser @parser_advance_raw(%Parser %t39)
  store %Parser %t40, %Parser* %l0
  %t41 = alloca [0 x %Token]
  %t42 = getelementptr [0 x %Token], [0 x %Token]* %t41, i32 0, i32 0
  %t43 = alloca { %Token*, i64 }
  %t44 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t43, i32 0, i32 0
  store %Token* %t42, %Token** %t44
  %t45 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t43, i32 0, i32 1
  store i64 0, i64* %t45
  store { %Token*, i64 }* %t43, { %Token*, i64 }** %l2
  %t46 = sitofp i64 1 to double
  store double %t46, double* %l3
  %t47 = load %Parser, %Parser* %l0
  %t48 = load %Token, %Token* %l1
  %t49 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t50 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t145 = phi { %Token*, i64 }* [ %t49, %entry ], [ %t143, %loop.latch2 ]
  %t146 = phi %Parser [ %t47, %entry ], [ %t144, %loop.latch2 ]
  store { %Token*, i64 }* %t145, { %Token*, i64 }** %l2
  store %Parser %t146, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t51 = load %Parser, %Parser* %l0
  %t52 = call %Token @parser_peek_raw(%Parser %t51)
  store %Token %t52, %Token* %l4
  %t53 = load %Token, %Token* %l4
  %t54 = extractvalue %Token %t53, 0
  %t55 = getelementptr inbounds %TokenKind, %TokenKind* %t54, i32 0, i32 0
  %t56 = load i32, i32* %t55
  %t57 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t58 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t56, 0
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t56, 1
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t56, 2
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t56, 3
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t56, 4
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t56, 5
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %t76 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t56, 6
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %t79 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t56, 7
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %s82 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.82, i32 0, i32 0
  %t83 = icmp eq i8* %t81, %s82
  %t84 = load %Parser, %Parser* %l0
  %t85 = load %Token, %Token* %l1
  %t86 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t87 = load double, double* %l3
  %t88 = load %Token, %Token* %l4
  br i1 %t83, label %then4, label %merge5
then4:
  %t89 = insertvalue %ParenthesizedParseResult undef, %Parser* null, 0
  %t90 = alloca [0 x %Token*]
  %t91 = getelementptr [0 x %Token*], [0 x %Token*]* %t90, i32 0, i32 0
  %t92 = alloca { %Token**, i64 }
  %t93 = getelementptr { %Token**, i64 }, { %Token**, i64 }* %t92, i32 0, i32 0
  store %Token** %t91, %Token*** %t93
  %t94 = getelementptr { %Token**, i64 }, { %Token**, i64 }* %t92, i32 0, i32 1
  store i64 0, i64* %t94
  %t95 = insertvalue %ParenthesizedParseResult %t89, { %Token**, i64 }* %t92, 1
  %t96 = insertvalue %ParenthesizedParseResult %t95, i1 0, 2
  ret %ParenthesizedParseResult %t96
merge5:
  %t97 = load %Token, %Token* %l4
  %t98 = extractvalue %Token %t97, 0
  %t99 = getelementptr inbounds %TokenKind, %TokenKind* %t98, i32 0, i32 0
  %t100 = load i32, i32* %t99
  %t101 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t102 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t100, 0
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t106 = icmp eq i32 %t100, 1
  %t107 = select i1 %t106, i8* %t105, i8* %t104
  %t108 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t100, 2
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t112 = icmp eq i32 %t100, 3
  %t113 = select i1 %t112, i8* %t111, i8* %t110
  %t114 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t100, 4
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %t117 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t118 = icmp eq i32 %t100, 5
  %t119 = select i1 %t118, i8* %t117, i8* %t116
  %t120 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t100, 6
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %t123 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t124 = icmp eq i32 %t100, 7
  %t125 = select i1 %t124, i8* %t123, i8* %t122
  %s126 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.126, i32 0, i32 0
  %t127 = icmp eq i8* %t125, %s126
  %t128 = load %Parser, %Parser* %l0
  %t129 = load %Token, %Token* %l1
  %t130 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t131 = load double, double* %l3
  %t132 = load %Token, %Token* %l4
  br i1 %t127, label %then6, label %merge7
then6:
  %t133 = load %Token, %Token* %l4
  %t134 = extractvalue %Token %t133, 0
  %t135 = getelementptr inbounds %TokenKind, %TokenKind* %t134, i32 0, i32 0
  %t136 = load i32, i32* %t135
  store double 0.0, double* %l5
  %t137 = load double, double* %l5
  br label %merge7
merge7:
  %t138 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t139 = load %Token, %Token* %l4
  %t140 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t138, %Token %t139)
  store { %Token*, i64 }* %t140, { %Token*, i64 }** %l2
  %t141 = load %Parser, %Parser* %l0
  %t142 = call %Parser @parser_advance_raw(%Parser %t141)
  store %Parser %t142, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t143 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t144 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t147 = load %Parser, %Parser* %l0
  %t148 = insertvalue %ParenthesizedParseResult undef, %Parser* null, 0
  %t149 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t150 = bitcast { %Token*, i64 }* %t149 to { %Token**, i64 }*
  %t151 = insertvalue %ParenthesizedParseResult %t148, { %Token**, i64 }* %t150, 1
  %t152 = insertvalue %ParenthesizedParseResult %t151, i1 1, 2
  ret %ParenthesizedParseResult %t152
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
  %t118 = phi { %Token*, i64 }* [ %t7, %entry ], [ %t116, %loop.latch2 ]
  %t119 = phi %Parser [ %t6, %entry ], [ %t117, %loop.latch2 ]
  store { %Token*, i64 }* %t118, { %Token*, i64 }** %l1
  store %Parser %t119, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t8 = load %Parser, %Parser* %l0
  %t9 = call %Token @parser_peek_raw(%Parser %t8)
  store %Token %t9, %Token* %l2
  %t10 = load %Token, %Token* %l2
  %t11 = extractvalue %Token %t10, 0
  %t12 = getelementptr inbounds %TokenKind, %TokenKind* %t11, i32 0, i32 0
  %t13 = load i32, i32* %t12
  %t14 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t15 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t16 = icmp eq i32 %t13, 0
  %t17 = select i1 %t16, i8* %t15, i8* %t14
  %t18 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t19 = icmp eq i32 %t13, 1
  %t20 = select i1 %t19, i8* %t18, i8* %t17
  %t21 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t22 = icmp eq i32 %t13, 2
  %t23 = select i1 %t22, i8* %t21, i8* %t20
  %t24 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t13, 3
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %t27 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t28 = icmp eq i32 %t13, 4
  %t29 = select i1 %t28, i8* %t27, i8* %t26
  %t30 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t31 = icmp eq i32 %t13, 5
  %t32 = select i1 %t31, i8* %t30, i8* %t29
  %t33 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t34 = icmp eq i32 %t13, 6
  %t35 = select i1 %t34, i8* %t33, i8* %t32
  %t36 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t37 = icmp eq i32 %t13, 7
  %t38 = select i1 %t37, i8* %t36, i8* %t35
  %s39 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.39, i32 0, i32 0
  %t40 = icmp eq i8* %t38, %s39
  %t41 = load %Parser, %Parser* %l0
  %t42 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t43 = load %Token, %Token* %l2
  br i1 %t40, label %then4, label %merge5
then4:
  %t44 = insertvalue %PatternCaptureResult undef, %Parser* null, 0
  %t45 = alloca [0 x %Token*]
  %t46 = getelementptr [0 x %Token*], [0 x %Token*]* %t45, i32 0, i32 0
  %t47 = alloca { %Token**, i64 }
  %t48 = getelementptr { %Token**, i64 }, { %Token**, i64 }* %t47, i32 0, i32 0
  store %Token** %t46, %Token*** %t48
  %t49 = getelementptr { %Token**, i64 }, { %Token**, i64 }* %t47, i32 0, i32 1
  store i64 0, i64* %t49
  %t50 = insertvalue %PatternCaptureResult %t44, { %Token**, i64 }* %t47, 1
  %t51 = insertvalue %PatternCaptureResult %t50, i1 0, 2
  ret %PatternCaptureResult %t51
merge5:
  %t52 = load %Token, %Token* %l2
  %t53 = extractvalue %Token %t52, 0
  %t54 = getelementptr inbounds %TokenKind, %TokenKind* %t53, i32 0, i32 0
  %t55 = load i32, i32* %t54
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
  %t83 = load %Parser, %Parser* %l0
  %t84 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t85 = load %Token, %Token* %l2
  br i1 %t82, label %then6, label %merge7
then6:
  %t86 = load %Token, %Token* %l2
  %t87 = extractvalue %Token %t86, 0
  %t88 = getelementptr inbounds %TokenKind, %TokenKind* %t87, i32 0, i32 0
  %t89 = load i32, i32* %t88
  store double 0.0, double* %l3
  %t91 = load double, double* %l3
  %s92 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.92, i32 0, i32 0
  br label %merge7
merge7:
  %t93 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t94 = load %Token, %Token* %l2
  %t95 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t93, %Token %t94)
  store { %Token*, i64 }* %t95, { %Token*, i64 }** %l1
  %t96 = load %Parser, %Parser* %l0
  %t97 = call %Parser @parser_advance_raw(%Parser %t96)
  store %Parser %t97, %Parser* %l4
  %t98 = load %Parser, %Parser* %l4
  %t99 = extractvalue %Parser %t98, 1
  %t100 = load %Parser, %Parser* %l0
  %t101 = extractvalue %Parser %t100, 1
  %t102 = fcmp oeq double %t99, %t101
  %t103 = load %Parser, %Parser* %l0
  %t104 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t105 = load %Token, %Token* %l2
  %t106 = load %Parser, %Parser* %l4
  br i1 %t102, label %then8, label %merge9
then8:
  %t107 = insertvalue %PatternCaptureResult undef, %Parser* null, 0
  %t108 = alloca [0 x %Token*]
  %t109 = getelementptr [0 x %Token*], [0 x %Token*]* %t108, i32 0, i32 0
  %t110 = alloca { %Token**, i64 }
  %t111 = getelementptr { %Token**, i64 }, { %Token**, i64 }* %t110, i32 0, i32 0
  store %Token** %t109, %Token*** %t111
  %t112 = getelementptr { %Token**, i64 }, { %Token**, i64 }* %t110, i32 0, i32 1
  store i64 0, i64* %t112
  %t113 = insertvalue %PatternCaptureResult %t107, { %Token**, i64 }* %t110, 1
  %t114 = insertvalue %PatternCaptureResult %t113, i1 0, 2
  ret %PatternCaptureResult %t114
merge9:
  %t115 = load %Parser, %Parser* %l4
  store %Parser %t115, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t116 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t117 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t120 = load %Parser, %Parser* %l0
  %t121 = insertvalue %PatternCaptureResult undef, %Parser* null, 0
  %t122 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t123 = bitcast { %Token*, i64 }* %t122 to { %Token**, i64 }*
  %t124 = insertvalue %PatternCaptureResult %t121, { %Token**, i64 }* %t123, 1
  %t125 = insertvalue %PatternCaptureResult %t124, i1 1, 2
  ret %PatternCaptureResult %t125
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
  %t67 = getelementptr inbounds %TokenKind, %TokenKind* %t66, i32 0, i32 0
  %t68 = load i32, i32* %t67
  %t69 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t70 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t68, 0
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t68, 1
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %t76 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t68, 2
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %t79 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t68, 3
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t68, 4
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %t85 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t68, 5
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t68, 6
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t68, 7
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %s94 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.94, i32 0, i32 0
  %t95 = icmp eq i8* %t93, %s94
  %t96 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t97 = load %Token, %Token* %l1
  br i1 %t95, label %then4, label %merge5
then4:
  %t98 = alloca %Expression
  %t99 = getelementptr inbounds %Expression, %Expression* %t98, i32 0, i32 0
  store i32 2, i32* %t99
  %t100 = load %Token, %Token* %l1
  %t101 = extractvalue %Token %t100, 0
  %t102 = getelementptr inbounds %TokenKind, %TokenKind* %t101, i32 0, i32 0
  %t103 = load i32, i32* %t102
  %t104 = getelementptr inbounds %TokenKind, %TokenKind* %t101, i32 0, i32 1
  %t105 = bitcast [8 x i8]* %t104 to i8*
  %t106 = bitcast i8* %t105 to i8**
  %t107 = load i8*, i8** %t106
  %t108 = icmp eq i32 %t103, 0
  %t109 = select i1 %t108, i8* %t107, i8* null
  %t110 = getelementptr inbounds %TokenKind, %TokenKind* %t101, i32 0, i32 1
  %t111 = bitcast [8 x i8]* %t110 to i8*
  %t112 = bitcast i8* %t111 to i8**
  %t113 = load i8*, i8** %t112
  %t114 = icmp eq i32 %t103, 1
  %t115 = select i1 %t114, i8* %t113, i8* %t109
  %t116 = getelementptr inbounds %TokenKind, %TokenKind* %t101, i32 0, i32 1
  %t117 = bitcast [8 x i8]* %t116 to i8*
  %t118 = bitcast i8* %t117 to i8**
  %t119 = load i8*, i8** %t118
  %t120 = icmp eq i32 %t103, 2
  %t121 = select i1 %t120, i8* %t119, i8* %t115
  %t122 = getelementptr inbounds %TokenKind, %TokenKind* %t101, i32 0, i32 1
  %t123 = bitcast [8 x i8]* %t122 to i8*
  %t124 = bitcast i8* %t123 to i8**
  %t125 = load i8*, i8** %t124
  %t126 = icmp eq i32 %t103, 4
  %t127 = select i1 %t126, i8* %t125, i8* %t121
  %t128 = getelementptr inbounds %Expression, %Expression* %t98, i32 0, i32 1
  %t129 = bitcast [8 x i8]* %t128 to i8*
  %t130 = bitcast i8* %t129 to i8**
  store i8* %t127, i8** %t130
  %t131 = load %Expression, %Expression* %t98
  ret %Expression %t131
merge5:
  %t132 = load %Token, %Token* %l1
  %t133 = extractvalue %Token %t132, 0
  %t134 = getelementptr inbounds %TokenKind, %TokenKind* %t133, i32 0, i32 0
  %t135 = load i32, i32* %t134
  %t136 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t137 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t135, 0
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t135, 1
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t135, 2
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t135, 3
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t135, 4
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t135, 5
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t135, 6
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t135, 7
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %s161 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.161, i32 0, i32 0
  %t162 = icmp eq i8* %t160, %s161
  %t163 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t164 = load %Token, %Token* %l1
  br i1 %t162, label %then6, label %merge7
then6:
  %t165 = alloca %Expression
  %t166 = getelementptr inbounds %Expression, %Expression* %t165, i32 0, i32 0
  store i32 3, i32* %t166
  %t167 = load %Token, %Token* %l1
  %t168 = extractvalue %Token %t167, 0
  %t169 = getelementptr inbounds %TokenKind, %TokenKind* %t168, i32 0, i32 0
  %t170 = load i32, i32* %t169
  %t171 = getelementptr inbounds %TokenKind, %TokenKind* %t168, i32 0, i32 1
  %t172 = bitcast [1 x i8]* %t171 to i8*
  %t173 = bitcast i8* %t172 to i1*
  %t174 = load i1, i1* %t173
  %t175 = icmp eq i32 %t170, 3
  %t176 = select i1 %t175, i1 %t174, i1 false
  %t177 = getelementptr inbounds %Expression, %Expression* %t165, i32 0, i32 1
  %t178 = bitcast [1 x i8]* %t177 to i8*
  %t179 = bitcast i8* %t178 to i1*
  store i1 %t176, i1* %t179
  %t180 = load %Expression, %Expression* %t165
  ret %Expression %t180
merge7:
  %t181 = load %Token, %Token* %l1
  %t182 = extractvalue %Token %t181, 0
  %t183 = getelementptr inbounds %TokenKind, %TokenKind* %t182, i32 0, i32 0
  %t184 = load i32, i32* %t183
  %t185 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t186 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t187 = icmp eq i32 %t184, 0
  %t188 = select i1 %t187, i8* %t186, i8* %t185
  %t189 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t190 = icmp eq i32 %t184, 1
  %t191 = select i1 %t190, i8* %t189, i8* %t188
  %t192 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t193 = icmp eq i32 %t184, 2
  %t194 = select i1 %t193, i8* %t192, i8* %t191
  %t195 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t196 = icmp eq i32 %t184, 3
  %t197 = select i1 %t196, i8* %t195, i8* %t194
  %t198 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t199 = icmp eq i32 %t184, 4
  %t200 = select i1 %t199, i8* %t198, i8* %t197
  %t201 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t202 = icmp eq i32 %t184, 5
  %t203 = select i1 %t202, i8* %t201, i8* %t200
  %t204 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t205 = icmp eq i32 %t184, 6
  %t206 = select i1 %t205, i8* %t204, i8* %t203
  %t207 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t208 = icmp eq i32 %t184, 7
  %t209 = select i1 %t208, i8* %t207, i8* %t206
  %s210 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.210, i32 0, i32 0
  %t211 = icmp eq i8* %t209, %s210
  %t212 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t213 = load %Token, %Token* %l1
  br i1 %t211, label %then8, label %merge9
then8:
  %t214 = alloca %Expression
  %t215 = getelementptr inbounds %Expression, %Expression* %t214, i32 0, i32 0
  store i32 1, i32* %t215
  %t216 = load %Token, %Token* %l1
  %t217 = extractvalue %Token %t216, 0
  %t218 = getelementptr inbounds %TokenKind, %TokenKind* %t217, i32 0, i32 0
  %t219 = load i32, i32* %t218
  %t220 = getelementptr inbounds %TokenKind, %TokenKind* %t217, i32 0, i32 1
  %t221 = bitcast [8 x i8]* %t220 to i8*
  %t222 = bitcast i8* %t221 to i8**
  %t223 = load i8*, i8** %t222
  %t224 = icmp eq i32 %t219, 0
  %t225 = select i1 %t224, i8* %t223, i8* null
  %t226 = getelementptr inbounds %TokenKind, %TokenKind* %t217, i32 0, i32 1
  %t227 = bitcast [8 x i8]* %t226 to i8*
  %t228 = bitcast i8* %t227 to i8**
  %t229 = load i8*, i8** %t228
  %t230 = icmp eq i32 %t219, 1
  %t231 = select i1 %t230, i8* %t229, i8* %t225
  %t232 = getelementptr inbounds %TokenKind, %TokenKind* %t217, i32 0, i32 1
  %t233 = bitcast [8 x i8]* %t232 to i8*
  %t234 = bitcast i8* %t233 to i8**
  %t235 = load i8*, i8** %t234
  %t236 = icmp eq i32 %t219, 2
  %t237 = select i1 %t236, i8* %t235, i8* %t231
  %t238 = getelementptr inbounds %TokenKind, %TokenKind* %t217, i32 0, i32 1
  %t239 = bitcast [8 x i8]* %t238 to i8*
  %t240 = bitcast i8* %t239 to i8**
  %t241 = load i8*, i8** %t240
  %t242 = icmp eq i32 %t219, 4
  %t243 = select i1 %t242, i8* %t241, i8* %t237
  %t244 = getelementptr inbounds %Expression, %Expression* %t214, i32 0, i32 1
  %t245 = bitcast [8 x i8]* %t244 to i8*
  %t246 = bitcast i8* %t245 to i8**
  store i8* %t243, i8** %t246
  %t247 = load %Expression, %Expression* %t214
  ret %Expression %t247
merge9:
  br label %merge3
merge3:
  %t248 = extractvalue %Expression %expr, 0
  %t249 = alloca %Expression
  store %Expression %expr, %Expression* %t249
  %t250 = getelementptr inbounds %Expression, %Expression* %t249, i32 0, i32 1
  %t251 = bitcast [8 x i8]* %t250 to i8*
  %t252 = bitcast i8* %t251 to i8**
  %t253 = load i8*, i8** %t252
  %t254 = icmp eq i32 %t248, 15
  %t255 = select i1 %t254, i8* %t253, i8* null
  %t256 = call i8* @trim_text(i8* %t255)
  store i8* %t256, i8** %l2
  %t258 = load i8*, i8** %l2
  %t259 = call i64 @sailfin_runtime_string_length(i8* %t258)
  %t260 = icmp sge i64 %t259, 2
  br label %logical_and_entry_257

logical_and_entry_257:
  br i1 %t260, label %logical_and_right_257, label %logical_and_merge_257

logical_and_right_257:
  %t262 = load i8*, i8** %l2
  %t263 = call double @char_at(i8* %t262, i64 0)
  %t264 = load i8*, i8** %l2
  %s265 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.265, i32 0, i32 0
  %t266 = icmp eq i8* %t264, %s265
  %t267 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t268 = load i8*, i8** %l2
  br i1 %t266, label %then10, label %merge11
then10:
  %t269 = alloca %Expression
  %t270 = getelementptr inbounds %Expression, %Expression* %t269, i32 0, i32 0
  store i32 3, i32* %t270
  %t271 = getelementptr inbounds %Expression, %Expression* %t269, i32 0, i32 1
  %t272 = bitcast [1 x i8]* %t271 to i8*
  %t273 = bitcast i8* %t272 to i1*
  store i1 1, i1* %t273
  %t274 = load %Expression, %Expression* %t269
  ret %Expression %t274
merge11:
  %t275 = load i8*, i8** %l2
  %s276 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.276, i32 0, i32 0
  %t277 = icmp eq i8* %t275, %s276
  %t278 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t279 = load i8*, i8** %l2
  br i1 %t277, label %then12, label %merge13
then12:
  %t280 = alloca %Expression
  %t281 = getelementptr inbounds %Expression, %Expression* %t280, i32 0, i32 0
  store i32 3, i32* %t281
  %t282 = getelementptr inbounds %Expression, %Expression* %t280, i32 0, i32 1
  %t283 = bitcast [1 x i8]* %t282 to i8*
  %t284 = bitcast i8* %t283 to i1*
  store i1 0, i1* %t284
  %t285 = load %Expression, %Expression* %t280
  ret %Expression %t285
merge13:
  %t286 = load i8*, i8** %l2
  %t287 = call i1 @looks_like_number(i8* %t286)
  %t288 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t289 = load i8*, i8** %l2
  br i1 %t287, label %then14, label %merge15
then14:
  %t290 = alloca %Expression
  %t291 = getelementptr inbounds %Expression, %Expression* %t290, i32 0, i32 0
  store i32 1, i32* %t291
  %t292 = load i8*, i8** %l2
  %t293 = getelementptr inbounds %Expression, %Expression* %t290, i32 0, i32 1
  %t294 = bitcast [8 x i8]* %t293 to i8*
  %t295 = bitcast i8* %t294 to i8**
  store i8* %t292, i8** %t295
  %t296 = load %Expression, %Expression* %t290
  ret %Expression %t296
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
  %t1 = getelementptr i8, i8* %ch, i64 0
  %t2 = load i8, i8* %t1
  %t3 = icmp eq i8 %t2, 48
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t3, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t5 = getelementptr i8, i8* %ch, i64 0
  %t6 = load i8, i8* %t5
  %t7 = icmp eq i8 %t6, 49
  br label %logical_or_entry_4

logical_or_entry_4:
  br i1 %t7, label %logical_or_merge_4, label %logical_or_right_4

logical_or_right_4:
  %t9 = getelementptr i8, i8* %ch, i64 0
  %t10 = load i8, i8* %t9
  %t11 = icmp eq i8 %t10, 50
  br label %logical_or_entry_8

logical_or_entry_8:
  br i1 %t11, label %logical_or_merge_8, label %logical_or_right_8

logical_or_right_8:
  %t13 = getelementptr i8, i8* %ch, i64 0
  %t14 = load i8, i8* %t13
  %t15 = icmp eq i8 %t14, 51
  br label %logical_or_entry_12

logical_or_entry_12:
  br i1 %t15, label %logical_or_merge_12, label %logical_or_right_12

logical_or_right_12:
  %t17 = getelementptr i8, i8* %ch, i64 0
  %t18 = load i8, i8* %t17
  %t19 = icmp eq i8 %t18, 52
  br label %logical_or_entry_16

logical_or_entry_16:
  br i1 %t19, label %logical_or_merge_16, label %logical_or_right_16

logical_or_right_16:
  %t21 = getelementptr i8, i8* %ch, i64 0
  %t22 = load i8, i8* %t21
  %t23 = icmp eq i8 %t22, 53
  br label %logical_or_entry_20

logical_or_entry_20:
  br i1 %t23, label %logical_or_merge_20, label %logical_or_right_20

logical_or_right_20:
  %t25 = getelementptr i8, i8* %ch, i64 0
  %t26 = load i8, i8* %t25
  %t27 = icmp eq i8 %t26, 54
  br label %logical_or_entry_24

logical_or_entry_24:
  br i1 %t27, label %logical_or_merge_24, label %logical_or_right_24

logical_or_right_24:
  %t29 = getelementptr i8, i8* %ch, i64 0
  %t30 = load i8, i8* %t29
  %t31 = icmp eq i8 %t30, 55
  br label %logical_or_entry_28

logical_or_entry_28:
  br i1 %t31, label %logical_or_merge_28, label %logical_or_right_28

logical_or_right_28:
  %t33 = getelementptr i8, i8* %ch, i64 0
  %t34 = load i8, i8* %t33
  %t35 = icmp eq i8 %t34, 56
  br label %logical_or_entry_32

logical_or_entry_32:
  br i1 %t35, label %logical_or_merge_32, label %logical_or_right_32

logical_or_right_32:
  %t36 = getelementptr i8, i8* %ch, i64 0
  %t37 = load i8, i8* %t36
  %t38 = icmp eq i8 %t37, 57
  br label %logical_or_right_end_32

logical_or_right_end_32:
  br label %logical_or_merge_32

logical_or_merge_32:
  %t39 = phi i1 [ true, %logical_or_entry_32 ], [ %t38, %logical_or_right_end_32 ]
  br label %logical_or_right_end_28

logical_or_right_end_28:
  br label %logical_or_merge_28

logical_or_merge_28:
  %t40 = phi i1 [ true, %logical_or_entry_28 ], [ %t39, %logical_or_right_end_28 ]
  br label %logical_or_right_end_24

logical_or_right_end_24:
  br label %logical_or_merge_24

logical_or_merge_24:
  %t41 = phi i1 [ true, %logical_or_entry_24 ], [ %t40, %logical_or_right_end_24 ]
  br label %logical_or_right_end_20

logical_or_right_end_20:
  br label %logical_or_merge_20

logical_or_merge_20:
  %t42 = phi i1 [ true, %logical_or_entry_20 ], [ %t41, %logical_or_right_end_20 ]
  br label %logical_or_right_end_16

logical_or_right_end_16:
  br label %logical_or_merge_16

logical_or_merge_16:
  %t43 = phi i1 [ true, %logical_or_entry_16 ], [ %t42, %logical_or_right_end_16 ]
  br label %logical_or_right_end_12

logical_or_right_end_12:
  br label %logical_or_merge_12

logical_or_merge_12:
  %t44 = phi i1 [ true, %logical_or_entry_12 ], [ %t43, %logical_or_right_end_12 ]
  br label %logical_or_right_end_8

logical_or_right_end_8:
  br label %logical_or_merge_8

logical_or_merge_8:
  %t45 = phi i1 [ true, %logical_or_entry_8 ], [ %t44, %logical_or_right_end_8 ]
  br label %logical_or_right_end_4

logical_or_right_end_4:
  br label %logical_or_merge_4

logical_or_merge_4:
  %t46 = phi i1 [ true, %logical_or_entry_4 ], [ %t45, %logical_or_right_end_4 ]
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t47 = phi i1 [ true, %logical_or_entry_0 ], [ %t46, %logical_or_right_end_0 ]
  ret i1 %t47
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
  %t68 = phi double [ %t6, %entry ], [ %t67, %loop.latch2 ]
  store double %t68, double* %l1
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
  %t26 = getelementptr inbounds %TokenKind, %TokenKind* %t25, i32 0, i32 0
  %t27 = load i32, i32* %t26
  %t28 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t29 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t27, 0
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t27, 1
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t27, 2
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t27, 3
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t27, 4
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t27, 5
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t27, 6
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %t50 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t27, 7
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %s53 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.53, i32 0, i32 0
  %t54 = icmp eq i8* %t52, %s53
  %t55 = load double, double* %l0
  %t56 = load double, double* %l1
  %t57 = load double, double* %l2
  %t58 = load %Token, %Token* %l3
  br i1 %t54, label %then6, label %merge7
then6:
  %t59 = load %Token, %Token* %l3
  %t60 = extractvalue %Token %t59, 0
  %t61 = getelementptr inbounds %TokenKind, %TokenKind* %t60, i32 0, i32 0
  %t62 = load i32, i32* %t61
  store double 0.0, double* %l4
  %t63 = load double, double* %l4
  br label %merge7
merge7:
  %t64 = load double, double* %l1
  %t65 = sitofp i64 1 to double
  %t66 = fadd double %t64, %t65
  store double %t66, double* %l1
  br label %loop.latch2
loop.latch2:
  %t67 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t69 = load double, double* %l2
  %t70 = sitofp i64 0 to double
  %t71 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %tokens, double %t70, double %t69)
  ret { %Token*, i64 }* %t71
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
  %t30 = getelementptr inbounds %TokenKind, %TokenKind* %t29, i32 0, i32 0
  %t31 = load i32, i32* %t30
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
  %s57 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.57, i32 0, i32 0
  %t58 = icmp eq i8* %t56, %s57
  %t59 = load double, double* %l0
  %t60 = load double, double* %l1
  %t61 = load double, double* %l2
  %t62 = load double, double* %l3
  %t63 = load double, double* %l4
  %t64 = load %Token, %Token* %l5
  br i1 %t58, label %then6, label %merge7
then6:
  %t65 = load %Token, %Token* %l5
  %t66 = extractvalue %Token %t65, 0
  %t67 = getelementptr inbounds %TokenKind, %TokenKind* %t66, i32 0, i32 0
  %t68 = load i32, i32* %t67
  store double 0.0, double* %l6
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
  %t51 = getelementptr %ExpressionTokens, %ExpressionTokens* %t50, i32 0, i32 1
  %t52 = load double, double* %t51
  %t53 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  %t54 = extractvalue %ExpressionParseResult %t53, 0
  %t55 = getelementptr %ExpressionTokens, %ExpressionTokens* %t54, i32 0, i32 0
  %t56 = load { %Token**, i64 }*, { %Token**, i64 }** %t55
  %t57 = load { %Token**, i64 }, { %Token**, i64 }* %t56
  %t58 = extractvalue { %Token**, i64 } %t57, 1
  %t59 = sitofp i64 %t58 to double
  %t60 = fcmp une double %t52, %t59
  %t61 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t62 = load %ExpressionTokens, %ExpressionTokens* %l2
  %t63 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  br i1 %t60, label %then6, label %merge7
then6:
  %t64 = alloca %Expression
  %t65 = getelementptr inbounds %Expression, %Expression* %t64, i32 0, i32 0
  store i32 15, i32* %t65
  %t66 = call i8* @tokens_to_text({ %Token*, i64 }* %tokens)
  %t67 = call i8* @trim_text(i8* %t66)
  %t68 = getelementptr inbounds %Expression, %Expression* %t64, i32 0, i32 1
  %t69 = bitcast [8 x i8]* %t68 to i8*
  %t70 = bitcast i8* %t69 to i8**
  store i8* %t67, i8** %t70
  %t71 = load %Expression, %Expression* %t64
  ret %Expression %t71
merge7:
  %t72 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  %t73 = extractvalue %ExpressionParseResult %t72, 1
  ret %Expression zeroinitializer
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
  %t138 = phi { %Token*, i64 }* [ %t10, %entry ], [ %t136, %loop.latch2 ]
  %t139 = phi %ExpressionTokens [ %t9, %entry ], [ %t137, %loop.latch2 ]
  store { %Token*, i64 }* %t138, { %Token*, i64 }** %l1
  store %ExpressionTokens %t139, %ExpressionTokens* %l0
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
  %t24 = insertvalue %ExpressionCollectResult undef, %ExpressionTokens* null, 0
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
  %t54 = getelementptr inbounds %TokenKind, %TokenKind* %t53, i32 0, i32 0
  %t55 = load i32, i32* %t54
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
  br label %logical_and_entry_51

logical_and_entry_51:
  br i1 %t82, label %logical_and_right_51, label %logical_and_merge_51

logical_and_right_51:
  %t83 = load %Token, %Token* %l6
  %t84 = extractvalue %Token %t83, 0
  %t85 = getelementptr inbounds %TokenKind, %TokenKind* %t84, i32 0, i32 0
  %t86 = load i32, i32* %t85
  %t87 = load %Token, %Token* %l6
  %t88 = extractvalue %Token %t87, 0
  %t89 = getelementptr inbounds %TokenKind, %TokenKind* %t88, i32 0, i32 0
  %t90 = load i32, i32* %t89
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
  %t118 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t119 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t120 = load double, double* %l2
  %t121 = load double, double* %l3
  %t122 = load double, double* %l4
  %t123 = load double, double* %l5
  %t124 = load %Token, %Token* %l6
  %t125 = load i1, i1* %l7
  br i1 %t117, label %then6, label %merge7
then6:
  %t126 = load %Token, %Token* %l6
  %t127 = extractvalue %Token %t126, 0
  %t128 = getelementptr inbounds %TokenKind, %TokenKind* %t127, i32 0, i32 0
  %t129 = load i32, i32* %t128
  store double 0.0, double* %l8
  %t130 = load double, double* %l8
  br label %merge7
merge7:
  %t131 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t132 = load %Token, %Token* %l6
  %t133 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t131, %Token %t132)
  store { %Token*, i64 }* %t133, { %Token*, i64 }** %l1
  %t134 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t135 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t134)
  store %ExpressionTokens %t135, %ExpressionTokens* %l0
  br label %loop.latch2
loop.latch2:
  %t136 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t137 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header0
afterloop3:
  %t140 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t141 = insertvalue %ExpressionCollectResult undef, %ExpressionTokens* null, 0
  %t142 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t143 = bitcast { %Token*, i64 }* %t142 to { %Token**, i64 }*
  %t144 = insertvalue %ExpressionCollectResult %t141, { %Token**, i64 }* %t143, 1
  %t145 = insertvalue %ExpressionCollectResult %t144, i1 1, 2
  ret %ExpressionCollectResult %t145
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
  %t4 = insertvalue %ExpressionBlockParseResult undef, %ExpressionTokens* null, 0
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
  %t17 = getelementptr inbounds %TokenKind, %TokenKind* %t16, i32 0, i32 0
  %t18 = load i32, i32* %t17
  %t19 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t20 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t18, 0
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t18, 1
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t18, 2
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t18, 3
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t18, 4
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t18, 5
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t18, 6
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t18, 7
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %s44 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.44, i32 0, i32 0
  %t45 = icmp ne i8* %t43, %s44
  br label %logical_or_entry_14

logical_or_entry_14:
  br i1 %t45, label %logical_or_merge_14, label %logical_or_right_14

logical_or_right_14:
  %t46 = load %Token, %Token* %l1
  %t47 = extractvalue %Token %t46, 0
  %t48 = getelementptr inbounds %TokenKind, %TokenKind* %t47, i32 0, i32 0
  %t49 = load i32, i32* %t48
  %t50 = alloca [0 x %Token]
  %t51 = getelementptr [0 x %Token], [0 x %Token]* %t50, i32 0, i32 0
  %t52 = alloca { %Token*, i64 }
  %t53 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t52, i32 0, i32 0
  store %Token* %t51, %Token** %t53
  %t54 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t52, i32 0, i32 1
  store i64 0, i64* %t54
  store { %Token*, i64 }* %t52, { %Token*, i64 }** %l2
  %t55 = sitofp i64 0 to double
  store double %t55, double* %l3
  %t56 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t57 = load %Token, %Token* %l1
  %t58 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t59 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t122 = phi { %Token*, i64 }* [ %t58, %entry ], [ %t120, %loop.latch4 ]
  %t123 = phi %ExpressionTokens [ %t56, %entry ], [ %t121, %loop.latch4 ]
  store { %Token*, i64 }* %t122, { %Token*, i64 }** %l2
  store %ExpressionTokens %t123, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t60 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t61 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t60)
  %t62 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t63 = load %Token, %Token* %l1
  %t64 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t65 = load double, double* %l3
  br i1 %t61, label %then6, label %merge7
then6:
  %t66 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t67 = insertvalue %ExpressionBlockParseResult undef, %ExpressionTokens* null, 0
  %t68 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t69 = bitcast { %Token*, i64 }* %t68 to { %Token**, i64 }*
  %t70 = insertvalue %ExpressionBlockParseResult %t67, { %Token**, i64 }* %t69, 1
  %t71 = insertvalue %ExpressionBlockParseResult %t70, i1 0, 2
  ret %ExpressionBlockParseResult %t71
merge7:
  %t72 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t73 = call %Token @expression_tokens_peek(%ExpressionTokens %t72)
  store %Token %t73, %Token* %l4
  %t74 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t75 = load %Token, %Token* %l4
  %t76 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t74, %Token %t75)
  store { %Token*, i64 }* %t76, { %Token*, i64 }** %l2
  %t77 = load %Token, %Token* %l4
  %t78 = extractvalue %Token %t77, 0
  %t79 = getelementptr inbounds %TokenKind, %TokenKind* %t78, i32 0, i32 0
  %t80 = load i32, i32* %t79
  %t81 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t82 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t80, 0
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %t85 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t80, 1
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t80, 2
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t80, 3
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t80, 4
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t80, 5
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %t100 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t80, 6
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %t103 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t104 = icmp eq i32 %t80, 7
  %t105 = select i1 %t104, i8* %t103, i8* %t102
  %s106 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.106, i32 0, i32 0
  %t107 = icmp eq i8* %t105, %s106
  %t108 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t109 = load %Token, %Token* %l1
  %t110 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t111 = load double, double* %l3
  %t112 = load %Token, %Token* %l4
  br i1 %t107, label %then8, label %merge9
then8:
  %t113 = load %Token, %Token* %l4
  %t114 = extractvalue %Token %t113, 0
  %t115 = getelementptr inbounds %TokenKind, %TokenKind* %t114, i32 0, i32 0
  %t116 = load i32, i32* %t115
  store double 0.0, double* %l5
  %t117 = load double, double* %l5
  br label %merge9
merge9:
  %t118 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t119 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t118)
  store %ExpressionTokens %t119, %ExpressionTokens* %l0
  br label %loop.latch4
loop.latch4:
  %t120 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t121 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t124 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t125 = insertvalue %ExpressionBlockParseResult undef, %ExpressionTokens* null, 0
  %t126 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t127 = bitcast { %Token*, i64 }* %t126 to { %Token**, i64 }*
  %t128 = insertvalue %ExpressionBlockParseResult %t125, { %Token**, i64 }* %t127, 1
  %t129 = insertvalue %ExpressionBlockParseResult %t128, i1 1, 2
  ret %ExpressionBlockParseResult %t129
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
  %t4 = insertvalue %LambdaParameterParseResult undef, %ExpressionTokens* null, 0
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.5, i32 0, i32 0
  %t6 = insertvalue %Parameter undef, i8* %s5, 0
  %t7 = bitcast i8* null to %TypeAnnotation*
  %t8 = insertvalue %Parameter %t6, %TypeAnnotation* %t7, 1
  %t9 = bitcast i8* null to %Expression*
  %t10 = insertvalue %Parameter %t8, %Expression* %t9, 2
  %t11 = insertvalue %Parameter %t10, i1 0, 3
  %t12 = bitcast i8* null to %SourceSpan*
  %t13 = insertvalue %Parameter %t11, %SourceSpan* %t12, 4
  %t14 = insertvalue %LambdaParameterParseResult %t4, %Parameter* null, 1
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
  %t23 = getelementptr inbounds %TokenKind, %TokenKind* %t22, i32 0, i32 0
  %t24 = load i32, i32* %t23
  %t25 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t26 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t24, 0
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t24, 1
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t24, 2
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t24, 3
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t24, 4
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t24, 5
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t24, 6
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t24, 7
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %s50 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.50, i32 0, i32 0
  %t51 = icmp eq i8* %t49, %s50
  br label %logical_and_entry_20

logical_and_entry_20:
  br i1 %t51, label %logical_and_right_20, label %logical_and_merge_20

logical_and_right_20:
  %t52 = load %Token, %Token* %l3
  %s53 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.53, i32 0, i32 0
  %t54 = call i1 @identifier_matches(%Token %t52, i8* %s53)
  br label %logical_and_right_end_20

logical_and_right_end_20:
  br label %logical_and_merge_20

logical_and_merge_20:
  %t55 = phi i1 [ false, %logical_and_entry_20 ], [ %t54, %logical_and_right_end_20 ]
  %t56 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t57 = load double, double* %l1
  %t58 = load i1, i1* %l2
  %t59 = load %Token, %Token* %l3
  br i1 %t55, label %then2, label %merge3
then2:
  store i1 1, i1* %l2
  %t60 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t61 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t60)
  store %ExpressionTokens %t61, %ExpressionTokens* %l0
  %t62 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t63 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t62)
  %t64 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t65 = load double, double* %l1
  %t66 = load i1, i1* %l2
  %t67 = load %Token, %Token* %l3
  br i1 %t63, label %then4, label %merge5
then4:
  %t68 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t69 = insertvalue %LambdaParameterParseResult undef, %ExpressionTokens* null, 0
  %s70 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.70, i32 0, i32 0
  %t71 = insertvalue %Parameter undef, i8* %s70, 0
  %t72 = bitcast i8* null to %TypeAnnotation*
  %t73 = insertvalue %Parameter %t71, %TypeAnnotation* %t72, 1
  %t74 = bitcast i8* null to %Expression*
  %t75 = insertvalue %Parameter %t73, %Expression* %t74, 2
  %t76 = insertvalue %Parameter %t75, i1 0, 3
  %t77 = bitcast i8* null to %SourceSpan*
  %t78 = insertvalue %Parameter %t76, %SourceSpan* %t77, 4
  %t79 = insertvalue %LambdaParameterParseResult %t69, %Parameter* null, 1
  %t80 = insertvalue %LambdaParameterParseResult %t79, i1 0, 2
  ret %LambdaParameterParseResult %t80
merge5:
  br label %merge3
merge3:
  %t81 = phi i1 [ 1, %then2 ], [ %t58, %entry ]
  %t82 = phi %ExpressionTokens [ %t61, %then2 ], [ %t56, %entry ]
  store i1 %t81, i1* %l2
  store %ExpressionTokens %t82, %ExpressionTokens* %l0
  %t83 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t84 = call %Token @expression_tokens_peek(%ExpressionTokens %t83)
  store %Token %t84, %Token* %l4
  %t85 = load %Token, %Token* %l4
  %t86 = extractvalue %Token %t85, 0
  %t87 = getelementptr inbounds %TokenKind, %TokenKind* %t86, i32 0, i32 0
  %t88 = load i32, i32* %t87
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
  %s114 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.114, i32 0, i32 0
  %t115 = icmp ne i8* %t113, %s114
  %t116 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t117 = load double, double* %l1
  %t118 = load i1, i1* %l2
  %t119 = load %Token, %Token* %l3
  %t120 = load %Token, %Token* %l4
  br i1 %t115, label %then6, label %merge7
then6:
  %t121 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t122 = insertvalue %LambdaParameterParseResult undef, %ExpressionTokens* null, 0
  %s123 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.123, i32 0, i32 0
  %t124 = insertvalue %Parameter undef, i8* %s123, 0
  %t125 = bitcast i8* null to %TypeAnnotation*
  %t126 = insertvalue %Parameter %t124, %TypeAnnotation* %t125, 1
  %t127 = bitcast i8* null to %Expression*
  %t128 = insertvalue %Parameter %t126, %Expression* %t127, 2
  %t129 = insertvalue %Parameter %t128, i1 0, 3
  %t130 = bitcast i8* null to %SourceSpan*
  %t131 = insertvalue %Parameter %t129, %SourceSpan* %t130, 4
  %t132 = insertvalue %LambdaParameterParseResult %t122, %Parameter* null, 1
  %t133 = insertvalue %LambdaParameterParseResult %t132, i1 0, 2
  ret %LambdaParameterParseResult %t133
merge7:
  %t134 = load %Token, %Token* %l4
  %t135 = call i8* @identifier_text(%Token %t134)
  store i8* %t135, i8** %l5
  %t136 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t137 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t136)
  store %ExpressionTokens %t137, %ExpressionTokens* %l0
  store i8* null, i8** %l6
  %t138 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t139 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t138)
  %t140 = xor i1 %t139, 1
  %t141 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t142 = load double, double* %l1
  %t143 = load i1, i1* %l2
  %t144 = load %Token, %Token* %l3
  %t145 = load %Token, %Token* %l4
  %t146 = load i8*, i8** %l5
  %t147 = load i8*, i8** %l6
  br i1 %t140, label %then8, label %merge9
then8:
  %t148 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t149 = call %Token @expression_tokens_peek(%ExpressionTokens %t148)
  store %Token %t149, %Token* %l7
  %t152 = load %Token, %Token* %l7
  %t153 = extractvalue %Token %t152, 0
  %t154 = getelementptr inbounds %TokenKind, %TokenKind* %t153, i32 0, i32 0
  %t155 = load i32, i32* %t154
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
  br label %logical_and_entry_151

logical_and_entry_151:
  br i1 %t182, label %logical_and_right_151, label %logical_and_merge_151

logical_and_right_151:
  %t183 = load %Token, %Token* %l7
  %t184 = extractvalue %Token %t183, 0
  %t185 = getelementptr inbounds %TokenKind, %TokenKind* %t184, i32 0, i32 0
  %t186 = load i32, i32* %t185
  br label %merge9
merge9:
  store i8* null, i8** %l8
  %t187 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t188 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t187)
  %t189 = xor i1 %t188, 1
  %t190 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t191 = load double, double* %l1
  %t192 = load i1, i1* %l2
  %t193 = load %Token, %Token* %l3
  %t194 = load %Token, %Token* %l4
  %t195 = load i8*, i8** %l5
  %t196 = load i8*, i8** %l6
  %t197 = load i8*, i8** %l8
  br i1 %t189, label %then10, label %merge11
then10:
  %t198 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t199 = call %Token @expression_tokens_peek(%ExpressionTokens %t198)
  store %Token %t199, %Token* %l9
  %t201 = load %Token, %Token* %l9
  %t202 = extractvalue %Token %t201, 0
  %t203 = getelementptr inbounds %TokenKind, %TokenKind* %t202, i32 0, i32 0
  %t204 = load i32, i32* %t203
  %t205 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t206 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t207 = icmp eq i32 %t204, 0
  %t208 = select i1 %t207, i8* %t206, i8* %t205
  %t209 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t210 = icmp eq i32 %t204, 1
  %t211 = select i1 %t210, i8* %t209, i8* %t208
  %t212 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t213 = icmp eq i32 %t204, 2
  %t214 = select i1 %t213, i8* %t212, i8* %t211
  %t215 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t216 = icmp eq i32 %t204, 3
  %t217 = select i1 %t216, i8* %t215, i8* %t214
  %t218 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t219 = icmp eq i32 %t204, 4
  %t220 = select i1 %t219, i8* %t218, i8* %t217
  %t221 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t222 = icmp eq i32 %t204, 5
  %t223 = select i1 %t222, i8* %t221, i8* %t220
  %t224 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t225 = icmp eq i32 %t204, 6
  %t226 = select i1 %t225, i8* %t224, i8* %t223
  %t227 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t228 = icmp eq i32 %t204, 7
  %t229 = select i1 %t228, i8* %t227, i8* %t226
  %s230 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.230, i32 0, i32 0
  %t231 = icmp eq i8* %t229, %s230
  br label %logical_and_entry_200

logical_and_entry_200:
  br i1 %t231, label %logical_and_right_200, label %logical_and_merge_200

logical_and_right_200:
  %t232 = load %Token, %Token* %l9
  %t233 = extractvalue %Token %t232, 0
  %t234 = getelementptr inbounds %TokenKind, %TokenKind* %t233, i32 0, i32 0
  %t235 = load i32, i32* %t234
  br label %merge11
merge11:
  %t236 = extractvalue %ExpressionTokens %state, 0
  %t237 = load double, double* %l1
  %t238 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t239 = extractvalue %ExpressionTokens %t238, 1
  %t240 = bitcast { %Token**, i64 }* %t236 to { %Token*, i64 }*
  %t241 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t240, double %t237, double %t239)
  store { %Token*, i64 }* %t241, { %Token*, i64 }** %l10
  %t242 = load { %Token*, i64 }*, { %Token*, i64 }** %l10
  %t243 = call double @source_span_from_tokens({ %Token*, i64 }* %t242)
  store double %t243, double* %l11
  %t244 = load i8*, i8** %l5
  %t245 = insertvalue %Parameter undef, i8* %t244, 0
  %t246 = load i8*, i8** %l6
  %t247 = bitcast i8* %t246 to %TypeAnnotation*
  %t248 = insertvalue %Parameter %t245, %TypeAnnotation* %t247, 1
  %t249 = load i8*, i8** %l8
  %t250 = bitcast i8* %t249 to %Expression*
  %t251 = insertvalue %Parameter %t248, %Expression* %t250, 2
  %t252 = load i1, i1* %l2
  %t253 = insertvalue %Parameter %t251, i1 %t252, 3
  %t254 = load double, double* %l11
  %t255 = insertvalue %Parameter %t253, %SourceSpan* null, 4
  store %Parameter %t255, %Parameter* %l12
  %t256 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t257 = insertvalue %LambdaParameterParseResult undef, %ExpressionTokens* null, 0
  %t258 = load %Parameter, %Parameter* %l12
  %t259 = insertvalue %LambdaParameterParseResult %t257, %Parameter* null, 1
  %t260 = insertvalue %LambdaParameterParseResult %t259, i1 1, 2
  ret %LambdaParameterParseResult %t260
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
  %t10 = insertvalue %LambdaParameterListParseResult undef, %ExpressionTokens* null, 0
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
  %t20 = getelementptr inbounds %TokenKind, %TokenKind* %t19, i32 0, i32 0
  %t21 = load i32, i32* %t20
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
  %t49 = load %Token, %Token* %l2
  %t50 = extractvalue %Token %t49, 0
  %t51 = getelementptr inbounds %TokenKind, %TokenKind* %t50, i32 0, i32 0
  %t52 = load i32, i32* %t51
  %t53 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t54 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t55 = load %Token, %Token* %l2
  br label %loop.header2
loop.header2:
  %t143 = phi { %Parameter*, i64 }* [ %t54, %entry ], [ %t141, %loop.latch4 ]
  %t144 = phi %ExpressionTokens [ %t53, %entry ], [ %t142, %loop.latch4 ]
  store { %Parameter*, i64 }* %t143, { %Parameter*, i64 }** %l1
  store %ExpressionTokens %t144, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t56 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t57 = call %LambdaParameterParseResult @parse_lambda_parameter(%ExpressionTokens %t56)
  store %LambdaParameterParseResult %t57, %LambdaParameterParseResult* %l3
  %t58 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  %t59 = extractvalue %LambdaParameterParseResult %t58, 2
  %t60 = xor i1 %t59, 1
  %t61 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t62 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t63 = load %Token, %Token* %l2
  %t64 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  br i1 %t60, label %then6, label %merge7
then6:
  %t65 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t66 = insertvalue %LambdaParameterListParseResult undef, %ExpressionTokens* null, 0
  %t67 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t68 = bitcast { %Parameter*, i64 }* %t67 to { %Parameter**, i64 }*
  %t69 = insertvalue %LambdaParameterListParseResult %t66, { %Parameter**, i64 }* %t68, 1
  %t70 = insertvalue %LambdaParameterListParseResult %t69, i1 0, 2
  ret %LambdaParameterListParseResult %t70
merge7:
  %t71 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t72 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  %t73 = extractvalue %LambdaParameterParseResult %t72, 1
  %t74 = call { %Parameter*, i64 }* @append_parameter({ %Parameter*, i64 }* %t71, %Parameter zeroinitializer)
  store { %Parameter*, i64 }* %t74, { %Parameter*, i64 }** %l1
  %t75 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  %t76 = extractvalue %LambdaParameterParseResult %t75, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t77 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t78 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t77)
  %t79 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t80 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t81 = load %Token, %Token* %l2
  %t82 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  br i1 %t78, label %then8, label %merge9
then8:
  %t83 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t84 = insertvalue %LambdaParameterListParseResult undef, %ExpressionTokens* null, 0
  %t85 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t86 = bitcast { %Parameter*, i64 }* %t85 to { %Parameter**, i64 }*
  %t87 = insertvalue %LambdaParameterListParseResult %t84, { %Parameter**, i64 }* %t86, 1
  %t88 = insertvalue %LambdaParameterListParseResult %t87, i1 0, 2
  ret %LambdaParameterListParseResult %t88
merge9:
  %t89 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t90 = call %Token @expression_tokens_peek(%ExpressionTokens %t89)
  store %Token %t90, %Token* %l4
  %t91 = load %Token, %Token* %l4
  %t92 = extractvalue %Token %t91, 0
  %t93 = getelementptr inbounds %TokenKind, %TokenKind* %t92, i32 0, i32 0
  %t94 = load i32, i32* %t93
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
  %s120 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.120, i32 0, i32 0
  %t121 = icmp eq i8* %t119, %s120
  %t122 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t123 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t124 = load %Token, %Token* %l2
  %t125 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  %t126 = load %Token, %Token* %l4
  br i1 %t121, label %then10, label %merge11
then10:
  %t127 = load %Token, %Token* %l4
  %t128 = extractvalue %Token %t127, 0
  %t129 = getelementptr inbounds %TokenKind, %TokenKind* %t128, i32 0, i32 0
  %t130 = load i32, i32* %t129
  %t131 = load %Token, %Token* %l4
  %t132 = extractvalue %Token %t131, 0
  %t133 = getelementptr inbounds %TokenKind, %TokenKind* %t132, i32 0, i32 0
  %t134 = load i32, i32* %t133
  br label %merge11
merge11:
  %t135 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t136 = insertvalue %LambdaParameterListParseResult undef, %ExpressionTokens* null, 0
  %t137 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t138 = bitcast { %Parameter*, i64 }* %t137 to { %Parameter**, i64 }*
  %t139 = insertvalue %LambdaParameterListParseResult %t136, { %Parameter**, i64 }* %t138, 1
  %t140 = insertvalue %LambdaParameterListParseResult %t139, i1 0, 2
  ret %LambdaParameterListParseResult %t140
loop.latch4:
  %t141 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t142 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t145 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t146 = insertvalue %LambdaParameterListParseResult undef, %ExpressionTokens* null, 0
  %t147 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t148 = bitcast { %Parameter*, i64 }* %t147 to { %Parameter**, i64 }*
  %t149 = insertvalue %LambdaParameterListParseResult %t146, { %Parameter**, i64 }* %t148, 1
  %t150 = insertvalue %LambdaParameterListParseResult %t149, i1 1, 2
  ret %LambdaParameterListParseResult %t150
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
  %l11 = alloca %Block*
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
  %t9 = getelementptr inbounds %TokenKind, %TokenKind* %t8, i32 0, i32 0
  %t10 = load i32, i32* %t9
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
  %s36 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.36, i32 0, i32 0
  %t37 = icmp ne i8* %t35, %s36
  br label %logical_or_entry_6

logical_or_entry_6:
  br i1 %t37, label %logical_or_merge_6, label %logical_or_right_6

logical_or_right_6:
  %t38 = load %Token, %Token* %l1
  %s39 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.39, i32 0, i32 0
  %t40 = call i1 @identifier_matches(%Token %t38, i8* %s39)
  %t41 = xor i1 %t40, 1
  br label %logical_or_right_end_6

logical_or_right_end_6:
  br label %logical_or_merge_6

logical_or_merge_6:
  %t42 = phi i1 [ true, %logical_or_entry_6 ], [ %t41, %logical_or_right_end_6 ]
  %t43 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t44 = load %Token, %Token* %l1
  br i1 %t42, label %then2, label %merge3
then2:
  %t45 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t45
merge3:
  %t46 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t47 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t46)
  store %ExpressionTokens %t47, %ExpressionTokens* %l0
  %t48 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t49 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t48)
  %t50 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t51 = load %Token, %Token* %l1
  br i1 %t49, label %then4, label %merge5
then4:
  %t52 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t52
merge5:
  %t53 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t54 = call %Token @expression_tokens_peek(%ExpressionTokens %t53)
  store %Token %t54, %Token* %l2
  %t56 = load %Token, %Token* %l2
  %t57 = extractvalue %Token %t56, 0
  %t58 = getelementptr inbounds %TokenKind, %TokenKind* %t57, i32 0, i32 0
  %t59 = load i32, i32* %t58
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
  %s85 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.85, i32 0, i32 0
  %t86 = icmp ne i8* %t84, %s85
  br label %logical_or_entry_55

logical_or_entry_55:
  br i1 %t86, label %logical_or_merge_55, label %logical_or_right_55

logical_or_right_55:
  %t87 = load %Token, %Token* %l2
  %t88 = extractvalue %Token %t87, 0
  %t89 = getelementptr inbounds %TokenKind, %TokenKind* %t88, i32 0, i32 0
  %t90 = load i32, i32* %t89
  %t91 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t92 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t91)
  store %ExpressionTokens %t92, %ExpressionTokens* %l0
  %t93 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t94 = call %LambdaParameterListParseResult @parse_lambda_parameter_list(%ExpressionTokens %t93)
  store %LambdaParameterListParseResult %t94, %LambdaParameterListParseResult* %l3
  %t95 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t96 = extractvalue %LambdaParameterListParseResult %t95, 2
  %t97 = xor i1 %t96, 1
  %t98 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t99 = load %Token, %Token* %l1
  %t100 = load %Token, %Token* %l2
  %t101 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  br i1 %t97, label %then6, label %merge7
then6:
  %t102 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t102
merge7:
  %t103 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t104 = extractvalue %LambdaParameterListParseResult %t103, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t105 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t106 = extractvalue %LambdaParameterListParseResult %t105, 1
  store { %Parameter**, i64 }* %t106, { %Parameter**, i64 }** %l4
  store i8* null, i8** %l5
  %t107 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t108 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t107)
  %t109 = xor i1 %t108, 1
  %t110 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t111 = load %Token, %Token* %l1
  %t112 = load %Token, %Token* %l2
  %t113 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t114 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %l4
  %t115 = load i8*, i8** %l5
  br i1 %t109, label %then8, label %merge9
then8:
  %t116 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t117 = call %Token @expression_tokens_peek(%ExpressionTokens %t116)
  store %Token %t117, %Token* %l6
  %t120 = load %Token, %Token* %l6
  %t121 = extractvalue %Token %t120, 0
  %t122 = getelementptr inbounds %TokenKind, %TokenKind* %t121, i32 0, i32 0
  %t123 = load i32, i32* %t122
  %t124 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t125 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t126 = icmp eq i32 %t123, 0
  %t127 = select i1 %t126, i8* %t125, i8* %t124
  %t128 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t129 = icmp eq i32 %t123, 1
  %t130 = select i1 %t129, i8* %t128, i8* %t127
  %t131 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t132 = icmp eq i32 %t123, 2
  %t133 = select i1 %t132, i8* %t131, i8* %t130
  %t134 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t123, 3
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t123, 4
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t123, 5
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t123, 6
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t123, 7
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %s149 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.149, i32 0, i32 0
  %t150 = icmp eq i8* %t148, %s149
  br label %logical_and_entry_119

logical_and_entry_119:
  br i1 %t150, label %logical_and_right_119, label %logical_and_merge_119

logical_and_right_119:
  %t151 = load %Token, %Token* %l6
  %t152 = extractvalue %Token %t151, 0
  %t153 = getelementptr inbounds %TokenKind, %TokenKind* %t152, i32 0, i32 0
  %t154 = load i32, i32* %t153
  br label %merge9
merge9:
  %t155 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t156 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t155)
  %t157 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t158 = load %Token, %Token* %l1
  %t159 = load %Token, %Token* %l2
  %t160 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t161 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %l4
  %t162 = load i8*, i8** %l5
  br i1 %t156, label %then10, label %merge11
then10:
  %t163 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t163
merge11:
  %t164 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t165 = call %ExpressionBlockParseResult @collect_expression_block(%ExpressionTokens %t164)
  store %ExpressionBlockParseResult %t165, %ExpressionBlockParseResult* %l7
  %t166 = load %ExpressionBlockParseResult, %ExpressionBlockParseResult* %l7
  %t167 = extractvalue %ExpressionBlockParseResult %t166, 2
  %t168 = xor i1 %t167, 1
  %t169 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t170 = load %Token, %Token* %l1
  %t171 = load %Token, %Token* %l2
  %t172 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t173 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %l4
  %t174 = load i8*, i8** %l5
  %t175 = load %ExpressionBlockParseResult, %ExpressionBlockParseResult* %l7
  br i1 %t168, label %then12, label %merge13
then12:
  %t176 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t176
merge13:
  %t177 = load %ExpressionBlockParseResult, %ExpressionBlockParseResult* %l7
  %t178 = extractvalue %ExpressionBlockParseResult %t177, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t179 = load %ExpressionBlockParseResult, %ExpressionBlockParseResult* %l7
  %t180 = extractvalue %ExpressionBlockParseResult %t179, 1
  store { %Token**, i64 }* %t180, { %Token**, i64 }** %l8
  %t181 = load { %Token**, i64 }*, { %Token**, i64 }** %l8
  %t182 = insertvalue %TokenKind undef, i32 7, 0
  %t183 = insertvalue %Token undef, %TokenKind* null, 0
  %s184 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.184, i32 0, i32 0
  %t185 = insertvalue %Token %t183, i8* %s184, 1
  %t186 = sitofp i64 0 to double
  %t187 = insertvalue %Token %t185, double %t186, 2
  %t188 = sitofp i64 0 to double
  %t189 = insertvalue %Token %t187, double %t188, 3
  %t190 = bitcast { %Token**, i64 }* %t181 to { %Token*, i64 }*
  %t191 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t190, %Token %t189)
  %t192 = bitcast { %Token*, i64 }* %t191 to { %Token**, i64 }*
  store { %Token**, i64 }* %t192, { %Token**, i64 }** %l8
  %t193 = load { %Token**, i64 }*, { %Token**, i64 }** %l8
  %t194 = insertvalue %Parser undef, { %Token**, i64 }* %t193, 0
  %t195 = sitofp i64 0 to double
  %t196 = insertvalue %Parser %t194, double %t195, 1
  store %Parser %t196, %Parser* %l9
  %t197 = load %Parser, %Parser* %l9
  %t198 = call %BlockParseResult @parse_block(%Parser %t197)
  store %BlockParseResult %t198, %BlockParseResult* %l10
  %t199 = load %BlockParseResult, %BlockParseResult* %l10
  %t200 = extractvalue %BlockParseResult %t199, 1
  store %Block* %t200, %Block** %l11
  %t201 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t202 = insertvalue %ExpressionParseResult undef, %ExpressionTokens* null, 0
  %t203 = alloca %Expression
  %t204 = getelementptr inbounds %Expression, %Expression* %t203, i32 0, i32 0
  store i32 13, i32* %t204
  %t205 = load { %Parameter**, i64 }*, { %Parameter**, i64 }** %l4
  %t206 = getelementptr inbounds %Expression, %Expression* %t203, i32 0, i32 1
  %t207 = bitcast [24 x i8]* %t206 to i8*
  %t208 = bitcast i8* %t207 to { %Parameter**, i64 }**
  store { %Parameter**, i64 }* %t205, { %Parameter**, i64 }** %t208
  %t209 = load %Block*, %Block** %l11
  %t210 = getelementptr inbounds %Expression, %Expression* %t203, i32 0, i32 1
  %t211 = bitcast [24 x i8]* %t210 to i8*
  %t212 = getelementptr inbounds i8, i8* %t211, i64 8
  %t213 = bitcast i8* %t212 to %Block**
  store %Block* %t209, %Block** %t213
  %t214 = load i8*, i8** %l5
  %t215 = bitcast i8* %t214 to %TypeAnnotation*
  %t216 = getelementptr inbounds %Expression, %Expression* %t203, i32 0, i32 1
  %t217 = bitcast [24 x i8]* %t216 to i8*
  %t218 = getelementptr inbounds i8, i8* %t217, i64 16
  %t219 = bitcast i8* %t218 to %TypeAnnotation**
  store %TypeAnnotation* %t215, %TypeAnnotation** %t219
  %t220 = load %Expression, %Expression* %t203
  %t221 = insertvalue %ExpressionParseResult %t202, %Expression* null, 1
  %t222 = insertvalue %ExpressionParseResult %t221, i1 1, 2
  ret %ExpressionParseResult %t222
}

define %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %state, double %min_precedence) {
entry:
  %l0 = alloca %ExpressionParseResult
  %l1 = alloca %ExpressionTokens*
  %l2 = alloca %Expression*
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
  store %ExpressionTokens* %t7, %ExpressionTokens** %l1
  %t8 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t9 = extractvalue %ExpressionParseResult %t8, 1
  store %Expression* %t9, %Expression** %l2
  %t10 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t11 = load %ExpressionTokens*, %ExpressionTokens** %l1
  %t12 = load %Expression*, %Expression** %l2
  br label %loop.header2
loop.header2:
  %t101 = phi %ExpressionTokens* [ %t11, %entry ], [ %t100, %loop.latch4 ]
  store %ExpressionTokens* %t101, %ExpressionTokens** %l1
  br label %loop.body3
loop.body3:
  %t13 = load %ExpressionTokens*, %ExpressionTokens** %l1
  %t14 = call i1 @expression_tokens_is_at_end(%ExpressionTokens zeroinitializer)
  %t15 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t16 = load %ExpressionTokens*, %ExpressionTokens** %l1
  %t17 = load %Expression*, %Expression** %l2
  br i1 %t14, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t18 = load %ExpressionTokens*, %ExpressionTokens** %l1
  %t19 = call %Token @expression_tokens_peek(%ExpressionTokens zeroinitializer)
  store %Token %t19, %Token* %l3
  %t20 = load %Token, %Token* %l3
  %t21 = extractvalue %Token %t20, 0
  %t22 = getelementptr inbounds %TokenKind, %TokenKind* %t21, i32 0, i32 0
  %t23 = load i32, i32* %t22
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
  %t50 = icmp ne i8* %t48, %s49
  %t51 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t52 = load %ExpressionTokens*, %ExpressionTokens** %l1
  %t53 = load %Expression*, %Expression** %l2
  %t54 = load %Token, %Token* %l3
  br i1 %t50, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t55 = load %Token, %Token* %l3
  %t56 = extractvalue %Token %t55, 0
  %t57 = getelementptr inbounds %TokenKind, %TokenKind* %t56, i32 0, i32 0
  %t58 = load i32, i32* %t57
  store double 0.0, double* %l4
  %t59 = load double, double* %l4
  %t60 = call double @binary_precedence(i8* null)
  store double %t60, double* %l5
  %t61 = load double, double* %l5
  %t62 = sitofp i64 -1 to double
  %t63 = fcmp oeq double %t61, %t62
  %t64 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t65 = load %ExpressionTokens*, %ExpressionTokens** %l1
  %t66 = load %Expression*, %Expression** %l2
  %t67 = load %Token, %Token* %l3
  %t68 = load double, double* %l4
  %t69 = load double, double* %l5
  br i1 %t63, label %then10, label %merge11
then10:
  br label %afterloop5
merge11:
  %t70 = load double, double* %l5
  %t71 = fcmp olt double %t70, %min_precedence
  %t72 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t73 = load %ExpressionTokens*, %ExpressionTokens** %l1
  %t74 = load %Expression*, %Expression** %l2
  %t75 = load %Token, %Token* %l3
  %t76 = load double, double* %l4
  %t77 = load double, double* %l5
  br i1 %t71, label %then12, label %merge13
then12:
  br label %afterloop5
merge13:
  %t78 = load %ExpressionTokens*, %ExpressionTokens** %l1
  %t79 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens zeroinitializer)
  store %ExpressionTokens* null, %ExpressionTokens** %l1
  %t80 = load %ExpressionTokens*, %ExpressionTokens** %l1
  %t81 = load double, double* %l5
  %t82 = sitofp i64 1 to double
  %t83 = fadd double %t81, %t82
  %t84 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens zeroinitializer, double %t83)
  store %ExpressionParseResult %t84, %ExpressionParseResult* %l6
  %t85 = load %ExpressionParseResult, %ExpressionParseResult* %l6
  %t86 = extractvalue %ExpressionParseResult %t85, 2
  %t87 = xor i1 %t86, 1
  %t88 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t89 = load %ExpressionTokens*, %ExpressionTokens** %l1
  %t90 = load %Expression*, %Expression** %l2
  %t91 = load %Token, %Token* %l3
  %t92 = load double, double* %l4
  %t93 = load double, double* %l5
  %t94 = load %ExpressionParseResult, %ExpressionParseResult* %l6
  br i1 %t87, label %then14, label %merge15
then14:
  %t95 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t95
merge15:
  %t96 = load %ExpressionParseResult, %ExpressionParseResult* %l6
  %t97 = extractvalue %ExpressionParseResult %t96, 0
  store %ExpressionTokens* %t97, %ExpressionTokens** %l1
  %t98 = load double, double* %l4
  %s99 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.99, i32 0, i32 0
  br label %loop.latch4
loop.latch4:
  %t100 = load %ExpressionTokens*, %ExpressionTokens** %l1
  br label %loop.header2
afterloop5:
  %t102 = load %ExpressionTokens*, %ExpressionTokens** %l1
  %t103 = insertvalue %ExpressionParseResult undef, %ExpressionTokens* %t102, 0
  %t104 = load %Expression*, %Expression** %l2
  %t105 = insertvalue %ExpressionParseResult %t103, %Expression* %t104, 1
  %t106 = insertvalue %ExpressionParseResult %t105, i1 1, 2
  ret %ExpressionParseResult %t106
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
  %t5 = getelementptr inbounds %TokenKind, %TokenKind* %t4, i32 0, i32 0
  %t6 = load i32, i32* %t5
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
  %t34 = load %Token, %Token* %l0
  br i1 %t33, label %then2, label %merge3
then2:
  %t35 = load %Token, %Token* %l0
  %t36 = extractvalue %Token %t35, 0
  %t37 = getelementptr inbounds %TokenKind, %TokenKind* %t36, i32 0, i32 0
  %t38 = load i32, i32* %t37
  store double 0.0, double* %l1
  %t40 = load double, double* %l1
  br label %merge3
merge3:
  %t42 = load %Token, %Token* %l0
  %t43 = extractvalue %Token %t42, 0
  %t44 = getelementptr inbounds %TokenKind, %TokenKind* %t43, i32 0, i32 0
  %t45 = load i32, i32* %t44
  %t46 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t47 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t45, 0
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %t50 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t45, 1
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %t53 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t54 = icmp eq i32 %t45, 2
  %t55 = select i1 %t54, i8* %t53, i8* %t52
  %t56 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t57 = icmp eq i32 %t45, 3
  %t58 = select i1 %t57, i8* %t56, i8* %t55
  %t59 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t60 = icmp eq i32 %t45, 4
  %t61 = select i1 %t60, i8* %t59, i8* %t58
  %t62 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t45, 5
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t45, 6
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t45, 7
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %s71 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.71, i32 0, i32 0
  %t72 = icmp eq i8* %t70, %s71
  br label %logical_and_entry_41

logical_and_entry_41:
  br i1 %t72, label %logical_and_right_41, label %logical_and_merge_41

logical_and_right_41:
  %t73 = load %Token, %Token* %l0
  %s74 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.74, i32 0, i32 0
  %t75 = call i1 @identifier_matches(%Token %t73, i8* %s74)
  br label %logical_and_right_end_41

logical_and_right_end_41:
  br label %logical_and_merge_41

logical_and_merge_41:
  %t76 = phi i1 [ false, %logical_and_entry_41 ], [ %t75, %logical_and_right_end_41 ]
  %t77 = load %Token, %Token* %l0
  br i1 %t76, label %then4, label %merge5
then4:
  %t78 = call %ExpressionParseResult @parse_lambda_expression(%ExpressionTokens %state)
  store %ExpressionParseResult %t78, %ExpressionParseResult* %l2
  %t79 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t80 = extractvalue %ExpressionParseResult %t79, 2
  %t81 = load %Token, %Token* %l0
  %t82 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  br i1 %t80, label %then6, label %merge7
then6:
  %t83 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  ret %ExpressionParseResult %t83
merge7:
  br label %merge5
merge5:
  %t84 = call %ExpressionParseResult @parse_primary_expression(%ExpressionTokens %state)
  store %ExpressionParseResult %t84, %ExpressionParseResult* %l3
  %t85 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  %t86 = extractvalue %ExpressionParseResult %t85, 2
  %t87 = xor i1 %t86, 1
  %t88 = load %Token, %Token* %l0
  %t89 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  br i1 %t87, label %then8, label %merge9
then8:
  %t90 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  ret %ExpressionParseResult %t90
merge9:
  %t91 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  %t92 = extractvalue %ExpressionParseResult %t91, 0
  %t93 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  %t94 = extractvalue %ExpressionParseResult %t93, 1
  %t95 = call %ExpressionParseResult @parse_postfix_chain(%ExpressionTokens zeroinitializer, %Expression zeroinitializer)
  ret %ExpressionParseResult %t95
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
  %t5 = getelementptr inbounds %TokenKind, %TokenKind* %t4, i32 0, i32 0
  %t6 = load i32, i32* %t5
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
  %s32 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.32, i32 0, i32 0
  %t33 = icmp eq i8* %t31, %s32
  %t34 = load %Token, %Token* %l0
  br i1 %t33, label %then2, label %merge3
then2:
  %t35 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %state)
  %t36 = insertvalue %ExpressionParseResult undef, %ExpressionTokens* null, 0
  %t37 = alloca %Expression
  %t38 = getelementptr inbounds %Expression, %Expression* %t37, i32 0, i32 0
  store i32 1, i32* %t38
  %t39 = load %Token, %Token* %l0
  %t40 = extractvalue %Token %t39, 0
  %t41 = getelementptr inbounds %TokenKind, %TokenKind* %t40, i32 0, i32 0
  %t42 = load i32, i32* %t41
  %t43 = getelementptr inbounds %TokenKind, %TokenKind* %t40, i32 0, i32 1
  %t44 = bitcast [8 x i8]* %t43 to i8*
  %t45 = bitcast i8* %t44 to i8**
  %t46 = load i8*, i8** %t45
  %t47 = icmp eq i32 %t42, 0
  %t48 = select i1 %t47, i8* %t46, i8* null
  %t49 = getelementptr inbounds %TokenKind, %TokenKind* %t40, i32 0, i32 1
  %t50 = bitcast [8 x i8]* %t49 to i8*
  %t51 = bitcast i8* %t50 to i8**
  %t52 = load i8*, i8** %t51
  %t53 = icmp eq i32 %t42, 1
  %t54 = select i1 %t53, i8* %t52, i8* %t48
  %t55 = getelementptr inbounds %TokenKind, %TokenKind* %t40, i32 0, i32 1
  %t56 = bitcast [8 x i8]* %t55 to i8*
  %t57 = bitcast i8* %t56 to i8**
  %t58 = load i8*, i8** %t57
  %t59 = icmp eq i32 %t42, 2
  %t60 = select i1 %t59, i8* %t58, i8* %t54
  %t61 = getelementptr inbounds %TokenKind, %TokenKind* %t40, i32 0, i32 1
  %t62 = bitcast [8 x i8]* %t61 to i8*
  %t63 = bitcast i8* %t62 to i8**
  %t64 = load i8*, i8** %t63
  %t65 = icmp eq i32 %t42, 4
  %t66 = select i1 %t65, i8* %t64, i8* %t60
  %t67 = getelementptr inbounds %Expression, %Expression* %t37, i32 0, i32 1
  %t68 = bitcast [8 x i8]* %t67 to i8*
  %t69 = bitcast i8* %t68 to i8**
  store i8* %t66, i8** %t69
  %t70 = load %Expression, %Expression* %t37
  %t71 = insertvalue %ExpressionParseResult %t36, %Expression* null, 1
  %t72 = insertvalue %ExpressionParseResult %t71, i1 1, 2
  ret %ExpressionParseResult %t72
merge3:
  %t73 = load %Token, %Token* %l0
  %t74 = extractvalue %Token %t73, 0
  %t75 = getelementptr inbounds %TokenKind, %TokenKind* %t74, i32 0, i32 0
  %t76 = load i32, i32* %t75
  %t77 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t78 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t76, 0
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %t81 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t76, 1
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t76, 2
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %t87 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t88 = icmp eq i32 %t76, 3
  %t89 = select i1 %t88, i8* %t87, i8* %t86
  %t90 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t91 = icmp eq i32 %t76, 4
  %t92 = select i1 %t91, i8* %t90, i8* %t89
  %t93 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t76, 5
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %t96 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t97 = icmp eq i32 %t76, 6
  %t98 = select i1 %t97, i8* %t96, i8* %t95
  %t99 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t76, 7
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %s102 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.102, i32 0, i32 0
  %t103 = icmp eq i8* %t101, %s102
  %t104 = load %Token, %Token* %l0
  br i1 %t103, label %then4, label %merge5
then4:
  %t105 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %state)
  %t106 = insertvalue %ExpressionParseResult undef, %ExpressionTokens* null, 0
  %t107 = alloca %Expression
  %t108 = getelementptr inbounds %Expression, %Expression* %t107, i32 0, i32 0
  store i32 3, i32* %t108
  %t109 = load %Token, %Token* %l0
  %t110 = extractvalue %Token %t109, 0
  %t111 = getelementptr inbounds %TokenKind, %TokenKind* %t110, i32 0, i32 0
  %t112 = load i32, i32* %t111
  %t113 = getelementptr inbounds %TokenKind, %TokenKind* %t110, i32 0, i32 1
  %t114 = bitcast [1 x i8]* %t113 to i8*
  %t115 = bitcast i8* %t114 to i1*
  %t116 = load i1, i1* %t115
  %t117 = icmp eq i32 %t112, 3
  %t118 = select i1 %t117, i1 %t116, i1 false
  %t119 = getelementptr inbounds %Expression, %Expression* %t107, i32 0, i32 1
  %t120 = bitcast [1 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to i1*
  store i1 %t118, i1* %t121
  %t122 = load %Expression, %Expression* %t107
  %t123 = insertvalue %ExpressionParseResult %t106, %Expression* null, 1
  %t124 = insertvalue %ExpressionParseResult %t123, i1 1, 2
  ret %ExpressionParseResult %t124
merge5:
  %t125 = load %Token, %Token* %l0
  %t126 = extractvalue %Token %t125, 0
  %t127 = getelementptr inbounds %TokenKind, %TokenKind* %t126, i32 0, i32 0
  %t128 = load i32, i32* %t127
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
  %s154 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.154, i32 0, i32 0
  %t155 = icmp eq i8* %t153, %s154
  %t156 = load %Token, %Token* %l0
  br i1 %t155, label %then6, label %merge7
then6:
  %t157 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %state)
  %t158 = insertvalue %ExpressionParseResult undef, %ExpressionTokens* null, 0
  %t159 = alloca %Expression
  %t160 = getelementptr inbounds %Expression, %Expression* %t159, i32 0, i32 0
  store i32 2, i32* %t160
  %t161 = load %Token, %Token* %l0
  %t162 = extractvalue %Token %t161, 0
  %t163 = getelementptr inbounds %TokenKind, %TokenKind* %t162, i32 0, i32 0
  %t164 = load i32, i32* %t163
  %t165 = getelementptr inbounds %TokenKind, %TokenKind* %t162, i32 0, i32 1
  %t166 = bitcast [8 x i8]* %t165 to i8*
  %t167 = bitcast i8* %t166 to i8**
  %t168 = load i8*, i8** %t167
  %t169 = icmp eq i32 %t164, 0
  %t170 = select i1 %t169, i8* %t168, i8* null
  %t171 = getelementptr inbounds %TokenKind, %TokenKind* %t162, i32 0, i32 1
  %t172 = bitcast [8 x i8]* %t171 to i8*
  %t173 = bitcast i8* %t172 to i8**
  %t174 = load i8*, i8** %t173
  %t175 = icmp eq i32 %t164, 1
  %t176 = select i1 %t175, i8* %t174, i8* %t170
  %t177 = getelementptr inbounds %TokenKind, %TokenKind* %t162, i32 0, i32 1
  %t178 = bitcast [8 x i8]* %t177 to i8*
  %t179 = bitcast i8* %t178 to i8**
  %t180 = load i8*, i8** %t179
  %t181 = icmp eq i32 %t164, 2
  %t182 = select i1 %t181, i8* %t180, i8* %t176
  %t183 = getelementptr inbounds %TokenKind, %TokenKind* %t162, i32 0, i32 1
  %t184 = bitcast [8 x i8]* %t183 to i8*
  %t185 = bitcast i8* %t184 to i8**
  %t186 = load i8*, i8** %t185
  %t187 = icmp eq i32 %t164, 4
  %t188 = select i1 %t187, i8* %t186, i8* %t182
  %t189 = getelementptr inbounds %Expression, %Expression* %t159, i32 0, i32 1
  %t190 = bitcast [8 x i8]* %t189 to i8*
  %t191 = bitcast i8* %t190 to i8**
  store i8* %t188, i8** %t191
  %t192 = load %Expression, %Expression* %t159
  %t193 = insertvalue %ExpressionParseResult %t158, %Expression* null, 1
  %t194 = insertvalue %ExpressionParseResult %t193, i1 1, 2
  ret %ExpressionParseResult %t194
merge7:
  %t195 = load %Token, %Token* %l0
  %t196 = extractvalue %Token %t195, 0
  %t197 = getelementptr inbounds %TokenKind, %TokenKind* %t196, i32 0, i32 0
  %t198 = load i32, i32* %t197
  %t199 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t200 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t201 = icmp eq i32 %t198, 0
  %t202 = select i1 %t201, i8* %t200, i8* %t199
  %t203 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t204 = icmp eq i32 %t198, 1
  %t205 = select i1 %t204, i8* %t203, i8* %t202
  %t206 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t207 = icmp eq i32 %t198, 2
  %t208 = select i1 %t207, i8* %t206, i8* %t205
  %t209 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t210 = icmp eq i32 %t198, 3
  %t211 = select i1 %t210, i8* %t209, i8* %t208
  %t212 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t213 = icmp eq i32 %t198, 4
  %t214 = select i1 %t213, i8* %t212, i8* %t211
  %t215 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t216 = icmp eq i32 %t198, 5
  %t217 = select i1 %t216, i8* %t215, i8* %t214
  %t218 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t219 = icmp eq i32 %t198, 6
  %t220 = select i1 %t219, i8* %t218, i8* %t217
  %t221 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t222 = icmp eq i32 %t198, 7
  %t223 = select i1 %t222, i8* %t221, i8* %t220
  %s224 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.224, i32 0, i32 0
  %t225 = icmp eq i8* %t223, %s224
  %t226 = load %Token, %Token* %l0
  br i1 %t225, label %then8, label %merge9
then8:
  %t227 = load %Token, %Token* %l0
  %t228 = call i8* @identifier_text(%Token %t227)
  store i8* %t228, i8** %l1
  %t229 = load i8*, i8** %l1
  %s230 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.230, i32 0, i32 0
  %t231 = icmp eq i8* %t229, %s230
  %t232 = load %Token, %Token* %l0
  %t233 = load i8*, i8** %l1
  br i1 %t231, label %then10, label %merge11
then10:
  %t234 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %state)
  %t235 = insertvalue %ExpressionParseResult undef, %ExpressionTokens* null, 0
  %t236 = alloca %Expression
  %t237 = getelementptr inbounds %Expression, %Expression* %t236, i32 0, i32 0
  store i32 3, i32* %t237
  %t238 = getelementptr inbounds %Expression, %Expression* %t236, i32 0, i32 1
  %t239 = bitcast [1 x i8]* %t238 to i8*
  %t240 = bitcast i8* %t239 to i1*
  store i1 1, i1* %t240
  %t241 = load %Expression, %Expression* %t236
  %t242 = insertvalue %ExpressionParseResult %t235, %Expression* null, 1
  %t243 = insertvalue %ExpressionParseResult %t242, i1 1, 2
  ret %ExpressionParseResult %t243
merge11:
  %t244 = load i8*, i8** %l1
  %s245 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.245, i32 0, i32 0
  %t246 = icmp eq i8* %t244, %s245
  %t247 = load %Token, %Token* %l0
  %t248 = load i8*, i8** %l1
  br i1 %t246, label %then12, label %merge13
then12:
  %t249 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %state)
  %t250 = insertvalue %ExpressionParseResult undef, %ExpressionTokens* null, 0
  %t251 = alloca %Expression
  %t252 = getelementptr inbounds %Expression, %Expression* %t251, i32 0, i32 0
  store i32 3, i32* %t252
  %t253 = getelementptr inbounds %Expression, %Expression* %t251, i32 0, i32 1
  %t254 = bitcast [1 x i8]* %t253 to i8*
  %t255 = bitcast i8* %t254 to i1*
  store i1 0, i1* %t255
  %t256 = load %Expression, %Expression* %t251
  %t257 = insertvalue %ExpressionParseResult %t250, %Expression* null, 1
  %t258 = insertvalue %ExpressionParseResult %t257, i1 1, 2
  ret %ExpressionParseResult %t258
merge13:
  %t259 = load i8*, i8** %l1
  %s260 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.260, i32 0, i32 0
  %t261 = icmp eq i8* %t259, %s260
  %t262 = load %Token, %Token* %l0
  %t263 = load i8*, i8** %l1
  br i1 %t261, label %then14, label %merge15
then14:
  %t264 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %state)
  %t265 = insertvalue %ExpressionParseResult undef, %ExpressionTokens* null, 0
  %t266 = insertvalue %Expression undef, i32 4, 0
  %t267 = insertvalue %ExpressionParseResult %t265, %Expression* null, 1
  %t268 = insertvalue %ExpressionParseResult %t267, i1 1, 2
  ret %ExpressionParseResult %t268
merge15:
  %t269 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %state)
  %t270 = insertvalue %ExpressionParseResult undef, %ExpressionTokens* null, 0
  %t271 = alloca %Expression
  %t272 = getelementptr inbounds %Expression, %Expression* %t271, i32 0, i32 0
  store i32 0, i32* %t272
  %t273 = load i8*, i8** %l1
  %t274 = getelementptr inbounds %Expression, %Expression* %t271, i32 0, i32 1
  %t275 = bitcast [8 x i8]* %t274 to i8*
  %t276 = bitcast i8* %t275 to i8**
  store i8* %t273, i8** %t276
  %t277 = load %Expression, %Expression* %t271
  %t278 = insertvalue %ExpressionParseResult %t270, %Expression* null, 1
  %t279 = insertvalue %ExpressionParseResult %t278, i1 1, 2
  ret %ExpressionParseResult %t279
merge9:
  %t281 = load %Token, %Token* %l0
  %t282 = extractvalue %Token %t281, 0
  %t283 = getelementptr inbounds %TokenKind, %TokenKind* %t282, i32 0, i32 0
  %t284 = load i32, i32* %t283
  %t285 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t286 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t287 = icmp eq i32 %t284, 0
  %t288 = select i1 %t287, i8* %t286, i8* %t285
  %t289 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t290 = icmp eq i32 %t284, 1
  %t291 = select i1 %t290, i8* %t289, i8* %t288
  %t292 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t293 = icmp eq i32 %t284, 2
  %t294 = select i1 %t293, i8* %t292, i8* %t291
  %t295 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t296 = icmp eq i32 %t284, 3
  %t297 = select i1 %t296, i8* %t295, i8* %t294
  %t298 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t299 = icmp eq i32 %t284, 4
  %t300 = select i1 %t299, i8* %t298, i8* %t297
  %t301 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t302 = icmp eq i32 %t284, 5
  %t303 = select i1 %t302, i8* %t301, i8* %t300
  %t304 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t305 = icmp eq i32 %t284, 6
  %t306 = select i1 %t305, i8* %t304, i8* %t303
  %t307 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t308 = icmp eq i32 %t284, 7
  %t309 = select i1 %t308, i8* %t307, i8* %t306
  %s310 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.310, i32 0, i32 0
  %t311 = icmp eq i8* %t309, %s310
  br label %logical_and_entry_280

logical_and_entry_280:
  br i1 %t311, label %logical_and_right_280, label %logical_and_merge_280

logical_and_right_280:
  %t312 = load %Token, %Token* %l0
  %t313 = extractvalue %Token %t312, 0
  %t314 = getelementptr inbounds %TokenKind, %TokenKind* %t313, i32 0, i32 0
  %t315 = load i32, i32* %t314
  %t317 = load %Token, %Token* %l0
  %t318 = extractvalue %Token %t317, 0
  %t319 = getelementptr inbounds %TokenKind, %TokenKind* %t318, i32 0, i32 0
  %t320 = load i32, i32* %t319
  %t321 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t322 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t323 = icmp eq i32 %t320, 0
  %t324 = select i1 %t323, i8* %t322, i8* %t321
  %t325 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t326 = icmp eq i32 %t320, 1
  %t327 = select i1 %t326, i8* %t325, i8* %t324
  %t328 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t329 = icmp eq i32 %t320, 2
  %t330 = select i1 %t329, i8* %t328, i8* %t327
  %t331 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t332 = icmp eq i32 %t320, 3
  %t333 = select i1 %t332, i8* %t331, i8* %t330
  %t334 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t335 = icmp eq i32 %t320, 4
  %t336 = select i1 %t335, i8* %t334, i8* %t333
  %t337 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t338 = icmp eq i32 %t320, 5
  %t339 = select i1 %t338, i8* %t337, i8* %t336
  %t340 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t341 = icmp eq i32 %t320, 6
  %t342 = select i1 %t341, i8* %t340, i8* %t339
  %t343 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t344 = icmp eq i32 %t320, 7
  %t345 = select i1 %t344, i8* %t343, i8* %t342
  %s346 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.346, i32 0, i32 0
  %t347 = icmp eq i8* %t345, %s346
  br label %logical_and_entry_316

logical_and_entry_316:
  br i1 %t347, label %logical_and_right_316, label %logical_and_merge_316

logical_and_right_316:
  %t348 = load %Token, %Token* %l0
  %t349 = extractvalue %Token %t348, 0
  %t350 = getelementptr inbounds %TokenKind, %TokenKind* %t349, i32 0, i32 0
  %t351 = load i32, i32* %t350
  %t353 = load %Token, %Token* %l0
  %t354 = extractvalue %Token %t353, 0
  %t355 = getelementptr inbounds %TokenKind, %TokenKind* %t354, i32 0, i32 0
  %t356 = load i32, i32* %t355
  %t357 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t358 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t359 = icmp eq i32 %t356, 0
  %t360 = select i1 %t359, i8* %t358, i8* %t357
  %t361 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t362 = icmp eq i32 %t356, 1
  %t363 = select i1 %t362, i8* %t361, i8* %t360
  %t364 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t365 = icmp eq i32 %t356, 2
  %t366 = select i1 %t365, i8* %t364, i8* %t363
  %t367 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t368 = icmp eq i32 %t356, 3
  %t369 = select i1 %t368, i8* %t367, i8* %t366
  %t370 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t371 = icmp eq i32 %t356, 4
  %t372 = select i1 %t371, i8* %t370, i8* %t369
  %t373 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t374 = icmp eq i32 %t356, 5
  %t375 = select i1 %t374, i8* %t373, i8* %t372
  %t376 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t377 = icmp eq i32 %t356, 6
  %t378 = select i1 %t377, i8* %t376, i8* %t375
  %t379 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t380 = icmp eq i32 %t356, 7
  %t381 = select i1 %t380, i8* %t379, i8* %t378
  %s382 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.382, i32 0, i32 0
  %t383 = icmp eq i8* %t381, %s382
  br label %logical_and_entry_352

logical_and_entry_352:
  br i1 %t383, label %logical_and_right_352, label %logical_and_merge_352

logical_and_right_352:
  %t384 = load %Token, %Token* %l0
  %t385 = extractvalue %Token %t384, 0
  %t386 = getelementptr inbounds %TokenKind, %TokenKind* %t385, i32 0, i32 0
  %t387 = load i32, i32* %t386
  %t388 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t388
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
  %t10 = getelementptr inbounds %TokenKind, %TokenKind* %t9, i32 0, i32 0
  %t11 = load i32, i32* %t10
  %t12 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t13 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t14 = icmp eq i32 %t11, 0
  %t15 = select i1 %t14, i8* %t13, i8* %t12
  %t16 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t17 = icmp eq i32 %t11, 1
  %t18 = select i1 %t17, i8* %t16, i8* %t15
  %t19 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t20 = icmp eq i32 %t11, 2
  %t21 = select i1 %t20, i8* %t19, i8* %t18
  %t22 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t23 = icmp eq i32 %t11, 3
  %t24 = select i1 %t23, i8* %t22, i8* %t21
  %t25 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t11, 4
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t11, 5
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %t31 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t32 = icmp eq i32 %t11, 6
  %t33 = select i1 %t32, i8* %t31, i8* %t30
  %t34 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t11, 7
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %s37 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.37, i32 0, i32 0
  %t38 = icmp ne i8* %t36, %s37
  %t39 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t40 = load %Expression, %Expression* %l1
  %t41 = load %Token, %Token* %l2
  br i1 %t38, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t42 = load %Token, %Token* %l2
  %t43 = extractvalue %Token %t42, 0
  %t44 = getelementptr inbounds %TokenKind, %TokenKind* %t43, i32 0, i32 0
  %t45 = load i32, i32* %t44
  store double 0.0, double* %l3
  %t46 = load double, double* %l3
  %t47 = load double, double* %l3
  %t48 = load double, double* %l3
  %t49 = load double, double* %l3
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t50 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t51 = insertvalue %ExpressionParseResult undef, %ExpressionTokens* null, 0
  %t52 = load %Expression, %Expression* %l1
  %t53 = insertvalue %ExpressionParseResult %t51, %Expression* null, 1
  %t54 = insertvalue %ExpressionParseResult %t53, i1 1, 2
  ret %ExpressionParseResult %t54
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
  %t10 = insertvalue %CallArgumentsParseResult undef, %ExpressionTokens* null, 0
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
  %t22 = getelementptr inbounds %TokenKind, %TokenKind* %t21, i32 0, i32 0
  %t23 = load i32, i32* %t22
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
  br label %logical_and_entry_18

logical_and_entry_18:
  br i1 %t50, label %logical_and_right_18, label %logical_and_merge_18

logical_and_right_18:
  %t51 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t52 = call %Token @expression_tokens_peek(%ExpressionTokens %t51)
  %t53 = extractvalue %Token %t52, 0
  %t54 = getelementptr inbounds %TokenKind, %TokenKind* %t53, i32 0, i32 0
  %t55 = load i32, i32* %t54
  %t56 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t57 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  br label %loop.header2
loop.header2:
  %t178 = phi { %Expression*, i64 }* [ %t57, %entry ], [ %t176, %loop.latch4 ]
  %t179 = phi %ExpressionTokens [ %t56, %entry ], [ %t177, %loop.latch4 ]
  store { %Expression*, i64 }* %t178, { %Expression*, i64 }** %l1
  store %ExpressionTokens %t179, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t58 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t59 = sitofp i64 0 to double
  %t60 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %t58, double %t59)
  store %ExpressionParseResult %t60, %ExpressionParseResult* %l2
  %t61 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t62 = extractvalue %ExpressionParseResult %t61, 2
  %t63 = xor i1 %t62, 1
  %t64 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t65 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t66 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  br i1 %t63, label %then6, label %merge7
then6:
  %t67 = insertvalue %CallArgumentsParseResult undef, %ExpressionTokens* null, 0
  %t68 = alloca [0 x %Expression*]
  %t69 = getelementptr [0 x %Expression*], [0 x %Expression*]* %t68, i32 0, i32 0
  %t70 = alloca { %Expression**, i64 }
  %t71 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t70, i32 0, i32 0
  store %Expression** %t69, %Expression*** %t71
  %t72 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t70, i32 0, i32 1
  store i64 0, i64* %t72
  %t73 = insertvalue %CallArgumentsParseResult %t67, { %Expression**, i64 }* %t70, 1
  %t74 = insertvalue %CallArgumentsParseResult %t73, i1 0, 2
  ret %CallArgumentsParseResult %t74
merge7:
  %t75 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t76 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t77 = extractvalue %ExpressionParseResult %t76, 1
  %t78 = call { %Expression*, i64 }* @append_expression({ %Expression*, i64 }* %t75, %Expression zeroinitializer)
  store { %Expression*, i64 }* %t78, { %Expression*, i64 }** %l1
  %t79 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t80 = extractvalue %ExpressionParseResult %t79, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t81 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t82 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t81)
  %t83 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t84 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t85 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  br i1 %t82, label %then8, label %merge9
then8:
  %t86 = insertvalue %CallArgumentsParseResult undef, %ExpressionTokens* null, 0
  %t87 = alloca [0 x %Expression*]
  %t88 = getelementptr [0 x %Expression*], [0 x %Expression*]* %t87, i32 0, i32 0
  %t89 = alloca { %Expression**, i64 }
  %t90 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t89, i32 0, i32 0
  store %Expression** %t88, %Expression*** %t90
  %t91 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t89, i32 0, i32 1
  store i64 0, i64* %t91
  %t92 = insertvalue %CallArgumentsParseResult %t86, { %Expression**, i64 }* %t89, 1
  %t93 = insertvalue %CallArgumentsParseResult %t92, i1 0, 2
  ret %CallArgumentsParseResult %t93
merge9:
  %t94 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t95 = call %Token @expression_tokens_peek(%ExpressionTokens %t94)
  store %Token %t95, %Token* %l3
  %t97 = load %Token, %Token* %l3
  %t98 = extractvalue %Token %t97, 0
  %t99 = getelementptr inbounds %TokenKind, %TokenKind* %t98, i32 0, i32 0
  %t100 = load i32, i32* %t99
  %t101 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t102 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t100, 0
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t106 = icmp eq i32 %t100, 1
  %t107 = select i1 %t106, i8* %t105, i8* %t104
  %t108 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t100, 2
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t112 = icmp eq i32 %t100, 3
  %t113 = select i1 %t112, i8* %t111, i8* %t110
  %t114 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t100, 4
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %t117 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t118 = icmp eq i32 %t100, 5
  %t119 = select i1 %t118, i8* %t117, i8* %t116
  %t120 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t100, 6
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %t123 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t124 = icmp eq i32 %t100, 7
  %t125 = select i1 %t124, i8* %t123, i8* %t122
  %s126 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.126, i32 0, i32 0
  %t127 = icmp eq i8* %t125, %s126
  br label %logical_and_entry_96

logical_and_entry_96:
  br i1 %t127, label %logical_and_right_96, label %logical_and_merge_96

logical_and_right_96:
  %t128 = load %Token, %Token* %l3
  %t129 = extractvalue %Token %t128, 0
  %t130 = getelementptr inbounds %TokenKind, %TokenKind* %t129, i32 0, i32 0
  %t131 = load i32, i32* %t130
  %t133 = load %Token, %Token* %l3
  %t134 = extractvalue %Token %t133, 0
  %t135 = getelementptr inbounds %TokenKind, %TokenKind* %t134, i32 0, i32 0
  %t136 = load i32, i32* %t135
  %t137 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t138 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t136, 0
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t136, 1
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t136, 2
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t136, 3
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t136, 4
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t136, 5
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t136, 6
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t136, 7
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %s162 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.162, i32 0, i32 0
  %t163 = icmp eq i8* %t161, %s162
  br label %logical_and_entry_132

logical_and_entry_132:
  br i1 %t163, label %logical_and_right_132, label %logical_and_merge_132

logical_and_right_132:
  %t164 = load %Token, %Token* %l3
  %t165 = extractvalue %Token %t164, 0
  %t166 = getelementptr inbounds %TokenKind, %TokenKind* %t165, i32 0, i32 0
  %t167 = load i32, i32* %t166
  %t168 = insertvalue %CallArgumentsParseResult undef, %ExpressionTokens* null, 0
  %t169 = alloca [0 x %Expression*]
  %t170 = getelementptr [0 x %Expression*], [0 x %Expression*]* %t169, i32 0, i32 0
  %t171 = alloca { %Expression**, i64 }
  %t172 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t171, i32 0, i32 0
  store %Expression** %t170, %Expression*** %t172
  %t173 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t171, i32 0, i32 1
  store i64 0, i64* %t173
  %t174 = insertvalue %CallArgumentsParseResult %t168, { %Expression**, i64 }* %t171, 1
  %t175 = insertvalue %CallArgumentsParseResult %t174, i1 0, 2
  ret %CallArgumentsParseResult %t175
loop.latch4:
  %t176 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t177 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t180 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t181 = insertvalue %CallArgumentsParseResult undef, %ExpressionTokens* null, 0
  %t182 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t183 = bitcast { %Expression*, i64 }* %t182 to { %Expression**, i64 }*
  %t184 = insertvalue %CallArgumentsParseResult %t181, { %Expression**, i64 }* %t183, 1
  %t185 = insertvalue %CallArgumentsParseResult %t184, i1 1, 2
  ret %CallArgumentsParseResult %t185
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
  %t9 = insertvalue %ArrayLiteralParseResult undef, %ExpressionTokens* null, 0
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
  %t21 = getelementptr inbounds %TokenKind, %TokenKind* %t20, i32 0, i32 0
  %t22 = load i32, i32* %t21
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
  br label %logical_and_entry_17

logical_and_entry_17:
  br i1 %t49, label %logical_and_right_17, label %logical_and_merge_17

logical_and_right_17:
  %t50 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t51 = call %Token @expression_tokens_peek(%ExpressionTokens %t50)
  %t52 = extractvalue %Token %t51, 0
  %t53 = getelementptr inbounds %TokenKind, %TokenKind* %t52, i32 0, i32 0
  %t54 = load i32, i32* %t53
  %t55 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t56 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  br label %loop.header2
loop.header2:
  %t177 = phi { %Expression*, i64 }* [ %t56, %entry ], [ %t175, %loop.latch4 ]
  %t178 = phi %ExpressionTokens [ %t55, %entry ], [ %t176, %loop.latch4 ]
  store { %Expression*, i64 }* %t177, { %Expression*, i64 }** %l1
  store %ExpressionTokens %t178, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t57 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t58 = sitofp i64 0 to double
  %t59 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %t57, double %t58)
  store %ExpressionParseResult %t59, %ExpressionParseResult* %l2
  %t60 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t61 = extractvalue %ExpressionParseResult %t60, 2
  %t62 = xor i1 %t61, 1
  %t63 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t64 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t65 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  br i1 %t62, label %then6, label %merge7
then6:
  %t66 = insertvalue %ArrayLiteralParseResult undef, %ExpressionTokens* null, 0
  %t67 = alloca [0 x %Expression*]
  %t68 = getelementptr [0 x %Expression*], [0 x %Expression*]* %t67, i32 0, i32 0
  %t69 = alloca { %Expression**, i64 }
  %t70 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t69, i32 0, i32 0
  store %Expression** %t68, %Expression*** %t70
  %t71 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t69, i32 0, i32 1
  store i64 0, i64* %t71
  %t72 = insertvalue %ArrayLiteralParseResult %t66, { %Expression**, i64 }* %t69, 1
  %t73 = insertvalue %ArrayLiteralParseResult %t72, i1 0, 2
  ret %ArrayLiteralParseResult %t73
merge7:
  %t74 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t75 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t76 = extractvalue %ExpressionParseResult %t75, 1
  %t77 = call { %Expression*, i64 }* @append_expression({ %Expression*, i64 }* %t74, %Expression zeroinitializer)
  store { %Expression*, i64 }* %t77, { %Expression*, i64 }** %l1
  %t78 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t79 = extractvalue %ExpressionParseResult %t78, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t80 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t81 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t80)
  %t82 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t83 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t84 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  br i1 %t81, label %then8, label %merge9
then8:
  %t85 = insertvalue %ArrayLiteralParseResult undef, %ExpressionTokens* null, 0
  %t86 = alloca [0 x %Expression*]
  %t87 = getelementptr [0 x %Expression*], [0 x %Expression*]* %t86, i32 0, i32 0
  %t88 = alloca { %Expression**, i64 }
  %t89 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t88, i32 0, i32 0
  store %Expression** %t87, %Expression*** %t89
  %t90 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t88, i32 0, i32 1
  store i64 0, i64* %t90
  %t91 = insertvalue %ArrayLiteralParseResult %t85, { %Expression**, i64 }* %t88, 1
  %t92 = insertvalue %ArrayLiteralParseResult %t91, i1 0, 2
  ret %ArrayLiteralParseResult %t92
merge9:
  %t93 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t94 = call %Token @expression_tokens_peek(%ExpressionTokens %t93)
  store %Token %t94, %Token* %l3
  %t96 = load %Token, %Token* %l3
  %t97 = extractvalue %Token %t96, 0
  %t98 = getelementptr inbounds %TokenKind, %TokenKind* %t97, i32 0, i32 0
  %t99 = load i32, i32* %t98
  %t100 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t101 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t99, 0
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t99, 1
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t99, 2
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t99, 3
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t99, 4
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %t116 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t99, 5
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %t119 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t99, 6
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %t122 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t123 = icmp eq i32 %t99, 7
  %t124 = select i1 %t123, i8* %t122, i8* %t121
  %s125 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.125, i32 0, i32 0
  %t126 = icmp eq i8* %t124, %s125
  br label %logical_and_entry_95

logical_and_entry_95:
  br i1 %t126, label %logical_and_right_95, label %logical_and_merge_95

logical_and_right_95:
  %t127 = load %Token, %Token* %l3
  %t128 = extractvalue %Token %t127, 0
  %t129 = getelementptr inbounds %TokenKind, %TokenKind* %t128, i32 0, i32 0
  %t130 = load i32, i32* %t129
  %t132 = load %Token, %Token* %l3
  %t133 = extractvalue %Token %t132, 0
  %t134 = getelementptr inbounds %TokenKind, %TokenKind* %t133, i32 0, i32 0
  %t135 = load i32, i32* %t134
  %t136 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t137 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t135, 0
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t135, 1
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t135, 2
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t135, 3
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t135, 4
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t135, 5
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t135, 6
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t135, 7
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %s161 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.161, i32 0, i32 0
  %t162 = icmp eq i8* %t160, %s161
  br label %logical_and_entry_131

logical_and_entry_131:
  br i1 %t162, label %logical_and_right_131, label %logical_and_merge_131

logical_and_right_131:
  %t163 = load %Token, %Token* %l3
  %t164 = extractvalue %Token %t163, 0
  %t165 = getelementptr inbounds %TokenKind, %TokenKind* %t164, i32 0, i32 0
  %t166 = load i32, i32* %t165
  %t167 = insertvalue %ArrayLiteralParseResult undef, %ExpressionTokens* null, 0
  %t168 = alloca [0 x %Expression*]
  %t169 = getelementptr [0 x %Expression*], [0 x %Expression*]* %t168, i32 0, i32 0
  %t170 = alloca { %Expression**, i64 }
  %t171 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t170, i32 0, i32 0
  store %Expression** %t169, %Expression*** %t171
  %t172 = getelementptr { %Expression**, i64 }, { %Expression**, i64 }* %t170, i32 0, i32 1
  store i64 0, i64* %t172
  %t173 = insertvalue %ArrayLiteralParseResult %t167, { %Expression**, i64 }* %t170, 1
  %t174 = insertvalue %ArrayLiteralParseResult %t173, i1 0, 2
  ret %ArrayLiteralParseResult %t174
loop.latch4:
  %t175 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t176 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t179 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t180 = insertvalue %ArrayLiteralParseResult undef, %ExpressionTokens* null, 0
  %t181 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t182 = bitcast { %Expression*, i64 }* %t181 to { %Expression**, i64 }*
  %t183 = insertvalue %ArrayLiteralParseResult %t180, { %Expression**, i64 }* %t182, 1
  %t184 = insertvalue %ArrayLiteralParseResult %t183, i1 1, 2
  ret %ArrayLiteralParseResult %t184
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
  %t9 = insertvalue %ObjectLiteralParseResult undef, %ExpressionTokens* null, 0
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
  %t21 = getelementptr inbounds %TokenKind, %TokenKind* %t20, i32 0, i32 0
  %t22 = load i32, i32* %t21
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
  br label %logical_and_entry_17

logical_and_entry_17:
  br i1 %t49, label %logical_and_right_17, label %logical_and_merge_17

logical_and_right_17:
  %t50 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t51 = call %Token @expression_tokens_peek(%ExpressionTokens %t50)
  %t52 = extractvalue %Token %t51, 0
  %t53 = getelementptr inbounds %TokenKind, %TokenKind* %t52, i32 0, i32 0
  %t54 = load i32, i32* %t53
  %t55 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t56 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  br label %loop.header2
loop.header2:
  %t300 = phi %ExpressionTokens [ %t55, %entry ], [ %t298, %loop.latch4 ]
  %t301 = phi { %ObjectField*, i64 }* [ %t56, %entry ], [ %t299, %loop.latch4 ]
  store %ExpressionTokens %t300, %ExpressionTokens* %l0
  store { %ObjectField*, i64 }* %t301, { %ObjectField*, i64 }** %l1
  br label %loop.body3
loop.body3:
  %t57 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t58 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t57)
  %t59 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t60 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  br i1 %t58, label %then6, label %merge7
then6:
  %t61 = insertvalue %ObjectLiteralParseResult undef, %ExpressionTokens* null, 0
  %t62 = alloca [0 x %ObjectField*]
  %t63 = getelementptr [0 x %ObjectField*], [0 x %ObjectField*]* %t62, i32 0, i32 0
  %t64 = alloca { %ObjectField**, i64 }
  %t65 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t64, i32 0, i32 0
  store %ObjectField** %t63, %ObjectField*** %t65
  %t66 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t64, i32 0, i32 1
  store i64 0, i64* %t66
  %t67 = insertvalue %ObjectLiteralParseResult %t61, { %ObjectField**, i64 }* %t64, 1
  %t68 = insertvalue %ObjectLiteralParseResult %t67, i1 0, 2
  ret %ObjectLiteralParseResult %t68
merge7:
  %t69 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t70 = call %Token @expression_tokens_peek(%ExpressionTokens %t69)
  store %Token %t70, %Token* %l2
  %t71 = load %Token, %Token* %l2
  %t72 = extractvalue %Token %t71, 0
  %t73 = getelementptr inbounds %TokenKind, %TokenKind* %t72, i32 0, i32 0
  %t74 = load i32, i32* %t73
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
  %s100 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.100, i32 0, i32 0
  %t101 = icmp ne i8* %t99, %s100
  %t102 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t103 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  %t104 = load %Token, %Token* %l2
  br i1 %t101, label %then8, label %merge9
then8:
  %t105 = insertvalue %ObjectLiteralParseResult undef, %ExpressionTokens* null, 0
  %t106 = alloca [0 x %ObjectField*]
  %t107 = getelementptr [0 x %ObjectField*], [0 x %ObjectField*]* %t106, i32 0, i32 0
  %t108 = alloca { %ObjectField**, i64 }
  %t109 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t108, i32 0, i32 0
  store %ObjectField** %t107, %ObjectField*** %t109
  %t110 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t108, i32 0, i32 1
  store i64 0, i64* %t110
  %t111 = insertvalue %ObjectLiteralParseResult %t105, { %ObjectField**, i64 }* %t108, 1
  %t112 = insertvalue %ObjectLiteralParseResult %t111, i1 0, 2
  ret %ObjectLiteralParseResult %t112
merge9:
  %t113 = load %Token, %Token* %l2
  %t114 = call i8* @identifier_text(%Token %t113)
  store i8* %t114, i8** %l3
  %t115 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t116 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t115)
  store %ExpressionTokens %t116, %ExpressionTokens* %l0
  %t117 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t118 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t117)
  %t119 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t120 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  %t121 = load %Token, %Token* %l2
  %t122 = load i8*, i8** %l3
  br i1 %t118, label %then10, label %merge11
then10:
  %t123 = insertvalue %ObjectLiteralParseResult undef, %ExpressionTokens* null, 0
  %t124 = alloca [0 x %ObjectField*]
  %t125 = getelementptr [0 x %ObjectField*], [0 x %ObjectField*]* %t124, i32 0, i32 0
  %t126 = alloca { %ObjectField**, i64 }
  %t127 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t126, i32 0, i32 0
  store %ObjectField** %t125, %ObjectField*** %t127
  %t128 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t126, i32 0, i32 1
  store i64 0, i64* %t128
  %t129 = insertvalue %ObjectLiteralParseResult %t123, { %ObjectField**, i64 }* %t126, 1
  %t130 = insertvalue %ObjectLiteralParseResult %t129, i1 0, 2
  ret %ObjectLiteralParseResult %t130
merge11:
  %t131 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t132 = call %Token @expression_tokens_peek(%ExpressionTokens %t131)
  store %Token %t132, %Token* %l4
  %t134 = load %Token, %Token* %l4
  %t135 = extractvalue %Token %t134, 0
  %t136 = getelementptr inbounds %TokenKind, %TokenKind* %t135, i32 0, i32 0
  %t137 = load i32, i32* %t136
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
  %t164 = icmp ne i8* %t162, %s163
  br label %logical_or_entry_133

logical_or_entry_133:
  br i1 %t164, label %logical_or_merge_133, label %logical_or_right_133

logical_or_right_133:
  %t165 = load %Token, %Token* %l4
  %t166 = extractvalue %Token %t165, 0
  %t167 = getelementptr inbounds %TokenKind, %TokenKind* %t166, i32 0, i32 0
  %t168 = load i32, i32* %t167
  %t169 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t170 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t169)
  store %ExpressionTokens %t170, %ExpressionTokens* %l0
  %t171 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t172 = sitofp i64 0 to double
  %t173 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %t171, double %t172)
  store %ExpressionParseResult %t173, %ExpressionParseResult* %l5
  %t174 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  %t175 = extractvalue %ExpressionParseResult %t174, 2
  %t176 = xor i1 %t175, 1
  %t177 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t178 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  %t179 = load %Token, %Token* %l2
  %t180 = load i8*, i8** %l3
  %t181 = load %Token, %Token* %l4
  %t182 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  br i1 %t176, label %then12, label %merge13
then12:
  %t183 = insertvalue %ObjectLiteralParseResult undef, %ExpressionTokens* null, 0
  %t184 = alloca [0 x %ObjectField*]
  %t185 = getelementptr [0 x %ObjectField*], [0 x %ObjectField*]* %t184, i32 0, i32 0
  %t186 = alloca { %ObjectField**, i64 }
  %t187 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t186, i32 0, i32 0
  store %ObjectField** %t185, %ObjectField*** %t187
  %t188 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t186, i32 0, i32 1
  store i64 0, i64* %t188
  %t189 = insertvalue %ObjectLiteralParseResult %t183, { %ObjectField**, i64 }* %t186, 1
  %t190 = insertvalue %ObjectLiteralParseResult %t189, i1 0, 2
  ret %ObjectLiteralParseResult %t190
merge13:
  %t191 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  %t192 = extractvalue %ExpressionParseResult %t191, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t193 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  %t194 = load i8*, i8** %l3
  %t195 = insertvalue %ObjectField undef, i8* %t194, 0
  %t196 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  %t197 = extractvalue %ExpressionParseResult %t196, 1
  %t198 = insertvalue %ObjectField %t195, %Expression* %t197, 1
  %t199 = call { %ObjectField*, i64 }* @append_object_field({ %ObjectField*, i64 }* %t193, %ObjectField %t198)
  store { %ObjectField*, i64 }* %t199, { %ObjectField*, i64 }** %l1
  %t200 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t201 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t200)
  %t202 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t203 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  %t204 = load %Token, %Token* %l2
  %t205 = load i8*, i8** %l3
  %t206 = load %Token, %Token* %l4
  %t207 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  br i1 %t201, label %then14, label %merge15
then14:
  %t208 = insertvalue %ObjectLiteralParseResult undef, %ExpressionTokens* null, 0
  %t209 = alloca [0 x %ObjectField*]
  %t210 = getelementptr [0 x %ObjectField*], [0 x %ObjectField*]* %t209, i32 0, i32 0
  %t211 = alloca { %ObjectField**, i64 }
  %t212 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t211, i32 0, i32 0
  store %ObjectField** %t210, %ObjectField*** %t212
  %t213 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t211, i32 0, i32 1
  store i64 0, i64* %t213
  %t214 = insertvalue %ObjectLiteralParseResult %t208, { %ObjectField**, i64 }* %t211, 1
  %t215 = insertvalue %ObjectLiteralParseResult %t214, i1 0, 2
  ret %ObjectLiteralParseResult %t215
merge15:
  %t216 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t217 = call %Token @expression_tokens_peek(%ExpressionTokens %t216)
  store %Token %t217, %Token* %l6
  %t219 = load %Token, %Token* %l6
  %t220 = extractvalue %Token %t219, 0
  %t221 = getelementptr inbounds %TokenKind, %TokenKind* %t220, i32 0, i32 0
  %t222 = load i32, i32* %t221
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
  %t250 = load %Token, %Token* %l6
  %t251 = extractvalue %Token %t250, 0
  %t252 = getelementptr inbounds %TokenKind, %TokenKind* %t251, i32 0, i32 0
  %t253 = load i32, i32* %t252
  %t255 = load %Token, %Token* %l6
  %t256 = extractvalue %Token %t255, 0
  %t257 = getelementptr inbounds %TokenKind, %TokenKind* %t256, i32 0, i32 0
  %t258 = load i32, i32* %t257
  %t259 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t260 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t261 = icmp eq i32 %t258, 0
  %t262 = select i1 %t261, i8* %t260, i8* %t259
  %t263 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t264 = icmp eq i32 %t258, 1
  %t265 = select i1 %t264, i8* %t263, i8* %t262
  %t266 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t267 = icmp eq i32 %t258, 2
  %t268 = select i1 %t267, i8* %t266, i8* %t265
  %t269 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t270 = icmp eq i32 %t258, 3
  %t271 = select i1 %t270, i8* %t269, i8* %t268
  %t272 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t273 = icmp eq i32 %t258, 4
  %t274 = select i1 %t273, i8* %t272, i8* %t271
  %t275 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t276 = icmp eq i32 %t258, 5
  %t277 = select i1 %t276, i8* %t275, i8* %t274
  %t278 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t279 = icmp eq i32 %t258, 6
  %t280 = select i1 %t279, i8* %t278, i8* %t277
  %t281 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t282 = icmp eq i32 %t258, 7
  %t283 = select i1 %t282, i8* %t281, i8* %t280
  %s284 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.284, i32 0, i32 0
  %t285 = icmp eq i8* %t283, %s284
  br label %logical_and_entry_254

logical_and_entry_254:
  br i1 %t285, label %logical_and_right_254, label %logical_and_merge_254

logical_and_right_254:
  %t286 = load %Token, %Token* %l6
  %t287 = extractvalue %Token %t286, 0
  %t288 = getelementptr inbounds %TokenKind, %TokenKind* %t287, i32 0, i32 0
  %t289 = load i32, i32* %t288
  %t290 = insertvalue %ObjectLiteralParseResult undef, %ExpressionTokens* null, 0
  %t291 = alloca [0 x %ObjectField*]
  %t292 = getelementptr [0 x %ObjectField*], [0 x %ObjectField*]* %t291, i32 0, i32 0
  %t293 = alloca { %ObjectField**, i64 }
  %t294 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t293, i32 0, i32 0
  store %ObjectField** %t292, %ObjectField*** %t294
  %t295 = getelementptr { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t293, i32 0, i32 1
  store i64 0, i64* %t295
  %t296 = insertvalue %ObjectLiteralParseResult %t290, { %ObjectField**, i64 }* %t293, 1
  %t297 = insertvalue %ObjectLiteralParseResult %t296, i1 0, 2
  ret %ObjectLiteralParseResult %t297
loop.latch4:
  %t298 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t299 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  br label %loop.header2
afterloop5:
  %t302 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t303 = insertvalue %ObjectLiteralParseResult undef, %ExpressionTokens* null, 0
  %t304 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  %t305 = bitcast { %ObjectField*, i64 }* %t304 to { %ObjectField**, i64 }*
  %t306 = insertvalue %ObjectLiteralParseResult %t303, { %ObjectField**, i64 }* %t305, 1
  %t307 = insertvalue %ObjectLiteralParseResult %t306, i1 1, 2
  ret %ObjectLiteralParseResult %t307
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
  %t15 = insertvalue %ExpressionParseResult undef, %ExpressionTokens* %t14, 0
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
  %t30 = insertvalue %ExpressionParseResult %t15, %Expression* null, 1
  %t31 = insertvalue %ExpressionParseResult %t30, i1 1, 2
  ret %ExpressionParseResult %t31
}

define %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state) {
entry:
  %t0 = insertvalue %ExpressionParseResult undef, %ExpressionTokens* null, 0
  %t1 = alloca %Expression
  %t2 = getelementptr inbounds %Expression, %Expression* %t1, i32 0, i32 0
  store i32 15, i32* %t2
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  %t4 = getelementptr inbounds %Expression, %Expression* %t1, i32 0, i32 1
  %t5 = bitcast [8 x i8]* %t4 to i8*
  %t6 = bitcast i8* %t5 to i8**
  store i8* %s3, i8** %t6
  %t7 = load %Expression, %Expression* %t1
  %t8 = insertvalue %ExpressionParseResult %t0, %Expression* null, 1
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
  ret %Token zeroinitializer
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
  %t108 = bitcast i8* %t107 to %Expression**
  %t109 = load %Expression*, %Expression** %t108
  %t110 = icmp eq i32 %t104, 7
  %t111 = select i1 %t110, %Expression* %t109, %Expression* null
  %t112 = call i1 @expression_is_struct_target(%Expression zeroinitializer)
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
  %t124 = bitcast i8* %t123 to %Expression**
  %t125 = load %Expression*, %Expression** %t124
  %t126 = icmp eq i32 %t120, 7
  %t127 = select i1 %t126, %Expression* %t125, %Expression* null
  %t128 = call %StructTypeNameResult @collect_struct_type_name(%Expression zeroinitializer)
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
  %t17 = getelementptr i8, i8* %op, i64 0
  %t18 = load i8, i8* %t17
  %t19 = icmp eq i8 %t18, 60
  br label %logical_or_entry_16

logical_or_entry_16:
  br i1 %t19, label %logical_or_merge_16, label %logical_or_right_16

logical_or_right_16:
  %s21 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.21, i32 0, i32 0
  %t22 = icmp eq i8* %op, %s21
  br label %logical_or_entry_20

logical_or_entry_20:
  br i1 %t22, label %logical_or_merge_20, label %logical_or_right_20

logical_or_right_20:
  %t24 = getelementptr i8, i8* %op, i64 0
  %t25 = load i8, i8* %t24
  %t26 = icmp eq i8 %t25, 62
  br label %logical_or_entry_23

logical_or_entry_23:
  br i1 %t26, label %logical_or_merge_23, label %logical_or_right_23

logical_or_right_23:
  %s27 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.27, i32 0, i32 0
  %t28 = icmp eq i8* %op, %s27
  br label %logical_or_right_end_23

logical_or_right_end_23:
  br label %logical_or_merge_23

logical_or_merge_23:
  %t29 = phi i1 [ true, %logical_or_entry_23 ], [ %t28, %logical_or_right_end_23 ]
  br label %logical_or_right_end_20

logical_or_right_end_20:
  br label %logical_or_merge_20

logical_or_merge_20:
  %t30 = phi i1 [ true, %logical_or_entry_20 ], [ %t29, %logical_or_right_end_20 ]
  br label %logical_or_right_end_16

logical_or_right_end_16:
  br label %logical_or_merge_16

logical_or_merge_16:
  %t31 = phi i1 [ true, %logical_or_entry_16 ], [ %t30, %logical_or_right_end_16 ]
  br i1 %t31, label %then8, label %merge9
then8:
  %t32 = sitofp i64 4 to double
  ret double %t32
merge9:
  %t34 = getelementptr i8, i8* %op, i64 0
  %t35 = load i8, i8* %t34
  %t36 = icmp eq i8 %t35, 43
  br label %logical_or_entry_33

logical_or_entry_33:
  br i1 %t36, label %logical_or_merge_33, label %logical_or_right_33

logical_or_right_33:
  %t37 = getelementptr i8, i8* %op, i64 0
  %t38 = load i8, i8* %t37
  %t39 = icmp eq i8 %t38, 45
  br label %logical_or_right_end_33

logical_or_right_end_33:
  br label %logical_or_merge_33

logical_or_merge_33:
  %t40 = phi i1 [ true, %logical_or_entry_33 ], [ %t39, %logical_or_right_end_33 ]
  br i1 %t40, label %then10, label %merge11
then10:
  %t41 = sitofp i64 5 to double
  ret double %t41
merge11:
  %t43 = getelementptr i8, i8* %op, i64 0
  %t44 = load i8, i8* %t43
  %t45 = icmp eq i8 %t44, 42
  br label %logical_or_entry_42

logical_or_entry_42:
  br i1 %t45, label %logical_or_merge_42, label %logical_or_right_42

logical_or_right_42:
  %t47 = getelementptr i8, i8* %op, i64 0
  %t48 = load i8, i8* %t47
  %t49 = icmp eq i8 %t48, 47
  br label %logical_or_entry_46

logical_or_entry_46:
  br i1 %t49, label %logical_or_merge_46, label %logical_or_right_46

logical_or_right_46:
  %t50 = getelementptr i8, i8* %op, i64 0
  %t51 = load i8, i8* %t50
  %t52 = icmp eq i8 %t51, 37
  br label %logical_or_right_end_46

logical_or_right_end_46:
  br label %logical_or_merge_46

logical_or_merge_46:
  %t53 = phi i1 [ true, %logical_or_entry_46 ], [ %t52, %logical_or_right_end_46 ]
  br label %logical_or_right_end_42

logical_or_right_end_42:
  br label %logical_or_merge_42

logical_or_merge_42:
  %t54 = phi i1 [ true, %logical_or_entry_42 ], [ %t53, %logical_or_right_end_42 ]
  br i1 %t54, label %then12, label %merge13
then12:
  %t55 = sitofp i64 6 to double
  ret double %t55
merge13:
  %t56 = sitofp i64 -1 to double
  ret double %t56
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
  %t132 = phi { %Token*, i64 }* [ %t7, %entry ], [ %t130, %loop.latch2 ]
  %t133 = phi double [ %t6, %entry ], [ %t131, %loop.latch2 ]
  store { %Token*, i64 }* %t132, { %Token*, i64 }** %l1
  store double %t133, double* %l0
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
  %t26 = getelementptr inbounds %TokenKind, %TokenKind* %t25, i32 0, i32 0
  %t27 = load i32, i32* %t26
  %t28 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t29 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t27, 0
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t27, 1
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t27, 2
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t27, 3
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t27, 4
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t27, 5
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t27, 6
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %t50 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t27, 7
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %s53 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.53, i32 0, i32 0
  %t54 = icmp ne i8* %t52, %s53
  br label %logical_and_entry_23

logical_and_entry_23:
  br i1 %t54, label %logical_and_right_23, label %logical_and_merge_23

logical_and_right_23:
  %t56 = load %Token, %Token* %l2
  %t57 = extractvalue %Token %t56, 0
  %t58 = getelementptr inbounds %TokenKind, %TokenKind* %t57, i32 0, i32 0
  %t59 = load i32, i32* %t58
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
  %s85 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.85, i32 0, i32 0
  %t86 = icmp ne i8* %t84, %s85
  br label %logical_and_entry_55

logical_and_entry_55:
  br i1 %t86, label %logical_and_right_55, label %logical_and_merge_55

logical_and_right_55:
  %t87 = load %Token, %Token* %l2
  %t88 = extractvalue %Token %t87, 0
  %t89 = getelementptr inbounds %TokenKind, %TokenKind* %t88, i32 0, i32 0
  %t90 = load i32, i32* %t89
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
  %s116 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.116, i32 0, i32 0
  %t117 = icmp ne i8* %t115, %s116
  br label %logical_and_right_end_55

logical_and_right_end_55:
  br label %logical_and_merge_55

logical_and_merge_55:
  %t118 = phi i1 [ false, %logical_and_entry_55 ], [ %t117, %logical_and_right_end_55 ]
  br label %logical_and_right_end_23

logical_and_right_end_23:
  br label %logical_and_merge_23

logical_and_merge_23:
  %t119 = phi i1 [ false, %logical_and_entry_23 ], [ %t118, %logical_and_right_end_23 ]
  %t120 = load double, double* %l0
  %t121 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t122 = load %Token, %Token* %l2
  br i1 %t119, label %then6, label %merge7
then6:
  %t123 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t124 = load %Token, %Token* %l2
  %t125 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t123, %Token %t124)
  store { %Token*, i64 }* %t125, { %Token*, i64 }** %l1
  br label %merge7
merge7:
  %t126 = phi { %Token*, i64 }* [ %t125, %then6 ], [ %t121, %loop.body1 ]
  store { %Token*, i64 }* %t126, { %Token*, i64 }** %l1
  %t127 = load double, double* %l0
  %t128 = sitofp i64 1 to double
  %t129 = fadd double %t127, %t128
  store double %t129, double* %l0
  br label %loop.latch2
loop.latch2:
  %t130 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t131 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t134 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  ret { %Token*, i64 }* %t134
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
  %t2 = getelementptr inbounds %TokenKind, %TokenKind* %t1, i32 0, i32 0
  %t3 = load i32, i32* %t2
  %t4 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t5 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t6 = icmp eq i32 %t3, 0
  %t7 = select i1 %t6, i8* %t5, i8* %t4
  %t8 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t9 = icmp eq i32 %t3, 1
  %t10 = select i1 %t9, i8* %t8, i8* %t7
  %t11 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t12 = icmp eq i32 %t3, 2
  %t13 = select i1 %t12, i8* %t11, i8* %t10
  %t14 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t15 = icmp eq i32 %t3, 3
  %t16 = select i1 %t15, i8* %t14, i8* %t13
  %t17 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t3, 4
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t3, 5
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t3, 6
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t3, 7
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %s29 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.29, i32 0, i32 0
  %t30 = icmp eq i8* %t28, %s29
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t30, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t31 = extractvalue %Token %token, 0
  %t32 = getelementptr inbounds %TokenKind, %TokenKind* %t31, i32 0, i32 0
  %t33 = load i32, i32* %t32
  %t34 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t35 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t33, 0
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t33, 1
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t33, 2
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t33, 3
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t33, 4
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %t50 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t33, 5
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %t53 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t54 = icmp eq i32 %t33, 6
  %t55 = select i1 %t54, i8* %t53, i8* %t52
  %t56 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t57 = icmp eq i32 %t33, 7
  %t58 = select i1 %t57, i8* %t56, i8* %t55
  %s59 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.59, i32 0, i32 0
  %t60 = icmp eq i8* %t58, %s59
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t61 = phi i1 [ true, %logical_or_entry_0 ], [ %t60, %logical_or_right_end_0 ]
  br i1 %t61, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t62 = extractvalue %Token %token, 0
  %t63 = getelementptr inbounds %TokenKind, %TokenKind* %t62, i32 0, i32 0
  %t64 = load i32, i32* %t63
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
  %s90 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.90, i32 0, i32 0
  %t91 = icmp eq i8* %t89, %s90
  br i1 %t91, label %then2, label %merge3
then2:
  %t92 = extractvalue %Token %token, 1
  %t93 = call i1 @is_whitespace_lexeme(i8* %t92)
  br i1 %t93, label %then4, label %merge5
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
  %t88 = phi %Parser [ %t0, %entry ], [ %t87, %loop.latch2 ]
  store %Parser %t88, %Parser* %l0
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
  %t8 = getelementptr inbounds %TokenKind, %TokenKind* %t7, i32 0, i32 0
  %t9 = load i32, i32* %t8
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
  %s35 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.35, i32 0, i32 0
  %t36 = icmp eq i8* %t34, %s35
  br label %logical_and_entry_5

logical_and_entry_5:
  br i1 %t36, label %logical_and_right_5, label %logical_and_merge_5

logical_and_right_5:
  %t37 = load %Token, %Token* %l1
  %t38 = extractvalue %Token %t37, 0
  %t39 = getelementptr inbounds %TokenKind, %TokenKind* %t38, i32 0, i32 0
  %t40 = load i32, i32* %t39
  %t41 = load %Token, %Token* %l1
  %t42 = extractvalue %Token %t41, 0
  %t43 = getelementptr inbounds %TokenKind, %TokenKind* %t42, i32 0, i32 0
  %t44 = load i32, i32* %t43
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
  %s70 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.70, i32 0, i32 0
  %t71 = icmp eq i8* %t69, %s70
  %t72 = load %Parser, %Parser* %l0
  %t73 = load %Token, %Token* %l1
  br i1 %t71, label %then4, label %merge5
then4:
  %t74 = load %Parser, %Parser* %l0
  ret %Parser %t74
merge5:
  %t75 = load %Parser, %Parser* %l0
  %t76 = call %Parser @parser_advance_raw(%Parser %t75)
  store %Parser %t76, %Parser* %l2
  %t77 = load %Parser, %Parser* %l2
  %t78 = extractvalue %Parser %t77, 1
  %t79 = load %Parser, %Parser* %l0
  %t80 = extractvalue %Parser %t79, 1
  %t81 = fcmp oeq double %t78, %t80
  %t82 = load %Parser, %Parser* %l0
  %t83 = load %Token, %Token* %l1
  %t84 = load %Parser, %Parser* %l2
  br i1 %t81, label %then6, label %merge7
then6:
  %t85 = load %Parser, %Parser* %l0
  ret %Parser %t85
merge7:
  %t86 = load %Parser, %Parser* %l2
  store %Parser %t86, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t87 = load %Parser, %Parser* %l0
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
  %t90 = phi %Parser [ %t0, %entry ], [ %t89, %loop.latch2 ]
  store %Parser %t90, %Parser* %l0
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
  %t16 = getelementptr inbounds %TokenKind, %TokenKind* %t15, i32 0, i32 0
  %t17 = load i32, i32* %t16
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
  %t46 = load %Parser, %Parser* %l1
  %t47 = load %Token, %Token* %l2
  br i1 %t44, label %then6, label %merge7
then6:
  %t48 = load %Parser, %Parser* %l0
  ret %Parser %t48
merge7:
  %t49 = load %Token, %Token* %l2
  %t50 = extractvalue %Token %t49, 0
  %t51 = getelementptr inbounds %TokenKind, %TokenKind* %t50, i32 0, i32 0
  %t52 = load i32, i32* %t51
  %t53 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t54 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t55 = icmp eq i32 %t52, 0
  %t56 = select i1 %t55, i8* %t54, i8* %t53
  %t57 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t58 = icmp eq i32 %t52, 1
  %t59 = select i1 %t58, i8* %t57, i8* %t56
  %t60 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t61 = icmp eq i32 %t52, 2
  %t62 = select i1 %t61, i8* %t60, i8* %t59
  %t63 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t52, 3
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t52, 4
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t52, 5
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t52, 6
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t52, 7
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %s78 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.78, i32 0, i32 0
  %t79 = icmp eq i8* %t77, %s78
  %t80 = load %Parser, %Parser* %l0
  %t81 = load %Parser, %Parser* %l1
  %t82 = load %Token, %Token* %l2
  br i1 %t79, label %then8, label %merge9
then8:
  %t83 = load %Token, %Token* %l2
  %t84 = extractvalue %Token %t83, 0
  %t85 = getelementptr inbounds %TokenKind, %TokenKind* %t84, i32 0, i32 0
  %t86 = load i32, i32* %t85
  store double 0.0, double* %l3
  %t87 = load double, double* %l3
  %t88 = load double, double* %l3
  br label %merge9
merge9:
  br label %loop.latch2
loop.latch2:
  %t89 = load %Parser, %Parser* %l0
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
  %t90 = phi %Parser [ %t0, %entry ], [ %t89, %loop.latch2 ]
  store %Parser %t90, %Parser* %l0
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
  %t16 = getelementptr inbounds %TokenKind, %TokenKind* %t15, i32 0, i32 0
  %t17 = load i32, i32* %t16
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
  %t46 = load %Parser, %Parser* %l1
  %t47 = load %Token, %Token* %l2
  br i1 %t44, label %then6, label %merge7
then6:
  %t48 = load %Parser, %Parser* %l0
  ret %Parser %t48
merge7:
  %t49 = load %Token, %Token* %l2
  %t50 = extractvalue %Token %t49, 0
  %t51 = getelementptr inbounds %TokenKind, %TokenKind* %t50, i32 0, i32 0
  %t52 = load i32, i32* %t51
  %t53 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t54 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t55 = icmp eq i32 %t52, 0
  %t56 = select i1 %t55, i8* %t54, i8* %t53
  %t57 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t58 = icmp eq i32 %t52, 1
  %t59 = select i1 %t58, i8* %t57, i8* %t56
  %t60 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t61 = icmp eq i32 %t52, 2
  %t62 = select i1 %t61, i8* %t60, i8* %t59
  %t63 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t52, 3
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t52, 4
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t52, 5
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t52, 6
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t52, 7
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %s78 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.78, i32 0, i32 0
  %t79 = icmp eq i8* %t77, %s78
  %t80 = load %Parser, %Parser* %l0
  %t81 = load %Parser, %Parser* %l1
  %t82 = load %Token, %Token* %l2
  br i1 %t79, label %then8, label %merge9
then8:
  %t83 = load %Token, %Token* %l2
  %t84 = extractvalue %Token %t83, 0
  %t85 = getelementptr inbounds %TokenKind, %TokenKind* %t84, i32 0, i32 0
  %t86 = load i32, i32* %t85
  store double 0.0, double* %l3
  %t87 = load double, double* %l3
  %t88 = load double, double* %l3
  br label %merge9
merge9:
  br label %loop.latch2
loop.latch2:
  %t89 = load %Parser, %Parser* %l0
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
  %t3 = call double @char_code(double %t2)
  store double %t3, double* %l0
  %t4 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t5 = sub i64 %t4, 1
  %t6 = call double @char_at(i8* %text, i64 %t5)
  %t7 = call double @char_code(double %t6)
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
  %t7 = call double @char_code(double %t6)
  store double %t7, double* %l1
  %t8 = load i8*, i8** %l0
  %t9 = load i8*, i8** %l0
  %t10 = call i64 @sailfin_runtime_string_length(i8* %t9)
  %t11 = sub i64 %t10, 1
  %t12 = call double @char_at(i8* %t8, i64 %t11)
  %t13 = call double @char_code(double %t12)
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
  %t93 = phi i8* [ %t12, %entry ], [ %t91, %loop.latch2 ]
  %t94 = phi double [ %t17, %entry ], [ %t92, %loop.latch2 ]
  store i8* %t93, i8** %l1
  store double %t94, double* %l6
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
  %t40 = getelementptr inbounds %TokenKind, %TokenKind* %t39, i32 0, i32 0
  %t41 = load i32, i32* %t40
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
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load i8*, i8** %l1
  %t71 = load double, double* %l2
  %t72 = load double, double* %l3
  %t73 = load double, double* %l4
  %t74 = load double, double* %l5
  %t75 = load double, double* %l6
  %t76 = load %Token, %Token* %l7
  br i1 %t68, label %then6, label %merge7
then6:
  %t77 = load %Token, %Token* %l7
  %t78 = extractvalue %Token %t77, 0
  %t79 = getelementptr inbounds %TokenKind, %TokenKind* %t78, i32 0, i32 0
  %t80 = load i32, i32* %t79
  store double 0.0, double* %l8
  %t81 = load double, double* %l8
  %t83 = load double, double* %l8
  br label %merge7
merge7:
  %t84 = load i8*, i8** %l1
  %t85 = load %Token, %Token* %l7
  %t86 = extractvalue %Token %t85, 1
  %t87 = add i8* %t84, %t86
  store i8* %t87, i8** %l1
  %t88 = load double, double* %l6
  %t89 = sitofp i64 1 to double
  %t90 = fadd double %t88, %t89
  store double %t90, double* %l6
  br label %loop.latch2
loop.latch2:
  %t91 = load i8*, i8** %l1
  %t92 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t95 = load i8*, i8** %l1
  %t96 = call i8* @trim_text(i8* %t95)
  store i8* %t96, i8** %l9
  %t97 = load i8*, i8** %l9
  %t98 = call i64 @sailfin_runtime_string_length(i8* %t97)
  %t99 = icmp sgt i64 %t98, 0
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t101 = load i8*, i8** %l1
  %t102 = load double, double* %l2
  %t103 = load double, double* %l3
  %t104 = load double, double* %l4
  %t105 = load double, double* %l5
  %t106 = load double, double* %l6
  %t107 = load i8*, i8** %l9
  br i1 %t99, label %then8, label %merge9
then8:
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t109 = load i8*, i8** %l9
  %t110 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t108, i8* %t109)
  store { i8**, i64 }* %t110, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t111 = phi { i8**, i64 }* [ %t110, %then8 ], [ %t100, %entry ]
  store { i8**, i64 }* %t111, { i8**, i64 }** %l0
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t112
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
  %t96 = phi { %Token*, i64 }* [ %t16, %entry ], [ %t94, %loop.latch2 ]
  %t97 = phi double [ %t21, %entry ], [ %t95, %loop.latch2 ]
  store { %Token*, i64 }* %t96, { %Token*, i64 }** %l1
  store double %t97, double* %l6
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
  %t44 = getelementptr inbounds %TokenKind, %TokenKind* %t43, i32 0, i32 0
  %t45 = load i32, i32* %t44
  %t46 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t47 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t45, 0
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %t50 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t45, 1
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %t53 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t54 = icmp eq i32 %t45, 2
  %t55 = select i1 %t54, i8* %t53, i8* %t52
  %t56 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t57 = icmp eq i32 %t45, 3
  %t58 = select i1 %t57, i8* %t56, i8* %t55
  %t59 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t60 = icmp eq i32 %t45, 4
  %t61 = select i1 %t60, i8* %t59, i8* %t58
  %t62 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t45, 5
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t45, 6
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t45, 7
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %s71 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.71, i32 0, i32 0
  %t72 = icmp eq i8* %t70, %s71
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t75 = load double, double* %l2
  %t76 = load double, double* %l3
  %t77 = load double, double* %l4
  %t78 = load double, double* %l5
  %t79 = load double, double* %l6
  %t80 = load %Token, %Token* %l7
  br i1 %t72, label %then6, label %merge7
then6:
  %t81 = load %Token, %Token* %l7
  %t82 = extractvalue %Token %t81, 0
  %t83 = getelementptr inbounds %TokenKind, %TokenKind* %t82, i32 0, i32 0
  %t84 = load i32, i32* %t83
  store double 0.0, double* %l8
  %t85 = load double, double* %l8
  %t87 = load double, double* %l8
  br label %merge7
merge7:
  %t88 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t89 = load %Token, %Token* %l7
  %t90 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t88, %Token %t89)
  store { %Token*, i64 }* %t90, { %Token*, i64 }** %l1
  %t91 = load double, double* %l6
  %t92 = sitofp i64 1 to double
  %t93 = fadd double %t91, %t92
  store double %t93, double* %l6
  br label %loop.latch2
loop.latch2:
  %t94 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t95 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t98 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t99 = load { %Token*, i64 }, { %Token*, i64 }* %t98
  %t100 = extractvalue { %Token*, i64 } %t99, 1
  %t101 = icmp sgt i64 %t100, 0
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t103 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t104 = load double, double* %l2
  %t105 = load double, double* %l3
  %t106 = load double, double* %l4
  %t107 = load double, double* %l5
  %t108 = load double, double* %l6
  br i1 %t101, label %then8, label %merge9
then8:
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t110 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t111 = call { i8**, i64 }* @append_token_array({ i8**, i64 }* %t109, { %Token*, i64 }* %t110)
  store { i8**, i64 }* %t111, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t112 = phi { i8**, i64 }* [ %t111, %then8 ], [ %t102, %entry ]
  store { i8**, i64 }* %t112, { i8**, i64 }** %l0
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t113
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
  %t76 = phi double [ %t9, %entry ], [ %t75, %loop.latch2 ]
  store double %t76, double* %l4
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
  %t30 = getelementptr inbounds %TokenKind, %TokenKind* %t29, i32 0, i32 0
  %t31 = load i32, i32* %t30
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
  %s57 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.57, i32 0, i32 0
  %t58 = icmp eq i8* %t56, %s57
  %t59 = load double, double* %l0
  %t60 = load double, double* %l1
  %t61 = load double, double* %l2
  %t62 = load double, double* %l3
  %t63 = load double, double* %l4
  %t64 = load %Token, %Token* %l5
  br i1 %t58, label %then6, label %merge7
then6:
  %t65 = load %Token, %Token* %l5
  %t66 = extractvalue %Token %t65, 0
  %t67 = getelementptr inbounds %TokenKind, %TokenKind* %t66, i32 0, i32 0
  %t68 = load i32, i32* %t67
  store double 0.0, double* %l6
  %t69 = load double, double* %l6
  %t71 = load double, double* %l6
  br label %merge7
merge7:
  %t72 = load double, double* %l4
  %t73 = sitofp i64 1 to double
  %t74 = fadd double %t72, %t73
  store double %t74, double* %l4
  br label %loop.latch2
loop.latch2:
  %t75 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t77 = sitofp i64 -1 to double
  ret double %t77
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
  %t144 = phi double [ %t9, %entry ], [ %t143, %loop.latch2 ]
  store double %t144, double* %l4
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
  %t30 = getelementptr inbounds %TokenKind, %TokenKind* %t29, i32 0, i32 0
  %t31 = load i32, i32* %t30
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
  %s57 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.57, i32 0, i32 0
  %t58 = icmp eq i8* %t56, %s57
  %t59 = load double, double* %l0
  %t60 = load double, double* %l1
  %t61 = load double, double* %l2
  %t62 = load double, double* %l3
  %t63 = load double, double* %l4
  %t64 = load %Token, %Token* %l5
  br i1 %t58, label %then6, label %merge7
then6:
  %t65 = load %Token, %Token* %l5
  %t66 = extractvalue %Token %t65, 0
  %t67 = getelementptr inbounds %TokenKind, %TokenKind* %t66, i32 0, i32 0
  %t68 = load i32, i32* %t67
  store double 0.0, double* %l6
  %t69 = load double, double* %l6
  br label %merge7
merge7:
  %t70 = load %Token, %Token* %l5
  %t71 = extractvalue %Token %t70, 0
  %t72 = getelementptr inbounds %TokenKind, %TokenKind* %t71, i32 0, i32 0
  %t73 = load i32, i32* %t72
  %t74 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t75 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t73, 0
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t73, 1
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %t81 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t73, 2
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t73, 3
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %t87 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t88 = icmp eq i32 %t73, 4
  %t89 = select i1 %t88, i8* %t87, i8* %t86
  %t90 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t91 = icmp eq i32 %t73, 5
  %t92 = select i1 %t91, i8* %t90, i8* %t89
  %t93 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t73, 6
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %t96 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t97 = icmp eq i32 %t73, 7
  %t98 = select i1 %t97, i8* %t96, i8* %t95
  %s99 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.99, i32 0, i32 0
  %t100 = icmp eq i8* %t98, %s99
  %t101 = load double, double* %l0
  %t102 = load double, double* %l1
  %t103 = load double, double* %l2
  %t104 = load double, double* %l3
  %t105 = load double, double* %l4
  %t106 = load %Token, %Token* %l5
  br i1 %t100, label %then8, label %merge9
then8:
  %t107 = load %Token, %Token* %l5
  %t108 = call i1 @identifier_matches(%Token %t107, i8* %keyword)
  %t109 = load double, double* %l0
  %t110 = load double, double* %l1
  %t111 = load double, double* %l2
  %t112 = load double, double* %l3
  %t113 = load double, double* %l4
  %t114 = load %Token, %Token* %l5
  br i1 %t108, label %then10, label %merge11
then10:
  %t116 = load double, double* %l0
  %t117 = sitofp i64 0 to double
  %t118 = fcmp oeq double %t116, %t117
  br label %logical_and_entry_115

logical_and_entry_115:
  br i1 %t118, label %logical_and_right_115, label %logical_and_merge_115

logical_and_right_115:
  %t120 = load double, double* %l1
  %t121 = sitofp i64 0 to double
  %t122 = fcmp oeq double %t120, %t121
  br label %logical_and_entry_119

logical_and_entry_119:
  br i1 %t122, label %logical_and_right_119, label %logical_and_merge_119

logical_and_right_119:
  %t124 = load double, double* %l2
  %t125 = sitofp i64 0 to double
  %t126 = fcmp oeq double %t124, %t125
  br label %logical_and_entry_123

logical_and_entry_123:
  br i1 %t126, label %logical_and_right_123, label %logical_and_merge_123

logical_and_right_123:
  %t127 = load double, double* %l3
  %t128 = sitofp i64 0 to double
  %t129 = fcmp oeq double %t127, %t128
  br label %logical_and_right_end_123

logical_and_right_end_123:
  br label %logical_and_merge_123

logical_and_merge_123:
  %t130 = phi i1 [ false, %logical_and_entry_123 ], [ %t129, %logical_and_right_end_123 ]
  br label %logical_and_right_end_119

logical_and_right_end_119:
  br label %logical_and_merge_119

logical_and_merge_119:
  %t131 = phi i1 [ false, %logical_and_entry_119 ], [ %t130, %logical_and_right_end_119 ]
  br label %logical_and_right_end_115

logical_and_right_end_115:
  br label %logical_and_merge_115

logical_and_merge_115:
  %t132 = phi i1 [ false, %logical_and_entry_115 ], [ %t131, %logical_and_right_end_115 ]
  %t133 = load double, double* %l0
  %t134 = load double, double* %l1
  %t135 = load double, double* %l2
  %t136 = load double, double* %l3
  %t137 = load double, double* %l4
  %t138 = load %Token, %Token* %l5
  br i1 %t132, label %then12, label %merge13
then12:
  %t139 = load double, double* %l4
  ret double %t139
merge13:
  br label %merge11
merge11:
  br label %merge9
merge9:
  %t140 = load double, double* %l4
  %t141 = sitofp i64 1 to double
  %t142 = fadd double %t140, %t141
  store double %t142, double* %l4
  br label %loop.latch2
loop.latch2:
  %t143 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t145 = sitofp i64 -1 to double
  ret double %t145
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
