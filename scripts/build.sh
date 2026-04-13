#!/usr/bin/env bash
# build.sh — Build the Sailfin native compiler from a seed binary.
#
# This is the Python-free replacement for selfhost_native.py.
# It performs only the essential build orchestration:
#
#   1. Enumerate compiler/src/**/*.sfn + runtime/**/*.sfn
#   2. Stage import-context artifacts (seed emit native → .sfn-asm + .layout-manifest)
#   3. Per-module: seed emit -o <out.ll> llvm → .ll
#   4. Compile each .ll → .o with clang
#   5. llvm-link all modules (except prelude) → linked bitcode
#   6. Compile C runtime
#   7. Link everything → final binary
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
# EMIT_RETRIES: how many times to re-run seed emit on empty/invalid output.
#   Production default: 3 (tolerates sporadic memory corruption).
#   Diagnostic runs:    1 (measures raw failure rate — no re-rolling the dice).
EMIT_RETRIES="${EMIT_RETRIES:-3}"
BUILD_MODULE_WORKER=0
WORKER_INDEX=""
WORKER_SRC=""

# Build directories (overridable via --work-dir)
WORK_DIR="${WORK_DIR:-build/selfhost/native}"


# Track start time for wall-time budget
START_TIME="$(date +%s)"

# Phase timers (populated as build progresses)
T_IMPORT_START=0
T_IMPORT_END=0
T_EMIT_START=0
T_EMIT_END=0
T_CLANG_START=0
T_CLANG_END=0
T_LINK_START=0
T_LINK_END=0

# ---------------------------------------------------------------------------
# Argument parsing
# ---------------------------------------------------------------------------
while [[ $# -gt 0 ]]; do
    case "$1" in
        --seed)     SEED="$2"; shift 2 ;;
        --out)      OUT="$2"; shift 2 ;;
        --opt)      OPT="$2"; shift 2 ;;
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

# Diagnostic artifacts (per-build, written under $WORK_DIR so diff experiments
# using --work-dir get their own logs automatically).
RETRY_LOG="${RETRY_LOG:-$WORK_DIR/retries.log}"
CORRUPTED_DIR="${CORRUPTED_DIR:-$WORK_DIR/corrupted}"

# Clang flags shared across all compilations. Composed post-argparse so that
# --opt, --clang, and OPAQUE_POINTERS are all honored consistently.
CLANG_FLAGS="$OPT -Wno-override-module -fno-delete-null-pointer-checks"
# Opaque pointer handling. Pin explicitly via OPAQUE_POINTERS env var when
# mixing clang versions across machines, so the IR pipeline doesn't silently
# diverge between runs:
#   OPAQUE_POINTERS=auto (default) — probe clang, add -no-opaque-pointers if supported
#   OPAQUE_POINTERS=off             — force -Xclang -no-opaque-pointers (fail if rejected)
#   OPAQUE_POINTERS=on              — leave clang in default (modern) opaque-pointer mode
# TODO: Remove once the compiler emits opaque pointer IR natively.
OPAQUE_POINTERS_MODE="${OPAQUE_POINTERS:-auto}"
case "$OPAQUE_POINTERS_MODE" in
    off)
        if echo "" | "$CLANG" -Xclang -no-opaque-pointers -x c -c - -o /dev/null 2>/dev/null; then
            CLANG_FLAGS="$CLANG_FLAGS -Xclang -no-opaque-pointers"
        else
            echo "[build][error] OPAQUE_POINTERS=off but $CLANG does not accept -no-opaque-pointers" >&2
            exit 1
        fi
        ;;
    on)
        : ;;
    auto)
        if echo "" | "$CLANG" -Xclang -no-opaque-pointers -x c -c - -o /dev/null 2>/dev/null; then
            CLANG_FLAGS="$CLANG_FLAGS -Xclang -no-opaque-pointers"
        fi
        ;;
    *)
        echo "[build][error] OPAQUE_POINTERS must be one of: auto, on, off (got: $OPAQUE_POINTERS_MODE)" >&2
        exit 1
        ;;
esac

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

SEED_MEM_LIMIT="${SEED_MEM_LIMIT:-12582912}"  # 12 GB virtual address space cap (kbytes)

seed_run() {
    # Run in a subshell so ulimit only affects this invocation
    (
        ulimit -v "$SEED_MEM_LIMIT" 2>/dev/null || true
        if [[ -n "$TIMEOUT_CMD" ]]; then
            "$TIMEOUT_CMD" "$SEED_TIMEOUT" "$@"
        else
            "$@"
        fi
    )
}

