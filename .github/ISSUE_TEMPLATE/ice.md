---
name: Internal Compiler Error (ICE)
about: The compiler panicked instead of emitting a diagnostic — every ICE is a bug
title: "ICE: <one-line summary from the banner message>"
labels: ["type:bug", "area:compiler"]
assignees: []
---

<!--
The Sailfin compiler is not supposed to panic. Any internal compiler error
(the `internal compiler error (ICE)` banner on stderr) is a bug by
definition — a pass hit a state it should have diagnosed or handled. File
it here so /triage can dedupe it by banner content (SFEP-0037 §3.2).

Paste the banner verbatim — its version, stage, and source lines are what
dedupe keys on. Do not hand-edit them.
-->

## ICE banner

<!-- Paste the full `internal compiler error (ICE): ...` block from stderr,
     including the version / stage / source / file-a-report lines. -->

```text

```

## Repro command

<!-- The exact command that produced the ICE. -->

```bash

```

## Input source

<!-- The `.sfn` source (or a link/attachment) that triggers the panic. Keep
     it as small as you can; a minimized repro goes in the next section. -->

```sfn

```

## Minimized repro

<!-- Optional today; `sfn reduce` (SFEP-0037 §3.5, a future SFEP) will fill
     this automatically once it exists. Until then, leave blank or paste a
     hand-reduced version if you have one. -->

## Environment

- Compiler version (from the banner's `version:` line):
- OS / arch:
