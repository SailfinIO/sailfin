#!/usr/bin/env python3
"""
Enhanced test harness: tests all .sfn example files across different directories.
Prefers self-hosting compiler when available, falls back to bootstrap.
"""
import os
import sys
import glob
import subprocess
import argparse
from typing import List, Dict, Tuple


def find_compiler() -> Tuple[str, str]:
    """Find the best available Sailfin compiler. Returns (compiler_path, compiler_type)."""
    repo_root = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))

    # Check for self-hosting compiler first
    selfhost_binary = os.path.join(repo_root, "build", "sfn")
    if os.path.exists(selfhost_binary) and os.access(selfhost_binary, os.X_OK):
        return selfhost_binary, "self-hosting"

    # Fall back to bootstrap compiler
    bootstrap_script = os.path.join(repo_root, "bootstrap", "bootstrap.py")
    if os.path.exists(bootstrap_script):
        return bootstrap_script, "bootstrap"

    raise FileNotFoundError(
        "No Sailfin compiler found (checked self-hosting and bootstrap)")


def run_example_selfhosting(compiler_path: str, example_file: str) -> Tuple[bool, str, str]:
    """Runs self-hosting sfn binary on a single example file."""
    env = os.environ.copy()
    env['SAILFIN_TEST_MODE'] = '1'  # Enable test mode for server examples

    proc = subprocess.run(
        [compiler_path, example_file],
        capture_output=True,
        text=True,
        env=env
    )
    return proc.returncode == 0, proc.stdout, proc.stderr


def run_example_bootstrap(bootstrap_path: str, example_file: str) -> Tuple[bool, str, str]:
    """Runs bootstrap.py on a single example file."""
    env = os.environ.copy()
    env['SAILFIN_TEST_MODE'] = '1'  # Enable test mode for server examples

    proc = subprocess.run(
        [sys.executable, bootstrap_path, example_file],
        capture_output=True,
        text=True,
        env=env
    )
    return proc.returncode == 0, proc.stdout, proc.stderr


def run_example(compiler_path: str, compiler_type: str, example_file: str) -> Tuple[bool, str, str]:
    """Runs the appropriate compiler on a single example file."""
    if compiler_type == "self-hosting":
        return run_example_selfhosting(compiler_path, example_file)
    elif compiler_type == "bootstrap":
        return run_example_bootstrap(compiler_path, example_file)
    else:
        raise ValueError(f"Unknown compiler type: {compiler_type}")


def test_directory(compiler_path: str, compiler_type: str, examples_dir: str, quiet: bool = False) -> Dict[str, any]:
    """Test all examples in a directory and return results."""
    # Find all .sfn files recursively
    pattern = os.path.join(examples_dir, "**", "*.sfn")
    sfn_files = glob.glob(pattern, recursive=True)

    if not sfn_files:
        return {
            'directory': examples_dir,
            'total': 0,
            'passed': 0,
            'failed': 0,
            'files': [],
            'failures': []
        }

    passed = []
    failed = []

    for f in sorted(sfn_files):
        success, stdout, stderr = run_example(compiler_path, compiler_type, f)
        filename = os.path.relpath(f, examples_dir)

        if success:
            passed.append(filename)
            if not quiet:
                print(f"✓ {filename}")
        else:
            failed.append({
                'file': filename,
                'stdout': stdout,
                'stderr': stderr
            })
            if not quiet:
                print(f"✗ {filename}")

    return {
        'directory': os.path.basename(examples_dir),
        'total': len(sfn_files),
        'passed': len(passed),
        'failed': len(failed),
        'files': passed,
        'failures': failed
    }


