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
import time

from aot_prepare import prepare_stage2_aot_modules


REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]


def _run(cmd: list[str], *, cwd: pathlib.Path, stdout_path: pathlib.Path | None = None) -> None:
    if stdout_path is None:
        subprocess.run(cmd, cwd=str(cwd), check=True)
        return

    stdout_path.parent.mkdir(parents=True, exist_ok=True)
    with stdout_path.open("wb") as f:
        subprocess.run(cmd, cwd=str(cwd), check=True, stdout=f)


def _seed_supports_emit_llvm_file(seed: pathlib.Path) -> bool:
    proc = subprocess.run(
        [str(seed), "emit-llvm-file"],
        cwd=str(REPO_ROOT),
        stdout=subprocess.DEVNULL,
        stderr=subprocess.PIPE,
    )
    stderr = proc.stderr.decode("utf-8", errors="replace")
    # When the command exists, stage2 prints usage for missing args.
    if "emit-llvm-file" in stderr or "usage" in stderr:
        return True
    # If the command does not exist, stage2 reports an unknown command.
    if "unknown" in stderr and "emit-llvm-file" in stderr:
        return False
    return proc.returncode != 0


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
        "--max-attempts",
        type=int,
        default=50,
        help="Max attempts per module when seed output is malformed (default: 50)",
    )
    parser.add_argument(
        "--attempt-sleep",
        type=float,
        default=0.0,
        help="Seconds to sleep between attempts for a flaky module (default: 0)",
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

    use_emit_llvm_file = _seed_supports_emit_llvm_file(seed)
    seed_env = os.environ.copy()
    seed_env["SAILFIN_DISABLE_STRING_FREE"] = "1"

    for idx, source_path in enumerate(sources):
        module_name = source_path.stem
        max_attempts = max(1, int(args.max_attempts))
        cleaned = ""
        last_stderr = ""
        last_rc: int | None = None
        for attempt in range(1, max_attempts + 1):
            attempt_path = raw_dir / f"{module_name}.attempt{attempt}.ll"
            if use_emit_llvm_file:
                proc = subprocess.run(
                    [str(seed), "emit-llvm-file",
                     str(source_path), str(attempt_path)],
                    cwd=str(REPO_ROOT),
                    stdout=subprocess.DEVNULL,
                    stderr=subprocess.PIPE,
                    close_fds=False,
                    env=seed_env,
                )
            else:
                # NOTE: Some seed compilers have been observed to emit truncated LLVM
                # when stdout is a pipe (e.g. via subprocess stdout=PIPE). Writing to
                # a real file sidesteps that runtime issue.
                with attempt_path.open("wb") as out:
                    proc = subprocess.run(
                        [str(seed), "emit", "llvm", str(source_path)],
                        cwd=str(REPO_ROOT),
                        stdout=out,
                        stderr=subprocess.PIPE,
                        close_fds=False,
                        env=seed_env,
                    )
            last_rc = proc.returncode
            last_stderr = proc.stderr.decode("utf-8", errors="replace")
            if proc.returncode != 0:
                if args.attempt_sleep > 0:
                    time.sleep(args.attempt_sleep)
                continue

            raw = attempt_path.read_text(encoding="utf-8", errors="replace")
            candidate = raw if use_emit_llvm_file else _strip_stage2_log_prefixes(
                raw)
            if _looks_like_llvm_module(candidate):
                cleaned = candidate
                break

            if args.attempt_sleep > 0:
                time.sleep(args.attempt_sleep)

        if not cleaned:
            try:
                rel = source_path.relative_to(REPO_ROOT)
            except ValueError:
                rel = source_path
            raise SystemExit(
                "selfhost: seed compiler failed compiling module "
                f"{idx + 1}/{len(sources)} {rel} (rc={last_rc})\n"
                + last_stderr
            )

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
