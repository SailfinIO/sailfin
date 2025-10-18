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

declare noalias i8* @malloc(i64)

@.str.4 = private unnamed_addr constant [2 x i8] c";\00"
@.str.45 = private unnamed_addr constant [3 x i8] c"fn\00"
@.str.73 = private unnamed_addr constant [2 x i8] c"(\00"
@.str.43 = private unnamed_addr constant [2 x i8] c"}\00"
@.str.16 = private unnamed_addr constant [11 x i8] c"implements\00"
@.str.21 = private unnamed_addr constant [2 x i8] c"{\00"
@.str.13 = private unnamed_addr constant [4 x i8] c"for\00"
@.str.32 = private unnamed_addr constant [3 x i8] c"in\00"
@.str.13 = private unnamed_addr constant [5 x i8] c"loop\00"
@.str.13 = private unnamed_addr constant [6 x i8] c"break\00"
@.str.13 = private unnamed_addr constant [9 x i8] c"continue\00"
@.str.13 = private unnamed_addr constant [3 x i8] c"if\00"
@.str.13 = private unnamed_addr constant [6 x i8] c"match\00"
@.str.15 = private unnamed_addr constant [7 x i8] c"prompt\00"
@.str.21 = private unnamed_addr constant [1 x i8] c"\00"
@.str.13 = private unnamed_addr constant [5 x i8] c"with\00"
@.str.22 = private unnamed_addr constant [7 x i8] c"return\00"
@.str.9 = private unnamed_addr constant [2 x i8] c"0\00"
@.str.11 = private unnamed_addr constant [2 x i8] c"1\00"
@.str.14 = private unnamed_addr constant [2 x i8] c"2\00"
@.str.17 = private unnamed_addr constant [2 x i8] c"3\00"
@.str.20 = private unnamed_addr constant [2 x i8] c"4\00"
@.str.23 = private unnamed_addr constant [2 x i8] c"5\00"
@.str.26 = private unnamed_addr constant [2 x i8] c"6\00"
@.str.29 = private unnamed_addr constant [2 x i8] c"7\00"
@.str.32 = private unnamed_addr constant [2 x i8] c"8\00"
@.str.35 = private unnamed_addr constant [2 x i8] c"9\00"

define %StatementParseResult @parse_statement(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %DecoratorParseResult
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %DecoratorParseResult @parse_decorators(%Parser %parser)
  store %DecoratorParseResult %t0, %DecoratorParseResult* %l1
  %t1 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t2 = extractvalue %DecoratorParseResult %t1, 1
  store { i8**, i64 }* %t2, { i8**, i64 }** %l2
  %t3 = call double @parser_peek_raw(%Parser %parser)
  store double %t3, double* %l3
  %t4 = load double, double* %l3
  %s5 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.5, i32 0, i32 0
  %t6 = call i1 @identifier_matches(i8* null, i8* %s5)
  %t7 = load %Parser, %Parser* %l0
  %t8 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t10 = load double, double* %l3
  br i1 %t6, label %then0, label %merge1
then0:
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t12 = call %StatementParseResult @parse_import(%Parser %parser)
  ret %StatementParseResult %t12
merge1:
  %t13 = load double, double* %l3
  %s14 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.14, i32 0, i32 0
  %t15 = call i1 @identifier_matches(i8* null, i8* %s14)
  %t16 = load %Parser, %Parser* %l0
  %t17 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t19 = load double, double* %l3
  br i1 %t15, label %then2, label %merge3
then2:
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t21 = call %StatementParseResult @parse_variable(%Parser %parser)
  ret %StatementParseResult %t21
merge3:
  %t22 = load double, double* %l3
  %s23 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.23, i32 0, i32 0
  %t24 = call i1 @identifier_matches(i8* null, i8* %s23)
  %t25 = load %Parser, %Parser* %l0
  %t26 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t28 = load double, double* %l3
  br i1 %t24, label %then4, label %merge5
then4:
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t31 = call %StatementParseResult @parse_model(%Parser %parser, { i8**, i64 }* %t30)
  ret %StatementParseResult %t31
merge5:
  %t32 = load double, double* %l3
  %s33 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.33, i32 0, i32 0
  %t34 = call i1 @identifier_matches(i8* null, i8* %s33)
  %t35 = load %Parser, %Parser* %l0
  %t36 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t38 = load double, double* %l3
  br i1 %t34, label %then6, label %merge7
then6:
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t41 = call %StatementParseResult @parse_pipeline(%Parser %parser, { i8**, i64 }* %t40)
  ret %StatementParseResult %t41
merge7:
  %t42 = load double, double* %l3
  %s43 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.43, i32 0, i32 0
  %t44 = call i1 @identifier_matches(i8* null, i8* %s43)
  %t45 = load %Parser, %Parser* %l0
  %t46 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t48 = load double, double* %l3
  br i1 %t44, label %then8, label %merge9
then8:
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t51 = call %StatementParseResult @parse_tool(%Parser %parser, { i8**, i64 }* %t50)
  ret %StatementParseResult %t51
merge9:
  %t52 = load double, double* %l3
  %s53 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.53, i32 0, i32 0
  %t54 = call i1 @identifier_matches(i8* null, i8* %s53)
  %t55 = load %Parser, %Parser* %l0
  %t56 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t58 = load double, double* %l3
  br i1 %t54, label %then10, label %merge11
then10:
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t61 = call %StatementParseResult @parse_test(%Parser %parser, { i8**, i64 }* %t60)
  ret %StatementParseResult %t61
merge11:
  %t62 = load double, double* %l3
  %s63 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.63, i32 0, i32 0
  %t64 = call i1 @identifier_matches(i8* null, i8* %s63)
  %t65 = load %Parser, %Parser* %l0
  %t66 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t68 = load double, double* %l3
  br i1 %t64, label %then12, label %merge13
then12:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t70 = call %StatementParseResult @parse_function(%Parser %parser, i1 0, { i8**, i64 }* %t69)
  ret %StatementParseResult %t70
merge13:
  %t71 = load double, double* %l3
  %s72 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.72, i32 0, i32 0
  %t73 = call i1 @identifier_matches(i8* null, i8* %s72)
  %t74 = load %Parser, %Parser* %l0
  %t75 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t77 = load double, double* %l3
  br i1 %t73, label %then14, label %merge15
then14:
  %t78 = load double, double* %l3
  %s79 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.79, i32 0, i32 0
  %t80 = call i1 @identifier_matches(i8* null, i8* %s79)
  %t81 = load %Parser, %Parser* %l0
  %t82 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t84 = load double, double* %l3
  br i1 %t80, label %then16, label %merge17
then16:
  br label %merge17
merge17:
  %t85 = load double, double* %l3
  %s86 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.86, i32 0, i32 0
  %t87 = call i1 @identifier_matches(i8* null, i8* %s86)
  %t88 = load %Parser, %Parser* %l0
  %t89 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t91 = load double, double* %l3
  br i1 %t87, label %then18, label %merge19
then18:
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l2
  ret %StatementParseResult zeroinitializer
merge19:
  %t93 = load double, double* %l3
  %s94 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.94, i32 0, i32 0
  %t95 = call i1 @identifier_matches(i8* null, i8* %s94)
  %t96 = load %Parser, %Parser* %l0
  %t97 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t99 = load double, double* %l3
  br i1 %t95, label %then20, label %merge21
then20:
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l2
  ret %StatementParseResult zeroinitializer
merge21:
  store double 0.0, double* %l4
  %t101 = load double, double* %l4
  %s102 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.102, i32 0, i32 0
  %t103 = call i1 @identifier_matches(i8* null, i8* %s102)
  %t104 = load %Parser, %Parser* %l0
  %t105 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t107 = load double, double* %l3
  %t108 = load double, double* %l4
  br i1 %t103, label %then22, label %merge23
then22:
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t110 = call %StatementParseResult @parse_function(%Parser %parser, i1 1, { i8**, i64 }* %t109)
  ret %StatementParseResult %t110
merge23:
  br label %merge15
merge15:
  %t111 = load double, double* %l3
  %s112 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.112, i32 0, i32 0
  %t113 = call i1 @identifier_matches(i8* null, i8* %s112)
  %t114 = load %Parser, %Parser* %l0
  %t115 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t117 = load double, double* %l3
  br i1 %t113, label %then24, label %merge25
then24:
  %t118 = call %StatementParseResult @parse_import(%Parser %parser)
  ret %StatementParseResult %t118
merge25:
  %t119 = load double, double* %l3
  %s120 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.120, i32 0, i32 0
  %t121 = call i1 @identifier_matches(i8* null, i8* %s120)
  %t122 = load %Parser, %Parser* %l0
  %t123 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t125 = load double, double* %l3
  br i1 %t121, label %then26, label %merge27
then26:
  %t126 = call %StatementParseResult @parse_export(%Parser %parser)
  ret %StatementParseResult %t126
merge27:
  %t127 = load double, double* %l3
  %s128 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.128, i32 0, i32 0
  %t129 = call i1 @identifier_matches(i8* null, i8* %s128)
  %t130 = load %Parser, %Parser* %l0
  %t131 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t133 = load double, double* %l3
  br i1 %t129, label %then28, label %merge29
then28:
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t135 = call %StatementParseResult @parse_struct(%Parser %parser, { i8**, i64 }* %t134)
  ret %StatementParseResult %t135
merge29:
  %t136 = load double, double* %l3
  %s137 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.137, i32 0, i32 0
  %t138 = call i1 @identifier_matches(i8* null, i8* %s137)
  %t139 = load %Parser, %Parser* %l0
  %t140 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t142 = load double, double* %l3
  br i1 %t138, label %then30, label %merge31
then30:
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t144 = call %StatementParseResult @parse_type_alias(%Parser %parser, { i8**, i64 }* %t143)
  ret %StatementParseResult %t144
merge31:
  %t145 = load double, double* %l3
  %s146 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.146, i32 0, i32 0
  %t147 = call i1 @identifier_matches(i8* null, i8* %s146)
  %t148 = load %Parser, %Parser* %l0
  %t149 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t151 = load double, double* %l3
  br i1 %t147, label %then32, label %merge33
then32:
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t153 = call %StatementParseResult @parse_interface(%Parser %parser, { i8**, i64 }* %t152)
  ret %StatementParseResult %t153
merge33:
  %t154 = load double, double* %l3
  %s155 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.155, i32 0, i32 0
  %t156 = call i1 @identifier_matches(i8* null, i8* %s155)
  %t157 = load %Parser, %Parser* %l0
  %t158 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t160 = load double, double* %l3
  br i1 %t156, label %then34, label %merge35
then34:
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t162 = call %StatementParseResult @parse_enum(%Parser %parser, { i8**, i64 }* %t161)
  ret %StatementParseResult %t162
merge35:
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t164 = call %StatementParseResult @parse_unknown(%Parser %parser)
  ret %StatementParseResult %t164
}

define %StatementParseResult @parse_import(%Parser %parser) {
entry:
  %l0 = alloca %SpecifierListParseResult
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %CaptureResult
  %l3 = alloca i8*
  %l4 = alloca double
  %t0 = call %SpecifierListParseResult @parse_specifier_list(%Parser %parser)
  store %SpecifierListParseResult %t0, %SpecifierListParseResult* %l0
  %t1 = load %SpecifierListParseResult, %SpecifierListParseResult* %l0
  %t2 = extractvalue %SpecifierListParseResult %t1, 1
  %t3 = call { i8**, i64 }* @build_import_specifiers({ %NamedSpecifier*, i64 }* null)
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %s4 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.4, i32 0, i32 0
  %t5 = alloca [1 x i8*]
  %t6 = getelementptr [1 x i8*], [1 x i8*]* %t5, i32 0, i32 0
  %t7 = getelementptr i8*, i8** %t6, i64 0
  store i8* %s4, i8** %t7
  %t8 = alloca { i8**, i64 }
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* %t8, i32 0, i32 0
  store i8** %t6, i8*** %t9
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t8, i32 0, i32 1
  store i64 1, i64* %t10
  %t11 = call %CaptureResult @collect_until(%Parser %parser, { i8**, i64 }* %t8)
  store %CaptureResult %t11, %CaptureResult* %l2
  %t12 = load %CaptureResult, %CaptureResult* %l2
  %t13 = extractvalue %CaptureResult %t12, 1
  %t14 = call i8* @tokens_to_text({ i8**, i64 }* %t13)
  %t15 = call i8* @trim_text(i8* %t14)
  store i8* %t15, i8** %l3
  %t16 = load i8*, i8** %l3
  %t17 = call i8* @strip_surrounding_quotes(i8* %t16)
  store i8* %t17, i8** %l3
  %t19 = call double @parser_peek_raw(%Parser %parser)
  store double 0.0, double* %l4
  %t20 = insertvalue %StatementParseResult undef, i8* null, 0
  %t21 = load double, double* %l4
  %t22 = insertvalue %StatementParseResult %t20, i8* null, 1
  ret %StatementParseResult %t22
}

define %StatementParseResult @parse_export(%Parser %parser) {
entry:
  %l0 = alloca %SpecifierListParseResult
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %CaptureResult
  %l3 = alloca i8*
  %l4 = alloca double
  %t0 = call %SpecifierListParseResult @parse_specifier_list(%Parser %parser)
  store %SpecifierListParseResult %t0, %SpecifierListParseResult* %l0
  %t1 = load %SpecifierListParseResult, %SpecifierListParseResult* %l0
  %t2 = extractvalue %SpecifierListParseResult %t1, 1
  %t3 = call { i8**, i64 }* @build_export_specifiers({ %NamedSpecifier*, i64 }* null)
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %s4 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.4, i32 0, i32 0
  %t5 = alloca [1 x i8*]
  %t6 = getelementptr [1 x i8*], [1 x i8*]* %t5, i32 0, i32 0
  %t7 = getelementptr i8*, i8** %t6, i64 0
  store i8* %s4, i8** %t7
  %t8 = alloca { i8**, i64 }
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* %t8, i32 0, i32 0
  store i8** %t6, i8*** %t9
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t8, i32 0, i32 1
  store i64 1, i64* %t10
  %t11 = call %CaptureResult @collect_until(%Parser %parser, { i8**, i64 }* %t8)
  store %CaptureResult %t11, %CaptureResult* %l2
  %t12 = load %CaptureResult, %CaptureResult* %l2
  %t13 = extractvalue %CaptureResult %t12, 1
  %t14 = call i8* @tokens_to_text({ i8**, i64 }* %t13)
  %t15 = call i8* @trim_text(i8* %t14)
  store i8* %t15, i8** %l3
  %t16 = load i8*, i8** %l3
  %t17 = call i8* @strip_surrounding_quotes(i8* %t16)
  store i8* %t17, i8** %l3
  %t19 = call double @parser_peek_raw(%Parser %parser)
  store double 0.0, double* %l4
  %t20 = insertvalue %StatementParseResult undef, i8* null, 0
  %t21 = load double, double* %l4
  %t22 = insertvalue %StatementParseResult %t20, i8* null, 1
  ret %StatementParseResult %t22
}

define %StatementParseResult @parse_variable(%Parser %parser) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca i8*
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = call double @parser_peek_raw(%Parser %parser)
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  %t8 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t6, i8* null)
  store { i8**, i64 }* %t8, { i8**, i64 }** %l0
  store i1 0, i1* %l2
  %t9 = call double @parser_peek_raw(%Parser %parser)
  store double %t9, double* %l3
  %t10 = load double, double* %l3
  %s11 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.11, i32 0, i32 0
  %t12 = call i1 @identifier_matches(i8* null, i8* %s11)
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  %t15 = load i1, i1* %l2
  %t16 = load double, double* %l3
  br i1 %t12, label %then0, label %merge1
then0:
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l3
  %t19 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t17, i8* null)
  store { i8**, i64 }* %t19, { i8**, i64 }** %l0
  store i1 1, i1* %l2
  br label %merge1
merge1:
  %t20 = phi { i8**, i64 }* [ %t19, %then0 ], [ %t13, %entry ]
  %t21 = phi i1 [ 1, %then0 ], [ %t15, %entry ]
  store { i8**, i64 }* %t20, { i8**, i64 }** %l0
  store i1 %t21, i1* %l2
  %t22 = call double @parser_peek_raw(%Parser %parser)
  store double %t22, double* %l4
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load double, double* %l4
  %t25 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t23, i8* null)
  store { i8**, i64 }* %t25, { i8**, i64 }** %l0
  %t26 = load double, double* %l4
  %t27 = call i8* @identifier_text(i8* null)
  store i8* %t27, i8** %l5
  store i8* null, i8** %l6
  %t28 = call double @parser_peek_raw(%Parser %parser)
  store double %t28, double* %l7
  %t31 = load double, double* %l7
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  %t32 = call double @parser_peek_raw(%Parser %parser)
  store double %t32, double* %l10
  %t34 = load double, double* %l10
  %t35 = call double @parser_peek_raw(%Parser %parser)
  store double %t35, double* %l11
  %t37 = load double, double* %l11
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = call double @source_span_from_tokens({ i8**, i64 }* %t38)
  store double %t39, double* %l12
  store double 0.0, double* %l13
  %t40 = insertvalue %StatementParseResult undef, i8* null, 0
  %t41 = load double, double* %l13
  %t42 = insertvalue %StatementParseResult %t40, i8* null, 1
  ret %StatementParseResult %t42
}

define %SpecifierListParseResult @parse_specifier_list(%Parser %parser) {
entry:
  %l0 = alloca { %NamedSpecifier*, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
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
  %t27 = phi { %NamedSpecifier*, i64 }* [ %t5, %entry ], [ %t26, %loop.latch2 ]
  store { %NamedSpecifier*, i64 }* %t27, { %NamedSpecifier*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t6 = call double @parser_peek_raw(%Parser %parser)
  store double %t6, double* %l1
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load double, double* %l1
  %t11 = call i8* @identifier_text(i8* null)
  store i8* %t11, i8** %l2
  store i8* null, i8** %l3
  %t12 = call double @parser_peek_raw(%Parser %parser)
  store double %t12, double* %l4
  %t13 = load double, double* %l4
  %s14 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.14, i32 0, i32 0
  %t15 = call i1 @identifier_matches(i8* null, i8* %s14)
  %t16 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l0
  %t17 = load double, double* %l1
  %t18 = load i8*, i8** %l2
  %t19 = load i8*, i8** %l3
  %t20 = load double, double* %l4
  br i1 %t15, label %then4, label %merge5
then4:
  %t21 = call double @parser_peek_raw(%Parser %parser)
  store double %t21, double* %l5
  %t22 = load double, double* %l5
  br label %merge5
merge5:
  %t23 = call double @parser_peek_raw(%Parser %parser)
  store double %t23, double* %l6
  %t25 = load double, double* %l6
  br label %loop.latch2
loop.latch2:
  %t26 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t29 = call double @parser_peek_raw(%Parser %parser)
  %t30 = insertvalue %SpecifierListParseResult undef, i8* null, 0
  %t31 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l0
  %t32 = insertvalue %SpecifierListParseResult %t30, { i8**, i64 }* null, 1
  ret %SpecifierListParseResult %t32
}

define { i8**, i64 }* @build_import_specifiers({ %NamedSpecifier*, i64 }* %values) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %NamedSpecifier
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t21 = phi { i8**, i64 }* [ %t6, %entry ], [ %t19, %loop.latch2 ]
  %t22 = phi double [ %t7, %entry ], [ %t20, %loop.latch2 ]
  store { i8**, i64 }* %t21, { i8**, i64 }** %l0
  store double %t22, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %values
  %t11 = extractvalue { %NamedSpecifier*, i64 } %t10, 0
  %t12 = extractvalue { %NamedSpecifier*, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr %NamedSpecifier, %NamedSpecifier* %t11, i64 %t9
  %t15 = load %NamedSpecifier, %NamedSpecifier* %t14
  store %NamedSpecifier %t15, %NamedSpecifier* %l2
  %t16 = load double, double* %l1
  %t17 = sitofp i64 1 to double
  %t18 = fadd double %t16, %t17
  store double %t18, double* %l1
  br label %loop.latch2
loop.latch2:
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t23
}

define { i8**, i64 }* @build_export_specifiers({ %NamedSpecifier*, i64 }* %values) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %NamedSpecifier
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t21 = phi { i8**, i64 }* [ %t6, %entry ], [ %t19, %loop.latch2 ]
  %t22 = phi double [ %t7, %entry ], [ %t20, %loop.latch2 ]
  store { i8**, i64 }* %t21, { i8**, i64 }** %l0
  store double %t22, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %values
  %t11 = extractvalue { %NamedSpecifier*, i64 } %t10, 0
  %t12 = extractvalue { %NamedSpecifier*, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr %NamedSpecifier, %NamedSpecifier* %t11, i64 %t9
  %t15 = load %NamedSpecifier, %NamedSpecifier* %t14
  store %NamedSpecifier %t15, %NamedSpecifier* %l2
  %t16 = load double, double* %l1
  %t17 = sitofp i64 1 to double
  %t18 = fadd double %t16, %t17
  store double %t18, double* %l1
  br label %loop.latch2
loop.latch2:
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t23
}

define %StatementParseResult @parse_struct(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca %TypeParameterParseResult
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca %ImplementsParseResult
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca { i8**, i64 }*
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca %Parser
  %l10 = alloca %DecoratorParseResult
  %l11 = alloca { i8**, i64 }*
  %l12 = alloca double
  %l13 = alloca %StructFieldParseResult
  %l14 = alloca %MethodParseResult
  %l15 = alloca double
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = call i8* @identifier_text(i8* null)
  store i8* %t2, i8** %l1
  %t3 = load double, double* %l0
  %t4 = alloca [1 x double]
  %t5 = getelementptr [1 x double], [1 x double]* %t4, i32 0, i32 0
  %t6 = getelementptr double, double* %t5, i64 0
  store double %t3, double* %t6
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t5, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 1, i64* %t9
  %t10 = call double @source_span_from_tokens({ i8**, i64 }* null)
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
  store { i8**, i64 }* null, { i8**, i64 }** %l7
  %t22 = alloca [0 x double]
  %t23 = getelementptr [0 x double], [0 x double]* %t22, i32 0, i32 0
  %t24 = alloca { double*, i64 }
  %t25 = getelementptr { double*, i64 }, { double*, i64 }* %t24, i32 0, i32 0
  store double* %t23, double** %t25
  %t26 = getelementptr { double*, i64 }, { double*, i64 }* %t24, i32 0, i32 1
  store i64 0, i64* %t26
  store { i8**, i64 }* null, { i8**, i64 }** %l8
  %t27 = load double, double* %l0
  %t28 = load i8*, i8** %l1
  %t29 = load double, double* %l2
  %t30 = load %TypeParameterParseResult, %TypeParameterParseResult* %l3
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t32 = load %ImplementsParseResult, %ImplementsParseResult* %l5
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l8
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  store %Parser %parser, %Parser* %l9
  %t36 = call %DecoratorParseResult @parse_decorators(%Parser %parser)
  store %DecoratorParseResult %t36, %DecoratorParseResult* %l10
  %t37 = load %DecoratorParseResult, %DecoratorParseResult* %l10
  %t38 = extractvalue %DecoratorParseResult %t37, 1
  store { i8**, i64 }* %t38, { i8**, i64 }** %l11
  %t39 = call double @parser_peek_raw(%Parser %parser)
  store double %t39, double* %l12
  %t41 = load double, double* %l12
  %t42 = load double, double* %l12
  %t43 = call %StructFieldParseResult @parse_struct_field(%Parser %parser)
  store %StructFieldParseResult %t43, %StructFieldParseResult* %l13
  %t45 = load %StructFieldParseResult, %StructFieldParseResult* %l13
  %t46 = extractvalue %StructFieldParseResult %t45, 2
  br label %logical_and_entry_44

logical_and_entry_44:
  br i1 %t46, label %logical_and_right_44, label %logical_and_merge_44

logical_and_right_44:
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t49 = call %MethodParseResult @parse_struct_method(%Parser %parser, { i8**, i64 }* %t48)
  store %MethodParseResult %t49, %MethodParseResult* %l14
  %t50 = load %MethodParseResult, %MethodParseResult* %l14
  %t51 = extractvalue %MethodParseResult %t50, 2
  %t52 = load double, double* %l0
  %t53 = load i8*, i8** %l1
  %t54 = load double, double* %l2
  %t55 = load %TypeParameterParseResult, %TypeParameterParseResult* %l3
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t57 = load %ImplementsParseResult, %ImplementsParseResult* %l5
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t61 = load %Parser, %Parser* %l9
  %t62 = load %DecoratorParseResult, %DecoratorParseResult* %l10
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t64 = load double, double* %l12
  %t65 = load %StructFieldParseResult, %StructFieldParseResult* %l13
  %t66 = load %MethodParseResult, %MethodParseResult* %l14
  br i1 %t51, label %then4, label %merge5
then4:
  %t67 = load %MethodParseResult, %MethodParseResult* %l14
  %t68 = extractvalue %MethodParseResult %t67, 1
  br label %loop.latch2
merge5:
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l15
  %t69 = insertvalue %StatementParseResult undef, i8* null, 0
  %t70 = load double, double* %l15
  %t71 = insertvalue %StatementParseResult %t69, i8* null, 1
  ret %StatementParseResult %t71
}

define %StatementParseResult @parse_type_alias(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca %TypeParameterParseResult
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca double
  %l7 = alloca %CaptureResult
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l1
  %t1 = load double, double* %l1
  %t2 = load double, double* %l1
  %t3 = call i8* @identifier_text(i8* null)
  store i8* %t3, i8** %l2
  %t4 = load double, double* %l1
  %t5 = alloca [1 x double]
  %t6 = getelementptr [1 x double], [1 x double]* %t5, i32 0, i32 0
  %t7 = getelementptr double, double* %t6, i64 0
  store double %t4, double* %t7
  %t8 = alloca { double*, i64 }
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 0
  store double* %t6, double** %t9
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 1
  store i64 1, i64* %t10
  %t11 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t11, double* %l3
  %t12 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %parser)
  store %TypeParameterParseResult %t12, %TypeParameterParseResult* %l4
  %t13 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t14 = extractvalue %TypeParameterParseResult %t13, 1
  store { i8**, i64 }* %t14, { i8**, i64 }** %l5
  %t15 = call double @parser_peek_raw(%Parser %parser)
  store double %t15, double* %l6
  %t17 = load double, double* %l6
  %t18 = call %Parser @skip_trivia(%Parser %parser)
  %s19 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.19, i32 0, i32 0
  %t20 = alloca [1 x i8*]
  %t21 = getelementptr [1 x i8*], [1 x i8*]* %t20, i32 0, i32 0
  %t22 = getelementptr i8*, i8** %t21, i64 0
  store i8* %s19, i8** %t22
  %t23 = alloca { i8**, i64 }
  %t24 = getelementptr { i8**, i64 }, { i8**, i64 }* %t23, i32 0, i32 0
  store i8** %t21, i8*** %t24
  %t25 = getelementptr { i8**, i64 }, { i8**, i64 }* %t23, i32 0, i32 1
  store i64 1, i64* %t25
  %t26 = call %CaptureResult @collect_until(%Parser %t18, { i8**, i64 }* %t23)
  store %CaptureResult %t26, %CaptureResult* %l7
  %t27 = load %CaptureResult, %CaptureResult* %l7
  %t28 = extractvalue %CaptureResult %t27, 1
  %t29 = call i8* @tokens_to_text({ i8**, i64 }* %t28)
  %t30 = call i8* @trim_text(i8* %t29)
  store i8* %t30, i8** %l8
  %t31 = load i8*, i8** %l8
  store double 0.0, double* %l9
  %t33 = call double @parser_peek_raw(%Parser %parser)
  store double 0.0, double* %l10
  %t34 = insertvalue %StatementParseResult undef, i8* null, 0
  %t35 = load double, double* %l10
  %t36 = insertvalue %StatementParseResult %t34, i8* null, 1
  ret %StatementParseResult %t36
}

define %StatementParseResult @parse_interface(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca %TypeParameterParseResult
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca double
  %l8 = alloca %Parser
  %l9 = alloca %DecoratorParseResult
  %l10 = alloca { i8**, i64 }*
  %l11 = alloca %InterfaceMemberParseResult
  %l12 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l1
  %t1 = load double, double* %l1
  %t2 = load double, double* %l1
  %t3 = call i8* @identifier_text(i8* null)
  store i8* %t3, i8** %l2
  %t4 = load double, double* %l1
  %t5 = alloca [1 x double]
  %t6 = getelementptr [1 x double], [1 x double]* %t5, i32 0, i32 0
  %t7 = getelementptr double, double* %t6, i64 0
  store double %t4, double* %t7
  %t8 = alloca { double*, i64 }
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 0
  store double* %t6, double** %t9
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 1
  store i64 1, i64* %t10
  %t11 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t11, double* %l3
  %t12 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %parser)
  store %TypeParameterParseResult %t12, %TypeParameterParseResult* %l4
  %t13 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t14 = extractvalue %TypeParameterParseResult %t13, 1
  store { i8**, i64 }* %t14, { i8**, i64 }** %l5
  %t15 = alloca [0 x double]
  %t16 = getelementptr [0 x double], [0 x double]* %t15, i32 0, i32 0
  %t17 = alloca { double*, i64 }
  %t18 = getelementptr { double*, i64 }, { double*, i64 }* %t17, i32 0, i32 0
  store double* %t16, double** %t18
  %t19 = getelementptr { double*, i64 }, { double*, i64 }* %t17, i32 0, i32 1
  store i64 0, i64* %t19
  store { i8**, i64 }* null, { i8**, i64 }** %l6
  %t20 = load %Parser, %Parser* %l0
  %t21 = load double, double* %l1
  %t22 = load i8*, i8** %l2
  %t23 = load double, double* %l3
  %t24 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l6
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t27 = call double @parser_peek_raw(%Parser %parser)
  store double %t27, double* %l7
  %t29 = load double, double* %l7
  %t30 = load double, double* %l7
  store %Parser %parser, %Parser* %l8
  %t31 = call %DecoratorParseResult @parse_decorators(%Parser %parser)
  store %DecoratorParseResult %t31, %DecoratorParseResult* %l9
  %t32 = load %DecoratorParseResult, %DecoratorParseResult* %l9
  %t33 = extractvalue %DecoratorParseResult %t32, 1
  store { i8**, i64 }* %t33, { i8**, i64 }** %l10
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t35 = call %InterfaceMemberParseResult @parse_interface_member(%Parser %parser, { i8**, i64 }* %t34)
  store %InterfaceMemberParseResult %t35, %InterfaceMemberParseResult* %l11
  %t36 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l11
  %t37 = extractvalue %InterfaceMemberParseResult %t36, 2
  %t38 = load %Parser, %Parser* %l0
  %t39 = load double, double* %l1
  %t40 = load i8*, i8** %l2
  %t41 = load double, double* %l3
  %t42 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t45 = load double, double* %l7
  %t46 = load %Parser, %Parser* %l8
  %t47 = load %DecoratorParseResult, %DecoratorParseResult* %l9
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t49 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l11
  br i1 %t37, label %then4, label %merge5
then4:
  %t50 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l11
  %t51 = extractvalue %InterfaceMemberParseResult %t50, 1
  br label %loop.latch2
merge5:
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l12
  %t52 = insertvalue %StatementParseResult undef, i8* null, 0
  %t53 = load double, double* %l12
  %t54 = insertvalue %StatementParseResult %t52, i8* null, 1
  ret %StatementParseResult %t54
}

