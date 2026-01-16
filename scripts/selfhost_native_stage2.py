#!/usr/bin/env python3
"""Rebuild the native stage2 compiler using an existing native stage2 binary.

This is the self-host check CI ultimately needs:

- Start from a *seed* native `sailfin-stage2` binary.
- Compile the full stage2 module set (compiler + runtime Sailfin sources) to
    separate LLVM modules.
- The selfhost pipeline is expected to produce link-safe IR without text rewriting
    (no `aot-prepare-dir`).
- Compile/link a fresh native `sailfin-stage2`.

This does NOT import stage1-generated Python compiler artifacts and does NOT run
`scripts/bootstrap_stage2.py`.
"""

from __future__ import annotations

import argparse
import concurrent.futures
import hashlib
import os
import pathlib
import shutil
import subprocess
import sys
import time
import re
import threading
import shlex


REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]


DEFAULT_MAX_TOTAL_SECONDS = 1800.0 if sys.platform == "darwin" else 1200.0


_IMPORT_FROM_RE = re.compile(r"\bfrom\s+\"(?P<path>[^\"]+)\"")
_IMPORT_BARE_RE = re.compile(
    r"^\s*import\s+\"(?P<path>[^\"]+)\"\s*;", re.MULTILINE)

_IMPORT_SYMBOLS_RE = re.compile(
    r"import\s*\{(?P<names>[^}]+)\}\s*from\s+\"(?P<path>[^\"]+)\"\s*;",
    re.MULTILINE,
)

_TOPLEVEL_FN_RE = re.compile(
    r"^\s*(?:pub\s+)?fn\s+(?P<name>[A-Za-z_][A-Za-z0-9_]*)\s*\(",
    re.MULTILINE,
)


_LLVM_NAMED_TYPE_DEF_RE = re.compile(
    r"^\s*(?P<name>%[A-Za-z_.$][A-Za-z0-9_.$]*)\s*=\s*type\s+(?P<body>.+)$",
    re.MULTILINE,
)


_OPAQUE_PTR_CLANG_ERR_RE = re.compile(
    r"ptr type is only supported in -opaque-pointers mode",
    re.IGNORECASE,
)


def _collect_concrete_named_type_defs(llvm_ir: str) -> dict[str, str]:
    """Return concrete named type definitions found in the LLVM module.

    We use this to patch other modules that declare the same types as
    `type opaque` under older release seeds.
    """

    out: dict[str, str] = {}
    for m in _LLVM_NAMED_TYPE_DEF_RE.finditer(llvm_ir):
        name = m.group("name")
        body = m.group("body").strip()
        if body == "opaque":
            continue
        # Keep the original formatting of the definition line.
        out[name] = f"{name} = type {body}"
    return out


def _patch_opaque_named_types(llvm_ir: str, known_defs: dict[str, str]) -> tuple[str, int]:
    """Replace `type opaque` declarations when a concrete definition is known.

    If the concrete definition references other named types (e.g. `%Token` uses
    `%TokenKind`), ensure those dependent type definitions are also present in
    the module before clang validation.
    """

    if not known_defs:
        return llvm_ir, 0

    type_decl_re = re.compile(
        r"^\s*(?P<name>%[A-Za-z_.$][A-Za-z0-9_.$]*)\s*=\s*type\s+(?P<body>.+)\s*$"
    )
    name_ref_re = re.compile(r"%[A-Za-z_.$][A-Za-z0-9_.$]*")

    lines_in = llvm_ir.splitlines()

    # Track which named types are already concretely defined in this module.
    # NOTE: Opaque definitions are *not* considered "defined" for our purposes
    # because we want to replace them when a concrete definition is known.
    concrete_defined: set[str] = set()
    for line in lines_in:
        m = type_decl_re.match(line)
        if not m:
            continue
        if m.group("body").strip() == "opaque":
            continue
        concrete_defined.add(m.group("name"))

    # Names we inserted (so we don't re-insert or loop forever).
    emitted: set[str] = set()

    def _emit_with_deps(name: str) -> list[str]:
        if name in emitted or name in concrete_defined:
            return []
        definition = known_defs.get(name)
        if definition is None:
            return []
        # Recurse into dependencies that we also know how to define.
        deps: list[str] = []
        body = definition.split("type", 1)[1]
        for ref in name_ref_re.findall(body):
            if ref == name:
                continue
            if ref in known_defs and ref not in concrete_defined and ref not in emitted:
                deps.extend(_emit_with_deps(ref))
        emitted.add(name)
        concrete_defined.add(name)
        deps.append(definition)
        return deps

    patched_lines: list[str] = []
    changed = 0
    for line in lines_in:
        stripped = line.strip()
        if stripped.endswith("= type opaque"):
            prefix_len = len(line) - len(line.lstrip(" \t"))
            prefix = line[:prefix_len]
            name = stripped.split("=", 1)[0].strip()
            if name in known_defs:
                injected = _emit_with_deps(name)
                if injected:
                    for inj in injected:
                        patched_lines.append(prefix + inj)
                # Whether we injected a definition here or the module already
                # had a concrete definition elsewhere, drop the opaque line.
                changed += 1
                continue
        patched_lines.append(line)

    return "\n".join(patched_lines) + "\n", changed


def _maybe_add_opaque_pointers_flag(
    *,
    clang_flags: list[str],
    clang_stderr: str,
) -> tuple[list[str], bool]:
    """Return updated clang flags if stderr indicates opaque pointers are required."""

    if not clang_stderr:
        return clang_flags, False

    # If clang doesn't understand the `ptr` keyword in LLVM IR, it will emit a
    # diagnostic like:
    #   "ptr type is only supported in -opaque-pointers mode"
    if _OPAQUE_PTR_CLANG_ERR_RE.search(clang_stderr) is None:
        return clang_flags, False

    # Avoid duplicating the flag.
    for idx, flag in enumerate(clang_flags):
        if flag == "-opaque-pointers":
            return clang_flags, False
        if flag == "-Xclang" and idx + 1 < len(clang_flags) and clang_flags[idx + 1] == "-opaque-pointers":
            return clang_flags, False

    return [*clang_flags, "-Xclang", "-opaque-pointers"], True


_BITCAST_FROM_BYTES_TO_PTR_RE = re.compile(
    r"^\s*(?P<dst>%[A-Za-z_.$][A-Za-z0-9_.$]*)\s*=\s*bitcast\s+"
    r"(?:(?:i8\*)|(?:\[[0-9]+\s+x\s+i8\]\*))\s+"
    r"(?P<src>%[A-Za-z_.$][A-Za-z0-9_.$]*)\s+to\s+.+\*$"
)

_LOAD_WITH_PTR_RE = re.compile(
    r"^(?P<head>\s*(?:%[A-Za-z_.$][A-Za-z0-9_.$]*\s*=\s*)?load\s+.+?,\s+.+?\*\s+)"
    r"(?P<ptr>%[A-Za-z_.$][A-Za-z0-9_.$]*)"
    r"(?P<tail>.*)$"
)

_STORE_WITH_PTR_RE = re.compile(
    r"^(?P<head>\s*store\s+.+?,\s+.+?\*\s+)"
    r"(?P<ptr>%[A-Za-z_.$][A-Za-z0-9_.$]*)"
    r"(?P<tail>.*)$"
)

_GEP_PTR_BASE_RE = re.compile(
    r"^\s*(?P<dst>%[A-Za-z_.$][A-Za-z0-9_.$]*)\s*=\s*getelementptr\b.*?,\s+"
    r"(?:(?:ptr)|(?:.+?\*))\s+(?P<base>%[A-Za-z_.$][A-Za-z0-9_.$]*).*$"
)

_BITCAST_PTR_BASE_RE = re.compile(
    r"^\s*(?P<dst>%[A-Za-z_.$][A-Za-z0-9_.$]*)\s*=\s*bitcast\s+.+?\s+"
    r"(?P<base>%[A-Za-z_.$][A-Za-z0-9_.$]*)\s+to\s+.+$"
)


def _mark_unaligned_enum_payload_accesses(llvm_ir: str) -> tuple[str, int]:
    """Add `align 1` to loads/stores through enum-payload byte casts.

    Stage2 encodes enums as `{ tag, [payload_size x i8] }` and then accesses
    variant payload fields by bitcasting the payload byte pointer to a typed
    pointer. For enums with a 32-bit tag on 64-bit targets, payload starts at
    offset 4, so pointer-sized fields are commonly misaligned.

    A typed `load/store` without an explicit `align` carries an implied
    alignment. If the pointer is actually misaligned, that is undefined
    behavior and can miscompile (arm64 is particularly sensitive).

    We conservatively mark such accesses as `align 1` when the pointer operand
    originates from a `bitcast i8*` / `bitcast [.. x i8]*` into a typed pointer.
    """

    lines = llvm_ir.splitlines()
    changed = 0
    out: list[str] = []

    in_function = False
    maybe_unaligned: set[str] = set()

    for ln in lines:
        # Reset per-function state at function boundaries.
        if ln.lstrip().startswith("define "):
            in_function = True
            maybe_unaligned = set()
            out.append(ln)
            continue

        if in_function:
            m = _BITCAST_FROM_BYTES_TO_PTR_RE.match(ln)
            if m:
                maybe_unaligned.add(m.group("dst"))

            # Propagate unaligned-ness through derived pointers so we catch
            # loads/stores that use GEPs/bitcasts of the original payload cast.
            m_gep = _GEP_PTR_BASE_RE.match(ln)
            if m_gep and m_gep.group("base") in maybe_unaligned:
                maybe_unaligned.add(m_gep.group("dst"))
            else:
                m_bc = _BITCAST_PTR_BASE_RE.match(ln)
                if m_bc and m_bc.group("base") in maybe_unaligned:
                    maybe_unaligned.add(m_bc.group("dst"))

            # Patch loads/stores using those potentially unaligned pointers.
            if maybe_unaligned and "align" not in ln:
                m_load = _LOAD_WITH_PTR_RE.match(ln)
                if m_load and m_load.group("ptr") in maybe_unaligned:
                    tail = m_load.group("tail")
                    insert_at = tail.find(", !")
                    if insert_at != -1:
                        tail = ", align 1" + tail[insert_at:]
                    else:
                        tail = ", align 1" + tail
                    out.append(m_load.group("head") +
                               m_load.group("ptr") + tail)
                    changed += 1
                    if ln.strip() == "}":
                        in_function = False
                    continue

                # `store <val>, <ptr>` has two SSA values; we want the pointer operand.
                if ln.lstrip().startswith("store "):
                    ssa_names = re.findall(r"%[A-Za-z_.$][A-Za-z0-9_.$]*", ln)
                    if ssa_names:
                        ptr_name = ssa_names[-1]
                        if ptr_name in maybe_unaligned:
                            meta_at = ln.find(", !")
                            if meta_at != -1:
                                ln2 = ln[:meta_at] + ", align 1" + ln[meta_at:]
                            else:
                                ln2 = ln + ", align 1"
                            out.append(ln2)
                            changed += 1
                            if ln.strip() == "}":
                                in_function = False
                            continue

            out.append(ln)
            if ln.strip() == "}":
                in_function = False
            continue

        out.append(ln)

    return "\n".join(out) + ("\n" if llvm_ir.endswith("\n") else ""), changed


