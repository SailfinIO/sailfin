#!/usr/bin/env python3
"""Rebuild the native stage2 compiler using an existing native stage2 binary.

This is the self-host check CI ultimately needs:

- Start from a *seed* native `sailfin-stage2` binary.
- Compile the full stage2 module set (compiler + runtime Sailfin sources) to
    separate LLVM modules.
- Apply AOT preparation (symbol deconfliction) so the modules can be linked
    together.
- Compile/link a fresh native `sailfin-stage2`.

This does NOT import stage1-generated Python compiler artifacts and does NOT run
`scripts/bootstrap_stage2.py`.
"""

from __future__ import annotations

import argparse
import os
import pathlib
import subprocess
import sys

from aot_prepare import prepare_stage2_aot_modules


REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]


def _run(cmd: list[str], *, cwd: pathlib.Path, stdout_path: pathlib.Path | None = None) -> None:
    if stdout_path is None:
        subprocess.run(cmd, cwd=str(cwd), check=True)
        return

    stdout_path.parent.mkdir(parents=True, exist_ok=True)
    with stdout_path.open("wb") as f:
        subprocess.run(cmd, cwd=str(cwd), check=True, stdout=f)


def _strip_stage2_log_prefixes(text: str) -> str:
    """Remove leading stage2 log prefixes like '[info] ' from LLVM text.

    Some stage2 builds annotate LLVM output lines with a log-level prefix. This
    helper strips that prefix so clang can parse the IR.
    """

    out_lines: list[str] = []
    for line in text.splitlines():
        if line.startswith("[info] "):
            out_lines.append(line[len("[info] "):])
            continue
        if line.startswith("[warn] "):
            out_lines.append(line[len("[warn] "):])
            continue
        if line.startswith("[error] "):
            out_lines.append(line[len("[error] "):])
            continue
        out_lines.append(line)
    return "\n".join(out_lines) + "\n"


def _collect_stage2_sources(repo_root: pathlib.Path) -> list[pathlib.Path]:
    compiler_src = repo_root / "compiler" / "src"
    runtime_src = repo_root / "runtime"

    if not compiler_src.exists():
        raise SystemExit(f"missing compiler sources: {compiler_src}")
    if not runtime_src.exists():
        raise SystemExit(f"missing runtime sources: {runtime_src}")

    # Match `scripts/bootstrap_stage2.py`: exclude aot_prepare.sfn.
    sources = [p for p in sorted(compiler_src.rglob(
        "*.sfn")) if p.name != "aot_prepare.sfn"]
    runtime_sources = sorted(runtime_src.rglob("*.sfn"))
    all_sources = sources + runtime_sources
    if not all_sources:
        raise SystemExit("no Sailfin sources found to compile")
    return all_sources