define %StatementParseResult @parse_enum(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca %TypeParameterParseResult
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca double
  %l8 = alloca %EnumVariantParseResult
  %l9 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l1
  %t1 = load double, double* %l1
  %t2 = load double, double* %l1
  %t3 = call i8* @identifier_text(i8* null)
  store i8* %t3, i8** %l2
  %t4 = load double, double* %l1
  %t5 = alloca [1 x double]
  %t6 = getelementptr [1 x double], [1 x double]* %t5, i32 0, i32 0
  %t7 = getelementptr double, double* %t6, i64 0
  store double %t4, double* %t7
  %t8 = alloca { double*, i64 }
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 0
  store double* %t6, double** %t9
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 1
  store i64 1, i64* %t10
  %t11 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t11, double* %l3
  %t12 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %parser)
  store %TypeParameterParseResult %t12, %TypeParameterParseResult* %l4
  %t13 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t14 = extractvalue %TypeParameterParseResult %t13, 1
  store { i8**, i64 }* %t14, { i8**, i64 }** %l5
  %t15 = alloca [0 x double]
  %t16 = getelementptr [0 x double], [0 x double]* %t15, i32 0, i32 0
  %t17 = alloca { double*, i64 }
  %t18 = getelementptr { double*, i64 }, { double*, i64 }* %t17, i32 0, i32 0
  store double* %t16, double** %t18
  %t19 = getelementptr { double*, i64 }, { double*, i64 }* %t17, i32 0, i32 1
  store i64 0, i64* %t19
  store { i8**, i64 }* null, { i8**, i64 }** %l6
  %t20 = load %Parser, %Parser* %l0
  %t21 = load double, double* %l1
  %t22 = load i8*, i8** %l2
  %t23 = load double, double* %l3
  %t24 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l6
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t27 = call double @parser_peek_raw(%Parser %parser)
  store double %t27, double* %l7
  %t29 = load double, double* %l7
  %t30 = load double, double* %l7
  %t31 = call %EnumVariantParseResult @parse_enum_variant(%Parser %parser)
  store %EnumVariantParseResult %t31, %EnumVariantParseResult* %l8
  %t32 = load %EnumVariantParseResult, %EnumVariantParseResult* %l8
  %t33 = extractvalue %EnumVariantParseResult %t32, 2
  %t34 = load %Parser, %Parser* %l0
  %t35 = load double, double* %l1
  %t36 = load i8*, i8** %l2
  %t37 = load double, double* %l3
  %t38 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t41 = load double, double* %l7
  %t42 = load %EnumVariantParseResult, %EnumVariantParseResult* %l8
  br i1 %t33, label %then4, label %merge5
then4:
  %t43 = load %EnumVariantParseResult, %EnumVariantParseResult* %l8
  %t44 = extractvalue %EnumVariantParseResult %t43, 1
  br label %loop.latch2
merge5:
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l9
  %t45 = insertvalue %StatementParseResult undef, i8* null, 0
  %t46 = load double, double* %l9
  %t47 = insertvalue %StatementParseResult %t45, i8* null, 1
  ret %StatementParseResult %t47
}

define %InterfaceMemberParseResult @parse_interface_member(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca i1
  %l3 = alloca double
  %l4 = alloca %Parser
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca %TypeParameterParseResult
  %l9 = alloca { i8**, i64 }*
  %l10 = alloca %ParameterListParseResult
  %l11 = alloca { i8**, i64 }*
  %l12 = alloca i8*
  %l13 = alloca double
  %l14 = alloca %EffectParseResult
  %l15 = alloca { i8**, i64 }*
  %l16 = alloca double
  %l17 = alloca double
  %l18 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  store i1 0, i1* %l2
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l3
  %t3 = load double, double* %l3
  %s4 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.4, i32 0, i32 0
  %t5 = call i1 @identifier_matches(i8* null, i8* %s4)
  %t6 = load %Parser, %Parser* %l0
  %t7 = load %Parser, %Parser* %l1
  %t8 = load i1, i1* %l2
  %t9 = load double, double* %l3
  br i1 %t5, label %then0, label %merge1
then0:
  %t10 = load %Parser, %Parser* %l1
  %t11 = call %Parser @parser_advance_raw(%Parser %t10)
  %t12 = call %Parser @skip_trivia(%Parser %t11)
  store %Parser %t12, %Parser* %l4
  %t13 = load %Parser, %Parser* %l4
  %t14 = call double @parser_peek_raw(%Parser %t13)
  %s15 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.15, i32 0, i32 0
  %t16 = call i1 @identifier_matches(i8* null, i8* %s15)
  %t17 = load %Parser, %Parser* %l0
  %t18 = load %Parser, %Parser* %l1
  %t19 = load i1, i1* %l2
  %t20 = load double, double* %l3
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
  %t32 = call double @parser_peek_raw(%Parser %t31)
  %s33 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.33, i32 0, i32 0
  %t34 = call double @identifier_matches(double %t32, i8* %s33)
  %t35 = fcmp one double %t34, 0.0
  %t36 = load %Parser, %Parser* %l0
  %t37 = load %Parser, %Parser* %l1
  %t38 = load i1, i1* %l2
  %t39 = load double, double* %l3
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
  %t50 = call double @parser_peek_raw(%Parser %t49)
  store double %t50, double* %l5
  %t51 = load double, double* %l5
  %t52 = load double, double* %l5
  %t53 = call i8* @identifier_text(i8* null)
  store i8* %t53, i8** %l6
  %t54 = load double, double* %l5
  %t55 = alloca [1 x double]
  %t56 = getelementptr [1 x double], [1 x double]* %t55, i32 0, i32 0
  %t57 = getelementptr double, double* %t56, i64 0
  store double %t54, double* %t57
  %t58 = alloca { double*, i64 }
  %t59 = getelementptr { double*, i64 }, { double*, i64 }* %t58, i32 0, i32 0
  store double* %t56, double** %t59
  %t60 = getelementptr { double*, i64 }, { double*, i64 }* %t58, i32 0, i32 1
  store i64 1, i64* %t60
  %t61 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t61, double* %l7
  %t62 = load %Parser, %Parser* %l1
  %t63 = call %Parser @parser_advance_raw(%Parser %t62)
  store %Parser %t63, %Parser* %l1
  %t64 = load %Parser, %Parser* %l1
  %t65 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %t64)
  store %TypeParameterParseResult %t65, %TypeParameterParseResult* %l8
  %t66 = load %TypeParameterParseResult, %TypeParameterParseResult* %l8
  %t67 = extractvalue %TypeParameterParseResult %t66, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t68 = load %TypeParameterParseResult, %TypeParameterParseResult* %l8
  %t69 = extractvalue %TypeParameterParseResult %t68, 1
  store { i8**, i64 }* %t69, { i8**, i64 }** %l9
  %t70 = load %Parser, %Parser* %l1
  %t71 = call %Parser @skip_trivia(%Parser %t70)
  store %Parser %t71, %Parser* %l1
  %t72 = load %Parser, %Parser* %l1
  %s73 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.73, i32 0, i32 0
  %t74 = call %Parser @consume_symbol(%Parser %t72, i8* %s73)
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
  %t84 = call double @parser_peek_raw(%Parser %t83)
  store double %t84, double* %l13
  %t87 = load double, double* %l13
  %t88 = load %Parser, %Parser* %l1
  %t89 = call %EffectParseResult @parse_effect_list(%Parser %t88)
  store %EffectParseResult %t89, %EffectParseResult* %l14
  %t90 = load %EffectParseResult, %EffectParseResult* %l14
  %t91 = extractvalue %EffectParseResult %t90, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t92 = load %EffectParseResult, %EffectParseResult* %l14
  %t93 = extractvalue %EffectParseResult %t92, 1
  store { i8**, i64 }* %t93, { i8**, i64 }** %l15
  %t94 = call double @evaluate_decorators({ i8**, i64 }* %decorators)
  store double %t94, double* %l16
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t96 = load double, double* %l16
  %t97 = call double @infer_effects({ i8**, i64 }* %t95, double %t96)
  store double %t97, double* %l17
  %t98 = load %Parser, %Parser* %l1
  %t99 = call %Parser @skip_trivia(%Parser %t98)
  store %Parser %t99, %Parser* %l1
  %t100 = load %Parser, %Parser* %l1
  %t101 = extractvalue %Parser %t100, 1
  %t102 = load %Parser, %Parser* %l1
  %t103 = extractvalue %Parser %t102, 0
  store double 0.0, double* %l18
  %t104 = load %Parser, %Parser* %l1
  %t105 = insertvalue %InterfaceMemberParseResult undef, i8* null, 0
  %t106 = load double, double* %l18
  %t107 = insertvalue %InterfaceMemberParseResult %t105, i8* null, 1
  %t108 = insertvalue %InterfaceMemberParseResult %t107, i1 1, 2
  ret %InterfaceMemberParseResult %t108
}

define %EnumVariantParseResult @parse_enum_variant(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l2
  %t3 = load double, double* %l2
  %t4 = load double, double* %l2
  %t5 = call i8* @identifier_text(i8* null)
  store i8* %t5, i8** %l3
  %t6 = load double, double* %l2
  %t7 = alloca [1 x double]
  %t8 = getelementptr [1 x double], [1 x double]* %t7, i32 0, i32 0
  %t9 = getelementptr double, double* %t8, i64 0
  store double %t6, double* %t9
  %t10 = alloca { double*, i64 }
  %t11 = getelementptr { double*, i64 }, { double*, i64 }* %t10, i32 0, i32 0
  store double* %t8, double** %t11
  %t12 = getelementptr { double*, i64 }, { double*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t13, double* %l4
  %t14 = load %Parser, %Parser* %l1
  %t15 = call %Parser @parser_advance_raw(%Parser %t14)
  store %Parser %t15, %Parser* %l1
  %t16 = alloca [0 x double]
  %t17 = getelementptr [0 x double], [0 x double]* %t16, i32 0, i32 0
  %t18 = alloca { double*, i64 }
  %t19 = getelementptr { double*, i64 }, { double*, i64 }* %t18, i32 0, i32 0
  store double* %t17, double** %t19
  %t20 = getelementptr { double*, i64 }, { double*, i64 }* %t18, i32 0, i32 1
  store i64 0, i64* %t20
  store { i8**, i64 }* null, { i8**, i64 }** %l5
  %t21 = load %Parser, %Parser* %l1
  %t22 = call %Parser @skip_trivia(%Parser %t21)
  store %Parser %t22, %Parser* %l1
  %t23 = load %Parser, %Parser* %l1
  %t24 = call double @parser_peek_raw(%Parser %t23)
  store double %t24, double* %l6
  %t26 = load double, double* %l6
  %t27 = load %Parser, %Parser* %l1
  %t28 = call %Parser @skip_trivia(%Parser %t27)
  store %Parser %t28, %Parser* %l1
  %t29 = load %Parser, %Parser* %l1
  %t30 = call double @parser_peek_raw(%Parser %t29)
  store double %t30, double* %l7
  %t32 = load double, double* %l7
  store double 0.0, double* %l8
  %t33 = load %Parser, %Parser* %l1
  %t34 = insertvalue %EnumVariantParseResult undef, i8* null, 0
  %t35 = load double, double* %l8
  %t36 = insertvalue %EnumVariantParseResult %t34, i8* null, 1
  %t37 = insertvalue %EnumVariantParseResult %t36, i1 1, 2
  ret %EnumVariantParseResult %t37
}

define %StructFieldParseResult @parse_enum_variant_field(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca i1
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca double
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  store i1 0, i1* %l1
  %t1 = load %Parser, %Parser* %l0
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l2
  %t3 = load double, double* %l2
  store double %t3, double* %l3
  %t4 = load double, double* %l3
  %s5 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.5, i32 0, i32 0
  %t6 = call i1 @identifier_matches(i8* null, i8* %s5)
  %t7 = load %Parser, %Parser* %l0
  %t8 = load i1, i1* %l1
  %t9 = load double, double* %l2
  %t10 = load double, double* %l3
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
  %t16 = call double @parser_peek_raw(%Parser %t15)
  store double %t16, double* %l3
  br label %merge1
merge1:
  %t17 = phi %Parser [ %t12, %then0 ], [ %t7, %entry ]
  %t18 = phi i1 [ 1, %then0 ], [ %t8, %entry ]
  %t19 = phi %Parser [ %t14, %then0 ], [ %t7, %entry ]
  %t20 = phi double [ %t16, %then0 ], [ %t10, %entry ]
  store %Parser %t17, %Parser* %l0
  store i1 %t18, i1* %l1
  store %Parser %t19, %Parser* %l0
  store double %t20, double* %l3
  %t21 = load double, double* %l3
  %t22 = load double, double* %l3
  %t23 = call i8* @identifier_text(i8* null)
  store i8* %t23, i8** %l4
  %t24 = load double, double* %l3
  %t25 = alloca [1 x double]
  %t26 = getelementptr [1 x double], [1 x double]* %t25, i32 0, i32 0
  %t27 = getelementptr double, double* %t26, i64 0
  store double %t24, double* %t27
  %t28 = alloca { double*, i64 }
  %t29 = getelementptr { double*, i64 }, { double*, i64 }* %t28, i32 0, i32 0
  store double* %t26, double** %t29
  %t30 = getelementptr { double*, i64 }, { double*, i64 }* %t28, i32 0, i32 1
  store i64 1, i64* %t30
  %t31 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t31, double* %l5
  %t32 = load %Parser, %Parser* %l0
  %t33 = call %Parser @parser_advance_raw(%Parser %t32)
  store %Parser %t33, %Parser* %l0
  %t34 = load %Parser, %Parser* %l0
  %t35 = call %Parser @skip_trivia(%Parser %t34)
  store %Parser %t35, %Parser* %l0
  %t36 = load %Parser, %Parser* %l0
  %t37 = call double @parser_peek_raw(%Parser %t36)
  store double %t37, double* %l6
  %t38 = load double, double* %l6
  store double 0.0, double* %l7
  %t39 = load %Parser, %Parser* %l0
  %t40 = call %Parser @parser_advance_raw(%Parser %t39)
  store %Parser %t40, %Parser* %l0
  %t41 = load %Parser, %Parser* %l0
  %t42 = call %Parser @skip_trivia(%Parser %t41)
  %s43 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.43, i32 0, i32 0
  store double 0.0, double* %l8
  %t44 = load double, double* %l8
  %t45 = load double, double* %l8
  store double 0.0, double* %l9
  %t46 = load %Parser, %Parser* %l0
  %t47 = load i1, i1* %l1
  %t48 = load double, double* %l2
  %t49 = load double, double* %l3
  %t50 = load i8*, i8** %l4
  %t51 = load double, double* %l5
  %t52 = load double, double* %l6
  %t53 = load double, double* %l7
  %t54 = load double, double* %l8
  %t55 = load double, double* %l9
  br label %loop.header2
loop.header2:
  %t64 = phi double [ %t55, %entry ], [ %t63, %loop.latch4 ]
  store double %t64, double* %l9
  br label %loop.body3
loop.body3:
  %t56 = load double, double* %l9
  store double 0.0, double* %l10
  %t57 = load double, double* %l10
  %s58 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.58, i32 0, i32 0
  %t59 = load double, double* %l9
  %t60 = load double, double* %l9
  store double 0.0, double* %l11
  %t61 = load double, double* %l11
  %t62 = call i8* @trim_text(i8* null)
  store double 0.0, double* %l9
  br label %loop.latch4
loop.latch4:
  %t63 = load double, double* %l9
  br label %loop.header2
afterloop5:
  %t65 = load double, double* %l9
  %t66 = load %Parser, %Parser* %l0
  %t67 = call %Parser @skip_trivia(%Parser %t66)
  store %Parser %t67, %Parser* %l0
  %t68 = load %Parser, %Parser* %l0
  %t69 = call double @parser_peek_raw(%Parser %t68)
  store double %t69, double* %l12
  %t70 = load double, double* %l12
  store double 0.0, double* %l13
  %t71 = load %Parser, %Parser* %l0
  %t72 = insertvalue %StructFieldParseResult undef, i8* null, 0
  %t73 = load double, double* %l13
  %t74 = insertvalue %StructFieldParseResult %t72, i8* null, 1
  %t75 = insertvalue %StructFieldParseResult %t74, i1 1, 2
  ret %StructFieldParseResult %t75
}

define %Parser @skip_trailing_comma(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l1
  %t4 = load double, double* %l1
  %t5 = load %Parser, %Parser* %l0
  ret %Parser %t5
}

define %StatementParseResult @parse_model(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca %EffectParseResult
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca { i8**, i64 }*
  %l10 = alloca double
  %l11 = alloca %Parser
  %l12 = alloca %ModelPropertyParseResult
  %l13 = alloca double
  %l14 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l1
  %t1 = load double, double* %l1
  %t2 = call i8* @identifier_text(i8* null)
  store i8* %t2, i8** %l2
  %t3 = load double, double* %l1
  %t4 = alloca [1 x double]
  %t5 = getelementptr [1 x double], [1 x double]* %t4, i32 0, i32 0
  %t6 = getelementptr double, double* %t5, i64 0
  store double %t3, double* %t6
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t5, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 1, i64* %t9
  %t10 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t10, double* %l3
  %t11 = call %Parser @skip_trivia(%Parser %parser)
  store double 0.0, double* %l4
  %t12 = load double, double* %l4
  store double 0.0, double* %l5
  %t13 = load double, double* %l5
  store double 0.0, double* %l6
  %t14 = call %EffectParseResult @parse_effect_list(%Parser %parser)
  store %EffectParseResult %t14, %EffectParseResult* %l7
  %t15 = load %EffectParseResult, %EffectParseResult* %l7
  %t16 = extractvalue %EffectParseResult %t15, 1
  store { i8**, i64 }* %t16, { i8**, i64 }** %l8
  %t17 = alloca [0 x double]
  %t18 = getelementptr [0 x double], [0 x double]* %t17, i32 0, i32 0
  %t19 = alloca { double*, i64 }
  %t20 = getelementptr { double*, i64 }, { double*, i64 }* %t19, i32 0, i32 0
  store double* %t18, double** %t20
  %t21 = getelementptr { double*, i64 }, { double*, i64 }* %t19, i32 0, i32 1
  store i64 0, i64* %t21
  store { i8**, i64 }* null, { i8**, i64 }** %l9
  %t22 = load %Parser, %Parser* %l0
  %t23 = load double, double* %l1
  %t24 = load i8*, i8** %l2
  %t25 = load double, double* %l3
  %t26 = load double, double* %l4
  %t27 = load double, double* %l5
  %t28 = load double, double* %l6
  %t29 = load %EffectParseResult, %EffectParseResult* %l7
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l9
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t32 = call double @parser_peek_raw(%Parser %parser)
  store double %t32, double* %l10
  %t34 = load double, double* %l10
  %t35 = load double, double* %l10
  store %Parser %parser, %Parser* %l11
  %t36 = call %ModelPropertyParseResult @parse_model_property(%Parser %parser)
  store %ModelPropertyParseResult %t36, %ModelPropertyParseResult* %l12
  %t38 = load %ModelPropertyParseResult, %ModelPropertyParseResult* %l12
  %t39 = extractvalue %ModelPropertyParseResult %t38, 2
  br label %logical_and_entry_37

logical_and_entry_37:
  br i1 %t39, label %logical_and_right_37, label %logical_and_merge_37

logical_and_right_37:
  %t40 = load %ModelPropertyParseResult, %ModelPropertyParseResult* %l12
  %t41 = extractvalue %ModelPropertyParseResult %t40, 1
  %t42 = call double @parser_peek_raw(%Parser %parser)
  store double %t42, double* %l13
  %t44 = load double, double* %l13
  %t45 = load double, double* %l13
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l14
  %t46 = insertvalue %StatementParseResult undef, i8* null, 0
  %t47 = load double, double* %l14
  %t48 = insertvalue %StatementParseResult %t46, i8* null, 1
  ret %StatementParseResult %t48
}

define %StatementParseResult @parse_pipeline(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca %TypeParameterParseResult
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca %ParameterListParseResult
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca i8*
  %l8 = alloca double
  %l9 = alloca %EffectParseResult
  %l10 = alloca { i8**, i64 }*
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca %BlockParseResult
  %l14 = alloca i8*
  %l15 = alloca double
  %l16 = alloca double
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = call i8* @identifier_text(i8* null)
  store i8* %t2, i8** %l1
  %t3 = load double, double* %l0
  %t4 = alloca [1 x double]
  %t5 = getelementptr [1 x double], [1 x double]* %t4, i32 0, i32 0
  %t6 = getelementptr double, double* %t5, i64 0
  store double %t3, double* %t6
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t5, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 1, i64* %t9
  %t10 = call double @source_span_from_tokens({ i8**, i64 }* null)
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
  %t17 = call double @parser_peek_raw(%Parser %parser)
  store double %t17, double* %l8
  %t20 = load double, double* %l8
  %t21 = call %EffectParseResult @parse_effect_list(%Parser %parser)
  store %EffectParseResult %t21, %EffectParseResult* %l9
  %t22 = load %EffectParseResult, %EffectParseResult* %l9
  %t23 = extractvalue %EffectParseResult %t22, 1
  store { i8**, i64 }* %t23, { i8**, i64 }** %l10
  %t24 = call double @evaluate_decorators({ i8**, i64 }* %decorators)
  store double %t24, double* %l11
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t26 = load double, double* %l11
  %t27 = call double @infer_effects({ i8**, i64 }* %t25, double %t26)
  store double %t27, double* %l12
  %t28 = call %BlockParseResult @parse_block(%Parser %parser)
  store %BlockParseResult %t28, %BlockParseResult* %l13
  %t29 = load %BlockParseResult, %BlockParseResult* %l13
  %t30 = extractvalue %BlockParseResult %t29, 1
  store i8* %t30, i8** %l14
  store double 0.0, double* %l15
  store double 0.0, double* %l16
  %t31 = insertvalue %StatementParseResult undef, i8* null, 0
  %t32 = load double, double* %l16
  %t33 = insertvalue %StatementParseResult %t31, i8* null, 1
  ret %StatementParseResult %t33
}

define %StatementParseResult @parse_tool(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca %ParameterListParseResult
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca %EffectParseResult
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca %BlockParseResult
  %l12 = alloca i8*
  %l13 = alloca double
  %l14 = alloca double
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = call i8* @identifier_text(i8* null)
  store i8* %t2, i8** %l1
  %t3 = load double, double* %l0
  %t4 = alloca [1 x double]
  %t5 = getelementptr [1 x double], [1 x double]* %t4, i32 0, i32 0
  %t6 = getelementptr double, double* %t5, i64 0
  store double %t3, double* %t6
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t5, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 1, i64* %t9
  %t10 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t10, double* %l2
  %t11 = call %ParameterListParseResult @parse_parameter_list(%Parser %parser)
  store %ParameterListParseResult %t11, %ParameterListParseResult* %l3
  %t12 = load %ParameterListParseResult, %ParameterListParseResult* %l3
  %t13 = extractvalue %ParameterListParseResult %t12, 1
  store { i8**, i64 }* %t13, { i8**, i64 }** %l4
  store i8* null, i8** %l5
  %t14 = call double @parser_peek_raw(%Parser %parser)
  store double %t14, double* %l6
  %t17 = load double, double* %l6
  %t18 = call %EffectParseResult @parse_effect_list(%Parser %parser)
  store %EffectParseResult %t18, %EffectParseResult* %l7
  %t19 = load %EffectParseResult, %EffectParseResult* %l7
  %t20 = extractvalue %EffectParseResult %t19, 1
  store { i8**, i64 }* %t20, { i8**, i64 }** %l8
  %t21 = call double @evaluate_decorators({ i8**, i64 }* %decorators)
  store double %t21, double* %l9
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t23 = load double, double* %l9
  %t24 = call double @infer_effects({ i8**, i64 }* %t22, double %t23)
  store double %t24, double* %l10
  %t25 = call %BlockParseResult @parse_block(%Parser %parser)
  store %BlockParseResult %t25, %BlockParseResult* %l11
  %t26 = load %BlockParseResult, %BlockParseResult* %l11
  %t27 = extractvalue %BlockParseResult %t26, 1
  store i8* %t27, i8** %l12
  store double 0.0, double* %l13
  store double 0.0, double* %l14
  %t28 = insertvalue %StatementParseResult undef, i8* null, 0
  %t29 = load double, double* %l14
  %t30 = insertvalue %StatementParseResult %t28, i8* null, 1
  ret %StatementParseResult %t30
}

define %StatementParseResult @parse_test(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca double
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
  store double 0.0, double* %l1
  %t1 = load double, double* %l1
  store double 0.0, double* %l2
  %t2 = load double, double* %l2
  %t3 = load double, double* %l1
  store double 0.0, double* %l3
  %t4 = load double, double* %l2
  %t5 = call i8* @normalize_test_name(i8* null)
  store i8* %t5, i8** %l4
  %t6 = call %EffectParseResult @parse_effect_list(%Parser %parser)
  store %EffectParseResult %t6, %EffectParseResult* %l5
  %t7 = load %EffectParseResult, %EffectParseResult* %l5
  %t8 = extractvalue %EffectParseResult %t7, 1
  store { i8**, i64 }* %t8, { i8**, i64 }** %l6
  %t9 = call double @evaluate_decorators({ i8**, i64 }* %decorators)
  store double %t9, double* %l7
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t11 = load double, double* %l7
  %t12 = call double @infer_effects({ i8**, i64 }* %t10, double %t11)
  store double %t12, double* %l8
  %t13 = call %BlockParseResult @parse_block(%Parser %parser)
  store %BlockParseResult %t13, %BlockParseResult* %l9
  %t14 = load %BlockParseResult, %BlockParseResult* %l9
  %t15 = extractvalue %BlockParseResult %t14, 1
  store i8* %t15, i8** %l10
  store double 0.0, double* %l11
  %t16 = insertvalue %StatementParseResult undef, i8* null, 0
  %t17 = load double, double* %l11
  %t18 = insertvalue %StatementParseResult %t16, i8* null, 1
  ret %StatementParseResult %t18
}

define %StatementParseResult @parse_function(%Parser %parser, i1 %starts_with_async, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca i1
  %l1 = alloca double
  %l2 = alloca %Parser
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca %TypeParameterParseResult
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca %ParameterListParseResult
  %l10 = alloca { i8**, i64 }*
  %l11 = alloca i8*
  %l12 = alloca double
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
  %t1 = call double @parser_peek_raw(%Parser %parser)
  store double %t1, double* %l1
  %t2 = load double, double* %l1
  %s3 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(i8* null, i8* %s3)
  %t5 = load i1, i1* %l0
  %t6 = load double, double* %l1
  br i1 %t4, label %then3, label %merge4
then3:
  %t7 = call %Parser @parser_advance_raw(%Parser %parser)
  %t8 = call %Parser @skip_trivia(%Parser %t7)
  store %Parser %t8, %Parser* %l2
  %t9 = load %Parser, %Parser* %l2
  %t10 = call double @parser_peek_raw(%Parser %t9)
  store double %t10, double* %l3
  %t11 = load double, double* %l3
  %s12 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.12, i32 0, i32 0
  %t13 = call i1 @identifier_matches(i8* null, i8* %s12)
  %t14 = load i1, i1* %l0
  %t15 = load double, double* %l1
  %t16 = load %Parser, %Parser* %l2
  %t17 = load double, double* %l3
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
  %t21 = call double @parser_peek_raw(%Parser %parser)
  store double %t21, double* %l4
  %t22 = load double, double* %l4
  %t23 = call i8* @identifier_text(i8* null)
  store i8* %t23, i8** %l5
  %t24 = load double, double* %l4
  %t25 = alloca [1 x double]
  %t26 = getelementptr [1 x double], [1 x double]* %t25, i32 0, i32 0
  %t27 = getelementptr double, double* %t26, i64 0
  store double %t24, double* %t27
  %t28 = alloca { double*, i64 }
  %t29 = getelementptr { double*, i64 }, { double*, i64 }* %t28, i32 0, i32 0
  store double* %t26, double** %t29
  %t30 = getelementptr { double*, i64 }, { double*, i64 }* %t28, i32 0, i32 1
  store i64 1, i64* %t30
  %t31 = call double @source_span_from_tokens({ i8**, i64 }* null)
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
  %t38 = call double @parser_peek_raw(%Parser %parser)
  store double %t38, double* %l12
  %t41 = load double, double* %l12
  %t42 = call %EffectParseResult @parse_effect_list(%Parser %parser)
  store %EffectParseResult %t42, %EffectParseResult* %l13
  %t43 = load %EffectParseResult, %EffectParseResult* %l13
  %t44 = extractvalue %EffectParseResult %t43, 1
  store { i8**, i64 }* %t44, { i8**, i64 }** %l14
  %t45 = call double @evaluate_decorators({ i8**, i64 }* %decorators)
  store double %t45, double* %l15
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t47 = load double, double* %l15
  %t48 = call double @infer_effects({ i8**, i64 }* %t46, double %t47)
  store double %t48, double* %l16
  %t49 = call %BlockParseResult @parse_block(%Parser %parser)
  store %BlockParseResult %t49, %BlockParseResult* %l17
  %t50 = load %BlockParseResult, %BlockParseResult* %l17
  %t51 = extractvalue %BlockParseResult %t50, 1
  store i8* %t51, i8** %l18
  store double 0.0, double* %l19
  store double 0.0, double* %l20
  %t52 = insertvalue %StatementParseResult undef, i8* null, 0
  %t53 = load double, double* %l20
  %t54 = insertvalue %StatementParseResult %t52, i8* null, 1
  ret %StatementParseResult %t54
}

define %ParameterListParseResult @parse_parameter_list(%Parser %parser) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %ParameterParseResult
  %l3 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = call double @parser_peek_raw(%Parser %parser)
  store double %t5, double* %l1
  %t6 = load double, double* %l1
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t20 = phi { i8**, i64 }* [ %t7, %entry ], [ %t19, %loop.latch2 ]
  store { i8**, i64 }* %t20, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t9 = call %ParameterParseResult @parse_single_parameter(%Parser %parser)
  store %ParameterParseResult %t9, %ParameterParseResult* %l2
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load %ParameterParseResult, %ParameterParseResult* %l2
  %t12 = extractvalue %ParameterParseResult %t11, 1
  %t13 = call { i8**, i64 }* @append_parameter({ i8**, i64 }* %t10, i8* %t12)
  store { i8**, i64 }* %t13, { i8**, i64 }** %l0
  %t14 = call double @parser_peek_raw(%Parser %parser)
  store double %t14, double* %l3
  %t16 = load double, double* %l3
  %t17 = load double, double* %l3
  %t18 = load double, double* %l3
  br label %loop.latch2
loop.latch2:
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t21 = insertvalue %ParameterListParseResult undef, i8* null, 0
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = insertvalue %ParameterListParseResult %t21, { i8**, i64 }* %t22, 1
  ret %ParameterListParseResult %t23
}

