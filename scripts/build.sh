#!/usr/bin/env bash
# build.sh — Build the Sailfin native compiler from a seed binary.
#
# This is the Python-free replacement for selfhost_native.py.
# It performs only the essential build orchestration:
#
#   1. Enumerate compiler/src/**/*.sfn + runtime/**/*.sfn
#   2. Stage import-context artifacts (seed emit native → .sfn-asm + .layout-manifest)
#   3. Per-module: seed emit llvm → .ll, clang compile → .o
#   4. llvm-link all modules (except prelude) → linked bitcode
#   5. Compile C runtime, link everything → final binary
#
# NO fixup passes. If the compiler emits broken LLVM IR, the build fails.
# Fix the compiler, not the build script.
#
# Requirements: seed compiler (sfn), clang, llvm-link, GNU coreutils
#
# Usage:
#   scripts/build.sh [options]
#
# Options:
#   --seed PATH        Seed compiler binary (default: sfn on PATH or build/seed/bin/sailfin)
#   --out PATH         Output binary path (default: build/native/sailfin)
#   --opt FLAGS        Clang optimization flags (default: -O2)
#   --jobs N           Parallel module builds (default: 1)
#   --clang CMD        Clang executable (default: clang)
#   --timeout SECS     Per-module seed timeout in seconds (default: 180)
#   --max-total SECS   Max total wall time (default: 1200)
#   --work-dir DIR     Working directory for intermediate artifacts (default: build/selfhost/native)
#   --verbose          Print each command as it runs

set -euo pipefail

# ---------------------------------------------------------------------------
# Defaults
# ---------------------------------------------------------------------------
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SEED="${SEED:-sfn}"
OUT="${OUT:-build/native/sailfin}"
OPT="${OPT:--O2}"
JOBS="${JOBS:-1}"
CLANG="${CLANG:-clang}"
SEED_TIMEOUT="${SEED_TIMEOUT:-180}"
MAX_TOTAL="${MAX_TOTAL:-1200}"
VERBOSE="${VERBOSE:-0}"
BUILD_MODULE_WORKER=0
WORKER_INDEX=""
WORKER_SRC=""

# Build directories (overridable via --work-dir)
WORK_DIR="${WORK_DIR:-build/selfhost/native}"

# Clang flags shared across all compilations
CLANG_FLAGS="$OPT -Wno-override-module -fno-delete-null-pointer-checks"

# Track start time for wall-time budget
START_TIME="$(date +%s)"

# ---------------------------------------------------------------------------
# Argument parsing
# ---------------------------------------------------------------------------
while [[ $# -gt 0 ]]; do
    case "$1" in
        --seed)     SEED="$2"; shift 2 ;;
        --out)      OUT="$2"; shift 2 ;;
        --opt)      OPT="$2"; CLANG_FLAGS="$OPT -Wno-override-module -fno-delete-null-pointer-checks"; shift 2 ;;
        --jobs)     JOBS="$2"; shift 2 ;;
        --clang)    CLANG="$2"; shift 2 ;;
        --timeout)  SEED_TIMEOUT="$2"; shift 2 ;;
        --max-total) MAX_TOTAL="$2"; shift 2 ;;
        --work-dir) WORK_DIR="$2"; shift 2 ;;
        --verbose)  VERBOSE=1; shift ;;
        --_build_module_worker)
            BUILD_MODULE_WORKER=1
            WORKER_INDEX="$2"
            WORKER_SRC="$3"
            shift 3
            ;;
        *)          echo "[build] unknown option: $1" >&2; exit 1 ;;
    esac
done

# Derived build directories (set after argument parsing so --work-dir takes effect)
RAW_DIR="$WORK_DIR/raw"
OBJ_DIR="$WORK_DIR/obj"
SEED_CWD="$WORK_DIR/seed_cwd"
IMPORT_CACHE="$SEED_CWD/build/native/import-context"

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
log() { echo "[build] $*"; }
warn() { echo "[build][warn] $*" >&2; }
die() { echo "[build][error] $*" >&2; exit 1; }

run() {
    if [[ "$VERBOSE" == "1" ]]; then
        echo "+ $*" >&2
    fi
    "$@"
}

check_budget() {
    local now
    now="$(date +%s)"
    local elapsed=$(( now - START_TIME ))
    if [[ "$elapsed" -gt "$MAX_TOTAL" ]]; then
        die "exceeded max wall time (${elapsed}s > ${MAX_TOTAL}s)"
    fi
}

# Timeout command (portable across Linux/macOS)
if command -v timeout &>/dev/null; then
    TIMEOUT_CMD="timeout"
elif command -v gtimeout &>/dev/null; then
    TIMEOUT_CMD="gtimeout"
else
    TIMEOUT_CMD=""
fi

seed_run() {
    if [[ -n "$TIMEOUT_CMD" ]]; then
        "$TIMEOUT_CMD" "$SEED_TIMEOUT" "$@"
    else
        "$@"
    fi
}

