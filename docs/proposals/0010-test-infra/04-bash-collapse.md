# Bash collapse plan

The 38 shell scripts under `compiler/tests/e2e/*.sh` total ~7442 LOC.
The migration target is **3 hold-outs** kept as bash for genuine
cross-language orchestration reasons. Everything else moves to
`*_test.sfn`, mostly via `assert_compiles`, snapshots, and
`process.run_capture`.

## Migration table

| Script | LOC | Target | Migration hook |
|---|---:|---|---|
| `test_arena_default_on.sh` | 160 | Sailfin test | `with_env SAILFIN_USE_ARENA=...` + `process.run_capture` + stderr regex |
| `test_atomic_fence_compile.sh` | 135 | Sailfin test (snapshot) | Compile snippet, snapshot the IR shape |
| `test_atomic_load_store_compile.sh` | 164 | Sailfin test (snapshot) | Same |
| `test_binary_capsule_walker.sh` | 177 | Sailfin test | `fs.read_dir` + `fs.exists` against the staged build tree |
| `test_build_diagnostics_format.sh` | 158 | Sailfin test | `assert_does_not_compile` with diagnostic_pattern |
| `test_build_json_schema.sh` | 208 | Sailfin test | `process.run_capture` + `sfn/json` parse + `expect()` against schema |
| `test_capsule_artifact_sidecar.sh` | 361 | Sailfin test | Build, then `fs.read_dir` + `fs.exists` assertions |
| `test_capsule_build.sh` | 136 | Sailfin test | Same pattern; verifies `build/native/import-context/...` and `build/capsules/.../ir/...` paths |
| `test_capsule_ir_layout.sh` | 272 | Sailfin test (snapshot) | IR layout snapshots |
| `test_check_compiler_src.sh` | 120 | **Stays bash** | Coarse-grained — runs `sfn check` over the whole compiler tree. Move into `Makefile` directly as a target, not a test. |
| `test_check_cross_module_conformance.sh` | 195 | Sailfin test | `assert_compiles` with multi-file fixture |
| `test_check_effect_call_site_caret.sh` | 184 | Sailfin test | Diagnostic-pattern assertion |
| `test_check_json_schema.sh` | 395 | Sailfin test | `sfn/json` schema validator |
| `test_compiler_debug_toggle_env_vars.sh` | 278 | Sailfin test | `with_env` fixture matrix |
| `test_config.sh` | 234 | Sailfin test | `with_env HOME=mktemp` + fs assertions; uses P5 perms helpers |
| `test_drop_emission_function_body.sh` | 111 | Sailfin test (snapshot) | IR snapshot |
| `test_fmt.sh` | 195 | Sailfin test | Round-trip via `process.run_capture` |
| `test_guillermo.sh` | 42 | Sailfin test | Trivial smoke test |
| `test_login.sh` | 128 | Sailfin test | `with_env` + `process.run_capture` |
| `test_numeric_bitwise.sh` | 195 | Sailfin test | Compile + run + stdout assertion |
| `test_numeric_cast.sh` | 297 | Sailfin test | Same |
| `test_numeric_int_float.sh` | 294 | Sailfin test | Same |
| `test_publish.sh` | 445 | **Stays bash, slimmed** | Multi-process curl orchestration against a registry mock. Reduce to ~80 LOC after factoring fixture setup into Sailfin helpers. |
| `test_reexport.sh` | 197 | Sailfin test | Compile + IR check |
| `test_run_cache_flags.sh` | 168 | Sailfin test | Build cache assertions via `fs.read_dir` + `fs.exists` |
| `test_runner_state_marker.sh` | 210 | Sailfin test | Env-var fixture + assertion |
| `test_runtime_clock_skeleton.sh` | 111 | Sailfin test (snapshot) | IR `declare` checks → snapshot |
| `test_runtime_io_skeleton.sh` | 84 | Sailfin test (snapshot) | Same |
| `test_runtime_libc_skeleton.sh` | 120 | Sailfin test (snapshot) | Same |
| `test_runtime_net_skeleton.sh` | 96 | Sailfin test (snapshot) | Same |
| `test_runtime_posix_skeleton.sh` | 96 | Sailfin test (snapshot) | Same |
| `test_runtime_pthread_skeleton.sh` | 100 | Sailfin test (snapshot) | Same |
| `test_runtime_sfn_sources_link_consumer.sh` | 239 | Sailfin test | Multi-step build orchestration; manageable with `process.run_capture` |
| `test_sfn_package.sh` | 393 | **Stays bash, slimmed** | Heavy fs perms + tar manipulation; keep ~100 LOC, factor common fixtures out |
| `test_sleep_routes_to_sfn_clock.sh` | 75 | Sailfin test (snapshot) | IR check |
| `test_sleep_unit_semantics.sh` | 127 | Sailfin test | Compile + run + timing |
| `test_struct_field_separator.sh` | 294 | Sailfin test (snapshot) | IR snapshot |
| `test_subprocess_emit_clean_env.sh` | 248 | Sailfin test | `with_env` + `process.run_capture` |

