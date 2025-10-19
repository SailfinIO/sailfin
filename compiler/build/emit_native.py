import asyncio
from runtime import runtime_support as runtime

from compiler.build.ast import Block, Decorator, EnumVariant, Expression, FieldDeclaration, ForClause, FunctionSignature, MatchCase, MethodDeclaration, ModelProperty, Parameter, Program, Statement, ImportSpecifier, ExportSpecifier, TypeAnnotation, TypeParameter, WithClause, ElseBranch, SourceSpan
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

    def __repr__(self):
        return runtime.struct_repr('NativeArtifact', [runtime.struct_field('name', self.name), runtime.struct_field('format', self.format), runtime.struct_field('contents', self.contents)])

class NativeModule:
    def __init__(self, artifacts, entry_points, symbol_count):
        self.artifacts = artifacts
        self.entry_points = entry_points
        self.symbol_count = symbol_count

    def __repr__(self):
        return runtime.struct_repr('NativeModule', [runtime.struct_field('artifacts', self.artifacts), runtime.struct_field('entry_points', self.entry_points), runtime.struct_field('symbol_count', self.symbol_count)])

class EmitNativeResult:
    def __init__(self, module, diagnostics):
        self.module = module
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('EmitNativeResult', [runtime.struct_field('module', self.module), runtime.struct_field('diagnostics', self.diagnostics)])

class TextBuilder:
    def __init__(self, lines, indent):
        self.lines = lines
        self.indent = indent

    def __repr__(self):
        return runtime.struct_repr('TextBuilder', [runtime.struct_field('lines', self.lines), runtime.struct_field('indent', self.indent)])

class NativeState:
    def __init__(self, builder, diagnostics, layout_context):
        self.builder = builder
        self.diagnostics = diagnostics
        self.layout_context = layout_context

    def __repr__(self):
        return runtime.struct_repr('NativeState', [runtime.struct_field('builder', self.builder), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('layout_context', self.layout_context)])