define %StructFieldParseResult @parse_struct_field(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca i1
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca %CaptureResult
  %l9 = alloca i8*
  %l10 = alloca double
  %l11 = alloca double
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  store i1 0, i1* %l1
  %t1 = load %Parser, %Parser* %l0
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l2
  %t3 = load double, double* %l2
  store double %t3, double* %l3
  %t4 = load double, double* %l3
  %s5 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.5, i32 0, i32 0
  %t6 = call i1 @identifier_matches(i8* null, i8* %s5)
  %t7 = load %Parser, %Parser* %l0
  %t8 = load i1, i1* %l1
  %t9 = load double, double* %l2
  %t10 = load double, double* %l3
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
  %t16 = call double @parser_peek_raw(%Parser %t15)
  store double %t16, double* %l3
  br label %merge1
merge1:
  %t17 = phi %Parser [ %t12, %then0 ], [ %t7, %entry ]
  %t18 = phi i1 [ 1, %then0 ], [ %t8, %entry ]
  %t19 = phi %Parser [ %t14, %then0 ], [ %t7, %entry ]
  %t20 = phi double [ %t16, %then0 ], [ %t10, %entry ]
  store %Parser %t17, %Parser* %l0
  store i1 %t18, i1* %l1
  store %Parser %t19, %Parser* %l0
  store double %t20, double* %l3
  %t21 = load double, double* %l3
  %t22 = load double, double* %l3
  %t23 = call i8* @identifier_text(i8* null)
  store i8* %t23, i8** %l4
  %t24 = load double, double* %l3
  %t25 = alloca [1 x double]
  %t26 = getelementptr [1 x double], [1 x double]* %t25, i32 0, i32 0
  %t27 = getelementptr double, double* %t26, i64 0
  store double %t24, double* %t27
  %t28 = alloca { double*, i64 }
  %t29 = getelementptr { double*, i64 }, { double*, i64 }* %t28, i32 0, i32 0
  store double* %t26, double** %t29
  %t30 = getelementptr { double*, i64 }, { double*, i64 }* %t28, i32 0, i32 1
  store i64 1, i64* %t30
  %t31 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t31, double* %l5
  %t32 = load %Parser, %Parser* %l0
  %t33 = call %Parser @parser_advance_raw(%Parser %t32)
  store %Parser %t33, %Parser* %l0
  %t34 = load %Parser, %Parser* %l0
  %t35 = call %Parser @skip_trivia(%Parser %t34)
  store %Parser %t35, %Parser* %l0
  %t36 = load %Parser, %Parser* %l0
  %t37 = call double @parser_peek_raw(%Parser %t36)
  store double %t37, double* %l6
  %t38 = load double, double* %l6
  store double 0.0, double* %l7
  %t39 = load %Parser, %Parser* %l0
  %t40 = call %Parser @parser_advance_raw(%Parser %t39)
  store %Parser %t40, %Parser* %l0
  %t41 = load %Parser, %Parser* %l0
  %t42 = call %Parser @skip_trivia(%Parser %t41)
  %s43 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.43, i32 0, i32 0
  %t44 = alloca [1 x i8*]
  %t45 = getelementptr [1 x i8*], [1 x i8*]* %t44, i32 0, i32 0
  %t46 = getelementptr i8*, i8** %t45, i64 0
  store i8* %s43, i8** %t46
  %t47 = alloca { i8**, i64 }
  %t48 = getelementptr { i8**, i64 }, { i8**, i64 }* %t47, i32 0, i32 0
  store i8** %t45, i8*** %t48
  %t49 = getelementptr { i8**, i64 }, { i8**, i64 }* %t47, i32 0, i32 1
  store i64 1, i64* %t49
  %t50 = call %CaptureResult @collect_until(%Parser %t42, { i8**, i64 }* %t47)
  store %CaptureResult %t50, %CaptureResult* %l8
  %t51 = load %CaptureResult, %CaptureResult* %l8
  %t52 = extractvalue %CaptureResult %t51, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t53 = load %CaptureResult, %CaptureResult* %l8
  %t54 = extractvalue %CaptureResult %t53, 1
  %t55 = call i8* @tokens_to_text({ i8**, i64 }* %t54)
  %t56 = call i8* @trim_text(i8* %t55)
  store i8* %t56, i8** %l9
  %t57 = load i8*, i8** %l9
  %t58 = load %Parser, %Parser* %l0
  %t59 = call %Parser @skip_trivia(%Parser %t58)
  store %Parser %t59, %Parser* %l0
  %t60 = load %Parser, %Parser* %l0
  %t61 = call double @parser_peek_raw(%Parser %t60)
  store double %t61, double* %l10
  %t63 = load double, double* %l10
  %t64 = load %Parser, %Parser* %l0
  %t65 = call %Parser @parser_advance_raw(%Parser %t64)
  store %Parser %t65, %Parser* %l0
  store double 0.0, double* %l11
  %t66 = load %Parser, %Parser* %l0
  %t67 = insertvalue %StructFieldParseResult undef, i8* null, 0
  %t68 = load double, double* %l11
  %t69 = insertvalue %StructFieldParseResult %t67, i8* null, 1
  %t70 = insertvalue %StructFieldParseResult %t69, i1 1, 2
  ret %StructFieldParseResult %t70
}

define %ModelPropertyParseResult @parse_model_property(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca %CaptureResult
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l1
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  %t5 = call i8* @identifier_text(i8* null)
  store i8* %t5, i8** %l2
  %t6 = load %Parser, %Parser* %l0
  %t7 = call %Parser @parser_advance_raw(%Parser %t6)
  store %Parser %t7, %Parser* %l0
  %t8 = load %Parser, %Parser* %l0
  %t9 = call %Parser @skip_trivia(%Parser %t8)
  store %Parser %t9, %Parser* %l0
  %t10 = load %Parser, %Parser* %l0
  %t11 = call double @parser_peek_raw(%Parser %t10)
  store double %t11, double* %l3
  %t13 = load double, double* %l3
  %t14 = load %Parser, %Parser* %l0
  %t15 = call %Parser @parser_advance_raw(%Parser %t14)
  store %Parser %t15, %Parser* %l0
  %t16 = load %Parser, %Parser* %l0
  %t17 = call %Parser @skip_trivia(%Parser %t16)
  %s18 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.18, i32 0, i32 0
  %t19 = alloca [1 x i8*]
  %t20 = getelementptr [1 x i8*], [1 x i8*]* %t19, i32 0, i32 0
  %t21 = getelementptr i8*, i8** %t20, i64 0
  store i8* %s18, i8** %t21
  %t22 = alloca { i8**, i64 }
  %t23 = getelementptr { i8**, i64 }, { i8**, i64 }* %t22, i32 0, i32 0
  store i8** %t20, i8*** %t23
  %t24 = getelementptr { i8**, i64 }, { i8**, i64 }* %t22, i32 0, i32 1
  store i64 1, i64* %t24
  %t25 = call %CaptureResult @collect_until(%Parser %t17, { i8**, i64 }* %t22)
  store %CaptureResult %t25, %CaptureResult* %l4
  %t26 = load %CaptureResult, %CaptureResult* %l4
  %t27 = extractvalue %CaptureResult %t26, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t28 = load %CaptureResult, %CaptureResult* %l4
  %t29 = extractvalue %CaptureResult %t28, 1
  %t30 = call double @expression_from_tokens({ i8**, i64 }* %t29)
  store double %t30, double* %l5
  %t31 = load %Parser, %Parser* %l0
  %t32 = call %Parser @skip_trivia(%Parser %t31)
  store %Parser %t32, %Parser* %l0
  %t33 = load %Parser, %Parser* %l0
  %t34 = call double @parser_peek_raw(%Parser %t33)
  store double %t34, double* %l6
  %t36 = load double, double* %l6
  %t37 = load %Parser, %Parser* %l0
  %t38 = call %Parser @parser_advance_raw(%Parser %t37)
  store %Parser %t38, %Parser* %l0
  store double 0.0, double* %l7
  %t39 = load %Parser, %Parser* %l0
  %t40 = insertvalue %ModelPropertyParseResult undef, i8* null, 0
  %t41 = load double, double* %l7
  %t42 = insertvalue %ModelPropertyParseResult %t40, i8* null, 1
  %t43 = insertvalue %ModelPropertyParseResult %t42, i1 1, 2
  ret %ModelPropertyParseResult %t43
}

define %MethodParseResult @parse_struct_method(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca i1
  %l2 = alloca double
  %l3 = alloca %Parser
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca %TypeParameterParseResult
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca %ParameterListParseResult
  %l10 = alloca { i8**, i64 }*
  %l11 = alloca i8*
  %l12 = alloca double
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
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l2
  %t3 = load double, double* %l2
  %s4 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.4, i32 0, i32 0
  %t5 = call i1 @identifier_matches(i8* null, i8* %s4)
  %t6 = load %Parser, %Parser* %l0
  %t7 = load i1, i1* %l1
  %t8 = load double, double* %l2
  br i1 %t5, label %then0, label %merge1
then0:
  %t9 = load %Parser, %Parser* %l0
  %t10 = call %Parser @parser_advance_raw(%Parser %t9)
  %t11 = call %Parser @skip_trivia(%Parser %t10)
  store %Parser %t11, %Parser* %l3
  %t12 = load %Parser, %Parser* %l3
  %t13 = call double @parser_peek_raw(%Parser %t12)
  %s14 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.14, i32 0, i32 0
  %t15 = call i1 @identifier_matches(i8* null, i8* %s14)
  %t16 = load %Parser, %Parser* %l0
  %t17 = load i1, i1* %l1
  %t18 = load double, double* %l2
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
  %t30 = call double @parser_peek_raw(%Parser %t29)
  %s31 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.31, i32 0, i32 0
  %t32 = call double @identifier_matches(double %t30, i8* %s31)
  %t33 = fcmp one double %t32, 0.0
  %t34 = load %Parser, %Parser* %l0
  %t35 = load i1, i1* %l1
  %t36 = load double, double* %l2
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
  %t46 = call double @parser_peek_raw(%Parser %t45)
  store double %t46, double* %l4
  %t47 = load double, double* %l4
  %t48 = load double, double* %l4
  %t49 = call i8* @identifier_text(i8* null)
  store i8* %t49, i8** %l5
  %t50 = load double, double* %l4
  %t51 = alloca [1 x double]
  %t52 = getelementptr [1 x double], [1 x double]* %t51, i32 0, i32 0
  %t53 = getelementptr double, double* %t52, i64 0
  store double %t50, double* %t53
  %t54 = alloca { double*, i64 }
  %t55 = getelementptr { double*, i64 }, { double*, i64 }* %t54, i32 0, i32 0
  store double* %t52, double** %t55
  %t56 = getelementptr { double*, i64 }, { double*, i64 }* %t54, i32 0, i32 1
  store i64 1, i64* %t56
  %t57 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t57, double* %l6
  %t58 = load %Parser, %Parser* %l0
  %t59 = call %Parser @parser_advance_raw(%Parser %t58)
  store %Parser %t59, %Parser* %l0
  %t60 = load %Parser, %Parser* %l0
  %t61 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %t60)
  store %TypeParameterParseResult %t61, %TypeParameterParseResult* %l7
  %t62 = load %TypeParameterParseResult, %TypeParameterParseResult* %l7
  %t63 = extractvalue %TypeParameterParseResult %t62, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t64 = load %TypeParameterParseResult, %TypeParameterParseResult* %l7
  %t65 = extractvalue %TypeParameterParseResult %t64, 1
  store { i8**, i64 }* %t65, { i8**, i64 }** %l8
  %t66 = load %Parser, %Parser* %l0
  %t67 = call %Parser @skip_trivia(%Parser %t66)
  store %Parser %t67, %Parser* %l0
  %t68 = load %Parser, %Parser* %l0
  %s69 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.69, i32 0, i32 0
  %t70 = call %Parser @consume_symbol(%Parser %t68, i8* %s69)
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
  %t80 = call double @parser_peek_raw(%Parser %t79)
  store double %t80, double* %l12
  %t83 = load double, double* %l12
  %t84 = load %Parser, %Parser* %l0
  %t85 = call %EffectParseResult @parse_effect_list(%Parser %t84)
  store %EffectParseResult %t85, %EffectParseResult* %l13
  %t86 = load %EffectParseResult, %EffectParseResult* %l13
  %t87 = extractvalue %EffectParseResult %t86, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t88 = load %EffectParseResult, %EffectParseResult* %l13
  %t89 = extractvalue %EffectParseResult %t88, 1
  store { i8**, i64 }* %t89, { i8**, i64 }** %l14
  %t90 = call double @evaluate_decorators({ i8**, i64 }* %decorators)
  store double %t90, double* %l15
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t92 = load double, double* %l15
  %t93 = call double @infer_effects({ i8**, i64 }* %t91, double %t92)
  store double %t93, double* %l16
  %t94 = load %Parser, %Parser* %l0
  %t95 = call %BlockParseResult @parse_block(%Parser %t94)
  store %BlockParseResult %t95, %BlockParseResult* %l17
  %t96 = load %BlockParseResult, %BlockParseResult* %l17
  %t97 = extractvalue %BlockParseResult %t96, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t98 = load %BlockParseResult, %BlockParseResult* %l17
  %t99 = extractvalue %BlockParseResult %t98, 1
  store i8* %t99, i8** %l18
  store double 0.0, double* %l19
  store double 0.0, double* %l20
  %t100 = load %Parser, %Parser* %l0
  %t101 = insertvalue %MethodParseResult undef, i8* null, 0
  %t102 = load double, double* %l20
  %t103 = insertvalue %MethodParseResult %t101, i8* null, 1
  %t104 = insertvalue %MethodParseResult %t103, i1 1, 2
  ret %MethodParseResult %t104
}

