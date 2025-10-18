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
  %t6 = call i1 @identifier_matches(double %t4, i8* %s5)
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
  %t15 = call i1 @identifier_matches(double %t13, i8* %s14)
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
  %t24 = call i1 @identifier_matches(double %t22, i8* %s23)
  %t25 = load %Parser, %Parser* %l0
  %t26 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t28 = load double, double* %l3
  br i1 %t24, label %then4, label %merge5
then4:
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t31 = call %StatementParseResult @parse_model(%Parser %parser, double 0.0)
  ret %StatementParseResult %t31
merge5:
  %t32 = load double, double* %l3
  %s33 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.33, i32 0, i32 0
  %t34 = call i1 @identifier_matches(double %t32, i8* %s33)
  %t35 = load %Parser, %Parser* %l0
  %t36 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t38 = load double, double* %l3
  br i1 %t34, label %then6, label %merge7
then6:
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t41 = call %StatementParseResult @parse_pipeline(%Parser %parser, double 0.0)
  ret %StatementParseResult %t41
merge7:
  %t42 = load double, double* %l3
  %s43 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.43, i32 0, i32 0
  %t44 = call i1 @identifier_matches(double %t42, i8* %s43)
  %t45 = load %Parser, %Parser* %l0
  %t46 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t48 = load double, double* %l3
  br i1 %t44, label %then8, label %merge9
then8:
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t51 = call %StatementParseResult @parse_tool(%Parser %parser, double 0.0)
  ret %StatementParseResult %t51
merge9:
  %t52 = load double, double* %l3
  %s53 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.53, i32 0, i32 0
  %t54 = call i1 @identifier_matches(double %t52, i8* %s53)
  %t55 = load %Parser, %Parser* %l0
  %t56 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t58 = load double, double* %l3
  br i1 %t54, label %then10, label %merge11
then10:
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t61 = call %StatementParseResult @parse_test(%Parser %parser, double 0.0)
  ret %StatementParseResult %t61
merge11:
  %t62 = load double, double* %l3
  %s63 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.63, i32 0, i32 0
  %t64 = call i1 @identifier_matches(double %t62, i8* %s63)
  %t65 = load %Parser, %Parser* %l0
  %t66 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t68 = load double, double* %l3
  br i1 %t64, label %then12, label %merge13
then12:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t70 = call %StatementParseResult @parse_function(%Parser %parser, i1 0, double 0.0)
  ret %StatementParseResult %t70
merge13:
  %t71 = load double, double* %l3
  %s72 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.72, i32 0, i32 0
  %t73 = call i1 @identifier_matches(double %t71, i8* %s72)
  %t74 = load %Parser, %Parser* %l0
  %t75 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t77 = load double, double* %l3
  br i1 %t73, label %then14, label %merge15
then14:
  %t78 = load double, double* %l3
  %s79 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.79, i32 0, i32 0
  %t80 = call i1 @identifier_matches(double %t78, i8* %s79)
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
  %t87 = call i1 @identifier_matches(double %t85, i8* %s86)
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
  %t95 = call i1 @identifier_matches(double %t93, i8* %s94)
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
  %t103 = call i1 @identifier_matches(double %t101, i8* %s102)
  %t104 = load %Parser, %Parser* %l0
  %t105 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t107 = load double, double* %l3
  %t108 = load double, double* %l4
  br i1 %t103, label %then22, label %merge23
then22:
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t110 = call %StatementParseResult @parse_function(%Parser %parser, i1 1, double 0.0)
  ret %StatementParseResult %t110
merge23:
  br label %merge15
merge15:
  %t111 = load double, double* %l3
  %s112 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.112, i32 0, i32 0
  %t113 = call i1 @identifier_matches(double %t111, i8* %s112)
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
  %t121 = call i1 @identifier_matches(double %t119, i8* %s120)
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
  %t129 = call i1 @identifier_matches(double %t127, i8* %s128)
  %t130 = load %Parser, %Parser* %l0
  %t131 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t133 = load double, double* %l3
  br i1 %t129, label %then28, label %merge29
then28:
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t135 = call %StatementParseResult @parse_struct(%Parser %parser, double 0.0)
  ret %StatementParseResult %t135
merge29:
  %t136 = load double, double* %l3
  %s137 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.137, i32 0, i32 0
  %t138 = call i1 @identifier_matches(double %t136, i8* %s137)
  %t139 = load %Parser, %Parser* %l0
  %t140 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t142 = load double, double* %l3
  br i1 %t138, label %then30, label %merge31
then30:
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t144 = call %StatementParseResult @parse_type_alias(%Parser %parser, double 0.0)
  ret %StatementParseResult %t144
merge31:
  %t145 = load double, double* %l3
  %s146 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.146, i32 0, i32 0
  %t147 = call i1 @identifier_matches(double %t145, i8* %s146)
  %t148 = load %Parser, %Parser* %l0
  %t149 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t151 = load double, double* %l3
  br i1 %t147, label %then32, label %merge33
then32:
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t153 = call %StatementParseResult @parse_interface(%Parser %parser, double 0.0)
  ret %StatementParseResult %t153
merge33:
  %t154 = load double, double* %l3
  %s155 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.155, i32 0, i32 0
  %t156 = call i1 @identifier_matches(double %t154, i8* %s155)
  %t157 = load %Parser, %Parser* %l0
  %t158 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t160 = load double, double* %l3
  br i1 %t156, label %then34, label %merge35
then34:
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t162 = call %StatementParseResult @parse_enum(%Parser %parser, double 0.0)
  ret %StatementParseResult %t162
merge35:
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t164 = call %StatementParseResult @parse_unknown(%Parser %parser)
  ret %StatementParseResult %t164
}

define %StatementParseResult @parse_import(%Parser %parser) {
entry:
  %l0 = alloca %SpecifierListParseResult
  %l1 = alloca double
  %l2 = alloca %CaptureResult
  %l3 = alloca i8*
  %l4 = alloca double
  %t0 = call %SpecifierListParseResult @parse_specifier_list(%Parser %parser)
  store %SpecifierListParseResult %t0, %SpecifierListParseResult* %l0
  %t1 = load %SpecifierListParseResult, %SpecifierListParseResult* %l0
  %t2 = extractvalue %SpecifierListParseResult %t1, 1
  %t3 = call double @build_import_specifiers({ %NamedSpecifier*, i64 }* null)
  store double %t3, double* %l1
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
  %t14 = call i8* @tokens_to_text(double 0.0)
  %t15 = call i8* @trim_text(i8* %t14)
  store i8* %t15, i8** %l3
  %t16 = load i8*, i8** %l3
  %t17 = call i8* @strip_surrounding_quotes(i8* %t16)
  store i8* %t17, i8** %l3
  %t18 = call double @parser_peek_raw(%Parser %parser)
  store double 0.0, double* %l4
  %t19 = insertvalue %StatementParseResult undef, i8* null, 0
  %t20 = load double, double* %l4
  %t21 = insertvalue %StatementParseResult %t19, i8* null, 1
  ret %StatementParseResult %t21
}

define %StatementParseResult @parse_export(%Parser %parser) {
entry:
  %l0 = alloca %SpecifierListParseResult
  %l1 = alloca double
  %l2 = alloca %CaptureResult
  %l3 = alloca i8*
  %l4 = alloca double
  %t0 = call %SpecifierListParseResult @parse_specifier_list(%Parser %parser)
  store %SpecifierListParseResult %t0, %SpecifierListParseResult* %l0
  %t1 = load %SpecifierListParseResult, %SpecifierListParseResult* %l0
  %t2 = extractvalue %SpecifierListParseResult %t1, 1
  %t3 = call double @build_export_specifiers({ %NamedSpecifier*, i64 }* null)
  store double %t3, double* %l1
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
  %t14 = call i8* @tokens_to_text(double 0.0)
  %t15 = call i8* @trim_text(i8* %t14)
  store i8* %t15, i8** %l3
  %t16 = load i8*, i8** %l3
  %t17 = call i8* @strip_surrounding_quotes(i8* %t16)
  store i8* %t17, i8** %l3
  %t18 = call double @parser_peek_raw(%Parser %parser)
  store double 0.0, double* %l4
  %t19 = insertvalue %StatementParseResult undef, i8* null, 0
  %t20 = load double, double* %l4
  %t21 = insertvalue %StatementParseResult %t19, i8* null, 1
  ret %StatementParseResult %t21
}

define %StatementParseResult @parse_variable(%Parser %parser) {
entry:
  %l0 = alloca { double*, i64 }*
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca double
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
  store { double*, i64 }* %t2, { double*, i64 }** %l0
  %t5 = call double @parser_peek_raw(%Parser %parser)
  store double %t5, double* %l1
  %t6 = load { double*, i64 }*, { double*, i64 }** %l0
  %t7 = load double, double* %l1
  %t8 = call double @append_token(double 0.0, double %t7)
  store { double*, i64 }* null, { double*, i64 }** %l0
  store i1 0, i1* %l2
  %t9 = call double @parser_peek_raw(%Parser %parser)
  store double %t9, double* %l3
  %t10 = load double, double* %l3
  %s11 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.11, i32 0, i32 0
  %t12 = call i1 @identifier_matches(double %t10, i8* %s11)
  %t13 = load { double*, i64 }*, { double*, i64 }** %l0
  %t14 = load double, double* %l1
  %t15 = load i1, i1* %l2
  %t16 = load double, double* %l3
  br i1 %t12, label %then0, label %merge1
then0:
  %t17 = load { double*, i64 }*, { double*, i64 }** %l0
  %t18 = load double, double* %l3
  %t19 = call double @append_token(double 0.0, double %t18)
  store { double*, i64 }* null, { double*, i64 }** %l0
  store i1 1, i1* %l2
  br label %merge1
merge1:
  %t20 = phi { double*, i64 }* [ null, %then0 ], [ %t13, %entry ]
  %t21 = phi i1 [ 1, %then0 ], [ %t15, %entry ]
  store { double*, i64 }* %t20, { double*, i64 }** %l0
  store i1 %t21, i1* %l2
  %t22 = call double @parser_peek_raw(%Parser %parser)
  store double %t22, double* %l4
  %t23 = load { double*, i64 }*, { double*, i64 }** %l0
  %t24 = load double, double* %l4
  %t25 = call double @append_token(double 0.0, double %t24)
  store { double*, i64 }* null, { double*, i64 }** %l0
  %t26 = load double, double* %l4
  %t27 = call i8* @identifier_text(double %t26)
  store i8* %t27, i8** %l5
  store double 0.0, double* %l6
  %t28 = call double @parser_peek_raw(%Parser %parser)
  store double %t28, double* %l7
  %t29 = load double, double* %l7
  store double 0.0, double* %l8
  store double 0.0, double* %l9
  %t30 = call double @parser_peek_raw(%Parser %parser)
  store double %t30, double* %l10
  %t31 = load double, double* %l10
  %t32 = call double @parser_peek_raw(%Parser %parser)
  store double %t32, double* %l11
  %t33 = load double, double* %l11
  %t34 = load { double*, i64 }*, { double*, i64 }** %l0
  %t35 = call double @source_span_from_tokens(double 0.0)
  store double %t35, double* %l12
  store double 0.0, double* %l13
  %t36 = insertvalue %StatementParseResult undef, i8* null, 0
  %t37 = load double, double* %l13
  %t38 = insertvalue %StatementParseResult %t36, i8* null, 1
  ret %StatementParseResult %t38
}

define %SpecifierListParseResult @parse_specifier_list(%Parser %parser) {
entry:
  %l0 = alloca { %NamedSpecifier*, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
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
  %t25 = phi { %NamedSpecifier*, i64 }* [ %t5, %entry ], [ %t24, %loop.latch2 ]
  store { %NamedSpecifier*, i64 }* %t25, { %NamedSpecifier*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t6 = call double @parser_peek_raw(%Parser %parser)
  store double %t6, double* %l1
  %t7 = load double, double* %l1
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = call i8* @identifier_text(double %t9)
  store i8* %t10, i8** %l2
  store double 0.0, double* %l3
  %t11 = call double @parser_peek_raw(%Parser %parser)
  store double %t11, double* %l4
  %t12 = load double, double* %l4
  %s13 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.13, i32 0, i32 0
  %t14 = call i1 @identifier_matches(double %t12, i8* %s13)
  %t15 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l0
  %t16 = load double, double* %l1
  %t17 = load i8*, i8** %l2
  %t18 = load double, double* %l3
  %t19 = load double, double* %l4
  br i1 %t14, label %then4, label %merge5
then4:
  %t20 = call double @parser_peek_raw(%Parser %parser)
  store double %t20, double* %l5
  %t21 = load double, double* %l5
  br label %merge5
merge5:
  %t22 = call double @parser_peek_raw(%Parser %parser)
  store double %t22, double* %l6
  %t23 = load double, double* %l6
  br label %loop.latch2
loop.latch2:
  %t24 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t26 = call double @parser_peek_raw(%Parser %parser)
  %t27 = insertvalue %SpecifierListParseResult undef, i8* null, 0
  %t28 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l0
  %t29 = insertvalue %SpecifierListParseResult %t27, { i8**, i64 }* null, 1
  ret %SpecifierListParseResult %t29
}

define %StatementParseResult @parse_struct(%Parser %parser, double %decorators) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca %TypeParameterParseResult
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca %ImplementsParseResult
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca { double*, i64 }*
  %l8 = alloca { double*, i64 }*
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
  %t2 = call i8* @identifier_text(double %t1)
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
  %t10 = call double @source_span_from_tokens(double 0.0)
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
  store { double*, i64 }* %t19, { double*, i64 }** %l7
  %t22 = alloca [0 x double]
  %t23 = getelementptr [0 x double], [0 x double]* %t22, i32 0, i32 0
  %t24 = alloca { double*, i64 }
  %t25 = getelementptr { double*, i64 }, { double*, i64 }* %t24, i32 0, i32 0
  store double* %t23, double** %t25
  %t26 = getelementptr { double*, i64 }, { double*, i64 }* %t24, i32 0, i32 1
  store i64 0, i64* %t26
  store { double*, i64 }* %t24, { double*, i64 }** %l8
  %t27 = load double, double* %l0
  %t28 = load i8*, i8** %l1
  %t29 = load double, double* %l2
  %t30 = load %TypeParameterParseResult, %TypeParameterParseResult* %l3
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t32 = load %ImplementsParseResult, %ImplementsParseResult* %l5
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t34 = load { double*, i64 }*, { double*, i64 }** %l7
  %t35 = load { double*, i64 }*, { double*, i64 }** %l8
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
  %t40 = load double, double* %l12
  %t41 = load double, double* %l12
  %t42 = call %StructFieldParseResult @parse_struct_field(%Parser %parser)
  store %StructFieldParseResult %t42, %StructFieldParseResult* %l13
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t44 = call %MethodParseResult @parse_struct_method(%Parser %parser, double 0.0)
  store %MethodParseResult %t44, %MethodParseResult* %l14
  %t45 = load %MethodParseResult, %MethodParseResult* %l14
  %t46 = extractvalue %MethodParseResult %t45, 2
  %t47 = load double, double* %l0
  %t48 = load i8*, i8** %l1
  %t49 = load double, double* %l2
  %t50 = load %TypeParameterParseResult, %TypeParameterParseResult* %l3
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t52 = load %ImplementsParseResult, %ImplementsParseResult* %l5
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t54 = load { double*, i64 }*, { double*, i64 }** %l7
  %t55 = load { double*, i64 }*, { double*, i64 }** %l8
  %t56 = load %Parser, %Parser* %l9
  %t57 = load %DecoratorParseResult, %DecoratorParseResult* %l10
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t59 = load double, double* %l12
  %t60 = load %StructFieldParseResult, %StructFieldParseResult* %l13
  %t61 = load %MethodParseResult, %MethodParseResult* %l14
  br i1 %t46, label %then4, label %merge5
then4:
  %t62 = load %MethodParseResult, %MethodParseResult* %l14
  %t63 = extractvalue %MethodParseResult %t62, 1
  br label %loop.latch2
merge5:
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l15
  %t64 = insertvalue %StatementParseResult undef, i8* null, 0
  %t65 = load double, double* %l15
  %t66 = insertvalue %StatementParseResult %t64, i8* null, 1
  ret %StatementParseResult %t66
}

define %StatementParseResult @parse_type_alias(%Parser %parser, double %decorators) {
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
  %t3 = call i8* @identifier_text(double %t2)
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
  %t11 = call double @source_span_from_tokens(double 0.0)
  store double %t11, double* %l3
  %t12 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %parser)
  store %TypeParameterParseResult %t12, %TypeParameterParseResult* %l4
  %t13 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t14 = extractvalue %TypeParameterParseResult %t13, 1
  store { i8**, i64 }* %t14, { i8**, i64 }** %l5
  %t15 = call double @parser_peek_raw(%Parser %parser)
  store double %t15, double* %l6
  %t16 = load double, double* %l6
  %t17 = call %Parser @skip_trivia(%Parser %parser)
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
  store %CaptureResult %t25, %CaptureResult* %l7
  %t26 = load %CaptureResult, %CaptureResult* %l7
  %t27 = extractvalue %CaptureResult %t26, 1
  %t28 = call i8* @tokens_to_text(double 0.0)
  %t29 = call i8* @trim_text(i8* %t28)
  store i8* %t29, i8** %l8
  %t30 = load i8*, i8** %l8
  store double 0.0, double* %l9
  %t31 = call double @parser_peek_raw(%Parser %parser)
  store double 0.0, double* %l10
  %t32 = insertvalue %StatementParseResult undef, i8* null, 0
  %t33 = load double, double* %l10
  %t34 = insertvalue %StatementParseResult %t32, i8* null, 1
  ret %StatementParseResult %t34
}

