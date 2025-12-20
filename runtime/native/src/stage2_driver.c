#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Entry point exported by the stage2 compiler IR.
extern char *compile_to_sailfin(char *source);
extern char *compile_to_llvm(char *source);

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

int main(int argc, char **argv)
{
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
