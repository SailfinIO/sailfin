import asyncio
from runtime import runtime_support as runtime

from compiler.build.emit_native import NativeArtifact
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

NativeInstruction = runtime.enum_type('NativeInstruction')
NativeInstruction = runtime.enum_define_variant(NativeInstruction, 'Return', ['expression'])
NativeInstruction = runtime.enum_define_variant(NativeInstruction, 'Expression', ['expression'])
NativeInstruction = runtime.enum_define_variant(NativeInstruction, 'Let', ['name', 'mutable', 'type_annotation', 'value'])
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

class NativeParameter:
    def __init__(self, name, type_annotation, mutable, default_value=None):
        self.name = name
        self.type_annotation = type_annotation
        self.mutable = mutable
        self.default_value = default_value

    def __repr__(self):
        return runtime.struct_repr('NativeParameter', [runtime.struct_field('name', self.name), runtime.struct_field('type_annotation', self.type_annotation), runtime.struct_field('mutable', self.mutable), runtime.struct_field('default_value', self.default_value)])

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

class NativeStruct:
    def __init__(self, name, fields):
        self.name = name
        self.fields = fields

    def __repr__(self):
        return runtime.struct_repr('NativeStruct', [runtime.struct_field('name', self.name), runtime.struct_field('fields', self.fields)])

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

class NativeEnum:
    def __init__(self, name, variants):
        self.name = name
        self.variants = variants

    def __repr__(self):
        return runtime.struct_repr('NativeEnum', [runtime.struct_field('name', self.name), runtime.struct_field('variants', self.variants)])

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

class StructParseResult:
    def __init__(self, next_index, diagnostics, definition=None):
        self.definition = definition
        self.next_index = next_index
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('StructParseResult', [runtime.struct_field('definition', self.definition), runtime.struct_field('next_index', self.next_index), runtime.struct_field('diagnostics', self.diagnostics)])

class ParseNativeResult:
    def __init__(self, functions, imports, structs, enums, bindings, diagnostics):
        self.functions = functions
        self.imports = imports
        self.structs = structs
        self.enums = enums
        self.bindings = bindings
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('ParseNativeResult', [runtime.struct_field('functions', self.functions), runtime.struct_field('imports', self.imports), runtime.struct_field('structs', self.structs), runtime.struct_field('enums', self.enums), runtime.struct_field('bindings', self.bindings), runtime.struct_field('diagnostics', self.diagnostics)])

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
    return null

def parse_native_artifact(text):
    lines = split_lines(text)
    diagnostics = []
    functions = []
    imports = []
    structs = []
    enums = []
    bindings = []
    current = null
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
            if parsed_import == null:
                diagnostics = append_string(diagnostics, "unable to parse import: " + line)
            else:
                imports = append_import(imports, parsed_import)
            index += 1
            continue
        if starts_with(line, ".export "):
            parsed_export = parse_import_entry("export", strip_prefix(line, ".export "))
            if parsed_export == null:
                diagnostics = append_string(diagnostics, "unable to parse export: " + line)
            else:
                imports = append_import(imports, parsed_export)
            index += 1
            continue
        if starts_with(line, ".struct "):
            struct_result = parse_struct_definition(lines, index)
            diagnostics = (diagnostics) + (struct_result.diagnostics)
            if struct_result.definition != null:
                structs = append_struct(structs, struct_result.definition)
            index = struct_result.next_index
            continue
        if starts_with(line, ".enum "):
            enum_result = parse_enum_definition(lines, index)
            diagnostics = (diagnostics) + (enum_result.diagnostics)
            if enum_result.definition != null:
                enums = append_enum(enums, enum_result.definition)
            index = enum_result.next_index
            continue
        if starts_with(line, ".fn "):
            if current != null:
                diagnostics = append_string(diagnostics, "encountered nested .fn while previous function still open")
            current = NativeFunction(name=parse_function_name(strip_prefix(line, ".fn ")), parameters=[], return_type="void", effects=[], instructions=[])
            index += 1
            continue
        if starts_with(line, ".endfn"):
            if current == null:
                diagnostics = append_string(diagnostics, "encountered .endfn without active function")
            else:
                functions = append_function(functions, current)
                current = null
            index += 1
            continue
        if starts_with(line, ".meta "):
            if current != null:
                current = apply_meta(current, strip_prefix(line, ".meta "))
            else:
                diagnostics = append_string(diagnostics, "metadata outside function body: " + line)
            index += 1
            continue
        if starts_with(line, ".param "):
            if current != null:
                parameter = parse_parameter_entry(strip_prefix(line, ".param "))
                if parameter == null:
                    diagnostics = append_string(diagnostics, "unable to parse parameter line: " + line)
                else:
                    current = append_parameter(current, parameter)
            else:
                diagnostics = append_string(diagnostics, "parameter outside function body: " + line)
            index += 1
            continue
        if current == null:
            if starts_with(line, ".let "):
                parsed_binding = parse_let_instruction(line)
                bindings = append_binding(bindings, binding_from_instruction(parsed_binding))
                index += 1
                continue
            diagnostics = append_string(diagnostics, "top-level directive not supported in lowering: " + line)
            index += 1
            continue
        instructions = parse_instruction(line)
        instruction_index = 0
        while True:
            if instruction_index >= len(instructions):
                break
            current = append_instruction(current, instructions[instruction_index])
            instruction_index += 1
        index += 1
    if current != null:
        diagnostics = append_string(diagnostics, "unterminated function at end of artifact")
    return ParseNativeResult(functions=functions, imports=imports, structs=structs, enums=enums, bindings=bindings, diagnostics=diagnostics)

