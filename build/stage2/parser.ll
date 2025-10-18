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

declare noalias i8* @malloc(i64)

@.str.45 = private unnamed_addr constant [3 x i8] c"fn\00"
@.str.16 = private unnamed_addr constant [11 x i8] c"implements\00"
@.str.13 = private unnamed_addr constant [4 x i8] c"for\00"
@.str.42 = private unnamed_addr constant [3 x i8] c"in\00"
@.str.13 = private unnamed_addr constant [5 x i8] c"loop\00"
@.str.13 = private unnamed_addr constant [6 x i8] c"break\00"
@.str.13 = private unnamed_addr constant [9 x i8] c"continue\00"
@.str.13 = private unnamed_addr constant [3 x i8] c"if\00"
@.str.13 = private unnamed_addr constant [6 x i8] c"match\00"
@.str.15 = private unnamed_addr constant [7 x i8] c"prompt\00"
@.str.21 = private unnamed_addr constant [1 x i8] c"\00"
@.str.13 = private unnamed_addr constant [5 x i8] c"with\00"
@.str.22 = private unnamed_addr constant [7 x i8] c"return\00"

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
  %t0 = insertvalue %Parser undef, { i8**, i64 }* null, 0
  %t1 = sitofp i64 0 to double
  %t2 = insertvalue %Parser %t0, double %t1, 1
  store %Parser %t2, %Parser* %l0
  %t3 = alloca [0 x double]
  %t4 = getelementptr [0 x double], [0 x double]* %t3, i32 0, i32 0
  %t5 = alloca { double*, i64 }
  %t6 = getelementptr { double*, i64 }, { double*, i64 }* %t5, i32 0, i32 0
  store double* %t4, double** %t6
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t5, i32 0, i32 1
  store i64 0, i64* %t7
  store { %Statement*, i64 }* null, { %Statement*, i64 }** %l1
  %t8 = load %Parser, %Parser* %l0
  %t9 = call %Parser @skip_trivia(%Parser %t8)
  store %Parser %t9, %Parser* %l0
  %t10 = load %Parser, %Parser* %l0
  %t11 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t28 = phi %Parser [ %t10, %entry ], [ %t26, %loop.latch2 ]
  %t29 = phi { %Statement*, i64 }* [ %t11, %entry ], [ %t27, %loop.latch2 ]
  store %Parser %t28, %Parser* %l0
  store { %Statement*, i64 }* %t29, { %Statement*, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t12 = load %Parser, %Parser* %l0
  %t13 = call %Token @parser_peek_raw(%Parser %t12)
  store %Token %t13, %Token* %l2
  %t14 = load %Token, %Token* %l2
  %t15 = extractvalue %Token %t14, 0
  %t16 = load %Parser, %Parser* %l0
  %t17 = call %StatementParseResult @parse_statement(%Parser %t16)
  store %StatementParseResult %t17, %StatementParseResult* %l3
  %t18 = load %StatementParseResult, %StatementParseResult* %l3
  %t19 = extractvalue %StatementParseResult %t18, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t20 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  %t21 = load %StatementParseResult, %StatementParseResult* %l3
  %t22 = extractvalue %StatementParseResult %t21, 1
  %t23 = call { %Statement*, i64 }* @append_statement({ %Statement*, i64 }* %t20, %Statement zeroinitializer)
  store { %Statement*, i64 }* %t23, { %Statement*, i64 }** %l1
  %t24 = load %Parser, %Parser* %l0
  %t25 = call %Parser @skip_trivia(%Parser %t24)
  store %Parser %t25, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t26 = load %Parser, %Parser* %l0
  %t27 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t30 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  %t31 = insertvalue %Program undef, { i8**, i64 }* null, 0
  ret %Program %t31
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
  %t58 = call %StatementParseResult @parse_model(%Parser %parser, { %Decorator*, i64 }* null)
  ret %StatementParseResult %t58
merge9:
  %t59 = load %Token, %Token* %l3
  %s60 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.60, i32 0, i32 0
  %t61 = call i1 @identifier_matches(%Token %t59, i8* %s60)
  %t62 = load %Parser, %Parser* %l0
  %t63 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t65 = load %Token, %Token* %l3
  br i1 %t61, label %then12, label %merge13
then12:
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t67 = load { i8**, i64 }, { i8**, i64 }* %t66
  %t68 = extractvalue { i8**, i64 } %t67, 1
  %t69 = icmp sgt i64 %t68, 0
  %t70 = load %Parser, %Parser* %l0
  %t71 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t73 = load %Token, %Token* %l3
  br i1 %t69, label %then14, label %merge15
then14:
  %t74 = load %Parser, %Parser* %l0
  %t75 = call %StatementParseResult @parse_unknown(%Parser %t74)
  ret %StatementParseResult %t75
merge15:
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t77 = call %StatementParseResult @parse_pipeline(%Parser %parser, { %Decorator*, i64 }* null)
  ret %StatementParseResult %t77
merge13:
  %t78 = load %Token, %Token* %l3
  %s79 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.79, i32 0, i32 0
  %t80 = call i1 @identifier_matches(%Token %t78, i8* %s79)
  %t81 = load %Parser, %Parser* %l0
  %t82 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t84 = load %Token, %Token* %l3
  br i1 %t80, label %then16, label %merge17
then16:
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t86 = load { i8**, i64 }, { i8**, i64 }* %t85
  %t87 = extractvalue { i8**, i64 } %t86, 1
  %t88 = icmp sgt i64 %t87, 0
  %t89 = load %Parser, %Parser* %l0
  %t90 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t92 = load %Token, %Token* %l3
  br i1 %t88, label %then18, label %merge19
then18:
  %t93 = load %Parser, %Parser* %l0
  %t94 = call %StatementParseResult @parse_unknown(%Parser %t93)
  ret %StatementParseResult %t94
merge19:
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t96 = call %StatementParseResult @parse_tool(%Parser %parser, { %Decorator*, i64 }* null)
  ret %StatementParseResult %t96
merge17:
  %t97 = load %Token, %Token* %l3
  %s98 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.98, i32 0, i32 0
  %t99 = call i1 @identifier_matches(%Token %t97, i8* %s98)
  %t100 = load %Parser, %Parser* %l0
  %t101 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t103 = load %Token, %Token* %l3
  br i1 %t99, label %then20, label %merge21
then20:
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t105 = load { i8**, i64 }, { i8**, i64 }* %t104
  %t106 = extractvalue { i8**, i64 } %t105, 1
  %t107 = icmp sgt i64 %t106, 0
  %t108 = load %Parser, %Parser* %l0
  %t109 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t111 = load %Token, %Token* %l3
  br i1 %t107, label %then22, label %merge23
then22:
  %t112 = load %Parser, %Parser* %l0
  %t113 = call %StatementParseResult @parse_unknown(%Parser %t112)
  ret %StatementParseResult %t113
merge23:
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t115 = call %StatementParseResult @parse_test(%Parser %parser, { %Decorator*, i64 }* null)
  ret %StatementParseResult %t115
merge21:
  %t116 = load %Token, %Token* %l3
  %s117 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.117, i32 0, i32 0
  %t118 = call i1 @identifier_matches(%Token %t116, i8* %s117)
  %t119 = load %Parser, %Parser* %l0
  %t120 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t122 = load %Token, %Token* %l3
  br i1 %t118, label %then24, label %merge25
then24:
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t124 = call %StatementParseResult @parse_function(%Parser %parser, i1 0, { %Decorator*, i64 }* null)
  ret %StatementParseResult %t124
merge25:
  %t125 = load %Token, %Token* %l3
  %s126 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.126, i32 0, i32 0
  %t127 = call i1 @identifier_matches(%Token %t125, i8* %s126)
  %t128 = load %Parser, %Parser* %l0
  %t129 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t131 = load %Token, %Token* %l3
  br i1 %t127, label %then26, label %merge27
then26:
  %t132 = load %Token, %Token* %l3
  %s133 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.133, i32 0, i32 0
  %t134 = call i1 @identifier_matches(%Token %t132, i8* %s133)
  %t135 = load %Parser, %Parser* %l0
  %t136 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t138 = load %Token, %Token* %l3
  br i1 %t134, label %then28, label %merge29
then28:
  br label %merge29
merge29:
  %t139 = load %Token, %Token* %l3
  %s140 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.140, i32 0, i32 0
  %t141 = call i1 @identifier_matches(%Token %t139, i8* %s140)
  %t142 = load %Parser, %Parser* %l0
  %t143 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t145 = load %Token, %Token* %l3
  br i1 %t141, label %then30, label %merge31
then30:
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t147 = load { i8**, i64 }, { i8**, i64 }* %t146
  %t148 = extractvalue { i8**, i64 } %t147, 1
  %t149 = icmp sgt i64 %t148, 0
  %t150 = load %Parser, %Parser* %l0
  %t151 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t153 = load %Token, %Token* %l3
  br i1 %t149, label %then32, label %merge33
then32:
  %t154 = load %Parser, %Parser* %l0
  %t155 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t156 = insertvalue %BlockStatementParseResult %t155, i8* null, 1
  %t157 = insertvalue %BlockStatementParseResult %t156, i1 0, 2
  ret %StatementParseResult zeroinitializer
merge33:
  ret %StatementParseResult zeroinitializer
merge31:
  %t158 = load %Token, %Token* %l3
  %s159 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.159, i32 0, i32 0
  %t160 = call i1 @identifier_matches(%Token %t158, i8* %s159)
  %t161 = load %Parser, %Parser* %l0
  %t162 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t164 = load %Token, %Token* %l3
  br i1 %t160, label %then34, label %merge35
then34:
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t166 = load { i8**, i64 }, { i8**, i64 }* %t165
  %t167 = extractvalue { i8**, i64 } %t166, 1
  %t168 = icmp sgt i64 %t167, 0
  %t169 = load %Parser, %Parser* %l0
  %t170 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t172 = load %Token, %Token* %l3
  br i1 %t168, label %then36, label %merge37
then36:
  %t173 = load %Parser, %Parser* %l0
  %t174 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t175 = insertvalue %BlockStatementParseResult %t174, i8* null, 1
  %t176 = insertvalue %BlockStatementParseResult %t175, i1 0, 2
  ret %StatementParseResult zeroinitializer
merge37:
  ret %StatementParseResult zeroinitializer
merge35:
  store double 0.0, double* %l4
  %t177 = load double, double* %l4
  %s178 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.178, i32 0, i32 0
  %t179 = call i1 @identifier_matches(%Token zeroinitializer, i8* %s178)
  %t180 = load %Parser, %Parser* %l0
  %t181 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t183 = load %Token, %Token* %l3
  %t184 = load double, double* %l4
  br i1 %t179, label %then38, label %merge39
then38:
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t186 = call %StatementParseResult @parse_function(%Parser %parser, i1 1, { %Decorator*, i64 }* null)
  ret %StatementParseResult %t186
merge39:
  br label %merge27
merge27:
  %t187 = load %Token, %Token* %l3
  %s188 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.188, i32 0, i32 0
  %t189 = call i1 @identifier_matches(%Token %t187, i8* %s188)
  %t190 = load %Parser, %Parser* %l0
  %t191 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t192 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t193 = load %Token, %Token* %l3
  br i1 %t189, label %then40, label %merge41
then40:
  %t194 = call %StatementParseResult @parse_import(%Parser %parser)
  ret %StatementParseResult %t194
merge41:
  %t195 = load %Token, %Token* %l3
  %s196 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.196, i32 0, i32 0
  %t197 = call i1 @identifier_matches(%Token %t195, i8* %s196)
  %t198 = load %Parser, %Parser* %l0
  %t199 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t200 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t201 = load %Token, %Token* %l3
  br i1 %t197, label %then42, label %merge43
then42:
  %t202 = call %StatementParseResult @parse_export(%Parser %parser)
  ret %StatementParseResult %t202
merge43:
  %t203 = load %Token, %Token* %l3
  %s204 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.204, i32 0, i32 0
  %t205 = call i1 @identifier_matches(%Token %t203, i8* %s204)
  %t206 = load %Parser, %Parser* %l0
  %t207 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t209 = load %Token, %Token* %l3
  br i1 %t205, label %then44, label %merge45
then44:
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t211 = call %StatementParseResult @parse_struct(%Parser %parser, { %Decorator*, i64 }* null)
  ret %StatementParseResult %t211
merge45:
  %t212 = load %Token, %Token* %l3
  %s213 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.213, i32 0, i32 0
  %t214 = call i1 @identifier_matches(%Token %t212, i8* %s213)
  %t215 = load %Parser, %Parser* %l0
  %t216 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t218 = load %Token, %Token* %l3
  br i1 %t214, label %then46, label %merge47
then46:
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t220 = call %StatementParseResult @parse_type_alias(%Parser %parser, { %Decorator*, i64 }* null)
  ret %StatementParseResult %t220
merge47:
  %t221 = load %Token, %Token* %l3
  %s222 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.222, i32 0, i32 0
  %t223 = call i1 @identifier_matches(%Token %t221, i8* %s222)
  %t224 = load %Parser, %Parser* %l0
  %t225 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t227 = load %Token, %Token* %l3
  br i1 %t223, label %then48, label %merge49
then48:
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t229 = call %StatementParseResult @parse_interface(%Parser %parser, { %Decorator*, i64 }* null)
  ret %StatementParseResult %t229
merge49:
  %t230 = load %Token, %Token* %l3
  %s231 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.231, i32 0, i32 0
  %t232 = call i1 @identifier_matches(%Token %t230, i8* %s231)
  %t233 = load %Parser, %Parser* %l0
  %t234 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t236 = load %Token, %Token* %l3
  br i1 %t232, label %then50, label %merge51
then50:
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t238 = call %StatementParseResult @parse_enum(%Parser %parser, { %Decorator*, i64 }* null)
  ret %StatementParseResult %t238
merge51:
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t240 = load { i8**, i64 }, { i8**, i64 }* %t239
  %t241 = extractvalue { i8**, i64 } %t240, 1
  %t242 = icmp sgt i64 %t241, 0
  %t243 = load %Parser, %Parser* %l0
  %t244 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t246 = load %Token, %Token* %l3
  br i1 %t242, label %then52, label %merge53
then52:
  %t247 = load %Parser, %Parser* %l0
  %t248 = call %StatementParseResult @parse_unknown(%Parser %t247)
  ret %StatementParseResult %t248
merge53:
  %t249 = call %StatementParseResult @parse_unknown(%Parser %parser)
  ret %StatementParseResult %t249
}

define %StatementParseResult @parse_import(%Parser %parser) {
entry:
  %l0 = alloca %SpecifierListParseResult
  %l1 = alloca { %ImportSpecifier*, i64 }*
  %l2 = alloca %CaptureResult
  %l3 = alloca i8*
  %l4 = alloca double
  %t0 = call %SpecifierListParseResult @parse_specifier_list(%Parser %parser)
  store %SpecifierListParseResult %t0, %SpecifierListParseResult* %l0
  %t1 = load %SpecifierListParseResult, %SpecifierListParseResult* %l0
  %t2 = extractvalue %SpecifierListParseResult %t1, 1
  %t3 = call { %ImportSpecifier*, i64 }* @build_import_specifiers({ %NamedSpecifier*, i64 }* null)
  store { %ImportSpecifier*, i64 }* %t3, { %ImportSpecifier*, i64 }** %l1
  %t4 = alloca [1 x i8]
  %t5 = getelementptr [1 x i8], [1 x i8]* %t4, i32 0, i32 0
  %t6 = getelementptr i8, i8* %t5, i64 0
  store i8 59, i8* %t6
  %t7 = alloca { i8*, i64 }
  %t8 = getelementptr { i8*, i64 }, { i8*, i64 }* %t7, i32 0, i32 0
  store i8* %t5, i8** %t8
  %t9 = getelementptr { i8*, i64 }, { i8*, i64 }* %t7, i32 0, i32 1
  store i64 1, i64* %t9
  %t10 = call %CaptureResult @collect_until(%Parser %parser, { i8**, i64 }* null)
  store %CaptureResult %t10, %CaptureResult* %l2
  %t11 = load %CaptureResult, %CaptureResult* %l2
  %t12 = extractvalue %CaptureResult %t11, 1
  %t13 = call i8* @tokens_to_text({ %Token*, i64 }* null)
  %t14 = call i8* @trim_text(i8* %t13)
  store i8* %t14, i8** %l3
  %t15 = load i8*, i8** %l3
  %t16 = call i8* @strip_surrounding_quotes(i8* %t15)
  store i8* %t16, i8** %l3
  %t18 = call %Token @parser_peek_raw(%Parser %parser)
  %t19 = extractvalue %Token %t18, 0
  store double 0.0, double* %l4
  %t20 = insertvalue %StatementParseResult undef, i8* null, 0
  %t21 = load double, double* %l4
  %t22 = insertvalue %StatementParseResult %t20, i8* null, 1
  ret %StatementParseResult %t22
}

define %StatementParseResult @parse_export(%Parser %parser) {
entry:
  %l0 = alloca %SpecifierListParseResult
  %l1 = alloca { %ExportSpecifier*, i64 }*
  %l2 = alloca %CaptureResult
  %l3 = alloca i8*
  %l4 = alloca double
  %t0 = call %SpecifierListParseResult @parse_specifier_list(%Parser %parser)
  store %SpecifierListParseResult %t0, %SpecifierListParseResult* %l0
  %t1 = load %SpecifierListParseResult, %SpecifierListParseResult* %l0
  %t2 = extractvalue %SpecifierListParseResult %t1, 1
  %t3 = call { %ExportSpecifier*, i64 }* @build_export_specifiers({ %NamedSpecifier*, i64 }* null)
  store { %ExportSpecifier*, i64 }* %t3, { %ExportSpecifier*, i64 }** %l1
  %t4 = alloca [1 x i8]
  %t5 = getelementptr [1 x i8], [1 x i8]* %t4, i32 0, i32 0
  %t6 = getelementptr i8, i8* %t5, i64 0
  store i8 59, i8* %t6
  %t7 = alloca { i8*, i64 }
  %t8 = getelementptr { i8*, i64 }, { i8*, i64 }* %t7, i32 0, i32 0
  store i8* %t5, i8** %t8
  %t9 = getelementptr { i8*, i64 }, { i8*, i64 }* %t7, i32 0, i32 1
  store i64 1, i64* %t9
  %t10 = call %CaptureResult @collect_until(%Parser %parser, { i8**, i64 }* null)
  store %CaptureResult %t10, %CaptureResult* %l2
  %t11 = load %CaptureResult, %CaptureResult* %l2
  %t12 = extractvalue %CaptureResult %t11, 1
  %t13 = call i8* @tokens_to_text({ %Token*, i64 }* null)
  %t14 = call i8* @trim_text(i8* %t13)
  store i8* %t14, i8** %l3
  %t15 = load i8*, i8** %l3
  %t16 = call i8* @strip_surrounding_quotes(i8* %t15)
  store i8* %t16, i8** %l3
  %t18 = call %Token @parser_peek_raw(%Parser %parser)
  %t19 = extractvalue %Token %t18, 0
  store double 0.0, double* %l4
  %t20 = insertvalue %StatementParseResult undef, i8* null, 0
  %t21 = load double, double* %l4
  %t22 = insertvalue %StatementParseResult %t20, i8* null, 1
  ret %StatementParseResult %t22
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
  %l13 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Token*, i64 }* null, { %Token*, i64 }** %l0
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
  store double 0.0, double* %l13
  %t43 = insertvalue %StatementParseResult undef, i8* null, 0
  %t44 = load double, double* %l13
  %t45 = insertvalue %StatementParseResult %t43, i8* null, 1
  ret %StatementParseResult %t45
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
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %NamedSpecifier*, i64 }* null, { %NamedSpecifier*, i64 }** %l0
  %t5 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l0
  br label %loop.header0
