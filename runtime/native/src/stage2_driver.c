#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Entry point exported by the stage2 compiler IR.
extern char *compile_to_sailfin(char *source);

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
    if (argc != 2)
    {
        fprintf(stderr, "usage: sailfin-stage2 <file.sfn>\n");
        return 2;
    }

    char *source = _read_file(argv[1]);
    if (!source)
    {
        fprintf(stderr, "failed to read: %s\n", argv[1]);
        return 3;
    }

    char *out = compile_to_sailfin(source);
    if (!out)
    {
        fprintf(stderr, "compile_to_sailfin returned NULL\n");
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
