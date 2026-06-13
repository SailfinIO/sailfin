Porting a runtime symbol from C to Sailfin during the C→Sailfin
migration window (epic #1308 and any `runtime/sfn/**` flip) is **not** a
mechanical rename. The C runtime and the Sailfin runtime are linked into
the **same binary** until `sailfin_runtime.c` / `sailfin_arena.c` are
deleted, so every flip is a link-time symbol-ownership change with
coexistence hazards. Audit every such issue against the checklist below —
at grooming time, and again as a pickup pre-flight — before treating the
Files Affected list or the "just rename it" framing as correct.

## The audit (run for each symbol being flipped)

For symbol `S` (e.g. `sfn_str_concat`, `sfn_arena_alloc`):

1. **Who defines it?** `grep -nE '^[[:space:]]*[A-Za-z_].*S[[:space:]]*\(' runtime/native/src/*.c`
   and `grep -rnE 'fn S[ (]' runtime/sfn`. A bare `sfn_*` that the registry
   emits is frequently **C-defined** with only a `sfn_<mod>_sfn_*` infix
   proof-of-life on the Sailfin side — the "port" is a façade.
2. **Who calls it?** `grep -cE 'S[[:space:]]*\(' runtime/native/src/sailfin_runtime.c`.
   If the C runtime calls `S` internally (count > its definition count),
   `static`-ifying the C copy gives that caller a private static copy
   while emitted code binds to the Sailfin definition — usually fine, but
   never silently delete a C body with live internal callers.
3. **Header collision?** `grep -nw S runtime/native/include/*.h`. If
   `S` is prototyped in a header, `static`-ifying the C definition collides
   with the `extern` prototype — the `.h` must be edited too. **Add both
   `.c` and `.h` to Files Affected.**
4. **Shared-struct layout hazard (the #1205-class landmine)?** If `S`
   reads or writes a struct/handle/header that the *other* runtime also
   reads or writes, the two layouts must be **byte-identical**. The arena
   handle (C `SfnArena` 40 bytes / 5 fields vs Sailfin `Arena` 24 bytes /
   3 fields — #1309) and the array header+canary convention
   (`SailfinPtrArray`, magic/capacity 2-word prefix — #1316) are the known
   cases. A divergent shared layout is a heap-corruption hazard; gate it
   behind an ASAN interleave test (see `.claude/rules/compiler-safety.md`
   for the sanitizer-leg rules). Values passed by value/buffer
   (`i8*`, `SfnString {i8*,i64}`, callbacks) carry **no** layout hazard.
5. **Emitted-ABI match?** Compare the registry row's `return_type` /
   `parameter_types` (`compiler/src/llvm/runtime_helpers.sfn`) against the
   Sailfin body's signature. A mismatch (e.g. registry emits
   `{i8*, i64}` + arena, the infix body returns `OwnedBuf`) is **real
   design work**, not a rename — flag it for an architect decision, since
   changing the emitted ABI ripples into every call site's lowering.

## The three flip mechanisms (classify each symbol)

1. **C defines AND emission targets the bare symbol** → link-ownership
   flip: define in Sailfin, `static`-ify the C body, drop the header
   prototype. Touches `runtime/native/src/sailfin_runtime.c` (+ `.h`) —
   not just the `runtime/sfn/**` file. (string/print/env/arena/array families.)
2. **Emission target ≠ C-internal symbol** (e.g. `sfn_fs_*` is
   Sailfin-only while C uses `sailfin_adapter_fs_*` internally) → clean:
   replace the Sailfin façade body with a real one; no C edit; the C
   symbol retires when the file is deleted (#822). Files Affected is the
   `runtime/sfn/**` file alone.
3. **Additive frontend** (e.g. `extern var`) → no coexistence concern.

## The readiness gate

A runtime-flip issue is correctly scoped only when the relink experiment
would pass: zero the `c-sources`/`ll-sources` in
`runtime/native/capsule.toml`, `make clean-build && make compile`, and
confirm no undefined symbols:

```bash
# symbols the Sailfin-compiled objects still demand:
nm -u build/sailfin/*.o \
  | grep -oE 'sfn_[a-z0-9_]+|sailfin_(runtime|adapter)_[a-z0-9_]+' | sort -u > /tmp/undef.txt
# symbols the C runtime sources define:
grep -rhoE 'sfn_[a-z0-9_]+|sailfin_(runtime|adapter)_[a-z0-9_]+' \
  runtime/native/src/sailfin_runtime.c runtime/native/src/sailfin_arena.c | sort -u > /tmp/cdefs.txt
comm -12 /tmp/undef.txt /tmp/cdefs.txt   # → expected empty
```

Until that intersection is empty, the C runtime is still load-bearing —
"ported to Sailfin" in an audit or a closed issue does **not** mean the C
body is dead. Verify, don't trust the prose.