def append_function(functions, value):
    return (functions) + ([value])

def append_binding(bindings, value):
    return (bindings) + ([value])

def append_import(imports, value):
    return (imports) + ([value])

def append_struct(structs, value):
    return (structs) + ([value])

def append_enum(enums, value):
    return (enums) + ([value])

def append_enum_variant(variants, value):
    return (variants) + ([value])

def append_enum_variant_field(fields, value):
    return (fields) + ([value])

def append_struct_field(fields, field):
    return (fields) + ([field])

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

def parse_instruction(line):
    if line == "noop":
        return [NativeInstruction.Noop()]
    if starts_with(line, ".if "):
        condition = trim_text(strip_prefix(line, ".if "))
        return [runtime.enum_instantiate(NativeInstruction, 'If', [runtime.enum_field('condition', condition)])]
    if line == ".else":
        return [NativeInstruction.Else()]
    if line == ".endif":
        return [NativeInstruction.EndIf()]
    if starts_with(line, ".for "):
        body = trim_text(strip_prefix(line, ".for "))
        separator = " in "
        index = index_of(body, separator)
        if index >= 0:
            target = trim_text(substring(body, 0, index))
            iterable = trim_text(substring(body, index + len(separator), len(body)))
            return [runtime.enum_instantiate(NativeInstruction, 'For', [runtime.enum_field('target', target), runtime.enum_field('iterable', iterable)])]
    if line == ".endfor":
        return [NativeInstruction.EndFor()]
    if line == ".loop":
        return [NativeInstruction.Loop()]
    if line == ".endloop":
        return [NativeInstruction.EndLoop()]
    if line == "break":
        return [NativeInstruction.Break()]
    if line == "continue":
        return [NativeInstruction.Continue()]
    if starts_with(line, ".match "):
        expression = trim_text(strip_prefix(line, ".match "))
        return [runtime.enum_instantiate(NativeInstruction, 'Match', [runtime.enum_field('expression', expression)])]
    if starts_with(line, ".case "):
        return [parse_case_instruction(line)]
    if line == ".endmatch":
        return [NativeInstruction.EndMatch()]
    if starts_with(line, ".let "):
        return [parse_let_instruction(line)]
    if starts_with(line, "ret"):
        if len(line) == 3:
            return [runtime.enum_instantiate(NativeInstruction, 'Return', [runtime.enum_field('expression', "")])]
        separator = line[3]
        if separator == " "  or  separator == "\t":
            remainder = trim_text(substring(line, 3, len(line)))
            if len(remainder) == 0:
                return [runtime.enum_instantiate(NativeInstruction, 'Return', [runtime.enum_field('expression', "")])]
            return [runtime.enum_instantiate(NativeInstruction, 'Return', [runtime.enum_field('expression', trim_trailing_delimiters(remainder))])]
    if starts_with(line, "eval let "):
        body = trim_text(strip_prefix(line, "eval let "))
        is_mutable = false
        if starts_with(body, "mut "):
            is_mutable = true
            body = trim_text(strip_prefix(body, "mut "))
        parsed = parse_binding_components(body)
        return [runtime.enum_instantiate(NativeInstruction, 'Let', [runtime.enum_field('name', parsed.name), runtime.enum_field('mutable', is_mutable), runtime.enum_field('type_annotation', parsed.type_annotation), runtime.enum_field('value', maybe_trim_trailing(parsed.value))])]
    if starts_with(line, "eval "):
        return [runtime.enum_instantiate(NativeInstruction, 'Expression', [runtime.enum_field('expression', trim_trailing_delimiters(trim_text(strip_prefix(line, "eval "))))])]
    if index_of(line, "=>") >= 0:
        return parse_inline_case_instruction(line)
    return [runtime.enum_instantiate(NativeInstruction, 'Unknown', [runtime.enum_field('text', line)])]

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
        return runtime.enum_instantiate(NativeInstruction, 'Return', [runtime.enum_field('expression', value)])
    if starts_with(lowered, "eval "):
        return runtime.enum_instantiate(NativeInstruction, 'Expression', [runtime.enum_field('expression', trim_trailing_delimiters(trim_text(strip_prefix(lowered, "eval "))))])
    return runtime.enum_instantiate(NativeInstruction, 'Expression', [runtime.enum_field('expression', lowered)])