# ---------------------------------------------------------------------------
# Diagnostic helpers for the emit retry loop
# ---------------------------------------------------------------------------
# _retry_log module attempt reason exit_code
#   Append one structured line per retry attempt (including post-success
#   records when a retry was needed or the seed exited non-zero). Single-line
#   printf >> append is atomic for lines under PIPE_BUF (~4KB on Linux),
#   which is enough for our schema.
_retry_log() {
    local module="$1" attempt="$2" reason="$3" exit_code="$4"
    [[ -n "${RETRY_LOG:-}" ]] || return 0
    mkdir -p "$(dirname "$RETRY_LOG")" 2>/dev/null || true
    printf 'timestamp=%s module=%s attempt=%s reason=%s exit_code=%s\n' \
        "$(date +%s)" "$module" "$attempt" "$reason" "$exit_code" \
        >>"$RETRY_LOG" 2>/dev/null || true
}

# _capture_corrupted module attempt bad_ll err_log reason
#   Stash the bad .ll and stderr so we can build a corruption corpus across
#   many builds (pattern-hunting: always at offset X, always near identifier
#   Y, always after construct Z).
_capture_corrupted() {
    local module="$1" attempt="$2" bad_ll="$3" err_log="$4" reason="$5"
    [[ -n "${CORRUPTED_DIR:-}" ]] || return 0
    mkdir -p "$CORRUPTED_DIR" 2>/dev/null || true
    local ts
    ts="$(date +%s)"
    local dest="$CORRUPTED_DIR/${module}.${ts}.attempt${attempt}.${reason}"
    if [[ -s "$bad_ll" ]]; then
        cp -f "$bad_ll" "${dest}.ll" 2>/dev/null || true
    fi
    if [[ -s "$err_log" ]]; then
        cp -f "$err_log" "${dest}.stderr" 2>/dev/null || true
    fi
}

