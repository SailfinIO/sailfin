---
title: "§9 String Interpolation"
description: "Sailfin language specification — String Interpolation."
sidebar:
  order: 9
  label: "§9 String Interpolation"
---

```sfn
let name = "Sailfin";
let greeting = "Hello, {{ name }}!";         // "Hello, Sailfin!"
let math = "2 + 2 = {{ 2 + 2 }}";           // "2 + 2 = 4"
let nested = "User: {{ user.name.trim() }}"; // arbitrary expressions
```

Mandatory double braces. Whitespace at the edges is ignored: `{{name}}` and
`{{ name }}` are equivalent. The compiler lowers interpolated strings into
segment arrays evaluated at runtime.
