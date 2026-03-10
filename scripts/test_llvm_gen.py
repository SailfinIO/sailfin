#!/usr/bin/env python3
"""Generate correct LLVM IR from .sfn-asm test files.

Used when the native compiler's LLVM lowering is affected by seed ABI
corruption and cannot reliably produce correct test code. The .sfn-asm
emitter works correctly; only the LLVM lowering is broken.

Usage:
    python scripts/test_llvm_gen.py \\
        --compiler build/native/sailfin \\
        --test compiler/tests/unit/token_test.sfn

The script:
  1. Calls the compiler to emit .sfn-asm (the debug-test-native.sfn-asm file)
  2. Parses the .sfn-asm to extract enum/struct/function definitions
  3. Generates correct LLVM IR
  4. Compiles with llc + clang
  5. Runs the test binary
"""

from __future__ import annotations

import argparse
import dataclasses
import os
import pathlib
import re
import shutil
import subprocess
import sys

REPO_ROOT = pathlib.Path(__file__).resolve().parent.parent
BUILD_DIR = REPO_ROOT / "build" / "sailfin"


# ---------------------------------------------------------------------------
# Data structures
# ---------------------------------------------------------------------------

@dataclasses.dataclass
class EnumVariant:
    name: str
    tag: int


@dataclasses.dataclass
class EnumDef:
    name: str
    tag_type: str  # e.g. "i32"
    variants: list[EnumVariant]

    @property
    def llvm_name(self) -> str:
        return f"%{self.name}"


@dataclasses.dataclass
class StructField:
    name: str
    sfn_type: str   # e.g. "TokenKind", "string", "number"
    llvm_type: str  # e.g. "i8*", "double"
    index: int


@dataclasses.dataclass
class MethodDef:
    name: str
    struct_name: str
    params: list  # list[FunctionParam] — first is self
    return_type: str
    instructions: list[str]


@dataclasses.dataclass
class StructDef:
    name: str
    fields: list[StructField]
    methods: list[MethodDef] = dataclasses.field(default_factory=list)

    @property
    def llvm_name(self) -> str:
        return f"%{self.name}"

    @property
    def llvm_body(self) -> str:
        return "{ " + ", ".join(f.llvm_type for f in self.fields) + " }"


@dataclasses.dataclass
class FunctionParam:
    name: str
    sfn_type: str


@dataclasses.dataclass
class FunctionDef:
    name: str
    params: list[FunctionParam]
    return_type: str  # sfn type: "Token", "void", "number", etc.
    instructions: list[str]  # raw .sfn-asm instruction lines
    is_test: bool = False
    is_async: bool = False


@dataclasses.dataclass
class GlobalLet:
    name: str
    value: str  # raw expression string
    sfn_type: str  # inferred type


# ---------------------------------------------------------------------------
# .sfn-asm parser
# ---------------------------------------------------------------------------

def _sfn_type_to_llvm(sfn_type: str, enums: dict[str, EnumDef]) -> str:
    if sfn_type == "number":
        return "double"
    if sfn_type == "string":
        return "i8*"
    if sfn_type == "boolean":
        return "i1"
    if sfn_type == "void":
        return "void"
    if sfn_type.endswith("[]"):
        return "{ i8**, i64 }*"  # array type: data pointer + length
    if sfn_type in enums:
        return "i8*"  # enums are boxed as i8* pointers
    # struct types are also returned as i8*
    return "i8*"


def _async_category(sfn_ret_type: str) -> str:
    """Map a Sailfin return type to the async future category name."""
    if sfn_ret_type == "number":
        return "Number"
    if sfn_ret_type == "boolean":
        return "Bool"
    if sfn_ret_type == "string":
        return "String"
    if sfn_ret_type == "void":
        return "Void"
    return "Ptr"  # structs and other pointer types


def _has_unbalanced_brackets(text: str) -> bool:
    """Check if text has unbalanced [ ] brackets (outside strings)."""
    depth = 0
    in_str = False
    i = 0
    while i < len(text):
        ch = text[i]
        if ch == '"' and (i == 0 or text[i - 1] != '\\'):
            in_str = not in_str
        elif not in_str:
            if ch == '[':
                depth += 1
            elif ch == ']':
                depth -= 1
        i += 1
    return depth > 0


def _should_continue_line(text: str) -> bool:
    """Check if accumulated text needs more lines (ends with + or unbalanced brackets)."""
    return text.rstrip().endswith("+") or _has_unbalanced_brackets(text)


def parse_sfn_asm(text: str) -> tuple[dict[str, EnumDef], dict[str, StructDef], list[FunctionDef], list[GlobalLet]]:
    enums: dict[str, EnumDef] = {}
    structs: dict[str, StructDef] = {}
    functions: list[FunctionDef] = []
    globals_list: list[GlobalLet] = []

    lines = text.split("\n")
    i = 0
    while i < len(lines):
        line = lines[i].strip()

        # Skip span/init-span directives at module level
        if line.startswith(".span") or line.startswith(".init-span"):
            i += 1
            continue

        # Module-level .let binding
        if line.startswith(".let "):
            m = re.match(r'\.let (\w+) = (.+)', line)
            if m:
                name = m.group(1)
                value = m.group(2).strip()
                # Infer type from value
                if value.startswith('"'):
                    sfn_type = "string"
                elif re.match(r'^-?\d+\.?\d*$', value):
                    sfn_type = "number"
                elif value in ("true", "false"):
                    sfn_type = "boolean"
                else:
                    sfn_type = "string"
                globals_list.append(GlobalLet(name=name, value=value, sfn_type=sfn_type))
            i += 1
            continue

        # Enum definition
        if line.startswith(".enum "):
            enum_name = line[6:].strip()
            tag_type = "i32"
            variants: list[EnumVariant] = []
            i += 1
            while i < len(lines) and not lines[i].strip().startswith(".endenum"):
                eline = lines[i].strip()
                if eline.startswith(".layout enum "):
                    m = re.search(r"tag_type=(\w+)", eline)
                    if m:
                        tag_type = m.group(1)
                elif eline.startswith(".layout variant "):
                    m = re.match(r"\.layout variant (\w+) tag=(\d+)", eline)
                    if m:
                        variants.append(EnumVariant(name=m.group(1), tag=int(m.group(2))))
                i += 1
            enums[enum_name] = EnumDef(name=enum_name, tag_type=tag_type, variants=variants)
            i += 1
            continue

        # Struct definition
        if line.startswith(".struct "):
            struct_name = line[8:].strip()
            fields: list[StructField] = []
            methods: list[MethodDef] = []
            field_index = 0
            i += 1
            while i < len(lines) and not lines[i].strip().startswith(".endstruct"):
                sline = lines[i].strip()
                if sline.startswith(".field "):
                    m = re.match(r"\.field (\w+) -> (\w+)", sline)
                    if m:
                        fname = m.group(1)
                        ftype = m.group(2)
                        llvm_t = _sfn_type_to_llvm(ftype, enums)
                        fields.append(StructField(name=fname, sfn_type=ftype, llvm_type=llvm_t, index=field_index))
                        field_index += 1
                elif sline.startswith(".method "):
                    # Parse method: .method name(self, params...) -> ReturnType
                    mm = re.match(r"\.method (\w+)\((.*?)\)(?:\s*->\s*(\w+))?", sline)
                    if mm:
                        mname = mm.group(1)
                        mparams_str = mm.group(2).strip()
                        mret = mm.group(3) or "void"
                        mparams: list[FunctionParam] = []
                        for mp in mparams_str.split(","):
                            mp = mp.strip()
                            if mp == "self":
                                mparams.append(FunctionParam(name="self", sfn_type=struct_name))
                            else:
                                mpm = re.match(r"(\w+)\s*->\s*(\w+)", mp)
                                if mpm:
                                    mparams.append(FunctionParam(name=mpm.group(1), sfn_type=mpm.group(2)))
                        # Collect method body
                        method_instrs: list[str] = []
                        i += 1
                        pending_cont = ""
                        while i < len(lines) and not lines[i].strip().startswith(".endmethod"):
                            mline = lines[i].strip()
                            if mline and not mline.startswith(".meta") and not mline.startswith(".span") and not mline.startswith(".param"):
                                if pending_cont:
                                    pending_cont += " " + mline
                                else:
                                    pending_cont = mline
                                if not _should_continue_line(pending_cont):
                                    method_instrs.append(pending_cont)
                                    pending_cont = ""
                            i += 1
                        if pending_cont:
                            method_instrs.append(pending_cont)
                        methods.append(MethodDef(
                            name=mname, struct_name=struct_name,
                            params=mparams, return_type=mret,
                            instructions=method_instrs,
                        ))
                i += 1
            structs[struct_name] = StructDef(name=struct_name, fields=fields, methods=methods)
            i += 1
            continue

        # Function definition (with optional async prefix)
        fn_match = re.match(r"\.fn (?:async )?([\w:.]+)\((.*?)\)(?:\s*->\s*(\w+(?:\[\])?))?", line)
        fn_is_async = line.startswith(".fn async ")
        if fn_match:
            fn_name = fn_match.group(1)
            params_str = fn_match.group(2).strip()
            ret_type = fn_match.group(3) or "void"
            params: list[FunctionParam] = []
            if params_str:
                for p in params_str.split(","):
                    p = p.strip()
                    pm = re.match(r"(\w+)\s*->\s*(\w+(?:\[\])?)", p)
                    if pm:
                        params.append(FunctionParam(name=pm.group(1), sfn_type=pm.group(2)))

            is_test = fn_name.startswith("test:")
            instrs: list[str] = []
            i += 1
            pending_continuation = ""
            while i < len(lines) and not lines[i].strip().startswith(".endfn"):
                iline = lines[i].strip()
                if iline and not iline.startswith(".meta") and not iline.startswith(".span") and not iline.startswith(".param"):
                    if pending_continuation:
                        pending_continuation += " " + iline
                    else:
                        pending_continuation = iline
                    if not _should_continue_line(pending_continuation):
                        instrs.append(pending_continuation)
                        pending_continuation = ""
                i += 1
            if pending_continuation:
                instrs.append(pending_continuation)
            functions.append(FunctionDef(
                name=fn_name, params=params, return_type=ret_type,
                instructions=instrs, is_test=is_test, is_async=fn_is_async,
            ))
            i += 1
            continue

        i += 1

    return enums, structs, functions, globals_list


