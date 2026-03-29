/*
 * sailfin_base64.c — Base64 encode/decode for Sailfin runtime.
 * No external dependencies.
 */

#include "sailfin_base64.h"
#include <stdlib.h>
#include <string.h>

/* ---------- encoding ---------- */

static const char _b64_table[] =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

char *sailfin_runtime_base64_encode(const char *data, int64_t length)
{
    if (!data || length < 0)
        return NULL;

    size_t len = (size_t)length;
    size_t out_len = 4 * ((len + 2) / 3);
    char *out = (char *)malloc(out_len + 1);
    if (!out)
        return NULL;

    size_t i, j;
    for (i = 0, j = 0; i + 2 < len; i += 3, j += 4) {
        uint32_t v = ((uint32_t)(uint8_t)data[i] << 16)
                   | ((uint32_t)(uint8_t)data[i + 1] << 8)
                   | ((uint32_t)(uint8_t)data[i + 2]);
        out[j]     = _b64_table[(v >> 18) & 0x3F];
        out[j + 1] = _b64_table[(v >> 12) & 0x3F];
        out[j + 2] = _b64_table[(v >>  6) & 0x3F];
        out[j + 3] = _b64_table[v & 0x3F];
    }

    if (i < len) {
        uint32_t v = (uint32_t)(uint8_t)data[i] << 16;
        if (i + 1 < len)
            v |= (uint32_t)(uint8_t)data[i + 1] << 8;

        out[j]     = _b64_table[(v >> 18) & 0x3F];
        out[j + 1] = _b64_table[(v >> 12) & 0x3F];
        out[j + 2] = (i + 1 < len) ? _b64_table[(v >> 6) & 0x3F] : '=';
        out[j + 3] = '=';
        j += 4;
    }

    out[j] = '\0';
    return out;
}

/* ---------- decoding ---------- */

static const int8_t _b64_decode_table[256] = {
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,62,-1,-1,-1,63,
    52,53,54,55,56,57,58,59,60,61,-1,-1,-1,-1,-1,-1,
    -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,
    15,16,17,18,19,20,21,22,23,24,25,-1,-1,-1,-1,-1,
    -1,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,
    41,42,43,44,45,46,47,48,49,50,51,-1,-1,-1,-1,-1,
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
};

char *sailfin_runtime_base64_decode(const char *b64, int64_t *out_length)
{
    if (!b64 || !out_length)
        return NULL;

    size_t in_len = strlen(b64);
    /* Skip trailing whitespace/newlines */
    while (in_len > 0 && (b64[in_len - 1] == '\n' || b64[in_len - 1] == '\r'
                       || b64[in_len - 1] == ' '))
        in_len--;

    if (in_len == 0) {
        *out_length = 0;
        char *empty = (char *)malloc(1);
        if (empty) empty[0] = '\0';
        return empty;
    }

    size_t out_cap = (in_len / 4) * 3;
    char *out = (char *)malloc(out_cap + 1);
    if (!out)
        return NULL;

    size_t i, j;
    for (i = 0, j = 0; i + 3 < in_len; i += 4) {
        int8_t a = _b64_decode_table[(uint8_t)b64[i]];
        int8_t b = _b64_decode_table[(uint8_t)b64[i + 1]];
        int8_t c = (b64[i + 2] == '=') ? 0 : _b64_decode_table[(uint8_t)b64[i + 2]];
        int8_t d = (b64[i + 3] == '=') ? 0 : _b64_decode_table[(uint8_t)b64[i + 3]];

        if (a < 0 || b < 0 || (b64[i + 2] != '=' && c < 0) || (b64[i + 3] != '=' && d < 0)) {
            free(out);
            *out_length = 0;
            return NULL;
        }

        uint32_t v = ((uint32_t)a << 18) | ((uint32_t)b << 12)
                   | ((uint32_t)c << 6)  | (uint32_t)d;

        out[j++] = (char)((v >> 16) & 0xFF);
        if (b64[i + 2] != '=')
            out[j++] = (char)((v >> 8) & 0xFF);
        if (b64[i + 3] != '=')
            out[j++] = (char)(v & 0xFF);
    }

    out[j] = '\0';
    *out_length = (int64_t)j;
    return out;
}