def _inject_debug_enum_payload_probes(llvm_ir: str, module_name: str) -> tuple[str, int]:
    """Inject best-effort debug probes to dump enum payload bits.

    This is for macOS/arm64 selfhost debugging where the selfhosted compiler
    crashes in `format_expression__emit_native` while reading the Call
    arguments pointer from the enum payload.

    Enabled only when `SAILFIN_SELFHOST_DEBUG_ENUM_PAYLOAD=1` is set.
    """

    if os.environ.get("SAILFIN_SELFHOST_DEBUG_ENUM_PAYLOAD") not in ("1", "true", "TRUE", "yes", "YES"):
        return llvm_ir, 0

    if module_name not in ("emit_native", "parser__expressions"):
        return llvm_ir, 0

    lines = llvm_ir.splitlines()
    changed = 0

    # Ensure declarations exist before any `define`.
    has_u64 = any(
        "declare void @sailfin_runtime_debug_dump_u64" in ln for ln in lines)
    has_ptr = any(
        "declare void @sailfin_runtime_debug_dump_ptr" in ln for ln in lines)
    if not (has_u64 and has_ptr):
        insert_at = next((i for i, ln in enumerate(
            lines) if ln.startswith("define ")), len(lines))
        decls: list[str] = []
        if not has_u64:
            decls.append("declare void @sailfin_runtime_debug_dump_u64(i64)")
        if not has_ptr:
            decls.append("declare void @sailfin_runtime_debug_dump_ptr(i8*)")
        if decls:
            lines[insert_at:insert_at] = decls + [""]
            changed += len(decls)

    out: list[str] = []

    if module_name == "emit_native":
        in_target_fn = False
        probe_idx = 0
        last_payload_i8: str | None = None
        last_payload8_i8: str | None = None
        last_tag_i32: str | None = None
        for ln in lines:
            if ln.startswith("define ") and "@format_expression__emit_native" in ln:
                in_target_fn = True
                out.append(ln)
                continue
            if in_target_fn and ln.strip() == "}":
                in_target_fn = False
                out.append(ln)
                continue

            if in_target_fn and re.match(r"^\s*[A-Za-z0-9_.]+:\s*(;.*)?$", ln):
                # Reset per-basic-block so we don't accidentally reuse values from a
                # non-dominating predecessor block.
                last_payload_i8 = None
                last_payload8_i8 = None
                last_tag_i32 = None

            # In Call-case blocks we have the pattern:
            #   %t661 = bitcast [40 x i8]* %t660 to i8*
            #   %t662 = getelementptr inbounds i8, i8* %t661, i64 8
            #   %t663 = bitcast i8* %t662 to { %Expression*, i64 }**
            #   %t664 = load { %Expression*, i64 }*, { %Expression*, i64 }** %t663, align 1
            # We probe the raw u64 words at payload+0 and payload+8 and the decoded ptr.

            if in_target_fn:
                m_tag = re.match(
                    r"^\s*(%[A-Za-z_.$][A-Za-z0-9_.$]*)\s*=\s*extractvalue\s+%Expression\s+%expression,\s*0\s*$",
                    ln,
                )
                if m_tag:
                    last_tag_i32 = m_tag.group(1)

                m_payload = re.match(
                    r"^\s*(%[A-Za-z_.$][A-Za-z0-9_.$]*)\s*=\s*bitcast\s+\[40 x i8\]\*\s+%[A-Za-z_.$][A-Za-z0-9_.$]*\s+to\s+i8\*\s*$",
                    ln,
                )
                if m_payload:
                    last_payload_i8 = m_payload.group(1)
                m_payload8 = re.match(
                    r"^\s*(%[A-Za-z_.$][A-Za-z0-9_.$]*)\s*=\s*getelementptr\s+inbounds\s+i8,\s+i8\*\s+(%[A-Za-z_.$][A-Za-z0-9_.$]*),\s+i64\s+8\s*$",
                    ln,
                )
                if m_payload8 and last_payload_i8 and m_payload8.group(2) == last_payload_i8:
                    last_payload8_i8 = m_payload8.group(1)

            if in_target_fn and "= load { %Expression*, i64 }*, { %Expression*, i64 }**" in ln and ", align 1" in ln:
                m = re.match(
                    r"^(\s*)(%[A-Za-z_.$][A-Za-z0-9_.$]*)\s*=\s*load\s+\{\s*%Expression\*,\s*i64\s*\}\*,\s+\{\s*%Expression\*,\s*i64\s*\}\*\*\s+(%[A-Za-z_.$][A-Za-z0-9_.$]*),\s*align\s+1\s*$",
                    ln,
                )
                if m:
                    indent = m.group(1)
                    loaded_ptr = m.group(2)
                    out.append(ln)
                    payload_i8 = last_payload_i8
                    payload8_i8 = last_payload8_i8
                    tag_i32 = last_tag_i32
                    if tag_i32 and payload_i8 and payload8_i8:
                        out.append(
                            f"{indent}%dbg_tag_i64.{probe_idx} = zext i32 {tag_i32} to i64")
                        out.append(
                            f"{indent}call void @sailfin_runtime_debug_dump_u64(i64 %dbg_tag_i64.{probe_idx})")
                        out.append(
                            f"{indent}%dbg_payload0_ptr.{probe_idx} = bitcast i8* {payload_i8} to i64*")
                        out.append(
                            f"{indent}%dbg_payload0.{probe_idx} = load i64, i64* %dbg_payload0_ptr.{probe_idx}, align 1")
                        out.append(
                            f"{indent}call void @sailfin_runtime_debug_dump_u64(i64 %dbg_payload0.{probe_idx})")
                        out.append(
                            f"{indent}%dbg_payload8_ptr.{probe_idx} = bitcast i8* {payload8_i8} to i64*")
                        out.append(
                            f"{indent}%dbg_payload8.{probe_idx} = load i64, i64* %dbg_payload8_ptr.{probe_idx}, align 1")
                        out.append(
                            f"{indent}call void @sailfin_runtime_debug_dump_u64(i64 %dbg_payload8.{probe_idx})")
                        out.append(
                            f"{indent}%dbg_ptr.{probe_idx} = bitcast {{ %Expression*, i64 }}* {loaded_ptr} to i8*")
                        out.append(
                            f"{indent}call void @sailfin_runtime_debug_dump_ptr(i8* %dbg_ptr.{probe_idx})")
                        changed += 9
                        probe_idx += 1
                    continue

            out.append(ln)

        return "\n".join(out) + ("\n" if llvm_ir.endswith("\n") else ""), changed

    # parser__expressions: probe the value being stored into Expression.Call payload+8
    # `store { %Expression*, i64 }* %t153, { %Expression*, i64 }** %t157, align 1`
    store_idx = 0
    for ln in lines:
        out.append(ln)
        if "store { %Expression*, i64 }*" in ln and "**" in ln and ", align 1" in ln:
            m = re.match(
                r"^(\s*)store\s+\{\s*%Expression\*,\s*i64\s*\}\*\s+(%[A-Za-z_.$][A-Za-z0-9_.$]*),\s+\{\s*%Expression\*,\s*i64\s*\}\*\*\s+(%[A-Za-z_.$][A-Za-z0-9_.$]*),\s*align\s+1\s*$",
                ln,
            )
            if m:
                indent = m.group(1)
                val_ptr = m.group(2)
                out.append(
                    f"{indent}%dbg_args_ptr_i8.{store_idx} = bitcast {{ %Expression*, i64 }}* {val_ptr} to i8*")
                out.append(
                    f"{indent}call void @sailfin_runtime_debug_dump_ptr(i8* %dbg_args_ptr_i8.{store_idx})")
                out.append(
                    f"{indent}%dbg_args_ptr_i64.{store_idx} = ptrtoint {{ %Expression*, i64 }}* {val_ptr} to i64")
                out.append(
                    f"{indent}call void @sailfin_runtime_debug_dump_u64(i64 %dbg_args_ptr_i64.{store_idx})")
                changed += 4
                store_idx += 1

    return "\n".join(out) + ("\n" if llvm_ir.endswith("\n") else ""), changed


def _normalize_concrete_named_type_defs(
    llvm_ir: str, canonical_defs: dict[str, str]
) -> tuple[str, int]:
    """Normalize concrete named type definitions to a canonical map.

    LLVM will silently rename identified structs when linking modules that
    define the same named type with different bodies. That can produce
    cross-module ABI mismatches and runtime crashes.

    This helper rewrites *concrete* definitions (non-opaque) to match the
    canonical definition, while leaving `type opaque` lines intact so
    `_patch_opaque_named_types` can handle dependency insertion.
    """

    if not canonical_defs:
        return llvm_ir, 0

    type_decl_re = re.compile(
        r"^(?P<prefix>\s*)(?P<name>%[A-Za-z_.$][A-Za-z0-9_.$]*)\s*=\s*type\s+(?P<body>.+?)\s*$"
    )
    lines_in = llvm_ir.splitlines()
    changed = 0
    out_lines: list[str] = []
    for line in lines_in:
        m = type_decl_re.match(line)
        if not m:
            out_lines.append(line)
            continue
        name = m.group("name")
        body = m.group("body").strip()
        if body == "opaque":
            out_lines.append(line)
            continue
        canonical = canonical_defs.get(name)
        if canonical is None:
            out_lines.append(line)
            continue
        expected = canonical
        # Compare on normalized whitespace to avoid churn.
        current_norm = " ".join(f"{name} = type {body}".split())
        expected_norm = " ".join(expected.split())
        if current_norm != expected_norm:
            out_lines.append(m.group("prefix") + expected)
            changed += 1
        else:
            out_lines.append(line)

    new_text = "\n".join(out_lines)
    if llvm_ir.endswith("\n"):
        new_text += "\n"
    return new_text, changed


def _build_canonical_named_type_defs(ll_texts: list[str]) -> tuple[dict[str, str], list[str]]:
    """Compute canonical named type definitions from a set of LLVM modules.

    If multiple concrete bodies exist for the same type name, records a warning
    and does not choose a canonical definition.
    """

    # name -> normalized body -> (original_def_line, count)
    counts: dict[str, dict[str, tuple[str, int]]] = {}

    for text in ll_texts:
        for m in _LLVM_NAMED_TYPE_DEF_RE.finditer(text):
            name = m.group("name")
            body = m.group("body").strip()
            if body == "opaque":
                continue
            definition = f"{name} = type {body}"
            normalized = " ".join(definition.split())
            if name not in counts:
                counts[name] = {}
            prev = counts[name].get(normalized)
            if prev is None:
                counts[name][normalized] = (definition, 1)
            else:
                counts[name][normalized] = (prev[0], prev[1] + 1)

    warnings: list[str] = []
    canonical: dict[str, str] = {}
    for name, variants in counts.items():
        if not variants:
            continue
        ranked = sorted(variants.values(), key=lambda t: t[1], reverse=True)
        chosen_def, chosen_count = ranked[0]
        if len(variants) == 1:
            # Safe: there is exactly one concrete body across modules.
            canonical[name] = chosen_def
            continue

        total = sum(v[1] for v in variants.values())
        warnings.append(
            f"named type {name} has {len(variants)} concrete definitions; "
            f"not normalizing (most common count={chosen_count}/{total})"
        )
    return canonical, warnings


_LLVM_NAMED_TYPE_REF_RE = re.compile(r"%[A-Z][A-Za-z0-9_.$]*")


def _inject_missing_named_type_stubs(llvm_ir: str) -> tuple[str, int]:
    """Ensure every referenced named type is declared in the module.

    Some release seeds have been observed to reference imported struct types
    (e.g. `%ElseBranch`) without emitting either a concrete definition or a
    `type opaque` placeholder.

    Clang rejects such IR with: "use of undefined type named 'ElseBranch'".
    We fix this by inserting `%Name = type opaque` stubs for any referenced
    CamelCase `%Name` that lacks a `= type ...` declaration line.

    The caller should run `_patch_opaque_named_types` afterwards so any stubs
    can be replaced with concrete definitions when known.
    """

    lines = llvm_ir.splitlines()
    type_decl_re = re.compile(
        r"^\s*(?P<name>%[A-Za-z_.$][A-Za-z0-9_.$]*)\s*=\s*type\s+(?P<body>.+)\s*$"
    )

    declared: set[str] = set()
    for line in lines:
        m = type_decl_re.match(line)
        if m:
            declared.add(m.group("name"))

    referenced = set(_LLVM_NAMED_TYPE_REF_RE.findall(llvm_ir))
    missing = sorted(name for name in referenced if name not in declared)
    if not missing:
        return llvm_ir, 0

    # Insert stubs before the first non-type top-level entity.
    insert_at = None
    for i, line in enumerate(lines):
        s = line.strip()
        if not s:
            continue
        if s.startswith("source_filename") or s.startswith(";"):
            continue
        if s.startswith("%"):
            continue
        insert_at = i
        break
    if insert_at is None:
        insert_at = len(lines)

    stub_lines = [f"{name} = type opaque" for name in missing]
    new_lines = lines[:insert_at] + stub_lines + [""] + lines[insert_at:]
    new_text = "\n".join(new_lines)
    if llvm_ir.endswith("\n"):
        new_text += "\n"
    return new_text, len(stub_lines)


def _resolve_sailfin_module_path(*, source_path: pathlib.Path, module_ref: str) -> pathlib.Path | None:
    """Resolve a Sailfin `import ... from "..."` module reference to a .sfn file.

    Only handles local relative imports (./, ../). External imports (e.g.
    "sailfin/runtime") return None.
    """

    ref = module_ref.strip()
    if not ref:
        return None
    if not (ref.startswith("./") or ref.startswith("../")):
        return None

    base = source_path.parent
    raw = (base / ref)

    candidates: list[pathlib.Path] = []
    if raw.suffix:
        candidates.append(raw)
    else:
        candidates.append(raw.with_suffix(".sfn"))
        candidates.append(raw / "mod.sfn")

    for cand in candidates:
        try:
            resolved = cand.resolve()
        except OSError:
            continue
        if resolved.exists():
            return resolved
    return None


def _sailfin_local_dependencies(source_path: pathlib.Path, sources_set: set[pathlib.Path]) -> set[pathlib.Path]:
    """Return local dependency paths (absolute/resolved) that exist in sources_set."""

    try:
        text = source_path.read_text(encoding="utf-8", errors="replace")
    except OSError:
        return set()

    deps: set[pathlib.Path] = set()
    for m in _IMPORT_FROM_RE.finditer(text):
        dep = _resolve_sailfin_module_path(
            source_path=source_path, module_ref=m.group("path"))
        if dep is not None and dep in sources_set:
            deps.add(dep)

    for m in _IMPORT_BARE_RE.finditer(text):
        dep = _resolve_sailfin_module_path(
            source_path=source_path, module_ref=m.group("path"))
        if dep is not None and dep in sources_set:
            deps.add(dep)

    return deps


