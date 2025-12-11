import asyncio
from runtime import runtime_support as runtime

from compiler.build.emit_native import NativeModule
from compiler.build.native_ir import select_text_artifact, select_layout_manifest_artifact, parse_native_artifact, parse_layout_manifest, NativeFunction, NativeInstruction, NativeParameter, NativeInterface, NativeInterfaceSignature, NativeStruct, NativeEnum, NativeSourceSpan, NativeImport, LayoutManifest
from compiler.build.string_utils import substring, char_code, char_at

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

class RuntimeHelperDescriptor:
    def __init__(self, target, symbol, return_type, parameter_types, effects):
        self.target = target
        self.symbol = symbol
        self.return_type = return_type
        self.parameter_types = parameter_types
        self.effects = effects

    def __repr__(self):
        return runtime.struct_repr('RuntimeHelperDescriptor', [runtime.struct_field('target', self.target), runtime.struct_field('symbol', self.symbol), runtime.struct_field('return_type', self.return_type), runtime.struct_field('parameter_types', self.parameter_types), runtime.struct_field('effects', self.effects)])

class FunctionCallEntry:
    def __init__(self, name, callees):
        self.name = name
        self.callees = callees

    def __repr__(self):
        return runtime.struct_repr('FunctionCallEntry', [runtime.struct_field('name', self.name), runtime.struct_field('callees', self.callees)])

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

class StructFieldInfo:
    def __init__(self, name, llvm_type, index, offset):
        self.name = name
        self.llvm_type = llvm_type
        self.index = index
        self.offset = offset

    def __repr__(self):
        return runtime.struct_repr('StructFieldInfo', [runtime.struct_field('name', self.name), runtime.struct_field('llvm_type', self.llvm_type), runtime.struct_field('index', self.index), runtime.struct_field('offset', self.offset)])

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
    def __init__(self, name, llvm_name, tag_type, tag_size, tag_align, size, align, variants):
        self.name = name
        self.llvm_name = llvm_name
        self.tag_type = tag_type
        self.tag_size = tag_size
        self.tag_align = tag_align
        self.size = size
        self.align = align
        self.variants = variants

    def __repr__(self):
        return runtime.struct_repr('EnumTypeInfo', [runtime.struct_field('name', self.name), runtime.struct_field('llvm_name', self.llvm_name), runtime.struct_field('tag_type', self.tag_type), runtime.struct_field('tag_size', self.tag_size), runtime.struct_field('tag_align', self.tag_align), runtime.struct_field('size', self.size), runtime.struct_field('align', self.align), runtime.struct_field('variants', self.variants)])

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

class LocalMutation:
    def __init__(self, name, llvm_type, value_name, originating_label, span=None):
        self.name = name
        self.llvm_type = llvm_type
        self.value_name = value_name
        self.span = span
        self.originating_label = originating_label

    def __repr__(self):
        return runtime.struct_repr('LocalMutation', [runtime.struct_field('name', self.name), runtime.struct_field('llvm_type', self.llvm_type), runtime.struct_field('value_name', self.value_name), runtime.struct_field('span', self.span), runtime.struct_field('originating_label', self.originating_label)])

class OwnershipAnalysis:
    def __init__(self, diagnostics, ownership=None, consumption=None):
        self.ownership = ownership
        self.consumption = consumption
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('OwnershipAnalysis', [runtime.struct_field('ownership', self.ownership), runtime.struct_field('consumption', self.consumption), runtime.struct_field('diagnostics', self.diagnostics)])

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
    def __init__(self, lines, allocas, locals, bindings, temp_index, diagnostics, next_local_id, lifetime_regions, next_region_id, mutations, string_constants):
        self.lines = lines
        self.allocas = allocas
        self.locals = locals
        self.bindings = bindings
        self.temp_index = temp_index
        self.diagnostics = diagnostics
        self.next_local_id = next_local_id
        self.lifetime_regions = lifetime_regions
        self.next_region_id = next_region_id
        self.mutations = mutations
        self.string_constants = string_constants

    def __repr__(self):
        return runtime.struct_repr('LetLoweringResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('allocas', self.allocas), runtime.struct_field('locals', self.locals), runtime.struct_field('bindings', self.bindings), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('next_local_id', self.next_local_id), runtime.struct_field('lifetime_regions', self.lifetime_regions), runtime.struct_field('next_region_id', self.next_region_id), runtime.struct_field('mutations', self.mutations), runtime.struct_field('string_constants', self.string_constants)])

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

class MatchCaseCondition:
    def __init__(self, lines, temp_index, diagnostics, is_default, field_bindings, string_constants, operand=None, enum_info=None, variant_info=None):
        self.lines = lines
        self.temp_index = temp_index
        self.operand = operand
        self.diagnostics = diagnostics
        self.is_default = is_default
        self.field_bindings = field_bindings
        self.enum_info = enum_info
        self.variant_info = variant_info
        self.string_constants = string_constants

    def __repr__(self):
        return runtime.struct_repr('MatchCaseCondition', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('operand', self.operand), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('is_default', self.is_default), runtime.struct_field('field_bindings', self.field_bindings), runtime.struct_field('enum_info', self.enum_info), runtime.struct_field('variant_info', self.variant_info), runtime.struct_field('string_constants', self.string_constants)])

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

class PhiMergeResult:
    def __init__(self, lines, temp_index):
        self.lines = lines
        self.temp_index = temp_index

    def __repr__(self):
        return runtime.struct_repr('PhiMergeResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index)])

class PhiInputEntry:
    def __init__(self, value, label):
        self.value = value
        self.label = label

    def __repr__(self):
        return runtime.struct_repr('PhiInputEntry', [runtime.struct_field('value', self.value), runtime.struct_field('label', self.label)])

class MutationMaterializationResult:
    def __init__(self, mutations, lines, temp_index):
        self.mutations = mutations
        self.lines = lines
        self.temp_index = temp_index

    def __repr__(self):
        return runtime.struct_repr('MutationMaterializationResult', [runtime.struct_field('mutations', self.mutations), runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index)])

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

def load_imported_layout_manifests(imports):
    # effects: io
    context = collect_imported_module_context(imports)
    return context.manifests

def collect_imported_module_context(imports):
    # effects: io
    manifests = []
    native_texts = []
    diagnostics = []
    seen = []
    index = 0
    while True:
        if index >= len(imports):
            break
        module_path = imports[index].module
        slug = resolve_import_module_slug(module_path)
        if len(slug) == 0:
            index += 1
            continue
        if string_array_contains(seen, slug):
            index += 1
            continue
        seen = append_string(seen, slug)
        manifest_path = layout_manifest_path_for_slug(slug)
        native_text_path = native_text_path_for_slug(slug)
        manifest_structs = []
        manifest_enums = []
        if fs.exists(manifest_path):
            manifest_contents = fs.readFile(manifest_path)
            parsed_manifest = parse_layout_manifest(manifest_contents)
            manifest_structs = parsed_manifest.structs
            manifest_enums = parsed_manifest.enums
        else:
            diagnostics = (diagnostics) + (["layout manifest: missing artifact for import `" + module_path + "` (expected " + manifest_path + ")"])
        native_text = ""
        if fs.exists(native_text_path):
            native_text = fs.readFile(native_text_path)
        else:
            diagnostics = (diagnostics) + (["native lowering: missing native text artifact for import `" + module_path + "` (expected " + native_text_path + ")"])
        manifests = (manifests) + ([LayoutManifest(structs=manifest_structs, enums=manifest_enums, diagnostics=[])])
        native_texts = (native_texts) + ([native_text])
        index += 1
    return ImportedModuleContext(manifests=manifests, native_texts=native_texts, diagnostics=diagnostics)

def resolve_import_module_slug(module):
    trimmed = trim_text(module)
    if len(trimmed) == 0:
        return ""
    normalized = normalize_import_module_path(trimmed)
    start_index = 0
    while True:
        if start_index >= len(normalized):
            break
        ch = normalized[start_index]
        if ch == "."  or  ch == "/":
            start_index += 1
            continue
        break
    candidate = normalized
    if start_index > 0:
        candidate = substring(normalized, start_index, len(normalized))
    last_slash = find_last_index_of_char(candidate, "/")
    if last_slash >= 0:
        return substring(candidate, last_slash + 1, len(candidate))
    return candidate

def layout_manifest_path_for_slug(slug):
    return "build/stage2/" + slug + ".layout-manifest"

def native_text_path_for_slug(slug):
    return "build/stage2/" + slug + ".sfn-asm"

def normalize_import_module_path(value):
    result = ""
    index = 0
    while True:
        if index >= len(value):
            break
        ch = value[index]
        if ch == "\\":
            result = result + "/"
        else:
            result = result + ch
        index += 1
    return result

def apply_layout_manifest_to_module(structs, enums, manifest):
    if manifest == None:
        return LayoutManifestApplication(structs=structs, enums=enums, diagnostics=[])
    return apply_layout_manifest_entries(structs, enums, manifest)

def apply_layout_manifest_entries(structs, enums, manifest):
    diagnostics = []
    updated_structs = structs
    struct_index = 0
    while True:
        if struct_index >= len(manifest.structs):
            break
        layout_struct = manifest.structs[struct_index]
        target_index = find_struct_index(updated_structs, layout_struct.name)
        if target_index < 0:
            diagnostics = append_string(diagnostics, "layout manifest: struct `" + layout_struct.name + "` missing from native module")
        else:
            target = updated_structs[target_index]
            replaced = NativeStruct(name=target.name, fields=target.fields, methods=target.methods, implements=target.implements, layout=layout_struct.layout)
            updated_structs = replace_native_struct(updated_structs, target_index, replaced)
        struct_index += 1
    updated_enums = enums
    enum_index = 0
    while True:
        if enum_index >= len(manifest.enums):
            break
        layout_enum = manifest.enums[enum_index]
        target_index = find_enum_index(updated_enums, layout_enum.name)
        if target_index < 0:
            diagnostics = append_string(diagnostics, "layout manifest: enum `" + layout_enum.name + "` missing from native module")
        else:
            target = updated_enums[target_index]
            replaced = NativeEnum(name=target.name, variants=target.variants, layout=layout_enum.layout)
            updated_enums = replace_native_enum(updated_enums, target_index, replaced)
        enum_index += 1
    return LayoutManifestApplication(structs=updated_structs, enums=updated_enums, diagnostics=diagnostics)

def lower_to_llvm(native_module):
    # effects: io
    artifact = select_text_artifact(native_module.artifacts)
    if artifact == None:
        return lower_to_llvm_with_context(native_module, [], [], [])
    parse = parse_native_artifact(artifact.contents)
    import_context = collect_imported_module_context(parse.imports)
    return lower_to_llvm_with_context(native_module, import_context.manifests, import_context.native_texts, import_context.diagnostics)

def lower_to_llvm_with_manifests(native_module, imported_manifests):
    return lower_to_llvm_with_context(native_module, imported_manifests, [], [])

def lower_to_llvm_with_context(native_module, imported_manifests, imported_native_texts, imported_diagnostics):
    diagnostics = []
    if len(imported_diagnostics) > 0:
        diagnostics = (diagnostics) + (imported_diagnostics)
    artifact = select_text_artifact(native_module.artifacts)
    if artifact == None:
        diagnostics = append_string(diagnostics, "no sailfin-native-text artifact present")
        empty_constants = empty_string_constant_set()
        return LoweredLLVMResult(ir="", diagnostics=diagnostics, trait_metadata=empty_trait_metadata(), function_effects=[], lifetime_regions=[], capability_manifest=empty_capability_manifest(), string_constants=empty_constants)
    parse = parse_native_artifact(artifact.contents)
    diagnostics = (diagnostics) + (parse.diagnostics)
    manifest_artifact = select_layout_manifest_artifact(native_module.artifacts)
    module_manifest = None
    if manifest_artifact != None:
        parsed_manifest = parse_layout_manifest(manifest_artifact.contents)
        diagnostics = (diagnostics) + (parsed_manifest.diagnostics)
        module_manifest = parsed_manifest
    manifest_application = apply_layout_manifest_to_module(parse.structs, parse.enums, module_manifest)
    diagnostics = (diagnostics) + (manifest_application.diagnostics)
    module_structs = manifest_application.structs
    module_enums = manifest_application.enums
    imported_structs = []
    imported_enums = []
    imported_interfaces = []
    imported_functions = []
    imported_struct_methods = []
    manifest_count = len(imported_manifests)
    text_index = 0
    while True:
        if text_index >= len(imported_native_texts):
            break
        native_text = imported_native_texts[text_index]
        manifest_for_module = None
        if text_index < manifest_count:
            candidate_manifest = imported_manifests[text_index]
            manifest_for_module = candidate_manifest
        if len(native_text) == 0:
            if manifest_for_module != None:
                manifest_only = manifest_for_module
                imported_structs = (imported_structs) + (manifest_only.structs)
                imported_enums = (imported_enums) + (manifest_only.enums)
            text_index += 1
            continue
        imported_parse = parse_native_artifact(native_text)
        applied_import = apply_layout_manifest_to_module(imported_parse.structs, imported_parse.enums, manifest_for_module)
        imported_structs = (imported_structs) + (applied_import.structs)
        imported_enums = (imported_enums) + (applied_import.enums)
        imported_interfaces = (imported_interfaces) + (imported_parse.interfaces)
        imported_functions = (imported_functions) + (imported_parse.functions)
        imported_methods = flatten_struct_methods(applied_import.structs)
        imported_struct_methods = (imported_struct_methods) + (imported_methods)
        text_index += 1
    if len(imported_native_texts) < manifest_count:
        manifest_index = len(imported_native_texts)
        while True:
            if manifest_index >= manifest_count:
                break
            leftover_manifest = imported_manifests[manifest_index]
            imported_structs = (imported_structs) + (leftover_manifest.structs)
            imported_enums = (imported_enums) + (leftover_manifest.enums)
            manifest_index += 1
    combined_structs = (module_structs) + (imported_structs)
    combined_enums = (module_enums) + (imported_enums)
    combined_interfaces = (parse.interfaces) + (imported_interfaces)
    trait_metadata = build_trait_metadata(combined_interfaces, combined_structs)
    type_build = build_type_context(combined_structs, combined_enums, combined_interfaces)
    diagnostics = (diagnostics) + (type_build.diagnostics)
    type_context = type_build.context
    module_struct_methods = flatten_struct_methods(module_structs)
    local_functions = concat_native_functions(parse.functions, module_struct_methods)
    context_functions = concat_native_functions(local_functions, imported_functions)
    context_functions = concat_native_functions(context_functions, imported_struct_methods)
    runtime_helpers = collect_runtime_helper_targets(local_functions)
    runtime_helpers = append_unique_effect(runtime_helpers, "get_field")
    runtime_helpers = append_unique_effect(runtime_helpers, "string.concat")
    runtime_helpers = append_unique_effect(runtime_helpers, "strings_equal")
    runtime_helpers = append_unique_effect(runtime_helpers, "runtime.bounds_check")
    direct_effects = collect_direct_function_effects(context_functions)
    call_graph = collect_function_call_graph(context_functions)
    aggregated_effects = propagate_function_effects(direct_effects, call_graph)
    function_effects = []
    lifetime_regions = []
    lines = []
    lines = append_string(lines, "; ModuleID = 'sailfin'")
    lines = append_string(lines, "source_filename = \"sailfin\"")
    lines = append_string(lines, "")
    trait_lines = render_trait_metadata_comments(trait_metadata)
    if len(trait_lines) > 0:
        lines = (lines) + (trait_lines)
        lines = append_string(lines, "")
    struct_type_lines = render_struct_type_definitions(type_context, context_functions)
    if len(struct_type_lines) > 0:
        lines = (lines) + (struct_type_lines)
        lines = append_string(lines, "")
    enum_type_lines = render_enum_type_definitions(type_context)
    if len(enum_type_lines) > 0:
        lines = (lines) + (enum_type_lines)
        lines = append_string(lines, "")
    interface_type_lines = render_interface_type_definitions(type_context)
    if len(interface_type_lines) > 0:
        lines = (lines) + (interface_type_lines)
        lines = append_string(lines, "")
    vtable_type_lines = render_vtable_type_definitions(type_context)
    if len(vtable_type_lines) > 0:
        lines = (lines) + (vtable_type_lines)
        lines = append_string(lines, "")
    vtable_const_lines = render_vtable_constants(type_context)
    if len(vtable_const_lines) > 0:
        lines = (lines) + (vtable_const_lines)
        lines = append_string(lines, "")
    helper_declarations = render_runtime_helper_declarations(runtime_helpers, local_functions)
    if len(helper_declarations) > 0:
        lines = (lines) + (helper_declarations)
        lines = append_string(lines, "")
    imported_declarations = render_imported_function_declarations(imported_functions, local_functions, type_context)
    if len(imported_declarations) > 0:
        lines = (lines) + (imported_declarations)
        lines = append_string(lines, "")
    lines = append_string(lines, "declare noalias i8* @malloc(i64)")
    lines = append_string(lines, "")
    lines = append_string(lines, "@runtime = external global i8**")
    lines = append_string(lines, "")
    preamble_lines = lines
    function_lines = []
    index = 0
    has_add_function = False
    all_string_constants = empty_string_constant_set()
    while True:
        if index >= len(local_functions):
            break
        current_function = local_functions[index]
        aggregated_entry = find_function_effect_entry(aggregated_effects, current_function.name)
        effective_effects = []
        if aggregated_entry != None:
            effective_effects = aggregated_entry.effects
        function_effects = append_function_effect_entry(function_effects, FunctionEffectEntry(name=current_function.name, effects=effective_effects))
        lowered = emit_function(current_function, context_functions, effective_effects, type_context)
        if sanitize_symbol(current_function.name) == "add":
            has_add_function = True
        diagnostics = (diagnostics) + (lowered.diagnostics)
        lifetime_regions = (lifetime_regions) + (lowered.lifetime_regions)
        all_string_constants = merge_string_constants(all_string_constants, lowered.string_constants)
        if len(lowered.lines) > 0:
            function_lines = (function_lines) + (lowered.lines)
            if index + 1 < len(local_functions):
                function_lines = append_string(function_lines, "")
        index += 1
    if not has_add_function:
        if len(function_lines) > 0:
            function_lines = append_string(function_lines, "")
        function_lines = (function_lines) + (["define double @add(double %a, double %b) {", "entry:", "  %t0 = fadd double %a, %b", "  ret double %t0", "}"])
    string_constant_lines = render_string_constants(all_string_constants)
    final_lines = preamble_lines
    if len(string_constant_lines) > 0:
        final_lines = (final_lines) + (string_constant_lines)
        final_lines = append_string(final_lines, "")
    final_lines = (final_lines) + (function_lines)
    ir = join_with_separator(final_lines, "\n")
    manifest = build_capability_manifest(native_module.entry_points, function_effects)
    output = ir
    if len(output) > 0:
        output = output + "\n"
    return LoweredLLVMResult(ir=output, diagnostics=diagnostics, trait_metadata=trait_metadata, function_effects=function_effects, lifetime_regions=lifetime_regions, capability_manifest=manifest, string_constants=all_string_constants)

def empty_trait_metadata():
    return TraitMetadata(interfaces=[], implementations=[])

def empty_capability_manifest():
    return CapabilityManifest(entries=[])

def build_trait_metadata(interfaces, structs):
    interface_descriptors = []
    index = 0
    while True:
        if index >= len(interfaces):
            break
        interface = interfaces[index]
        interface_descriptors = (interface_descriptors) + ([TraitDescriptor(name=interface.name, type_parameters=interface.type_parameters, signatures=interface.signatures)])
        index += 1
    implementation_descriptors = []
    index = 0
    while True:
        if index >= len(structs):
            break
        definition = structs[index]
        if len(definition.implements) > 0:
            implementation_descriptors = (implementation_descriptors) + ([TraitImplementationDescriptor(struct_name=definition.name, interfaces=definition.implements)])
        index += 1
    return TraitMetadata(interfaces=interface_descriptors, implementations=implementation_descriptors)

def render_trait_metadata_comments(metadata):
    interface_lines = []
    index = 0
    while True:
        if index >= len(metadata.interfaces):
            break
        interface = metadata.interfaces[index]
        header = "; interface " + interface.name
        if len(interface.type_parameters) > 0:
            header = header + "<" + join_with_separator(interface.type_parameters, ", ") + ">"
        interface_lines = append_string(interface_lines, header)
        signature_index = 0
        while True:
            if signature_index >= len(interface.signatures):
                break
            signature = interface.signatures[signature_index]
            rendered = render_interface_signature(signature)
            interface_lines = append_string(interface_lines, ";   " + rendered)
            signature_index += 1
        if len(interface.signatures) == 0:
            interface_lines = append_string(interface_lines, ";   ; no signatures recorded")
        index += 1
    struct_lines = []
    index = 0
    while True:
        if index >= len(metadata.implementations):
            break
        implementation = metadata.implementations[index]
        line = "; struct " + implementation.struct_name + " implements " + join_with_separator(implementation.interfaces, ", ")
        struct_lines = append_string(struct_lines, line)
        index += 1
    if len(interface_lines) == 0  and  len(struct_lines) == 0:
        return []
    lines = []
    lines = append_string(lines, "; -- Trait Metadata --------------------------------")
    lines = (lines) + (interface_lines)
    if len(interface_lines) > 0  and  len(struct_lines) > 0:
        lines = append_string(lines, ";")
    lines = (lines) + (struct_lines)
    lines = append_string(lines, "; -----------------------------------------------")
    return lines

def render_runtime_helper_declarations(used_targets, local_functions):
    if len(used_targets) == 0:
        return []
    local_symbols = []
    local_index = 0
    while True:
        if local_index >= len(local_functions):
            break
        local_symbols = append_string(local_symbols, sanitize_symbol(local_functions[local_index].name))
        local_index += 1
    lines = []
    descriptors = runtime_helper_descriptors()
    index = 0
    while True:
        if index >= len(descriptors):
            break
        descriptor = descriptors[index]
        if string_array_contains(used_targets, descriptor.target):
            if string_array_contains(local_symbols, descriptor.symbol):
                index += 1
                continue
            if len(descriptor.effects) > 0:
                effects_text = join_with_separator(descriptor.effects, ", ")
                lines = append_string(lines, "; intrinsic " + descriptor.symbol + " requires capabilities: ![" + effects_text + "]")
            parameter_text = ""
            if len(descriptor.parameter_types) > 0:
                parameter_text = join_with_separator(descriptor.parameter_types, ", ")
            line = "declare " + descriptor.return_type + " @" + descriptor.symbol + "(" + parameter_text + ")"
            lines = append_string(lines, line)
        index += 1
    return lines

def render_imported_function_declarations(imported_functions, local_functions, context):
    if len(imported_functions) == 0:
        return []
    helper_descriptors = runtime_helper_descriptors()
    helper_symbols = []
    helper_index = 0
    while True:
        if helper_index >= len(helper_descriptors):
            break
        helper_symbols = append_string(helper_symbols, helper_descriptors[helper_index].symbol)
        helper_index += 1
    local_symbols = []
    local_index = 0
    while True:
        if local_index >= len(local_functions):
            break
        local_symbols = append_string(local_symbols, sanitize_symbol(local_functions[local_index].name))
        local_index += 1
    lines = []
    emitted_declarations = []
    index = 0
    while True:
        if index >= len(imported_functions):
            break
        function = imported_functions[index]
        sanitized_name = sanitize_symbol(function.name)
        if string_array_contains(helper_symbols, sanitized_name)  or  string_array_contains(local_symbols, sanitized_name):
            index += 1
            continue
        if string_array_contains(emitted_declarations, sanitized_name):
            index += 1
            continue
        emitted_declarations = append_string(emitted_declarations, sanitized_name)
        return_type = map_return_type(context, function.return_type)
        param_types = collect_parameter_types(context, function.parameters)
        param_text = join_with_separator(param_types, ", ")
        line = "declare " + return_type + " @" + sanitized_name + "(" + param_text + ")"
        lines = append_string(lines, line)
        index += 1
    return lines

def empty_type_context():
    return TypeContext(structs=[], enums=[], interfaces=[], vtables=[])

def build_type_context(structs, enums, interfaces):
    diagnostics = []
    struct_entries = []
    index = 0
    while True:
        if index >= len(structs):
            break
        definition = structs[index]
        if definition.layout == None:
            diagnostics = append_string(diagnostics, "llvm lowering: struct `" + definition.name + "` missing layout metadata; skipping type emission")
            index += 1
            continue
        layout = definition.layout
        sanitized = sanitize_symbol(definition.name)
        llvm_name = "%" + sanitized
        fields = []
        field_index = 0
        while True:
            if field_index >= len(layout.fields):
                break
            layout_field = layout.fields[field_index]
            mapped = map_struct_field_annotation(layout_field.type_annotation)
            llvm_field_type = mapped
            if len(llvm_field_type) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: struct `" + definition.name + "` field `" + layout_field.name + "` uses unsupported type `" + layout_field.type_annotation + "`; lowering as `i8*`")
                llvm_field_type = "i8*"
            else:
                if ends_with_pointer_suffix(llvm_field_type):
                    layout_base_type = layout_annotation_base_type(layout_field.type_annotation)
                    references_self_type = layout_base_type == definition.name
                    if layout_annotation_represents_user_value(layout_field.type_annotation)  and  not references_self_type:
                        stripped = strip_pointer_suffix(llvm_field_type)
                        if len(stripped) > 0:
                            llvm_field_type = stripped
            fields = append_struct_field_info(fields, StructFieldInfo(name=layout_field.name, llvm_type=llvm_field_type, index=field_index, offset=layout_field.offset))
            field_index += 1
        align_value = layout.align
        if align_value <= 0:
            align_value = 1
        struct_entries = append_struct_type_info(struct_entries, StructTypeInfo(name=definition.name, llvm_name=llvm_name, fields=fields, size=layout.size, align=align_value))
        index += 1
    enum_entries = []
    enum_index = 0
    while True:
        if enum_index >= len(enums):
            break
        enum_def = enums[enum_index]
        if enum_def.layout == None:
            diagnostics = append_string(diagnostics, "llvm lowering: enum `" + enum_def.name + "` missing layout metadata; skipping type emission")
            enum_index += 1
            continue
        enum_layout = enum_def.layout
        sanitized_enum = sanitize_symbol(enum_def.name)
        llvm_enum_name = "%" + sanitized_enum
        variants = []
        variant_index = 0
        while True:
            if variant_index >= len(enum_layout.variants):
                break
            variant_layout = enum_layout.variants[variant_index]
            variant_fields = []
            variant_field_index = 0
            while True:
                if variant_field_index >= len(variant_layout.fields):
                    break
                variant_field = variant_layout.fields[variant_field_index]
                mapped_variant_type = map_struct_field_annotation(variant_field.type_annotation)
                llvm_variant_field_type = mapped_variant_type
                if len(llvm_variant_field_type) == 0:
                    diagnostics = append_string(diagnostics, "llvm lowering: enum `" + enum_def.name + "` variant `" + variant_layout.name + "` field `" + variant_field.name + "` uses unsupported type `" + variant_field.type_annotation + "`; lowering as `i8*`")
                    llvm_variant_field_type = "i8*"
                else:
                    if ends_with_pointer_suffix(llvm_variant_field_type):
                        variant_base_type = layout_annotation_base_type(variant_field.type_annotation)
                        references_declaring_enum = variant_base_type == enum_def.name
                        if layout_annotation_represents_user_value(variant_field.type_annotation)  and  not references_declaring_enum:
                            stripped_variant = strip_pointer_suffix(llvm_variant_field_type)
                            if len(stripped_variant) > 0:
                                llvm_variant_field_type = stripped_variant
                variant_fields = append_struct_field_info(variant_fields, StructFieldInfo(name=variant_field.name, llvm_type=llvm_variant_field_type, index=variant_field_index, offset=variant_field.offset))
                variant_field_index += 1
            variants = append_enum_variant_info(variants, EnumVariantInfo(name=variant_layout.name, tag=variant_layout.tag, offset=variant_layout.offset, size=variant_layout.size, align=variant_layout.align, fields=variant_fields))
            variant_index += 1
        enum_align_value = enum_layout.align
        if enum_align_value <= 0:
            enum_align_value = 1
        enum_entries = append_enum_type_info(enum_entries, EnumTypeInfo(name=enum_def.name, llvm_name=llvm_enum_name, tag_type=enum_layout.tag_type, tag_size=enum_layout.tag_size, tag_align=enum_layout.tag_align, size=enum_layout.size, align=enum_align_value, variants=variants))
        enum_index += 1
    interface_entries = []
    interface_index = 0
    while True:
        if interface_index >= len(interfaces):
            break
        interface_def = interfaces[interface_index]
        sanitized_interface = sanitize_symbol(interface_def.name)
        llvm_interface_name = "%trait." + sanitized_interface
        interface_entries = append_interface_type_info(interface_entries, InterfaceTypeInfo(name=interface_def.name, llvm_name=llvm_interface_name, type_parameters=interface_def.type_parameters, signatures=interface_def.signatures))
        interface_index += 1
    vtable_entries = []
    struct_vtable_index = 0
    while True:
        if struct_vtable_index >= len(structs):
            break
        struct_def = structs[struct_vtable_index]
        implements_index = 0
        while True:
            if implements_index >= len(struct_def.implements):
                break
            interface_name = struct_def.implements[implements_index]
            interface_def_opt = None
            search_idx = 0
            while True:
                if search_idx >= len(interfaces):
                    break
                if interfaces[search_idx].name == interface_name:
                    interface_def_opt = interfaces[search_idx]
                    break
                search_idx += 1
            if interface_def_opt == None:
                diagnostics = append_string(diagnostics, "llvm lowering: struct `" + struct_def.name + "` implements unknown interface `" + interface_name + "`")
                implements_index += 1
                continue
            interface_def = interface_def_opt
            sanitized_struct = sanitize_symbol(struct_def.name)
            sanitized_iface = sanitize_symbol(interface_name)
            vtable_type_name = "%vtable." + sanitized_struct + "." + sanitized_iface
            vtable_global_name = "@vtable." + sanitized_struct + "." + sanitized_iface + ".const"
            vtable_method_entries = []
            sig_index = 0
            while True:
                if sig_index >= len(interface_def.signatures):
                    break
                signature = interface_def.signatures[sig_index]
                param_types = ["i8*"]
                param_idx = 1
                while True:
                    if param_idx >= len(signature.parameters):
                        break
                    param = signature.parameters[param_idx]
                    mapped_type = map_type_annotation(param.type_annotation)
                    param_types = append_string(param_types, mapped_type)
                    param_idx += 1
                return_type = map_type_annotation(signature.return_type)
                func_ptr_type = return_type + " (" + join_with_separator(param_types, ", ") + ")*"
                vtable_method_entries = append_vtable_entry(vtable_method_entries, VTableEntry(method_name=struct_def.name + "::" + signature.name, interface_method_name=signature.name, function_pointer_type=func_ptr_type))
                sig_index += 1
            vtable_entries = append_vtable_info(vtable_entries, VTableInfo(struct_name=struct_def.name, interface_name=interface_name, llvm_type_name=vtable_type_name, llvm_global_name=vtable_global_name, entries=vtable_method_entries))
            implements_index += 1
        struct_vtable_index += 1
    return TypeContextBuild(context=TypeContext(structs=struct_entries, enums=enum_entries, interfaces=interface_entries, vtables=vtable_entries), diagnostics=diagnostics)

def append_struct_type_info(values, value):
    return (values) + ([value])

def append_struct_field_info(values, value):
    return (values) + ([value])

def append_enum_variant_info(values, value):
    return (values) + ([value])

def append_enum_type_info(values, value):
    return (values) + ([value])

def append_interface_type_info(values, value):
    return (values) + ([value])

def append_vtable_info(values, value):
    return (values) + ([value])

def append_vtable_entry(values, value):
    return (values) + ([value])

def append_native_function(values, value):
    return (values) + ([value])

def concat_native_functions(first, second):
    result = first
    index = 0
    while True:
        if index >= len(second):
            break
        result = append_native_function(result, second[index])
        index += 1
    return result

def flatten_struct_methods(structs):
    result = []
    index = 0
    while True:
        if index >= len(structs):
            break
        definition = structs[index]
        method_index = 0
        while True:
            if method_index >= len(definition.methods):
                break
            method = definition.methods[method_index]
            qualified_name = definition.name + "::" + method.name
            qualified = NativeFunction(name=qualified_name, parameters=method.parameters, return_type=method.return_type, effects=method.effects, instructions=method.instructions)
            result = append_native_function(result, qualified)
            method_index += 1
        index += 1
    return result

def extract_struct_type_from_llvm(llvm_type):
    if len(llvm_type) == 0:
        return ""
    result = ""
    index = 0
    while True:
        if index >= len(llvm_type):
            break
        ch = substring(llvm_type, index, index + 1)
        if ch == "%":
            end_index = index + 1
            while True:
                if end_index >= len(llvm_type):
                    break
                end_ch = substring(llvm_type, end_index, end_index + 1)
                if end_ch == " "  or  end_ch == ","  or  end_ch == "*"  or  end_ch == "}"  or  end_ch == ">":
                    break
                end_index += 1
            if end_index > index + 1:
                result = substring(llvm_type, index, end_index)
                break
        index += 1
    return result

def render_struct_type_definitions(context, functions):
    lines = []
    referenced_types = []
    struct_index = 0
    while True:
        if struct_index >= len(context.structs):
            break
        info = context.structs[struct_index]
        field_index = 0
        while True:
            if field_index >= len(info.fields):
                break
            field_type = info.fields[field_index].llvm_type
            extracted = extract_struct_type_from_llvm(field_type)
            if len(extracted) > 0  and  not string_array_contains(referenced_types, extracted):
                referenced_types = append_string(referenced_types, extracted)
            field_index += 1
        struct_index += 1
    enum_index = 0
    while True:
        if enum_index >= len(context.enums):
            break
        enum_info = context.enums[enum_index]
        variant_index = 0
        while True:
            if variant_index >= len(enum_info.variants):
                break
            variant = enum_info.variants[variant_index]
            variant_field_index = 0
            while True:
                if variant_field_index >= len(variant.fields):
                    break
                field_type = variant.fields[variant_field_index].llvm_type
                extracted = extract_struct_type_from_llvm(field_type)
                if len(extracted) > 0  and  not string_array_contains(referenced_types, extracted):
                    referenced_types = append_string(referenced_types, extracted)
                variant_field_index += 1
            variant_index += 1
        enum_index += 1
    func_index = 0
    while True:
        if func_index >= len(functions):
            break
        func = functions[func_index]
        return_llvm_type = map_return_type(context, func.return_type)
        extracted_return = extract_struct_type_from_llvm(return_llvm_type)
        if len(extracted_return) > 0  and  not string_array_contains(referenced_types, extracted_return):
            referenced_types = append_string(referenced_types, extracted_return)
        param_index = 0
        while True:
            if param_index >= len(func.parameters):
                break
            param_llvm_type = map_parameter_type(context, func.parameters[param_index].type_annotation)
            extracted_param = extract_struct_type_from_llvm(param_llvm_type)
            if len(extracted_param) > 0  and  not string_array_contains(referenced_types, extracted_param):
                referenced_types = append_string(referenced_types, extracted_param)
            param_index += 1
        func_index += 1
    ref_index = 0
    while True:
        if ref_index >= len(referenced_types):
            break
        ref_type = referenced_types[ref_index]
        is_defined = False
        check_index = 0
        while True:
            if check_index >= len(context.structs):
                break
            if context.structs[check_index].llvm_name == ref_type:
                is_defined = True
                break
            check_index += 1
        if not is_defined:
            check_index = 0
            while True:
                if check_index >= len(context.enums):
                    break
                enum_llvm_name = "%" + sanitize_symbol(context.enums[check_index].name)
                if enum_llvm_name == ref_type:
                    is_defined = True
                    break
                check_index += 1
        if not is_defined:
            lines = append_string(lines, ref_type + " = type opaque")
        ref_index += 1
    index = 0
    emitted_types = []
    while True:
        if index >= len(context.structs):
            break
        info = context.structs[index]
        if string_array_contains(emitted_types, info.llvm_name):
            index += 1
            continue
        emitted_types = append_string(emitted_types, info.llvm_name)
        field_types = []
        field_index = 0
        while True:
            if field_index >= len(info.fields):
                break
            field_types = append_string(field_types, info.fields[field_index].llvm_type)
            field_index += 1
        body = ""
        if len(field_types) == 0:
            body = "{}"
        else:
            body = "{ " + join_with_separator(field_types, ", ") + " }"
        lines = append_string(lines, info.llvm_name + " = type " + body)
        index += 1
    return lines

def render_enum_type_definitions(context):
    lines = []
    emitted_types = []
    index = 0
    while True:
        if index >= len(context.enums):
            break
        enum_info = context.enums[index]
        enum_llvm_name = "%" + sanitize_symbol(enum_info.name)
        if string_array_contains(emitted_types, enum_llvm_name):
            index += 1
            continue
        emitted_types = append_string(emitted_types, enum_llvm_name)
        llvm_tag_type = "i32"
        if enum_info.tag_type == "i8":
            llvm_tag_type = "i8"
        if enum_info.tag_type == "i16":
            llvm_tag_type = "i16"
        if enum_info.tag_type == "i32":
            llvm_tag_type = "i32"
        if enum_info.tag_type == "i64":
            llvm_tag_type = "i64"
        max_payload_size = 0
        variant_idx = 0
        while True:
            if variant_idx >= len(enum_info.variants):
                break
            variant = enum_info.variants[variant_idx]
            if variant.size > max_payload_size:
                max_payload_size = variant.size
            variant_idx += 1
        payload_repr = ""
        if max_payload_size > 0:
            payload_repr = ", [" + number_to_string(max_payload_size) + " x i8]"
        body = "{ " + llvm_tag_type + payload_repr + " }"
        lines = append_string(lines, enum_info.llvm_name + " = type " + body)
        index += 1
    return lines

def render_interface_type_definitions(context):
    lines = []
    index = 0
    while True:
        if index >= len(context.interfaces):
            break
        interface_info = context.interfaces[index]
        body = "{ i8*, i8* }"
        lines = append_string(lines, interface_info.llvm_name + " = type " + body)
        index += 1
    return lines

def render_vtable_type_definitions(context):
    lines = []
    index = 0
    while True:
        if index >= len(context.vtables):
            break
        vtable = context.vtables[index]
        entry_types = []
        entry_index = 0
        while True:
            if entry_index >= len(vtable.entries):
                break
            entry_types = append_string(entry_types, vtable.entries[entry_index].function_pointer_type)
            entry_index += 1
        body = ""
        if len(entry_types) == 0:
            body = "{}"
        else:
            body = "{ " + join_with_separator(entry_types, ", ") + " }"
        lines = append_string(lines, vtable.llvm_type_name + " = type " + body)
        index += 1
    return lines

def render_vtable_constants(context):
    lines = []
    index = 0
    while True:
        if index >= len(context.vtables):
            break
        vtable = context.vtables[index]
        entry_values = []
        entry_index = 0
        while True:
            if entry_index >= len(vtable.entries):
                break
            entry = vtable.entries[entry_index]
            sanitized_method = sanitize_symbol(entry.method_name)
            cast_value = "bitcast (" + entry.function_pointer_type + " @" + sanitized_method + " to " + entry.function_pointer_type + ")"
            typed_value = entry.function_pointer_type + " " + cast_value
            entry_values = append_string(entry_values, typed_value)
            entry_index += 1
        body = ""
        if len(entry_values) == 0:
            body = "zeroinitializer"
        else:
            body = "{ " + join_with_separator(entry_values, ", ") + " }"
        lines = append_string(lines, vtable.llvm_global_name + " = global " + vtable.llvm_type_name + " " + body)
        index += 1
    return lines

def is_ascii_uppercase(ch):
    if len(ch) == 0:
        return False
    return ch >= "A"  and  ch <= "Z"

def looks_like_user_type(annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return False
    first = trimmed[0]
    if is_ascii_uppercase(first):
        return True
    index = 1
    while True:
        if index >= len(trimmed):
            break
        current = trimmed[index]
        if current == "."  and  index + 1 < len(trimmed):
            next = trimmed[index + 1]
            if is_ascii_uppercase(next):
                return True
        index += 1
    return False

def map_type_annotation(annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return "void"
    normalized = unwrap_move_wrapper(trimmed)
    if len(normalized) > 0:
        optional_marker = normalized[len(normalized) - 1]
        if optional_marker == "?":
            inner_annotation = trim_text(substring(normalized, 0, len(normalized) - 1))
            if len(inner_annotation) == 0:
                return "i8*"
            inner_type = map_type_annotation(inner_annotation)
            if len(inner_type) == 0  or  inner_type == "void":
                return "i8*"
            if len(inner_type) > 0  and  inner_type[len(inner_type) - 1] == "*":
                return inner_type
            return inner_type + "*"
    if normalized == "number":
        return "double"
    if normalized == "boolean"  or  normalized == "bool":
        return "i1"
    if normalized == "int"  or  normalized == "i64":
        return "i64"
    if normalized == "i32":
        return "i32"
    if normalized == "string":
        return "i8*"
    if normalized == "void":
        return "void"
    if len(normalized) > 2:
        suffix = substring(normalized, len(normalized) - 2, len(normalized))
        if suffix == "[]":
            element_annotation = trim_text(substring(normalized, 0, len(normalized) - 2))
            element_type = map_type_annotation(element_annotation)
            if len(element_type) == 0:
                return "i8*"
            aggregate = array_struct_type_for_element(element_type)
            return aggregate + "*"
    if looks_like_user_type(normalized):
        sanitized = sanitize_symbol(normalized)
        return "%" + sanitized + "*"
    return "i8*"

def map_struct_field_annotation(annotation):
    result = map_type_annotation(annotation)
    if result == "void":
        return ""
    return result

def layout_annotation_requires_pointer(annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return False
    normalized = unwrap_move_wrapper(trimmed)
    if len(normalized) == 0:
        return False
    if starts_with(normalized, "mut "):
        remainder = trim_text(substring(normalized, 4, len(normalized)))
        if len(remainder) == 0:
            return False
        return layout_annotation_requires_pointer(remainder)
    if len(normalized) > 0:
        first = normalized[0]
        if first == "&":
            return True
    if len(normalized) > 0:
        last = normalized[len(normalized) - 1]
        if last == "?":
            return True
    if len(normalized) > 2:
        suffix = substring(normalized, len(normalized) - 2, len(normalized))
        if suffix == "[]":
            return True
    return False

def layout_annotation_base_type(annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    normalized = unwrap_move_wrapper(trimmed)
    if len(normalized) == 0:
        return ""
    if starts_with(normalized, "mut "):
        remainder = trim_text(substring(normalized, 4, len(normalized)))
        return layout_annotation_base_type(remainder)
    if len(normalized) > 0:
        first = normalized[0]
        if first == "&":
            inner_reference = trim_text(substring(normalized, 1, len(normalized)))
            return layout_annotation_base_type(inner_reference)
    if len(normalized) > 0:
        last = normalized[len(normalized) - 1]
        if last == "?":
            inner_optional = trim_text(substring(normalized, 0, len(normalized) - 1))
            return layout_annotation_base_type(inner_optional)
    if len(normalized) > 2:
        suffix = substring(normalized, len(normalized) - 2, len(normalized))
        if suffix == "[]":
            element = trim_text(substring(normalized, 0, len(normalized) - 2))
            return layout_annotation_base_type(element)
    return normalized

def layout_annotation_represents_user_value(annotation):
    if layout_annotation_requires_pointer(annotation):
        return False
    base = layout_annotation_base_type(annotation)
    if len(base) == 0:
        return False
    if base == "number":
        return False
    if base == "boolean"  or  base == "bool":
        return False
    if base == "int"  or  base == "i64":
        return False
    if base == "i32":
        return False
    if base == "string":
        return False
    if base == "void":
        return False
    if contains_text(base, "<"):
        return False
    if contains_text(base, ">"):
        return False
    if looks_like_user_type(base):
        return True
    return False

def find_struct_info_by_name(context, name):
    index = 0
    while True:
        if index >= len(context.structs):
            break
        info = context.structs[index]
        if info.name == name:
            return info
        index += 1
    return None

def find_interface_info_by_name(context, name):
    index = 0
    while True:
        if index >= len(context.interfaces):
            break
        info = context.interfaces[index]
        if info.name == name:
            return info
        index += 1
    return None

def find_vtable_for_struct_interface(context, struct_name, interface_name):
    index = 0
    while True:
        if index >= len(context.vtables):
            break
        vtable = context.vtables[index]
        if vtable.struct_name == struct_name  and  vtable.interface_name == interface_name:
            return vtable
        index += 1
    return None

def find_struct_info_by_llvm_type(context, llvm_type):
    trimmed = trim_text(llvm_type)
    index = 0
    while True:
        if index >= len(context.structs):
            break
        info = context.structs[index]
        if info.llvm_name == trimmed:
            return info
        index += 1
    return None

def find_struct_field_index(struct_info, field_name):
    index = 0
    while True:
        if index >= len(struct_info.fields):
            break
        field = struct_info.fields[index]
        if field.name == field_name:
            return index
        index += 1
    return -1

def find_enum_info_by_llvm_type(context, llvm_type):
    trimmed = trim_text(llvm_type)
    index = 0
    while True:
        if index >= len(context.enums):
            break
        info = context.enums[index]
        if info.llvm_name == trimmed:
            return info
        index += 1
    return None

def resolve_struct_info_from_llvm_type(context, llvm_type):
    candidate = trim_text(llvm_type)
    if len(candidate) == 0:
        return None
    if ends_with_pointer_suffix(candidate):
        candidate = strip_pointer_suffix(candidate)
    return find_struct_info_by_llvm_type(context, candidate)

def lookup_allocation_info(context, llvm_type):
    trimmed = trim_text(llvm_type)
    if len(trimmed) == 0:
        return None
    if ends_with_pointer_suffix(trimmed):
        return None
    if trimmed == "double":
        return TypeAllocationInfo(llvm_type=trimmed, size=8, align=8)
    if trimmed == "i64"  or  trimmed == "int":
        return TypeAllocationInfo(llvm_type=trimmed, size=8, align=8)
    if trimmed == "i32":
        return TypeAllocationInfo(llvm_type=trimmed, size=4, align=4)
    if trimmed == "i1":
        return TypeAllocationInfo(llvm_type=trimmed, size=1, align=1)
    if trimmed == "i8":
        return TypeAllocationInfo(llvm_type=trimmed, size=1, align=1)
    struct_info = find_struct_info_by_llvm_type(context, trimmed)
    if struct_info != None:
        align_value = struct_info.align
        if align_value <= 0:
            align_value = 1
        return TypeAllocationInfo(llvm_type=struct_info.llvm_name, size=struct_info.size, align=align_value)
    enum_info = find_enum_info_by_llvm_type(context, trimmed)
    if enum_info != None:
        align_value = enum_info.align
        if align_value <= 0:
            align_value = 1
        return TypeAllocationInfo(llvm_type=enum_info.llvm_name, size=enum_info.size, align=align_value)
    return None

def resolve_struct_info_for_method_target(base, bindings, locals, context):
    trimmed = trim_text(base)
    if len(trimmed) == 0:
        return None
    if is_simple_identifier(trimmed):
        parameter = find_parameter_binding(bindings, trimmed)
        if parameter != None:
            info = resolve_struct_info_from_llvm_type(context, parameter.llvm_type)
            if info != None:
                return info
        local = find_local_binding(locals, trimmed)
        if local != None:
            info = resolve_struct_info_from_llvm_type(context, local.llvm_type)
            if info != None:
                return info
    return None

def resolve_interface_info_for_method_target(base, bindings, locals, context):
    trimmed = trim_text(base)
    if len(trimmed) == 0:
        return None
    if is_simple_identifier(trimmed):
        parameter = find_parameter_binding(bindings, trimmed)
        if parameter != None:
            type_name = parameter.llvm_type
            if substring(type_name, 0, 7) == "%trait.":
                interface_name = substring(type_name, 7, len(type_name))
                info = find_interface_info_by_name(context, interface_name)
                if info != None:
                    return info
            info = find_interface_info_by_name(context, type_name)
            if info != None:
                return info
        local = find_local_binding(locals, trimmed)
        if local != None:
            type_name = local.llvm_type
            if substring(type_name, 0, 7) == "%trait.":
                interface_name = substring(type_name, 7, len(type_name))
                info = find_interface_info_by_name(context, interface_name)
                if info != None:
                    return info
            info = find_interface_info_by_name(context, type_name)
            if info != None:
                return info
    return None

def find_struct_field_info(info, field_name):
    index = 0
    while True:
        if index >= len(info.fields):
            break
        field = info.fields[index]
        if field.name == field_name:
            return field
        index += 1
    return None

def find_variant_field_info(variant, field_name):
    index = 0
    while True:
        if index >= len(variant.fields):
            break
        field = variant.fields[index]
        if field.name == field_name:
            return field
        index += 1
    return None

def resolve_struct_info_for_literal(context, type_name):
    trimmed = trim_text(type_name)
    if len(trimmed) == 0:
        return None
    candidates = [trimmed]
    generic_index = index_of(trimmed, "<")
    if generic_index >= 0:
        base = trim_text(substring(trimmed, 0, generic_index))
        if len(base) > 0:
            if not string_array_contains(candidates, base):
                candidates = append_string(candidates, base)
    last_dot = find_last_index_of_char(trimmed, ".")
    if last_dot >= 0:
        tail_full = trim_text(substring(trimmed, last_dot + 1, len(trimmed)))
        if len(tail_full) > 0:
            if not string_array_contains(candidates, tail_full):
                candidates = append_string(candidates, tail_full)
            tail_generic_index = index_of(tail_full, "<")
            if tail_generic_index >= 0:
                tail_base = trim_text(substring(tail_full, 0, tail_generic_index))
                if len(tail_base) > 0:
                    if not string_array_contains(candidates, tail_base):
                        candidates = append_string(candidates, tail_base)
    index = 0
    while True:
        if index >= len(candidates):
            break
        candidate = candidates[index]
        info = find_struct_info_by_name(context, candidate)
        if info != None:
            return info
        index += 1
    return None

def resolve_enum_info_for_literal(context, enum_name):
    trimmed = trim_text(enum_name)
    if len(trimmed) == 0:
        return None
    index = 0
    while True:
        if index >= len(context.enums):
            break
        enum_info = context.enums[index]
        if enum_info.name == trimmed:
            return enum_info
        index += 1
    return None

def resolve_enum_variant_info(enum_info, variant_name):
    trimmed = trim_text(variant_name)
    if len(trimmed) == 0:
        return None
    index = 0
    while True:
        if index >= len(enum_info.variants):
            break
        variant = enum_info.variants[index]
        if variant.name == trimmed:
            return variant
        index += 1
    return None

def collect_direct_function_effects(functions):
    entries = []
    index = 0
    while True:
        if index >= len(functions):
            break
        entry = collect_function_effect_entry(functions[index])
        entries = append_function_effect_entry(entries, entry)
        index += 1
    return entries

def collect_function_call_graph(functions):
    entries = []
    function_names = collect_function_names(functions)
    index = 0
    while True:
        if index >= len(functions):
            break
        call_entry = collect_function_call_entry(functions[index], function_names)
        entries = append_function_call_entry(entries, call_entry)
        index += 1
    return entries

def collect_function_call_entry(function, function_names):
    callees = []
    index = 0
    while True:
        if index >= len(function.instructions):
            break
        instruction = function.instructions[index]
        callees = merge_effect_lists(callees, collect_instruction_calls(instruction, function_names))
        index += 1
    return FunctionCallEntry(name=function.name, callees=callees)

def collect_runtime_helper_targets(functions):
    used = []
    index = 0
    while True:
        if index >= len(functions):
            break
        helpers = collect_function_runtime_helper_targets(functions[index])
        used = merge_effect_lists(used, helpers)
        index += 1
    return used

def collect_function_runtime_helper_targets(function):
    used = []
    index = 0
    while True:
        if index >= len(function.instructions):
            break
        instruction = function.instructions[index]
        instruction_helpers = collect_instruction_runtime_helper_targets(instruction)
        used = merge_effect_lists(used, instruction_helpers)
        index += 1
    return used

def collect_instruction_runtime_helper_targets(instruction):
    if instruction.variant == "Let":
        if instruction.value != None:
            helpers = filter_runtime_helper_targets(extract_all_call_targets(instruction.value))
            helpers = merge_effect_lists(helpers, collect_runtime_property_targets(instruction.value))
            return helpers
        return []
    if instruction.variant == "Expression":
        helpers = filter_runtime_helper_targets(extract_all_call_targets(instruction.expression))
        helpers = merge_effect_lists(helpers, collect_runtime_property_targets(instruction.expression))
        return helpers
    if instruction.variant == "Return":
        trimmed = trim_text(instruction.expression)
        if len(trimmed) > 0:
            helpers = filter_runtime_helper_targets(extract_all_call_targets(trimmed))
            helpers = merge_effect_lists(helpers, collect_runtime_property_targets(trimmed))
            return helpers
        return []
    if instruction.variant == "If":
        helpers = filter_runtime_helper_targets(extract_all_call_targets(instruction.condition))
        helpers = merge_effect_lists(helpers, collect_runtime_property_targets(instruction.condition))
        return helpers
    if instruction.variant == "For":
        helpers = filter_runtime_helper_targets(extract_all_call_targets(instruction.iterable))
        helpers = merge_effect_lists(helpers, collect_runtime_property_targets(instruction.iterable))
        return helpers
    if instruction.variant == "Match":
        helpers = filter_runtime_helper_targets(extract_all_call_targets(instruction.expression))
        helpers = merge_effect_lists(helpers, collect_runtime_property_targets(instruction.expression))
        return helpers
    if instruction.variant == "Case":
        helpers = filter_runtime_helper_targets(extract_all_call_targets(instruction.pattern))
        helpers = merge_effect_lists(helpers, collect_runtime_property_targets(instruction.pattern))
        if instruction.guard != None:
            guard_targets = filter_runtime_helper_targets(extract_all_call_targets(instruction.guard))
            combined = merge_effect_lists(helpers, guard_targets)
            combined = merge_effect_lists(combined, collect_runtime_property_targets(instruction.guard))
            return combined
        return helpers
    return []

def collect_instruction_calls(instruction, function_names):
    callees = []
    if instruction.variant == "Let":
        if instruction.value != None:
            callees = merge_effect_lists(callees, extract_call_targets(instruction.value, function_names))
        return callees
    if instruction.variant == "Expression":
        callees = merge_effect_lists(callees, extract_call_targets(instruction.expression, function_names))
        return callees
    if instruction.variant == "Return":
        trimmed = trim_text(instruction.expression)
        if len(trimmed) > 0:
            callees = merge_effect_lists(callees, extract_call_targets(trimmed, function_names))
        return callees
    if instruction.variant == "If":
        callees = merge_effect_lists(callees, extract_call_targets(instruction.condition, function_names))
        return callees
    if instruction.variant == "For":
        callees = merge_effect_lists(callees, extract_call_targets(instruction.iterable, function_names))
        return callees
    if instruction.variant == "Match":
        callees = merge_effect_lists(callees, extract_call_targets(instruction.expression, function_names))
        return callees
    if instruction.variant == "Case":
        callees = merge_effect_lists(callees, extract_call_targets(instruction.pattern, function_names))
        if instruction.guard != None:
            callees = merge_effect_lists(callees, extract_call_targets(instruction.guard, function_names))
        return callees
    return callees

def collect_function_names(functions):
    names = []
    index = 0
    while True:
        if index >= len(functions):
            break
        names = append_string(names, functions[index].name)
        index += 1
    return names

def extract_call_targets(expression, function_names):
    results = []
    if len(expression) == 0:
        return results
    index = 0
    while True:
        if index >= len(expression):
            break
        ch = expression[index]
        if ch == "\"":
            index = skip_string_literal(expression, index + 1)
            continue
        if is_identifier_start_char(ch):
            start_index = index
            index += 1
            while True:
                if index >= len(expression):
                    break
                current = expression[index]
                if is_identifier_part_char(current):
                    index += 1
                    continue
                if current == ".":
                    index += 1
                    continue
                break
            candidate = trim_text(substring(expression, start_index, index))
            if len(candidate) > 0:
                while True:
                    dot_index = index_of(candidate, ".")
                    if dot_index == -1:
                        break
                    candidate = trim_text(substring(candidate, dot_index + 1, len(candidate)))
                cursor = index
                while True:
                    if cursor >= len(expression):
                        break
                    next = expression[cursor]
                    if is_trim_char(next):
                        cursor += 1
                        continue
                    if next == "(":
                        if string_array_contains(function_names, candidate):
                            results = append_unique_effect(results, candidate)
                    break
            continue
        index += 1
    return results

def extract_all_call_targets(expression):
    results = []
    if len(expression) == 0:
        return results
    index = 0
    while True:
        if index >= len(expression):
            break
        ch = expression[index]
        if ch == "\"":
            index = skip_string_literal(expression, index + 1)
            continue
        if is_identifier_start_char(ch):
            start_index = index
            index += 1
            while True:
                if index >= len(expression):
                    break
                current = expression[index]
                if is_identifier_part_char(current):
                    index += 1
                    continue
                if current == "."  or  current == ":":
                    index += 1
                    continue
                break
            candidate = trim_text(substring(expression, start_index, index))
            if len(candidate) > 0:
                cursor = index
                while True:
                    if cursor >= len(expression):
                        break
                    next = expression[cursor]
                    if is_trim_char(next):
                        cursor += 1
                        continue
                    if next == "(":
                        results = append_unique_effect(results, candidate)
                    break
            continue
        index += 1
    return results

def filter_runtime_helper_targets(targets):
    results = []
    index = 0
    while True:
        if index >= len(targets):
            break
        trimmed = trim_text(targets[index])
        helper = find_runtime_helper(trimmed)
        if helper == None:
            dot_index = find_last_index_of_char(trimmed, ".")
            if dot_index >= 0  and  dot_index + 1 < len(trimmed):
                suffix = substring(trimmed, dot_index + 1, len(trimmed))
                helper = find_runtime_helper(suffix)
        if helper == None:
            colon_index = find_last_index_of_char(trimmed, ":")
            if colon_index >= 0  and  colon_index + 1 < len(trimmed):
                suffix = substring(trimmed, colon_index + 1, len(trimmed))
                helper = find_runtime_helper(suffix)
        if helper == None:
            length_suffix = ".length"
            if len(trimmed) >= len(length_suffix):
                maybe_length = substring(trimmed, len(trimmed) - len(length_suffix), len(trimmed))
                if maybe_length == length_suffix:
                    helper = find_runtime_helper("len(string)")
                    if helper == None:
                        helper = find_runtime_helper("len(string)")
            if helper == None:
                concat_suffix = ".concat"
                if len(trimmed) >= len(concat_suffix):
                    maybe_concat = substring(trimmed, len(trimmed) - len(concat_suffix), len(trimmed))
                    if maybe_concat == concat_suffix:
                        helper = find_runtime_helper("concat")
        if helper != None:
            results = append_unique_effect(results, helper.target)
        index += 1
    return results

def collect_runtime_property_targets(expression):
    trimmed = trim_text(expression)
    if len(trimmed) == 0:
        return []
    results = []
    if contains_dot_property(trimmed, "length"):
        results = append_unique_effect(results, "len(string)")
    return results

def contains_dot_property(expression, name):
    suffix = "." + name
    suffix_length = len(suffix)
    if suffix_length == 0  or  len(expression) < suffix_length:
        return False
    index = 0
    in_single = False
    in_double = False
    escape_next = False
    while True:
        if index >= len(expression):
            break
        ch = expression[index]
        if in_double:
            if escape_next:
                escape_next = False
            else:
                if ch == "\\":
                    escape_next = True
                else:
                    if ch == "\"":
                        in_double = False
            index += 1
            continue
        if in_single:
            if escape_next:
                escape_next = False
            else:
                if ch == "\\":
                    escape_next = True
                else:
                    if ch == "'":
                        in_single = False
            index += 1
            continue
        if ch == "\"":
            in_double = True
            index += 1
            continue
        if ch == "'":
            in_single = True
            index += 1
            continue
        if index + suffix_length <= len(expression):
            match_index = 0
            matches = True
            while True:
                if match_index >= suffix_length:
                    break
                expr_char = char_at(expression, index + match_index)
                suffix_char = char_at(suffix, match_index)
                if len(expr_char) == 0  or  len(suffix_char) == 0  or  expr_char != suffix_char:
                    matches = False
                    break
                match_index += 1
            if matches:
                after_index = index + suffix_length
                after_char = char_at(expression, after_index)
                if len(after_char) == 0:
                    return True
                if not is_identifier_part_char(after_char):
                    return True
        index += 1
    return False

def append_function_call_entry(entries, entry):
    return (entries) + ([entry])

def replace_function_effect_entry(entries, position, entry):
    result = []
    index = 0
    while True:
        if index >= len(entries):
            break
        if index == position:
            result = (result) + ([entry])
        else:
            result = (result) + ([entries[index]])
        index += 1
    return result

def find_function_effect_entry_index(entries, name):
    index = 0
    while True:
        if index >= len(entries):
            break
        if entries[index].name == name:
            return index
        index += 1
    return -1

def propagate_function_effects(direct_effects, call_graph):
    aggregated = []
    index = 0
    while True:
        if index >= len(direct_effects):
            break
        aggregated = (aggregated) + ([FunctionEffectEntry(name=direct_effects[index].name, effects=copy_string_array(direct_effects[index].effects))])
        index += 1
    changed = True
    while True:
        if not changed:
            break
        changed = False
        call_index = 0
        while True:
            if call_index >= len(call_graph):
                break
            call_entry = call_graph[call_index]
            target_index = find_function_effect_entry_index(aggregated, call_entry.name)
            if target_index >= 0:
                target_entry = aggregated[target_index]
                merged = copy_string_array(target_entry.effects)
                callee_index = 0
                while True:
                    if callee_index >= len(call_entry.callees):
                        break
                    callee_name = call_entry.callees[callee_index]
                    callee_pos = find_function_effect_entry_index(aggregated, callee_name)
                    if callee_pos >= 0:
                        callee_entry = aggregated[callee_pos]
                        effect_index = 0
                        while True:
                            if effect_index >= len(callee_entry.effects):
                                break
                            merged = append_unique_effect(merged, callee_entry.effects[effect_index])
                            effect_index += 1
                    callee_index += 1
                if not string_arrays_equal(merged, target_entry.effects):
                    updated_entry = FunctionEffectEntry(name=target_entry.name, effects=merged)
                    aggregated = replace_function_effect_entry(aggregated, target_index, updated_entry)
                    changed = True
            call_index += 1
    return aggregated

def find_function_effect_entry(entries, name):
    index = find_function_effect_entry_index(entries, name)
    if index >= 0:
        return entries[index]
    return None

def build_capability_manifest(entry_points, function_effects):
    entries = []
    index = 0
    while True:
        if index >= len(entry_points):
            break
        symbol = entry_points[index]
        effect_entry = find_function_effect_entry(function_effects, symbol)
        effects = []
        if effect_entry != None:
            effects = effect_entry.effects
        entries = append_manifest_entry(entries, CapabilityManifestEntry(symbol=symbol, effects=effects))
        index += 1
    return CapabilityManifest(entries=entries)

def append_manifest_entry(entries, entry):
    return (entries) + ([entry])

def runtime_helper_descriptors():
    descriptors = []
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="print.info", symbol="sailfin_runtime_print_info", return_type="void", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="print.error", symbol="sailfin_runtime_print_error", return_type="void", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="print.warn", symbol="sailfin_runtime_print_warn", return_type="void", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="console.info", symbol="sailfin_intrinsic_io_print", return_type="void", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="console.log", symbol="sailfin_intrinsic_io_print", return_type="void", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="console.error", symbol="sailfin_runtime_print_error", return_type="void", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="io_read", symbol="sailfin_intrinsic_io_read", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.read", symbol="sailfin_intrinsic_fs_read", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.write", symbol="sailfin_intrinsic_fs_write", return_type="void", parameter_types=["i8*", "i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.exists", symbol="sailfin_intrinsic_fs_exists", return_type="i1", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="model_invoke", symbol="sailfin_intrinsic_model_invoke", return_type="i8*", parameter_types=["i8*", "i8*"], effects=["model"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="prompt", symbol="sailfin_intrinsic_model_invoke", return_type="i8*", parameter_types=["i8*", "i8*"], effects=["model"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="net_request", symbol="sailfin_intrinsic_net_request", return_type="i8*", parameter_types=["i8*", "i8*", "i8*"], effects=["net"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="http.get", symbol="sailfin_intrinsic_http_get", return_type="i8*", parameter_types=["i8*"], effects=["net"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="http.post", symbol="sailfin_intrinsic_http_post", return_type="i8*", parameter_types=["i8*", "i8*"], effects=["net"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="sleep", symbol="sailfin_runtime_sleep", return_type="void", parameter_types=["double"], effects=["clock"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_sleep_fn", symbol="sailfin_runtime_sleep", return_type="void", parameter_types=["double"], effects=["clock"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_channel_fn", symbol="sailfin_runtime_channel", return_type="i8*", parameter_types=["double"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_spawn_fn", symbol="sailfin_runtime_spawn", return_type="void", parameter_types=["i8*", "i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_parallel_fn", symbol="sailfin_runtime_parallel", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_create_capability_grant", symbol="sailfin_runtime_create_capability_grant", return_type="i8*", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_create_filesystem_bridge", symbol="sailfin_runtime_create_filesystem_bridge", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_create_http_bridge", symbol="sailfin_runtime_create_http_bridge", return_type="i8*", parameter_types=["i8*"], effects=["net"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_create_model_bridge", symbol="sailfin_runtime_create_model_bridge", return_type="i8*", parameter_types=["i8*"], effects=["model"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_log_execution_fn", symbol="sailfin_runtime_log_execution", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_to_debug_string_fn", symbol="sailfin_runtime_to_debug_string", return_type="i8*", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_raise_value_error_fn", symbol="sailfin_runtime_raise_value_error", return_type="void", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_is_string_fn", symbol="sailfin_runtime_is_string", return_type="i1", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_is_number_fn", symbol="sailfin_runtime_is_number", return_type="i1", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_is_boolean_fn", symbol="sailfin_runtime_is_boolean", return_type="i1", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_is_void_fn", symbol="sailfin_runtime_is_void", return_type="i1", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime.bounds_check", symbol="sailfin_runtime_bounds_check", return_type="void", parameter_types=["i64", "i64"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_is_array_fn", symbol="sailfin_runtime_is_array", return_type="i1", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_is_callable_fn", symbol="sailfin_runtime_is_callable", return_type="i1", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_resolve_runtime_type_fn", symbol="sailfin_runtime_resolve_type", return_type="i8*", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_instance_of_fn", symbol="sailfin_runtime_instance_of", return_type="i1", parameter_types=["i8*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_serve_fn", symbol="sailfin_runtime_serve", return_type="void", parameter_types=["i8*", "i8*"], effects=["io", "net"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_char_code_fn", symbol="sailfin_runtime_char_code", return_type="double", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs_read_file", symbol="sailfin_adapter_fs_read_file", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.readFile", symbol="sailfin_adapter_fs_read_file", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs_write_file", symbol="sailfin_adapter_fs_write_file", return_type="void", parameter_types=["i8*", "i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.writeFile", symbol="sailfin_adapter_fs_write_file", return_type="void", parameter_types=["i8*", "i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs_list_directory", symbol="sailfin_adapter_fs_list_directory", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.listDirectory", symbol="sailfin_adapter_fs_list_directory", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs_delete_file", symbol="sailfin_adapter_fs_delete_file", return_type="i1", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.deleteFile", symbol="sailfin_adapter_fs_delete_file", return_type="i1", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs_create_directory", symbol="sailfin_adapter_fs_create_directory", return_type="i1", parameter_types=["i8*", "i1"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.createDirectory", symbol="sailfin_adapter_fs_create_directory", return_type="i1", parameter_types=["i8*", "i1"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="http_get", symbol="sailfin_adapter_http_get", return_type="i8*", parameter_types=["i8*"], effects=["net"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="http_post", symbol="sailfin_adapter_http_post", return_type="i8*", parameter_types=["i8*", "i8*"], effects=["net"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="model_invoke_with_prompt", symbol="sailfin_adapter_model_invoke_with_prompt", return_type="i8*", parameter_types=["i8*", "i8*"], effects=["model"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="serve_start", symbol="sailfin_adapter_serve_start", return_type="void", parameter_types=["i8*", "i32"], effects=["net", "io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="serve_handler_dispatch", symbol="sailfin_adapter_serve_handler_dispatch", return_type="i8*", parameter_types=["i8*", "i8*"], effects=["net", "io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="spawn_task", symbol="sailfin_adapter_spawn_task", return_type="i8*", parameter_types=["i8*"], effects=["spawn"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="channel_create", symbol="sailfin_adapter_channel_create", return_type="i8*", parameter_types=["i32"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="channel_send", symbol="sailfin_adapter_channel_send", return_type="void", parameter_types=["i8*", "i8*"], effects=["channel"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="channel_receive", symbol="sailfin_adapter_channel_receive", return_type="i8*", parameter_types=["i8*"], effects=["channel"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_array_map_fn", symbol="sailfin_runtime_array_map", return_type="i8*", parameter_types=["i8*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_array_filter_fn", symbol="sailfin_runtime_array_filter", return_type="i8*", parameter_types=["i8*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_array_reduce_fn", symbol="sailfin_runtime_array_reduce", return_type="i8*", parameter_types=["i8*", "i8*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="substring", symbol="sailfin_runtime_substring", return_type="i8*", parameter_types=["i8*", "i64", "i64"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="len(string)", symbol="sailfin_runtime_string_length", return_type="i64", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="string.concat", symbol="sailfin_runtime_string_concat", return_type="i8*", parameter_types=["i8*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="strings_equal", symbol="strings_equal", return_type="i1", parameter_types=["i8*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="char_code", symbol="char_code", return_type="double", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_grapheme_count_fn", symbol="sailfin_runtime_grapheme_count", return_type="double", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_grapheme_at_fn", symbol="sailfin_runtime_grapheme_at", return_type="i8*", parameter_types=["i8*", "double"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="is_whitespace_char", symbol="sailfin_runtime_is_whitespace_char", return_type="i1", parameter_types=["i8"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="is_decimal_digit", symbol="sailfin_runtime_is_decimal_digit", return_type="i1", parameter_types=["i8"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="is_alpha_char", symbol="sailfin_runtime_is_alpha_char", return_type="i1", parameter_types=["i8"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="append_string", symbol="sailfin_runtime_append_string", return_type="{ i8**, i64 }*", parameter_types=["{ i8**, i64 }*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="concat", symbol="sailfin_runtime_concat", return_type="{ i8**, i64 }*", parameter_types=["{ i8**, i64 }*", "{ i8**, i64 }*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="get_field", symbol="sailfin_runtime_get_field", return_type="i8*", parameter_types=["i8*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="mark_persistent", symbol="sailfin_runtime_mark_persistent", return_type="void", parameter_types=["i8*"], effects=[]))
    return descriptors

def append_runtime_helper(values, value):
    return (values) + ([value])

def find_runtime_helper(target):
    descriptors = runtime_helper_descriptors()
    trimmed = trim_text(target)
    index = 0
    while True:
        if index >= len(descriptors):
            break
        if descriptors[index].target == trimmed:
            return descriptors[index]
        index += 1
    return None

def collect_function_effect_entry(function):
    combined = []
    combined = merge_effect_lists(combined, function.effects)
    combined = merge_effect_lists(combined, collect_function_borrow_effects(function))
    return FunctionEffectEntry(name=function.name, effects=combined)

def append_function_effect_entry(values, entry):
    return (values) + ([entry])

def merge_effect_lists(base, extras):
    result = []
    index = 0
    while True:
        if index >= len(base):
            break
        result = append_unique_effect(result, base[index])
        index += 1
    index = 0
    while True:
        if index >= len(extras):
            break
        result = append_unique_effect(result, extras[index])
        index += 1
    return result

def append_unique_effect(effects, effect):
    if len(effect) == 0:
        return effects
    if string_array_contains(effects, effect):
        return effects
    return (effects) + ([effect])

def collect_function_borrow_effects(function):
    effects = []
    index = 0
    while True:
        if index >= len(function.instructions):
            break
        instruction = function.instructions[index]
        if instruction.variant == "Let":
            if instruction.value != None:
                effects = merge_effect_lists(effects, collect_expression_borrow_effects(instruction.value))
        else:
            if instruction.variant == "Expression":
                effects = merge_effect_lists(effects, collect_expression_borrow_effects(instruction.expression))
            else:
                if instruction.variant == "Return":
                    trimmed = trim_text(instruction.expression)
                    if len(trimmed) > 0:
                        effects = merge_effect_lists(effects, collect_expression_borrow_effects(trimmed))
        index += 1
    return effects

def collect_expression_borrow_effects(expression):
    trimmed = trim_text(expression)
    if len(trimmed) == 0:
        return []
    effects = []
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if ch == "\"":
            index = skip_string_literal(trimmed, index + 1)
            continue
        if ch == "&":
            if index + 1 < len(trimmed)  and  trimmed[index + 1] == "&":
                index += 2
                continue
            if index > 0:
                prefix = trimmed[index - 1]
                if is_identifier_part_char(prefix):
                    index += 1
                    continue
            cursor = index + 1
            mutable_flag = False
            if cursor + 3 <= len(trimmed):
                maybe_mut = substring(trimmed, cursor, cursor + 3)
                if maybe_mut == "mut":
                    after_mut_index = cursor + 3
                    if after_mut_index >= len(trimmed)  or  is_effect_delimiter(trimmed[after_mut_index]):
                        mutable_flag = True
                        cursor = after_mut_index
            while True:
                if cursor >= len(trimmed):
                    break
                current = trimmed[cursor]
                if not is_trim_char(current):
                    break
                cursor += 1
            if cursor < len(trimmed):
                target_start = trimmed[cursor]
                if is_identifier_start_char(target_start):
                    if mutable_flag:
                        effects = append_unique_effect(effects, "mut")
                    else:
                        effects = append_unique_effect(effects, "read")
            index += 1
            continue
        if ch == "b":
            if matches_keyword(trimmed, index, "borrow"):
                before_index = index - 1
                if before_index < 0  or  is_effect_prefix_char(trimmed[before_index]):
                    effects = append_unique_effect(effects, "read")
                    index += 6
                    continue
        index += 1
    return effects

def skip_string_literal(text, start_index):
    index = start_index
    escaped = False
    while True:
        if index >= len(text):
            break
        current = text[index]
        if escaped:
            escaped = False
        else:
            if current == "\\":
                escaped = True
            else:
                if current == "\"":
                    index += 1
                    break
        if current == "\n":
            index += 1
            break
        index += 1
    return index

def copy_string_array(values):
    result = []
    index = 0
    while True:
        if index >= len(values):
            break
        result = append_string(result, values[index])
        index += 1
    return result

def string_arrays_equal(first, second):
    if len(first) != len(second):
        return False
    index = 0
    while True:
        if index >= len(first):
            break
        if first[index] != second[index]:
            return False
        index += 1
    return True

def matches_keyword(value, start_index, keyword):
    remaining = len(value) - start_index
    if remaining < len(keyword):
        return False
    slice = substring(value, start_index, start_index + len(keyword))
    if slice != keyword:
        return False
    if start_index + len(keyword) >= len(value):
        return True
    next = value[start_index + len(keyword)]
    if is_identifier_part_char(next):
        return False
    return True

def is_effect_prefix_char(ch):
    if is_trim_char(ch):
        return True
    return ch == "("  or  ch == ","  or  ch == ";"  or  ch == "{"  or  ch == "}"  or  ch == "="

def is_effect_delimiter(ch):
    if is_trim_char(ch):
        return True
    return ch == "("  or  ch == ")"  or  ch == ","  or  ch == ";"  or  ch == "{"  or  ch == "}"  or  ch == "="

def is_identifier_start_char(ch):
    if ch == "_":
        return True
    if index_of("abcdefghijklmnopqrstuvwxyz", ch) != -1:
        return True
    if index_of("ABCDEFGHIJKLMNOPQRSTUVWXYZ", ch) != -1:
        return True
    return False

def is_identifier_part_char(ch):
    if is_identifier_start_char(ch):
        return True
    if index_of("0123456789", ch) != -1:
        return True
    return False

def render_interface_signature(signature):
    line = "fn " + signature.name
    if len(signature.type_parameters) > 0:
        line = line + "<" + join_with_separator(signature.type_parameters, ", ") + ">"
    line = line + "(" + render_interface_parameters(signature.parameters) + ")"
    if len(signature.return_type) > 0  and  signature.return_type != "void":
        line = line + " -> " + signature.return_type
    if len(signature.effects) > 0:
        line = line + " ![" + join_with_separator(signature.effects, ", ") + "]"
    if signature.is_async:
        line = "async " + line
    return line

def render_interface_parameters(parameters):
    if len(parameters) == 0:
        return ""
    rendered = []
    index = 0
    while True:
        if index >= len(parameters):
            break
        parameter = parameters[index]
        entry = parameter.name
        if parameter.mutable:
            entry = "mut " + entry
        if len(parameter.type_annotation) > 0:
            entry = entry + " -> " + parameter.type_annotation
        if parameter.default_value != None:
            entry = entry + " = " + parameter.default_value
        rendered = append_string(rendered, entry)
        index += 1
    return join_with_separator(rendered, ", ")

def emit_function(function, functions, effects, context):
    diagnostics = []
    sanitized = sanitize_symbol(function.name)
    llvm_return = map_return_type(context, function.return_type)
    if len(llvm_return) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: unsupported return type `" + function.return_type + "` in " + function.name)
        empty_constants = empty_string_constant_set()
        return LoweredLLVMFunction(lines=[], diagnostics=diagnostics, lifetime_regions=[], string_constants=empty_constants)
    preparation = prepare_parameters(function, context)
    diagnostics = (diagnostics) + (preparation.diagnostics)
    lines = []
    if len(effects) > 0:
        lines = append_string(lines, "; fn " + function.name + " effects: ![" + join_with_separator(effects, ", ") + "]")
    signature = join_with_separator(preparation.signature, ", ")
    if len(signature) == 0:
        signature = ""
    entry_label = "block.entry"
    lines = append_string(lines, "define " + llvm_return + " @" + sanitized + "(" + signature + ") {")
    lines = append_string(lines, entry_label + ":")
    body = emit_body(function, llvm_return, preparation.bindings, functions, context, entry_label)
    lines = (lines) + (body.lines)
    diagnostics = (diagnostics) + (body.diagnostics)
    lifetime_diagnostics = validate_borrow_lifetimes(function, body.lifetime_regions)
    diagnostics = (diagnostics) + (lifetime_diagnostics)
    lines = append_string(lines, "}")
    return LoweredLLVMFunction(lines=lines, diagnostics=diagnostics, lifetime_regions=body.lifetime_regions, string_constants=body.string_constants)

def emit_body(function, llvm_return, bindings, functions, context, entry_label):
    lowered = lower_instruction_range(
function,
0,
len(function.instructions),
llvm_return,
bindings,
[],
[],
[],
0,
0,
0,
0,
functions,
[],
context,
format_root_scope_id(function.name),
0,
entry_label
)
    diagnostics = lowered.diagnostics
    lines = []
    lines = (lines) + (lowered.allocas)
    lines = (lines) + (lowered.lines)
    if not lowered.terminated:
        if llvm_return == "void":
            lines = append_string(lines, "  ret void")
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: missing return in function `" + function.name + "`")
            lines = append_string(lines, "  ret " + llvm_return + " " + default_return_literal(llvm_return))
    return BodyResult(lines=lines, diagnostics=diagnostics, lifetime_regions=lowered.lifetime_regions, string_constants=lowered.string_constants)

def validate_borrow_lifetimes(function, regions):
    diagnostics = []
    index = 0
    root_scope = format_root_scope_id(function.name)
    while True:
        if index >= len(regions):
            break
        region = regions[index]
        base_scope_id = region.base_scope_id
        base_scope_depth = region.base_scope_depth
        if len(base_scope_id) == 0:
            base_scope_id = root_scope
            base_scope_depth = 0
        violation = False
        if region.released:
            if len(region.end_scope_id) == 0:
                violation = True
            else:
                if not is_scope_descendant(base_scope_id, region.end_scope_id):
                    violation = True
        else:
            if region.scope_depth < base_scope_depth:
                violation = True
            else:
                if not is_scope_descendant(base_scope_id, region.scope_id):
                    violation = True
        if violation:
            location = ""
            if region.start_span != None:
                location = " at " + format_span_location(region.start_span)
            diagnostics = append_string(diagnostics, "llvm lowering: borrow `" + region.binding + "` of `" + region.base + "` escapes lifetime of `" + region.base + "` in `" + function.name + "`" + location)
        index += 1
    return diagnostics

def lower_instruction_range(function, start_index, end, llvm_return, bindings, locals, allocas, lines, temp_index, block_counter, next_local_id, next_region_id, functions, loop_stack, context, scope_id, scope_depth, initial_label):
    diagnostics = []
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_bindings = bindings
    current_temp = temp_index
    current_block_counter = block_counter
    current_next_local = next_local_id
    current_next_region = next_region_id
    terminated = False
    current_loop_stack = loop_stack
    index = start_index
    collected_lifetime_regions = []
    current_mutations = []
    collected_string_constants = empty_string_constant_set()
    current_label = initial_label
    while True:
        if index >= end:
            break
        instruction = function.instructions[index]
        if instruction.variant == "Let":
            lowered = lower_let_instruction(function, instruction, current_bindings, current_locals, current_allocas, current_lines, current_temp, current_next_local, current_next_region, functions, context, scope_id, scope_depth, current_label)
            diagnostics = (diagnostics) + (lowered.diagnostics)
            collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
            current_lines = lowered.lines
            current_allocas = lowered.allocas
            current_locals = lowered.locals
            current_bindings = lowered.bindings
            current_temp = lowered.temp_index
            current_next_local = lowered.next_local_id
            current_next_region = lowered.next_region_id
            current_mutations = (current_mutations) + (lowered.mutations)
            temp_constants = collected_string_constants
            collected_string_constants = merge_string_constants(temp_constants, lowered.string_constants)
            current_label = find_last_label(current_lines, current_label)
        else:
            if instruction.variant == "Expression":
                trimmed_expression = trim_text(instruction.expression)
                handled_inline_let = False
                if len(trimmed_expression) >= 4:
                    prefix = substring(trimmed_expression, 0, 4)
                    if prefix == "let ":
                        inline_parse = parse_inline_let_expression(trimmed_expression)
                        diagnostics = (diagnostics) + (inline_parse.diagnostics)
                        if inline_parse.success:
                            inline_instruction = runtime.enum_instantiate(NativeInstruction, 'Let', [runtime.enum_field('name', inline_parse.name), runtime.enum_field('mutable', inline_parse.mutable), runtime.enum_field('type_annotation', inline_parse.type_annotation), runtime.enum_field('value', inline_parse.initializer), runtime.enum_field('span', instruction.span), runtime.enum_field('value_span', instruction.span)])
                            lowered = lower_let_instruction(function, inline_instruction, current_bindings, current_locals, current_allocas, current_lines, current_temp, current_next_local, current_next_region, functions, context, scope_id, scope_depth, current_label)
                            diagnostics = (diagnostics) + (lowered.diagnostics)
                            collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
                            current_lines = lowered.lines
                            current_allocas = lowered.allocas
                            current_locals = lowered.locals
                            current_bindings = lowered.bindings
                            current_temp = lowered.temp_index
                            current_next_local = lowered.next_local_id
                            current_next_region = lowered.next_region_id
                            current_mutations = (current_mutations) + (lowered.mutations)
                            temp_constants = collected_string_constants
                            collected_string_constants = merge_string_constants(temp_constants, lowered.string_constants)
                            handled_inline_let = True
                if not handled_inline_let:
                    lowered = lower_expression_statement(function.name, instruction, trimmed_expression, current_bindings, current_locals, current_temp, current_lines, current_next_region, scope_id, scope_depth, functions, context, current_label)
                    diagnostics = (diagnostics) + (lowered.diagnostics)
                    current_lines = lowered.lines
                    current_temp = lowered.temp_index
                    current_locals = lowered.locals
                    current_bindings = lowered.bindings
                    collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
                    collected_lifetime_regions = apply_lifetime_release_events(collected_lifetime_regions, lowered.lifetime_releases)
                    current_next_region = lowered.next_region_id
                    current_mutations = (current_mutations) + (lowered.mutations)
                    temp_constants = collected_string_constants
                    collected_string_constants = merge_string_constants(temp_constants, lowered.string_constants)
                current_label = find_last_label(current_lines, current_label)
            else:
                if instruction.variant == "Return":
                    lowered = lower_return_instruction(function, instruction, llvm_return, current_bindings, current_locals, current_temp, current_lines, current_next_region, scope_id, scope_depth, functions, context)
                    diagnostics = (diagnostics) + (lowered.diagnostics)
                    current_lines = lowered.lines
                    current_temp = lowered.temp_index
                    current_locals = lowered.locals
                    current_bindings = lowered.bindings
                    collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
                    collected_lifetime_regions = apply_lifetime_release_events(collected_lifetime_regions, lowered.lifetime_releases)
                    current_next_region = lowered.next_region_id
                    current_mutations = (current_mutations) + (lowered.mutations)
                    temp_constants = collected_string_constants
                    collected_string_constants = merge_string_constants(temp_constants, lowered.string_constants)
                    terminated = True
                    index += 1
                    if index < end:
                        diagnostics = append_string(diagnostics, "llvm lowering: instructions after return ignored in `" + function.name + "`")
                    break
                else:
                    if instruction.variant == "If":
                        lowered = lower_if_instruction(
function,
index,
llvm_return,
current_bindings,
current_locals,
current_allocas,
current_lines,
current_temp,
current_block_counter,
current_next_local,
current_next_region,
functions,
current_loop_stack,
end,
context,
scope_id,
scope_depth,
current_label
)
                        diagnostics = (diagnostics) + (lowered.diagnostics)
                        collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
                        current_lines = lowered.lines
                        current_allocas = lowered.allocas
                        current_locals = lowered.locals
                        current_bindings = lowered.bindings
                        current_temp = lowered.temp_index
                        current_block_counter = lowered.block_counter
                        current_next_local = lowered.next_local_id
                        current_next_region = lowered.next_lifetime_region_id
                        current_mutations = (current_mutations) + (lowered.mutations)
                        terminated = lowered.terminated
                        index = lowered.next_index
                        current_label = find_last_label(current_lines, current_label)
                        if terminated:
                            break
                        continue
                    else:
                        if instruction.variant == "Loop":
                            lowered = lower_loop_instruction(
function,
index,
llvm_return,
current_bindings,
current_locals,
current_allocas,
current_lines,
current_temp,
current_block_counter,
current_next_local,
current_next_region,
functions,
current_loop_stack,
end,
context,
scope_id,
scope_depth,
current_label
)
                            diagnostics = (diagnostics) + (lowered.diagnostics)
                            collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
                            current_lines = lowered.lines
                            current_allocas = lowered.allocas
                            current_locals = lowered.locals
                            current_bindings = lowered.bindings
                            current_temp = lowered.temp_index
                            current_block_counter = lowered.block_counter
                            current_next_local = lowered.next_local_id
                            current_next_region = lowered.next_lifetime_region_id
                            current_mutations = (current_mutations) + (lowered.mutations)
                            terminated = lowered.terminated
                            index = lowered.next_index
                            current_label = find_last_label(current_lines, current_label)
                            if terminated:
                                break
                            continue
                        else:
                            if instruction.variant == "Match":
                                lowered = lower_match_instruction(
function,
index,
llvm_return,
current_bindings,
current_locals,
current_allocas,
current_lines,
current_temp,
current_block_counter,
current_next_local,
current_next_region,
functions,
current_loop_stack,
end,
context,
scope_id,
scope_depth,
current_label
)
                                diagnostics = (diagnostics) + (lowered.diagnostics)
                                collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
                                current_lines = lowered.lines
                                current_allocas = lowered.allocas
                                current_locals = lowered.locals
                                current_bindings = lowered.bindings
                                current_temp = lowered.temp_index
                                current_block_counter = lowered.block_counter
                                current_next_local = lowered.next_local_id
                                current_next_region = lowered.next_lifetime_region_id
                                current_mutations = (current_mutations) + (lowered.mutations)
                                terminated = lowered.terminated
                                index = lowered.next_index
                                current_label = find_last_label(current_lines, current_label)
                                if terminated:
                                    break
                                continue
                            else:
                                if instruction.variant == "Else"  or  instruction.variant == "EndIf":
                                    break
                                else:
                                    if instruction.variant == "EndLoop"  or  instruction.variant == "EndMatch"  or  instruction.variant == "EndFor":
                                        break
                                    else:
                                        if instruction.variant == "Break":
                                            if len(current_loop_stack) == 0:
                                                diagnostics = append_string(diagnostics, "llvm lowering: `break` outside loop in `" + function.name + "`")
                                            else:
                                                loop_context = last_loop_context(current_loop_stack)
                                                current_lines = append_string(current_lines, "  br label %" + loop_context.break_label)
                                                terminated = True
                                            index += 1
                                            if index < end  and  terminated:
                                                diagnostics = append_string(diagnostics, "llvm lowering: instructions after break ignored in `" + function.name + "`")
                                            break
                                        else:
                                            if instruction.variant == "Continue":
                                                if len(current_loop_stack) == 0:
                                                    diagnostics = append_string(diagnostics, "llvm lowering: `continue` outside loop in `" + function.name + "`")
                                                else:
                                                    loop_context = last_loop_context(current_loop_stack)
                                                    current_lines = append_string(current_lines, "  br label %" + loop_context.continue_label)
                                                    terminated = True
                                                index += 1
                                                if index < end  and  terminated:
                                                    diagnostics = append_string(diagnostics, "llvm lowering: instructions after continue ignored in `" + function.name + "`")
                                                break
                                            else:
                                                if instruction.variant == "For":
                                                    lowered = lower_for_instruction(
function,
index,
llvm_return,
current_bindings,
current_locals,
current_allocas,
current_lines,
current_temp,
current_block_counter,
current_next_local,
current_next_region,
functions,
current_loop_stack,
end,
context,
scope_id,
scope_depth,
current_label
)
                                                    diagnostics = (diagnostics) + (lowered.diagnostics)
                                                    collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
                                                    current_lines = lowered.lines
                                                    current_allocas = lowered.allocas
                                                    current_locals = lowered.locals
                                                    current_bindings = lowered.bindings
                                                    current_temp = lowered.temp_index
                                                    current_block_counter = lowered.block_counter
                                                    current_next_local = lowered.next_local_id
                                                    current_next_region = lowered.next_lifetime_region_id
                                                    current_mutations = (current_mutations) + (lowered.mutations)
                                                    terminated = lowered.terminated
                                                    index = lowered.next_index
                                                    current_label = find_last_label(current_lines, current_label)
                                                    if terminated:
                                                        break
                                                    continue
                                                else:
                                                    if instruction.variant == "Noop":
                                                        pass
                                                    else:
                                                        diagnostics = append_string(diagnostics, "llvm lowering: unsupported instruction `" + instruction.variant + "` in `" + function.name + "`")
        index += 1
    return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=terminated, next_local_id=current_next_local, lifetime_regions=collected_lifetime_regions, next_lifetime_region_id=current_next_region, next_index=index, mutations=current_mutations, string_constants=collected_string_constants)

def collect_if_structure(instructions, start_index, end, function_name):
    diagnostics = []
    then_start = start_index + 1
    then_end = end
    else_start = -1
    else_end = -1
    has_else = False
    depth = 0
    index = then_start
    limit = end
    if limit > len(instructions):
        limit = len(instructions)
    while True:
        if index >= limit:
            diagnostics = append_string(diagnostics, "llvm lowering: unterminated `.if` in `" + function_name + "`")
            return IfStructure(then_start=then_start, then_end=limit, else_start=else_start, else_end=else_end, has_else=has_else, next_index=limit - 1, diagnostics=diagnostics)
        current = instructions[index]
        if current.variant == "If":
            depth += 1
            index += 1
            continue
        if current.variant == "EndIf":
            if depth == 0:
                if not has_else:
                    then_end = index
                else:
                    else_end = index
                return IfStructure(then_start=then_start, then_end=then_end, else_start=else_start, else_end=else_end, has_else=has_else, next_index=index, diagnostics=diagnostics)
            depth -= 1
            index += 1
            continue
        if current.variant == "Else":
            if depth == 0:
                if has_else:
                    diagnostics = append_string(diagnostics, "llvm lowering: duplicate `.else` in `.if` within `" + function_name + "`")
                else:
                    has_else = True
                    then_end = index
                    else_start = index + 1
            index += 1
            continue
        index += 1
    return IfStructure(then_start=then_start, then_end=then_end, else_start=else_start, else_end=else_end, has_else=has_else, next_index=limit, diagnostics=diagnostics)

def collect_loop_structure(instructions, start_index, end, function_name):
    diagnostics = []
    body_start = start_index + 1
    body_end = end
    depth = 0
    index = body_start
    limit = end
    if limit > len(instructions):
        limit = len(instructions)
    while True:
        if index >= limit:
            if limit <= 0:
                limit = 0
            diagnostics = append_string(diagnostics, "llvm lowering: unterminated `.loop` in `" + function_name + "`")
            return LoopStructure(body_start=body_start, body_end=limit, next_index=limit - 1, diagnostics=diagnostics)
        current = instructions[index]
        if current.variant == "Loop"  or  current.variant == "For":
            depth += 1
            index += 1
            continue
        if current.variant == "EndLoop"  or  current.variant == "EndFor":
            if depth == 0:
                body_end = index
                return LoopStructure(body_start=body_start, body_end=body_end, next_index=index, diagnostics=diagnostics)
            if depth > 0:
                depth -= 1
            index += 1
            continue
        index += 1
    return LoopStructure(body_start=body_start, body_end=body_end, next_index=limit, diagnostics=diagnostics)

def append_loop_context(values, value):
    return (values) + ([value])

def last_loop_context(values):
    index = len(values)
    if index <= 0:
        return LoopContext(break_label="", continue_label="")
    index -= 1
    return values[index]

def lower_loop_instruction(function, start_index, llvm_return, bindings, locals, allocas, lines, temp_index, block_counter, next_local_id, next_region_id, functions, loop_stack, end, context, scope_id, scope_depth, current_label):
    diagnostics = []
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_bindings = bindings
    current_temp = temp_index
    current_block_counter = block_counter
    current_next_local = next_local_id
    lifetime_regions = []
    current_next_region = next_region_id
    collected_mutations = []
    collected_string_constants = empty_string_constant_set()
    structure = collect_loop_structure(function.instructions, start_index, end, function.name)
    diagnostics = (diagnostics) + (structure.diagnostics)
    preloaded_locals = []
    preload_index = 0
    while True:
        if preload_index >= len(current_locals):
            break
        local = current_locals[preload_index]
        preload_temp = format_temp_name(current_temp)
        current_temp += 1
        preload_line = "  " + preload_temp + " = load " + local.llvm_type + ", " + local.llvm_type + "* " + local.pointer
        current_lines = append_string(current_lines, preload_line)
        preloaded_locals = append_string(preloaded_locals, preload_temp)
        preload_index += 1
    header_alloc = allocate_block_label("loop.header", current_block_counter)
    header_label = header_alloc.label
    current_block_counter = header_alloc.next_counter
    body_alloc = allocate_block_label("loop.body", current_block_counter)
    body_label = body_alloc.label
    current_block_counter = body_alloc.next_counter
    latch_alloc = allocate_block_label("loop.latch", current_block_counter)
    latch_label = latch_alloc.label
    current_block_counter = latch_alloc.next_counter
    exit_alloc = allocate_block_label("afterloop", current_block_counter)
    exit_label = exit_alloc.label
    current_block_counter = exit_alloc.next_counter
    current_lines = append_string(current_lines, "  br label %" + header_label)
    current_lines = append_string(current_lines, header_label + ":")
    loop_context = LoopContext(break_label=exit_label, continue_label=latch_label)
    stacked = append_loop_context(loop_stack, loop_context)
    base_locals = current_locals
    base_allocas = current_allocas
    base_local_id = current_next_local
    body_scope_id = make_child_scope_id(scope_id, body_label)
    body_result = lower_instruction_range(
function,
structure.body_start,
structure.body_end,
llvm_return,
current_bindings,
base_locals,
base_allocas,
[],
current_temp,
current_block_counter,
base_local_id,
current_next_region,
functions,
stacked,
context,
body_scope_id,
scope_depth + 1,
body_label
)
    diagnostics = (diagnostics) + (body_result.diagnostics)
    lifetime_regions = (lifetime_regions) + (body_result.lifetime_regions)
    current_allocas = body_result.allocas
    current_temp = body_result.temp_index
    current_block_counter = body_result.block_counter
    current_next_local = body_result.next_local_id
    current_bindings = body_result.bindings
    current_next_region = body_result.next_lifetime_region_id
    collected_mutations = (collected_mutations) + (body_result.mutations)
    collected_string_constants = merge_string_constants(collected_string_constants, body_result.string_constants)
    header_phis = []
    phi_stores = []
    mutated_names = []
    mut_idx = 0
    while True:
        if mut_idx >= len(body_result.mutations):
            break
        mutation = body_result.mutations[mut_idx]
        already_added = False
        check_idx = 0
        while True:
            if check_idx >= len(mutated_names):
                break
            if mutated_names[check_idx] == mutation.name:
                already_added = True
                break
            check_idx += 1
        if not already_added:
            mutated_names = append_string(mutated_names, mutation.name)
        mut_idx += 1
    current_lines = append_string(current_lines, "  br label %" + body_label)
    current_lines = append_string(current_lines, body_label + ":")
    current_lines = (current_lines) + (body_result.lines)
    if not body_result.terminated:
        current_lines = append_string(current_lines, "  br label %" + latch_label)
    current_lines = append_string(current_lines, latch_label + ":")
    latch_loads = []
    load_idx = 0
    while True:
        if load_idx >= len(mutated_names):
            break
        name = mutated_names[load_idx]
        local = find_local_binding(base_locals, name)
        if local != None:
            load_temp = format_temp_name(current_temp)
            current_temp += 1
            load_line = "  " + load_temp + " = load " + local.llvm_type + ", " + local.llvm_type + "* " + local.pointer
            current_lines = append_string(current_lines, load_line)
            latch_loads = append_string(latch_loads, load_temp)
        else:
            latch_loads = append_string(latch_loads, "")
        load_idx += 1
    current_lines = append_string(current_lines, "  br label %" + header_label)
    name_idx = 0
    while True:
        if name_idx >= len(mutated_names):
            break
        name = mutated_names[name_idx]
        local = find_local_binding(base_locals, name)
        if local != None  and  name_idx < len(latch_loads):
            latch_value = latch_loads[name_idx]
            if len(latch_value) > 0:
                preload_value = ""
                local_idx = 0
                while True:
                    if local_idx >= len(base_locals):
                        break
                    if base_locals[local_idx].name == name  and  local_idx < len(preloaded_locals):
                        preload_value = preloaded_locals[local_idx]
                        break
                    local_idx += 1
                if len(preload_value) > 0:
                    phi_temp = format_temp_name(current_temp)
                    current_temp += 1
                    phi_line = "  " + phi_temp + " = phi " + local.llvm_type + " [ " + preload_value + ", %" + current_label + " ], [ " + latch_value + ", %" + latch_label + " ]"
                    header_phis = append_string(header_phis, phi_line)
                    store_line = "  store " + local.llvm_type + " " + phi_temp + ", " + local.llvm_type + "* " + local.pointer
                    phi_stores = append_string(phi_stores, store_line)
        name_idx += 1
    final_lines = []
    line_idx = 0
    found_header = False
    while True:
        if line_idx >= len(current_lines):
            break
        line = current_lines[line_idx]
        final_lines = append_string(final_lines, line)
        if not found_header  and  line == header_label + ":":
            found_header = True
            final_lines = (final_lines) + (header_phis)
            final_lines = (final_lines) + (phi_stores)
        line_idx += 1
    current_lines = final_lines
    current_lines = append_string(current_lines, exit_label + ":")
    current_locals = base_locals
    exit_loads = []
    exit_load_idx = 0
    while True:
        if exit_load_idx >= len(mutated_names):
            break
        name = mutated_names[exit_load_idx]
        local = find_local_binding(base_locals, name)
        if local != None:
            exit_load_temp = format_temp_name(current_temp)
            current_temp += 1
            current_lines = append_string(current_lines, "  " + exit_load_temp + " = load " + local.llvm_type + ", " + local.llvm_type + "* " + local.pointer)
            exit_loads = append_string(exit_loads, exit_load_temp)
        else:
            exit_loads = append_string(exit_loads, "")
        exit_load_idx += 1
    exit_mutations = []
    name_idx = 0
    while True:
        if name_idx >= len(mutated_names):
            break
        name = mutated_names[name_idx]
        exit_value = ""
        if name_idx < len(exit_loads):
            exit_value = exit_loads[name_idx]
        if len(exit_value) > 0:
            original = find_mutation_for_name(collected_mutations, name)
            llvm_type = ""
            original_span = None
            if original != None:
                llvm_type = original.llvm_type
                original_span = original.span
            if len(llvm_type) == 0:
                local = find_local_binding(base_locals, name)
                if local != None:
                    llvm_type = local.llvm_type
            if len(llvm_type) == 0:
                llvm_type = "double"
            exit_mutation = LocalMutation(name=name, llvm_type=llvm_type, value_name=exit_value, span=original_span, originating_label=exit_label)
            exit_mutations = (exit_mutations) + ([exit_mutation])
        name_idx += 1
    collected_mutations = exit_mutations
    return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=structure.next_index + 1, mutations=collected_mutations, string_constants=collected_string_constants)

def lower_for_instruction(function, start_index, llvm_return, bindings, locals, allocas, lines, temp_index, block_counter, next_local_id, next_region_id, functions, loop_stack, end, context, scope_id, scope_depth, current_label):
    diagnostics = []
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_bindings = bindings
    current_temp = temp_index
    current_block_counter = block_counter
    current_next_local = next_local_id
    lifetime_regions = []
    current_next_region = next_region_id
    collected_mutations = []
    collected_string_constants = empty_string_constant_set()
    structure = collect_loop_structure(function.instructions, start_index, end, function.name)
    diagnostics = (diagnostics) + (structure.diagnostics)
    next_index = structure.next_index + 1
    instruction = function.instructions[start_index]
    raw_target = trim_text(instruction.target)
    raw_target = strip_mut_prefix(raw_target)
    if len(raw_target) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` loop missing iteration binding in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
    if not is_simple_identifier(raw_target):
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` loop target `" + raw_target + "` is not a simple identifier in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
    if find_local_binding(current_locals, raw_target) != None:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` loop target `" + raw_target + "` shadows existing local in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
    range_parse = parse_range_iterable(instruction.iterable)
    if range_parse.success:
        diagnostics = (diagnostics) + (range_parse.diagnostics)
        start_result = lower_expression(range_parse.start, current_bindings, current_locals, current_temp, current_lines, functions, context, "")
        diagnostics = (diagnostics) + (start_result.diagnostics)
        current_lines = start_result.lines
        current_temp = start_result.temp_index
        if start_result.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: unable to lower `.for` range start in `" + function.name + "`")
            return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
        end_result = lower_expression(range_parse.end, current_bindings, current_locals, current_temp, current_lines, functions, context, "")
        diagnostics = (diagnostics) + (end_result.diagnostics)
        current_lines = end_result.lines
        current_temp = end_result.temp_index
        if end_result.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: unable to lower `.for` range end in `" + function.name + "`")
            return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
        start_coerced = coerce_operand_to_type(start_result.operand, "double", current_temp, current_lines)
        diagnostics = (diagnostics) + (start_coerced.diagnostics)
        current_lines = start_coerced.lines
        current_temp = start_coerced.temp_index
        if start_coerced.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: `.for` start expression must evaluate to `number` in `" + function.name + "`")
            return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
        start_operand = start_coerced.operand
        end_coerced = coerce_operand_to_type(end_result.operand, "double", current_temp, current_lines)
        diagnostics = (diagnostics) + (end_coerced.diagnostics)
        current_lines = end_coerced.lines
        current_temp = end_coerced.temp_index
        if end_coerced.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: `.for` end expression must evaluate to `number` in `" + function.name + "`")
            return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
        end_operand = end_coerced.operand
        stride_operand = LLVMOperand(llvm_type="double", value="1.0")
        stride_text = trim_text(range_parse.stride)
        if len(stride_text) > 0:
            stride_result = lower_expression(stride_text, current_bindings, current_locals, current_temp, current_lines, functions, context, "")
            diagnostics = (diagnostics) + (stride_result.diagnostics)
            current_lines = stride_result.lines
            current_temp = stride_result.temp_index
            if stride_result.operand == None:
                diagnostics = append_string(diagnostics, "llvm lowering: `.for` stride expression did not produce a value in `" + function.name + "`")
                return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
            stride_coerced = coerce_operand_to_type(stride_result.operand, "double", current_temp, current_lines)
            diagnostics = (diagnostics) + (stride_coerced.diagnostics)
            current_lines = stride_coerced.lines
            current_temp = stride_coerced.temp_index
            if stride_coerced.operand == None:
                diagnostics = append_string(diagnostics, "llvm lowering: `.for` stride expression must evaluate to `number` in `" + function.name + "`")
                return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
            stride_operand = stride_coerced.operand
            if is_number_literal(stride_text):
                normalised_stride = normalise_number_literal(stride_text)
                if normalised_stride == "0.0":
                    diagnostics = append_string(diagnostics, "llvm lowering: `.for` stride must not be zero in `" + function.name + "`")
        stride_pointer = format_local_pointer_name(current_next_local)
        current_next_local += 1
        current_allocas = append_string(current_allocas, "  " + stride_pointer + " = alloca double")
        current_lines = append_string(current_lines, "  store double " + stride_operand.value + ", double* " + stride_pointer)
        loop_header_alloc = allocate_block_label("for", current_block_counter)
        loop_header_label = loop_header_alloc.label
        current_block_counter = loop_header_alloc.next_counter
        loop_body_alloc = allocate_block_label("forbody", current_block_counter)
        loop_body_label = loop_body_alloc.label
        current_block_counter = loop_body_alloc.next_counter
        loop_increment_alloc = allocate_block_label("forinc", current_block_counter)
        loop_increment_label = loop_increment_alloc.label
        current_block_counter = loop_increment_alloc.next_counter
        loop_exit_alloc = allocate_block_label("afterfor", current_block_counter)
        loop_exit_label = loop_exit_alloc.label
        current_block_counter = loop_exit_alloc.next_counter
        iteration_pointer = format_local_pointer_name(current_next_local)
        current_next_local += 1
        current_allocas = append_string(current_allocas, "  " + iteration_pointer + " = alloca double")
        current_lines = append_string(current_lines, "  store double " + start_operand.value + ", double* " + iteration_pointer)
        current_lines = append_string(current_lines, "  br label %" + loop_header_label)
        current_lines = append_string(current_lines, loop_header_label + ":")
        loop_body_scope_id = make_child_scope_id(scope_id, loop_body_label)
        iteration_binding = LocalBinding(name=raw_target, pointer=iteration_pointer, llvm_type="double", type_annotation="number", ownership=None, consumed=False, scope_id=loop_body_scope_id, scope_depth=scope_depth + 1)
        header_load = load_local_operand(iteration_binding, current_temp, current_lines)
        diagnostics = (diagnostics) + (header_load.diagnostics)
        current_lines = header_load.lines
        current_temp = header_load.temp_index
        if header_load.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: internal error loading `.for` iteration value in `" + function.name + "`")
            current_lines = append_string(current_lines, "  br label %" + loop_exit_label)
            current_lines = append_string(current_lines, loop_exit_label + ":")
            return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
        stride_header_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + stride_header_name + " = load double, double* " + stride_pointer)
        current_temp += 1
        stride_positive_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + stride_positive_name + " = fcmp ogt double " + stride_header_name + ", 0.0")
        current_temp += 1
        stride_negative_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + stride_negative_name + " = fcmp olt double " + stride_header_name + ", 0.0")
        current_temp += 1
        ascending_comparison = emit_comparison_instruction("<", header_load.operand, end_operand, current_temp, current_lines)
        diagnostics = (diagnostics) + (ascending_comparison.diagnostics)
        current_lines = ascending_comparison.lines
        current_temp = ascending_comparison.temp_index
        if ascending_comparison.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: unable to compare `.for` range bounds in `" + function.name + "`")
            current_lines = append_string(current_lines, "  br label %" + loop_exit_label)
            current_lines = append_string(current_lines, loop_exit_label + ":")
            return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
        descending_comparison = emit_comparison_instruction(">", header_load.operand, end_operand, current_temp, current_lines)
        diagnostics = (diagnostics) + (descending_comparison.diagnostics)
        current_lines = descending_comparison.lines
        current_temp = descending_comparison.temp_index
        if descending_comparison.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: unable to compare descending `.for` range bounds in `" + function.name + "`")
            current_lines = append_string(current_lines, "  br label %" + loop_exit_label)
            current_lines = append_string(current_lines, loop_exit_label + ":")
            return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
        ascending_active_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + ascending_active_name + " = and i1 " + stride_positive_name + ", " + ascending_comparison.operand.value)
        current_temp += 1
        descending_active_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + descending_active_name + " = and i1 " + stride_negative_name + ", " + descending_comparison.operand.value)
        current_temp += 1
        continue_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + continue_name + " = or i1 " + ascending_active_name + ", " + descending_active_name)
        current_temp += 1
        current_lines = append_string(current_lines, "  br i1 " + continue_name + ", label %" + loop_body_label + ", label %" + loop_exit_label)
        current_lines = append_string(current_lines, loop_body_label + ":")
        loop_context = LoopContext(break_label=loop_exit_label, continue_label=loop_increment_label)
        stacked = append_loop_context(loop_stack, loop_context)
        body_locals = append_local_binding(current_locals, iteration_binding)
        body_result = lower_instruction_range(
function,
structure.body_start,
structure.body_end,
llvm_return,
current_bindings,
body_locals,
current_allocas,
[],
current_temp,
current_block_counter,
current_next_local,
current_next_region,
functions,
stacked,
context,
loop_body_scope_id,
scope_depth + 1,
loop_body_label
)
        diagnostics = (diagnostics) + (body_result.diagnostics)
        lifetime_regions = (lifetime_regions) + (body_result.lifetime_regions)
        current_lines = (current_lines) + (body_result.lines)
        current_allocas = body_result.allocas
        current_temp = body_result.temp_index
        current_block_counter = body_result.block_counter
        current_next_local = body_result.next_local_id
        current_bindings = body_result.bindings
        current_next_region = body_result.next_lifetime_region_id
        collected_mutations = (collected_mutations) + (body_result.mutations)
        if not body_result.terminated:
            current_lines = append_string(current_lines, "  br label %" + loop_increment_label)
        current_lines = append_string(current_lines, loop_increment_label + ":")
        increment_load = load_local_operand(iteration_binding, current_temp, current_lines)
        diagnostics = (diagnostics) + (increment_load.diagnostics)
        current_lines = increment_load.lines
        current_temp = increment_load.temp_index
        if increment_load.operand != None:
            increment_stride_name = format_temp_name(current_temp)
            current_lines = append_string(current_lines, "  " + increment_stride_name + " = load double, double* " + stride_pointer)
            current_temp += 1
            next_value_name = format_temp_name(current_temp)
            current_lines = append_string(current_lines, "  " + next_value_name + " = fadd double " + increment_load.operand.value + ", " + increment_stride_name)
            current_temp += 1
            current_lines = append_string(current_lines, "  store double " + next_value_name + ", double* " + iteration_pointer)
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: unable to increment `.for` iterator in `" + function.name + "`")
        current_lines = append_string(current_lines, "  br label %" + loop_header_label)
        current_lines = append_string(current_lines, loop_exit_label + ":")
        mutated_names = collect_mutation_names(collected_mutations)
        exit_loads = []
        load_idx = 0
        while True:
            if load_idx >= len(mutated_names):
                break
            name = mutated_names[load_idx]
            local = find_local_binding(locals, name)
            if local != None:
                exit_load_temp = format_temp_name(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + exit_load_temp + " = load " + local.llvm_type + ", " + local.llvm_type + "* " + local.pointer)
                exit_loads = append_string(exit_loads, exit_load_temp)
            else:
                exit_loads = append_string(exit_loads, "")
            load_idx += 1
        exit_mutations = []
        exit_idx = 0
        while True:
            if exit_idx >= len(mutated_names):
                break
            name = mutated_names[exit_idx]
            exit_value = ""
            if exit_idx < len(exit_loads):
                exit_value = exit_loads[exit_idx]
            if len(exit_value) > 0:
                original = find_mutation_for_name(collected_mutations, name)
                llvm_type = ""
                original_span = None
                if original != None:
                    llvm_type = original.llvm_type
                    original_span = original.span
                if len(llvm_type) == 0:
                    local = find_local_binding(locals, name)
                    if local != None:
                        llvm_type = local.llvm_type
                if len(llvm_type) == 0:
                    llvm_type = "double"
                exit_mutation = LocalMutation(name=name, llvm_type=llvm_type, value_name=exit_value, span=original_span, originating_label=loop_exit_label)
                exit_mutations = (exit_mutations) + ([exit_mutation])
            exit_idx += 1
        collected_mutations = exit_mutations
        current_locals = locals
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
    iterable_result = lower_expression(instruction.iterable, current_bindings, current_locals, current_temp, current_lines, functions, context, "")
    diagnostics = (diagnostics) + (iterable_result.diagnostics)
    current_lines = iterable_result.lines
    current_temp = iterable_result.temp_index
    if iterable_result.operand == None:
        diagnostics = (diagnostics) + (range_parse.diagnostics)
        diagnostics = append_string(diagnostics, "llvm lowering: unable to lower `.for` iterable in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
    iterable_operand = iterable_result.operand
    element_type = array_pointer_element_type(iterable_operand.llvm_type)
    if len(element_type) == 0:
        diagnostics = (diagnostics) + (range_parse.diagnostics)
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` iterable must resolve to an array value in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
    array_struct_type = array_struct_type_for_element(element_type)
    data_pointer_type = element_type + "*"
    data_pointer_pointer_type = data_pointer_type + "*"
    length_pointer_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + length_pointer_name + " = getelementptr " + array_struct_type + ", " + array_struct_type + "* " + iterable_operand.value + ", i32 0, i32 1")
    current_temp += 1
    length_load_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + length_load_name + " = load i64, i64* " + length_pointer_name)
    current_temp += 1
    length_operand = LLVMOperand(llvm_type="i64", value=length_load_name)
    data_pointer_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + data_pointer_name + " = getelementptr " + array_struct_type + ", " + array_struct_type + "* " + iterable_operand.value + ", i32 0, i32 0")
    current_temp += 1
    data_load_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + data_load_name + " = load " + data_pointer_type + ", " + data_pointer_pointer_type + " " + data_pointer_name)
    current_temp += 1
    data_operand = LLVMOperand(llvm_type=data_pointer_type, value=data_load_name)
    loop_header_alloc = allocate_block_label("for", current_block_counter)
    loop_header_label = loop_header_alloc.label
    current_block_counter = loop_header_alloc.next_counter
    loop_body_alloc = allocate_block_label("forbody", current_block_counter)
    loop_body_label = loop_body_alloc.label
    current_block_counter = loop_body_alloc.next_counter
    loop_increment_alloc = allocate_block_label("forinc", current_block_counter)
    loop_increment_label = loop_increment_alloc.label
    current_block_counter = loop_increment_alloc.next_counter
    loop_exit_alloc = allocate_block_label("afterfor", current_block_counter)
    loop_exit_label = loop_exit_alloc.label
    current_block_counter = loop_exit_alloc.next_counter
    index_pointer = format_local_pointer_name(current_next_local)
    current_next_local += 1
    current_allocas = append_string(current_allocas, "  " + index_pointer + " = alloca i64")
    current_lines = append_string(current_lines, "  store i64 0, i64* " + index_pointer)
    iteration_pointer = format_local_pointer_name(current_next_local)
    current_next_local += 1
    current_allocas = append_string(current_allocas, "  " + iteration_pointer + " = alloca " + element_type)
    current_lines = append_string(current_lines, "  store " + element_type + " " + default_return_literal(element_type) + ", " + element_type + "* " + iteration_pointer)
    current_lines = append_string(current_lines, "  br label %" + loop_header_label)
    current_lines = append_string(current_lines, loop_header_label + ":")
    header_index_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + header_index_name + " = load i64, i64* " + index_pointer)
    current_temp += 1
    comparison_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + comparison_name + " = icmp slt i64 " + header_index_name + ", " + length_operand.value)
    current_temp += 1
    current_lines = append_string(current_lines, "  br i1 " + comparison_name + ", label %" + loop_body_label + ", label %" + loop_exit_label)
    current_lines = append_string(current_lines, loop_body_label + ":")
    body_index_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + body_index_name + " = load i64, i64* " + index_pointer)
    current_temp += 1
    element_pointer_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + element_pointer_name + " = getelementptr " + element_type + ", " + element_type + "* " + data_operand.value + ", i64 " + body_index_name)
    current_temp += 1
    element_load_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + element_load_name + " = load " + element_type + ", " + element_type + "* " + element_pointer_name)
    current_temp += 1
    current_lines = append_string(current_lines, "  store " + element_type + " " + element_load_name + ", " + element_type + "* " + iteration_pointer)
    loop_context = LoopContext(break_label=loop_exit_label, continue_label=loop_increment_label)
    stacked = append_loop_context(loop_stack, loop_context)
    element_loop_scope_id = make_child_scope_id(scope_id, loop_body_label)
    iteration_binding = LocalBinding(name=raw_target, pointer=iteration_pointer, llvm_type=element_type, type_annotation="", ownership=None, consumed=False, scope_id=element_loop_scope_id, scope_depth=scope_depth + 1)
    body_locals = append_local_binding(current_locals, iteration_binding)
    body_result = lower_instruction_range(
function,
structure.body_start,
structure.body_end,
llvm_return,
current_bindings,
body_locals,
current_allocas,
[],
current_temp,
current_block_counter,
current_next_local,
current_next_region,
functions,
stacked,
context,
element_loop_scope_id,
scope_depth + 1,
loop_body_label
)
    diagnostics = (diagnostics) + (body_result.diagnostics)
    lifetime_regions = (lifetime_regions) + (body_result.lifetime_regions)
    current_lines = (current_lines) + (body_result.lines)
    current_allocas = body_result.allocas
    current_temp = body_result.temp_index
    current_block_counter = body_result.block_counter
    current_next_local = body_result.next_local_id
    current_bindings = body_result.bindings
    current_next_region = body_result.next_lifetime_region_id
    collected_mutations = (collected_mutations) + (body_result.mutations)
    collected_string_constants = merge_string_constants(collected_string_constants, body_result.string_constants)
    if not body_result.terminated:
        current_lines = append_string(current_lines, "  br label %" + loop_increment_label)
    current_lines = append_string(current_lines, loop_increment_label + ":")
    increment_index_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + increment_index_name + " = load i64, i64* " + index_pointer)
    current_temp += 1
    next_index_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + next_index_name + " = add i64 " + increment_index_name + ", 1")
    current_temp += 1
    current_lines = append_string(current_lines, "  store i64 " + next_index_name + ", i64* " + index_pointer)
    current_lines = append_string(current_lines, "  br label %" + loop_header_label)
    current_lines = append_string(current_lines, loop_exit_label + ":")
    mutated_names = collect_mutation_names(collected_mutations)
    exit_loads = []
    load_idx = 0
    while True:
        if load_idx >= len(mutated_names):
            break
        name = mutated_names[load_idx]
        local = find_local_binding(locals, name)
        if local != None:
            exit_load_temp = format_temp_name(current_temp)
            current_temp += 1
            current_lines = append_string(current_lines, "  " + exit_load_temp + " = load " + local.llvm_type + ", " + local.llvm_type + "* " + local.pointer)
            exit_loads = append_string(exit_loads, exit_load_temp)
        else:
            exit_loads = append_string(exit_loads, "")
        load_idx += 1
    exit_mutations = []
    exit_idx = 0
    while True:
        if exit_idx >= len(mutated_names):
            break
        name = mutated_names[exit_idx]
        exit_value = ""
        if exit_idx < len(exit_loads):
            exit_value = exit_loads[exit_idx]
        if len(exit_value) > 0:
            original = find_mutation_for_name(collected_mutations, name)
            llvm_type = ""
            original_span = None
            if original != None:
                llvm_type = original.llvm_type
                original_span = original.span
            if len(llvm_type) == 0:
                local = find_local_binding(locals, name)
                if local != None:
                    llvm_type = local.llvm_type
            if len(llvm_type) == 0:
                llvm_type = "double"
            exit_mutation = LocalMutation(name=name, llvm_type=llvm_type, value_name=exit_value, span=original_span, originating_label=loop_exit_label)
            exit_mutations = (exit_mutations) + ([exit_mutation])
        exit_idx += 1
    collected_mutations = exit_mutations
    current_locals = locals
    empty_constants = empty_string_constant_set()
    return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=empty_constants)

def collect_match_structure(instructions, start_index, end, function_name):
    diagnostics = []
    cases = []
    current_case = None
    index = start_index + 1
    depth = 0
    limit = end
    if limit > len(instructions):
        limit = len(instructions)
    while True:
        if index >= limit:
            diagnostics = append_string(diagnostics, "llvm lowering: unterminated `.match` in `" + function_name + "`")
            if current_case != None:
                finished = finalize_match_case(current_case, limit)
                cases = append_match_case(cases, finished)
            return MatchStructure(cases=cases, end_index=limit - 1, diagnostics=diagnostics)
        instruction = instructions[index]
        if instruction.variant == "Match":
            depth += 1
            index += 1
            continue
        if instruction.variant == "EndMatch":
            if depth == 0:
                if current_case != None:
                    finished = finalize_match_case(current_case, index)
                    cases = append_match_case(cases, finished)
                    current_case = None
                return MatchStructure(cases=cases, end_index=index, diagnostics=diagnostics)
            depth -= 1
            index += 1
            continue
        if depth > 0:
            index += 1
            continue
        if instruction.variant == "Case":
            if current_case != None:
                finished = finalize_match_case(current_case, index)
                cases = append_match_case(cases, finished)
            guard_text = None
            if instruction.guard != None:
                guard_text = instruction.guard
            current_case = MatchCaseStructure(pattern=instruction.pattern, guard=guard_text, body_start=index + 1, body_end=index + 1, is_default=is_default_pattern(instruction.pattern))
            index += 1
            continue
        index += 1
    return MatchStructure(cases=cases, end_index=limit, diagnostics=diagnostics)

def append_match_case(cases, value):
    return (cases) + ([value])

def finalize_match_case(case, body_end):
    value = case
    return MatchCaseStructure(pattern=value.pattern, guard=value.guard, body_start=value.body_start, body_end=body_end, is_default=value.is_default)

def is_default_pattern(pattern):
    trimmed = trim_text(pattern)
    if len(trimmed) == 0:
        return True
    if trimmed == "_":
        return True
    return False

def lower_match_instruction(function, start_index, llvm_return, bindings, locals, allocas, lines, temp_index, block_counter, next_local_id, next_region_id, functions, loop_stack, end, context, scope_id, scope_depth, current_label):
    diagnostics = []
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_temp = temp_index
    current_block_counter = block_counter
    current_next_local = next_local_id
    base_bindings = bindings
    merged_bindings = base_bindings
    lifetime_regions = []
    current_next_region = next_region_id
    collected_mutations = []
    collected_string_constants = empty_string_constant_set()
    structure = collect_match_structure(function.instructions, start_index, end, function.name)
    diagnostics = (diagnostics) + (structure.diagnostics)
    subject_instruction = function.instructions[start_index]
    subject_result = lower_expression(subject_instruction.expression, bindings, current_locals, current_temp, current_lines, functions, context, "")
    diagnostics = (diagnostics) + (subject_result.diagnostics)
    current_lines = subject_result.lines
    current_temp = subject_result.temp_index
    collected_string_constants = merge_string_constants(collected_string_constants, subject_result.string_constants)
    if subject_result.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to lower match subject in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=base_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=structure.end_index + 1, mutations=collected_mutations, string_constants=collected_string_constants)
    subject_operand = subject_result.operand
    if len(structure.cases) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: match without cases in `" + function.name + "`")
        merge_alloc = allocate_block_label("matchmerge", current_block_counter)
        merge_label = merge_alloc.label
        current_block_counter = merge_alloc.next_counter
        current_lines = append_string(current_lines, "  br label %" + merge_label)
        current_lines = append_string(current_lines, merge_label + ":")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=base_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=structure.end_index + 1, mutations=collected_mutations, string_constants=collected_string_constants)
    test_labels = []
    body_labels = []
    index = 0
    while True:
        if index >= len(structure.cases):
            break
        test_alloc = allocate_block_label("matchcase", current_block_counter)
        body_alloc = allocate_block_label("matchbody", test_alloc.next_counter)
        test_labels = append_string(test_labels, test_alloc.label)
        body_labels = append_string(body_labels, body_alloc.label)
        current_block_counter = body_alloc.next_counter
        index += 1
    merge_alloc = allocate_block_label("matchmerge", current_block_counter)
    merge_label = merge_alloc.label
    current_block_counter = merge_alloc.next_counter
    preloaded_locals = []
    preload_index = 0
    while True:
        if preload_index >= len(current_locals):
            break
        local = current_locals[preload_index]
        preload_temp = format_temp_name(current_temp)
        current_temp += 1
        preload_line = "  " + preload_temp + " = load " + local.llvm_type + ", " + local.llvm_type + "* " + local.pointer
        current_lines = append_string(current_lines, preload_line)
        preloaded_locals = append_string(preloaded_locals, preload_temp)
        preload_index += 1
    current_lines = append_string(current_lines, "  br label %" + test_labels[0])
    all_terminated = True
    has_unconditional_default = False
    arm_mutations_list = []
    index = 0
    while True:
        if index >= len(structure.cases):
            break
        case = structure.cases[index]
        failure_target = merge_label
        if index + 1 < len(structure.cases):
            failure_target = test_labels[index + 1]
        current_lines = append_string(current_lines, test_labels[index] + ":")
        lowered_condition = lower_match_case_condition(
function.name,
subject_operand,
case,
bindings,
current_locals,
current_temp,
current_lines,
functions,
context
)
        diagnostics = (diagnostics) + (lowered_condition.diagnostics)
        current_lines = lowered_condition.lines
        current_temp = lowered_condition.temp_index
        collected_string_constants = merge_string_constants(collected_string_constants, lowered_condition.string_constants)
        if lowered_condition.is_default:
            has_unconditional_default = True
            current_lines = append_string(current_lines, "  br label %" + body_labels[index])
        else:
            if lowered_condition.operand != None:
                current_lines = append_string(current_lines, "  br i1 " + lowered_condition.operand.value + ", label %" + body_labels[index] + ", label %" + failure_target)
            else:
                current_lines = append_string(current_lines, "  br label %" + failure_target)
        current_lines = append_string(current_lines, body_labels[index] + ":")
        base_locals = current_locals
        base_allocas = current_allocas
        base_local_id = current_next_local
        if len(lowered_condition.field_bindings) > 0  and  lowered_condition.enum_info != None  and  lowered_condition.variant_info != None  and  subject_operand != None:
            enum_info_val = lowered_condition.enum_info
            variant_info_val = lowered_condition.variant_info
            subject_alloca_temp = format_temp_name(current_temp)
            current_temp += 1
            current_lines = append_string(current_lines, "  " + subject_alloca_temp + " = alloca " + subject_operand.llvm_type)
            current_lines = append_string(current_lines, "  store " + subject_operand.llvm_type + " " + subject_operand.value + ", " + subject_operand.llvm_type + "* " + subject_alloca_temp)
            binding_idx = 0
            while True:
                if binding_idx >= len(lowered_condition.field_bindings):
                    break
                field_binding = lowered_condition.field_bindings[binding_idx]
                payload_ptr_temp = format_temp_name(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + payload_ptr_temp + " = getelementptr inbounds " + enum_info_val.llvm_name + ", " + enum_info_val.llvm_name + "* " + subject_alloca_temp + ", i32 0, i32 1")
                byte_ptr_temp = format_temp_name(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + byte_ptr_temp + " = bitcast [" + number_to_string(variant_info_val.size) + " x i8]* " + payload_ptr_temp + " to i8*")
                field_offset_in_payload = field_binding.field_offset - variant_info_val.offset
                field_ptr_temp = byte_ptr_temp
                if field_offset_in_payload > 0:
                    offset_ptr_temp = format_temp_name(current_temp)
                    current_temp += 1
                    current_lines = append_string(current_lines, "  " + offset_ptr_temp + " = getelementptr inbounds i8, i8* " + byte_ptr_temp + ", i64 " + number_to_string(field_offset_in_payload))
                    field_ptr_temp = offset_ptr_temp
                typed_ptr_temp = format_temp_name(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + typed_ptr_temp + " = bitcast i8* " + field_ptr_temp + " to " + field_binding.field_type + "*")
                value_temp = format_temp_name(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + value_temp + " = load " + field_binding.field_type + ", " + field_binding.field_type + "* " + typed_ptr_temp)
                local_alloca_temp = format_temp_name(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + local_alloca_temp + " = alloca " + field_binding.field_type)
                current_lines = append_string(current_lines, "  store " + field_binding.field_type + " " + value_temp + ", " + field_binding.field_type + "* " + local_alloca_temp)
                base_locals = (base_locals) + ([LocalBinding(name=field_binding.field_name, pointer=local_alloca_temp, llvm_type=field_binding.field_type, type_annotation="", ownership=None, consumed=False, scope_id=make_child_scope_id(scope_id, body_labels[index]), scope_depth=scope_depth + 1)])
                base_local_id += 1
                binding_idx += 1
        body_result = lower_instruction_range(
function,
case.body_start,
case.body_end,
llvm_return,
bindings,
base_locals,
base_allocas,
[],
current_temp,
current_block_counter,
base_local_id,
current_next_region,
functions,
loop_stack,
context,
make_child_scope_id(scope_id, body_labels[index]),
scope_depth + 1,
body_labels[index]
)
        diagnostics = (diagnostics) + (body_result.diagnostics)
        lifetime_regions = (lifetime_regions) + (body_result.lifetime_regions)
        current_lines = (current_lines) + (body_result.lines)
        current_allocas = body_result.allocas
        current_locals = base_locals
        current_temp = body_result.temp_index
        current_block_counter = body_result.block_counter
        current_next_local = body_result.next_local_id
        current_next_region = body_result.next_lifetime_region_id
        collected_mutations = (collected_mutations) + (body_result.mutations)
        collected_string_constants = merge_string_constants(collected_string_constants, body_result.string_constants)
        arm_mutations_list = append_match_arm_mutations(
arm_mutations_list,
MatchArmMutations(mutations=body_result.mutations, label=body_labels[index], terminated=body_result.terminated)
)
        if not body_result.terminated:
            merged_bindings = merge_parameter_bindings(merged_bindings, body_result.bindings)
            current_lines = append_string(current_lines, "  br label %" + merge_label)
            all_terminated = False
        else:
            all_terminated = all_terminated  and  True
        index += 1
    terminated = all_terminated  and  has_unconditional_default
    if not terminated:
        current_lines = append_string(current_lines, merge_label + ":")
        phi_result = emit_phi_merges_for_match(
arm_mutations_list,
current_locals,
preloaded_locals,
current_lines,
current_temp
)
        current_lines = phi_result.lines
        current_temp = phi_result.temp_index
    result_string_constants = collected_string_constants
    return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=merged_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=terminated, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=structure.end_index + 1, mutations=collected_mutations, string_constants=result_string_constants)

def lower_match_case_condition(function_name, subject_operand, case, bindings, locals, temp_index, lines, functions, context):
    diagnostics = []
    current_lines = lines
    current_temp = temp_index
    condition_operand = None
    field_bindings = []
    matched_enum_info = None
    matched_variant_info = None
    collected_string_constants = empty_string_constant_set()
    if not case.is_default:
        enum_parse = parse_enum_literal(case.pattern)
        if enum_parse.recognized  and  enum_parse.success:
            enum_info = resolve_enum_info_for_literal(context, enum_parse.enum_name)
            if enum_info == None:
                diagnostics = append_string(diagnostics, "llvm lowering: match pattern references unknown enum `" + enum_parse.enum_name + "`")
            else:
                variant_info = resolve_enum_variant_info(enum_info, enum_parse.variant_name)
                if variant_info == None:
                    diagnostics = append_string(diagnostics, "llvm lowering: enum `" + enum_parse.enum_name + "` has no variant `" + enum_parse.variant_name + "`")
                else:
                    tag_llvm_type = "i32"
                    if enum_info.tag_type == "i8":
                        tag_llvm_type = "i8"
                    if enum_info.tag_type == "i16":
                        tag_llvm_type = "i16"
                    if enum_info.tag_type == "i32":
                        tag_llvm_type = "i32"
                    if enum_info.tag_type == "i64":
                        tag_llvm_type = "i64"
                    tag_temp = format_temp_name(current_temp)
                    current_temp += 1
                    current_lines = append_string(current_lines, "  " + tag_temp + " = extractvalue " + subject_operand.llvm_type + " " + subject_operand.value + ", 0")
                    tag_operand = LLVMOperand(llvm_type=tag_llvm_type, value=tag_temp)
                    variant_tag_operand = LLVMOperand(llvm_type=tag_llvm_type, value=number_to_string(variant_info.tag))
                    comparison = emit_comparison_instruction("==", tag_operand, variant_tag_operand, current_temp, current_lines)
                    diagnostics = (diagnostics) + (comparison.diagnostics)
                    current_lines = comparison.lines
                    current_temp = comparison.temp_index
                    condition_operand = comparison.operand
                    if len(variant_info.fields) > 0:
                        field_idx = 0
                        while True:
                            if field_idx >= len(enum_parse.fields):
                                break
                            pattern_field = enum_parse.fields[field_idx]
                            variant_field_idx = 0
                            found_field = None
                            while True:
                                if variant_field_idx >= len(variant_info.fields):
                                    break
                                if variant_info.fields[variant_field_idx].name == pattern_field.name:
                                    found_field = variant_info.fields[variant_field_idx]
                                    break
                                variant_field_idx += 1
                            if found_field != None:
                                field_bindings = (field_bindings) + ([MatchFieldBinding(field_name=pattern_field.name, field_type=found_field.llvm_type, field_offset=found_field.offset)])
                            else:
                                diagnostics = append_string(diagnostics, "llvm lowering: match pattern field `" + pattern_field.name + "` not found in variant `" + enum_parse.enum_name + "." + enum_parse.variant_name + "`")
                            field_idx += 1
                        matched_enum_info = enum_info
                        matched_variant_info = variant_info
        else:
            pattern_result = lower_expression(case.pattern, bindings, locals, current_temp, current_lines, functions, context, "")
            diagnostics = (diagnostics) + (pattern_result.diagnostics)
            current_lines = pattern_result.lines
            current_temp = pattern_result.temp_index
            collected_string_constants = merge_string_constants(collected_string_constants, pattern_result.string_constants)
            if pattern_result.operand != None:
                harmonised = harmonise_operands(subject_operand, pattern_result.operand, current_temp, current_lines)
                diagnostics = (diagnostics) + (harmonised.diagnostics)
                if harmonised.left != None  and  harmonised.right != None:
                    current_lines = harmonised.lines
                    current_temp = harmonised.temp_index
                    comparison = emit_comparison_instruction("==", harmonised.left, harmonised.right, current_temp, current_lines)
                    diagnostics = (diagnostics) + (comparison.diagnostics)
                    current_lines = comparison.lines
                    current_temp = comparison.temp_index
                    condition_operand = comparison.operand
                else:
                    current_lines = harmonised.lines
                    current_temp = harmonised.temp_index
            else:
                diagnostics = append_string(diagnostics, "llvm lowering: unable to lower match case pattern in `" + function_name + "`")
    if case.guard != None:
        guard_text = trim_text(case.guard)
        if len(guard_text) > 0:
            guard_condition = lower_condition_to_i1(function_name, guard_text, bindings, locals, current_temp, current_lines, functions, context)
            diagnostics = (diagnostics) + (guard_condition.diagnostics)
            current_lines = guard_condition.lines
            current_temp = guard_condition.temp_index
            collected_string_constants = merge_string_constants(collected_string_constants, guard_condition.string_constants)
            if guard_condition.operand != None:
                if condition_operand == None:
                    condition_operand = guard_condition.operand
                else:
                    merged = emit_boolean_and(condition_operand, guard_condition.operand, current_temp, current_lines)
                    diagnostics = (diagnostics) + (merged.diagnostics)
                    current_lines = merged.lines
                    current_temp = merged.temp_index
                    condition_operand = merged.operand
            else:
                diagnostics = append_string(diagnostics, "llvm lowering: unable to lower guard in match case for `" + function_name + "`")
    is_unconditional_default = False
    if case.is_default:
        if case.guard == None:
            is_unconditional_default = True
        else:
            guard_trimmed = trim_text(case.guard)
            if len(guard_trimmed) == 0:
                is_unconditional_default = True
    return MatchCaseCondition(lines=current_lines, temp_index=current_temp, operand=condition_operand, diagnostics=diagnostics, is_default=is_unconditional_default, field_bindings=field_bindings, enum_info=matched_enum_info, variant_info=matched_variant_info, string_constants=collected_string_constants)

def allocate_block_label(prefix, counter):
    return BlockLabelResult(label=prefix + number_to_string(counter), next_counter=counter + 1)

def lower_condition_to_i1(function_name, expression, bindings, locals, temp_index, lines, functions, context):
    diagnostics = detect_suspension_conflicts(expression, locals, bindings, function_name, None)
    lowered = lower_expression(expression, bindings, locals, temp_index, lines, functions, context, "")
    diagnostics = (diagnostics) + (lowered.diagnostics)
    current_lines = lowered.lines
    current_temp = lowered.temp_index
    string_constants = lowered.string_constants
    if lowered.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: condition produced no value in `" + function_name + "`")
        return ConditionConversion(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    operand = lowered.operand
    if operand.llvm_type == "i1":
        return ConditionConversion(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=string_constants)
    if operand.llvm_type == "double":
        temp_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + temp_name + " = fcmp one double " + operand.value + ", 0.0")
        converted = LLVMOperand(llvm_type="i1", value=temp_name)
        return ConditionConversion(lines=current_lines, temp_index=current_temp + 1, operand=converted, diagnostics=diagnostics, string_constants=string_constants)
    if operand.llvm_type == "i32"  or  operand.llvm_type == "i64":
        temp_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + temp_name + " = icmp ne " + operand.llvm_type + " " + operand.value + ", " + default_return_literal(operand.llvm_type) + "")
        converted = LLVMOperand(llvm_type="i1", value=temp_name)
        return ConditionConversion(lines=current_lines, temp_index=current_temp + 1, operand=converted, diagnostics=diagnostics, string_constants=string_constants)
    diagnostics = append_string(diagnostics, "llvm lowering: unsupported condition type `" + operand.llvm_type + "` in `" + function_name + "`")
    return ConditionConversion(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=string_constants)

def find_preloaded_value(locals, preloaded_values, name):
    local_index = 0
    while True:
        if local_index >= len(locals):
            break
        check_local = locals[local_index]
        if check_local.name == name  and  local_index < len(preloaded_values):
            return preloaded_values[local_index]
        local_index += 1
    return None

def collect_mutation_names(mutations):
    names = []
    index = 0
    while True:
        if index >= len(mutations):
            break
        mutation = mutations[index]
        already_added = False
        check_index = 0
        while True:
            if check_index >= len(names):
                break
            if names[check_index] == mutation.name:
                already_added = True
                break
            check_index += 1
        if not already_added:
            names = append_string(names, mutation.name)
        index += 1
    return names

def find_mutation_for_name(mutations, name):
    index = 0
    while True:
        if index >= len(mutations):
            break
        if mutations[index].name == name:
            return mutations[index]
        index += 1
    return None

def join_strings(strings, separator):
    result = ""
    index = 0
    while True:
        if index >= len(strings):
            break
        if index > 0:
            result = result + separator
        result = result + strings[index]
        index += 1
    return result

def build_phi_and_store(local, llvm_type, phi_inputs, temp_index):
    phi_temp = format_temp_name(temp_index)
    phi_input_str = join_strings(phi_inputs, ", ")
    phi_line = "  " + phi_temp + " = phi " + llvm_type + " " + phi_input_str
    store_line = "  store " + llvm_type + " " + phi_temp + ", " + llvm_type + "* " + local.pointer
    return PhiStoreEntry(phi_line=phi_line, store_line=store_line)

def find_last_label(lines, fallback):
    index = len(lines)
    while True:
        if index <= 0:
            break
        index -= 1
        line = lines[index]
        if len(line) == 0:
            continue
        if line[len(line) - 1] == ":":
            return substring(line, 0, len(line) - 1)
    return fallback

def retarget_recent_mutations(mutations, start_index, target_label):
    if len(target_label) == 0:
        return mutations
    index = 0
    result = []
    while True:
        if index >= len(mutations):
            break
        mutation = mutations[index]
        if index >= start_index:
            updated = LocalMutation(name=mutation.name, llvm_type=mutation.llvm_type, value_name=mutation.value_name, span=mutation.span, originating_label=target_label)
            result = (result) + ([updated])
        else:
            result = (result) + ([mutation])
        index += 1
    return result

def materialize_mutation_values_at_exit(mutations, locals, lines, temp_index):
    updated_lines = lines
    current_temp = temp_index
    updated_mutations = []
    index = 0
    while True:
        if index >= len(mutations):
            break
        mutation = mutations[index]
        local = find_local_binding(locals, mutation.name)
        if local != None:
            load_temp = format_temp_name(current_temp)
            current_temp += 1
            load_line = "  " + load_temp + " = load " + local.llvm_type + ", " + local.llvm_type + "* " + local.pointer
            updated_lines = append_string(updated_lines, load_line)
            updated = LocalMutation(name=mutation.name, llvm_type=mutation.llvm_type, value_name=load_temp, span=mutation.span, originating_label=mutation.originating_label)
            updated_mutations = (updated_mutations) + ([updated])
        else:
            updated_mutations = (updated_mutations) + ([mutation])
        index += 1
    return MutationMaterializationResult(mutations=updated_mutations, lines=updated_lines, temp_index=current_temp)

def emit_phi_merges_for_straight_if(mutations, locals, preloaded_values, base_label, then_label, lines, temp_index):
    phi_lines = []
    store_lines = []
    current_temp = temp_index
    index = 0
    while True:
        if index >= len(mutations):
            break
        mutation = mutations[index]
        local = find_local_binding(locals, mutation.name)
        if local != None:
            preloaded_value = find_preloaded_value(locals, preloaded_values, mutation.name)
            if preloaded_value != None  and  len(preloaded_value) > 0:
                then_source_label = mutation.originating_label
                if len(then_source_label) == 0:
                    then_source_label = then_label
                phi_inputs = ["[ " + mutation.value_name + ", %" + then_source_label + " ]", "[ " + preloaded_value + ", %" + base_label + " ]"]
                entry = build_phi_and_store(local, mutation.llvm_type, phi_inputs, current_temp)
                phi_lines = append_string(phi_lines, entry.phi_line)
                store_lines = append_string(store_lines, entry.store_line)
                current_temp += 1
        index += 1
    lines_with_phi = (lines) + (phi_lines)
    combined_lines = (lines_with_phi) + (store_lines)
    return PhiMergeResult(lines=combined_lines, temp_index=current_temp)

def emit_phi_merges_for_if_else(then_mutations, else_mutations, locals, preloaded_values, then_label, else_label, then_exit_label, else_exit_label, then_terminated, else_terminated, lines, temp_index):
    phi_lines = []
    store_lines = []
    current_temp = temp_index
    then_names = collect_mutation_names(then_mutations)
    else_names = collect_mutation_names(else_mutations)
    mutated_names = then_names
    else_idx = 0
    while True:
        if else_idx >= len(else_names):
            break
        else_name = else_names[else_idx]
        already_added = False
        check_idx = 0
        while True:
            if check_idx >= len(mutated_names):
                break
            if mutated_names[check_idx] == else_name:
                already_added = True
                break
            check_idx += 1
        if not already_added:
            mutated_names = append_string(mutated_names, else_name)
        else_idx += 1
    name_idx = 0
    while True:
        if name_idx >= len(mutated_names):
            break
        name = mutated_names[name_idx]
        local = find_local_binding(locals, name)
        if local != None:
            then_mutation = find_mutation_for_name(then_mutations, name)
            else_mutation = find_mutation_for_name(else_mutations, name)
            preloaded_value = find_preloaded_value(locals, preloaded_values, name)
            llvm_type = local.llvm_type
            if then_mutation != None:
                llvm_type = then_mutation.llvm_type
            if else_mutation != None  and  len(else_mutation.llvm_type) > 0:
                llvm_type = else_mutation.llvm_type
            phi_inputs = []
            if not then_terminated:
                if then_mutation != None:
                    then_source_label = then_mutation.originating_label
                    if len(then_source_label) == 0:
                        if len(then_exit_label) > 0:
                            then_source_label = then_exit_label
                        else:
                            then_source_label = then_label
                    phi_inputs = append_string(phi_inputs, "[ " + then_mutation.value_name + ", %" + then_source_label + " ]")
                else:
                    if preloaded_value != None:
                        fallback_label = then_exit_label
                        if len(fallback_label) == 0:
                            fallback_label = then_label
                        phi_inputs = append_string(phi_inputs, "[ " + preloaded_value + ", %" + fallback_label + " ]")
            if not else_terminated:
                if else_mutation != None:
                    else_source_label = else_mutation.originating_label
                    if len(else_source_label) == 0:
                        if len(else_exit_label) > 0:
                            else_source_label = else_exit_label
                        else:
                            else_source_label = else_label
                    phi_inputs = append_string(phi_inputs, "[ " + else_mutation.value_name + ", %" + else_source_label + " ]")
                else:
                    if preloaded_value != None:
                        fallback_label = else_exit_label
                        if len(fallback_label) == 0:
                            fallback_label = else_label
                        phi_inputs = append_string(phi_inputs, "[ " + preloaded_value + ", %" + fallback_label + " ]")
            if len(phi_inputs) >= 2:
                entry = build_phi_and_store(local, llvm_type, phi_inputs, current_temp)
                phi_lines = append_string(phi_lines, entry.phi_line)
                store_lines = append_string(store_lines, entry.store_line)
                current_temp += 1
        name_idx += 1
    lines_with_phi = (lines) + (phi_lines)
    combined_lines = (lines_with_phi) + (store_lines)
    return PhiMergeResult(lines=combined_lines, temp_index=current_temp)

def emit_phi_merges_for_match(arm_mutations_list, locals, preloaded_values, lines, temp_index):
    phi_lines = []
    store_lines = []
    current_temp = temp_index
    mutated_names = []
    arm_idx = 0
    while True:
        if arm_idx >= len(arm_mutations_list):
            break
        arm = arm_mutations_list[arm_idx]
        arm_names = collect_mutation_names(arm.mutations)
        name_idx = 0
        while True:
            if name_idx >= len(arm_names):
                break
            arm_name = arm_names[name_idx]
            already_added = False
            check_idx = 0
            while True:
                if check_idx >= len(mutated_names):
                    break
                if mutated_names[check_idx] == arm_name:
                    already_added = True
                    break
                check_idx += 1
            if not already_added:
                mutated_names = append_string(mutated_names, arm_name)
            name_idx += 1
        arm_idx += 1
    name_idx = 0
    while True:
        if name_idx >= len(mutated_names):
            break
        name = mutated_names[name_idx]
        local = find_local_binding(locals, name)
        if local != None:
            preloaded_value = find_preloaded_value(locals, preloaded_values, name)
            llvm_type = local.llvm_type
            phi_inputs = []
            arm_scan_idx = 0
            while True:
                if arm_scan_idx >= len(arm_mutations_list):
                    break
                arm = arm_mutations_list[arm_scan_idx]
                if not arm.terminated:
                    arm_mutation = find_mutation_for_name(arm.mutations, name)
                    if arm_mutation != None:
                        if len(arm_mutation.llvm_type) > 0:
                            llvm_type = arm_mutation.llvm_type
                        phi_inputs = append_string(phi_inputs, "[ " + arm_mutation.value_name + ", %" + arm.label + " ]")
                    else:
                        if preloaded_value != None:
                            phi_inputs = append_string(phi_inputs, "[ " + preloaded_value + ", %" + arm.label + " ]")
                arm_scan_idx += 1
            if len(phi_inputs) >= 2:
                entry = build_phi_and_store(local, llvm_type, phi_inputs, current_temp)
                phi_lines = append_string(phi_lines, entry.phi_line)
                store_lines = append_string(store_lines, entry.store_line)
                current_temp += 1
        name_idx += 1
    lines_with_phi = (lines) + (phi_lines)
    combined_lines = (lines_with_phi) + (store_lines)
    return PhiMergeResult(lines=combined_lines, temp_index=current_temp)

def lower_if_instruction(function, start_index, llvm_return, bindings, locals, allocas, lines, temp_index, block_counter, next_local_id, next_region_id, functions, loop_stack, end, context, scope_id, scope_depth, current_label):
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_temp = temp_index
    current_block_counter = block_counter
    current_next_local = next_local_id
    diagnostics = []
    base_bindings = bindings
    then_bindings = base_bindings
    else_bindings = base_bindings
    lifetime_regions = []
    current_next_region = next_region_id
    collected_mutations = []
    structure = collect_if_structure(function.instructions, start_index, end, function.name)
    diagnostics = (diagnostics) + (structure.diagnostics)
    condition = lower_condition_to_i1(
function.name,
function.instructions[start_index].condition,
bindings,
current_locals,
current_temp,
current_lines,
functions,
context
)
    diagnostics = (diagnostics) + (condition.diagnostics)
    current_lines = condition.lines
    current_temp = condition.temp_index
    collected_string_constants = condition.string_constants
    if condition.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to lower if condition in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=base_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=structure.next_index + 1, mutations=[], string_constants=collected_string_constants)
    then_label_alloc = allocate_block_label("then", current_block_counter)
    then_label = then_label_alloc.label
    current_block_counter = then_label_alloc.next_counter
    else_label = ""
    if structure.has_else:
        else_alloc = allocate_block_label("else", current_block_counter)
        else_label = else_alloc.label
        current_block_counter = else_alloc.next_counter
    merge_alloc = allocate_block_label("merge", current_block_counter)
    merge_label = merge_alloc.label
    current_block_counter = merge_alloc.next_counter
    false_target = merge_label
    if structure.has_else:
        false_target = else_label
    preloaded_locals = []
    preload_index = 0
    while True:
        if preload_index >= len(current_locals):
            break
        local = current_locals[preload_index]
        preload_temp = format_temp_name(current_temp)
        current_temp += 1
        preload_line = "  " + preload_temp + " = load " + local.llvm_type + ", " + local.llvm_type + "* " + local.pointer
        current_lines = append_string(current_lines, preload_line)
        preloaded_locals = append_string(preloaded_locals, preload_temp)
        preload_index += 1
    current_lines = append_string(current_lines, "  br i1 " + condition.operand.value + ", label %" + then_label + ", label %" + false_target)
    branch_label = find_last_label(current_lines, current_label)
    base_locals = current_locals
    base_allocas = current_allocas
    base_temp = current_temp
    base_local_id = current_next_local
    base_block_counter = current_block_counter
    current_lines = append_string(current_lines, then_label + ":")
    then_scope_id = make_child_scope_id(scope_id, then_label)
    then_result = lower_instruction_range(
function,
structure.then_start,
structure.then_end,
llvm_return,
bindings,
base_locals,
base_allocas,
[],
base_temp,
base_block_counter,
base_local_id,
current_next_region,
functions,
loop_stack,
context,
then_scope_id,
scope_depth + 1,
then_label
)
    diagnostics = (diagnostics) + (then_result.diagnostics)
    lifetime_regions = (lifetime_regions) + (then_result.lifetime_regions)
    current_allocas = then_result.allocas
    current_locals = then_result.locals
    current_temp = then_result.temp_index
    current_block_counter = then_result.block_counter
    current_next_local = then_result.next_local_id
    then_bindings = then_result.bindings
    current_next_region = then_result.next_lifetime_region_id
    current_lines = (current_lines) + (then_result.lines)
    then_exit_label = find_last_label(current_lines, then_label)
    then_mutations = retarget_recent_mutations(then_result.mutations, 0, then_exit_label)
    if not then_result.terminated  and  len(then_mutations) > 0:
        materialized_then = materialize_mutation_values_at_exit(then_mutations, base_locals, current_lines, current_temp)
        current_lines = materialized_then.lines
        current_temp = materialized_then.temp_index
        then_mutations = materialized_then.mutations
    collected_mutations = (collected_mutations) + (then_mutations)
    collected_string_constants = merge_string_constants(collected_string_constants, then_result.string_constants)
    then_terminated = then_result.terminated
    if not then_terminated:
        current_lines = append_string(current_lines, "  br label %" + merge_label)
    else_terminated = False
    else_mutations = []
    else_exit_label = else_label
    if structure.has_else:
        current_lines = append_string(current_lines, else_label + ":")
        else_scope_id = make_child_scope_id(scope_id, else_label)
        else_result = lower_instruction_range(
function,
structure.else_start,
structure.else_end,
llvm_return,
bindings,
base_locals,
current_allocas,
[],
current_temp,
current_block_counter,
current_next_local,
current_next_region,
functions,
loop_stack,
context,
else_scope_id,
scope_depth + 1,
else_label
)
        diagnostics = (diagnostics) + (else_result.diagnostics)
        lifetime_regions = (lifetime_regions) + (else_result.lifetime_regions)
        current_allocas = else_result.allocas
        current_locals = else_result.locals
        current_temp = else_result.temp_index
        current_block_counter = else_result.block_counter
        current_next_local = else_result.next_local_id
        else_bindings = else_result.bindings
        current_next_region = else_result.next_lifetime_region_id
        current_lines = (current_lines) + (else_result.lines)
        else_terminated = else_result.terminated
        exit_label = find_last_label(current_lines, else_label)
        else_exit_label = exit_label
        branch_mutations = retarget_recent_mutations(else_result.mutations, 0, exit_label)
        if not else_terminated  and  len(branch_mutations) > 0:
            materialized_else = materialize_mutation_values_at_exit(branch_mutations, base_locals, current_lines, current_temp)
            current_lines = materialized_else.lines
            current_temp = materialized_else.temp_index
            branch_mutations = materialized_else.mutations
        else_mutations = branch_mutations
        collected_mutations = (collected_mutations) + (else_mutations)
        collected_string_constants = merge_string_constants(collected_string_constants, else_result.string_constants)
        if not else_terminated:
            current_lines = append_string(current_lines, "  br label %" + merge_label)
    terminated = False
    if structure.has_else:
        terminated = then_terminated  and  else_terminated
    if not terminated  or  not structure.has_else:
        current_lines = append_string(current_lines, merge_label + ":")
        if structure.has_else:
            if not then_terminated  or  not else_terminated  and  len(collected_mutations) > 0:
                phi_result = emit_phi_merges_for_if_else(
then_mutations,
else_mutations,
base_locals,
preloaded_locals,
then_label,
else_label,
then_exit_label,
else_exit_label,
then_terminated,
else_terminated,
current_lines,
current_temp
)
                current_lines = phi_result.lines
                current_temp = phi_result.temp_index
        else:
            if not then_terminated  and  len(collected_mutations) > 0:
                phi_result = emit_phi_merges_for_straight_if(
collected_mutations,
base_locals,
preloaded_locals,
branch_label,
then_label,
current_lines,
current_temp
)
                current_lines = phi_result.lines
                current_temp = phi_result.temp_index
    current_locals = base_locals
    merged_bindings = base_bindings
    if not then_terminated:
        merged_bindings = merge_parameter_bindings(merged_bindings, then_bindings)
    if structure.has_else:
        if not else_terminated:
            merged_bindings = merge_parameter_bindings(merged_bindings, else_bindings)
    return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=merged_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=terminated, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=structure.next_index + 1, mutations=collected_mutations, string_constants=collected_string_constants)

def lower_let_instruction(function, instruction, bindings, locals, allocas, lines, temp_index, next_local_id, next_region_id, functions, context, scope_id, scope_depth, current_label):
    diagnostics = []
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_temp = temp_index
    current_bindings = bindings
    ownership = None
    consumption = None
    initializer_span = instruction.value_span
    lifetime_regions = []
    lifetime_releases = []
    current_next_region = next_region_id
    mutations = []
    if initializer_span == None:
        initializer_span = instruction.span
    suspension_diagnostics = detect_suspension_conflicts(instruction.value, current_locals, current_bindings, function.name, initializer_span)
    diagnostics = (diagnostics) + (suspension_diagnostics)
    trimmed_annotation = trim_text(instruction.type_annotation)
    llvm_type = ""
    if len(trimmed_annotation) > 0:
        llvm_type = map_local_type(context, instruction.type_annotation)
        if len(llvm_type) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: unsupported local type for `" + instruction.name + "` in `" + function.name + "`")
    operand = None
    ownership_analysis = analyze_value_ownership(instruction.value, initializer_span, current_locals, current_bindings)
    diagnostics = (diagnostics) + (ownership_analysis.diagnostics)
    ownership = ownership_analysis.ownership
    consumption = ownership_analysis.consumption
    if ownership != None:
        conflict_diagnostics = detect_borrow_conflicts(ownership, current_locals, instruction.name, function.name)
        diagnostics = (diagnostics) + (conflict_diagnostics)
        if ownership.variant == "Borrow":
            base_scope = infer_borrow_base_scope(ownership.base, current_locals, current_bindings, function.name)
            region_id = current_next_region
            current_next_region += 1
            ownership = OwnershipInfo(variant=ownership.variant, base=ownership.base, mutable=ownership.mutable, span=ownership.span, region_id=region_id)
            region = make_lifetime_region_metadata(region_id, instruction.name, ownership, scope_id, scope_depth, base_scope.scope_id, base_scope.scope_depth)
            lifetime_regions = append_lifetime_region(lifetime_regions, region)
        else:
            ownership = OwnershipInfo(variant=ownership.variant, base=ownership.base, mutable=ownership.mutable, span=ownership.span, region_id=-1)
    if consumption != None:
        if consumption.kind == "local":
            current_locals = mark_local_consumed(current_locals, consumption.name)
        else:
            if consumption.kind == "parameter":
                current_bindings = mark_parameter_consumed(current_bindings, consumption.name)
    string_constants = empty_string_constant_set()
    if instruction.value == None  or  len(instruction.value) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: let `" + instruction.name + "` missing initializer in `" + function.name + "`")
    else:
        lowered = lower_expression(instruction.value, current_bindings, current_locals, current_temp, current_lines, functions, context, llvm_type)
        diagnostics = (diagnostics) + (lowered.diagnostics)
        current_lines = lowered.lines
        current_temp = lowered.temp_index
        operand = lowered.operand
        string_constants = lowered.string_constants
    if len(llvm_type) == 0:
        if operand != None:
            llvm_type = operand.llvm_type
    if len(llvm_type) == 0:
        llvm_type = "double"
    interface_info = find_interface_info_by_name(context, instruction.type_annotation)
    if interface_info != None  and  operand != None:
        struct_info = find_struct_info_by_llvm_type(context, operand.llvm_type)
        if struct_info != None:
            vtable = find_vtable_for_struct_interface(context, struct_info.name, interface_info.name)
            if vtable != None:
                struct_ptr_temp = "%t" + number_to_string(current_temp)
                current_temp += 1
                vtable_ptr_temp = "%t" + number_to_string(current_temp)
                current_temp += 1
                data_ptr_temp = "%t" + number_to_string(current_temp)
                current_temp += 1
                with_data_temp = "%t" + number_to_string(current_temp)
                current_temp += 1
                with_vtable_temp = "%t" + number_to_string(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + struct_ptr_temp + " = alloca " + struct_info.llvm_name)
                current_lines = append_string(current_lines, "  store " + operand.llvm_type + " " + operand.value + ", " + operand.llvm_type + "* " + struct_ptr_temp)
                current_lines = append_string(current_lines, "  " + data_ptr_temp + " = bitcast " + struct_info.llvm_name + "* " + struct_ptr_temp + " to i8*")
                current_lines = append_string(current_lines, "  " + vtable_ptr_temp + " = bitcast " + vtable.llvm_type_name + "* " + vtable.llvm_global_name + " to i8*")
                current_lines = append_string(current_lines, "  " + with_data_temp + " = insertvalue " + interface_info.llvm_name + " undef, i8* " + data_ptr_temp + ", 0")
                current_lines = append_string(current_lines, "  " + with_vtable_temp + " = insertvalue " + interface_info.llvm_name + " " + with_data_temp + ", i8* " + vtable_ptr_temp + ", 1")
                operand = LLVMOperand(llvm_type=interface_info.llvm_name, value=with_vtable_temp)
                llvm_type = interface_info.llvm_name
            else:
                diagnostics = append_string(diagnostics, "llvm lowering: struct `" + struct_info.name + "` does not implement interface `" + interface_info.name + "`")
    pointer = format_local_pointer_name(next_local_id)
    current_allocas = append_string(current_allocas, "  " + pointer + " = alloca " + llvm_type)
    stored_value = default_return_literal(llvm_type)
    if operand != None:
        coerced = coerce_operand_to_type(operand, llvm_type, current_temp, current_lines)
        diagnostics = (diagnostics) + (coerced.diagnostics)
        current_lines = coerced.lines
        current_temp = coerced.temp_index
        if coerced.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce initializer for `" + instruction.name + "` to `" + llvm_type + "`")
            current_lines = append_string(current_lines, "  store " + llvm_type + " " + default_return_literal(llvm_type) + ", " + llvm_type + "* " + pointer)
        else:
            stored = coerced.operand
            stored_value = stored.value
            current_lines = append_string(current_lines, "  store " + llvm_type + " " + stored.value + ", " + llvm_type + "* " + pointer)
    else:
        current_lines = append_string(current_lines, "  store " + llvm_type + " " + default_return_literal(llvm_type) + ", " + llvm_type + "* " + pointer)
    current_locals = append_local_binding(current_locals, LocalBinding(name=instruction.name, pointer=pointer, llvm_type=llvm_type, type_annotation=instruction.type_annotation, ownership=ownership, consumed=False, scope_id=scope_id, scope_depth=scope_depth))
    mutation = LocalMutation(name=instruction.name, llvm_type=llvm_type, value_name=stored_value, span=initializer_span, originating_label=current_label)
    mutations = (mutations) + ([mutation])
    return LetLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, diagnostics=diagnostics, next_local_id=next_local_id + 1, lifetime_regions=lifetime_regions, next_region_id=current_next_region, mutations=mutations, string_constants=string_constants)

def lower_expression_statement(function_name, instruction, expression, bindings, locals, temp_index, lines, next_region_id, scope_id, scope_depth, functions, context, current_label):
    suspension_span = None
    if instruction.span != None:
        suspension_span = instruction.span
    diagnostics = detect_suspension_conflicts(expression, locals, bindings, function_name, suspension_span)
    current_lines = lines
    current_temp = temp_index
    current_locals = locals
    current_bindings = bindings
    lifetime_regions = []
    lifetime_releases = []
    current_next_region = next_region_id
    mutations = []
    string_constants = empty_string_constant_set()
    parsed_assignment = parse_assignment_expression(expression)
    if parsed_assignment.success:
        member_parse = parse_member_access(parsed_assignment.target)
        if member_parse.success:
            effective_value = parsed_assignment.value
            if len(parsed_assignment.operator) > 0:
                effective_value = parsed_assignment.target + " " + parsed_assignment.operator + " " + parsed_assignment.value
            lowered = lower_expression(effective_value, current_bindings, current_locals, current_temp, current_lines, functions, context, "")
            diagnostics = (diagnostics) + (lowered.diagnostics)
            string_constants = lowered.string_constants
            current_lines = lowered.lines
            current_temp = lowered.temp_index
            if lowered.operand == None:
                diagnostics = append_string(diagnostics, "llvm lowering: failed to lower assignment value for member `" + parsed_assignment.target + "`")
            else:
                base_result = lower_expression(member_parse.base, current_bindings, current_locals, current_temp, current_lines, functions, context, "")
                diagnostics = (diagnostics) + (base_result.diagnostics)
                current_lines = base_result.lines
                current_temp = base_result.temp_index
                if base_result.operand == None:
                    diagnostics = append_string(diagnostics, "llvm lowering: member access assignment base `" + member_parse.base + "` produced no value")
                else:
                    base_operand = base_result.operand
                    base_pointer_type = base_operand.llvm_type
                    base_pointer_value = base_operand.value
                    base_name = trim_text(member_parse.base)
                    if not ends_with_pointer_suffix(base_pointer_type)  and  is_simple_identifier(base_name):
                        local_pointer = find_local_binding(current_locals, base_name)
                        if local_pointer != None:
                            base_pointer_type = local_pointer.llvm_type + "*"
                            base_pointer_value = local_pointer.pointer
                        else:
                            parameter_pointer = find_parameter_binding(current_bindings, base_name)
                            if parameter_pointer != None  and  ends_with_pointer_suffix(parameter_pointer.llvm_type):
                                base_pointer_type = parameter_pointer.llvm_type
                                base_pointer_value = parameter_pointer.llvm_name
                    if not ends_with_pointer_suffix(base_pointer_type):
                        diagnostics = append_string(diagnostics, "llvm lowering: member access assignment base `" + member_parse.base + "` is not addressable")
                        return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=mutations, string_constants=string_constants)
                    struct_llvm_name = strip_pointer_suffix(base_pointer_type)
                    struct_info = find_struct_info_by_llvm_type(context, struct_llvm_name)
                    if struct_info == None:
                        diagnostics = append_string(diagnostics, "llvm lowering: member access assignment on non-struct type `" + base_result.operand.llvm_type + "`")
                    else:
                        field_index = find_struct_field_index(struct_info, member_parse.field)
                        if field_index < 0:
                            diagnostics = append_string(diagnostics, "llvm lowering: struct `" + struct_info.name + "` has no field `" + member_parse.field + "`")
                        else:
                            field_info = struct_info.fields[field_index]
                            coerced = coerce_operand_to_type(lowered.operand, field_info.llvm_type, current_temp, current_lines)
                            diagnostics = (diagnostics) + (coerced.diagnostics)
                            current_lines = coerced.lines
                            current_temp = coerced.temp_index
                            if coerced.operand != None:
                                field_ptr_temp = format_temp_name(current_temp)
                                current_temp += 1
                                current_lines = append_string(current_lines, "  " + field_ptr_temp + " = getelementptr " + struct_info.llvm_name + ", " + base_pointer_type + " " + base_pointer_value + ", i32 0, i32 " + number_to_string(field_index))
                                current_lines = append_string(current_lines, "  store " + coerced.operand.llvm_type + " " + coerced.operand.value + ", " + coerced.operand.llvm_type + "* " + field_ptr_temp)
            return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=mutations, string_constants=string_constants)
        index_parse = parse_index_expression(parsed_assignment.target)
        if index_parse.success:
            effective_value = parsed_assignment.value
            if len(parsed_assignment.operator) > 0:
                effective_value = parsed_assignment.target + " " + parsed_assignment.operator + " " + parsed_assignment.value
            lowered = lower_expression(effective_value, current_bindings, current_locals, current_temp, current_lines, functions, context, "")
            diagnostics = (diagnostics) + (lowered.diagnostics)
            string_constants = lowered.string_constants
            current_lines = lowered.lines
            current_temp = lowered.temp_index
            if lowered.operand == None:
                diagnostics = append_string(diagnostics, "llvm lowering: failed to lower assignment value for array index `" + parsed_assignment.target + "`")
            else:
                base_result = lower_expression(index_parse.base, current_bindings, current_locals, current_temp, current_lines, functions, context, "")
                diagnostics = (diagnostics) + (base_result.diagnostics)
                current_lines = base_result.lines
                current_temp = base_result.temp_index
                if base_result.operand == None:
                    diagnostics = append_string(diagnostics, "llvm lowering: array index assignment base `" + index_parse.base + "` produced no value")
                else:
                    index_result = lower_expression(index_parse.index, current_bindings, current_locals, current_temp, current_lines, functions, context, "")
                    diagnostics = (diagnostics) + (index_result.diagnostics)
                    current_lines = index_result.lines
                    current_temp = index_result.temp_index
                    if index_result.operand == None:
                        diagnostics = append_string(diagnostics, "llvm lowering: array index `" + index_parse.index + "` produced no value")
                    else:
                        element_type = array_pointer_element_type(base_result.operand.llvm_type)
                        if len(element_type) == 0:
                            diagnostics = append_string(diagnostics, "llvm lowering: cannot determine element type for array assignment `" + base_result.operand.llvm_type + "`")
                        else:
                            coerced = coerce_operand_to_type(lowered.operand, element_type, current_temp, current_lines)
                            diagnostics = (diagnostics) + (coerced.diagnostics)
                            current_lines = coerced.lines
                            current_temp = coerced.temp_index
                            if coerced.operand != None:
                                data_ptr_temp = format_temp_name(current_temp)
                                current_temp += 1
                                elem_ptr_temp = format_temp_name(current_temp)
                                current_temp += 1
                                current_lines = append_string(current_lines, "  " + data_ptr_temp + " = getelementptr " + array_struct_type_for_element(element_type) + ", " + base_result.operand.llvm_type + " " + base_result.operand.value + ", i32 0, i32 0")
                                data_ptr_loaded = format_temp_name(current_temp)
                                current_temp += 1
                                current_lines = append_string(current_lines, "  " + data_ptr_loaded + " = load " + element_type + "*, " + element_type + "** " + data_ptr_temp)
                                current_lines = append_string(current_lines, "  " + elem_ptr_temp + " = getelementptr " + element_type + ", " + element_type + "* " + data_ptr_loaded + ", i64 " + index_result.operand.value)
                                current_lines = append_string(current_lines, "  store " + coerced.operand.llvm_type + " " + coerced.operand.value + ", " + coerced.operand.llvm_type + "* " + elem_ptr_temp)
            return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=mutations, string_constants=string_constants)
        binding = find_local_binding(current_locals, parsed_assignment.target)
        if binding == None:
            diagnostics = append_string(diagnostics, "llvm lowering: assignment to unknown local `" + parsed_assignment.target + "`")
        else:
            effective_value = parsed_assignment.value
            if len(parsed_assignment.operator) > 0:
                effective_value = parsed_assignment.target + " " + parsed_assignment.operator + " " + parsed_assignment.value
            previous_ownership = binding.ownership
            ownership_analysis = analyze_value_ownership(effective_value, instruction.span, current_locals, current_bindings)
            diagnostics = (diagnostics) + (ownership_analysis.diagnostics)
            assignment_ownership = ownership_analysis.ownership
            consumption = ownership_analysis.consumption
            stored_value = default_return_literal(binding.llvm_type)
            lowered = lower_expression(effective_value, current_bindings, current_locals, current_temp, current_lines, functions, context, binding.llvm_type)
            diagnostics = (diagnostics) + (lowered.diagnostics)
            string_constants = lowered.string_constants
            current_lines = lowered.lines
            current_temp = lowered.temp_index
            if lowered.operand == None:
                diagnostics = append_string(diagnostics, "llvm lowering: failed to lower assignment expression for `" + parsed_assignment.target + "`")
            else:
                coerced = coerce_operand_to_type(lowered.operand, binding.llvm_type, current_temp, current_lines)
                diagnostics = (diagnostics) + (coerced.diagnostics)
                current_lines = coerced.lines
                current_temp = coerced.temp_index
                if coerced.operand == None:
                    diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce assignment value for `" + parsed_assignment.target + "`")
                    current_lines = append_string(current_lines, "  store " + binding.llvm_type + " " + default_return_literal(binding.llvm_type) + ", " + binding.llvm_type + "* " + binding.pointer)
                else:
                    operand = coerced.operand
                    stored_value = operand.value
                    current_lines = append_string(current_lines, "  store " + binding.llvm_type + " " + operand.value + ", " + binding.llvm_type + "* " + binding.pointer)
            if consumption != None:
                if consumption.kind == "local":
                    current_locals = mark_local_consumed(current_locals, consumption.name)
                else:
                    if consumption.kind == "parameter":
                        current_bindings = mark_parameter_consumed(current_bindings, consumption.name)
            if previous_ownership != None:
                if previous_ownership.variant == "Borrow":
                    if previous_ownership.region_id >= 0:
                        release_event = LifetimeReleaseEvent(region_id=previous_ownership.region_id, scope_id=scope_id, scope_depth=scope_depth)
                        lifetime_releases = append_lifetime_release_event(lifetime_releases, release_event)
            if assignment_ownership != None:
                if assignment_ownership.variant == "Borrow":
                    region_id = current_next_region
                    current_next_region += 1
                    assignment_ownership = OwnershipInfo(variant=assignment_ownership.variant, base=assignment_ownership.base, mutable=assignment_ownership.mutable, span=assignment_ownership.span, region_id=region_id)
                else:
                    assignment_ownership = OwnershipInfo(variant=assignment_ownership.variant, base=assignment_ownership.base, mutable=assignment_ownership.mutable, span=assignment_ownership.span, region_id=-1)
            current_locals = reset_local_consumption(current_locals, parsed_assignment.target)
            current_locals = update_local_ownership(current_locals, parsed_assignment.target, assignment_ownership)
            if assignment_ownership != None:
                if assignment_ownership.variant == "Borrow":
                    base_scope = infer_borrow_base_scope(assignment_ownership.base, current_locals, current_bindings, function_name)
                    region = make_lifetime_region_metadata(assignment_ownership.region_id, parsed_assignment.target, assignment_ownership, binding.scope_id, binding.scope_depth, base_scope.scope_id, base_scope.scope_depth)
                    lifetime_regions = append_lifetime_region(lifetime_regions, region)
            mutation = LocalMutation(name=parsed_assignment.target, llvm_type=binding.llvm_type, value_name=stored_value, span=instruction.span, originating_label=current_label)
            mutations = (mutations) + ([mutation])
        return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=mutations, string_constants=string_constants)
    ownership_analysis = analyze_value_ownership(expression, instruction.span, current_locals, current_bindings)
    diagnostics = (diagnostics) + (ownership_analysis.diagnostics)
    consumption = ownership_analysis.consumption
    lowered = lower_expression(expression, current_bindings, current_locals, current_temp, current_lines, functions, context, "")
    diagnostics = (diagnostics) + (lowered.diagnostics)
    string_constants = lowered.string_constants
    current_lines = lowered.lines
    current_temp = lowered.temp_index
    if consumption != None:
        if consumption.kind == "local":
            current_locals = mark_local_consumed(current_locals, consumption.name)
        else:
            if consumption.kind == "parameter":
                current_bindings = mark_parameter_consumed(current_bindings, consumption.name)
    return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=mutations, string_constants=string_constants)

def parse_assignment_expression(expression):
    trimmed = trim_text(expression)
    paren_depth = 0
    bracket_depth = 0
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
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
        if paren_depth > 0  or  bracket_depth > 0:
            index += 1
            continue
        if ch == "=":
            previous = ""
            if index > 0:
                previous = trimmed[index - 1]
            next_char = ""
            if index + 1 < len(trimmed):
                next_char = trimmed[index + 1]
            if previous == "+"  or  previous == "-"  or  previous == "*"  or  previous == "/":
                target = trim_text(substring(trimmed, 0, index - 1))
                value = trim_text(substring(trimmed, index + 1, len(trimmed)))
                if len(target) == 0  or  len(value) == 0:
                    return AssignmentParseResult(success=False, target="", value="", operator="")
                return AssignmentParseResult(success=True, target=target, value=value, operator=previous)
            if previous == "="  or  previous == "!"  or  previous == ">"  or  previous == "<":
                index += 1
                continue
            if next_char == "="  or  next_char == ">":
                index += 1
                continue
            target = trim_text(substring(trimmed, 0, index))
            value = trim_text(substring(trimmed, index + 1, len(trimmed)))
            if len(target) == 0  or  len(value) == 0:
                return AssignmentParseResult(success=False, target="", value="", operator="")
            return AssignmentParseResult(success=True, target=target, value=value, operator="")
        index += 1
    return AssignmentParseResult(success=False, target="", value="", operator="")

def parse_inline_let_expression(expression):
    diagnostics = []
    trimmed = trim_text(expression)
    if len(trimmed) < 4:
        diagnostics = append_string(diagnostics, "llvm lowering: malformed let expression `" + expression + "`")
        return InlineLetParseResult(success=False, name="", mutable=False, type_annotation="", initializer=None, diagnostics=diagnostics)
    prefix = substring(trimmed, 0, 4)
    if prefix != "let ":
        return InlineLetParseResult(success=False, name="", mutable=False, type_annotation="", initializer=None, diagnostics=diagnostics)
    remainder = trim_text(substring(trimmed, 4, len(trimmed)))
    is_mutable = False
    if len(remainder) >= 4:
        mut_prefix = substring(remainder, 0, 4)
        if mut_prefix == "mut ":
            is_mutable = True
            remainder = trim_text(substring(remainder, 4, len(remainder)))
    if len(remainder) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: let expression missing binding name in `" + expression + "`")
        return InlineLetParseResult(success=False, name="", mutable=is_mutable, type_annotation="", initializer=None, diagnostics=diagnostics)
    name = ""
    index = 0
    while True:
        if index >= len(remainder):
            break
        ch = remainder[index]
        if ch == " "  or  ch == ":"  or  ch == "-"  or  ch == "=":
            break
        name = name + ch
        index += 1
    name = trim_text(name)
    if len(name) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: let expression missing binding name in `" + expression + "`")
        return InlineLetParseResult(success=False, name="", mutable=is_mutable, type_annotation="", initializer=None, diagnostics=diagnostics)
    tail = trim_text(substring(remainder, index, len(remainder)))
    type_annotation = ""
    initializer = None
    if len(tail) > 0:
        if len(tail) >= 2:
            annotation_prefix = substring(tail, 0, 2)
            if annotation_prefix == "->":
                tail = trim_text(substring(tail, 2, len(tail)))
                assign_index = index_of(tail, "=")
                if assign_index >= 0:
                    type_annotation = trim_text(substring(tail, 0, assign_index))
                    value_text = trim_text(substring(tail, assign_index + 1, len(tail)))
                    if len(value_text) > 0:
                        initializer = value_text
                else:
                    type_annotation = trim_text(tail)
            else:
                if tail[0] == ":":
                    tail = trim_text(substring(tail, 1, len(tail)))
                    assign_index = index_of(tail, "=")
                    if assign_index >= 0:
                        type_annotation = trim_text(substring(tail, 0, assign_index))
                        value_text = trim_text(substring(tail, assign_index + 1, len(tail)))
                        if len(value_text) > 0:
                            initializer = value_text
                    else:
                        type_annotation = trim_text(tail)
                else:
                    if tail[0] == "=":
                        value_text = trim_text(substring(tail, 1, len(tail)))
                        if len(value_text) > 0:
                            initializer = value_text
                    else:
                        value_text = trim_text(tail)
                        if len(value_text) > 0:
                            initializer = value_text
        else:
            if tail[0] == "=":
                value_text = trim_text(substring(tail, 1, len(tail)))
                if len(value_text) > 0:
                    initializer = value_text
            else:
                value_text = trim_text(tail)
                if len(value_text) > 0:
                    initializer = value_text
    if initializer == None:
        diagnostics = append_string(diagnostics, "llvm lowering: let expression missing initializer for `" + name + "`")
        return InlineLetParseResult(success=False, name=name, mutable=is_mutable, type_annotation=type_annotation, initializer=None, diagnostics=diagnostics)
    return InlineLetParseResult(success=True, name=name, mutable=is_mutable, type_annotation=type_annotation, initializer=initializer, diagnostics=diagnostics)

def lower_return_instruction(function, instruction, llvm_return, bindings, locals, temp_index, lines, next_region_id, scope_id, scope_depth, functions, context):
    diagnostics = []
    current_lines = lines
    current_temp = temp_index
    lifetime_regions = []
    lifetime_releases = []
    current_next_region = next_region_id
    if instruction.expression == None  or  len(instruction.expression) == 0:
        if llvm_return == "void":
            current_lines = append_string(current_lines, "  ret void")
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: missing return value in `" + function.name + "`")
            current_lines = append_string(current_lines, "  ret " + llvm_return + " " + default_return_literal(llvm_return))
        empty_constants = empty_string_constant_set()
        return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=locals, bindings=bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=[], string_constants=empty_constants)
    current_locals = locals
    current_bindings = bindings
    suspension_diagnostics = detect_suspension_conflicts(instruction.expression, current_locals, current_bindings, function.name, instruction.span)
    diagnostics = (diagnostics) + (suspension_diagnostics)
    ownership_analysis = analyze_value_ownership(instruction.expression, instruction.span, current_locals, current_bindings)
    diagnostics = (diagnostics) + (ownership_analysis.diagnostics)
    consumption = ownership_analysis.consumption
    lowered = lower_expression(instruction.expression, current_bindings, current_locals, current_temp, current_lines, functions, context, llvm_return)
    diagnostics = (diagnostics) + (lowered.diagnostics)
    current_lines = lowered.lines
    current_temp = lowered.temp_index
    string_constants = lowered.string_constants
    if lowered.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unhandled return expression in `" + function.name + "`")
        current_lines = append_string(current_lines, "  ret " + llvm_return + " " + default_return_literal(llvm_return))
        return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=[], string_constants=string_constants)
    operand = lowered.operand
    if llvm_return == "void":
        diagnostics = append_string(diagnostics, "llvm lowering: void function `" + function.name + "` returned a value")
        current_lines = append_string(current_lines, "  ret void")
        return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=[], string_constants=string_constants)
    coerced = coerce_operand_to_type(operand, llvm_return, current_temp, current_lines)
    diagnostics = (diagnostics) + (coerced.diagnostics)
    current_lines = coerced.lines
    current_temp = coerced.temp_index
    if coerced.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce return expression to `" + llvm_return + "` in `" + function.name + "`")
        current_lines = append_string(current_lines, "  ret " + llvm_return + " " + default_return_literal(llvm_return))
        return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=[], string_constants=string_constants)
    coerced_operand = coerced.operand
    if coerced_operand.llvm_type == "i8*":
        current_lines = append_string(current_lines, "  call void @sailfin_runtime_mark_persistent(i8* " + coerced_operand.value + ")")
    current_lines = append_string(current_lines, "  ret " + coerced_operand.llvm_type + " " + coerced_operand.value)
    if consumption != None:
        if consumption.kind == "local":
            current_locals = mark_local_consumed(current_locals, consumption.name)
        else:
            if consumption.kind == "parameter":
                current_bindings = mark_parameter_consumed(current_bindings, consumption.name)
    return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=[], string_constants=string_constants)

def prepare_parameters(function, context):
    signature = []
    bindings = []
    diagnostics = []
    index = 0
    while True:
        if index >= len(function.parameters):
            break
        parameter = function.parameters[index]
        llvm_type = map_parameter_type(context, parameter.type_annotation)
        if len(parameter.type_annotation) == 0  and  parameter.name == "self"  and  index == 0:
            double_colon_pos = find_last_index_of_char(function.name, ":")
            if double_colon_pos > 0  and  substring(function.name, double_colon_pos - 1, double_colon_pos + 1) == "::":
                struct_name = substring(function.name, 0, double_colon_pos - 1)
                struct_type = map_struct_type_annotation(context, struct_name)
                if len(struct_type) > 0:
                    llvm_type = struct_type + "*"
        if len(parameter.type_annotation) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: parameter `" + parameter.name + "` missing type annotation; defaulting to `" + llvm_type + "`")
        sanitized = sanitize_symbol(parameter.name)
        llvm_name = "%" + sanitized
        signature = append_string(signature, llvm_type + " " + llvm_name)
        bindings = append_parameter_binding(bindings, ParameterBinding(name=parameter.name, llvm_name=llvm_name, llvm_type=llvm_type, type_annotation=parameter.type_annotation, consumed=False, span=parameter.span))
        index += 1
    return ParameterPreparation(signature=signature, bindings=bindings, diagnostics=diagnostics)

def map_struct_type_annotation(context, annotation):
    info = find_struct_info_by_name(context, annotation)
    if info != None:
        return info.llvm_name
    return ""

def map_enum_type_annotation(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    index = 0
    while True:
        if index >= len(context.enums):
            break
        enum_info = context.enums[index]
        if enum_info.name == trimmed:
            return enum_info.llvm_name
        index += 1
    return ""

def map_interface_type_annotation(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    interface_info = find_interface_info_by_name(context, trimmed)
    if interface_info != None:
        return interface_info.llvm_name
    return ""

def map_primitive_type(context, annotation):
    if annotation == "number":
        return "double"
    if annotation == "boolean"  or  annotation == "bool":
        return "i1"
    if annotation == "int"  or  annotation == "i64":
        return "i64"
    if annotation == "i32":
        return "i32"
    struct_type = map_struct_type_annotation(context, annotation)
    if len(struct_type) > 0:
        return struct_type
    enum_type = map_enum_type_annotation(context, annotation)
    if len(enum_type) > 0:
        return enum_type
    interface_type = map_interface_type_annotation(context, annotation)
    if len(interface_type) > 0:
        return interface_type
    if annotation == "string":
        return "i8*"
    return ""

def map_optional_type(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    if trimmed[len(trimmed) - 1] != "?":
        return ""
    inner_annotation = trim_text(substring(trimmed, 0, len(trimmed) - 1))
    if len(inner_annotation) == 0:
        return ""
    struct_type = map_struct_type_annotation(context, inner_annotation)
    if len(struct_type) > 0:
        return struct_type + "*"
    enum_type = map_enum_type_annotation(context, inner_annotation)
    if len(enum_type) > 0:
        return enum_type + "*"
    interface_type = map_interface_type_annotation(context, inner_annotation)
    if len(interface_type) > 0:
        return interface_type + "*"
    inner_type = map_type_annotation(inner_annotation)
    if len(inner_type) == 0  or  inner_type == "void":
        return "i8*"
    if inner_type[len(inner_type) - 1] == "*":
        return inner_type
    return inner_type + "*"

def map_reference_inner_type(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    nested_reference = map_reference_type(context, trimmed)
    if len(nested_reference) > 0:
        return nested_reference
    array_type = map_array_pointer_type(context, trimmed)
    if len(array_type) > 0:
        return array_type
    return map_primitive_type(context, trimmed)

def map_reference_type(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    if not starts_with(trimmed, "&"):
        return ""
    if starts_with(trimmed, "&&"):
        return ""
    remainder = trim_text(substring(trimmed, 1, len(trimmed)))
    if starts_with(remainder, "mut"):
        after_mut = substring(remainder, 3, len(remainder))
        remainder = trim_text(after_mut)
    if len(remainder) == 0:
        return ""
    if remainder[0] == "("  and  remainder[len(remainder) - 1] == ")":
        remainder = trim_text(substring(remainder, 1, len(remainder) - 1))
    inner_type = map_reference_inner_type(context, remainder)
    if len(inner_type) == 0:
        return ""
    return inner_type + "*"

def map_array_pointer_type(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) < 3:
        return ""
    suffix = substring(trimmed, len(trimmed) - 2, len(trimmed))
    if suffix != "[]":
        return ""
    element_annotation = trim_text(substring(trimmed, 0, len(trimmed) - 2))
    element_type = map_primitive_type(context, element_annotation)
    if len(element_type) == 0:
        element_type = "i8*"
    return "{ " + element_type + "*, i64 }*"

def array_struct_type_for_element(element_type):
    return "{ " + element_type + "*, i64 }"

def array_pointer_element_type(llvm_type):
    trimmed = trim_text(llvm_type)
    if len(trimmed) == 0:
        return ""
    if trimmed[len(trimmed) - 1] != "*":
        return ""
    without_pointer = trim_text(substring(trimmed, 0, len(trimmed) - 1))
    if len(without_pointer) < 2:
        return ""
    if without_pointer[0] != "{":
        return ""
    if without_pointer[len(without_pointer) - 1] != "}":
        return ""
    inner = trim_text(substring(without_pointer, 1, len(without_pointer) - 1))
    if len(inner) == 0:
        return ""
    comma_index = index_of(inner, ",")
    if comma_index < 0:
        return ""
    first_segment = trim_text(substring(inner, 0, comma_index))
    if len(first_segment) == 0:
        return ""
    if first_segment[len(first_segment) - 1] != "*":
        return ""
    element = trim_text(substring(first_segment, 0, len(first_segment) - 1))
    if len(element) == 0:
        return ""
    return element

def unwrap_move_wrapper(annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return trimmed
    if starts_with(trimmed, "Affine<")  or  starts_with(trimmed, "Linear<"):
        open_index = index_of(trimmed, "<")
        if open_index >= 0:
            if trimmed[len(trimmed) - 1] == ">":
                inner = substring(trimmed, open_index + 1, len(trimmed) - 1)
                return unwrap_move_wrapper(trim_text(inner))
    return trimmed

def contains_keyword_outside_strings(value, keyword):
    if len(value) == 0:
        return False
    index = 0
    in_single = False
    in_double = False
    escape = False
    while True:
        if index >= len(value):
            break
        ch = value[index]
        if in_single:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "'":
                        in_single = False
            index += 1
            continue
        if in_double:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "\"":
                        in_double = False
            index += 1
            continue
        if ch == "'":
            in_single = True
            index += 1
            continue
        if ch == "\"":
            in_double = True
            index += 1
            continue
        if ch == keyword[0]:
            if index > 0:
                previous = value[index - 1]
                if is_identifier_part_char(previous):
                    index += 1
                    continue
            if matches_keyword(value, index, keyword):
                return True
        index += 1
    return False

def find_suspension_keyword(expression):
    if contains_keyword_outside_strings(expression, "await"):
        return "await"
    if contains_keyword_outside_strings(expression, "yield"):
        return "yield"
    return ""

def is_mutable_borrow_annotation(annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return False
    normalized = unwrap_move_wrapper(trimmed)
    if len(normalized) == 0:
        return False
    if normalized[0] != "&":
        return False
    remainder = trim_text(substring(normalized, 1, len(normalized)))
    if len(remainder) == 0:
        return False
    if starts_with(remainder, "mut"):
        return True
    return False

def collect_suspension_conflicts(keyword, locals, bindings, function_name, suspension_span):
    diagnostics = []
    index = 0
    while True:
        if index >= len(locals):
            break
        local = locals[index]
        if not local.consumed  and  local.ownership != None:
            details = local.ownership
            if details.variant == "Borrow"  and  details.mutable:
                base_name = normalise_borrow_base(details.base)
                location = format_suspension_location(keyword, details.span, suspension_span)
                diagnostics = append_string(diagnostics, "llvm lowering: " + keyword + " suspends while mutable borrow `" + local.name + "` of `" + base_name + "` remains active in `" + function_name + "`" + location)
        index += 1
    parameter_index = 0
    while True:
        if parameter_index >= len(bindings):
            break
        binding = bindings[parameter_index]
        if not binding.consumed:
            if is_mutable_borrow_annotation(binding.type_annotation):
                location = format_suspension_location(keyword, binding.span, suspension_span)
                diagnostics = append_string(diagnostics, "llvm lowering: " + keyword + " suspends while mutable borrow parameter `" + binding.name + "` remains active in `" + function_name + "`" + location)
        parameter_index += 1
    return diagnostics

def normalise_borrow_base(raw_base):
    trimmed = trim_text(raw_base)
    while True:
        if len(trimmed) == 0:
            break
        if trimmed[0] == "*":
            trimmed = trim_text(substring(trimmed, 1, len(trimmed)))
            continue
        break
    if len(trimmed) >= 2:
        if trimmed[0] == "(":
            if trimmed[len(trimmed) - 1] == ")":
                inner = trim_text(substring(trimmed, 1, len(trimmed) - 1))
                if len(inner) > 0:
                    return inner
    return trimmed

def detect_suspension_conflicts(expression, locals, bindings, function_name, suspension_span):
    if expression == None:
        return []
    trimmed = trim_text(expression)
    if len(trimmed) == 0:
        return []
    keyword = find_suspension_keyword(trimmed)
    if len(keyword) == 0:
        return []
    return collect_suspension_conflicts(keyword, locals, bindings, function_name, suspension_span)

def map_return_type(context, return_type):
    trimmed = trim_text(return_type)
    if len(trimmed) == 0  or  trimmed == "void":
        return "void"
    normalized = unwrap_move_wrapper(trimmed)
    optional_type = map_optional_type(context, normalized)
    if len(optional_type) > 0:
        return optional_type
    reference_type = map_reference_type(context, normalized)
    if len(reference_type) > 0:
        return reference_type
    array_type = map_array_pointer_type(context, normalized)
    if len(array_type) > 0:
        return array_type
    primitive_type = map_primitive_type(context, normalized)
    if len(primitive_type) > 0:
        return primitive_type
    return "i8*"

def map_parameter_type(context, parameter_type):
    trimmed = trim_text(parameter_type)
    if len(trimmed) == 0:
        return "double"
    normalized = unwrap_move_wrapper(trimmed)
    optional_type = map_optional_type(context, normalized)
    if len(optional_type) > 0:
        return optional_type
    reference_type = map_reference_type(context, normalized)
    if len(reference_type) > 0:
        return reference_type
    array_type = map_array_pointer_type(context, normalized)
    if len(array_type) > 0:
        return array_type
    primitive_type = map_primitive_type(context, normalized)
    if len(primitive_type) > 0:
        return primitive_type
    return "i8*"

def map_local_type(context, type_annotation):
    trimmed = trim_text(type_annotation)
    if len(trimmed) == 0:
        return "double"
    normalized = unwrap_move_wrapper(trimmed)
    optional_type = map_optional_type(context, normalized)
    if len(optional_type) > 0:
        return optional_type
    reference_type = map_reference_type(context, normalized)
    if len(reference_type) > 0:
        return reference_type
    array_type = map_array_pointer_type(context, normalized)
    if len(array_type) > 0:
        return array_type
    primitive_type = map_primitive_type(context, normalized)
    if len(primitive_type) > 0:
        return primitive_type
    return "i8*"

def find_parameter_binding(bindings, name):
    index = 0
    while True:
        if index >= len(bindings):
            break
        binding = bindings[index]
        if binding.name == name:
            return binding
        index += 1
    return None

def mark_parameter_consumed(bindings, name):
    result = []
    index = 0
    while True:
        if index >= len(bindings):
            break
        binding = bindings[index]
        if binding.name == name:
            updated = ParameterBinding(name=binding.name, llvm_name=binding.llvm_name, llvm_type=binding.llvm_type, type_annotation=binding.type_annotation, consumed=True, span=binding.span)
            result = (result) + ([updated])
        else:
            result = (result) + ([binding])
        index += 1
    return result

def mark_local_consumed(locals, name):
    result = []
    index = 0
    while True:
        if index >= len(locals):
            break
        entry = locals[index]
        if entry.name == name:
            updated = LocalBinding(name=entry.name, pointer=entry.pointer, llvm_type=entry.llvm_type, type_annotation=entry.type_annotation, ownership=entry.ownership, consumed=True, scope_id=entry.scope_id, scope_depth=entry.scope_depth)
            result = (result) + ([updated])
        else:
            result = (result) + ([entry])
        index += 1
    return result

def reset_local_consumption(locals, name):
    result = []
    index = 0
    while True:
        if index >= len(locals):
            break
        entry = locals[index]
        if entry.name == name:
            updated = LocalBinding(name=entry.name, pointer=entry.pointer, llvm_type=entry.llvm_type, type_annotation=entry.type_annotation, ownership=entry.ownership, consumed=False, scope_id=entry.scope_id, scope_depth=entry.scope_depth)
            result = (result) + ([updated])
        else:
            result = (result) + ([entry])
        index += 1
    return result

def update_local_ownership(locals, name, ownership):
    result = []
    index = 0
    while True:
        if index >= len(locals):
            break
        entry = locals[index]
        if entry.name == name:
            updated = LocalBinding(name=entry.name, pointer=entry.pointer, llvm_type=entry.llvm_type, type_annotation=entry.type_annotation, ownership=ownership, consumed=entry.consumed, scope_id=entry.scope_id, scope_depth=entry.scope_depth)
            result = (result) + ([updated])
        else:
            result = (result) + ([entry])
        index += 1
    return result

def lower_logical_not_with_operand(operand, temp_index, lines, diagnostics, string_constants):
    coerced = coerce_operand_to_type(operand, "i1", temp_index, lines)
    current_diagnostics = (diagnostics) + (coerced.diagnostics)
    current_lines = coerced.lines
    current_temp = coerced.temp_index
    if coerced.operand != None:
        bool_operand = coerced.operand
        result_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + result_temp + " = xor i1 " + bool_operand.value + ", 1")
        current_temp += 1
        result_operand = LLVMOperand(llvm_type="i1", value=result_temp)
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=result_operand, diagnostics=current_diagnostics, string_constants=string_constants)
    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=current_diagnostics, string_constants=string_constants)

def lower_logical_not_result(result, base_diagnostics):
    combined = (base_diagnostics) + (result.diagnostics)
    if result.operand == None:
        return ExpressionResult(lines=result.lines, temp_index=result.temp_index, operand=None, diagnostics=combined, string_constants=result.string_constants)
    return lower_logical_not_with_operand(result.operand, result.temp_index, result.lines, combined, result.string_constants)

def lower_expression(expression, bindings, locals, temp_index, lines, functions, context, expected_type):
    trimmed = trim_text(expression)
    diagnostics = []
    empty_constants = empty_string_constant_set()
    if len(trimmed) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: empty expression encountered")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    stripped = strip_enclosing_parentheses(trimmed)
    if stripped != trimmed:
        return lower_expression(stripped, bindings, locals, temp_index, lines, functions, context, expected_type)
    ternary_parse = parse_ternary_expression(stripped)
    if ternary_parse.success:
        return lower_ternary_expression(ternary_parse, bindings, locals, temp_index, lines, functions, context, expected_type)
    borrow_parse = parse_borrow_expression(stripped)
    if borrow_parse.recognized:
        return lower_borrow_expression(borrow_parse, bindings, locals, temp_index, lines)
    if len(stripped) > 0:
        first_ch = stripped[0]
        if first_ch == "!":
            operand_text = trim_text(substring(stripped, 1, len(stripped)))
            if len(operand_text) > 0:
                lowered_operand = lower_expression(operand_text, bindings, locals, temp_index, lines, functions, context, "")
                return lower_logical_not_result(lowered_operand, diagnostics)
    logical = find_logical_operator(stripped)
    if logical.success:
        if logical.symbol == "&&":
            return lower_logical_and(stripped, logical, bindings, locals, temp_index, lines, functions, context)
        if logical.symbol == "||":
            return lower_logical_or(stripped, logical, bindings, locals, temp_index, lines, functions, context)
    comparison = find_comparison_operator(stripped)
    if comparison.success:
        return lower_comparison_operation(stripped, comparison, bindings, locals, temp_index, lines, functions, context)
    additive = find_top_level_operator(stripped, "+-")
    if additive.success:
        return lower_binary_operation(stripped, additive, bindings, locals, temp_index, lines, functions, context)
    multiplicative = find_top_level_operator(stripped, "*/%")
    if multiplicative.success:
        return lower_binary_operation(stripped, multiplicative, bindings, locals, temp_index, lines, functions, context)
    call_index = find_call_site(stripped)
    if call_index >= 0  and  stripped[len(stripped) - 1] == ")":
        target = trim_text(substring(stripped, 0, call_index))
        arguments_text = substring(stripped, call_index + 1, len(stripped) - 1)
        argument_entries = split_call_arguments(arguments_text)
        return lower_call_expression(target, argument_entries, bindings, locals, temp_index, lines, functions, context)
    if len(stripped) >= 2:
        first = stripped[0]
        last = stripped[len(stripped) - 1]
        if first == "["  and  last == "]":
            return lower_array_literal(stripped, bindings, locals, temp_index, lines, functions, context, expected_type)
    enum_parse = parse_enum_literal(stripped)
    if enum_parse.recognized  and  enum_parse.success:
        enum_info = resolve_enum_info_for_literal(context, enum_parse.enum_name)
        if enum_info != None:
            lowered_enum = lower_enum_literal(enum_parse, bindings, locals, temp_index, lines, functions, context, expected_type)
            combined = (diagnostics) + (lowered_enum.diagnostics)
            return ExpressionResult(lines=lowered_enum.lines, temp_index=lowered_enum.temp_index, operand=lowered_enum.operand, diagnostics=combined, string_constants=lowered_enum.string_constants)
    struct_parse = parse_struct_literal(stripped)
    if struct_parse.recognized:
        if not struct_parse.success:
            diagnostics = (diagnostics) + (struct_parse.diagnostics)
            return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
        lowered_struct = lower_struct_literal(struct_parse, bindings, locals, temp_index, lines, functions, context, expected_type)
        combined = (diagnostics) + (lowered_struct.diagnostics)
        return ExpressionResult(lines=lowered_struct.lines, temp_index=lowered_struct.temp_index, operand=lowered_struct.operand, diagnostics=combined, string_constants=lowered_struct.string_constants)
    index_parse = parse_index_expression(stripped)
    if index_parse.success:
        return lower_index_expression(index_parse, bindings, locals, temp_index, lines, functions, context)
    member_parse = parse_member_access(stripped)
    if member_parse.success:
        return lower_member_access(member_parse, bindings, locals, temp_index, lines, functions, context, expected_type)
    parameter = find_parameter_binding(bindings, stripped)
    if parameter != None:
        operand = LLVMOperand(llvm_type=parameter.llvm_type, value=parameter.llvm_name)
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics, string_constants=empty_constants)
    local = find_local_binding(locals, stripped)
    if local != None:
        load_result = load_local_operand(local, temp_index, lines)
        diagnostics = (diagnostics) + (load_result.diagnostics)
        return ExpressionResult(lines=load_result.lines, temp_index=load_result.temp_index, operand=load_result.operand, diagnostics=diagnostics, string_constants=empty_constants)
    literal_candidate = trim_text(stripped)
    if literal_candidate == "runtime":
        runtime_result = lower_runtime_global_reference(temp_index, lines)
        combined_diagnostics = (diagnostics) + (runtime_result.diagnostics)
        return ExpressionResult(lines=runtime_result.lines, temp_index=runtime_result.temp_index, operand=runtime_result.operand, diagnostics=combined_diagnostics, string_constants=runtime_result.string_constants)
    if literal_candidate == "fs":
        runtime_result = lower_runtime_global_reference(temp_index, lines)
        diagnostics = (diagnostics) + (runtime_result.diagnostics)
        if runtime_result.operand == None:
            return ExpressionResult(lines=runtime_result.lines, temp_index=runtime_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=runtime_result.string_constants)
        field_result = lower_dynamic_member_access("fs", runtime_result.operand, runtime_result.temp_index, runtime_result.lines, diagnostics, runtime_result.string_constants)
        return ExpressionResult(lines=field_result.lines, temp_index=field_result.temp_index, operand=field_result.operand, diagnostics=field_result.diagnostics, string_constants=field_result.string_constants)
    if is_string_literal(literal_candidate):
        if is_character_literal(literal_candidate):
            char_value = get_character_literal_value(literal_candidate)
            operand = LLVMOperand(llvm_type="i8", value=number_to_string(char_value))
            return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics, string_constants=empty_constants)
        return lower_string_literal(literal_candidate, temp_index, lines)
    if is_boolean_literal(literal_candidate):
        value = "0"
        if matches_case_insensitive(literal_candidate, "true"):
            value = "1"
        operand = LLVMOperand(llvm_type="i1", value=value)
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics, string_constants=empty_constants)
    if is_null_literal(literal_candidate):
        operand = LLVMOperand(llvm_type="i8*", value="null")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics, string_constants=empty_constants)
    if is_integer_literal(literal_candidate):
        operand = LLVMOperand(llvm_type="i64", value=literal_candidate)
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics, string_constants=empty_constants)
    if is_number_literal(literal_candidate):
        normalised = normalise_number_literal(literal_candidate)
        operand = LLVMOperand(llvm_type="double", value=normalised)
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics, string_constants=empty_constants)
    diagnostics = append_string(diagnostics, "llvm lowering: unsupported expression `" + literal_candidate + "`")
    return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)

def parse_borrow_expression(text):
    trimmed = trim_text(text)
    diagnostics = []
    if len(trimmed) == 0:
        return BorrowParseResult(recognized=False, success=False, target="", mutable=False, diagnostics=diagnostics)
    if starts_with(trimmed, "borrow"):
        remainder = trim_text(substring(trimmed, 6, len(trimmed)))
        if len(remainder) == 0:
            issue = append_string(diagnostics, "llvm lowering: borrow expression missing target")
            return BorrowParseResult(recognized=True, success=False, target="", mutable=False, diagnostics=issue)
        mutable_flag = False
        if starts_with(remainder, "mut"):
            after_mut = substring(remainder, 3, len(remainder))
            mutable_flag = True
            remainder = trim_text(after_mut)
        if len(remainder) > 0  and  remainder[0] == "(":
            argument_parse = extract_borrow_argument(remainder)
            messages = (diagnostics) + (argument_parse.diagnostics)
            if not argument_parse.success:
                return BorrowParseResult(recognized=True, success=False, target="", mutable=mutable_flag, diagnostics=messages)
            argument_text = argument_parse.argument
            if starts_with(argument_text, "mut"):
                after_mut = substring(argument_text, 3, len(argument_text))
                trimmed_after_mut = trim_text(after_mut)
                if len(trimmed_after_mut) > 0:
                    mutable_flag = True
                    argument_text = trimmed_after_mut
            if len(argument_text) == 0:
                messages = append_string(messages, "llvm lowering: borrow expression missing target")
                return BorrowParseResult(recognized=True, success=False, target="", mutable=mutable_flag, diagnostics=messages)
            if not is_valid_borrow_target(argument_text):
                return BorrowParseResult(recognized=False, success=False, target="", mutable=mutable_flag, diagnostics=diagnostics)
            return BorrowParseResult(recognized=True, success=True, target=argument_text, mutable=mutable_flag, diagnostics=messages)
        simple_parse = extract_simple_borrow_target(remainder)
        if not simple_parse.success:
            return BorrowParseResult(recognized=False, success=False, target="", mutable=mutable_flag, diagnostics=diagnostics)
        if not is_valid_borrow_target(simple_parse.argument):
            return BorrowParseResult(recognized=False, success=False, target="", mutable=mutable_flag, diagnostics=diagnostics)
        return BorrowParseResult(recognized=True, success=True, target=simple_parse.argument, mutable=mutable_flag, diagnostics=diagnostics)
    if not starts_with(trimmed, "&"):
        return BorrowParseResult(recognized=False, success=False, target="", mutable=False, diagnostics=diagnostics)
    if starts_with(trimmed, "&&"):
        return BorrowParseResult(recognized=False, success=False, target="", mutable=False, diagnostics=diagnostics)
    remainder = trim_text(substring(trimmed, 1, len(trimmed)))
    mutable_flag = False
    if starts_with(remainder, "mut"):
        mutable_flag = True
        after_mut = substring(remainder, 3, len(remainder))
        remainder = trim_text(after_mut)
    if len(remainder) == 0:
        issue = append_string(diagnostics, "llvm lowering: borrow expression missing target")
        return BorrowParseResult(recognized=True, success=False, target="", mutable=mutable_flag, diagnostics=issue)
    return BorrowParseResult(recognized=True, success=True, target=trim_text(remainder), mutable=mutable_flag, diagnostics=diagnostics)

def extract_borrow_argument(text):
    diagnostics = []
    depth = 0
    index = 0
    closing_index = -1
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if ch == "(":
            depth += 1
            index += 1
            continue
        if ch == ")":
            if depth == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: borrow expression missing opening `(`")
                return BorrowArgumentParse(success=False, argument="", diagnostics=diagnostics)
            depth -= 1
            current_index = index
            index += 1
            if depth == 0:
                closing_index = current_index
                break
            continue
        index += 1
    if closing_index < 0:
        diagnostics = append_string(diagnostics, "llvm lowering: borrow expression missing closing `)`")
        return BorrowArgumentParse(success=False, argument="", diagnostics=diagnostics)
    inner = substring(text, 1, closing_index)
    remainder = trim_text(substring(text, closing_index + 1, len(text)))
    if len(remainder) > 0:
        diagnostics = append_string(diagnostics, "llvm lowering: borrow expression trailing content `" + remainder + "`")
        return BorrowArgumentParse(success=False, argument="", diagnostics=diagnostics)
    return BorrowArgumentParse(success=True, argument=trim_text(inner), diagnostics=diagnostics)

def extract_simple_borrow_target(text):
    diagnostics = []
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: borrow expression missing target")
        return BorrowArgumentParse(success=False, argument="", diagnostics=diagnostics)
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if is_effect_delimiter(ch):
            break
        index += 1
    target = trim_text(substring(trimmed, 0, index))
    if len(target) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: borrow expression missing target")
        return BorrowArgumentParse(success=False, argument="", diagnostics=diagnostics)
    remainder = trim_text(substring(trimmed, index, len(trimmed)))
    if len(remainder) > 0:
        diagnostics = append_string(diagnostics, "llvm lowering: borrow expression trailing content `" + remainder + "`")
        return BorrowArgumentParse(success=False, argument=target, diagnostics=diagnostics)
    return BorrowArgumentParse(success=True, argument=target, diagnostics=diagnostics)

def is_valid_borrow_target(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return False
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if ch == ".":
            index += 1
            continue
        if index == 0:
            if not is_identifier_start_char(ch):
                return False
        else:
            if not is_identifier_part_char(ch):
                return False
        index += 1
    return True

def parse_ternary_expression(text):
    diagnostics = []
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return TernaryParseResult(success=False, condition="", true_value="", false_value="", diagnostics=diagnostics)
    depth = 0
    question_index = -1
    colon_index = -1
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if ch == "("  or  ch == "["  or  ch == "{":
            depth += 1
            index += 1
            continue
        if ch == ")"  or  ch == "]"  or  ch == "}":
            depth -= 1
            index += 1
            continue
        if depth == 0:
            if ch == "?"  and  question_index < 0:
                question_index = index
                index += 1
                continue
            if ch == ":"  and  question_index >= 0  and  colon_index < 0:
                colon_index = index
                index += 1
                continue
        index += 1
    if question_index < 0  or  colon_index < 0:
        return TernaryParseResult(success=False, condition="", true_value="", false_value="", diagnostics=diagnostics)
    if question_index >= colon_index:
        diagnostics = append_string(diagnostics, "llvm lowering: malformed ternary expression - `:` before `?`")
        return TernaryParseResult(success=False, condition="", true_value="", false_value="", diagnostics=diagnostics)
    condition = trim_text(substring(trimmed, 0, question_index))
    true_value = trim_text(substring(trimmed, question_index + 1, colon_index))
    false_value = trim_text(substring(trimmed, colon_index + 1, len(trimmed)))
    if len(condition) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: ternary expression missing condition")
        return TernaryParseResult(success=False, condition="", true_value="", false_value="", diagnostics=diagnostics)
    if len(true_value) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: ternary expression missing true branch value")
        return TernaryParseResult(success=False, condition="", true_value="", false_value="", diagnostics=diagnostics)
    if len(false_value) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: ternary expression missing false branch value")
        return TernaryParseResult(success=False, condition="", true_value="", false_value="", diagnostics=diagnostics)
    return TernaryParseResult(success=True, condition=condition, true_value=true_value, false_value=false_value, diagnostics=diagnostics)

def analyze_value_ownership(initializer, span, locals, bindings):
    if initializer == None:
        return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=[])
    trimmed = trim_text(initializer)
    if len(trimmed) == 0:
        return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=[])
    parse = parse_borrow_expression(trimmed)
    diagnostics = parse.diagnostics
    if parse.recognized:
        if not parse.success:
            return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=diagnostics)
        resolved_base = resolve_borrow_base(parse.target, locals)
        if len(resolved_base) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: borrow expression missing target")
            return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=diagnostics)
        ownership = OwnershipInfo(variant="Borrow", base=resolved_base, mutable=parse.mutable, span=span, region_id=-1)
        return OwnershipAnalysis(ownership=ownership, consumption=None, diagnostics=diagnostics)
    if is_simple_identifier(trimmed):
        name = trimmed
        local = find_local_binding(locals, name)
        if local != None:
            if local.consumed:
                diagnostics = append_string(diagnostics, format_use_after_move_message(name, span))
                return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=diagnostics)
            if is_copy_type(local.type_annotation, local.llvm_type):
                return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=diagnostics)
            consumption = OwnershipConsumption(kind="local", name=name)
            return OwnershipAnalysis(ownership=None, consumption=consumption, diagnostics=diagnostics)
        parameter = find_parameter_binding(bindings, name)
        if parameter != None:
            if parameter.consumed:
                diagnostics = append_string(diagnostics, format_use_after_move_message(name, span))
                return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=diagnostics)
            if is_copy_type(parameter.type_annotation, parameter.llvm_type):
                return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=diagnostics)
            consumption = OwnershipConsumption(kind="parameter", name=name)
            return OwnershipAnalysis(ownership=None, consumption=consumption, diagnostics=diagnostics)
    return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=diagnostics)

def format_use_after_move_message(name, span):
    if span == None:
        return "llvm lowering: use-after-move of `" + name + "`"
    return "llvm lowering: use-after-move of `" + name + "` at " + format_span_location(span)

def format_span_location(span):
    start = number_to_string(span.start_line) + ":" + number_to_string(span.start_column)
    end = number_to_string(span.end_line) + ":" + number_to_string(span.end_column)
    return start + "-" + end

def format_suspension_location(keyword, borrow_span, suspension_span):
    has_segment = False
    combined = ""
    if borrow_span != None:
        combined = "borrow at " + format_span_location(borrow_span)
        has_segment = True
    if suspension_span != None:
        label = keyword
        if len(label) == 0:
            label = "suspend"
        segment = label + " at " + format_span_location(suspension_span)
        if has_segment:
            combined = combined + "; " + segment
        else:
            combined = segment
            has_segment = True
    if not has_segment:
        return ""
    return " (" + combined + ")"

def detect_borrow_conflicts(ownership, locals, binding_name, function_name):
    diagnostics = []
    if ownership == None:
        return diagnostics
    if ownership.variant != "Borrow":
        return diagnostics
    base = trim_text(ownership.base)
    index = 0
    while True:
        if index >= len(locals):
            break
        existing = locals[index]
        if existing.ownership != None:
            details = existing.ownership
            if details.variant == "Borrow":
                existing_base = trim_text(details.base)
                if existing_base == base:
                    if ownership.mutable:
                        if details.mutable:
                            diagnostics = append_string(diagnostics, "llvm lowering: mutable borrow `" + binding_name + "` conflicts with active mutable borrow `" + existing.name + "` of `" + base + "` in `" + function_name + "`")
                        else:
                            diagnostics = append_string(diagnostics, "llvm lowering: mutable borrow `" + binding_name + "` conflicts with active shared borrow `" + existing.name + "` of `" + base + "` in `" + function_name + "`")
                    else:
                        if details.mutable:
                            diagnostics = append_string(diagnostics, "llvm lowering: shared borrow `" + binding_name + "` conflicts with active mutable borrow `" + existing.name + "` of `" + base + "` in `" + function_name + "`")
        index += 1
    return diagnostics

def resolve_borrow_base(target, locals):
    return resolve_borrow_base_inner(trim_text(target), locals, 0)

def resolve_borrow_base_inner(target, locals, depth):
    trimmed = trim_text(target)
    if len(trimmed) == 0:
        return trimmed
    if depth >= 8:
        return trimmed
    if not is_simple_identifier(trimmed):
        return trimmed
    binding = find_local_binding(locals, trimmed)
    if binding == None:
        return trimmed
    if binding.ownership == None:
        return trimmed
    details = binding.ownership
    if details.variant != "Borrow":
        return trimmed
    return resolve_borrow_base_inner(details.base, locals, depth + 1)

def lower_borrow_expression(parse, bindings, locals, temp_index, lines):
    diagnostics = parse.diagnostics
    empty_constants = empty_string_constant_set()
    if not parse.success:
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    target = strip_enclosing_parentheses(parse.target)
    target = trim_text(target)
    if len(target) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: borrow expression missing target")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    local = find_local_binding(locals, target)
    if local == None:
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    pointer_type = local.llvm_type + "*"
    operand = LLVMOperand(llvm_type=pointer_type, value=local.pointer)
    return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics, string_constants=empty_constants)

def lower_ternary_expression(parse, bindings, locals, temp_index, lines, functions, context, expected_type):
    diagnostics = parse.diagnostics
    string_constants = empty_string_constant_set()
    label_id = number_to_string(temp_index)
    cond_label = "ternary_cond_" + label_id
    then_label = "ternary_then_" + label_id
    else_label = "ternary_else_" + label_id
    merge_label = "ternary_merge_" + label_id
    label_temp_offset = temp_index + 1
    cond_result = lower_expression(parse.condition, bindings, locals, label_temp_offset, lines, functions, context, "")
    diagnostics = (diagnostics) + (cond_result.diagnostics)
    string_constants = cond_result.string_constants
    if cond_result.operand == None:
        return ExpressionResult(lines=cond_result.lines, temp_index=cond_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    cond_bool = coerce_operand_to_type(cond_result.operand, "i1", cond_result.temp_index, cond_result.lines)
    diagnostics = (diagnostics) + (cond_bool.diagnostics)
    if cond_bool.operand == None:
        return ExpressionResult(lines=cond_bool.lines, temp_index=cond_bool.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    current_lines = cond_bool.lines
    current_lines = append_string(current_lines, "  br label %" + cond_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, cond_label + ":")
    current_lines = append_string(current_lines, "  br i1 " + cond_bool.operand.value + ", label %" + then_label + ", label %" + else_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, then_label + ":")
    then_result = lower_expression(parse.true_value, bindings, locals, cond_bool.temp_index, current_lines, functions, context, expected_type)
    diagnostics = (diagnostics) + (then_result.diagnostics)
    string_constants = merge_string_constants(string_constants, then_result.string_constants)
    if then_result.operand == None:
        return ExpressionResult(lines=then_result.lines, temp_index=then_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    then_end_label = "ternary_then_end_" + label_id
    current_lines = then_result.lines
    current_lines = append_string(current_lines, "  br label %" + then_end_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, then_end_label + ":")
    current_lines = append_string(current_lines, "  br label %" + merge_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, else_label + ":")
    else_result = lower_expression(parse.false_value, bindings, locals, then_result.temp_index, current_lines, functions, context, expected_type)
    diagnostics = (diagnostics) + (else_result.diagnostics)
    string_constants = merge_string_constants(string_constants, else_result.string_constants)
    if else_result.operand == None:
        return ExpressionResult(lines=else_result.lines, temp_index=else_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    else_end_label = "ternary_else_end_" + label_id
    current_lines = else_result.lines
    current_lines = append_string(current_lines, "  br label %" + else_end_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, else_end_label + ":")
    current_lines = append_string(current_lines, "  br label %" + merge_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, merge_label + ":")
    if then_result.operand.llvm_type != else_result.operand.llvm_type:
        diagnostics = append_string(diagnostics, "llvm lowering: ternary expression branches have incompatible types: `" + then_result.operand.llvm_type + "` vs `" + else_result.operand.llvm_type + "`")
        return ExpressionResult(lines=current_lines, temp_index=else_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    result_temp = format_temp_name(else_result.temp_index)
    result_type = then_result.operand.llvm_type
    current_lines = append_string(current_lines, "  " + result_temp + " = phi " + result_type + " [ " + then_result.operand.value + ", %" + then_end_label + " ], [ " + else_result.operand.value + ", %" + else_end_label + " ]")
    operand = LLVMOperand(llvm_type=result_type, value=result_temp)
    return ExpressionResult(lines=current_lines, temp_index=else_result.temp_index + 1, operand=operand, diagnostics=diagnostics, string_constants=string_constants)

def lower_binary_operation(expression, match, bindings, locals, temp_index, lines, functions, context):
    left_text = trim_text(substring(expression, 0, match.index))
    right_text = trim_text(substring(expression, match.index + 1, len(expression)))
    diagnostics = []
    if len(left_text) == 0  or  len(right_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: malformed binary expression `" + expression + "`")
        empty_constants = empty_string_constant_set()
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    left_result = lower_expression(left_text, bindings, locals, temp_index, lines, functions, context, "")
    diagnostics = (diagnostics) + (left_result.diagnostics)
    string_constants = left_result.string_constants
    if left_result.operand == None:
        return ExpressionResult(lines=left_result.lines, temp_index=left_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    right_result = lower_expression(right_text, bindings, locals, left_result.temp_index, left_result.lines, functions, context, "")
    diagnostics = (diagnostics) + (right_result.diagnostics)
    string_constants = merge_string_constants(string_constants, right_result.string_constants)
    if right_result.operand == None:
        return ExpressionResult(lines=right_result.lines, temp_index=right_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    harmonised = harmonise_operands(left_result.operand, right_result.operand, right_result.temp_index, right_result.lines)
    diagnostics = (diagnostics) + (harmonised.diagnostics)
    if harmonised.left == None  or  harmonised.right == None:
        return ExpressionResult(lines=harmonised.lines, temp_index=harmonised.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    left_aligned = harmonised.left
    right_aligned = harmonised.right
    if match.symbol == "+"  and  harmonised.result_type == "i8*":
        temp_name = format_temp_name(harmonised.temp_index)
        line = "  " + temp_name + " = call i8* @sailfin_runtime_string_concat(i8* " + left_aligned.value + ", i8* " + right_aligned.value + ")"
        updated_lines = append_string(harmonised.lines, line)
        operand = LLVMOperand(llvm_type="i8*", value=temp_name)
        return ExpressionResult(lines=updated_lines, temp_index=harmonised.temp_index + 1, operand=operand, diagnostics=diagnostics, string_constants=string_constants)
    operation = operation_name_for_symbol(match.symbol, harmonised.result_type)
    temp_name = format_temp_name(harmonised.temp_index)
    line = "  " + temp_name + " = " + operation + " " + harmonised.result_type + " " + left_aligned.value + ", " + right_aligned.value
    updated_lines = append_string(harmonised.lines, line)
    operand = LLVMOperand(llvm_type=harmonised.result_type, value=temp_name)
    return ExpressionResult(lines=updated_lines, temp_index=harmonised.temp_index + 1, operand=operand, diagnostics=diagnostics, string_constants=string_constants)

def lower_comparison_operation(expression, match, bindings, locals, temp_index, lines, functions, context):
    operator_length = len(match.symbol)
    left_text = trim_text(substring(expression, 0, match.index))
    right_text = trim_text(substring(expression, match.index + operator_length, len(expression)))
    diagnostics = []
    if len(left_text) == 0  or  len(right_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: malformed comparison expression `" + expression + "`")
        empty_constants = empty_string_constant_set()
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    left_result = lower_expression(left_text, bindings, locals, temp_index, lines, functions, context, "")
    diagnostics = (diagnostics) + (left_result.diagnostics)
    string_constants = left_result.string_constants
    if left_result.operand == None:
        return ExpressionResult(lines=left_result.lines, temp_index=left_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    right_result = lower_expression(right_text, bindings, locals, left_result.temp_index, left_result.lines, functions, context, "")
    diagnostics = (diagnostics) + (right_result.diagnostics)
    string_constants = merge_string_constants(string_constants, right_result.string_constants)
    if right_result.operand == None:
        return ExpressionResult(lines=right_result.lines, temp_index=right_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    alignment_lines = right_result.lines
    alignment_temp = right_result.temp_index
    left_operand = left_result.operand
    right_operand = right_result.operand
    is_equality = match.symbol == "=="  or  match.symbol == "!="
    if is_equality  and  left_operand != None  and  right_operand != None:
        left_is_char = left_operand.llvm_type == "i8"
        right_is_char = right_operand.llvm_type == "i8"
        left_is_pointer = ends_with_pointer_suffix(left_operand.llvm_type)
        right_is_pointer = ends_with_pointer_suffix(right_operand.llvm_type)
        if left_is_char  and  right_is_pointer:
            coercion = coerce_operand_to_type(right_operand, "i8", alignment_temp, alignment_lines)
            diagnostics = (diagnostics) + (coercion.diagnostics)
            if coercion.operand == None:
                return ExpressionResult(lines=coercion.lines, temp_index=coercion.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
            right_operand = coercion.operand
            alignment_lines = coercion.lines
            alignment_temp = coercion.temp_index
        else:
            if right_is_char  and  left_is_pointer:
                coercion = coerce_operand_to_type(left_operand, "i8", alignment_temp, alignment_lines)
                diagnostics = (diagnostics) + (coercion.diagnostics)
                if coercion.operand == None:
                    return ExpressionResult(lines=coercion.lines, temp_index=coercion.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
                left_operand = coercion.operand
                alignment_lines = coercion.lines
                alignment_temp = coercion.temp_index
    harmonised = harmonise_operands(left_operand, right_operand, alignment_temp, alignment_lines)
    diagnostics = (diagnostics) + (harmonised.diagnostics)
    if harmonised.left == None  or  harmonised.right == None:
        return ExpressionResult(lines=harmonised.lines, temp_index=harmonised.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    comparison = emit_comparison_instruction(match.symbol, harmonised.left, harmonised.right, harmonised.temp_index, harmonised.lines)
    diagnostics = (diagnostics) + (comparison.diagnostics)
    if comparison.operand == None:
        return ExpressionResult(lines=comparison.lines, temp_index=comparison.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    return ExpressionResult(lines=comparison.lines, temp_index=comparison.temp_index, operand=comparison.operand, diagnostics=diagnostics, string_constants=string_constants)

def lower_logical_and(expression, match, bindings, locals, temp_index, lines, functions, context):
    left_text = trim_text(substring(expression, 0, match.index))
    right_text = trim_text(substring(expression, match.index + 2, len(expression)))
    diagnostics = []
    string_constants = empty_string_constant_set()
    if len(left_text) == 0  or  len(right_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: malformed && expression `" + expression + "`")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    label_id = number_to_string(temp_index)
    entry_label = "logical_and_entry_" + label_id
    check_right_label = "logical_and_right_" + label_id
    right_end_label = "logical_and_right_end_" + label_id
    merge_label = "logical_and_merge_" + label_id
    label_temp_offset = temp_index + 1
    left_result = lower_expression(left_text, bindings, locals, label_temp_offset, lines, functions, context, "")
    diagnostics = (diagnostics) + (left_result.diagnostics)
    string_constants = left_result.string_constants
    if left_result.operand == None:
        return ExpressionResult(lines=left_result.lines, temp_index=left_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    left_bool = coerce_operand_to_type(left_result.operand, "i1", left_result.temp_index, left_result.lines)
    diagnostics = (diagnostics) + (left_bool.diagnostics)
    string_constants = merge_string_constants(string_constants, left_result.string_constants)
    if left_bool.operand == None:
        return ExpressionResult(lines=left_bool.lines, temp_index=left_bool.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    current_lines = left_bool.lines
    current_lines = append_string(current_lines, "  br label %" + entry_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, entry_label + ":")
    current_lines = append_string(current_lines, "  br i1 " + left_bool.operand.value + ", label %" + check_right_label + ", label %" + merge_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, check_right_label + ":")
    right_result = lower_expression(right_text, bindings, locals, left_bool.temp_index, current_lines, functions, context, "")
    diagnostics = (diagnostics) + (right_result.diagnostics)
    string_constants = merge_string_constants(string_constants, right_result.string_constants)
    if right_result.operand == None:
        return ExpressionResult(lines=right_result.lines, temp_index=right_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    right_bool = coerce_operand_to_type(right_result.operand, "i1", right_result.temp_index, right_result.lines)
    diagnostics = (diagnostics) + (right_bool.diagnostics)
    string_constants = merge_string_constants(string_constants, right_result.string_constants)
    if right_bool.operand == None:
        return ExpressionResult(lines=right_bool.lines, temp_index=right_bool.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    current_lines = right_bool.lines
    current_lines = append_string(current_lines, "  br label %" + right_end_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, right_end_label + ":")
    current_lines = append_string(current_lines, "  br label %" + merge_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, merge_label + ":")
    result_temp = format_temp_name(right_bool.temp_index)
    current_lines = append_string(current_lines, "  " + result_temp + " = phi i1 [ false, %" + entry_label + " ], [ " + right_bool.operand.value + ", %" + right_end_label + " ]")
    operand = LLVMOperand(llvm_type="i1", value=result_temp)
    return ExpressionResult(lines=current_lines, temp_index=right_bool.temp_index + 1, operand=operand, diagnostics=diagnostics, string_constants=string_constants)

def lower_logical_or(expression, match, bindings, locals, temp_index, lines, functions, context):
    left_text = trim_text(substring(expression, 0, match.index))
    right_text = trim_text(substring(expression, match.index + 2, len(expression)))
    diagnostics = []
    string_constants = empty_string_constant_set()
    if len(left_text) == 0  or  len(right_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: malformed || expression `" + expression + "`")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    label_id = number_to_string(temp_index)
    entry_label = "logical_or_entry_" + label_id
    check_right_label = "logical_or_right_" + label_id
    right_end_label = "logical_or_right_end_" + label_id
    merge_label = "logical_or_merge_" + label_id
    label_temp_offset = temp_index + 1
    left_result = lower_expression(left_text, bindings, locals, label_temp_offset, lines, functions, context, "")
    diagnostics = (diagnostics) + (left_result.diagnostics)
    string_constants = left_result.string_constants
    if left_result.operand == None:
        return ExpressionResult(lines=left_result.lines, temp_index=left_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    left_bool = coerce_operand_to_type(left_result.operand, "i1", left_result.temp_index, left_result.lines)
    diagnostics = (diagnostics) + (left_bool.diagnostics)
    string_constants = merge_string_constants(string_constants, left_result.string_constants)
    if left_bool.operand == None:
        return ExpressionResult(lines=left_bool.lines, temp_index=left_bool.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    current_lines = left_bool.lines
    current_lines = append_string(current_lines, "  br label %" + entry_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, entry_label + ":")
    current_lines = append_string(current_lines, "  br i1 " + left_bool.operand.value + ", label %" + merge_label + ", label %" + check_right_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, check_right_label + ":")
    right_result = lower_expression(right_text, bindings, locals, left_bool.temp_index, current_lines, functions, context, "")
    diagnostics = (diagnostics) + (right_result.diagnostics)
    string_constants = merge_string_constants(string_constants, right_result.string_constants)
    if right_result.operand == None:
        return ExpressionResult(lines=right_result.lines, temp_index=right_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    right_bool = coerce_operand_to_type(right_result.operand, "i1", right_result.temp_index, right_result.lines)
    diagnostics = (diagnostics) + (right_bool.diagnostics)
    string_constants = merge_string_constants(string_constants, right_result.string_constants)
    if right_bool.operand == None:
        return ExpressionResult(lines=right_bool.lines, temp_index=right_bool.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    current_lines = right_bool.lines
    current_lines = append_string(current_lines, "  br label %" + right_end_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, right_end_label + ":")
    current_lines = append_string(current_lines, "  br label %" + merge_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, merge_label + ":")
    result_temp = format_temp_name(right_bool.temp_index)
    current_lines = append_string(current_lines, "  " + result_temp + " = phi i1 [ true, %" + entry_label + " ], [ " + right_bool.operand.value + ", %" + right_end_label + " ]")
    operand = LLVMOperand(llvm_type="i1", value=result_temp)
    return ExpressionResult(lines=current_lines, temp_index=right_bool.temp_index + 1, operand=operand, diagnostics=diagnostics, string_constants=string_constants)

def lower_call_expression(target, arguments, bindings, locals, temp_index, lines, functions, context):
    diagnostics = []
    collected_string_constants = empty_string_constant_set()
    empty_constants = empty_string_constant_set()
    trimmed_target = trim_text(target)
    if len(trimmed_target) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: call target missing")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    dot_index = index_of(trimmed_target, ".")
    if dot_index > 0:
        enum_name = trim_text(substring(trimmed_target, 0, dot_index))
        variant_name = trim_text(substring(trimmed_target, dot_index + 1, len(trimmed_target)))
        enum_info = resolve_enum_info_for_literal(context, enum_name)
        if enum_info != None:
            fields = []
            if len(arguments) > 0:
                variant_info = resolve_enum_variant_info(enum_info, variant_name)
                if variant_info != None  and  len(variant_info.fields) == len(arguments):
                    arg_index = 0
                    while True:
                        if arg_index >= len(arguments):
                            break
                        field_info = variant_info.fields[arg_index]
                        fields = append_struct_literal_field(fields, StructLiteralField(name=field_info.name, value=arguments[arg_index]))
                        arg_index += 1
                else:
                    pass
            enum_parse = EnumLiteralParse(recognized=True, success=True, enum_name=enum_name, variant_name=variant_name, fields=fields, diagnostics=[])
            return lower_enum_literal(enum_parse, bindings, locals, temp_index, lines, functions, context, "")
    current_lines = lines
    current_temp = temp_index
    operands = []
    injected_argument_count = 0
    method_operand = None
    helper_descriptor = None
    method_parse = parse_member_access(trimmed_target)
    if method_parse.success:
        method_info = resolve_struct_info_for_method_target(method_parse.base, bindings, locals, context)
        interface_info = resolve_interface_info_for_method_target(method_parse.base, bindings, locals, context)
        if method_info != None:
            lowered_self = lower_expression(method_parse.base, bindings, locals, current_temp, current_lines, functions, context, "")
            diagnostics = (diagnostics) + (lowered_self.diagnostics)
            collected_string_constants = merge_string_constants(collected_string_constants, lowered_self.string_constants)
            current_lines = lowered_self.lines
            current_temp = lowered_self.temp_index
            if lowered_self.operand != None:
                method_operand = lowered_self.operand
                trimmed_target = method_info.name + "::" + method_parse.field
                injected_argument_count = 1
            else:
                diagnostics = append_string(diagnostics, "llvm lowering: method call base `" + method_parse.base + "` produced no value")
                return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
        else:
            if interface_info != None:
                lowered_self = lower_expression(method_parse.base, bindings, locals, current_temp, current_lines, functions, context, "")
                diagnostics = (diagnostics) + (lowered_self.diagnostics)
                collected_string_constants = merge_string_constants(collected_string_constants, lowered_self.string_constants)
                current_lines = lowered_self.lines
                current_temp = lowered_self.temp_index
                if lowered_self.operand != None:
                    method_operand = lowered_self.operand
                    trimmed_target = "trait_dispatch::" + interface_info.name + "::" + method_parse.field
                    injected_argument_count = 1
                else:
                    diagnostics = append_string(diagnostics, "llvm lowering: method call base `" + method_parse.base + "` produced no value")
                    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
            else:
                helper_candidate = find_runtime_helper(trimmed_target)
                if helper_candidate != None:
                    helper_descriptor = helper_candidate
                else:
                    lowered_self = lower_expression(method_parse.base, bindings, locals, current_temp, current_lines, functions, context, "")
                    diagnostics = (diagnostics) + (lowered_self.diagnostics)
                    collected_string_constants = merge_string_constants(collected_string_constants, lowered_self.string_constants)
                    current_lines = lowered_self.lines
                    current_temp = lowered_self.temp_index
                    if lowered_self.operand != None:
                        base_operand = lowered_self.operand
                        array_element_type = array_pointer_element_type(base_operand.llvm_type)
                        if len(array_element_type) > 0  and  method_parse.field == "concat":
                            method_operand = base_operand
                            trimmed_target = "concat"
                            injected_argument_count = 1
                    else:
                        diagnostics = append_string(diagnostics, "llvm lowering: method call base `" + method_parse.base + "` produced no value")
                        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    function_entry = None
    llvm_return = "double"
    expected_params = []
    is_trait_dispatch = False
    if substring(trimmed_target, 0, 16) == "trait_dispatch::":
        is_trait_dispatch = True
        after_prefix = substring(trimmed_target, 16, len(trimmed_target))
        double_colon_pos = find_last_index_of_char(after_prefix, ":")
        if double_colon_pos > 0  and  substring(after_prefix, double_colon_pos - 1, double_colon_pos + 1) == "::":
            interface_name = substring(after_prefix, 0, double_colon_pos - 1)
            method_name = substring(after_prefix, double_colon_pos + 1, len(after_prefix))
            interface_info = find_interface_info_by_name(context, interface_name)
            if interface_info != None:
                sig_idx = 0
                while True:
                    if sig_idx >= len(interface_info.signatures):
                        break
                    sig = interface_info.signatures[sig_idx]
                    if sig.name == method_name:
                        llvm_return = map_return_type(context, sig.return_type)
                        if len(llvm_return) == 0:
                            llvm_return = "double"
                        expected_params = ["i8*"]
                        break
                    sig_idx += 1
    function_entry = find_function_by_name(functions, trimmed_target)
    if helper_descriptor == None:
        helper_descriptor = find_runtime_helper(trimmed_target)
    if not is_trait_dispatch:
        if function_entry != None:
            llvm_return = map_return_type(context, function_entry.return_type)
            if len(llvm_return) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: unsupported return type in call to `" + trimmed_target + "`")
                llvm_return = "double"
            expected_params = collect_parameter_types(context, function_entry.parameters)
        else:
            if helper_descriptor != None:
                descriptor = helper_descriptor
                llvm_return = descriptor.return_type
                expected_params = descriptor.parameter_types
            else:
                diagnostics = append_string(diagnostics, "llvm lowering: call to unknown function `" + trimmed_target + "`")
    index = 0
    while True:
        if index >= len(arguments):
            break
        argument_text = trim_text(arguments[index])
        if len(argument_text) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: empty argument in call to `" + trimmed_target + "`")
        argument_expected_type = ""
        parameter_index = index + injected_argument_count
        if len(expected_params) > parameter_index:
            argument_expected_type = expected_params[parameter_index]
        lowered = lower_expression(argument_text, bindings, locals, current_temp, current_lines, functions, context, argument_expected_type)
        diagnostics = (diagnostics) + (lowered.diagnostics)
        collected_string_constants = merge_string_constants(collected_string_constants, lowered.string_constants)
        current_lines = lowered.lines
        current_temp = lowered.temp_index
        if lowered.operand != None:
            operands = append_llvm_operand(operands, lowered.operand)
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: failed to lower argument " + number_to_string(index) + " for call to `" + trimmed_target + "`")
        index += 1
    if method_operand != None:
        operand_value = method_operand
        combined_operands = []
        combined_operands = append_llvm_operand(combined_operands, operand_value)
        operand_index = 0
        while True:
            if operand_index >= len(operands):
                break
            combined_operands = append_llvm_operand(combined_operands, operands[operand_index])
            operand_index += 1
        operands = combined_operands
    expected_operand_count = len(arguments) + injected_argument_count
    if len(operands) != expected_operand_count:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to emit call to `" + trimmed_target + "` due to argument errors")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    if function_entry != None  and  injected_argument_count == 1:
        if len(operands) > 0  and  len(expected_params) > 0:
            expected_self_type = expected_params[0]
            self_operand = operands[0]
            if self_operand.llvm_type != expected_self_type:
                if ends_with_pointer_suffix(self_operand.llvm_type):
                    stripped = strip_pointer_suffix(self_operand.llvm_type)
                    if stripped == expected_self_type:
                        load_name = format_temp_name(current_temp)
                        current_lines = append_string(current_lines, "  " + load_name + " = load " + expected_self_type + ", " + expected_self_type + "* " + self_operand.value)
                        current_temp += 1
                        updated_operand = LLVMOperand(llvm_type=expected_self_type, value=load_name)
                        operands = replace_llvm_operand(operands, 0, updated_operand)
                    else:
                        diagnostics = append_string(diagnostics, "llvm lowering: method call expects `" + expected_self_type + "` but base `" + self_operand.llvm_type + "` is incompatible")
                else:
                    diagnostics = append_string(diagnostics, "llvm lowering: method call expects `" + expected_self_type + "` but base `" + self_operand.llvm_type + "` is incompatible")
    coerced_operands = []
    index = 0
    while True:
        if index >= len(operands):
            break
        operand = operands[index]
        target_type = ""
        if len(expected_params) > index:
            target_type = expected_params[index]
        if is_trait_dispatch  and  index == 0:
            coerced_operands = append_llvm_operand(coerced_operands, operand)
        else:
            if len(target_type) == 0:
                coerced_operands = append_llvm_operand(coerced_operands, operand)
            else:
                coerced = coerce_operand_to_type(operand, target_type, current_temp, current_lines)
                diagnostics = (diagnostics) + (coerced.diagnostics)
                current_lines = coerced.lines
                current_temp = coerced.temp_index
                if coerced.operand == None:
                    diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce argument " + number_to_string(index) + " for call to `" + trimmed_target + "`")
                    placeholder = LLVMOperand(llvm_type="i8*", value="null")
                    coerced_operands = append_llvm_operand(coerced_operands, placeholder)
                else:
                    coerced_operands = append_llvm_operand(coerced_operands, coerced.operand)
        index += 1
    operands = coerced_operands
    if function_entry != None  or  helper_descriptor != None:
        if len(expected_params) != len(operands):
            diagnostics = append_string(diagnostics, "llvm lowering: call to `" + trimmed_target + "` expected " + number_to_string(len(expected_params)) + " arguments but received " + number_to_string(len(operands)))
    rendered_args = []
    index = 0
    while True:
        if index >= len(operands):
            break
        rendered_args = append_string(rendered_args, format_typed_operand(operands[index]))
        index += 1
    argument_text = join_with_separator(rendered_args, ", ")
    if substring(trimmed_target, 0, 16) == "trait_dispatch::":
        after_prefix = substring(trimmed_target, 16, len(trimmed_target))
        double_colon_pos = find_last_index_of_char(after_prefix, ":")
        if double_colon_pos > 0  and  substring(after_prefix, double_colon_pos - 1, double_colon_pos + 1) == "::":
            interface_name = substring(after_prefix, 0, double_colon_pos - 1)
            method_name = substring(after_prefix, double_colon_pos + 1, len(after_prefix))
            if len(operands) > 0:
                trait_object = operands[0]
                data_ptr_temp = "%t" + number_to_string(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + data_ptr_temp + " = extractvalue " + trait_object.llvm_type + " " + trait_object.value + ", 0")
                vtable_ptr_temp = "%t" + number_to_string(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + vtable_ptr_temp + " = extractvalue " + trait_object.llvm_type + " " + trait_object.value + ", 1")
                interface_info = find_interface_info_by_name(context, interface_name)
                if interface_info != None:
                    method_index = -1
                    sig_idx = 0
                    while True:
                        if sig_idx >= len(interface_info.signatures):
                            break
                        if interface_info.signatures[sig_idx].name == method_name:
                            method_index = sig_idx
                            break
                        sig_idx += 1
                    if method_index >= 0:
                        fp_param_types = ["i8*"]
                        arg_idx = 1
                        while True:
                            if arg_idx >= len(operands):
                                break
                            fp_param_types = append_string(fp_param_types, operands[arg_idx].llvm_type)
                            arg_idx += 1
                        fp_params = join_with_separator(fp_param_types, ", ")
                        function_type = llvm_return + " (" + fp_params + ")*"
                        vtable_cast_temp = "%t" + number_to_string(current_temp)
                        current_temp += 1
                        current_lines = append_string(current_lines, "  " + vtable_cast_temp + " = bitcast i8* " + vtable_ptr_temp + " to " + function_type + "*")
                        method_ptr_temp = "%t" + number_to_string(current_temp)
                        current_temp += 1
                        current_lines = append_string(current_lines, "  " + method_ptr_temp + " = load " + function_type + ", " + function_type + "* " + vtable_cast_temp)
                        call_args = ["i8* " + data_ptr_temp]
                        arg_idx = 1
                        while True:
                            if arg_idx >= len(rendered_args):
                                break
                            call_args = append_string(call_args, rendered_args[arg_idx])
                            arg_idx += 1
                        call_arg_text = join_with_separator(call_args, ", ")
                        if llvm_return == "void":
                            current_lines = append_string(current_lines, "  call void " + method_ptr_temp + "(" + call_arg_text + ")")
                            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
                        else:
                            result_temp = format_temp_name(current_temp)
                            current_lines = append_string(current_lines, "  " + result_temp + " = call " + llvm_return + " " + method_ptr_temp + "(" + call_arg_text + ")")
                            result_operand = LLVMOperand(llvm_type=llvm_return, value=result_temp)
                            return ExpressionResult(lines=current_lines, temp_index=current_temp + 1, operand=result_operand, diagnostics=diagnostics, string_constants=collected_string_constants)
                    else:
                        diagnostics = append_string(diagnostics, "llvm lowering: method `" + method_name + "` not found in interface `" + interface_name + "`")
                else:
                    diagnostics = append_string(diagnostics, "llvm lowering: interface `" + interface_name + "` not found for trait dispatch")
            else:
                diagnostics = append_string(diagnostics, "llvm lowering: trait dispatch requires at least one argument (the trait object)")
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: malformed trait dispatch target `" + trimmed_target + "`")
    call_symbol = sanitize_symbol(trimmed_target)
    if helper_descriptor != None:
        call_symbol = helper_descriptor.symbol
    if llvm_return == "void":
        call_line = "  call void @" + call_symbol + "(" + argument_text + ")"
        current_lines = append_string(current_lines, call_line)
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    temp_name = format_temp_name(current_temp)
    call_line = "  " + temp_name + " = call " + llvm_return + " @" + call_symbol + "(" + argument_text + ")"
    current_lines = append_string(current_lines, call_line)
    operand = LLVMOperand(llvm_type=llvm_return, value=temp_name)
    return ExpressionResult(lines=current_lines, temp_index=current_temp + 1, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)

def lower_member_access(parse, bindings, locals, temp_index, lines, functions, context, expected_type):
    base_result = lower_expression(parse.base, bindings, locals, temp_index, lines, functions, context, "")
    diagnostics = base_result.diagnostics
    collected_string_constants = base_result.string_constants
    if base_result.operand == None:
        return ExpressionResult(lines=base_result.lines, temp_index=base_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    current_lines = base_result.lines
    current_temp = base_result.temp_index
    base_operand = base_result.operand
    if parse.field == "length"  and  ends_with_pointer_suffix(base_operand.llvm_type):
        inner_type = strip_pointer_suffix(base_operand.llvm_type)
        if starts_with(inner_type, "{")  and  len(inner_type) > 0  and  inner_type[len(inner_type) - 1] == "}":
            struct_inner = trim_text(substring(inner_type, 1, len(inner_type) - 1))
            if contains_text(struct_inner, ", i64"):
                loaded_array = format_temp_name(current_temp)
                current_lines = append_string(current_lines, "  " + loaded_array + " = load " + inner_type + ", " + base_operand.llvm_type + " " + base_operand.value)
                current_temp += 1
                length_temp = format_temp_name(current_temp)
                current_lines = append_string(current_lines, "  " + length_temp + " = extractvalue " + inner_type + " " + loaded_array + ", 1")
                current_temp += 1
                operand = LLVMOperand(llvm_type="i64", value=length_temp)
                return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)
    if parse.field == "length"  and  base_operand.llvm_type == "i8*":
        length_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + length_temp + " = call i64 @sailfin_runtime_string_length(i8* " + base_operand.value + ")")
        current_temp += 1
        operand = LLVMOperand(llvm_type="i64", value=length_temp)
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)
    struct_info = None
    pointer_available = False
    pointer_operand = base_operand
    if ends_with_pointer_suffix(base_operand.llvm_type):
        candidate = strip_pointer_suffix(base_operand.llvm_type)
        struct_info = find_struct_info_by_llvm_type(context, candidate)
        if struct_info == None:
            enum_info_candidate = find_enum_info_by_llvm_type(context, candidate)
            if enum_info_candidate != None:
                return lower_enum_member_access(parse, enum_info_candidate, base_operand, True, current_temp, current_lines, diagnostics, collected_string_constants, expected_type)
            if base_operand.llvm_type == "i8*":
                return lower_dynamic_member_access(parse.field, base_operand, current_temp, current_lines, diagnostics, collected_string_constants)
            if base_operand.llvm_type != "double"  and  base_operand.llvm_type != "i8":
                diagnostics = append_string(diagnostics, "llvm lowering: member access base `" + base_operand.llvm_type + "` lacks struct metadata")
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
        pointer_available = True
    else:
        struct_info = find_struct_info_by_llvm_type(context, base_operand.llvm_type)
        if struct_info == None:
            enum_info_candidate = find_enum_info_by_llvm_type(context, base_operand.llvm_type)
            if enum_info_candidate != None:
                return lower_enum_member_access(parse, enum_info_candidate, base_operand, False, current_temp, current_lines, diagnostics, collected_string_constants, expected_type)
            if base_operand.llvm_type == "i8*":
                return lower_dynamic_member_access(parse.field, base_operand, current_temp, current_lines, diagnostics, collected_string_constants)
            if base_operand.llvm_type != "double"  and  base_operand.llvm_type != "i8":
                diagnostics = append_string(diagnostics, "llvm lowering: member access base `" + base_operand.llvm_type + "` lacks struct metadata")
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    info = struct_info
    field_info = find_struct_field_info(info, parse.field)
    if field_info == None:
        diagnostics = append_string(diagnostics, "llvm lowering: struct `" + info.name + "` has no field `" + parse.field + "`")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    if pointer_available:
        struct_type = info.llvm_name
        gep_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + gep_name + " = getelementptr " + struct_type + ", " + struct_type + "* " + pointer_operand.value + ", i32 0, i32 " + number_to_string(field_info.index))
        current_temp += 1
        load_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + load_name + " = load " + field_info.llvm_type + ", " + field_info.llvm_type + "* " + gep_name)
        current_temp += 1
        operand = LLVMOperand(llvm_type=field_info.llvm_type, value=load_name)
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)
    extract_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + extract_name + " = extractvalue " + info.llvm_name + " " + base_operand.value + ", " + number_to_string(field_info.index))
    current_temp += 1
    operand = LLVMOperand(llvm_type=field_info.llvm_type, value=extract_name)
    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)

def make_expression_result(lines, temp_index, operand, diagnostics, string_constants):
    return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics, string_constants=string_constants)

def lower_dynamic_member_access(field, base_operand, temp_index, lines, diagnostics, string_constants):
    current_lines = lines
    current_temp = temp_index
    dynamic_string_constants = string_constants
    sanitized_field = sanitize_symbol(field)
    constant_name = "@.runtime.field." + sanitized_field
    existing_constant = find_string_constant_by_name(dynamic_string_constants, constant_name)
    field_constant = StringConstant(name=constant_name, content=field, byte_count=len(field))
    if existing_constant != None:
        field_constant = existing_constant
    else:
        dynamic_string_constants = append_string_constant(dynamic_string_constants, field_constant)
    pointer_result = emit_string_constant_pointer(field_constant, current_temp, current_lines)
    current_lines = pointer_result.lines
    current_temp = pointer_result.temp_index
    field_pointer = pointer_result.pointer
    call_temp = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + call_temp + " = call i8* @sailfin_runtime_get_field(i8* " + base_operand.value + ", i8* " + field_pointer + ")")
    current_temp += 1
    operand = LLVMOperand(llvm_type="i8*", value=call_temp)
    return make_expression_result(current_lines, current_temp, operand, diagnostics, dynamic_string_constants)

def lower_runtime_global_reference(temp_index, lines):
    runtime_temp = format_temp_name(temp_index)
    current_lines = lines
    current_lines = append_string(current_lines, "  " + runtime_temp + " = load i8*, i8** @runtime")
    operand = LLVMOperand(llvm_type="i8*", value=runtime_temp)
    empty_constants = empty_string_constant_set()
    return ExpressionResult(lines=current_lines, temp_index=temp_index + 1, operand=operand, diagnostics=[], string_constants=empty_constants)

def lower_enum_member_access(parse, enum_info, base_operand, pointer_available, temp_index, lines, diagnostics, string_constants, expected_type):
    current_lines = lines
    current_temp = temp_index
    enum_string_constants = string_constants
    messages = diagnostics
    tag_operand = LLVMOperand(llvm_type=enum_info.tag_type, value="")
    if pointer_available:
        tag_ptr = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + tag_ptr + " = getelementptr inbounds " + enum_info.llvm_name + ", " + enum_info.llvm_name + "* " + base_operand.value + ", i32 0, i32 0")
        current_temp += 1
        tag_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + tag_temp + " = load " + enum_info.tag_type + ", " + enum_info.tag_type + "* " + tag_ptr)
        current_temp += 1
        tag_operand = LLVMOperand(llvm_type=enum_info.tag_type, value=tag_temp)
    else:
        tag_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + tag_temp + " = extractvalue " + enum_info.llvm_name + " " + base_operand.value + ", 0")
        current_temp += 1
        tag_operand = LLVMOperand(llvm_type=enum_info.tag_type, value=tag_temp)
    if parse.field == "variant":
        sanitized_enum = sanitize_symbol(enum_info.name)
        default_constant_name = "@.enum." + sanitized_enum + ".variant.default"
        existing_default = find_string_constant_by_name(enum_string_constants, default_constant_name)
        default_constant = StringConstant(name=default_constant_name, content="", byte_count=0)
        if existing_default != None:
            default_constant = existing_default
        else:
            default_constant = StringConstant(name=default_constant_name, content="", byte_count=0)
            enum_string_constants = append_string_constant(enum_string_constants, default_constant)
        default_pointer_result = emit_string_constant_pointer(default_constant, current_temp, current_lines)
        current_lines = default_pointer_result.lines
        current_temp = default_pointer_result.temp_index
        current_pointer = default_pointer_result.pointer
        variant_index = 0
        while True:
            if variant_index >= len(enum_info.variants):
                break
            variant_info = enum_info.variants[variant_index]
            sanitized_variant = sanitize_symbol(variant_info.name)
            constant_name = "@.enum." + sanitized_enum + "." + sanitized_variant + ".variant"
            existing_variant = find_string_constant_by_name(enum_string_constants, constant_name)
            variant_constant = StringConstant(name=constant_name, content="", byte_count=0)
            if existing_variant != None:
                variant_constant = existing_variant
            else:
                variant_constant = StringConstant(name=constant_name, content=variant_info.name, byte_count=len(variant_info.name))
                enum_string_constants = append_string_constant(enum_string_constants, variant_constant)
            pointer_result = emit_string_constant_pointer(variant_constant, current_temp, current_lines)
            current_lines = pointer_result.lines
            current_temp = pointer_result.temp_index
            variant_pointer = pointer_result.pointer
            compare_temp = format_temp_name(current_temp)
            current_lines = append_string(current_lines, "  " + compare_temp + " = icmp eq " + tag_operand.llvm_type + " " + tag_operand.value + ", " + number_to_string(variant_info.tag))
            current_temp += 1
            select_temp = format_temp_name(current_temp)
            current_lines = append_string(current_lines, "  " + select_temp + " = select i1 " + compare_temp + ", i8* " + variant_pointer + ", i8* " + current_pointer)
            current_temp += 1
            current_pointer = select_temp
            variant_index += 1
        operand = LLVMOperand(llvm_type="i8*", value=current_pointer)
        return make_expression_result(current_lines, current_temp, operand, messages, enum_string_constants)
    matched_variants = []
    matched_fields = []
    variant_check_index = 0
    while True:
        if variant_check_index >= len(enum_info.variants):
            break
        candidate_variant = enum_info.variants[variant_check_index]
        candidate_field = find_variant_field_info(candidate_variant, parse.field)
        if candidate_field != None:
            matched_variants = (matched_variants) + ([candidate_variant])
            matched_fields = (matched_fields) + ([candidate_field])
        variant_check_index += 1
    if len(matched_variants) == 0:
        messages = append_string(messages, "llvm lowering: enum `" + enum_info.name + "` has no field `" + parse.field + "` on any variant")
        return make_expression_result(current_lines, current_temp, None, messages, enum_string_constants)
    selected_variants = matched_variants
    selected_fields = matched_fields
    if len(expected_type) > 0:
        filtered_variants = []
        filtered_fields = []
        selection_index = 0
        while True:
            if selection_index >= len(matched_fields):
                break
            candidate_field = matched_fields[selection_index]
            if candidate_field.llvm_type == expected_type:
                filtered_variants = (filtered_variants) + ([matched_variants[selection_index]])
                filtered_fields = (filtered_fields) + ([candidate_field])
            selection_index += 1
        if len(filtered_variants) > 0:
            selected_variants = filtered_variants
            selected_fields = filtered_fields
    if len(selected_variants) == 0:
        if len(expected_type) > 0:
            messages = append_string(messages, "llvm lowering: enum `" + enum_info.name + "` has no field `" + parse.field + "` compatible with expected type `" + expected_type + "`")
        else:
            messages = append_string(messages, "llvm lowering: enum member access for `" + enum_info.name + "." + parse.field + "` uses incompatible field types across variants")
        return make_expression_result(current_lines, current_temp, None, messages, enum_string_constants)
    first_type = selected_fields[0].llvm_type
    base_type = first_type
    first_pointer_depth = 0
    while True:
        if not ends_with_pointer_suffix(base_type):
            break
        base_type = strip_pointer_suffix(base_type)
        first_pointer_depth += 1
    min_pointer_depth = first_pointer_depth
    max_pointer_depth = first_pointer_depth
    consistent_base = True
    pointer_depth_mismatch = False
    type_index = 1
    while True:
        if type_index >= len(selected_fields):
            break
        candidate_type = selected_fields[type_index].llvm_type
        candidate_base = candidate_type
        candidate_depth = 0
        while True:
            if not ends_with_pointer_suffix(candidate_base):
                break
            candidate_base = strip_pointer_suffix(candidate_base)
            candidate_depth += 1
        if candidate_base != base_type:
            consistent_base = False
            break
        if candidate_depth != first_pointer_depth:
            pointer_depth_mismatch = True
        if candidate_depth < min_pointer_depth:
            min_pointer_depth = candidate_depth
        if candidate_depth > max_pointer_depth:
            max_pointer_depth = candidate_depth
        type_index += 1
    if not consistent_base:
        messages = append_string(messages, "llvm lowering: enum member access for `" + enum_info.name + "." + parse.field + "` uses incompatible field types across variants")
        return make_expression_result(current_lines, current_temp, None, messages, enum_string_constants)
    field_type = selected_fields[0].llvm_type
    pointer_coercion = False
    if pointer_depth_mismatch:
        if max_pointer_depth - min_pointer_depth == 1  and  len(base_type) > 0  and  base_type[0] == "%":
            pointer_coercion = True
            field_type = base_type + "*"
        else:
            messages = append_string(messages, "llvm lowering: enum member access for `" + enum_info.name + "." + parse.field + "` uses incompatible field types across variants")
            return make_expression_result(current_lines, current_temp, None, messages, enum_string_constants)
    enum_pointer_value = base_operand.value
    if not pointer_available:
        alloca_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + alloca_temp + " = alloca " + enum_info.llvm_name)
        current_temp += 1
        current_lines = append_string(current_lines, "  store " + enum_info.llvm_name + " " + base_operand.value + ", " + enum_info.llvm_name + "* " + alloca_temp)
        enum_pointer_value = alloca_temp
    default_literal = default_return_literal(field_type)
    current_value_text = default_literal
    match_index = 0
    while True:
        if match_index >= len(selected_variants):
            break
        variant_info = selected_variants[match_index]
        field_info = selected_fields[match_index]
        payload_ptr_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + payload_ptr_temp + " = getelementptr inbounds " + enum_info.llvm_name + ", " + enum_info.llvm_name + "* " + enum_pointer_value + ", i32 0, i32 1")
        current_temp += 1
        byte_ptr_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + byte_ptr_temp + " = bitcast [" + number_to_string(variant_info.size) + " x i8]* " + payload_ptr_temp + " to i8*")
        current_temp += 1
        field_offset_in_payload = field_info.offset - variant_info.offset
        field_ptr_temp = byte_ptr_temp
        if field_offset_in_payload > 0:
            offset_ptr_temp = format_temp_name(current_temp)
            current_lines = append_string(current_lines, "  " + offset_ptr_temp + " = getelementptr inbounds i8, i8* " + byte_ptr_temp + ", i64 " + number_to_string(field_offset_in_payload))
            current_temp += 1
            field_ptr_temp = offset_ptr_temp
        storage_type = field_info.llvm_type
        typed_ptr_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + typed_ptr_temp + " = bitcast i8* " + field_ptr_temp + " to " + storage_type + "*")
        current_temp += 1
        value_temp = typed_ptr_temp
        if pointer_coercion:
            if ends_with_pointer_suffix(storage_type):
                value_temp = format_temp_name(current_temp)
                current_lines = append_string(current_lines, "  " + value_temp + " = load " + storage_type + ", " + storage_type + "* " + typed_ptr_temp)
                current_temp += 1
        else:
            value_temp = format_temp_name(current_temp)
            current_lines = append_string(current_lines, "  " + value_temp + " = load " + storage_type + ", " + storage_type + "* " + typed_ptr_temp)
            current_temp += 1
        compare_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + compare_temp + " = icmp eq " + tag_operand.llvm_type + " " + tag_operand.value + ", " + number_to_string(variant_info.tag))
        current_temp += 1
        select_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + select_temp + " = select i1 " + compare_temp + ", " + field_type + " " + value_temp + ", " + field_type + " " + current_value_text)
        current_temp += 1
        current_value_text = select_temp
        match_index += 1
    operand = LLVMOperand(llvm_type=field_type, value=current_value_text)
    return make_expression_result(current_lines, current_temp, operand, messages, enum_string_constants)

def emit_string_constant_pointer(constant, temp_index, lines):
    current_lines = lines
    array_length = constant.byte_count + 1
    array_type = "[" + number_to_string(array_length) + " x i8]"
    temp_name = format_temp_name(temp_index)
    current_lines = append_string(current_lines, "  " + temp_name + " = getelementptr inbounds " + array_type + ", " + array_type + "* " + constant.name + ", i32 0, i32 0")
    return StringPointerResult(lines=current_lines, temp_index=temp_index + 1, pointer=temp_name)

def lower_index_expression(parse, bindings, locals, temp_index, lines, functions, context):
    base_result = lower_expression(parse.base, bindings, locals, temp_index, lines, functions, context, "")
    diagnostics = base_result.diagnostics
    collected_string_constants = base_result.string_constants
    if base_result.operand == None:
        return ExpressionResult(lines=base_result.lines, temp_index=base_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    current_lines = base_result.lines
    current_temp = base_result.temp_index
    base_operand = base_result.operand
    index_result = lower_expression(parse.index, bindings, locals, current_temp, current_lines, functions, context, "")
    diagnostics = (diagnostics) + (index_result.diagnostics)
    collected_string_constants = merge_string_constants(collected_string_constants, index_result.string_constants)
    current_lines = index_result.lines
    current_temp = index_result.temp_index
    if index_result.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: index expression produced no value")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    index_operand = index_result.operand
    index_coercion = coerce_operand_to_type(index_operand, "i64", current_temp, current_lines)
    diagnostics = (diagnostics) + (index_coercion.diagnostics)
    current_lines = index_coercion.lines
    current_temp = index_coercion.temp_index
    if index_coercion.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce index expression to i64")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    coerced_index = index_coercion.operand
    array_type = base_operand.llvm_type
    element_type = ""
    is_heap_array = False
    is_string = False
    if array_type == "i8*":
        element_type = "i8"
        is_string = True
    else:
        if ends_with_pointer_suffix(array_type):
            inner_type = strip_pointer_suffix(array_type)
            if starts_with(inner_type, "{")  and  len(inner_type) > 0  and  inner_type[len(inner_type) - 1] == "}":
                struct_inner = trim_text(substring(inner_type, 1, len(inner_type) - 1))
                comma_pos = -1
                i = 0
                while True:
                    if i >= len(struct_inner):
                        break
                    if struct_inner[i] == ",":
                        comma_pos = i
                        break
                    i += 1
                if comma_pos >= 0:
                    first_field = trim_text(substring(struct_inner, 0, comma_pos))
                    if ends_with_pointer_suffix(first_field):
                        element_type = strip_pointer_suffix(first_field)
                        is_heap_array = True
    if len(element_type) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to determine element type for array indexing on type `" + array_type + "`")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    if is_heap_array:
        data_ptr = ""
        length_value = ""
        array_struct_type = strip_pointer_suffix(array_type)
        loaded_array = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + loaded_array + " = load " + array_struct_type + ", " + array_type + " " + base_operand.value)
        current_temp += 1
        data_ptr_extracted = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + data_ptr_extracted + " = extractvalue " + array_struct_type + " " + loaded_array + ", 0")
        current_temp += 1
        data_ptr = data_ptr_extracted
        length_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + length_temp + " = extractvalue " + array_struct_type + " " + loaded_array + ", 1")
        current_temp += 1
        length_value = length_temp
        bounds_check = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + bounds_check + " = icmp uge i64 " + coerced_index.value + ", " + length_value)
        current_temp += 1
        current_lines = append_string(current_lines, "  ; bounds check: " + bounds_check + " (if true, out of bounds)")
        current_lines = append_string(current_lines, "  call void @sailfin_runtime_bounds_check(i64 " + coerced_index.value + ", i64 " + length_value + ")")
        element_ptr = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + element_ptr + " = getelementptr " + element_type + ", " + element_type + "* " + data_ptr + ", i64 " + coerced_index.value)
        current_temp += 1
        element_value = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + element_value + " = load " + element_type + ", " + element_type + "* " + element_ptr)
        current_temp += 1
        operand = LLVMOperand(llvm_type=element_type, value=element_value)
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)
    else:
        if is_string:
            char_pointer = format_temp_name(current_temp)
            current_lines = append_string(current_lines, "  " + char_pointer + " = getelementptr i8, i8* " + base_operand.value + ", i64 " + coerced_index.value)
            current_temp += 1
            loaded_char = format_temp_name(current_temp)
            current_lines = append_string(current_lines, "  " + loaded_char + " = load i8, i8* " + char_pointer)
            current_temp += 1
            operand = LLVMOperand(llvm_type="i8", value=loaded_char)
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)
    diagnostics = append_string(diagnostics, "llvm lowering: unsupported array type for indexing: `" + array_type + "`")
    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)

def lower_array_literal(text, bindings, locals, temp_index, lines, functions, context, expected_type):
    diagnostics = []
    current_lines = lines
    current_temp = temp_index
    collected_string_constants = empty_string_constant_set()
    trimmed_expected = trim_text(expected_type)
    expected_element_type = ""
    if len(trimmed_expected) > 0:
        expected_element_type = array_pointer_element_type(trimmed_expected)
    expected_struct_type = ""
    if len(expected_element_type) > 0:
        expected_struct_type = array_struct_type_for_element(expected_element_type)
    inner = trim_text(substring(text, 1, len(text) - 1))
    elements = split_array_elements(inner)
    metadata = parse_array_literal_metadata(elements, context)
    operands = []
    inferred_element_type = metadata.element_type
    if len(inferred_element_type) == 0  and  len(expected_element_type) > 0:
        inferred_element_type = expected_element_type
    index = metadata.start_index
    while True:
        if index >= len(elements):
            break
        element_text = trim_text(elements[index])
        if len(element_text) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: empty element in array literal")
            index += 1
            continue
        lowered = lower_expression(element_text, bindings, locals, current_temp, current_lines, functions, context, "")
        diagnostics = (diagnostics) + (lowered.diagnostics)
        collected_string_constants = merge_string_constants(collected_string_constants, lowered.string_constants)
        current_lines = lowered.lines
        current_temp = lowered.temp_index
        if lowered.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: array literal element produced no value")
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
        operands = append_llvm_operand(operands, lowered.operand)
        inferred_element_type = dominant_type(inferred_element_type, lowered.operand.llvm_type)
        index += 1
    if len(operands) == 0:
        if len(inferred_element_type) == 0  and  len(expected_element_type) > 0:
            inferred_element_type = expected_element_type
        if len(inferred_element_type) == 0:
            inferred_element_type = "double"
    if len(inferred_element_type) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: unsupported array literal element type")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    element_type = inferred_element_type
    coerced_operands = []
    index = 0
    while True:
        if index >= len(operands):
            break
        operand = operands[index]
        prepared_operand = operand
        if ends_with_pointer_suffix(element_type)  and  not ends_with_pointer_suffix(operand.llvm_type):
            boxed = box_aggregate_operand(operand, element_type, current_temp, current_lines, context)
            diagnostics = (diagnostics) + (boxed.diagnostics)
            current_lines = boxed.lines
            current_temp = boxed.temp_index
            if boxed.operand == None:
                diagnostics = append_string(diagnostics, "llvm lowering: array literal element could not be boxed to `" + element_type + "`")
                return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
            prepared_operand = boxed.operand
        coerced = coerce_operand_to_type(prepared_operand, element_type, current_temp, current_lines)
        diagnostics = (diagnostics) + (coerced.diagnostics)
        current_lines = coerced.lines
        current_temp = coerced.temp_index
        if coerced.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: array literal element could not be coerced to `" + element_type + "`")
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
        coerced_operands = append_llvm_operand(coerced_operands, coerced.operand)
        index += 1
    operands = coerced_operands
    length_value = len(operands)
    length_text = number_to_string(length_value)
    array_type = "[" + length_text + " x " + element_type + "]"
    array_size_ptr = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + array_size_ptr + " = getelementptr " + array_type + ", " + array_type + "* null, i32 1")
    current_temp += 1
    array_bytes = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + array_bytes + " = ptrtoint " + array_type + "* " + array_size_ptr + " to i64")
    current_temp += 1
    array_bytes_is_zero = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + array_bytes_is_zero + " = icmp eq i64 " + array_bytes + ", 0")
    current_temp += 1
    adjusted_array_bytes = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + adjusted_array_bytes + " = select i1 " + array_bytes_is_zero + ", i64 1, i64 " + array_bytes)
    current_temp += 1
    raw_array_ptr = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + raw_array_ptr + " = call i8* @malloc(i64 " + adjusted_array_bytes + ")")
    current_temp += 1
    data_pointer = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + data_pointer + " = bitcast i8* " + raw_array_ptr + " to " + element_type + "*")
    current_temp += 1
    index = 0
    while True:
        if index >= len(operands):
            break
        element_pointer = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + element_pointer + " = getelementptr " + element_type + ", " + element_type + "* " + data_pointer + ", i64 " + number_to_string(index))
        current_temp += 1
        current_lines = append_string(current_lines, "  store " + element_type + " " + operands[index].value + ", " + element_type + "* " + element_pointer)
        index += 1
    struct_type = array_struct_type_for_element(element_type)
    if len(operands) == 0  and  len(expected_struct_type) > 0:
        struct_type = expected_struct_type
    struct_size_ptr = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + struct_size_ptr + " = getelementptr " + struct_type + ", " + struct_type + "* null, i32 1")
    current_temp += 1
    struct_bytes = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + struct_bytes + " = ptrtoint " + struct_type + "* " + struct_size_ptr + " to i64")
    current_temp += 1
    raw_struct_ptr = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + raw_struct_ptr + " = call i8* @malloc(i64 " + struct_bytes + ")")
    current_temp += 1
    struct_pointer = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + struct_pointer + " = bitcast i8* " + raw_struct_ptr + " to " + struct_type + "*")
    current_temp += 1
    data_field_pointer = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + data_field_pointer + " = getelementptr " + struct_type + ", " + struct_type + "* " + struct_pointer + ", i32 0, i32 0")
    current_temp += 1
    data_pointer_type = element_type + "*"
    data_pointer_pointer_type = data_pointer_type + "*"
    current_lines = append_string(current_lines, "  store " + data_pointer_type + " " + data_pointer + ", " + data_pointer_pointer_type + " " + data_field_pointer)
    length_field_pointer = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + length_field_pointer + " = getelementptr " + struct_type + ", " + struct_type + "* " + struct_pointer + ", i32 0, i32 1")
    current_temp += 1
    current_lines = append_string(current_lines, "  store i64 " + length_text + ", i64* " + length_field_pointer)
    operand = LLVMOperand(llvm_type=struct_type + "*", value=struct_pointer)
    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)

def find_matching_closing_brace(text, open_index):
    depth = 0
    index = open_index
    in_single = False
    in_double = False
    escape = False
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if in_double:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "\"":
                        in_double = False
            index += 1
            continue
        if in_single:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "'":
                        in_single = False
            index += 1
            continue
        if ch == "\"":
            in_double = True
            index += 1
            continue
        if ch == "'":
            in_single = True
            index += 1
            continue
        if ch == "{":
            depth += 1
        else:
            if ch == "}":
                if depth > 0:
                    depth -= 1
                    if depth == 0:
                        return index
        index += 1
    return -1

def find_top_level_colon(text):
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    angle_depth = 0
    in_single = False
    in_double = False
    escape = False
    index = 0
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if in_double:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "\"":
                        in_double = False
            index += 1
            continue
        if in_single:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "'":
                        in_single = False
            index += 1
            continue
        if ch == "\"":
            in_double = True
            index += 1
            continue
        if ch == "'":
            in_single = True
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
        if ch == "<":
            angle_depth += 1
            index += 1
            continue
        if ch == ">":
            if angle_depth > 0:
                angle_depth -= 1
            index += 1
            continue
        if ch == ":":
            if paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0  and  angle_depth == 0:
                return index
        index += 1
    return -1

def parse_struct_literal(text):
    trimmed = trim_text(text)
    diagnostics = []
    if len(trimmed) == 0:
        return StructLiteralParse(recognized=False, success=False, type_name="", fields=[], diagnostics=diagnostics)
    first = trimmed[0]
    if not is_identifier_start_char(first):
        return StructLiteralParse(recognized=False, success=False, type_name="", fields=[], diagnostics=diagnostics)
    paren_depth = 0
    bracket_depth = 0
    angle_depth = 0
    index = 0
    open_index = -1
    in_single = False
    in_double = False
    escape = False
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if in_double:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "\"":
                        in_double = False
            index += 1
            continue
        if in_single:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "'":
                        in_single = False
            index += 1
            continue
        if ch == "\"":
            in_double = True
            index += 1
            continue
        if ch == "'":
            in_single = True
            index += 1
            continue
        if ch == "(":
            paren_depth += 1
        else:
            if ch == ")":
                if paren_depth > 0:
                    paren_depth -= 1
            else:
                if ch == "[":
                    bracket_depth += 1
                else:
                    if ch == "]":
                        if bracket_depth > 0:
                            bracket_depth -= 1
                    else:
                        if ch == "<":
                            angle_depth += 1
                        else:
                            if ch == ">":
                                if angle_depth > 0:
                                    angle_depth -= 1
                            else:
                                if ch == "{":
                                    if paren_depth == 0  and  bracket_depth == 0  and  angle_depth == 0:
                                        open_index = index
                                        break
        index += 1
    if open_index < 0:
        return StructLiteralParse(recognized=False, success=False, type_name="", fields=[], diagnostics=diagnostics)
    fatal = False
    close_index = find_matching_closing_brace(trimmed, open_index)
    if close_index < 0:
        diagnostics = append_string(diagnostics, "llvm lowering: struct literal missing closing `}`")
        snippet = trimmed
        if len(snippet) > 120:
            snippet = substring(snippet, 0, 117) + "..."
        diagnostics = append_string(diagnostics, "llvm lowering: struct literal context `" + snippet + "`")
        fatal = True
    type_name = trim_text(substring(trimmed, 0, open_index))
    if len(type_name) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: struct literal missing type name")
        fatal = True
    fields = []
    if not fatal  and  close_index >= 0:
        body = substring(trimmed, open_index + 1, close_index)
        entries = split_array_elements(body)
        seen = []
        entry_index = 0
        while True:
            if entry_index >= len(entries):
                break
            entry = trim_text(entries[entry_index])
            entry_index += 1
            if len(entry) == 0:
                continue
            colon_index = find_top_level_colon(entry)
            if colon_index < 0:
                diagnostics = append_string(diagnostics, "llvm lowering: struct literal field `" + entry + "` missing `:`")
                continue
            field_name = trim_text(substring(entry, 0, colon_index))
            value_text = trim_text(substring(entry, colon_index + 1, len(entry)))
            if len(field_name) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: struct literal field missing name")
                continue
            if string_array_contains(seen, field_name):
                diagnostics = append_string(diagnostics, "llvm lowering: struct literal field `" + field_name + "` repeated")
                continue
            if len(value_text) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: struct literal field `" + field_name + "` missing value")
                continue
            seen = append_string(seen, field_name)
            fields = (fields) + ([StructLiteralField(name=field_name, value=value_text)])
    if not fatal  and  close_index >= 0:
        remainder = trim_text(substring(trimmed, close_index + 1, len(trimmed)))
        if len(remainder) > 0:
            diagnostics = append_string(diagnostics, "llvm lowering: struct literal trailing content `" + remainder + "`")
            fatal = True
    if fatal:
        fields = []
    return StructLiteralParse(recognized=True, success=not fatal, type_name=type_name, fields=fields, diagnostics=diagnostics)

def parse_enum_literal(text):
    trimmed = trim_text(text)
    diagnostics = []
    if len(trimmed) == 0:
        return EnumLiteralParse(recognized=False, success=False, enum_name="", variant_name="", fields=[], diagnostics=diagnostics)
    first = trimmed[0]
    if not is_identifier_start_char(first):
        return EnumLiteralParse(recognized=False, success=False, enum_name="", variant_name="", fields=[], diagnostics=diagnostics)
    dot_index = index_of(trimmed, ".")
    if dot_index < 0:
        return EnumLiteralParse(recognized=False, success=False, enum_name="", variant_name="", fields=[], diagnostics=diagnostics)
    enum_name_part = trim_text(substring(trimmed, 0, dot_index))
    if len(enum_name_part) == 0:
        return EnumLiteralParse(recognized=False, success=False, enum_name="", variant_name="", fields=[], diagnostics=diagnostics)
    paren_depth = 0
    bracket_depth = 0
    angle_depth = 0
    index = dot_index + 1
    open_index = -1
    in_single = False
    in_double = False
    escape = False
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if in_double:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "\"":
                        in_double = False
            index += 1
            continue
        if in_single:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "'":
                        in_single = False
            index += 1
            continue
        if ch == "\"":
            in_double = True
            index += 1
            continue
        if ch == "'":
            in_single = True
            index += 1
            continue
        if ch == "(":
            paren_depth += 1
        else:
            if ch == ")":
                if paren_depth > 0:
                    paren_depth -= 1
            else:
                if ch == "[":
                    bracket_depth += 1
                else:
                    if ch == "]":
                        if bracket_depth > 0:
                            bracket_depth -= 1
                    else:
                        if ch == "<":
                            angle_depth += 1
                        else:
                            if ch == ">":
                                if angle_depth > 0:
                                    angle_depth -= 1
                            else:
                                if ch == "{":
                                    if paren_depth == 0  and  bracket_depth == 0  and  angle_depth == 0:
                                        open_index = index
                                        break
        index += 1
    if open_index < 0:
        variant_name_part = trim_text(substring(trimmed, dot_index + 1, len(trimmed)))
        if len(variant_name_part) == 0:
            return EnumLiteralParse(recognized=False, success=False, enum_name="", variant_name="", fields=[], diagnostics=diagnostics)
        return EnumLiteralParse(recognized=True, success=True, enum_name=enum_name_part, variant_name=variant_name_part, fields=[], diagnostics=diagnostics)
    fatal = False
    close_index = find_matching_closing_brace(trimmed, open_index)
    if close_index < 0:
        diagnostics = append_string(diagnostics, "llvm lowering: enum literal missing closing `}`")
        fatal = True
    variant_name_part = trim_text(substring(trimmed, dot_index + 1, open_index))
    if len(variant_name_part) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: enum literal missing variant name")
        fatal = True
    fields = []
    if not fatal  and  close_index >= 0:
        body = substring(trimmed, open_index + 1, close_index)
        entries = split_array_elements(body)
        seen = []
        entry_index = 0
        while True:
            if entry_index >= len(entries):
                break
            entry = trim_text(entries[entry_index])
            entry_index += 1
            if len(entry) == 0:
                continue
            colon_index = find_top_level_colon(entry)
            if colon_index < 0:
                field_name = trim_text(entry)
                if len(field_name) == 0:
                    diagnostics = append_string(diagnostics, "llvm lowering: enum literal field missing name")
                    continue
                if string_array_contains(seen, field_name):
                    diagnostics = append_string(diagnostics, "llvm lowering: enum literal field `" + field_name + "` repeated")
                    continue
                seen = append_string(seen, field_name)
                fields = (fields) + ([StructLiteralField(name=field_name, value="")])
                continue
            field_name = trim_text(substring(entry, 0, colon_index))
            value_text = trim_text(substring(entry, colon_index + 1, len(entry)))
            if len(field_name) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: enum literal field missing name")
                continue
            if string_array_contains(seen, field_name):
                diagnostics = append_string(diagnostics, "llvm lowering: enum literal field `" + field_name + "` repeated")
                continue
            if len(value_text) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: enum literal field `" + field_name + "` missing value")
                continue
            seen = append_string(seen, field_name)
            fields = (fields) + ([StructLiteralField(name=field_name, value=value_text)])
    if not fatal  and  close_index >= 0:
        remainder = trim_text(substring(trimmed, close_index + 1, len(trimmed)))
        if len(remainder) > 0:
            diagnostics = append_string(diagnostics, "llvm lowering: enum literal trailing content `" + remainder + "`")
            fatal = True
    if fatal:
        fields = []
    return EnumLiteralParse(recognized=True, success=not fatal, enum_name=enum_name_part, variant_name=variant_name_part, fields=fields, diagnostics=diagnostics)

def lower_struct_literal(parse, bindings, locals, temp_index, lines, functions, context, expected_type):
    # effects: io
    diagnostics = parse.diagnostics
    current_lines = lines
    current_temp = temp_index
    collected_string_constants = empty_string_constant_set()
    info = resolve_struct_info_for_literal(context, parse.type_name)
    if info == None:
        if len(parse.type_name) > 0:
            diagnostics = append_string(diagnostics, "llvm lowering: struct literal references unknown struct `" + parse.type_name + "`")
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: struct literal references unknown struct")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    if len(info.fields) == 0:
        operand = LLVMOperand(llvm_type=info.llvm_name, value="zeroinitializer")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)
    used_names = []
    previous_value = ""
    field_index = 0
    while True:
        if field_index >= len(info.fields):
            break
        expected = info.fields[field_index]
        literal_index = -1
        literal_lookup_index = 0
        while True:
            if literal_lookup_index >= len(parse.fields):
                break
            if parse.fields[literal_lookup_index].name == expected.name:
                literal_index = literal_lookup_index
                break
            literal_lookup_index += 1
        value_operand = None
        if literal_index >= 0:
            literal_field = parse.fields[literal_index]
            if expected.name == "string_constants":
                local_names = []
                local_idx = 0
                while True:
                    if local_idx >= len(locals):
                        break
                    local_names = append_string(local_names, locals[local_idx].name)
                    local_idx += 1
                print.info("[sfn-debug] lower_struct_literal locals=" + join_strings(local_names, ", "))
            lowered = lower_expression(literal_field.value, bindings, locals, current_temp, current_lines, functions, context, expected.llvm_type)
            diagnostics = (diagnostics) + (lowered.diagnostics)
            current_lines = lowered.lines
            current_temp = lowered.temp_index
            collected_string_constants = merge_string_constants(collected_string_constants, lowered.string_constants)
            if lowered.operand != None:
                coerced = coerce_operand_to_type(lowered.operand, expected.llvm_type, current_temp, current_lines)
                diagnostics = (diagnostics) + (coerced.diagnostics)
                current_lines = coerced.lines
                current_temp = coerced.temp_index
                if coerced.operand != None:
                    value_operand = coerced.operand
            if not string_array_contains(used_names, expected.name):
                used_names = append_string(used_names, expected.name)
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: struct literal for `" + info.name + "` missing field `" + expected.name + "`")
        value_text = default_return_literal(expected.llvm_type)
        if value_operand != None:
            value_text = value_operand.value
        aggregate_source = "undef"
        if field_index > 0:
            aggregate_source = previous_value
        temp_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + temp_name + " = insertvalue " + info.llvm_name + " " + aggregate_source + ", " + expected.llvm_type + " " + value_text + ", " + number_to_string(field_index))
        current_temp += 1
        previous_value = temp_name
        field_index += 1
    extra_index = 0
    while True:
        if extra_index >= len(parse.fields):
            break
        literal_field = parse.fields[extra_index]
        if not string_array_contains(used_names, literal_field.name):
            diagnostics = append_string(diagnostics, "llvm lowering: struct literal for `" + info.name + "` provides unknown field `" + literal_field.name + "`")
        extra_index += 1
    if len(previous_value) == 0:
        operand = LLVMOperand(llvm_type=info.llvm_name, value="zeroinitializer")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)
    operand = LLVMOperand(llvm_type=info.llvm_name, value=previous_value)
    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)

def box_aggregate_operand(operand, expected_pointer_type, temp_index, lines, context):
    diagnostics = []
    current_lines = lines
    current_temp = temp_index
    allocation = lookup_allocation_info(context, operand.llvm_type)
    if allocation == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to allocate heap storage for `" + operand.llvm_type + "` when assigning to `" + expected_pointer_type + "`")
        return HeapBoxResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics)
    if allocation.size <= 0:
        diagnostics = append_string(diagnostics, "llvm lowering: computed heap allocation size for `" + operand.llvm_type + "` is zero")
        return HeapBoxResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics)
    malloc_temp = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + malloc_temp + " = call noalias i8* @malloc(i64 " + number_to_string(allocation.size) + ")")
    typed_ptr_temp = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + typed_ptr_temp + " = bitcast i8* " + malloc_temp + " to " + operand.llvm_type + "*")
    current_lines = append_string(current_lines, "  store " + operand.llvm_type + " " + operand.value + ", " + operand.llvm_type + "* " + typed_ptr_temp)
    pointer_operand = LLVMOperand(llvm_type="i8*", value=malloc_temp)
    trimmed_expected = trim_text(expected_pointer_type)
    if len(trimmed_expected) > 0  and  trimmed_expected != "i8*":
        cast_temp = format_temp_name(current_temp)
        current_temp += 1
        current_lines = append_string(current_lines, "  " + cast_temp + " = bitcast i8* " + malloc_temp + " to " + trimmed_expected)
        pointer_operand = LLVMOperand(llvm_type=trimmed_expected, value=cast_temp)
    return HeapBoxResult(lines=current_lines, temp_index=current_temp, operand=pointer_operand, diagnostics=diagnostics)

def lower_enum_literal(parse, bindings, locals, temp_index, lines, functions, context, expected_type):
    diagnostics = parse.diagnostics
    current_lines = lines
    current_temp = temp_index
    collected_string_constants = empty_string_constant_set()
    enum_info = resolve_enum_info_for_literal(context, parse.enum_name)
    if enum_info == None:
        if len(parse.enum_name) > 0:
            diagnostics = append_string(diagnostics, "llvm lowering: enum literal references unknown enum `" + parse.enum_name + "`")
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: enum literal references unknown enum")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    variant_info = resolve_enum_variant_info(enum_info, parse.variant_name)
    if variant_info == None:
        diagnostics = append_string(diagnostics, "llvm lowering: enum `" + parse.enum_name + "` has no variant `" + parse.variant_name + "`")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    tag_llvm_type = "i32"
    if enum_info.tag_type == "i8":
        tag_llvm_type = "i8"
    if enum_info.tag_type == "i16":
        tag_llvm_type = "i16"
    if enum_info.tag_type == "i32":
        tag_llvm_type = "i32"
    if enum_info.tag_type == "i64":
        tag_llvm_type = "i64"
    enum_value = "undef"
    enum_alloca = None
    if len(variant_info.fields) > 0:
        alloca_temp = format_temp_name(current_temp)
        current_temp += 1
        current_lines = append_string(current_lines, "  " + alloca_temp + " = alloca " + enum_info.llvm_name)
        enum_alloca = alloca_temp
        tag_ptr_temp = format_temp_name(current_temp)
        current_temp += 1
        current_lines = append_string(current_lines, "  " + tag_ptr_temp + " = getelementptr inbounds " + enum_info.llvm_name + ", " + enum_info.llvm_name + "* " + alloca_temp + ", i32 0, i32 0")
        current_lines = append_string(current_lines, "  store " + tag_llvm_type + " " + number_to_string(variant_info.tag) + ", " + tag_llvm_type + "* " + tag_ptr_temp)
    else:
        tag_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + tag_temp + " = insertvalue " + enum_info.llvm_name + " " + enum_value + ", " + tag_llvm_type + " " + number_to_string(variant_info.tag) + ", 0")
        current_temp += 1
        enum_value = tag_temp
    if len(variant_info.fields) > 0:
        alloca_ptr = enum_alloca
        used_names = []
        field_index = 0
        while True:
            if field_index >= len(variant_info.fields):
                break
            expected = variant_info.fields[field_index]
            literal_index = -1
            literal_lookup_index = 0
            while True:
                if literal_lookup_index >= len(parse.fields):
                    break
                if parse.fields[literal_lookup_index].name == expected.name:
                    literal_index = literal_lookup_index
                    break
                literal_lookup_index += 1
            if literal_index >= 0:
                literal_field = parse.fields[literal_index]
                lowered = lower_expression(literal_field.value, bindings, locals, current_temp, current_lines, functions, context, expected.llvm_type)
                diagnostics = (diagnostics) + (lowered.diagnostics)
                current_lines = lowered.lines
                current_temp = lowered.temp_index
                if lowered.operand != None:
                    field_operand = lowered.operand
                    if ends_with_pointer_suffix(expected.llvm_type)  and  not ends_with_pointer_suffix(field_operand.llvm_type):
                        boxed = box_aggregate_operand(field_operand, expected.llvm_type, current_temp, current_lines, context)
                        diagnostics = (diagnostics) + (boxed.diagnostics)
                        current_lines = boxed.lines
                        current_temp = boxed.temp_index
                        if boxed.operand != None:
                            field_operand = boxed.operand
                    coerced = coerce_operand_to_type(field_operand, expected.llvm_type, current_temp, current_lines)
                    diagnostics = (diagnostics) + (coerced.diagnostics)
                    current_lines = coerced.lines
                    current_temp = coerced.temp_index
                    if coerced.operand != None  and  alloca_ptr != None:
                        payload_ptr_temp = format_temp_name(current_temp)
                        current_temp += 1
                        current_lines = append_string(current_lines, "  " + payload_ptr_temp + " = getelementptr inbounds " + enum_info.llvm_name + ", " + enum_info.llvm_name + "* " + alloca_ptr + ", i32 0, i32 1")
                        byte_array_ptr_temp = format_temp_name(current_temp)
                        current_temp += 1
                        current_lines = append_string(current_lines, "  " + byte_array_ptr_temp + " = bitcast [" + number_to_string(variant_info.size) + " x i8]* " + payload_ptr_temp + " to i8*")
                        field_absolute_offset = variant_info.fields[field_index].offset
                        field_offset_in_payload = field_absolute_offset - variant_info.offset
                        field_byte_ptr_temp = byte_array_ptr_temp
                        if field_offset_in_payload > 0:
                            offset_ptr_temp = format_temp_name(current_temp)
                            current_temp += 1
                            current_lines = append_string(current_lines, "  " + offset_ptr_temp + " = getelementptr inbounds i8, i8* " + byte_array_ptr_temp + ", i64 " + number_to_string(field_offset_in_payload))
                            field_byte_ptr_temp = offset_ptr_temp
                        field_ptr_temp = format_temp_name(current_temp)
                        current_temp += 1
                        current_lines = append_string(current_lines, "  " + field_ptr_temp + " = bitcast i8* " + field_byte_ptr_temp + " to " + expected.llvm_type + "*")
                        current_lines = append_string(current_lines, "  store " + expected.llvm_type + " " + coerced.operand.value + ", " + expected.llvm_type + "* " + field_ptr_temp)
                if not string_array_contains(used_names, expected.name):
                    used_names = append_string(used_names, expected.name)
            else:
                diagnostics = append_string(diagnostics, "llvm lowering: enum literal for `" + parse.enum_name + "." + parse.variant_name + "` missing field `" + expected.name + "`")
            field_index += 1
        extra_index = 0
        while True:
            if extra_index >= len(parse.fields):
                break
            literal_field = parse.fields[extra_index]
            if not string_array_contains(used_names, literal_field.name):
                diagnostics = append_string(diagnostics, "llvm lowering: enum literal for `" + parse.enum_name + "." + parse.variant_name + "` provides unknown field `" + literal_field.name + "`")
            extra_index += 1
        if alloca_ptr != None:
            load_temp = format_temp_name(current_temp)
            current_temp += 1
            current_lines = append_string(current_lines, "  " + load_temp + " = load " + enum_info.llvm_name + ", " + enum_info.llvm_name + "* " + alloca_ptr)
            enum_value = load_temp
    operand = LLVMOperand(llvm_type=enum_info.llvm_name, value=enum_value)
    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)

def emit_comparison_instruction(symbol, left_operand, right_operand, temp_index, lines):
    diagnostics = []
    current_lines = lines
    if left_operand.llvm_type != right_operand.llvm_type:
        diagnostics = append_string(diagnostics, "llvm lowering: comparison operands have mismatched types `" + left_operand.llvm_type + "` and `" + right_operand.llvm_type + "`")
    symbol_is_equality = symbol == "=="  or  symbol == "!="
    left_is_string = is_string_pointer_type(left_operand.llvm_type)
    right_is_string = is_string_pointer_type(right_operand.llvm_type)
    left_is_null = left_operand.value == "null"
    right_is_null = right_operand.value == "null"
    if symbol_is_equality  and  left_is_string  and  right_is_string  and  not left_is_null  and  not right_is_null:
        compare_temp = format_temp_name(temp_index)
        current_lines = append_string(current_lines, "  " + compare_temp + " = call i1 @strings_equal(i8* " + left_operand.value + ", i8* " + right_operand.value + ")")
        next_index = temp_index + 1
        operand = LLVMOperand(llvm_type="i1", value=compare_temp)
        if symbol == "!=":
            inverted_temp = format_temp_name(next_index)
            current_lines = append_string(current_lines, "  " + inverted_temp + " = xor i1 " + compare_temp + ", true")
            operand = LLVMOperand(llvm_type="i1", value=inverted_temp)
            next_index += 1
        return ComparisonEmission(lines=current_lines, temp_index=next_index, operand=operand, diagnostics=diagnostics)
    llvm_type = left_operand.llvm_type
    predicate = comparison_predicate_for_symbol(symbol, llvm_type)
    if len(predicate) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: unsupported comparison operator `" + symbol + "` for type `" + llvm_type + "`")
        return ComparisonEmission(lines=current_lines, temp_index=temp_index, operand=None, diagnostics=diagnostics)
    temp_name = format_temp_name(temp_index)
    current_lines = append_string(current_lines, "  " + temp_name + " = " + predicate + " " + llvm_type + " " + left_operand.value + ", " + right_operand.value)
    operand = LLVMOperand(llvm_type="i1", value=temp_name)
    return ComparisonEmission(lines=current_lines, temp_index=temp_index + 1, operand=operand, diagnostics=diagnostics)

def emit_boolean_and(left_operand, right_operand, temp_index, lines):
    diagnostics = []
    current_lines = lines
    if left_operand.llvm_type != "i1":
        diagnostics = append_string(diagnostics, "llvm lowering: expected boolean operand for `and`, found `" + left_operand.llvm_type + "`")
    if right_operand.llvm_type != "i1":
        diagnostics = append_string(diagnostics, "llvm lowering: expected boolean operand for `and`, found `" + right_operand.llvm_type + "`")
    temp_name = format_temp_name(temp_index)
    current_lines = append_string(current_lines, "  " + temp_name + " = and i1 " + left_operand.value + ", " + right_operand.value)
    operand = LLVMOperand(llvm_type="i1", value=temp_name)
    return ComparisonEmission(lines=current_lines, temp_index=temp_index + 1, operand=operand, diagnostics=diagnostics)

def comparison_predicate_for_symbol(symbol, llvm_type):
    if llvm_type == "double":
        if symbol == "==":
            return "fcmp oeq"
        if symbol == "!=":
            return "fcmp une"
        if symbol == "<":
            return "fcmp olt"
        if symbol == "<=":
            return "fcmp ole"
        if symbol == ">":
            return "fcmp ogt"
        if symbol == ">=":
            return "fcmp oge"
        return ""
    if llvm_type == "i32"  or  llvm_type == "i64":
        if symbol == "==":
            return "icmp eq"
        if symbol == "!=":
            return "icmp ne"
        if symbol == "<":
            return "icmp slt"
        if symbol == "<=":
            return "icmp sle"
        if symbol == ">":
            return "icmp sgt"
        if symbol == ">=":
            return "icmp sge"
        return ""
    if llvm_type == "i1":
        if symbol == "==":
            return "icmp eq"
        if symbol == "!=":
            return "icmp ne"
        return ""
    if llvm_type == "i8":
        if symbol == "==":
            return "icmp eq"
        if symbol == "!=":
            return "icmp ne"
        if symbol == "<":
            return "icmp slt"
        if symbol == "<=":
            return "icmp sle"
        if symbol == ">":
            return "icmp sgt"
        if symbol == ">=":
            return "icmp sge"
        return ""
    if ends_with_pointer_suffix(llvm_type):
        if symbol == "==":
            return "icmp eq"
        if symbol == "!=":
            return "icmp ne"
        if llvm_type == "i8*":
            if symbol == "<":
                return "icmp ult"
            if symbol == "<=":
                return "icmp ule"
            if symbol == ">":
                return "icmp ugt"
            if symbol == ">=":
                return "icmp uge"
        return ""
    return ""

def is_string_pointer_type(llvm_type):
    if llvm_type == "i8*":
        return True
    return False

def collect_parameter_types(context, parameters):
    types = []
    index = 0
    while True:
        if index >= len(parameters):
            break
        llvm_type = map_parameter_type(context, parameters[index].type_annotation)
        if len(llvm_type) == 0:
            types = append_string(types, "double")
        else:
            types = append_string(types, llvm_type)
        index += 1
    return types

def load_local_operand(local, temp_index, lines):
    diagnostics = []
    load_name = format_temp_name(temp_index)
    current_lines = lines
    current_lines = append_string(current_lines, "  " + load_name + " = load " + local.llvm_type + ", " + local.llvm_type + "* " + local.pointer)
    operand = LLVMOperand(llvm_type=local.llvm_type, value=load_name)
    return LoadLocalResult(lines=current_lines, temp_index=temp_index + 1, operand=operand, diagnostics=diagnostics)

def coerce_operand_to_type(operand, target_type, temp_index, lines):
    diagnostics = []
    current_lines = lines
    if len(target_type) == 0:
        return CoercionResult(lines=current_lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics)
    if operand.llvm_type == target_type:
        return CoercionResult(lines=current_lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics)
    if not ends_with_pointer_suffix(target_type)  and  ends_with_pointer_suffix(operand.llvm_type):
        source_base = strip_pointer_suffix(operand.llvm_type)
        if source_base == target_type:
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = load " + target_type + ", " + operand.llvm_type + " " + operand.value)
            coerced = LLVMOperand(llvm_type=target_type, value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
    if target_type == "double":
        if operand.llvm_type == "i64":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = sitofp i64 " + operand.value + " to double")
            coerced = LLVMOperand(llvm_type="double", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
        if operand.llvm_type == "i1":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = uitofp i1 " + operand.value + " to double")
            coerced = LLVMOperand(llvm_type="double", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
    if target_type == "i64":
        if operand.llvm_type == "double":
            round_temp = format_temp_name(temp_index)
            convert_temp = format_temp_name(temp_index + 1)
            current_lines = append_string(current_lines, "  " + round_temp + " = call double @llvm.round.f64(double " + operand.value + ")")
            current_lines = append_string(current_lines, "  " + convert_temp + " = fptosi double " + round_temp + " to i64")
            coerced = LLVMOperand(llvm_type="i64", value=convert_temp)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 2, operand=coerced, diagnostics=diagnostics)
        if operand.llvm_type == "i1":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = zext i1 " + operand.value + " to i64")
            coerced = LLVMOperand(llvm_type="i64", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
        if operand.llvm_type == "i8":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = sext i8 " + operand.value + " to i64")
            coerced = LLVMOperand(llvm_type="i64", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
    if target_type == "i1":
        if operand.llvm_type == "double":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = fcmp one double " + operand.value + ", 0.0")
            coerced = LLVMOperand(llvm_type="i1", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
        if operand.llvm_type == "i64":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = icmp ne i64 " + operand.value + ", 0")
            coerced = LLVMOperand(llvm_type="i1", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
    if target_type == "i8"  and  operand.llvm_type == "i8*":
        char_ptr_temp = format_temp_name(temp_index)
        char_value_temp = format_temp_name(temp_index + 1)
        current_lines = append_string(current_lines, "  " + char_ptr_temp + " = getelementptr i8, i8* " + operand.value + ", i64 0")
        current_lines = append_string(current_lines, "  " + char_value_temp + " = load i8, i8* " + char_ptr_temp)
        coerced = LLVMOperand(llvm_type="i8", value=char_value_temp)
        return CoercionResult(lines=current_lines, temp_index=temp_index + 2, operand=coerced, diagnostics=diagnostics)
    if target_type == "i8*"  and  operand.llvm_type == "i8":
        alloca_temp = format_temp_name(temp_index)
        char_ptr = format_temp_name(temp_index + 1)
        null_ptr = format_temp_name(temp_index + 2)
        result_ptr = format_temp_name(temp_index + 3)
        current_lines = append_string(current_lines, "  " + alloca_temp + " = alloca [2 x i8], align 1")
        current_lines = append_string(current_lines, "  " + char_ptr + " = getelementptr [2 x i8], [2 x i8]* " + alloca_temp + ", i32 0, i32 0")
        current_lines = append_string(current_lines, "  store i8 " + operand.value + ", i8* " + char_ptr)
        current_lines = append_string(current_lines, "  " + null_ptr + " = getelementptr [2 x i8], [2 x i8]* " + alloca_temp + ", i32 0, i32 1")
        current_lines = append_string(current_lines, "  store i8 0, i8* " + null_ptr)
        current_lines = append_string(current_lines, "  " + result_ptr + " = getelementptr [2 x i8], [2 x i8]* " + alloca_temp + ", i32 0, i32 0")
        coerced = LLVMOperand(llvm_type="i8*", value=result_ptr)
        return CoercionResult(lines=current_lines, temp_index=temp_index + 4, operand=coerced, diagnostics=diagnostics)
    if target_type == "i8*"  and  ends_with_pointer_suffix(operand.llvm_type):
        temp_name = format_temp_name(temp_index)
        current_lines = append_string(current_lines, "  " + temp_name + " = bitcast " + operand.llvm_type + " " + operand.value + " to i8*")
        coerced = LLVMOperand(llvm_type="i8*", value=temp_name)
        return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
    if operand.llvm_type == "i8*"  and  ends_with_pointer_suffix(target_type):
        temp_name = format_temp_name(temp_index)
        current_lines = append_string(current_lines, "  " + temp_name + " = bitcast i8* " + operand.value + " to " + target_type)
        coerced = LLVMOperand(llvm_type=target_type, value=temp_name)
        return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
    if not ends_with_pointer_suffix(operand.llvm_type)  and  ends_with_pointer_suffix(target_type):
        expected_value_type = strip_pointer_suffix(target_type)
        if expected_value_type == operand.llvm_type:
            alloca_temp = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + alloca_temp + " = alloca " + operand.llvm_type)
            current_lines = append_string(current_lines, "  store " + operand.llvm_type + " " + operand.value + ", " + target_type + " " + alloca_temp)
            coerced = LLVMOperand(llvm_type=target_type, value=alloca_temp)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
    if ends_with_pointer_suffix(operand.llvm_type)  and  ends_with_pointer_suffix(target_type):
        source_element = array_pointer_element_type(operand.llvm_type)
        target_element = array_pointer_element_type(target_type)
        if len(source_element) > 0  and  len(target_element) > 0:
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = bitcast " + operand.llvm_type + " " + operand.value + " to " + target_type)
            coerced = LLVMOperand(llvm_type=target_type, value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
        temp_name = format_temp_name(temp_index)
        current_lines = append_string(current_lines, "  " + temp_name + " = bitcast " + operand.llvm_type + " " + operand.value + " to " + target_type)
        coerced = LLVMOperand(llvm_type=target_type, value=temp_name)
        return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
    if operand.value == "null"  and  ends_with_pointer_suffix(target_type):
        coerced = LLVMOperand(llvm_type=target_type, value="null")
        return CoercionResult(lines=current_lines, temp_index=temp_index, operand=coerced, diagnostics=diagnostics)
    if operand.value == "null"  and  not ends_with_pointer_suffix(target_type):
        literal = default_return_literal(target_type)
        coerced = LLVMOperand(llvm_type=target_type, value=literal)
        return CoercionResult(lines=current_lines, temp_index=temp_index, operand=coerced, diagnostics=diagnostics)
    if not ends_with_pointer_suffix(target_type)  and  ends_with_pointer_suffix(operand.llvm_type):
        pointer_type = operand.llvm_type
        pointer_value = operand.value
        pointer_temp_index = temp_index
        base_type = strip_pointer_suffix(pointer_type)
        if base_type != target_type:
            desired_pointer_type = target_type + "*"
            bitcast_temp = format_temp_name(pointer_temp_index)
            current_lines = append_string(current_lines, "  " + bitcast_temp + " = bitcast " + pointer_type + " " + pointer_value + " to " + desired_pointer_type)
            pointer_type = desired_pointer_type
            pointer_value = bitcast_temp
            pointer_temp_index += 1
        load_temp = format_temp_name(pointer_temp_index)
        current_lines = append_string(current_lines, "  " + load_temp + " = load " + target_type + ", " + pointer_type + " " + pointer_value)
        coerced = LLVMOperand(llvm_type=target_type, value=load_temp)
        return CoercionResult(lines=current_lines, temp_index=pointer_temp_index + 1, operand=coerced, diagnostics=diagnostics)
    diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce operand of type `" + operand.llvm_type + "` to `" + target_type + "`")
    return CoercionResult(lines=current_lines, temp_index=temp_index, operand=None, diagnostics=diagnostics)

def dominant_type(first, second):
    if len(first) == 0:
        return second
    if len(second) == 0:
        return first
    if first == second:
        return first
    first_is_pointer = ends_with_pointer_suffix(first)
    second_is_pointer = ends_with_pointer_suffix(second)
    if first_is_pointer  and  not second_is_pointer:
        return first
    if second_is_pointer  and  not first_is_pointer:
        return second
    if first_is_pointer  and  second_is_pointer:
        return first
    if first == "double"  or  second == "double":
        return "double"
    if first == "i64"  or  second == "i64":
        return "i64"
    if first == "i8"  and  second == "i64"  or  first == "i64"  and  second == "i8":
        return "i64"
    if first == "i1"  or  second == "i1":
        return "i1"
    return first

def harmonise_operands(left, right, temp_index, lines):
    diagnostics = []
    current_lines = lines
    current_temp = temp_index
    left_operand = left
    right_operand = right
    if left_operand.value == "null"  and  ends_with_pointer_suffix(right_operand.llvm_type):
        left_operand = LLVMOperand(llvm_type=right_operand.llvm_type, value="null")
    if right_operand.value == "null"  and  ends_with_pointer_suffix(left_operand.llvm_type):
        right_operand = LLVMOperand(llvm_type=left_operand.llvm_type, value="null")
    if left_operand.llvm_type == right_operand.llvm_type:
        return BinaryAlignmentResult(lines=current_lines, temp_index=current_temp, left=left_operand, right=right_operand, diagnostics=diagnostics, result_type=left_operand.llvm_type)
    target_type = dominant_type(left_operand.llvm_type, right_operand.llvm_type)
    left_coercion = coerce_operand_to_type(left_operand, target_type, current_temp, current_lines)
    diagnostics = (diagnostics) + (left_coercion.diagnostics)
    if left_coercion.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to convert left operand from `" + left_operand.llvm_type + "` to `" + target_type + "`")
        return BinaryAlignmentResult(lines=left_coercion.lines, temp_index=left_coercion.temp_index, left=None, right=None, diagnostics=diagnostics, result_type=target_type)
    left_operand = left_coercion.operand
    current_lines = left_coercion.lines
    current_temp = left_coercion.temp_index
    right_coercion = coerce_operand_to_type(right_operand, target_type, current_temp, current_lines)
    diagnostics = (diagnostics) + (right_coercion.diagnostics)
    if right_coercion.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to convert right operand from `" + right_operand.llvm_type + "` to `" + target_type + "`")
        return BinaryAlignmentResult(lines=right_coercion.lines, temp_index=right_coercion.temp_index, left=None, right=None, diagnostics=diagnostics, result_type=target_type)
    right_operand = right_coercion.operand
    current_lines = right_coercion.lines
    current_temp = right_coercion.temp_index
    return BinaryAlignmentResult(lines=current_lines, temp_index=current_temp, left=left_operand, right=right_operand, diagnostics=diagnostics, result_type=target_type)

def strip_enclosing_parentheses(expression):
    trimmed = trim_text(expression)
    if len(trimmed) < 2:
        return trimmed
    if trimmed[0] != "("  or  trimmed[len(trimmed) - 1] != ")":
        return trimmed
    depth = 0
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if ch == "(":
            depth += 1
        else:
            if ch == ")":
                depth -= 1
                if depth == 0:
                    if index == len(trimmed) - 1:
                        inner = substring(trimmed, 1, len(trimmed) - 1)
                        return strip_enclosing_parentheses(inner)
                    return trimmed
        index += 1
    return trimmed

def find_top_level_operator(expression, operators):
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    angle_depth = 0
    in_single = False
    in_double = False
    escape_next = False
    candidate_index = -1
    candidate_symbol = ""
    index = 0
    while True:
        if index >= len(expression):
            break
        ch = expression[index]
        if in_double:
            if escape_next:
                escape_next = False
                index += 1
                continue
            if ch == "\\":
                escape_next = True
                index += 1
                continue
            if ch == "\"":
                in_double = False
            index += 1
            continue
        if in_single:
            if escape_next:
                escape_next = False
                index += 1
                continue
            if ch == "\\":
                escape_next = True
                index += 1
                continue
            if ch == "'":
                in_single = False
            index += 1
            continue
        if ch == "\"":
            in_double = True
            index += 1
            continue
        if ch == "'":
            in_single = True
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
        if ch == "<":
            angle_depth += 1
            index += 1
            continue
        if ch == ">":
            if angle_depth > 0:
                angle_depth -= 1
            index += 1
            continue
        if paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0  and  angle_depth == 0  and  contains_char(operators, ch):
            if ch == "-":
                if is_binary_minus(expression, index):
                    candidate_index = index
                    candidate_symbol = substring(expression, index, index + 1)
            else:
                candidate_index = index
                candidate_symbol = substring(expression, index, index + 1)
        index += 1
    if candidate_index >= 0:
        return OperatorMatch(index=candidate_index, symbol=candidate_symbol, success=True)
    return OperatorMatch(index=-1, symbol="", success=False)

def find_comparison_operator(expression):
    depth = 0
    index = 0
    in_string = False
    escape_next = False
    while True:
        if index >= len(expression):
            break
        ch = expression[index]
        if in_string:
            if escape_next:
                escape_next = False
                index += 1
                continue
            if ch == "\\":
                escape_next = True
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
            depth += 1
            index += 1
            continue
        if ch == ")":
            if depth > 0:
                depth -= 1
            index += 1
            continue
        if depth > 0:
            index += 1
            continue
        if index + 1 < len(expression):
            two = substring(expression, index, index + 2)
            if two == "=="  or  two == "!="  or  two == "<="  or  two == ">=":
                return OperatorMatch(index=index, symbol=two, success=True)
        if ch == "<"  or  ch == ">":
            return OperatorMatch(index=index, symbol=substring(expression, index, index + 1), success=True)
        index += 1
    return OperatorMatch(index=-1, symbol="", success=False)

def find_logical_operator(expression):
    depth = 0
    index = 0
    in_string = False
    escape_next = False
    while True:
        if index + 1 >= len(expression):
            break
        ch = expression[index]
        if in_string:
            if escape_next:
                escape_next = False
                index += 1
                continue
            if ch == "\\":
                escape_next = True
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
            depth += 1
            index += 1
            continue
        if ch == ")":
            if depth > 0:
                depth -= 1
            index += 1
            continue
        if depth == 0:
            two = substring(expression, index, index + 2)
            if two == "||":
                return OperatorMatch(index=index, symbol="||", success=True)
        index += 1
    depth = 0
    index = 0
    in_string = False
    escape_next = False
    while True:
        if index + 1 >= len(expression):
            break
        ch = expression[index]
        if in_string:
            if escape_next:
                escape_next = False
                index += 1
                continue
            if ch == "\\":
                escape_next = True
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
            depth += 1
            index += 1
            continue
        if ch == ")":
            if depth > 0:
                depth -= 1
            index += 1
            continue
        if depth == 0:
            two = substring(expression, index, index + 2)
            if two == "&&":
                return OperatorMatch(index=index, symbol="&&", success=True)
        index += 1
    return OperatorMatch(index=-1, symbol="", success=False)

def contains_char(set, ch):
    index = 0
    while True:
        if index >= len(set):
            break
        if set[index] == ch:
            return True
        index += 1
    return False

def is_binary_minus(expression, index):
    previous = find_previous_non_space_char(expression, index)
    next = find_next_non_space_char(expression, index)
    if previous == None:
        return False
    prev_char = previous
    if prev_char == "+"  or  prev_char == "-"  or  prev_char == "*"  or  prev_char == "/"  or  prev_char == "("  or  prev_char == ",":
        return False
    if next == None:
        return False
    next_char = next
    if next_char == "+"  or  next_char == "-"  or  next_char == "*"  or  next_char == "/"  or  next_char == ")"  or  next_char == ",":
        return False
    return True

def find_previous_non_space_char(value, index):
    position = index
    while True:
        if position <= 0:
            break
        position -= 1
        ch = value[position]
        if not is_trim_char(ch):
            return ch
    return None

def find_next_non_space_char(value, index):
    position = index + 1
    while True:
        if position >= len(value):
            break
        ch = value[position]
        if not is_trim_char(ch):
            return ch
        position += 1
    return None

def find_call_site(expression):
    depth = 0
    index = 0
    while True:
        if index >= len(expression):
            break
        ch = expression[index]
        if ch == "(":
            if depth == 0:
                return index
            depth += 1
        else:
            if ch == ")":
                if depth > 0:
                    depth -= 1
        index += 1
    return -1

def split_call_arguments(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return []
    entries = []
    current = ""
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    in_single = False
    in_double = False
    escape = False
    index = 0
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if in_double:
            current = current + ch
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "\"":
                        in_double = False
            index += 1
            continue
        if in_single:
            current = current + ch
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "'":
                        in_single = False
            index += 1
            continue
        if ch == "\"":
            in_double = True
            current = current + ch
            index += 1
            continue
        if ch == "'":
            in_single = True
            current = current + ch
            index += 1
            continue
        if ch == "(":
            paren_depth += 1
            current = current + ch
        else:
            if ch == ")":
                if paren_depth > 0:
                    paren_depth -= 1
                current = current + ch
            else:
                if ch == "[":
                    bracket_depth += 1
                    current = current + ch
                else:
                    if ch == "]":
                        if bracket_depth > 0:
                            bracket_depth -= 1
                        current = current + ch
                    else:
                        if ch == "{":
                            brace_depth += 1
                            current = current + ch
                        else:
                            if ch == "}":
                                if brace_depth > 0:
                                    brace_depth -= 1
                                current = current + ch
                            else:
                                if ch == ","  and  paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0:
                                    entries = append_string(entries, trim_text(current))
                                    current = ""
                                else:
                                    current = current + ch
        index += 1
    entries = append_string(entries, trim_text(current))
    return entries

def split_array_elements(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return []
    entries = []
    current = ""
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    index = 0
    in_single = False
    in_double = False
    escape = False
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if in_double:
            current = current + ch
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "\"":
                        in_double = False
            index += 1
            continue
        if in_single:
            current = current + ch
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "'":
                        in_single = False
            index += 1
            continue
        if ch == "\"":
            in_double = True
            current = current + ch
            index += 1
            continue
        if ch == "'":
            in_single = True
            current = current + ch
            index += 1
            continue
        if ch == "(":
            paren_depth += 1
        else:
            if ch == ")":
                if paren_depth > 0:
                    paren_depth -= 1
            else:
                if ch == "[":
                    bracket_depth += 1
                else:
                    if ch == "]":
                        if bracket_depth > 0:
                            bracket_depth -= 1
                    else:
                        if ch == "{":
                            brace_depth += 1
                        else:
                            if ch == "}":
                                if brace_depth > 0:
                                    brace_depth -= 1
        if ch == ","  and  paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0:
            entries = append_string(entries, trim_text(current))
            current = ""
        else:
            current = current + ch
        index += 1
    if len(current) > 0:
        entries = append_string(entries, trim_text(current))
    filtered = []
    index = 0
    while True:
        if index >= len(entries):
            break
        entry = trim_text(entries[index])
        if len(entry) > 0:
            filtered = append_string(filtered, entry)
        index += 1
    return filtered

def parse_array_literal_metadata(entries, context):
    if len(entries) == 0:
        return ArrayLiteralMetadata(element_type="", start_index=0)
    first = trim_text(entries[0])
    if len(first) < 9:
        return ArrayLiteralMetadata(element_type="", start_index=0)
    prefix = substring(first, 0, 9)
    if prefix != "#element:":
        return ArrayLiteralMetadata(element_type="", start_index=0)
    annotation = trim_text(substring(first, 9, len(first)))
    if len(annotation) == 0:
        return ArrayLiteralMetadata(element_type="", start_index=1)
    mapped = map_metadata_annotation(context, annotation)
    return ArrayLiteralMetadata(element_type=mapped, start_index=1)

def map_metadata_annotation(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    primitive = map_primitive_type(context, trimmed)
    if len(primitive) > 0:
        return primitive
    if len(trimmed) > 2:
        suffix = substring(trimmed, len(trimmed) - 2, len(trimmed))
        if suffix == "[]":
            inner_annotation = trim_text(substring(trimmed, 0, len(trimmed) - 2))
            inner_type = map_metadata_annotation(context, inner_annotation)
            if len(inner_type) == 0:
                return ""
            struct_type = array_struct_type_for_element(inner_type)
            return struct_type + "*"
    return ""

def operation_name_for_symbol(symbol, llvm_type):
    if llvm_type == "double":
        if symbol == "+":
            return "fadd"
        if symbol == "-":
            return "fsub"
        if symbol == "*":
            return "fmul"
        if symbol == "/":
            return "fdiv"
        if symbol == "%":
            return "frem"
    if symbol == "+":
        return "add"
    if symbol == "-":
        return "sub"
    if symbol == "*":
        return "mul"
    if symbol == "/":
        return "sdiv"
    if symbol == "%":
        return "srem"
    return "add"

def format_temp_name(index):
    return "%t" + number_to_string(index)

def format_local_pointer_name(index):
    return "%l" + number_to_string(index)

def format_typed_operand(operand):
    return operand.llvm_type + " " + operand.value

def ends_with_pointer_suffix(value):
    trimmed = trim_text(value)
    if len(trimmed) == 0:
        return False
    return trimmed[len(trimmed) - 1] == "*"

def strip_pointer_suffix(value):
    trimmed = trim_text(value)
    if len(trimmed) == 0:
        return trimmed
    if trimmed[len(trimmed) - 1] != "*":
        return trimmed
    return trim_text(substring(trimmed, 0, len(trimmed) - 1))

def is_copy_type(type_annotation, llvm_type):
    trimmed = trim_text(type_annotation)
    if starts_with(trimmed, "Affine<")  or  starts_with(trimmed, "Linear<"):
        return False
    if trimmed == "Affine"  or  trimmed == "Linear":
        return False
    if llvm_type == "double":
        return True
    if llvm_type == "i32":
        return True
    if llvm_type == "i64":
        return True
    if llvm_type == "i1":
        return True
    if ends_with_pointer_suffix(llvm_type):
        return True
    if len(trimmed) == 0:
        return True
    if trimmed[0] == "&":
        return True
    if starts_with(trimmed, "mut "):
        stripped = strip_mut_prefix(trimmed)
        if len(stripped) > 0:
            if stripped[0] == "&":
                return True
    return False

def default_return_literal(llvm_type):
    if llvm_type == "double":
        return "0.0"
    if llvm_type == "i32":
        return "0"
    if llvm_type == "i64":
        return "0"
    if llvm_type == "i1":
        return "false"
    if ends_with_pointer_suffix(llvm_type):
        return "null"
    return "zeroinitializer"

def starts_with(value, prefix):
    if len(prefix) == 0:
        return True
    if len(value) < len(prefix):
        return False
    head = substring(value, 0, len(prefix))
    return head == prefix

def contains_text(haystack, needle):
    if len(needle) == 0:
        return True
    if len(haystack) < len(needle):
        return False
    index = 0
    while True:
        if index + len(needle) > len(haystack):
            break
        candidate = substring(haystack, index, index + len(needle))
        if candidate == needle:
            return True
        index += 1
    return False

def strip_mut_prefix(value):
    trimmed = trim_text(value)
    if len(trimmed) < 4:
        return trimmed
    prefix = substring(trimmed, 0, 4)
    if prefix == "mut ":
        return trim_text(substring(trimmed, 4, len(trimmed)))
    return trimmed

def is_simple_identifier(value):
    trimmed = trim_text(value)
    if len(trimmed) == 0:
        return False
    first = trimmed[0]
    if first >= "0"  and  first <= "9":
        return False
    sanitized = sanitize_symbol(trimmed)
    if sanitized != trimmed:
        return False
    return True

def find_top_level_range_separator(value):
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    index = 0
    while True:
        if index >= len(value):
            break
        ch = value[index]
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
        if ch == ".":
            if index + 1 < len(value):
                if value[index + 1] == ".":
                    if paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0:
                        return index
        index += 1
    return -1

def find_top_level_range_separator_from(value, start_index):
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    index = 0
    while True:
        if index >= len(value):
            break
        ch = value[index]
        if ch == "(":
            paren_depth += 1
        else:
            if ch == ")":
                if paren_depth > 0:
                    paren_depth -= 1
            else:
                if ch == "[":
                    bracket_depth += 1
                else:
                    if ch == "]":
                        if bracket_depth > 0:
                            bracket_depth -= 1
                    else:
                        if ch == "{":
                            brace_depth += 1
                        else:
                            if ch == "}":
                                if brace_depth > 0:
                                    brace_depth -= 1
        if index >= start_index:
            if ch == ".":
                if index + 1 < len(value):
                    if value[index + 1] == ".":
                        if paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0:
                            return index
        index += 1
    return -1

def find_member_access_separator(value):
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    in_single = False
    in_double = False
    escape = False
    index = 0
    last_index = -1
    while True:
        if index >= len(value):
            break
        ch = value[index]
        if in_single:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "'":
                        in_single = False
            index += 1
            continue
        if in_double:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "\"":
                        in_double = False
            index += 1
            continue
        if ch == "'":
            in_single = True
            index += 1
            continue
        if ch == "\"":
            in_double = True
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
        if paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0:
            if ch == ".":
                if index > 0:
                    previous = value[index - 1]
                    if previous == ".":
                        index += 1
                        continue
                    if is_digit_char(previous):
                        if index + 1 < len(value):
                            next_digit = value[index + 1]
                            if is_digit_char(next_digit):
                                index += 1
                                continue
                if index + 1 < len(value):
                    next_char = value[index + 1]
                    if next_char == ".":
                        index += 1
                        continue
                last_index = index
        index += 1
    return last_index

def parse_member_access(expression):
    trimmed = trim_text(expression)
    if len(trimmed) == 0:
        return MemberAccessParse(success=False, base="", field="")
    separator = find_member_access_separator(trimmed)
    if separator < 0:
        return MemberAccessParse(success=False, base="", field="")
    base = trim_text(substring(trimmed, 0, separator))
    field = trim_text(substring(trimmed, separator + 1, len(trimmed)))
    if len(base) == 0  or  len(field) == 0:
        return MemberAccessParse(success=False, base="", field="")
    if not is_simple_identifier(field):
        return MemberAccessParse(success=False, base="", field="")
    return MemberAccessParse(success=True, base=base, field=field)

def parse_index_expression(expression):
    trimmed = trim_text(expression)
    if len(trimmed) == 0:
        return IndexExpressionParse(success=False, base="", index="")
    bracket_depth = 0
    index_position = -1
    i = len(trimmed) - 1
    if trimmed[len(trimmed) - 1] != "]":
        return IndexExpressionParse(success=False, base="", index="")
    bracket_depth = 1
    i = len(trimmed) - 2
    while True:
        if i < 0:
            break
        ch = trimmed[i]
        if ch == "]":
            bracket_depth += 1
        if ch == "[":
            bracket_depth -= 1
            if bracket_depth == 0:
                index_position = i
                break
        i -= 1
    if index_position < 0:
        return IndexExpressionParse(success=False, base="", index="")
    base = trim_text(substring(trimmed, 0, index_position))
    index = trim_text(substring(trimmed, index_position + 1, len(trimmed) - 1))
    if len(base) == 0  or  len(index) == 0:
        return IndexExpressionParse(success=False, base="", index="")
    return IndexExpressionParse(success=True, base=base, index=index)

def parse_range_iterable(iterable):
    trimmed = trim_text(iterable)
    diagnostics = []
    if len(trimmed) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` iterable expression is empty")
        return RangeIterableParse(success=False, start="", end="", stride="", diagnostics=diagnostics)
    first_separator = find_top_level_range_separator(trimmed)
    has_stride = False
    stride_text = ""
    if first_separator < 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` iterable must use `start..end` range syntax")
        return RangeIterableParse(success=False, start="", end="", stride="", diagnostics=diagnostics)
    second_separator = find_top_level_range_separator_from(trimmed, first_separator + 2)
    start_text = trim_text(substring(trimmed, 0, first_separator))
    end_text = trim_text(substring(trimmed, first_separator + 2, len(trimmed)))
    if second_separator >= 0:
        end_text = trim_text(substring(trimmed, first_separator + 2, second_separator))
        stride_text = trim_text(substring(trimmed, second_separator + 2, len(trimmed)))
        has_stride = len(stride_text) > 0
    if len(start_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` range missing start expression")
    if len(end_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` range missing end expression")
    if has_stride  and  len(stride_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` range missing stride expression")
    success = len(start_text) > 0  and  len(end_text) > 0  and  (not has_stride  or  len(stride_text) > 0)
    return RangeIterableParse(success=success, start=start_text, end=end_text, stride=stride_text, diagnostics=diagnostics)

def find_local_binding(locals, name):
    index = 0
    while True:
        if index >= len(locals):
            break
        entry = locals[index]
        if entry.name == name:
            return entry
        index += 1
    return None

def infer_borrow_base_scope(base, locals, bindings, function_name):
    local = find_local_binding(locals, base)
    if local != None:
        return ScopeMetadata(scope_id=local.scope_id, scope_depth=local.scope_depth)
    parameter = find_parameter_binding(bindings, base)
    if parameter != None:
        return ScopeMetadata(scope_id=format_root_scope_id(function_name), scope_depth=0)
    return ScopeMetadata(scope_id=format_root_scope_id(function_name), scope_depth=0)

def append_lifetime_region(values, value):
    return (values) + ([value])

def append_lifetime_release_event(events, event):
    return (events) + ([event])

def mark_lifetime_region_released(regions, region_id, scope_id, scope_depth):
    result = []
    index = 0
    while True:
        if index >= len(regions):
            break
        entry = regions[index]
        if entry.id == region_id:
            updated = LifetimeRegionMetadata(id=entry.id, binding=entry.binding, base=entry.base, mutable=entry.mutable, start_span=entry.start_span, scope_id=entry.scope_id, scope_depth=entry.scope_depth, base_scope_id=entry.base_scope_id, base_scope_depth=entry.base_scope_depth, end_scope_id=scope_id, end_scope_depth=scope_depth, released=True)
            result = append_lifetime_region(result, updated)
        else:
            result = append_lifetime_region(result, entry)
        index += 1
    return result

def apply_lifetime_release_events(regions, releases):
    if len(releases) == 0:
        return regions
    current_regions = regions
    index = 0
    while True:
        if index >= len(releases):
            break
        release = releases[index]
        current_regions = mark_lifetime_region_released(current_regions, release.region_id, release.scope_id, release.scope_depth)
        index += 1
    return current_regions

def make_lifetime_region_metadata(id, binding, ownership, scope_id, scope_depth, base_scope_id, base_scope_depth):
    return LifetimeRegionMetadata(id=id, binding=binding, base=ownership.base, mutable=ownership.mutable, start_span=ownership.span, scope_id=scope_id, scope_depth=scope_depth, base_scope_id=base_scope_id, base_scope_depth=base_scope_depth, end_scope_id="", end_scope_depth=0, released=False)

def format_root_scope_id(function_name):
    sanitized = sanitize_symbol(function_name)
    if len(sanitized) == 0:
        sanitized = "fn"
    return "fn:" + sanitized

def make_child_scope_id(parent, child):
    sanitized_child = sanitize_symbol(child)
    if len(sanitized_child) == 0:
        sanitized_child = "scope"
    if len(parent) == 0:
        return sanitized_child
    return parent + "::" + sanitized_child

def is_scope_descendant(parent, candidate):
    if len(parent) == 0:
        return True
    if len(candidate) == 0:
        return False
    if candidate == parent:
        return True
    prefix = parent + "::"
    if len(candidate) <= len(prefix):
        return False
    return starts_with(candidate, prefix)

def append_local_binding(values, value):
    return (values) + ([value])

def append_llvm_operand(values, value):
    return (values) + ([value])

def append_struct_literal_field(values, value):
    return (values) + ([value])

def append_native_struct(values, value):
    return (values) + ([value])

def append_native_enum(values, value):
    return (values) + ([value])

def replace_llvm_operand(values, index, value):
    result = []
    current = 0
    while True:
        if current >= len(values):
            break
        if current == index:
            result = append_llvm_operand(result, value)
        else:
            result = append_llvm_operand(result, values[current])
        current += 1
    return result

def replace_native_struct(values, index, value):
    result = []
    current = 0
    while True:
        if current >= len(values):
            break
        if current == index:
            result = append_native_struct(result, value)
        else:
            result = append_native_struct(result, values[current])
        current += 1
    return result

def replace_native_enum(values, index, value):
    result = []
    current = 0
    while True:
        if current >= len(values):
            break
        if current == index:
            result = append_native_enum(result, value)
        else:
            result = append_native_enum(result, values[current])
        current += 1
    return result

def find_function_by_name(functions, name):
    index = 0
    while True:
        if index >= len(functions):
            break
        if functions[index].name == name:
            return functions[index]
        index += 1
    return None

def find_struct_index(structs, name):
    index = 0
    while True:
        if index >= len(structs):
            break
        if structs[index].name == name:
            return index
        index += 1
    return -1

def find_enum_index(enums, name):
    index = 0
    while True:
        if index >= len(enums):
            break
        if enums[index].name == name:
            return index
        index += 1
    return -1

def number_to_string(value):
    if value == 0:
        return "0"
    digits = "0123456789"
    powers = [1000000000000000, 100000000000000, 10000000000000, 1000000000000, 100000000000, 10000000000, 1000000000, 100000000, 10000000, 1000000, 100000, 10000, 1000, 100, 10, 1]
    remaining = value
    is_negative = False
    if remaining < 0:
        is_negative = True
        remaining = 0 - remaining
    output = ""
    index = 0
    started = False
    while True:
        if index >= len(powers):
            break
        power = powers[index]
        count = 0
        while True:
            if remaining < power:
                break
            remaining -= power
            count += 1
        if started  or  count > 0:
            started = True
            ch = substring(digits, count, count + 1)
            output = output + ch
        index += 1
    if len(output) == 0:
        output = "0"
    if is_negative:
        return "-" + output
    return output

def lower_char_code(code):
    upper_a = char_code("A")
    upper_z = char_code("Z")
    if code >= upper_a  and  code <= upper_z:
        lower_a = char_code("a")
        return code + lower_a - upper_a
    return code

def matches_case_insensitive(value, expected):
    if len(value) != len(expected):
        return False
    index = 0
    while True:
        if index >= len(value):
            break
        value_ch = substring(value, index, index + 1)
        expected_ch = substring(expected, index, index + 1)
        value_code = lower_char_code(char_code(value_ch))
        expected_code = lower_char_code(char_code(expected_ch))
        if value_code != expected_code:
            return False
        index += 1
    return True

def is_boolean_literal(text):
    trimmed = trim_text(text)
    if matches_case_insensitive(trimmed, "true"):
        return True
    if matches_case_insensitive(trimmed, "false"):
        return True
    return False

def is_null_literal(text):
    trimmed = trim_text(text)
    if matches_case_insensitive(trimmed, "null"):
        return True
    return False

def is_digit_char(ch):
    if index_of("0123456789", ch) >= 0:
        return True
    return False

def is_integer_literal(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return False
    index = 0
    if trimmed[0] == "-":
        if len(trimmed) == 1:
            return False
        index = 1
    has_digit = False
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if ch >= "0"  and  ch <= "9":
            has_digit = True
            index += 1
            continue
        return False
    return has_digit

def is_number_literal(text):
    index = 0
    has_digit = False
    has_decimal = False
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return False
    if trimmed[0] == "-":
        if len(trimmed) == 1:
            return False
        index = 1
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if ch >= "0"  and  ch <= "9":
            has_digit = True
            index += 1
            continue
        if ch == ".":
            if has_decimal:
                return False
            has_decimal = True
            index += 1
            continue
        return False
    return has_digit

def normalise_number_literal(text):
    trimmed = trim_text(text)
    if index_of(trimmed, ".") >= 0:
        return trimmed
    return trimmed + ".0"

def is_string_literal(text):
    trimmed = trim_text(text)
    if len(trimmed) < 2:
        return False
    if trimmed[0] != "\"":
        return False
    if trimmed[len(trimmed) - 1] != "\"":
        return False
    return True

def is_character_literal(text):
    if len(text) < 2:
        return False
    if text[0] != "\""  or  text[len(text) - 1] != "\"":
        return False
    inner = substring(text, 1, len(text) - 1)
    if len(inner) == 2  and  inner[0] == "\\":
        return True
    return len(inner) == 1

def get_character_literal_value(text):
    inner = substring(text, 1, len(text) - 1)
    if len(inner) == 0:
        return 0
    if len(inner) == 2  and  inner[0] == "\\":
        escape = inner[1]
        if escape == "n":
            return char_code("\n")
        else:
            if escape == "r":
                return char_code("\r")
            else:
                if escape == "t":
                    return char_code("\t")
                else:
                    if escape == "\"":
                        return char_code("\"")
                    else:
                        if escape == "\\":
                            return char_code("\\")
        return char_code(escape)
    return char_code(inner[0])

def make_string_constant_name(content):
    hash_value = compute_string_constant_hash(content)
    length_part = number_to_string(len(content))
    hash_part = number_to_string(hash_value)
    return "@.str.len" + length_part + ".h" + hash_part

def compute_string_constant_hash(content):
    hash = 5381
    modulus = 2147483647
    index = 0
    while True:
        if index >= len(content):
            break
        code = char_code(content[index])
        hash = hash * 33 + code
        while True:
            if hash < modulus:
                break
            hash -= modulus
        index += 1
    hash = hash * 33 + len(content)
    while True:
        if hash < modulus:
            break
        hash -= modulus
    return hash

def lower_string_literal(literal, temp_index, lines):
    content = unescape_string_literal(literal)
    global_name = make_string_constant_name(content)
    constant = StringConstant(name=global_name, content=content, byte_count=len(content))
    base_constants = empty_string_constant_set()
    constant_set = append_string_constant(base_constants, constant)
    array_type = "[" + number_to_string(len(content) + 1) + " x i8]"
    gep_instr = "  %s" + number_to_string(temp_index) + " = getelementptr inbounds " + array_type + ", " + array_type + "* " + global_name + ", i32 0, i32 0"
    updated_lines = append_string(lines, gep_instr)
    operand = LLVMOperand(llvm_type="i8*", value="%s" + number_to_string(temp_index))
    return ExpressionResult(lines=updated_lines, temp_index=temp_index + 1, operand=operand, diagnostics=[], string_constants=constant_set)

def unescape_string_literal(literal):
    if len(literal) < 2:
        return ""
    start_index = 1
    end_index = len(literal) - 1
    inner = substring(literal, start_index, end_index)
    result = ""
    index = 0
    while True:
        if index >= len(inner):
            break
        ch = inner[index]
        if ch == "\\"  and  index + 1 < len(inner):
            next = inner[index + 1]
            if next == "n":
                result = result + "\n"
                index += 2
                continue
            else:
                if next == "r":
                    result = result + "\r"
                    index += 2
                    continue
                else:
                    if next == "t":
                        result = result + "\t"
                        index += 2
                        continue
                    else:
                        if next == "\"":
                            result = result + "\""
                            index += 2
                            continue
                        else:
                            if next == "\\":
                                result = result + "\\"
                                index += 2
                                continue
        result = result + ch
        index += 1
    return result

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

def find_last_index_of_char(value, target):
    if len(target) != 1:
        return -1
    index = len(value)
    while True:
        if index <= 0:
            break
        index -= 1
        if value[index] == target:
            return index
    return -1

def append_string(values, value):
    return (values) + ([value])

def append_match_arm_mutations(list, arm):
    return (list) + ([arm])

def string_array_contains(values, target):
    index = 0
    while True:
        if index >= len(values):
            break
        if values[index] == target:
            return True
        index += 1
    return False

def merge_parameter_bindings(first, second):
    result = []
    index = 0
    while True:
        if index >= len(first):
            break
        primary = first[index]
        consumed_flag = primary.consumed
        counterpart = find_parameter_binding(second, primary.name)
        if counterpart != None:
            consumed_flag = consumed_flag  or  counterpart.consumed
        result = append_parameter_binding(result, ParameterBinding(name=primary.name, llvm_name=primary.llvm_name, llvm_type=primary.llvm_type, type_annotation=primary.type_annotation, consumed=consumed_flag, span=primary.span))
        index += 1
    return result

def append_parameter_binding(bindings, binding):
    return (bindings) + ([binding])

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

def empty_string_constant_set():
    return []

def string_constant_singleton(constant):
    return [constant]

def clone_string_constants(constants):
    copy = []
    index = 0
    while True:
        if index >= len(constants):
            break
        copy = append_string_constant(copy, constants[index])
        index += 1
    return copy

def append_string_constant(set, constant):
    return (set) + ([constant])

def merge_string_constants(existing, new_constants):
    result = existing
    index = 0
    while True:
        if index >= len(new_constants):
            break
        candidate = new_constants[index]
        found_by_name = find_string_constant_by_name(result, candidate.name)
        if found_by_name == None:
            result = append_string_constant(result, candidate)
        index += 1
    return result

def find_string_constant(constants, content):
    index = 0
    while True:
        if index >= len(constants):
            break
        candidate = constants[index]
        if candidate.content == content:
            return candidate
        index += 1
    return None

def find_string_constant_by_name(constants, name):
    index = 0
    while True:
        if index >= len(constants):
            break
        candidate = constants[index]
        if candidate.name == name:
            return candidate
        index += 1
    return None

def render_string_constants(constants):
    lines = []
    index = 0
    while True:
        if index >= len(constants):
            break
        constant = constants[index]
        escaped = escape_string_for_llvm(constant.content)
        length_str = number_to_string(constant.byte_count + 1)
        declaration = constant.name + " = private unnamed_addr constant [" + length_str + " x i8] c\"" + escaped + "\\00\""
        lines = append_string(lines, declaration)
        index += 1
    return lines

def escape_string_for_llvm(content):
    result = ""
    index = 0
    while True:
        if index >= len(content):
            break
        ch = content[index]
        if ch == "\n":
            result = result + "\\0A"
        else:
            if ch == "\r":
                result = result + "\\0D"
            else:
                if ch == "\t":
                    result = result + "\\09"
                else:
                    if ch == "\"":
                        result = result + "\\22"
                    else:
                        if ch == "\\":
                            result = result + "\\5C"
                        else:
                            result = result + ch
        index += 1
    return result

def is_symbol_char(ch):
    if len(ch) == 0:
        return False
    if ch == "_":
        return True
    code = char_code(ch)
    lower_a = char_code("a")
    lower_z = char_code("z")
    if code >= lower_a  and  code <= lower_z:
        return True
    upper_a = char_code("A")
    upper_z = char_code("Z")
    if code >= upper_a  and  code <= upper_z:
        return True
    zero = char_code("0")
    nine = char_code("9")
    if code >= zero  and  code <= nine:
        return True
    return False

def sanitize_symbol(name):
    if len(name) == 0:
        return "_"
    result = ""
    index = 0
    while True:
        if index >= len(name):
            break
        ch = name[index]
        if is_symbol_char(ch):
            result = result + ch
        index += 1
    if len(result) == 0:
        return "_"
    first = result[0]
    first_code = char_code(first)
    zero = char_code("0")
    nine = char_code("9")
    if first_code >= zero  and  first_code <= nine:
        result = "_" + result
    return result