define %StatementParseResult @parse_interface(%Parser %parser, double %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca %TypeParameterParseResult
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca { double*, i64 }*
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
  %t3 = call i8* @identifier_text(double %t2)
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
  %t11 = call double @source_span_from_tokens(double 0.0)
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
  store { double*, i64 }* %t17, { double*, i64 }** %l6
  %t20 = load %Parser, %Parser* %l0
  %t21 = load double, double* %l1
  %t22 = load i8*, i8** %l2
  %t23 = load double, double* %l3
  %t24 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t26 = load { double*, i64 }*, { double*, i64 }** %l6
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t27 = call double @parser_peek_raw(%Parser %parser)
  store double %t27, double* %l7
  %t28 = load double, double* %l7
  %t29 = load double, double* %l7
  store %Parser %parser, %Parser* %l8
  %t30 = call %DecoratorParseResult @parse_decorators(%Parser %parser)
  store %DecoratorParseResult %t30, %DecoratorParseResult* %l9
  %t31 = load %DecoratorParseResult, %DecoratorParseResult* %l9
  %t32 = extractvalue %DecoratorParseResult %t31, 1
  store { i8**, i64 }* %t32, { i8**, i64 }** %l10
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t34 = call %InterfaceMemberParseResult @parse_interface_member(%Parser %parser, double 0.0)
  store %InterfaceMemberParseResult %t34, %InterfaceMemberParseResult* %l11
  %t35 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l11
  %t36 = extractvalue %InterfaceMemberParseResult %t35, 2
  %t37 = load %Parser, %Parser* %l0
  %t38 = load double, double* %l1
  %t39 = load i8*, i8** %l2
  %t40 = load double, double* %l3
  %t41 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t43 = load { double*, i64 }*, { double*, i64 }** %l6
  %t44 = load double, double* %l7
  %t45 = load %Parser, %Parser* %l8
  %t46 = load %DecoratorParseResult, %DecoratorParseResult* %l9
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t48 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l11
  br i1 %t36, label %then4, label %merge5
then4:
  %t49 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l11
  %t50 = extractvalue %InterfaceMemberParseResult %t49, 1
  br label %loop.latch2
merge5:
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l12
  %t51 = insertvalue %StatementParseResult undef, i8* null, 0
  %t52 = load double, double* %l12
  %t53 = insertvalue %StatementParseResult %t51, i8* null, 1
  ret %StatementParseResult %t53
}

define %StatementParseResult @parse_enum(%Parser %parser, double %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca %TypeParameterParseResult
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca { double*, i64 }*
  %l7 = alloca double
  %l8 = alloca %EnumVariantParseResult
  %l9 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l1
  %t1 = load double, double* %l1
  %t2 = load double, double* %l1
  %t3 = call i8* @identifier_text(double %t2)
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
  %t11 = call double @source_span_from_tokens(double 0.0)
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
  store { double*, i64 }* %t17, { double*, i64 }** %l6
  %t20 = load %Parser, %Parser* %l0
  %t21 = load double, double* %l1
  %t22 = load i8*, i8** %l2
  %t23 = load double, double* %l3
  %t24 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t26 = load { double*, i64 }*, { double*, i64 }** %l6
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t27 = call double @parser_peek_raw(%Parser %parser)
  store double %t27, double* %l7
  %t28 = load double, double* %l7
  %t29 = load double, double* %l7
  %t30 = call %EnumVariantParseResult @parse_enum_variant(%Parser %parser)
  store %EnumVariantParseResult %t30, %EnumVariantParseResult* %l8
  %t31 = load %EnumVariantParseResult, %EnumVariantParseResult* %l8
  %t32 = extractvalue %EnumVariantParseResult %t31, 2
  %t33 = load %Parser, %Parser* %l0
  %t34 = load double, double* %l1
  %t35 = load i8*, i8** %l2
  %t36 = load double, double* %l3
  %t37 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t39 = load { double*, i64 }*, { double*, i64 }** %l6
  %t40 = load double, double* %l7
  %t41 = load %EnumVariantParseResult, %EnumVariantParseResult* %l8
  br i1 %t32, label %then4, label %merge5
then4:
  %t42 = load %EnumVariantParseResult, %EnumVariantParseResult* %l8
  %t43 = extractvalue %EnumVariantParseResult %t42, 1
  br label %loop.latch2
merge5:
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l9
  %t44 = insertvalue %StatementParseResult undef, i8* null, 0
  %t45 = load double, double* %l9
  %t46 = insertvalue %StatementParseResult %t44, i8* null, 1
  ret %StatementParseResult %t46
}

define %InterfaceMemberParseResult @parse_interface_member(%Parser %parser, double %decorators) {
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
  %l12 = alloca double
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
  %t5 = call i1 @identifier_matches(double %t3, i8* %s4)
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
  %t16 = call i1 @identifier_matches(double %t14, i8* %s15)
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
  %t53 = call i8* @identifier_text(double %t52)
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
  %t61 = call double @source_span_from_tokens(double 0.0)
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
  store double 0.0, double* %l12
  %t83 = load %Parser, %Parser* %l1
  %t84 = call double @parser_peek_raw(%Parser %t83)
  store double %t84, double* %l13
  %t85 = load double, double* %l13
  %t86 = load %Parser, %Parser* %l1
  %t87 = call %EffectParseResult @parse_effect_list(%Parser %t86)
  store %EffectParseResult %t87, %EffectParseResult* %l14
  %t88 = load %EffectParseResult, %EffectParseResult* %l14
  %t89 = extractvalue %EffectParseResult %t88, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t90 = load %EffectParseResult, %EffectParseResult* %l14
  %t91 = extractvalue %EffectParseResult %t90, 1
  store { i8**, i64 }* %t91, { i8**, i64 }** %l15
  %t92 = call double @evaluate_decorators(double %decorators)
  store double %t92, double* %l16
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t94 = load double, double* %l16
  %t95 = call double @infer_effects({ i8**, i64 }* %t93, double %t94)
  store double %t95, double* %l17
  %t96 = load %Parser, %Parser* %l1
  %t97 = call %Parser @skip_trivia(%Parser %t96)
  store %Parser %t97, %Parser* %l1
  %t98 = load %Parser, %Parser* %l1
  %t99 = extractvalue %Parser %t98, 1
  %t100 = load %Parser, %Parser* %l1
  %t101 = extractvalue %Parser %t100, 0
  store double 0.0, double* %l18
  %t102 = load %Parser, %Parser* %l1
  %t103 = insertvalue %InterfaceMemberParseResult undef, i8* null, 0
  %t104 = load double, double* %l18
  %t105 = insertvalue %InterfaceMemberParseResult %t103, i8* null, 1
  %t106 = insertvalue %InterfaceMemberParseResult %t105, i1 1, 2
  ret %InterfaceMemberParseResult %t106
}

define %EnumVariantParseResult @parse_enum_variant(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca { double*, i64 }*
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
  %t5 = call i8* @identifier_text(double %t4)
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
  %t13 = call double @source_span_from_tokens(double 0.0)
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
  store { double*, i64 }* %t18, { double*, i64 }** %l5
  %t21 = load %Parser, %Parser* %l1
  %t22 = call %Parser @skip_trivia(%Parser %t21)
  store %Parser %t22, %Parser* %l1
  %t23 = load %Parser, %Parser* %l1
  %t24 = call double @parser_peek_raw(%Parser %t23)
  store double %t24, double* %l6
  %t25 = load double, double* %l6
  %t26 = load %Parser, %Parser* %l1
  %t27 = call %Parser @skip_trivia(%Parser %t26)
  store %Parser %t27, %Parser* %l1
  %t28 = load %Parser, %Parser* %l1
  %t29 = call double @parser_peek_raw(%Parser %t28)
  store double %t29, double* %l7
  %t30 = load double, double* %l7
  store double 0.0, double* %l8
  %t31 = load %Parser, %Parser* %l1
  %t32 = insertvalue %EnumVariantParseResult undef, i8* null, 0
  %t33 = load double, double* %l8
  %t34 = insertvalue %EnumVariantParseResult %t32, i8* null, 1
  %t35 = insertvalue %EnumVariantParseResult %t34, i1 1, 2
  ret %EnumVariantParseResult %t35
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
  %t6 = call i1 @identifier_matches(double %t4, i8* %s5)
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
  %t23 = call i8* @identifier_text(double %t22)
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
  %t31 = call double @source_span_from_tokens(double 0.0)
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
  %t3 = load double, double* %l1
  %t4 = load %Parser, %Parser* %l0
  ret %Parser %t4
}

define %StatementParseResult @parse_model(%Parser %parser, double %decorators) {
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
  %l9 = alloca { double*, i64 }*
  %l10 = alloca double
  %l11 = alloca %Parser
  %l12 = alloca %ModelPropertyParseResult
  %l13 = alloca double
  %l14 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l1
  %t1 = load double, double* %l1
  %t2 = call i8* @identifier_text(double %t1)
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
  %t10 = call double @source_span_from_tokens(double 0.0)
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
  store { double*, i64 }* %t19, { double*, i64 }** %l9
  %t22 = load %Parser, %Parser* %l0
  %t23 = load double, double* %l1
  %t24 = load i8*, i8** %l2
  %t25 = load double, double* %l3
  %t26 = load double, double* %l4
  %t27 = load double, double* %l5
  %t28 = load double, double* %l6
  %t29 = load %EffectParseResult, %EffectParseResult* %l7
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t31 = load { double*, i64 }*, { double*, i64 }** %l9
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t32 = call double @parser_peek_raw(%Parser %parser)
  store double %t32, double* %l10
  %t33 = load double, double* %l10
  %t34 = load double, double* %l10
  store %Parser %parser, %Parser* %l11
  %t35 = call %ModelPropertyParseResult @parse_model_property(%Parser %parser)
  store %ModelPropertyParseResult %t35, %ModelPropertyParseResult* %l12
  %t36 = call double @parser_peek_raw(%Parser %parser)
  store double %t36, double* %l13
  %t37 = load double, double* %l13
  %t38 = load double, double* %l13
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l14
  %t39 = insertvalue %StatementParseResult undef, i8* null, 0
  %t40 = load double, double* %l14
  %t41 = insertvalue %StatementParseResult %t39, i8* null, 1
  ret %StatementParseResult %t41
}

define %StatementParseResult @parse_pipeline(%Parser %parser, double %decorators) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca %TypeParameterParseResult
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca %ParameterListParseResult
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca double
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
  %t2 = call i8* @identifier_text(double %t1)
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
  %t10 = call double @source_span_from_tokens(double 0.0)
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
  store double 0.0, double* %l7
  %t17 = call double @parser_peek_raw(%Parser %parser)
  store double %t17, double* %l8
  %t18 = load double, double* %l8
  %t19 = call %EffectParseResult @parse_effect_list(%Parser %parser)
  store %EffectParseResult %t19, %EffectParseResult* %l9
  %t20 = load %EffectParseResult, %EffectParseResult* %l9
  %t21 = extractvalue %EffectParseResult %t20, 1
  store { i8**, i64 }* %t21, { i8**, i64 }** %l10
  %t22 = call double @evaluate_decorators(double %decorators)
  store double %t22, double* %l11
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t24 = load double, double* %l11
  %t25 = call double @infer_effects({ i8**, i64 }* %t23, double %t24)
  store double %t25, double* %l12
  %t26 = call %BlockParseResult @parse_block(%Parser %parser)
  store %BlockParseResult %t26, %BlockParseResult* %l13
  %t27 = load %BlockParseResult, %BlockParseResult* %l13
  %t28 = extractvalue %BlockParseResult %t27, 1
  store i8* %t28, i8** %l14
  store double 0.0, double* %l15
  store double 0.0, double* %l16
  %t29 = insertvalue %StatementParseResult undef, i8* null, 0
  %t30 = load double, double* %l16
  %t31 = insertvalue %StatementParseResult %t29, i8* null, 1
  ret %StatementParseResult %t31
}

define %StatementParseResult @parse_tool(%Parser %parser, double %decorators) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca %ParameterListParseResult
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca double
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
  %t2 = call i8* @identifier_text(double %t1)
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
  %t10 = call double @source_span_from_tokens(double 0.0)
  store double %t10, double* %l2
  %t11 = call %ParameterListParseResult @parse_parameter_list(%Parser %parser)
  store %ParameterListParseResult %t11, %ParameterListParseResult* %l3
  %t12 = load %ParameterListParseResult, %ParameterListParseResult* %l3
  %t13 = extractvalue %ParameterListParseResult %t12, 1
  store { i8**, i64 }* %t13, { i8**, i64 }** %l4
  store double 0.0, double* %l5
  %t14 = call double @parser_peek_raw(%Parser %parser)
  store double %t14, double* %l6
  %t15 = load double, double* %l6
  %t16 = call %EffectParseResult @parse_effect_list(%Parser %parser)
  store %EffectParseResult %t16, %EffectParseResult* %l7
  %t17 = load %EffectParseResult, %EffectParseResult* %l7
  %t18 = extractvalue %EffectParseResult %t17, 1
  store { i8**, i64 }* %t18, { i8**, i64 }** %l8
  %t19 = call double @evaluate_decorators(double %decorators)
  store double %t19, double* %l9
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t21 = load double, double* %l9
  %t22 = call double @infer_effects({ i8**, i64 }* %t20, double %t21)
  store double %t22, double* %l10
  %t23 = call %BlockParseResult @parse_block(%Parser %parser)
  store %BlockParseResult %t23, %BlockParseResult* %l11
  %t24 = load %BlockParseResult, %BlockParseResult* %l11
  %t25 = extractvalue %BlockParseResult %t24, 1
  store i8* %t25, i8** %l12
  store double 0.0, double* %l13
  store double 0.0, double* %l14
  %t26 = insertvalue %StatementParseResult undef, i8* null, 0
  %t27 = load double, double* %l14
  %t28 = insertvalue %StatementParseResult %t26, i8* null, 1
  ret %StatementParseResult %t28
}