define %DecoratorParseResult @parse_decorators(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %Parser
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t5 = load %Parser, %Parser* %l0
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t39 = phi %Parser [ %t5, %entry ], [ %t37, %loop.latch2 ]
  %t40 = phi { i8**, i64 }* [ %t6, %entry ], [ %t38, %loop.latch2 ]
  store %Parser %t39, %Parser* %l0
  store { i8**, i64 }* %t40, { i8**, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t7 = load %Parser, %Parser* %l0
  %t8 = call %Parser @skip_trivia(%Parser %t7)
  store %Parser %t8, %Parser* %l0
  %t9 = load %Parser, %Parser* %l0
  %t10 = call double @parser_peek_raw(%Parser %t9)
  store double %t10, double* %l2
  %t12 = load double, double* %l2
  %t13 = load %Parser, %Parser* %l0
  store %Parser %t13, %Parser* %l3
  %t14 = load %Parser, %Parser* %l0
  %t15 = call %Parser @parser_advance_raw(%Parser %t14)
  store %Parser %t15, %Parser* %l0
  %t16 = load %Parser, %Parser* %l0
  %t17 = call %Parser @skip_trivia(%Parser %t16)
  store %Parser %t17, %Parser* %l0
  %t18 = load %Parser, %Parser* %l0
  %t19 = call double @parser_peek_raw(%Parser %t18)
  store double %t19, double* %l4
  %t20 = load double, double* %l4
  %t21 = load double, double* %l4
  %t22 = call i8* @identifier_text(i8* null)
  store i8* %t22, i8** %l5
  %t23 = load %Parser, %Parser* %l0
  %t24 = call %Parser @parser_advance_raw(%Parser %t23)
  store %Parser %t24, %Parser* %l0
  %t25 = load %Parser, %Parser* %l0
  %t26 = call %Parser @skip_trivia(%Parser %t25)
  store %Parser %t26, %Parser* %l0
  %t27 = alloca [0 x double]
  %t28 = getelementptr [0 x double], [0 x double]* %t27, i32 0, i32 0
  %t29 = alloca { double*, i64 }
  %t30 = getelementptr { double*, i64 }, { double*, i64 }* %t29, i32 0, i32 0
  store double* %t28, double** %t30
  %t31 = getelementptr { double*, i64 }, { double*, i64 }* %t29, i32 0, i32 1
  store i64 0, i64* %t31
  store { i8**, i64 }* null, { i8**, i64 }** %l6
  %t32 = load %Parser, %Parser* %l0
  %t33 = call double @parser_peek_raw(%Parser %t32)
  store double %t33, double* %l7
  %t35 = load double, double* %l7
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t37 = load %Parser, %Parser* %l0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t41 = load %Parser, %Parser* %l0
  %t42 = insertvalue %DecoratorParseResult undef, i8* null, 0
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t44 = insertvalue %DecoratorParseResult %t42, { i8**, i64 }* %t43, 1
  ret %DecoratorParseResult %t44
}

define %TypeParameterParseResult @parse_type_parameter_clause(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca double
  %l8 = alloca { i8**, i64 }*
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l1
  %t4 = load double, double* %l1
  %t5 = load %Parser, %Parser* %l0
  %t6 = call %Parser @parser_advance_raw(%Parser %t5)
  store %Parser %t6, %Parser* %l0
  %t7 = alloca [0 x double]
  %t8 = getelementptr [0 x double], [0 x double]* %t7, i32 0, i32 0
  %t9 = alloca { double*, i64 }
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t9, i32 0, i32 0
  store double* %t8, double** %t10
  %t11 = getelementptr { double*, i64 }, { double*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t12 = sitofp i64 1 to double
  store double %t12, double* %l3
  %t13 = load %Parser, %Parser* %l0
  %t14 = load double, double* %l1
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t16 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t28 = phi { i8**, i64 }* [ %t15, %entry ], [ %t26, %loop.latch2 ]
  %t29 = phi %Parser [ %t13, %entry ], [ %t27, %loop.latch2 ]
  store { i8**, i64 }* %t28, { i8**, i64 }** %l2
  store %Parser %t29, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t17 = load %Parser, %Parser* %l0
  %t18 = call double @parser_peek_raw(%Parser %t17)
  store double %t18, double* %l4
  %t19 = load double, double* %l4
  %t20 = load double, double* %l4
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t22 = load double, double* %l4
  %t23 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t21, i8* null)
  store { i8**, i64 }* %t23, { i8**, i64 }** %l2
  %t24 = load %Parser, %Parser* %l0
  %t25 = call %Parser @parser_advance_raw(%Parser %t24)
  store %Parser %t25, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t27 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t31 = call { i8**, i64 }* @split_token_slices_by_comma({ i8**, i64 }* %t30)
  store { i8**, i64 }* %t31, { i8**, i64 }** %l5
  %t32 = alloca [0 x double]
  %t33 = getelementptr [0 x double], [0 x double]* %t32, i32 0, i32 0
  %t34 = alloca { double*, i64 }
  %t35 = getelementptr { double*, i64 }, { double*, i64 }* %t34, i32 0, i32 0
  store double* %t33, double** %t35
  %t36 = getelementptr { double*, i64 }, { double*, i64 }* %t34, i32 0, i32 1
  store i64 0, i64* %t36
  store { i8**, i64 }* null, { i8**, i64 }** %l6
  %t37 = sitofp i64 0 to double
  store double %t37, double* %l7
  %t38 = load %Parser, %Parser* %l0
  %t39 = load double, double* %l1
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t41 = load double, double* %l3
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t44 = load double, double* %l7
  br label %loop.header4
loop.header4:
  %t61 = phi double [ %t44, %entry ], [ %t60, %loop.latch6 ]
  store double %t61, double* %l7
  br label %loop.body5
loop.body5:
  %t45 = load double, double* %l7
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t48 = load double, double* %l7
  %t49 = load { i8**, i64 }, { i8**, i64 }* %t47
  %t50 = extractvalue { i8**, i64 } %t49, 0
  %t51 = extractvalue { i8**, i64 } %t49, 1
  %t52 = icmp uge i64 %t48, %t51
  ; bounds check: %t52 (if true, out of bounds)
  %t53 = getelementptr i8*, i8** %t50, i64 %t48
  %t54 = load i8*, i8** %t53
  %t55 = call { i8**, i64 }* @trim_token_edges({ i8**, i64 }* null)
  store { i8**, i64 }* %t55, { i8**, i64 }** %l8
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t57 = load double, double* %l7
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l7
  br label %loop.latch6
loop.latch6:
  %t60 = load double, double* %l7
  br label %loop.header4
afterloop7:
  %t62 = load %Parser, %Parser* %l0
  %t63 = insertvalue %TypeParameterParseResult undef, i8* null, 0
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t65 = insertvalue %TypeParameterParseResult %t63, { i8**, i64 }* %t64, 1
  ret %TypeParameterParseResult %t65
}

define %ImplementsParseResult @parse_implements_clause(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %CaptureResult
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca i8*
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %t2 = call double @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.3, i32 0, i32 0
  %t4 = call double @identifier_matches(double %t2, i8* %s3)
  %t5 = fcmp one double %t4, 0.0
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
  %s21 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.21, i32 0, i32 0
  %t22 = alloca [1 x i8*]
  %t23 = getelementptr [1 x i8*], [1 x i8*]* %t22, i32 0, i32 0
  %t24 = getelementptr i8*, i8** %t23, i64 0
  store i8* %s21, i8** %t24
  %t25 = alloca { i8**, i64 }
  %t26 = getelementptr { i8**, i64 }, { i8**, i64 }* %t25, i32 0, i32 0
  store i8** %t23, i8*** %t26
  %t27 = getelementptr { i8**, i64 }, { i8**, i64 }* %t25, i32 0, i32 1
  store i64 1, i64* %t27
  %t28 = call %CaptureResult @collect_until(%Parser %t20, { i8**, i64 }* %t25)
  store %CaptureResult %t28, %CaptureResult* %l1
  %t29 = load %CaptureResult, %CaptureResult* %l1
  %t30 = extractvalue %CaptureResult %t29, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t31 = alloca [0 x double]
  %t32 = getelementptr [0 x double], [0 x double]* %t31, i32 0, i32 0
  %t33 = alloca { double*, i64 }
  %t34 = getelementptr { double*, i64 }, { double*, i64 }* %t33, i32 0, i32 0
  store double* %t32, double** %t34
  %t35 = getelementptr { double*, i64 }, { double*, i64 }* %t33, i32 0, i32 1
  store i64 0, i64* %t35
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t36 = load %CaptureResult, %CaptureResult* %l1
  %t37 = extractvalue %CaptureResult %t36, 1
  %t38 = call { i8**, i64 }* @split_tokens_by_comma({ i8**, i64 }* %t37)
  store { i8**, i64 }* %t38, { i8**, i64 }** %l3
  %t39 = sitofp i64 0 to double
  store double %t39, double* %l4
  %t40 = load %Parser, %Parser* %l0
  %t41 = load %CaptureResult, %CaptureResult* %l1
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t44 = load double, double* %l4
  br label %loop.header2
loop.header2:
  %t61 = phi double [ %t44, %entry ], [ %t60, %loop.latch4 ]
  store double %t61, double* %l4
  br label %loop.body3
loop.body3:
  %t45 = load double, double* %l4
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t48 = load double, double* %l4
  %t49 = load { i8**, i64 }, { i8**, i64 }* %t47
  %t50 = extractvalue { i8**, i64 } %t49, 0
  %t51 = extractvalue { i8**, i64 } %t49, 1
  %t52 = icmp uge i64 %t48, %t51
  ; bounds check: %t52 (if true, out of bounds)
  %t53 = getelementptr i8*, i8** %t50, i64 %t48
  %t54 = load i8*, i8** %t53
  %t55 = call i8* @trim_text(i8* %t54)
  store i8* %t55, i8** %l5
  %t56 = load i8*, i8** %l5
  %t57 = load double, double* %l4
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l4
  br label %loop.latch4
loop.latch4:
  %t60 = load double, double* %l4
  br label %loop.header2
afterloop5:
  %t62 = load %Parser, %Parser* %l0
  %t63 = insertvalue %ImplementsParseResult undef, i8* null, 0
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t65 = insertvalue %ImplementsParseResult %t63, { i8**, i64 }* %t64, 1
  %t66 = insertvalue %ImplementsParseResult %t65, i1 1, 2
  ret %ImplementsParseResult %t66
}

define %ParameterParseResult @parse_single_parameter(%Parser %parser) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca { i8**, i64 }*
  %l12 = alloca double
  %l13 = alloca double
  %t0 = extractvalue %Parser %parser, 0
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %t1 = extractvalue %Parser %parser, 1
  store double %t1, double* %l1
  store i1 0, i1* %l2
  %t2 = call double @parser_peek_raw(%Parser %parser)
  store double %t2, double* %l3
  %t3 = load double, double* %l3
  %s4 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.4, i32 0, i32 0
  %t5 = call i1 @identifier_matches(i8* null, i8* %s4)
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  %t8 = load i1, i1* %l2
  %t9 = load double, double* %l3
  br i1 %t5, label %then0, label %merge1
then0:
  store i1 1, i1* %l2
  br label %merge1
merge1:
  %t10 = phi i1 [ 1, %then0 ], [ %t8, %entry ]
  store i1 %t10, i1* %l2
  %t11 = call double @parser_peek_raw(%Parser %parser)
  store double %t11, double* %l4
  %t12 = load double, double* %l4
  %t13 = call i8* @identifier_text(i8* null)
  store i8* %t13, i8** %l5
  store i8* null, i8** %l6
  %t14 = call double @parser_peek_raw(%Parser %parser)
  store double %t14, double* %l7
  %t17 = load double, double* %l7
  store i8* null, i8** %l8
  %t18 = call double @parser_peek_raw(%Parser %parser)
  store double %t18, double* %l9
  %t20 = load double, double* %l9
  %t21 = extractvalue %Parser %parser, 1
  store double %t21, double* %l10
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load double, double* %l1
  %t24 = load double, double* %l10
  %t25 = call { i8**, i64 }* @token_slice({ i8**, i64 }* %t22, double %t23, double %t24)
  store { i8**, i64 }* %t25, { i8**, i64 }** %l11
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t27 = call double @source_span_from_tokens({ i8**, i64 }* %t26)
  store double %t27, double* %l12
  store double 0.0, double* %l13
  %t28 = insertvalue %ParameterParseResult undef, i8* null, 0
  %t29 = load double, double* %l13
  %t30 = insertvalue %ParameterParseResult %t28, i8* null, 1
  ret %ParameterParseResult %t30
}

define %EffectParseResult @parse_effect_list(%Parser %parser) {
entry:
  %l0 = alloca double
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l0
  %t2 = load double, double* %l0
  %t3 = alloca [0 x double]
  %t4 = getelementptr [0 x double], [0 x double]* %t3, i32 0, i32 0
  %t5 = alloca { double*, i64 }
  %t6 = getelementptr { double*, i64 }, { double*, i64 }* %t5, i32 0, i32 0
  store double* %t4, double** %t6
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t5, i32 0, i32 1
  store i64 0, i64* %t7
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t8 = load double, double* %l0
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t10 = call double @parser_peek_raw(%Parser %parser)
  store double %t10, double* %l2
  %t12 = load double, double* %l2
  %t13 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t14 = insertvalue %EffectParseResult undef, i8* null, 0
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t16 = insertvalue %EffectParseResult %t14, { i8**, i64 }* %t15, 1
  ret %EffectParseResult %t16
}

define %BlockParseResult @parse_block(%Parser %parser) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca %Parser
  %l3 = alloca double
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca double
  %l6 = alloca %BlockStatementParseResult
  %l7 = alloca double
  %l8 = alloca %StatementParseResult
  %l9 = alloca double
  %l10 = alloca { i8**, i64 }*
  %l11 = alloca i8*
  %l12 = alloca double
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l0
  %t2 = load double, double* %l0
  %t3 = extractvalue %Parser %parser, 1
  store double %t3, double* %l1
  %t4 = call %Parser @parser_advance_raw(%Parser %parser)
  store %Parser %t4, %Parser* %l2
  %t5 = load double, double* %l1
  store double %t5, double* %l3
  %t6 = alloca [0 x double]
  %t7 = getelementptr [0 x double], [0 x double]* %t6, i32 0, i32 0
  %t8 = alloca { double*, i64 }
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 0
  store double* %t7, double** %t9
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t11 = load double, double* %l0
  %t12 = load double, double* %l1
  %t13 = load %Parser, %Parser* %l2
  %t14 = load double, double* %l3
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %loop.header0
loop.header0:
  %t63 = phi %Parser [ %t13, %entry ], [ %t62, %loop.latch2 ]
  store %Parser %t63, %Parser* %l2
  br label %loop.body1
loop.body1:
  %t16 = load %Parser, %Parser* %l2
  %t17 = call %Parser @skip_trivia(%Parser %t16)
  store %Parser %t17, %Parser* %l2
  %t18 = load %Parser, %Parser* %l2
  %t19 = call double @parser_peek_raw(%Parser %t18)
  store double %t19, double* %l5
  %t21 = load double, double* %l5
  %t22 = load double, double* %l5
  %t23 = load %Parser, %Parser* %l2
  %t24 = call %BlockStatementParseResult @parse_block_statement(%Parser %t23)
  store %BlockStatementParseResult %t24, %BlockStatementParseResult* %l6
  %t25 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t26 = extractvalue %BlockStatementParseResult %t25, 2
  %t27 = load double, double* %l0
  %t28 = load double, double* %l1
  %t29 = load %Parser, %Parser* %l2
  %t30 = load double, double* %l3
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t32 = load double, double* %l5
  %t33 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  br i1 %t26, label %then4, label %merge5
then4:
  %t34 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t35 = extractvalue %BlockStatementParseResult %t34, 0
  store %Parser zeroinitializer, %Parser* %l2
  %t36 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t37 = extractvalue %BlockStatementParseResult %t36, 1
  br label %loop.latch2
merge5:
  %t38 = load %Parser, %Parser* %l2
  %t39 = extractvalue %Parser %t38, 1
  store double %t39, double* %l7
  %t40 = load %Parser, %Parser* %l2
  %t41 = call %StatementParseResult @parse_unknown(%Parser %t40)
  store %StatementParseResult %t41, %StatementParseResult* %l8
  %t42 = load %StatementParseResult, %StatementParseResult* %l8
  %t43 = extractvalue %StatementParseResult %t42, 0
  store %Parser zeroinitializer, %Parser* %l2
  %t44 = load %StatementParseResult, %StatementParseResult* %l8
  %t45 = extractvalue %StatementParseResult %t44, 1
  %t46 = load %Parser, %Parser* %l2
  %t47 = extractvalue %Parser %t46, 1
  %t48 = load double, double* %l7
  %t49 = fcmp ole double %t47, %t48
  %t50 = load double, double* %l0
  %t51 = load double, double* %l1
  %t52 = load %Parser, %Parser* %l2
  %t53 = load double, double* %l3
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t55 = load double, double* %l5
  %t56 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t57 = load double, double* %l7
  %t58 = load %StatementParseResult, %StatementParseResult* %l8
  br i1 %t49, label %then6, label %merge7
then6:
  %t59 = load %Parser, %Parser* %l2
  %t60 = call %Parser @parser_advance_raw(%Parser %t59)
  store %Parser %t60, %Parser* %l2
  br label %merge7
merge7:
  %t61 = phi %Parser [ %t60, %then6 ], [ %t52, %loop.body1 ]
  store %Parser %t61, %Parser* %l2
  br label %loop.latch2
loop.latch2:
  %t62 = load %Parser, %Parser* %l2
  br label %loop.header0
afterloop3:
  %t64 = load %Parser, %Parser* %l2
  %t65 = extractvalue %Parser %t64, 1
  store double %t65, double* %l9
  %t66 = load double, double* %l3
  %t67 = load double, double* %l1
  %t68 = fcmp ogt double %t66, %t67
  %t69 = load double, double* %l0
  %t70 = load double, double* %l1
  %t71 = load %Parser, %Parser* %l2
  %t72 = load double, double* %l3
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t74 = load double, double* %l9
  br i1 %t68, label %then8, label %merge9
then8:
  %t75 = load double, double* %l3
  store double %t75, double* %l9
  br label %merge9
merge9:
  %t76 = phi double [ %t75, %then8 ], [ %t74, %entry ]
  store double %t76, double* %l9
  %t77 = extractvalue %Parser %parser, 0
  %t78 = load double, double* %l1
  %t79 = load double, double* %l9
  %t80 = call { i8**, i64 }* @token_slice({ i8**, i64 }* %t77, double %t78, double %t79)
  store { i8**, i64 }* %t80, { i8**, i64 }** %l10
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t82 = call { i8**, i64 }* @trim_block_tokens({ i8**, i64 }* %t81)
  store { i8**, i64 }* %t82, { i8**, i64 }** %l10
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t84 = call i8* @tokens_to_text({ i8**, i64 }* %t83)
  store i8* %t84, i8** %l11
  store double 0.0, double* %l12
  %t85 = load %Parser, %Parser* %l2
  %t86 = call %Parser @skip_trivia(%Parser %t85)
  %t87 = insertvalue %BlockParseResult undef, i8* null, 0
  %t88 = load double, double* %l12
  %t89 = insertvalue %BlockParseResult %t87, i8* null, 1
  ret %BlockParseResult %t89
}

define %BlockStatementParseResult @parse_block_statement(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %DecoratorParseResult
  %l2 = alloca i8*
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca %Parser
  %l5 = alloca double
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
  %t8 = call double @parser_peek_raw(%Parser %t7)
  store double %t8, double* %l5
  %t9 = load double, double* %l5
  %s10 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.10, i32 0, i32 0
  %t11 = call i1 @identifier_matches(i8* null, i8* %s10)
  %t12 = load %Parser, %Parser* %l0
  %t13 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t14 = load i8*, i8** %l2
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t16 = load %Parser, %Parser* %l4
  %t17 = load double, double* %l5
  br i1 %t11, label %then0, label %merge1
then0:
  %t18 = load %Parser, %Parser* %l4
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t20 = call %BlockStatementParseResult @parse_for_statement(%Parser %t18, { i8**, i64 }* %t19)
  ret %BlockStatementParseResult %t20
merge1:
  %t21 = load double, double* %l5
  %s22 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.22, i32 0, i32 0
  %t23 = call i1 @identifier_matches(i8* null, i8* %s22)
  %t24 = load %Parser, %Parser* %l0
  %t25 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t26 = load i8*, i8** %l2
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t28 = load %Parser, %Parser* %l4
  %t29 = load double, double* %l5
  br i1 %t23, label %then2, label %merge3
then2:
  %t30 = load %Parser, %Parser* %l4
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t32 = call %BlockStatementParseResult @parse_loop_statement(%Parser %t30, { i8**, i64 }* %t31)
  ret %BlockStatementParseResult %t32
merge3:
  %t33 = load double, double* %l5
  %s34 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.34, i32 0, i32 0
  %t35 = call i1 @identifier_matches(i8* null, i8* %s34)
  %t36 = load %Parser, %Parser* %l0
  %t37 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t38 = load i8*, i8** %l2
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t40 = load %Parser, %Parser* %l4
  %t41 = load double, double* %l5
  br i1 %t35, label %then4, label %merge5
then4:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t43 = load %Parser, %Parser* %l4
  %t44 = call %BlockStatementParseResult @parse_break_statement(%Parser %t43)
  ret %BlockStatementParseResult %t44
merge5:
  %t45 = load double, double* %l5
  %s46 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.46, i32 0, i32 0
  %t47 = call i1 @identifier_matches(i8* null, i8* %s46)
  %t48 = load %Parser, %Parser* %l0
  %t49 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t50 = load i8*, i8** %l2
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t52 = load %Parser, %Parser* %l4
  %t53 = load double, double* %l5
  br i1 %t47, label %then6, label %merge7
then6:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t55 = load %Parser, %Parser* %l4
  %t56 = call %BlockStatementParseResult @parse_continue_statement(%Parser %t55)
  ret %BlockStatementParseResult %t56
merge7:
  %t57 = load double, double* %l5
  %s58 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.58, i32 0, i32 0
  %t59 = call i1 @identifier_matches(i8* null, i8* %s58)
  %t60 = load %Parser, %Parser* %l0
  %t61 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t62 = load i8*, i8** %l2
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t64 = load %Parser, %Parser* %l4
  %t65 = load double, double* %l5
  br i1 %t59, label %then8, label %merge9
then8:
  %t66 = load %Parser, %Parser* %l4
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t68 = call %BlockStatementParseResult @parse_if_statement(%Parser %t66, { i8**, i64 }* %t67)
  ret %BlockStatementParseResult %t68
merge9:
  %t69 = load double, double* %l5
  %s70 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.70, i32 0, i32 0
  %t71 = call i1 @identifier_matches(i8* null, i8* %s70)
  %t72 = load %Parser, %Parser* %l0
  %t73 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t74 = load i8*, i8** %l2
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t76 = load %Parser, %Parser* %l4
  %t77 = load double, double* %l5
  br i1 %t71, label %then10, label %merge11
then10:
  %t78 = load %Parser, %Parser* %l4
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t80 = call %BlockStatementParseResult @parse_match_statement(%Parser %t78, { i8**, i64 }* %t79)
  ret %BlockStatementParseResult %t80
merge11:
  %t81 = load double, double* %l5
  %s82 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.82, i32 0, i32 0
  %t83 = call i1 @identifier_matches(i8* null, i8* %s82)
  %t84 = load %Parser, %Parser* %l0
  %t85 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t86 = load i8*, i8** %l2
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t88 = load %Parser, %Parser* %l4
  %t89 = load double, double* %l5
  br i1 %t83, label %then12, label %merge13
then12:
  %t90 = load %Parser, %Parser* %l4
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t92 = call %BlockStatementParseResult @parse_prompt_statement(%Parser %t90, { i8**, i64 }* %t91)
  ret %BlockStatementParseResult %t92
merge13:
  %t93 = load double, double* %l5
  %s94 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.94, i32 0, i32 0
  %t95 = call i1 @identifier_matches(i8* null, i8* %s94)
  %t96 = load %Parser, %Parser* %l0
  %t97 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t98 = load i8*, i8** %l2
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t100 = load %Parser, %Parser* %l4
  %t101 = load double, double* %l5
  br i1 %t95, label %then14, label %merge15
then14:
  %t102 = load %Parser, %Parser* %l4
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t104 = call %BlockStatementParseResult @parse_with_statement(%Parser %t102, { i8**, i64 }* %t103)
  ret %BlockStatementParseResult %t104
merge15:
  %t105 = load double, double* %l5
  %s106 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.106, i32 0, i32 0
  %t107 = call i1 @identifier_matches(i8* null, i8* %s106)
  %t108 = load %Parser, %Parser* %l0
  %t109 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t110 = load i8*, i8** %l2
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t112 = load %Parser, %Parser* %l4
  %t113 = load double, double* %l5
  br i1 %t107, label %then16, label %merge17
then16:
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t115 = load %Parser, %Parser* %l4
  %t116 = call %BlockStatementParseResult @parse_return_statement(%Parser %t115)
  ret %BlockStatementParseResult %t116
merge17:
  %t117 = load %Parser, %Parser* %l4
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t119 = call %BlockStatementParseResult @parse_expression_statement(%Parser %t117, { i8**, i64 }* %t118)
  store %BlockStatementParseResult %t119, %BlockStatementParseResult* %l6
  %t120 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t121 = extractvalue %BlockStatementParseResult %t120, 2
  %t122 = load %Parser, %Parser* %l0
  %t123 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t124 = load i8*, i8** %l2
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t126 = load %Parser, %Parser* %l4
  %t127 = load double, double* %l5
  %t128 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  br i1 %t121, label %then18, label %merge19
then18:
  %t129 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  ret %BlockStatementParseResult %t129
merge19:
  %t130 = load %Parser, %Parser* %l0
  %t131 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t132 = insertvalue %BlockStatementParseResult %t131, i8* null, 1
  %t133 = insertvalue %BlockStatementParseResult %t132, i1 0, 2
  ret %BlockStatementParseResult %t133
}

