import asyncio
from runtime import runtime_support as runtime

from compiler.build.ast import Block, Decorator, EnumVariant, Expression, FieldDeclaration, ForClause, FunctionSignature, MatchCase, MethodDeclaration, ModelProperty, Parameter, Program, Statement, ImportSpecifier, ExportSpecifier, TypeAnnotation, TypeParameter, WithClause, ElseBranch
from compiler.build.string_utils import substring

print = runtime.console
sleep = runtime.sleep
channel = runtime.channel
parallel = runtime.parallel
spawn = runtime.spawn
fs = runtime.fs
serve = runtime.serve
http = runtime.http
websocket = runtime.websocket
logExecution = runtime.logExecution
array_map = runtime.array_map
array_filter = runtime.array_filter
array_reduce = runtime.array_reduce
globals()['t' + 'rue'] = True
globals()['f' + 'alse'] = False

class NativeArtifact:
    def __init__(self, name, format, contents):
        self.name = name
        self.format = format
        self.contents = contents

class NativeModule:
    def __init__(self, artifacts, entry_points, symbol_count):
        self.artifacts = artifacts
        self.entry_points = entry_points
        self.symbol_count = symbol_count

class EmitNativeResult:
    def __init__(self, module, diagnostics):
        self.module = module
        self.diagnostics = diagnostics

class TextBuilder:
    def __init__(self, lines, indent):
        self.lines = lines
        self.indent = indent

class NativeState:
    def __init__(self, builder, diagnostics):
        self.builder = builder
        self.diagnostics = diagnostics

def emit_native(program):
    state = state_new()
    state = state_emit_line(state, "; Sailfin Native Prototype")
    state = state_emit_line(state, ".module main")
    if len(program.statements) > 0:
        state = state_emit_blank(state)
    index = 0
    while True:
        if index >= len(program.statements):
            break
        state = emit_statement(state, program.statements[index])
        if index + 1 < len(program.statements):
            state = state_emit_blank(state)
        index += 1
    artifact = NativeArtifact(name="module.sfn-asm", format="sailfin-native-text", contents=builder_to_string(state.builder))
    module = NativeModule(artifacts=[artifact], entry_points=collect_entry_points(program), symbol_count=count_exported_symbols(program))
    return EmitNativeResult(module=module, diagnostics=state.diagnostics)

def emit_statement(state, statement):
    if statement.variant == "ImportDeclaration":
        line = ".import \"" + statement.source + "\""
        rendered = render_native_specifiers(statement.specifiers)
        if len(rendered) > 0:
            line = line + " { " + rendered + " }"
        return state_emit_line(state, line)
    if statement.variant == "ExportDeclaration":
        line = ".export \"" + statement.source + "\""
        rendered = render_export_specifiers(statement.specifiers)
        if len(rendered) > 0:
            line = line + " { " + rendered + " }"
        return state_emit_line(state, line)
    if statement.variant == "VariableDeclaration":
        return emit_variable(state, statement)
    if statement.variant == "FunctionDeclaration":
        return emit_function(state, statement.signature, statement.body, statement.decorators)
    if statement.variant == "StructDeclaration":
        return emit_struct(state, statement)
    if statement.variant == "PipelineDeclaration":
        return emit_pipeline(state, statement)
    if statement.variant == "ToolDeclaration":
        return emit_tool(state, statement)
    if statement.variant == "TestDeclaration":
        return emit_test(state, statement)
    if statement.variant == "ModelDeclaration":
        return emit_model(state, statement)
    if statement.variant == "TypeAliasDeclaration":
        return emit_type_alias(state, statement)
    if statement.variant == "InterfaceDeclaration":
        return emit_interface(state, statement)
    if statement.variant == "EnumDeclaration":
        return emit_enum(state, statement)
    if statement.variant == "PromptStatement":
        return emit_prompt(state, statement)
    if statement.variant == "WithStatement":
        return emit_with(state, statement)
    if statement.variant == "ForStatement":
        return emit_for(state, statement)
    if statement.variant == "MatchStatement":
        return emit_match(state, statement)
    if statement.variant == "LoopStatement":
        return emit_loop(state, statement)
    if statement.variant == "BreakStatement":
        return state_emit_line(state, "break")
    if statement.variant == "ContinueStatement":
        return state_emit_line(state, "continue")
    if statement.variant == "IfStatement":
        return emit_if(state, statement)
    if statement.variant == "ReturnStatement":
        return emit_return(state, statement.expression)
    if statement.variant == "ExpressionStatement":
        return emit_expression_statement(state, statement.expression)
    message = "native backend: unsupported statement `" + statement.variant + "`"
    return state_add_diagnostic(state, message)

