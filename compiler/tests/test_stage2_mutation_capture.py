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

    context = TypeContext(structs=[], enums=[])
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


def test_mutations_propagate_through_if_then() -> None:
    """Verify mutations from an if-then block are captured."""
    if_instruction = runtime.enum_instantiate(
        NativeInstruction,
        "If",
        [
            runtime.enum_field("condition", "true"),
            runtime.enum_field("span", None),
        ],
    )

    let_in_then = runtime.enum_instantiate(
        NativeInstruction,
        "Let",
        [
            runtime.enum_field("name", "x"),
            runtime.enum_field("mutable", False),
            runtime.enum_field("type_annotation", "number"),
            runtime.enum_field("value", "42"),
            runtime.enum_field("span", None),
            runtime.enum_field("value_span", None),
        ],
    )

    endif_instruction = runtime.enum_instantiate(
        NativeInstruction,
        "EndIf",
        [runtime.enum_field("span", None)],
    )

    function = NativeFunction(
        name="test_if",
        parameters=[],
        return_type="void",
        effects=[],
        instructions=[if_instruction, let_in_then, endif_instruction],
    )

    context = TypeContext(structs=[], enums=[])
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
    assert result.mutations and len(result.mutations) == 1

    mutation = result.mutations[0]
    assert mutation.name == "x"
    assert mutation.llvm_type == "double"
    assert "then" in mutation.originating_label


def test_mutations_propagate_through_if_else() -> None:
    """Verify mutations from both if and else blocks are captured."""
    if_instruction = runtime.enum_instantiate(
        NativeInstruction,
        "If",
        [
            runtime.enum_field("condition", "true"),
            runtime.enum_field("span", None),
        ],
    )

    let_in_then = runtime.enum_instantiate(
        NativeInstruction,
        "Let",
        [
            runtime.enum_field("name", "x"),
            runtime.enum_field("mutable", False),
            runtime.enum_field("type_annotation", "number"),
            runtime.enum_field("value", "1"),
            runtime.enum_field("span", None),
            runtime.enum_field("value_span", None),
        ],
    )

    else_instruction = runtime.enum_instantiate(
        NativeInstruction,
        "Else",
        [runtime.enum_field("span", None)],
    )

    let_in_else = runtime.enum_instantiate(
        NativeInstruction,
        "Let",
        [
            runtime.enum_field("name", "y"),
            runtime.enum_field("mutable", False),
            runtime.enum_field("type_annotation", "number"),
            runtime.enum_field("value", "2"),
            runtime.enum_field("span", None),
            runtime.enum_field("value_span", None),
        ],
    )

    endif_instruction = runtime.enum_instantiate(
        NativeInstruction,
        "EndIf",
        [runtime.enum_field("span", None)],
    )

    function = NativeFunction(
        name="test_if_else",
        parameters=[],
        return_type="void",
        effects=[],
        instructions=[
            if_instruction,
            let_in_then,
            else_instruction,
            let_in_else,
            endif_instruction,
        ],
    )

    context = TypeContext(structs=[], enums=[])
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

    then_mutation = result.mutations[0]
    assert then_mutation.name == "x"
    assert "then" in then_mutation.originating_label

    else_mutation = result.mutations[1]
    assert else_mutation.name == "y"
    assert "else" in else_mutation.originating_label


def test_mutations_propagate_through_loop() -> None:
    """Verify mutations from a loop body are captured."""
    loop_instruction = runtime.enum_instantiate(
        NativeInstruction,
        "Loop",
        [runtime.enum_field("span", None)],
    )

    let_in_loop = runtime.enum_instantiate(
        NativeInstruction,
        "Let",
        [
            runtime.enum_field("name", "counter"),
            runtime.enum_field("mutable", True),
            runtime.enum_field("type_annotation", "number"),
            runtime.enum_field("value", "0"),
            runtime.enum_field("span", None),
            runtime.enum_field("value_span", None),
        ],
    )

    break_instruction = runtime.enum_instantiate(
        NativeInstruction,
        "Break",
        [runtime.enum_field("span", None)],
    )

    endloop_instruction = runtime.enum_instantiate(
        NativeInstruction,
        "EndLoop",
        [runtime.enum_field("span", None)],
    )

    function = NativeFunction(
        name="test_loop",
        parameters=[],
        return_type="void",
        effects=[],
        instructions=[
            loop_instruction,
            let_in_loop,
            break_instruction,
            endloop_instruction,
        ],
    )

    context = TypeContext(structs=[], enums=[])
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
    assert result.mutations and len(result.mutations) == 1

    mutation = result.mutations[0]
    assert mutation.name == "counter"
    assert mutation.llvm_type == "double"
    assert "loop" in mutation.originating_label


def test_mutations_propagate_through_match() -> None:
    """Verify mutations from match arms are captured."""
    match_instruction = runtime.enum_instantiate(
        NativeInstruction,
        "Match",
        [
            runtime.enum_field("expression", "1"),
            runtime.enum_field("span", None),
        ],
    )

    case1_instruction = runtime.enum_instantiate(
        NativeInstruction,
        "Case",
        [
            runtime.enum_field("pattern", "1"),
            runtime.enum_field("guard", None),
            runtime.enum_field("span", None),
        ],
    )

    let_in_case1 = runtime.enum_instantiate(
        NativeInstruction,
        "Let",
        [
            runtime.enum_field("name", "a"),
            runtime.enum_field("mutable", False),
            runtime.enum_field("type_annotation", "number"),
            runtime.enum_field("value", "10"),
            runtime.enum_field("span", None),
            runtime.enum_field("value_span", None),
        ],
    )

    case2_instruction = runtime.enum_instantiate(
        NativeInstruction,
        "Case",
        [
            runtime.enum_field("pattern", "_"),
            runtime.enum_field("guard", None),
            runtime.enum_field("span", None),
        ],
    )

    let_in_case2 = runtime.enum_instantiate(
        NativeInstruction,
        "Let",
        [
            runtime.enum_field("name", "b"),
            runtime.enum_field("mutable", False),
            runtime.enum_field("type_annotation", "number"),
            runtime.enum_field("value", "20"),
            runtime.enum_field("span", None),
            runtime.enum_field("value_span", None),
        ],
    )

    endmatch_instruction = runtime.enum_instantiate(
        NativeInstruction,
        "EndMatch",
        [runtime.enum_field("span", None)],
    )

    function = NativeFunction(
        name="test_match",
        parameters=[],
        return_type="void",
        effects=[],
        instructions=[
            match_instruction,
            case1_instruction,
            let_in_case1,
            case2_instruction,
            let_in_case2,
            endmatch_instruction,
        ],
    )

    context = TypeContext(structs=[], enums=[])
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

    case1_mutation = result.mutations[0]
    assert case1_mutation.name == "a"
    assert "matchbody" in case1_mutation.originating_label

    case2_mutation = result.mutations[1]
    assert case2_mutation.name == "b"
    assert "matchbody" in case2_mutation.originating_label
