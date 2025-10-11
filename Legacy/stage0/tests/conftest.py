from __future__ import annotations

import pathlib
import sys

# Ensure the repository root is on sys.path when pytest sets rootdir to the
# bootstrap package. This allows imports like `import bootstrap` to resolve.
REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))
