#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>

#include "sailfin_runtime.h"

// Entry point exported by the stage2 compiler IR.
extern char *compile_to_sailfin(char *source);
extern char *compile_to_llvm(char *source);
extern double stage2_cli_main(SailfinPtrArray *argv);

static void _print_usage(FILE *stream)
{
    fprintf(stream, "usage: sailfin-stage2 [--emit sailfin|llvm] <file.sfn>\n");
}

static char *_read_file(const char *path)
{
    FILE *f = fopen(path, "rb");
    if (!f)
    {
        return NULL;
    }
    if (fseek(f, 0, SEEK_END) != 0)
    {
        fclose(f);
        return NULL;
    }
    long n = ftell(f);
    if (n < 0)
    {
        fclose(f);
        return NULL;
    }
    if (fseek(f, 0, SEEK_SET) != 0)
    {
        fclose(f);
        return NULL;
    }

    char *buf = (char *)malloc((size_t)n + 1);
    if (!buf)
    {
        fclose(f);
        return NULL;
    }
    size_t read_n = fread(buf, 1, (size_t)n, f);
    fclose(f);
    buf[read_n] = '\0';
    return buf;
}

static bool _dir_exists(const char *path)
{
    struct stat st;
    if (!path)
    {
        return false;
    }
    return stat(path, &st) == 0 && S_ISDIR(st.st_mode);
}

static char *_dirname_dup(const char *path)
{
    if (!path)
    {
        return NULL;
    }
    const char *slash = strrchr(path, '/');
    if (!slash)
    {
        return strdup(".");
    }
    if (slash == path)
    {
        return strdup("/");
    }
    size_t len = (size_t)(slash - path);
    char *out = (char *)malloc(len + 1);
    if (!out)
    {
        return NULL;
    }
    memcpy(out, path, len);
    out[len] = '\0';
    return out;
}

static char *_join_path(const char *base, const char *suffix)
{
    if (!base || !suffix)
    {
        return NULL;
    }
    size_t base_len = strlen(base);
    size_t suffix_len = strlen(suffix);
    bool needs_slash = base_len > 0 && base[base_len - 1] != '/';
    size_t total = base_len + (needs_slash ? 1 : 0) + suffix_len;
    char *out = (char *)malloc(total + 1);
    if (!out)
    {
        return NULL;
    }
    memcpy(out, base, base_len);
    size_t offset = base_len;
    if (needs_slash)
    {
        out[offset++] = '/';
    }
    memcpy(out + offset, suffix, suffix_len);
    out[total] = '\0';
    return out;
}

static char *_resolve_runtime_root(const char *argv0)
{
    const char *override = getenv("SAILFIN_RUNTIME_ROOT");
    if (override && override[0] != '\0')
    {
        return strdup(override);
    }

    const char *exe_path = argv0;
    char resolved[PATH_MAX];
    if (argv0 && realpath(argv0, resolved))
    {
        exe_path = resolved;
    }

    char *exe_dir = _dirname_dup(exe_path);
    if (!exe_dir)
    {
        return NULL;
    }

    char *candidate = _join_path(exe_dir, "runtime");
    if (candidate && _dir_exists(candidate))
    {
        free(exe_dir);
        return candidate;
    }
    if (candidate)
    {
        free(candidate);
    }

    candidate = _join_path(exe_dir, "../runtime");
    if (candidate && _dir_exists(candidate))
    {
        free(exe_dir);
        return candidate;
    }
    if (candidate)
    {
        free(candidate);
    }

    candidate = _join_path(exe_dir, "../../runtime");
    if (candidate && _dir_exists(candidate))
    {
        free(exe_dir);
        return candidate;
    }
    if (candidate)
    {
        free(candidate);
    }

    free(exe_dir);
    return NULL;
}

int main(int argc, char **argv)
{
    // If invoked with an explicit subcommand/flag, delegate to the Sailfin-native CLI.
    // Otherwise, preserve the legacy interface: `sailfin-stage2 [--emit MODE] file.sfn`.
    if (argc >= 2)
    {
        const char *first = argv[1];
        bool is_cli = false;

        if (strcmp(first, "emit") == 0 || strcmp(first, "emit-llvm-file") == 0 || strcmp(first, "build") == 0 || strcmp(first, "run") == 0 || strcmp(first, "test") == 0 || strcmp(first, "version") == 0)
        {
            is_cli = true;
        }
        else if (strcmp(first, "-h") == 0 || strcmp(first, "--help") == 0)
        {
            is_cli = true;
        }
        else if (strcmp(first, "--version") == 0 || strcmp(first, "-V") == 0)
        {
            is_cli = true;
        }
        else if (strcmp(first, "--emit") == 0)
        {
            // Support `sailfin-stage2 --emit llvm file.sfn` through the Sailfin CLI layer as well.
            is_cli = true;
        }

        if (is_cli)
        {
            char *runtime_root = _resolve_runtime_root(argv[0]);
            SailfinPtrArray args;
            int64_t extra = runtime_root ? 2 : 0;
            char **argv_copy = (char **)malloc(
                sizeof(char *) * (size_t)(argc - 1 + extra));
            if (!argv_copy)
            {
                fprintf(stderr, "out of memory building stage2 argv\n");
                free(runtime_root);
                return 1;
            }

            int64_t out_index = 0;
            if (runtime_root)
            {
                argv_copy[out_index++] = "--runtime-root";
                argv_copy[out_index++] = runtime_root;
            }
            for (int i = 1; i < argc; i++)
            {
                argv_copy[out_index++] = argv[i];
            }

            args.data = argv_copy;
            args.len = out_index;
            double rc = stage2_cli_main(&args);
            free(argv_copy);
            free(runtime_root);
            return (int)rc;
        }
    }

    const char *emit = "sailfin";
    const char *path = NULL;

    if (argc == 2)
    {
        if (strcmp(argv[1], "-h") == 0 || strcmp(argv[1], "--help") == 0)
        {
            _print_usage(stdout);
            return 0;
        }
        path = argv[1];
    }
    else if (argc == 4 && strcmp(argv[1], "--emit") == 0)
    {
        emit = argv[2];
        path = argv[3];
    }
    else
    {
        _print_usage(stderr);
        return 2;
    }

    if (strcmp(emit, "sailfin") != 0 && strcmp(emit, "llvm") != 0)
    {
        fprintf(stderr, "unknown --emit mode: %s\n", emit);
        _print_usage(stderr);
        return 2;
    }

    char *source = _read_file(path);
    if (!source)
    {
        fprintf(stderr, "failed to read: %s\n", path);
        return 3;
    }

    char *out = NULL;
    if (strcmp(emit, "llvm") == 0)
    {
        out = compile_to_llvm(source);
    }
    else
    {
        out = compile_to_sailfin(source);
    }
    if (!out)
    {
        fprintf(stderr, "compiler returned NULL\n");
        free(source);
        return 4;
    }

    fputs(out, stdout);
    if (out[0] && out[strlen(out) - 1] != '\n')
    {
        fputc('\n', stdout);
    }

    free(source);
    return 0;
}