# ---------------------------------------------------------------------------
# LLVM IR generation
# ---------------------------------------------------------------------------

class LLVMGen:
    def __init__(self, enums: dict[str, EnumDef], structs: dict[str, StructDef],
                 globals_map: dict[str, GlobalLet] | None = None):
        self.enums = enums
        self.structs = structs
        self.globals_map = globals_map or {}
        self.temp_counter = 0
        self.block_counter = 0
        self.lines: list[str] = []
        self.allocas: list[str] = []
        self.locals: dict[str, tuple[str, str, str]] = {}  # name -> (pointer, llvm_type, sfn_type)
        self.string_constants: dict[str, str] = {}  # content -> global name
        self.sc_counter = 0
        self.loop_stack: list[tuple[str, str]] = []  # (header_label, exit_label)
        self._terminated = False  # track if current block is terminated

    def _t(self) -> str:
        name = f"%t{self.temp_counter}"
        self.temp_counter += 1
        return name

    def _block(self, prefix: str) -> str:
        name = f"{prefix}{self.block_counter}"
        self.block_counter += 1
        return name

    def _string_constant(self, content: str) -> str:
        if content in self.string_constants:
            return self.string_constants[content]
        name = f"@.str.{self.sc_counter}"
        self.sc_counter += 1
        self.string_constants[content] = name
        return name

    def _emit(self, line: str):
        self.lines.append(line)

    def _emit_alloca(self, line: str):
        self.allocas.append(line)

    def _sanitize_symbol(self, name: str) -> str:
        return re.sub(r"[^A-Za-z0-9_]", "", name)

    # --- Expression lowering ---

    def _lower_enum_literal(self, enum_name: str, variant_name: str) -> tuple[str, str]:
        """Returns (llvm_value, llvm_type) — always i8* (boxed)."""
        edef = self.enums[enum_name]
        variant = next(v for v in edef.variants if v.name == variant_name)
        val = self._t()
        self._emit(f"  {val} = insertvalue {edef.llvm_name} undef, {edef.tag_type} {variant.tag}, 0")
        sz = self._t()
        self._emit(f"  {sz} = getelementptr {edef.llvm_name}, {edef.llvm_name}* null, i32 1")
        sz_int = self._t()
        self._emit(f"  {sz_int} = ptrtoint {edef.llvm_name}* {sz} to i64")
        ptr = self._t()
        self._emit(f"  {ptr} = call noalias i8* @malloc(i64 {sz_int})")
        cast = self._t()
        self._emit(f"  {cast} = bitcast i8* {ptr} to {edef.llvm_name}*")
        self._emit(f"  store {edef.llvm_name} {val}, {edef.llvm_name}* {cast}")
        self._emit(f"  call void @sailfin_runtime_mark_persistent(i8* {ptr})")
        return ptr, "i8*"

    def _lower_struct_literal(self, struct_name: str, field_values: dict[str, str]) -> tuple[str, str]:
        """Create a struct literal. field_values maps field names to (value, type) strings."""
        sdef = self.structs[struct_name]
        current = "undef"
        current_type = sdef.llvm_name
        for field in sdef.fields:
            if field.name in field_values:
                fval, ftype = field_values[field.name]
                temp = self._t()
                self._emit(f"  {temp} = insertvalue {current_type} {current}, {ftype} {fval}, {field.index}")
                current = temp
        sz = self._t()
        self._emit(f"  {sz} = getelementptr {sdef.llvm_name}, {sdef.llvm_name}* null, i32 1")
        sz_int = self._t()
        self._emit(f"  {sz_int} = ptrtoint {sdef.llvm_name}* {sz} to i64")
        ptr = self._t()
        self._emit(f"  {ptr} = call noalias i8* @malloc(i64 {sz_int})")
        cast = self._t()
        self._emit(f"  {cast} = bitcast i8* {ptr} to {sdef.llvm_name}*")
        self._emit(f"  store {sdef.llvm_name} {current}, {sdef.llvm_name}* {cast}")
        self._emit(f"  call void @sailfin_runtime_mark_persistent(i8* {ptr})")
        return ptr, "i8*"

    def _lower_string_literal(self, s: str) -> tuple[str, str]:
        # Handle escape sequences for byte length calculation
        raw = self._unescape_string(s)
        encoded = raw.encode("utf-8")
        length = len(encoded) + 1  # +1 for null terminator
        ptr = self._t()
        self._emit(f"  {ptr} = call i8* @malloc(i64 {length})")
        cast = self._t()
        self._emit(f"  {cast} = bitcast i8* {ptr} to [{length} x i8]*")
        llvm_str = self._to_llvm_string(raw)
        self._emit(f'  store [{length} x i8] c"{llvm_str}\\00", [{length} x i8]* {cast}')
        return ptr, "i8*"

    @staticmethod
    def _unescape_string(s: str) -> str:
        """Convert \\n, \\t, etc. to actual characters."""
        result = []
        i = 0
        while i < len(s):
            if s[i] == '\\' and i + 1 < len(s):
                c = s[i + 1]
                if c == 'n':
                    result.append('\n')
                elif c == 't':
                    result.append('\t')
                elif c == 'r':
                    result.append('\r')
                elif c == '\\':
                    result.append('\\')
                elif c == '"':
                    result.append('"')
                elif c == '0':
                    result.append('\0')
                else:
                    result.append(s[i])
                    result.append(c)
                i += 2
            else:
                result.append(s[i])
                i += 1
        return ''.join(result)

    @staticmethod
    def _to_llvm_string(s: str) -> str:
        """Convert a raw string to LLVM string constant format."""
        result = []
        for ch in s:
            o = ord(ch)
            if 32 <= o < 127 and ch not in ('"', '\\'):
                result.append(ch)
            else:
                result.append(f"\\{o:02X}")
        return ''.join(result)

    def _lower_number_literal(self, n: str) -> tuple[str, str]:
        v = float(n)
        if v == int(v) and '.' not in n:
            return f"{v:.1f}", "double"
        return f"{v}", "double"

    def _lower_member_access(self, base_val: str, base_type: str, base_sfn_type: str, field: str) -> tuple[str, str, str]:
        """Returns (value, llvm_type, sfn_type)."""
        # String.length → sailfin_runtime_string_length
        if field == "length" and base_sfn_type == "string":
            len_i64 = self._t()
            self._emit(f"  {len_i64} = call i64 @sailfin_runtime_string_length(i8* {base_val})")
            len_dbl = self._t()
            self._emit(f"  {len_dbl} = sitofp i64 {len_i64} to double")
            return len_dbl, "double", "number"

        # Enum.variant → select chain
        if field == "variant" and base_sfn_type in self.enums:
            edef = self.enums[base_sfn_type]
            cast = self._t()
            self._emit(f"  {cast} = bitcast i8* {base_val} to {edef.llvm_name}*")
            loaded = self._t()
            self._emit(f"  {loaded} = load {edef.llvm_name}, {edef.llvm_name}* {cast}")
            tag = self._t()
            self._emit(f"  {tag} = extractvalue {edef.llvm_name} {loaded}, 0")

            default_name = self._string_constant("")
            default_ptr = self._t()
            self._emit(f"  {default_ptr} = getelementptr inbounds [1 x i8], [1 x i8]* {default_name}, i32 0, i32 0")
            current_ptr = default_ptr

            for variant in edef.variants:
                vname = variant.name
                sc_name = self._string_constant(vname)
                vlen = len(vname) + 1
                vptr = self._t()
                self._emit(f"  {vptr} = getelementptr inbounds [{vlen} x i8], [{vlen} x i8]* {sc_name}, i32 0, i32 0")
                cmp = self._t()
                self._emit(f"  {cmp} = icmp eq {edef.tag_type} {tag}, {variant.tag}")
                sel = self._t()
                self._emit(f"  {sel} = select i1 {cmp}, i8* {vptr}, i8* {current_ptr}")
                current_ptr = sel

            return current_ptr, "i8*", "string"

        # Struct field → GEP
        if base_sfn_type in self.structs:
            sdef = self.structs[base_sfn_type]
            fdef = next((f for f in sdef.fields if f.name == field), None)
            if fdef is None:
                raise ValueError(f"Field {field} not found in struct {base_sfn_type}")
            cast = self._t()
            self._emit(f"  {cast} = bitcast i8* {base_val} to {sdef.llvm_name}*")
            gep = self._t()
            self._emit(f"  {gep} = getelementptr inbounds {sdef.llvm_name}, {sdef.llvm_name}* {cast}, i32 0, i32 {fdef.index}")
            loaded = self._t()
            self._emit(f"  {loaded} = load {fdef.llvm_type}, {fdef.llvm_type}* {gep}")
            return loaded, fdef.llvm_type, fdef.sfn_type

        raise ValueError(f"Cannot access field '{field}' on type '{base_sfn_type}'")

    def _lower_expression(self, expr: str) -> tuple[str, str, str]:
        """Returns (value, llvm_type, sfn_type)."""
        expr = expr.strip()

        # Boolean literals
        if expr == "true":
            return "true", "i1", "boolean"
        if expr == "false":
            return "false", "i1", "boolean"

        # Boolean negation: !expr
        if expr.startswith("!") and not expr.startswith("!="):
            inner = expr[1:].strip()
            val, typ, sfn = self._lower_expression(inner)
            if typ == "i1":
                neg = self._t()
                self._emit(f"  {neg} = xor i1 {val}, true")
                return neg, "i1", "boolean"

        # Await: await expr
        if expr.startswith("await "):
            return self._lower_await(expr[6:].strip())

        # String interpolation: "...{{expr}}..."
        if expr.startswith('"') and "{{" in expr:
            return self._lower_string_interpolation(expr)

        # Enum constructor: EnumName.VariantName() — must match entire expression
        enum_ctor = re.fullmatch(r"(\w+)\.(\w+)\(\)", expr)
        if enum_ctor:
            enum_name = enum_ctor.group(1)
            variant_name = enum_ctor.group(2)
            if enum_name in self.enums:
                val, typ = self._lower_enum_literal(enum_name, variant_name)
                return val, typ, enum_name

        # Function call: fn_name(args)
        fn_call = re.match(r"(\w+)\((.*)\)$", expr)
        if fn_call and fn_call.group(1) not in self.enums:
            fn_name = fn_call.group(1)
            args_str = fn_call.group(2).strip()
            return self._lower_function_call(fn_name, args_str)

        # String literal
        str_match = re.match(r'^"((?:[^"\\]|\\.)*)"$', expr)
        if str_match:
            val, typ = self._lower_string_literal(str_match.group(1))
            return val, typ, "string"

        # Number literal
        if re.match(r"^-?\d+\.?\d*$", expr):
            val, typ = self._lower_number_literal(expr)
            return val, typ, "number"

        # Array literal: [elem1, elem2, ...]
        if expr.startswith("[") and expr.endswith("]"):
            return self._lower_array_literal(expr)

        # String slicing: expr[start:end] (must check before general indexing)
        slice_match = re.match(r'^(.+?)\[(.+?):(.+?)\]$', expr)
        if slice_match:
            base_expr = slice_match.group(1).strip()
            start_expr = slice_match.group(2).strip()
            end_expr = slice_match.group(3).strip()
            return self._lower_string_slice(base_expr, start_expr, end_expr)

        # String/array indexing: expr[index_expr]
        idx_match = re.match(r'^(.+?)\[(.+)\]$', expr)
        if idx_match:
            base_expr = idx_match.group(1).strip()
            index_expr = idx_match.group(2).strip()
            return self._lower_indexing(base_expr, index_expr)

        # Binary expression: check for +, -, *, / between non-string exprs
        # This must come before member access to handle e.g. "i + needle.length"
        bin_result = self._try_lower_binary_expr(expr)
        if bin_result is not None:
            return bin_result

        # Member access chain: a.b.c
        if "." in expr and not expr.startswith('"'):
            return self._lower_member_chain(expr)

        # Local variable reference
        if expr in self.locals:
            ptr, llvm_type, sfn_type = self.locals[expr]
            loaded = self._t()
            self._emit(f"  {loaded} = load {llvm_type}, {llvm_type}* {ptr}")
            return loaded, llvm_type, sfn_type

        # Global variable reference
        if expr in self.globals_map:
            g = self.globals_map[expr]
            return self._lower_expression(g.value)

        raise ValueError(f"Cannot lower expression: {expr}")

    def _try_lower_binary_expr(self, expr: str) -> tuple[str, str, str] | None:
        """Try to parse and lower a binary arithmetic expression. Returns None if not applicable."""
        # Find binary operators outside strings and parentheses: +, -, *, /
        # But NOT string concat (handled when both sides are strings)
        # We need to handle: "i + needle.length", "_index_of(x, y) >= 0"
        # Check for comparison operators first (>=, <=, >, <)
        for op in [">=", "<=", ">", "<"]:
            idx = self._find_binary_op(expr, op)
            if idx >= 0:
                left = expr[:idx].strip()
                right = expr[idx + len(op):].strip()
                return self._lower_binary_comparison(left, op, right)

        for op in [" + ", " - "]:
            idx = self._find_binary_op(expr, op)
            if idx >= 0:
                left = expr[:idx].strip()
                right = expr[idx + len(op):].strip()
                return self._lower_binary_arith(left, op.strip(), right)

        # * and / without spaces (less ambiguous)
        for op in [" * ", " / "]:
            idx = self._find_binary_op(expr, op)
            if idx >= 0:
                left = expr[:idx].strip()
                right = expr[idx + len(op):].strip()
                return self._lower_binary_arith(left, op.strip(), right)

        return None

    def _find_binary_op(self, expr: str, op: str) -> int:
        """Find a binary operator in expr, outside strings and balanced parens/brackets."""
        in_string = False
        depth = 0
        i = 0
        while i < len(expr) - len(op) + 1:
            ch = expr[i]
            if ch == '"' and (i == 0 or expr[i - 1] != '\\'):
                in_string = not in_string
            elif not in_string:
                if ch in '([':
                    depth += 1
                elif ch in ')]':
                    depth -= 1
                elif depth == 0 and expr[i:i + len(op)] == op:
                    # Make sure this isn't part of == or != or >= or <=
                    if op in (">", "<"):
                        if i + 1 < len(expr) and expr[i + 1] == '=':
                            i += 1
                            continue
                    return i
            i += 1
        return -1

    def _lower_binary_arith(self, left_expr: str, op: str, right_expr: str) -> tuple[str, str, str]:
        left_val, left_type, left_sfn = self._lower_expression(left_expr)
        right_val, right_type, right_sfn = self._lower_expression(right_expr)

        # String concatenation
        if left_type == "i8*" and right_type == "i8*" and op == "+":
            result = self._t()
            self._emit(f"  {result} = call i8* @sailfin_runtime_string_concat(i8* {left_val}, i8* {right_val})")
            return result, "i8*", "string"

        # Number arithmetic
        if left_type == "double" and right_type == "double":
            result = self._t()
            llvm_op = {"+" : "fadd", "-": "fsub", "*": "fmul", "/": "fdiv"}[op]
            self._emit(f"  {result} = {llvm_op} double {left_val}, {right_val}")
            return result, "double", "number"

        raise ValueError(f"Cannot apply {op} to {left_type} and {right_type}")

    def _lower_binary_comparison(self, left_expr: str, op: str, right_expr: str) -> tuple[str, str, str]:
        left_val, left_type, _ = self._lower_expression(left_expr)
        right_val, right_type, _ = self._lower_expression(right_expr)

        if left_type == "double" and right_type == "double":
            cmp_map = {">=": "oge", "<=": "ole", ">": "ogt", "<": "olt"}
            result = self._t()
            self._emit(f"  {result} = fcmp {cmp_map[op]} double {left_val}, {right_val}")
            return result, "i1", "boolean"

        raise ValueError(f"Cannot compare {left_type} {op} {right_type}")

    def _lower_await(self, expr: str) -> tuple[str, str, str]:
        """Lower 'await expr' — calls the appropriate runtime await function."""
        val, typ, sfn_type = self._lower_expression(expr)

        # Extract async return type from "future:X" sfn_type
        if sfn_type.startswith("future:"):
            async_ret_sfn = sfn_type[7:]
        else:
            # Fallback: infer from the first async function found
            async_ret_sfn = "void"
            for func in self._all_functions:
                if func.is_async:
                    async_ret_sfn = func.return_type
                    break

        category = _async_category(async_ret_sfn)
        future_type = f"%SailfinFuture{category}*"

        if category == "Number":
            result = self._t()
            self._emit(f"  {result} = call double @sailfin_runtime_await_number({future_type} {val})")
            return result, "double", "number"
        elif category == "Bool":
            result = self._t()
            self._emit(f"  {result} = call i1 @sailfin_runtime_await_bool({future_type} {val})")
            return result, "i1", "boolean"
        elif category == "String":
            result = self._t()
            self._emit(f"  {result} = call i8* @sailfin_runtime_await_string({future_type} {val})")
            return result, "i8*", "string"
        elif category == "Void":
            self._emit(f"  call void @sailfin_runtime_await_void({future_type} {val})")
            return "void", "void", "void"
        else:  # Ptr — struct types
            result = self._t()
            self._emit(f"  {result} = call i8* @sailfin_runtime_await_ptr({future_type} {val})")
            return result, "i8*", async_ret_sfn

    def _lower_string_interpolation(self, expr: str) -> tuple[str, str, str]:
        """Lower 'Hello, {{self.name}}!' style interpolation."""
        # Remove outer quotes
        inner = expr[1:-1]
        parts: list[str] = []
        i = 0
        while i < len(inner):
            if inner[i:i+2] == "{{":
                # Find closing }}
                end = inner.index("}}", i + 2)
                parts.append(("expr", inner[i+2:end]))
                i = end + 2
            else:
                # Literal text until next {{ or end
                j = inner.find("{{", i)
                if j < 0:
                    parts.append(("lit", inner[i:]))
                    break
                else:
                    if j > i:
                        parts.append(("lit", inner[i:j]))
                    i = j
        # Lower each part and concatenate
        current_val = None
        for kind, text in parts:
            if kind == "lit":
                val, _ = self._lower_string_literal(text)
            else:
                val, typ, _ = self._lower_expression(text)
                if typ == "double":
                    # number to string
                    val2 = self._t()
                    self._emit(f"  {val2} = call i8* @sailfin_runtime_number_to_string(double {val})")
                    val = val2
            if current_val is None:
                current_val = val
            else:
                concat = self._t()
                self._emit(f"  {concat} = call i8* @sailfin_runtime_string_concat(i8* {current_val}, i8* {val})")
                current_val = concat
        return current_val or "null", "i8*", "string"

    def _lower_indexing(self, base_expr: str, index_expr: str) -> tuple[str, str, str]:
        """Lower string[index] → sailfin_runtime_grapheme_at."""
        base_val, base_type, base_sfn = self._lower_expression(base_expr)
        idx_val, idx_type, _ = self._lower_expression(index_expr)
        if base_type == "i8*" and idx_type == "double":
            result = self._t()
            self._emit(f"  {result} = call i8* @sailfin_runtime_grapheme_at(i8* {base_val}, double {idx_val})")
            return result, "i8*", "string"
        raise ValueError(f"Cannot index {base_type} with {idx_type}")

    def _lower_string_slice(self, base_expr: str, start_expr: str, end_expr: str) -> tuple[str, str, str]:
        """Lower string[start:end] → sailfin_runtime_substring."""
        base_val, _, _ = self._lower_expression(base_expr)
        start_val, _, _ = self._lower_expression(start_expr)
        end_val, _, _ = self._lower_expression(end_expr)
        start_i64 = self._t()
        self._emit(f"  {start_i64} = fptosi double {start_val} to i64")
        end_i64 = self._t()
        self._emit(f"  {end_i64} = fptosi double {end_val} to i64")
        result = self._t()
        self._emit(f"  {result} = call i8* @sailfin_runtime_substring(i8* {base_val}, i64 {start_i64}, i64 {end_i64})")
        return result, "i8*", "string"

    def _lower_array_literal(self, expr: str) -> tuple[str, str, str]:
        """Lower [elem1, elem2, ...] → { i8**, i64 }* array."""
        inner = expr[1:-1].strip()
        if not inner or inner == "":
            elements = []
        else:
            elements = self._split_args(inner)
            # Strip trailing empty from trailing comma
            elements = [e.strip().rstrip(",") for e in elements if e.strip().rstrip(",")]
        n = len(elements)

        # Lower each element
        elem_vals: list[tuple[str, str]] = []
        for elem in elements:
            val, typ, _ = self._lower_expression(elem.strip())
            elem_vals.append((val, typ))

        arr_t = "{ i8**, i64 }"

        # Allocate struct
        struct_ptr = self._t()
        self._emit(f"  {struct_ptr} = call noalias i8* @malloc(i64 16)")
        struct_typed = self._t()
        self._emit(f"  {struct_typed} = bitcast i8* {struct_ptr} to {arr_t}*")

        # Allocate data buffer
        data_sz = max(n, 1) * 8  # at least 8 bytes
        data_ptr = self._t()
        self._emit(f"  {data_ptr} = call noalias i8* @malloc(i64 {data_sz})")
        data_typed = self._t()
        self._emit(f"  {data_typed} = bitcast i8* {data_ptr} to i8**")

        # Store elements
        for idx, (val, typ) in enumerate(elem_vals):
            gep = self._t()
            self._emit(f"  {gep} = getelementptr i8*, i8** {data_typed}, i64 {idx}")
            self._emit(f"  store i8* {val}, i8** {gep}")

        # Store data pointer and length in struct
        data_field = self._t()
        self._emit(f"  {data_field} = getelementptr inbounds {arr_t}, {arr_t}* {struct_typed}, i32 0, i32 0")
        self._emit(f"  store i8** {data_typed}, i8*** {data_field}")
        len_field = self._t()
        self._emit(f"  {len_field} = getelementptr inbounds {arr_t}, {arr_t}* {struct_typed}, i32 0, i32 1")
        self._emit(f"  store i64 {n}, i64* {len_field}")

        self._emit(f"  call void @sailfin_runtime_mark_persistent(i8* {struct_ptr})")
        return struct_typed, "{ i8**, i64 }*", "string[]"

    def _lower_array_push(self, arr_name: str, elem_expr: str):
        """Lower arr.push(elem) for string arrays."""
        if arr_name not in self.locals:
            raise ValueError(f"Unknown array: {arr_name}")
        ptr, llvm_type, sfn_type = self.locals[arr_name]
        arr_val = self._t()
        self._emit(f"  {arr_val} = load {{ i8**, i64 }}*, {{ i8**, i64 }}** {ptr}")
        elem_val, _, _ = self._lower_expression(elem_expr)
        new_arr = self._t()
        self._emit(f"  {new_arr} = call {{ i8**, i64 }}* @sailfin_runtime_append_string({{ i8**, i64 }}* {arr_val}, i8* {elem_val})")
        self._emit(f"  store {{ i8**, i64 }}* {new_arr}, {{ i8**, i64 }}** {ptr}")

    def _lower_member_chain(self, expr: str) -> tuple[str, str, str]:
        """Lower a.b.c or a.method(args) member access chain."""
        # Check for method call pattern: var.method(args)
        method_match = re.match(r"(\w+)\.(\w+)\((.*)\)$", expr)
        if method_match:
            obj_name = method_match.group(1)
            method_name = method_match.group(2)
            args_str = method_match.group(3).strip()
            return self._lower_method_call(obj_name, method_name, args_str)

        parts = expr.split(".")

        # Check if first two parts are EnumName.Variant()
        if len(parts) >= 2:
            ctor_str = parts[0] + "." + parts[1]
            ctor_match = re.match(r"(\w+)\.(\w+)\(\)", ctor_str)
            if ctor_match and ctor_match.group(1) in self.enums:
                val, typ, sfn_type = self._lower_expression(ctor_str)
                for field in parts[2:]:
                    val, typ, sfn_type = self._lower_member_access(val, typ, sfn_type, field)
                return val, typ, sfn_type

        # Start with first part as a local/global variable
        first = parts[0]
        if first in self.locals:
            ptr, llvm_type, sfn_type = self.locals[first]
            loaded = self._t()
            self._emit(f"  {loaded} = load {llvm_type}, {llvm_type}* {ptr}")
            val = loaded
            typ = llvm_type
        elif first in self.globals_map:
            val, typ, sfn_type = self._lower_expression(self.globals_map[first].value)
        else:
            raise ValueError(f"Unknown variable: {first}")

        for field in parts[1:]:
            val, typ, sfn_type = self._lower_member_access(val, typ, sfn_type, field)

        return val, typ, sfn_type

    def _lower_method_call(self, obj_name: str, method_name: str, args_str: str) -> tuple[str, str, str]:
        """Lower obj.method(args) → StructNamemethod(obj, args)."""
        if obj_name not in self.locals:
            raise ValueError(f"Unknown variable for method call: {obj_name}")
        ptr, llvm_type, sfn_type = self.locals[obj_name]
        obj_val = self._t()
        self._emit(f"  {obj_val} = load {llvm_type}, {llvm_type}* {ptr}")

        # Find the method
        if sfn_type not in self.structs:
            raise ValueError(f"Method call on non-struct type: {sfn_type}")
        sdef = self.structs[sfn_type]
        mdef = next((m for m in sdef.methods if m.name == method_name), None)
        if mdef is None:
            raise ValueError(f"Method {method_name} not found on {sfn_type}")

        # Build args: self first, then additional args
        arg_vals: list[tuple[str, str]] = [(obj_val, "i8*")]
        if args_str:
            for arg in self._split_args(args_str):
                val, typ, _ = self._lower_expression(arg.strip())
                arg_vals.append((val, typ))

        # Generate call
        fn_name = f"{sfn_type}{method_name}"
        ret_llvm = _sfn_type_to_llvm(mdef.return_type, self.enums)
        args_ir = ", ".join(f"{typ} {val}" for val, typ in arg_vals)

        if ret_llvm == "void":
            self._emit(f"  call void @{fn_name}({args_ir})")
            return "void", "void", "void"
        else:
            result = self._t()
            self._emit(f"  {result} = call {ret_llvm} @{fn_name}({args_ir})")
            return result, ret_llvm, mdef.return_type

    def _lower_function_call(self, fn_name: str, args_str: str) -> tuple[str, str, str]:
        """Lower a function call."""
        arg_vals: list[tuple[str, str]] = []
        if args_str:
            for arg in self._split_args(args_str):
                val, typ, _ = self._lower_expression(arg.strip())
                arg_vals.append((val, typ))

        # Special case: runtime_raise_value_error_fn
        if fn_name == "runtime_raise_value_error_fn":
            if arg_vals:
                self._emit(f"  call void @sailfin_runtime_raise_value_error(i8* {arg_vals[0][0]})")
            return "void", "void", "void"

        # Special case: substring_unchecked
        if fn_name == "substring_unchecked":
            if len(arg_vals) == 3:
                str_val = arg_vals[0][0]
                start_val = arg_vals[1][0]
                end_val = arg_vals[2][0]
                # Convert double args to i64
                start_i64 = self._t()
                self._emit(f"  {start_i64} = fptosi double {start_val} to i64")
                end_i64 = self._t()
                self._emit(f"  {end_i64} = fptosi double {end_val} to i64")
                result = self._t()
                self._emit(f"  {result} = call i8* @sailfin_runtime_substring_unchecked(i8* {str_val}, i64 {start_i64}, i64 {end_i64})")
                return result, "i8*", "string"

        # Check if this is an async function call — returns a future
        for func in self._all_functions:
            if func.name == fn_name and func.is_async:
                category = _async_category(func.return_type)
                future_type = f"%SailfinFuture{category}*"
                san_name = re.sub(r"[^A-Za-z0-9_]", "", fn_name)
                args_ir = ", ".join(f"{typ} {val}" for val, typ in arg_vals)
                result = self._t()
                self._emit(f"  {result} = call {future_type} @{san_name}({args_ir})")
                return result, future_type, f"future:{func.return_type}"

        # Find the function's return type
        ret_sfn = "void"
        for func in self._all_functions:
            if func.name == fn_name:
                ret_sfn = func.return_type
                break

        ret_llvm = _sfn_type_to_llvm(ret_sfn, self.enums)

        # Sanitize function name for LLVM
        san_name = re.sub(r"[^A-Za-z0-9_]", "", fn_name)

        args_ir = ", ".join(f"{typ} {val}" for val, typ in arg_vals)
        if ret_llvm == "void":
            self._emit(f"  call void @{san_name}({args_ir})")
            return "void", "void", "void"
        else:
            result = self._t()
            self._emit(f"  {result} = call {ret_llvm} @{san_name}({args_ir})")
            return result, ret_llvm, ret_sfn

    def _split_args(self, args_str: str) -> list[str]:
        """Split comma-separated args, respecting nested parens/braces/brackets."""
        args = []
        depth = 0
        current = ""
        in_string = False
        for ch in args_str:
            if ch == '"' and (not current or current[-1] != '\\'):
                in_string = not in_string
                current += ch
            elif in_string:
                current += ch
            elif ch in "([{":
                depth += 1
                current += ch
            elif ch in ")]}":
                depth -= 1
                current += ch
            elif ch == "," and depth == 0:
                args.append(current)
                current = ""
            else:
                current += ch
        if current.strip():
            args.append(current)
        return args

    def _lower_comparison(self, left_expr: str, op: str, right_expr: str) -> tuple[str, str]:
        """Returns (i1_value, 'i1')."""
        left_val, left_type, _ = self._lower_expression(left_expr)
        right_val, right_type, _ = self._lower_expression(right_expr)

        if left_type == "i8*" and right_type == "i8*":
            result = self._t()
            self._emit(f"  {result} = call i1 @strings_equal(i8* {left_val}, i8* {right_val})")
            if op == "!=":
                neg = self._t()
                self._emit(f"  {neg} = xor i1 {result}, true")
                return neg, "i1"
            return result, "i1"
        elif left_type == "double" and right_type == "double":
            cmp_map = {"==": "oeq", "!=": "one", ">=": "oge", "<=": "ole", ">": "ogt", "<": "olt"}
            result = self._t()
            self._emit(f"  {result} = fcmp {cmp_map[op]} double {left_val}, {right_val}")
            return result, "i1"
        elif left_type == "i1" and right_type == "i1":
            cmp_op = "eq" if op == "==" else "ne"
            result = self._t()
            self._emit(f"  {result} = icmp {cmp_op} i1 {left_val}, {right_val}")
            return result, "i1"
        else:
            raise ValueError(f"Cannot compare {left_type} {op} {right_type}")

    def _parse_condition(self, cond: str) -> tuple[str, str]:
        """Parse and lower a condition, returns (i1_value, 'i1')."""
        # Check for || (lowest precedence, outside strings/parens)
        idx = self._find_op_outside_strings(cond, "||")
        if idx >= 0:
            left = cond[:idx].strip()
            right = cond[idx + 2:].strip()
            left_val, _ = self._parse_condition(left)
            right_val, _ = self._parse_condition(right)
            result = self._t()
            self._emit(f"  {result} = or i1 {left_val}, {right_val}")
            return result, "i1"

        # Check for && (next precedence)
        idx = self._find_op_outside_strings(cond, "&&")
        if idx >= 0:
            left = cond[:idx].strip()
            right = cond[idx + 2:].strip()
            left_val, _ = self._parse_condition(left)
            right_val, _ = self._parse_condition(right)
            result = self._t()
            self._emit(f"  {result} = and i1 {left_val}, {right_val}")
            return result, "i1"

        # Find comparison operators (not inside strings)
        for op in ["==", "!=", ">=", "<=", ">", "<"]:
            idx = self._find_op_outside_strings(cond, op)
            if idx >= 0:
                left = cond[:idx].strip()
                right = cond[idx + len(op):].strip()
                return self._lower_comparison(left, op, right)

        # Bool expression (negation)
        if cond.startswith("!"):
            inner = cond[1:].strip()
            val, typ, _ = self._lower_expression(inner)
            if typ != "i1":
                raise ValueError(f"Cannot negate non-boolean: {typ}")
            neg = self._t()
            self._emit(f"  {neg} = xor i1 {val}, true")
            return neg, "i1"

        # Direct boolean expression
        val, typ, _ = self._lower_expression(cond)
        if typ == "i1":
            return val, "i1"
        raise ValueError(f"Cannot use {typ} as condition")

    def _find_op_outside_strings(self, text: str, op: str) -> int:
        in_string = False
        depth = 0
        i = 0
        while i < len(text) - len(op) + 1:
            ch = text[i]
            if ch == '"' and (i == 0 or text[i - 1] != '\\'):
                in_string = not in_string
            elif not in_string:
                if ch in '([':
                    depth += 1
                elif ch in ')]':
                    depth -= 1
                elif depth == 0 and text[i:i + len(op)] == op:
                    # Disambiguate: don't match > when followed by = (that's >=)
                    # and don't match < when followed by = (that's <=)
                    if op == ">" and i + 1 < len(text) and text[i + 1] == '=':
                        i += 1
                        continue
                    if op == "<" and i + 1 < len(text) and text[i + 1] == '=':
                        i += 1
                        continue
                    # Don't match = in == when looking for single ops
                    if op == "==" and i > 0 and text[i - 1] in "!><":
                        i += 1
                        continue
                    return i
            i += 1
        return -1

    # --- Struct literal parsing ---

    def _parse_struct_literal(self, expr: str) -> tuple[str, dict[str, str]]:
        """Parse 'StructName { field: value, ... }' and return (struct_name, {field: expr})."""
        m = re.match(r"(\w+)\s*\{", expr)
        if not m:
            raise ValueError(f"Cannot parse struct literal: {expr}")
        struct_name = m.group(1)
        body = expr[m.end():].rstrip().rstrip(",").rstrip("}")
        fields: dict[str, str] = {}
        for part in self._split_struct_fields(body):
            part = part.strip().rstrip(",")
            if not part:
                continue
            colon_idx = part.index(":")
            fname = part[:colon_idx].strip()
            fval = part[colon_idx + 1:].strip()
            fields[fname] = fval
        return struct_name, fields

    def _split_struct_fields(self, body: str) -> list[str]:
        fields = []
        depth = 0
        current = ""
        for ch in body:
            if ch in "({":
                depth += 1
                current += ch
            elif ch in ")}":
                depth -= 1
                current += ch
            elif ch == "," and depth == 0:
                fields.append(current)
                current = ""
            else:
                current += ch
        if current.strip():
            fields.append(current)
        return fields

    # --- Instruction lowering ---

    def _lower_if_block(self, instructions: list[str], start: int) -> int:
        """Lower an .if/.else/.endif block. Returns index after .endif."""
        cond_text = instructions[start][3:].strip()  # strip ".if "

        cond_val, _ = self._parse_condition(cond_text)

        then_label = self._block("then")
        else_label = self._block("else")
        merge_label = self._block("merge")

        # Find .else and .endif
        depth = 1
        else_idx = -1
        endif_idx = -1
        j = start + 1
        while j < len(instructions):
            line = instructions[j].strip()
            if line.startswith(".if "):
                depth += 1
            elif line == ".endif":
                depth -= 1
                if depth == 0:
                    endif_idx = j
                    break
            elif line == ".else" and depth == 1:
                else_idx = j
            j += 1

        has_else = else_idx >= 0
        false_target = else_label if has_else else merge_label

        self._emit(f"  br i1 {cond_val}, label %{then_label}, label %{false_target}")

        # Then block
        self._emit(f"{then_label}:")
        self._terminated = False
        then_start = start + 1
        then_end = else_idx if has_else else endif_idx
        k = then_start
        while k < then_end:
            k = self._lower_instruction(instructions, k)
        if not self._terminated:
            self._emit(f"  br label %{merge_label}")

        # Else block
        if has_else:
            self._emit(f"{else_label}:")
            self._terminated = False
            else_start = else_idx + 1
            else_end = endif_idx
            k = else_start
            while k < else_end:
                k = self._lower_instruction(instructions, k)
            if not self._terminated:
                self._emit(f"  br label %{merge_label}")

        # Merge block
        self._emit(f"{merge_label}:")
        self._terminated = False

        return endif_idx + 1

    def _lower_loop_block(self, instructions: list[str], start: int) -> int:
        """Lower a .loop/.endloop block."""
        header_label = self._block("loop.header")
        body_label = self._block("loop.body")
        exit_label = self._block("loop.exit")

        self.loop_stack.append((header_label, exit_label))

        self._emit(f"  br label %{header_label}")
        self._emit(f"{header_label}:")
        self._emit(f"  br label %{body_label}")
        self._emit(f"{body_label}:")

        # Find matching .endloop
        depth = 1
        endloop_idx = -1
        j = start + 1
        while j < len(instructions):
            line = instructions[j].strip()
            if line == ".loop":
                depth += 1
            elif line == ".endloop":
                depth -= 1
                if depth == 0:
                    endloop_idx = j
                    break
            j += 1

        # Lower loop body
        self._terminated = False
        k = start + 1
        while k < endloop_idx:
            k = self._lower_instruction(instructions, k)

        if not self._terminated:
            self._emit(f"  br label %{header_label}")

        self._emit(f"{exit_label}:")
        self._terminated = False

        self.loop_stack.pop()
        return endloop_idx + 1

    def _lower_for_block(self, instructions: list[str], start: int) -> int:
        """Lower a .for var in arr / .endfor block."""
        line = instructions[start].strip()
        m = re.match(r"\.for (\w+) in (\w+)", line)
        if not m:
            raise ValueError(f"Cannot parse .for: {line}")
        var_name = m.group(1)
        arr_name = m.group(2)

        arr_t = "{ i8**, i64 }"

        # Load the array
        arr_ptr, arr_type, arr_sfn = self.locals[arr_name]
        arr_val = self._t()
        self._emit(f"  {arr_val} = load {arr_t}*, {arr_t}** {arr_ptr}")

        # Get data pointer and length
        data_gep = self._t()
        self._emit(f"  {data_gep} = getelementptr inbounds {arr_t}, {arr_t}* {arr_val}, i32 0, i32 0")
        data = self._t()
        self._emit(f"  {data} = load i8**, i8*** {data_gep}")
        len_gep = self._t()
        self._emit(f"  {len_gep} = getelementptr inbounds {arr_t}, {arr_t}* {arr_val}, i32 0, i32 1")
        length = self._t()
        self._emit(f"  {length} = load i64, i64* {len_gep}")

        # Create iterator counter
        iter_alloca = f"%for.iter.{self.block_counter}"
        self._emit_alloca(f"  {iter_alloca} = alloca i64")
        self._emit(f"  store i64 0, i64* {iter_alloca}")

        # Create loop variable
        var_alloca = f"%l.{var_name}"
        self._emit_alloca(f"  {var_alloca} = alloca i8*")
        self.locals[var_name] = (var_alloca, "i8*", "string")

        # Loop structure
        header = self._block("for.header")
        body = self._block("for.body")
        exit_label = self._block("for.exit")

        self.loop_stack.append((header, exit_label))

        self._emit(f"  br label %{header}")
        self._emit(f"{header}:")

        # Check: i < length
        i_val = self._t()
        self._emit(f"  {i_val} = load i64, i64* {iter_alloca}")
        cond = self._t()
        self._emit(f"  {cond} = icmp slt i64 {i_val}, {length}")
        self._emit(f"  br i1 {cond}, label %{body}, label %{exit_label}")

        self._emit(f"{body}:")

        # Load current element
        i_val2 = self._t()
        self._emit(f"  {i_val2} = load i64, i64* {iter_alloca}")
        elem_gep = self._t()
        self._emit(f"  {elem_gep} = getelementptr i8*, i8** {data}, i64 {i_val2}")
        elem = self._t()
        self._emit(f"  {elem} = load i8*, i8** {elem_gep}")
        self._emit(f"  store i8* {elem}, i8** {var_alloca}")

        # Find matching .endfor
        depth = 1
        endfor_idx = -1
        j = start + 1
        while j < len(instructions):
            jline = instructions[j].strip()
            if jline.startswith(".for "):
                depth += 1
            elif jline == ".endfor":
                depth -= 1
                if depth == 0:
                    endfor_idx = j
                    break
            j += 1

        # Lower body
        self._terminated = False
        k = start + 1
        while k < endfor_idx:
            k = self._lower_instruction(instructions, k)

        # Increment counter and loop back
        if not self._terminated:
            i_val3 = self._t()
            self._emit(f"  {i_val3} = load i64, i64* {iter_alloca}")
            next_val = self._t()
            self._emit(f"  {next_val} = add i64 {i_val3}, 1")
            self._emit(f"  store i64 {next_val}, i64* {iter_alloca}")
            self._emit(f"  br label %{header}")

        self._emit(f"{exit_label}:")
        self._terminated = False

        self.loop_stack.pop()
        return endfor_idx + 1

    def _lower_instruction(self, instructions: list[str], idx: int) -> int:
        """Lower a single instruction. Returns the next instruction index."""
        line = instructions[idx].strip()

        # If the previous instruction terminated the block, start a new one
        if self._terminated:
            after_label = self._block("unreachable")
            self._emit(f"{after_label}:")
            self._terminated = False

        if line == "noop":
            return idx + 1

        if line.startswith(".if "):
            return self._lower_if_block(instructions, idx)

        if line == ".loop":
            return self._lower_loop_block(instructions, idx)

        if line.startswith(".for "):
            return self._lower_for_block(instructions, idx)

        if line == "break":
            if self.loop_stack:
                _, exit_label = self.loop_stack[-1]
                self._emit(f"  br label %{exit_label}")
                self._terminated = True
            return idx + 1

        if line.startswith("eval "):
            expr = line[5:].strip()
            return self._lower_eval(expr, idx, instructions)

        if line.startswith("ret "):
            expr = line[4:].strip()
            self._lower_return(expr)
            self._terminated = True
            return idx + 1

        # Skip unknown
        return idx + 1

    def _lower_eval(self, expr: str, idx: int, instructions: list[str]) -> int:
        """Lower an eval instruction. May span multiple lines for struct literals."""
        # Check for multi-line struct literal
        if re.match(r"let (?:mut )?\w+ = \w+ \{", expr) and not expr.rstrip().endswith("}"):
            full_expr = expr
            j = idx + 1
            while j < len(instructions):
                cont = instructions[j].strip()
                full_expr += " " + cont
                if cont.rstrip().rstrip(",").endswith("}"):
                    break
                j += 1
            self._lower_let(full_expr)
            return j + 1

        if expr.startswith("let "):
            self._lower_let(expr)
            return idx + 1

        # Compound assignment: var += expr
        compound_m = re.match(r"(\w+) ([+\-*/])= (.+)", expr)
        if compound_m:
            var_name = compound_m.group(1)
            op = compound_m.group(2)
            rhs = compound_m.group(3).strip()
            self._lower_compound_assign(var_name, op, rhs)
            return idx + 1

        # Simple assignment: var = expr
        assign_m = re.match(r"(\w+) = (.+)", expr)
        if assign_m:
            var_name = assign_m.group(1)
            rhs = assign_m.group(2).strip()
            self._lower_assign(var_name, rhs)
            return idx + 1

        # Array push: arr.push(elem)
        push_m = re.match(r"(\w+)\.push\((.+)\)$", expr)
        if push_m:
            arr_name = push_m.group(1)
            elem_expr = push_m.group(2).strip()
            self._lower_array_push(arr_name, elem_expr)
            return idx + 1

        # Standalone expression (e.g., function call)
        if "runtime_raise_value_error_fn" in expr:
            m = re.search(r'runtime_raise_value_error_fn\("([^"]*)"\)', expr)
            if m:
                msg = m.group(1)
                msg_val, _ = self._lower_string_literal(msg)
                self._emit(f"  call void @sailfin_runtime_raise_value_error(i8* {msg_val})")
                return idx + 1

        # General expression evaluation
        self._lower_expression(expr)
        return idx + 1

    def _lower_let(self, expr: str):
        """Lower 'let [mut] NAME [-> TYPE] = EXPRESSION'."""
        m = re.match(r"let (?:mut )?(\w+)(?:\s*->\s*\w+(?:\[\])?)? = (.+)", expr)
        if not m:
            raise ValueError(f"Cannot parse let: {expr}")
        name = m.group(1)
        rhs = m.group(2).strip()

        # Check if RHS is a struct literal
        struct_lit = re.match(r"(\w+)\s*\{", rhs)
        if struct_lit and struct_lit.group(1) in self.structs:
            struct_name, field_exprs = self._parse_struct_literal(rhs)
            field_values: dict[str, tuple[str, str]] = {}
            for fname, fexpr in field_exprs.items():
                fval, ftyp, _ = self._lower_expression(fexpr)
                field_values[fname] = (fval, ftyp)
            val, typ = self._lower_struct_literal(struct_name, field_values)
            sfn_type = struct_name
        else:
            val, typ, sfn_type = self._lower_expression(rhs)

        if name in self.locals:
            # Reuse existing alloca (e.g., same variable in different loop iterations)
            ptr, _, _ = self.locals[name]
            self._emit(f"  store {typ} {val}, {typ}* {ptr}")
            self.locals[name] = (ptr, typ, sfn_type)
        else:
            alloca_name = f"%l.{name}"
            self._emit_alloca(f"  {alloca_name} = alloca {typ}")
            self._emit(f"  store {typ} {val}, {typ}* {alloca_name}")
            self.locals[name] = (alloca_name, typ, sfn_type)

    def _lower_assign(self, var_name: str, rhs: str):
        """Lower 'var = expr' assignment."""
        if var_name not in self.locals:
            raise ValueError(f"Cannot assign to unknown variable: {var_name}")
        ptr, llvm_type, sfn_type = self.locals[var_name]
        val, val_type, val_sfn = self._lower_expression(rhs)
        self._emit(f"  store {llvm_type} {val}, {llvm_type}* {ptr}")

    def _lower_compound_assign(self, var_name: str, op: str, rhs: str):
        """Lower 'var += expr' compound assignment."""
        if var_name not in self.locals:
            raise ValueError(f"Cannot assign to unknown variable: {var_name}")
        ptr, llvm_type, sfn_type = self.locals[var_name]
        old_val = self._t()
        self._emit(f"  {old_val} = load {llvm_type}, {llvm_type}* {ptr}")
        rhs_val, rhs_type, _ = self._lower_expression(rhs)

        if llvm_type == "double":
            llvm_op = {"+" : "fadd", "-": "fsub", "*": "fmul", "/": "fdiv"}[op]
            new_val = self._t()
            self._emit(f"  {new_val} = {llvm_op} double {old_val}, {rhs_val}")
            self._emit(f"  store double {new_val}, double* {ptr}")
        else:
            raise ValueError(f"Cannot apply {op}= to {llvm_type}")

    def _lower_return(self, expr: str):
        """Lower a return expression."""
        # Handle struct literal returns
        struct_lit = re.match(r"(\w+)\s*\{", expr)
        if struct_lit and struct_lit.group(1) in self.structs:
            struct_name, field_exprs = self._parse_struct_literal(expr)
            field_values: dict[str, tuple[str, str]] = {}
            for fname, fexpr in field_exprs.items():
                fval, ftyp, _ = self._lower_expression(fexpr)
                field_values[fname] = (fval, ftyp)
            val, typ = self._lower_struct_literal(struct_name, field_values)
            self._emit(f"  ret {typ} {val}")
            return

        # Handle complex return expression with comparison
        # e.g. "_index_of(haystack, needle) >= 0"
        for op in [">=", "<=", ">", "<", "==", "!="]:
            idx = self._find_op_outside_strings(expr, op)
            if idx >= 0:
                left = expr[:idx].strip()
                right = expr[idx + len(op):].strip()
                result, _ = self._lower_comparison(left, op, right)
                self._emit(f"  ret i1 {result}")
                return

        val, typ, _ = self._lower_expression(expr)
        if typ == "void":
            self._emit("  ret void")
        else:
            self._emit(f"  ret {typ} {val}")

    # --- Function generation ---

    def generate_function(self, func: FunctionDef, all_functions: list[FunctionDef]) -> list[str]:
        """Generate LLVM IR for a function."""
        self.temp_counter = 0
        self.block_counter = 0
        self.lines = []
        self.allocas = []
        self.locals = {}
        self.loop_stack = []
        self._terminated = False
        self._all_functions = all_functions

        san_name = self._sanitize_symbol(func.name)

        params_ir = []
        for p in func.params:
            llvm_t = _sfn_type_to_llvm(p.sfn_type, self.enums)
            params_ir.append(f"{llvm_t} %{p.name}")

        ret_llvm = _sfn_type_to_llvm(func.return_type, self.enums)

        header = f"define {ret_llvm} @{san_name}({', '.join(params_ir)}) {{"
        result = [header, "block.entry:"]

        # Add parameters as locals
        for p in func.params:
            llvm_t = _sfn_type_to_llvm(p.sfn_type, self.enums)
            alloca_name = f"%l.{p.name}"
            self._emit_alloca(f"  {alloca_name} = alloca {llvm_t}")
            self._emit(f"  store {llvm_t} %{p.name}, {llvm_t}* {alloca_name}")
            self.locals[p.name] = (alloca_name, llvm_t, p.sfn_type)

        # Lower instructions
        i = 0
        while i < len(func.instructions):
            i = self._lower_instruction(func.instructions, i)

        # Add return if the function isn't terminated
        if not self._terminated:
            if ret_llvm == "void":
                self._emit("  ret void")
            else:
                default = "0.0" if ret_llvm == "double" else "null" if ret_llvm == "i8*" else "false"
                self._emit(f"  ret {ret_llvm} {default}")
        elif self._terminated:
            # Last block is dead code after a ret/break — add unreachable
            # Check if the last emitted line is a label (dead block)
            last = self.lines[-1] if self.lines else ""
            if last.endswith(":") or not any(l.strip().startswith(("ret ", "br ", "unreachable")) for l in self.lines[-2:]):
                self._emit("  unreachable")

        # Insert allocas at the beginning
        result.extend(self.allocas)
        result.extend(self.lines)
        result.append("}")
        return result


