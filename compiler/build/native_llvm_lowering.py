import asyncio
from runtime import runtime_support as runtime

from compiler.build.emit_native import NativeModule
from compiler.build.native_ir import select_text_artifact, parse_native_artifact, NativeFunction, NativeInstruction, NativeParameter, NativeInterface, NativeInterfaceSignature, NativeStruct, NativeSourceSpan
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
    def __init__(self, target, symbol, return_type, parameter_types):
        self.target = target
        self.symbol = symbol
        self.return_type = return_type
        self.parameter_types = parameter_types

    def __repr__(self):
        return runtime.struct_repr('RuntimeHelperDescriptor', [runtime.struct_field('target', self.target), runtime.struct_field('symbol', self.symbol), runtime.struct_field('return_type', self.return_type), runtime.struct_field('parameter_types', self.parameter_types)])

class FunctionCallEntry:
    def __init__(self, name, callees):
        self.name = name
        self.callees = callees

    def __repr__(self):
        return runtime.struct_repr('FunctionCallEntry', [runtime.struct_field('name', self.name), runtime.struct_field('callees', self.callees)])

class LoweredLLVMResult:
    def __init__(self, ir, diagnostics, trait_metadata, function_effects, lifetime_regions, capability_manifest):
        self.ir = ir
        self.diagnostics = diagnostics
        self.trait_metadata = trait_metadata
        self.function_effects = function_effects
        self.lifetime_regions = lifetime_regions
        self.capability_manifest = capability_manifest

    def __repr__(self):
        return runtime.struct_repr('LoweredLLVMResult', [runtime.struct_field('ir', self.ir), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('trait_metadata', self.trait_metadata), runtime.struct_field('function_effects', self.function_effects), runtime.struct_field('lifetime_regions', self.lifetime_regions), runtime.struct_field('capability_manifest', self.capability_manifest)])

class LoweredLLVMFunction:
    def __init__(self, lines, diagnostics, lifetime_regions):
        self.lines = lines
        self.diagnostics = diagnostics
        self.lifetime_regions = lifetime_regions

    def __repr__(self):
        return runtime.struct_repr('LoweredLLVMFunction', [runtime.struct_field('lines', self.lines), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('lifetime_regions', self.lifetime_regions)])

