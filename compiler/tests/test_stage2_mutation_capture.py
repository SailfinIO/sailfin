from __future__ import annotations

import pytest

from compiler.build.native_llvm_lowering import (
    TypeContext,
    format_root_scope_id,
    lower_instruction_range,
    prepare_parameters,
)
from compiler.build.native_ir import NativeFunction, NativeInstruction
from runtime import runtime_support as runtime

pytestmark = [pytest.mark.unit, pytest.mark.stage2]


def test_lower_instruction_range_records_local_mutations() -> None:
    let_instruction = runtime.enum_instantiate(
        NativeInstruction,
        "Let",
        [
            runtime.enum_field("name", "value"),
            runtime.enum_field("mutable", False),
            runtime.enum_field("type_annotation", "number"),
            runtime.enum_field("value", "1"),
            runtime.enum_field("span", None),
            runtime.enum_field("value_span", None),
        ],
    )

    assign_instruction = runtime.enum_instantiate(
        NativeInstruction,
        "Expression",
        [
            runtime.enum_field("expression", "value = 2"),
            runtime.enum_field("span", None),
        ],
    )

    function = NativeFunction(
        name="mutation_capture",
        parameters=[],
        return_type="void",
        effects=[],
        instructions=[let_instruction, assign_instruction],
    )

    context = TypeContext(structs=[])
    prepared = prepare_parameters(function, context)
    assert prepared.diagnostics == []

    result = lower_instruction_range(
        function=function,
        start_index=0,
        end=len(function.instructions),
        llvm_return="void",
        bindings=prepared.bindings,
        locals=[],
        allocas=[],
        lines=[],
        temp_index=0,
        block_counter=0,
        next_local_id=0,
        next_region_id=0,
        functions=[function],
        loop_stack=[],
        context=context,
        scope_id=format_root_scope_id(function.name),
        scope_depth=0,
        current_label="entry",
    )

    assert result.diagnostics == []
    assert result.mutations and len(result.mutations) == 2

    let_mutation, assignment_mutation = result.mutations
    assert let_mutation.name == "value"
    assert let_mutation.llvm_type == "double"
    assert let_mutation.value_name
    assert let_mutation.originating_label == "entry"

    assert assignment_mutation.name == "value"
    assert assignment_mutation.llvm_type == "double"
    assert assignment_mutation.value_name
    assert assignment_mutation.originating_label == "entry"