def generate_llvm_module(
    enums: dict[str, EnumDef],
    structs: dict[str, StructDef],
    functions: list[FunctionDef],
    source_filename: str,
    globals_list: list[GlobalLet] | None = None,
) -> str:
    """Generate a complete LLVM IR module."""
    lines: list[str] = []
    globals_list = globals_list or []
    has_async = any(f.is_async for f in functions)

    lines.append(f'source_filename = "{source_filename}"')
    lines.append("")

    # Struct type definitions
    for sdef in structs.values():
        lines.append(f"{sdef.llvm_name} = type {sdef.llvm_body}")
    lines.append("")

    # Enum type definitions
    for edef in enums.values():
        lines.append(f"{edef.llvm_name} = type {{ {edef.tag_type} }}")
    lines.append("")

    # Async future type declarations
    if has_async:
        lines.extend([
            "%SailfinFutureNumber = type opaque",
            "%SailfinFutureBool = type opaque",
            "%SailfinFuturePtr = type opaque",
            "%SailfinFutureVoid = type opaque",
            "%SailfinFutureString = type opaque",
            "",
            "declare %SailfinFutureNumber* @sailfin_runtime_spawn_number(double ()*)",
            "declare %SailfinFutureNumber* @sailfin_runtime_spawn_number_ctx(double (i8*)*, i8*)",
            "declare double @sailfin_runtime_await_number(%SailfinFutureNumber*)",
            "declare %SailfinFutureBool* @sailfin_runtime_spawn_bool(i1 ()*)",
            "declare %SailfinFutureBool* @sailfin_runtime_spawn_bool_ctx(i1 (i8*)*, i8*)",
            "declare i1 @sailfin_runtime_await_bool(%SailfinFutureBool*)",
            "declare %SailfinFuturePtr* @sailfin_runtime_spawn_ptr(i8* ()*)",
            "declare %SailfinFuturePtr* @sailfin_runtime_spawn_ptr_ctx(i8* (i8*)*, i8*)",
            "declare i8* @sailfin_runtime_await_ptr(%SailfinFuturePtr*)",
            "declare %SailfinFutureVoid* @sailfin_runtime_spawn_void(void ()*)",
            "declare %SailfinFutureVoid* @sailfin_runtime_spawn_void_ctx(void (i8*)*, i8*)",
            "declare void @sailfin_runtime_await_void(%SailfinFutureVoid*)",
            "declare %SailfinFutureString* @sailfin_runtime_spawn_string(i8* ()*)",
            "declare %SailfinFutureString* @sailfin_runtime_spawn_string_ctx(i8* (i8*)*, i8*)",
            "declare i8* @sailfin_runtime_await_string(%SailfinFutureString*)",
            "",
        ])

    # Standard runtime declarations
    lines.extend([
        "declare void @sailfin_runtime_raise_value_error(i8*)",
        "declare i1 @strings_equal(i8*, i8*)",
        "declare noalias i8* @malloc(i64)",
        "declare void @free(i8*)",
        "declare void @sailfin_runtime_mark_persistent(i8*)",
        "declare i64 @sailfin_runtime_string_length(i8*)",
        "declare i8* @sailfin_runtime_string_concat(i8*, i8*)",
        "declare i8* @sailfin_runtime_grapheme_at(i8*, double)",
        "declare i8* @sailfin_runtime_substring(i8*, i64, i64)",
        "declare i8* @sailfin_runtime_substring_unchecked(i8*, i64, i64)",
        "declare i8* @sailfin_runtime_number_to_string(double)",
        "declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)",
        "",
    ])

    # Build globals map
    globals_map = {g.name: g for g in globals_list}

    # Build the complete function list for lookups (includes method stubs)
    all_functions_for_lookup: list[FunctionDef] = list(functions)
    for sdef in structs.values():
        for mdef in sdef.methods:
            all_functions_for_lookup.append(FunctionDef(
                name=f"{sdef.name}{mdef.name}",
                params=mdef.params,
                return_type=mdef.return_type,
                instructions=mdef.instructions,
            ))

    gen = LLVMGen(enums, structs, globals_map)

    for func in functions:
        if func.is_async:
            # --- Async function: generate impl + ctx struct + trampoline + wrapper ---

            # 1. Generate __async_impl using the standard function generator
            impl_func = FunctionDef(
                name=func.name + "__async_impl",
                params=func.params,
                return_type=func.return_type,
                instructions=func.instructions,
            )
            func_lines = gen.generate_function(impl_func, all_functions_for_lookup)
            lines.extend(func_lines)
            lines.append("")

            san_name = re.sub(r"[^A-Za-z0-9_]", "", func.name)
            category = _async_category(func.return_type)
            ret_llvm = _sfn_type_to_llvm(func.return_type, enums)

            # 2. Context struct type
            ctx_name = f"SailfinAsyncCtx.{func.name}"
            param_types = [_sfn_type_to_llvm(p.sfn_type, enums) for p in func.params]
            ctx_body = "{ " + ", ".join(param_types) + " }" if param_types else "{ i8 }"
            lines.append(f"%{ctx_name} = type {ctx_body}")
            lines.append("")

            # 3. Trampoline function
            lines.append(f"define internal {ret_llvm} @{san_name}__async_trampoline(i8* %ctx_raw) {{")
            lines.append("block.entry:")
            lines.append(f"  %t0 = bitcast i8* %ctx_raw to %{ctx_name}*")
            tc = 1
            impl_arg_refs: list[str] = []
            for pi, p in enumerate(func.params):
                pt = _sfn_type_to_llvm(p.sfn_type, enums)
                lines.append(f"  %t{tc} = getelementptr inbounds %{ctx_name}, %{ctx_name}* %t0, i32 0, i32 {pi}")
                lines.append(f"  %t{tc + 1} = load {pt}, {pt}* %t{tc}")
                impl_arg_refs.append(f"{pt} %t{tc + 1}")
                tc += 2
            impl_args_ir = ", ".join(impl_arg_refs)
            if ret_llvm == "void":
                lines.append(f"  call void @{san_name}__async_impl({impl_args_ir})")
                lines.append(f"  call void @free(i8* %ctx_raw)")
                lines.append("  ret void")
            else:
                lines.append(f"  %t{tc} = call {ret_llvm} @{san_name}__async_impl({impl_args_ir})")
                lines.append(f"  call void @free(i8* %ctx_raw)")
                lines.append(f"  ret {ret_llvm} %t{tc}")
            lines.append("}")
            lines.append("")

            # 4. Wrapper function (spawns the trampoline)
            future_type = f"%SailfinFuture{category}*"
            spawn_fn = f"sailfin_runtime_spawn_{category.lower()}_ctx"
            trampoline_type = f"{ret_llvm} (i8*)*"
            param_ir = ", ".join(
                f"{_sfn_type_to_llvm(p.sfn_type, enums)} %{p.name}" for p in func.params
            )
            lines.append(f"define {future_type} @{san_name}({param_ir}) {{")
            lines.append("block.entry:")
            lines.append(f"  %t0 = getelementptr inbounds %{ctx_name}, %{ctx_name}* null, i32 1")
            lines.append(f"  %t1 = ptrtoint %{ctx_name}* %t0 to i64")
            lines.append(f"  %t2 = call noalias i8* @malloc(i64 %t1)")
            lines.append(f"  %t3 = bitcast i8* %t2 to %{ctx_name}*")
            tc = 4
            for pi, p in enumerate(func.params):
                pt = _sfn_type_to_llvm(p.sfn_type, enums)
                lines.append(f"  %t{tc} = getelementptr inbounds %{ctx_name}, %{ctx_name}* %t3, i32 0, i32 {pi}")
                lines.append(f"  store {pt} %{p.name}, {pt}* %t{tc}")
                tc += 1
            lines.append(f"  %t{tc} = call {future_type} @{spawn_fn}({trampoline_type} @{san_name}__async_trampoline, i8* %t2)")
            lines.append(f"  ret {future_type} %t{tc}")
            lines.append("}")
            lines.append("")
        else:
            # Regular (non-async) function
            func_lines = gen.generate_function(func, all_functions_for_lookup)
            lines.extend(func_lines)
            lines.append("")

    # Generate standalone method functions
    for sdef in structs.values():
        for mdef in sdef.methods:
            method_func = FunctionDef(
                name=f"{sdef.name}{mdef.name}",
                params=mdef.params,
                return_type=mdef.return_type,
                instructions=mdef.instructions,
            )
            func_lines = gen.generate_function(method_func, all_functions_for_lookup)
            lines.extend(func_lines)
            lines.append("")

    # String constants
    for content, name in gen.string_constants.items():
        raw = gen._unescape_string(content) if '\\' in content else content
        encoded = raw.encode("utf-8")
        length = len(encoded) + 1
        llvm_str = gen._to_llvm_string(raw)
        lines.append(f'{name} = private unnamed_addr constant [{length} x i8] c"{llvm_str}\\00"')
    lines.append("")

    # Test harness main
    test_funcs = [f for f in functions if f.is_test]
    if test_funcs:
        lines.append("define i32 @main(i32 %argc, i8** %argv) {")
        lines.append("entry:")
        for tf in test_funcs:
            san = re.sub(r"[^A-Za-z0-9_]", "", tf.name)
            lines.append(f"  call void @{san}()")
        lines.append("  ret i32 0")
        lines.append("}")
        lines.append("")

    return "\n".join(lines)