class LayoutEmitResult:
    def __init__(self, lines, diagnostics):
        self.lines = lines
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('LayoutEmitResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('diagnostics', self.diagnostics)])

class StructFieldLayoutDescriptor:
    def __init__(self, name, type_annotation, offset, size, align):
        self.name = name
        self.type_annotation = type_annotation
        self.offset = offset
        self.size = size
        self.align = align

    def __repr__(self):
        return runtime.struct_repr('StructFieldLayoutDescriptor', [runtime.struct_field('name', self.name), runtime.struct_field('type_annotation', self.type_annotation), runtime.struct_field('offset', self.offset), runtime.struct_field('size', self.size), runtime.struct_field('align', self.align)])

class RecordLayoutResult:
    def __init__(self, size, align, fields, diagnostics):
        self.size = size
        self.align = align
        self.fields = fields
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('RecordLayoutResult', [runtime.struct_field('size', self.size), runtime.struct_field('align', self.align), runtime.struct_field('fields', self.fields), runtime.struct_field('diagnostics', self.diagnostics)])

class EnumVariantLayoutDescriptor:
    def __init__(self, name, tag, offset, size, align, fields):
        self.name = name
        self.tag = tag
        self.offset = offset
        self.size = size
        self.align = align
        self.fields = fields

    def __repr__(self):
        return runtime.struct_repr('EnumVariantLayoutDescriptor', [runtime.struct_field('name', self.name), runtime.struct_field('tag', self.tag), runtime.struct_field('offset', self.offset), runtime.struct_field('size', self.size), runtime.struct_field('align', self.align), runtime.struct_field('fields', self.fields)])

class EnumAggregateLayout:
    def __init__(self, size, align, tag_size, tag_align, variants, diagnostics):
        self.size = size
        self.align = align
        self.tag_size = tag_size
        self.tag_align = tag_align
        self.variants = variants
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('EnumAggregateLayout', [runtime.struct_field('size', self.size), runtime.struct_field('align', self.align), runtime.struct_field('tag_size', self.tag_size), runtime.struct_field('tag_align', self.tag_align), runtime.struct_field('variants', self.variants), runtime.struct_field('diagnostics', self.diagnostics)])

class TypeLayoutInfo:
    def __init__(self, size, align, diagnostics):
        self.size = size
        self.align = align
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('TypeLayoutInfo', [runtime.struct_field('size', self.size), runtime.struct_field('align', self.align), runtime.struct_field('diagnostics', self.diagnostics)])

class LayoutFieldInput:
    def __init__(self, name, type_annotation):
        self.name = name
        self.type_annotation = type_annotation

    def __repr__(self):
        return runtime.struct_repr('LayoutFieldInput', [runtime.struct_field('name', self.name), runtime.struct_field('type_annotation', self.type_annotation)])

class LayoutStructDefinition:
    def __init__(self, name, fields):
        self.name = name
        self.fields = fields

    def __repr__(self):
        return runtime.struct_repr('LayoutStructDefinition', [runtime.struct_field('name', self.name), runtime.struct_field('fields', self.fields)])

class LayoutEnumVariantDefinition:
    def __init__(self, name, fields):
        self.name = name
        self.fields = fields

    def __repr__(self):
        return runtime.struct_repr('LayoutEnumVariantDefinition', [runtime.struct_field('name', self.name), runtime.struct_field('fields', self.fields)])

class LayoutEnumDefinition:
    def __init__(self, name, variants):
        self.name = name
        self.variants = variants

    def __repr__(self):
        return runtime.struct_repr('LayoutEnumDefinition', [runtime.struct_field('name', self.name), runtime.struct_field('variants', self.variants)])

class CanonicalTypeLayout:
    def __init__(self, name, size, align):
        self.name = name
        self.size = size
        self.align = align

    def __repr__(self):
        return runtime.struct_repr('CanonicalTypeLayout', [runtime.struct_field('name', self.name), runtime.struct_field('size', self.size), runtime.struct_field('align', self.align)])

class LayoutContext:
    def __init__(self, structs, enums):
        self.structs = structs
        self.enums = enums

    def __repr__(self):
        return runtime.struct_repr('LayoutContext', [runtime.struct_field('structs', self.structs), runtime.struct_field('enums', self.enums)])

def build_layout_context(program):
    structs = []
    enums = []
    index = 0
    while True:
        if index >= len(program.statements):
            break
        statement = program.statements[index]
        if statement.variant == "StructDeclaration":
            inputs = convert_struct_fields(statement.fields)
            structs = append_layout_struct_definition(structs, LayoutStructDefinition(name=statement.name, fields=inputs))
        if statement.variant == "EnumDeclaration":
            variants = []
            variant_index = 0
            while True:
                if variant_index >= len(statement.variants):
                    break
                variant = statement.variants[variant_index]
                inputs = convert_variant_fields(variant)
                variants = append_layout_enum_variant_definition(variants, LayoutEnumVariantDefinition(name=variant.name, fields=inputs))
                variant_index += 1
            enums = append_layout_enum_definition(enums, LayoutEnumDefinition(name=statement.name, variants=variants))
        index += 1
    return LayoutContext(structs=structs, enums=enums)

def emit_native(program):
    layout_context = build_layout_context(program)
    state = state_new(layout_context)
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
    manifest_artifact = generate_layout_manifest(program, layout_context)
    module = NativeModule(artifacts=[artifact, manifest_artifact], entry_points=collect_entry_points(program), symbol_count=count_exported_symbols(program))
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
        return emit_return(state, statement)
    if statement.variant == "ExpressionStatement":
        return emit_expression_statement(state, statement)
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
    if alias == None  or  len(alias) == 0:
        return name
    return name + " as " + alias

def emit_span_if_present(state, span):
    if span == None:
        return state
    return state_emit_line(state, ".span " + format_span(span))

def emit_initializer_span_if_present(state, span):
    if span == None:
        return state
    return state_emit_line(state, ".init-span " + format_span(span))

def format_span(span):
    return number_to_string(span.start_line) + " " + number_to_string(span.start_column) + " " + number_to_string(span.end_line) + " " + number_to_string(span.end_column)

def emit_variable(state, statement):
    current = emit_span_if_present(state, statement.span)
    current = emit_initializer_span_if_present(current, statement.initializer_span)
    line = ".let "
    if statement.mutable:
        line = line + "mut "
    line = line + statement.name
    if statement.type_annotation != None:
        line = line + " : " + statement.type_annotation.text
    if statement.initializer != None:
        line = line + " = " + format_expression(statement.initializer)
    return state_emit_line(current, line)

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
    current = emit_signature_metadata(
current,
FunctionSignature(name=statement.name, is_async=False, parameters=[], return_type=None, effects=statement.effects, type_parameters=[], name_span=None)
)
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
    enum_layout = compute_enum_layout_lines(state.layout_context, statement)
    current = emit_layout_lines(current, enum_layout.lines)
    current = state_merge_diagnostics(current, enum_layout.diagnostics)
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
    struct_layout = compute_struct_layout_lines(state.layout_context, statement.name, statement.fields)
    current = emit_layout_lines(current, struct_layout.lines)
    current = state_merge_diagnostics(current, struct_layout.diagnostics)
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
    if inline_statement != None:
        return emit_inline_match_case(state, case, inline_statement)
    line = ".case " + format_match_case_head(case)
    current = state_emit_line(state, line)
    current = state_push_indent(current)
    current = emit_block(current, case.body)
    current = state_pop_indent(current)
    return current

def select_inline_match_case_statement(block):
    if len(block.statements) != 1:
        return None
    statement = block.statements[0]
    if statement.variant == "ExpressionStatement":
        return statement
    if statement.variant == "ReturnStatement":
        return statement
    return None

def emit_inline_match_case(state, case, statement):
    line = format_match_case_head(case) + " => " + format_inline_case_body(statement)
    return state_emit_line(state, line + ",")

def format_match_case_head(case):
    head = format_expression(case.pattern)
    if case.guard != None:
        head = head + " if " + format_expression(case.guard)
    return head

def format_inline_case_body(statement):
    if statement.variant == "ExpressionStatement":
        return format_expression(statement.expression)
    if statement.variant == "ReturnStatement":
        if statement.expression == None:
            return "return"
        return "return " + format_expression(statement.expression)
    return ""

def emit_if(state, statement):
    current = emit_decorators(state, statement.decorators)
    current = state_emit_line(current, ".if " + format_expression(statement.condition))
    current = state_push_indent(current)
    current = emit_block(current, statement.then_block)
    current = state_pop_indent(current)
    if statement.else_branch != None:
        current = emit_else_branch(current, statement.else_branch)
    return state_emit_line(current, ".endif")

def emit_else_branch(state, branch):
    current = state_emit_line(state, ".else")
    current = state_push_indent(current)
    if branch.body != None:
        current = emit_block(current, branch.body)
    else:
        if branch.statement != None:
            current = emit_statement(current, branch.statement)
        else:
            current = state_emit_line(current, "noop")
    current = state_pop_indent(current)
    return current

def emit_return(state, statement):
    current = emit_span_if_present(state, statement.span)
    if statement.expression == None:
        return state_emit_line(current, "ret")
    return state_emit_line(current, "ret " + format_expression(statement.expression))

def emit_expression_statement(state, statement):
    current = emit_span_if_present(state, statement.span)
    return state_emit_line(current, "eval " + format_expression(statement.expression))

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
    if signature.return_type != None:
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
        current = emit_span_if_present(current, parameter.span)
        line = ".param "
        if parameter.mutable:
            line = line + "mut "
        line = line + parameter.name
        if parameter.type_annotation != None:
            line = line + " -> " + parameter.type_annotation.text
        if parameter.default_value != None:
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
        if argument.name != None:
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
    if signature.return_type != None:
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
        if parameter.type_annotation != None:
            entry = entry + " -> " + parameter.type_annotation.text
        if parameter.default_value != None:
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
        if parameter.bound != None:
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

def compute_struct_layout_lines(context, struct_name, fields):
    inputs = convert_struct_fields(fields)
    layout = calculate_record_layout(context, inputs, "struct", struct_name, append_string([], struct_name))
    lines = []
    lines = append_string(lines, ".layout struct name=" + struct_name + " size=" + number_to_string(layout.size) + " align=" + number_to_string(layout.align))
    index = 0
    while True:
        if index >= len(layout.fields):
            break
        field = layout.fields[index]
        line = ".layout field " + field.name
        line = line + " type=" + field.type_annotation
        line = line + " offset=" + number_to_string(field.offset)
        line = line + " size=" + number_to_string(field.size)
        line = line + " align=" + number_to_string(field.align)
        lines = append_string(lines, line)
        index += 1
    return LayoutEmitResult(lines=lines, diagnostics=layout.diagnostics)

def compute_enum_layout_lines(context, statement):
    layout_variants = []
    index = 0
    while True:
        if index >= len(statement.variants):
            break
        variant = statement.variants[index]
        inputs = convert_variant_fields(variant)
        layout_variants = append_layout_enum_variant_definition(layout_variants, LayoutEnumVariantDefinition(name=variant.name, fields=inputs))
        index += 1
    layout = infer_enum_aggregate_layout(context, statement.name, layout_variants, append_string([], statement.name))
    lines = []
    header = ".layout enum name=" + statement.name + " size=" + number_to_string(layout.size) + " align=" + number_to_string(layout.align)
    header = header + " tag_type=i32 tag_size=" + number_to_string(layout.tag_size) + " tag_align=" + number_to_string(layout.tag_align)
    lines = append_string(lines, header)
    variant_index = 0
    while True:
        if variant_index >= len(layout.variants):
            break
        descriptor = layout.variants[variant_index]
        line = ".layout variant " + descriptor.name
        line = line + " tag=" + number_to_string(descriptor.tag)
        line = line + " offset=" + number_to_string(descriptor.offset)
        line = line + " size=" + number_to_string(descriptor.size)
        line = line + " align=" + number_to_string(descriptor.align)
        lines = append_string(lines, line)
        payload_index = 0
        while True:
            if payload_index >= len(descriptor.fields):
                break
            payload = descriptor.fields[payload_index]
            payload_line = ".layout payload " + descriptor.name + "." + payload.name
            payload_line = payload_line + " type=" + payload.type_annotation
            payload_line = payload_line + " offset=" + number_to_string(payload.offset)
            payload_line = payload_line + " size=" + number_to_string(payload.size)
            payload_line = payload_line + " align=" + number_to_string(payload.align)
            lines = append_string(lines, payload_line)
            payload_index += 1
        variant_index += 1
    return LayoutEmitResult(lines=lines, diagnostics=layout.diagnostics)

def infer_enum_aggregate_layout(context, enum_name, variants, visiting):
    tag_size = 4
    tag_align = 4
    union_align = tag_align
    union_size = tag_size
    diagnostics = []
    descriptors = []
    index = 0
    while True:
        if index >= len(variants):
            break
        variant = variants[index]
        container_name = enum_name + "." + variant.name
        record = calculate_record_layout(context, variant.fields, "variant", container_name, visiting)
        diagnostics = (diagnostics) + (record.diagnostics)
        variant_align = record.align
        if variant_align <= 0:
            variant_align = 1
        payload_offset = align_to(tag_size, variant_align)
        if variant_align > union_align:
            union_align = variant_align
        absolute_fields = []
        field_index = 0
        while True:
            if field_index >= len(record.fields):
                break
            field = record.fields[field_index]
            absolute = StructFieldLayoutDescriptor(name=field.name, type_annotation=field.type_annotation, offset=payload_offset + field.offset, size=field.size, align=field.align)
            absolute_fields = append_struct_field_layout(absolute_fields, absolute)
            field_index += 1
        variant_size = payload_offset + record.size
        if variant_size > union_size:
            union_size = variant_size
        descriptors = append_enum_variant_layout(descriptors, EnumVariantLayoutDescriptor(name=variant.name, tag=index, offset=payload_offset, size=record.size, align=variant_align, fields=absolute_fields))
        index += 1
    if len(variants) == 0:
        union_align = tag_align
        union_size = tag_size
    final_align = union_align
    if final_align <= 0:
        final_align = 1
    aligned_size = union_size
    if final_align > 1:
        aligned_size = align_to(union_size, final_align)
    return EnumAggregateLayout(size=aligned_size, align=final_align, tag_size=tag_size, tag_align=tag_align, variants=descriptors, diagnostics=diagnostics)

def calculate_record_layout(context, inputs, container_kind, container_name, visiting):
    diagnostics = []
    fields = []
    offset = 0
    max_align = 1
    index = 0
    while True:
        if index >= len(inputs):
            break
        input = inputs[index]
        layout = analyze_type_layout(context, visiting, input.type_annotation, container_kind, container_name, input.name)
        diagnostics = (diagnostics) + (layout.diagnostics)
        field_align = layout.align
        if field_align <= 0:
            field_align = 1
        offset = align_to(offset, field_align)
        descriptor = StructFieldLayoutDescriptor(name=input.name, type_annotation=trim_text(input.type_annotation), offset=offset, size=layout.size, align=field_align)
        fields = append_struct_field_layout(fields, descriptor)
        offset += layout.size
        if field_align > max_align:
            max_align = field_align
        index += 1
    final_align = max_align
    if len(inputs) == 0:
        final_align = 1
    if final_align <= 0:
        final_align = 1
    total_size = offset
    if final_align > 1:
        total_size = align_to(offset, final_align)
    return RecordLayoutResult(size=total_size, align=final_align, fields=fields, diagnostics=diagnostics)

def analyze_type_layout(context, visiting, type_annotation, container_kind, container_name, field_name):
    trimmed = trim_text(type_annotation)
    diagnostics = []
    if len(trimmed) == 0:
        diagnostics = append_string(diagnostics, "native layout: " + container_kind + " `" + container_name + "` field `" + field_name + "` missing type annotation; defaulting to pointer layout")
        return TypeLayoutInfo(size=8, align=8, diagnostics=diagnostics)
    if trimmed == "number":
        return TypeLayoutInfo(size=8, align=8, diagnostics=diagnostics)
    if trimmed == "int"  or  trimmed == "i64":
        return TypeLayoutInfo(size=8, align=8, diagnostics=diagnostics)
    if trimmed == "i32":
        return TypeLayoutInfo(size=4, align=4, diagnostics=diagnostics)
    if trimmed == "boolean"  or  trimmed == "bool"  or  trimmed == "i1":
        return TypeLayoutInfo(size=1, align=1, diagnostics=diagnostics)
    if trimmed == "any":
        return TypeLayoutInfo(size=8, align=8, diagnostics=diagnostics)
    canonical = lookup_canonical_type_layout(trimmed)
    if canonical != None:
        return TypeLayoutInfo(size=canonical.size, align=canonical.align, diagnostics=diagnostics)
    if is_array_type(trimmed):
        return TypeLayoutInfo(size=8, align=8, diagnostics=diagnostics)
    if trimmed == "string":
        return TypeLayoutInfo(size=8, align=8, diagnostics=diagnostics)
    if is_optional_annotation(trimmed):
        inner = trim_text(strip_optional_suffix(trimmed))
        if len(inner) == 0:
            diagnostics = append_string(diagnostics, "native layout: " + container_kind + " `" + container_name + "` field `" + field_name + "` optional type missing inner annotation; defaulting to pointer layout")
        return TypeLayoutInfo(size=8, align=8, diagnostics=diagnostics)
    if contains_string(visiting, trimmed):
        return TypeLayoutInfo(size=8, align=8, diagnostics=diagnostics)
    struct_definition = find_layout_struct_definition(context, trimmed)
    if struct_definition != None:
        nested_visiting = append_string(visiting, trimmed)
        record = calculate_record_layout(context, struct_definition.fields, "struct", trimmed, nested_visiting)
        diagnostics = (diagnostics) + (record.diagnostics)
        return TypeLayoutInfo(size=record.size, align=record.align, diagnostics=diagnostics)
    enum_definition = find_layout_enum_definition(context, trimmed)
    if enum_definition != None:
        nested_visiting = append_string(visiting, trimmed)
        aggregate = infer_enum_aggregate_layout(context, trimmed, enum_definition.variants, nested_visiting)
        diagnostics = (diagnostics) + (aggregate.diagnostics)
        return TypeLayoutInfo(size=aggregate.size, align=aggregate.align, diagnostics=diagnostics)
    diagnostics = append_string(diagnostics, "native layout: " + container_kind + " `" + container_name + "` field `" + field_name + "` uses unsupported type `" + trimmed + "`; defaulting to pointer layout")
    return TypeLayoutInfo(size=8, align=8, diagnostics=diagnostics)

def convert_struct_fields(fields):
    inputs = []
    index = 0
    while True:
        if index >= len(fields):
            break
        field = fields[index]
        type_text = ""
        if field.type_annotation != None:
            type_text = field.type_annotation.text
        inputs = append_layout_field_input(inputs, LayoutFieldInput(name=field.name, type_annotation=type_text))
        index += 1
    return inputs

def convert_variant_fields(variant):
    return convert_struct_fields(variant.fields)

def append_struct_field_layout(values, value):
    return (values) + ([value])

def append_enum_variant_layout(values, value):
    return (values) + ([value])

def append_layout_field_input(values, value):
    return (values) + ([value])

def append_layout_struct_definition(values, value):
    return (values) + ([value])

def append_layout_enum_definition(values, value):
    return (values) + ([value])

def append_layout_enum_variant_definition(values, value):
    return (values) + ([value])

def append_canonical_type_layout(values, value):
    return (values) + ([value])

def find_layout_struct_definition(context, name):
    index = 0
    while True:
        if index >= len(context.structs):
            break
        definition = context.structs[index]
        if definition.name == name:
            return definition
        index += 1
    return None

def find_layout_enum_definition(context, name):
    index = 0
    while True:
        if index >= len(context.enums):
            break
        definition = context.enums[index]
        if definition.name == name:
            return definition
        index += 1
    return None

def canonical_type_layouts():
    layouts = []
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="Token", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="TokenKind", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="Program", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="TypeAnnotation", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="TypeParameter", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="Block", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="SourceSpan", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="Expression", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="Parameter", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="WithClause", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="ObjectField", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="ElseBranch", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="ForClause", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="MatchCase", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="ModelProperty", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="FieldDeclaration", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="MethodDeclaration", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="EnumVariant", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="FunctionSignature", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="PipelineDeclaration", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="ToolDeclaration", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="TestDeclaration", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="ModelDeclaration", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="Decorator", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="DecoratorArgument", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="NamedSpecifier", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="Statement", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="EnumField", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="EnumVariantDefinition", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="EnumType", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="EnumInstance", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="StructField", size=8, align=8))
    layouts = append_canonical_type_layout(layouts, CanonicalTypeLayout(name="TypeDescriptor", size=8, align=8))
    return layouts

