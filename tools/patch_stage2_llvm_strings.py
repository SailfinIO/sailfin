"""Patch stage2-native `--emit llvm` output to be clang-linkable.

Today the stage2-native `--emit llvm` mode can emit IR that references
string constant globals (e.g. `@.str.len15.h123`) without defining them.

This helper scans the Sailfin source for string literals, computes the
same deterministic constant names as the compiler, and injects any missing
constant definitions into the IR.

It is intentionally minimal and currently assumes ASCII-only literals.
"""

from __future__ import annotations

import argparse
import pathlib
import re
import sys
from dataclasses import dataclass


_STR_REF_RE = re.compile(r"@\.str\.len(\d+)\.h(\d+)")


@dataclass(frozen=True)
class StringConst:
    name: str  # includes leading '@'
    content: str


def _unescape_sailfin_string_literal(token: str) -> str:
    token = token.strip()
    if len(token) < 2 or token[0] != '"' or token[-1] != '"':
        return ""
    inner = token[1:-1]
    out: list[str] = []
    i = 0
    while i < len(inner):
        ch = inner[i]
        if ch == "\\" and i + 1 < len(inner):
            nxt = inner[i + 1]
            if nxt == "n":
                out.append("\n")
                i += 2
                continue
            if nxt == "r":
                out.append("\r")
                i += 2
                continue
            if nxt == "t":
                out.append("\t")
                i += 2
                continue
            if nxt == '"':
                out.append('"')
                i += 2
                continue
            if nxt == "\\":
                out.append("\\")
                i += 2
                continue
            # Unknown escape: keep the escaped char (matches compiler fallback).
            out.append(nxt)
            i += 2
            continue
        out.append(ch)
        i += 1
    return "".join(out)


def _compute_string_constant_hash(content: str) -> int:
    # Mirrors `compute_string_constant_hash` in `compiler/src/native_llvm_lowering.sfn`.
    h = 5381
    modulus = 2147483647
    for ch in content:
        h = h * 33 + ord(ch)
        while h >= modulus:
            h -= modulus
    h = h * 33 + len(content)
    while h >= modulus:
        h -= modulus
    return int(h)


def _make_string_constant_name(content: str) -> str:
    return f"@.str.len{len(content)}.h{_compute_string_constant_hash(content)}"


def _escape_string_for_llvm(content: str) -> str:
    out: list[str] = []
    for ch in content:
        if ch == "\n":
            out.append("\\0A")
        elif ch == "\r":
            out.append("\\0D")
        elif ch == "\t":
            out.append("\\09")
        elif ch == '"':
            out.append("\\22")
        elif ch == "\\":
            out.append("\\5C")
        else:
            out.append(ch)
    return "".join(out)


def _render_string_constant_definition(constant: StringConst) -> str:
    # LLVM string constants include a trailing null terminator.
    length = len(constant.content.encode("utf-8")) + 1
    escaped = _escape_string_for_llvm(constant.content)
    return f"{constant.name} = private unnamed_addr constant [{length} x i8] c\"{escaped}\\00\""


def _extract_string_literals(source: str) -> list[str]:
    # Minimal lexer: finds double-quoted literals, respecting backslash escapes.
    literals: list[str] = []
    i = 0
    in_string = False
    buf: list[str] = []
    while i < len(source):
        ch = source[i]
        if not in_string:
            if ch == '"':
                in_string = True
                buf = ['"']
            i += 1
            continue

        # in string
        buf.append(ch)
        if ch == "\\" and i + 1 < len(source):
            buf.append(source[i + 1])
            i += 2
            continue
        if ch == '"':
            token = "".join(buf)
            literals.append(token)
            in_string = False
            buf = []
        i += 1

    return literals


def _inject_definitions(ir: str, definitions: list[str]) -> str:
    if not definitions:
        return ir

    lines = ir.splitlines()
    already_defined: set[str] = set()
    for line in lines:
        stripped = line.strip()
        if stripped.startswith("@") and " = " in stripped:
            name = stripped.split("=", 1)[0].strip()
            already_defined.add(name)

    missing = [d for d in definitions if d.split(
        "=", 1)[0].strip() not in already_defined]
    if not missing:
        return ir

    insert_at = 0
    for idx, line in enumerate(lines):
        if line.strip() == "@runtime = external global i8**":
            insert_at = idx + 1
            # Prefer a blank line separation.
            if insert_at < len(lines) and lines[insert_at].strip() == "":
                insert_at += 1
            break

    patched = lines[:insert_at] + missing + [""] + lines[insert_at:]
    return "\n".join(patched) + ("\n" if ir.endswith("\n") else "")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", type=pathlib.Path, required=True)
    parser.add_argument("--ir", type=pathlib.Path, required=True)
    parser.add_argument("--out", type=pathlib.Path, required=True)
    args = parser.parse_args(argv)

    source_text = args.source.read_text(encoding="utf-8")
    ir_text = args.ir.read_text(encoding="utf-8")

    source_literals = _extract_string_literals(source_text)
    mapping: dict[str, StringConst] = {}
    for token in source_literals:
        content = _unescape_sailfin_string_literal(token)
        if content == "" and token != '""':
            # Skip malformed tokens.
            continue
        name = _make_string_constant_name(content)
        mapping.setdefault(name, StringConst(name=name, content=content))

    referenced: set[str] = set(m.group(0)
                               for m in _STR_REF_RE.finditer(ir_text))

    definitions: list[str] = []
    missing_names: list[str] = []
    for name in sorted(referenced):
        if name in mapping:
            definitions.append(
                _render_string_constant_definition(mapping[name]))
        else:
            missing_names.append(name)

    if missing_names:
        sys.stderr.write(
            "[patch-stage2-llvm-strings] warning: missing source literal(s) for constants:\n"
        )
        for name in missing_names:
            sys.stderr.write(f"  - {name}\n")

    patched = _inject_definitions(ir_text, definitions)
    args.out.parent.mkdir(parents=True, exist_ok=True)
    args.out.write_text(patched, encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