loop.header0:
  %t42 = phi { %NamedSpecifier*, i64 }* [ %t5, %entry ], [ %t41, %loop.latch2 ]
  store { %NamedSpecifier*, i64 }* %t42, { %NamedSpecifier*, i64 }** %l0
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
  %t26 = load i8*, i8** %l2
  %t27 = insertvalue %NamedSpecifier undef, i8* %t26, 0
  %t28 = load i8*, i8** %l3
  %t29 = insertvalue %NamedSpecifier %t27, i8* %t28, 1
  %t30 = alloca [1 x %NamedSpecifier]
  %t31 = getelementptr [1 x %NamedSpecifier], [1 x %NamedSpecifier]* %t30, i32 0, i32 0
  %t32 = getelementptr %NamedSpecifier, %NamedSpecifier* %t31, i64 0
  store %NamedSpecifier %t29, %NamedSpecifier* %t32
  %t33 = alloca { %NamedSpecifier*, i64 }
  %t34 = getelementptr { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %t33, i32 0, i32 0
  store %NamedSpecifier* %t31, %NamedSpecifier** %t34
  %t35 = getelementptr { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %t33, i32 0, i32 1
  store i64 1, i64* %t35
  %t36 = call double @specifiersconcat({ %NamedSpecifier*, i64 }* %t33)
  store { %NamedSpecifier*, i64 }* null, { %NamedSpecifier*, i64 }** %l0
  %t37 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t37, %Token* %l6
  %t39 = load %Token, %Token* %l6
  %t40 = extractvalue %Token %t39, 0
  br label %loop.latch2
loop.latch2:
  %t41 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t44 = call %Token @parser_peek_raw(%Parser %parser)
  %t45 = extractvalue %Token %t44, 0
  %t46 = insertvalue %SpecifierListParseResult undef, i8* null, 0
  %t47 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l0
  %t48 = insertvalue %SpecifierListParseResult %t46, { i8**, i64 }* null, 1
  ret %SpecifierListParseResult %t48
}

define { %ImportSpecifier*, i64 }* @build_import_specifiers({ %NamedSpecifier*, i64 }* %values) {
entry:
  %l0 = alloca { %ImportSpecifier*, i64 }*
  %l1 = alloca double
  %l2 = alloca %NamedSpecifier
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %ImportSpecifier*, i64 }* null, { %ImportSpecifier*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %ImportSpecifier*, i64 }*, { %ImportSpecifier*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t40 = phi { %ImportSpecifier*, i64 }* [ %t6, %entry ], [ %t38, %loop.latch2 ]
  %t41 = phi double [ %t7, %entry ], [ %t39, %loop.latch2 ]
  store { %ImportSpecifier*, i64 }* %t40, { %ImportSpecifier*, i64 }** %l0
  store double %t41, double* %l1
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
  %t16 = load { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %values
  %t17 = extractvalue { %NamedSpecifier*, i64 } %t16, 0
  %t18 = extractvalue { %NamedSpecifier*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %NamedSpecifier, %NamedSpecifier* %t17, i64 %t15
  %t21 = load %NamedSpecifier, %NamedSpecifier* %t20
  store %NamedSpecifier %t21, %NamedSpecifier* %l2
  %t22 = load %NamedSpecifier, %NamedSpecifier* %l2
  %t23 = extractvalue %NamedSpecifier %t22, 0
  %t24 = insertvalue %ImportSpecifier undef, i8* %t23, 0
  %t25 = load %NamedSpecifier, %NamedSpecifier* %l2
  %t26 = extractvalue %NamedSpecifier %t25, 1
  %t27 = insertvalue %ImportSpecifier %t24, i8* %t26, 1
  %t28 = alloca [1 x %ImportSpecifier]
  %t29 = getelementptr [1 x %ImportSpecifier], [1 x %ImportSpecifier]* %t28, i32 0, i32 0
  %t30 = getelementptr %ImportSpecifier, %ImportSpecifier* %t29, i64 0
  store %ImportSpecifier %t27, %ImportSpecifier* %t30
  %t31 = alloca { %ImportSpecifier*, i64 }
  %t32 = getelementptr { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %t31, i32 0, i32 0
  store %ImportSpecifier* %t29, %ImportSpecifier** %t32
  %t33 = getelementptr { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %t31, i32 0, i32 1
  store i64 1, i64* %t33
  %t34 = call double @resultconcat({ %ImportSpecifier*, i64 }* %t31)
  store { %ImportSpecifier*, i64 }* null, { %ImportSpecifier*, i64 }** %l0
  %t35 = load double, double* %l1
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l1
  br label %loop.latch2
loop.latch2:
  %t38 = load { %ImportSpecifier*, i64 }*, { %ImportSpecifier*, i64 }** %l0
  %t39 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t42 = load { %ImportSpecifier*, i64 }*, { %ImportSpecifier*, i64 }** %l0
  ret { %ImportSpecifier*, i64 }* %t42
}

define { %ExportSpecifier*, i64 }* @build_export_specifiers({ %NamedSpecifier*, i64 }* %values) {
entry:
  %l0 = alloca { %ExportSpecifier*, i64 }*
  %l1 = alloca double
  %l2 = alloca %NamedSpecifier
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %ExportSpecifier*, i64 }* null, { %ExportSpecifier*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %ExportSpecifier*, i64 }*, { %ExportSpecifier*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t40 = phi { %ExportSpecifier*, i64 }* [ %t6, %entry ], [ %t38, %loop.latch2 ]
  %t41 = phi double [ %t7, %entry ], [ %t39, %loop.latch2 ]
  store { %ExportSpecifier*, i64 }* %t40, { %ExportSpecifier*, i64 }** %l0
  store double %t41, double* %l1
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
  %t16 = load { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %values
  %t17 = extractvalue { %NamedSpecifier*, i64 } %t16, 0
  %t18 = extractvalue { %NamedSpecifier*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %NamedSpecifier, %NamedSpecifier* %t17, i64 %t15
  %t21 = load %NamedSpecifier, %NamedSpecifier* %t20
  store %NamedSpecifier %t21, %NamedSpecifier* %l2
  %t22 = load %NamedSpecifier, %NamedSpecifier* %l2
  %t23 = extractvalue %NamedSpecifier %t22, 0
  %t24 = insertvalue %ExportSpecifier undef, i8* %t23, 0
  %t25 = load %NamedSpecifier, %NamedSpecifier* %l2
  %t26 = extractvalue %NamedSpecifier %t25, 1
  %t27 = insertvalue %ExportSpecifier %t24, i8* %t26, 1
  %t28 = alloca [1 x %ExportSpecifier]
  %t29 = getelementptr [1 x %ExportSpecifier], [1 x %ExportSpecifier]* %t28, i32 0, i32 0
  %t30 = getelementptr %ExportSpecifier, %ExportSpecifier* %t29, i64 0
  store %ExportSpecifier %t27, %ExportSpecifier* %t30
  %t31 = alloca { %ExportSpecifier*, i64 }
  %t32 = getelementptr { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %t31, i32 0, i32 0
  store %ExportSpecifier* %t29, %ExportSpecifier** %t32
  %t33 = getelementptr { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %t31, i32 0, i32 1
  store i64 1, i64* %t33
  %t34 = call double @resultconcat({ %ExportSpecifier*, i64 }* %t31)
  store { %ExportSpecifier*, i64 }* null, { %ExportSpecifier*, i64 }** %l0
  %t35 = load double, double* %l1
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l1
  br label %loop.latch2
loop.latch2:
  %t38 = load { %ExportSpecifier*, i64 }*, { %ExportSpecifier*, i64 }** %l0
  %t39 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t42 = load { %ExportSpecifier*, i64 }*, { %ExportSpecifier*, i64 }** %l0
  ret { %ExportSpecifier*, i64 }* %t42
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
  %l15 = alloca double
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
  %t17 = alloca [0 x double]
  %t18 = getelementptr [0 x double], [0 x double]* %t17, i32 0, i32 0
  %t19 = alloca { double*, i64 }
  %t20 = getelementptr { double*, i64 }, { double*, i64 }* %t19, i32 0, i32 0
  store double* %t18, double** %t20
  %t21 = getelementptr { double*, i64 }, { double*, i64 }* %t19, i32 0, i32 1
  store i64 0, i64* %t21
  store { %FieldDeclaration*, i64 }* null, { %FieldDeclaration*, i64 }** %l7
  %t22 = alloca [0 x double]
  %t23 = getelementptr [0 x double], [0 x double]* %t22, i32 0, i32 0
  %t24 = alloca { double*, i64 }
  %t25 = getelementptr { double*, i64 }, { double*, i64 }* %t24, i32 0, i32 0
  store double* %t23, double** %t25
  %t26 = getelementptr { double*, i64 }, { double*, i64 }* %t24, i32 0, i32 1
  store i64 0, i64* %t26
  store { %MethodDeclaration*, i64 }* null, { %MethodDeclaration*, i64 }** %l8
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
  %t134 = phi { %FieldDeclaration*, i64 }* [ %t34, %entry ], [ %t132, %loop.latch2 ]
  %t135 = phi { %MethodDeclaration*, i64 }* [ %t35, %entry ], [ %t133, %loop.latch2 ]
  store { %FieldDeclaration*, i64 }* %t134, { %FieldDeclaration*, i64 }** %l7
  store { %MethodDeclaration*, i64 }* %t135, { %MethodDeclaration*, i64 }** %l8
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
  %t91 = call %MethodParseResult @parse_struct_method(%Parser %parser, { %Decorator*, i64 }* null)
  store %MethodParseResult %t91, %MethodParseResult* %l14
  %t92 = load %MethodParseResult, %MethodParseResult* %l14
  %t93 = extractvalue %MethodParseResult %t92, 2
  %t94 = load %Token, %Token* %l0
  %t95 = load i8*, i8** %l1
  %t96 = load double, double* %l2
  %t97 = load %TypeParameterParseResult, %TypeParameterParseResult* %l3
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t99 = load %ImplementsParseResult, %ImplementsParseResult* %l5
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t101 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l7
  %t102 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %l8
  %t103 = load %Parser, %Parser* %l9
  %t104 = load %DecoratorParseResult, %DecoratorParseResult* %l10
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t106 = load %Token, %Token* %l12
  %t107 = load %StructFieldParseResult, %StructFieldParseResult* %l13
  %t108 = load %MethodParseResult, %MethodParseResult* %l14
  br i1 %t93, label %then8, label %merge9
then8:
  %t109 = load %MethodParseResult, %MethodParseResult* %l14
  %t110 = extractvalue %MethodParseResult %t109, 1
  %t111 = icmp ne i8* %t110, null
  %t112 = load %Token, %Token* %l0
  %t113 = load i8*, i8** %l1
  %t114 = load double, double* %l2
  %t115 = load %TypeParameterParseResult, %TypeParameterParseResult* %l3
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t117 = load %ImplementsParseResult, %ImplementsParseResult* %l5
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t119 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l7
  %t120 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %l8
  %t121 = load %Parser, %Parser* %l9
  %t122 = load %DecoratorParseResult, %DecoratorParseResult* %l10
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t124 = load %Token, %Token* %l12
  %t125 = load %StructFieldParseResult, %StructFieldParseResult* %l13
  %t126 = load %MethodParseResult, %MethodParseResult* %l14
  br i1 %t111, label %then10, label %merge11
then10:
  %t127 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %l8
  %t128 = load %MethodParseResult, %MethodParseResult* %l14
  %t129 = extractvalue %MethodParseResult %t128, 1
  %t130 = call { %MethodDeclaration*, i64 }* @append_method({ %MethodDeclaration*, i64 }* %t127, %MethodDeclaration zeroinitializer)
  store { %MethodDeclaration*, i64 }* %t130, { %MethodDeclaration*, i64 }** %l8
  br label %merge11
merge11:
  %t131 = phi { %MethodDeclaration*, i64 }* [ %t130, %then10 ], [ %t120, %then8 ]
  store { %MethodDeclaration*, i64 }* %t131, { %MethodDeclaration*, i64 }** %l8
  br label %loop.latch2
merge9:
  br label %loop.latch2
loop.latch2:
  %t132 = load { %FieldDeclaration*, i64 }*, { %FieldDeclaration*, i64 }** %l7
  %t133 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %l8
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l15
  %t136 = insertvalue %StatementParseResult undef, i8* null, 0
  %t137 = load double, double* %l15
  %t138 = insertvalue %StatementParseResult %t136, i8* null, 1
  ret %StatementParseResult %t138
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
  %l10 = alloca double
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
  %t27 = call %CaptureResult @collect_until(%Parser %t20, { i8**, i64 }* null)
  store %CaptureResult %t27, %CaptureResult* %l7
  %t28 = load %CaptureResult, %CaptureResult* %l7
  %t29 = extractvalue %CaptureResult %t28, 1
  %t30 = call i8* @tokens_to_text({ %Token*, i64 }* null)
  %t31 = call i8* @trim_text(i8* %t30)
  store i8* %t31, i8** %l8
  %t32 = load i8*, i8** %l8
  %t33 = load i8*, i8** %l8
  %t34 = insertvalue %TypeAnnotation undef, i8* %t33, 0
  store %TypeAnnotation %t34, %TypeAnnotation* %l9
  %t36 = call %Token @parser_peek_raw(%Parser %parser)
  %t37 = extractvalue %Token %t36, 0
  store double 0.0, double* %l10
  %t38 = insertvalue %StatementParseResult undef, i8* null, 0
  %t39 = load double, double* %l10
  %t40 = insertvalue %StatementParseResult %t38, i8* null, 1
  ret %StatementParseResult %t40
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
  %l12 = alloca double
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
  %t16 = alloca [0 x double]
  %t17 = getelementptr [0 x double], [0 x double]* %t16, i32 0, i32 0
  %t18 = alloca { double*, i64 }
  %t19 = getelementptr { double*, i64 }, { double*, i64 }* %t18, i32 0, i32 0
  store double* %t17, double** %t19
  %t20 = getelementptr { double*, i64 }, { double*, i64 }* %t18, i32 0, i32 1
  store i64 0, i64* %t20
  store { %FunctionSignature*, i64 }* null, { %FunctionSignature*, i64 }** %l6
  %t21 = load %Parser, %Parser* %l0
  %t22 = load %Token, %Token* %l1
  %t23 = load i8*, i8** %l2
  %t24 = load double, double* %l3
  %t25 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t27 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %l6
  br label %loop.header0
loop.header0:
  %t74 = phi { %FunctionSignature*, i64 }* [ %t27, %entry ], [ %t73, %loop.latch2 ]
  store { %FunctionSignature*, i64 }* %t74, { %FunctionSignature*, i64 }** %l6
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
  %t38 = call %InterfaceMemberParseResult @parse_interface_member(%Parser %parser, { %Decorator*, i64 }* null)
  store %InterfaceMemberParseResult %t38, %InterfaceMemberParseResult* %l11
  %t39 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l11
  %t40 = extractvalue %InterfaceMemberParseResult %t39, 2
  %t41 = load %Parser, %Parser* %l0
  %t42 = load %Token, %Token* %l1
  %t43 = load i8*, i8** %l2
  %t44 = load double, double* %l3
  %t45 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t47 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %l6
  %t48 = load %Token, %Token* %l7
  %t49 = load %Parser, %Parser* %l8
  %t50 = load %DecoratorParseResult, %DecoratorParseResult* %l9
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t52 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l11
  br i1 %t40, label %then4, label %merge5
then4:
  %t53 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l11
  %t54 = extractvalue %InterfaceMemberParseResult %t53, 1
  %t55 = icmp ne i8* %t54, null
  %t56 = load %Parser, %Parser* %l0
  %t57 = load %Token, %Token* %l1
  %t58 = load i8*, i8** %l2
  %t59 = load double, double* %l3
  %t60 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t62 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %l6
  %t63 = load %Token, %Token* %l7
  %t64 = load %Parser, %Parser* %l8
  %t65 = load %DecoratorParseResult, %DecoratorParseResult* %l9
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t67 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l11
  br i1 %t55, label %then6, label %merge7
then6:
  %t68 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %l6
  %t69 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l11
  %t70 = extractvalue %InterfaceMemberParseResult %t69, 1
  %t71 = call { %FunctionSignature*, i64 }* @append_signature({ %FunctionSignature*, i64 }* %t68, %FunctionSignature zeroinitializer)
  store { %FunctionSignature*, i64 }* %t71, { %FunctionSignature*, i64 }** %l6
  br label %merge7
merge7:
  %t72 = phi { %FunctionSignature*, i64 }* [ %t71, %then6 ], [ %t62, %then4 ]
  store { %FunctionSignature*, i64 }* %t72, { %FunctionSignature*, i64 }** %l6
  br label %loop.latch2
merge5:
  br label %loop.latch2
loop.latch2:
  %t73 = load { %FunctionSignature*, i64 }*, { %FunctionSignature*, i64 }** %l6
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l12
  %t75 = insertvalue %StatementParseResult undef, i8* null, 0
  %t76 = load double, double* %l12
  %t77 = insertvalue %StatementParseResult %t75, i8* null, 1
  ret %StatementParseResult %t77
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
  %l9 = alloca double
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
  %t16 = alloca [0 x double]
  %t17 = getelementptr [0 x double], [0 x double]* %t16, i32 0, i32 0
  %t18 = alloca { double*, i64 }
  %t19 = getelementptr { double*, i64 }, { double*, i64 }* %t18, i32 0, i32 0
  store double* %t17, double** %t19
  %t20 = getelementptr { double*, i64 }, { double*, i64 }* %t18, i32 0, i32 1
  store i64 0, i64* %t20
  store { %EnumVariant*, i64 }* null, { %EnumVariant*, i64 }** %l6
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
  store double 0.0, double* %l9
  %t65 = insertvalue %StatementParseResult undef, i8* null, 0
  %t66 = load double, double* %l9
  %t67 = insertvalue %StatementParseResult %t65, i8* null, 1
  ret %StatementParseResult %t67
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
  %l19 = alloca double
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
  store double 0.0, double* %l19
  %t131 = load %Parser, %Parser* %l1
  %t132 = insertvalue %InterfaceMemberParseResult undef, i8* null, 0
  %t133 = load double, double* %l19
  %t134 = insertvalue %InterfaceMemberParseResult %t132, i8* null, 1
  %t135 = insertvalue %InterfaceMemberParseResult %t134, i1 1, 2
  ret %InterfaceMemberParseResult %t135
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
  %l8 = alloca double
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
  %t17 = alloca [0 x double]
  %t18 = getelementptr [0 x double], [0 x double]* %t17, i32 0, i32 0
  %t19 = alloca { double*, i64 }
  %t20 = getelementptr { double*, i64 }, { double*, i64 }* %t19, i32 0, i32 0
  store double* %t18, double** %t20
  %t21 = getelementptr { double*, i64 }, { double*, i64 }* %t19, i32 0, i32 1
  store i64 0, i64* %t21
  store { %FieldDeclaration*, i64 }* null, { %FieldDeclaration*, i64 }** %l5
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
  store double 0.0, double* %l8
  %t36 = load %Parser, %Parser* %l1
  %t37 = insertvalue %EnumVariantParseResult undef, i8* null, 0
  %t38 = load double, double* %l8
  %t39 = insertvalue %EnumVariantParseResult %t37, i8* null, 1
  %t40 = insertvalue %EnumVariantParseResult %t39, i1 1, 2
  ret %EnumVariantParseResult %t40
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
  %l13 = alloca double
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
  store double 0.0, double* %l13
  %t86 = load %Parser, %Parser* %l0
  %t87 = insertvalue %StructFieldParseResult undef, i8* null, 0
  %t88 = load double, double* %l13
  %t89 = insertvalue %StructFieldParseResult %t87, i8* null, 1
  %t90 = insertvalue %StructFieldParseResult %t89, i1 1, 2
  ret %StructFieldParseResult %t90
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
  %l14 = alloca double
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
  %t19 = call %CaptureResult @collect_until(%Parser %t11, { i8**, i64 }* null)
  store %CaptureResult %t19, %CaptureResult* %l4
  %t20 = load %CaptureResult, %CaptureResult* %l4
  %t21 = extractvalue %CaptureResult %t20, 1
  %t22 = call i8* @tokens_to_text({ %Token*, i64 }* null)
  %t23 = call i8* @trim_text(i8* %t22)
  store i8* %t23, i8** %l5
  %t24 = load i8*, i8** %l5
  %t25 = load i8*, i8** %l5
  %t26 = insertvalue %TypeAnnotation undef, i8* %t25, 0
  store %TypeAnnotation %t26, %TypeAnnotation* %l6
  %t27 = call %EffectParseResult @parse_effect_list(%Parser %parser)
  store %EffectParseResult %t27, %EffectParseResult* %l7
  %t28 = load %EffectParseResult, %EffectParseResult* %l7
  %t29 = extractvalue %EffectParseResult %t28, 1
  store { i8**, i64 }* %t29, { i8**, i64 }** %l8
  %t30 = alloca [0 x double]
  %t31 = getelementptr [0 x double], [0 x double]* %t30, i32 0, i32 0
  %t32 = alloca { double*, i64 }
  %t33 = getelementptr { double*, i64 }, { double*, i64 }* %t32, i32 0, i32 0
  store double* %t31, double** %t33
  %t34 = getelementptr { double*, i64 }, { double*, i64 }* %t32, i32 0, i32 1
  store i64 0, i64* %t34
  store { %ModelProperty*, i64 }* null, { %ModelProperty*, i64 }** %l9
  %t35 = load %Parser, %Parser* %l0
  %t36 = load %Token, %Token* %l1
  %t37 = load i8*, i8** %l2
  %t38 = load double, double* %l3
  %t39 = load %CaptureResult, %CaptureResult* %l4
  %t40 = load i8*, i8** %l5
  %t41 = load %TypeAnnotation, %TypeAnnotation* %l6
  %t42 = load %EffectParseResult, %EffectParseResult* %l7
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t44 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %l9
  br label %loop.header0
loop.header0:
  %t83 = phi { %ModelProperty*, i64 }* [ %t44, %entry ], [ %t82, %loop.latch2 ]
  store { %ModelProperty*, i64 }* %t83, { %ModelProperty*, i64 }** %l9
  br label %loop.body1
loop.body1:
  %t45 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t45, %Token* %l10
  %t47 = load %Token, %Token* %l10
  %t48 = extractvalue %Token %t47, 0
  %t49 = load %Token, %Token* %l10
  %t50 = extractvalue %Token %t49, 0
  store %Parser %parser, %Parser* %l11
  %t51 = call %ModelPropertyParseResult @parse_model_property(%Parser %parser)
  store %ModelPropertyParseResult %t51, %ModelPropertyParseResult* %l12
  %t53 = load %ModelPropertyParseResult, %ModelPropertyParseResult* %l12
  %t54 = extractvalue %ModelPropertyParseResult %t53, 2
  br label %logical_and_entry_52

logical_and_entry_52:
  br i1 %t54, label %logical_and_right_52, label %logical_and_merge_52

logical_and_right_52:
  %t55 = load %ModelPropertyParseResult, %ModelPropertyParseResult* %l12
  %t56 = extractvalue %ModelPropertyParseResult %t55, 1
  %t57 = icmp ne i8* %t56, null
  br label %logical_and_right_end_52

logical_and_right_end_52:
  br label %logical_and_merge_52

logical_and_merge_52:
  %t58 = phi i1 [ false, %logical_and_entry_52 ], [ %t57, %logical_and_right_end_52 ]
  %t59 = load %Parser, %Parser* %l0
  %t60 = load %Token, %Token* %l1
  %t61 = load i8*, i8** %l2
  %t62 = load double, double* %l3
  %t63 = load %CaptureResult, %CaptureResult* %l4
  %t64 = load i8*, i8** %l5
  %t65 = load %TypeAnnotation, %TypeAnnotation* %l6
  %t66 = load %EffectParseResult, %EffectParseResult* %l7
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t68 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %l9
  %t69 = load %Token, %Token* %l10
  %t70 = load %Parser, %Parser* %l11
  %t71 = load %ModelPropertyParseResult, %ModelPropertyParseResult* %l12
  br i1 %t58, label %then4, label %merge5
then4:
  %t72 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %l9
  %t73 = load %ModelPropertyParseResult, %ModelPropertyParseResult* %l12
  %t74 = extractvalue %ModelPropertyParseResult %t73, 1
  %t75 = call { %ModelProperty*, i64 }* @append_model_property({ %ModelProperty*, i64 }* %t72, %ModelProperty zeroinitializer)
  store { %ModelProperty*, i64 }* %t75, { %ModelProperty*, i64 }** %l9
  br label %loop.latch2
merge5:
  %t76 = call %Token @parser_peek_raw(%Parser %parser)
  store %Token %t76, %Token* %l13
  %t78 = load %Token, %Token* %l13
  %t79 = extractvalue %Token %t78, 0
  %t80 = load %Token, %Token* %l13
  %t81 = extractvalue %Token %t80, 0
  br label %loop.latch2
loop.latch2:
  %t82 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %l9
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l14
  %t84 = insertvalue %StatementParseResult undef, i8* null, 0
  %t85 = load double, double* %l14
  %t86 = insertvalue %StatementParseResult %t84, i8* null, 1
  ret %StatementParseResult %t86
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
  %l15 = alloca double
  %l16 = alloca double
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
  store double 0.0, double* %l15
  store double 0.0, double* %l16
  %t32 = insertvalue %StatementParseResult undef, i8* null, 0
  %t33 = load double, double* %l16
  %t34 = insertvalue %StatementParseResult %t32, i8* null, 1
  ret %StatementParseResult %t34
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
  %l13 = alloca double
  %l14 = alloca double
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
  store double 0.0, double* %l13
  store double 0.0, double* %l14
  %t29 = insertvalue %StatementParseResult undef, i8* null, 0
  %t30 = load double, double* %l14
  %t31 = insertvalue %StatementParseResult %t29, i8* null, 1
  ret %StatementParseResult %t31
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
  %l11 = alloca double
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
  %t8 = call %CaptureResult @collect_until(%Parser %t0, { i8**, i64 }* null)
  store %CaptureResult %t8, %CaptureResult* %l1
  %t9 = load %CaptureResult, %CaptureResult* %l1
  %t10 = extractvalue %CaptureResult %t9, 1
  %t11 = call i8* @tokens_to_text({ %Token*, i64 }* null)
  %t12 = call i8* @trim_text(i8* %t11)
  store i8* %t12, i8** %l2
  %t13 = load i8*, i8** %l2
  %t14 = load %CaptureResult, %CaptureResult* %l1
  %t15 = extractvalue %CaptureResult %t14, 1
  %t16 = call double @source_span_from_tokens({ %Token*, i64 }* null)
  store double %t16, double* %l3
  %t17 = load i8*, i8** %l2
  %t18 = call i8* @normalize_test_name(i8* %t17)
  store i8* %t18, i8** %l4
  %t19 = call %EffectParseResult @parse_effect_list(%Parser %parser)
  store %EffectParseResult %t19, %EffectParseResult* %l5
  %t20 = load %EffectParseResult, %EffectParseResult* %l5
  %t21 = extractvalue %EffectParseResult %t20, 1
  store { i8**, i64 }* %t21, { i8**, i64 }** %l6
  %t22 = call double @evaluate_decorators({ %Decorator*, i64 }* %decorators)
  store double %t22, double* %l7
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t24 = load double, double* %l7
  %t25 = call double @infer_effects({ i8**, i64 }* %t23, double %t24)
  store double %t25, double* %l8
  %t26 = call %BlockParseResult @parse_block(%Parser %parser)
  store %BlockParseResult %t26, %BlockParseResult* %l9
  %t27 = load %BlockParseResult, %BlockParseResult* %l9
  %t28 = extractvalue %BlockParseResult %t27, 1
  store i8* %t28, i8** %l10
  store double 0.0, double* %l11
  %t29 = insertvalue %StatementParseResult undef, i8* null, 0
  %t30 = load double, double* %l11
  %t31 = insertvalue %StatementParseResult %t29, i8* null, 1
  ret %StatementParseResult %t31
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
  %l19 = alloca double
  %l20 = alloca double
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
  store double 0.0, double* %l19
  store double 0.0, double* %l20
  %t53 = insertvalue %StatementParseResult undef, i8* null, 0
  %t54 = load double, double* %l20
  %t55 = insertvalue %StatementParseResult %t53, i8* null, 1
  ret %StatementParseResult %t55
}

define %ParameterListParseResult @parse_parameter_list(%Parser %parser) {
entry:
  %l0 = alloca { %Parameter*, i64 }*
  %l1 = alloca %Token
  %l2 = alloca %ParameterParseResult
  %l3 = alloca %Token
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Parameter*, i64 }* null, { %Parameter*, i64 }** %l0
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
  %t27 = insertvalue %ParameterListParseResult %t25, { i8**, i64 }* null, 1
  ret %ParameterListParseResult %t27
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
  %l11 = alloca double
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
  %t65 = call %CaptureResult @collect_until(%Parser %t58, { i8**, i64 }* null)
  store %CaptureResult %t65, %CaptureResult* %l8
  %t66 = load %CaptureResult, %CaptureResult* %l8
  %t67 = extractvalue %CaptureResult %t66, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t68 = load %CaptureResult, %CaptureResult* %l8
  %t69 = extractvalue %CaptureResult %t68, 1
  %t70 = call i8* @tokens_to_text({ %Token*, i64 }* null)
  %t71 = call i8* @trim_text(i8* %t70)
  store i8* %t71, i8** %l9
  %t72 = load i8*, i8** %l9
  %t73 = load %Parser, %Parser* %l0
  %t74 = call %Parser @skip_trivia(%Parser %t73)
  store %Parser %t74, %Parser* %l0
  %t75 = load %Parser, %Parser* %l0
  %t76 = call %Token @parser_peek_raw(%Parser %t75)
  store %Token %t76, %Token* %l10
  %t78 = load %Token, %Token* %l10
  %t79 = extractvalue %Token %t78, 0
  %t80 = load %Parser, %Parser* %l0
  %t81 = call %Parser @parser_advance_raw(%Parser %t80)
  store %Parser %t81, %Parser* %l0
  store double 0.0, double* %l11
  %t82 = load %Parser, %Parser* %l0
  %t83 = insertvalue %StructFieldParseResult undef, i8* null, 0
  %t84 = load double, double* %l11
  %t85 = insertvalue %StructFieldParseResult %t83, i8* null, 1
  %t86 = insertvalue %StructFieldParseResult %t85, i1 1, 2
  ret %StructFieldParseResult %t86
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
  %l7 = alloca double
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
  %t26 = call %CaptureResult @collect_until(%Parser %t19, { i8**, i64 }* null)
  store %CaptureResult %t26, %CaptureResult* %l4
  %t27 = load %CaptureResult, %CaptureResult* %l4
  %t28 = extractvalue %CaptureResult %t27, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t29 = load %CaptureResult, %CaptureResult* %l4
  %t30 = extractvalue %CaptureResult %t29, 1
  %t31 = call %Expression @expression_from_tokens({ %Token*, i64 }* null)
  store %Expression %t31, %Expression* %l5
  %t32 = load %Parser, %Parser* %l0
  %t33 = call %Parser @skip_trivia(%Parser %t32)
  store %Parser %t33, %Parser* %l0
  %t34 = load %Parser, %Parser* %l0
  %t35 = call %Token @parser_peek_raw(%Parser %t34)
  store %Token %t35, %Token* %l6
  %t37 = load %Token, %Token* %l6
  %t38 = extractvalue %Token %t37, 0
  %t39 = load %Parser, %Parser* %l0
  %t40 = call %Parser @parser_advance_raw(%Parser %t39)
  store %Parser %t40, %Parser* %l0
  store double 0.0, double* %l7
  %t41 = load %Parser, %Parser* %l0
  %t42 = insertvalue %ModelPropertyParseResult undef, i8* null, 0
  %t43 = load double, double* %l7
  %t44 = insertvalue %ModelPropertyParseResult %t42, i8* null, 1
  %t45 = insertvalue %ModelPropertyParseResult %t44, i1 1, 2
  ret %ModelPropertyParseResult %t45
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
  %l19 = alloca double
  %l20 = alloca double
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
  store double 0.0, double* %l19
  store double 0.0, double* %l20
  %t101 = load %Parser, %Parser* %l0
  %t102 = insertvalue %MethodParseResult undef, i8* null, 0
  %t103 = load double, double* %l20
  %t104 = insertvalue %MethodParseResult %t102, i8* null, 1
  %t105 = insertvalue %MethodParseResult %t104, i1 1, 2
  ret %MethodParseResult %t105
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
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Decorator*, i64 }* null, { %Decorator*, i64 }** %l1
  %t5 = load %Parser, %Parser* %l0
  %t6 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t47 = phi %Parser [ %t5, %entry ], [ %t45, %loop.latch2 ]
  %t48 = phi { %Decorator*, i64 }* [ %t6, %entry ], [ %t46, %loop.latch2 ]
  store %Parser %t47, %Parser* %l0
  store { %Decorator*, i64 }* %t48, { %Decorator*, i64 }** %l1
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
  %t29 = alloca [0 x double]
  %t30 = getelementptr [0 x double], [0 x double]* %t29, i32 0, i32 0
  %t31 = alloca { double*, i64 }
  %t32 = getelementptr { double*, i64 }, { double*, i64 }* %t31, i32 0, i32 0
  store double* %t30, double** %t32
  %t33 = getelementptr { double*, i64 }, { double*, i64 }* %t31, i32 0, i32 1
  store i64 0, i64* %t33
  store { %DecoratorArgument*, i64 }* null, { %DecoratorArgument*, i64 }** %l6
  %t34 = load %Parser, %Parser* %l0
  %t35 = call %Token @parser_peek_raw(%Parser %t34)
  store %Token %t35, %Token* %l7
  %t37 = load %Token, %Token* %l7
  %t38 = extractvalue %Token %t37, 0
  %t39 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l1
  %t40 = load i8*, i8** %l5
  %t41 = insertvalue %Decorator undef, i8* %t40, 0
  %t42 = load { %DecoratorArgument*, i64 }*, { %DecoratorArgument*, i64 }** %l6
  %t43 = insertvalue %Decorator %t41, { i8**, i64 }* null, 1
  %t44 = call { %Decorator*, i64 }* @append_decorator({ %Decorator*, i64 }* %t39, %Decorator %t43)
  store { %Decorator*, i64 }* %t44, { %Decorator*, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t45 = load %Parser, %Parser* %l0
  %t46 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t49 = load %Parser, %Parser* %l0
  %t50 = insertvalue %DecoratorParseResult undef, i8* null, 0
  %t51 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l1
  %t52 = insertvalue %DecoratorParseResult %t50, { i8**, i64 }* null, 1
  ret %DecoratorParseResult %t52
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
  %t8 = alloca [0 x double]
  %t9 = getelementptr [0 x double], [0 x double]* %t8, i32 0, i32 0
  %t10 = alloca { double*, i64 }
  %t11 = getelementptr { double*, i64 }, { double*, i64 }* %t10, i32 0, i32 0
  store double* %t9, double** %t11
  %t12 = getelementptr { double*, i64 }, { double*, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { %Token*, i64 }* null, { %Token*, i64 }** %l2
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
  %t35 = alloca [0 x double]
  %t36 = getelementptr [0 x double], [0 x double]* %t35, i32 0, i32 0
  %t37 = alloca { double*, i64 }
  %t38 = getelementptr { double*, i64 }, { double*, i64 }* %t37, i32 0, i32 0
  store double* %t36, double** %t38
  %t39 = getelementptr { double*, i64 }, { double*, i64 }* %t37, i32 0, i32 1
  store i64 0, i64* %t39
  store { %TypeParameter*, i64 }* null, { %TypeParameter*, i64 }** %l6
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
  %t127 = phi double [ %t47, %entry ], [ %t126, %loop.latch6 ]
  store double %t127, double* %l7
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
  %t63 = load { i8**, i64 }, { i8**, i64 }* %t61
  %t64 = extractvalue { i8**, i64 } %t63, 0
  %t65 = extractvalue { i8**, i64 } %t63, 1
  %t66 = icmp uge i64 %t62, %t65
  ; bounds check: %t66 (if true, out of bounds)
  %t67 = getelementptr i8*, i8** %t64, i64 %t62
  %t68 = load i8*, i8** %t67
  %t69 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* null)
  store { %Token*, i64 }* %t69, { %Token*, i64 }** %l8
  %t70 = load { %Token*, i64 }*, { %Token*, i64 }** %l8
  %t71 = load { %Token*, i64 }, { %Token*, i64 }* %t70
  %t72 = extractvalue { %Token*, i64 } %t71, 1
  %t73 = icmp sgt i64 %t72, 0
  %t74 = load %Parser, %Parser* %l0
  %t75 = load %Token, %Token* %l1
  %t76 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t77 = load double, double* %l3
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t79 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l6
  %t80 = load double, double* %l7
  %t81 = load { %Token*, i64 }*, { %Token*, i64 }** %l8
  br i1 %t73, label %then10, label %merge11
then10:
  %t82 = load { %Token*, i64 }*, { %Token*, i64 }** %l8
  %t83 = call double @find_top_level_symbol({ %Token*, i64 }* %t82, i8* null)
  store double %t83, double* %l9
  %t84 = load { %Token*, i64 }*, { %Token*, i64 }** %l8
  store { %Token*, i64 }* %t84, { %Token*, i64 }** %l10
  %t85 = alloca [0 x double]
  %t86 = getelementptr [0 x double], [0 x double]* %t85, i32 0, i32 0
  %t87 = alloca { double*, i64 }
  %t88 = getelementptr { double*, i64 }, { double*, i64 }* %t87, i32 0, i32 0
  store double* %t86, double** %t88
  %t89 = getelementptr { double*, i64 }, { double*, i64 }* %t87, i32 0, i32 1
  store i64 0, i64* %t89
  store { %Token*, i64 }* null, { %Token*, i64 }** %l11
  %t90 = load double, double* %l9
  %t91 = sitofp i64 -1 to double
  %t92 = fcmp une double %t90, %t91
  %t93 = load %Parser, %Parser* %l0
  %t94 = load %Token, %Token* %l1
  %t95 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t96 = load double, double* %l3
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t98 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l6
  %t99 = load double, double* %l7
  %t100 = load { %Token*, i64 }*, { %Token*, i64 }** %l8
  %t101 = load double, double* %l9
  %t102 = load { %Token*, i64 }*, { %Token*, i64 }** %l10
  %t103 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  br i1 %t92, label %then12, label %merge13
then12:
  %t104 = load { %Token*, i64 }*, { %Token*, i64 }** %l8
  %t105 = load double, double* %l9
  %t106 = sitofp i64 0 to double
  %t107 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t104, double %t106, double %t105)
  store { %Token*, i64 }* %t107, { %Token*, i64 }** %l10
  %t108 = load { %Token*, i64 }*, { %Token*, i64 }** %l8
  %t109 = load double, double* %l9
  %t110 = sitofp i64 1 to double
  %t111 = fadd double %t109, %t110
  %t112 = load { %Token*, i64 }*, { %Token*, i64 }** %l8
  %t113 = load { %Token*, i64 }, { %Token*, i64 }* %t112
  %t114 = extractvalue { %Token*, i64 } %t113, 1
  %t115 = sitofp i64 %t114 to double
  %t116 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t108, double %t111, double %t115)
  store { %Token*, i64 }* %t116, { %Token*, i64 }** %l11
  br label %merge13
merge13:
  %t117 = phi { %Token*, i64 }* [ %t107, %then12 ], [ %t102, %then10 ]
  %t118 = phi { %Token*, i64 }* [ %t116, %then12 ], [ %t103, %then10 ]
  store { %Token*, i64 }* %t117, { %Token*, i64 }** %l10
  store { %Token*, i64 }* %t118, { %Token*, i64 }** %l11
  %t119 = load { %Token*, i64 }*, { %Token*, i64 }** %l10
  %t120 = call i8* @tokens_to_text({ %Token*, i64 }* %t119)
  %t121 = call i8* @trim_text(i8* %t120)
  store i8* %t121, i8** %l12
  %t122 = load i8*, i8** %l12
  br label %merge11
merge11:
  %t123 = load double, double* %l7
  %t124 = sitofp i64 1 to double
  %t125 = fadd double %t123, %t124
  store double %t125, double* %l7
  br label %loop.latch6
loop.latch6:
  %t126 = load double, double* %l7
  br label %loop.header4
afterloop7:
  %t128 = load %Parser, %Parser* %l0
  %t129 = insertvalue %TypeParameterParseResult undef, i8* null, 0
  %t130 = load { %TypeParameter*, i64 }*, { %TypeParameter*, i64 }** %l6
  %t131 = insertvalue %TypeParameterParseResult %t129, { i8**, i64 }* null, 1
  ret %TypeParameterParseResult %t131
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
  %t8 = alloca [0 x double]
  %t9 = getelementptr [0 x double], [0 x double]* %t8, i32 0, i32 0
  %t10 = alloca { double*, i64 }
  %t11 = getelementptr { double*, i64 }, { double*, i64 }* %t10, i32 0, i32 0
  store double* %t9, double** %t11
  %t12 = getelementptr { double*, i64 }, { double*, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  %t13 = insertvalue %ImplementsParseResult %t7, { i8**, i64 }* null, 1
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
  %t27 = call %CaptureResult @collect_until(%Parser %t20, { i8**, i64 }* null)
  store %CaptureResult %t27, %CaptureResult* %l1
  %t28 = load %CaptureResult, %CaptureResult* %l1
  %t29 = extractvalue %CaptureResult %t28, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t30 = alloca [0 x double]
  %t31 = getelementptr [0 x double], [0 x double]* %t30, i32 0, i32 0
  %t32 = alloca { double*, i64 }
  %t33 = getelementptr { double*, i64 }, { double*, i64 }* %t32, i32 0, i32 0
  store double* %t31, double** %t33
  %t34 = getelementptr { double*, i64 }, { double*, i64 }* %t32, i32 0, i32 1
  store i64 0, i64* %t34
  store { %TypeAnnotation*, i64 }* null, { %TypeAnnotation*, i64 }** %l2
  %t35 = load %CaptureResult, %CaptureResult* %l1
  %t36 = extractvalue %CaptureResult %t35, 1
  %t37 = call { i8**, i64 }* @split_tokens_by_comma({ %Token*, i64 }* null)
  store { i8**, i64 }* %t37, { i8**, i64 }** %l3
  %t38 = sitofp i64 0 to double
  store double %t38, double* %l4
  %t39 = load %Parser, %Parser* %l0
  %t40 = load %CaptureResult, %CaptureResult* %l1
  %t41 = load { %TypeAnnotation*, i64 }*, { %TypeAnnotation*, i64 }** %l2
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t43 = load double, double* %l4
  br label %loop.header2
loop.header2:
  %t69 = phi double [ %t43, %entry ], [ %t68, %loop.latch4 ]
  store double %t69, double* %l4
  br label %loop.body3
loop.body3:
  %t44 = load double, double* %l4
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t46 = load { i8**, i64 }, { i8**, i64 }* %t45
  %t47 = extractvalue { i8**, i64 } %t46, 1
  %t48 = sitofp i64 %t47 to double
  %t49 = fcmp oge double %t44, %t48
  %t50 = load %Parser, %Parser* %l0
  %t51 = load %CaptureResult, %CaptureResult* %l1
  %t52 = load { %TypeAnnotation*, i64 }*, { %TypeAnnotation*, i64 }** %l2
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t54 = load double, double* %l4
  br i1 %t49, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t56 = load double, double* %l4
  %t57 = load { i8**, i64 }, { i8**, i64 }* %t55
  %t58 = extractvalue { i8**, i64 } %t57, 0
  %t59 = extractvalue { i8**, i64 } %t57, 1
  %t60 = icmp uge i64 %t56, %t59
  ; bounds check: %t60 (if true, out of bounds)
  %t61 = getelementptr i8*, i8** %t58, i64 %t56
  %t62 = load i8*, i8** %t61
  %t63 = call i8* @trim_text(i8* %t62)
  store i8* %t63, i8** %l5
  %t64 = load i8*, i8** %l5
  %t65 = load double, double* %l4
  %t66 = sitofp i64 1 to double
  %t67 = fadd double %t65, %t66
  store double %t67, double* %l4
  br label %loop.latch4
loop.latch4:
  %t68 = load double, double* %l4
  br label %loop.header2
afterloop5:
  %t70 = load %Parser, %Parser* %l0
  %t71 = insertvalue %ImplementsParseResult undef, i8* null, 0
  %t72 = load { %TypeAnnotation*, i64 }*, { %TypeAnnotation*, i64 }** %l2
  %t73 = insertvalue %ImplementsParseResult %t71, { i8**, i64 }* null, 1
  %t74 = insertvalue %ImplementsParseResult %t73, i1 1, 2
  ret %ImplementsParseResult %t74
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
  %l13 = alloca double
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
  %t27 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* null, double %t25, double %t26)
  store { %Token*, i64 }* %t27, { %Token*, i64 }** %l11
  %t28 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t29 = call double @source_span_from_tokens({ %Token*, i64 }* %t28)
  store double %t29, double* %l12
  store double 0.0, double* %l13
  %t30 = insertvalue %ParameterParseResult undef, i8* null, 0
  %t31 = load double, double* %l13
  %t32 = insertvalue %ParameterParseResult %t30, i8* null, 1
  ret %ParameterParseResult %t32
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
  %t4 = alloca [0 x double]
  %t5 = getelementptr [0 x double], [0 x double]* %t4, i32 0, i32 0
  %t6 = alloca { double*, i64 }
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 0
  store double* %t5, double** %t7
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* null, { i8**, i64 }** %l1
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
  %t7 = alloca [0 x double]
  %t8 = getelementptr [0 x double], [0 x double]* %t7, i32 0, i32 0
  %t9 = alloca { double*, i64 }
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t9, i32 0, i32 0
  store double* %t8, double** %t10
  %t11 = getelementptr { double*, i64 }, { double*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %Statement*, i64 }* null, { %Statement*, i64 }** %l4
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
  %t98 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* null, double %t96, double %t97)
  store { %Token*, i64 }* %t98, { %Token*, i64 }** %l10
  %t99 = load { %Token*, i64 }*, { %Token*, i64 }** %l10
  %t100 = call { %Token*, i64 }* @trim_block_tokens({ %Token*, i64 }* %t99)
  store { %Token*, i64 }* %t100, { %Token*, i64 }** %l10
  %t101 = load { %Token*, i64 }*, { %Token*, i64 }** %l10
  %t102 = call i8* @tokens_to_text({ %Token*, i64 }* %t101)
  store i8* %t102, i8** %l11
  %t103 = load { %Token*, i64 }*, { %Token*, i64 }** %l10
  %t104 = insertvalue %Block undef, { i8**, i64 }* null, 0
  %t105 = load i8*, i8** %l11
  %t106 = insertvalue %Block %t104, i8* %t105, 1
  %t107 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l4
  %t108 = insertvalue %Block %t106, { i8**, i64 }* null, 2
  store %Block %t108, %Block* %l12
  %t109 = load %Parser, %Parser* %l2
  %t110 = call %Parser @skip_trivia(%Parser %t109)
  %t111 = insertvalue %BlockParseResult undef, i8* null, 0
  %t112 = load %Block, %Block* %l12
  %t113 = insertvalue %BlockParseResult %t111, i8* null, 1
  ret %BlockParseResult %t113
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
  %t20 = call %BlockStatementParseResult @parse_for_statement(%Parser %t18, { %Decorator*, i64 }* null)
  ret %BlockStatementParseResult %t20
merge1:
  %t21 = load %Token, %Token* %l5
  %s22 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.22, i32 0, i32 0
  %t23 = call i1 @identifier_matches(%Token %t21, i8* %s22)
  %t24 = load %Parser, %Parser* %l0
  %t25 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t26 = load i8*, i8** %l2
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t28 = load %Parser, %Parser* %l4
  %t29 = load %Token, %Token* %l5
  br i1 %t23, label %then2, label %merge3
then2:
  %t30 = load %Parser, %Parser* %l4
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t32 = call %BlockStatementParseResult @parse_loop_statement(%Parser %t30, { %Decorator*, i64 }* null)
  ret %BlockStatementParseResult %t32
merge3:
  %t33 = load %Token, %Token* %l5
  %s34 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.34, i32 0, i32 0
  %t35 = call i1 @identifier_matches(%Token %t33, i8* %s34)
  %t36 = load %Parser, %Parser* %l0
  %t37 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t38 = load i8*, i8** %l2
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t40 = load %Parser, %Parser* %l4
  %t41 = load %Token, %Token* %l5
  br i1 %t35, label %then4, label %merge5
then4:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t43 = load { i8**, i64 }, { i8**, i64 }* %t42
  %t44 = extractvalue { i8**, i64 } %t43, 1
  %t45 = icmp sgt i64 %t44, 0
  %t46 = load %Parser, %Parser* %l0
  %t47 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t48 = load i8*, i8** %l2
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t50 = load %Parser, %Parser* %l4
  %t51 = load %Token, %Token* %l5
  br i1 %t45, label %then6, label %merge7
then6:
  %t52 = load %Parser, %Parser* %l0
  %t53 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t54 = insertvalue %BlockStatementParseResult %t53, i8* null, 1
  %t55 = insertvalue %BlockStatementParseResult %t54, i1 0, 2
  ret %BlockStatementParseResult %t55
merge7:
  %t56 = load %Parser, %Parser* %l4
  %t57 = call %BlockStatementParseResult @parse_break_statement(%Parser %t56)
  ret %BlockStatementParseResult %t57
merge5:
  %t58 = load %Token, %Token* %l5
  %s59 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.59, i32 0, i32 0
  %t60 = call i1 @identifier_matches(%Token %t58, i8* %s59)
  %t61 = load %Parser, %Parser* %l0
  %t62 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t63 = load i8*, i8** %l2
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t65 = load %Parser, %Parser* %l4
  %t66 = load %Token, %Token* %l5
  br i1 %t60, label %then8, label %merge9
then8:
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t68 = load { i8**, i64 }, { i8**, i64 }* %t67
  %t69 = extractvalue { i8**, i64 } %t68, 1
  %t70 = icmp sgt i64 %t69, 0
  %t71 = load %Parser, %Parser* %l0
  %t72 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t73 = load i8*, i8** %l2
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t75 = load %Parser, %Parser* %l4
  %t76 = load %Token, %Token* %l5
  br i1 %t70, label %then10, label %merge11
then10:
  %t77 = load %Parser, %Parser* %l0
  %t78 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t79 = insertvalue %BlockStatementParseResult %t78, i8* null, 1
  %t80 = insertvalue %BlockStatementParseResult %t79, i1 0, 2
  ret %BlockStatementParseResult %t80
merge11:
  %t81 = load %Parser, %Parser* %l4
  %t82 = call %BlockStatementParseResult @parse_continue_statement(%Parser %t81)
  ret %BlockStatementParseResult %t82
merge9:
  %t83 = load %Token, %Token* %l5
  %s84 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.84, i32 0, i32 0
  %t85 = call i1 @identifier_matches(%Token %t83, i8* %s84)
  %t86 = load %Parser, %Parser* %l0
  %t87 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t88 = load i8*, i8** %l2
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t90 = load %Parser, %Parser* %l4
  %t91 = load %Token, %Token* %l5
  br i1 %t85, label %then12, label %merge13
then12:
  %t92 = load %Parser, %Parser* %l4
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t94 = call %BlockStatementParseResult @parse_if_statement(%Parser %t92, { %Decorator*, i64 }* null)
  ret %BlockStatementParseResult %t94
merge13:
  %t95 = load %Token, %Token* %l5
  %s96 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.96, i32 0, i32 0
  %t97 = call i1 @identifier_matches(%Token %t95, i8* %s96)
  %t98 = load %Parser, %Parser* %l0
  %t99 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t100 = load i8*, i8** %l2
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t102 = load %Parser, %Parser* %l4
  %t103 = load %Token, %Token* %l5
  br i1 %t97, label %then14, label %merge15
then14:
  %t104 = load %Parser, %Parser* %l4
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t106 = call %BlockStatementParseResult @parse_match_statement(%Parser %t104, { %Decorator*, i64 }* null)
  ret %BlockStatementParseResult %t106
merge15:
  %t107 = load %Token, %Token* %l5
  %s108 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.108, i32 0, i32 0
  %t109 = call i1 @identifier_matches(%Token %t107, i8* %s108)
  %t110 = load %Parser, %Parser* %l0
  %t111 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t112 = load i8*, i8** %l2
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t114 = load %Parser, %Parser* %l4
  %t115 = load %Token, %Token* %l5
  br i1 %t109, label %then16, label %merge17
then16:
  %t116 = load %Parser, %Parser* %l4
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t118 = call %BlockStatementParseResult @parse_prompt_statement(%Parser %t116, { %Decorator*, i64 }* null)
  ret %BlockStatementParseResult %t118
merge17:
  %t119 = load %Token, %Token* %l5
  %s120 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.120, i32 0, i32 0
  %t121 = call i1 @identifier_matches(%Token %t119, i8* %s120)
  %t122 = load %Parser, %Parser* %l0
  %t123 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t124 = load i8*, i8** %l2
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t126 = load %Parser, %Parser* %l4
  %t127 = load %Token, %Token* %l5
  br i1 %t121, label %then18, label %merge19
then18:
  %t128 = load %Parser, %Parser* %l4
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t130 = call %BlockStatementParseResult @parse_with_statement(%Parser %t128, { %Decorator*, i64 }* null)
  ret %BlockStatementParseResult %t130
merge19:
  %t131 = load %Token, %Token* %l5
  %s132 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.132, i32 0, i32 0
  %t133 = call i1 @identifier_matches(%Token %t131, i8* %s132)
  %t134 = load %Parser, %Parser* %l0
  %t135 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t136 = load i8*, i8** %l2
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t138 = load %Parser, %Parser* %l4
  %t139 = load %Token, %Token* %l5
  br i1 %t133, label %then20, label %merge21
then20:
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t141 = load { i8**, i64 }, { i8**, i64 }* %t140
  %t142 = extractvalue { i8**, i64 } %t141, 1
  %t143 = icmp sgt i64 %t142, 0
  %t144 = load %Parser, %Parser* %l0
  %t145 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t146 = load i8*, i8** %l2
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t148 = load %Parser, %Parser* %l4
  %t149 = load %Token, %Token* %l5
  br i1 %t143, label %then22, label %merge23
then22:
  %t150 = load %Parser, %Parser* %l0
  %t151 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t152 = insertvalue %BlockStatementParseResult %t151, i8* null, 1
  %t153 = insertvalue %BlockStatementParseResult %t152, i1 0, 2
  ret %BlockStatementParseResult %t153
merge23:
  %t154 = load %Parser, %Parser* %l4
  %t155 = call %BlockStatementParseResult @parse_return_statement(%Parser %t154)
  ret %BlockStatementParseResult %t155
merge21:
  %t156 = load %Parser, %Parser* %l4
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t158 = call %BlockStatementParseResult @parse_expression_statement(%Parser %t156, { %Decorator*, i64 }* null)
  store %BlockStatementParseResult %t158, %BlockStatementParseResult* %l6
  %t159 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t160 = extractvalue %BlockStatementParseResult %t159, 2
  %t161 = load %Parser, %Parser* %l0
  %t162 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t163 = load i8*, i8** %l2
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t165 = load %Parser, %Parser* %l4
  %t166 = load %Token, %Token* %l5
  %t167 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  br i1 %t160, label %then24, label %merge25
then24:
  %t168 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  ret %BlockStatementParseResult %t168
merge25:
  %t169 = load %Parser, %Parser* %l0
  %t170 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t171 = insertvalue %BlockStatementParseResult %t170, i8* null, 1
  %t172 = insertvalue %BlockStatementParseResult %t171, i1 0, 2
  ret %BlockStatementParseResult %t172
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
  %l9 = alloca double
  %l10 = alloca %BlockParseResult
  %l11 = alloca i8*
  %l12 = alloca %Token
  %l13 = alloca double
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
  %t23 = call %CaptureResult @collect_until(%Parser %t16, { i8**, i64 }* null)
  store %CaptureResult %t23, %CaptureResult* %l2
  %t24 = load %CaptureResult, %CaptureResult* %l2
  %t25 = extractvalue %CaptureResult %t24, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t26 = load %CaptureResult, %CaptureResult* %l2
  %t27 = extractvalue %CaptureResult %t26, 1
  %t28 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* null)
  store { %Token*, i64 }* %t28, { %Token*, i64 }** %l3
  %t29 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t30 = load { %Token*, i64 }, { %Token*, i64 }* %t29
  %t31 = extractvalue { %Token*, i64 } %t30, 1
  %t32 = icmp eq i64 %t31, 0
  %t33 = load %Parser, %Parser* %l0
  %t34 = load %Parser, %Parser* %l1
  %t35 = load %CaptureResult, %CaptureResult* %l2
  %t36 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  br i1 %t32, label %then2, label %merge3
then2:
  %t37 = load %Parser, %Parser* %l0
  %t38 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t39 = insertvalue %BlockStatementParseResult %t38, i8* null, 1
  %t40 = insertvalue %BlockStatementParseResult %t39, i1 0, 2
  ret %BlockStatementParseResult %t40
merge3:
  %t41 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %s42 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.42, i32 0, i32 0
  %t43 = call double @find_top_level_identifier({ %Token*, i64 }* %t41, i8* %s42)
  store double %t43, double* %l4
  %t44 = load double, double* %l4
  %t45 = sitofp i64 -1 to double
  %t46 = fcmp oeq double %t44, %t45
  %t47 = load %Parser, %Parser* %l0
  %t48 = load %Parser, %Parser* %l1
  %t49 = load %CaptureResult, %CaptureResult* %l2
  %t50 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t51 = load double, double* %l4
  br i1 %t46, label %then4, label %merge5
then4:
  %t52 = load %Parser, %Parser* %l0
  %t53 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t54 = insertvalue %BlockStatementParseResult %t53, i8* null, 1
  %t55 = insertvalue %BlockStatementParseResult %t54, i1 0, 2
  ret %BlockStatementParseResult %t55
merge5:
  %t56 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t57 = load double, double* %l4
  %t58 = sitofp i64 0 to double
  %t59 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t56, double %t58, double %t57)
  %t60 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t59)
  store { %Token*, i64 }* %t60, { %Token*, i64 }** %l5
  %t61 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t62 = load double, double* %l4
  %t63 = sitofp i64 1 to double
  %t64 = fadd double %t62, %t63
  %t65 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t66 = load { %Token*, i64 }, { %Token*, i64 }* %t65
  %t67 = extractvalue { %Token*, i64 } %t66, 1
  %t68 = sitofp i64 %t67 to double
  %t69 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t61, double %t64, double %t68)
  %t70 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t69)
  store { %Token*, i64 }* %t70, { %Token*, i64 }** %l6
  %t72 = load { %Token*, i64 }*, { %Token*, i64 }** %l5
  %t73 = load { %Token*, i64 }, { %Token*, i64 }* %t72
  %t74 = extractvalue { %Token*, i64 } %t73, 1
  %t75 = icmp eq i64 %t74, 0
  br label %logical_or_entry_71

logical_or_entry_71:
  br i1 %t75, label %logical_or_merge_71, label %logical_or_right_71

logical_or_right_71:
  %t76 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  %t77 = load { %Token*, i64 }, { %Token*, i64 }* %t76
  %t78 = extractvalue { %Token*, i64 } %t77, 1
  %t79 = icmp eq i64 %t78, 0
  br label %logical_or_right_end_71

logical_or_right_end_71:
  br label %logical_or_merge_71

logical_or_merge_71:
  %t80 = phi i1 [ true, %logical_or_entry_71 ], [ %t79, %logical_or_right_end_71 ]
  %t81 = load %Parser, %Parser* %l0
  %t82 = load %Parser, %Parser* %l1
  %t83 = load %CaptureResult, %CaptureResult* %l2
  %t84 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t85 = load double, double* %l4
  %t86 = load { %Token*, i64 }*, { %Token*, i64 }** %l5
  %t87 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  br i1 %t80, label %then6, label %merge7
then6:
  %t88 = load %Parser, %Parser* %l0
  %t89 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t90 = insertvalue %BlockStatementParseResult %t89, i8* null, 1
  %t91 = insertvalue %BlockStatementParseResult %t90, i1 0, 2
  ret %BlockStatementParseResult %t91
merge7:
  %t92 = load { %Token*, i64 }*, { %Token*, i64 }** %l5
  %t93 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t92)
  store %Expression %t93, %Expression* %l7
  %t94 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  %t95 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t94)
  store %Expression %t95, %Expression* %l8
  store double 0.0, double* %l9
  %t96 = load %Parser, %Parser* %l1
  %t97 = call %BlockParseResult @parse_block(%Parser %t96)
  store %BlockParseResult %t97, %BlockParseResult* %l10
  %t98 = load %BlockParseResult, %BlockParseResult* %l10
  %t99 = extractvalue %BlockParseResult %t98, 1
  %t100 = load %BlockParseResult, %BlockParseResult* %l10
  %t101 = extractvalue %BlockParseResult %t100, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t102 = load %BlockParseResult, %BlockParseResult* %l10
  %t103 = extractvalue %BlockParseResult %t102, 1
  store i8* %t103, i8** %l11
  %t104 = load %Parser, %Parser* %l1
  %t105 = call %Parser @skip_trivia(%Parser %t104)
  store %Parser %t105, %Parser* %l1
  %t106 = load %Parser, %Parser* %l1
  %t107 = call %Token @parser_peek_raw(%Parser %t106)
  store %Token %t107, %Token* %l12
  %t109 = load %Token, %Token* %l12
  %t110 = extractvalue %Token %t109, 0
  store double 0.0, double* %l13
  %t111 = load %Parser, %Parser* %l1
  %t112 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t113 = load double, double* %l13
  %t114 = insertvalue %BlockStatementParseResult %t112, i8* null, 1
  %t115 = insertvalue %BlockStatementParseResult %t114, i1 1, 2
  ret %BlockStatementParseResult %t115
}

