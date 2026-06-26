When a Sailfin change depends on a compiler-source capability that must be
present in the **pinned seed**, the decision is always the same: **bundle the
capability with its single consumer by default; split only when the capability
has multiple consumers or is genuinely independent.** This rule is the single
source of truth for that decision — `/groom`, `/pickup`, and any future agent
cite it instead of restating the tree. Design record: SFEP-0026
(`docs/proposals/0026-delivery-process.md`) WS-B.

## Why bundling is the default — the seed-cut tax

`make compile` self-hosts against the binary pinned by `.seed-version`, not
against `main`. So a compiler-source capability (lowering / parsing / typecheck /
intrinsic / runtime-prelude change that alters the compiler binary's behaviour)
that lands in a **separate** PR from its consumer cannot self-host until that
capability is in the **pinned seed** — forcing a seed cut + `/pin-seed` between
the two merges.

Bundling the capability and its consumer in **one PR avoids the seed cut
entirely**: `make compile` builds the new compiler from the *old* seed, and that
freshly-built compiler then compiles the consumer that uses the new capability —
all in one self-host pass. **Splitting a capability away from its only consumer
actively manufactures a release cycle that bundling would not need.**

## The decision tree

```
A seed dependency is discovered (groom-time or mid-pickup):
│
├─ Is the dependency a compiler-source capability (lowering / parse /
│  typecheck / intrinsic / runtime-prelude) that the consumer needs
│  present in the *pinned seed*?
│     └─ No  → not a seed dependency. Normal `## Blocked by`. Done.
│     └─ Yes ↓
│
├─ How many consumers need this capability?
│     ├─ Exactly one, tightly coupled, same session
│     │     → BUNDLE: one PR lands capability + consumer together.
│     │       `make compile` builds the new compiler from the old seed;
│     │       that compiler compiles the consumer in the same self-host
│     │       pass → NO seed cut, NO `/pin-seed`. (Default.)
│     └─ Multiple consumers, OR genuinely independent, OR large blast
│        radius → SPLIT: file the capability as a standalone predecessor
│        with `seed-blocker`; the consumer carries
│        `## Required in pinned seed: #<predecessor>`.
│             └─ The split now REQUIRES a seed cut. Do NOT cut reactively —
│                QUEUE it against the next scheduled cadence seed bump.
│                Mid-pickup: pause and present the bundle-vs-split tradeoff
│                to the user (per pickup.md), defaulting to bundle.
```

## How each agent applies it

- **`/groom`** — apply the tree at decomposition time. For a capability with
  exactly one tightly-coupled consumer worked in the same session, produce **one
  issue** (one PR), not two. Any split that creates a seed-cut gate for a single
  consumer must be **explicitly justified** in the issue body. When you do split,
  label the predecessor `seed-blocker`, give the consumer
  `## Required in pinned seed: #<predecessor>`, and note the queued seed bump.

- **`/pickup`** — when a seed need surfaces **mid-flight** (the issue's premise
  that there was "no frontend dependency" turns out false — the #1088 failure
  mode), walk the same tree. **Pause and present the bundle-vs-split tradeoff to
  the user, defaulting to bundle.** Do not silently fan out into a
  predecessor-issue → groom → separate-PR → seed-cut → re-pickup chain when one
  cohesive PR would deliver the same result.

## Split-forced seed cuts queue against the cadence

A split that forces a seed cut **does not trigger a reactive cut**. The
predecessor lands with `seed-blocker`; the seed advance is **batched onto the
next scheduled cadence seed bump** (SFEP-0026 WS-C). The `seed-cut-advisor.yml`
workflow surfaces "this merged PR is required-in-seed by an open downstream
issue" via the `needs-seed-cut` label — that flag means **queued for the next
cadence bump**, not "cut now."

**The only thing that breaks the batch** is a *release-critical* seed need: one
that unblocks an item on the current release hard gate, has no bundle path, and
would slip the train's committed scope if it waited. A miscompilation or seed-bug
that breaks *active* downstream work clears that bar by construction. Everything
else queues. The full release-critical bar is SFEP-0026 §3.3.
