# Expanded-example supplement

This supplement is shown only in the expanded-examples ablation. The base packet remains authoritative.

```sailfin
fn parse_digit(ch: string) -> int { return char_code(ch) - 48; }
```

```sailfin
fn join_two(left: string, right: string) -> string { return left + ":" + right; }
```

```sailfin
fn push_if_present(values: string[], value: string) { if value.length > 0 { values.push(value); } }
```

```sailfin
fn ascii_space(ch: string) -> boolean { return ch == " " || ch == "\n" || ch == "\r" || ch == "\t"; }
```

```sailfin
fn has_items(parts: string[]) -> boolean { return parts.length > 0; }
```

```sailfin
fn main() ![io] { let value = io.read_line(0); print(value); }
```