define %StatementParseResult @parse_test(%Parser %parser, double %decorators) {
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
  %t9 = call double @evaluate_decorators(double %decorators)
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

define %StatementParseResult @parse_function(%Parser %parser, i1 %starts_with_async, double %decorators) {
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
  %l11 = alloca double
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
  %t4 = call i1 @identifier_matches(double %t2, i8* %s3)
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
  %t13 = call i1 @identifier_matches(double %t11, i8* %s12)
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
  %t23 = call i8* @identifier_text(double %t22)
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
  %t31 = call double @source_span_from_tokens(double 0.0)
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
  store double 0.0, double* %l11
  %t38 = call double @parser_peek_raw(%Parser %parser)
  store double %t38, double* %l12
  %t39 = load double, double* %l12
  %t40 = call %EffectParseResult @parse_effect_list(%Parser %parser)
  store %EffectParseResult %t40, %EffectParseResult* %l13
  %t41 = load %EffectParseResult, %EffectParseResult* %l13
  %t42 = extractvalue %EffectParseResult %t41, 1
  store { i8**, i64 }* %t42, { i8**, i64 }** %l14
  %t43 = call double @evaluate_decorators(double %decorators)
  store double %t43, double* %l15
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t45 = load double, double* %l15
  %t46 = call double @infer_effects({ i8**, i64 }* %t44, double %t45)
  store double %t46, double* %l16
  %t47 = call %BlockParseResult @parse_block(%Parser %parser)
  store %BlockParseResult %t47, %BlockParseResult* %l17
  %t48 = load %BlockParseResult, %BlockParseResult* %l17
  %t49 = extractvalue %BlockParseResult %t48, 1
  store i8* %t49, i8** %l18
  store double 0.0, double* %l19
  store double 0.0, double* %l20
  %t50 = insertvalue %StatementParseResult undef, i8* null, 0
  %t51 = load double, double* %l20
  %t52 = insertvalue %StatementParseResult %t50, i8* null, 1
  ret %StatementParseResult %t52
}

define %ParameterListParseResult @parse_parameter_list(%Parser %parser) {
entry:
  %l0 = alloca { double*, i64 }*
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
  store { double*, i64 }* %t2, { double*, i64 }** %l0
  %t5 = call double @parser_peek_raw(%Parser %parser)
  store double %t5, double* %l1
  %t6 = load double, double* %l1
  %t7 = load { double*, i64 }*, { double*, i64 }** %l0
  %t8 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t19 = phi { double*, i64 }* [ %t7, %entry ], [ %t18, %loop.latch2 ]
  store { double*, i64 }* %t19, { double*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t9 = call %ParameterParseResult @parse_single_parameter(%Parser %parser)
  store %ParameterParseResult %t9, %ParameterParseResult* %l2
  %t10 = load { double*, i64 }*, { double*, i64 }** %l0
  %t11 = load %ParameterParseResult, %ParameterParseResult* %l2
  %t12 = extractvalue %ParameterParseResult %t11, 1
  %t13 = call double @append_parameter(double 0.0, double 0.0)
  store { double*, i64 }* null, { double*, i64 }** %l0
  %t14 = call double @parser_peek_raw(%Parser %parser)
  store double %t14, double* %l3
  %t15 = load double, double* %l3
  %t16 = load double, double* %l3
  %t17 = load double, double* %l3
  br label %loop.latch2
loop.latch2:
  %t18 = load { double*, i64 }*, { double*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t20 = insertvalue %ParameterListParseResult undef, i8* null, 0
  %t21 = load { double*, i64 }*, { double*, i64 }** %l0
  %t22 = insertvalue %ParameterListParseResult %t20, { i8**, i64 }* null, 1
  ret %ParameterListParseResult %t22
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
  %t6 = call i1 @identifier_matches(double %t4, i8* %s5)
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
  %t23 = call i8* @identifier_text(double %t22)
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
  %t31 = call double @source_span_from_tokens(double 0.0)
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
  %t55 = call i8* @tokens_to_text(double 0.0)
  %t56 = call i8* @trim_text(i8* %t55)
  store i8* %t56, i8** %l9
  %t57 = load i8*, i8** %l9
  %t58 = load %Parser, %Parser* %l0
  %t59 = call %Parser @skip_trivia(%Parser %t58)
  store %Parser %t59, %Parser* %l0
  %t60 = load %Parser, %Parser* %l0
  %t61 = call double @parser_peek_raw(%Parser %t60)
  store double %t61, double* %l10
  %t62 = load double, double* %l10
  %t63 = load %Parser, %Parser* %l0
  %t64 = call %Parser @parser_advance_raw(%Parser %t63)
  store %Parser %t64, %Parser* %l0
  store double 0.0, double* %l11
  %t65 = load %Parser, %Parser* %l0
  %t66 = insertvalue %StructFieldParseResult undef, i8* null, 0
  %t67 = load double, double* %l11
  %t68 = insertvalue %StructFieldParseResult %t66, i8* null, 1
  %t69 = insertvalue %StructFieldParseResult %t68, i1 1, 2
  ret %StructFieldParseResult %t69
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
  %t5 = call i8* @identifier_text(double %t4)
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
  %t12 = load double, double* %l3
  %t13 = load %Parser, %Parser* %l0
  %t14 = call %Parser @parser_advance_raw(%Parser %t13)
  store %Parser %t14, %Parser* %l0
  %t15 = load %Parser, %Parser* %l0
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
  store %CaptureResult %t24, %CaptureResult* %l4
  %t25 = load %CaptureResult, %CaptureResult* %l4
  %t26 = extractvalue %CaptureResult %t25, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t27 = load %CaptureResult, %CaptureResult* %l4
  %t28 = extractvalue %CaptureResult %t27, 1
  %t29 = call double @expression_from_tokens(double 0.0)
  store double %t29, double* %l5
  %t30 = load %Parser, %Parser* %l0
  %t31 = call %Parser @skip_trivia(%Parser %t30)
  store %Parser %t31, %Parser* %l0
  %t32 = load %Parser, %Parser* %l0
  %t33 = call double @parser_peek_raw(%Parser %t32)
  store double %t33, double* %l6
  %t34 = load double, double* %l6
  %t35 = load %Parser, %Parser* %l0
  %t36 = call %Parser @parser_advance_raw(%Parser %t35)
  store %Parser %t36, %Parser* %l0
  store double 0.0, double* %l7
  %t37 = load %Parser, %Parser* %l0
  %t38 = insertvalue %ModelPropertyParseResult undef, i8* null, 0
  %t39 = load double, double* %l7
  %t40 = insertvalue %ModelPropertyParseResult %t38, i8* null, 1
  %t41 = insertvalue %ModelPropertyParseResult %t40, i1 1, 2
  ret %ModelPropertyParseResult %t41
}

define %MethodParseResult @parse_struct_method(%Parser %parser, double %decorators) {
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
  %l11 = alloca double
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
  %t5 = call i1 @identifier_matches(double %t3, i8* %s4)
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
  %t15 = call i1 @identifier_matches(double %t13, i8* %s14)
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
  %t49 = call i8* @identifier_text(double %t48)
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
  %t57 = call double @source_span_from_tokens(double 0.0)
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
  store double 0.0, double* %l11
  %t79 = load %Parser, %Parser* %l0
  %t80 = call double @parser_peek_raw(%Parser %t79)
  store double %t80, double* %l12
  %t81 = load double, double* %l12
  %t82 = load %Parser, %Parser* %l0
  %t83 = call %EffectParseResult @parse_effect_list(%Parser %t82)
  store %EffectParseResult %t83, %EffectParseResult* %l13
  %t84 = load %EffectParseResult, %EffectParseResult* %l13
  %t85 = extractvalue %EffectParseResult %t84, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t86 = load %EffectParseResult, %EffectParseResult* %l13
  %t87 = extractvalue %EffectParseResult %t86, 1
  store { i8**, i64 }* %t87, { i8**, i64 }** %l14
  %t88 = call double @evaluate_decorators(double %decorators)
  store double %t88, double* %l15
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t90 = load double, double* %l15
  %t91 = call double @infer_effects({ i8**, i64 }* %t89, double %t90)
  store double %t91, double* %l16
  %t92 = load %Parser, %Parser* %l0
  %t93 = call %BlockParseResult @parse_block(%Parser %t92)
  store %BlockParseResult %t93, %BlockParseResult* %l17
  %t94 = load %BlockParseResult, %BlockParseResult* %l17
  %t95 = extractvalue %BlockParseResult %t94, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t96 = load %BlockParseResult, %BlockParseResult* %l17
  %t97 = extractvalue %BlockParseResult %t96, 1
  store i8* %t97, i8** %l18
  store double 0.0, double* %l19
  store double 0.0, double* %l20
  %t98 = load %Parser, %Parser* %l0
  %t99 = insertvalue %MethodParseResult undef, i8* null, 0
  %t100 = load double, double* %l20
  %t101 = insertvalue %MethodParseResult %t99, i8* null, 1
  %t102 = insertvalue %MethodParseResult %t101, i1 1, 2
  ret %MethodParseResult %t102
}

define %DecoratorParseResult @parse_decorators(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca { double*, i64 }*
  %l2 = alloca double
  %l3 = alloca %Parser
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca { double*, i64 }*
  %l7 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { double*, i64 }* %t2, { double*, i64 }** %l1
  %t5 = load %Parser, %Parser* %l0
  %t6 = load { double*, i64 }*, { double*, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t37 = phi %Parser [ %t5, %entry ], [ %t35, %loop.latch2 ]
  %t38 = phi { double*, i64 }* [ %t6, %entry ], [ %t36, %loop.latch2 ]
  store %Parser %t37, %Parser* %l0
  store { double*, i64 }* %t38, { double*, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t7 = load %Parser, %Parser* %l0
  %t8 = call %Parser @skip_trivia(%Parser %t7)
  store %Parser %t8, %Parser* %l0
  %t9 = load %Parser, %Parser* %l0
  %t10 = call double @parser_peek_raw(%Parser %t9)
  store double %t10, double* %l2
  %t11 = load double, double* %l2
  %t12 = load %Parser, %Parser* %l0
  store %Parser %t12, %Parser* %l3
  %t13 = load %Parser, %Parser* %l0
  %t14 = call %Parser @parser_advance_raw(%Parser %t13)
  store %Parser %t14, %Parser* %l0
  %t15 = load %Parser, %Parser* %l0
  %t16 = call %Parser @skip_trivia(%Parser %t15)
  store %Parser %t16, %Parser* %l0
  %t17 = load %Parser, %Parser* %l0
  %t18 = call double @parser_peek_raw(%Parser %t17)
  store double %t18, double* %l4
  %t19 = load double, double* %l4
  %t20 = load double, double* %l4
  %t21 = call i8* @identifier_text(double %t20)
  store i8* %t21, i8** %l5
  %t22 = load %Parser, %Parser* %l0
  %t23 = call %Parser @parser_advance_raw(%Parser %t22)
  store %Parser %t23, %Parser* %l0
  %t24 = load %Parser, %Parser* %l0
  %t25 = call %Parser @skip_trivia(%Parser %t24)
  store %Parser %t25, %Parser* %l0
  %t26 = alloca [0 x double]
  %t27 = getelementptr [0 x double], [0 x double]* %t26, i32 0, i32 0
  %t28 = alloca { double*, i64 }
  %t29 = getelementptr { double*, i64 }, { double*, i64 }* %t28, i32 0, i32 0
  store double* %t27, double** %t29
  %t30 = getelementptr { double*, i64 }, { double*, i64 }* %t28, i32 0, i32 1
  store i64 0, i64* %t30
  store { double*, i64 }* %t28, { double*, i64 }** %l6
  %t31 = load %Parser, %Parser* %l0
  %t32 = call double @parser_peek_raw(%Parser %t31)
  store double %t32, double* %l7
  %t33 = load double, double* %l7
  %t34 = load { double*, i64 }*, { double*, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t35 = load %Parser, %Parser* %l0
  %t36 = load { double*, i64 }*, { double*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t39 = load %Parser, %Parser* %l0
  %t40 = insertvalue %DecoratorParseResult undef, i8* null, 0
  %t41 = load { double*, i64 }*, { double*, i64 }** %l1
  %t42 = insertvalue %DecoratorParseResult %t40, { i8**, i64 }* null, 1
  ret %DecoratorParseResult %t42
}

define %TypeParameterParseResult @parse_type_parameter_clause(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca { double*, i64 }*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca { double*, i64 }*
  %l7 = alloca double
  %l8 = alloca double
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l1
  %t3 = load double, double* %l1
  %t4 = load %Parser, %Parser* %l0
  %t5 = call %Parser @parser_advance_raw(%Parser %t4)
  store %Parser %t5, %Parser* %l0
  %t6 = alloca [0 x double]
  %t7 = getelementptr [0 x double], [0 x double]* %t6, i32 0, i32 0
  %t8 = alloca { double*, i64 }
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 0
  store double* %t7, double** %t9
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
  store { double*, i64 }* %t8, { double*, i64 }** %l2
  %t11 = sitofp i64 1 to double
  store double %t11, double* %l3
  %t12 = load %Parser, %Parser* %l0
  %t13 = load double, double* %l1
  %t14 = load { double*, i64 }*, { double*, i64 }** %l2
  %t15 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t27 = phi { double*, i64 }* [ %t14, %entry ], [ %t25, %loop.latch2 ]
  %t28 = phi %Parser [ %t12, %entry ], [ %t26, %loop.latch2 ]
  store { double*, i64 }* %t27, { double*, i64 }** %l2
  store %Parser %t28, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t16 = load %Parser, %Parser* %l0
  %t17 = call double @parser_peek_raw(%Parser %t16)
  store double %t17, double* %l4
  %t18 = load double, double* %l4
  %t19 = load double, double* %l4
  %t20 = load { double*, i64 }*, { double*, i64 }** %l2
  %t21 = load double, double* %l4
  %t22 = call double @append_token(double 0.0, double %t21)
  store { double*, i64 }* null, { double*, i64 }** %l2
  %t23 = load %Parser, %Parser* %l0
  %t24 = call %Parser @parser_advance_raw(%Parser %t23)
  store %Parser %t24, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t25 = load { double*, i64 }*, { double*, i64 }** %l2
  %t26 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t29 = load { double*, i64 }*, { double*, i64 }** %l2
  %t30 = call double @split_token_slices_by_comma(double 0.0)
  store double %t30, double* %l5
  %t31 = alloca [0 x double]
  %t32 = getelementptr [0 x double], [0 x double]* %t31, i32 0, i32 0
  %t33 = alloca { double*, i64 }
  %t34 = getelementptr { double*, i64 }, { double*, i64 }* %t33, i32 0, i32 0
  store double* %t32, double** %t34
  %t35 = getelementptr { double*, i64 }, { double*, i64 }* %t33, i32 0, i32 1
  store i64 0, i64* %t35
  store { double*, i64 }* %t33, { double*, i64 }** %l6
  %t36 = sitofp i64 0 to double
  store double %t36, double* %l7
  %t37 = load %Parser, %Parser* %l0
  %t38 = load double, double* %l1
  %t39 = load { double*, i64 }*, { double*, i64 }** %l2
  %t40 = load double, double* %l3
  %t41 = load double, double* %l5
  %t42 = load { double*, i64 }*, { double*, i64 }** %l6
  %t43 = load double, double* %l7
  br label %loop.header4
loop.header4:
  br label %loop.body5
loop.body5:
  %t44 = load double, double* %l7
  %t45 = load double, double* %l5
  %t46 = load double, double* %l5
  %t47 = load double, double* %l7
  store double 0.0, double* %l8
  %t48 = load double, double* %l8
  br label %loop.latch6
loop.latch6:
  br label %loop.header4
afterloop7:
  %t49 = load %Parser, %Parser* %l0
  %t50 = insertvalue %TypeParameterParseResult undef, i8* null, 0
  %t51 = load { double*, i64 }*, { double*, i64 }** %l6
  %t52 = insertvalue %TypeParameterParseResult %t50, { i8**, i64 }* null, 1
  ret %TypeParameterParseResult %t52
}

define %ImplementsParseResult @parse_implements_clause(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %CaptureResult
  %l2 = alloca { double*, i64 }*
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
  store { double*, i64 }* %t33, { double*, i64 }** %l2
  %t36 = load %CaptureResult, %CaptureResult* %l1
  %t37 = extractvalue %CaptureResult %t36, 1
  %t38 = call { i8**, i64 }* @split_tokens_by_comma(double 0.0)
  store { i8**, i64 }* %t38, { i8**, i64 }** %l3
  %t39 = sitofp i64 0 to double
  store double %t39, double* %l4
  %t40 = load %Parser, %Parser* %l0
  %t41 = load %CaptureResult, %CaptureResult* %l1
  %t42 = load { double*, i64 }*, { double*, i64 }** %l2
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t44 = load double, double* %l4
  br label %loop.header2
loop.header2:
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
  br label %loop.latch4
loop.latch4:
  br label %loop.header2
afterloop5:
  %t57 = load %Parser, %Parser* %l0
  %t58 = insertvalue %ImplementsParseResult undef, i8* null, 0
  %t59 = load { double*, i64 }*, { double*, i64 }** %l2
  %t60 = insertvalue %ImplementsParseResult %t58, { i8**, i64 }* null, 1
  %t61 = insertvalue %ImplementsParseResult %t60, i1 1, 2
  ret %ImplementsParseResult %t61
}

define %ParameterParseResult @parse_single_parameter(%Parser %parser) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
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
  %t5 = call i1 @identifier_matches(double %t3, i8* %s4)
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
  %t13 = call i8* @identifier_text(double %t12)
  store i8* %t13, i8** %l5
  store double 0.0, double* %l6
  %t14 = call double @parser_peek_raw(%Parser %parser)
  store double %t14, double* %l7
  %t15 = load double, double* %l7
  store double 0.0, double* %l8
  %t16 = call double @parser_peek_raw(%Parser %parser)
  store double %t16, double* %l9
  %t17 = load double, double* %l9
  %t18 = extractvalue %Parser %parser, 1
  store double %t18, double* %l10
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = load double, double* %l10
  %t22 = call double @token_slice(double 0.0, double %t20, double %t21)
  store double %t22, double* %l11
  %t23 = load double, double* %l11
  %t24 = call double @source_span_from_tokens(double %t23)
  store double %t24, double* %l12
  store double 0.0, double* %l13
  %t25 = insertvalue %ParameterParseResult undef, i8* null, 0
  %t26 = load double, double* %l13
  %t27 = insertvalue %ParameterParseResult %t25, i8* null, 1
  ret %ParameterParseResult %t27
}

define %EffectParseResult @parse_effect_list(%Parser %parser) {
entry:
  %l0 = alloca double
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = alloca [0 x double]
  %t3 = getelementptr [0 x double], [0 x double]* %t2, i32 0, i32 0
  %t4 = alloca { double*, i64 }
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t4, i32 0, i32 0
  store double* %t3, double** %t5
  %t6 = getelementptr { double*, i64 }, { double*, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t7 = load double, double* %l0
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t9 = call double @parser_peek_raw(%Parser %parser)
  store double %t9, double* %l2
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t12 = insertvalue %EffectParseResult undef, i8* null, 0
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t14 = insertvalue %EffectParseResult %t12, { i8**, i64 }* %t13, 1
  ret %EffectParseResult %t14
}

define %BlockParseResult @parse_block(%Parser %parser) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca %Parser
  %l3 = alloca double
  %l4 = alloca { double*, i64 }*
  %l5 = alloca double
  %l6 = alloca %BlockStatementParseResult
  %l7 = alloca double
  %l8 = alloca %StatementParseResult
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca i8*
  %l12 = alloca double
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = extractvalue %Parser %parser, 1
  store double %t2, double* %l1
  %t3 = call %Parser @parser_advance_raw(%Parser %parser)
  store %Parser %t3, %Parser* %l2
  %t4 = load double, double* %l1
  store double %t4, double* %l3
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { double*, i64 }* %t7, { double*, i64 }** %l4
  %t10 = load double, double* %l0
  %t11 = load double, double* %l1
  %t12 = load %Parser, %Parser* %l2
  %t13 = load double, double* %l3
  %t14 = load { double*, i64 }*, { double*, i64 }** %l4
  br label %loop.header0
loop.header0:
  %t61 = phi %Parser [ %t12, %entry ], [ %t60, %loop.latch2 ]
  store %Parser %t61, %Parser* %l2
  br label %loop.body1
loop.body1:
  %t15 = load %Parser, %Parser* %l2
  %t16 = call %Parser @skip_trivia(%Parser %t15)
  store %Parser %t16, %Parser* %l2
  %t17 = load %Parser, %Parser* %l2
  %t18 = call double @parser_peek_raw(%Parser %t17)
  store double %t18, double* %l5
  %t19 = load double, double* %l5
  %t20 = load double, double* %l5
  %t21 = load %Parser, %Parser* %l2
  %t22 = call %BlockStatementParseResult @parse_block_statement(%Parser %t21)
  store %BlockStatementParseResult %t22, %BlockStatementParseResult* %l6
  %t23 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t24 = extractvalue %BlockStatementParseResult %t23, 2
  %t25 = load double, double* %l0
  %t26 = load double, double* %l1
  %t27 = load %Parser, %Parser* %l2
  %t28 = load double, double* %l3
  %t29 = load { double*, i64 }*, { double*, i64 }** %l4
  %t30 = load double, double* %l5
  %t31 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  br i1 %t24, label %then4, label %merge5
then4:
  %t32 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t33 = extractvalue %BlockStatementParseResult %t32, 0
  store %Parser zeroinitializer, %Parser* %l2
  %t34 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t35 = extractvalue %BlockStatementParseResult %t34, 1
  br label %loop.latch2
merge5:
  %t36 = load %Parser, %Parser* %l2
  %t37 = extractvalue %Parser %t36, 1
  store double %t37, double* %l7
  %t38 = load %Parser, %Parser* %l2
  %t39 = call %StatementParseResult @parse_unknown(%Parser %t38)
  store %StatementParseResult %t39, %StatementParseResult* %l8
  %t40 = load %StatementParseResult, %StatementParseResult* %l8
  %t41 = extractvalue %StatementParseResult %t40, 0
  store %Parser zeroinitializer, %Parser* %l2
  %t42 = load %StatementParseResult, %StatementParseResult* %l8
  %t43 = extractvalue %StatementParseResult %t42, 1
  %t44 = load %Parser, %Parser* %l2
  %t45 = extractvalue %Parser %t44, 1
  %t46 = load double, double* %l7
  %t47 = fcmp ole double %t45, %t46
  %t48 = load double, double* %l0
  %t49 = load double, double* %l1
  %t50 = load %Parser, %Parser* %l2
  %t51 = load double, double* %l3
  %t52 = load { double*, i64 }*, { double*, i64 }** %l4
  %t53 = load double, double* %l5
  %t54 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t55 = load double, double* %l7
  %t56 = load %StatementParseResult, %StatementParseResult* %l8
  br i1 %t47, label %then6, label %merge7
then6:
  %t57 = load %Parser, %Parser* %l2
  %t58 = call %Parser @parser_advance_raw(%Parser %t57)
  store %Parser %t58, %Parser* %l2
  br label %merge7
merge7:
  %t59 = phi %Parser [ %t58, %then6 ], [ %t50, %loop.body1 ]
  store %Parser %t59, %Parser* %l2
  br label %loop.latch2
loop.latch2:
  %t60 = load %Parser, %Parser* %l2
  br label %loop.header0
afterloop3:
  %t62 = load %Parser, %Parser* %l2
  %t63 = extractvalue %Parser %t62, 1
  store double %t63, double* %l9
  %t64 = load double, double* %l3
  %t65 = load double, double* %l1
  %t66 = fcmp ogt double %t64, %t65
  %t67 = load double, double* %l0
  %t68 = load double, double* %l1
  %t69 = load %Parser, %Parser* %l2
  %t70 = load double, double* %l3
  %t71 = load { double*, i64 }*, { double*, i64 }** %l4
  %t72 = load double, double* %l9
  br i1 %t66, label %then8, label %merge9
then8:
  %t73 = load double, double* %l3
  store double %t73, double* %l9
  br label %merge9
merge9:
  %t74 = phi double [ %t73, %then8 ], [ %t72, %entry ]
  store double %t74, double* %l9
  %t75 = extractvalue %Parser %parser, 0
  %t76 = load double, double* %l1
  %t77 = load double, double* %l9
  %t78 = call double @token_slice(double 0.0, double %t76, double %t77)
  store double %t78, double* %l10
  %t79 = load double, double* %l10
  %t80 = call double @trim_block_tokens(double %t79)
  store double %t80, double* %l10
  %t81 = load double, double* %l10
  %t82 = call i8* @tokens_to_text(double %t81)
  store i8* %t82, i8** %l11
  store double 0.0, double* %l12
  %t83 = load %Parser, %Parser* %l2
  %t84 = call %Parser @skip_trivia(%Parser %t83)
  %t85 = insertvalue %BlockParseResult undef, i8* null, 0
  %t86 = load double, double* %l12
  %t87 = insertvalue %BlockParseResult %t85, i8* null, 1
  ret %BlockParseResult %t87
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
  %t11 = call i1 @identifier_matches(double %t9, i8* %s10)
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
  %t20 = call %BlockStatementParseResult @parse_for_statement(%Parser %t18, double 0.0)
  ret %BlockStatementParseResult %t20
merge1:
  %t21 = load double, double* %l5
  %s22 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.22, i32 0, i32 0
  %t23 = call i1 @identifier_matches(double %t21, i8* %s22)
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
  %t32 = call %BlockStatementParseResult @parse_loop_statement(%Parser %t30, double 0.0)
  ret %BlockStatementParseResult %t32
merge3:
  %t33 = load double, double* %l5
  %s34 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.34, i32 0, i32 0
  %t35 = call i1 @identifier_matches(double %t33, i8* %s34)
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
  %t47 = call i1 @identifier_matches(double %t45, i8* %s46)
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
  %t59 = call i1 @identifier_matches(double %t57, i8* %s58)
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
  %t68 = call %BlockStatementParseResult @parse_if_statement(%Parser %t66, double 0.0)
  ret %BlockStatementParseResult %t68
merge9:
  %t69 = load double, double* %l5
  %s70 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.70, i32 0, i32 0
  %t71 = call i1 @identifier_matches(double %t69, i8* %s70)
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
  %t80 = call %BlockStatementParseResult @parse_match_statement(%Parser %t78, double 0.0)
  ret %BlockStatementParseResult %t80
merge11:
  %t81 = load double, double* %l5
  %s82 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.82, i32 0, i32 0
  %t83 = call i1 @identifier_matches(double %t81, i8* %s82)
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
  %t92 = call %BlockStatementParseResult @parse_prompt_statement(%Parser %t90, double 0.0)
  ret %BlockStatementParseResult %t92
merge13:
  %t93 = load double, double* %l5
  %s94 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.94, i32 0, i32 0
  %t95 = call i1 @identifier_matches(double %t93, i8* %s94)
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
  %t104 = call %BlockStatementParseResult @parse_with_statement(%Parser %t102, double 0.0)
  ret %BlockStatementParseResult %t104
merge15:
  %t105 = load double, double* %l5
  %s106 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.106, i32 0, i32 0
  %t107 = call i1 @identifier_matches(double %t105, i8* %s106)
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
  %t119 = call %BlockStatementParseResult @parse_expression_statement(%Parser %t117, double 0.0)
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

define %BlockStatementParseResult @parse_for_statement(%Parser %parser, double %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %CaptureResult
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
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
  %t29 = call double @trim_token_edges(double 0.0)
  store double %t29, double* %l3
  %t30 = load double, double* %l3
  %t31 = load double, double* %l3
  %s32 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.32, i32 0, i32 0
  %t33 = call double @find_top_level_identifier(double %t31, i8* %s32)
  store double %t33, double* %l4
  %t34 = load double, double* %l4
  %t35 = sitofp i64 -1 to double
  %t36 = fcmp oeq double %t34, %t35
  %t37 = load %Parser, %Parser* %l0
  %t38 = load %Parser, %Parser* %l1
  %t39 = load %CaptureResult, %CaptureResult* %l2
  %t40 = load double, double* %l3
  %t41 = load double, double* %l4
  br i1 %t36, label %then2, label %merge3
then2:
  %t42 = load %Parser, %Parser* %l0
  %t43 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t44 = insertvalue %BlockStatementParseResult %t43, i8* null, 1
  %t45 = insertvalue %BlockStatementParseResult %t44, i1 0, 2
  ret %BlockStatementParseResult %t45
merge3:
  %t46 = load double, double* %l3
  %t47 = load double, double* %l4
  %t48 = sitofp i64 0 to double
  %t49 = call double @token_slice(double %t46, double %t48, double %t47)
  %t50 = call double @trim_token_edges(double %t49)
  store double %t50, double* %l5
  %t51 = load double, double* %l3
  %t52 = load double, double* %l4
  %t53 = sitofp i64 1 to double
  %t54 = fadd double %t52, %t53
  %t55 = load double, double* %l3
  store double 0.0, double* %l6
  %t56 = load double, double* %l5
  %t57 = load double, double* %l5
  %t58 = call double @expression_from_tokens(double %t57)
  store double %t58, double* %l7
  %t59 = load double, double* %l6
  %t60 = call double @expression_from_tokens(double %t59)
  store double %t60, double* %l8
  store double 0.0, double* %l9
  %t61 = load %Parser, %Parser* %l1
  %t62 = call %BlockParseResult @parse_block(%Parser %t61)
  store %BlockParseResult %t62, %BlockParseResult* %l10
  %t63 = load %BlockParseResult, %BlockParseResult* %l10
  %t64 = extractvalue %BlockParseResult %t63, 1
  %t65 = load %BlockParseResult, %BlockParseResult* %l10
  %t66 = extractvalue %BlockParseResult %t65, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t67 = load %BlockParseResult, %BlockParseResult* %l10
  %t68 = extractvalue %BlockParseResult %t67, 1
  store i8* %t68, i8** %l11
  %t69 = load %Parser, %Parser* %l1
  %t70 = call %Parser @skip_trivia(%Parser %t69)
  store %Parser %t70, %Parser* %l1
  %t71 = load %Parser, %Parser* %l1
  %t72 = call double @parser_peek_raw(%Parser %t71)
  store double %t72, double* %l12
  %t73 = load double, double* %l12
  store double 0.0, double* %l13
  %t74 = load %Parser, %Parser* %l1
  %t75 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t76 = load double, double* %l13
  %t77 = insertvalue %BlockStatementParseResult %t75, i8* null, 1
  %t78 = insertvalue %BlockStatementParseResult %t77, i1 1, 2
  ret %BlockStatementParseResult %t78
}

define %BlockStatementParseResult @parse_loop_statement(%Parser %parser, double %decorators) {
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
  %t25 = load double, double* %l3
  store double 0.0, double* %l4
  %t26 = load %Parser, %Parser* %l1
  %t27 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t28 = load double, double* %l4
  %t29 = insertvalue %BlockStatementParseResult %t27, i8* null, 1
  %t30 = insertvalue %BlockStatementParseResult %t29, i1 1, 2
  ret %BlockStatementParseResult %t30
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
  %t19 = load double, double* %l2
  %t20 = load %Parser, %Parser* %l1
  %t21 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t22 = call double @StatementBreakStatement()
  %t23 = insertvalue %BlockStatementParseResult %t21, i8* null, 1
  %t24 = insertvalue %BlockStatementParseResult %t23, i1 1, 2
  ret %BlockStatementParseResult %t24
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
  %t19 = load double, double* %l2
  %t20 = load %Parser, %Parser* %l1
  %t21 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t22 = call double @StatementContinueStatement()
  %t23 = insertvalue %BlockStatementParseResult %t21, i8* null, 1
  %t24 = insertvalue %BlockStatementParseResult %t23, i1 1, 2
  ret %BlockStatementParseResult %t24
}

define %BlockStatementParseResult @parse_if_statement(%Parser %parser, double %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %CaptureResult
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca %BlockParseResult
  %l6 = alloca i8*
  %l7 = alloca double
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
  %t29 = call double @trim_token_edges(double 0.0)
  store double %t29, double* %l3
  %t30 = load double, double* %l3
  %t31 = load double, double* %l3
  %t32 = call double @expression_from_tokens(double %t31)
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
  store double 0.0, double* %l7
  %t43 = load %Parser, %Parser* %l1
  %t44 = call double @parser_peek_raw(%Parser %t43)
  %s45 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.45, i32 0, i32 0
  %t46 = call i1 @identifier_matches(double %t44, i8* %s45)
  %t47 = load %Parser, %Parser* %l0
  %t48 = load %Parser, %Parser* %l1
  %t49 = load %CaptureResult, %CaptureResult* %l2
  %t50 = load double, double* %l3
  %t51 = load double, double* %l4
  %t52 = load %BlockParseResult, %BlockParseResult* %l5
  %t53 = load i8*, i8** %l6
  %t54 = load double, double* %l7
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
  %t64 = call i1 @identifier_matches(double %t62, i8* %s63)
  %t65 = load %Parser, %Parser* %l0
  %t66 = load %Parser, %Parser* %l1
  %t67 = load %CaptureResult, %CaptureResult* %l2
  %t68 = load double, double* %l3
  %t69 = load double, double* %l4
  %t70 = load %BlockParseResult, %BlockParseResult* %l5
  %t71 = load i8*, i8** %l6
  %t72 = load double, double* %l7
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
  %t80 = call %BlockStatementParseResult @parse_if_statement(%Parser %t74, double 0.0)
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
  %t92 = phi double [ 0.0, %then4 ], [ 0.0, %else5 ]
  store %Parser %t91, %Parser* %l1
  store double %t92, double* %l7
  %t93 = load %Parser, %Parser* %l1
  %t94 = call %Parser @skip_trivia(%Parser %t93)
  store %Parser %t94, %Parser* %l1
  %t95 = load %Parser, %Parser* %l1
  %t96 = call double @parser_peek_raw(%Parser %t95)
  store double %t96, double* %l11
  %t97 = load double, double* %l11
  br label %merge3
merge3:
  %t98 = phi %Parser [ %t57, %then2 ], [ %t48, %entry ]
  %t99 = phi %Parser [ %t59, %then2 ], [ %t48, %entry ]
  %t100 = phi %Parser [ zeroinitializer, %then2 ], [ %t48, %entry ]
  %t101 = phi double [ 0.0, %then2 ], [ %t54, %entry ]
  %t102 = phi %Parser [ zeroinitializer, %then2 ], [ %t48, %entry ]
  %t103 = phi double [ 0.0, %then2 ], [ %t54, %entry ]
  %t104 = phi %Parser [ %t94, %then2 ], [ %t48, %entry ]
  store %Parser %t98, %Parser* %l1
  store %Parser %t99, %Parser* %l1
  store %Parser %t100, %Parser* %l1
  store double %t101, double* %l7
  store %Parser %t102, %Parser* %l1
  store double %t103, double* %l7
  store %Parser %t104, %Parser* %l1
  store double 0.0, double* %l12
  %t105 = load %Parser, %Parser* %l1
  %t106 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t107 = load double, double* %l12
  %t108 = insertvalue %BlockStatementParseResult %t106, i8* null, 1
  %t109 = insertvalue %BlockStatementParseResult %t108, i1 1, 2
  ret %BlockStatementParseResult %t109
}

define %BlockStatementParseResult @parse_match_statement(%Parser %parser, double %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %CaptureResult
  %l3 = alloca double
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
  %t29 = call double @trim_token_edges(double 0.0)
  store double %t29, double* %l3
  %t30 = load double, double* %l3
  %t31 = load double, double* %l3
  %t32 = call double @expression_from_tokens(double %t31)
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
  %l2 = alloca { double*, i64 }*
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
  %t6 = load double, double* %l1
  %t7 = load %Parser, %Parser* %l0
  %t8 = call %Parser @parser_advance_raw(%Parser %t7)
  store %Parser %t8, %Parser* %l0
  %t9 = alloca [0 x double]
  %t10 = getelementptr [0 x double], [0 x double]* %t9, i32 0, i32 0
  %t11 = alloca { double*, i64 }
  %t12 = getelementptr { double*, i64 }, { double*, i64 }* %t11, i32 0, i32 0
  store double* %t10, double** %t12
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t11, i32 0, i32 1
  store i64 0, i64* %t13
  store { double*, i64 }* %t11, { double*, i64 }** %l2
  %t14 = load %Parser, %Parser* %l0
  %t15 = load double, double* %l1
  %t16 = load { double*, i64 }*, { double*, i64 }** %l2
  br label %loop.header0
loop.header0:
  %t38 = phi %Parser [ %t14, %entry ], [ %t36, %loop.latch2 ]
  %t39 = phi { double*, i64 }* [ %t16, %entry ], [ %t37, %loop.latch2 ]
  store %Parser %t38, %Parser* %l0
  store { double*, i64 }* %t39, { double*, i64 }** %l2
  br label %loop.body1
loop.body1:
  %t17 = load %Parser, %Parser* %l0
  %t18 = call %Parser @skip_trivia(%Parser %t17)
  store %Parser %t18, %Parser* %l0
  %t19 = load %Parser, %Parser* %l0
  %t20 = call double @parser_peek_raw(%Parser %t19)
  store double %t20, double* %l3
  %t21 = load double, double* %l3
  %t22 = load double, double* %l3
  %t23 = load %Parser, %Parser* %l0
  %t24 = call %MatchCaseParseResult @parse_match_case(%Parser %t23)
  store %MatchCaseParseResult %t24, %MatchCaseParseResult* %l4
  %t25 = load %MatchCaseParseResult, %MatchCaseParseResult* %l4
  %t26 = extractvalue %MatchCaseParseResult %t25, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t27 = load { double*, i64 }*, { double*, i64 }** %l2
  %t28 = load %MatchCaseParseResult, %MatchCaseParseResult* %l4
  %t29 = extractvalue %MatchCaseParseResult %t28, 1
  %t30 = call double @append_match_case(double 0.0, double 0.0)
  store { double*, i64 }* null, { double*, i64 }** %l2
  %t31 = load %Parser, %Parser* %l0
  %t32 = call %Parser @skip_trivia(%Parser %t31)
  store %Parser %t32, %Parser* %l0
  %t33 = load %Parser, %Parser* %l0
  %t34 = call double @parser_peek_raw(%Parser %t33)
  store double %t34, double* %l5
  %t35 = load double, double* %l5
  br label %loop.latch2
loop.latch2:
  %t36 = load %Parser, %Parser* %l0
  %t37 = load { double*, i64 }*, { double*, i64 }** %l2
  br label %loop.header0
afterloop3:
  %t40 = load %Parser, %Parser* %l0
  %t41 = insertvalue %MatchCasesParseResult undef, i8* null, 0
  %t42 = load { double*, i64 }*, { double*, i64 }** %l2
  %t43 = insertvalue %MatchCasesParseResult %t41, { i8**, i64 }* null, 1
  %t44 = insertvalue %MatchCasesParseResult %t43, i1 1, 2
  ret %MatchCasesParseResult %t44
}

define %MatchCaseParseResult @parse_match_case(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %PatternCaptureResult
  %l3 = alloca %MatchCaseTokenSplit
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(double %t2, i8* %s3)
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
  %t20 = call %MatchCaseTokenSplit @split_match_case_tokens(double 0.0)
  store %MatchCaseTokenSplit %t20, %MatchCaseTokenSplit* %l3
  %t21 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t22 = extractvalue %MatchCaseTokenSplit %t21, 0
  %t23 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t24 = extractvalue %MatchCaseTokenSplit %t23, 0
  %t25 = call double @expression_from_tokens(double 0.0)
  store double %t25, double* %l4
  store double 0.0, double* %l5
  %t26 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t27 = extractvalue %MatchCaseTokenSplit %t26, 2
  %t28 = load %Parser, %Parser* %l0
  %t29 = load %Parser, %Parser* %l1
  %t30 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t31 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t32 = load double, double* %l4
  %t33 = load double, double* %l5
  br i1 %t27, label %then2, label %merge3
then2:
  %t34 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t35 = extractvalue %MatchCaseTokenSplit %t34, 1
  %t36 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t37 = extractvalue %MatchCaseTokenSplit %t36, 1
  %t38 = call double @expression_from_tokens(double 0.0)
  store double %t38, double* %l5
  br label %merge3
merge3:
  %t39 = phi double [ %t38, %then2 ], [ %t33, %entry ]
  store double %t39, double* %l5
  %t40 = load %Parser, %Parser* %l1
  %t41 = call %Parser @skip_trivia(%Parser %t40)
  store %Parser %t41, %Parser* %l1
  %t42 = load %Parser, %Parser* %l1
  %t43 = call double @parser_peek_raw(%Parser %t42)
  store double %t43, double* %l6
  store double 0.0, double* %l7
  %t44 = load double, double* %l6
  %t45 = load double, double* %l7
  store double 0.0, double* %l8
  %t46 = load %Parser, %Parser* %l1
  %t47 = insertvalue %MatchCaseParseResult undef, i8* null, 0
  %t48 = load double, double* %l8
  %t49 = insertvalue %MatchCaseParseResult %t47, i8* null, 1
  %t50 = insertvalue %MatchCaseParseResult %t49, i1 1, 2
  ret %MatchCaseParseResult %t50
}

define %BlockStatementParseResult @parse_prompt_statement(%Parser %parser, double %decorators) {
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
  %t33 = load %Parser, %Parser* %l1
  %t34 = call double @parser_peek_raw(%Parser %t33)
  store double 0.0, double* %l7
  %t35 = load %Parser, %Parser* %l1
  %t36 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t37 = load double, double* %l7
  %t38 = insertvalue %BlockStatementParseResult %t36, i8* null, 1
  %t39 = insertvalue %BlockStatementParseResult %t38, i1 1, 2
  ret %BlockStatementParseResult %t39
}

define %BlockStatementParseResult @parse_with_statement(%Parser %parser, double %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %CaptureResult
  %l3 = alloca double
  %l4 = alloca { double*, i64 }*
  %l5 = alloca double
  %l6 = alloca double
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
  %t29 = call double @split_token_slices_by_comma(double 0.0)
  store double %t29, double* %l3
  %t30 = alloca [0 x double]
  %t31 = getelementptr [0 x double], [0 x double]* %t30, i32 0, i32 0
  %t32 = alloca { double*, i64 }
  %t33 = getelementptr { double*, i64 }, { double*, i64 }* %t32, i32 0, i32 0
  store double* %t31, double** %t33
  %t34 = getelementptr { double*, i64 }, { double*, i64 }* %t32, i32 0, i32 1
  store i64 0, i64* %t34
  store { double*, i64 }* %t32, { double*, i64 }** %l4
  %t35 = sitofp i64 0 to double
  store double %t35, double* %l5
  %t36 = load %Parser, %Parser* %l0
  %t37 = load %Parser, %Parser* %l1
  %t38 = load %CaptureResult, %CaptureResult* %l2
  %t39 = load double, double* %l3
  %t40 = load { double*, i64 }*, { double*, i64 }** %l4
  %t41 = load double, double* %l5
  br label %loop.header2
loop.header2:
  br label %loop.body3
loop.body3:
  %t42 = load double, double* %l5
  %t43 = load double, double* %l3
  %t44 = load double, double* %l3
  %t45 = load double, double* %l5
  store double 0.0, double* %l6
  %t46 = load double, double* %l6
  br label %loop.latch4
loop.latch4:
  br label %loop.header2
afterloop5:
  %t47 = load %Parser, %Parser* %l1
  %t48 = call %BlockParseResult @parse_block(%Parser %t47)
  store %BlockParseResult %t48, %BlockParseResult* %l7
  %t49 = load %BlockParseResult, %BlockParseResult* %l7
  %t50 = extractvalue %BlockParseResult %t49, 1
  %t51 = load %BlockParseResult, %BlockParseResult* %l7
  %t52 = extractvalue %BlockParseResult %t51, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t53 = load %BlockParseResult, %BlockParseResult* %l7
  %t54 = extractvalue %BlockParseResult %t53, 1
  store i8* %t54, i8** %l8
  %t55 = load %Parser, %Parser* %l1
  %t56 = call %Parser @skip_trivia(%Parser %t55)
  store %Parser %t56, %Parser* %l1
  %t57 = load %Parser, %Parser* %l1
  %t58 = call double @parser_peek_raw(%Parser %t57)
  store double 0.0, double* %l9
  %t59 = load %Parser, %Parser* %l1
  %t60 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t61 = load double, double* %l9
  %t62 = insertvalue %BlockStatementParseResult %t60, i8* null, 1
  %t63 = insertvalue %BlockStatementParseResult %t62, i1 1, 2
  ret %BlockStatementParseResult %t63
}

define %BlockStatementParseResult @parse_return_statement(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca { double*, i64 }*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
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
  store { double*, i64 }* %t14, { double*, i64 }** %l2
  %t17 = load { double*, i64 }*, { double*, i64 }** %l2
  %t18 = load %Parser, %Parser* %l1
  %t19 = call double @parser_peek_raw(%Parser %t18)
  %t20 = call double @append_token(double 0.0, double %t19)
  store { double*, i64 }* null, { double*, i64 }** %l2
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
  store double 0.0, double* %l5
  %t28 = load double, double* %l4
  %t29 = sitofp i64 0 to double
  store double %t29, double* %l6
  %t30 = load %Parser, %Parser* %l0
  %t31 = load %Parser, %Parser* %l1
  %t32 = load { double*, i64 }*, { double*, i64 }** %l2
  %t33 = load double, double* %l3
  %t34 = load double, double* %l4
  %t35 = load double, double* %l5
  %t36 = load double, double* %l6
  br label %loop.header2
loop.header2:
  %t42 = phi { double*, i64 }* [ %t32, %entry ], [ %t41, %loop.latch4 ]
  store { double*, i64 }* %t42, { double*, i64 }** %l2
  br label %loop.body3
loop.body3:
  %t37 = load double, double* %l6
  %t38 = load double, double* %l3
  %t39 = load { double*, i64 }*, { double*, i64 }** %l2
  %t40 = load double, double* %l3
  br label %loop.latch4
loop.latch4:
  %t41 = load { double*, i64 }*, { double*, i64 }** %l2
  br label %loop.header2
afterloop5:
  %t43 = load %Parser, %Parser* %l1
  %t44 = call %Parser @skip_trivia(%Parser %t43)
  store %Parser %t44, %Parser* %l1
  %t45 = load %Parser, %Parser* %l1
  %t46 = call double @parser_peek_raw(%Parser %t45)
  store double %t46, double* %l7
  %t47 = load double, double* %l7
  %t48 = load { double*, i64 }*, { double*, i64 }** %l2
  %t49 = call double @source_span_from_tokens(double 0.0)
  store double %t49, double* %l8
  store double 0.0, double* %l9
  %t50 = load %Parser, %Parser* %l1
  %t51 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t52 = load double, double* %l9
  %t53 = insertvalue %BlockStatementParseResult %t51, i8* null, 1
  %t54 = insertvalue %BlockStatementParseResult %t53, i1 1, 2
  ret %BlockStatementParseResult %t54
}

define %BlockStatementParseResult @parse_expression_statement(%Parser %parser, double %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca %CaptureResult
  %l3 = alloca { double*, i64 }*
  %l4 = alloca double
  %l5 = alloca double
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
  store { double*, i64 }* %t18, { double*, i64 }** %l3
  %t21 = sitofp i64 0 to double
  store double %t21, double* %l4
  %t22 = load %Parser, %Parser* %l0
  %t23 = load double, double* %l1
  %t24 = load %CaptureResult, %CaptureResult* %l2
  %t25 = load { double*, i64 }*, { double*, i64 }** %l3
  %t26 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t42 = phi { double*, i64 }* [ %t25, %entry ], [ %t41, %loop.latch2 ]
  store { double*, i64 }* %t42, { double*, i64 }** %l3
  br label %loop.body1
loop.body1:
  %t27 = load double, double* %l4
  %t28 = load %CaptureResult, %CaptureResult* %l2
  %t29 = extractvalue %CaptureResult %t28, 1
  %t30 = load { double*, i64 }*, { double*, i64 }** %l3
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
  %t40 = call double @append_token(double 0.0, double 0.0)
  store { double*, i64 }* null, { double*, i64 }** %l3
  br label %loop.latch2
loop.latch2:
  %t41 = load { double*, i64 }*, { double*, i64 }** %l3
  br label %loop.header0
afterloop3:
  %t43 = load %CaptureResult, %CaptureResult* %l2
  %t44 = extractvalue %CaptureResult %t43, 1
  %t45 = call double @trim_token_edges(double 0.0)
  store double %t45, double* %l5
  %t46 = load double, double* %l5
  %t47 = load %CaptureResult, %CaptureResult* %l2
  %t48 = extractvalue %CaptureResult %t47, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t49 = load %Parser, %Parser* %l0
  %t50 = call %Parser @skip_trivia(%Parser %t49)
  store %Parser %t50, %Parser* %l0
  %t51 = load %Parser, %Parser* %l0
  %t52 = call double @parser_peek_raw(%Parser %t51)
  store double %t52, double* %l6
  %t53 = load double, double* %l6
  %t54 = load { double*, i64 }*, { double*, i64 }** %l3
  %t55 = load double, double* %l6
  %t56 = call double @append_token(double 0.0, double %t55)
  store { double*, i64 }* null, { double*, i64 }** %l3
  %t57 = load %Parser, %Parser* %l0
  %t58 = call %Parser @parser_advance_raw(%Parser %t57)
  store %Parser %t58, %Parser* %l0
  %t59 = load double, double* %l5
  %t60 = call double @expression_from_tokens(double %t59)
  store double %t60, double* %l7
  %t61 = load { double*, i64 }*, { double*, i64 }** %l3
  %t62 = call double @source_span_from_tokens(double 0.0)
  store double %t62, double* %l8
  store double 0.0, double* %l9
  %t63 = load %Parser, %Parser* %l0
  %t64 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t65 = load double, double* %l9
  %t66 = insertvalue %BlockStatementParseResult %t64, i8* null, 1
  %t67 = insertvalue %BlockStatementParseResult %t66, i1 1, 2
  ret %BlockStatementParseResult %t67
}

define %StatementParseResult @parse_unknown(%Parser %parser) {
entry:
  %l0 = alloca { double*, i64 }*
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
  store { double*, i64 }* %t2, { double*, i64 }** %l0
  store %Parser %parser, %Parser* %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = load { double*, i64 }*, { double*, i64 }** %l0
  %t7 = load %Parser, %Parser* %l1
  %t8 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t20 = phi { double*, i64 }* [ %t6, %entry ], [ %t18, %loop.latch2 ]
  %t21 = phi %Parser [ %t7, %entry ], [ %t19, %loop.latch2 ]
  store { double*, i64 }* %t20, { double*, i64 }** %l0
  store %Parser %t21, %Parser* %l1
  br label %loop.body1
loop.body1:
  %t9 = load %Parser, %Parser* %l1
  %t10 = call double @parser_peek_raw(%Parser %t9)
  store double %t10, double* %l3
  %t11 = load { double*, i64 }*, { double*, i64 }** %l0
  %t12 = load double, double* %l3
  %t13 = call double @append_token(double 0.0, double %t12)
  store { double*, i64 }* null, { double*, i64 }** %l0
  %t14 = load double, double* %l3
  %t15 = load double, double* %l3
  %t16 = load %Parser, %Parser* %l1
  %t17 = call %Parser @parser_advance_raw(%Parser %t16)
  store %Parser %t17, %Parser* %l1
  br label %loop.latch2
loop.latch2:
  %t18 = load { double*, i64 }*, { double*, i64 }** %l0
  %t19 = load %Parser, %Parser* %l1
  br label %loop.header0
afterloop3:
  %t22 = load { double*, i64 }*, { double*, i64 }** %l0
  %t23 = call i8* @tokens_to_text(double 0.0)
  store i8* %t23, i8** %l4
  store double 0.0, double* %l5
  %t24 = insertvalue %StatementParseResult undef, i8* null, 0
  %t25 = load double, double* %l5
  %t26 = insertvalue %StatementParseResult %t24, i8* null, 1
  ret %StatementParseResult %t26
}

define i1 @identifier_matches(double %token, i8* %expected) {
entry:
  ret i1 false
}

define i8* @identifier_text(double %token) {
entry:
  ret i8* null
}

define i8* @string_literal_value(double %token) {
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
  %t16 = call i1 @is_trivia_token(double 0.0)
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
  %t2 = call i1 @identifier_matches(double %t1, i8* %keyword)
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
  %t1 = load double, double* %l0
  ret %Parser %parser
}

define %CaptureResult @collect_until(%Parser %parser, { i8**, i64 }* %terminators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca { double*, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca %Parser
  store %Parser %parser, %Parser* %l0
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { double*, i64 }* %t2, { double*, i64 }** %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l3
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l4
  %t8 = load %Parser, %Parser* %l0
  %t9 = load { double*, i64 }*, { double*, i64 }** %l1
  %t10 = load double, double* %l2
  %t11 = load double, double* %l3
  %t12 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t48 = phi { double*, i64 }* [ %t9, %entry ], [ %t46, %loop.latch2 ]
  %t49 = phi %Parser [ %t8, %entry ], [ %t47, %loop.latch2 ]
  store { double*, i64 }* %t48, { double*, i64 }** %l1
  store %Parser %t49, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t13 = load %Parser, %Parser* %l0
  %t14 = call double @parser_peek_raw(%Parser %t13)
  store double %t14, double* %l5
  %t15 = load double, double* %l5
  %t16 = load double, double* %l2
  store double 0.0, double* %l6
  %t17 = load double, double* %l6
  %t18 = fcmp one double %t17, 0.0
  %t19 = load %Parser, %Parser* %l0
  %t20 = load { double*, i64 }*, { double*, i64 }** %l1
  %t21 = load double, double* %l2
  %t22 = load double, double* %l3
  %t23 = load double, double* %l4
  %t24 = load double, double* %l5
  %t25 = load double, double* %l6
  br i1 %t18, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t26 = load { double*, i64 }*, { double*, i64 }** %l1
  %t27 = load double, double* %l5
  %t28 = call double @append_token(double 0.0, double %t27)
  store { double*, i64 }* null, { double*, i64 }** %l1
  %t29 = load double, double* %l5
  %t30 = load %Parser, %Parser* %l0
  %t31 = call %Parser @parser_advance_raw(%Parser %t30)
  store %Parser %t31, %Parser* %l7
  %t32 = load %Parser, %Parser* %l7
  %t33 = extractvalue %Parser %t32, 1
  %t34 = load %Parser, %Parser* %l0
  %t35 = extractvalue %Parser %t34, 1
  %t36 = fcmp oeq double %t33, %t35
  %t37 = load %Parser, %Parser* %l0
  %t38 = load { double*, i64 }*, { double*, i64 }** %l1
  %t39 = load double, double* %l2
  %t40 = load double, double* %l3
  %t41 = load double, double* %l4
  %t42 = load double, double* %l5
  %t43 = load double, double* %l6
  %t44 = load %Parser, %Parser* %l7
  br i1 %t36, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t45 = load %Parser, %Parser* %l7
  store %Parser %t45, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t46 = load { double*, i64 }*, { double*, i64 }** %l1
  %t47 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t50 = load %Parser, %Parser* %l0
  %t51 = insertvalue %CaptureResult undef, i8* null, 0
  %t52 = load { double*, i64 }*, { double*, i64 }** %l1
  %t53 = insertvalue %CaptureResult %t51, { i8**, i64 }* null, 1
  ret %CaptureResult %t53
}

define %ParenthesizedParseResult @collect_parenthesized(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca { double*, i64 }*
  %l3 = alloca double
  %l4 = alloca double
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l1
  %t3 = load double, double* %l1
  %t4 = load %Parser, %Parser* %l0
  %t5 = call %Parser @parser_advance_raw(%Parser %t4)
  store %Parser %t5, %Parser* %l0
  %t6 = alloca [0 x double]
  %t7 = getelementptr [0 x double], [0 x double]* %t6, i32 0, i32 0
  %t8 = alloca { double*, i64 }
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 0
  store double* %t7, double** %t9
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
  store { double*, i64 }* %t8, { double*, i64 }** %l2
  %t11 = sitofp i64 1 to double
  store double %t11, double* %l3
  %t12 = load %Parser, %Parser* %l0
  %t13 = load double, double* %l1
  %t14 = load { double*, i64 }*, { double*, i64 }** %l2
  %t15 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t27 = phi { double*, i64 }* [ %t14, %entry ], [ %t25, %loop.latch2 ]
  %t28 = phi %Parser [ %t12, %entry ], [ %t26, %loop.latch2 ]
  store { double*, i64 }* %t27, { double*, i64 }** %l2
  store %Parser %t28, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t16 = load %Parser, %Parser* %l0
  %t17 = call double @parser_peek_raw(%Parser %t16)
  store double %t17, double* %l4
  %t18 = load double, double* %l4
  %t19 = load double, double* %l4
  %t20 = load { double*, i64 }*, { double*, i64 }** %l2
  %t21 = load double, double* %l4
  %t22 = call double @append_token(double 0.0, double %t21)
  store { double*, i64 }* null, { double*, i64 }** %l2
  %t23 = load %Parser, %Parser* %l0
  %t24 = call %Parser @parser_advance_raw(%Parser %t23)
  store %Parser %t24, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t25 = load { double*, i64 }*, { double*, i64 }** %l2
  %t26 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t29 = load %Parser, %Parser* %l0
  %t30 = insertvalue %ParenthesizedParseResult undef, i8* null, 0
  %t31 = load { double*, i64 }*, { double*, i64 }** %l2
  %t32 = insertvalue %ParenthesizedParseResult %t30, { i8**, i64 }* null, 1
  %t33 = insertvalue %ParenthesizedParseResult %t32, i1 1, 2
  ret %ParenthesizedParseResult %t33
}

define %PatternCaptureResult @collect_pattern_until_arrow(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca { double*, i64 }*
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
  store { double*, i64 }* %t3, { double*, i64 }** %l1
  %t6 = load %Parser, %Parser* %l0
  %t7 = load { double*, i64 }*, { double*, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t37 = phi { double*, i64 }* [ %t7, %entry ], [ %t35, %loop.latch2 ]
  %t38 = phi %Parser [ %t6, %entry ], [ %t36, %loop.latch2 ]
  store { double*, i64 }* %t37, { double*, i64 }** %l1
  store %Parser %t38, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t8 = load %Parser, %Parser* %l0
  %t9 = call double @parser_peek_raw(%Parser %t8)
  store double %t9, double* %l2
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  %t12 = load { double*, i64 }*, { double*, i64 }** %l1
  %t13 = load double, double* %l2
  %t14 = call double @append_token(double 0.0, double %t13)
  store { double*, i64 }* null, { double*, i64 }** %l1
  %t15 = load %Parser, %Parser* %l0
  %t16 = call %Parser @parser_advance_raw(%Parser %t15)
  store %Parser %t16, %Parser* %l3
  %t17 = load %Parser, %Parser* %l3
  %t18 = extractvalue %Parser %t17, 1
  %t19 = load %Parser, %Parser* %l0
  %t20 = extractvalue %Parser %t19, 1
  %t21 = fcmp oeq double %t18, %t20
  %t22 = load %Parser, %Parser* %l0
  %t23 = load { double*, i64 }*, { double*, i64 }** %l1
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
  %t35 = load { double*, i64 }*, { double*, i64 }** %l1
  %t36 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t39 = load %Parser, %Parser* %l0
  %t40 = insertvalue %PatternCaptureResult undef, i8* null, 0
  %t41 = load { double*, i64 }*, { double*, i64 }** %l1
  %t42 = insertvalue %PatternCaptureResult %t40, { i8**, i64 }* null, 1
  %t43 = insertvalue %PatternCaptureResult %t42, i1 1, 2
  ret %PatternCaptureResult %t43
}

define %MatchCaseTokenSplit @split_match_case_tokens(double %tokens) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %t0 = call double @trim_token_edges(double %tokens)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = load double, double* %l0
  %s3 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.3, i32 0, i32 0
  %t4 = call double @find_top_level_identifier(double %t2, i8* %s3)
  store double %t4, double* %l1
  %t5 = load double, double* %l1
  %t6 = sitofp i64 -1 to double
  %t7 = fcmp oeq double %t5, %t6
  %t8 = load double, double* %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then0, label %merge1
then0:
  %t10 = load double, double* %l0
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
  %t19 = load double, double* %l0
  %t20 = load double, double* %l1
  %t21 = sitofp i64 0 to double
  %t22 = call double @token_slice(double %t19, double %t21, double %t20)
  %t23 = call double @trim_token_edges(double %t22)
  store double %t23, double* %l2
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  %t28 = load double, double* %l0
  store double 0.0, double* %l3
  %t29 = load double, double* %l2
  %t30 = insertvalue %MatchCaseTokenSplit undef, { i8**, i64 }* null, 0
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
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  ret i1 1
}

define i1 @is_decimal_digit(i8* %ch) {
entry:
  ret i1 false
}

define double @find_top_level_colon(double %tokens) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
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
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l4
  %t11 = load double, double* %l4
  store double 0.0, double* %l5
  %t12 = load double, double* %l5
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t13 = sitofp i64 -1 to double
  ret double %t13
}

define %ExpressionCollectResult @expression_tokens_collect_until(%ExpressionTokens %state, { i8**, i64 }* %terminators) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca { double*, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { double*, i64 }* %t2, { double*, i64 }** %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l3
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l4
  %t8 = sitofp i64 0 to double
  store double %t8, double* %l5
  %t9 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t10 = load { double*, i64 }*, { double*, i64 }** %l1
  %t11 = load double, double* %l2
  %t12 = load double, double* %l3
  %t13 = load double, double* %l4
  %t14 = load double, double* %l5
  br label %loop.header0
loop.header0:
  %t39 = phi { double*, i64 }* [ %t10, %entry ], [ %t37, %loop.latch2 ]
  %t40 = phi %ExpressionTokens [ %t9, %entry ], [ %t38, %loop.latch2 ]
  store { double*, i64 }* %t39, { double*, i64 }** %l1
  store %ExpressionTokens %t40, %ExpressionTokens* %l0
  br label %loop.body1
loop.body1:
  %t15 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t16 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t15)
  %t17 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t18 = load { double*, i64 }*, { double*, i64 }** %l1
  %t19 = load double, double* %l2
  %t20 = load double, double* %l3
  %t21 = load double, double* %l4
  %t22 = load double, double* %l5
  br i1 %t16, label %then4, label %merge5
then4:
  %t23 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t24 = insertvalue %ExpressionCollectResult undef, i8* null, 0
  %t25 = load { double*, i64 }*, { double*, i64 }** %l1
  %t26 = insertvalue %ExpressionCollectResult %t24, { i8**, i64 }* null, 1
  %t27 = insertvalue %ExpressionCollectResult %t26, i1 0, 2
  ret %ExpressionCollectResult %t27
merge5:
  %t28 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t29 = call double @expression_tokens_peek(%ExpressionTokens %t28)
  store double %t29, double* %l6
  %t30 = load double, double* %l2
  store double 0.0, double* %l7
  %t31 = load double, double* %l6
  %t32 = load { double*, i64 }*, { double*, i64 }** %l1
  %t33 = load double, double* %l6
  %t34 = call double @append_token(double 0.0, double %t33)
  store { double*, i64 }* null, { double*, i64 }** %l1
  %t35 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t36 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t35)
  store %ExpressionTokens %t36, %ExpressionTokens* %l0
  br label %loop.latch2
loop.latch2:
  %t37 = load { double*, i64 }*, { double*, i64 }** %l1
  %t38 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header0
afterloop3:
  %t41 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t42 = insertvalue %ExpressionCollectResult undef, i8* null, 0
  %t43 = load { double*, i64 }*, { double*, i64 }** %l1
  %t44 = insertvalue %ExpressionCollectResult %t42, { i8**, i64 }* null, 1
  %t45 = insertvalue %ExpressionCollectResult %t44, i1 1, 2
  ret %ExpressionCollectResult %t45
}

define %ExpressionBlockParseResult @collect_expression_block(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca double
  %l2 = alloca { double*, i64 }*
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
  %t14 = load double, double* %l1
  %t15 = alloca [0 x double]
  %t16 = getelementptr [0 x double], [0 x double]* %t15, i32 0, i32 0
  %t17 = alloca { double*, i64 }
  %t18 = getelementptr { double*, i64 }, { double*, i64 }* %t17, i32 0, i32 0
  store double* %t16, double** %t18
  %t19 = getelementptr { double*, i64 }, { double*, i64 }* %t17, i32 0, i32 1
  store i64 0, i64* %t19
  store { double*, i64 }* %t17, { double*, i64 }** %l2
  %t20 = sitofp i64 0 to double
  store double %t20, double* %l3
  %t21 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t22 = load double, double* %l1
  %t23 = load { double*, i64 }*, { double*, i64 }** %l2
  %t24 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t46 = phi { double*, i64 }* [ %t23, %entry ], [ %t44, %loop.latch4 ]
  %t47 = phi %ExpressionTokens [ %t21, %entry ], [ %t45, %loop.latch4 ]
  store { double*, i64 }* %t46, { double*, i64 }** %l2
  store %ExpressionTokens %t47, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t25 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t26 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t25)
  %t27 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t28 = load double, double* %l1
  %t29 = load { double*, i64 }*, { double*, i64 }** %l2
  %t30 = load double, double* %l3
  br i1 %t26, label %then6, label %merge7
then6:
  %t31 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t32 = insertvalue %ExpressionBlockParseResult undef, i8* null, 0
  %t33 = load { double*, i64 }*, { double*, i64 }** %l2
  %t34 = insertvalue %ExpressionBlockParseResult %t32, { i8**, i64 }* null, 1
  %t35 = insertvalue %ExpressionBlockParseResult %t34, i1 0, 2
  ret %ExpressionBlockParseResult %t35
merge7:
  %t36 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t37 = call double @expression_tokens_peek(%ExpressionTokens %t36)
  store double %t37, double* %l4
  %t38 = load { double*, i64 }*, { double*, i64 }** %l2
  %t39 = load double, double* %l4
  %t40 = call double @append_token(double 0.0, double %t39)
  store { double*, i64 }* null, { double*, i64 }** %l2
  %t41 = load double, double* %l4
  %t42 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t43 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t42)
  store %ExpressionTokens %t43, %ExpressionTokens* %l0
  br label %loop.latch4
loop.latch4:
  %t44 = load { double*, i64 }*, { double*, i64 }** %l2
  %t45 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t48 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t49 = insertvalue %ExpressionBlockParseResult undef, i8* null, 0
  %t50 = load { double*, i64 }*, { double*, i64 }** %l2
  %t51 = insertvalue %ExpressionBlockParseResult %t49, { i8**, i64 }* null, 1
  %t52 = insertvalue %ExpressionBlockParseResult %t51, i1 1, 2
  ret %ExpressionBlockParseResult %t52
}

define %LambdaParameterParseResult @parse_lambda_parameter(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca double
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
  %t11 = load double, double* %l3
  %t12 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t13 = call double @expression_tokens_peek(%ExpressionTokens %t12)
  store double %t13, double* %l4
  %t14 = load double, double* %l4
  %t15 = load double, double* %l4
  %t16 = call i8* @identifier_text(double %t15)
  store i8* %t16, i8** %l5
  %t17 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t18 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t17)
  store %ExpressionTokens %t18, %ExpressionTokens* %l0
  store double 0.0, double* %l6
  %t19 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t20 = call double @expression_tokens_is_at_end(%ExpressionTokens %t19)
  %t21 = fcmp one double %t20, 0.0
  %t22 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t23 = load double, double* %l1
  %t24 = load i1, i1* %l2
  %t25 = load double, double* %l3
  %t26 = load double, double* %l4
  %t27 = load i8*, i8** %l5
  %t28 = load double, double* %l6
  br i1 %t21, label %then2, label %merge3
then2:
  %t29 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t30 = call double @expression_tokens_peek(%ExpressionTokens %t29)
  store double %t30, double* %l7
  %t31 = load double, double* %l7
  br label %merge3
merge3:
  store double 0.0, double* %l8
  %t32 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t33 = call double @expression_tokens_is_at_end(%ExpressionTokens %t32)
  %t34 = fcmp one double %t33, 0.0
  %t35 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t36 = load double, double* %l1
  %t37 = load i1, i1* %l2
  %t38 = load double, double* %l3
  %t39 = load double, double* %l4
  %t40 = load i8*, i8** %l5
  %t41 = load double, double* %l6
  %t42 = load double, double* %l8
  br i1 %t34, label %then4, label %merge5
then4:
  %t43 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t44 = call double @expression_tokens_peek(%ExpressionTokens %t43)
  store double %t44, double* %l9
  %t45 = load double, double* %l9
  br label %merge5
merge5:
  %t46 = extractvalue %ExpressionTokens %state, 0
  %t47 = load double, double* %l1
  %t48 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t49 = extractvalue %ExpressionTokens %t48, 1
  %t50 = call double @token_slice(double 0.0, double %t47, double %t49)
  store double %t50, double* %l10
  %t51 = load double, double* %l10
  %t52 = call double @source_span_from_tokens(double %t51)
  store double %t52, double* %l11
  store double 0.0, double* %l12
  %t53 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t54 = insertvalue %LambdaParameterParseResult undef, i8* null, 0
  %t55 = load double, double* %l12
  %t56 = insertvalue %LambdaParameterParseResult %t54, i8* null, 1
  %t57 = insertvalue %LambdaParameterParseResult %t56, i1 1, 2
  ret %LambdaParameterParseResult %t57
}

define %LambdaParameterListParseResult @parse_lambda_parameter_list(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca { double*, i64 }*
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
  store { double*, i64 }* %t2, { double*, i64 }** %l1
  %t5 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t6 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t5)
  %t7 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t8 = load { double*, i64 }*, { double*, i64 }** %l1
  br i1 %t6, label %then0, label %merge1
then0:
  %t9 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t10 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t11 = load { double*, i64 }*, { double*, i64 }** %l1
  %t12 = insertvalue %LambdaParameterListParseResult %t10, { i8**, i64 }* null, 1
  %t13 = insertvalue %LambdaParameterListParseResult %t12, i1 0, 2
  ret %LambdaParameterListParseResult %t13
merge1:
  %t14 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t15 = call double @expression_tokens_peek(%ExpressionTokens %t14)
  store double %t15, double* %l2
  %t16 = load double, double* %l2
  %t17 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t18 = load { double*, i64 }*, { double*, i64 }** %l1
  %t19 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t49 = phi { double*, i64 }* [ %t18, %entry ], [ %t47, %loop.latch4 ]
  %t50 = phi %ExpressionTokens [ %t17, %entry ], [ %t48, %loop.latch4 ]
  store { double*, i64 }* %t49, { double*, i64 }** %l1
  store %ExpressionTokens %t50, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t20 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t21 = call %LambdaParameterParseResult @parse_lambda_parameter(%ExpressionTokens %t20)
  store %LambdaParameterParseResult %t21, %LambdaParameterParseResult* %l3
  %t22 = load { double*, i64 }*, { double*, i64 }** %l1
  %t23 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  %t24 = extractvalue %LambdaParameterParseResult %t23, 1
  %t25 = call double @append_parameter(double 0.0, double 0.0)
  store { double*, i64 }* null, { double*, i64 }** %l1
  %t26 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  %t27 = extractvalue %LambdaParameterParseResult %t26, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t28 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t29 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t28)
  %t30 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t31 = load { double*, i64 }*, { double*, i64 }** %l1
  %t32 = load double, double* %l2
  %t33 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  br i1 %t29, label %then6, label %merge7
then6:
  %t34 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t35 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t36 = load { double*, i64 }*, { double*, i64 }** %l1
  %t37 = insertvalue %LambdaParameterListParseResult %t35, { i8**, i64 }* null, 1
  %t38 = insertvalue %LambdaParameterListParseResult %t37, i1 0, 2
  ret %LambdaParameterListParseResult %t38
merge7:
  %t39 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t40 = call double @expression_tokens_peek(%ExpressionTokens %t39)
  store double %t40, double* %l4
  %t41 = load double, double* %l4
  %t42 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t43 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t44 = load { double*, i64 }*, { double*, i64 }** %l1
  %t45 = insertvalue %LambdaParameterListParseResult %t43, { i8**, i64 }* null, 1
  %t46 = insertvalue %LambdaParameterListParseResult %t45, i1 0, 2
  ret %LambdaParameterListParseResult %t46
loop.latch4:
  %t47 = load { double*, i64 }*, { double*, i64 }** %l1
  %t48 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t51 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t52 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t53 = load { double*, i64 }*, { double*, i64 }** %l1
  %t54 = insertvalue %LambdaParameterListParseResult %t52, { i8**, i64 }* null, 1
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
  %l5 = alloca double
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
  %t6 = load double, double* %l1
  %t7 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t8 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t7)
  store %ExpressionTokens %t8, %ExpressionTokens* %l0
  %t9 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t10 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t9)
  %t11 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then2, label %merge3
