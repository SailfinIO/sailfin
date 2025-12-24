#!/usr/bin/env python3
"""Prepare Stage2 LLVM IR for AOT compilation without llvmlite.

This tool rewrites a directory of stage2-produced *.ll modules into an AOT-safe
form for clang/ld, similar to `tools/prepare_stage2_aot.py`, but without
importing `llvmlite` (or `runtime.stage2_runner`).

Currently it performs:
- Rename IR entrypoint `@main` -> `@stage2_compiler_main` (to avoid colliding
  with the native C driver `main`).
- De-duplicate colliding defined functions/globals across modules by renaming
  later definitions and rewriting their intra-module references.

Usage:
  python tools/prepare_stage2_aot_text.py --input build/stage2 --output build/stage2/aot
"""

from __future__ import annotations

import argparse
import pathlib
import re
from dataclasses import dataclass

REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]


_SYMBOL_CHARS = r"[A-Za-z0-9_.$]"


@dataclass(frozen=True)
class ModuleIR:
    name: str
    path: pathlib.Path
    text: str


_DEFINE_RE = re.compile(
    r"^\s*define\b[^@]*@(?P<name>" + _SYMBOL_CHARS + r"+)\b", re.MULTILINE)
_GLOBAL_RE = re.compile(r"^\s*@(?P<name>" + _SYMBOL_CHARS +
                        r"+)\s*=\s*(?:external\s+)?(?:global|constant)\b", re.MULTILINE)

_LLVM_ROUND_F64 = "@llvm.round.f64"
_LLVM_ROUND_F64_DECL_RE = re.compile(
    r"^\s*declare\s+double\s+@llvm\.round\.f64\(double\)\s*$",
    re.MULTILINE,
)


def _ensure_intrinsic_decls(ir: str) -> str:
    """Ensure per-module intrinsic declarations exist for AOT compilation.

    We compile each module independently with clang; some toolchains (notably
    clang-15) reject calls to intrinsics that lack an explicit `declare` in the
    same module.
    """

    updated = ir
    if _LLVM_ROUND_F64 in updated and not _LLVM_ROUND_F64_DECL_RE.search(updated):
        decl = "declare double @llvm.round.f64(double)\n"

        # Insert after `source_filename` (or after the module ID line) to keep
        # declarations near the top while preserving leading comments.
        insert_at = 0
        source_at = updated.find("source_filename")
        if source_at != -1:
            line_end = updated.find("\n", source_at)
            insert_at = len(updated) if line_end == -1 else line_end + 1
        else:
            module_id_at = updated.find("; ModuleID")
            if module_id_at != -1:
                line_end = updated.find("\n", module_id_at)
                insert_at = len(updated) if line_end == -1 else line_end + 1

        updated = updated[:insert_at] + decl + updated[insert_at:]

    return updated


def _load_modules(input_dir: pathlib.Path) -> list[ModuleIR]:
    artifacts = sorted(input_dir.glob("*.ll"))
    if not artifacts:
        raise FileNotFoundError(f"no .ll files found in {input_dir}")
    modules: list[ModuleIR] = []
    for artifact in artifacts:
        modules.append(
            ModuleIR(name=artifact.stem, path=artifact,
                     text=artifact.read_text(encoding="utf-8"))
        )
    return modules


def _find_defined_symbols(ir: str) -> tuple[set[str], set[str]]:
    functions = {m.group("name") for m in _DEFINE_RE.finditer(ir)}
    globals_ = {m.group("name") for m in _GLOBAL_RE.finditer(ir)}
    return functions, globals_