def render_native_specifiers(specifiers):
    parts = []
    index = 0
    while True:
        if index >= len(specifiers):
            break
        parts = append_string(parts, format_native_specifier(specifiers[index].name, specifiers[index].alias))
        index += 1
    return join_with_separator(parts, ", ")

def render_export_specifiers(specifiers):
    parts = []
    index = 0
    while True:
        if index >= len(specifiers):
            break
        parts = append_string(parts, format_native_specifier(specifiers[index].name, specifiers[index].alias))
        index += 1
    return join_with_separator(parts, ", ")

def format_native_specifier(name, alias):
    if alias == null  or  len(alias) == 0:
        return name
    return name + " as " + alias

def emit_variable(state, statement):
    line = ".let "
    if statement.mutable:
        line = line + "mut "
    line = line + statement.name
    if statement.type_annotation != null:
        line = line + " : " + statement.type_annotation.text
    if statement.initializer != null:
        line = line + " = " + format_expression(statement.initializer)
    return state_emit_line(state, line)

def emit_function(state, signature, body, decorators):
    current = emit_decorators(state, decorators)
    current = state_emit_line(current, ".fn " + format_function_signature(signature))
    current = emit_signature_metadata(current, signature)
    current = state_push_indent(current)
    current = emit_parameter_metadata(current, signature.parameters)
    current = emit_block(current, body)
    current = state_pop_indent(current)
    return state_emit_line(current, ".endfn")

def emit_pipeline(state, statement):
    current = emit_decorators(state, statement.decorators)
    current = state_emit_line(current, ".pipeline " + format_function_signature(statement.signature))
    current = emit_signature_metadata(current, statement.signature)
    current = state_push_indent(current)
    current = emit_parameter_metadata(current, statement.signature.parameters)
    current = emit_block(current, statement.body)
    current = state_pop_indent(current)
    return state_emit_line(current, ".endpipeline")

def emit_tool(state, statement):
    current = emit_decorators(state, statement.decorators)
    current = state_emit_line(current, ".tool " + format_function_signature(statement.signature))
    current = emit_signature_metadata(current, statement.signature)
    current = state_push_indent(current)
    current = emit_parameter_metadata(current, statement.signature.parameters)
    current = emit_block(current, statement.body)
    current = state_pop_indent(current)
    return state_emit_line(current, ".endtool")

def emit_test(state, statement):
    current = emit_decorators(state, statement.decorators)
    header = ".test " + quote_string(statement.name)
    if len(statement.effects) > 0:
        header = header + " ![" + join_with_separator(statement.effects, ", ") + "]"
    current = state_emit_line(current, header)
    current = emit_signature_metadata( current, FunctionSignature(name=statement.name, is_async=false, parameters=[], return_type=null, effects=statement.effects, type_parameters=[]) )
    current = state_push_indent(current)
    current = emit_block(current, statement.body)
    current = state_pop_indent(current)
    return state_emit_line(current, ".endtest")

def emit_model(state, statement):
    current = emit_decorators(state, statement.decorators)
    header = ".model " + statement.name + " : " + statement.model_type.text
    if len(statement.effects) > 0:
        header = header + " ![" + join_with_separator(statement.effects, ", ") + "]"
    current = state_emit_line(current, header)
    current = state_push_indent(current)
    index = 0
    while True:
        if index >= len(statement.properties):
            break
        property = statement.properties[index]
        line = ".property " + property.name + " = " + format_expression(property.value)
        current = state_emit_line(current, line)
        index += 1
    if len(statement.properties) == 0:
        current = state_emit_line(current, "noop")
    current = state_pop_indent(current)
    return state_emit_line(current, ".endmodel")

def emit_type_alias(state, statement):
    line = ".type " + statement.name
    line = line + format_type_parameters(statement.type_parameters)
    line = line + " = " + statement.aliased_type.text
    if len(statement.decorators) > 0:
        current = emit_decorators(state, statement.decorators)
        return state_emit_line(current, line)
    return state_emit_line(state, line)