then2:
  %t13 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t13
merge3:
  %t14 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t15 = call double @expression_tokens_peek(%ExpressionTokens %t14)
  store double %t15, double* %l2
  %t16 = load double, double* %l2
  %t17 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t18 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t17)
  store %ExpressionTokens %t18, %ExpressionTokens* %l0
  %t19 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t20 = call %LambdaParameterListParseResult @parse_lambda_parameter_list(%ExpressionTokens %t19)
  store %LambdaParameterListParseResult %t20, %LambdaParameterListParseResult* %l3
  %t21 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t22 = extractvalue %LambdaParameterListParseResult %t21, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t23 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t24 = extractvalue %LambdaParameterListParseResult %t23, 1
  store { i8**, i64 }* %t24, { i8**, i64 }** %l4
  store double 0.0, double* %l5
  %t25 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t26 = call double @expression_tokens_is_at_end(%ExpressionTokens %t25)
  %t27 = fcmp one double %t26, 0.0
  %t28 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t29 = load double, double* %l1
  %t30 = load double, double* %l2
  %t31 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t33 = load double, double* %l5
  br i1 %t27, label %then4, label %merge5
then4:
  %t34 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t35 = call double @expression_tokens_peek(%ExpressionTokens %t34)
  store double %t35, double* %l6
  %t36 = load double, double* %l6
  br label %merge5