# _validate_ll path
#   Full-file LLVM IR parse. Catches mid-file corruption (stray UTF-8 bytes
#   in a function body, truncated globals, etc.) that the fast head-20 check
#   doesn't see. Uses llvm-as when available (cheap parse, no codegen);
#   falls back to clang with the same flags as the downstream compile so
#   behavior matches what the later step would produce.
_validate_ll() {
    local ll="$1"
    if [[ -n "${LLVM_AS:-}" ]]; then
        "$LLVM_AS" -disable-output "$ll"
    else
        # shellcheck disable=SC2086
        "$CLANG" $CLANG_FLAGS -c -emit-llvm -x ir -o /dev/null "$ll"
    fi
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
# Find llvm-as (used by _validate_ll to parse IR for full-file validation)
# ---------------------------------------------------------------------------
find_llvm_as() {
    if [[ -n "${LLVM_AS_BIN:-}" ]] && command -v "$LLVM_AS_BIN" &>/dev/null; then
        echo "$LLVM_AS_BIN"
        return
    fi
    for cand in llvm-as llvm-as-{30..14}; do
        if command -v "$cand" &>/dev/null; then
            echo "$cand"
            return
        fi
    done
    if [[ "$(uname -s)" == "Darwin" ]]; then
        local brew_prefix
        brew_prefix="$(brew --prefix llvm 2>/dev/null || true)"
        if [[ -n "$brew_prefix" && -x "$brew_prefix/bin/llvm-as" ]]; then
            echo "$brew_prefix/bin/llvm-as"
            return
        fi
    fi
    echo ""  # not found — _validate_ll falls back to clang
}

# Discover llvm-as once so build_module (main + worker) can reuse it.
LLVM_AS="$(find_llvm_as)"
export LLVM_AS

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
done < <(find "$COMPILER_SRC" -name '*.sfn' -print0 | LC_ALL=C sort -z)
while IFS= read -r -d '' f; do
    SOURCES+=("$f")
done < <(find "$RUNTIME_SRC" -name '*.sfn' -print0 | LC_ALL=C sort -z)

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


    # Resolve output paths to absolute so they work from module_cwd.
    # Use mkdir+realpath rather than --canonicalize-missing (GNU only, not on macOS).
    local abs_ll_path
    mkdir -p "$(dirname "$ll_path")"
    abs_ll_path="$(cd "$REPO_ROOT" && cd "$(dirname "$ll_path")" && echo "$(pwd)/$(basename "$ll_path")")"
    local abs_ll_raw="${abs_ll_path}.raw"

    # Emit LLVM IR to file via -o flag.
    # Run from module_cwd so the seed picks up staged import-context.
    # Diagnostics go to stderr (via print.err) so stdout/file output is clean LLVM IR.
    #
    # Retry policy: controlled by EMIT_RETRIES (default 3; set to 1 for
    # diagnostic runs to measure raw per-module failure rate).
    #
    # Every failed attempt:
    #   - captures the bad .ll + stderr to $CORRUPTED_DIR (corpus-building)
    #   - writes a structured line to $RETRY_LOG
    # The seed's exit code is captured — not swallowed by `|| true` — so a
    # segfault after a write-through is logged even when the output looks OK.
    local stderr_log="${abs_ll_path}.stderr"
    local validate_log="${abs_ll_path}.validate"
    local attempt=0
    local max_attempts="${EMIT_RETRIES:-3}"
    [[ "$max_attempts" =~ ^[0-9]+$ ]] || max_attempts=3
    [[ "$max_attempts" -ge 1 ]] || max_attempts=1
    local seed_exit=0
    while [[ $attempt -lt $max_attempts ]]; do
        attempt=$((attempt + 1))
        rm -f "$abs_ll_raw" "$validate_log"

        # Capture seed exit code explicitly (don't swallow with `|| true`).
        # `set +e` scopes the suspension to just this invocation.
        set +e
        (cd "$module_cwd" && seed_run "$SEED" emit -o "$abs_ll_raw" llvm "$abs_src") 2>"$stderr_log"
        seed_exit=$?
        set -e

        # --- Failure mode 1: empty or missing output ------------------------
        if [[ ! -s "$abs_ll_raw" ]]; then
            _capture_corrupted "$module_name" "$attempt" "$abs_ll_raw" "$stderr_log" "empty_output"
            _retry_log "$module_name" "$attempt" "empty_output" "$seed_exit"
            if [[ $attempt -lt $max_attempts ]]; then
                echo "[build] $module_name: empty output (attempt $attempt/$max_attempts, exit=$seed_exit), retrying..." >&2
                continue
            fi
            echo "[build] FAIL: seed emit produced no output for $module_name (exit=$seed_exit)" >&2
            [[ -s "$stderr_log" ]] && cat "$stderr_log" >&2
            rm -f "$stderr_log"
            return 1
        fi

        # --- Failure mode 2: header doesn't look like LLVM IR --------------
        # Fast-path check — catches header-region corruption cheaply before
        # we pay for a full parse.
        if ! head -20 "$abs_ll_raw" | grep -qE "define|declare|target|source_filename|ModuleID"; then
            _capture_corrupted "$module_name" "$attempt" "$abs_ll_raw" "$stderr_log" "invalid_header"
            _retry_log "$module_name" "$attempt" "invalid_header" "$seed_exit"
            if [[ $attempt -lt $max_attempts ]]; then
                echo "[build] $module_name: invalid IR header (attempt $attempt/$max_attempts, exit=$seed_exit), retrying..." >&2
                continue
            fi
            echo "[build] FAIL: seed output for $module_name is not valid LLVM IR" >&2
            head -5 "$abs_ll_raw" >&2
            [[ -s "$stderr_log" ]] && cat "$stderr_log" >&2
            rm -f "$stderr_log"
            return 1
        fi

        # --- Failure mode 3: mid-file corruption ---------------------------
        # Full-file parse via llvm-as (or clang fallback). This is the check
        # the head-20 grep can't make: stray bytes inside a function body,
        # truncated constants, etc., which otherwise sail through to clang
        # and surface as confusing errors at a completely different step.
        if ! _validate_ll "$abs_ll_raw" >"$validate_log" 2>&1; then
            _capture_corrupted "$module_name" "$attempt" "$abs_ll_raw" "$validate_log" "invalid_ir"
            _retry_log "$module_name" "$attempt" "invalid_ir" "$seed_exit"
            if [[ $attempt -lt $max_attempts ]]; then
                echo "[build] $module_name: IR validation failed (attempt $attempt/$max_attempts, exit=$seed_exit), retrying..." >&2
                continue
            fi
            echo "[build] FAIL: seed output for $module_name fails IR validation (exit=$seed_exit)" >&2
            [[ -s "$validate_log" ]] && tail -20 "$validate_log" >&2
            [[ -s "$stderr_log" ]] && cat "$stderr_log" >&2
            rm -f "$stderr_log" "$validate_log"
            return 1
        fi

        # --- Success path --------------------------------------------------
        # Log eventual-success cases so retries.log stays informative:
        #   - attempt > 1 means we hit corruption and recovered
        #   - seed_exit != 0 means the seed segfaulted after writing valid IR
        #     (a known-bug workaround today, but worth recording as signal)
        if [[ $attempt -gt 1 || $seed_exit -ne 0 ]]; then
            _retry_log "$module_name" "$attempt" "success_after_retry" "$seed_exit"
        fi
        break
    done
    mv "$abs_ll_raw" "$ll_path"
    rm -f "$stderr_log" "$validate_log"

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

    # Emit native text (.sfn-asm) with a direct redirect. Bash command
    # substitution strips trailing newlines and re-encodes through the
    # shell's locale, which can mangle any non-ASCII bytes in the seed's
    # output (intentional or from corruption). Pipe straight to the file.
    if ! seed_run "$SEED" emit native "$src" >"$asm_dest" 2>/dev/null; then
        warn "failed to emit native for $slug"
        rm -f "$asm_dest"
        return 0
    fi

    # Extract .layout lines for the manifest
    grep '^\.\(layout\)' "$asm_dest" > "$manifest_dest" 2>/dev/null || true
}

