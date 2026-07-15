# Expanded-example supplement

This supplement is shown only in the expanded-examples ablation. The base packet remains authoritative.

```rill17
craft parse_digit(ch: glyphs) -> whole { yield rune_code(ch) - 48; }
```

```rill17
craft join_two(left: glyphs, right: glyphs) -> glyphs { yield left + ":" + right; }
```

```rill17
craft push_if_present(values: glyphs[], value: glyphs) { when value.length > 0 { values.push(value); } }
```

```rill17
craft ascii_space(ch: glyphs) -> truth { yield ch == " " || ch == "\n" || ch == "\r" || ch == "\t"; }
```

```rill17
craft has_items(parts: glyphs[]) -> truth { yield parts.length > 0; }
```

```rill17
craft main() with[console] { bind value = console.take_line(0); emit(value); }
```