def main(argv: list[str]) -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--seed",
        type=pathlib.Path,
        default=REPO_ROOT / "build/native/sailfin-stage2",
        help="Path to the seed native sailfin-stage2 binary",
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

    args = parser.parse_args(argv)

    seed = args.seed
    out_path = args.out

    if not seed.exists():
        raise SystemExit(f"missing seed compiler: {seed}")
    if not os.access(seed, os.X_OK):
        raise SystemExit(f"seed compiler is not executable: {seed}")
    work_dir = REPO_ROOT / "build" / "selfhost"
    stage2_dir = work_dir / "stage2"
    raw_dir = stage2_dir / "raw"
    aot_dir = stage2_dir / "aot"
    obj_dir = work_dir / "obj"

    raw_dir.mkdir(parents=True, exist_ok=True)
    aot_dir.mkdir(parents=True, exist_ok=True)
    obj_dir.mkdir(parents=True, exist_ok=True)

    # Clean object outputs (avoid accidentally linking stale objs).
    for p in obj_dir.glob("*.o"):
        p.unlink()

    # 1) Compile all stage2 sources to per-module LLVM.
    sources = _collect_stage2_sources(REPO_ROOT)
    module_names: list[str] = []
    module_texts: list[str] = []

    for idx, source_path in enumerate(sources):
        module_name = source_path.stem
        proc = subprocess.run(
            [str(seed), "emit", "llvm", str(source_path)],
            cwd=str(REPO_ROOT),
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )
        if proc.returncode != 0:
            try:
                rel = source_path.relative_to(REPO_ROOT)
            except ValueError:
                rel = source_path
            stderr_text = proc.stderr.decode("utf-8", errors="replace")
            raise SystemExit(
                "selfhost: seed compiler failed compiling module "
                f"{idx + 1}/{len(sources)} {rel} (rc={proc.returncode})\n"
                + stderr_text
            )

        raw = proc.stdout.decode("utf-8", errors="replace")
        cleaned = _strip_stage2_log_prefixes(raw)
        (raw_dir / f"{module_name}.ll").write_text(cleaned, encoding="utf-8")
        module_names.append(module_name)
        module_texts.append(cleaned)

    # 2) AOT prepare: deconflict duplicate globals/functions across modules.
    rewritten = prepare_stage2_aot_modules(module_names, module_texts)
    if len(rewritten) != len(module_names):
        raise SystemExit(
            f"aot_prepare returned {len(rewritten)} module(s), expected {len(module_names)}"
        )

    for name, ir in zip(module_names, rewritten):
        (aot_dir / f"{name}.ll").write_text(ir if ir.endswith("\n")
                                            else ir + "\n", encoding="utf-8")
    (aot_dir / "modules.txt").write_text("\n".join(module_names) + "\n", encoding="utf-8")

    clang = args.clang
    clang_flags: list[str] = [args.opt]
    if args.wno_override_module:
        clang_flags.append("-Wno-override-module")

    runtime_c = REPO_ROOT / "runtime/native/src/sailfin_runtime.c"
    driver_c = REPO_ROOT / "runtime/native/src/stage2_driver.c"
    globals_ll = REPO_ROOT / "runtime/native/ir/runtime_globals.ll"

    include_dir = REPO_ROOT / "runtime/native/include"

    runtime_o = obj_dir / "sailfin_runtime.o"
    driver_o = obj_dir / "stage2_driver.o"
    globals_o = obj_dir / "runtime_globals.o"

    aot_objects: list[pathlib.Path] = []

    _run(
        [
            clang,
            *clang_flags,
            "-I",
            str(include_dir),
            "-c",
            str(runtime_c),
            "-o",
            str(runtime_o),
        ],
        cwd=REPO_ROOT,
    )
    _run(
        [
            clang,
            *clang_flags,
            "-I",
            str(include_dir),
            "-c",
            str(driver_c),
            "-o",
            str(driver_o),
        ],
        cwd=REPO_ROOT,
    )
    _run(
        [
            clang,
            *clang_flags,
            "-c",
            str(globals_ll),
            "-o",
            str(globals_o),
        ],
        cwd=REPO_ROOT,
    )
    # Compile each AOT-prepared module.
    for name in module_names:
        ll_path = aot_dir / f"{name}.ll"
        out_o = obj_dir / f"{name}.o"
        _run(
            [
                clang,
                *clang_flags,
                "-fPIC",
                "-c",
                str(ll_path),
                "-o",
                str(out_o),
            ],
            cwd=REPO_ROOT,
        )
        aot_objects.append(out_o)

    # 3) Link the new stage2 binary.
    out_path.parent.mkdir(parents=True, exist_ok=True)
    if out_path.exists():
        out_path.unlink()

    # Keep this minimal; platform-specific libs are handled by the Makefile path.
    link_cmd = [
        clang,
        *clang_flags,
        "-o",
        str(out_path),
        str(runtime_o),
        str(driver_o),
        str(globals_o),
        *[str(p) for p in aot_objects],
    ]

    _run(link_cmd, cwd=REPO_ROOT)

    # 4) Smoke check: new binary should run.
    subprocess.run([str(out_path), "--version"],
                   cwd=str(REPO_ROOT), check=True)

    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