define %BlockStatementParseResult @parse_for_statement(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %CaptureResult
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca %BlockParseResult
  %l11 = alloca i8*
  %l12 = alloca double
  %l13 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.3, i32 0, i32 0
  %t4 = call double @identifier_matches(double %t2, i8* %s3)
  %t5 = fcmp one double %t4, 0.0
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
  %s17 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.17, i32 0, i32 0
  %t18 = alloca [1 x i8*]
  %t19 = getelementptr [1 x i8*], [1 x i8*]* %t18, i32 0, i32 0
  %t20 = getelementptr i8*, i8** %t19, i64 0
  store i8* %s17, i8** %t20
  %t21 = alloca { i8**, i64 }
  %t22 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 0
  store i8** %t19, i8*** %t22
  %t23 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 1
  store i64 1, i64* %t23
  %t24 = call %CaptureResult @collect_until(%Parser %t16, { i8**, i64 }* %t21)
  store %CaptureResult %t24, %CaptureResult* %l2
  %t25 = load %CaptureResult, %CaptureResult* %l2
  %t26 = extractvalue %CaptureResult %t25, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t27 = load %CaptureResult, %CaptureResult* %l2
  %t28 = extractvalue %CaptureResult %t27, 1
  %t29 = call { i8**, i64 }* @trim_token_edges({ i8**, i64 }* %t28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l3
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s32 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.32, i32 0, i32 0
  %t33 = call double @find_top_level_identifier({ i8**, i64 }* %t31, i8* %s32)
  store double %t33, double* %l4
  %t34 = load double, double* %l4
  %t35 = sitofp i64 -1 to double
  %t36 = fcmp oeq double %t34, %t35
  %t37 = load %Parser, %Parser* %l0
  %t38 = load %Parser, %Parser* %l1
  %t39 = load %CaptureResult, %CaptureResult* %l2
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t41 = load double, double* %l4
  br i1 %t36, label %then2, label %merge3
then2:
  %t42 = load %Parser, %Parser* %l0
  %t43 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t44 = insertvalue %BlockStatementParseResult %t43, i8* null, 1
  %t45 = insertvalue %BlockStatementParseResult %t44, i1 0, 2
  ret %BlockStatementParseResult %t45
merge3:
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t47 = load double, double* %l4
  %t48 = sitofp i64 0 to double
  %t49 = call { i8**, i64 }* @token_slice({ i8**, i64 }* %t46, double %t48, double %t47)
  %t50 = call { i8**, i64 }* @trim_token_edges({ i8**, i64 }* %t49)
  store { i8**, i64 }* %t50, { i8**, i64 }** %l5
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t52 = load double, double* %l4
  %t53 = sitofp i64 1 to double
  %t54 = fadd double %t52, %t53
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l3
  store double 0.0, double* %l6
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t59 = call double @expression_from_tokens({ i8**, i64 }* %t58)
  store double %t59, double* %l7
  %t60 = load double, double* %l6
  %t61 = call double @expression_from_tokens({ i8**, i64 }* null)
  store double %t61, double* %l8
  store double 0.0, double* %l9
  %t62 = load %Parser, %Parser* %l1
  %t63 = call %BlockParseResult @parse_block(%Parser %t62)
  store %BlockParseResult %t63, %BlockParseResult* %l10
  %t64 = load %BlockParseResult, %BlockParseResult* %l10
  %t65 = extractvalue %BlockParseResult %t64, 1
  %t66 = load %BlockParseResult, %BlockParseResult* %l10
  %t67 = extractvalue %BlockParseResult %t66, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t68 = load %BlockParseResult, %BlockParseResult* %l10
  %t69 = extractvalue %BlockParseResult %t68, 1
  store i8* %t69, i8** %l11
  %t70 = load %Parser, %Parser* %l1
  %t71 = call %Parser @skip_trivia(%Parser %t70)
  store %Parser %t71, %Parser* %l1
  %t72 = load %Parser, %Parser* %l1
  %t73 = call double @parser_peek_raw(%Parser %t72)
  store double %t73, double* %l12
  %t75 = load double, double* %l12
  store double 0.0, double* %l13
  %t76 = load %Parser, %Parser* %l1
  %t77 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t78 = load double, double* %l13
  %t79 = insertvalue %BlockStatementParseResult %t77, i8* null, 1
  %t80 = insertvalue %BlockStatementParseResult %t79, i1 1, 2
  ret %BlockStatementParseResult %t80
}

define %BlockStatementParseResult @parse_loop_statement(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %BlockParseResult
  %l3 = alloca double
  %l4 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.3, i32 0, i32 0
  %t4 = call double @identifier_matches(double %t2, i8* %s3)
  %t5 = fcmp one double %t4, 0.0
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
  %t24 = call double @parser_peek_raw(%Parser %t23)
  store double %t24, double* %l3
  %t26 = load double, double* %l3
  store double 0.0, double* %l4
  %t27 = load %Parser, %Parser* %l1
  %t28 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t29 = load double, double* %l4
  %t30 = insertvalue %BlockStatementParseResult %t28, i8* null, 1
  %t31 = insertvalue %BlockStatementParseResult %t30, i1 1, 2
  ret %BlockStatementParseResult %t31
}

define %BlockStatementParseResult @parse_break_statement(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.3, i32 0, i32 0
  %t4 = call double @identifier_matches(double %t2, i8* %s3)
  %t5 = fcmp one double %t4, 0.0
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
  %t18 = call double @parser_peek_raw(%Parser %t17)
  store double %t18, double* %l2
  %t20 = load double, double* %l2
  %t21 = load %Parser, %Parser* %l1
  %t22 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t23 = call double @StatementBreakStatement()
  %t24 = insertvalue %BlockStatementParseResult %t22, i8* null, 1
  %t25 = insertvalue %BlockStatementParseResult %t24, i1 1, 2
  ret %BlockStatementParseResult %t25
}

define %BlockStatementParseResult @parse_continue_statement(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.3, i32 0, i32 0
  %t4 = call double @identifier_matches(double %t2, i8* %s3)
  %t5 = fcmp one double %t4, 0.0
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
  %t18 = call double @parser_peek_raw(%Parser %t17)
  store double %t18, double* %l2
  %t20 = load double, double* %l2
  %t21 = load %Parser, %Parser* %l1
  %t22 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t23 = call double @StatementContinueStatement()
  %t24 = insertvalue %BlockStatementParseResult %t22, i8* null, 1
  %t25 = insertvalue %BlockStatementParseResult %t24, i1 1, 2
  ret %BlockStatementParseResult %t25
}

define %BlockStatementParseResult @parse_if_statement(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %CaptureResult
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca %BlockParseResult
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca double
  %l9 = alloca %BlockStatementParseResult
  %l10 = alloca %BlockParseResult
  %l11 = alloca double
  %l12 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.3, i32 0, i32 0
  %t4 = call double @identifier_matches(double %t2, i8* %s3)
  %t5 = fcmp one double %t4, 0.0
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
  %s17 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.17, i32 0, i32 0
  %t18 = alloca [1 x i8*]
  %t19 = getelementptr [1 x i8*], [1 x i8*]* %t18, i32 0, i32 0
  %t20 = getelementptr i8*, i8** %t19, i64 0
  store i8* %s17, i8** %t20
  %t21 = alloca { i8**, i64 }
  %t22 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 0
  store i8** %t19, i8*** %t22
  %t23 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 1
  store i64 1, i64* %t23
  %t24 = call %CaptureResult @collect_until(%Parser %t16, { i8**, i64 }* %t21)
  store %CaptureResult %t24, %CaptureResult* %l2
  %t25 = load %CaptureResult, %CaptureResult* %l2
  %t26 = extractvalue %CaptureResult %t25, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t27 = load %CaptureResult, %CaptureResult* %l2
  %t28 = extractvalue %CaptureResult %t27, 1
  %t29 = call { i8**, i64 }* @trim_token_edges({ i8**, i64 }* %t28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l3
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t32 = call double @expression_from_tokens({ i8**, i64 }* %t31)
  store double %t32, double* %l4
  %t33 = load %Parser, %Parser* %l1
  %t34 = call %BlockParseResult @parse_block(%Parser %t33)
  store %BlockParseResult %t34, %BlockParseResult* %l5
  %t35 = load %BlockParseResult, %BlockParseResult* %l5
  %t36 = extractvalue %BlockParseResult %t35, 1
  %t37 = load %BlockParseResult, %BlockParseResult* %l5
  %t38 = extractvalue %BlockParseResult %t37, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t39 = load %BlockParseResult, %BlockParseResult* %l5
  %t40 = extractvalue %BlockParseResult %t39, 1
  store i8* %t40, i8** %l6
  %t41 = load %Parser, %Parser* %l1
  %t42 = call %Parser @skip_trivia(%Parser %t41)
  store %Parser %t42, %Parser* %l1
  store i8* null, i8** %l7
  %t43 = load %Parser, %Parser* %l1
  %t44 = call double @parser_peek_raw(%Parser %t43)
  %s45 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.45, i32 0, i32 0
  %t46 = call i1 @identifier_matches(i8* null, i8* %s45)
  %t47 = load %Parser, %Parser* %l0
  %t48 = load %Parser, %Parser* %l1
  %t49 = load %CaptureResult, %CaptureResult* %l2
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t51 = load double, double* %l4
  %t52 = load %BlockParseResult, %BlockParseResult* %l5
  %t53 = load i8*, i8** %l6
  %t54 = load i8*, i8** %l7
  br i1 %t46, label %then2, label %merge3
then2:
  %t55 = load %Parser, %Parser* %l1
  %s56 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.56, i32 0, i32 0
  %t57 = call %Parser @consume_keyword(%Parser %t55, i8* %s56)
  store %Parser %t57, %Parser* %l1
  %t58 = load %Parser, %Parser* %l1
  %t59 = call %Parser @skip_trivia(%Parser %t58)
  store %Parser %t59, %Parser* %l1
  %t60 = load %Parser, %Parser* %l1
  %t61 = call double @parser_peek_raw(%Parser %t60)
  store double %t61, double* %l8
  %t62 = load double, double* %l8
  %s63 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.63, i32 0, i32 0
  %t64 = call i1 @identifier_matches(i8* null, i8* %s63)
  %t65 = load %Parser, %Parser* %l0
  %t66 = load %Parser, %Parser* %l1
  %t67 = load %CaptureResult, %CaptureResult* %l2
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t69 = load double, double* %l4
  %t70 = load %BlockParseResult, %BlockParseResult* %l5
  %t71 = load i8*, i8** %l6
  %t72 = load i8*, i8** %l7
  %t73 = load double, double* %l8
  br i1 %t64, label %then4, label %else5
then4:
  %t74 = load %Parser, %Parser* %l1
  %t75 = alloca [0 x double]
  %t76 = getelementptr [0 x double], [0 x double]* %t75, i32 0, i32 0
  %t77 = alloca { double*, i64 }
  %t78 = getelementptr { double*, i64 }, { double*, i64 }* %t77, i32 0, i32 0
  store double* %t76, double** %t78
  %t79 = getelementptr { double*, i64 }, { double*, i64 }* %t77, i32 0, i32 1
  store i64 0, i64* %t79
  %t80 = call %BlockStatementParseResult @parse_if_statement(%Parser %t74, { i8**, i64 }* null)
  store %BlockStatementParseResult %t80, %BlockStatementParseResult* %l9
  %t81 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  %t82 = extractvalue %BlockStatementParseResult %t81, 1
  %t83 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  %t84 = extractvalue %BlockStatementParseResult %t83, 0
  store %Parser zeroinitializer, %Parser* %l1
  br label %merge6
else5:
  %t85 = load %Parser, %Parser* %l1
  %t86 = call %BlockParseResult @parse_block(%Parser %t85)
  store %BlockParseResult %t86, %BlockParseResult* %l10
  %t87 = load %BlockParseResult, %BlockParseResult* %l10
  %t88 = extractvalue %BlockParseResult %t87, 1
  %t89 = load %BlockParseResult, %BlockParseResult* %l10
  %t90 = extractvalue %BlockParseResult %t89, 0
  store %Parser zeroinitializer, %Parser* %l1
  br label %merge6
merge6:
  %t91 = phi %Parser [ zeroinitializer, %then4 ], [ zeroinitializer, %else5 ]
  %t92 = phi i8* [ null, %then4 ], [ null, %else5 ]
  store %Parser %t91, %Parser* %l1
  store i8* %t92, i8** %l7
  %t93 = load %Parser, %Parser* %l1
  %t94 = call %Parser @skip_trivia(%Parser %t93)
  store %Parser %t94, %Parser* %l1
  %t95 = load %Parser, %Parser* %l1
  %t96 = call double @parser_peek_raw(%Parser %t95)
  store double %t96, double* %l11
  %t98 = load double, double* %l11
  br label %merge3
merge3:
  %t99 = phi %Parser [ %t57, %then2 ], [ %t48, %entry ]
  %t100 = phi %Parser [ %t59, %then2 ], [ %t48, %entry ]
  %t101 = phi %Parser [ zeroinitializer, %then2 ], [ %t48, %entry ]
  %t102 = phi i8* [ null, %then2 ], [ %t54, %entry ]
  %t103 = phi %Parser [ zeroinitializer, %then2 ], [ %t48, %entry ]
  %t104 = phi i8* [ null, %then2 ], [ %t54, %entry ]
  %t105 = phi %Parser [ %t94, %then2 ], [ %t48, %entry ]
  store %Parser %t99, %Parser* %l1
  store %Parser %t100, %Parser* %l1
  store %Parser %t101, %Parser* %l1
  store i8* %t102, i8** %l7
  store %Parser %t103, %Parser* %l1
  store i8* %t104, i8** %l7
  store %Parser %t105, %Parser* %l1
  store double 0.0, double* %l12
  %t106 = load %Parser, %Parser* %l1
  %t107 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t108 = load double, double* %l12
  %t109 = insertvalue %BlockStatementParseResult %t107, i8* null, 1
  %t110 = insertvalue %BlockStatementParseResult %t109, i1 1, 2
  ret %BlockStatementParseResult %t110
}

define %BlockStatementParseResult @parse_match_statement(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %CaptureResult
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca %MatchCasesParseResult
  %l6 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.3, i32 0, i32 0
  %t4 = call double @identifier_matches(double %t2, i8* %s3)
  %t5 = fcmp one double %t4, 0.0
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
  %s17 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.17, i32 0, i32 0
  %t18 = alloca [1 x i8*]
  %t19 = getelementptr [1 x i8*], [1 x i8*]* %t18, i32 0, i32 0
  %t20 = getelementptr i8*, i8** %t19, i64 0
  store i8* %s17, i8** %t20
  %t21 = alloca { i8**, i64 }
  %t22 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 0
  store i8** %t19, i8*** %t22
  %t23 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 1
  store i64 1, i64* %t23
  %t24 = call %CaptureResult @collect_until(%Parser %t16, { i8**, i64 }* %t21)
  store %CaptureResult %t24, %CaptureResult* %l2
  %t25 = load %CaptureResult, %CaptureResult* %l2
  %t26 = extractvalue %CaptureResult %t25, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t27 = load %CaptureResult, %CaptureResult* %l2
  %t28 = extractvalue %CaptureResult %t27, 1
  %t29 = call { i8**, i64 }* @trim_token_edges({ i8**, i64 }* %t28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l3
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t32 = call double @expression_from_tokens({ i8**, i64 }* %t31)
  store double %t32, double* %l4
  %t33 = load %Parser, %Parser* %l1
  %t34 = call %MatchCasesParseResult @parse_match_cases(%Parser %t33)
  store %MatchCasesParseResult %t34, %MatchCasesParseResult* %l5
  %t35 = load %MatchCasesParseResult, %MatchCasesParseResult* %l5
  %t36 = extractvalue %MatchCasesParseResult %t35, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t37 = load %Parser, %Parser* %l1
  %t38 = call %Parser @skip_trivia(%Parser %t37)
  store %Parser %t38, %Parser* %l1
  %t39 = load %Parser, %Parser* %l1
  %t40 = extractvalue %Parser %t39, 1
  %t41 = load %Parser, %Parser* %l1
  %t42 = extractvalue %Parser %t41, 0
  store double 0.0, double* %l6
  %t43 = load %Parser, %Parser* %l1
  %t44 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t45 = load double, double* %l6
  %t46 = insertvalue %BlockStatementParseResult %t44, i8* null, 1
  %t47 = insertvalue %BlockStatementParseResult %t46, i1 1, 2
  ret %BlockStatementParseResult %t47
}

define %MatchCasesParseResult @parse_match_cases(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca %MatchCaseParseResult
  %l5 = alloca double
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %s2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2, i32 0, i32 0
  %t3 = call %Parser @advance_to_symbol(%Parser %t1, i8* %s2)
  store %Parser %t3, %Parser* %l0
  %t4 = load %Parser, %Parser* %l0
  %t5 = call double @parser_peek_raw(%Parser %t4)
  store double %t5, double* %l1
  %t7 = load double, double* %l1
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
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t15 = load %Parser, %Parser* %l0
  %t16 = load double, double* %l1
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %loop.header0
loop.header0:
  %t42 = phi %Parser [ %t15, %entry ], [ %t40, %loop.latch2 ]
  %t43 = phi { i8**, i64 }* [ %t17, %entry ], [ %t41, %loop.latch2 ]
  store %Parser %t42, %Parser* %l0
  store { i8**, i64 }* %t43, { i8**, i64 }** %l2
  br label %loop.body1
loop.body1:
  %t18 = load %Parser, %Parser* %l0
  %t19 = call %Parser @skip_trivia(%Parser %t18)
  store %Parser %t19, %Parser* %l0
  %t20 = load %Parser, %Parser* %l0
  %t21 = call double @parser_peek_raw(%Parser %t20)
  store double %t21, double* %l3
  %t23 = load double, double* %l3
  %t24 = load double, double* %l3
  %t25 = load %Parser, %Parser* %l0
  %t26 = call %MatchCaseParseResult @parse_match_case(%Parser %t25)
  store %MatchCaseParseResult %t26, %MatchCaseParseResult* %l4
  %t28 = load %MatchCaseParseResult, %MatchCaseParseResult* %l4
  %t29 = extractvalue %MatchCaseParseResult %t28, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t31 = load %MatchCaseParseResult, %MatchCaseParseResult* %l4
  %t32 = extractvalue %MatchCaseParseResult %t31, 1
  %t33 = call { i8**, i64 }* @append_match_case({ i8**, i64 }* %t30, i8* %t32)
  store { i8**, i64 }* %t33, { i8**, i64 }** %l2
  %t34 = load %Parser, %Parser* %l0
  %t35 = call %Parser @skip_trivia(%Parser %t34)
  store %Parser %t35, %Parser* %l0
  %t36 = load %Parser, %Parser* %l0
  %t37 = call double @parser_peek_raw(%Parser %t36)
  store double %t37, double* %l5
  %t39 = load double, double* %l5
  br label %loop.latch2
loop.latch2:
  %t40 = load %Parser, %Parser* %l0
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %loop.header0
afterloop3:
  %t44 = load %Parser, %Parser* %l0
  %t45 = insertvalue %MatchCasesParseResult undef, i8* null, 0
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t47 = insertvalue %MatchCasesParseResult %t45, { i8**, i64 }* %t46, 1
  %t48 = insertvalue %MatchCasesParseResult %t47, i1 1, 2
  ret %MatchCasesParseResult %t48
}

define %MatchCaseParseResult @parse_match_case(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %PatternCaptureResult
  %l3 = alloca %MatchCaseTokenSplit
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(i8* null, i8* %s3)
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
  %t17 = extractvalue %PatternCaptureResult %t16, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t18 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t19 = extractvalue %PatternCaptureResult %t18, 1
  %t20 = call %MatchCaseTokenSplit @split_match_case_tokens({ i8**, i64 }* %t19)
  store %MatchCaseTokenSplit %t20, %MatchCaseTokenSplit* %l3
  %t21 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t22 = extractvalue %MatchCaseTokenSplit %t21, 0
  %t23 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t24 = extractvalue %MatchCaseTokenSplit %t23, 0
  %t25 = call double @expression_from_tokens({ i8**, i64 }* %t24)
  store double %t25, double* %l4
  store i8* null, i8** %l5
  %t26 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t27 = extractvalue %MatchCaseTokenSplit %t26, 2
  %t28 = load %Parser, %Parser* %l0
  %t29 = load %Parser, %Parser* %l1
  %t30 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t31 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t32 = load double, double* %l4
  %t33 = load i8*, i8** %l5
  br i1 %t27, label %then2, label %merge3
then2:
  %t34 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t35 = extractvalue %MatchCaseTokenSplit %t34, 1
  %t36 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t37 = extractvalue %MatchCaseTokenSplit %t36, 1
  %t38 = call double @expression_from_tokens({ i8**, i64 }* %t37)
  store i8* null, i8** %l5
  br label %merge3
merge3:
  %t39 = phi i8* [ null, %then2 ], [ %t33, %entry ]
  store i8* %t39, i8** %l5
  %t40 = load %Parser, %Parser* %l1
  %t41 = call %Parser @skip_trivia(%Parser %t40)
  store %Parser %t41, %Parser* %l1
  %t42 = load %Parser, %Parser* %l1
  %t43 = call double @parser_peek_raw(%Parser %t42)
  store double %t43, double* %l6
  store i8* null, i8** %l7
  %t45 = load double, double* %l6
  %t46 = load i8*, i8** %l7
  store double 0.0, double* %l8
  %t47 = load %Parser, %Parser* %l1
  %t48 = insertvalue %MatchCaseParseResult undef, i8* null, 0
  %t49 = load double, double* %l8
  %t50 = insertvalue %MatchCaseParseResult %t48, i8* null, 1
  %t51 = insertvalue %MatchCaseParseResult %t50, i1 1, 2
  ret %MatchCaseParseResult %t51
}

define %BlockStatementParseResult @parse_prompt_statement(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca %BlockParseResult
  %l6 = alloca i8*
  %l7 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l2
  %t3 = load double, double* %l2
  %s4 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.4, i32 0, i32 0
  %t5 = call double @identifier_matches(double %t3, i8* %s4)
  %t6 = fcmp one double %t5, 0.0
  %t7 = load %Parser, %Parser* %l0
  %t8 = load %Parser, %Parser* %l1
  %t9 = load double, double* %l2
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
  %t20 = call double @parser_peek_raw(%Parser %t19)
  store double %t20, double* %l3
  %s21 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.21, i32 0, i32 0
  store i8* %s21, i8** %l4
  %t22 = load double, double* %l3
  %t23 = load %Parser, %Parser* %l1
  %t24 = call %BlockParseResult @parse_block(%Parser %t23)
  store %BlockParseResult %t24, %BlockParseResult* %l5
  %t25 = load %BlockParseResult, %BlockParseResult* %l5
  %t26 = extractvalue %BlockParseResult %t25, 1
  %t27 = load %BlockParseResult, %BlockParseResult* %l5
  %t28 = extractvalue %BlockParseResult %t27, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t29 = load %BlockParseResult, %BlockParseResult* %l5
  %t30 = extractvalue %BlockParseResult %t29, 1
  store i8* %t30, i8** %l6
  %t31 = load %Parser, %Parser* %l1
  %t32 = call %Parser @skip_trivia(%Parser %t31)
  store %Parser %t32, %Parser* %l1
  %t34 = load %Parser, %Parser* %l1
  %t35 = call double @parser_peek_raw(%Parser %t34)
  store double 0.0, double* %l7
  %t36 = load %Parser, %Parser* %l1
  %t37 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t38 = load double, double* %l7
  %t39 = insertvalue %BlockStatementParseResult %t37, i8* null, 1
  %t40 = insertvalue %BlockStatementParseResult %t39, i1 1, 2
  ret %BlockStatementParseResult %t40
}

define %BlockStatementParseResult @parse_with_statement(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %CaptureResult
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca double
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca %BlockParseResult
  %l8 = alloca i8*
  %l9 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.3, i32 0, i32 0
  %t4 = call double @identifier_matches(double %t2, i8* %s3)
  %t5 = fcmp one double %t4, 0.0
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
  %s17 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.17, i32 0, i32 0
  %t18 = alloca [1 x i8*]
  %t19 = getelementptr [1 x i8*], [1 x i8*]* %t18, i32 0, i32 0
  %t20 = getelementptr i8*, i8** %t19, i64 0
  store i8* %s17, i8** %t20
  %t21 = alloca { i8**, i64 }
  %t22 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 0
  store i8** %t19, i8*** %t22
  %t23 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 1
  store i64 1, i64* %t23
  %t24 = call %CaptureResult @collect_until(%Parser %t16, { i8**, i64 }* %t21)
  store %CaptureResult %t24, %CaptureResult* %l2
  %t25 = load %CaptureResult, %CaptureResult* %l2
  %t26 = extractvalue %CaptureResult %t25, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t27 = load %CaptureResult, %CaptureResult* %l2
  %t28 = extractvalue %CaptureResult %t27, 1
  %t29 = call { i8**, i64 }* @split_token_slices_by_comma({ i8**, i64 }* %t28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l3
  %t30 = alloca [0 x double]
  %t31 = getelementptr [0 x double], [0 x double]* %t30, i32 0, i32 0
  %t32 = alloca { double*, i64 }
  %t33 = getelementptr { double*, i64 }, { double*, i64 }* %t32, i32 0, i32 0
  store double* %t31, double** %t33
  %t34 = getelementptr { double*, i64 }, { double*, i64 }* %t32, i32 0, i32 1
  store i64 0, i64* %t34
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t35 = sitofp i64 0 to double
  store double %t35, double* %l5
  %t36 = load %Parser, %Parser* %l0
  %t37 = load %Parser, %Parser* %l1
  %t38 = load %CaptureResult, %CaptureResult* %l2
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t41 = load double, double* %l5
  br label %loop.header2
loop.header2:
  %t58 = phi double [ %t41, %entry ], [ %t57, %loop.latch4 ]
  store double %t58, double* %l5
  br label %loop.body3
loop.body3:
  %t42 = load double, double* %l5
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t45 = load double, double* %l5
  %t46 = load { i8**, i64 }, { i8**, i64 }* %t44
  %t47 = extractvalue { i8**, i64 } %t46, 0
  %t48 = extractvalue { i8**, i64 } %t46, 1
  %t49 = icmp uge i64 %t45, %t48
  ; bounds check: %t49 (if true, out of bounds)
  %t50 = getelementptr i8*, i8** %t47, i64 %t45
  %t51 = load i8*, i8** %t50
  %t52 = call { i8**, i64 }* @trim_token_edges({ i8**, i64 }* null)
  store { i8**, i64 }* %t52, { i8**, i64 }** %l6
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t54 = load double, double* %l5
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %t54, %t55
  store double %t56, double* %l5
  br label %loop.latch4
loop.latch4:
  %t57 = load double, double* %l5
  br label %loop.header2
afterloop5:
  %t59 = load %Parser, %Parser* %l1
  %t60 = call %BlockParseResult @parse_block(%Parser %t59)
  store %BlockParseResult %t60, %BlockParseResult* %l7
  %t61 = load %BlockParseResult, %BlockParseResult* %l7
  %t62 = extractvalue %BlockParseResult %t61, 1
  %t63 = load %BlockParseResult, %BlockParseResult* %l7
  %t64 = extractvalue %BlockParseResult %t63, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t65 = load %BlockParseResult, %BlockParseResult* %l7
  %t66 = extractvalue %BlockParseResult %t65, 1
  store i8* %t66, i8** %l8
  %t67 = load %Parser, %Parser* %l1
  %t68 = call %Parser @skip_trivia(%Parser %t67)
  store %Parser %t68, %Parser* %l1
  %t70 = load %Parser, %Parser* %l1
  %t71 = call double @parser_peek_raw(%Parser %t70)
  store double 0.0, double* %l9
  %t72 = load %Parser, %Parser* %l1
  %t73 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t74 = load double, double* %l9
  %t75 = insertvalue %BlockStatementParseResult %t73, i8* null, 1
  %t76 = insertvalue %BlockStatementParseResult %t75, i1 1, 2
  ret %BlockStatementParseResult %t76
}

define %BlockStatementParseResult @parse_return_statement(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.3, i32 0, i32 0
  %t4 = call double @identifier_matches(double %t2, i8* %s3)
  %t5 = fcmp one double %t4, 0.0
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
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t18 = load %Parser, %Parser* %l1
  %t19 = call double @parser_peek_raw(%Parser %t18)
  %t20 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t17, i8* null)
  store { i8**, i64 }* %t20, { i8**, i64 }** %l2
  %t21 = load %Parser, %Parser* %l1
  %s22 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.22, i32 0, i32 0
  %t23 = call %Parser @consume_keyword(%Parser %t21, i8* %s22)
  store %Parser %t23, %Parser* %l1
  %t24 = load %Parser, %Parser* %l1
  %t25 = call %Parser @skip_trivia(%Parser %t24)
  store double 0.0, double* %l3
  %t26 = load double, double* %l3
  %t27 = load double, double* %l3
  store double 0.0, double* %l4
  store i8* null, i8** %l5
  %t28 = load double, double* %l4
  %t29 = sitofp i64 0 to double
  store double %t29, double* %l6
  %t30 = load %Parser, %Parser* %l0
  %t31 = load %Parser, %Parser* %l1
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t33 = load double, double* %l3
  %t34 = load double, double* %l4
  %t35 = load i8*, i8** %l5
  %t36 = load double, double* %l6
  br label %loop.header2
loop.header2:
  %t46 = phi { i8**, i64 }* [ %t32, %entry ], [ %t44, %loop.latch4 ]
  %t47 = phi double [ %t36, %entry ], [ %t45, %loop.latch4 ]
  store { i8**, i64 }* %t46, { i8**, i64 }** %l2
  store double %t47, double* %l6
  br label %loop.body3
loop.body3:
  %t37 = load double, double* %l6
  %t38 = load double, double* %l3
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t40 = load double, double* %l3
  %t41 = load double, double* %l6
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l6
  br label %loop.latch4
loop.latch4:
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t45 = load double, double* %l6
  br label %loop.header2
afterloop5:
  %t48 = load %Parser, %Parser* %l1
  %t49 = call %Parser @skip_trivia(%Parser %t48)
  store %Parser %t49, %Parser* %l1
  %t50 = load %Parser, %Parser* %l1
  %t51 = call double @parser_peek_raw(%Parser %t50)
  store double %t51, double* %l7
  %t53 = load double, double* %l7
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t55 = call double @source_span_from_tokens({ i8**, i64 }* %t54)
  store double %t55, double* %l8
  store double 0.0, double* %l9
  %t56 = load %Parser, %Parser* %l1
  %t57 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t58 = load double, double* %l9
  %t59 = insertvalue %BlockStatementParseResult %t57, i8* null, 1
  %t60 = insertvalue %BlockStatementParseResult %t59, i1 1, 2
  ret %BlockStatementParseResult %t60
}

define %BlockStatementParseResult @parse_expression_statement(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca %CaptureResult
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca double
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l1
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  %t5 = load %Parser, %Parser* %l0
  %s6 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.6, i32 0, i32 0
  %t7 = alloca [1 x i8*]
  %t8 = getelementptr [1 x i8*], [1 x i8*]* %t7, i32 0, i32 0
  %t9 = getelementptr i8*, i8** %t8, i64 0
  store i8* %s6, i8** %t9
  %t10 = alloca { i8**, i64 }
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t8, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = call %CaptureResult @collect_until(%Parser %t5, { i8**, i64 }* %t10)
  store %CaptureResult %t13, %CaptureResult* %l2
  %t14 = load %CaptureResult, %CaptureResult* %l2
  %t15 = extractvalue %CaptureResult %t14, 1
  %t16 = alloca [0 x double]
  %t17 = getelementptr [0 x double], [0 x double]* %t16, i32 0, i32 0
  %t18 = alloca { double*, i64 }
  %t19 = getelementptr { double*, i64 }, { double*, i64 }* %t18, i32 0, i32 0
  store double* %t17, double** %t19
  %t20 = getelementptr { double*, i64 }, { double*, i64 }* %t18, i32 0, i32 1
  store i64 0, i64* %t20
  store { i8**, i64 }* null, { i8**, i64 }** %l3
  %t21 = sitofp i64 0 to double
  store double %t21, double* %l4
  %t22 = load %Parser, %Parser* %l0
  %t23 = load double, double* %l1
  %t24 = load %CaptureResult, %CaptureResult* %l2
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t26 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t46 = phi { i8**, i64 }* [ %t25, %entry ], [ %t44, %loop.latch2 ]
  %t47 = phi double [ %t26, %entry ], [ %t45, %loop.latch2 ]
  store { i8**, i64 }* %t46, { i8**, i64 }** %l3
  store double %t47, double* %l4
  br label %loop.body1
loop.body1:
  %t27 = load double, double* %l4
  %t28 = load %CaptureResult, %CaptureResult* %l2
  %t29 = extractvalue %CaptureResult %t28, 1
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t31 = load %CaptureResult, %CaptureResult* %l2
  %t32 = extractvalue %CaptureResult %t31, 1
  %t33 = load double, double* %l4
  %t34 = load { i8**, i64 }, { i8**, i64 }* %t32
  %t35 = extractvalue { i8**, i64 } %t34, 0
  %t36 = extractvalue { i8**, i64 } %t34, 1
  %t37 = icmp uge i64 %t33, %t36
  ; bounds check: %t37 (if true, out of bounds)
  %t38 = getelementptr i8*, i8** %t35, i64 %t33
  %t39 = load i8*, i8** %t38
  %t40 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t30, i8* %t39)
  store { i8**, i64 }* %t40, { i8**, i64 }** %l3
  %t41 = load double, double* %l4
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l4
  br label %loop.latch2
loop.latch2:
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t45 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t48 = load %CaptureResult, %CaptureResult* %l2
  %t49 = extractvalue %CaptureResult %t48, 1
  %t50 = call { i8**, i64 }* @trim_token_edges({ i8**, i64 }* %t49)
  store { i8**, i64 }* %t50, { i8**, i64 }** %l5
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t52 = load %CaptureResult, %CaptureResult* %l2
  %t53 = extractvalue %CaptureResult %t52, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t54 = load %Parser, %Parser* %l0
  %t55 = call %Parser @skip_trivia(%Parser %t54)
  store %Parser %t55, %Parser* %l0
  %t56 = load %Parser, %Parser* %l0
  %t57 = call double @parser_peek_raw(%Parser %t56)
  store double %t57, double* %l6
  %t59 = load double, double* %l6
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t61 = load double, double* %l6
  %t62 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t60, i8* null)
  store { i8**, i64 }* %t62, { i8**, i64 }** %l3
  %t63 = load %Parser, %Parser* %l0
  %t64 = call %Parser @parser_advance_raw(%Parser %t63)
  store %Parser %t64, %Parser* %l0
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t66 = call double @expression_from_tokens({ i8**, i64 }* %t65)
  store double %t66, double* %l7
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t68 = call double @source_span_from_tokens({ i8**, i64 }* %t67)
  store double %t68, double* %l8
  store double 0.0, double* %l9
  %t69 = load %Parser, %Parser* %l0
  %t70 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t71 = load double, double* %l9
  %t72 = insertvalue %BlockStatementParseResult %t70, i8* null, 1
  %t73 = insertvalue %BlockStatementParseResult %t72, i1 1, 2
  ret %BlockStatementParseResult %t73
}

define %StatementParseResult @parse_unknown(%Parser %parser) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca %Parser
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  store %Parser %parser, %Parser* %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load %Parser, %Parser* %l1
  %t8 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t20 = phi { i8**, i64 }* [ %t6, %entry ], [ %t18, %loop.latch2 ]
  %t21 = phi %Parser [ %t7, %entry ], [ %t19, %loop.latch2 ]
  store { i8**, i64 }* %t20, { i8**, i64 }** %l0
  store %Parser %t21, %Parser* %l1
  br label %loop.body1
loop.body1:
  %t9 = load %Parser, %Parser* %l1
  %t10 = call double @parser_peek_raw(%Parser %t9)
  store double %t10, double* %l3
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load double, double* %l3
  %t13 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t11, i8* null)
  store { i8**, i64 }* %t13, { i8**, i64 }** %l0
  %t14 = load double, double* %l3
  %t15 = load double, double* %l3
  %t16 = load %Parser, %Parser* %l1
  %t17 = call %Parser @parser_advance_raw(%Parser %t16)
  store %Parser %t17, %Parser* %l1
  br label %loop.latch2
