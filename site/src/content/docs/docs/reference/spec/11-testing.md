---
title: "§11 Testing"
description: "Sailfin language specification — Testing."
sidebar:
  order: 11
  label: "§11 Testing"
---

```sfn
test "name" ![effects] {
    assert expression;
    assert actual == expected;
}
```

- `test` is a first-class keyword — no external framework needed
- Effects are declared just like on functions
- Test files are named `*_test.sfn` and discovered automatically by `sfn test`
- `assert expr;` is a statement form (no parens) and fails with the expression text

---