def emit_interface(state, statement):
    current = emit_decorators(state, statement.decorators)
    header = ".interface " + statement.name
    header = header + format_type_parameters(statement.type_parameters)
    current = state_emit_line(current, header)
    current = state_push_indent(current)
    index = 0
    while True:
        if index >= len(statement.members):
            break
        signature = statement.members[index]
        current = state_emit_line(current, ".sig " + format_function_signature(signature))
        index += 1
    if len(statement.members) == 0:
        current = state_emit_line(current, "noop")
    current = state_pop_indent(current)
    return state_emit_line(current, ".endinterface")

def emit_enum(state, statement):
    current = emit_decorators(state, statement.decorators)
    header = ".enum " + statement.name
    header = header + format_type_parameters(statement.type_parameters)
    current = state_emit_line(current, header)
    current = state_push_indent(current)
    index = 0
    while True:
        if index >= len(statement.variants):
            break
        current = state_emit_line(current, ".variant " + format_enum_variant(statement.variants[index]))
        index += 1
    if len(statement.variants) == 0:
        current = state_emit_line(current, "noop")
    current = state_pop_indent(current)
    return state_emit_line(current, ".endenum")

def emit_struct(state, statement):
    current = emit_decorators(state, statement.decorators)
    header = ".struct " + statement.name
    header = header + format_type_parameters(statement.type_parameters)
    if len(statement.implements_types) > 0:
        header = header + " implements " + join_type_annotations(statement.implements_types)
    current = state_emit_line(current, header)
    current = state_push_indent(current)
    index = 0
    while True:
        if index >= len(statement.fields):
            break
        current = state_emit_line(current, ".field " + format_field(statement.fields[index]))
        index += 1
    method_index = 0
    while True:
        if method_index >= len(statement.methods):
            break
        current = emit_method(current, statement.methods[method_index])
        method_index += 1
    if len(statement.fields) == 0  and  len(statement.methods) == 0:
        current = state_emit_line(current, "noop")
    current = state_pop_indent(current)
    return state_emit_line(current, ".endstruct")

def emit_method(state, method):
    current = emit_decorators(state, method.decorators)
    current = state_emit_line(current, ".method " + format_function_signature(method.signature))
    current = emit_signature_metadata(current, method.signature)
    current = state_push_indent(current)
    current = emit_parameter_metadata(current, method.signature.parameters)
    current = emit_block(current, method.body)
    current = state_pop_indent(current)
    return state_emit_line(current, ".endmethod")

def emit_prompt(state, statement):
    current = emit_decorators(state, statement.decorators)
    current = state_emit_line(current, ".prompt " + statement.channel)
    current = state_push_indent(current)
    current = emit_block(current, statement.body)
    current = state_pop_indent(current)
    return state_emit_line(current, ".endprompt")

def emit_with(state, statement):
    current = emit_decorators(state, statement.decorators)
    line = ".with "
    index = 0
    while True:
        if index >= len(statement.clauses):
            break
        if index > 0:
            line = line + ", "
        line = line + format_expression(statement.clauses[index].expression)
        index += 1
    current = state_emit_line(current, line)
    current = state_push_indent(current)
    current = emit_block(current, statement.body)
    current = state_pop_indent(current)
    return state_emit_line(current, ".endwith")

def emit_for(state, statement):
    current = emit_decorators(state, statement.decorators)
    line = ".for " + format_expression(statement.clause.target) + " in " + format_expression(statement.clause.iterable)
    current = state_emit_line(current, line)
    current = state_push_indent(current)
    current = emit_block(current, statement.body)
    current = state_pop_indent(current)
    return state_emit_line(current, ".endfor")

def emit_loop(state, statement):
    current = emit_decorators(state, statement.decorators)
    current = state_emit_line(current, ".loop")
    current = state_push_indent(current)
    current = emit_block(current, statement.body)
    current = state_pop_indent(current)
    return state_emit_line(current, ".endloop")

def emit_match(state, statement):
    current = emit_decorators(state, statement.decorators)
    current = state_emit_line(current, ".match " + format_expression(statement.expression))
    current = state_push_indent(current)
    index = 0
    while True:
        if index >= len(statement.cases):
            break
        current = emit_match_case(current, statement.cases[index])
        index += 1
    if len(statement.cases) == 0:
        current = state_emit_line(current, "noop")
    current = state_pop_indent(current)
    return state_emit_line(current, ".endmatch")

