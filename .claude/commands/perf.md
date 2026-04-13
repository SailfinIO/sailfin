# Performance Work Workflow

Drive a performance improvement from baseline measurement through verified speedup. Designed to leave concrete numbers in the PR so the win is undeniable.

## Target: $ARGUMENTS

The argument can be:
- A specific bottleneck (e.g., "extend_string_lines O(n²) in lowering_io.sfn")
- An issue number (e.g., `#142`)
- A subsystem (e.g., "import resolution")
- Empty — let the seed-stabilizer find the next bottleneck

---

## Phase 1: BASELINE

Capture the current performance profile **before any changes**:

```bash
ulimit -v 8388608 && make bench 2>&1 | tee build/bench-baseline.txt
```

Record:
- Total build time (wall clock)
- Per-module time for the slowest 10 modules
- Per-module peak RSS for the heaviest 10 modules
- Any module-specific metrics from the issue

If the target is a hot path that's not directly visible in `make bench`, write a focused micro-benchmark — a small `.sfn` file that exercises the path heavily — and time it:

```bash
ulimit -v 8388608 && /usr/bin/time -v build/native/sailfin emit native /tmp/bench_hotpath.sfn 2>&1 | tee build/bench-baseline-hotpath.txt
```

Save the baseline numbers in a comment for later comparison.

---

## Phase 2: PROFILE (if root cause unclear)

If the bottleneck is named in the issue/argument, skip to Phase 3.

Otherwise, spawn the **seed-stabilizer** agent (Opus). Give it:
- The baseline numbers
- The target subsystem or symptom
- `docs/build-performance.md` as context

The stabilizer identifies the hot path: which functions, which patterns (filesystem IPC, O(n²), import re-parsing, string explosion), and produces a focused fix proposal.

---

## Phase 3: DESIGN (if non-trivial)

If the fix is a one-liner or local change (e.g., swap an O(n²) helper for an O(n) one that already exists), skip to Phase 4.

If the fix is structural — touches multiple files, changes data flow, or introduces caching — spawn the **compiler-architect** agent. Give it:
- The stabilizer's root cause analysis
- The constraint that the change must self-host

The architect produces a step-by-step migration plan where each step independently self-hosts. Present the plan to the user for approval if it touches more than 3 files.

---

## Phase 4: IMPLEMENT

Apply the fix. Keep the change minimal — perf fixes that also refactor are hard to review and easy to revert.

After every meaningful change:
```bash
ulimit -v 8388608 && make compile    # self-hosts
```

If a step breaks self-hosting, stop and diagnose before continuing.

---

## Phase 5: BENCHMARK AFTER

Capture the post-fix profile **with the same methodology as Phase 1**:

```bash
ulimit -v 8388608 && make bench 2>&1 | tee build/bench-after.txt
# plus any micro-benchmark you ran in Phase 1
```

Compute the deltas:

| Metric | Before | After | Δ |
|---|---|---|---|
| Total build wall clock | <X> min | <Y> min | -<Z>% |
| Slowest module wall clock | <X> s | <Y> s | -<Z>% |
| Heaviest module peak RSS | <X> MB | <Y> MB | -<Z>% |
| Hot path micro-bench | <X> s | <Y> s | -<Z>% |

**Acceptance:**
- The improvement must be measurable and significant (>10% on at least one metric)
- No metric may regress by more than 5%
- If results don't show clear improvement, **investigate why before declaring done** — the fix may not have hit the actual hot path

---

## Phase 6: VALIDATE CORRECTNESS

Spawn the **test-runner** agent:

```bash
ulimit -v 8388608 && make test
```

Performance fixes that break tests are net negative. Full suite must pass.

Also run `/check` for the full self-hosting validation:
```bash
ulimit -v 8388608 && make check
```

---

## Phase 7: COMMIT WITH NUMBERS

The commit message and PR body **must include the before/after numbers**. This is non-negotiable — perf wins without numbers can't be defended in review and can't be tracked over time.

```
perf: <subsystem> — <one-line summary of fix>

Before: <key metric>
After:  <key metric>
Delta:  -<X>%

<short explanation of root cause and fix>

<full benchmark table>

Closes #<N>
```

---

## Constraints

- **Always benchmark before AND after.** No exceptions. A perf claim without numbers is a guess.
- **Keep the change minimal.** Don't bundle refactoring with a perf fix.
- **Self-hosting wins.** If a faster compiler can't compile itself, it isn't faster.
- **Watch RSS, not just time.** Memory pressure cascades — a fix that halves time but doubles RSS often regresses overall.
- **Always apply `ulimit -v 8388608`** before running the compiler.