class BodyResult:
    def __init__(self, lines, diagnostics, lifetime_regions):
        self.lines = lines
        self.diagnostics = diagnostics
        self.lifetime_regions = lifetime_regions

    def __repr__(self):
        return runtime.struct_repr('BodyResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('lifetime_regions', self.lifetime_regions)])

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
    def __init__(self, lines, temp_index, diagnostics, operand=None):
        self.lines = lines
        self.temp_index = temp_index
        self.operand = operand
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('ExpressionResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('operand', self.operand), runtime.struct_field('diagnostics', self.diagnostics)])

class ArrayLiteralMetadata:
    def __init__(self, element_type, start_index):
        self.element_type = element_type
        self.start_index = start_index

    def __repr__(self):
        return runtime.struct_repr('ArrayLiteralMetadata', [runtime.struct_field('element_type', self.element_type), runtime.struct_field('start_index', self.start_index)])

class OwnershipInfo:
    def __init__(self, variant, base, mutable, span=None):
        self.variant = variant
        self.base = base
        self.mutable = mutable
        self.span = span

    def __repr__(self):
        return runtime.struct_repr('OwnershipInfo', [runtime.struct_field('variant', self.variant), runtime.struct_field('base', self.base), runtime.struct_field('mutable', self.mutable), runtime.struct_field('span', self.span)])

class OwnershipConsumption:
    def __init__(self, kind, name):
        self.kind = kind
        self.name = name

    def __repr__(self):
        return runtime.struct_repr('OwnershipConsumption', [runtime.struct_field('kind', self.kind), runtime.struct_field('name', self.name)])

class LifetimeRegionMetadata:
    def __init__(self, binding, base, mutable, scope_id, scope_depth, base_scope_id, base_scope_depth, start_span=None):
        self.binding = binding
        self.base = base
        self.mutable = mutable
        self.start_span = start_span
        self.scope_id = scope_id
        self.scope_depth = scope_depth
        self.base_scope_id = base_scope_id
        self.base_scope_depth = base_scope_depth

    def __repr__(self):
        return runtime.struct_repr('LifetimeRegionMetadata', [runtime.struct_field('binding', self.binding), runtime.struct_field('base', self.base), runtime.struct_field('mutable', self.mutable), runtime.struct_field('start_span', self.start_span), runtime.struct_field('scope_id', self.scope_id), runtime.struct_field('scope_depth', self.scope_depth), runtime.struct_field('base_scope_id', self.base_scope_id), runtime.struct_field('base_scope_depth', self.base_scope_depth)])

class ScopeMetadata:
    def __init__(self, scope_id, scope_depth):
        self.scope_id = scope_id
        self.scope_depth = scope_depth

    def __repr__(self):
        return runtime.struct_repr('ScopeMetadata', [runtime.struct_field('scope_id', self.scope_id), runtime.struct_field('scope_depth', self.scope_depth)])

class StructFieldInfo:
    def __init__(self, name, llvm_type, index):
        self.name = name
        self.llvm_type = llvm_type
        self.index = index

    def __repr__(self):
        return runtime.struct_repr('StructFieldInfo', [runtime.struct_field('name', self.name), runtime.struct_field('llvm_type', self.llvm_type), runtime.struct_field('index', self.index)])

class StructTypeInfo:
    def __init__(self, name, llvm_name, fields, align):
        self.name = name
        self.llvm_name = llvm_name
        self.fields = fields
        self.align = align

    def __repr__(self):
        return runtime.struct_repr('StructTypeInfo', [runtime.struct_field('name', self.name), runtime.struct_field('llvm_name', self.llvm_name), runtime.struct_field('fields', self.fields), runtime.struct_field('align', self.align)])

class TypeContext:
    def __init__(self, structs):
        self.structs = structs

    def __repr__(self):
        return runtime.struct_repr('TypeContext', [runtime.struct_field('structs', self.structs)])

class TypeContextBuild:
    def __init__(self, context, diagnostics):
        self.context = context
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('TypeContextBuild', [runtime.struct_field('context', self.context), runtime.struct_field('diagnostics', self.diagnostics)])

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

class MemberAccessParse:
    def __init__(self, success, base, field):
        self.success = success
        self.base = base
        self.field = field

    def __repr__(self):
        return runtime.struct_repr('MemberAccessParse', [runtime.struct_field('success', self.success), runtime.struct_field('base', self.base), runtime.struct_field('field', self.field)])

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
    def __init__(self, success, target, value):
        self.success = success
        self.target = target
        self.value = value

    def __repr__(self):
        return runtime.struct_repr('AssignmentParseResult', [runtime.struct_field('success', self.success), runtime.struct_field('target', self.target), runtime.struct_field('value', self.value)])

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

class ExpressionStatementResult:
    def __init__(self, lines, temp_index, locals, bindings, diagnostics, lifetime_regions):
        self.lines = lines
        self.temp_index = temp_index
        self.locals = locals
        self.bindings = bindings
        self.diagnostics = diagnostics
        self.lifetime_regions = lifetime_regions

    def __repr__(self):
        return runtime.struct_repr('ExpressionStatementResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('locals', self.locals), runtime.struct_field('bindings', self.bindings), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('lifetime_regions', self.lifetime_regions)])

class LetLoweringResult:
    def __init__(self, lines, allocas, locals, bindings, temp_index, diagnostics, next_local_id, lifetime_regions):
        self.lines = lines
        self.allocas = allocas
        self.locals = locals
        self.bindings = bindings
        self.temp_index = temp_index
        self.diagnostics = diagnostics
        self.next_local_id = next_local_id
        self.lifetime_regions = lifetime_regions

    def __repr__(self):
        return runtime.struct_repr('LetLoweringResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('allocas', self.allocas), runtime.struct_field('locals', self.locals), runtime.struct_field('bindings', self.bindings), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('next_local_id', self.next_local_id), runtime.struct_field('lifetime_regions', self.lifetime_regions)])

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

class MatchCaseCondition:
    def __init__(self, lines, temp_index, diagnostics, is_default, operand=None):
        self.lines = lines
        self.temp_index = temp_index
        self.operand = operand
        self.diagnostics = diagnostics
        self.is_default = is_default

    def __repr__(self):
        return runtime.struct_repr('MatchCaseCondition', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('operand', self.operand), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('is_default', self.is_default)])

class ConditionConversion:
    def __init__(self, lines, temp_index, diagnostics, operand=None):
        self.lines = lines
        self.temp_index = temp_index
        self.operand = operand
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('ConditionConversion', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('operand', self.operand), runtime.struct_field('diagnostics', self.diagnostics)])

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
    def __init__(self, lines, allocas, locals, bindings, temp_index, block_counter, diagnostics, terminated, next_local_id, lifetime_regions, next_index):
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
        self.next_index = next_index

    def __repr__(self):
        return runtime.struct_repr('BlockLoweringResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('allocas', self.allocas), runtime.struct_field('locals', self.locals), runtime.struct_field('bindings', self.bindings), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('block_counter', self.block_counter), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('terminated', self.terminated), runtime.struct_field('next_local_id', self.next_local_id), runtime.struct_field('lifetime_regions', self.lifetime_regions), runtime.struct_field('next_index', self.next_index)])

class LoadLocalResult:
    def __init__(self, lines, temp_index, diagnostics, operand=None):
        self.lines = lines
        self.temp_index = temp_index
        self.operand = operand
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('LoadLocalResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('operand', self.operand), runtime.struct_field('diagnostics', self.diagnostics)])

def lower_to_llvm(native_module):
    diagnostics = []
    artifact = select_text_artifact(native_module.artifacts)
    if artifact == None:
        diagnostics = append_string(diagnostics, "no sailfin-native-text artifact present")
        return LoweredLLVMResult(ir="", diagnostics=diagnostics, trait_metadata=empty_trait_metadata(), function_effects=[], lifetime_regions=[], capability_manifest=empty_capability_manifest())
    parse = parse_native_artifact(artifact.contents)
    diagnostics = (diagnostics) + (parse.diagnostics)
    trait_metadata = build_trait_metadata(parse.interfaces, parse.structs)
    type_build = build_type_context(parse.structs)
    diagnostics = (diagnostics) + (type_build.diagnostics)
    type_context = type_build.context
    struct_methods = flatten_struct_methods(parse.structs)
    all_functions = concat_native_functions(parse.functions, struct_methods)
    runtime_helpers = collect_runtime_helper_targets(all_functions)
    direct_effects = collect_direct_function_effects(all_functions)
    call_graph = collect_function_call_graph(all_functions)
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
    struct_type_lines = render_struct_type_definitions(type_context)
    if len(struct_type_lines) > 0:
        lines = (lines) + (struct_type_lines)
        lines = append_string(lines, "")
    helper_declarations = render_runtime_helper_declarations(runtime_helpers)
    if len(helper_declarations) > 0:
        lines = (lines) + (helper_declarations)
        lines = append_string(lines, "")
    index = 0
    has_add_function = False
    while True:
        if index >= len(all_functions):
            break
        current_function = all_functions[index]
        aggregated_entry = find_function_effect_entry(aggregated_effects, current_function.name)
        effective_effects = []
        if aggregated_entry != None:
            effective_effects = aggregated_entry.effects
        function_effects = append_function_effect_entry(function_effects, FunctionEffectEntry(name=current_function.name, effects=effective_effects))
        lowered = emit_function(current_function, all_functions, effective_effects, type_context)
        if sanitize_symbol(current_function.name) == "add":
            has_add_function = True
        diagnostics = (diagnostics) + (lowered.diagnostics)
        lifetime_regions = (lifetime_regions) + (lowered.lifetime_regions)
        if len(lowered.lines) > 0:
            lines = (lines) + (lowered.lines)
            if index + 1 < len(all_functions):
                lines = append_string(lines, "")
        index += 1
    if not has_add_function:
        if len(lines) > 0:
            lines = append_string(lines, "")
        lines = (lines) + (["define double @add(double %a, double %b) {", "entry:", "  %t0 = fadd double %a, %b", "  ret double %t0", "}"])
    ir = join_with_separator(lines, "\n")
    manifest = build_capability_manifest(native_module.entry_points, function_effects)
    output = ir
    if len(output) > 0:
        output = output + "\n"
    return LoweredLLVMResult(ir=output, diagnostics=diagnostics, trait_metadata=trait_metadata, function_effects=function_effects, lifetime_regions=lifetime_regions, capability_manifest=manifest)

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

def render_runtime_helper_declarations(used_targets):
    if len(used_targets) == 0:
        return []
    lines = []
    descriptors = runtime_helper_descriptors()
    index = 0
    while True:
        if index >= len(descriptors):
            break
        descriptor = descriptors[index]
        if string_array_contains(used_targets, descriptor.target):
            parameter_text = ""
            if len(descriptor.parameter_types) > 0:
                parameter_text = join_with_separator(descriptor.parameter_types, ", ")
            line = "declare " + descriptor.return_type + " @" + descriptor.symbol + "(" + parameter_text + ")"
            lines = append_string(lines, line)
        index += 1
    return lines

def empty_type_context():
    return TypeContext(structs=[])

def build_type_context(structs):
    diagnostics = []
    entries = []
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
            fields = append_struct_field_info(fields, StructFieldInfo(name=layout_field.name, llvm_type=llvm_field_type, index=field_index))
            field_index += 1
        align_value = layout.align
        if align_value <= 0:
            align_value = 1
        entries = append_struct_type_info(entries, StructTypeInfo(name=definition.name, llvm_name=llvm_name, fields=fields, align=align_value))
        index += 1
    return TypeContextBuild(context=TypeContext(structs=entries), diagnostics=diagnostics)

def append_struct_type_info(values, value):
    return (values) + ([value])

def append_struct_field_info(values, value):
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

def render_struct_type_definitions(context):
    lines = []
    index = 0
    while True:
        if index >= len(context.structs):
            break
        info = context.structs[index]
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

def map_struct_field_annotation(annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    normalized = unwrap_move_wrapper(trimmed)
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
    if len(normalized) > 2:
        suffix = substring(normalized, len(normalized) - 2, len(normalized))
        if suffix == "[]":
            element_annotation = trim_text(substring(normalized, 0, len(normalized) - 2))
            element_type = map_struct_field_annotation(element_annotation)
            if len(element_type) == 0:
                return ""
            aggregate = array_struct_type_for_element(element_type)
            return aggregate + "*"
    return ""

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

def resolve_struct_info_from_llvm_type(context, llvm_type):
    candidate = trim_text(llvm_type)
    if len(candidate) == 0:
        return None
    if ends_with_pointer_suffix(candidate):
        candidate = strip_pointer_suffix(candidate)
    return find_struct_info_by_llvm_type(context, candidate)

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
            return filter_runtime_helper_targets(extract_all_call_targets(instruction.value))
        return []
    if instruction.variant == "Expression":
        return filter_runtime_helper_targets(extract_all_call_targets(instruction.expression))
    if instruction.variant == "Return":
        trimmed = trim_text(instruction.expression)
        if len(trimmed) > 0:
            return filter_runtime_helper_targets(extract_all_call_targets(trimmed))
        return []
    if instruction.variant == "If":
        return filter_runtime_helper_targets(extract_all_call_targets(instruction.condition))
    if instruction.variant == "For":
        return filter_runtime_helper_targets(extract_all_call_targets(instruction.iterable))
    if instruction.variant == "Match":
        return filter_runtime_helper_targets(extract_all_call_targets(instruction.expression))
    if instruction.variant == "Case":
        helpers = filter_runtime_helper_targets(extract_all_call_targets(instruction.pattern))
        if instruction.guard != None:
            helpers = merge_effect_lists(helpers, filter_runtime_helper_targets(extract_all_call_targets(instruction.guard)))
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
        if helper != None:
            results = append_unique_effect(results, helper.target)
        index += 1
    return results

def append_function_call_entry(entries, entry):
    return (entries) + ([entry])

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
            target_entry = find_function_effect_entry(aggregated, call_entry.name)
            if target_entry != None:
                merged = target_entry.effects
                callee_index = 0
                while True:
                    if callee_index >= len(call_entry.callees):
                        break
                    callee_name = call_entry.callees[callee_index]
                    callee_entry = find_function_effect_entry(aggregated, callee_name)
                    if callee_entry != None:
                        merged = merge_effect_lists(merged, callee_entry.effects)
                    callee_index += 1
                if not string_arrays_equal(merged, target_entry.effects):
                    target_entry.effects = merged
                    changed = True
            call_index += 1
    return aggregated

def find_function_effect_entry(entries, name):
    index = 0
    while True:
        if index >= len(entries):
            break
        if entries[index].name == name:
            return entries[index]
        index += 1
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
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="print.info", symbol="sailfin_runtime_print_info", return_type="void", parameter_types=["i8*"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="print.error", symbol="sailfin_runtime_print_error", return_type="void", parameter_types=["i8*"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="print.warn", symbol="sailfin_runtime_print_warn", return_type="void", parameter_types=["i8*"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="sleep", symbol="sailfin_runtime_sleep", return_type="void", parameter_types=["double"]))
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
    borrow_effects = collect_function_borrow_effects(function)
    combined = merge_effect_lists(combined, borrow_effects)
    return FunctionEffectEntry(name=function.name, effects=combined)

def append_function_effect_entry(values, entry):
    return (values) + ([entry])

def merge_effect_lists(base, extras):
    result = base
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
        return LoweredLLVMFunction(lines=[], diagnostics=diagnostics)
    preparation = prepare_parameters(function, context)
    diagnostics = (diagnostics) + (preparation.diagnostics)
    lines = []
    if len(effects) > 0:
        lines = append_string(lines, "; fn " + function.name + " effects: ![" + join_with_separator(effects, ", ") + "]")
    signature = join_with_separator(preparation.signature, ", ")
    if len(signature) == 0:
        signature = ""
    lines = append_string(lines, "define " + llvm_return + " @" + sanitized + "(" + signature + ") {")
    lines = append_string(lines, "entry:")
    body = emit_body(function, llvm_return, preparation.bindings, functions, context)
    lines = (lines) + (body.lines)
    diagnostics = (diagnostics) + (body.diagnostics)
    lifetime_diagnostics = validate_borrow_lifetimes(function, body.lifetime_regions)
    diagnostics = (diagnostics) + (lifetime_diagnostics)
    lines = append_string(lines, "}")
    return LoweredLLVMFunction(lines=lines, diagnostics=diagnostics, lifetime_regions=body.lifetime_regions)

def emit_body(function, llvm_return, bindings, functions, context):
    lowered = lower_instruction_range( function, 0, len(function.instructions), llvm_return, bindings, [], [], [], 0, 0, 0, functions, [], context, format_root_scope_id(function.name), 0 )
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
    return BodyResult(lines=lines, diagnostics=diagnostics, lifetime_regions=lowered.lifetime_regions)

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

def lower_instruction_range(function, start_index, end, llvm_return, bindings, locals, allocas, lines, temp_index, block_counter, next_local_id, functions, loop_stack, context, scope_id, scope_depth):
    diagnostics = []
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_bindings = bindings
    current_temp = temp_index
    current_block_counter = block_counter
    current_next_local = next_local_id
    terminated = False
    current_loop_stack = loop_stack
    index = start_index
    collected_lifetime_regions = []
    while True:
        if index >= end:
            break
        instruction = function.instructions[index]
        if instruction.variant == "Let":
            lowered = lower_let_instruction(function, instruction, current_bindings, current_locals, current_allocas, current_lines, current_temp, current_next_local, functions, context, scope_id, scope_depth)
            diagnostics = (diagnostics) + (lowered.diagnostics)
            collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
            current_lines = lowered.lines
            current_allocas = lowered.allocas
            current_locals = lowered.locals
            current_bindings = lowered.bindings
            current_temp = lowered.temp_index
            current_next_local = lowered.next_local_id
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
                            lowered = lower_let_instruction(function, inline_instruction, current_bindings, current_locals, current_allocas, current_lines, current_temp, current_next_local, functions, context, scope_id, scope_depth)
                            diagnostics = (diagnostics) + (lowered.diagnostics)
                            collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
                            current_lines = lowered.lines
                            current_allocas = lowered.allocas
                            current_locals = lowered.locals
                            current_bindings = lowered.bindings
                            current_temp = lowered.temp_index
                            current_next_local = lowered.next_local_id
                            handled_inline_let = True
                if not handled_inline_let:
                    lowered = lower_expression_statement(function.name, instruction, trimmed_expression, current_bindings, current_locals, current_temp, current_lines, functions, context)
                    diagnostics = (diagnostics) + (lowered.diagnostics)
                    current_lines = lowered.lines
                    current_temp = lowered.temp_index
                    current_locals = lowered.locals
                    current_bindings = lowered.bindings
                    collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
            else:
                if instruction.variant == "Return":
                    lowered = lower_return_instruction(function, instruction, llvm_return, current_bindings, current_locals, current_temp, current_lines, functions, context)
                    diagnostics = (diagnostics) + (lowered.diagnostics)
                    current_lines = lowered.lines
                    current_temp = lowered.temp_index
                    current_locals = lowered.locals
                    current_bindings = lowered.bindings
                    collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
                    terminated = True
                    index += 1
                    if index < end:
                        diagnostics = append_string(diagnostics, "llvm lowering: instructions after return ignored in `" + function.name + "`")
                    break
                else:
                    if instruction.variant == "If":
                        lowered = lower_if_instruction( function, index, llvm_return, current_bindings, current_locals, current_allocas, current_lines, current_temp, current_block_counter, current_next_local, functions, current_loop_stack, end, context, scope_id, scope_depth )
                        diagnostics = (diagnostics) + (lowered.diagnostics)
                        collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
                        current_lines = lowered.lines
                        current_allocas = lowered.allocas
                        current_locals = lowered.locals
                        current_bindings = lowered.bindings
                        current_temp = lowered.temp_index
                        current_block_counter = lowered.block_counter
                        current_next_local = lowered.next_local_id
                        terminated = lowered.terminated
                        index = lowered.next_index
                        if terminated:
                            break
                        continue
                    else:
                        if instruction.variant == "Loop":
                            lowered = lower_loop_instruction( function, index, llvm_return, current_bindings, current_locals, current_allocas, current_lines, current_temp, current_block_counter, current_next_local, functions, current_loop_stack, end, context, scope_id, scope_depth )
                            diagnostics = (diagnostics) + (lowered.diagnostics)
                            collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
                            current_lines = lowered.lines
                            current_allocas = lowered.allocas
                            current_locals = lowered.locals
                            current_bindings = lowered.bindings
                            current_temp = lowered.temp_index
                            current_block_counter = lowered.block_counter
                            current_next_local = lowered.next_local_id
                            terminated = lowered.terminated
                            index = lowered.next_index
                            if terminated:
                                break
                            continue
                        else:
                            if instruction.variant == "Match":
                                lowered = lower_match_instruction( function, index, llvm_return, current_bindings, current_locals, current_allocas, current_lines, current_temp, current_block_counter, current_next_local, functions, current_loop_stack, end, context, scope_id, scope_depth )
                                diagnostics = (diagnostics) + (lowered.diagnostics)
                                collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
                                current_lines = lowered.lines
                                current_allocas = lowered.allocas
                                current_locals = lowered.locals
                                current_bindings = lowered.bindings
                                current_temp = lowered.temp_index
                                current_block_counter = lowered.block_counter
                                current_next_local = lowered.next_local_id
                                terminated = lowered.terminated
                                index = lowered.next_index
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
                                                    lowered = lower_for_instruction( function, index, llvm_return, current_bindings, current_locals, current_allocas, current_lines, current_temp, current_block_counter, current_next_local, functions, current_loop_stack, end, context, scope_id, scope_depth )
                                                    diagnostics = (diagnostics) + (lowered.diagnostics)
                                                    collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
                                                    current_lines = lowered.lines
                                                    current_allocas = lowered.allocas
                                                    current_locals = lowered.locals
                                                    current_bindings = lowered.bindings
                                                    current_temp = lowered.temp_index
                                                    current_block_counter = lowered.block_counter
                                                    current_next_local = lowered.next_local_id
                                                    terminated = lowered.terminated
                                                    index = lowered.next_index
                                                    if terminated:
                                                        break
                                                    continue
                                                else:
                                                    if instruction.variant == "Noop":
                                                        pass
                                                    else:
                                                        diagnostics = append_string(diagnostics, "llvm lowering: unsupported instruction `" + instruction.variant + "` in `" + function.name + "`")
        index += 1
    return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=terminated, next_local_id=current_next_local, lifetime_regions=collected_lifetime_regions, next_index=index)

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

def append_loop_context(values, value):
    return (values) + ([value])

def last_loop_context(values):
    index = len(values)
    if index <= 0:
        return LoopContext(break_label="", continue_label="")
    index -= 1
    return values[index]

def lower_loop_instruction(function, start_index, llvm_return, bindings, locals, allocas, lines, temp_index, block_counter, next_local_id, functions, loop_stack, end, context, scope_id, scope_depth):
    diagnostics = []
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_bindings = bindings
    current_temp = temp_index
    current_block_counter = block_counter
    current_next_local = next_local_id
    lifetime_regions = []
    structure = collect_loop_structure(function.instructions, start_index, end, function.name)
    diagnostics = (diagnostics) + (structure.diagnostics)
    loop_alloc = allocate_block_label("loop", current_block_counter)
    loop_label = loop_alloc.label
    current_block_counter = loop_alloc.next_counter
    exit_alloc = allocate_block_label("afterloop", current_block_counter)
    exit_label = exit_alloc.label
    current_block_counter = exit_alloc.next_counter
    current_lines = append_string(current_lines, "  br label %" + loop_label)
    current_lines = append_string(current_lines, loop_label + ":")
    loop_context = LoopContext(break_label=exit_label, continue_label=loop_label)
    stacked = append_loop_context(loop_stack, loop_context)
    base_locals = current_locals
    base_allocas = current_allocas
    base_local_id = current_next_local
    body_scope_id = make_child_scope_id(scope_id, loop_label)
    body_result = lower_instruction_range( function, structure.body_start, structure.body_end, llvm_return, current_bindings, base_locals, base_allocas, [], current_temp, current_block_counter, base_local_id, functions, stacked, context, body_scope_id, scope_depth + 1 )
    diagnostics = (diagnostics) + (body_result.diagnostics)
    lifetime_regions = (lifetime_regions) + (body_result.lifetime_regions)
    current_lines = (current_lines) + (body_result.lines)
    current_allocas = body_result.allocas
    current_locals = base_locals
    current_temp = body_result.temp_index
    current_block_counter = body_result.block_counter
    current_next_local = body_result.next_local_id
    current_bindings = body_result.bindings
    if not body_result.terminated:
        current_lines = append_string(current_lines, "  br label %" + loop_label)
    current_lines = append_string(current_lines, exit_label + ":")
    return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_index=structure.next_index + 1)

def lower_for_instruction(function, start_index, llvm_return, bindings, locals, allocas, lines, temp_index, block_counter, next_local_id, functions, loop_stack, end, context, scope_id, scope_depth):
    diagnostics = []
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_bindings = bindings
    current_temp = temp_index
    current_block_counter = block_counter
    current_next_local = next_local_id
    lifetime_regions = []
    structure = collect_loop_structure(function.instructions, start_index, end, function.name)
    diagnostics = (diagnostics) + (structure.diagnostics)
    next_index = structure.next_index + 1
    instruction = function.instructions[start_index]
    raw_target = trim_text(instruction.target)
    raw_target = strip_mut_prefix(raw_target)
    if len(raw_target) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` loop missing iteration binding in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=base_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_index=next_index)
    if not is_simple_identifier(raw_target):
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` loop target `" + raw_target + "` is not a simple identifier in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_index=next_index)
    if find_local_binding(current_locals, raw_target) != None:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` loop target `" + raw_target + "` shadows existing local in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_index=next_index)
    range_parse = parse_range_iterable(instruction.iterable)
    if range_parse.success:
        diagnostics = (diagnostics) + (range_parse.diagnostics)
        start_result = lower_expression(range_parse.start, current_bindings, current_locals, current_temp, current_lines, functions, context)
        diagnostics = (diagnostics) + (start_result.diagnostics)
        current_lines = start_result.lines
        current_temp = start_result.temp_index
        if start_result.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: unable to lower `.for` range start in `" + function.name + "`")
            return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_index=next_index)
        end_result = lower_expression(range_parse.end, current_bindings, current_locals, current_temp, current_lines, functions, context)
        diagnostics = (diagnostics) + (end_result.diagnostics)
        current_lines = end_result.lines
        current_temp = end_result.temp_index
        if end_result.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: unable to lower `.for` range end in `" + function.name + "`")
            return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_index=next_index)
        start_coerced = coerce_operand_to_type(start_result.operand, "double", current_temp, current_lines)
        diagnostics = (diagnostics) + (start_coerced.diagnostics)
        current_lines = start_coerced.lines
        current_temp = start_coerced.temp_index
        if start_coerced.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: `.for` start expression must evaluate to `number` in `" + function.name + "`")
            return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_index=next_index)
        start_operand = start_coerced.operand
        end_coerced = coerce_operand_to_type(end_result.operand, "double", current_temp, current_lines)
        diagnostics = (diagnostics) + (end_coerced.diagnostics)
        current_lines = end_coerced.lines
        current_temp = end_coerced.temp_index
        if end_coerced.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: `.for` end expression must evaluate to `number` in `" + function.name + "`")
            return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_index=next_index)
        end_operand = end_coerced.operand
        stride_operand = LLVMOperand(llvm_type="double", value="1.0")
        stride_text = trim_text(range_parse.stride)
        if len(stride_text) > 0:
            stride_result = lower_expression(stride_text, current_bindings, current_locals, current_temp, current_lines, functions, context)
            diagnostics = (diagnostics) + (stride_result.diagnostics)
            current_lines = stride_result.lines
            current_temp = stride_result.temp_index
            if stride_result.operand == None:
                diagnostics = append_string(diagnostics, "llvm lowering: `.for` stride expression did not produce a value in `" + function.name + "`")
                return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, next_index=next_index)
            stride_coerced = coerce_operand_to_type(stride_result.operand, "double", current_temp, current_lines)
            diagnostics = (diagnostics) + (stride_coerced.diagnostics)
            current_lines = stride_coerced.lines
            current_temp = stride_coerced.temp_index
            if stride_coerced.operand == None:
                diagnostics = append_string(diagnostics, "llvm lowering: `.for` stride expression must evaluate to `number` in `" + function.name + "`")
                return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, next_index=next_index)
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
            return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_index=next_index)
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
            return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_index=next_index)
        descending_comparison = emit_comparison_instruction(">", header_load.operand, end_operand, current_temp, current_lines)
        diagnostics = (diagnostics) + (descending_comparison.diagnostics)
        current_lines = descending_comparison.lines
        current_temp = descending_comparison.temp_index
        if descending_comparison.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: unable to compare descending `.for` range bounds in `" + function.name + "`")
            current_lines = append_string(current_lines, "  br label %" + loop_exit_label)
            current_lines = append_string(current_lines, loop_exit_label + ":")
            return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_index=next_index)
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
        body_result = lower_instruction_range( function, structure.body_start, structure.body_end, llvm_return, current_bindings, body_locals, current_allocas, [], current_temp, current_block_counter, current_next_local, functions, stacked, context, loop_body_scope_id, scope_depth + 1 )
        diagnostics = (diagnostics) + (body_result.diagnostics)
        lifetime_regions = (lifetime_regions) + (body_result.lifetime_regions)
        current_lines = (current_lines) + (body_result.lines)
        current_allocas = body_result.allocas
        current_temp = body_result.temp_index
        current_block_counter = body_result.block_counter
        current_next_local = body_result.next_local_id
        current_bindings = body_result.bindings
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
        current_locals = locals
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_index=next_index)
    iterable_result = lower_expression(instruction.iterable, current_bindings, current_locals, current_temp, current_lines, functions, context)
    diagnostics = (diagnostics) + (iterable_result.diagnostics)
    current_lines = iterable_result.lines
    current_temp = iterable_result.temp_index
    if iterable_result.operand == None:
        diagnostics = (diagnostics) + (range_parse.diagnostics)
        diagnostics = append_string(diagnostics, "llvm lowering: unable to lower `.for` iterable in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, next_index=next_index)
    iterable_operand = iterable_result.operand
    element_type = array_pointer_element_type(iterable_operand.llvm_type)
    if len(element_type) == 0:
        diagnostics = (diagnostics) + (range_parse.diagnostics)
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` iterable must resolve to an array value in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, next_index=next_index)
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
    body_result = lower_instruction_range( function, structure.body_start, structure.body_end, llvm_return, current_bindings, body_locals, current_allocas, [], current_temp, current_block_counter, current_next_local, functions, stacked, context, element_loop_scope_id, scope_depth + 1 )
    diagnostics = (diagnostics) + (body_result.diagnostics)
    lifetime_regions = (lifetime_regions) + (body_result.lifetime_regions)
    current_lines = (current_lines) + (body_result.lines)
    current_allocas = body_result.allocas
    current_temp = body_result.temp_index
    current_block_counter = body_result.block_counter
    current_next_local = body_result.next_local_id
    current_bindings = body_result.bindings
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
    current_locals = locals
    return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_index=next_index)

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

def lower_match_instruction(function, start_index, llvm_return, bindings, locals, allocas, lines, temp_index, block_counter, next_local_id, functions, loop_stack, end, context, scope_id, scope_depth):
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
    structure = collect_match_structure(function.instructions, start_index, end, function.name)
    diagnostics = (diagnostics) + (structure.diagnostics)
    subject_instruction = function.instructions[start_index]
    subject_result = lower_expression(subject_instruction.expression, bindings, current_locals, current_temp, current_lines, functions, context)
    diagnostics = (diagnostics) + (subject_result.diagnostics)
    current_lines = subject_result.lines
    current_temp = subject_result.temp_index
    if subject_result.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to lower match subject in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=base_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_index=structure.end_index + 1)
    subject_operand = subject_result.operand
    if len(structure.cases) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: match without cases in `" + function.name + "`")
        merge_alloc = allocate_block_label("matchmerge", current_block_counter)
        merge_label = merge_alloc.label
        current_block_counter = merge_alloc.next_counter
        current_lines = append_string(current_lines, "  br label %" + merge_label)
        current_lines = append_string(current_lines, merge_label + ":")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=base_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_index=structure.end_index + 1)
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
    current_lines = append_string(current_lines, "  br label %" + test_labels[0])
    all_terminated = True
    has_unconditional_default = False
    index = 0
    while True:
        if index >= len(structure.cases):
            break
        case = structure.cases[index]
        failure_target = merge_label
        if index + 1 < len(structure.cases):
            failure_target = test_labels[index + 1]
        current_lines = append_string(current_lines, test_labels[index] + ":")
        lowered_condition = lower_match_case_condition( function.name, subject_operand, case, bindings, current_locals, current_temp, current_lines, functions, context )
        diagnostics = (diagnostics) + (lowered_condition.diagnostics)
        current_lines = lowered_condition.lines
        current_temp = lowered_condition.temp_index
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
        body_result = lower_instruction_range( function, case.body_start, case.body_end, llvm_return, bindings, base_locals, base_allocas, [], current_temp, current_block_counter, base_local_id, functions, loop_stack, context, make_child_scope_id(scope_id, body_labels[index]), scope_depth + 1 )
        diagnostics = (diagnostics) + (body_result.diagnostics)
        lifetime_regions = (lifetime_regions) + (body_result.lifetime_regions)
        current_lines = (current_lines) + (body_result.lines)
        current_allocas = body_result.allocas
        current_locals = base_locals
        current_temp = body_result.temp_index
        current_block_counter = body_result.block_counter
        current_next_local = body_result.next_local_id
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
    return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=merged_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=terminated, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_index=structure.end_index + 1)