def emit_match_case(state, case):
    inline_statement = select_inline_match_case_statement(case.body)
    if inline_statement != null:
        return emit_inline_match_case(state, case, inline_statement)
    line = ".case " + format_match_case_head(case)
    current = state_emit_line(state, line)
    current = state_push_indent(current)
    current = emit_block(current, case.body)
    current = state_pop_indent(current)
    return current

def select_inline_match_case_statement(block):
    if len(block.statements) != 1:
        return null
    statement = block.statements[0]
    if statement.variant == "ExpressionStatement":
        return statement
    if statement.variant == "ReturnStatement":
        return statement
    return null

def emit_inline_match_case(state, case, statement):
    line = format_match_case_head(case) + " => " + format_inline_case_body(statement)
    return state_emit_line(state, line + ",")

def format_match_case_head(case):
    head = format_expression(case.pattern)
    if case.guard != null:
        head = head + " if " + format_expression(case.guard)
    return head

def format_inline_case_body(statement):
    if statement.variant == "ExpressionStatement":
        return format_expression(statement.expression)
    if statement.variant == "ReturnStatement":
        if statement.expression == null:
            return "return"
        return "return " + format_expression(statement.expression)
    return ""

def emit_if(state, statement):
    current = emit_decorators(state, statement.decorators)
    current = state_emit_line(current, ".if " + format_expression(statement.condition))
    current = state_push_indent(current)
    current = emit_block(current, statement.then_block)
    current = state_pop_indent(current)
    if statement.else_branch != null:
        current = emit_else_branch(current, statement.else_branch)
    return state_emit_line(current, ".endif")

def emit_else_branch(state, branch):
    current = state_emit_line(state, ".else")
    current = state_push_indent(current)
    if branch.body != null:
        current = emit_block(current, branch.body)
    else:
        if branch.statement != null:
            current = emit_statement(current, branch.statement)
        else:
            current = state_emit_line(current, "noop")
    current = state_pop_indent(current)
    return current

def emit_return(state, expression):
    if expression == null:
        return state_emit_line(state, "ret")
    return state_emit_line(state, "ret " + format_expression(expression))

def emit_expression_statement(state, expression):
    return state_emit_line(state, "eval " + format_expression(expression))

def emit_block(state, block):
    if len(block.statements) == 0:
        return state_emit_line(state, "noop")
    current = state
    index = 0
    while True:
        if index >= len(block.statements):
            break
        current = emit_statement(current, block.statements[index])
        index += 1
    return current

def emit_decorators(state, decorators):
    current = state
    index = 0
    while True:
        if index >= len(decorators):
            break
        current = state_emit_line(current, ".decorator " + format_decorator(decorators[index]))
        index += 1
    return current

def emit_signature_metadata(state, signature):
    current = state
    if signature.return_type != null:
        current = state_emit_line(current, ".meta return " + signature.return_type.text)
    else:
        current = state_emit_line(current, ".meta return void")
    if len(signature.effects) > 0:
        current = state_emit_line(current, ".meta effects " + join_with_separator(signature.effects, ", "))
    else:
        current = state_emit_line(current, ".meta effects none")
    if len(signature.type_parameters) > 0:
        current = state_emit_line(current, ".meta generics " + format_type_parameters(signature.type_parameters))
    return current

def emit_parameter_metadata(state, parameters):
    current = state
    index = 0
    while True:
        if index >= len(parameters):
            break
        parameter = parameters[index]
        line = ".param "
        if parameter.mutable:
            line = line + "mut "
        line = line + parameter.name
        if parameter.type_annotation != null:
            line = line + " -> " + parameter.type_annotation.text
        if parameter.default_value != null:
            line = line + " = " + format_expression(parameter.default_value)
        current = state_emit_line(current, line)
        index += 1
    return current

def format_decorator(decorator):
    line = "@" + decorator.name
    if len(decorator.arguments) == 0:
        return line
    parts = []
    index = 0
    while True:
        if index >= len(decorator.arguments):
            break
        argument = decorator.arguments[index]
        value = format_expression(argument.expression)
        if argument.name != null:
            parts = append_string(parts, argument.name + "=" + value)
        else:
            parts = append_string(parts, value)
        index += 1
    return line + "(" + join_with_separator(parts, ", ") + ")"

def format_function_signature(signature):
    prefix = ""
    if signature.is_async:
        prefix = "async "
    line = prefix + signature.name
    line = line + format_type_parameters(signature.type_parameters)
    line = line + "(" + format_parameters(signature.parameters) + ")"
    if signature.return_type != null:
        line = line + " -> " + signature.return_type.text
    if len(signature.effects) > 0:
        line = line + " ![" + join_with_separator(signature.effects, ", ") + "]"
    return line

