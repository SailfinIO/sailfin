---
title: "Unsafe Enforcement"
description: "Design preview — Unsafe Enforcement. Planned, not yet shipped."
sidebar:
  order: 8
---

`unsafe` and `extern` syntax is parsed today but the unsafe capability is not
enforced — unsafe blocks outside `![unsafe]` functions are not rejected.
Full enforcement arrives with the native runtime.