def lookup_canonical_type_layout(name):
    layouts = canonical_type_layouts()
    index = 0
    while True:
        if index >= len(layouts):
            break
        layout = layouts[index]
        if layout.name == name:
            return layout
        index += 1
    return None

def align_to(value, alignment):
    if alignment <= 1:
        return value
    remainder = value
    while True:
        if remainder < alignment:
            break
        remainder -= alignment
    if remainder == 0:
        return value
    return value + alignment - remainder

def is_array_type(type_annotation):
    return ends_with(type_annotation, "[]")

def is_optional_annotation(type_annotation):
    return ends_with(type_annotation, "?")

def strip_optional_suffix(type_annotation):
    if len(type_annotation) == 0:
        return type_annotation
    return substring(type_annotation, 0, len(type_annotation) - 1)

def ends_with(value, suffix):
    if len(suffix) == 0:
        return True
    if len(value) < len(suffix):
        return False
    start = len(value) - len(suffix)
    index = 0
    while True:
        if index >= len(suffix):
            break
        if value[start + index] != suffix[index]:
            return False
        index += 1
    return True

def number_to_string(value):
    if value == 0:
        return "0"
    remaining = value
    output = ""
    digits = "0123456789"
    while True:
        if remaining <= 0:
            break
        temp = remaining
        quotient = 0
        while True:
            if temp < 10:
                break
            temp -= 10
            quotient += 1
        digit = temp
        ch = substring(digits, digit, digit + 1)
        output = ch + output
        remaining = quotient
    return output

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
        return format_array_expression(expression.elements)
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