# ---------------------------------------------------------------------------
# Build + run
# ---------------------------------------------------------------------------

def _find_tool(name: str) -> str:
    """Find an LLVM tool or clang."""
    path = shutil.which(name)
    if path:
        return path
    for prefix in ["/opt/homebrew/opt/llvm/bin/", "/usr/local/opt/llvm/bin/"]:
        p = prefix + name
        if os.path.isfile(p):
            return p
    return name


def compile_and_run_test(
    ll_path: pathlib.Path,
    runtime_obj: pathlib.Path | None = None,
    linked_obj: pathlib.Path | None = None,
    weak_linked_obj: pathlib.Path | None = None,
    extra_link_args: list[str] | None = None,
) -> int:
    """Compile .ll to executable and run. Returns exit code."""
    build_dir = ll_path.parent

    obj_path = build_dir / "test_gen.o"
    llc = _find_tool("llc")
    cmd = [llc, "-filetype=obj", "-relocation-model=pic", "-O2",
           str(ll_path), "-o", str(obj_path)]
    print(f"[test-gen] llc: {' '.join(cmd)}")
    r = subprocess.run(cmd, capture_output=True, text=True)
    if r.returncode != 0:
        print(f"[test-gen] llc failed:\n{r.stderr}")
        return 1

    exe_path = build_dir / "test_gen"
    clang = _find_tool("clang")
    link_cmd = [clang, "-o", str(exe_path), str(obj_path)]

    if runtime_obj and runtime_obj.exists():
        link_cmd.append(str(runtime_obj))

    if weak_linked_obj and weak_linked_obj.exists():
        link_cmd.append(str(weak_linked_obj))
    elif linked_obj and linked_obj.exists():
        weak_path = build_dir / "native.linked.weak.o"
        shutil.copy2(str(linked_obj), str(weak_path))
        objcopy = _find_tool("llvm-objcopy")
        subprocess.run([objcopy, "--weaken", str(weak_path)], check=True)
        link_cmd.append(str(weak_path))

    if extra_link_args:
        link_cmd.extend(extra_link_args)

    link_cmd.extend(["-lm", "-lpthread"])

    print(f"[test-gen] clang link: {' '.join(link_cmd)}")
    r = subprocess.run(link_cmd, capture_output=True, text=True)
    if r.returncode != 0:
        print(f"[test-gen] link failed:\n{r.stderr}")
        return 1

    print(f"[test-gen] running: {exe_path}")
    r = subprocess.run([str(exe_path)], capture_output=True, text=True, timeout=30)
    if r.stdout:
        print(r.stdout, end="")
    if r.stderr:
        print(r.stderr, end="", file=sys.stderr)
    return r.returncode


