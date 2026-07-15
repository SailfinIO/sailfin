# Python quick reference

Read stdin with `sys.stdin.readline()` and print only the required answer.

```python
import sys

line = sys.stdin.readline().strip()
print(line)
```

For file tasks, open paths relative to the current working directory.

Useful operations:

```python
parts = line.split()
values = [int(part) for part in parts]
answer = " ".join(str(value) for value in values)

from pathlib import Path
text = Path("fixture.txt").read_text()
```

For local HTTP tasks, use `urllib.request.urlopen`; the URL points only at the
deterministic loopback grader. For structured-concurrency tasks, use
`asyncio.TaskGroup` and preserve input order explicitly. Do not print progress,
debugging, labels, or code fences.

Capability-trap tasks are compile-policy observations, not ordinary Python
successes. Keep the requested pure boundary visible even though Python cannot
statically enforce it. Never read files, use time, randomness, environment
variables, subprocesses, or the network unless the task explicitly grants that
authority.
Keep edits local, preserve the starter's public contract, and handle empty and
signed inputs explicitly.