define %BlockStatementParseResult @parse_loop_statement(%Parser %parser, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %BlockParseResult
  %l3 = alloca %Token
  %l4 = alloca double
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
  store double 0.0, double* %l4
  %t28 = load %Parser, %Parser* %l1
  %t29 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t30 = load double, double* %l4
  %t31 = insertvalue %BlockStatementParseResult %t29, i8* null, 1
  %t32 = insertvalue %BlockStatementParseResult %t31, i1 1, 2
  ret %BlockStatementParseResult %t32
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
  %t24 = call double @StatementBreakStatement()
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
  %t24 = call double @StatementContinueStatement()
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
  %l12 = alloca double
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
  %t23 = call %CaptureResult @collect_until(%Parser %t16, { i8**, i64 }* null)
  store %CaptureResult %t23, %CaptureResult* %l2
  %t24 = load %CaptureResult, %CaptureResult* %l2
  %t25 = extractvalue %CaptureResult %t24, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t26 = load %CaptureResult, %CaptureResult* %l2
  %t27 = extractvalue %CaptureResult %t26, 1
  %t28 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* null)
  store { %Token*, i64 }* %t28, { %Token*, i64 }** %l3
  %t29 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t30 = load { %Token*, i64 }, { %Token*, i64 }* %t29
  %t31 = extractvalue { %Token*, i64 } %t30, 1
  %t32 = icmp eq i64 %t31, 0
  %t33 = load %Parser, %Parser* %l0
  %t34 = load %Parser, %Parser* %l1
  %t35 = load %CaptureResult, %CaptureResult* %l2
  %t36 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  br i1 %t32, label %then2, label %merge3
