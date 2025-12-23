import asyncio
from runtime import runtime_support as runtime

from compiler.build.emit_native import NativeArtifact
from compiler.build.string_utils import substring, char_code

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

NativeInstruction = runtime.enum_type('NativeInstruction')
NativeInstruction = runtime.enum_define_variant(NativeInstruction, 'Return', ['expression', 'span'])
NativeInstruction = runtime.enum_define_variant(NativeInstruction, 'Expression', ['expression', 'span'])
NativeInstruction = runtime.enum_define_variant(NativeInstruction, 'Let', ['name', 'mutable', 'type_annotation', 'value', 'span', 'value_span'])
NativeInstruction = runtime.enum_define_variant(NativeInstruction, 'If', ['condition'])
NativeInstruction = runtime.enum_define_variant(NativeInstruction, 'Else', [])
NativeInstruction = runtime.enum_define_variant(NativeInstruction, 'EndIf', [])
NativeInstruction = runtime.enum_define_variant(NativeInstruction, 'For', ['target', 'iterable'])
NativeInstruction = runtime.enum_define_variant(NativeInstruction, 'EndFor', [])
NativeInstruction = runtime.enum_define_variant(NativeInstruction, 'Loop', [])
NativeInstruction = runtime.enum_define_variant(NativeInstruction, 'EndLoop', [])
NativeInstruction = runtime.enum_define_variant(NativeInstruction, 'Break', [])
NativeInstruction = runtime.enum_define_variant(NativeInstruction, 'Continue', [])
NativeInstruction = runtime.enum_define_variant(NativeInstruction, 'Match', ['expression'])
NativeInstruction = runtime.enum_define_variant(NativeInstruction, 'Case', ['pattern', 'guard'])
NativeInstruction = runtime.enum_define_variant(NativeInstruction, 'EndMatch', [])
NativeInstruction = runtime.enum_define_variant(NativeInstruction, 'Noop', [])
NativeInstruction = runtime.enum_define_variant(NativeInstruction, 'Unknown', ['text'])

class NativeSourceSpan:
    def __init__(self, start_line, start_column, end_line, end_column):
        self.start_line = start_line
        self.start_column = start_column
        self.end_line = end_line
        self.end_column = end_column

    def __repr__(self):
        return runtime.struct_repr('NativeSourceSpan', [runtime.struct_field('start_line', self.start_line), runtime.struct_field('start_column', self.start_column), runtime.struct_field('end_line', self.end_line), runtime.struct_field('end_column', self.end_column)])

class NativeParameter:
    def __init__(self, name, type_annotation, mutable, default_value=None, span=None):
        self.name = name
        self.type_annotation = type_annotation
        self.mutable = mutable
        self.default_value = default_value
        self.span = span

    def __repr__(self):
        return runtime.struct_repr('NativeParameter', [runtime.struct_field('name', self.name), runtime.struct_field('type_annotation', self.type_annotation), runtime.struct_field('mutable', self.mutable), runtime.struct_field('default_value', self.default_value), runtime.struct_field('span', self.span)])

class NativeFunction:
    def __init__(self, name, parameters, return_type, effects, instructions):
        self.name = name
        self.parameters = parameters
        self.return_type = return_type
        self.effects = effects
        self.instructions = instructions

    def __repr__(self):
        return runtime.struct_repr('NativeFunction', [runtime.struct_field('name', self.name), runtime.struct_field('parameters', self.parameters), runtime.struct_field('return_type', self.return_type), runtime.struct_field('effects', self.effects), runtime.struct_field('instructions', self.instructions)])

class NativeImportSpecifier:
    def __init__(self, name, alias=None):
        self.name = name
        self.alias = alias

    def __repr__(self):
        return runtime.struct_repr('NativeImportSpecifier', [runtime.struct_field('name', self.name), runtime.struct_field('alias', self.alias)])

class NativeImport:
    def __init__(self, kind, module, specifiers):
        self.kind = kind
        self.module = module
        self.specifiers = specifiers

    def __repr__(self):
        return runtime.struct_repr('NativeImport', [runtime.struct_field('kind', self.kind), runtime.struct_field('module', self.module), runtime.struct_field('specifiers', self.specifiers)])

class NativeStructField:
    def __init__(self, name, type_annotation, mutable):
        self.name = name
        self.type_annotation = type_annotation
        self.mutable = mutable

    def __repr__(self):
        return runtime.struct_repr('NativeStructField', [runtime.struct_field('name', self.name), runtime.struct_field('type_annotation', self.type_annotation), runtime.struct_field('mutable', self.mutable)])

class NativeStructLayoutField:
    def __init__(self, name, type_annotation, offset, size, align):
        self.name = name
        self.type_annotation = type_annotation
        self.offset = offset
        self.size = size
        self.align = align

    def __repr__(self):
        return runtime.struct_repr('NativeStructLayoutField', [runtime.struct_field('name', self.name), runtime.struct_field('type_annotation', self.type_annotation), runtime.struct_field('offset', self.offset), runtime.struct_field('size', self.size), runtime.struct_field('align', self.align)])

class NativeStructLayout:
    def __init__(self, size, align, fields):
        self.size = size
        self.align = align
        self.fields = fields

    def __repr__(self):
        return runtime.struct_repr('NativeStructLayout', [runtime.struct_field('size', self.size), runtime.struct_field('align', self.align), runtime.struct_field('fields', self.fields)])

class NativeStruct:
    def __init__(self, name, fields, methods, implements, layout=None):
        self.name = name
        self.fields = fields
        self.methods = methods
        self.implements = implements
        self.layout = layout

    def __repr__(self):
        return runtime.struct_repr('NativeStruct', [runtime.struct_field('name', self.name), runtime.struct_field('fields', self.fields), runtime.struct_field('methods', self.methods), runtime.struct_field('implements', self.implements), runtime.struct_field('layout', self.layout)])

class NativeInterfaceSignature:
    def __init__(self, name, is_async, type_parameters, parameters, return_type, effects):
        self.name = name
        self.is_async = is_async
        self.type_parameters = type_parameters
        self.parameters = parameters
        self.return_type = return_type
        self.effects = effects

    def __repr__(self):
        return runtime.struct_repr('NativeInterfaceSignature', [runtime.struct_field('name', self.name), runtime.struct_field('is_async', self.is_async), runtime.struct_field('type_parameters', self.type_parameters), runtime.struct_field('parameters', self.parameters), runtime.struct_field('return_type', self.return_type), runtime.struct_field('effects', self.effects)])

class NativeInterface:
    def __init__(self, name, type_parameters, signatures):
        self.name = name
        self.type_parameters = type_parameters
        self.signatures = signatures

    def __repr__(self):
        return runtime.struct_repr('NativeInterface', [runtime.struct_field('name', self.name), runtime.struct_field('type_parameters', self.type_parameters), runtime.struct_field('signatures', self.signatures)])

class NativeEnumVariantField:
    def __init__(self, name, type_annotation, mutable):
        self.name = name
        self.type_annotation = type_annotation
        self.mutable = mutable

    def __repr__(self):
        return runtime.struct_repr('NativeEnumVariantField', [runtime.struct_field('name', self.name), runtime.struct_field('type_annotation', self.type_annotation), runtime.struct_field('mutable', self.mutable)])

class NativeEnumVariant:
    def __init__(self, name, fields):
        self.name = name
        self.fields = fields

    def __repr__(self):
        return runtime.struct_repr('NativeEnumVariant', [runtime.struct_field('name', self.name), runtime.struct_field('fields', self.fields)])

class NativeEnumVariantLayout:
    def __init__(self, name, tag, offset, size, align, fields):
        self.name = name
        self.tag = tag
        self.offset = offset
        self.size = size
        self.align = align
        self.fields = fields

    def __repr__(self):
        return runtime.struct_repr('NativeEnumVariantLayout', [runtime.struct_field('name', self.name), runtime.struct_field('tag', self.tag), runtime.struct_field('offset', self.offset), runtime.struct_field('size', self.size), runtime.struct_field('align', self.align), runtime.struct_field('fields', self.fields)])

class NativeEnumLayout:
    def __init__(self, size, align, tag_type, tag_size, tag_align, variants):
        self.size = size
        self.align = align
        self.tag_type = tag_type
        self.tag_size = tag_size
        self.tag_align = tag_align
        self.variants = variants

    def __repr__(self):
        return runtime.struct_repr('NativeEnumLayout', [runtime.struct_field('size', self.size), runtime.struct_field('align', self.align), runtime.struct_field('tag_type', self.tag_type), runtime.struct_field('tag_size', self.tag_size), runtime.struct_field('tag_align', self.tag_align), runtime.struct_field('variants', self.variants)])

class NativeEnum:
    def __init__(self, name, variants, layout=None):
        self.name = name
        self.variants = variants
        self.layout = layout

    def __repr__(self):
        return runtime.struct_repr('NativeEnum', [runtime.struct_field('name', self.name), runtime.struct_field('variants', self.variants), runtime.struct_field('layout', self.layout)])

class NativeBinding:
    def __init__(self, name, mutable, type_annotation, value=None):
        self.name = name
        self.mutable = mutable
        self.type_annotation = type_annotation
        self.value = value

    def __repr__(self):
        return runtime.struct_repr('NativeBinding', [runtime.struct_field('name', self.name), runtime.struct_field('mutable', self.mutable), runtime.struct_field('type_annotation', self.type_annotation), runtime.struct_field('value', self.value)])

class EnumParseResult:
    def __init__(self, next_index, diagnostics, definition=None):
        self.definition = definition
        self.next_index = next_index
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('EnumParseResult', [runtime.struct_field('definition', self.definition), runtime.struct_field('next_index', self.next_index), runtime.struct_field('diagnostics', self.diagnostics)])

class CaseComponents:
    def __init__(self, pattern, guard=None):
        self.pattern = pattern
        self.guard = guard

    def __repr__(self):
        return runtime.struct_repr('CaseComponents', [runtime.struct_field('pattern', self.pattern), runtime.struct_field('guard', self.guard)])

class InstructionParseResult:
    def __init__(self, instructions, span_consumed, value_span_consumed):
        self.instructions = instructions
        self.span_consumed = span_consumed
        self.value_span_consumed = value_span_consumed

    def __repr__(self):
        return runtime.struct_repr('InstructionParseResult', [runtime.struct_field('instructions', self.instructions), runtime.struct_field('span_consumed', self.span_consumed), runtime.struct_field('value_span_consumed', self.value_span_consumed)])

class InstructionGatherResult:
    def __init__(self, text, lines_consumed):
        self.text = text
        self.lines_consumed = lines_consumed

    def __repr__(self):
        return runtime.struct_repr('InstructionGatherResult', [runtime.struct_field('text', self.text), runtime.struct_field('lines_consumed', self.lines_consumed)])

class InstructionDepthState:
    def __init__(self, paren_depth, bracket_depth, brace_depth, in_string, escaping):
        self.paren_depth = paren_depth
        self.bracket_depth = bracket_depth
        self.brace_depth = brace_depth
        self.in_string = in_string
        self.escaping = escaping

    def __repr__(self):
        return runtime.struct_repr('InstructionDepthState', [runtime.struct_field('paren_depth', self.paren_depth), runtime.struct_field('bracket_depth', self.bracket_depth), runtime.struct_field('brace_depth', self.brace_depth), runtime.struct_field('in_string', self.in_string), runtime.struct_field('escaping', self.escaping)])

class StructParseResult:
    def __init__(self, next_index, diagnostics, definition=None):
        self.definition = definition
        self.next_index = next_index
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('StructParseResult', [runtime.struct_field('definition', self.definition), runtime.struct_field('next_index', self.next_index), runtime.struct_field('diagnostics', self.diagnostics)])

class InterfaceParseResult:
    def __init__(self, next_index, diagnostics, definition=None):
        self.definition = definition
        self.next_index = next_index
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('InterfaceParseResult', [runtime.struct_field('definition', self.definition), runtime.struct_field('next_index', self.next_index), runtime.struct_field('diagnostics', self.diagnostics)])

class InterfaceSignatureParse:
    def __init__(self, success, signature, diagnostics):
        self.success = success
        self.signature = signature
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('InterfaceSignatureParse', [runtime.struct_field('success', self.success), runtime.struct_field('signature', self.signature), runtime.struct_field('diagnostics', self.diagnostics)])