def format_array_expression(elements):
    annotation = infer_array_element_type(elements)
    rendered = []
    index = 0
    while True:
        if index >= len(elements):
            break
        rendered = append_string(rendered, format_expression(elements[index]))
        index += 1
    if len(rendered) == 0:
        if len(annotation) == 0:
            return "[]"
        return "[#element:" + annotation + "]"
    body = join_with_separator(rendered, ", ")
    if len(annotation) == 0:
        return "[" + body + "]"
    return "[#element:" + annotation + ", " + body + "]"

def infer_array_element_type(elements):
    if len(elements) == 0:
        return ""
    candidate = ""
    index = 0
    while True:
        if index >= len(elements):
            break
        element_type = infer_expression_type(elements[index])
        if len(element_type) == 0:
            return ""
        if len(candidate) == 0:
            candidate = element_type
        else:
            if candidate != element_type:
                return ""
        index += 1
    return candidate

def infer_expression_type(expression):
    if expression.variant == "NumberLiteral":
        return "number"
    if expression.variant == "BooleanLiteral":
        return "boolean"
    if expression.variant == "StringLiteral":
        return "string"
    if expression.variant == "Struct":
        if len(expression.type_name) == 0:
            return ""
        if len(expression.type_name) == 2:
            return expression.type_name[0]
        return join_with_separator(expression.type_name, ".")
    if expression.variant == "Member":
        if expression.object.variant == "Identifier":
            return expression.object.name
        if expression.object.variant == "Member":
            return infer_expression_type(expression.object)
        return ""
    if expression.variant == "Array":
        nested = infer_array_element_type(expression.elements)
        if len(nested) == 0:
            return ""
        return nested + "[]"
    return ""

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
            return True
        index += 1
    return False

