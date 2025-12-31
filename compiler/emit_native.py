"""Bootstrap shim for stage1-generated Python modules.

The stage1 compiler emits Python under `compiler/build/` and some submodules use
relative imports that resolve to `compiler.emit_native`.

This file re-exports the generated implementation from `compiler.build.emit_native`.
"""

from compiler.build.emit_native import *  # noqa: F401,F403