loop.latch2:
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load %Parser, %Parser* %l1
  br label %loop.header0
afterloop3:
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = call i8* @tokens_to_text({ i8**, i64 }* %t22)
  store i8* %t23, i8** %l4
  store double 0.0, double* %l5
  %t24 = insertvalue %StatementParseResult undef, i8* null, 0
  %t25 = load double, double* %l5
  %t26 = insertvalue %StatementParseResult %t24, i8* null, 1
  ret %StatementParseResult %t26
}

define i1 @identifier_matches(i8* %token, i8* %expected) {
entry:
  ret i1 false
}

define i8* @identifier_text(i8* %token) {
entry:
  ret i8* null
}

define i8* @string_literal_value(i8* %token) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %t1 = call i8* @strip_surrounding_quotes(i8* null)
  ret i8* %t1
}

define %Parser @skip_trivia(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca i8*
  store %Parser %parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  br label %loop.header0
loop.header0:
  %t22 = phi %Parser [ %t0, %entry ], [ %t21, %loop.latch2 ]
  store %Parser %t22, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t1 = load %Parser, %Parser* %l0
  %t2 = extractvalue %Parser %t1, 1
  %t3 = load %Parser, %Parser* %l0
  %t4 = extractvalue %Parser %t3, 0
  %t5 = load %Parser, %Parser* %l0
  %t6 = extractvalue %Parser %t5, 0
  %t7 = load %Parser, %Parser* %l0
  %t8 = extractvalue %Parser %t7, 1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %t6
  %t10 = extractvalue { i8**, i64 } %t9, 0
  %t11 = extractvalue { i8**, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  %t13 = getelementptr i8*, i8** %t10, i64 %t8
  %t14 = load i8*, i8** %t13
  store i8* %t14, i8** %l1
  %t15 = load i8*, i8** %l1
  %t16 = call i1 @is_trivia_token(i8* %t15)
  %t17 = load %Parser, %Parser* %l0
  %t18 = load i8*, i8** %l1
  br i1 %t16, label %then4, label %merge5
then4:
  %t19 = load %Parser, %Parser* %l0
  %t20 = call %Parser @parser_advance_raw(%Parser %t19)
  store %Parser %t20, %Parser* %l0
  br label %loop.latch2
merge5:
  br label %afterloop3
loop.latch2:
  %t21 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t23 = load %Parser, %Parser* %l0
  ret %Parser %t23
}

define %Parser @parser_advance_raw(%Parser %parser) {
entry:
  %t0 = extractvalue %Parser %parser, 1
  %t1 = sitofp i64 1 to double
  %t2 = fadd double %t0, %t1
  %t3 = extractvalue %Parser %parser, 0
  ret %Parser zeroinitializer
}

define %Parser @consume_keyword(%Parser %parser, i8* %keyword) {
entry:
  %l0 = alloca double
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = call i1 @identifier_matches(i8* null, i8* %keyword)
  %t3 = load double, double* %l0
  br i1 %t2, label %then0, label %merge1
then0:
  %t4 = call %Parser @parser_advance_raw(%Parser %parser)
  ret %Parser %t4
merge1:
  ret %Parser %parser
}

define %Parser @consume_symbol(%Parser %parser, i8* %symbol) {
entry:
  %l0 = alloca double
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l0
  %t2 = load double, double* %l0
  ret %Parser %parser
}

define %CaptureResult @collect_until(%Parser %parser, { i8**, i64 }* %terminators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
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
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l3
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l4
  %t8 = load %Parser, %Parser* %l0
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t10 = load double, double* %l2
  %t11 = load double, double* %l3
  %t12 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t59 = phi { i8**, i64 }* [ %t9, %entry ], [ %t57, %loop.latch2 ]
  %t60 = phi %Parser [ %t8, %entry ], [ %t58, %loop.latch2 ]
  store { i8**, i64 }* %t59, { i8**, i64 }** %l1
  store %Parser %t60, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t13 = load %Parser, %Parser* %l0
  %t14 = call double @parser_peek_raw(%Parser %t13)
  store double %t14, double* %l5
  %t15 = load double, double* %l5
  %t18 = load double, double* %l2
  %t19 = sitofp i64 0 to double
  %t20 = fcmp oeq double %t18, %t19
  br label %logical_and_entry_17

logical_and_entry_17:
  br i1 %t20, label %logical_and_right_17, label %logical_and_merge_17

logical_and_right_17:
  %t21 = load double, double* %l3
  %t22 = sitofp i64 0 to double
  %t23 = fcmp oeq double %t21, %t22
  br label %logical_and_right_end_17

logical_and_right_end_17:
  br label %logical_and_merge_17

logical_and_merge_17:
  %t24 = phi i1 [ false, %logical_and_entry_17 ], [ %t23, %logical_and_right_end_17 ]
  br label %logical_and_entry_16

logical_and_entry_16:
  br i1 %t24, label %logical_and_right_16, label %logical_and_merge_16

logical_and_right_16:
  %t25 = load double, double* %l4
  %t26 = sitofp i64 0 to double
  %t27 = fcmp oeq double %t25, %t26
  br label %logical_and_right_end_16

logical_and_right_end_16:
  br label %logical_and_merge_16

logical_and_merge_16:
  %t28 = phi i1 [ false, %logical_and_entry_16 ], [ %t27, %logical_and_right_end_16 ]
  store i1 %t28, i1* %l6
  %t29 = load i1, i1* %l6
  %t30 = load %Parser, %Parser* %l0
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t32 = load double, double* %l2
  %t33 = load double, double* %l3
  %t34 = load double, double* %l4
  %t35 = load double, double* %l5
  %t36 = load i1, i1* %l6
  br i1 %t29, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t38 = load double, double* %l5
  %t39 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t37, i8* null)
  store { i8**, i64 }* %t39, { i8**, i64 }** %l1
  %t40 = load double, double* %l5
  %t41 = load %Parser, %Parser* %l0
  %t42 = call %Parser @parser_advance_raw(%Parser %t41)
  store %Parser %t42, %Parser* %l7
  %t43 = load %Parser, %Parser* %l7
  %t44 = extractvalue %Parser %t43, 1
  %t45 = load %Parser, %Parser* %l0
  %t46 = extractvalue %Parser %t45, 1
  %t47 = fcmp oeq double %t44, %t46
  %t48 = load %Parser, %Parser* %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t50 = load double, double* %l2
  %t51 = load double, double* %l3
  %t52 = load double, double* %l4
  %t53 = load double, double* %l5
  %t54 = load i1, i1* %l6
  %t55 = load %Parser, %Parser* %l7
  br i1 %t47, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t56 = load %Parser, %Parser* %l7
  store %Parser %t56, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t58 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t61 = load %Parser, %Parser* %l0
  %t62 = insertvalue %CaptureResult undef, i8* null, 0
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t64 = insertvalue %CaptureResult %t62, { i8**, i64 }* %t63, 1
  ret %CaptureResult %t64
}

define %ParenthesizedParseResult @collect_parenthesized(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca double
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l1
  %t4 = load double, double* %l1
  %t5 = load %Parser, %Parser* %l0
  %t6 = call %Parser @parser_advance_raw(%Parser %t5)
  store %Parser %t6, %Parser* %l0
  %t7 = alloca [0 x double]
  %t8 = getelementptr [0 x double], [0 x double]* %t7, i32 0, i32 0
  %t9 = alloca { double*, i64 }
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t9, i32 0, i32 0
  store double* %t8, double** %t10
  %t11 = getelementptr { double*, i64 }, { double*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t12 = sitofp i64 1 to double
  store double %t12, double* %l3
  %t13 = load %Parser, %Parser* %l0
  %t14 = load double, double* %l1
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t16 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t28 = phi { i8**, i64 }* [ %t15, %entry ], [ %t26, %loop.latch2 ]
  %t29 = phi %Parser [ %t13, %entry ], [ %t27, %loop.latch2 ]
  store { i8**, i64 }* %t28, { i8**, i64 }** %l2
  store %Parser %t29, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t17 = load %Parser, %Parser* %l0
  %t18 = call double @parser_peek_raw(%Parser %t17)
  store double %t18, double* %l4
  %t19 = load double, double* %l4
  %t20 = load double, double* %l4
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t22 = load double, double* %l4
  %t23 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t21, i8* null)
  store { i8**, i64 }* %t23, { i8**, i64 }** %l2
  %t24 = load %Parser, %Parser* %l0
  %t25 = call %Parser @parser_advance_raw(%Parser %t24)
  store %Parser %t25, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t27 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t30 = load %Parser, %Parser* %l0
  %t31 = insertvalue %ParenthesizedParseResult undef, i8* null, 0
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t33 = insertvalue %ParenthesizedParseResult %t31, { i8**, i64 }* %t32, 1
  %t34 = insertvalue %ParenthesizedParseResult %t33, i1 1, 2
  ret %ParenthesizedParseResult %t34
}

define %PatternCaptureResult @collect_pattern_until_arrow(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
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
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t6 = load %Parser, %Parser* %l0
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t37 = phi { i8**, i64 }* [ %t7, %entry ], [ %t35, %loop.latch2 ]
  %t38 = phi %Parser [ %t6, %entry ], [ %t36, %loop.latch2 ]
  store { i8**, i64 }* %t37, { i8**, i64 }** %l1
  store %Parser %t38, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t8 = load %Parser, %Parser* %l0
  %t9 = call double @parser_peek_raw(%Parser %t8)
  store double %t9, double* %l2
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t13 = load double, double* %l2
  %t14 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t12, i8* null)
  store { i8**, i64 }* %t14, { i8**, i64 }** %l1
  %t15 = load %Parser, %Parser* %l0
  %t16 = call %Parser @parser_advance_raw(%Parser %t15)
  store %Parser %t16, %Parser* %l3
  %t17 = load %Parser, %Parser* %l3
  %t18 = extractvalue %Parser %t17, 1
  %t19 = load %Parser, %Parser* %l0
  %t20 = extractvalue %Parser %t19, 1
  %t21 = fcmp oeq double %t18, %t20
  %t22 = load %Parser, %Parser* %l0
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t24 = load double, double* %l2
  %t25 = load %Parser, %Parser* %l3
  br i1 %t21, label %then4, label %merge5
then4:
  %t26 = insertvalue %PatternCaptureResult undef, i8* null, 0
  %t27 = alloca [0 x double]
  %t28 = getelementptr [0 x double], [0 x double]* %t27, i32 0, i32 0
  %t29 = alloca { double*, i64 }
  %t30 = getelementptr { double*, i64 }, { double*, i64 }* %t29, i32 0, i32 0
  store double* %t28, double** %t30
  %t31 = getelementptr { double*, i64 }, { double*, i64 }* %t29, i32 0, i32 1
  store i64 0, i64* %t31
  %t32 = insertvalue %PatternCaptureResult %t26, { i8**, i64 }* null, 1
  %t33 = insertvalue %PatternCaptureResult %t32, i1 0, 2
  ret %PatternCaptureResult %t33
merge5:
  %t34 = load %Parser, %Parser* %l3
  store %Parser %t34, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t36 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t39 = load %Parser, %Parser* %l0
  %t40 = insertvalue %PatternCaptureResult undef, i8* null, 0
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t42 = insertvalue %PatternCaptureResult %t40, { i8**, i64 }* %t41, 1
  %t43 = insertvalue %PatternCaptureResult %t42, i1 1, 2
  ret %PatternCaptureResult %t43
}

define %MatchCaseTokenSplit @split_match_case_tokens({ i8**, i64 }* %tokens) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %t0 = call { i8**, i64 }* @trim_token_edges({ i8**, i64 }* %tokens)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %t1 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t2 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s3 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.3, i32 0, i32 0
  %t4 = call double @find_top_level_identifier({ i8**, i64 }* %t2, i8* %s3)
  store double %t4, double* %l1
  %t5 = load double, double* %l1
  %t6 = sitofp i64 -1 to double
  %t7 = fcmp oeq double %t5, %t6
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then0, label %merge1
then0:
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = insertvalue %MatchCaseTokenSplit undef, { i8**, i64 }* %t10, 0
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
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = sitofp i64 0 to double
  %t22 = call { i8**, i64 }* @token_slice({ i8**, i64 }* %t19, double %t21, double %t20)
  %t23 = call { i8**, i64 }* @trim_token_edges({ i8**, i64 }* %t22)
  store { i8**, i64 }* %t23, { i8**, i64 }** %l2
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  store double 0.0, double* %l3
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t30 = insertvalue %MatchCaseTokenSplit undef, { i8**, i64 }* %t29, 0
  %t31 = load double, double* %l3
  %t32 = insertvalue %MatchCaseTokenSplit %t30, { i8**, i64 }* null, 1
  %t33 = insertvalue %MatchCaseTokenSplit %t32, i1 1, 2
  ret %MatchCaseTokenSplit %t33
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
  %t21 = phi double [ %t4, %entry ], [ %t20, %loop.latch2 ]
  store double %t21, double* %l1
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = load double, double* %l1
  %t7 = getelementptr i8, i8* %text, i64 %t6
  %t8 = load i8, i8* %t7
  store i8 %t8, i8* %l2
  %t9 = load i8, i8* %l2
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  %t11 = load i8, i8* %l2
  %t12 = call double @is_decimal_digit(i8 %t11)
  %t13 = fcmp one double %t12, 0.0
  %t14 = load i1, i1* %l0
  %t15 = load double, double* %l1
  %t16 = load i8, i8* %l2
  br i1 %t13, label %then4, label %merge5
then4:
  ret i1 0
merge5:
  %t17 = load double, double* %l1
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l1
  br label %loop.latch2
loop.latch2:
  %t20 = load double, double* %l1
  br label %loop.header0
afterloop3:
  ret i1 1
}

define i1 @is_decimal_digit(i8* %ch) {
entry:
  %s9 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.9, i32 0, i32 0
  %t10 = icmp eq i8* %ch, %s9
  br label %logical_or_entry_8

logical_or_entry_8:
  br i1 %t10, label %logical_or_merge_8, label %logical_or_right_8

logical_or_right_8:
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %t12 = icmp eq i8* %ch, %s11
  br label %logical_or_right_end_8

logical_or_right_end_8:
  br label %logical_or_merge_8

logical_or_merge_8:
  %t13 = phi i1 [ true, %logical_or_entry_8 ], [ %t12, %logical_or_right_end_8 ]
  br label %logical_or_entry_7

logical_or_entry_7:
  br i1 %t13, label %logical_or_merge_7, label %logical_or_right_7

logical_or_right_7:
  %s14 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.14, i32 0, i32 0
  %t15 = icmp eq i8* %ch, %s14
  br label %logical_or_right_end_7

logical_or_right_end_7:
  br label %logical_or_merge_7

logical_or_merge_7:
  %t16 = phi i1 [ true, %logical_or_entry_7 ], [ %t15, %logical_or_right_end_7 ]
  br label %logical_or_entry_6

logical_or_entry_6:
  br i1 %t16, label %logical_or_merge_6, label %logical_or_right_6

logical_or_right_6:
  %s17 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.17, i32 0, i32 0
  %t18 = icmp eq i8* %ch, %s17
  br label %logical_or_right_end_6

logical_or_right_end_6:
  br label %logical_or_merge_6

logical_or_merge_6:
  %t19 = phi i1 [ true, %logical_or_entry_6 ], [ %t18, %logical_or_right_end_6 ]
  br label %logical_or_entry_5

logical_or_entry_5:
  br i1 %t19, label %logical_or_merge_5, label %logical_or_right_5

logical_or_right_5:
  %s20 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.20, i32 0, i32 0
  %t21 = icmp eq i8* %ch, %s20
  br label %logical_or_right_end_5

logical_or_right_end_5:
  br label %logical_or_merge_5

logical_or_merge_5:
  %t22 = phi i1 [ true, %logical_or_entry_5 ], [ %t21, %logical_or_right_end_5 ]
  br label %logical_or_entry_4

logical_or_entry_4:
  br i1 %t22, label %logical_or_merge_4, label %logical_or_right_4

logical_or_right_4:
  %s23 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.23, i32 0, i32 0
  %t24 = icmp eq i8* %ch, %s23
  br label %logical_or_right_end_4

logical_or_right_end_4:
  br label %logical_or_merge_4

logical_or_merge_4:
  %t25 = phi i1 [ true, %logical_or_entry_4 ], [ %t24, %logical_or_right_end_4 ]
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t25, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %s26 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.26, i32 0, i32 0
  %t27 = icmp eq i8* %ch, %s26
  br label %logical_or_right_end_3

logical_or_right_end_3:
  br label %logical_or_merge_3

logical_or_merge_3:
  %t28 = phi i1 [ true, %logical_or_entry_3 ], [ %t27, %logical_or_right_end_3 ]
  br label %logical_or_entry_2

logical_or_entry_2:
  br i1 %t28, label %logical_or_merge_2, label %logical_or_right_2

logical_or_right_2:
  %s29 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.29, i32 0, i32 0
  %t30 = icmp eq i8* %ch, %s29
  br label %logical_or_right_end_2

logical_or_right_end_2:
  br label %logical_or_merge_2

logical_or_merge_2:
  %t31 = phi i1 [ true, %logical_or_entry_2 ], [ %t30, %logical_or_right_end_2 ]
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t31, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %s32 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.32, i32 0, i32 0
  %t33 = icmp eq i8* %ch, %s32
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t34 = phi i1 [ true, %logical_or_entry_1 ], [ %t33, %logical_or_right_end_1 ]
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t34, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %s35 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.35, i32 0, i32 0
  %t36 = icmp eq i8* %ch, %s35
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t37 = phi i1 [ true, %logical_or_entry_0 ], [ %t36, %logical_or_right_end_0 ]
  ret i1 %t37
}

