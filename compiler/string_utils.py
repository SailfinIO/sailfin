"""Bootstrap shim for stage1-generated Python modules.

The stage1 compiler emits Python under `compiler/build/` and some submodules use
relative imports that resolve to `compiler.string_utils`.

This file re-exports the generated implementation from `compiler.build.string_utils`.
"""

from compiler.build.string_utils import *  # noqa: F401,F403