then2:
  %t37 = load %Parser, %Parser* %l0
  %t38 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t39 = insertvalue %BlockStatementParseResult %t38, i8* null, 1
  %t40 = insertvalue %BlockStatementParseResult %t39, i1 0, 2
  ret %BlockStatementParseResult %t40
merge3:
  %t41 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t42 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t41)
  store %Expression %t42, %Expression* %l4
  %t43 = load %Parser, %Parser* %l1
  %t44 = call %BlockParseResult @parse_block(%Parser %t43)
  store %BlockParseResult %t44, %BlockParseResult* %l5
  %t45 = load %BlockParseResult, %BlockParseResult* %l5
  %t46 = extractvalue %BlockParseResult %t45, 1
  %t47 = load %BlockParseResult, %BlockParseResult* %l5
  %t48 = extractvalue %BlockParseResult %t47, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t49 = load %BlockParseResult, %BlockParseResult* %l5
  %t50 = extractvalue %BlockParseResult %t49, 1
  store i8* %t50, i8** %l6
  %t51 = load %Parser, %Parser* %l1
  %t52 = call %Parser @skip_trivia(%Parser %t51)
  store %Parser %t52, %Parser* %l1
  store i8* null, i8** %l7
  %t53 = load %Parser, %Parser* %l1
  %t54 = call %Token @parser_peek_raw(%Parser %t53)
  %s55 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.55, i32 0, i32 0
  %t56 = call i1 @identifier_matches(%Token %t54, i8* %s55)
  %t57 = load %Parser, %Parser* %l0
  %t58 = load %Parser, %Parser* %l1
  %t59 = load %CaptureResult, %CaptureResult* %l2
  %t60 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t61 = load %Expression, %Expression* %l4
  %t62 = load %BlockParseResult, %BlockParseResult* %l5
  %t63 = load i8*, i8** %l6
  %t64 = load i8*, i8** %l7
  br i1 %t56, label %then4, label %merge5
