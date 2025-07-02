#!/usr/bin/env python3
"""
Test harness: iterates over all .sfn example files and invokes the bootstrap compiler to ensure syntactic correctness.
"""
import os
import sys
import glob
import subprocess


def run_example(path_to_bootstrap, example_file):
    """Runs bootstrap.py on a single example file."""
    proc = subprocess.run(
        [sys.executable, path_to_bootstrap, example_file],
        capture_output=True,
        text=True
    )
    if proc.returncode != 0:
        # Report failure for this example
        print(f"=== FAIL: {example_file} ===")
        print(proc.stdout)
        print(proc.stderr)
        return False
    else:
        print(f"PASS: {example_file}")
        return True


def main():
    # Locate bootstrap script and examples directory
    repo_root = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
    bootstrap_script = os.path.join(repo_root, "bootstrap", "bootstrap.py")
    examples_dir = os.path.join(repo_root, "examples")

    # Find all .sfn files recursively
    pattern = os.path.join(examples_dir, "**", "*.sfn")
    sfn_files = glob.glob(pattern, recursive=True)

    if not sfn_files:
        print("No .sfn example files found.")
        sys.exit(1)

    failures = []
    for f in sorted(sfn_files):
        ok = run_example(bootstrap_script, f)
        if not ok:
            failures.append(f)

    if failures:
        # Summary of failures
        print(f"{len(failures)} example(s) failed to compile/test.")
        sys.exit(1)
    else:
        print("All examples compiled and ran successfully.")


if __name__ == "__main__":
    main()