def _sailfin_local_imported_symbols(
    source_path: pathlib.Path, sources_set: set[pathlib.Path]
) -> list[tuple[pathlib.Path, set[str]]]:
    """Return [(dep_path, {symbol,...})] for `import { ... } from "...";` forms.

    Only includes local relative imports that resolve into sources_set.
    """

    try:
        text = source_path.read_text(encoding="utf-8", errors="replace")
    except OSError:
        return []

    out: list[tuple[pathlib.Path, set[str]]] = []
    for m in _IMPORT_SYMBOLS_RE.finditer(text):
        dep = _resolve_sailfin_module_path(
            source_path=source_path, module_ref=m.group("path")
        )
        if dep is None or dep not in sources_set:
            continue
        names_raw = m.group("names")
        names: set[str] = set()
        for part in names_raw.split(","):
            token = part.strip()
            if not token:
                continue
            # Handle `foo as bar`-style aliases by keeping the original name.
            token = token.split(" as ", 1)[0].strip()
            # Drop any trailing comments or punctuation.
            token = token.split("//", 1)[0].strip()
            token = token.strip()
            if token:
                names.add(token)
        if names:
            out.append((dep, names))
    return out


def _toplevel_fn_names(source_path: pathlib.Path) -> set[str]:
    try:
        text = source_path.read_text(encoding="utf-8", errors="replace")
    except OSError:
        return set()
    return set(m.group("name") for m in _TOPLEVEL_FN_RE.finditer(text))


def _deterministic_link_flags() -> list[str]:
    if sys.platform == "darwin":
        return ["-Wl,-no_uuid"]
    if sys.platform.startswith("linux"):
        return ["-Wl,--build-id=none"]
    return []


def _platform_link_libs() -> list[str]:
    # Match Makefile defaults.
    if sys.platform.startswith("linux"):
        return ["-lm", "-pthread"]
    return []


def _run(
    cmd: list[str],
    *,
    cwd: pathlib.Path,
    stdout_path: pathlib.Path | None = None,
    timeout: float | None = None,
) -> None:
    if stdout_path is None:
        subprocess.run(cmd, cwd=str(cwd), check=True, timeout=timeout)
        return

    stdout_path.parent.mkdir(parents=True, exist_ok=True)
    with stdout_path.open("wb") as f:
        subprocess.run(cmd, cwd=str(cwd), check=True,
                       stdout=f, timeout=timeout)


def _remaining_budget_seconds(*, total_start: float, max_total_seconds: float) -> float | None:
    if max_total_seconds <= 0:
        return None
    elapsed = time.perf_counter() - total_start
    remaining = float(max_total_seconds) - elapsed
    if remaining <= 0:
        return 0.0
    return remaining


def _seed_supports_emit_llvm_file(seed: pathlib.Path) -> bool:
    proc = subprocess.run(
        [str(seed), "emit-llvm-file"],
        cwd=str(REPO_ROOT),
        stdout=subprocess.DEVNULL,
        stderr=subprocess.PIPE,
        timeout=10,
    )
    stderr = proc.stderr.decode("utf-8", errors="replace")
    # When the command exists, stage2 prints usage for missing args.
    if "emit-llvm-file" in stderr or "usage" in stderr:
        return True
    # If the command does not exist, stage2 reports an unknown command.
    if "unknown" in stderr and "emit-llvm-file" in stderr:
        return False
    return proc.returncode != 0


def _seed_supports_aot_prepare_dir(seed: pathlib.Path) -> bool:
    proc = subprocess.run(
        [str(seed), "aot-prepare-dir"],
        cwd=str(REPO_ROOT),
        stdout=subprocess.DEVNULL,
        stderr=subprocess.PIPE,
        timeout=10,
    )
    stderr = proc.stderr.decode("utf-8", errors="replace")
    # Some seeds respond to unknown subcommands with the generic CLI usage.
    # That output can occasionally include the subcommand text, so explicitly
    # treat the base usage as "not supported".
    if stderr.startswith("usage: sailfin-stage2 [--emit sailfin|llvm]"):
        return False
    # Only treat as supported if the command name appears in output.
    # Some seeds print a generic usage string even for unknown subcommands.
    if "aot-prepare-dir" in stderr:
        return True
    # If the command does not exist, stage2 reports an unknown command.
    if "unknown" in stderr and "aot-prepare-dir" in stderr:
        return False
    return False


def _strip_stage2_log_prefixes(text: str) -> str:
    """Remove leading stage2 log prefixes like '[info] ' from LLVM text.

    Some stage2 builds annotate LLVM output lines with a log-level prefix. This
    helper strips that prefix so clang can parse the IR.
    """

    out_lines: list[str] = []
    for line in text.splitlines():
        # Handle common prefixes: "[info] ", "[debug]", "[warn] ...", etc.
        if line.startswith("["):
            end = line.find("]")
            if end != -1:
                rest = line[end + 1:]
                if rest.startswith(" "):
                    rest = rest[1:]
                out_lines.append(rest)
                continue
        out_lines.append(line)
    return "\n".join(out_lines) + "\n"


def _split_top_level_commas(text: str) -> list[str]:
    parts: list[str] = []
    depth_brace = 0
    depth_bracket = 0
    depth_paren = 0
    depth_angle = 0
    start = 0
    for i, ch in enumerate(text):
        if ch == "{":
            depth_brace += 1
        elif ch == "}":
            depth_brace = max(0, depth_brace - 1)
        elif ch == "[":
            depth_bracket += 1
        elif ch == "]":
            depth_bracket = max(0, depth_bracket - 1)
        elif ch == "(":
            depth_paren += 1
        elif ch == ")":
            depth_paren = max(0, depth_paren - 1)
        elif ch == "<":
            depth_angle += 1
        elif ch == ">":
            depth_angle = max(0, depth_angle - 1)
        elif (
            ch == ","
            and depth_brace == 0
            and depth_bracket == 0
            and depth_paren == 0
            and depth_angle == 0
        ):
            parts.append(text[start:i].strip())
            start = i + 1
    tail = text[start:].strip()
    parts.append(tail)
    return parts


def _extract_type_group_from_end(text: str) -> str:
    """Extract trailing LLVM type group from a token string.

    Example:
      "double" -> "double"
      "noundef { i8**, i64 }*" -> "{ i8**, i64 }*"
    """
    s = text.strip()
    if not s:
        return ""

    depth_brace = 0
    depth_bracket = 0
    depth_paren = 0
    depth_angle = 0

    i = len(s) - 1
    while i >= 0 and s[i].isspace():
        i -= 1
    end = i

    while i >= 0:
        ch = s[i]
        if ch == "}":
            depth_brace += 1
        elif ch == "{":
            depth_brace = max(0, depth_brace - 1)
        elif ch == "]":
            depth_bracket += 1
        elif ch == "[":
            depth_bracket = max(0, depth_bracket - 1)
        elif ch == ")":
            depth_paren += 1
        elif ch == "(":
            depth_paren = max(0, depth_paren - 1)
        elif ch == ">":
            depth_angle += 1
        elif ch == "<":
            depth_angle = max(0, depth_angle - 1)

        if (
            ch.isspace()
            and depth_brace == 0
            and depth_bracket == 0
            and depth_paren == 0
            and depth_angle == 0
        ):
            break
        i -= 1

    return s[i + 1: end + 1].strip()


def _split_llvm_arg_type(arg: str) -> str:
    """Given a call arg like "i8* %x" return its type string."""
    a = arg.strip()
    if not a:
        return ""
    if a == "...":
        return "..."

    depth_brace = 0
    depth_bracket = 0
    depth_paren = 0
    depth_angle = 0
    i = len(a) - 1
    while i >= 0:
        ch = a[i]
        if ch == "}":
            depth_brace += 1
        elif ch == "{":
            depth_brace = max(0, depth_brace - 1)
        elif ch == "]":
            depth_bracket += 1
        elif ch == "[":
            depth_bracket = max(0, depth_bracket - 1)
        elif ch == ")":
            depth_paren += 1
        elif ch == "(":
            depth_paren = max(0, depth_paren - 1)
        elif ch == ">":
            depth_angle += 1
        elif ch == "<":
            depth_angle = max(0, depth_angle - 1)

        if (
            ch.isspace()
            and depth_brace == 0
            and depth_bracket == 0
            and depth_paren == 0
            and depth_angle == 0
        ):
            return a[:i].strip()
        i -= 1
    return a


def _inject_missing_function_declarations(llvm_text: str) -> tuple[str, int]:
    """Insert `declare` lines for called-but-undeclared functions.

    Older release seeds have been observed to emit call sites without a
    corresponding `declare`, which makes clang reject the module with e.g.
    "use of undefined value '@foo'".

    Returns (new_text, inserted_count).
    """
    lines = llvm_text.splitlines()

    defined_or_declared: set[str] = set()
    for line in lines:
        s = line.lstrip()
        if not (s.startswith("define ") or s.startswith("declare ")):
            continue
        at = s.find("@")
        if at == -1:
            continue
        lpar = s.find("(", at)
        if lpar == -1:
            continue
        name = s[at + 1: lpar].strip()
        if name:
            defined_or_declared.add(name)

    inferred: dict[str, tuple[str, list[str]]] = {}
    for line in lines:
        if "call" not in line or "@" not in line:
            continue
        call_idx = line.find("call")
        if call_idx == -1:
            continue
        at = line.find("@", call_idx)
        if at == -1:
            continue
        lpar = line.find("(", at)
        if lpar == -1:
            continue
        rpar = line.rfind(")")
        if rpar == -1 or rpar < lpar:
            continue

        name = line[at + 1: lpar].strip()
        if not name or name in defined_or_declared or name in inferred:
            continue
        if name.startswith("llvm."):
            continue

        ret_chunk = line[call_idx + len("call"): at].strip()
        ret_type = _extract_type_group_from_end(ret_chunk)
        if not ret_type:
            continue

        args_chunk = line[lpar + 1: rpar].strip()
        arg_types: list[str] = []
        if args_chunk:
            for part in _split_top_level_commas(args_chunk):
                ty = _split_llvm_arg_type(part)
                if ty:
                    arg_types.append(ty)

        inferred[name] = (ret_type, arg_types)

    missing = [(n, sig[0], sig[1])
               for n, sig in inferred.items() if n not in defined_or_declared]
    if not missing:
        return llvm_text, 0

    decl_lines = [
        f"declare {ret} @{name}({', '.join(args)})" for name, ret, args in sorted(missing)
    ]

    insert_at = None
    for i, line in enumerate(lines):
        if line.lstrip().startswith("define "):
            insert_at = i
            break
    if insert_at is None:
        insert_at = len(lines)

    new_lines = lines[:insert_at] + decl_lines + [""] + lines[insert_at:]
    new_text = "\n".join(new_lines)
    if llvm_text.endswith("\n"):
        new_text += "\n"
    return new_text, len(decl_lines)


# Clang diagnostic formats vary slightly across versions and truncation.
# Accept both:
#   use of undefined value '@foo'
#   use of undefined value '@foo
# (i.e. optional trailing quote)
_UNDEFINED_VALUE_RE = re.compile(r"use of undefined value '@(?P<name>[^']+)'?")


def _inject_declare_for_symbol(llvm_text: str, symbol: str) -> tuple[str, bool]:
    """Inject a single `declare` for `symbol`, inferred from a call site."""
    if not symbol:
        return llvm_text, False

    lines = llvm_text.splitlines()

    # If it's already declared/defined, nothing to do.
    for line in lines:
        s = line.lstrip()
        if not (s.startswith("define ") or s.startswith("declare ")):
            continue
        at = s.find("@")
        if at == -1:
            continue
        lpar = s.find("(", at)
        if lpar == -1:
            continue
        name = s[at + 1: lpar].strip()
        if name == symbol:
            return llvm_text, False

    call_line = None
    needle = f"@{symbol}("
    for line in lines:
        if "call" in line and needle in line:
            call_line = line
            break
    if call_line is None:
        return llvm_text, False

    call_idx = call_line.find("call")
    at = call_line.find("@", call_idx)
    lpar = call_line.find("(", at)
    rpar = call_line.rfind(")")
    if call_idx == -1 or at == -1 or lpar == -1 or rpar == -1 or rpar < lpar:
        return llvm_text, False

    ret_chunk = call_line[call_idx + len("call"): at].strip()
    ret_type = _extract_type_group_from_end(ret_chunk)
    if not ret_type:
        return llvm_text, False

    args_chunk = call_line[lpar + 1: rpar].strip()
    arg_types: list[str] = []
    if args_chunk:
        for part in _split_top_level_commas(args_chunk):
            ty = _split_llvm_arg_type(part)
            if ty:
                arg_types.append(ty)

    decl = f"declare {ret_type} @{symbol}({', '.join(arg_types)})"

    insert_at = None
    for i, line in enumerate(lines):
        if line.lstrip().startswith("define "):
            insert_at = i
            break
    if insert_at is None:
        insert_at = len(lines)

    new_lines = lines[:insert_at] + [decl, ""] + lines[insert_at:]
    new_text = "\n".join(new_lines)
    if llvm_text.endswith("\n"):
        new_text += "\n"
    return new_text, True