# Stage import context (sequential for safety with older seeds)
T_IMPORT_START="$(date +%s)"
for src in "${SOURCES[@]}"; do
    check_budget
    stage_import_context "$src"
done
T_IMPORT_END="$(date +%s)"

log "staged import-context for ${#SOURCES[@]} modules"

# ---------------------------------------------------------------------------
# Step 3: Per-module emit + compile
# ---------------------------------------------------------------------------
log "building ${#SOURCES[@]} modules (jobs=$JOBS)..."

MODULE_NAMES=()
FAILED=0
T_EMIT_START="$(date +%s)"

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
        # Parallel workers append to MODULES_LIST concurrently. Even if each
        # append is atomic (single-line printf, well under PIPE_BUF), the
        # *order* of lines is nondeterministic — and downstream llvm-link
        # input order affects the final linked bitcode. Sort here so every
        # run with the same source tree produces the same link order.
        LC_ALL=C sort -o "$MODULES_LIST" "$MODULES_LIST"
        while IFS= read -r name; do
            MODULE_NAMES+=("$name")
        done < "$MODULES_LIST"
    fi
fi

T_EMIT_END="$(date +%s)"
[[ "$FAILED" -eq 0 ]] || die "module build failed (see errors above)"
log "compiled ${#MODULE_NAMES[@]} modules"

# Write module list for reproducibility
printf '%s\n' "${MODULE_NAMES[@]}" > "$RAW_DIR/modules.txt"

# ---------------------------------------------------------------------------
# Step 4: Compile all modules with clang
# ---------------------------------------------------------------------------
log "compiling ${#MODULE_NAMES[@]} modules with clang..."
T_CLANG_START="$(date +%s)"
FAILED=0
for name in "${MODULE_NAMES[@]}"; do
    if ! compile_module "$name"; then
        FAILED=1
        break
    fi
done
T_CLANG_END="$(date +%s)"
[[ "$FAILED" -eq 0 ]] || die "clang compilation failed (see errors above)"

# ---------------------------------------------------------------------------
# Step 5: llvm-link all modules (except prelude)
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
# Step 6: Compile C runtime
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
# Step 7: Link final binary
# ---------------------------------------------------------------------------
T_LINK_START="$(date +%s)"
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
T_LINK_END="$(date +%s)"

if [[ ! -x "$OUT" ]]; then
    die "link succeeded but output is not executable: $OUT"
fi

ELAPSED=$(( $(date +%s) - START_TIME ))
log "built $OUT in ${ELAPSED}s"

# Quick sanity check
VERSION_STR=""
if "$OUT" --version &>/dev/null; then
    VERSION_STR="$("$OUT" --version 2>&1 | head -1)"
    log "$VERSION_STR"
else
    warn "binary built but --version check failed"
fi

# ---------------------------------------------------------------------------
# Build metrics
# ---------------------------------------------------------------------------
BINARY_SIZE="$(du -h "$OUT" | cut -f1)"
IMPORT_SECS=$(( T_IMPORT_END - T_IMPORT_START ))
EMIT_SECS=$(( T_EMIT_END - T_EMIT_START ))
CLANG_SECS=$(( T_CLANG_END - T_CLANG_START ))
LINK_SECS=$(( T_LINK_END - T_LINK_START ))

echo ""
echo "───────────────────────────────────────"
echo "  Build Metrics"
echo "───────────────────────────────────────"
printf "  %-24s %s\n" "modules"      "${#MODULE_NAMES[@]}"
printf "  %-24s %s\n" "binary size"  "$BINARY_SIZE"
[[ -n "$VERSION_STR" ]] && \
printf "  %-24s %s\n" "version"      "$VERSION_STR"
echo ""
printf "  %-24s %4ds\n" "import-context (native)" "$IMPORT_SECS"
printf "  %-24s %4ds\n" "seed emit (llvm)"        "$EMIT_SECS"
printf "  %-24s %4ds\n" "clang compile"           "$CLANG_SECS"
printf "  %-24s %4ds\n" "link + verify"           "$LINK_SECS"
echo "  ─────────────────────────────────────"
printf "  %-24s %4ds\n" "total wall time"         "$ELAPSED"
echo "───────────────────────────────────────"