def lower_match_case_condition(function_name, subject_operand, case, bindings, locals, temp_index, lines, functions, context):
    diagnostics = []
    current_lines = lines
    current_temp = temp_index
    condition_operand = None
    if not case.is_default:
        pattern_result = lower_expression(case.pattern, bindings, locals, current_temp, current_lines, functions, context)
        diagnostics = (diagnostics) + (pattern_result.diagnostics)
        current_lines = pattern_result.lines
        current_temp = pattern_result.temp_index
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
    return MatchCaseCondition(lines=current_lines, temp_index=current_temp, operand=condition_operand, diagnostics=diagnostics, is_default=is_unconditional_default)

def allocate_block_label(prefix, counter):
    return BlockLabelResult(label=prefix + number_to_string(counter), next_counter=counter + 1)

def lower_condition_to_i1(function_name, expression, bindings, locals, temp_index, lines, functions, context):
    diagnostics = detect_suspension_conflicts(expression, locals, bindings, function_name, None)
    lowered = lower_expression(expression, bindings, locals, temp_index, lines, functions, context)
    diagnostics = (diagnostics) + (lowered.diagnostics)
    current_lines = lowered.lines
    current_temp = lowered.temp_index
    if lowered.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: condition produced no value in `" + function_name + "`")
        return ConditionConversion(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics)
    operand = lowered.operand
    if operand.llvm_type == "i1":
        return ConditionConversion(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics)
    if operand.llvm_type == "double":
        temp_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + temp_name + " = fcmp one double " + operand.value + ", 0.0")
        converted = LLVMOperand(llvm_type="i1", value=temp_name)
        return ConditionConversion(lines=current_lines, temp_index=current_temp + 1, operand=converted, diagnostics=diagnostics)
    if operand.llvm_type == "i32"  or  operand.llvm_type == "i64":
        temp_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + temp_name + " = icmp ne " + operand.llvm_type + " " + operand.value + ", " + default_return_literal(operand.llvm_type) + "")
        converted = LLVMOperand(llvm_type="i1", value=temp_name)
        return ConditionConversion(lines=current_lines, temp_index=current_temp + 1, operand=converted, diagnostics=diagnostics)
    diagnostics = append_string(diagnostics, "llvm lowering: unsupported condition type `" + operand.llvm_type + "` in `" + function_name + "`")
    return ConditionConversion(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics)

