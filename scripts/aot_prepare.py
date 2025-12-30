"""Pure-Python AOT preparation for Stage2 LLVM modules.

This is a small, standalone port of the algorithm in the stage1-generated
`compiler/build/aot_prepare.py`.

We use it for native self-hosting builds so we can produce collision-free LLVM
modules for AOT linking *without* importing stage1-generated Python compiler
artifacts.

Public API:
  - prepare_stage2_aot_modules(module_names: list[str], module_texts: list[str]) -> list[str]
"""

from __future__ import annotations


def _number_to_string(value: int) -> str:
    return str(value)


def _matches_at(value: str, start: int, pattern: str) -> bool:
    if start < 0:
        return False
    pattern_len = len(pattern)
    value_len = len(value)
    if start + pattern_len > value_len:
        return False
    return value[start: start + pattern_len] == pattern


def _count_trailing_backslashes(text: str, before_index: int) -> int:
    count = 0
    index = before_index - 1
    while index >= 0 and text[index] == "\\":
        count += 1
        index -= 1
    return count


def _find_substring_outside_quotes(text: str, needle: str) -> int:
    needle_len = len(needle)
    if needle_len == 0:
        return 0
    i = 0
    text_len = len(text)
    in_quote = False
    while i < text_len:
        ch = text[i]
        if ch == '"':
            backslashes = _count_trailing_backslashes(text, i)
            if backslashes % 2 == 0:
                in_quote = not in_quote
            i += 1
            continue
        if not in_quote and _matches_at(text, i, needle):
            return i
        i += 1
    return -1


def _is_symbol_char(ch: str) -> bool:
    if not ch:
        return False
    if ch in ("_", ".", "$"):
        return True
    return ch.isalnum()


def _starts_with_at(text: str, start: int, prefix: str) -> bool:
    if start < 0:
        return False
    return text.startswith(prefix, start)


def _rename_symbol_refs(ir: str, old: str, fresh: str) -> str:
    old_len = len(old)
    if old_len == 0:
        return ir
    ir_len = len(ir)
    out_parts: list[str] = []
    i = 0
    last_emit = 0
    in_quote = False

    while i < ir_len:
        ch = ir[i]
        if ch == '"':
            backslashes = _count_trailing_backslashes(ir, i)
            if backslashes % 2 == 0:
                in_quote = not in_quote
            i += 1
            continue

        if (not in_quote) and ch == "@":
            if _starts_with_at(ir, i + 1, old):
                end = i + 1 + old_len
                if end >= ir_len or (not _is_symbol_char(ir[end])):
                    out_parts.append(ir[last_emit:i])
                    out_parts.append("@" + fresh)
                    i = end
                    last_emit = i
                    continue

        i += 1

    out_parts.append(ir[last_emit:ir_len])
    return "".join(out_parts)


def _trim_text(value: str) -> str:
    return value.strip(" \n\r\t")


def _parse_defined_function_name(line: str) -> str:
    trimmed = _trim_text(line)
    if len(trimmed) < 6 or not trimmed.startswith("define"):
        return ""

    at = trimmed.find("@")
    if at < 0:
        return ""

    index = at + 1
    start = index
    while index < len(trimmed) and _is_symbol_char(trimmed[index]):
        index += 1
    if index <= start:
        return ""
    return trimmed[start:index]


def _parse_defined_global_name(line: str) -> str:
    trimmed = _trim_text(line)
    if not trimmed or not trimmed.startswith("@"):
        return ""

    idx = 1
    start = idx
    while idx < len(trimmed) and _is_symbol_char(trimmed[idx]):
        idx += 1
    if idx <= start:
        return ""

    # Only count global/constant definitions.
    if "=" not in trimmed:
        return ""
    if " global" not in trimmed and " constant" not in trimmed:
        return ""

    return trimmed[start:idx]


def _split_lines(text: str) -> list[str]:
    # Keep behaviour close to the stage1-generated version.
    return text.split("\n")


def _append_unique(values: list[str], value: str) -> None:
    if value not in values:
        values.append(value)


def _find_defined_functions(ir: str) -> list[str]:
    functions: list[str] = []
    for line in _split_lines(ir):
        fun = _parse_defined_function_name(line)
        if fun:
            _append_unique(functions, fun)
    return functions


def _find_defined_globals(ir: str) -> list[str]:
    globals_: list[str] = []
    for line in _split_lines(ir):
        glob = _parse_defined_global_name(line)
        if glob:
            _append_unique(globals_, glob)
    return globals_


def _ensure_intrinsic_decls(ir: str) -> str:
    round_marker = "@round(double"
    round_decl = "declare double @round(double)"
    if _find_substring_outside_quotes(ir, round_marker) < 0:
        return ir
    if _find_substring_outside_quotes(ir, round_decl) >= 0:
        return ir

    decl_line = round_decl + "\n"
    source_at = ir.find("source_filename")
    if source_at < 0:
        return decl_line + ir

    # Insert after the source_filename line.
    line_end = ir.find("\n", source_at)
    if line_end < 0:
        return ir + "\n" + decl_line
    line_end += 1
    return ir[:line_end] + decl_line + ir[line_end:]


def prepare_stage2_aot_modules(module_names: list[str], module_texts: list[str]) -> list[str]:
    rewritten: list[str] = []
    seen_functions: list[str] = []
    seen_globals: list[str] = []

    for module_name, ir in zip(module_names, module_texts):
        if module_name == "main":
            ir = ir.replace("@main(", "@stage2_compiler_main(")

        defined_functions = _find_defined_functions(ir)
        defined_globals = _find_defined_globals(ir)

        for name in defined_functions:
            if name not in seen_functions:
                _append_unique(seen_functions, name)
                continue

            counter = 1
            while True:
                suffix = module_name if counter == 1 else module_name + \
                    "_" + _number_to_string(counter)
                candidate = name + "__" + suffix
                if candidate not in seen_functions:
                    break
                counter += 1

            ir = _rename_symbol_refs(ir, name, candidate)
            _append_unique(seen_functions, candidate)

        for name in defined_globals:
            if name not in seen_globals:
                _append_unique(seen_globals, name)
                continue

            counter = 1
            while True:
                suffix = module_name if counter == 1 else module_name + \
                    "_" + _number_to_string(counter)
                candidate = name + "__" + suffix
                if candidate not in seen_globals:
                    break
                counter += 1

            ir = _rename_symbol_refs(ir, name, candidate)
            _append_unique(seen_globals, candidate)

        ir = _ensure_intrinsic_decls(ir)
        rewritten.append(ir)

    return rewritten