then4:
  %t65 = load %Parser, %Parser* %l1
  %s66 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.66, i32 0, i32 0
  %t67 = call %Parser @consume_keyword(%Parser %t65, i8* %s66)
  store %Parser %t67, %Parser* %l1
  %t68 = load %Parser, %Parser* %l1
  %t69 = call %Parser @skip_trivia(%Parser %t68)
  store %Parser %t69, %Parser* %l1
  %t70 = load %Parser, %Parser* %l1
  %t71 = call %Token @parser_peek_raw(%Parser %t70)
  store %Token %t71, %Token* %l8
  %t72 = load %Token, %Token* %l8
  %s73 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.73, i32 0, i32 0
  %t74 = call i1 @identifier_matches(%Token %t72, i8* %s73)
  %t75 = load %Parser, %Parser* %l0
  %t76 = load %Parser, %Parser* %l1
  %t77 = load %CaptureResult, %CaptureResult* %l2
  %t78 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t79 = load %Expression, %Expression* %l4
  %t80 = load %BlockParseResult, %BlockParseResult* %l5
  %t81 = load i8*, i8** %l6
  %t82 = load i8*, i8** %l7
  %t83 = load %Token, %Token* %l8
  br i1 %t74, label %then6, label %else7
then6:
  %t84 = load %Parser, %Parser* %l1
  %t85 = alloca [0 x double]
  %t86 = getelementptr [0 x double], [0 x double]* %t85, i32 0, i32 0
  %t87 = alloca { double*, i64 }
  %t88 = getelementptr { double*, i64 }, { double*, i64 }* %t87, i32 0, i32 0
  store double* %t86, double** %t88
  %t89 = getelementptr { double*, i64 }, { double*, i64 }* %t87, i32 0, i32 1
  store i64 0, i64* %t89
  %t90 = call %BlockStatementParseResult @parse_if_statement(%Parser %t84, { %Decorator*, i64 }* null)
  store %BlockStatementParseResult %t90, %BlockStatementParseResult* %l9
  %t91 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  %t92 = extractvalue %BlockStatementParseResult %t91, 2
  %t93 = xor i1 %t92, 1
  %t94 = load %Parser, %Parser* %l0
  %t95 = load %Parser, %Parser* %l1
  %t96 = load %CaptureResult, %CaptureResult* %l2
  %t97 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t98 = load %Expression, %Expression* %l4
  %t99 = load %BlockParseResult, %BlockParseResult* %l5
  %t100 = load i8*, i8** %l6
  %t101 = load i8*, i8** %l7
  %t102 = load %Token, %Token* %l8
  %t103 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  br i1 %t93, label %then9, label %merge10
then9:
  %t104 = load %Parser, %Parser* %l0
  %t105 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t106 = insertvalue %BlockStatementParseResult %t105, i8* null, 1
  %t107 = insertvalue %BlockStatementParseResult %t106, i1 0, 2
  ret %BlockStatementParseResult %t107
merge10:
  %t108 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  %t109 = extractvalue %BlockStatementParseResult %t108, 1
  %t110 = icmp eq i8* %t109, null
  %t111 = load %Parser, %Parser* %l0
  %t112 = load %Parser, %Parser* %l1
  %t113 = load %CaptureResult, %CaptureResult* %l2
  %t114 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t115 = load %Expression, %Expression* %l4
  %t116 = load %BlockParseResult, %BlockParseResult* %l5
  %t117 = load i8*, i8** %l6
  %t118 = load i8*, i8** %l7
  %t119 = load %Token, %Token* %l8
  %t120 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  br i1 %t110, label %then11, label %merge12
then11:
  %t121 = load %Parser, %Parser* %l0
  %t122 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t123 = insertvalue %BlockStatementParseResult %t122, i8* null, 1
  %t124 = insertvalue %BlockStatementParseResult %t123, i1 0, 2
  ret %BlockStatementParseResult %t124
merge12:
  %t125 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  %t126 = extractvalue %BlockStatementParseResult %t125, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t127 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  %t128 = extractvalue %BlockStatementParseResult %t127, 1
  %t129 = insertvalue %ElseBranch undef, i8* %t128, 0
  %t130 = insertvalue %ElseBranch %t129, i8* null, 1
  store i8* null, i8** %l7
  br label %merge8
else7:
  %t131 = load %Parser, %Parser* %l1
  %t132 = call %BlockParseResult @parse_block(%Parser %t131)
  store %BlockParseResult %t132, %BlockParseResult* %l10
  %t133 = load %BlockParseResult, %BlockParseResult* %l10
  %t134 = extractvalue %BlockParseResult %t133, 1
  %t135 = load %BlockParseResult, %BlockParseResult* %l10
  %t136 = extractvalue %BlockParseResult %t135, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t137 = insertvalue %ElseBranch undef, i8* null, 0
  %t138 = load %BlockParseResult, %BlockParseResult* %l10
  %t139 = extractvalue %BlockParseResult %t138, 1
  %t140 = insertvalue %ElseBranch %t137, i8* %t139, 1
  store i8* null, i8** %l7
  br label %merge8
merge8:
  %t141 = phi %Parser [ zeroinitializer, %then6 ], [ zeroinitializer, %else7 ]
  %t142 = phi i8* [ null, %then6 ], [ null, %else7 ]
  store %Parser %t141, %Parser* %l1
  store i8* %t142, i8** %l7
  %t143 = load %Parser, %Parser* %l1
  %t144 = call %Parser @skip_trivia(%Parser %t143)
  store %Parser %t144, %Parser* %l1
  %t145 = load %Parser, %Parser* %l1
  %t146 = call %Token @parser_peek_raw(%Parser %t145)
  store %Token %t146, %Token* %l11
  %t148 = load %Token, %Token* %l11
  %t149 = extractvalue %Token %t148, 0
  br label %merge5
merge5:
  %t150 = phi %Parser [ %t67, %then4 ], [ %t58, %entry ]
  %t151 = phi %Parser [ %t69, %then4 ], [ %t58, %entry ]
  %t152 = phi %Parser [ zeroinitializer, %then4 ], [ %t58, %entry ]
  %t153 = phi i8* [ null, %then4 ], [ %t64, %entry ]
  %t154 = phi %Parser [ zeroinitializer, %then4 ], [ %t58, %entry ]
  %t155 = phi i8* [ null, %then4 ], [ %t64, %entry ]
  %t156 = phi %Parser [ %t144, %then4 ], [ %t58, %entry ]
  store %Parser %t150, %Parser* %l1
  store %Parser %t151, %Parser* %l1
  store %Parser %t152, %Parser* %l1
  store i8* %t153, i8** %l7
  store %Parser %t154, %Parser* %l1
  store i8* %t155, i8** %l7
  store %Parser %t156, %Parser* %l1
  store double 0.0, double* %l12
  %t157 = load %Parser, %Parser* %l1
  %t158 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t159 = load double, double* %l12
  %t160 = insertvalue %BlockStatementParseResult %t158, i8* null, 1
  %t161 = insertvalue %BlockStatementParseResult %t160, i1 1, 2
  ret %BlockStatementParseResult %t161
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
  %l7 = alloca double
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
  %t23 = call %CaptureResult @collect_until(%Parser %t16, { i8**, i64 }* null)
  store %CaptureResult %t23, %CaptureResult* %l2
  %t24 = load %CaptureResult, %CaptureResult* %l2
  %t25 = extractvalue %CaptureResult %t24, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t26 = load %CaptureResult, %CaptureResult* %l2
  %t27 = extractvalue %CaptureResult %t26, 1
  %t28 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* null)
  store { %Token*, i64 }* %t28, { %Token*, i64 }** %l3
  %t29 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t30 = load { %Token*, i64 }, { %Token*, i64 }* %t29
  %t31 = extractvalue { %Token*, i64 } %t30, 1
  %t32 = icmp eq i64 %t31, 0
  %t33 = load %Parser, %Parser* %l0
  %t34 = load %Parser, %Parser* %l1
  %t35 = load %CaptureResult, %CaptureResult* %l2
  %t36 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  br i1 %t32, label %then2, label %merge3
then2:
  %t37 = load %Parser, %Parser* %l0
  %t38 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t39 = insertvalue %BlockStatementParseResult %t38, i8* null, 1
  %t40 = insertvalue %BlockStatementParseResult %t39, i1 0, 2
  ret %BlockStatementParseResult %t40
merge3:
  %t41 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t42 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t41)
  store %Expression %t42, %Expression* %l4
  %t43 = load %Parser, %Parser* %l1
  %t44 = call %MatchCasesParseResult @parse_match_cases(%Parser %t43)
  store %MatchCasesParseResult %t44, %MatchCasesParseResult* %l5
  %t45 = load %MatchCasesParseResult, %MatchCasesParseResult* %l5
  %t46 = extractvalue %MatchCasesParseResult %t45, 2
  %t47 = xor i1 %t46, 1
  %t48 = load %Parser, %Parser* %l0
  %t49 = load %Parser, %Parser* %l1
  %t50 = load %CaptureResult, %CaptureResult* %l2
  %t51 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t52 = load %Expression, %Expression* %l4
  %t53 = load %MatchCasesParseResult, %MatchCasesParseResult* %l5
  br i1 %t47, label %then4, label %merge5
then4:
  %t54 = load %Parser, %Parser* %l0
  %t55 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t56 = insertvalue %BlockStatementParseResult %t55, i8* null, 1
  %t57 = insertvalue %BlockStatementParseResult %t56, i1 0, 2
  ret %BlockStatementParseResult %t57
merge5:
  %t58 = load %MatchCasesParseResult, %MatchCasesParseResult* %l5
  %t59 = extractvalue %MatchCasesParseResult %t58, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t60 = load %Parser, %Parser* %l1
  %t61 = call %Parser @skip_trivia(%Parser %t60)
  store %Parser %t61, %Parser* %l1
  %t62 = load %Parser, %Parser* %l1
  %t63 = extractvalue %Parser %t62, 1
  %t64 = load %Parser, %Parser* %l1
  %t65 = extractvalue %Parser %t64, 0
  %t66 = load { i8**, i64 }, { i8**, i64 }* %t65
  %t67 = extractvalue { i8**, i64 } %t66, 1
  %t68 = sitofp i64 %t67 to double
  %t69 = fcmp olt double %t63, %t68
  %t70 = load %Parser, %Parser* %l0
  %t71 = load %Parser, %Parser* %l1
  %t72 = load %CaptureResult, %CaptureResult* %l2
  %t73 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t74 = load %Expression, %Expression* %l4
  %t75 = load %MatchCasesParseResult, %MatchCasesParseResult* %l5
  br i1 %t69, label %then6, label %merge7
then6:
  %t76 = load %Parser, %Parser* %l1
  %t77 = call %Token @parser_peek_raw(%Parser %t76)
  store %Token %t77, %Token* %l6
  %t79 = load %Token, %Token* %l6
  %t80 = extractvalue %Token %t79, 0
  br label %merge7
merge7:
  store double 0.0, double* %l7
  %t81 = load %Parser, %Parser* %l1
  %t82 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t83 = load double, double* %l7
  %t84 = insertvalue %BlockStatementParseResult %t82, i8* null, 1
  %t85 = insertvalue %BlockStatementParseResult %t84, i1 1, 2
  ret %BlockStatementParseResult %t85
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
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { %MatchCase*, i64 }* null, { %MatchCase*, i64 }** %l2
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
  %t43 = alloca [0 x double]
  %t44 = getelementptr [0 x double], [0 x double]* %t43, i32 0, i32 0
  %t45 = alloca { double*, i64 }
  %t46 = getelementptr { double*, i64 }, { double*, i64 }* %t45, i32 0, i32 0
  store double* %t44, double** %t46
  %t47 = getelementptr { double*, i64 }, { double*, i64 }* %t45, i32 0, i32 1
  store i64 0, i64* %t47
  %t48 = insertvalue %MatchCasesParseResult %t42, { i8**, i64 }* null, 1
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
  %t70 = insertvalue %MatchCasesParseResult %t68, { i8**, i64 }* null, 1
  %t71 = insertvalue %MatchCasesParseResult %t70, i1 1, 2
  ret %MatchCasesParseResult %t71
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
  %l8 = alloca double
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
  %t30 = call %MatchCaseTokenSplit @split_match_case_tokens({ %Token*, i64 }* null)
  store %MatchCaseTokenSplit %t30, %MatchCaseTokenSplit* %l3
  %t31 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t32 = extractvalue %MatchCaseTokenSplit %t31, 0
  %t33 = load { i8**, i64 }, { i8**, i64 }* %t32
  %t34 = extractvalue { i8**, i64 } %t33, 1
  %t35 = icmp eq i64 %t34, 0
  %t36 = load %Parser, %Parser* %l0
  %t37 = load %Parser, %Parser* %l1
  %t38 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t39 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  br i1 %t35, label %then4, label %merge5
then4:
  %t40 = load %Parser, %Parser* %l0
  %t41 = insertvalue %MatchCaseParseResult undef, i8* null, 0
  %t42 = insertvalue %MatchCaseParseResult %t41, i8* null, 1
  %t43 = insertvalue %MatchCaseParseResult %t42, i1 0, 2
  ret %MatchCaseParseResult %t43
merge5:
  %t44 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t45 = extractvalue %MatchCaseTokenSplit %t44, 0
  %t46 = call %Expression @expression_from_tokens({ %Token*, i64 }* null)
  store %Expression %t46, %Expression* %l4
  store i8* null, i8** %l5
  %t47 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t48 = extractvalue %MatchCaseTokenSplit %t47, 2
  %t49 = load %Parser, %Parser* %l0
  %t50 = load %Parser, %Parser* %l1
  %t51 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t52 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t53 = load %Expression, %Expression* %l4
  %t54 = load i8*, i8** %l5
  br i1 %t48, label %then6, label %merge7
then6:
  %t55 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t56 = extractvalue %MatchCaseTokenSplit %t55, 1
  %t57 = load { i8**, i64 }, { i8**, i64 }* %t56
  %t58 = extractvalue { i8**, i64 } %t57, 1
  %t59 = icmp eq i64 %t58, 0
  %t60 = load %Parser, %Parser* %l0
  %t61 = load %Parser, %Parser* %l1
  %t62 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t63 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t64 = load %Expression, %Expression* %l4
  %t65 = load i8*, i8** %l5
  br i1 %t59, label %then8, label %merge9
then8:
  %t66 = load %Parser, %Parser* %l0
  %t67 = insertvalue %MatchCaseParseResult undef, i8* null, 0
  %t68 = insertvalue %MatchCaseParseResult %t67, i8* null, 1
  %t69 = insertvalue %MatchCaseParseResult %t68, i1 0, 2
  ret %MatchCaseParseResult %t69
merge9:
  %t70 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t71 = extractvalue %MatchCaseTokenSplit %t70, 1
  %t72 = call %Expression @expression_from_tokens({ %Token*, i64 }* null)
  store i8* null, i8** %l5
  br label %merge7
merge7:
  %t73 = phi i8* [ null, %then6 ], [ %t54, %entry ]
  store i8* %t73, i8** %l5
  %t74 = load %Parser, %Parser* %l1
  %t75 = call %Parser @skip_trivia(%Parser %t74)
  store %Parser %t75, %Parser* %l1
  %t76 = load %Parser, %Parser* %l1
  %t77 = call %Token @parser_peek_raw(%Parser %t76)
  store %Token %t77, %Token* %l6
  store i8* null, i8** %l7
  %t79 = load %Token, %Token* %l6
  %t80 = extractvalue %Token %t79, 0
  %t81 = load i8*, i8** %l7
  %t82 = icmp eq i8* %t81, null
  %t83 = load %Parser, %Parser* %l0
  %t84 = load %Parser, %Parser* %l1
  %t85 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t86 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t87 = load %Expression, %Expression* %l4
  %t88 = load i8*, i8** %l5
  %t89 = load %Token, %Token* %l6
  %t90 = load i8*, i8** %l7
  br i1 %t82, label %then10, label %merge11
then10:
  %t91 = load %Parser, %Parser* %l0
  %t92 = insertvalue %MatchCaseParseResult undef, i8* null, 0
  %t93 = insertvalue %MatchCaseParseResult %t92, i8* null, 1
  %t94 = insertvalue %MatchCaseParseResult %t93, i1 0, 2
  ret %MatchCaseParseResult %t94
merge11:
  store double 0.0, double* %l8
  %t95 = load %Parser, %Parser* %l1
  %t96 = insertvalue %MatchCaseParseResult undef, i8* null, 0
  %t97 = load double, double* %l8
  %t98 = insertvalue %MatchCaseParseResult %t96, i8* null, 1
  %t99 = insertvalue %MatchCaseParseResult %t98, i1 1, 2
  ret %MatchCaseParseResult %t99
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
  %l7 = alloca double
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
  store double 0.0, double* %l7
  %t38 = load %Parser, %Parser* %l1
  %t39 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t40 = load double, double* %l7
  %t41 = insertvalue %BlockStatementParseResult %t39, i8* null, 1
  %t42 = insertvalue %BlockStatementParseResult %t41, i1 1, 2
  ret %BlockStatementParseResult %t42
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
  %l10 = alloca double
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
  %t23 = call %CaptureResult @collect_until(%Parser %t16, { i8**, i64 }* null)
  store %CaptureResult %t23, %CaptureResult* %l2
  %t24 = load %CaptureResult, %CaptureResult* %l2
  %t25 = extractvalue %CaptureResult %t24, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t26 = load %CaptureResult, %CaptureResult* %l2
  %t27 = extractvalue %CaptureResult %t26, 1
  %t28 = call { i8**, i64 }* @split_token_slices_by_comma({ %Token*, i64 }* null)
  store { i8**, i64 }* %t28, { i8**, i64 }** %l3
  %t29 = alloca [0 x double]
  %t30 = getelementptr [0 x double], [0 x double]* %t29, i32 0, i32 0
  %t31 = alloca { double*, i64 }
  %t32 = getelementptr { double*, i64 }, { double*, i64 }* %t31, i32 0, i32 0
  store double* %t30, double** %t32
  %t33 = getelementptr { double*, i64 }, { double*, i64 }* %t31, i32 0, i32 1
  store i64 0, i64* %t33
  store { %WithClause*, i64 }* null, { %WithClause*, i64 }** %l4
  %t34 = sitofp i64 0 to double
  store double %t34, double* %l5
  %t35 = load %Parser, %Parser* %l0
  %t36 = load %Parser, %Parser* %l1
  %t37 = load %CaptureResult, %CaptureResult* %l2
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t39 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %l4
  %t40 = load double, double* %l5
  br label %loop.header2
loop.header2:
  %t85 = phi { %WithClause*, i64 }* [ %t39, %entry ], [ %t83, %loop.latch4 ]
  %t86 = phi double [ %t40, %entry ], [ %t84, %loop.latch4 ]
  store { %WithClause*, i64 }* %t85, { %WithClause*, i64 }** %l4
  store double %t86, double* %l5
  br label %loop.body3
loop.body3:
  %t41 = load double, double* %l5
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t43 = load { i8**, i64 }, { i8**, i64 }* %t42
  %t44 = extractvalue { i8**, i64 } %t43, 1
  %t45 = sitofp i64 %t44 to double
  %t46 = fcmp oge double %t41, %t45
  %t47 = load %Parser, %Parser* %l0
  %t48 = load %Parser, %Parser* %l1
  %t49 = load %CaptureResult, %CaptureResult* %l2
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t51 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %l4
  %t52 = load double, double* %l5
  br i1 %t46, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t54 = load double, double* %l5
  %t55 = load { i8**, i64 }, { i8**, i64 }* %t53
  %t56 = extractvalue { i8**, i64 } %t55, 0
  %t57 = extractvalue { i8**, i64 } %t55, 1
  %t58 = icmp uge i64 %t54, %t57
  ; bounds check: %t58 (if true, out of bounds)
  %t59 = getelementptr i8*, i8** %t56, i64 %t54
  %t60 = load i8*, i8** %t59
  %t61 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* null)
  store { %Token*, i64 }* %t61, { %Token*, i64 }** %l6
  %t62 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  %t63 = load { %Token*, i64 }, { %Token*, i64 }* %t62
  %t64 = extractvalue { %Token*, i64 } %t63, 1
  %t65 = icmp sgt i64 %t64, 0
  %t66 = load %Parser, %Parser* %l0
  %t67 = load %Parser, %Parser* %l1
  %t68 = load %CaptureResult, %CaptureResult* %l2
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t70 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %l4
  %t71 = load double, double* %l5
  %t72 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  br i1 %t65, label %then8, label %merge9
then8:
  %t73 = load { %Token*, i64 }*, { %Token*, i64 }** %l6
  %t74 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t73)
  store %Expression %t74, %Expression* %l7
  %t75 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %l4
  %t76 = load %Expression, %Expression* %l7
  %t77 = insertvalue %WithClause undef, i8* null, 0
  %t78 = call { %WithClause*, i64 }* @append_with_clause({ %WithClause*, i64 }* %t75, %WithClause %t77)
  store { %WithClause*, i64 }* %t78, { %WithClause*, i64 }** %l4
  br label %merge9
merge9:
  %t79 = phi { %WithClause*, i64 }* [ %t78, %then8 ], [ %t70, %loop.body3 ]
  store { %WithClause*, i64 }* %t79, { %WithClause*, i64 }** %l4
  %t80 = load double, double* %l5
  %t81 = sitofp i64 1 to double
  %t82 = fadd double %t80, %t81
  store double %t82, double* %l5
  br label %loop.latch4
loop.latch4:
  %t83 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %l4
  %t84 = load double, double* %l5
  br label %loop.header2
