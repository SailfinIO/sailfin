import asyncio
from runtime import runtime_support as runtime

from ...native_ir import NativeInterfaceSignature, NativeSourceSpan, NativeEnum, NativeStruct, LayoutManifest

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
substring_unchecked = runtime.substring_unchecked
is_decimal_digit = runtime.is_decimal_digit
is_whitespace_char = runtime.is_whitespace_char
is_alpha_char = runtime.is_alpha_char
globals()['t' + 'rue'] = True
globals()['f' + 'alse'] = False

class EnumLayoutFixupResult:
    def __init__(self, enums, diagnostics):
        self.enums = enums
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('EnumLayoutFixupResult', [runtime.struct_field('enums', self.enums), runtime.struct_field('diagnostics', self.diagnostics)])

class TraitImplementationDescriptor:
    def __init__(self, struct_name, interfaces):
        self.struct_name = struct_name
        self.interfaces = interfaces

    def __repr__(self):
        return runtime.struct_repr('TraitImplementationDescriptor', [runtime.struct_field('struct_name', self.struct_name), runtime.struct_field('interfaces', self.interfaces)])

class TraitDescriptor:
    def __init__(self, name, type_parameters, signatures):
        self.name = name
        self.type_parameters = type_parameters
        self.signatures = signatures

    def __repr__(self):
        return runtime.struct_repr('TraitDescriptor', [runtime.struct_field('name', self.name), runtime.struct_field('type_parameters', self.type_parameters), runtime.struct_field('signatures', self.signatures)])

class TraitMetadata:
    def __init__(self, interfaces, implementations):
        self.interfaces = interfaces
        self.implementations = implementations

    def __repr__(self):
        return runtime.struct_repr('TraitMetadata', [runtime.struct_field('interfaces', self.interfaces), runtime.struct_field('implementations', self.implementations)])

class FunctionEffectEntry:
    def __init__(self, name, effects):
        self.name = name
        self.effects = effects

    def __repr__(self):
        return runtime.struct_repr('FunctionEffectEntry', [runtime.struct_field('name', self.name), runtime.struct_field('effects', self.effects)])

class CapabilityManifestEntry:
    def __init__(self, symbol, effects):
        self.symbol = symbol
        self.effects = effects

    def __repr__(self):
        return runtime.struct_repr('CapabilityManifestEntry', [runtime.struct_field('symbol', self.symbol), runtime.struct_field('effects', self.effects)])

class CapabilityManifest:
    def __init__(self, entries):
        self.entries = entries

    def __repr__(self):
        return runtime.struct_repr('CapabilityManifest', [runtime.struct_field('entries', self.entries)])

class FunctionCallEntry:
    def __init__(self, name, callees):
        self.name = name
        self.callees = callees

    def __repr__(self):
        return runtime.struct_repr('FunctionCallEntry', [runtime.struct_field('name', self.name), runtime.struct_field('callees', self.callees)])

class RuntimeHelperDescriptor:
    def __init__(self, target, symbol, return_type, parameter_types, effects):
        self.target = target
        self.symbol = symbol
        self.return_type = return_type
        self.parameter_types = parameter_types
        self.effects = effects

    def __repr__(self):
        return runtime.struct_repr('RuntimeHelperDescriptor', [runtime.struct_field('target', self.target), runtime.struct_field('symbol', self.symbol), runtime.struct_field('return_type', self.return_type), runtime.struct_field('parameter_types', self.parameter_types), runtime.struct_field('effects', self.effects)])

class StringConstant:
    def __init__(self, name, content, byte_count):
        self.name = name
        self.content = content
        self.byte_count = byte_count

    def __repr__(self):
        return runtime.struct_repr('StringConstant', [runtime.struct_field('name', self.name), runtime.struct_field('content', self.content), runtime.struct_field('byte_count', self.byte_count)])

