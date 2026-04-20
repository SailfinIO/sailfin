---
title: "Ownership Enforcement"
description: "Design preview — Ownership Enforcement. Planned, not yet shipped."
sidebar:
  order: 4
---

`Affine<T>` and `Linear<T>` wrappers are parsed today but move/consume rules
are not enforced. `&T`/`&mut T` borrows are parsed but exclusivity is not checked.
Full enforcement is a 1.0 requirement.