def format_parameters(parameters):
    if len(parameters) == 0:
        return ""
    parts = []
    index = 0
    while True:
        if index >= len(parameters):
            break
        parameter = parameters[index]
        entry = ""
        if parameter.mutable:
            entry = "mut " + parameter.name
        else:
            entry = parameter.name
        if parameter.type_annotation != null:
            entry = entry + " -> " + parameter.type_annotation.text
        if parameter.default_value != null:
            entry = entry + " = " + format_expression(parameter.default_value)
        parts = append_string(parts, entry)
        index += 1
    return join_with_separator(parts, ", ")

def format_type_parameters(parameters):
    if len(parameters) == 0:
        return ""
    parts = []
    index = 0
    while True:
        if index >= len(parameters):
            break
        parameter = parameters[index]
        entry = parameter.name
        if parameter.bound != null:
            entry = entry + " : " + parameter.bound.text
        parts = append_string(parts, entry)
        index += 1
    return "<" + join_with_separator(parts, ", ") + ">"

def format_field(field):
    line = ""
    if field.mutable:
        line = line + "mut "
    line = line + field.name + " -> " + field.type_annotation.text
    return line

def format_enum_variant(variant):
    if len(variant.fields) == 0:
        return variant.name
    parts = []
    index = 0
    while True:
        if index >= len(variant.fields):
            break
        parts = append_string(parts, format_field(variant.fields[index]))
        index += 1
    return variant.name + " { " + join_with_separator(parts, "; ") + " }"

def format_expression(expression):
    if expression.variant == "Identifier":
        return expression.name
    if expression.variant == "NumberLiteral":
        return expression.value
    if expression.variant == "BooleanLiteral":
        if expression.value:
            return "true"
        return "false"
    if expression.variant == "NullLiteral":
        return "null"
    if expression.variant == "StringLiteral":
        return quote_string(expression.value)
    if expression.variant == "Unary":
        return expression.operator + format_expression(expression.operand)
    if expression.variant == "Binary":
        left = format_expression(expression.left)
        right = format_expression(expression.right)
        return left + " " + expression.operator + " " + right
    if expression.variant == "Member":
        return format_expression(expression.object) + "." + expression.member
    if expression.variant == "Call":
        rendered = []
        index = 0
        while True:
            if index >= len(expression.arguments):
                break
            rendered = append_string(rendered, format_expression(expression.arguments[index]))
            index += 1
        args = join_with_separator(rendered, ", ")
        return format_expression(expression.callee) + "(" + args + ")"
    if expression.variant == "Index":
        return format_expression(expression.sequence) + "[" + format_expression(expression.index) + "]"
    if expression.variant == "Array":
        rendered = []
        index = 0
        while True:
            if index >= len(expression.elements):
                break
            rendered = append_string(rendered, format_expression(expression.elements[index]))
            index += 1
        return "[" + join_with_separator(rendered, ", ") + "]"
    if expression.variant == "Object":
        rendered = []
        index = 0
        while True:
            if index >= len(expression.fields):
                break
            field = expression.fields[index]
            rendered = append_string(rendered, field.name + ": " + format_expression(field.value))
            index += 1
        return "{ " + join_with_separator(rendered, ", ") + " }"
    if expression.variant == "Struct":
        rendered = []
        index = 0
        while True:
            if index >= len(expression.fields):
                break
            field = expression.fields[index]
            rendered = append_string(rendered, field.name + ": " + format_expression(field.value))
            index += 1
        type_name = join_with_separator(expression.type_name, ".")
        return type_name + " { " + join_with_separator(rendered, ", ") + " }"
    if expression.variant == "Range":
        return format_expression(expression.start) + ".." + format_expression(expression.end)
    if expression.variant == "Lambda":
        return "<lambda>"
    if expression.variant == "Raw":
        return trim_text(expression.text)
    return "<" + expression.variant + ">"

def quote_string(value):
    result = "\""
    index = 0
    while True:
        if index >= len(value):
            break
        result = result + escape_string_char(value[index])
        index += 1
    result = result + "\""
    return result

def escape_string_char(ch):
    if ch == "\"":
        return "\\\""
    if ch == "\\":
        return "\\\\"
    if ch == "\n":
        return "\\n"
    if ch == "\r":
        return "\\r"
    if ch == "\t":
        return "\\t"
    return ch