def split_case_components(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return CaseComponents(pattern=trimmed, guard=null)
    separator = " if "
    index = last_index_of(trimmed, separator)
    if index < 0:
        return CaseComponents(pattern=trimmed, guard=null)
    pattern = trim_text(substring(trimmed, 0, index))
    guard_text = trim_text(substring(trimmed, index + len(separator), len(trimmed)))
    if len(guard_text) == 0:
        return CaseComponents(pattern=pattern, guard=null)
    return CaseComponents(pattern=pattern, guard=guard_text)

def parse_import_entry(kind, entry):
    trimmed = trim_text(entry)
    if len(trimmed) == 0:
        return null
    module_text = trimmed
    specifiers = []
    brace_index = index_of(trimmed, "{")
    if brace_index >= 0:
        close_index = last_index_of(trimmed, "}")
        if close_index < 0  or  close_index <= brace_index:
            return null
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
        return NativeImportSpecifier(name="", alias=null)
    separator = " as "
    index = index_of(trimmed, separator)
    if index < 0:
        return NativeImportSpecifier(name=trimmed, alias=null)
    name = trim_text(substring(trimmed, 0, index))
    alias_text = trim_text(substring(trimmed, index + len(separator), len(trimmed)))
    if len(alias_text) == 0:
        return NativeImportSpecifier(name=name, alias=null)
    return NativeImportSpecifier(name=name, alias=alias_text)

def parse_struct_definition(lines, start_index):
    diagnostics = []
    header = trim_text(lines[start_index])
    name_text = trim_text(strip_prefix(header, ".struct "))
    struct_name = name_text
    space_index = index_of(struct_name, " ")
    if space_index >= 0:
        struct_name = trim_text(substring(struct_name, 0, space_index))
    struct_name = strip_generics(struct_name)
    if len(struct_name) == 0:
        diagnostics = append_string(diagnostics, "unable to parse struct header: " + header)
        return StructParseResult(definition=null, next_index=start_index + 1, diagnostics=diagnostics)
    fields = []
    index = start_index + 1
    while True:
        if index >= len(lines):
            diagnostics = append_string(diagnostics, "unterminated struct " + struct_name)
            return StructParseResult(definition=NativeStruct(name=struct_name, fields=fields), next_index=index, diagnostics=diagnostics)
        raw_line = trim_text(lines[index])
        if len(raw_line) == 0  or  starts_with(raw_line, ";"):
            index += 1
            continue
        if raw_line == "noop":
            index += 1
            continue
        if raw_line == ".endstruct":
            index += 1
            break
        if starts_with(raw_line, ".field "):
            parsed_field = parse_struct_field_line(strip_prefix(raw_line, ".field "))
            if parsed_field == null:
                diagnostics = append_string(diagnostics, "unable to parse struct field: " + raw_line)
            else:
                fields = append_struct_field(fields, parsed_field)
            index += 1
            continue
        diagnostics = append_string(diagnostics, "unsupported struct directive: " + raw_line)
        index += 1
    return StructParseResult(definition=NativeStruct(name=struct_name, fields=fields), next_index=index, diagnostics=diagnostics)

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
        return EnumParseResult(definition=null, next_index=start_index + 1, diagnostics=diagnostics)
    variants = []
    index = start_index + 1
    while True:
        if index >= len(lines):
            diagnostics = append_string(diagnostics, "unterminated enum " + enum_name)
            return EnumParseResult(definition=NativeEnum(name=enum_name, variants=variants), next_index=index, diagnostics=diagnostics)
        raw_line = trim_text(lines[index])
        if len(raw_line) == 0  or  starts_with(raw_line, ";"):
            index += 1
            continue
        if raw_line == "noop":
            index += 1
            continue
        if raw_line == ".endenum":
            index += 1
            break
        if starts_with(raw_line, ".variant "):
            parsed_variant = parse_enum_variant_line(strip_prefix(raw_line, ".variant "))
            if parsed_variant == null:
                diagnostics = append_string(diagnostics, "unable to parse enum variant: " + raw_line)
            else:
                variants = append_enum_variant(variants, parsed_variant)
            index += 1
            continue
        diagnostics = append_string(diagnostics, "unsupported enum directive: " + raw_line)
        index += 1
    return EnumParseResult(definition=NativeEnum(name=enum_name, variants=variants), next_index=index, diagnostics=diagnostics)

def parse_enum_variant_line(text):
    trimmed = trim_trailing_delimiters(trim_text(text))
    if len(trimmed) == 0:
        return null
    brace_index = index_of(trimmed, "{")
    if brace_index < 0:
        return NativeEnumVariant(name=strip_generics(trimmed), fields=[])
    close_index = last_index_of(trimmed, "}")
    if close_index < 0  or  close_index <= brace_index:
        return null
    name_text = strip_generics(trim_text(substring(trimmed, 0, brace_index)))
    if len(name_text) == 0:
        return null
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
        if parsed_field == null:
            return null
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
        return null
    is_mutable = false
    if starts_with(trimmed, "mut "):
        is_mutable = true
        trimmed = trim_text(strip_prefix(trimmed, "mut "))
    arrow_index = index_of(trimmed, "->")
    if arrow_index < 0:
        return null
    name = trim_text(substring(trimmed, 0, arrow_index))
    if len(name) == 0:
        return null
    type_text = trim_text(substring(trimmed, arrow_index + 2, len(trimmed)))
    return NativeEnumVariantField(name=name, type_annotation=type_text, mutable=is_mutable)

def trim_trailing_delimiters(text):
    end = len(text)
    while True:
        if end <= 0:
            break
        ch = text[end - 1]
        if ch == ","  or  ch == ";":
            end -= 1
            continue
        break
    if end == len(text):
        return text
    return substring(text, 0, end)

def maybe_trim_trailing(value):
    if value == null:
        return null
    trimmed = trim_trailing_delimiters(value)
    return trimmed

def parse_struct_field_line(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return null
    is_mutable = false
    if starts_with(trimmed, "mut "):
        is_mutable = true
        trimmed = trim_text(strip_prefix(trimmed, "mut "))
    arrow_index = index_of(trimmed, "->")
    if arrow_index < 0:
        return null
    name = trim_text(substring(trimmed, 0, arrow_index))
    if len(name) == 0:
        return null
    type_text = trim_text(substring(trimmed, arrow_index + 2, len(trimmed)))
    return NativeStructField(name=name, type_annotation=type_text, mutable=is_mutable)

def parse_let_instruction(line):
    body = trim_text(strip_prefix(line, ".let "))
    is_mutable = false
    remainder = body
    if starts_with(remainder, "mut "):
        is_mutable = true
        remainder = trim_text(strip_prefix(remainder, "mut "))
    parsed = parse_binding_components(remainder)
    return runtime.enum_instantiate(NativeInstruction, 'Let', [runtime.enum_field('name', parsed.name), runtime.enum_field('mutable', is_mutable), runtime.enum_field('type_annotation', parsed.type_annotation), runtime.enum_field('value', parsed.value)])

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
    value = null
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
    return strip_generics(name)

def parse_parameter_entry(body):
    trimmed = trim_text(body)
    if len(trimmed) == 0:
        return null
    is_mutable = false
    if starts_with(trimmed, "mut "):
        is_mutable = true
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
        return null
    type_annotation = ""
    default_value = null
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
    return NativeParameter(name=name, type_annotation=type_annotation, mutable=is_mutable, default_value=default_value)

def parse_effect_list(text):
    trimmed = trim_text(text)
    if trimmed == "none":
        return []
    return split_comma_separated(trimmed)

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

def is_trim_char(ch):
    return ch == " "  or  ch == "\n"  or  ch == "\r"  or  ch == "\t"

def starts_with(value, prefix):
    if len(prefix) == 0:
        return true
    if len(value) < len(prefix):
        return false
    index = 0
    while True:
        if index >= len(prefix):
            break
        if value[index] != prefix[index]:
            return false
        index += 1
    return true

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
        matches = true
        while True:
            if match_index >= len(target):
                break
            if value[index + match_index] != target[match_index]:
                matches = false
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
        matches = true
        while True:
            if match_index >= len(target):
                break
            if value[index + match_index] != target[match_index]:
                matches = false
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

def append_parameter_array(values, parameter):
    return (values) + ([parameter])
