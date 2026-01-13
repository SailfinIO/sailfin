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


REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]


_IMPORT_FROM_RE = re.compile(r"\bfrom\s+\"(?P<path>[^\"]+)\"")
_IMPORT_BARE_RE = re.compile(
    r"^\s*import\s+\"(?P<path>[^\"]+)\"\s*;", re.MULTILINE)


_LLVM_NAMED_TYPE_DEF_RE = re.compile(
    r"^(?P<name>%[A-Za-z_.$][A-Za-z0-9_.$]*)\s*=\s*type\s+(?P<body>.+)$",
    re.MULTILINE,
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
    defined: set[str] = set()
    for line in lines_in:
        m = type_decl_re.match(line)
        if m:
            defined.add(m.group("name"))

    # Names we inserted (so we don't re-insert or loop forever).
    emitted: set[str] = set()

    def _emit_with_deps(name: str) -> list[str]:
        if name in emitted or name in defined:
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
            if ref in known_defs and ref not in defined and ref not in emitted:
                deps.extend(_emit_with_deps(ref))
        emitted.add(name)
        defined.add(name)
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
                    changed += 1
                    continue
        patched_lines.append(line)

    return "\n".join(patched_lines) + "\n", changed


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
    if tail:
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


_UNDEFINED_VALUE_RE = re.compile(r"use of undefined value '@(?P<name>[^']+)'")


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

    return source_path.stem


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
        default=600.0,
        help="Fail if the rebuild exceeds this wall time (default: 600)",
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
            "Use the seed compiler's 'emit-llvm-file' command when available. "
            "Disabled by default because some seeds can silently truncate output."
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

    args = parser.parse_args(argv)

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
                f"selfhost: exceeded max wall time ({elapsed:.2f}s > {args.max_total_seconds:.2f}s)"
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
    clang_flags: list[str] = [args.opt]
    if args.wno_override_module:
        clang_flags.append("-Wno-override-module")

    if not seed.exists():
        raise SystemExit(f"missing seed compiler: {seed}")
    if not os.access(seed, os.X_OK):
        raise SystemExit(f"seed compiler is not executable: {seed}")

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

        work_dir = args.work_dir
        stage2_dir = work_dir / pass_name
        raw_dir = stage2_dir / "raw"
        obj_dir = stage2_dir / "obj"

        raw_dir.mkdir(parents=True, exist_ok=True)
        obj_dir.mkdir(parents=True, exist_ok=True)

        for p in obj_dir.rglob("*.o"):
            p.unlink()

        sources = _collect_stage2_sources(REPO_ROOT)
        module_names: list[str] = []

        # Shared cache of concrete named LLVM type definitions discovered while
        # compiling modules. Used to replace `%Foo = type opaque` in other
        # modules when a concrete definition is known.
        known_named_type_defs: dict[str, str] = {}
        known_named_type_defs_lock = threading.Lock()

        use_emit_llvm_file = args.use_emit_llvm_file and _seed_supports_emit_llvm_file(
            seed_bin)
        seed_env = os.environ.copy()
        seed_env["SAILFIN_DISABLE_STRING_FREE"] = "1"

        seed_timeout = None
        if args.seed_timeout and args.seed_timeout > 0:
            seed_timeout = float(args.seed_timeout)
        clang_validate_timeout = None
        if args.clang_validate_timeout and args.clang_validate_timeout > 0:
            clang_validate_timeout = float(args.clang_validate_timeout)

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
                                # Keep CWD at repo root so seeds that resolve module roots
                                # or cache/import metadata relative to the working directory
                                # can materialize concrete struct layouts.
                                cwd=str(REPO_ROOT),
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
                                    cwd=str(REPO_ROOT),
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
                                cwd=str(REPO_ROOT),
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

                    # Some release seeds emit call sites without corresponding
                    # declarations. Inject any missing `declare` lines before
                    # running the clang compile gate to keep selfhost robust.
                    candidate, _ = _inject_missing_function_declarations(
                        candidate)

                    # Learn concrete named type definitions from this module.
                    discovered = _collect_concrete_named_type_defs(candidate)
                    if discovered:
                        with known_named_type_defs_lock:
                            for name, definition in discovered.items():
                                known_named_type_defs.setdefault(
                                    name, definition)

                    # Patch `type opaque` declarations when we know a concrete definition.
                    with known_named_type_defs_lock:
                        candidate, _ = _patch_opaque_named_types(
                            candidate, known_named_type_defs
                        )

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
                    clang_proc = subprocess.run(
                        [clang, *clang_flags, "-fPIC", "-c",
                            str(cleaned_attempt_path), "-o", str(validate_obj)],
                        cwd=str(REPO_ROOT),
                        stdout=subprocess.DEVNULL,
                        stderr=subprocess.PIPE,
                        text=True,
                        timeout=_cap_timeout(clang_validate_timeout),
                    )
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
                        try:
                            try:
                                final_obj_path.unlink()
                            except FileNotFoundError:
                                pass
                            validate_obj.replace(final_obj_path)
                        except OSError:
                            shutil.copy2(validate_obj, final_obj_path)
                        break

                    stats["clang_validation_failures"] = int(
                        stats["clang_validation_failures"]) + 1

                    m = _UNDEFINED_VALUE_RE.search(last_clang_stderr)
                    if m:
                        missing = m.group("name")
                        if "__" in missing:
                            patched, did_patch = _inject_declare_for_symbol(
                                candidate, missing)
                            if did_patch:
                                cleaned_attempt_path.write_text(
                                    patched, encoding="utf-8")
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
                                    timeout=_cap_timeout(
                                        clang_validate_timeout),
                                )
                                last_clang_stderr = clang_proc2.stderr or ""
                                last_clang_rc = int(clang_proc2.returncode)
                                if clang_proc2.returncode == 0:
                                    cleaned = patched
                                    try:
                                        try:
                                            final_obj_path.unlink()
                                        except FileNotFoundError:
                                            pass
                                        validate_obj.replace(final_obj_path)
                                    except OSError:
                                        shutil.copy2(
                                            validate_obj, final_obj_path)
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
            if jobs == 1:
                for idx, source_path in enumerate(sources):
                    _check_budget()
                    name, local_timing, module_stats = _compile_one_module(
                        idx, source_path)
                    seed_emit_s += float(module_stats["seed_emit_s"])
                    clang_validate_s += float(module_stats["clang_validate_s"])
                    seed_attempts_total += int(
                        module_stats["seed_attempts_total"])
                    seed_timeouts += int(module_stats["seed_timeouts"])
                    seed_failures += int(module_stats["seed_failures"])
                    clang_validations += int(module_stats["clang_validations"])
                    clang_validation_failures += int(
                        module_stats["clang_validation_failures"])
                    modules_retried += int(module_stats["modules_retried"])
                    if args.timing and local_timing:
                        timing_by_module[name] = local_timing
                    module_names.append(name)
            else:
                print(
                    f"[selfhost] ({pass_name}) building modules with jobs={jobs}", flush=True)
                # NOTE: Some stage2 release seeds appear to rely on prior
                # compilation of imported modules to materialize concrete struct
                # layouts in LLVM output (otherwise emitting `type opaque` for
                # imported structs, which clang rejects once accessed).
                #
                # When running in parallel, compile in dependency order so
                # modules that define AST/token structs (and similar) complete
                # before dependents.
                resolved_sources = [p.resolve() for p in sources]
                sources_set = set(resolved_sources)
                deps_by_source: dict[pathlib.Path, set[pathlib.Path]] = {}
                for p in resolved_sources:
                    deps_by_source[p] = _sailfin_local_dependencies(
                        p, sources_set)

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

            for name in module_names:
                _check_budget()
                ll_path = ll_dir / f"{name}.ll"
                out_o = obj_dir / f"{name}.o"
                out_o.parent.mkdir(parents=True, exist_ok=True)
                if not out_o.exists():
                    t0 = time.perf_counter()
                    _run(
                        [clang, *clang_flags, "-fPIC", "-c",
                            str(ll_path), "-o", str(out_o)],
                        cwd=REPO_ROOT,
                        timeout=_remaining_budget_seconds(
                            total_start=t_total_start, max_total_seconds=float(args.max_total_seconds))
                        if args.max_total_seconds > 0
                        else None,
                    )
                    clang_compile_s += time.perf_counter() - t0
                aot_objects.append(out_o)

                # Also emit the runtime prelude object in the canonical runtime
                # bundle location expected by the Stage2 CLI packaging.
                if name == "runtime__prelude":
                    canonical = obj_dir / "runtime" / "prelude.o"
                    canonical.parent.mkdir(parents=True, exist_ok=True)
                    if canonical.exists():
                        canonical.unlink()
                    if out_o.exists():
                        try:
                            os.link(out_o, canonical)
                        except OSError:
                            shutil.copy2(out_o, canonical)
                    else:
                        t0 = time.perf_counter()
                        _run(
                            [clang, *clang_flags, "-fPIC", "-c",
                                str(ll_path), "-o", str(canonical)],
                            cwd=REPO_ROOT,
                            timeout=_remaining_budget_seconds(
                                total_start=t_total_start, max_total_seconds=float(args.max_total_seconds))
                            if args.max_total_seconds > 0
                            else None,
                        )
                        clang_compile_s += time.perf_counter() - t0
                    prelude_obj = canonical

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