merge5:
  %t37 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t38 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t37)
  %t39 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t40 = load double, double* %l1
  %t41 = load double, double* %l2
  %t42 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t44 = load double, double* %l5
  br i1 %t38, label %then6, label %merge7
then6:
  %t45 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t45
merge7:
  %t46 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t47 = call %ExpressionBlockParseResult @collect_expression_block(%ExpressionTokens %t46)
  store %ExpressionBlockParseResult %t47, %ExpressionBlockParseResult* %l7
  %t48 = load %ExpressionBlockParseResult, %ExpressionBlockParseResult* %l7
  %t49 = extractvalue %ExpressionBlockParseResult %t48, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t50 = load %ExpressionBlockParseResult, %ExpressionBlockParseResult* %l7
  %t51 = extractvalue %ExpressionBlockParseResult %t50, 1
  store { i8**, i64 }* %t51, { i8**, i64 }** %l8
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t53 = insertvalue %Parser undef, { i8**, i64 }* %t52, 0
  %t54 = sitofp i64 0 to double
  %t55 = insertvalue %Parser %t53, double %t54, 1
  store %Parser %t55, %Parser* %l9
  %t56 = load %Parser, %Parser* %l9
  %t57 = call %BlockParseResult @parse_block(%Parser %t56)
  store %BlockParseResult %t57, %BlockParseResult* %l10
  %t58 = load %BlockParseResult, %BlockParseResult* %l10
  %t59 = extractvalue %BlockParseResult %t58, 1
  store i8* %t59, i8** %l11
  %t60 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t61 = insertvalue %ExpressionParseResult undef, i8* null, 0
  %t62 = insertvalue %ExpressionParseResult %t61, i8* null, 1
  %t63 = insertvalue %ExpressionParseResult %t62, i1 1, 2
  ret %ExpressionParseResult %t63
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
  %t4 = load double, double* %l0
  %t5 = call %ExpressionParseResult @parse_primary_expression(%ExpressionTokens %state)
  store %ExpressionParseResult %t5, %ExpressionParseResult* %l1
  %t6 = load %ExpressionParseResult, %ExpressionParseResult* %l1
  %t7 = extractvalue %ExpressionParseResult %t6, 0
  %t8 = load %ExpressionParseResult, %ExpressionParseResult* %l1
  %t9 = extractvalue %ExpressionParseResult %t8, 1
  %t10 = call %ExpressionParseResult @parse_postfix_chain(%ExpressionTokens zeroinitializer, double 0.0)
  ret %ExpressionParseResult %t10
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
  %t7 = load double, double* %l0
  %t8 = load double, double* %l0
  %t9 = load double, double* %l0
  %t10 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t10
}

