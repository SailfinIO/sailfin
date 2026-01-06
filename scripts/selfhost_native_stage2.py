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
import hashlib
import os
import pathlib
import subprocess
import sys
import time


REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]


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


def _run(cmd: list[str], *, cwd: pathlib.Path, stdout_path: pathlib.Path | None = None) -> None:
    if stdout_path is None:
        subprocess.run(cmd, cwd=str(cwd), check=True)
        return

    stdout_path.parent.mkdir(parents=True, exist_ok=True)
    with stdout_path.open("wb") as f:
        subprocess.run(cmd, cwd=str(cwd), check=True, stdout=f)


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
    )
    stderr = proc.stderr.decode("utf-8", errors="replace")
    if "aot-prepare-dir" in stderr or "usage" in stderr:
        return True
    if "unknown" in stderr and "aot-prepare-dir" in stderr:
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
        "--attempt-sleep",
        type=float,
        default=0.0,
        help="Seconds to sleep between attempts for a flaky module (default: 0)",
    )
    parser.add_argument(
        "--seed-timeout",
        type=float,
        default=180.0,
        help="Timeout (seconds) per seed emit attempt (default: 180)",
    )
    parser.add_argument(
        "--clang-validate-timeout",
        type=float,
        default=30.0,
        help="Timeout (seconds) for per-module clang validation (default: 30)",
    )
    parser.add_argument(
        "--skip-clang-validate",
        action="store_true",
        help="Skip per-module clang validation (not recommended)",
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
        default=True,
        help="Prefer ASAN seed when available (default: on)",
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
        aot_prepare_s = 0.0
        clang_compile_s = 0.0
        clang_link_s = 0.0
        seed_attempts_total = 0
        seed_timeouts = 0
        seed_failures = 0
        modules_retried = 0
        clang_validations = 0
        clang_validation_failures = 0

        work_dir = args.work_dir
        stage2_dir = work_dir / pass_name
        raw_dir = stage2_dir / "raw"
        aot_dir = stage2_dir / "aot"
        obj_dir = stage2_dir / "obj"

        raw_dir.mkdir(parents=True, exist_ok=True)
        aot_dir.mkdir(parents=True, exist_ok=True)
        obj_dir.mkdir(parents=True, exist_ok=True)

        for p in obj_dir.rglob("*.o"):
            p.unlink()

        sources = _collect_stage2_sources(REPO_ROOT)
        module_names: list[str] = []

        use_emit_llvm_file = _seed_supports_emit_llvm_file(seed_bin)
        seed_env = os.environ.copy()
        seed_env["SAILFIN_DISABLE_STRING_FREE"] = "1"

        seed_timeout = None
        if args.seed_timeout and args.seed_timeout > 0:
            seed_timeout = float(args.seed_timeout)
        clang_validate_timeout = None
        if args.clang_validate_timeout and args.clang_validate_timeout > 0:
            clang_validate_timeout = float(args.clang_validate_timeout)

        for idx, source_path in enumerate(sources):
            _check_budget()
            module_name = _module_name_from_source_path(source_path)
            max_attempts = max(1, int(args.max_attempts))
            cleaned = ""
            last_stderr = ""
            last_rc: int | None = None
            used_attempts = 0
            for attempt in range(1, max_attempts + 1):
                used_attempts = attempt
                seed_attempts_total += 1
                print(
                    f"[selfhost] ({pass_name}) module {idx + 1}/{len(sources)} {module_name} attempt {attempt}/{max_attempts}",
                    flush=True,
                )
                attempt_path = raw_dir / f"{module_name}.attempt{attempt}.ll"
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

                if use_emit_llvm_file:
                    try:
                        t0 = time.perf_counter()
                        proc = subprocess.run(
                            [str(seed_bin), "emit-llvm-file",
                             str(source_path), str(attempt_path)],
                            cwd=str(REPO_ROOT),
                            stdout=subprocess.DEVNULL,
                            stderr=subprocess.PIPE,
                            close_fds=False,
                            env=seed_env,
                            timeout=seed_timeout,
                        )
                        seed_emit_s += time.perf_counter() - t0
                    except subprocess.TimeoutExpired as exc:
                        last_rc = 124
                        seed_timeouts += 1
                        last_stderr = (exc.stderr or b"").decode(
                            "utf-8", errors="replace")
                        if args.attempt_sleep > 0:
                            time.sleep(args.attempt_sleep)
                        continue
                else:
                    with attempt_path.open("wb") as out:
                        try:
                            t0 = time.perf_counter()
                            proc = subprocess.run(
                                [str(seed_bin), "emit",
                                 "llvm", str(source_path)],
                                cwd=str(REPO_ROOT),
                                stdout=out,
                                stderr=subprocess.PIPE,
                                close_fds=False,
                                env=seed_env,
                                timeout=seed_timeout,
                            )
                            seed_emit_s += time.perf_counter() - t0
                        except subprocess.TimeoutExpired as exc:
                            last_rc = 124
                            seed_timeouts += 1
                            last_stderr = (exc.stderr or b"").decode(
                                "utf-8", errors="replace")
                            if args.attempt_sleep > 0:
                                time.sleep(args.attempt_sleep)
                            continue

                last_rc = proc.returncode
                last_stderr = proc.stderr.decode("utf-8", errors="replace")
                if proc.returncode != 0:
                    seed_failures += 1
                    if args.attempt_sleep > 0:
                        time.sleep(args.attempt_sleep)
                    continue

                raw = attempt_path.read_text(
                    encoding="utf-8", errors="replace")
                candidate = raw if use_emit_llvm_file else _strip_stage2_log_prefixes(
                    raw)

                if use_emit_llvm_file and "@listpush" in candidate:
                    with attempt_path.open("wb") as out:
                        try:
                            t0 = time.perf_counter()
                            proc = subprocess.run(
                                [str(seed_bin), "emit",
                                 "llvm", str(source_path)],
                                cwd=str(REPO_ROOT),
                                stdout=out,
                                stderr=subprocess.PIPE,
                                close_fds=False,
                                env=seed_env,
                                timeout=seed_timeout,
                            )
                            seed_emit_s += time.perf_counter() - t0
                        except subprocess.TimeoutExpired as exc:
                            last_rc = 124
                            seed_timeouts += 1
                            last_stderr = (exc.stderr or b"").decode(
                                "utf-8", errors="replace")
                            if args.attempt_sleep > 0:
                                time.sleep(args.attempt_sleep)
                            continue

                    last_rc = proc.returncode
                    last_stderr = proc.stderr.decode("utf-8", errors="replace")
                    if proc.returncode != 0:
                        seed_failures += 1
                        if args.attempt_sleep > 0:
                            time.sleep(args.attempt_sleep)
                        continue

                    raw = attempt_path.read_text(
                        encoding="utf-8", errors="replace")
                    candidate = _strip_stage2_log_prefixes(raw)

                if _looks_like_llvm_module(candidate):
                    if args.skip_clang_validate:
                        cleaned = candidate
                        break

                    cleaned_attempt_path.write_text(
                        candidate, encoding="utf-8")
                    validate_obj = raw_dir / \
                        f"{module_name}.attempt{attempt}.o"
                    validate_obj.parent.mkdir(parents=True, exist_ok=True)
                    try:
                        validate_obj.unlink()
                    except FileNotFoundError:
                        pass

                    clang_validations += 1
                    t0 = time.perf_counter()
                    clang_proc = subprocess.run(
                        [clang, *clang_flags, "-fPIC", "-c",
                            str(cleaned_attempt_path), "-o", str(validate_obj)],
                        cwd=str(REPO_ROOT),
                        stdout=subprocess.DEVNULL,
                        stderr=subprocess.PIPE,
                        text=True,
                        timeout=clang_validate_timeout,
                    )
                    clang_validate_s += time.perf_counter() - t0
                    clang_stderr_path.write_text(
                        clang_proc.stderr or "", encoding="utf-8")

                    if clang_proc.returncode == 0:
                        cleaned = candidate
                        break

                    clang_validation_failures += 1

                    # `emit-llvm-file` has historically produced malformed output
                    # for some large modules. If validation fails and we used
                    # `emit-llvm-file`, retry once in this attempt using the
                    # streaming `emit llvm` path.
                    if use_emit_llvm_file:
                        with attempt_path.open("wb") as out:
                            try:
                                t0 = time.perf_counter()
                                proc = subprocess.run(
                                    [str(seed_bin), "emit",
                                     "llvm", str(source_path)],
                                    cwd=str(REPO_ROOT),
                                    stdout=out,
                                    stderr=subprocess.PIPE,
                                    close_fds=False,
                                    env=seed_env,
                                    timeout=seed_timeout,
                                )
                                seed_emit_s += time.perf_counter() - t0
                            except subprocess.TimeoutExpired as exc:
                                last_rc = 124
                                seed_timeouts += 1
                                last_stderr = (exc.stderr or b"").decode(
                                    "utf-8", errors="replace")
                                continue

                        last_rc = proc.returncode
                        last_stderr = proc.stderr.decode(
                            "utf-8", errors="replace")
                        if proc.returncode != 0:
                            seed_failures += 1
                            continue

                        raw = attempt_path.read_text(
                            encoding="utf-8", errors="replace")
                        candidate = _strip_stage2_log_prefixes(raw)
                        if _looks_like_llvm_module(candidate):
                            cleaned_attempt_path.write_text(
                                candidate, encoding="utf-8")
                            clang_validations += 1
                            t0 = time.perf_counter()
                            clang_proc = subprocess.run(
                                [clang, *clang_flags, "-fPIC", "-c",
                                 str(cleaned_attempt_path), "-o", str(validate_obj)],
                                cwd=str(REPO_ROOT),
                                stdout=subprocess.DEVNULL,
                                stderr=subprocess.PIPE,
                                text=True,
                                timeout=clang_validate_timeout,
                            )
                            clang_validate_s += time.perf_counter() - t0
                            clang_stderr_path.write_text(
                                clang_proc.stderr or "", encoding="utf-8")

                            if clang_proc.returncode == 0:
                                cleaned = candidate
                                break

                if args.attempt_sleep > 0:
                    time.sleep(args.attempt_sleep)

            if used_attempts > 1:
                modules_retried += 1

            if not cleaned:
                try:
                    rel = source_path.relative_to(REPO_ROOT)
                except ValueError:
                    rel = source_path
                raise SystemExit(
                    "selfhost: seed compiler failed compiling module "
                    f"{idx + 1}/{len(sources)} {rel} (rc={last_rc})\n" +
                    last_stderr
                )

            final_ll = raw_dir / f"{module_name}.ll"
            final_ll.parent.mkdir(parents=True, exist_ok=True)
            final_ll.write_text(cleaned, encoding="utf-8")
            module_names.append(module_name)

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

            t0 = time.perf_counter()
            _run([clang, *clang_flags, "-I", str(include_dir), "-c",
                 str(runtime_c), "-o", str(runtime_o)], cwd=REPO_ROOT)
            clang_compile_s += time.perf_counter() - t0
            t0 = time.perf_counter()
            _run([clang, *clang_flags, "-I", str(include_dir), "-c",
                 str(driver_c), "-o", str(driver_o)], cwd=REPO_ROOT)
            clang_compile_s += time.perf_counter() - t0
            t0 = time.perf_counter()
            _run([clang, *clang_flags, "-c", str(globals_ll),
                 "-o", str(globals_o)], cwd=REPO_ROOT)
            clang_compile_s += time.perf_counter() - t0

            for name in module_names:
                _check_budget()
                ll_path = ll_dir / f"{name}.ll"
                out_o = obj_dir / f"{name}.o"
                out_o.parent.mkdir(parents=True, exist_ok=True)
                t0 = time.perf_counter()
                _run([clang, *clang_flags, "-fPIC", "-c",
                     str(ll_path), "-o", str(out_o)], cwd=REPO_ROOT)
                clang_compile_s += time.perf_counter() - t0
                aot_objects.append(out_o)

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
            _run(link_cmd, cwd=REPO_ROOT)
            clang_link_s += time.perf_counter() - t0

        # Compile/link directly from the raw IR modules.
        used_ir_dir = raw_dir
        _compile_objects_and_link(ll_dir=used_ir_dir)

        print(f"[selfhost] ({pass_name}) timing summary:", flush=True)
        print(
            "[selfhost] "
            f"attempts={seed_attempts_total} retried_modules={modules_retried} "
            f"timeouts={seed_timeouts} seed_failures={seed_failures} "
            f"clang_validations={clang_validations} clang_validation_failures={clang_validation_failures}",
            flush=True,
        )
        print(f"[selfhost] seed emit: {seed_emit_s:.2f}s", flush=True)
        if not args.skip_clang_validate:
            print(
                f"[selfhost] clang validate: {clang_validate_s:.2f}s", flush=True)
        print(f"[selfhost] aot prepare: {aot_prepare_s:.2f}s", flush=True)
        print(f"[selfhost] clang compile: {clang_compile_s:.2f}s", flush=True)
        print(f"[selfhost] clang link: {clang_link_s:.2f}s", flush=True)
        return used_ir_dir, module_names

    out_path1 = args.out
    aot_dir1, module_names1 = _build_once(
        seed_bin=seed, out_path=out_path1, pass_name="stage2")
    subprocess.run([str(out_path1), "--version"],
                   cwd=str(REPO_ROOT), check=True)

    if args.fixed_point:
        _check_budget()
        out_path2 = args.out.with_name(args.out.name + "-fp2")
        aot_dir2, module_names2 = _build_once(
            seed_bin=out_path1, out_path=out_path2, pass_name="stage2_fp2")
        subprocess.run([str(out_path2), "--version"],
                       cwd=str(REPO_ROOT), check=True)

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