class StructHeaderParse:
    def __init__(self, name, implements, diagnostics):
        self.name = name
        self.implements = implements
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('StructHeaderParse', [runtime.struct_field('name', self.name), runtime.struct_field('implements', self.implements), runtime.struct_field('diagnostics', self.diagnostics)])

class InterfaceHeaderParse:
    def __init__(self, name, type_parameters, diagnostics):
        self.name = name
        self.type_parameters = type_parameters
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('InterfaceHeaderParse', [runtime.struct_field('name', self.name), runtime.struct_field('type_parameters', self.type_parameters), runtime.struct_field('diagnostics', self.diagnostics)])

class HeaderNameParse:
    def __init__(self, name, type_parameters, remainder, diagnostics):
        self.name = name
        self.type_parameters = type_parameters
        self.remainder = remainder
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('HeaderNameParse', [runtime.struct_field('name', self.name), runtime.struct_field('type_parameters', self.type_parameters), runtime.struct_field('remainder', self.remainder), runtime.struct_field('diagnostics', self.diagnostics)])

class StructLayoutHeaderParse:
    def __init__(self, success, name, size, align, diagnostics):
        self.success = success
        self.name = name
        self.size = size
        self.align = align
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('StructLayoutHeaderParse', [runtime.struct_field('success', self.success), runtime.struct_field('name', self.name), runtime.struct_field('size', self.size), runtime.struct_field('align', self.align), runtime.struct_field('diagnostics', self.diagnostics)])

class StructLayoutFieldParse:
    def __init__(self, success, field, diagnostics):
        self.success = success
        self.field = field
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('StructLayoutFieldParse', [runtime.struct_field('success', self.success), runtime.struct_field('field', self.field), runtime.struct_field('diagnostics', self.diagnostics)])

class ParseNativeResult:
    def __init__(self, functions, imports, structs, interfaces, enums, bindings, diagnostics):
        self.functions = functions
        self.imports = imports
        self.structs = structs
        self.interfaces = interfaces
        self.enums = enums
        self.bindings = bindings
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('ParseNativeResult', [runtime.struct_field('functions', self.functions), runtime.struct_field('imports', self.imports), runtime.struct_field('structs', self.structs), runtime.struct_field('interfaces', self.interfaces), runtime.struct_field('enums', self.enums), runtime.struct_field('bindings', self.bindings), runtime.struct_field('diagnostics', self.diagnostics)])

class EnumLayoutHeaderParse:
    def __init__(self, success, name, size, align, tag_type, tag_size, tag_align, diagnostics):
        self.success = success
        self.name = name
        self.size = size
        self.align = align
        self.tag_type = tag_type
        self.tag_size = tag_size
        self.tag_align = tag_align
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('EnumLayoutHeaderParse', [runtime.struct_field('success', self.success), runtime.struct_field('name', self.name), runtime.struct_field('size', self.size), runtime.struct_field('align', self.align), runtime.struct_field('tag_type', self.tag_type), runtime.struct_field('tag_size', self.tag_size), runtime.struct_field('tag_align', self.tag_align), runtime.struct_field('diagnostics', self.diagnostics)])

class EnumLayoutVariantParse:
    def __init__(self, success, variant, diagnostics):
        self.success = success
        self.variant = variant
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('EnumLayoutVariantParse', [runtime.struct_field('success', self.success), runtime.struct_field('variant', self.variant), runtime.struct_field('diagnostics', self.diagnostics)])

class EnumLayoutPayloadParse:
    def __init__(self, success, variant_name, field, diagnostics):
        self.success = success
        self.variant_name = variant_name
        self.field = field
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('EnumLayoutPayloadParse', [runtime.struct_field('success', self.success), runtime.struct_field('variant_name', self.variant_name), runtime.struct_field('field', self.field), runtime.struct_field('diagnostics', self.diagnostics)])

class NumberParseResult:
    def __init__(self, success, value):
        self.success = success
        self.value = value

    def __repr__(self):
        return runtime.struct_repr('NumberParseResult', [runtime.struct_field('success', self.success), runtime.struct_field('value', self.value)])

class LayoutManifest:
    def __init__(self, structs, enums, diagnostics):
        self.structs = structs
        self.enums = enums
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('LayoutManifest', [runtime.struct_field('structs', self.structs), runtime.struct_field('enums', self.enums), runtime.struct_field('diagnostics', self.diagnostics)])

class BindingComponents:
    def __init__(self, name, type_annotation, value=None):
        self.name = name
        self.type_annotation = type_annotation
        self.value = value

    def __repr__(self):
        return runtime.struct_repr('BindingComponents', [runtime.struct_field('name', self.name), runtime.struct_field('type_annotation', self.type_annotation), runtime.struct_field('value', self.value)])

def select_text_artifact(artifacts):
    index = 0
    while True:
        if index >= len(artifacts):
            break
        artifact = artifacts[index]
        if artifact.format == "sailfin-native-text":
            return artifact
        index += 1
    return None

def select_layout_manifest_artifact(artifacts):
    index = 0
    while True:
        if index >= len(artifacts):
            break
        artifact = artifacts[index]
        if artifact.format == "sailfin-layout-manifest":
            return artifact
        index += 1
    return None

def parse_native_artifact(text):
    lines = split_lines(text)
    diagnostics = []
    functions = []
    imports = []
    structs = []
    interfaces = []
    enums = []
    bindings = []
    current = None
    pending_span = None
    pending_value_span = None
    index = 0
    while True:
        if index >= len(lines):
            break
        raw_line = lines[index]
        line = trim_text(raw_line)
        if len(line) == 0:
            index += 1
            continue
        if starts_with(line, ";"):
            index += 1
            continue
        if starts_with(line, ".module "):
            index += 1
            continue
        if starts_with(line, ".import "):
            parsed_import = parse_import_entry("import", strip_prefix(line, ".import "))
            if parsed_import == None:
                diagnostics = append_string(diagnostics, "unable to parse import: " + line)
            else:
                imports = append_import(imports, parsed_import)
            index += 1
            continue
        if starts_with(line, ".export "):
            parsed_export = parse_import_entry("export", strip_prefix(line, ".export "))
            if parsed_export == None:
                diagnostics = append_string(diagnostics, "unable to parse export: " + line)
            else:
                imports = append_import(imports, parsed_export)
            index += 1
            continue
        if starts_with(line, ".span "):
            parsed_span = parse_source_span(strip_prefix(line, ".span "))
            if parsed_span == None:
                diagnostics = append_string(diagnostics, "unable to parse span metadata: " + line)
            else:
                pending_span = parsed_span
            index += 1
            continue
        if starts_with(line, ".init-span "):
            parsed_init_span = parse_source_span(strip_prefix(line, ".init-span "))
            if parsed_init_span == None:
                diagnostics = append_string(diagnostics, "unable to parse initializer span metadata: " + line)
            else:
                pending_value_span = parsed_init_span
            index += 1
            continue
        if starts_with(line, ".struct "):
            struct_result = parse_struct_definition(lines, index)
            diagnostics = (diagnostics) + (struct_result.diagnostics)
            if struct_result.definition != None:
                structs = append_struct(structs, struct_result.definition)
            index = struct_result.next_index
            continue
        if starts_with(line, ".interface "):
            interface_result = parse_interface_definition(lines, index)
            diagnostics = (diagnostics) + (interface_result.diagnostics)
            if interface_result.definition != None:
                interfaces = append_interface(interfaces, interface_result.definition)
            index = interface_result.next_index
            continue
        if starts_with(line, ".enum "):
            enum_result = parse_enum_definition(lines, index)
            diagnostics = (diagnostics) + (enum_result.diagnostics)
            if enum_result.definition != None:
                enums = append_enum(enums, enum_result.definition)
            index = enum_result.next_index
            continue
        if starts_with(line, ".fn "):
            if current != None:
                diagnostics = append_string(diagnostics, "encountered nested .fn while previous function still open")
            current = NativeFunction(name=parse_function_name(strip_prefix(line, ".fn ")), parameters=[], return_type="void", effects=[], instructions=[])
            index += 1
            continue
        if starts_with(line, ".test "):
            if current != None:
                diagnostics = append_string(diagnostics, "encountered nested .test while previous function still open")
            header = strip_prefix(line, ".test ")
            trimmed = trim_text(header)
            if len(trimmed) == 0:
                diagnostics = append_string(diagnostics, "unable to parse test header: " + line)
                index += 1
                continue
            raw_name = ""
            if trimmed[0] == "\""  or  trimmed[0] == "'":
                quote = trimmed[0]
                scan = 1
                escaping = False
                while True:
                    if scan >= len(trimmed):
                        break
                    ch = trimmed[scan]
                    if escaping:
                        escaping = False
                        scan += 1
                        continue
                    if ch == "\\":
                        escaping = True
                        scan += 1
                        continue
                    if ch == quote:
                        raw_name = substring(trimmed, 0, scan + 1)
                        break
                    scan += 1
            else:
                space_index = index_of(trimmed, " ")
                if space_index < 0:
                    raw_name = trimmed
                else:
                    raw_name = trim_text(substring(trimmed, 0, space_index))
            name = strip_quotes(trim_text(raw_name))
            if len(name) == 0:
                diagnostics = append_string(diagnostics, "unable to parse test header: " + line)
                index += 1
                continue
            current = NativeFunction(name="test:" + name, parameters=[], return_type="void", effects=[], instructions=[])
            index += 1
            continue
        if starts_with(line, ".endfn"):
            if current == None:
                diagnostics = append_string(diagnostics, "encountered .endfn without active function")
            else:
                functions = append_function(functions, current)
                current = None
            index += 1
            continue
        if starts_with(line, ".endtest"):
            if current == None:
                diagnostics = append_string(diagnostics, "encountered .endtest without active test")
            else:
                functions = append_function(functions, current)
                current = None
            index += 1
            continue
        if starts_with(line, ".meta "):
            if current != None:
                current = apply_meta(current, strip_prefix(line, ".meta "))
            else:
                diagnostics = append_string(diagnostics, "metadata outside function body: " + line)
            index += 1
            continue
        if starts_with(line, ".param "):
            if current != None:
                combined = strip_prefix(line, ".param ")
                lookahead = index + 1
                while True:
                    if lookahead >= len(lines):
                        break
                    continuation_raw = lines[lookahead]
                    if len(continuation_raw) == 0:
                        break
                    continuation_trimmed = trim_text(continuation_raw)
                    if len(continuation_trimmed) == 0:
                        lookahead += 1
                        continue
                    if not line_looks_like_parameter_entry(continuation_trimmed):
                        break
                    combined = combined + " " + continuation_trimmed
                    lookahead += 1
                entries = split_parameter_entries(combined)
                if len(entries) == 0:
                    diagnostics = append_string(diagnostics, "unable to parse parameter line: " + line)
                    pending_span = None
                else:
                    entry_index = 0
                    span_consumed = False
                    while True:
                        if entry_index >= len(entries):
                            break
                        entry = entries[entry_index]
                        parameter_span = pending_span
                        if span_consumed:
                            parameter_span = None
                        parameter = parse_parameter_entry(entry, parameter_span)
                        if parameter == None:
                            diagnostics = append_string(diagnostics, "unable to parse parameter entry: " + entry)
                        else:
                            current = append_parameter(current, parameter)
                            if parameter.span != None:
                                span_consumed = True
                        entry_index += 1
                    pending_span = None
                index = lookahead - 1
            else:
                diagnostics = append_string(diagnostics, "parameter outside function body: " + line)
            index += 1
            continue
        gather = gather_instruction(lines, index)
        line = gather.text
        index += gather.lines_consumed
        instruction_result = parse_instruction(line, pending_span, pending_value_span)
        instructions = instruction_result.instructions
        if instruction_result.span_consumed:
            pending_span = None
        else:
            if pending_span != None:
                diagnostics = append_string(diagnostics, "unused span metadata before: " + line)
                pending_span = None
        if instruction_result.value_span_consumed:
            pending_value_span = None
        else:
            if pending_value_span != None:
                diagnostics = append_string(diagnostics, "unused initializer span metadata before: " + line)
                pending_value_span = None
        if current == None:
            if len(instructions) == 1  and  instructions[0].variant == "Let":
                bindings = append_binding(bindings, binding_from_instruction(instructions[0]))
            else:
                diagnostics = append_string(diagnostics, "top-level directive not supported in lowering: " + line)
            index += 1
            continue
        instruction_index = 0
        while True:
            if instruction_index >= len(instructions):
                break
            current = append_instruction(current, instructions[instruction_index])
            instruction_index += 1
        index += 1
    if current != None:
        diagnostics = append_string(diagnostics, "unterminated function at end of artifact")
    return ParseNativeResult(functions=functions, imports=imports, structs=structs, interfaces=interfaces, enums=enums, bindings=bindings, diagnostics=diagnostics)