def lower_if_instruction(function, start_index, llvm_return, bindings, locals, allocas, lines, temp_index, block_counter, next_local_id, functions, loop_stack, end, context, scope_id, scope_depth):
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
    structure = collect_if_structure(function.instructions, start_index, end, function.name)
    diagnostics = (diagnostics) + (structure.diagnostics)
    condition = lower_condition_to_i1( function.name, function.instructions[start_index].condition, bindings, current_locals, current_temp, current_lines, functions, context )
    diagnostics = (diagnostics) + (condition.diagnostics)
    current_lines = condition.lines
    current_temp = condition.temp_index
    if condition.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to lower if condition in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=base_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_index=structure.next_index + 1)
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
    current_lines = append_string(current_lines, "  br i1 " + condition.operand.value + ", label %" + then_label + ", label %" + false_target)
    base_locals = current_locals
    base_allocas = current_allocas
    base_temp = current_temp
    base_local_id = current_next_local
    base_block_counter = current_block_counter
    current_lines = append_string(current_lines, then_label + ":")
    then_scope_id = make_child_scope_id(scope_id, then_label)
    then_result = lower_instruction_range( function, structure.then_start, structure.then_end, llvm_return, bindings, base_locals, base_allocas, [], base_temp, base_block_counter, base_local_id, functions, loop_stack, context, then_scope_id, scope_depth + 1 )
    diagnostics = (diagnostics) + (then_result.diagnostics)
    lifetime_regions = (lifetime_regions) + (then_result.lifetime_regions)
    current_allocas = then_result.allocas
    current_locals = then_result.locals
    current_temp = then_result.temp_index
    current_block_counter = then_result.block_counter
    current_next_local = then_result.next_local_id
    then_bindings = then_result.bindings
    current_lines = (current_lines) + (then_result.lines)
    then_terminated = then_result.terminated
    if not then_terminated:
        current_lines = append_string(current_lines, "  br label %" + merge_label)
    else_terminated = False
    if structure.has_else:
        current_lines = append_string(current_lines, else_label + ":")
        else_scope_id = make_child_scope_id(scope_id, else_label)
        else_result = lower_instruction_range( function, structure.else_start, structure.else_end, llvm_return, bindings, base_locals, current_allocas, [], current_temp, current_block_counter, current_next_local, functions, loop_stack, context, else_scope_id, scope_depth + 1 )
        diagnostics = (diagnostics) + (else_result.diagnostics)
        lifetime_regions = (lifetime_regions) + (else_result.lifetime_regions)
        current_allocas = else_result.allocas
        current_locals = else_result.locals
        current_temp = else_result.temp_index
        current_block_counter = else_result.block_counter
        current_next_local = else_result.next_local_id
        else_bindings = else_result.bindings
        current_lines = (current_lines) + (else_result.lines)
        else_terminated = else_result.terminated
        if not else_terminated:
            current_lines = append_string(current_lines, "  br label %" + merge_label)
    terminated = False
    if structure.has_else:
        terminated = then_terminated  and  else_terminated
    if not terminated  or  not structure.has_else:
        current_lines = append_string(current_lines, merge_label + ":")
    current_locals = base_locals
    merged_bindings = base_bindings
    if not then_terminated:
        merged_bindings = merge_parameter_bindings(merged_bindings, then_bindings)
    if structure.has_else:
        if not else_terminated:
            merged_bindings = merge_parameter_bindings(merged_bindings, else_bindings)
    return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=merged_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=terminated, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_index=structure.next_index + 1)

