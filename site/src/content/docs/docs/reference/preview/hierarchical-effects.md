---
title: "Hierarchical Effects"
description: "Sub-effect detection and manifest tightening — shipped for four detected families; deeper refinements are incremental."
sidebar:
  order: 6
---

Shipped: `io.fs`, `io.console`, `net.http`, `net.ws` — sub-effects that are
**refinements within the canonical six** (`io`, `net`, `clock`, `gpu`, `model`,
`rand`), not new top-level effects. `io.fs` refines `io` (`io.fs ⊑ io`); the
taxonomy stays locked at six atoms (`compiler/src/effect_taxonomy.sfn`).

The runtime-helper descriptor registry detects effectful builtin calls and
attributes the narrow sub-effect: `fs.*` calls require `io.fs`, `print.*` /
`console.*` calls require `io.console`, `http.*` calls require `net.http`, and
`websocket.*` calls require `net.ws` (`http.download` stays plain `net.http` +
bare `io`). A bare-root grant subsumes every narrow requirement in that root, so
every existing `![io]` / `![net]` annotation stays valid unchanged — detection
is fully backward compatible.

The narrow grant is also enforceable on its own: a function declaring
`![io.fs]` satisfies a detected `fs.*` call, but a sibling function that only
declares `![io.fs]` and calls a `print.*` builtin is rejected with a
missing-effect diagnostic (it needs `![io.console]`). At the capsule boundary,
`[capabilities] required = ["io.fs"]` tightens a capsule to filesystem-only —
a function declaring `![io.console]` inside that capsule is rejected with
`E0403`; `required = ["io"]` continues to authorize all `io.*` sub-effects.

Detection stays conservative: an `io`-effect helper outside the four detected
families (e.g. `env.get`) keeps the bare `io` root, and an unresolved or
dynamic callee yields no guessed sub-effect.

Deeper refinements beyond the four shipped families — e.g. `io.fs.read` /
`io.fs.write` — parse and subsume correctly under the same lattice, but
detection currently attributes only at the family granularity shown above;
finer-grained detection is an incremental follow-up (SFEP-0017 §8).

The full design — dotted-name representation, the subsumption rule
(`io.fs ⊑ io`), capsule-manifest interaction, and the G6/G7 gating — is
specified in the RFC:
[`docs/proposals/0017-hierarchical-effects.md`](https://github.com/SailfinIO/sailfin/blob/main/docs/proposals/0017-hierarchical-effects.md).
