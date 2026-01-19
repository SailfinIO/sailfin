#!/usr/bin/env python3

from __future__ import annotations

import argparse
import datetime
import os
import pathlib
import shutil
import subprocess
import sys
import textwrap
from typing import TextIO

REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]
DEFAULT_SEED = REPO_ROOT / "build/native/sailfin"
DEFAULT_OUT = REPO_ROOT / "build/native/sailfin-selfhost"


def _utc_timestamp() -> str:
    return datetime.datetime.now(datetime.UTC).strftime("%Y%m%dT%H%M%SZ")


def _ensure_dir(p: pathlib.Path) -> None:
    p.mkdir(parents=True, exist_ok=True)


def _stream_process(cmd: list[str], *, cwd: pathlib.Path | None, env: dict[str, str], log_path: pathlib.Path) -> int:
    _ensure_dir(log_path.parent)
    with log_path.open("w", encoding="utf-8") as log:
        log.write("$ " + " ".join(cmd) + "\n")
        log.flush()

        proc = subprocess.Popen(
            cmd,
            cwd=str(cwd) if cwd is not None else None,
            env=env,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            bufsize=1,
        )
        assert proc.stdout is not None
        for line in proc.stdout:
            sys.stdout.write(line)
            log.write(line)
        return int(proc.wait())


def _run_checked(cmd: list[str], *, cwd: pathlib.Path | None, env: dict[str, str], log_path: pathlib.Path) -> None:
    rc = _stream_process(cmd, cwd=cwd, env=env, log_path=log_path)
    if rc != 0:
        raise SystemExit(
            f"selfhost-smoke: command failed (exit {rc}): {' '.join(cmd)}\nlog: {log_path}")

    # Treat this as a hard failure: it indicates memory/layout corruption.
    try:
        log_text = log_path.read_text(encoding="utf-8", errors="replace")
    except OSError:
        log_text = ""
    if "string_concat: unterminated input" in log_text:
        raise SystemExit(
            "selfhost-smoke: detected runtime corruption warning in logs: "
            f"{log_path}\n"
            "(string_concat: unterminated input...)"
        )


def _default_env() -> dict[str, str]:
    env = dict(os.environ)

    # Reduce sources of nondeterminism in Python tooling.
    env.setdefault("PYTHONHASHSEED", "0")

    # Reduce locale-related surprises.
    env.setdefault("LC_ALL", "C")
    env.setdefault("LANG", "C")
    env.setdefault("TZ", "UTC")

    # Repro build hint used by many toolchains.
    env.setdefault("SOURCE_DATE_EPOCH", "1")

    return env


def main(argv: list[str]) -> int:
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter,
        description=textwrap.dedent(
            """\
            Self-host Stage2 and run a minimal smoke test.

            This is intended to be a fast, high-signal check that:
              1) we can rebuild the native stage2 compiler from a seed, and
              2) the resulting compiler can compile + run hello-world.

            It writes logs and intermediates under --work-dir.
            """
        ),
    )

    parser.add_argument(
        "--seed",
        type=pathlib.Path,
        default=DEFAULT_SEED,
        help=f"Path to seed stage2 compiler (default: {DEFAULT_SEED})",
    )
    parser.add_argument(
        "--out",
        type=pathlib.Path,
        default=DEFAULT_OUT,
        help=f"Output path for the rebuilt compiler (default: {DEFAULT_OUT})",
    )
    parser.add_argument(
        "--work-dir",
        type=pathlib.Path,
        default=REPO_ROOT / "build" / "selfhost_smoke" / _utc_timestamp(),
        help="Work directory for logs/artifacts (default: build/selfhost_smoke/<timestamp>)",
    )
    parser.add_argument(
        "--keep-work-dir",
        action="store_true",
        help="Do not delete the work directory on success",
    )

    # Default to sequential selfhost because this is a reliability harness.
    parser.add_argument("--jobs", type=int, default=1)
    parser.add_argument("--import-context-jobs", type=int, default=1)
    parser.add_argument("--max-attempts", type=int, default=10)
    parser.add_argument("--seed-timeout", type=float, default=300.0)
    parser.add_argument("--max-total-seconds", type=float, default=1800.0)

    args = parser.parse_args(argv)

    seed = args.seed.resolve()
    out = args.out.resolve()
    work_dir = args.work_dir.resolve()

    if not seed.exists():
        raise SystemExit(f"selfhost-smoke: seed does not exist: {seed}")

    env = _default_env()

    # Keep smoke runs isolated from whatever might be sitting in build/.
    _ensure_dir(work_dir)
    logs_dir = work_dir / "logs"

    print(f"[selfhost-smoke] seed: {seed}")
    print(f"[selfhost-smoke] out:  {out}")
    print(f"[selfhost-smoke] work: {work_dir}")

    success = False
    try:
        _run_checked(
            [
                sys.executable,
                str(REPO_ROOT / "scripts/selfhost_native.py"),
                "--seed",
                str(seed),
                "--no-prefer-asan-seed",
                "--work-dir",
                str(work_dir / "selfhost"),
                "--jobs",
                str(args.jobs),
                "--import-context-jobs",
                str(args.import_context_jobs),
                "--max-attempts",
                str(args.max_attempts),
                "--seed-timeout",
                str(args.seed_timeout),
                "--max-total-seconds",
                str(args.max_total_seconds),
                "--out",
                str(out),
            ],
            cwd=REPO_ROOT,
            env=env,
            log_path=logs_dir / "selfhost_build.log",
        )

        # Sanity check the output binary exists.
        if not out.exists():
            raise SystemExit(
                f"selfhost-smoke: expected output compiler missing: {out}")

        # Run a tiny compilation+execution check.
        hello = REPO_ROOT / "examples/basics/hello-world.sfn"
        _run_checked(
            [str(out), "version"],
            cwd=REPO_ROOT,
            env=env,
            log_path=logs_dir / "stage2_version.log",
        )

        hello_env = dict(env)
        # Only emits output when a suspicious identifier payload is observed.
        hello_env["SAILFIN_DEBUG_IDENTIFIER_VALIDATION"] = "1"
        _run_checked(
            [str(out), "run", str(hello)],
            cwd=REPO_ROOT,
            env=hello_env,
            log_path=logs_dir / "hello_world_run.log",
        )

        # Emit LLVM into the work directory so it doesn't pollute the repo.
        emit_ll = work_dir / "hello-world.ll"
        if emit_ll.exists():
            emit_ll.unlink()
        _run_checked(
            [str(out), "emit-llvm-file", str(hello), str(emit_ll)],
            cwd=REPO_ROOT,
            env=env,
            log_path=logs_dir / "hello_world_emit_llvm_file.log",
        )
        if not emit_ll.exists() or emit_ll.stat().st_size == 0:
            raise SystemExit(
                f"selfhost-smoke: emit-llvm-file did not produce output: {emit_ll}")

        print("[selfhost-smoke] OK")
        success = True
        return 0
    finally:
        if success and not args.keep_work_dir:
            shutil.rmtree(work_dir, ignore_errors=True)


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
