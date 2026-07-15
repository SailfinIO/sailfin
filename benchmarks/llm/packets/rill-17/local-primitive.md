# Documented local primitive

In the local-implementation treatment, `span` is unavailable. Copy this packet-defined implementation into the solution and call `local_slice` wherever a half-open glyph slice is needed.

```rill17
craft local_slice(text: glyphs, start: whole, end: whole) -> glyphs {
    bind flux out = "";
    bind flux i = start;
    cycle {
        when i >= end { halt; }
        out = out + text[i];
        i += 1;
    }
    yield out;
}
```