define { i8**, i64 }* @trim_token_edges({ i8**, i64 }* %tokens) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t24 = phi double [ %t1, %entry ], [ %t23, %loop.latch2 ]
  store double %t24, double* %l0
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
  %t9 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t10 = extractvalue { i8**, i64 } %t9, 0
  %t11 = extractvalue { i8**, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  %t13 = getelementptr i8*, i8** %t10, i64 %t8
  %t14 = load i8*, i8** %t13
  store i8* %t14, i8** %l2
  %t15 = load i8*, i8** %l2
  %t16 = call i1 @is_trivia_token(i8* %t15)
  %t17 = load double, double* %l0
  %t18 = load double, double* %l1
  %t19 = load i8*, i8** %l2
  br i1 %t16, label %then6, label %merge7
then6:
  %t20 = load double, double* %l0
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t23 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t25 = load double, double* %l0
  %t26 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t41 = phi double [ %t26, %entry ], [ %t40, %loop.latch10 ]
  store double %t41, double* %l1
  br label %loop.body9
loop.body9:
  %t27 = load double, double* %l1
  %t28 = load double, double* %l0
  %t29 = fcmp ole double %t27, %t28
  %t30 = load double, double* %l0
  %t31 = load double, double* %l1
  br i1 %t29, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store double 0.0, double* %l3
  %t32 = load double, double* %l3
  %t33 = call i1 @is_trivia_token(i8* null)
  %t34 = load double, double* %l0
  %t35 = load double, double* %l1
  %t36 = load double, double* %l3
  br i1 %t33, label %then14, label %merge15
then14:
  %t37 = load double, double* %l1
  %t38 = sitofp i64 1 to double
  %t39 = fsub double %t37, %t38
  store double %t39, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t40 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t42 = load double, double* %l0
  %t43 = load double, double* %l1
  %t44 = call { i8**, i64 }* @token_slice({ i8**, i64 }* %tokens, double %t42, double %t43)
  ret { i8**, i64 }* %t44
}

define { i8**, i64 }* @token_slice({ i8**, i64 }* %tokens, double %start, double %end) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  store double %start, double* %l1
  %t5 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t6 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t25 = phi { i8**, i64 }* [ %t5, %entry ], [ %t23, %loop.latch2 ]
  %t26 = phi double [ %t6, %entry ], [ %t24, %loop.latch2 ]
  store { i8**, i64 }* %t25, { i8**, i64 }** %l0
  store double %t26, double* %l1
  br label %loop.body1
loop.body1:
  %t7 = load double, double* %l1
  %t8 = fcmp oge double %t7, %end
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l1
  br i1 %t8, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load double, double* %l1
  %t13 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t14 = extractvalue { i8**, i64 } %t13, 0
  %t15 = extractvalue { i8**, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  %t17 = getelementptr i8*, i8** %t14, i64 %t12
  %t18 = load i8*, i8** %t17
  %t19 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t11, i8* %t18)
  store { i8**, i64 }* %t19, { i8**, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l1
  br label %loop.latch2
loop.latch2:
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t27
}

define { i8**, i64 }* @trim_block_tokens({ i8**, i64 }* %tokens) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  store double 0.0, double* %l2
  %t2 = load double, double* %l0
  %t3 = load double, double* %l1
  %t4 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t18 = phi double [ %t3, %entry ], [ %t17, %loop.latch2 ]
  store double %t18, double* %l1
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = load double, double* %l1
  %t7 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t8 = extractvalue { i8**, i64 } %t7, 0
  %t9 = extractvalue { i8**, i64 } %t7, 1
  %t10 = icmp uge i64 %t6, %t9
  ; bounds check: %t10 (if true, out of bounds)
  %t11 = getelementptr i8*, i8** %t8, i64 %t6
  %t12 = load i8*, i8** %t11
  store i8* %t12, i8** %l3
  %t13 = load i8*, i8** %l3
  %t14 = load double, double* %l1
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  store double %t16, double* %l1
  br label %loop.latch2
loop.latch2:
  %t17 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t19 = load double, double* %l2
  %t20 = sitofp i64 0 to double
  %t21 = call { i8**, i64 }* @token_slice({ i8**, i64 }* %tokens, double %t20, double %t19)
  ret { i8**, i64 }* %t21
}

define double @find_top_level_colon({ i8**, i64 }* %tokens) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
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
  %t23 = phi double [ %t9, %entry ], [ %t22, %loop.latch2 ]
  store double %t23, double* %l4
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l4
  %t11 = load double, double* %l4
  %t12 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t13 = extractvalue { i8**, i64 } %t12, 0
  %t14 = extractvalue { i8**, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr i8*, i8** %t13, i64 %t11
  %t17 = load i8*, i8** %t16
  store i8* %t17, i8** %l5
  %t18 = load i8*, i8** %l5
  %t19 = load double, double* %l4
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l4
  br label %loop.latch2
loop.latch2:
  %t22 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t24 = sitofp i64 -1 to double
  ret double %t24
}

define %ExpressionCollectResult @expression_tokens_collect_until(%ExpressionTokens %state, { i8**, i64 }* %terminators) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i1
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l3
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l4
  %t8 = sitofp i64 0 to double
  store double %t8, double* %l5
  %t9 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t11 = load double, double* %l2
  %t12 = load double, double* %l3
  %t13 = load double, double* %l4
  %t14 = load double, double* %l5
  br label %loop.header0
loop.header0:
  %t60 = phi { i8**, i64 }* [ %t10, %entry ], [ %t58, %loop.latch2 ]
  %t61 = phi %ExpressionTokens [ %t9, %entry ], [ %t59, %loop.latch2 ]
  store { i8**, i64 }* %t60, { i8**, i64 }** %l1
  store %ExpressionTokens %t61, %ExpressionTokens* %l0
  br label %loop.body1
loop.body1:
  %t15 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t16 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t15)
  %t17 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t19 = load double, double* %l2
  %t20 = load double, double* %l3
  %t21 = load double, double* %l4
  %t22 = load double, double* %l5
  br i1 %t16, label %then4, label %merge5
then4:
  %t23 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t24 = insertvalue %ExpressionCollectResult undef, i8* null, 0
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t26 = insertvalue %ExpressionCollectResult %t24, { i8**, i64 }* %t25, 1
  %t27 = insertvalue %ExpressionCollectResult %t26, i1 0, 2
  ret %ExpressionCollectResult %t27
merge5:
  %t28 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t29 = call double @expression_tokens_peek(%ExpressionTokens %t28)
  store double %t29, double* %l6
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
  %t51 = load double, double* %l6
  %t52 = load double, double* %l6
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t54 = load double, double* %l6
  %t55 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t53, i8* null)
  store { i8**, i64 }* %t55, { i8**, i64 }** %l1
  %t56 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t57 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t56)
  store %ExpressionTokens %t57, %ExpressionTokens* %l0
  br label %loop.latch2
loop.latch2:
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header0
afterloop3:
  %t62 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t63 = insertvalue %ExpressionCollectResult undef, i8* null, 0
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t65 = insertvalue %ExpressionCollectResult %t63, { i8**, i64 }* %t64, 1
  %t66 = insertvalue %ExpressionCollectResult %t65, i1 1, 2
  ret %ExpressionCollectResult %t66
}

define %ExpressionBlockParseResult @collect_expression_block(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca double
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
  %t13 = call double @expression_tokens_peek(%ExpressionTokens %t12)
  store double %t13, double* %l1
  %t15 = load double, double* %l1
  %t16 = alloca [0 x double]
  %t17 = getelementptr [0 x double], [0 x double]* %t16, i32 0, i32 0
  %t18 = alloca { double*, i64 }
  %t19 = getelementptr { double*, i64 }, { double*, i64 }* %t18, i32 0, i32 0
  store double* %t17, double** %t19
  %t20 = getelementptr { double*, i64 }, { double*, i64 }* %t18, i32 0, i32 1
  store i64 0, i64* %t20
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t21 = sitofp i64 0 to double
  store double %t21, double* %l3
  %t22 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t23 = load double, double* %l1
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t25 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t47 = phi { i8**, i64 }* [ %t24, %entry ], [ %t45, %loop.latch4 ]
  %t48 = phi %ExpressionTokens [ %t22, %entry ], [ %t46, %loop.latch4 ]
  store { i8**, i64 }* %t47, { i8**, i64 }** %l2
  store %ExpressionTokens %t48, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t26 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t27 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t26)
  %t28 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t29 = load double, double* %l1
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t31 = load double, double* %l3
  br i1 %t27, label %then6, label %merge7
then6:
  %t32 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t33 = insertvalue %ExpressionBlockParseResult undef, i8* null, 0
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t35 = insertvalue %ExpressionBlockParseResult %t33, { i8**, i64 }* %t34, 1
  %t36 = insertvalue %ExpressionBlockParseResult %t35, i1 0, 2
  ret %ExpressionBlockParseResult %t36
merge7:
  %t37 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t38 = call double @expression_tokens_peek(%ExpressionTokens %t37)
  store double %t38, double* %l4
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t40 = load double, double* %l4
  %t41 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t39, i8* null)
  store { i8**, i64 }* %t41, { i8**, i64 }** %l2
  %t42 = load double, double* %l4
  %t43 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t44 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t43)
  store %ExpressionTokens %t44, %ExpressionTokens* %l0
  br label %loop.latch4
loop.latch4:
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t46 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t49 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t50 = insertvalue %ExpressionBlockParseResult undef, i8* null, 0
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t52 = insertvalue %ExpressionBlockParseResult %t50, { i8**, i64 }* %t51, 1
  %t53 = insertvalue %ExpressionBlockParseResult %t52, i1 1, 2
  ret %ExpressionBlockParseResult %t53
}

define %LambdaParameterParseResult @parse_lambda_parameter(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca { i8**, i64 }*
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
  %t5 = insertvalue %LambdaParameterParseResult %t4, i8* null, 1
  %t6 = insertvalue %LambdaParameterParseResult %t5, i1 0, 2
  ret %LambdaParameterParseResult %t6
merge1:
  %t7 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t8 = extractvalue %ExpressionTokens %t7, 1
  store double %t8, double* %l1
  store i1 0, i1* %l2
  %t9 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t10 = call double @expression_tokens_peek(%ExpressionTokens %t9)
  store double %t10, double* %l3
  %t12 = load double, double* %l3
  %t13 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t14 = call double @expression_tokens_peek(%ExpressionTokens %t13)
  store double %t14, double* %l4
  %t15 = load double, double* %l4
  %t16 = load double, double* %l4
  %t17 = call i8* @identifier_text(i8* null)
  store i8* %t17, i8** %l5
  %t18 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t19 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t18)
  store %ExpressionTokens %t19, %ExpressionTokens* %l0
  store i8* null, i8** %l6
  %t20 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t21 = call double @expression_tokens_is_at_end(%ExpressionTokens %t20)
  %t22 = fcmp one double %t21, 0.0
  %t23 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t24 = load double, double* %l1
  %t25 = load i1, i1* %l2
  %t26 = load double, double* %l3
  %t27 = load double, double* %l4
  %t28 = load i8*, i8** %l5
  %t29 = load i8*, i8** %l6
  br i1 %t22, label %then2, label %merge3
then2:
  %t30 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t31 = call double @expression_tokens_peek(%ExpressionTokens %t30)
  store double %t31, double* %l7
  %t34 = load double, double* %l7
  br label %merge3
merge3:
  store i8* null, i8** %l8
  %t35 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t36 = call double @expression_tokens_is_at_end(%ExpressionTokens %t35)
  %t37 = fcmp one double %t36, 0.0
  %t38 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t39 = load double, double* %l1
  %t40 = load i1, i1* %l2
  %t41 = load double, double* %l3
  %t42 = load double, double* %l4
  %t43 = load i8*, i8** %l5
  %t44 = load i8*, i8** %l6
  %t45 = load i8*, i8** %l8
  br i1 %t37, label %then4, label %merge5
then4:
  %t46 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t47 = call double @expression_tokens_peek(%ExpressionTokens %t46)
  store double %t47, double* %l9
  %t49 = load double, double* %l9
  br label %merge5
merge5:
  %t50 = extractvalue %ExpressionTokens %state, 0
  %t51 = load double, double* %l1
  %t52 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t53 = extractvalue %ExpressionTokens %t52, 1
  %t54 = call { i8**, i64 }* @token_slice({ i8**, i64 }* %t50, double %t51, double %t53)
  store { i8**, i64 }* %t54, { i8**, i64 }** %l10
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t56 = call double @source_span_from_tokens({ i8**, i64 }* %t55)
  store double %t56, double* %l11
  store double 0.0, double* %l12
  %t57 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t58 = insertvalue %LambdaParameterParseResult undef, i8* null, 0
  %t59 = load double, double* %l12
  %t60 = insertvalue %LambdaParameterParseResult %t58, i8* null, 1
  %t61 = insertvalue %LambdaParameterParseResult %t60, i1 1, 2
  ret %LambdaParameterParseResult %t61
}

define %LambdaParameterListParseResult @parse_lambda_parameter_list(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %LambdaParameterParseResult
  %l4 = alloca double
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t5 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t6 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t5)
  %t7 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t6, label %then0, label %merge1
then0:
  %t9 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t10 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t12 = insertvalue %LambdaParameterListParseResult %t10, { i8**, i64 }* %t11, 1
  %t13 = insertvalue %LambdaParameterListParseResult %t12, i1 0, 2
  ret %LambdaParameterListParseResult %t13
merge1:
  %t14 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t15 = call double @expression_tokens_peek(%ExpressionTokens %t14)
  store double %t15, double* %l2
  %t16 = load double, double* %l2
  %t17 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t19 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t49 = phi { i8**, i64 }* [ %t18, %entry ], [ %t47, %loop.latch4 ]
  %t50 = phi %ExpressionTokens [ %t17, %entry ], [ %t48, %loop.latch4 ]
  store { i8**, i64 }* %t49, { i8**, i64 }** %l1
  store %ExpressionTokens %t50, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t20 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t21 = call %LambdaParameterParseResult @parse_lambda_parameter(%ExpressionTokens %t20)
  store %LambdaParameterParseResult %t21, %LambdaParameterParseResult* %l3
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t23 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  %t24 = extractvalue %LambdaParameterParseResult %t23, 1
  %t25 = call { i8**, i64 }* @append_parameter({ i8**, i64 }* %t22, i8* %t24)
  store { i8**, i64 }* %t25, { i8**, i64 }** %l1
  %t26 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  %t27 = extractvalue %LambdaParameterParseResult %t26, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t28 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t29 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t28)
  %t30 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t32 = load double, double* %l2
  %t33 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  br i1 %t29, label %then6, label %merge7
then6:
  %t34 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t35 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t37 = insertvalue %LambdaParameterListParseResult %t35, { i8**, i64 }* %t36, 1
  %t38 = insertvalue %LambdaParameterListParseResult %t37, i1 0, 2
  ret %LambdaParameterListParseResult %t38
merge7:
  %t39 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t40 = call double @expression_tokens_peek(%ExpressionTokens %t39)
  store double %t40, double* %l4
  %t41 = load double, double* %l4
  %t42 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t43 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t45 = insertvalue %LambdaParameterListParseResult %t43, { i8**, i64 }* %t44, 1
  %t46 = insertvalue %LambdaParameterListParseResult %t45, i1 0, 2
  ret %LambdaParameterListParseResult %t46
loop.latch4:
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t48 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t51 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t52 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t54 = insertvalue %LambdaParameterListParseResult %t52, { i8**, i64 }* %t53, 1
  %t55 = insertvalue %LambdaParameterListParseResult %t54, i1 1, 2
  ret %LambdaParameterListParseResult %t55
}

define %ExpressionParseResult @parse_lambda_expression(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca %LambdaParameterListParseResult
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca i8*
  %l6 = alloca double
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
  %t5 = call double @expression_tokens_peek(%ExpressionTokens %t4)
  store double %t5, double* %l1
  %t7 = load double, double* %l1
  %t8 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t9 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t8)
  store %ExpressionTokens %t9, %ExpressionTokens* %l0
  %t10 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t11 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t10)
  %t12 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t13 = load double, double* %l1
  br i1 %t11, label %then2, label %merge3
then2:
  %t14 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t14
merge3:
  %t15 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t16 = call double @expression_tokens_peek(%ExpressionTokens %t15)
  store double %t16, double* %l2
  %t18 = load double, double* %l2
  %t19 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t20 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t19)
  store %ExpressionTokens %t20, %ExpressionTokens* %l0
  %t21 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t22 = call %LambdaParameterListParseResult @parse_lambda_parameter_list(%ExpressionTokens %t21)
  store %LambdaParameterListParseResult %t22, %LambdaParameterListParseResult* %l3
  %t23 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t24 = extractvalue %LambdaParameterListParseResult %t23, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t25 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t26 = extractvalue %LambdaParameterListParseResult %t25, 1
  store { i8**, i64 }* %t26, { i8**, i64 }** %l4
  store i8* null, i8** %l5
  %t27 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t28 = call double @expression_tokens_is_at_end(%ExpressionTokens %t27)
  %t29 = fcmp one double %t28, 0.0
  %t30 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t31 = load double, double* %l1
  %t32 = load double, double* %l2
  %t33 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t35 = load i8*, i8** %l5
  br i1 %t29, label %then4, label %merge5
then4:
  %t36 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t37 = call double @expression_tokens_peek(%ExpressionTokens %t36)
  store double %t37, double* %l6
  %t40 = load double, double* %l6
  br label %merge5
merge5:
  %t41 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t42 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t41)
  %t43 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t44 = load double, double* %l1
  %t45 = load double, double* %l2
  %t46 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t48 = load i8*, i8** %l5
  br i1 %t42, label %then6, label %merge7
then6:
  %t49 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t49
merge7:
  %t50 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t51 = call %ExpressionBlockParseResult @collect_expression_block(%ExpressionTokens %t50)
  store %ExpressionBlockParseResult %t51, %ExpressionBlockParseResult* %l7
  %t52 = load %ExpressionBlockParseResult, %ExpressionBlockParseResult* %l7
  %t53 = extractvalue %ExpressionBlockParseResult %t52, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t54 = load %ExpressionBlockParseResult, %ExpressionBlockParseResult* %l7
  %t55 = extractvalue %ExpressionBlockParseResult %t54, 1
  store { i8**, i64 }* %t55, { i8**, i64 }** %l8
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t57 = insertvalue %Parser undef, { i8**, i64 }* %t56, 0
  %t58 = sitofp i64 0 to double
  %t59 = insertvalue %Parser %t57, double %t58, 1
  store %Parser %t59, %Parser* %l9
  %t60 = load %Parser, %Parser* %l9
  %t61 = call %BlockParseResult @parse_block(%Parser %t60)
  store %BlockParseResult %t61, %BlockParseResult* %l10
  %t62 = load %BlockParseResult, %BlockParseResult* %l10
  %t63 = extractvalue %BlockParseResult %t62, 1
  store i8* %t63, i8** %l11
  %t64 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t65 = insertvalue %ExpressionParseResult undef, i8* null, 0
  %t66 = insertvalue %ExpressionParseResult %t65, i8* null, 1
  %t67 = insertvalue %ExpressionParseResult %t66, i1 1, 2
  ret %ExpressionParseResult %t67
}

define %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %state, double %min_precedence) {
entry:
  %l0 = alloca %ExpressionParseResult
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca %ExpressionParseResult
  %t0 = call %ExpressionParseResult @parse_prefix_expression(%ExpressionTokens %state)
  store %ExpressionParseResult %t0, %ExpressionParseResult* %l0
  %t1 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t2 = extractvalue %ExpressionParseResult %t1, 0
  store i8* %t2, i8** %l1
  %t3 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t4 = extractvalue %ExpressionParseResult %t3, 1
  store i8* %t4, i8** %l2
  %t5 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t6 = load i8*, i8** %l1
  %t7 = load i8*, i8** %l2
  br label %loop.header0
loop.header0:
  %t48 = phi i8* [ %t6, %entry ], [ %t47, %loop.latch2 ]
  store i8* %t48, i8** %l1
  br label %loop.body1
loop.body1:
  %t8 = load i8*, i8** %l1
  %t9 = call i1 @expression_tokens_is_at_end(%ExpressionTokens zeroinitializer)
  %t10 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t11 = load i8*, i8** %l1
  %t12 = load i8*, i8** %l2
  br i1 %t9, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t13 = load i8*, i8** %l1
  %t14 = call double @expression_tokens_peek(%ExpressionTokens zeroinitializer)
  store double %t14, double* %l3
  %t15 = load double, double* %l3
  %t16 = load double, double* %l3
  store double 0.0, double* %l4
  %t17 = load double, double* %l4
  %t18 = call double @binary_precedence(i8* null)
  store double %t18, double* %l5
  %t19 = load double, double* %l5
  %t20 = sitofp i64 -1 to double
  %t21 = fcmp oeq double %t19, %t20
  %t22 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t23 = load i8*, i8** %l1
  %t24 = load i8*, i8** %l2
  %t25 = load double, double* %l3
  %t26 = load double, double* %l4
  %t27 = load double, double* %l5
  br i1 %t21, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t28 = load double, double* %l5
  %t29 = fcmp olt double %t28, %min_precedence
  %t30 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t31 = load i8*, i8** %l1
  %t32 = load i8*, i8** %l2
  %t33 = load double, double* %l3
  %t34 = load double, double* %l4
  %t35 = load double, double* %l5
  br i1 %t29, label %then8, label %merge9
then8:
  br label %afterloop3
merge9:
  %t36 = load i8*, i8** %l1
  %t37 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens zeroinitializer)
  store i8* null, i8** %l1
  %t38 = load i8*, i8** %l1
  %t39 = load double, double* %l5
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  %t42 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens zeroinitializer, double %t41)
  store %ExpressionParseResult %t42, %ExpressionParseResult* %l6
  %t43 = load %ExpressionParseResult, %ExpressionParseResult* %l6
  %t44 = extractvalue %ExpressionParseResult %t43, 0
  store i8* %t44, i8** %l1
  %t45 = load double, double* %l4
  %s46 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.46, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  %t47 = load i8*, i8** %l1
  br label %loop.header0
afterloop3:
  %t49 = load i8*, i8** %l1
  %t50 = insertvalue %ExpressionParseResult undef, i8* %t49, 0
  %t51 = load i8*, i8** %l2
  %t52 = insertvalue %ExpressionParseResult %t50, i8* %t51, 1
  %t53 = insertvalue %ExpressionParseResult %t52, i1 1, 2
  ret %ExpressionParseResult %t53
}

define %ExpressionParseResult @parse_prefix_expression(%ExpressionTokens %state) {
entry:
  %l0 = alloca double
  %l1 = alloca %ExpressionParseResult
  %t0 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %state)
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t1
merge1:
  %t2 = call double @expression_tokens_peek(%ExpressionTokens %state)
  store double %t2, double* %l0
  %t3 = load double, double* %l0
  %t5 = load double, double* %l0
  %t6 = call %ExpressionParseResult @parse_primary_expression(%ExpressionTokens %state)
  store %ExpressionParseResult %t6, %ExpressionParseResult* %l1
  %t7 = load %ExpressionParseResult, %ExpressionParseResult* %l1
  %t8 = extractvalue %ExpressionParseResult %t7, 0
  %t9 = load %ExpressionParseResult, %ExpressionParseResult* %l1
  %t10 = extractvalue %ExpressionParseResult %t9, 1
  %t11 = call %ExpressionParseResult @parse_postfix_chain(%ExpressionTokens zeroinitializer, i8* %t10)
  ret %ExpressionParseResult %t11
}

define %ExpressionParseResult @parse_primary_expression(%ExpressionTokens %state) {
entry:
  %l0 = alloca double
  %t0 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %state)
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t1
merge1:
  %t2 = call double @expression_tokens_peek(%ExpressionTokens %state)
  store double %t2, double* %l0
  %t3 = load double, double* %l0
  %t4 = load double, double* %l0
  %t5 = load double, double* %l0
  %t6 = load double, double* %l0
  %t8 = load double, double* %l0
  %t10 = load double, double* %l0
  %t12 = load double, double* %l0
  %t13 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t13
}

define %ExpressionParseResult @parse_postfix_chain(%ExpressionTokens %state, i8* %expression) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  store i8* %expression, i8** %l1
  %t0 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t1 = load i8*, i8** %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t2 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t3 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t2)
  %t4 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t5 = load i8*, i8** %l1
  br i1 %t3, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t6 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t7 = call double @expression_tokens_peek(%ExpressionTokens %t6)
  store double %t7, double* %l2
  %t8 = load double, double* %l2
  %t9 = load double, double* %l2
  store double 0.0, double* %l3
  %t10 = load double, double* %l3
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %t12 = load double, double* %l3
  %s13 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.13, i32 0, i32 0
  %t14 = load double, double* %l3
  %s15 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.15, i32 0, i32 0
  %t16 = load double, double* %l3
  %s17 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.17, i32 0, i32 0
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t18 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t19 = insertvalue %ExpressionParseResult undef, i8* null, 0
  %t20 = load i8*, i8** %l1
  %t21 = insertvalue %ExpressionParseResult %t19, i8* %t20, 1
  %t22 = insertvalue %ExpressionParseResult %t21, i1 1, 2
  ret %ExpressionParseResult %t22
}

