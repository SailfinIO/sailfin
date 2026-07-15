# Controlled-learnability packets

These versioned packets implement Track B of `../PROTOCOL-V2.md`.

- `sailfin-b/packet.md` teaches the frozen task-relevant Sailfin subset.
- `rill-17/packet.md` teaches a nonce surface dialect over exactly that subset.
- Each arm's `expanded-examples.md` and `local-primitive.md` are matched,
  secondary-only SFN-364 ablation supplements. They never alter the frozen
  primary packet condition.

Rill-17 is an experimental unfamiliar-language control, not a product or
competitor. `../rill17.sfn` performs a lexical, semantics-preserving surface
translation into Sailfin. It adds no primitive, conversion, default, library,
or authority and uses the same task starters, hidden cases, known-good and
known-bad audits, compiler/runtime, and graders as Sailfin-B.

Each packet has six worked examples plus a machine-readable `[covers:...]`
index. The runner fails before scored execution if a required marker is absent,
the prose or example budget is outside the frozen limits, or the two arms differ
by more than 5% under the repository's tokenizer-normalized estimate. Exact
provider input-token usage remains recorded per attempt; unavoidable
provider-tokenizer differences are therefore visible in run artifacts rather
than hidden by irrelevant padding.

Packet validation also requires both supplement pairs and enforces the same 5%
matched-arm band. `run.json` records their hashes, while `schedule.json` records
the seeded paired treatment assignment.