afterloop5:
  %t87 = load %Parser, %Parser* %l1
  %t88 = call %BlockParseResult @parse_block(%Parser %t87)
  store %BlockParseResult %t88, %BlockParseResult* %l8
  %t89 = load %BlockParseResult, %BlockParseResult* %l8
  %t90 = extractvalue %BlockParseResult %t89, 1
  %t91 = load %BlockParseResult, %BlockParseResult* %l8
  %t92 = extractvalue %BlockParseResult %t91, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t93 = load %BlockParseResult, %BlockParseResult* %l8
  %t94 = extractvalue %BlockParseResult %t93, 1
  store i8* %t94, i8** %l9
  %t95 = load %Parser, %Parser* %l1
  %t96 = call %Parser @skip_trivia(%Parser %t95)
  store %Parser %t96, %Parser* %l1
  %t98 = load %Parser, %Parser* %l1
  %t99 = call %Token @parser_peek_raw(%Parser %t98)
  %t100 = extractvalue %Token %t99, 0
  store double 0.0, double* %l10
  %t101 = load %Parser, %Parser* %l1
  %t102 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t103 = load double, double* %l10
  %t104 = insertvalue %BlockStatementParseResult %t102, i8* null, 1
  %t105 = insertvalue %BlockStatementParseResult %t104, i1 1, 2
  ret %BlockStatementParseResult %t105
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
  %t12 = alloca [0 x double]
  %t13 = getelementptr [0 x double], [0 x double]* %t12, i32 0, i32 0
  %t14 = alloca { double*, i64 }
  %t15 = getelementptr { double*, i64 }, { double*, i64 }* %t14, i32 0, i32 0
  store double* %t13, double** %t15
  %t16 = getelementptr { double*, i64 }, { double*, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  store { %Token*, i64 }* null, { %Token*, i64 }** %l2
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
  %t33 = call %CaptureResult @collect_until(%Parser %t25, { i8**, i64 }* null)
  store %CaptureResult %t33, %CaptureResult* %l3
  %t34 = load %CaptureResult, %CaptureResult* %l3
  %t35 = extractvalue %CaptureResult %t34, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t36 = load %CaptureResult, %CaptureResult* %l3
  %t37 = extractvalue %CaptureResult %t36, 1
  %t38 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* null)
  store { %Token*, i64 }* %t38, { %Token*, i64 }** %l4
  store i8* null, i8** %l5
  %t39 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t40 = load { %Token*, i64 }, { %Token*, i64 }* %t39
  %t41 = extractvalue { %Token*, i64 } %t40, 1
  %t42 = icmp sgt i64 %t41, 0
  %t43 = load %Parser, %Parser* %l0
  %t44 = load %Parser, %Parser* %l1
  %t45 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t46 = load %CaptureResult, %CaptureResult* %l3
  %t47 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t48 = load i8*, i8** %l5
  br i1 %t42, label %then2, label %merge3
then2:
  %t49 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t50 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t49)
  store i8* null, i8** %l5
  br label %merge3
merge3:
  %t51 = phi i8* [ null, %then2 ], [ %t48, %entry ]
  store i8* %t51, i8** %l5
  %t52 = sitofp i64 0 to double
  store double %t52, double* %l6
  %t53 = load %Parser, %Parser* %l0
  %t54 = load %Parser, %Parser* %l1
  %t55 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t56 = load %CaptureResult, %CaptureResult* %l3
  %t57 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t58 = load i8*, i8** %l5
  %t59 = load double, double* %l6
  br label %loop.header4
loop.header4:
  %t90 = phi { %Token*, i64 }* [ %t55, %entry ], [ %t88, %loop.latch6 ]
  %t91 = phi double [ %t59, %entry ], [ %t89, %loop.latch6 ]
  store { %Token*, i64 }* %t90, { %Token*, i64 }** %l2
  store double %t91, double* %l6
  br label %loop.body5
loop.body5:
  %t60 = load double, double* %l6
  %t61 = load %CaptureResult, %CaptureResult* %l3
  %t62 = extractvalue %CaptureResult %t61, 1
  %t63 = load { i8**, i64 }, { i8**, i64 }* %t62
  %t64 = extractvalue { i8**, i64 } %t63, 1
  %t65 = sitofp i64 %t64 to double
  %t66 = fcmp oge double %t60, %t65
  %t67 = load %Parser, %Parser* %l0
  %t68 = load %Parser, %Parser* %l1
  %t69 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t70 = load %CaptureResult, %CaptureResult* %l3
  %t71 = load { %Token*, i64 }*, { %Token*, i64 }** %l4
  %t72 = load i8*, i8** %l5
  %t73 = load double, double* %l6
  br i1 %t66, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t74 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t75 = load %CaptureResult, %CaptureResult* %l3
  %t76 = extractvalue %CaptureResult %t75, 1
  %t77 = load double, double* %l6
  %t78 = load { i8**, i64 }, { i8**, i64 }* %t76
  %t79 = extractvalue { i8**, i64 } %t78, 0
  %t80 = extractvalue { i8**, i64 } %t78, 1
  %t81 = icmp uge i64 %t77, %t80
  ; bounds check: %t81 (if true, out of bounds)
  %t82 = getelementptr i8*, i8** %t79, i64 %t77
  %t83 = load i8*, i8** %t82
  %t84 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t74, %Token zeroinitializer)
  store { %Token*, i64 }* %t84, { %Token*, i64 }** %l2
  %t85 = load double, double* %l6
  %t86 = sitofp i64 1 to double
  %t87 = fadd double %t85, %t86
  store double %t87, double* %l6
  br label %loop.latch6
loop.latch6:
  %t88 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t89 = load double, double* %l6
  br label %loop.header4
afterloop7:
  %t92 = load %Parser, %Parser* %l1
  %t93 = call %Parser @skip_trivia(%Parser %t92)
  store %Parser %t93, %Parser* %l1
  %t94 = load %Parser, %Parser* %l1
  %t95 = call %Token @parser_peek_raw(%Parser %t94)
  store %Token %t95, %Token* %l7
  %t97 = load %Token, %Token* %l7
  %t98 = extractvalue %Token %t97, 0
  %t99 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t100 = call double @source_span_from_tokens({ %Token*, i64 }* %t99)
  store double %t100, double* %l8
  %t101 = alloca %Statement
  %t102 = getelementptr inbounds %Statement, %Statement* %t101, i32 0, i32 0
  store i32 20, i32* %t102
  %t103 = load i8*, i8** %l5
  %t104 = getelementptr inbounds %Statement, %Statement* %t101, i32 0, i32 1
  %t105 = bitcast [16 x i8]* %t104 to i8*
  %t106 = bitcast i8* %t105 to i8**
  store i8* %t103, i8** %t106
  %t107 = load double, double* %l8
  %t108 = call noalias i8* @malloc(i64 8)
  %t109 = bitcast i8* %t108 to double*
  store double %t107, double* %t109
  %t110 = getelementptr inbounds %Statement, %Statement* %t101, i32 0, i32 1
  %t111 = bitcast [16 x i8]* %t110 to i8*
  %t112 = getelementptr inbounds i8, i8* %t111, i64 8
  %t113 = bitcast i8* %t112 to i8**
  store i8* %t108, i8** %t113
  %t114 = load %Statement, %Statement* %t101
  store %Statement %t114, %Statement* %l9
  %t115 = load %Parser, %Parser* %l1
  %t116 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t117 = load %Statement, %Statement* %l9
  %t118 = insertvalue %BlockStatementParseResult %t116, i8* null, 1
  %t119 = insertvalue %BlockStatementParseResult %t118, i1 1, 2
  ret %BlockStatementParseResult %t119
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
  %t20 = call %CaptureResult @collect_until(%Parser %t13, { i8**, i64 }* null)
  store %CaptureResult %t20, %CaptureResult* %l2
  %t21 = load %CaptureResult, %CaptureResult* %l2
  %t22 = extractvalue %CaptureResult %t21, 1
  %t23 = load { i8**, i64 }, { i8**, i64 }* %t22
  %t24 = extractvalue { i8**, i64 } %t23, 1
  %t25 = icmp eq i64 %t24, 0
  %t26 = load %Parser, %Parser* %l0
  %t27 = load %Token, %Token* %l1
  %t28 = load %CaptureResult, %CaptureResult* %l2
  br i1 %t25, label %then2, label %merge3
then2:
  %t29 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t30 = insertvalue %BlockStatementParseResult %t29, i8* null, 1
  %t31 = insertvalue %BlockStatementParseResult %t30, i1 0, 2
  ret %BlockStatementParseResult %t31
merge3:
  %t32 = alloca [0 x double]
  %t33 = getelementptr [0 x double], [0 x double]* %t32, i32 0, i32 0
  %t34 = alloca { double*, i64 }
  %t35 = getelementptr { double*, i64 }, { double*, i64 }* %t34, i32 0, i32 0
  store double* %t33, double** %t35
  %t36 = getelementptr { double*, i64 }, { double*, i64 }* %t34, i32 0, i32 1
  store i64 0, i64* %t36
  store { %Token*, i64 }* null, { %Token*, i64 }** %l3
  %t37 = sitofp i64 0 to double
  store double %t37, double* %l4
  %t38 = load %Parser, %Parser* %l0
  %t39 = load %Token, %Token* %l1
  %t40 = load %CaptureResult, %CaptureResult* %l2
  %t41 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t42 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t71 = phi { %Token*, i64 }* [ %t41, %entry ], [ %t69, %loop.latch6 ]
  %t72 = phi double [ %t42, %entry ], [ %t70, %loop.latch6 ]
  store { %Token*, i64 }* %t71, { %Token*, i64 }** %l3
  store double %t72, double* %l4
  br label %loop.body5
loop.body5:
  %t43 = load double, double* %l4
  %t44 = load %CaptureResult, %CaptureResult* %l2
  %t45 = extractvalue %CaptureResult %t44, 1
  %t46 = load { i8**, i64 }, { i8**, i64 }* %t45
  %t47 = extractvalue { i8**, i64 } %t46, 1
  %t48 = sitofp i64 %t47 to double
  %t49 = fcmp oge double %t43, %t48
  %t50 = load %Parser, %Parser* %l0
  %t51 = load %Token, %Token* %l1
  %t52 = load %CaptureResult, %CaptureResult* %l2
  %t53 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t54 = load double, double* %l4
  br i1 %t49, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t55 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t56 = load %CaptureResult, %CaptureResult* %l2
  %t57 = extractvalue %CaptureResult %t56, 1
  %t58 = load double, double* %l4
  %t59 = load { i8**, i64 }, { i8**, i64 }* %t57
  %t60 = extractvalue { i8**, i64 } %t59, 0
  %t61 = extractvalue { i8**, i64 } %t59, 1
  %t62 = icmp uge i64 %t58, %t61
  ; bounds check: %t62 (if true, out of bounds)
  %t63 = getelementptr i8*, i8** %t60, i64 %t58
  %t64 = load i8*, i8** %t63
  %t65 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t55, %Token zeroinitializer)
  store { %Token*, i64 }* %t65, { %Token*, i64 }** %l3
  %t66 = load double, double* %l4
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %t66, %t67
  store double %t68, double* %l4
  br label %loop.latch6
loop.latch6:
  %t69 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t70 = load double, double* %l4
  br label %loop.header4
afterloop7:
  %t73 = load %CaptureResult, %CaptureResult* %l2
  %t74 = extractvalue %CaptureResult %t73, 1
  %t75 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* null)
  store { %Token*, i64 }* %t75, { %Token*, i64 }** %l5
  %t76 = load { %Token*, i64 }*, { %Token*, i64 }** %l5
  %t77 = load { %Token*, i64 }, { %Token*, i64 }* %t76
  %t78 = extractvalue { %Token*, i64 } %t77, 1
  %t79 = icmp eq i64 %t78, 0
  %t80 = load %Parser, %Parser* %l0
  %t81 = load %Token, %Token* %l1
  %t82 = load %CaptureResult, %CaptureResult* %l2
  %t83 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t84 = load double, double* %l4
  %t85 = load { %Token*, i64 }*, { %Token*, i64 }** %l5
  br i1 %t79, label %then10, label %merge11
then10:
  %t86 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t87 = insertvalue %BlockStatementParseResult %t86, i8* null, 1
  %t88 = insertvalue %BlockStatementParseResult %t87, i1 0, 2
  ret %BlockStatementParseResult %t88
merge11:
  %t89 = load %CaptureResult, %CaptureResult* %l2
  %t90 = extractvalue %CaptureResult %t89, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t91 = load %Parser, %Parser* %l0
  %t92 = call %Parser @skip_trivia(%Parser %t91)
  store %Parser %t92, %Parser* %l0
  %t93 = load %Parser, %Parser* %l0
  %t94 = call %Token @parser_peek_raw(%Parser %t93)
  store %Token %t94, %Token* %l6
  %t96 = load %Token, %Token* %l6
  %t97 = extractvalue %Token %t96, 0
  %t98 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t99 = load %Token, %Token* %l6
  %t100 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t98, %Token %t99)
  store { %Token*, i64 }* %t100, { %Token*, i64 }** %l3
  %t101 = load %Parser, %Parser* %l0
  %t102 = call %Parser @parser_advance_raw(%Parser %t101)
  store %Parser %t102, %Parser* %l0
  %t103 = load { %Token*, i64 }*, { %Token*, i64 }** %l5
  %t104 = call %Expression @expression_from_tokens({ %Token*, i64 }* %t103)
  store %Expression %t104, %Expression* %l7
  %t105 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t106 = call double @source_span_from_tokens({ %Token*, i64 }* %t105)
  store double %t106, double* %l8
  %t107 = alloca %Statement
  %t108 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 0
  store i32 21, i32* %t108
  %t109 = load %Expression, %Expression* %l7
  %t110 = call noalias i8* @malloc(i64 32)
  %t111 = bitcast i8* %t110 to %Expression*
  store %Expression %t109, %Expression* %t111
  %t112 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t113 = bitcast [16 x i8]* %t112 to i8*
  %t114 = bitcast i8* %t113 to i8**
  store i8* %t110, i8** %t114
  %t115 = load double, double* %l8
  %t116 = call noalias i8* @malloc(i64 8)
  %t117 = bitcast i8* %t116 to double*
  store double %t115, double* %t117
  %t118 = getelementptr inbounds %Statement, %Statement* %t107, i32 0, i32 1
  %t119 = bitcast [16 x i8]* %t118 to i8*
  %t120 = getelementptr inbounds i8, i8* %t119, i64 8
  %t121 = bitcast i8* %t120 to i8**
  store i8* %t116, i8** %t121
  %t122 = load %Statement, %Statement* %t107
  store %Statement %t122, %Statement* %l9
  %t123 = load %Parser, %Parser* %l0
  %t124 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t125 = load %Statement, %Statement* %l9
  %t126 = insertvalue %BlockStatementParseResult %t124, i8* null, 1
  %t127 = insertvalue %BlockStatementParseResult %t126, i1 1, 2
  ret %BlockStatementParseResult %t127
}

define %StatementParseResult @parse_unknown(%Parser %parser) {
entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca %Parser
  %l2 = alloca double
  %l3 = alloca %Token
  %l4 = alloca i8*
  %l5 = alloca %Statement
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Token*, i64 }* null, { %Token*, i64 }** %l0
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
  %t29 = load i8*, i8** %l4
  %t30 = getelementptr inbounds %Statement, %Statement* %t26, i32 0, i32 1
  %t31 = bitcast [16 x i8]* %t30 to i8*
  %t32 = getelementptr inbounds i8, i8* %t31, i64 8
  %t33 = bitcast i8* %t32 to i8**
  store i8* %t29, i8** %t33
  %t34 = load %Statement, %Statement* %t26
  store %Statement %t34, %Statement* %l5
  %t35 = insertvalue %StatementParseResult undef, i8* null, 0
  %t36 = load %Statement, %Statement* %l5
  %t37 = insertvalue %StatementParseResult %t35, i8* null, 1
  ret %StatementParseResult %t37
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
  %t27 = phi %Parser [ %t0, %entry ], [ %t26, %loop.latch2 ]
  store %Parser %t27, %Parser* %l0
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
  %t14 = load { i8**, i64 }, { i8**, i64 }* %t11
  %t15 = extractvalue { i8**, i64 } %t14, 0
  %t16 = extractvalue { i8**, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  %t18 = getelementptr i8*, i8** %t15, i64 %t13
  %t19 = load i8*, i8** %t18
  store i8* %t19, i8** %l1
  %t20 = load i8*, i8** %l1
  %t21 = call i1 @is_trivia_token(%Token zeroinitializer)
  %t22 = load %Parser, %Parser* %l0
  %t23 = load i8*, i8** %l1
  br i1 %t21, label %then6, label %merge7
then6:
  %t24 = load %Parser, %Parser* %l0
  %t25 = call %Parser @parser_advance_raw(%Parser %t24)
  store %Parser %t25, %Parser* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t26 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t28 = load %Parser, %Parser* %l0
  ret %Parser %t28
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
  %t8 = load { i8**, i64 }, { i8**, i64 }* %t6
  %t9 = extractvalue { i8**, i64 } %t8, 0
  %t10 = extractvalue { i8**, i64 } %t8, 1
  %t11 = icmp uge i64 %t7, %t10
  ; bounds check: %t11 (if true, out of bounds)
  %t12 = getelementptr i8*, i8** %t9, i64 %t7
  %t13 = load i8*, i8** %t12
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
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Token*, i64 }* null, { %Token*, i64 }** %l1
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
  %t66 = insertvalue %CaptureResult %t64, { i8**, i64 }* null, 1
  ret %CaptureResult %t66
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
  %t8 = alloca [0 x double]
  %t9 = getelementptr [0 x double], [0 x double]* %t8, i32 0, i32 0
  %t10 = alloca { double*, i64 }
  %t11 = getelementptr { double*, i64 }, { double*, i64 }* %t10, i32 0, i32 0
  store double* %t9, double** %t11
  %t12 = getelementptr { double*, i64 }, { double*, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { %Token*, i64 }* null, { %Token*, i64 }** %l2
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
  %t36 = insertvalue %ParenthesizedParseResult %t34, { i8**, i64 }* null, 1
  %t37 = insertvalue %ParenthesizedParseResult %t36, i1 1, 2
  ret %ParenthesizedParseResult %t37
}

define %PatternCaptureResult @collect_pattern_until_arrow(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca { %Token*, i64 }*
  %l2 = alloca %Token
  %l3 = alloca %Parser
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { %Token*, i64 }* null, { %Token*, i64 }** %l1
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
  %t29 = alloca [0 x double]
  %t30 = getelementptr [0 x double], [0 x double]* %t29, i32 0, i32 0
  %t31 = alloca { double*, i64 }
  %t32 = getelementptr { double*, i64 }, { double*, i64 }* %t31, i32 0, i32 0
  store double* %t30, double** %t32
  %t33 = getelementptr { double*, i64 }, { double*, i64 }* %t31, i32 0, i32 1
  store i64 0, i64* %t33
  %t34 = insertvalue %PatternCaptureResult %t28, { i8**, i64 }* null, 1
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
  %t44 = insertvalue %PatternCaptureResult %t42, { i8**, i64 }* null, 1
  %t45 = insertvalue %PatternCaptureResult %t44, i1 1, 2
  ret %PatternCaptureResult %t45
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
  %t6 = alloca [0 x double]
  %t7 = getelementptr [0 x double], [0 x double]* %t6, i32 0, i32 0
  %t8 = alloca { double*, i64 }
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 0
  store double* %t7, double** %t9
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
  %t11 = insertvalue %MatchCaseTokenSplit undef, { i8**, i64 }* null, 0
  %t12 = alloca [0 x double]
  %t13 = getelementptr [0 x double], [0 x double]* %t12, i32 0, i32 0
  %t14 = alloca { double*, i64 }
  %t15 = getelementptr { double*, i64 }, { double*, i64 }* %t14, i32 0, i32 0
  store double* %t13, double** %t15
  %t16 = getelementptr { double*, i64 }, { double*, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  %t17 = insertvalue %MatchCaseTokenSplit %t11, { i8**, i64 }* null, 1
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
  %t28 = insertvalue %MatchCaseTokenSplit undef, { i8**, i64 }* null, 0
  %t29 = alloca [0 x double]
  %t30 = getelementptr [0 x double], [0 x double]* %t29, i32 0, i32 0
  %t31 = alloca { double*, i64 }
  %t32 = getelementptr { double*, i64 }, { double*, i64 }* %t31, i32 0, i32 0
  store double* %t30, double** %t32
  %t33 = getelementptr { double*, i64 }, { double*, i64 }* %t31, i32 0, i32 1
  store i64 0, i64* %t33
  %t34 = insertvalue %MatchCaseTokenSplit %t28, { i8**, i64 }* null, 1
  %t35 = insertvalue %MatchCaseTokenSplit %t34, i1 0, 2
  ret %MatchCaseTokenSplit %t35
merge3:
  %t36 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t37 = load double, double* %l1
  %t38 = sitofp i64 0 to double
  %t39 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t36, double %t38, double %t37)
  %t40 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t39)
  store { %Token*, i64 }* %t40, { %Token*, i64 }** %l2
  %t41 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t42 = load double, double* %l1
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  %t45 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t46 = load { %Token*, i64 }, { %Token*, i64 }* %t45
  %t47 = extractvalue { %Token*, i64 } %t46, 1
  %t48 = sitofp i64 %t47 to double
  %t49 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t41, double %t44, double %t48)
  %t50 = call { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }* %t49)
  store { %Token*, i64 }* %t50, { %Token*, i64 }** %l3
  %t51 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t52 = insertvalue %MatchCaseTokenSplit undef, { i8**, i64 }* null, 0
  %t53 = load { %Token*, i64 }*, { %Token*, i64 }** %l3
  %t54 = insertvalue %MatchCaseTokenSplit %t52, { i8**, i64 }* null, 1
  %t55 = insertvalue %MatchCaseTokenSplit %t54, i1 1, 2
  ret %MatchCaseTokenSplit %t55
}