_TIMING_LINE_RE = re.compile(
    r"\[timing\]\s+module=(?P<module>\S+)\s+phase=(?P<phase>\S+)\s+ms=(?P<ms>-?\d+)"
)


def _extract_timing_lines(stderr_text: str) -> list[tuple[str, str, int]]:
    """Extract timing triples (module, phase, ms) from stage2 stderr output."""

    out: list[tuple[str, str, int]] = []
    for raw_line in stderr_text.splitlines():
        line = raw_line.strip()
        # Handle runtime prefixes like: "[warn] [timing] ..."
        if "[timing]" not in line:
            continue
        m = _TIMING_LINE_RE.search(line)
        if not m:
            continue
        try:
            ms = int(m.group("ms"))
        except ValueError:
            continue
        out.append((m.group("module"), m.group("phase"), ms))
    return out


def _looks_like_llvm_module(text: str) -> bool:
    # Stage2 `emit llvm` output should begin with top-level LLVM entities.
    # We've seen rare cases where the seed compiler emits a truncated suffix
    # that starts with indented instructions (e.g. "  store ..."), which clang
    # rejects as "expected top-level entity".
    for line in text.splitlines()[:100]:
        if not line.strip():
            continue
        if line[:1].isspace():
            return False
        return line.startswith((
            "source_filename =",
            "; ModuleID =",
            "target ",
            "declare ",
            "define ",
            "%",
            "@",
            ";",
            "!",
            "attributes ",
        ))
    return False


def _trim_to_llvm_module_start(text: str) -> str:
    """Drop any leading non-LLVM lines before the module header.

    Some seed compilers print log output before emitting the LLVM module.
    This makes the output invalid for clang, but the LLVM payload is still
    present later in the stream.
    """

    def _is_plausible_llvm_toplevel(line: str) -> bool:
        if not line:
            return False
        if line[:1].isspace():
            return False
        # Most stable anchors across LLVM versions.
        if line.startswith("source_filename ="):
            return True
        if line.startswith("; ModuleID ="):
            return True
        # Some modules may omit the above and start directly with other
        # top-level entities.
        return line.startswith(
            (
                "target ",
                "declare ",
                "define ",
                "%",
                "@",
                ";",
                "!",
                "attributes ",
            )
        )

    lines = text.splitlines(keepends=True)
    for i, raw_line in enumerate(lines[:400]):
        line = raw_line.rstrip("\n")
        if not line.strip():
            continue
        if _is_plausible_llvm_toplevel(line):
            return "".join(lines[i:])
    return text


def _collect_stage2_sources(repo_root: pathlib.Path) -> list[pathlib.Path]:
    compiler_src = repo_root / "compiler" / "src"
    runtime_src = repo_root / "runtime"

    if not compiler_src.exists():
        raise SystemExit(f"missing compiler sources: {compiler_src}")
    if not runtime_src.exists():
        raise SystemExit(f"missing runtime sources: {runtime_src}")

    # Match `scripts/bootstrap_stage2.py`: include all compiler sources.
    sources = [p for p in sorted(compiler_src.rglob("*.sfn"))]
    runtime_sources = sorted(runtime_src.rglob("*.sfn"))
    all_sources = sources + runtime_sources
    if not all_sources:
        raise SystemExit("no Sailfin sources found to compile")
    return all_sources


def _module_name_from_source_path(source_path: pathlib.Path) -> str:
    """Return a collision-free module name for AOT preparation and file layout."""

    compiler_src = REPO_ROOT / "compiler" / "src"
    runtime_src = REPO_ROOT / "runtime"

    try:
        relative = source_path.relative_to(compiler_src)
        return str(relative.with_suffix("")).replace("\\", "/").replace("/", "__")
    except ValueError:
        pass

    try:
        relative = source_path.relative_to(runtime_src)
        return "runtime__" + str(relative.with_suffix("")).replace("\\", "/").replace("/", "__")
    except ValueError:
        pass

    # Support generated compatibility sources that live outside REPO_ROOT but
    # still use a compiler/src-like path layout so module naming stays stable.
    normalized = str(source_path).replace("\\", "/")
    marker = "/compiler/src/"
    idx = normalized.find(marker)
    if idx != -1:
        tail = normalized[idx + len(marker):]
        if tail.endswith(".sfn"):
            tail = tail[:-4]
        return tail.replace("/", "__")
    marker = "/runtime/"
    idx = normalized.find(marker)
    if idx != -1:
        tail = normalized[idx + len(marker):]
        if tail.endswith(".sfn"):
            tail = tail[:-4]
        return "runtime__" + tail.replace("/", "__")

    return source_path.stem


def _slug_from_source_path(source_path: pathlib.Path) -> str:
    """Return the build/stage2 slug used by stage2 import resolution.

    This matches the logic in compiler/src/llvm/imports.sfn, which expects
    imported-module artifacts under build/stage2/<slug>.*.
    """

    compiler_src = REPO_ROOT / "compiler" / "src"
    runtime_src = REPO_ROOT / "runtime"

    try:
        relative = source_path.relative_to(compiler_src)
        return str(relative.with_suffix("")).replace("\\", "/")
    except ValueError:
        pass

    try:
        relative = source_path.relative_to(runtime_src)
        return "runtime/" + str(relative.with_suffix("")).replace("\\", "/")
    except ValueError:
        pass

    # Support generated shim sources that live outside REPO_ROOT but still use
    # a compiler/src-like path layout so module_name_from_path/import slugs stay
    # stable.
    normalized = str(source_path).replace("\\", "/")
    marker = "/compiler/src/"
    idx = normalized.find(marker)
    if idx != -1:
        tail = normalized[idx + len(marker):]
        if tail.endswith(".sfn"):
            tail = tail[:-4]
        return tail
    marker = "/runtime/"
    idx = normalized.find(marker)
    if idx != -1:
        tail = normalized[idx + len(marker):]
        if tail.endswith(".sfn"):
            tail = tail[:-4]
        return "runtime/" + tail

    return source_path.stem


def _generate_mod_shim(*, mod_path: pathlib.Path, shim_path: pathlib.Path) -> None:
    """Create a compatibility shim for a directory entrypoint module.

    Older seeds may treat directory imports as module slugs without the implicit
    `/mod` resolution. We generate a sibling `<dir>.sfn` that mirrors the
    directory's `mod.sfn`, adjusting relative import paths accordingly.
    """

    text = mod_path.read_text(encoding="utf-8")
    dir_segment = mod_path.parent.name

    # Move from <dir>/mod.sfn -> <dir>.sfn (one directory up):
    # - "./foo" becomes "./<dir>/foo"
    # - "../bar" becomes "./bar"
    text = text.replace('from "./', f'from "./{dir_segment}/')
    text = text.replace("from \"../", "from \"./")

    shim_path.parent.mkdir(parents=True, exist_ok=True)
    shim_path.write_text(text, encoding="utf-8")


def _seed_emit_native_text(
    *,
    seed_bin: pathlib.Path,
    source_path: pathlib.Path,
    out_path: pathlib.Path,
    cwd: pathlib.Path,
    env: dict[str, str],
    timeout: float | None,
) -> None:
    out_path.parent.mkdir(parents=True, exist_ok=True)
    proc = subprocess.run(
        [str(seed_bin), "emit", "native", str(source_path)],
        cwd=str(cwd),
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        env=env,
        timeout=timeout,
    )
    if proc.returncode != 0:
        stderr_text = proc.stderr.decode("utf-8", errors="replace")
        raise SystemExit(
            f"selfhost: seed emit native failed for {source_path} (rc={proc.returncode})\n{stderr_text}"
        )
    raw = proc.stdout.decode("utf-8", errors="replace")
    # Some seeds prefix stdout with log labels; strip those so the native-text
    # parser can consume the artifact.
    cleaned = _strip_stage2_log_prefixes(raw)
    out_path.write_text(cleaned, encoding="utf-8")


def _prepare_seed_import_context(
    *,
    seed_bin: pathlib.Path,
    fallback_seed_bin: pathlib.Path | None,
    sources: list[pathlib.Path],
    seed_cwd: pathlib.Path,
    jobs: int,
    env: dict[str, str],
    timeout: float | None,
) -> None:
    """Populate seed_cwd/build/stage2 with .sfn-asm + .layout-manifest artifacts.

    Stage2's LLVM lowering reads imported module context from
    build/stage2/<slug>.sfn-asm and build/stage2/<slug>.layout-manifest.

    In clean CI environments, relying on `sfn build` to "warm" this cache is
    brittle because the build can fail before emitting any cache artifacts
    (missing runtime symbols, invalid LLVM, etc). Instead, we generate the
    artifacts directly:

    - Run `sfn emit native <path>` to produce `<slug>.sfn-asm`.
    - Derive `<slug>.layout-manifest` by extracting `.layout ...` lines from the
      emitted native text.
    """

    stage2_cache = seed_cwd / "build" / "stage2"
    stage2_cache.mkdir(parents=True, exist_ok=True)
    tmp_root = stage2_cache / ".tmp"
    tmp_root.mkdir(parents=True, exist_ok=True)

    def _write_seed_stamp() -> None:
        stamp_path = stage2_cache / ".seed_stamp"
        try:
            seed_stat = seed_bin.stat()
        except OSError:
            seed_stat = None
        try:
            fallback_stat = fallback_seed_bin.stat() if fallback_seed_bin is not None else None
        except OSError:
            fallback_stat = None

        lines: list[str] = [
            "seed_import_context_stamp_v1",
            f"seed_bin={seed_bin}",
            f"seed_mtime={seed_stat.st_mtime if seed_stat is not None else 'unknown'}",
            f"seed_size={seed_stat.st_size if seed_stat is not None else 'unknown'}",
            f"fallback_seed_bin={fallback_seed_bin if fallback_seed_bin is not None else ''}",
            f"fallback_seed_mtime={fallback_stat.st_mtime if fallback_stat is not None else ''}",
            f"fallback_seed_size={fallback_stat.st_size if fallback_stat is not None else ''}",
        ]
        stamp_path.write_text("\n".join(lines) + "\n", encoding="utf-8")

    def _write_layout_manifest_from_native_text(*, native_text: str, out_path: pathlib.Path) -> None:
        out_path.parent.mkdir(parents=True, exist_ok=True)
        header = "; Sailfin Layout Manifest\n.manifest version=1\n\n"
        out_lines: list[str] = [header.rstrip("\n")]
        for line in native_text.splitlines():
            stripped = line.lstrip(" \t")
            if stripped.startswith(".layout "):
                out_lines.append(stripped)
        out_path.write_text("\n".join(out_lines) + "\n", encoding="utf-8")

    def _emit_one(p: pathlib.Path) -> None:
        slug = _slug_from_source_path(p)
        asm_path = stage2_cache / f"{slug}.sfn-asm"
        manifest_path = stage2_cache / f"{slug}.layout-manifest"

        # Best-effort caching.
        try:
            src_mtime = p.stat().st_mtime
            seed_mtime = seed_bin.stat().st_mtime
            fallback_seed_mtime = fallback_seed_bin.stat(
            ).st_mtime if fallback_seed_bin is not None else 0.0
            stamp_mtime = max(src_mtime, seed_mtime, fallback_seed_mtime)
            if asm_path.exists() and manifest_path.exists():
                if asm_path.stat().st_mtime >= stamp_mtime and manifest_path.stat().st_mtime >= stamp_mtime:
                    return
        except OSError:
            pass

        seed_env_local = env.copy()
        tmp_dir = tmp_root / slug.replace("/", "__")
        tmp_dir.mkdir(parents=True, exist_ok=True)
        seed_env_local["TMPDIR"] = str(tmp_dir)
        seed_env_local["TMP"] = str(tmp_dir)
        seed_env_local["TEMP"] = str(tmp_dir)

        def _emit_with(seed: pathlib.Path) -> None:
            _seed_emit_native_text(
                seed_bin=seed,
                source_path=p,
                out_path=asm_path,
                cwd=seed_cwd,
                env=seed_env_local,
                timeout=timeout,
            )
            native_text = asm_path.read_text(
                encoding="utf-8", errors="replace")
            _write_layout_manifest_from_native_text(
                native_text=native_text,
                out_path=manifest_path,
            )

        try:
            _emit_with(seed_bin)
        except SystemExit as exc:
            if fallback_seed_bin is None or fallback_seed_bin == seed_bin:
                raise
            print(
                f"[selfhost][warn] seed emit native failed for {p}; retrying staging with fallback seed {fallback_seed_bin}\n{exc}",
                file=sys.stderr,
                flush=True,
            )
            _emit_with(fallback_seed_bin)

    # Stamp the cache so per-module isolated cwds can detect when they need a refresh.
    _write_seed_stamp()

    if jobs <= 1:
        for idx, p in enumerate(sources):
            if idx % 10 == 0 or idx + 1 == len(sources):
                print(
                    f"[selfhost] staging {idx + 1}/{len(sources)} import artifact(s)...",
                    flush=True,
                )
            _emit_one(p)
        return

    completed = 0
    completed_lock = threading.Lock()

    def _emit_one_with_progress(p: pathlib.Path) -> None:
        nonlocal completed
        _emit_one(p)
        with completed_lock:
            completed += 1
            if completed % 10 == 0 or completed == len(sources):
                print(
                    f"[selfhost] staged {completed}/{len(sources)} import artifact(s)...",
                    flush=True,
                )

    with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as pool:
        futures = [pool.submit(_emit_one_with_progress, p) for p in sources]
        for fut in concurrent.futures.as_completed(futures):
            fut.result()


