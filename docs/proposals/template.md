---
sfep: TBD
title: <Concise title>
status: Draft
type: language            # language | runtime | tooling | process | informational
created: YYYY-MM-DD
updated: YYYY-MM-DD
author: "agent:<role>; human review"   # record who/what drafted it (see SFEP-0001 §7)
tracking:                 # related issue/epic numbers, e.g. "#1234"
supersedes:               # SFEP-N this replaces, if any
superseded-by:            # SFEP-N that replaced this, if any
graduates-to:             # spec/preview path once it ships, e.g. reference/preview/foo.md
---

# SFEP-XXXX — <Title>

> Copy this file to `draft-<slug>.md` (or `NNNN-<slug>.md` once a number is
> claimed), fill in every section below, and open a PR. See
> [`0001-sfep-process.md`](./0001-sfep-process.md) for the full process. All
> sections are required; an incomplete proposal stays `Draft`.

## 1. Summary

One paragraph: what changes, and why it matters.

## 2. Motivation

The problem. Who hits it, how often, and why the status quo is insufficient.
Include concrete examples or failing cases where possible.

## 3. Design

The concrete proposal — syntax, semantics, APIs, data shapes — with worked
examples. Be specific enough that an implementer could start from this section.

```sfn
// Illustrative example
```

## 4. Effect & capability impact

How this interacts with the effect system (`![io, net, ...]`) and capability
enforcement. If there is no interaction, say so explicitly.

## 5. Self-hosting impact

Which compiler passes change (lexer → parser → AST → typecheck → effects →
emitter → LLVM lowering), and how the self-hosting invariant is preserved. See
`.claude/rules/selfhost-invariant.md`.

## 6. Alternatives considered

The options weighed and why they lost. (A proposal with no alternatives is not
ready for review.)

## 7. Stage1 readiness mapping

Track each item from the `CLAUDE.md` Stage1 Readiness Checklist:

- [ ] Parses
- [ ] Type-checks / effect-checks
- [ ] Emits valid `.sfn-asm`
- [ ] Lowers to LLVM IR
- [ ] Regression coverage
- [ ] Self-hosts
- [ ] `sfn fmt --check` clean
- [ ] Documented in `docs/status.md` + spec

## 8. Test plan

The regression tests that will prove this works (`compiler/tests/{unit,integration,e2e}/`).

## 9. References

Issues/epics, related SFEPs, spec/preview chapters, and any prior art.