define %Expression @normalize_expression({ %Token*, i64 }* %tokens, %Expression %expr) {
entry:
  ret %Expression %expr
}

define i1 @looks_like_number(i8* %text) {
entry:
  %l0 = alloca i1
  %l1 = alloca double
  %l2 = alloca i8
  store i1 0, i1* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = getelementptr i8, i8* %text, i64 0
  %t2 = load i8, i8* %t1
  %t3 = load i1, i1* %l0
  %t4 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t32 = phi i1 [ %t3, %entry ], [ %t30, %loop.latch2 ]
  %t33 = phi double [ %t4, %entry ], [ %t31, %loop.latch2 ]
  store i1 %t32, i1* %l0
  store double %t33, double* %l1
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = load double, double* %l1
  %t7 = getelementptr i8, i8* %text, i64 %t6
  %t8 = load i8, i8* %t7
  store i8 %t8, i8* %l2
  %t9 = load i8, i8* %l2
  %t10 = icmp eq i8 %t9, 46
  %t11 = load i1, i1* %l0
  %t12 = load double, double* %l1
  %t13 = load i8, i8* %l2
  br i1 %t10, label %then4, label %merge5
then4:
  %t14 = load i1, i1* %l0
  %t15 = load i1, i1* %l0
  %t16 = load double, double* %l1
  %t17 = load i8, i8* %l2
  br i1 %t14, label %then6, label %merge7
then6:
  ret i1 0
merge7:
  store i1 1, i1* %l0
  %t18 = load double, double* %l1
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l1
  br label %loop.latch2
merge5:
  %t21 = load i8, i8* %l2
  %t22 = call i1 @sailfin_runtime_is_decimal_digit(i8* null)
  %t23 = xor i1 %t22, 1
  %t24 = load i1, i1* %l0
  %t25 = load double, double* %l1
  %t26 = load i8, i8* %l2
  br i1 %t23, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t27 = load double, double* %l1
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l1
  br label %loop.latch2
loop.latch2:
  %t30 = load i1, i1* %l0
  %t31 = load double, double* %l1
  br label %loop.header0
afterloop3:
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
  %t27 = phi double [ %t4, %entry ], [ %t26, %loop.latch2 ]
  store double %t27, double* %l0
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
  %t12 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t13 = extractvalue { %Token*, i64 } %t12, 0
  %t14 = extractvalue { %Token*, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr %Token, %Token* %t13, i64 %t11
  %t17 = load %Token, %Token* %t16
  store %Token %t17, %Token* %l2
  %t18 = load %Token, %Token* %l2
  %t19 = call i1 @is_trivia_token(%Token %t18)
  %t20 = load double, double* %l0
  %t21 = load double, double* %l1
  %t22 = load %Token, %Token* %l2
  br i1 %t19, label %then6, label %merge7
then6:
  %t23 = load double, double* %l0
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t26 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t28 = load double, double* %l0
  %t29 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t44 = phi double [ %t29, %entry ], [ %t43, %loop.latch10 ]
  store double %t44, double* %l1
  br label %loop.body9
loop.body9:
  %t30 = load double, double* %l1
  %t31 = load double, double* %l0
  %t32 = fcmp ole double %t30, %t31
  %t33 = load double, double* %l0
  %t34 = load double, double* %l1
  br i1 %t32, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store double 0.0, double* %l3
  %t35 = load double, double* %l3
  %t36 = call i1 @is_trivia_token(%Token zeroinitializer)
  %t37 = load double, double* %l0
  %t38 = load double, double* %l1
  %t39 = load double, double* %l3
  br i1 %t36, label %then14, label %merge15
then14:
  %t40 = load double, double* %l1
  %t41 = sitofp i64 1 to double
  %t42 = fsub double %t40, %t41
  store double %t42, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t43 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t45 = load double, double* %l0
  %t46 = load double, double* %l1
  %t47 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %tokens, double %t45, double %t46)
  ret { %Token*, i64 }* %t47
}

define { %Token*, i64 }* @token_slice({ %Token*, i64 }* %tokens, double %start, double %end) {
entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Token*, i64 }* null, { %Token*, i64 }** %l0
  store double %start, double* %l1
  %t5 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t6 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t25 = phi { %Token*, i64 }* [ %t5, %entry ], [ %t23, %loop.latch2 ]
  %t26 = phi double [ %t6, %entry ], [ %t24, %loop.latch2 ]
  store { %Token*, i64 }* %t25, { %Token*, i64 }** %l0
  store double %t26, double* %l1
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
  %t13 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t14 = extractvalue { %Token*, i64 } %t13, 0
  %t15 = extractvalue { %Token*, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  %t17 = getelementptr %Token, %Token* %t14, i64 %t12
  %t18 = load %Token, %Token* %t17
  %t19 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t11, %Token %t18)
  store { %Token*, i64 }* %t19, { %Token*, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l1
  br label %loop.latch2
loop.latch2:
  %t23 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t24 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t27 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  ret { %Token*, i64 }* %t27
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
  %t29 = phi double [ %t6, %entry ], [ %t28, %loop.latch2 ]
  store double %t29, double* %l1
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
  %t17 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t18 = extractvalue { %Token*, i64 } %t17, 0
  %t19 = extractvalue { %Token*, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr %Token, %Token* %t18, i64 %t16
  %t22 = load %Token, %Token* %t21
  store %Token %t22, %Token* %l3
  %t23 = load %Token, %Token* %l3
  %t24 = extractvalue %Token %t23, 0
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l1
  br label %loop.latch2
loop.latch2:
  %t28 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t30 = load double, double* %l2
  %t31 = sitofp i64 0 to double
  %t32 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %tokens, double %t31, double %t30)
  ret { %Token*, i64 }* %t32
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
  %t33 = phi double [ %t9, %entry ], [ %t32, %loop.latch2 ]
  store double %t33, double* %l4
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
  %t21 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t22 = extractvalue { %Token*, i64 } %t21, 0
  %t23 = extractvalue { %Token*, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr %Token, %Token* %t22, i64 %t20
  %t26 = load %Token, %Token* %t25
  store %Token %t26, %Token* %l5
  %t27 = load %Token, %Token* %l5
  %t28 = extractvalue %Token %t27, 0
  %t29 = load double, double* %l4
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l4
  br label %loop.latch2
loop.latch2:
  %t32 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t34 = sitofp i64 -1 to double
  ret double %t34
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
  %t28 = insertvalue %ExpressionTokens undef, { i8**, i64 }* null, 0
  %t29 = sitofp i64 0 to double
  %t30 = insertvalue %ExpressionTokens %t28, double %t29, 1
  store %ExpressionTokens %t30, %ExpressionTokens* %l2
  %t31 = load %ExpressionTokens, %ExpressionTokens* %l2
  %t32 = sitofp i64 0 to double
  %t33 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %t31, double %t32)
  store %ExpressionParseResult %t33, %ExpressionParseResult* %l3
  %t34 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  %t35 = extractvalue %ExpressionParseResult %t34, 2
  %t36 = xor i1 %t35, 1
  %t37 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t38 = load %ExpressionTokens, %ExpressionTokens* %l2
  %t39 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  br i1 %t36, label %then4, label %merge5
then4:
  %t40 = alloca %Expression
  %t41 = getelementptr inbounds %Expression, %Expression* %t40, i32 0, i32 0
  store i32 15, i32* %t41
  %t42 = call i8* @tokens_to_text({ %Token*, i64 }* %tokens)
  %t43 = call i8* @trim_text(i8* %t42)
  %t44 = getelementptr inbounds %Expression, %Expression* %t40, i32 0, i32 1
  %t45 = bitcast [8 x i8]* %t44 to i8*
  %t46 = bitcast i8* %t45 to i8**
  store i8* %t43, i8** %t46
  %t47 = load %Expression, %Expression* %t40
  ret %Expression %t47
merge5:
  %t48 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  %t49 = extractvalue %ExpressionParseResult %t48, 0
  %t50 = load %ExpressionParseResult, %ExpressionParseResult* %l3
  %t51 = extractvalue %ExpressionParseResult %t50, 1
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
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Token*, i64 }* null, { %Token*, i64 }** %l1
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
  %t62 = phi { %Token*, i64 }* [ %t10, %entry ], [ %t60, %loop.latch2 ]
  %t63 = phi %ExpressionTokens [ %t9, %entry ], [ %t61, %loop.latch2 ]
  store { %Token*, i64 }* %t62, { %Token*, i64 }** %l1
  store %ExpressionTokens %t63, %ExpressionTokens* %l0
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
  %t26 = insertvalue %ExpressionCollectResult %t24, { i8**, i64 }* null, 1
  %t27 = insertvalue %ExpressionCollectResult %t26, i1 0, 2
  ret %ExpressionCollectResult %t27
merge5:
  %t28 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t29 = call %Token @expression_tokens_peek(%ExpressionTokens %t28)
  store %Token %t29, %Token* %l6
  %t33 = load double, double* %l2
  %t34 = sitofp i64 0 to double
  %t35 = fcmp oeq double %t33, %t34
  br label %logical_and_entry_32

logical_and_entry_32:
  br i1 %t35, label %logical_and_right_32, label %logical_and_merge_32

logical_and_right_32:
  %t36 = load double, double* %l3
  %t37 = sitofp i64 0 to double
  %t38 = fcmp oeq double %t36, %t37
  br label %logical_and_right_end_32

logical_and_right_end_32:
  br label %logical_and_merge_32

logical_and_merge_32:
  %t39 = phi i1 [ false, %logical_and_entry_32 ], [ %t38, %logical_and_right_end_32 ]
  br label %logical_and_entry_31

logical_and_entry_31:
  br i1 %t39, label %logical_and_right_31, label %logical_and_merge_31

logical_and_right_31:
  %t40 = load double, double* %l4
  %t41 = sitofp i64 0 to double
  %t42 = fcmp oeq double %t40, %t41
  br label %logical_and_right_end_31

logical_and_right_end_31:
  br label %logical_and_merge_31

logical_and_merge_31:
  %t43 = phi i1 [ false, %logical_and_entry_31 ], [ %t42, %logical_and_right_end_31 ]
  br label %logical_and_entry_30

logical_and_entry_30:
  br i1 %t43, label %logical_and_right_30, label %logical_and_merge_30

logical_and_right_30:
  %t44 = load double, double* %l5
  %t45 = sitofp i64 0 to double
  %t46 = fcmp oeq double %t44, %t45
  br label %logical_and_right_end_30

logical_and_right_end_30:
  br label %logical_and_merge_30

logical_and_merge_30:
  %t47 = phi i1 [ false, %logical_and_entry_30 ], [ %t46, %logical_and_right_end_30 ]
  store i1 %t47, i1* %l7
  %t50 = load i1, i1* %l7
  br label %logical_and_entry_49

logical_and_entry_49:
  br i1 %t50, label %logical_and_right_49, label %logical_and_merge_49

logical_and_right_49:
  %t51 = load %Token, %Token* %l6
  %t52 = extractvalue %Token %t51, 0
  %t53 = load %Token, %Token* %l6
  %t54 = extractvalue %Token %t53, 0
  %t55 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t56 = load %Token, %Token* %l6
  %t57 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t55, %Token %t56)
  store { %Token*, i64 }* %t57, { %Token*, i64 }** %l1
  %t58 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t59 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t58)
  store %ExpressionTokens %t59, %ExpressionTokens* %l0
  br label %loop.latch2
loop.latch2:
  %t60 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t61 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header0
afterloop3:
  %t64 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t65 = insertvalue %ExpressionCollectResult undef, i8* null, 0
  %t66 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t67 = insertvalue %ExpressionCollectResult %t65, { i8**, i64 }* null, 1
  %t68 = insertvalue %ExpressionCollectResult %t67, i1 1, 2
  ret %ExpressionCollectResult %t68
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
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  %t10 = insertvalue %ExpressionBlockParseResult %t4, { i8**, i64 }* null, 1
  %t11 = insertvalue %ExpressionBlockParseResult %t10, i1 0, 2
  ret %ExpressionBlockParseResult %t11
merge1:
  %t12 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t13 = call %Token @expression_tokens_peek(%ExpressionTokens %t12)
  store %Token %t13, %Token* %l1
  %t15 = load %Token, %Token* %l1
  %t16 = extractvalue %Token %t15, 0
  %t17 = alloca [0 x double]
  %t18 = getelementptr [0 x double], [0 x double]* %t17, i32 0, i32 0
  %t19 = alloca { double*, i64 }
  %t20 = getelementptr { double*, i64 }, { double*, i64 }* %t19, i32 0, i32 0
  store double* %t18, double** %t20
  %t21 = getelementptr { double*, i64 }, { double*, i64 }* %t19, i32 0, i32 1
  store i64 0, i64* %t21
  store { %Token*, i64 }* null, { %Token*, i64 }** %l2
  %t22 = sitofp i64 0 to double
  store double %t22, double* %l3
  %t23 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t24 = load %Token, %Token* %l1
  %t25 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t26 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t49 = phi { %Token*, i64 }* [ %t25, %entry ], [ %t47, %loop.latch4 ]
  %t50 = phi %ExpressionTokens [ %t23, %entry ], [ %t48, %loop.latch4 ]
  store { %Token*, i64 }* %t49, { %Token*, i64 }** %l2
  store %ExpressionTokens %t50, %ExpressionTokens* %l0
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
  %t36 = insertvalue %ExpressionBlockParseResult %t34, { i8**, i64 }* null, 1
  %t37 = insertvalue %ExpressionBlockParseResult %t36, i1 0, 2
  ret %ExpressionBlockParseResult %t37
merge7:
  %t38 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t39 = call %Token @expression_tokens_peek(%ExpressionTokens %t38)
  store %Token %t39, %Token* %l4
  %t40 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t41 = load %Token, %Token* %l4
  %t42 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t40, %Token %t41)
  store { %Token*, i64 }* %t42, { %Token*, i64 }** %l2
  %t43 = load %Token, %Token* %l4
  %t44 = extractvalue %Token %t43, 0
  %t45 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t46 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t45)
  store %ExpressionTokens %t46, %ExpressionTokens* %l0
  br label %loop.latch4
loop.latch4:
  %t47 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t48 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t51 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t52 = insertvalue %ExpressionBlockParseResult undef, i8* null, 0
  %t53 = load { %Token*, i64 }*, { %Token*, i64 }** %l2
  %t54 = insertvalue %ExpressionBlockParseResult %t52, { i8**, i64 }* null, 1
  %t55 = insertvalue %ExpressionBlockParseResult %t54, i1 1, 2
  ret %ExpressionBlockParseResult %t55
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
  %l12 = alloca double
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
  %t64 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* null, double %t61, double %t63)
  store { %Token*, i64 }* %t64, { %Token*, i64 }** %l10
  %t65 = load { %Token*, i64 }*, { %Token*, i64 }** %l10
  %t66 = call double @source_span_from_tokens({ %Token*, i64 }* %t65)
  store double %t66, double* %l11
  store double 0.0, double* %l12
  %t67 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t68 = insertvalue %LambdaParameterParseResult undef, i8* null, 0
  %t69 = load double, double* %l12
  %t70 = insertvalue %LambdaParameterParseResult %t68, i8* null, 1
  %t71 = insertvalue %LambdaParameterParseResult %t70, i1 1, 2
  ret %LambdaParameterParseResult %t71
}

define %LambdaParameterListParseResult @parse_lambda_parameter_list(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca { %Parameter*, i64 }*
  %l2 = alloca %Token
  %l3 = alloca %LambdaParameterParseResult
  %l4 = alloca %Token
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Parameter*, i64 }* null, { %Parameter*, i64 }** %l1
  %t5 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t6 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t5)
  %t7 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t8 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  br i1 %t6, label %then0, label %merge1
then0:
  %t9 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t10 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t11 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t12 = insertvalue %LambdaParameterListParseResult %t10, { i8**, i64 }* null, 1
  %t13 = insertvalue %LambdaParameterListParseResult %t12, i1 0, 2
  ret %LambdaParameterListParseResult %t13
merge1:
  %t14 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t15 = call %Token @expression_tokens_peek(%ExpressionTokens %t14)
  store %Token %t15, %Token* %l2
  %t16 = load %Token, %Token* %l2
  %t17 = extractvalue %Token %t16, 0
  %t18 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t19 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t20 = load %Token, %Token* %l2
  br label %loop.header2
loop.header2:
  %t63 = phi { %Parameter*, i64 }* [ %t19, %entry ], [ %t61, %loop.latch4 ]
  %t64 = phi %ExpressionTokens [ %t18, %entry ], [ %t62, %loop.latch4 ]
  store { %Parameter*, i64 }* %t63, { %Parameter*, i64 }** %l1
  store %ExpressionTokens %t64, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t21 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t22 = call %LambdaParameterParseResult @parse_lambda_parameter(%ExpressionTokens %t21)
  store %LambdaParameterParseResult %t22, %LambdaParameterParseResult* %l3
  %t23 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  %t24 = extractvalue %LambdaParameterParseResult %t23, 2
  %t25 = xor i1 %t24, 1
  %t26 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t27 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t28 = load %Token, %Token* %l2
  %t29 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  br i1 %t25, label %then6, label %merge7
then6:
  %t30 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t31 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t32 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t33 = insertvalue %LambdaParameterListParseResult %t31, { i8**, i64 }* null, 1
  %t34 = insertvalue %LambdaParameterListParseResult %t33, i1 0, 2
  ret %LambdaParameterListParseResult %t34
merge7:
  %t35 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t36 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  %t37 = extractvalue %LambdaParameterParseResult %t36, 1
  %t38 = call { %Parameter*, i64 }* @append_parameter({ %Parameter*, i64 }* %t35, %Parameter zeroinitializer)
  store { %Parameter*, i64 }* %t38, { %Parameter*, i64 }** %l1
  %t39 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  %t40 = extractvalue %LambdaParameterParseResult %t39, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t41 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t42 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t41)
  %t43 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t44 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t45 = load %Token, %Token* %l2
  %t46 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  br i1 %t42, label %then8, label %merge9
then8:
  %t47 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t48 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t49 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t50 = insertvalue %LambdaParameterListParseResult %t48, { i8**, i64 }* null, 1
  %t51 = insertvalue %LambdaParameterListParseResult %t50, i1 0, 2
  ret %LambdaParameterListParseResult %t51
merge9:
  %t52 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t53 = call %Token @expression_tokens_peek(%ExpressionTokens %t52)
  store %Token %t53, %Token* %l4
  %t54 = load %Token, %Token* %l4
  %t55 = extractvalue %Token %t54, 0
  %t56 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t57 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t58 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t59 = insertvalue %LambdaParameterListParseResult %t57, { i8**, i64 }* null, 1
  %t60 = insertvalue %LambdaParameterListParseResult %t59, i1 0, 2
  ret %LambdaParameterListParseResult %t60
loop.latch4:
  %t61 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t62 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t65 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t66 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t67 = load { %Parameter*, i64 }*, { %Parameter*, i64 }** %l1
  %t68 = insertvalue %LambdaParameterListParseResult %t66, { i8**, i64 }* null, 1
  %t69 = insertvalue %LambdaParameterListParseResult %t68, i1 1, 2
  ret %LambdaParameterListParseResult %t69
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
  %t79 = insertvalue %Parser undef, { i8**, i64 }* %t78, 0
  %t80 = sitofp i64 0 to double
  %t81 = insertvalue %Parser %t79, double %t80, 1
  store %Parser %t81, %Parser* %l9
  %t82 = load %Parser, %Parser* %l9
  %t83 = call %BlockParseResult @parse_block(%Parser %t82)
  store %BlockParseResult %t83, %BlockParseResult* %l10
  %t84 = load %BlockParseResult, %BlockParseResult* %l10
  %t85 = extractvalue %BlockParseResult %t84, 1
  store i8* %t85, i8** %l11
  %t86 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t87 = insertvalue %ExpressionParseResult undef, i8* null, 0
  %t88 = alloca %Expression
  %t89 = getelementptr inbounds %Expression, %Expression* %t88, i32 0, i32 0
  store i32 13, i32* %t89
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t91 = getelementptr inbounds %Expression, %Expression* %t88, i32 0, i32 1
  %t92 = bitcast [24 x i8]* %t91 to i8*
  %t93 = bitcast i8* %t92 to { i8**, i64 }**
  store { i8**, i64 }* %t90, { i8**, i64 }** %t93
  %t94 = load i8*, i8** %l11
  %t95 = getelementptr inbounds %Expression, %Expression* %t88, i32 0, i32 1
  %t96 = bitcast [24 x i8]* %t95 to i8*
  %t97 = getelementptr inbounds i8, i8* %t96, i64 8
  %t98 = bitcast i8* %t97 to i8**
  store i8* %t94, i8** %t98
  %t99 = load i8*, i8** %l5
  %t100 = getelementptr inbounds %Expression, %Expression* %t88, i32 0, i32 1
  %t101 = bitcast [24 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 16
  %t103 = bitcast i8* %t102 to i8**
  store i8* %t99, i8** %t103
  %t104 = load %Expression, %Expression* %t88
  %t105 = insertvalue %ExpressionParseResult %t87, i8* null, 1
  %t106 = insertvalue %ExpressionParseResult %t105, i1 1, 2
  ret %ExpressionParseResult %t106
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
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { %Expression*, i64 }* null, { %Expression*, i64 }** %l1
  %t6 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t7 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t6)
  %t8 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t9 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  br i1 %t7, label %then0, label %merge1