def main():
    parser = argparse.ArgumentParser(
        description='Test Sailfin examples with self-hosting compiler (or bootstrap fallback)')
    parser.add_argument('--dir', '-d',
                        help='Test only specific directory (e.g., "basics", "advanced")')
    parser.add_argument('--ci', action='store_true',
                        help='CI mode: exit 0 only if all working directories pass (ignore unimplemented features)')
    parser.add_argument('--strict', action='store_true',
                        help='Strict mode: exit 0 only if ALL examples pass')
    parser.add_argument('--quiet', '-q', action='store_true',
                        help='Quiet mode: only show summary')
    parser.add_argument('--force-bootstrap', action='store_true',
                        help='Force use of bootstrap compiler even if self-hosting is available')

    args = parser.parse_args()

    # Find the best available compiler
    try:
        if args.force_bootstrap:
            repo_root = os.path.abspath(
                os.path.join(os.path.dirname(__file__), ".."))
            bootstrap_script = os.path.join(
                repo_root, "bootstrap", "bootstrap.py")
            if not os.path.exists(bootstrap_script):
                print("❌ Bootstrap compiler not found")
                sys.exit(1)
            compiler_path, compiler_type = bootstrap_script, "bootstrap"
        else:
            compiler_path, compiler_type = find_compiler()
    except FileNotFoundError as e:
        print(f"❌ {e}")
        sys.exit(1)

    # Locate examples directory
    repo_root = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
    examples_root = os.path.join(repo_root, "examples")

    # Find example directories to test
    if args.dir:
        # Test specific directory
        target_dir = os.path.join(examples_root, args.dir)
        if not os.path.isdir(target_dir):
            print(f"❌ Directory not found: {target_dir}")
            sys.exit(1)
        example_dirs = [target_dir]
    else:
        # Find all example subdirectories
        example_dirs = []
        for item in os.listdir(examples_root):
            full_path = os.path.join(examples_root, item)
            if os.path.isdir(full_path) and item != '__pycache__':
                example_dirs.append(full_path)

    if not example_dirs:
        print("No example directories found.")
        sys.exit(1)

    if not args.quiet:
        compiler_name = "🚢 Self-Hosting Compiler (sfn)" if compiler_type == "self-hosting" else "🐍 Bootstrap Compiler (Python)"
        print(f"🚀 Testing Sailfin Examples with {compiler_name}")
        if args.dir:
            print(f"   Directory: {args.dir}")
        print("=" * 60)

    all_results = []
    total_files = 0
    total_passed = 0
    total_failed = 0

    for examples_dir in sorted(example_dirs):
        dir_name = os.path.basename(examples_dir)
        if not args.quiet:
            print(f"\n📁 Testing {dir_name}/")
            print("-" * 30)

        results = test_directory(
            compiler_path, compiler_type, examples_dir, args.quiet)
        all_results.append(results)

        total_files += results['total']
        total_passed += results['passed']
        total_failed += results['failed']

        if not args.quiet:
            if results['total'] == 0:
                print(f"   No .sfn files found")
            else:
                print(f"   {results['passed']}/{results['total']} passed")

    print("\n" + "=" * 60)
    print("📊 SUMMARY")
    print("=" * 60)
    compiler_name = "🚢 Self-Hosting Compiler (sfn)" if compiler_type == "self-hosting" else "🐍 Bootstrap Compiler (Python)"
    print(f"Compiler: {compiler_name}")
    print("-" * 60)

    for result in all_results:
        if result['total'] > 0:
            percentage = (result['passed'] / result['total']) * 100
            status = "✅" if result['failed'] == 0 else "⚠️" if result['passed'] > result['failed'] else "❌"
            print(
                f"{status} {result['directory']:20} {result['passed']:3d}/{result['total']:3d} ({percentage:5.1f}%)")

    print(
        f"\n🎯 OVERALL: {total_passed}/{total_files} examples passing ({(total_passed/total_files)*100 if total_files > 0 else 0:.1f}%)")

    # Show failures for directories that have some working examples
    print(f"\n🔍 ANALYSIS")
    print("-" * 30)

    working_dirs = [r for r in all_results if r['failed']
                    == 0 and r['total'] > 0]
    partial_dirs = [r for r in all_results if r['failed']
                    > 0 and r['passed'] > 0]
    broken_dirs = [r for r in all_results if r['passed']
                   == 0 and r['total'] > 0]

    if working_dirs:
        print(
            f"✅ Fully implemented: {', '.join([r['directory'] for r in working_dirs])}")

    if partial_dirs:
        print(
            f"⚠️  Partially implemented: {', '.join([r['directory'] for r in partial_dirs])}")

    if broken_dirs:
        print(
            f"❌ Not yet implemented: {', '.join([r['directory'] for r in broken_dirs])}")

    # Exit with appropriate code
    if total_failed == 0:
        print(f"\n🎉 All {total_files} examples are working!")
        if compiler_type == "self-hosting":
            print("✅ Self-hosting compilation successful - Sailfin can compile itself!")
        sys.exit(0)
    else:
        print(f"\n🚧 {total_failed} examples need syntax/feature implementation")
        if compiler_type == "self-hosting":
            print(
                "ℹ️  Note: Using self-hosting compiler - consider testing with --force-bootstrap to compare")
        sys.exit(1)


if __name__ == "__main__":
    main()