define %ExpressionParseResult @parse_postfix_chain(%ExpressionTokens %state, double %expression) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  store double %expression, double* %l1
  %t0 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t1 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t2 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t3 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t2)
  %t4 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t5 = load double, double* %l1
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
  %t20 = load double, double* %l1
  %t21 = insertvalue %ExpressionParseResult %t19, i8* null, 1
  %t22 = insertvalue %ExpressionParseResult %t21, i1 1, 2
  ret %ExpressionParseResult %t22
}

define %CallArgumentsParseResult @parse_call_arguments(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca { double*, i64 }*
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
  store { double*, i64 }* %t3, { double*, i64 }** %l1
  %t6 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t7 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t6)
  %t8 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t9 = load { double*, i64 }*, { double*, i64 }** %l1
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
  %t21 = load { double*, i64 }*, { double*, i64 }** %l1
  br label %loop.header2
loop.header2:
  %t58 = phi { double*, i64 }* [ %t21, %entry ], [ %t56, %loop.latch4 ]
  %t59 = phi %ExpressionTokens [ %t20, %entry ], [ %t57, %loop.latch4 ]
  store { double*, i64 }* %t58, { double*, i64 }** %l1
  store %ExpressionTokens %t59, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t22 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t23 = sitofp i64 0 to double
  %t24 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %t22, double %t23)
  store %ExpressionParseResult %t24, %ExpressionParseResult* %l2
  %t25 = load { double*, i64 }*, { double*, i64 }** %l1
  %t26 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t27 = extractvalue %ExpressionParseResult %t26, 1
  %t28 = call double @append_expression(double 0.0, double 0.0)
  store { double*, i64 }* null, { double*, i64 }** %l1
  %t29 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t30 = extractvalue %ExpressionParseResult %t29, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t31 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t32 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t31)
  %t33 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t34 = load { double*, i64 }*, { double*, i64 }** %l1
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
  %t46 = load double, double* %l3
  %t47 = load double, double* %l3
  %t48 = insertvalue %CallArgumentsParseResult undef, i8* null, 0
  %t49 = alloca [0 x double]
  %t50 = getelementptr [0 x double], [0 x double]* %t49, i32 0, i32 0
  %t51 = alloca { double*, i64 }
  %t52 = getelementptr { double*, i64 }, { double*, i64 }* %t51, i32 0, i32 0
  store double* %t50, double** %t52
  %t53 = getelementptr { double*, i64 }, { double*, i64 }* %t51, i32 0, i32 1
  store i64 0, i64* %t53
  %t54 = insertvalue %CallArgumentsParseResult %t48, { i8**, i64 }* null, 1
  %t55 = insertvalue %CallArgumentsParseResult %t54, i1 0, 2
  ret %CallArgumentsParseResult %t55