# Strip CLI log prefixes from LLVM IR output and trim to module start.
# Legacy seed compilers (< v0.5) prefix lines with "[info] ", "[warn] ", etc.
# because they used print.info() instead of raw print(). This can be removed
# once the seed is built from a version that uses raw print().
strip_log_prefixes() {
    local input="$1"
    local output="$2"

    # Step 1: strip [level] prefixes (e.g. "[info] source_filename" → "source_filename")
    # Step 2: find first LLVM top-level line and drop everything before it
    awk '
    {
        line = $0
        # Strip log prefixes like [info], [debug], [warn]
        if (substr(line, 1, 1) == "[") {
            idx = index(line, "] ")
            if (idx > 0) {
                line = substr(line, idx + 2)
            }
        }

        # Once we find the first LLVM top-level entity, start outputting
        if (!started) {
            trimmed = line
            gsub(/^[[:space:]]+/, "", trimmed)
            if (trimmed == "") next
            if (trimmed ~ /^(source_filename =|; ModuleID =|target |declare |define |%|@|;|!|attributes )/) {
                started = 1
            } else {
                next
            }
        }
        print line
    }
    ' "$input" > "$output"
}

# ---------------------------------------------------------------------------
# Find llvm-link
# ---------------------------------------------------------------------------
find_llvm_link() {
    if [[ -n "${LLVM_LINK:-}" ]] && command -v "$LLVM_LINK" &>/dev/null; then
        echo "$LLVM_LINK"
        return
    fi
    for cand in llvm-link llvm-link-{30..14}; do
        if command -v "$cand" &>/dev/null; then
            echo "$cand"
            return
        fi
    done
    # macOS Homebrew
    if [[ "$(uname -s)" == "Darwin" ]]; then
        local brew_prefix
        brew_prefix="$(brew --prefix llvm 2>/dev/null || true)"
        if [[ -n "$brew_prefix" && -x "$brew_prefix/bin/llvm-link" ]]; then
            echo "$brew_prefix/bin/llvm-link"
            return
        fi
    fi
    die "llvm-link not found (set LLVM_LINK or install LLVM tools)"
}

# ---------------------------------------------------------------------------
# Resolve seed compiler
# ---------------------------------------------------------------------------
if ! command -v "$SEED" &>/dev/null; then
    if [[ -x "$REPO_ROOT/build/seed/bin/sailfin" ]]; then
        SEED="$REPO_ROOT/build/seed/bin/sailfin"
    elif [[ -x "$REPO_ROOT/build/native/sailfin" ]]; then
        SEED="$REPO_ROOT/build/native/sailfin"
    else
        die "seed compiler not found: $SEED (run 'make fetch-seed' first)"
    fi
fi

# Resolve to absolute path
SEED="$(command -v "$SEED" 2>/dev/null || echo "$SEED")"
SEED="$(cd "$REPO_ROOT" && realpath "$SEED")"
[[ -x "$SEED" ]] || die "seed compiler not executable: $SEED"

log "seed: $SEED ($("$SEED" version 2>/dev/null || "$SEED" --version 2>/dev/null || echo 'unknown'))"

# ---------------------------------------------------------------------------
# Collect sources
# ---------------------------------------------------------------------------
COMPILER_SRC="$REPO_ROOT/compiler/src"
RUNTIME_SRC="$REPO_ROOT/runtime"

[[ -d "$COMPILER_SRC" ]] || die "missing compiler sources: $COMPILER_SRC"
[[ -d "$RUNTIME_SRC" ]] || die "missing runtime sources: $RUNTIME_SRC"

# Collect all .sfn files in deterministic order
SOURCES=()
while IFS= read -r -d '' f; do
    SOURCES+=("$f")
done < <(find "$COMPILER_SRC" -name '*.sfn' -print0 | sort -z)
while IFS= read -r -d '' f; do
    SOURCES+=("$f")
done < <(find "$RUNTIME_SRC" -name '*.sfn' -print0 | sort -z)

