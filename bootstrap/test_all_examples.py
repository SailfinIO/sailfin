#!/usr/bin/env python3
"""
Enhanced test harness: tests all .sfn example files across different directories 
and provides a summary of which directories/features are working vs. not yet implemented.
"""
import os
import sys
import glob
import subprocess
from typing import List, Dict, Tuple


def run_example(path_to_bootstrap: str, example_file: str) -> Tuple[bool, str, str]:
    """Runs bootstrap.py on a single example file and returns success status with output."""
    proc = subprocess.run(
        [sys.executable, path_to_bootstrap, example_file],
        capture_output=True,
        text=True
    )
    return proc.returncode == 0, proc.stdout, proc.stderr


def test_directory(bootstrap_script: str, examples_dir: str) -> Dict[str, any]:
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
        success, stdout, stderr = run_example(bootstrap_script, f)
        filename = os.path.relpath(f, examples_dir)

        if success:
            passed.append(filename)
            print(f"✓ {filename}")
        else:
            failed.append({
                'file': filename,
                'stdout': stdout,
                'stderr': stderr
            })
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
    # Locate bootstrap script and examples directory
    repo_root = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
    bootstrap_script = os.path.join(repo_root, "bootstrap", "bootstrap.py")
    examples_root = os.path.join(repo_root, "examples")

    # Find all example subdirectories
    example_dirs = []
    for item in os.listdir(examples_root):
        full_path = os.path.join(examples_root, item)
        if os.path.isdir(full_path) and item != '__pycache__':
            example_dirs.append(full_path)

    if not example_dirs:
        print("No example directories found.")
        sys.exit(1)

    print("🚀 Testing Sailfin Examples")
    print("=" * 50)

    all_results = []
    total_files = 0
    total_passed = 0
    total_failed = 0

    for examples_dir in sorted(example_dirs):
        dir_name = os.path.basename(examples_dir)
        print(f"\n📁 Testing {dir_name}/")
        print("-" * 30)

        results = test_directory(bootstrap_script, examples_dir)
        all_results.append(results)

        total_files += results['total']
        total_passed += results['passed']
        total_failed += results['failed']

        if results['total'] == 0:
            print(f"   No .sfn files found")
        else:
            print(f"   {results['passed']}/{results['total']} passed")

    print("\n" + "=" * 50)
    print("📊 SUMMARY")
    print("=" * 50)

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
        sys.exit(0)
    else:
        print(f"\n🚧 {total_failed} examples need syntax/feature implementation")
        sys.exit(1)


if __name__ == "__main__":
    main()