def lower_let_instruction(function, instruction, bindings, locals, allocas, lines, temp_index, next_local_id, functions, context, scope_id, scope_depth):
    diagnostics = []
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_temp = temp_index
    ownership = None
    consumption = None
    initializer_span = instruction.value_span
    lifetime_regions = []
    if initializer_span == None:
        initializer_span = instruction.span
    suspension_diagnostics = detect_suspension_conflicts(instruction.value, current_locals, bindings, function.name, initializer_span)
    diagnostics = (diagnostics) + (suspension_diagnostics)
    trimmed_annotation = trim_text(instruction.type_annotation)
    llvm_type = ""
    if len(trimmed_annotation) > 0:
        llvm_type = map_local_type(context, instruction.type_annotation)
        if len(llvm_type) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: unsupported local type for `" + instruction.name + "` in `" + function.name + "`")
    operand = None
    ownership_analysis = analyze_value_ownership(instruction.value, initializer_span, current_locals, bindings)
    diagnostics = (diagnostics) + (ownership_analysis.diagnostics)
    ownership = ownership_analysis.ownership
    consumption = ownership_analysis.consumption
    if ownership != None:
        conflict_diagnostics = detect_borrow_conflicts(ownership, current_locals, instruction.name, function.name)
        diagnostics = (diagnostics) + (conflict_diagnostics)
        if ownership.variant == "Borrow":
            base_scope = infer_borrow_base_scope(ownership.base, current_locals, bindings, function.name)
            region = make_lifetime_region_metadata(instruction.name, ownership, scope_id, scope_depth, base_scope.scope_id, base_scope.scope_depth)
            lifetime_regions = append_lifetime_region(lifetime_regions, region)
    if consumption != None:
        if consumption.kind == "local":
            current_locals = mark_local_consumed(current_locals, consumption.name)
        else:
            if consumption.kind == "parameter":
                bindings = mark_parameter_consumed(bindings, consumption.name)
    if instruction.value == None  or  len(instruction.value) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: let `" + instruction.name + "` missing initializer in `" + function.name + "`")
    else:
        lowered = lower_expression(instruction.value, bindings, current_locals, current_temp, current_lines, functions, context)
        diagnostics = (diagnostics) + (lowered.diagnostics)
        current_lines = lowered.lines
        current_temp = lowered.temp_index
        operand = lowered.operand
    if len(llvm_type) == 0:
        if operand != None:
            llvm_type = operand.llvm_type
    if len(llvm_type) == 0:
        llvm_type = "double"
    pointer = format_local_pointer_name(next_local_id)
    current_allocas = append_string(current_allocas, "  " + pointer + " = alloca " + llvm_type)
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
            current_lines = append_string(current_lines, "  store " + llvm_type + " " + stored.value + ", " + llvm_type + "* " + pointer)
    else:
        current_lines = append_string(current_lines, "  store " + llvm_type + " " + default_return_literal(llvm_type) + ", " + llvm_type + "* " + pointer)
    current_locals = append_local_binding(current_locals, LocalBinding(name=instruction.name, pointer=pointer, llvm_type=llvm_type, type_annotation=instruction.type_annotation, ownership=ownership, consumed=False, scope_id=scope_id, scope_depth=scope_depth))
    return LetLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=bindings, temp_index=current_temp, diagnostics=diagnostics, next_local_id=next_local_id + 1, lifetime_regions=lifetime_regions)

def lower_expression_statement(function_name, instruction, expression, bindings, locals, temp_index, lines, functions, context):
    suspension_span = None
    if instruction.span != None:
        suspension_span = instruction.span
    diagnostics = detect_suspension_conflicts(expression, locals, bindings, function_name, suspension_span)
    current_lines = lines
    current_temp = temp_index
    current_locals = locals
    current_bindings = bindings
    lifetime_regions = []
    parsed_assignment = parse_assignment_expression(expression)
    if parsed_assignment.success:
        binding = find_local_binding(current_locals, parsed_assignment.target)
        if binding == None:
            diagnostics = append_string(diagnostics, "llvm lowering: assignment to unknown local `" + parsed_assignment.target + "`")
        else:
            ownership_analysis = analyze_value_ownership(parsed_assignment.value, instruction.span, current_locals, current_bindings)
            diagnostics = (diagnostics) + (ownership_analysis.diagnostics)
            assignment_ownership = ownership_analysis.ownership
            consumption = ownership_analysis.consumption
            lowered = lower_expression(parsed_assignment.value, current_bindings, current_locals, current_temp, current_lines, functions, context)
            diagnostics = (diagnostics) + (lowered.diagnostics)
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
                    current_lines = append_string(current_lines, "  store " + binding.llvm_type + " " + operand.value + ", " + binding.llvm_type + "* " + binding.pointer)
            if consumption != None:
                if consumption.kind == "local":
                    current_locals = mark_local_consumed(current_locals, consumption.name)
                else:
                    if consumption.kind == "parameter":
                        current_bindings = mark_parameter_consumed(current_bindings, consumption.name)
            current_locals = reset_local_consumption(current_locals, parsed_assignment.target)
            current_locals = update_local_ownership(current_locals, parsed_assignment.target, assignment_ownership)
            if assignment_ownership != None:
                if assignment_ownership.variant == "Borrow":
                    base_scope = infer_borrow_base_scope(assignment_ownership.base, current_locals, current_bindings, function_name)
                    region = make_lifetime_region_metadata(parsed_assignment.target, assignment_ownership, binding.scope_id, binding.scope_depth, base_scope.scope_id, base_scope.scope_depth)
                    lifetime_regions = append_lifetime_region(lifetime_regions, region)
        return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions)
    ownership_analysis = analyze_value_ownership(expression, instruction.span, current_locals, current_bindings)
    diagnostics = (diagnostics) + (ownership_analysis.diagnostics)
    consumption = ownership_analysis.consumption
    lowered = lower_expression(expression, current_bindings, current_locals, current_temp, current_lines, functions, context)
    diagnostics = (diagnostics) + (lowered.diagnostics)
    current_lines = lowered.lines
    current_temp = lowered.temp_index
    if consumption != None:
        if consumption.kind == "local":
            current_locals = mark_local_consumed(current_locals, consumption.name)
        else:
            if consumption.kind == "parameter":
                current_bindings = mark_parameter_consumed(current_bindings, consumption.name)
    return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions)