## Hold-out justification

Three scripts stay as bash. Each has a concrete reason that does not
disappear in Phase 4.

1. **`test_check_compiler_src.sh`** — not a test. It runs `sfn check`
   over the entire `compiler/src/` tree and asserts zero diagnostics.
   That is a `make` target shape, not a per-test shape. The right move
   is to delete the `.sh` and add a `make check-src` target whose body
   is one `sfn check` invocation.

2. **`test_publish.sh`** — orchestrates a registry mock (probably
   `python -m http.server` or similar), runs `sfn publish` against it,
   verifies HTTP requests via `curl`. Multi-process bash is genuinely
   easier than spawning an HTTP server from Sailfin tests today (no
   `sfn/http` server stubs yet). Slimmable to ~80 LOC by factoring the
   capsule-setup half into a Sailfin fixture.

3. **`test_sfn_package.sh`** — exercises `sfn package` against tarball
   layouts and fs permissions. Some of the assertions need `tar -tvf`
   verification against actual archive contents, which Sailfin lacks a
   library for. Slimmable to ~100 LOC by moving permission/fs
   assertions to Sailfin and keeping only the tar-inspection bash.

**Total post-migration:** 3 scripts × ~80-100 LOC = ~280 LOC bash, down
from 7442. Net deletion: ~7160 LOC bash. Net addition: ~35 new
`*_test.sfn` files averaging ~80 LOC each = ~2800 LOC Sailfin. Even
counting the API surface added to `sfn/test`, the framework expansion,
and the new precondition stdlib, the total LOC delta is **negative**
because the bash scripts are dense with boilerplate that the framework
deletes.

## Migration ordering

Within Phase 3 issue 3.1, migrate in this order:

1. **Trivial smoke tests** (`test_guillermo.sh`, `test_login.sh`,
   `test_arena_default_on.sh`) — prove `with_env` + `process.run_capture`
   work end-to-end. ~1 day.
2. **IR-snapshot family** (10 scripts: `test_atomic_*`, `test_runtime_*_skeleton.sh`,
   `test_drop_emission_*`, `test_struct_field_separator`, `test_sleep_routes_*`,
   `test_capsule_ir_layout`) — prove the snapshot harness works against
   real-world LLVM IR. ~2 days.
3. **Compile-as-test family** (6 scripts: `test_check_*.sh`,
   `test_build_diagnostics_format.sh`) — prove `assert_compiles` /
   `assert_does_not_compile` work. ~2 days.
4. **fs-and-env family** (the remaining ~14 scripts) — once all of
   `with_tmp_dir`, `with_env`, `with_cwd`, `process.run_capture`, and
   `fs.set_perms` are stable, this is mechanical. ~3 days.

Total Phase 3.1 effort: ~8 working days at one engineer.
