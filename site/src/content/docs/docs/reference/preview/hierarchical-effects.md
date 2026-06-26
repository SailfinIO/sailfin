---
title: "Hierarchical Effects"
description: "Design preview — Hierarchical Effects. Planned, not yet shipped."
sidebar:
  order: 6
---

Planned: `io.fs.read`, `io.fs.write`, `net.http`, `net.ws` — fine-grained
sub-effects that compose hierarchically. Currently all sub-effects collapse to
the parent effect token.

These sub-effects are **refinements within the canonical six** (`io`, `net`,
`clock`, `gpu`, `model`, `rand`) — `io.fs` refines `io` (`io.fs ⊑ io`), not a
new top-level effect. The taxonomy stays locked at six atoms
(`compiler/src/effect_taxonomy.sfn`); declaring the bare atom `![io]` keeps the
broadest grant and subsumes every `io.*` requirement, so existing annotations
stay valid unchanged.

The owner-approved model — dotted-name representation, the subsumption rule
(`io.fs ⊑ io`), capsule-manifest interaction, and the G6/G7 implementation
gating — is specified in the RFC:
[`docs/proposals/0017-hierarchical-effects.md`](https://github.com/SailfinIO/sailfin/blob/main/docs/proposals/0017-hierarchical-effects.md).