loop.latch4:
  %t56 = load { double*, i64 }*, { double*, i64 }** %l1
  %t57 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t60 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t61 = insertvalue %CallArgumentsParseResult undef, i8* null, 0
  %t62 = load { double*, i64 }*, { double*, i64 }** %l1
  %t63 = insertvalue %CallArgumentsParseResult %t61, { i8**, i64 }* null, 1
  %t64 = insertvalue %CallArgumentsParseResult %t63, i1 1, 2
  ret %CallArgumentsParseResult %t64
}

define %ArrayLiteralParseResult @parse_array_literal(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca { double*, i64 }*
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
  store { double*, i64 }* %t2, { double*, i64 }** %l1
  %t5 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t6 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t5)
  %t7 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t8 = load { double*, i64 }*, { double*, i64 }** %l1
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
  %t17 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t18 = call double @expression_tokens_peek(%ExpressionTokens %t17)
  %t19 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t20 = load { double*, i64 }*, { double*, i64 }** %l1
  br label %loop.header2
loop.header2:
  %t57 = phi { double*, i64 }* [ %t20, %entry ], [ %t55, %loop.latch4 ]
  %t58 = phi %ExpressionTokens [ %t19, %entry ], [ %t56, %loop.latch4 ]
  store { double*, i64 }* %t57, { double*, i64 }** %l1
  store %ExpressionTokens %t58, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t21 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t22 = sitofp i64 0 to double
  %t23 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %t21, double %t22)
  store %ExpressionParseResult %t23, %ExpressionParseResult* %l2
  %t24 = load { double*, i64 }*, { double*, i64 }** %l1
  %t25 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t26 = extractvalue %ExpressionParseResult %t25, 1
  %t27 = call double @append_expression(double 0.0, double 0.0)
  store { double*, i64 }* null, { double*, i64 }** %l1
  %t28 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t29 = extractvalue %ExpressionParseResult %t28, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t30 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t31 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t30)
  %t32 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t33 = load { double*, i64 }*, { double*, i64 }** %l1
  %t34 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  br i1 %t31, label %then6, label %merge7