def _rename_symbol_refs(ir: str, old: str, new: str) -> str:
    """Replace exact `@old` symbol references (not `@old.suffix`).

    Important: do not rewrite inside LLVM IR string literals (e.g. c"...")
    because changing bytes there will invalidate the declared array length.
    """

    def is_symbol_char(ch: str) -> bool:
        return ch.isalnum() or ch in "_.$."

    out: list[str] = []
    i = 0
    in_quote = False
    old_len = len(old)
    while i < len(ir):
        ch = ir[i]

        if ch == '"':
            # Toggle quote mode when the quote is not escaped.
            backslashes = 0
            j = i - 1
            while j >= 0 and ir[j] == "\\":
                backslashes += 1
                j -= 1
            if backslashes % 2 == 0:
                in_quote = not in_quote
            out.append(ch)
            i += 1
            continue

        if not in_quote and ch == "@" and ir.startswith(old, i + 1):
            end = i + 1 + old_len
            if end >= len(ir) or not is_symbol_char(ir[end]):
                out.append("@" + new)
                i = end
                continue

        out.append(ch)
        i += 1

    return "".join(out)


def _rewrite_module(
    module: ModuleIR,
    *,
    seen_functions: set[str],
    seen_globals: set[str],
) -> tuple[str, list[str], list[str]]:
    """Return rewritten IR, plus lists of renames applied."""

    ir = module.text

    # Keep per-module IR compilable for clang AOT.
    ir = _ensure_intrinsic_decls(ir)

    # Avoid C driver `main` collision.
    if module.name == "main":
        ir = ir.replace("@main(", "@stage2_compiler_main(")

    defined_functions, defined_globals = _find_defined_symbols(ir)

    function_renames: list[str] = []
    global_renames: list[str] = []

    # Rename duplicate defined functions.
    for name in sorted(defined_functions):
        if name not in seen_functions:
            seen_functions.add(name)
            continue
        # First collision becomes `name__<module>`, then `name__<module>_2`, etc.
        counter = 1
        while True:
            suffix = module.name if counter == 1 else f"{module.name}_{counter}"
            candidate = f"{name}__{suffix}"
            if candidate not in seen_functions:
                break
            counter += 1
        ir = _rename_symbol_refs(ir, name, candidate)
        seen_functions.add(candidate)
        function_renames.append(f"{name}->{candidate}")

    # Rename duplicate defined globals.
    for name in sorted(defined_globals):
        if name not in seen_globals:
            seen_globals.add(name)
            continue
        counter = 1
        while True:
            suffix = module.name if counter == 1 else f"{module.name}_{counter}"
            candidate = f"{name}__{suffix}"
            if candidate not in seen_globals:
                break
            counter += 1
        ir = _rename_symbol_refs(ir, name, candidate)
        seen_globals.add(candidate)
        global_renames.append(f"{name}->{candidate}")

    return ir, function_renames, global_renames


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description="Rewrite stage2 LLVM IR modules for AOT compilation (no llvmlite)"
    )
    parser.add_argument(
        "--input",
        type=pathlib.Path,
        default=REPO_ROOT / "build" / "stage2",
        help="Directory containing stage2 *.ll modules (default: build/stage2)",
    )
    parser.add_argument(
        "--output",
        type=pathlib.Path,
        default=REPO_ROOT / "build" / "stage2" / "aot",
        help="Directory to write rewritten *.ll modules (default: build/stage2/aot)",
    )

    args = parser.parse_args(argv)

    modules = _load_modules(args.input)
    args.output.mkdir(parents=True, exist_ok=True)

    seen_functions: set[str] = set()
    seen_globals: set[str] = set()

    rewritten_names: list[str] = []
    total_func_renames: list[str] = []
    total_global_renames: list[str] = []

    for module in modules:
        rewritten_ir, func_renames, glob_renames = _rewrite_module(
            module, seen_functions=seen_functions, seen_globals=seen_globals
        )
        (args.output /
         f"{module.name}.ll").write_text(rewritten_ir, encoding="utf-8")
        rewritten_names.append(module.name)
        total_func_renames.extend(func_renames)
        total_global_renames.extend(glob_renames)

    (args.output / "modules.txt").write_text("\n".join(rewritten_names) +
                                             "\n", encoding="utf-8")

    print(
        f"[prepare-stage2-aot-text] wrote {len(rewritten_names)} module(s) to {args.output}")
    if total_func_renames:
        print(
            f"[prepare-stage2-aot-text] renamed {len(total_func_renames)} function(s)")
    if total_global_renames:
        print(
            f"[prepare-stage2-aot-text] renamed {len(total_global_renames)} global(s)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