def main(argv: list[str]) -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--fixed-point",
        action="store_true",
        help="Rebuild twice (seed->out, out->out2) and diff AOT outputs",
    )
    parser.add_argument(
        "--max-total-seconds",
        type=float,
        default=DEFAULT_MAX_TOTAL_SECONDS,
        help=(
            "Fail if the rebuild exceeds this wall time "
            f"(default: {int(DEFAULT_MAX_TOTAL_SECONDS)})"
        ),
    )
    parser.add_argument(
        "--work-dir",
        type=pathlib.Path,
        default=REPO_ROOT / "build" / "selfhost",
        help="Working directory for intermediate artifacts",
    )
    parser.add_argument(
        "--seed",
        type=pathlib.Path,
        default=REPO_ROOT / "build/native/sailfin-stage2",
        help="Path to the seed native sailfin-stage2 binary",
    )
    parser.add_argument(
        "--import-context-seed",
        type=pathlib.Path,
        default=None,
        help=(
            "Optional path to a stage2 binary used only to stage import-context artifacts "
            "(emit native -> build/stage2/*.sfn-asm). Useful when the main seed crashes on 'emit native'."
        ),
    )
    parser.add_argument(
        "--import-context-jobs",
        type=int,
        default=1,
        help=(
            "Parallelism for import-context staging (emit native -> build/stage2/*.sfn-asm). "
            "Default: 1. IMPORTANT: older seeds are not safe to run concurrently in the same cwd, "
            "and parallel staging can trigger crashes or corrupt artifacts."
        ),
    )
    parser.add_argument(
        "--max-attempts",
        type=int,
        default=5,
        help="Max attempts per module when seed output is malformed (default: 5)",
    )
    parser.add_argument(
        "--jobs",
        type=int,
        default=1,
        help=(
            "Number of modules to build in parallel (seed emit + clang compile). "
            "Default: 1 (sequential, most reliable)."
        ),
    )
    parser.add_argument(
        "--attempt-sleep",
        type=float,
        default=0.0,
        help="Seconds to sleep between attempts for a flaky module (default: 0)",
    )
    parser.add_argument(
        "--seed-timeout",
        type=float,
        default=None,
        help="Timeout (seconds) per seed emit attempt (default: 180; 600 when auto-using ASAN seed)",
    )
    parser.add_argument(
        "--clang-validate-timeout",
        type=float,
        default=None,
        help="Timeout (seconds) for per-module clang validation (default: 30)",
    )
    parser.add_argument(
        "--skip-clang-validate",
        action="store_true",
        help=(
            "Skip strict per-module clang validation gating. Note: the selfhost pipeline still "
            "clang-compiles each module to catch invalid IR early and enable retries."
        ),
    )
    parser.add_argument(
        "--use-emit-llvm-file",
        action="store_true",
        help=(
            "Force using the seed compiler's 'emit-llvm-file' command (when available). "
            "This mode generally produces link-safe IR."
        ),
    )

    parser.add_argument(
        "--no-use-emit-llvm-file",
        action="store_true",
        help=(
            "Do not use 'emit-llvm-file' even if the seed supports it. "
            "Use this only when debugging seeds that truncate output."
        ),
    )

    parser.add_argument(
        "--timing",
        action="store_true",
        help=(
            "Ask the seed compiler to emit per-phase timing to stderr (requires a seed that supports it). "
            "The selfhost script will summarize the slowest modules."
        ),
    )
    parser.add_argument(
        "--force-clang-validate",
        action="store_true",
        help="Force per-module clang validation (overrides presets)",
    )

    prefer_seed_group = parser.add_mutually_exclusive_group()
    prefer_seed_group.add_argument(
        "--prefer-asan-seed",
        action="store_true",
        default=False,
        help="Prefer ASAN seed when available (default: off)",
    )
    prefer_seed_group.add_argument(
        "--no-prefer-asan-seed",
        action="store_true",
        default=False,
        help="Do not auto-switch to ASAN seed",
    )
    parser.add_argument(
        "--compiler-entry",
        type=pathlib.Path,
        default=REPO_ROOT / "compiler/src/cli_main.sfn",
        help="Unused for now (kept for compatibility); the script compiles the full module set",
    )
    parser.add_argument(
        "--out",
        type=pathlib.Path,
        default=REPO_ROOT / "build/native/sailfin-stage2-selfhost",
        help="Output path for the rebuilt native compiler binary",
    )
    parser.add_argument(
        "--clang",
        default=os.environ.get("CLANG", "clang"),
        help="Clang executable (default: clang)",
    )
    parser.add_argument(
        "--opt",
        default="-O2",
        help="Optimization flags to pass to clang (default: -O2)",
    )
    parser.add_argument(
        "--wno-override-module",
        action="store_true",
        default=True,
        help="Suppress clang -Woverride-module warnings (default: on)",
    )
    parser.add_argument(
        "--no-deterministic-link",
        action="store_false",
        dest="deterministic_link",
        default=True,
        help="Disable deterministic link flags (default: deterministic)",
    )

    parser.add_argument(
        "--asan",
        action="store_true",
        default=False,
        help=(
            "Build the output compiler with AddressSanitizer instrumentation "
            "(adds -fsanitize=address, -g, -fno-omit-frame-pointer). Useful for debugging runtime corruption."
        ),
    )

    args = parser.parse_args(argv)

    # Resolve the seed path once up front so subprocesses can run it even when
    # we change cwd (e.g. into an isolated seed working directory).
    try:
        args.seed = args.seed.resolve()
    except OSError:
        # Best effort; a later check will fail with a clear message.
        pass

    if args.import_context_seed is not None:
        try:
            args.import_context_seed = args.import_context_seed.resolve()
        except OSError:
            pass

    if args.use_emit_llvm_file and args.no_use_emit_llvm_file:
        raise SystemExit(
            "selfhost: cannot pass both --use-emit-llvm-file and --no-use-emit-llvm-file")

    # Production defaults: validate LLVM output, keep retries bounded.
    if args.force_clang_validate:
        args.skip_clang_validate = False

    # On newer macOS, -Wl,-no_uuid can trip dyld in some environments.
    if sys.platform == "darwin":
        args.deterministic_link = False

    t_total_start = time.perf_counter()

    def _check_budget() -> None:
        if args.max_total_seconds <= 0:
            return
        elapsed = time.perf_counter() - t_total_start
        if elapsed > float(args.max_total_seconds):
            raise SystemExit(
                f"selfhost: exceeded max wall time ({elapsed:.2f}s > {args.max_total_seconds:.2f}s)\n"
                "hint: increase --max-total-seconds (or reduce --jobs / seed-timeout if you suspect a hang)"
            )

    # Prefer a reliable seed when available.
    default_seed = REPO_ROOT / "build/native/sailfin-stage2"
    asan_seed = REPO_ROOT / "build/native/sailfin-stage2-asan"
    prefer_asan_seed = (
        args.prefer_asan_seed and not args.no_prefer_asan_seed and not args.fixed_point
    )
    seed = args.seed
    if prefer_asan_seed and seed.resolve() == default_seed.resolve() and asan_seed.exists():
        print(f"[selfhost] using ASAN seed: {asan_seed}")
        seed = asan_seed

    # Default timeouts: ASAN seeds can be much slower and may spuriously hit the
    # standard per-module timeout, leading to repeated retries.
    if args.seed_timeout is None:
        args.seed_timeout = 600.0 if seed.name.endswith("-asan") else 180.0
    if args.clang_validate_timeout is None:
        args.clang_validate_timeout = 30.0

    clang = args.clang
    clang_flags: list[str] = shlex.split(args.opt)
    if args.wno_override_module:
        clang_flags.append("-Wno-override-module")

    if args.asan:
        # Prefer diagnostic builds when chasing selfhost corruption.
        clang_flags.extend(
            [
                "-g",
                "-fno-omit-frame-pointer",
                "-fno-delete-null-pointer-checks",
                "-fsanitize=address",
            ]
        )

    if not seed.exists():
        raise SystemExit(f"missing seed compiler: {seed}")
    if not os.access(seed, os.X_OK):
        raise SystemExit(f"seed compiler is not executable: {seed}")

    def _seed_version(seed_bin: pathlib.Path) -> str:
        for cmd in ([str(seed_bin), "version"], [str(seed_bin), "--version"]):
            try:
                proc = subprocess.run(
                    cmd,
                    cwd=str(REPO_ROOT),
                    stdout=subprocess.PIPE,
                    stderr=subprocess.PIPE,
                    timeout=10,
                )
            except (OSError, subprocess.TimeoutExpired):
                continue
            out = proc.stdout.decode("utf-8", errors="replace").strip()
            if proc.returncode == 0 and out:
                return out.splitlines()[0]
        return "(unknown version)"

    print(f"[selfhost] seed: {seed} ({_seed_version(seed)})", flush=True)

    seed_supports_emit_llvm_file = _seed_supports_emit_llvm_file(seed)
    # Default behaviour: prefer emit-llvm-file when the seed supports it.
    # Rationale: many seeds' streaming `emit llvm` output is not link-safe
    # (missing import symbol rewrite), especially on macOS.
    prefer_emit_llvm_file = seed_supports_emit_llvm_file and not args.no_use_emit_llvm_file
    if args.use_emit_llvm_file:
        prefer_emit_llvm_file = seed_supports_emit_llvm_file

    def _hash_file(path: pathlib.Path) -> str:
        h = hashlib.sha256()
        with path.open("rb") as f:
            while True:
                chunk = f.read(1024 * 1024)
                if not chunk:
                    break
                h.update(chunk)
        return h.hexdigest()

    def _build_once(*, seed_bin: pathlib.Path, out_path: pathlib.Path, pass_name: str) -> tuple[pathlib.Path, list[str]]:
        seed_emit_s = 0.0
        clang_validate_s = 0.0
        clang_compile_s = 0.0
        clang_link_s = 0.0
        seed_attempts_total = 0
        seed_timeouts = 0
        seed_failures = 0
        modules_retried = 0
        clang_validations = 0
        clang_validation_failures = 0

        # Timing aggregation keyed by module_name.
        timing_by_module: dict[str, dict[str, int]] = {}

        def _timing_module_matches(*, timing_module: str, module_name: str) -> bool:
            if timing_module == module_name:
                return True
            # Stage2 timing uses logical module paths like "llvm/foo/bar".
            # Selfhost uses a collision-free filesystem layout with "__".
            if timing_module.replace("/", "__").replace("\\", "__") == module_name:
                return True
            return False

        def _print_timing_summary(*, header: str, module_list: list[str]) -> None:
            print(f"[selfhost] ({pass_name}) {header}:", flush=True)
            print(
                "[selfhost] "
                f"timing_enabled={bool(args.timing)} timed_modules={len(timing_by_module)}",
                flush=True,
            )
            print(
                "[selfhost] "
                f"attempts={seed_attempts_total} retried_modules={modules_retried} "
                f"timeouts={seed_timeouts} seed_failures={seed_failures} "
                f"clang_validations={clang_validations} clang_validation_failures={clang_validation_failures}",
                flush=True,
            )
            print(f"[selfhost] seed emit: {seed_emit_s:.2f}s", flush=True)
            print(
                f"[selfhost] clang module compile: {clang_validate_s:.2f}s", flush=True
            )
            print(
                f"[selfhost] clang compile: {clang_compile_s:.2f}s", flush=True)
            print(f"[selfhost] clang link: {clang_link_s:.2f}s", flush=True)

            if args.timing and timing_by_module and module_list:
                def _phase_ms(name: str, phase: str) -> int:
                    return int(timing_by_module.get(name, {}).get(phase, 0))

                ranked = sorted(
                    module_list,
                    key=lambda n: _phase_ms(n, "lower_llvm"),
                    reverse=True,
                )

                print(
                    f"[selfhost] ({pass_name}) slowest modules by lower_llvm (ms):", flush=True)
                for name in ranked[:20]:
                    phases = timing_by_module.get(name, {})
                    parse_ms = phases.get("parse", 0)
                    type_ms = phases.get("typecheck", 0)
                    emit_ms = phases.get("emit_native", 0)
                    lower_ms = phases.get("lower_llvm", 0)
                    total_ms = phases.get("total", 0)
                    print(
                        "[selfhost] "
                        f"{name} parse={parse_ms} typecheck={type_ms} emit_native={emit_ms} lower_llvm={lower_ms} total={total_ms}",
                        flush=True,
                    )

        work_dir = args.work_dir.resolve()
        stage2_dir = work_dir / pass_name
        raw_dir = stage2_dir / "raw"
        obj_dir = stage2_dir / "obj"
        seed_cwd = stage2_dir / "seed_cwd"

        raw_dir.mkdir(parents=True, exist_ok=True)
        obj_dir.mkdir(parents=True, exist_ok=True)
        (seed_cwd / "build" / "stage2").mkdir(parents=True, exist_ok=True)

        for p in obj_dir.rglob("*.o"):
            p.unlink()

        sources = _collect_stage2_sources(REPO_ROOT)
        module_names: list[str] = []

        # Shared cache of concrete named LLVM type definitions discovered while
        # compiling modules. Used to replace `%Foo = type opaque` in other
        # modules when a concrete definition is known.
        known_named_type_defs: dict[str, str] = {}
        known_named_type_defs_lock = threading.Lock()

        use_emit_llvm_file = prefer_emit_llvm_file and seed_supports_emit_llvm_file
        seed_env = os.environ.copy()
        seed_env["SAILFIN_DISABLE_STRING_FREE"] = "1"

        fallback_import_seed: pathlib.Path | None = None
        if args.import_context_seed is not None:
            fallback_import_seed = args.import_context_seed
        else:
            # Convenience fallback for local debugging: allow a stage1-built
            # debug compiler to stage import-context artifacts when the release
            # seed crashes on `emit native`.
            candidate = REPO_ROOT / "build/native/sailfin-stage2-debug"
            if candidate.exists() and os.access(candidate, os.X_OK):
                fallback_import_seed = candidate

        seed_timeout = None
        if args.seed_timeout and args.seed_timeout > 0:
            seed_timeout = float(args.seed_timeout)
        clang_validate_timeout = None
        if args.clang_validate_timeout and args.clang_validate_timeout > 0:
            clang_validate_timeout = float(args.clang_validate_timeout)

        # Compatibility: older seeds may not resolve directory imports ("./parser")
        # to "./parser/mod". Previously we generated shim modules like
        # compat_src/compiler/src/parser.sfn, but some older seeds crash while
        # compiling those shims. Instead, build a full compatibility copy of
        # compiler sources that rewrites directory imports to explicit /mod.
        compat_compiler_src = seed_cwd / "compat_src" / "compiler" / "src"
        if compat_compiler_src.exists():
            shutil.rmtree(compat_compiler_src)
        compat_compiler_src.parent.mkdir(parents=True, exist_ok=True)
        shutil.copytree(REPO_ROOT / "compiler" / "src", compat_compiler_src)

        # Rewrite the handful of known directory imports used by stage2.
        # Keep this surgical to avoid churn and to preserve determinism.
        rewrites = {
            'from "./parser";': 'from "./parser/mod";',
            'from "./llvm/expression_lowering_stage2";': 'from "./llvm/expression_lowering_stage2/mod";',
        }
        for p in compat_compiler_src.rglob("*.sfn"):
            try:
                text = p.read_text(encoding="utf-8")
            except UnicodeDecodeError:
                text = p.read_text(encoding="utf-8", errors="replace")
            new_text = text
            for old, new in rewrites.items():
                new_text = new_text.replace(old, new)
            if new_text != text:
                p.write_text(new_text, encoding="utf-8")

        # Compile using the compat tree for compiler sources but keep runtime
        # sources from the repo.
        sources = sorted(compat_compiler_src.rglob("*.sfn")) + sorted(
            (REPO_ROOT / "runtime").rglob("*.sfn")
        )

        sources_set = set(p.resolve() for p in sources)
        source_by_module: dict[str, pathlib.Path] = {
            _module_name_from_source_path(p): p for p in sources
        }

        # Infer which *function* symbols each module must export based on the
        # rest of the stage2 sources importing them.
        fn_names_by_module: dict[str, set[str]] = {
            mod: _toplevel_fn_names(path) for mod, path in source_by_module.items()
        }
        required_export_fns: dict[str, set[str]] = {}
        for src in sources:
            for dep_path, imported_names in _sailfin_local_imported_symbols(src, sources_set):
                dep_mod = _module_name_from_source_path(dep_path)
                dep_fns = fn_names_by_module.get(dep_mod, set())
                needed = {name for name in imported_names if name in dep_fns}
                if needed:
                    required_export_fns.setdefault(
                        dep_mod, set()).update(needed)

        # Populate an isolated import-context cache for the seed compiler.
        # Without build/stage2/<slug>.sfn-asm files, stage2 lowering falls back
        # to opaque/i8* imported types and can drop cross-module definitions,
        # leading to link failures.
        print(
            f"[selfhost] ({pass_name}) staging import artifacts...", flush=True)
        _prepare_seed_import_context(
            seed_bin=seed_bin,
            fallback_seed_bin=fallback_import_seed if fallback_import_seed != seed_bin else None,
            sources=sources,
            seed_cwd=seed_cwd,
            jobs=max(1, int(args.import_context_jobs)),
            env=seed_env,
            timeout=seed_timeout,
        )

        try:
            def _compile_one_module(
                idx: int,
                source_path: pathlib.Path,
            ) -> tuple[str, dict[str, int], dict[str, float | int]]:
                """Compile one module to final .ll + .o.

                Returns (module_name, timing_phases, stats).
                """
                module_name = _module_name_from_source_path(source_path)
                final_obj_path = obj_dir / f"{module_name}.o"
                final_obj_path.parent.mkdir(parents=True, exist_ok=True)
                try:
                    final_obj_path.unlink()
                except FileNotFoundError:
                    pass

                local_timing: dict[str, int] = {}
                stats: dict[str, float | int] = {
                    "seed_emit_s": 0.0,
                    "clang_validate_s": 0.0,
                    "seed_attempts_total": 0,
                    "seed_timeouts": 0,
                    "seed_failures": 0,
                    "clang_validations": 0,
                    "clang_validation_failures": 0,
                    "modules_retried": 0,
                }
                max_attempts = max(1, int(args.max_attempts))
                cleaned = ""
                last_stderr = ""
                last_rc: int | None = None
                last_clang_stderr = ""
                last_clang_rc: int | None = None
                used_attempts = 0
                use_emit_llvm_file_local = bool(use_emit_llvm_file)

                def _cap_timeout(base: float | None) -> float | None:
                    if args.max_total_seconds <= 0:
                        return base
                    remaining = _remaining_budget_seconds(
                        total_start=t_total_start,
                        max_total_seconds=float(args.max_total_seconds),
                    )
                    if remaining is None:
                        return base
                    # Avoid passing extremely small timeouts to subprocesses.
                    # When the wall-time budget is nearly exhausted, a
                    # sub-second timeout tends to produce confusing
                    # `subprocess.TimeoutExpired` errors; fail fast instead.
                    if remaining < 1.0:
                        elapsed = float(args.max_total_seconds) - remaining
                        raise SystemExit(
                            f"selfhost: exceeded max wall time ({elapsed:.2f}s > {args.max_total_seconds:.2f}s)\n"
                            f"(remaining budget {remaining:.2f}s is too small to run the next step)"
                        )
                    if base is None:
                        return remaining
                    return min(base, remaining)

                for attempt in range(1, max_attempts + 1):
                    used_attempts = attempt
                    stats["seed_attempts_total"] = int(
                        stats["seed_attempts_total"]) + 1

                    _check_budget()

                    seed_env_local = seed_env.copy()
                    attempt_tmp = raw_dir / "tmp" / \
                        module_name / f"attempt{attempt}"
                    attempt_tmp.mkdir(parents=True, exist_ok=True)

                    # IMPORTANT: Many stage2 seeds write intermediate artifacts
                    # under the current working directory (e.g. build/sailfin/*)
                    # using fixed file names. When running in parallel, sharing
                    # a single cwd can corrupt or truncate emitted LLVM.
                    #
                    # To make parallel builds reliable, run each seed emit in a
                    # per-attempt isolated cwd that still has access to the
                    # shared build/stage2 import-context cache.
                    seed_emit_cwd = attempt_tmp / "seed_cwd"
                    (seed_emit_cwd / "build").mkdir(parents=True, exist_ok=True)
                    shared_stage2_cache = seed_cwd / "build" / "stage2"
                    local_stage2_cache = seed_emit_cwd / "build" / "stage2"

                    def _needs_stage2_cache_refresh() -> bool:
                        shared_stamp = shared_stage2_cache / ".seed_stamp"
                        local_stamp = local_stage2_cache / ".seed_stamp"
                        try:
                            if not local_stage2_cache.exists():
                                return True
                            if not shared_stamp.exists() or not local_stamp.exists():
                                return True
                            return shared_stamp.read_text(encoding="utf-8", errors="replace") != local_stamp.read_text(
                                encoding="utf-8", errors="replace"
                            )
                        except OSError:
                            return True

                    if _needs_stage2_cache_refresh():
                        # Copy rather than symlink: stage2 seeds may update
                        # build artifacts during emit, and sharing build/stage2
                        # across concurrent seed processes can produce
                        # inconsistent IR and runtime ABI mismatches.
                        if local_stage2_cache.exists():
                            shutil.rmtree(local_stage2_cache)
                        shutil.copytree(shared_stage2_cache,
                                        local_stage2_cache)

                    # IMPORTANT: Some seeds will opportunistically load
                    # build/stage2/<module>.sfn-asm when it exists, even when
                    # compiling that same module from source. This can cause
                    # the seed to treat local functions as imported externs,
                    # producing LLVM with missing definitions (link-time
                    # undefined symbols).
                    cached_self_artifact = local_stage2_cache / \
                        f"{module_name}.sfn-asm"
                    if cached_self_artifact.exists():
                        cached_self_artifact.unlink()
                    cached_self_manifest = local_stage2_cache / \
                        f"{module_name}.layout-manifest"
                    if cached_self_manifest.exists():
                        cached_self_manifest.unlink()
                    # Some stage2 seeds appear to use fixed temp file names.
                    # When running modules in parallel, isolate TMPDIR to avoid
                    # cross-process temp collisions that can corrupt LLVM output.
                    seed_env_local["TMPDIR"] = str(attempt_tmp)
                    seed_env_local["TMP"] = str(attempt_tmp)
                    seed_env_local["TEMP"] = str(attempt_tmp)

                    attempt_seed_timeout = seed_timeout
                    if seed_timeout is not None:
                        cap = max(seed_timeout, 1200.0)
                        attempt_seed_timeout = min(
                            seed_timeout * (2 ** (attempt - 1)), cap)

                    print(
                        f"[selfhost] ({pass_name}) module {idx + 1}/{len(sources)} {module_name} attempt {attempt}/{max_attempts}",
                        flush=True,
                    )

                    attempt_path = raw_dir / \
                        f"{module_name}.attempt{attempt}.ll"
                    cleaned_attempt_path = raw_dir / \
                        f"{module_name}.attempt{attempt}.clean.ll"
                    clang_stderr_path = raw_dir / \
                        f"{module_name}.attempt{attempt}.clang.stderr"

                    for p in (attempt_path, cleaned_attempt_path, clang_stderr_path):
                        p.parent.mkdir(parents=True, exist_ok=True)
                    for stale in (attempt_path, cleaned_attempt_path, clang_stderr_path):
                        try:
                            stale.unlink()
                        except FileNotFoundError:
                            pass

                    last_clang_stderr = ""
                    last_clang_rc = None

                    # --- Seed emit ---
                    t0 = time.perf_counter()
                    if use_emit_llvm_file_local:
                        try:
                            cmd = [str(seed_bin), "emit-llvm-file"]
                            if args.timing:
                                cmd.append("--timing")
                            cmd.extend([str(source_path), str(attempt_path)])
                            proc = subprocess.run(
                                cmd,
                                # Run in an isolated cwd populated with build/stage2
                                # native-text artifacts so imported module context is
                                # always available during lowering.
                                cwd=str(seed_emit_cwd),
                                stdout=subprocess.DEVNULL,
                                stderr=subprocess.PIPE,
                                close_fds=False,
                                env=seed_env_local,
                                timeout=_cap_timeout(attempt_seed_timeout),
                            )
                        except subprocess.TimeoutExpired as exc:
                            last_rc = 124
                            last_stderr = (exc.stderr or b"").decode(
                                "utf-8", errors="replace")
                            stats["seed_timeouts"] = int(
                                stats["seed_timeouts"]) + 1
                            if args.attempt_sleep > 0:
                                time.sleep(args.attempt_sleep)
                            continue
                    else:
                        with attempt_path.open("wb") as out:
                            try:
                                cmd = [str(seed_bin), "emit"]
                                if args.timing:
                                    cmd.append("--timing")
                                cmd.extend(["llvm", str(source_path)])
                                proc = subprocess.run(
                                    cmd,
                                    cwd=str(seed_emit_cwd),
                                    stdout=out,
                                    stderr=subprocess.PIPE,
                                    close_fds=False,
                                    env=seed_env_local,
                                    timeout=_cap_timeout(attempt_seed_timeout),
                                )
                            except subprocess.TimeoutExpired as exc:
                                last_rc = 124
                                last_stderr = (exc.stderr or b"").decode(
                                    "utf-8", errors="replace")
                                stats["seed_timeouts"] = int(
                                    stats["seed_timeouts"]) + 1
                                if args.attempt_sleep > 0:
                                    time.sleep(args.attempt_sleep)
                                continue

                    emit_elapsed = time.perf_counter() - t0
                    stats["seed_emit_s"] = float(
                        stats["seed_emit_s"]) + float(emit_elapsed)

                    last_rc = proc.returncode
                    last_stderr = proc.stderr.decode("utf-8", errors="replace")
                    if last_rc != 0:
                        stats["seed_failures"] = int(
                            stats["seed_failures"]) + 1
                        if args.attempt_sleep > 0:
                            time.sleep(args.attempt_sleep)
                        continue

                    if args.timing:
                        for _mod, phase, ms in _extract_timing_lines(last_stderr):
                            local_timing[phase] = ms

                    raw = attempt_path.read_text(
                        encoding="utf-8", errors="replace")
                    candidate = raw if use_emit_llvm_file_local else _strip_stage2_log_prefixes(
                        raw)
                    candidate = _trim_to_llvm_module_start(candidate)

                    # Fallback away from emit-llvm-file if it produced known-bad output.
                    if use_emit_llvm_file_local and "@listpush" in candidate:
                        with attempt_path.open("wb") as out:
                            cmd = [str(seed_bin), "emit"]
                            if args.timing:
                                cmd.append("--timing")
                            cmd.extend(["llvm", str(source_path)])
                            proc = subprocess.run(
                                cmd,
                                cwd=str(seed_emit_cwd),
                                stdout=out,
                                stderr=subprocess.PIPE,
                                close_fds=False,
                                env=seed_env_local,
                                timeout=_cap_timeout(attempt_seed_timeout),
                            )
                        last_rc = proc.returncode
                        last_stderr = proc.stderr.decode(
                            "utf-8", errors="replace")
                        if last_rc != 0:
                            if args.attempt_sleep > 0:
                                time.sleep(args.attempt_sleep)
                            continue
                        raw = attempt_path.read_text(
                            encoding="utf-8", errors="replace")
                        candidate = _strip_stage2_log_prefixes(raw)
                        candidate = _trim_to_llvm_module_start(candidate)
                        use_emit_llvm_file_local = False

                    if not _looks_like_llvm_module(candidate):
                        try:
                            size = attempt_path.stat().st_size
                        except OSError:
                            size = -1
                        preview = "\n".join(candidate.splitlines()[:25])
                        print(
                            f"[selfhost][warn] malformed seed output for {module_name} (rc=0, bytes={size})\n"
                            f"[selfhost][warn] first lines:\n{preview}\n",
                            file=sys.stderr,
                            flush=True,
                        )
                        if args.attempt_sleep > 0:
                            time.sleep(args.attempt_sleep)
                        continue

                    # Learn concrete named type definitions from this module.
                    discovered = _collect_concrete_named_type_defs(candidate)
                    if discovered:
                        with known_named_type_defs_lock:
                            for name, definition in discovered.items():
                                known_named_type_defs.setdefault(
                                    name, definition)

                    # Some seeds reference named types without declaring them.
                    # Insert `type opaque` stubs so clang can parse the module,
                    # then immediately replace any stubs with concrete
                    # definitions we learned from earlier modules.
                    candidate, _ = _inject_missing_named_type_stubs(candidate)

                    # Patch `type opaque` declarations when we know a concrete definition.
                    with known_named_type_defs_lock:
                        candidate, _ = _patch_opaque_named_types(
                            candidate, known_named_type_defs
                        )

                    # Arm64 is sensitive to misaligned accesses: our enum payloads are
                    # byte arrays after a 32-bit tag, so typed loads/stores through
                    # payload bitcasts can be misaligned and are UB without `align`.
                    candidate, _ = _mark_unaligned_enum_payload_accesses(
                        candidate)

                    # Optional debugging: inject probes to dump enum payload raw bits
                    # and decoded pointers around Expression.Call.
                    candidate, _ = _inject_debug_enum_payload_probes(
                        candidate, module_name)

                    # --- Export-definition gate (catches truncated-but-parseable LLVM) ---
                    required = required_export_fns.get(module_name, set())
                    if required:
                        missing_defs: list[str] = []
                        for fn_name in sorted(required):
                            # The stage2 seed currently emits a mix of symbol mangling styles:
                            # - many exports are `@name__module`
                            # - some entrypoints are emitted as plain `@name` (not suffixed)
                            # Treat either as satisfying the export requirement.
                            sym_module = f"@{fn_name}__{module_name}"
                            sym_plain = f"@{fn_name}"
                            has_module = re.search(
                                rf"^define\b.*{re.escape(sym_module)}\b",
                                candidate,
                                re.MULTILINE,
                            )
                            has_plain = re.search(
                                rf"^define\b.*{re.escape(sym_plain)}\b",
                                candidate,
                                re.MULTILINE,
                            )
                            if not (has_module or has_plain):
                                missing_defs.append(sym_module)
                        if missing_defs:
                            try:
                                size = attempt_path.stat().st_size
                            except OSError:
                                size = -1
                            preview = "\n".join(candidate.splitlines()[:40])
                            print(
                                f"[selfhost][warn] seed output for {module_name} is missing {len(missing_defs)} required definition(s) (bytes={size})\n"
                                f"[selfhost][warn] missing: {', '.join(missing_defs[:8])}{' ...' if len(missing_defs) > 8 else ''}\n"
                                f"[selfhost][warn] first lines:\n{preview}\n",
                                file=sys.stderr,
                                flush=True,
                            )
                            if args.attempt_sleep > 0:
                                time.sleep(args.attempt_sleep)
                            continue

                    cleaned_attempt_path.write_text(
                        candidate, encoding="utf-8")
                    validate_obj = raw_dir / \
                        f"{module_name}.attempt{attempt}.o"
                    try:
                        validate_obj.unlink()
                    except FileNotFoundError:
                        pass

                    # --- Clang compile gate (always) ---
                    t1 = time.perf_counter()

                    def _run_clang_compile(flags: list[str]) -> subprocess.CompletedProcess[str]:
                        return subprocess.run(
                            [clang, *flags, "-fPIC", "-c",
                                str(cleaned_attempt_path), "-o", str(validate_obj)],
                            cwd=str(REPO_ROOT),
                            stdout=subprocess.DEVNULL,
                            stderr=subprocess.PIPE,
                            text=True,
                            timeout=_cap_timeout(clang_validate_timeout),
                        )

                    clang_proc = _run_clang_compile(clang_flags)
                    if clang_proc.returncode != 0:
                        maybe_flags, did_patch = _maybe_add_opaque_pointers_flag(
                            clang_flags=clang_flags,
                            clang_stderr=clang_proc.stderr or "",
                        )
                        if did_patch:
                            clang_flags = maybe_flags
                            clang_proc = _run_clang_compile(clang_flags)
                    clang_elapsed = time.perf_counter() - t1
                    clang_stderr_path.write_text(
                        clang_proc.stderr or "", encoding="utf-8")
                    last_clang_stderr = clang_proc.stderr or ""
                    last_clang_rc = int(clang_proc.returncode)

                    stats["clang_validate_s"] = float(
                        stats["clang_validate_s"]) + float(clang_elapsed)
                    stats["clang_validations"] = int(
                        stats["clang_validations"]) + 1

                    if clang_proc.returncode == 0:
                        cleaned = candidate
                        # Do not reuse this object for the final build. We will
                        # run a global named-type normalization pass after all
                        # modules are emitted, then compile objects from the
                        # normalized IR.
                        break

                    stats["clang_validation_failures"] = int(
                        stats["clang_validation_failures"]) + 1

                    # Some seeds omit `declare` lines for imported functions.
                    # Iteratively patch missing declarations inferred from call
                    # sites until clang accepts the module (or we stop making
                    # progress).
                    patched_candidate = candidate
                    for _ in range(64):
                        m = _UNDEFINED_VALUE_RE.search(last_clang_stderr)
                        if not m:
                            break
                        missing = m.group("name").strip()
                        if not missing or missing.startswith("llvm."):
                            break

                        patched_candidate2, did_patch = _inject_declare_for_symbol(
                            patched_candidate, missing
                        )
                        if not did_patch:
                            break
                        patched_candidate = patched_candidate2
                        cleaned_attempt_path.write_text(
                            patched_candidate, encoding="utf-8")
                        try:
                            validate_obj.unlink()
                        except FileNotFoundError:
                            pass
                        clang_proc2 = subprocess.run(
                            [clang, *clang_flags, "-fPIC", "-c",
                                str(cleaned_attempt_path), "-o", str(validate_obj)],
                            cwd=str(REPO_ROOT),
                            stdout=subprocess.DEVNULL,
                            stderr=subprocess.PIPE,
                            text=True,
                            timeout=_cap_timeout(clang_validate_timeout),
                        )
                        last_clang_stderr = clang_proc2.stderr or ""
                        last_clang_rc = int(clang_proc2.returncode)
                        # Persist the latest stderr so failures are debuggable.
                        clang_stderr_path.write_text(
                            last_clang_stderr, encoding="utf-8")
                        if clang_proc2.returncode == 0:
                            cleaned = patched_candidate
                            break

                    if cleaned:
                        break

                    if use_emit_llvm_file_local:
                        # Force retry with streaming emit in the next attempt.
                        use_emit_llvm_file_local = False

                    if args.attempt_sleep > 0:
                        time.sleep(args.attempt_sleep)

                if used_attempts > 1:
                    stats["modules_retried"] = 1

                if not cleaned:
                    try:
                        rel = source_path.relative_to(REPO_ROOT)
                    except ValueError:
                        rel = source_path
                    extra = ""
                    if last_clang_rc is not None and last_clang_stderr.strip():
                        extra = (
                            "\n[selfhost] last clang error (rc="
                            + str(last_clang_rc)
                            + "):\n"
                            + last_clang_stderr
                        )
                    raise SystemExit(
                        "selfhost: seed compiler failed compiling module "
                        f"{idx + 1}/{len(sources)} {rel} (rc={last_rc})\n" +
                        last_stderr + extra
                    )

                final_ll = raw_dir / f"{module_name}.ll"
                final_ll.parent.mkdir(parents=True, exist_ok=True)
                final_ll.write_text(cleaned, encoding="utf-8")
                return module_name, local_timing, stats

            jobs = max(1, int(args.jobs))
            print(
                f"[selfhost] ({pass_name}) building modules with jobs={jobs}", flush=True)
            # NOTE: Some stage2 release seeds appear to rely on prior
            # compilation of imported modules to materialize concrete struct
            # layouts in LLVM output (otherwise emitting `type opaque` for
            # imported structs, which clang rejects once accessed).
            #
            # Compile in dependency order even with jobs=1, so modules that
            # define shared structs (AST/token/native IR) complete before
            # dependents.
            resolved_sources = [p.resolve() for p in sources]
            sources_set = set(resolved_sources)
            deps_by_source: dict[pathlib.Path, set[pathlib.Path]] = {}
            for p in resolved_sources:
                deps_by_source[p] = _sailfin_local_dependencies(p, sources_set)

            dependents: dict[pathlib.Path, set[pathlib.Path]] = {}
            indegree: dict[pathlib.Path, int] = {}
            for p in resolved_sources:
                indegree[p] = 0
                dependents[p] = set()
            for p, deps in deps_by_source.items():
                indegree[p] = len(deps)
                for dep in deps:
                    dependents[dep].add(p)

            # Map resolved path -> original (idx, path) for stable progress output.
            index_by_source: dict[pathlib.Path, int] = {
                resolved_sources[i]: i for i in range(len(resolved_sources))
            }

            ready: list[pathlib.Path] = [
                p for p in resolved_sources if indegree[p] == 0]
            # Prefer deterministic ordering for readiness waves.
            ready.sort(key=lambda p: str(p))

            results_by_index: dict[
                int, tuple[str, dict[str, int], dict[str, float | int]]
            ] = {}
            in_flight: dict[
                concurrent.futures.Future[
                    tuple[str, dict[str, int], dict[str, float | int]]
                ],
                pathlib.Path,
            ] = {}

            completed: set[pathlib.Path] = set()
            first_error: BaseException | None = None

            with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as executor:
                while (ready or in_flight) and first_error is None:
                    _check_budget()

                    while ready and len(in_flight) < jobs:
                        source_resolved = ready.pop(0)
                        original_idx = index_by_source[source_resolved]
                        # Use the resolved path for consistent dependency accounting.
                        fut = executor.submit(
                            _compile_one_module, original_idx, source_resolved
                        )
                        in_flight[fut] = source_resolved

                    if not in_flight:
                        break

                    done, _pending = concurrent.futures.wait(
                        in_flight,
                        return_when=concurrent.futures.FIRST_COMPLETED,
                    )
                    for fut in done:
                        source_resolved = in_flight.pop(fut)
                        original_idx = index_by_source[source_resolved]
                        try:
                            results_by_index[original_idx] = fut.result()
                        except BaseException as exc:
                            first_error = exc
                            for other in in_flight:
                                other.cancel()
                            break

                        completed.add(source_resolved)
                        for child in dependents.get(source_resolved, set()):
                            if child in completed:
                                continue
                            indegree[child] = max(0, indegree[child] - 1)
                            if indegree[child] == 0:
                                ready.append(child)
                        ready.sort(key=lambda p: str(p))

                    if first_error is not None:
                        raise first_error

                # If we couldn't topologically schedule everything (cycles or
                # unresolved imports), fall back to compiling remaining modules
                # in their original order.
                if len(results_by_index) != len(sources):
                    remaining: list[pathlib.Path] = []
                    for p in resolved_sources:
                        if index_by_source[p] not in results_by_index:
                            remaining.append(p)
                    if remaining:
                        print(
                            f"[selfhost][warn] ({pass_name}) dependency scheduler left {len(remaining)} module(s); compiling remaining in original order",
                            flush=True,
                        )
                        with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as executor:
                            extra_futures: dict[concurrent.futures.Future[tuple[str,
                                                                                dict[str, int], dict[str, float | int]]], int] = {}
                            for p in remaining:
                                idx = index_by_source[p]
                                extra_futures[executor.submit(
                                    _compile_one_module, idx, p)] = idx
                            for fut in concurrent.futures.as_completed(extra_futures):
                                idx = extra_futures[fut]
                                results_by_index[idx] = fut.result()

                for idx in range(len(sources)):
                    name, local_timing, module_stats = results_by_index[idx]
                    seed_emit_s += float(module_stats["seed_emit_s"])
                    clang_validate_s += float(
                        module_stats["clang_validate_s"])
                    seed_attempts_total += int(
                        module_stats["seed_attempts_total"])
                    seed_timeouts += int(module_stats["seed_timeouts"])
                    seed_failures += int(module_stats["seed_failures"])
                    clang_validations += int(module_stats["clang_validations"])
                    clang_validation_failures += int(
                        module_stats["clang_validation_failures"]
                    )
                    modules_retried += int(module_stats["modules_retried"])
                    if args.timing and local_timing:
                        timing_by_module[name] = local_timing
                    module_names.append(name)

        except SystemExit as exc:
            # If we're exiting due to a wall-time budget, print partial timing so
            # we can still see the current hotspots.
            if args.max_total_seconds > 0 and "exceeded max wall time" in str(exc):
                _print_timing_summary(
                    header="partial timing summary", module_list=module_names)
            raise

        _check_budget()

        # Global named-type normalization pass.
        #
        # Per-module compilation learns concrete named type definitions
        # incrementally. Modules emitted early can retain `type opaque` lines,
        # which LLVM will resolve by renaming types during linking. That can
        # cause cross-module ABI mismatches and runtime crashes.
        print(
            f"[selfhost] ({pass_name}) normalizing named LLVM types...", flush=True)
        ll_texts: list[str] = []
        ll_paths: list[pathlib.Path] = []
        for name in module_names:
            p = raw_dir / f"{name}.ll"
            ll_paths.append(p)
            ll_texts.append(p.read_text(encoding="utf-8", errors="replace"))

        canonical_defs, canonical_warnings = _build_canonical_named_type_defs(
            ll_texts)
        if canonical_warnings:
            # Keep this as info/warn output rather than failing: this is often
            # recoverable (e.g. concrete vs opaque across modules).
            for w in canonical_warnings:
                print(f"[selfhost][warn] ({pass_name}) {w}", flush=True)

        # Rewrite each module to:
        # - declare any missing referenced named types as opaque
        # - replace opaque defs with canonical concrete defs (including deps)
        for idx, p in enumerate(ll_paths):
            _check_budget()
            text = ll_texts[idx]
            text, _ = _inject_missing_named_type_stubs(text)
            text, _ = _patch_opaque_named_types(text, canonical_defs)
            # Patching can introduce new references via inserted bodies.
            text, _ = _inject_missing_named_type_stubs(text)
            p.write_text(text, encoding="utf-8")

        modules_path = raw_dir / "modules.txt"
        modules_path.write_text(
            "\n".join(module_names) + "\n", encoding="utf-8")

        runtime_c = REPO_ROOT / "runtime/native/src/sailfin_runtime.c"
        driver_c = REPO_ROOT / "runtime/native/src/stage2_driver.c"
        globals_ll = REPO_ROOT / "runtime/native/ir/runtime_globals.ll"
        include_dir = REPO_ROOT / "runtime/native/include"

        runtime_o = obj_dir / "sailfin_runtime.o"
        driver_o = obj_dir / "stage2_driver.o"
        globals_o = obj_dir / "runtime_globals.o"

        def _compile_objects_and_link(*, ll_dir: pathlib.Path) -> None:
            nonlocal clang_compile_s, clang_link_s
            aot_objects: list[pathlib.Path] = []
            prelude_obj: pathlib.Path | None = None

            t0 = time.perf_counter()
            _run(
                [clang, *clang_flags, "-I",
                    str(include_dir), "-c", str(runtime_c), "-o", str(runtime_o)],
                cwd=REPO_ROOT,
                timeout=_remaining_budget_seconds(
                    total_start=t_total_start, max_total_seconds=float(args.max_total_seconds))
                if args.max_total_seconds > 0
                else None,
            )
            clang_compile_s += time.perf_counter() - t0
            t0 = time.perf_counter()
            _run(
                [clang, *clang_flags, "-I",
                    str(include_dir), "-c", str(driver_c), "-o", str(driver_o)],
                cwd=REPO_ROOT,
                timeout=_remaining_budget_seconds(
                    total_start=t_total_start, max_total_seconds=float(args.max_total_seconds))
                if args.max_total_seconds > 0
                else None,
            )
            clang_compile_s += time.perf_counter() - t0
            t0 = time.perf_counter()
            _run(
                [clang, *clang_flags, "-c",
                    str(globals_ll), "-o", str(globals_o)],
                cwd=REPO_ROOT,
                timeout=_remaining_budget_seconds(
                    total_start=t_total_start, max_total_seconds=float(args.max_total_seconds))
                if args.max_total_seconds > 0
                else None,
            )
            clang_compile_s += time.perf_counter() - t0

            # --- IR link step (prevents cross-object ABI/layout mismatches) ---
            llvm_link = shutil.which(os.environ.get("LLVM_LINK", "llvm-link"))
            if not llvm_link:
                raise SystemExit(
                    "selfhost: missing llvm-link (set LLVM_LINK or install LLVM; e.g. brew install llvm)"
                )

            # Keep runtime prelude as a separate object in the canonical runtime
            # bundle location expected by the Stage2 CLI packaging.
            prelude_name = "runtime__prelude"
            ll_paths_for_link: list[pathlib.Path] = []
            for name in module_names:
                if name == prelude_name:
                    continue
                ll_paths_for_link.append(ll_dir / f"{name}.ll")

            linked_bc = obj_dir / "stage2.linked.bc"
            if linked_bc.exists():
                linked_bc.unlink()
            t0 = time.perf_counter()
            _run(
                [llvm_link, "-o", str(linked_bc), *[str(p)
                                                    for p in ll_paths_for_link]],
                cwd=REPO_ROOT,
                timeout=_remaining_budget_seconds(
                    total_start=t_total_start, max_total_seconds=float(args.max_total_seconds))
                if args.max_total_seconds > 0
                else None,
            )
            # llvm-link time is generally small compared to clang, but keep it in compile bucket.
            clang_compile_s += time.perf_counter() - t0

            stage2_o = obj_dir / "stage2.linked.o"
            if stage2_o.exists():
                stage2_o.unlink()
            t0 = time.perf_counter()
            _run(
                [clang, *clang_flags, "-fPIC", "-c",
                    str(linked_bc), "-o", str(stage2_o)],
                cwd=REPO_ROOT,
                timeout=_remaining_budget_seconds(
                    total_start=t_total_start, max_total_seconds=float(args.max_total_seconds))
                if args.max_total_seconds > 0
                else None,
            )
            clang_compile_s += time.perf_counter() - t0
            aot_objects.append(stage2_o)

            # Build runtime prelude object separately (for packaging and for any
            # runtime-link expectations).
            prelude_ll = ll_dir / f"{prelude_name}.ll"
            canonical = obj_dir / "runtime" / "prelude.o"
            canonical.parent.mkdir(parents=True, exist_ok=True)
            if canonical.exists():
                canonical.unlink()
            t0 = time.perf_counter()
            _run(
                [clang, *clang_flags, "-fPIC", "-c",
                    str(prelude_ll), "-o", str(canonical)],
                cwd=REPO_ROOT,
                timeout=_remaining_budget_seconds(
                    total_start=t_total_start, max_total_seconds=float(args.max_total_seconds))
                if args.max_total_seconds > 0
                else None,
            )
            clang_compile_s += time.perf_counter() - t0
            prelude_obj = canonical
            aot_objects.append(canonical)

            out_path.parent.mkdir(parents=True, exist_ok=True)
            if out_path.exists():
                out_path.unlink()

            link_extra: list[str] = []
            if args.deterministic_link:
                link_extra.extend(_deterministic_link_flags())
            link_extra.extend(_platform_link_libs())

            link_cmd = [
                clang,
                *clang_flags,
                "-o",
                str(out_path),
                str(runtime_o),
                str(driver_o),
                str(globals_o),
                *[str(p) for p in aot_objects],
                *link_extra,
            ]

            t0 = time.perf_counter()
            _run(
                link_cmd,
                cwd=REPO_ROOT,
                timeout=_remaining_budget_seconds(
                    total_start=t_total_start, max_total_seconds=float(args.max_total_seconds))
                if args.max_total_seconds > 0
                else None,
            )
            clang_link_s += time.perf_counter() - t0

            if prelude_obj is None:
                raise SystemExit(
                    "selfhost: missing runtime prelude module; expected to compile runtime/prelude.sfn"
                )

        # Default: compile/link directly from the raw IR modules.
        used_ir_dir = raw_dir

        # In `--skip-clang-validate` mode (used by some release CI workflows),
        # we don't have a per-module clang parse/validate gate that would
        # otherwise force retries or catch malformed import mangling early.
        # Some older seed compilers also rely on `aot-prepare-dir` to make IR
        # link-safe (import symbol rewrites + declaration injection). If the
        # seed supports it, run the rewrite step before compiling.
        if args.skip_clang_validate and _seed_supports_aot_prepare_dir(seed_bin):
            prepared_dir = stage2_dir / "aot_prepared"
            prepared_dir.mkdir(parents=True, exist_ok=True)
            for p in prepared_dir.glob("*.ll"):
                try:
                    p.unlink()
                except OSError:
                    pass
            try:
                proc = subprocess.run(
                    [
                        str(seed_bin),
                        "aot-prepare-dir",
                        str(modules_path),
                        str(raw_dir),
                        str(prepared_dir),
                    ],
                    cwd=str(REPO_ROOT),
                    check=True,
                    stdout=subprocess.DEVNULL,
                    stderr=subprocess.PIPE,
                )
                _ = proc  # silence linters
                used_ir_dir = prepared_dir
            except subprocess.CalledProcessError as exc:
                stderr_text = (exc.stderr or b"").decode(
                    "utf-8", errors="replace")
                # If the seed doesn't actually implement this subcommand, it can
                # respond with the generic CLI usage. Don't spam CI logs for that.
                if not stderr_text.startswith("usage: sailfin-stage2 [--emit sailfin|llvm]"):
                    print(
                        "[selfhost][warn] aot-prepare-dir failed; continuing with raw IR\n"
                        + stderr_text,
                        file=sys.stderr,
                        flush=True,
                    )
        _compile_objects_and_link(ll_dir=used_ir_dir)

        _print_timing_summary(header="timing summary",
                              module_list=module_names)
        return used_ir_dir, module_names

    out_path1 = args.out
    aot_dir1, module_names1 = _build_once(
        seed_bin=seed, out_path=out_path1, pass_name="stage2")
    subprocess.run(
        [str(out_path1), "--version"],
        cwd=str(REPO_ROOT),
        check=True,
        timeout=30,
    )

    if args.fixed_point:
        _check_budget()
        out_path2 = args.out.with_name(args.out.name + "-fp2")
        aot_dir2, module_names2 = _build_once(
            seed_bin=out_path1, out_path=out_path2, pass_name="stage2_fp2")
        subprocess.run(
            [str(out_path2), "--version"],
            cwd=str(REPO_ROOT),
            check=True,
            timeout=30,
        )

        if module_names1 != module_names2:
            raise SystemExit(
                "selfhost: fixed-point mismatch in modules.txt ordering")

        diffs: list[str] = []
        for name in module_names1:
            p1 = aot_dir1 / f"{name}.ll"
            p2 = aot_dir2 / f"{name}.ll"
            if not p1.exists() or not p2.exists():
                diffs.append(name)
                continue
            if _hash_file(p1) != _hash_file(p2):
                diffs.append(name)

        if diffs:
            preview = "\n".join(diffs[:25])
            more = "" if len(
                diffs) <= 25 else f"\n... and {len(diffs) - 25} more"
            raise SystemExit(
                "selfhost: fixed-point AOT output mismatch for module(s):\n" +
                preview + more
            )

        print("[selfhost] fixed-point: AOT outputs match", flush=True)

    total_s = time.perf_counter() - t_total_start
    print(f"[selfhost] total wall time: {total_s:.2f}s", flush=True)
    _check_budget()
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