def parse_source_span(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return None
    parts = split_whitespace(trimmed)
    if len(parts) != 4:
        return None
    start_line = parse_decimal_number(parts[0])
    if not start_line.success:
        return None
    start_column = parse_decimal_number(parts[1])
    if not start_column.success:
        return None
    end_line = parse_decimal_number(parts[2])
    if not end_line.success:
        return None
    end_column = parse_decimal_number(parts[3])
    if not end_column.success:
        return None
    return NativeSourceSpan(start_line=start_line.value, start_column=start_column.value, end_line=end_line.value, end_column=end_column.value)

def append_function(functions, value):
    return (functions) + ([value])

def append_binding(bindings, value):
    return (bindings) + ([value])

def append_import(imports, value):
    return (imports) + ([value])

def append_struct(structs, value):
    return (structs) + ([value])

def append_interface(interfaces, value):
    return (interfaces) + ([value])

def append_enum(enums, value):
    return (enums) + ([value])

def append_enum_variant(variants, value):
    return (variants) + ([value])

def append_enum_variant_field(fields, value):
    return (fields) + ([value])

def append_struct_field(fields, field):
    return (fields) + ([field])

def append_struct_layout_field(fields, field):
    return (fields) + ([field])

def append_enum_variant_layout(variants, value):
    return (variants) + ([value])

def find_enum_variant_layout(variants, name):
    index = 0
    while True:
        if index >= len(variants):
            break
        if variants[index].name == name:
            return index
        index += 1
    return -1

def update_enum_variant_fields(variants, index, field):
    result = []
    current_index = 0
    while True:
        if current_index >= len(variants):
            break
        if current_index == index:
            variant = variants[current_index]
            updated = NativeEnumVariantLayout(name=variant.name, tag=variant.tag, offset=variant.offset, size=variant.size, align=variant.align, fields=append_struct_layout_field(variant.fields, field))
            result = append_enum_variant_layout(result, updated)
        else:
            result = append_enum_variant_layout(result, variants[current_index])
        current_index += 1
    return result

def append_parameter(function, parameter):
    parameters = append_parameter_array(function.parameters, parameter)
    return NativeFunction(name=function.name, parameters=parameters, return_type=function.return_type, effects=function.effects, instructions=function.instructions)

def append_instruction(function, instruction):
    instructions = (function.instructions) + ([instruction])
    return NativeFunction(name=function.name, parameters=function.parameters, return_type=function.return_type, effects=function.effects, instructions=instructions)

def binding_from_instruction(instruction):
    return NativeBinding(name=instruction.name, mutable=instruction.mutable, type_annotation=instruction.type_annotation, value=instruction.value)

def apply_meta(function, entry):
    trimmed = trim_text(entry)
    if starts_with(trimmed, "return "):
        return_type = trim_text(strip_prefix(trimmed, "return "))
        return update_function_meta(function, return_type, function.effects)
    if starts_with(trimmed, "effects "):
        list = trim_text(strip_prefix(trimmed, "effects "))
        effects = parse_effect_list(list)
        return update_function_meta(function, function.return_type, effects)
    return function

def update_function_meta(function, return_type, effects):
    return NativeFunction(name=function.name, parameters=function.parameters, return_type=return_type, effects=effects, instructions=function.instructions)

def gather_instruction(lines, start_index):
    if start_index >= len(lines):
        return InstructionGatherResult(text="", lines_consumed=0)
    first_line = trim_text(lines[start_index])
    if len(first_line) == 0:
        return InstructionGatherResult(text=first_line, lines_consumed=0)
    if not instruction_supports_multiline(first_line):
        return InstructionGatherResult(text=first_line, lines_consumed=0)
    state = update_instruction_depth_state(initial_instruction_depth_state(), first_line)
    if not instruction_requires_continuation(state):
        return InstructionGatherResult(text=first_line, lines_consumed=0)
    combined = first_line
    consumed = 0
    index = start_index + 1
    while True:
        if index >= len(lines):
            break
        continuation = trim_text(lines[index])
        if len(continuation) == 0:
            combined = combined + "\n"
        else:
            combined = combined + "\n" + continuation
            state = update_instruction_depth_state(state, continuation)
        consumed += 1
        index += 1
        if not instruction_requires_continuation(state):
            break
    normalized = trim_text(combined)
    return InstructionGatherResult(text=normalized, lines_consumed=consumed)

def instruction_supports_multiline(line):
    if starts_with(line, "eval "):
        return True
    if starts_with(line, "ret "):
        return True
    return False

def instruction_requires_continuation(state):
    if state.in_string:
        return True
    if state.paren_depth > 0:
        return True
    if state.bracket_depth > 0:
        return True
    if state.brace_depth > 0:
        return True
    return False

def initial_instruction_depth_state():
    return InstructionDepthState(paren_depth=0, bracket_depth=0, brace_depth=0, in_string=False, escaping=False)

def update_instruction_depth_state(state, text):
    paren_depth = state.paren_depth
    bracket_depth = state.bracket_depth
    brace_depth = state.brace_depth
    in_string = state.in_string
    escaping = state.escaping
    index = 0
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if in_string:
            if escaping:
                escaping = False
                index += 1
                continue
            if ch == "\\":
                escaping = True
                index += 1
                continue
            if ch == "\"":
                in_string = False
            index += 1
            continue
        if ch == "\"":
            in_string = True
            index += 1
            continue
        if ch == "(":
            paren_depth += 1
            index += 1
            continue
        if ch == ")":
            if paren_depth > 0:
                paren_depth -= 1
            index += 1
            continue
        if ch == "[":
            bracket_depth += 1
            index += 1
            continue
        if ch == "]":
            if bracket_depth > 0:
                bracket_depth -= 1
            index += 1
            continue
        if ch == "{":
            brace_depth += 1
            index += 1
            continue
        if ch == "}":
            if brace_depth > 0:
                brace_depth -= 1
            index += 1
            continue
        index += 1
    return InstructionDepthState(paren_depth=paren_depth, bracket_depth=bracket_depth, brace_depth=brace_depth, in_string=in_string, escaping=escaping)

def parse_instruction(line, span, value_span):
    if line == "noop":
        return InstructionParseResult(instructions=[NativeInstruction.Noop()], span_consumed=False, value_span_consumed=False)
    if starts_with(line, ".if "):
        condition = trim_text(strip_prefix(line, ".if "))
        return InstructionParseResult(instructions=[runtime.enum_instantiate(NativeInstruction, 'If', [runtime.enum_field('condition', condition)])], span_consumed=False, value_span_consumed=False)
    if line == ".else":
        return InstructionParseResult(instructions=[NativeInstruction.Else()], span_consumed=False, value_span_consumed=False)
    if line == ".endif":
        return InstructionParseResult(instructions=[NativeInstruction.EndIf()], span_consumed=False, value_span_consumed=False)
    if starts_with(line, ".for "):
        body = trim_text(strip_prefix(line, ".for "))
        separator = " in "
        index = index_of(body, separator)
        if index >= 0:
            target = trim_text(substring(body, 0, index))
            iterable = trim_text(substring(body, index + len(separator), len(body)))
            return InstructionParseResult(instructions=[runtime.enum_instantiate(NativeInstruction, 'For', [runtime.enum_field('target', target), runtime.enum_field('iterable', iterable)])], span_consumed=False, value_span_consumed=False)
    if line == ".endfor":
        return InstructionParseResult(instructions=[NativeInstruction.EndFor()], span_consumed=False, value_span_consumed=False)
    if line == ".loop":
        return InstructionParseResult(instructions=[NativeInstruction.Loop()], span_consumed=False, value_span_consumed=False)
    if line == ".endloop":
        return InstructionParseResult(instructions=[NativeInstruction.EndLoop()], span_consumed=False, value_span_consumed=False)
    if line == "break":
        return InstructionParseResult(instructions=[NativeInstruction.Break()], span_consumed=False, value_span_consumed=False)
    if line == "continue":
        return InstructionParseResult(instructions=[NativeInstruction.Continue()], span_consumed=False, value_span_consumed=False)
    if starts_with(line, ".match "):
        expression = trim_text(strip_prefix(line, ".match "))
        return InstructionParseResult(instructions=[runtime.enum_instantiate(NativeInstruction, 'Match', [runtime.enum_field('expression', expression)])], span_consumed=False, value_span_consumed=False)
    if starts_with(line, ".case "):
        return InstructionParseResult(instructions=[parse_case_instruction(line)], span_consumed=False, value_span_consumed=False)
    if line == ".endmatch":
        return InstructionParseResult(instructions=[NativeInstruction.EndMatch()], span_consumed=False, value_span_consumed=False)
    if starts_with(line, ".let "):
        return InstructionParseResult(instructions=[parse_let_instruction(line, span, value_span)], span_consumed=True, value_span_consumed=True)
    if starts_with(line, ".return"):
        remainder = trim_text(strip_prefix(line, ".return"))
        expression = ""
        if len(remainder) > 0:
            expression = trim_trailing_delimiters(remainder)
        return InstructionParseResult(instructions=[runtime.enum_instantiate(NativeInstruction, 'Return', [runtime.enum_field('expression', expression), runtime.enum_field('span', span)])], span_consumed=True, value_span_consumed=False)
    if starts_with(line, "ret"):
        if len(line) == 3:
            return InstructionParseResult(instructions=[runtime.enum_instantiate(NativeInstruction, 'Return', [runtime.enum_field('expression', ""), runtime.enum_field('span', span)])], span_consumed=True, value_span_consumed=False)
        separator = line[3]
        if separator == " "  or  separator == "\t":
            remainder = trim_text(substring(line, 3, len(line)))
            if len(remainder) == 0:
                return InstructionParseResult(instructions=[runtime.enum_instantiate(NativeInstruction, 'Return', [runtime.enum_field('expression', ""), runtime.enum_field('span', span)])], span_consumed=True, value_span_consumed=False)
            return InstructionParseResult(instructions=[runtime.enum_instantiate(NativeInstruction, 'Return', [runtime.enum_field('expression', trim_trailing_delimiters(remainder)), runtime.enum_field('span', span)])], span_consumed=True, value_span_consumed=False)
    if starts_with(line, "eval let "):
        body = trim_text(strip_prefix(line, "eval let "))
        is_mutable = False
        if starts_with(body, "mut "):
            is_mutable = True
            body = trim_text(strip_prefix(body, "mut "))
        parsed = parse_binding_components(body)
        return InstructionParseResult(instructions=[runtime.enum_instantiate(NativeInstruction, 'Let', [runtime.enum_field('name', parsed.name), runtime.enum_field('mutable', is_mutable), runtime.enum_field('type_annotation', parsed.type_annotation), runtime.enum_field('value', maybe_trim_trailing(parsed.value)), runtime.enum_field('span', span), runtime.enum_field('value_span', value_span)])], span_consumed=True, value_span_consumed=True)
    if starts_with(line, "eval "):
        return InstructionParseResult(instructions=[runtime.enum_instantiate(NativeInstruction, 'Expression', [runtime.enum_field('expression', trim_trailing_delimiters(trim_text(strip_prefix(line, "eval ")))), runtime.enum_field('span', span)])], span_consumed=True, value_span_consumed=False)
    if index_of(line, "=>") >= 0:
        return InstructionParseResult(instructions=parse_inline_case_instruction(line), span_consumed=False, value_span_consumed=False)
    return InstructionParseResult(instructions=[runtime.enum_instantiate(NativeInstruction, 'Unknown', [runtime.enum_field('text', line)])], span_consumed=False, value_span_consumed=False)

def parse_case_instruction(line):
    body = trim_text(strip_prefix(line, ".case "))
    split = split_case_components(body)
    return runtime.enum_instantiate(NativeInstruction, 'Case', [runtime.enum_field('pattern', split.pattern), runtime.enum_field('guard', split.guard)])

def parse_inline_case_instruction(line):
    trimmed = trim_trailing_delimiters(trim_text(line))
    arrow_index = index_of(trimmed, "=>")
    if arrow_index < 0:
        return [runtime.enum_instantiate(NativeInstruction, 'Unknown', [runtime.enum_field('text', line)])]
    head = trim_text(substring(trimmed, 0, arrow_index))
    remainder = trim_trailing_delimiters(trim_text(substring(trimmed, arrow_index + 2, len(trimmed))))
    split = split_case_components(head)
    instructions = []
    instructions = (instructions) + ([runtime.enum_instantiate(NativeInstruction, 'Case', [runtime.enum_field('pattern', split.pattern), runtime.enum_field('guard', split.guard)])])
    if len(remainder) == 0:
        instructions = (instructions) + ([NativeInstruction.Noop()])
        return instructions
    body_instruction = parse_inline_case_body_instruction(remainder)
    instructions = (instructions) + ([body_instruction])
    return instructions

def parse_inline_case_body_instruction(body):
    lowered = trim_trailing_delimiters(body)
    if starts_with(lowered, "return "):
        value = trim_trailing_delimiters(trim_text(strip_prefix(lowered, "return ")))
        return runtime.enum_instantiate(NativeInstruction, 'Return', [runtime.enum_field('expression', value), runtime.enum_field('span', None)])
    if starts_with(lowered, "eval "):
        return runtime.enum_instantiate(NativeInstruction, 'Expression', [runtime.enum_field('expression', trim_trailing_delimiters(trim_text(strip_prefix(lowered, "eval ")))), runtime.enum_field('span', None)])
    return runtime.enum_instantiate(NativeInstruction, 'Expression', [runtime.enum_field('expression', lowered), runtime.enum_field('span', None)])

def split_case_components(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return CaseComponents(pattern=trimmed, guard=None)
    separator = " if "
    index = last_index_of(trimmed, separator)
    if index < 0:
        return CaseComponents(pattern=trimmed, guard=None)
    pattern = trim_text(substring(trimmed, 0, index))
    guard_text = trim_text(substring(trimmed, index + len(separator), len(trimmed)))
    if len(guard_text) == 0:
        return CaseComponents(pattern=pattern, guard=None)
    return CaseComponents(pattern=pattern, guard=guard_text)

def parse_import_entry(kind, entry):
    trimmed = trim_text(entry)
    if len(trimmed) == 0:
        return None
    module_text = trimmed
    specifiers = []
    brace_index = index_of(trimmed, "{")
    if brace_index >= 0:
        close_index = last_index_of(trimmed, "}")
        if close_index < 0  or  close_index <= brace_index:
            return None
        module_text = trim_text(substring(trimmed, 0, brace_index))
        names_segment = substring(trimmed, brace_index + 1, close_index)
        specifiers = parse_import_specifiers(names_segment)
    module_text = strip_quotes(trim_text(module_text))
    return NativeImport(kind=kind, module=module_text, specifiers=specifiers)

def parse_import_specifiers(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return []
    entries = split_comma_separated(trimmed)
    specifiers = []
    index = 0
    while True:
        if index >= len(entries):
            break
        parsed = parse_single_specifier(entries[index])
        if len(parsed.name) > 0:
            specifiers = (specifiers) + ([parsed])
        index += 1
    return specifiers

def parse_single_specifier(entry):
    trimmed = trim_text(entry)
    if len(trimmed) == 0:
        return NativeImportSpecifier(name="", alias=None)
    separator = " as "
    index = index_of(trimmed, separator)
    if index < 0:
        return NativeImportSpecifier(name=trimmed, alias=None)
    name = trim_text(substring(trimmed, 0, index))
    alias_text = trim_text(substring(trimmed, index + len(separator), len(trimmed)))
    if len(alias_text) == 0:
        return NativeImportSpecifier(name=name, alias=None)
    return NativeImportSpecifier(name=name, alias=alias_text)

def parse_struct_definition(lines, start_index):
    diagnostics = []
    header = trim_text(lines[start_index])
    name_text = trim_text(strip_prefix(header, ".struct "))
    header_parse = parse_struct_header(name_text)
    diagnostics = (diagnostics) + (header_parse.diagnostics)
    struct_name = header_parse.name
    implements = header_parse.implements
    if len(struct_name) == 0:
        diagnostics = append_string(diagnostics, "unable to parse struct header: " + header)
        return StructParseResult(definition=None, next_index=start_index + 1, diagnostics=diagnostics)
    fields = []
    methods = []
    current_method = None
    method_pending_span = None
    method_pending_value_span = None
    struct_layout_fields = []
    struct_layout_size = 0
    struct_layout_align = 0
    struct_layout_header_success = False
    struct_layout_reported_missing_header = False
    index = start_index + 1
    while True:
        if index >= len(lines):
            diagnostics = append_string(diagnostics, "unterminated struct " + struct_name)
            struct_layout_value = None
            if struct_layout_header_success:
                struct_layout_value = NativeStructLayout(size=struct_layout_size, align=struct_layout_align, fields=struct_layout_fields)
            return StructParseResult(definition=NativeStruct(name=struct_name, fields=fields, methods=methods, implements=implements, layout=struct_layout_value), next_index=index, diagnostics=diagnostics)
        raw_line = trim_text(lines[index])
        if len(raw_line) == 0  or  starts_with(raw_line, ";"):
            index += 1
            continue
        if raw_line == ".endstruct":
            if current_method != None:
                diagnostics = append_string(diagnostics, "unterminated method in struct " + struct_name)
                methods = append_function(methods, current_method)
                current_method = None
                method_pending_span = None
                method_pending_value_span = None
            index += 1
            break
        if current_method != None:
            if raw_line == ".endmethod":
                methods = append_function(methods, current_method)
                current_method = None
                method_pending_span = None
                method_pending_value_span = None
                index += 1
                continue
            if starts_with(raw_line, ".meta "):
                current_method = apply_meta(current_method, strip_prefix(raw_line, ".meta "))
                index += 1
                continue
            if starts_with(raw_line, ".param "):
                parameter = parse_parameter_entry(strip_prefix(raw_line, ".param "), method_pending_span)
                if parameter == None:
                    diagnostics = append_string(diagnostics, "unable to parse method parameter: " + raw_line)
                else:
                    current_method = append_parameter(current_method, parameter)
                method_pending_span = None
                index += 1
                continue
            if starts_with(raw_line, ".method "):
                diagnostics = append_string(diagnostics, "nested method declaration in struct " + struct_name)
                index += 1
                continue
            if starts_with(raw_line, ".span "):
                parsed_method_span = parse_source_span(strip_prefix(raw_line, ".span "))
                if parsed_method_span == None:
                    diagnostics = append_string(diagnostics, "unable to parse span metadata: " + raw_line)
                else:
                    method_pending_span = parsed_method_span
                index += 1
                continue
            if starts_with(raw_line, ".init-span "):
                parsed_method_init_span = parse_source_span(strip_prefix(raw_line, ".init-span "))
                if parsed_method_init_span == None:
                    diagnostics = append_string(diagnostics, "unable to parse initializer span metadata: " + raw_line)
                else:
                    method_pending_value_span = parsed_method_init_span
                index += 1
                continue
            method_instruction_result = parse_instruction(raw_line, method_pending_span, method_pending_value_span)
            if method_instruction_result.span_consumed:
                method_pending_span = None
            else:
                if method_pending_span != None:
                    diagnostics = append_string(diagnostics, "unused span metadata before: " + raw_line)
                    method_pending_span = None
            if method_instruction_result.value_span_consumed:
                method_pending_value_span = None
            else:
                if method_pending_value_span != None:
                    diagnostics = append_string(diagnostics, "unused initializer span metadata before: " + raw_line)
                    method_pending_value_span = None
            instruction_index = 0
            while True:
                if instruction_index >= len(method_instruction_result.instructions):
                    break
                current_method = append_instruction(current_method, method_instruction_result.instructions[instruction_index])
                instruction_index += 1
            index += 1
            continue
        if starts_with(raw_line, ".layout "):
            body = strip_prefix(raw_line, ".layout ")
            if starts_with(body, "struct "):
                header_result = parse_struct_layout_header(strip_prefix(body, "struct "))
                diagnostics = (diagnostics) + (header_result.diagnostics)
                if header_result.success:
                    if struct_layout_header_success:
                        diagnostics = append_string(diagnostics, "duplicate struct layout header in " + struct_name)
                    else:
                        struct_layout_size = header_result.size
                        struct_layout_align = header_result.align
                        struct_layout_header_success = True
                index += 1
                continue
            if starts_with(body, "field "):
                tail = trim_text(strip_prefix(body, "field "))
                is_struct_header = False
                if starts_with(tail, "struct"):
                    if len(tail) == 6:
                        is_struct_header = True
                    else:
                        if len(tail) > 6:
                            after = tail[6]
                            if is_trim_char(after):
                                is_struct_header = True
                if is_struct_header:
                    header_text = trim_text(strip_prefix(tail, "struct"))
                    header_result = parse_struct_layout_header(header_text)
                    diagnostics = (diagnostics) + (header_result.diagnostics)
                    if header_result.success:
                        if struct_layout_header_success:
                            diagnostics = append_string(diagnostics, "duplicate struct layout header in " + struct_name)
                        else:
                            struct_layout_size = header_result.size
                            struct_layout_align = header_result.align
                            struct_layout_header_success = True
                    index += 1
                    continue
                field_result = parse_struct_layout_field(tail, struct_name)
                diagnostics = (diagnostics) + (field_result.diagnostics)
                if field_result.success:
                    struct_layout_fields = append_struct_layout_field(struct_layout_fields, field_result.field)
                    if not struct_layout_header_success:
                        if not struct_layout_reported_missing_header:
                            diagnostics = append_string(diagnostics, "struct " + struct_name + " layout field encountered before layout header")
                            struct_layout_reported_missing_header = True
                index += 1
                continue
            diagnostics = append_string(diagnostics, "unsupported struct layout directive: " + raw_line)
            index += 1
            continue
        if raw_line == "noop":
            index += 1
            continue
        if starts_with(raw_line, ".field "):
            parsed_field = parse_struct_field_line(strip_prefix(raw_line, ".field "))
            if parsed_field == None:
                diagnostics = append_string(diagnostics, "unable to parse struct field: " + raw_line)
            else:
                fields = append_struct_field(fields, parsed_field)
            index += 1
            continue
        if starts_with(raw_line, ".method "):
            if current_method != None:
                diagnostics = append_string(diagnostics, "nested method declaration in struct " + struct_name)
            method_name = parse_function_name(strip_prefix(raw_line, ".method "))
            current_method = NativeFunction(name=method_name, parameters=[], return_type="void", effects=[], instructions=[])
            method_pending_span = None
            method_pending_value_span = None
            index += 1
            continue
        diagnostics = append_string(diagnostics, "unsupported struct directive: " + raw_line)
        index += 1
    struct_layout_value = None
    if struct_layout_header_success:
        struct_layout_value = NativeStructLayout(size=struct_layout_size, align=struct_layout_align, fields=struct_layout_fields)
    return StructParseResult(definition=NativeStruct(name=struct_name, fields=fields, methods=methods, implements=implements, layout=struct_layout_value), next_index=index, diagnostics=diagnostics)

def parse_interface_definition(lines, start_index):
    diagnostics = []
    header = trim_text(lines[start_index])
    name_text = trim_text(strip_prefix(header, ".interface "))
    header_parse = parse_interface_header(name_text)
    diagnostics = (diagnostics) + (header_parse.diagnostics)
    interface_name = header_parse.name
    if len(interface_name) == 0:
        diagnostics = append_string(diagnostics, "unable to parse interface header: " + header)
        return InterfaceParseResult(definition=None, next_index=start_index + 1, diagnostics=diagnostics)
    signatures = []
    index = start_index + 1
    while True:
        if index >= len(lines):
            diagnostics = append_string(diagnostics, "unterminated interface " + interface_name)
            return InterfaceParseResult(definition=NativeInterface(name=interface_name, type_parameters=header_parse.type_parameters, signatures=signatures), next_index=index, diagnostics=diagnostics)
        raw_line = trim_text(lines[index])
        if len(raw_line) == 0  or  starts_with(raw_line, ";"):
            index += 1
            continue
        if raw_line == ".endinterface":
            index += 1
            break
        if raw_line == "noop":
            index += 1
            continue
        if starts_with(raw_line, ".sig "):
            signature_parse = parse_interface_signature(strip_prefix(raw_line, ".sig "), interface_name)
            diagnostics = (diagnostics) + (signature_parse.diagnostics)
            if signature_parse.success:
                signatures = (signatures) + ([signature_parse.signature])
            index += 1
            continue
        diagnostics = append_string(diagnostics, "unsupported interface directive: " + raw_line)
        index += 1
    return InterfaceParseResult(definition=NativeInterface(name=interface_name, type_parameters=header_parse.type_parameters, signatures=signatures), next_index=index, diagnostics=diagnostics)

def parse_struct_header(text):
    base = parse_header_name_and_remainder(text)
    diagnostics = base.diagnostics
    implements = []
    if len(base.remainder) > 0:
        if starts_with(base.remainder, "implements "):
            list_text = trim_text(strip_prefix(base.remainder, "implements "))
            if len(list_text) == 0:
                diagnostics = append_string(diagnostics, "struct " + base.name + " header missing implements list")
            else:
                implements = parse_implements_list(list_text)
        else:
            diagnostics = append_string(diagnostics, "struct " + base.name + " header has unsupported segment `" + base.remainder + "`")
    return StructHeaderParse(name=base.name, implements=implements, diagnostics=diagnostics)

def parse_interface_header(text):
    base = parse_header_name_and_remainder(text)
    diagnostics = base.diagnostics
    if len(base.remainder) > 0:
        diagnostics = append_string(diagnostics, "interface " + base.name + " header has unsupported segment `" + base.remainder + "`")
    return InterfaceHeaderParse(name=base.name, type_parameters=base.type_parameters, diagnostics=diagnostics)

def parse_interface_signature(text, interface_name):
    diagnostics = []
    default_signature = NativeInterfaceSignature(name="", is_async=False, type_parameters=[], parameters=[], return_type="void", effects=[])
    trimmed = trim_trailing_delimiters(trim_text(text))
    if len(trimmed) == 0:
        diagnostics = append_string(diagnostics, "interface " + interface_name + " signature missing content")
        return InterfaceSignatureParse(success=False, signature=default_signature, diagnostics=diagnostics)
    remainder = trimmed
    is_async = False
    if starts_with(remainder, "async "):
        is_async = True
        remainder = trim_text(strip_prefix(remainder, "async "))
    paren_index = index_of(remainder, "(")
    if paren_index < 0:
        diagnostics = append_string(diagnostics, "interface " + interface_name + " signature missing parameter list: " + trimmed)
        return InterfaceSignatureParse(success=False, signature=default_signature, diagnostics=diagnostics)
    close_index = find_matching_paren(remainder, paren_index)
    if close_index < 0:
        diagnostics = append_string(diagnostics, "interface " + interface_name + " signature has unterminated parameter list: " + trimmed)
        return InterfaceSignatureParse(success=False, signature=default_signature, diagnostics=diagnostics)
    head = trim_text(substring(remainder, 0, paren_index))
    name_parse = parse_header_name_and_remainder(head)
    diagnostics = (diagnostics) + (name_parse.diagnostics)
    if len(name_parse.remainder) > 0:
        diagnostics = append_string(diagnostics, "interface " + interface_name + " signature `" + trimmed + "` has unsupported segment `" + name_parse.remainder + "`")
    method_name = name_parse.name
    if len(method_name) == 0:
        diagnostics = append_string(diagnostics, "interface " + interface_name + " signature `" + trimmed + "` missing name")
    parameters_section = substring(remainder, paren_index + 1, close_index)
    parameters = []
    parameter_text = trim_text(parameters_section)
    if len(parameter_text) > 0:
        entries = split_parameter_entries(parameter_text)
        entry_index = 0
        while True:
            if entry_index >= len(entries):
                break
            parsed = parse_parameter_entry(entries[entry_index], None)
            if parsed == None:
                diagnostics = append_string(diagnostics, "interface " + interface_name + " signature `" + method_name + "` has invalid parameter `" + entries[entry_index] + "`")
            else:
                parameters = append_parameter_array(parameters, parsed)
            entry_index += 1
    return_type = "void"
    effects = []
    suffix = trim_text(substring(remainder, close_index + 1, len(remainder)))
    if len(suffix) > 0:
        effect_index = index_of(suffix, "![")
        effect_segment = ""
        if effect_index >= 0:
            effect_segment = trim_text(substring(suffix, effect_index, len(suffix)))
            suffix = trim_text(substring(suffix, 0, effect_index))
        if len(suffix) > 0:
            if starts_with(suffix, "->"):
                type_text = trim_text(strip_prefix(suffix, "->"))
                if len(type_text) > 0:
                    return_type = type_text
            else:
                diagnostics = append_string(diagnostics, "interface " + interface_name + " signature `" + method_name + "` has unsupported suffix `" + suffix + "`")
        if len(effect_segment) > 0:
            if starts_with(effect_segment, "![")  and  effect_segment[len(effect_segment) - 1] == "]":
                body = substring(effect_segment, 2, len(effect_segment) - 1)
                effects = parse_effect_list(body)
            else:
                diagnostics = append_string(diagnostics, "interface " + interface_name + " signature `" + method_name + "` has invalid effects annotation `" + effect_segment + "`")
    signature = NativeInterfaceSignature(name=method_name, is_async=is_async, type_parameters=name_parse.type_parameters, parameters=parameters, return_type=return_type, effects=effects)
    success = len(method_name) > 0  and  len(diagnostics) == 0
    return InterfaceSignatureParse(success=success, signature=signature, diagnostics=diagnostics)

def parse_header_name_and_remainder(text):
    diagnostics = []
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return HeaderNameParse(name="", type_parameters=[], remainder="", diagnostics=diagnostics)
    name = trimmed
    remainder = ""
    type_parameters = []
    generics_index = index_of(trimmed, "<")
    if generics_index >= 0:
        close_index = find_matching_angle(trimmed, generics_index)
        if close_index < 0:
            diagnostics = append_string(diagnostics, "header `" + text + "` missing closing `>`")
            name = strip_generics(trimmed)
            return HeaderNameParse(name=name, type_parameters=type_parameters, remainder=remainder, diagnostics=diagnostics)
        name = trim_text(substring(trimmed, 0, generics_index))
        generics_text = substring(trimmed, generics_index + 1, close_index)
        type_parameters = parse_type_parameter_entries(generics_text)
        remainder = trim_text(substring(trimmed, close_index + 1, len(trimmed)))
    else:
        space_index = index_of(trimmed, " ")
        if space_index >= 0:
            name = trim_text(substring(trimmed, 0, space_index))
            remainder = trim_text(substring(trimmed, space_index + 1, len(trimmed)))
    name = strip_generics(name)
    return HeaderNameParse(name=name, type_parameters=type_parameters, remainder=remainder, diagnostics=diagnostics)

def parse_type_parameter_entries(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return []
    return split_top_level_commas(trimmed)

def parse_implements_list(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return []
    return split_top_level_commas(trimmed)

def split_top_level_commas(text):
    entries = []
    current = ""
    index = 0
    quote = ""
    angle_depth = 0
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if len(quote) > 0:
            current = current + ch
            if ch == "\\":
                if index + 1 < len(text):
                    current = current + text[index + 1]
                    index += 2
                    continue
            if ch == quote:
                quote = ""
            index += 1
            continue
        if ch == "\""  or  ch == "'":
            quote = ch
            current = current + ch
            index += 1
            continue
        if ch == "<":
            angle_depth += 1
            current = current + ch
            index += 1
            continue
        if ch == ">":
            if angle_depth > 0:
                angle_depth -= 1
            current = current + ch
            index += 1
            continue
        if ch == "(":
            paren_depth += 1
            current = current + ch
            index += 1
            continue
        if ch == ")":
            if paren_depth > 0:
                paren_depth -= 1
            current = current + ch
            index += 1
            continue
        if ch == "[":
            bracket_depth += 1
            current = current + ch
            index += 1
            continue
        if ch == "]":
            if bracket_depth > 0:
                bracket_depth -= 1
            current = current + ch
            index += 1
            continue
        if ch == "{":
            brace_depth += 1
            current = current + ch
            index += 1
            continue
        if ch == "}":
            if brace_depth > 0:
                brace_depth -= 1
            current = current + ch
            index += 1
            continue
        if ch == ",":
            if angle_depth == 0  and  paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0:
                segment = trim_text(current)
                if len(segment) > 0:
                    entries = append_string(entries, segment)
                current = ""
                index += 1
                continue
        current = current + ch
        index += 1
    segment = trim_text(current)
    if len(segment) > 0:
        entries = append_string(entries, segment)
    return entries

def find_matching_angle(text, start_index):
    depth = 0
    index = start_index
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if ch == "<":
            depth += 1
        else:
            if ch == ">":
                if depth > 0:
                    depth -= 1
                    if depth == 0:
                        return index
                else:
                    return index
        index += 1
    return -1

def find_matching_paren(text, start_index):
    depth = 0
    index = start_index
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if ch == "\""  or  ch == "'":
            lookahead = index + 1
            while True:
                if lookahead >= len(text):
                    return -1
                current = text[lookahead]
                if current == "\\":
                    lookahead += 2
                    continue
                if current == ch:
                    index = lookahead
                    break
                lookahead += 1
        else:
            if ch == "(":
                depth += 1
            else:
                if ch == ")":
                    if depth > 0:
                        depth -= 1
                        if depth == 0:
                            return index
                    else:
                        return -1
        index += 1
    return -1

def parse_enum_definition(lines, start_index):
    diagnostics = []
    header = trim_text(lines[start_index])
    name_text = trim_text(strip_prefix(header, ".enum "))
    enum_name = name_text
    space_index = index_of(enum_name, " ")
    if space_index >= 0:
        enum_name = trim_text(substring(enum_name, 0, space_index))
    enum_name = strip_generics(enum_name)
    if len(enum_name) == 0:
        diagnostics = append_string(diagnostics, "unable to parse enum header: " + header)
        return EnumParseResult(definition=None, next_index=start_index + 1, diagnostics=diagnostics)
    variants = []
    enum_layout_variants = []
    enum_layout_size = 0
    enum_layout_align = 0
    enum_layout_tag_type = ""
    enum_layout_tag_size = 0
    enum_layout_tag_align = 0
    enum_layout_header_success = False
    enum_layout_reported_missing_header = False
    index = start_index + 1
    while True:
        if index >= len(lines):
            diagnostics = append_string(diagnostics, "unterminated enum " + enum_name)
            enum_layout_value = None
            if enum_layout_header_success:
                enum_layout_value = NativeEnumLayout(size=enum_layout_size, align=enum_layout_align, tag_type=enum_layout_tag_type, tag_size=enum_layout_tag_size, tag_align=enum_layout_tag_align, variants=enum_layout_variants)
            return EnumParseResult(definition=NativeEnum(name=enum_name, variants=variants, layout=enum_layout_value), next_index=index, diagnostics=diagnostics)
        raw_line = trim_text(lines[index])
        if len(raw_line) == 0  or  starts_with(raw_line, ";"):
            index += 1
            continue
        if raw_line == "noop":
            index += 1
            continue
        if starts_with(raw_line, ".layout "):
            body = strip_prefix(raw_line, ".layout ")
            if starts_with(body, "enum "):
                header_result = parse_enum_layout_header(strip_prefix(body, "enum "))
                diagnostics = (diagnostics) + (header_result.diagnostics)
                if header_result.success:
                    if enum_layout_header_success:
                        diagnostics = append_string(diagnostics, "duplicate enum layout header in " + enum_name)
                    else:
                        enum_layout_size = header_result.size
                        enum_layout_align = header_result.align
                        enum_layout_tag_type = header_result.tag_type
                        enum_layout_tag_size = header_result.tag_size
                        enum_layout_tag_align = header_result.tag_align
                        enum_layout_header_success = True
                index += 1
                continue
            if starts_with(body, "variant "):
                variant_text = strip_prefix(body, "variant ")
                if starts_with(variant_text, "enum "):
                    header_result = parse_enum_layout_header(strip_prefix(variant_text, "enum "))
                    if header_result.success:
                        if not enum_layout_header_success:
                            enum_layout_size = header_result.size
                            enum_layout_align = header_result.align
                            enum_layout_tag_type = header_result.tag_type
                            enum_layout_tag_size = header_result.tag_size
                            enum_layout_tag_align = header_result.tag_align
                            enum_layout_header_success = True
                        index += 1
                        continue
                variant_result = parse_enum_variant_layout(variant_text, enum_name)
                diagnostics = (diagnostics) + (variant_result.diagnostics)
                if variant_result.success:
                    existing_index = find_enum_variant_layout(enum_layout_variants, variant_result.variant.name)
                    if existing_index >= 0:
                        diagnostics = append_string(diagnostics, "duplicate enum layout variant `" + variant_result.variant.name + "` in " + enum_name)
                    else:
                        enum_layout_variants = append_enum_variant_layout(enum_layout_variants, variant_result.variant)
                    if not enum_layout_header_success:
                        if not enum_layout_reported_missing_header:
                            diagnostics = append_string(diagnostics, "enum " + enum_name + " layout variant encountered before layout header")
                            enum_layout_reported_missing_header = True
                index += 1
                continue
            if starts_with(body, "payload "):
                payload_result = parse_enum_payload_layout(strip_prefix(body, "payload "), enum_name)
                diagnostics = (diagnostics) + (payload_result.diagnostics)
                if payload_result.success:
                    target_index = find_enum_variant_layout(enum_layout_variants, payload_result.variant_name)
                    if target_index < 0:
                        diagnostics = append_string(diagnostics, "enum " + enum_name + " layout payload references unknown variant `" + payload_result.variant_name + "`")
                    else:
                        enum_layout_variants = update_enum_variant_fields(enum_layout_variants, target_index, payload_result.field)
                    if not enum_layout_header_success:
                        if not enum_layout_reported_missing_header:
                            diagnostics = append_string(diagnostics, "enum " + enum_name + " layout payload encountered before layout header")
                            enum_layout_reported_missing_header = True
                index += 1
                continue
            diagnostics = append_string(diagnostics, "unsupported enum layout directive: " + raw_line)
            index += 1
            continue
        if raw_line == ".endenum":
            index += 1
            break
        if starts_with(raw_line, ".variant "):
            parsed_variant = parse_enum_variant_line(strip_prefix(raw_line, ".variant "))
            if parsed_variant == None:
                diagnostics = append_string(diagnostics, "unable to parse enum variant: " + raw_line)
            else:
                variants = append_enum_variant(variants, parsed_variant)
            index += 1
            continue
        diagnostics = append_string(diagnostics, "unsupported enum directive: " + raw_line)
        index += 1
    enum_layout_value = None
    if enum_layout_header_success:
        enum_layout_value = NativeEnumLayout(size=enum_layout_size, align=enum_layout_align, tag_type=enum_layout_tag_type, tag_size=enum_layout_tag_size, tag_align=enum_layout_tag_align, variants=enum_layout_variants)
    return EnumParseResult(definition=NativeEnum(name=enum_name, variants=variants, layout=enum_layout_value), next_index=index, diagnostics=diagnostics)

def parse_enum_variant_line(text):
    trimmed = trim_trailing_delimiters(trim_text(text))
    if len(trimmed) == 0:
        return None
    brace_index = index_of(trimmed, "{")
    if brace_index < 0:
        return NativeEnumVariant(name=strip_generics(trimmed), fields=[])
    close_index = last_index_of(trimmed, "}")
    if close_index < 0  or  close_index <= brace_index:
        return None
    name_text = strip_generics(trim_text(substring(trimmed, 0, brace_index)))
    if len(name_text) == 0:
        return None
    fields_segment = substring(trimmed, brace_index + 1, close_index)
    entries = split_enum_field_entries(fields_segment)
    fields = []
    index = 0
    while True:
        if index >= len(entries):
            break
        entry = trim_trailing_delimiters(trim_text(entries[index]))
        if len(entry) == 0:
            index += 1
            continue
        parsed_field = parse_enum_variant_field(entry)
        if parsed_field == None:
            return None
        fields = append_enum_variant_field(fields, parsed_field)
        index += 1
    return NativeEnumVariant(name=name_text, fields=fields)

def split_enum_field_entries(text):
    entries = []
    current = ""
    depth = 0
    index = 0
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if ch == "{"  or  ch == "["  or  ch == "(":
            depth += 1
        else:
            if ch == "}"  or  ch == "]"  or  ch == ")":
                if depth > 0:
                    depth -= 1
        if ch == ";"  and  depth == 0:
            entries = append_string(entries, current)
            current = ""
        else:
            current = current + ch
        index += 1
    if len(current) > 0:
        entries = append_string(entries, current)
    return entries

def parse_enum_variant_field(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return None
    is_mutable = False
    if starts_with(trimmed, "mut "):
        is_mutable = True
        trimmed = trim_text(strip_prefix(trimmed, "mut "))
    arrow_index = index_of(trimmed, "->")
    if arrow_index < 0:
        return None
    name = trim_text(substring(trimmed, 0, arrow_index))
    if len(name) == 0:
        return None
    type_text = trim_text(substring(trimmed, arrow_index + 2, len(trimmed)))
    return NativeEnumVariantField(name=name, type_annotation=type_text, mutable=is_mutable)

def text_char_at(value, index):
    if index < 0:
        return ""
    if index >= len(value):
        return ""
    return substring(value, index, index + 1)

def trim_trailing_delimiters(text):
    end = len(text)
    while True:
        if end <= 0:
            break
        ch = text_char_at(text, end - 1)
        if ch == ","  or  ch == ";":
            end -= 1
            continue
        break
    if end == len(text):
        return text
    return substring(text, 0, end)

def maybe_trim_trailing(value):
    if value == None:
        return None
    trimmed = trim_trailing_delimiters(value)
    return trimmed

def parse_struct_field_line(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return None
    is_mutable = False
    if starts_with(trimmed, "mut "):
        is_mutable = True
        trimmed = trim_text(strip_prefix(trimmed, "mut "))
    arrow_index = index_of(trimmed, "->")
    if arrow_index < 0:
        return None
    name = trim_text(substring(trimmed, 0, arrow_index))
    if len(name) == 0:
        return None
    type_text = trim_text(substring(trimmed, arrow_index + 2, len(trimmed)))
    return NativeStructField(name=name, type_annotation=type_text, mutable=is_mutable)

def parse_struct_layout_header(text):
    tokens = split_whitespace(trim_text(text))
    diagnostics = []
    if len(tokens) == 0:
        diagnostics = append_string(diagnostics, "struct layout header missing entries")
        return StructLayoutHeaderParse(success=False, name="", size=0, align=0, diagnostics=diagnostics)
    name_found = False
    size_found = False
    align_found = False
    name_value = ""
    size_value = 0
    align_value = 0
    index = 0
    while True:
        if index >= len(tokens):
            break
        token = tokens[index]
        if starts_with(token, "name="):
            name_value = substring(token, 5, len(token))
            name_found = True
        else:
            if starts_with(token, "size="):
                value_text = substring(token, 5, len(token))
                parsed = parse_decimal_number(value_text)
                if parsed.success:
                    size_found = True
                    size_value = parsed.value
                else:
                    diagnostics = append_string(diagnostics, "struct layout header has invalid size `" + value_text + "`")
            else:
                if starts_with(token, "align="):
                    value_text = substring(token, 6, len(token))
                    parsed = parse_decimal_number(value_text)
                    if parsed.success:
                        align_found = True
                        align_value = parsed.value
                    else:
                        diagnostics = append_string(diagnostics, "struct layout header has invalid align `" + value_text + "`")
                else:
                    diagnostics = append_string(diagnostics, "struct layout header unrecognized token `" + token + "`")
        index += 1
    if not size_found:
        diagnostics = append_string(diagnostics, "struct layout header missing size entry")
    if not align_found:
        diagnostics = append_string(diagnostics, "struct layout header missing align entry")
    success = size_found  and  align_found  and  len(diagnostics) == 0
    return StructLayoutHeaderParse(success=success, name=name_value, size=size_value, align=align_value, diagnostics=diagnostics)

def parse_struct_layout_field(text, struct_name):
    trimmed = trim_text(text)
    diagnostics = []
    default_field = NativeStructLayoutField(name="", type_annotation="", offset=0, size=0, align=0)
    if len(trimmed) == 0:
        diagnostics = append_string(diagnostics, "struct " + struct_name + " layout field missing content")
        return StructLayoutFieldParse(success=False, field=default_field, diagnostics=diagnostics)
    tokens = split_whitespace(trimmed)
    if len(tokens) == 0:
        diagnostics = append_string(diagnostics, "struct " + struct_name + " layout field missing entries")
        return StructLayoutFieldParse(success=False, field=default_field, diagnostics=diagnostics)
    field_name = tokens[0]
    if len(field_name) == 0:
        diagnostics = append_string(diagnostics, "struct " + struct_name + " layout field missing name")
        return StructLayoutFieldParse(success=False, field=default_field, diagnostics=diagnostics)
    type_text = ""
    offset_found = False
    size_found = False
    align_found = False
    offset_value = 0
    size_value = 0
    align_value = 0
    index = 1
    while True:
        if index >= len(tokens):
            break
        token = tokens[index]
        if starts_with(token, "type="):
            type_text = substring(token, 5, len(token))
        else:
            if starts_with(token, "offset="):
                value_text = substring(token, 7, len(token))
                parsed = parse_decimal_number(value_text)
                if parsed.success:
                    offset_found = True
                    offset_value = parsed.value
                else:
                    diagnostics = append_string(diagnostics, "struct " + struct_name + " layout field `" + field_name + "` has invalid offset `" + value_text + "`")
            else:
                if starts_with(token, "size="):
                    value_text = substring(token, 5, len(token))
                    parsed = parse_decimal_number(value_text)
                    if parsed.success:
                        size_found = True
                        size_value = parsed.value
                    else:
                        diagnostics = append_string(diagnostics, "struct " + struct_name + " layout field `" + field_name + "` has invalid size `" + value_text + "`")
                else:
                    if starts_with(token, "align="):
                        value_text = substring(token, 6, len(token))
                        parsed = parse_decimal_number(value_text)
                        if parsed.success:
                            align_found = True
                            align_value = parsed.value
                        else:
                            diagnostics = append_string(diagnostics, "struct " + struct_name + " layout field `" + field_name + "` has invalid align `" + value_text + "`")
                    else:
                        diagnostics = append_string(diagnostics, "struct " + struct_name + " layout field `" + field_name + "` unrecognized token `" + token + "`")
        index += 1
    if len(type_text) == 0:
        diagnostics = append_string(diagnostics, "struct " + struct_name + " layout field `" + field_name + "` missing type entry")
    if not offset_found:
        diagnostics = append_string(diagnostics, "struct " + struct_name + " layout field `" + field_name + "` missing offset entry")
    if not size_found:
        diagnostics = append_string(diagnostics, "struct " + struct_name + " layout field `" + field_name + "` missing size entry")
    if not align_found:
        diagnostics = append_string(diagnostics, "struct " + struct_name + " layout field `" + field_name + "` missing align entry")
    success = len(type_text) > 0  and  offset_found  and  size_found  and  align_found  and  len(diagnostics) == 0
    field = NativeStructLayoutField(name=field_name, type_annotation=type_text, offset=offset_value, size=size_value, align=align_value)
    return StructLayoutFieldParse(success=success, field=field, diagnostics=diagnostics)

def parse_enum_layout_header(text):
    tokens = split_whitespace(trim_text(text))
    diagnostics = []
    if len(tokens) == 0:
        diagnostics = append_string(diagnostics, "enum layout header missing entries")
        return EnumLayoutHeaderParse(success=False, name="", size=0, align=0, tag_type="", tag_size=0, tag_align=0, diagnostics=diagnostics)
    name_found = False
    size_found = False
    align_found = False
    name_value = ""
    tag_type = ""
    tag_size_found = False
    tag_align_found = False
    size_value = 0
    align_value = 0
    tag_size_value = 0
    tag_align_value = 0
    index = 0
    while True:
        if index >= len(tokens):
            break
        token = tokens[index]
        if starts_with(token, "name="):
            name_value = substring(token, 5, len(token))
            name_found = True
        else:
            if starts_with(token, "size="):
                value_text = substring(token, 5, len(token))
                parsed = parse_decimal_number(value_text)
                if parsed.success:
                    size_found = True
                    size_value = parsed.value
                else:
                    diagnostics = append_string(diagnostics, "enum layout header has invalid size `" + value_text + "`")
            else:
                if starts_with(token, "align="):
                    value_text = substring(token, 6, len(token))
                    parsed = parse_decimal_number(value_text)
                    if parsed.success:
                        align_found = True
                        align_value = parsed.value
                    else:
                        diagnostics = append_string(diagnostics, "enum layout header has invalid align `" + value_text + "`")
                else:
                    if starts_with(token, "tag_type="):
                        tag_type = substring(token, 9, len(token))
                    else:
                        if starts_with(token, "tag_size="):
                            value_text = substring(token, 9, len(token))
                            parsed = parse_decimal_number(value_text)
                            if parsed.success:
                                tag_size_found = True
                                tag_size_value = parsed.value
                            else:
                                diagnostics = append_string(diagnostics, "enum layout header has invalid tag_size `" + value_text + "`")
                        else:
                            if starts_with(token, "tag_align="):
                                value_text = substring(token, 10, len(token))
                                parsed = parse_decimal_number(value_text)
                                if parsed.success:
                                    tag_align_found = True
                                    tag_align_value = parsed.value
                                else:
                                    diagnostics = append_string(diagnostics, "enum layout header has invalid tag_align `" + value_text + "`")
                            else:
                                diagnostics = append_string(diagnostics, "enum layout header unrecognized token `" + token + "`")
        index += 1
    if not size_found:
        diagnostics = append_string(diagnostics, "enum layout header missing size entry")
    if not align_found:
        diagnostics = append_string(diagnostics, "enum layout header missing align entry")
    if len(tag_type) == 0:
        diagnostics = append_string(diagnostics, "enum layout header missing tag_type entry")
    if not tag_size_found:
        diagnostics = append_string(diagnostics, "enum layout header missing tag_size entry")
    if not tag_align_found:
        diagnostics = append_string(diagnostics, "enum layout header missing tag_align entry")
    success = size_found  and  align_found  and  len(tag_type) > 0  and  tag_size_found  and  tag_align_found  and  len(diagnostics) == 0
    return EnumLayoutHeaderParse(success=success, name=name_value, size=size_value, align=align_value, tag_type=tag_type, tag_size=tag_size_value, tag_align=tag_align_value, diagnostics=diagnostics)

def parse_enum_variant_layout(text, enum_name):
    trimmed = trim_text(text)
    diagnostics = []
    default_variant = NativeEnumVariantLayout(name="", tag=0, offset=0, size=0, align=0, fields=[])
    if len(trimmed) == 0:
        diagnostics = append_string(diagnostics, "enum " + enum_name + " layout variant missing content")
        return EnumLayoutVariantParse(success=False, variant=default_variant, diagnostics=diagnostics)
    tokens = split_whitespace(trimmed)
    if len(tokens) == 0:
        diagnostics = append_string(diagnostics, "enum " + enum_name + " layout variant missing entries")
        return EnumLayoutVariantParse(success=False, variant=default_variant, diagnostics=diagnostics)
    variant_name = tokens[0]
    if len(variant_name) == 0:
        diagnostics = append_string(diagnostics, "enum " + enum_name + " layout variant missing name")
        return EnumLayoutVariantParse(success=False, variant=default_variant, diagnostics=diagnostics)
    tag_found = False
    offset_found = False
    size_found = False
    align_found = False
    tag_value = 0
    offset_value = 0
    size_value = 0
    align_value = 0
    index = 1
    while True:
        if index >= len(tokens):
            break
        token = tokens[index]
        if starts_with(token, "tag="):
            value_text = substring(token, 4, len(token))
            parsed = parse_decimal_number(value_text)
            if parsed.success:
                tag_found = True
                tag_value = parsed.value
            else:
                diagnostics = append_string(diagnostics, "enum " + enum_name + " layout variant `" + variant_name + "` has invalid tag `" + value_text + "`")
        else:
            if starts_with(token, "offset="):
                value_text = substring(token, 7, len(token))
                parsed = parse_decimal_number(value_text)
                if parsed.success:
                    offset_found = True
                    offset_value = parsed.value
                else:
                    diagnostics = append_string(diagnostics, "enum " + enum_name + " layout variant `" + variant_name + "` has invalid offset `" + value_text + "`")
            else:
                if starts_with(token, "size="):
                    value_text = substring(token, 5, len(token))
                    parsed = parse_decimal_number(value_text)
                    if parsed.success:
                        size_found = True
                        size_value = parsed.value
                    else:
                        diagnostics = append_string(diagnostics, "enum " + enum_name + " layout variant `" + variant_name + "` has invalid size `" + value_text + "`")
                else:
                    if starts_with(token, "align="):
                        value_text = substring(token, 6, len(token))
                        parsed = parse_decimal_number(value_text)
                        if parsed.success:
                            align_found = True
                            align_value = parsed.value
                        else:
                            diagnostics = append_string(diagnostics, "enum " + enum_name + " layout variant `" + variant_name + "` has invalid align `" + value_text + "`")
                    else:
                        diagnostics = append_string(diagnostics, "enum " + enum_name + " layout variant `" + variant_name + "` unrecognized token `" + token + "`")
        index += 1
    if not tag_found:
        diagnostics = append_string(diagnostics, "enum " + enum_name + " layout variant `" + variant_name + "` missing tag entry")
    if not offset_found:
        diagnostics = append_string(diagnostics, "enum " + enum_name + " layout variant `" + variant_name + "` missing offset entry")
    if not size_found:
        diagnostics = append_string(diagnostics, "enum " + enum_name + " layout variant `" + variant_name + "` missing size entry")
    if not align_found:
        diagnostics = append_string(diagnostics, "enum " + enum_name + " layout variant `" + variant_name + "` missing align entry")
    success = tag_found  and  offset_found  and  size_found  and  align_found  and  len(diagnostics) == 0
    variant = NativeEnumVariantLayout(name=variant_name, tag=tag_value, offset=offset_value, size=size_value, align=align_value, fields=[])
    return EnumLayoutVariantParse(success=success, variant=variant, diagnostics=diagnostics)

def parse_enum_payload_layout(text, enum_name):
    trimmed = trim_text(text)
    diagnostics = []
    default_field = NativeStructLayoutField(name="", type_annotation="", offset=0, size=0, align=0)
    if len(trimmed) == 0:
        diagnostics = append_string(diagnostics, "enum " + enum_name + " layout payload missing content")
        return EnumLayoutPayloadParse(success=False, variant_name="", field=default_field, diagnostics=diagnostics)
    tokens = split_whitespace(trimmed)
    if len(tokens) == 0:
        diagnostics = append_string(diagnostics, "enum " + enum_name + " layout payload missing entries")
        return EnumLayoutPayloadParse(success=False, variant_name="", field=default_field, diagnostics=diagnostics)
    identifier = tokens[0]
    dot_index = index_of(identifier, ".")
    if dot_index <= 0  or  dot_index + 1 >= len(identifier):
        diagnostics = append_string(diagnostics, "enum " + enum_name + " layout payload identifier `" + identifier + "` invalid")
        return EnumLayoutPayloadParse(success=False, variant_name="", field=default_field, diagnostics=diagnostics)
    variant_name = substring(identifier, 0, dot_index)
    field_name = substring(identifier, dot_index + 1, len(identifier))
    type_text = ""
    offset_found = False
    size_found = False
    align_found = False
    offset_value = 0
    size_value = 0
    align_value = 0
    index = 1
    while True:
        if index >= len(tokens):
            break
        token = tokens[index]
        if starts_with(token, "type="):
            type_text = substring(token, 5, len(token))
        else:
            if starts_with(token, "offset="):
                value_text = substring(token, 7, len(token))
                parsed = parse_decimal_number(value_text)
                if parsed.success:
                    offset_found = True
                    offset_value = parsed.value
                else:
                    diagnostics = append_string(diagnostics, "enum " + enum_name + " layout payload `" + identifier + "` has invalid offset `" + value_text + "`")
            else:
                if starts_with(token, "size="):
                    value_text = substring(token, 5, len(token))
                    parsed = parse_decimal_number(value_text)
                    if parsed.success:
                        size_found = True
                        size_value = parsed.value
                    else:
                        diagnostics = append_string(diagnostics, "enum " + enum_name + " layout payload `" + identifier + "` has invalid size `" + value_text + "`")
                else:
                    if starts_with(token, "align="):
                        value_text = substring(token, 6, len(token))
                        parsed = parse_decimal_number(value_text)
                        if parsed.success:
                            align_found = True
                            align_value = parsed.value
                        else:
                            diagnostics = append_string(diagnostics, "enum " + enum_name + " layout payload `" + identifier + "` has invalid align `" + value_text + "`")
                    else:
                        diagnostics = append_string(diagnostics, "enum " + enum_name + " layout payload `" + identifier + "` unrecognized token `" + token + "`")
        index += 1
    if len(type_text) == 0:
        diagnostics = append_string(diagnostics, "enum " + enum_name + " layout payload `" + identifier + "` missing type entry")
    if not offset_found:
        diagnostics = append_string(diagnostics, "enum " + enum_name + " layout payload `" + identifier + "` missing offset entry")
    if not size_found:
        diagnostics = append_string(diagnostics, "enum " + enum_name + " layout payload `" + identifier + "` missing size entry")
    if not align_found:
        diagnostics = append_string(diagnostics, "enum " + enum_name + " layout payload `" + identifier + "` missing align entry")
    success = len(type_text) > 0  and  offset_found  and  size_found  and  align_found  and  len(diagnostics) == 0
    field = NativeStructLayoutField(name=field_name, type_annotation=type_text, offset=offset_value, size=size_value, align=align_value)
    return EnumLayoutPayloadParse(success=success, variant_name=variant_name, field=field, diagnostics=diagnostics)

def parse_let_instruction(line, span, value_span):
    body = trim_text(strip_prefix(line, ".let "))
    is_mutable = False
    remainder = body
    if starts_with(remainder, "mut "):
        is_mutable = True
        remainder = trim_text(strip_prefix(remainder, "mut "))
    parsed = parse_binding_components(remainder)
    return runtime.enum_instantiate(NativeInstruction, 'Let', [runtime.enum_field('name', parsed.name), runtime.enum_field('mutable', is_mutable), runtime.enum_field('type_annotation', parsed.type_annotation), runtime.enum_field('value', parsed.value), runtime.enum_field('span', span), runtime.enum_field('value_span', value_span)])

def parse_binding_components(text):
    name = ""
    index = 0
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if ch == " "  or  ch == ":"  or  ch == "=":
            break
        name = name + ch
        index += 1
    name = trim_text(name)
    type_annotation = ""
    value = None
    remainder = trim_text(substring(text, index, len(text)))
    if len(remainder) > 0:
        if starts_with(remainder, "->"):
            remainder = trim_text(strip_prefix(remainder, "->"))
            assign_index = index_of(remainder, "=")
            if assign_index >= 0:
                type_annotation = trim_text(substring(remainder, 0, assign_index))
                value_text = trim_text(substring(remainder, assign_index + 1, len(remainder)))
                if len(value_text) > 0:
                    value = value_text
            else:
                type_annotation = trim_text(remainder)
        else:
            if starts_with(remainder, ":"):
                remainder = trim_text(strip_prefix(remainder, ":"))
                assign_index = index_of(remainder, "=")
                if assign_index >= 0:
                    type_annotation = trim_text(substring(remainder, 0, assign_index))
                    value_text = trim_text(substring(remainder, assign_index + 1, len(remainder)))
                    if len(value_text) > 0:
                        value = value_text
                else:
                    type_annotation = trim_text(remainder)
            else:
                if starts_with(remainder, "="):
                    value_text = trim_text(strip_prefix(remainder, "="))
                    if len(value_text) > 0:
                        value = value_text
                else:
                    value = remainder
    return BindingComponents(name=name, type_annotation=type_annotation, value=value)

def parse_function_name(header):
    trimmed = trim_text(header)
    if starts_with(trimmed, "async "):
        trimmed = trim_text(strip_prefix(trimmed, "async "))
    paren_index = index_of(trimmed, "(")
    name = trimmed
    if paren_index >= 0:
        name = trim_text(substring(trimmed, 0, paren_index))
    separator_index = last_index_of(name, ".")
    if separator_index >= 0:
        name = trim_text(substring(name, separator_index + 1, len(name)))
    return strip_generics(name)

def parse_parameter_entry(body, span):
    trimmed = trim_text(body)
    if len(trimmed) == 0:
        return None
    is_mutable = False
    if starts_with(trimmed, "mut "):
        is_mutable = True
        trimmed = trim_text(strip_prefix(trimmed, "mut "))
    name = ""
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if ch == " "  or  ch == "-"  or  ch == "=":
            break
        name = name + ch
        index += 1
    name = trim_text(name)
    if len(name) == 0:
        return None
    type_annotation = ""
    default_value = None
    remainder = trim_text(substring(trimmed, index, len(trimmed)))
    if len(remainder) > 0:
        if starts_with(remainder, "->"):
            remainder = trim_text(strip_prefix(remainder, "->"))
            assign_index = index_of(remainder, "=")
            if assign_index >= 0:
                type_annotation = trim_text(substring(remainder, 0, assign_index))
                default_text = trim_text(substring(remainder, assign_index + 1, len(remainder)))
                if len(default_text) > 0:
                    default_value = default_text
            else:
                type_annotation = trim_text(remainder)
        else:
            if starts_with(remainder, "="):
                default_text = trim_text(strip_prefix(remainder, "="))
                if len(default_text) > 0:
                    default_value = default_text
    return NativeParameter(name=name, type_annotation=type_annotation, mutable=is_mutable, default_value=default_value, span=span)

def line_looks_like_parameter_entry(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return False
    if starts_with(trimmed, "."):
        return False
    if starts_with(trimmed, ";"):
        return False
    arrow_index = index_of(trimmed, "->")
    if arrow_index >= 0:
        head = trim_text(substring(trimmed, 0, arrow_index))
        if len(head) == 0:
            return False
        if starts_with(head, "mut "):
            head = trim_text(strip_prefix(head, "mut "))
        if len(head) == 0:
            return False
        if index_of(head, " ") >= 0:
            return False
        if index_of(head, "\t") >= 0:
            return False
        return True
    assign_index = index_of(trimmed, "=")
    if assign_index >= 0:
        head = trim_text(substring(trimmed, 0, assign_index))
        if len(head) == 0:
            return False
        if starts_with(head, "mut "):
            head = trim_text(strip_prefix(head, "mut "))
        if len(head) == 0:
            return False
        if index_of(head, " ") >= 0:
            return False
        if index_of(head, "\t") >= 0:
            return False
        return True
    return False

def split_parameter_entries(body):
    entries = []
    current = ""
    index = 0
    depth = 0
    quote = ""
    while True:
        if index >= len(body):
            break
        ch = body[index]
        if len(quote) > 0:
            current = current + ch
            if ch == "\\":
                if index + 1 < len(body):
                    current = current + body[index + 1]
                    index += 2
                    continue
            if ch == quote:
                quote = ""
            index += 1
            continue
        if ch == "\""  or  ch == "'":
            quote = ch
            current = current + ch
            index += 1
            continue
        if ch == "("  or  ch == "["  or  ch == "{":
            depth += 1
            current = current + ch
            index += 1
            continue
        if ch == ")"  or  ch == "]"  or  ch == "}":
            if depth > 0:
                depth -= 1
            current = current + ch
            index += 1
            continue
        if ch == ",":
            if depth == 0:
                segment = trim_text(current)
                if len(segment) > 0:
                    entries = append_string(entries, segment)
                current = ""
                index += 1
                continue
        current = current + ch
        index += 1
    segment = trim_text(current)
    if len(segment) > 0:
        entries = append_string(entries, segment)
    return entries

def parse_effect_list(text):
    trimmed = trim_text(text)
    if trimmed == "none":
        return []
    return split_comma_separated(trimmed)

def split_whitespace(value):
    parts = []
    if len(value) == 0:
        return parts
    start = -1
    index = 0
    while True:
        if index >= len(value):
            break
        ch = text_char_at(value, index)
        is_space = ch == " "  or  ch == "\t"  or  ch == "\n"  or  ch == "\r"
        if is_space:
            if start >= 0:
                parts = append_string(parts, substring(value, start, index))
                start = -1
        else:
            if start < 0:
                start = index
        index += 1
    if start >= 0:
        parts = append_string(parts, substring(value, start, len(value)))
    return parts

def parse_decimal_number(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return NumberParseResult(success=False, value=0)
    zero = char_code("0")
    nine = char_code("9")
    index = 0
    value = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        code = char_code(ch)
        if code < zero  or  code > nine:
            return NumberParseResult(success=False, value=0)
        digit = code - zero
        value = value * 10 + digit
        index += 1
    return NumberParseResult(success=True, value=value)

def split_lines(value):
    lines = []
    current = ""
    index = 0
    while True:
        if index >= len(value):
            break
        ch = value[index]
        if ch == "\n":
            lines = append_string(lines, current)
            current = ""
        else:
            current = current + ch
        index += 1
    lines = append_string(lines, current)
    return lines

def split_comma_separated(value):
    results = []
    current = ""
    index = 0
    while True:
        if index >= len(value):
            break
        ch = value[index]
        if ch == ",":
            results = append_string(results, trim_text(current))
            current = ""
        else:
            current = current + ch
        index += 1
    if len(current) > 0:
        results = append_string(results, trim_text(current))
    filtered = []
    index = 0
    while True:
        if index >= len(results):
            break
        entry = results[index]
        if len(entry) > 0:
            filtered = append_string(filtered, entry)
        index += 1
    return filtered

def strip_generics(name):
    result = ""
    depth = 0
    index = 0
    while True:
        if index >= len(name):
            break
        ch = name[index]
        if ch == "<":
            depth += 1
            index += 1
            continue
        if ch == ">":
            if depth > 0:
                depth -= 1
            index += 1
            continue
        if depth == 0:
            result = result + ch
        index += 1
    return trim_text(result)

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

def parse_layout_manifest(text):
    lines = split_lines(text)
    diagnostics = []
    structs = []
    enums = []
    index = 0
    while True:
        if index >= len(lines):
            break
        raw_line = lines[index]
        line = trim_text(raw_line)
        if len(line) == 0:
            index += 1
            continue
        if starts_with(line, ";"):
            index += 1
            continue
        if starts_with(line, ".manifest "):
            index += 1
            continue
        if starts_with(line, ".layout field "):
            tail = trim_text(strip_prefix(line, ".layout field "))
            is_struct_header = False
            if starts_with(tail, "struct"):
                if len(tail) == 6:
                    is_struct_header = True
                else:
                    if len(tail) > 6:
                        after = tail[6]
                        if is_trim_char(after):
                            is_struct_header = True
            if is_struct_header:
                header_text = trim_text(strip_prefix(tail, "struct"))
                line = ".layout struct " + header_text
        if starts_with(line, ".layout struct "):
            body = strip_prefix(line, ".layout ")
            struct_header = strip_prefix(body, "struct ")
            header_result = parse_struct_layout_header(struct_header)
            diagnostics = (diagnostics) + (header_result.diagnostics)
            if header_result.success:
                fields = []
                struct_name = header_result.name
                index += 1
                while True:
                    if index >= len(lines):
                        break
                    field_line = trim_text(lines[index])
                    if len(field_line) == 0:
                        index += 1
                        break
                    if starts_with(field_line, ".layout struct ")  or  starts_with(field_line, ".layout enum "):
                        break
                    if not starts_with(field_line, ".layout field "):
                        break
                    tail = trim_text(strip_prefix(field_line, ".layout field "))
                    is_struct_header = False
                    if starts_with(tail, "struct"):
                        if len(tail) == 6:
                            is_struct_header = True
                        else:
                            if len(tail) > 6:
                                after = tail[6]
                                if is_trim_char(after):
                                    is_struct_header = True
                    if is_struct_header:
                        break
                    field_result = parse_struct_layout_field(tail, struct_name)
                    diagnostics = (diagnostics) + (field_result.diagnostics)
                    if field_result.success:
                        fields = append_struct_layout_field(fields, field_result.field)
                    index += 1
                struct_def = NativeStruct(name=struct_name, fields=[], methods=[], implements=[], layout=NativeStructLayout(size=header_result.size, align=header_result.align, fields=fields))
                structs = append_struct(structs, struct_def)
            continue
        if starts_with(line, ".layout enum "):
            body = strip_prefix(line, ".layout ")
            enum_header = strip_prefix(body, "enum ")
            header_result = parse_enum_layout_header(enum_header)
            diagnostics = (diagnostics) + (header_result.diagnostics)
            if header_result.success:
                variants = []
                enum_name = header_result.name
                index += 1
                while True:
                    if index >= len(lines):
                        break
                    variant_line = trim_text(lines[index])
                    if len(variant_line) == 0:
                        index += 1
                        break
                    if not starts_with(variant_line, ".layout variant ")  and  not starts_with(variant_line, ".layout payload "):
                        break
                    if starts_with(variant_line, ".layout variant "):
                        body = strip_prefix(variant_line, ".layout ")
                        variant_text = strip_prefix(body, "variant ")
                        if starts_with(variant_text, "enum "):
                            index += 1
                            continue
                        variant_result = parse_enum_variant_layout(variant_text, enum_name)
                        diagnostics = (diagnostics) + (variant_result.diagnostics)
                        if variant_result.success:
                            variants = append_enum_variant_layout(variants, variant_result.variant)
                    else:
                        if starts_with(variant_line, ".layout payload "):
                            body = strip_prefix(variant_line, ".layout ")
                            payload_text = strip_prefix(body, "payload ")
                            payload_result = parse_enum_payload_layout(payload_text, enum_name)
                            diagnostics = (diagnostics) + (payload_result.diagnostics)
                            if payload_result.success  and  len(variants) > 0:
                                last_index = len(variants) - 1
                                last_variant = variants[last_index]
                                updated_fields = append_struct_layout_field(last_variant.fields, payload_result.field)
                                variants[last_index] = NativeEnumVariantLayout(name=last_variant.name, tag=last_variant.tag, offset=last_variant.offset, size=last_variant.size, align=last_variant.align, fields=updated_fields)
                    index += 1
                enum_def = NativeEnum(name=enum_name, variants=[], layout=NativeEnumLayout(size=header_result.size, align=header_result.align, tag_type=header_result.tag_type, tag_size=header_result.tag_size, tag_align=header_result.tag_align, variants=variants))
                enums = append_enum(enums, enum_def)
            else:
                index += 1
            continue
        index += 1
    return LayoutManifest(structs=structs, enums=enums, diagnostics=diagnostics)

def is_trim_char(ch):
    return ch == " "  or  ch == "\n"  or  ch == "\r"  or  ch == "\t"

def starts_with(value, prefix):
    if len(prefix) == 0:
        return True
    if len(value) < len(prefix):
        return False
    index = 0
    while True:
        if index >= len(prefix):
            break
        if value[index] != prefix[index]:
            return False
        index += 1
    return True

def strip_prefix(value, prefix):
    if not starts_with(value, prefix):
        return value
    return substring(value, len(prefix), len(value))

def index_of(value, target):
    if len(target) == 0:
        return 0
    index = 0
    while True:
        if index + len(target) > len(value):
            break
        match_index = 0
        matches = True
        while True:
            if match_index >= len(target):
                break
            if value[index + match_index] != target[match_index]:
                matches = False
                break
            match_index += 1
        if matches:
            return index
        index += 1
    return -1

def last_index_of(value, target):
    if len(target) == 0:
        return len(value)
    index = len(value) - len(target)
    while True:
        if index < 0:
            break
        match_index = 0
        matches = True
        while True:
            if match_index >= len(target):
                break
            if value[index + match_index] != target[match_index]:
                matches = False
                break
            match_index += 1
        if matches:
            return index
        index -= 1
    return -1

def strip_quotes(value):
    if len(value) >= 2:
        first = value[0]
        last = value[len(value) - 1]
        is_double = first == "\""  and  last == "\""
        is_single = first == "'"  and  last == "'"
        if is_double  or  is_single:
            return substring(value, 1, len(value) - 1)
    return value

def append_string(values, value):
    return (values) + ([value])

def split_text(value, delimiter):
    if len(delimiter) == 0:
        return [value]
    parts = []
    start = 0
    index = 0
    while True:
        if index >= len(value):
            break
        pos = index_of(substring(value, index, len(value)), delimiter)
        if pos < 0:
            break
        actual_pos = index + pos
        parts = append_string(parts, substring(value, start, actual_pos))
        start = actual_pos + len(delimiter)
        index = start
    if start < len(value):
        parts = append_string(parts, substring(value, start, len(value)))
    else:
        if start == len(value):
            parts = append_string(parts, "")
    return parts

def append_parameter_array(values, parameter):
    return (values) + ([parameter])