def state_new(context):
    return NativeState(builder=builder_new(), diagnostics=[], layout_context=context)

def state_emit_line(state, line):
    return NativeState(builder=builder_emit_line(state.builder, line), diagnostics=state.diagnostics, layout_context=state.layout_context)

def state_emit_blank(state):
    return NativeState(builder=builder_emit_blank(state.builder), diagnostics=state.diagnostics, layout_context=state.layout_context)

def state_push_indent(state):
    return NativeState(builder=builder_push_indent(state.builder), diagnostics=state.diagnostics, layout_context=state.layout_context)

def state_pop_indent(state):
    return NativeState(builder=builder_pop_indent(state.builder), diagnostics=state.diagnostics, layout_context=state.layout_context)

def state_add_diagnostic(state, message):
    diagnostics = append_string(state.diagnostics, message)
    return NativeState(builder=builder_emit_line(state.builder, "; " + message), diagnostics=diagnostics, layout_context=state.layout_context)

def state_merge_diagnostics(state, entries):
    if len(entries) == 0:
        return state
    combined = state.diagnostics
    index = 0
    while True:
        if index >= len(entries):
            break
        combined = append_string(combined, entries[index])
        index += 1
    return NativeState(builder=state.builder, diagnostics=combined, layout_context=state.layout_context)