class StringPointerResult:
    def __init__(self, lines, temp_index, pointer):
        self.lines = lines
        self.temp_index = temp_index
        self.pointer = pointer

    def __repr__(self):
        return runtime.struct_repr('StringPointerResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('pointer', self.pointer)])

class InterpolatedTemplateParse:
    def __init__(self, parts, expressions, success):
        self.parts = parts
        self.expressions = expressions
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('InterpolatedTemplateParse', [runtime.struct_field('parts', self.parts), runtime.struct_field('expressions', self.expressions), runtime.struct_field('success', self.success)])

class LoweredLLVMResult:
    def __init__(self, ir, diagnostics, trait_metadata, function_effects, lifetime_regions, capability_manifest, string_constants):
        self.ir = ir
        self.diagnostics = diagnostics
        self.trait_metadata = trait_metadata
        self.function_effects = function_effects
        self.lifetime_regions = lifetime_regions
        self.capability_manifest = capability_manifest
        self.string_constants = string_constants

    def __repr__(self):
        return runtime.struct_repr('LoweredLLVMResult', [runtime.struct_field('ir', self.ir), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('trait_metadata', self.trait_metadata), runtime.struct_field('function_effects', self.function_effects), runtime.struct_field('lifetime_regions', self.lifetime_regions), runtime.struct_field('capability_manifest', self.capability_manifest), runtime.struct_field('string_constants', self.string_constants)])

class LayoutManifestApplication:
    def __init__(self, structs, enums, diagnostics):
        self.structs = structs
        self.enums = enums
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('LayoutManifestApplication', [runtime.struct_field('structs', self.structs), runtime.struct_field('enums', self.enums), runtime.struct_field('diagnostics', self.diagnostics)])

class ImportedModuleContext:
    def __init__(self, manifests, native_texts, diagnostics):
        self.manifests = manifests
        self.native_texts = native_texts
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('ImportedModuleContext', [runtime.struct_field('manifests', self.manifests), runtime.struct_field('native_texts', self.native_texts), runtime.struct_field('diagnostics', self.diagnostics)])

class LoweredLLVMFunction:
    def __init__(self, lines, diagnostics, lifetime_regions, string_constants):
        self.lines = lines
        self.diagnostics = diagnostics
        self.lifetime_regions = lifetime_regions
        self.string_constants = string_constants

    def __repr__(self):
        return runtime.struct_repr('LoweredLLVMFunction', [runtime.struct_field('lines', self.lines), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('lifetime_regions', self.lifetime_regions), runtime.struct_field('string_constants', self.string_constants)])

class BodyResult:
    def __init__(self, lines, diagnostics, lifetime_regions, string_constants):
        self.lines = lines
        self.diagnostics = diagnostics
        self.lifetime_regions = lifetime_regions
        self.string_constants = string_constants

    def __repr__(self):
        return runtime.struct_repr('BodyResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('lifetime_regions', self.lifetime_regions), runtime.struct_field('string_constants', self.string_constants)])

class ParameterBinding:
    def __init__(self, name, llvm_name, llvm_type, type_annotation, consumed, span=None):
        self.name = name
        self.llvm_name = llvm_name
        self.llvm_type = llvm_type
        self.type_annotation = type_annotation
        self.consumed = consumed
        self.span = span

    def __repr__(self):
        return runtime.struct_repr('ParameterBinding', [runtime.struct_field('name', self.name), runtime.struct_field('llvm_name', self.llvm_name), runtime.struct_field('llvm_type', self.llvm_type), runtime.struct_field('type_annotation', self.type_annotation), runtime.struct_field('consumed', self.consumed), runtime.struct_field('span', self.span)])

class ParameterPreparation:
    def __init__(self, signature, bindings, diagnostics):
        self.signature = signature
        self.bindings = bindings
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('ParameterPreparation', [runtime.struct_field('signature', self.signature), runtime.struct_field('bindings', self.bindings), runtime.struct_field('diagnostics', self.diagnostics)])

class LocalBinding:
    def __init__(self, name, pointer, llvm_type, type_annotation, consumed, scope_id, scope_depth, ownership=None):
        self.name = name
        self.pointer = pointer
        self.llvm_type = llvm_type
        self.type_annotation = type_annotation
        self.ownership = ownership
        self.consumed = consumed
        self.scope_id = scope_id
        self.scope_depth = scope_depth

    def __repr__(self):
        return runtime.struct_repr('LocalBinding', [runtime.struct_field('name', self.name), runtime.struct_field('pointer', self.pointer), runtime.struct_field('llvm_type', self.llvm_type), runtime.struct_field('type_annotation', self.type_annotation), runtime.struct_field('ownership', self.ownership), runtime.struct_field('consumed', self.consumed), runtime.struct_field('scope_id', self.scope_id), runtime.struct_field('scope_depth', self.scope_depth)])

class ModuleGlobalLoweringResult:
    def __init__(self, preamble_lines, init_function_lines, init_function_symbol, needs_init_call, locals, string_constants, diagnostics):
        self.preamble_lines = preamble_lines
        self.init_function_lines = init_function_lines
        self.init_function_symbol = init_function_symbol
        self.needs_init_call = needs_init_call
        self.locals = locals
        self.string_constants = string_constants
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('ModuleGlobalLoweringResult', [runtime.struct_field('preamble_lines', self.preamble_lines), runtime.struct_field('init_function_lines', self.init_function_lines), runtime.struct_field('init_function_symbol', self.init_function_symbol), runtime.struct_field('needs_init_call', self.needs_init_call), runtime.struct_field('locals', self.locals), runtime.struct_field('string_constants', self.string_constants), runtime.struct_field('diagnostics', self.diagnostics)])

class LLVMOperand:
    def __init__(self, llvm_type, value):
        self.llvm_type = llvm_type
        self.value = value

    def __repr__(self):
        return runtime.struct_repr('LLVMOperand', [runtime.struct_field('llvm_type', self.llvm_type), runtime.struct_field('value', self.value)])

class ExpressionResult:
    def __init__(self, lines, temp_index, diagnostics, string_constants, operand=None):
        self.lines = lines
        self.temp_index = temp_index
        self.operand = operand
        self.diagnostics = diagnostics
        self.string_constants = string_constants

    def __repr__(self):
        return runtime.struct_repr('ExpressionResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('operand', self.operand), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('string_constants', self.string_constants)])

class ArrayLiteralMetadata:
    def __init__(self, element_type, start_index):
        self.element_type = element_type
        self.start_index = start_index

    def __repr__(self):
        return runtime.struct_repr('ArrayLiteralMetadata', [runtime.struct_field('element_type', self.element_type), runtime.struct_field('start_index', self.start_index)])

class OwnershipInfo:
    def __init__(self, variant, base, mutable, region_id, span=None):
        self.variant = variant
        self.base = base
        self.mutable = mutable
        self.span = span
        self.region_id = region_id

    def __repr__(self):
        return runtime.struct_repr('OwnershipInfo', [runtime.struct_field('variant', self.variant), runtime.struct_field('base', self.base), runtime.struct_field('mutable', self.mutable), runtime.struct_field('span', self.span), runtime.struct_field('region_id', self.region_id)])

class OwnershipConsumption:
    def __init__(self, kind, name):
        self.kind = kind
        self.name = name

    def __repr__(self):
        return runtime.struct_repr('OwnershipConsumption', [runtime.struct_field('kind', self.kind), runtime.struct_field('name', self.name)])

class LifetimeRegionMetadata:
    def __init__(self, id, binding, base, mutable, scope_id, scope_depth, base_scope_id, base_scope_depth, end_scope_id, end_scope_depth, released, start_span=None):
        self.id = id
        self.binding = binding
        self.base = base
        self.mutable = mutable
        self.start_span = start_span
        self.scope_id = scope_id
        self.scope_depth = scope_depth
        self.base_scope_id = base_scope_id
        self.base_scope_depth = base_scope_depth
        self.end_scope_id = end_scope_id
        self.end_scope_depth = end_scope_depth
        self.released = released

    def __repr__(self):
        return runtime.struct_repr('LifetimeRegionMetadata', [runtime.struct_field('id', self.id), runtime.struct_field('binding', self.binding), runtime.struct_field('base', self.base), runtime.struct_field('mutable', self.mutable), runtime.struct_field('start_span', self.start_span), runtime.struct_field('scope_id', self.scope_id), runtime.struct_field('scope_depth', self.scope_depth), runtime.struct_field('base_scope_id', self.base_scope_id), runtime.struct_field('base_scope_depth', self.base_scope_depth), runtime.struct_field('end_scope_id', self.end_scope_id), runtime.struct_field('end_scope_depth', self.end_scope_depth), runtime.struct_field('released', self.released)])

class LifetimeReleaseEvent:
    def __init__(self, region_id, scope_id, scope_depth):
        self.region_id = region_id
        self.scope_id = scope_id
        self.scope_depth = scope_depth

    def __repr__(self):
        return runtime.struct_repr('LifetimeReleaseEvent', [runtime.struct_field('region_id', self.region_id), runtime.struct_field('scope_id', self.scope_id), runtime.struct_field('scope_depth', self.scope_depth)])

class ScopeMetadata:
    def __init__(self, scope_id, scope_depth):
        self.scope_id = scope_id
        self.scope_depth = scope_depth

    def __repr__(self):
        return runtime.struct_repr('ScopeMetadata', [runtime.struct_field('scope_id', self.scope_id), runtime.struct_field('scope_depth', self.scope_depth)])

class OwnershipAnalysis:
    def __init__(self, diagnostics, ownership=None, consumption=None):
        self.ownership = ownership
        self.consumption = consumption
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('OwnershipAnalysis', [runtime.struct_field('ownership', self.ownership), runtime.struct_field('consumption', self.consumption), runtime.struct_field('diagnostics', self.diagnostics)])

class StructFieldInfo:
    def __init__(self, name, llvm_type, type_annotation, index, offset):
        self.name = name
        self.llvm_type = llvm_type
        self.type_annotation = type_annotation
        self.index = index
        self.offset = offset

    def __repr__(self):
        return runtime.struct_repr('StructFieldInfo', [runtime.struct_field('name', self.name), runtime.struct_field('llvm_type', self.llvm_type), runtime.struct_field('type_annotation', self.type_annotation), runtime.struct_field('index', self.index), runtime.struct_field('offset', self.offset)])

class StructTypeInfo:
    def __init__(self, name, llvm_name, fields, size, align):
        self.name = name
        self.llvm_name = llvm_name
        self.fields = fields
        self.size = size
        self.align = align

    def __repr__(self):
        return runtime.struct_repr('StructTypeInfo', [runtime.struct_field('name', self.name), runtime.struct_field('llvm_name', self.llvm_name), runtime.struct_field('fields', self.fields), runtime.struct_field('size', self.size), runtime.struct_field('align', self.align)])

class EnumVariantInfo:
    def __init__(self, name, tag, offset, size, align, fields):
        self.name = name
        self.tag = tag
        self.offset = offset
        self.size = size
        self.align = align
        self.fields = fields

    def __repr__(self):
        return runtime.struct_repr('EnumVariantInfo', [runtime.struct_field('name', self.name), runtime.struct_field('tag', self.tag), runtime.struct_field('offset', self.offset), runtime.struct_field('size', self.size), runtime.struct_field('align', self.align), runtime.struct_field('fields', self.fields)])

class EnumTypeInfo:
    def __init__(self, name, llvm_name, tag_type, tag_size, tag_align, max_payload_size, size, align, variants):
        self.name = name
        self.llvm_name = llvm_name
        self.tag_type = tag_type
        self.tag_size = tag_size
        self.tag_align = tag_align
        self.max_payload_size = max_payload_size
        self.size = size
        self.align = align
        self.variants = variants

    def __repr__(self):
        return runtime.struct_repr('EnumTypeInfo', [runtime.struct_field('name', self.name), runtime.struct_field('llvm_name', self.llvm_name), runtime.struct_field('tag_type', self.tag_type), runtime.struct_field('tag_size', self.tag_size), runtime.struct_field('tag_align', self.tag_align), runtime.struct_field('max_payload_size', self.max_payload_size), runtime.struct_field('size', self.size), runtime.struct_field('align', self.align), runtime.struct_field('variants', self.variants)])

class VTableEntry:
    def __init__(self, method_name, interface_method_name, function_pointer_type):
        self.method_name = method_name
        self.interface_method_name = interface_method_name
        self.function_pointer_type = function_pointer_type

    def __repr__(self):
        return runtime.struct_repr('VTableEntry', [runtime.struct_field('method_name', self.method_name), runtime.struct_field('interface_method_name', self.interface_method_name), runtime.struct_field('function_pointer_type', self.function_pointer_type)])

class VTableInfo:
    def __init__(self, struct_name, interface_name, llvm_type_name, llvm_global_name, entries):
        self.struct_name = struct_name
        self.interface_name = interface_name
        self.llvm_type_name = llvm_type_name
        self.llvm_global_name = llvm_global_name
        self.entries = entries

    def __repr__(self):
        return runtime.struct_repr('VTableInfo', [runtime.struct_field('struct_name', self.struct_name), runtime.struct_field('interface_name', self.interface_name), runtime.struct_field('llvm_type_name', self.llvm_type_name), runtime.struct_field('llvm_global_name', self.llvm_global_name), runtime.struct_field('entries', self.entries)])

class InterfaceTypeInfo:
    def __init__(self, name, llvm_name, type_parameters, signatures):
        self.name = name
        self.llvm_name = llvm_name
        self.type_parameters = type_parameters
        self.signatures = signatures

    def __repr__(self):
        return runtime.struct_repr('InterfaceTypeInfo', [runtime.struct_field('name', self.name), runtime.struct_field('llvm_name', self.llvm_name), runtime.struct_field('type_parameters', self.type_parameters), runtime.struct_field('signatures', self.signatures)])

class TypeContext:
    def __init__(self, structs, enums, interfaces, vtables):
        self.structs = structs
        self.enums = enums
        self.interfaces = interfaces
        self.vtables = vtables

    def __repr__(self):
        return runtime.struct_repr('TypeContext', [runtime.struct_field('structs', self.structs), runtime.struct_field('enums', self.enums), runtime.struct_field('interfaces', self.interfaces), runtime.struct_field('vtables', self.vtables)])

class TypeContextBuild:
    def __init__(self, context, diagnostics):
        self.context = context
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('TypeContextBuild', [runtime.struct_field('context', self.context), runtime.struct_field('diagnostics', self.diagnostics)])

class TypeAllocationInfo:
    def __init__(self, llvm_type, size, align):
        self.llvm_type = llvm_type
        self.size = size
        self.align = align

    def __repr__(self):
        return runtime.struct_repr('TypeAllocationInfo', [runtime.struct_field('llvm_type', self.llvm_type), runtime.struct_field('size', self.size), runtime.struct_field('align', self.align)])

class HeapBoxResult:
    def __init__(self, lines, temp_index, diagnostics, operand=None):
        self.lines = lines
        self.temp_index = temp_index
        self.operand = operand
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('HeapBoxResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('operand', self.operand), runtime.struct_field('diagnostics', self.diagnostics)])

class StructLiteralField:
    def __init__(self, name, value):
        self.name = name
        self.value = value

    def __repr__(self):
        return runtime.struct_repr('StructLiteralField', [runtime.struct_field('name', self.name), runtime.struct_field('value', self.value)])

class StructLiteralParse:
    def __init__(self, recognized, success, type_name, fields, diagnostics):
        self.recognized = recognized
        self.success = success
        self.type_name = type_name
        self.fields = fields
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('StructLiteralParse', [runtime.struct_field('recognized', self.recognized), runtime.struct_field('success', self.success), runtime.struct_field('type_name', self.type_name), runtime.struct_field('fields', self.fields), runtime.struct_field('diagnostics', self.diagnostics)])

class EnumLiteralParse:
    def __init__(self, recognized, success, enum_name, variant_name, fields, diagnostics):
        self.recognized = recognized
        self.success = success
        self.enum_name = enum_name
        self.variant_name = variant_name
        self.fields = fields
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('EnumLiteralParse', [runtime.struct_field('recognized', self.recognized), runtime.struct_field('success', self.success), runtime.struct_field('enum_name', self.enum_name), runtime.struct_field('variant_name', self.variant_name), runtime.struct_field('fields', self.fields), runtime.struct_field('diagnostics', self.diagnostics)])

class MemberAccessParse:
    def __init__(self, success, base, field):
        self.success = success
        self.base = base
        self.field = field

    def __repr__(self):
        return runtime.struct_repr('MemberAccessParse', [runtime.struct_field('success', self.success), runtime.struct_field('base', self.base), runtime.struct_field('field', self.field)])

class IndexExpressionParse:
    def __init__(self, success, base, index):
        self.success = success
        self.base = base
        self.index = index

    def __repr__(self):
        return runtime.struct_repr('IndexExpressionParse', [runtime.struct_field('success', self.success), runtime.struct_field('base', self.base), runtime.struct_field('index', self.index)])

class LocalMutation:
    def __init__(self, name, llvm_type, value_name, originating_label, span=None):
        self.name = name
        self.llvm_type = llvm_type
        self.value_name = value_name
        self.span = span
        self.originating_label = originating_label

    def __repr__(self):
        return runtime.struct_repr('LocalMutation', [runtime.struct_field('name', self.name), runtime.struct_field('llvm_type', self.llvm_type), runtime.struct_field('value_name', self.value_name), runtime.struct_field('span', self.span), runtime.struct_field('originating_label', self.originating_label)])

class OperatorMatch:
    def __init__(self, index, symbol, success):
        self.index = index
        self.symbol = symbol
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('OperatorMatch', [runtime.struct_field('index', self.index), runtime.struct_field('symbol', self.symbol), runtime.struct_field('success', self.success)])

class AssignmentParseResult:
    def __init__(self, success, target, value, operator):
        self.success = success
        self.target = target
        self.value = value
        self.operator = operator

    def __repr__(self):
        return runtime.struct_repr('AssignmentParseResult', [runtime.struct_field('success', self.success), runtime.struct_field('target', self.target), runtime.struct_field('value', self.value), runtime.struct_field('operator', self.operator)])

class BorrowParseResult:
    def __init__(self, recognized, success, target, mutable, diagnostics):
        self.recognized = recognized
        self.success = success
        self.target = target
        self.mutable = mutable
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('BorrowParseResult', [runtime.struct_field('recognized', self.recognized), runtime.struct_field('success', self.success), runtime.struct_field('target', self.target), runtime.struct_field('mutable', self.mutable), runtime.struct_field('diagnostics', self.diagnostics)])

class BorrowArgumentParse:
    def __init__(self, success, argument, diagnostics):
        self.success = success
        self.argument = argument
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('BorrowArgumentParse', [runtime.struct_field('success', self.success), runtime.struct_field('argument', self.argument), runtime.struct_field('diagnostics', self.diagnostics)])

class RawAddressParseResult:
    def __init__(self, recognized, success, target, diagnostics):
        self.recognized = recognized
        self.success = success
        self.target = target
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('RawAddressParseResult', [runtime.struct_field('recognized', self.recognized), runtime.struct_field('success', self.success), runtime.struct_field('target', self.target), runtime.struct_field('diagnostics', self.diagnostics)])

class CastParseResult:
    def __init__(self, recognized, success, value, type_annotation, diagnostics):
        self.recognized = recognized
        self.success = success
        self.value = value
        self.type_annotation = type_annotation
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('CastParseResult', [runtime.struct_field('recognized', self.recognized), runtime.struct_field('success', self.success), runtime.struct_field('value', self.value), runtime.struct_field('type_annotation', self.type_annotation), runtime.struct_field('diagnostics', self.diagnostics)])

class TernaryParseResult:
    def __init__(self, success, condition, true_value, false_value, diagnostics):
        self.success = success
        self.condition = condition
        self.true_value = true_value
        self.false_value = false_value
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('TernaryParseResult', [runtime.struct_field('success', self.success), runtime.struct_field('condition', self.condition), runtime.struct_field('true_value', self.true_value), runtime.struct_field('false_value', self.false_value), runtime.struct_field('diagnostics', self.diagnostics)])

class ExpressionStatementResult:
    def __init__(self, lines, temp_index, locals, bindings, diagnostics, lifetime_regions, lifetime_releases, next_region_id, mutations, string_constants):
        self.lines = lines
        self.temp_index = temp_index
        self.locals = locals
        self.bindings = bindings
        self.diagnostics = diagnostics
        self.lifetime_regions = lifetime_regions
        self.lifetime_releases = lifetime_releases
        self.next_region_id = next_region_id
        self.mutations = mutations
        self.string_constants = string_constants

    def __repr__(self):
        return runtime.struct_repr('ExpressionStatementResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('locals', self.locals), runtime.struct_field('bindings', self.bindings), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('lifetime_regions', self.lifetime_regions), runtime.struct_field('lifetime_releases', self.lifetime_releases), runtime.struct_field('next_region_id', self.next_region_id), runtime.struct_field('mutations', self.mutations), runtime.struct_field('string_constants', self.string_constants)])

class LetLoweringResult:
    def __init__(self, lines, allocas, locals, bindings, temp_index, diagnostics, next_local_id, lifetime_regions, lifetime_releases, next_region_id, mutations, string_constants):
        self.lines = lines
        self.allocas = allocas
        self.locals = locals
        self.bindings = bindings
        self.temp_index = temp_index
        self.diagnostics = diagnostics
        self.next_local_id = next_local_id
        self.lifetime_regions = lifetime_regions
        self.lifetime_releases = lifetime_releases
        self.next_region_id = next_region_id
        self.mutations = mutations
        self.string_constants = string_constants

    def __repr__(self):
        return runtime.struct_repr('LetLoweringResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('allocas', self.allocas), runtime.struct_field('locals', self.locals), runtime.struct_field('bindings', self.bindings), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('next_local_id', self.next_local_id), runtime.struct_field('lifetime_regions', self.lifetime_regions), runtime.struct_field('lifetime_releases', self.lifetime_releases), runtime.struct_field('next_region_id', self.next_region_id), runtime.struct_field('mutations', self.mutations), runtime.struct_field('string_constants', self.string_constants)])

class InlineLetParseResult:
    def __init__(self, success, name, mutable, type_annotation, diagnostics, initializer=None):
        self.success = success
        self.name = name
        self.mutable = mutable
        self.type_annotation = type_annotation
        self.initializer = initializer
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('InlineLetParseResult', [runtime.struct_field('success', self.success), runtime.struct_field('name', self.name), runtime.struct_field('mutable', self.mutable), runtime.struct_field('type_annotation', self.type_annotation), runtime.struct_field('initializer', self.initializer), runtime.struct_field('diagnostics', self.diagnostics)])

class BlockLabelResult:
    def __init__(self, label, next_counter):
        self.label = label
        self.next_counter = next_counter

    def __repr__(self):
        return runtime.struct_repr('BlockLabelResult', [runtime.struct_field('label', self.label), runtime.struct_field('next_counter', self.next_counter)])

class IfStructure:
    def __init__(self, then_start, then_end, else_start, else_end, has_else, next_index, diagnostics):
        self.then_start = then_start
        self.then_end = then_end
        self.else_start = else_start
        self.else_end = else_end
        self.has_else = has_else
        self.next_index = next_index
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('IfStructure', [runtime.struct_field('then_start', self.then_start), runtime.struct_field('then_end', self.then_end), runtime.struct_field('else_start', self.else_start), runtime.struct_field('else_end', self.else_end), runtime.struct_field('has_else', self.has_else), runtime.struct_field('next_index', self.next_index), runtime.struct_field('diagnostics', self.diagnostics)])

class LoopContext:
    def __init__(self, break_label, continue_label):
        self.break_label = break_label
        self.continue_label = continue_label

    def __repr__(self):
        return runtime.struct_repr('LoopContext', [runtime.struct_field('break_label', self.break_label), runtime.struct_field('continue_label', self.continue_label)])

class LoopStructure:
    def __init__(self, body_start, body_end, next_index, diagnostics):
        self.body_start = body_start
        self.body_end = body_end
        self.next_index = next_index
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('LoopStructure', [runtime.struct_field('body_start', self.body_start), runtime.struct_field('body_end', self.body_end), runtime.struct_field('next_index', self.next_index), runtime.struct_field('diagnostics', self.diagnostics)])

class TryStructure:
    def __init__(self, try_start, try_end, catch_index, catch_name, catch_start, catch_end, finally_index, finally_start, finally_end, end_index, next_index, diagnostics):
        self.try_start = try_start
        self.try_end = try_end
        self.catch_index = catch_index
        self.catch_name = catch_name
        self.catch_start = catch_start
        self.catch_end = catch_end
        self.finally_index = finally_index
        self.finally_start = finally_start
        self.finally_end = finally_end
        self.end_index = end_index
        self.next_index = next_index
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('TryStructure', [runtime.struct_field('try_start', self.try_start), runtime.struct_field('try_end', self.try_end), runtime.struct_field('catch_index', self.catch_index), runtime.struct_field('catch_name', self.catch_name), runtime.struct_field('catch_start', self.catch_start), runtime.struct_field('catch_end', self.catch_end), runtime.struct_field('finally_index', self.finally_index), runtime.struct_field('finally_start', self.finally_start), runtime.struct_field('finally_end', self.finally_end), runtime.struct_field('end_index', self.end_index), runtime.struct_field('next_index', self.next_index), runtime.struct_field('diagnostics', self.diagnostics)])

class RangeIterableParse:
    def __init__(self, success, start, end, stride, diagnostics):
        self.success = success
        self.start = start
        self.end = end
        self.stride = stride
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('RangeIterableParse', [runtime.struct_field('success', self.success), runtime.struct_field('start', self.start), runtime.struct_field('end', self.end), runtime.struct_field('stride', self.stride), runtime.struct_field('diagnostics', self.diagnostics)])

class MatchCaseStructure:
    def __init__(self, pattern, body_start, body_end, is_default, guard=None):
        self.pattern = pattern
        self.guard = guard
        self.body_start = body_start
        self.body_end = body_end
        self.is_default = is_default

    def __repr__(self):
        return runtime.struct_repr('MatchCaseStructure', [runtime.struct_field('pattern', self.pattern), runtime.struct_field('guard', self.guard), runtime.struct_field('body_start', self.body_start), runtime.struct_field('body_end', self.body_end), runtime.struct_field('is_default', self.is_default)])

class MatchStructure:
    def __init__(self, cases, end_index, diagnostics):
        self.cases = cases
        self.end_index = end_index
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('MatchStructure', [runtime.struct_field('cases', self.cases), runtime.struct_field('end_index', self.end_index), runtime.struct_field('diagnostics', self.diagnostics)])

class MatchFieldBinding:
    def __init__(self, field_name, field_type, field_offset):
        self.field_name = field_name
        self.field_type = field_type
        self.field_offset = field_offset

    def __repr__(self):
        return runtime.struct_repr('MatchFieldBinding', [runtime.struct_field('field_name', self.field_name), runtime.struct_field('field_type', self.field_type), runtime.struct_field('field_offset', self.field_offset)])

class MatchStructFieldBinding:
    def __init__(self, field_name, field_type, field_index):
        self.field_name = field_name
        self.field_type = field_type
        self.field_index = field_index

    def __repr__(self):
        return runtime.struct_repr('MatchStructFieldBinding', [runtime.struct_field('field_name', self.field_name), runtime.struct_field('field_type', self.field_type), runtime.struct_field('field_index', self.field_index)])

class MatchCaseCondition:
    def __init__(self, lines, temp_index, diagnostics, is_default, field_bindings, union_variant_index, union_struct_bindings, string_constants, operand=None, enum_info=None, variant_info=None, union_struct_info=None):
        self.lines = lines
        self.temp_index = temp_index
        self.operand = operand
        self.diagnostics = diagnostics
        self.is_default = is_default
        self.field_bindings = field_bindings
        self.enum_info = enum_info
        self.variant_info = variant_info
        self.union_variant_index = union_variant_index
        self.union_struct_info = union_struct_info
        self.union_struct_bindings = union_struct_bindings
        self.string_constants = string_constants

    def __repr__(self):
        return runtime.struct_repr('MatchCaseCondition', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('operand', self.operand), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('is_default', self.is_default), runtime.struct_field('field_bindings', self.field_bindings), runtime.struct_field('enum_info', self.enum_info), runtime.struct_field('variant_info', self.variant_info), runtime.struct_field('union_variant_index', self.union_variant_index), runtime.struct_field('union_struct_info', self.union_struct_info), runtime.struct_field('union_struct_bindings', self.union_struct_bindings), runtime.struct_field('string_constants', self.string_constants)])

class ConditionConversion:
    def __init__(self, lines, temp_index, diagnostics, string_constants, operand=None):
        self.lines = lines
        self.temp_index = temp_index
        self.operand = operand
        self.diagnostics = diagnostics
        self.string_constants = string_constants

    def __repr__(self):
        return runtime.struct_repr('ConditionConversion', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('operand', self.operand), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('string_constants', self.string_constants)])

class ComparisonEmission:
    def __init__(self, lines, temp_index, diagnostics, operand=None):
        self.lines = lines
        self.temp_index = temp_index
        self.operand = operand
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('ComparisonEmission', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('operand', self.operand), runtime.struct_field('diagnostics', self.diagnostics)])

class CoercionResult:
    def __init__(self, lines, temp_index, diagnostics, operand=None):
        self.lines = lines
        self.temp_index = temp_index
        self.operand = operand
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('CoercionResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('operand', self.operand), runtime.struct_field('diagnostics', self.diagnostics)])

class BinaryAlignmentResult:
    def __init__(self, lines, temp_index, diagnostics, result_type, left=None, right=None):
        self.lines = lines
        self.temp_index = temp_index
        self.left = left
        self.right = right
        self.diagnostics = diagnostics
        self.result_type = result_type

    def __repr__(self):
        return runtime.struct_repr('BinaryAlignmentResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('left', self.left), runtime.struct_field('right', self.right), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('result_type', self.result_type)])

class BlockLoweringResult:
    def __init__(self, lines, allocas, locals, bindings, temp_index, block_counter, diagnostics, terminated, next_local_id, lifetime_regions, next_lifetime_region_id, next_index, mutations, string_constants):
        self.lines = lines
        self.allocas = allocas
        self.locals = locals
        self.bindings = bindings
        self.temp_index = temp_index
        self.block_counter = block_counter
        self.diagnostics = diagnostics
        self.terminated = terminated
        self.next_local_id = next_local_id
        self.lifetime_regions = lifetime_regions
        self.next_lifetime_region_id = next_lifetime_region_id
        self.next_index = next_index
        self.mutations = mutations
        self.string_constants = string_constants

    def __repr__(self):
        return runtime.struct_repr('BlockLoweringResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('allocas', self.allocas), runtime.struct_field('locals', self.locals), runtime.struct_field('bindings', self.bindings), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('block_counter', self.block_counter), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('terminated', self.terminated), runtime.struct_field('next_local_id', self.next_local_id), runtime.struct_field('lifetime_regions', self.lifetime_regions), runtime.struct_field('next_lifetime_region_id', self.next_lifetime_region_id), runtime.struct_field('next_index', self.next_index), runtime.struct_field('mutations', self.mutations), runtime.struct_field('string_constants', self.string_constants)])

class ThrowLoweringResult:
    def __init__(self, lines, temp_index, diagnostics, terminated, string_constants):
        self.lines = lines
        self.temp_index = temp_index
        self.diagnostics = diagnostics
        self.terminated = terminated
        self.string_constants = string_constants

    def __repr__(self):
        return runtime.struct_repr('ThrowLoweringResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('terminated', self.terminated), runtime.struct_field('string_constants', self.string_constants)])

class PhiMergeResult:
    def __init__(self, lines, temp_index):
        self.lines = lines
        self.temp_index = temp_index

    def __repr__(self):
        return runtime.struct_repr('PhiMergeResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index)])

class PhiInputEntry:
    def __init__(self, label, value_name):
        self.label = label
        self.value_name = value_name

    def __repr__(self):
        return runtime.struct_repr('PhiInputEntry', [runtime.struct_field('label', self.label), runtime.struct_field('value_name', self.value_name)])

class MutationMaterializationResult:
    def __init__(self, lines, mutations, temp_index):
        self.lines = lines
        self.mutations = mutations
        self.temp_index = temp_index

    def __repr__(self):
        return runtime.struct_repr('MutationMaterializationResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('mutations', self.mutations), runtime.struct_field('temp_index', self.temp_index)])

class PhiStoreEntry:
    def __init__(self, phi_line, store_line):
        self.phi_line = phi_line
        self.store_line = store_line

    def __repr__(self):
        return runtime.struct_repr('PhiStoreEntry', [runtime.struct_field('phi_line', self.phi_line), runtime.struct_field('store_line', self.store_line)])

class MatchArmMutations:
    def __init__(self, mutations, label, terminated):
        self.mutations = mutations
        self.label = label
        self.terminated = terminated

    def __repr__(self):
        return runtime.struct_repr('MatchArmMutations', [runtime.struct_field('mutations', self.mutations), runtime.struct_field('label', self.label), runtime.struct_field('terminated', self.terminated)])

class LoadLocalResult:
    def __init__(self, lines, temp_index, diagnostics, operand=None):
        self.lines = lines
        self.temp_index = temp_index
        self.operand = operand
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('LoadLocalResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('operand', self.operand), runtime.struct_field('diagnostics', self.diagnostics)])

