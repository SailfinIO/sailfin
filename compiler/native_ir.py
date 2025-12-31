"""Bootstrap shim for stage1-generated Python modules.

The stage1 compiler emits Python under `compiler/build/` and some submodules use
relative imports that resolve to `compiler.native_ir`.

This file re-exports the generated implementation from `compiler.build.native_ir`.
"""

from compiler.build.native_ir import *  # noqa: F401,F403