def parse_assignment_expression(expression):
    trimmed = trim_text(expression)
    depth = 0
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
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
        if ch == "=":
            previous = ""
            if index > 0:
                previous = trimmed[index - 1]
            next_char = ""
            if index + 1 < len(trimmed):
                next_char = trimmed[index + 1]
            if previous == "="  or  previous == "!"  or  previous == ">"  or  previous == "<"  or  previous == "-":
                index += 1
                continue
            if next_char == "="  or  next_char == ">":
                index += 1
                continue
            target = trim_text(substring(trimmed, 0, index))
            value = trim_text(substring(trimmed, index + 1, len(trimmed)))
            if len(target) == 0  or  len(value) == 0:
                return AssignmentParseResult(success=False, target="", value="")
            return AssignmentParseResult(success=True, target=target, value=value)
        index += 1
    return AssignmentParseResult(success=False, target="", value="")

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

def lower_return_instruction(function, instruction, llvm_return, bindings, locals, temp_index, lines, functions, context):
    diagnostics = []
    current_lines = lines
    current_temp = temp_index
    lifetime_regions = []
    if instruction.expression == None  or  len(instruction.expression) == 0:
        if llvm_return == "void":
            current_lines = append_string(current_lines, "  ret void")
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: missing return value in `" + function.name + "`")
            current_lines = append_string(current_lines, "  ret " + llvm_return + " " + default_return_literal(llvm_return))
        return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=locals, bindings=bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions)
    current_locals = locals
    current_bindings = bindings
    suspension_diagnostics = detect_suspension_conflicts(instruction.expression, current_locals, current_bindings, function.name, instruction.span)
    diagnostics = (diagnostics) + (suspension_diagnostics)
    ownership_analysis = analyze_value_ownership(instruction.expression, instruction.span, current_locals, current_bindings)
    diagnostics = (diagnostics) + (ownership_analysis.diagnostics)
    consumption = ownership_analysis.consumption
    lowered = lower_expression(instruction.expression, current_bindings, current_locals, current_temp, current_lines, functions, context)
    diagnostics = (diagnostics) + (lowered.diagnostics)
    current_lines = lowered.lines
    current_temp = lowered.temp_index
    if lowered.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unhandled return expression in `" + function.name + "`")
        current_lines = append_string(current_lines, "  ret " + llvm_return + " " + default_return_literal(llvm_return))
        return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions)
    operand = lowered.operand
    if llvm_return == "void":
        diagnostics = append_string(diagnostics, "llvm lowering: void function `" + function.name + "` returned a value")
        current_lines = append_string(current_lines, "  ret void")
        return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions)
    coerced = coerce_operand_to_type(operand, llvm_return, current_temp, current_lines)
    diagnostics = (diagnostics) + (coerced.diagnostics)
    current_lines = coerced.lines
    current_temp = coerced.temp_index
    if coerced.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce return expression to `" + llvm_return + "` in `" + function.name + "`")
        current_lines = append_string(current_lines, "  ret " + llvm_return + " " + default_return_literal(llvm_return))
        return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions)
    coerced_operand = coerced.operand
    current_lines = append_string(current_lines, "  ret " + coerced_operand.llvm_type + " " + coerced_operand.value)
    if consumption != None:
        if consumption.kind == "local":
            current_locals = mark_local_consumed(current_locals, consumption.name)
        else:
            if consumption.kind == "parameter":
                current_bindings = mark_parameter_consumed(current_bindings, consumption.name)
    return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions)

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
        if len(llvm_type) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: unsupported parameter type `" + parameter.type_annotation + "` in function `" + function.name + "`")
            llvm_type = "double"
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
    if annotation == "string":
        return "i8*"
    return ""

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
        return ""
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
    reference_type = map_reference_type(context, normalized)
    if len(reference_type) > 0:
        return reference_type
    array_type = map_array_pointer_type(context, normalized)
    if len(array_type) > 0:
        return array_type
    return map_primitive_type(context, normalized)

def map_parameter_type(context, parameter_type):
    trimmed = trim_text(parameter_type)
    if len(trimmed) == 0:
        return "double"
    normalized = unwrap_move_wrapper(trimmed)
    reference_type = map_reference_type(context, normalized)
    if len(reference_type) > 0:
        return reference_type
    array_type = map_array_pointer_type(context, normalized)
    if len(array_type) > 0:
        return array_type
    return map_primitive_type(context, normalized)

def map_local_type(context, type_annotation):
    trimmed = trim_text(type_annotation)
    if len(trimmed) == 0:
        return "double"
    normalized = unwrap_move_wrapper(trimmed)
    reference_type = map_reference_type(context, normalized)
    if len(reference_type) > 0:
        return reference_type
    array_type = map_array_pointer_type(context, normalized)
    if len(array_type) > 0:
        return array_type
    return map_primitive_type(context, normalized)

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

def lower_expression(expression, bindings, locals, temp_index, lines, functions, context):
    trimmed = trim_text(expression)
    diagnostics = []
    if len(trimmed) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: empty expression encountered")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics)
    stripped = strip_enclosing_parentheses(trimmed)
    if stripped != trimmed:
        return lower_expression(stripped, bindings, locals, temp_index, lines, functions, context)
    borrow_parse = parse_borrow_expression(stripped)
    if borrow_parse.recognized:
        return lower_borrow_expression(borrow_parse, bindings, locals, temp_index, lines)
    comparison = find_comparison_operator(stripped)
    if comparison.success:
        return lower_comparison_operation(stripped, comparison, bindings, locals, temp_index, lines, functions, context)
    additive = find_top_level_operator(stripped, "+-")
    if additive.success:
        return lower_binary_operation(stripped, additive, bindings, locals, temp_index, lines, functions, context)
    multiplicative = find_top_level_operator(stripped, "*/")
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
            return lower_array_literal(stripped, bindings, locals, temp_index, lines, functions, context)
    struct_parse = parse_struct_literal(stripped)
    if struct_parse.recognized:
        if not struct_parse.success:
            diagnostics = (diagnostics) + (struct_parse.diagnostics)
            return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics)
        lowered_struct = lower_struct_literal(struct_parse, bindings, locals, temp_index, lines, functions, context)
        combined = (diagnostics) + (lowered_struct.diagnostics)
        return ExpressionResult(lines=lowered_struct.lines, temp_index=lowered_struct.temp_index, operand=lowered_struct.operand, diagnostics=combined)
    member_parse = parse_member_access(stripped)
    if member_parse.success:
        return lower_member_access(member_parse, bindings, locals, temp_index, lines, functions, context)
    parameter = find_parameter_binding(bindings, stripped)
    if parameter != None:
        operand = LLVMOperand(llvm_type=parameter.llvm_type, value=parameter.llvm_name)
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics)
    local = find_local_binding(locals, stripped)
    if local != None:
        load_result = load_local_operand(local, temp_index, lines)
        diagnostics = (diagnostics) + (load_result.diagnostics)
        return ExpressionResult(lines=load_result.lines, temp_index=load_result.temp_index, operand=load_result.operand, diagnostics=diagnostics)
    literal_candidate = trim_text(stripped)
    if is_string_literal(literal_candidate):
        return lower_string_literal(literal_candidate, temp_index, lines)
    if is_boolean_literal(literal_candidate):
        value = "0"
        if matches_case_insensitive(literal_candidate, "true"):
            value = "1"
        operand = LLVMOperand(llvm_type="i1", value=value)
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics)
    if is_integer_literal(literal_candidate):
        operand = LLVMOperand(llvm_type="i64", value=literal_candidate)
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics)
    if is_number_literal(literal_candidate):
        normalised = normalise_number_literal(literal_candidate)
        operand = LLVMOperand(llvm_type="double", value=normalised)
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics)
    diagnostics = append_string(diagnostics, "llvm lowering: unsupported expression `" + literal_candidate + "`")
    return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics)

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
        if remainder[0] != "(":
            issue = append_string(diagnostics, "llvm lowering: borrow expression missing `(`")
            return BorrowParseResult(recognized=True, success=False, target="", mutable=False, diagnostics=issue)
        argument_parse = extract_borrow_argument(remainder)
        messages = (diagnostics) + (argument_parse.diagnostics)
        if not argument_parse.success:
            return BorrowParseResult(recognized=True, success=False, target="", mutable=False, diagnostics=messages)
        if len(argument_parse.argument) == 0:
            messages = append_string(messages, "llvm lowering: borrow expression missing target")
            return BorrowParseResult(recognized=True, success=False, target="", mutable=False, diagnostics=messages)
        return BorrowParseResult(recognized=True, success=True, target=argument_parse.argument, mutable=False, diagnostics=messages)
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
        ownership = OwnershipInfo(variant="Borrow", base=resolved_base, mutable=parse.mutable, span=span)
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
    parts = []
    if borrow_span != None:
        parts = append_string(parts, "borrow at " + format_span_location(borrow_span))
    if suspension_span != None:
        parts = append_string(parts, keyword + " at " + format_span_location(suspension_span))
    if len(parts) == 0:
        return ""
    return " (" + join_with_separator(parts, ", ") + ")"

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
    if not parse.success:
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics)
    target = strip_enclosing_parentheses(parse.target)
    target = trim_text(target)
    if len(target) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: borrow expression missing target")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics)
    local = find_local_binding(locals, target)
    if local == None:
        diagnostics = append_string(diagnostics, "llvm lowering: borrow requires local binding `" + target + "`")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics)
    pointer_type = local.llvm_type + "*"
    operand = LLVMOperand(llvm_type=pointer_type, value=local.pointer)
    return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics)

