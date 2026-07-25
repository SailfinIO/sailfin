# SFN-502 — Widening-multiply scope decision

> Single-issue design note (no SFEP number). Records whether Sailfin needs a
> `64 × 64 → 128` multiplication capability for the native-crypto path and,
> if it is revisited, which design boundary should own it. Design context:
> SFEP-0048 §§6.4 and 7; SFEP-0058 §3; SFN-500's X25519 limb-strategy gate.

## 1. Decision

**Not needed: do not add widening multiply to SFEP-0058 and do not file a
standalone SFEP now.** The only concrete 1.0 consumer was X25519. SFN-500
returned **VIABLE** for 16 limbs × 16 bits, and that implementation has since
shipped without sized integers, unsigned semantics, or a widening multiply.
The proof and its `2^45.80` worst-case intermediate bound are recorded in
[`sfn-335-x25519-limb-strategy.md`](./sfn-335-x25519-limb-strategy.md) §§1–3.

The remaining motivation is a possible post-1.0 performance optimization:
51-bit Curve25519 limbs could reduce multiplication work relative to the
shipped 16-limb representation. A prospective optimization with no measured
requirement is not enough to reserve language surface or start a backend SFEP.
This closes the unowned dependency rather than silently deferring it.

## 2. Why it does not belong in SFEP-0058

SFEP-0058 completes the sign and overflow semantics of the existing
`{i,u}{8,16,32,64}` family. A widening multiply is a distinct operation whose
result cannot be represented by that family as one scalar. Absorbing it would
couple a backend/intrinsic design to a type-system proposal without a current
consumer, while adding neither `i128` nor `u128` to SFEP-0058.

The native-crypto blocker was the only reason to review both capabilities
together. SFN-500 removed that blocker, so shared reviewers and numeric
substrate are no longer sufficient reasons to combine their scopes.

## 3. Shape if evidence reopens the capability

If profiling establishes a concrete need, begin a **standalone backend-intrinsic
SFEP**. Its preferred starting point is an unsigned operation such as
`mul_wide(u64, u64) -> (u64, u64)`, returning `(hi, lo)`. This is a direction
for future design, not accepted language or library surface.

The pair result preserves both halves while using carriers the compiler already
threads. In contrast, a scalar `u128`/`i128` result would introduce a new type
through the string-typed native IR and the `.sfn-asm` wire format, then require
every parser, verifier, emitter, and lowering pass to preserve it. That blast
radius is unjustified for one prospective optimization. A future proposal must
still settle signed variants, naming and namespace, constant evaluation,
overflow semantics, target support, and lowering before implementation.

## 4. Record corrections

SFEP-0048 §§6.4 and 7 now preserve the original blocker claim as history but
mark it withdrawn: the 16 × 16-bit strategy needs no new compiler capability.
SFEP-0058 keeps widening multiply explicitly out of scope. Those amendments,
together with this note, mean neither proposal implies an outstanding X25519
dependency.

## 5. Reopening criteria

Reopen the question only with a named consumer and measurements showing that
the shipped narrow-limb approach misses an agreed performance target. The new
work should compare a pair-returning intrinsic with software decomposition and
target-specific alternatives, and should treat full 128-bit integers as a
separate choice rather than an assumed prerequisite.
