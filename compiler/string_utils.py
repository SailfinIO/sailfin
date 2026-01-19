"""Bootstrap shim for legacy Python-generated modules.

The legacy Python bootstrap compiler emits modules under `compiler/build/` and
some of those modules use relative imports that resolve to `compiler.string_utils`.

This file intentionally re-exports the generated implementation from
`compiler.build.string_utils`.
"""

from compiler.build.string_utils import *  # noqa: F401,F403