define %CallArgumentsParseResult @parse_call_arguments(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %ExpressionParseResult
  %l3 = alloca double
  %t0 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %state)
  store %ExpressionTokens %t0, %ExpressionTokens* %l0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t6 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t7 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t6)
  %t8 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l1
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
  %t19 = call double @expression_tokens_peek(%ExpressionTokens %t18)
  %t20 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header2
loop.header2:
  %t59 = phi { i8**, i64 }* [ %t21, %entry ], [ %t57, %loop.latch4 ]
  %t60 = phi %ExpressionTokens [ %t20, %entry ], [ %t58, %loop.latch4 ]
  store { i8**, i64 }* %t59, { i8**, i64 }** %l1
  store %ExpressionTokens %t60, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t22 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t23 = sitofp i64 0 to double
  %t24 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %t22, double %t23)
  store %ExpressionParseResult %t24, %ExpressionParseResult* %l2
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t26 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t27 = extractvalue %ExpressionParseResult %t26, 1
  %t28 = call { i8**, i64 }* @append_expression({ i8**, i64 }* %t25, i8* %t27)
  store { i8**, i64 }* %t28, { i8**, i64 }** %l1
  %t29 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t30 = extractvalue %ExpressionParseResult %t29, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t31 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t32 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t31)
  %t33 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t35 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  br i1 %t32, label %then6, label %merge7
then6:
  %t36 = insertvalue %CallArgumentsParseResult undef, i8* null, 0
  %t37 = alloca [0 x double]
  %t38 = getelementptr [0 x double], [0 x double]* %t37, i32 0, i32 0
  %t39 = alloca { double*, i64 }
  %t40 = getelementptr { double*, i64 }, { double*, i64 }* %t39, i32 0, i32 0
  store double* %t38, double** %t40
  %t41 = getelementptr { double*, i64 }, { double*, i64 }* %t39, i32 0, i32 1
  store i64 0, i64* %t41
  %t42 = insertvalue %CallArgumentsParseResult %t36, { i8**, i64 }* null, 1
  %t43 = insertvalue %CallArgumentsParseResult %t42, i1 0, 2
  ret %CallArgumentsParseResult %t43
merge7:
  %t44 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t45 = call double @expression_tokens_peek(%ExpressionTokens %t44)
  store double %t45, double* %l3
  %t47 = load double, double* %l3
  %t48 = load double, double* %l3
  %t49 = insertvalue %CallArgumentsParseResult undef, i8* null, 0
  %t50 = alloca [0 x double]
  %t51 = getelementptr [0 x double], [0 x double]* %t50, i32 0, i32 0
  %t52 = alloca { double*, i64 }
  %t53 = getelementptr { double*, i64 }, { double*, i64 }* %t52, i32 0, i32 0
  store double* %t51, double** %t53
  %t54 = getelementptr { double*, i64 }, { double*, i64 }* %t52, i32 0, i32 1
  store i64 0, i64* %t54
  %t55 = insertvalue %CallArgumentsParseResult %t49, { i8**, i64 }* null, 1
  %t56 = insertvalue %CallArgumentsParseResult %t55, i1 0, 2
  ret %CallArgumentsParseResult %t56
loop.latch4:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t58 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t61 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t62 = insertvalue %CallArgumentsParseResult undef, i8* null, 0
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t64 = insertvalue %CallArgumentsParseResult %t62, { i8**, i64 }* %t63, 1
  %t65 = insertvalue %CallArgumentsParseResult %t64, i1 1, 2
  ret %CallArgumentsParseResult %t65
}

define %ArrayLiteralParseResult @parse_array_literal(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %ExpressionParseResult
  %l3 = alloca double
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t5 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t6 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t5)
  %t7 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l1
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
  %t19 = call double @expression_tokens_peek(%ExpressionTokens %t18)
  %t20 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header2
loop.header2:
  %t60 = phi { i8**, i64 }* [ %t21, %entry ], [ %t58, %loop.latch4 ]
  %t61 = phi %ExpressionTokens [ %t20, %entry ], [ %t59, %loop.latch4 ]
  store { i8**, i64 }* %t60, { i8**, i64 }** %l1
  store %ExpressionTokens %t61, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t22 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t23 = sitofp i64 0 to double
  %t24 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %t22, double %t23)
  store %ExpressionParseResult %t24, %ExpressionParseResult* %l2
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t26 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t27 = extractvalue %ExpressionParseResult %t26, 1
  %t28 = call { i8**, i64 }* @append_expression({ i8**, i64 }* %t25, i8* %t27)
  store { i8**, i64 }* %t28, { i8**, i64 }** %l1
  %t29 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t30 = extractvalue %ExpressionParseResult %t29, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t31 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t32 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t31)
  %t33 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t35 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  br i1 %t32, label %then6, label %merge7
then6:
  %t36 = insertvalue %ArrayLiteralParseResult undef, i8* null, 0
  %t37 = alloca [0 x double]
  %t38 = getelementptr [0 x double], [0 x double]* %t37, i32 0, i32 0
  %t39 = alloca { double*, i64 }
  %t40 = getelementptr { double*, i64 }, { double*, i64 }* %t39, i32 0, i32 0
  store double* %t38, double** %t40
  %t41 = getelementptr { double*, i64 }, { double*, i64 }* %t39, i32 0, i32 1
  store i64 0, i64* %t41
  %t42 = insertvalue %ArrayLiteralParseResult %t36, { i8**, i64 }* null, 1
  %t43 = insertvalue %ArrayLiteralParseResult %t42, i1 0, 2
  ret %ArrayLiteralParseResult %t43
merge7:
  %t44 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t45 = call double @expression_tokens_peek(%ExpressionTokens %t44)
  store double %t45, double* %l3
  %t47 = load double, double* %l3
  %t49 = load double, double* %l3
  %t50 = insertvalue %ArrayLiteralParseResult undef, i8* null, 0
  %t51 = alloca [0 x double]
  %t52 = getelementptr [0 x double], [0 x double]* %t51, i32 0, i32 0
  %t53 = alloca { double*, i64 }
  %t54 = getelementptr { double*, i64 }, { double*, i64 }* %t53, i32 0, i32 0
  store double* %t52, double** %t54
  %t55 = getelementptr { double*, i64 }, { double*, i64 }* %t53, i32 0, i32 1
  store i64 0, i64* %t55
  %t56 = insertvalue %ArrayLiteralParseResult %t50, { i8**, i64 }* null, 1
  %t57 = insertvalue %ArrayLiteralParseResult %t56, i1 0, 2
  ret %ArrayLiteralParseResult %t57
loop.latch4:
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t62 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t63 = insertvalue %ArrayLiteralParseResult undef, i8* null, 0
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t65 = insertvalue %ArrayLiteralParseResult %t63, { i8**, i64 }* %t64, 1
  %t66 = insertvalue %ArrayLiteralParseResult %t65, i1 1, 2
  ret %ArrayLiteralParseResult %t66
}

define %ObjectLiteralParseResult @parse_object_literal(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca %ExpressionParseResult
  %l6 = alloca double
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t5 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t6 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t5)
  %t7 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l1
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
  %t19 = call double @expression_tokens_peek(%ExpressionTokens %t18)
  %t20 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header2
loop.header2:
  %t99 = phi %ExpressionTokens [ %t20, %entry ], [ %t97, %loop.latch4 ]
  %t100 = phi { i8**, i64 }* [ %t21, %entry ], [ %t98, %loop.latch4 ]
  store %ExpressionTokens %t99, %ExpressionTokens* %l0
  store { i8**, i64 }* %t100, { i8**, i64 }** %l1
  br label %loop.body3
loop.body3:
  %t22 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t23 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t22)
  %t24 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t23, label %then6, label %merge7
then6:
  %t26 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t27 = alloca [0 x double]
  %t28 = getelementptr [0 x double], [0 x double]* %t27, i32 0, i32 0
  %t29 = alloca { double*, i64 }
  %t30 = getelementptr { double*, i64 }, { double*, i64 }* %t29, i32 0, i32 0
  store double* %t28, double** %t30
  %t31 = getelementptr { double*, i64 }, { double*, i64 }* %t29, i32 0, i32 1
  store i64 0, i64* %t31
  %t32 = insertvalue %ObjectLiteralParseResult %t26, { i8**, i64 }* null, 1
  %t33 = insertvalue %ObjectLiteralParseResult %t32, i1 0, 2
  ret %ObjectLiteralParseResult %t33
merge7:
  %t34 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t35 = call double @expression_tokens_peek(%ExpressionTokens %t34)
  store double %t35, double* %l2
  %t36 = load double, double* %l2
  %t37 = load double, double* %l2
  %t38 = call i8* @identifier_text(i8* null)
  store i8* %t38, i8** %l3
  %t39 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t40 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t39)
  store %ExpressionTokens %t40, %ExpressionTokens* %l0
  %t41 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t42 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t41)
  %t43 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t45 = load double, double* %l2
  %t46 = load i8*, i8** %l3
  br i1 %t42, label %then8, label %merge9
then8:
  %t47 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t48 = alloca [0 x double]
  %t49 = getelementptr [0 x double], [0 x double]* %t48, i32 0, i32 0
  %t50 = alloca { double*, i64 }
  %t51 = getelementptr { double*, i64 }, { double*, i64 }* %t50, i32 0, i32 0
  store double* %t49, double** %t51
  %t52 = getelementptr { double*, i64 }, { double*, i64 }* %t50, i32 0, i32 1
  store i64 0, i64* %t52
  %t53 = insertvalue %ObjectLiteralParseResult %t47, { i8**, i64 }* null, 1
  %t54 = insertvalue %ObjectLiteralParseResult %t53, i1 0, 2
  ret %ObjectLiteralParseResult %t54
merge9:
  %t55 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t56 = call double @expression_tokens_peek(%ExpressionTokens %t55)
  store double %t56, double* %l4
  %t58 = load double, double* %l4
  %t59 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t60 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t59)
  store %ExpressionTokens %t60, %ExpressionTokens* %l0
  %t61 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t62 = sitofp i64 0 to double
  %t63 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %t61, double %t62)
  store %ExpressionParseResult %t63, %ExpressionParseResult* %l5
  %t64 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  %t65 = extractvalue %ExpressionParseResult %t64, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t67 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t68 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t67)
  %t69 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t71 = load double, double* %l2
  %t72 = load i8*, i8** %l3
  %t73 = load double, double* %l4
  %t74 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  br i1 %t68, label %then10, label %merge11
then10:
  %t75 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t76 = alloca [0 x double]
  %t77 = getelementptr [0 x double], [0 x double]* %t76, i32 0, i32 0
  %t78 = alloca { double*, i64 }
  %t79 = getelementptr { double*, i64 }, { double*, i64 }* %t78, i32 0, i32 0
  store double* %t77, double** %t79
  %t80 = getelementptr { double*, i64 }, { double*, i64 }* %t78, i32 0, i32 1
  store i64 0, i64* %t80
  %t81 = insertvalue %ObjectLiteralParseResult %t75, { i8**, i64 }* null, 1
  %t82 = insertvalue %ObjectLiteralParseResult %t81, i1 0, 2
  ret %ObjectLiteralParseResult %t82
merge11:
  %t83 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t84 = call double @expression_tokens_peek(%ExpressionTokens %t83)
  store double %t84, double* %l6
  %t86 = load double, double* %l6
  %t88 = load double, double* %l6
  %t89 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t90 = alloca [0 x double]
  %t91 = getelementptr [0 x double], [0 x double]* %t90, i32 0, i32 0
  %t92 = alloca { double*, i64 }
  %t93 = getelementptr { double*, i64 }, { double*, i64 }* %t92, i32 0, i32 0
  store double* %t91, double** %t93
  %t94 = getelementptr { double*, i64 }, { double*, i64 }* %t92, i32 0, i32 1
  store i64 0, i64* %t94
  %t95 = insertvalue %ObjectLiteralParseResult %t89, { i8**, i64 }* null, 1
  %t96 = insertvalue %ObjectLiteralParseResult %t95, i1 0, 2
  ret %ObjectLiteralParseResult %t96
loop.latch4:
  %t97 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header2
afterloop5:
  %t101 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t102 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t104 = insertvalue %ObjectLiteralParseResult %t102, { i8**, i64 }* %t103, 1
  %t105 = insertvalue %ObjectLiteralParseResult %t104, i1 1, 2
  ret %ObjectLiteralParseResult %t105
}

define %ExpressionParseResult @parse_struct_literal(%ExpressionTokens %state, i8* %target) {
entry:
  %l0 = alloca %StructTypeNameResult
  %l1 = alloca %ObjectLiteralParseResult
  %t0 = call %StructTypeNameResult @collect_struct_type_name(i8* %target)
  store %StructTypeNameResult %t0, %StructTypeNameResult* %l0
  %t1 = call %ObjectLiteralParseResult @parse_object_literal(%ExpressionTokens %state)
  store %ObjectLiteralParseResult %t1, %ObjectLiteralParseResult* %l1
  %t2 = load %ObjectLiteralParseResult, %ObjectLiteralParseResult* %l1
  %t3 = extractvalue %ObjectLiteralParseResult %t2, 0
  %t4 = insertvalue %ExpressionParseResult undef, i8* %t3, 0
  %t5 = insertvalue %ExpressionParseResult %t4, i8* null, 1
  %t6 = insertvalue %ExpressionParseResult %t5, i1 1, 2
  ret %ExpressionParseResult %t6
}

define %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state) {
entry:
  %t0 = insertvalue %ExpressionParseResult undef, i8* null, 0
  %t1 = insertvalue %ExpressionParseResult %t0, i8* null, 1
  %t2 = insertvalue %ExpressionParseResult %t1, i1 0, 2
  ret %ExpressionParseResult %t2
}

define i1 @expression_tokens_is_at_end(%ExpressionTokens %state) {
entry:
  %t0 = extractvalue %ExpressionTokens %state, 1
  %t1 = extractvalue %ExpressionTokens %state, 0
  ret i1 false
}

define %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %state) {
entry:
  %t0 = extractvalue %ExpressionTokens %state, 1
  %t1 = extractvalue %ExpressionTokens %state, 0
  ret %ExpressionTokens zeroinitializer
}

define i1 @expression_is_struct_target(i8* %expression) {
entry:
  ret i1 0
}

define %StructTypeNameResult @collect_struct_type_name(i8* %expression) {
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

define { i8**, i64 }* @filter_trivia({ i8**, i64 }* %tokens) {
entry:
  %l0 = alloca double
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i8*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t6 = load double, double* %l0
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t23 = phi double [ %t6, %entry ], [ %t22, %loop.latch2 ]
  store double %t23, double* %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l0
  %t9 = load double, double* %l0
  %t10 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  store i8* %t15, i8** %l2
  %t18 = load i8*, i8** %l2
  %t19 = load double, double* %l0
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l0
  br label %loop.latch2
loop.latch2:
  %t22 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l1
  ret { i8**, i64 }* %t24
}

define i8* @tokens_to_text({ i8**, i64 }* %tokens) {
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
  %t18 = phi i8* [ %t2, %entry ], [ %t16, %loop.latch2 ]
  %t19 = phi double [ %t3, %entry ], [ %t17, %loop.latch2 ]
  store i8* %t18, i8** %l0
  store double %t19, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load i8*, i8** %l0
  %t6 = load double, double* %l1
  %t7 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t8 = extractvalue { i8**, i64 } %t7, 0
  %t9 = extractvalue { i8**, i64 } %t7, 1
  %t10 = icmp uge i64 %t6, %t9
  ; bounds check: %t10 (if true, out of bounds)
  %t11 = getelementptr i8*, i8** %t8, i64 %t6
  %t12 = load i8*, i8** %t11
  %t13 = load double, double* %l1
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  store double %t15, double* %l1
  br label %loop.latch2
loop.latch2:
  %t16 = load i8*, i8** %l0
  %t17 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t20 = load i8*, i8** %l0
  ret i8* %t20
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
  %t40 = call double @substring(i8* %value, double %t38, double %t39)
  ret i8* null
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
  %t16 = phi double [ %t1, %entry ], [ %t15, %loop.latch2 ]
  store double %t16, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = load { i8**, i64 }, { i8**, i64 }* %values
  %t5 = extractvalue { i8**, i64 } %t4, 0
  %t6 = extractvalue { i8**, i64 } %t4, 1
  %t7 = icmp uge i64 %t3, %t6
  ; bounds check: %t7 (if true, out of bounds)
  %t8 = getelementptr i8*, i8** %t5, i64 %t3
  %t9 = load i8*, i8** %t8
  %t10 = icmp eq i8* %t9, %target
  %t11 = load double, double* %l0
  br i1 %t10, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t12 = load double, double* %l0
  %t13 = sitofp i64 1 to double
  %t14 = fadd double %t12, %t13
  store double %t14, double* %l0
  br label %loop.latch2
loop.latch2:
  %t15 = load double, double* %l0
  br label %loop.header0
afterloop3:
  ret i1 0
}

define i1 @is_trivia_token(i8* %token) {
entry:
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
  %t7 = call double @is_trim_whitespace(i8 %t6)
  %t8 = fcmp one double %t7, 0.0
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
  %l1 = alloca double
  %l2 = alloca %Parser
  store %Parser %parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  br label %loop.header0
loop.header0:
  %t21 = phi %Parser [ %t0, %entry ], [ %t20, %loop.latch2 ]
  store %Parser %t21, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Parser @skip_trivia(%Parser %t1)
  store %Parser %t2, %Parser* %l0
  %t3 = load %Parser, %Parser* %l0
  %t4 = call double @parser_peek_raw(%Parser %t3)
  store double %t4, double* %l1
  %t6 = load double, double* %l1
  %t7 = load double, double* %l1
  %t8 = load %Parser, %Parser* %l0
  %t9 = call %Parser @parser_advance_raw(%Parser %t8)
  store %Parser %t9, %Parser* %l2
  %t10 = load %Parser, %Parser* %l2
  %t11 = extractvalue %Parser %t10, 1
  %t12 = load %Parser, %Parser* %l0
  %t13 = extractvalue %Parser %t12, 1
  %t14 = fcmp oeq double %t11, %t13
  %t15 = load %Parser, %Parser* %l0
  %t16 = load double, double* %l1
  %t17 = load %Parser, %Parser* %l2
  br i1 %t14, label %then4, label %merge5
then4:
  %t18 = load %Parser, %Parser* %l0
  ret %Parser %t18
merge5:
  %t19 = load %Parser, %Parser* %l2
  store %Parser %t19, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t20 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  ret %Parser zeroinitializer
}

define %Parser @skip_struct_member(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  br label %loop.header0
loop.header0:
  %t17 = phi %Parser [ %t0, %entry ], [ %t16, %loop.latch2 ]
  store %Parser %t17, %Parser* %l0
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
  %t13 = call double @parser_peek_raw(%Parser %t12)
  store double %t13, double* %l2
  %t14 = load double, double* %l2
  %t15 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  %t16 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  ret %Parser zeroinitializer
}

define %Parser @skip_enum_variant_entry(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  br label %loop.header0
loop.header0:
  %t17 = phi %Parser [ %t0, %entry ], [ %t16, %loop.latch2 ]
  store %Parser %t17, %Parser* %l0
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
  %t13 = call double @parser_peek_raw(%Parser %t12)
  store double %t13, double* %l2
  %t14 = load double, double* %l2
  %t15 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  %t16 = load %Parser, %Parser* %l0
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

define { i8**, i64 }* @split_tokens_by_comma({ i8**, i64 }* %tokens) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i8*
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
  %t34 = phi i8* [ %t12, %entry ], [ %t32, %loop.latch2 ]
  %t35 = phi double [ %t17, %entry ], [ %t33, %loop.latch2 ]
  store i8* %t34, i8** %l1
  store double %t35, double* %l6
  br label %loop.body1
loop.body1:
  %t18 = load double, double* %l6
  %t19 = load double, double* %l6
  %t20 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t21 = extractvalue { i8**, i64 } %t20, 0
  %t22 = extractvalue { i8**, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  %t24 = getelementptr i8*, i8** %t21, i64 %t19
  %t25 = load i8*, i8** %t24
  store i8* %t25, i8** %l7
  %t26 = load i8*, i8** %l7
  %t27 = load i8*, i8** %l1
  %t28 = load i8*, i8** %l7
  %t29 = load double, double* %l6
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l6
  br label %loop.latch2
loop.latch2:
  %t32 = load i8*, i8** %l1
  %t33 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t36 = load i8*, i8** %l1
  %t37 = call i8* @trim_text(i8* %t36)
  store i8* %t37, i8** %l8
  %t38 = load i8*, i8** %l8
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t39
}

define { i8**, i64 }* @split_token_slices_by_comma({ i8**, i64 }* %tokens) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i8*
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
  store { i8**, i64 }* null, { i8**, i64 }** %l1
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
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t17 = load double, double* %l2
  %t18 = load double, double* %l3
  %t19 = load double, double* %l4
  %t20 = load double, double* %l5
  %t21 = load double, double* %l6
  br label %loop.header0
loop.header0:
  %t39 = phi { i8**, i64 }* [ %t16, %entry ], [ %t37, %loop.latch2 ]
  %t40 = phi double [ %t21, %entry ], [ %t38, %loop.latch2 ]
  store { i8**, i64 }* %t39, { i8**, i64 }** %l1
  store double %t40, double* %l6
  br label %loop.body1
loop.body1:
  %t22 = load double, double* %l6
  %t23 = load double, double* %l6
  %t24 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t25 = extractvalue { i8**, i64 } %t24, 0
  %t26 = extractvalue { i8**, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  %t28 = getelementptr i8*, i8** %t25, i64 %t23
  %t29 = load i8*, i8** %t28
  store i8* %t29, i8** %l7
  %t30 = load i8*, i8** %l7
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t32 = load i8*, i8** %l7
  %t33 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t31, i8* %t32)
  store { i8**, i64 }* %t33, { i8**, i64 }** %l1
  %t34 = load double, double* %l6
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l6
  br label %loop.latch2
loop.latch2:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t38 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t42
}

define double @find_top_level_symbol({ i8**, i64 }* %tokens, i8* %symbol) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
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
  %t23 = phi double [ %t9, %entry ], [ %t22, %loop.latch2 ]
  store double %t23, double* %l4
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l4
  %t11 = load double, double* %l4
  %t12 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t13 = extractvalue { i8**, i64 } %t12, 0
  %t14 = extractvalue { i8**, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr i8*, i8** %t13, i64 %t11
  %t17 = load i8*, i8** %t16
  store i8* %t17, i8** %l5
  %t18 = load i8*, i8** %l5
  %t19 = load double, double* %l4
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l4
  br label %loop.latch2
loop.latch2:
  %t22 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t24 = sitofp i64 -1 to double
  ret double %t24
}

define double @find_top_level_identifier({ i8**, i64 }* %tokens, i8* %keyword) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
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
  %t24 = phi double [ %t9, %entry ], [ %t23, %loop.latch2 ]
  store double %t24, double* %l4
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l4
  %t11 = load double, double* %l4
  %t12 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t13 = extractvalue { i8**, i64 } %t12, 0
  %t14 = extractvalue { i8**, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr i8*, i8** %t13, i64 %t11
  %t17 = load i8*, i8** %t16
  store i8* %t17, i8** %l5
  %t18 = load i8*, i8** %l5
  %t19 = load i8*, i8** %l5
  %t20 = load double, double* %l4
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l4
  br label %loop.latch2
loop.latch2:
  %t23 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t25 = sitofp i64 -1 to double
  ret double %t25
}

define { i8**, i64 }* @append_statement({ i8**, i64 }* %statements, i8* %statement) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %statement, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @statementsconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
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

define { i8**, i64 }* @append_parameter({ i8**, i64 }* %parameters, i8* %parameter) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %parameter, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @parametersconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_model_property({ i8**, i64 }* %properties, i8* %property) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %property, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @propertiesconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_field({ i8**, i64 }* %fields, i8* %field) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %field, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @fieldsconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_method({ i8**, i64 }* %methods, i8* %method) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %method, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @methodsconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_signature({ i8**, i64 }* %signatures, i8* %signature) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %signature, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @signaturesconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_enum_variant({ i8**, i64 }* %variants, i8* %variant) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %variant, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @variantsconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_type_annotation({ i8**, i64 }* %types, i8* %item) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %item, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @typesconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_type_parameter({ i8**, i64 }* %parameters, i8* %parameter) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %parameter, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @parametersconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_decorator({ i8**, i64 }* %decorators, i8* %decorator) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %decorator, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @decoratorsconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_decorator_argument({ i8**, i64 }* %arguments, i8* %argument) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %argument, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @argumentsconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_with_clause({ i8**, i64 }* %clauses, i8* %clause) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %clause, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @clausesconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_match_case({ i8**, i64 }* %cases, i8* %case) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %case, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @casesconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_expression({ i8**, i64 }* %expressions, i8* %expression) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %expression, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @expressionsconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_object_field({ i8**, i64 }* %fields, i8* %field) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %field, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @fieldsconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_token({ i8**, i64 }* %tokens, i8* %token) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %token, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @tokensconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_token_array({ i8**, i64 }* %collection, { i8**, i64 }* %tokens) {
entry:
  %t0 = alloca [1 x { i8**, i64 }*]
  %t1 = getelementptr [1 x { i8**, i64 }*], [1 x { i8**, i64 }*]* %t0, i32 0, i32 0
  %t2 = getelementptr { i8**, i64 }*, { i8**, i64 }** %t1, i64 0
  store { i8**, i64 }* %tokens, { i8**, i64 }** %t2
  %t3 = alloca { { i8**, i64 }**, i64 }
  %t4 = getelementptr { { i8**, i64 }**, i64 }, { { i8**, i64 }**, i64 }* %t3, i32 0, i32 0
  store { i8**, i64 }** %t1, { i8**, i64 }*** %t4
  %t5 = getelementptr { { i8**, i64 }**, i64 }, { { i8**, i64 }**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @collectionconcat({ { i8**, i64 }**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