def trim_text(value):
    start = 0
    end = len(value)
    while True:
        if start >= end:
            break
        ch = value[start]
        if is_trim_char(ch):
            start += 1
            continue
        break
    while True:
        if end <= start:
            break
        ch = value[end - 1]
        if is_trim_char(ch):
            end -= 1
            continue
        break
    if start == 0  and  end == len(value):
        return value
    return substring(value, start, end)

def is_trim_char(ch):
    return ch == " "  or  ch == "\n"  or  ch == "\r"  or  ch == "\t"

def collect_entry_points(program):
    entries = []
    index = 0
    while True:
        if index >= len(program.statements):
            break
        statement = program.statements[index]
        if statement.variant == "FunctionDeclaration":
            entries = append_unique(entries, statement.signature.name)
        if statement.variant == "TestDeclaration":
            entries = append_unique(entries, "test:" + statement.name)
        index += 1
    return entries

def count_exported_symbols(program):
    count = 0
    index = 0
    while True:
        if index >= len(program.statements):
            break
        stmt = program.statements[index]
        if stmt.variant == "FunctionDeclaration"  or  stmt.variant == "StructDeclaration"  or  stmt.variant == "EnumDeclaration"  or  stmt.variant == "PipelineDeclaration"  or  stmt.variant == "ToolDeclaration"  or  stmt.variant == "ModelDeclaration"  or  stmt.variant == "TestDeclaration"  or  stmt.variant == "TypeAliasDeclaration"  or  stmt.variant == "InterfaceDeclaration":
            count += 1
        index += 1
    return count

def append_unique(values, value):
    if contains_string(values, value):
        return values
    return append_string(values, value)

def contains_string(values, target):
    index = 0
    while True:
        if index >= len(values):
            break
        if values[index] == target:
            return true
        index += 1
    return false

def state_new():
    return NativeState(builder=builder_new(), diagnostics=[])

def state_emit_line(state, line):
    return NativeState(builder=builder_emit_line(state.builder, line), diagnostics=state.diagnostics)

def state_emit_blank(state):
    return NativeState(builder=builder_emit_blank(state.builder), diagnostics=state.diagnostics)

def state_push_indent(state):
    return NativeState(builder=builder_push_indent(state.builder), diagnostics=state.diagnostics)

def state_pop_indent(state):
    return NativeState(builder=builder_pop_indent(state.builder), diagnostics=state.diagnostics)

def state_add_diagnostic(state, message):
    diagnostics = append_string(state.diagnostics, message)
    return NativeState(builder=builder_emit_line(state.builder, "; " + message), diagnostics=diagnostics)

def builder_new():
    return TextBuilder(lines=[], indent=0)

def builder_emit_line(builder, line):
    prefix = ""
    count = 0
    while True:
        if count >= builder.indent:
            break
        prefix = prefix + "    "
        count += 1
    full_line = prefix + trim_right(line)
    lines = append_string(builder.lines, full_line)
    return TextBuilder(lines=lines, indent=builder.indent)

def builder_emit_blank(builder):
    lines = append_string(builder.lines, "")
    return TextBuilder(lines=lines, indent=builder.indent)

def builder_push_indent(builder):
    return TextBuilder(lines=builder.lines, indent=builder.indent + 1)

def builder_pop_indent(builder):
    indent = builder.indent
    if indent > 0:
        indent -= 1
    return TextBuilder(lines=builder.lines, indent=indent)

def builder_to_string(builder):
    content = join_with_separator(builder.lines, "\n")
    if len(content) == 0:
        return ""
    return content + "\n"

def trim_right(value):
    end = len(value)
    while True:
        if end <= 0:
            break
        ch = value[end - 1]
        if ch == " "  or  ch == "\t":
            end -= 1
            continue
        break
    if end == len(value):
        return value
    return substring(value, 0, end)

def append_string(values, value):
    return (values) + ([value])

def join_with_separator(values, separator):
    if len(values) == 0:
        return ""
    result = values[0]
    index = 1
    while True:
        if index >= len(values):
            break
        result = result + separator + values[index]
        index += 1
    return result

def join_type_annotations(values):
    if len(values) == 0:
        return ""
    parts = []
    index = 0
    while True:
        if index >= len(values):
            break
        parts = append_string(parts, values[index].text)
        index += 1
    return join_with_separator(parts, ", ")
