; ModuleID = 'sailfin'
source_filename = "sailfin"

%Parser = type { { i8**, i64 }*, double }
%StatementParseResult = type { i8*, i8* }
%ParameterParseResult = type { i8*, i8* }
%ParameterListParseResult = type { i8*, { i8**, i64 }* }
%StructFieldParseResult = type { i8*, i8*, i1 }
%ModelPropertyParseResult = type { i8*, i8*, i1 }
%MethodParseResult = type { i8*, i8*, i1 }
%InterfaceMemberParseResult = type { i8*, i8*, i1 }
%SpecifierListParseResult = type { i8*, { i8**, i64 }* }
%NamedSpecifier = type { i8*, i8* }
%EnumVariantParseResult = type { i8*, i8*, i1 }
%TypeParameterParseResult = type { i8*, { i8**, i64 }* }
%ImplementsParseResult = type { i8*, { i8**, i64 }*, i1 }
%DecoratorParseResult = type { i8*, { i8**, i64 }* }
%BlockStatementParseResult = type { i8*, i8*, i1 }
%ParenthesizedParseResult = type { i8*, { i8**, i64 }*, i1 }
%MatchCasesParseResult = type { i8*, { i8**, i64 }*, i1 }
%MatchCaseParseResult = type { i8*, i8*, i1 }
%MatchCaseTokenSplit = type { { i8**, i64 }*, { i8**, i64 }*, i1 }
%ExpressionTokens = type { { i8**, i64 }*, double }
%ExpressionParseResult = type { i8*, i8*, i1 }
%LambdaParameterParseResult = type { i8*, i8*, i1 }
%LambdaParameterListParseResult = type { i8*, { i8**, i64 }*, i1 }
%ExpressionCollectResult = type { i8*, { i8**, i64 }*, i1 }
%ExpressionBlockParseResult = type { i8*, { i8**, i64 }*, i1 }
%CallArgumentsParseResult = type { i8*, { i8**, i64 }*, i1 }
%ArrayLiteralParseResult = type { i8*, { i8**, i64 }*, i1 }
%ObjectLiteralParseResult = type { i8*, { i8**, i64 }*, i1 }
%StructTypeNameResult = type { { i8**, i64 }*, i1 }
%CaptureResult = type { i8*, { i8**, i64 }* }
%EffectParseResult = type { i8*, { i8**, i64 }* }
%BlockParseResult = type { i8*, i8* }
%PatternCaptureResult = type { i8*, { i8**, i64 }*, i1 }
%LexerState = type { i8*, double, double, double }
%Token = type { i8*, i8*, double, double }
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
%DecoratorArgumentInfo = type { i8*, i8* }
%DecoratorInfo = type { i8*, { i8**, i64 }* }

%TokenKind = type { i32, [8 x i8] }
%Expression = type { i32, [24 x i8] }
%Statement = type { i32, [56 x i8] }
%LiteralValue = type { i32, [8 x i8] }

declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i1 @sailfin_runtime_is_decimal_digit(i8)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)

declare noalias i8* @malloc(i64)

@.str.45 = private unnamed_addr constant [3 x i8] c"fn\00"
@.str.41 = private unnamed_addr constant [3 x i8] c"fn\00"
@.str.16 = private unnamed_addr constant [11 x i8] c"implements\00"
@.str.13 = private unnamed_addr constant [4 x i8] c"for\00"
@.str.44 = private unnamed_addr constant [3 x i8] c"in\00"
@.str.15 = private unnamed_addr constant [7 x i8] c"prompt\00"
@.str.21 = private unnamed_addr constant [1 x i8] c"\00"
@.str.22 = private unnamed_addr constant [7 x i8] c"return\00"
@.str.20 = private unnamed_addr constant [3 x i8] c"if\00"
@.str.81 = private unnamed_addr constant [1 x i8] c"\00"
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
  %t0 = bitcast { %Token*, i64 }* %tokens to { i8**, i64 }*
  %t1 = insertvalue %Parser undef, { i8**, i64 }* %t0, 0
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
  %t29 = phi %Parser [ %t11, %entry ], [ %t27, %loop.latch2 ]
  %t30 = phi { %Statement*, i64 }* [ %t12, %entry ], [ %t28, %loop.latch2 ]
  store %Parser %t29, %Parser* %l0
  store { %Statement*, i64 }* %t30, { %Statement*, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t13 = load %Parser, %Parser* %l0
  %t14 = call %Token @parser_peek_raw(%Parser %t13)
  store %Token %t14, %Token* %l2
  %t15 = load %Token, %Token* %l2
  %t16 = extractvalue %Token %t15, 0
  %t17 = load %Parser, %Parser* %l0
  %t18 = call %StatementParseResult @parse_statement(%Parser %t17)
  store %StatementParseResult %t18, %StatementParseResult* %l3
  %t19 = load %StatementParseResult, %StatementParseResult* %l3
  %t20 = extractvalue %StatementParseResult %t19, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t21 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  %t22 = load %StatementParseResult, %StatementParseResult* %l3
  %t23 = extractvalue %StatementParseResult %t22, 1
  %t24 = call { %Statement*, i64 }* @append_statement({ %Statement*, i64 }* %t21, %Statement zeroinitializer)
  store { %Statement*, i64 }* %t24, { %Statement*, i64 }** %l1
  %t25 = load %Parser, %Parser* %l0
  %t26 = call %Parser @skip_trivia(%Parser %t25)
  store %Parser %t26, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t27 = load %Parser, %Parser* %l0
  %t28 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t31 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  %t32 = bitcast { %Statement*, i64 }* %t31 to { i8**, i64 }*
  %t33 = insertvalue %Program undef, { i8**, i64 }* %t32, 0
  ret %Program %t33
}

define %StatementParseResult @parse_statement(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %DecoratorParseResult
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca %Token
  %l4 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %DecoratorParseResult @parse_decorators(%Parser %parser)
  store %DecoratorParseResult %t0, %DecoratorParseResult* %l1
  %t1 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t2 = extractvalue %DecoratorParseResult %t1, 1
  store { i8**, i64 }* %t2, { i8**, i64 }** %l2
  %t3 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t3, %Token* %l3
  %t4 = load %Token, %Token* %l3
  %s5 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.5, i32 0, i32 0
  %t6 = call i1 @identifier_matches(%Token %t4, i8* %s5)
  %t7 = load %Parser, %Parser* %l0
  %t8 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t10 = load %Token, %Token* %l3
  br i1 %t6, label %then0, label %merge1
then0:
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t12 = load { i8**, i64 }, { i8**, i64 }* %t11
  %t13 = extractvalue { i8**, i64 } %t12, 1
  %t14 = icmp sgt i64 %t13, 0
  %t15 = load %Parser, %Parser* %l0
  %t16 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t18 = load %Token, %Token* %l3
  br i1 %t14, label %then2, label %merge3
then2:
  %t19 = load %Parser, %Parser* %l0
  %t20 = call %StatementParseResult @parse_unknown(%Parser %t19)
  ret %StatementParseResult %t20
merge3:
  %t21 = call %StatementParseResult @parse_import(%Parser %parser)
  ret %StatementParseResult %t21
merge1:
  %t22 = load %Token, %Token* %l3
  %s23 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.23, i32 0, i32 0
  %t24 = call i1 @identifier_matches(%Token %t22, i8* %s23)
  %t25 = load %Parser, %Parser* %l0
  %t26 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t28 = load %Token, %Token* %l3
  br i1 %t24, label %then4, label %merge5
then4:
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t30 = load { i8**, i64 }, { i8**, i64 }* %t29
  %t31 = extractvalue { i8**, i64 } %t30, 1
  %t32 = icmp sgt i64 %t31, 0
  %t33 = load %Parser, %Parser* %l0
  %t34 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t36 = load %Token, %Token* %l3
  br i1 %t32, label %then6, label %merge7
then6:
  %t37 = load %Parser, %Parser* %l0
  %t38 = call %StatementParseResult @parse_unknown(%Parser %t37)
  ret %StatementParseResult %t38
merge7:
  %t39 = call %StatementParseResult @parse_variable(%Parser %parser)
  ret %StatementParseResult %t39
merge5:
  %t40 = load %Token, %Token* %l3
  %s41 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.41, i32 0, i32 0
  %t42 = call i1 @identifier_matches(%Token %t40, i8* %s41)
  %t43 = load %Parser, %Parser* %l0
  %t44 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t46 = load %Token, %Token* %l3
  br i1 %t42, label %then8, label %merge9
then8:
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t48 = load { i8**, i64 }, { i8**, i64 }* %t47
  %t49 = extractvalue { i8**, i64 } %t48, 1
  %t50 = icmp sgt i64 %t49, 0
  %t51 = load %Parser, %Parser* %l0
  %t52 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t54 = load %Token, %Token* %l3
  br i1 %t50, label %then10, label %merge11
then10:
  %t55 = load %Parser, %Parser* %l0
  %t56 = call %StatementParseResult @parse_unknown(%Parser %t55)
  ret %StatementParseResult %t56
merge11:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t58 = bitcast { i8**, i64 }* %t57 to { %Decorator*, i64 }*
  %t59 = call %StatementParseResult @parse_model(%Parser %parser, { %Decorator*, i64 }* %t58)
  ret %StatementParseResult %t59
merge9:
  %t60 = load %Token, %Token* %l3
  %s61 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.61, i32 0, i32 0
  %t62 = call i1 @identifier_matches(%Token %t60, i8* %s61)
  %t63 = load %Parser, %Parser* %l0
  %t64 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t66 = load %Token, %Token* %l3
  br i1 %t62, label %then12, label %merge13
then12:
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t68 = load { i8**, i64 }, { i8**, i64 }* %t67
  %t69 = extractvalue { i8**, i64 } %t68, 1
  %t70 = icmp sgt i64 %t69, 0
  %t71 = load %Parser, %Parser* %l0
  %t72 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t74 = load %Token, %Token* %l3
  br i1 %t70, label %then14, label %merge15
then14:
  %t75 = load %Parser, %Parser* %l0
  %t76 = call %StatementParseResult @parse_unknown(%Parser %t75)
  ret %StatementParseResult %t76
merge15:
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t78 = bitcast { i8**, i64 }* %t77 to { %Decorator*, i64 }*
  %t79 = call %StatementParseResult @parse_pipeline(%Parser %parser, { %Decorator*, i64 }* %t78)
  ret %StatementParseResult %t79
merge13:
  %t80 = load %Token, %Token* %l3
  %s81 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.81, i32 0, i32 0
  %t82 = call i1 @identifier_matches(%Token %t80, i8* %s81)
  %t83 = load %Parser, %Parser* %l0
  %t84 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t86 = load %Token, %Token* %l3
  br i1 %t82, label %then16, label %merge17
then16:
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t88 = load { i8**, i64 }, { i8**, i64 }* %t87
  %t89 = extractvalue { i8**, i64 } %t88, 1
  %t90 = icmp sgt i64 %t89, 0
  %t91 = load %Parser, %Parser* %l0
  %t92 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t94 = load %Token, %Token* %l3
  br i1 %t90, label %then18, label %merge19
then18:
  %t95 = load %Parser, %Parser* %l0
  %t96 = call %StatementParseResult @parse_unknown(%Parser %t95)
  ret %StatementParseResult %t96
merge19:
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t98 = bitcast { i8**, i64 }* %t97 to { %Decorator*, i64 }*
  %t99 = call %StatementParseResult @parse_tool(%Parser %parser, { %Decorator*, i64 }* %t98)
  ret %StatementParseResult %t99
merge17:
  %t100 = load %Token, %Token* %l3
  %s101 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.101, i32 0, i32 0
  %t102 = call i1 @identifier_matches(%Token %t100, i8* %s101)
  %t103 = load %Parser, %Parser* %l0
  %t104 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t106 = load %Token, %Token* %l3
  br i1 %t102, label %then20, label %merge21
then20:
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t108 = load { i8**, i64 }, { i8**, i64 }* %t107
  %t109 = extractvalue { i8**, i64 } %t108, 1
  %t110 = icmp sgt i64 %t109, 0
  %t111 = load %Parser, %Parser* %l0
  %t112 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t114 = load %Token, %Token* %l3
  br i1 %t110, label %then22, label %merge23
then22:
  %t115 = load %Parser, %Parser* %l0
  %t116 = call %StatementParseResult @parse_unknown(%Parser %t115)
  ret %StatementParseResult %t116
merge23:
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t118 = bitcast { i8**, i64 }* %t117 to { %Decorator*, i64 }*
  %t119 = call %StatementParseResult @parse_test(%Parser %parser, { %Decorator*, i64 }* %t118)
  ret %StatementParseResult %t119
merge21:
  %t120 = load %Token, %Token* %l3
  %s121 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.121, i32 0, i32 0
  %t122 = call i1 @identifier_matches(%Token %t120, i8* %s121)
  %t123 = load %Parser, %Parser* %l0
  %t124 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t126 = load %Token, %Token* %l3
  br i1 %t122, label %then24, label %merge25
then24:
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t128 = bitcast { i8**, i64 }* %t127 to { %Decorator*, i64 }*
  %t129 = call %StatementParseResult @parse_function(%Parser %parser, i1 0, { %Decorator*, i64 }* %t128)
  ret %StatementParseResult %t129
merge25:
  %t130 = load %Token, %Token* %l3
  %s131 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.131, i32 0, i32 0
  %t132 = call i1 @identifier_matches(%Token %t130, i8* %s131)
  %t133 = load %Parser, %Parser* %l0
  %t134 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t136 = load %Token, %Token* %l3
  br i1 %t132, label %then26, label %merge27
then26:
  %t137 = load %Token, %Token* %l3
  %s138 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.138, i32 0, i32 0
  %t139 = call i1 @identifier_matches(%Token %t137, i8* %s138)
  %t140 = load %Parser, %Parser* %l0
  %t141 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t143 = load %Token, %Token* %l3
  br i1 %t139, label %then28, label %merge29
then28:
  br label %merge29
merge29:
  %t144 = load %Token, %Token* %l3
  %s145 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.145, i32 0, i32 0
  %t146 = call i1 @identifier_matches(%Token %t144, i8* %s145)
  %t147 = load %Parser, %Parser* %l0
  %t148 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t150 = load %Token, %Token* %l3
  br i1 %t146, label %then30, label %merge31
then30:
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t152 = load { i8**, i64 }, { i8**, i64 }* %t151
  %t153 = extractvalue { i8**, i64 } %t152, 1
  %t154 = icmp sgt i64 %t153, 0
  %t155 = load %Parser, %Parser* %l0
  %t156 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t158 = load %Token, %Token* %l3
  br i1 %t154, label %then32, label %merge33
then32:
  %t159 = load %Parser, %Parser* %l0
  %t160 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t161 = insertvalue %BlockStatementParseResult %t160, i8* null, 1
  %t162 = insertvalue %BlockStatementParseResult %t161, i1 0, 2
  ret %StatementParseResult zeroinitializer
merge33:
  ret %StatementParseResult zeroinitializer
merge31:
  %t163 = load %Token, %Token* %l3
  %s164 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.164, i32 0, i32 0
  %t165 = call i1 @identifier_matches(%Token %t163, i8* %s164)
  %t166 = load %Parser, %Parser* %l0
  %t167 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t169 = load %Token, %Token* %l3
  br i1 %t165, label %then34, label %merge35
then34:
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t171 = load { i8**, i64 }, { i8**, i64 }* %t170
  %t172 = extractvalue { i8**, i64 } %t171, 1
  %t173 = icmp sgt i64 %t172, 0
  %t174 = load %Parser, %Parser* %l0
  %t175 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t177 = load %Token, %Token* %l3
  br i1 %t173, label %then36, label %merge37
then36:
  %t178 = load %Parser, %Parser* %l0
  %t179 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t180 = insertvalue %BlockStatementParseResult %t179, i8* null, 1
  %t181 = insertvalue %BlockStatementParseResult %t180, i1 0, 2
  ret %StatementParseResult zeroinitializer
merge37:
  ret %StatementParseResult zeroinitializer
merge35:
  store double 0.0, double* %l4
  %t182 = load double, double* %l4
  %s183 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.183, i32 0, i32 0
  %t184 = call i1 @identifier_matches(%Token zeroinitializer, i8* %s183)
  %t185 = load %Parser, %Parser* %l0
  %t186 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t188 = load %Token, %Token* %l3
  %t189 = load double, double* %l4
  br i1 %t184, label %then38, label %merge39
then38:
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t191 = bitcast { i8**, i64 }* %t190 to { %Decorator*, i64 }*
  %t192 = call %StatementParseResult @parse_function(%Parser %parser, i1 1, { %Decorator*, i64 }* %t191)
  ret %StatementParseResult %t192
merge39:
  br label %merge27
merge27:
  %t193 = load %Token, %Token* %l3
  %s194 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.194, i32 0, i32 0
  %t195 = call i1 @identifier_matches(%Token %t193, i8* %s194)
  %t196 = load %Parser, %Parser* %l0
  %t197 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t199 = load %Token, %Token* %l3
  br i1 %t195, label %then40, label %merge41
then40:
  %t200 = call %StatementParseResult @parse_import(%Parser %parser)
  ret %StatementParseResult %t200
merge41:
  %t201 = load %Token, %Token* %l3
  %s202 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.202, i32 0, i32 0
  %t203 = call i1 @identifier_matches(%Token %t201, i8* %s202)
  %t204 = load %Parser, %Parser* %l0
  %t205 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t207 = load %Token, %Token* %l3
  br i1 %t203, label %then42, label %merge43
then42:
  %t208 = call %StatementParseResult @parse_export(%Parser %parser)
  ret %StatementParseResult %t208
merge43:
  %t209 = load %Token, %Token* %l3
  %s210 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.210, i32 0, i32 0
  %t211 = call i1 @identifier_matches(%Token %t209, i8* %s210)
  %t212 = load %Parser, %Parser* %l0
  %t213 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t215 = load %Token, %Token* %l3
  br i1 %t211, label %then44, label %merge45
then44:
  %t216 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t217 = bitcast { i8**, i64 }* %t216 to { %Decorator*, i64 }*
  %t218 = call %StatementParseResult @parse_struct(%Parser %parser, { %Decorator*, i64 }* %t217)
  ret %StatementParseResult %t218
merge45:
  %t219 = load %Token, %Token* %l3
  %s220 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.220, i32 0, i32 0
  %t221 = call i1 @identifier_matches(%Token %t219, i8* %s220)
  %t222 = load %Parser, %Parser* %l0
  %t223 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t225 = load %Token, %Token* %l3
  br i1 %t221, label %then46, label %merge47
then46:
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t227 = bitcast { i8**, i64 }* %t226 to { %Decorator*, i64 }*
  %t228 = call %StatementParseResult @parse_type_alias(%Parser %parser, { %Decorator*, i64 }* %t227)
  ret %StatementParseResult %t228
merge47:
  %t229 = load %Token, %Token* %l3
  %s230 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.230, i32 0, i32 0
  %t231 = call i1 @identifier_matches(%Token %t229, i8* %s230)
  %t232 = load %Parser, %Parser* %l0
  %t233 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t234 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t235 = load %Token, %Token* %l3
  br i1 %t231, label %then48, label %merge49
then48:
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t237 = bitcast { i8**, i64 }* %t236 to { %Decorator*, i64 }*
  %t238 = call %StatementParseResult @parse_interface(%Parser %parser, { %Decorator*, i64 }* %t237)
  ret %StatementParseResult %t238
merge49:
  %t239 = load %Token, %Token* %l3
  %s240 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.240, i32 0, i32 0
  %t241 = call i1 @identifier_matches(%Token %t239, i8* %s240)
  %t242 = load %Parser, %Parser* %l0
  %t243 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t245 = load %Token, %Token* %l3
  br i1 %t241, label %then50, label %merge51
then50:
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t247 = bitcast { i8**, i64 }* %t246 to { %Decorator*, i64 }*
  %t248 = call %StatementParseResult @parse_enum(%Parser %parser, { %Decorator*, i64 }* %t247)
  ret %StatementParseResult %t248
merge51:
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t250 = load { i8**, i64 }, { i8**, i64 }* %t249
  %t251 = extractvalue { i8**, i64 } %t250, 1
  %t252 = icmp sgt i64 %t251, 0
  %t253 = load %Parser, %Parser* %l0
  %t254 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t255 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t256 = load %Token, %Token* %l3
  br i1 %t252, label %then52, label %merge53
then52:
  %t257 = load %Parser, %Parser* %l0
  %t258 = call %StatementParseResult @parse_unknown(%Parser %t257)
  ret %StatementParseResult %t258
merge53:
  %t259 = call %StatementParseResult @parse_unknown(%Parser %parser)
  ret %StatementParseResult %t259
}

define %StatementParseResult @parse_import(%Parser %parser) {
entry:
  %l0 = alloca %SpecifierListParseResult
  %l1 = alloca { %ImportSpecifier*, i64 }*
  %l2 = alloca %CaptureResult
  %l3 = alloca i8*
  %l4 = alloca %Statement
  %t0 = call %SpecifierListParseResult @parse_specifier_list(%Parser %parser)
  store %SpecifierListParseResult %t0, %SpecifierListParseResult* %l0
  %t1 = load %SpecifierListParseResult, %SpecifierListParseResult* %l0
  %t2 = extractvalue %SpecifierListParseResult %t1, 1
  %t3 = bitcast { i8**, i64 }* %t2 to { %NamedSpecifier*, i64 }*
  %t4 = call { %ImportSpecifier*, i64 }* @build_import_specifiers({ %NamedSpecifier*, i64 }* %t3)
  store { %ImportSpecifier*, i64 }* %t4, { %ImportSpecifier*, i64 }** %l1
  %t5 = alloca [1 x i8]
  %t6 = getelementptr [1 x i8], [1 x i8]* %t5, i32 0, i32 0
  %t7 = getelementptr i8, i8* %t6, i64 0
  store i8 59, i8* %t7
  %t8 = alloca { i8*, i64 }
  %t9 = getelementptr { i8*, i64 }, { i8*, i64 }* %t8, i32 0, i32 0
  store i8* %t6, i8** %t9
  %t10 = getelementptr { i8*, i64 }, { i8*, i64 }* %t8, i32 0, i32 1
  store i64 1, i64* %t10
  %t11 = bitcast { i8*, i64 }* %t8 to { i8**, i64 }*
  %t12 = call %CaptureResult @collect_until(%Parser %parser, { i8**, i64 }* %t11)
  store %CaptureResult %t12, %CaptureResult* %l2
  %t13 = load %CaptureResult, %CaptureResult* %l2
  %t14 = extractvalue %CaptureResult %t13, 1
  %t15 = bitcast { i8**, i64 }* %t14 to { %Token*, i64 }*
  %t16 = call i8* @tokens_to_text({ %Token*, i64 }* %t15)
  %t17 = call i8* @trim_text(i8* %t16)
  store i8* %t17, i8** %l3
  %t18 = load i8*, i8** %l3
  %t19 = call i8* @strip_surrounding_quotes(i8* %t18)
  store i8* %t19, i8** %l3
  %t21 = call %Token @parser_peek_raw(%Parser %parser)
  %t22 = extractvalue %Token %t21, 0
  %t23 = alloca %Statement
  %t24 = getelementptr inbounds %Statement, %Statement* %t23, i32 0, i32 0
  store i32 0, i32* %t24
  %t25 = load { %ImportSpecifier*, i64 }*, { %ImportSpecifier*, i64 }** %l1
  %t26 = bitcast { %ImportSpecifier*, i64 }* %t25 to { i8**, i64 }*
  %t27 = getelementptr inbounds %Statement, %Statement* %t23, i32 0, i32 1
  %t28 = bitcast [16 x i8]* %t27 to i8*
  %t29 = bitcast i8* %t28 to { i8**, i64 }**
  store { i8**, i64 }* %t26, { i8**, i64 }** %t29
  %t30 = load i8*, i8** %l3
  %t31 = getelementptr inbounds %Statement, %Statement* %t23, i32 0, i32 1
  %t32 = bitcast [16 x i8]* %t31 to i8*
  %t33 = getelementptr inbounds i8, i8* %t32, i64 8
  %t34 = bitcast i8* %t33 to i8**
  store i8* %t30, i8** %t34
  %t35 = load %Statement, %Statement* %t23
  store %Statement %t35, %Statement* %l4
  %t36 = insertvalue %StatementParseResult undef, i8* null, 0
  %t37 = load %Statement, %Statement* %l4
  %t38 = insertvalue %StatementParseResult %t36, i8* null, 1
  ret %StatementParseResult %t38
}

define %StatementParseResult @parse_export(%Parser %parser) {
entry:
  %l0 = alloca %SpecifierListParseResult
  %l1 = alloca { %ExportSpecifier*, i64 }*
  %l2 = alloca %CaptureResult
  %l3 = alloca i8*
  %l4 = alloca %Statement
  %t0 = call %SpecifierListParseResult @parse_specifier_list(%Parser %parser)
  store %SpecifierListParseResult %t0, %SpecifierListParseResult* %l0
  %t1 = load %SpecifierListParseResult, %SpecifierListParseResult* %l0
  %t2 = extractvalue %SpecifierListParseResult %t1, 1
  %t3 = bitcast { i8**, i64 }* %t2 to { %NamedSpecifier*, i64 }*
  %t4 = call { %ExportSpecifier*, i64 }* @build_export_specifiers({ %NamedSpecifier*, i64 }* %t3)
  store { %ExportSpecifier*, i64 }* %t4, { %ExportSpecifier*, i64 }** %l1
  %t5 = alloca [1 x i8]
  %t6 = getelementptr [1 x i8], [1 x i8]* %t5, i32 0, i32 0
  %t7 = getelementptr i8, i8* %t6, i64 0
  store i8 59, i8* %t7
  %t8 = alloca { i8*, i64 }
  %t9 = getelementptr { i8*, i64 }, { i8*, i64 }* %t8, i32 0, i32 0
  store i8* %t6, i8** %t9
  %t10 = getelementptr { i8*, i64 }, { i8*, i64 }* %t8, i32 0, i32 1
  store i64 1, i64* %t10
  %t11 = bitcast { i8*, i64 }* %t8 to { i8**, i64 }*
  %t12 = call %CaptureResult @collect_until(%Parser %parser, { i8**, i64 }* %t11)
  store %CaptureResult %t12, %CaptureResult* %l2
  %t13 = load %CaptureResult, %CaptureResult* %l2
  %t14 = extractvalue %CaptureResult %t13, 1
  %t15 = bitcast { i8**, i64 }* %t14 to { %Token*, i64 }*
  %t16 = call i8* @tokens_to_text({ %Token*, i64 }* %t15)
  %t17 = call i8* @trim_text(i8* %t16)
  store i8* %t17, i8** %l3
  %t18 = load i8*, i8** %l3
  %t19 = call i8* @strip_surrounding_quotes(i8* %t18)
  store i8* %t19, i8** %l3
  %t21 = call %Token @parser_peek_raw(%Parser %parser)
  %t22 = extractvalue %Token %t21, 0
  %t23 = alloca %Statement
  %t24 = getelementptr inbounds %Statement, %Statement* %t23, i32 0, i32 0
  store i32 1, i32* %t24
  %t25 = load { %ExportSpecifier*, i64 }*, { %ExportSpecifier*, i64 }** %l1
  %t26 = bitcast { %ExportSpecifier*, i64 }* %t25 to { i8**, i64 }*
  %t27 = getelementptr inbounds %Statement, %Statement* %t23, i32 0, i32 1
  %t28 = bitcast [16 x i8]* %t27 to i8*
  %t29 = bitcast i8* %t28 to { i8**, i64 }**
  store { i8**, i64 }* %t26, { i8**, i64 }** %t29
  %t30 = load i8*, i8** %l3
  %t31 = getelementptr inbounds %Statement, %Statement* %t23, i32 0, i32 1
  %t32 = bitcast [16 x i8]* %t31 to i8*
  %t33 = getelementptr inbounds i8, i8* %t32, i64 8
  %t34 = bitcast i8* %t33 to i8**
  store i8* %t30, i8** %t34
  %t35 = load %Statement, %Statement* %t23
  store %Statement %t35, %Statement* %l4
  %t36 = insertvalue %StatementParseResult undef, i8* null, 0
  %t37 = load %Statement, %Statement* %l4
  %t38 = insertvalue %StatementParseResult %t36, i8* null, 1
  ret %StatementParseResult %t38
}

define %StatementParseResult @parse_variable(%Parser %parser) {
entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca %Token
  %l2 = alloca i1
  %l3 = alloca %Token
  %l4 = alloca %Token
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca %Token
  %l8 = alloca i8*
  %l9 = alloca i8*
  %l10 = alloca %Token
  %l11 = alloca %Token
  %l12 = alloca double
  %l13 = alloca %Statement
  %t0 = alloca [0 x %Token]
  %t1 = getelementptr [0 x %Token], [0 x %Token]* %t0, i32 0, i32 0
  %t2 = alloca { %Token*, i64 }
  %t3 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t2, i32 0, i32 0
  store %Token* %t1, %Token** %t3
  %t4 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Token*, i64 }* %t2, { %Token*, i64 }** %l0
  %t5 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t5, %Token* %l1
  %t6 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t7 = load %Token, %Token* %l1
  %t8 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t6, %Token %t7)
  store { %Token*, i64 }* %t8, { %Token*, i64 }** %l0
  store i1 0, i1* %l2
  %t9 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t9, %Token* %l3
  %t10 = load %Token, %Token* %l3
  %s11 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.11, i32 0, i32 0
  %t12 = call i1 @identifier_matches(%Token %t10, i8* %s11)
  %t13 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t14 = load %Token, %Token* %l1
  %t15 = load i1, i1* %l2
  %t16 = load %Token, %Token* %l3
  br i1 %t12, label %then0, label %merge1
then0:
  %t17 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t18 = load %Token, %Token* %l3
  %t19 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t17, %Token %t18)
  store { %Token*, i64 }* %t19, { %Token*, i64 }** %l0
  store i1 1, i1* %l2
  br label %merge1
merge1:
  %t20 = phi { %Token*, i64 }* [ %t19, %then0 ], [ %t13, %entry ]
  %t21 = phi i1 [ 1, %then0 ], [ %t15, %entry ]
  store { %Token*, i64 }* %t20, { %Token*, i64 }** %l0
  store i1 %t21, i1* %l2
  %t22 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t22, %Token* %l4
  %t23 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t24 = load %Token, %Token* %l4
  %t25 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t23, %Token %t24)
  store { %Token*, i64 }* %t25, { %Token*, i64 }** %l0
  %t26 = load %Token, %Token* %l4
  %t27 = call i8* @identifier_text(%Token %t26)
  store i8* %t27, i8** %l5
  store i8* null, i8** %l6
  %t28 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t28, %Token* %l7
  %t31 = load %Token, %Token* %l7
  %t32 = extractvalue %Token %t31, 0
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  %t33 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t33, %Token* %l10
  %t35 = load %Token, %Token* %l10
  %t36 = extractvalue %Token %t35, 0
  %t37 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t37, %Token* %l11
  %t39 = load %Token, %Token* %l11
  %t40 = extractvalue %Token %t39, 0
  %t41 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t42 = call double @source_span_from_tokens({ %Token*, i64 }* %t41)
  store double %t42, double* %l12
  %t43 = alloca %Statement
  %t44 = getelementptr inbounds %Statement, %Statement* %t43, i32 0, i32 0
  store i32 2, i32* %t44
  %t45 = load i8*, i8** %l5
  %t46 = getelementptr inbounds %Statement, %Statement* %t43, i32 0, i32 1
  %t47 = bitcast [48 x i8]* %t46 to i8*
  %t48 = bitcast i8* %t47 to i8**
  store i8* %t45, i8** %t48
  %t49 = load i1, i1* %l2
  %t50 = getelementptr inbounds %Statement, %Statement* %t43, i32 0, i32 1
  %t51 = bitcast [48 x i8]* %t50 to i8*
  %t52 = getelementptr inbounds i8, i8* %t51, i64 8
  %t53 = bitcast i8* %t52 to i1*
  store i1 %t49, i1* %t53
  %t54 = load i8*, i8** %l6
  %t55 = getelementptr inbounds %Statement, %Statement* %t43, i32 0, i32 1
  %t56 = bitcast [48 x i8]* %t55 to i8*
  %t57 = getelementptr inbounds i8, i8* %t56, i64 16
  %t58 = bitcast i8* %t57 to i8**
  store i8* %t54, i8** %t58
  %t59 = load i8*, i8** %l8
  %t60 = getelementptr inbounds %Statement, %Statement* %t43, i32 0, i32 1
  %t61 = bitcast [48 x i8]* %t60 to i8*
  %t62 = getelementptr inbounds i8, i8* %t61, i64 24
  %t63 = bitcast i8* %t62 to i8**
  store i8* %t59, i8** %t63
  %t64 = load double, double* %l12
  %t65 = call noalias i8* @malloc(i64 8)
  %t66 = bitcast i8* %t65 to double*
  store double %t64, double* %t66
  %t67 = getelementptr inbounds %Statement, %Statement* %t43, i32 0, i32 1
  %t68 = bitcast [48 x i8]* %t67 to i8*
  %t69 = getelementptr inbounds i8, i8* %t68, i64 32
  %t70 = bitcast i8* %t69 to i8**
  store i8* %t65, i8** %t70
  %t71 = load i8*, i8** %l9
  %t72 = getelementptr inbounds %Statement, %Statement* %t43, i32 0, i32 1
  %t73 = bitcast [48 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 40
  %t75 = bitcast i8* %t74 to i8**
  store i8* %t71, i8** %t75
  %t76 = load %Statement, %Statement* %t43
  store %Statement %t76, %Statement* %l13
  %t77 = insertvalue %StatementParseResult undef, i8* null, 0
  %t78 = load %Statement, %Statement* %l13
  %t79 = insertvalue %StatementParseResult %t77, i8* null, 1
  ret %StatementParseResult %t79
}

define %SpecifierListParseResult @parse_specifier_list(%Parser %parser) {
entry:
  %l0 = alloca { %NamedSpecifier*, i64 }*
  %l1 = alloca %Token
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca %Token
  %l5 = alloca %Token
  %l6 = alloca %Token
  %t0 = alloca [0 x %NamedSpecifier]
  %t1 = getelementptr [0 x %NamedSpecifier], [0 x %NamedSpecifier]* %t0, i32 0, i32 0
  %t2 = alloca { %NamedSpecifier*, i64 }
  %t3 = getelementptr { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %t2, i32 0, i32 0
  store %NamedSpecifier* %t1, %NamedSpecifier** %t3
  %t4 = getelementptr { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %NamedSpecifier*, i64 }* %t2, { %NamedSpecifier*, i64 }** %l0
  %t5 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l0
  br label %loop.header0
loop.header0:
  %t46 = phi { %NamedSpecifier*, i64 }* [ %t5, %entry ], [ %t45, %loop.latch2 ]
  store { %NamedSpecifier*, i64 }* %t46, { %NamedSpecifier*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t6 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t6, %Token* %l1
  %t8 = load %Token, %Token* %l1
  %t9 = extractvalue %Token %t8, 0
  %t10 = load %Token, %Token* %l1
  %t11 = extractvalue %Token %t10, 0
  %t12 = load %Token, %Token* %l1
  %t13 = call i8* @identifier_text(%Token %t12)
  store i8* %t13, i8** %l2
  store i8* null, i8** %l3
  %t14 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t14, %Token* %l4
  %t15 = load %Token, %Token* %l4
  %s16 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.16, i32 0, i32 0
  %t17 = call i1 @identifier_matches(%Token %t15, i8* %s16)
  %t18 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l0
  %t19 = load %Token, %Token* %l1
  %t20 = load i8*, i8** %l2
  %t21 = load i8*, i8** %l3
  %t22 = load %Token, %Token* %l4
  br i1 %t17, label %then4, label %merge5
then4:
  %t23 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t23, %Token* %l5
  %t24 = load %Token, %Token* %l5
  %t25 = extractvalue %Token %t24, 0
  br label %merge5
merge5:
  %t26 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l0
  %t27 = load i8*, i8** %l2
  %t28 = insertvalue %NamedSpecifier undef, i8* %t27, 0
  %t29 = load i8*, i8** %l3
  %t30 = insertvalue %NamedSpecifier %t28, i8* %t29, 1
  %t31 = alloca [1 x %NamedSpecifier]
  %t32 = getelementptr [1 x %NamedSpecifier], [1 x %NamedSpecifier]* %t31, i32 0, i32 0
  %t33 = getelementptr %NamedSpecifier, %NamedSpecifier* %t32, i64 0
  store %NamedSpecifier %t30, %NamedSpecifier* %t33
  %t34 = alloca { %NamedSpecifier*, i64 }
  %t35 = getelementptr { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %t34, i32 0, i32 0
  store %NamedSpecifier* %t32, %NamedSpecifier** %t35
  %t36 = getelementptr { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %t34, i32 0, i32 1
  store i64 1, i64* %t36
  %t37 = bitcast { %NamedSpecifier*, i64 }* %t26 to { i8**, i64 }*
  %t38 = bitcast { %NamedSpecifier*, i64 }* %t34 to { i8**, i64 }*
  %t39 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t37, { i8**, i64 }* %t38)
  %t40 = bitcast { i8**, i64 }* %t39 to { %NamedSpecifier*, i64 }*
  store { %NamedSpecifier*, i64 }* %t40, { %NamedSpecifier*, i64 }** %l0
  %t41 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t41, %Token* %l6
  %t43 = load %Token, %Token* %l6
  %t44 = extractvalue %Token %t43, 0
  br label %loop.latch2
loop.latch2:
  %t45 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t48 = call %Token @parser_peek_raw(%Parser %parser)
  %t49 = extractvalue %Token %t48, 0
  %t50 = insertvalue %SpecifierListParseResult undef, i8* null, 0
  %t51 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l0
  %t52 = bitcast { %NamedSpecifier*, i64 }* %t51 to { i8**, i64 }*
  %t53 = insertvalue %SpecifierListParseResult %t50, { i8**, i64 }* %t52, 1
  ret %SpecifierListParseResult %t53
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

define %StatementParseResult @parse_struct(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Token
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca %TypeParameterParseResult
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca %ImplementsParseResult
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca { %FieldDeclaration*, i64 }*
  %l8 = alloca { %MethodDeclaration*, i64 }*
  %l9 = alloca %Parser
  %l10 = alloca %DecoratorParseResult
  %l11 = alloca { i8**, i64 }*
  %l12 = alloca %Token
  %l13 = alloca %StructFieldParseResult
  %l14 = alloca %MethodParseResult
  %l15 = alloca %Statement
  %t0 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t0, %Token* %l0
  %t1 = load %Token, %Token* %l0
  %t2 = call i8* @identifier_text(%Token %t1)
  store i8* %t2, i8** %l1
  %t3 = load %Token, %Token* %l0
  %t4 = alloca [1 x %Token]
  %t5 = getelementptr [1 x %Token], [1 x %Token]* %t4, i32 0, i32 0
  %t6 = getelementptr %Token, %Token* %t5, i64 0
  store %Token %t3, %Token* %t6
  %t7 = alloca { %Token*, i64 }
  %t8 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t7, i32 0, i32 0
  store %Token* %t5, %Token** %t8
  %t9 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t7, i32 0, i32 1
  store i64 1, i64* %t9
  %t10 = call double @source_span_from_tokens({ %Token*, i64 }* %t7)
  store double %t10, double* %l2
  %t11 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %parser)
  store %TypeParameterParseResult %t11, %TypeParameterParseResult* %l3
  %t12 = load %TypeParameterParseResult, %TypeParameterParseResult* %l3
  %t13 = extractvalue %TypeParameterParseResult %t12, 1
  store { i8**, i64 }* %t13, { i8**, i64 }** %l4
  %t14 = call %ImplementsParseResult @parse_implements_clause(%Parser %parser)
  store %ImplementsParseResult %t14, %ImplementsParseResult* %l5
  %t15 = load %ImplementsParseResult, %ImplementsParseResult* %l5
  %t16 = extractvalue %ImplementsParseResult %t15, 1
  store { i8**, i64 }* %t16, { i8**, i64 }** %l6
  %t17 = alloca [0 x %FieldDeclaration]
  %t18 = getelementptr [0 x %FieldDeclaration], [0 x %FieldDeclaration]* %t17, i32 0, i32 0
  %t19 = alloca { %FieldDeclaration*, i64 }
  %t20 = getelementptr { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %t19, i32 0, i32 0
  store %FieldDeclaration* %t18, %FieldDeclaration** %t20
  %t21 = getelementptr { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %t19, i32 0, i32 1
  store i64 0, i64* %t21
  store { %FieldDeclaration*, i64 }* %t19, { %FieldDeclaration*, i64 }** %l7
  %t22 = alloca [0 x %MethodDeclaration]
  %t23 = getelementptr [0 x %MethodDeclaration], [0 x %MethodDeclaration]* %t22, i32 0, i32 0
  %t24 = alloca { %MethodDeclaration*, i64 }
  %t25 = getelementptr { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t24, i32 0, i32 0
  store %MethodDeclaration* %t23, %MethodDeclaration** %t25
  %t26 = getelementptr { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t24, i32 0, i32 1
  store i64 0, i64* %t26
  store { %MethodDeclaration*, i64 }* %t24, { %MethodDeclaration*, i64 }** %l8
  %t27 = load %Token, %Token* %l0
  %t28 = load i8*, i8** %l1
  %t29 = load double, double* %l2
  %t30 = load %TypeParameterParseResult, %TypeParameterParseResult* %l3
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t32 = load %ImplementsParseResult, %ImplementsParseResult* %l5
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t34 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l7
  %t35 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %l8
  br label %loop.header0
loop.header0:
  %t135 = phi { %FieldDeclaration*, i64 }* [ %t34, %entry ], [ %t133, %loop.latch2 ]
  %t136 = phi { %MethodDeclaration*, i64 }* [ %t35, %entry ], [ %t134, %loop.latch2 ]
  store { %FieldDeclaration*, i64 }* %t135, { %FieldDeclaration*, i64 }** %l7
  store { %MethodDeclaration*, i64 }* %t136, { %MethodDeclaration*, i64 }** %l8
  br label %loop.body1
loop.body1:
  store %Parser %parser, %Parser* %l9
  %t36 = call %DecoratorParseResult @parse_decorators(%Parser %parser)
  store %DecoratorParseResult %t36, %DecoratorParseResult* %l10
  %t37 = load %DecoratorParseResult, %DecoratorParseResult* %l10
  %t38 = extractvalue %DecoratorParseResult %t37, 1
  store { i8**, i64 }* %t38, { i8**, i64 }** %l11
  %t39 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t39, %Token* %l12
  %t41 = load %Token, %Token* %l12
  %t42 = extractvalue %Token %t41, 0
  %t43 = load %Token, %Token* %l12
  %t44 = extractvalue %Token %t43, 0
  %t45 = call %StructFieldParseResult @parse_struct_field(%Parser %parser)
  store %StructFieldParseResult %t45, %StructFieldParseResult* %l13
  %t47 = load %StructFieldParseResult, %StructFieldParseResult* %l13
  %t48 = extractvalue %StructFieldParseResult %t47, 2
  br label %logical_and_entry_46

logical_and_entry_46:
  br i1 %t48, label %logical_and_right_46, label %logical_and_merge_46

logical_and_right_46:
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t50 = load { i8**, i64 }, { i8**, i64 }* %t49
  %t51 = extractvalue { i8**, i64 } %t50, 1
  %t52 = icmp eq i64 %t51, 0
  br label %logical_and_right_end_46

logical_and_right_end_46:
  br label %logical_and_merge_46

logical_and_merge_46:
  %t53 = phi i1 [ false, %logical_and_entry_46 ], [ %t52, %logical_and_right_end_46 ]
  %t54 = load %Token, %Token* %l0
  %t55 = load i8*, i8** %l1
  %t56 = load double, double* %l2
  %t57 = load %TypeParameterParseResult, %TypeParameterParseResult* %l3
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t59 = load %ImplementsParseResult, %ImplementsParseResult* %l5
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t61 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l7
  %t62 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %l8
  %t63 = load %Parser, %Parser* %l9
  %t64 = load %DecoratorParseResult, %DecoratorParseResult* %l10
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t66 = load %Token, %Token* %l12
  %t67 = load %StructFieldParseResult, %StructFieldParseResult* %l13
  br i1 %t53, label %then4, label %merge5
then4:
  %t68 = load %StructFieldParseResult, %StructFieldParseResult* %l13
  %t69 = extractvalue %StructFieldParseResult %t68, 1
  %t70 = icmp ne i8* %t69, null
  %t71 = load %Token, %Token* %l0
  %t72 = load i8*, i8** %l1
  %t73 = load double, double* %l2
  %t74 = load %TypeParameterParseResult, %TypeParameterParseResult* %l3
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t76 = load %ImplementsParseResult, %ImplementsParseResult* %l5
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t78 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l7
  %t79 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %l8
  %t80 = load %Parser, %Parser* %l9
  %t81 = load %DecoratorParseResult, %DecoratorParseResult* %l10
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t83 = load %Token, %Token* %l12
  %t84 = load %StructFieldParseResult, %StructFieldParseResult* %l13
  br i1 %t70, label %then6, label %merge7
then6:
  %t85 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l7
  %t86 = load %StructFieldParseResult, %StructFieldParseResult* %l13
  %t87 = extractvalue %StructFieldParseResult %t86, 1
  %t88 = call { %FieldDeclaration*, i64 }* @append_field({ %FieldDeclaration*, i64 }* %t85, %FieldDeclaration zeroinitializer)
  store { %FieldDeclaration*, i64 }* %t88, { %FieldDeclaration*, i64 }** %l7
  br label %merge7
merge7:
  %t89 = phi { %FieldDeclaration*, i64 }* [ %t88, %then6 ], [ %t78, %then4 ]
  store { %FieldDeclaration*, i64 }* %t89, { %FieldDeclaration*, i64 }** %l7
  br label %loop.latch2
merge5:
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t91 = bitcast { i8**, i64 }* %t90 to { %Decorator*, i64 }*
  %t92 = call %MethodParseResult @parse_struct_method(%Parser %parser, { %Decorator*, i64 }* %t91)
  store %MethodParseResult %t92, %MethodParseResult* %l14
  %t93 = load %MethodParseResult, %MethodParseResult* %l14
  %t94 = extractvalue %MethodParseResult %t93, 2
  %t95 = load %Token, %Token* %l0
  %t96 = load i8*, i8** %l1
  %t97 = load double, double* %l2
  %t98 = load %TypeParameterParseResult, %TypeParameterParseResult* %l3
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t100 = load %ImplementsParseResult, %ImplementsParseResult* %l5
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t102 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l7
  %t103 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %l8
  %t104 = load %Parser, %Parser* %l9
  %t105 = load %DecoratorParseResult, %DecoratorParseResult* %l10
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t107 = load %Token, %Token* %l12
  %t108 = load %StructFieldParseResult, %StructFieldParseResult* %l13
  %t109 = load %MethodParseResult, %MethodParseResult* %l14
  br i1 %t94, label %then8, label %merge9
then8:
  %t110 = load %MethodParseResult, %MethodParseResult* %l14
  %t111 = extractvalue %MethodParseResult %t110, 1
  %t112 = icmp ne i8* %t111, null
  %t113 = load %Token, %Token* %l0
  %t114 = load i8*, i8** %l1
  %t115 = load double, double* %l2
  %t116 = load %TypeParameterParseResult, %TypeParameterParseResult* %l3
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t118 = load %ImplementsParseResult, %ImplementsParseResult* %l5
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t120 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l7
  %t121 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %l8
  %t122 = load %Parser, %Parser* %l9
  %t123 = load %DecoratorParseResult, %DecoratorParseResult* %l10
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t125 = load %Token, %Token* %l12
  %t126 = load %StructFieldParseResult, %StructFieldParseResult* %l13
  %t127 = load %MethodParseResult, %MethodParseResult* %l14
  br i1 %t112, label %then10, label %merge11
then10:
  %t128 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %l8
  %t129 = load %MethodParseResult, %MethodParseResult* %l14
  %t130 = extractvalue %MethodParseResult %t129, 1
  %t131 = call { %MethodDeclaration*, i64 }* @append_method({ %MethodDeclaration*, i64 }* %t128, %MethodDeclaration zeroinitializer)
  store { %MethodDeclaration*, i64 }* %t131, { %MethodDeclaration*, i64 }** %l8
  br label %merge11
merge11:
  %t132 = phi { %MethodDeclaration*, i64 }* [ %t131, %then10 ], [ %t121, %then8 ]
  store { %MethodDeclaration*, i64 }* %t132, { %MethodDeclaration*, i64 }** %l8
  br label %loop.latch2
merge9:
  br label %loop.latch2
loop.latch2:
  %t133 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l7
  %t134 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %l8
  br label %loop.header0
afterloop3:
  %t137 = alloca %Statement
  %t138 = getelementptr inbounds %Statement, %Statement* %t137, i32 0, i32 0
  store i32 8, i32* %t138
  %t139 = load i8*, i8** %l1
  %t140 = getelementptr inbounds %Statement, %Statement* %t137, i32 0, i32 1
  %t141 = bitcast [56 x i8]* %t140 to i8*
  %t142 = bitcast i8* %t141 to i8**
  store i8* %t139, i8** %t142
  %t143 = load double, double* %l2
  %t144 = call noalias i8* @malloc(i64 8)
  %t145 = bitcast i8* %t144 to double*
  store double %t143, double* %t145
  %t146 = getelementptr inbounds %Statement, %Statement* %t137, i32 0, i32 1
  %t147 = bitcast [56 x i8]* %t146 to i8*
  %t148 = getelementptr inbounds i8, i8* %t147, i64 8
  %t149 = bitcast i8* %t148 to i8**
  store i8* %t144, i8** %t149
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t151 = getelementptr inbounds %Statement, %Statement* %t137, i32 0, i32 1
  %t152 = bitcast [56 x i8]* %t151 to i8*
  %t153 = getelementptr inbounds i8, i8* %t152, i64 16
  %t154 = bitcast i8* %t153 to { i8**, i64 }**
  store { i8**, i64 }* %t150, { i8**, i64 }** %t154
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t156 = getelementptr inbounds %Statement, %Statement* %t137, i32 0, i32 1
  %t157 = bitcast [56 x i8]* %t156 to i8*
  %t158 = getelementptr inbounds i8, i8* %t157, i64 24
  %t159 = bitcast i8* %t158 to { i8**, i64 }**
  store { i8**, i64 }* %t155, { i8**, i64 }** %t159
  %t160 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l7
  %t161 = bitcast { %FieldDeclaration*, i64 }* %t160 to { i8**, i64 }*
  %t162 = getelementptr inbounds %Statement, %Statement* %t137, i32 0, i32 1
  %t163 = bitcast [56 x i8]* %t162 to i8*
  %t164 = getelementptr inbounds i8, i8* %t163, i64 32
  %t165 = bitcast i8* %t164 to { i8**, i64 }**
  store { i8**, i64 }* %t161, { i8**, i64 }** %t165
  %t166 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %l8
  %t167 = bitcast { %MethodDeclaration*, i64 }* %t166 to { i8**, i64 }*
  %t168 = getelementptr inbounds %Statement, %Statement* %t137, i32 0, i32 1
  %t169 = bitcast [56 x i8]* %t168 to i8*
  %t170 = getelementptr inbounds i8, i8* %t169, i64 40
  %t171 = bitcast i8* %t170 to { i8**, i64 }**
  store { i8**, i64 }* %t167, { i8**, i64 }** %t171
  %t172 = bitcast { %Decorator*, i64 }* %decorators to { i8**, i64 }*
  %t173 = getelementptr inbounds %Statement, %Statement* %t137, i32 0, i32 1
  %t174 = bitcast [56 x i8]* %t173 to i8*
  %t175 = getelementptr inbounds i8, i8* %t174, i64 48
  %t176 = bitcast i8* %t175 to { i8**, i64 }**
  store { i8**, i64 }* %t172, { i8**, i64 }** %t176
  %t177 = load %Statement, %Statement* %t137
  store %Statement %t177, %Statement* %l15
  %t178 = insertvalue %StatementParseResult undef, i8* null, 0
  %t179 = load %Statement, %Statement* %l15
  %t180 = insertvalue %StatementParseResult %t178, i8* null, 1
  ret %StatementParseResult %t180
}

define %StatementParseResult @parse_type_alias(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca %TypeParameterParseResult
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca %Token
  %l7 = alloca %CaptureResult
  %l8 = alloca i8*
  %l9 = alloca %TypeAnnotation
  %l10 = alloca %Statement
  store %Parser %parser, %Parser* %l0
  %t0 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t0, %Token* %l1
  %t1 = load %Token, %Token* %l1
  %t2 = extractvalue %Token %t1, 0
  %t3 = load %Token, %Token* %l1
  %t4 = call i8* @identifier_text(%Token %t3)
  store i8* %t4, i8** %l2
  %t5 = load %Token, %Token* %l1
  %t6 = alloca [1 x %Token]
  %t7 = getelementptr [1 x %Token], [1 x %Token]* %t6, i32 0, i32 0
  %t8 = getelementptr %Token, %Token* %t7, i64 0
  store %Token %t5, %Token* %t8
  %t9 = alloca { %Token*, i64 }
  %t10 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t9, i32 0, i32 0
  store %Token* %t7, %Token** %t10
  %t11 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t9, i32 0, i32 1
  store i64 1, i64* %t11
  %t12 = call double @source_span_from_tokens({ %Token*, i64 }* %t9)
  store double %t12, double* %l3
  %t13 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %parser)
  store %TypeParameterParseResult %t13, %TypeParameterParseResult* %l4
  %t14 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t15 = extractvalue %TypeParameterParseResult %t14, 1
  store { i8**, i64 }* %t15, { i8**, i64 }** %l5
  %t16 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t16, %Token* %l6
  %t18 = load %Token, %Token* %l6
  %t19 = extractvalue %Token %t18, 0
  %t20 = call %Parser @skip_trivia(%Parser %parser)
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
  store %CaptureResult %t28, %CaptureResult* %l7
  %t29 = load %CaptureResult, %CaptureResult* %l7
  %t30 = extractvalue %CaptureResult %t29, 1
  %t31 = bitcast { i8**, i64 }* %t30 to { %Token*, i64 }*
  %t32 = call i8* @tokens_to_text({ %Token*, i64 }* %t31)
  %t33 = call i8* @trim_text(i8* %t32)
  store i8* %t33, i8** %l8
  %t34 = load i8*, i8** %l8
  %t35 = call i64 @sailfin_runtime_string_length(i8* %t34)
  %t36 = icmp eq i64 %t35, 0
  %t37 = load %Parser, %Parser* %l0
  %t38 = load %Token, %Token* %l1
  %t39 = load i8*, i8** %l2
  %t40 = load double, double* %l3
  %t41 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t43 = load %Token, %Token* %l6
  %t44 = load %CaptureResult, %CaptureResult* %l7
  %t45 = load i8*, i8** %l8
  br i1 %t36, label %then0, label %merge1
then0:
  %t46 = load %Parser, %Parser* %l0
  %t47 = call %StatementParseResult @parse_unknown(%Parser %t46)
  ret %StatementParseResult %t47
merge1:
  %t48 = load i8*, i8** %l8
  %t49 = insertvalue %TypeAnnotation undef, i8* %t48, 0
  store %TypeAnnotation %t49, %TypeAnnotation* %l9
  %t51 = call %Token @parser_peek_raw(%Parser %parser)
  %t52 = extractvalue %Token %t51, 0
  %t53 = alloca %Statement
  %t54 = getelementptr inbounds %Statement, %Statement* %t53, i32 0, i32 0
  store i32 9, i32* %t54
  %t55 = load i8*, i8** %l2
  %t56 = getelementptr inbounds %Statement, %Statement* %t53, i32 0, i32 1
  %t57 = bitcast [40 x i8]* %t56 to i8*
  %t58 = bitcast i8* %t57 to i8**
  store i8* %t55, i8** %t58
  %t59 = load double, double* %l3
  %t60 = call noalias i8* @malloc(i64 8)
  %t61 = bitcast i8* %t60 to double*
  store double %t59, double* %t61
  %t62 = getelementptr inbounds %Statement, %Statement* %t53, i32 0, i32 1
  %t63 = bitcast [40 x i8]* %t62 to i8*
  %t64 = getelementptr inbounds i8, i8* %t63, i64 8
  %t65 = bitcast i8* %t64 to i8**
  store i8* %t60, i8** %t65
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t67 = getelementptr inbounds %Statement, %Statement* %t53, i32 0, i32 1
  %t68 = bitcast [40 x i8]* %t67 to i8*
  %t69 = getelementptr inbounds i8, i8* %t68, i64 16
  %t70 = bitcast i8* %t69 to { i8**, i64 }**
  store { i8**, i64 }* %t66, { i8**, i64 }** %t70
  %t71 = load %TypeAnnotation, %TypeAnnotation* %l9
  %t72 = call noalias i8* @malloc(i64 8)
  %t73 = bitcast i8* %t72 to %TypeAnnotation*
  store %TypeAnnotation %t71, %TypeAnnotation* %t73
  %t74 = getelementptr inbounds %Statement, %Statement* %t53, i32 0, i32 1
  %t75 = bitcast [40 x i8]* %t74 to i8*
  %t76 = getelementptr inbounds i8, i8* %t75, i64 24
  %t77 = bitcast i8* %t76 to i8**
  store i8* %t72, i8** %t77
  %t78 = bitcast { %Decorator*, i64 }* %decorators to { i8**, i64 }*
  %t79 = getelementptr inbounds %Statement, %Statement* %t53, i32 0, i32 1
  %t80 = bitcast [40 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 32
  %t82 = bitcast i8* %t81 to { i8**, i64 }**
  store { i8**, i64 }* %t78, { i8**, i64 }** %t82
  %t83 = load %Statement, %Statement* %t53
  store %Statement %t83, %Statement* %l10
  %t84 = insertvalue %StatementParseResult undef, i8* null, 0
  %t85 = load %Statement, %Statement* %l10
  %t86 = insertvalue %StatementParseResult %t84, i8* null, 1
  ret %StatementParseResult %t86
}

define %StatementParseResult @parse_interface(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca %TypeParameterParseResult
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca { %FunctionSignature*, i64 }*
  %l7 = alloca %Token
  %l8 = alloca %Parser
  %l9 = alloca %DecoratorParseResult
  %l10 = alloca { i8**, i64 }*
  %l11 = alloca %InterfaceMemberParseResult
  %l12 = alloca %Statement
  store %Parser %parser, %Parser* %l0
  %t0 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t0, %Token* %l1
  %t1 = load %Token, %Token* %l1
  %t2 = extractvalue %Token %t1, 0
  %t3 = load %Token, %Token* %l1
  %t4 = call i8* @identifier_text(%Token %t3)
  store i8* %t4, i8** %l2
  %t5 = load %Token, %Token* %l1
  %t6 = alloca [1 x %Token]
  %t7 = getelementptr [1 x %Token], [1 x %Token]* %t6, i32 0, i32 0
  %t8 = getelementptr %Token, %Token* %t7, i64 0
  store %Token %t5, %Token* %t8
  %t9 = alloca { %Token*, i64 }
  %t10 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t9, i32 0, i32 0
  store %Token* %t7, %Token** %t10
  %t11 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t9, i32 0, i32 1
  store i64 1, i64* %t11
  %t12 = call double @source_span_from_tokens({ %Token*, i64 }* %t9)
  store double %t12, double* %l3
  %t13 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %parser)
  store %TypeParameterParseResult %t13, %TypeParameterParseResult* %l4
  %t14 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t15 = extractvalue %TypeParameterParseResult %t14, 1
  store { i8**, i64 }* %t15, { i8**, i64 }** %l5
  %t16 = alloca [0 x %FunctionSignature]
  %t17 = getelementptr [0 x %FunctionSignature], [0 x %FunctionSignature]* %t16, i32 0, i32 0
  %t18 = alloca { %FunctionSignature*, i64 }
  %t19 = getelementptr { %FunctionSignature*, i64 }, { %FunctionSignature*, i64 }* %t18, i32 0, i32 0
  store %FunctionSignature* %t17, %FunctionSignature** %t19
  %t20 = getelementptr { %FunctionSignature*, i64 }, { %FunctionSignature*, i64 }* %t18, i32 0, i32 1
  store i64 0, i64* %t20
  store { %FunctionSignature*, i64 }* %t18, { %FunctionSignature*, i64 }** %l6
  %t21 = load %Parser, %Parser* %l0
  %t22 = load %Token, %Token* %l1
  %t23 = load i8*, i8** %l2
  %t24 = load double, double* %l3
  %t25 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t27 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %l6
  br label %loop.header0
loop.header0:
  %t75 = phi { %FunctionSignature*, i64 }* [ %t27, %entry ], [ %t74, %loop.latch2 ]
  store { %FunctionSignature*, i64 }* %t75, { %FunctionSignature*, i64 }** %l6
  br label %loop.body1
loop.body1:
  %t28 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t28, %Token* %l7
  %t30 = load %Token, %Token* %l7
  %t31 = extractvalue %Token %t30, 0
  %t32 = load %Token, %Token* %l7
  %t33 = extractvalue %Token %t32, 0
  store %Parser %parser, %Parser* %l8
  %t34 = call %DecoratorParseResult @parse_decorators(%Parser %parser)
  store %DecoratorParseResult %t34, %DecoratorParseResult* %l9
  %t35 = load %DecoratorParseResult, %DecoratorParseResult* %l9
  %t36 = extractvalue %DecoratorParseResult %t35, 1
  store { i8**, i64 }* %t36, { i8**, i64 }** %l10
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t38 = bitcast { i8**, i64 }* %t37 to { %Decorator*, i64 }*
  %t39 = call %InterfaceMemberParseResult @parse_interface_member(%Parser %parser, { %Decorator*, i64 }* %t38)
  store %InterfaceMemberParseResult %t39, %InterfaceMemberParseResult* %l11
  %t40 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l11
  %t41 = extractvalue %InterfaceMemberParseResult %t40, 2
  %t42 = load %Parser, %Parser* %l0
  %t43 = load %Token, %Token* %l1
  %t44 = load i8*, i8** %l2
  %t45 = load double, double* %l3
  %t46 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t48 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %l6
  %t49 = load %Token, %Token* %l7
  %t50 = load %Parser, %Parser* %l8
  %t51 = load %DecoratorParseResult, %DecoratorParseResult* %l9
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t53 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l11
  br i1 %t41, label %then4, label %merge5
then4:
  %t54 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l11
  %t55 = extractvalue %InterfaceMemberParseResult %t54, 1
  %t56 = icmp ne i8* %t55, null
  %t57 = load %Parser, %Parser* %l0
  %t58 = load %Token, %Token* %l1
  %t59 = load i8*, i8** %l2
  %t60 = load double, double* %l3
  %t61 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t63 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %l6
  %t64 = load %Token, %Token* %l7
  %t65 = load %Parser, %Parser* %l8
  %t66 = load %DecoratorParseResult, %DecoratorParseResult* %l9
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t68 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l11
  br i1 %t56, label %then6, label %merge7
then6:
  %t69 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %l6
  %t70 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l11
  %t71 = extractvalue %InterfaceMemberParseResult %t70, 1
  %t72 = call { %FunctionSignature*, i64 }* @append_signature({ %FunctionSignature*, i64 }* %t69, %FunctionSignature zeroinitializer)
  store { %FunctionSignature*, i64 }* %t72, { %FunctionSignature*, i64 }** %l6
  br label %merge7
merge7:
  %t73 = phi { %FunctionSignature*, i64 }* [ %t72, %then6 ], [ %t63, %then4 ]
  store { %FunctionSignature*, i64 }* %t73, { %FunctionSignature*, i64 }** %l6
  br label %loop.latch2
merge5:
  br label %loop.latch2
loop.latch2:
  %t74 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %l6
  br label %loop.header0
afterloop3:
  %t76 = alloca %Statement
  %t77 = getelementptr inbounds %Statement, %Statement* %t76, i32 0, i32 0
  store i32 10, i32* %t77
  %t78 = load i8*, i8** %l2
  %t79 = getelementptr inbounds %Statement, %Statement* %t76, i32 0, i32 1
  %t80 = bitcast [40 x i8]* %t79 to i8*
  %t81 = bitcast i8* %t80 to i8**
  store i8* %t78, i8** %t81
  %t82 = load double, double* %l3
  %t83 = call noalias i8* @malloc(i64 8)
  %t84 = bitcast i8* %t83 to double*
  store double %t82, double* %t84
  %t85 = getelementptr inbounds %Statement, %Statement* %t76, i32 0, i32 1
  %t86 = bitcast [40 x i8]* %t85 to i8*
  %t87 = getelementptr inbounds i8, i8* %t86, i64 8
  %t88 = bitcast i8* %t87 to i8**
  store i8* %t83, i8** %t88
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t90 = getelementptr inbounds %Statement, %Statement* %t76, i32 0, i32 1
  %t91 = bitcast [40 x i8]* %t90 to i8*
  %t92 = getelementptr inbounds i8, i8* %t91, i64 16
  %t93 = bitcast i8* %t92 to { i8**, i64 }**
  store { i8**, i64 }* %t89, { i8**, i64 }** %t93
  %t94 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %l6
  %t95 = bitcast { %FunctionSignature*, i64 }* %t94 to { i8**, i64 }*
  %t96 = getelementptr inbounds %Statement, %Statement* %t76, i32 0, i32 1
  %t97 = bitcast [40 x i8]* %t96 to i8*
  %t98 = getelementptr inbounds i8, i8* %t97, i64 24
  %t99 = bitcast i8* %t98 to { i8**, i64 }**
  store { i8**, i64 }* %t95, { i8**, i64 }** %t99
  %t100 = bitcast { %Decorator*, i64 }* %decorators to { i8**, i64 }*
  %t101 = getelementptr inbounds %Statement, %Statement* %t76, i32 0, i32 1
  %t102 = bitcast [40 x i8]* %t101 to i8*
  %t103 = getelementptr inbounds i8, i8* %t102, i64 32
  %t104 = bitcast i8* %t103 to { i8**, i64 }**
  store { i8**, i64 }* %t100, { i8**, i64 }** %t104
  %t105 = load %Statement, %Statement* %t76
  store %Statement %t105, %Statement* %l12
  %t106 = insertvalue %StatementParseResult undef, i8* null, 0
  %t107 = load %Statement, %Statement* %l12
  %t108 = insertvalue %StatementParseResult %t106, i8* null, 1
  ret %StatementParseResult %t108
}

define %StatementParseResult @parse_enum(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca %TypeParameterParseResult
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca { %EnumVariant*, i64 }*
  %l7 = alloca %Token
  %l8 = alloca %EnumVariantParseResult
  %l9 = alloca %Statement
  store %Parser %parser, %Parser* %l0
  %t0 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t0, %Token* %l1
  %t1 = load %Token, %Token* %l1
  %t2 = extractvalue %Token %t1, 0
  %t3 = load %Token, %Token* %l1
  %t4 = call i8* @identifier_text(%Token %t3)
  store i8* %t4, i8** %l2
  %t5 = load %Token, %Token* %l1
  %t6 = alloca [1 x %Token]
  %t7 = getelementptr [1 x %Token], [1 x %Token]* %t6, i32 0, i32 0
  %t8 = getelementptr %Token, %Token* %t7, i64 0
  store %Token %t5, %Token* %t8
  %t9 = alloca { %Token*, i64 }
  %t10 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t9, i32 0, i32 0
  store %Token* %t7, %Token** %t10
  %t11 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t9, i32 0, i32 1
  store i64 1, i64* %t11
  %t12 = call double @source_span_from_tokens({ %Token*, i64 }* %t9)
  store double %t12, double* %l3
  %t13 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %parser)
  store %TypeParameterParseResult %t13, %TypeParameterParseResult* %l4
  %t14 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t15 = extractvalue %TypeParameterParseResult %t14, 1
  store { i8**, i64 }* %t15, { i8**, i64 }** %l5
  %t16 = alloca [0 x %EnumVariant]
  %t17 = getelementptr [0 x %EnumVariant], [0 x %EnumVariant]* %t16, i32 0, i32 0
  %t18 = alloca { %EnumVariant*, i64 }
  %t19 = getelementptr { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %t18, i32 0, i32 0
  store %EnumVariant* %t17, %EnumVariant** %t19
  %t20 = getelementptr { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %t18, i32 0, i32 1
  store i64 0, i64* %t20
  store { %EnumVariant*, i64 }* %t18, { %EnumVariant*, i64 }** %l6
  %t21 = load %Parser, %Parser* %l0
  %t22 = load %Token, %Token* %l1
  %t23 = load i8*, i8** %l2
  %t24 = load double, double* %l3
  %t25 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t27 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %l6
  br label %loop.header0
loop.header0:
  %t64 = phi { %EnumVariant*, i64 }* [ %t27, %entry ], [ %t63, %loop.latch2 ]
  store { %EnumVariant*, i64 }* %t64, { %EnumVariant*, i64 }** %l6
  br label %loop.body1
loop.body1:
  %t28 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t28, %Token* %l7
  %t30 = load %Token, %Token* %l7
  %t31 = extractvalue %Token %t30, 0
  %t32 = load %Token, %Token* %l7
  %t33 = extractvalue %Token %t32, 0
  %t34 = call %EnumVariantParseResult @parse_enum_variant(%Parser %parser)
  store %EnumVariantParseResult %t34, %EnumVariantParseResult* %l8
  %t35 = load %EnumVariantParseResult, %EnumVariantParseResult* %l8
  %t36 = extractvalue %EnumVariantParseResult %t35, 2
  %t37 = load %Parser, %Parser* %l0
  %t38 = load %Token, %Token* %l1
  %t39 = load i8*, i8** %l2
  %t40 = load double, double* %l3
  %t41 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t43 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %l6
  %t44 = load %Token, %Token* %l7
  %t45 = load %EnumVariantParseResult, %EnumVariantParseResult* %l8
  br i1 %t36, label %then4, label %merge5
then4:
  %t46 = load %EnumVariantParseResult, %EnumVariantParseResult* %l8
  %t47 = extractvalue %EnumVariantParseResult %t46, 1
  %t48 = icmp ne i8* %t47, null
  %t49 = load %Parser, %Parser* %l0
  %t50 = load %Token, %Token* %l1
  %t51 = load i8*, i8** %l2
  %t52 = load double, double* %l3
  %t53 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t55 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %l6
  %t56 = load %Token, %Token* %l7
  %t57 = load %EnumVariantParseResult, %EnumVariantParseResult* %l8
  br i1 %t48, label %then6, label %merge7
then6:
  %t58 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %l6
  %t59 = load %EnumVariantParseResult, %EnumVariantParseResult* %l8
  %t60 = extractvalue %EnumVariantParseResult %t59, 1
  %t61 = call { %EnumVariant*, i64 }* @append_enum_variant({ %EnumVariant*, i64 }* %t58, %EnumVariant zeroinitializer)
  store { %EnumVariant*, i64 }* %t61, { %EnumVariant*, i64 }** %l6
  br label %merge7
merge7:
  %t62 = phi { %EnumVariant*, i64 }* [ %t61, %then6 ], [ %t55, %then4 ]
  store { %EnumVariant*, i64 }* %t62, { %EnumVariant*, i64 }** %l6
  br label %loop.latch2
merge5:
  br label %loop.latch2
loop.latch2:
  %t63 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %l6
  br label %loop.header0
afterloop3:
  %t65 = alloca %Statement
  %t66 = getelementptr inbounds %Statement, %Statement* %t65, i32 0, i32 0
  store i32 11, i32* %t66
  %t67 = load i8*, i8** %l2
  %t68 = getelementptr inbounds %Statement, %Statement* %t65, i32 0, i32 1
  %t69 = bitcast [40 x i8]* %t68 to i8*
  %t70 = bitcast i8* %t69 to i8**
  store i8* %t67, i8** %t70
  %t71 = load double, double* %l3
  %t72 = call noalias i8* @malloc(i64 8)
  %t73 = bitcast i8* %t72 to double*
  store double %t71, double* %t73
  %t74 = getelementptr inbounds %Statement, %Statement* %t65, i32 0, i32 1
  %t75 = bitcast [40 x i8]* %t74 to i8*
  %t76 = getelementptr inbounds i8, i8* %t75, i64 8
  %t77 = bitcast i8* %t76 to i8**
  store i8* %t72, i8** %t77
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t79 = getelementptr inbounds %Statement, %Statement* %t65, i32 0, i32 1
  %t80 = bitcast [40 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 16
  %t82 = bitcast i8* %t81 to { i8**, i64 }**
  store { i8**, i64 }* %t78, { i8**, i64 }** %t82
  %t83 = load { %EnumVariant*, i64 }*, { %EnumVariant*, i64 }** %l6
  %t84 = bitcast { %EnumVariant*, i64 }* %t83 to { i8**, i64 }*
  %t85 = getelementptr inbounds %Statement, %Statement* %t65, i32 0, i32 1
  %t86 = bitcast [40 x i8]* %t85 to i8*
  %t87 = getelementptr inbounds i8, i8* %t86, i64 24
  %t88 = bitcast i8* %t87 to { i8**, i64 }**
  store { i8**, i64 }* %t84, { i8**, i64 }** %t88
  %t89 = bitcast { %Decorator*, i64 }* %decorators to { i8**, i64 }*
  %t90 = getelementptr inbounds %Statement, %Statement* %t65, i32 0, i32 1
  %t91 = bitcast [40 x i8]* %t90 to i8*
  %t92 = getelementptr inbounds i8, i8* %t91, i64 32
  %t93 = bitcast i8* %t92 to { i8**, i64 }**
  store { i8**, i64 }* %t89, { i8**, i64 }** %t93
  %t94 = load %Statement, %Statement* %t65
  store %Statement %t94, %Statement* %l9
  %t95 = insertvalue %StatementParseResult undef, i8* null, 0
  %t96 = load %Statement, %Statement* %l9
  %t97 = insertvalue %StatementParseResult %t95, i8* null, 1
  ret %StatementParseResult %t97
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
  %l9 = alloca { i8**, i64 }*
  %l10 = alloca %ParameterListParseResult
  %l11 = alloca { i8**, i64 }*
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
  %t41 = insertvalue %InterfaceMemberParseResult undef, i8* null, 0
  %t42 = insertvalue %InterfaceMemberParseResult %t41, i8* null, 1
  %t43 = insertvalue %InterfaceMemberParseResult %t42, i1 0, 2
  ret %InterfaceMemberParseResult %t43
merge5:
  %t44 = load %Parser, %Parser* %l1
  %s45 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.45, i32 0, i32 0
  %t46 = call %Parser @consume_keyword(%Parser %t44, i8* %s45)
  store %Parser %t46, %Parser* %l1
  %t47 = load %Parser, %Parser* %l1
  %t48 = call %Parser @skip_trivia(%Parser %t47)
  store %Parser %t48, %Parser* %l1
  %t49 = load %Parser, %Parser* %l1
  %t50 = call %Token @parser_peek_raw(%Parser %t49)
  store %Token %t50, %Token* %l5
  %t51 = load %Token, %Token* %l5
  %t52 = extractvalue %Token %t51, 0
  %t53 = load %Token, %Token* %l5
  %t54 = call i8* @identifier_text(%Token %t53)
  store i8* %t54, i8** %l6
  %t55 = load %Token, %Token* %l5
  %t56 = alloca [1 x %Token]
  %t57 = getelementptr [1 x %Token], [1 x %Token]* %t56, i32 0, i32 0
  %t58 = getelementptr %Token, %Token* %t57, i64 0
  store %Token %t55, %Token* %t58
  %t59 = alloca { %Token*, i64 }
  %t60 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t59, i32 0, i32 0
  store %Token* %t57, %Token** %t60
  %t61 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t59, i32 0, i32 1
  store i64 1, i64* %t61
  %t62 = call double @source_span_from_tokens({ %Token*, i64 }* %t59)
  store double %t62, double* %l7
  %t63 = load %Parser, %Parser* %l1
  %t64 = call %Parser @parser_advance_raw(%Parser %t63)
  store %Parser %t64, %Parser* %l1
  %t65 = load %Parser, %Parser* %l1
  %t66 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %t65)
  store %TypeParameterParseResult %t66, %TypeParameterParseResult* %l8
  %t67 = load %TypeParameterParseResult, %TypeParameterParseResult* %l8
  %t68 = extractvalue %TypeParameterParseResult %t67, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t69 = load %TypeParameterParseResult, %TypeParameterParseResult* %l8
  %t70 = extractvalue %TypeParameterParseResult %t69, 1
  store { i8**, i64 }* %t70, { i8**, i64 }** %l9
  %t71 = load %Parser, %Parser* %l1
  %t72 = call %Parser @skip_trivia(%Parser %t71)
  store %Parser %t72, %Parser* %l1
  %t73 = load %Parser, %Parser* %l1
  %t74 = call %Parser @consume_symbol(%Parser %t73, i8* null)
  store %Parser %t74, %Parser* %l1
  %t75 = load %Parser, %Parser* %l1
  %t76 = call %ParameterListParseResult @parse_parameter_list(%Parser %t75)
  store %ParameterListParseResult %t76, %ParameterListParseResult* %l10
  %t77 = load %ParameterListParseResult, %ParameterListParseResult* %l10
  %t78 = extractvalue %ParameterListParseResult %t77, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t79 = load %ParameterListParseResult, %ParameterListParseResult* %l10
  %t80 = extractvalue %ParameterListParseResult %t79, 1
  store { i8**, i64 }* %t80, { i8**, i64 }** %l11
  %t81 = load %Parser, %Parser* %l1
  %t82 = call %Parser @skip_trivia(%Parser %t81)
  store %Parser %t82, %Parser* %l1
  store i8* null, i8** %l12
  %t83 = load %Parser, %Parser* %l1
  %t84 = call %Token @parser_peek_raw(%Parser %t83)
  store %Token %t84, %Token* %l13
  %t87 = load %Token, %Token* %l13
  %t88 = extractvalue %Token %t87, 0
  %t89 = load %Parser, %Parser* %l1
  %t90 = call %EffectParseResult @parse_effect_list(%Parser %t89)
  store %EffectParseResult %t90, %EffectParseResult* %l14
  %t91 = load %EffectParseResult, %EffectParseResult* %l14
  %t92 = extractvalue %EffectParseResult %t91, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t93 = load %EffectParseResult, %EffectParseResult* %l14
  %t94 = extractvalue %EffectParseResult %t93, 1
  store { i8**, i64 }* %t94, { i8**, i64 }** %l15
  %t95 = call double @evaluate_decorators({ %Decorator*, i64 }* %decorators)
  store double %t95, double* %l16
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t97 = load double, double* %l16
  %t98 = call double @infer_effects({ i8**, i64 }* %t96, double %t97)
  store double %t98, double* %l17
  %t99 = load %Parser, %Parser* %l1
  %t100 = call %Parser @skip_trivia(%Parser %t99)
  store %Parser %t100, %Parser* %l1
  %t101 = load %Parser, %Parser* %l1
  %t102 = extractvalue %Parser %t101, 1
  %t103 = load %Parser, %Parser* %l1
  %t104 = extractvalue %Parser %t103, 0
  %t105 = load { i8**, i64 }, { i8**, i64 }* %t104
  %t106 = extractvalue { i8**, i64 } %t105, 1
  %t107 = sitofp i64 %t106 to double
  %t108 = fcmp olt double %t102, %t107
  %t109 = load %Parser, %Parser* %l0
  %t110 = load %Parser, %Parser* %l1
  %t111 = load i1, i1* %l2
  %t112 = load %Token, %Token* %l3
  %t113 = load %Token, %Token* %l5
  %t114 = load i8*, i8** %l6
  %t115 = load double, double* %l7
  %t116 = load %TypeParameterParseResult, %TypeParameterParseResult* %l8
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t118 = load %ParameterListParseResult, %ParameterListParseResult* %l10
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t120 = load i8*, i8** %l12
  %t121 = load %Token, %Token* %l13
  %t122 = load %EffectParseResult, %EffectParseResult* %l14
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t124 = load double, double* %l16
  %t125 = load double, double* %l17
  br i1 %t108, label %then6, label %merge7
then6:
  %t126 = load %Parser, %Parser* %l1
  %t127 = call %Token @parser_peek_raw(%Parser %t126)
  store %Token %t127, %Token* %l18
  %t129 = load %Token, %Token* %l18
  %t130 = extractvalue %Token %t129, 0
  br label %merge7
merge7:
  %t131 = load i8*, i8** %l6
  %t132 = insertvalue %FunctionSignature undef, i8* %t131, 0
  %t133 = load i1, i1* %l2
  %t134 = insertvalue %FunctionSignature %t132, i1 %t133, 1
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t136 = insertvalue %FunctionSignature %t134, { i8**, i64 }* %t135, 2
  %t137 = load i8*, i8** %l12
  %t138 = insertvalue %FunctionSignature %t136, i8* %t137, 3
  %t139 = load double, double* %l17
  %t140 = insertvalue %FunctionSignature %t138, { i8**, i64 }* null, 4
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t142 = insertvalue %FunctionSignature %t140, { i8**, i64 }* %t141, 5
  %t143 = load double, double* %l7
  %t144 = insertvalue %FunctionSignature %t142, i8* null, 6
  store %FunctionSignature %t144, %FunctionSignature* %l19
  %t145 = load %Parser, %Parser* %l1
  %t146 = insertvalue %InterfaceMemberParseResult undef, i8* null, 0
  %t147 = load %FunctionSignature, %FunctionSignature* %l19
  %t148 = insertvalue %InterfaceMemberParseResult %t146, i8* null, 1
  %t149 = insertvalue %InterfaceMemberParseResult %t148, i1 1, 2
  ret %InterfaceMemberParseResult %t149
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
  %t5 = load %Token, %Token* %l2
  %t6 = call i8* @identifier_text(%Token %t5)
  store i8* %t6, i8** %l3
  %t7 = load %Token, %Token* %l2
  %t8 = alloca [1 x %Token]
  %t9 = getelementptr [1 x %Token], [1 x %Token]* %t8, i32 0, i32 0
  %t10 = getelementptr %Token, %Token* %t9, i64 0
  store %Token %t7, %Token* %t10
  %t11 = alloca { %Token*, i64 }
  %t12 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t11, i32 0, i32 0
  store %Token* %t9, %Token** %t12
  %t13 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t11, i32 0, i32 1
  store i64 1, i64* %t13
  %t14 = call double @source_span_from_tokens({ %Token*, i64 }* %t11)
  store double %t14, double* %l4
  %t15 = load %Parser, %Parser* %l1
  %t16 = call %Parser @parser_advance_raw(%Parser %t15)
  store %Parser %t16, %Parser* %l1
  %t17 = alloca [0 x %FieldDeclaration]
  %t18 = getelementptr [0 x %FieldDeclaration], [0 x %FieldDeclaration]* %t17, i32 0, i32 0
  %t19 = alloca { %FieldDeclaration*, i64 }
  %t20 = getelementptr { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %t19, i32 0, i32 0
  store %FieldDeclaration* %t18, %FieldDeclaration** %t20
  %t21 = getelementptr { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %t19, i32 0, i32 1
  store i64 0, i64* %t21
  store { %FieldDeclaration*, i64 }* %t19, { %FieldDeclaration*, i64 }** %l5
  %t22 = load %Parser, %Parser* %l1
  %t23 = call %Parser @skip_trivia(%Parser %t22)
  store %Parser %t23, %Parser* %l1
  %t24 = load %Parser, %Parser* %l1
  %t25 = call %Token @parser_peek_raw(%Parser %t24)
  store %Token %t25, %Token* %l6
  %t27 = load %Token, %Token* %l6
  %t28 = extractvalue %Token %t27, 0
  %t29 = load %Parser, %Parser* %l1
  %t30 = call %Parser @skip_trivia(%Parser %t29)
  store %Parser %t30, %Parser* %l1
  %t31 = load %Parser, %Parser* %l1
  %t32 = call %Token @parser_peek_raw(%Parser %t31)
  store %Token %t32, %Token* %l7
  %t34 = load %Token, %Token* %l7
  %t35 = extractvalue %Token %t34, 0
  %t36 = load i8*, i8** %l3
  %t37 = insertvalue %EnumVariant undef, i8* %t36, 0
  %t38 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l5
  %t39 = bitcast { %FieldDeclaration*, i64 }* %t38 to { i8**, i64 }*
  %t40 = insertvalue %EnumVariant %t37, { i8**, i64 }* %t39, 1
  %t41 = load double, double* %l4
  %t42 = insertvalue %EnumVariant %t40, i8* null, 2
  store %EnumVariant %t42, %EnumVariant* %l8
  %t43 = load %Parser, %Parser* %l1
  %t44 = insertvalue %EnumVariantParseResult undef, i8* null, 0
  %t45 = load %EnumVariant, %EnumVariant* %l8
  %t46 = insertvalue %EnumVariantParseResult %t44, i8* null, 1
  %t47 = insertvalue %EnumVariantParseResult %t46, i1 1, 2
  ret %EnumVariantParseResult %t47
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
  %l7 = alloca double
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
  %t23 = load %Token, %Token* %l3
  %t24 = call i8* @identifier_text(%Token %t23)
  store i8* %t24, i8** %l4
  %t25 = load %Token, %Token* %l3
  %t26 = alloca [1 x %Token]
  %t27 = getelementptr [1 x %Token], [1 x %Token]* %t26, i32 0, i32 0
  %t28 = getelementptr %Token, %Token* %t27, i64 0
  store %Token %t25, %Token* %t28
  %t29 = alloca { %Token*, i64 }
  %t30 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t29, i32 0, i32 0
  store %Token* %t27, %Token** %t30
  %t31 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t29, i32 0, i32 1
  store i64 1, i64* %t31
  %t32 = call double @source_span_from_tokens({ %Token*, i64 }* %t29)
  store double %t32, double* %l5
  %t33 = load %Parser, %Parser* %l0
  %t34 = call %Parser @parser_advance_raw(%Parser %t33)
  store %Parser %t34, %Parser* %l0
  %t35 = load %Parser, %Parser* %l0
  %t36 = call %Parser @skip_trivia(%Parser %t35)
  store %Parser %t36, %Parser* %l0
  %t37 = load %Parser, %Parser* %l0
  %t38 = call %Token @parser_peek_raw(%Parser %t37)
  store %Token %t38, %Token* %l6
  %t39 = load %Token, %Token* %l6
  %t40 = extractvalue %Token %t39, 0
  store double 0.0, double* %l7
  %t41 = load double, double* %l7
  %t42 = fcmp one double %t41, 0.0
  %t43 = xor i1 %t42, 1
  %t44 = load %Parser, %Parser* %l0
  %t45 = load i1, i1* %l1
  %t46 = load %Token, %Token* %l2
  %t47 = load %Token, %Token* %l3
  %t48 = load i8*, i8** %l4
  %t49 = load double, double* %l5
  %t50 = load %Token, %Token* %l6
  %t51 = load double, double* %l7
  br i1 %t43, label %then2, label %merge3
then2:
  %t52 = insertvalue %StructFieldParseResult undef, i8* null, 0
  %t53 = insertvalue %StructFieldParseResult %t52, i8* null, 1
  %t54 = insertvalue %StructFieldParseResult %t53, i1 0, 2
  ret %StructFieldParseResult %t54
merge3:
  %t55 = load %Parser, %Parser* %l0
  %t56 = call %Parser @parser_advance_raw(%Parser %t55)
  store %Parser %t56, %Parser* %l0
  %t57 = load %Parser, %Parser* %l0
  %t58 = call %Parser @skip_trivia(%Parser %t57)
  store double 0.0, double* %l8
  %t59 = load double, double* %l8
  %t60 = load double, double* %l8
  store double 0.0, double* %l9
  %t61 = load %Parser, %Parser* %l0
  %t62 = load i1, i1* %l1
  %t63 = load %Token, %Token* %l2
  %t64 = load %Token, %Token* %l3
  %t65 = load i8*, i8** %l4
  %t66 = load double, double* %l5
  %t67 = load %Token, %Token* %l6
  %t68 = load double, double* %l7
  %t69 = load double, double* %l8
  %t70 = load double, double* %l9
  br label %loop.header4
loop.header4:
  %t78 = phi double [ %t70, %entry ], [ %t77, %loop.latch6 ]
  store double %t78, double* %l9
  br label %loop.body5
loop.body5:
  %t71 = load double, double* %l9
  store double 0.0, double* %l10
  %t72 = load double, double* %l10
  %t73 = load double, double* %l9
  %t74 = load double, double* %l9
  store double 0.0, double* %l11
  %t75 = load double, double* %l11
  %t76 = call i8* @trim_text(i8* null)
  store double 0.0, double* %l9
  br label %loop.latch6
loop.latch6:
  %t77 = load double, double* %l9
  br label %loop.header4
afterloop7:
  %t79 = load double, double* %l9
  %t80 = load %Parser, %Parser* %l0
  %t81 = call %Parser @skip_trivia(%Parser %t80)
  store %Parser %t81, %Parser* %l0
  %t82 = load %Parser, %Parser* %l0
  %t83 = call %Token @parser_peek_raw(%Parser %t82)
  store %Token %t83, %Token* %l12
  %t84 = load %Token, %Token* %l12
  %t85 = extractvalue %Token %t84, 0
  %t86 = load i8*, i8** %l4
  %t87 = insertvalue %FieldDeclaration undef, i8* %t86, 0
  %t88 = load double, double* %l9
  %t89 = insertvalue %TypeAnnotation undef, i8* null, 0
  %t90 = insertvalue %FieldDeclaration %t87, i8* null, 1
  %t91 = load i1, i1* %l1
  %t92 = insertvalue %FieldDeclaration %t90, i1 %t91, 2
  %t93 = load double, double* %l5
  %t94 = insertvalue %FieldDeclaration %t92, i8* null, 3
  store %FieldDeclaration %t94, %FieldDeclaration* %l13
  %t95 = load %Parser, %Parser* %l0
  %t96 = insertvalue %StructFieldParseResult undef, i8* null, 0
  %t97 = load %FieldDeclaration, %FieldDeclaration* %l13
  %t98 = insertvalue %StructFieldParseResult %t96, i8* null, 1
  %t99 = insertvalue %StructFieldParseResult %t98, i1 1, 2
  ret %StructFieldParseResult %t99
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
  %t6 = load %Parser, %Parser* %l0
  ret %Parser %t6
}

define %StatementParseResult @parse_model(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca %CaptureResult
  %l5 = alloca i8*
  %l6 = alloca %TypeAnnotation
  %l7 = alloca %EffectParseResult
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca { %ModelProperty*, i64 }*
  %l10 = alloca %Token
  %l11 = alloca %Parser
  %l12 = alloca %ModelPropertyParseResult
  %l13 = alloca %Token
  %l14 = alloca %Statement
  store %Parser %parser, %Parser* %l0
  %t0 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t0, %Token* %l1
  %t1 = load %Token, %Token* %l1
  %t2 = call i8* @identifier_text(%Token %t1)
  store i8* %t2, i8** %l2
  %t3 = load %Token, %Token* %l1
  %t4 = alloca [1 x %Token]
  %t5 = getelementptr [1 x %Token], [1 x %Token]* %t4, i32 0, i32 0
  %t6 = getelementptr %Token, %Token* %t5, i64 0
  store %Token %t3, %Token* %t6
  %t7 = alloca { %Token*, i64 }
  %t8 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t7, i32 0, i32 0
  store %Token* %t5, %Token** %t8
  %t9 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t7, i32 0, i32 1
  store i64 1, i64* %t9
  %t10 = call double @source_span_from_tokens({ %Token*, i64 }* %t7)
  store double %t10, double* %l3
  %t11 = call %Parser @skip_trivia(%Parser %parser)
  %t12 = alloca [2 x i8]
  %t13 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  %t14 = getelementptr i8, i8* %t13, i64 0
  store i8 33, i8* %t14
  %t15 = getelementptr i8, i8* %t13, i64 1
  store i8 123, i8* %t15
  %t16 = alloca { i8*, i64 }
  %t17 = getelementptr { i8*, i64 }, { i8*, i64 }* %t16, i32 0, i32 0
  store i8* %t13, i8** %t17
  %t18 = getelementptr { i8*, i64 }, { i8*, i64 }* %t16, i32 0, i32 1
  store i64 2, i64* %t18
  %t19 = bitcast { i8*, i64 }* %t16 to { i8**, i64 }*
  %t20 = call %CaptureResult @collect_until(%Parser %t11, { i8**, i64 }* %t19)
  store %CaptureResult %t20, %CaptureResult* %l4
  %t21 = load %CaptureResult, %CaptureResult* %l4
  %t22 = extractvalue %CaptureResult %t21, 1
  %t23 = bitcast { i8**, i64 }* %t22 to { %Token*, i64 }*
  %t24 = call i8* @tokens_to_text({ %Token*, i64 }* %t23)
  %t25 = call i8* @trim_text(i8* %t24)
  store i8* %t25, i8** %l5
  %t26 = load i8*, i8** %l5
  %t27 = call i64 @sailfin_runtime_string_length(i8* %t26)
  %t28 = icmp eq i64 %t27, 0
  %t29 = load %Parser, %Parser* %l0
  %t30 = load %Token, %Token* %l1
  %t31 = load i8*, i8** %l2
  %t32 = load double, double* %l3
  %t33 = load %CaptureResult, %CaptureResult* %l4
  %t34 = load i8*, i8** %l5
  br i1 %t28, label %then0, label %merge1
then0:
  %t35 = load %Parser, %Parser* %l0
  %t36 = call %StatementParseResult @parse_unknown(%Parser %t35)
  ret %StatementParseResult %t36
merge1:
  %t37 = load i8*, i8** %l5
  %t38 = insertvalue %TypeAnnotation undef, i8* %t37, 0
  store %TypeAnnotation %t38, %TypeAnnotation* %l6
  %t39 = call %EffectParseResult @parse_effect_list(%Parser %parser)
  store %EffectParseResult %t39, %EffectParseResult* %l7
  %t40 = load %EffectParseResult, %EffectParseResult* %l7
  %t41 = extractvalue %EffectParseResult %t40, 1
  store { i8**, i64 }* %t41, { i8**, i64 }** %l8
  %t42 = alloca [0 x %ModelProperty]
  %t43 = getelementptr [0 x %ModelProperty], [0 x %ModelProperty]* %t42, i32 0, i32 0
  %t44 = alloca { %ModelProperty*, i64 }
  %t45 = getelementptr { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %t44, i32 0, i32 0
  store %ModelProperty* %t43, %ModelProperty** %t45
  %t46 = getelementptr { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %t44, i32 0, i32 1
  store i64 0, i64* %t46
  store { %ModelProperty*, i64 }* %t44, { %ModelProperty*, i64 }** %l9
  %t47 = load %Parser, %Parser* %l0
  %t48 = load %Token, %Token* %l1
  %t49 = load i8*, i8** %l2
  %t50 = load double, double* %l3
  %t51 = load %CaptureResult, %CaptureResult* %l4
  %t52 = load i8*, i8** %l5
  %t53 = load %TypeAnnotation, %TypeAnnotation* %l6
  %t54 = load %EffectParseResult, %EffectParseResult* %l7
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t56 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %l9
  br label %loop.header2
loop.header2:
  %t95 = phi { %ModelProperty*, i64 }* [ %t56, %entry ], [ %t94, %loop.latch4 ]
  store { %ModelProperty*, i64 }* %t95, { %ModelProperty*, i64 }** %l9
  br label %loop.body3
loop.body3:
  %t57 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t57, %Token* %l10
  %t59 = load %Token, %Token* %l10
  %t60 = extractvalue %Token %t59, 0
  %t61 = load %Token, %Token* %l10
  %t62 = extractvalue %Token %t61, 0
  store %Parser %parser, %Parser* %l11
  %t63 = call %ModelPropertyParseResult @parse_model_property(%Parser %parser)
  store %ModelPropertyParseResult %t63, %ModelPropertyParseResult* %l12
  %t65 = load %ModelPropertyParseResult, %ModelPropertyParseResult* %l12
  %t66 = extractvalue %ModelPropertyParseResult %t65, 2
  br label %logical_and_entry_64

logical_and_entry_64:
  br i1 %t66, label %logical_and_right_64, label %logical_and_merge_64

logical_and_right_64:
  %t67 = load %ModelPropertyParseResult, %ModelPropertyParseResult* %l12
  %t68 = extractvalue %ModelPropertyParseResult %t67, 1
  %t69 = icmp ne i8* %t68, null
  br label %logical_and_right_end_64

logical_and_right_end_64:
  br label %logical_and_merge_64

logical_and_merge_64:
  %t70 = phi i1 [ false, %logical_and_entry_64 ], [ %t69, %logical_and_right_end_64 ]
  %t71 = load %Parser, %Parser* %l0
  %t72 = load %Token, %Token* %l1
  %t73 = load i8*, i8** %l2
  %t74 = load double, double* %l3
  %t75 = load %CaptureResult, %CaptureResult* %l4
  %t76 = load i8*, i8** %l5
  %t77 = load %TypeAnnotation, %TypeAnnotation* %l6
  %t78 = load %EffectParseResult, %EffectParseResult* %l7
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t80 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %l9
  %t81 = load %Token, %Token* %l10
  %t82 = load %Parser, %Parser* %l11
  %t83 = load %ModelPropertyParseResult, %ModelPropertyParseResult* %l12
  br i1 %t70, label %then6, label %merge7
then6:
  %t84 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %l9
  %t85 = load %ModelPropertyParseResult, %ModelPropertyParseResult* %l12
  %t86 = extractvalue %ModelPropertyParseResult %t85, 1
  %t87 = call { %ModelProperty*, i64 }* @append_model_property({ %ModelProperty*, i64 }* %t84, %ModelProperty zeroinitializer)
  store { %ModelProperty*, i64 }* %t87, { %ModelProperty*, i64 }** %l9
  br label %loop.latch4
merge7:
  %t88 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t88, %Token* %l13
  %t90 = load %Token, %Token* %l13
  %t91 = extractvalue %Token %t90, 0
  %t92 = load %Token, %Token* %l13
  %t93 = extractvalue %Token %t92, 0
  br label %loop.latch4
loop.latch4:
  %t94 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %l9
  br label %loop.header2
afterloop5:
  %t96 = alloca %Statement
  %t97 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 0
  store i32 3, i32* %t97
  %t98 = load i8*, i8** %l2
  %t99 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t100 = bitcast [48 x i8]* %t99 to i8*
  %t101 = bitcast i8* %t100 to i8**
  store i8* %t98, i8** %t101
  %t102 = load double, double* %l3
  %t103 = call noalias i8* @malloc(i64 8)
  %t104 = bitcast i8* %t103 to double*
  store double %t102, double* %t104
  %t105 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t106 = bitcast [48 x i8]* %t105 to i8*
  %t107 = getelementptr inbounds i8, i8* %t106, i64 8
  %t108 = bitcast i8* %t107 to i8**
  store i8* %t103, i8** %t108
  %t109 = load %TypeAnnotation, %TypeAnnotation* %l6
  %t110 = call noalias i8* @malloc(i64 8)
  %t111 = bitcast i8* %t110 to %TypeAnnotation*
  store %TypeAnnotation %t109, %TypeAnnotation* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t113 = bitcast [48 x i8]* %t112 to i8*
  %t114 = getelementptr inbounds i8, i8* %t113, i64 16
  %t115 = bitcast i8* %t114 to i8**
  store i8* %t110, i8** %t115
  %t116 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %l9
  %t117 = bitcast { %ModelProperty*, i64 }* %t116 to { i8**, i64 }*
  %t118 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t119 = bitcast [48 x i8]* %t118 to i8*
  %t120 = getelementptr inbounds i8, i8* %t119, i64 24
  %t121 = bitcast i8* %t120 to { i8**, i64 }**
  store { i8**, i64 }* %t117, { i8**, i64 }** %t121
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t123 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t124 = bitcast [48 x i8]* %t123 to i8*
  %t125 = getelementptr inbounds i8, i8* %t124, i64 32
  %t126 = bitcast i8* %t125 to { i8**, i64 }**
  store { i8**, i64 }* %t122, { i8**, i64 }** %t126
  %t127 = bitcast { %Decorator*, i64 }* %decorators to { i8**, i64 }*
  %t128 = getelementptr inbounds %Statement, %Statement* %t96, i32 0, i32 1
  %t129 = bitcast [48 x i8]* %t128 to i8*
  %t130 = getelementptr inbounds i8, i8* %t129, i64 40
  %t131 = bitcast i8* %t130 to { i8**, i64 }**
  store { i8**, i64 }* %t127, { i8**, i64 }** %t131
  %t132 = load %Statement, %Statement* %t96
  store %Statement %t132, %Statement* %l14
  %t133 = insertvalue %StatementParseResult undef, i8* null, 0
  %t134 = load %Statement, %Statement* %l14
  %t135 = insertvalue %StatementParseResult %t133, i8* null, 1
  ret %StatementParseResult %t135
}

define %StatementParseResult @parse_pipeline(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Token
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca %TypeParameterParseResult
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca %ParameterListParseResult
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca i8*
  %l8 = alloca %Token
  %l9 = alloca %EffectParseResult
  %l10 = alloca { i8**, i64 }*
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca %BlockParseResult
  %l14 = alloca i8*
  %l15 = alloca %FunctionSignature
  %l16 = alloca %Statement
  %t0 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t0, %Token* %l0
  %t1 = load %Token, %Token* %l0
  %t2 = call i8* @identifier_text(%Token %t1)
  store i8* %t2, i8** %l1
  %t3 = load %Token, %Token* %l0
  %t4 = alloca [1 x %Token]
  %t5 = getelementptr [1 x %Token], [1 x %Token]* %t4, i32 0, i32 0
  %t6 = getelementptr %Token, %Token* %t5, i64 0
  store %Token %t3, %Token* %t6
  %t7 = alloca { %Token*, i64 }
  %t8 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t7, i32 0, i32 0
  store %Token* %t5, %Token** %t8
  %t9 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t7, i32 0, i32 1
  store i64 1, i64* %t9
  %t10 = call double @source_span_from_tokens({ %Token*, i64 }* %t7)
  store double %t10, double* %l2
  %t11 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %parser)
  store %TypeParameterParseResult %t11, %TypeParameterParseResult* %l3
  %t12 = load %TypeParameterParseResult, %TypeParameterParseResult* %l3
  %t13 = extractvalue %TypeParameterParseResult %t12, 1
  store { i8**, i64 }* %t13, { i8**, i64 }** %l4
  %t14 = call %ParameterListParseResult @parse_parameter_list(%Parser %parser)
  store %ParameterListParseResult %t14, %ParameterListParseResult* %l5
  %t15 = load %ParameterListParseResult, %ParameterListParseResult* %l5
  %t16 = extractvalue %ParameterListParseResult %t15, 1
  store { i8**, i64 }* %t16, { i8**, i64 }** %l6
  store i8* null, i8** %l7
  %t17 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t17, %Token* %l8
  %t20 = load %Token, %Token* %l8
  %t21 = extractvalue %Token %t20, 0
  %t22 = call %EffectParseResult @parse_effect_list(%Parser %parser)
  store %EffectParseResult %t22, %EffectParseResult* %l9
  %t23 = load %EffectParseResult, %EffectParseResult* %l9
  %t24 = extractvalue %EffectParseResult %t23, 1
  store { i8**, i64 }* %t24, { i8**, i64 }** %l10
  %t25 = call double @evaluate_decorators({ %Decorator*, i64 }* %decorators)
  store double %t25, double* %l11
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t27 = load double, double* %l11
  %t28 = call double @infer_effects({ i8**, i64 }* %t26, double %t27)
  store double %t28, double* %l12
  %t29 = call %BlockParseResult @parse_block(%Parser %parser)
  store %BlockParseResult %t29, %BlockParseResult* %l13
  %t30 = load %BlockParseResult, %BlockParseResult* %l13
  %t31 = extractvalue %BlockParseResult %t30, 1
  store i8* %t31, i8** %l14
  %t32 = load i8*, i8** %l1
  %t33 = insertvalue %FunctionSignature undef, i8* %t32, 0
  %t34 = insertvalue %FunctionSignature %t33, i1 0, 1
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t36 = insertvalue %FunctionSignature %t34, { i8**, i64 }* %t35, 2
  %t37 = load i8*, i8** %l7
  %t38 = insertvalue %FunctionSignature %t36, i8* %t37, 3
  %t39 = load double, double* %l12
  %t40 = insertvalue %FunctionSignature %t38, { i8**, i64 }* null, 4
  %t41 = alloca [0 x i8*]
  %t42 = getelementptr [0 x i8*], [0 x i8*]* %t41, i32 0, i32 0
  %t43 = alloca { i8**, i64 }
  %t44 = getelementptr { i8**, i64 }, { i8**, i64 }* %t43, i32 0, i32 0
  store i8** %t42, i8*** %t44
  %t45 = getelementptr { i8**, i64 }, { i8**, i64 }* %t43, i32 0, i32 1
  store i64 0, i64* %t45
  %t46 = insertvalue %FunctionSignature %t40, { i8**, i64 }* %t43, 5
  %t47 = load double, double* %l2
  %t48 = insertvalue %FunctionSignature %t46, i8* null, 6
  store %FunctionSignature %t48, %FunctionSignature* %l15
  %t49 = alloca %Statement
  %t50 = getelementptr inbounds %Statement, %Statement* %t49, i32 0, i32 0
  store i32 4, i32* %t50
  %t51 = load %FunctionSignature, %FunctionSignature* %l15
  %t52 = call noalias i8* @malloc(i64 56)
  %t53 = bitcast i8* %t52 to %FunctionSignature*
  store %FunctionSignature %t51, %FunctionSignature* %t53
  %t54 = getelementptr inbounds %Statement, %Statement* %t49, i32 0, i32 1
  %t55 = bitcast [24 x i8]* %t54 to i8*
  %t56 = bitcast i8* %t55 to i8**
  store i8* %t52, i8** %t56
  %t57 = load i8*, i8** %l14
  %t58 = getelementptr inbounds %Statement, %Statement* %t49, i32 0, i32 1
  %t59 = bitcast [24 x i8]* %t58 to i8*
  %t60 = getelementptr inbounds i8, i8* %t59, i64 8
  %t61 = bitcast i8* %t60 to i8**
  store i8* %t57, i8** %t61
  %t62 = bitcast { %Decorator*, i64 }* %decorators to { i8**, i64 }*
  %t63 = getelementptr inbounds %Statement, %Statement* %t49, i32 0, i32 1
  %t64 = bitcast [24 x i8]* %t63 to i8*
  %t65 = getelementptr inbounds i8, i8* %t64, i64 16
  %t66 = bitcast i8* %t65 to { i8**, i64 }**
  store { i8**, i64 }* %t62, { i8**, i64 }** %t66
  %t67 = load %Statement, %Statement* %t49
  store %Statement %t67, %Statement* %l16
  %t68 = insertvalue %StatementParseResult undef, i8* null, 0
  %t69 = load %Statement, %Statement* %l16
  %t70 = insertvalue %StatementParseResult %t68, i8* null, 1
  ret %StatementParseResult %t70
}

define %StatementParseResult @parse_tool(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Token
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca %ParameterListParseResult
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca i8*
  %l6 = alloca %Token
  %l7 = alloca %EffectParseResult
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca %BlockParseResult
  %l12 = alloca i8*
  %l13 = alloca %FunctionSignature
  %l14 = alloca %Statement
  %t0 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t0, %Token* %l0
  %t1 = load %Token, %Token* %l0
  %t2 = call i8* @identifier_text(%Token %t1)
  store i8* %t2, i8** %l1
  %t3 = load %Token, %Token* %l0
  %t4 = alloca [1 x %Token]
  %t5 = getelementptr [1 x %Token], [1 x %Token]* %t4, i32 0, i32 0
  %t6 = getelementptr %Token, %Token* %t5, i64 0
  store %Token %t3, %Token* %t6
  %t7 = alloca { %Token*, i64 }
  %t8 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t7, i32 0, i32 0
  store %Token* %t5, %Token** %t8
  %t9 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t7, i32 0, i32 1
  store i64 1, i64* %t9
  %t10 = call double @source_span_from_tokens({ %Token*, i64 }* %t7)
  store double %t10, double* %l2
  %t11 = call %ParameterListParseResult @parse_parameter_list(%Parser %parser)
  store %ParameterListParseResult %t11, %ParameterListParseResult* %l3
  %t12 = load %ParameterListParseResult, %ParameterListParseResult* %l3
  %t13 = extractvalue %ParameterListParseResult %t12, 1
  store { i8**, i64 }* %t13, { i8**, i64 }** %l4
  store i8* null, i8** %l5
  %t14 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t14, %Token* %l6
  %t17 = load %Token, %Token* %l6
  %t18 = extractvalue %Token %t17, 0
  %t19 = call %EffectParseResult @parse_effect_list(%Parser %parser)
  store %EffectParseResult %t19, %EffectParseResult* %l7
  %t20 = load %EffectParseResult, %EffectParseResult* %l7
  %t21 = extractvalue %EffectParseResult %t20, 1
  store { i8**, i64 }* %t21, { i8**, i64 }** %l8
  %t22 = call double @evaluate_decorators({ %Decorator*, i64 }* %decorators)
  store double %t22, double* %l9
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t24 = load double, double* %l9
  %t25 = call double @infer_effects({ i8**, i64 }* %t23, double %t24)
  store double %t25, double* %l10
  %t26 = call %BlockParseResult @parse_block(%Parser %parser)
  store %BlockParseResult %t26, %BlockParseResult* %l11
  %t27 = load %BlockParseResult, %BlockParseResult* %l11
  %t28 = extractvalue %BlockParseResult %t27, 1
  store i8* %t28, i8** %l12
  %t29 = load i8*, i8** %l1
  %t30 = insertvalue %FunctionSignature undef, i8* %t29, 0
  %t31 = insertvalue %FunctionSignature %t30, i1 0, 1
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t33 = insertvalue %FunctionSignature %t31, { i8**, i64 }* %t32, 2
  %t34 = load i8*, i8** %l5
  %t35 = insertvalue %FunctionSignature %t33, i8* %t34, 3
  %t36 = load double, double* %l10
  %t37 = insertvalue %FunctionSignature %t35, { i8**, i64 }* null, 4
  %t38 = alloca [0 x i8*]
  %t39 = getelementptr [0 x i8*], [0 x i8*]* %t38, i32 0, i32 0
  %t40 = alloca { i8**, i64 }
  %t41 = getelementptr { i8**, i64 }, { i8**, i64 }* %t40, i32 0, i32 0
  store i8** %t39, i8*** %t41
  %t42 = getelementptr { i8**, i64 }, { i8**, i64 }* %t40, i32 0, i32 1
  store i64 0, i64* %t42
  %t43 = insertvalue %FunctionSignature %t37, { i8**, i64 }* %t40, 5
  %t44 = insertvalue %FunctionSignature %t43, i8* null, 6
  store %FunctionSignature %t44, %FunctionSignature* %l13
  %t45 = alloca %Statement
  %t46 = getelementptr inbounds %Statement, %Statement* %t45, i32 0, i32 0
  store i32 5, i32* %t46
  %t47 = load %FunctionSignature, %FunctionSignature* %l13
  %t48 = call noalias i8* @malloc(i64 56)
  %t49 = bitcast i8* %t48 to %FunctionSignature*
  store %FunctionSignature %t47, %FunctionSignature* %t49
  %t50 = getelementptr inbounds %Statement, %Statement* %t45, i32 0, i32 1
  %t51 = bitcast [24 x i8]* %t50 to i8*
  %t52 = bitcast i8* %t51 to i8**
  store i8* %t48, i8** %t52
  %t53 = load i8*, i8** %l12
  %t54 = getelementptr inbounds %Statement, %Statement* %t45, i32 0, i32 1
  %t55 = bitcast [24 x i8]* %t54 to i8*
  %t56 = getelementptr inbounds i8, i8* %t55, i64 8
  %t57 = bitcast i8* %t56 to i8**
  store i8* %t53, i8** %t57
  %t58 = bitcast { %Decorator*, i64 }* %decorators to { i8**, i64 }*
  %t59 = getelementptr inbounds %Statement, %Statement* %t45, i32 0, i32 1
  %t60 = bitcast [24 x i8]* %t59 to i8*
  %t61 = getelementptr inbounds i8, i8* %t60, i64 16
  %t62 = bitcast i8* %t61 to { i8**, i64 }**
  store { i8**, i64 }* %t58, { i8**, i64 }** %t62
  %t63 = load %Statement, %Statement* %t45
  store %Statement %t63, %Statement* %l14
  %t64 = insertvalue %StatementParseResult undef, i8* null, 0
  %t65 = load %Statement, %Statement* %l14
  %t66 = insertvalue %StatementParseResult %t64, i8* null, 1
  ret %StatementParseResult %t66
}

define %StatementParseResult @parse_test(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %CaptureResult
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca %EffectParseResult
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca %BlockParseResult
  %l10 = alloca i8*
  %l11 = alloca %Statement
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  %t1 = alloca [2 x i8]
  %t2 = getelementptr [2 x i8], [2 x i8]* %t1, i32 0, i32 0
  %t3 = getelementptr i8, i8* %t2, i64 0
  store i8 33, i8* %t3
  %t4 = getelementptr i8, i8* %t2, i64 1
  store i8 123, i8* %t4
  %t5 = alloca { i8*, i64 }
  %t6 = getelementptr { i8*, i64 }, { i8*, i64 }* %t5, i32 0, i32 0
  store i8* %t2, i8** %t6
  %t7 = getelementptr { i8*, i64 }, { i8*, i64 }* %t5, i32 0, i32 1
  store i64 2, i64* %t7
  %t8 = bitcast { i8*, i64 }* %t5 to { i8**, i64 }*
  %t9 = call %CaptureResult @collect_until(%Parser %t0, { i8**, i64 }* %t8)
  store %CaptureResult %t9, %CaptureResult* %l1
  %t10 = load %CaptureResult, %CaptureResult* %l1
  %t11 = extractvalue %CaptureResult %t10, 1
  %t12 = bitcast { i8**, i64 }* %t11 to { %Token*, i64 }*
  %t13 = call i8* @tokens_to_text({ %Token*, i64 }* %t12)
  %t14 = call i8* @trim_text(i8* %t13)
  store i8* %t14, i8** %l2
  %t15 = load i8*, i8** %l2
  %t16 = call i64 @sailfin_runtime_string_length(i8* %t15)
  %t17 = icmp eq i64 %t16, 0
  %t18 = load %Parser, %Parser* %l0
  %t19 = load %CaptureResult, %CaptureResult* %l1
  %t20 = load i8*, i8** %l2
  br i1 %t17, label %then0, label %merge1
then0:
  %t21 = load %Parser, %Parser* %l0
  %t22 = call %StatementParseResult @parse_unknown(%Parser %t21)
  ret %StatementParseResult %t22
merge1:
  %t23 = load %CaptureResult, %CaptureResult* %l1
  %t24 = extractvalue %CaptureResult %t23, 1
  %t25 = bitcast { i8**, i64 }* %t24 to { %Token*, i64 }*
  %t26 = call double @source_span_from_tokens({ %Token*, i64 }* %t25)
  store double %t26, double* %l3
  %t27 = load i8*, i8** %l2
  %t28 = call i8* @normalize_test_name(i8* %t27)
  store i8* %t28, i8** %l4
  %t29 = call %EffectParseResult @parse_effect_list(%Parser %parser)
  store %EffectParseResult %t29, %EffectParseResult* %l5
  %t30 = load %EffectParseResult, %EffectParseResult* %l5
  %t31 = extractvalue %EffectParseResult %t30, 1
  store { i8**, i64 }* %t31, { i8**, i64 }** %l6
  %t32 = call double @evaluate_decorators({ %Decorator*, i64 }* %decorators)
  store double %t32, double* %l7
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t34 = load double, double* %l7
  %t35 = call double @infer_effects({ i8**, i64 }* %t33, double %t34)
  store double %t35, double* %l8
  %t36 = call %BlockParseResult @parse_block(%Parser %parser)
  store %BlockParseResult %t36, %BlockParseResult* %l9
  %t37 = load %BlockParseResult, %BlockParseResult* %l9
  %t38 = extractvalue %BlockParseResult %t37, 1
  store i8* %t38, i8** %l10
  %t39 = alloca %Statement
  %t40 = getelementptr inbounds %Statement, %Statement* %t39, i32 0, i32 0
  store i32 6, i32* %t40
  %t41 = load i8*, i8** %l4
  %t42 = getelementptr inbounds %Statement, %Statement* %t39, i32 0, i32 1
  %t43 = bitcast [40 x i8]* %t42 to i8*
  %t44 = bitcast i8* %t43 to i8**
  store i8* %t41, i8** %t44
  %t45 = load double, double* %l3
  %t46 = call noalias i8* @malloc(i64 8)
  %t47 = bitcast i8* %t46 to double*
  store double %t45, double* %t47
  %t48 = getelementptr inbounds %Statement, %Statement* %t39, i32 0, i32 1
  %t49 = bitcast [40 x i8]* %t48 to i8*
  %t50 = getelementptr inbounds i8, i8* %t49, i64 8
  %t51 = bitcast i8* %t50 to i8**
  store i8* %t46, i8** %t51
  %t52 = load i8*, i8** %l10
  %t53 = getelementptr inbounds %Statement, %Statement* %t39, i32 0, i32 1
  %t54 = bitcast [40 x i8]* %t53 to i8*
  %t55 = getelementptr inbounds i8, i8* %t54, i64 16
  %t56 = bitcast i8* %t55 to i8**
  store i8* %t52, i8** %t56
  %t57 = load double, double* %l8
  %t58 = call noalias i8* @malloc(i64 8)
  %t59 = bitcast i8* %t58 to double*
  store double %t57, double* %t59
  %t60 = bitcast i8* %t58 to { i8**, i64 }*
  %t61 = getelementptr inbounds %Statement, %Statement* %t39, i32 0, i32 1
  %t62 = bitcast [40 x i8]* %t61 to i8*
  %t63 = getelementptr inbounds i8, i8* %t62, i64 24
  %t64 = bitcast i8* %t63 to { i8**, i64 }**
  store { i8**, i64 }* %t60, { i8**, i64 }** %t64
  %t65 = bitcast { %Decorator*, i64 }* %decorators to { i8**, i64 }*
  %t66 = getelementptr inbounds %Statement, %Statement* %t39, i32 0, i32 1
  %t67 = bitcast [40 x i8]* %t66 to i8*
  %t68 = getelementptr inbounds i8, i8* %t67, i64 32
  %t69 = bitcast i8* %t68 to { i8**, i64 }**
  store { i8**, i64 }* %t65, { i8**, i64 }** %t69
  %t70 = load %Statement, %Statement* %t39
  store %Statement %t70, %Statement* %l11
  %t71 = insertvalue %StatementParseResult undef, i8* null, 0
  %t72 = load %Statement, %Statement* %l11
  %t73 = insertvalue %StatementParseResult %t71, i8* null, 1
  ret %StatementParseResult %t73
}

define %StatementParseResult @parse_function(%Parser %parser, i1 %starts_with_async, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca i1
  %l1 = alloca %Token
  %l2 = alloca %Parser
  %l3 = alloca %Token
  %l4 = alloca %Token
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca %TypeParameterParseResult
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca %ParameterListParseResult
  %l10 = alloca { i8**, i64 }*
  %l11 = alloca i8*
  %l12 = alloca %Token
  %l13 = alloca %EffectParseResult
  %l14 = alloca { i8**, i64 }*
  %l15 = alloca double
  %l16 = alloca double
  %l17 = alloca %BlockParseResult
  %l18 = alloca i8*
  %l19 = alloca %FunctionSignature
  %l20 = alloca %Statement
  store i1 0, i1* %l0
  %t0 = load i1, i1* %l0
  br i1 %starts_with_async, label %then0, label %else1
then0:
  store i1 1, i1* %l0
  br label %merge2
else1:
  %t1 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t1, %Token* %l1
  %t2 = load %Token, %Token* %l1
  %s3 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(%Token %t2, i8* %s3)
  %t5 = load i1, i1* %l0
  %t6 = load %Token, %Token* %l1
  br i1 %t4, label %then3, label %merge4
then3:
  %t7 = call %Parser @parser_advance_raw(%Parser %parser)
  %t8 = call %Parser @skip_trivia(%Parser %t7)
  store %Parser %t8, %Parser* %l2
  %t9 = load %Parser, %Parser* %l2
  %t10 = call %Token @parser_peek_raw(%Parser %t9)
  store %Token %t10, %Token* %l3
  %t11 = load %Token, %Token* %l3
  %s12 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.12, i32 0, i32 0
  %t13 = call i1 @identifier_matches(%Token %t11, i8* %s12)
  %t14 = load i1, i1* %l0
  %t15 = load %Token, %Token* %l1
  %t16 = load %Parser, %Parser* %l2
  %t17 = load %Token, %Token* %l3
  br i1 %t13, label %then5, label %merge6
then5:
  store i1 1, i1* %l0
  br label %merge6
merge6:
  %t18 = phi i1 [ 1, %then5 ], [ %t14, %then3 ]
  store i1 %t18, i1* %l0
  br label %merge4
merge4:
  %t19 = phi i1 [ 1, %then3 ], [ %t5, %else1 ]
  store i1 %t19, i1* %l0
  br label %merge2
merge2:
  %t20 = phi i1 [ 1, %then0 ], [ 1, %else1 ]
  store i1 %t20, i1* %l0
  %t21 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t21, %Token* %l4
  %t22 = load %Token, %Token* %l4
  %t23 = call i8* @identifier_text(%Token %t22)
  store i8* %t23, i8** %l5
  %t24 = load %Token, %Token* %l4
  %t25 = alloca [1 x %Token]
  %t26 = getelementptr [1 x %Token], [1 x %Token]* %t25, i32 0, i32 0
  %t27 = getelementptr %Token, %Token* %t26, i64 0
  store %Token %t24, %Token* %t27
  %t28 = alloca { %Token*, i64 }
  %t29 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t28, i32 0, i32 0
  store %Token* %t26, %Token** %t29
  %t30 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t28, i32 0, i32 1
  store i64 1, i64* %t30
  %t31 = call double @source_span_from_tokens({ %Token*, i64 }* %t28)
  store double %t31, double* %l6
  %t32 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %parser)
  store %TypeParameterParseResult %t32, %TypeParameterParseResult* %l7
  %t33 = load %TypeParameterParseResult, %TypeParameterParseResult* %l7
  %t34 = extractvalue %TypeParameterParseResult %t33, 1
  store { i8**, i64 }* %t34, { i8**, i64 }** %l8
  %t35 = call %ParameterListParseResult @parse_parameter_list(%Parser %parser)
  store %ParameterListParseResult %t35, %ParameterListParseResult* %l9
  %t36 = load %ParameterListParseResult, %ParameterListParseResult* %l9
  %t37 = extractvalue %ParameterListParseResult %t36, 1
  store { i8**, i64 }* %t37, { i8**, i64 }** %l10
  store i8* null, i8** %l11
  %t38 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t38, %Token* %l12
  %t41 = load %Token, %Token* %l12
  %t42 = extractvalue %Token %t41, 0
  %t43 = call %EffectParseResult @parse_effect_list(%Parser %parser)
  store %EffectParseResult %t43, %EffectParseResult* %l13
  %t44 = load %EffectParseResult, %EffectParseResult* %l13
  %t45 = extractvalue %EffectParseResult %t44, 1
  store { i8**, i64 }* %t45, { i8**, i64 }** %l14
  %t46 = call double @evaluate_decorators({ %Decorator*, i64 }* %decorators)
  store double %t46, double* %l15
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t48 = load double, double* %l15
  %t49 = call double @infer_effects({ i8**, i64 }* %t47, double %t48)
  store double %t49, double* %l16
  %t50 = call %BlockParseResult @parse_block(%Parser %parser)
  store %BlockParseResult %t50, %BlockParseResult* %l17
  %t51 = load %BlockParseResult, %BlockParseResult* %l17
  %t52 = extractvalue %BlockParseResult %t51, 1
  store i8* %t52, i8** %l18
  %t53 = load i8*, i8** %l5
  %t54 = insertvalue %FunctionSignature undef, i8* %t53, 0
  %t55 = load i1, i1* %l0
  %t56 = insertvalue %FunctionSignature %t54, i1 %t55, 1
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t58 = insertvalue %FunctionSignature %t56, { i8**, i64 }* %t57, 2
  %t59 = load i8*, i8** %l11
  %t60 = insertvalue %FunctionSignature %t58, i8* %t59, 3
  %t61 = load double, double* %l16
  %t62 = insertvalue %FunctionSignature %t60, { i8**, i64 }* null, 4
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t64 = insertvalue %FunctionSignature %t62, { i8**, i64 }* %t63, 5
  %t65 = load double, double* %l6
  %t66 = insertvalue %FunctionSignature %t64, i8* null, 6
  store %FunctionSignature %t66, %FunctionSignature* %l19
  %t67 = alloca %Statement
  %t68 = getelementptr inbounds %Statement, %Statement* %t67, i32 0, i32 0
  store i32 7, i32* %t68
  %t69 = load %FunctionSignature, %FunctionSignature* %l19
  %t70 = call noalias i8* @malloc(i64 56)
  %t71 = bitcast i8* %t70 to %FunctionSignature*
  store %FunctionSignature %t69, %FunctionSignature* %t71
  %t72 = getelementptr inbounds %Statement, %Statement* %t67, i32 0, i32 1
  %t73 = bitcast [24 x i8]* %t72 to i8*
  %t74 = bitcast i8* %t73 to i8**
  store i8* %t70, i8** %t74
  %t75 = load i8*, i8** %l18
  %t76 = getelementptr inbounds %Statement, %Statement* %t67, i32 0, i32 1
  %t77 = bitcast [24 x i8]* %t76 to i8*
  %t78 = getelementptr inbounds i8, i8* %t77, i64 8
  %t79 = bitcast i8* %t78 to i8**
  store i8* %t75, i8** %t79
  %t80 = bitcast { %Decorator*, i64 }* %decorators to { i8**, i64 }*
  %t81 = getelementptr inbounds %Statement, %Statement* %t67, i32 0, i32 1
  %t82 = bitcast [24 x i8]* %t81 to i8*
  %t83 = getelementptr inbounds i8, i8* %t82, i64 16
  %t84 = bitcast i8* %t83 to { i8**, i64 }**
  store { i8**, i64 }* %t80, { i8**, i64 }** %t84
  %t85 = load %Statement, %Statement* %t67
  store %Statement %t85, %Statement* %l20
  %t86 = insertvalue %StatementParseResult undef, i8* null, 0
  %t87 = load %Statement, %Statement* %l20
  %t88 = insertvalue %StatementParseResult %t86, i8* null, 1
  ret %StatementParseResult %t88
}

define %ParameterListParseResult @parse_parameter_list(%Parser %parser) {
entry:
  %l0 = alloca { %Parameter*, i64 }*
  %l1 = alloca %Token
  %l2 = alloca %ParameterParseResult
  %l3 = alloca %Token
  %t0 = alloca [0 x %Parameter]
  %t1 = getelementptr [0 x %Parameter], [0 x %Parameter]* %t0, i32 0, i32 0
  %t2 = alloca { %Parameter*, i64 }
  %t3 = getelementptr { %Parameter*, i64 }, { %Parameter*, i64 }* %t2, i32 0, i32 0
  store %Parameter* %t1, %Parameter** %t3
  %t4 = getelementptr { %Parameter*, i64 }, { %Parameter*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Parameter*, i64 }* %t2, { %Parameter*, i64 }** %l0
  %t5 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t5, %Token* %l1
  %t6 = load %Token, %Token* %l1
  %t7 = extractvalue %Token %t6, 0
  %t8 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l0
  %t9 = load %Token, %Token* %l1
  br label %loop.header0
loop.header0:
  %t24 = phi { %Parameter*, i64 }* [ %t8, %entry ], [ %t23, %loop.latch2 ]
  store { %Parameter*, i64 }* %t24, { %Parameter*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t10 = call %ParameterParseResult @parse_single_parameter(%Parser %parser)
  store %ParameterParseResult %t10, %ParameterParseResult* %l2
  %t11 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l0
  %t12 = load %ParameterParseResult, %ParameterParseResult* %l2
  %t13 = extractvalue %ParameterParseResult %t12, 1
  %t14 = call { %Parameter*, i64 }* @append_parameter({ %Parameter*, i64 }* %t11, %Parameter zeroinitializer)
  store { %Parameter*, i64 }* %t14, { %Parameter*, i64 }** %l0
  %t15 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t15, %Token* %l3
  %t17 = load %Token, %Token* %l3
  %t18 = extractvalue %Token %t17, 0
  %t19 = load %Token, %Token* %l3
  %t20 = extractvalue %Token %t19, 0
  %t21 = load %Token, %Token* %l3
  %t22 = extractvalue %Token %t21, 0
  br label %loop.latch2
loop.latch2:
  %t23 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t25 = insertvalue %ParameterListParseResult undef, i8* null, 0
  %t26 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l0
  %t27 = bitcast { %Parameter*, i64 }* %t26 to { i8**, i64 }*
  %t28 = insertvalue %ParameterListParseResult %t25, { i8**, i64 }* %t27, 1
  ret %ParameterListParseResult %t28
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
  %l7 = alloca double
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
  %t23 = load %Token, %Token* %l3
  %t24 = call i8* @identifier_text(%Token %t23)
  store i8* %t24, i8** %l4
  %t25 = load %Token, %Token* %l3
  %t26 = alloca [1 x %Token]
  %t27 = getelementptr [1 x %Token], [1 x %Token]* %t26, i32 0, i32 0
  %t28 = getelementptr %Token, %Token* %t27, i64 0
  store %Token %t25, %Token* %t28
  %t29 = alloca { %Token*, i64 }
  %t30 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t29, i32 0, i32 0
  store %Token* %t27, %Token** %t30
  %t31 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t29, i32 0, i32 1
  store i64 1, i64* %t31
  %t32 = call double @source_span_from_tokens({ %Token*, i64 }* %t29)
  store double %t32, double* %l5
  %t33 = load %Parser, %Parser* %l0
  %t34 = call %Parser @parser_advance_raw(%Parser %t33)
  store %Parser %t34, %Parser* %l0
  %t35 = load %Parser, %Parser* %l0
  %t36 = call %Parser @skip_trivia(%Parser %t35)
  store %Parser %t36, %Parser* %l0
  %t37 = load %Parser, %Parser* %l0
  %t38 = call %Token @parser_peek_raw(%Parser %t37)
  store %Token %t38, %Token* %l6
  %t39 = load %Token, %Token* %l6
  %t40 = extractvalue %Token %t39, 0
  store double 0.0, double* %l7
  %t41 = load double, double* %l7
  %t42 = fcmp one double %t41, 0.0
  %t43 = xor i1 %t42, 1
  %t44 = load %Parser, %Parser* %l0
  %t45 = load i1, i1* %l1
  %t46 = load %Token, %Token* %l2
  %t47 = load %Token, %Token* %l3
  %t48 = load i8*, i8** %l4
  %t49 = load double, double* %l5
  %t50 = load %Token, %Token* %l6
  %t51 = load double, double* %l7
  br i1 %t43, label %then2, label %merge3
then2:
  %t52 = insertvalue %StructFieldParseResult undef, i8* null, 0
  %t53 = insertvalue %StructFieldParseResult %t52, i8* null, 1
  %t54 = insertvalue %StructFieldParseResult %t53, i1 0, 2
  ret %StructFieldParseResult %t54
merge3:
  %t55 = load %Parser, %Parser* %l0
  %t56 = call %Parser @parser_advance_raw(%Parser %t55)
  store %Parser %t56, %Parser* %l0
  %t57 = load %Parser, %Parser* %l0
  %t58 = call %Parser @skip_trivia(%Parser %t57)
  %t59 = alloca [1 x i8]
  %t60 = getelementptr [1 x i8], [1 x i8]* %t59, i32 0, i32 0
  %t61 = getelementptr i8, i8* %t60, i64 0
  store i8 59, i8* %t61
  %t62 = alloca { i8*, i64 }
  %t63 = getelementptr { i8*, i64 }, { i8*, i64 }* %t62, i32 0, i32 0
  store i8* %t60, i8** %t63
  %t64 = getelementptr { i8*, i64 }, { i8*, i64 }* %t62, i32 0, i32 1
  store i64 1, i64* %t64
  %t65 = bitcast { i8*, i64 }* %t62 to { i8**, i64 }*
  %t66 = call %CaptureResult @collect_until(%Parser %t58, { i8**, i64 }* %t65)
  store %CaptureResult %t66, %CaptureResult* %l8
  %t67 = load %CaptureResult, %CaptureResult* %l8
  %t68 = extractvalue %CaptureResult %t67, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t69 = load %CaptureResult, %CaptureResult* %l8
  %t70 = extractvalue %CaptureResult %t69, 1
  %t71 = bitcast { i8**, i64 }* %t70 to { %Token*, i64 }*
  %t72 = call i8* @tokens_to_text({ %Token*, i64 }* %t71)
  %t73 = call i8* @trim_text(i8* %t72)
  store i8* %t73, i8** %l9
  %t74 = load i8*, i8** %l9
  %t75 = call i64 @sailfin_runtime_string_length(i8* %t74)
  %t76 = icmp eq i64 %t75, 0
  %t77 = load %Parser, %Parser* %l0
  %t78 = load i1, i1* %l1
  %t79 = load %Token, %Token* %l2
  %t80 = load %Token, %Token* %l3
  %t81 = load i8*, i8** %l4
  %t82 = load double, double* %l5
  %t83 = load %Token, %Token* %l6
  %t84 = load double, double* %l7
  %t85 = load %CaptureResult, %CaptureResult* %l8
  %t86 = load i8*, i8** %l9
  br i1 %t76, label %then4, label %merge5
then4:
  %t87 = insertvalue %StructFieldParseResult undef, i8* null, 0
  %t88 = insertvalue %StructFieldParseResult %t87, i8* null, 1
  %t89 = insertvalue %StructFieldParseResult %t88, i1 0, 2
  ret %StructFieldParseResult %t89
merge5:
  %t90 = load %Parser, %Parser* %l0
  %t91 = call %Parser @skip_trivia(%Parser %t90)
  store %Parser %t91, %Parser* %l0
  %t92 = load %Parser, %Parser* %l0
  %t93 = call %Token @parser_peek_raw(%Parser %t92)
  store %Token %t93, %Token* %l10
  %t95 = load %Token, %Token* %l10
  %t96 = extractvalue %Token %t95, 0
  %t97 = load %Parser, %Parser* %l0
  %t98 = call %Parser @parser_advance_raw(%Parser %t97)
  store %Parser %t98, %Parser* %l0
  %t99 = load i8*, i8** %l4
  %t100 = insertvalue %FieldDeclaration undef, i8* %t99, 0
  %t101 = load i8*, i8** %l9
  %t102 = insertvalue %TypeAnnotation undef, i8* %t101, 0
  %t103 = insertvalue %FieldDeclaration %t100, i8* null, 1
  %t104 = load i1, i1* %l1
  %t105 = insertvalue %FieldDeclaration %t103, i1 %t104, 2
  %t106 = load double, double* %l5
  %t107 = insertvalue %FieldDeclaration %t105, i8* null, 3
  store %FieldDeclaration %t107, %FieldDeclaration* %l11
  %t108 = load %Parser, %Parser* %l0
  %t109 = insertvalue %StructFieldParseResult undef, i8* null, 0
  %t110 = load %FieldDeclaration, %FieldDeclaration* %l11
  %t111 = insertvalue %StructFieldParseResult %t109, i8* null, 1
  %t112 = insertvalue %StructFieldParseResult %t111, i1 1, 2
  ret %StructFieldParseResult %t112
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
  %t5 = load %Token, %Token* %l1
  %t6 = call i8* @identifier_text(%Token %t5)
  store i8* %t6, i8** %l2
  %t7 = load %Parser, %Parser* %l0
  %t8 = call %Parser @parser_advance_raw(%Parser %t7)
  store %Parser %t8, %Parser* %l0
  %t9 = load %Parser, %Parser* %l0
  %t10 = call %Parser @skip_trivia(%Parser %t9)
  store %Parser %t10, %Parser* %l0
  %t11 = load %Parser, %Parser* %l0
  %t12 = call %Token @parser_peek_raw(%Parser %t11)
  store %Token %t12, %Token* %l3
  %t14 = load %Token, %Token* %l3
  %t15 = extractvalue %Token %t14, 0
  %t16 = load %Parser, %Parser* %l0
  %t17 = call %Parser @parser_advance_raw(%Parser %t16)
  store %Parser %t17, %Parser* %l0
  %t18 = load %Parser, %Parser* %l0
  %t19 = call %Parser @skip_trivia(%Parser %t18)
  %t20 = alloca [1 x i8]
  %t21 = getelementptr [1 x i8], [1 x i8]* %t20, i32 0, i32 0
  %t22 = getelementptr i8, i8* %t21, i64 0
  store i8 59, i8* %t22
  %t23 = alloca { i8*, i64 }
  %t24 = getelementptr { i8*, i64 }, { i8*, i64 }* %t23, i32 0, i32 0
  store i8* %t21, i8** %t24
  %t25 = getelementptr { i8*, i64 }, { i8*, i64 }* %t23, i32 0, i32 1
  store i64 1, i64* %t25
  %t26 = bitcast { i8*, i64 }* %t23 to { i8**, i64 }*
  %t27 = call %CaptureResult @collect_until(%Parser %t19, { i8**, i64 }* %t26)
  store %CaptureResult %t27, %CaptureResult* %l4
  %t28 = load %CaptureResult, %CaptureResult* %l4
  %t29 = extractvalue %CaptureResult %t28, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t30 = load %CaptureResult, %CaptureResult* %l4
  %t31 = extractvalue %CaptureResult %t30, 1
  %t32 = bitcast { i8**, i64 }* %t31 to { %Token*, i64 }*
  %t33 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t32)
  store %Expression %t33, %Expression* %l5
  %t34 = load %Parser, %Parser* %l0
  %t35 = call %Parser @skip_trivia(%Parser %t34)
  store %Parser %t35, %Parser* %l0
  %t36 = load %Parser, %Parser* %l0
  %t37 = call %Token @parser_peek_raw(%Parser %t36)
  store %Token %t37, %Token* %l6
  %t39 = load %Token, %Token* %l6
  %t40 = extractvalue %Token %t39, 0
  %t41 = load %Parser, %Parser* %l0
  %t42 = call %Parser @parser_advance_raw(%Parser %t41)
  store %Parser %t42, %Parser* %l0
  %t43 = load i8*, i8** %l2
  %t44 = insertvalue %ModelProperty undef, i8* %t43, 0
  %t45 = load %Expression, %Expression* %l5
  %t46 = insertvalue %ModelProperty %t44, i8* null, 1
  %t47 = load %Token, %Token* %l1
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
  %t55 = insertvalue %ModelProperty %t46, i8* null, 2
  store %ModelProperty %t55, %ModelProperty* %l7
  %t56 = load %Parser, %Parser* %l0
  %t57 = insertvalue %ModelPropertyParseResult undef, i8* null, 0
  %t58 = load %ModelProperty, %ModelProperty* %l7
  %t59 = insertvalue %ModelPropertyParseResult %t57, i8* null, 1
  %t60 = insertvalue %ModelPropertyParseResult %t59, i1 1, 2
  ret %ModelPropertyParseResult %t60
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
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca %ParameterListParseResult
  %l10 = alloca { i8**, i64 }*
  %l11 = alloca i8*
  %l12 = alloca %Token
  %l13 = alloca %EffectParseResult
  %l14 = alloca { i8**, i64 }*
  %l15 = alloca double
  %l16 = alloca double
  %l17 = alloca %BlockParseResult
  %l18 = alloca i8*
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
  %t37 = insertvalue %MethodParseResult undef, i8* null, 0
  %t38 = insertvalue %MethodParseResult %t37, i8* null, 1
  %t39 = insertvalue %MethodParseResult %t38, i1 0, 2
  ret %MethodParseResult %t39
merge5:
  %t40 = load %Parser, %Parser* %l0
  %s41 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.41, i32 0, i32 0
  %t42 = call %Parser @consume_keyword(%Parser %t40, i8* %s41)
  store %Parser %t42, %Parser* %l0
  %t43 = load %Parser, %Parser* %l0
  %t44 = call %Parser @skip_trivia(%Parser %t43)
  store %Parser %t44, %Parser* %l0
  %t45 = load %Parser, %Parser* %l0
  %t46 = call %Token @parser_peek_raw(%Parser %t45)
  store %Token %t46, %Token* %l4
  %t47 = load %Token, %Token* %l4
  %t48 = extractvalue %Token %t47, 0
  %t49 = load %Token, %Token* %l4
  %t50 = call i8* @identifier_text(%Token %t49)
  store i8* %t50, i8** %l5
  %t51 = load %Token, %Token* %l4
  %t52 = alloca [1 x %Token]
  %t53 = getelementptr [1 x %Token], [1 x %Token]* %t52, i32 0, i32 0
  %t54 = getelementptr %Token, %Token* %t53, i64 0
  store %Token %t51, %Token* %t54
  %t55 = alloca { %Token*, i64 }
  %t56 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t55, i32 0, i32 0
  store %Token* %t53, %Token** %t56
  %t57 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t55, i32 0, i32 1
  store i64 1, i64* %t57
  %t58 = call double @source_span_from_tokens({ %Token*, i64 }* %t55)
  store double %t58, double* %l6
  %t59 = load %Parser, %Parser* %l0
  %t60 = call %Parser @parser_advance_raw(%Parser %t59)
  store %Parser %t60, %Parser* %l0
  %t61 = load %Parser, %Parser* %l0
  %t62 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %t61)
  store %TypeParameterParseResult %t62, %TypeParameterParseResult* %l7
  %t63 = load %TypeParameterParseResult, %TypeParameterParseResult* %l7
  %t64 = extractvalue %TypeParameterParseResult %t63, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t65 = load %TypeParameterParseResult, %TypeParameterParseResult* %l7
  %t66 = extractvalue %TypeParameterParseResult %t65, 1
  store { i8**, i64 }* %t66, { i8**, i64 }** %l8
  %t67 = load %Parser, %Parser* %l0
  %t68 = call %Parser @skip_trivia(%Parser %t67)
  store %Parser %t68, %Parser* %l0
  %t69 = load %Parser, %Parser* %l0
  %t70 = call %Parser @consume_symbol(%Parser %t69, i8* null)
  store %Parser %t70, %Parser* %l0
  %t71 = load %Parser, %Parser* %l0
  %t72 = call %ParameterListParseResult @parse_parameter_list(%Parser %t71)
  store %ParameterListParseResult %t72, %ParameterListParseResult* %l9
  %t73 = load %ParameterListParseResult, %ParameterListParseResult* %l9
  %t74 = extractvalue %ParameterListParseResult %t73, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t75 = load %ParameterListParseResult, %ParameterListParseResult* %l9
  %t76 = extractvalue %ParameterListParseResult %t75, 1
  store { i8**, i64 }* %t76, { i8**, i64 }** %l10
  %t77 = load %Parser, %Parser* %l0
  %t78 = call %Parser @skip_trivia(%Parser %t77)
  store %Parser %t78, %Parser* %l0
  store i8* null, i8** %l11
  %t79 = load %Parser, %Parser* %l0
  %t80 = call %Token @parser_peek_raw(%Parser %t79)
  store %Token %t80, %Token* %l12
  %t83 = load %Token, %Token* %l12
  %t84 = extractvalue %Token %t83, 0
  %t85 = load %Parser, %Parser* %l0
  %t86 = call %EffectParseResult @parse_effect_list(%Parser %t85)
  store %EffectParseResult %t86, %EffectParseResult* %l13
  %t87 = load %EffectParseResult, %EffectParseResult* %l13
  %t88 = extractvalue %EffectParseResult %t87, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t89 = load %EffectParseResult, %EffectParseResult* %l13
  %t90 = extractvalue %EffectParseResult %t89, 1
  store { i8**, i64 }* %t90, { i8**, i64 }** %l14
  %t91 = call double @evaluate_decorators({ %Decorator*, i64 }* %decorators)
  store double %t91, double* %l15
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t93 = load double, double* %l15
  %t94 = call double @infer_effects({ i8**, i64 }* %t92, double %t93)
  store double %t94, double* %l16
  %t95 = load %Parser, %Parser* %l0
  %t96 = call %BlockParseResult @parse_block(%Parser %t95)
  store %BlockParseResult %t96, %BlockParseResult* %l17
  %t97 = load %BlockParseResult, %BlockParseResult* %l17
  %t98 = extractvalue %BlockParseResult %t97, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t99 = load %BlockParseResult, %BlockParseResult* %l17
  %t100 = extractvalue %BlockParseResult %t99, 1
  store i8* %t100, i8** %l18
  %t101 = load i8*, i8** %l5
  %t102 = insertvalue %FunctionSignature undef, i8* %t101, 0
  %t103 = load i1, i1* %l1
  %t104 = insertvalue %FunctionSignature %t102, i1 %t103, 1
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t106 = insertvalue %FunctionSignature %t104, { i8**, i64 }* %t105, 2
  %t107 = load i8*, i8** %l11
  %t108 = insertvalue %FunctionSignature %t106, i8* %t107, 3
  %t109 = load double, double* %l16
  %t110 = insertvalue %FunctionSignature %t108, { i8**, i64 }* null, 4
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t112 = insertvalue %FunctionSignature %t110, { i8**, i64 }* %t111, 5
  %t113 = load double, double* %l6
  %t114 = insertvalue %FunctionSignature %t112, i8* null, 6
  store %FunctionSignature %t114, %FunctionSignature* %l19
  %t115 = load %FunctionSignature, %FunctionSignature* %l19
  %t116 = insertvalue %MethodDeclaration undef, i8* null, 0
  %t117 = load i8*, i8** %l18
  %t118 = insertvalue %MethodDeclaration %t116, i8* %t117, 1
  %t119 = bitcast { %Decorator*, i64 }* %decorators to { i8**, i64 }*
  %t120 = insertvalue %MethodDeclaration %t118, { i8**, i64 }* %t119, 2
  store %MethodDeclaration %t120, %MethodDeclaration* %l20
  %t121 = load %Parser, %Parser* %l0
  %t122 = insertvalue %MethodParseResult undef, i8* null, 0
  %t123 = load %MethodDeclaration, %MethodDeclaration* %l20
  %t124 = insertvalue %MethodParseResult %t122, i8* null, 1
  %t125 = insertvalue %MethodParseResult %t124, i1 1, 2
  ret %MethodParseResult %t125
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
  %t48 = phi %Parser [ %t5, %entry ], [ %t46, %loop.latch2 ]
  %t49 = phi { %Decorator*, i64 }* [ %t6, %entry ], [ %t47, %loop.latch2 ]
  store %Parser %t48, %Parser* %l0
  store { %Decorator*, i64 }* %t49, { %Decorator*, i64 }** %l1
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
  %t14 = load %Parser, %Parser* %l0
  store %Parser %t14, %Parser* %l3
  %t15 = load %Parser, %Parser* %l0
  %t16 = call %Parser @parser_advance_raw(%Parser %t15)
  store %Parser %t16, %Parser* %l0
  %t17 = load %Parser, %Parser* %l0
  %t18 = call %Parser @skip_trivia(%Parser %t17)
  store %Parser %t18, %Parser* %l0
  %t19 = load %Parser, %Parser* %l0
  %t20 = call %Token @parser_peek_raw(%Parser %t19)
  store %Token %t20, %Token* %l4
  %t21 = load %Token, %Token* %l4
  %t22 = extractvalue %Token %t21, 0
  %t23 = load %Token, %Token* %l4
  %t24 = call i8* @identifier_text(%Token %t23)
  store i8* %t24, i8** %l5
  %t25 = load %Parser, %Parser* %l0
  %t26 = call %Parser @parser_advance_raw(%Parser %t25)
  store %Parser %t26, %Parser* %l0
  %t27 = load %Parser, %Parser* %l0
  %t28 = call %Parser @skip_trivia(%Parser %t27)
  store %Parser %t28, %Parser* %l0
  %t29 = alloca [0 x %DecoratorArgument]
  %t30 = getelementptr [0 x %DecoratorArgument], [0 x %DecoratorArgument]* %t29, i32 0, i32 0
  %t31 = alloca { %DecoratorArgument*, i64 }
  %t32 = getelementptr { %DecoratorArgument*, i64 }, { %DecoratorArgument*, i64 }* %t31, i32 0, i32 0
  store %DecoratorArgument* %t30, %DecoratorArgument** %t32
  %t33 = getelementptr { %DecoratorArgument*, i64 }, { %DecoratorArgument*, i64 }* %t31, i32 0, i32 1
  store i64 0, i64* %t33
  store { %DecoratorArgument*, i64 }* %t31, { %DecoratorArgument*, i64 }** %l6
  %t34 = load %Parser, %Parser* %l0
  %t35 = call %Token @parser_peek_raw(%Parser %t34)
  store %Token %t35, %Token* %l7
  %t37 = load %Token, %Token* %l7
  %t38 = extractvalue %Token %t37, 0
  %t39 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l1
  %t40 = load i8*, i8** %l5
  %t41 = insertvalue %Decorator undef, i8* %t40, 0
  %t42 = load { %DecoratorArgument*, i64 }*, { %DecoratorArgument*, i64 }** %l6
  %t43 = bitcast { %DecoratorArgument*, i64 }* %t42 to { i8**, i64 }*
  %t44 = insertvalue %Decorator %t41, { i8**, i64 }* %t43, 1
  %t45 = call { %Decorator*, i64 }* @append_decorator({ %Decorator*, i64 }* %t39, %Decorator %t44)
  store { %Decorator*, i64 }* %t45, { %Decorator*, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t46 = load %Parser, %Parser* %l0
  %t47 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t50 = load %Parser, %Parser* %l0
  %t51 = insertvalue %DecoratorParseResult undef, i8* null, 0
  %t52 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l1
  %t53 = bitcast { %Decorator*, i64 }* %t52 to { i8**, i64 }*
  %t54 = insertvalue %DecoratorParseResult %t51, { i8**, i64 }* %t53, 1
  ret %DecoratorParseResult %t54
}

define %TypeParameterParseResult @parse_type_parameter_clause(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  %l2 = alloca { %Token*, i64 }*
  %l3 = alloca double
  %l4 = alloca %Token
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca { %TypeParameter*, i64 }*
  %l7 = alloca double
  %l8 = alloca { %Token*, i64 }*
  %l9 = alloca double
  %l10 = alloca { %Token*, i64 }*
  %l11 = alloca { %Token*, i64 }*
  %l12 = alloca i8*
  %l13 = alloca i8*
  %l14 = alloca i8*
  %l15 = alloca double
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Token @parser_peek_raw(%Parser %t1)
  store %Token %t2, %Token* %l1
  %t4 = load %Token, %Token* %l1
  %t5 = extractvalue %Token %t4, 0
  %t6 = load %Parser, %Parser* %l0
  %t7 = call %Parser @parser_advance_raw(%Parser %t6)
  store %Parser %t7, %Parser* %l0
  %t8 = alloca [0 x %Token]
  %t9 = getelementptr [0 x %Token], [0 x %Token]* %t8, i32 0, i32 0
  %t10 = alloca { %Token*, i64 }
  %t11 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t10, i32 0, i32 0
  store %Token* %t9, %Token** %t11
  %t12 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { %Token*, i64 }* %t10, { %Token*, i64 }** %l2
  %t13 = sitofp i64 1 to double
  store double %t13, double* %l3
  %t14 = load %Parser, %Parser* %l0
  %t15 = load %Token, %Token* %l1
  %t16 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t17 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t31 = phi { %Token*, i64 }* [ %t16, %entry ], [ %t29, %loop.latch2 ]
  %t32 = phi %Parser [ %t14, %entry ], [ %t30, %loop.latch2 ]
  store { %Token*, i64 }* %t31, { %Token*, i64 }** %l2
  store %Parser %t32, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t18 = load %Parser, %Parser* %l0
  %t19 = call %Token @parser_peek_raw(%Parser %t18)
  store %Token %t19, %Token* %l4
  %t20 = load %Token, %Token* %l4
  %t21 = extractvalue %Token %t20, 0
  %t22 = load %Token, %Token* %l4
  %t23 = extractvalue %Token %t22, 0
  %t24 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t25 = load %Token, %Token* %l4
  %t26 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t24, %Token %t25)
  store { %Token*, i64 }* %t26, { %Token*, i64 }** %l2
  %t27 = load %Parser, %Parser* %l0
  %t28 = call %Parser @parser_advance_raw(%Parser %t27)
  store %Parser %t28, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t29 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t30 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t33 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t34 = call { i8**, i64 }* @split_token_slices_by_comma({ %Token*, i64 }* %t33)
  store { i8**, i64 }* %t34, { i8**, i64 }** %l5
  %t35 = alloca [0 x %TypeParameter]
  %t36 = getelementptr [0 x %TypeParameter], [0 x %TypeParameter]* %t35, i32 0, i32 0
  %t37 = alloca { %TypeParameter*, i64 }
  %t38 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %t37, i32 0, i32 0
  store %TypeParameter* %t36, %TypeParameter** %t38
  %t39 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %t37, i32 0, i32 1
  store i64 0, i64* %t39
  store { %TypeParameter*, i64 }* %t37, { %TypeParameter*, i64 }** %l6
  %t40 = sitofp i64 0 to double
  store double %t40, double* %l7
  %t41 = load %Parser, %Parser* %l0
  %t42 = load %Token, %Token* %l1
  %t43 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t44 = load double, double* %l3
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t46 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l6
  %t47 = load double, double* %l7
  br label %loop.header4
loop.header4:
  %t183 = phi { %TypeParameter*, i64 }* [ %t46, %entry ], [ %t181, %loop.latch6 ]
  %t184 = phi double [ %t47, %entry ], [ %t182, %loop.latch6 ]
  store { %TypeParameter*, i64 }* %t183, { %TypeParameter*, i64 }** %l6
  store double %t184, double* %l7
  br label %loop.body5
loop.body5:
  %t48 = load double, double* %l7
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t50 = load { i8**, i64 }, { i8**, i64 }* %t49
  %t51 = extractvalue { i8**, i64 } %t50, 1
  %t52 = sitofp i64 %t51 to double
  %t53 = fcmp oge double %t48, %t52
  %t54 = load %Parser, %Parser* %l0
  %t55 = load %Token, %Token* %l1
  %t56 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t57 = load double, double* %l3
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t59 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l6
  %t60 = load double, double* %l7
  br i1 %t53, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t62 = load double, double* %l7
  %t63 = fptosi double %t62 to i64
  %t64 = load { i8**, i64 }, { i8**, i64 }* %t61
  %t65 = extractvalue { i8**, i64 } %t64, 0
  %t66 = extractvalue { i8**, i64 } %t64, 1
  %t67 = icmp uge i64 %t63, %t66
  ; bounds check: %t67 (if true, out of bounds)
  %t68 = getelementptr i8*, i8** %t65, i64 %t63
  %t69 = load i8*, i8** %t68
  %t70 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* null)
  store { %Token*, i64 }* %t70, { %Token*, i64 }** %l8
  %t71 = load { %Token*, i64 }*, { %Token*, i64 }** %l8
  %t72 = load { %Token*, i64 }, { %Token*, i64 }* %t71
  %t73 = extractvalue { %Token*, i64 } %t72, 1
  %t74 = icmp sgt i64 %t73, 0
  %t75 = load %Parser, %Parser* %l0
  %t76 = load %Token, %Token* %l1
  %t77 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t78 = load double, double* %l3
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t80 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l6
  %t81 = load double, double* %l7
  %t82 = load { %Token*, i64 }*, { %Token*, i64 }** %l8
  br i1 %t74, label %then10, label %merge11
then10:
  %t83 = load { %Token*, i64 }*, { %Token*, i64 }** %l8
  %t84 = call double @find_top_level_symbol({ %Token*, i64 }* %t83, i8* null)
  store double %t84, double* %l9
  %t85 = load { %Token*, i64 }*, { %Token*, i64 }** %l8
  store { %Token*, i64 }* %t85, { %Token*, i64 }** %l10
  %t86 = alloca [0 x %Token]
  %t87 = getelementptr [0 x %Token], [0 x %Token]* %t86, i32 0, i32 0
  %t88 = alloca { %Token*, i64 }
  %t89 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t88, i32 0, i32 0
  store %Token* %t87, %Token** %t89
  %t90 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t88, i32 0, i32 1
  store i64 0, i64* %t90
  store { %Token*, i64 }* %t88, { %Token*, i64 }** %l11
  %t91 = load double, double* %l9
  %t92 = sitofp i64 -1 to double
  %t93 = fcmp une double %t91, %t92
  %t94 = load %Parser, %Parser* %l0
  %t95 = load %Token, %Token* %l1
  %t96 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t97 = load double, double* %l3
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t99 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l6
  %t100 = load double, double* %l7
  %t101 = load { %Token*, i64 }*, { %Token*, i64 }** %l8
  %t102 = load double, double* %l9
  %t103 = load { %Token*, i64 }*, { %Token*, i64 }** %l10
  %t104 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  br i1 %t93, label %then12, label %merge13
then12:
  %t105 = load { %Token*, i64 }*, { %Token*, i64 }** %l8
  %t106 = load double, double* %l9
  %t107 = sitofp i64 0 to double
  %t108 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t105, double %t107, double %t106)
  store { %Token*, i64 }* %t108, { %Token*, i64 }** %l10
  %t109 = load { %Token*, i64 }*, { %Token*, i64 }** %l8
  %t110 = load double, double* %l9
  %t111 = sitofp i64 1 to double
  %t112 = fadd double %t110, %t111
  %t113 = load { %Token*, i64 }*, { %Token*, i64 }** %l8
  %t114 = load { %Token*, i64 }, { %Token*, i64 }* %t113
  %t115 = extractvalue { %Token*, i64 } %t114, 1
  %t116 = sitofp i64 %t115 to double
  %t117 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t109, double %t112, double %t116)
  store { %Token*, i64 }* %t117, { %Token*, i64 }** %l11
  br label %merge13
merge13:
  %t118 = phi { %Token*, i64 }* [ %t108, %then12 ], [ %t103, %then10 ]
  %t119 = phi { %Token*, i64 }* [ %t117, %then12 ], [ %t104, %then10 ]
  store { %Token*, i64 }* %t118, { %Token*, i64 }** %l10
  store { %Token*, i64 }* %t119, { %Token*, i64 }** %l11
  %t120 = load { %Token*, i64 }*, { %Token*, i64 }** %l10
  %t121 = call i8* @tokens_to_text({ %Token*, i64 }* %t120)
  %t122 = call i8* @trim_text(i8* %t121)
  store i8* %t122, i8** %l12
  %t123 = load i8*, i8** %l12
  %t124 = call i64 @sailfin_runtime_string_length(i8* %t123)
  %t125 = icmp sgt i64 %t124, 0
  %t126 = load %Parser, %Parser* %l0
  %t127 = load %Token, %Token* %l1
  %t128 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t129 = load double, double* %l3
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t131 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l6
  %t132 = load double, double* %l7
  %t133 = load { %Token*, i64 }*, { %Token*, i64 }** %l8
  %t134 = load double, double* %l9
  %t135 = load { %Token*, i64 }*, { %Token*, i64 }** %l10
  %t136 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t137 = load i8*, i8** %l12
  br i1 %t125, label %then14, label %merge15
then14:
  store i8* null, i8** %l13
  %t138 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t139 = call i8* @tokens_to_text({ %Token*, i64 }* %t138)
  %t140 = call i8* @trim_text(i8* %t139)
  store i8* %t140, i8** %l14
  %t142 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t143 = load { %Token*, i64 }, { %Token*, i64 }* %t142
  %t144 = extractvalue { %Token*, i64 } %t143, 1
  %t145 = icmp sgt i64 %t144, 0
  br label %logical_and_entry_141

logical_and_entry_141:
  br i1 %t145, label %logical_and_right_141, label %logical_and_merge_141

logical_and_right_141:
  %t146 = load i8*, i8** %l14
  %t147 = call i64 @sailfin_runtime_string_length(i8* %t146)
  %t148 = icmp sgt i64 %t147, 0
  br label %logical_and_right_end_141

logical_and_right_end_141:
  br label %logical_and_merge_141

logical_and_merge_141:
  %t149 = phi i1 [ false, %logical_and_entry_141 ], [ %t148, %logical_and_right_end_141 ]
  %t150 = load %Parser, %Parser* %l0
  %t151 = load %Token, %Token* %l1
  %t152 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t153 = load double, double* %l3
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t155 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l6
  %t156 = load double, double* %l7
  %t157 = load { %Token*, i64 }*, { %Token*, i64 }** %l8
  %t158 = load double, double* %l9
  %t159 = load { %Token*, i64 }*, { %Token*, i64 }** %l10
  %t160 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t161 = load i8*, i8** %l12
  %t162 = load i8*, i8** %l13
  %t163 = load i8*, i8** %l14
  br i1 %t149, label %then16, label %merge17
then16:
  %t164 = load i8*, i8** %l14
  %t165 = insertvalue %TypeAnnotation undef, i8* %t164, 0
  store i8* null, i8** %l13
  br label %merge17
merge17:
  %t166 = phi i8* [ null, %then16 ], [ %t162, %then14 ]
  store i8* %t166, i8** %l13
  %t167 = load { %Token*, i64 }*, { %Token*, i64 }** %l10
  %t168 = call double @source_span_from_tokens({ %Token*, i64 }* %t167)
  store double %t168, double* %l15
  %t169 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l6
  %t170 = load i8*, i8** %l12
  %t171 = insertvalue %TypeParameter undef, i8* %t170, 0
  %t172 = load i8*, i8** %l13
  %t173 = insertvalue %TypeParameter %t171, i8* %t172, 1
  %t174 = load double, double* %l15
  %t175 = insertvalue %TypeParameter %t173, i8* null, 2
  br label %merge15
merge15:
  %t176 = phi { %TypeParameter*, i64 }* [ null, %then14 ], [ %t131, %then10 ]
  store { %TypeParameter*, i64 }* %t176, { %TypeParameter*, i64 }** %l6
  br label %merge11
merge11:
  %t177 = phi { %TypeParameter*, i64 }* [ null, %then10 ], [ %t80, %loop.body5 ]
  store { %TypeParameter*, i64 }* %t177, { %TypeParameter*, i64 }** %l6
  %t178 = load double, double* %l7
  %t179 = sitofp i64 1 to double
  %t180 = fadd double %t178, %t179
  store double %t180, double* %l7
  br label %loop.latch6
loop.latch6:
  %t181 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l6
  %t182 = load double, double* %l7
  br label %loop.header4
afterloop7:
  %t185 = load %Parser, %Parser* %l0
  %t186 = insertvalue %TypeParameterParseResult undef, i8* null, 0
  %t187 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l6
  %t188 = bitcast { %TypeParameter*, i64 }* %t187 to { i8**, i64 }*
  %t189 = insertvalue %TypeParameterParseResult %t186, { i8**, i64 }* %t188, 1
  ret %TypeParameterParseResult %t189
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
  %t7 = insertvalue %ImplementsParseResult undef, i8* null, 0
  %t8 = alloca [0 x i8*]
  %t9 = getelementptr [0 x i8*], [0 x i8*]* %t8, i32 0, i32 0
  %t10 = alloca { i8**, i64 }
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t9, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  %t13 = insertvalue %ImplementsParseResult %t7, { i8**, i64 }* %t10, 1
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
  %t38 = bitcast { i8**, i64 }* %t37 to { %Token*, i64 }*
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
  %t89 = insertvalue %ImplementsParseResult undef, i8* null, 0
  %t90 = load { %TypeAnnotation*, i64 }*, { %TypeAnnotation*, i64 }** %l2
  %t91 = bitcast { %TypeAnnotation*, i64 }* %t90 to { i8**, i64 }*
  %t92 = insertvalue %ImplementsParseResult %t89, { i8**, i64 }* %t91, 1
  %t93 = insertvalue %ImplementsParseResult %t92, i1 1, 2
  ret %ImplementsParseResult %t93
}

define %ParameterParseResult @parse_single_parameter(%Parser %parser) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca %Token
  %l4 = alloca %Token
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca %Token
  %l8 = alloca i8*
  %l9 = alloca %Token
  %l10 = alloca double
  %l11 = alloca { %Token*, i64 }*
  %l12 = alloca double
  %l13 = alloca %Parameter
  %t0 = extractvalue %Parser %parser, 0
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %t1 = extractvalue %Parser %parser, 1
  store double %t1, double* %l1
  store i1 0, i1* %l2
  %t2 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t2, %Token* %l3
  %t3 = load %Token, %Token* %l3
  %s4 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.4, i32 0, i32 0
  %t5 = call i1 @identifier_matches(%Token %t3, i8* %s4)
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  %t8 = load i1, i1* %l2
  %t9 = load %Token, %Token* %l3
  br i1 %t5, label %then0, label %merge1
then0:
  store i1 1, i1* %l2
  br label %merge1
merge1:
  %t10 = phi i1 [ 1, %then0 ], [ %t8, %entry ]
  store i1 %t10, i1* %l2
  %t11 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t11, %Token* %l4
  %t12 = load %Token, %Token* %l4
  %t13 = call i8* @identifier_text(%Token %t12)
  store i8* %t13, i8** %l5
  store i8* null, i8** %l6
  %t14 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t14, %Token* %l7
  %t17 = load %Token, %Token* %l7
  %t18 = extractvalue %Token %t17, 0
  store i8* null, i8** %l8
  %t19 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t19, %Token* %l9
  %t21 = load %Token, %Token* %l9
  %t22 = extractvalue %Token %t21, 0
  %t23 = extractvalue %Parser %parser, 1
  store double %t23, double* %l10
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = load double, double* %l10
  %t27 = bitcast { i8**, i64 }* %t24 to { %Token*, i64 }*
  %t28 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t27, double %t25, double %t26)
  store { %Token*, i64 }* %t28, { %Token*, i64 }** %l11
  %t29 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t30 = call double @source_span_from_tokens({ %Token*, i64 }* %t29)
  store double %t30, double* %l12
  %t31 = load i8*, i8** %l5
  %t32 = insertvalue %Parameter undef, i8* %t31, 0
  %t33 = load i8*, i8** %l6
  %t34 = insertvalue %Parameter %t32, i8* %t33, 1
  %t35 = load i8*, i8** %l8
  %t36 = insertvalue %Parameter %t34, i8* %t35, 2
  %t37 = load i1, i1* %l2
  %t38 = insertvalue %Parameter %t36, i1 %t37, 3
  %t39 = load double, double* %l12
  %t40 = insertvalue %Parameter %t38, i8* null, 4
  store %Parameter %t40, %Parameter* %l13
  %t41 = insertvalue %ParameterParseResult undef, i8* null, 0
  %t42 = load %Parameter, %Parameter* %l13
  %t43 = insertvalue %ParameterParseResult %t41, i8* null, 1
  ret %ParameterParseResult %t43
}

define %EffectParseResult @parse_effect_list(%Parser %parser) {
entry:
  %l0 = alloca %Token
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %Token
  %t0 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t0, %Token* %l0
  %t2 = load %Token, %Token* %l0
  %t3 = extractvalue %Token %t2, 0
  %t4 = alloca [0 x i8*]
  %t5 = getelementptr [0 x i8*], [0 x i8*]* %t4, i32 0, i32 0
  %t6 = alloca { i8**, i64 }
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 0
  store i8** %t5, i8*** %t7
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* %t6, { i8**, i64 }** %l1
  %t9 = load %Token, %Token* %l0
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t11 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t11, %Token* %l2
  %t13 = load %Token, %Token* %l2
  %t14 = extractvalue %Token %t13, 0
  %t15 = load %Token, %Token* %l2
  %t16 = extractvalue %Token %t15, 0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t17 = insertvalue %EffectParseResult undef, i8* null, 0
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t19 = insertvalue %EffectParseResult %t17, { i8**, i64 }* %t18, 1
  ret %EffectParseResult %t19
}

define %BlockParseResult @parse_block(%Parser %parser) {
entry:
  %l0 = alloca %Token
  %l1 = alloca double
  %l2 = alloca %Parser
  %l3 = alloca double
  %l4 = alloca { %Statement*, i64 }*
  %l5 = alloca %Token
  %l6 = alloca %BlockStatementParseResult
  %l7 = alloca double
  %l8 = alloca %StatementParseResult
  %l9 = alloca double
  %l10 = alloca { %Token*, i64 }*
  %l11 = alloca i8*
  %l12 = alloca %Block
  %t0 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t0, %Token* %l0
  %t2 = load %Token, %Token* %l0
  %t3 = extractvalue %Token %t2, 0
  %t4 = extractvalue %Parser %parser, 1
  store double %t4, double* %l1
  %t5 = call %Parser @parser_advance_raw(%Parser %parser)
  store %Parser %t5, %Parser* %l2
  %t6 = load double, double* %l1
  store double %t6, double* %l3
  %t7 = alloca [0 x %Statement]
  %t8 = getelementptr [0 x %Statement], [0 x %Statement]* %t7, i32 0, i32 0
  %t9 = alloca { %Statement*, i64 }
  %t10 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t9, i32 0, i32 0
  store %Statement* %t8, %Statement** %t10
  %t11 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %Statement*, i64 }* %t9, { %Statement*, i64 }** %l4
  %t12 = load %Token, %Token* %l0
  %t13 = load double, double* %l1
  %t14 = load %Parser, %Parser* %l2
  %t15 = load double, double* %l3
  %t16 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l4
  br label %loop.header0
loop.header0:
  %t80 = phi %Parser [ %t14, %entry ], [ %t78, %loop.latch2 ]
  %t81 = phi { %Statement*, i64 }* [ %t16, %entry ], [ %t79, %loop.latch2 ]
  store %Parser %t80, %Parser* %l2
  store { %Statement*, i64 }* %t81, { %Statement*, i64 }** %l4
  br label %loop.body1
loop.body1:
  %t17 = load %Parser, %Parser* %l2
  %t18 = call %Parser @skip_trivia(%Parser %t17)
  store %Parser %t18, %Parser* %l2
  %t19 = load %Parser, %Parser* %l2
  %t20 = call %Token @parser_peek_raw(%Parser %t19)
  store %Token %t20, %Token* %l5
  %t22 = load %Token, %Token* %l5
  %t23 = extractvalue %Token %t22, 0
  %t24 = load %Token, %Token* %l5
  %t25 = extractvalue %Token %t24, 0
  %t26 = load %Parser, %Parser* %l2
  %t27 = call %BlockStatementParseResult @parse_block_statement(%Parser %t26)
  store %BlockStatementParseResult %t27, %BlockStatementParseResult* %l6
  %t28 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t29 = extractvalue %BlockStatementParseResult %t28, 2
  %t30 = load %Token, %Token* %l0
  %t31 = load double, double* %l1
  %t32 = load %Parser, %Parser* %l2
  %t33 = load double, double* %l3
  %t34 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l4
  %t35 = load %Token, %Token* %l5
  %t36 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  br i1 %t29, label %then4, label %merge5
then4:
  %t37 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t38 = extractvalue %BlockStatementParseResult %t37, 0
  store %Parser zeroinitializer, %Parser* %l2
  %t39 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t40 = extractvalue %BlockStatementParseResult %t39, 1
  %t41 = icmp ne i8* %t40, null
  %t42 = load %Token, %Token* %l0
  %t43 = load double, double* %l1
  %t44 = load %Parser, %Parser* %l2
  %t45 = load double, double* %l3
  %t46 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l4
  %t47 = load %Token, %Token* %l5
  %t48 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  br i1 %t41, label %then6, label %merge7
then6:
  %t49 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l4
  %t50 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t51 = extractvalue %BlockStatementParseResult %t50, 1
  %t52 = call { %Statement*, i64 }* @append_statement({ %Statement*, i64 }* %t49, %Statement zeroinitializer)
  store { %Statement*, i64 }* %t52, { %Statement*, i64 }** %l4
  br label %merge7
merge7:
  %t53 = phi { %Statement*, i64 }* [ %t52, %then6 ], [ %t46, %then4 ]
  store { %Statement*, i64 }* %t53, { %Statement*, i64 }** %l4
  br label %loop.latch2
merge5:
  %t54 = load %Parser, %Parser* %l2
  %t55 = extractvalue %Parser %t54, 1
  store double %t55, double* %l7
  %t56 = load %Parser, %Parser* %l2
  %t57 = call %StatementParseResult @parse_unknown(%Parser %t56)
  store %StatementParseResult %t57, %StatementParseResult* %l8
  %t58 = load %StatementParseResult, %StatementParseResult* %l8
  %t59 = extractvalue %StatementParseResult %t58, 0
  store %Parser zeroinitializer, %Parser* %l2
  %t60 = load %StatementParseResult, %StatementParseResult* %l8
  %t61 = extractvalue %StatementParseResult %t60, 1
  %t62 = load %Parser, %Parser* %l2
  %t63 = extractvalue %Parser %t62, 1
  %t64 = load double, double* %l7
  %t65 = fcmp ole double %t63, %t64
  %t66 = load %Token, %Token* %l0
  %t67 = load double, double* %l1
  %t68 = load %Parser, %Parser* %l2
  %t69 = load double, double* %l3
  %t70 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l4
  %t71 = load %Token, %Token* %l5
  %t72 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t73 = load double, double* %l7
  %t74 = load %StatementParseResult, %StatementParseResult* %l8
  br i1 %t65, label %then8, label %merge9
then8:
  %t75 = load %Parser, %Parser* %l2
  %t76 = call %Parser @parser_advance_raw(%Parser %t75)
  store %Parser %t76, %Parser* %l2
  br label %merge9
merge9:
  %t77 = phi %Parser [ %t76, %then8 ], [ %t68, %loop.body1 ]
  store %Parser %t77, %Parser* %l2
  br label %loop.latch2
loop.latch2:
  %t78 = load %Parser, %Parser* %l2
  %t79 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l4
  br label %loop.header0
afterloop3:
  %t82 = load %Parser, %Parser* %l2
  %t83 = extractvalue %Parser %t82, 1
  store double %t83, double* %l9
  %t84 = load double, double* %l3
  %t85 = load double, double* %l1
  %t86 = fcmp ogt double %t84, %t85
  %t87 = load %Token, %Token* %l0
  %t88 = load double, double* %l1
  %t89 = load %Parser, %Parser* %l2
  %t90 = load double, double* %l3
  %t91 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l4
  %t92 = load double, double* %l9
  br i1 %t86, label %then10, label %merge11
then10:
  %t93 = load double, double* %l3
  store double %t93, double* %l9
  br label %merge11
merge11:
  %t94 = phi double [ %t93, %then10 ], [ %t92, %entry ]
  store double %t94, double* %l9
  %t95 = extractvalue %Parser %parser, 0
  %t96 = load double, double* %l1
  %t97 = load double, double* %l9
  %t98 = bitcast { i8**, i64 }* %t95 to { %Token*, i64 }*
  %t99 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t98, double %t96, double %t97)
  store { %Token*, i64 }* %t99, { %Token*, i64 }** %l10
  %t100 = load { %Token*, i64 }*, { %Token*, i64 }** %l10
  %t101 = call { %Token*, i64 }* @trim_block_tokens({ %Token*, i64 }* %t100)
  store { %Token*, i64 }* %t101, { %Token*, i64 }** %l10
  %t102 = load { %Token*, i64 }*, { %Token*, i64 }** %l10
  %t103 = call i8* @tokens_to_text({ %Token*, i64 }* %t102)
  store i8* %t103, i8** %l11
  %t104 = load { %Token*, i64 }*, { %Token*, i64 }** %l10
  %t105 = bitcast { %Token*, i64 }* %t104 to { i8**, i64 }*
  %t106 = insertvalue %Block undef, { i8**, i64 }* %t105, 0
  %t107 = load i8*, i8** %l11
  %t108 = insertvalue %Block %t106, i8* %t107, 1
  %t109 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l4
  %t110 = bitcast { %Statement*, i64 }* %t109 to { i8**, i64 }*
  %t111 = insertvalue %Block %t108, { i8**, i64 }* %t110, 2
  store %Block %t111, %Block* %l12
  %t112 = load %Parser, %Parser* %l2
  %t113 = call %Parser @skip_trivia(%Parser %t112)
  %t114 = insertvalue %BlockParseResult undef, i8* null, 0
  %t115 = load %Block, %Block* %l12
  %t116 = insertvalue %BlockParseResult %t114, i8* null, 1
  ret %BlockParseResult %t116
}

define %BlockStatementParseResult @parse_block_statement(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %DecoratorParseResult
  %l2 = alloca i8*
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca %Parser
  %l5 = alloca %Token
  %l6 = alloca %BlockStatementParseResult
  store %Parser %parser, %Parser* %l0
  %t0 = call %DecoratorParseResult @parse_decorators(%Parser %parser)
  store %DecoratorParseResult %t0, %DecoratorParseResult* %l1
  %t1 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t2 = extractvalue %DecoratorParseResult %t1, 0
  store i8* %t2, i8** %l2
  %t3 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t4 = extractvalue %DecoratorParseResult %t3, 1
  store { i8**, i64 }* %t4, { i8**, i64 }** %l3
  %t5 = load i8*, i8** %l2
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
  %t14 = load i8*, i8** %l2
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t16 = load %Parser, %Parser* %l4
  %t17 = load %Token, %Token* %l5
  br i1 %t11, label %then0, label %merge1
then0:
  %t18 = load %Parser, %Parser* %l4
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t20 = bitcast { i8**, i64 }* %t19 to { %Decorator*, i64 }*
  %t21 = call %BlockStatementParseResult @parse_for_statement(%Parser %t18, { %Decorator*, i64 }* %t20)
  ret %BlockStatementParseResult %t21
merge1:
  %t22 = load %Token, %Token* %l5
  %s23 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.23, i32 0, i32 0
  %t24 = call i1 @identifier_matches(%Token %t22, i8* %s23)
  %t25 = load %Parser, %Parser* %l0
  %t26 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t27 = load i8*, i8** %l2
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t29 = load %Parser, %Parser* %l4
  %t30 = load %Token, %Token* %l5
  br i1 %t24, label %then2, label %merge3
then2:
  %t31 = load %Parser, %Parser* %l4
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t33 = bitcast { i8**, i64 }* %t32 to { %Decorator*, i64 }*
  %t34 = call %BlockStatementParseResult @parse_loop_statement(%Parser %t31, { %Decorator*, i64 }* %t33)
  ret %BlockStatementParseResult %t34
merge3:
  %t35 = load %Token, %Token* %l5
  %s36 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.36, i32 0, i32 0
  %t37 = call i1 @identifier_matches(%Token %t35, i8* %s36)
  %t38 = load %Parser, %Parser* %l0
  %t39 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t40 = load i8*, i8** %l2
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t42 = load %Parser, %Parser* %l4
  %t43 = load %Token, %Token* %l5
  br i1 %t37, label %then4, label %merge5
then4:
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t45 = load { i8**, i64 }, { i8**, i64 }* %t44
  %t46 = extractvalue { i8**, i64 } %t45, 1
  %t47 = icmp sgt i64 %t46, 0
  %t48 = load %Parser, %Parser* %l0
  %t49 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t50 = load i8*, i8** %l2
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t52 = load %Parser, %Parser* %l4
  %t53 = load %Token, %Token* %l5
  br i1 %t47, label %then6, label %merge7
then6:
  %t54 = load %Parser, %Parser* %l0
  %t55 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t56 = insertvalue %BlockStatementParseResult %t55, i8* null, 1
  %t57 = insertvalue %BlockStatementParseResult %t56, i1 0, 2
  ret %BlockStatementParseResult %t57
merge7:
  %t58 = load %Parser, %Parser* %l4
  %t59 = call %BlockStatementParseResult @parse_break_statement(%Parser %t58)
  ret %BlockStatementParseResult %t59
merge5:
  %t60 = load %Token, %Token* %l5
  %s61 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.61, i32 0, i32 0
  %t62 = call i1 @identifier_matches(%Token %t60, i8* %s61)
  %t63 = load %Parser, %Parser* %l0
  %t64 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t65 = load i8*, i8** %l2
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t67 = load %Parser, %Parser* %l4
  %t68 = load %Token, %Token* %l5
  br i1 %t62, label %then8, label %merge9
then8:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t70 = load { i8**, i64 }, { i8**, i64 }* %t69
  %t71 = extractvalue { i8**, i64 } %t70, 1
  %t72 = icmp sgt i64 %t71, 0
  %t73 = load %Parser, %Parser* %l0
  %t74 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t75 = load i8*, i8** %l2
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t77 = load %Parser, %Parser* %l4
  %t78 = load %Token, %Token* %l5
  br i1 %t72, label %then10, label %merge11
then10:
  %t79 = load %Parser, %Parser* %l0
  %t80 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t81 = insertvalue %BlockStatementParseResult %t80, i8* null, 1
  %t82 = insertvalue %BlockStatementParseResult %t81, i1 0, 2
  ret %BlockStatementParseResult %t82
merge11:
  %t83 = load %Parser, %Parser* %l4
  %t84 = call %BlockStatementParseResult @parse_continue_statement(%Parser %t83)
  ret %BlockStatementParseResult %t84
merge9:
  %t85 = load %Token, %Token* %l5
  %s86 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.86, i32 0, i32 0
  %t87 = call i1 @identifier_matches(%Token %t85, i8* %s86)
  %t88 = load %Parser, %Parser* %l0
  %t89 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t90 = load i8*, i8** %l2
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t92 = load %Parser, %Parser* %l4
  %t93 = load %Token, %Token* %l5
  br i1 %t87, label %then12, label %merge13
then12:
  %t94 = load %Parser, %Parser* %l4
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t96 = bitcast { i8**, i64 }* %t95 to { %Decorator*, i64 }*
  %t97 = call %BlockStatementParseResult @parse_if_statement(%Parser %t94, { %Decorator*, i64 }* %t96)
  ret %BlockStatementParseResult %t97
merge13:
  %t98 = load %Token, %Token* %l5
  %s99 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.99, i32 0, i32 0
  %t100 = call i1 @identifier_matches(%Token %t98, i8* %s99)
  %t101 = load %Parser, %Parser* %l0
  %t102 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t103 = load i8*, i8** %l2
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t105 = load %Parser, %Parser* %l4
  %t106 = load %Token, %Token* %l5
  br i1 %t100, label %then14, label %merge15
then14:
  %t107 = load %Parser, %Parser* %l4
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t109 = bitcast { i8**, i64 }* %t108 to { %Decorator*, i64 }*
  %t110 = call %BlockStatementParseResult @parse_match_statement(%Parser %t107, { %Decorator*, i64 }* %t109)
  ret %BlockStatementParseResult %t110
merge15:
  %t111 = load %Token, %Token* %l5
  %s112 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.112, i32 0, i32 0
  %t113 = call i1 @identifier_matches(%Token %t111, i8* %s112)
  %t114 = load %Parser, %Parser* %l0
  %t115 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t116 = load i8*, i8** %l2
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t118 = load %Parser, %Parser* %l4
  %t119 = load %Token, %Token* %l5
  br i1 %t113, label %then16, label %merge17
then16:
  %t120 = load %Parser, %Parser* %l4
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t122 = bitcast { i8**, i64 }* %t121 to { %Decorator*, i64 }*
  %t123 = call %BlockStatementParseResult @parse_prompt_statement(%Parser %t120, { %Decorator*, i64 }* %t122)
  ret %BlockStatementParseResult %t123
merge17:
  %t124 = load %Token, %Token* %l5
  %s125 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.125, i32 0, i32 0
  %t126 = call i1 @identifier_matches(%Token %t124, i8* %s125)
  %t127 = load %Parser, %Parser* %l0
  %t128 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t129 = load i8*, i8** %l2
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t131 = load %Parser, %Parser* %l4
  %t132 = load %Token, %Token* %l5
  br i1 %t126, label %then18, label %merge19
then18:
  %t133 = load %Parser, %Parser* %l4
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t135 = bitcast { i8**, i64 }* %t134 to { %Decorator*, i64 }*
  %t136 = call %BlockStatementParseResult @parse_with_statement(%Parser %t133, { %Decorator*, i64 }* %t135)
  ret %BlockStatementParseResult %t136
merge19:
  %t137 = load %Token, %Token* %l5
  %s138 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.138, i32 0, i32 0
  %t139 = call i1 @identifier_matches(%Token %t137, i8* %s138)
  %t140 = load %Parser, %Parser* %l0
  %t141 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t142 = load i8*, i8** %l2
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t144 = load %Parser, %Parser* %l4
  %t145 = load %Token, %Token* %l5
  br i1 %t139, label %then20, label %merge21
then20:
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t147 = load { i8**, i64 }, { i8**, i64 }* %t146
  %t148 = extractvalue { i8**, i64 } %t147, 1
  %t149 = icmp sgt i64 %t148, 0
  %t150 = load %Parser, %Parser* %l0
  %t151 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t152 = load i8*, i8** %l2
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t154 = load %Parser, %Parser* %l4
  %t155 = load %Token, %Token* %l5
  br i1 %t149, label %then22, label %merge23
then22:
  %t156 = load %Parser, %Parser* %l0
  %t157 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t158 = insertvalue %BlockStatementParseResult %t157, i8* null, 1
  %t159 = insertvalue %BlockStatementParseResult %t158, i1 0, 2
  ret %BlockStatementParseResult %t159
merge23:
  %t160 = load %Parser, %Parser* %l4
  %t161 = call %BlockStatementParseResult @parse_return_statement(%Parser %t160)
  ret %BlockStatementParseResult %t161
merge21:
  %t162 = load %Parser, %Parser* %l4
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t164 = bitcast { i8**, i64 }* %t163 to { %Decorator*, i64 }*
  %t165 = call %BlockStatementParseResult @parse_expression_statement(%Parser %t162, { %Decorator*, i64 }* %t164)
  store %BlockStatementParseResult %t165, %BlockStatementParseResult* %l6
  %t166 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t167 = extractvalue %BlockStatementParseResult %t166, 2
  %t168 = load %Parser, %Parser* %l0
  %t169 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t170 = load i8*, i8** %l2
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t172 = load %Parser, %Parser* %l4
  %t173 = load %Token, %Token* %l5
  %t174 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  br i1 %t167, label %then24, label %merge25
then24:
  %t175 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  ret %BlockStatementParseResult %t175
merge25:
  %t176 = load %Parser, %Parser* %l0
  %t177 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t178 = insertvalue %BlockStatementParseResult %t177, i8* null, 1
  %t179 = insertvalue %BlockStatementParseResult %t178, i1 0, 2
  ret %BlockStatementParseResult %t179
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
  %l11 = alloca i8*
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
  %t9 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t10 = insertvalue %BlockStatementParseResult %t9, i8* null, 1
  %t11 = insertvalue %BlockStatementParseResult %t10, i1 0, 2
  ret %BlockStatementParseResult %t11
merge1:
  %t12 = load %Parser, %Parser* %l1
  %s13 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.13, i32 0, i32 0
  %t14 = call %Parser @consume_keyword(%Parser %t12, i8* %s13)
  store %Parser %t14, %Parser* %l1
  %t15 = load %Parser, %Parser* %l1
  %t16 = call %Parser @skip_trivia(%Parser %t15)
  %t17 = alloca [1 x i8]
  %t18 = getelementptr [1 x i8], [1 x i8]* %t17, i32 0, i32 0
  %t19 = getelementptr i8, i8* %t18, i64 0
  store i8 123, i8* %t19
  %t20 = alloca { i8*, i64 }
  %t21 = getelementptr { i8*, i64 }, { i8*, i64 }* %t20, i32 0, i32 0
  store i8* %t18, i8** %t21
  %t22 = getelementptr { i8*, i64 }, { i8*, i64 }* %t20, i32 0, i32 1
  store i64 1, i64* %t22
  %t23 = bitcast { i8*, i64 }* %t20 to { i8**, i64 }*
  %t24 = call %CaptureResult @collect_until(%Parser %t16, { i8**, i64 }* %t23)
  store %CaptureResult %t24, %CaptureResult* %l2
  %t25 = load %CaptureResult, %CaptureResult* %l2
  %t26 = extractvalue %CaptureResult %t25, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t27 = load %CaptureResult, %CaptureResult* %l2
  %t28 = extractvalue %CaptureResult %t27, 1
  %t29 = bitcast { i8**, i64 }* %t28 to { %Token*, i64 }*
  %t30 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t29)
  store { %Token*, i64 }* %t30, { %Token*, i64 }** %l3
  %t31 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t32 = load { %Token*, i64 }, { %Token*, i64 }* %t31
  %t33 = extractvalue { %Token*, i64 } %t32, 1
  %t34 = icmp eq i64 %t33, 0
  %t35 = load %Parser, %Parser* %l0
  %t36 = load %Parser, %Parser* %l1
  %t37 = load %CaptureResult, %CaptureResult* %l2
  %t38 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  br i1 %t34, label %then2, label %merge3
then2:
  %t39 = load %Parser, %Parser* %l0
  %t40 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t41 = insertvalue %BlockStatementParseResult %t40, i8* null, 1
  %t42 = insertvalue %BlockStatementParseResult %t41, i1 0, 2
  ret %BlockStatementParseResult %t42
merge3:
  %t43 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %s44 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.44, i32 0, i32 0
  %t45 = call double @find_top_level_identifier({ %Token*, i64 }* %t43, i8* %s44)
  store double %t45, double* %l4
  %t46 = load double, double* %l4
  %t47 = sitofp i64 -1 to double
  %t48 = fcmp oeq double %t46, %t47
  %t49 = load %Parser, %Parser* %l0
  %t50 = load %Parser, %Parser* %l1
  %t51 = load %CaptureResult, %CaptureResult* %l2
  %t52 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t53 = load double, double* %l4
  br i1 %t48, label %then4, label %merge5
then4:
  %t54 = load %Parser, %Parser* %l0
  %t55 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t56 = insertvalue %BlockStatementParseResult %t55, i8* null, 1
  %t57 = insertvalue %BlockStatementParseResult %t56, i1 0, 2
  ret %BlockStatementParseResult %t57
merge5:
  %t58 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t59 = load double, double* %l4
  %t60 = sitofp i64 0 to double
  %t61 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t58, double %t60, double %t59)
  %t62 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t61)
  store { %Token*, i64 }* %t62, { %Token*, i64 }** %l5
  %t63 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t64 = load double, double* %l4
  %t65 = sitofp i64 1 to double
  %t66 = fadd double %t64, %t65
  %t67 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t68 = load { %Token*, i64 }, { %Token*, i64 }* %t67
  %t69 = extractvalue { %Token*, i64 } %t68, 1
  %t70 = sitofp i64 %t69 to double
  %t71 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t63, double %t66, double %t70)
  %t72 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t71)
  store { %Token*, i64 }* %t72, { %Token*, i64 }** %l6
  %t74 = load { %Token*, i64 }*, { %Token*, i64 }** %l5
  %t75 = load { %Token*, i64 }, { %Token*, i64 }* %t74
  %t76 = extractvalue { %Token*, i64 } %t75, 1
  %t77 = icmp eq i64 %t76, 0
  br label %logical_or_entry_73

logical_or_entry_73:
  br i1 %t77, label %logical_or_merge_73, label %logical_or_right_73

logical_or_right_73:
  %t78 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  %t79 = load { %Token*, i64 }, { %Token*, i64 }* %t78
  %t80 = extractvalue { %Token*, i64 } %t79, 1
  %t81 = icmp eq i64 %t80, 0
  br label %logical_or_right_end_73

logical_or_right_end_73:
  br label %logical_or_merge_73

logical_or_merge_73:
  %t82 = phi i1 [ true, %logical_or_entry_73 ], [ %t81, %logical_or_right_end_73 ]
  %t83 = load %Parser, %Parser* %l0
  %t84 = load %Parser, %Parser* %l1
  %t85 = load %CaptureResult, %CaptureResult* %l2
  %t86 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t87 = load double, double* %l4
  %t88 = load { %Token*, i64 }*, { %Token*, i64 }** %l5
  %t89 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  br i1 %t82, label %then6, label %merge7
then6:
  %t90 = load %Parser, %Parser* %l0
  %t91 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t92 = insertvalue %BlockStatementParseResult %t91, i8* null, 1
  %t93 = insertvalue %BlockStatementParseResult %t92, i1 0, 2
  ret %BlockStatementParseResult %t93
merge7:
  %t94 = load { %Token*, i64 }*, { %Token*, i64 }** %l5
  %t95 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t94)
  store %Expression %t95, %Expression* %l7
  %t96 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  %t97 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t96)
  store %Expression %t97, %Expression* %l8
  %t98 = load %Expression, %Expression* %l7
  %t99 = insertvalue %ForClause undef, i8* null, 0
  %t100 = load %Expression, %Expression* %l8
  %t101 = insertvalue %ForClause %t99, i8* null, 1
  %t102 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t103 = bitcast { %Token*, i64 }* %t102 to { i8**, i64 }*
  %t104 = insertvalue %ForClause %t101, { i8**, i64 }* %t103, 2
  store %ForClause %t104, %ForClause* %l9
  %t105 = load %Parser, %Parser* %l1
  %t106 = call %BlockParseResult @parse_block(%Parser %t105)
  store %BlockParseResult %t106, %BlockParseResult* %l10
  %t107 = load %BlockParseResult, %BlockParseResult* %l10
  %t108 = extractvalue %BlockParseResult %t107, 1
  %t109 = load %BlockParseResult, %BlockParseResult* %l10
  %t110 = extractvalue %BlockParseResult %t109, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t111 = load %BlockParseResult, %BlockParseResult* %l10
  %t112 = extractvalue %BlockParseResult %t111, 1
  store i8* %t112, i8** %l11
  %t113 = load %Parser, %Parser* %l1
  %t114 = call %Parser @skip_trivia(%Parser %t113)
  store %Parser %t114, %Parser* %l1
  %t115 = load %Parser, %Parser* %l1
  %t116 = call %Token @parser_peek_raw(%Parser %t115)
  store %Token %t116, %Token* %l12
  %t118 = load %Token, %Token* %l12
  %t119 = extractvalue %Token %t118, 0
  %t120 = alloca %Statement
  %t121 = getelementptr inbounds %Statement, %Statement* %t120, i32 0, i32 0
  store i32 14, i32* %t121
  %t122 = load %ForClause, %ForClause* %l9
  %t123 = call noalias i8* @malloc(i64 24)
  %t124 = bitcast i8* %t123 to %ForClause*
  store %ForClause %t122, %ForClause* %t124
  %t125 = getelementptr inbounds %Statement, %Statement* %t120, i32 0, i32 1
  %t126 = bitcast [24 x i8]* %t125 to i8*
  %t127 = bitcast i8* %t126 to i8**
  store i8* %t123, i8** %t127
  %t128 = load i8*, i8** %l11
  %t129 = getelementptr inbounds %Statement, %Statement* %t120, i32 0, i32 1
  %t130 = bitcast [24 x i8]* %t129 to i8*
  %t131 = getelementptr inbounds i8, i8* %t130, i64 8
  %t132 = bitcast i8* %t131 to i8**
  store i8* %t128, i8** %t132
  %t133 = bitcast { %Decorator*, i64 }* %decorators to { i8**, i64 }*
  %t134 = getelementptr inbounds %Statement, %Statement* %t120, i32 0, i32 1
  %t135 = bitcast [24 x i8]* %t134 to i8*
  %t136 = getelementptr inbounds i8, i8* %t135, i64 16
  %t137 = bitcast i8* %t136 to { i8**, i64 }**
  store { i8**, i64 }* %t133, { i8**, i64 }** %t137
  %t138 = load %Statement, %Statement* %t120
  store %Statement %t138, %Statement* %l13
  %t139 = load %Parser, %Parser* %l1
  %t140 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t141 = load %Statement, %Statement* %l13
  %t142 = insertvalue %BlockStatementParseResult %t140, i8* null, 1
  %t143 = insertvalue %BlockStatementParseResult %t142, i1 1, 2
  ret %BlockStatementParseResult %t143
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
  %t9 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t10 = insertvalue %BlockStatementParseResult %t9, i8* null, 1
  %t11 = insertvalue %BlockStatementParseResult %t10, i1 0, 2
  ret %BlockStatementParseResult %t11
merge1:
  %t12 = load %Parser, %Parser* %l1
  %s13 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.13, i32 0, i32 0
  %t14 = call %Parser @consume_keyword(%Parser %t12, i8* %s13)
  store %Parser %t14, %Parser* %l1
  %t15 = load %Parser, %Parser* %l1
  %t16 = call %BlockParseResult @parse_block(%Parser %t15)
  store %BlockParseResult %t16, %BlockParseResult* %l2
  %t17 = load %BlockParseResult, %BlockParseResult* %l2
  %t18 = extractvalue %BlockParseResult %t17, 1
  %t19 = load %BlockParseResult, %BlockParseResult* %l2
  %t20 = extractvalue %BlockParseResult %t19, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t21 = load %Parser, %Parser* %l1
  %t22 = call %Parser @skip_trivia(%Parser %t21)
  store %Parser %t22, %Parser* %l1
  %t23 = load %Parser, %Parser* %l1
  %t24 = call %Token @parser_peek_raw(%Parser %t23)
  store %Token %t24, %Token* %l3
  %t26 = load %Token, %Token* %l3
  %t27 = extractvalue %Token %t26, 0
  %t28 = alloca %Statement
  %t29 = getelementptr inbounds %Statement, %Statement* %t28, i32 0, i32 0
  store i32 15, i32* %t29
  %t30 = load %BlockParseResult, %BlockParseResult* %l2
  %t31 = extractvalue %BlockParseResult %t30, 1
  %t32 = getelementptr inbounds %Statement, %Statement* %t28, i32 0, i32 1
  %t33 = bitcast [16 x i8]* %t32 to i8*
  %t34 = bitcast i8* %t33 to i8**
  store i8* %t31, i8** %t34
  %t35 = bitcast { %Decorator*, i64 }* %decorators to { i8**, i64 }*
  %t36 = getelementptr inbounds %Statement, %Statement* %t28, i32 0, i32 1
  %t37 = bitcast [16 x i8]* %t36 to i8*
  %t38 = getelementptr inbounds i8, i8* %t37, i64 8
  %t39 = bitcast i8* %t38 to { i8**, i64 }**
  store { i8**, i64 }* %t35, { i8**, i64 }** %t39
  %t40 = load %Statement, %Statement* %t28
  store %Statement %t40, %Statement* %l4
  %t41 = load %Parser, %Parser* %l1
  %t42 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t43 = load %Statement, %Statement* %l4
  %t44 = insertvalue %BlockStatementParseResult %t42, i8* null, 1
  %t45 = insertvalue %BlockStatementParseResult %t44, i1 1, 2
  ret %BlockStatementParseResult %t45
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
  %t9 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t10 = insertvalue %BlockStatementParseResult %t9, i8* null, 1
  %t11 = insertvalue %BlockStatementParseResult %t10, i1 0, 2
  ret %BlockStatementParseResult %t11
merge1:
  %t12 = load %Parser, %Parser* %l1
  %s13 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.13, i32 0, i32 0
  %t14 = call %Parser @consume_keyword(%Parser %t12, i8* %s13)
  store %Parser %t14, %Parser* %l1
  %t15 = load %Parser, %Parser* %l1
  %t16 = call %Parser @skip_trivia(%Parser %t15)
  store %Parser %t16, %Parser* %l1
  %t17 = load %Parser, %Parser* %l1
  %t18 = call %Token @parser_peek_raw(%Parser %t17)
  store %Token %t18, %Token* %l2
  %t20 = load %Token, %Token* %l2
  %t21 = extractvalue %Token %t20, 0
  %t22 = load %Parser, %Parser* %l1
  %t23 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t24 = insertvalue %Statement undef, i32 16, 0
  %t25 = insertvalue %BlockStatementParseResult %t23, i8* null, 1
  %t26 = insertvalue %BlockStatementParseResult %t25, i1 1, 2
  ret %BlockStatementParseResult %t26
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
  %t9 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t10 = insertvalue %BlockStatementParseResult %t9, i8* null, 1
  %t11 = insertvalue %BlockStatementParseResult %t10, i1 0, 2
  ret %BlockStatementParseResult %t11
merge1:
  %t12 = load %Parser, %Parser* %l1
  %s13 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.13, i32 0, i32 0
  %t14 = call %Parser @consume_keyword(%Parser %t12, i8* %s13)
  store %Parser %t14, %Parser* %l1
  %t15 = load %Parser, %Parser* %l1
  %t16 = call %Parser @skip_trivia(%Parser %t15)
  store %Parser %t16, %Parser* %l1
  %t17 = load %Parser, %Parser* %l1
  %t18 = call %Token @parser_peek_raw(%Parser %t17)
  store %Token %t18, %Token* %l2
  %t20 = load %Token, %Token* %l2
  %t21 = extractvalue %Token %t20, 0
  %t22 = load %Parser, %Parser* %l1
  %t23 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t24 = insertvalue %Statement undef, i32 17, 0
  %t25 = insertvalue %BlockStatementParseResult %t23, i8* null, 1
  %t26 = insertvalue %BlockStatementParseResult %t25, i1 1, 2
  ret %BlockStatementParseResult %t26
}

define %BlockStatementParseResult @parse_if_statement(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %CaptureResult
  %l3 = alloca { %Token*, i64 }*
  %l4 = alloca %Expression
  %l5 = alloca %BlockParseResult
  %l6 = alloca i8*
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
  %t9 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t10 = insertvalue %BlockStatementParseResult %t9, i8* null, 1
  %t11 = insertvalue %BlockStatementParseResult %t10, i1 0, 2
  ret %BlockStatementParseResult %t11
merge1:
  %t12 = load %Parser, %Parser* %l1
  %s13 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.13, i32 0, i32 0
  %t14 = call %Parser @consume_keyword(%Parser %t12, i8* %s13)
  store %Parser %t14, %Parser* %l1
  %t15 = load %Parser, %Parser* %l1
  %t16 = call %Parser @skip_trivia(%Parser %t15)
  %t17 = alloca [1 x i8]
  %t18 = getelementptr [1 x i8], [1 x i8]* %t17, i32 0, i32 0
  %t19 = getelementptr i8, i8* %t18, i64 0
  store i8 123, i8* %t19
  %t20 = alloca { i8*, i64 }
  %t21 = getelementptr { i8*, i64 }, { i8*, i64 }* %t20, i32 0, i32 0
  store i8* %t18, i8** %t21
  %t22 = getelementptr { i8*, i64 }, { i8*, i64 }* %t20, i32 0, i32 1
  store i64 1, i64* %t22
  %t23 = bitcast { i8*, i64 }* %t20 to { i8**, i64 }*
  %t24 = call %CaptureResult @collect_until(%Parser %t16, { i8**, i64 }* %t23)
  store %CaptureResult %t24, %CaptureResult* %l2
  %t25 = load %CaptureResult, %CaptureResult* %l2
  %t26 = extractvalue %CaptureResult %t25, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t27 = load %CaptureResult, %CaptureResult* %l2
  %t28 = extractvalue %CaptureResult %t27, 1
  %t29 = bitcast { i8**, i64 }* %t28 to { %Token*, i64 }*
  %t30 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t29)
  store { %Token*, i64 }* %t30, { %Token*, i64 }** %l3
  %t31 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t32 = load { %Token*, i64 }, { %Token*, i64 }* %t31
  %t33 = extractvalue { %Token*, i64 } %t32, 1
  %t34 = icmp eq i64 %t33, 0
  %t35 = load %Parser, %Parser* %l0
  %t36 = load %Parser, %Parser* %l1
  %t37 = load %CaptureResult, %CaptureResult* %l2
  %t38 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  br i1 %t34, label %then2, label %merge3
then2:
  %t39 = load %Parser, %Parser* %l0
  %t40 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t41 = insertvalue %BlockStatementParseResult %t40, i8* null, 1
  %t42 = insertvalue %BlockStatementParseResult %t41, i1 0, 2
  ret %BlockStatementParseResult %t42
merge3:
  %t43 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t44 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t43)
  store %Expression %t44, %Expression* %l4
  %t45 = load %Parser, %Parser* %l1
  %t46 = call %BlockParseResult @parse_block(%Parser %t45)
  store %BlockParseResult %t46, %BlockParseResult* %l5
  %t47 = load %BlockParseResult, %BlockParseResult* %l5
  %t48 = extractvalue %BlockParseResult %t47, 1
  %t49 = load %BlockParseResult, %BlockParseResult* %l5
  %t50 = extractvalue %BlockParseResult %t49, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t51 = load %BlockParseResult, %BlockParseResult* %l5
  %t52 = extractvalue %BlockParseResult %t51, 1
  store i8* %t52, i8** %l6
  %t53 = load %Parser, %Parser* %l1
  %t54 = call %Parser @skip_trivia(%Parser %t53)
  store %Parser %t54, %Parser* %l1
  store i8* null, i8** %l7
  %t55 = load %Parser, %Parser* %l1
  %t56 = call %Token @parser_peek_raw(%Parser %t55)
  %s57 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.57, i32 0, i32 0
  %t58 = call i1 @identifier_matches(%Token %t56, i8* %s57)
  %t59 = load %Parser, %Parser* %l0
  %t60 = load %Parser, %Parser* %l1
  %t61 = load %CaptureResult, %CaptureResult* %l2
  %t62 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t63 = load %Expression, %Expression* %l4
  %t64 = load %BlockParseResult, %BlockParseResult* %l5
  %t65 = load i8*, i8** %l6
  %t66 = load i8*, i8** %l7
  br i1 %t58, label %then4, label %merge5
then4:
  %t67 = load %Parser, %Parser* %l1
  %s68 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.68, i32 0, i32 0
  %t69 = call %Parser @consume_keyword(%Parser %t67, i8* %s68)
  store %Parser %t69, %Parser* %l1
  %t70 = load %Parser, %Parser* %l1
  %t71 = call %Parser @skip_trivia(%Parser %t70)
  store %Parser %t71, %Parser* %l1
  %t72 = load %Parser, %Parser* %l1
  %t73 = call %Token @parser_peek_raw(%Parser %t72)
  store %Token %t73, %Token* %l8
  %t74 = load %Token, %Token* %l8
  %s75 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.75, i32 0, i32 0
  %t76 = call i1 @identifier_matches(%Token %t74, i8* %s75)
  %t77 = load %Parser, %Parser* %l0
  %t78 = load %Parser, %Parser* %l1
  %t79 = load %CaptureResult, %CaptureResult* %l2
  %t80 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t81 = load %Expression, %Expression* %l4
  %t82 = load %BlockParseResult, %BlockParseResult* %l5
  %t83 = load i8*, i8** %l6
  %t84 = load i8*, i8** %l7
  %t85 = load %Token, %Token* %l8
  br i1 %t76, label %then6, label %else7
then6:
  %t86 = load %Parser, %Parser* %l1
  %t87 = alloca [0 x double]
  %t88 = getelementptr [0 x double], [0 x double]* %t87, i32 0, i32 0
  %t89 = alloca { double*, i64 }
  %t90 = getelementptr { double*, i64 }, { double*, i64 }* %t89, i32 0, i32 0
  store double* %t88, double** %t90
  %t91 = getelementptr { double*, i64 }, { double*, i64 }* %t89, i32 0, i32 1
  store i64 0, i64* %t91
  %t92 = bitcast { double*, i64 }* %t89 to { %Decorator*, i64 }*
  %t93 = call %BlockStatementParseResult @parse_if_statement(%Parser %t86, { %Decorator*, i64 }* %t92)
  store %BlockStatementParseResult %t93, %BlockStatementParseResult* %l9
  %t94 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  %t95 = extractvalue %BlockStatementParseResult %t94, 2
  %t96 = xor i1 %t95, 1
  %t97 = load %Parser, %Parser* %l0
  %t98 = load %Parser, %Parser* %l1
  %t99 = load %CaptureResult, %CaptureResult* %l2
  %t100 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t101 = load %Expression, %Expression* %l4
  %t102 = load %BlockParseResult, %BlockParseResult* %l5
  %t103 = load i8*, i8** %l6
  %t104 = load i8*, i8** %l7
  %t105 = load %Token, %Token* %l8
  %t106 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  br i1 %t96, label %then9, label %merge10
then9:
  %t107 = load %Parser, %Parser* %l0
  %t108 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t109 = insertvalue %BlockStatementParseResult %t108, i8* null, 1
  %t110 = insertvalue %BlockStatementParseResult %t109, i1 0, 2
  ret %BlockStatementParseResult %t110
merge10:
  %t111 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  %t112 = extractvalue %BlockStatementParseResult %t111, 1
  %t113 = icmp eq i8* %t112, null
  %t114 = load %Parser, %Parser* %l0
  %t115 = load %Parser, %Parser* %l1
  %t116 = load %CaptureResult, %CaptureResult* %l2
  %t117 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t118 = load %Expression, %Expression* %l4
  %t119 = load %BlockParseResult, %BlockParseResult* %l5
  %t120 = load i8*, i8** %l6
  %t121 = load i8*, i8** %l7
  %t122 = load %Token, %Token* %l8
  %t123 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  br i1 %t113, label %then11, label %merge12
then11:
  %t124 = load %Parser, %Parser* %l0
  %t125 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t126 = insertvalue %BlockStatementParseResult %t125, i8* null, 1
  %t127 = insertvalue %BlockStatementParseResult %t126, i1 0, 2
  ret %BlockStatementParseResult %t127
merge12:
  %t128 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  %t129 = extractvalue %BlockStatementParseResult %t128, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t130 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  %t131 = extractvalue %BlockStatementParseResult %t130, 1
  %t132 = insertvalue %ElseBranch undef, i8* %t131, 0
  %t133 = insertvalue %ElseBranch %t132, i8* null, 1
  store i8* null, i8** %l7
  br label %merge8
else7:
  %t134 = load %Parser, %Parser* %l1
  %t135 = call %BlockParseResult @parse_block(%Parser %t134)
  store %BlockParseResult %t135, %BlockParseResult* %l10
  %t136 = load %BlockParseResult, %BlockParseResult* %l10
  %t137 = extractvalue %BlockParseResult %t136, 1
  %t138 = load %BlockParseResult, %BlockParseResult* %l10
  %t139 = extractvalue %BlockParseResult %t138, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t140 = insertvalue %ElseBranch undef, i8* null, 0
  %t141 = load %BlockParseResult, %BlockParseResult* %l10
  %t142 = extractvalue %BlockParseResult %t141, 1
  %t143 = insertvalue %ElseBranch %t140, i8* %t142, 1
  store i8* null, i8** %l7
  br label %merge8
merge8:
  %t144 = phi %Parser [ zeroinitializer, %then6 ], [ zeroinitializer, %else7 ]
  %t145 = phi i8* [ null, %then6 ], [ null, %else7 ]
  store %Parser %t144, %Parser* %l1
  store i8* %t145, i8** %l7
  %t146 = load %Parser, %Parser* %l1
  %t147 = call %Parser @skip_trivia(%Parser %t146)
  store %Parser %t147, %Parser* %l1
  %t148 = load %Parser, %Parser* %l1
  %t149 = call %Token @parser_peek_raw(%Parser %t148)
  store %Token %t149, %Token* %l11
  %t151 = load %Token, %Token* %l11
  %t152 = extractvalue %Token %t151, 0
  br label %merge5
merge5:
  %t153 = phi %Parser [ %t69, %then4 ], [ %t60, %entry ]
  %t154 = phi %Parser [ %t71, %then4 ], [ %t60, %entry ]
  %t155 = phi %Parser [ zeroinitializer, %then4 ], [ %t60, %entry ]
  %t156 = phi i8* [ null, %then4 ], [ %t66, %entry ]
  %t157 = phi %Parser [ zeroinitializer, %then4 ], [ %t60, %entry ]
  %t158 = phi i8* [ null, %then4 ], [ %t66, %entry ]
  %t159 = phi %Parser [ %t147, %then4 ], [ %t60, %entry ]
  store %Parser %t153, %Parser* %l1
  store %Parser %t154, %Parser* %l1
  store %Parser %t155, %Parser* %l1
  store i8* %t156, i8** %l7
  store %Parser %t157, %Parser* %l1
  store i8* %t158, i8** %l7
  store %Parser %t159, %Parser* %l1
  %t160 = alloca %Statement
  %t161 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 0
  store i32 19, i32* %t161
  %t162 = load %Expression, %Expression* %l4
  %t163 = call noalias i8* @malloc(i64 32)
  %t164 = bitcast i8* %t163 to %Expression*
  store %Expression %t162, %Expression* %t164
  %t165 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t166 = bitcast [32 x i8]* %t165 to i8*
  %t167 = bitcast i8* %t166 to i8**
  store i8* %t163, i8** %t167
  %t168 = load i8*, i8** %l6
  %t169 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t170 = bitcast [32 x i8]* %t169 to i8*
  %t171 = getelementptr inbounds i8, i8* %t170, i64 8
  %t172 = bitcast i8* %t171 to i8**
  store i8* %t168, i8** %t172
  %t173 = load i8*, i8** %l7
  %t174 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t175 = bitcast [32 x i8]* %t174 to i8*
  %t176 = getelementptr inbounds i8, i8* %t175, i64 16
  %t177 = bitcast i8* %t176 to i8**
  store i8* %t173, i8** %t177
  %t178 = bitcast { %Decorator*, i64 }* %decorators to { i8**, i64 }*
  %t179 = getelementptr inbounds %Statement, %Statement* %t160, i32 0, i32 1
  %t180 = bitcast [32 x i8]* %t179 to i8*
  %t181 = getelementptr inbounds i8, i8* %t180, i64 24
  %t182 = bitcast i8* %t181 to { i8**, i64 }**
  store { i8**, i64 }* %t178, { i8**, i64 }** %t182
  %t183 = load %Statement, %Statement* %t160
  store %Statement %t183, %Statement* %l12
  %t184 = load %Parser, %Parser* %l1
  %t185 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t186 = load %Statement, %Statement* %l12
  %t187 = insertvalue %BlockStatementParseResult %t185, i8* null, 1
  %t188 = insertvalue %BlockStatementParseResult %t187, i1 1, 2
  ret %BlockStatementParseResult %t188
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
  %t9 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t10 = insertvalue %BlockStatementParseResult %t9, i8* null, 1
  %t11 = insertvalue %BlockStatementParseResult %t10, i1 0, 2
  ret %BlockStatementParseResult %t11
merge1:
  %t12 = load %Parser, %Parser* %l1
  %s13 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.13, i32 0, i32 0
  %t14 = call %Parser @consume_keyword(%Parser %t12, i8* %s13)
  store %Parser %t14, %Parser* %l1
  %t15 = load %Parser, %Parser* %l1
  %t16 = call %Parser @skip_trivia(%Parser %t15)
  %t17 = alloca [1 x i8]
  %t18 = getelementptr [1 x i8], [1 x i8]* %t17, i32 0, i32 0
  %t19 = getelementptr i8, i8* %t18, i64 0
  store i8 123, i8* %t19
  %t20 = alloca { i8*, i64 }
  %t21 = getelementptr { i8*, i64 }, { i8*, i64 }* %t20, i32 0, i32 0
  store i8* %t18, i8** %t21
  %t22 = getelementptr { i8*, i64 }, { i8*, i64 }* %t20, i32 0, i32 1
  store i64 1, i64* %t22
  %t23 = bitcast { i8*, i64 }* %t20 to { i8**, i64 }*
  %t24 = call %CaptureResult @collect_until(%Parser %t16, { i8**, i64 }* %t23)
  store %CaptureResult %t24, %CaptureResult* %l2
  %t25 = load %CaptureResult, %CaptureResult* %l2
  %t26 = extractvalue %CaptureResult %t25, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t27 = load %CaptureResult, %CaptureResult* %l2
  %t28 = extractvalue %CaptureResult %t27, 1
  %t29 = bitcast { i8**, i64 }* %t28 to { %Token*, i64 }*
  %t30 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t29)
  store { %Token*, i64 }* %t30, { %Token*, i64 }** %l3
  %t31 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t32 = load { %Token*, i64 }, { %Token*, i64 }* %t31
  %t33 = extractvalue { %Token*, i64 } %t32, 1
  %t34 = icmp eq i64 %t33, 0
  %t35 = load %Parser, %Parser* %l0
  %t36 = load %Parser, %Parser* %l1
  %t37 = load %CaptureResult, %CaptureResult* %l2
  %t38 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  br i1 %t34, label %then2, label %merge3
then2:
  %t39 = load %Parser, %Parser* %l0
  %t40 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t41 = insertvalue %BlockStatementParseResult %t40, i8* null, 1
  %t42 = insertvalue %BlockStatementParseResult %t41, i1 0, 2
  ret %BlockStatementParseResult %t42
merge3:
  %t43 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t44 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t43)
  store %Expression %t44, %Expression* %l4
  %t45 = load %Parser, %Parser* %l1
  %t46 = call %MatchCasesParseResult @parse_match_cases(%Parser %t45)
  store %MatchCasesParseResult %t46, %MatchCasesParseResult* %l5
  %t47 = load %MatchCasesParseResult, %MatchCasesParseResult* %l5
  %t48 = extractvalue %MatchCasesParseResult %t47, 2
  %t49 = xor i1 %t48, 1
  %t50 = load %Parser, %Parser* %l0
  %t51 = load %Parser, %Parser* %l1
  %t52 = load %CaptureResult, %CaptureResult* %l2
  %t53 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t54 = load %Expression, %Expression* %l4
  %t55 = load %MatchCasesParseResult, %MatchCasesParseResult* %l5
  br i1 %t49, label %then4, label %merge5
then4:
  %t56 = load %Parser, %Parser* %l0
  %t57 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t58 = insertvalue %BlockStatementParseResult %t57, i8* null, 1
  %t59 = insertvalue %BlockStatementParseResult %t58, i1 0, 2
  ret %BlockStatementParseResult %t59
merge5:
  %t60 = load %MatchCasesParseResult, %MatchCasesParseResult* %l5
  %t61 = extractvalue %MatchCasesParseResult %t60, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t62 = load %Parser, %Parser* %l1
  %t63 = call %Parser @skip_trivia(%Parser %t62)
  store %Parser %t63, %Parser* %l1
  %t64 = load %Parser, %Parser* %l1
  %t65 = extractvalue %Parser %t64, 1
  %t66 = load %Parser, %Parser* %l1
  %t67 = extractvalue %Parser %t66, 0
  %t68 = load { i8**, i64 }, { i8**, i64 }* %t67
  %t69 = extractvalue { i8**, i64 } %t68, 1
  %t70 = sitofp i64 %t69 to double
  %t71 = fcmp olt double %t65, %t70
  %t72 = load %Parser, %Parser* %l0
  %t73 = load %Parser, %Parser* %l1
  %t74 = load %CaptureResult, %CaptureResult* %l2
  %t75 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t76 = load %Expression, %Expression* %l4
  %t77 = load %MatchCasesParseResult, %MatchCasesParseResult* %l5
  br i1 %t71, label %then6, label %merge7
then6:
  %t78 = load %Parser, %Parser* %l1
  %t79 = call %Token @parser_peek_raw(%Parser %t78)
  store %Token %t79, %Token* %l6
  %t81 = load %Token, %Token* %l6
  %t82 = extractvalue %Token %t81, 0
  br label %merge7
merge7:
  %t83 = alloca %Statement
  %t84 = getelementptr inbounds %Statement, %Statement* %t83, i32 0, i32 0
  store i32 18, i32* %t84
  %t85 = load %Expression, %Expression* %l4
  %t86 = call noalias i8* @malloc(i64 32)
  %t87 = bitcast i8* %t86 to %Expression*
  store %Expression %t85, %Expression* %t87
  %t88 = getelementptr inbounds %Statement, %Statement* %t83, i32 0, i32 1
  %t89 = bitcast [24 x i8]* %t88 to i8*
  %t90 = bitcast i8* %t89 to i8**
  store i8* %t86, i8** %t90
  %t91 = load %MatchCasesParseResult, %MatchCasesParseResult* %l5
  %t92 = extractvalue %MatchCasesParseResult %t91, 1
  %t93 = getelementptr inbounds %Statement, %Statement* %t83, i32 0, i32 1
  %t94 = bitcast [24 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 8
  %t96 = bitcast i8* %t95 to { i8**, i64 }**
  store { i8**, i64 }* %t92, { i8**, i64 }** %t96
  %t97 = bitcast { %Decorator*, i64 }* %decorators to { i8**, i64 }*
  %t98 = getelementptr inbounds %Statement, %Statement* %t83, i32 0, i32 1
  %t99 = bitcast [24 x i8]* %t98 to i8*
  %t100 = getelementptr inbounds i8, i8* %t99, i64 16
  %t101 = bitcast i8* %t100 to { i8**, i64 }**
  store { i8**, i64 }* %t97, { i8**, i64 }** %t101
  %t102 = load %Statement, %Statement* %t83
  store %Statement %t102, %Statement* %l7
  %t103 = load %Parser, %Parser* %l1
  %t104 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t105 = load %Statement, %Statement* %l7
  %t106 = insertvalue %BlockStatementParseResult %t104, i8* null, 1
  %t107 = insertvalue %BlockStatementParseResult %t106, i1 1, 2
  ret %BlockStatementParseResult %t107
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
  %t2 = call %Parser @advance_to_symbol(%Parser %t1, i8* null)
  store %Parser %t2, %Parser* %l0
  %t3 = load %Parser, %Parser* %l0
  %t4 = call %Token @parser_peek_raw(%Parser %t3)
  store %Token %t4, %Token* %l1
  %t6 = load %Token, %Token* %l1
  %t7 = extractvalue %Token %t6, 0
  %t8 = load %Parser, %Parser* %l0
  %t9 = call %Parser @parser_advance_raw(%Parser %t8)
  store %Parser %t9, %Parser* %l0
  %t10 = alloca [0 x %MatchCase]
  %t11 = getelementptr [0 x %MatchCase], [0 x %MatchCase]* %t10, i32 0, i32 0
  %t12 = alloca { %MatchCase*, i64 }
  %t13 = getelementptr { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t12, i32 0, i32 0
  store %MatchCase* %t11, %MatchCase** %t13
  %t14 = getelementptr { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { %MatchCase*, i64 }* %t12, { %MatchCase*, i64 }** %l2
  %t15 = load %Parser, %Parser* %l0
  %t16 = load %Token, %Token* %l1
  %t17 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %l2
  br label %loop.header0
loop.header0:
  %t65 = phi %Parser [ %t15, %entry ], [ %t63, %loop.latch2 ]
  %t66 = phi { %MatchCase*, i64 }* [ %t17, %entry ], [ %t64, %loop.latch2 ]
  store %Parser %t65, %Parser* %l0
  store { %MatchCase*, i64 }* %t66, { %MatchCase*, i64 }** %l2
  br label %loop.body1
loop.body1:
  %t18 = load %Parser, %Parser* %l0
  %t19 = call %Parser @skip_trivia(%Parser %t18)
  store %Parser %t19, %Parser* %l0
  %t20 = load %Parser, %Parser* %l0
  %t21 = call %Token @parser_peek_raw(%Parser %t20)
  store %Token %t21, %Token* %l3
  %t23 = load %Token, %Token* %l3
  %t24 = extractvalue %Token %t23, 0
  %t25 = load %Token, %Token* %l3
  %t26 = extractvalue %Token %t25, 0
  %t27 = load %Parser, %Parser* %l0
  %t28 = call %MatchCaseParseResult @parse_match_case(%Parser %t27)
  store %MatchCaseParseResult %t28, %MatchCaseParseResult* %l4
  %t30 = load %MatchCaseParseResult, %MatchCaseParseResult* %l4
  %t31 = extractvalue %MatchCaseParseResult %t30, 2
  br label %logical_or_entry_29

logical_or_entry_29:
  br i1 %t31, label %logical_or_merge_29, label %logical_or_right_29

logical_or_right_29:
  %t32 = load %MatchCaseParseResult, %MatchCaseParseResult* %l4
  %t33 = extractvalue %MatchCaseParseResult %t32, 1
  %t34 = icmp eq i8* %t33, null
  br label %logical_or_right_end_29

logical_or_right_end_29:
  br label %logical_or_merge_29

logical_or_merge_29:
  %t35 = phi i1 [ true, %logical_or_entry_29 ], [ %t34, %logical_or_right_end_29 ]
  %t36 = xor i1 %t35, 1
  %t37 = load %Parser, %Parser* %l0
  %t38 = load %Token, %Token* %l1
  %t39 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %l2
  %t40 = load %Token, %Token* %l3
  %t41 = load %MatchCaseParseResult, %MatchCaseParseResult* %l4
  br i1 %t36, label %then4, label %merge5
then4:
  %t42 = insertvalue %MatchCasesParseResult undef, i8* null, 0
  %t43 = alloca [0 x i8*]
  %t44 = getelementptr [0 x i8*], [0 x i8*]* %t43, i32 0, i32 0
  %t45 = alloca { i8**, i64 }
  %t46 = getelementptr { i8**, i64 }, { i8**, i64 }* %t45, i32 0, i32 0
  store i8** %t44, i8*** %t46
  %t47 = getelementptr { i8**, i64 }, { i8**, i64 }* %t45, i32 0, i32 1
  store i64 0, i64* %t47
  %t48 = insertvalue %MatchCasesParseResult %t42, { i8**, i64 }* %t45, 1
  %t49 = insertvalue %MatchCasesParseResult %t48, i1 0, 2
  ret %MatchCasesParseResult %t49
merge5:
  %t50 = load %MatchCaseParseResult, %MatchCaseParseResult* %l4
  %t51 = extractvalue %MatchCaseParseResult %t50, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t52 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %l2
  %t53 = load %MatchCaseParseResult, %MatchCaseParseResult* %l4
  %t54 = extractvalue %MatchCaseParseResult %t53, 1
  %t55 = call { %MatchCase*, i64 }* @append_match_case({ %MatchCase*, i64 }* %t52, %MatchCase zeroinitializer)
  store { %MatchCase*, i64 }* %t55, { %MatchCase*, i64 }** %l2
  %t56 = load %Parser, %Parser* %l0
  %t57 = call %Parser @skip_trivia(%Parser %t56)
  store %Parser %t57, %Parser* %l0
  %t58 = load %Parser, %Parser* %l0
  %t59 = call %Token @parser_peek_raw(%Parser %t58)
  store %Token %t59, %Token* %l5
  %t61 = load %Token, %Token* %l5
  %t62 = extractvalue %Token %t61, 0
  br label %loop.latch2
loop.latch2:
  %t63 = load %Parser, %Parser* %l0
  %t64 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %l2
  br label %loop.header0
afterloop3:
  %t67 = load %Parser, %Parser* %l0
  %t68 = insertvalue %MatchCasesParseResult undef, i8* null, 0
  %t69 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %l2
  %t70 = bitcast { %MatchCase*, i64 }* %t69 to { i8**, i64 }*
  %t71 = insertvalue %MatchCasesParseResult %t68, { i8**, i64 }* %t70, 1
  %t72 = insertvalue %MatchCasesParseResult %t71, i1 1, 2
  ret %MatchCasesParseResult %t72
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
  %t23 = insertvalue %MatchCaseParseResult undef, i8* null, 0
  %t24 = insertvalue %MatchCaseParseResult %t23, i8* null, 1
  %t25 = insertvalue %MatchCaseParseResult %t24, i1 0, 2
  ret %MatchCaseParseResult %t25
merge3:
  %t26 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t27 = extractvalue %PatternCaptureResult %t26, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t28 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t29 = extractvalue %PatternCaptureResult %t28, 1
  %t30 = bitcast { i8**, i64 }* %t29 to { %Token*, i64 }*
  %t31 = call %MatchCaseTokenSplit @split_match_case_tokens({ %Token*, i64 }* %t30)
  store %MatchCaseTokenSplit %t31, %MatchCaseTokenSplit* %l3
  %t32 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t33 = extractvalue %MatchCaseTokenSplit %t32, 0
  %t34 = load { i8**, i64 }, { i8**, i64 }* %t33
  %t35 = extractvalue { i8**, i64 } %t34, 1
  %t36 = icmp eq i64 %t35, 0
  %t37 = load %Parser, %Parser* %l0
  %t38 = load %Parser, %Parser* %l1
  %t39 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t40 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  br i1 %t36, label %then4, label %merge5
then4:
  %t41 = load %Parser, %Parser* %l0
  %t42 = insertvalue %MatchCaseParseResult undef, i8* null, 0
  %t43 = insertvalue %MatchCaseParseResult %t42, i8* null, 1
  %t44 = insertvalue %MatchCaseParseResult %t43, i1 0, 2
  ret %MatchCaseParseResult %t44
merge5:
  %t45 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t46 = extractvalue %MatchCaseTokenSplit %t45, 0
  %t47 = bitcast { i8**, i64 }* %t46 to { %Token*, i64 }*
  %t48 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t47)
  store %Expression %t48, %Expression* %l4
  store i8* null, i8** %l5
  %t49 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t50 = extractvalue %MatchCaseTokenSplit %t49, 2
  %t51 = load %Parser, %Parser* %l0
  %t52 = load %Parser, %Parser* %l1
  %t53 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t54 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t55 = load %Expression, %Expression* %l4
  %t56 = load i8*, i8** %l5
  br i1 %t50, label %then6, label %merge7
then6:
  %t57 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t58 = extractvalue %MatchCaseTokenSplit %t57, 1
  %t59 = load { i8**, i64 }, { i8**, i64 }* %t58
  %t60 = extractvalue { i8**, i64 } %t59, 1
  %t61 = icmp eq i64 %t60, 0
  %t62 = load %Parser, %Parser* %l0
  %t63 = load %Parser, %Parser* %l1
  %t64 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t65 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t66 = load %Expression, %Expression* %l4
  %t67 = load i8*, i8** %l5
  br i1 %t61, label %then8, label %merge9
then8:
  %t68 = load %Parser, %Parser* %l0
  %t69 = insertvalue %MatchCaseParseResult undef, i8* null, 0
  %t70 = insertvalue %MatchCaseParseResult %t69, i8* null, 1
  %t71 = insertvalue %MatchCaseParseResult %t70, i1 0, 2
  ret %MatchCaseParseResult %t71
merge9:
  %t72 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t73 = extractvalue %MatchCaseTokenSplit %t72, 1
  %t74 = bitcast { i8**, i64 }* %t73 to { %Token*, i64 }*
  %t75 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t74)
  store i8* null, i8** %l5
  br label %merge7
merge7:
  %t76 = phi i8* [ null, %then6 ], [ %t56, %entry ]
  store i8* %t76, i8** %l5
  %t77 = load %Parser, %Parser* %l1
  %t78 = call %Parser @skip_trivia(%Parser %t77)
  store %Parser %t78, %Parser* %l1
  %t79 = load %Parser, %Parser* %l1
  %t80 = call %Token @parser_peek_raw(%Parser %t79)
  store %Token %t80, %Token* %l6
  store i8* null, i8** %l7
  %t82 = load %Token, %Token* %l6
  %t83 = extractvalue %Token %t82, 0
  %t84 = load i8*, i8** %l7
  %t85 = icmp eq i8* %t84, null
  %t86 = load %Parser, %Parser* %l0
  %t87 = load %Parser, %Parser* %l1
  %t88 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t89 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t90 = load %Expression, %Expression* %l4
  %t91 = load i8*, i8** %l5
  %t92 = load %Token, %Token* %l6
  %t93 = load i8*, i8** %l7
  br i1 %t85, label %then10, label %merge11
then10:
  %t94 = load %Parser, %Parser* %l0
  %t95 = insertvalue %MatchCaseParseResult undef, i8* null, 0
  %t96 = insertvalue %MatchCaseParseResult %t95, i8* null, 1
  %t97 = insertvalue %MatchCaseParseResult %t96, i1 0, 2
  ret %MatchCaseParseResult %t97
merge11:
  %t98 = load %Expression, %Expression* %l4
  %t99 = insertvalue %MatchCase undef, i8* null, 0
  %t100 = load i8*, i8** %l5
  %t101 = insertvalue %MatchCase %t99, i8* %t100, 1
  %t102 = load i8*, i8** %l7
  %t103 = insertvalue %MatchCase %t101, i8* %t102, 2
  store %MatchCase %t103, %MatchCase* %l8
  %t104 = load %Parser, %Parser* %l1
  %t105 = insertvalue %MatchCaseParseResult undef, i8* null, 0
  %t106 = load %MatchCase, %MatchCase* %l8
  %t107 = insertvalue %MatchCaseParseResult %t105, i8* null, 1
  %t108 = insertvalue %MatchCaseParseResult %t107, i1 1, 2
  ret %MatchCaseParseResult %t108
}

define %BlockStatementParseResult @parse_prompt_statement(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %Token
  %l3 = alloca %Token
  %l4 = alloca i8*
  %l5 = alloca %BlockParseResult
  %l6 = alloca i8*
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
  %t11 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t12 = insertvalue %BlockStatementParseResult %t11, i8* null, 1
  %t13 = insertvalue %BlockStatementParseResult %t12, i1 0, 2
  ret %BlockStatementParseResult %t13
merge1:
  %t14 = load %Parser, %Parser* %l1
  %s15 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.15, i32 0, i32 0
  %t16 = call %Parser @consume_keyword(%Parser %t14, i8* %s15)
  store %Parser %t16, %Parser* %l1
  %t17 = load %Parser, %Parser* %l1
  %t18 = call %Parser @skip_trivia(%Parser %t17)
  store %Parser %t18, %Parser* %l1
  %t19 = load %Parser, %Parser* %l1
  %t20 = call %Token @parser_peek_raw(%Parser %t19)
  store %Token %t20, %Token* %l3
  %s21 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.21, i32 0, i32 0
  store i8* %s21, i8** %l4
  %t22 = load %Token, %Token* %l3
  %t23 = extractvalue %Token %t22, 0
  %t24 = load %Parser, %Parser* %l1
  %t25 = call %BlockParseResult @parse_block(%Parser %t24)
  store %BlockParseResult %t25, %BlockParseResult* %l5
  %t26 = load %BlockParseResult, %BlockParseResult* %l5
  %t27 = extractvalue %BlockParseResult %t26, 1
  %t28 = load %BlockParseResult, %BlockParseResult* %l5
  %t29 = extractvalue %BlockParseResult %t28, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t30 = load %BlockParseResult, %BlockParseResult* %l5
  %t31 = extractvalue %BlockParseResult %t30, 1
  store i8* %t31, i8** %l6
  %t32 = load %Parser, %Parser* %l1
  %t33 = call %Parser @skip_trivia(%Parser %t32)
  store %Parser %t33, %Parser* %l1
  %t35 = load %Parser, %Parser* %l1
  %t36 = call %Token @parser_peek_raw(%Parser %t35)
  %t37 = extractvalue %Token %t36, 0
  %t38 = alloca %Statement
  %t39 = getelementptr inbounds %Statement, %Statement* %t38, i32 0, i32 0
  store i32 12, i32* %t39
  %t40 = load i8*, i8** %l4
  %t41 = getelementptr inbounds %Statement, %Statement* %t38, i32 0, i32 1
  %t42 = bitcast [40 x i8]* %t41 to i8*
  %t43 = bitcast i8* %t42 to i8**
  store i8* %t40, i8** %t43
  %t44 = load %Token, %Token* %l2
  %t45 = call noalias i8* @malloc(i64 32)
  %t46 = bitcast i8* %t45 to %Token*
  store %Token %t44, %Token* %t46
  %t47 = getelementptr inbounds %Statement, %Statement* %t38, i32 0, i32 1
  %t48 = bitcast [40 x i8]* %t47 to i8*
  %t49 = getelementptr inbounds i8, i8* %t48, i64 8
  %t50 = bitcast i8* %t49 to i8**
  store i8* %t45, i8** %t50
  %t51 = load %Token, %Token* %l3
  %t52 = call noalias i8* @malloc(i64 32)
  %t53 = bitcast i8* %t52 to %Token*
  store %Token %t51, %Token* %t53
  %t54 = getelementptr inbounds %Statement, %Statement* %t38, i32 0, i32 1
  %t55 = bitcast [40 x i8]* %t54 to i8*
  %t56 = getelementptr inbounds i8, i8* %t55, i64 16
  %t57 = bitcast i8* %t56 to i8**
  store i8* %t52, i8** %t57
  %t58 = load i8*, i8** %l6
  %t59 = getelementptr inbounds %Statement, %Statement* %t38, i32 0, i32 1
  %t60 = bitcast [40 x i8]* %t59 to i8*
  %t61 = getelementptr inbounds i8, i8* %t60, i64 24
  %t62 = bitcast i8* %t61 to i8**
  store i8* %t58, i8** %t62
  %t63 = bitcast { %Decorator*, i64 }* %decorators to { i8**, i64 }*
  %t64 = getelementptr inbounds %Statement, %Statement* %t38, i32 0, i32 1
  %t65 = bitcast [40 x i8]* %t64 to i8*
  %t66 = getelementptr inbounds i8, i8* %t65, i64 32
  %t67 = bitcast i8* %t66 to { i8**, i64 }**
  store { i8**, i64 }* %t63, { i8**, i64 }** %t67
  %t68 = load %Statement, %Statement* %t38
  store %Statement %t68, %Statement* %l7
  %t69 = load %Parser, %Parser* %l1
  %t70 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t71 = load %Statement, %Statement* %l7
  %t72 = insertvalue %BlockStatementParseResult %t70, i8* null, 1
  %t73 = insertvalue %BlockStatementParseResult %t72, i1 1, 2
  ret %BlockStatementParseResult %t73
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
  %l9 = alloca i8*
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
  %t9 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t10 = insertvalue %BlockStatementParseResult %t9, i8* null, 1
  %t11 = insertvalue %BlockStatementParseResult %t10, i1 0, 2
  ret %BlockStatementParseResult %t11
merge1:
  %t12 = load %Parser, %Parser* %l1
  %s13 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.13, i32 0, i32 0
  %t14 = call %Parser @consume_keyword(%Parser %t12, i8* %s13)
  store %Parser %t14, %Parser* %l1
  %t15 = load %Parser, %Parser* %l1
  %t16 = call %Parser @skip_trivia(%Parser %t15)
  %t17 = alloca [1 x i8]
  %t18 = getelementptr [1 x i8], [1 x i8]* %t17, i32 0, i32 0
  %t19 = getelementptr i8, i8* %t18, i64 0
  store i8 123, i8* %t19
  %t20 = alloca { i8*, i64 }
  %t21 = getelementptr { i8*, i64 }, { i8*, i64 }* %t20, i32 0, i32 0
  store i8* %t18, i8** %t21
  %t22 = getelementptr { i8*, i64 }, { i8*, i64 }* %t20, i32 0, i32 1
  store i64 1, i64* %t22
  %t23 = bitcast { i8*, i64 }* %t20 to { i8**, i64 }*
  %t24 = call %CaptureResult @collect_until(%Parser %t16, { i8**, i64 }* %t23)
  store %CaptureResult %t24, %CaptureResult* %l2
  %t25 = load %CaptureResult, %CaptureResult* %l2
  %t26 = extractvalue %CaptureResult %t25, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t27 = load %CaptureResult, %CaptureResult* %l2
  %t28 = extractvalue %CaptureResult %t27, 1
  %t29 = bitcast { i8**, i64 }* %t28 to { %Token*, i64 }*
  %t30 = call { i8**, i64 }* @split_token_slices_by_comma({ %Token*, i64 }* %t29)
  store { i8**, i64 }* %t30, { i8**, i64 }** %l3
  %t31 = alloca [0 x %WithClause]
  %t32 = getelementptr [0 x %WithClause], [0 x %WithClause]* %t31, i32 0, i32 0
  %t33 = alloca { %WithClause*, i64 }
  %t34 = getelementptr { %WithClause*, i64 }, { %WithClause*, i64 }* %t33, i32 0, i32 0
  store %WithClause* %t32, %WithClause** %t34
  %t35 = getelementptr { %WithClause*, i64 }, { %WithClause*, i64 }* %t33, i32 0, i32 1
  store i64 0, i64* %t35
  store { %WithClause*, i64 }* %t33, { %WithClause*, i64 }** %l4
  %t36 = sitofp i64 0 to double
  store double %t36, double* %l5
  %t37 = load %Parser, %Parser* %l0
  %t38 = load %Parser, %Parser* %l1
  %t39 = load %CaptureResult, %CaptureResult* %l2
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t41 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %l4
  %t42 = load double, double* %l5
  br label %loop.header2
loop.header2:
  %t88 = phi { %WithClause*, i64 }* [ %t41, %entry ], [ %t86, %loop.latch4 ]
  %t89 = phi double [ %t42, %entry ], [ %t87, %loop.latch4 ]
  store { %WithClause*, i64 }* %t88, { %WithClause*, i64 }** %l4
  store double %t89, double* %l5
  br label %loop.body3
loop.body3:
  %t43 = load double, double* %l5
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t45 = load { i8**, i64 }, { i8**, i64 }* %t44
  %t46 = extractvalue { i8**, i64 } %t45, 1
  %t47 = sitofp i64 %t46 to double
  %t48 = fcmp oge double %t43, %t47
  %t49 = load %Parser, %Parser* %l0
  %t50 = load %Parser, %Parser* %l1
  %t51 = load %CaptureResult, %CaptureResult* %l2
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t53 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %l4
  %t54 = load double, double* %l5
  br i1 %t48, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t56 = load double, double* %l5
  %t57 = fptosi double %t56 to i64
  %t58 = load { i8**, i64 }, { i8**, i64 }* %t55
  %t59 = extractvalue { i8**, i64 } %t58, 0
  %t60 = extractvalue { i8**, i64 } %t58, 1
  %t61 = icmp uge i64 %t57, %t60
  ; bounds check: %t61 (if true, out of bounds)
  %t62 = getelementptr i8*, i8** %t59, i64 %t57
  %t63 = load i8*, i8** %t62
  %t64 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* null)
  store { %Token*, i64 }* %t64, { %Token*, i64 }** %l6
  %t65 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  %t66 = load { %Token*, i64 }, { %Token*, i64 }* %t65
  %t67 = extractvalue { %Token*, i64 } %t66, 1
  %t68 = icmp sgt i64 %t67, 0
  %t69 = load %Parser, %Parser* %l0
  %t70 = load %Parser, %Parser* %l1
  %t71 = load %CaptureResult, %CaptureResult* %l2
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t73 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %l4
  %t74 = load double, double* %l5
  %t75 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  br i1 %t68, label %then8, label %merge9
then8:
  %t76 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  %t77 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t76)
  store %Expression %t77, %Expression* %l7
  %t78 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %l4
  %t79 = load %Expression, %Expression* %l7
  %t80 = insertvalue %WithClause undef, i8* null, 0
  %t81 = call { %WithClause*, i64 }* @append_with_clause({ %WithClause*, i64 }* %t78, %WithClause %t80)
  store { %WithClause*, i64 }* %t81, { %WithClause*, i64 }** %l4
  br label %merge9
merge9:
  %t82 = phi { %WithClause*, i64 }* [ %t81, %then8 ], [ %t73, %loop.body3 ]
  store { %WithClause*, i64 }* %t82, { %WithClause*, i64 }** %l4
  %t83 = load double, double* %l5
  %t84 = sitofp i64 1 to double
  %t85 = fadd double %t83, %t84
  store double %t85, double* %l5
  br label %loop.latch4
loop.latch4:
  %t86 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %l4
  %t87 = load double, double* %l5
  br label %loop.header2
afterloop5:
  %t90 = load %Parser, %Parser* %l1
  %t91 = call %BlockParseResult @parse_block(%Parser %t90)
  store %BlockParseResult %t91, %BlockParseResult* %l8
  %t92 = load %BlockParseResult, %BlockParseResult* %l8
  %t93 = extractvalue %BlockParseResult %t92, 1
  %t94 = load %BlockParseResult, %BlockParseResult* %l8
  %t95 = extractvalue %BlockParseResult %t94, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t96 = load %BlockParseResult, %BlockParseResult* %l8
  %t97 = extractvalue %BlockParseResult %t96, 1
  store i8* %t97, i8** %l9
  %t98 = load %Parser, %Parser* %l1
  %t99 = call %Parser @skip_trivia(%Parser %t98)
  store %Parser %t99, %Parser* %l1
  %t101 = load %Parser, %Parser* %l1
  %t102 = call %Token @parser_peek_raw(%Parser %t101)
  %t103 = extractvalue %Token %t102, 0
  %t104 = alloca %Statement
  %t105 = getelementptr inbounds %Statement, %Statement* %t104, i32 0, i32 0
  store i32 13, i32* %t105
  %t106 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %l4
  %t107 = bitcast { %WithClause*, i64 }* %t106 to { i8**, i64 }*
  %t108 = getelementptr inbounds %Statement, %Statement* %t104, i32 0, i32 1
  %t109 = bitcast [24 x i8]* %t108 to i8*
  %t110 = bitcast i8* %t109 to { i8**, i64 }**
  store { i8**, i64 }* %t107, { i8**, i64 }** %t110
  %t111 = load i8*, i8** %l9
  %t112 = getelementptr inbounds %Statement, %Statement* %t104, i32 0, i32 1
  %t113 = bitcast [24 x i8]* %t112 to i8*
  %t114 = getelementptr inbounds i8, i8* %t113, i64 8
  %t115 = bitcast i8* %t114 to i8**
  store i8* %t111, i8** %t115
  %t116 = bitcast { %Decorator*, i64 }* %decorators to { i8**, i64 }*
  %t117 = getelementptr inbounds %Statement, %Statement* %t104, i32 0, i32 1
  %t118 = bitcast [24 x i8]* %t117 to i8*
  %t119 = getelementptr inbounds i8, i8* %t118, i64 16
  %t120 = bitcast i8* %t119 to { i8**, i64 }**
  store { i8**, i64 }* %t116, { i8**, i64 }** %t120
  %t121 = load %Statement, %Statement* %t104
  store %Statement %t121, %Statement* %l10
  %t122 = load %Parser, %Parser* %l1
  %t123 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t124 = load %Statement, %Statement* %l10
  %t125 = insertvalue %BlockStatementParseResult %t123, i8* null, 1
  %t126 = insertvalue %BlockStatementParseResult %t125, i1 1, 2
  ret %BlockStatementParseResult %t126
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
  %t9 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t10 = insertvalue %BlockStatementParseResult %t9, i8* null, 1
  %t11 = insertvalue %BlockStatementParseResult %t10, i1 0, 2
  ret %BlockStatementParseResult %t11
merge1:
  %t12 = alloca [0 x %Token]
  %t13 = getelementptr [0 x %Token], [0 x %Token]* %t12, i32 0, i32 0
  %t14 = alloca { %Token*, i64 }
  %t15 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t14, i32 0, i32 0
  store %Token* %t13, %Token** %t15
  %t16 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  store { %Token*, i64 }* %t14, { %Token*, i64 }** %l2
  %t17 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t18 = load %Parser, %Parser* %l1
  %t19 = call %Token @parser_peek_raw(%Parser %t18)
  %t20 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t17, %Token %t19)
  store { %Token*, i64 }* %t20, { %Token*, i64 }** %l2
  %t21 = load %Parser, %Parser* %l1
  %s22 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.22, i32 0, i32 0
  %t23 = call %Parser @consume_keyword(%Parser %t21, i8* %s22)
  store %Parser %t23, %Parser* %l1
  %t24 = load %Parser, %Parser* %l1
  %t25 = call %Parser @skip_trivia(%Parser %t24)
  %t26 = alloca [2 x i8]
  %t27 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 0
  %t28 = getelementptr i8, i8* %t27, i64 0
  store i8 59, i8* %t28
  %t29 = getelementptr i8, i8* %t27, i64 1
  store i8 125, i8* %t29
  %t30 = alloca { i8*, i64 }
  %t31 = getelementptr { i8*, i64 }, { i8*, i64 }* %t30, i32 0, i32 0
  store i8* %t27, i8** %t31
  %t32 = getelementptr { i8*, i64 }, { i8*, i64 }* %t30, i32 0, i32 1
  store i64 2, i64* %t32
  %t33 = bitcast { i8*, i64 }* %t30 to { i8**, i64 }*
  %t34 = call %CaptureResult @collect_until(%Parser %t25, { i8**, i64 }* %t33)
  store %CaptureResult %t34, %CaptureResult* %l3
  %t35 = load %CaptureResult, %CaptureResult* %l3
  %t36 = extractvalue %CaptureResult %t35, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t37 = load %CaptureResult, %CaptureResult* %l3
  %t38 = extractvalue %CaptureResult %t37, 1
  %t39 = bitcast { i8**, i64 }* %t38 to { %Token*, i64 }*
  %t40 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t39)
  store { %Token*, i64 }* %t40, { %Token*, i64 }** %l4
  store i8* null, i8** %l5
  %t41 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t42 = load { %Token*, i64 }, { %Token*, i64 }* %t41
  %t43 = extractvalue { %Token*, i64 } %t42, 1
  %t44 = icmp sgt i64 %t43, 0
  %t45 = load %Parser, %Parser* %l0
  %t46 = load %Parser, %Parser* %l1
  %t47 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t48 = load %CaptureResult, %CaptureResult* %l3
  %t49 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t50 = load i8*, i8** %l5
  br i1 %t44, label %then2, label %merge3
then2:
  %t51 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t52 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t51)
  store i8* null, i8** %l5
  br label %merge3
merge3:
  %t53 = phi i8* [ null, %then2 ], [ %t50, %entry ]
  store i8* %t53, i8** %l5
  %t54 = sitofp i64 0 to double
  store double %t54, double* %l6
  %t55 = load %Parser, %Parser* %l0
  %t56 = load %Parser, %Parser* %l1
  %t57 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t58 = load %CaptureResult, %CaptureResult* %l3
  %t59 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t60 = load i8*, i8** %l5
  %t61 = load double, double* %l6
  br label %loop.header4
loop.header4:
  %t93 = phi { %Token*, i64 }* [ %t57, %entry ], [ %t91, %loop.latch6 ]
  %t94 = phi double [ %t61, %entry ], [ %t92, %loop.latch6 ]
  store { %Token*, i64 }* %t93, { %Token*, i64 }** %l2
  store double %t94, double* %l6
  br label %loop.body5
loop.body5:
  %t62 = load double, double* %l6
  %t63 = load %CaptureResult, %CaptureResult* %l3
  %t64 = extractvalue %CaptureResult %t63, 1
  %t65 = load { i8**, i64 }, { i8**, i64 }* %t64
  %t66 = extractvalue { i8**, i64 } %t65, 1
  %t67 = sitofp i64 %t66 to double
  %t68 = fcmp oge double %t62, %t67
  %t69 = load %Parser, %Parser* %l0
  %t70 = load %Parser, %Parser* %l1
  %t71 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t72 = load %CaptureResult, %CaptureResult* %l3
  %t73 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t74 = load i8*, i8** %l5
  %t75 = load double, double* %l6
  br i1 %t68, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t76 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t77 = load %CaptureResult, %CaptureResult* %l3
  %t78 = extractvalue %CaptureResult %t77, 1
  %t79 = load double, double* %l6
  %t80 = fptosi double %t79 to i64
  %t81 = load { i8**, i64 }, { i8**, i64 }* %t78
  %t82 = extractvalue { i8**, i64 } %t81, 0
  %t83 = extractvalue { i8**, i64 } %t81, 1
  %t84 = icmp uge i64 %t80, %t83
  ; bounds check: %t84 (if true, out of bounds)
  %t85 = getelementptr i8*, i8** %t82, i64 %t80
  %t86 = load i8*, i8** %t85
  %t87 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t76, %Token zeroinitializer)
  store { %Token*, i64 }* %t87, { %Token*, i64 }** %l2
  %t88 = load double, double* %l6
  %t89 = sitofp i64 1 to double
  %t90 = fadd double %t88, %t89
  store double %t90, double* %l6
  br label %loop.latch6
loop.latch6:
  %t91 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t92 = load double, double* %l6
  br label %loop.header4
afterloop7:
  %t95 = load %Parser, %Parser* %l1
  %t96 = call %Parser @skip_trivia(%Parser %t95)
  store %Parser %t96, %Parser* %l1
  %t97 = load %Parser, %Parser* %l1
  %t98 = call %Token @parser_peek_raw(%Parser %t97)
  store %Token %t98, %Token* %l7
  %t100 = load %Token, %Token* %l7
  %t101 = extractvalue %Token %t100, 0
  %t102 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t103 = call double @source_span_from_tokens({ %Token*, i64 }* %t102)
  store double %t103, double* %l8
  %t104 = alloca %Statement
  %t105 = getelementptr inbounds %Statement, %Statement* %t104, i32 0, i32 0
  store i32 20, i32* %t105
  %t106 = load i8*, i8** %l5
  %t107 = getelementptr inbounds %Statement, %Statement* %t104, i32 0, i32 1
  %t108 = bitcast [16 x i8]* %t107 to i8*
  %t109 = bitcast i8* %t108 to i8**
  store i8* %t106, i8** %t109
  %t110 = load double, double* %l8
  %t111 = call noalias i8* @malloc(i64 8)
  %t112 = bitcast i8* %t111 to double*
  store double %t110, double* %t112
  %t113 = getelementptr inbounds %Statement, %Statement* %t104, i32 0, i32 1
  %t114 = bitcast [16 x i8]* %t113 to i8*
  %t115 = getelementptr inbounds i8, i8* %t114, i64 8
  %t116 = bitcast i8* %t115 to i8**
  store i8* %t111, i8** %t116
  %t117 = load %Statement, %Statement* %t104
  store %Statement %t117, %Statement* %l9
  %t118 = load %Parser, %Parser* %l1
  %t119 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t120 = load %Statement, %Statement* %l9
  %t121 = insertvalue %BlockStatementParseResult %t119, i8* null, 1
  %t122 = insertvalue %BlockStatementParseResult %t121, i1 1, 2
  ret %BlockStatementParseResult %t122
}

define %BlockStatementParseResult @parse_expression_statement(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  %l2 = alloca %CaptureResult
  %l3 = alloca { %Token*, i64 }*
  %l4 = alloca double
  %l5 = alloca { %Token*, i64 }*
  %l6 = alloca %Token
  %l7 = alloca %Expression
  %l8 = alloca double
  %l9 = alloca %Statement
  %t0 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %decorators
  %t1 = extractvalue { %Decorator*, i64 } %t0, 1
  %t2 = icmp sgt i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t4 = insertvalue %BlockStatementParseResult %t3, i8* null, 1
  %t5 = insertvalue %BlockStatementParseResult %t4, i1 0, 2
  ret %BlockStatementParseResult %t5
merge1:
  %t6 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t6, %Parser* %l0
  %t7 = load %Parser, %Parser* %l0
  %t8 = call %Token @parser_peek_raw(%Parser %t7)
  store %Token %t8, %Token* %l1
  %t9 = load %Token, %Token* %l1
  %t10 = extractvalue %Token %t9, 0
  %t11 = load %Token, %Token* %l1
  %t12 = extractvalue %Token %t11, 0
  %t13 = load %Parser, %Parser* %l0
  %t14 = alloca [1 x i8]
  %t15 = getelementptr [1 x i8], [1 x i8]* %t14, i32 0, i32 0
  %t16 = getelementptr i8, i8* %t15, i64 0
  store i8 59, i8* %t16
  %t17 = alloca { i8*, i64 }
  %t18 = getelementptr { i8*, i64 }, { i8*, i64 }* %t17, i32 0, i32 0
  store i8* %t15, i8** %t18
  %t19 = getelementptr { i8*, i64 }, { i8*, i64 }* %t17, i32 0, i32 1
  store i64 1, i64* %t19
  %t20 = bitcast { i8*, i64 }* %t17 to { i8**, i64 }*
  %t21 = call %CaptureResult @collect_until(%Parser %t13, { i8**, i64 }* %t20)
  store %CaptureResult %t21, %CaptureResult* %l2
  %t22 = load %CaptureResult, %CaptureResult* %l2
  %t23 = extractvalue %CaptureResult %t22, 1
  %t24 = load { i8**, i64 }, { i8**, i64 }* %t23
  %t25 = extractvalue { i8**, i64 } %t24, 1
  %t26 = icmp eq i64 %t25, 0
  %t27 = load %Parser, %Parser* %l0
  %t28 = load %Token, %Token* %l1
  %t29 = load %CaptureResult, %CaptureResult* %l2
  br i1 %t26, label %then2, label %merge3
then2:
  %t30 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t31 = insertvalue %BlockStatementParseResult %t30, i8* null, 1
  %t32 = insertvalue %BlockStatementParseResult %t31, i1 0, 2
  ret %BlockStatementParseResult %t32
merge3:
  %t33 = alloca [0 x %Token]
  %t34 = getelementptr [0 x %Token], [0 x %Token]* %t33, i32 0, i32 0
  %t35 = alloca { %Token*, i64 }
  %t36 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t35, i32 0, i32 0
  store %Token* %t34, %Token** %t36
  %t37 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t35, i32 0, i32 1
  store i64 0, i64* %t37
  store { %Token*, i64 }* %t35, { %Token*, i64 }** %l3
  %t38 = sitofp i64 0 to double
  store double %t38, double* %l4
  %t39 = load %Parser, %Parser* %l0
  %t40 = load %Token, %Token* %l1
  %t41 = load %CaptureResult, %CaptureResult* %l2
  %t42 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t43 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t73 = phi { %Token*, i64 }* [ %t42, %entry ], [ %t71, %loop.latch6 ]
  %t74 = phi double [ %t43, %entry ], [ %t72, %loop.latch6 ]
  store { %Token*, i64 }* %t73, { %Token*, i64 }** %l3
  store double %t74, double* %l4
  br label %loop.body5
loop.body5:
  %t44 = load double, double* %l4
  %t45 = load %CaptureResult, %CaptureResult* %l2
  %t46 = extractvalue %CaptureResult %t45, 1
  %t47 = load { i8**, i64 }, { i8**, i64 }* %t46
  %t48 = extractvalue { i8**, i64 } %t47, 1
  %t49 = sitofp i64 %t48 to double
  %t50 = fcmp oge double %t44, %t49
  %t51 = load %Parser, %Parser* %l0
  %t52 = load %Token, %Token* %l1
  %t53 = load %CaptureResult, %CaptureResult* %l2
  %t54 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t55 = load double, double* %l4
  br i1 %t50, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t56 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t57 = load %CaptureResult, %CaptureResult* %l2
  %t58 = extractvalue %CaptureResult %t57, 1
  %t59 = load double, double* %l4
  %t60 = fptosi double %t59 to i64
  %t61 = load { i8**, i64 }, { i8**, i64 }* %t58
  %t62 = extractvalue { i8**, i64 } %t61, 0
  %t63 = extractvalue { i8**, i64 } %t61, 1
  %t64 = icmp uge i64 %t60, %t63
  ; bounds check: %t64 (if true, out of bounds)
  %t65 = getelementptr i8*, i8** %t62, i64 %t60
  %t66 = load i8*, i8** %t65
  %t67 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t56, %Token zeroinitializer)
  store { %Token*, i64 }* %t67, { %Token*, i64 }** %l3
  %t68 = load double, double* %l4
  %t69 = sitofp i64 1 to double
  %t70 = fadd double %t68, %t69
  store double %t70, double* %l4
  br label %loop.latch6
loop.latch6:
  %t71 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t72 = load double, double* %l4
  br label %loop.header4
afterloop7:
  %t75 = load %CaptureResult, %CaptureResult* %l2
  %t76 = extractvalue %CaptureResult %t75, 1
  %t77 = bitcast { i8**, i64 }* %t76 to { %Token*, i64 }*
  %t78 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t77)
  store { %Token*, i64 }* %t78, { %Token*, i64 }** %l5
  %t79 = load { %Token*, i64 }*, { %Token*, i64 }** %l5
  %t80 = load { %Token*, i64 }, { %Token*, i64 }* %t79
  %t81 = extractvalue { %Token*, i64 } %t80, 1
  %t82 = icmp eq i64 %t81, 0
  %t83 = load %Parser, %Parser* %l0
  %t84 = load %Token, %Token* %l1
  %t85 = load %CaptureResult, %CaptureResult* %l2
  %t86 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t87 = load double, double* %l4
  %t88 = load { %Token*, i64 }*, { %Token*, i64 }** %l5
  br i1 %t82, label %then10, label %merge11
then10:
  %t89 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t90 = insertvalue %BlockStatementParseResult %t89, i8* null, 1
  %t91 = insertvalue %BlockStatementParseResult %t90, i1 0, 2
  ret %BlockStatementParseResult %t91
merge11:
  %t92 = load %CaptureResult, %CaptureResult* %l2
  %t93 = extractvalue %CaptureResult %t92, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t94 = load %Parser, %Parser* %l0
  %t95 = call %Parser @skip_trivia(%Parser %t94)
  store %Parser %t95, %Parser* %l0
  %t96 = load %Parser, %Parser* %l0
  %t97 = call %Token @parser_peek_raw(%Parser %t96)
  store %Token %t97, %Token* %l6
  %t99 = load %Token, %Token* %l6
  %t100 = extractvalue %Token %t99, 0
  %t101 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t102 = load %Token, %Token* %l6
  %t103 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t101, %Token %t102)
  store { %Token*, i64 }* %t103, { %Token*, i64 }** %l3
  %t104 = load %Parser, %Parser* %l0
  %t105 = call %Parser @parser_advance_raw(%Parser %t104)
  store %Parser %t105, %Parser* %l0
  %t106 = load { %Token*, i64 }*, { %Token*, i64 }** %l5
  %t107 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t106)
  store %Expression %t107, %Expression* %l7
  %t108 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t109 = call double @source_span_from_tokens({ %Token*, i64 }* %t108)
  store double %t109, double* %l8
  %t110 = alloca %Statement
  %t111 = getelementptr inbounds %Statement, %Statement* %t110, i32 0, i32 0
  store i32 21, i32* %t111
  %t112 = load %Expression, %Expression* %l7
  %t113 = call noalias i8* @malloc(i64 32)
  %t114 = bitcast i8* %t113 to %Expression*
  store %Expression %t112, %Expression* %t114
  %t115 = getelementptr inbounds %Statement, %Statement* %t110, i32 0, i32 1
  %t116 = bitcast [16 x i8]* %t115 to i8*
  %t117 = bitcast i8* %t116 to i8**
  store i8* %t113, i8** %t117
  %t118 = load double, double* %l8
  %t119 = call noalias i8* @malloc(i64 8)
  %t120 = bitcast i8* %t119 to double*
  store double %t118, double* %t120
  %t121 = getelementptr inbounds %Statement, %Statement* %t110, i32 0, i32 1
  %t122 = bitcast [16 x i8]* %t121 to i8*
  %t123 = getelementptr inbounds i8, i8* %t122, i64 8
  %t124 = bitcast i8* %t123 to i8**
  store i8* %t119, i8** %t124
  %t125 = load %Statement, %Statement* %t110
  store %Statement %t125, %Statement* %l9
  %t126 = load %Parser, %Parser* %l0
  %t127 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t128 = load %Statement, %Statement* %l9
  %t129 = insertvalue %BlockStatementParseResult %t127, i8* null, 1
  %t130 = insertvalue %BlockStatementParseResult %t129, i1 1, 2
  ret %BlockStatementParseResult %t130
}

define %StatementParseResult @parse_unknown(%Parser %parser) {
entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca %Parser
  %l2 = alloca double
  %l3 = alloca %Token
  %l4 = alloca i8*
  %l5 = alloca %Statement
  %t0 = alloca [0 x %Token]
  %t1 = getelementptr [0 x %Token], [0 x %Token]* %t0, i32 0, i32 0
  %t2 = alloca { %Token*, i64 }
  %t3 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t2, i32 0, i32 0
  store %Token* %t1, %Token** %t3
  %t4 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Token*, i64 }* %t2, { %Token*, i64 }** %l0
  store %Parser %parser, %Parser* %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t7 = load %Parser, %Parser* %l1
  %t8 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t22 = phi { %Token*, i64 }* [ %t6, %entry ], [ %t20, %loop.latch2 ]
  %t23 = phi %Parser [ %t7, %entry ], [ %t21, %loop.latch2 ]
  store { %Token*, i64 }* %t22, { %Token*, i64 }** %l0
  store %Parser %t23, %Parser* %l1
  br label %loop.body1
loop.body1:
  %t9 = load %Parser, %Parser* %l1
  %t10 = call %Token @parser_peek_raw(%Parser %t9)
  store %Token %t10, %Token* %l3
  %t11 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t12 = load %Token, %Token* %l3
  %t13 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t11, %Token %t12)
  store { %Token*, i64 }* %t13, { %Token*, i64 }** %l0
  %t14 = load %Token, %Token* %l3
  %t15 = extractvalue %Token %t14, 0
  %t16 = load %Token, %Token* %l3
  %t17 = extractvalue %Token %t16, 0
  %t18 = load %Parser, %Parser* %l1
  %t19 = call %Parser @parser_advance_raw(%Parser %t18)
  store %Parser %t19, %Parser* %l1
  br label %loop.latch2
loop.latch2:
  %t20 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t21 = load %Parser, %Parser* %l1
  br label %loop.header0
afterloop3:
  %t24 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t25 = call i8* @tokens_to_text({ %Token*, i64 }* %t24)
  store i8* %t25, i8** %l4
  %t26 = alloca %Statement
  %t27 = getelementptr inbounds %Statement, %Statement* %t26, i32 0, i32 0
  store i32 22, i32* %t27
  %t28 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t29 = bitcast { %Token*, i64 }* %t28 to { i8**, i64 }*
  %t30 = getelementptr inbounds %Statement, %Statement* %t26, i32 0, i32 1
  %t31 = bitcast [16 x i8]* %t30 to i8*
  %t32 = bitcast i8* %t31 to { i8**, i64 }**
  store { i8**, i64 }* %t29, { i8**, i64 }** %t32
  %t33 = load i8*, i8** %l4
  %t34 = getelementptr inbounds %Statement, %Statement* %t26, i32 0, i32 1
  %t35 = bitcast [16 x i8]* %t34 to i8*
  %t36 = getelementptr inbounds i8, i8* %t35, i64 8
  %t37 = bitcast i8* %t36 to i8**
  store i8* %t33, i8** %t37
  %t38 = load %Statement, %Statement* %t26
  store %Statement %t38, %Statement* %l5
  %t39 = insertvalue %StatementParseResult undef, i8* null, 0
  %t40 = load %Statement, %Statement* %l5
  %t41 = insertvalue %StatementParseResult %t39, i8* null, 1
  ret %StatementParseResult %t41
}

define i1 @identifier_matches(%Token %token, i8* %expected) {
entry:
  %t0 = extractvalue %Token %token, 0
  %t1 = extractvalue %Token %token, 0
  %t2 = extractvalue %Token %token, 1
  %t3 = icmp eq i8* %t2, %expected
  ret i1 %t3
}

define i8* @identifier_text(%Token %token) {
entry:
  %t0 = extractvalue %Token %token, 0
  %t1 = extractvalue %Token %token, 1
  ret i8* %t1
}

define i8* @string_literal_value(%Token %token) {
entry:
  %l0 = alloca i8*
  %t0 = extractvalue %Token %token, 0
  %t1 = extractvalue %Token %token, 1
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i8* @strip_surrounding_quotes(i8* %t2)
  ret i8* %t3
}

define %Parser @skip_trivia(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca i8*
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
  %t5 = load { i8**, i64 }, { i8**, i64 }* %t4
  %t6 = extractvalue { i8**, i64 } %t5, 1
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
  %t15 = load { i8**, i64 }, { i8**, i64 }* %t11
  %t16 = extractvalue { i8**, i64 } %t15, 0
  %t17 = extractvalue { i8**, i64 } %t15, 1
  %t18 = icmp uge i64 %t14, %t17
  ; bounds check: %t18 (if true, out of bounds)
  %t19 = getelementptr i8*, i8** %t16, i64 %t14
  %t20 = load i8*, i8** %t19
  store i8* %t20, i8** %l1
  %t21 = load i8*, i8** %l1
  %t22 = call i1 @is_trivia_token(%Token zeroinitializer)
  %t23 = load %Parser, %Parser* %l0
  %t24 = load i8*, i8** %l1
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
  %t2 = load { i8**, i64 }, { i8**, i64 }* %t1
  %t3 = extractvalue { i8**, i64 } %t2, 1
  %t4 = sitofp i64 %t3 to double
  %t5 = fcmp oge double %t0, %t4
  br i1 %t5, label %then0, label %merge1
then0:
  ret %Token zeroinitializer
merge1:
  %t6 = extractvalue %Parser %parser, 0
  %t7 = extractvalue %Parser %parser, 1
  %t8 = fptosi double %t7 to i64
  %t9 = load { i8**, i64 }, { i8**, i64 }* %t6
  %t10 = extractvalue { i8**, i64 } %t9, 0
  %t11 = extractvalue { i8**, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  %t13 = getelementptr i8*, i8** %t10, i64 %t8
  %t14 = load i8*, i8** %t13
  ret %Token zeroinitializer
}

define %Parser @parser_advance_raw(%Parser %parser) {
entry:
  %t0 = extractvalue %Parser %parser, 1
  %t1 = sitofp i64 1 to double
  %t2 = fadd double %t0, %t1
  %t3 = extractvalue %Parser %parser, 0
  %t4 = load { i8**, i64 }, { i8**, i64 }* %t3
  %t5 = extractvalue { i8**, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp ogt double %t2, %t6
  br i1 %t7, label %then0, label %merge1
then0:
  ret %Parser %parser
merge1:
  ret %Parser zeroinitializer
}

define %Parser @consume_keyword(%Parser %parser, i8* %keyword) {
entry:
  %l0 = alloca %Token
  %t0 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t0, %Token* %l0
  %t1 = load %Token, %Token* %l0
  %t2 = call i1 @identifier_matches(%Token %t1, i8* %keyword)
  %t3 = load %Token, %Token* %l0
  br i1 %t2, label %then0, label %merge1
then0:
  %t4 = call %Parser @parser_advance_raw(%Parser %parser)
  ret %Parser %t4
merge1:
  ret %Parser %parser
}

define %Parser @consume_symbol(%Parser %parser, i8* %symbol) {
entry:
  %l0 = alloca %Token
  %t0 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t0, %Token* %l0
  %t2 = load %Token, %Token* %l0
  %t3 = extractvalue %Token %t2, 0
  ret %Parser %parser
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
  %l7 = alloca %Parser
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
  %t61 = phi { %Token*, i64 }* [ %t9, %entry ], [ %t59, %loop.latch2 ]
  %t62 = phi %Parser [ %t8, %entry ], [ %t60, %loop.latch2 ]
  store { %Token*, i64 }* %t61, { %Token*, i64 }** %l1
  store %Parser %t62, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t13 = load %Parser, %Parser* %l0
  %t14 = call %Token @parser_peek_raw(%Parser %t13)
  store %Token %t14, %Token* %l5
  %t15 = load %Token, %Token* %l5
  %t16 = extractvalue %Token %t15, 0
  %t19 = load double, double* %l2
  %t20 = sitofp i64 0 to double
  %t21 = fcmp oeq double %t19, %t20
  br label %logical_and_entry_18

logical_and_entry_18:
  br i1 %t21, label %logical_and_right_18, label %logical_and_merge_18

logical_and_right_18:
  %t22 = load double, double* %l3
  %t23 = sitofp i64 0 to double
  %t24 = fcmp oeq double %t22, %t23
  br label %logical_and_right_end_18

logical_and_right_end_18:
  br label %logical_and_merge_18

logical_and_merge_18:
  %t25 = phi i1 [ false, %logical_and_entry_18 ], [ %t24, %logical_and_right_end_18 ]
  br label %logical_and_entry_17

logical_and_entry_17:
  br i1 %t25, label %logical_and_right_17, label %logical_and_merge_17

logical_and_right_17:
  %t26 = load double, double* %l4
  %t27 = sitofp i64 0 to double
  %t28 = fcmp oeq double %t26, %t27
  br label %logical_and_right_end_17

logical_and_right_end_17:
  br label %logical_and_merge_17

logical_and_merge_17:
  %t29 = phi i1 [ false, %logical_and_entry_17 ], [ %t28, %logical_and_right_end_17 ]
  store i1 %t29, i1* %l6
  %t30 = load i1, i1* %l6
  %t31 = load %Parser, %Parser* %l0
  %t32 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t33 = load double, double* %l2
  %t34 = load double, double* %l3
  %t35 = load double, double* %l4
  %t36 = load %Token, %Token* %l5
  %t37 = load i1, i1* %l6
  br i1 %t30, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t38 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t39 = load %Token, %Token* %l5
  %t40 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t38, %Token %t39)
  store { %Token*, i64 }* %t40, { %Token*, i64 }** %l1
  %t41 = load %Token, %Token* %l5
  %t42 = extractvalue %Token %t41, 0
  %t43 = load %Parser, %Parser* %l0
  %t44 = call %Parser @parser_advance_raw(%Parser %t43)
  store %Parser %t44, %Parser* %l7
  %t45 = load %Parser, %Parser* %l7
  %t46 = extractvalue %Parser %t45, 1
  %t47 = load %Parser, %Parser* %l0
  %t48 = extractvalue %Parser %t47, 1
  %t49 = fcmp oeq double %t46, %t48
  %t50 = load %Parser, %Parser* %l0
  %t51 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t52 = load double, double* %l2
  %t53 = load double, double* %l3
  %t54 = load double, double* %l4
  %t55 = load %Token, %Token* %l5
  %t56 = load i1, i1* %l6
  %t57 = load %Parser, %Parser* %l7
  br i1 %t49, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t58 = load %Parser, %Parser* %l7
  store %Parser %t58, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t59 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t60 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t63 = load %Parser, %Parser* %l0
  %t64 = insertvalue %CaptureResult undef, i8* null, 0
  %t65 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t66 = bitcast { %Token*, i64 }* %t65 to { i8**, i64 }*
  %t67 = insertvalue %CaptureResult %t64, { i8**, i64 }* %t66, 1
  ret %CaptureResult %t67
}

define %ParenthesizedParseResult @collect_parenthesized(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  %l2 = alloca { %Token*, i64 }*
  %l3 = alloca double
  %l4 = alloca %Token
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Token @parser_peek_raw(%Parser %t1)
  store %Token %t2, %Token* %l1
  %t4 = load %Token, %Token* %l1
  %t5 = extractvalue %Token %t4, 0
  %t6 = load %Parser, %Parser* %l0
  %t7 = call %Parser @parser_advance_raw(%Parser %t6)
  store %Parser %t7, %Parser* %l0
  %t8 = alloca [0 x %Token]
  %t9 = getelementptr [0 x %Token], [0 x %Token]* %t8, i32 0, i32 0
  %t10 = alloca { %Token*, i64 }
  %t11 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t10, i32 0, i32 0
  store %Token* %t9, %Token** %t11
  %t12 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { %Token*, i64 }* %t10, { %Token*, i64 }** %l2
  %t13 = sitofp i64 1 to double
  store double %t13, double* %l3
  %t14 = load %Parser, %Parser* %l0
  %t15 = load %Token, %Token* %l1
  %t16 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t17 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t31 = phi { %Token*, i64 }* [ %t16, %entry ], [ %t29, %loop.latch2 ]
  %t32 = phi %Parser [ %t14, %entry ], [ %t30, %loop.latch2 ]
  store { %Token*, i64 }* %t31, { %Token*, i64 }** %l2
  store %Parser %t32, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t18 = load %Parser, %Parser* %l0
  %t19 = call %Token @parser_peek_raw(%Parser %t18)
  store %Token %t19, %Token* %l4
  %t20 = load %Token, %Token* %l4
  %t21 = extractvalue %Token %t20, 0
  %t22 = load %Token, %Token* %l4
  %t23 = extractvalue %Token %t22, 0
  %t24 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t25 = load %Token, %Token* %l4
  %t26 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t24, %Token %t25)
  store { %Token*, i64 }* %t26, { %Token*, i64 }** %l2
  %t27 = load %Parser, %Parser* %l0
  %t28 = call %Parser @parser_advance_raw(%Parser %t27)
  store %Parser %t28, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t29 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t30 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t33 = load %Parser, %Parser* %l0
  %t34 = insertvalue %ParenthesizedParseResult undef, i8* null, 0
  %t35 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t36 = bitcast { %Token*, i64 }* %t35 to { i8**, i64 }*
  %t37 = insertvalue %ParenthesizedParseResult %t34, { i8**, i64 }* %t36, 1
  %t38 = insertvalue %ParenthesizedParseResult %t37, i1 1, 2
  ret %ParenthesizedParseResult %t38
}

define %PatternCaptureResult @collect_pattern_until_arrow(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca { %Token*, i64 }*
  %l2 = alloca %Token
  %l3 = alloca %Parser
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
  %t39 = phi { %Token*, i64 }* [ %t7, %entry ], [ %t37, %loop.latch2 ]
  %t40 = phi %Parser [ %t6, %entry ], [ %t38, %loop.latch2 ]
  store { %Token*, i64 }* %t39, { %Token*, i64 }** %l1
  store %Parser %t40, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t8 = load %Parser, %Parser* %l0
  %t9 = call %Token @parser_peek_raw(%Parser %t8)
  store %Token %t9, %Token* %l2
  %t10 = load %Token, %Token* %l2
  %t11 = extractvalue %Token %t10, 0
  %t12 = load %Token, %Token* %l2
  %t13 = extractvalue %Token %t12, 0
  %t14 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t15 = load %Token, %Token* %l2
  %t16 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t14, %Token %t15)
  store { %Token*, i64 }* %t16, { %Token*, i64 }** %l1
  %t17 = load %Parser, %Parser* %l0
  %t18 = call %Parser @parser_advance_raw(%Parser %t17)
  store %Parser %t18, %Parser* %l3
  %t19 = load %Parser, %Parser* %l3
  %t20 = extractvalue %Parser %t19, 1
  %t21 = load %Parser, %Parser* %l0
  %t22 = extractvalue %Parser %t21, 1
  %t23 = fcmp oeq double %t20, %t22
  %t24 = load %Parser, %Parser* %l0
  %t25 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t26 = load %Token, %Token* %l2
  %t27 = load %Parser, %Parser* %l3
  br i1 %t23, label %then4, label %merge5
then4:
  %t28 = insertvalue %PatternCaptureResult undef, i8* null, 0
  %t29 = alloca [0 x i8*]
  %t30 = getelementptr [0 x i8*], [0 x i8*]* %t29, i32 0, i32 0
  %t31 = alloca { i8**, i64 }
  %t32 = getelementptr { i8**, i64 }, { i8**, i64 }* %t31, i32 0, i32 0
  store i8** %t30, i8*** %t32
  %t33 = getelementptr { i8**, i64 }, { i8**, i64 }* %t31, i32 0, i32 1
  store i64 0, i64* %t33
  %t34 = insertvalue %PatternCaptureResult %t28, { i8**, i64 }* %t31, 1
  %t35 = insertvalue %PatternCaptureResult %t34, i1 0, 2
  ret %PatternCaptureResult %t35
merge5:
  %t36 = load %Parser, %Parser* %l3
  store %Parser %t36, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t37 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t38 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t41 = load %Parser, %Parser* %l0
  %t42 = insertvalue %PatternCaptureResult undef, i8* null, 0
  %t43 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t44 = bitcast { %Token*, i64 }* %t43 to { i8**, i64 }*
  %t45 = insertvalue %PatternCaptureResult %t42, { i8**, i64 }* %t44, 1
  %t46 = insertvalue %PatternCaptureResult %t45, i1 1, 2
  ret %PatternCaptureResult %t46
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
  %t6 = alloca [0 x i8*]
  %t7 = getelementptr [0 x i8*], [0 x i8*]* %t6, i32 0, i32 0
  %t8 = alloca { i8**, i64 }
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* %t8, i32 0, i32 0
  store i8** %t7, i8*** %t9
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
  %t11 = insertvalue %MatchCaseTokenSplit undef, { i8**, i64 }* %t8, 0
  %t12 = alloca [0 x i8*]
  %t13 = getelementptr [0 x i8*], [0 x i8*]* %t12, i32 0, i32 0
  %t14 = alloca { i8**, i64 }
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 0
  store i8** %t13, i8*** %t15
  %t16 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  %t17 = insertvalue %MatchCaseTokenSplit %t11, { i8**, i64 }* %t14, 1
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
  %t28 = bitcast { %Token*, i64 }* %t27 to { i8**, i64 }*
  %t29 = insertvalue %MatchCaseTokenSplit undef, { i8**, i64 }* %t28, 0
  %t30 = alloca [0 x i8*]
  %t31 = getelementptr [0 x i8*], [0 x i8*]* %t30, i32 0, i32 0
  %t32 = alloca { i8**, i64 }
  %t33 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 0
  store i8** %t31, i8*** %t33
  %t34 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 1
  store i64 0, i64* %t34
  %t35 = insertvalue %MatchCaseTokenSplit %t29, { i8**, i64 }* %t32, 1
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
  %t53 = bitcast { %Token*, i64 }* %t52 to { i8**, i64 }*
  %t54 = insertvalue %MatchCaseTokenSplit undef, { i8**, i64 }* %t53, 0
  %t55 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t56 = bitcast { %Token*, i64 }* %t55 to { i8**, i64 }*
  %t57 = insertvalue %MatchCaseTokenSplit %t54, { i8**, i64 }* %t56, 1
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
  %t67 = load %Token, %Token* %l1
  %t68 = extractvalue %Token %t67, 0
  %t69 = load %Token, %Token* %l1
  %t70 = extractvalue %Token %t69, 0
  br label %merge3
merge3:
  %t71 = extractvalue %Expression %expr, 0
  %t72 = alloca %Expression
  store %Expression %expr, %Expression* %t72
  %t73 = getelementptr inbounds %Expression, %Expression* %t72, i32 0, i32 1
  %t74 = bitcast [8 x i8]* %t73 to i8*
  %t75 = bitcast i8* %t74 to i8**
  %t76 = load i8*, i8** %t75
  %t77 = icmp eq i32 %t71, 15
  %t78 = select i1 %t77, i8* %t76, i8* null
  %t79 = call i8* @trim_text(i8* %t78)
  store i8* %t79, i8** %l2
  %t82 = load i8*, i8** %l2
  %t83 = call i64 @sailfin_runtime_string_length(i8* %t82)
  %t84 = icmp sge i64 %t83, 2
  br label %logical_and_entry_81

logical_and_entry_81:
  br i1 %t84, label %logical_and_right_81, label %logical_and_merge_81

logical_and_right_81:
  %t85 = load i8*, i8** %l2
  %t86 = getelementptr i8, i8* %t85, i64 0
  %t87 = load i8, i8* %t86
  %t88 = icmp eq i8 %t87, 34
  br label %logical_and_right_end_81

logical_and_right_end_81:
  br label %logical_and_merge_81

logical_and_merge_81:
  %t89 = phi i1 [ false, %logical_and_entry_81 ], [ %t88, %logical_and_right_end_81 ]
  br label %logical_and_entry_80

logical_and_entry_80:
  br i1 %t89, label %logical_and_right_80, label %logical_and_merge_80

logical_and_right_80:
  %t90 = load i8*, i8** %l2
  %s91 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.91, i32 0, i32 0
  %t92 = icmp eq i8* %t90, %s91
  %t93 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t94 = load i8*, i8** %l2
  br i1 %t92, label %then4, label %merge5
then4:
  %t95 = alloca %Expression
  %t96 = getelementptr inbounds %Expression, %Expression* %t95, i32 0, i32 0
  store i32 3, i32* %t96
  %t97 = getelementptr inbounds %Expression, %Expression* %t95, i32 0, i32 1
  %t98 = bitcast [1 x i8]* %t97 to i8*
  %t99 = bitcast i8* %t98 to i1*
  store i1 1, i1* %t99
  %t100 = load %Expression, %Expression* %t95
  ret %Expression %t100
merge5:
  %t101 = load i8*, i8** %l2
  %s102 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.102, i32 0, i32 0
  %t103 = icmp eq i8* %t101, %s102
  %t104 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t105 = load i8*, i8** %l2
  br i1 %t103, label %then6, label %merge7
then6:
  %t106 = alloca %Expression
  %t107 = getelementptr inbounds %Expression, %Expression* %t106, i32 0, i32 0
  store i32 3, i32* %t107
  %t108 = getelementptr inbounds %Expression, %Expression* %t106, i32 0, i32 1
  %t109 = bitcast [1 x i8]* %t108 to i8*
  %t110 = bitcast i8* %t109 to i1*
  store i1 0, i1* %t110
  %t111 = load %Expression, %Expression* %t106
  ret %Expression %t111
merge7:
  %t112 = load i8*, i8** %l2
  %t113 = call i1 @looks_like_number(i8* %t112)
  %t114 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t115 = load i8*, i8** %l2
  br i1 %t113, label %then8, label %merge9
then8:
  %t116 = alloca %Expression
  %t117 = getelementptr inbounds %Expression, %Expression* %t116, i32 0, i32 0
  store i32 1, i32* %t117
  %t118 = load i8*, i8** %l2
  %t119 = getelementptr inbounds %Expression, %Expression* %t116, i32 0, i32 1
  %t120 = bitcast [8 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to i8**
  store i8* %t118, i8** %t121
  %t122 = load %Expression, %Expression* %t116
  ret %Expression %t122
merge9:
  br label %merge1
merge1:
  ret %Expression %expr
}

define i1 @looks_like_number(i8* %text) {
entry:
  %l0 = alloca i1
  %l1 = alloca double
  %l2 = alloca i8
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  store i1 0, i1* %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  %t3 = getelementptr i8, i8* %text, i64 0
  %t4 = load i8, i8* %t3
  %t5 = load i1, i1* %l0
  %t6 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t40 = phi i1 [ %t5, %entry ], [ %t38, %loop.latch4 ]
  %t41 = phi double [ %t6, %entry ], [ %t39, %loop.latch4 ]
  store i1 %t40, i1* %l0
  store double %t41, double* %l1
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l1
  %t8 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t7, %t9
  %t11 = load i1, i1* %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = load double, double* %l1
  %t14 = fptosi double %t13 to i64
  %t15 = getelementptr i8, i8* %text, i64 %t14
  %t16 = load i8, i8* %t15
  store i8 %t16, i8* %l2
  %t17 = load i8, i8* %l2
  %t18 = icmp eq i8 %t17, 46
  %t19 = load i1, i1* %l0
  %t20 = load double, double* %l1
  %t21 = load i8, i8* %l2
  br i1 %t18, label %then8, label %merge9
then8:
  %t22 = load i1, i1* %l0
  %t23 = load i1, i1* %l0
  %t24 = load double, double* %l1
  %t25 = load i8, i8* %l2
  br i1 %t22, label %then10, label %merge11
then10:
  ret i1 0
merge11:
  store i1 1, i1* %l0
  %t26 = load double, double* %l1
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  store double %t28, double* %l1
  br label %loop.latch4
merge9:
  %t29 = load i8, i8* %l2
  %t30 = call i1 @sailfin_runtime_is_decimal_digit(i8* null)
  %t31 = xor i1 %t30, 1
  %t32 = load i1, i1* %l0
  %t33 = load double, double* %l1
  %t34 = load i8, i8* %l2
  br i1 %t31, label %then12, label %merge13
then12:
  ret i1 0
merge13:
  %t35 = load double, double* %l1
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l1
  br label %loop.latch4
loop.latch4:
  %t38 = load i1, i1* %l0
  %t39 = load double, double* %l1
  br label %loop.header2
afterloop5:
  ret i1 1
}

define i1 @is_decimal_digit(i8* %ch) {
entry:
  %t9 = getelementptr i8, i8* %ch, i64 0
  %t10 = load i8, i8* %t9
  %t11 = icmp eq i8 %t10, 48
  br label %logical_or_entry_8

logical_or_entry_8:
  br i1 %t11, label %logical_or_merge_8, label %logical_or_right_8

logical_or_right_8:
  %t12 = getelementptr i8, i8* %ch, i64 0
  %t13 = load i8, i8* %t12
  %t14 = icmp eq i8 %t13, 49
  br label %logical_or_right_end_8

logical_or_right_end_8:
  br label %logical_or_merge_8

logical_or_merge_8:
  %t15 = phi i1 [ true, %logical_or_entry_8 ], [ %t14, %logical_or_right_end_8 ]
  br label %logical_or_entry_7

logical_or_entry_7:
  br i1 %t15, label %logical_or_merge_7, label %logical_or_right_7

logical_or_right_7:
  %t16 = getelementptr i8, i8* %ch, i64 0
  %t17 = load i8, i8* %t16
  %t18 = icmp eq i8 %t17, 50
  br label %logical_or_right_end_7

logical_or_right_end_7:
  br label %logical_or_merge_7

logical_or_merge_7:
  %t19 = phi i1 [ true, %logical_or_entry_7 ], [ %t18, %logical_or_right_end_7 ]
  br label %logical_or_entry_6

logical_or_entry_6:
  br i1 %t19, label %logical_or_merge_6, label %logical_or_right_6

logical_or_right_6:
  %t20 = getelementptr i8, i8* %ch, i64 0
  %t21 = load i8, i8* %t20
  %t22 = icmp eq i8 %t21, 51
  br label %logical_or_right_end_6

logical_or_right_end_6:
  br label %logical_or_merge_6

logical_or_merge_6:
  %t23 = phi i1 [ true, %logical_or_entry_6 ], [ %t22, %logical_or_right_end_6 ]
  br label %logical_or_entry_5

logical_or_entry_5:
  br i1 %t23, label %logical_or_merge_5, label %logical_or_right_5

logical_or_right_5:
  %t24 = getelementptr i8, i8* %ch, i64 0
  %t25 = load i8, i8* %t24
  %t26 = icmp eq i8 %t25, 52
  br label %logical_or_right_end_5

logical_or_right_end_5:
  br label %logical_or_merge_5

logical_or_merge_5:
  %t27 = phi i1 [ true, %logical_or_entry_5 ], [ %t26, %logical_or_right_end_5 ]
  br label %logical_or_entry_4

logical_or_entry_4:
  br i1 %t27, label %logical_or_merge_4, label %logical_or_right_4

logical_or_right_4:
  %t28 = getelementptr i8, i8* %ch, i64 0
  %t29 = load i8, i8* %t28
  %t30 = icmp eq i8 %t29, 53
  br label %logical_or_right_end_4

logical_or_right_end_4:
  br label %logical_or_merge_4

logical_or_merge_4:
  %t31 = phi i1 [ true, %logical_or_entry_4 ], [ %t30, %logical_or_right_end_4 ]
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t31, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %t32 = getelementptr i8, i8* %ch, i64 0
  %t33 = load i8, i8* %t32
  %t34 = icmp eq i8 %t33, 54
  br label %logical_or_right_end_3

logical_or_right_end_3:
  br label %logical_or_merge_3

logical_or_merge_3:
  %t35 = phi i1 [ true, %logical_or_entry_3 ], [ %t34, %logical_or_right_end_3 ]
  br label %logical_or_entry_2

logical_or_entry_2:
  br i1 %t35, label %logical_or_merge_2, label %logical_or_right_2

logical_or_right_2:
  %t36 = getelementptr i8, i8* %ch, i64 0
  %t37 = load i8, i8* %t36
  %t38 = icmp eq i8 %t37, 55
  br label %logical_or_right_end_2

logical_or_right_end_2:
  br label %logical_or_merge_2

logical_or_merge_2:
  %t39 = phi i1 [ true, %logical_or_entry_2 ], [ %t38, %logical_or_right_end_2 ]
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t39, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %t40 = getelementptr i8, i8* %ch, i64 0
  %t41 = load i8, i8* %t40
  %t42 = icmp eq i8 %t41, 56
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t43 = phi i1 [ true, %logical_or_entry_1 ], [ %t42, %logical_or_right_end_1 ]
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t43, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t44 = getelementptr i8, i8* %ch, i64 0
  %t45 = load i8, i8* %t44
  %t46 = icmp eq i8 %t45, 57
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
  %t30 = phi double [ %t6, %entry ], [ %t29, %loop.latch2 ]
  store double %t30, double* %l1
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
  %t26 = load double, double* %l1
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  store double %t28, double* %l1
  br label %loop.latch2
loop.latch2:
  %t29 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t31 = load double, double* %l2
  %t32 = sitofp i64 0 to double
  %t33 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %tokens, double %t32, double %t31)
  ret { %Token*, i64 }* %t33
}

define double @find_top_level_colon({ %Token*, i64 }* %tokens) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca %Token
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
  %t34 = phi double [ %t9, %entry ], [ %t33, %loop.latch2 ]
  store double %t34, double* %l4
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
  %t30 = load double, double* %l4
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l4
  br label %loop.latch2
loop.latch2:
  %t33 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t35 = sitofp i64 -1 to double
  ret double %t35
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
  %t28 = bitcast { %Token*, i64 }* %t27 to { i8**, i64 }*
  %t29 = insertvalue %ExpressionTokens undef, { i8**, i64 }* %t28, 0
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
  %t51 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  %t52 = extractvalue %ExpressionParseResult %t51, 1
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
  %t63 = phi { %Token*, i64 }* [ %t10, %entry ], [ %t61, %loop.latch2 ]
  %t64 = phi %ExpressionTokens [ %t9, %entry ], [ %t62, %loop.latch2 ]
  store { %Token*, i64 }* %t63, { %Token*, i64 }** %l1
  store %ExpressionTokens %t64, %ExpressionTokens* %l0
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
  %t24 = insertvalue %ExpressionCollectResult undef, i8* null, 0
  %t25 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t26 = bitcast { %Token*, i64 }* %t25 to { i8**, i64 }*
  %t27 = insertvalue %ExpressionCollectResult %t24, { i8**, i64 }* %t26, 1
  %t28 = insertvalue %ExpressionCollectResult %t27, i1 0, 2
  ret %ExpressionCollectResult %t28
merge5:
  %t29 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t30 = call %Token @expression_tokens_peek(%ExpressionTokens %t29)
  store %Token %t30, %Token* %l6
  %t34 = load double, double* %l2
  %t35 = sitofp i64 0 to double
  %t36 = fcmp oeq double %t34, %t35
  br label %logical_and_entry_33

logical_and_entry_33:
  br i1 %t36, label %logical_and_right_33, label %logical_and_merge_33

logical_and_right_33:
  %t37 = load double, double* %l3
  %t38 = sitofp i64 0 to double
  %t39 = fcmp oeq double %t37, %t38
  br label %logical_and_right_end_33

logical_and_right_end_33:
  br label %logical_and_merge_33

logical_and_merge_33:
  %t40 = phi i1 [ false, %logical_and_entry_33 ], [ %t39, %logical_and_right_end_33 ]
  br label %logical_and_entry_32

logical_and_entry_32:
  br i1 %t40, label %logical_and_right_32, label %logical_and_merge_32

logical_and_right_32:
  %t41 = load double, double* %l4
  %t42 = sitofp i64 0 to double
  %t43 = fcmp oeq double %t41, %t42
  br label %logical_and_right_end_32

logical_and_right_end_32:
  br label %logical_and_merge_32

logical_and_merge_32:
  %t44 = phi i1 [ false, %logical_and_entry_32 ], [ %t43, %logical_and_right_end_32 ]
  br label %logical_and_entry_31

logical_and_entry_31:
  br i1 %t44, label %logical_and_right_31, label %logical_and_merge_31

logical_and_right_31:
  %t45 = load double, double* %l5
  %t46 = sitofp i64 0 to double
  %t47 = fcmp oeq double %t45, %t46
  br label %logical_and_right_end_31

logical_and_right_end_31:
  br label %logical_and_merge_31

logical_and_merge_31:
  %t48 = phi i1 [ false, %logical_and_entry_31 ], [ %t47, %logical_and_right_end_31 ]
  store i1 %t48, i1* %l7
  %t51 = load i1, i1* %l7
  br label %logical_and_entry_50

logical_and_entry_50:
  br i1 %t51, label %logical_and_right_50, label %logical_and_merge_50

logical_and_right_50:
  %t52 = load %Token, %Token* %l6
  %t53 = extractvalue %Token %t52, 0
  %t54 = load %Token, %Token* %l6
  %t55 = extractvalue %Token %t54, 0
  %t56 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t57 = load %Token, %Token* %l6
  %t58 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t56, %Token %t57)
  store { %Token*, i64 }* %t58, { %Token*, i64 }** %l1
  %t59 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t60 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t59)
  store %ExpressionTokens %t60, %ExpressionTokens* %l0
  br label %loop.latch2
loop.latch2:
  %t61 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t62 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header0
afterloop3:
  %t65 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t66 = insertvalue %ExpressionCollectResult undef, i8* null, 0
  %t67 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t68 = bitcast { %Token*, i64 }* %t67 to { i8**, i64 }*
  %t69 = insertvalue %ExpressionCollectResult %t66, { i8**, i64 }* %t68, 1
  %t70 = insertvalue %ExpressionCollectResult %t69, i1 1, 2
  ret %ExpressionCollectResult %t70
}

define %ExpressionBlockParseResult @collect_expression_block(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca %Token
  %l2 = alloca { %Token*, i64 }*
  %l3 = alloca double
  %l4 = alloca %Token
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  %t0 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t1 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t0)
  %t2 = load %ExpressionTokens, %ExpressionTokens* %l0
  br i1 %t1, label %then0, label %merge1
then0:
  %t3 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t4 = insertvalue %ExpressionBlockParseResult undef, i8* null, 0
  %t5 = alloca [0 x i8*]
  %t6 = getelementptr [0 x i8*], [0 x i8*]* %t5, i32 0, i32 0
  %t7 = alloca { i8**, i64 }
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t7, i32 0, i32 0
  store i8** %t6, i8*** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  %t10 = insertvalue %ExpressionBlockParseResult %t4, { i8**, i64 }* %t7, 1
  %t11 = insertvalue %ExpressionBlockParseResult %t10, i1 0, 2
  ret %ExpressionBlockParseResult %t11
merge1:
  %t12 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t13 = call %Token @expression_tokens_peek(%ExpressionTokens %t12)
  store %Token %t13, %Token* %l1
  %t15 = load %Token, %Token* %l1
  %t16 = extractvalue %Token %t15, 0
  %t17 = alloca [0 x %Token]
  %t18 = getelementptr [0 x %Token], [0 x %Token]* %t17, i32 0, i32 0
  %t19 = alloca { %Token*, i64 }
  %t20 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t19, i32 0, i32 0
  store %Token* %t18, %Token** %t20
  %t21 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t19, i32 0, i32 1
  store i64 0, i64* %t21
  store { %Token*, i64 }* %t19, { %Token*, i64 }** %l2
  %t22 = sitofp i64 0 to double
  store double %t22, double* %l3
  %t23 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t24 = load %Token, %Token* %l1
  %t25 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t26 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t50 = phi { %Token*, i64 }* [ %t25, %entry ], [ %t48, %loop.latch4 ]
  %t51 = phi %ExpressionTokens [ %t23, %entry ], [ %t49, %loop.latch4 ]
  store { %Token*, i64 }* %t50, { %Token*, i64 }** %l2
  store %ExpressionTokens %t51, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t27 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t28 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t27)
  %t29 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t30 = load %Token, %Token* %l1
  %t31 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t32 = load double, double* %l3
  br i1 %t28, label %then6, label %merge7
then6:
  %t33 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t34 = insertvalue %ExpressionBlockParseResult undef, i8* null, 0
  %t35 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t36 = bitcast { %Token*, i64 }* %t35 to { i8**, i64 }*
  %t37 = insertvalue %ExpressionBlockParseResult %t34, { i8**, i64 }* %t36, 1
  %t38 = insertvalue %ExpressionBlockParseResult %t37, i1 0, 2
  ret %ExpressionBlockParseResult %t38
merge7:
  %t39 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t40 = call %Token @expression_tokens_peek(%ExpressionTokens %t39)
  store %Token %t40, %Token* %l4
  %t41 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t42 = load %Token, %Token* %l4
  %t43 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t41, %Token %t42)
  store { %Token*, i64 }* %t43, { %Token*, i64 }** %l2
  %t44 = load %Token, %Token* %l4
  %t45 = extractvalue %Token %t44, 0
  %t46 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t47 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t46)
  store %ExpressionTokens %t47, %ExpressionTokens* %l0
  br label %loop.latch4
loop.latch4:
  %t48 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t49 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t52 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t53 = insertvalue %ExpressionBlockParseResult undef, i8* null, 0
  %t54 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t55 = bitcast { %Token*, i64 }* %t54 to { i8**, i64 }*
  %t56 = insertvalue %ExpressionBlockParseResult %t53, { i8**, i64 }* %t55, 1
  %t57 = insertvalue %ExpressionBlockParseResult %t56, i1 1, 2
  ret %ExpressionBlockParseResult %t57
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
  %t4 = insertvalue %LambdaParameterParseResult undef, i8* null, 0
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.5, i32 0, i32 0
  %t6 = insertvalue %Parameter undef, i8* %s5, 0
  %t7 = insertvalue %Parameter %t6, i8* null, 1
  %t8 = insertvalue %Parameter %t7, i8* null, 2
  %t9 = insertvalue %Parameter %t8, i1 0, 3
  %t10 = insertvalue %Parameter %t9, i8* null, 4
  %t11 = insertvalue %LambdaParameterParseResult %t4, i8* null, 1
  %t12 = insertvalue %LambdaParameterParseResult %t11, i1 0, 2
  ret %LambdaParameterParseResult %t12
merge1:
  %t13 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t14 = extractvalue %ExpressionTokens %t13, 1
  store double %t14, double* %l1
  store i1 0, i1* %l2
  %t15 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t16 = call %Token @expression_tokens_peek(%ExpressionTokens %t15)
  store %Token %t16, %Token* %l3
  %t18 = load %Token, %Token* %l3
  %t19 = extractvalue %Token %t18, 0
  %t20 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t21 = call %Token @expression_tokens_peek(%ExpressionTokens %t20)
  store %Token %t21, %Token* %l4
  %t22 = load %Token, %Token* %l4
  %t23 = extractvalue %Token %t22, 0
  %t24 = load %Token, %Token* %l4
  %t25 = call i8* @identifier_text(%Token %t24)
  store i8* %t25, i8** %l5
  %t26 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t27 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t26)
  store %ExpressionTokens %t27, %ExpressionTokens* %l0
  store i8* null, i8** %l6
  %t28 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t29 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t28)
  %t30 = xor i1 %t29, 1
  %t31 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t32 = load double, double* %l1
  %t33 = load i1, i1* %l2
  %t34 = load %Token, %Token* %l3
  %t35 = load %Token, %Token* %l4
  %t36 = load i8*, i8** %l5
  %t37 = load i8*, i8** %l6
  br i1 %t30, label %then2, label %merge3
then2:
  %t38 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t39 = call %Token @expression_tokens_peek(%ExpressionTokens %t38)
  store %Token %t39, %Token* %l7
  %t42 = load %Token, %Token* %l7
  %t43 = extractvalue %Token %t42, 0
  br label %merge3
merge3:
  store i8* null, i8** %l8
  %t44 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t45 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t44)
  %t46 = xor i1 %t45, 1
  %t47 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t48 = load double, double* %l1
  %t49 = load i1, i1* %l2
  %t50 = load %Token, %Token* %l3
  %t51 = load %Token, %Token* %l4
  %t52 = load i8*, i8** %l5
  %t53 = load i8*, i8** %l6
  %t54 = load i8*, i8** %l8
  br i1 %t46, label %then4, label %merge5
then4:
  %t55 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t56 = call %Token @expression_tokens_peek(%ExpressionTokens %t55)
  store %Token %t56, %Token* %l9
  %t58 = load %Token, %Token* %l9
  %t59 = extractvalue %Token %t58, 0
  br label %merge5
merge5:
  %t60 = extractvalue %ExpressionTokens %state, 0
  %t61 = load double, double* %l1
  %t62 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t63 = extractvalue %ExpressionTokens %t62, 1
  %t64 = bitcast { i8**, i64 }* %t60 to { %Token*, i64 }*
  %t65 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t64, double %t61, double %t63)
  store { %Token*, i64 }* %t65, { %Token*, i64 }** %l10
  %t66 = load { %Token*, i64 }*, { %Token*, i64 }** %l10
  %t67 = call double @source_span_from_tokens({ %Token*, i64 }* %t66)
  store double %t67, double* %l11
  %t68 = load i8*, i8** %l5
  %t69 = insertvalue %Parameter undef, i8* %t68, 0
  %t70 = load i8*, i8** %l6
  %t71 = insertvalue %Parameter %t69, i8* %t70, 1
  %t72 = load i8*, i8** %l8
  %t73 = insertvalue %Parameter %t71, i8* %t72, 2
  %t74 = load i1, i1* %l2
  %t75 = insertvalue %Parameter %t73, i1 %t74, 3
  %t76 = load double, double* %l11
  %t77 = insertvalue %Parameter %t75, i8* null, 4
  store %Parameter %t77, %Parameter* %l12
  %t78 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t79 = insertvalue %LambdaParameterParseResult undef, i8* null, 0
  %t80 = load %Parameter, %Parameter* %l12
  %t81 = insertvalue %LambdaParameterParseResult %t79, i8* null, 1
  %t82 = insertvalue %LambdaParameterParseResult %t81, i1 1, 2
  ret %LambdaParameterParseResult %t82
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
  %t10 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t11 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t12 = bitcast { %Parameter*, i64 }* %t11 to { i8**, i64 }*
  %t13 = insertvalue %LambdaParameterListParseResult %t10, { i8**, i64 }* %t12, 1
  %t14 = insertvalue %LambdaParameterListParseResult %t13, i1 0, 2
  ret %LambdaParameterListParseResult %t14
merge1:
  %t15 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t16 = call %Token @expression_tokens_peek(%ExpressionTokens %t15)
  store %Token %t16, %Token* %l2
  %t17 = load %Token, %Token* %l2
  %t18 = extractvalue %Token %t17, 0
  %t19 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t20 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t21 = load %Token, %Token* %l2
  br label %loop.header2
loop.header2:
  %t67 = phi { %Parameter*, i64 }* [ %t20, %entry ], [ %t65, %loop.latch4 ]
  %t68 = phi %ExpressionTokens [ %t19, %entry ], [ %t66, %loop.latch4 ]
  store { %Parameter*, i64 }* %t67, { %Parameter*, i64 }** %l1
  store %ExpressionTokens %t68, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t22 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t23 = call %LambdaParameterParseResult @parse_lambda_parameter(%ExpressionTokens %t22)
  store %LambdaParameterParseResult %t23, %LambdaParameterParseResult* %l3
  %t24 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  %t25 = extractvalue %LambdaParameterParseResult %t24, 2
  %t26 = xor i1 %t25, 1
  %t27 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t28 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t29 = load %Token, %Token* %l2
  %t30 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  br i1 %t26, label %then6, label %merge7
then6:
  %t31 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t32 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t33 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t34 = bitcast { %Parameter*, i64 }* %t33 to { i8**, i64 }*
  %t35 = insertvalue %LambdaParameterListParseResult %t32, { i8**, i64 }* %t34, 1
  %t36 = insertvalue %LambdaParameterListParseResult %t35, i1 0, 2
  ret %LambdaParameterListParseResult %t36
merge7:
  %t37 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t38 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  %t39 = extractvalue %LambdaParameterParseResult %t38, 1
  %t40 = call { %Parameter*, i64 }* @append_parameter({ %Parameter*, i64 }* %t37, %Parameter zeroinitializer)
  store { %Parameter*, i64 }* %t40, { %Parameter*, i64 }** %l1
  %t41 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  %t42 = extractvalue %LambdaParameterParseResult %t41, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t43 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t44 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t43)
  %t45 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t46 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t47 = load %Token, %Token* %l2
  %t48 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  br i1 %t44, label %then8, label %merge9
then8:
  %t49 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t50 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t51 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t52 = bitcast { %Parameter*, i64 }* %t51 to { i8**, i64 }*
  %t53 = insertvalue %LambdaParameterListParseResult %t50, { i8**, i64 }* %t52, 1
  %t54 = insertvalue %LambdaParameterListParseResult %t53, i1 0, 2
  ret %LambdaParameterListParseResult %t54
merge9:
  %t55 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t56 = call %Token @expression_tokens_peek(%ExpressionTokens %t55)
  store %Token %t56, %Token* %l4
  %t57 = load %Token, %Token* %l4
  %t58 = extractvalue %Token %t57, 0
  %t59 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t60 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t61 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t62 = bitcast { %Parameter*, i64 }* %t61 to { i8**, i64 }*
  %t63 = insertvalue %LambdaParameterListParseResult %t60, { i8**, i64 }* %t62, 1
  %t64 = insertvalue %LambdaParameterListParseResult %t63, i1 0, 2
  ret %LambdaParameterListParseResult %t64
loop.latch4:
  %t65 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t66 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t69 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t70 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t71 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t72 = bitcast { %Parameter*, i64 }* %t71 to { i8**, i64 }*
  %t73 = insertvalue %LambdaParameterListParseResult %t70, { i8**, i64 }* %t72, 1
  %t74 = insertvalue %LambdaParameterListParseResult %t73, i1 1, 2
  ret %LambdaParameterListParseResult %t74
}

define %ExpressionParseResult @parse_lambda_expression(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca %Token
  %l2 = alloca %Token
  %l3 = alloca %LambdaParameterListParseResult
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca i8*
  %l6 = alloca %Token
  %l7 = alloca %ExpressionBlockParseResult
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca %Parser
  %l10 = alloca %BlockParseResult
  %l11 = alloca i8*
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
  %t9 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t10 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t9)
  store %ExpressionTokens %t10, %ExpressionTokens* %l0
  %t11 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t12 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t11)
  %t13 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t14 = load %Token, %Token* %l1
  br i1 %t12, label %then2, label %merge3
then2:
  %t15 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t15
merge3:
  %t16 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t17 = call %Token @expression_tokens_peek(%ExpressionTokens %t16)
  store %Token %t17, %Token* %l2
  %t19 = load %Token, %Token* %l2
  %t20 = extractvalue %Token %t19, 0
  %t21 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t22 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t21)
  store %ExpressionTokens %t22, %ExpressionTokens* %l0
  %t23 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t24 = call %LambdaParameterListParseResult @parse_lambda_parameter_list(%ExpressionTokens %t23)
  store %LambdaParameterListParseResult %t24, %LambdaParameterListParseResult* %l3
  %t25 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t26 = extractvalue %LambdaParameterListParseResult %t25, 2
  %t27 = xor i1 %t26, 1
  %t28 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t29 = load %Token, %Token* %l1
  %t30 = load %Token, %Token* %l2
  %t31 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  br i1 %t27, label %then4, label %merge5
then4:
  %t32 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t32
merge5:
  %t33 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t34 = extractvalue %LambdaParameterListParseResult %t33, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t35 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t36 = extractvalue %LambdaParameterListParseResult %t35, 1
  store { i8**, i64 }* %t36, { i8**, i64 }** %l4
  store i8* null, i8** %l5
  %t37 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t38 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t37)
  %t39 = xor i1 %t38, 1
  %t40 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t41 = load %Token, %Token* %l1
  %t42 = load %Token, %Token* %l2
  %t43 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t45 = load i8*, i8** %l5
  br i1 %t39, label %then6, label %merge7
then6:
  %t46 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t47 = call %Token @expression_tokens_peek(%ExpressionTokens %t46)
  store %Token %t47, %Token* %l6
  %t50 = load %Token, %Token* %l6
  %t51 = extractvalue %Token %t50, 0
  br label %merge7
merge7:
  %t52 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t53 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t52)
  %t54 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t55 = load %Token, %Token* %l1
  %t56 = load %Token, %Token* %l2
  %t57 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t59 = load i8*, i8** %l5
  br i1 %t53, label %then8, label %merge9
then8:
  %t60 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t60
merge9:
  %t61 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t62 = call %ExpressionBlockParseResult @collect_expression_block(%ExpressionTokens %t61)
  store %ExpressionBlockParseResult %t62, %ExpressionBlockParseResult* %l7
  %t63 = load %ExpressionBlockParseResult, %ExpressionBlockParseResult* %l7
  %t64 = extractvalue %ExpressionBlockParseResult %t63, 2
  %t65 = xor i1 %t64, 1
  %t66 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t67 = load %Token, %Token* %l1
  %t68 = load %Token, %Token* %l2
  %t69 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t71 = load i8*, i8** %l5
  %t72 = load %ExpressionBlockParseResult, %ExpressionBlockParseResult* %l7
  br i1 %t65, label %then10, label %merge11
then10:
  %t73 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t73
merge11:
  %t74 = load %ExpressionBlockParseResult, %ExpressionBlockParseResult* %l7
  %t75 = extractvalue %ExpressionBlockParseResult %t74, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t76 = load %ExpressionBlockParseResult, %ExpressionBlockParseResult* %l7
  %t77 = extractvalue %ExpressionBlockParseResult %t76, 1
  store { i8**, i64 }* %t77, { i8**, i64 }** %l8
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t79 = insertvalue %TokenKind undef, i32 7, 0
  %t80 = insertvalue %Token undef, i8* null, 0
  %s81 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.81, i32 0, i32 0
  %t82 = insertvalue %Token %t80, i8* %s81, 1
  %t83 = sitofp i64 0 to double
  %t84 = insertvalue %Token %t82, double %t83, 2
  %t85 = sitofp i64 0 to double
  %t86 = insertvalue %Token %t84, double %t85, 3
  %t87 = bitcast { i8**, i64 }* %t78 to { %Token*, i64 }*
  %t88 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t87, %Token %t86)
  %t89 = bitcast { %Token*, i64 }* %t88 to { i8**, i64 }*
  store { i8**, i64 }* %t89, { i8**, i64 }** %l8
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t91 = insertvalue %Parser undef, { i8**, i64 }* %t90, 0
  %t92 = sitofp i64 0 to double
  %t93 = insertvalue %Parser %t91, double %t92, 1
  store %Parser %t93, %Parser* %l9
  %t94 = load %Parser, %Parser* %l9
  %t95 = call %BlockParseResult @parse_block(%Parser %t94)
  store %BlockParseResult %t95, %BlockParseResult* %l10
  %t96 = load %BlockParseResult, %BlockParseResult* %l10
  %t97 = extractvalue %BlockParseResult %t96, 1
  store i8* %t97, i8** %l11
  %t98 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t99 = insertvalue %ExpressionParseResult undef, i8* null, 0
  %t100 = alloca %Expression
  %t101 = getelementptr inbounds %Expression, %Expression* %t100, i32 0, i32 0
  store i32 13, i32* %t101
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t103 = getelementptr inbounds %Expression, %Expression* %t100, i32 0, i32 1
  %t104 = bitcast [24 x i8]* %t103 to i8*
  %t105 = bitcast i8* %t104 to { i8**, i64 }**
  store { i8**, i64 }* %t102, { i8**, i64 }** %t105
  %t106 = load i8*, i8** %l11
  %t107 = getelementptr inbounds %Expression, %Expression* %t100, i32 0, i32 1
  %t108 = bitcast [24 x i8]* %t107 to i8*
  %t109 = getelementptr inbounds i8, i8* %t108, i64 8
  %t110 = bitcast i8* %t109 to i8**
  store i8* %t106, i8** %t110
  %t111 = load i8*, i8** %l5
  %t112 = getelementptr inbounds %Expression, %Expression* %t100, i32 0, i32 1
  %t113 = bitcast [24 x i8]* %t112 to i8*
  %t114 = getelementptr inbounds i8, i8* %t113, i64 16
  %t115 = bitcast i8* %t114 to i8**
  store i8* %t111, i8** %t115
  %t116 = load %Expression, %Expression* %t100
  %t117 = insertvalue %ExpressionParseResult %t99, i8* null, 1
  %t118 = insertvalue %ExpressionParseResult %t117, i1 1, 2
  ret %ExpressionParseResult %t118
}

define %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %state, double %min_precedence) {
entry:
  %l0 = alloca %ExpressionParseResult
  %l1 = alloca i8*
  %l2 = alloca i8*
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
  store i8* %t7, i8** %l1
  %t8 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t9 = extractvalue %ExpressionParseResult %t8, 1
  store i8* %t9, i8** %l2
  %t10 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t11 = load i8*, i8** %l1
  %t12 = load i8*, i8** %l2
  br label %loop.header2
loop.header2:
  %t66 = phi i8* [ %t11, %entry ], [ %t65, %loop.latch4 ]
  store i8* %t66, i8** %l1
  br label %loop.body3
loop.body3:
  %t13 = load i8*, i8** %l1
  %t14 = call i1 @expression_tokens_is_at_end(%ExpressionTokens zeroinitializer)
  %t15 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t16 = load i8*, i8** %l1
  %t17 = load i8*, i8** %l2
  br i1 %t14, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t18 = load i8*, i8** %l1
  %t19 = call %Token @expression_tokens_peek(%ExpressionTokens zeroinitializer)
  store %Token %t19, %Token* %l3
  %t20 = load %Token, %Token* %l3
  %t21 = extractvalue %Token %t20, 0
  %t22 = load %Token, %Token* %l3
  %t23 = extractvalue %Token %t22, 0
  store double 0.0, double* %l4
  %t24 = load double, double* %l4
  %t25 = call double @binary_precedence(i8* null)
  store double %t25, double* %l5
  %t26 = load double, double* %l5
  %t27 = sitofp i64 -1 to double
  %t28 = fcmp oeq double %t26, %t27
  %t29 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t30 = load i8*, i8** %l1
  %t31 = load i8*, i8** %l2
  %t32 = load %Token, %Token* %l3
  %t33 = load double, double* %l4
  %t34 = load double, double* %l5
  br i1 %t28, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t35 = load double, double* %l5
  %t36 = fcmp olt double %t35, %min_precedence
  %t37 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t38 = load i8*, i8** %l1
  %t39 = load i8*, i8** %l2
  %t40 = load %Token, %Token* %l3
  %t41 = load double, double* %l4
  %t42 = load double, double* %l5
  br i1 %t36, label %then10, label %merge11
then10:
  br label %afterloop5
merge11:
  %t43 = load i8*, i8** %l1
  %t44 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens zeroinitializer)
  store i8* null, i8** %l1
  %t45 = load i8*, i8** %l1
  %t46 = load double, double* %l5
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  %t49 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens zeroinitializer, double %t48)
  store %ExpressionParseResult %t49, %ExpressionParseResult* %l6
  %t50 = load %ExpressionParseResult, %ExpressionParseResult* %l6
  %t51 = extractvalue %ExpressionParseResult %t50, 2
  %t52 = xor i1 %t51, 1
  %t53 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t54 = load i8*, i8** %l1
  %t55 = load i8*, i8** %l2
  %t56 = load %Token, %Token* %l3
  %t57 = load double, double* %l4
  %t58 = load double, double* %l5
  %t59 = load %ExpressionParseResult, %ExpressionParseResult* %l6
  br i1 %t52, label %then12, label %merge13
then12:
  %t60 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t60
merge13:
  %t61 = load %ExpressionParseResult, %ExpressionParseResult* %l6
  %t62 = extractvalue %ExpressionParseResult %t61, 0
  store i8* %t62, i8** %l1
  %t63 = load double, double* %l4
  %s64 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.64, i32 0, i32 0
  br label %loop.latch4
loop.latch4:
  %t65 = load i8*, i8** %l1
  br label %loop.header2
afterloop5:
  %t67 = load i8*, i8** %l1
  %t68 = insertvalue %ExpressionParseResult undef, i8* %t67, 0
  %t69 = load i8*, i8** %l2
  %t70 = insertvalue %ExpressionParseResult %t68, i8* %t69, 1
  %t71 = insertvalue %ExpressionParseResult %t70, i1 1, 2
  ret %ExpressionParseResult %t71
}

define %ExpressionParseResult @parse_prefix_expression(%ExpressionTokens %state) {
entry:
  %l0 = alloca %Token
  %l1 = alloca %ExpressionParseResult
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
  %t6 = load %Token, %Token* %l0
  %t7 = extractvalue %Token %t6, 0
  %t8 = call %ExpressionParseResult @parse_primary_expression(%ExpressionTokens %state)
  store %ExpressionParseResult %t8, %ExpressionParseResult* %l1
  %t9 = load %ExpressionParseResult, %ExpressionParseResult* %l1
  %t10 = extractvalue %ExpressionParseResult %t9, 2
  %t11 = xor i1 %t10, 1
  %t12 = load %Token, %Token* %l0
  %t13 = load %ExpressionParseResult, %ExpressionParseResult* %l1
  br i1 %t11, label %then2, label %merge3
then2:
  %t14 = load %ExpressionParseResult, %ExpressionParseResult* %l1
  ret %ExpressionParseResult %t14
merge3:
  %t15 = load %ExpressionParseResult, %ExpressionParseResult* %l1
  %t16 = extractvalue %ExpressionParseResult %t15, 0
  %t17 = load %ExpressionParseResult, %ExpressionParseResult* %l1
  %t18 = extractvalue %ExpressionParseResult %t17, 1
  %t19 = call %ExpressionParseResult @parse_postfix_chain(%ExpressionTokens zeroinitializer, %Expression zeroinitializer)
  ret %ExpressionParseResult %t19
}

define %ExpressionParseResult @parse_primary_expression(%ExpressionTokens %state) {
entry:
  %l0 = alloca %Token
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
  %t5 = load %Token, %Token* %l0
  %t6 = extractvalue %Token %t5, 0
  %t7 = load %Token, %Token* %l0
  %t8 = extractvalue %Token %t7, 0
  %t9 = load %Token, %Token* %l0
  %t10 = extractvalue %Token %t9, 0
  %t12 = load %Token, %Token* %l0
  %t13 = extractvalue %Token %t12, 0
  %t15 = load %Token, %Token* %l0
  %t16 = extractvalue %Token %t15, 0
  %t18 = load %Token, %Token* %l0
  %t19 = extractvalue %Token %t18, 0
  %t20 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t20
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
  %t10 = load %Token, %Token* %l2
  %t11 = extractvalue %Token %t10, 0
  store double 0.0, double* %l3
  %t12 = load double, double* %l3
  %t13 = load double, double* %l3
  %t14 = load double, double* %l3
  %t15 = load double, double* %l3
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t16 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t17 = insertvalue %ExpressionParseResult undef, i8* null, 0
  %t18 = load %Expression, %Expression* %l1
  %t19 = insertvalue %ExpressionParseResult %t17, i8* null, 1
  %t20 = insertvalue %ExpressionParseResult %t19, i1 1, 2
  ret %ExpressionParseResult %t20
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
  %t10 = insertvalue %CallArgumentsParseResult undef, i8* null, 0
  %t11 = alloca [0 x i8*]
  %t12 = getelementptr [0 x i8*], [0 x i8*]* %t11, i32 0, i32 0
  %t13 = alloca { i8**, i64 }
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 0
  store i8** %t12, i8*** %t14
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  %t16 = insertvalue %CallArgumentsParseResult %t10, { i8**, i64 }* %t13, 1
  %t17 = insertvalue %CallArgumentsParseResult %t16, i1 0, 2
  ret %CallArgumentsParseResult %t17
merge1:
  %t18 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t19 = call %Token @expression_tokens_peek(%ExpressionTokens %t18)
  %t20 = extractvalue %Token %t19, 0
  %t21 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t22 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  br label %loop.header2
loop.header2:
  %t76 = phi { %Expression*, i64 }* [ %t22, %entry ], [ %t74, %loop.latch4 ]
  %t77 = phi %ExpressionTokens [ %t21, %entry ], [ %t75, %loop.latch4 ]
  store { %Expression*, i64 }* %t76, { %Expression*, i64 }** %l1
  store %ExpressionTokens %t77, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t23 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t24 = sitofp i64 0 to double
  %t25 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %t23, double %t24)
  store %ExpressionParseResult %t25, %ExpressionParseResult* %l2
  %t26 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t27 = extractvalue %ExpressionParseResult %t26, 2
  %t28 = xor i1 %t27, 1
  %t29 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t30 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t31 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  br i1 %t28, label %then6, label %merge7
then6:
  %t32 = insertvalue %CallArgumentsParseResult undef, i8* null, 0
  %t33 = alloca [0 x i8*]
  %t34 = getelementptr [0 x i8*], [0 x i8*]* %t33, i32 0, i32 0
  %t35 = alloca { i8**, i64 }
  %t36 = getelementptr { i8**, i64 }, { i8**, i64 }* %t35, i32 0, i32 0
  store i8** %t34, i8*** %t36
  %t37 = getelementptr { i8**, i64 }, { i8**, i64 }* %t35, i32 0, i32 1
  store i64 0, i64* %t37
  %t38 = insertvalue %CallArgumentsParseResult %t32, { i8**, i64 }* %t35, 1
  %t39 = insertvalue %CallArgumentsParseResult %t38, i1 0, 2
  ret %CallArgumentsParseResult %t39
merge7:
  %t40 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t41 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t42 = extractvalue %ExpressionParseResult %t41, 1
  %t43 = call { %Expression*, i64 }* @append_expression({ %Expression*, i64 }* %t40, %Expression zeroinitializer)
  store { %Expression*, i64 }* %t43, { %Expression*, i64 }** %l1
  %t44 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t45 = extractvalue %ExpressionParseResult %t44, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t46 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t47 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t46)
  %t48 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t49 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t50 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  br i1 %t47, label %then8, label %merge9
then8:
  %t51 = insertvalue %CallArgumentsParseResult undef, i8* null, 0
  %t52 = alloca [0 x i8*]
  %t53 = getelementptr [0 x i8*], [0 x i8*]* %t52, i32 0, i32 0
  %t54 = alloca { i8**, i64 }
  %t55 = getelementptr { i8**, i64 }, { i8**, i64 }* %t54, i32 0, i32 0
  store i8** %t53, i8*** %t55
  %t56 = getelementptr { i8**, i64 }, { i8**, i64 }* %t54, i32 0, i32 1
  store i64 0, i64* %t56
  %t57 = insertvalue %CallArgumentsParseResult %t51, { i8**, i64 }* %t54, 1
  %t58 = insertvalue %CallArgumentsParseResult %t57, i1 0, 2
  ret %CallArgumentsParseResult %t58
merge9:
  %t59 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t60 = call %Token @expression_tokens_peek(%ExpressionTokens %t59)
  store %Token %t60, %Token* %l3
  %t62 = load %Token, %Token* %l3
  %t63 = extractvalue %Token %t62, 0
  %t64 = load %Token, %Token* %l3
  %t65 = extractvalue %Token %t64, 0
  %t66 = insertvalue %CallArgumentsParseResult undef, i8* null, 0
  %t67 = alloca [0 x i8*]
  %t68 = getelementptr [0 x i8*], [0 x i8*]* %t67, i32 0, i32 0
  %t69 = alloca { i8**, i64 }
  %t70 = getelementptr { i8**, i64 }, { i8**, i64 }* %t69, i32 0, i32 0
  store i8** %t68, i8*** %t70
  %t71 = getelementptr { i8**, i64 }, { i8**, i64 }* %t69, i32 0, i32 1
  store i64 0, i64* %t71
  %t72 = insertvalue %CallArgumentsParseResult %t66, { i8**, i64 }* %t69, 1
  %t73 = insertvalue %CallArgumentsParseResult %t72, i1 0, 2
  ret %CallArgumentsParseResult %t73
loop.latch4:
  %t74 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t75 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t78 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t79 = insertvalue %CallArgumentsParseResult undef, i8* null, 0
  %t80 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t81 = bitcast { %Expression*, i64 }* %t80 to { i8**, i64 }*
  %t82 = insertvalue %CallArgumentsParseResult %t79, { i8**, i64 }* %t81, 1
  %t83 = insertvalue %CallArgumentsParseResult %t82, i1 1, 2
  ret %CallArgumentsParseResult %t83
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
  %t9 = insertvalue %ArrayLiteralParseResult undef, i8* null, 0
  %t10 = alloca [0 x i8*]
  %t11 = getelementptr [0 x i8*], [0 x i8*]* %t10, i32 0, i32 0
  %t12 = alloca { i8**, i64 }
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t11, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  %t15 = insertvalue %ArrayLiteralParseResult %t9, { i8**, i64 }* %t12, 1
  %t16 = insertvalue %ArrayLiteralParseResult %t15, i1 0, 2
  ret %ArrayLiteralParseResult %t16
merge1:
  %t18 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t19 = call %Token @expression_tokens_peek(%ExpressionTokens %t18)
  %t20 = extractvalue %Token %t19, 0
  %t21 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t22 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  br label %loop.header2
loop.header2:
  %t77 = phi { %Expression*, i64 }* [ %t22, %entry ], [ %t75, %loop.latch4 ]
  %t78 = phi %ExpressionTokens [ %t21, %entry ], [ %t76, %loop.latch4 ]
  store { %Expression*, i64 }* %t77, { %Expression*, i64 }** %l1
  store %ExpressionTokens %t78, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t23 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t24 = sitofp i64 0 to double
  %t25 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %t23, double %t24)
  store %ExpressionParseResult %t25, %ExpressionParseResult* %l2
  %t26 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t27 = extractvalue %ExpressionParseResult %t26, 2
  %t28 = xor i1 %t27, 1
  %t29 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t30 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t31 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  br i1 %t28, label %then6, label %merge7
then6:
  %t32 = insertvalue %ArrayLiteralParseResult undef, i8* null, 0
  %t33 = alloca [0 x i8*]
  %t34 = getelementptr [0 x i8*], [0 x i8*]* %t33, i32 0, i32 0
  %t35 = alloca { i8**, i64 }
  %t36 = getelementptr { i8**, i64 }, { i8**, i64 }* %t35, i32 0, i32 0
  store i8** %t34, i8*** %t36
  %t37 = getelementptr { i8**, i64 }, { i8**, i64 }* %t35, i32 0, i32 1
  store i64 0, i64* %t37
  %t38 = insertvalue %ArrayLiteralParseResult %t32, { i8**, i64 }* %t35, 1
  %t39 = insertvalue %ArrayLiteralParseResult %t38, i1 0, 2
  ret %ArrayLiteralParseResult %t39
merge7:
  %t40 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t41 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t42 = extractvalue %ExpressionParseResult %t41, 1
  %t43 = call { %Expression*, i64 }* @append_expression({ %Expression*, i64 }* %t40, %Expression zeroinitializer)
  store { %Expression*, i64 }* %t43, { %Expression*, i64 }** %l1
  %t44 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t45 = extractvalue %ExpressionParseResult %t44, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t46 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t47 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t46)
  %t48 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t49 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t50 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  br i1 %t47, label %then8, label %merge9
then8:
  %t51 = insertvalue %ArrayLiteralParseResult undef, i8* null, 0
  %t52 = alloca [0 x i8*]
  %t53 = getelementptr [0 x i8*], [0 x i8*]* %t52, i32 0, i32 0
  %t54 = alloca { i8**, i64 }
  %t55 = getelementptr { i8**, i64 }, { i8**, i64 }* %t54, i32 0, i32 0
  store i8** %t53, i8*** %t55
  %t56 = getelementptr { i8**, i64 }, { i8**, i64 }* %t54, i32 0, i32 1
  store i64 0, i64* %t56
  %t57 = insertvalue %ArrayLiteralParseResult %t51, { i8**, i64 }* %t54, 1
  %t58 = insertvalue %ArrayLiteralParseResult %t57, i1 0, 2
  ret %ArrayLiteralParseResult %t58
merge9:
  %t59 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t60 = call %Token @expression_tokens_peek(%ExpressionTokens %t59)
  store %Token %t60, %Token* %l3
  %t62 = load %Token, %Token* %l3
  %t63 = extractvalue %Token %t62, 0
  %t65 = load %Token, %Token* %l3
  %t66 = extractvalue %Token %t65, 0
  %t67 = insertvalue %ArrayLiteralParseResult undef, i8* null, 0
  %t68 = alloca [0 x i8*]
  %t69 = getelementptr [0 x i8*], [0 x i8*]* %t68, i32 0, i32 0
  %t70 = alloca { i8**, i64 }
  %t71 = getelementptr { i8**, i64 }, { i8**, i64 }* %t70, i32 0, i32 0
  store i8** %t69, i8*** %t71
  %t72 = getelementptr { i8**, i64 }, { i8**, i64 }* %t70, i32 0, i32 1
  store i64 0, i64* %t72
  %t73 = insertvalue %ArrayLiteralParseResult %t67, { i8**, i64 }* %t70, 1
  %t74 = insertvalue %ArrayLiteralParseResult %t73, i1 0, 2
  ret %ArrayLiteralParseResult %t74
loop.latch4:
  %t75 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t76 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t79 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t80 = insertvalue %ArrayLiteralParseResult undef, i8* null, 0
  %t81 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  %t82 = bitcast { %Expression*, i64 }* %t81 to { i8**, i64 }*
  %t83 = insertvalue %ArrayLiteralParseResult %t80, { i8**, i64 }* %t82, 1
  %t84 = insertvalue %ArrayLiteralParseResult %t83, i1 1, 2
  ret %ArrayLiteralParseResult %t84
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
  %t9 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t10 = alloca [0 x i8*]
  %t11 = getelementptr [0 x i8*], [0 x i8*]* %t10, i32 0, i32 0
  %t12 = alloca { i8**, i64 }
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t11, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  %t15 = insertvalue %ObjectLiteralParseResult %t9, { i8**, i64 }* %t12, 1
  %t16 = insertvalue %ObjectLiteralParseResult %t15, i1 0, 2
  ret %ObjectLiteralParseResult %t16
merge1:
  %t18 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t19 = call %Token @expression_tokens_peek(%ExpressionTokens %t18)
  %t20 = extractvalue %Token %t19, 0
  %t21 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t22 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  br label %loop.header2
loop.header2:
  %t127 = phi %ExpressionTokens [ %t21, %entry ], [ %t125, %loop.latch4 ]
  %t128 = phi { %ObjectField*, i64 }* [ %t22, %entry ], [ %t126, %loop.latch4 ]
  store %ExpressionTokens %t127, %ExpressionTokens* %l0
  store { %ObjectField*, i64 }* %t128, { %ObjectField*, i64 }** %l1
  br label %loop.body3
loop.body3:
  %t23 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t24 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t23)
  %t25 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t26 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  br i1 %t24, label %then6, label %merge7
then6:
  %t27 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t28 = alloca [0 x i8*]
  %t29 = getelementptr [0 x i8*], [0 x i8*]* %t28, i32 0, i32 0
  %t30 = alloca { i8**, i64 }
  %t31 = getelementptr { i8**, i64 }, { i8**, i64 }* %t30, i32 0, i32 0
  store i8** %t29, i8*** %t31
  %t32 = getelementptr { i8**, i64 }, { i8**, i64 }* %t30, i32 0, i32 1
  store i64 0, i64* %t32
  %t33 = insertvalue %ObjectLiteralParseResult %t27, { i8**, i64 }* %t30, 1
  %t34 = insertvalue %ObjectLiteralParseResult %t33, i1 0, 2
  ret %ObjectLiteralParseResult %t34
merge7:
  %t35 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t36 = call %Token @expression_tokens_peek(%ExpressionTokens %t35)
  store %Token %t36, %Token* %l2
  %t37 = load %Token, %Token* %l2
  %t38 = extractvalue %Token %t37, 0
  %t39 = load %Token, %Token* %l2
  %t40 = call i8* @identifier_text(%Token %t39)
  store i8* %t40, i8** %l3
  %t41 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t42 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t41)
  store %ExpressionTokens %t42, %ExpressionTokens* %l0
  %t43 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t44 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t43)
  %t45 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t46 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  %t47 = load %Token, %Token* %l2
  %t48 = load i8*, i8** %l3
  br i1 %t44, label %then8, label %merge9
then8:
  %t49 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t50 = alloca [0 x i8*]
  %t51 = getelementptr [0 x i8*], [0 x i8*]* %t50, i32 0, i32 0
  %t52 = alloca { i8**, i64 }
  %t53 = getelementptr { i8**, i64 }, { i8**, i64 }* %t52, i32 0, i32 0
  store i8** %t51, i8*** %t53
  %t54 = getelementptr { i8**, i64 }, { i8**, i64 }* %t52, i32 0, i32 1
  store i64 0, i64* %t54
  %t55 = insertvalue %ObjectLiteralParseResult %t49, { i8**, i64 }* %t52, 1
  %t56 = insertvalue %ObjectLiteralParseResult %t55, i1 0, 2
  ret %ObjectLiteralParseResult %t56
merge9:
  %t57 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t58 = call %Token @expression_tokens_peek(%ExpressionTokens %t57)
  store %Token %t58, %Token* %l4
  %t60 = load %Token, %Token* %l4
  %t61 = extractvalue %Token %t60, 0
  %t62 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t63 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t62)
  store %ExpressionTokens %t63, %ExpressionTokens* %l0
  %t64 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t65 = sitofp i64 0 to double
  %t66 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %t64, double %t65)
  store %ExpressionParseResult %t66, %ExpressionParseResult* %l5
  %t67 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  %t68 = extractvalue %ExpressionParseResult %t67, 2
  %t69 = xor i1 %t68, 1
  %t70 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t71 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  %t72 = load %Token, %Token* %l2
  %t73 = load i8*, i8** %l3
  %t74 = load %Token, %Token* %l4
  %t75 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  br i1 %t69, label %then10, label %merge11
then10:
  %t76 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t77 = alloca [0 x i8*]
  %t78 = getelementptr [0 x i8*], [0 x i8*]* %t77, i32 0, i32 0
  %t79 = alloca { i8**, i64 }
  %t80 = getelementptr { i8**, i64 }, { i8**, i64 }* %t79, i32 0, i32 0
  store i8** %t78, i8*** %t80
  %t81 = getelementptr { i8**, i64 }, { i8**, i64 }* %t79, i32 0, i32 1
  store i64 0, i64* %t81
  %t82 = insertvalue %ObjectLiteralParseResult %t76, { i8**, i64 }* %t79, 1
  %t83 = insertvalue %ObjectLiteralParseResult %t82, i1 0, 2
  ret %ObjectLiteralParseResult %t83
merge11:
  %t84 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  %t85 = extractvalue %ExpressionParseResult %t84, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t86 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  %t87 = load i8*, i8** %l3
  %t88 = insertvalue %ObjectField undef, i8* %t87, 0
  %t89 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  %t90 = extractvalue %ExpressionParseResult %t89, 1
  %t91 = insertvalue %ObjectField %t88, i8* %t90, 1
  %t92 = call { %ObjectField*, i64 }* @append_object_field({ %ObjectField*, i64 }* %t86, %ObjectField %t91)
  store { %ObjectField*, i64 }* %t92, { %ObjectField*, i64 }** %l1
  %t93 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t94 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t93)
  %t95 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t96 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  %t97 = load %Token, %Token* %l2
  %t98 = load i8*, i8** %l3
  %t99 = load %Token, %Token* %l4
  %t100 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  br i1 %t94, label %then12, label %merge13
then12:
  %t101 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t102 = alloca [0 x i8*]
  %t103 = getelementptr [0 x i8*], [0 x i8*]* %t102, i32 0, i32 0
  %t104 = alloca { i8**, i64 }
  %t105 = getelementptr { i8**, i64 }, { i8**, i64 }* %t104, i32 0, i32 0
  store i8** %t103, i8*** %t105
  %t106 = getelementptr { i8**, i64 }, { i8**, i64 }* %t104, i32 0, i32 1
  store i64 0, i64* %t106
  %t107 = insertvalue %ObjectLiteralParseResult %t101, { i8**, i64 }* %t104, 1
  %t108 = insertvalue %ObjectLiteralParseResult %t107, i1 0, 2
  ret %ObjectLiteralParseResult %t108
merge13:
  %t109 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t110 = call %Token @expression_tokens_peek(%ExpressionTokens %t109)
  store %Token %t110, %Token* %l6
  %t112 = load %Token, %Token* %l6
  %t113 = extractvalue %Token %t112, 0
  %t115 = load %Token, %Token* %l6
  %t116 = extractvalue %Token %t115, 0
  %t117 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t118 = alloca [0 x i8*]
  %t119 = getelementptr [0 x i8*], [0 x i8*]* %t118, i32 0, i32 0
  %t120 = alloca { i8**, i64 }
  %t121 = getelementptr { i8**, i64 }, { i8**, i64 }* %t120, i32 0, i32 0
  store i8** %t119, i8*** %t121
  %t122 = getelementptr { i8**, i64 }, { i8**, i64 }* %t120, i32 0, i32 1
  store i64 0, i64* %t122
  %t123 = insertvalue %ObjectLiteralParseResult %t117, { i8**, i64 }* %t120, 1
  %t124 = insertvalue %ObjectLiteralParseResult %t123, i1 0, 2
  ret %ObjectLiteralParseResult %t124
loop.latch4:
  %t125 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t126 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  br label %loop.header2
afterloop5:
  %t129 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t130 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t131 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  %t132 = bitcast { %ObjectField*, i64 }* %t131 to { i8**, i64 }*
  %t133 = insertvalue %ObjectLiteralParseResult %t130, { i8**, i64 }* %t132, 1
  %t134 = insertvalue %ObjectLiteralParseResult %t133, i1 1, 2
  ret %ObjectLiteralParseResult %t134
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
  %t15 = insertvalue %ExpressionParseResult undef, i8* %t14, 0
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
  %t28 = bitcast i8* %t27 to { i8**, i64 }**
  store { i8**, i64 }* %t24, { i8**, i64 }** %t28
  %t29 = load %Expression, %Expression* %t16
  %t30 = insertvalue %ExpressionParseResult %t15, i8* null, 1
  %t31 = insertvalue %ExpressionParseResult %t30, i1 1, 2
  ret %ExpressionParseResult %t31
}

define %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state) {
entry:
  %t0 = insertvalue %ExpressionParseResult undef, i8* null, 0
  %t1 = alloca %Expression
  %t2 = getelementptr inbounds %Expression, %Expression* %t1, i32 0, i32 0
  store i32 15, i32* %t2
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  %t4 = getelementptr inbounds %Expression, %Expression* %t1, i32 0, i32 1
  %t5 = bitcast [8 x i8]* %t4 to i8*
  %t6 = bitcast i8* %t5 to i8**
  store i8* %s3, i8** %t6
  %t7 = load %Expression, %Expression* %t1
  %t8 = insertvalue %ExpressionParseResult %t0, i8* null, 1
  %t9 = insertvalue %ExpressionParseResult %t8, i1 0, 2
  ret %ExpressionParseResult %t9
}

define i1 @expression_tokens_is_at_end(%ExpressionTokens %state) {
entry:
  %t0 = extractvalue %ExpressionTokens %state, 1
  %t1 = extractvalue %ExpressionTokens %state, 0
  %t2 = load { i8**, i64 }, { i8**, i64 }* %t1
  %t3 = extractvalue { i8**, i64 } %t2, 1
  %t4 = sitofp i64 %t3 to double
  %t5 = fcmp oge double %t0, %t4
  ret i1 %t5
}

define %Token @expression_tokens_peek(%ExpressionTokens %state) {
entry:
  %t0 = extractvalue %ExpressionTokens %state, 0
  %t1 = extractvalue %ExpressionTokens %state, 1
  %t2 = fptosi double %t1 to i64
  %t3 = load { i8**, i64 }, { i8**, i64 }* %t0
  %t4 = extractvalue { i8**, i64 } %t3, 0
  %t5 = extractvalue { i8**, i64 } %t3, 1
  %t6 = icmp uge i64 %t2, %t5
  ; bounds check: %t6 (if true, out of bounds)
  %t7 = getelementptr i8*, i8** %t4, i64 %t2
  %t8 = load i8*, i8** %t7
  ret %Token zeroinitializer
}

define %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %state) {
entry:
  %t0 = extractvalue %ExpressionTokens %state, 1
  %t1 = extractvalue %ExpressionTokens %state, 0
  %t2 = load { i8**, i64 }, { i8**, i64 }* %t1
  %t3 = extractvalue { i8**, i64 } %t2, 1
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
  %t108 = bitcast i8* %t107 to i8**
  %t109 = load i8*, i8** %t108
  %t110 = icmp eq i32 %t104, 7
  %t111 = select i1 %t110, i8* %t109, i8* null
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
  %t124 = bitcast i8* %t123 to i8**
  %t125 = load i8*, i8** %t124
  %t126 = icmp eq i32 %t120, 7
  %t127 = select i1 %t126, i8* %t125, i8* null
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
  %t12 = sitofp i64 -1 to double
  ret double %t12
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
  %t31 = phi double [ %t6, %entry ], [ %t30, %loop.latch2 ]
  store double %t31, double* %l0
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
  %t25 = load %Token, %Token* %l2
  %t26 = extractvalue %Token %t25, 0
  %t27 = load double, double* %l0
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l0
  br label %loop.latch2
loop.latch2:
  %t30 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t32 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  ret { %Token*, i64 }* %t32
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
  %l2 = alloca i8
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
  %t23 = phi double [ %t3, %entry ], [ %t22, %loop.latch2 ]
  store double %t23, double* %l0
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
  store i8 %t13, i8* %l2
  %t14 = load i8, i8* %l2
  %t15 = call i1 @is_trim_whitespace(i8* null)
  %t16 = load double, double* %l0
  %t17 = load double, double* %l1
  %t18 = load i8, i8* %l2
  br i1 %t15, label %then6, label %merge7
then6:
  %t19 = load double, double* %l0
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t22 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t40 = phi double [ %t25, %entry ], [ %t39, %loop.latch10 ]
  store double %t40, double* %l1
  br label %loop.body9
loop.body9:
  %t26 = load double, double* %l1
  %t27 = load double, double* %l0
  %t28 = fcmp ole double %t26, %t27
  %t29 = load double, double* %l0
  %t30 = load double, double* %l1
  br i1 %t28, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store double 0.0, double* %l3
  %t31 = load double, double* %l3
  %t32 = call i1 @is_trim_whitespace(i8* null)
  %t33 = load double, double* %l0
  %t34 = load double, double* %l1
  %t35 = load double, double* %l3
  br i1 %t32, label %then14, label %merge15
then14:
  %t36 = load double, double* %l1
  %t37 = sitofp i64 1 to double
  %t38 = fsub double %t36, %t37
  store double %t38, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t39 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t41 = load double, double* %l0
  %t42 = load double, double* %l1
  %t43 = fptosi double %t41 to i64
  %t44 = fptosi double %t42 to i64
  %t45 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t43, i64 %t44)
  ret i8* %t45
}

define i1 @is_trim_whitespace(i8* %ch) {
entry:
  %l0 = alloca double
  %t0 = call double @char_code(i8* %ch)
  store double %t0, double* %l0
  %t4 = load double, double* %l0
  %t5 = sitofp i64 32 to double
  %t6 = fcmp oeq double %t4, %t5
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t6, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %t7 = load double, double* %l0
  %t8 = sitofp i64 10 to double
  %t9 = fcmp oeq double %t7, %t8
  br label %logical_or_right_end_3

logical_or_right_end_3:
  br label %logical_or_merge_3

logical_or_merge_3:
  %t10 = phi i1 [ true, %logical_or_entry_3 ], [ %t9, %logical_or_right_end_3 ]
  br label %logical_or_entry_2

logical_or_entry_2:
  br i1 %t10, label %logical_or_merge_2, label %logical_or_right_2

logical_or_right_2:
  %t11 = load double, double* %l0
  %t12 = sitofp i64 9 to double
  %t13 = fcmp oeq double %t11, %t12
  br label %logical_or_right_end_2

logical_or_right_end_2:
  br label %logical_or_merge_2

logical_or_merge_2:
  %t14 = phi i1 [ true, %logical_or_entry_2 ], [ %t13, %logical_or_right_end_2 ]
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t14, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %t15 = load double, double* %l0
  %t16 = sitofp i64 13 to double
  %t17 = fcmp oeq double %t15, %t16
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
  %t2 = extractvalue %Token %token, 0
  ret i1 0
}

define i1 @is_whitespace_lexeme(i8* %text) {
entry:
  %l0 = alloca double
  %l1 = alloca i8
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
  %t22 = phi double [ %t3, %entry ], [ %t21, %loop.latch4 ]
  store double %t22, double* %l0
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
  %t10 = fptosi double %t9 to i64
  %t11 = getelementptr i8, i8* %text, i64 %t10
  %t12 = load i8, i8* %t11
  store i8 %t12, i8* %l1
  %t13 = load i8, i8* %l1
  %t14 = call i1 @is_trim_whitespace(i8* null)
  %t15 = xor i1 %t14, 1
  %t16 = load double, double* %l0
  %t17 = load i8, i8* %l1
  br i1 %t15, label %then8, label %merge9
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

define %Parser @advance_to_symbol(%Parser %parser, i8* %symbol) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  %l2 = alloca %Parser
  store %Parser %parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  br label %loop.header0
loop.header0:
  %t23 = phi %Parser [ %t0, %entry ], [ %t22, %loop.latch2 ]
  store %Parser %t23, %Parser* %l0
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
  %t8 = load %Token, %Token* %l1
  %t9 = extractvalue %Token %t8, 0
  %t10 = load %Parser, %Parser* %l0
  %t11 = call %Parser @parser_advance_raw(%Parser %t10)
  store %Parser %t11, %Parser* %l2
  %t12 = load %Parser, %Parser* %l2
  %t13 = extractvalue %Parser %t12, 1
  %t14 = load %Parser, %Parser* %l0
  %t15 = extractvalue %Parser %t14, 1
  %t16 = fcmp oeq double %t13, %t15
  %t17 = load %Parser, %Parser* %l0
  %t18 = load %Token, %Token* %l1
  %t19 = load %Parser, %Parser* %l2
  br i1 %t16, label %then4, label %merge5
then4:
  %t20 = load %Parser, %Parser* %l0
  ret %Parser %t20
merge5:
  %t21 = load %Parser, %Parser* %l2
  store %Parser %t21, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t22 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  ret %Parser zeroinitializer
}

define %Parser @skip_struct_member(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %Token
  store %Parser %parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  br label %loop.header0
loop.header0:
  %t19 = phi %Parser [ %t0, %entry ], [ %t18, %loop.latch2 ]
  store %Parser %t19, %Parser* %l0
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
  %t16 = load %Token, %Token* %l2
  %t17 = extractvalue %Token %t16, 0
  br label %loop.latch2
loop.latch2:
  %t18 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  ret %Parser zeroinitializer
}

define %Parser @skip_enum_variant_entry(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %Token
  store %Parser %parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  br label %loop.header0
loop.header0:
  %t19 = phi %Parser [ %t0, %entry ], [ %t18, %loop.latch2 ]
  store %Parser %t19, %Parser* %l0
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
  %t16 = load %Token, %Token* %l2
  %t17 = extractvalue %Token %t16, 0
  br label %loop.latch2
loop.latch2:
  %t18 = load %Parser, %Parser* %l0
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
  %t2 = getelementptr i8, i8* %text, i64 0
  %t3 = load i8, i8* %t2
  %t4 = call double @char_code(i8 %t3)
  store double %t4, double* %l0
  store double 0.0, double* %l1
  %t6 = load double, double* %l0
  %t7 = sitofp i64 34 to double
  %t8 = fcmp oeq double %t6, %t7
  br label %logical_and_entry_5

logical_and_entry_5:
  br i1 %t8, label %logical_and_right_5, label %logical_and_merge_5

logical_and_right_5:
  %t9 = load double, double* %l1
  %t10 = sitofp i64 34 to double
  %t11 = fcmp oeq double %t9, %t10
  br label %logical_and_right_end_5

logical_and_right_end_5:
  br label %logical_and_merge_5

logical_and_merge_5:
  %t12 = phi i1 [ false, %logical_and_entry_5 ], [ %t11, %logical_and_right_end_5 ]
  %t13 = load double, double* %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then2, label %merge3
then2:
  %t15 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t16 = sub i64 %t15, 1
  %t17 = call i8* @sailfin_runtime_substring(i8* %text, i64 1, i64 %t16)
  ret i8* %t17
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
  %t6 = getelementptr i8, i8* %t5, i64 0
  %t7 = load i8, i8* %t6
  %t8 = call double @char_code(i8 %t7)
  store double %t8, double* %l1
  store double 0.0, double* %l2
  %t10 = load double, double* %l1
  %t11 = sitofp i64 34 to double
  %t12 = fcmp oeq double %t10, %t11
  br label %logical_and_entry_9

logical_and_entry_9:
  br i1 %t12, label %logical_and_right_9, label %logical_and_merge_9

logical_and_right_9:
  %t13 = load double, double* %l2
  %t14 = sitofp i64 34 to double
  %t15 = fcmp oeq double %t13, %t14
  br label %logical_and_right_end_9

logical_and_right_end_9:
  br label %logical_and_merge_9

logical_and_merge_9:
  %t16 = phi i1 [ false, %logical_and_entry_9 ], [ %t15, %logical_and_right_end_9 ]
  %t17 = load i8*, i8** %l0
  %t18 = load double, double* %l1
  %t19 = load double, double* %l2
  br i1 %t16, label %then2, label %merge3
then2:
  %t20 = load i8*, i8** %l0
  %t21 = call i8* @strip_surrounding_quotes(i8* %t20)
  ret i8* %t21
merge3:
  br label %merge1
merge1:
  %t22 = load i8*, i8** %l0
  ret i8* %t22
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
  %l8 = alloca i8*
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
  %t49 = phi i8* [ %t12, %entry ], [ %t47, %loop.latch2 ]
  %t50 = phi double [ %t17, %entry ], [ %t48, %loop.latch2 ]
  store i8* %t49, i8** %l1
  store double %t50, double* %l6
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
  %t40 = load i8*, i8** %l1
  %t41 = load %Token, %Token* %l7
  %t42 = extractvalue %Token %t41, 1
  %t43 = add i8* %t40, %t42
  store i8* %t43, i8** %l1
  %t44 = load double, double* %l6
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l6
  br label %loop.latch2
loop.latch2:
  %t47 = load i8*, i8** %l1
  %t48 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t51 = load i8*, i8** %l1
  %t52 = call i8* @trim_text(i8* %t51)
  store i8* %t52, i8** %l8
  %t53 = load i8*, i8** %l8
  %t54 = call i64 @sailfin_runtime_string_length(i8* %t53)
  %t55 = icmp sgt i64 %t54, 0
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t57 = load i8*, i8** %l1
  %t58 = load double, double* %l2
  %t59 = load double, double* %l3
  %t60 = load double, double* %l4
  %t61 = load double, double* %l5
  %t62 = load double, double* %l6
  %t63 = load i8*, i8** %l8
  br i1 %t55, label %then6, label %merge7
then6:
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load i8*, i8** %l8
  %t66 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t64, i8* %t65)
  store { i8**, i64 }* %t66, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t67 = phi { i8**, i64 }* [ %t66, %then6 ], [ %t56, %entry ]
  store { i8**, i64 }* %t67, { i8**, i64 }** %l0
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t68
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
  %t52 = phi { %Token*, i64 }* [ %t16, %entry ], [ %t50, %loop.latch2 ]
  %t53 = phi double [ %t21, %entry ], [ %t51, %loop.latch2 ]
  store { %Token*, i64 }* %t52, { %Token*, i64 }** %l1
  store double %t53, double* %l6
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
  %t44 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t45 = load %Token, %Token* %l7
  %t46 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t44, %Token %t45)
  store { %Token*, i64 }* %t46, { %Token*, i64 }** %l1
  %t47 = load double, double* %l6
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l6
  br label %loop.latch2
loop.latch2:
  %t50 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t51 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t54 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t55 = load { %Token*, i64 }, { %Token*, i64 }* %t54
  %t56 = extractvalue { %Token*, i64 } %t55, 1
  %t57 = icmp sgt i64 %t56, 0
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t60 = load double, double* %l2
  %t61 = load double, double* %l3
  %t62 = load double, double* %l4
  %t63 = load double, double* %l5
  %t64 = load double, double* %l6
  br i1 %t57, label %then6, label %merge7
then6:
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t67 = call { i8**, i64 }* @append_token_array({ i8**, i64 }* %t65, { %Token*, i64 }* %t66)
  store { i8**, i64 }* %t67, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t68 = phi { i8**, i64 }* [ %t67, %then6 ], [ %t58, %entry ]
  store { i8**, i64 }* %t68, { i8**, i64 }** %l0
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t69
}

define double @find_top_level_symbol({ %Token*, i64 }* %tokens, i8* %symbol) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca %Token
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
  %t34 = phi double [ %t9, %entry ], [ %t33, %loop.latch2 ]
  store double %t34, double* %l4
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
  %t30 = load double, double* %l4
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l4
  br label %loop.latch2
loop.latch2:
  %t33 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t35 = sitofp i64 -1 to double
  ret double %t35
}

define double @find_top_level_identifier({ %Token*, i64 }* %tokens, i8* %keyword) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca %Token
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
  %t36 = phi double [ %t9, %entry ], [ %t35, %loop.latch2 ]
  store double %t36, double* %l4
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
  %t30 = load %Token, %Token* %l5
  %t31 = extractvalue %Token %t30, 0
  %t32 = load double, double* %l4
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l4
  br label %loop.latch2
loop.latch2:
  %t35 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t37 = sitofp i64 -1 to double
  ret double %t37
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