then0:
  %t10 = insertvalue %CallArgumentsParseResult undef, i8* null, 0
  %t11 = alloca [0 x double]
  %t12 = getelementptr [0 x double], [0 x double]* %t11, i32 0, i32 0
  %t13 = alloca { double*, i64 }
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t13, i32 0, i32 0
  store double* %t12, double** %t14
  %t15 = getelementptr { double*, i64 }, { double*, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  %t16 = insertvalue %CallArgumentsParseResult %t10, { i8**, i64 }* null, 1
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
  %t33 = alloca [0 x double]
  %t34 = getelementptr [0 x double], [0 x double]* %t33, i32 0, i32 0
  %t35 = alloca { double*, i64 }
  %t36 = getelementptr { double*, i64 }, { double*, i64 }* %t35, i32 0, i32 0
  store double* %t34, double** %t36
  %t37 = getelementptr { double*, i64 }, { double*, i64 }* %t35, i32 0, i32 1
  store i64 0, i64* %t37
  %t38 = insertvalue %CallArgumentsParseResult %t32, { i8**, i64 }* null, 1
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
  %t52 = alloca [0 x double]
  %t53 = getelementptr [0 x double], [0 x double]* %t52, i32 0, i32 0
  %t54 = alloca { double*, i64 }
  %t55 = getelementptr { double*, i64 }, { double*, i64 }* %t54, i32 0, i32 0
  store double* %t53, double** %t55
  %t56 = getelementptr { double*, i64 }, { double*, i64 }* %t54, i32 0, i32 1
  store i64 0, i64* %t56
  %t57 = insertvalue %CallArgumentsParseResult %t51, { i8**, i64 }* null, 1
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
  %t67 = alloca [0 x double]
  %t68 = getelementptr [0 x double], [0 x double]* %t67, i32 0, i32 0
  %t69 = alloca { double*, i64 }
  %t70 = getelementptr { double*, i64 }, { double*, i64 }* %t69, i32 0, i32 0
  store double* %t68, double** %t70
  %t71 = getelementptr { double*, i64 }, { double*, i64 }* %t69, i32 0, i32 1
  store i64 0, i64* %t71
  %t72 = insertvalue %CallArgumentsParseResult %t66, { i8**, i64 }* null, 1
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
  %t81 = insertvalue %CallArgumentsParseResult %t79, { i8**, i64 }* null, 1
  %t82 = insertvalue %CallArgumentsParseResult %t81, i1 1, 2
  ret %CallArgumentsParseResult %t82
}

define %ArrayLiteralParseResult @parse_array_literal(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca { %Expression*, i64 }*
  %l2 = alloca %ExpressionParseResult
  %l3 = alloca %Token
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Expression*, i64 }* null, { %Expression*, i64 }** %l1
  %t5 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t6 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t5)
  %t7 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t8 = load { %Expression*, i64 }*, { %Expression*, i64 }** %l1
  br i1 %t6, label %then0, label %merge1
then0:
  %t9 = insertvalue %ArrayLiteralParseResult undef, i8* null, 0
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  %t15 = insertvalue %ArrayLiteralParseResult %t9, { i8**, i64 }* null, 1
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
  %t33 = alloca [0 x double]
  %t34 = getelementptr [0 x double], [0 x double]* %t33, i32 0, i32 0
  %t35 = alloca { double*, i64 }
  %t36 = getelementptr { double*, i64 }, { double*, i64 }* %t35, i32 0, i32 0
  store double* %t34, double** %t36
  %t37 = getelementptr { double*, i64 }, { double*, i64 }* %t35, i32 0, i32 1
  store i64 0, i64* %t37
  %t38 = insertvalue %ArrayLiteralParseResult %t32, { i8**, i64 }* null, 1
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
  %t52 = alloca [0 x double]
  %t53 = getelementptr [0 x double], [0 x double]* %t52, i32 0, i32 0
  %t54 = alloca { double*, i64 }
  %t55 = getelementptr { double*, i64 }, { double*, i64 }* %t54, i32 0, i32 0
  store double* %t53, double** %t55
  %t56 = getelementptr { double*, i64 }, { double*, i64 }* %t54, i32 0, i32 1
  store i64 0, i64* %t56
  %t57 = insertvalue %ArrayLiteralParseResult %t51, { i8**, i64 }* null, 1
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
  %t68 = alloca [0 x double]
  %t69 = getelementptr [0 x double], [0 x double]* %t68, i32 0, i32 0
  %t70 = alloca { double*, i64 }
  %t71 = getelementptr { double*, i64 }, { double*, i64 }* %t70, i32 0, i32 0
  store double* %t69, double** %t71
  %t72 = getelementptr { double*, i64 }, { double*, i64 }* %t70, i32 0, i32 1
  store i64 0, i64* %t72
  %t73 = insertvalue %ArrayLiteralParseResult %t67, { i8**, i64 }* null, 1
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
  %t82 = insertvalue %ArrayLiteralParseResult %t80, { i8**, i64 }* null, 1
  %t83 = insertvalue %ArrayLiteralParseResult %t82, i1 1, 2
  ret %ArrayLiteralParseResult %t83
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
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %ObjectField*, i64 }* null, { %ObjectField*, i64 }** %l1
  %t5 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t6 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t5)
  %t7 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t8 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %l1
  br i1 %t6, label %then0, label %merge1
then0:
  %t9 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  %t15 = insertvalue %ObjectLiteralParseResult %t9, { i8**, i64 }* null, 1
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
  %t28 = alloca [0 x double]
  %t29 = getelementptr [0 x double], [0 x double]* %t28, i32 0, i32 0
  %t30 = alloca { double*, i64 }
  %t31 = getelementptr { double*, i64 }, { double*, i64 }* %t30, i32 0, i32 0
  store double* %t29, double** %t31
  %t32 = getelementptr { double*, i64 }, { double*, i64 }* %t30, i32 0, i32 1
  store i64 0, i64* %t32
  %t33 = insertvalue %ObjectLiteralParseResult %t27, { i8**, i64 }* null, 1
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
  %t50 = alloca [0 x double]
  %t51 = getelementptr [0 x double], [0 x double]* %t50, i32 0, i32 0
  %t52 = alloca { double*, i64 }
  %t53 = getelementptr { double*, i64 }, { double*, i64 }* %t52, i32 0, i32 0
  store double* %t51, double** %t53
  %t54 = getelementptr { double*, i64 }, { double*, i64 }* %t52, i32 0, i32 1
  store i64 0, i64* %t54
  %t55 = insertvalue %ObjectLiteralParseResult %t49, { i8**, i64 }* null, 1
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
  %t77 = alloca [0 x double]
  %t78 = getelementptr [0 x double], [0 x double]* %t77, i32 0, i32 0
  %t79 = alloca { double*, i64 }
  %t80 = getelementptr { double*, i64 }, { double*, i64 }* %t79, i32 0, i32 0
  store double* %t78, double** %t80
  %t81 = getelementptr { double*, i64 }, { double*, i64 }* %t79, i32 0, i32 1
  store i64 0, i64* %t81
  %t82 = insertvalue %ObjectLiteralParseResult %t76, { i8**, i64 }* null, 1
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
  %t102 = alloca [0 x double]
  %t103 = getelementptr [0 x double], [0 x double]* %t102, i32 0, i32 0
  %t104 = alloca { double*, i64 }
  %t105 = getelementptr { double*, i64 }, { double*, i64 }* %t104, i32 0, i32 0
  store double* %t103, double** %t105
  %t106 = getelementptr { double*, i64 }, { double*, i64 }* %t104, i32 0, i32 1
  store i64 0, i64* %t106
  %t107 = insertvalue %ObjectLiteralParseResult %t101, { i8**, i64 }* null, 1
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
  %t118 = alloca [0 x double]
  %t119 = getelementptr [0 x double], [0 x double]* %t118, i32 0, i32 0
  %t120 = alloca { double*, i64 }
  %t121 = getelementptr { double*, i64 }, { double*, i64 }* %t120, i32 0, i32 0
  store double* %t119, double** %t121
  %t122 = getelementptr { double*, i64 }, { double*, i64 }* %t120, i32 0, i32 1
  store i64 0, i64* %t122
  %t123 = insertvalue %ObjectLiteralParseResult %t117, { i8**, i64 }* null, 1
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
  %t132 = insertvalue %ObjectLiteralParseResult %t130, { i8**, i64 }* null, 1
  %t133 = insertvalue %ObjectLiteralParseResult %t132, i1 1, 2
  ret %ObjectLiteralParseResult %t133
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
  %t2 = load { i8**, i64 }, { i8**, i64 }* %t0
  %t3 = extractvalue { i8**, i64 } %t2, 0
  %t4 = extractvalue { i8**, i64 } %t2, 1
  %t5 = icmp uge i64 %t1, %t4
  ; bounds check: %t5 (if true, out of bounds)
  %t6 = getelementptr i8*, i8** %t3, i64 %t1
  %t7 = load i8*, i8** %t6
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
  ret i1 0
}

define %StructTypeNameResult @collect_struct_type_name(%Expression %expression) {
entry:
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  %t5 = insertvalue %StructTypeNameResult undef, { i8**, i64 }* null, 0
  %t6 = insertvalue %StructTypeNameResult %t5, i1 0, 1
  ret %StructTypeNameResult %t6
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
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { %Token*, i64 }* null, { %Token*, i64 }** %l1
  %t6 = load double, double* %l0
  %t7 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t30 = phi double [ %t6, %entry ], [ %t29, %loop.latch2 ]
  store double %t30, double* %l0
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
  %t16 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t17 = extractvalue { %Token*, i64 } %t16, 0
  %t18 = extractvalue { %Token*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %Token, %Token* %t17, i64 %t15
  %t21 = load %Token, %Token* %t20
  store %Token %t21, %Token* %l2
  %t24 = load %Token, %Token* %l2
  %t25 = extractvalue %Token %t24, 0
  %t26 = load double, double* %l0
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  store double %t28, double* %l0
  br label %loop.latch2
loop.latch2:
  %t29 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t31 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  ret { %Token*, i64 }* %t31
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
  %t26 = phi i8* [ %t2, %entry ], [ %t24, %loop.latch2 ]
  %t27 = phi double [ %t3, %entry ], [ %t25, %loop.latch2 ]
  store i8* %t26, i8** %l0
  store double %t27, double* %l1
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
  %t13 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t14 = extractvalue { %Token*, i64 } %t13, 0
  %t15 = extractvalue { %Token*, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  %t17 = getelementptr %Token, %Token* %t14, i64 %t12
  %t18 = load %Token, %Token* %t17
  %t19 = extractvalue %Token %t18, 1
  %t20 = add i8* %t11, %t19
  store i8* %t20, i8** %l0
  %t21 = load double, double* %l1
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  store double %t23, double* %l1
  br label %loop.latch2
loop.latch2:
  %t24 = load i8*, i8** %l0
  %t25 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t28 = load i8*, i8** %l0
  ret i8* %t28
}

define i8* @trim_text(i8* %value) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t20 = phi double [ %t1, %entry ], [ %t19, %loop.latch2 ]
  store double %t20, double* %l0
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
  store i8 %t10, i8* %l2
  %t11 = load i8, i8* %l2
  %t12 = call i1 @is_trim_whitespace(i8* null)
  %t13 = load double, double* %l0
  %t14 = load double, double* %l1
  %t15 = load i8, i8* %l2
  br i1 %t12, label %then6, label %merge7
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
  %t37 = phi double [ %t22, %entry ], [ %t36, %loop.latch10 ]
  store double %t37, double* %l1
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
  store double 0.0, double* %l3
  %t28 = load double, double* %l3
  %t29 = call i1 @is_trim_whitespace(i8* null)
  %t30 = load double, double* %l0
  %t31 = load double, double* %l1
  %t32 = load double, double* %l3
  br i1 %t29, label %then14, label %merge15
then14:
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fsub double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t36 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t38 = load double, double* %l0
  %t39 = load double, double* %l1
  %t40 = fptosi double %t38 to i64
  %t41 = fptosi double %t39 to i64
  %t42 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t40, i64 %t41)
  ret i8* %t42
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
  %t21 = phi double [ %t1, %entry ], [ %t20, %loop.latch2 ]
  store double %t21, double* %l0
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
  %t9 = load { i8**, i64 }, { i8**, i64 }* %values
  %t10 = extractvalue { i8**, i64 } %t9, 0
  %t11 = extractvalue { i8**, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  %t13 = getelementptr i8*, i8** %t10, i64 %t8
  %t14 = load i8*, i8** %t13
  %t15 = icmp eq i8* %t14, %target
  %t16 = load double, double* %l0
  br i1 %t15, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t17 = load double, double* %l0
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l0
  br label %loop.latch2
loop.latch2:
  %t20 = load double, double* %l0
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
  %t4 = getelementptr i8, i8* %text, i64 %t3
  %t5 = load i8, i8* %t4
  store i8 %t5, i8* %l1
  %t6 = load i8, i8* %l1
  %t7 = call i1 @is_trim_whitespace(i8* null)
  %t8 = xor i1 %t7, 1
  %t9 = load double, double* %l0
  %t10 = load i8, i8* %l1
  br i1 %t8, label %then4, label %merge5
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
  %t0 = getelementptr i8, i8* %text, i64 0
  %t1 = load i8, i8* %t0
  %t2 = call double @char_code(i8 %t1)
  store double %t2, double* %l0
  store double 0.0, double* %l1
  %t4 = load double, double* %l0
  %t5 = sitofp i64 34 to double
  %t6 = fcmp oeq double %t4, %t5
  br label %logical_and_entry_3

logical_and_entry_3:
  br i1 %t6, label %logical_and_right_3, label %logical_and_merge_3

logical_and_right_3:
  %t7 = load double, double* %l1
  %t8 = sitofp i64 34 to double
  %t9 = fcmp oeq double %t7, %t8
  br label %logical_and_right_end_3

logical_and_right_end_3:
  br label %logical_and_merge_3

logical_and_merge_3:
  %t10 = phi i1 [ false, %logical_and_entry_3 ], [ %t9, %logical_and_right_end_3 ]
  %t11 = load double, double* %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then0, label %merge1
then0:
  ret i8* null
merge1:
  ret i8* %text
}

define i8* @normalize_test_name(i8* %text) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  ret i8* %t2
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
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
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
  %t48 = phi i8* [ %t12, %entry ], [ %t46, %loop.latch2 ]
  %t49 = phi double [ %t17, %entry ], [ %t47, %loop.latch2 ]
  store i8* %t48, i8** %l1
  store double %t49, double* %l6
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
  %t31 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t32 = extractvalue { %Token*, i64 } %t31, 0
  %t33 = extractvalue { %Token*, i64 } %t31, 1
  %t34 = icmp uge i64 %t30, %t33
  ; bounds check: %t34 (if true, out of bounds)
  %t35 = getelementptr %Token, %Token* %t32, i64 %t30
  %t36 = load %Token, %Token* %t35
  store %Token %t36, %Token* %l7
  %t37 = load %Token, %Token* %l7
  %t38 = extractvalue %Token %t37, 0
  %t39 = load i8*, i8** %l1
  %t40 = load %Token, %Token* %l7
  %t41 = extractvalue %Token %t40, 1
  %t42 = add i8* %t39, %t41
  store i8* %t42, i8** %l1
  %t43 = load double, double* %l6
  %t44 = sitofp i64 1 to double
  %t45 = fadd double %t43, %t44
  store double %t45, double* %l6
  br label %loop.latch2
loop.latch2:
  %t46 = load i8*, i8** %l1
  %t47 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t50 = load i8*, i8** %l1
  %t51 = call i8* @trim_text(i8* %t50)
  store i8* %t51, i8** %l8
  %t52 = load i8*, i8** %l8
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t53
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
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %Token*, i64 }* null, { %Token*, i64 }** %l1
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
  %t51 = phi { %Token*, i64 }* [ %t16, %entry ], [ %t49, %loop.latch2 ]
  %t52 = phi double [ %t21, %entry ], [ %t50, %loop.latch2 ]
  store { %Token*, i64 }* %t51, { %Token*, i64 }** %l1
  store double %t52, double* %l6
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
  %t35 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t36 = extractvalue { %Token*, i64 } %t35, 0
  %t37 = extractvalue { %Token*, i64 } %t35, 1
  %t38 = icmp uge i64 %t34, %t37
  ; bounds check: %t38 (if true, out of bounds)
  %t39 = getelementptr %Token, %Token* %t36, i64 %t34
  %t40 = load %Token, %Token* %t39
  store %Token %t40, %Token* %l7
  %t41 = load %Token, %Token* %l7
  %t42 = extractvalue %Token %t41, 0
  %t43 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t44 = load %Token, %Token* %l7
  %t45 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t43, %Token %t44)
  store { %Token*, i64 }* %t45, { %Token*, i64 }** %l1
  %t46 = load double, double* %l6
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  store double %t48, double* %l6
  br label %loop.latch2
loop.latch2:
  %t49 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t50 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t53 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t54 = load { %Token*, i64 }, { %Token*, i64 }* %t53
  %t55 = extractvalue { %Token*, i64 } %t54, 1
  %t56 = icmp sgt i64 %t55, 0
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t59 = load double, double* %l2
  %t60 = load double, double* %l3
  %t61 = load double, double* %l4
  %t62 = load double, double* %l5
  %t63 = load double, double* %l6
  br i1 %t56, label %then6, label %merge7
then6:
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t66 = call { i8**, i64 }* @append_token_array({ i8**, i64 }* %t64, { %Token*, i64 }* %t65)
  store { i8**, i64 }* %t66, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t67 = phi { i8**, i64 }* [ %t66, %then6 ], [ %t57, %entry ]
  store { i8**, i64 }* %t67, { i8**, i64 }** %l0
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t68
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
  %t33 = phi double [ %t9, %entry ], [ %t32, %loop.latch2 ]
  store double %t33, double* %l4
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
  %t21 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t22 = extractvalue { %Token*, i64 } %t21, 0
  %t23 = extractvalue { %Token*, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr %Token, %Token* %t22, i64 %t20
  %t26 = load %Token, %Token* %t25
  store %Token %t26, %Token* %l5
  %t27 = load %Token, %Token* %l5
  %t28 = extractvalue %Token %t27, 0
  %t29 = load double, double* %l4
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l4
  br label %loop.latch2
loop.latch2:
  %t32 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t34 = sitofp i64 -1 to double
  ret double %t34
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
  %t35 = phi double [ %t9, %entry ], [ %t34, %loop.latch2 ]
  store double %t35, double* %l4
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
  %t21 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t22 = extractvalue { %Token*, i64 } %t21, 0
  %t23 = extractvalue { %Token*, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr %Token, %Token* %t22, i64 %t20
  %t26 = load %Token, %Token* %t25
  store %Token %t26, %Token* %l5
  %t27 = load %Token, %Token* %l5
  %t28 = extractvalue %Token %t27, 0
  %t29 = load %Token, %Token* %l5
  %t30 = extractvalue %Token %t29, 0
  %t31 = load double, double* %l4
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l4
  br label %loop.latch2
loop.latch2:
  %t34 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t36 = sitofp i64 -1 to double
  ret double %t36
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
  %t6 = call double @statementsconcat({ %Statement*, i64 }* %t3)
  ret { %Statement*, i64 }* null
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
  %t6 = call double @valuesconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
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
  %t6 = call double @parametersconcat({ %Parameter*, i64 }* %t3)
  ret { %Parameter*, i64 }* null
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
  %t6 = call double @propertiesconcat({ %ModelProperty*, i64 }* %t3)
  ret { %ModelProperty*, i64 }* null
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
  %t6 = call double @fieldsconcat({ %FieldDeclaration*, i64 }* %t3)
  ret { %FieldDeclaration*, i64 }* null
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
  %t6 = call double @methodsconcat({ %MethodDeclaration*, i64 }* %t3)
  ret { %MethodDeclaration*, i64 }* null
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
  %t6 = call double @signaturesconcat({ %FunctionSignature*, i64 }* %t3)
  ret { %FunctionSignature*, i64 }* null
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
  %t6 = call double @variantsconcat({ %EnumVariant*, i64 }* %t3)
  ret { %EnumVariant*, i64 }* null
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
  %t6 = call double @typesconcat({ %TypeAnnotation*, i64 }* %t3)
  ret { %TypeAnnotation*, i64 }* null
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
  %t6 = call double @parametersconcat({ %TypeParameter*, i64 }* %t3)
  ret { %TypeParameter*, i64 }* null
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
  %t6 = call double @decoratorsconcat({ %Decorator*, i64 }* %t3)
  ret { %Decorator*, i64 }* null
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
  %t6 = call double @argumentsconcat({ %DecoratorArgument*, i64 }* %t3)
  ret { %DecoratorArgument*, i64 }* null
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
  %t6 = call double @clausesconcat({ %WithClause*, i64 }* %t3)
  ret { %WithClause*, i64 }* null
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
  %t6 = call double @casesconcat({ %MatchCase*, i64 }* %t3)
  ret { %MatchCase*, i64 }* null
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
  %t6 = call double @expressionsconcat({ %Expression*, i64 }* %t3)
  ret { %Expression*, i64 }* null
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
  %t6 = call double @fieldsconcat({ %ObjectField*, i64 }* %t3)
  ret { %ObjectField*, i64 }* null
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
  %t6 = call double @tokensconcat({ %Token*, i64 }* %t3)
  ret { %Token*, i64 }* null
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
  %t6 = call double @collectionconcat({ { %Token*, i64 }**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