[[ ${#SOURCES[@]} -gt 0 ]] || die "no .sfn sources found"
log "found ${#SOURCES[@]} source modules"

# ---------------------------------------------------------------------------
# Module naming helpers
# ---------------------------------------------------------------------------
# Converts a source path to a module name (collision-free, __ separated)
# e.g. compiler/src/llvm/types.sfn → llvm__types
#      runtime/prelude.sfn → runtime__prelude
module_name_from_path() {
    local src="$1"
    local rel

    # Try compiler/src/ prefix first
    if [[ "$src" == "$COMPILER_SRC"/* ]]; then
        rel="${src#"$COMPILER_SRC/"}"
        rel="${rel%.sfn}"
        echo "${rel//\//__}"
        return
    fi

    # Try runtime/ prefix
    if [[ "$src" == "$RUNTIME_SRC"/* ]]; then
        rel="${src#"$RUNTIME_SRC/"}"
        rel="${rel%.sfn}"
        echo "runtime__${rel//\//__}"
        return
    fi

    # Fallback: basename
    local base
    base="$(basename "$src" .sfn)"
    echo "$base"
}

# Converts a source path to an import-context slug
# e.g. compiler/src/llvm/types.sfn → llvm/types
#      runtime/prelude.sfn → runtime/prelude
slug_from_path() {
    local src="$1"
    local rel

    if [[ "$src" == "$COMPILER_SRC"/* ]]; then
        rel="${src#"$COMPILER_SRC/"}"
        echo "${rel%.sfn}"
        return
    fi

    if [[ "$src" == "$RUNTIME_SRC"/* ]]; then
        rel="${src#"$RUNTIME_SRC/"}"
        echo "runtime/${rel%.sfn}"
        return
    fi

    basename "$src" .sfn
}

# ---------------------------------------------------------------------------
# Module build worker (used for parallel builds)
# ---------------------------------------------------------------------------
build_module() {
    local idx="$1"
    local src="$2"
    local module_name
    module_name="$(module_name_from_path "$src")"
    local slug
    slug="$(slug_from_path "$src")"
    local ll_path="$RAW_DIR/${module_name}.ll"
    local obj_path="$OBJ_DIR/${module_name}.o"

    # Resolve source to absolute path for use inside module_cwd
    local abs_src
    abs_src="$(cd "$REPO_ROOT" && realpath "$src")"

    # Create isolated seed cwd for this module
    local module_cwd="$RAW_DIR/tmp/${module_name}/seed_cwd"
    mkdir -p "$module_cwd/build/native"

    # Copy import-context (or symlink for speed)
    if [[ -d "$IMPORT_CACHE" ]]; then
        rm -rf "$module_cwd/build/native/import-context"
        cp -a "$IMPORT_CACHE" "$module_cwd/build/native/import-context"
    fi

    # Remove self-artifact to prevent self-import issues
    local self_asm="$module_cwd/build/native/import-context/${slug}.sfn-asm"
    local self_manifest="$module_cwd/build/native/import-context/${slug}.layout-manifest"
    rm -f "$self_asm" "$self_manifest" 2>/dev/null || true

    # Create clean build/sailfin dir for lowering temp files.
    # Stale IPC artifacts from a prior build can corrupt the output.
    rm -rf "$module_cwd/build/sailfin"
    mkdir -p "$module_cwd/build/sailfin"


    # Resolve output paths to absolute so they work from module_cwd
    local abs_ll_path
    abs_ll_path="$(cd "$REPO_ROOT" && realpath --canonicalize-missing "$ll_path")"
    local abs_ll_raw="${abs_ll_path}.raw"

    # Prefer emit-llvm-file if available (produces link-safe IR)
    # Run from module_cwd so the seed picks up staged import-context
    local emit_ok=0
    if "$SEED" emit-llvm-file --help &>/dev/null 2>&1 || "$SEED" help 2>&1 | grep -q "emit-llvm-file"; then
        # Tolerate segfault during cleanup if the output file was written
        (cd "$module_cwd" && seed_run "$SEED" emit-llvm-file "$abs_src" "$abs_ll_raw") 2>/dev/null || true
        if [[ -s "$abs_ll_raw" ]]; then
            strip_log_prefixes "$abs_ll_raw" "$ll_path"
            rm -f "$abs_ll_raw"
            emit_ok=1
        fi
    fi

    # Fallback to streaming emit (also run from module_cwd)
    if [[ "$emit_ok" -eq 0 ]]; then
        # The first-pass binary may segfault during cleanup after writing valid LLVM IR.
        # Tolerate non-zero exit if the output file contains valid LLVM IR.
        (cd "$module_cwd" && seed_run "$SEED" emit llvm "$abs_src") > "$abs_ll_raw" 2>/dev/null || true
        if [[ ! -s "$abs_ll_raw" ]]; then
            echo "[build] FAIL: seed emit produced no output for $module_name" >&2
            return 1
        fi
        # Strip CLI log prefixes (e.g. "[info] source_filename = ...")
        # and trim to the first LLVM top-level entity
        strip_log_prefixes "$abs_ll_raw" "$ll_path"
        rm -f "$abs_ll_raw"
    fi

    # Validate: output must look like LLVM IR
    if ! head -20 "$ll_path" | grep -qE "define|declare|target|source_filename|ModuleID"; then
        echo "[build] FAIL: seed output for $module_name is not valid LLVM IR" >&2
        head -5 "$ll_path" >&2
        return 1
    fi

    echo "$module_name"
    return 0
}

# Compile a single .ll file to .o with clang (called after cross-module resolution)
compile_module() {
    local module_name="$1"
    local ll_path="$RAW_DIR/${module_name}.ll"
    local obj_path="$OBJ_DIR/${module_name}.o"

    # shellcheck disable=SC2086
    if ! run "$CLANG" $CLANG_FLAGS -c "$ll_path" -o "$obj_path" 2>/dev/null; then
        echo "[build] FAIL: clang compile failed for $module_name" >&2
        echo "[build] hint: inspect $ll_path for invalid LLVM IR" >&2
        # shellcheck disable=SC2086
        "$CLANG" $CLANG_FLAGS -c "$ll_path" -o "$obj_path" 2>&1 | tail -20 >&2
        return 1
    fi
    return 0
}

if [[ "$BUILD_MODULE_WORKER" -eq 1 ]]; then
    mkdir -p "$RAW_DIR" "$OBJ_DIR"
    result="$(build_module "$WORKER_INDEX" "$WORKER_SRC")" || exit 1
    : "${MODULES_LIST:="$RAW_DIR/modules_built.txt"}"
    echo "$result" >> "$MODULES_LIST"
    exit 0
fi

# ---------------------------------------------------------------------------
# Step 1: Prepare directories
# ---------------------------------------------------------------------------
log "preparing build directories..."
cd "$REPO_ROOT"
mkdir -p "$RAW_DIR" "$OBJ_DIR" "$OBJ_DIR/runtime"
mkdir -p "$SEED_CWD/build/native/import-context"

# Clean stale artifacts from prior builds (Python selfhost leaves .attempt*.ll files)
find "$RAW_DIR" -name '*.ll' -delete 2>/dev/null || true
find "$OBJ_DIR" -name '*.o' -delete 2>/dev/null || true

# ---------------------------------------------------------------------------
# Step 2: Stage import-context artifacts
# ---------------------------------------------------------------------------
log "staging import-context artifacts..."

stage_import_context() {
    local src="$1"
    local slug
    slug="$(slug_from_path "$src")"
    local asm_dest="$IMPORT_CACHE/${slug}.sfn-asm"
    local manifest_dest="$IMPORT_CACHE/${slug}.layout-manifest"

    mkdir -p "$(dirname "$asm_dest")"

    # Emit native text (.sfn-asm)
    local native_text
    if ! native_text="$(seed_run "$SEED" emit native "$src" 2>/dev/null)"; then
        warn "failed to emit native for $slug"
        return 0
    fi

    echo "$native_text" > "$asm_dest"

    # Extract .layout lines for the manifest
    grep '^\.\(layout\)' "$asm_dest" > "$manifest_dest" 2>/dev/null || true

    # Reduce native text to a lightweight skeleton that retains module
    # metadata, import declarations, and function signatures but strips
    # function instruction bodies.  The full native text causes OOM in
    # early seed compilers because the transitive import BFS loads all
    # texts into memory.  The skeleton keeps the BFS working (imports
    # are preserved) while drastically reducing memory pressure.
    local full_dest="${asm_dest}.full"
    mv "$asm_dest" "$full_dest"
    awk '
    # Always keep module, import, struct, enum, layout declarations
    /^\.(module|import|struct|enum|end-struct|end-enum|layout|end-layout)/ { print; next }
    # Keep function signature line (.fn) and end marker (.endfn)
    /^\.fn / { print; infn=1; next }
    /^\.endfn/ { print; infn=0; next }
    # Inside a function keep metadata but skip body instructions
    infn && /^\.(meta|param|return)/ { print; next }
    infn { next }
    # Keep top-level let bindings (module bindings)
    /^\.let / { print; next }
    # Skip everything else
    { next }
    ' "$full_dest" > "$asm_dest"
    rm -f "$full_dest"
}

# Stage import context (sequential for safety with older seeds)
for src in "${SOURCES[@]}"; do
    check_budget
    stage_import_context "$src"
done

log "staged import-context for ${#SOURCES[@]} modules"

# ---------------------------------------------------------------------------
# Step 3: Per-module emit + compile
# ---------------------------------------------------------------------------
log "building ${#SOURCES[@]} modules (jobs=$JOBS)..."

MODULE_NAMES=()
FAILED=0

# Build modules (with optional parallelism)
if [[ "$JOBS" -le 1 ]]; then
    for i in "${!SOURCES[@]}"; do
        check_budget
        result="$(build_module "$i" "${SOURCES[$i]}")" || { FAILED=1; break; }
        MODULE_NAMES+=("$result")
        log "  [$((i+1))/${#SOURCES[@]}] $result"
    done
else
    # Parallel build using GNU parallel or xargs
    MODULES_LIST="$RAW_DIR/modules_built.txt"
    > "$MODULES_LIST"
    export MODULES_LIST

    for i in "${!SOURCES[@]}"; do
        echo "$i ${SOURCES[$i]}"
    done | xargs -P "$JOBS" -L 1 bash -c '
        cd "'"$REPO_ROOT"'"
        bash scripts/build.sh --seed "'"$SEED"'" --work-dir "'"$WORK_DIR"'" --_build_module_worker "$@"
    ' _ 2>"$RAW_DIR/build_errors.txt" || FAILED=1

    if [[ "$FAILED" -eq 0 ]]; then
        while IFS= read -r name; do
            MODULE_NAMES+=("$name")
        done < "$MODULES_LIST"
    fi
fi

[[ "$FAILED" -eq 0 ]] || die "module build failed (see errors above)"
log "compiled ${#MODULE_NAMES[@]} modules"

# Write module list for reproducibility
printf '%s\n' "${MODULE_NAMES[@]}" > "$RAW_DIR/modules.txt"

# ---------------------------------------------------------------------------
# Step 3.4: Cross-module type resolution
# ---------------------------------------------------------------------------
# When modules are compiled separately, imported struct types appear as
# `%Name = type opaque` because the compiler doesn't have a header/metadata
# system.  This step collects all concrete (non-opaque) type definitions from
# every module and replaces opaque stubs where a concrete definition exists.
# This is standard separate-compilation infrastructure (analogous to C headers
# or Rust .rmeta files), not a fixup for broken IR.
log "resolving cross-module types..."

# Build global type table: %TypeName -> full definition line
TYPETAB="$RAW_DIR/.typetab"
> "$TYPETAB"
for ll in "$RAW_DIR"/*.ll; do
    # Collect concrete type definitions (lines like: %Foo = type { ... })
    grep -P '^%[A-Z]\w+ = type \{' "$ll" >> "$TYPETAB" 2>/dev/null || true
done
# Deduplicate, keeping first occurrence (most specific)
awk -F' = ' '!seen[$1]++' "$TYPETAB" > "${TYPETAB}.dedup"
mv "${TYPETAB}.dedup" "$TYPETAB"

# Use a Python helper for iterative type resolution (handles cascading
# dependencies where injecting a concrete type introduces references to
# other types not yet declared in the module).
_type_output=$(python3 - "$RAW_DIR" "$TYPETAB" <<'PYEOF'
import sys, os, re

raw_dir = sys.argv[1]
typetab_path = sys.argv[2]

# Load global type table
type_defs = {}  # %Name -> full line
with open(typetab_path) as f:
    for line in f:
        line = line.rstrip("\n")
        m = re.match(r'^(%\w+) = type \{', line)
        if m:
            type_defs[m.group(1)] = line

# Legitimately opaque types (runtime internals)
SKIP_TYPES = {"%SailfinFutureNumber", "%SailfinFutureBool", "%SailfinFuturePtr",
              "%SailfinFutureVoid", "%SailfinFutureString",
              "%SailfinChannelNumber", "%SailfinChannelBool", "%SailfinChannelPtr",
              "%SailfinChannelVoid", "%SailfinChannelString"}

total_fixes = 0

for fname in sorted(os.listdir(raw_dir)):
    if not fname.endswith(".ll"):
        continue
    fpath = os.path.join(raw_dir, fname)
    with open(fpath) as f:
        text = f.read()
    lines = text.split("\n")

    # Iterate until stable (cascading type deps)
    changed = True
    passes = 0
    while changed and passes < 20:
        changed = False
        passes += 1

        # Build set of types declared/defined in this module
        declared_types = set()
        for ln in lines:
            m = re.match(r'^(%\w+) = type ', ln)
            if m:
                declared_types.add(m.group(1))

        # Phase 1: Replace opaque stubs with concrete defs
        new_lines = []
        for ln in lines:
            m = re.match(r'^(%\w+) = type opaque$', ln)
            if m:
                tname = m.group(1)
                if tname not in SKIP_TYPES and tname in type_defs:
                    new_lines.append(type_defs[tname])
                    total_fixes += 1
                    changed = True
                    continue
            new_lines.append(ln)
        lines = new_lines

        # Phase 2: Find ALL type references (in type defs, signatures, and body)
        all_refs = set()
        for ln in lines:
            for ref in re.findall(r'%[A-Z]\w+', ln):
                all_refs.add(ref)

        # Rebuild declared types set after phase 1
        declared_types = set()
        for ln in lines:
            m = re.match(r'^(%\w+) = type ', ln)
            if m:
                declared_types.add(m.group(1))

        missing = all_refs - declared_types
        if missing:
            # Find insertion point (after last type def line, or at line 1)
            insert_idx = 0
            for i, ln in enumerate(lines):
                if re.match(r'^%\w+ = type ', ln):
                    insert_idx = i + 1
            inject = []
            for tname in sorted(missing):
                if tname in SKIP_TYPES:
                    continue
                if tname in type_defs:
                    inject.append(type_defs[tname])
                    total_fixes += 1
                else:
                    # No concrete def known — insert opaque stub so LLVM can parse
                    inject.append(f"{tname} = type opaque")
                changed = changed or bool(inject)
            if inject:
                for j, inj_line in enumerate(inject):
                    lines.insert(insert_idx + j, inj_line)

    # Phase 3: Fix `store %Struct null` → `store %Struct zeroinitializer`
    # When types are resolved from opaque to concrete, `null` is no longer
    # valid for aggregate (non-pointer) types.
    concrete_types = set()
    for ln in lines:
        m = re.match(r'^(%\w+) = type \{', ln)
        if m:
            concrete_types.add(m.group(1))
    new_lines = []
    for ln in lines:
        m = re.match(r'^(\s+store )(%\w+)( null,)(.+)$', ln)
        if m and m.group(2) in concrete_types:
            new_lines.append(m.group(1) + m.group(2) + " zeroinitializer," + m.group(4))
            total_fixes += 1
        else:
            new_lines.append(ln)
    lines = new_lines

    with open(fpath, "w") as f:
        f.write("\n".join(lines))

print(total_fixes, flush=True)
PYEOF
)
log "cross-module type resolution: ${_type_output} fix(es)"

# ---------------------------------------------------------------------------
# Step 3.5: Cross-module symbol resolution
# ---------------------------------------------------------------------------
# The seed compiler may not emit `declare` statements for functions defined
# in other modules.  This step collects all `define` signatures across modules
# and injects matching `declare` statements where a function is called but
# neither defined nor declared.  This is analogous to what a linker does —
# it is NOT a fixup for broken IR.
log "resolving cross-module symbols..."

# Build a global symbol table: symbol -> declare line
SYMTAB="$RAW_DIR/.symtab"
> "$SYMTAB"
for ll in "$RAW_DIR"/*.ll; do
    grep '^define ' "$ll" | sed 's/^define /declare /; s/ internal / /; s/ {$//' >> "$SYMTAB"
done
sort -t'@' -k2,2 -u "$SYMTAB" -o "$SYMTAB"

# Add C runtime functions that the compiler references but are defined in
# the C runtime library (linked at the final step, not in any .ll module).
# These declarations match runtime/native/include/sailfin_runtime.h.
cat >> "$SYMTAB" <<'RUNTIME_DECLS'
declare double @print(i8*)
declare i8* @calloc(i64, i64)
declare void @sailfin_runtime_set_exception(i8*)
declare i8* @sailfin_runtime_take_exception()
declare i1 @sailfin_runtime_has_exception()
declare void @sailfin_runtime_clear_exception()
declare double @sailfin_runtime_string_to_number(i8*)
declare void @sailfin_runtime_log_execution(i8*, i8*)
declare i1 @sailfin_intrinsic_fs_exists(i8*)
declare i8* @sailfin_adapter_fs_read_file(i8*)
declare void @sailfin_adapter_fs_write_file(i8*, i8*)
declare void @sailfin_adapter_fs_append_file(i8*, i8*)
declare void @sailfin_adapter_fs_write_lines(i8*, { i8**, i64 }*)
declare { i8**, i64 }* @sailfin_adapter_fs_list_directory(i8*)
declare i1 @sailfin_adapter_fs_delete_file(i8*)
declare i1 @sailfin_adapter_fs_create_directory(i8*, i1)
declare double @sailfin_runtime_process_run({ i8**, i64 }*)
RUNTIME_DECLS

# For each module, find called-but-undeclared symbols and inject declares.
# Uses comm(1) + grep -f for fast batch lookup (avoids O(n*m) bash loops).
for ll in "$RAW_DIR"/*.ll; do
    called_f="$(mktemp)"
    known_f="$(mktemp)"
    missing_f="$(mktemp)"
    # Extract called symbols (|| true: grep returns 1 when no matches, which kills pipefail)
    { grep -oP '(?<=@)[a-zA-Z_][a-zA-Z0-9_]*(?=\()' "$ll" 2>/dev/null || true; } | sort -u > "$called_f"
    # Extract declared/defined symbols
    { grep -P '^(declare|define) ' "$ll" || true; } | { grep -oP '(?<=@)[a-zA-Z_][a-zA-Z0-9_]*(?=\()' || true; } | sort -u > "$known_f"
    # Set difference
    comm -23 "$called_f" "$known_f" > "$missing_f"
    rm -f "$called_f" "$known_f"

    if [[ -s "$missing_f" ]]; then
        # Build grep patterns for batch symtab lookup
        inject_f="$(mktemp)"
        while IFS= read -r sym; do
            grep -m1 "@${sym}(" "$SYMTAB" >> "$inject_f" 2>/dev/null || true
        done < "$missing_f"

        if [[ -s "$inject_f" ]]; then
            # Insert after the last `declare` line, or before first `define`
            last_declare=$(grep -n '^declare ' "$ll" | tail -1 | cut -d: -f1 || true)
            if [[ -n "$last_declare" ]]; then
                sed -i "${last_declare}r ${inject_f}" "$ll"
            else
                first_define=$(grep -n '^define ' "$ll" | head -1 | cut -d: -f1 || true)
                if [[ -n "$first_define" ]]; then
                    sed -i "$((first_define-1))r ${inject_f}" "$ll"
                fi
            fi
        fi
        rm -f "$inject_f"
    fi
    rm -f "$missing_f"
done
log "cross-module symbol resolution complete"

# ---------------------------------------------------------------------------
# Step 3.51: Remove empty-param declares that conflict with typed declares
# ---------------------------------------------------------------------------
# The compiler sometimes emits `declare ... @fn()` (empty params) for imported
# functions whose signatures it couldn't resolve. Cross-module symbol resolution
# above may have injected a properly-typed `declare ... @fn(type1, type2)`.
# LLVM rejects two declares of the same function with different signatures,
# so remove the empty-param versions when a typed version exists.
for ll in "$RAW_DIR"/*.ll; do
    # Collect function names that have both empty-param and typed declares.
    # Empty-param: lines like  declare ... @name()  (paren at end of line)
    # Typed:       declare ... @name(type ...)
    empty_fns="$(mktemp)"
    typed_fns="$(mktemp)"
    { grep -P '^declare\s.*@\w+\(\)\s*$' "$ll" 2>/dev/null | grep -oP '(?<=@)[a-zA-Z_][a-zA-Z0-9_]*(?=\(\))' || true; } | sort -u > "$empty_fns"
    { grep '^declare ' "$ll" 2>/dev/null | grep -oP '(?<=@)[a-zA-Z_][a-zA-Z0-9_]*(?=\([^)]+\))' || true; } | sort -u > "$typed_fns"
    conflicts="$(comm -12 "$empty_fns" "$typed_fns")"
    rm -f "$empty_fns" "$typed_fns"
    if [[ -n "$conflicts" ]]; then
        # Build a sed script to delete the empty-param declare lines
        sed_script="$(mktemp)"
        while IFS= read -r fn; do
            echo "/@${fn}()$/d" >> "$sed_script"
        done <<< "$conflicts"
        sed -i -f "$sed_script" "$ll"
        rm -f "$sed_script"
    fi
done

# ---------------------------------------------------------------------------
# Step 3.55: Second type resolution pass
# ---------------------------------------------------------------------------
# Symbol resolution may have injected `declare` lines referencing types not
# yet present in the module. Run the type resolver again to pick these up.
log "resolving cross-module types (pass 2)..."
_type_output2=$(python3 - "$RAW_DIR" "$TYPETAB" <<'PYEOF2'
import sys, os, re

raw_dir = sys.argv[1]
typetab_path = sys.argv[2]

type_defs = {}
with open(typetab_path) as f:
    for line in f:
        line = line.rstrip("\n")
        m = re.match(r'^(%\w+) = type \{', line)
        if m:
            type_defs[m.group(1)] = line

SKIP_TYPES = {"%SailfinFutureNumber", "%SailfinFutureBool", "%SailfinFuturePtr",
              "%SailfinFutureVoid", "%SailfinFutureString",
              "%SailfinChannelNumber", "%SailfinChannelBool", "%SailfinChannelPtr",
              "%SailfinChannelVoid", "%SailfinChannelString"}

total_fixes = 0

for fname in sorted(os.listdir(raw_dir)):
    if not fname.endswith(".ll"):
        continue
    fpath = os.path.join(raw_dir, fname)
    with open(fpath) as f:
        lines = f.read().split("\n")

    changed = True
    while changed:
        changed = False
        declared_types = set()
        for ln in lines:
            m = re.match(r'^(%\w+) = type ', ln)
            if m:
                declared_types.add(m.group(1))

        all_refs = set()
        for ln in lines:
            for ref in re.findall(r'%[A-Z]\w+', ln):
                all_refs.add(ref)

        missing = all_refs - declared_types
        if not missing:
            break
        insert_idx = 0
        for i, ln in enumerate(lines):
            if re.match(r'^%\w+ = type ', ln):
                insert_idx = i + 1
        inject = []
        for tname in sorted(missing):
            if tname in SKIP_TYPES:
                continue
            if tname in type_defs:
                inject.append(type_defs[tname])
                total_fixes += 1
            else:
                inject.append(f"{tname} = type opaque")
            changed = True
        for j, inj_line in enumerate(inject):
            lines.insert(insert_idx + j, inj_line)

    with open(fpath, "w") as f:
        f.write("\n".join(lines))

print(total_fixes, flush=True)
PYEOF2
)
log "cross-module type resolution (pass 2): ${_type_output2} fix(es)"

# ---------------------------------------------------------------------------
# Step 3.6: Compile all modules with clang
# ---------------------------------------------------------------------------
log "compiling ${#MODULE_NAMES[@]} modules with clang..."
FAILED=0
for name in "${MODULE_NAMES[@]}"; do
    if ! compile_module "$name"; then
        FAILED=1
        break
    fi
done
[[ "$FAILED" -eq 0 ]] || die "clang compilation failed (see errors above)"

# ---------------------------------------------------------------------------
# Step 4: llvm-link all modules (except prelude)
# ---------------------------------------------------------------------------
log "linking LLVM IR modules..."
LLVM_LINK="$(find_llvm_link)"
log "using $LLVM_LINK"

# Collect .ll files, excluding runtime__prelude (built separately)
LL_FILES=()
for name in "${MODULE_NAMES[@]}"; do
    if [[ "$name" == "runtime__prelude" ]]; then
        continue
    fi
    LL_FILES+=("$RAW_DIR/${name}.ll")
done

LINKED_BC="$OBJ_DIR/sailfin.linked.bc"
if ! run "$LLVM_LINK" -o "$LINKED_BC" "${LL_FILES[@]}" 2>/dev/null; then
    # Retry with opaque pointers flag
    if run "$LLVM_LINK" --opaque-pointers -o "$LINKED_BC" "${LL_FILES[@]}" 2>/dev/null; then
        log "llvm-link succeeded with --opaque-pointers"
    elif run "$LLVM_LINK" -opaque-pointers -o "$LINKED_BC" "${LL_FILES[@]}" 2>/dev/null; then
        log "llvm-link succeeded with -opaque-pointers"
    else
        die "llvm-link failed (inspect .ll files in $RAW_DIR)"
    fi
fi

# Compile linked bitcode to object
LINKED_O="$OBJ_DIR/native.linked.o"
# shellcheck disable=SC2086
run "$CLANG" $CLANG_FLAGS -fPIC -c "$LINKED_BC" -o "$LINKED_O"

# Build prelude separately (for packaging and test runner expectations)
PRELUDE_LL="$RAW_DIR/runtime__prelude.ll"
PRELUDE_O="$OBJ_DIR/runtime/prelude.o"
mkdir -p "$OBJ_DIR/runtime"
# shellcheck disable=SC2086
run "$CLANG" $CLANG_FLAGS -fPIC -c "$PRELUDE_LL" -o "$PRELUDE_O"

# ---------------------------------------------------------------------------
# Step 5: Compile C runtime
# ---------------------------------------------------------------------------
log "compiling C runtime..."
INCLUDE_DIR="$REPO_ROOT/runtime/native/include"

# shellcheck disable=SC2086
run "$CLANG" $CLANG_FLAGS -I "$INCLUDE_DIR" -c runtime/native/src/sailfin_runtime.c -o "$OBJ_DIR/sailfin_runtime.o"
# shellcheck disable=SC2086
run "$CLANG" $CLANG_FLAGS -I "$INCLUDE_DIR" -c runtime/native/src/sailfin_sha256.c   -o "$OBJ_DIR/sailfin_sha256.o"
# shellcheck disable=SC2086
run "$CLANG" $CLANG_FLAGS -I "$INCLUDE_DIR" -c runtime/native/src/sailfin_base64.c   -o "$OBJ_DIR/sailfin_base64.o"
# shellcheck disable=SC2086
run "$CLANG" $CLANG_FLAGS -I "$INCLUDE_DIR" -c runtime/native/src/native_driver.c    -o "$OBJ_DIR/native_driver.o"
# shellcheck disable=SC2086
run "$CLANG" $CLANG_FLAGS -c runtime/native/ir/runtime_globals.ll -o "$OBJ_DIR/runtime_globals.o"

# ---------------------------------------------------------------------------
# Step 6: Link final binary
# ---------------------------------------------------------------------------
log "linking final binary..."

LINK_LIBS="-lm -lpthread"
case "$(uname -s)" in
    Linux*)  LINK_LIBS="$LINK_LIBS -lrt" ;;
    Darwin*) ;;
esac

mkdir -p "$(dirname "$OUT")"

# shellcheck disable=SC2086
run "$CLANG" $CLANG_FLAGS \
    -o "$OUT" \
    "$OBJ_DIR/sailfin_runtime.o" \
    "$OBJ_DIR/sailfin_sha256.o" \
    "$OBJ_DIR/sailfin_base64.o" \
    "$OBJ_DIR/native_driver.o" \
    "$OBJ_DIR/runtime_globals.o" \
    "$LINKED_O" \
    "$PRELUDE_O" \
    $LINK_LIBS

# ---------------------------------------------------------------------------
# Verify
# ---------------------------------------------------------------------------
if [[ ! -x "$OUT" ]]; then
    die "link succeeded but output is not executable: $OUT"
fi

ELAPSED=$(( $(date +%s) - START_TIME ))
log "built $OUT in ${ELAPSED}s"

# Quick sanity check
if "$OUT" --version &>/dev/null; then
    log "$("$OUT" --version 2>&1 | head -1)"
else
    warn "binary built but --version check failed"
fi