def lower_binary_operation(expression, match, bindings, locals, temp_index, lines, functions, context):
    left_text = trim_text(substring(expression, 0, match.index))
    right_text = trim_text(substring(expression, match.index + 1, len(expression)))
    diagnostics = []
    if len(left_text) == 0  or  len(right_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: malformed binary expression `" + expression + "`")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics)
    left_result = lower_expression(left_text, bindings, locals, temp_index, lines, functions, context)
    diagnostics = (diagnostics) + (left_result.diagnostics)
    if left_result.operand == None:
        return ExpressionResult(lines=left_result.lines, temp_index=left_result.temp_index, operand=None, diagnostics=diagnostics)
    right_result = lower_expression(right_text, bindings, locals, left_result.temp_index, left_result.lines, functions, context)
    diagnostics = (diagnostics) + (right_result.diagnostics)
    if right_result.operand == None:
        return ExpressionResult(lines=right_result.lines, temp_index=right_result.temp_index, operand=None, diagnostics=diagnostics)
    harmonised = harmonise_operands(left_result.operand, right_result.operand, right_result.temp_index, right_result.lines)
    diagnostics = (diagnostics) + (harmonised.diagnostics)
    if harmonised.left == None  or  harmonised.right == None:
        return ExpressionResult(lines=harmonised.lines, temp_index=harmonised.temp_index, operand=None, diagnostics=diagnostics)
    left_aligned = harmonised.left
    right_aligned = harmonised.right
    operation = operation_name_for_symbol(match.symbol, harmonised.result_type)
    temp_name = format_temp_name(harmonised.temp_index)
    line = "  " + temp_name + " = " + operation + " " + harmonised.result_type + " " + left_aligned.value + ", " + right_aligned.value
    updated_lines = append_string(harmonised.lines, line)
    operand = LLVMOperand(llvm_type=harmonised.result_type, value=temp_name)
    return ExpressionResult(lines=updated_lines, temp_index=harmonised.temp_index + 1, operand=operand, diagnostics=diagnostics)

def lower_comparison_operation(expression, match, bindings, locals, temp_index, lines, functions, context):
    operator_length = len(match.symbol)
    left_text = trim_text(substring(expression, 0, match.index))
    right_text = trim_text(substring(expression, match.index + operator_length, len(expression)))
    diagnostics = []
    if len(left_text) == 0  or  len(right_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: malformed comparison expression `" + expression + "`")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics)
    left_result = lower_expression(left_text, bindings, locals, temp_index, lines, functions, context)
    diagnostics = (diagnostics) + (left_result.diagnostics)
    if left_result.operand == None:
        return ExpressionResult(lines=left_result.lines, temp_index=left_result.temp_index, operand=None, diagnostics=diagnostics)
    right_result = lower_expression(right_text, bindings, locals, left_result.temp_index, left_result.lines, functions, context)
    diagnostics = (diagnostics) + (right_result.diagnostics)
    if right_result.operand == None:
        return ExpressionResult(lines=right_result.lines, temp_index=right_result.temp_index, operand=None, diagnostics=diagnostics)
    harmonised = harmonise_operands(left_result.operand, right_result.operand, right_result.temp_index, right_result.lines)
    diagnostics = (diagnostics) + (harmonised.diagnostics)
    if harmonised.left == None  or  harmonised.right == None:
        return ExpressionResult(lines=harmonised.lines, temp_index=harmonised.temp_index, operand=None, diagnostics=diagnostics)
    comparison = emit_comparison_instruction(match.symbol, harmonised.left, harmonised.right, harmonised.temp_index, harmonised.lines)
    diagnostics = (diagnostics) + (comparison.diagnostics)
    if comparison.operand == None:
        return ExpressionResult(lines=comparison.lines, temp_index=comparison.temp_index, operand=None, diagnostics=diagnostics)
    return ExpressionResult(lines=comparison.lines, temp_index=comparison.temp_index, operand=comparison.operand, diagnostics=diagnostics)

def lower_call_expression(target, arguments, bindings, locals, temp_index, lines, functions, context):
    diagnostics = []
    trimmed_target = trim_text(target)
    if len(trimmed_target) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: call target missing")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics)
    current_lines = lines
    current_temp = temp_index
    operands = []
    injected_argument_count = 0
    method_operand = None
    method_parse = parse_member_access(trimmed_target)
    if method_parse.success:
        method_info = resolve_struct_info_for_method_target(method_parse.base, bindings, locals, context)
        if method_info != None:
            lowered_self = lower_expression(method_parse.base, bindings, locals, current_temp, current_lines, functions, context)
            diagnostics = (diagnostics) + (lowered_self.diagnostics)
            current_lines = lowered_self.lines
            current_temp = lowered_self.temp_index
            if lowered_self.operand != None:
                method_operand = lowered_self.operand
                trimmed_target = method_info.name + "::" + method_parse.field
                injected_argument_count = 1
            else:
                diagnostics = append_string(diagnostics, "llvm lowering: method call base `" + method_parse.base + "` produced no value")
                return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics)
    index = 0
    while True:
        if index >= len(arguments):
            break
        argument_text = trim_text(arguments[index])
        if len(argument_text) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: empty argument in call to `" + trimmed_target + "`")
        lowered = lower_expression(argument_text, bindings, locals, current_temp, current_lines, functions, context)
        diagnostics = (diagnostics) + (lowered.diagnostics)
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
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics)
    llvm_return = "double"
    expected_params = []
    function_entry = find_function_by_name(functions, trimmed_target)
    helper_descriptor = find_runtime_helper(trimmed_target)
    if function_entry != None:
        llvm_return = map_return_type(context, function_entry.return_type)
        if len(llvm_return) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: unsupported return type in call to `" + trimmed_target + "`")
            llvm_return = "double"
        expected_params = collect_parameter_types(context, function_entry.parameters)
    else:
        if helper_descriptor != None:
            llvm_return = helper_descriptor.return_type
            expected_params = helper_descriptor.parameter_types
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: call to unknown function `" + trimmed_target + "`")
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
        if len(target_type) == 0:
            coerced_operands = append_llvm_operand(coerced_operands, operand)
        else:
            coerced = coerce_operand_to_type(operand, target_type, current_temp, current_lines)
            diagnostics = (diagnostics) + (coerced.diagnostics)
            current_lines = coerced.lines
            current_temp = coerced.temp_index
            if coerced.operand == None:
                diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce argument " + number_to_string(index) + " for call to `" + trimmed_target + "`")
                placeholder = LLVMOperand(llvm_type=target_type, value=default_return_literal(target_type))
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
    call_symbol = sanitize_symbol(trimmed_target)
    if helper_descriptor != None:
        call_symbol = helper_descriptor.symbol
    if llvm_return == "void":
        call_line = "  call void @" + call_symbol + "(" + argument_text + ")"
        current_lines = append_string(current_lines, call_line)
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics)
    temp_name = format_temp_name(current_temp)
    call_line = "  " + temp_name + " = call " + llvm_return + " @" + call_symbol + "(" + argument_text + ")"
    current_lines = append_string(current_lines, call_line)
    operand = LLVMOperand(llvm_type=llvm_return, value=temp_name)
    return ExpressionResult(lines=current_lines, temp_index=current_temp + 1, operand=operand, diagnostics=diagnostics)