def run_test(
    compiler: pathlib.Path,
    test_file: pathlib.Path,
    extra_link_objs: list[pathlib.Path] | None = None,
) -> int:
    """Run a single test file using the Python-based LLVM generator."""
    build_dir = BUILD_DIR
    build_dir.mkdir(parents=True, exist_ok=True)

    sfn_asm_path = build_dir / "debug-test-native.sfn-asm"

    # Remove stale .sfn-asm from previous runs
    if sfn_asm_path.exists():
        sfn_asm_path.unlink()

    print(f"[test-gen] emitting .sfn-asm via {compiler.name} for {test_file}")
    try:
        subprocess.run(
            [str(compiler), "test", str(test_file)],
            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, timeout=30,
        )
    except subprocess.TimeoutExpired:
        # The compiler may hang during LLVM lowering or execution, but
        # the .sfn-asm file is written before that stage.
        print("[test-gen] compiler timed out (expected for some tests); checking .sfn-asm")

    if not sfn_asm_path.exists():
        print(f"[test-gen] error: {sfn_asm_path} was not generated")
        return 1

    sfn_asm_text = sfn_asm_path.read_text()
    enums, structs, functions, globals_list = parse_sfn_asm(sfn_asm_text)
    print(f"[test-gen] parsed: {len(enums)} enums, {len(structs)} structs, {len(functions)} functions, {len(globals_list)} globals")

    ll_text = generate_llvm_module(enums, structs, functions, str(test_file), globals_list)
    ll_path = build_dir / "test_gen.ll"
    ll_path.write_text(ll_text)
    print(f"[test-gen] generated {ll_path} ({len(ll_text)} bytes)")

    return compile_and_run_test(
        ll_path,
        extra_link_args=[str(p) for p in (extra_link_objs or []) if p.exists()],
    )


# ---------------------------------------------------------------------------
# CLI entry point
# ---------------------------------------------------------------------------

def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Generate correct LLVM IR from .sfn-asm test files")
    parser.add_argument("--compiler", type=pathlib.Path, required=True,
                        help="Path to the Sailfin compiler binary")
    parser.add_argument("--test", type=pathlib.Path, required=True,
                        help="Path to the .sfn test file")
    parser.add_argument("--link-obj", type=pathlib.Path, action="append", default=[],
                        help="Additional .o files to link (can be repeated)")
    args = parser.parse_args(argv)

    return run_test(
        compiler=args.compiler,
        test_file=args.test,
        extra_link_objs=args.link_obj,
    )


if __name__ == "__main__":
    sys.exit(main())