then6:
  %t35 = insertvalue %ArrayLiteralParseResult undef, i8* null, 0
  %t36 = alloca [0 x double]
  %t37 = getelementptr [0 x double], [0 x double]* %t36, i32 0, i32 0
  %t38 = alloca { double*, i64 }
  %t39 = getelementptr { double*, i64 }, { double*, i64 }* %t38, i32 0, i32 0
  store double* %t37, double** %t39
  %t40 = getelementptr { double*, i64 }, { double*, i64 }* %t38, i32 0, i32 1
  store i64 0, i64* %t40
  %t41 = insertvalue %ArrayLiteralParseResult %t35, { i8**, i64 }* null, 1
  %t42 = insertvalue %ArrayLiteralParseResult %t41, i1 0, 2
  ret %ArrayLiteralParseResult %t42
merge7:
  %t43 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t44 = call double @expression_tokens_peek(%ExpressionTokens %t43)
  store double %t44, double* %l3
  %t45 = load double, double* %l3
  %t46 = load double, double* %l3
  %t47 = insertvalue %ArrayLiteralParseResult undef, i8* null, 0
  %t48 = alloca [0 x double]
  %t49 = getelementptr [0 x double], [0 x double]* %t48, i32 0, i32 0
  %t50 = alloca { double*, i64 }
  %t51 = getelementptr { double*, i64 }, { double*, i64 }* %t50, i32 0, i32 0
  store double* %t49, double** %t51
  %t52 = getelementptr { double*, i64 }, { double*, i64 }* %t50, i32 0, i32 1
  store i64 0, i64* %t52
  %t53 = insertvalue %ArrayLiteralParseResult %t47, { i8**, i64 }* null, 1
  %t54 = insertvalue %ArrayLiteralParseResult %t53, i1 0, 2
  ret %ArrayLiteralParseResult %t54
loop.latch4:
  %t55 = load { double*, i64 }*, { double*, i64 }** %l1
  %t56 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t59 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t60 = insertvalue %ArrayLiteralParseResult undef, i8* null, 0
  %t61 = load { double*, i64 }*, { double*, i64 }** %l1
  %t62 = insertvalue %ArrayLiteralParseResult %t60, { i8**, i64 }* null, 1
  %t63 = insertvalue %ArrayLiteralParseResult %t62, i1 1, 2
  ret %ArrayLiteralParseResult %t63
}

define %ObjectLiteralParseResult @parse_object_literal(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca { double*, i64 }*
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
  store { double*, i64 }* %t2, { double*, i64 }** %l1
  %t5 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t6 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t5)
  %t7 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t8 = load { double*, i64 }*, { double*, i64 }** %l1
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
  %t17 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t18 = call double @expression_tokens_peek(%ExpressionTokens %t17)
  %t19 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t20 = load { double*, i64 }*, { double*, i64 }** %l1
  br label %loop.header2
loop.header2:
  %t95 = phi %ExpressionTokens [ %t19, %entry ], [ %t93, %loop.latch4 ]
  %t96 = phi { double*, i64 }* [ %t20, %entry ], [ %t94, %loop.latch4 ]
  store %ExpressionTokens %t95, %ExpressionTokens* %l0
  store { double*, i64 }* %t96, { double*, i64 }** %l1
  br label %loop.body3
loop.body3:
  %t21 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t22 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t21)
  %t23 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t24 = load { double*, i64 }*, { double*, i64 }** %l1
  br i1 %t22, label %then6, label %merge7
then6:
  %t25 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t26 = alloca [0 x double]
  %t27 = getelementptr [0 x double], [0 x double]* %t26, i32 0, i32 0
  %t28 = alloca { double*, i64 }
  %t29 = getelementptr { double*, i64 }, { double*, i64 }* %t28, i32 0, i32 0
  store double* %t27, double** %t29
  %t30 = getelementptr { double*, i64 }, { double*, i64 }* %t28, i32 0, i32 1
  store i64 0, i64* %t30
  %t31 = insertvalue %ObjectLiteralParseResult %t25, { i8**, i64 }* null, 1
  %t32 = insertvalue %ObjectLiteralParseResult %t31, i1 0, 2
  ret %ObjectLiteralParseResult %t32
merge7:
  %t33 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t34 = call double @expression_tokens_peek(%ExpressionTokens %t33)
  store double %t34, double* %l2
  %t35 = load double, double* %l2
  %t36 = load double, double* %l2
  %t37 = call i8* @identifier_text(double %t36)
  store i8* %t37, i8** %l3
  %t38 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t39 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t38)
  store %ExpressionTokens %t39, %ExpressionTokens* %l0
  %t40 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t41 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t40)
  %t42 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t43 = load { double*, i64 }*, { double*, i64 }** %l1
  %t44 = load double, double* %l2
  %t45 = load i8*, i8** %l3
  br i1 %t41, label %then8, label %merge9
then8:
  %t46 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t47 = alloca [0 x double]
  %t48 = getelementptr [0 x double], [0 x double]* %t47, i32 0, i32 0
  %t49 = alloca { double*, i64 }
  %t50 = getelementptr { double*, i64 }, { double*, i64 }* %t49, i32 0, i32 0
  store double* %t48, double** %t50
  %t51 = getelementptr { double*, i64 }, { double*, i64 }* %t49, i32 0, i32 1
  store i64 0, i64* %t51
  %t52 = insertvalue %ObjectLiteralParseResult %t46, { i8**, i64 }* null, 1
  %t53 = insertvalue %ObjectLiteralParseResult %t52, i1 0, 2
  ret %ObjectLiteralParseResult %t53
merge9:
  %t54 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t55 = call double @expression_tokens_peek(%ExpressionTokens %t54)
  store double %t55, double* %l4
  %t56 = load double, double* %l4
  %t57 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t58 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t57)
  store %ExpressionTokens %t58, %ExpressionTokens* %l0
  %t59 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t60 = sitofp i64 0 to double
  %t61 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %t59, double %t60)
  store %ExpressionParseResult %t61, %ExpressionParseResult* %l5
  %t62 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  %t63 = extractvalue %ExpressionParseResult %t62, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t64 = load { double*, i64 }*, { double*, i64 }** %l1
  %t65 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t66 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t65)
  %t67 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t68 = load { double*, i64 }*, { double*, i64 }** %l1
  %t69 = load double, double* %l2
  %t70 = load i8*, i8** %l3
  %t71 = load double, double* %l4
  %t72 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  br i1 %t66, label %then10, label %merge11
then10:
  %t73 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t74 = alloca [0 x double]
  %t75 = getelementptr [0 x double], [0 x double]* %t74, i32 0, i32 0
  %t76 = alloca { double*, i64 }
  %t77 = getelementptr { double*, i64 }, { double*, i64 }* %t76, i32 0, i32 0
  store double* %t75, double** %t77
  %t78 = getelementptr { double*, i64 }, { double*, i64 }* %t76, i32 0, i32 1
  store i64 0, i64* %t78
  %t79 = insertvalue %ObjectLiteralParseResult %t73, { i8**, i64 }* null, 1
  %t80 = insertvalue %ObjectLiteralParseResult %t79, i1 0, 2
  ret %ObjectLiteralParseResult %t80
merge11:
  %t81 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t82 = call double @expression_tokens_peek(%ExpressionTokens %t81)
  store double %t82, double* %l6
  %t83 = load double, double* %l6
  %t84 = load double, double* %l6
  %t85 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t86 = alloca [0 x double]
  %t87 = getelementptr [0 x double], [0 x double]* %t86, i32 0, i32 0
  %t88 = alloca { double*, i64 }
  %t89 = getelementptr { double*, i64 }, { double*, i64 }* %t88, i32 0, i32 0
  store double* %t87, double** %t89
  %t90 = getelementptr { double*, i64 }, { double*, i64 }* %t88, i32 0, i32 1
  store i64 0, i64* %t90
  %t91 = insertvalue %ObjectLiteralParseResult %t85, { i8**, i64 }* null, 1
  %t92 = insertvalue %ObjectLiteralParseResult %t91, i1 0, 2
  ret %ObjectLiteralParseResult %t92
loop.latch4:
  %t93 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t94 = load { double*, i64 }*, { double*, i64 }** %l1
  br label %loop.header2
afterloop5:
  %t97 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t98 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t99 = load { double*, i64 }*, { double*, i64 }** %l1
  %t100 = insertvalue %ObjectLiteralParseResult %t98, { i8**, i64 }* null, 1
  %t101 = insertvalue %ObjectLiteralParseResult %t100, i1 1, 2
  ret %ObjectLiteralParseResult %t101
}

define %ExpressionParseResult @parse_struct_literal(%ExpressionTokens %state, double %target) {
entry:
  %l0 = alloca %StructTypeNameResult
  %l1 = alloca %ObjectLiteralParseResult
  %t0 = call %StructTypeNameResult @collect_struct_type_name(double %target)
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

define i1 @expression_is_struct_target(double %expression) {
entry:
  ret i1 0
}

define %StructTypeNameResult @collect_struct_type_name(double %expression) {
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
  %s1 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1, i32 0, i32 0
  %s2 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.2, i32 0, i32 0
  %t3 = sitofp i64 -1 to double
  ret double %t3
}

define double @unary_precedence() {
entry:
  %t0 = sitofp i64 7 to double
  ret double %t0
}

define i8* @tokens_to_text(double %tokens) {
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
  %t8 = phi i8* [ %t2, %entry ], [ %t7, %loop.latch2 ]
  store i8* %t8, i8** %l0
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load i8*, i8** %l0
  %t6 = load double, double* %l1
  br label %loop.latch2
loop.latch2:
  %t7 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t9 = load i8*, i8** %l0
  ret i8* %t9
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
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t16 = load double, double* %l0
  %t17 = load double, double* %l1
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t18 = load double, double* %l1
  %t19 = load double, double* %l0
  %t20 = fcmp ole double %t18, %t19
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  br i1 %t20, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store double 0.0, double* %l3
  %t23 = load double, double* %l3
  %t24 = call i1 @is_trim_whitespace(i8* null)
  %t25 = load double, double* %l0
  %t26 = load double, double* %l1
  %t27 = load double, double* %l3
  br i1 %t24, label %then14, label %merge15
then14:
  %t28 = load double, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  br label %loop.header8
afterloop11:
  %t29 = load double, double* %l0
  %t30 = load double, double* %l1
  %t31 = call double @substring(i8* %value, double %t29, double %t30)
  ret i8* null
}

define i1 @is_trim_whitespace(i8* %ch) {
entry:
  %l0 = alloca double
  %t0 = call double @char_code(i8* %ch)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  ret i1 false
}

define i1 @string_array_contains({ i8**, i64 }* %values, i8* %target) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
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
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  ret i1 0
}

define i1 @is_trivia_token(double %token) {
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
  br label %loop.latch2
loop.latch2:
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
  %t20 = phi %Parser [ %t0, %entry ], [ %t19, %loop.latch2 ]
  store %Parser %t20, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Parser @skip_trivia(%Parser %t1)
  store %Parser %t2, %Parser* %l0
  %t3 = load %Parser, %Parser* %l0
  %t4 = call double @parser_peek_raw(%Parser %t3)
  store double %t4, double* %l1
  %t5 = load double, double* %l1
  %t6 = load double, double* %l1
  %t7 = load %Parser, %Parser* %l0
  %t8 = call %Parser @parser_advance_raw(%Parser %t7)
  store %Parser %t8, %Parser* %l2
  %t9 = load %Parser, %Parser* %l2
  %t10 = extractvalue %Parser %t9, 1
  %t11 = load %Parser, %Parser* %l0
  %t12 = extractvalue %Parser %t11, 1
  %t13 = fcmp oeq double %t10, %t12
  %t14 = load %Parser, %Parser* %l0
  %t15 = load double, double* %l1
  %t16 = load %Parser, %Parser* %l2
  br i1 %t13, label %then4, label %merge5
then4:
  %t17 = load %Parser, %Parser* %l0
  ret %Parser %t17
merge5:
  %t18 = load %Parser, %Parser* %l2
  store %Parser %t18, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t19 = load %Parser, %Parser* %l0
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
  %t3 = load double, double* %l0
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

define { i8**, i64 }* @split_tokens_by_comma(double %tokens) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
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
  %t24 = phi i8* [ %t12, %entry ], [ %t23, %loop.latch2 ]
  store i8* %t24, i8** %l1
  br label %loop.body1
loop.body1:
  %t18 = load double, double* %l6
  %t19 = load double, double* %l6
  store double 0.0, double* %l7
  %t20 = load double, double* %l7
  %t21 = load i8*, i8** %l1
  %t22 = load double, double* %l7
  br label %loop.latch2
loop.latch2:
  %t23 = load i8*, i8** %l1
  br label %loop.header0
afterloop3:
  %t25 = load i8*, i8** %l1
  %t26 = call i8* @trim_text(i8* %t25)
  store i8* %t26, i8** %l8
  %t27 = load i8*, i8** %l8
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t28
}

define double @find_top_level_symbol(double %tokens, i8* %symbol) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
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
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l4
  %t11 = load double, double* %l4
  store double 0.0, double* %l5
  %t12 = load double, double* %l5
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t13 = sitofp i64 -1 to double
  ret double %t13
}

define double @find_top_level_identifier(double %tokens, i8* %keyword) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
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
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l4
  %t11 = load double, double* %l4
  store double 0.0, double* %l5
  %t12 = load double, double* %l5
  %t13 = load double, double* %l5
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t14 = sitofp i64 -1 to double
  ret double %t14
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


define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