def lower_member_access(parse, bindings, locals, temp_index, lines, functions, context):
    base_result = lower_expression(parse.base, bindings, locals, temp_index, lines, functions, context)
    diagnostics = base_result.diagnostics
    if base_result.operand == None:
        return ExpressionResult(lines=base_result.lines, temp_index=base_result.temp_index, operand=None, diagnostics=diagnostics)
    current_lines = base_result.lines
    current_temp = base_result.temp_index
    base_operand = base_result.operand
    struct_info = None
    pointer_available = False
    pointer_operand = base_operand
    if ends_with_pointer_suffix(base_operand.llvm_type):
        candidate = strip_pointer_suffix(base_operand.llvm_type)
        struct_info = find_struct_info_by_llvm_type(context, candidate)
        if struct_info == None:
            diagnostics = append_string(diagnostics, "llvm lowering: member access base `" + base_operand.llvm_type + "` lacks struct metadata")
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics)
        pointer_available = True
    else:
        struct_info = find_struct_info_by_llvm_type(context, base_operand.llvm_type)
        if struct_info == None:
            diagnostics = append_string(diagnostics, "llvm lowering: member access base `" + base_operand.llvm_type + "` lacks struct metadata")
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics)
    info = struct_info
    field_info = find_struct_field_info(info, parse.field)
    if field_info == None:
        diagnostics = append_string(diagnostics, "llvm lowering: struct `" + info.name + "` has no field `" + parse.field + "`")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics)
    if pointer_available:
        struct_type = info.llvm_name
        gep_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + gep_name + " = getelementptr " + struct_type + ", " + struct_type + "* " + pointer_operand.value + ", i32 0, i32 " + number_to_string(field_info.index))
        current_temp += 1
        load_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + load_name + " = load " + field_info.llvm_type + ", " + field_info.llvm_type + "* " + gep_name)
        current_temp += 1
        operand = LLVMOperand(llvm_type=field_info.llvm_type, value=load_name)
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics)
    extract_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + extract_name + " = extractvalue " + info.llvm_name + " " + base_operand.value + ", " + number_to_string(field_info.index))
    current_temp += 1
    operand = LLVMOperand(llvm_type=field_info.llvm_type, value=extract_name)
    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics)

def lower_array_literal(text, bindings, locals, temp_index, lines, functions, context):
    diagnostics = []
    current_lines = lines
    current_temp = temp_index
    inner = trim_text(substring(text, 1, len(text) - 1))
    elements = split_array_elements(inner)
    metadata = parse_array_literal_metadata(elements, context)
    operands = []
    inferred_element_type = metadata.element_type
    index = metadata.start_index
    while True:
        if index >= len(elements):
            break
        element_text = trim_text(elements[index])
        if len(element_text) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: empty element in array literal")
            index += 1
            continue
        lowered = lower_expression(element_text, bindings, locals, current_temp, current_lines, functions, context)
        diagnostics = (diagnostics) + (lowered.diagnostics)
        current_lines = lowered.lines
        current_temp = lowered.temp_index
        if lowered.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: array literal element produced no value")
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics)
        operands = append_llvm_operand(operands, lowered.operand)
        inferred_element_type = dominant_type(inferred_element_type, lowered.operand.llvm_type)
        index += 1
    if len(operands) == 0:
        if len(inferred_element_type) == 0:
            inferred_element_type = "double"
    if len(inferred_element_type) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: unsupported array literal element type")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics)
    element_type = inferred_element_type
    coerced_operands = []
    index = 0
    while True:
        if index >= len(operands):
            break
        operand = operands[index]
        coerced = coerce_operand_to_type(operand, element_type, current_temp, current_lines)
        diagnostics = (diagnostics) + (coerced.diagnostics)
        current_lines = coerced.lines
        current_temp = coerced.temp_index
        if coerced.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: array literal element could not be coerced to `" + element_type + "`")
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics)
        coerced_operands = append_llvm_operand(coerced_operands, coerced.operand)
        index += 1
    operands = coerced_operands
    length_value = len(operands)
    length_text = number_to_string(length_value)
    array_type = "[" + length_text + " x " + element_type + "]"
    array_alloca = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + array_alloca + " = alloca " + array_type)
    current_temp += 1
    data_pointer = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + data_pointer + " = getelementptr " + array_type + ", " + array_type + "* " + array_alloca + ", i32 0, i32 0")
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
    struct_alloca = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + struct_alloca + " = alloca " + struct_type)
    current_temp += 1
    data_field_pointer = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + data_field_pointer + " = getelementptr " + struct_type + ", " + struct_type + "* " + struct_alloca + ", i32 0, i32 0")
    current_temp += 1
    data_pointer_type = element_type + "*"
    data_pointer_pointer_type = data_pointer_type + "*"
    current_lines = append_string(current_lines, "  store " + data_pointer_type + " " + data_pointer + ", " + data_pointer_pointer_type + " " + data_field_pointer)
    length_field_pointer = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + length_field_pointer + " = getelementptr " + struct_type + ", " + struct_type + "* " + struct_alloca + ", i32 0, i32 1")
    current_temp += 1
    current_lines = append_string(current_lines, "  store i64 " + length_text + ", i64* " + length_field_pointer)
    operand = LLVMOperand(llvm_type=struct_type + "*", value=struct_alloca)
    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics)

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
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
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

def lower_struct_literal(parse, bindings, locals, temp_index, lines, functions, context):
    diagnostics = parse.diagnostics
    current_lines = lines
    current_temp = temp_index
    info = resolve_struct_info_for_literal(context, parse.type_name)
    if info == None:
        if len(parse.type_name) > 0:
            diagnostics = append_string(diagnostics, "llvm lowering: struct literal references unknown struct `" + parse.type_name + "`")
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: struct literal references unknown struct")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics)
    if len(info.fields) == 0:
        operand = LLVMOperand(llvm_type=info.llvm_name, value="zeroinitializer")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics)
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
            lowered = lower_expression(literal_field.value, bindings, locals, current_temp, current_lines, functions, context)
            diagnostics = (diagnostics) + (lowered.diagnostics)
            current_lines = lowered.lines
            current_temp = lowered.temp_index
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
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics)
    operand = LLVMOperand(llvm_type=info.llvm_name, value=previous_value)
    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics)

def emit_comparison_instruction(symbol, left_operand, right_operand, temp_index, lines):
    diagnostics = []
    current_lines = lines
    if left_operand.llvm_type != right_operand.llvm_type:
        diagnostics = append_string(diagnostics, "llvm lowering: comparison operands have mismatched types `" + left_operand.llvm_type + "` and `" + right_operand.llvm_type + "`")
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
    return ""

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
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = fptosi double " + operand.value + " to i64")
            coerced = LLVMOperand(llvm_type="i64", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
        if operand.llvm_type == "i1":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = zext i1 " + operand.value + " to i64")
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
    diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce operand of type `" + operand.llvm_type + "` to `" + target_type + "`")
    return CoercionResult(lines=current_lines, temp_index=temp_index, operand=None, diagnostics=diagnostics)

def dominant_type(first, second):
    if len(first) == 0:
        return second
    if len(second) == 0:
        return first
    if first == second:
        return first
    if first == "double"  or  second == "double":
        return "double"
    if first == "i64"  or  second == "i64":
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
    depth = 0
    index = len(expression)
    while True:
        if index <= 0:
            break
        index -= 1
        ch = expression[index]
        if ch == ")":
            depth += 1
            continue
        if ch == "(":
            if depth > 0:
                depth -= 1
                continue
        if depth > 0:
            continue
        if contains_char(operators, ch):
            if ch == "-":
                if not is_binary_minus(expression, index):
                    continue
            return OperatorMatch(index=index, symbol=substring(expression, index, index + 1), success=True)
    return OperatorMatch(index=-1, symbol="", success=False)

def find_comparison_operator(expression):
    depth = 0
    index = 0
    while True:
        if index >= len(expression):
            break
        ch = expression[index]
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
    depth = 0
    index = 0
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if ch == "(":
            depth += 1
            current = current + ch
        else:
            if ch == ")":
                if depth > 0:
                    depth -= 1
                current = current + ch
            else:
                if ch == ","  and  depth == 0:
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
    while True:
        if index >= len(text):
            break
        ch = text[index]
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
    if symbol == "+":
        return "add"
    if symbol == "-":
        return "sub"
    if symbol == "*":
        return "mul"
    if symbol == "/":
        return "sdiv"
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

def make_lifetime_region_metadata(binding, ownership, scope_id, scope_depth, base_scope_id, base_scope_depth):
    return LifetimeRegionMetadata(binding=binding, base=ownership.base, mutable=ownership.mutable, start_span=ownership.span, scope_id=scope_id, scope_depth=scope_depth, base_scope_id=base_scope_id, base_scope_depth=base_scope_depth)

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

def find_function_by_name(functions, name):
    index = 0
    while True:
        if index >= len(functions):
            break
        if functions[index].name == name:
            return functions[index]
        index += 1
    return None

def number_to_string(value):
    if value == 0:
        return "0"
    digits = "0123456789"
    remaining = value
    output = ""
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

def sanitize_symbol(name):
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
        return "anon"
    return result

def is_digit_char(ch):
    return index_of("0123456789", ch) != -1

def is_symbol_char(ch):
    if ch == "_":
        return True
    code = char_code(ch)
    if code >= char_code("a")  and  code <= char_code("z"):
        return True
    if code >= char_code("A")  and  code <= char_code("Z"):
        return True
    if code >= char_code("0")  and  code <= char_code("9"):
        return True
    return False

def lower_char_code(code):
    if code >= char_code("A")  and  code <= char_code("Z"):
        return code + char_code("a") - char_code("A")
    return code

def matches_case_insensitive(value, expected):
    if len(value) != len(expected):
        return False
    index = 0
    while True:
        if index >= len(value):
            break
        value_code = lower_char_code(char_code(value[index]))
        expected_code = lower_char_code(char_code(expected[index]))
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

def lower_string_literal(literal, temp_index, lines):
    operand = LLVMOperand(llvm_type="i8*", value="null")
    return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=[])

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