def generate_layout_manifest(program, context):
    builder = builder_new()
    builder = builder_emit_line(builder, "; Sailfin Layout Manifest")
    builder = builder_emit_line(builder, ".manifest version=1")
    builder = builder_emit_blank(builder)
    index = 0
    while True:
        if index >= len(program.statements):
            break
        statement = program.statements[index]
        if statement.variant == "StructDeclaration":
            result = compute_struct_layout_lines(context, statement.name, statement.fields)
            line_index = 0
            while True:
                if line_index >= len(result.lines):
                    break
                builder = builder_emit_line(builder, result.lines[line_index])
                line_index += 1
            builder = builder_emit_blank(builder)
        index += 1
    index = 0
    while True:
        if index >= len(program.statements):
            break
        statement = program.statements[index]
        if statement.variant == "EnumDeclaration":
            result = compute_enum_layout_lines(context, statement)
            line_index = 0
            while True:
                if line_index >= len(result.lines):
                    break
                builder = builder_emit_line(builder, result.lines[line_index])
                line_index += 1
            builder = builder_emit_blank(builder)
        index += 1
    return NativeArtifact(name="module.layout-manifest", format="sailfin-layout-manifest", contents=builder_to_string(builder))

def emit_layout_lines(state, lines):
    if len(lines) == 0:
        return state
    current = state
    index = 0
    while True:
        if index >= len(lines):
            break
        current = state_emit_line(current, lines[index])
        index += 1
    return current

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
